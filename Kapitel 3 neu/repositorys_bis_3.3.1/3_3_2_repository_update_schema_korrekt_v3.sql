/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.2 – SCHEMAKORREKT V3

   Abschnitt:
     3.3.2 Axiom A1 – Existenz funktionaler Zustände

   Verbindlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.1-NEUFASSUNG-V2
     letzte Literaturquelle:      [85]
     nächste Literaturquelle:     [86]
     letzte Gleichung:            (3.276)
     nächste Gleichungen:         (3.277), (3.278)

   Konsistenzanpassung gegenüber V1:
     - Parent-Revision auf die vollständige 3.3.1-V2 angehoben
     - eigene Abschnittsrevision auf V2 angehoben
     - Literatur-, Gleichungs-, Definitions- und Axiomnummern unverändert

   Durch dieses Skript erzeugter Stand:
     neue Literaturquelle:        [86]
     nächste Literaturquelle:     [87]
     neue Gleichungen:            (3.277), (3.278)
     nächste Gleichung:           (3.279)
     neue Revision:               RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3

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
     - object_source_links
     - equations
     - equation_symbols
     - symbols
     - section_change_log
     - repository_counters
     - Audit- und Kontrollabfragen

   SQL-Dialekt:
     MariaDB / MySQL

   Eigenschaften:
     - vollständig
     - transaktional
     - idempotent
     - phpMyAdmin-kompatibel
     - utf8mb4_unicode_ci
     - keine Platzhalter
     - keine Gleichsetzung von citation_number und source_id
     - Parent-Revision wird vor dem INSERT geladen
     - keine Annahme-ID wird erfunden; NULL-fähige FK-Spalte wird schemaentsprechend genutzt
     - erkannte leere ENUM-Altwerte aus 3.3.1 werden repariert
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Parent-Revision laden und als zwingende Vorbedingung prüfen
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.1-NEUFASSUNG-V2' USING utf8mb4)
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
   Harte Vorbedingung ohne Stored Procedure und ohne DELIMITER:
   Ist @parent_revision_id NULL, verletzt das INSERT die NOT-NULL-Bedingung
   und der Import wird kontrolliert abgebrochen.
*/
DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_332`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_332`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_332` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_332`;

