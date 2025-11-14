
import pandas as pd

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
    "Bewertungen": []  # Hier werden die Bewertungen als Liste hinzugefügt
}

# Bewertungsdaten
bewertungen = []

# Seite 1
bewertungen.append({
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

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-05-19",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "VorbLK",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 0,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, Basiswissen vorhanden"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-05-12",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "VorbLK",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 0,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-05-02",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Geometrie: SdP rechnen, sachaufgaben hintendr",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 0,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-04-14",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Brückenaufgabe",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-04-11",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Dreieck: SdP",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-04-07",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "SdP Vorb LK",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 0,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-04-04",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Analytische Geometrie: SdP komplexe Aufg.",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-03-31",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "SdP",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 1,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, Basiswissen vorhanden, fähig zu Transferdenken"
})

# Seite 2
bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-03-28",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "SdP",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 0,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-03-14",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Exponentialgleichung/-funktion: ungerade/gerade Normalfomrm",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-03-03",
    "Lehrkraft": "Wolter, Kathrin",
    "Thema": "Magnetismus komplexe Aufg, Fehlerkorrektur / Überschlag / Zehnerpotenzen / Lorentzkraft",
    "Absprachen": 1,
    "Mitarbeit": 0,
    "Fleißig": 0,
    "Selbstständig": 1,
    "Vorbereitet": 0,
    "Konzentriert": 0,
    "Lernfortschritt": 0,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, arbeitet selbstständig, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-03-07",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "ZusFass x^n / EinheitenR / 10erP Rech",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-02-24",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Elektrische Energie: Grdl. Elektrik",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 1,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, Basiswissen vorhanden, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-02-17",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Grdl. Stromkreis / Widerstandsberechnung",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 1,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, Basiswissen vorhanden, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-02-12",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Exponentialgleichung/-funktion: x hoch ungerade, Exp. gerade",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-02-10",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Grdl.Elektr. / Induktion",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 0,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, Basiswissen vorhanden"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-02-07",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Korr. LK",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

# Seite 3
bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-02-03",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Elektrizitätslehre",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-01-31",
    "Lehrkraft": "Thiele, Dipl.-Ing. Olaf",
    "Thema": "Korrektur LK / Wiederholung Kreisberechnung",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 1,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt, beherrscht Thema, fähig zu Transferdenken"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-01-23",
    "Lehrkraft": "Trigkidis, Dimitrios",
    "Thema": "Elektrische Energie: Bauelemente Elektronik",
    "Absprachen": 1,
    "Mitarbeit": 0,
    "Fleißig": 0,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 0,
    "Basiswissen": 0,
    "Freitext": "Absprachen einhaltend, arbeitet selbstständig, konzentriert, vorbereitet, Lernfortschritt erzielt"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-01-13",
    "Lehrkraft": "Nößler, Brian",
    "Thema": "Elektrische Energie: Induktion",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 1,
    "Konzentriert": 1,
    "Lernfortschritt": 0,
    "Beherrscht Thema": 1,
    "Transferdenken": 0,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, konzentriert, arbeitet selbstständig, vorbereitet, beherrscht Thema, Basiswissen vorhanden"
})

bewertungen.append({
    "Fach": "MAT",
    "Datum": "2025-01-10",
    "Lehrkraft": "Nößler, Brian",
    "Thema": "Quadratische Funktion/Gleichung: Funktionsgleichungen herleiten",
    "Absprachen": 1,
    "Mitarbeit": 0,
    "Fleißig": 1,
    "Selbstständig": 1,
    "Vorbereitet": 0,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 1,
    "Transferdenken": 0,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, fleißig / bemüht, arbeitet selbstständig, konzentriert, Lernfortschritt erzielt, Basiswissen vorhanden, beherrscht Thema"
})

bewertungen.append({
    "Fach": "PHY",
    "Datum": "2025-01-06",
    "Lehrkraft": "Martin, Alexander",
    "Thema": "Magnetisches Feld: Wiederholung Magnetismus mit Übungsaufgaben, nächsten Dienstag Klassenarbeit",
    "Absprachen": 1,
    "Mitarbeit": 1,
    "Fleißig": 1,
    "Selbstständig": 0,
    "Vorbereitet": 0,
    "Konzentriert": 1,
    "Lernfortschritt": 1,
    "Beherrscht Thema": 0,
    "Transferdenken": 0,
    "Basiswissen": 1,
    "Freitext": "Absprachen einhaltend, beteiligt sich / gute Mitarbeit, fleißig / bemüht, konzentriert, benötigt Aufforderung, Lernfortschritt erzielt, Basiswissen vorhanden"
})

# Hinzufügen der Bewertungen zum Schüler
schueler["Bewertungen"] = bewertungen

# DataFrame erstellen
df = pd.DataFrame([schueler])

# Ausgabe des DataFrames
print(df.to_string(index=False))

