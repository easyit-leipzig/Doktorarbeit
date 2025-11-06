# -*- coding: utf-8 -*-
"""
Abb. 2 – Raumfunktion x(U) als aktive Zuordnung
Beschreibung:
  - Veranschaulicht, wie der Operator o_x Zustände U auf die x-Achse abbildet.
  - Pfeile zeigen die Zuweisung; Punkte vor/nach der Zuordnung sind markiert.
"""

import numpy as np
import matplotlib.pyplot as plt

def draw_xU_assignment(outfile_svg="Abb2_xU_assignment.svg", outfile_png="Abb2_xU_assignment.png"):
    # Beispielzustände in M (vor Zuweisung) – links (x=0), unterschiedliche y-Werte
    U_states = np.array([[0, 3], [0, 2], [0, 1], [0, 0]])

    # Zielpositionen nach der Zuweisung x(U) (auf x-Achse / Funktionsraum)
    x_targets = np.array([[3, 3], [2, 2], [1, 1], [0, 0]])  # (x,y) Paare zur Illustration

    fig, ax = plt.subplots(figsize=(7, 5))
    ax.set_title("Abb. 2 – Raumfunktion x(U) als aktive Zuordnung", pad=12)

    # Pfeile für Operatorwirkung o_x
    for u, x in zip(U_states, x_targets):
        dx, dy = x - u
        ax.arrow(u[0], u[1], dx, dy,
                 head_width=0.12, head_length=0.18, length_includes_head=True, linewidth=1.6)

    # Punkte: vor und nach Zuweisung
    ax.scatter(U_states[:, 0], U_states[:, 1], s=50, alpha=0.7, label="Zustände U ∈ M (vor Zuweisung)")
    ax.scatter(x_targets[:, 0], x_targets[:, 1], s=50, alpha=0.9, marker='s', label="x(U) (nach Zuweisung)")

    # Anmerkungen
    ax.text(-0.2, 3.05, "o_x", fontsize=11)
    ax.text(3.05, 3.05, "x(U)", fontsize=10)

    # Achsen
    ax.set_xlim([-0.6, 3.6])
    ax.set_ylim([-0.6, 3.6])
    ax.set_xlabel("Funktionsraum x(U)")
    ax.set_ylabel("Menge M (Index / Kategorie)")
    ax.grid(True, linestyle='--', alpha=0.5)
    ax.legend(loc="lower right")

    plt.tight_layout()
    #plt.savefig(outfile_svg, bbox_inches="tight")
    #plt.savefig(outfile_png, dpi=300, bbox_inches="tight")
    plt.show()

if __name__ == "__main__":
    draw_xU_assignment()
