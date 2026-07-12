# Korrigiertes vollständiges Update-Skript für Kapitel 3.4

## Behobener Fehler

MySQL meldete:

```text
#1052 - Feld 'title' in field list ist nicht eindeutig
```

Ursache war eine nicht qualifizierte Spaltenangabe in einer Abfrage mit `JOIN`:

```sql
SELECT definition_number,title,validation_status
```

Da sowohl `definitions` als auch `dissertation_sections` eine Spalte `title`
besitzen, muss der Tabellenalias angegeben werden.

## Verbindliche SQL-Konvention

In allen Kontrollabfragen mit mehreren Tabellen werden Spalten vollständig
qualifiziert, beispielsweise:

```sql
d.definition_number
d.title
d.validation_status
ds.section_code
```

Diese Korrektur wurde für Definitionen, Sätze, Lemmata, Korollare, Beweise,
Abschnitte, Gleichungen und Validierungsausgaben umgesetzt.

## Import in die bestehende Datenbank

```bash
mysql -u root frzk_rkb < 09_frzk_rkb_complete_chapter_3_4_mysql_korrigiert.sql
```

## Vollständiger Neuimport

```bash
mysql -u root < frzk_rkb_aktualisiert_bis_kapitel_3_4_korrigiert.sql
```

## Nummerierungsstand

- Literatur: `[1]` bis `[52]`
- nächste freie Literaturnummer: `[53]`
- Gleichungen: `(3.1)` bis `(3.148)`
- nächste freie Gleichungsnummer: `(3.149)`
