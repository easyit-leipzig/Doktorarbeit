/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.3

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql

   Abschnitt:
     3.3.3 Axiom A2 – Funktionale Relationierbarkeit

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3
     letzte Literaturquelle:      [86]
     nächste freie Literatur-Nr.: [87]
     letzte Gleichung:            (3.278)
     nächste Gleichungen:         (3.279)–(3.282)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquellen:       keine
     wiederverwendete Quelle:     [84] Saunders Mac Lane
     nächste freie Literatur-Nr.: [87]
     neue Gleichungen:            (3.279), (3.280), (3.281), (3.282)
     nächste freie Gleichung:     (3.283)
     neue Revision:               RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1

   Registrierte Repository-Objekte:
     - repository_revisions
     - dissertation_sections
     - source_usage
     - definitions
     - axioms
     - axiom_dependencies
     - object_source_links
     - equations
     - equation_symbols
     - symbols
     - section_change_log
     - repository_counters
     - vollständige Audit- und Kontrollabfragen

   Wichtige Schemaentscheidungen:
     - axioms.source_assumption_id bleibt NULL.
       Es wird keine nicht vorhandene Annahme konstruiert.
     - object_source_links.usage_type verwendet ausschließlich:
       supporting_source
     - source_usage.usage_type verwendet ausschließlich:
       background
     - section_change_log.change_type verwendet ausschließlich gültige ENUM-Werte.
     - Keine neue Quelle wird angelegt, weil der Abschnitt ausschließlich [84] wiederverwendet.
     - Das Skript ist transaktional, idempotent und phpMyAdmin-kompatibel.
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Parent-Revision laden und zwingend prüfen
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/*
   Kontrollierter Abbruch, falls die Parent-Revision fehlt.
   Die temporäre NOT-NULL-Tabelle benötigt weder DELIMITER noch Stored Procedure.
*/
DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_333`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_333`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_333` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_333`;

/* -------------------------------------------------------------------------------------------------
   2. Abschnittsrevision idempotent anlegen
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

INSERT INTO `repository_revisions`
(
    `revision_code`,
    `revision_date`,
    `scope_type`,
    `scope_reference`,
    `version_label`,
    `summary`,
    `created_by`,
    `parent_revision_id`
)
VALUES
(
    @revision_code,
    NOW(),
    'section',
    '3.3.3',
    'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.3: Axiom A2 – Funktionale Relationierbarkeit. Registriert werden die qualitative Definition des funktionalen Zusammenhangs, das originäre Axiom A2, die Abhängigkeit von Axiom A1, die Wiederverwendung von Quelle [84], die Gleichungen (3.279) bis (3.282), Gleichungssymbole, Abschnittssymbole, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_date`      = VALUES(`revision_date`),
    `scope_type`         = VALUES(`scope_type`),
    `scope_reference`    = VALUES(`scope_reference`),
    `version_label`      = VALUES(`version_label`),
    `summary`            = VALUES(`summary`),
    `created_by`         = VALUES(`created_by`),
    `parent_revision_id` = VALUES(`parent_revision_id`);

SET @revision_id := NULL;

SELECT `revision_id`
INTO @revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   3. Parent-Abschnitt 3.3 laden
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_333`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_333`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_333` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_333`;

/* -------------------------------------------------------------------------------------------------
   4. Abschnitt 3.3.3 aktualisieren
   Im Ausgangsdump existiert 3.3.3 noch mit einer älteren geplanten Bezeichnung.
   Der eindeutige section_code bleibt erhalten; Titel und Ordnungsposition werden aktualisiert.
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `dissertation_sections`
(
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`,
    `notes`
)
VALUES
(
    @section_33_id,
    '3.3.3',
    'Axiom A2 – Funktionale Relationierbarkeit',
    3,
    3.3004,
    'review',
    1,
    'Zweites originäres FRZK-Axiom. Relationierbarkeit wird qualitativ vor dem klassischen mathematischen Relationsbegriff eingeführt. Mengen, kartesische Produkte, geordnete Paare, Richtung, Symmetrie, Transitivität, Kausalität und Zeit werden nicht vorausgesetzt.'
)
ON DUPLICATE KEY UPDATE
    `parent_section_id`        = VALUES(`parent_section_id`),
    `title`                    = VALUES(`title`),
    `chapter_no`               = VALUES(`chapter_no`),
    `section_order`            = VALUES(`section_order`),
    `status`                   = VALUES(`status`),
    `is_original_contribution` = VALUES(`is_original_contribution`),
    `notes`                    = VALUES(`notes`);

SET @section_id := NULL;

SELECT `section_id`
INTO @section_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   5. Bereits vorhandene Quelle [84] auflösen
   Keine neue Literaturquelle wird eingefügt.
   ------------------------------------------------------------------------------------------------- */

