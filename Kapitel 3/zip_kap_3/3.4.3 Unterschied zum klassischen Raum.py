# 3.4.3 Klassischer Raum vs. FRZK
import matplotlib.pyplot as plt
import numpy as np

fig, ax = plt.subplots(1,2, figsize=(12,6))

# Klassisches Raster
ax[0].set_title("Klassisch: gegebener Raum")
for i in range(-5,6):
    ax[0].axhline(i, color="lightgrey", lw=0.5)
    ax[0].axvline(i, color="lightgrey", lw=0.5)
ax[0].scatter(2,3, color="red")
ax[0].text(2,3," Punkt", color="red")

# FRZK: Punkte + dynamische Linien
points = np.array([[1,1],[2,3],[3,2]])
ax[1].scatter(points[:,0], points[:,1], color="red")
ax[1].plot(points[:,0], points[:,1], color="blue")
ax[1].set_title("FRZK: Raum durch Zuweisung")

plt.suptitle("3.4.3 Unterschied zum klassischen Raum", fontsize=14)
plt.show()
