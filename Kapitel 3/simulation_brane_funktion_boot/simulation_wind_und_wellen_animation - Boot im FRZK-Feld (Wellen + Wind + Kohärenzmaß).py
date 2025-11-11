import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# --- Parameter ---------------------------------------------------------------
L = 20                      # Raumgröße
x = np.linspace(-L, L, 200)
y = np.linspace(-L, L, 200)
X, Y = np.meshgrid(x, y)
A, k, ω = 1.0, 0.5, 0.8     # Wellenamplitude, Wellenzahl, Kreisfrequenz
v_wind = 0.8                # Windstärke
r_boat, ωb = 8, 0.3         # Radius & Winkelgeschwindigkeit Boot
z_amp = 1.0                 # Windmodulation Boot (z-Komponente)

# --- Brane-Funktionen --------------------------------------------------------
def h_wave(x, y, t):
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t)

def h_wind(x, y, z, t):
    return v_wind * z * np.sin(0.3 * t)

def h_total(x, y, z, t):
    return h_wave(x, y, t) + 0.5 * h_wind(x, y, z, t)

def boat_pos(t):
    x = r_boat * np.cos(ωb * t)
    y = r_boat * np.sin(ωb * t)
    z = z_amp * np.sin(0.2 * t)
    return x, y, z

# --- Gradient und Orientierungsmaß ------------------------------------------
def orientation_measure(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    return O, grad_mag

# --- Visualisierung ----------------------------------------------------------
fig = plt.figure(figsize=(12,5))
ax1 = fig.add_subplot(1,2,1, projection='3d')
ax2 = fig.add_subplot(1,2,2)

def update(t):
    ax1.clear(); ax2.clear()
    bx, by, bz = boat_pos(t)
    Z = h_total(X, Y, bz, t)
    O, grad = orientation_measure(Z)

    # --- 3D Brane-Feld mit Boot
    ax1.plot_surface(X, Y, Z, cmap='plasma', alpha=0.8)
    ax1.scatter(bx, by, h_total(bx, by, bz, t) + 0.3, color='red', s=50)
    ax1.set_title(f"Brane-Funktion h(x,y,z,t) – Boot bei t={t:.1f}")
    ax1.set_zlim(-2, 2)

    # --- Orientierung (Heatmap)
    ax2.imshow(O, cmap='viridis', extent=[-L, L, -L, L], origin='lower')
    ax2.set_title("Orientierungsmaß O(x,y)")
    ax2.set_xlabel("x"); ax2.set_ylabel("y")
    ax2.scatter(bx, by, color='red', marker='x')
    ax2.text(bx+1, by+1, f"O={O[100,100]:.2f}", color='white')

    return ax1, ax2

ani = FuncAnimation(fig, update, frames=np.linspace(0, 40, 80), interval=150)
plt.show()
