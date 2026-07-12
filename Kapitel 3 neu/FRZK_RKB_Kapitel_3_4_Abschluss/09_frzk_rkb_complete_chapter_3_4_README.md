# FRZK-RKB – vollständiges SQL für Kapitel 3.4

## Grundlage

Das Skript setzt den korrigierten Datenbankstand nach der Neufassung von
Kapitel 3.3 voraus.

## Import in die bestehende Datenbank

```bash
mysql -u root frzk_rkb < 09_frzk_rkb_complete_chapter_3_4_mysql.sql
```

## Vollständiger Neuimport

```bash
mysql -u root < frzk_rkb_aktualisiert_bis_kapitel_3_4.sql
```

## Inhalt

- Abschnittsstruktur `3.4.0` bis `3.4.10`
- 49 Gleichungen `(3.100)` bis `(3.148)`
- 17 Definitionen
- 16 Lemmata
- 8 Sätze
- 7 Korollare
- 31 Beweisdatensätze
- Symbolverzeichnis
- Änderungsprotokoll
- automatische Validierungen

## Nummerierungsstand danach

- Literatur: `[1]` bis `[52]`
- nächste freie Literaturnummer: `[53]`
- Gleichungen: `(3.1)` bis `(3.148)`
- nächste freie Gleichungsnummer: `(3.149)`

## Wissenschaftlicher Status

Kapitel 3.4 wird auf `review` gesetzt.

Die Beweisdatensätze bleiben bewusst auf `draft`, weil mehrere Aussagen vor
der endgültigen Abgabe noch einer streng formalen Prüfung ihrer Voraussetzungen
bedürfen. Das SQL behauptet daher nicht, dass sämtliche Beweise bereits
mathematisch verifiziert sind.
