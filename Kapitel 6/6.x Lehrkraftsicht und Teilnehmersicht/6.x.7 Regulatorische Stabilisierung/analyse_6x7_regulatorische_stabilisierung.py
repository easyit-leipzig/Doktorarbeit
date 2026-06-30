import json
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

IN = Path("6x7_regulatorische_stabilisierung.json")
OUT = Path("6x7_regulatorische_stabilisierung_auswertung")
OUT.mkdir(exist_ok=True)

def corr(df, a, b):
    x = df[[a, b]].dropna()
    return None if len(x) < 3 else float(x[a].corr(x[b]))

def main():
    data = json.loads(IN.read_text(encoding="utf-8"))
    df = pd.DataFrame(data["records"])

    metrics = {
        "n": len(df),
        "regulation_mean": df["regulation_lehrkraft"].mean(),
        "regulation_std": df["regulation_lehrkraft"].std(),
        "corr_regulation_emotion_valenz": corr(df, "regulation_lehrkraft", "emotion_valenz_mean"),
        "corr_regulation_drift": corr(df, "regulation_lehrkraft", "drift_zur_vorsitzung"),
        "corr_regulation_coherence": corr(df, "regulation_lehrkraft", "coherence_index"),
        "corr_regulation_ambivalence": corr(df, "regulation_lehrkraft", "ambivalence_index"),
        "corr_regulation_semantische_breite": corr(df, "regulation_lehrkraft", "semantische_breite"),
        "corr_regulation_dichte_std": corr(df, "regulation_lehrkraft", "d_semantisch_std"),
    }

    Path(OUT / "kennwerte.json").write_text(
        json.dumps(metrics, ensure_ascii=False, indent=2),
        encoding="utf-8"
    )

    text = []
    text.append("# 6.x.7 Regulatorische Stabilisierung – Auswertung\n")
    text.append(f"Datensätze: {metrics['n']}\n")
    text.append(f"Mittelwert Regulation: {metrics['regulation_mean']:.4f}\n")
    text.append(f"Standardabweichung Regulation: {metrics['regulation_std']:.4f}\n\n")
    text.append("## Korrelationen\n")
    for k, v in metrics.items():
        if k.startswith("corr_"):
            text.append(f"- {k}: {v:.4f}" if v is not None else f"- {k}: nicht berechenbar")

    text.append("\n\n## Interpretation\n")
    text.append(
        "Positive Zusammenhänge zwischen Regulation und Kohärenz bzw. emotionaler Valenz "
        "sprechen für regulatorische Stabilisierung. Negative Zusammenhänge zwischen Regulation "
        "und Drift, Ambivalenz oder semantischer Breite sprechen dafür, dass Regulation im FRZK-Raum "
        "als stabilisierende Kopplungsdimension wirkt."
    )

    Path(OUT / "bericht.md").write_text("\n".join(text), encoding="utf-8")

    plots = [
        ("emotion_valenz_mean", "Regulation vs. emotionale Valenz"),
        ("drift_zur_vorsitzung", "Regulation vs. Drift"),
        ("coherence_index", "Regulation vs. Kohärenzindex"),
        ("ambivalence_index", "Regulation vs. Ambivalenzindex"),
    ]

    for y, title in plots:
        d = df[["regulation_lehrkraft", y]].dropna()
        if len(d) < 3:
            continue
        plt.figure()
        plt.scatter(d["regulation_lehrkraft"], d[y])
        plt.xlabel("Regulation Lehrkraft")
        plt.ylabel(y)
        plt.title(title)
        plt.tight_layout()
        plt.savefig(OUT / f"{y}.png", dpi=200)
        plt.close()

    print(f"Auswertung erzeugt in: {OUT.resolve()}")

if __name__ == "__main__":
    main()