#!/usr/bin/env python3
"""
plot_frzk_group_3d.py
Erzeugt 3D-Kohärenzkarte der gruppenaggregierten semantischen Dichte.

Versuchsreihenfolge beim Laden:
 1) MySQL/MariaDB (pymysql nötig)
 2) SQL-Dump (icas.sql) - parsen von INSERTs
 3) CSV-Fallback (mtr_rueckkopplung_teilnehmer.csv oder frzk_semantische_dichte.csv)

Ausgabe:
 - frzk_group_semantische_dichte_extracted.csv
 - frzk_group_coherence_3d.png
"""

import sys, os, re, ast, math
import argparse
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # noqa

# make argparse friendly in notebooks
if 'ipykernel' in sys.modules:
    sys.argv = [sys.argv[0]]

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
            # Prefer group-aggregated table if exists; else aggregate from mtr_rueckkopplung_teilnehmer
            cur.execute("SHOW TABLES LIKE 'frzk_group_semantische_dichte'")
            if cur.fetchone():
                cur.execute("SELECT * FROM frzk_group_semantische_dichte ORDER BY gruppe_id, zeitpunkt")
                rows = cur.fetchall()
                df = pd.DataFrame(rows)
                return df
            # if not, try to build from frzk_semantische_dichte if exists
            cur.execute("SHOW TABLES LIKE 'frzk_semantische_dichte'")
            if cur.fetchone():
                cur.execute("SELECT teilnehmer_id, zeitpunkt, x_kognition, y_sozial, z_affektiv, h_bedeutung FROM frzk_semantische_dichte")
                rows = cur.fetchall()
                df = pd.DataFrame(rows)
                return df
            # last fallback: aggregate from mtr_rueckkopplung_teilnehmer
            cur.execute("SELECT teilnehmer_id, gruppe_id, erfasst_am, " 
                        "mitarbeit, selbststaendigkeit, konzentration, basiswissen, vorbereitet, "
                        "absprachen, themenauswahl, individualisierung, zielgruppen, "
                        "fleiss, lernfortschritt FROM mtr_rueckkopplung_teilnehmer")
            rows = cur.fetchall()
            df = pd.DataFrame(rows)
            return df
    finally:
        conn.close()

def parse_sql_file(path):
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()
    text = re.sub(r'\bNULL\b', 'None', text, flags=re.IGNORECASE)
    # try to find INSERT INTO frzk_semantische_dichte
    m = re.search(r"INSERT\s+INTO\s+`?frzk_semantische_dichte`?\s*\([^\)]*\)\s*VALUES\s*(.+?);", text, flags=re.IGNORECASE|re.DOTALL)
    if not m:
        # fallback: try to locate mtr_rueckkopplung_teilnehmer insert
        m = re.search(r"INSERT\s+INTO\s+`?mtr_rueckkopplung_teilnehmer`?\s*\([^\)]*\)\s*VALUES\s*(.+?);", text, flags=re.IGNORECASE|re.DOTALL)
        if not m:
            raise ValueError("Keine passenden INSERTs für frzk_semantische_dichte oder mtr_rueckkopplung_teilnehmer gefunden.")
    vals = m.group(1)
    tuples = re.findall(r"\((.*?)\)(?:,|$)", vals, flags=re.DOTALL)
    rows = []
    for t in tuples:
        tup = "(" + t + ")"
        try:
            parsed = ast.literal_eval(tup)
        except Exception:
            parsed = ast.literal_eval(re.sub(r"\s+", " ", tup))
        rows.append(parsed)
    # Heuristisch: return DataFrame with columns depending on which insert we found
    # Try to detect frzk_semantische_dichte by tuple length >= 7 (it has many columns)
    if rows and len(rows[0]) >= 7:
        cols = ["id","teilnehmer_id","zeitpunkt","x_kognition","y_sozial","z_affektiv","h_bedeutung",
                "dh_dt","cluster_id","stabilitaet_score","transitions_marker","bemerkung"]
        df = pd.DataFrame(rows, columns=cols[:len(rows[0])])
        return df
    else:
        # fallback generic DF
        return pd.DataFrame(rows)

def read_csv_fallback(paths):
    for p in paths:
        if os.path.exists(p):
            return pd.read_csv(p)
    return None

