"""
Abb. 6 – Semantische Dichtefunktion h(x,y,z) im epistemischen Raum
------------------------------------------------------------------
Darstellung des epistemischen Raums als 3D-Oberfläche mit Dichte-Peaks.
Achsen:
x = kognitiver Zugriff
y = sozialer Kontext
z = affektive Beteiligung
"""
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Beispielhafte Funktion h(x, y, z) mit den Dichte-Peaks
def h(x, y, z, hubs):
    density = np.zeros_like(x)
    for (hx, hy, hz) in hubs:
        # Berechnet den Abstand und die Dichte (z.B. Gaußsche Funktion)
        distance = np.sqrt((x - hx)**2 + (y - hy)**2 + (z - hz)**2)
        density += np.exp(-0.5 * distance**2)
    return density

# Erstelle Gitter für X, Y und Z
x = np.linspace(-3, 3, 100)
y = np.linspace(-3, 3, 100)
z = np.linspace(-3, 3, 100)
X, Y, Z = np.meshgrid(x, y, z)

# Definiere die Hubs (Dichte-Peaks)
hubs = [(1, 1, 0), (-1, -0.5, 0.5)]

# Zeitdimension hinzufügen
t = np.linspace(0, 5, 100)

# Beispiel: zeitliche Veränderung der Dichtefunktion
Z_t0 = h(X, Y, Z, hubs)
Z_t1 = h(X * 0.9, Y * 1.1, Z * 1.05, hubs)  # leicht veränderte Position der Hubs
dZ_dt = Z_t1 - Z_t0

# Plot der Veränderung der Dichte
fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection="3d")
ax.plot_surface(X[:, :, 50], Y[:, :, 50], dZ_dt[:, :, 50], cmap="coolwarm", alpha=0.9)

ax.set_xlabel("x (kognitiver Zugriff)")
ax.set_ylabel("y (sozialer Kontext)")
ax.set_zlabel("Δh (Veränderung)")
ax.set_title("Abb. 6 – Veränderung der semantischen Dichte dh/dt")
plt.show()