# 3.2.1 Erste Unterscheidung: Markierung
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(5,5))

# Weißer Hintergrund = Leere
ax.set_facecolor("white")

# Linie als erste Unterscheidung
ax.plot([0.5, 0.5], [0, 1], color="black", linewidth=2)

ax.text(0.25, 0.5, "Innen", ha="center", va="center", fontsize=14)
ax.text(0.75, 0.5, "Außen", ha="center", va="center", fontsize=14)

ax.set_xticks([]); ax.set_yticks([])
ax.set_xlim(0,1); ax.set_ylim(0,1)
ax.set_title("3.2.1 Erste Unterscheidung (Spencer-Brown)", fontsize=12)
plt.show()
