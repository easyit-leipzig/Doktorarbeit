#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.8 Epistemische Übergangsemotionen – Exportskript

Ziel:
- Exportiert alle passenden Datensätze ohne Lehrkraftunterscheidung in eine JSON-Datei.
- Nutzt match_tn_daten_analyze_lehrkraft als zentrale Kopplungsview.
- Nutzt _mtr_emotionen zur Auflösung der Emotions-IDs.
- Epistemische Emotionen: 9, 20, 23, 24, 25, 26, 27, 28.

Ausgabe:
- 6x8_epistemische_uebergangsemotionen.json

Voraussetzungen:
    pip install mysql-connector-python
"""

from __future__ import annotations

import json
import math
from collections import Counter, defaultdict
from datetime import date, datetime
from decimal import Decimal
from pathlib import Path
from typing import Any, Dict, List, Optional

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

OUTFILE = Path("6x8_epistemische_uebergangsemotionen.json")

DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]

EPISTEMIC_EMOTIONS = {
    9: {"emotion": "Neugier", "phase": "Exploration"},
    20: {"emotion": "Zweifel", "phase": "Destabilisierung/Neubewertung"},
    23: {"emotion": "Interesse", "phase": "Exploration/Aktivierung"},
    24: {"emotion": "Verwirrung", "phase": "Destabilisierung"},
    25: {"emotion": "Unsicherheit", "phase": "Destabilisierung"},
    26: {"emotion": "Überraschung", "phase": "Trigger/Aktivierung"},
    27: {"emotion": "Erwartung", "phase": "Antizipation"},
    28: {"emotion": "Erleichterung", "phase": "Stabilisierung"},
}

PHASE_ORDER = [
    "Antizipation",
    "Trigger/Aktivierung",
    "Destabilisierung",
    "Destabilisierung/Neubewertung",
    "Exploration/Aktivierung",
    "Exploration",
    "Stabilisierung",
]

SQL_ROWS = """
SELECT
    teilnehmer_feedback_id,
    teilnehmer_ue_id,
    teilnehmer_id,
    gruppe_id,
    erfasst_am,
    teilnehmer_datum,
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
    dominante_dimension,
    dominante_dimension_wert,
    polaritaet_gesamt,
    d_semantisch,
    token_anzahl,
    funktionsklassen_anzahl_gesamt
