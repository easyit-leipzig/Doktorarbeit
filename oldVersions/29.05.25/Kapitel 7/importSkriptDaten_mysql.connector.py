import mysql.connector

# Schülerdaten
schueler = {
    "Name": "Schaff, Luise",
    "Klasse": "9 GYM",
    "Probeschüler": 1,
    "Erhält keine Noten": 1,
    "Versetzungsgefährdet": 1,
    "Teilnahmenachweis erforderlich": 1,
    "Protokoll": 1,
    "Extras": 1,
    "Vertraulich": 1,
    "Bewertungen": []  # Bewertungen-Liste kommt gleich
}

# Bewertungsdaten hinzufügen (Beispiel: nur 1 zur Vereinfachung – du kannst alle übernehmen)
schueler["Bewertungen"].append({
    "Fach": "MAT",
    "Datum": "2025-05-23",
    "Lehrkraft": "Städter, Kathleen",
    "Thema": "Geometrie: Vorbereitung LK",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 0,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, vorbereitet, konzentriert, Lernfortschritt erzielt"
})

# Verbindung zur MySQL-Datenbank
conn = mysql.connector.connect(
    host="localhost",
    user="dein_benutzername",
    password="dein_passwort",
    database="deine_datenbank"
)
cursor = conn.cursor()

# Schüler einfügen
insert_schueler = """
INSERT INTO schueler 
(name, klasse, probeschueler, erhaelt_keine_noten, versetzungsgefaehrdet,
 teilnahmenachweis_erforderlich, protokoll, extras, vertraulich)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
"""
cursor.execute(insert_schueler, (
    schueler["Name"],
    schueler["Klasse"],
    schueler["Probeschüler"],
    schueler["Erhält keine Noten"],
    schueler["Versetzungsgefährdet"],
    schueler["Teilnahmenachweis erforderlich"],
    schueler["Protokoll"],
    schueler["Extras"],
    schueler["Vertraulich"]
))

# ID des Schülers abrufen
schueler_id = cursor.lastrowid

# Bewertungen einfügen
insert_bewertung = """
INSERT INTO bewertungen (
    schueler_id, fach, datum, lehrkraft, thema,
    absprachen, mitarbeit, fleissig, selbstaendig,
    vorbereitet, konzentriert, lernfortschritt,
    beherrscht_thema, transferdenken, basiswissen, freitext
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

for b in schueler["Bewertungen"]:
    cursor.execute(insert_bewertung, (
        schueler_id,
        b["Fach"],
        b["Datum"],
        b["Lehrkraft"],
        b["Thema"],
        b["Absprachen"],
        b["Mitarbeit"],
        b["Fleißig"],
        b["Selbstständig"],
        b["Vorbereitet"],
        b["Konzentriert"],
        b["Lernfortschritt"],
        b["Beherrscht Thema"],
        b["Transferdenken"],
        b["Basiswissen"],
        b["Freitext"]
    ))

# Änderungen speichern und Verbindung schließen
conn.commit()
cursor.close()
conn.close()

print("✅ Daten erfolgreich in die Datenbank übertragen.")
