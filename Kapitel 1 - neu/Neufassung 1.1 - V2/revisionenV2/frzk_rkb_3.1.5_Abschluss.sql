USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   FRZK-RKB – Abschnitt 3.1.5
   Methodologische Konsequenzen für das
   Funktionale Raum-Zeit-Kohärenzsystem

   Neue Literatur:
   [60] Saunders Mac Lane: Mathematics: Form and Function (1986)
   [61] Samuel Eilenberg / Saunders Mac Lane:
        General Theory of Natural Equivalences (1945)

   Methodologische Grundsätze: M1 bis M10
   Nummerierte Gleichungen: keine
   Nächste Literaturstelle: [62]
   ============================================================ */

/* ============================================================
   1. Parent-Revision ermitteln und Revision anlegen
   ============================================================ */

SET @parent_revision_id :=
(
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `scope_reference` = '3.1.4'
    ORDER BY `revision_id` DESC
    LIMIT 1
);

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
    'RKB-NEU-K3.1.5-ABSCHLUSS-V1',
    NOW(),
    'section',
    '3.1.5',
    '3.1.5-Abschluss-v1',
    'Vollständiger Abschluss des Abschnitts 3.1.5 „Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem“ mit den methodologischen Grundsätzen M1 bis M10 und den Quellen [60] bis [61]. Keine nummerierten Gleichungen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`),
    `parent_revision_id` = VALUES(`parent_revision_id`);

SET @revision_id := LAST_INSERT_ID();

/* ============================================================
   2. Abschnitt 3.1.5 anlegen oder aktualisieren
   ============================================================ */

SET @parent_section_id :=
(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1'
    LIMIT 1
);

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
SELECT
    @parent_section_id,
    '3.1.5',
    'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem',
    3,
    3.1500,
    'final',
    1,
    'Abschnitt vollständig abgeschlossen. Methodologische Grundsätze M1 bis M10; neue Quellen [60] und [61]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.5'
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @parent_section_id,
    `title` = 'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem',
    `chapter_no` = 3,
    `section_order` = 3.1500,
    `status` = 'final',
    `is_original_contribution` = 1,
    `notes` = 'Abschnitt vollständig abgeschlossen. Methodologische Grundsätze M1 bis M10; neue Quellen [60] und [61]; keine nummerierten Gleichungen.'
WHERE `section_code` = '3.1.5';

SET @section_id :=
(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.5'
    LIMIT 1
);

