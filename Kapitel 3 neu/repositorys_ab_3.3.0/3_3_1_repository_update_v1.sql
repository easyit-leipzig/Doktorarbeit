/* =================================================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.3.1

   Abschnitt:
     3.3.1 Primitive Begriffe und wissenschaftstheoretische Ausgangspunkte

   Verbindlicher Ausgangsstand nach 3.3.0:
     letzte Literaturquelle: [82]
     nächste Literaturquelle: [83]
     letzte Gleichung: (3.275)
     nächste Gleichung: (3.276)
     Parent-Revision: RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2

   Dieses Skript registriert:
     - Abschnitt 3.3.1
     - Revision RKB-2026-07-16-K3.3.1-NEUFASSUNG-V1
     - neue Quellen [83] Suppes, [84] Mac Lane und [85] Quine
     - Wiederverwendung der Quelle [82] Tarski
     - sechs primitive FRZK-Begriffe als Definitionen
     - Gleichung (3.276)
     - Gleichungssymbol \Longrightarrow
     - Abschnittsänderungen, Repository-Zähler und Audit-Abfragen

   SQL-Dialekt:
     MariaDB / MySQL

   Eigenschaften:
     - transaktional
     - idempotent
     - phpMyAdmin-kompatibel
     - explizite Verbindungskollation
     - keine Gleichsetzung interner IDs mit Literaturziffern
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Parent-Revision laden und validieren
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* Harte Vorbedingung ohne DELIMITER oder Stored Procedure. */
DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_331`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_331`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_331` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_331`;

