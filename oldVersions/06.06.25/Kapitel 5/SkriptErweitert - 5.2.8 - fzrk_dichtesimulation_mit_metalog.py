# ================================================================
# FZRK – Erweiterungsskript: Dichtesimulation und Clusterbildung
# ================================================================
# Dieses Skript ergänzt das FZRK-GeoLab-Konzept um eine semantische Feldsimulation.
# Punkte im Raum beeinflussen sich gegenseitig über semantische Dichten und organisieren sich in Cluster.
# Durch Rückbindung an den MetaLog wird reflexive Selbstbeobachtung realisiert.
# ================================================================

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans

# -------------------------------
# MetaLog-Struktur
# -------------------------------
MetaLog = []

def log_event(description, **kwargs):
    MetaLog.append({"description": description, **kwargs})

# -------------------------------
# 1. Simulationsparameter
# -------------------------------
n_points = 100
n_iterations = 50
influence_radius = 0.1

# -------------------------------
# 2. Initialisierung des Raumes
# -------------------------------
positions = np.random.rand(n_points, 3)
semantic_densities = np.random.rand(n_points)

# -------------------------------
# 3. Interaktionsfunktionen
# -------------------------------
def distance(p1, p2):
    return np.linalg.norm(p1 - p2)

def interaction(d1, d2, dist):
    if dist < influence_radius:
        return (d2 - d1) * np.exp(-dist**2 / influence_radius**2)
    else:
        return 0

def update_density(density, interaction_sum, learning_rate=0.1):
    return density + learning_rate * interaction_sum

# -------------------------------
# 4. Simulation mit Logging
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
        update_density(semantic_densities[i], all_interactions[i])
        for i in range(n_points)
    ])
    semantic_densities = np.clip(semantic_densities, 0, 1)

    if iteration % 10 == 0:
        fig = plt.figure(figsize=(7, 5))
        ax = fig.add_subplot(111, projection='3d')
        ax.scatter(positions[:, 0], positions[:, 1], positions[:, 2],
                   c=semantic_densities, cmap='viridis', s=40)
        ax.set_title(f'Semantische Dichte – Iteration {iteration}')
        plt.show()
        log_event("Visualisierung", iteration=iteration, density_snapshot=semantic_densities.copy())

# -------------------------------
# 5. Clusterbildung mit Logging
# -------------------------------
n_clusters = 3
kmeans = KMeans(n_clusters=n_clusters, random_state=0, n_init='auto')
cluster_labels = kmeans.fit_predict(positions)

fig = plt.figure(figsize=(7, 5))
ax = fig.add_subplot(111, projection='3d')
ax.scatter(positions[:, 0], positions[:, 1], positions[:, 2],
           c=cluster_labels, cmap='viridis', s=50)
ax.set_title('Clusterbildung (nach Dichteentwicklung)')
plt.show()

log_event("Clusterbildung", clusters=int(n_clusters), cluster_labels=cluster_labels.tolist())

# -------------------------------
# 6. Ergebnisprotokoll
# -------------------------------
from pprint import pprint
print("=== MetaLog-Protokoll ===")
pprint(MetaLog)