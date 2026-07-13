USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.3
   Funktionen als mathematische Grundlage gerichteter Transformationen

   Verwendete bestehende Quellen:
   [29] Lang, Undergraduate Analysis
   [30] Rudin, Principles of Mathematical Analysis

   Gleichungen:
   (3.10) Funktion
   (3.11) Eindeutige Zuordnung
   (3.12) Funktionskomposition
   (3.13) Iterative Entwicklung

   Neue Quellen: keine
   Nächste freie Literaturnummer bleibt [59].
   ============================================================ */

/* 1. Revision idempotent anlegen oder wiederverwenden. */
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
    'RKB-2026-07-12-K3.2.3-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.3',
    '1.0',
    'Neufassung von Abschnitt 3.2.3 mit den Gleichungen (3.10) bis (3.13) und den bestehenden Quellen [29] und [30].',
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

/* 2. Abschnitt ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.3'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Funktionen als mathematische Grundlage gerichteter Transformationen',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [29] und [30] und enthält die Gleichungen (3.10) bis (3.13).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* 4. Quellenverwendungen des Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* [29] Lang */
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
    'Lang dient als Referenz für den allgemeinen Funktionsbegriff, Definitions- und Zielmengen sowie die eindeutige Zuordnung.',
    'Abschnitt 3.2.3',
    0,
    1,
    'Wiederverwendung der bereits vorhandenen Quelle [29].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 29;

/* [30] Rudin */
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
    'Rudin dient als Referenz für Funktionen, Kompositionen und iterative mathematische Entwicklungen in der Analysis.',
    'Abschnitt 3.2.3',
    0,
    1,
    'Wiederverwendung der bereits vorhandenen Quelle [30].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 30;

/* 5. Quellen-IDs für Gleichungen bestimmen. */
SET @source_29_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 29
    LIMIT 1
);

SET @source_30_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 30
    LIMIT 1
);

/* 6. Alte Belegungen der Gleichungsnummern (3.10) bis (3.13) bereinigen.
      Dies entfernt insbesondere ältere Fassungen aus 3.2.2. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.10','3.11','3.12','3.13');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.10','3.11','3.12','3.13');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.10','3.11','3.12','3.13');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.10','3.11','3.12','3.13');

/* 7. Gleichungen der Neufassung einfügen. */
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
VALUES
(
    '3.10',
    @section_id,
    'Funktion zwischen zwei Mengen',
    'f:A\\rightarrow B',
    'f:A\\rightarrow B',
    'Die Funktion f bildet Elemente der Definitionsmenge A in die Zielmenge B ab.',
    'definition',
    'literature',
    @source_29_id,
    NULL,
    'A und B sind Mengen; f ist eine eindeutige Abbildung.',
    'checked',
    @revision_id
),
(
    '3.11',
    @section_id,
    'Eindeutige Zuordnung',
    '\\forall x\\in A\\;\\exists!\\;y\\in B:\\;f(x)=y',
    '\\forall x\\in A\\;\\exists!\\;y\\in B:\\;f(x)=y',
    'Jedem Element x der Definitionsmenge A wird genau ein Element y der Zielmenge B zugeordnet.',
    'definition',
    'literature',
    @source_29_id,
    NULL,
    'f ist eine Funktion von A nach B.',
    'checked',
    @revision_id
),
(
    '3.12',
    @section_id,
    'Komposition zweier Funktionen',
    '(g\\circ f)(x)=g(f(x))',
    '(g\\circ f)(x)=g(f(x))',
    'Die Komposition führt zunächst f und anschließend g aus.',
    'definition',
    'literature',
    @source_30_id,
    NULL,
    'f:A\\rightarrow B und g:B\\rightarrow C.',
    'checked',
    @revision_id
),
(
    '3.13',
    @section_id,
    'Iterative Entwicklung',
    'x_{n+1}=f(x_n)',
    'x_{n+1}=f(x_n)',
    'Ein Folgezustand entsteht durch erneute Anwendung derselben Funktion auf den vorhergehenden Zustand.',
    'model',
    'literature',
    @source_30_id,
    NULL,
    'x_n gehört zum Definitionsbereich von f.',
    'checked',
    @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_10 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.10'
    LIMIT 1
);
SET @eq_3_11 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.11'
    LIMIT 1
);
SET @eq_3_12 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.12'
    LIMIT 1
);
SET @eq_3_13 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.13'
    LIMIT 1
);

/* 9. Symbolregister für die vier Gleichungen anlegen. */
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
(@eq_3_10, 'f', 'Funktion', 'Eindeutige Abbildung von A nach B.', NULL, 'f:A\\rightarrow B', 1),
(@eq_3_10, 'A', 'Definitionsmenge', 'Menge der zulässigen Ausgangselemente.', NULL, 'Menge', 2),
(@eq_3_10, 'B', 'Zielmenge', 'Menge der möglichen Zielwerte.', NULL, 'Menge', 3),

(@eq_3_11, 'x', 'Ausgangselement', 'Beliebiges Element der Definitionsmenge A.', NULL, 'x\\in A', 1),
(@eq_3_11, 'y', 'Bildelement', 'Eindeutig zugeordnetes Element der Zielmenge B.', NULL, 'y\\in B', 2),
(@eq_3_11, '\\exists!', 'eindeutige Existenz', 'Es existiert genau ein Element mit der angegebenen Eigenschaft.', NULL, 'logischer Quantor', 3),

(@eq_3_12, 'f', 'erste Funktion', 'Zuerst angewandte Funktion von A nach B.', NULL, 'f:A\\rightarrow B', 1),
(@eq_3_12, 'g', 'zweite Funktion', 'Anschließend angewandte Funktion von B nach C.', NULL, 'g:B\\rightarrow C', 2),
(@eq_3_12, '\\circ', 'Komposition', 'Hintereinanderausführung der Funktionen f und g.', NULL, 'Funktionsverknüpfung', 3),

(@eq_3_13, 'x_n', 'aktueller Zustand', 'Zustand im Iterationsschritt n.', NULL, 'Zustandsmenge', 1),
(@eq_3_13, 'x_{n+1}', 'Folgezustand', 'Zustand nach erneuter Anwendung von f.', NULL, 'Zustandsmenge', 2),
(@eq_3_13, 'f', 'Iterationsfunktion', 'Funktion, die den Folgezustand erzeugt.', NULL, 'f:X\\rightarrow X', 3);

/* 10. Änderungsprotokoll aktualisieren. */
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
    '3.2.3',
    'Abschnitt 3.2.3 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit älterer Gleichungsnummerierung.',
    'Neufassung mit den bestehenden Quellen [29] und [30] sowie den Gleichungen (3.10) bis (3.13).'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'sources',
    '[29], [30]',
    'Die vorhandenen Quellen von Lang und Rudin wurden wiederverwendet.',
    NULL,
    '2 Quellenverwendungen'
),
(
    @revision_id,
    @section_id,
    'equation_changed',
    'equations',
    '(3.10)–(3.13)',
    'Die Gleichungsnummern wurden bereinigt und mit den Funktionsdefinitionen der Neufassung neu belegt.',
    'Ältere Relations- und Funktionsgleichungen unter denselben Nummern.',
    'Funktion, eindeutige Zuordnung, Komposition und iterative Entwicklung.'
);

/* 11. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.14'),
    ('last_edited_section', '3.2.3'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.3-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.3: review
   - 2 Quellenverwendungen: [29], [30]
   - 0 Erstnennungen
   - Gleichungen (3.10) bis (3.13)
   - next_citation_number = 59
   - next_equation_number = 3.14
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.3')
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
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`section_id` = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED);

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
