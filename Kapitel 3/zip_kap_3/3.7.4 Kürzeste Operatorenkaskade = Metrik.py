# 3.7.4 Minimale Länge der Kaskade
import networkx as nx
import matplotlib.pyplot as plt

# Graphmodell: Knoten = Zustände, Kanten = Operatoren
G = nx.DiGraph()
edges = [("A","B"),("B","C"),("A","C"),("C","D")]
G.add_edges_from(edges)

pos = nx.spring_layout(G, seed=1)
nx.draw(G, pos, with_labels=True, node_color="lightblue", node_size=2000, arrows=True)
labels = {("A","B"):"o1",("B","C"):"o2",("A","C"):"o3",("C","D"):"o4"}
nx.draw_networkx_edge_labels(G, pos, edge_labels=labels)
plt.title("3.7.4 Kürzeste Operatorenkaskade = Metrik")
plt.show()
