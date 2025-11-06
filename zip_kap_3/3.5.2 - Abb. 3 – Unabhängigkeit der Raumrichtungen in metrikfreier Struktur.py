# Abbildung 3 – Unabhängigkeit der Raumrichtungen in metrikfreier Struktur
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection='3d')
ax.set_title("Abb. 3 – Unabhängigkeit der Raumrichtungen in metrikfreier Struktur", pad=20)

# Ursprung (Initialpunkt I)
origin = np.array([0, 0, 0])

# Raumfunktionen als unabhängige Operatoren
vectors = {
    'x(U)': np.array([1.2, 0.2, 0]),
    'y(U)': np.array([0.1, 1.1, 0.3]),
    'z(U)': np.array([0.2, 0.3, 1.3])
}

# Quiver-Pfeile (ohne metrische Skalierung)
for label, v in vectors.items():
    ax.quiver(*origin, *v, arrow_length_ratio=0.1, lw=2.2, label=label)

# Initialpunkt
ax.scatter(*origin, color='black', s=60, label="Initialpunkt I")

# Annotationen
ax.text(1.3, 0.2, 0, "x(U)", color='darkred', fontsize=11)
ax.text(0.1, 1.3, 0.3, "y(U)", color='darkgreen', fontsize=11)
ax.text(0.3, 0.4, 1.3, "z(U)", color='darkblue', fontsize=11)
ax.text(0.05, -0.1, 0.05, "I", fontsize=12, color='black')

# Layout
ax.set_xlim([-0.2, 1.5])
ax.set_ylim([-0.2, 1.5])
ax.set_zlim([-0.2, 1.5])
ax.set_xlabel("x(U)")
ax.set_ylabel("y(U)")
ax.set_zlabel("z(U)")
ax.view_init(elev=25, azim=40)
ax.legend()
ax.grid(False)

plt.tight_layout()
plt.show()
