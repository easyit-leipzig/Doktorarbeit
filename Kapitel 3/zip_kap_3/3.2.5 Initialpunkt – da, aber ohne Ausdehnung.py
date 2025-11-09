# 3.2.5 Eigenschaften Initialpunkt
import matplotlib.pyplot as plt
import numpy as np

fig, ax = plt.subplots(figsize=(5,5))

# Punkt
ax.scatter(0.5, 0.5, s=300, color="red", zorder=3)

# Wolke drumherum
theta = np.linspace(0, 2*np.pi, 50)
r = 0.2 + 0.05*np.sin(5*theta)
x = 0.5 + r*np.cos(theta); y = 0.5 + r*np.sin(theta)
ax.plot(x, y, color="gray", linestyle="--")

ax.text(0.5, 0.55, "I", ha="center", fontsize=14, color="red")
ax.set_xticks([]); ax.set_yticks([])
ax.set_xlim(0,1); ax.set_ylim(0,1)
ax.set_title("3.2.5 Initialpunkt – da, aber ohne Ausdehnung", fontsize=12)
plt.show()
