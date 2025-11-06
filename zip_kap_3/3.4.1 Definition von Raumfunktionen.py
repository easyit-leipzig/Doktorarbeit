# 3.4.1 Definition von Raumfunktionen
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Punkt U
U = (1, 2, 3)

fig = plt.figure(figsize=(7,6))
ax = fig.add_subplot(111, projection='3d')

# Achsen + Punkt
ax.scatter(*U, color="red", s=80, label="U → (x(U), y(U), z(U))")
ax.text(*U, " U", fontsize=12, color="red")

ax.set_xlabel("x(U)")
ax.set_ylabel("y(U)")
ax.set_zlabel("z(U)")
ax.set_title("3.4.1 Definition von Raumfunktionen", fontsize=14)
ax.legend()
plt.show()
