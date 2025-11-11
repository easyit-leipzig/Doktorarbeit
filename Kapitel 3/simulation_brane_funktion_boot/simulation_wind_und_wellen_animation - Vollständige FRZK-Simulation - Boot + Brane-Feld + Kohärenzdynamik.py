import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# --- Parameter ---------------------------------------------------------------
L = 20
x = np.linspace(-L, L, 150)
y = np.linspace(-L, L, 150)
X, Y = np.meshgrid(x, y)
A, k, ω = 1.0, 0.5, 0.8
v_wind = 0.8
r_boat, ωb = 8, 0.3
z_amp = 1.0

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

# --- Gradient & Orientierung -------------------------------------------------
def orientation_measure(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    return O, grad_mag

# --- Setup der Visualisierung ------------------------------------------------
fig = plt.figure(figsize=(14,5))
ax1 = fig.add_subplot(1,3,1, projection='3d')  # Brane-Feld
ax2 = fig.add_subplot(1,3,2)                   # O(x,y)
ax3 = fig.add_subplot(1,3,3)                   # K(t)-Diagramm

K_values, T_values = [], []

def update(t):
    ax1.clear(); ax2.clear(); ax3.clear()
    bx, by, bz = boat_pos(t)
    Z = h_total(X, Y, bz, t)
    O, grad = orientation_measure(Z)
    K = np.mean(O)
    K_values.append(K)
    T_values.append(t)

    # --- (1) 3D-Brane-Feld mit Boot
    ax1.plot_surface(X, Y, Z, cmap='plasma', alpha=0.85)
    ax1.scatter(bx, by, h_total(bx, by, bz, t)+0.3, color='red', s=50)
    ax1.set_title(f"Brane-Funktion h(x,y,z,t) – Boot (t={t:.1f})")
    ax1.set_zlim(-2, 2)

    # --- (2) Heatmap O(x,y)
    ax2.imshow(O, cmap='viridis', extent=[-L, L, -L, L], origin='lower')
    ax2.scatter(bx, by, color='red', marker='x')
    ax2.set_title("Orientierungsmaß O(x,y)")
    ax2.set_xlabel("x"); ax2.set_ylabel("y")

    # --- (3) Kohärenzkurve K(t)
    ax3.plot(T_values, K_values, color='orange')
    ax3.set_xlim(0, 40)
    ax3.set_ylim(0, 1)
    ax3.set_title("Kohärenzdynamik K(t)")
    ax3.set_xlabel("Zeit t")
    ax3.set_ylabel("Kohärenzmaß (1 = Desorientierung)")
    ax3.grid(True)

    return ax1, ax2, ax3

ani = FuncAnimation(fig, update, frames=np.linspace(0,40,100), interval=150)
plt.tight_layout()
plt.show()
