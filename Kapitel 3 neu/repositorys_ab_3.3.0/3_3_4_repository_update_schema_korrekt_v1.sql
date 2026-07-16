/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.4

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql

   Abschnitt:
     3.3.4 Axiom A3 – Dynamische Zustandsänderung

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1
     letzte Literaturquelle:      [86]
     nächste freie Literatur-Nr.: [87]
     letzte Gleichung:            (3.282)
     nächste Gleichungen:         (3.283)–(3.286)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquellen:       keine
     wiederverwendete Quellen:    keine
     nächste freie Literatur-Nr.: [87]
     neue Gleichungen:            (3.283), (3.284), (3.285), (3.286)
     nächste freie Gleichung:     (3.287)
     neue Revision:               RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1

   Registrierte Repository-Objekte:
     - repository_revisions
     - dissertation_sections
     - definitions
     - axioms
     - axiom_dependencies
     - equations
     - equation_symbols
     - symbols
     - section_change_log
     - repository_counters
     - vollständige Audit- und Kontrollabfragen

   Wichtige Schemaentscheidungen:
     - axioms.source_assumption_id bleibt NULL.
       Es wird keine nicht vorhandene Annahme konstruiert.
     - Der Abschnitt enthält keine neue oder wiederverwendete Literaturquelle.
       Deshalb werden weder sources noch source_usage noch object_source_links verändert.
     - section_change_log.change_type verwendet ausschließlich gültige ENUM-Werte.
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
    CONVERT('RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_334`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_334`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_334` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_334`;

/* -------------------------------------------------------------------------------------------------
   2. Abschnittsrevision idempotent anlegen
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1' USING utf8mb4)
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
    '3.3.4',
    'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.4: Axiom A3 – Dynamische Zustandsänderung. Registriert werden die qualitative Definition der funktionalen Transformation, das originäre Axiom A3, die Abhängigkeiten von Axiom A1 und Axiom A2, die Gleichungen (3.283) bis (3.286), Gleichungssymbole, Abschnittssymbole, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
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

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_334`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_334`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_334` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_334`;

/* -------------------------------------------------------------------------------------------------
   4. Abschnitt 3.3.4 aktualisieren
   Im Ausgangsdump existiert 3.3.4 noch mit einer älteren geplanten Bezeichnung.
   Der eindeutige section_code bleibt erhalten.
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
    '3.3.4',
    'Axiom A3 – Dynamische Zustandsänderung',
    3,
    3.3005,
    'review',
    1,
    'Drittes originäres FRZK-Axiom. Transformierbarkeit wird qualitativ vor mathematischen Operatoren, Zustandsräumen und Zeitparametern eingeführt. Zeit wird nicht vorausgesetzt, sondern erst später aus geordneten funktionalen Transformationen rekonstruiert.'
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
      '3.3.4' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   5. Qualitative Definition der funktionalen Transformation
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
    'Def. 3.3.4.1',
    @section_id,
    'Funktionale Transformation',
    'Eine funktionale Transformation bezeichnet in Kapitel 3.3 eine qualitative Veränderung mindestens einer funktional bestimmbaren Eigenschaft eines Zustandes oder eines funktionalen Zusammenhangs, durch die eine prinzipiell unterscheidbare Konfiguration entsteht. Sie ist noch keine mathematische Funktion, kein Operator, keine Differentialgleichung und keine zeitparametrisierte Entwicklung.',
    NULL,
    NULL,
    'original',
    NULL,
    'Axiom A1, Axiom A2 sowie die primitiven Begriffe Unterscheidbarkeit, Relationierbarkeit und Transformation werden vorausgesetzt.',
    'Qualitative Sprachdefinition zur eindeutigen Abgrenzung von einer später mathematisch rekonstruierten Transformationsabbildung oder einem Operator.',
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
      'Def. 3.3.4.1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   6. Axiom A1 und Axiom A2 als Abhängigkeitsgrundlage auflösen
   ------------------------------------------------------------------------------------------------- */

SET @axiom_a1_id := NULL;
SET @axiom_a2_id := NULL;

SELECT `axiom_id`
INTO @axiom_a1_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `axiom_id`
INTO @axiom_a2_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A2' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_axioms_a1_a2_334`;

CREATE TEMPORARY TABLE `tmp_frzk_axioms_a1_a2_334`
(
    `axiom_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_axioms_a1_a2_334` (`axiom_id`)
VALUES
    (@axiom_a1_id),
    (@axiom_a2_id);

DROP TEMPORARY TABLE `tmp_frzk_axioms_a1_a2_334`;

/* -------------------------------------------------------------------------------------------------
   7. Originäres FRZK-Axiom A3
   source_assumption_id bleibt gemäß realem Schema und Datenbestand NULL.
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
    'A3',
    @section_id,
    'Dynamische Zustandsänderung',
    'Funktionale Zustände und ihre funktionalen Zusammenhänge können sich verändern.',
    'A_3:\\quad\\text{Funktionale Zustände und Zusammenhänge sind prinzipiell transformierbar.}',
    'A_3:\\quad\\text{Funktionale Zustände und Zusammenhänge sind prinzipiell transformierbar.}',
    'Axiom A1 ermöglicht funktional unterscheidbare Zuständlichkeit und Axiom A2 funktionale Zusammenhänge. Beide Axiome begründen jedoch noch keine Veränderbarkeit. Axiom A3 ergänzt deshalb die eigenständige Möglichkeit qualitativer funktionaler Transformation.',
    'Axiom A3 benötigt Axiom A1 und Axiom A2 als Anwendungsgrundlage, ist aus deren gemeinsamer Geltung jedoch nicht ableitbar. Ein vollständig statisches Modell mit unterscheidbaren und relationierbaren Zuständen bleibt begrifflich möglich.',
    'Das Axiom ist mit Axiom A1 und Axiom A2 vereinbar, weil es ausschließlich Veränderbarkeit ergänzt und weder einen Zeitparameter noch einen mathematischen Operator voraussetzt.',
    'In Kapitel 3.4 wird aus Axiom A3 eine funktionale Transformationsstruktur rekonstruiert. Erst aus geordneten und vergleichbaren Transformationen kann später eine funktionale Zeitstruktur hervorgehen.',
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

SET @axiom_a3_id := NULL;

SELECT `axiom_id`
INTO @axiom_a3_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   8. Axiomabhängigkeiten A3 depends_on A1 und A2
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a3_id;

INSERT INTO `axiom_dependencies`
(
    `axiom_id`,
    `depends_on_axiom_id`,
    `dependency_type`,
    `note`
)
VALUES
(
    @axiom_a3_id,
    @axiom_a1_id,
    'depends_on',
    'Transformierbarkeit setzt funktional unterscheidbare Zuständlichkeit voraus.'
),
(
    @axiom_a3_id,
    @axiom_a2_id,
    'depends_on',
    'Die Veränderung funktionaler Zusammenhänge setzt funktionale Relationierbarkeit voraus.'
)
ON DUPLICATE KEY UPDATE
    `note` = VALUES(`note`);

/* -------------------------------------------------------------------------------------------------
   9. Gleichung (3.283): Axiom A3
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
    '3.283',
    @section_id,
    'Axiom A3 – komprimierte axiomatische Schreibweise',
    'A_3:\\quad\\text{Funktionale Zustände und Zusammenhänge sind prinzipiell transformierbar.}',
    'A_3:\\quad\\text{Funktionale Zustände und Zusammenhänge sind prinzipiell transformierbar.}',
    'Komprimierte qualitative Formulierung des dritten FRZK-Axioms. Sie führt weder mathematischen Operator noch Zustandsraum, Differentialgleichung oder Zeitparameter ein.',
    'axiom',
    'original',
    NULL,
    'Originäre axiomatische Setzung auf Grundlage funktionaler Unterscheidbarkeit und Relationierbarkeit.',
    'Axiom A1, Axiom A2 sowie die qualitativen Begriffe Zustand, Zusammenhang und Transformation werden vorausgesetzt.',
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
   10. Gleichung (3.284): A3 setzt A1 und A2 voraus
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
    '3.284',
    @section_id,
    'Qualitative Abhängigkeit von Axiom A3 von Axiom A1 und Axiom A2',
    'A_3\\;\\Longrightarrow\\;A_1\\land A_2',
    'A_3\\Longrightarrow A_1\\land A_2',
    'Qualitative axiomatische Abhängigkeit: Transformierbarkeit benötigt funktional unterscheidbare und relationierbare Zuständlichkeit.',
    'schema',
    'original',
    NULL,
    'Axiom A3 kann nur auf funktional unterscheidbare Zustände und funktionale Zusammenhänge angewendet werden.',
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
   11. Gleichung (3.285): A1 und A2 implizieren A3 nicht
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
    '3.285',
    @section_id,
    'Qualitative Nichtableitbarkeit von Axiom A3 aus Axiom A1 und Axiom A2',
    'A_1\\land A_2\\;\\not\\Longrightarrow\\;A_3',
    'A_1\\land A_2\\not\\Longrightarrow A_3',
    'Qualitative Aussage, dass funktionale Unterscheidbarkeit und Relationierbarkeit allein noch keine Veränderbarkeit begründen.',
    'schema',
    'original',
    NULL,
    'Ein begriffliches Modell mit unterscheidbaren und relationierbaren, aber vollständig starren Konfigurationen zeigt die eigenständige Rolle von Axiom A3.',
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
   12. Gleichung (3.286): gemeinsame qualitative Reichweite von A1, A2 und A3
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
    '3.286',
    @section_id,
    'Gemeinsame qualitative Reichweite der Axiome A1, A2 und A3',
    'A_1\\land A_2\\land A_3\\;\\Longrightarrow\\;\\text{unterscheidbare, relationierbare und transformierbare Zuständlichkeit}',
    'A_1\\land A_2\\land A_3\\Longrightarrow\\text{unterscheidbare, relationierbare und transformierbare Zuständlichkeit}',
    'Qualitative Zusammenfassung der gemeinsamen Reichweite der ersten drei FRZK-Axiome.',
    'schema',
    'original',
    NULL,
    'Zusammenführung der qualitativen Reichweite von Axiom A1, Axiom A2 und Axiom A3.',
    'Es wird noch kein dynamischer Zustandsraum und keine zeitabhängige Entwicklungsgleichung behauptet.',
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

SET @equation_3283_id := NULL;
SET @equation_3284_id := NULL;
SET @equation_3285_id := NULL;
SET @equation_3286_id := NULL;

SELECT `equation_id`
INTO @equation_3283_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.283' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `equation_id`
INTO @equation_3284_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.284' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `equation_id`
INTO @equation_3285_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.285' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `equation_id`
INTO @equation_3286_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.286' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   13. Gleichungssymbole kontrolliert neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN
(
    @equation_3283_id,
    @equation_3284_id,
    @equation_3285_id,
    @equation_3286_id
);

/* (3.283) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3283_id, 'A_3', 'Axiom A3', 'Bezeichnung des dritten FRZK-Axioms der dynamischen Zustandsänderung.', NULL, 'qualitative FRZK-Axiomatik', 1)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`symbol_order`=VALUES(`symbol_order`);

/* (3.284) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3284_id, 'A_3', 'Axiom A3', 'Bezeichnung des Axioms der dynamischen Zustandsänderung.', NULL, 'qualitative FRZK-Axiomatik', 1),
(@equation_3284_id, '\\Longrightarrow', 'qualitativer Folgerungspfeil', 'Kennzeichnet eine qualitative axiomatische Voraussetzung.', NULL, 'qualitative axiomatische Abhängigkeit', 2),
(@equation_3284_id, 'A_1', 'Axiom A1', 'Bezeichnung des Axioms der Existenz funktionaler Zustände.', NULL, 'qualitative FRZK-Axiomatik', 3),
(@equation_3284_id, '\\land', 'logische Konjunktion', 'Verknüpft Axiom A1 und Axiom A2.', NULL, 'qualitative logische Verknüpfung', 4),
(@equation_3284_id, 'A_2', 'Axiom A2', 'Bezeichnung des Axioms der funktionalen Relationierbarkeit.', NULL, 'qualitative FRZK-Axiomatik', 5)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`symbol_order`=VALUES(`symbol_order`);

/* (3.285) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3285_id, 'A_1', 'Axiom A1', 'Bezeichnung des Axioms der Existenz funktionaler Zustände.', NULL, 'qualitative FRZK-Axiomatik', 1),
(@equation_3285_id, '\\land', 'logische Konjunktion', 'Verknüpft Axiom A1 und Axiom A2.', NULL, 'qualitative logische Verknüpfung', 2),
(@equation_3285_id, 'A_2', 'Axiom A2', 'Bezeichnung des Axioms der funktionalen Relationierbarkeit.', NULL, 'qualitative FRZK-Axiomatik', 3),
(@equation_3285_id, '\\not\\Longrightarrow', 'qualitativer Nichtableitungspfeil', 'Kennzeichnet die behauptete qualitative Nichtableitbarkeit von Axiom A3 aus Axiom A1 und Axiom A2.', NULL, 'qualitative axiomatische Nichtableitbarkeit', 4),
(@equation_3285_id, 'A_3', 'Axiom A3', 'Bezeichnung des Axioms der dynamischen Zustandsänderung.', NULL, 'qualitative FRZK-Axiomatik', 5)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`symbol_order`=VALUES(`symbol_order`);

/* (3.286) */
INSERT INTO `equation_symbols`
(`equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`)
VALUES
(@equation_3286_id, 'A_1', 'Axiom A1', 'Bezeichnung des ersten FRZK-Axioms.', NULL, 'qualitative FRZK-Axiomatik', 1),
(@equation_3286_id, '\\land', 'logische Konjunktion', 'Verknüpft die Axiome in der qualitativen Zusammenfassung.', NULL, 'qualitative logische Verknüpfung', 2),
(@equation_3286_id, 'A_2', 'Axiom A2', 'Bezeichnung des zweiten FRZK-Axioms.', NULL, 'qualitative FRZK-Axiomatik', 3),
(@equation_3286_id, 'A_3', 'Axiom A3', 'Bezeichnung des dritten FRZK-Axioms.', NULL, 'qualitative FRZK-Axiomatik', 4),
(@equation_3286_id, '\\Longrightarrow', 'qualitativer Folgerungspfeil', 'Kennzeichnet die gemeinsame qualitative Reichweite der Axiome A1 bis A3.', NULL, 'qualitative axiomatische Zusammenfassung', 5)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`symbol_order`=VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   14. Abschnittssymbole registrieren
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
    'A_3', 'A_3', 'Axiom A3',
    'Bezeichnung des dritten FRZK-Axioms der dynamischen Zustandsänderung.',
    'section', @section_id, @equation_3283_id,
    NULL, 'qualitative FRZK-Axiomatik', 'qualitative FRZK-Axiomatik',
    0, 0, 0,
    'Kein mathematisches Objekt und keine Variable eines Zustandsraumes.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`),
`is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`),
`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),
`validation_status`=VALUES(`validation_status`),
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
    'Kennzeichnet in Abschnitt 3.3.4 die behauptete qualitative Nichtableitbarkeit von Axiom A3 aus Axiom A1 und Axiom A2.',
    'section', @section_id, @equation_3285_id,
    NULL, 'qualitative axiomatische Nichtableitbarkeit', 'qualitative axiomatische Nichtableitbarkeit',
    0, 0, 0,
    'Kein abgeschlossener modelltheoretischer Unabhängigkeitsbeweis.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`),
