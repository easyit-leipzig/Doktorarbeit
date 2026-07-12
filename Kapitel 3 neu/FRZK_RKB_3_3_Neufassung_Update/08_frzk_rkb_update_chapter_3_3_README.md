# Anpassung der FRZK-RKB an die Neufassung von Kapitel 3.3

## Nummerierungsstand

Nach dem Update gilt:

- Literaturquellen: weiterhin `[1]` bis `[52]`
- nächste freie Literaturnummer: `[53]`
- Gleichungen in Kapitel 3.3: `(3.87)` bis `(3.99)`
- nächste freie Gleichungsnummer: `(3.100)`

Die alte Gleichungsgruppe `(3.100)` bis `(3.115)` wird entfernt.

## Inhalt des Updates

- neue Gliederung `3.3.0` bis `3.3.9`
- neuer Kapiteltitel
- fünf vollständig überarbeitete Axiome
- fünf vollständig überarbeitete Propositionen
- 13 neue Gleichungsdatensätze
- aktualisiertes Symbolverzeichnis
- neue Literaturverwendungen ohne neue Quellen
- aktualisierte Repository-Zähler
- Validierungsabfragen und Änderungsprotokoll

## Import in die bereits bestehende Datenbank

```bash
mysql -u root frzk_rkb < 08_frzk_rkb_update_chapter_3_3_new_numbering.sql
```

## Vollständiger Neuimport

Die Datei `frzk_rkb_aktualisiert_nach_3_3_neufassung.sql` enthält zuerst den
vollständigen bisherigen Dump und anschließend automatisch das Update.

```bash
mysql -u root < frzk_rkb_aktualisiert_nach_3_3_neufassung.sql
```

## Wissenschaftlicher Status

Es werden keine neuen Literaturquellen eingeführt. Die vorhandenen Nummern
`[7]`, `[8]`, `[18]` und `[24]` werden für die axiomatische Einordnung
wiederverwendet.

Kapitel 3.3 bleibt auf `review`, bis die endgültige sprachliche und
wissenschaftliche Endprüfung abgeschlossen ist.
