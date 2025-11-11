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

# --- Brane-Funktionen ----------------------------------------------------------
def h1(x, y, t):  # konstante Wellen, linearer Wind
    A = 1.0
    wind = 0.05 * t * z
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

def h2(x, y, t):  # lineare Wellen, konstanter Wind
    A = 0.05 * t
    wind = 0.5
    return A * np.sin(k * np.sqrt(x**2 + y**2) - ω * t) + wind

def h3(x, y, t):  # beide linear
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

# --- Berechnung der Kohärenzmatrix K(t,s) -------------------------------------
K = np.zeros((3, len(T)))  # Zeilen = Szenarien, Spalten = Zeitpunkte

for i, h_func in enumerate([h1, h2, h3]):
    for j, t in enumerate(T):
        Z = h_func(X, Y, t)
        K[i, j] = orientation_measure(Z)

# --- Heatmap -------------------------------------------------------------------
fig, ax = plt.subplots(figsize=(8, 4))
im = ax.imshow(K, aspect='auto', cmap='plasma', origin='lower',
               extent=[T[0], T[-1], 1, 3])

ax.set_xlabel("Zeit t")
ax.set_ylabel("Szenario s")
ax.set_yticks([1,2,3])
ax.set_yticklabels([
    "1️⃣ konst. Wellen / linearer Wind",
    "2️⃣ linear. Wellen / konst. Wind",
    "3️⃣ beide linear"
])
ax.set_title("Kohärenz-Topographie K(t,s) – FRZK-System")
cbar = plt.colorbar(im, ax=ax)
cbar.set_label("Kohärenzmaß (1 = flach / Desorientierung)")
plt.tight_layout()
plt.show()
