import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Gitter für Raum
x = np.linspace(-3, 3, 100)
y = np.linspace(-3, 3, 100)
X, Y = np.meshgrid(x, y)

# Semantische Dichte: nur ein Hub bei einem Lernenden (z.B. rechts auf dem Kreis)
hub_pos = (2, 0)
sigma = 0.8
Z = np.exp(-((X-hub_pos[0])**2 + (Y-hub_pos[1])**2) / (2*sigma**2))

# Plot
fig = plt.figure(figsize=(15,20))
ax = fig.add_subplot(111, projection='3d')

ax.plot_surface(X, Y, Z, cmap='plasma', alpha=0.9)

# Teilnehmer auf dem Kreis markieren
n = 5
winkel = np.linspace(0, 2*np.pi, n, endpoint=False)
px = 2*np.cos(winkel)
py = 2*np.sin(winkel)
pz = np.exp(-((px-hub_pos[0])**2 + (py-hub_pos[1])**2) / (2*sigma**2))

ax.scatter(px, py, pz, c='blue', s=60, label="Lernende")
ax.scatter(hub_pos[0], hub_pos[1], 1, c='red', s=100, marker="*", label="Hub (nur 1 Verbindung)")

ax.set_title("Gruppe B – Ohne Hubs (Orientierungsverlust)")
ax.set_xlabel("x")
ax.set_ylabel("y")
ax.set_zlabel("Semantische Dichte")
ax.legend()

plt.show()
