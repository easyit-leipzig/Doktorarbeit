# brane_learning_path_3d.py
# Beispiel: Wirkung der Brane-Funktion auf einen Lernpfad im 3D-Didaktikraum
# Abhängigkeiten: numpy, matplotlib

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# -------- Brane-Funktion als Gaußhügel --------
def h_brane(x, y, centers=[(0.0, 0.0)], sigmas=[1.5], weights=[1.0]):
    z = np.zeros_like(x)
    for (cx, cy), sigma, w in zip(centers, sigmas, weights):
        z += w * np.exp(-((x - cx)**2 + (y - cy)**2) / (2 * sigma**2))
    return z

# -------- Lernpfad definieren --------
t_vals = np.linspace(0, 1, 200)
x_path = -2 + 4 * t_vals          # Bewegung von links nach rechts
y_path = np.sin(2 * np.pi * t_vals)  # Schwankung wie Lernkurven
z_path = h_brane(x_path, y_path,
                 centers=[(-1, 0.5), (1.2, -0.5)],
                 sigmas=[0.8, 1.0],
                 weights=[1.0, 0.7])  # Brane-Werte = Höhe

# -------- Oberfläche der Brane --------
xg = np.linspace(-3, 3, 100)
yg = np.linspace(-2, 2, 100)
Xg, Yg = np.meshgrid(xg, yg)
Zg = h_brane(Xg, Yg,
             centers=[(-1, 0.5), (1.2, -0.5)],
             sigmas=[0.8, 1.0],
             weights=[1.0, 0.7])

# -------- Plot --------0
fig = plt.figure(figsize=(23,23))
ax = fig.add_subplot(111, projection='3d')

# Brane-Oberfläche
ax.plot_surface(Xg, Yg, Zg, cmap="viridis", alpha=0.7)

# Lernpfad
ax.plot(x_path, y_path, z_path, color="red", lw=2, label="Lernpfad")

# Brane-Zentren markieren
ax.scatter([-1, 1.2], [0.5, -0.5], [h_brane(np.array([-1,1.2]), np.array([0.5,-0.5]),
                                            centers=[(-1, 0.5), (1.2, -0.5)],
                                            sigmas=[0.8, 1.0],
                                            weights=[1.0, 0.7])],
           color="white", edgecolor="black", s=100, marker="X", label="Bedeutungszentren")

# Achsen & Labels
ax.set_xlabel("Themenraum X")
ax.set_ylabel("Themenraum Y")
ax.set_zlabel("Brane-Wertigkeit h(x,y)")
ax.set_title("3D-Brane-Oberfläche mit Lernpfad")
ax.legend()
ax.set_box_aspect([1,1,0.6])
plt.rcParams.update({'font.size': 34})
plt.show()
