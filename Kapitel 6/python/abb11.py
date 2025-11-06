"""
Abb. 11 – Semantische Dichtefunktion h(x,y,z) im epistemischen Raum
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

# Beispielhafte Definition von h(x, y) (z.B. eine Gauss-Funktion)
def h(x, y):
    return np.exp(-0.5 * (x**2 + y**2))

# Gitter für X und Y erstellen
x = np.linspace(-3, 3, 100)
y = np.linspace(-3, 3, 100)
X, Y = np.meshgrid(x, y)

# Berechnung von Z basierend auf X und Y
Z = h(X, Y)

# Hubs
hubs = [(1, 1), (-1, -0.5)]

# Plot erstellen
fig = plt.figure(figsize=(12, 14))
ax = fig.add_subplot(111, projection="3d")
ax.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8)

# Hubs einzeichnen
for hx, hy in hubs:
    hz = h(hx, hy)
    ax.scatter(hx, hy, hz, color="red", marker="X", s=100)

# Achsen und Titel
ax.set_xlabel("x (kognitiver Zugriff)")
ax.set_ylabel("y (sozialer Kontext)")
ax.set_zlabel("h(x,y)")
ax.set_title("Abb. 11 – Hubs im epistemischen Raum")
plt.show()