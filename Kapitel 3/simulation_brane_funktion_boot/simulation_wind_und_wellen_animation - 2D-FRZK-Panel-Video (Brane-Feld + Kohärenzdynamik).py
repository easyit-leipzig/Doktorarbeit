import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, FFMpegWriter

# --- Parameter ---------------------------------------------------------------
L = 20
x = np.linspace(-L, L, 150)
y = np.linspace(-L, L, 150)
X, Y = np.meshgrid(x, y)
A, k, ω = 1.0, 0.5, 0.8
v_wind = 0.8
r_boat, ωb = 8, 0.3
z_amp = 1.0

# --- Brane-Funktion (Wellen + Wind) ------------------------------------------
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

# --- Orientierungsmaß & Kohärenz ---------------------------------------------
def orientation_measure(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    return O

# --- Figure Setup -------------------------------------------------------------
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10,5))
plt.tight_layout()
K_values, T_values = [], []

# --- Update-Funktion für Animation -------------------------------------------
def update(t):
    ax1.clear(); ax2.clear()
    bx, by, bz = boat_pos(t)
    Z = h_total(X, Y, bz, t)
    O = orientation_measure(Z)
    K = np.mean(O)
    K_values.append(K)
    T_values.append(t)

    # --- (1) Heatmap der Brane-Funktion h(x,y,z,t)
    im = ax1.imshow(Z, cmap='plasma', extent=[-L,L,-L,L], origin='lower')
    ax1.scatter(bx, by, color='white', s=20, marker='x')
    ax1.set_title(f"Brane-Feld h(x,y,z,t) – t={t:.1f}")
    ax1.set_xlabel("x"); ax1.set_ylabel("y")
    plt.colorbar(im, ax=ax1, fraction=0.046, pad=0.04)

    # --- (2) Kohärenzmaß K(t)
    ax2.plot(T_values, K_values, color='orange', linewidth=2)
    ax2.set_xlim(0, 40)
    ax2.set_ylim(0, 1)
    ax2.set_xlabel("Zeit t")
    ax2.set_ylabel("Kohärenzmaß K(t)")
    ax2.set_title("Gesamtorientierung im System")
    ax2.grid(True)

    return [ax1, ax2]

ani = FuncAnimation(fig, update, frames=np.linspace(0, 40, 100), interval=150)

# --- Video speichern (optional) ----------------------------------------------
# writer = FFMpegWriter(fps=15)
# ani.save("FRZK_Boot_Kohärenz.mp4", writer=writer, dpi=200)

plt.show()
