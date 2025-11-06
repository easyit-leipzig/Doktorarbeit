# --- 3.6.4 Richtungsabhängige Brane-Funktionen ---
# Visualisierung der Branen h_x, h_y, h_z und der resultierenden Gesamtbrane H

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.patches import Patch
from matplotlib.lines import Line2D

# Gitterdefinition
n = 120
x = np.linspace(-2.5, 2.5, n)
y = np.linspace(-2.5, 2.5, n)
X, Y = np.meshgrid(x, y)

# Richtungsabhängige Branen (anisotrope Gauß-Funktionen)
# Jede beschreibt eine partielle Kohärenz entlang einer Raumrichtung
hx = np.exp(-(((X - 0.8) ** 2) / (2 * 0.4 ** 2) + (Y ** 2) / (2 * 1.2 ** 2)))       # x-Komponente
hy = np.exp(-(((X) ** 2) / (2 * 1.2 ** 2) + ((Y + 0.6) ** 2) / (2 * 0.45 ** 2)))   # y-Komponente
hz = 0.8 * np.exp(-(((X + 0.4) ** 2) / (2 * 0.9 ** 2) + ((Y - 0.2) ** 2) / (2 * 0.9 ** 2)))  # z-Komponente

# Kombinierte Kohärenz (Vektornorm)
H = np.sqrt(hx**2 + hy**2 + hz**2)

# --- Visualisierung ---
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Teilbranen als halbtransparente Flächen
ax.plot_surface(X, Y, hx, rstride=3, cstride=3, linewidth=0, alpha=0.55)
ax.plot_surface(X, Y, hy, rstride=3, cstride=3, linewidth=0, alpha=0.55)
ax.plot_surface(X, Y, hz, rstride=3, cstride=3, linewidth=0, alpha=0.55)

# Gesamtbrane als Drahtgitter
ax.plot_wireframe(X, Y, H, rstride=6, cstride=6, linewidth=0.8, color='black')

# Achsenbeschriftung
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('h(x,y)')
ax.set_title('Richtungsabhängige Brane-Funktionen $h_x, h_y, h_z$ und Gesamtfeld $H$')

# Legende
proxy_surfs = [Patch(alpha=0.6), Patch(alpha=0.6), Patch(alpha=0.6), Line2D([0], [0], color='k', lw=1)]
ax.legend(proxy_surfs, ['$h_x$', '$h_y$', '$h_z$', 'Gesamt $H$'], loc='upper right')

# Perspektive
ax.view_init(elev=25, azim=-60)

plt.tight_layout()
plt.show()
