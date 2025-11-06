# 3.7.8 Übersicht - Baumschema
import matplotlib.pyplot as plt
import networkx as nx

G = nx.DiGraph()
edges = [
    ("Operatoren","Definition"),
    ("Operatoren","Dynamik"),
    ("Operatoren","Vorhersage"),
    ("Operatoren","Metrik"),
    ("Operatoren","Simulation"),
    ("Operatoren","Empirie"),
    ("Operatoren","Kapitel-Integration")
]
G.add_edges_from(edges)

pos = nx.spring_layout(G, seed=2)
nx.draw(G, pos, with_labels=True, node_color="lightgreen", node_size=2500, arrows=True)
plt.title("3.7.8 Zusammenfassung: Die Operatorenkaskade")
plt.show()
