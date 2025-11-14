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
# 3D-Trajektorien pro Teilnehmer
# ==========================
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection="3d")

# Trajektorie je Teilnehmer zeichnen
for tid, group in df.groupby("teilnehmer_id"):
    group = group.sort_values("zeitpunkt")  # zeitlich sortieren
    
    ax.plot(
        group["x_kognition"],
        group["y_sozial"],
        group["z_affektiv"],
        label=f"Teilnehmer {tid}", alpha=0.7
    )
    
    # optional: Punkte farbig nach h_bedeutung
    sc = ax.scatter(
        group["x_kognition"],
        group["y_sozial"],
        group["z_affektiv"],
        c=group["h_bedeutung"], cmap="viridis", s=30
    )

# Achsenbeschriftungen
ax.set_xlabel("Kognition (x)")
ax.set_ylabel("Sozial (y)")
ax.set_zlabel("Affektiv (z)")

fig.colorbar(sc, label="h_bedeutung")
plt.title("Trajektorien im semantischen Raum (3D)")
plt.legend()
plt.show()
