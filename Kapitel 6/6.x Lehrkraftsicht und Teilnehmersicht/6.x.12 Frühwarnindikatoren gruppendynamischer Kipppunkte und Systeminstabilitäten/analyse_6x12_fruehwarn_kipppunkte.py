#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten
Analyse-/Visualisierungsskript Python

Liest 6x12_fruehwarn_kipppunkte.json und erzeugt:
- CSV Tabellen
- PNG Grafiken
- TXT Kurzbericht
"""

from __future__ import annotations

import json
import math
from pathlib import Path
from typing import Dict, List, Any

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

INFILE = Path("6x12_fruehwarn_kipppunkte.json")
OUTDIR = Path("6x12_fruehwarn_kipppunkte_output")
DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]


def safe_z(series: pd.Series) -> pd.Series:
    s = pd.to_numeric(series, errors="coerce")
    std = s.std(ddof=0)
    if pd.isna(std) or std == 0:
        return pd.Series(np.zeros(len(s)), index=s.index)
    return (s - s.mean()) / std


def dominant_dimension(row: pd.Series) -> str:
    vals = {d: abs(float(row.get(f"mean_{d}", 0) or 0)) for d in DIMENSIONS}
    return max(vals, key=vals.get) if vals else ""


def prepare_scope(payload: Dict[str, Any], scope: str) -> pd.DataFrame:
    data = payload["scopes"][scope]
    lk = pd.DataFrame(data.get("lehrkraft_daily", []))
    if lk.empty:
        return lk
    lk["datum"] = pd.to_datetime(lk["datum"])
    lk = lk.sort_values(["gruppe_id", "datum"]).reset_index(drop=True)

    # Grundmetriken
    lk["varianzlast"] = lk[[f"var_{d}" for d in DIMENSIONS if f"var_{d}" in lk.columns]].mean(axis=1)
    lk["dominante_dimension_calc"] = lk.apply(dominant_dimension, axis=1)

    # Drift und Dominanzwechsel pro Gruppe
    drift_values = []
    dom_changes = []
    for _, g in lk.groupby("gruppe_id", sort=False):
        prev_vec = None
        prev_dom = None
        for idx, row in g.iterrows():
            vec = np.array([float(row.get(f"mean_{d}", 0) or 0) for d in DIMENSIONS], dtype=float)
            if prev_vec is None:
                drift_values.append((idx, 0.0))
                dom_changes.append((idx, 0))
            else:
                drift_values.append((idx, float(np.linalg.norm(vec - prev_vec))))
                dom_changes.append((idx, int(row["dominante_dimension_calc"] != prev_dom)))
            prev_vec = vec
            prev_dom = row["dominante_dimension_calc"]
    lk["drift"] = pd.Series(dict(drift_values))
    lk["dominanzwechsel"] = pd.Series(dict(dom_changes))

    # Optional: Gruppendynamik/Emotionen mergen
    ge = pd.DataFrame(data.get("group_emotion", []))
    if not ge.empty:
        ge["datum"] = pd.to_datetime(ge["zeitpunkt"])
        ge_small = ge[["gruppe_id", "datum", "z_affektiv", "kohaerenz", "stabilitaet", "dynamik"]].copy()
        lk = lk.merge(ge_small, on=["gruppe_id", "datum"], how="left")
    else:
        for c in ["z_affektiv", "kohaerenz", "stabilitaet", "dynamik"]:
            lk[c] = np.nan

    # Optional: Teilnehmersicht mergen
    tn = pd.DataFrame(data.get("teilnehmer_daily", []))
    if not tn.empty:
        tn["datum"] = pd.to_datetime(tn["datum"])
        lk = lk.merge(tn, on=["gruppe_id", "datum"], how="left")

    # Risikoindex: robust, auch wenn optionale Felder fehlen
    lk["polaritaet_negativ"] = -pd.to_numeric(lk.get("polaritaet_index", 0), errors="coerce").fillna(0)
    lk["kohaerenzverlust"] = -pd.to_numeric(lk.get("kohaerenz", np.nan), errors="coerce")
    lk["instabilitaet_group"] = (
        safe_z(lk.get("dynamik", pd.Series(np.zeros(len(lk)))).fillna(0))
        + safe_z(-lk.get("stabilitaet", pd.Series(np.zeros(len(lk)))).fillna(0))
        + safe_z(lk.get("z_affektiv", pd.Series(np.zeros(len(lk)))).fillna(0))
    ) / 3.0

    lk["risiko_score"] = (
        0.25 * safe_z(lk["drift"]) +
        0.15 * safe_z(lk["varianzlast"]) +
        0.15 * safe_z(lk["d_semantisch_std"]) +
        0.15 * safe_z(lk["semantische_breite"]) +
        0.10 * safe_z(lk["polaritaet_negativ"]) +
        0.10 * lk["dominanzwechsel"].fillna(0) +
        0.10 * lk["instabilitaet_group"].fillna(0)
    )

    # Klassifikation nach Perzentilen innerhalb des Scopes
    q70 = lk["risiko_score"].quantile(0.70)
    q85 = lk["risiko_score"].quantile(0.85)
    def risk_label(x: float) -> str:
        if x >= q85:
            return "hoch"
        if x >= q70:
            return "latent"
        return "niedrig"
    lk["risiko_klasse"] = lk["risiko_score"].apply(risk_label)

    return lk


def plot_scope(df: pd.DataFrame, scope: str) -> None:
    if df.empty:
        return

    # 1 Risiko-Zeitverlauf je Gruppe
    plt.figure(figsize=(12, 7))
    for gruppe_id, g in df.groupby("gruppe_id"):
        g = g.sort_values("datum")
        plt.plot(g["datum"], g["risiko_score"], marker="o", label=f"Gruppe {gruppe_id}")
    plt.title(f"6.x.12 Frühwarn-Risikoindex nach Gruppe ({scope})")
    plt.xlabel("Datum")
    plt.ylabel("Risiko-Score (z-standardisiert, gewichtet)")
    plt.xticks(rotation=45, ha="right")
    plt.legend(loc="best", fontsize=8)
    plt.tight_layout()
    plt.savefig(OUTDIR / f"abb_6x12_01_risiko_zeitverlauf_{scope}.png", dpi=180)
    plt.close()

    # 2 Gruppensummary
    summary = df.groupby("gruppe_id").agg(
        risiko_mean=("risiko_score", "mean"),
        risiko_max=("risiko_score", "max"),
        drift_mean=("drift", "mean"),
        varianzlast_mean=("varianzlast", "mean"),
        dominanzwechsel_sum=("dominanzwechsel", "sum"),
        hoch_count=("risiko_klasse", lambda s: int((s == "hoch").sum())),
        latent_count=("risiko_klasse", lambda s: int((s == "latent").sum())),
    ).reset_index()

    plt.figure(figsize=(10, 6))
    plt.bar(summary["gruppe_id"].astype(str), summary["risiko_max"])
    plt.title(f"6.x.12 Maximaler Frühwarn-Risikoindex nach Gruppe ({scope})")
    plt.xlabel("Gruppe")
    plt.ylabel("max. Risiko-Score")
    plt.tight_layout()
    plt.savefig(OUTDIR / f"abb_6x12_02_risiko_max_gruppen_{scope}.png", dpi=180)
    plt.close()

    # 3 Drift vs Varianzlast
    plt.figure(figsize=(9, 6))
    plt.scatter(df["drift"], df["varianzlast"])
    for _, r in df.iterrows():
        if r["risiko_klasse"] == "hoch":
            plt.annotate(str(r["gruppe_id"]), (r["drift"], r["varianzlast"]), fontsize=8)
    plt.title(f"6.x.12 Drift-Varianz-Feld ({scope})")
    plt.xlabel("Drift")
    plt.ylabel("Varianzlast")
    plt.tight_layout()
    plt.savefig(OUTDIR / f"abb_6x12_03_drift_varianz_feld_{scope}.png", dpi=180)
    plt.close()


def write_report(scope_frames: Dict[str, pd.DataFrame]) -> None:
    lines: List[str] = []
    lines.append("6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten")
    lines.append("=" * 88)
    lines.append("")
    lines.append("Methodik: Der Risikoindex kombiniert Drift, Varianzlast, semantische Breite, Dichte-Streuung, Polaritätsbelastung, Dominanzwechsel sowie – falls vorhanden – gruppendynamische Emotions-/Stabilitätswerte.")
    lines.append("")

    for scope, df in scope_frames.items():
        lines.append(f"Scope: {scope}")
        lines.append("-" * (7 + len(scope)))
        if df.empty:
            lines.append("Keine Daten gefunden.")
            lines.append("")
            continue
        summary = df.groupby("gruppe_id").agg(
            n=("risiko_score", "size"),
            risiko_mean=("risiko_score", "mean"),
            risiko_max=("risiko_score", "max"),
            drift_mean=("drift", "mean"),
            varianzlast_mean=("varianzlast", "mean"),
            dominanzwechsel_sum=("dominanzwechsel", "sum"),
            hoch_count=("risiko_klasse", lambda s: int((s == "hoch").sum())),
            latent_count=("risiko_klasse", lambda s: int((s == "latent").sum())),
        ).reset_index().sort_values(["risiko_max", "risiko_mean"], ascending=False)
        top = summary.head(5)
        lines.append(top.to_string(index=False))
        lines.append("")
        high_events = df[df["risiko_klasse"].isin(["hoch", "latent"])].sort_values(["risiko_score"], ascending=False).head(12)
        lines.append("Auffällige Einzelzeitpunkte:")
        if high_events.empty:
            lines.append("Keine auffälligen Zeitpunkte nach Perzentilklassifikation.")
        else:
            cols = ["gruppe_id", "datum", "risiko_score", "risiko_klasse", "drift", "varianzlast", "dominanzwechsel", "semantische_breite", "d_semantisch_std"]
            lines.append(high_events[cols].to_string(index=False))
        lines.append("")

    (OUTDIR / "bericht_6x12_fruehwarn_kipppunkte.txt").write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    OUTDIR.mkdir(exist_ok=True)
    payload = json.loads(INFILE.read_text(encoding="utf-8"))
    scope_frames: Dict[str, pd.DataFrame] = {}

    for scope in payload.get("scopes", {}).keys():
        df = prepare_scope(payload, scope)
        scope_frames[scope] = df
        if not df.empty:
            df.to_csv(OUTDIR / f"daten_6x12_fruehwarn_{scope}.csv", index=False, encoding="utf-8-sig")
            group_summary = df.groupby("gruppe_id").agg(
                n=("risiko_score", "size"),
                risiko_mean=("risiko_score", "mean"),
                risiko_max=("risiko_score", "max"),
                drift_mean=("drift", "mean"),
                varianzlast_mean=("varianzlast", "mean"),
                dominanzwechsel_sum=("dominanzwechsel", "sum"),
                hoch_count=("risiko_klasse", lambda s: int((s == "hoch").sum())),
                latent_count=("risiko_klasse", lambda s: int((s == "latent").sum())),
            ).reset_index()
            group_summary.to_csv(OUTDIR / f"gruppenuebersicht_6x12_{scope}.csv", index=False, encoding="utf-8-sig")
            plot_scope(df, scope)

    write_report(scope_frames)
    print(f"OK: Auswertung erzeugt in {OUTDIR.resolve()}")


if __name__ == "__main__":
    main()
