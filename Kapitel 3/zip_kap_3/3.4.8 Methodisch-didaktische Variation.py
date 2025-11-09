# 3.4.8 Didaktische Variation
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(7,7))

# Orthogonal
ax.arrow(0,0,1,0, head_width=0.05, color="blue")
ax.arrow(0,0,0,1, head_width=0.05, color="green")

# Schiefwinklig
ax.arrow(0,0,0.7,0.5, head_width=0.05, color="red")

# Diskretisierung
ax.scatter([0.5,1.0,1.5],[0.5,1.0,1.5], color="black")

ax.set_xlim(-0.2,2)
ax.set_ylim(-0.2,2)
ax.set_title("3.4.8 Methodisch-didaktische Variation", fontsize=14)
ax.set_aspect("equal")
plt.show()
