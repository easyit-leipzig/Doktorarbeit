import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Zufallsdaten für die Punktwolke (simulierter epistemischer Raum)
np.random.seed(42)
N = 500
x = np.random.normal(0, 2, N)
y = np.random.normal(0, 2, N)
z = np.random.normal(0, 2, N)

# Definition einiger epistemischer Hubs (schwarze Marker)
hubs = np.array([
    [2, 2, 0],
    [-2, -1, 1],
    [0, 3, -2]
])

# Semantische Dichtefunktion h(x,y,z)
def h(x, y, z, hubs):
    density = np.zeros_like(x)
    for hx, hy, hz in hubs:
        density += np.exp(-((x - hx)**2 + (y - hy)**2 + (z - hz)**2) / (2 * 1.5**2))
    return density

density = h(x, y, z, hubs)

# 3D-Scatterplot
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Punktwolke einfärben nach Dichte
p = ax.scatter(x, y, z, c=density, cmap='viridis', s=20, alpha=0.7)

# Hubs als schwarze Marker einzeichnen
ax.scatter(hubs[:,0], hubs[:,1], hubs[:,2], c='black', s=100, marker='X', label='Hubs')

# Achsenbeschriftungen
ax.set_xlabel("Kognitiver Zugriff (x)")
ax.set_ylabel("Sozialer Kontext (y)")
ax.set_zlabel("Affektive Beteiligung (z)")
ax.set_title("Abb. 8 – FRZK semantische Dichte (3D-Scatter)")

fig.colorbar(p, ax=ax, label="Semantische Dichte h(x,y,z)")
ax.legend()

# Datei speichern
plt.savefig("frzk_semantic_density_3d_scatter.png", dpi=300, bbox_inches='tight')
plt.show()
