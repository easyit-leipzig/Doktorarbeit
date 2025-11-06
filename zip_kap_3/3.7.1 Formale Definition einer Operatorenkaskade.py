# 3.7.1 Operatorenkaskade - Verkettung von Funktionen
import numpy as np
import matplotlib.pyplot as plt

# Einfache Operatoren: Skalierung, Verschiebung
def o1(x): return 2*x
def o2(x): return x+3
def o3(x): return -x

# Kaskade: o3 ∘ o2 ∘ o1
def cascade(x): return o3(o2(o1(x)))

x = np.linspace(-3, 3, 100)
y1 = o1(x)
y2 = o2(y1)
y3 = cascade(x)

plt.figure(figsize=(8,6))
plt.plot(x, y1, label="o1(x)=2x")
plt.plot(x, y2, label="o2(o1(x))=2x+3")
plt.plot(x, y3, label="O(x)=o3(o2(o1(x)))")
plt.title("3.7.1 Formale Definition einer Operatorenkaskade")
plt.legend()
plt.grid()
plt.show()
