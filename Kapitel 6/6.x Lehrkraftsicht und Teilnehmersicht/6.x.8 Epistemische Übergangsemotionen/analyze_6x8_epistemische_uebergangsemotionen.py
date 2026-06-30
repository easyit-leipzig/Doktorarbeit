# -*- coding: utf-8 -*-
"""
6.x.8 Epistemische Übergangsemotionen – Python-Auswertung ohne Lehrkraftunterscheidung
Liest: 6x8_epistemische_uebergangsemotionen.json
Erzeugt CSV-Tabellen und PNG-Grafiken.
"""

import json
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

INPUT_FILE = Path("6x8_epistemische_uebergangsemotionen.json")
OUT_DIR = Path("6x8_epistemische_uebergangsemotionen_output")
DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
TARGET_EMOTIONS = ["Interesse", "Überraschung", "Erwartung", "Erleichterung"]


def load_records() -> pd.DataFrame:
    data = json.loads(INPUT_FILE.read_text(encoding="utf-8"))
    rows = []
    for r in data["records"]:
        base = {
            "datum": r.get("datum"),
            "gruppe_id": r.get("gruppe_id"),
            "teilnehmer_id": r.get("teilnehmer_id"),
            "has_epistemic_transition": int(r.get("has_epistemic_transition", False)),
            "transition_count": r.get("transition_count", 0),
            "transition_names": ", ".join(r.get("epistemic_transition_names", [])),
            "d_semantisch": r.get("d_semantisch", 0),
            "d_semantisch_mean": r.get("d_semantisch_mean", 0),
            "semantische_breite": r.get("semantische_breite", 0),
            "dominanz_breite": r.get("dominanz_breite", 0),
            "dominante_dimension": r.get("dominante_dimension"),
            "polaritaet_gesamt": r.get("polaritaet_gesamt", 0),
            "token_anzahl": r.get("token_anzahl", 0),
        }
        for d in DIMENSIONS:
            base[f"mean_{d}"] = r.get("mean_vector", {}).get(d, 0)
            base[f"x_{d}"] = r.get("x_vector", {}).get(d, 0)
            base[f"var_{d}"] = r.get("var_vector", {}).get(d, 0)
        for e in TARGET_EMOTIONS:
            base[f"emo_{e}"] = int(e in r.get("epistemic_transition_names", []))
        rows.append(base)
    df = pd.DataFrame(rows)
    df["datum"] = pd.to_datetime(df["datum"], errors="coerce")
    return df


def safe_corr(a: pd.Series, b: pd.Series) -> float:
    if a.nunique(dropna=True) < 2 or b.nunique(dropna=True) < 2:
        return np.nan
    return float(a.corr(b))


def save_bar(series: pd.Series, title: str, ylabel: str, filename: str) -> None:
    fig, ax = plt.subplots(figsize=(10, 5))
    series.plot(kind="bar", ax=ax)
    ax.set_title(title)
    ax.set_ylabel(ylabel)
    ax.set_xlabel("")
    plt.xticks(rotation=35, ha="right")
    plt.tight_layout()
    fig.savefig(OUT_DIR / filename, dpi=180)
    plt.close(fig)


