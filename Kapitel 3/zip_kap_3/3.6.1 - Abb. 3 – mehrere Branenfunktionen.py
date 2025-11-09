import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Create grid
x = np.linspace(-3, 3, 100)
y = np.linspace(-3, 3, 100)
X, Y = np.meshgrid(x, y)

# Define three separate brane functions (for x, y, z directions)
Zx = np.exp(-((X-1.5)**2 + Y**2))  # Brane along x-axis
Zy = np.exp(-(X**2 + (Y+1.5)**2))  # Brane along y-axis
Zz = np.exp(-((X+1.5)**2 + (Y-1.5)**2))  # Brane along z-axis (third field)

# Combined field as sum of all three Branes
Z_combined = (Zx + Zy + Zz) / 3

# Single global Brane (homogeneous field)
Z_single = np.exp(-(X**2 + Y**2))

# Plot setup
fig = plt.figure(figsize=(18, 6))

# --- Single Brane ---
ax1 = fig.add_subplot(1, 3, 1, projection='3d')
ax1.plot_surface(X, Y, Z_single, cmap='viridis', alpha=0.9)
ax1.set_title('Eine Brane-Funktion  h(x, y)')
ax1.set_xlabel('x')
ax1.set_ylabel('y')
ax1.set_zlabel('Kohärenz h')

# --- Three Separate Branes ---
ax2 = fig.add_subplot(1, 3, 2, projection='3d')
ax2.plot_surface(X, Y, Zx, cmap='Reds', alpha=0.7)
ax2.plot_surface(X, Y, Zy, cmap='Blues', alpha=0.7)
ax2.plot_surface(X, Y, Zz, cmap='Greens', alpha=0.7)
ax2.set_title('Drei Brane-Funktionen  h_x, h_y, h_z')
ax2.set_xlabel('x')
ax2.set_ylabel('y')
ax2.set_zlabel('Kohärenz h_i')

# --- Combined Field (Kohärenzraum) ---
ax3 = fig.add_subplot(1, 3, 3, projection='3d')
ax3.plot_surface(X, Y, Z_combined, cmap='plasma', alpha=0.9)
ax3.set_title('Überlagerte Kohärenz h(x, y, z)')
ax3.set_xlabel('x')
ax3.set_ylabel('y')
ax3.set_zlabel('h_total')

plt.tight_layout()
plt.show()