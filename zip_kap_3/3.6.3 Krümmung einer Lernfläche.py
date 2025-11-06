# 3.6.3: Krümmung einer Lernfläche
import numpy as np
import matplotlib.pyplot as plt

def h(x,y):
    return np.exp(-0.2*x**2) + 0.5*np.exp(-0.2*y**2)

x = np.linspace(-5,5,100)
y = np.linspace(-5,5,100)
X,Y = np.meshgrid(x,y)
Z = h(X,Y)

fig = plt.figure(figsize=(10,7))
ax = fig.add_subplot(111, projection="3d")
ax.plot_surface(X,Y,Z,cmap="viridis",alpha=0.8)

ax.set_title("3.6.3 Krümmung im Lernraum (Operatoren)")
ax.set_xlabel("x = Thema 1")
ax.set_ylabel("y = Thema 2")
ax.set_zlabel("h(x,y) = Schwierigkeit")
plt.show()
