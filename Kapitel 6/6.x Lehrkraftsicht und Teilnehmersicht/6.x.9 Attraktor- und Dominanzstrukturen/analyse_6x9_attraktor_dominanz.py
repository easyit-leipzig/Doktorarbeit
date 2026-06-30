#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
6.x.9 Attraktor- und Dominanzstrukturen – Analyse-/Visualisierungsskript Python
Liest 6x9_attraktor_dominanzstrukturen.json und erzeugt Text, CSV und PNG-Grafiken.
"""
from __future__ import annotations

import json
from pathlib import Path
from typing import List

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

JSON_FILE = Path("6x9_attraktor_dominanzstrukturen.json")
OUTDIR = Path("6x9_attraktor_dominanzstrukturen_output")
DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
XCOLS = [f"x_{d}" for d in DIMENSIONS]


def ensure_numeric(df: pd.DataFrame, cols: List[str]) -> pd.DataFrame:
    for c in cols:
        if c in df.columns:
            df[c] = pd.to_numeric(df[c], errors="coerce")
    return df


def cosine_matrix(vectors: np.ndarray) -> np.ndarray:
    if len(vectors) == 0:
        return np.empty((0, 0))
    norms = np.linalg.norm(vectors, axis=1, keepdims=True)
    norms[norms == 0] = np.nan
    unit = vectors / norms
    return np.nan_to_num(unit @ unit.T, nan=0.0)


def pca_2d(x: np.ndarray) -> np.ndarray:
    x = np.nan_to_num(x.astype(float))
    if len(x) < 2:
        return np.zeros((len(x), 2))
    x0 = x - x.mean(axis=0, keepdims=True)
    _, _, vt = np.linalg.svd(x0, full_matrices=False)
    comp = x0 @ vt[:2].T
    if comp.shape[1] == 1:
        comp = np.c_[comp, np.zeros(len(comp))]
    return comp


def save_bar(series: pd.Series, title: str, ylabel: str, filename: str) -> None:
    plt.figure(figsize=(10, 5))
    series.plot(kind="bar")
    plt.title(title)
    plt.ylabel(ylabel)
    plt.xlabel("")
    plt.tight_layout()
    plt.savefig(OUTDIR / filename, dpi=180)
    plt.close()


def save_heatmap(data: pd.DataFrame, title: str, filename: str) -> None:
    plt.figure(figsize=(9, 7))
    plt.imshow(data.values, aspect="auto")
    plt.xticks(range(len(data.columns)), data.columns, rotation=45, ha="right")
    plt.yticks(range(len(data.index)), data.index)
    plt.title(title)
    plt.colorbar()
    plt.tight_layout()
    plt.savefig(OUTDIR / filename, dpi=180)
    plt.close()


def main() -> None:
    OUTDIR.mkdir(exist_ok=True)
    payload = json.loads(JSON_FILE.read_text(encoding="utf-8"))
    df = pd.DataFrame(payload.get("records", []))
    if df.empty:
        raise SystemExit("Keine Datensätze im JSON gefunden.")

    numeric_cols = XCOLS + [
        "dominante_dimension_wert", "polaritaet_gesamt", "d_semantisch", "token_anzahl",
        "mitarbeit", "absprachen", "selbststaendigkeit", "konzentration", "fleiss",
        "lernfortschritt", "beherrscht_thema", "transferdenken", "basiswissen", "vorbereitet",
        "d_semantisch_mean", "d_semantisch_std", "semantische_breite", "dominanz_breite",
    ]
    df = ensure_numeric(df, numeric_cols)
    df["teilnehmer_datum"] = pd.to_datetime(df["teilnehmer_datum"], errors="coerce")
    df = df.sort_values(["teilnehmer_datum", "gruppe_id", "teilnehmer_id", "sdlg_id"], na_position="last")
    df["zustand"] = df["dominante_dimension"].astype(str) + "|p=" + df["polaritaet_gesamt"].fillna(0).astype(int).astype(str)

    # Teilnehmerreaktions-Proxys: Schulnotenlogik 1 = positiv, 4/5 = ungünstig; deshalb invertiert.
    df["reaktion_performanz"] = df[["lernfortschritt", "beherrscht_thema", "basiswissen", "transferdenken"]].apply(lambda s: 5 - s, axis=1).mean(axis=1)
    df["reaktion_motivation"] = df[["mitarbeit", "fleiss", "konzentration"]].apply(lambda s: 5 - s, axis=1).mean(axis=1)
    df["reaktion_regulation"] = df[["selbststaendigkeit", "absprachen", "vorbereitet"]].apply(lambda s: 5 - s, axis=1).mean(axis=1)
    df["reaktion_methodik"] = df[["themenauswahl", "materialien", "methodenvielfalt", "individualisierung"]].apply(lambda s: 5 - s, axis=1).mean(axis=1)

    # Kerntabellen
    dominance_counts = df["dominante_dimension"].value_counts().reindex(DIMENSIONS, fill_value=0)
    dominance_pct = (dominance_counts / dominance_counts.sum() * 100).round(2)
    dominance_table = pd.DataFrame({"anzahl": dominance_counts, "anteil_prozent": dominance_pct})
    dominance_table.to_csv(OUTDIR / "tab_6x9_01_dominanzhaeufigkeit.csv", encoding="utf-8-sig")

    group_dom = pd.crosstab(df["gruppe_id"], df["dominante_dimension"], normalize="index").reindex(columns=DIMENSIONS, fill_value=0).round(4)
    group_dom.to_csv(OUTDIR / "tab_6x9_02_dominanzverteilung_gruppen.csv", encoding="utf-8-sig")

    attractors = df["zustand"].value_counts().rename_axis("zustand").reset_index(name="anzahl")
    attractors["anteil_prozent"] = (attractors["anzahl"] / len(df) * 100).round(2)
    attractors.to_csv(OUTDIR / "tab_6x9_03_attraktor_zustaende.csv", index=False, encoding="utf-8-sig")

    reaction_by_dom = df.groupby("dominante_dimension")[["reaktion_performanz", "reaktion_motivation", "reaktion_regulation", "reaktion_methodik", "d_semantisch"]].mean().reindex(DIMENSIONS).round(4)
    reaction_by_dom.to_csv(OUTDIR / "tab_6x9_04_teilnehmerreaktionen_nach_dominanz.csv", encoding="utf-8-sig")

    # Übergangsmatrix der Dominanzachsen innerhalb Teilnehmertrajektorien
    trans = []
    for _, g in df.groupby("teilnehmer_id"):
        vals = g.sort_values("teilnehmer_datum")["dominante_dimension"].dropna().tolist()
        trans.extend(zip(vals[:-1], vals[1:]))
    if trans:
        tdf = pd.DataFrame(trans, columns=["von", "nach"])
        transition = pd.crosstab(tdf["von"], tdf["nach"], normalize="index").reindex(index=DIMENSIONS, columns=DIMENSIONS, fill_value=0).round(4)
    else:
        transition = pd.DataFrame(0.0, index=DIMENSIONS, columns=DIMENSIONS)
    transition.to_csv(OUTDIR / "tab_6x9_05_dominanz_uebergangsmatrix.csv", encoding="utf-8-sig")

    # Kosinus-Rekurrenz: durchschnittliche Ähnlichkeit aller Zustände derselben Dominanzachse
    vectors = df[XCOLS].to_numpy(float)
    cos = cosine_matrix(vectors)
    rec_rows = []
    for dim in DIMENSIONS:
        idx = np.where(df["dominante_dimension"].to_numpy() == dim)[0]
        if len(idx) >= 2:
            sub = cos[np.ix_(idx, idx)]
            mean_rec = (sub.sum() - len(idx)) / (len(idx) * (len(idx) - 1))
        else:
            mean_rec = np.nan
        rec_rows.append({"dominante_dimension": dim, "n": int(len(idx)), "mittlere_kosinus_rekurrenz": mean_rec})
    recurrence = pd.DataFrame(rec_rows).round(4)
    recurrence.to_csv(OUTDIR / "tab_6x9_06_kosinus_rekurrenz_attraktoren.csv", index=False, encoding="utf-8-sig")

    # Grafiken
    save_bar(dominance_counts, "Abb. 6x9-1: Häufigkeit dominanter Dimensionen", "Anzahl", "abb_6x9_01_dominanzhaeufigkeit.png")
    save_heatmap(group_dom, "Abb. 6x9-2: Dominanzverteilung nach Gruppen", "abb_6x9_02_dominanz_gruppen_heatmap.png")
    save_bar(attractors.head(12).set_index("zustand")["anzahl"], "Abb. 6x9-3: Häufigste Attraktorzustände", "Anzahl", "abb_6x9_03_attraktor_zustaende.png")
    save_heatmap(transition, "Abb. 6x9-4: Übergangsmatrix der Dominanzachsen", "abb_6x9_04_dominanz_uebergangsmatrix.png")
    save_heatmap(reaction_by_dom.drop(columns=["d_semantisch"]), "Abb. 6x9-5: Teilnehmerreaktionen nach Dominanzachse", "abb_6x9_05_reaktionen_nach_dominanz.png")
    save_bar(recurrence.set_index("dominante_dimension")["mittlere_kosinus_rekurrenz"], "Abb. 6x9-6: Kosinus-Rekurrenz nach Dominanzachse", "mittlere Kosinusähnlichkeit", "abb_6x9_06_kosinus_rekurrenz.png")

    coords = pca_2d(vectors)
    pca_df = pd.DataFrame({"pc1": coords[:, 0], "pc2": coords[:, 1], "dominante_dimension": df["dominante_dimension"].values})
    pca_df.to_csv(OUTDIR / "tab_6x9_07_pca_koordinaten.csv", index=False, encoding="utf-8-sig")
    plt.figure(figsize=(8, 6))
    for dim in DIMENSIONS:
        part = pca_df[pca_df["dominante_dimension"] == dim]
        if not part.empty:
            plt.scatter(part["pc1"], part["pc2"], label=dim, s=18, alpha=0.75)
    plt.title("Abb. 6x9-7: PCA-Projektion der 7D-Zustände")
    plt.xlabel("PC1")
    plt.ylabel("PC2")
    plt.legend(fontsize=8)
    plt.tight_layout()
    plt.savefig(OUTDIR / "abb_6x9_07_pca_attraktorraum.png", dpi=180)
    plt.close()

    # Textbericht
    top_dom = dominance_table.sort_values("anzahl", ascending=False).head(3)
    top_attr = attractors.head(5)
    top_rec = recurrence.sort_values("mittlere_kosinus_rekurrenz", ascending=False).head(3)
    report = []
    report.append("6.x.9 Attraktor- und Dominanzstrukturen – Auswertungsbericht\n")
    report.append(f"Datengrundlage: {len(df)} gematchte Zustände ohne Lehrkraftunterscheidung.\n")
    report.append("1. Dominanzachsen\n")
    report.append(top_dom.to_string() + "\n")
    report.append("2. Häufigste Attraktorzustände (Dominanz|Polarität)\n")
    report.append(top_attr.to_string(index=False) + "\n")
    report.append("3. Rekurrenz der Attraktoren\n")
    report.append(top_rec.to_string(index=False) + "\n")
    report.append("4. Interpretation\n")
    report.append("Stabile Attraktoren liegen dort vor, wo Dominanzachsen häufig wiederkehren, innerhalb der 7D-Vektoren eine hohe Kosinus-Rekurrenz zeigen und mit konsistenten Teilnehmerreaktionen verbunden sind. Performanzdominanz wird besonders über Leistungs- und Motivationsproxys gelesen, Regulation über Selbstständigkeit/Absprachen/Vorbereitung, Kognition über epistemische Aktivierung und Affektivität über ambivalente bzw. belastete Reaktionsmuster.\n")
    report.append("5. Erzeugte Dateien\n")
    for p in sorted(OUTDIR.iterdir()):
        report.append(f"- {p.name}\n")
    (OUTDIR / "bericht_6x9_attraktor_dominanzstrukturen.txt").write_text("".join(report), encoding="utf-8")
    print(f"OK: Auswertung erzeugt in {OUTDIR.resolve()}")


if __name__ == "__main__":
    main()