`is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`),
`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),
`validation_status`=VALUES(`validation_status`),
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
    'Logisches Und zur qualitativen Verknüpfung der Axiome A1, A2 und A3.',
    'section', @section_id, @equation_3284_id,
    NULL, 'qualitative logische Aussagen', 'qualitative logische Aussagen',
    0, 0, 0,
    'Dient ausschließlich der komprimierten Darstellung.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`),
`is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`),
`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),
`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   15. Abschnittsänderungsprotokoll
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
    @revision_id, @section_id, 'rewritten', 'section', '3.3.4',
    'Abschnitt 3.3.4 wurde vollständig als Formulierung und Begründung von Axiom A3 neu gefasst.',
    'Axiom A2 – Prinzip der funktionalen Relationierbarkeit beziehungsweise älterer Planungsstand.',
    'Axiom A3 – Dynamische Zustandsänderung.'
),
(
    @revision_id, @section_id, 'definition_added', 'definitions', 'Def. 3.3.4.1',
    'Der qualitative Begriff der funktionalen Transformation wurde registriert und von mathematischen Operatoren sowie Zeitentwicklungen abgegrenzt.',
    NULL,
    'Def. 3.3.4.1 Funktionale Transformation.'
),
(
    @revision_id, @section_id, 'axiom_added', 'axioms', 'A3',
    'Axiom A3 wurde einschließlich Motivation, Konsistenz-, Unabhängigkeits- und Operationalisierungshinweis registriert.',
    NULL,
    'A3 – Dynamische Zustandsänderung.'
),
(
    @revision_id, @section_id, 'equation_added', 'equations', '(3.283)–(3.286)',
    'Vier qualitative axiomatische Darstellungen wurden vollständig registriert.',
    NULL,
    'Axiom A3, Abhängigkeit von A1 und A2, Nichtableitbarkeit sowie gemeinsame Reichweite von A1 bis A3.'
),
(
    @revision_id, @section_id, 'symbol_added', 'symbols', 'A_3, \\not\\Longrightarrow, \\land',
    'Die neuen abschnittsspezifischen Symbole wurden einschließlich Gleichungsbezügen registriert.',
    NULL,
    'Drei Abschnittssymbole.'
),
(
    @revision_id, @section_id, 'status_changed', 'section', '3.3.4',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   16. Repository-Zähler aktualisieren
   Keine neue Quelle: next_citation_number bleibt 87.
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section',       '3.3.4'),
    ('last_repository_revision', 'RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1'),
    ('next_citation_number',      '87'),
    ('next_equation_number',      '3.287')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* -------------------------------------------------------------------------------------------------
   17. Transaktion abschließen
   ------------------------------------------------------------------------------------------------- */

COMMIT;

/* =================================================================================================
   18. AUDIT UND KONTROLLABFRAGEN

   Erwartete Ergebnisse:
     Revision:                     RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1
     Parent-Revision:              RKB-2026-07-16-K3.3.3-NEUFASSUNG-V1
     Abschnitt:                    3.3.4
     Status:                       review
     neue Quellen:                0
     Definitionen:                1
     Axiome:                       1 (A3)
     Axiomabhängigkeiten:         A3 depends_on A1 und A2
     Gleichungen:                 (3.283)–(3.286)
     nächste Quelle:              [87]
     nächste Gleichung:           (3.287)
   ================================================================================================= */

/* 18.1 Revision und Parent */
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
      'RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

/* 18.2 Abschnitt */
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
      '3.3.4' COLLATE utf8mb4_unicode_ci;

/* 18.3 Definition */
SELECT
    d.`definition_number`,
    d.`title`,
    d.`definition_text`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`section_id` = @section_id
ORDER BY d.`definition_number`;

/* 18.4 Axiom A3 */
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
      'A3' COLLATE utf8mb4_unicode_ci;

/* 18.5 Axiomabhängigkeiten */
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
      'A3' COLLATE utf8mb4_unicode_ci
ORDER BY parent_ax.`axiom_number`;

/* 18.6 Gleichungen und Word-LaTeX */
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
  AND e.`equation_number` IN ('3.283','3.284','3.285','3.286')
ORDER BY e.`equation_number`;

/* 18.7 Gleichungssymbole */
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
  AND e.`equation_number` IN ('3.283','3.284','3.285','3.286')
ORDER BY e.`equation_number`, es.`symbol_order`;

/* 18.8 Abschnittssymbole */
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

/* 18.9 Repository-Zähler */
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

/* 18.10 Doppelte Gleichungsnummern */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*) > 1;

/* 18.11 Doppelte Gleichungssymbole */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`, `symbol_latex`
HAVING COUNT(*) > 1;

/* 18.12 Fehlendes Word-LaTeX */
SELECT
    `equation_number`,
    `title`
FROM `equations`
WHERE `section_id` = @section_id
  AND (`word_latex` IS NULL OR TRIM(`word_latex`) = '');

/* 18.13 Ungültige oder leere ENUM-Werte im Abschnitt */
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
  );

/* 18.14 Verwaiste Objekte dieser Revision */
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

/* 18.15 Änderungsprotokoll */
SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id` = @revision_id
  AND scl.`section_id` = @section_id
ORDER BY scl.`change_id`;

/* 18.16 Abschlussmeldung */
SELECT
    'Repository-Update 3.3.4 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [87], Gleichung (3.287), letzte Revision RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1.' AS `result`;
