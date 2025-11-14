import numpy as np
import matplotlib.pyplot as plt
from scipy.ndimage import gaussian_gradient_magnitude

# Beispielhafte "didaktische Anforderungslandschaft" h(x,y)
def didaktische_landschaft(x, y):
    return (
        0.5 * np.exp(-((x+1)**2 + (y+1)**2)) +   # einfache Phase
        1.0 * np.exp(-((x-1)**2 + (y-1)**2)/0.5) +  # intensive, plötzliche Phase
        0.3 * np.exp(-((x-2)**2 + (y+2)**2)/2)     # leichte Reflexion
    )

# Gitter erzeugen
x = np.linspace(-4, 4, 200)
y = np.linspace(-4, 4, 200)
X, Y = np.meshgrid(x, y)

# h(x,y): didaktische Anforderung
H = didaktische_landschaft(X, Y)

# Gradient (Veränderungsrate der Anforderungen)
grad_H = gaussian_gradient_magnitude(H, sigma=1)
max_grad = np.max(grad_H)

# O(x,y): "didaktische Glätte" = 1 - normierter Gradient
O = 1 - grad_H / max_grad

# Plot
fig, ax = plt.subplots(1, 3, figsize=(18, 7))

ax[0].imshow(H, extent=[-4,4,-4,4], origin='lower', cmap='viridis')
ax[0].set_title("Didaktische Anforderung h(x, y)")
ax[0].set_xlabel("Methodische Phase X")
ax[0].set_ylabel("Sozialform / Kogn. Niveau Y")

ax[1].imshow(grad_H, extent=[-4,4,-4,4], origin='lower', cmap='inferno')
ax[1].set_title("Methodenwechsel / Brüche (∇h)")
ax[1].set_xlabel("X")
ax[1].set_ylabel("Y")

im = ax[2].imshow(O, extent=[-4,4,-4,4], origin='lower', cmap='plasma')
ax[2].set_title("Didaktische Kohärenz O(x, y)")
ax[2].set_xlabel("X")
ax[2].set_ylabel("Y")

fig.colorbar(im, ax=ax.ravel().tolist(), shrink=0.8)
plt.tight_layout()
plt.show()