/* -------------------------------------------------------------------------------------------------
   2. Neue Abschnittsrevision idempotent registrieren
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3' USING utf8mb4)
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
    '3.3.2',
    'V3',
    'Vollständige schemaorientierte Neufassung und konsistente Neuverkettung von Abschnitt 3.3.2: Axiom A1 – Existenz funktionaler Zustände. Registriert werden die qualitative Definition eines funktionalen Zustandes, das originäre Axiom A1, Quelle [86] George Spencer-Brown, die Gleichungen (3.277) und (3.278), Gleichungssymbole, Abschnittssymbole, Quellenverwendungen, Änderungsprotokoll und Repository-Zähler.',
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
   3. Kapitel 3.3 und Abschnitt 3.3.2 auflösen bzw. aktualisieren
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_332`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_332`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_332` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_332`;

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
    '3.3.2',
    'Axiom A1 – Existenz funktionaler Zustände',
    3,
    3.3003,
    'review',
    1,
    'Erstes originäres FRZK-Axiom. Der funktionale Zustand ist in Kapitel 3.3 noch kein Element eines mathematischen Zustandsraumes, sondern eine qualitative, prinzipiell funktional unterscheidbare Konfiguration. Die mathematische Rekonstruktion erfolgt erst in Kapitel 3.4.'
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
      '3.3.2' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   4. Neue Quelle [86]: George Spencer-Brown
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
    'Spencer-Brown',
    'George',
    'Spencer-Brown, George',
    NULL,
    1923,
    2016,
    'Britischer Logiker und Autor von Laws of Form. In Abschnitt 3.3.2 ausschließlich als wissenschaftshistorischer und begrifflicher Anschluss zur grundlegenden Rolle der Unterscheidung verwendet.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `orcid`       = VALUES(`orcid`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

SET @author_86_id := NULL;

SELECT `author_id`
INTO @author_86_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Spencer-Brown, George' COLLATE utf8mb4_unicode_ci
LIMIT 1;

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
    86,
    'spencer_brown_laws_form_1969',
    'book',
    'Laws of Form',
    NULL,
    1969,
    1969,
    NULL,
    'George Allen & Unwin',
    'London',
    NULL,
    NULL,
    NULL,
    'First edition',
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    8,
    'verified',
    '3.3.2',
    'Erstnennung zur erkenntnistheoretischen und formalen Bedeutung eines ursprünglichen Unterscheidungsvollzugs. Das FRZK übernimmt weder den Kalkül noch Spencer-Browns konkrete Markierungsform.',
    'Spencer-Brown, George: Laws of Form. London: George Allen & Unwin, 1969.',
    'Spencer-Brown [86]',
    'Die Quelle dient der wissenschaftlichen Einordnung der Unterscheidung als notwendiger Voraussetzung weiterer Formbildung. Axiom A1 bleibt eine originäre FRZK-Setzung.',
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

SET @source_86_id := NULL;

SELECT `source_id`
INTO @source_86_id
FROM `sources`
WHERE `citation_number` = 86
LIMIT 1;

INSERT INTO `source_authors`
(
    `source_id`,
    `author_id`,
    `author_order`,
    `role`
)
VALUES
(
    @source_86_id,
    @author_86_id,
    1,
    'author'
)
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

/* -------------------------------------------------------------------------------------------------
   5. Wissenschaftliche Annotation der Quelle [86]
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
    @source_86_id,
    'Spencer-Brown entwickelt einen formalen Kalkül, dessen Ausgangspunkt der Vollzug einer Unterscheidung und die daraus entstehende Markierung ist.',
    'Die Quelle bietet einen wichtigen wissenschaftshistorischen und begrifflichen Anschluss für die in Axiom A1 vorausgesetzte fundamentale Rolle funktionaler Unterscheidbarkeit.',
    'Die Quelle wird verwendet, um zu zeigen, dass wissenschaftliche Ansätze existieren, die Formbildung nicht mit fertigen Objekten, sondern mit Unterscheidung beginnen.',
    'Übernommen wird ausschließlich die allgemeine Einsicht, dass ohne Unterscheidung keine weitere Form- oder Strukturbildung möglich ist.',
    'Nicht übernommen werden Spencer-Browns Kalkül, seine konkrete Markierungsoperation, seine Notation oder eine Gleichsetzung des FRZK mit Laws of Form.',
    'Axiom A1 ist keine Adaptation des Kalküls. Das FRZK setzt nur die Möglichkeit funktionaler Unterscheidbarkeit voraus und vermeidet in Kapitel 3.3 bereits eine formale Operation, einen Wirkungsbereich oder ein Ergebnis zu postulieren.',
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
    @source_86_id,
    @section_id,
    'first_citation',
    'Spencer-Brown wird zur wissenschaftlichen Einordnung der Unterscheidung als Ausgangspunkt von Formbildung herangezogen. Der Text grenzt das FRZK ausdrücklich von Spencer-Browns Kalkül und konkreter Markierungsoperation ab.',
    '3.3.2, Absatz unmittelbar vor der Formulierung von Axiom A1',
    1,
    1,
    'Erstnennung der Quelle [86]. Die Quelle begründet nicht das originäre Axiom, sondern dokumentiert einen relevanten Forschungsanschluss.',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   7. Herkunft aus der Forschungslücke

   Die reale Datenbank enthält zwar die Tabelle `assumptions`, im bereitgestellten Dump jedoch
   keinen Datensatz mit `assumption_number = 'A-3.2-1'`. Die Spalte
   `axioms.source_assumption_id` ist laut Schema NULL-fähig und besitzt ON DELETE SET NULL.
   Deshalb wird für Axiom A1 bewusst kein künstlicher oder erfundener Annahmedatensatz erzeugt.
   Die inhaltliche Herkunft aus der Forschungslücke wird vollständig in Motivation,
   Konsistenzhinweis und Operationalisierungsnotiz des Axioms dokumentiert.
   ------------------------------------------------------------------------------------------------- */