SET @source_84_id := NULL;

SELECT `source_id`
INTO @source_84_id
FROM `sources`
WHERE `citation_number` = 84
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_source_84_333`;

CREATE TEMPORARY TABLE `tmp_frzk_source_84_333`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_source_84_333` (`source_id`)
VALUES (@source_84_id);

DROP TEMPORARY TABLE `tmp_frzk_source_84_333`;

/* -------------------------------------------------------------------------------------------------
   6. Quellenverwendung des Abschnitts kontrolliert neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

INSERT INTO `source_usage`
(
    `source_id`,
    `section_id`,
    `usage_type`,
    `claim_summary`,
    `exact_location`,
    `is_first_mention`,
    `citation_checked`,
    `notes`,
    `created_revision_id`
)
VALUES
(
    @source_84_id,
    @section_id,
    'background',
    'Mac Lane wird als Forschungsanschluss für die strukturelle Bedeutung von Beziehungen und strukturerhaltenden Transformationen verwendet. Das FRZK übernimmt keine kategoriale oder algebraische Struktur, sondern verlagert Relationierbarkeit auf eine qualitative axiomatische Ausgangsebene.',
    '3.3.3, Absatz zur strukturellen Bedeutung von Beziehungen',
    0,
    1,
    'Wiederverwendung der bereits in Abschnitt 3.3.1 erstmals zitierten Quelle [84].',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   7. Qualitative Definition des funktionalen Zusammenhangs
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `definitions`
(
    `definition_number`,
    `section_id`,
    `title`,
    `definition_text`,
    `formal_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    'Def. 3.3.3.1',
    @section_id,
    'Funktionaler Zusammenhang',
    'Ein funktionaler Zusammenhang bezeichnet in Kapitel 3.3 eine realisierte Form prinzipieller Relationierbarkeit zwischen mindestens zwei funktional unterscheidbaren Konfigurationen. Er ist noch keine mathematische Relation, keine Teilmenge eines kartesischen Produkts und enthält noch keine Festlegung von Richtung, Symmetrie, Transitivität, Dauer, Kausalität oder Informationsübertragung.',
    NULL,
    NULL,
    'original',
    NULL,
    'Axiom A1 und der primitive Begriff der Relationierbarkeit aus Abschnitt 3.3.1 werden vorausgesetzt.',
    'Qualitative Sprachdefinition zur eindeutigen Abgrenzung von einer später mathematisch rekonstruierten Relation.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `definition_text`     = VALUES(`definition_text`),
    `formal_latex`        = VALUES(`formal_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `assumptions`         = VALUES(`assumptions`),
    `notes`               = VALUES(`notes`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

SET @definition_id := NULL;

SELECT `definition_id`
INTO @definition_id
FROM `definitions`
WHERE `definition_number` COLLATE utf8mb4_unicode_ci
      =
      'Def. 3.3.3.1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   8. Axiom A1 als notwendige Abhängigkeitsgrundlage auflösen
   ------------------------------------------------------------------------------------------------- */

SET @axiom_a1_id := NULL;

