# analyze_dominanztransitionen.py
import json
from collections import Counter, defaultdict
import pandas as pd
import matplotlib.pyplot as plt

INFILE = "dominanztransitionen.json"
OUT_PREFIX = "dominanztransitionen"

def main():
    with open(INFILE, "r", encoding="utf-8") as f:
        data = json.load(f)

    transitions = data["transitions"]
    df = pd.DataFrame(transitions)

    if df.empty:
        print("Keine Dominanztransitionen vorhanden.")
        return

    counts = Counter(df["transition"])
    dims = sorted(set(df["from"]).union(set(df["to"])))

    matrix = pd.DataFrame(0, index=dims, columns=dims, dtype=int)
    for _, r in df.iterrows():
        matrix.loc[r["from"], r["to"]] += 1

    prob = matrix.div(matrix.sum(axis=1).replace(0, 1), axis=0)

    summary_lines = []
    summary_lines.append("# Auswertung Dominanztransitionen\n")
    summary_lines.append(f"Datensätze: {data['summary']['n_records']}")
    summary_lines.append(f"Sequenzen: {data['summary']['n_sequences']}")
    summary_lines.append(f"Transitionen: {data['summary']['n_transitions']}")
    summary_lines.append(f"Stabilitätsrate: {data['summary']['stability_rate']:.4f}")
    summary_lines.append(f"Transitionsentropie: {data['summary']['transition_entropy']:.4f}\n")

    summary_lines.append("## Häufigste Übergänge")
    for tr, c in counts.most_common(20):
        summary_lines.append(f"- {tr}: {c}")

    summary_lines.append("\n## FRZK-Deutung")
    summary_lines.append(
        "Stabile Übergänge D(t)->D(t+1) zeigen Attraktorbindung. "
        "Wechsel wie Motivation->Regulation oder Kognition->Performanz zeigen dagegen funktionale Zustandsverschiebungen. "
        "Hohe Entropie spricht für variable Übergangsdynamik, niedrige Entropie für wiederkehrende Dominanzpfade."
    )

    with open(f"{OUT_PREFIX}_bericht.md", "w", encoding="utf-8") as f:
        f.write("\n".join(summary_lines))

    matrix.to_csv(f"{OUT_PREFIX}_matrix_counts.csv", encoding="utf-8-sig")
    prob.to_csv(f"{OUT_PREFIX}_matrix_probabilities.csv", encoding="utf-8-sig")

    plt.figure(figsize=(10, 7))
    plt.imshow(matrix.values)
    plt.xticks(range(len(dims)), dims, rotation=45, ha="right")
    plt.yticks(range(len(dims)), dims)
    plt.colorbar(label="Anzahl")
    plt.title("Dominanztransitionen – absolute Häufigkeiten")
    plt.xlabel("D(t+1)")
    plt.ylabel("D(t)")
    plt.tight_layout()
    plt.savefig(f"{OUT_PREFIX}_heatmap_counts.png", dpi=200)
    plt.close()

    top = pd.Series(counts).sort_values(ascending=False).head(15)
    plt.figure(figsize=(10, 6))
    top.plot(kind="bar")
    plt.title("Häufigste Dominanztransitionen")
    plt.ylabel("Anzahl")
    plt.tight_layout()
    plt.savefig(f"{OUT_PREFIX}_top_transitions.png", dpi=200)
    plt.close()

    print(f"Erzeugt: {OUT_PREFIX}_bericht.md")
    print(f"Erzeugt: {OUT_PREFIX}_matrix_counts.csv")
    print(f"Erzeugt: {OUT_PREFIX}_matrix_probabilities.csv")
    print(f"Erzeugt: {OUT_PREFIX}_heatmap_counts.png")
    print(f"Erzeugt: {OUT_PREFIX}_top_transitions.png")

if __name__ == "__main__":
    main()