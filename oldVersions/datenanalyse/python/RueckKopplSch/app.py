from flask import Flask, render_template, request, redirect
import csv
import os

app = Flask(__name__)

# Bewertungsfelder
felder = [
    ("val_themenauswahl", "Wie gut passten die Themen zu dir?"),
    ("val_materialien", "Wie hilfreich waren die Materialien?"),
    ("val_methodenvielfalt", "Wie vielfältig waren die Methoden?"),
    ("val_individualisierung", "Wie gut war der Unterricht auf dich abgestimmt?"),
    ("val_aufforderung", "Wurdest du zum Mitdenken/Mithandeln angeregt?"),
    ("val_mitarbeit", "Wie war deine Mitarbeit?"),
    ("val_absprachen", "Hast du Absprachen eingehalten?"),
    ("val_selbststaendigkeit", "Wie selbstständig hast du gearbeitet?"),
    ("val_konzentration", "Wie war deine Konzentration?"),
    ("val_fleiss", "Wie war dein Fleiß?"),
    ("val_lernfortschritt", "Wie viel hast du gelernt?"),
    ("val_beherrscht_thema", "Wie gut hast du das Thema verstanden?"),
    ("val_transferdenken", "Konntest du das Wissen auf Neues anwenden?"),
    ("val_basiswissen", "Wie gut war dein Vorwissen?"),
    ("val_vorbereitet", "Wie gut warst du vorbereitet?")
]

@app.route("/", methods=["GET", "POST"])
def rueckmeldung():
    if request.method == "POST":
        vorname = request.form["vorname"].strip().title()
        nachname = request.form["nachname"].strip().title()

        if not vorname or not nachname:
            return "Bitte Vor- und Nachnamen angeben."

        filename = f"{nachname}_{vorname}.csv"
        filepath = os.path.join(os.getcwd(), filename)

        # Daten erfassen
        daten = {
            "Vorname": vorname,
            "Nachname": nachname
        }
        for feld, _ in felder:
            daten[feld] = request.form.get(feld, "")

        # CSV schreiben
        write_header = not os.path.exists(filepath)
        with open(filepath, "a", newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=daten.keys())
            if write_header:
                writer.writeheader()
            writer.writerow(daten)

        return f"Rückmeldung gespeichert als <strong>{filename}</strong>"

    return render_template("formular.html", felder=felder)

if __name__ == "__main__":
    app.run(debug=True)
