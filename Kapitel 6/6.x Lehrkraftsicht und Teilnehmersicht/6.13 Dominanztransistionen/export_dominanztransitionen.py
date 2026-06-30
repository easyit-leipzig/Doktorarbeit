# export_dominanztransitionen.py
import json
import math
from collections import Counter, defaultdict
from datetime import date, datetime
import mysql.connector

OUTFILE = "dominanztransitionen.json"

DB = dict(
    host="127.0.0.1",
    port=3306,
    user="root",
    password="",
    database="icas_19_4_2",
    charset="utf8mb4",
    connection_timeout=5,
    use_pure=True,
)

SQL = """
SELECT
    m.gruppe_id,
    m.teilnehmer_id,
    m.datum,
    s.id AS sdlg_id,
    s.id_mtr_rueckkopplung_datenmaske,
    s.dominante_dimension,
    s.dominante_dimension_wert,
    s.polaritaet_gesamt,
    s.d_semantisch,
    s.type
FROM frzk_semantische_dichte_lehrer_gesamt s
JOIN mtr_rueckkopplung_datenmaske m
  ON m.id = s.id_mtr_rueckkopplung_datenmaske
WHERE s.type = 1
  AND s.dominante_dimension IS NOT NULL
ORDER BY m.gruppe_id, m.teilnehmer_id, m.datum, s.id
"""

def clean(v):
    if isinstance(v, (date, datetime)):
        return v.isoformat()
    return v

def entropy(counter):
    total = sum(counter.values())
    if total == 0:
        return 0.0
    return -sum((c / total) * math.log2(c / total) for c in counter.values())

def main():
    con = mysql.connector.connect(**DB)
    cur = con.cursor(dictionary=True)
    cur.execute(SQL)
    rows = [{k: clean(v) for k, v in r.items()} for r in cur.fetchall()]
    cur.close()
    con.close()

    grouped = defaultdict(list)
    for r in rows:
        grouped[(r["gruppe_id"], r["teilnehmer_id"])].append(r)

    transitions = []
    for (gruppe_id, teilnehmer_id), seq in grouped.items():
        seq = sorted(seq, key=lambda x: (x["datum"], x["sdlg_id"]))
        for a, b in zip(seq, seq[1:]):
            d1 = a["dominante_dimension"]
            d2 = b["dominante_dimension"]
            transitions.append({
                "gruppe_id": gruppe_id,
                "teilnehmer_id": teilnehmer_id,
                "datum_t": a["datum"],
                "datum_t1": b["datum"],
                "from": d1,
                "to": d2,
                "transition": f"{d1}->{d2}",
                "stable": d1 == d2,
                "wert_t": float(a["dominante_dimension_wert"] or 0),
                "wert_t1": float(b["dominante_dimension_wert"] or 0),
                "delta_wert": float(b["dominante_dimension_wert"] or 0) - float(a["dominante_dimension_wert"] or 0),
                "polaritaet_t": a["polaritaet_gesamt"],
                "polaritaet_t1": b["polaritaet_gesamt"],
                "d_semantisch_t": float(a["d_semantisch"] or 0),
                "d_semantisch_t1": float(b["d_semantisch"] or 0),
                "delta_d_semantisch": float(b["d_semantisch"] or 0) - float(a["d_semantisch"] or 0),
            })

    transition_counts = Counter(t["transition"] for t in transitions)
    from_counts = Counter(t["from"] for t in transitions)

    matrix = defaultdict(dict)
    for tr, c in transition_counts.items():
        f, to = tr.split("->")
        matrix[f][to] = {
            "count": c,
            "probability": c / from_counts[f] if from_counts[f] else 0
        }

    summary = {
        "n_records": len(rows),
        "n_sequences": len(grouped),
        "n_transitions": len(transitions),
        "stable_transitions": sum(1 for t in transitions if t["stable"]),
        "stability_rate": sum(1 for t in transitions if t["stable"]) / len(transitions) if transitions else 0,
        "transition_entropy": entropy(transition_counts),
        "dominance_counts": dict(Counter(r["dominante_dimension"] for r in rows)),
        "transition_counts": dict(transition_counts),
        "transition_matrix": matrix,
    }

    out = {
        "metadata": {
            "auswertungspunkt": "Dominanztransitionen",
            "scope": "ohne_lehrkraftunterscheidung",
            "source_tables": [
                "frzk_semantische_dichte_lehrer_gesamt",
                "mtr_rueckkopplung_datenmaske"
            ]
        },
        "summary": summary,
        "records": rows,
        "transitions": transitions,
    }

    with open(OUTFILE, "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False, indent=2)

    print(f"JSON exportiert: {OUTFILE}")
    print(json.dumps(summary, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    main()