import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# --- Parameter -----------------------------------------------------------------
L = 20
x = np.linspace(-L, L, 150)
y = np.linspace(-L, L, 150)
X, Y = np.meshgrid(x, y)
k, ω = 0.5, 0.8
z = 1.0
T = np.linspace(0, 40, 100)

# --- Brane-Funktionen ----------------------------------------------------------
def h1(x, y, t):  # konstante Wellen, linearer Wind
    A = 1.0
    wind = 0.05 * t * z
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

def h2(x, y, t):  # lineare Wellen, konstanter Wind
    A = 0.05 * t
    wind = 0.5
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

def h3(x, y, t):  # beide linear
    A = 0.05 * t
    wind = 0.05 * t * z
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

# --- Orientierung & Kohärenz ---------------------------------------------------
def orientation_measure(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    return np.mean(O)

# --- Berechne Kohärenz für alle Szenarien -------------------------------------
K = np.zeros((3, len(T)))  # Matrix für s=1,2,3 und t

for i, h_func in enumerate([h1, h2, h3]):
    for j, t in enumerate(T):
        Z = h_func(X, Y, t)
        K[i, j] = orientation_measure(Z)

# --- 3D-Fläche vorbereiten -----------------------------------------------------
S, TT = np.meshgrid(np.arange(1,4), T)
KK = K.T  # transponiert für richtige Achsenorientierung

# --- Plot ---------------------------------------------------------------------
fig = plt.figure(figsize=(10,6))
ax = fig.add_subplot(111, projection='3d')

surf = ax.plot_surface(TT, S, KK, cmap='plasma', alpha=0.9)
ax.set_xlabel("Zeit t")
ax.set_ylabel("Szenario s")
ax.set_zlabel("Kohärenzmaß K(t,s)")
ax.set_title("3D-Kohärenzlandschaft – FRZK-Systeme (Wellen/Wind)")
ax.set_yticks([1,2,3])
ax.set_yticklabels([
    "1️⃣ konst. Wellen / linearer Wind",
    "2️⃣ linear. Wellen / konst. Wind",
    "3️⃣ beide linear"
])
fig.colorbar(surf, shrink=0.5, aspect=10, pad=0.1)
plt.tight_layout()
plt.show()
