# ============================================================
# FRZK — Demonstrationsskripte zu den Axiomen A1–A4
# ============================================================
# Jedes Skript illustriert das jeweilige Axiom in einer
# einfachen funktionalen Simulation mit Python.
# ------------------------------------------------------------
# Autor: [Dein Name]
# Kapitel: 3.2.5 — Die Axiome des FRZK
# ============================================================

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# ------------------------------------------------------------
# A1 — Leere und Initialisierung
# ------------------------------------------------------------
def demo_A1():
    """
    A1: Aus der Leere (∅) entsteht durch den Initialisierungsoperator I
    ein erster Zustand U0. Formal: I(∅) = U0.
    """

    empty = []  # Leere Menge als Ausgangspunkt

    # Definition des Initialisierungsoperators I
    def I(empty_input):
        # Markiere einen ersten Zustand: Ursprung (0,0)
        pts = np.array([[0.0, 0.0]])
        return pts

    U0 = I(empty)
    print("A1: Initialisierung (I) erzeugt mit Initialstatus U₀:")
    print(U0)

    # Visualisierung: ein einzelner Punkt im Ursprung
    plt.figure(figsize=(4, 4))
    plt.scatter(U0[:, 0], U0[:, 1], s=100, color='navy')
    plt.title("A1: Initialstatus U₀ (Punkt von ∅)")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.grid(True)
    plt.show()


# ------------------------------------------------------------
# A2 — Differenz und Transformation
# ------------------------------------------------------------
def demo_A2():
    """
    A2: Der Operator σ erzeugt Differenzen durch Selektion und Transformation.
    Formal: σ: S → S′ mit σ(s) ≠ s für mindestens ein s ∈ S.
    """

    # Ausgangszustand: Parabel y = x^2
    x = np.linspace(-3, 3, 31)
    state = np.column_stack([x, x**2])

    # Definition des Differenzoperators σ
    def sigma(S, predicate=None, perturb_scale=0.4):
        S = np.array(S)
        if predicate is None:
            mask = S[:, 0] > 0  # Selektion: nur x > 0
        else:
            mask = predicate(S)

        selected = S[mask].copy()
        noise = perturb_scale * np.random.randn(*selected.shape)
        selected_perturbed = selected + noise

        # Kombiniere unveränderte und veränderte Teile
        new_state = np.vstack([S[~mask], selected_perturbed])
        return new_state

    new_state = sigma(state, perturb_scale=0.2)
    print("A2: sigma applied — original vs. new state (first 6 rows):")
    df = pd.DataFrame({
        "orig_x": state[:6, 0],
        "orig_y": state[:6, 1],
        "new_x": new_state[:6, 0],
        "new_y": new_state[:6, 1],
    })
    print(df)

    # Visualisierung: Vorher-Nachher-Parabel
    plt.figure(figsize=(8, 4))
    plt.subplot(1, 2, 1)
    plt.scatter(state[:, 0], state[:, 1], c='darkblue')
    plt.title("A2: Originalstatus")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.grid(True)

    plt.subplot(1, 2, 2)
    plt.scatter(new_state[:, 0], new_state[:, 1], c='darkorange')
    plt.title("A2: Nach σ (Auswahl + Störung)")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.grid(True)
    plt.tight_layout()
    plt.show()


# ------------------------------------------------------------
# A3 — Komposition und Regelhaftigkeit (Monoid)
# ------------------------------------------------------------
def demo_A3():
    """
    A3: Die Operatoren bilden ein Monoid (O,∘,e).
    Demonstration der Assoziativität: (o1∘o2)∘o3 = o1∘(o2∘o3)
    """

    # Erzeuge einfache affine Operatoren
    def make_affine(a, b):
        return lambda x: a * x + b

    o1 = make_affine(2.0, 1.0)   # o1(x) = 2x + 1
    o2 = make_affine(0.5, -0.3)  # o2(x) = 0.5x - 0.3
    o3 = make_affine(-1.0, 0.5)  # o3(x) = -x + 0.5

    def compose(f, g):
        return lambda x: f(g(x))

    xs = np.linspace(-2, 2, 9)

    comp_left = compose(compose(o1, o2), o3)
    comp_right = compose(o1, compose(o2, o3))

    left_vals = np.array([comp_left(x) for x in xs])
    right_vals = np.array([comp_right(x) for x in xs])

    df = pd.DataFrame({
        "x": xs,
        "left_composed": left_vals,
        "right_composed": right_vals,
        "difference": left_vals - right_vals
    })
    print("A3: Associativity check for composition (difference should be ~0):")
    print(df)

    # Visualisierung: beide Kompositionen deckungsgleich
    plt.figure(figsize=(8, 4))
    plt.plot(xs, left_vals, 'o-', label='(o₁∘o₂)∘o₃')
    plt.plot(xs, right_vals, 'x--', label='o₁∘(o₂∘o₃)')
    plt.title("A3: Zusammengesetzte affine Operatoren (Assoziativitätsbeweis)")
    plt.xlabel("Eingabe x")
    plt.ylabel("Ausgabe")
    plt.grid(True)
    plt.legend()
    plt.show()


# ------------------------------------------------------------
# A4 — Transparenz und Nachvollziehbarkeit
# ------------------------------------------------------------
def demo_A4():
    """
    A4: Für jeden Operator o existiert eine beschreibbare Spezifikation spec(o),
    aus der er rekonstruierbar ist. Demonstration: Scale-Threshold Operator.
    """

    # Definition des Operators
    def operator_o(signal, scale=1.5, threshold=0.2):
        res = scale * signal
        res[res < threshold] = 0.0
        return res

    # Spezifikation des Operators
    spec_o = {
        "type": "scale_threshold",
        "params": {"scale": 1.5, "threshold": 0.2},
        "description": "scale by factor, then zero values below threshold"
    }

    # Rekonstruktor aus der Spezifikation
    def reconstruct_from_spec(spec):
        p = spec["params"]
        def reconstructed(signal):
            out = p["scale"] * signal
            out[out < p["threshold"]] = 0.0
            return out
        return reconstructed

    signal = np.linspace(-1, 1, 21)
    out_o = operator_o(signal.copy(), **spec_o["params"])
    reconstructed = reconstruct_from_spec(spec_o)
    out_rec = reconstructed(signal.copy())

    df = pd.DataFrame({
        "signal": signal,
        "out_original": out_o,
        "out_reconstructed": out_rec,
        "diff": out_o - out_rec
    })
    print("A4: Spec-driven reconstruction — original operator vs reconstructed from spec:")
    print(df)

    # Visualisierung: Original vs. Rekonstruktion (deckungsgleich)
    plt.figure(figsize=(6, 4))
    plt.plot(signal, out_o, 'o-', label='Originaloperator')
    plt.plot(signal, out_rec, 'x--', label='Rekonstruktion vom Operator')
    plt.title("A4:Transparenz – Spezifikationsrekonstruktion des Operators")
    plt.xlabel("Signal")
    plt.ylabel("Ausgabe")
    plt.grid(True)
    plt.legend()
    plt.show()


# ============================================================
# Hauptprogramm: alle Demos ausführen
# ============================================================
if __name__ == "__main__":
    print("\n--- Demo A1 ---")
    demo_A1()

    print("\n--- Demo A2 ---")
    demo_A2()

    print("\n--- Demo A3 ---")
    demo_A3()

    print("\n--- Demo A4 ---")
    demo_A4()
