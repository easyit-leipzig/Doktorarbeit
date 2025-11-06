# 3.2.7 Didaktische Perspektive
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(6,5))

# Initialpunkt
ax.scatter(0.5, 0.2, s=200, color="red")
ax.text(0.5, 0.25, "I", ha="center", fontsize=12, color="red")

# Lehrer/Schüler Sprechblasen
ax.text(0.2, 0.7, "Lehrer:\n\"Was unterscheidest du?\"", fontsize=11,
        bbox=dict(facecolor="lightgreen", alpha=0.5))
ax.text(0.7, 0.7, "Schüler:\n\"Ich setze einen Unterschied.\"", fontsize=11,
        bbox=dict(facecolor="lightblue", alpha=0.5))

ax.set_xticks([]); ax.set_yticks([])
ax.set_xlim(0,1); ax.set_ylim(0,1)
ax.set_title("3.2.7 Didaktische Perspektive: Initialpunkt im Dialog", fontsize=12)
plt.show()
