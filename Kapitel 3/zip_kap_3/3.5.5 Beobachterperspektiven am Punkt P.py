# 3_5_5_observer_projections.py
# Zeigt denselben Punkt P und die Projektionen aus verschiedenen Beobachterperspektiven

import numpy as np
import matplotlib.pyplot as plt

# Beispiel-Punktewolke (z: Wertigkeit)
np.random.seed(0)
pts = np.random.normal(scale=1.2, size=(120,2))
vals = np.exp(-0.5*(pts[:,0]**2 + pts[:,1]**2)) + 0.05*np.random.randn(120)

P = np.array([0.6, -0.3])  # Punkt P

fig, axs = plt.subplots(1,3, figsize=(15,4))

# Top-View scatter
axs[0].scatter(pts[:,0], pts[:,1], c=vals, cmap='viridis')
axs[0].scatter(P[0], P[1], c='red', s=80, label='P')
axs[0].set_title("Top-View (Koordinatenraum)")
axs[0].legend()

# Perspektivische 'Entfernung' (z ~ value perceived)
perceived = np.interp(vals, (vals.min(), vals.max()), (0.2, 1.2))
axs[1].scatter(pts[:,0], perceived, c=vals, cmap='viridis')
axs[1].scatter(P[0], np.interp(np.interp(np.sqrt(P[0]**2+P[1]**2), (0,2), (vals.min(), vals.max())), (vals.min(), vals.max()), (0.2,1.2)), c='red', s=80)
axs[1].set_title("Perzeptive Projektion (Wert als 'Höhe')")

# Projektion auf Achse (z.B. x-Achse)
axs[2].hist(pts[:,0], bins=20, color='grey')
axs[2].axvline(P[0], color='red', linestyle='--')
axs[2].set_title("Projektion auf x-Achse (Beobachterposition)")

plt.suptitle("3.5.5 Beobachterperspektiven am Punkt P")
plt.tight_layout()
plt.show()
