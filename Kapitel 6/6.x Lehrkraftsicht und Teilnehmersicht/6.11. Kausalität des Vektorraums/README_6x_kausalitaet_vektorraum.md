# 6.x Kausalität des FRZK-Vektorraums – Skriptpaket

Dieses Paket enthält vier Skripte:

1. `export_6x_kausalitaet_vektorraum.py`  
   Exportiert Daten aus `match_tn_daten_analyze_lehrkraft` als JSON.

2. `analyse_6x_kausalitaet_vektorraum.py`  
   Liest die JSON-Datei und erzeugt CSV-Tabellen, PNG-Grafiken und Markdown-Berichte.

3. `export_6x_kausalitaet_vektorraum.php`  
   PHP-Variante des Exports.

4. `analyse_6x_kausalitaet_vektorraum.php`  
   PHP-Variante der Analyse. Erzeugt CSV, SVG-Grafiken und Markdown-Berichte.

## Python-Nutzung

```powershell
py .\export_6x_kausalitaet_vektorraum.py --out=6x_kausalitaet_vektorraum_export.json
py .\analyse_6x_kausalitaet_vektorraum.py --input=6x_kausalitaet_vektorraum_export.json --outdir=6x_kausalitaet_vektorraum_output --permutations=1000
```

Benötigte Pakete:

```powershell
py -m pip install mysql-connector-python matplotlib
```

## PHP-Nutzung

```powershell
php .\export_6x_kausalitaet_vektorraum.php --out=6x_kausalitaet_vektorraum_export.json
php .\analyse_6x_kausalitaet_vektorraum.php --input=6x_kausalitaet_vektorraum_export.json --outdir=6x_kausalitaet_vektorraum_output --permutations=1000
```

## Inhaltliche Prüfungen

Die Analyse führt drei Hauptprüfungen aus:

- Zeitversetzte Resonanzvalidierung `L(t) -> T(t+n)` für `n = 0..3`
- Permutations-/Nullmodellanalyse echte Zuordnung gegen zufällig vertauschte Teilnehmerzustände
- Vorhersagevergleich FRZK-Vektoren gegen klassische Ratings und Baseline

## Wichtiger methodischer Hinweis

Der Export nutzt `match_tn_daten_analyze_lehrkraft` als zentrale Kopplungsview. Falls später ein direkter Teilnehmer-7D-Vektor aus `frzk_semantische_dichte_teilnehmer_7d` in denselben Export integriert werden soll, muss in den Analyse-Skripten nur die Funktion `participant_target_vector(...)` auf den direkten Teilnehmervektor umgestellt werden. Die übrige Permutations-, Lag- und Vorhersagelogik bleibt verwendbar.