SELECT `axiom_id`
INTO @axiom_a1_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_axiom_a1_333`;

CREATE TEMPORARY TABLE `tmp_frzk_axiom_a1_333`
(
    `axiom_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_axiom_a1_333` (`axiom_id`)
VALUES (@axiom_a1_id);

DROP TEMPORARY TABLE `tmp_frzk_axiom_a1_333`;

/* -------------------------------------------------------------------------------------------------
   9. Originäres FRZK-Axiom A2
   source_assumption_id bleibt gemäß tatsächlichem Schema und Datenbestand NULL.
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `axioms`
(
    `axiom_number`,
    `section_id`,
    `title`,
    `axiom_text`,
    `formal_latex`,
    `word_latex`,
    `motivation`,
    `independence_note`,
    `consistency_note`,
    `operationalization_note`,
    `source_assumption_id`,
    `status`,
    `created_revision_id`
)
VALUES
(
    'A2',
    @section_id,
    'Funktionale Relationierbarkeit',
    'Funktional unterscheidbare Zustände können miteinander in einen funktionalen Zusammenhang treten.',
    'A_2:\\quad\\text{Funktional unterscheidbare Zustände sind prinzipiell relationierbar.}',
    'A_2:\\quad\\text{Funktional unterscheidbare Zustände sind prinzipiell relationierbar.}',
    'Axiom A1 erlaubt funktional unterscheidbare Zuständlichkeit, begründet jedoch noch keinen Zusammenhang. Axiom A2 ergänzt die eigenständige Möglichkeit funktionaler Verknüpfung, ohne bereits eine mathematische Relation oder deren Trägerstrukturen vorauszusetzen.',
    'Axiom A2 benötigt die Anwendungsgrundlage von Axiom A1, ist aus Axiom A1 jedoch nicht ableitbar. Die modelltheoretische Prüfung dieser Nichtableitbarkeit erfolgt erst in Abschnitt 3.3.8.',
    'Das Axiom ist mit Axiom A1 vereinbar, weil es die Möglichkeit funktionaler Verknüpfung ergänzt, ohne die Existenz bestimmter mathematischer Relationsformen zu fordern.',
    'In Kapitel 3.4 wird aus Axiom A2 eine funktionale Relationsstruktur rekonstruiert. Eigenschaften wie Richtung, Reflexivität, Symmetrie, Transitivität, Gewichtung oder Dauer werden nicht axiomatisch vorweggenommen.',
    NULL,
    'review',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`              = VALUES(`section_id`),
    `title`                   = VALUES(`title`),
    `axiom_text`              = VALUES(`axiom_text`),
    `formal_latex`            = VALUES(`formal_latex`),
    `word_latex`              = VALUES(`word_latex`),
    `motivation`              = VALUES(`motivation`),
    `independence_note`       = VALUES(`independence_note`),
    `consistency_note`        = VALUES(`consistency_note`),
    `operationalization_note` = VALUES(`operationalization_note`),
    `source_assumption_id`    = VALUES(`source_assumption_id`),
    `status`                  = VALUES(`status`),
    `created_revision_id`     = VALUES(`created_revision_id`);

SET @axiom_a2_id := NULL;

SELECT `axiom_id`
INTO @axiom_a2_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A2' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   10. Axiomabhängigkeit A2 depends_on A1
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a2_id;

INSERT INTO `axiom_dependencies`
(
    `axiom_id`,
    `depends_on_axiom_id`,
    `dependency_type`,
    `note`
)
VALUES
(
    @axiom_a2_id,
    @axiom_a1_id,
    'depends_on',
    'Relationierbarkeit setzt funktional unterscheidbare Zuständlichkeit voraus. Axiom A1 allein impliziert Axiom A2 jedoch nicht.'
)
ON DUPLICATE KEY UPDATE
    `note` = VALUES(`note`);

