#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.24 Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität
Exportskript Python

Erzeugt eine JSON-Datei mit:
- Profil Lehrkraft 1
- Profil andere Lehrkraft (lehrkraft_id <> 1)
- Gruppenzeitreihe aus frzk_group_emotion
- je Zeitpunkt Distanz Gruppe -> Profil LK1 und Gruppe -> Profil andere LK
- kontrafaktischem Distanzdelta

Standard-DB-Konfiguration gemäß Projektstand.
"""

from __future__ import annotations

import json
import math
from datetime import date, datetime
from decimal import Decimal
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import mysql.connector

DB_CONFIG = {
    "host": "127.0.0.1",
    "port": 3306,
    "user": "root",
    "password": "",
    "database": "icas_19_4_2",
    "charset": "utf8mb4",
    "connection_timeout": 5,
    "use_pure": True,
}

OUTPUT_FILE = Path("6x24_lehrkraftprofil_gruppendynamik.json")

DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]

PROFILE_FIELDS = [f"mean_{d}" for d in DIMENSIONS]
VAR_FIELDS = [f"var_{d}" for d in DIMENSIONS]


def to_json_value(value: Any) -> Any:
    """Konvertiert DB-Spezialtypen in JSON-kompatible Werte."""
    if isinstance(value, Decimal):
        return float(value)
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    return value


def json_default(value: Any) -> Any:
    """Fallback für json.dumps, falls verschachtelt doch noch Sondertypen auftauchen."""
    return to_json_value(value)


def as_float(value: Any, default: float = 0.0) -> float:
    try:
        if value is None:
            return default
        return float(value)
    except (TypeError, ValueError):
        return default


def fetch_all(cur, sql: str, params: Tuple[Any, ...] = ()) -> List[Dict[str, Any]]:
    cur.execute(sql, params)
    rows = cur.fetchall()
    return [{k: to_json_value(v) for k, v in row.items()} for row in rows]


def euclidean(a: List[float], b: List[float]) -> float:
    return math.sqrt(sum((x - y) ** 2 for x, y in zip(a, b)))


def cosine(a: List[float], b: List[float]) -> Optional[float]:
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(x * x for x in b))
    if na == 0 or nb == 0:
        return None
    return sum(x * y for x, y in zip(a, b)) / (na * nb)


def profile_vector(profile: Dict[str, Any]) -> List[float]:
    return [as_float(profile.get(f"mean_{d}")) for d in DIMENSIONS]


def group_vector(row: Dict[str, Any]) -> List[float]:
    """
    frzk_group_emotion enthält keine vollständige 7D-Struktur. Für die kontrafaktische
    Projektion wird daraus ein kompatibler 7D-Näherungsvektor gebildet:
    - affektiv: z_affektiv
    - sozial: kohärenz
    - regulation: stabilitaet
    - motivation: dynamik invers gerichtet gedämpft über Stabilität
    - performanz/methodik/kognition: aus Kohärenz/Stabilität als Gruppensystem-Indikator

    Falls später eine echte frzk_group_semantische_dichte-View mit 7D-Feldern genutzt wird,
    kann diese Funktion direkt ersetzt werden.
    """
    z_aff = as_float(row.get("z_affektiv"))
    koh = as_float(row.get("kohaerenz"))
    stab = as_float(row.get("stabilitaet"))
    dyn = as_float(row.get("dynamik"))

    dyn_safe = max(0.0, dyn)
    motivation = max(0.0, (koh + stab) / 2.0 - dyn_safe / 2.0)
    kognition = (koh + stab) / 2.0
    methodik = koh
    performanz = stab
    sozial = koh
    regulation = stab
    affektiv = z_aff

    return [
        kognition,
        sozial,
        affektiv,
        motivation,
        methodik,
        performanz,
        regulation,
    ]


def get_profile(cur, label: str, where_sql: str) -> Dict[str, Any]:
    select_parts = ["COUNT(*) AS n"]
    for d in DIMENSIONS:
        select_parts.append(f"AVG(mean_{d}) AS mean_{d}")
        select_parts.append(f"AVG(var_{d}) AS avg_var_{d}")
        select_parts.append(f"AVG(range_{d}) AS avg_range_{d}")
    select_parts += [
        "AVG(semantische_breite) AS semantische_breite_mean",
        "AVG(d_semantisch_mean) AS d_semantisch_mean",
        "AVG(d_semantisch_std) AS d_semantisch_std_mean",
        "AVG(polaritaet_index) AS polaritaet_index_mean",
        "AVG(dominanz_breite) AS dominanz_breite_mean",
    ]
    sql = f"SELECT {', '.join(select_parts)} FROM analyze_lehrkraftdaten WHERE {where_sql}"
    rows = fetch_all(cur, sql)
    profile = rows[0] if rows else {}
    profile["label"] = label
    profile["vector"] = profile_vector(profile)
    return profile


def get_profile_by_group(cur, where_sql: str) -> Dict[str, Dict[str, Any]]:
    select_parts = ["gruppe_id", "COUNT(*) AS n"]
    for d in DIMENSIONS:
        select_parts.append(f"AVG(mean_{d}) AS mean_{d}")
    sql = f"SELECT {', '.join(select_parts)} FROM analyze_lehrkraftdaten WHERE {where_sql} GROUP BY gruppe_id"
    rows = fetch_all(cur, sql)
    out = {}
    for row in rows:
        gid = str(row.get("gruppe_id"))
        row["vector"] = profile_vector(row)
        out[gid] = row
    return out


def get_dominance_distribution(cur, where_sql: str) -> List[Dict[str, Any]]:
    sql = f"""
        SELECT dominante_dimension, COUNT(*) AS n
        FROM sql_semantische_dichte_lehrer_type_1
        WHERE {where_sql}
        GROUP BY dominante_dimension
        ORDER BY n DESC
    """
    try:
        return fetch_all(cur, sql)
    except mysql.connector.Error:
        return []


def get_group_rows(cur) -> List[Dict[str, Any]]:
    sql = """
        SELECT gruppe_id, zeitpunkt, z_affektiv, kohärenz AS kohaerenz,
               stabilitaet, dynamik, emotionaler_status, emotionaler_modus, bemerkung
        FROM frzk_group_emotion
        ORDER BY gruppe_id, zeitpunkt
    """
    return fetch_all(cur, sql)


def classify_risk(delta_distance: float, dist_other: float, dyn: float, stab: float) -> str:
    """
    Positive delta_distance bedeutet: andere Lehrkraft liegt weiter weg als LK1.
    Risiko steigt, wenn Gruppe stark an LK1-Profil gebunden ist und zugleich Dynamik hoch/Stabilität niedrig ist.
    """
    instability = max(0.0, dyn) + max(0.0, 1.0 - stab)
    score = delta_distance + 0.5 * instability + 0.25 * dist_other
    if score >= 1.25:
        return "hoch"
    if score >= 0.75:
        return "mittel"
    return "niedrig"


def main() -> None:
    conn = mysql.connector.connect(**DB_CONFIG)
    try:
        cur = conn.cursor(dictionary=True)

        lk1_profile = get_profile(cur, "lehrkraft_1", "lehrkraft_id = 1")
        other_profile = get_profile(cur, "andere_lehrkraft", "lehrkraft_id <> 1")
        lk1_by_group = get_profile_by_group(cur, "lehrkraft_id = 1")
        other_by_group = get_profile_by_group(cur, "lehrkraft_id <> 1")

        profiles = {
            "lehrkraft_1": lk1_profile,
            "andere_lehrkraft": other_profile,
            "lehrkraft_1_by_group": lk1_by_group,
            "andere_lehrkraft_by_group": other_by_group,
            "dominanz_lehrkraft_1": get_dominance_distribution(cur, "lehrkraft_id = 1"),
            "dominanz_andere_lehrkraft": get_dominance_distribution(cur, "lehrkraft_id <> 1"),
        }

        group_rows = get_group_rows(cur)
        lk1_vec_global = lk1_profile["vector"]
        other_vec_global = other_profile["vector"]

        projected_rows: List[Dict[str, Any]] = []
        for row in group_rows:
            gid = str(row.get("gruppe_id"))
            gv = group_vector(row)
            lk1_vec = lk1_by_group.get(gid, {}).get("vector", lk1_vec_global)
            other_vec = other_by_group.get(gid, {}).get("vector", other_vec_global)

            d_lk1 = euclidean(gv, lk1_vec)
            d_other = euclidean(gv, other_vec)
            delta = d_other - d_lk1
            cos_lk1 = cosine(gv, lk1_vec)
            cos_other = cosine(gv, other_vec)

            row_out = dict(row)
            row_out.update({
                "group_vector_7d_proxy": dict(zip(DIMENSIONS, gv)),
                "distance_to_lk1_profile": d_lk1,
                "distance_to_other_profile": d_other,
                "delta_distance_other_minus_lk1": delta,
                "cosine_to_lk1_profile": cos_lk1,
                "cosine_to_other_profile": cos_other,
                "risk_level": classify_risk(delta, d_other, as_float(row.get("dynamik")), as_float(row.get("stabilitaet"))),
                "interpretation": "positives Delta = Gruppe liegt näher an LK1 als am Profil andere Lehrkraft",
            })
            projected_rows.append(row_out)

        summary_by_group: Dict[str, Dict[str, Any]] = {}
        for row in projected_rows:
            gid = str(row["gruppe_id"])
            bucket = summary_by_group.setdefault(gid, {
                "gruppe_id": row["gruppe_id"],
                "n": 0,
                "mean_distance_lk1": 0.0,
                "mean_distance_other": 0.0,
                "mean_delta_distance": 0.0,
                "mean_dynamik": 0.0,
                "mean_stabilitaet": 0.0,
                "risk_counts": {},
            })
            bucket["n"] += 1
            bucket["mean_distance_lk1"] += row["distance_to_lk1_profile"]
            bucket["mean_distance_other"] += row["distance_to_other_profile"]
            bucket["mean_delta_distance"] += row["delta_distance_other_minus_lk1"]
            bucket["mean_dynamik"] += as_float(row.get("dynamik"))
            bucket["mean_stabilitaet"] += as_float(row.get("stabilitaet"))
            rc = bucket["risk_counts"]
            rc[row["risk_level"]] = rc.get(row["risk_level"], 0) + 1

        for bucket in summary_by_group.values():
            n = max(1, bucket["n"])
            for key in ["mean_distance_lk1", "mean_distance_other", "mean_delta_distance", "mean_dynamik", "mean_stabilitaet"]:
                bucket[key] = bucket[key] / n
            if bucket["mean_delta_distance"] > 0.15:
                bucket["profile_binding"] = "stärker an Lehrkraft 1 gebunden"
            elif bucket["mean_delta_distance"] < -0.15:
                bucket["profile_binding"] = "näher am Profil andere Lehrkraft"
            else:
                bucket["profile_binding"] = "profilrobust / geringe Distanzdifferenz"

        payload = {
            "meta": {
                "auswertungspunkt": "6.x.24",
                "titel": "Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität",
                "created_at": datetime.now().isoformat(timespec="seconds"),
                "database": DB_CONFIG["database"],
                "dimensions": DIMENSIONS,
                "method_note": "Gruppendynamik liegt nur für LK1 real vor; Profil andere Lehrkraft wird kontrafaktisch als Distanz- und Resonanzprofil projiziert.",
                "group_vector_note": "frzk_group_emotion wird als 7D-Proxy auf den FRZK-Raum abgebildet; bei vorhandenen 7D-Gruppenvectors kann group_vector() ersetzt werden.",
            },
            "profiles": profiles,
            "group_projection_rows": projected_rows,
            "summary_by_group": list(summary_by_group.values()),
        }

        OUTPUT_FILE.write_text(json.dumps(payload, ensure_ascii=False, indent=2, default=json_default), encoding="utf-8")
        print(f"OK: Export geschrieben: {OUTPUT_FILE.resolve()}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()
