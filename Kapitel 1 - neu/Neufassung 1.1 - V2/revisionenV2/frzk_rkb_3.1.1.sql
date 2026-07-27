USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   FRZK-RKB – Abschnitt 3.1.1
   Das Nichts als mathematischer Ausgangspunkt

   Neue Literatur:
   [4] Parmenides / Diels / Kranz
   [5] Steven Weinberg
   [6] Paul R. Halmos

   Nummerierte Gleichungen: keine
   Das Symbol \emptyset wird nur erläuternd verwendet und
   erzeugt weder einen Gleichungs- noch einen Symboleintrag.
   ============================================================ */

/* ============================================================
   1. Revision idempotent anlegen
   ============================================================ */

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
    'RKB-NEU-K3.1.1-V1',
    NOW(),
    'section',
    '3.1.1',
    '1.0',
    'Aufnahme des Abschnitts 3.1.1 „Das Nichts als mathematischer Ausgangspunkt“ einschließlich der erstmals verwendeten Quellen [4] bis [6]. Der Abschnitt enthält keine nummerierte Gleichung.',
    'Olaf Thiele / ChatGPT',
    (
        SELECT r.`revision_id`
        FROM `repository_revisions` r
        WHERE r.`revision_code` = 'K3_1_0_REBUILD_V1'
           OR r.`revision_code` = 'RKB-NEU-K3.1.0-V1'
        ORDER BY r.`revision_id` DESC
        LIMIT 1
    )
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* ============================================================
   2. Kapitelstruktur sicherstellen
   ============================================================ */

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
    NULL,
    '3',
    'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen',
    3,
    3.0000,
    'draft',
    1,
    'Übergeordnetes Wurzelkapitel für Kapitel 3.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `dissertation_sections`
    WHERE `section_code` = '3'
);

SET @chapter3_id :=
(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3'
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
    @chapter3_id,
    '3.1',
    'Grundlagen der funktionalen Beschreibung von Raum und Zeit',
    3,
    3.1000,
    'draft',
    1,
    'Kapitel 3.1 wird unterabschnittsweise nach dem Weiter-Skript-Prinzip aufgebaut.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1'
);

SET @chapter31_id :=
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
    @chapter31_id,
    '3.1.1',
    'Das Nichts als mathematischer Ausgangspunkt',
    3,
    3.1100,
    'final',
    1,
    'Der Abschnitt grenzt das absolute Nichts von mathematisch und physikalisch strukturierten Formen der Leere ab und leitet funktionale Unterscheidbarkeit als minimale Voraussetzung mathematischer Beschreibung her. Literatur [4] bis [6]; keine nummerierte Gleichung.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.1'
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter31_id,
    `title` = 'Das Nichts als mathematischer Ausgangspunkt',
    `chapter_no` = 3,
    `section_order` = 3.1100,
    `status` = 'final',
    `is_original_contribution` = 1,
    `notes` = 'Der Abschnitt grenzt das absolute Nichts von mathematisch und physikalisch strukturierten Formen der Leere ab und leitet funktionale Unterscheidbarkeit als minimale Voraussetzung mathematischer Beschreibung her. Literatur [4] bis [6]; keine nummerierte Gleichung.'
WHERE `section_code` = '3.1.1';

SET @section_id :=
(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.1'
    LIMIT 1
);

