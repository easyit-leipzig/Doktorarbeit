# lernpfad_metrik_3d.py
# Abschnitt 3.6.3: Beispiel aus der Nachhilfe

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Brane-Funktion: Überlagerung mehrerer Hügel
def h(x, y, centers, sigmas, weights):
    z = np.zeros_like(x)
    for (cx, cy), s, w in zip(centers, sigmas, weights):
        z += w * np.exp(-((x - cx)**2 + (y - cy)**2) / (2 * s**2))
    return z

# Zentren = "Themen"
centers = [(0, 0), (3, -2), (-3, 2)]
sigmas  = [1.2, 1.5, 1.0]
weights = [1.0, 0.8, 0.6]

# Gitter
x = np.linspace(-6, 6, 120)
y = np.linspace(-6, 6, 120)
X, Y = np.meshgrid(x, y)
H = h(X, Y, centers, sigmas, weights)

# Lernpfad (einfacher Bogen durchs Zentrum)
t = np.linspace(-3, 3, 100)
x_path = t
y_path = np.sin(t)
z_path = h(x_path, y_path, centers, sigmas, weights)

# Plot
fig = plt.figure(figsize=(14, 14))
ax = fig.add_subplot(111, projection='3d')

# Oberfläche der Themenlandschaft
ax.plot_surface(X, Y, H, cmap='viridis', alpha=0.8)

# Lernpfad einzeichnen
ax.plot(x_path, y_path, z_path + 0.05, color="red", lw=2, label="Lernpfad")

# Achsen und Titel
ax.set_title("3.6.3 Lernpfad über Themenhügel", fontsize=14)
ax.set_xlabel("Themenachse x", fontsize=12)
ax.set_ylabel("Themenachse y", fontsize=12)
ax.set_zlabel("Schwierigkeit / Gewichtung h(x,y)", fontsize=12)
ax.legend()

plt.show()
