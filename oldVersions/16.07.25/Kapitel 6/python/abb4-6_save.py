import numpy as np
import matplotlib.pyplot as plt
import os

# --- Setup ---
out_dir = "output"
os.makedirs(out_dir, exist_ok=True)

# Grid (x = kognitiv, y = sozial)
n = 120
x = np.linspace(-3, 3, n)
y = np.linspace(-3, 3, n)
X, Y = np.meshgrid(x, y)

# Hilfsfunktion: Gaussian Peak
def gaussian(x, y, cx, cy, sx=0.6):
    return np.exp(-(((x-cx)**2 + (y-cy)**2) / (2*sx**2)))

# --- 1) Flache semantische Dichte ---
h_flat = 0.2 + 0.02 * np.random.RandomState(0).normal(size=(n, n))

# --- 2) Strukturierte semantische Dichte ---
h_struct = (
    1.2 * gaussian(X, Y, -1.2, -0.5, sx=0.5)
    + 0.9 * gaussian(X, Y, 1.0, 0.8, sx=0.6)
    + 0.6 * gaussian(X, Y, -0.3, 1.6, sx=0.4)
    + 0.15
)

# --- Gradient und Orientierungsverlust ---
def orientation_loss(h, x, y):
    hx, hy = np.gradient(h, x, y)
    grad = np.sqrt(hx**2 + hy**2)
    maxg = np.max(grad)
    if maxg == 0:
        return np.ones_like(h)
    return 1.0 - grad / maxg

O_flat = orientation_loss(h_flat, x, y)
O_struct = orientation_loss(h_struct, x, y)

# --- Abbildung 1: Flache Dichte ---
fig1 = plt.figure(figsize=(8,6))
ax1 = fig1.add_subplot(111, projection='3d')
ax1.plot_surface(X, Y, h_flat, linewidth=0, antialiased=True)
ax1.set_title("Semantische Dichte (flach)")
ax1.set_xlabel("x (kognitiv)")
ax1.set_ylabel("y (sozial)")
ax1.set_zlabel("h(x,y)")
plt.savefig(os.path.join(out_dir, "h_flat_surface.png"), dpi=150, bbox_inches="tight")
plt.close(fig1)

# --- Abbildung 2: Strukturierte Dichte ---
fig2 = plt.figure(figsize=(8,6))
ax2 = fig2.add_subplot(111, projection='3d')
ax2.plot_surface(X, Y, h_struct, linewidth=0, antialiased=True)
ax2.set_title("Semantische Dichte (strukturiert)")
ax2.set_xlabel("x (kognitiv)")
ax2.set_ylabel("y (sozial)")
ax2.set_zlabel("h(x,y)")
plt.savefig(os.path.join(out_dir, "h_struct_surface.png"), dpi=150, bbox_inches="tight")
plt.close(fig2)

# --- Abbildung 3: Orientierungsverlust-Heatmap ---
fig3 = plt.figure(figsize=(7,6))
ax3 = fig3.add_subplot(111)
im = ax3.imshow(O_struct, extent=[x.min(), x.max(), y.min(), y.max()],
                origin='lower', aspect='auto')
ax3.set_title("Orientierungsverlust O(x,y)\nO = 1 - |∇h|/max(|∇h|)")
ax3.set_xlabel("x (kognitiv)")
ax3.set_ylabel("y (sozial)")
plt.colorbar(im, ax=ax3, label="O(x,y)")
plt.savefig(os.path.join(out_dir, "orientation_loss_heatmap.png"), dpi=150, bbox_inches="tight")
plt.close(fig3)
