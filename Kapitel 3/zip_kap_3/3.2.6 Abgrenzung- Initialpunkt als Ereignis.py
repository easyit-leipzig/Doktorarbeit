# 3.2.6 Initialpunkt als Ereignis, nicht Objekt
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(6,4))

ax.text(0.2, 0.5, "Ereignis\n(Prozess)", ha="center", va="center", fontsize=12, bbox=dict(facecolor="lightyellow"))
ax.text(0.8, 0.5, "Unterschied\n(Differenz)", ha="center", va="center", fontsize=12, bbox=dict(facecolor="lightblue"))

ax.arrow(0.35, 0.5, 0.3, 0, head_width=0.05, head_length=0.05, fc="black", ec="black")

ax.set_xticks([]); ax.set_yticks([])
ax.set_xlim(0,1); ax.set_ylim(0,1)
ax.set_title("3.2.6 Abgrenzung: Initialpunkt als Ereignis", fontsize=12)
plt.show()
