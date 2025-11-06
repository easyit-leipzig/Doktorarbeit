# 3_5_2_pointcloud_to_surface.py
# Erzeugt zufällige Punkte und eine RBF-Interpolation als Fläche

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from scipy.interpolate import Rbf

# Zufällige Punkte (als "Schülerpunkte")
np.random.seed(2)
n = 25
px = np.random.uniform(-3,3,n)
py = np.random.uniform(-3,3,n)
# simulierte "Werte" hi (z): z.B. unterschiedliche Wichtigkeit
pz = np.exp(-0.5*(px**2 + py**2)) + 0.1*np.random.randn(n)

# RBF Interpolation
rbf = Rbf(px, py, pz, function='multiquadric', epsilon=1)
xi = np.linspace(-3, 3, 120)
yi = np.linspace(-3, 3, 120)
XI, YI = np.meshgrid(xi, yi)
ZI = rbf(XI, YI)

# Plot Punkte + interpolierte Fläche
fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(XI, YI, ZI, cmap='viridis', alpha=0.85)
ax.scatter(px, py, pz, c='red', s=40, label='Punkte (Schüler)')
ax.set_title("3.5.2 Punktewolke → emergente Brane (RBF-Interpolation)")
ax.set_xlabel("x"); ax.set_ylabel("y"); ax.set_zlabel("h")
ax.legend()
plt.show()
