USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.5
   Operatorentheorie als mathematische Grundlage funktionaler Transformationen

   Quellen:
   [35] Conway – Erstnennung
   [36] Kreyszig – Erstnennung
   [37] Strogatz – Erstnennung

   Gleichungen:
   (3.19) Operator
   (3.20) Operatorwirkung
   (3.21) Linearität
   (3.22) Nichtlinearität
   (3.23) Operatorkomposition
   (3.24) Operatoriteration

   Neue Quellen: keine
   ============================================================ */

/* 1. Revision idempotent anlegen bzw. wiederverwenden. */
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
    'RKB-2026-07-12-K3.2.5-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.5',
    '1.0',
    'Neufassung von Abschnitt 3.2.5 mit den Quellen [35] bis [37] und den Gleichungen (3.19) bis (3.24).',
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

/* 2. Abschnitts-ID ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.5'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Operatorentheorie als mathematische Grundlage funktionaler Transformationen',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [35] bis [37] und enthält die Gleichungen (3.19) bis (3.24).'
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

/* [35] Conway */
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
    'Conway dient als Hauptreferenz für Operatoren auf Banach- und Hilberträumen, Linearität und Operatorkomposition.',
    'Abschnitt 3.2.5',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [35].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 35;

/* [36] Kreyszig */
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
    'Kreyszig dient als ergänzende Referenz für normierte Räume, lineare Operatoren und Anwendungen der Funktionalanalysis.',
    'Abschnitt 3.2.5',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [36].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 36;

/* [37] Strogatz */
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
    'Strogatz dient als Referenz für nichtlineare Transformationen, Iteration, Fixpunkte und dynamische Konsequenzen rekursiver Operatoranwendung.',
    'Abschnitt 3.2.5',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [37].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 37;

/* 5. Quellen-IDs bestimmen. */
SET @source_35_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 35
    LIMIT 1
);

SET @source_37_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 37
    LIMIT 1
);

/* 6. Alte Belegungen der Gleichungsnummern (3.19) bis (3.24) bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.19','3.20','3.21','3.22','3.23','3.24');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.19','3.20','3.21','3.22','3.23','3.24');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.19','3.20','3.21','3.22','3.23','3.24');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.19','3.20','3.21','3.22','3.23','3.24');

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
    '3.19',
    @section_id,
    'Allgemeiner Operator',
    'T:X\\rightarrow Y',
    'T:X\\rightarrow Y',
    'Ein Operator T bildet Elemente eines mathematischen Raumes X in einen mathematischen Raum Y ab.',
    'definition',
    'literature',
    @source_35_id,
    NULL,
    'X und Y sind geeignete mathematische Räume.',
    'checked',
    @revision_id
),
(
    '3.20',
    @section_id,
    'Wirkung eines Operators',
    'y=T(x)',
    'y=T(x)',
    'Das Element x wird durch den Operator T auf das Element y abgebildet.',
    'definition',
    'literature',
    @source_35_id,
    NULL,
    'x gehört zum Definitionsbereich von T.',
    'checked',
    @revision_id
),
(
    '3.21',
    @section_id,
    'Linearität eines Operators',
    'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)',
    'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)',
    'Ein linearer Operator erhält Linearkombinationen.',
    'definition',
    'literature',
    @source_35_id,
    NULL,
    'X und Y sind Vektorräume über demselben Körper; x,y\\in X und \\alpha,\\beta sind Skalare.',
    'checked',
    @revision_id
),
(
    '3.22',
    @section_id,
    'Nichtlinearität eines Operators',
    'T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)',
    'T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)',
    'Ein nichtlinearer Operator erfüllt die Linearitätsbedingung im Allgemeinen nicht.',
    'definition',
    'literature',
    @source_37_id,
    NULL,
    'Es existieren x,y,\\alpha,\\beta, für die die Linearitätsgleichung nicht gilt.',
    'checked',
    @revision_id
),
(
    '3.23',
    @section_id,
    'Komposition zweier Operatoren',
    '(T\\circ S)(x)=T(S(x))',
    '(T\\circ S)(x)=T(S(x))',
    'Die Operatorkomposition führt zunächst S und anschließend T aus.',
    'definition',
    'literature',
    @source_35_id,
    NULL,
    'S:X\\rightarrow Y und T:Y\\rightarrow Z.',
    'checked',
    @revision_id
),
(
    '3.24',
    @section_id,
    'Iteration eines Operators',
    'x_{n+1}=T(x_n)',
    'x_{n+1}=T(x_n)',
    'Durch wiederholte Anwendung desselben Operators entsteht eine rekursive Zustandsfolge.',
    'model',
    'literature',
    @source_37_id,
    NULL,
    'T bildet den betrachteten Zustandsbereich in sich selbst ab.',
    'checked',
    @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_19 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.19'
    LIMIT 1
);
SET @eq_3_20 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.20'
    LIMIT 1
);
SET @eq_3_21 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.21'
    LIMIT 1
);
SET @eq_3_22 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.22'
    LIMIT 1
);
SET @eq_3_23 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.23'
    LIMIT 1
);
SET @eq_3_24 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.24'
    LIMIT 1
);

/* 9. Symbolregister anlegen. */
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
(@eq_3_19, 'T', 'Operator', 'Abbildung zwischen den mathematischen Räumen X und Y.', NULL, 'T:X\\rightarrow Y', 1),
(@eq_3_19, 'X', 'Definitionsraum', 'Raum der zulässigen Eingabeelemente.', NULL, 'mathematischer Raum', 2),
(@eq_3_19, 'Y', 'Zielraum', 'Raum der möglichen Ausgabeelemente.', NULL, 'mathematischer Raum', 3),

