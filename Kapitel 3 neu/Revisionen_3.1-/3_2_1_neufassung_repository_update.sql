USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.1 – Mengen als Grundlage mathematischer Modellbildung
   Revisionsskript zur Neufassung

   Repository-konsistente Literatur:
   [23] Cantor – bereits vorhanden
   [58] Fraenkel / Bar-Hillel / Levy – neu

   Gleichungen:
   (3.3) wird inhaltlich aktualisiert.
   Die alten Gleichungen (3.4)–(3.8) dieses Abschnitts werden entfernt,
   da sie in der Neufassung nicht mehr enthalten sind.
   ============================================================ */

/* ------------------------------------------------------------
   1. Revision idempotent anlegen oder wiederverwenden
   ------------------------------------------------------------ */

INSERT INTO `repository_revisions` (
    `revision_code`,
    `revision_date`,
    `scope_type`,
    `scope_reference`,
    `version_label`,
    `summary`,
    `created_by`,
    `parent_revision_id`
)
VALUES (
    'RKB-2026-07-12-K3.2.1-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.1',
    '1.0',
    'Neufassung von Abschnitt 3.2.1: Mengen als Grundlage mathematischer Modellbildung; Bereinigung der bisherigen Literaturverwendungen und Gleichungen.',
    'Olaf Thiele / ChatGPT',
    (
        SELECT MAX(r.`revision_id`)
        FROM `repository_revisions` r
    )
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* ------------------------------------------------------------
   2. Abschnitts-ID ermitteln und validieren
   ------------------------------------------------------------ */

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.1'
    LIMIT 1
);

SELECT
    CASE
        WHEN @section_id IS NULL
        THEN 'FEHLER: Abschnitt 3.2.1 existiert nicht.'
        ELSE CONCAT('OK: section_id=', @section_id)
    END AS `section_validation`;

/* ------------------------------------------------------------
   3. Abschnittsmetadaten aktualisieren
   ------------------------------------------------------------ */

UPDATE `dissertation_sections`
SET
    `title` = 'Mengen als Grundlage mathematischer Modellbildung',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt behandelt Mengen als etablierten mathematischen Forschungsstand, verwendet die Quellen [23] und [58] und enthält ausschließlich die aktualisierte Gleichung (3.3).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird abschnittsweise vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* ------------------------------------------------------------
   4. Neue Autoren idempotent anlegen
   ------------------------------------------------------------ */

INSERT INTO `authors` (
    `family_name`,
    `given_names`,
    `normalized_name`,
    `notes`
)
VALUES (
    'Fraenkel',
    'Abraham A.',
    'Fraenkel, Abraham A.',
    'Mitautor von Foundations of Set Theory.'
)
ON DUPLICATE KEY UPDATE
    `author_id` = LAST_INSERT_ID(`author_id`),
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`);

SET @author_fraenkel := LAST_INSERT_ID();

INSERT INTO `authors` (
    `family_name`,
    `given_names`,
    `normalized_name`,
    `notes`
)
VALUES (
    'Bar-Hillel',
    'Yehoshua',
    'Bar-Hillel, Yehoshua',
    'Mitautor von Foundations of Set Theory.'
)
ON DUPLICATE KEY UPDATE
    `author_id` = LAST_INSERT_ID(`author_id`),
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`);

SET @author_bar_hillel := LAST_INSERT_ID();

