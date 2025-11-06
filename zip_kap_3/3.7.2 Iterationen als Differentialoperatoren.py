# 3.7.2 Differentialoperator als wiederholte Transformation
import numpy as np
import matplotlib.pyplot as plt

# Dynamisches System: dx/dt = -0.5*x
def step(x, dt=0.1): return x - 0.5*x*dt

# Simulation
x0 = 5
steps = 50
xs = [x0]
for t in range(steps):
    xs.append(step(xs[-1]))

plt.figure(figsize=(8,6))
plt.plot(xs, marker="o")
plt.title("3.7.2 Iterationen als Differentialoperatoren")
plt.xlabel("t")
plt.ylabel("x(t)")
plt.grid()
plt.show()
