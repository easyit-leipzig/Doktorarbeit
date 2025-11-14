from flask import Flask, render_template, request, redirect
import csv
import os
from datetime import datetime

app = Flask(__name__)

# Bewertungsfelder mit lesbarer Bezeichnung
felder = [
    ("val_mitarbeit", "Mitarbeit"),
    ("val_absprachen", "Absprachen einhalten"),
    ("val_selbststaendigkeit", "Selbstständigkeit"),
    ("val_konzentration", "Konzentration"),
    ("val_fleiss", "Fleiß"),
    ("val_lernfortschritt", "Lernfortschritt"),
    ("val_beherrscht_thema", "Beherrscht Thema"),
    ("val_transferdenken", "Transferdenken"),
    ("val_basiswissen", "Basiswissen"),
    ("val_vorbereitet", "Vorbereitet"),
    ("val_themenauswahl", "Themenauswahl"),
    ("val_materialien", "Materialien"),
    ("val_methodenvielfalt", "Methodenvielfalt"),
    ("val_individualisierung", "Individualisierung"),
    ("val_aufforderung", "Aufforderung zum Denken")
]

@app.route("/", methods=["GET", "POST"])
def formular():
    if request.method == "POST":
        # Namen der Teilnehmer:in und Lehrkraft
        tn_vorname = request.form.get("tn_vorname", "").strip()
        tn_nachname = request.form.get("tn_nachname", "").strip()
        lk_vorname = request.form.get("lk_vorname", "").strip()
        lk_nachname = request.form.get("lk_nachname", "").strip()

        # Validierung
        if not tn_vorname or not tn_nachname or not lk_nachname:
            return "Vor- und Nachname von Teilnehmer:in und Nachname der Lehrkraft erforderlich!", 400

        # Werte validieren
        daten = {}
        for feld, _ in felder:
            try:
                wert = int(request.form.get(feld))
                if not 1 <= wert <= 6:
                    raise ValueError()
                daten[feld] = wert
            except:
                return f"Ungültiger Wert für {feld}. Bitte Werte zwischen 1 und 6 eingeben.", 400

        # Dateiname nach Muster: [LehrerNachname]_[TeilnehmerNachname]_[TeilnehmerVorname].csv
        dateiname = f"{lk_nachname}_{tn_nachname}_{tn_vorname}.csv"
        dateiname = dateiname.replace(" ", "_")
        pfad = os.path.join(os.getcwd(), dateiname)

        # CSV-Zeile vorbereiten
        header = ["Erfasst am", "TN_Vorname", "TN_Nachname", "LK_Vorname", "LK_Nachname"] + [f[0] for f in felder]
        zeile = [datetime.now().strftime("%Y-%m-%d"), tn_vorname, tn_nachname, lk_vorname, lk_nachname] + [daten[f[0]] for f in felder]

        # Datei schreiben (mit Header, falls neu)
        datei_existiert = os.path.exists(pfad)
        with open(pfad, "a", newline='', encoding="utf-8") as f:
            writer = csv.writer(f)
            if not datei_existiert:
                writer.writerow(header)
            writer.writerow(zeile)

        return redirect("/")  # Nach Eintrag zurück zum Formular

    return render_template("formular_lehrkraft.html", felder=felder)

if __name__ == "__main__":
    app.run(debug=True)