/* -------------------------------------------------------------------------------------------------
   2. Repository-Revision idempotent anlegen
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.1-NEUFASSUNG-V1' USING utf8mb4)
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
    '3.3.1',
    'V1',
    'Neufassung von Abschnitt 3.3.1: wissenschaftstheoretische Bestimmung der primitiven FRZK-Begriffe Funktionalität, Unterscheidbarkeit, Relationierbarkeit, Transformation, Organisation und Kohärenz; neue Quellen [83] bis [85], Wiederverwendung von [82] und Registrierung der konzeptionellen Gleichung (3.276).',
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
   3. Kapitel- und Abschnittsstruktur
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_331`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_331`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_331` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_331`;

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
    '3.3.1',
    'Primitive Begriffe und wissenschaftstheoretische Ausgangspunkte',
    3,
    3.3002,
    'review',
    1,
    'Bestimmt den qualitativen primitiven Wortschatz des FRZK. Mengen, mathematische Relationen, Funktionen, Operatoren, Zustandsräume, Raum und Zeit werden ausdrücklich nicht als primitive mathematische Objekte vorausgesetzt.'
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
      '3.3.1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   4. Autoren [83]–[85] idempotent anlegen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `birth_year`,
    `death_year`,
    `notes`
)
VALUES
(
    'Suppes',
    'Patrick',
    'Suppes, Patrick',
    1922,
    2014,
    'Wissenschaftstheoretiker und Logiker; Arbeiten zur axiomatischen Darstellung wissenschaftlicher Theorien.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `birth_year`,
    `death_year`,
    `notes`
)
VALUES
(
    'Mac Lane',
    'Saunders',
    'Mac Lane, Saunders',
    1909,
    2005,
    'Mathematiker und Mitbegründer der Kategorientheorie; Quelle zur strukturellen Auffassung moderner Mathematik.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `birth_year`,
    `death_year`,
    `notes`
)
VALUES
(
    'Quine',
    'Willard Van Orman',
    'Quine, Willard Van Orman',
    1908,
    2000,
    'Philosoph und Logiker; zentrale Quelle zum Begriff ontologischer Verpflichtungen formaler Theorien.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

SET @author_suppes_id := NULL;
SET @author_mac_lane_id := NULL;
SET @author_quine_id := NULL;

SELECT `author_id`
INTO @author_suppes_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Suppes, Patrick' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `author_id`
INTO @author_mac_lane_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Mac Lane, Saunders' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `author_id`
INTO @author_quine_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Quine, Willard Van Orman' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   5. Quellen [83]–[85]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `sources`
(
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `year_original`,
    `year_edition`,
    `publisher`,
    `place`,
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
    83,
    'suppes_introduction_logic_1957',
    'book',
    'Introduction to Logic',
    1957,
    1957,
    'D. Van Nostrand Company',
    'Princeton, New Jersey',
    'en',
    1,
    'textbook',
    8,
    'partially_verified',
    '3.3.1',
    'Erstnennung zur methodischen Rolle primitiver Begriffe in axiomatischen und deduktiven Theorien.',
    'Suppes, Patrick: Introduction to Logic. Princeton, New Jersey: D. Van Nostrand Company, 1957.',
    'Suppes [83]',
    'Verwendet zur wissenschaftstheoretischen Einordnung primitiver Begriffe und axiomatischer Darstellungen.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`             = VALUES(`citation_number`),
    `source_type`                 = VALUES(`source_type`),
    `title`                       = VALUES(`title`),
    `year_original`               = VALUES(`year_original`),
    `year_edition`                = VALUES(`year_edition`),
    `publisher`                   = VALUES(`publisher`),
    `place`                       = VALUES(`place`),
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

INSERT INTO `sources`
(
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `year_original`,
    `year_edition`,
    `publisher`,
    `place`,
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
    84,
    'mac_lane_mathematics_form_function_1986',
    'book',
    'Mathematics: Form and Function',
    1986,
    1986,
    'Springer',
    'New York',
    'en',
    1,
    'reference',
    8,
    'verified',
    '3.3.1',
    'Erstnennung zur strukturellen Auffassung von Mathematik und zur begrifflichen Sparsamkeit.',
    'Mac Lane, Saunders: Mathematics: Form and Function. New York: Springer, 1986.',
    'Mac Lane [84]',
    'Dient zur Einordnung der Beziehungen und Transformationen als tragende Struktur moderner Mathematik.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`             = VALUES(`citation_number`),
    `source_type`                 = VALUES(`source_type`),
    `title`                       = VALUES(`title`),
    `year_original`               = VALUES(`year_original`),
    `year_edition`                = VALUES(`year_edition`),
    `publisher`                   = VALUES(`publisher`),
    `place`                       = VALUES(`place`),
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

INSERT INTO `sources`
(
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `year_original`,
    `year_edition`,
    `publisher`,
    `place`,
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
    85,
    'quine_logical_point_view_1953',
    'book',
    'From a Logical Point of View',
    1953,
    1953,
    'Harvard University Press',
    'Cambridge, Massachusetts',
    'en',
    1,
    'primary',
    8,
    'verified',
    '3.3.1',
    'Erstnennung zur ontologischen Verpflichtung formaler Theorien.',
    'Quine, Willard Van Orman: From a Logical Point of View. Cambridge, Massachusetts: Harvard University Press, 1953.',
    'Quine [85]',
    'Dient zur Begründung, warum jeder primitive Begriff eine Theorie auf bestimmte Grundstrukturen verpflichtet.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`             = VALUES(`citation_number`),
    `source_type`                 = VALUES(`source_type`),
    `title`                       = VALUES(`title`),
    `year_original`               = VALUES(`year_original`),
    `year_edition`                = VALUES(`year_edition`),
    `publisher`                   = VALUES(`publisher`),
    `place`                       = VALUES(`place`),
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

SET @source_83_id := NULL;
SET @source_84_id := NULL;
SET @source_85_id := NULL;
SET @source_82_id := NULL;

SELECT `source_id`
INTO @source_83_id
FROM `sources`
WHERE `citation_number` = 83
LIMIT 1;

SELECT `source_id`
INTO @source_84_id
FROM `sources`
WHERE `citation_number` = 84
LIMIT 1;

SELECT `source_id`
INTO @source_85_id
FROM `sources`
WHERE `citation_number` = 85
LIMIT 1;

SELECT `source_id`
INTO @source_82_id
FROM `sources`
WHERE `citation_number` = 82
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   6. Quellen-Autor-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `source_authors`
(`source_id`, `author_id`, `author_order`, `role`)
VALUES
(@source_83_id, @author_suppes_id, 1, 'author')
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

INSERT INTO `source_authors`
(`source_id`, `author_id`, `author_order`, `role`)
VALUES
(@source_84_id, @author_mac_lane_id, 1, 'author')
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

INSERT INTO `source_authors`
(`source_id`, `author_id`, `author_order`, `role`)
VALUES
(@source_85_id, @author_quine_id, 1, 'author')
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

/* -------------------------------------------------------------------------------------------------
   7. Quellenannotation
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
    @source_83_id,
    'Systematische Einführung in formale Logik und axiomatische Theoriebildung.',
    'Begründet die methodische Rolle primitiver Begriffe im Übergang von qualitativer Grundlegung zu formaler Rekonstruktion.',
    'Stützt die Aussage, dass primitive Begriffe nicht innerhalb derselben Theorie vollständig definiert werden können.',
    'Übernommen wird die methodische Trennung von primitiven Begriffen, Axiomen und abgeleiteten Aussagen.',
    'Die Quelle entwickelt keine funktionale Raum-Zeit-Axiomatik.',
    'Suppes wird mit Tarski [82] verglichen; das FRZK verwendet die Methode auf einer vor-mathematischen qualitativen Ebene.',
    'reviewed',
    NOW()
)
ON DUPLICATE KEY UPDATE
    `contribution`                   = VALUES(`contribution`),
    `significance_for_dissertation` = VALUES(`significance_for_dissertation`),
    `citation_reason`                = VALUES(`citation_reason`),
    `adopted_claims`                 = VALUES(`adopted_claims`),
    `limitations`                   = VALUES(`limitations`),
    `scientific_discussion`         = VALUES(`scientific_discussion`),
    `annotation_status`             = VALUES(`annotation_status`),
    `reviewed_at`                   = VALUES(`reviewed_at`);

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
    @source_84_id,
    'Strukturelle Darstellung der Mathematik über Formen, Beziehungen und Transformationen.',
    'Unterstützt die begriffliche Sparsamkeit und die relationale Ausrichtung der primitiven FRZK-Begriffe.',
    'Stützt die methodische Entscheidung, den Theorieaufbau nicht über eine Vielzahl vorausgesetzter Grundobjekte zu beginnen.',
    'Übernommen wird die strukturelle Perspektive auf Beziehungen und Transformationen.',
    'Mac Lane setzt etablierte mathematische Strukturen voraus und erklärt nicht deren qualitative Genese.',
    'Das FRZK verlagert den strukturellen Gedanken auf eine vorgelagerte axiomatische Ebene.',
    'reviewed',
    NOW()
)
ON DUPLICATE KEY UPDATE
    `contribution`                   = VALUES(`contribution`),
    `significance_for_dissertation` = VALUES(`significance_for_dissertation`),
    `citation_reason`                = VALUES(`citation_reason`),
    `adopted_claims`                 = VALUES(`adopted_claims`),
    `limitations`                   = VALUES(`limitations`),
    `scientific_discussion`         = VALUES(`scientific_discussion`),
    `annotation_status`             = VALUES(`annotation_status`),
    `reviewed_at`                   = VALUES(`reviewed_at`);

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
    @source_85_id,
    'Formuliert die ontologischen Verpflichtungen, die aus der Sprache und Quantifikation einer Theorie folgen.',
    'Begründet den bewussten Ausschluss bereits stark strukturierter mathematischer Begriffe aus dem primitiven Wortschatz des FRZK.',
    'Stützt die Aussage, dass jeder primitive Begriff eine Theorie auf bestimmte Grundstrukturen verpflichtet.',
    'Übernommen wird das methodische Bewusstsein für ontologische Verpflichtungen formaler Theorien.',
    'Die Quelle entwickelt keine eigenständige Theorie funktionaler Organisation.',
    'Das FRZK überträgt Quines Problemstellung auf die Auswahl qualitativer primitiver Begriffe.',
    'reviewed',
    NOW()
)
ON DUPLICATE KEY UPDATE
    `contribution`                   = VALUES(`contribution`),
    `significance_for_dissertation` = VALUES(`significance_for_dissertation`),
    `citation_reason`                = VALUES(`citation_reason`),
    `adopted_claims`                 = VALUES(`adopted_claims`),
    `limitations`                   = VALUES(`limitations`),
    `scientific_discussion`         = VALUES(`scientific_discussion`),
    `annotation_status`             = VALUES(`annotation_status`),
    `reviewed_at`                   = VALUES(`reviewed_at`);

/* -------------------------------------------------------------------------------------------------
   8. Quellenverwendungen des Abschnitts neu aufbauen
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
    @source_82_id,
    @section_id,
    'method',
    'Tarski stützt die Trennung zwischen primitiven Ausdrücken, Grundsätzen und abgeleiteten Aussagen deduktiver Theorien.',
    '3.3.1, Absätze 1–2',
    0,
    1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.3.0.',
    @revision_id
),
(
    @source_83_id,
    @section_id,
    'first_citation',
    'Suppes begründet die methodische Funktion primitiver Begriffe und axiomatischer Darstellungen wissenschaftlicher Theorien.',
    '3.3.1, Absatz 2',
    1,
    1,
    'Erstnennung der Quelle [83].',
    @revision_id
),
(
    @source_84_id,
    @section_id,
    'first_citation',
    'Mac Lane stützt die strukturelle und relationale Ausrichtung sowie die begriffliche Sparsamkeit des Theorieaufbaus.',
    '3.3.1, Absatz zur begrifflichen Sparsamkeit',
    1,
    1,
    'Erstnennung der Quelle [84].',
    @revision_id
),
(
    @source_85_id,
    @section_id,
    'first_citation',
    'Quine begründet die Aussage, dass primitive Begriffe eine Theorie auf bestimmte ontologische Grundstrukturen verpflichten.',
    '3.3.1, Abschnitt zum Ausschluss strukturhaltiger Grundbegriffe',
    1,
    1,
    'Erstnennung der Quelle [85].',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   9. Sechs primitive Begriffe als originale Definitionen
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
    'Def. 3.3.1.1',
    @section_id,
    'Funktionalität',
    'Funktionalität bezeichnet im FRZK die prinzipielle Möglichkeit, dass eine Konfiguration innerhalb eines Organisationszusammenhangs Wirkungen hervorbringen oder Wirkungen anderer Konfigurationen aufnehmen kann. Der Begriff bezeichnet noch keine mathematische Funktion.',
    NULL,
    NULL,
    'original',
    NULL,
    'Keine Menge, Definitionsmenge, Zielmenge oder Zuordnungsvorschrift wird vorausgesetzt.',
    'Primitiver qualitativer FRZK-Begriff.',
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
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'Def. 3.3.1.2',
    @section_id,
    'Unterscheidbarkeit',
    'Unterscheidbarkeit bezeichnet die qualitative Möglichkeit, funktionale Konfigurationen voneinander abzugrenzen, ohne bereits einen Abstand, eine Ordnung, eine Metrik oder einen numerischen Differenzwert vorauszusetzen.',
    NULL,
    NULL,
    'original',
    NULL,
    'Funktionale Verschiedenheit wird lediglich als Möglichkeit angenommen.',
    'Primitiver qualitativer FRZK-Begriff.',
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
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'Def. 3.3.1.3',
    @section_id,
    'Relationierbarkeit',
    'Relationierbarkeit bezeichnet die prinzipielle Möglichkeit, funktional unterscheidbare Konfigurationen miteinander in Zusammenhang zu bringen. Der Begriff ist noch keine mathematische Relation als Teilmenge eines kartesischen Produkts.',
    NULL,
    NULL,
    'original',
    NULL,
    'Mengen, geordnete Paare und kartesische Produkte werden nicht vorausgesetzt.',
    'Primitiver qualitativer FRZK-Begriff.',
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
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'Def. 3.3.1.4',
    @section_id,
    'Transformation',
    'Transformation bezeichnet jede mögliche Veränderung funktionaler Konfigurationen oder ihrer Zusammenhänge, ohne bereits eine mathematische Funktion, einen Operator oder eine zeitliche Entwicklung vorauszusetzen.',
    NULL,
    NULL,
    'original',
    NULL,
    'Zeit, Funktionen und Operatoren sind noch nicht rekonstruiert.',
    'Primitiver qualitativer FRZK-Begriff.',
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
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'Def. 3.3.1.5',
    @section_id,
    'Organisation',
    'Organisation bezeichnet das Auftreten zusammenhängender und prinzipiell wiedererkennbarer funktionaler Muster, ohne bereits eine räumliche Anordnung, einen Zustandsraum oder eine feste Komponentenmenge vorauszusetzen.',
    NULL,
    NULL,
    'original',
    NULL,
    'Relationierbarkeit und Transformation sind qualitativ möglich.',
    'Primitiver qualitativer FRZK-Begriff.',
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
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'Def. 3.3.1.6',
    @section_id,
    'Kohärenz',
    'Kohärenz bezeichnet die qualitative Möglichkeit, dass sich funktionale Organisationszusammenhänge trotz Transformation erhalten, erneuern oder in wiedererkennbarer Form reproduzieren können. Der Begriff enthält noch kein mathematisches Kohärenzmaß.',
    NULL,
    NULL,
    'original',
    NULL,
    'Organisation und Transformation sind qualitativ möglich.',
    'Primitiver qualitativer FRZK-Begriff.',
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
   10. Gleichung (3.276)
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
    '3.276',
    @section_id,
    'Begriffliche Entwicklungsrichtung der primitiven FRZK-Begriffe',
    '\\text{Funktionalität}\\;\\Longrightarrow\\;\\text{Unterscheidbarkeit}\\;\\Longrightarrow\\;\\text{Relationierbarkeit}\\;\\Longrightarrow\\;\\text{Transformation}\\;\\Longrightarrow\\;\\text{Organisation}\\;\\Longrightarrow\\;\\text{Kohärenz}',
    '\\text{Funktionalität}\\Longrightarrow\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierbarkeit}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Kohärenz}',
    'Qualitative Reihenfolge, in der die primitiven FRZK-Begriffe für den Aufbau der Axiomatik benötigt werden. Die Pfeile sind weder mathematische Implikationen noch Funktionen, Operatoren oder zeitliche Entwicklungen.',
    'schema',
    'original',
    NULL,
    'Die Folge ordnet die primitiven Begriffe entsprechend ihrer Rolle im Theorieaufbau.',
    'Sämtliche Begriffe besitzen in Abschnitt 3.3.1 ausschließlich qualitative Bedeutung.',
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

SET @equation_id := NULL;

SELECT `equation_id`
INTO @equation_id
FROM `equations`
WHERE `equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.276' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   11. Gleichungssymbol und Abschnittssymbol
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` = @equation_id;

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
    @equation_id,
    '\\Longrightarrow',
    'qualitativer Folgerungs- und Ordnungspfeil',
    'Kennzeichnet in Gleichung (3.276) ausschließlich die begriffliche Reihenfolge der primitiven FRZK-Begriffe.',
    NULL,
    'qualitative axiomatische Begriffsordnung',
    1
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

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
    '\\Longrightarrow',
    '\\Longrightarrow',
    'qualitativer Folgerungs- und Ordnungspfeil',
    'Qualitativer Pfeil zur Kennzeichnung der begrifflichen Reihenfolge in Abschnitt 3.3.1; keine formale Implikation.',
    'section',
    @section_id,
    @equation_id,
    NULL,
    'qualitative axiomatische Begriffsordnung',
    'qualitative axiomatische Begriffsordnung',
    0,
    0,
    0,
    'Abschnittsspezifische Verwendung in Gleichung (3.276).',
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
   12. Abschnittsänderungsprotokoll
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
    'created',
    'section',
    '3.3.1',
    'Abschnitt 3.3.1 wurde als wissenschaftstheoretische Bestimmung der primitiven FRZK-Begriffe neu angelegt.',
    NULL,
    'Primitive Begriffe und wissenschaftstheoretische Ausgangspunkte.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source_usage',
    '[82]',
    'Tarski [82] wurde zur methodischen Einordnung primitiver Ausdrücke wiederverwendet.',
    NULL,
    'Eine geprüfte Wiederverwendung.'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'sources',
    '[83]–[85]',
    'Suppes [83], Mac Lane [84] und Quine [85] wurden als neue Quellen registriert.',
    NULL,
    'Drei neue Quellen einschließlich Autoren, Annotationen und source_usage.'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definitions',
    'Def. 3.3.1.1–Def. 3.3.1.6',
    'Die sechs primitiven qualitativen FRZK-Begriffe wurden vollständig registriert.',
    NULL,
    'Funktionalität, Unterscheidbarkeit, Relationierbarkeit, Transformation, Organisation und Kohärenz.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equations',
    '(3.276)',
    'Die begriffliche Entwicklungsrichtung der primitiven FRZK-Begriffe wurde als Gleichung (3.276) registriert.',
    NULL,
    'Funktionalität → Unterscheidbarkeit → Relationierbarkeit → Transformation → Organisation → Kohärenz.'
),
(
    @revision_id,
    @section_id,
    'symbol_added',
    'symbols',
    '\\Longrightarrow',
    'Der qualitative Folgerungs- und Ordnungspfeil wurde abschnittsspezifisch registriert.',
    NULL,
    'Symbolbezug zu Gleichung (3.276).'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.3.1',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned oder nicht vorhanden',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   13. Repository-Zähler
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section',       '3.3.1'),
    ('last_repository_revision', 'RKB-2026-07-16-K3.3.1-NEUFASSUNG-V1'),
    ('next_citation_number',      '86'),
    ('next_equation_number',      '3.277')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* -------------------------------------------------------------------------------------------------
   14. Transaktion abschließen
   ------------------------------------------------------------------------------------------------- */

