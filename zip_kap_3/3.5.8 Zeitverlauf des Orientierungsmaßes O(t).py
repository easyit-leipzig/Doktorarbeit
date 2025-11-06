# 3_5_8_orientation_measure_time.py
# Simuliert zeitliche Veränderung von Gradienten und berechnet O(t)

import numpy as np
import matplotlib.pyplot as plt

# Simulierte Gradientenzeitreihe (z.B. in Lernintervallen)
np.random.seed(1)
T = 60
gradients = np.abs(np.sin(np.linspace(0,6*np.pi,T)) + 0.3*np.random.randn(T))
grad_norm = gradients / gradients.max()
O_t = 1 - grad_norm  # O(t) = 1 - normalized gradient

plt.figure(figsize=(9,4))
plt.plot(np.arange(T), O_t, lw=2)
plt.axhline(0.5, color='grey', linestyle='--', alpha=0.6)
plt.xlabel("Zeit (Lerneinheiten)")
plt.ylabel("Orientierungsmaß O(t)")
plt.title("3.5.8 Zeitverlauf des Orientierungsmaßes O(t)")
plt.grid(True)
plt.show()
