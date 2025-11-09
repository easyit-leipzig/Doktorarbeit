# boat_frzk_3d.py
# Anzeige: Boot auf Kreisbahn, schaukelnd (Sinus) + FRZK-Brane-Oberfläche im Hintergrund
# Abhängigkeiten: numpy, matplotlib
# Einfach laufen lassen: python boat_frzk_3d.py

import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

# ------------- Parameter -------------
R = 5.0                 # Radius der Kreisbahn (xy-Ebene)
omega = 0.8             # Umlaufwinkelgeschwindigkeit (rad/s)
t_max = 20.0            # Simulationsdauer (s)
fps = 30                # Frames per second

# Schaukelfunktionen (Basisamplituden)
A_pitch = 0.25         # Grundamplitude Pitch (rad) - Nickbewegung (um Querachse)
A_roll  = 0.15         # Grundamplitude Roll (rad)  - Rollbewegung (um Längsachse)
k_pitch = 2.0          # Frequenz Pitch (rad/s)
k_roll  = 2.5          # Frequenz Roll  (rad/s)

# Brane-Funktion (h(x,y)) - eine simple Gauß-Hügel (als Beispiel für FRZK Brane)
def h_brane(x, y, centers=[(0.0, 0.0)], sigmas=[2.0], weights=[1.0]):
    z = np.zeros_like(x)
    for (cx, cy), sigma, w in zip(centers, sigmas, weights):
        z += w * np.exp(-((x-cx)**2 + (y-cy)**2) / (2 * sigma**2))
    return z

# Mapping: lokale h modifiziert Schaukelamplitude (je dichter, desto stärker die Schwingung)
def local_amplitude_factor(hval, factor=1.5):
    # hval in [0, ~1] -> skaliert Amplituden leicht
    return 1.0 + factor * hval

# Boot als kleines Rechteck (Hull) im lokalen Boot-Koordinatensystem
def boat_polygon(length=1.0, width=0.5):
    # definiere 4 Eckpunkte in Boot-Koordinaten (Längsrichtung x_boot, Quer y_boot)
    L = length / 2.0
    W = width / 2.0
    pts = np.array([
        [ L,  W, 0.0],
        [ L, -W, 0.0],
        [-L, -W, 0.0],
        [-L,  W, 0.0],
    ])
    return pts

# Rotationsmatrizen
def Rx(alpha):
    c, s = np.cos(alpha), np.sin(alpha)
    return np.array([[1,0,0],[0,c,-s],[0,s,c]])

def Ry(beta):
    c, s = np.cos(beta), np.sin(beta)
    return np.array([[c,0,s],[0,1,0],[-s,0,c]])

def Rz(gamma):
    c, s = np.cos(gamma), np.sin(gamma)
    return np.array([[c,-s,0],[s,c,0],[0,0,1]])

# ------------- Setup Figure -------------
fig = plt.figure(figsize=(10,7))
ax = fig.add_subplot(111, projection='3d')
ax.set_box_aspect([1,1,0.6])

# Prepare brane grid for background surface
grid_n = 100
xg = np.linspace(-8, 8, grid_n)
yg = np.linspace(-8, 8, grid_n)
Xg, Yg = np.meshgrid(xg, yg)
Hg = h_brane(Xg, Yg, centers=[(0.0,0.0),(3.0,-2.0)], sigmas=[2.5,1.2], weights=[0.8,0.5])

# Plot FRZK Brane surface (colormap shows semantic density)
surf = ax.plot_surface(Xg, Yg, Hg*0.6 - 0.5, cmap='viridis', alpha=0.6, linewidth=0, antialiased=True)

# draw the circular path
theta = np.linspace(0, 2*np.pi, 200)
cx = R * np.cos(theta)
cy = R * np.sin(theta)
cz = np.zeros_like(cx)
ax.plot(cx, cy, cz, color='k', linewidth=0.8, linestyle='--', alpha=0.6)

# Boat initial objects: polygon + mast line + position marker
boat_pts0 = boat_polygon(length=1.4, width=0.6)
poly = Poly3DCollection([boat_pts0], facecolors=['saddlebrown'], edgecolors='k', linewidths=0.5)
ax.add_collection3d(poly)
mast_line, = ax.plot([], [], [], lw=2, color='brown')
pos_marker, = ax.plot([], [], [], marker='o', color='red', markersize=6)

# Axes labels and limits
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z (Brane h scaled)')
ax.set_xlim(-8,8); ax.set_ylim(-8,8); ax.set_zlim(-2.0, 2.0)
ax.set_title('Boot auf Kreisbahn — schaukelnd; FRZK Brane im Hintergrund')

# ------------- Animation function -------------
t_vals = np.linspace(0, t_max, int(t_max*fps))

def update(frame):
    t = t_vals[frame]
    # position on circular path
    ang = omega * t
    x = R * np.cos(ang)
    y = R * np.sin(ang)
    z = 0.0  # Boot bleibt nah an Wasseroberfläche (z=0); Brane sichtbar unter/über

    # local brane value at (x,y)
    h_local = h_brane(np.array([x]), np.array([y]), centers=[(0.0,0.0),(3.0,-2.0)], sigmas=[2.5,1.2], weights=[0.8,0.5])[0]

    # amplitude modulation by FRZK brane at position
    amp_factor = local_amplitude_factor(h_local, factor=1.2)

    # compute pitch and roll (sinus)
    pitch = A_pitch * amp_factor * np.sin(k_pitch * t + 0.0)   # Nick (rotation um Querachse = Ry)
    roll  = A_roll  * amp_factor * np.sin(k_roll  * t + 0.7)   # Roll (rotation um Längsachse = Rx)

    # orientation: first roll (Rx), then pitch (Ry), then align along path tangent (Rz)
    heading = ang + np.pi/2.0  # heading tangent to circle (optional)
    R_total = Rz(heading) @ Ry(pitch) @ Rx(roll)

    # transform boat points
    pts = boat_polygon(length=1.4, width=0.6)
    rotated = (R_total @ pts.T).T  # shape (4,3)
    translated = rotated + np.array([x, y, z])

    # update polygon
    poly.set_verts([translated])
    # update mast: draw small vertical mast in boat coords (0.6 length)
    mast_local_top = np.array([0.0, 0.0, 0.6])
    mast_local_bottom = np.array([0.0, 0.0, 0.0])
    mast_world_top = (R_total @ mast_local_top) + np.array([x,y,z])
    mast_world_bottom = (R_total @ mast_local_bottom) + np.array([x,y,z])
    mast_line.set_data([mast_world_bottom[0], mast_world_top[0]], [mast_world_bottom[1], mast_world_top[1]])
    mast_line.set_3d_properties([mast_world_bottom[2], mast_world_top[2]])

    # update position marker
    pos_marker.set_data([x], [y])
    pos_marker.set_3d_properties([z + 0.05])

    # optionally update title or annotation with t and h_local
    ax.set_title(f' t={t:4.2f}s | h_local={h_local:.3f} | pitch={np.degrees(pitch):.1f}° roll={np.degrees(roll):.1f}°')

    return poly, mast_line, pos_marker

anim = animation.FuncAnimation(fig, update, frames=len(t_vals), interval=1000/fps, blit=False)

# To save animation as mp4 uncomment the following line (needs ffmpeg)
# anim.save('boat_frzk.mp4', fps=fps, dpi=150)

plt.show()
