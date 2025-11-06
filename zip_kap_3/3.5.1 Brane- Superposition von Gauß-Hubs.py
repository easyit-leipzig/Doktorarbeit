# 3_5_1_brane_gaussians.py
# Visualisiert h(x,y) = sum_k w_k * exp(-||x-xk||^2 / (2 sigma_k^2))

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def brane_h(X, Y, centers, sigmas, weights):
    Z = np.zeros_like(X)
    for (cx, cy), s, w in zip(centers, sigmas, weights):
        Z += w * np.exp(-((X-cx)**2 + (Y-cy)**2) / (2*s**2))
    return Z

# Parameter: drei Gauß-Hubs
centers = [( -1.5,  0.5), (1.0, -0.5), (2.5, 1.5)]
sigmas  = [0.9, 0.7, 1.1]
weights = [1.0, 0.8, 0.6]

# Gitter
x = np.linspace(-4, 4, 200)
y = np.linspace(-4, 4, 200)
X, Y = np.meshgrid(x, y)
Z = brane_h(X, Y, centers, sigmas, weights)

# Plot 3D Oberfläche und Kontur
fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(121, projection='3d')
ax.plot_surface(X, Y, Z, cmap='viridis', linewidth=0, antialiased=True, alpha=0.9)
ax.set_title("3.5.1 Brane: Superposition von Gauß-Hubs")
ax.set_xlabel("x"); ax.set_ylabel("y"); ax.set_zlabel("h(x,y)")

ax2 = fig.add_subplot(122)
cnt = ax2.contourf(X, Y, Z, levels=30)
ax2.set_title("Konturplot der Brane")
ax2.set_xlabel("x"); ax2.set_ylabel("y")
fig.colorbar(cnt, ax=ax2, shrink=0.8)
plt.tight_layout()
plt.show()
