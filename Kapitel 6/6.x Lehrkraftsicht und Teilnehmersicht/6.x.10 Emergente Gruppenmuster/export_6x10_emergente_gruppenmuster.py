#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.10 Emergente Gruppenmuster – Exportskript (Python)
Erzeugt eine JSON-Datei ohne Lehrkraftunterscheidung.

Datenbasis:
- match_tn_daten_analyze_lehrkraft: direkte Kopplung Teilnehmersicht ↔ aggregierte Lehrkraftdaten ↔ sdlg-Vektoren
- _mtr_emotionen: Emotions-Valenz und -Aktivierung

Ausgabe:
- 6x10_emergente_gruppenmuster.json
"""
from __future__ import annotations

import json
import math
from collections import Counter, defaultdict
from datetime import date, datetime
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

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

OUTFILE = Path("6x10_emergente_gruppenmuster.json")
DIMENSIONS = [
    "kognition", "sozial", "affektiv", "motivation",
    "methodik", "performanz", "regulation",
]

QUERY = """
SELECT
    gruppe_id,
    teilnehmer_id,
    teilnehmer_feedback_id,
    teilnehmer_datum,
    erfasst_am,
    emotions,

    id_mtr_rueckkopplung_datenmaske,
    datum,
    satzanzahl,

    mean_kognition, mean_sozial, mean_affektiv, mean_motivation,
    mean_methodik, mean_performanz, mean_regulation,

    var_kognition, var_sozial, var_affektiv, var_motivation,
    var_methodik, var_performanz, var_regulation,

    d_semantisch_mean, d_semantisch_std,
    semantische_breite, dominanz_breite,

    sdlg_id, sdlg_type, sdlg_ue_id,
    x_kognition, x_sozial, x_affektiv, x_motivation,
    x_methodik, x_performanz, x_regulation,
    dominante_dimension, dominante_dimension_wert,
    polaritaet_gesamt, d_semantisch,
    token_anzahl, funktionsklassen_anzahl_gesamt
FROM match_tn_daten_analyze_lehrkraft
WHERE gruppe_id IS NOT NULL
  AND sdlg_type = 1
