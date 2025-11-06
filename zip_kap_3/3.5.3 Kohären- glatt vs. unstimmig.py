# 3_5_3_coherence_compare.py
# Vergleich zweier Branen: glatt vs. unstimmig

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def smooth_brane(X, Y):
    return np.exp(-0.4*(X**2 + Y**2))

def bumpy_brane(X, Y):
    return np.exp(-0.4*(X**2 + Y**2)) + 0.3*np.sin(5*X)*np.cos(4*Y)

x = np.linspace(-3,3,200)
y = np.linspace(-3,3,200)
X,Y = np.meshgrid(x,y)
Z1 = smooth_brane(X,Y)
Z2 = bumpy_brane(X,Y)

fig = plt.figure(figsize=(12,5))
ax1 = fig.add_subplot(121, projection='3d')
ax1.plot_surface(X, Y, Z1, cmap='viridis', alpha=0.9)
ax1.set_title("Kohärente Brane (glatt)")

ax2 = fig.add_subplot(122, projection='3d')
ax2.plot_surface(X, Y, Z2, cmap='viridis', alpha=0.9)
ax2.set_title("Inkohärente Brane (bumpy)")

plt.suptitle("3.5.3 Kohärenz: glatt vs. unstimmig")
plt.tight_layout()
plt.show()
