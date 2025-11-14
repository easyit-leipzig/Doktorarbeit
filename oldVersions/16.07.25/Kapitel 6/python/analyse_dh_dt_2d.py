import pandas as pd
import matplotlib.pyplot as plt
import mysql.connector

# --- DB-Verbindung ---
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="icas"
)

# --- Daten laden ---
query = """
SELECT teilnehmer_id, zeitpunkt, x_kognition, y_sozial, z_affektiv,
       h_bedeutung, dh_dt, cluster_id, stabilitaet_score, transitions_marker
FROM frzk_semantische_dichte
ORDER BY teilnehmer_id, zeitpunkt
"""
df = pd.read_sql(query, conn)

# --- Plot: h(t) pro Teilnehmer ---
for tid, group in df.groupby("teilnehmer_id"):
    plt.plot(group["zeitpunkt"], group["h_bedeutung"], label=f"Teilnehmer {tid}")

plt.title("Semantische Dichte h(t) pro Teilnehmer")
plt.xlabel("Zeit")
plt.ylabel("h_bedeutung")
plt.legend()
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
