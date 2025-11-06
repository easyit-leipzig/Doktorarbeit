# 3.7.7 Brücke zu anderen Kapiteln
import matplotlib.pyplot as plt

chapters = ["3: Theorie", "4: Vorhersage", "5: Validierung", "6: Praxis"]
values = [1, 2, 3, 4]

plt.figure(figsize=(8,6))
plt.plot(chapters, values, marker="o", lw=3, color="purple")
plt.title("3.7.7 Operatorenkaskade als Brücke")
plt.xlabel("Kapitel")
plt.ylabel("Fortschritt")
plt.grid()
plt.show()
