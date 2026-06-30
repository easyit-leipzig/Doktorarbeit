#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Export 6.x Kausalität des FRZK-Vektorraums als Beschreibungssystem

Erzeugt eine gemeinsame JSON-Datei mit drei Scopes:
  - alle
  - lehrkraft_1
  - ohne_lehrkraft_1

Die Datei enthält die Datengrundlage für:
  1. Artefakttest / Nullmodell / Permutationsanalyse
  2. Zeitversetzte Resonanzvalidierung L(t) -> T(t+n)
  3. Vorhersagevergleich FRZK-Vektoren vs. klassische Ratings
  4. Dominanz-, Polaritäts- und Resonanzkopplung

Standard-DB-Konfiguration gemäß ICAS/FRZK-Projektstand 28.05.2026.
"""

from __future__ import annotations

import argparse
import json
import math
import os
import sys
from datetime import date, datetime
from decimal import Decimal
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

try:
    import mysql.connector
except ImportError as exc:
    raise SystemExit(
        "Fehlendes Paket: mysql-connector-python. Installation: py -m pip install mysql-connector-python"
    ) from exc

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

DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]

RATING_FIELDS = [
    "mitarbeit",
    "absprachen",
    "selbststaendigkeit",
    "konzentration",
    "fleiss",
    "lernfortschritt",
    "beherrscht_thema",
    "transferdenken",
    "basiswissen",
    "vorbereitet",
    "themenauswahl",
    "materialien",
    "methodenvielfalt",
    "individualisierung",
    "aufforderung",
    "zielgruppen",
]


def json_default(obj: Any) -> Any:
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    if isinstance(obj, Decimal):
        return float(obj)
    return str(obj)


def get_connection(config: Dict[str, Any]):
    return mysql.connector.connect(**config)


def fetch_all(cur, sql: str, params: Optional[Iterable[Any]] = None) -> List[Dict[str, Any]]:
    cur.execute(sql, tuple(params or ()))
    return [dict(row) for row in cur.fetchall()]


def numeric_or_none(value: Any) -> Optional[float]:
    if value is None or value == "":
        return None
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def dominant_dimension_from_vector(prefix: str, row: Dict[str, Any]) -> Optional[str]:
    values = {}
    for d in DIMENSIONS:
        key = f"{prefix}_{d}"
        val = numeric_or_none(row.get(key))
        if val is not None:
            values[d] = abs(val)
    return max(values, key=values.get) if values else None


def norm(vector: List[float]) -> float:
    return math.sqrt(sum(v * v for v in vector))


def polarity(vector: List[float]) -> int:
    s = sum(vector)
    return 1 if s > 0 else (-1 if s < 0 else 0)


def add_derived_fields(row: Dict[str, Any]) -> Dict[str, Any]:
    lk_vector = [numeric_or_none(row.get(f"x_{d}")) or 0.0 for d in DIMENSIONS]
    lk_mean_vector = [numeric_or_none(row.get(f"mean_{d}")) or 0.0 for d in DIMENSIONS]

    # Teilnehmervektor ist im View nicht immer als 7D-FRZK-Vektor vorhanden. Für Ratings wird zusätzlich
    # eine klassisch-numerische Ratingsignatur exportiert. Die spätere Analyse baut daraus ein Gegenmodell.
    rating_vector = [numeric_or_none(row.get(f)) for f in RATING_FIELDS]
    rating_vector_clean = [v for v in rating_vector if v is not None]

    row["_derived"] = {
        "lk_vector": lk_vector,
        "lk_mean_vector": lk_mean_vector,
        "lk_norm": norm(lk_vector),
        "lk_mean_norm": norm(lk_mean_vector),
        "lk_polarity_from_vector": polarity(lk_vector),
        "lk_dominant_from_vector": dominant_dimension_from_vector("x", row),
        "rating_vector": rating_vector,
        "rating_mean": sum(rating_vector_clean) / len(rating_vector_clean) if rating_vector_clean else None,
        "rating_norm": norm(rating_vector_clean) if rating_vector_clean else None,
        "emotion_ids": [int(x) for x in str(row.get("emotions") or "").replace(";", ",").split(",") if x.strip().isdigit()],
    }
    return row


def build_scope_clause(scope: str) -> str:
    if scope == "lehrkraft_1":
        return "WHERE lehrkraft_id = 1"
    if scope == "ohne_lehrkraft_1":
        return "WHERE lehrkraft_id <> 1"
    return ""


def export_scope(cur, scope: str, limit: Optional[int] = None) -> Dict[str, Any]:
    where_clause = build_scope_clause(scope)
    limit_clause = " LIMIT %s" if limit else ""
    sql = f"""
        SELECT
            teilnehmer_feedback_id,
            teilnehmer_ue_id,
            teilnehmer_id,
            gruppe_id,
            erfasst_am,
            teilnehmer_datum,
            mitarbeit,
            absprachen,
            selbststaendigkeit,
            konzentration,
            fleiss,
            lernfortschritt,
            beherrscht_thema,
            transferdenken,
            basiswissen,
            vorbereitet,
            themenauswahl,
            materialien,
            methodenvielfalt,
            individualisierung,
            aufforderung,
            zielgruppen,
            emotions,
            bemerkungen,
            id_mtr_rueckkopplung_datenmaske,
            lehrkraft_id,
            datum,
            satzanzahl,
            mean_kognition,
            mean_sozial,
            mean_affektiv,
            mean_motivation,
            mean_methodik,
            mean_performanz,
            mean_regulation,
            var_kognition,
            var_sozial,
            var_affektiv,
            var_motivation,
            var_methodik,
            var_performanz,
            var_regulation,
            d_semantisch_mean,
            d_semantisch_std,
            semantische_breite,
            dominanz_breite,
            sdlg_id,
            sdlg_type,
            sdlg_ue_id,
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
            h_kognition,
            h_sozial,
            h_affektiv,
            h_motivation,
            h_methodik,
            h_performanz,
            h_regulation,
            token_anzahl,
            funktionsklassen_anzahl_gesamt,
            dominante_dimension,
            dominante_dimension_wert,
            polaritaet_gesamt,
            d_semantisch,
            sdlg_created_at
        FROM match_tn_daten_analyze_lehrkraft
        {where_clause}
        ORDER BY teilnehmer_id, teilnehmer_datum, sdlg_type, sdlg_id
        {limit_clause}
    """
    params: List[Any] = [limit] if limit else []
    rows = fetch_all(cur, sql, params)
    rows = [add_derived_fields(r) for r in rows]

    by_group: Dict[str, int] = {}
    by_teacher: Dict[str, int] = {}
    for r in rows:
        by_group[str(r.get("gruppe_id"))] = by_group.get(str(r.get("gruppe_id")), 0) + 1
        by_teacher[str(r.get("lehrkraft_id"))] = by_teacher.get(str(r.get("lehrkraft_id")), 0) + 1

    return {
        "scope": scope,
        "n_rows": len(rows),
        "by_group": by_group,
        "by_teacher": by_teacher,
        "rows": rows,
    }


def export_emotions(cur) -> List[Dict[str, Any]]:
    try:
        return fetch_all(cur, "SELECT id, type_name, fine_label, emotion, valenz, aktivierung FROM _mtr_emotionen ORDER BY id")
    except Exception:
        return []


def main() -> None:
    parser = argparse.ArgumentParser(description="Exportiert JSON-Daten für 6.x Kausalität FRZK-Vektorraum.")
    parser.add_argument("--out", default="6x_kausalitaet_vektorraum_export.json", help="Zieldatei JSON")
    parser.add_argument("--limit", type=int, default=None, help="Optionales Limit pro Scope für Tests")
    parser.add_argument("--host", default=DB_CONFIG["host"])
    parser.add_argument("--port", type=int, default=DB_CONFIG["port"])
    parser.add_argument("--user", default=DB_CONFIG["user"])
    parser.add_argument("--password", default=DB_CONFIG["password"])
    parser.add_argument("--database", default=DB_CONFIG["database"])
    args = parser.parse_args()

    config = dict(DB_CONFIG)
    config.update({"host": args.host, "port": args.port, "user": args.user, "password": args.password, "database": args.database})

    output_path = Path(args.out)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    conn = get_connection(config)
    try:
        cur = conn.cursor(dictionary=True)
        payload = {
            "metadata": {
                "title": "6.x Kausalität des FRZK-Vektorraums als Beschreibungssystem",
                "created_at": datetime.now().isoformat(timespec="seconds"),
                "database": args.database,
                "source_view": "match_tn_daten_analyze_lehrkraft",
                "method": "Export für Permutationstest, zeitversetzte Resonanz und Vorhersagevergleich",
                "dimensions": DIMENSIONS,
                "rating_fields": RATING_FIELDS,
                "scopes": ["alle", "lehrkraft_1", "ohne_lehrkraft_1"],
            },
            "emotions": export_emotions(cur),
            "scopes": {},
        }
        for scope in payload["metadata"]["scopes"]:
            payload["scopes"][scope] = export_scope(cur, scope, args.limit)
    finally:
        conn.close()

    with output_path.open("w", encoding="utf-8") as f:
        json.dump(payload, f, ensure_ascii=False, indent=2, default=json_default)

    print(f"Export abgeschlossen: {output_path.resolve()}")


if __name__ == "__main__":
    main()
