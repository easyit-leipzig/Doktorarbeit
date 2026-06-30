#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten
Exportskript Python

Erzeugt JSON mit den Scopes:
- alle_lehrkraefte
- lehrkraft_1
- ohne_lehrkraft_1

Datenbasis bevorzugt:
- analyze_lehrkraftdaten: aggregierte Lehrkraftsicht
- frzk_group_emotion: gruppendynamische Emotions-/Kohärenz-/Stabilitätsdaten
- frzk_semantische_dichte_teilnehmer_7d: Teilnehmersicht 7D

Ausgabe:
- 6x12_fruehwarn_kipppunkte.json
"""

from __future__ import annotations

import json
import math
from dataclasses import dataclass
from datetime import date, datetime
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

OUTFILE = Path("6x12_fruehwarn_kipppunkte.json")
DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
SCOPES = {
    "alle_lehrkraefte": "1=1",
    "lehrkraft_1": "lehrkraft_id = 1",
    "ohne_lehrkraft_1": "lehrkraft_id <> 1",
}


def json_default(obj: Any) -> Any:
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    if isinstance(obj, float):
        if math.isnan(obj) or math.isinf(obj):
            return None
    return str(obj)


def fetch_all(cur, sql: str, params: Tuple[Any, ...] = ()) -> List[Dict[str, Any]]:
    cur.execute(sql, params)
    return list(cur.fetchall())


def table_exists(cur, table_name: str) -> bool:
    cur.execute(
        """
        SELECT COUNT(*) AS c
        FROM information_schema.tables
        WHERE table_schema = DATABASE() AND table_name = %s
        """,
        (table_name,),
    )
    return int(cur.fetchone()["c"]) > 0


def export_scope(cur, scope_name: str, where_clause: str) -> Dict[str, Any]:
    # Lehrkraftsicht pro Gruppe und Datum
    dim_select = ",\n            ".join(
        [
            f"AVG(mean_{d}) AS mean_{d}, AVG(var_{d}) AS var_{d}, AVG(range_{d}) AS range_{d}"
            for d in DIMENSIONS
        ]
    )

    lehrkraft_daily_sql = f"""
        SELECT
            gruppe_id,
            datum,
            COUNT(*) AS n_lehrkraft_records,
            SUM(satzanzahl) AS satzanzahl_sum,
            AVG(semantische_breite) AS semantische_breite,
            AVG(d_semantisch_mean) AS d_semantisch_mean,
            AVG(d_semantisch_std) AS d_semantisch_std,
            AVG(polaritaet_index) AS polaritaet_index,
            AVG(dominanz_breite) AS dominanz_breite,
            {dim_select}
        FROM analyze_lehrkraftdaten
        WHERE gruppe_id IS NOT NULL AND datum IS NOT NULL AND {where_clause}
        GROUP BY gruppe_id, datum
        ORDER BY gruppe_id, datum
    """
    lehrkraft_daily = fetch_all(cur, lehrkraft_daily_sql)

    # Gruppendynamik / Emotionen, falls vorhanden
    group_emotion = []
    if table_exists(cur, "frzk_group_emotion"):
        group_emotion = fetch_all(
            cur,
            """
            SELECT
                gruppe_id,
                zeitpunkt,
                z_affektiv,
                `kohärenz` AS kohaerenz,
                stabilitaet,
                dynamik,
                emotionaler_status,
                emotionaler_modus,
                bemerkung
            FROM frzk_group_emotion
            WHERE gruppe_id IS NOT NULL AND zeitpunkt IS NOT NULL
            ORDER BY gruppe_id, zeitpunkt
            """,
        )

    # Teilnehmersicht 7D, falls vorhanden
    teilnehmer_daily = []
    if table_exists(cur, "frzk_semantische_dichte_teilnehmer_7d"):
        teilnehmer_daily = fetch_all(
            cur,
            """
            SELECT
                gruppe_id,
                zeitpunkt AS datum,
                COUNT(*) AS n_teilnehmer_records,
                AVG(x_kognition) AS tn_mean_kognition,
                AVG(x_sozial) AS tn_mean_sozial,
                AVG(x_affektiv) AS tn_mean_affektiv,
                AVG(x_motivation) AS tn_mean_motivation,
                AVG(x_methodik) AS tn_mean_methodik,
                AVG(x_performanz) AS tn_mean_performanz,
                AVG(x_regulation) AS tn_mean_regulation,
                AVG(d_semantisch) AS tn_d_semantisch_mean,
                AVG(emotion_valenz) AS emotion_valenz_mean,
                AVG(emotion_aktivierung) AS emotion_aktivierung_mean,
                AVG(emotion_anzahl) AS emotion_anzahl_mean,
                AVG(polaritaet_gesamt) AS tn_polaritaet_mean,
                COUNT(DISTINCT dominante_dimension) AS tn_dominanz_breite
            FROM frzk_semantische_dichte_teilnehmer_7d
            WHERE gruppe_id IS NOT NULL AND zeitpunkt IS NOT NULL
            GROUP BY gruppe_id, zeitpunkt
            ORDER BY gruppe_id, zeitpunkt
            """,
        )

    # Meta je Gruppe
    summary_sql = f"""
        SELECT
            gruppe_id,
            COUNT(*) AS n_records,
            COUNT(DISTINCT datum) AS n_termine,
            MIN(datum) AS datum_min,
            MAX(datum) AS datum_max,
            AVG(semantische_breite) AS semantische_breite_mean,
            AVG(d_semantisch_std) AS d_semantisch_std_mean,
            AVG(polaritaet_index) AS polaritaet_index_mean,
            AVG(dominanz_breite) AS dominanz_breite_mean
        FROM analyze_lehrkraftdaten
        WHERE gruppe_id IS NOT NULL AND datum IS NOT NULL AND {where_clause}
        GROUP BY gruppe_id
        ORDER BY gruppe_id
    """
    group_summary = fetch_all(cur, summary_sql)

    return {
        "scope": scope_name,
        "where_clause": where_clause,
        "group_summary": group_summary,
        "lehrkraft_daily": lehrkraft_daily,
        "group_emotion": group_emotion,
        "teilnehmer_daily": teilnehmer_daily,
    }


def main() -> None:
    conn = mysql.connector.connect(**DB_CONFIG)
    try:
        cur = conn.cursor(dictionary=True)
        payload = {
            "meta": {
                "auswertung": "6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten",
                "created_at": datetime.now().isoformat(timespec="seconds"),
                "database": DB_CONFIG["database"],
                "dimensions": DIMENSIONS,
                "definition": {
                    "drift": "Euklidische Distanz zwischen aufeinanderfolgenden Gruppenzuständen",
                    "varianzlast": "Mittel der sieben Varianzdimensionen aus analyze_lehrkraftdaten",
                    "kohaerenzverlust": "fallende Kohärenz bzw. steigende semantische Breite/Drift",
                    "dominanzwechsel": "Wechsel der stärksten Dimension zwischen aufeinanderfolgenden Gruppenzuständen",
                    "risiko_score": "gewichteter Index aus Drift, Varianzlast, Dichte-Std, semantischer Breite, Polaritätsbelastung, Dominanzwechsel und optional Gruppendynamik/Emotionen",
                },
                "risk_weights_hint": {
                    "drift_z": 0.25,
                    "varianzlast_z": 0.15,
                    "d_semantisch_std_z": 0.15,
                    "semantische_breite_z": 0.15,
                    "polaritaet_negativ_z": 0.10,
                    "dominanzwechsel": 0.10,
                    "group_emotion_instability": 0.10,
                },
            },
            "scopes": {},
        }
        for scope, where_clause in SCOPES.items():
            payload["scopes"][scope] = export_scope(cur, scope, where_clause)

        OUTFILE.write_text(json.dumps(payload, ensure_ascii=False, indent=2, default=json_default), encoding="utf-8")
        print(f"OK: JSON exportiert nach {OUTFILE.resolve()}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()
