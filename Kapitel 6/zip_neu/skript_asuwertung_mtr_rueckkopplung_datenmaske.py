#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Trend-Analyse mtr_rueckkopplung_datenmaske
------------------------------------------
- Liest metrische Werte pro Teilnehmer und Datum aus MySQL/MariaDB
- Erstellt Trendgrafiken (pro Teilnehmer + Gesamt)
- Exportiert aggregierte Werte als JSON
"""

import pandas as pd
import matplotlib
matplotlib.use("Agg")  # kein GUI nötig (Headless-kompatibel)
import matplotlib.pyplot as plt
from matplotlib.dates import DateFormatter
import json
from pathlib import Path
from sqlalchemy import create_engine, text

# ======================================================
# 1️⃣ Datenbankverbindung (PDO-ähnlich mit SQLAlchemy)
# ======================================================

DB_USER = "root"
DB_PASS = ""
DB_HOST = "localhost"
DB_NAME = "icas"
DB_CHARSET = "utf8mb4"

engine = create_engine(
    f"mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_HOST}/{DB_NAME}?charset={DB_CHARSET}",
    pool_pre_ping=True
)

# ======================================================
# 2️⃣ Daten abrufen
# ======================================================

query = text("""
SELECT 
    teilnehmer_id,
    fach,
    datum,
    metr_kognition,
    metr_sozial,
    metr_affektiv,
    metr_metakog,
    metr_kohärenz
FROM mtr_rueckkopplung_datenmaske
WHERE datum IS NOT NULL
ORDER BY teilnehmer_id, datum;
""")

try:
    df = pd.read_sql(query, engine)
except Exception as e:
    print("❌ Datenbankabfrage fehlgeschlagen:", e)
    raise SystemExit(1)

print("📦 Datensätze geladen:", len(df))
if len(df) == 0:
    print("⚠️ Keine Daten vorhanden – Abbruch.")
    raise SystemExit(0)

# ======================================================
# 3️⃣ Daten vorbereiten
# ======================================================
df["datum"] = pd.to_datetime(df["datum"])
metr_cols = ["metr_kognition", "metr_sozial", "metr_affektiv", "metr_metakog", "metr_kohärenz"]

# ======================================================
# 4️⃣ Ausgabeordner
# ======================================================
out_dir = Path(__file__).parent / "trend_output"
out_dir.mkdir(exist_ok=True)
print("💾 Ausgabeordner:", out_dir.resolve())

# ======================================================
# 5️⃣ Trenddiagramme je Teilnehmer
# ======================================================
for tid, group in df.groupby("teilnehmer_id"):
    plt.figure(figsize=(10, 6))
    group = group.sort_values("datum")

    for col in metr_cols:
        plt.plot(group["datum"], group[col], marker="o", label=col.replace("metr_", "").capitalize())

    plt.title(f"Trendverlauf – Teilnehmer {tid}")
    plt.xlabel("Datum")
    plt.ylabel("Metrischer Wert (0–1)")
    plt.legend()
    plt.grid(True)
    plt.gca().xaxis.set_major_formatter(DateFormatter("%Y-%m-%d"))
    plt.xticks(rotation=45)
    plt.tight_layout()

    fname = out_dir / f"trend_teilnehmer_{tid}.png"
    plt.savefig(fname, dpi=150)
    plt.close()
    print(f"✅ Diagramm gespeichert: {fname.name}")

# ======================================================
# 6️⃣ Aggregierte Trendübersicht (alle Teilnehmer)
# ======================================================
trend_all = (
    df.groupby("datum")[metr_cols]
    .mean()
    .reset_index()
    .sort_values("datum")
)

plt.figure(figsize=(10, 6))
for col in metr_cols:
    plt.plot(trend_all["datum"], trend_all[col], marker="o", label=col.replace("metr_", "").capitalize())

plt.title("Aggregierte Trendanalyse aller Teilnehmer")
plt.xlabel("Datum")
plt.ylabel("Metrischer Mittelwert (0–1)")
plt.legend()
plt.grid(True)
plt.gca().xaxis.set_major_formatter(DateFormatter("%Y-%m-%d"))
plt.xticks(rotation=45)
plt.tight_layout()
agg_file = out_dir / "trend_gesamt.png"
plt.savefig(agg_file, dpi=150)
plt.close()
print(f"📊 Gesamttrend gespeichert: {agg_file.name}")

# ======================================================
# 7️⃣ JSON-Export der aggregierten Werte
# ======================================================
trend_json = (
    df.groupby(["teilnehmer_id", "datum"])[metr_cols]
    .mean()
    .reset_index()
    .sort_values(["teilnehmer_id", "datum"])
    .groupby("teilnehmer_id")
    .apply(lambda g: g[["datum"] + metr_cols].to_dict(orient="records"))
    .to_dict()
)

json_path = out_dir / "trend_aggregiert.json"
with open(json_path, "w", encoding="utf-8") as f:
    json.dump(trend_json, f, indent=2, ensure_ascii=False, default=str)
print(f"💾 JSON-Datei gespeichert: {json_path.name}")

# Beispielauszug
print("\n🔍 Beispiel aus JSON:")
for tid, daten in list(trend_json.items())[:2]:
    print(f"Teilnehmer {tid}: {len(daten)} Einträge")
    print(json.dumps(daten[:2], indent=2, ensure_ascii=False))
    print("…\n")

print("✅ Trendanalyse erfolgreich abgeschlossen.")
