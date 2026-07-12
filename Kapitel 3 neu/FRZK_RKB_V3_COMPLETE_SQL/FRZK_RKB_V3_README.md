# FRZK-RKB V3.0

Vollständiges MySQL-Installationsskript für das Dissertations-Repository.

## Enthalten

- Datenbankschema und Startbestand aus Kapitel 3.1
- Literatur, Annotationen, Themen und Quellenverwendungen
- Gleichungen, Gleichungssymbole und Gleichungsabhängigkeiten
- Definitionen, Sätze, Lemmata und Korollare
- Beweise
- Annahmen und Axiome
- Abbildungen und Dissertationstabellen
- globales Symbol- und Abkürzungsverzeichnis
- Revisionen und Änderungsprotokolle
- vorbereitete Anforderungen A-3.2-1 bis A-3.2-5
- vorläufige Axiome A1 bis A5 für Kapitel 3.3

## Import

```bash
mysql -u root < FRZK_RKB_V3_COMPLETE_MYSQL.sql
```

Das Skript legt die Datenbank `frzk_rkb` vollständig neu an.

## Hinweis

Die Axiome A1 bis A5 sind als `draft` gespeichert. Sie sind vorbereitete Repository-Datensätze und noch keine endgültig angenommene Fassung von Kapitel 3.3.
