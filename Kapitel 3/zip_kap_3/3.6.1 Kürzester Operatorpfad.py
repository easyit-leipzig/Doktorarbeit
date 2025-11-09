# 3.6.1: Minimale Operatorpfade (d(x,y))
import networkx as nx
import matplotlib.pyplot as plt

# Beispiel-Graph: Operatoren als Kanten
G = nx.DiGraph()
edges = [("Bruchrechnen","Umformen"),
         ("Umformen","Lineare Gleichungen"),
         ("Bruchrechnen","Termumgang"),
         ("Termumgang","Lineare Gleichungen")]

G.add_edges_from(edges)

# Kürzester Pfad
path = nx.shortest_path(G, "Bruchrechnen", "Lineare Gleichungen")
print("Kürzester Operatorpfad:", path)

# Zeichnen
pos = nx.spring_layout(G, seed=1)
nx.draw(G, pos, with_labels=True, node_size=2000, node_color="lightblue", arrowsize=20)
nx.draw_networkx_edges(G, pos, edgelist=[(path[i], path[i+1]) for i in range(len(path)-1)],
                       edge_color="red", width=2)

plt.title("3.6.1 Kürzester Operatorpfad")
plt.show()
