#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.9 Attraktor- und Dominanzstrukturen – Exportskript Python
Erzeugt EIN JSON ohne Lehrkraftunterscheidung.
Datenbasis: match_tn_daten_analyze_lehrkraft (bevorzugt), Fallback auf Join aus mtr_rueckkopplung_teilnehmer,
analyze_lehrkraftdaten und frzk_semantische_dichte_lehrer_gesamt.
"""
from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List

import mysql.connector
from mysql.connector import Error

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

OUTFILE = Path("6x9_attraktor_dominanzstrukturen.json")
DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]


def table_exists(cur, table_name: str) -> bool:
    cur.execute(
        """
        SELECT COUNT(*) AS n
        FROM information_schema.tables
        WHERE table_schema = DATABASE() AND table_name = %s
        """,
        (table_name,),
    )
    return int(cur.fetchone()["n"]) > 0


def fetch_rows(cur) -> List[Dict[str, Any]]:
    if table_exists(cur, "match_tn_daten_analyze_lehrkraft"):
        sql = """
        SELECT
            teilnehmer_feedback_id, teilnehmer_ue_id, teilnehmer_id, gruppe_id,
            erfasst_am, teilnehmer_datum,
            mitarbeit, absprachen, selbststaendigkeit, konzentration, fleiss,
            lernfortschritt, beherrscht_thema, transferdenken, basiswissen,
            vorbereitet, themenauswahl, materialien, methodenvielfalt,
            individualisierung, aufforderung, zielgruppen, emotions, bemerkungen,
            id_mtr_rueckkopplung_datenmaske, datum, satzanzahl,
            mean_kognition, mean_sozial, mean_affektiv, mean_motivation,
            mean_methodik, mean_performanz, mean_regulation,
            var_kognition, var_sozial, var_affektiv, var_motivation,
            var_methodik, var_performanz, var_regulation,
            d_semantisch_mean, d_semantisch_std, semantische_breite, dominanz_breite,
            sdlg_id, sdlg_type, sdlg_ue_id,
            x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik,
            x_performanz, x_regulation,
            dominante_dimension, dominante_dimension_wert, polaritaet_gesamt,
            d_semantisch, token_anzahl, funktionsklassen_anzahl_gesamt
        FROM match_tn_daten_analyze_lehrkraft
        WHERE sdlg_type = 1
        ORDER BY teilnehmer_datum, gruppe_id, teilnehmer_id, sdlg_id
        """
    else:
        sql = """
        SELECT
            mt.id AS teilnehmer_feedback_id, mt.ue_id AS teilnehmer_ue_id,
            mt.teilnehmer_id, mt.gruppe_id, mt.erfasst_am,
            CAST(mt.erfasst_am AS DATE) AS teilnehmer_datum,
            mt.mitarbeit, mt.absprachen, mt.selbststaendigkeit, mt.konzentration,
            mt.fleiss, mt.lernfortschritt, mt.beherrscht_thema, mt.transferdenken,
            mt.basiswissen, mt.vorbereitet, mt.themenauswahl, mt.materialien,
            mt.methodenvielfalt, mt.individualisierung, mt.aufforderung,
            mt.zielgruppen, mt.emotions, mt.bemerkungen,
            al.id_mtr_rueckkopplung_datenmaske, al.datum, al.satzanzahl,
            al.mean_kognition, al.mean_sozial, al.mean_affektiv, al.mean_motivation,
            al.mean_methodik, al.mean_performanz, al.mean_regulation,
            al.var_kognition, al.var_sozial, al.var_affektiv, al.var_motivation,
            al.var_methodik, al.var_performanz, al.var_regulation,
            al.d_semantisch_mean, al.d_semantisch_std, al.semantische_breite, al.dominanz_breite,
            sdlg.id AS sdlg_id, sdlg.type AS sdlg_type, sdlg.ue_id AS sdlg_ue_id,
            sdlg.x_kognition, sdlg.x_sozial, sdlg.x_affektiv, sdlg.x_motivation,
            sdlg.x_methodik, sdlg.x_performanz, sdlg.x_regulation,
            sdlg.dominante_dimension, sdlg.dominante_dimension_wert,
            sdlg.polaritaet_gesamt, sdlg.d_semantisch,
            sdlg.token_anzahl, sdlg.funktionsklassen_anzahl_gesamt
        FROM mtr_rueckkopplung_teilnehmer mt
        JOIN analyze_lehrkraftdaten al
          ON al.teilnehmer_id = mt.teilnehmer_id
         AND al.datum = CAST(mt.erfasst_am AS DATE)
        JOIN frzk_semantische_dichte_lehrer_gesamt sdlg
          ON sdlg.id_mtr_rueckkopplung_datenmaske = al.id_mtr_rueckkopplung_datenmaske
        WHERE sdlg.type = 1
        ORDER BY mt.erfasst_am, mt.gruppe_id, mt.teilnehmer_id, sdlg.id
        """
    cur.execute(sql)
    return cur.fetchall()


def main() -> None:
    try:
        con = mysql.connector.connect(**DB_CONFIG)
        cur = con.cursor(dictionary=True)
        rows = fetch_rows(cur)
        payload = {
            "metadata": {
                "auswertung": "6.x.9 Attraktor- und Dominanzstrukturen",
                "created_at": datetime.now().isoformat(timespec="seconds"),
                "database": DB_CONFIG["database"],
                "scope": "ohne Lehrkraftunterscheidung",
                "record_count": len(rows),
                "dimensions": DIMENSIONS,
                "dominance_definition": "argmax(|x_dimension|) bzw. dominante_dimension aus frzk_semantische_dichte_lehrer_gesamt",
                "attractor_definition": "wiederkehrender Zustand aus dominante_dimension, Polarität und hoher lokaler Wiederholung/Kosinusnähe",
            },
            "records": rows,
        }
        OUTFILE.write_text(json.dumps(payload, ensure_ascii=False, indent=2, default=str), encoding="utf-8")
        print(f"OK: {len(rows)} Datensätze nach {OUTFILE.resolve()} exportiert.")
    except Error as exc:
        raise SystemExit(f"MySQL-Fehler: {exc}") from exc
    finally:
        try:
            cur.close(); con.close()
        except Exception:
            pass


if __name__ == "__main__":
    main()
