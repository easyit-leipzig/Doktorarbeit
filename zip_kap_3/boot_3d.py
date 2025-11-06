# boat_path_3d.py
# Darstellung: 3D-Pfad eines Bootes auf Kreisbahn mit sinusförmigem Schaukeln
# Abhängigkeiten: numpy, matplotlib

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# -------- Parameter --------
R = 5.0                 # Radius der Kreisbahn (xy-Ebene)
omega = 0.8             # Umlaufwinkelgeschwindigkeit (rad/s)
t_max = 20.0            # Simulationsdauer (s)
n_points = 400

# Schaukelfunktionen (Basisamplituden)
A_pitch = 0.25
A_roll  = 0.15
k_pitch = 2.0
k_roll  = 2.5

# Brane-Funktion (h(x,y)) als Gaußhügel
def h_brane(x, y, centers=[(0.0, 0.0)], sigmas=[2.0], weights=[1.0]):
    z = np.zeros_like(x)
    for (cx, cy), sigma, w in zip(centers, sigmas, weights):
        z += w * np.exp(-((x-cx)**2 + (y-cy)**2) / (2 * sigma**2))
    return z

# Mapping: lokale h modifiziert Schaukelamplitude
def local_amplitude_factor(hval, factor=1.2):
    return 1.0 + factor * hval

# -------- Berechne Trajektorie --------
t_vals = np.linspace(0, t_max, n_points)
x_vals = R * np.cos(omega * t_vals)
y_vals = R * np.sin(omega * t_vals)

# z-Komponente: kombinierte Schaukelbewegung (Pitch + Roll als "Höhe")
z_vals = []
for t, x, y in zip(t_vals, x_vals, y_vals):
    h_local = h_brane(np.array([x]), np.array([y]),
                      centers=[(0.0,0.0),(3.0,-2.0)],
                      sigmas=[2.5,1.2], weights=[0.8,0.5])[0]
    amp_factor = local_amplitude_factor(h_local)
    pitch = A_pitch * amp_factor * np.sin(k_pitch * t)
    roll  = A_roll  * amp_factor * np.sin(k_roll  * t + 0.7)
    z_vals.append(0.5 * (pitch + roll))  # einfache Kombination als z-Verschiebung
z_vals = np.array(z_vals)

# -------- Plot --------
fig = plt.figure(figsize=(10,7))
ax = fig.add_subplot(111, projection='3d')

# Bootspfad
ax.plot(x_vals, y_vals, z_vals, color="red", lw=2, label="Bootsweg (mit Schaukel)")

# Kreisbahn in xy (z=0)
theta = np.linspace(0, 2*np.pi, 200)
ax.plot(R*np.cos(theta), R*np.sin(theta), np.zeros_like(theta),
        "--", color="k", alpha=0.5, label="Kreisbahn (ohne Schaukel)")

# Brane-Oberfläche im Hintergrund
grid_n = 80
xg = np.linspace(-8, 8, grid_n)
yg = np.linspace(-8, 8, grid_n)
Xg, Yg = np.meshgrid(xg, yg)
Hg = h_brane(Xg, Yg,
             centers=[(0.0,0.0),(3.0,-2.0)],
             sigmas=[2.5,1.2], weights=[0.8,0.5])
ax.plot_surface(Xg, Yg, Hg*0.4 - 0.5, cmap='viridis', alpha=0.6)

# Achsen
ax.set_xlabel("x")
ax.set_ylabel("y")
ax.set_zlabel("z (Schaukel + Brane)")
ax.set_title("3D-Pfad des Bootes (ohne Animation)")
ax.legend()
ax.set_box_aspect([1,1,0.6])

plt.show()
