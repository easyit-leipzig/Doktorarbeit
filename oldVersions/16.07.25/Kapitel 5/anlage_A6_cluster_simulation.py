# ================================================================
# Anlage A6 – Dichtesimulation und Clusterbildung im semantischen Raum
# ================================================================
# Dieses Skript zeigt, wie eine Menge von Punkten im Raum miteinander
# interagieren, ihre semantischen Dichten verändern und sich schließlich
# in funktional entstandene Cluster organisieren.
# Dies illustriert, wie im FZRK aus lokalen Regeln globale Ordnung emergieren kann.
# ================================================================

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans

# -------------------------------
# 1. Initiale Parameter
# -------------------------------
n_points = 100  # Anzahl der Punkte im Raum
n_iterations = 100  # Iterationen zur Dichteangleichung
influence_radius = 0.1  # Radius, innerhalb dessen Punkte sich beeinflussen

# -------------------------------
# 2. Initialisierung des Raumes
# -------------------------------
positions = np.random.rand(n_points, 3)  # Zufällige Positionen im Raum
semantic_densities = np.random.rand(n_points)  # Zufällige semantische Dichten (zwischen 0 und 1)

# -------------------------------
# 3. Interaktionsfunktionen
# -------------------------------
def distance(pos1, pos2):
    return np.linalg.norm(pos1 - pos2)

def interaction(d1, d2, dist):
    if dist < influence_radius:
        return (d2 - d1) * np.exp(-dist**2 / influence_radius**2)
    else:
        return 0

def update_density(density, interaction_sum, learning_rate=0.1):
    return density + learning_rate * interaction_sum

# -------------------------------
# 4. Simulation der Dichteentwicklung
# -------------------------------
for iteration in range(n_iterations):
    all_interactions = np.zeros(n_points)
    for i in range(n_points):
        interactions = [
            interaction(semantic_densities[i], semantic_densities[j], distance(positions[i], positions[j]))
            for j in range(n_points) if i != j
        ]
        all_interactions[i] = np.sum(interactions)

    semantic_densities = np.array([
        update_density(semantic_densities[i], all_interactions[i]) for i in range(n_points)
    ])
    semantic_densities = np.clip(semantic_densities, 0, 1)  # Werte bleiben im Bereich [0,1]

    # Visualisierung der Dichteverteilung (alle 10 Schritte)
    if iteration % 10 == 0:
        fig = plt.figure(figsize=(8, 6))
        ax = fig.add_subplot(111, projection='3d')
        ax.scatter(positions[:, 0], positions[:, 1], positions[:, 2], c=semantic_densities, cmap='viridis', s=50)
        ax.set_title(f'Semantische Dichten – Iteration {iteration}')
        plt.show()

# -------------------------------
# 5. Clusteranalyse
# -------------------------------
n_clusters = 3
kmeans = KMeans(n_clusters=n_clusters, random_state=0, n_init='auto')
cluster_labels = kmeans.fit_predict(positions)

# Visualisierung der Cluster
fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(positions[:, 0], positions[:, 1], positions[:, 2], c=cluster_labels, cmap='viridis', s=50)
ax.set_title('Clusterbildung auf Basis räumlicher Nähe')
plt.show()

# Clustergrößen ausgeben
cluster_sizes = np.bincount(cluster_labels)
print("Clustergrößen:", cluster_sizes)
print("Letzte semantische Dichten:", semantic_densities)