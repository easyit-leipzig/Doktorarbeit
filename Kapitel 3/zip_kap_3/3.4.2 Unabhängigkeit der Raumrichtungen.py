# 3.4.2 Unabhängigkeit der Raumrichtungen
import matplotlib.pyplot as plt
import numpy as np

fig, ax = plt.subplots(1,2, figsize=(12,6))

# Klassisch orthogonal
ax[0].arrow(0,0,1,0, head_width=0.05, color="blue")
ax[0].arrow(0,0,0,1, head_width=0.05, color="green")
ax[0].set_title("Klassisch: orthogonal")
ax[0].set_xlim(-0.2,1.2)
ax[0].set_ylim(-0.2,1.2)
ax[0].set_aspect("equal")

# FRZK: schiefwinklig
ax[1].arrow(0,0,1,0, head_width=0.05, color="blue")
ax[1].arrow(0,0,0.7,0.7, head_width=0.05, color="green")
ax[1].set_title("FRZK: metrikfrei")
ax[1].set_xlim(-0.2,1.2)
ax[1].set_ylim(-0.2,1.2)
ax[1].set_aspect("equal")

plt.suptitle("3.4.2 Unabhängigkeit der Raumrichtungen", fontsize=14)
plt.show()
