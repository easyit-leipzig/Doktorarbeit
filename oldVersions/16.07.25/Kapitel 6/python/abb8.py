"""
Abb. 8 – Semantische Dichtefunktion h(x,y,z) im epistemischen Raum
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

# Raumgitter
x = np.linspace(-2, 2, 50)
y = np.linspace(-2, 2, 50)
X, Y = np.meshgrid(x, y)

# Semantische Dichtefunktion h(x,y,z) (vereinfachtes Modell: Summe von Gauß-Feldern)
def h(x, y):
    return np.exp(-((x-1)**2 + (y-1)**2)) + 0.6*np.exp(-((x+1)**2 + (y+0.5)**2))

Z = h(X, Y)

# 3D-Oberfläche plotten
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(111, projection="3d")
ax.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8)

ax.set_xlabel("x (kognitiver Zugriff)")
ax.set_ylabel("y (sozialer Kontext)")
ax.set_zlabel("h(x,y) (Semantische Dichte)")
ax.set_title("Abb. 8 – Semantische Dichtefunktion h(x,y,z)")
plt.show()