def prepare_and_aggregate(df):
    # if table already group-aggregated (has 'gruppe_id' or avg_x), detect and return
    if 'gruppe_id' in df.columns and ('avg_x' in df.columns or 'x_kognition' not in df.columns):
        # assume this is already grouped
        # if avg_x doesn't exist but avg_h exists, try to extract avg columns
        return df
    # If frzk_semantische_dichte structure (has x_kognition)
    if 'x_kognition' in df.columns and 'teilnehmer_id' in df.columns:
        working = df[['teilnehmer_id','zeitpunkt','x_kognition','y_sozial','z_affektiv','h_bedeutung']].copy()
        # if zeitpunkt missing, try other columns
        working['zeitpunkt'] = pd.to_datetime(working['zeitpunkt'], errors='coerce')
        # Need gruppe_id mapping from mtr_rueckkopplung_teilnehmer if not present: try to load that mapping from CSV or DB
        # Here we attempt to read local mapping file
        if 'gruppe_id' not in working.columns:
            # try to load mapping from mtr_rueckkopplung_teilnehmer.csv
            if os.path.exists("mtr_rueckkopplung_teilnehmer.csv"):
                m = pd.read_csv("mtr_rueckkopplung_teilnehmer.csv", usecols=['teilnehmer_id','gruppe_id','erfasst_am'])
                m['teilnehmer_id'] = pd.to_numeric(m['teilnehmer_id'], errors='coerce')
                working = working.merge(m[['teilnehmer_id','gruppe_id','erfasst_am']], on='teilnehmer_id', how='left')
                working['zeitpunkt'] = pd.to_datetime(working['zeitpunkt']).fillna(pd.to_datetime(working['erfasst_am'], errors='coerce'))
        # If still no gruppe_id, try to read from local SQL parsed DF 'mtr_rueckkopplung_teilnehmer' present as file
        if 'gruppe_id' not in working.columns:
            # attempt to read mtr_rueckkopplung_teilnehmer.csv or raise
            raise ValueError("Keine 'gruppe_id' in den Daten. Stelle sicher, dass mtr_rueckkopplung_teilnehmer vorhanden ist oder liefere CSV mit gruppe_id.")
        # group by gruppe_id + zeitpunkt
        grouped = working.groupby(['gruppe_id','zeitpunkt']).agg(
            n_teilnehmer = ('teilnehmer_id','nunique'),
            avg_x = ('x_kognition','mean'),
            avg_y = ('y_sozial','mean'),
            avg_z = ('z_affektiv','mean'),
            avg_h = ('h_bedeutung','mean')
        ).reset_index()
        return grouped
    # If mtr_rueckkopplung_teilnehmer raw fields exist (individual scales)
    raw_fields = ['mitarbeit','selbststaendigkeit','konzentration','basiswissen','vorbereitet',
                  'absprachen','themenauswahl','individualisierung','zielgruppen','fleiss','lernfortschritt']
    if all(f in df.columns for f in ['teilnehmer_id','gruppe_id','erfasst_am']):
        # compute per row x,y,z,h then aggregate per group/time
        def mean_vals(row, fields):
            vals = [float(row[f]) for f in fields if pd.notna(row.get(f, None)) and row.get(f, None)!='']
            return sum(vals)/len(vals) if vals else None
        df['x_kognition'] = df.apply(lambda r: mean_vals(r, ['mitarbeit','selbststaendigkeit','konzentration','basiswissen','vorbereitet']), axis=1)
        df['y_sozial'] = df.apply(lambda r: mean_vals(r, ['absprachen','themenauswahl','individualisierung','zielgruppen']), axis=1)
        df['z_affektiv'] = df.apply(lambda r: mean_vals(r, ['fleiss','lernfortschritt']), axis=1)
        df['h_bedeutung'] = df[['x_kognition','y_sozial','z_affektiv']].mean(axis=1)
        df['zeitpunkt'] = pd.to_datetime(df['erfasst_am'], errors='coerce')
        grouped = df.groupby(['gruppe_id','zeitpunkt']).agg(
            n_teilnehmer = ('teilnehmer_id','nunique'),
            avg_x = ('x_kognition','mean'),
            avg_y = ('y_sozial','mean'),
            avg_z = ('z_affektiv','mean'),
            avg_h = ('h_bedeutung','mean')
        ).reset_index()
        return grouped

    raise ValueError("Input-Daten besitzen kein bekanntes Schema zur Aggregation.")

