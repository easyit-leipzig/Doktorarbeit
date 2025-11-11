import numpy as np
import matplotlib.pyplot as plt

# --- Parameter -----------------------------------------------------------------
L = 20
x = np.linspace(-L, L, 150)
y = np.linspace(-L, L, 150)
X, Y = np.meshgrid(x, y)
k, ω = 0.5, 0.8
z = 1.0
T = np.linspace(0, 40, 100)

# --- Brane-Funktionen -----------------------------------------------------------
def h1(x, y, t):
    A = 1.0
    wind = 0.05 * t * z
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

def h2(x, y, t):
    A = 0.05 * t
    wind = 0.5
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

def h3(x, y, t):
    A = 0.05 * t
    wind = 0.05 * t * z
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

# --- Orientierung & Kohärenz ---------------------------------------------------
def orientation_measure(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    return np.mean(O)

# --- Kohärenzberechnung --------------------------------------------------------
K = np.zeros((3, len(T)))
for i, h_func in enumerate([h1, h2, h3]):
    for j, t in enumerate(T):
        Z = h_func(X, Y, t)
        K[i, j] = orientation_measure(Z)

# --- Visualisierung ------------------------------------------------------------
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(11, 4))
plt.tight_layout(pad=3.0)

# --- (1) Heatmap ---------------------------------------------------------------
im = ax1.imshow(K, aspect='auto', cmap='plasma', origin='lower',
                extent=[T[0], T[-1], 1, 3])
ax1.set_xlabel("Zeit t")
ax1.set_ylabel("Szenario s")
ax1.set_yticks([1,2,3])
ax1.set_yticklabels([
    "1️⃣ konst. Wellen / linearer Wind",
    "2️⃣ linear. Wellen / konst. Wind",
    "3️⃣ beide linear"
])
ax1.set_title("Kohärenz-Topographie K(t,s)")
cbar = plt.colorbar(im, ax=ax1)
cbar.set_label("Kohärenzmaß (1 = flach / Desorientierung)")

# --- (2) Kohärenzverläufe ------------------------------------------------------
ax2.plot(T, K[0], color='blue', label="1️⃣ konst. Wellen / linearer Wind")
ax2.plot(T, K[1], color='green', label="2️⃣ linear. Wellen / konst. Wind")
ax2.plot(T, K[2], color='orange', label="3️⃣ beide linear")

ax2.set_xlabel("Zeit t")
ax2.set_ylabel("Kohärenzmaß K(t)")
ax2.set_title("Zeitliche Kohärenzdynamik")
ax2.set_ylim(0, 1)
ax2.grid(True)
ax2.legend(fontsize=8, loc="upper right")

plt.show()
