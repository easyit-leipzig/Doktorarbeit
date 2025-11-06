# 3.6.6: Kohärenzfunktion K(x,y)
import numpy as np
import matplotlib.pyplot as plt

d = np.linspace(0,10,200)
alpha = 0.5
K = np.exp(-alpha*d)

plt.figure(figsize=(8,5))
plt.plot(d,K,"g",lw=2,label="K(x,y) = exp(-α d(x,y)), α=0.5")
plt.xlabel("d(x,y) = Distanz")
plt.ylabel("Kohärenz K(x,y)")
plt.title("3.6.6 Kohärenzfunktion")
plt.grid(True)
plt.legend()
plt.show()