def plot_group_3d(grouped_df, out_png="frzk_group_coherence_3d.png", out_csv="frzk_group_semantische_dichte_extracted.csv"):
    # ensure numeric
    for c in ['avg_x','avg_y','avg_z','avg_h']:
        grouped_df[c] = pd.to_numeric(grouped_df[c], errors='coerce')
    grouped_df = grouped_df.dropna(subset=['avg_x','avg_y','avg_z'])
    grouped_df.to_csv(out_csv, index=False)
    x = grouped_df['avg_x']
    y = grouped_df['avg_y']
    z = grouped_df['avg_z']
    h = grouped_df['avg_h'].fillna(0)
    # sizes
    if h.max() - h.min() > 1e-9:
        sizes = (h - h.min()) / (h.max() - h.min()) * 250 + 30
    else:
        sizes = [60]*len(h)
    fig = plt.figure(figsize=(11,8))
    ax = fig.add_subplot(111, projection='3d')
    sc = ax.scatter(x, y, z, s=sizes, c=h, cmap='viridis', alpha=0.8, depthshade=True)
    ax.set_xlabel('avg_x (Kognition)')
    ax.set_ylabel('avg_y (Sozial)')
    ax.set_zlabel('avg_z (Affektiv)')
    ax.set_title('3D FRZK - Gruppen-Kohärenzkarte (Punktgröße/Color ∝ avg_h)')
    plt.colorbar(sc, label='avg_h')
    # annotate top 10% avg_h
    try:
        thr = grouped_df['avg_h'].quantile(0.90)
        high = grouped_df[grouped_df['avg_h'] >= thr]
        for _, row in high.iterrows():
            gid = row['gruppe_id']
            t = row['zeitpunkt']
            lab = f"{int(gid)}\n{pd.to_datetime(t).strftime('%Y-%m-%d %H:%M') if not pd.isna(t) else ''}"
            ax.text(row['avg_x'], row['avg_y'], row['avg_z'], lab, fontsize=8)
    except Exception:
        pass
    plt.tight_layout()
    fig.savefig(out_png, dpi=150)
    print("Saved PNG:", os.path.abspath(out_png))
    print("Saved CSV:", os.path.abspath(out_csv))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--db-host", default="localhost")
    parser.add_argument("--db-user", default="root")
    parser.add_argument("--db-pass", default="")
    parser.add_argument("--db-name", default="icas")
    parser.add_argument("--sql-file", default="icas.sql")
    parser.add_argument("--csv-files", nargs='*', default=["mtr_rueckkopplung_teilnehmer.csv","frzk_semantische_dichte.csv"])
    parser.add_argument("--out-png", default="frzk_group_coherence_3d.png")
    parser.add_argument("--out-csv", default="frzk_group_semantische_dichte_extracted.csv")
    args = parser.parse_args()

    df = None
    # try DB
    try:
        print("Trying DB...")
        df = read_from_db(args.db_host, args.db_user, args.db_pass, args.db_name)
        print("Read rows from DB:", len(df))
    except Exception as e:
        print("DB read failed:", e)

    # try SQL file
    if (df is None or df.empty) and os.path.exists(args.sql_file):
        try:
            print("Parsing SQL file:", args.sql_file)
            df = parse_sql_file(args.sql_file)
            print("Parsed tuples:", len(df))
        except Exception as e:
            print("SQL parse failed:", e)

    # try CSV fallback
    if (df is None or df.empty):
        csvdf = read_csv_fallback(args.csv_files)
        if csvdf is not None:
            print("Using CSV fallback:", csvdf.shape)
            df = csvdf

    if df is None or df.empty:
        print("No data available. Provide DB access, SQL dump, or CSV files.")
        return

    grouped = prepare_and_aggregate(df)
    print("Aggregated groups:", grouped.shape)
    plot_group_3d(grouped, out_png=args.out_png, out_csv=args.out_csv)

if __name__ == "__main__":
    main()
