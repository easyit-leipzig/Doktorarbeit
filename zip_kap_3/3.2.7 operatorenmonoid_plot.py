# operatorenmonoid_plot.py
# Erzeugt "Abbildung 1 – Operatorenmonoid 𝒪 = {σ, M, R, E}"
# Benötigt: matplotlib, numpy
# z.B. pip install matplotlib numpy

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, Circle

def circular_positions(n, radius=1.0, start_angle=90):
    """
    n Punkte gleichmäßig auf Kreis (start_angle in Grad, 90 = oben)
    Rückgabe: list von (x,y)
    """
    angles = np.linspace(0, 2*np.pi, n, endpoint=False) + np.deg2rad(start_angle)
    return [(radius * np.cos(a), radius * np.sin(a)) for a in angles]

def draw_operator_monoid(savepath=None, figsize=(6,6)):
    # Operatoren in der gewünschten zyklischen Reihenfolge
    labels = [r'$\sigma$ (Selektion)', 'M (Metrik)', 'R (Relation)', 'E (Emergenz)']
    pts = circular_positions(len(labels), radius=1.0, start_angle=90)  # begin oben

    fig, ax = plt.subplots(figsize=figsize)
    ax.set_aspect('equal')
    ax.axis('off')

    # Kreis als Guideline (leicht transparent)
    circ = Circle((0,0), 1.05, edgecolor='black', facecolor='none', lw=0.6, alpha=0.5)
    ax.add_patch(circ)

    # Punkte und Labels
    for (x, y), lab in zip(pts, labels):
        ax.scatter([x], [y], s=180, zorder=3, color='white', edgecolor='black')
        # Label etwas außerhalb positionieren (normalisiert)
        dx, dy = 1.15 * x, 1.15 * y
        ax.text(dx, dy, lab, ha='center', va='center', fontsize=11)

    # zyklische Pfeile zwischen Punkten (gerichtete Komposition)
    arrow_props = dict(arrowstyle='-|>', mutation_scale=18, lw=1.2, color='black')
    n = len(pts)
    for i in range(n):
        x1, y1 = pts[i]
        x2, y2 = pts[(i+1) % n]
        # mittlerer Punkt für die Pfeil-Krümmung:
        midx, midy = (x1 + x2)/2, (y1 + y2)/2
        # etwas nach außen verschieben, um Pfeile sichtbar zu krümmen
        perp = np.array([-(y2-y1), (x2-x1)])
        if np.linalg.norm(perp) == 0:
            perp = np.array([0.0,0.0])
        perp = perp / (np.linalg.norm(perp) + 1e-9) * 0.18
        ctrl = (midx + perp[0], midy + perp[1])

        # Verwende FancyArrowPatch mit Kurve (connectionstyle)
        arrow = FancyArrowPatch((x1, y1), (x2, y2),
                                connectionstyle=f"arc3,rad={0.18 if i%2==0 else -0.18}",
                                **arrow_props)
        ax.add_patch(arrow)

    # Zustände außerhalb des Kreises: ∅ und I (keine Operatoren)
    ax.text(-1.6, 0.0, r'$\varnothing$ (Leerstelle)', fontsize=10, ha='center', va='center')
    ax.text( 1.6, 0.0, r'$I$ (Initialpunkt)', fontsize=10, ha='center', va='center')

    # erklärende Legende / Hinweis
    ax.text(0, -1.5,
            "Die Pfeile symbolisieren die Kompositionsregel des Operatorenmonoids\n"
            "Formell: (𝒪, ∘, e) mit 𝒪 = {σ, M, R, E}; ∅ und I sind Zustände, keine Operatoren.",
            fontsize=9, ha='center', va='center')

    # Randbegrenzung
    ax.set_xlim(-2.0, 2.0)
    ax.set_ylim(-2.0, 2.0)

    plt.tight_layout()
    if savepath:
        plt.savefig(savepath, dpi=300)
    plt.show()

if __name__ == "__main__":
    draw_operator_monoid(savepath="operatorenmonoid.png")