/* -------------------------------------------------------------------------------------------------
   11. Wissenschaftlicher Kontext: Axiom A2 und Definition mit Quelle [84] verknüpfen
   object_source_links.usage_type verwendet ausschließlich den realen ENUM-Wert supporting_source.
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE `object_type` = 'axiom'
  AND `object_id` = @axiom_a2_id
  AND `source_id` = @source_84_id;

INSERT INTO `object_source_links`
(
    `object_type`,
    `object_id`,
    `source_id`,
    `usage_type`,
    `note`
)
VALUES
(
    'axiom',
    @axiom_a2_id,
    @source_84_id,
    'supporting_source',
    'Mac Lane dient als struktureller Forschungsanschluss für die Bedeutung von Beziehungen. Axiom A2 ist keine Übernahme kategorialer Mathematik, sondern eine originäre qualitative FRZK-Setzung.'
);

DELETE FROM `object_source_links`
WHERE `object_type` = 'definition'
  AND `object_id` = @definition_id
  AND `source_id` = @source_84_id;

INSERT INTO `object_source_links`
(
    `object_type`,
    `object_id`,
    `source_id`,
    `usage_type`,
    `note`
)
VALUES
(
    'definition',
    @definition_id,
    @source_84_id,
    'supporting_source',
    'Die Quelle stützt den strukturellen Kontext. Die qualitative Definition des funktionalen Zusammenhangs ist originäre FRZK-Eigenleistung.'
);

/* -------------------------------------------------------------------------------------------------
   12. Gleichung (3.279): Axiom A2
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,
    `section_id`,
    `title`,
    `equation_latex`,
    `word_latex`,
    `plain_description`,
    `equation_type`,
    `provenance`,
    `source_id`,
    `derivation`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.279',
    @section_id,
    'Axiom A2 – komprimierte axiomatische Schreibweise',
    'A_2:\\quad\\text{Funktional unterscheidbare Zustände sind prinzipiell relationierbar.}',
    'A_2:\\quad\\text{Funktional unterscheidbare Zustände sind prinzipiell relationierbar.}',
    'Komprimierte qualitative Formulierung des zweiten FRZK-Axioms. Sie führt weder Mengen noch kartesische Produkte oder mathematische Relationen ein.',
    'axiom',
    'original',
    NULL,
    'Originäre axiomatische Setzung auf Grundlage der in Axiom A1 eröffneten funktionalen Unterscheidbarkeit.',
    'Axiom A1 sowie die qualitativen Begriffe Zustand, Unterscheidbarkeit und Relationierbarkeit werden vorausgesetzt.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `equation_latex`      = VALUES(`equation_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `plain_description`   = VALUES(`plain_description`),
    `equation_type`       = VALUES(`equation_type`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `derivation`          = VALUES(`derivation`),
    `assumptions`         = VALUES(`assumptions`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   13. Gleichung (3.280): A2 setzt A1 voraus
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,
    `section_id`,
    `title`,
    `equation_latex`,
    `word_latex`,
    `plain_description`,
    `equation_type`,
    `provenance`,
    `source_id`,
    `derivation`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.280',
    @section_id,
    'Qualitative Abhängigkeit von Axiom A2 von Axiom A1',
    'A_2\\;\\Longrightarrow\\;A_1',
    'A_2\\Longrightarrow A_1',
    'Qualitative axiomatische Abhängigkeit: Relationierbarkeit benötigt funktional unterscheidbare Zuständlichkeit.',
    'schema',
    'original',
    NULL,
    'Axiom A2 kann nur auf funktional unterscheidbare Zustände angewendet werden.',
    'Die Pfeilnotation dokumentiert eine axiomatische Voraussetzung und noch keinen vollständig formalisierten Beweis.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `equation_latex`      = VALUES(`equation_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `plain_description`   = VALUES(`plain_description`),
    `equation_type`       = VALUES(`equation_type`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `derivation`          = VALUES(`derivation`),
    `assumptions`         = VALUES(`assumptions`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   14. Gleichung (3.281): A1 impliziert A2 nicht
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,
    `section_id`,
    `title`,
    `equation_latex`,
    `word_latex`,
    `plain_description`,
    `equation_type`,
    `provenance`,
    `source_id`,
    `derivation`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.281',
    @section_id,
    'Qualitative Nichtableitbarkeit von Axiom A2 aus Axiom A1',
    'A_1\\;\\not\\Longrightarrow\\;A_2',
    'A_1\\not\\Longrightarrow A_2',
    'Qualitative Aussage, dass funktionale Unterscheidbarkeit allein noch keine Relationierbarkeit begründet.',
    'schema',
    'original',
    NULL,
    'Ein begriffliches Modell mit unterscheidbaren, aber vollständig isolierten Konfigurationen zeigt die eigenständige Rolle von Axiom A2.',
    'Die Aussage ist noch kein vollständiger modelltheoretischer Unabhängigkeitsbeweis.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `equation_latex`      = VALUES(`equation_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `plain_description`   = VALUES(`plain_description`),
    `equation_type`       = VALUES(`equation_type`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `derivation`          = VALUES(`derivation`),
    `assumptions`         = VALUES(`assumptions`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   15. Gleichung (3.282): gemeinsame qualitative Reichweite von A1 und A2
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,
    `section_id`,
    `title`,
    `equation_latex`,
    `word_latex`,
    `plain_description`,
    `equation_type`,
    `provenance`,
    `source_id`,
    `derivation`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.282',
    @section_id,
    'Gemeinsame qualitative Reichweite der Axiome A1 und A2',
    'A_1\\land A_2\\;\\Longrightarrow\\;\\text{funktional unterscheidbare und relationierbare Zuständlichkeit}',
    'A_1\\land A_2\\Longrightarrow\\text{funktional unterscheidbare und relationierbare Zuständlichkeit}',
    'Qualitative Zusammenfassung: Axiom A1 ermöglicht funktionale Unterscheidbarkeit, Axiom A2 ergänzt die Möglichkeit funktionaler Zusammenhänge.',
    'schema',
    'original',
    NULL,
    'Zusammenführung der qualitativen Reichweite der ersten beiden FRZK-Axiome.',
    'Es wird noch keine mathematische Trägermenge oder Relationsstruktur behauptet.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `equation_latex`      = VALUES(`equation_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `plain_description`   = VALUES(`plain_description`),
    `equation_type`       = VALUES(`equation_type`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `derivation`          = VALUES(`derivation`),
    `assumptions`         = VALUES(`assumptions`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* Gleichungs-IDs laden */

