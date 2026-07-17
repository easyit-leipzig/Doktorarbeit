/* ============================================================================
   FRZK-Repository – vollständiger Datenreset vor Neufassung von Kapitel 3.1
   Grundlage: frzk_rkb_ende_3.3(1).sql
   Zweck:
   - sämtliche Repository-Daten löschen
   - alle AUTO_INCREMENT-Zähler durch TRUNCATE auf Startwert 1 zurücksetzen
   - Tabellenstruktur, Indizes, Constraints und Views unverändert erhalten
   - sauberen Ausgangspunkt für Kapitel 3.1 schaffen

   WICHTIG:
   Dieses Skript ist destruktiv. Vor der Ausführung muss eine Sicherung des
   bisherigen Datenbestands vorhanden sein.
   ============================================================================ */

USE `frzk_rkb`;
SET NAMES utf8mb4;

SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS;
SET @OLD_SQL_NOTES = @@SQL_NOTES;

SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;
SET SQL_NOTES = 0;

TRUNCATE TABLE `acronyms`;
TRUNCATE TABLE `annotations`;
TRUNCATE TABLE `assumptions`;
TRUNCATE TABLE `authors`;
TRUNCATE TABLE `axioms`;
TRUNCATE TABLE `axiom_dependencies`;
TRUNCATE TABLE `citation_corrections`;
TRUNCATE TABLE `corollaries`;
TRUNCATE TABLE `definitions`;
TRUNCATE TABLE `dissertation_sections`;
TRUNCATE TABLE `dissertation_tables`;
TRUNCATE TABLE `documents`;
TRUNCATE TABLE `equations`;
TRUNCATE TABLE `equation_dependencies`;
TRUNCATE TABLE `equation_symbols`;
TRUNCATE TABLE `figures`;
TRUNCATE TABLE `lemmas`;
TRUNCATE TABLE `object_dependencies`;
TRUNCATE TABLE `object_source_links`;
TRUNCATE TABLE `pending_sources`;
TRUNCATE TABLE `proofs`;
TRUNCATE TABLE `propositions`;
TRUNCATE TABLE `proposition_dependencies`;
TRUNCATE TABLE `repository_counters`;
TRUNCATE TABLE `repository_revisions`;
TRUNCATE TABLE `repository_validation_results`;
TRUNCATE TABLE `section_change_log`;
TRUNCATE TABLE `sources`;
TRUNCATE TABLE `source_authors`;
TRUNCATE TABLE `source_relations`;
TRUNCATE TABLE `source_topics`;
TRUNCATE TABLE `source_usage`;
TRUNCATE TABLE `symbols`;
TRUNCATE TABLE `theorems`;
TRUNCATE TABLE `topics`;

SET SQL_NOTES = @OLD_SQL_NOTES;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

/* Kontrollabfragen: Jede Tabelle muss 0 Zeilen enthalten.
   Nach dem ersten Abschnittsskript müssen die neu verwendeten
   AUTO_INCREMENT-Schlüssel mit 1 beginnen. */

SELECT 'acronyms' AS table_name, COUNT(*) AS row_count FROM `acronyms`;
SELECT 'annotations' AS table_name, COUNT(*) AS row_count FROM `annotations`;
SELECT 'assumptions' AS table_name, COUNT(*) AS row_count FROM `assumptions`;
SELECT 'authors' AS table_name, COUNT(*) AS row_count FROM `authors`;
SELECT 'axioms' AS table_name, COUNT(*) AS row_count FROM `axioms`;
SELECT 'axiom_dependencies' AS table_name, COUNT(*) AS row_count FROM `axiom_dependencies`;
SELECT 'citation_corrections' AS table_name, COUNT(*) AS row_count FROM `citation_corrections`;
SELECT 'corollaries' AS table_name, COUNT(*) AS row_count FROM `corollaries`;
SELECT 'definitions' AS table_name, COUNT(*) AS row_count FROM `definitions`;
SELECT 'dissertation_sections' AS table_name, COUNT(*) AS row_count FROM `dissertation_sections`;
SELECT 'dissertation_tables' AS table_name, COUNT(*) AS row_count FROM `dissertation_tables`;
SELECT 'documents' AS table_name, COUNT(*) AS row_count FROM `documents`;
SELECT 'equations' AS table_name, COUNT(*) AS row_count FROM `equations`;
SELECT 'equation_dependencies' AS table_name, COUNT(*) AS row_count FROM `equation_dependencies`;
SELECT 'equation_symbols' AS table_name, COUNT(*) AS row_count FROM `equation_symbols`;
SELECT 'figures' AS table_name, COUNT(*) AS row_count FROM `figures`;
SELECT 'lemmas' AS table_name, COUNT(*) AS row_count FROM `lemmas`;
SELECT 'object_dependencies' AS table_name, COUNT(*) AS row_count FROM `object_dependencies`;
SELECT 'object_source_links' AS table_name, COUNT(*) AS row_count FROM `object_source_links`;
SELECT 'pending_sources' AS table_name, COUNT(*) AS row_count FROM `pending_sources`;
SELECT 'proofs' AS table_name, COUNT(*) AS row_count FROM `proofs`;
SELECT 'propositions' AS table_name, COUNT(*) AS row_count FROM `propositions`;
SELECT 'proposition_dependencies' AS table_name, COUNT(*) AS row_count FROM `proposition_dependencies`;
SELECT 'repository_counters' AS table_name, COUNT(*) AS row_count FROM `repository_counters`;
SELECT 'repository_revisions' AS table_name, COUNT(*) AS row_count FROM `repository_revisions`;
SELECT 'repository_validation_results' AS table_name, COUNT(*) AS row_count FROM `repository_validation_results`;
SELECT 'section_change_log' AS table_name, COUNT(*) AS row_count FROM `section_change_log`;
SELECT 'sources' AS table_name, COUNT(*) AS row_count FROM `sources`;
SELECT 'source_authors' AS table_name, COUNT(*) AS row_count FROM `source_authors`;
SELECT 'source_relations' AS table_name, COUNT(*) AS row_count FROM `source_relations`;
SELECT 'source_topics' AS table_name, COUNT(*) AS row_count FROM `source_topics`;
SELECT 'source_usage' AS table_name, COUNT(*) AS row_count FROM `source_usage`;
SELECT 'symbols' AS table_name, COUNT(*) AS row_count FROM `symbols`;
SELECT 'theorems' AS table_name, COUNT(*) AS row_count FROM `theorems`;
SELECT 'topics' AS table_name, COUNT(*) AS row_count FROM `topics`;

/* AUTO_INCREMENT-Prüfung nach dem Reset.
   Bei vollständig geleerten Tabellen weist AUTO_INCREMENT in MariaDB/MySQL
   je nach Version entweder 1 oder NULL aus; der nächste INSERT erhält 1. */
SELECT TABLE_NAME, AUTO_INCREMENT
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('acronyms', 'annotations', 'assumptions', 'authors', 'axioms', 'axiom_dependencies', 'citation_corrections', 'corollaries', 'definitions', 'dissertation_sections', 'dissertation_tables', 'documents', 'equations', 'equation_dependencies', 'equation_symbols', 'figures', 'lemmas', 'object_dependencies', 'object_source_links', 'pending_sources', 'proofs', 'propositions', 'proposition_dependencies', 'repository_counters', 'repository_revisions', 'repository_validation_results', 'section_change_log', 'sources', 'source_authors', 'source_relations', 'source_topics', 'source_usage', 'symbols', 'theorems', 'topics')
ORDER BY TABLE_NAME;
