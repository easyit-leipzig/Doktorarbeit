#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.4 Polarität – Python-Export
Erzeugt JSON-Daten ohne Lehrkraftunterscheidung aus frzk_semantische_dichte_teilnehmer_7d.

Umgebung über Variablen steuerbar:
  FRZK_DB_HOST, FRZK_DB_NAME, FRZK_DB_USER, FRZK_DB_PASS
Ausgabe:
  6x4_polaritaet_tn.json
"""

from __future__ import annotations
import json
import math
import os
from datetime import date, datetime
from pathlib import Path
from typing import Any, Dict, List

try:
    import pymysql
except ImportError as exc:
    raise SystemExit("Bitte installieren: pip install pymysql") from exc

OUT = Path(__file__).with_name("6x4_polaritaet_tn.json")
DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]


def jdefault(o: Any) -> Any:
    if isinstance(o, (datetime, date)):
        return o.isoformat()
    if isinstance(o, float) and (math.isnan(o) or math.isinf(o)):
        return None
    return o


def polarity_class(x: float | None) -> str:
    if x is None:
        return "neutral"
    if x > 0:
        return "positiv"
    if x < 0:
        return "negativ"
    return "neutral"


def connect():
    return pymysql.connect(
        host=os.getenv("FRZK_DB_HOST", "localhost"),
        user=os.getenv("FRZK_DB_USER", "root"),
        password=os.getenv("FRZK_DB_PASS", ""),
        database=os.getenv("FRZK_DB_NAME", "icas_19_4_2"),
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor,
    )


def main() -> None:
    dim_cols = ", ".join([f"x_{d}" for d in DIMENSIONS])
    sql = f"""
        SELECT
            id, rueckkopplung_teilnehmer_id, ue_id, teilnehmer_id, gruppe_id, zeitpunkt,
            {dim_cols}, dominante_dimension, dominante_dimension_wert,
            polaritaet_gesamt, d_semantisch, drift_norm, d_semantisch_delta,
            dominanzwechsel, stabilitaet, transition_marker
        FROM frzk_semantische_dichte_teilnehmer_7d
        WHERE zeitpunkt IS NOT NULL
        ORDER BY gruppe_id, teilnehmer_id, zeitpunkt, id
    """

    with connect() as con:
        with con.cursor() as cur:
            cur.execute(sql)
            rows = cur.fetchall()

    records: List[Dict[str, Any]] = []
    for r in rows:
        vals = [float(r.get(f"x_{d}") or 0.0) for d in DIMENSIONS]
        polarity_index = sum(vals) / len(DIMENSIONS)
        sign = int(r.get("polaritaet_gesamt") or (1 if polarity_index > 0 else -1 if polarity_index < 0 else 0))
        records.append({
            **r,
            "polaritaet_index": polarity_index,
            "polaritaet_klasse": polarity_class(sign),
        })

    def group_key(*parts: Any) -> str:
        return "|".join(str(p) for p in parts)

    by_group: Dict[str, Dict[str, Any]] = {}
    by_group_time: Dict[str, Dict[str, Any]] = {}
    by_time: Dict[str, Dict[str, Any]] = {}

    def add(bucket: Dict[str, Dict[str, Any]], key: str, r: Dict[str, Any], extra: Dict[str, Any]) -> None:
        b = bucket.setdefault(key, {**extra, "n": 0, "positiv": 0, "negativ": 0, "neutral": 0, "sum_index": 0.0})
        b["n"] += 1
        b[r["polaritaet_klasse"]] += 1
        b["sum_index"] += float(r["polaritaet_index"])

    for r in records:
        gid = r.get("gruppe_id")
        day = str(r.get("zeitpunkt"))[:10]
        add(by_group, str(gid), r, {"gruppe_id": gid})
        add(by_time, day, r, {"datum": day})
        add(by_group_time, group_key(gid, day), r, {"gruppe_id": gid, "datum": day})

    for bucket in (by_group, by_time, by_group_time):
        for b in bucket.values():
            n = max(1, b["n"])
            b["mean_polaritaet_index"] = b["sum_index"] / n
            b["anteil_positiv"] = b["positiv"] / n
            b["anteil_negativ"] = b["negativ"] / n
            b["anteil_neutral"] = b["neutral"] / n
            del b["sum_index"]

    output = {
        "meta": {
            "auswertung": "6.x.4 Polarität",
            "scope": "Teilnehmersicht ohne Lehrkraftunterscheidung",
            "quelle": "frzk_semantische_dichte_teilnehmer_7d",
            "dimensionen": DIMENSIONS,
            "n_records": len(records),
        },
        "records": records,
        "by_group": list(by_group.values()),
        "by_time": list(by_time.values()),
        "by_group_time": list(by_group_time.values()),
    }
    OUT.write_text(json.dumps(output, ensure_ascii=False, indent=2, default=jdefault), encoding="utf-8")
    print(f"OK: {OUT} ({len(records)} Datensätze)")


if __name__ == "__main__":
    main()