SET @equation_3279_id := NULL;
SET @equation_3280_id := NULL;
SET @equation_3281_id := NULL;
SET @equation_3282_id := NULL;

SELECT `equation_id`
INTO @equation_3279_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.279' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `equation_id`
INTO @equation_3280_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.280' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `equation_id`
INTO @equation_3281_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.281' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `equation_id`
INTO @equation_3282_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.282' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   16. Gleichungssymbole kontrolliert neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN
(
    @equation_3279_id,
    @equation_3280_id,
    @equation_3281_id,
    @equation_3282_id
);

/* (3.279) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3279_id, 'A_2', 'Axiom A2', 'Bezeichnung des zweiten FRZK-Axioms der funktionalen Relationierbarkeit.', NULL, 'qualitative FRZK-Axiomatik', 1)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`), `definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`), `symbol_order`=VALUES(`symbol_order`);

/* (3.280) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3280_id, 'A_2', 'Axiom A2', 'Bezeichnung des Axioms der funktionalen Relationierbarkeit.', NULL, 'qualitative FRZK-Axiomatik', 1),
(@equation_3280_id, '\\Longrightarrow', 'qualitativer Folgerungspfeil', 'Kennzeichnet eine qualitative axiomatische Voraussetzung.', NULL, 'qualitative axiomatische Abhängigkeit', 2),
(@equation_3280_id, 'A_1', 'Axiom A1', 'Bezeichnung des Axioms der Existenz funktionaler Zustände.', NULL, 'qualitative FRZK-Axiomatik', 3)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`), `definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`), `symbol_order`=VALUES(`symbol_order`);

/* (3.281) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3281_id, 'A_1', 'Axiom A1', 'Bezeichnung des Axioms der Existenz funktionaler Zustände.', NULL, 'qualitative FRZK-Axiomatik', 1),
(@equation_3281_id, '\\not\\Longrightarrow', 'qualitativer Nichtableitungspfeil', 'Kennzeichnet die behauptete qualitative Nichtableitbarkeit von A2 aus A1.', NULL, 'qualitative axiomatische Nichtableitbarkeit', 2),
(@equation_3281_id, 'A_2', 'Axiom A2', 'Bezeichnung des Axioms der funktionalen Relationierbarkeit.', NULL, 'qualitative FRZK-Axiomatik', 3)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`), `definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`), `symbol_order`=VALUES(`symbol_order`);

/* (3.282) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3282_id, 'A_1', 'Axiom A1', 'Bezeichnung des ersten FRZK-Axioms.', NULL, 'qualitative FRZK-Axiomatik', 1),
(@equation_3282_id, '\\land', 'logische Konjunktion', 'Verknüpft Axiom A1 und Axiom A2 in der qualitativen Zusammenfassung.', NULL, 'qualitative logische Verknüpfung', 2),
(@equation_3282_id, 'A_2', 'Axiom A2', 'Bezeichnung des zweiten FRZK-Axioms.', NULL, 'qualitative FRZK-Axiomatik', 3),
(@equation_3282_id, '\\Longrightarrow', 'qualitativer Folgerungspfeil', 'Kennzeichnet die gemeinsame qualitative Reichweite beider Axiome.', NULL, 'qualitative axiomatische Zusammenfassung', 4)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`), `definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`), `symbol_order`=VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   17. Abschnittssymbole registrieren
   Der UNIQUE-Key lautet (symbol_latex, scope_type, first_section_id).
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `symbols`
(
    `symbol_latex`, `symbol_word_latex`, `symbol_name`, `definition_text`,
    `scope_type`, `first_section_id`, `first_equation_id`,
    `unit_text`, `domain_text`, `codomain_text`,
    `is_vector`, `is_matrix`, `is_operator`,
    `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'A_2', 'A_2', 'Axiom A2',
    'Bezeichnung des zweiten FRZK-Axioms der funktionalen Relationierbarkeit.',
    'section', @section_id, @equation_3279_id,
    NULL, 'qualitative FRZK-Axiomatik', 'qualitative FRZK-Axiomatik',
    0, 0, 0,
    'Kein mathematisches Objekt und keine Variable eines Zustandsraumes.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`), `symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`), `first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`), `is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`), `is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`), `validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `symbols`
(
    `symbol_latex`, `symbol_word_latex`, `symbol_name`, `definition_text`,
    `scope_type`, `first_section_id`, `first_equation_id`,
    `unit_text`, `domain_text`, `codomain_text`,
    `is_vector`, `is_matrix`, `is_operator`,
    `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    '\\not\\Longrightarrow', '\\not\\Longrightarrow',
    'qualitativer Nichtableitungspfeil',
    'Kennzeichnet in Abschnitt 3.3.3 die behauptete qualitative Nichtableitbarkeit von Axiom A2 aus Axiom A1.',
    'section', @section_id, @equation_3281_id,
    NULL, 'qualitative axiomatische Nichtableitbarkeit', 'qualitative axiomatische Nichtableitbarkeit',
    0, 0, 0,
    'Kein abgeschlossener modelltheoretischer Unabhängigkeitsbeweis.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`), `symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`), `first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`), `is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`), `is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`), `validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `symbols`
(
    `symbol_latex`, `symbol_word_latex`, `symbol_name`, `definition_text`,
    `scope_type`, `first_section_id`, `first_equation_id`,
    `unit_text`, `domain_text`, `codomain_text`,
    `is_vector`, `is_matrix`, `is_operator`,
    `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    '\\land', '\\land',
    'logische Konjunktion',
    'Logisches Und zur qualitativen Verknüpfung der Axiome A1 und A2 in Gleichung (3.282).',
    'section', @section_id, @equation_3282_id,
    NULL, 'qualitative logische Aussagen', 'qualitative logische Aussagen',
    0, 0, 0,
    'Dient ausschließlich der komprimierten Darstellung.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`), `symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`), `first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`), `domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`), `is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`), `is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`), `validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   18. Abschnittsänderungsprotokoll
   Nur reale ENUM-Werte aus frzk_rkb(5).sql werden verwendet.
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log`
(
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.3.3',
    'Abschnitt 3.3.3 wurde vollständig als Formulierung und Begründung von Axiom A2 neu gefasst.',
    'Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit beziehungsweise älterer Planungsstand.',
    'Axiom A2 – Funktionale Relationierbarkeit.'
),
(
    @revision_id, @section_id, 'source_reused', 'source_usage', '[84]',
    'Mac Lane [84] wurde als struktureller Forschungsanschluss wiederverwendet.',
    NULL,
    'Eine geprüfte Wiederverwendung; keine neue Quelle.'
),
(
    @revision_id, @section_id, 'definition_added', 'definitions', 'Def. 3.3.3.1',
    'Der qualitative Begriff des funktionalen Zusammenhangs wurde registriert und vom mathematischen Relationsbegriff abgegrenzt.',
    NULL,
    'Def. 3.3.3.1 Funktionaler Zusammenhang.'
),
(
    @revision_id, @section_id, 'axiom_added', 'axioms', 'A2',
    'Axiom A2 wurde einschließlich Motivation, Konsistenz-, Unabhängigkeits- und Operationalisierungshinweis registriert.',
    NULL,
    'A2 – Funktionale Relationierbarkeit.'
),
(
    @revision_id, @section_id, 'equation_added', 'equations', '(3.279)–(3.282)',
    'Vier qualitative axiomatische Darstellungen wurden vollständig registriert.',
    NULL,
    'Axiom A2, Abhängigkeit von A1, Nichtableitbarkeit aus A1 und gemeinsame Reichweite von A1 und A2.'
),
(
    @revision_id, @section_id, 'symbol_added', 'symbols', 'A_2, \\not\\Longrightarrow, \\land',
    'Die neuen abschnittsspezifischen Symbole wurden einschließlich Gleichungsbezügen registriert.',
    NULL,
    'Drei Abschnittssymbole.'
),
(
    @revision_id, @section_id, 'status_changed', 'section', '3.3.3',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   19. Repository-Zähler aktualisieren
   Keine neue Quelle: next_citation_number bleibt 87.
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section',       '3.3.3'),
    ('last_repository_revision', 'RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1'),
    ('next_citation_number',      '87'),
    ('next_equation_number',      '3.283')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* -------------------------------------------------------------------------------------------------
   20. Transaktion abschließen
   ------------------------------------------------------------------------------------------------- */

