#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.3 Dominanzstrukturen Teilnehmersicht – Python-Analyse/Visualisierung
Liest 6x3_dominanzstrukturen_tn.json und erzeugt Text- und PNG-Auswertungen.
"""

from __future__ import annotations

import json
from collections import Counter
from pathlib import Path
from typing import Any, Dict, List

try:
    import pandas as pd
except ImportError as exc:
    raise SystemExit("Bitte installieren: pip install pandas") from exc

try:
    import matplotlib.pyplot as plt
except ImportError as exc:
    raise SystemExit("Bitte installieren: pip install matplotlib") from exc

BASE_DIR = Path(__file__).resolve().parent
INPUT_FILE = BASE_DIR / "6x3_dominanzstrukturen_tn.json"
OUTPUT_DIR = BASE_DIR / "6x3_dominanzstrukturen_tn_analyse"
OUTPUT_DIR.mkdir(exist_ok=True)

DIM_ORDER = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]


def load_data() -> Dict[str, Any]:
    if not INPUT_FILE.exists():
        raise SystemExit(f"JSON-Datei nicht gefunden: {INPUT_FILE}. Bitte zuerst Export-Skript ausführen.")
    return json.loads(INPUT_FILE.read_text(encoding="utf-8"))


def records_to_df(data: Dict[str, Any]) -> pd.DataFrame:
    records = data.get("records", [])
    if not records:
        raise SystemExit("JSON enthält keine records.")
    flat = []
    for r in records:
        row = {k: v for k, v in r.items() if k != "dimensionen"}
        for d, v in (r.get("dimensionen") or {}).items():
            row[f"x_{d}"] = v
        flat.append(row)
    df = pd.DataFrame(flat)
    if "zeitpunkt" in df.columns:
        df["zeitpunkt"] = pd.to_datetime(df["zeitpunkt"], errors="coerce")
    return df


def save_bar(series: pd.Series, title: str, ylabel: str, filename: str) -> None:
    fig, ax = plt.subplots(figsize=(10, 6))
    series.plot(kind="bar", ax=ax)
    ax.set_title(title)
    ax.set_xlabel("")
    ax.set_ylabel(ylabel)
    fig.tight_layout()
    fig.savefig(OUTPUT_DIR / filename, dpi=200)
    plt.close(fig)


def save_group_heatmap(df: pd.DataFrame) -> None:
    if "gruppe_id" not in df.columns or df.empty:
        return
    pivot = pd.crosstab(df["gruppe_id"], df["dominante_dimension"], normalize="index")
    for d in DIM_ORDER:
        if d not in pivot.columns:
            pivot[d] = 0.0
    pivot = pivot[DIM_ORDER]

    fig, ax = plt.subplots(figsize=(10, 6))
    im = ax.imshow(pivot.values, aspect="auto")
    ax.set_title("Dominanzanteile je Gruppe")
    ax.set_xlabel("Dominante Dimension")
    ax.set_ylabel("Gruppe")
    ax.set_xticks(range(len(pivot.columns)))
    ax.set_xticklabels(pivot.columns, rotation=45, ha="right")
    ax.set_yticks(range(len(pivot.index)))
    ax.set_yticklabels(pivot.index)
    fig.colorbar(im, ax=ax, label="Anteil")
    fig.tight_layout()
    fig.savefig(OUTPUT_DIR / "6x3_dominanzanteile_je_gruppe_heatmap.png", dpi=200)
    plt.close(fig)


def save_timeline(df: pd.DataFrame) -> None:
    if "zeitpunkt" not in df.columns or df["zeitpunkt"].isna().all():
        return
    tmp = df.dropna(subset=["zeitpunkt"]).copy()
    tmp["datum"] = tmp["zeitpunkt"].dt.date.astype(str)
    pivot = pd.crosstab(tmp["datum"], tmp["dominante_dimension"], normalize="index")
    for d in DIM_ORDER:
        if d not in pivot.columns:
            pivot[d] = 0.0
    pivot = pivot[DIM_ORDER]

    fig, ax = plt.subplots(figsize=(12, 6))
    pivot.plot(ax=ax)
    ax.set_title("Zeitlicher Verlauf der Dominanzanteile")
    ax.set_xlabel("Datum")
    ax.set_ylabel("Anteil")
    ax.legend(title="Dimension", bbox_to_anchor=(1.02, 1), loc="upper left")
    fig.tight_layout()
    fig.savefig(OUTPUT_DIR / "6x3_dominanzanteile_zeitverlauf.png", dpi=200)
    plt.close(fig)


def interpretation_lines(df: pd.DataFrame, data: Dict[str, Any]) -> List[str]:
    summary = data.get("summary", {})
    counts = Counter(df["dominante_dimension"].fillna("unbestimmt"))
    total = len(df)
    top = counts.most_common(1)[0] if counts else (None, 0)

    lines = []
    lines.append("6.x.3 Dominanzstrukturen – Teilnehmersicht")
    lines.append("================================================")
    lines.append("")
    lines.append(f"Datengrundlage: {summary.get('n_zustaende', total)} Teilnehmerzustände aus frzk_semantische_dichte_teilnehmer_7d.")
    lines.append(f"Teilnehmer: {summary.get('n_teilnehmer')} | Gruppen: {summary.get('n_gruppen')} | Lehrkraftunterscheidung: nein.")
    lines.append("")
    lines.append("1. Gesamtverteilung der dominanten Dimensionen")
    for dim in DIM_ORDER:
        n = counts.get(dim, 0)
        lines.append(f"   - {dim}: {n} Zustände ({(n / total * 100) if total else 0:.1f} %)")
    if top[0]:
        lines.append(f"   Hauptbefund: Die häufigste Dominanzdimension ist '{top[0]}' mit {top[1]} Zuständen.")
    lines.append("")

    dom_mean = pd.to_numeric(df.get("dominanz_abs"), errors="coerce").mean()
    dom_std = pd.to_numeric(df.get("dominanz_abs"), errors="coerce").std(ddof=0)
    gap_mean = pd.to_numeric(df.get("dominanz_luecke_zur_zweiten_dimension"), errors="coerce").mean()
    lines.append("2. Stärke der Dominanz")
    lines.append(f"   - Mittlere absolute Dominanz: {dom_mean:.4f}" if pd.notna(dom_mean) else "   - Mittlere absolute Dominanz: nicht berechenbar")
    lines.append(f"   - Streuung der Dominanz: {dom_std:.4f}" if pd.notna(dom_std) else "   - Streuung der Dominanz: nicht berechenbar")
    lines.append(f"   - Mittlere Lücke zur zweitstärksten Dimension: {gap_mean:.4f}" if pd.notna(gap_mean) else "   - Mittlere Lücke zur zweitstärksten Dimension: nicht berechenbar")
    lines.append("   Interpretation: Eine große Lücke zeigt klar profilierte Zustände; eine kleine Lücke spricht für diffuse oder mehrdimensionale Zustände.")
    lines.append("")

    if "gruppe_id" in df.columns:
        lines.append("3. Gruppenbezogene Dominanzmuster")
        group_top = []
        for gid, gdf in df.groupby("gruppe_id"):
            c = Counter(gdf["dominante_dimension"].fillna("unbestimmt"))
            if c:
                d, n = c.most_common(1)[0]
                group_top.append((gid, d, n, len(gdf)))
        for gid, d, n, size in sorted(group_top, key=lambda x: x[0]):
            lines.append(f"   - Gruppe {gid}: häufigste Dominanz '{d}' ({n}/{size}; {n/size*100:.1f} %)")
        lines.append("")

    if "dominanzwechsel" in df.columns:
        wechsel = pd.to_numeric(df["dominanzwechsel"], errors="coerce").fillna(0).sum()
        lines.append("4. Dominanzwechsel")
        lines.append(f"   - Dominanzwechsel gesamt: {int(wechsel)}")
        lines.append(f"   - Anteil bezogen auf alle Zustände: {(wechsel / total * 100) if total else 0:.1f} %")
        lines.append("   Interpretation: Häufige Dominanzwechsel deuten auf dynamische, möglicherweise instabile oder suchende Lernzustände hin.")
        lines.append("")

    lines.append("5. Bezug zu den Leitfragen")
    lines.append("   - Kognitive Dominanz: hoher Anteil 'kognition' spricht für erkenntnis- und verstehensorientierte Lernzustände.")
    lines.append("   - Affektive Dominanz: hoher Anteil 'affektiv' verweist auf emotionale Färbung, Irritation oder Zustimmung im Lernprozess.")
    lines.append("   - Motivationale Dominanz: hoher Anteil 'motivation' zeigt Zustände, in denen Antrieb, Interesse oder Widerstand strukturprägend werden.")
    lines.append("   - Regulatorische Dominanz: hoher Anteil 'regulation' zeigt Selbststeuerung, Konzentration, Vorbereitung und Ordnung als tragende Dimensionen.")
    lines.append("")
    lines.append("Erzeugte Grafiken:")
    for p in sorted(OUTPUT_DIR.glob("*.png")):
        lines.append(f"   - {p.name}")

    return lines


def main() -> None:
    data = load_data()
    df = records_to_df(data)

    counts = df["dominante_dimension"].value_counts().reindex(DIM_ORDER).fillna(0)
    save_bar(counts, "Häufigkeit dominanter Dimensionen", "Anzahl Zustände", "6x3_dominante_dimensionen_haeufigkeit.png")

    shares = (counts / counts.sum()) if counts.sum() else counts
    save_bar(shares, "Anteile dominanter Dimensionen", "Anteil", "6x3_dominante_dimensionen_anteile.png")

    if "dominanz_abs" in df.columns:
        dom_by_dim = df.groupby("dominante_dimension")["dominanz_abs"].mean().reindex(DIM_ORDER).dropna()
        save_bar(dom_by_dim, "Mittlere Dominanzstärke nach Dimension", "mittlere absolute Dominanz", "6x3_dominanzstaerke_nach_dimension.png")

    save_group_heatmap(df)
    save_timeline(df)

    # CSV für Kontrolle/Weiterverarbeitung
    df.to_csv(OUTPUT_DIR / "6x3_dominanzstrukturen_records.csv", index=False, encoding="utf-8-sig")

    report = "\n".join(interpretation_lines(df, data))
    (OUTPUT_DIR / "6x3_dominanzstrukturen_report.txt").write_text(report, encoding="utf-8")
    print(report)
    print(f"\nAnalyseordner: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
