"""
Visualisierung des Orientierungsmaßes O(U) im 3D-Epistemischen Raum

Benötigte Pakete:
    numpy, matplotlib
Optional (interaktiv):
    plotly

Installation (falls nötig):
    pip install numpy matplotlib plotly

Erläuterung:
    - Definiere Hubs als Liste von (x,y,z) Koordinaten
    - Definiere zugehörige Gewichte w_k und Reichweiten sigma_k
    - Script erstellt ein reguläres Gitter, berechnet O(U) und zeigt:
        * 3D-Punktwolke (gewichtete Stichprobe, damit Zentrum / Hubs sichtbar sind)
        * 3 XY-Schnitte zur Orientierung (z = z_slices)
        * (Optional) interaktive Isosurface mit plotly
"""
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401

# -------------------------
# 1) Parameter / Hubs
# -------------------------
# Beispiel-Hubs: passe hier deine hk, wk, sigma_k an
hubs = np.array([
    [0.0, 0.0, 0.0],   # zentraler Hub im Ursprung
    [1.0, 0.8, -0.5],  # Satellit 1
    [-1.2, -0.6, 0.9], # Satellit 2
])

weights = np.array([1.2, 0.8, 0.6])       # w_k
sigmas = np.array([0.35, 0.6, 0.7])       # sigma_k (Reichweiten)

assert hubs.shape[0] == weights.size == sigmas.size, "Anzahl Hubs, Weights und Sigmas muss übereinstimmen."

# Raumgrenzen und Gitterauflösung
lim = 2.0          # ±Lim in jeder Achse
res = 60           # Gitterauflösung pro Achse (res^3 Punkte; 60 => 216k Werte; anpassen)
xs = np.linspace(-lim, lim, res)
ys = np.linspace(-lim, lim, res)
zs = np.linspace(-lim, lim, res)

# -------------------------
# 2) Definition von O(U)
# -------------------------
def orientation_O(X, Y, Z, hubs, weights, sigmas):
    """
    Berechnet O(U) auf Vektoren X, Y, Z (gleichförmig geformt).
    X,Y,Z können 3D-Arrays (meshgrid) oder 1D-Flattenarrays sein.
    Rückgabe: Array gleicher Form mit O-Werten.
    """
    # Stelle sicher, dass hubs, weights, sigmas numpy arrays sind
    hubs = np.asarray(hubs)
    weights = np.asarray(weights)
    sigmas = np.asarray(sigmas)
    # Form bestimmen
    flat = False
    if X.ndim == 1:
        # X, Y, Z als 1D arrays (flach)
        pts = np.stack([X, Y, Z], axis=1)  # (N,3)
        O = np.zeros(pts.shape[0])
        for k, (hk, wk, sk) in enumerate(zip(hubs, weights, sigmas)):
            d2 = np.sum((pts - hk)**2, axis=1)
            O += wk * np.exp(-d2 / (2 * sk**2))
        return O
    else:
        # X,Y,Z sind 3D arrays (meshgrid) -> berechne flach und reshape zurück
        shape = X.shape
        pts = np.stack([X.ravel(), Y.ravel(), Z.ravel()], axis=1)
        Oflat = np.zeros(pts.shape[0])
        for k, (hk, wk, sk) in enumerate(zip(hubs, weights, sigmas)):
            d2 = np.sum((pts - hk)**2, axis=1)
            Oflat += wk * np.exp(-d2 / (2 * sk**2))
        return Oflat.reshape(shape)

# -------------------------
# 3) Gitter erzeugen, O berechnen
# -------------------------
X, Y, Z = np.meshgrid(xs, ys, zs, indexing='xy')  # shape: (res,res,res)
print("Berechne O(U) auf Gitter (dies kann einige Sekunden dauern)...")
O = orientation_O(X, Y, Z, hubs, weights, sigmas)  # shape = (res,res,res)
print("Fertig.")

# -------------------------
# 4) Gewichtete Stichprobe zum Plotten (sparsify für Performance)
# -------------------------
rng = np.random.default_rng(42)
N_plot = 20000  # Anzahl Punkte, die geplottet werden; anpassen je nach RAM/Leistung
# Flatten Gitter
Xf = X.ravel()
Yf = Y.ravel()
Zf = Z.ravel()
Of = O.ravel()

# Erzeuge Wahrscheinlichkeitsverteilung proportional zu O (plus kleine Regularisierung)
p = Of - Of.min()
if p.sum() <= 0:
    p = np.ones_like(p)