def main() -> None:
    OUT_DIR.mkdir(exist_ok=True)
    df = load_records()

    df.to_csv(OUT_DIR / "6x8_rohdaten_flach.csv", index=False, encoding="utf-8-sig")

    summary_rows = []
    for label, sub in [("alle Emotionsdatensätze", df), ("mit epistemischer Übergangsemotion", df[df["has_epistemic_transition"] == 1]), ("ohne epistemische Übergangsemotion", df[df["has_epistemic_transition"] == 0])]:
        row = {"gruppe": label, "n": len(sub)}
        for d in DIMENSIONS:
            row[f"mean_{d}"] = sub[f"mean_{d}"].mean()
        row["d_semantisch_mean"] = sub["d_semantisch_mean"].mean()
        row["semantische_breite"] = sub["semantische_breite"].mean()
        row["dominanz_breite"] = sub["dominanz_breite"].mean()
        row["token_anzahl"] = sub["token_anzahl"].mean()
        summary_rows.append(row)
    summary = pd.DataFrame(summary_rows)
    summary.to_csv(OUT_DIR / "6x8_summary_mit_ohne_uebergangsemotion.csv", index=False, encoding="utf-8-sig")

    emotion_counts = df[[f"emo_{e}" for e in TARGET_EMOTIONS]].sum().rename(lambda x: x.replace("emo_", ""))
    emotion_counts.to_csv(OUT_DIR / "6x8_emotionshaeufigkeit.csv", header=["anzahl"], encoding="utf-8-sig")
    save_bar(emotion_counts, "Häufigkeit epistemischer Übergangsemotionen", "Anzahl", "abb_6x8_01_emotionshaeufigkeit.png")

    dim_cols = [f"mean_{d}" for d in DIMENSIONS]
    means_by_transition = summary.set_index("gruppe").loc[["mit epistemischer Übergangsemotion", "ohne epistemische Übergangsemotion"], dim_cols].T
    means_by_transition.index = [c.replace("mean_", "") for c in means_by_transition.index]
    fig, ax = plt.subplots(figsize=(10, 5))
    means_by_transition.plot(kind="bar", ax=ax)
    ax.set_title("FRZK-Dimensionsmittel: mit vs. ohne epistemische Übergangsemotion")
    ax.set_ylabel("Mittelwert")
    plt.xticks(rotation=35, ha="right")
    plt.tight_layout()
    fig.savefig(OUT_DIR / "abb_6x8_02_dimensionen_mit_ohne.png", dpi=180)
    plt.close(fig)

    corr_rows = []
    for e in TARGET_EMOTIONS:
        indicator = df[f"emo_{e}"]
        row = {"emotion": e, "n": int(indicator.sum())}
        for d in DIMENSIONS:
            row[f"corr_mean_{d}"] = safe_corr(indicator, df[f"mean_{d}"])
        row["corr_d_semantisch_mean"] = safe_corr(indicator, df["d_semantisch_mean"])
        row["corr_semantische_breite"] = safe_corr(indicator, df["semantische_breite"])
        row["corr_dominanz_breite"] = safe_corr(indicator, df["dominanz_breite"])
        row["corr_token_anzahl"] = safe_corr(indicator, df["token_anzahl"])
        corr_rows.append(row)
    corr = pd.DataFrame(corr_rows)
    corr.to_csv(OUT_DIR / "6x8_korrelationen_emotionen_frzk.csv", index=False, encoding="utf-8-sig")

    heat = corr.set_index("emotion")[[f"corr_mean_{d}" for d in DIMENSIONS] + ["corr_d_semantisch_mean", "corr_semantische_breite", "corr_dominanz_breite"]]
    fig, ax = plt.subplots(figsize=(12, 5))
    im = ax.imshow(heat.fillna(0).values, aspect="auto")
    ax.set_xticks(range(len(heat.columns)))
    ax.set_xticklabels([c.replace("corr_mean_", "").replace("corr_", "") for c in heat.columns], rotation=35, ha="right")
    ax.set_yticks(range(len(heat.index)))
    ax.set_yticklabels(heat.index)
    ax.set_title("Korrelationen: Übergangsemotionen und FRZK-Kennwerte")
    fig.colorbar(im, ax=ax)
    plt.tight_layout()
    fig.savefig(OUT_DIR / "abb_6x8_03_korrelationsmatrix.png", dpi=180)
    plt.close(fig)

    by_date = df.groupby("datum")["has_epistemic_transition"].agg(["sum", "count"])
    by_date["anteil"] = by_date["sum"] / by_date["count"]
    by_date.to_csv(OUT_DIR / "6x8_zeitverlauf_uebergangsemotionen.csv", encoding="utf-8-sig")
    fig, ax = plt.subplots(figsize=(11, 5))
    by_date["anteil"].plot(ax=ax, marker="o")
    ax.set_title("Zeitverlauf: Anteil epistemischer Übergangsemotionen")
    ax.set_ylabel("Anteil")
    ax.set_xlabel("Datum")
    plt.tight_layout()
    fig.savefig(OUT_DIR / "abb_6x8_04_zeitverlauf_anteil.png", dpi=180)
    plt.close(fig)

    group_table = df.groupby("gruppe_id").agg(
        n=("has_epistemic_transition", "count"),
        epistemic_n=("has_epistemic_transition", "sum"),
        epistemic_share=("has_epistemic_transition", "mean"),
        mean_kognition=("mean_kognition", "mean"),
        mean_methodik=("mean_methodik", "mean"),
        mean_affektiv=("mean_affektiv", "mean"),
        d_semantisch_mean=("d_semantisch_mean", "mean"),
        semantische_breite=("semantische_breite", "mean"),
    ).reset_index()
    group_table.to_csv(OUT_DIR / "6x8_gruppenprofil_uebergangsemotionen.csv", index=False, encoding="utf-8-sig")

    text = []
    text.append("6.x.8 Epistemische Übergangsemotionen – automatische Auswertung")
    text.append(f"Datensätze gesamt: {len(df)}")
    text.append(f"Mit epistemischer Übergangsemotion: {int(df['has_epistemic_transition'].sum())}")
    text.append(f"Anteil: {df['has_epistemic_transition'].mean():.3f}")
    text.append("\nHäufigkeiten:")
    for e, n in emotion_counts.items():
        text.append(f"- {e}: {int(n)}")
    text.append("\nStärkste positive Korrelationen:")
    long_corr = corr.melt(id_vars=["emotion", "n"], var_name="kennwert", value_name="korrelation").dropna()
    long_corr = long_corr.sort_values("korrelation", ascending=False).head(12)
    for _, r in long_corr.iterrows():
        text.append(f"- {r['emotion']} ↔ {r['kennwert']}: r={r['korrelation']:.3f}")
    (OUT_DIR / "6x8_textauswertung.txt").write_text("\n".join(text), encoding="utf-8")

    print(f"Auswertung abgeschlossen: {OUT_DIR.resolve()}")


if __name__ == "__main__":
    main()
