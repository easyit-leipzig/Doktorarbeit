import json
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import griddata

# JSON-Datei laden
with open("e:/xampp/htdocs/easyDidak/library/php/frzk_semantische_dichte.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Daten extrahieren
x = np.array([d["x_kognition"] for d in data])
y = np.array([d["y_sozial"] for d in data])
z = np.array([d["z_affektiv"] for d in data])
h = np.array([d["h_bedeutung"] for d in data])

# --- Gitter erzeugen für Interpolation ---
grid_x, grid_y, grid_z = np.mgrid[
    min(x):max(x):30j,
    min(y):max(y):30j,
    min(z):max(z):30j
]

# h auf Gitter interpolieren
grid_h = griddata(
    points=(x, y, z),
    values=h,
    xi=(grid_x, grid_y, grid_z),
    method="linear"
)

# --- Gradient berechnen ---
dh_dx, dh_dy, dh_dz = np.gradient(grid_h)
grad_h = np.sqrt(dh_dx**2 + dh_dy**2 + dh_dz**2)

# --- Orientierungsverlust ---
max_grad = np.nanmax(grad_h) if np.nanmax(grad_h) > 0 else 1.0
O_field = 1 - (grad_h / max_grad)

# --- 3D Scatterplot der Punkte mit O(t)-Farbcodierung ---
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection="3d")

sc = ax.scatter(x, y, z, c=O_field.flatten()[~np.isnan(O_field.flatten())][:len(x)],
                cmap="inferno", s=50, alpha=0.8)

ax.set_xlabel("Kognition (x)")
ax.set_ylabel("Sozial (y)")
ax.set_zlabel("Affektiv (z)")
ax.set_title("Orientierungsverlust O(x,y,z)")

cbar = plt.colorbar(sc, ax=ax, shrink=0.6)
cbar.set_label("O(x,y,z) (Orientierungsverlust)")

plt.show()
