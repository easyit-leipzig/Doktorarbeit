#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Auswertungspunkt 3: Dominanzkopplungsanalyse
Exportiert Lehrkraft- und Teilnehmerzustände aus ICAS als eine gemeinsame JSON-Datei.
Kohorten: alle Lehrkräfte, lehrkraft_id=1, alle außer lehrkraft_id=1.

Voraussetzung:
    pip install mysql-connector-python
"""
from __future__ import annotations
import argparse, json, math
from collections import Counter, defaultdict
from datetime import date, datetime
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

import mysql.connector

DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
DB_CONFIG = dict(host="127.0.0.1", port=3306, user="root", password="", database="icas_19_4_2", charset="utf8mb4", connection_timeout=5, use_pure=True)


def as_json_value(v: Any) -> Any:
    if isinstance(v, (datetime, date)):
        return v.isoformat()
    return v


def fetch_dicts(cur, sql: str, params: Iterable[Any] = ()) -> List[Dict[str, Any]]:
    cur.execute(sql, tuple(params))
    cols = [c[0] for c in cur.description]
    return [{cols[i]: as_json_value(row[i]) for i in range(len(cols))} for row in cur.fetchall()]


def dominant_from_vector(row: Dict[str, Any]) -> tuple[str, float]:
    vals = {d: float(row.get(f"x_{d}") or 0.0) for d in DIMENSIONS}
    dim = max(vals, key=lambda k: abs(vals[k]))
    return dim, vals[dim]


def aggregate_teacher_events(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    buckets: Dict[tuple, List[Dict[str, Any]]] = defaultdict(list)
    for r in rows:
        key = (r["id_mtr_rueckkopplung_datenmaske"], r["datum"], r["lehrkraft_id"], r["gruppe_id"], r.get("teilnehmer_id"))
        buckets[key].append(r)
    events = []
    for (rid, datum, lk, gruppe, teilnehmer), items in buckets.items():
        ev = {"id_mtr_rueckkopplung_datenmaske": rid, "datum": datum, "lehrkraft_id": lk, "gruppe_id": gruppe, "teilnehmer_id": teilnehmer, "satzanzahl": len(items)}
        for d in DIMENSIONS:
            ev[f"x_{d}"] = sum(float(x.get(f"x_{d}") or 0.0) for x in items) / len(items)
        ev["d_semantisch"] = sum(float(x.get("d_semantisch") or 0.0) for x in items) / len(items)
        pols = [int(x.get("polaritaet_gesamt") or 0) for x in items]
        ev["polaritaet_gesamt"] = 1 if sum(pols) > 0 else (-1 if sum(pols) < 0 else 0)
        ev["dominante_dimension"], ev["dominante_dimension_wert"] = dominant_from_vector(ev)
        cnt = Counter(str(x.get("dominante_dimension") or "") for x in items if x.get("dominante_dimension"))
        ev["dominante_dimension_satzmodus"] = cnt.most_common(1)[0][0] if cnt else ev["dominante_dimension"]
        events.append(ev)
    events.sort(key=lambda x: (str(x["gruppe_id"]), str(x.get("teilnehmer_id")), str(x["datum"]), int(x["lehrkraft_id"] or 0)))
    return events


def build_pairs(teacher_events: List[Dict[str, Any]], participant_events: List[Dict[str, Any]], max_lag: int) -> List[Dict[str, Any]]:
    # Teilnehmerereignisse werden je Gruppe/Teilnehmer chronologisch indiziert; Lag = nächste Teilnehmertermine nach Lehrkrafttermin.
    p_by_key: Dict[tuple, List[Dict[str, Any]]] = defaultdict(list)
    for p in participant_events:
        p_by_key[(p["gruppe_id"], p["teilnehmer_id"])].append(p)
    for key in p_by_key:
        p_by_key[key].sort(key=lambda x: str(x["zeitpunkt"]))

    pairs = []
    for l in teacher_events:
        key = (l["gruppe_id"], l.get("teilnehmer_id"))
        candidates = p_by_key.get(key) or []
        if not candidates:
            # Fallback: Gruppenkopplung, falls Teilnehmer-ID in Lehrkraftsicht leer/0 ist.
            candidates = [p for (g, _), arr in p_by_key.items() if g == l["gruppe_id"] for p in arr]
            candidates.sort(key=lambda x: str(x["zeitpunkt"]))
        same_or_after = [p for p in candidates if str(p["zeitpunkt"])[:10] >= str(l["datum"])]
        for lag, p in enumerate(same_or_after[: max_lag + 1]):
            ld, pd = l.get("dominante_dimension"), p.get("dominante_dimension")
            pairs.append({
                "lag": lag,
                "match_type": "same_or_following_session",
                "lehrkraft_id": l["lehrkraft_id"],
                "gruppe_id": l["gruppe_id"],
                "teilnehmer_id": l.get("teilnehmer_id") or p.get("teilnehmer_id"),
                "teacher_date": l["datum"],
                "participant_time": p["zeitpunkt"],
                "teacher_dominante_dimension": ld,
                "participant_dominante_dimension": pd,
                "dominanz_match": int(ld == pd),
                "teacher_dominante_dimension_wert": l.get("dominante_dimension_wert"),
                "participant_dominante_dimension_wert": p.get("dominante_dimension_wert"),
                "teacher_polaritaet_gesamt": l.get("polaritaet_gesamt"),
                "participant_polaritaet_gesamt": p.get("polaritaet_gesamt"),
                "polaritaet_match": int((l.get("polaritaet_gesamt") or 0) == (p.get("polaritaet_gesamt") or 0)),
            })
    return pairs


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="dominanzkopplung_export.json")
    ap.add_argument("--max-lag", type=int, default=3)
    args = ap.parse_args()

    cnx = mysql.connector.connect(**DB_CONFIG)
    try:
        cur = cnx.cursor()
        teacher_sql = """
            SELECT id, datum, lehrkraft_id, gruppe_id, teilnehmer_id,
                   id_mtr_rueckkopplung_datenmaske, mtr_rueckkopplung_datenmaske_values_id,
                   x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation,
                   dominante_dimension, dominante_dimension_wert, polaritaet_gesamt, d_semantisch
            FROM sql_semantische_dichte_lehrer_type_1
            WHERE dominante_dimension IS NOT NULL
            ORDER BY datum, gruppe_id, teilnehmer_id, lehrkraft_id, id
        """
        participant_sql = """
            SELECT id, rueckkopplung_teilnehmer_id, ue_id, teilnehmer_id, gruppe_id, zeitpunkt,
                   x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation,
                   dominante_dimension, dominante_dimension_wert, polaritaet_gesamt, d_semantisch,
                   emotion_valenz, emotion_aktivierung, emotion_anzahl
            FROM frzk_semantische_dichte_teilnehmer_7d
            WHERE dominante_dimension IS NOT NULL
            ORDER BY zeitpunkt, gruppe_id, teilnehmer_id, id
        """
        teacher_raw = fetch_dicts(cur, teacher_sql)
        participant_events = fetch_dicts(cur, participant_sql)
    finally:
        cnx.close()

    cohorts = {
        "alle_lehrkraefte": lambda r: True,
        "lehrkraft_1": lambda r: int(r.get("lehrkraft_id") or 0) == 1,
        "ohne_lehrkraft_1": lambda r: int(r.get("lehrkraft_id") or 0) != 1,
    }
    data = {
        "meta": {"auswertungspunkt": 3, "name": "Dominanzkopplungsanalyse", "max_lag": args.max_lag, "dimensions": DIMENSIONS, "created_at": datetime.now().isoformat(timespec="seconds")},
        "cohorts": {},
    }
    for name, pred in cohorts.items():
        rows = [r for r in teacher_raw if pred(r)]
        t_events = aggregate_teacher_events(rows)
        pairs = build_pairs(t_events, participant_events, args.max_lag)
        data["cohorts"][name] = {"teacher_raw_n": len(rows), "teacher_events": t_events, "participant_events": participant_events, "coupling_pairs": pairs}

    Path(args.out).write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"JSON geschrieben: {args.out}")

if __name__ == "__main__":
    main()
