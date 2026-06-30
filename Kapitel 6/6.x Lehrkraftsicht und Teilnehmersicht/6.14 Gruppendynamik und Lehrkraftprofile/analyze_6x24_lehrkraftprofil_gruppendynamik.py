#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.24 Analyse-/Visualisierungsskript Python
Liest 6x24_lehrkraftprofil_gruppendynamik.json und erzeugt:
- CSV-Zusammenfassung je Gruppe
- Textbericht
- Grafiken: Distanzvergleich, Delta, Risiko, Dynamik/Stabilität
"""

from __future__ import annotations

import csv
import json
from pathlib import Path
from statistics import mean
from typing import Any, Dict, List

import matplotlib.pyplot as plt

INPUT_FILE = Path("6x24_lehrkraftprofil_gruppendynamik.json")
OUT_DIR = Path("6x24_lehrkraftprofil_gruppendynamik_output")


def fnum(x: Any, nd: int = 4) -> str:
    try:
        return f"{float(x):.{nd}f}"
    except Exception:
        return "n/a"


def load_payload() -> Dict[str, Any]:
    if not INPUT_FILE.exists():
        raise FileNotFoundError(f"JSON nicht gefunden: {INPUT_FILE.resolve()}")
    return json.loads(INPUT_FILE.read_text(encoding="utf-8"))


def write_csv(summary: List[Dict[str, Any]]) -> None:
    fields = [
        "gruppe_id",
        "n",
        "mean_distance_lk1",
        "mean_distance_other",
        "mean_delta_distance",
        "mean_dynamik",
        "mean_stabilitaet",
        "profile_binding",
        "risk_counts",
    ]
    with (OUT_DIR / "6x24_summary_by_group.csv").open("w", encoding="utf-8-sig", newline="") as fh:
        writer = csv.DictWriter(fh, fieldnames=fields, extrasaction="ignore")
        writer.writeheader()
        for row in summary:
            r = dict(row)
            r["risk_counts"] = json.dumps(r.get("risk_counts", {}), ensure_ascii=False)
            writer.writerow(r)


def bar_chart(labels: List[str], values: List[float], title: str, ylabel: str, filename: str) -> None:
    plt.figure(figsize=(10, 5))
    plt.bar(labels, values)
    plt.title(title)
    plt.xlabel("Gruppe")
    plt.ylabel(ylabel)
    plt.tight_layout()
    plt.savefig(OUT_DIR / filename, dpi=200)
    plt.close()


def grouped_distance_chart(summary: List[Dict[str, Any]]) -> None:
    labels = [str(r["gruppe_id"]) for r in summary]
    x = range(len(labels))
    width = 0.38
    lk1 = [float(r["mean_distance_lk1"]) for r in summary]
    other = [float(r["mean_distance_other"]) for r in summary]

    plt.figure(figsize=(11, 5))
    plt.bar([i - width / 2 for i in x], lk1, width=width, label="Distanz zu LK1")
    plt.bar([i + width / 2 for i in x], other, width=width, label="Distanz zu andere LK")
    plt.xticks(list(x), labels)
    plt.title("6.x.24 Distanzvergleich Gruppe ↔ Lehrkraftprofil")
    plt.xlabel("Gruppe")
    plt.ylabel("mittlere euklidische Distanz")
    plt.legend()
    plt.tight_layout()
    plt.savefig(OUT_DIR / "abb_6x24_01_distanzvergleich_profile.png", dpi=200)
    plt.close()


def scatter_delta_instability(summary: List[Dict[str, Any]]) -> None:
    x = [float(r["mean_delta_distance"]) for r in summary]
    y = [float(r["mean_dynamik"]) + max(0.0, 1.0 - float(r["mean_stabilitaet"])) for r in summary]
    labels = [str(r["gruppe_id"]) for r in summary]

    plt.figure(figsize=(8, 6))
    plt.scatter(x, y)
    for xi, yi, label in zip(x, y, labels):
        plt.annotate(label, (xi, yi), textcoords="offset points", xytext=(5, 5))
    plt.axvline(0, linewidth=1)
    plt.title("6.x.24 Profilbindung und gruppendynamische Instabilität")
    plt.xlabel("ΔDistanz = andere LK - LK1")
    plt.ylabel("Instabilitätsindex = Dynamik + (1 - Stabilität)")
    plt.tight_layout()
    plt.savefig(OUT_DIR / "abb_6x24_04_delta_instabilitaet.png", dpi=200)
    plt.close()


def write_report(payload: Dict[str, Any], summary: List[Dict[str, Any]]) -> None:
    lk1 = payload["profiles"]["lehrkraft_1"]
    other = payload["profiles"]["andere_lehrkraft"]
    rows_sorted = sorted(summary, key=lambda r: float(r.get("mean_delta_distance", 0)), reverse=True)
    high = [r for r in rows_sorted if r.get("risk_counts", {}).get("hoch", 0) > 0]

    lines = []
    lines.append("6.x.24 Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität")
    lines.append("=" * 78)
    lines.append("")
    lines.append("1. Datenbasis")
    lines.append(f"- Profil Lehrkraft 1: n={lk1.get('n')}")
    lines.append(f"- Profil andere Lehrkraft: n={other.get('n')}")
    lines.append(f"- Gruppenzeitpunkte: n={len(payload.get('group_projection_rows', []))}")
    lines.append("")
    lines.append("2. Gruppenzusammenfassung")
    for r in rows_sorted:
        lines.append(
            f"- Gruppe {r['gruppe_id']}: ΔDistanz={fnum(r['mean_delta_distance'])}, "
            f"D(LK1)={fnum(r['mean_distance_lk1'])}, D(andere)={fnum(r['mean_distance_other'])}, "
            f"Dynamik={fnum(r['mean_dynamik'])}, Stabilität={fnum(r['mean_stabilitaet'])}, "
            f"Bindung={r.get('profile_binding')}, Risiko={r.get('risk_counts')}"
        )
    lines.append("")
    lines.append("3. Interpretation")
    lines.append("Ein positives ΔDistanz bedeutet, dass die jeweilige Gruppendynamik näher am Profil von Lehrkraft 1 liegt als am kontrafaktischen Profil anderer Lehrkräfte. Dadurch wird keine reale Wirkung anderer Lehrkräfte behauptet, sondern eine Profilanfälligkeit des Gruppensystems modelliert.")
    if high:
        lines.append("Gruppen mit mindestens einem hohen Risikopunkt: " + ", ".join(str(r["gruppe_id"]) for r in high) + ".")
    else:
        lines.append("In den vorhandenen Gruppendynamikdaten wurde nach der gewählten Heuristik kein hoher Risikopunkt markiert.")
    lines.append("")
    lines.append("4. Methodischer Hinweis")
    lines.append("Da frzk_group_emotion keine vollständigen 7D-Gruppenvektoren enthält, wird ein 7D-Proxy aus affektivem Zustand, Kohärenz, Stabilität und Dynamik gebildet. Sobald echte gruppensemantische 7D-Werte vorliegen, sollte der Proxy durch diese Werte ersetzt werden.")

    (OUT_DIR / "6x24_analysebericht.txt").write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    OUT_DIR.mkdir(exist_ok=True)
    payload = load_payload()
    summary = payload.get("summary_by_group", [])
    if not summary:
        raise RuntimeError("Keine Gruppenzusammenfassung in JSON vorhanden.")

    summary = sorted(summary, key=lambda r: int(r["gruppe_id"]))
    write_csv(summary)
    grouped_distance_chart(summary)
    bar_chart(
        [str(r["gruppe_id"]) for r in summary],
        [float(r["mean_delta_distance"]) for r in summary],
        "6.x.24 ΔDistanz: Profil andere Lehrkraft minus Profil LK1",
        "mittlere ΔDistanz",
        "abb_6x24_02_delta_distanz.png",
    )
    bar_chart(
        [str(r["gruppe_id"]) for r in summary],
        [float(r["mean_dynamik"]) for r in summary],
        "6.x.24 Gruppendynamik nach Gruppe",
        "mittlere Dynamik",
        "abb_6x24_03_gruppendynamik.png",
    )
    scatter_delta_instability(summary)
    write_report(payload, summary)

    print(f"OK: Analyse erzeugt in {OUT_DIR.resolve()}")


if __name__ == "__main__":
    main()
