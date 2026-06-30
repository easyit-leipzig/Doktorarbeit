import json
import math
from pathlib import Path
import mysql.connector

OUT = Path("6x7_regulatorische_stabilisierung.json")

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

DIM = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]

def f(x):
    return None if x is None else float(x)

def mean(vals):
    vals = [v for v in vals if v is not None]
    return sum(vals) / len(vals) if vals else None

def main():
    cn = mysql.connector.connect(**DB)
    cur = cn.cursor(dictionary=True)

    cur.execute("""
        SELECT id, valenz, aktivierung
        FROM _mtr_emotionen
    """)
    emotions = {int(r["id"]): {"valenz": f(r["valenz"]), "aktivierung": f(r["aktivierung"])} for r in cur.fetchall()}

    cur.execute("""
        SELECT *
        FROM match_tn_daten_analyze_lehrkraft
        WHERE sdlg_type = 1
        ORDER BY teilnehmer_datum, gruppe_id, teilnehmer_id
    """)
    rows = []

    for r in cur.fetchall():
        emo_ids = []
        if r.get("emotions"):
            emo_ids = [int(x.strip()) for x in str(r["emotions"]).split(",") if x.strip().isdigit()]

        valenzen = [emotions[e]["valenz"] for e in emo_ids if e in emotions]
        aktivierungen = [emotions[e]["aktivierung"] for e in emo_ids if e in emotions]

        var_sum = sum(f(r.get(f"var_{d}")) or 0 for d in DIM)
        coherence_index = 1 / (1 + var_sum + (f(r.get("semantische_breite")) or 0))
        ambivalence_index = (f(r.get("d_semantisch_std")) or 0) + (f(r.get("dominanz_breite")) or 0) / 7

        record = {
            "teilnehmer_feedback_id": int(r["teilnehmer_feedback_id"]),
            "datum": str(r["teilnehmer_datum"]),
            "gruppe_id": int(r["gruppe_id"]),
            "teilnehmer_id": int(r["teilnehmer_id"]),

            "regulation_lehrkraft": f(r["mean_regulation"]),
            "affektiv_lehrkraft": f(r["mean_affektiv"]),
            "motivation_lehrkraft": f(r["mean_motivation"]),
            "methodik_lehrkraft": f(r["mean_methodik"]),
            "performanz_lehrkraft": f(r["mean_performanz"]),

            "varianz_summe": var_sum,
            "semantische_breite": f(r["semantische_breite"]),
            "d_semantisch_mean": f(r["d_semantisch_mean"]),
            "d_semantisch_std": f(r["d_semantisch_std"]),
            "dominanz_breite": f(r["dominanz_breite"]),
            "coherence_index": coherence_index,
            "ambivalence_index": ambivalence_index,

            "emotion_ids": emo_ids,
            "emotion_valenz_mean": mean(valenzen),
            "emotion_aktivierung_mean": mean(aktivierungen),

            "x_vector": {d: f(r[f"x_{d}"]) for d in DIM},
            "mean_vector": {d: f(r[f"mean_{d}"]) for d in DIM},
        }
        rows.append(record)

    rows.sort(key=lambda x: (x["gruppe_id"], x["teilnehmer_id"], x["datum"]))

    prev = {}
    for r in rows:
        key = (r["gruppe_id"], r["teilnehmer_id"])
        vec = [r["mean_vector"][d] or 0 for d in DIM]
        if key in prev:
            drift = math.sqrt(sum((vec[i] - prev[key][i]) ** 2 for i in range(len(DIM))))
        else:
            drift = None
        r["drift_zur_vorsitzung"] = drift
        prev[key] = vec

    data = {
        "auswertung": "6.x.7 Regulatorische Stabilisierung",
        "beschreibung": "Regulatorische Lehrkraftzustände ohne Lehrkraftunterscheidung im Zusammenhang mit emotionaler Stabilisierung, Drift, Kohärenz und Ambivalenz.",
        "datenquelle": "match_tn_daten_analyze_lehrkraft + _mtr_emotionen",
        "dimensionen": DIM,
        "n": len(rows),
        "records": rows,
    }

    OUT.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"JSON erzeugt: {OUT.resolve()} | Datensätze: {len(rows)}")

    cur.close()
    cn.close()

if __name__ == "__main__":
    main()