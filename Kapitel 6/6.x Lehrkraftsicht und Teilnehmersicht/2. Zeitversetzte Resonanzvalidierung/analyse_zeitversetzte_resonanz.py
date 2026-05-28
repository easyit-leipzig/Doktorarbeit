#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Auswertungspunkt 2: Zeitversetzte Resonanzvalidierung – Analyse/Visualisierung

Liest zeitversetzte_resonanzvalidierung_export.json und erzeugt:
- CSV-Zusammenfassung
- Markdown-Auswertungsbericht
- PNG-Grafiken für Kosinus, Distanz und Korrelation je Lag/Sicht
"""

from __future__ import annotations

import csv
import json
import math
import statistics
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

import matplotlib.pyplot as plt

INPUT_FILE = Path("zeitversetzte_resonanzvalidierung_export.json")
OUT_DIR = Path("zeitversetzte_resonanzvalidierung_output")


def clean(values: Iterable[Optional[float]]) -> List[float]:
    return [float(v) for v in values if v is not None and not math.isnan(float(v))]


def mean(values: Iterable[Optional[float]]) -> Optional[float]:
    c = clean(values)
    return statistics.mean(c) if c else None


def stdev(values: Iterable[Optional[float]]) -> Optional[float]:
    c = clean(values)
    return statistics.stdev(c) if len(c) >= 2 else None


def fmt(value: Optional[float]) -> str:
    return "—" if value is None else f"{value:.4f}"


def summarize_scope(scope_name: str, scope: Dict[str, Any]) -> List[Dict[str, Any]]:
    rows = []
    for lag, s in scope["summary_by_lag"].items():
        rows.append({
            "scope": scope_name,
            "lag_sitzungen": int(lag),
            "n_matches": s["n_matches"],
            "kosinus_mean": s["kosinus_mean"],
            "kosinus_median": s["kosinus_median"],
            "distanz_mean": s["distanz_mean"],
            "distanz_median": s["distanz_median"],
            "korrelation_mean": s["korrelation_mean"],
            "korrelation_median": s["korrelation_median"],
        })
    return rows


def plot_metric(rows: List[Dict[str, Any]], metric: str, ylabel: str, filename: str) -> None:
    scopes = sorted({r["scope"] for r in rows})
    lags = sorted({r["lag_sitzungen"] for r in rows})
    width = 0.22
    x = list(range(len(lags)))
    fig, ax = plt.subplots(figsize=(9, 5))
    for i, scope in enumerate(scopes):
        vals = []
        for lag in lags:
            row = next((r for r in rows if r["scope"] == scope and r["lag_sitzungen"] == lag), None)
            vals.append(row.get(metric) if row else None)
        xpos = [p + (i - (len(scopes)-1)/2)*width for p in x]
        ax.bar(xpos, [v if v is not None else 0 for v in vals], width=width, label=scope)
    ax.set_title(f"Zeitversetzte Resonanzvalidierung – {ylabel}")
    ax.set_xlabel("Lag in Folgesitzungen")
    ax.set_ylabel(ylabel)
    ax.set_xticks(x)
    ax.set_xticklabels([str(l) for l in lags])
    ax.legend()
    ax.grid(axis="y", alpha=0.25)
    fig.tight_layout()
    fig.savefig(OUT_DIR / filename, dpi=180)
    plt.close(fig)


def write_csv(rows: List[Dict[str, Any]]) -> None:
    path = OUT_DIR / "summary_by_lag.csv"
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def interpretation(rows: List[Dict[str, Any]]) -> str:
    lines = []
    best = max([r for r in rows if r["kosinus_mean"] is not None], key=lambda r: r["kosinus_mean"], default=None)
    if best:
        lines.append(f"Die stärkste mittlere Richtungsresonanz liegt in `{best['scope']}` bei Lag n={best['lag_sitzungen']} mit Kosinus={fmt(best['kosinus_mean'])}.")
    closest = min([r for r in rows if r["distanz_mean"] is not None], key=lambda r: r["distanz_mean"], default=None)
    if closest:
        lines.append(f"Die geringste mittlere euklidische Distanz liegt in `{closest['scope']}` bei Lag n={closest['lag_sitzungen']} mit Distanz={fmt(closest['distanz_mean'])}.")
    corr = max([r for r in rows if r["korrelation_mean"] is not None], key=lambda r: r["korrelation_mean"], default=None)
    if corr:
        lines.append(f"Die stärkste dimensionsbezogene Korrelation liegt in `{corr['scope']}` bei Lag n={corr['lag_sitzungen']} mit r={fmt(corr['korrelation_mean'])}.")
    lines.append("Interpretativ ist besonders relevant, ob Lag n=1, n=2 oder n=3 systematisch höhere Kosinuswerte und niedrigere Distanzen aufweist. Dann würde nicht nur Gleichzeitigkeit, sondern zeitversetzte pädagogische Kopplung sichtbar.")
    return "\n\n".join(lines)


def write_report(payload: Dict[str, Any], rows: List[Dict[str, Any]]) -> None:
    lines = [
        "# Auswertungspunkt 2 – Zeitversetzte Resonanzvalidierung",
        "",
        "## Methodischer Kern",
        "Verglichen wird der Lehrkraftzustand L_t mit dem späteren Teilnehmerzustand T_{t+n}. n bezeichnet reale Folgesitzungen innerhalb derselben Gruppe und desselben Teilnehmers, nicht Kalendertage.",
        "",
        "## Ergebnisübersicht",
        "| Sicht | Lag | n | Kosinus Mittel | Distanz Mittel | Korrelation Mittel |",
        "|---|---:|---:|---:|---:|---:|",
    ]
    for r in rows:
        lines.append(f"| {r['scope']} | {r['lag_sitzungen']} | {r['n_matches']} | {fmt(r['kosinus_mean'])} | {fmt(r['distanz_mean'])} | {fmt(r['korrelation_mean'])} |")
    lines += ["", "## Automatische Interpretation", interpretation(rows), "", "## Erzeugte Dateien", "- summary_by_lag.csv", "- kosinus_by_lag.png", "- distanz_by_lag.png", "- korrelation_by_lag.png"]
    (OUT_DIR / "bericht_zeitversetzte_resonanzvalidierung.md").write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    OUT_DIR.mkdir(exist_ok=True)
    payload = json.loads(INPUT_FILE.read_text(encoding="utf-8"))
    rows: List[Dict[str, Any]] = []
    for scope_name, scope in payload["scopes"].items():
        rows.extend(summarize_scope(scope_name, scope))
    if not rows:
        raise SystemExit("Keine auswertbaren Matches in der JSON-Datei.")
    write_csv(rows)
    plot_metric(rows, "kosinus_mean", "mittlere Kosinusähnlichkeit", "kosinus_by_lag.png")
    plot_metric(rows, "distanz_mean", "mittlere euklidische Distanz", "distanz_by_lag.png")
    plot_metric(rows, "korrelation_mean", "mittlere Pearson-Korrelation", "korrelation_by_lag.png")
    write_report(payload, rows)
    print(f"Analyse abgeschlossen: {OUT_DIR.resolve()}")


if __name__ == "__main__":
    main()