COMMIT;

/* =================================================================================================
   21. AUDIT UND KONTROLLABFRAGEN

   Erwartete Ergebnisse:
     Revision:                     RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1
     Parent-Revision:              RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3
     Abschnitt:                    3.3.3
     Status:                       review
     neue Quellen:                0
     wiederverwendete Quelle:     [84]
     Definitionen:                1
     Axiome:                       1 (A2)
     Axiomabhängigkeiten:         A2 depends_on A1
     Gleichungen:                 (3.279)–(3.282)
     nächste Quelle:              [87]
     nächste Gleichung:           (3.283)
   ================================================================================================= */

/* 21.1 Revision und Parent */
SELECT
    r.`revision_id`,
    r.`revision_code`,
    r.`scope_type`,
    r.`scope_reference`,
    r.`version_label`,
    p.`revision_code` AS `parent_revision_code`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p
    ON p.`revision_id` = r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci
      =
      'RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

/* 21.2 Abschnitt */
SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    p.`section_code` AS `parent_section_code`,
    ds.`notes`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` p
    ON p.`section_id` = ds.`parent_section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.3' COLLATE utf8mb4_unicode_ci;

/* 21.3 Quellenverwendung */
SELECT
    s.`citation_number`,
    s.`short_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`exact_location`,
    su.`claim_summary`
FROM `source_usage` su
JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

/* 21.4 Definition */
SELECT
    d.`definition_number`,
    d.`title`,
    d.`definition_text`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`section_id` = @section_id
ORDER BY d.`definition_number`;

/* 21.5 Axiom A2 */
SELECT
    ax.`axiom_id`,
    ax.`axiom_number`,
    ax.`title`,
    ax.`axiom_text`,
    ax.`formal_latex`,
    ax.`word_latex`,
    ax.`source_assumption_id`,
    ax.`status`,
    rr.`revision_code`
FROM `axioms` ax
LEFT JOIN `repository_revisions` rr
    ON rr.`revision_id` = ax.`created_revision_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A2' COLLATE utf8mb4_unicode_ci;

