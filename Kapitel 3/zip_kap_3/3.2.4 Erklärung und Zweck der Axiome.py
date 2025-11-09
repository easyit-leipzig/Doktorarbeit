# 3.2.4 Axiome Übersicht
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(7,5))

axiome = ["A1: Leere (∅)", "A2: Initialpunkt (I)", "A3: Operatoren (O)", "A4: Transitive Zuweisung"]
desc = ["Ausgangspunkt", "Erste Differenz", "Operationen als Monoid", "Rekonstruktion garantiert"]

for i, (a,d) in enumerate(zip(axiome, desc)):
    ax.text(0.1, 0.9-0.2*i, a, fontsize=12, weight="bold")
    ax.text(0.4, 0.9-0.2*i, d, fontsize=11)

ax.set_xticks([]); ax.set_yticks([])
ax.set_xlim(0,1); ax.set_ylim(0,1)
ax.set_title("3.2.4 Erklärung und Zweck der Axiome", fontsize=12)
plt.show()
