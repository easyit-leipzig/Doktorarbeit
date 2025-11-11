import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# Parameter
L = 20
x = np.linspace(-L, L, 200)
y = np.linspace(-L, L, 200)
X, Y = np.meshgrid(x, y)

# Brane-Funktion: reine Wasserwelle
def h_wave(x, y, t, A=1.0, k=0.5, ω=0.8):
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t)

# Bootposition (Kreisbahn an Kette)
def boat_pos(t, r=8, ωb=0.3):
    return r * np.cos(ωb*t), r * np.sin(ωb*t)

fig = plt.figure(figsize=(6,5))
ax = plt.axes(projection="3d")
def h_total(x, y, z, t):
    return h_wave(x, y, t) + 0.5*h_wind(x, y, z, t)

def boat_motion(t, r=8, ωb=0.3, z_amp=1.0):
    x = r*np.cos(ωb*t)
    y = r*np.sin(ωb*t)
    z = z_amp*np.sin(0.2*t)
    return x, y, z

fig = plt.figure(figsize=(6,5))
ax = plt.axes(projection="3d")

def update3(t):
    ax.clear()
    bx, by, bz = boat_motion(t)
    Z = h_total(X, Y, bz, t)
    ax.plot_surface(X, Y, Z, cmap='plasma', alpha=0.8)
    ax.scatter(bx, by, bz+0.3, color='red', s=50)
    ax.set_zlim(-2, 2)
    ax.set_title(f"Kombiniertes Feld – Boot (t={t:.1f})")
    return ax

ani3 = FuncAnimation(fig, update3, frames=np.linspace(0,40,100), interval=100)
plt.show()
