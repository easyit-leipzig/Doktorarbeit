import numpy as np
import matplotlib.pyplot as plt

# Definition der Brane-Funktion (semantisches Feld)
def h(x, y):
    return np.sin(x) * np.cos(y)

# Gradient (Richtungsinformation)
x, y = np.meshgrid(np.linspace(-3, 3, 40), np.linspace(-3, 3, 40))
hx, hy = np.gradient(h(x, y))

# Akteur-Funktion: gerichtete Bewegung entlang des Gradienten
A_x = hx / np.sqrt(hx**2 + hy**2 + 1e-6)
A_y = hy / np.sqrt(hx**2 + hy**2 + 1e-6)

# Darstellung
plt.figure(figsize=(7,6))
plt.streamplot(x, y, A_x, A_y, color=h(x,y), cmap='viridis', density=1.5)
plt.title("Akteur-Funktion A(U) im Brane-Feld h(x,y)")
plt.xlabel("x")
plt.ylabel("y")
plt.show()