/* 21.6 Axiomabhängigkeit */
SELECT
    ax.`axiom_number`,
    parent_ax.`axiom_number` AS `depends_on_axiom`,
    ad.`dependency_type`,
    ad.`note`
FROM `axiom_dependencies` ad
JOIN `axioms` ax
    ON ax.`axiom_id` = ad.`axiom_id`
JOIN `axioms` parent_ax
    ON parent_ax.`axiom_id` = ad.`depends_on_axiom_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A2' COLLATE utf8mb4_unicode_ci;

/* 21.7 Objekt-Quellen-Verknüpfungen */
SELECT
    osl.`object_type`,
    osl.`object_id`,
    s.`citation_number`,
    osl.`usage_type`,
    osl.`note`
FROM `object_source_links` osl
JOIN `sources` s
    ON s.`source_id` = osl.`source_id`
WHERE s.`citation_number` = 84
  AND
  (
      (osl.`object_type` = 'axiom' AND osl.`object_id` = @axiom_a2_id)
      OR
      (osl.`object_type` = 'definition' AND osl.`object_id` = @definition_id)
  )
ORDER BY osl.`object_type`;

/* 21.8 Gleichungen und Word-LaTeX */
SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_type`,
    e.`provenance`,
    e.`validation_status`,
    e.`equation_latex`,
    e.`word_latex`,
    CASE
        WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`) = '' THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `equations` e
WHERE e.`section_id` = @section_id
  AND e.`equation_number` IN ('3.279','3.280','3.281','3.282')
ORDER BY e.`equation_number`;

/* 21.9 Gleichungssymbole */
SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`,
    es.`definition_text`
