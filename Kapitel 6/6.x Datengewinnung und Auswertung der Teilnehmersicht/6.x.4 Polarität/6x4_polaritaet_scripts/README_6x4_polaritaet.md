# 6.x.4 Polarität – Skriptpaket ohne Lehrkraftunterscheidung

## Reihenfolge

1. `01_export_6x4_polaritaet_tn.py` **oder** `01_export_6x4_polaritaet_tn.php` ausführen.  
   Ergebnis: `6x4_polaritaet_tn.json`

2. `02_analyse_6x4_polaritaet_tn.py` ausführen.  
   Ergebnis: Markdown-Auswertung, CSV und PNG-Grafiken in `output_6x4_polaritaet/`

3. Optional zusätzlich `02_analyse_6x4_polaritaet_tn.php` ausführen.  
   Ergebnis: Markdown- und CSV-Auswertung in `output_6x4_polaritaet_php/`

## Inhaltliche Fragestellungen

- Welche Gruppen zeigen positive Entwicklung?
- Wo entstehen negative Zustandsräume?
- Wie verteilen sich positive, negative und neutrale Zustände je Gruppe?
- Wie verändert sich der mittlere Polaritätsindex im Zeitverlauf?

## Datenquelle

`frzk_semantische_dichte_teilnehmer_7d`

Die Skripte nutzen keine Lehrkraftfilter und erzeugen Auswertungen ausschließlich auf Teilnehmer- und Gruppenebene.