p = p / p.sum()

# Ziehe Indices (mit Ersatz= False wenn genug Punkte)
replace = (N_plot > p.size)
idx = rng.choice(np.arange(p.size), size=N_plot, replace=replace, p=p)

Xs = Xf[idx]
Ys = Yf[idx]
Zs = Zf[idx]
Os = Of[idx]

# Setze Markergrößen proportional zu O (sichtbarer)
sizes = 6 * (Os / Os.max()) + 0.5

# -------------------------
# 5) Matplotlib 3D-Plot (Punktwolke + Schnitte)
# -------------------------
fig = plt.figure(figsize=(12, 9))
ax = fig.add_subplot(111, projection='3d')

sc = ax.scatter(Xs, Ys, Zs, c=Os, cmap='viridis', s=sizes, alpha=0.75, linewidth=0)

ax.set_xlabel('x (kognitiver Zugriff)')
ax.set_ylabel('y (sozialer Kontext)')
ax.set_zlabel('z (affektive Beteiligung)')
ax.set_title(r'Orientierungsmaß $O(U)=\sum_k w_k e^{-\|U-h_k\|^2/(2\sigma_k^2)}$')

cbar = fig.colorbar(sc, shrink=0.6, pad=0.1)
cbar.set_label('O(U)')

# Markiere Hub-Positionen
ax.scatter(hubs[:,0], hubs[:,1], hubs[:,2], color='red', s=80, marker='X', label='Hubs')
for i, hk in enumerate(hubs):
    ax.text(hk[0], hk[1], hk[2], f'  h{i+1}', color='red')

ax.legend()

# Schnittebenen (z-Slices) als farbige Flächen (aus dem Gitter entnommen)
z_slices = [ -1.0, 0.0, 1.0 ]  # passe an; falls außerhalb von [-lim,lim] skip
for z0 in z_slices:
    # Finde nächstliegenden Index in zs
    iz = int(np.argmin(np.abs(zs - z0)))
    # Ebene: X[:,:,iz], Y[:,:,iz], O[:,:,iz]
    Xi = X[:,:,iz]
    Yi = Y[:,:,iz]
    Oi = O[:,:,iz]
    # Projektion leicht transparent in die 3D-Szene
    ax.plot_surface(Xi, Yi, zs[iz], facecolors=plt.cm.viridis((Oi - O.min())/(O.max()-O.min())),
                    rcount=50, ccount=50, antialiased=True, alpha=0.9)

# Perspektive
ax.view_init(elev=30, azim=40)
plt.tight_layout()
plt.show()

# -------------------------
# 6) Optional: Interaktive Isosurface mit Plotly (auskommentiert; aktivieren falls plotly installiert)
# -------------------------
"""
# Uncomment the following block to create an interactive isosurface (Plotly)
import plotly.graph_objects as go

# Flatten arrays for Plotly
Xf_all = X.ravel()
Yf_all = Y.ravel()
Zf_all = Z.ravel()
Of_all = O.ravel()

# Wähle zwei Isowerte (z.B. Quantile)
iso_low = np.percentile(Of_all, 65)
iso_high = np.percentile(Of_all, 90)

figp = go.Figure()
figp.add_trace(go.Isosurface(
    x=Xf_all, y=Yf_all, z=Zf_all, value=Of_all,
    isomin=iso_low, isomax=Of_all.max(), surface_count=3,
    caps=dict(x_show=False, y_show=False, z_show=False),
    opacity=0.4, showscale=True
))

# Add hubs as scatter3d
figp.add_trace(go.Scatter3d(x=hubs[:,0], y=hubs[:,1], z=hubs[:,2],
                            mode='markers+text', marker=dict(size=6, color='red'),
                            text=[f'h{i+1}' for i in range(hubs.shape[0])], textposition='top center'))

figp.update_layout(title='Interaktive Isosurface: O(U)', scene=dict(
    xaxis_title='x', yaxis_title='y', zaxis_title='z'
), width=900, height=700)

figp.show()
# ggf. figp.write_html("O_orientation_isosurface.html")
"""

# -------------------------
# 7) Hinweise / Anpassungen
# -------------------------
# - Erhöhe 'res' für feinere Flächen (geht mit deutlich mehr RAM einher).
# - Passe 'hubs', 'weights', 'sigmas' an dein Modell an.
# - Für Publikationen: fig.savefig("O_orientation_scatter.png", dpi=300)
