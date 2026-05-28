# analyse_01_perspektivische_zustandskohaerenz_sdlg.py
import json, csv, statistics
from pathlib import Path
from collections import Counter, defaultdict
import matplotlib.pyplot as plt

IN = Path("auswertung_01_perspektivische_zustandskohaerenz_sdlg_export.json")
OUT = Path("auswertung_01_perspektivische_zustandskohaerenz_sdlg_analyse")
OUT.mkdir(exist_ok=True)

DIM = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"]


def mean(v):
    return statistics.mean(v) if v else None


def median(v):
    return statistics.median(v) if v else None


def cls(d):
    if d <= 0.75:
        return "hoch_kohärent"
    if d <= 1.50:
        return "teilkohärent"
    if d <= 2.50:
        return "divergent"
    return "stark_divergent"


def flat(dataset, m):
    r = {
        "dataset": dataset,
        "delta_days": m["delta_days"],
        "matching_type": m["matching_type"],
        "distance_euclidean": m["distance_euclidean"],
        "cosine_similarity": m["cosine_similarity"],
        "dominance_match": int(m["dominance_match"]),
        "polarity_match": int(m["polarity_match"]),
        "lehrkraft_id": m["lehrkraft"]["lehrkraft_id"],
        "gruppe_id": m["lehrkraft"]["gruppe_id"],
        "lehrkraft_datum": m["lehrkraft"]["datum"],
        "teilnehmer_datum": m["teilnehmer"]["datum"],
        "lk_dom": m["lehrkraft"]["dominante_dimension"],
        "tn_dom": m["teilnehmer"]["dominante_dimension"],
        "lk_pol": m["lehrkraft"]["polaritaet_gesamt"],
        "tn_pol": m["teilnehmer"]["polaritaet_gesamt"],
        "satzanzahl": m["lehrkraft"]["analyze"]["satzanzahl"],
        "semantische_breite": m["lehrkraft"]["analyze"]["semantische_breite"],
        "d_semantisch_mean": m["lehrkraft"]["analyze"]["d_semantisch_mean"],
        "polaritaet_index": m["lehrkraft"]["analyze"]["polaritaet_index"],
    }
    for d in DIM:
        lk = m["lehrkraft"]["vector"][d]
        tn = m["teilnehmer"]["vector"][d]
        r["lk_" + d] = lk
        r["tn_" + d] = tn
        r["diff_" + d] = lk - tn
    return r


def write_csv(path, rows):
    if not rows:
        return
    with path.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()), delimiter=";")
        w.writeheader()
        w.writerows(rows)


def summarize(rows):
    ds = [r["distance_euclidean"] for r in rows]
    cs = [r["cosine_similarity"] for r in rows if r["cosine_similarity"] is not None]

    by_delta = defaultdict(list)
    dom_pairs = Counter()
    class_counts = Counter()

    for r in rows:
        by_delta[r["delta_days"]].append(r["distance_euclidean"])
        dom_pairs[(r["lk_dom"], r["tn_dom"])] += 1
        class_counts[cls(r["distance_euclidean"])] += 1

    return {
        "n": len(rows),
        "distance_mean": mean(ds),
        "distance_median": median(ds),
        "distance_min": min(ds) if ds else None,
        "distance_max": max(ds) if ds else None,
        "cosine_mean": mean(cs),
        "cosine_median": median(cs),
        "dominance_match_rate": sum(r["dominance_match"] for r in rows)/len(rows) if rows else None,
        "polarity_match_rate": sum(r["polarity_match"] for r in rows)/len(rows) if rows else None,
        "distance_classes": dict(class_counts),
        "distance_by_delta": {
            str(k): {"n": len(v), "mean": mean(v), "median": median(v)}
            for k, v in sorted(by_delta.items())
        },
        "dominance_pairs_top15": [
            {"lehrkraft": a, "teilnehmer": b, "n": n}
            for (a,b), n in dom_pairs.most_common(15)
        ]
    }


