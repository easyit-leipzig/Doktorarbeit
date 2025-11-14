import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D

# Definition der semantischen Operatorwerte über die Zeit
# I(t) = (σ, S, D, M, R, E) über fünf Schritte

states = np.array([
    [0.3, 0.2, 0.0, 0.1, 0.0, 0.0],  # I(0): Ausgangszustand
    [0.3, 0.2, 0.3, 0.1, 0.0, 0.0],  # t1: D ↑ durch Diskussion
    [0.3, 0.5, 0.3, 0.1, 0.0, 0.0],  # t2: S ↑ durch Normenklärung
    [0.3, 0.5, 0.3, 0.4, 0.0, 0.0],  # t3: M ↑ durch Reflexion
    [0.3, 0.5, 0.3, 0.4, 0.3, 0.0],  # t4: R ↑ durch Rückbindung
    [0.3, 0.5, 0.3, 0.4, 0.3, 0.6],  # t5: E ↑ Entscheidung emergiert
])

# 6D-Daten über Farben und Markergröße (σ, S, D, M, R, E)
sigma, S, D, M, R, E = states.T

fig = plt.figure(figsize=(12, 10))
ax = fig.add_subplot(111, projection='3d')

# Markerfarbe nach Emergenz E, Markergröße nach σ
sc = ax.scatter(S, D, M, c=E, cmap='viridis', s=100 + 300 * sigma, edgecolor='k')

# Linienverbindung zwischen den Zeitpunkten
ax.plot(S, D, M, color='gray', linestyle='--', alpha=0.5)

# Achsenbeschriftung
ax.set_xlabel('S (Symbolik)')
ax.set_ylabel('D (Diskurs)')
ax.set_zlabel('M (Metareflexion)')
ax.set_title('6D-Trajektorie im Raum I(t) – Farbe: E, Größe: σ')

# Punktbeschriftungen
for i, (x, y, z) in enumerate(zip(S, D, M)):
    ax.text(x, y, z, f't{i}', fontsize=9)

# Farbleiste für E
cbar = plt.colorbar(sc, ax=ax, shrink=0.6, pad=0.1)
cbar.set_label('Emergenz E')

plt.tight_layout()
plt.show()