/* ============================================================
   3. Neue Quellen [60] und [61]
   ============================================================ */

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
    60,
    'mac_lane_mathematics_form_function_1986',
    'book',
    'Mathematics: Form and Function',
    NULL,
    1986,
    1986,
    NULL,
    'Springer',
    'New York',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.1.5',
    'Strukturorientierte Bestimmung mathematischer Gegenstände durch Beziehungen und Operationen.',
    'Mac Lane, Saunders: Mathematics: Form and Function. New York: Springer, 1986.',
    'Mac Lane, Mathematics: Form and Function [60]',
    'Methodische Grundlage für die relationale Bestimmung funktionaler Zustände im FRZK.',
    @revision_id
),
(
    61,
    'eilenberg_mac_lane_natural_equivalences_1945',
    'journal_article',
    'General Theory of Natural Equivalences',
    NULL,
    1945,
    1945,
    'Transactions of the American Mathematical Society',
    NULL,
    NULL,
    '58',
    NULL,
    '231–294',
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    10,
    'verified',
    '3.1.5',
    'Strukturerhaltende Abbildungen und natürliche Äquivalenzen als methodischer Bezugspunkt.',
    'Eilenberg, Samuel; Mac Lane, Saunders: General Theory of Natural Equivalences. In: Transactions of the American Mathematical Society, Band 58, 1945, S. 231–294.',
    'Eilenberg/Mac Lane, Natural Equivalences [61]',
    'Methodischer Bezug für die Untersuchung strukturerhaltender Transformationen im FRZK; keine kategorientheoretische Rekonstruktion des FRZK.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_key` = VALUES(`source_key`),
    `source_type` = VALUES(`source_type`),
    `title` = VALUES(`title`),
    `subtitle` = VALUES(`subtitle`),
    `year_original` = VALUES(`year_original`),
    `year_edition` = VALUES(`year_edition`),
    `journal` = VALUES(`journal`),
    `publisher` = VALUES(`publisher`),
    `place` = VALUES(`place`),
    `volume` = VALUES(`volume`),
    `issue` = VALUES(`issue`),
    `pages` = VALUES(`pages`),
    `edition` = VALUES(`edition`),
    `doi` = VALUES(`doi`),
    `isbn` = VALUES(`isbn`),
    `url` = VALUES(`url`),
    `language_code` = VALUES(`language_code`),
    `priority` = VALUES(`priority`),
    `evidence_type` = VALUES(`evidence_type`),
    `frzk_relevance` = VALUES(`frzk_relevance`),
    `verification_status` = VALUES(`verification_status`),
    `first_citation_section_code` = VALUES(`first_citation_section_code`),
    `first_citation_note` = VALUES(`first_citation_note`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `notes` = VALUES(`notes`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* ============================================================
   4. Autoren
   ============================================================ */

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
    'Autor von Quelle [60] und Mitautor von Quelle [61].'
),
(
    'Eilenberg',
    'Samuel',
    'Eilenberg, Samuel',
    1913,
    1998,
    'Erstautor von Quelle [61].'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year` = VALUES(`birth_year`),
    `death_year` = VALUES(`death_year`),
    `notes` = VALUES(`notes`);

/* ============================================================
   5. Quellen-Autoren-Verknüpfungen
   ============================================================ */

SET @source_60 :=
(
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 60
    LIMIT 1
);

SET @source_61 :=
(
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 61
    LIMIT 1
);

SET @author_mac_lane :=
(
    SELECT `author_id`
    FROM `authors`
    WHERE `normalized_name` = 'Mac Lane, Saunders'
    LIMIT 1
);

SET @author_eilenberg :=
(
    SELECT `author_id`
    FROM `authors`
    WHERE `normalized_name` = 'Eilenberg, Samuel'
    LIMIT 1
);

INSERT IGNORE INTO `source_authors`
(
    `source_id`, `author_id`, `author_order`, `role`
)
VALUES
(@source_60, @author_mac_lane, 1, 'author'),
(@source_61, @author_eilenberg, 1, 'author'),
(@source_61, @author_mac_lane, 2, 'author');

/* ============================================================
   6. Quellenverwendung
   ============================================================ */

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
SELECT
    s.`source_id`,
    @section_id,
    'first_citation',
    CASE s.`citation_number`
        WHEN 60 THEN 'Mathematische Objekte werden methodisch durch ihre Beziehungen, Operationen und ihre Stellung innerhalb einer Struktur bestimmt.'
        WHEN 61 THEN 'Strukturerhaltende Abbildungen bilden einen methodischen Bezugspunkt für die Analyse funktionaler Transformationen und Invarianten.'
    END,
    '3.1.5',
    1,
    1,
    CASE s.`citation_number`
        WHEN 60 THEN 'Erstverwendung zur Begründung des methodologischen Grundsatzes M3.'
        WHEN 61 THEN 'Erstverwendung zur Begründung des methodologischen Grundsatzes M4; das FRZK wird ausdrücklich nicht als kategorientheoretische Rekonstruktion ausgewiesen.'
    END,
    @revision_id
FROM `sources` s
WHERE s.`citation_number` IN (60, 61)
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM `source_usage` u
      WHERE u.`source_id` = s.`source_id`
        AND u.`section_id` = @section_id
        AND u.`usage_type` = 'first_citation'
  );

/* ============================================================
   7. Methodologische Grundsätze M1 bis M10 protokollieren
   ============================================================ */

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
SELECT
    @revision_id,
    @section_id,
    'created',
    'methodological_principle',
    p.`principle_code`,
    p.`principle_summary`,
    NULL,
    p.`principle_text`
FROM
(
    SELECT 'M1' AS principle_code,
           'Vermeidung vorweggenommener Raum- und Zeitstrukturen.' AS principle_summary,
           'Raum, Zeit, Richtung, Entfernung, Dauer und Gleichzeitigkeit dürfen nicht als elementare Eigenschaften des funktionalen Ausgangssystems vorausgesetzt werden.' AS principle_text
    UNION ALL
    SELECT 'M2',
           'Explizite Ableitungsabhängigkeit.',
           'Jede Definition, Relation und mathematische Konstruktion muss vollständig auf bereits eingeführte Begriffe zurückführbar sein.'
    UNION ALL
    SELECT 'M3',
           'Relationale Bestimmung funktionaler Zustände.',
           'Funktionale Zustände werden zunächst durch Unterscheidbarkeit sowie definierte Relationen und Transformationen bestimmt.'
    UNION ALL
    SELECT 'M4',
           'Vorrang strukturerhaltender Transformationen.',
           'Für Transformationen ist zu bestimmen, welche Relationen, Eigenschaften oder Invarianten erhalten, verändert oder erzeugt werden.'
    UNION ALL
    SELECT 'M5',
           'Funktionale Anschlussfähigkeit von Definitionen.',
           'Definitionen müssen eindeutig, widerspruchsfrei und für weitere Ableitungen verwendbar sein.'
    UNION ALL
    SELECT 'M6',
           'Nicht rückwirkende Begriffsentwicklung.',
           'Neue Definitionen dürfen die Bedeutung bereits eingeführter Begriffe nicht unbemerkt verändern.'
    UNION ALL
    SELECT 'M7',
           'Trennung von Formalismus und Interpretation.',
           'Mathematische Entwicklung und empirische oder fachwissenschaftliche Interpretation sind voneinander zu trennen.'
    UNION ALL
    SELECT 'M8',
           'Modularität und Abhängigkeitskontrolle.',
           'Logische Abhängigkeiten müssen eindeutig bestimmt und Änderungen auf tatsächlich abhängige Aussagen begrenzt werden.'
    UNION ALL
    SELECT 'M9',
           'Versionierung und Reproduzierbarkeit.',
           'Jede inhaltliche oder formale Änderung muss dokumentiert, einer Revision zugeordnet und überprüfbar sein.'
    UNION ALL
    SELECT 'M10',
           'Vorrang der Rekonstruktion vor der Deutung.',
           'Ontologische, physikalische oder anwendungsbezogene Deutungen erfolgen erst auf Grundlage einer konsistent entwickelten mathematischen Struktur.'
) p
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log` l
    WHERE l.`revision_id` = @revision_id
      AND l.`object_type` = 'methodological_principle'
      AND l.`object_reference` = p.`principle_code`
);

/* ============================================================
   8. Abschnittsabschluss protokollieren
   ============================================================ */

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
SELECT
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.1.5',
    'Abschnitt 3.1.5 „Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem“ wurde vollständig angelegt und abgeschlossen.',
    NULL,
    'Methodologische Grundsätze M1 bis M10; Quellen [60] und [61]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `object_reference` = '3.1.5'
);

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
SELECT
    @revision_id,
    @section_id,
    'source_added',
    'source_range',
    '[60]-[61]',
    'Die neuen Quellen [60] und [61] wurden aufgenommen und mit Abschnitt 3.1.5 verknüpft.',
    'last_citation_number=59',
    'last_citation_number=61'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `object_reference` = '[60]-[61]'
);

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
SELECT
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.1.5-ABSCHLUSS',
    'Abschnitt 3.1.5 wurde als vollständig abgeschlossen markiert.',
    'draft',
    'final'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `object_reference` = '3.1.5-ABSCHLUSS'
);

