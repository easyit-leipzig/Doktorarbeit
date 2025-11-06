# 3.7.5 Attraktorbildung
import numpy as np
import matplotlib.pyplot as plt

def O(x): return np.cos(x)

x0 = 1.0
steps = 50
xs = [x0]
for t in range(steps):
    xs.append(O(xs[-1]))

plt.figure(figsize=(8,6))
plt.plot(xs, marker="o")
plt.title("3.7.5 Attraktorbildung durch Operatorenkaskaden")
plt.xlabel("t")
plt.ylabel("x(t)")
plt.grid()
plt.show()
