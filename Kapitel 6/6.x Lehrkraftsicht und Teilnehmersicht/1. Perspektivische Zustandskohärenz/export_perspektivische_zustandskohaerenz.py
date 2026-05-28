# export_01_sdlg_safe.py
import json, math, statistics
from datetime import datetime, date
from pathlib import Path
import mysql.connector

DB = dict(host="127.0.0.1", port=3306, user="root", password="",
          database="icas_19_4_2", charset="utf8mb4",
          connection_timeout=5, use_pure=True)

OUT = Path("auswertung_01_perspektivische_zustandskohaerenz_sdlg_safe.json")

DIM = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"]
MAX_DAY_WINDOW = 3
SDLG_TYPE = 2  # ggf. auf None setzen

def f(v): return 0.0 if v is None else float(v)

def nd(v):
    if v is None: return None
    if isinstance(v, datetime): return v.date()
    if isinstance(v, date): return v
    return datetime.fromisoformat(str(v)).date()

def vec(r): return [f(r.get("x_" + d)) for d in DIM]

def euclid(a,b): return math.sqrt(sum((x-y)**2 for x,y in zip(a,b)))

def cosine(a,b):
    na = math.sqrt(sum(x*x for x in a))
    nb = math.sqrt(sum(y*y for y in b))
    if na == 0 or nb == 0: return None
    return sum(x*y for x,y in zip(a,b)) / (na*nb)

def load_teacher(cur, where="", params=()):
    type_sql, type_params = "", []
    if SDLG_TYPE is not None:
        type_sql = "AND sdlg.type = %s"
        type_params.append(SDLG_TYPE)

    sql = f"""
    SELECT DISTINCT
        sdlg.id,
        sdlg.ue_id,
        sdlg.id_mtr_rueckkopplung_datenmaske,
        a.datum,
        a.teilnehmer_id,
        a.lehrkraft_id,
        a.gruppe_id,
        sdlg.x_kognition, sdlg.x_sozial, sdlg.x_affektiv,
        sdlg.x_motivation, sdlg.x_methodik, sdlg.x_performanz,
        sdlg.x_regulation,
        sdlg.dominante_dimension,
        sdlg.dominante_dimension_wert,
        sdlg.polaritaet_gesamt,
        sdlg.d_semantisch,
        a.satzanzahl,
        a.semantische_breite,
        a.d_semantisch_mean,
        a.d_semantisch_std,
        a.polaritaet_index,
        a.dominanz_breite
    FROM frzk_semantische_dichte_lehrer_gesamt sdlg
    INNER JOIN analyze_lehrkraftdaten a
        ON a.id_mtr_rueckkopplung_datenmaske = sdlg.id_mtr_rueckkopplung_datenmaske
    WHERE a.datum IS NOT NULL
      AND a.gruppe_id IS NOT NULL
      AND a.teilnehmer_id IS NOT NULL
      {type_sql}
      {where}
    """
    cur.execute(sql, tuple(type_params) + tuple(params))
    return cur.fetchall()

def load_participants(cur):
    cur.execute("""
    SELECT
        id, ue_id, gruppe_id, teilnehmer_id, zeitpunkt,
        x_kognition, x_sozial, x_affektiv,
        x_motivation, x_methodik, x_performanz, x_regulation,
        dominante_dimension, dominante_dimension_wert,
        polaritaet_gesamt, d_semantisch
    FROM frzk_semantische_dichte_teilnehmer_7d
    WHERE zeitpunkt IS NOT NULL
      AND gruppe_id IS NOT NULL
      AND teilnehmer_id IS NOT NULL
    """)
    return cur.fetchall()

