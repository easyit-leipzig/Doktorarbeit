# 3.7.3 Vorhersagefähigkeit
import numpy as np
import matplotlib.pyplot as plt

# Einfache lineare Transformation
def O(x): return 0.8*x + 1

x0 = 1
steps = 15
xs = [x0]
for t in range(steps):
    xs.append(O(xs[-1]))

plt.figure(figsize=(8,6))
plt.plot(xs, marker="o", label="Trajektorie")
plt.axhline(y=5, color="r", linestyle="--", label="Vorhersage")
plt.title("3.7.3 Vorhersage durch Operatorenkaskaden")
plt.xlabel("t")
plt.ylabel("x(t)")
plt.legend()
plt.grid()
plt.show()
