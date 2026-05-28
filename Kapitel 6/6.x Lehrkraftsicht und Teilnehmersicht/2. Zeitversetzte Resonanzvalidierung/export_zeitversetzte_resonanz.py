#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Auswertungspunkt 2: Zeitversetzte Resonanzvalidierung – Export

Erzeugt EINE JSON-Datei mit drei Vergleichsräumen:
1. alle Lehrkräfte
2. lehrkraft_id = 1
3. alle außer lehrkraft_id = 1

Grundidee: Lehrkraftzustand L_t wird mit Teilnehmerzustand T_{t+n}
verglichen, wobei n = 1, 2, 3 spätere Sitzungen innerhalb derselben Gruppe
und desselben Teilnehmers meint.
"""

from __future__ import annotations

import json
import math
import statistics
from dataclasses import dataclass, asdict
from datetime import datetime, date
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

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

OUTPUT_FILE = Path("zeitversetzte_resonanzvalidierung_export.json")
DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]
LAGS = [1, 2, 3]


def as_float(value: Any, default: float = 0.0) -> float:
    if value is None:
        return default
    try:
        return float(value)
    except (TypeError, ValueError):
        return default


def vector_from_row(row: Dict[str, Any], prefix: str = "x_") -> List[float]:
    return [as_float(row.get(f"{prefix}{d}")) for d in DIMENSIONS]


def cosine_similarity(a: List[float], b: List[float]) -> Optional[float]:
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(x * x for x in b))
    if na == 0 or nb == 0:
        return None
    return sum(x * y for x, y in zip(a, b)) / (na * nb)


def euclidean_distance(a: List[float], b: List[float]) -> float:
    return math.sqrt(sum((x - y) ** 2 for x, y in zip(a, b)))


def pearson_corr(a: List[float], b: List[float]) -> Optional[float]:
    if len(a) < 2 or len(b) < 2:
        return None
    ma = statistics.mean(a)
    mb = statistics.mean(b)
    da = [x - ma for x in a]
    db = [y - mb for y in b]
    denom = math.sqrt(sum(x * x for x in da) * sum(y * y for y in db))
    if denom == 0:
        return None
    return sum(x * y for x, y in zip(da, db)) / denom


def to_iso(value: Any) -> Optional[str]:
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    if value is None:
        return None
    return str(value)


def connect():
    return mysql.connector.connect(**DB_CONFIG)


def fetch_teacher_states(conn, where_sql: str = "", params: Tuple[Any, ...] = ()) -> List[Dict[str, Any]]:
    """Aggregierter Lehrkraftzustand pro Datum/Gruppe/Teilnehmer/Lehrkraft.

    analyze_lehrkraftdaten ist dafür bevorzugt, weil dort bereits pro
    id_mtr_rueckkopplung_datenmaske und Lehrkraft mittlere Dimensionswerte
    aus sql_semantische_dichte_lehrer_type_1 aggregiert werden.
    """
    sql = f"""
        SELECT
            id_mtr_rueckkopplung_datenmaske,
            datum,
            teilnehmer_id,
            lehrkraft_id,
            gruppe_id,
            satzanzahl,
            mean_kognition AS x_kognition,
            mean_sozial AS x_sozial,
            mean_affektiv AS x_affektiv,
            mean_motivation AS x_motivation,
            mean_methodik AS x_methodik,
            mean_performanz AS x_performanz,
            mean_regulation AS x_regulation,
            d_semantisch_mean AS d_semantisch,
            polaritaet_index,
            dominanz_breite
        FROM analyze_lehrkraftdaten
        {where_sql}
        ORDER BY gruppe_id, teilnehmer_id, datum, lehrkraft_id
    """
    cur = conn.cursor(dictionary=True)
    cur.execute(sql, params)
    rows = cur.fetchall()
    cur.close()
    return rows


def fetch_participant_states(conn) -> List[Dict[str, Any]]:
    sql = """
        SELECT
            id,
            rueckkopplung_teilnehmer_id,
            ue_id,
            teilnehmer_id,
            gruppe_id,
            zeitpunkt,
            DATE(zeitpunkt) AS datum,
            x_kognition,
            x_sozial,
            x_affektiv,
            x_motivation,
            x_methodik,
            x_performanz,
            x_regulation,
            dominante_dimension,
            dominante_dimension_wert,
            polaritaet_gesamt,
            d_semantisch,
            emotion_valenz,
            emotion_aktivierung,
            emotion_anzahl
        FROM frzk_semantische_dichte_teilnehmer_7d
        ORDER BY gruppe_id, teilnehmer_id, zeitpunkt, id
    """
    cur = conn.cursor(dictionary=True)
    cur.execute(sql)
    rows = cur.fetchall()
    cur.close()
    return rows


def index_participants(rows: Iterable[Dict[str, Any]]) -> Dict[Tuple[int, int], List[Dict[str, Any]]]:
    out: Dict[Tuple[int, int], List[Dict[str, Any]]] = {}
    for row in rows:
        key = (int(row["gruppe_id"]), int(row["teilnehmer_id"]))
        out.setdefault(key, []).append(row)
    return out


def find_future_by_session(participant_rows: List[Dict[str, Any]], teacher_date: date, lag: int) -> Optional[Dict[str, Any]]:
    """Gibt den n-ten späteren Teilnehmerzustand zurück.

    Es wird bewusst nicht mit Kalendertagen gearbeitet, sondern mit realen
    Folgesitzungen. Dadurch passt das Verfahren zu Nachhilfeverläufen mit
    Ferien, Ausfällen und unregelmäßigen Abständen.
    """
    future = []
    for row in participant_rows:
        z = row.get("zeitpunkt")
        if isinstance(z, datetime):
            row_date = z.date()
        else:
            row_date = datetime.fromisoformat(str(z)).date()
        if row_date > teacher_date:
            future.append(row)
    if len(future) >= lag:
        return future[lag - 1]
    return None


def build_matches(teacher_rows: List[Dict[str, Any]], participant_rows: List[Dict[str, Any]]) -> Dict[str, Any]:
    p_index = index_participants(participant_rows)
    matches = []

    for t in teacher_rows:
        if t.get("datum") is None or t.get("gruppe_id") is None or t.get("teilnehmer_id") is None:
            continue
        t_date = t["datum"] if isinstance(t["datum"], date) else datetime.fromisoformat(str(t["datum"])).date()
        key = (int(t["gruppe_id"]), int(t["teilnehmer_id"]))
        related = p_index.get(key, [])
        if not related:
            continue
        lv = vector_from_row(t)
        for lag in LAGS:
            p = find_future_by_session(related, t_date, lag)
            if p is None:
                continue
            tv = vector_from_row(p)
            matches.append({
                "lag_sitzungen": lag,
                "gruppe_id": int(t["gruppe_id"]),
                "teilnehmer_id": int(t["teilnehmer_id"]),
                "lehrkraft_id": int(t["lehrkraft_id"]),
                "lehrkraft_datum": to_iso(t["datum"]),
                "teilnehmer_zeitpunkt": to_iso(p["zeitpunkt"]),
                "id_mtr_rueckkopplung_datenmaske": t.get("id_mtr_rueckkopplung_datenmaske"),
                "teilnehmer_state_id": p.get("id"),
                "lehrkraft_vector": dict(zip(DIMENSIONS, lv)),
                "teilnehmer_vector": dict(zip(DIMENSIONS, tv)),
                "kosinus": cosine_similarity(lv, tv),
                "euklidische_distanz": euclidean_distance(lv, tv),
                "korrelation": pearson_corr(lv, tv),
                "lehrkraft_d_semantisch": as_float(t.get("d_semantisch"), None),
                "teilnehmer_d_semantisch": as_float(p.get("d_semantisch"), None),
                "lehrkraft_polaritaet_index": as_float(t.get("polaritaet_index"), None),
                "teilnehmer_polaritaet_gesamt": p.get("polaritaet_gesamt"),
                "teilnehmer_dominante_dimension": p.get("dominante_dimension"),
            })
    return summarize_matches(matches)


def mean_ignore_none(values: Iterable[Optional[float]]) -> Optional[float]:
    clean = [float(v) for v in values if v is not None]
    return statistics.mean(clean) if clean else None


def median_ignore_none(values: Iterable[Optional[float]]) -> Optional[float]:
    clean = [float(v) for v in values if v is not None]
    return statistics.median(clean) if clean else None


def summarize_matches(matches: List[Dict[str, Any]]) -> Dict[str, Any]:
    by_lag = {}
    for lag in LAGS:
        subset = [m for m in matches if m["lag_sitzungen"] == lag]
        by_lag[str(lag)] = {
            "n_matches": len(subset),
            "kosinus_mean": mean_ignore_none(m.get("kosinus") for m in subset),
            "kosinus_median": median_ignore_none(m.get("kosinus") for m in subset),
            "distanz_mean": mean_ignore_none(m.get("euklidische_distanz") for m in subset),
            "distanz_median": median_ignore_none(m.get("euklidische_distanz") for m in subset),
            "korrelation_mean": mean_ignore_none(m.get("korrelation") for m in subset),
            "korrelation_median": median_ignore_none(m.get("korrelation") for m in subset),
        }
    return {
        "summary_by_lag": by_lag,
        "matches": matches,
    }


def main() -> None:
    conn = connect()
    try:
        participant_rows = fetch_participant_states(conn)
        scopes = {
            "alle_lehrkraefte": ("", ()),
            "lehrkraft_1": ("WHERE lehrkraft_id = %s", (1,)),
            "ohne_lehrkraft_1": ("WHERE lehrkraft_id <> %s", (1,)),
        }
        payload = {
            "auswertungspunkt": "2. Zeitversetzte Resonanzvalidierung",
            "beschreibung": "Vergleich L_t mit T_{t+n}; n = 1, 2, 3 reale Folgesitzungen innerhalb gleicher Gruppe und gleichem Teilnehmer.",
            "created_at": datetime.now().isoformat(timespec="seconds"),
            "database": DB_CONFIG["database"],
            "dimensions": DIMENSIONS,
            "lags_sitzungen": LAGS,
            "source_tables": {
                "lehrkraft": "analyze_lehrkraftdaten",
                "teilnehmer": "frzk_semantische_dichte_teilnehmer_7d",
            },
            "scopes": {},
        }
        for scope_name, (where_sql, params) in scopes.items():
            teacher_rows = fetch_teacher_states(conn, where_sql, params)
            payload["scopes"][scope_name] = {
                "n_teacher_states": len(teacher_rows),
                "n_participant_states_total": len(participant_rows),
                **build_matches(teacher_rows, participant_rows),
            }
        OUTPUT_FILE.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"Export geschrieben: {OUTPUT_FILE.resolve()}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()
