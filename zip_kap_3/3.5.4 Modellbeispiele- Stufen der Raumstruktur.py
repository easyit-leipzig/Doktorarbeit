# 3_5_4_brane_types.py
# Vier exemplarische Branen: homogen, gebrochen, lokalisiert, extrem

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

x = np.linspace(-3,3,150); y = np.linspace(-3,3,150)
X,Y = np.meshgrid(x,y)

# homogen
Z_hom = np.ones_like(X)*0.5

# symmetriegebrochen: linearer Gradient + sinus Störung
Z_broken = 0.2*(X+Y) + 0.15*np.sin(3*X)

# lokalisiert: scharfer Hügel
Z_local = np.exp(-((X-1.0)**2 + (Y+0.5)**2)/(0.3**2))

# extrem: nahe an Singularität (steiler Peak)
Z_extreme = 1.0 / (1 + ((X-0.2)**2 + (Y-0.1)**2)/0.02)

fig = plt.figure(figsize=(12,10))
titles = ["Homogene Brane", "Symmetriegebrochene Brane", "Lokalisierte Brane", "Extreme Brane"]
Zs = [Z_hom, Z_broken, Z_local, Z_extreme]

for i, Z in enumerate(Zs,1):
    ax = fig.add_subplot(2,2,i, projection='3d')
    ax.plot_surface(X, Y, Z, cmap='viridis', linewidth=0, antialiased=True)
    ax.set_title(titles[i-1])
    ax.set_xticks([]); ax.set_yticks([]); ax.set_zticks([])

plt.suptitle("3.5.4 Modellbeispiele: Stufen der Raumstruktur", fontsize=14)
plt.tight_layout()
plt.show()
