# -*- coding: utf-8 -*-
"""
Abb. 1 – Emergenz eines Koordinatensystems durch funktionale Zuweisung
Erstellt: (dein Name), Datum
Beschreibung:
  - Visualisiert Initialpunkt I und die Entstehung der drei Raumfunktionen x(U), y(U), z(U)
  - Exportiert als SVG/PNG für Einbindung in Dissertation
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 (needed for 3D projection)

def draw_emergent_coordinate_system(outfile_svg="Abb1_emergence.svg", outfile_png="Abb1_emergence.png"):
    # Ursprung / Initialpunkt
    origin = np.array([0.0, 0.0, 0.0])

    # Vektoren repräsentieren Operatorwirkungen o_x, o_y, o_z
    # Länge/Orientierung können bei Bedarf angepasst werden
    vx = np.array([1.2, 0.0, 0.0])
    vy = np.array([0.0, 1.2, 0.0])
    vz = np.array([0.0, 0.0, 1.2])

    fig = plt.figure(figsize=(8, 6))
    ax = fig.add_subplot(111, projection='3d')
    ax.set_title("Abb. 1 – Emergenz eines Koordinatensystems\ndurch funktionale Zuweisung", pad=14)

    # Zeichne Pfeile (Quiver)
    ax.quiver(*origin, *vx, arrow_length_ratio=0.12, linewidth=2)
    ax.quiver(*origin, *vy, arrow_length_ratio=0.12, linewidth=2)
    ax.quiver(*origin, *vz, arrow_length_ratio=0.12, linewidth=2)

    # Initialpunkt markieren
    ax.scatter([0], [0], [0], s=70, color='k', label="Initialpunkt I")

    # Beschriftungen nahe den Pfeilspitzen
    ax.text(vx[0]*1.05, vx[1]*1.05, vx[2]*1.05, "x(U)", fontsize=11)
    ax.text(vy[0]*1.05, vy[1]*1.05, vy[2]*1.05, "y(U)", fontsize=11)
    ax.text(vz[0]*1.05, vz[1]*1.05, vz[2]*1.05, "z(U)", fontsize=11)
    ax.text(0.05, -0.05, 0.05, "I", fontsize=11)

    # Achsenlimits und Labels (sichtbar, aber unaufdringlich)
    ax.set_xlim([-0.3, 1.5])
    ax.set_ylim([-0.3, 1.5])
    ax.set_zlim([-0.3, 1.5])
    ax.set_xlabel("x(U)")
    ax.set_ylabel("y(U)")
    ax.set_zlabel("z(U)")

    # Kamerawinkel für eine gute Perspektive
    ax.view_init(elev=25, azim=35)

    # Legende separat (nur der Initialpunkt benötigt eine Legende hier)
    ax.legend(loc='upper left')

    plt.tight_layout()
    # Speichern (SVG für Vektorqualität, PNG als Fallback)
    #plt.savefig(outfile_svg, bbox_inches="tight")
    #plt.savefig(outfile_png, dpi=300, bbox_inches="tight")
    plt.show()

if __name__ == "__main__":
    draw_emergent_coordinate_system()
