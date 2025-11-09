# 3.2.6 - 2 Operatorenmonoid
import matplotlib.pyplot as plt
import numpy as np

fig, ax = plt.subplots(figsize=(6,6))

# Kreispositionen
labels = ["σ (Selektion)", "M (Metrik)", "R (Relation)", "E (Emergenz)"]
angles = np.linspace(0, 2*np.pi, len(labels), endpoint=False)

# Punkte
x = np.cos(angles); y = np.sin(angles)
ax.scatter(x, y, s=400, color="lightblue")

# Labels
for i, label in enumerate(labels):
    ax.text(x[i], y[i], label, ha="center", va="center", fontsize=11)

# Pfeile als Komposition
for i in range(len(labels)):
    ax.arrow(x[i], y[i], 0.6*(x[(i+1)%4]-x[i]), 0.6*(y[(i+1)%4]-y[i]),
             head_width=0.05, length_includes_head=True, color="black")

ax.set_xlim(-1.5,1.5); ax.set_ylim(-1.5,1.5)
ax.set_xticks([]); ax.set_yticks([])
ax.set_title("3.2.6 - 2 Operatorenmonoid O={σ,M,R,E}", fontsize=12)
plt.show()