SET @assumption_a1_id := NULL;

/* -------------------------------------------------------------------------------------------------
   8. Qualitative Definition des funktionalen Zustandes
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
    'Def. 3.3.2.1',
    @section_id,
    'Funktionaler Zustand',
    'Ein funktionaler Zustand ist in Kapitel 3.3 eine qualitative Konfiguration, die aufgrund ihrer möglichen Wirkungen prinzipiell von einer anderen funktionalen Konfiguration unterscheidbar sein kann. Er ist noch kein Element eines mathematischen Zustandsraumes und besitzt weder Koordinaten, Dimension, Metrik, räumliche Lage noch zeitliche Position.',
    NULL,
    NULL,
    'original',
    NULL,
    'Die primitiven Begriffe Funktionalität und Unterscheidbarkeit aus Abschnitt 3.3.1 sind vorausgesetzt.',
    'Diese Definition präzisiert den Sprachgebrauch des Abschnitts, ohne die mathematische Rekonstruktion funktionaler Zustände in Kapitel 3.4 vorwegzunehmen.',
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

/* -------------------------------------------------------------------------------------------------
   9. Originäres FRZK-Axiom A1 registrieren
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
    'A1',
    @section_id,
    'Existenz funktionaler Zustände',
    'Es existiert mindestens eine funktionale Konfiguration, die prinzipiell von einer anderen funktionalen Konfiguration unterscheidbar sein kann.',
    'A_1:\\quad\\text{Mindestens ein funktional unterscheidbarer Zustand ist möglich.}',
    'A_1:\\quad\\text{Mindestens ein funktional unterscheidbarer Zustand ist möglich.}',
    'Ohne die Möglichkeit funktionaler Unterscheidbarkeit können weder Relationierbarkeit noch Transformation, Organisation oder Kohärenz sinnvoll formuliert werden. Das Axiom setzt weder materielle Existenz noch Raum, Zeit, Menge oder Zustandsraum voraus.',
    'Axiom A1 besitzt keinen Rückgriff auf ein früheres FRZK-Axiom. Seine modelltheoretische Unabhängigkeit von A2 bis A5 wird erst in Abschnitt 3.3.8 geprüft. In Abschnitt 3.3.2 wird ausschließlich seine begriffliche Vorrangstellung behauptet.',
    'Das Axiom enthält keine Existenzquantifizierung über einer bereits definierten Menge. Es postuliert eine qualitative Möglichkeit und vermeidet dadurch einen Zirkelschluss mit der späteren Konstruktion mathematischer Zustände.',
    'In Kapitel 3.4 wird aus Axiom A1 zunächst eine funktionale Differenz- beziehungsweise Zustandsstruktur rekonstruiert. Die axiomatische Aussage selbst enthält keine Metrik, Koordinate, Dimension oder Zeitordnung.',
    @assumption_a1_id,
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

SET @axiom_a1_id := NULL;

SELECT `axiom_id`
INTO @axiom_a1_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/*
   Axiom A1 besitzt keine Abhängigkeit von einem vorhergehenden Axiom.
   Eventuelle Altartefakte einer früheren Kapitelstruktur werden deshalb entfernt.
*/
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a1_id;