(@eq_3_20, 'x', 'Eingabeelement', 'Element aus dem Definitionsbereich des Operators.', NULL, 'x\\in X', 1),
(@eq_3_20, 'y', 'Ausgabeelement', 'Bild von x unter dem Operator T.', NULL, 'y\\in Y', 2),
(@eq_3_20, 'T', 'Operator', 'Transformation des Eingabeelements x.', NULL, 'T:X\\rightarrow Y', 3),

(@eq_3_21, '\\alpha', 'erster Skalar', 'Skalarer Koeffizient der Linearkombination.', NULL, 'Skalarkörper', 1),
(@eq_3_21, '\\beta', 'zweiter Skalar', 'Skalarer Koeffizient der Linearkombination.', NULL, 'Skalarkörper', 2),
(@eq_3_21, 'T', 'linearer Operator', 'Operator, der Linearkombinationen erhält.', NULL, 'linearer Operator', 3),

(@eq_3_22, 'T', 'nichtlinearer Operator', 'Operator, der die Linearitätsbedingung im Allgemeinen nicht erfüllt.', NULL, 'Operator', 1),
(@eq_3_22, '\\neq', 'Ungleichheit', 'Kennzeichnet die Verletzung der Linearitätsbedingung.', NULL, 'Relation', 2),

(@eq_3_23, 'S', 'erster Operator', 'Zuerst angewandter Operator.', NULL, 'S:X\\rightarrow Y', 1),
(@eq_3_23, 'T', 'zweiter Operator', 'Anschließend angewandter Operator.', NULL, 'T:Y\\rightarrow Z', 2),
(@eq_3_23, '\\circ', 'Operatorkomposition', 'Hintereinanderausführung der Operatoren S und T.', NULL, 'Operatorverknüpfung', 3),

(@eq_3_24, 'x_n', 'aktueller Zustand', 'Zustand im Iterationsschritt n.', NULL, 'Zustandsbereich', 1),
(@eq_3_24, 'x_{n+1}', 'Folgezustand', 'Zustand nach erneuter Anwendung von T.', NULL, 'Zustandsbereich', 2),
(@eq_3_24, 'T', 'Iterationsoperator', 'Operator, der die rekursive Folge erzeugt.', NULL, 'T:X\\rightarrow X', 3);

/* 10. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_3_20,
    @eq_3_19,
    'uses',
    'Die Operatorwirkung konkretisiert die allgemeine Operatordefinition.'
),
(
    @eq_3_21,
    @eq_3_19,
    'special_case_of',
    'Lineare Operatoren bilden eine spezielle Klasse allgemeiner Operatoren.'
),
(
    @eq_3_22,
    @eq_3_21,
    'contrasts',
    'Die Nichtlinearität wird durch die Verletzung der Linearitätsbedingung abgegrenzt.'
),
(
    @eq_3_23,
    @eq_3_19,
    'uses',
    'Die Komposition setzt kompatible Operatoren voraus.'
),
(
    @eq_3_24,
    @eq_3_20,
    'uses',
    'Die Iteration beruht auf der wiederholten Operatorwirkung.'
),
(
    @eq_3_24,
    @eq_3_23,
    'special_case_of',
    'Die Iteration ist eine wiederholte Komposition desselben Operators.'
);

/* 11. Änderungsprotokoll aktualisieren. */
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
    '3.2.5',
    'Abschnitt 3.2.5 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit den Gleichungen (3.31) bis (3.36).',
    'Neufassung mit den Quellen [35] bis [37] und den Gleichungen (3.19) bis (3.24).'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'sources',
    '[35]–[37]',
    'Die bestehenden Quellen Conway, Kreyszig und Strogatz wurden in ihrer ersten Textnennung registriert.',
    NULL,
    '3 Quellenverwendungen'
),
(
    @revision_id,
    @section_id,
    'equation_changed',
    'equations',
    '(3.19)–(3.24)',
    'Die Operatorgleichungen wurden neu nummeriert und inhaltlich an die Neufassung angepasst.',
    'Ältere Gleichungsbelegungen und die bisherige Nummerierung (3.31) bis (3.36).',
    'Operator, Operatorwirkung, Linearität, Nichtlinearität, Komposition und Iteration.'
);

/* 12. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.25'),
    ('last_edited_section', '3.2.5'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.5-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.5: review
   - 3 Quellenverwendungen: [35], [36], [37]
   - 3 Erstnennungen
   - Gleichungen (3.19) bis (3.24)
   - next_citation_number = 59
   - next_equation_number = 3.25
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.5')
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
    ed.`dependency_type`,
    e1.`equation_number` AS `equation_number`,
    e2.`equation_number` AS `depends_on`,
    ed.`dependency_note`
FROM `equation_dependencies` ed
INNER JOIN `equations` e1
    ON e1.`equation_id` = ed.`equation_id`
INNER JOIN `equations` e2
    ON e2.`equation_id` = ed.`depends_on_equation_id`
WHERE e1.`section_id` = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e1.`equation_number`, '.', -1) AS UNSIGNED);

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
