import numpy as np
import plotly.graph_objects as go
from skimage import measure

# Parameter
grid_size = 20
D = 0.1
alpha = 1.0
beta = 5.0
lambda_coupling = 0.8

# Gitter
x = np.linspace(-5, 5, grid_size)
y = np.linspace(-5, 5, grid_size)
z = np.linspace(-5, 5, grid_size)
X, Y, Z = np.meshgrid(x, y, z, indexing='ij')

# Felder berechnen
sigma = np.exp(-(X**2 + Y**2 + Z**2))
V = alpha * np.exp(-beta * (X**2 + Y**2 + Z**2))
gradV_x, gradV_y, gradV_z = np.gradient(V, x, y, z)
div_sigma_gradV = (
    np.gradient(sigma * gradV_x, x, axis=0) +
    np.gradient(sigma * gradV_y, y, axis=1) +
    np.gradient(sigma * gradV_z, z, axis=2)
)
laplacian_sigma = (
    np.gradient(np.gradient(sigma, x, axis=0), x, axis=0) +
    np.gradient(np.gradient(sigma, y, axis=1), y, axis=1) +
    np.gradient(np.gradient(sigma, z, axis=2), z, axis=2)
)
P = np.exp(-((X - 1.5)**2 + (Y + 1.5)**2 + Z**2))

# Dynamikfeld
d_sigma_dt = D * laplacian_sigma - div_sigma_gradV + lambda_coupling * P
field_norm = d_sigma_dt / np.max(d_sigma_dt)

# Isofläche erzeugen
verts, faces, _, _ = measure.marching_cubes(field_norm, level=0.3)

# Punkte in Koordinaten übersetzen
xv, yv, zv = verts.T
i, j, k = faces.T

# Plotly-Mesh3D erzeugen
fig = go.Figure(data=[go.Mesh3d(
    x=xv, y=yv, z=zv,
    i=i, j=j, k=k,
    intensity=zv,
    colorscale='Viridis',
    showscale=True,
    opacity=0.8
)])

fig.update_layout(
    title='3D Surface: ∂σ/∂t im semantischen Raum',
    scene=dict(
        xaxis_title='x',
        yaxis_title='y',
        zaxis_title='z',
        aspectmode='cube'
    )
)

fig.show()  # <-- wichtig! NICHT plt.show()