/* -------------------------------------------------------------------------------------------------
   10. Gleichung (3.277): komprimierte axiomatische Schreibweise
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
    '3.277',
    @section_id,
    'Axiom A1 – komprimierte axiomatische Schreibweise',
    'A_1:\\quad\\text{Mindestens ein funktional unterscheidbarer Zustand ist möglich.}',
    'A_1:\\quad\\text{Mindestens ein funktional unterscheidbarer Zustand ist möglich.}',
    'Komprimierte qualitative Formulierung des ersten FRZK-Axioms. Sie ist keine Existenzquantifizierung über einer bereits definierten Menge und führt noch keinen mathematischen Zustandsraum ein.',
    'axiom',
    'original',
    NULL,
    'Die Aussage folgt als originäre axiomatische Setzung aus der in Kapitel 3.2 identifizierten Notwendigkeit, die Entstehung funktionaler Zustände ohne deren primitive mathematische Voraussetzung zu erklären.',
    'Funktionalität und Unterscheidbarkeit werden ausschließlich in der qualitativen Bedeutung aus Abschnitt 3.3.1 verwendet.',
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

SET @equation_3277_id := NULL;

SELECT `equation_id`
INTO @equation_3277_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.277' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   11. Gleichung (3.278): qualitative Abhängigkeit der späteren Axiome
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
    '3.278',
    @section_id,
    'Qualitative Abhängigkeit der späteren Axiome von Axiom A1',
    '\\neg A_1\\;\\Longrightarrow\\;\\neg\\!\\left(A_2\\lor A_3\\lor A_4\\lor A_5\\right)',
    '\\neg A_1\\Longrightarrow\\neg\\left(A_2\\lor A_3\\lor A_4\\lor A_5\\right)',
    'Qualitative Abhängigkeitsaussage: Wird die Möglichkeit funktionaler Unterscheidbarkeit ausgeschlossen, fehlt den späteren Axiomen ihre Anwendungsgrundlage. Die Darstellung ist noch kein formal bewiesener Satz eines vollständig spezifizierten logischen Kalküls.',
    'schema',
    'original',
    NULL,
    'Ohne funktional unterscheidbare Konfigurationen können Relationierbarkeit, Transformation, Organisation und Kohärenz nicht sinnvoll formuliert werden.',
    'A1 bis A5 werden als Bezeichnungen der FRZK-Axiome verwendet; ihre formale Unabhängigkeit wird erst in Abschnitt 3.3.8 untersucht.',
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

SET @equation_3278_id := NULL;

SELECT `equation_id`
INTO @equation_3278_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.278' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   12. Gleichungssymbole vollständig neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@equation_3277_id, @equation_3278_id);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3277_id,
    'A_1',
    'Axiom A1',
    'Bezeichnung des ersten FRZK-Axioms: Existenz mindestens eines prinzipiell funktional unterscheidbaren Zustandes.',
    NULL,
    'qualitative FRZK-Axiomatik',
    1
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    '\\neg',
    'Negation',
    'Logisches Negationszeichen. In Gleichung (3.278) kennzeichnet es das Ausschließen der jeweils bezeichneten axiomatischen Möglichkeit.',
    NULL,
    'qualitative logische Abhängigkeitsaussage',
    1
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    '\\Longrightarrow',
    'qualitativer Folgerungspfeil',
    'Kennzeichnet eine qualitative axiomatische Abhängigkeit, noch keinen formal bewiesenen Satz.',
    NULL,
    'qualitative logische Abhängigkeitsaussage',
    2
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    '\\lor',
    'logische Disjunktion',
    'Verknüpft die späteren Axiombezeichnungen A2 bis A5 im Sinne einer qualitativen Alternativenmenge.',
    NULL,
    'qualitative logische Abhängigkeitsaussage',
    3
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    'A_1',
    'Axiom A1',
    'Bezeichnung des ersten FRZK-Axioms.',
    NULL,
    'qualitative FRZK-Axiomatik',
    4
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    'A_2',
    'Axiom A2',
    'Bezeichnung des nachfolgenden Axioms der funktionalen Relationierbarkeit.',
    NULL,
    'qualitative FRZK-Axiomatik',
    5
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    'A_3',
    'Axiom A3',
    'Bezeichnung des späteren Axioms der Transformation.',
    NULL,
    'qualitative FRZK-Axiomatik',
    6
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    'A_4',
    'Axiom A4',
    'Bezeichnung des späteren Axioms der funktionalen Organisation beziehungsweise Kohärenzbildung.',
    NULL,
    'qualitative FRZK-Axiomatik',
    7
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @equation_3278_id,
    'A_5',
    'Axiom A5',
    'Bezeichnung des späteren Axioms der Emergenz funktionaler Organisation.',
    NULL,
    'qualitative FRZK-Axiomatik',
    8
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   13. Abschnittssymbole registrieren
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `symbols`
(
    `symbol_latex`,
    `symbol_word_latex`,
    `symbol_name`,
    `definition_text`,
    `scope_type`,
    `first_section_id`,
    `first_equation_id`,
    `unit_text`,
    `domain_text`,
    `codomain_text`,
    `is_vector`,
    `is_matrix`,
    `is_operator`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    'A_1',
    'A_1',
    'Axiom A1',
    'Bezeichnung des ersten FRZK-Axioms zur Existenz mindestens eines prinzipiell funktional unterscheidbaren Zustandes.',
    'section',
    @section_id,
    @equation_3277_id,
    NULL,
    'qualitative FRZK-Axiomatik',
    'qualitative FRZK-Axiomatik',
    0,
    0,
    0,
    'Kein mathematisches Objekt und keine Variable eines Zustandsraumes.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `symbol_word_latex`   = VALUES(`symbol_word_latex`),
    `symbol_name`         = VALUES(`symbol_name`),
    `definition_text`     = VALUES(`definition_text`),
    `first_equation_id`   = VALUES(`first_equation_id`),
    `unit_text`           = VALUES(`unit_text`),
    `domain_text`         = VALUES(`domain_text`),
    `codomain_text`       = VALUES(`codomain_text`),
    `is_vector`           = VALUES(`is_vector`),
    `is_matrix`           = VALUES(`is_matrix`),
    `is_operator`         = VALUES(`is_operator`),
    `notes`               = VALUES(`notes`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

INSERT INTO `symbols`
(
    `symbol_latex`,
    `symbol_word_latex`,
    `symbol_name`,
    `definition_text`,
    `scope_type`,
    `first_section_id`,
    `first_equation_id`,
    `unit_text`,
    `domain_text`,
    `codomain_text`,
    `is_vector`,
    `is_matrix`,
    `is_operator`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '\\neg',
    '\\neg',
    'Negation',
    'Logisches Negationszeichen in der qualitativen Abhängigkeitsaussage (3.278).',
    'section',
    @section_id,
    @equation_3278_id,
    NULL,
    'qualitative logische Aussagen',
    'qualitative logische Aussagen',
    0,
    0,
    0,
    'Die mathematische Logik wird nicht als zusätzliche FRZK-Struktur rekonstruiert; die Notation dient der komprimierten Darstellung.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `symbol_word_latex`   = VALUES(`symbol_word_latex`),
    `symbol_name`         = VALUES(`symbol_name`),
    `definition_text`     = VALUES(`definition_text`),
    `first_equation_id`   = VALUES(`first_equation_id`),
    `unit_text`           = VALUES(`unit_text`),
    `domain_text`         = VALUES(`domain_text`),
    `codomain_text`       = VALUES(`codomain_text`),
    `is_vector`           = VALUES(`is_vector`),
    `is_matrix`           = VALUES(`is_matrix`),
    `is_operator`         = VALUES(`is_operator`),
    `notes`               = VALUES(`notes`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

INSERT INTO `symbols`
(
    `symbol_latex`,
    `symbol_word_latex`,
    `symbol_name`,
    `definition_text`,
    `scope_type`,
    `first_section_id`,
    `first_equation_id`,
    `unit_text`,
    `domain_text`,
    `codomain_text`,
    `is_vector`,
    `is_matrix`,
    `is_operator`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '\\lor',
    '\\lor',
    'logische Disjunktion',
    'Logisches Oder in der qualitativen Abhängigkeitsaussage (3.278).',
    'section',
    @section_id,
    @equation_3278_id,
    NULL,
    'qualitative logische Aussagen',
    'qualitative logische Aussagen',
    0,
    0,
    0,
    'Verknüpft die Axiombezeichnungen A2 bis A5; keine mengen- oder algebraische Operation.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `symbol_word_latex`   = VALUES(`symbol_word_latex`),
    `symbol_name`         = VALUES(`symbol_name`),
    `definition_text`     = VALUES(`definition_text`),
    `first_equation_id`   = VALUES(`first_equation_id`),
    `unit_text`           = VALUES(`unit_text`),
    `domain_text`         = VALUES(`domain_text`),
    `codomain_text`       = VALUES(`codomain_text`),
    `is_vector`           = VALUES(`is_vector`),
    `is_matrix`           = VALUES(`is_matrix`),
    `is_operator`         = VALUES(`is_operator`),
    `notes`               = VALUES(`notes`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   14. Quelle [86] als wissenschaftlicher Kontext mit Axiom A1 verknüpfen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE `object_type` = 'axiom'
  AND `object_id` = @axiom_a1_id
  AND `source_id` = @source_86_id;

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
    @axiom_a1_id,
    @source_86_id,
    'historical_context',
    'Spencer-Brown dient als Forschungsanschluss für die grundlegende Rolle der Unterscheidung. Axiom A1 bleibt eine originäre FRZK-Setzung und übernimmt weder Kalkül noch Markierungsoperation.'
);

/* -------------------------------------------------------------------------------------------------
   15. Abschnittsänderungsprotokoll vollständig neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log`
(
    `revision_id`,
    `section_id`,
    `change_type`,
    `object_type`,
    `object_reference`,
    `change_summary`,
    `previous_value`,
    `new_value`
)
VALUES
(
    @revision_id,
    @section_id,
    'rewritten',
    'section',
    '3.3.2',
    'Abschnitt 3.3.2 wurde vollständig als originäre Formulierung und wissenschaftstheoretische Begründung von Axiom A1 neu gefasst.',
    'Frühere Abschnittsstruktur beziehungsweise geplanter Altinhalt.',
    'Axiom A1 – Existenz funktionaler Zustände.'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'sources',
    '[86]',
    'George Spencer-Brown: Laws of Form wurde als neue Quelle [86] einschließlich Autor, Annotation und Erstverwendung registriert.',
    NULL,
    'Quelle [86], Autorverknüpfung, Annotation, source_usage und object_source_link.'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definitions',
    'Def. 3.3.2.1',
    'Der qualitative Begriff des funktionalen Zustandes wurde klar von einem mathematischen Zustand beziehungsweise Zustandsraumelement abgegrenzt.',
    NULL,
    'Def. 3.3.2.1 Funktionaler Zustand.'
),
(
    @revision_id,
    @section_id,
    'axiom_added',
    'axioms',
    'A1',
    'Axiom A1 wurde als originäres FRZK-Axiom einschließlich Motivation, Konsistenzhinweis, Unabhängigkeitshinweis und Operationalisierungsnotiz registriert.',
    NULL,
    'A1 – Existenz funktionaler Zustände.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equations',
    '(3.277)',
    'Die komprimierte axiomatische Schreibweise von Axiom A1 wurde als Gleichung (3.277) registriert.',
    NULL,
    'A_1: Mindestens ein funktional unterscheidbarer Zustand ist möglich.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equations',
    '(3.278)',
    'Die qualitative Abhängigkeit der späteren Axiome von Axiom A1 wurde als Gleichung (3.278) registriert.',
    NULL,
    'Negation von A1 impliziert qualitativ den Entfall der Anwendungsgrundlage von A2 bis A5.'
),
(
    @revision_id,
    @section_id,
    'symbol_added',
    'symbols',
    'A_1, \\neg, \\lor',
    'Die abschnittsspezifischen Symbole wurden einschließlich Definitionen und Gleichungsbezügen registriert.',
    NULL,
    'Drei Abschnittssymbole und acht Gleichungssymbol-Zuordnungen.'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.3.2',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned oder früherer Status',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   16. Repository-Zähler auf den nächsten freien Stand setzen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section',       '3.3.2'),
    ('last_repository_revision', 'RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3'),
    ('next_citation_number',      '87'),
    ('next_equation_number',      '3.279')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* -------------------------------------------------------------------------------------------------
   17. Transaktion abschließen
   ------------------------------------------------------------------------------------------------- */

