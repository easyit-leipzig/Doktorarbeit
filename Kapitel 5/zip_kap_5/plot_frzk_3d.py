#!/usr/bin/env python3
"""
plot_frzk_3d.py

Erzeugt eine 3D-Kohärenzkarte aus der Tabelle `frzk_semantische_dichte`.

Vorgehen:
1) Versucht DB-Verbindung (MySQL/MariaDB) mit den hier konfigurierten Zugangsdaten.
2) Falls das fehlschlägt, versucht es, INSERTs aus einer lokal vorhandenen 'icas.sql' zu parsen.
3) Falls vorhanden, kann stattdessen eine CSV 'frzk_semantische_dichte.csv' geladen werden.

Ausgabe:
- frzk_coherence_3d.png
- frzk_semantische_dichte_extracted.csv
"""

import os
import re
import ast
import sys
import argparse
import math
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # required for 3D plotting

# Optionally try to import pymysql for DB access
try:
    import pymysql
    HAVE_PYMYSQL = True
except Exception:
    HAVE_PYMYSQL = False

def read_from_db(host, user, password, dbname, port=3306):
    if not HAVE_PYMYSQL:
        raise RuntimeError("pymysql not installed. Install with: pip install pymysql")
    conn = pymysql.connect(host=host, user=user, password=password, db=dbname, port=port, charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT id, teilnehmer_id, zeitpunkt, x_kognition, y_sozial, z_affektiv, h_bedeutung, dh_dt, cluster_id, stabilitaet_score, transitions_marker, bemerkung FROM frzk_semantische_dichte ORDER BY zeitpunkt")
            rows = cur.fetchall()
        return pd.DataFrame(rows)
    finally:
        conn.close()

def parse_sql_file(path):
    """
    Robust parse: look for INSERT INTO frzk_semantische_dichte or variants without backticks.
    Returns DataFrame or raises ValueError.
    """
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()

    # normalize NULL -> None for Python evaluation
    text = re.sub(r'\bNULL\b', 'None', text, flags=re.IGNORECASE)

    # search for various INSERT regex patterns
    patterns = [
        r"INSERT\s+INTO\s+`?frzk_semantische_dichte`?\s*\([^\)]*\)\s*VALUES\s*(.+?);",
        r"INSERT\s+INTO\s+frzk_semantische_dichte\s+VALUES\s*(.+?);"
    ]
    tuples = []
    for pat in patterns:
        m = re.search(pat, text, flags=re.IGNORECASE | re.DOTALL)
        if m:
            values_block = m.group(1)
            # find all tuples between parentheses
            raw_tuples = re.findall(r"\((.*?)\)(?:,|$)", values_block, flags=re.DOTALL)
            for t in raw_tuples:
                tup_text = "(" + t + ")"
                # attempt to transform MySQL-literals to Python-literals
                try:
                    parsed = ast.literal_eval(tup_text)
                except Exception:
                    simplified = re.sub(r"\s+", " ", tup_text)
                    parsed = ast.literal_eval(simplified)
                tuples.append(parsed)
            break

    if not tuples:
        raise ValueError("Keine passenden INSERT-VALUES für frzk_semantische_dichte in der SQL-Datei gefunden.")

    cols = ["id", "teilnehmer_id", "zeitpunkt", "x_kognition", "y_sozial", "z_affektiv", "h_bedeutung",
            "dh_dt", "cluster_id", "stabilitaet_score", "transitions_marker", "bemerkung"]
    df = pd.DataFrame(tuples, columns=cols)
    return df

def read_from_csv(path):
    return pd.read_csv(path)

def prepare_df(df):
    # ensure columns exist
    expected = ["id","teilnehmer_id","zeitpunkt","x_kognition","y_sozial","z_affektiv","h_bedeutung"]
    missing = [c for c in expected if c not in df.columns]
    if missing:
        raise ValueError(f"Dataframe missing required columns: {missing}")

    # numeric conversions
    for c in ["x_kognition","y_sozial","z_affektiv","h_bedeutung","dh_dt","stabilitaet_score"]:
        if c in df.columns:
            df[c] = pd.to_numeric(df[c], errors="coerce")
    # parse datetime
    df["zeitpunkt"] = pd.to_datetime(df["zeitpunkt"], errors="coerce")
    return df

def plot_3d(df, out_png="frzk_coherence_3d.png"):
    x = df["x_kognition"]
    y = df["y_sozial"]
    z = df["z_affektiv"]
    h = df["h_bedeutung"].fillna(0)

    # marker sizes: scale h into a reasonable range (20 .. 220)
    if h.max() - h.min() > 1e-9:
        sizes = (h - h.min()) / (h.max() - h.min()) * 200 + 20
    else:
        sizes = [60] * len(h)

    fig = plt.figure(figsize=(10,8))
    ax = fig.add_subplot(111, projection='3d')
    sc = ax.scatter(x, y, z, s=sizes, alpha=0.7)
    ax.set_xlabel("x_kognition")
    ax.set_ylabel("y_sozial")
    ax.set_zlabel("z_affektiv")
    ax.set_title("3D FRZK-Kohärenzkarte (Punktgröße ∝ h_bedeutung)")

    # annotate top 10% h as potential hubs
    try:
        threshold = df["h_bedeutung"].quantile(0.90)
        high = df[df["h_bedeutung"] >= threshold]
        for _, row in high.iterrows():
            ax.text(row["x_kognition"], row["y_sozial"], row["z_affektiv"], str(int(row["teilnehmer_id"])), fontsize=8)
    except Exception:
        pass

    plt.tight_layout()
    fig.savefig(out_png, dpi=150)
    print(f"Saved 3D plot to: {os.path.abspath(out_png)}")
    return os.path.abspath(out_png)

def main():
    parser = argparse.ArgumentParser(description="Generate 3D FRZK coherence map")
    parser.add_argument("--db-host", default="localhost", help="DB host")
    parser.add_argument("--db-user", default="root", help="DB user")
    parser.add_argument("--db-pass", default="", help="DB password")
    parser.add_argument("--db-name", default="icas", help="DB name")
    parser.add_argument("--db-port", type=int, default=3306, help="DB port")
    parser.add_argument("--sql-file", default="icas.sql", help="Path to SQL dump to parse")
    parser.add_argument("--csv-file", default="frzk_semantische_dichte.csv", help="CSV fallback")
    parser.add_argument("--out", default="frzk_coherence_3d.png", help="Output PNG path")
    args = parser.parse_args()

    df = None
    # 1) Try DB
    try:
        print("Trying to read from DB...")
        df = read_from_db(args.db_host, args.db_user, args.db_pass, args.db_name, port=args.db_port)
        print(f"Read {len(df)} rows from database.")
    except Exception as e:
        print("DB read failed:", str(e))

    # 2) Try SQL file parsing
    if df is None or df.empty:
        if os.path.exists(args.sql_file):
            try:
                print("Trying to parse SQL file:", args.sql_file)
                df = parse_sql_file(args.sql_file)
                print(f"Parsed {len(df)} rows from SQL file.")
            except Exception as e:
                print("SQL parsing failed:", str(e))
        else:
            print(f"SQL file '{args.sql_file}' not found, skipping.")

    # 3) Try CSV fallback
    if (df is None or df.empty) and os.path.exists(args.csv_file):
        try:
            print("Loading CSV fallback:", args.csv_file)
            df = read_from_csv(args.csv_file)
            print(f"Loaded {len(df)} rows from CSV.")
        except Exception as e:
            print("CSV load failed:", str(e))

    if df is None or df.empty:
        print("No data available. Please ensure DB credentials are correct, or place a valid SQL dump or CSV in the working directory.")
        sys.exit(1)

    df = prepare_df(df)
    # Save extracted DataFrame for inspection
    csv_out = "frzk_semantische_dichte_extracted.csv"
    df.to_csv(csv_out, index=False)
    print("Saved extracted table to:", os.path.abspath(csv_out))

    png = plot_3d(df, out_png=args.out)
    print("Done. Plot saved at:", png)

if __name__ == "__main__":
    main()
