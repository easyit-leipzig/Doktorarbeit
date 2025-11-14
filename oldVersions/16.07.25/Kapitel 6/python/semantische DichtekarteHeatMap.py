# heatmap_h_3d_peaks.py
import requests
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm

# --- JSON von deinem PHP-Endpunkt laden ---
url = "http://localhost/easyDidak/library/php/semantische Dichtekarte (h(x,y)).php"
data = requests.get(url).json()

x_labels = data["x_labels"]
y_labels = data["y_labels"]

# Transponieren, damit Shape passt
h = np.array(data["h"], dtype=float).T  

x = np.arange(len(x_labels))
y = np.arange(len(y_labels))
X, Y = np.meshgrid(x, y)

# --- Plot ---
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection="3d")

surf = ax.plot_surface(
    X, Y, h,
    cmap=cm.viridis,
    edgecolor="none",
    linewidth=0,
    antialiased=True,
    alpha=0.9
)

fig.colorbar(surf, shrink=0.5, aspect=10, label="Semantische Dichte h(x,y)")

ax.set_xticks(x)
ax.set_xticklabels(x_labels, rotation=45, ha="right", fontsize=8)
ax.set_yticks(y)
ax.set_yticklabels(y_labels, fontsize=8)
ax.set_xlabel("x-Bereich (kognitive Dimension)")
ax.set_ylabel("y-Bereich (soziale Dimension)")
ax.set_zlabel("h(x,y)")
ax.set_title("3D-Darstellung der semantischen Dichte h(x,y) mit Peaks")

# --- Peaks markieren ---
max_val = np.nanmax(h)
threshold = 0.9 * max_val  # nur Werte über 90% des Maximums

for i in range(h.shape[0]):       # über y
    for j in range(h.shape[1]):   # über x
        if h[i, j] >= threshold:
            ax.text(
                j, i, h[i, j],
                f"{x_labels[j]}\n{y_labels[i]}",
                color="red",
                fontsize=8,
                ha="center"
            )

plt.tight_layout()
plt.show()
