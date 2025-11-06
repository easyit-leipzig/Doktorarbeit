"""
Abb. 7a – Zeit als Differenzoperator (3D-Darstellung)
------------------------------------------------------
Visualisierung von |f_{t+1}(x,y) - f_t(x,y)| < ε im epistemischen Raum.

x = kognitiver Zugriff
y = sozialer Kontext
z = Differenzwert
"""

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Gitter im (x,y)-Raum
x = np.linspace(-3, 3, 50)
y = np.linspace(-3, 3, 50)
X, Y = np.meshgrid(x, y)

# Zwei "Zeitstufen" einer semantischen Funktion
def f_t(x, y):
    return np.sin(x) * np.cos(y) * np.exp(-0.1*(x**2+y**2))

def f_tp1(x, y):
    return np.sin(x+0.5) * np.cos(y-0.3) * np.exp(-0.1*(x**2+y**2))

# Differenz
Delta = np.abs(f_tp1(X, Y) - f_t(X, Y))

# Schwellwert ε
epsilon = 0.2
stable = Delta < epsilon

fig = plt.figure(figsize=(14,14))
ax = fig.add_subplot(111, projection="3d")

# Oberfläche mit Farbmarkierung
surf = ax.plot_surface(X, Y, Delta, facecolors=plt.cm.coolwarm(Delta/Delta.max()), 
                       rstride=1, cstride=1, linewidth=0, antialiased=False, alpha=0.9)

# Stabile und instabile Zonen markieren
ax.contourf(X, Y, Delta, zdir='z', offset=0, cmap="Greens", levels=[0, epsilon], alpha=0.5)
ax.contourf(X, Y, Delta, zdir='z', offset=0, cmap="Reds", levels=[epsilon, Delta.max()], alpha=0.5)

ax.set_xlabel("x (kognitiver Zugriff)")
ax.set_ylabel("y (sozialer Kontext)")
ax.set_zlabel("|Δf|")
ax.set_title("Abb. 7a – Zeit als Differenzoperator (3D-Darstellung)")
plt.show()
