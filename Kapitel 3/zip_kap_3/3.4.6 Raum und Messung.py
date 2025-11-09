# 3.4.6 Raum und Messung
import matplotlib.pyplot as plt

points = [(1,2),(3,4)]
labels = ["Messung 1","Messung 2"]

plt.figure(figsize=(6,6))
for p,l in zip(points,labels):
    plt.scatter(*p, s=80)
    plt.text(p[0]+0.1,p[1]+0.1,l)

plt.title("3.4.6 Raum und Messung", fontsize=14)
plt.xlabel("x(U)")
plt.ylabel("y(U)")
plt.grid(True)
plt.show()
