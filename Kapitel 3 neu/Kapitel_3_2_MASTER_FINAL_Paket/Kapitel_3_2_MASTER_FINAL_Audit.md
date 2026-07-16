# Kapitel 3.2 MASTER FINAL – Prüfbericht

**Verbindlicher Ausgangsdump:** `frzk_rkb_backup_vor_korrektur_3.2.2.sql`  
**Kontrollreferenz:** `frzk_rkb_nach_repository_update_3.2.2(2).sql`  
**Masterdatei:** `Kapitel_3_2_MASTER_FINAL.sql`  
**Dateigröße:** 600,097 Byte  
**SHA-256:** `d2de8d7d34580ddf5eefcf804fb593c8166ebd58ec8c3281f4d8a5f5aef60663`

## Statische Prüfungen

- PASS – `source_before_exists`
- PASS – `control_after_exists`
- PASS – `contains_12_migrations`
- PASS – `balanced_transactions`
- PASS – `no_author_role_column`
- PASS – `no_invalid_complete_status`
- PASS – `no_invalid_author_synthesis_provenance`
- PASS – `no_invalid_synthesis_usage`
- PASS – `no_invalid_validated_change`
- PASS – `contains_equation_symbol_upserts`
- PASS – `final_counter_82`
- PASS – `final_counter_3275`
- PASS – `final_section_3212`
- PASS – `has_full_audit`

Geprüfte `equation_symbols`-INSERT-Blöcke: **214**; ohne Upsert: **0**.

## Importreihenfolge

1. Arbeitsdatenbank sichern.
2. Den Ausgangsdump `frzk_rkb_backup_vor_korrektur_3.2.2.sql` in eine neue/leere Datenbank `frzk_rkb` importieren.
3. Danach ausschließlich `Kapitel_3_2_MASTER_FINAL.sql` importieren.
4. Die am Ende ausgegebenen Auditblöcke kontrollieren.

## Erwarteter Endstand

- `next_citation_number = 82`
- `next_equation_number = 3.275`
- `last_edited_section = 3.2.12`
- `last_repository_revision = RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5`

## Laufzeitprüfung

Ein echter MariaDB-Import konnte in dieser Umgebung nicht ausgeführt werden. Der strukturelle Test ist vollständig bestanden; das Masterskript enthält zusätzlich einen ausführbaren SQL-Gesamtaudit für den realen Import.
