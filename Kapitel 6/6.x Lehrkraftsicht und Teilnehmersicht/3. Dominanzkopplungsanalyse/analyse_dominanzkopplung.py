#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Auswertungspunkt 3: Dominanzkopplungsanalyse
Liest JSON aus 01_export_dominanzkopplung.py und erzeugt Text-, CSV- und PNG-Auswertungen.
Voraussetzung: pip install pandas matplotlib
"""
from __future__ import annotations
import argparse, json
from pathlib import Path
from typing import Dict
import pandas as pd
import matplotlib.pyplot as plt

DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]


def safe_div(a, b):
    return float(a) / float(b) if b else 0.0


def analyze_cohort(name: str, cohort: Dict, outdir: Path) -> str:
    pairs = pd.DataFrame(cohort.get("coupling_pairs", []))
    if pairs.empty:
        return f"## {name}\nKeine Kopplungspaare gefunden.\n"
    pairs.to_csv(outdir / f"{name}_kopplungspaare.csv", index=False, encoding="utf-8-sig")

    lag_summary = pairs.groupby("lag").agg(
        n=("dominanz_match", "size"),
        dominanz_match_rate=("dominanz_match", "mean"),
        polaritaet_match_rate=("polaritaet_match", "mean"),
    ).reset_index()
    lag_summary.to_csv(outdir / f"{name}_lag_summary.csv", index=False, encoding="utf-8-sig")

    matrix = pd.crosstab(pairs["teacher_dominante_dimension"], pairs["participant_dominante_dimension"], normalize="index").reindex(index=DIMENSIONS, columns=DIMENSIONS).fillna(0)
    matrix.to_csv(outdir / f"{name}_dominanz_uebergangsmatrix.csv", encoding="utf-8-sig")

    fig = plt.figure(figsize=(8, 5))
    plt.bar(lag_summary["lag"].astype(str), lag_summary["dominanz_match_rate"])
    plt.xlabel("Lag der Teilnehmersicht (0 = gleiche/nächste Sitzung)")
    plt.ylabel("Dominanz-Match-Rate")
    plt.title(f"Dominanzkopplung nach Zeitversatz – {name}")
    plt.ylim(0, 1)
    plt.tight_layout()
    plt.savefig(outdir / f"{name}_dominanz_match_lag.png", dpi=180)
    plt.close(fig)

    fig = plt.figure(figsize=(8, 6))
    plt.imshow(matrix.values, aspect="auto")
    plt.xticks(range(len(DIMENSIONS)), DIMENSIONS, rotation=45, ha="right")
    plt.yticks(range(len(DIMENSIONS)), DIMENSIONS)
    plt.xlabel("Teilnehmerdominanz")
    plt.ylabel("Lehrkraftdominanz")
    plt.title(f"Dominanz-Übergangsmatrix – {name}")
    plt.colorbar(label="Zeilenanteil")
    plt.tight_layout()
    plt.savefig(outdir / f"{name}_dominanz_matrix.png", dpi=180)
    plt.close(fig)

    best_lag = lag_summary.sort_values("dominanz_match_rate", ascending=False).iloc[0]
    top_pairs = pairs[pairs["dominanz_match"] == 1][["teacher_dominante_dimension", "participant_dominante_dimension"]].value_counts().head(5)
    lines = [
        f"## {name}",
        f"Lehrkraft-Rohwerte: {cohort.get('teacher_raw_n', 0)}; aggregierte Lehrkraft-Ereignisse: {len(cohort.get('teacher_events', []))}; Kopplungspaare: {len(pairs)}.",
        f"Stärkste beobachtete Dominanzkopplung bei Lag {int(best_lag['lag'])}: {best_lag['dominanz_match_rate']:.3f} Dominanz-Match-Rate; Polaritäts-Match-Rate dort: {best_lag['polaritaet_match_rate']:.3f}.",
        "Lag-Zusammenfassung:",
        lag_summary.to_string(index=False),
        "Häufigste direkte Dominanzübernahmen:",
        top_pairs.to_string() if len(top_pairs) else "keine",
        "Interpretation: Eine hohe Match-Rate bedeutet, dass dominante semantische Zustände der Lehrkraft in der Teilnehmersicht wiederkehren. Das ist als funktionale Zustandsvalidierung zu lesen, nicht als sprachstatistische Textähnlichkeit.",
        "",
    ]
    return "\n".join(lines)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("json_file")
    ap.add_argument("--outdir", default="dominanzkopplung_output")
    args = ap.parse_args()
    outdir = Path(args.outdir); outdir.mkdir(parents=True, exist_ok=True)
    data = json.loads(Path(args.json_file).read_text(encoding="utf-8"))
    report = ["# Auswertungspunkt 3 – Dominanzkopplungsanalyse", ""]
    for name, cohort in data.get("cohorts", {}).items():
        report.append(analyze_cohort(name, cohort, outdir))
    (outdir / "dominanzkopplung_report.md").write_text("\n".join(report), encoding="utf-8")
    print(f"Auswertung geschrieben nach: {outdir}")

if __name__ == "__main__":
    main()
