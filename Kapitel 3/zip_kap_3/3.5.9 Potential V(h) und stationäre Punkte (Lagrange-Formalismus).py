# 3_5_9_lagrange_potential.py
# Visualisiert V(h) = lambda/4 * (h^2 - h0^2)^2 und markiert Stationärpunkte

import numpy as np
import matplotlib.pyplot as plt

h0 = 1.0
lam = 1.0
h = np.linspace(-1.5, 1.5, 400)
V = (lam/4.0) * (h**2 - h0**2)**2
Vprime = lam * (h**2 - h0**2) * h  # V'(h) = lambda*(h^2 - h0^2)*h

plt.figure(figsize=(9,4))
plt.plot(h, V, lw=2, label='V(h)')
plt.plot(h, Vprime, lw=1, linestyle='--', label="V'(h) (Skizze)")
# mark stable minima at h = +- h0 and unstable at h=0
plt.scatter([-h0, h0, 0], [ (lam/4.0) * (h0**2 - h0**2)**2, (lam/4.0) * (h0**2 - h0**2)**2, (lam/4.0) * (0 - h0**2)**2 ],
            c=['green','green','red'], s=80)
plt.text(-h0, 0.02, "h=-h0 (stabil)", ha='center')
plt.text(h0, 0.02, "h=+h0 (stabil)", ha='center')
plt.text(0, (lam/4.0)*(0 - h0**2)**2 + 0.05, "h=0 (instabil)", ha='center', color='red')
plt.xlabel("h"); plt.ylabel("V(h)")
plt.title("3.5.9 Potential V(h) und stationäre Punkte (Lagrange-Formalismus)")
plt.legend()
plt.grid(True)
plt.show()
