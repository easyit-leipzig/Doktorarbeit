# 3.4.7 Architekturwissenschaftliche Perspektiven
import matplotlib.pyplot as plt
import matplotlib.patches as patches

fig, ax = plt.subplots(figsize=(6,6))
# Rechteck als "Raum"
ax.add_patch(patches.Rectangle((0,0),4,3, fill=None, edgecolor="black"))
# Achsen
ax.axvline(2, color="red", linestyle="--")
ax.axhline(1.5, color="blue", linestyle="--")
ax.set_xlim(0,5)
ax.set_ylim(0,4)
ax.set_title("3.4.7 Architektur: Raum durch Setzungen", fontsize=14)
plt.show()