COMMIT;

/* =================================================================================================
   18. AUDIT UND KONTROLLABFRAGEN

   Erwartete Kernergebnisse:
     Revision:                     RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3
     Parent-Revision:              RKB-2026-07-16-K3.3.1-NEUFASSUNG-V2
     Abschnitt:                    3.3.2
     Status:                       review
     neue Quelle:                 [86]
     Quellenverwendungen:          1
     Erstnennungen:                1
     Definitionen:                 1
     Axiome:                       1
     Gleichungen:                  (3.277), (3.278)
     equation_symbols:             9
     nächste Quelle:               [87]
     nächste Gleichung:            (3.279)
   ================================================================================================= */

/* 18.1 Revision und Parent-Revision */
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
      'RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3' COLLATE utf8mb4_unicode_ci;

/* 18.2 Abschnitt und Parent-Abschnitt */
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
      '3.3.2' COLLATE utf8mb4_unicode_ci;

/* 18.3 Quelle [86], Autor und Verifikationsstatus */
SELECT
    s.`source_id`,
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`publisher`,
    s.`place`,
    s.`year_original`,
    s.`verification_status`,
    s.`first_citation_section_code`,
    a.`normalized_name`,
    sa.`author_order`,
    sa.`role`
FROM `sources` s
LEFT JOIN `source_authors` sa
    ON sa.`source_id` = s.`source_id`
