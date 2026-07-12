# FRZK-RKB – Abschlussskript Kapitel 3.2

## Voraussetzung

Zuerst muss `FRZK_RKB_V3_COMPLETE_MYSQL.sql` importiert worden sein.

## Import

```bash
mysql -u root frzk_rkb < 06_frzk_rkb_complete_chapter_3_2_mysql.sql
```

## Inhalt

- 30 neue, deduplizierte Quellen `[23]` bis `[52]`
- Wiederverwendung von Haken `[12]`, Holland `[14]` und Barabási `[15]`
- 30 vollständige Quellenannotationenen
- Quellenverwendungen für alle Abschnitte `3.2.1` bis `3.2.13`
- 84 Gleichungen `(3.3)` bis `(3.86)`
- 25 Definitionen
- globales Symbolverzeichnis
- 5 aus der Forschungslücke abgeleitete Anforderungen
- 8 geplante Abbildungen
- 5 geplante Tabellen
- Abkürzungen
- Änderungsprotokoll
- automatische Validierungen
- Repository-Zähler

## Deduplizierte Literaturkorrekturen

Die Rohfassung von 3.2 enthielt drei erneut nummerierte Quellen:

- Barabási: Rohfassung `[49]` → korrekt `[15]`
- Haken: Rohfassung `[54]` → korrekt `[12]`
- Holland: Rohfassung `[55]` → korrekt `[14]`

Dadurch verschieben sich:

- Burago et al.: `[50]` → `[49]`
- Manning et al.: `[51]` → `[50]`
- Camazine et al.: `[52]` → `[51]`
- Mitchell: `[53]` → `[52]`

## Nächste freie Nummern

- Literatur: `[53]`
- Gleichung: `(3.87)`

## Wichtiger Status

Kapitel 3.2 wird im Repository auf `review` gesetzt, nicht auf `final`.
Die bibliographischen Angaben bleiben bis zur Einzelprüfung auf `needs_review`.
