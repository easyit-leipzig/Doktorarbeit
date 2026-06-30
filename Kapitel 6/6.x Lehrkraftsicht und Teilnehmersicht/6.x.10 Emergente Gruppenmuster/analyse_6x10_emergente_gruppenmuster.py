#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.10 Emergente Gruppenmuster – Analyse-/Visualisierungsskript (Python)
Liest 6x10_emergente_gruppenmuster.json und erzeugt textuelle und grafische Auswertungen.

Ausgaben:
- 6x10_emergente_gruppenmuster_report.md
- 6x10_group_centroids.csv
- PNG-Grafiken im Ordner plots_6x10_emergente_gruppenmuster
"""
from __future__ import annotations

import csv
import json
import math
from pathlib import Path
from typing import Any, Dict, List, Optional

import matplotlib.pyplot as plt

INFILE = Path("6x10_emergente_gruppenmuster.json")
OUTDIR = Path("plots_6x10_emergente_gruppenmuster")
REPORT = Path("6x10_emergente_gruppenmuster_report.md")
CSV_OUT = Path("6x10_group_centroids.csv")


def fnum(x: Optional[float], digits: int = 4) -> str:
    if x is None:
        return "n/a"
    try:
        if not math.isfinite(float(x)):
            return "n/a"
        return f"{float(x):.{digits}f}"
    except Exception:
        return "n/a"


def load_json() -> Dict[str, Any]:
    if not INFILE.exists():
        raise FileNotFoundError(f"{INFILE} nicht gefunden. Bitte zuerst export_6x10_emergente_gruppenmuster.py ausführen.")
    return json.loads(INFILE.read_text(encoding="utf-8"))


def write_centroid_csv(data: Dict[str, Any]) -> None:
    dims = data["meta"]["dimensions"]
    fields = [
        "gruppe_id", "n_records", "n_participants", "date_min", "date_max",
        *dims,
        "dominant_axis", "mean_d_semantisch", "mean_semantische_breite",
        "mean_euclidean_drift", "mean_cosine_transition",
        "mean_pairwise_cosine", "share_cosine_ge_0_95",
        "mean_emotion_valenz", "mean_emotion_aktivierung", "n_emotion_mentions",
    ]
    with CSV_OUT.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=fields, delimiter=";")
        writer.writeheader()
        for gid, g in data["groups"].items():
            row = {
                "gruppe_id": gid,
                "n_records": g.get("n_records"),
                "n_participants": g.get("n_participants"),
                "date_min": g.get("date_min"),
                "date_max": g.get("date_max"),
                "dominant_axis": g.get("dominant_axis"),
                "mean_d_semantisch": g.get("mean_d_semantisch"),
                "mean_semantische_breite": g.get("mean_semantische_breite"),
                "mean_euclidean_drift": g.get("drift_summary", {}).get("mean_euclidean_drift"),
                "mean_cosine_transition": g.get("drift_summary", {}).get("mean_cosine_transition"),
                "mean_pairwise_cosine": g.get("attractor_summary", {}).get("mean_pairwise_cosine_limited_window"),
                "share_cosine_ge_0_95": g.get("attractor_summary", {}).get("share_cosine_ge_0_95"),
                "mean_emotion_valenz": g.get("emotion_summary", {}).get("mean_valenz"),
                "mean_emotion_aktivierung": g.get("emotion_summary", {}).get("mean_aktivierung"),
                "n_emotion_mentions": g.get("emotion_summary", {}).get("n_emotion_mentions"),
            }
            row.update(g.get("centroid_7d", {}))
            writer.writerow(row)


def plot_group_centroid_lines(data: Dict[str, Any]) -> None:
    dims = data["meta"]["dimensions"]
    OUTDIR.mkdir(exist_ok=True)
    for gid, g in data["groups"].items():
        vals = [g["centroid_7d"].get(d, 0.0) for d in dims]
        plt.figure(figsize=(10, 5))
        plt.plot(dims, vals, marker="o")
        plt.xticks(rotation=35, ha="right")
        plt.ylabel("Mittelwert 7D-Zentrum")
        plt.title(f"Abb. 6.x.10-{gid} Gruppenzentrum im FRZK-Raum – Gruppe {gid}")
        plt.tight_layout()
        plt.savefig(OUTDIR / f"abb_6x10_gruppe_{gid}_zentrum_7d.png", dpi=180)
        plt.close()


def plot_summary_bars(data: Dict[str, Any]) -> None:
    groups = sorted(data["groups"].keys(), key=lambda x: int(x))
    drift = [data["groups"][g].get("drift_summary", {}).get("mean_euclidean_drift") or 0 for g in groups]
    attr = [data["groups"][g].get("attractor_summary", {}).get("share_cosine_ge_0_95") or 0 for g in groups]
    val = [data["groups"][g].get("emotion_summary", {}).get("mean_valenz") or 0 for g in groups]

    for values, name, ylabel, filename in [
        (drift, "Mittlere Drift je Gruppe", "Euklidische Drift", "abb_6x10_mittlere_drift_je_gruppe.png"),
        (attr, "Attraktoranteil je Gruppe", "Anteil Kosinus ≥ 0.95", "abb_6x10_attraktoranteil_je_gruppe.png"),
        (val, "Mittlere Emotionsvalenz je Gruppe", "Valenz", "abb_6x10_emotionsvalenz_je_gruppe.png"),
    ]:
        plt.figure(figsize=(9, 5))
        plt.bar(groups, values)
        plt.xlabel("Gruppe")
        plt.ylabel(ylabel)
        plt.title(f"Abb. 6.x.10 – {name}")
        plt.tight_layout()
        plt.savefig(OUTDIR / filename, dpi=180)
        plt.close()


def make_report(data: Dict[str, Any]) -> None:
    lines: List[str] = []
    meta = data["meta"]
    gs = data["global_summary"]
    lines.append(f"# {meta['auswertung']} – Analysebericht")
    lines.append("")
    lines.append("## 1. Datenbasis")
    lines.append(f"Die Auswertung liest `{INFILE.name}`. Die JSON-Datei wurde aus `{meta['source_view']}` und `{meta['source_emotions']}` erzeugt. Eine Lehrkraftunterscheidung findet bewusst nicht statt.")
    lines.append(f"Erfasste Datensätze: **{gs.get('n_records')}**, Gruppen: **{gs.get('n_groups')}**.")
    lines.append("")
    lines.append("## 2. Globale Struktur")
    lines.append("Das globale FRZK-Zentrum lautet:")
    lines.append("")
    lines.append("| Dimension | Mittelwert |")
    lines.append("|---|---:|")
    for d, v in gs.get("global_centroid_7d", {}).items():
        lines.append(f"| {d} | {fnum(v)} |")
    lines.append("")
    lines.append("## 3. Gruppenprofile")
    lines.append("| Gruppe | n | TN | Zeitraum | Dominanzachse | Dichte | Breite | Drift | Übergangs-Kosinus | Attraktoranteil | Emotionsvalenz | Aktivierung |")
    lines.append("|---:|---:|---:|---|---|---:|---:|---:|---:|---:|---:|---:|")
    for gid, g in sorted(data["groups"].items(), key=lambda kv: int(kv[0])):
        ds = g.get("drift_summary", {})
        ats = g.get("attractor_summary", {})
        es = g.get("emotion_summary", {})
        lines.append(
            f"| {gid} | {g.get('n_records')} | {g.get('n_participants')} | {g.get('date_min')}–{g.get('date_max')} | "
            f"{g.get('dominant_axis')} | {fnum(g.get('mean_d_semantisch'))} | {fnum(g.get('mean_semantische_breite'))} | "
            f"{fnum(ds.get('mean_euclidean_drift'))} | {fnum(ds.get('mean_cosine_transition'))} | "
            f"{fnum(ats.get('share_cosine_ge_0_95'))} | {fnum(es.get('mean_valenz'))} | {fnum(es.get('mean_aktivierung'))} |"
        )
    lines.append("")
    lines.append("## 4. Automatische Interpretation")
    lines.append("Die Analyse prüft emergente Gruppenmuster anhand von vier Indikatorgruppen: wiederkehrende Dominanzachsen, Driftstabilität, kollektive Emotionscluster und gruppenspezifische Attraktoren. Als Attraktorhinweis wird ein hoher Anteil paarweiser Kosinusähnlichkeiten ab 0.95 gewertet. Eine geringe mittlere Drift bei gleichzeitig hoher Übergangsähnlichkeit spricht für stabile Gruppenresonanz; hohe Drift bei negativer oder stark aktivierter Emotionslage spricht für Übergangs- oder Kippphasen.")
    lines.append("")
    for gid, g in sorted(data["groups"].items(), key=lambda kv: int(kv[0])):
        ds = g.get("drift_summary", {})
        ats = g.get("attractor_summary", {})
        es = g.get("emotion_summary", {})
        drift = ds.get("mean_euclidean_drift")
        attr = ats.get("share_cosine_ge_0_95")
        val = es.get("mean_valenz")
        lines.append(f"### Gruppe {gid}")
        lines.append(
            f"Gruppe {gid} zeigt als semantisches Zentrum die Dominanzachse **{g.get('dominant_axis')}**. "
            f"Die mittlere Drift beträgt {fnum(drift)}, der mittlere Übergangs-Kosinus {fnum(ds.get('mean_cosine_transition'))}. "
            f"Der Attraktoranteil liegt bei {fnum(attr)}. Die mittlere Emotionsvalenz beträgt {fnum(val)}, die Aktivierung {fnum(es.get('mean_aktivierung'))}."
        )
        if attr is not None and attr >= 0.7:
            lines.append("Interpretation: Die Gruppe bildet einen deutlich wiederkehrenden semantischen Attraktor aus.")
        elif drift is not None and drift > 0.15:
            lines.append("Interpretation: Die Gruppe befindet sich eher in einer beweglichen Übergangsstruktur als in einem stabilen Attraktorraum.")
        else:
            lines.append("Interpretation: Die Gruppe zeigt eine mittlere Stabilität; emergente Muster sind vorhanden, aber nicht maximal verfestigt.")
        lines.append("")
    lines.append("## 5. Grafiken")
    lines.append(f"Die Grafiken wurden im Ordner `{OUTDIR.name}` erzeugt. Sie umfassen Gruppenzentren, Drift, Attraktoranteile und Emotionsvalenz.")
    REPORT.write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    data = load_json()
    OUTDIR.mkdir(exist_ok=True)
    write_centroid_csv(data)
    plot_group_centroid_lines(data)
    plot_summary_bars(data)
    make_report(data)
    print(f"OK: {REPORT.resolve()} geschrieben")
    print(f"OK: {CSV_OUT.resolve()} geschrieben")
    print(f"OK: Grafiken in {OUTDIR.resolve()}")


if __name__ == "__main__":
    main()
