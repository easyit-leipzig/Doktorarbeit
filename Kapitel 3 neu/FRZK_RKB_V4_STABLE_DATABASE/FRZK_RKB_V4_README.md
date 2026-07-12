# FRZK-RKB V4 – stabile Datenbankbasis

## Zwei Wege

### A. Sauberer Neuaufbau

Verwendet eine leere Datenbank und legt das vollständige Schema neu an:

```bash
mysql -u root < FRZK_RKB_V4_STABLE_SCHEMA_MYSQL.sql
```

Danach werden die Kapitelimporte in dieser Reihenfolge ausgeführt:

```bash
mysql -u root frzk_rkb < 06_frzk_rkb_complete_chapter_3_2_mysql.sql
mysql -u root frzk_rkb < 07_frzk_rkb_complete_chapter_3_3_mysql.sql
```

Vorher muss der vollständige Startbestand aus 3.1 importiert oder in einen neuen
V4-Seed überführt werden.

### B. Bestehende V3-Datenbank migrieren

```bash
mysql -u root frzk_rkb < FRZK_RKB_V3_TO_V4_MIGRATION_MYSQL.sql
```

Danach kann das korrigierte 3.3-Abschlussskript ausgeführt werden.

## Behebung des konkreten Fehlers

Die Tabelle `equations` enthält in V4 verbindlich:

```sql
created_revision_id BIGINT UNSIGNED NULL
```

mit Fremdschlüssel auf:

```sql
repository_revisions(revision_id)
```

Damit ist der Fehler `#1054 - Unbekanntes Tabellenfeld 'created_revision_id'`
behoben.

## V4-Grundsatz

Ab V4 erfolgen neue Kapitel nur noch über Daten-INSERTs und UPDATEs.
Schemaänderungen werden nur noch bei tatsächlich neuen Objektarten vorgenommen.
Die Tabellen für Kapitel 3.4 sind bereits vorhanden:

- `theorems`
- `lemmas`
- `corollaries`
- `proofs`
- `assumptions`
- `axioms`
- `propositions`
- `equations`
- `equation_dependencies`
- `symbols`
- `object_source_links`
- `repository_validation_results`

Kapitel 3.4 kann daher ohne weitere strukturelle Änderung begonnen werden.
