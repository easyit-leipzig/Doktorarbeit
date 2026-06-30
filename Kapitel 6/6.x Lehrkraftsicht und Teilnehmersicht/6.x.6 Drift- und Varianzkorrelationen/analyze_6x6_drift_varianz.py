#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.6 Drift- und Varianzkorrelationen – Analyse-/Visualisierungsskript (Python)
Liest das JSON aus export_6x6_drift_varianz.py und erzeugt Text, CSV und Grafiken.
"""
from __future__ import annotations

import json
import math
from pathlib import Path
from typing import Dict, List, Any

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

INFILE = Path("6x6_drift_varianz_korrelationen.json")
OUTDIR = Path("6x6_drift_varianz_output")
DIMS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
TN_FIELDS = [
    "mitarbeit", "absprachen", "selbststaendigkeit", "konzentration", "fleiss",
    "lernfortschritt", "beherrscht_thema", "transferdenken", "basiswissen", "vorbereitet",
    "themenauswahl", "materialien", "methodenvielfalt", "individualisierung", "aufforderung", "zielgruppen"
]


def safe_float(x: Any) -> float:
    try:
        if x is None or x == "":
            return np.nan
        return float(x)
    except Exception:
        return np.nan


def parse_emotion_ids(value: Any) -> List[int]:
    if value is None:
        return []
    parts = str(value).replace(";", ",").split(",")
    ids: List[int] = []
    for p in parts:
        p = p.strip()
        if p.isdigit():
            ids.append(int(p))
    return ids


def corr_table(df: pd.DataFrame, targets: List[str], drivers: List[str]) -> pd.DataFrame:
    rows = []
    for d in drivers:
        for t in targets:
            sub = df[[d, t]].dropna()
            if len(sub) >= 3 and sub[d].std(ddof=0) > 0 and sub[t].std(ddof=0) > 0:
                r = sub[d].corr(sub[t], method="pearson")
                rs = sub[d].corr(sub[t], method="spearman")
            else:
                r = np.nan
                rs = np.nan
            rows.append({"driver": d, "target": t, "n": int(len(sub)), "pearson_r": r, "spearman_r": rs})
    return pd.DataFrame(rows).sort_values("pearson_r", key=lambda s: s.abs(), ascending=False)


def main() -> None:
    OUTDIR.mkdir(exist_ok=True)
    payload = json.loads(INFILE.read_text(encoding="utf-8"))
    df = pd.DataFrame(payload["data"])
    if df.empty:
        raise SystemExit("Keine Daten im JSON.")

    emotion_lookup: Dict[int, Dict[str, float]] = {}
    for e in payload.get("emotion_lookup", []):
        try:
            emotion_lookup[int(e["id"])] = {"valenz": safe_float(e.get("valenz")), "aktivierung": safe_float(e.get("aktivierung"))}
        except Exception:
            pass

    for col in TN_FIELDS:
        df[col] = df[col].map(safe_float)
    for dim in DIMS:
        for prefix in ["mean_", "var_", "x_"]:
            col = prefix + dim
            if col in df.columns:
                df[col] = df[col].map(safe_float)
    for col in ["d_semantisch_mean", "d_semantisch_std", "semantische_breite", "dominanz_breite", "d_semantisch", "dominante_dimension_wert", "polaritaet_gesamt"]:
        if col in df.columns:
            df[col] = df[col].map(safe_float)

    df["erfasst_am"] = pd.to_datetime(df["erfasst_am"], errors="coerce")
    df = df.sort_values(["teilnehmer_id", "erfasst_am", "teilnehmer_feedback_id"])

    # Teilnehmerzustand: Skalenrichtung wird vereinheitlicht. Bei den meisten ICAS-Ratings ist 1 positiv;
    # daher wird als Belastungswert score = rating - 1 verwendet. Höhere Werte = höhere Belastung/Instabilität.
    tn_matrix = df[TN_FIELDS].astype(float)
    df["tn_belastung_mean"] = tn_matrix.mean(axis=1)
    df["tn_belastung_std"] = tn_matrix.std(axis=1)
    df["tn_state_norm"] = np.sqrt(np.nansum(np.square(tn_matrix - 1.0), axis=1))

    # Teilnehmerdrift zwischen aufeinanderfolgenden Zuständen desselben Teilnehmers.
    drift_values = []
    for _, g in df.groupby("teilnehmer_id", sort=False):
        arr = (g[TN_FIELDS].astype(float).to_numpy() - 1.0)
        prev = np.vstack([np.full((1, arr.shape[1]), np.nan), arr[:-1]])
        drift = np.sqrt(np.nansum(np.square(arr - prev), axis=1))
        drift[np.isnan(prev).all(axis=1)] = np.nan
        drift_values.extend(drift.tolist())
    df["teilnehmer_drift"] = drift_values

    def emotion_metrics(raw: Any) -> pd.Series:
        ids = parse_emotion_ids(raw)
        vals, acts = [], []
        pos = neg = 0
        for i in ids:
            if i in emotion_lookup:
                v = emotion_lookup[i]["valenz"]
                a = emotion_lookup[i]["aktivierung"]
                if not math.isnan(v):
                    vals.append(v)
                    if v > 0:
                        pos += 1
                    if v < 0:
                        neg += 1
                if not math.isnan(a):
                    acts.append(a)
        amb = min(pos, neg) / max(pos + neg, 1)
        return pd.Series({
            "emotion_count": len(ids),
            "emotion_valenz_mean": np.nanmean(vals) if vals else np.nan,
            "emotion_valenz_std": np.nanstd(vals) if vals else np.nan,
            "emotion_aktivierung_mean": np.nanmean(acts) if acts else np.nan,
            "emotion_ambivalenz": amb,
        })

    df = pd.concat([df, df["emotions"].apply(emotion_metrics)], axis=1)

    var_cols = [f"var_{d}" for d in DIMS]
    df["lehrkraft_varianz_mean"] = df[var_cols].mean(axis=1)
    df["lehrkraft_varianz_max"] = df[var_cols].max(axis=1)
    df["semantische_instabilitaet"] = df[["d_semantisch_std", "semantische_breite", "dominanz_breite"]].astype(float).mean(axis=1)

    # Übergangsindex: z-standardisierte Kombination der zentralen Destabilisierungsindikatoren.
    zcols = ["lehrkraft_varianz_mean", "semantische_breite", "d_semantisch_std", "teilnehmer_drift", "emotion_ambivalenz"]
    zdf = df[zcols].copy()
    for c in zcols:
        sd = zdf[c].std(skipna=True)
        zdf[c] = (zdf[c] - zdf[c].mean(skipna=True)) / sd if sd and sd > 0 else np.nan
    df["uebergangsindex"] = zdf.mean(axis=1)
    cutoff = df["uebergangsindex"].quantile(0.75)
    df["uebergangsphase_flag"] = df["uebergangsindex"] >= cutoff

    drivers = var_cols + ["lehrkraft_varianz_mean", "lehrkraft_varianz_max", "semantische_breite", "d_semantisch_std", "dominanz_breite"]
    targets = ["teilnehmer_drift", "emotion_ambivalenz", "emotion_valenz_std", "semantische_instabilitaet", "tn_belastung_mean", "tn_belastung_std", "uebergangsindex"]
    corrs = corr_table(df, targets, drivers)

    df.to_csv(OUTDIR / "6x6_drift_varianz_analysed_rows.csv", index=False, encoding="utf-8-sig")
    corrs.to_csv(OUTDIR / "6x6_drift_varianz_korrelationen.csv", index=False, encoding="utf-8-sig")

    # Grafiken
    top = corrs.dropna(subset=["pearson_r"]).head(20).copy()
    labels = top["driver"] + " → " + top["target"]
    plt.figure(figsize=(11, 7))
    plt.barh(labels, top["pearson_r"])
    plt.gca().invert_yaxis()
    plt.xlabel("Pearson-r")
    plt.title("6.x.6 stärkste Drift-/Varianzkorrelationen")
    plt.tight_layout()
    plt.savefig(OUTDIR / "plot_top_korrelationen.png", dpi=180)
    plt.close()

    plt.figure(figsize=(8, 6))
    plt.scatter(df["lehrkraft_varianz_mean"], df["teilnehmer_drift"])
    plt.xlabel("mittlere Lehrkraftvarianz")
    plt.ylabel("Teilnehmerdrift")
    plt.title("Lehrkraftvarianz und Teilnehmerdrift")
    plt.tight_layout()
    plt.savefig(OUTDIR / "plot_varianz_vs_drift.png", dpi=180)
    plt.close()

    by_date = df.dropna(subset=["erfasst_am"]).copy()
    by_date["datum"] = by_date["erfasst_am"].dt.date
    t = by_date.groupby("datum", as_index=False)[["lehrkraft_varianz_mean", "teilnehmer_drift", "emotion_ambivalenz", "uebergangsindex"]].mean(numeric_only=True)
    plt.figure(figsize=(11, 5))
    plt.plot(t["datum"], t["lehrkraft_varianz_mean"], label="Lehrkraftvarianz")
    plt.plot(t["datum"], t["teilnehmer_drift"], label="Teilnehmerdrift")
    plt.xticks(rotation=45, ha="right")
    plt.title("Zeitverlauf: Varianz und Drift")
    plt.legend()
    plt.tight_layout()
    plt.savefig(OUTDIR / "plot_zeitverlauf_varianz_drift.png", dpi=180)
    plt.close()

    top_rows = df.sort_values("uebergangsindex", ascending=False).head(15)[[
        "teilnehmer_feedback_id", "teilnehmer_id", "gruppe_id", "erfasst_am",
        "lehrkraft_varianz_mean", "semantische_breite", "d_semantisch_std",
        "teilnehmer_drift", "emotion_ambivalenz", "uebergangsindex", "bemerkungen"
    ]]
    top_rows.to_csv(OUTDIR / "6x6_top_uebergangsphasen.csv", index=False, encoding="utf-8-sig")

    def fmt(x: float) -> str:
        return "n/a" if pd.isna(x) else f"{x:.4f}"

    strongest = corrs.dropna(subset=["pearson_r"]).head(12)
    report = []
    report.append("6.x.6 Drift- und Varianzkorrelationen – automatischer Auswertungsbericht")
    report.append("=" * 78)
    report.append(f"Datensätze: {len(df)}")
    report.append(f"Teilnehmer: {df['teilnehmer_id'].nunique()} | Gruppen: {df['gruppe_id'].nunique()}")
    report.append("")
    report.append("Zentrale Kennwerte")
    report.append(f"Mittlere Lehrkraftvarianz: {fmt(df['lehrkraft_varianz_mean'].mean())}")
    report.append(f"Mittlere Teilnehmerdrift: {fmt(df['teilnehmer_drift'].mean())}")
    report.append(f"Mittlere Emotionsambivalenz: {fmt(df['emotion_ambivalenz'].mean())}")
    report.append(f"Anteil markierter Übergangsphasen oberes Quartil: {df['uebergangsphase_flag'].mean():.2%}")
    report.append("")
    report.append("Stärkste Korrelationen")
    for _, r in strongest.iterrows():
        report.append(f"- {r['driver']} → {r['target']}: Pearson r={fmt(r['pearson_r'])}, Spearman ρ={fmt(r['spearman_r'])}, n={int(r['n'])}")
    report.append("")
    report.append("Interpretationsregel")
    report.append("Positive Korrelationen zwischen Varianzmaßen und Teilnehmerdrift/Emotionsambivalenz sprechen für Destabilisierungs- oder Übergangsprozesse; negative Korrelationen sprechen für Dämpfung bzw. Stabilisierung.")
    (OUTDIR / "6x6_bericht.txt").write_text("\n".join(report), encoding="utf-8")
    print(f"OK: Auswertung in {OUTDIR.resolve()} geschrieben.")


if __name__ == "__main__":
    main()
