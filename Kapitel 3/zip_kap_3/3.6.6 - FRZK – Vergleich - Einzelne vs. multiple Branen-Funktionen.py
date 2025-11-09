# ======================================================
# FRZK – Visualisierung der Brane-Funktionen h_xy, h_xz, h_yz
# Abschnitt 3.6.1 – Relationale Definition der Branen
# ======================================================

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Erzeuge ein 3D-Raster
x = np.linspace(-3, 3, 200)
y = np.linspace(-3, 3, 200)
X, Y = np.meshgrid(x, y)

# ------------------------------------------------------
# Definition der drei Brane-Funktionen:
# Jede Brane beschreibt eine mögliche funktionale Relation
# zwischen zwei Richtungen, die durch das Bezugssystem aktiviert wird.
# ------------------------------------------------------

# 1. h_xy: horizontale–laterale Relation (z.B. Wellenfeld)
h_xy = np.cos(X) * np.sin(Y)

# 2. h_xz: horizontale–vertikale Relation (z.B. Windneigung)
# Wir simulieren Z als Skalarfunktion des X-Felds
Z_sim = np.sin(X / 2)
h_xz = np.sin(X) * np.cos(Z_sim)

# 3. h_yz: vertikale–laterale Relation (z.B. Tiefenstabilität)
h_yz = np.sin(Y) * np.sin(Z_sim)

# Gesamtkohärenz: Mittelwert der aktivierten Branen
H_total = (h_xy + h_xz + h_yz) / 3

# ------------------------------------------------------
# Visualisierung 1: Nur eine aktivierte Brane (h_xy)
# ------------------------------------------------------
fig = plt.figure(figsize=(12, 5))
ax1 = fig.add_subplot(1, 2, 1, projection='3d')
ax1.plot_surface(X, Y, h_xy, cmap='viridis', alpha=0.9)
ax1.set_title("Eine aktivierte Brane: h_xy(U)\nIsotrope Kohärenz (ein Bezugssystem)")
ax1.set_xlabel('x-Richtung')
ax1.set_ylabel('y-Richtung')
ax1.set_zlabel('Kohärenz h_xy')

# ------------------------------------------------------
# Visualisierung 2: Überlagerung der drei Branen
# ------------------------------------------------------
ax2 = fig.add_subplot(1, 2, 2, projection='3d')
ax2.plot_surface(X, Y, H_total, cmap='plasma', alpha=0.9)
ax2.set_title("Aktivierte Relationen h_xy, h_xz, h_yz\nÜberlagerte Kohärenzflächen (mehrere Bezugssysteme)")
ax2.set_xlabel('x-Richtung')
ax2.set_ylabel('y-Richtung')
ax2.set_zlabel('Gesamtkohärenz H_total')

# Layout und Anzeige
plt.suptitle("FRZK – Vergleich: Einzelne vs. multiple Branen-Funktionen", fontsize=13, y=0.95)
plt.tight_layout()
plt.show()