LEFT JOIN `authors` a
    ON a.`author_id` = sa.`author_id`
WHERE s.`citation_number` = 86;

/* 18.4 Annotation [86] */
SELECT
    s.`citation_number`,
    a.`annotation_status`,
    a.`contribution`,
    a.`significance_for_dissertation`,
    a.`limitations`
FROM `annotations` a
JOIN `sources` s
    ON s.`source_id` = a.`source_id`
WHERE s.`citation_number` = 86;

/* 18.5 Quellenverwendungen des Abschnitts */
SELECT
    ds.`section_code`,
    COUNT(*) AS `source_usage_count`,
    SUM(su.`is_first_mention`) AS `first_mentions`,
    MIN(s.`citation_number`) AS `lowest_citation`,
    MAX(s.`citation_number`) AS `highest_citation`
FROM `source_usage` su
JOIN `sources` s
    ON s.`source_id` = su.`source_id`
JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.2' COLLATE utf8mb4_unicode_ci
GROUP BY ds.`section_code`;

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
JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.2' COLLATE utf8mb4_unicode_ci
ORDER BY s.`citation_number`;

/* 18.6 Definition des funktionalen Zustandes */
SELECT
    d.`definition_number`,
    d.`title`,
    d.`definition_text`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
JOIN `dissertation_sections` ds
    ON ds.`section_id` = d.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.2' COLLATE utf8mb4_unicode_ci
