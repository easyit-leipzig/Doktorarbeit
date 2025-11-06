# 3_5_7_sea_film_like.py
# Simuliert eine einfache glättende Membran über Knoten (Laplace relaxation)

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Gitter
n = 60
X = np.linspace(-2,2,n)
Y = np.linspace(-2,2,n)
XX, YY = np.meshgrid(X, Y)
Z = np.zeros_like(XX)

# Set fixed rim values (simulate wires/sticks at boundary)
Z[0,:] = 0.5
Z[-1,:] = 0.5
Z[:,0] = 0.2
Z[:,-1] = 0.2

# Relaxation (Laplace iterative smoothing)
for it in range(800):
    Z[1:-1,1:-1] = 0.25*(Z[1:-1,2:] + Z[1:-1,:-2] + Z[2:,1:-1] + Z[:-2,1:-1])

fig = plt.figure(figsize=(9,6))
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(XX, YY, Z, cmap='viridis', alpha=0.9)
ax.set_title("3.5.7 Seifenfilm-Analogie: entspannte Membran")
plt.show()
