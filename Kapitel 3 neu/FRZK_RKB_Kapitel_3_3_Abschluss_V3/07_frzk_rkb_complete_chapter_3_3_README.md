# FRZK-RKB – Abschlussskript Kapitel 3.3

## Voraussetzung

In dieser Reihenfolge importieren:

```bash
mysql -u root < FRZK_RKB_V3_COMPLETE_MYSQL.sql
mysql -u root frzk_rkb < 06_frzk_rkb_complete_chapter_3_2_mysql.sql
mysql -u root frzk_rkb < 07_frzk_rkb_complete_chapter_3_3_mysql.sql
```

## Enthalten

- vollständige Abschnittsstruktur `3.3.0` bis `3.3.6`
- Axiome `A1` bis `A5`
- Verknüpfung jedes Axioms mit einer Anforderung aus `3.2.13`
- Gleichungen `(3.87)` bis `(3.115)`
- fünf logische Propositionen
- neue Tabellen `propositions` und `proposition_dependencies`
- propositionenbezogene Registeransicht
- Symbolverzeichnis für Kapitel 3.3
- Wiederverwendung der bestehenden Literatur
- Änderungsprotokoll und automatische Validierungen

## Nummerierungsstand nach dem Import

- nächste freie Literaturnummer: `[53]`
- nächste freie Gleichungsnummer: `(3.116)`

## Wissenschaftlicher Status

Kapitel 3.3 wird auf `review` gesetzt.

Die Axiome erhalten ebenfalls den Status `review`, nicht `accepted`.
Die endgültige Annahme sollte erst nach der mathematischen Konstruktion,
Konsistenzprüfung und gegebenenfalls Unabhängigkeitsprüfung in Kapitel 3.4 erfolgen.

Die früher als Sätze, Lemmata und Korollare bezeichneten Aussagen aus 3.3.6
werden entsprechend der überarbeiteten Kapitelstruktur als Propositionen geführt.