FROM match_tn_daten_analyze_lehrkraft
WHERE emotions IS NOT NULL AND TRIM(emotions) <> ''
ORDER BY teilnehmer_datum, gruppe_id, teilnehmer_id, teilnehmer_feedback_id, sdlg_type
"""

SQL_EMOTIONS = """
SELECT id, type_name, fine_label, emotion, map_field, valenz, aktivierung
FROM _mtr_emotionen
ORDER BY id
"""


def json_default(obj: Any) -> Any:
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    return str(obj)




def make_json_safe(obj: Any) -> Any:
    """Konvertiert MySQL-/Python-Spezialtypen rekursiv in echte JSON-Werte.

    Wichtig für mysql.connector: DECIMAL-Felder kommen häufig als Decimal zurück.
    json.dumps kann Decimal, date und datetime ohne Vorverarbeitung nicht serialisieren.
    """
    if obj is None:
        return None
    if isinstance(obj, bool):
        return obj
    if isinstance(obj, int):
        return obj
    if isinstance(obj, float):
        if math.isnan(obj) or math.isinf(obj):
            return None
        return obj
    if isinstance(obj, Decimal):
        f = float(obj)
        if math.isnan(f) or math.isinf(f):
            return None
        return f
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    if isinstance(obj, dict):
        return {str(k): make_json_safe(v) for k, v in obj.items()}
    if isinstance(obj, (list, tuple, set)):
        return [make_json_safe(v) for v in obj]
    return obj


def to_float(value: Any) -> Optional[float]:
    if value is None:
        return None
    try:
        f = float(value)
        if math.isnan(f) or math.isinf(f):
            return None
        return f
    except (TypeError, ValueError):
        return None


def parse_emotion_ids(raw: Any) -> List[int]:
    if raw is None:
        return []
    ids: List[int] = []
    for part in str(raw).replace(";", ",").split(","):
        part = part.strip()
        if not part:
            continue
        try:
            ids.append(int(part))
        except ValueError:
            continue
    return ids


def norm_date(value: Any) -> str:
    if isinstance(value, datetime):
        return value.date().isoformat()
    if isinstance(value, date):
        return value.isoformat()
    return str(value)[:10]


def vector_from_row(row: Dict[str, Any], prefix: str = "mean_") -> Dict[str, Optional[float]]:
    return {dim: to_float(row.get(f"{prefix}{dim}")) for dim in DIMENSIONS}


def x_vector_from_row(row: Dict[str, Any]) -> Dict[str, Optional[float]]:
    return {dim: to_float(row.get(f"x_{dim}")) for dim in DIMENSIONS}


def mean(values: List[float]) -> Optional[float]:
    values = [v for v in values if v is not None]
    if not values:
        return None
    return sum(values) / len(values)


def fetch_all() -> Dict[str, Any]:
    con = mysql.connector.connect(**DB_CONFIG)
    try:
        cur = con.cursor(dictionary=True)
        cur.execute(SQL_EMOTIONS)
        emotion_table = {int(r["id"]): r for r in cur.fetchall()}

        cur.execute(SQL_ROWS)
        rows = cur.fetchall()
    finally:
        con.close()

    records: List[Dict[str, Any]] = []
    emotion_counter: Counter[str] = Counter()
    phase_counter: Counter[str] = Counter()
    group_counter: Counter[str] = Counter()
    date_counter: Counter[str] = Counter()
    dominant_counter: Counter[str] = Counter()

    for row in rows:
        ids = parse_emotion_ids(row.get("emotions"))
        epistemic_ids = [eid for eid in ids if eid in EPISTEMIC_EMOTIONS]
        if not epistemic_ids:
            continue

        all_emotions = []
        epistemic_emotions = []
        valences: List[float] = []
        activations: List[float] = []

        for eid in ids:
            erow = emotion_table.get(eid)
            if erow:
                all_emotions.append({
                    "id": eid,
                    "emotion": erow.get("emotion"),
                    "type_name": erow.get("type_name"),
                    "fine_label": erow.get("fine_label"),
                    "map_field": erow.get("map_field"),
                    "valenz": to_float(erow.get("valenz")),
                    "aktivierung": to_float(erow.get("aktivierung")),
                })

        for eid in epistemic_ids:
            erow = emotion_table.get(eid, {})
            base = EPISTEMIC_EMOTIONS[eid]
            val = to_float(erow.get("valenz"))
            act = to_float(erow.get("aktivierung"))
            if val is not None:
                valences.append(val)
            if act is not None:
                activations.append(act)
            epistemic_emotions.append({
                "id": eid,
                "emotion": base["emotion"],
                "phase": base["phase"],
                "valenz": val,
                "aktivierung": act,
            })
            emotion_counter[base["emotion"]] += 1
            phase_counter[base["phase"]] += 1

        d_mean = to_float(row.get("d_semantisch_mean")) or 0.0
        sem_breite = to_float(row.get("semantische_breite")) or 0.0
        avg_activation = mean(activations) or 0.0
        epistemic_activation_index = len(epistemic_ids) * avg_activation * (1.0 + d_mean) * (1.0 + sem_breite)

        datum = norm_date(row.get("teilnehmer_datum") or row.get("datum"))
        gruppe_id = str(row.get("gruppe_id"))
        dominante_dimension = row.get("dominante_dimension") or "unbekannt"
        group_counter[gruppe_id] += 1
        date_counter[datum] += 1
        dominant_counter[str(dominante_dimension)] += 1

        records.append({
            "teilnehmer_feedback_id": row.get("teilnehmer_feedback_id"),
            "teilnehmer_ue_id": row.get("teilnehmer_ue_id"),
            "teilnehmer_id": row.get("teilnehmer_id"),
            "gruppe_id": row.get("gruppe_id"),
            "datum": datum,
            "erfasst_am": row.get("erfasst_am"),
            "bemerkungen": row.get("bemerkungen"),

            "id_mtr_rueckkopplung_datenmaske": row.get("id_mtr_rueckkopplung_datenmaske"),
            "sdlg_id": row.get("sdlg_id"),
            "sdlg_type": row.get("sdlg_type"),
            "satzanzahl": row.get("satzanzahl"),

            "emotion_ids_raw": ids,
            "all_emotions": all_emotions,
            "epistemic_emotion_ids": epistemic_ids,
            "epistemic_emotions": epistemic_emotions,
            "epistemic_emotion_count": len(epistemic_ids),
            "epistemic_phase_sequence": [e["phase"] for e in epistemic_emotions],
            "epistemic_activation_index": epistemic_activation_index,
            "epistemic_valenz_mean": mean(valences),
            "epistemic_aktivierung_mean": mean(activations),

            "mean_vector": vector_from_row(row, "mean_"),
            "var_vector": vector_from_row(row, "var_"),
            "x_vector": x_vector_from_row(row),
            "d_semantisch_mean": to_float(row.get("d_semantisch_mean")),
            "d_semantisch_std": to_float(row.get("d_semantisch_std")),
            "d_semantisch": to_float(row.get("d_semantisch")),
            "semantische_breite": to_float(row.get("semantische_breite")),
            "dominanz_breite": to_float(row.get("dominanz_breite")),
            "dominante_dimension": dominante_dimension,
            "dominante_dimension_wert": to_float(row.get("dominante_dimension_wert")),
            "polaritaet_gesamt": to_float(row.get("polaritaet_gesamt")),
            "token_anzahl": to_float(row.get("token_anzahl")),
            "funktionsklassen_anzahl_gesamt": to_float(row.get("funktionsklassen_anzahl_gesamt")),
        })

    records.sort(key=lambda r: (r["datum"], int(r.get("gruppe_id") or 0), int(r.get("teilnehmer_id") or 0)))

    return {
        "metadata": {
            "auswertung": "6.x.8 Epistemische Übergangsemotionen",
            "created_at": datetime.now().isoformat(timespec="seconds"),
            "database": DB_CONFIG["database"],
            "source_view": "match_tn_daten_analyze_lehrkraft",
            "emotion_table": "_mtr_emotionen",
            "teacher_split": False,
            "epistemic_emotion_ids": list(EPISTEMIC_EMOTIONS.keys()),
            "epistemic_emotions": EPISTEMIC_EMOTIONS,
            "phase_order": PHASE_ORDER,
            "dimensions": DIMENSIONS,
            "record_count": len(records),
        },
        "summary": {
            "emotion_frequencies": dict(emotion_counter),
            "phase_frequencies": dict(phase_counter),
            "group_record_counts": dict(group_counter),
            "date_record_counts": dict(date_counter),
            "dominant_dimension_counts": dict(dominant_counter),
        },
        "records": records,
    }


def main() -> None:
    data = fetch_all()
    OUTFILE.write_text(json.dumps(make_json_safe(data), ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Export abgeschlossen: {OUTFILE.resolve()}")
    print(f"Datensätze mit epistemischen Emotionen: {data['metadata']['record_count']}")


if __name__ == "__main__":
    main()
