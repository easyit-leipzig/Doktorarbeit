import numpy as np
import matplotlib.pyplot as plt

# Simulationseinstellungen
T = 200
t = np.arange(T)

# Beispiel Input-Zeitreihen (kann durch reale Messdaten ersetzt werden)
# S: symbolische Struktur (aufbauend), D: Diskurs (oszillierend)
S = 0.5 / (1 + np.exp(-0.05*(t-60)))           # langsamer Anstieg
D = 0.3 * np.sin(0.2*t) + 0.15*np.random.randn(T)  # variabler Diskurs (Rauschen)
D = np.clip(D, 0, 1)

# Beispiel: O^hub aus 2 Hubs in 2D (vereinfachte zeitunabhängige Hubs)
def compute_Ohub_grid(T):
    # Hier wird O^hub(t) vereinfacht als Summe zweier zeitlich leicht variierender Hubs
    h1 = 0.7 * np.exp(-0.001*(t-50)**2)
    h2 = 0.5 * np.exp(-0.001*(t-120)**2)
    return h1 + h2

Ohub = compute_Ohub_grid(T)
Ohub = np.clip(Ohub, 0, 1)

# Parameter (einstellbar)
eta = 0.1
alpha_S = 0.6
alpha_D = 0.4
lambda_M = 0.05
kappa = 0.02

rho = 0.98
gamma = 0.01
lambda_R = 0.01

beta = 0.3
delta = 0.25
mu = 0.4

# Startwerte
M = np.zeros(T)
R = np.zeros(T)
O = np.zeros(T)

M[0] = 0.1
R[0] = 0.05
O[0] = 0.2

# Simulation (diskret)
for ti in range(T-1):
    # Inputs at time ti
    S_t = S[ti]
    D_t = D[ti]
    Ohub_t = Ohub[ti]
    O_t = O[ti]
    M_t = M[ti]
    R_t = R[ti]

    # Update M
    M[ti+1] = M_t + eta*(alpha_S*S_t + alpha_D*D_t - lambda_M*M_t) + kappa*R_t*M_t
    M[ti+1] = np.clip(M[ti+1], 0, 1)

    # Update R
    R[ti+1] = rho*R_t + gamma*M_t*O_t - lambda_R*R_t
    R[ti+1] = np.clip(R[ti+1], 0, 1)

    # Update O
    O[ti+1] = O_t + beta*(Ohub_t - O_t) + delta*M_t*(1-O_t) - mu*D_t*(1-M_t)
    O[ti+1] = np.clip(O[ti+1], 0, 1)

# Plots
plt.figure(figsize=(10,8))
plt.subplot(3,1,1)
plt.plot(t, Ohub, label='O^hub (Feldangebot)')
plt.plot(t, O, label='O (erlebte Orientierung)')
plt.legend(); plt.title('Orientierung: Feldangebot vs. erlebte Orientierung')

plt.subplot(3,1,2)
plt.plot(t, M, label='M (Metareflexion)')
plt.plot(t, R, label='R (Rekursion)')
plt.legend(); plt.title('Meta-Operatoren')

plt.subplot(3,1,3)
plt.plot(t, S, label='S (Symbolic Structure)')
plt.plot(t, D, label='D (Diskurs)')
plt.legend(); plt.title('Input-Operatoren')

plt.tight_layout()
plt.show()