FROM `equation_symbols` es
JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`section_id` = @section_id
  AND e.`equation_number` IN ('3.279','3.280','3.281','3.282')
ORDER BY e.`equation_number`, es.`symbol_order`;

/* 21.10 Abschnittssymbole */
SELECT
    sy.`symbol_latex`,
    sy.`symbol_name`,
    sy.`scope_type`,
    sy.`validation_status`,
    e.`equation_number` AS `first_equation_number`
FROM `symbols` sy
LEFT JOIN `equations` e
    ON e.`equation_id` = sy.`first_equation_id`
WHERE sy.`first_section_id` = @section_id
ORDER BY sy.`symbol_latex`;

/* 21.11 Repository-Zähler */
SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
(
    'last_edited_section',
    'last_repository_revision',
    'next_citation_number',
    'next_equation_number'
)
ORDER BY `counter_key`;

/* 21.12 Doppelte Gleichungsnummern */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*) > 1;

/* 21.13 Doppelte Gleichungssymbole */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`, `symbol_latex`
HAVING COUNT(*) > 1;

/* 21.14 Fehlendes Word-LaTeX */
SELECT
    `equation_number`,
    `title`
FROM `equations`
WHERE `section_id` = @section_id
  AND (`word_latex` IS NULL OR TRIM(`word_latex`) = '');

/* 21.15 Ungültige oder leere ENUM-Werte im Abschnitt */
SELECT
    'source_usage' AS `table_name`,
    CAST(`usage_id` AS CHAR) AS `row_id`,
    `usage_type` AS `enum_value`
FROM `source_usage`
WHERE `section_id` = @section_id
  AND
  (
      `usage_type` IS NULL
      OR TRIM(`usage_type`) = ''
  )

UNION ALL

SELECT
    'section_change_log' AS `table_name`,
    CAST(`change_id` AS CHAR) AS `row_id`,
    `change_type` AS `enum_value`
FROM `section_change_log`
WHERE `section_id` = @section_id
  AND
  (
      `change_type` IS NULL
      OR TRIM(`change_type`) = ''
  )

UNION ALL

SELECT
    'object_source_links' AS `table_name`,
    CAST(`object_source_link_id` AS CHAR) AS `row_id`,
    `usage_type` AS `enum_value`
FROM `object_source_links`
WHERE
    (
        (`object_type` = 'axiom' AND `object_id` = @axiom_a2_id)
        OR
        (`object_type` = 'definition' AND `object_id` = @definition_id)
    )
  AND
  (
      `usage_type` IS NULL
      OR TRIM(`usage_type`) = ''
  );

/* 21.16 Verwaiste Objekte dieser Revision */
SELECT
    'definition' AS `object_type`,
    d.`definition_id` AS `object_id`,
    d.`definition_number` AS `object_reference`
FROM `definitions` d
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = d.`section_id`
WHERE d.`created_revision_id` = @revision_id
  AND ds.`section_id` IS NULL

UNION ALL

SELECT
    'axiom' AS `object_type`,
    ax.`axiom_id` AS `object_id`,
    ax.`axiom_number` AS `object_reference`
FROM `axioms` ax
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = ax.`section_id`
WHERE ax.`created_revision_id` = @revision_id
  AND ds.`section_id` IS NULL

UNION ALL

SELECT
    'equation' AS `object_type`,
    e.`equation_id` AS `object_id`,
    e.`equation_number` AS `object_reference`
FROM `equations` e
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE e.`created_revision_id` = @revision_id
  AND ds.`section_id` IS NULL;

/* 21.17 Änderungsprotokoll */
SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id` = @revision_id
  AND scl.`section_id` = @section_id
ORDER BY scl.`change_id`;

/* 21.18 Abschlussmeldung */
SELECT
    'Repository-Update 3.3.3 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [87], Gleichung (3.283), letzte Revision RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1.' AS `result`;