def match_rows(teachers, participants):
    diag = {
        "teacher_rows": len(teachers),
        "participant_rows": len(participants),
        "same_group_candidates": 0,
        "same_participant_candidates": 0,
        "inside_time_window": 0,
        "matches": 0,
        "ue_equal": 0,
        "ue_different": 0,
        "ue_missing": 0
    }

    by_group = {}
    for t in participants:
        by_group.setdefault(int(t["gruppe_id"]), []).append(t)

    matches = []

    for l in teachers:
        ld = nd(l["datum"])
        if ld is None:
            continue

        group_id = int(l["gruppe_id"])
        teilnehmer_id = int(l["teilnehmer_id"])
        lv = vec(l)

        group_candidates = by_group.get(group_id, [])
        diag["same_group_candidates"] += len(group_candidates)

        for t in group_candidates:
            if int(t["teilnehmer_id"]) != teilnehmer_id:
                continue
            diag["same_participant_candidates"] += 1

            td = nd(t["zeitpunkt"])
            if td is None:
                continue

            delta = (td - ld).days
            if abs(delta) > MAX_DAY_WINDOW:
                continue
            diag["inside_time_window"] += 1

            ue_match = None
            if l.get("ue_id") is None or t.get("ue_id") is None:
                diag["ue_missing"] += 1
            else:
                ue_match = int(int(l["ue_id"]) == int(t["ue_id"]))
                if ue_match:
                    diag["ue_equal"] += 1
                else:
                    diag["ue_different"] += 1

            tv = vec(t)

            matches.append({
                "delta_days": delta,
                "matching_type": "gleicher_tag" if delta == 0 else (
                    f"teilnehmersicht_nach_{delta}_tag(en)" if delta > 0
                    else f"teilnehmersicht_vor_{abs(delta)}_tag(en)"
                ),
                "ue_match": ue_match,
                "distance_euclidean": euclid(lv, tv),
                "cosine_similarity": cosine(lv, tv),
                "dominance_match": l.get("dominante_dimension") == t.get("dominante_dimension"),
                "polarity_match": (
                    l.get("polaritaet_gesamt") is not None and
                    t.get("polaritaet_gesamt") is not None and
                    int(l["polaritaet_gesamt"]) == int(t["polaritaet_gesamt"])
                ),
                "lehrkraft": {
                    "quelle": "frzk_semantische_dichte_lehrer_gesamt + analyze_lehrkraftdaten",
                    "id": l["id"],
                    "ue_id": l.get("ue_id"),
                    "id_mtr_rueckkopplung_datenmaske": l.get("id_mtr_rueckkopplung_datenmaske"),
                    "datum": str(ld),
                    "gruppe_id": group_id,
                    "teilnehmer_id": teilnehmer_id,
                    "lehrkraft_id": l["lehrkraft_id"],
                    "vector": dict(zip(DIM, lv)),
                    "dominante_dimension": l.get("dominante_dimension"),
                    "dominante_dimension_wert": f(l.get("dominante_dimension_wert")),
                    "polaritaet_gesamt": l.get("polaritaet_gesamt"),
                    "d_semantisch": f(l.get("d_semantisch")),
                    "analyze": {
                        "satzanzahl": l.get("satzanzahl"),
                        "semantische_breite": f(l.get("semantische_breite")),
                        "d_semantisch_mean": f(l.get("d_semantisch_mean")),
                        "d_semantisch_std": f(l.get("d_semantisch_std")),
                        "polaritaet_index": f(l.get("polaritaet_index")),
                        "dominanz_breite": l.get("dominanz_breite")
                    }
                },
                "teilnehmer": {
                    "id": t["id"],
                    "ue_id": t.get("ue_id"),
                    "datum": str(td),
                    "gruppe_id": int(t["gruppe_id"]),
                    "teilnehmer_id": int(t["teilnehmer_id"]),
                    "vector": dict(zip(DIM, tv)),
                    "dominante_dimension": t.get("dominante_dimension"),
                    "dominante_dimension_wert": f(t.get("dominante_dimension_wert")),
                    "polaritaet_gesamt": t.get("polaritaet_gesamt"),
                    "d_semantisch": f(t.get("d_semantisch"))
                }
            })

    diag["matches"] = len(matches)
    return matches, diag

def summary(matches):
    ds = [m["distance_euclidean"] for m in matches]
    cs = [m["cosine_similarity"] for m in matches if m["cosine_similarity"] is not None]
    return {
        "n_matches": len(matches),
        "distance_mean": statistics.mean(ds) if ds else None,
        "distance_median": statistics.median(ds) if ds else None,
        "cosine_mean": statistics.mean(cs) if cs else None,
        "cosine_median": statistics.median(cs) if cs else None,
        "dominance_match_rate": sum(m["dominance_match"] for m in matches)/len(matches) if matches else None,
        "polarity_match_rate": sum(m["polarity_match"] for m in matches)/len(matches) if matches else None
    }

def build(cur, name, where="", params=()):
    teachers = load_teacher(cur, where, params)
    participants = load_participants(cur)
    matches, diag = match_rows(teachers, participants)
    return {"name": name, "diagnose": diag, "summary": summary(matches), "matches": matches}

def main():
    conn = mysql.connector.connect(**DB)
    cur = conn.cursor(dictionary=True)

    data = {
        "auswertung": "01_perspektivische_zustandskohaerenz_sdlg_safe",
        "lehrkraftbasis": "frzk_semantische_dichte_lehrer_gesamt + analyze_lehrkraftdaten",
        "matching_hart": ["gruppe_id", "teilnehmer_id", f"datum ± {MAX_DAY_WINDOW} Tage"],
        "matching_nicht_hart": ["ue_id", "dominante_dimension", "polaritaet_gesamt"],
        "parameter": {"sdlg_type": SDLG_TYPE, "max_day_window": MAX_DAY_WINDOW, "dimensions": DIM},
        "datasets": {
            "alle_lehrkraefte": build(cur, "alle_lehrkraefte"),
            "lehrkraft_1": build(cur, "lehrkraft_1", "AND a.lehrkraft_id = %s", (1,)),
            "ohne_lehrkraft_1": build(cur, "ohne_lehrkraft_1", "AND a.lehrkraft_id <> %s", (1,))
        }
    }

    OUT.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"JSON geschrieben: {OUT.resolve()}")
    for k,v in data["datasets"].items():
        print(k, v["diagnose"], v["summary"])

    conn.close()

if __name__ == "__main__":
    main()