# 3.4.4 Höhere Dimensionen
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Beispielpunkte in 4D -> Projektion auf 3D
points_4d = [
    (1,2,3,4),
    (2,1,4,3),
    (3,3,2,1)
]
points_3d = [(x,y,z) for (x,y,z,w) in points_4d]

fig = plt.figure(figsize=(7,6))
ax = fig.add_subplot(111, projection="3d")
ax.scatter(*zip(*points_3d), color="purple", s=70)
ax.set_title("3.4.4 Projektion von 4D → 3D", fontsize=14)
ax.set_xlabel("x1")
ax.set_ylabel("x2")
ax.set_zlabel("x3")
plt.show()
