# Skript: extract_numbers.py
# Liest die Textdatei, filtert nur die Zahlen und schreibt sie flach in data.txt

input_file = "rohdaten_realdaten_gruppenaggregation.txt"  # Dein Original-File
output_file = "data.txt"  # Ausgabe

data = []

with open(input_file, "r", encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        # Nur Zeilen, die komplett aus Ziffern bestehen
        if line.isdigit():
            data.append(line)
            print(line)
# Schreibe die gefilterten Zahlen als Flat Text
with open(output_file, "w", encoding="utf-8") as f:
    for number in data:
        f.write(number + "\n")

print(f"Fertig! {len(data)} Zahlen in '{output_file}' geschrieben.")
