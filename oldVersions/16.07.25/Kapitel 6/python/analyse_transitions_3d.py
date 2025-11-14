import pandas as pd
import matplotlib.pyplot as plt
import mysql.connector
from mpl_toolkits.mplot3d import Axes3D

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

# ==========================
# 3D-Scatterplot mit Transitionen
# ==========================
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection="3d")

# Alle Punkte im Raum (Farbe = h_bedeutung)
sc = ax.scatter(
    df["x_kognition"],
    df["y_sozial"],
    df["z_affektiv"],
    c=df["h_bedeutung"], cmap="viridis", s=40, alpha=0.6, label="h(t)"
)

# Transitions hervorheben
transitions = df[df["transitions_marker"] == "Transition"]
ax.scatter(
    transitions["x_kognition"],
    transitions["y_sozial"],
    transitions["z_affektiv"],
    color="red", marker="x", s=100, label="Transition"
)

# Achsenbeschriftungen
ax.set_xlabel("Kognition (x)")
ax.set_ylabel("Sozial (y)")
ax.set_zlabel("Affektiv (z)")

# Farblegende + Titel
fig.colorbar(sc, label="h_bedeutung")
plt.title("Semantische Dichte mit markierten Transitionen (3D)")

plt.legend()
plt.show()
