import json
import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

INPUT_FILE = "06x05_nichtlinearitaet.json"
OUTPUT_DIR = "06x05_output"

os.makedirs(OUTPUT_DIR, exist_ok=True)

DIMENSIONEN = [
    "kognition",
    "sozial",
    "affektiv",
    "motivation",
    "methodik",
    "performanz",
    "regulation"
]

NICHTLINEARITAETS_VARIABLEN = [
    "semantische_breite",
    "dominanz_breite",
    "var_affektiv",
    "var_motivation",
    "var_regulation",
    "emotion_count",
    "ambivalenz_index"
]

POSITIVE_EMOTIONS = {
    "1", "2", "3", "4", "5", "6", "7",
    "8", "9", "10", "11", "12", "13", "14",
    "23", "26", "27", "28"
}

NEGATIVE_EMOTIONS = {
    "15", "16", "17", "18", "19", "20",
    "21", "22", "24", "25"
}


def load_data():
    with open(INPUT_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)

    records = data.get("records", [])

    if not records:
        raise ValueError("Keine records im JSON gefunden.")

    return pd.DataFrame(records)


def to_numeric(df, cols):
    for col in cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce")
    return df


def parse_emotions(value):
    if pd.isna(value):
        return []

    value = str(value).strip()

    if value == "":
        return []

    return [
        x.strip()
        for x in value.split(",")
        if x.strip() != ""
    ]


def emotion_count(value):
    return len(parse_emotions(value))


def ambivalenz_index(value):
    ids = set(parse_emotions(value))

    pos = len(ids & POSITIVE_EMOTIONS)
    neg = len(ids & NEGATIVE_EMOTIONS)

    if pos > 0 and neg > 0:
        return min(pos, neg)

    return 0


def emotion_polaritaet(value):
    ids = set(parse_emotions(value))

    pos = len(ids & POSITIVE_EMOTIONS)
    neg = len(ids & NEGATIVE_EMOTIONS)

    if pos > neg:
        return 1
    if neg > pos:
        return -1
    if pos == 0 and neg == 0:
        return 0

    return 0


