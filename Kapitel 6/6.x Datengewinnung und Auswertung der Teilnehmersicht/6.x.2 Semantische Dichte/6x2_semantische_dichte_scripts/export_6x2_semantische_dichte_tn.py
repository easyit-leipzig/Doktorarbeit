#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.2 Semantische Dichte – Teilnehmersicht – Python-Export

Liest die 7D-Teilnehmerzustände aus der FRZK-Datenbank und erzeugt eine
JSON-Datei, die von Python- und PHP-Analyse-Skripten identisch gelesen wird.

Ziel-JSON:
    6x2_semantische_dichte_tn.json

Standard-DB:
    host=127.0.0.1, port=3306, user=root, password='', database=icas_19_4_2
"""

from __future__ import annotations

import argparse
import json
import math
import os
from collections import defaultdict
from datetime import date, datetime
from decimal import Decimal
from statistics import mean, pstdev
from typing import Any, Dict, Iterable, List, Optional

try:
    import mysql.connector  # type: ignore
except ImportError as exc:
    raise SystemExit(
        "mysql-connector-python fehlt. Installation z. B.: python -m pip install mysql-connector-python"
    ) from exc

DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]

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


def json_default(obj: Any) -> Any:
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    if isinstance(obj, Decimal):
        return float(obj)
    return str(obj)


def fnum(value: Any) -> Optional[float]:
    if value is None or value == "":
        return None
    try:
        val = float(value)
    except (TypeError, ValueError):
        return None
    if math.isnan(val) or math.isinf(val):
        return None
    return val


def density_class(value: Optional[float], q33: float, q66: float) -> str:
    if value is None:
        return "ohne Dichtewert"
    if value < q33:
        return "Leerstelle / geringe Dichte"
    if value < q66:
        return "mittlere Dichte"
    return "Verdichtung / hohe Dichte"


def quantile(values: List[float], q: float) -> float:
    if not values:
        return 0.0
    xs = sorted(values)
    pos = (len(xs) - 1) * q
    lo = int(math.floor(pos))
    hi = int(math.ceil(pos))
    if lo == hi:
        return xs[lo]
    return xs[lo] + (xs[hi] - xs[lo]) * (pos - lo)


def table_exists(cursor: Any, table_name: str) -> bool:
    cursor.execute("SHOW TABLES LIKE %s", (table_name,))
    return cursor.fetchone() is not None


def fetch_rows(cursor: Any, exclude_group_zero: bool = True) -> List[Dict[str, Any]]:
    where = "WHERE gruppe_id IS NOT NULL"
    if exclude_group_zero:
        where += " AND gruppe_id <> 0"

    sql = f"""
        SELECT
            id,
            rueckkopplung_teilnehmer_id,
            ue_id,
            ue_zuweisung_teilnehmer_id,
            teilnehmer_id,
            gruppe_id,
            zeitpunkt,
            x_kognition,
            x_sozial,
            x_affektiv,
            x_motivation,
            x_methodik,
            x_performanz,
            x_regulation,
            sum_kognition,
            sum_sozial,
            sum_affektiv,
            sum_motivation,
            sum_methodik,
            sum_performanz,
            sum_regulation,
            emotion_ids,
            emotion_valenz,
            emotion_aktivierung,
            emotion_anzahl,
            dominante_dimension,
            dominante_dimension_wert,
            polaritaet_gesamt,
            d_semantisch,
            drift_norm,
            d_semantisch_delta,
            dominanzwechsel,
            stabilitaet,
            transition_marker
        FROM frzk_semantische_dichte_teilnehmer_7d
        {where}
        ORDER BY gruppe_id ASC, zeitpunkt ASC, teilnehmer_id ASC, id ASC
    """
    cursor.execute(sql)
    rows = cursor.fetchall()
    return list(rows)


def normalize_rows(rows: Iterable[Dict[str, Any]], q33: float, q66: float) -> List[Dict[str, Any]]:
    out: List[Dict[str, Any]] = []
    for r in rows:
        vec = {dim: fnum(r.get(f"x_{dim}")) for dim in DIMENSIONS}
        d_raw = fnum(r.get("d_semantisch"))
        d_calc = math.sqrt(sum((vec[d] or 0.0) ** 2 for d in DIMENSIONS))
        d_final = d_raw if d_raw is not None else d_calc

        rec = dict(r)
        rec["vector_7d"] = vec
        rec["h_T"] = d_final
        rec["h_T_berechnet"] = d_calc
        rec["dichteklasse"] = density_class(d_final, q33, q66)
        rec["zeitpunkt_iso"] = json_default(r.get("zeitpunkt")) if r.get("zeitpunkt") else None
        out.append(rec)
    return out


def aggregate_group_time(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    groups: Dict[tuple, List[Dict[str, Any]]] = defaultdict(list)
    for r in rows:
        z = str(r.get("zeitpunkt_iso") or r.get("zeitpunkt") or "")[:10]
        groups[(int(r["gruppe_id"]), z)].append(r)

    out: List[Dict[str, Any]] = []
    for (gid, z), items in sorted(groups.items(), key=lambda x: (x[0][0], x[0][1])):
        d_vals = [fnum(i.get("h_T")) for i in items]
        d_vals = [v for v in d_vals if v is not None]
        dim_means: Dict[str, Optional[float]] = {}
        dim_std: Dict[str, Optional[float]] = {}
        for dim in DIMENSIONS:
            vals = [fnum(i.get("vector_7d", {}).get(dim)) for i in items]
            vals = [v for v in vals if v is not None]
            dim_means[dim] = mean(vals) if vals else None
            dim_std[dim] = pstdev(vals) if len(vals) > 1 else 0.0 if vals else None
        out.append(
            {
                "gruppe_id": gid,
                "datum": z,
                "n": len(items),
                "teilnehmer_ids": sorted({int(i["teilnehmer_id"]) for i in items if i.get("teilnehmer_id") is not None}),
                "h_T_mean": mean(d_vals) if d_vals else None,
                "h_T_std": pstdev(d_vals) if len(d_vals) > 1 else 0.0 if d_vals else None,
                "h_T_min": min(d_vals) if d_vals else None,
                "h_T_max": max(d_vals) if d_vals else None,
                "dimensions_mean": dim_means,
                "dimensions_std": dim_std,
                "dominante_dimension_gruppe": max(
                    DIMENSIONS,
                    key=lambda d: abs(dim_means[d] or 0.0),
                ),
            }
        )
    return out


def aggregate_group_total(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    groups: Dict[int, List[Dict[str, Any]]] = defaultdict(list)
    for r in rows:
        groups[int(r["gruppe_id"])].append(r)

    out: List[Dict[str, Any]] = []
    for gid, items in sorted(groups.items()):
        d_vals = [fnum(i.get("h_T")) for i in items]
        d_vals = [v for v in d_vals if v is not None]
        dim_means: Dict[str, Optional[float]] = {}
        for dim in DIMENSIONS:
            vals = [fnum(i.get("vector_7d", {}).get(dim)) for i in items]
            vals = [v for v in vals if v is not None]
            dim_means[dim] = mean(vals) if vals else None
        out.append(
            {
                "gruppe_id": gid,
                "n": len(items),
                "n_teilnehmer": len({i.get("teilnehmer_id") for i in items}),
                "h_T_mean": mean(d_vals) if d_vals else None,
                "h_T_std": pstdev(d_vals) if len(d_vals) > 1 else 0.0 if d_vals else None,
                "h_T_min": min(d_vals) if d_vals else None,
                "h_T_max": max(d_vals) if d_vals else None,
                "dimensions_mean": dim_means,
                "dominante_dimension_gruppe": max(DIMENSIONS, key=lambda d: abs(dim_means[d] or 0.0)),
            }
        )
    return out


def fetch_existing_group_table(cursor: Any) -> List[Dict[str, Any]]:
    if not table_exists(cursor, "frzk_group_semantische_dichte_7d"):
        return []
    cursor.execute("SELECT * FROM frzk_group_semantische_dichte_7d ORDER BY gruppe_id ASC")
    return list(cursor.fetchall())


def main() -> None:
    parser = argparse.ArgumentParser(description="Export 6.x.2 Semantische Dichte Teilnehmersicht")
    parser.add_argument("--out", default="6x2_semantische_dichte_tn.json", help="Ziel-JSON")
    parser.add_argument("--include-group-zero", action="store_true", help="Gruppe 0 nicht ausschließen")
    args = parser.parse_args()

    conn = mysql.connector.connect(**DB_CONFIG)
    try:
        cursor = conn.cursor(dictionary=True)
        raw = fetch_rows(cursor, exclude_group_zero=not args.include_group_zero)
        h_values = [fnum(r.get("d_semantisch")) for r in raw]
        h_values = [v for v in h_values if v is not None]
        q33 = quantile(h_values, 0.33)
        q66 = quantile(h_values, 0.66)
        rows = normalize_rows(raw, q33, q66)

        payload = {
            "metadata": {
                "kapitel": "6.x.2",
                "titel": "Semantische Dichte – Teilnehmersicht im 7D-FRZK-Raum",
                "generated_at": datetime.now().isoformat(timespec="seconds"),
                "source_table": "frzk_semantische_dichte_teilnehmer_7d",
                "group_table_optional": "frzk_group_semantische_dichte_7d",
                "exclude_group_zero": not args.include_group_zero,
                "dimensions": DIMENSIONS,
                "definition": "h(T)=||T||_2 bzw. d_semantisch, sofern in der Datenbank vorhanden",
                "density_quantiles": {"q33": q33, "q66": q66},
                "record_count": len(rows),
            },
            "teilnehmer_zustaende": rows,
            "gruppen_zeit_aggregation": aggregate_group_time(rows),
            "gruppen_aggregation": aggregate_group_total(rows),
            "frzk_group_semantische_dichte_7d_existing": fetch_existing_group_table(cursor),
        }

        out_path = os.path.abspath(args.out)
        with open(out_path, "w", encoding="utf-8") as f:
            json.dump(payload, f, ensure_ascii=False, indent=2, default=json_default)
        print(f"OK: {len(rows)} Datensätze exportiert: {out_path}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()
