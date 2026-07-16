/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.6

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql

   Abschnitt:
     3.3.6 Axiom A5 – Funktionale Kohärenz und Stabilisierung

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1
     letzte Literaturquelle:      [86]
     nächste freie Literatur-Nr.: [87]
     letzte Gleichung:            (3.290)
     nächste Gleichungen:         (3.291)–(3.294)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquelle:        [87] Maturana / Varela
     wiederverwendete Quellen:    [12] Haken, [13] Prigogine / Stengers
     nächste freie Literatur-Nr.: [88]
     neue Gleichungen:            (3.291), (3.292), (3.293), (3.294)
     nächste freie Gleichung:     (3.295)
     neue Revision:               RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1

   Registrierte Repository-Objekte:
     - repository_revisions
     - dissertation_sections
     - authors
     - sources
     - source_authors
     - annotations
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
     - source_usage.usage_type nutzt nur gültige ENUM-Werte.
     - object_source_links.usage_type nutzt nur gültige ENUM-Werte.
     - section_change_log.change_type nutzt nur gültige ENUM-Werte.
     - Keine nicht vorhandene assumption_id wird vorausgesetzt.
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
    CONVERT('RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_336`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_336`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_336` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_336`;

/* -------------------------------------------------------------------------------------------------
   2. Neue Abschnittsrevision
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1' USING utf8mb4)
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
    '3.3.6',
    'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.6: Axiom A5 – Funktionale Kohärenz und Stabilisierung. Registriert werden die qualitativen Definitionen funktionaler Kohärenz und funktionaler Stabilisierung, das originäre Axiom A5, die Abhängigkeiten von Axiom A1 bis Axiom A4, die neue Quelle [87] Maturana/Varela, Wiederverwendungen der Quellen [12] und [13], die Gleichungen (3.291) bis (3.294), Gleichungssymbole, Abschnittssymbole, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
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
   3. Abschnitt 3.3.6
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_336`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_336`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_336` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_336`;

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
    '3.3.6',
    'Axiom A5 – Funktionale Kohärenz und Stabilisierung',
    3,
    3.3007,
    'review',
    1,
    'Fünftes originäres FRZK-Axiom. Kohärenz bezeichnet den funktionalen Erhalt von Zusammengehörigkeit unter Transformation, nicht vollständige Unveränderlichkeit. Mathematische Kohärenzmaße, Attraktoren, Fixpunkte oder Lyapunov-Funktionen werden nicht vorausgesetzt.'
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
      '3.3.6' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   4. Autoren der neuen Quelle [87]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `orcid`,
    `birth_year`,
    `death_year`,
    `notes`
)
VALUES
(
    'Maturana',
    'Humberto R.',
    'Maturana, Humberto R.',
    NULL,
    1928,
    2021,
    'Chilenischer Biologe und Systemtheoretiker. In Abschnitt 3.3.6 als Forschungsanschluss zur Reproduktion organisatorischer Zusammenhänge verwendet.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `orcid`       = VALUES(`orcid`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `orcid`,
    `birth_year`,
    `death_year`,
    `notes`
)
VALUES
(
    'Varela',
    'Francisco J.',
    'Varela, Francisco J.',
    NULL,
    1946,
    2001,
    'Chilenischer Biologe, Neurowissenschaftler und Systemtheoretiker. In Abschnitt 3.3.6 als Forschungsanschluss zur Autopoiesis und organisatorischen Reproduktion verwendet.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `orcid`       = VALUES(`orcid`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

SET @author_maturana_id := NULL;
SET @author_varela_id := NULL;

SELECT `author_id`
INTO @author_maturana_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Maturana, Humberto R.' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `author_id`
INTO @author_varela_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Varela, Francisco J.' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   5. Neue Quelle [87]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `sources`
(
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `subtitle`,
    `year_original`,
    `year_edition`,
    `journal`,
    `publisher`,
    `place`,
    `volume`,
    `issue`,
    `pages`,
    `edition`,
    `doi`,
    `isbn`,
    `url`,
    `language_code`,
    `priority`,
    `evidence_type`,
    `frzk_relevance`,
    `verification_status`,
    `first_citation_section_code`,
    `first_citation_note`,
    `full_citation_text`,
    `short_citation_text`,
    `notes`,
    `created_revision_id`
)
VALUES
(
    87,
    'maturana_varela_autopoiesis_cognition_1980',
    'book',
    'Autopoiesis and Cognition',
    'The Realization of the Living',
    1972,
    1980,
    NULL,
    'D. Reidel Publishing Company',
    'Dordrecht',
    NULL,
    NULL,
    NULL,
    NULL,
    '10.1007/978-94-009-8947-4',
    NULL,
    'https://doi.org/10.1007/978-94-009-8947-4',
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.3.6',
    'Erstnennung als Forschungsanschluss zur fortlaufenden Reproduktion organisatorischer Zusammenhänge. Das FRZK übernimmt keine biologische Definition des Lebendigen und keine vollständige Autopoiesistheorie.',
    'Maturana, Humberto R.; Varela, Francisco J.: Autopoiesis and Cognition: The Realization of the Living. Dordrecht: D. Reidel Publishing Company, 1980.',
    'Maturana und Varela [87]',
    'Die Quelle dient zur wissenschaftlichen Einordnung der Möglichkeit, dass Organisation durch fortlaufende Prozesse erhalten und reproduziert werden kann. Axiom A5 bleibt eine originäre FRZK-Setzung.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`             = VALUES(`citation_number`),
    `source_type`                 = VALUES(`source_type`),
    `title`                       = VALUES(`title`),
    `subtitle`                    = VALUES(`subtitle`),
    `year_original`               = VALUES(`year_original`),
    `year_edition`                = VALUES(`year_edition`),
    `journal`                     = VALUES(`journal`),
    `publisher`                   = VALUES(`publisher`),
    `place`                       = VALUES(`place`),
    `volume`                      = VALUES(`volume`),
    `issue`                       = VALUES(`issue`),
    `pages`                       = VALUES(`pages`),
    `edition`                     = VALUES(`edition`),
    `doi`                         = VALUES(`doi`),
    `isbn`                        = VALUES(`isbn`),
    `url`                         = VALUES(`url`),
    `language_code`               = VALUES(`language_code`),
    `priority`                    = VALUES(`priority`),
    `evidence_type`               = VALUES(`evidence_type`),
    `frzk_relevance`              = VALUES(`frzk_relevance`),
    `verification_status`         = VALUES(`verification_status`),
    `first_citation_section_code` = VALUES(`first_citation_section_code`),
    `first_citation_note`         = VALUES(`first_citation_note`),
    `full_citation_text`          = VALUES(`full_citation_text`),
    `short_citation_text`         = VALUES(`short_citation_text`),
    `notes`                       = VALUES(`notes`),
    `created_revision_id`         = VALUES(`created_revision_id`);

SET @source_87_id := NULL;
SET @source_12_id := NULL;
SET @source_13_id := NULL;

SELECT `source_id`
INTO @source_87_id
FROM `sources`
WHERE `citation_number` = 87
LIMIT 1;

SELECT `source_id`
INTO @source_12_id
FROM `sources`
WHERE `citation_number` = 12
LIMIT 1;

SELECT `source_id`
INTO @source_13_id
FROM `sources`
WHERE `citation_number` = 13
LIMIT 1;

/* Vorhandensein der drei Quellen erzwingen */
DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_sources_336`;

CREATE TEMPORARY TABLE `tmp_frzk_sources_336`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_sources_336` (`source_id`)
VALUES
    (@source_12_id),
    (@source_13_id),
    (@source_87_id);

DROP TEMPORARY TABLE `tmp_frzk_sources_336`;

/* -------------------------------------------------------------------------------------------------
   6. Quellen-Autor-Verknüpfungen für [87]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `source_authors`
(
    `source_id`,
    `author_id`,
    `author_order`,
    `role`
)
VALUES
(
    @source_87_id,
    @author_maturana_id,
    1,
    'author'
)
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

INSERT INTO `source_authors`
(
    `source_id`,
    `author_id`,
    `author_order`,
    `role`
)
VALUES
(
    @source_87_id,
    @author_varela_id,
    2,
    'author'
)
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

/* -------------------------------------------------------------------------------------------------
   7. Annotation der Quelle [87]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `annotations`
(
    `source_id`,
    `contribution`,
    `significance_for_dissertation`,
    `citation_reason`,
    `adopted_claims`,
    `limitations`,
    `scientific_discussion`,
    `annotation_status`,
    `reviewed_at`
)
VALUES
(
    @source_87_id,
    'Entwicklung des Autopoiesisbegriffs zur Beschreibung von Systemen, deren Organisation durch ein Netzwerk wechselseitig erzeugender Prozesse reproduziert wird.',
    'Bietet einen zentralen wissenschaftlichen Anschluss für die qualitative Möglichkeit des Erhalts und der Reproduktion funktionaler Organisationszusammenhänge unter fortlaufender Veränderung.',
    'Die Quelle wird zitiert, um zu zeigen, dass organisatorische Reproduktion in der Systemtheorie bereits als eigenständige wissenschaftliche Problemstellung ausgearbeitet wurde.',
    'Übernommen wird ausschließlich die allgemeine Einsicht, dass Organisation durch fortlaufende Prozesse erhalten und reproduziert werden kann.',
    'Nicht übernommen werden eine biologische Definition des Lebendigen, konkrete autopoietische Mechanismen, Membranen, Stoffwechselprozesse oder eine Gleichsetzung des FRZK mit der Autopoiesistheorie.',
    'Axiom A5 verallgemeinert die Möglichkeit funktionaler Erhaltung auf eine qualitative vor-mathematische Ebene und bleibt von der biologischen Spezialisierung der Quelle unabhängig.',
    'reviewed',
    NOW()
)
ON DUPLICATE KEY UPDATE
    `contribution`                   = VALUES(`contribution`),
    `significance_for_dissertation` = VALUES(`significance_for_dissertation`),
    `citation_reason`                = VALUES(`citation_reason`),
    `adopted_claims`                 = VALUES(`adopted_claims`),
    `limitations`                    = VALUES(`limitations`),
    `scientific_discussion`         = VALUES(`scientific_discussion`),
    `annotation_status`             = VALUES(`annotation_status`),
    `reviewed_at`                    = VALUES(`reviewed_at`);

/* -------------------------------------------------------------------------------------------------
   8. Quellenverwendungen des Abschnitts
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
    @source_12_id,
    @section_id,
    'background',
    'Haken wird als Forschungsanschluss für den Erhalt und die Veränderung makroskopischer Ordnungsformen in synergetischen Systemen verwendet.',
    '3.3.6, Absatz zum wissenschaftlichen Forschungsstand',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [12]. Kein konkretes synergetisches Modell wird in Axiom A5 übernommen.',
    @revision_id
),
(
    @source_13_id,
    @section_id,
    'background',
    'Prigogine und Stengers werden als Forschungsanschluss für die Aufrechterhaltung dissipativer Strukturen in offenen Systemen verwendet.',
    '3.3.6, Absatz zum wissenschaftlichen Forschungsstand',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [13]. Axiom A5 setzt keine thermodynamischen Bedingungen voraus.',
    @revision_id
),
(
    @source_87_id,
    @section_id,
    'first_citation',
    'Maturana und Varela werden als Forschungsanschluss für die fortlaufende Reproduktion organisatorischer Zusammenhänge durch wechselseitig erzeugende Prozesse erstmals eingeführt.',
    '3.3.6, Absatz zum wissenschaftlichen Forschungsstand',
    1,
    1,
    'Erstnennung der Quelle [87]. Die biologische Autopoiesistheorie wird nicht als FRZK-Axiom übernommen.',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   9. Definitionen funktionaler Kohärenz und funktionaler Stabilisierung
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
    'Def. 3.3.6.1',
    @section_id,
    'Funktionale Kohärenz',
    'Funktionale Kohärenz bezeichnet in Kapitel 3.3 die qualitative Möglichkeit, dass mehrere funktionale Zustände, Relationierungen und Transformationen trotz innerer Veränderungen als zusammengehöriger Organisationszusammenhang bestimmbar bleiben. Kohärenz bedeutet weder vollständige Gleichheit noch vollständige Unveränderlichkeit und enthält noch kein mathematisches Kohärenzmaß.',
    NULL,
    NULL,
    'original',
    NULL,
    'Axiom A1 bis Axiom A4 sowie die primitiven Begriffe Organisation, Transformation und Kohärenz werden vorausgesetzt.',
    'Qualitative Definition vor jeder metrischen, statistischen, informationstheoretischen oder dynamischen Operationalisierung.',
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
    'Def. 3.3.6.2',
    @section_id,
    'Funktionale Stabilisierung',
    'Funktionale Stabilisierung bezeichnet in Kapitel 3.3 die qualitative Möglichkeit, einen funktionalen Organisationszusammenhang gegenüber auflösenden Transformationen zu erhalten, zu erneuern oder wiederherzustellen. Sie ist noch kein Fixpunkt, Attraktor, Gleichgewicht, Lyapunov-Kriterium oder mathematisch definierter Regelungsprozess.',
    NULL,
    NULL,
    'original',
    NULL,
    'Axiom A1 bis Axiom A4 sowie die qualitative Definition funktionaler Organisation werden vorausgesetzt.',
    'Stabilisierung bezeichnet die Möglichkeit des Erhalts oder der Wiederherstellung; Kohärenz bezeichnet den dabei erhaltenen funktionalen Zusammenhang.',
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

SET @definition_coherence_id := NULL;
SET @definition_stabilization_id := NULL;

SELECT `definition_id`
INTO @definition_coherence_id
FROM `definitions`
WHERE `definition_number` COLLATE utf8mb4_unicode_ci
      =
      'Def. 3.3.6.1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `definition_id`
INTO @definition_stabilization_id
FROM `definitions`
WHERE `definition_number` COLLATE utf8mb4_unicode_ci
      =
      'Def. 3.3.6.2' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   10. Axiome A1 bis A4 laden
   ------------------------------------------------------------------------------------------------- */

SET @axiom_a1_id := NULL;
SET @axiom_a2_id := NULL;
SET @axiom_a3_id := NULL;
SET @axiom_a4_id := NULL;

SELECT `axiom_id` INTO @axiom_a1_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci = 'A1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `axiom_id` INTO @axiom_a2_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci = 'A2' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `axiom_id` INTO @axiom_a3_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci = 'A3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `axiom_id` INTO @axiom_a4_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci = 'A4' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_axioms_a1_a4_336`;

CREATE TEMPORARY TABLE `tmp_frzk_axioms_a1_a4_336`
(
    `axiom_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_axioms_a1_a4_336` (`axiom_id`)
VALUES
    (@axiom_a1_id),
    (@axiom_a2_id),
    (@axiom_a3_id),
    (@axiom_a4_id);

DROP TEMPORARY TABLE `tmp_frzk_axioms_a1_a4_336`;

/* -------------------------------------------------------------------------------------------------
   11. Axiom A5
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
    'A5',
    @section_id,
    'Funktionale Kohärenz und Stabilisierung',
    'Funktionale Organisationszusammenhänge können sich trotz weiterer Transformationen erhalten, erneuern oder in einer wiedererkennbaren Form reproduzieren.',
    'A_5:\\quad\\text{Funktionale Organisation ist prinzipiell kohärenz- und stabilisierungsfähig.}',
    'A_5:\\quad\\text{Funktionale Organisation ist prinzipiell kohärenz- und stabilisierungsfähig.}',
    'Axiom A1 bis Axiom A4 ermöglichen funktionale Zustände, Relationierbarkeit, Transformation und Organisationsbildung, begründen jedoch noch keinen Erhalt unter weiterer Veränderung. Axiom A5 ergänzt die eigenständige Möglichkeit funktionaler Kohärenz und Stabilisierung.',
    'Axiom A5 setzt Axiom A1 bis Axiom A4 voraus, ist aus deren gemeinsamer Geltung jedoch nicht ableitbar. Eine Organisation kann entstehen und unter jeder weiteren Transformation vollständig zerfallen.',
    'Das Axiom ist mit Axiom A1 bis Axiom A4 vereinbar, weil es weder vollständige Unveränderlichkeit noch ein konkretes Kohärenzmaß fordert, sondern ausschließlich die Möglichkeit funktionalen Erhalts und funktionaler Reproduktion ergänzt.',
    'In Kapitel 3.4 werden mathematische Kriterien funktionaler Kohärenz, Erhaltung und Stabilisierung rekonstruiert. Metriken, Korrelationen, Normen, Attraktoren, Fixpunkte oder Lyapunov-Funktionen werden nicht axiomatisch vorweggenommen.',
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

SET @axiom_a5_id := NULL;

SELECT `axiom_id`
INTO @axiom_a5_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A5' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   12. Axiomabhängigkeiten
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a5_id;

INSERT INTO `axiom_dependencies`
(
    `axiom_id`,
    `depends_on_axiom_id`,
    `dependency_type`,
    `note`
)
VALUES
(
    @axiom_a5_id,
    @axiom_a1_id,
    'depends_on',
    'Kohärenz und Stabilisierung setzen funktional unterscheidbare Zuständlichkeit voraus.'
),
(
    @axiom_a5_id,
    @axiom_a2_id,
    'depends_on',
    'Kohärenz bezieht sich auf funktionale Zusammenhänge und setzt Relationierbarkeit voraus.'
),
(
    @axiom_a5_id,
    @axiom_a3_id,
    'depends_on',
    'Kohärenz wird als Erhalt unter Transformation verstanden und setzt Transformierbarkeit voraus.'
),
(
    @axiom_a5_id,
    @axiom_a4_id,
    'depends_on',
    'Kohärenz und Stabilisierung setzen eine funktionale Organisation voraus, deren Zusammenhang erhalten oder reproduziert werden kann.'
)
ON DUPLICATE KEY UPDATE
    `note` = VALUES(`note`);

/* -------------------------------------------------------------------------------------------------
   13. Objekt-Quellen-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE `object_type` = 'axiom'
  AND `object_id` = @axiom_a5_id
  AND `source_id` IN (@source_12_id, @source_13_id, @source_87_id);

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
    @axiom_a5_id,
    @source_12_id,
    'supporting_source',
    'Haken dient als Forschungsanschluss für dynamische Ordnungsbildung und Stabilisierung. Axiom A5 übernimmt kein konkretes synergetisches Modell.'
),
(
    'axiom',
    @axiom_a5_id,
    @source_13_id,
    'supporting_source',
    'Prigogine und Stengers dienen als Forschungsanschluss für den Erhalt dissipativer Strukturen. Axiom A5 setzt keine thermodynamischen Randbedingungen voraus.'
),
(
    'axiom',
    @axiom_a5_id,
    @source_87_id,
    'supporting_source',
    'Maturana und Varela dienen als Forschungsanschluss für organisatorische Reproduktion. Axiom A5 übernimmt keine biologische Autopoiesisdefinition.'
);

DELETE FROM `object_source_links`
WHERE `object_type` = 'definition'
  AND `object_id` IN (@definition_coherence_id, @definition_stabilization_id)
  AND `source_id` IN (@source_12_id, @source_13_id, @source_87_id);

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
    @definition_coherence_id,
    @source_87_id,
    'supporting_source',
    'Forschungsanschluss zur Reproduktion organisatorischer Zusammenhänge. Die qualitative FRZK-Definition funktionaler Kohärenz ist originär.'
),
(
    'definition',
    @definition_stabilization_id,
    @source_12_id,
    'supporting_source',
    'Forschungsanschluss zu dynamischer Stabilisierung. Die qualitative Definition funktionaler Stabilisierung bleibt allgemeiner als konkrete synergetische Stabilitätsmodelle.'
),
(
    'definition',
    @definition_stabilization_id,
    @source_13_id,
    'supporting_source',
    'Forschungsanschluss zur Aufrechterhaltung geordneter Strukturen unter fortlaufenden Prozessen. Keine thermodynamische Definition wird übernommen.'
);

/* -------------------------------------------------------------------------------------------------
   14. Gleichungen (3.291) bis (3.294)
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`,
    `plain_description`, `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`, `created_revision_id`
)
VALUES
(
    '3.291',
    @section_id,
    'Axiom A5 – komprimierte axiomatische Schreibweise',
    'A_5:\\quad\\text{Funktionale Organisation ist prinzipiell kohärenz- und stabilisierungsfähig.}',
    'A_5:\\quad\\text{Funktionale Organisation ist prinzipiell kohärenz- und stabilisierungsfähig.}',
    'Komprimierte qualitative Formulierung des fünften FRZK-Axioms. Sie führt kein mathematisches Kohärenzmaß und kein konkretes Stabilitätskriterium ein.',
    'axiom',
    'original',
    NULL,
    'Originäre axiomatische Setzung auf Grundlage funktionaler Organisationsbildung.',
    'Axiom A1 bis Axiom A4 werden vorausgesetzt.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `equation_latex`=VALUES(`equation_latex`),
    `word_latex`=VALUES(`word_latex`),
    `plain_description`=VALUES(`plain_description`),
    `equation_type`=VALUES(`equation_type`),
    `provenance`=VALUES(`provenance`),
    `source_id`=VALUES(`source_id`),
    `derivation`=VALUES(`derivation`),
    `assumptions`=VALUES(`assumptions`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(
    `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`,
    `plain_description`, `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`, `created_revision_id`
)
VALUES
(
    '3.292',
    @section_id,
    'Qualitative Abhängigkeit von Axiom A5 von Axiom A1 bis Axiom A4',
    'A_5\\;\\Longrightarrow\\;A_1\\land A_2\\land A_3\\land A_4',
    'A_5\\Longrightarrow A_1\\land A_2\\land A_3\\land A_4',
    'Qualitative axiomatische Abhängigkeit: Kohärenz und Stabilisierung benötigen unterscheidbare, relationierbare, transformierbare und organisationsbildende Zuständlichkeit.',
    'schema',
    'original',
    NULL,
    'Axiom A5 kann nur auf bereits gebildete funktionale Organisation angewendet werden.',
    'Die Darstellung ist noch kein vollständig formalisierter Beweis.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `equation_latex`=VALUES(`equation_latex`),
    `word_latex`=VALUES(`word_latex`),
    `plain_description`=VALUES(`plain_description`),
    `equation_type`=VALUES(`equation_type`),
    `provenance`=VALUES(`provenance`),
    `source_id`=VALUES(`source_id`),
    `derivation`=VALUES(`derivation`),
    `assumptions`=VALUES(`assumptions`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(
    `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`,
    `plain_description`, `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`, `created_revision_id`
)
VALUES
(
    '3.293',
    @section_id,
    'Qualitative Nichtableitbarkeit von Axiom A5 aus Axiom A1 bis Axiom A4',
    'A_1\\land A_2\\land A_3\\land A_4\\;\\not\\Longrightarrow\\;A_5',
    'A_1\\land A_2\\land A_3\\land A_4\\not\\Longrightarrow A_5',
    'Qualitative Aussage, dass Organisationsbildung allein noch keinen Erhalt oder keine Reproduktion unter weiterer Transformation begründet.',
    'schema',
    'original',
    NULL,
    'Ein begriffliches Modell mit Organisationsmustern, die unter jeder weiteren Transformation vollständig zerfallen, zeigt die eigenständige Rolle von Axiom A5.',
    'Die Aussage ist noch kein vollständiger modelltheoretischer Unabhängigkeitsbeweis.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `equation_latex`=VALUES(`equation_latex`),
    `word_latex`=VALUES(`word_latex`),
    `plain_description`=VALUES(`plain_description`),
    `equation_type`=VALUES(`equation_type`),
    `provenance`=VALUES(`provenance`),
    `source_id`=VALUES(`source_id`),
    `derivation`=VALUES(`derivation`),
    `assumptions`=VALUES(`assumptions`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(
    `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`,
    `plain_description`, `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`, `created_revision_id`
)
VALUES
(
    '3.294',
    @section_id,
    'Gemeinsame qualitative Reichweite der Axiome A1 bis A5',
    'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\;\\Longrightarrow\\;\\text{unterscheidbare, relationierbare, transformierbare, organisations- und kohärenzfähige Zuständlichkeit}',
    'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\text{unterscheidbare, relationierbare, transformierbare, organisations- und kohärenzfähige Zuständlichkeit}',
    'Qualitative Zusammenfassung der gemeinsamen Reichweite des vollständigen FRZK-Axiomensystems.',
    'schema',
    'original',
    NULL,
    'Zusammenführung der qualitativen Reichweite von Axiom A1 bis Axiom A5.',
    'Es wird noch keine mathematische Gesamttheorie oder konkrete Raum-Zeit-Struktur behauptet.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `equation_latex`=VALUES(`equation_latex`),
    `word_latex`=VALUES(`word_latex`),
    `plain_description`=VALUES(`plain_description`),
    `equation_type`=VALUES(`equation_type`),
    `provenance`=VALUES(`provenance`),
    `source_id`=VALUES(`source_id`),
    `derivation`=VALUES(`derivation`),
    `assumptions`=VALUES(`assumptions`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

SET @eq_3291 := NULL;
SET @eq_3292 := NULL;
SET @eq_3293 := NULL;
SET @eq_3294 := NULL;

SELECT `equation_id` INTO @eq_3291 FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci='3.291' COLLATE utf8mb4_unicode_ci LIMIT 1;

SELECT `equation_id` INTO @eq_3292 FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci='3.292' COLLATE utf8mb4_unicode_ci LIMIT 1;

SELECT `equation_id` INTO @eq_3293 FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci='3.293' COLLATE utf8mb4_unicode_ci LIMIT 1;

SELECT `equation_id` INTO @eq_3294 FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci='3.294' COLLATE utf8mb4_unicode_ci LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   15. Gleichungssymbole
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3291,@eq_3292,@eq_3293,@eq_3294);

INSERT INTO `equation_symbols`
(
    `equation_id`, `symbol_latex`, `symbol_name`, `definition_text`,
    `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_3291,'A_5','Axiom A5','Bezeichnung des fünften FRZK-Axioms der funktionalen Kohärenz und Stabilisierung.',NULL,'qualitative FRZK-Axiomatik',1),

(@eq_3292,'A_5','Axiom A5','Bezeichnung des Axioms der funktionalen Kohärenz und Stabilisierung.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3292,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet die qualitative axiomatische Abhängigkeit von A5.',NULL,'qualitative axiomatische Abhängigkeit',2),
(@eq_3292,'A_1','Axiom A1','Bezeichnung des ersten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3292,'\\land','logische Konjunktion','Verknüpft die vorausgesetzten Axiome.',NULL,'qualitative logische Verknüpfung',4),
(@eq_3292,'A_2','Axiom A2','Bezeichnung des zweiten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3292,'A_3','Axiom A3','Bezeichnung des dritten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',6),
(@eq_3292,'A_4','Axiom A4','Bezeichnung des vierten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',7),

(@eq_3293,'A_1','Axiom A1','Bezeichnung des ersten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3293,'\\land','logische Konjunktion','Verknüpft die Axiome A1 bis A4.',NULL,'qualitative logische Verknüpfung',2),
(@eq_3293,'A_2','Axiom A2','Bezeichnung des zweiten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3293,'A_3','Axiom A3','Bezeichnung des dritten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3293,'A_4','Axiom A4','Bezeichnung des vierten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3293,'\\not\\Longrightarrow','qualitativer Nichtableitungspfeil','Kennzeichnet die qualitative Nichtableitbarkeit von A5 aus A1 bis A4.',NULL,'qualitative axiomatische Nichtableitbarkeit',6),
(@eq_3293,'A_5','Axiom A5','Bezeichnung des fünften FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',7),

(@eq_3294,'A_1','Axiom A1','Bezeichnung des ersten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3294,'\\land','logische Konjunktion','Verknüpft Axiom A1 bis Axiom A5.',NULL,'qualitative logische Verknüpfung',2),
(@eq_3294,'A_2','Axiom A2','Bezeichnung des zweiten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3294,'A_3','Axiom A3','Bezeichnung des dritten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3294,'A_4','Axiom A4','Bezeichnung des vierten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3294,'A_5','Axiom A5','Bezeichnung des fünften FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',6),
(@eq_3294,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet die gemeinsame qualitative Reichweite des vollständigen Axiomensystems.',NULL,'qualitative axiomatische Zusammenfassung',7)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   16. Abschnittssymbole
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
    'A_5',
    'A_5',
    'Axiom A5',
    'Bezeichnung des fünften FRZK-Axioms der funktionalen Kohärenz und Stabilisierung.',
    'section',
    @section_id,
    @eq_3291,
    NULL,
    'qualitative FRZK-Axiomatik',
    'qualitative FRZK-Axiomatik',
    0,0,0,
    'Kein mathematisches Objekt und kein Kohärenzmaß.',
    'checked',
    @revision_id
),
(
    '\\not\\Longrightarrow',
    '\\not\\Longrightarrow',
    'qualitativer Nichtableitungspfeil',
    'Kennzeichnet die qualitative Nichtableitbarkeit von Axiom A5 aus Axiom A1 bis Axiom A4.',
    'section',
    @section_id,
    @eq_3293,
    NULL,
    'qualitative axiomatische Nichtableitbarkeit',
    'qualitative axiomatische Nichtableitbarkeit',
    0,0,0,
    'Kein abgeschlossener modelltheoretischer Unabhängigkeitsbeweis.',
    'checked',
    @revision_id
),
(
    '\\land',
    '\\land',
    'logische Konjunktion',
    'Logisches Und zur qualitativen Verknüpfung der Axiome A1 bis A5.',
    'section',
    @section_id,
    @eq_3292,
    NULL,
    'qualitative logische Aussagen',
    'qualitative logische Aussagen',
    0,0,0,
    'Dient ausschließlich der komprimierten Darstellung.',
    'checked',
    @revision_id
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
   17. Änderungsprotokoll
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log`
(
    `revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,
    `change_summary`,`previous_value`,`new_value`
)
VALUES
(
    @revision_id,@section_id,'rewritten','section','3.3.6',
    'Abschnitt 3.3.6 wurde vollständig als Formulierung und Begründung von Axiom A5 neu gefasst.',
    'Älterer Planungsstand.',
    'Axiom A5 – Funktionale Kohärenz und Stabilisierung.'
),
(
    @revision_id,@section_id,'source_added','sources','[87]',
    'Maturana und Varela wurden mit Autopoiesis and Cognition als neue Quelle [87] registriert.',
    NULL,
    'Neue Quelle einschließlich Autoren, Annotation, Erstverwendung und Objektverknüpfung.'
),
(
    @revision_id,@section_id,'source_reused','source_usage','[12], [13]',
    'Haken sowie Prigogine und Stengers wurden als Forschungsanschlüsse wiederverwendet.',
    NULL,
    'Zwei geprüfte Wiederverwendungen.'
),
(
    @revision_id,@section_id,'definition_added','definitions','Def. 3.3.6.1–Def. 3.3.6.2',
    'Die qualitativen Begriffe funktionale Kohärenz und funktionale Stabilisierung wurden registriert.',
    NULL,
    'Zwei originäre FRZK-Definitionen.'
),
(
    @revision_id,@section_id,'axiom_added','axioms','A5',
    'Axiom A5 wurde einschließlich Motivation, Konsistenz-, Unabhängigkeits- und Operationalisierungshinweis registriert.',
    NULL,
    'A5 – Funktionale Kohärenz und Stabilisierung.'
),
(
    @revision_id,@section_id,'equation_added','equations','(3.291)–(3.294)',
    'Vier qualitative axiomatische Darstellungen wurden vollständig registriert.',
    NULL,
    'Axiom A5, Abhängigkeit, Nichtableitbarkeit und gemeinsame Reichweite von A1 bis A5.'
),
(
    @revision_id,@section_id,'symbol_added','symbols','A_5, \\not\\Longrightarrow, \\land',
    'Die neuen abschnittsspezifischen Symbole wurden registriert.',
    NULL,
    'Drei Abschnittssymbole.'
),
(
    @revision_id,@section_id,'status_changed','section','3.3.6',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   18. Repository-Zähler
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section','3.3.6'),
    ('last_repository_revision','RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1'),
    ('next_citation_number','88'),
    ('next_equation_number','3.295')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* =================================================================================================
   19. AUDIT
   ================================================================================================= */

SELECT
    r.`revision_code`,
    p.`revision_code` AS `parent_revision_code`,
    r.`scope_reference`,
    r.`version_label`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p
    ON p.`revision_id`=r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci
      =
      'RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    p.`section_code` AS `parent_section_code`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` p
    ON p.`section_id`=ds.`parent_section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.6' COLLATE utf8mb4_unicode_ci;

SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`subtitle`,
    s.`publisher`,
    s.`place`,
    s.`year_edition`,
    s.`verification_status`,
    a.`normalized_name`,
    sa.`author_order`,
    sa.`role`
FROM `sources` s
LEFT JOIN `source_authors` sa ON sa.`source_id`=s.`source_id`
LEFT JOIN `authors` a ON a.`author_id`=sa.`author_id`
WHERE s.`citation_number`=87
ORDER BY sa.`author_order`;

SELECT
    s.`citation_number`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`claim_summary`
FROM `source_usage` su
JOIN `sources` s ON s.`source_id`=su.`source_id`
WHERE su.`section_id`=@section_id
ORDER BY s.`citation_number`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`section_id`=@section_id
ORDER BY d.`definition_number`;

SELECT
    ax.`axiom_number`,
    ax.`title`,
    ax.`status`,
    ax.`source_assumption_id`,
    rr.`revision_code`
FROM `axioms` ax
LEFT JOIN `repository_revisions` rr
    ON rr.`revision_id`=ax.`created_revision_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A5' COLLATE utf8mb4_unicode_ci;

SELECT
    ax.`axiom_number`,
    parent_ax.`axiom_number` AS `depends_on_axiom`,
    ad.`dependency_type`,
    ad.`note`
FROM `axiom_dependencies` ad
JOIN `axioms` ax ON ax.`axiom_id`=ad.`axiom_id`
JOIN `axioms` parent_ax ON parent_ax.`axiom_id`=ad.`depends_on_axiom_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A5' COLLATE utf8mb4_unicode_ci
ORDER BY parent_ax.`axiom_number`;

SELECT
    osl.`object_type`,
    s.`citation_number`,
    osl.`usage_type`,
    osl.`note`
FROM `object_source_links` osl
JOIN `sources` s ON s.`source_id`=osl.`source_id`
WHERE
    (
        (osl.`object_type`='axiom' AND osl.`object_id`=@axiom_a5_id)
        OR
        (osl.`object_type`='definition'
         AND osl.`object_id` IN (@definition_coherence_id,@definition_stabilization_id))
    )
ORDER BY osl.`object_type`,s.`citation_number`;

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_type`,
    e.`validation_status`,
    CASE
        WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`)=''
        THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND e.`equation_number` IN ('3.291','3.292','3.293','3.294')
ORDER BY e.`equation_number`;

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id
  AND e.`equation_number` IN ('3.291','3.292','3.293','3.294')
ORDER BY e.`equation_number`,es.`symbol_order`;

SELECT
    sy.`symbol_latex`,
    sy.`symbol_name`,
    sy.`scope_type`,
    sy.`validation_status`,
    e.`equation_number` AS `first_equation_number`
FROM `symbols` sy
LEFT JOIN `equations` e ON e.`equation_id`=sy.`first_equation_id`
WHERE sy.`first_section_id`=@section_id
ORDER BY sy.`symbol_latex`;

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

SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*)>1;

SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`,`symbol_latex`
HAVING COUNT(*)>1;

SELECT
    `equation_number`,
    `title`
FROM `equations`
WHERE `section_id`=@section_id
  AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');

SELECT
    'source_usage' AS `table_name`,
    CAST(`usage_id` AS CHAR) AS `row_id`,
    `usage_type` AS `enum_value`
FROM `source_usage`
WHERE `section_id`=@section_id
  AND (`usage_type` IS NULL OR TRIM(`usage_type`)='')

UNION ALL

SELECT
    'section_change_log',
    CAST(`change_id` AS CHAR),
    `change_type`
FROM `section_change_log`
WHERE `section_id`=@section_id
  AND (`change_type` IS NULL OR TRIM(`change_type`)='')

UNION ALL

SELECT
    'object_source_links',
    CAST(`object_source_link_id` AS CHAR),
    `usage_type`
FROM `object_source_links`
WHERE
    (
        (`object_type`='axiom' AND `object_id`=@axiom_a5_id)
        OR
        (`object_type`='definition'
         AND `object_id` IN (@definition_coherence_id,@definition_stabilization_id))
    )
  AND (`usage_type` IS NULL OR TRIM(`usage_type`)='');

SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id`=@revision_id
  AND scl.`section_id`=@section_id
ORDER BY scl.`change_id`;

SELECT
    'Repository-Update 3.3.6 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [88], Gleichung (3.295), letzte Revision RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1.'
AS `result`;