COMMIT;

/* =================================================================================================
   15. AUDIT UND KONTROLLABFRAGEN

   Erwartete Kernergebnisse:
     Revision:                 RKB-2026-07-16-K3.3.1-NEUFASSUNG-V1
     Parent-Revision:          RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2
     Abschnitt:                3.3.1
     Status:                   review
     Quellenverwendungen:      4
     Erstnennungen:            3
     Definitionen:             6
     Gleichung:                (3.276)
     equation_symbols:         1
     nächste Quelle:           [86]
     nächste Gleichung:        (3.277)
   ================================================================================================= */

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
      'RKB-2026-07-16-K3.3.1-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    p.`section_code` AS `parent_section_code`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` p
    ON p.`section_id` = ds.`parent_section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.1' COLLATE utf8mb4_unicode_ci;

SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`verification_status`,
    s.`first_citation_section_code`
FROM `sources` s
WHERE s.`citation_number` BETWEEN 83 AND 85
ORDER BY s.`citation_number`;

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
      '3.3.1' COLLATE utf8mb4_unicode_ci
GROUP BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
JOIN `dissertation_sections` ds
    ON ds.`section_id` = d.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.1' COLLATE utf8mb4_unicode_ci
ORDER BY d.`definition_number`;

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
WHERE e.`equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.276' COLLATE utf8mb4_unicode_ci;

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` COLLATE utf8mb4_unicode_ci
      =
      '3.276' COLLATE utf8mb4_unicode_ci
ORDER BY es.`symbol_order`;

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

/* Globale Gleichungsdubletten */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*) > 1;

/* Dubletten in equation_symbols */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`, `symbol_latex`
HAVING COUNT(*) > 1;

/* Fehlendes Word-LaTeX im neuen Abschnitt */
SELECT
    e.`equation_number`,
    e.`title`
FROM `equations` e
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.1' COLLATE utf8mb4_unicode_ci
  AND (e.`word_latex` IS NULL OR TRIM(e.`word_latex`) = '');

/* Verwaiste source_usage-Einträge der Revision */
SELECT
    su.`usage_id`
FROM `source_usage` su
LEFT JOIN `sources` s
    ON s.`source_id` = su.`source_id`
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE su.`created_revision_id` = @revision_id
  AND (s.`source_id` IS NULL OR ds.`section_id` IS NULL);

/* Abschlussmeldung */
SELECT
    'Repository-Update 3.3.1 vollständig ausgeführt. Erwarteter nächster Stand: Quelle [86], Gleichung (3.277).' AS `result`;
