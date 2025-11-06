
#!/usr/bin/env python3
# frzk_3d_visualization.py
# 3D-Visualisierung der Verortung von Lernenden im epistemischen Raum (FRZK §6.1.3)
# Jede Lernende:r U wird durch f(U) = (x(U), y(U), z(U)) repräsentiert.
# Zusätzlich wird das Orientierungsmaß O(U) aus Gauss-Hubs berechnet und als Farbe dargestellt.
#
# Usage:
#   python frzk_3d_visualization.py         # zeigt interaktiven Plot
#   python frzk_3d_visualization.py --save  # speichert PNG in ./output_frzk3d/
#
# Requirements: numpy, matplotlib
# Install (if needed): pip install numpy matplotlib

import os
import argparse
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # registers 3D projection
from matplotlib import cm

# ---------------------------
# Configuration (edit as desired)
# ---------------------------
OUT_DIR = "output_frzk3d"
BOUNDS = (-3.0, 3.0)   # sampling bounds for initial learners
N_LEARNERS = 40        # number of learners / points
SEED = 12345

# Hubs: (position (3,), weight w, sigma)
DEFAULT_HUBS = [
    (np.array([0.0,  0.0,  0.5]), 2.0, 1.0),
    (np.array([0.8, -0.6, -0.2]), 1.6, 0.9),
    (np.array([-0.9, 0.9,  0.2]), 1.4, 1.1),
]

# ---------------------------
# Helper functions
# ---------------------------
def semantic_density(U, hubs):
    # Compute h(U) = sum_k w_k * exp(-||U - h_k||^2 / (2 sigma_k^2))
    # U: array shape (..., 3) or (3,)
    # hubs: iterable of (pos (3,), w, sigma)
    # Returns: array of shape (N,) or scalar if input single point
    U = np.asarray(U)
    single = (U.ndim == 1 and U.shape[0] == 3)
    if single:
        U = U.reshape((1, 3))
    H = np.zeros(U.shape[0], dtype=float)
    for pos, w, sigma in hubs:
        diff = U - pos.reshape((1, 3))
        r2 = np.sum(diff * diff, axis=1)
        H += w * np.exp(- r2 / (2.0 * sigma**2))
    if single:
        return H[0]
    return H

def orientation_O(U, hubs):
    # Alias to semantic_density: orientation measure O(U) in the FRZK text
    return semantic_density(U, hubs)

# ---------------------------
# Plotting function
# ---------------------------
def plot_learners_3d(learners, hubs, savepath=None, show=True):
    # learners: (N,3) array containing f(U) coordinates
    O = orientation_O(learners, hubs)
    # normalize O to [0,1] for colormap
    Omin, Omax = O.min(), O.max()
    if Omax - Omin > 1e-9:
        Onorm = (O - Omin) / (Omax - Omin)
    else:
        Onorm = np.zeros_like(O)
    cmap = cm.get_cmap('viridis')

    fig = plt.figure(figsize=(10,8))
    ax = fig.add_subplot(111, projection='3d')
    sc = ax.scatter(learners[:,0], learners[:,1], learners[:,2],
                    c=Onorm, s=60, cmap=cmap, depthshade=True, edgecolor='k', linewidth=0.2)
    # mark hubs
    hub_positions = np.array([h[0] for h in hubs])
    ax.scatter(hub_positions[:,0], hub_positions[:,1], hub_positions[:,2],
               s=180, marker='X', edgecolor='k', linewidth=1.2, c='red', zorder=10, label='Hubs')
    # annotate hubs with weights
    for i, (pos, w, sigma) in enumerate(hubs):
        ax.text(pos[0], pos[1], pos[2], f' hub{i+1} (w={w},σ={sigma})', color='red')

    ax.set_xlabel('x (kognitiv)')
    ax.set_ylabel('y (sozial)')
    ax.set_zlabel('z (affektiv)')
    ax.set_title('FRZK – Verortung der Lernenden f(U) und Orientierungsmaß O(U)')
    cbar = fig.colorbar(sc, ax=ax, shrink=0.6, pad=0.08)
    cbar.set_label('normiertes O(U) (Orientierung)')
    ax.legend()

    # add a semi-transparent sphere to indicate central region (optional)
    u = np.linspace(0, 2 * np.pi, 40)
    v = np.linspace(0, np.pi, 20)
    r = 1.2
    x = r * np.outer(np.cos(u), np.sin(v))
    y = r * np.outer(np.sin(u), np.sin(v))
    z = r * np.outer(np.ones_like(u), np.cos(v))
    ax.plot_surface(x, y, z, color='0.95', alpha=0.07, linewidth=0)

    if savepath:
        os.makedirs(os.path.dirname(savepath) or '.', exist_ok=True)
        fig.savefig(savepath, dpi=180)
        print('Saved:', savepath)
    if show:
        plt.show()
    plt.close(fig)

# ---------------------------
# CLI / Runner
# ---------------------------
def main():
    parser = argparse.ArgumentParser(description='FRZK 3D visualization of f(U) and O(U)')
    parser.add_argument('--n', type=int, default=N_LEARNERS, help='number of learners/points to sample')
    parser.add_argument('--seed', type=int, default=SEED, help='random seed')
    parser.add_argument('--bounds', type=float, nargs=2, default=list(BOUNDS), help='sampling bounds: min max')
    parser.add_argument('--save', action='store_true', help='save PNG to output directory')
    args = parser.parse_args()

    rng = np.random.default_rng(args.seed)
    # sample learners uniformly in box
    learners = rng.uniform(args.bounds[0], args.bounds[1], size=(args.n, 3))

    savepath = None
    if args.save:
        os.makedirs(OUT_DIR, exist_ok=True)
        savepath = os.path.join(OUT_DIR, 'frzk_3d_fU_OU.png')

    plot_learners_3d(learners, DEFAULT_HUBS, savepath=savepath, show=not args.save)

if __name__ == '__main__':
    main()
