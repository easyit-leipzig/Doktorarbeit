# 3.6.2: Relationstiefe k darstellen
import networkx as nx
import matplotlib.pyplot as plt

G = nx.DiGraph()
edges = [("Lineare Gleichungen","Binome"),
         ("Binome","Faktorisierung"),
         ("Faktorisierung","Quadratische Gleichungen")]

G.add_edges_from(edges)

# Relationstiefe = Pfadlänge
path = nx.shortest_path(G, "Lineare Gleichungen", "Quadratische Gleichungen")
print("Relationstiefe:", len(path)-1)

pos = nx.spring_layout(G, seed=5)
nx.draw(G, pos, with_labels=True, node_size=2200, node_color="lightgreen", arrowsize=20)
nx.draw_networkx_edges(G, pos, edgelist=[(path[i], path[i+1]) for i in range(len(path)-1)],
                       edge_color="red", width=2)

plt.title("3.6.2 Relationstiefe im Lernraum")
plt.show()
