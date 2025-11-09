# 3.6.5: Vergleich zweier Lernpfade
import numpy as np
import matplotlib.pyplot as plt

# Schwierigkeit = Hügel im Zentrum
def h(x,y):
    return np.exp(-(x**2+y**2)/4)

x = np.linspace(-4,4,120)
y = np.linspace(-4,4,120)
X,Y = np.meshgrid(x,y)
Z = h(X,Y)

# Zwei Wege: direkter & Umweg
x_direct = np.linspace(-3,3,100)
y_direct = np.zeros_like(x_direct)

theta = np.linspace(-np.pi/2, np.pi/2,100)
x_umweg = 3*np.cos(theta)
y_umweg = 3*np.sin(theta)

fig = plt.figure(figsize=(9,7))
ax = fig.add_subplot(111, projection="3d")
ax.plot_surface(X,Y,Z,cmap="viridis",alpha=0.7)
ax.plot(x_direct,y_direct,h(x_direct,y_direct)+0.05,"r",label="Direkter Weg")
ax.plot(x_umweg,y_umweg,h(x_umweg,y_umweg)+0.05,"b",label="Umweg")

ax.set_title("3.6.5 Vergleich Lernpfade")
ax.set_xlabel("x")
ax.set_ylabel("y")
ax.set_zlabel("h(x,y)")
ax.legend()
plt.show()
