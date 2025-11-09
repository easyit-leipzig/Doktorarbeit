# 3.6.4: -log(P(x->y)) als Distanz
import numpy as np
import matplotlib.pyplot as plt

P = np.linspace(0.01,1,100)
d_info = -np.log(P)

plt.figure(figsize=(8,5))
plt.plot(P,d_info,"r",label="d_info(x,y) = -log P(x->y)")
plt.xlabel("P(x→y) = Erfolgswahrscheinlichkeit")
plt.ylabel("d_info")
plt.title("3.6.4 Informationstheoretische Distanz")
plt.legend()
plt.grid(True)
plt.show()
