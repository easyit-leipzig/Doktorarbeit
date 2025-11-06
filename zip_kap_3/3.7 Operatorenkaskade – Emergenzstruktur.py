import numpy as np
import matplotlib.pyplot as plt

# Definition der Operatoren
def O1(S):  # Initialpunkt
    return np.sin(S) + 0.1

def O2(S):  # Raumfunktion
    return np.gradient(S) + np.cos(S)

def O3(S):  # Brane-Kopplung
    return S * np.tanh(S)

def O4(S):  # Metrik
    return np.sqrt(np.abs(S)) * np.sign(S)

def O5(S):  # Dynamik
    return np.diff(S, prepend=S[0]) + 0.05 * np.sin(S)

def O6(S):  # Akteur-Funktion
    return S + 0.2 * np.gradient(S)

def cascade(S0, steps=6):
    states = [S0]
    for i in range(steps):
        S = O1(states[-1])
        S = O2(S)
        S = O3(S)
        S = O4(S)
        S = O5(S)
        S = O6(S)
        states.append(S)
    return states

# Initialzustand
x = np.linspace(-2*np.pi, 2*np.pi, 500)
S0 = np.zeros_like(x)

# Ausführen der Kaskade
states = cascade(S0, steps=5)

# Visualisierung
plt.figure(figsize=(8,5))
for i, S in enumerate(states):
    plt.plot(x, S, label=f'Step {i}')
plt.title("Operatorenkaskade – Emergenzstruktur")
plt.xlabel("x")
plt.ylabel("Funktionswert")
plt.legend()
plt.show()
