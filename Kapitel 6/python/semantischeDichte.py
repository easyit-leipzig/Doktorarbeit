import json
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# JSON-Datei laden
with open("e:/xampp/htdocs/easyDidak/library/php/frzk_semantische_dichte.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Listen für Achsenwerte
x_vals = [d["x_kognition"] for d in data]
y_vals = [d["y_sozial"] for d in data]
z_vals = [d["z_affektiv"] for d in data]
h_vals = [d["h_bedeutung"] for d in data]  # Semantische Dichte als Farbskala

# 3D-Plot
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection="3d")

# Scatterplot mit Farbskala nach h_bedeutung
sc = ax.scatter(x_vals, y_vals, z_vals, c=h_vals, cmap="viridis", s=50)

# Achsen beschriften
ax.set_xlabel("Kognition (x)")
ax.set_ylabel("Sozial (y)")
ax.set_zlabel("Affektiv (z)")
ax.set_title("Semantische Dichte im FRZK")

# Farbskala hinzufügen
cbar = plt.colorbar(sc, ax=ax, shrink=0.6)
cbar.set_label("h_bedeutung (Semantische Dichte)")

plt.show()
