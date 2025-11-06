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
# 3D-Scatterplot für dh_dt
# ==========================
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection="3d")

sc = ax.scatter(
    df["x_kognition"],
    df["y_sozial"],
    df["z_affektiv"],
    c=df["dh_dt"], cmap="coolwarm", s=40
)

ax.set_xlabel("Kognition (x)")
ax.set_ylabel("Sozial (y)")
ax.set_zlabel("Affektiv (z)")
fig.colorbar(sc, label="dh/dt (Änderungsrate)")
plt.title("Änderungsrate dh/dt im semantischen Raum")
plt.show()
