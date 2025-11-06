import json
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.cm as cm
import matplotlib.colors as mcolors
from datetime import datetime

# JSON-Datei laden
with open("e:/xampp/htdocs/easyDidak/library/php/frzk_semantische_dichte.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Sortieren nach Zeit (wichtig für Trajektorie!)
data.sort(key=lambda d: d["zeitpunkt"])

# Koordinaten
x = [d["x_kognition"] for d in data]
y = [d["y_sozial"] for d in data]
z = [d["z_affektiv"] for d in data]
h = [d["h_bedeutung"] for d in data]

# Farbskala nach Zeit
norm = mcolors.Normalize(vmin=0, vmax=len(x)-1)
colors = cm.plasma(norm(range(len(x))))

# 3D-Plot
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection="3d")

# Trajektorie (Linie)
for i in range(len(x)-1):
    ax.plot(x[i:i+2], y[i:i+2], z[i:i+2], color=colors[i], linewidth=2)

# Punkte markieren
sc = ax.scatter(x, y, z, c=range(len(x)), cmap="plasma", s=50)

# Achsen
ax.set_xlabel("Kognition (x)")
ax.set_ylabel("Sozial (y)")
ax.set_zlabel("Affektiv (z)")
ax.set_title("3D-Trajektorie im FRZK-Raum")

# Farbleiste = Zeit
cbar = plt.colorbar(sc, ax=ax, shrink=0.6)
cbar.set_label("Zeitliche Reihenfolge")

plt.show()

# Extrahiere Dimensionen
x = np.array([d["x_kognition"] for d in data])
y = np.array([d["y_sozial"] for d in data])
z = np.array([d["z_affektiv"] for d in data])
h = np.array([d["h_bedeutung"] for d in data])

# --- Gradient berechnen (numerisch) ---
# Wir brauchen Gitterstruktur -> einfache Interpolation durch np.gradient
# Dazu nehmen wir h als Funktion der Indexreihenfolge
dh_dx = np.gradient(h, x, edge_order=1)
dh_dy = np.gradient(h, y, edge_order=1)
dh_dz = np.gradient(h, z, edge_order=1)

# Betrag des Gradienten
grad_h = np.sqrt(dh_dx**2 + dh_dy**2 + dh_dz**2)

# Normierung und Orientierungsverlust
max_grad = np.max(grad_h) if np.max(grad_h) > 0 else 1.0
O_t = 1 - (grad_h / max_grad)

# --- Visualisierung ---
plt.figure(figsize=(10, 6))
plt.plot(O_t, marker="o")
plt.title("Orientierungsverlust O(t) nach FRZK")
plt.xlabel("Zeit / Index")
plt.ylabel("O(t)")
plt.grid(True)
plt.show()
