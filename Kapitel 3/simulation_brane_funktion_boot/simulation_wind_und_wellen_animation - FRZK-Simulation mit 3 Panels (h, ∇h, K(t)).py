import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, FFMpegWriter

# --- Parameter ---------------------------------------------------------------
L = 20
x = np.linspace(-L, L, 120)
y = np.linspace(-L, L, 120)
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
def gradient_and_orientation(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    return dZdx, dZdy, O

# --- Figure Setup ------------------------------------------------------------
fig = plt.figure(figsize=(15,5))
ax1 = fig.add_subplot(1,3,1)   # h(x,y)
ax2 = fig.add_subplot(1,3,2)   # ∇h (Pfeilfeld)
ax3 = fig.add_subplot(1,3,3)   # K(t)

plt.tight_layout()
K_values, T_values = [], []

# --- Update Funktion ---------------------------------------------------------
def update(t):
    ax1.clear(); ax2.clear(); ax3.clear()
    bx, by, bz = boat_pos(t)
    Z = h_total(X, Y, bz, t)
    dZdx, dZdy, O = gradient_and_orientation(Z)
    K = np.mean(O)
    K_values.append(K)
    T_values.append(t)

    # --- (1) Brane-Feld h(x,y,z,t)
    im1 = ax1.imshow(Z, cmap='plasma', extent=[-L,L,-L,L], origin='lower')
    ax1.scatter(bx, by, color='white', s=20, marker='x')
    ax1.set_title(f"h(x,y,z,t) – Brane-Feld (t={t:.1f})")
    ax1.set_xlabel("x"); ax1.set_ylabel("y")
    plt.colorbar(im1, ax=ax1, fraction=0.046, pad=0.04)

    # --- (2) Gradientenfeld (∇h)
    skip = (slice(None,None,5), slice(None,None,5))
    ax2.imshow(O, cmap='Greys', extent=[-L,L,-L,L], origin='lower', alpha=0.5)
    ax2.quiver(X[skip], Y[skip], dZdx[skip], dZdy[skip], color='blue', scale=40)
    ax2.scatter(bx, by, color='red', marker='x')
    ax2.set_title("Gradientenfeld ∇h(x,y) / Orientierung O(x,y)")
    ax2.set_xlabel("x"); ax2.set_ylabel("y")

    # --- (3) Kohärenzkurve K(t)
    ax3.plot(T_values, K_values, color='orange', linewidth=2)
    ax3.set_xlim(0, 40)
    ax3.set_ylim(0, 1)
    ax3.set_title("Kohärenzdynamik K(t)")
    ax3.set_xlabel("Zeit t"); ax3.set_ylabel("Kohärenzmaß")
    ax3.grid(True)

    return [ax1, ax2, ax3]

ani = FuncAnimation(fig, update, frames=np.linspace(0, 40, 100), interval=150)

# --- Optional: Video speichern ----------------------------------------------
# writer = FFMpegWriter(fps=15)
# ani.save("FRZK_Boot_Gradient_Kohärenz.mp4", writer=writer, dpi=200)

plt.show()
