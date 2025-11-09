# 3.7.6 Sequenzen und Vorhersagbarkeit
import matplotlib.pyplot as plt
import numpy as np

# Zwei Sequenzen: kohärent vs. inkohärent
seq1 = [1,2,3,4,5,6,7,8,9,10]  # kohärent
seq2 = [1,3,2,7,5,9,4,10,6,8]  # inkohärent

plt.figure(figsize=(8,6))
plt.plot(seq1, label="kohärente Operatoren")
plt.plot(seq2, label="inkohärente Operatoren")
plt.title("3.7.6 Vorhersagbarkeit von Sequenzen")
plt.xlabel("Schritt")
plt.ylabel("Wert")
plt.legend()
plt.grid()
plt.show()
