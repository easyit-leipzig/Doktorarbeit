# orientation_loss.py
import requests
import numpy as np
import matplotlib.pyplot as plt

url = "http://localhost/easyDidak/library/php/Orientierungsverlust O(x,y)_old.php"
data = requests.get(url).json()

x_labels = data["x_labels"]
y_labels = data["y_labels"]
O = np.array(data["O"], dtype=float).T

plt.figure(figsize=(10, 6))
plt.imshow(O, cmap="magma", origin="lower", aspect="auto", vmin=0, vmax=1)
plt.colorbar(label="Orientierungsverlust O(x,y)")
plt.xticks(ticks=np.arange(len(x_labels)), labels=x_labels, rotation=45)
plt.yticks(ticks=np.arange(len(y_labels)), labels=y_labels)
plt.title("Gradientenkarte – Orientierungsverlust O(x,y)")
plt.xlabel("x-Bereich (kognitive Dimension)")
plt.ylabel("y-Bereich (soziale Dimension)")
plt.tight_layout()
plt.show()
