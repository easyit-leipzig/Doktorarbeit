# ============================================================
# Anlage: Kommentiertes FZRK-GeoLab-Skript mit Erklärung
# ============================================================

# Dieses Skript demonstriert die Grundidee des FZRK – ein System,
# das sich selbst aus der Leere konstruiert, indem es Bezugspunkte
# erzeugt, diesen Punkte räumliche Koordinaten zuweist, ein Feld
# über den Raum legt und schließlich Akteure erzeugt, die sich in
# diesem Feld verhalten. Jeder Schritt wird dokumentiert.

# ------------------------------------------------------------
# 1. Initialpunkt: Der leere Anfang
# ------------------------------------------------------------

Empty = type("Empty", (), {})  # symbolischer Platzhalter

# ------------------------------------------------------------
# 2. Einheitliche Setzung eines ersten Unterscheidbaren
# ------------------------------------------------------------

class Unit:
    def __init__(self):
        self.identity = "I"

# ------------------------------------------------------------
# 3. Bezugspunkt: Eine Adresse im Raum
# ------------------------------------------------------------

class Identifier:
    def __init__(self, label):
        self.label = label  # z. B. "U1", "U2", etc.

# ------------------------------------------------------------
# 4. Raumfunktionen x, y, z: erzeugen eine Position
# ------------------------------------------------------------

def x(U: Identifier) -> float:
    return float(hash(U.label) % 100)

def y(U: Identifier) -> float:
    return float((hash(U.label) + 37) % 100)

def z(U: Identifier) -> float:
    return float((hash(U.label) + 71) % 100)

def coords(U: Identifier) -> tuple:
    return (x(U), y(U), z(U))  # Koordinatentripel

# ------------------------------------------------------------
# 5. Brane-Funktion h(x, y, z): Feld im Raum
# ------------------------------------------------------------

def h(x: float, y: float, z: float) -> float:
    return -1.0 / (x**2 + y**2 + z**2 + 1e-5)  # zentrales Potential

Field = h  # Kurzform

# ------------------------------------------------------------
# 6. Handlung: Reaktion auf das Feld
# ------------------------------------------------------------

class Action:
    def __init__(self, description):
        self.description = description

def A(field, x: float, y: float, z: float, t: float) -> Action:
    potential = field(x, y, z)
    return Action(f"Move to lower Ψ from ({x:.2f}, {y:.2f}, {z:.2f}), Ψ={potential:.4f}")

# ------------------------------------------------------------
# 7. Meta-Funktion: Beobachtung und Protokollierung
# ------------------------------------------------------------

class Observation:
    def __init__(self, agent, potential, location, time):
        self.agent = agent
        self.potential = potential
        self.location = location
        self.time = time

MetaLog = []

def M(agent_function, field, x: float, y: float, z: float, t: float) -> Observation:
    action = agent_function(field, x, y, z, t)
    potential = field(x, y, z)
    observation = Observation(agent=action.description, potential=potential,
                              location=(x, y, z), time=t)
    MetaLog.append({
        "action": action.description,
        "potential": potential,
        "position": (x, y, z),
        "time": t
    })
    return observation

# ------------------------------------------------------------
# 8. Beispiel: Anwendung auf einen Bezugspunkt
# ------------------------------------------------------------

U1 = Identifier("U1")
x1, y1, z1 = coords(U1)
t1 = 0.0
obs1 = M(A, Field, x1, y1, z1, t1)

# Ausgabe des Protokolls
from pprint import pprint
print("=== MetaLog (Selbstbeobachtung) ===")
pprint(MetaLog)