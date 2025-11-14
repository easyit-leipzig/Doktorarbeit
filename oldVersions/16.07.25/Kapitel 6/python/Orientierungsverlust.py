import json
import numpy as np
import matplotlib.pyplot as plt

# JSON-Datei laden
with open("e:/xampp/htdocs/easyDidak/library/php/frzk_semantische_dichte.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Extrahiere Dimensionen
x = np.array([d["x_kognition"] for d in data])
y = np.array([d["y_sozial"] for d in data])
z = np.array([d["z_affektiv"] for d in data])
h = np.array([d["h_bedeutung"] for d in data])

# --- Gradient berechnen (numerisch) ---
# Wir brauchen Gitterstruktur -> einfache Interpolation durch np.gradient
# Dazu nehmen wir h als Funktion der Indexreihenfolge
dh_dx = np.gradient(h, x, edge_order=1)
dh_dy = np.gradient(h, y, edge_order=1)
dh_dz = np.gradient(h, z, edge_order=1)

# Betrag des Gradienten
grad_h = np.sqrt(dh_dx**2 + dh_dy**2 + dh_dz**2)

# Normierung und Orientierungsverlust
max_grad = np.max(grad_h) if np.max(grad_h) > 0 else 1.0
O_t = 1 - (grad_h / max_grad)

# --- Visualisierung ---
plt.figure(figsize=(10, 6))
plt.plot(O_t, marker="o")
plt.title("Orientierungsverlust O(t) nach FRZK")
plt.xlabel("Zeit / Index")
plt.ylabel("O(t)")
plt.grid(True)
plt.show()
