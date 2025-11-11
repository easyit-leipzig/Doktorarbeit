import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# --- Parameter ---------------------------------------------------------------
L = 20
x = np.linspace(-L, L, 150)
y = np.linspace(-L, L, 150)
X, Y = np.meshgrid(x, y)
k, ω = 0.5, 0.8
z = 1.0  # feste z-Höhe
r_boat, ωb = 8, 0.3

def boat_pos(t):
    x = r_boat * np.cos(ωb * t)
    y = r_boat * np.sin(ωb * t)
    return x, y

# --- Szenario 1: konstante Wellen, linearer Wind -----------------------------
def h_const_wave_linear_wind(x, y, t):
    A = 1.0                # konstante Wellenamplitude
    wind = 0.05 * t * z    # linearer Windanstieg
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

# --- Szenario 2: lineare Wellenamplitude, konstanter Wind -------------------
def h_linear_wave_const_wind(x, y, t):
    A = 0.05 * t           # linear steigende Wellenamplitude
    wind = 0.5             # konstanter Wind
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

# --- Szenario 3: Kombination (beide linear) ---------------------------------
def h_linear_wave_linear_wind(x, y, t):
    A = 0.05 * t
    wind = 0.05 * t * z
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

# --- Visualisierungsfunktion -------------------------------------------------
def run_simulation(h_function, title):
    fig, ax = plt.subplots(subplot_kw={"projection": "3d"}, figsize=(6,5))
    ax.set_zlim(-3, 3)
    plt.tight_layout()

    def update(t):
        ax.clear()
        Z = h_function(X, Y, t)
        bx, by = boat_pos(t)
        bz = h_function(bx, by, t)
        ax.plot_surface(X, Y, Z, cmap='plasma', alpha=0.85)
        ax.scatter(bx, by, bz+0.3, color='red', s=50)
        ax.set_zlim(-3, 3)
        ax.set_title(f"{title}\n t={t:.1f}")
        return ax

    ani = FuncAnimation(fig, update, frames=np.linspace(0, 40, 80), interval=120)
    plt.show()

# --- Simulationen starten ----------------------------------------------------
run_simulation(h_const_wave_linear_wind, "1️⃣ Konstante Wellen – linearer Wind")
run_simulation(h_linear_wave_const_wind, "2️⃣ Lineare Wellen – konstanter Wind")
run_simulation(h_linear_wave_linear_wind, "3️⃣ Lineare Wellen & linearer Wind")
