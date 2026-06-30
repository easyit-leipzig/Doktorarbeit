#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.3 Dominanzstrukturen Teilnehmersicht – Python-Export
Erzeugt JSON-Auswertungsdaten ohne Lehrkraftunterscheidung aus
frzk_semantische_dichte_teilnehmer_7d.

DB-Standard:
  host=127.0.0.1, port=3306, user=root, password='', database=icas_19_4_2

Ausgabe:
  6x3_dominanzstrukturen_tn.json
"""

from __future__ import annotations

import json
import math
from collections import Counter, defaultdict
from datetime import date, datetime
from pathlib import Path
from typing import Any, Dict, List

try:
    import mysql.connector
except ImportError as exc:
    raise SystemExit("Bitte installieren: pip install mysql-connector-python") from exc

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

OUTPUT_FILE = Path(__file__).with_name("6x3_dominanzstrukturen_tn.json")

DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]


def json_default(obj: Any) -> Any:
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    return str(obj)


def fnum(value: Any) -> float | None:
    if value is None:
        return None
    try:
        x = float(value)
    except (TypeError, ValueError):
        return None
    if math.isnan(x) or math.isinf(x):
        return None
    return x


def mean(values: List[float]) -> float | None:
    return sum(values) / len(values) if values else None


def std_pop(values: List[float]) -> float | None:
    if not values:
        return None
    m = mean(values)
    assert m is not None
    return math.sqrt(sum((x - m) ** 2 for x in values) / len(values))


def safe_ratio(a: int, b: int) -> float:
    return a / b if b else 0.0


def fetch_rows() -> List[Dict[str, Any]]:
    sql = """
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
            dominante_dimension,
            dominante_dimension_wert,
            polaritaet_gesamt,
            d_semantisch,
            drift_norm,
            d_semantisch_delta,
            dominanzwechsel,
            stabilitaet,
            transition_marker,
            emotion_valenz,
            emotion_aktivierung,
            emotion_anzahl
        FROM frzk_semantische_dichte_teilnehmer_7d
        WHERE dominante_dimension IS NOT NULL
        ORDER BY zeitpunkt ASC, gruppe_id ASC, teilnehmer_id ASC, id ASC
    """
    conn = mysql.connector.connect(**DB_CONFIG)
    try:
        cur = conn.cursor(dictionary=True)
        cur.execute(sql)
        return list(cur.fetchall())
    finally:
        conn.close()


def build_export(rows: List[Dict[str, Any]]) -> Dict[str, Any]:
    records: List[Dict[str, Any]] = []
    dominance_values: List[float] = []
    density_values: List[float] = []
    dimensions_counter: Counter[str] = Counter()
    polarity_counter: Counter[str] = Counter()

    by_group: dict[int, list[Dict[str, Any]]] = defaultdict(list)
    by_participant: dict[int, list[Dict[str, Any]]] = defaultdict(list)
    by_date: dict[str, list[Dict[str, Any]]] = defaultdict(list)

    for r in rows:
        dim = str(r.get("dominante_dimension") or "unbestimmt").strip().lower()
        dom_value = fnum(r.get("dominante_dimension_wert"))
        density = fnum(r.get("d_semantisch"))
        polarity = int(fnum(r.get("polaritaet_gesamt")) or 0)
        zeitpunkt = r.get("zeitpunkt")
        date_key = zeitpunkt.date().isoformat() if isinstance(zeitpunkt, datetime) else str(zeitpunkt)[:10]

        dimension_values = {d: fnum(r.get(f"x_{d}")) for d in DIMENSIONS}
        abs_sorted = sorted(
            [(d, abs(v)) for d, v in dimension_values.items() if v is not None],
            key=lambda x: x[1],
            reverse=True,
        )
        second_value = abs_sorted[1][1] if len(abs_sorted) > 1 else None
        dominance_gap = (abs(dom_value) - second_value) if dom_value is not None and second_value is not None else None

        rec = {
            "id": r.get("id"),
            "rueckkopplung_teilnehmer_id": r.get("rueckkopplung_teilnehmer_id"),
            "teilnehmer_id": r.get("teilnehmer_id"),
            "gruppe_id": r.get("gruppe_id"),
            "zeitpunkt": zeitpunkt,
            "datum": date_key,
            "dominante_dimension": dim,
            "dominante_dimension_wert": dom_value,
            "dominanz_abs": abs(dom_value) if dom_value is not None else None,
            "dominanz_luecke_zur_zweiten_dimension": dominance_gap,
            "polaritaet_gesamt": polarity,
            "d_semantisch": density,
            "drift_norm": fnum(r.get("drift_norm")),
            "d_semantisch_delta": fnum(r.get("d_semantisch_delta")),
            "dominanzwechsel": int(fnum(r.get("dominanzwechsel")) or 0),
            "stabilitaet": fnum(r.get("stabilitaet")),
            "transition_marker": r.get("transition_marker"),
            "emotion_valenz": fnum(r.get("emotion_valenz")),
            "emotion_aktivierung": fnum(r.get("emotion_aktivierung")),
            "emotion_anzahl": int(fnum(r.get("emotion_anzahl")) or 0),
            "dimensionen": dimension_values,
        }
        records.append(rec)
        by_group[int(r.get("gruppe_id") or 0)].append(rec)
        by_participant[int(r.get("teilnehmer_id") or 0)].append(rec)
        by_date[date_key].append(rec)
        dimensions_counter[dim] += 1
        polarity_counter[str(polarity)] += 1
        if dom_value is not None:
            dominance_values.append(abs(dom_value))
        if density is not None:
            density_values.append(density)

    total = len(records)

    def summarize_bucket(bucket: List[Dict[str, Any]]) -> Dict[str, Any]:
        dims = Counter(r["dominante_dimension"] for r in bucket)
        dom_abs = [r["dominanz_abs"] for r in bucket if r["dominanz_abs"] is not None]
        gaps = [r["dominanz_luecke_zur_zweiten_dimension"] for r in bucket if r["dominanz_luecke_zur_zweiten_dimension"] is not None]
        density = [r["d_semantisch"] for r in bucket if r["d_semantisch"] is not None]
        wechsel = sum(int(r.get("dominanzwechsel") or 0) for r in bucket)
        return {
            "n": len(bucket),
            "dominante_dimension_haeufigkeit": dict(dims),
            "dominante_dimension_anteile": {k: safe_ratio(v, len(bucket)) for k, v in dims.items()},
            "haeufigste_dominanz": dims.most_common(1)[0][0] if dims else None,
            "dominanz_abs_mittel": mean(dom_abs),
            "dominanz_abs_std": std_pop(dom_abs),
            "dominanz_luecke_mittel": mean(gaps),
            "d_semantisch_mittel": mean(density),
            "dominanzwechsel_anzahl": wechsel,
            "dominanzwechsel_anteil": safe_ratio(wechsel, len(bucket)),
        }

    result = {
        "metadata": {
            "auswertungspunkt": "6.x.3 Dominanzstrukturen",
            "perspektive": "Teilnehmersicht",
            "lehrkraftunterscheidung": False,
            "quelle": "frzk_semantische_dichte_teilnehmer_7d",
            "created_at": datetime.now().isoformat(timespec="seconds"),
            "beschreibung": "Dominante Dimension und Dominanzwert je Teilnehmerzustand, aggregiert ohne Lehrkraftunterscheidung.",
            "dimensionen": DIMENSIONS,
        },
        "summary": {
            "n_zustaende": total,
            "n_teilnehmer": len({r["teilnehmer_id"] for r in records if r.get("teilnehmer_id") is not None}),
            "n_gruppen": len({r["gruppe_id"] for r in records if r.get("gruppe_id") is not None}),
            "dominante_dimension_haeufigkeit": dict(dimensions_counter),
            "dominante_dimension_anteile": {k: safe_ratio(v, total) for k, v in dimensions_counter.items()},
            "dominanz_abs_mittel": mean(dominance_values),
            "dominanz_abs_std": std_pop(dominance_values),
            "d_semantisch_mittel": mean(density_values),
            "polaritaet_haeufigkeit": dict(polarity_counter),
        },
        "by_group": {str(k): summarize_bucket(v) for k, v in sorted(by_group.items())},
        "by_participant": {str(k): summarize_bucket(v) for k, v in sorted(by_participant.items())},
        "by_date": {k: summarize_bucket(v) for k, v in sorted(by_date.items())},
        "records": records,
    }
    return result


def main() -> None:
    rows = fetch_rows()
    data = build_export(rows)
    OUTPUT_FILE.write_text(json.dumps(data, ensure_ascii=False, indent=2, default=json_default), encoding="utf-8")
    print(f"Export abgeschlossen: {OUTPUT_FILE}")
    print(f"Datensätze: {data['summary']['n_zustaende']}")


if __name__ == "__main__":
    main()