ORDER BY d.`definition_number`;

/* 18.7 Axiom A1 und Herkunftsannahme */
SELECT
    ax.`axiom_id`,
    ax.`axiom_number`,
    ax.`title`,
    ax.`axiom_text`,
    ax.`formal_latex`,
    ax.`word_latex`,
    ax.`status`,
    ass.`assumption_number` AS `source_assumption_number`,
    ass.`title` AS `source_assumption_title`,
    rr.`revision_code`
FROM `axioms` ax
LEFT JOIN `assumptions` ass
    ON ass.`assumption_id` = ax.`source_assumption_id`
LEFT JOIN `repository_revisions` rr
    ON rr.`revision_id` = ax.`created_revision_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A1' COLLATE utf8mb4_unicode_ci;

/* 18.8 Für A1 werden keine Abhängigkeiten von früheren Axiomen erwartet */
SELECT
    ad.`axiom_dependency_id`,
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
      'A1' COLLATE utf8mb4_unicode_ci;

/* 18.9 Gleichungen und Word-LaTeX-Prüfung */
SELECT
    e.`equation_id`,
    e.`equation_number`,
    ds.`section_code`,
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
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE e.`equation_number` COLLATE utf8mb4_unicode_ci
      IN
      (
          '3.277' COLLATE utf8mb4_unicode_ci,
          '3.278' COLLATE utf8mb4_unicode_ci
      )
ORDER BY e.`equation_number`;

/* 18.10 Gleichungssymbole */
SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`,
    es.`definition_text`
