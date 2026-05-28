# Auswertungspunkt 2 – Zeitversetzte Resonanzvalidierung

## Reihenfolge

### Python
```bash
pip install mysql-connector-python matplotlib
python 01_export_zeitversetzte_resonanz.py
python 02_analyse_zeitversetzte_resonanz.py
```

### PHP
```bash
php 01_export_zeitversetzte_resonanz.php
php 02_analyse_zeitversetzte_resonanz_gd.php
```

## Datenlogik

- Lehrkraftzustände: `analyze_lehrkraftdaten`
- Teilnehmerzustände: `frzk_semantische_dichte_teilnehmer_7d`
- Vergleich: gleicher `gruppe_id` und gleicher `teilnehmer_id`
- Verzögerung: n-te spätere reale Sitzung, nicht Kalendertag
- Lags: `n = 1, 2, 3`
- Metriken: Kosinusähnlichkeit, euklidische Distanz, Pearson-Korrelation
- JSON enthält: `alle_lehrkraefte`, `lehrkraft_1`, `ohne_lehrkraft_1`
