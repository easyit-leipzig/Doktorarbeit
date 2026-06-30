#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.2 Semantische Dichte – Teilnehmersicht – Python-Analyse/Visualisierung

Liest:
    6x2_semantische_dichte_tn.json

Erzeugt im Ergebnisordner:
    - 6x2_semantische_dichte_tn_auswertung.md
    - CSV-Tabellen
    - PNG-Grafiken: Gruppenvergleich, Zeitreihe, Heatmap, 3D-Projektion, 7D-Profil
"""

from __future__ import annotations

import argparse
import json
import math
import os
from collections import Counter
from pathlib import Path
from typing import Any, Dict, List, Optional

import matplotlib.pyplot as plt
import pandas as pd

DIMENSIONS = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation",
]


def fnum(value: Any) -> Optional[float]:
    if value is None or value == "":
        return None
    try:
        val = float(value)
    except (TypeError, ValueError):
        return None
    if math.isnan(val) or math.isinf(val):
        return None
    return val


def safe_mean(series: pd.Series) -> float:
    s = pd.to_numeric(series, errors="coerce").dropna()
    return float(s.mean()) if len(s) else float("nan")


def load_json(path: str) -> Dict[str, Any]:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def rows_to_dataframe(rows: List[Dict[str, Any]]) -> pd.DataFrame:
    flat_rows: List[Dict[str, Any]] = []
    for r in rows:
        fr = dict(r)
        vec = r.get("vector_7d") or {}
        for dim in DIMENSIONS:
            fr[dim] = fnum(vec.get(dim, r.get(f"x_{dim}")))
        fr["h_T"] = fnum(r.get("h_T", r.get("d_semantisch")))
        fr["zeitpunkt"] = pd.to_datetime(r.get("zeitpunkt_iso") or r.get("zeitpunkt"), errors="coerce")
        fr["datum"] = fr["zeitpunkt"].date().isoformat() if pd.notna(fr["zeitpunkt"]) else None
        flat_rows.append(fr)
    return pd.DataFrame(flat_rows)


def save_group_bar(df: pd.DataFrame, out_dir: Path) -> Optional[str]:
    if df.empty or "gruppe_id" not in df or "h_T" not in df:
        return None
    g = df.groupby("gruppe_id", dropna=True)["h_T"].mean().sort_index()
    if g.empty:
        return None
    plt.figure(figsize=(12, 7), dpi=180)
    g.plot(kind="bar")
    plt.title("6.x.2 Semantische Dichte h(T) nach Gruppe")
    plt.xlabel("Gruppe")
    plt.ylabel("mittlere semantische Dichte h(T)")
    plt.tight_layout()
    path = out_dir / "abb_6x2_01_gruppenvergleich_hT.png"
    plt.savefig(path)
    plt.close()
    return path.name


def save_time_series(df: pd.DataFrame, out_dir: Path) -> Optional[str]:
    if df.empty or "datum" not in df:
        return None
    tmp = df.dropna(subset=["datum", "gruppe_id", "h_T"]).copy()
    if tmp.empty:
        return None
    g = tmp.groupby(["datum", "gruppe_id"], dropna=True)["h_T"].mean().reset_index()
    if g.empty:
        return None
    plt.figure(figsize=(13, 7), dpi=180)
    for gid, part in g.groupby("gruppe_id"):
        part = part.sort_values("datum")
        plt.plot(part["datum"], part["h_T"], marker="o", label=f"Gruppe {gid}")
    plt.title("6.x.2 Verlauf der semantischen Dichte h(T)")
    plt.xlabel("Datum")
    plt.ylabel("mittlere h(T)")
    plt.xticks(rotation=45, ha="right")
    plt.legend(loc="best", fontsize=8)
    plt.tight_layout()
    path = out_dir / "abb_6x2_02_zeitreihe_hT_gruppen.png"
    plt.savefig(path)
    plt.close()
    return path.name


def save_heatmap(df: pd.DataFrame, out_dir: Path) -> Optional[str]:
    if df.empty:
        return None
    pivot = df.groupby("gruppe_id")[DIMENSIONS].mean().sort_index()
    if pivot.empty:
        return None
    plt.figure(figsize=(12, 7), dpi=180)
    plt.imshow(pivot.values, aspect="auto")
    plt.colorbar(label="mittlerer Dimensionswert")
    plt.xticks(range(len(DIMENSIONS)), DIMENSIONS, rotation=45, ha="right")
    plt.yticks(range(len(pivot.index)), [f"Gruppe {g}" for g in pivot.index])
    plt.title("6.x.2 7D-Dichteprofil nach Gruppe")
    plt.tight_layout()
    path = out_dir / "abb_6x2_03_heatmap_7d_gruppenprofil.png"
    plt.savefig(path)
    plt.close()
    return path.name


def save_3d_projection(df: pd.DataFrame, out_dir: Path) -> Optional[str]:
    needed = ["kognition", "sozial", "affektiv", "h_T"]
    if df.empty or any(c not in df for c in needed):
        return None
    tmp = df.dropna(subset=needed).copy()
    if tmp.empty:
        return None
    fig = plt.figure(figsize=(11, 8), dpi=180)
    ax = fig.add_subplot(111, projection="3d")
    sc = ax.scatter(tmp["kognition"], tmp["sozial"], tmp["affektiv"], c=tmp["h_T"], s=30)
    ax.set_title("6.x.2 3D-Projektion des 7D-Teilnehmerraums")
    ax.set_xlabel("Kognition")
    ax.set_ylabel("Sozial")
    ax.set_zlabel("Affektiv")
    fig.colorbar(sc, ax=ax, label="h(T)")
    plt.tight_layout()
    path = out_dir / "abb_6x2_04_3d_projection_kognition_sozial_affektiv.png"
    plt.savefig(path)
    plt.close()
    return path.name


def save_7d_profile(df: pd.DataFrame, out_dir: Path) -> Optional[str]:
    if df.empty:
        return None
    profile = df[DIMENSIONS].mean(numeric_only=True)
    if profile.empty:
        return None
    plt.figure(figsize=(12, 7), dpi=180)
    profile.plot(kind="bar")
    plt.title("6.x.2 Gesamtprofil der sieben FRZK-Dimensionen")
    plt.xlabel("Dimension")
    plt.ylabel("mittlerer Wert")
    plt.xticks(rotation=45, ha="right")
    plt.tight_layout()
    path = out_dir / "abb_6x2_05_gesamtprofil_7d.png"
    plt.savefig(path)
    plt.close()
    return path.name


def write_markdown(payload: Dict[str, Any], df: pd.DataFrame, out_dir: Path, figures: List[str]) -> str:
    meta = payload.get("metadata", {})
    md_path = out_dir / "6x2_semantische_dichte_tn_auswertung.md"

    lines: List[str] = []
    lines.append("# 6.x.2 Semantische Dichte – Teilnehmersicht")
    lines.append("")
    lines.append("## Datengrundlage")
    lines.append(f"- Quelle: `{meta.get('source_table', 'frzk_semantische_dichte_teilnehmer_7d')}`")
    lines.append(f"- Datensätze: {len(df)}")
    lines.append(f"- Dimensionen: {', '.join(meta.get('dimensions', DIMENSIONS))}")
    lines.append(f"- Definition: {meta.get('definition', 'h(T)=||T||_2')}")
    lines.append("")

    if not df.empty:
        n_groups = df["gruppe_id"].nunique(dropna=True) if "gruppe_id" in df else 0
        n_tn = df["teilnehmer_id"].nunique(dropna=True) if "teilnehmer_id" in df else 0
        lines.append("## Kurzbefund")
        lines.append(f"Es wurden {len(df)} Teilnehmerzustände aus {n_groups} Gruppen und {n_tn} Teilnehmenden ausgewertet.")
        lines.append(f"Die mittlere semantische Dichte beträgt {safe_mean(df['h_T']):.4f}.")
        if "dichteklasse" in df:
            counts = Counter(df["dichteklasse"].fillna("ohne Klasse"))
            lines.append("Die Dichteklassen verteilen sich wie folgt: " + ", ".join(f"{k}: {v}" for k, v in counts.items()) + ".")
        lines.append("")

        lines.append("## Gruppenvergleich")
        g = df.groupby("gruppe_id").agg(
            n=("h_T", "count"),
            h_T_mean=("h_T", "mean"),
            h_T_std=("h_T", "std"),
            h_T_min=("h_T", "min"),
            h_T_max=("h_T", "max"),
        ).reset_index().sort_values("h_T_mean", ascending=False)
        g.to_csv(out_dir / "tab_6x2_gruppenvergleich.csv", index=False, encoding="utf-8-sig")
        lines.append(g.to_markdown(index=False, floatfmt=".4f"))
        lines.append("")

        lines.append("## Verdichtungen und Leerstellen")
        high = g.head(3)
        low = g.tail(3).sort_values("h_T_mean")
        lines.append("**Stärkste Verdichtungen:** " + ", ".join(f"Gruppe {int(r.gruppe_id)} (h={r.h_T_mean:.4f})" for r in high.itertuples()) + ".")
        lines.append("**Deutlichste Leerstellen/diffuseste Gruppen:** " + ", ".join(f"Gruppe {int(r.gruppe_id)} (h={r.h_T_mean:.4f})" for r in low.itertuples()) + ".")
        lines.append("")

        lines.append("## 7D-Profil")
        dim_profile = df[DIMENSIONS].mean(numeric_only=True).sort_values(ascending=False)
        dim_profile.to_csv(out_dir / "tab_6x2_7d_gesamtprofil.csv", header=["mean"], encoding="utf-8-sig")
        lines.append(dim_profile.to_frame("mean").to_markdown(floatfmt=".4f"))
        lines.append("")

        lines.append("## Dominanzstruktur")
        if "dominante_dimension" in df:
            dom = df["dominante_dimension"].fillna("unbestimmt").value_counts().reset_index()
            dom.columns = ["dominante_dimension", "anzahl"]
            dom.to_csv(out_dir / "tab_6x2_dominanzstruktur.csv", index=False, encoding="utf-8-sig")
            lines.append(dom.to_markdown(index=False))
        else:
            lines.append("Keine Spalte `dominante_dimension` vorhanden.")
        lines.append("")

        lines.append("## Interpretation für den Abschnitt")
        lines.append(
            "Semantische Dichte wird hier als Stärke des Teilnehmerzustands im sieben-dimensionalen FRZK-Raum gelesen. "
            "Hohe Werte markieren Verdichtungen: Dort bündeln sich kognitive, soziale, affektive, motivationale, methodische, performative und regulatorische Anteile. "
            "Niedrige Werte markieren Leerstellen oder diffuse Zustände: Der Lernraum ist dort weniger klar gebunden und benötigt didaktisch eher Strukturierung, Rückbindung oder Stabilisierung."
        )
        lines.append("")

    lines.append("## Abbildungen")
    for fig in figures:
        lines.append(f"- `{fig}`")
    lines.append("")

    md_path.write_text("\n".join(lines), encoding="utf-8")
    return md_path.name


def main() -> None:
    parser = argparse.ArgumentParser(description="Analyse 6.x.2 Semantische Dichte Teilnehmersicht")
    parser.add_argument("--json", default="6x2_semantische_dichte_tn.json", help="Input-JSON")
    parser.add_argument("--out-dir", default="6x2_semantische_dichte_tn_output", help="Ergebnisordner")
    args = parser.parse_args()

    payload = load_json(args.json)
    rows = payload.get("teilnehmer_zustaende", [])
    df = rows_to_dataframe(rows)

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    df.to_csv(out_dir / "tab_6x2_teilnehmer_zustaende_flat.csv", index=False, encoding="utf-8-sig")

    figures = []
    for maker in [save_group_bar, save_time_series, save_heatmap, save_3d_projection, save_7d_profile]:
        fig = maker(df, out_dir)
        if fig:
            figures.append(fig)

    md = write_markdown(payload, df, out_dir, figures)
    print(f"OK: Auswertung erzeugt in {out_dir.resolve()}")
    print(f"Markdown: {md}")
    if figures:
        print("Abbildungen:")
        for f in figures:
            print(f"- {f}")


if __name__ == "__main__":
    main()
