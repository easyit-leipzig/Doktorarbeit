import matplotlib.pyplot as plt
import networkx as nx

# Graph definieren
G = nx.DiGraph()

# Axiome (links)
axiome = ["A1: Nullstruktur", "A2: Differenz", "A3: Regelhaftigkeit", "A4: Nachvollziehbarkeit"]
# Basisoperatoren (rechts)
operatoren = ["∅ Leere", "I Initialisierung", "σ Zuweisung", "R Relation", "E Emergenz", "M Metrik"]

# Knoten hinzufügen
G.add_nodes_from(axiome, bipartite=0)
G.add_nodes_from(operatoren, bipartite=1)

# Kanten definieren
edges = [
    ("A1: Nullstruktur", "∅ Leere"),
    ("A2: Differenz", "I Initialisierung"),
    ("A3: Regelhaftigkeit", "σ Zuweisung"),
    ("A3: Regelhaftigkeit", "R Relation"),
    ("A3: Regelhaftigkeit", "E Emergenz"),
    ("A3: Regelhaftigkeit", "M Metrik"),
    ("A4: Nachvollziehbarkeit", "σ Zuweisung"),
    ("A4: Nachvollziehbarkeit", "R Relation"),
    ("A4: Nachvollziehbarkeit", "E Emergenz"),
    ("A4: Nachvollziehbarkeit", "M Metrik"),
]
G.add_edges_from(edges)

# Layout: Abstand groß genug wählen, damit sich die Kreise nicht überlappen
pos = {}
spacing = 28.0  # vertikaler Abstand (hoch genug für node_size=8000)

# links (Axiome)
for i, node in enumerate(axiome):
    pos[node] = (0, -i * spacing)
# rechts (Operatoren)
for i, node in enumerate(operatoren):
    pos[node] = (5, -i * spacing)  # horizontale Distanz etwas größer (5 statt 3)

# Plot
plt.figure(figsize=(16, 20))

# Größere Kreise
node_size = 8000

nx.draw_networkx_nodes(G, pos, nodelist=axiome, node_color="lightblue", node_size=node_size)
nx.draw_networkx_nodes(G, pos, nodelist=operatoren, node_color="lightblue", node_size=node_size)

nx.draw_networkx_labels(G, pos, font_size=11, font_weight="bold")

nx.draw_networkx_edges(
    G,
    pos,
    edgelist=edges,
    arrowstyle="->",
    arrowsize=18,
    connectionstyle="arc3,rad=0.05",
    node_size=node_size  # sorgt dafür, dass Pfeile korrekt an den Rändern enden
)

plt.title("Mapping Axiome (links) ↔ Basisoperatoren (rechts)")
plt.axis("off")
plt.show()