ORDER BY gruppe_id, datum, teilnehmer_id, sdlg_id
"""

EMOTION_QUERY = """
SELECT id, type_name, fine_label, emotion, valenz, aktivierung
FROM _mtr_emotionen
"""


def as_float(value: Any) -> Optional[float]:
    if value is None or value == "":
        return None
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def as_int(value: Any) -> Optional[int]:
    if value is None or value == "":
        return None
    try:
        return int(value)
    except (TypeError, ValueError):
        return None


def json_default(value: Any) -> str:
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    return str(value)


def vector_from_row(row: Dict[str, Any]) -> List[float]:
    return [as_float(row.get(f"x_{d}")) or 0.0 for d in DIMENSIONS]


def mean(values: Iterable[Optional[float]]) -> Optional[float]:
    clean = [v for v in values if v is not None and math.isfinite(v)]
    return sum(clean) / len(clean) if clean else None


def euclidean(a: List[float], b: List[float]) -> float:
    return math.sqrt(sum((x - y) ** 2 for x, y in zip(a, b)))


def cosine(a: List[float], b: List[float]) -> Optional[float]:
    na = math.sqrt(sum(x * x for x in a))
    nb = math.sqrt(sum(x * x for x in b))
    if na == 0 or nb == 0:
        return None
    return sum(x * y for x, y in zip(a, b)) / (na * nb)


def parse_emotion_ids(raw: Any) -> List[int]:
    if not raw:
        return []
    ids: List[int] = []
    for part in str(raw).replace(";", ",").split(","):
        part = part.strip()
        if part.isdigit():
            ids.append(int(part))
    return ids


def fetch_data() -> tuple[List[Dict[str, Any]], Dict[int, Dict[str, Any]]]:
    con = mysql.connector.connect(**DB_CONFIG)
    try:
        cur = con.cursor(dictionary=True)
        cur.execute(QUERY)
        rows = list(cur.fetchall())
        cur.execute(EMOTION_QUERY)
        emotions = {int(r["id"]): r for r in cur.fetchall()}
        return rows, emotions
    finally:
        con.close()


def build_export(rows: List[Dict[str, Any]], emotions: Dict[int, Dict[str, Any]]) -> Dict[str, Any]:
    grouped: Dict[int, List[Dict[str, Any]]] = defaultdict(list)
    for row in rows:
        gid = as_int(row.get("gruppe_id"))
        if gid is not None:
            grouped[gid].append(row)

    groups: Dict[str, Any] = {}
    all_vectors: List[List[float]] = []
    all_dominance: Counter[str] = Counter()
    all_emotion_ids: Counter[int] = Counter()

    for gid, items in sorted(grouped.items()):
        vectors = [vector_from_row(r) for r in items]
        all_vectors.extend(vectors)
        dates = [str(r.get("datum") or r.get("teilnehmer_datum")) for r in items]

        centroid = [mean([v[i] for v in vectors]) or 0.0 for i in range(len(DIMENSIONS))]
        dominance_counter = Counter(str(r.get("dominante_dimension") or "unbekannt") for r in items)
        all_dominance.update(dominance_counter)

        drift = []
        for i in range(1, len(vectors)):
            drift.append({
                "from_index": i - 1,
                "to_index": i,
                "from_date": dates[i - 1],
                "to_date": dates[i],
                "euclidean_drift": euclidean(vectors[i - 1], vectors[i]),
                "cosine_similarity": cosine(vectors[i - 1], vectors[i]),
            })

        pairwise_cosines = []
        # begrenzte Paarberechnung, um JSON-Datei handhabbar zu halten
        for i in range(len(vectors)):
            for j in range(i + 1, min(len(vectors), i + 51)):
                c = cosine(vectors[i], vectors[j])
                if c is not None:
                    pairwise_cosines.append(c)

        emotion_counter: Counter[int] = Counter()
        emotion_values: List[float] = []
        emotion_activation: List[float] = []
        for r in items:
            for eid in parse_emotion_ids(r.get("emotions")):
                if eid in emotions:
                    emotion_counter[eid] += 1
                    all_emotion_ids[eid] += 1
                    emotion_values.append(as_float(emotions[eid].get("valenz")) or 0.0)
                    emotion_activation.append(as_float(emotions[eid].get("aktivierung")) or 0.0)

        groups[str(gid)] = {
            "gruppe_id": gid,
            "n_records": len(items),
            "n_participants": len({r.get("teilnehmer_id") for r in items}),
            "date_min": min(dates) if dates else None,
            "date_max": max(dates) if dates else None,
            "centroid_7d": dict(zip(DIMENSIONS, centroid)),
            "dominant_axis": max(zip(DIMENSIONS, centroid), key=lambda x: abs(x[1]))[0] if centroid else None,
            "mean_d_semantisch": mean(as_float(r.get("d_semantisch")) for r in items),
            "mean_d_semantisch_mean": mean(as_float(r.get("d_semantisch_mean")) for r in items),
            "mean_semantische_breite": mean(as_float(r.get("semantische_breite")) for r in items),
            "mean_dominanz_breite": mean(as_float(r.get("dominanz_breite")) for r in items),
            "mean_polaritaet": mean(as_float(r.get("polaritaet_gesamt")) for r in items),
            "dominance_counts": dict(dominance_counter),
            "drift": drift,
            "drift_summary": {
                "mean_euclidean_drift": mean(d["euclidean_drift"] for d in drift),
                "mean_cosine_transition": mean(d["cosine_similarity"] for d in drift),
            },
            "attractor_summary": {
                "mean_pairwise_cosine_limited_window": mean(pairwise_cosines),
                "share_cosine_ge_0_95": (sum(1 for c in pairwise_cosines if c >= 0.95) / len(pairwise_cosines)) if pairwise_cosines else None,
                "n_pairwise_cosine": len(pairwise_cosines),
            },
            "emotion_summary": {
                "emotion_counts": {str(k): int(v) for k, v in emotion_counter.items()},
                "mean_valenz": mean(emotion_values),
                "mean_aktivierung": mean(emotion_activation),
                "n_emotion_mentions": sum(emotion_counter.values()),
            },
            "records": [
                {
                    "gruppe_id": as_int(r.get("gruppe_id")),
                    "teilnehmer_id": as_int(r.get("teilnehmer_id")),
                    "datum": str(r.get("datum") or r.get("teilnehmer_datum")),
                    "vector_7d": dict(zip(DIMENSIONS, vector_from_row(r))),
                    "dominante_dimension": r.get("dominante_dimension"),
                    "dominante_dimension_wert": as_float(r.get("dominante_dimension_wert")),
                    "polaritaet_gesamt": as_int(r.get("polaritaet_gesamt")),
                    "d_semantisch": as_float(r.get("d_semantisch")),
                    "emotions": parse_emotion_ids(r.get("emotions")),
                }
                for r in items
            ],
        }

    global_centroid = [mean([v[i] for v in all_vectors]) or 0.0 for i in range(len(DIMENSIONS))]
    return {
        "meta": {
            "auswertung": "6.x.10 Emergente Gruppenmuster",
            "created_at": datetime.now().isoformat(timespec="seconds"),
            "database": DB_CONFIG["database"],
            "source_view": "match_tn_daten_analyze_lehrkraft",
            "source_emotions": "_mtr_emotionen",
            "lehrkraftunterscheidung": False,
            "dimensions": DIMENSIONS,
            "description": "Gruppenbezogene Emergenzanalyse aus 7D-Vektoren, Dominanzachsen, Drift, Attraktorähnlichkeit und Emotionsclustern.",
        },
        "global_summary": {
            "n_records": len(rows),
            "n_groups": len(grouped),
            "global_centroid_7d": dict(zip(DIMENSIONS, global_centroid)),
            "global_dominance_counts": dict(all_dominance),
            "global_emotion_counts": {str(k): int(v) for k, v in all_emotion_ids.items()},
        },
        "groups": groups,
        "emotion_lookup": {
            str(k): {
                "emotion": v.get("emotion"),
                "type_name": v.get("type_name"),
                "fine_label": v.get("fine_label"),
                "valenz": as_float(v.get("valenz")),
                "aktivierung": as_float(v.get("aktivierung")),
            }
            for k, v in emotions.items()
        },
    }


def main() -> None:
    rows, emotions = fetch_data()
    export = build_export(rows, emotions)
    OUTFILE.write_text(json.dumps(export, ensure_ascii=False, indent=2, default=json_default), encoding="utf-8")
    print(f"OK: {OUTFILE.resolve()} geschrieben")
    print(f"Datensätze: {export['global_summary']['n_records']} | Gruppen: {export['global_summary']['n_groups']}")


if __name__ == "__main__":
    main()
