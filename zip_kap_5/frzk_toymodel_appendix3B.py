
# FRZK Toy-Model: correlation -> distance -> MDS -> Procrustes
import numpy as np
from numpy.linalg import svd, eig
import matplotlib.pyplot as plt
import pandas as pd

def simulate_spatial_time_series(coords, T=300, K=3, scale=1.0, noise_std=0.1, seed=42):
    np.random.seed(seed)
    N = coords.shape[0]
    mins = coords.min(axis=0)
    maxs = coords.max(axis=0)
    centers = np.random.uniform(mins, maxs, size=(K, 2))
    t = np.linspace(0, 10, T)
    sources = np.array([np.sin(2*np.pi*(0.2 + 0.1*np.random.rand())*t + 2*np.pi*np.random.rand()) for _ in range(K)])
    weights = np.zeros((N, K))
    for i in range(N):
        for k in range(K):
            d = np.linalg.norm(coords[i] - centers[k])
            weights[i,k] = np.exp(-d/scale)
    series = weights @ sources + noise_std * np.random.randn(N, T)
    series = (series - series.mean(axis=1, keepdims=True)) / (series.std(axis=1, keepdims=True) + 1e-8)
    return series, centers

def pairwise_distances(X):
    diff = X[:, None, :] - X[None, :, :]
    D = np.sqrt(np.sum(diff**2, axis=2))
    return D

def corr_to_distance(R):
    R = np.clip(R, -1+1e-12, 1-1e-12)
    D = np.sqrt(2 * (1 - R))
    return D

def classical_mds(D, n_components=2):
    n = D.shape[0]
    J = np.eye(n) - np.ones((n,n))/n
    B = -0.5 * J @ (D**2) @ J
    eigvals, eigvecs = eig(B)
    idx = np.argsort(eigvals)[::-1]
    eigvals = np.real(eigvals[idx])
    eigvecs = np.real(eigvecs[:, idx])
    L = np.diag(np.sqrt(np.maximum(eigvals[:n_components], 0)))
    V = eigvecs[:, :n_components]
    X = V @ L
    return X, eigvals

def procrustes(X, Y):
    Xm = X - X.mean(axis=0)
    Ym = Y - Y.mean(axis=0)
    U, s, Vt = svd(Xm.T @ Ym)
    R = U @ Vt
    scale = np.trace((Ym.T @ Xm @ R)) / np.trace(Xm.T @ Xm)
    X_aligned = (Xm @ R) * scale
    X_aligned = X_aligned + Y.mean(axis=0)
    return X_aligned, R, scale

params = {
    "seed": 42,
    "N": 20,
    "T": 300,
    "K": 3,
    "scale": 1.5,
    "noise_std": 0.3
}

np.random.seed(params["seed"])
coords = np.random.uniform(-3, 3, size=(params["N"], 2))

series, centers = simulate_spatial_time_series(coords, T=params["T"], K=params["K"], scale=params["scale"], noise_std=params["noise_std"], seed=params["seed"])
R = np.corrcoef(series)
D_from_corr = corr_to_distance(R)
X_mds, eigvals = classical_mds(D_from_corr, n_components=2)
X_aligned, Ropt, scl = procrustes(X_mds, coords)
D_true = pairwise_distances(coords)
D_emb = pairwise_distances(X_aligned)
rmse = np.sqrt(np.mean((D_true - D_emb)**2))
stress = np.sqrt(np.sum((D_true - D_emb)**2) / np.sum(D_true**2))

metrics = {
    "RMSE_pairwise_dist": float(rmse),
    "Normalized_stress": float(stress),
    "MDS_top_eigvals_sum": float(np.sum(eigvals[:2]))
}

# Save outputs
plt.figure(figsize=(6,6))
plt.scatter(coords[:,0], coords[:,1], marker='o', label='Ground truth')
plt.scatter(X_aligned[:,0], X_aligned[:,1], marker='x', label='MDS embedding (aligned)')
for i in range(params["N"]):
    plt.plot([coords[i,0], X_aligned[i,0]], [coords[i,1], X_aligned[i,1]], linewidth=0.6)
plt.title("Ground truth positions vs. reconstructed MDS embedding")
plt.legend()
plt.xlabel("x")
plt.ylabel("y")
plt.axis('equal')
plt.tight_layout()
plt.savefig("positions_vs_embedding.png", dpi=300)
plt.close()

plt.figure(figsize=(6,5))
plt.scatter(D_true.flatten(), D_emb.flatten(), s=8)
mx = max(D_true.max(), D_emb.max())
plt.plot([0, mx], [0, mx], linestyle='--')
plt.xlabel("True pairwise distance")
plt.ylabel("Reconstructed pairwise distance from correlation→MDS")
plt.title("True vs Reconstructed pairwise distances (all pairs)")
plt.tight_layout()
plt.savefig("true_vs_reconstructed_distances.png", dpi=300)
plt.close()

pd.DataFrame([params]).to_csv("params_log.csv", index=False)
pd.DataFrame([metrics]).to_csv("metrics.csv", index=False)
