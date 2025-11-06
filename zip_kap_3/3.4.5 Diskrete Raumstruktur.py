# 3.4.5 Diskretisierung
import matplotlib.pyplot as plt
import numpy as np

x = np.arange(-3,4)
y = np.arange(-3,4)
X,Y = np.meshgrid(x,y)

plt.figure(figsize=(6,6))
plt.scatter(X,Y, color="black")
plt.title("3.4.5 Diskrete Raumstruktur", fontsize=14)
plt.xlabel("x")
plt.ylabel("y")
plt.gca().set_aspect("equal")
plt.show()
