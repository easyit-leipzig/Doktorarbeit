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

# --- Szenarien -----------------------------------------------------------------
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

# --- Hilfsfunktion: Orientierung & Kohärenz -----------------------------------
def orientation_measure(Z):
    dZdx, dZdy = np.gradient(Z)
    grad_mag = np.sqrt(dZdx**2 + dZdy**2)
    grad_norm = grad_mag / np.max(grad_mag)
    O = 1 - grad_norm
    K = np.mean(O)
    return K

# --- Berechnung der Kohärenzkurven --------------------------------------------
K1, K2, K3 = [], [], []

for t in T:
    Z1 = h1(X, Y, t)
    Z2 = h2(X, Y, t)
    Z3 = h3(X, Y, t)

    K1.append(orientation_measure(Z1))
    K2.append(orientation_measure(Z2))
    K3.append(orientation_measure(Z3))

# --- Visualisierung ------------------------------------------------------------
plt.figure(figsize=(8,5))
plt.plot(T, K1, label="1️⃣ konst. Wellen / linearer Wind", color='blue')
plt.plot(T, K2, label="2️⃣ linear. Wellen / konst. Wind", color='green')
plt.plot(T, K3, label="3️⃣ beide linear", color='orange')

plt.title("Kohärenzdynamik K(t) für drei FRZK-Szenarien")
plt.xlabel("Zeit t")
plt.ylabel("Kohärenzmaß K(t)")
plt.grid(True)
plt.legend()
plt.ylim(0, 1)
plt.show()
