import json, os
import pandas as pd
import matplotlib.pyplot as plt

IN = "6x4_globale_semantische_resonanz_match.json"
OUTDIR = "6x4_globale_resonanz_output"
os.makedirs(OUTDIR, exist_ok=True)

with open(IN, "r", encoding="utf-8") as fp:
    data = json.load(fp)

df = pd.DataFrame(data["records"])

summary_rows = []
for key, g in df.groupby("subset"):
    summary_rows.append({
        "gruppe": key,
        "n": len(g),
        "cos_mean": g["cosine_tn_lk_sdlg"].mean(),
        "cos_min": g["cosine_tn_lk_sdlg"].min(),
        "cos_max": g["cosine_tn_lk_sdlg"].max(),
        "dist_mean": g["euclid_tn_lk_sdlg"].mean(),
    })

summary = pd.DataFrame(summary_rows)
summary.loc[len(summary)] = {
    "gruppe": "alle",
    "n": len(df),
    "cos_mean": df["cosine_tn_lk_sdlg"].mean(),
    "cos_min": df["cosine_tn_lk_sdlg"].min(),
    "cos_max": df["cosine_tn_lk_sdlg"].max(),
    "dist_mean": df["euclid_tn_lk_sdlg"].mean(),
}

summary.to_csv(os.path.join(OUTDIR, "summary_globale_resonanz.csv"), index=False, encoding="utf-8-sig")

with open(os.path.join(OUTDIR, "dissertationsauswertung_6x4.txt"), "w", encoding="utf-8") as f:
    f.write("6.x.4 Globale semantische Resonanzkopplung\n\n")
    f.write("Datenbasis: match_tn_daten_analyze_lehrkraft\n")
    f.write("Resonanzmaß: Kosinusähnlichkeit zwischen Teilnehmer-7D-Projektion und Lehrkraft-7D-Gesamtvektor.\n\n")
    for _, r in summary.iterrows():
        f.write(
            f"{r['gruppe']}: n={int(r['n'])}, "
            f"mittlere Kosinusähnlichkeit={r['cos_mean']:.4f}, "
            f"Bereich={r['cos_min']:.4f}–{r['cos_max']:.4f}, "
            f"mittlere euklidische Distanz={r['dist_mean']:.4f}\n"
        )
    f.write("\nInterpretation:\n")
    f.write(
        "Hohe Kosinusähnlichkeiten zeigen eine starke Richtungsähnlichkeit der semantischen "
        "Zustandsräume. Für die Dissertation ist besonders der Vergleich zwischen allen Fällen, "
        "lehrkraft_id=1 und allen übrigen Lehrkräften relevant. Bleibt die Resonanz in allen "
        "Teilmengen hoch, spricht dies nicht nur für einen Einzelfalleffekt, sondern für eine "
        "strukturierte semantische Kopplung zwischen Lehrkraft- und Teilnehmerraum.\n"
    )

plt.figure(figsize=(8,5))
df["cosine_tn_lk_sdlg"].dropna().hist(bins=20)
plt.title("6.x.4 Globale semantische Resonanzkopplung")
plt.xlabel("Kosinusähnlichkeit Teilnehmer ↔ Lehrkraft")
plt.ylabel("Häufigkeit")
plt.tight_layout()
plt.savefig(os.path.join(OUTDIR, "hist_kosinus_resonanz.png"), dpi=200)
plt.close()

plt.figure(figsize=(8,5))
df.boxplot(column="cosine_tn_lk_sdlg", by="subset")
plt.title("Kosinusähnlichkeit nach Lehrkraftgruppe")
plt.suptitle("")
plt.xlabel("Teilmenge")
plt.ylabel("Kosinusähnlichkeit")
plt.tight_layout()
plt.savefig(os.path.join(OUTDIR, "boxplot_kosinus_nach_subset.png"), dpi=200)
plt.close()

plt.figure(figsize=(8,5))
plt.scatter(df["euclid_tn_lk_sdlg"], df["cosine_tn_lk_sdlg"])
plt.title("Distanz und Resonanz")
plt.xlabel("Euklidische Distanz")
plt.ylabel("Kosinusähnlichkeit")
plt.tight_layout()
plt.savefig(os.path.join(OUTDIR, "scatter_distanz_kosinus.png"), dpi=200)
plt.close()

print(summary)
print(f"Auswertung gespeichert in: {OUTDIR}")