/* ============================================================
   9. Repository-Zähler aktualisieren
   ============================================================ */

INSERT INTO `repository_counters`
(
    `counter_key`, `counter_value`
)
VALUES
    ('last_completed_section', '3.1.5'),
    ('current_section', '3.2'),
    ('last_citation_number', '61'),
    ('next_citation_number', '62')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* ============================================================
   10. Validierungen
   ============================================================ */

SET @section_count :=
(
    SELECT COUNT(*)
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.5'
);

SET @source_count :=
(
    SELECT COUNT(*)
    FROM `sources`
    WHERE `citation_number` IN (60, 61)
);

SET @usage_count :=
(
    SELECT COUNT(DISTINCT s.`citation_number`)
    FROM `source_usage` u
    JOIN `sources` s
      ON s.`source_id` = u.`source_id`
    WHERE u.`section_id` = @section_id
      AND s.`citation_number` IN (60, 61)
);

SET @principle_count :=
(
    SELECT COUNT(DISTINCT `object_reference`)
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `section_id` = @section_id
      AND `object_type` = 'methodological_principle'
      AND `object_reference` IN
      ('M1','M2','M3','M4','M5','M6','M7','M8','M9','M10')
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM `equations`
    WHERE `section_id` = @section_id
);

INSERT INTO `repository_validation_results`
(
    `revision_id`,
    `validation_code`,
    `validation_status`,
    `expected_value`,
    `actual_value`,
    `validation_message`
)
VALUES
(
    @revision_id,
    'K3_1_5_SECTION',
    IF(@section_count = 1, 'passed', 'failed'),
    '1',
    CAST(@section_count AS CHAR),
    'Abschnitt 3.1.5 muss genau einmal vorhanden sein.'
),
(
    @revision_id,
    'K3_1_5_SOURCES',
    IF(@source_count = 2, 'passed', 'failed'),
    '2',
    CAST(@source_count AS CHAR),
    'Die Quellen [60] und [61] müssen vollständig vorhanden sein.'
),
(
    @revision_id,
    'K3_1_5_SOURCE_USAGE',
    IF(@usage_count = 2, 'passed', 'failed'),
    '2',
    CAST(@usage_count AS CHAR),
    'Beide neuen Quellen müssen mit Abschnitt 3.1.5 verknüpft sein.'
),
(
    @revision_id,
    'K3_1_5_PRINCIPLES',
    IF(@principle_count = 10, 'passed', 'failed'),
    '10',
    CAST(@principle_count AS CHAR),
    'Die methodologischen Grundsätze M1 bis M10 müssen vollständig protokolliert sein.'
),
(
    @revision_id,
    'K3_1_5_NO_EQUATIONS',
    IF(@equation_count = 0, 'passed', 'failed'),
    '0',
    CAST(@equation_count AS CHAR),
    'Abschnitt 3.1.5 enthält keine nummerierten Gleichungen.'
)
ON DUPLICATE KEY UPDATE
    `validation_status` = VALUES(`validation_status`),
    `expected_value` = VALUES(`expected_value`),
    `actual_value` = VALUES(`actual_value`),
    `validation_message` = VALUES(`validation_message`),
    `checked_at` = CURRENT_TIMESTAMP;

COMMIT;

/* ============================================================
   11. Kontrollausgaben
   ============================================================ */

SELECT
    `revision_id`,
    `revision_code`,
    `scope_reference`,
    `version_label`,
    `parent_revision_id`
FROM `repository_revisions`
WHERE `revision_code` = 'RKB-NEU-K3.1.5-ABSCHLUSS-V1';

SELECT
    `section_id`,
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `notes`
FROM `dissertation_sections`
WHERE `section_code` = '3.1.5';

SELECT
    `citation_number`,
    `source_key`,
    `title`,
    `year_edition`
FROM `sources`
WHERE `citation_number` IN (60, 61)
ORDER BY `citation_number`;

SELECT
    `object_reference`,
    `change_summary`,
    `new_value`
FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `object_type` = 'methodological_principle'
ORDER BY CAST(SUBSTRING(`object_reference`, 2) AS UNSIGNED);

SELECT
    `validation_code`,
    `validation_status`,
    `expected_value`,
    `actual_value`,
    `validation_message`
FROM `repository_validation_results`
WHERE `revision_id` = @revision_id
ORDER BY `validation_code`;

SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
(
    'last_completed_section',
    'current_section',
    'last_citation_number',
    'next_citation_number'
)
ORDER BY `counter_key`;