def plot_hist(name, rows):
    vals = [r["distance_euclidean"] for r in rows]
    if not vals:
        return
    plt.figure(figsize=(9,5))
    plt.hist(vals, bins=25)
    plt.title(f"D_LT-Verteilung – {name}")
    plt.xlabel("D_LT")
    plt.ylabel("Häufigkeit")
    plt.tight_layout()
    plt.savefig(OUT / f"{name}_distanz_histogramm.png", dpi=200)
    plt.close()


def plot_delta(name, summary):
    xs=[]; ys=[]
    for k, v in summary["distance_by_delta"].items():
        xs.append(int(k)); ys.append(v["mean"])
    if not xs:
        return
    plt.figure(figsize=(9,5))
    plt.plot(xs, ys, marker="o")
    plt.title(f"Mittlere D_LT nach Zeitfenster – {name}")
    plt.xlabel("Delta Tage")
    plt.ylabel("mittlere D_LT")
    plt.axvline(0, linestyle="--")
    plt.tight_layout()
    plt.savefig(OUT / f"{name}_distanz_nach_zeitfenster.png", dpi=200)
    plt.close()


def plot_dims(name, rows):
    ys=[]
    for d in DIM:
        ys.append(mean([abs(r["diff_" + d]) for r in rows]))
    plt.figure(figsize=(10,5))
    plt.bar(DIM, ys)
    plt.title(f"Mittlere absolute Dimensionsdifferenzen – {name}")
    plt.xticks(rotation=30, ha="right")
    plt.ylabel("|Lehrkraft - Teilnehmer|")
    plt.tight_layout()
    plt.savefig(OUT / f"{name}_dimensionsdifferenzen.png", dpi=200)
    plt.close()


def main():
    data = json.loads(IN.read_text(encoding="utf-8"))

    report = [
        "# Auswertung 01 – Perspektivische Zustandskohärenz auf Basis SDL_GESAMT",
        "",
        "Lehrkraftbasis: `frzk_semantische_dichte_lehrer_gesamt` unter Berücksichtigung von `analyze_lehrkraftdaten`.",
        ""
    ]

    all_rows = []

    for name, ds in data["datasets"].items():
        rows = [flat(name, m) for m in ds["matches"]]
        all_rows.extend(rows)

        s = summarize(rows)
        write_csv(OUT / f"{name}_matches.csv", rows)
        (OUT / f"{name}_summary.json").write_text(json.dumps(s, ensure_ascii=False, indent=2), encoding="utf-8")

        plot_hist(name, rows)
        plot_delta(name, s)
        plot_dims(name, rows)

        report += [
            f"## {name}",
            "",
            f"- Matches: {s['n']}",
            f"- D_LT Mittelwert: {s['distance_mean']}",
            f"- D_LT Median: {s['distance_median']}",
            f"- Cosine Mittelwert: {s['cosine_mean']}",
            f"- Dominanz-Matchrate: {s['dominance_match_rate']}",
            f"- Polaritäts-Matchrate: {s['polarity_match_rate']}",
            "",
            "### Distanzklassen",
            *[f"- {k}: {v}" for k, v in s["distance_classes"].items()],
            "",
            "### Zeitfenster",
            *[f"- Δ={k}: n={v['n']}, mean={v['mean']}, median={v['median']}" for k, v in s["distance_by_delta"].items()],
            "",
            "### Häufigste Dominanzkopplungen",
            *[f"- {x['lehrkraft']} → {x['teilnehmer']}: {x['n']}" for x in s["dominance_pairs_top15"]],
            ""
        ]

    write_csv(OUT / "alle_matches_langformat.csv", all_rows)
    (OUT / "auswertung_01_report.md").write_text("\n".join(report), encoding="utf-8")

    print(f"Analyse geschrieben: {OUT.resolve()}")


if __name__ == "__main__":
    main()