INSERT INTO `authors` (
    `family_name`,
    `given_names`,
    `normalized_name`,
    `notes`
)
VALUES (
    'Levy',
    'Azriel',
    'Levy, Azriel',
    'Mitautor von Foundations of Set Theory.'
)
ON DUPLICATE KEY UPDATE
    `author_id` = LAST_INSERT_ID(`author_id`),
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`);

SET @author_levy := LAST_INSERT_ID();

/* ------------------------------------------------------------
   5. Neue Quelle [58] idempotent anlegen
   ------------------------------------------------------------ */

INSERT INTO `sources` (
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
VALUES (
    58,
    'fraenkel_bar_hillel_levy_foundations_set_theory_1973',
    'book',
    'Foundations of Set Theory',
    NULL,
    1958,
    1973,
    NULL,
    'North-Holland',
    'Amsterdam',
    NULL,
    NULL,
    NULL,
    'Second Revised Edition',
    NULL,
    NULL,
    NULL,
    'en',
    5,
    'reference',
    4,
    'needs_review',
    '3.2.1',
    'Erstnennung in der Neufassung von Abschnitt 3.2.1.',
    'Fraenkel, Abraham A.; Bar-Hillel, Yehoshua; Levy, Azriel: Foundations of Set Theory. Second Revised Edition. Amsterdam: North-Holland, 1973.',
    'Fraenkel, Bar-Hillel und Levy [58]',
    'Referenzwerk zur axiomatischen Mengenlehre und zu den Grundlagen von ZFC.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `title` = VALUES(`title`),
    `year_original` = VALUES(`year_original`),
    `year_edition` = VALUES(`year_edition`),
    `publisher` = VALUES(`publisher`),
    `place` = VALUES(`place`),
    `edition` = VALUES(`edition`),
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

SET @source_58 := LAST_INSERT_ID();

/* ------------------------------------------------------------
   6. Autorenzuordnungen für Quelle [58] aktualisieren
   ------------------------------------------------------------ */

DELETE FROM `source_authors`
WHERE `source_id` = @source_58;

INSERT INTO `source_authors` (
    `source_id`,
    `author_id`,
    `author_order`,
    `role`
)
VALUES
    (@source_58, @author_fraenkel, 1, 'author'),
    (@source_58, @author_bar_hillel, 2, 'author'),
    (@source_58, @author_levy, 3, 'author');

/* ------------------------------------------------------------
   7. Alte Quellenverwendungen des Abschnitts entfernen
   ------------------------------------------------------------ */

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* ------------------------------------------------------------
   8. Neue Quellenverwendungen einzeln eintragen
   Keine UNION-Unterabfrage, daher kein Aliasproblem.
   ------------------------------------------------------------ */

/* [23] Cantor – bestehende Quelle, erneute Verwendung */
INSERT INTO `source_usage` (
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
    'state_of_research',
    'Cantors Arbeiten begründen die systematische Theorie unendlicher Mengen und die allgemeine mengentheoretische Abstraktion.',
    'Abschnitt 3.2.1',
    0,
    1,
    'Die Quelle wurde bereits im bisherigen Repository als [23] erstgenannt und wird in der Neufassung wiederverwendet.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 23;

/* [58] Fraenkel / Bar-Hillel / Levy – Erstnennung */
INSERT INTO `source_usage` (
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
    'Das Werk systematisiert die axiomatischen Grundlagen der Mengenlehre und die für ZFC charakteristischen Existenz- und Bildungsbedingungen.',
    'Abschnitt 3.2.1',
    1,
    0,
    'Neue Quelle der Neufassung; bibliografische Detailprüfung bleibt im Repository als needs_review markiert.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 58;

/* ------------------------------------------------------------
   9. Alte Gleichungen (3.4)–(3.8) sicher entfernen
   Zuerst abhängige Zuordnungen löschen.
   ------------------------------------------------------------ */

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`section_id` = @section_id
  AND e.`equation_number` IN ('3.4', '3.5', '3.6', '3.7', '3.8');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`section_id` = @section_id
  AND e.`equation_number` IN ('3.4', '3.5', '3.6', '3.7', '3.8');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`section_id` = @section_id
  AND e.`equation_number` IN ('3.4', '3.5', '3.6', '3.7', '3.8');

DELETE FROM `equations`
WHERE `section_id` = @section_id
  AND `equation_number` IN ('3.4', '3.5', '3.6', '3.7', '3.8');

/* ------------------------------------------------------------
   10. Gleichung (3.3) aktualisieren oder ergänzen
   ------------------------------------------------------------ */

SET @cantor_source_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 23
    LIMIT 1
);

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Endliche Mengendarstellung',
    `equation_latex` = 'M=\\{x_1,x_2,\\ldots,x_n\\}',
    `word_latex` = 'M=\\{x_1,x_2,\\ldots,x_n\\}',
    `plain_description` = 'Darstellung einer endlichen Menge M durch die Aufzählung ihrer Elemente.',
    `equation_type` = 'definition',
    `provenance` = 'literature',
    `source_id` = @cantor_source_id,
    `derivation` = NULL,
    `assumptions` = 'Die Elemente x_1 bis x_n sind unterscheidbar und gehören zur Menge M.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.3';

INSERT INTO `equations` (
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
SELECT
    '3.3',
    @section_id,
    'Endliche Mengendarstellung',
    'M=\\{x_1,x_2,\\ldots,x_n\\}',
    'M=\\{x_1,x_2,\\ldots,x_n\\}',
    'Darstellung einer endlichen Menge M durch die Aufzählung ihrer Elemente.',
    'definition',
    'literature',
    @cantor_source_id,
    NULL,
    'Die Elemente x_1 bis x_n sind unterscheidbar und gehören zur Menge M.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM `equations` e
    WHERE e.`equation_number` = '3.3'
);

/* ------------------------------------------------------------
   11. Symbolzuordnungen zu Gleichung (3.3) aktualisieren
   ------------------------------------------------------------ */

SET @equation_3_3_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.3'
    LIMIT 1
);

DELETE FROM `equation_symbols`
WHERE `equation_id` = @equation_3_3_id;

INSERT INTO `equation_symbols` (
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
        @equation_3_3_id,
        'M',
        'Menge',
        'Endliche Menge der betrachteten Elemente.',
        NULL,
        'Menge',
        1
    ),
    (
        @equation_3_3_id,
        'x_i',
        'Mengenelement',
        'i-tes unterscheidbares Element der Menge M.',
        NULL,
        'x_i\\in M',
        2
    ),
    (
        @equation_3_3_id,
        'n',
        'Elementanzahl',
        'Endliche Anzahl der in der Darstellung aufgeführten Elemente.',
        NULL,
        'n\\in\\mathbb{N}',
        3
    );

/* ------------------------------------------------------------
   12. Änderungsprotokoll idempotent neu schreiben
   ------------------------------------------------------------ */

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
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
    '3.2.1',
    'Abschnitt 3.2.1 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit vier Quellen [23]–[26] und sechs Gleichungen (3.3)–(3.8).',
    'Neufassung mit den Quellen [23] und [58] sowie ausschließlich Gleichung (3.3).'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'source',
    '[58]',
    'Fraenkel, Bar-Hillel und Levy wurden als neue Quelle zur axiomatischen Mengenlehre aufgenommen.',
    NULL,
    'Foundations of Set Theory, 1973.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source',
    '[23]',
    'Cantors Primärarbeit wird mit ihrer bestehenden Literaturnummer wiederverwendet.',
    NULL,
    'Cantor [23].'
),
(
    @revision_id,
    @section_id,
    'equation_changed',
    'equation',
    '(3.3)',
    'Gleichung (3.3) wurde an die Neufassung angepasst.',
    'M=\\{x\\mid x\\ \\text{erfüllt Eigenschaft}\\ P\\}',
    'M=\\{x_1,x_2,\\ldots,x_n\\}'
),
(
    @revision_id,
    @section_id,
    'other',
    'equations',
    '(3.4)–(3.8)',
    'Die in der Neufassung nicht mehr verwendeten Gleichungen wurden einschließlich ihrer Symbol- und Abhängigkeitszuordnungen entfernt.',
    '(3.4)–(3.8) waren dem Abschnitt 3.2.1 zugeordnet.',
    'Keine entsprechenden Gleichungen mehr in Abschnitt 3.2.1.'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.2.1',
    'Der Abschnitt verbleibt bis zur Endredaktion im Status review.',
    'review',
    'review'
);

/* ------------------------------------------------------------
   13. Repository-Zähler aktualisieren
   ------------------------------------------------------------ */

INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.4'),
    ('last_edited_section', '3.2.1'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.1-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* ------------------------------------------------------------
   14. Transaktion abschließen
   ------------------------------------------------------------ */

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartete Ergebnisse:
   - Abschnitt 3.2.1: review
   - 2 Quellenverwendungen: [23], [58]
   - 1 Erstnennung: [58]
   - 1 Gleichung: (3.3)
   - Gleichungen (3.4)–(3.8) nicht mehr in Abschnitt 3.2.1
   - next_citation_number = 59
   - next_equation_number = 3.4
   ============================================================ */

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    ds.`notes`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.1')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`), 0) AS `first_mentions_in_section`,
    GROUP_CONCAT(
        s.`citation_number`
        ORDER BY s.`citation_number`
        SEPARATOR ', '
    ) AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

SELECT
    s.`citation_number`,
    s.`full_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`claim_summary`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`section_id` = @section_id
ORDER BY e.`equation_number`;

SELECT
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`definition_text`,
    es.`domain_text`
FROM `equation_symbols` es
WHERE es.`equation_id` = @equation_3_3_id
ORDER BY es.`symbol_order`;

SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY `counter_key`;

SELECT
    rr.`revision_id`,
    rr.`revision_code`,
    rr.`scope_reference`,
    rr.`version_label`,
    rr.`revision_date`
FROM `repository_revisions` rr
WHERE rr.`revision_id` = @revision_id;
