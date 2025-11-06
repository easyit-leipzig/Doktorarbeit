# 3.2.2 Initialpunkt in Grundmenge
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(5,5))

# Punkt
ax.scatter(0.5, 0.5, s=300, color="red")
ax.text(0.5, 0.55, "I", ha="center", fontsize=14, color="red")

ax.set_xticks([]); ax.set_yticks([])
ax.set_xlim(0,1); ax.set_ylim(0,1)
ax.set_title("3.2.2 Initialpunkt als Element M={I}", fontsize=12)
plt.show()
