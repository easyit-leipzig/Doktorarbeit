import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

np.random.seed(1)

# Zeitachse
T = 200
t = np.linspace(0, 1, T)

# Operatoren simulieren (synthetische Verläufe)
sigma = 0.6 * np.exp(-((t - 0.4) ** 2) / (2 * 0.06 ** 2)) + 0.2 * np.exp(-((t - 0.75) ** 2) / (2 * 0.02 ** 2))
S = 0.5 / (1 + np.exp(-20 * (t - 0.35))) + 0.05 * np.random.randn(T)       # Symbolische Struktur
D = 0.4 * np.sin(6 * np.pi * t) * (0.5 + t) + 0.1 * np.random.randn(T)     # Diskurs
M = 0.6 / (1 + np.exp(-40 * (t - 0.6)))                                    # Metareflexion
R = 0.3 * (t % 0.15) / 0.15 + 0.02 * np.random.randn(T)                    # Rekursion
E = 0.25 * S + 0.35 * D + 0.25 * R + 0.15 * sigma + 0.03 * np.random.randn(T)  # Emergenz

# Intentionaler Vektor
I = np.vstack([sigma, S, D, M, R, E]).T  # Shape (T,6)

# Diagnostik: steigender Diskurs bei stagnierender Reflexion
dD_dt = np.gradient(D, t)
dM_dt = np.gradient(M, t)
rising_discourse = dD_dt > np.percentile(dD_dt, 75)
stagnant_reflex = np.abs(dM_dt) < 0.5 * np.median(np.abs(dM_dt))
diagnostic_points = np.where(rising_discourse & stagnant_reflex)[0]

# --- Grafik 1: 3D-Trajektorie ---
fig = plt.figure(figsize=(15, 15))
ax3d = fig.add_subplot(2, 1, 1, projection='3d')

ax3d.plot(I[:,1], I[:,2], I[:,5], linewidth=1.5)  # (S,D,E)
ax3d.scatter(I[:,1], I[:,2], I[:,5], s=20 * (0.5 + sigma), alpha=0.8)

ax3d.set_xlabel('S (symbolic structure)')
ax3d.set_ylabel('D (diskurs)')
ax3d.set_zlabel('E (emergent order)')
ax3d.set_title('3D-Trajektorie im intentionalen Raum (S,D,E)')

# Annotiere diagnostische Punkte
for idx in diagnostic_points:
    ax3d.text(I[idx,1], I[idx,2], I[idx,5], f'{idx}', fontsize=8)

# --- Grafik 2: Zeitreihen aller Operatoren ---
operators = {
    'σ (semantische Dichte)': sigma,
    'S (symbolische Struktur)': S,
    'D (Diskurs)': D,
    'M (Metareflexion)': M,
    'R (Rekursion)': R,
    'E (emergente Ordnung)': E
}

fig_ts, axes = plt.subplots(len(operators), 1, figsize=(8, 12), sharex=True)
fig_ts.suptitle('Operator-Verläufe im intentionalen Raum')

for ax, (label, series) in zip(axes, operators.items()):
    ax.plot(t, series, linewidth=1)
    ax.set_ylabel(label, rotation=0, labelpad=110, va='center')
    if label.startswith('D ('):
        for idx in diagnostic_points:
            ax.axvline(t[idx], linestyle='--', linewidth=0.6)
    ax.grid(True, linestyle=':', linewidth=0.4)

axes[-1].set_xlabel('Zeit (t, normiert)')
plt.tight_layout(rect=[0, 0.03, 1, 0.95])
plt.show()

# --- Diagnostische Zusammenfassung ---
print("Diagnostische Zusammenfassung:")
print(f"Gesamtanzahl Zeitpunkte: {T}")
print(f"Gefundene kritische Punkte: {len(diagnostic_points)}")
if len(diagnostic_points) > 0:
    print("Indizes:", diagnostic_points.tolist())
