import matplotlib.pyplot as plt
import networkx as nx

# Axiome und Basisoperatoren
axioms = ["A1: Nullstruktur", "A2: Differenz", "A3: Regelhaftigkeit", "A4: Nachvollziehbarkeit"]
operators = ["∅ Leere", "I Initialisierung", "σ Zuweisung", "R Relation", "E Emergenz", "M Metrik"]

# Mapping zwischen Axiomen und Operatoren
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

# Graph erstellen
G = nx.DiGraph()
G.add_nodes_from(axioms + operators)
G.add_edges_from(edges)

# Layout: Axiome links, Operatoren rechts
pos = {}
for i, a in enumerate(axioms):
    pos[a] = (-1, i)
for i, o in enumerate(operators):
    pos[o] = (1, i)

# Plot
plt.figure(figsize=(12, 8))
nx.draw(G, pos, with_labels=True, node_size=3500, node_color="lightblue", font_size=10, arrows=True, arrowstyle="-|>", arrowsize=15)
plt.title("Mapping Axiome (links) ↔ Basisoperatoren (rechts)", fontsize=14)
plt.show()
