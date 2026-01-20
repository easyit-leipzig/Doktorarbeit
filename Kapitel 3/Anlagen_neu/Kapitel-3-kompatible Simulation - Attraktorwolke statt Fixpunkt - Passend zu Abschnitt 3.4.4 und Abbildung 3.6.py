# Kapitel-3-kompatible Simulation: Attraktorwolke statt Fixpunkt
# Passend zu Abschnitt 3.4.4 und Abbildung 3.6 (6 Iterationen)

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(2)

# Ausgangszustand (ungeordneter funktionaler Zustand)
S0 = np.random.rand(300, 2)

# Attraktorzentrum (statistisch wirksam, kein Fixpunkt)
center = np.array([0.5, 0.5])

def operator_phi_cloud(S):
    """
    φ = E ∘ M ∘ R ∘ σ
    Stabilisierung auf eine Attraktorregion (keine Punktkonvergenz)
    """

    # σ: weiche Selektion (stetig, keine Reduktion der Punktzahl)
    weights = np.clip(S[:, 1], 0.2, 1.0).reshape(-1, 1)
    S_sigma = S * weights

    # R ∘ M: schwache, nicht-fixierende Kontraktion
    S_rel = S_sigma + 0.3 * (center - S_sigma)

    # E: persistente Emergenz (erhält Dynamik)
    noise = np.random.normal(0, 0.05, S_rel.shape)
    S_em = S_rel + noise

    return S_em

# Iterationen (genau 6: Iteration 0–5)
steps = [S0]
for _ in range(5):
    steps.append(operator_phi_cloud(steps[-1]))

# Visualisierung: 6 Teilbilder
fig, axes = plt.subplots(2, 3, figsize=(10, 6))
for i, ax in enumerate(axes.flat):
    ax.scatter(steps[i][:, 0], steps[i][:, 1], s=6, alpha=0.5)
    ax.scatter(center[0], center[1], color="red", marker="x")
    ax.set_title(f"Iteration {i}")
    ax.set_xlim(-0.2, 1.2)
    ax.set_ylim(-0.2, 1.2)

plt.suptitle("Simulation der Stabilisierung einer Operatorenkaskade")
plt.tight_layout()
plt.show()
