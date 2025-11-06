import requests
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# URL des PHP-Endpunkts
url = "http://localhost/easyDidak/library/php/Orientierungsverlust O(x,y)_old.php"

# Hole die JSON-Daten von der PHP-Datei
data = requests.get(url).json()

# X- und Y-Achsen-Beschriftungen
x_labels = data["x_labels"]
y_labels = data["y_labels"]
O = np.array(data["O"], dtype=float)  # O bleibt unverändert

# Erstelle ein Gitter für die X- und Y-Achse
x = np.arange(len(x_labels))
y = np.arange(len(y_labels))

# Erstelle ein 3D-Plot
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection='3d')

# Erstelle das Meshgrid für X und Y (für die 3D-Fläche)
X, Y = np.meshgrid(x, y)

# Plot der 3D-Oberfläche
surf = ax.plot_surface(X, Y, O, cmap="magma", edgecolor="none")

# Farbskala (Colorbar)
cbar = fig.colorbar(surf)
cbar.set_label("Orientierungsverlust O(x,y)")

# Achsenbeschriftungen
ax.set_xlabel('x-Bereich (kognitive Dimension)')
ax.set_ylabel('y-Bereich (soziale Dimension)')
ax.set_zlabel('Orientierungsverlust O(x,y)')
ax.set_title("3D-Oberfläche der Orientierungsverluste")

# Setze die X- und Y-Ticks auf die Labels aus den JSON-Daten
ax.set_xticks(x)
ax.set_xticklabels(x_labels, rotation=45, ha="right")
ax.set_yticks(y)
ax.set_yticklabels(y_labels)

# Layout anpassen
plt.tight_layout()

# Zeige das Plot
plt.show()
