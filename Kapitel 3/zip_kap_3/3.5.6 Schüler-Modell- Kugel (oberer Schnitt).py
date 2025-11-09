# 3_5_6_student_models.py
# Visualisiert zwei einfache von Schülern entworfene Branen: Ebene und Kugel (Schnitt)

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Gitter
x = np.linspace(-2,2,140); y = np.linspace(-2,2,140)
X,Y = np.meshgrid(x,y)

# Ebene: h = a x + b y + c
a,b,c = 0.3, -0.1, 0.5
Z_plane = a*X + b*Y + c

# Kugel als level-set: h = x^2+y^2+z^2 - r^2 => solve for z (upper)
r = 1.2
inside = r**2 - X**2 - Y**2
Z_sphere = np.where(inside>0, np.sqrt(inside), np.nan)

fig = plt.figure(figsize=(12,5))
ax1 = fig.add_subplot(121, projection='3d')
ax1.plot_surface(X, Y, Z_plane, cmap='viridis', alpha=0.9)
ax1.set_title("3.5.6 Schüler-Modell: Ebene h=ax+by+c")

ax2 = fig.add_subplot(122, projection='3d')
ax2.plot_surface(X, Y, Z_sphere, cmap='viridis', alpha=0.9)
ax2.set_title("3.5.6 Schüler-Modell: Kugel (oberer Schnitt)")

plt.suptitle("Vergleich: verschiedene von Lernenden entworfene Branen")
plt.tight_layout()
plt.show()
