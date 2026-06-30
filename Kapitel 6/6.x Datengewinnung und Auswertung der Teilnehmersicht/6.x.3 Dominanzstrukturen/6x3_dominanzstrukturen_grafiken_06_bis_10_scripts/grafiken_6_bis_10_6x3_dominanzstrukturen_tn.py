#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.3 Dominanzstrukturen – Grafiken 6 bis 10 (Python)

Erzeugt aus 6x3_dominanzstrukturen_tn.json die folgenden Grafiken:
  06 Heatmap Gruppe × dominante Dimension
  07 Dominanznetzwerk der Dimensionen
  08 Sankey-/Alluvial-Diagramm der Dominanzwechsel
  09 Zeitliche Entwicklung der Dominanzanteile
  10 Boxplot der Dominanzwerte nach Gruppe

Ablage:
  ./6x3_dominanzstrukturen_tn_anlage_grafiken/

Voraussetzungen:
  pip install pandas matplotlib numpy

Aufruf:
  python grafiken_6_bis_10_6x3_dominanzstrukturen_tn.py
  python grafiken_6_bis_10_6x3_dominanzstrukturen_tn.py --input pfad/zur/datei.json --output ausgabeordner
"""

from __future__ import annotations

import argparse
import json
import math
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any, Dict, Iterable, List, Tuple

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, PathPatch
from matplotlib.path import Path

DIM_ORDER = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]


def parse_args() -> argparse.Namespace:
    base_dir = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description="Erzeugt Grafiken 6 bis 10 für 6.x.3 Dominanzstrukturen.")
    parser.add_argument("--input", type=Path, default=base_dir / "6x3_dominanzstrukturen_tn.json")
    parser.add_argument("--output", type=Path, default=base_dir / "6x3_dominanzstrukturen_tn_anlage_grafiken")
    return parser.parse_args()


def load_records(path: Path) -> pd.DataFrame:
    if not path.exists():
        raise SystemExit(f"JSON-Datei nicht gefunden: {path}")
    data = json.loads(path.read_text(encoding="utf-8"))
    records = data.get("records", data if isinstance(data, list) else [])
    if not records:
        raise SystemExit("Keine Datensätze gefunden. Erwartet wird ein JSON mit Schlüssel 'records'.")

    flat: List[Dict[str, Any]] = []
    for r in records:
        row = {k: v for k, v in r.items() if k != "dimensionen"}
        for dim, value in (r.get("dimensionen") or {}).items():
            row[f"x_{dim}"] = value
        flat.append(row)

    df = pd.DataFrame(flat)
    if "zeitpunkt" in df.columns:
        df["zeitpunkt"] = pd.to_datetime(df["zeitpunkt"], errors="coerce")
    if "dominanz_abs" not in df.columns:
        if "dominante_dimension_wert" in df.columns:
            df["dominanz_abs"] = pd.to_numeric(df["dominante_dimension_wert"], errors="coerce").abs()
        else:
            df["dominanz_abs"] = np.nan
    df["dominante_dimension"] = df["dominante_dimension"].astype(str).str.lower().str.strip()
    return df


def savefig(fig: plt.Figure, output: Path, filename: str) -> None:
    output.mkdir(parents=True, exist_ok=True)
    fig.tight_layout()
    fig.savefig(output / filename, dpi=240)
    plt.close(fig)


def grafik_06_heatmap(df: pd.DataFrame, output: Path) -> None:
    """Grafik 06: Heatmap Gruppe × dominante Dimension."""
    if "gruppe_id" not in df.columns:
        return
    pivot = pd.crosstab(df["gruppe_id"], df["dominante_dimension"], normalize="index")
    for dim in DIM_ORDER:
        if dim not in pivot.columns:
            pivot[dim] = 0.0
    pivot = pivot[DIM_ORDER].sort_index()

    fig, ax = plt.subplots(figsize=(11, max(5, 0.45 * len(pivot) + 2)))
    im = ax.imshow(pivot.values, aspect="auto")
    ax.set_title("Grafik 6: Heatmap der Dominanzanteile nach Gruppe")
    ax.set_xlabel("Dominante Dimension")
    ax.set_ylabel("Gruppe")
    ax.set_xticks(range(len(DIM_ORDER)))
    ax.set_xticklabels(DIM_ORDER, rotation=45, ha="right")
    ax.set_yticks(range(len(pivot.index)))
    ax.set_yticklabels([str(x) for x in pivot.index])
    for i in range(pivot.shape[0]):
        for j in range(pivot.shape[1]):
            ax.text(j, i, f"{pivot.values[i, j]*100:.0f}%", ha="center", va="center", fontsize=8)
    fig.colorbar(im, ax=ax, label="Anteil innerhalb der Gruppe")
    savefig(fig, output, "grafik_06_heatmap_gruppe_dimension.png")
    pivot.to_csv(output / "grafik_06_heatmap_gruppe_dimension.csv", encoding="utf-8-sig")


def transition_counts(df: pd.DataFrame) -> Counter:
    """Zählt Dominanzübergänge je Teilnehmer in zeitlicher Reihenfolge."""
    if "teilnehmer_id" not in df.columns or "zeitpunkt" not in df.columns:
        return Counter()
    tmp = df.dropna(subset=["zeitpunkt"]).sort_values(["teilnehmer_id", "zeitpunkt"])
    counts: Counter = Counter()
    for _tid, g in tmp.groupby("teilnehmer_id"):
        dims = [d for d in g["dominante_dimension"].tolist() if d in DIM_ORDER]
        for a, b in zip(dims, dims[1:]):
            counts[(a, b)] += 1
    return counts


def grafik_07_netzwerk(df: pd.DataFrame, output: Path) -> None:
    """Grafik 07: Dominanznetzwerk der Übergänge."""
    counts = transition_counts(df)
    node_counts = Counter(df["dominante_dimension"][df["dominante_dimension"].isin(DIM_ORDER)])
    if not node_counts:
        return

    angles = np.linspace(0, 2 * np.pi, len(DIM_ORDER), endpoint=False)
    pos = {dim: (math.cos(a), math.sin(a)) for dim, a in zip(DIM_ORDER, angles)}
    max_node = max(node_counts.values()) if node_counts else 1
    max_edge = max(counts.values()) if counts else 1

    fig, ax = plt.subplots(figsize=(10, 10))
    ax.set_title("Grafik 7: Dominanznetzwerk der Dimensionsübergänge")
    ax.axis("off")

    for (a, b), n in counts.items():
        if a not in pos or b not in pos:
            continue
        x1, y1 = pos[a]
        x2, y2 = pos[b]
        rad = 0.18 if a != b else 0.35
        if a == b:
            patch = FancyArrowPatch(
                (x1, y1), (x1 + 0.01, y1 + 0.01),
                connectionstyle="arc3,rad=0.8", arrowstyle="-|>",
                mutation_scale=12, linewidth=0.5 + 4 * n / max_edge, alpha=0.45,
            )
        else:
            patch = FancyArrowPatch(
                (x1, y1), (x2, y2),
                connectionstyle=f"arc3,rad={rad}", arrowstyle="-|>",
                mutation_scale=12, linewidth=0.5 + 4 * n / max_edge, alpha=0.35,
            )
        ax.add_patch(patch)

    for dim in DIM_ORDER:
        x, y = pos[dim]
        size = 900 + 2600 * node_counts.get(dim, 0) / max_node
        ax.scatter([x], [y], s=size, zorder=3)
        ax.text(x, y, f"{dim}\n{node_counts.get(dim, 0)}", ha="center", va="center", zorder=4, fontsize=10)

    ax.set_xlim(-1.35, 1.35)
    ax.set_ylim(-1.35, 1.35)
    savefig(fig, output, "grafik_07_dominanznetzwerk.png")

    rows = [{"von": a, "nach": b, "anzahl": n} for (a, b), n in counts.items()]
    pd.DataFrame(rows).to_csv(output / "grafik_07_dominanznetzwerk_edges.csv", index=False, encoding="utf-8-sig")


def draw_sankey_like(ax: plt.Axes, counts: Counter) -> None:
    """Ein einfaches zweistufiges Alluvial-/Sankey-Diagramm ohne Zusatzbibliotheken."""
    left_totals = Counter()
    right_totals = Counter()
    for (a, b), n in counts.items():
        left_totals[a] += n
        right_totals[b] += n
    total = sum(counts.values()) or 1
    spacing = 0.02

    def positions(totals: Counter) -> Dict[str, Tuple[float, float]]:
        y = 1.0
        out = {}
        active = [d for d in DIM_ORDER if totals.get(d, 0) > 0]
        gap_total = spacing * max(0, len(active) - 1)
        scale = (1.0 - gap_total) / total
        for dim in active:
            h = totals[dim] * scale
            out[dim] = (y - h, y)
            y -= h + spacing
        return out

    left_pos = positions(left_totals)
    right_pos = positions(right_totals)
    left_cursor = {d: left_pos[d][0] for d in left_pos}
    right_cursor = {d: right_pos[d][0] for d in right_pos}

    for (a, b), n in sorted(counts.items(), key=lambda item: (DIM_ORDER.index(item[0][0]), DIM_ORDER.index(item[0][1]))):
        if a not in left_pos or b not in right_pos:
            continue
        h = n * ((1.0 - spacing * max(0, len(left_pos) - 1)) / total)
        y0a, y1a = left_cursor[a], left_cursor[a] + h
        y0b, y1b = right_cursor[b], right_cursor[b] + h
        left_cursor[a] += h
        right_cursor[b] += h

        verts = [
            (0.15, y0a), (0.38, y0a), (0.62, y0b), (0.85, y0b),
            (0.85, y1b), (0.62, y1b), (0.38, y1a), (0.15, y1a),
            (0.15, y0a),
        ]
        codes = [
            Path.MOVETO, Path.CURVE4, Path.CURVE4, Path.CURVE4,
            Path.LINETO, Path.CURVE4, Path.CURVE4, Path.CURVE4,
            Path.CLOSEPOLY,
        ]
        ax.add_patch(PathPatch(Path(verts, codes), alpha=0.25, linewidth=0.4))

    for x, totals, pos, title in [(0.08, left_totals, left_pos, "t"), (0.92, right_totals, right_pos, "t+1")]:
        ax.text(x, 1.05, title, ha="center", va="bottom", fontsize=12)
        for dim, (y0, y1) in pos.items():
            ax.add_patch(plt.Rectangle((x - 0.04, y0), 0.08, y1 - y0, alpha=0.75))
            ax.text(x, (y0 + y1) / 2, f"{dim}\n{totals[dim]}", ha="center", va="center", fontsize=8)

    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1.1)
    ax.axis("off")


def grafik_08_sankey(df: pd.DataFrame, output: Path) -> None:
    """Grafik 08: Sankey-/Alluvial-Diagramm der Dominanzwechsel."""
    counts = transition_counts(df)
    if not counts:
        return
    fig, ax = plt.subplots(figsize=(12, 7))
    ax.set_title("Grafik 8: Sankey-Diagramm der Dominanzwechsel")
    draw_sankey_like(ax, counts)
    savefig(fig, output, "grafik_08_sankey_dominanzwechsel.png")

    rows = [{"von": a, "nach": b, "anzahl": n} for (a, b), n in counts.items()]
    pd.DataFrame(rows).to_csv(output / "grafik_08_sankey_dominanzwechsel.csv", index=False, encoding="utf-8-sig")


def grafik_09_zeitverlauf(df: pd.DataFrame, output: Path) -> None:
    """Grafik 09: Zeitliche Entwicklung der Dominanzanteile."""
    if "zeitpunkt" not in df.columns or df["zeitpunkt"].isna().all():
        return
    tmp = df.dropna(subset=["zeitpunkt"]).copy()
    tmp["datum"] = tmp["zeitpunkt"].dt.date.astype(str)
    pivot = pd.crosstab(tmp["datum"], tmp["dominante_dimension"], normalize="index")
    for dim in DIM_ORDER:
        if dim not in pivot.columns:
            pivot[dim] = 0.0
    pivot = pivot[DIM_ORDER]

    fig, ax = plt.subplots(figsize=(13, 7))
    pivot.plot(ax=ax, marker="o")
    ax.set_title("Grafik 9: Zeitliche Entwicklung der Dominanzanteile")
    ax.set_xlabel("Datum")
    ax.set_ylabel("Anteil je Datum")
    ax.legend(title="Dimension", bbox_to_anchor=(1.02, 1), loc="upper left")
    ax.tick_params(axis="x", rotation=45)
    savefig(fig, output, "grafik_09_zeitliche_entwicklung_dominanzanteile.png")
    pivot.to_csv(output / "grafik_09_zeitliche_entwicklung_dominanzanteile.csv", encoding="utf-8-sig")


def grafik_10_boxplot(df: pd.DataFrame, output: Path) -> None:
    """Grafik 10: Boxplot der Dominanzwerte nach Gruppe."""
    if "gruppe_id" not in df.columns or "dominanz_abs" not in df.columns:
        return
    tmp = df.dropna(subset=["gruppe_id", "dominanz_abs"]).copy()
    if tmp.empty:
        return
    groups = sorted(tmp["gruppe_id"].unique())
    values = [tmp.loc[tmp["gruppe_id"] == g, "dominanz_abs"].astype(float).values for g in groups]

    fig, ax = plt.subplots(figsize=(12, 7))
    ax.boxplot(values, labels=[str(g) for g in groups], showmeans=True)
    ax.set_title("Grafik 10: Verteilung der Dominanzwerte nach Gruppe")
    ax.set_xlabel("Gruppe")
    ax.set_ylabel("absolute Dominanzstärke")
    savefig(fig, output, "grafik_10_boxplot_dominanzwerte_nach_gruppe.png")

    summary = tmp.groupby("gruppe_id")["dominanz_abs"].describe()
    summary.to_csv(output / "grafik_10_boxplot_dominanzwerte_nach_gruppe.csv", encoding="utf-8-sig")


def write_index(output: Path) -> None:
    lines = [
        "Grafiken 6 bis 10 – Dominanzstrukturen Teilnehmersicht",
        "======================================================",
        "",
        "06: grafik_06_heatmap_gruppe_dimension.png",
        "07: grafik_07_dominanznetzwerk.png",
        "08: grafik_08_sankey_dominanzwechsel.png",
        "09: grafik_09_zeitliche_entwicklung_dominanzanteile.png",
        "10: grafik_10_boxplot_dominanzwerte_nach_gruppe.png",
        "",
        "Zu jeder Grafik werden, soweit sinnvoll, CSV-Kontrolldaten exportiert.",
    ]
    (output / "README_grafiken_06_bis_10.txt").write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    args = parse_args()
    df = load_records(args.input)
    args.output.mkdir(parents=True, exist_ok=True)

    grafik_06_heatmap(df, args.output)
    grafik_07_netzwerk(df, args.output)
    grafik_08_sankey(df, args.output)
    grafik_09_zeitverlauf(df, args.output)
    grafik_10_boxplot(df, args.output)
    write_index(args.output)

    print(f"Fertig. Ausgabeverzeichnis: {args.output}")
    for p in sorted(args.output.glob("grafik_*.png")):
        print(f"- {p.name}")


if __name__ == "__main__":
    main()