FROM `equation_symbols` es
JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` COLLATE utf8mb4_unicode_ci
      IN
      (
          '3.277' COLLATE utf8mb4_unicode_ci,
          '3.278' COLLATE utf8mb4_unicode_ci
      )
ORDER BY e.`equation_number`, es.`symbol_order`;

/* 18.11 Abschnittssymbole */
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

/* 18.12 Axiom-Quellen-Verknüpfung */
SELECT
    osl.`object_type`,
    ax.`axiom_number`,
    s.`citation_number`,
    osl.`usage_type`,
    osl.`note`
FROM `object_source_links` osl
JOIN `axioms` ax
    ON ax.`axiom_id` = osl.`object_id`
JOIN `sources` s
    ON s.`source_id` = osl.`source_id`
WHERE osl.`object_type` = 'axiom'
  AND ax.`axiom_number` COLLATE utf8mb4_unicode_ci
      =
      'A1' COLLATE utf8mb4_unicode_ci;

/* 18.13 Repository-Zähler */
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

/* 18.14 Globale Gleichungsdubletten */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*) > 1;

/* 18.15 Dubletten in equation_symbols */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`, `symbol_latex`
HAVING COUNT(*) > 1;

/* 18.16 Fehlendes Word-LaTeX im neuen Abschnitt */
SELECT
    e.`equation_number`,
    e.`title`
FROM `equations` e
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.2' COLLATE utf8mb4_unicode_ci
  AND (e.`word_latex` IS NULL OR TRIM(e.`word_latex`) = '');

/* 18.17 Verwaiste source_usage-Einträge dieser Revision */
SELECT
    su.`usage_id`
FROM `source_usage` su
LEFT JOIN `sources` s
    ON s.`source_id` = su.`source_id`
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE su.`created_revision_id` = @revision_id
  AND (s.`source_id` IS NULL OR ds.`section_id` IS NULL);

/* 18.18 Verwaiste Gleichungs- oder Axiomobjekte dieser Revision */
SELECT
    'equation' AS `object_type`,
    e.`equation_id` AS `object_id`,
    e.`equation_number` AS `object_reference`
FROM `equations` e
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE e.`created_revision_id` = @revision_id
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
  AND ds.`section_id` IS NULL;

/* 18.19 Änderungsprotokoll */
SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id` = @revision_id
  AND scl.`section_id` = @section_id
ORDER BY scl.`change_id`;

/* 18.20 Prüfung auf leere ENUM-Altwerte in den berührten Repository-Bereichen */
SELECT
    'object_source_links.usage_type' AS `field_name`,
    COUNT(*) AS `invalid_empty_values`
FROM `object_source_links`
WHERE `usage_type` IS NULL OR TRIM(`usage_type`) = ''

UNION ALL

SELECT
    'section_change_log.change_type' AS `field_name`,
    COUNT(*) AS `invalid_empty_values`
FROM `section_change_log`
WHERE `change_type` IS NULL OR TRIM(`change_type`) = '';

/* 18.21 Abschlussmeldung */

SELECT
    'Repository-Update 3.3.2 V3 vollständig ausgeführt. Erwarteter nächster Stand: Quelle [87], Gleichung (3.279), letzte Revision RKB-2026-07-16-K3.3.2-NEUFASSUNG-V3.' AS `result`;