def main():
    df = load_data()

    numeric_cols = [
        "semantische_breite",
        "dominanz_breite",
        "var_affektiv",
        "var_motivation",
        "var_regulation",
        "var_kognition",
        "var_sozial",
        "var_methodik",
        "var_performanz",
        "d_semantisch_mean",
        "d_semantisch_std",
        "d_semantisch",
        "polaritaet_gesamt",
        "dominante_dimension_wert"
    ]

    df = to_numeric(df, numeric_cols)

    if "emotions" not in df.columns:
        df["emotions"] = ""

    df["emotion_count"] = df["emotions"].apply(emotion_count)
    df["ambivalenz_index"] = df["emotions"].apply(ambivalenz_index)
    df["emotion_polaritaet"] = df["emotions"].apply(emotion_polaritaet)

    for col in NICHTLINEARITAETS_VARIABLEN:
        if col not in df.columns:
            df[col] = 0

    df[NICHTLINEARITAETS_VARIABLEN] = df[NICHTLINEARITAETS_VARIABLEN].fillna(0)

    df["nichtlinearitaets_index"] = (
        df["semantische_breite"]
        + df["dominanz_breite"]
        + df["var_affektiv"]
        + df["var_motivation"]
        + df["var_regulation"]
        + df["emotion_count"]
        + df["ambivalenz_index"]
    )

    summary = {
        "anzahl_datensaetze": int(len(df)),
        "mittelwert_nichtlinearitaets_index": float(df["nichtlinearitaets_index"].mean()),
        "median_nichtlinearitaets_index": float(df["nichtlinearitaets_index"].median()),
        "maximum_nichtlinearitaets_index": float(df["nichtlinearitaets_index"].max()),
        "mittelwert_emotion_count": float(df["emotion_count"].mean()),
        "mittelwert_ambivalenz_index": float(df["ambivalenz_index"].mean()),
        "mittelwert_semantische_breite": float(df["semantische_breite"].mean()),
        "mittelwert_dominanz_breite": float(df["dominanz_breite"].mean()),
        "mittelwert_var_affektiv": float(df["var_affektiv"].mean()),
        "mittelwert_var_motivation": float(df["var_motivation"].mean()),
        "mittelwert_var_regulation": float(df["var_regulation"].mean())
    }

    top_cases = df.sort_values(
        "nichtlinearitaets_index",
        ascending=False
    ).head(30)

    corr_cols = [
        "nichtlinearitaets_index",
        "semantische_breite",
        "dominanz_breite",
        "var_affektiv",
        "var_motivation",
        "var_regulation",
        "emotion_count",
        "ambivalenz_index",
        "d_semantisch_mean",
        "d_semantisch_std"
    ]

    corr = df[corr_cols].corr(numeric_only=True)

    summary_df = pd.DataFrame([summary])
    summary_df.to_csv(
        os.path.join(OUTPUT_DIR, "06x05_summary.csv"),
        index=False,
        encoding="utf-8-sig"
    )

    top_cases.to_csv(
        os.path.join(OUTPUT_DIR, "06x05_top_nichtlinearitaet.csv"),
        index=False,
        encoding="utf-8-sig"
    )

    corr.to_csv(
        os.path.join(OUTPUT_DIR, "06x05_korrelationen.csv"),
        encoding="utf-8-sig"
    )

    with open(
        os.path.join(OUTPUT_DIR, "06x05_summary.json"),
        "w",
        encoding="utf-8"
    ) as f:
        json.dump(summary, f, ensure_ascii=False, indent=2)

    plt.figure(figsize=(10, 6))
    plt.hist(df["nichtlinearitaets_index"].dropna(), bins=25)
    plt.title("6.x.5 Verteilung des Nichtlinearitätsindex")
    plt.xlabel("Nichtlinearitätsindex")
    plt.ylabel("Häufigkeit")
    plt.tight_layout()
    plt.savefig(
        os.path.join(OUTPUT_DIR, "06x05_hist_nichtlinearitaetsindex.png"),
        dpi=300
    )
    plt.close()

    plt.figure(figsize=(10, 6))
    plt.scatter(df["semantische_breite"], df["emotion_count"])
    plt.title("Semantische Breite und Emotionsvielfalt")
    plt.xlabel("semantische_breite")
    plt.ylabel("emotion_count")
    plt.tight_layout()
    plt.savefig(
        os.path.join(OUTPUT_DIR, "06x05_scatter_semantische_breite_emotionen.png"),
        dpi=300
    )
    plt.close()

    plt.figure(figsize=(10, 6))
    plt.scatter(df["var_affektiv"], df["ambivalenz_index"])
    plt.title("Affektive Varianz und Ambivalenz")
    plt.xlabel("var_affektiv")
    plt.ylabel("ambivalenz_index")
    plt.tight_layout()
    plt.savefig(
        os.path.join(OUTPUT_DIR, "06x05_scatter_affektive_varianz_ambivalenz.png"),
        dpi=300
    )
    plt.close()

    plt.figure(figsize=(10, 6))
    plt.scatter(df["dominanz_breite"], df["emotion_count"])
    plt.title("Dominanzbreite und Emotionsvielfalt")
    plt.xlabel("dominanz_breite")
    plt.ylabel("emotion_count")
    plt.tight_layout()
    plt.savefig(
        os.path.join(OUTPUT_DIR, "06x05_scatter_dominanzbreite_emotionen.png"),
        dpi=300
    )
    plt.close()

    plt.figure(figsize=(10, 6))
    plt.imshow(corr, aspect="auto")
    plt.xticks(range(len(corr.columns)), corr.columns, rotation=90)
    plt.yticks(range(len(corr.index)), corr.index)
    plt.title("Korrelationsmatrix Nichtlinearität")
    plt.colorbar()
    plt.tight_layout()
    plt.savefig(
        os.path.join(OUTPUT_DIR, "06x05_korrelationsmatrix.png"),
        dpi=300
    )
    plt.close()

    print("Analyse abgeschlossen.")
    print("Ausgabeordner:", OUTPUT_DIR)
    print(json.dumps(summary, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()