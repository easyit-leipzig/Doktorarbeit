#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.4 Polarität – Python-Analyse/Visualisierung
Liest 6x4_polaritaet_tn.json und erzeugt Textauswertung + Grafiken.
"""

from __future__ import annotations
import json
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

BASE = Path(__file__).resolve().parent
INFILE = BASE / "6x4_polaritaet_tn.json"
OUTDIR = BASE / "output_6x4_polaritaet"
OUTDIR.mkdir(exist_ok=True)


def slope(y):
    if len(y) < 2:
        return 0.0
    x = pd.Series(range(len(y)), dtype=float)
    ys = pd.Series(y, dtype=float)
    return float(((x - x.mean()) * (ys - ys.mean())).sum() / ((x - x.mean()) ** 2).sum()) if ((x - x.mean()) ** 2).sum() else 0.0


def main() -> None:
    data = json.loads(INFILE.read_text(encoding="utf-8"))
    group = pd.DataFrame(data.get("by_group", []))
    gt = pd.DataFrame(data.get("by_group_time", []))
    records = pd.DataFrame(data.get("records", []))

    if group.empty:
        raise SystemExit("Keine Daten in by_group gefunden. Bitte zuerst Export ausführen.")

    # Entwicklungsrichtung je Gruppe über mittleren Polaritätsindex pro Datum
    trends = []
    if not gt.empty:
        gt["datum"] = pd.to_datetime(gt["datum"])
        for gid, sub in gt.sort_values("datum").groupby("gruppe_id"):
            trends.append({
                "gruppe_id": gid,
                "trend_slope": slope(sub["mean_polaritaet_index"].tolist()),
                "start_index": float(sub.iloc[0]["mean_polaritaet_index"]),
                "end_index": float(sub.iloc[-1]["mean_polaritaet_index"]),
                "n_zeitpunkte": int(len(sub)),
            })
    trend = pd.DataFrame(trends)
    summary = group.merge(trend, on="gruppe_id", how="left") if not trend.empty else group
    summary = summary.sort_values("mean_polaritaet_index", ascending=False)

    # Grafiken
    ax = group.sort_values("gruppe_id").plot(x="gruppe_id", y=["anteil_positiv", "anteil_negativ", "anteil_neutral"], kind="bar", figsize=(11, 6))
    ax.set_title("6.x.4 Polarität: Zustandsanteile je Gruppe")
    ax.set_xlabel("Gruppe")
    ax.set_ylabel("Anteil")
    plt.tight_layout()
    plt.savefig(OUTDIR / "6x4_polaritaet_anteile_je_gruppe.png", dpi=300)
    plt.close()

    ax = group.sort_values("gruppe_id").plot(x="gruppe_id", y="mean_polaritaet_index", kind="bar", figsize=(11, 6), legend=False)
    ax.axhline(0, linewidth=1)
    ax.set_title("6.x.4 Polarität: mittlerer Polaritätsindex je Gruppe")
    ax.set_xlabel("Gruppe")
    ax.set_ylabel("mittlerer Polaritätsindex")
    plt.tight_layout()
    plt.savefig(OUTDIR / "6x4_polaritaet_index_je_gruppe.png", dpi=300)
    plt.close()

    if not gt.empty:
        pivot = gt.pivot_table(index="datum", columns="gruppe_id", values="mean_polaritaet_index", aggfunc="mean").sort_index()
        ax = pivot.plot(figsize=(12, 6))
        ax.axhline(0, linewidth=1)
        ax.set_title("6.x.4 Polarität: Entwicklung des Polaritätsindex")
        ax.set_xlabel("Datum")
        ax.set_ylabel("mittlerer Polaritätsindex")
        plt.tight_layout()
        plt.savefig(OUTDIR / "6x4_polaritaet_verlauf_je_gruppe.png", dpi=300)
        plt.close()

    # Textauswertung
    top_pos = summary.head(3)
    top_neg = summary.sort_values("mean_polaritaet_index").head(3)
    developing = summary.sort_values("trend_slope", ascending=False).head(3) if "trend_slope" in summary else pd.DataFrame()
    declining = summary.sort_values("trend_slope", ascending=True).head(3) if "trend_slope" in summary else pd.DataFrame()

    lines = []
    lines.append("# 6.x.4 Polarität – textuelle Auswertung ohne Lehrkraftunterscheidung\n")
    lines.append(f"Datengrundlage: {data['meta'].get('quelle')} mit {data['meta'].get('n_records')} Teilnehmerzuständen.\n")
    lines.append("## Zentrale Kennwerte je Gruppe\n")
    lines.append(summary.to_markdown(index=False))
    lines.append("\n## Interpretation\n")
    lines.append("Positive Zustandsräume werden hier über einen positiven Polaritätsindex bzw. positive Polaritätsklasse rekonstruiert. Negative Zustandsräume entstehen dort, wo negative Anteile hoch sind oder der mittlere Index unter null fällt.\n")
    lines.append("### Gruppen mit stärkster positiver Lage\n")
    for _, r in top_pos.iterrows():
        lines.append(f"- Gruppe {r['gruppe_id']}: mittlerer Index {r['mean_polaritaet_index']:.3f}, positiver Anteil {r['anteil_positiv']:.1%}.")
    lines.append("\n### Gruppen mit kritischster/negativster Lage\n")
    for _, r in top_neg.iterrows():
        lines.append(f"- Gruppe {r['gruppe_id']}: mittlerer Index {r['mean_polaritaet_index']:.3f}, negativer Anteil {r['anteil_negativ']:.1%}.")
    if not developing.empty:
        lines.append("\n### Positive Entwicklungstendenz\n")
        for _, r in developing.iterrows():
            lines.append(f"- Gruppe {r['gruppe_id']}: Trend {r['trend_slope']:.4f}, von {r['start_index']:.3f} zu {r['end_index']:.3f}.")
    if not declining.empty:
        lines.append("\n### Negative Entwicklungstendenz\n")
        for _, r in declining.iterrows():
            lines.append(f"- Gruppe {r['gruppe_id']}: Trend {r['trend_slope']:.4f}, von {r['start_index']:.3f} zu {r['end_index']:.3f}.")

    (OUTDIR / "6x4_polaritaet_auswertung.md").write_text("\n".join(lines), encoding="utf-8")
    summary.to_csv(OUTDIR / "6x4_polaritaet_gruppen_summary.csv", index=False, encoding="utf-8-sig")
    print(f"OK: Auswertung erzeugt in {OUTDIR}")


if __name__ == "__main__":
    main()
