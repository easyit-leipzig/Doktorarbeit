#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.6 Drift- und Varianzkorrelationen – Exportskript (Python)
Erzeugt EIN JSON ohne Lehrkraftunterscheidung.
Datenbasis: match_tn_daten_analyze_lehrkraft + _mtr_emotionen.
"""
from __future__ import annotations

import json
from decimal import Decimal
from datetime import date, datetime
from pathlib import Path
from typing import Any, Dict, List

import mysql.connector

OUTFILE = Path("6x6_drift_varianz_korrelationen.json")

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

DIMS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
TN_FIELDS = [
    "mitarbeit", "absprachen", "selbststaendigkeit", "konzentration", "fleiss",
    "lernfortschritt", "beherrscht_thema", "transferdenken", "basiswissen", "vorbereitet",
    "themenauswahl", "materialien", "methodenvielfalt", "individualisierung", "aufforderung", "zielgruppen"
]


def json_default(obj: Any) -> Any:
    """Sichere JSON-Konvertierung für MySQL/Python-Typen."""
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    if isinstance(obj, Decimal):
        return float(obj)
    if isinstance(obj, bytes):
        return obj.decode("utf-8", errors="replace")
    raise TypeError(f"Object of type {type(obj).__name__} is not JSON serializable")


def fetch_dicts(cursor, sql: str) -> List[Dict[str, Any]]:
    cursor.execute(sql)
    return list(cursor.fetchall())


def main() -> None:
    cnx = mysql.connector.connect(**DB_CONFIG)
    cur = cnx.cursor(dictionary=True)

    rows_sql = f"""
        SELECT
            teilnehmer_feedback_id, teilnehmer_ue_id, teilnehmer_id, gruppe_id,
            erfasst_am, teilnehmer_datum,
            {', '.join(TN_FIELDS)}, emotions, bemerkungen,
            id_mtr_rueckkopplung_datenmaske, datum, satzanzahl,
            mean_kognition, mean_sozial, mean_affektiv, mean_motivation,
            mean_methodik, mean_performanz, mean_regulation,
            var_kognition, var_sozial, var_affektiv, var_motivation,
            var_methodik, var_performanz, var_regulation,
            d_semantisch_mean, d_semantisch_std, semantische_breite, dominanz_breite,
            x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation,
            dominante_dimension, dominante_dimension_wert, polaritaet_gesamt,
            d_semantisch, token_anzahl, funktionsklassen_anzahl_gesamt
        FROM match_tn_daten_analyze_lehrkraft
        WHERE sdlg_type = 1
        ORDER BY teilnehmer_id, erfasst_am, teilnehmer_feedback_id
    """
    rows = fetch_dicts(cur, rows_sql)

    emotions = fetch_dicts(cur, """
        SELECT id, type_name, fine_label, emotion, map_field, valenz, aktivierung
        FROM _mtr_emotionen
        ORDER BY id
    """)

    payload = {
        "meta": {
            "auswertung": "6.x.6 Drift- und Varianzkorrelationen",
            "created_at": datetime.now().isoformat(timespec="seconds"),
            "database": DB_CONFIG["database"],
            "source_view": "match_tn_daten_analyze_lehrkraft",
            "emotion_table": "_mtr_emotionen",
            "teacher_filter": "keine Lehrkraftunterscheidung; alle Datensätze gemeinsam",
            "row_count": len(rows),
            "dimensions": DIMS,
            "teilnehmer_fields": TN_FIELDS,
            "method": "Exportiert gepaarte Lehrkraft-/Teilnehmerzustände. Analyse berechnet Teilnehmerdrift aus zeitlich aufeinanderfolgenden Teilnehmerzuständen und korreliert diese mit Lehrkraftvarianz, semantischer Breite und Emotionsambivalenz.",
        },
        "emotion_lookup": emotions,
        "data": rows,
    }

    OUTFILE.write_text(json.dumps(payload, ensure_ascii=False, indent=2, default=json_default), encoding="utf-8")
    print(f"OK: {OUTFILE.resolve()} geschrieben ({len(rows)} Datensätze).")

    cur.close()
    cnx.close()


if __name__ == "__main__":
    main()
