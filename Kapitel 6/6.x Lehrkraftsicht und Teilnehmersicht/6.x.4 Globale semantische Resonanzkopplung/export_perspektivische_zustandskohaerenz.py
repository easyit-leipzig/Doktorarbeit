import json, math
import mysql.connector
from datetime import date, datetime

OUT = "6x4_globale_semantische_resonanz_match.json"

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

DIMS = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"]

def f(x):
    try:
        return None if x is None else float(x)
    except Exception:
        return None

def rating_to_positive(v):
    """
    ICAS-Teilnehmerwerte: 1 = sehr positiv, höhere Werte = schwächer/negativer.
    0 oder NULL wird als fehlend behandelt.
    """
    if v is None:
        return None
    v = float(v)
    if v <= 0:
        return None
    return max(0.0, min(1.0, (5.0 - v) / 4.0))

def avg(vals):
    vals = [v for v in vals if v is not None]
    return None if not vals else sum(vals) / len(vals)

def cosine(a, b):
    if any(v is None for v in a + b):
        return None
    na = math.sqrt(sum(x*x for x in a))
    nb = math.sqrt(sum(x*x for x in b))
    if na == 0 or nb == 0:
        return None
    return sum(x*y for x, y in zip(a, b)) / (na * nb)

def euclid(a, b):
    if any(v is None for v in a + b):
        return None
    return math.sqrt(sum((x-y)**2 for x, y in zip(a, b)))

def build_participant_vector(r):
    return {
        "kognition": avg([rating_to_positive(r["beherrscht_thema"]), rating_to_positive(r["transferdenken"]), rating_to_positive(r["basiswissen"])]),
        "sozial": avg([rating_to_positive(r["mitarbeit"]), rating_to_positive(r["zielgruppen"])]),
        "affektiv": avg([rating_to_positive(r["fleiss"])]),
        "motivation": avg([rating_to_positive(r["fleiss"]), rating_to_positive(r["lernfortschritt"])]),
        "methodik": avg([rating_to_positive(r["themenauswahl"]), rating_to_positive(r["methodenvielfalt"]), rating_to_positive(r["individualisierung"])]),
        "performanz": avg([rating_to_positive(r["lernfortschritt"]), rating_to_positive(r["beherrscht_thema"])]),
        "regulation": avg([rating_to_positive(r["absprachen"]), rating_to_positive(r["selbststaendigkeit"]), rating_to_positive(r["konzentration"]), rating_to_positive(r["vorbereitet"]), rating_to_positive(r["aufforderung"])]),
    }

def subset_name(lehrkraft_id):
    return "lehrkraft_1" if int(lehrkraft_id) == 1 else "ohne_lehrkraft_1"

sql = """
SELECT *
FROM match_tn_daten_analyze_lehrkraft
WHERE sdlg_type = 1
ORDER BY datum, gruppe_id, teilnehmer_id, teilnehmer_feedback_id
"""

conn = mysql.connector.connect(**DB)
cur = conn.cursor(dictionary=True)
cur.execute(sql)
rows = cur.fetchall()
cur.close()
conn.close()

records = []
for r in rows:
    tn_vec = build_participant_vector(r)
    lk_vec = {d: f(r[f"x_{d}"]) for d in DIMS}
    lk_mean_vec = {d: f(r[f"mean_{d}"]) for d in DIMS}

    tn = [tn_vec[d] for d in DIMS]
    lk = [lk_vec[d] for d in DIMS]
    lkm = [lk_mean_vec[d] for d in DIMS]

    rec = {
        "teilnehmer_feedback_id": int(r["teilnehmer_feedback_id"]),
        "teilnehmer_id": int(r["teilnehmer_id"]),
        "gruppe_id": int(r["gruppe_id"]),
        "lehrkraft_id": int(r["lehrkraft_id"]),
        "datum": str(r["datum"]),
        "erfasst_am": str(r["erfasst_am"]),
        "id_mtr_rueckkopplung_datenmaske": int(r["id_mtr_rueckkopplung_datenmaske"]),
        "satzanzahl": int(r["satzanzahl"]),
        "teilnehmer_vector_7d": tn_vec,
        "lehrkraft_vector_7d_sdlg": lk_vec,
        "lehrkraft_vector_7d_mean": lk_mean_vec,
        "cosine_tn_lk_sdlg": cosine(tn, lk),
        "cosine_tn_lk_mean": cosine(tn, lkm),
        "euclid_tn_lk_sdlg": euclid(tn, lk),
        "euclid_tn_lk_mean": euclid(tn, lkm),
        "d_semantisch_lehrkraft": f(r["d_semantisch"]),
        "d_semantisch_mean": f(r["d_semantisch_mean"]),
        "semantische_breite": f(r["semantische_breite"]),
        "dominanz_breite": f(r["dominanz_breite"]),
        "dominante_dimension": r["dominante_dimension"],
        "polaritaet_gesamt": int(r["polaritaet_gesamt"]) if r["polaritaet_gesamt"] is not None else None,
        "subset": subset_name(r["lehrkraft_id"]),
    }
    records.append(rec)

def summarize(items):
    vals = [x["cosine_tn_lk_sdlg"] for x in items if x["cosine_tn_lk_sdlg"] is not None]
    dist = [x["euclid_tn_lk_sdlg"] for x in items if x["euclid_tn_lk_sdlg"] is not None]
    return {
        "n": len(items),
        "cosine_mean": sum(vals)/len(vals) if vals else None,
        "cosine_min": min(vals) if vals else None,
        "cosine_max": max(vals) if vals else None,
        "euclid_mean": sum(dist)/len(dist) if dist else None,
    }

data = {
    "meta": {
        "title": "6.x.4 Globale semantische Resonanzkopplung",
        "source_view": "match_tn_daten_analyze_lehrkraft",
        "dimensions": DIMS,
        "participant_mapping": "Teilnehmer-Skalenwerte werden invers normiert: 1 -> 1.0, 4 -> 0.25, 0/NULL -> fehlend.",
        "created_at": datetime.now().isoformat(timespec="seconds"),
    },
    "summary": {
        "alle": summarize(records),
        "lehrkraft_1": summarize([r for r in records if r["subset"] == "lehrkraft_1"]),
        "ohne_lehrkraft_1": summarize([r for r in records if r["subset"] == "ohne_lehrkraft_1"]),
    },
    "records": records,
}

with open(OUT, "w", encoding="utf-8") as fp:
    json.dump(data, fp, ensure_ascii=False, indent=2)

print(f"JSON erzeugt: {OUT}")
print(json.dumps(data["summary"], ensure_ascii=False, indent=2))