/* ============================================================
   3. Quellen [4] bis [6] anlegen bzw. aktualisieren
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
    4,
    'parmenides_fragmente_diels_kranz_1951',
    'historical_work',
    'Die Fragmente der Vorsokratiker',
    'Griechisch und deutsch, Band 1; Fragmente 28 B2, B3 und B6',
    NULL,
    1951,
    NULL,
    'Weidmann',
    'Berlin',
    '1',
    NULL,
    NULL,
    '6. Auflage',
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'historical',
    8,
    'verified',
    '3.1.1',
    'Erstnennung zur philosophischen Unzugänglichkeit des Nichtseins und zur Bindung von Denken, Sagen und Sein.',
    'Parmenides: Fragmente 28 B2, B3 und B6. In: Diels, Hermann; Kranz, Walther (Hrsg.) (1951): Die Fragmente der Vorsokratiker. Griechisch und deutsch. Band 1. 6. Auflage. Berlin: Weidmann.',
    'Parmenides, Fragmente 28 B2, B3 und B6 [4]',
    'Historische Primärüberlieferung in der Edition von Diels und Kranz.',
    @revision_id
),
(
    5,
    'weinberg_quantum_fields_vol1_1995',
    'book',
    'The Quantum Theory of Fields',
    'Volume I: Foundations',
    1995,
    1995,
    NULL,
    'Cambridge University Press',
    'Cambridge',
    'I',
    NULL,
    NULL,
    '1',
    NULL,
    '978-0-521-55001-7',
    NULL,
    'en',
    1,
    'textbook',
    8,
    'verified',
    '3.1.1',
    'Erstnennung zur Einordnung des quantenfeldtheoretischen Vakuums als strukturierter Grundzustand eines vorausgesetzten formalen Systems.',
    'Weinberg, Steven (1995): The Quantum Theory of Fields. Volume I: Foundations. Cambridge: Cambridge University Press.',
    'Weinberg (1995) [5]',
    'Grundlegende Darstellung der Quantenfeldtheorie; verwendet für den Zustands- und Vakuumbegriff.',
    @revision_id
),
(
    6,
    'halmos_naive_set_theory_1974',
    'book',
    'Naive Set Theory',
    NULL,
    1960,
    1974,
    NULL,
    'Springer-Verlag',
    'New York',
    NULL,
    NULL,
    '1–12',
    'Reprint',
    NULL,
    '978-0-387-90092-6',
    NULL,
    'en',
    1,
    'textbook',
    8,
    'verified',
    '3.1.1',
    'Erstnennung zur leeren Menge als wohldefiniertem mathematischem Objekt innerhalb einer vorausgesetzten Mengenstruktur.',
    'Halmos, Paul R. (1974): Naive Set Theory. New York: Springer-Verlag, insbesondere S. 1–12.',
    'Halmos (1974) [6]',
    'Referenzwerk zur elementaren Mengenlehre und zur begrifflichen Stellung der leeren Menge.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `citation_number` = VALUES(`citation_number`),
    `source_type` = VALUES(`source_type`),
    `title` = VALUES(`title`),
    `subtitle` = VALUES(`subtitle`),
    `year_original` = VALUES(`year_original`),
    `year_edition` = VALUES(`year_edition`),
    `publisher` = VALUES(`publisher`),
    `place` = VALUES(`place`),
    `volume` = VALUES(`volume`),
    `pages` = VALUES(`pages`),
    `edition` = VALUES(`edition`),
    `isbn` = VALUES(`isbn`),
    `language_code` = VALUES(`language_code`),
    `priority` = VALUES(`priority`),
    `evidence_type` = VALUES(`evidence_type`),
    `frzk_relevance` = VALUES(`frzk_relevance`),
    `verification_status` = VALUES(`verification_status`),
    `first_citation_section_code` = VALUES(`first_citation_section_code`),
    `first_citation_note` = VALUES(`first_citation_note`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `notes` = VALUES(`notes`);

/* ============================================================
   4. Autoren und Herausgeber anlegen
   ============================================================ */

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
('Parmenides', NULL, 'Parmenides', NULL, -515, -450, 'Antiker Autor der Fragmente in Quelle [4].'),
('Diels', 'Hermann', 'Diels, Hermann', NULL, 1848, 1922, 'Herausgeber der Fragmente der Vorsokratiker, Quelle [4].'),
('Kranz', 'Walther', 'Kranz, Walther', NULL, 1884, 1960, 'Bearbeiter und Herausgeber der Fragmente der Vorsokratiker, Quelle [4].'),
('Weinberg', 'Steven', 'Weinberg, Steven', NULL, 1933, 2021, 'Autor der Quelle [5].'),
('Halmos', 'Paul R.', 'Halmos, Paul R.', NULL, 1916, 2006, 'Autor der Quelle [6].')
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year` = VALUES(`birth_year`),
    `death_year` = VALUES(`death_year`),
    `notes` = VALUES(`notes`);

/* IDs ermitteln */
SET @source4_id := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 4 LIMIT 1);
SET @source5_id := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 5 LIMIT 1);
SET @source6_id := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 6 LIMIT 1);

SET @parmenides_id := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Parmenides' LIMIT 1);
SET @diels_id      := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Diels, Hermann' LIMIT 1);
SET @kranz_id      := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Kranz, Walther' LIMIT 1);
SET @weinberg_id   := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Weinberg, Steven' LIMIT 1);
SET @halmos_id     := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Halmos, Paul R.' LIMIT 1);

/* ============================================================
   5. Quellen-Autoren-Zuordnungen
   ============================================================ */

INSERT IGNORE INTO `source_authors`
(`source_id`, `author_id`, `author_order`, `role`)
VALUES
(@source4_id, @parmenides_id, 1, 'author'),
(@source4_id, @diels_id,      1, 'editor'),
(@source4_id, @kranz_id,      2, 'editor'),
(@source5_id, @weinberg_id,   1, 'author'),
(@source6_id, @halmos_id,     1, 'author');

/* ============================================================
   6. Quellenverwendungen für Abschnitt 3.1.1
   ============================================================ */

DELETE FROM `source_usage`
WHERE `section_id` = @section_id
  AND `source_id` IN (@source4_id, @source5_id, @source6_id);

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
    @source4_id,
    @section_id,
    'first_citation',
    'Parmenides dient als historische Grundlage für die Aussage, dass das Nichtseiende weder widerspruchsfrei gedacht noch sprachlich bestimmt werden kann.',
    'Abschnitt 3.1.1, Absatz 3',
    1,
    1,
    'Erstnennung der Quelle [4].',
    @revision_id
),
(
    @source5_id,
    @section_id,
    'first_citation',
    'Weinberg stützt die Einordnung des quantenfeldtheoretischen Vakuums als definierten und strukturierten Grundzustand eines bereits vorausgesetzten formalen Systems.',
    'Abschnitt 3.1.1, Absatz 4',
    1,
    1,
    'Erstnennung der Quelle [5].',
    @revision_id
),
(
    @source6_id,
    @section_id,
    'first_citation',
    'Halmos stützt die Abgrenzung der leeren Menge vom absoluten Nichts, da die leere Menge ein wohldefiniertes Objekt innerhalb einer Mengenlehre ist.',
    'Abschnitt 3.1.1, Absatz 6',
    1,
    1,
    'Erstnennung der Quelle [6].',
    @revision_id
);

/* ============================================================
   7. Quellenannotationen
   ============================================================ */

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
SELECT
    @source4_id,
    'Historische Bestimmung des Verhältnisses von Sein, Denken und Nichtsein.',
    'Begründet die erkenntnistheoretische Unzugänglichkeit eines absolut voraussetzungslosen Nichts.',
    'Beleg der frühen philosophischen Problematisierung des Nichtseins.',
    'Übernommen wird ausschließlich der Hinweis, dass die sprachliche oder gedankliche Bestimmung des Nichts bereits eine Unterscheidung voraussetzt.',
    'Die ontologische Gesamtposition des Parmenides wird nicht vollständig übernommen.',
    'Die Quelle wird als historischer Ausgangspunkt, nicht als unmittelbare formale Grundlage des FRZK verwendet.',
    'reviewed',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM `annotations` WHERE `source_id` = @source4_id
);

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
SELECT
    @source5_id,
    'Systematische Darstellung des quantenfeldtheoretischen Zustands- und Vakuumbegriffes.',
    'Ermöglicht die Abgrenzung des physikalischen Vakuums vom absoluten Nichts.',
    'Beleg dafür, dass das Vakuum ein Zustand innerhalb einer bereits definierten Theorie ist.',
    'Übernommen wird die Einordnung des Vakuums als mathematisch strukturierter Grundzustand.',
    'Die Quelle behandelt keine metaphysische Theorie des Nichts.',
    'Die Verwendung bleibt auf die begriffliche Abgrenzung zwischen Vakuum und absolutem Nichts beschränkt.',
    'reviewed',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM `annotations` WHERE `source_id` = @source5_id
);

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
SELECT
    @source6_id,
    'Elementare Darstellung der Mengenlehre und der leeren Menge.',
    'Begründet die Unterscheidung zwischen einer leeren mathematischen Struktur und der Abwesenheit jeder Struktur.',
    'Beleg dafür, dass die leere Menge ein definiertes mathematisches Objekt ist.',
    'Übernommen wird die Stellung der leeren Menge innerhalb eines bereits vorausgesetzten Axiomen- und Relationssystems.',
    'Die naive Mengenlehre ersetzt keine vollständige axiomatische Fundierung.',
    'Die Quelle wird zur begrifflichen Abgrenzung verwendet, nicht als vollständige mengentheoretische Grundlage des FRZK.',
    'reviewed',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM `annotations` WHERE `source_id` = @source6_id
);

/* ============================================================
   8. Änderungsprotokoll
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
    '3.1.1',
    'Abschnitt 3.1.1 wurde schemagerecht angelegt beziehungsweise aktualisiert.',
    NULL,
    'Status final; Originalbeitrag; Literatur [4] bis [6]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `section_id` = @section_id
      AND `change_type` = 'created'
      AND `object_reference` = '3.1.1'
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
    'sources',
    '[4]–[6]',
    'Die Quellen [4] bis [6] wurden angelegt, mit Autorenrollen versehen, annotiert und dem Abschnitt 3.1.1 als Erstnennungen zugeordnet.',
    NULL,
    '3 neue Quellen; 5 Autoren bzw. Herausgeber; 3 Quellenverwendungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `section_id` = @section_id
      AND `change_type` = 'source_added'
      AND `object_reference` = '[4]–[6]'
);

/* ============================================================
   9. Validierung
   ============================================================ */

SET @source_count :=
(
    SELECT COUNT(*)
    FROM `sources`
    WHERE `citation_number` BETWEEN 4 AND 6
);

SET @usage_count :=
(
    SELECT COUNT(*)
    FROM `source_usage`
    WHERE `section_id` = @section_id
      AND `source_id` IN (@source4_id, @source5_id, @source6_id)
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
    'K3_1_1_SOURCES_4_6',
    IF(@source_count = 3, 'passed', 'failed'),
    '3',
    CAST(@source_count AS CHAR),
    'Prüft das Vorhandensein der Literaturquellen [4] bis [6].'
),
(
    @revision_id,
    'K3_1_1_SOURCE_USAGE',
    IF(@usage_count = 3, 'passed', 'failed'),
    '3',
    CAST(@usage_count AS CHAR),
    'Prüft die drei Quellenverwendungen in Abschnitt 3.1.1.'
),
(
    @revision_id,
    'K3_1_1_NO_EQUATIONS',
    IF(@equation_count = 0, 'passed', 'failed'),
    '0',
    CAST(@equation_count AS CHAR),
    'Abschnitt 3.1.1 enthält keine nummerierte Gleichung.'
)
ON DUPLICATE KEY UPDATE
    `validation_status` = VALUES(`validation_status`),
    `expected_value` = VALUES(`expected_value`),
    `actual_value` = VALUES(`actual_value`),
    `validation_message` = VALUES(`validation_message`),
    `checked_at` = CURRENT_TIMESTAMP;

/* ============================================================
   10. Repository-Zähler
   ============================================================ */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
('last_completed_section', '3.1.1'),
('last_citation_number', '6'),
('next_citation_number', '7')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* Kein Gleichungszähler wird angelegt oder verändert. */

COMMIT;

/* ============================================================
   Kontrollausgaben
   ============================================================ */

SELECT
    `section_id`,
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3', '3.1', '3.1.1')
ORDER BY `section_order`, `section_code`;

SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`verification_status`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`
FROM `sources` s
JOIN `source_usage` su
  ON su.`source_id` = s.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

SELECT
    `validation_code`,
    `validation_status`,
    `expected_value`,
    `actual_value`,
    `validation_message`
FROM `repository_validation_results`
WHERE `revision_id` = @revision_id
ORDER BY `validation_code`;
