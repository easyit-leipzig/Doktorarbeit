USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.6
   Axiom A4 – Prinzip stabiler funktionaler Organisation

   Neue Quellen:       keine
   Neue Gleichungen:   (3.68), (3.69)
   Axiom:               A4 (bestehenden Datensatz aktualisieren)
   Axiomabhängigkeiten: A4 depends_on A1, A2 und A3
   Nächste Gleichung:   (3.70)
   Nächstes Axiom:      A5

   WICHTIG:
   Der vorhandene Datensatz A4 wird nicht gelöscht, damit seine
   axiom_id und bestehende eingehende Verweise erhalten bleiben.
   ============================================================ */

INSERT INTO `repository_revisions` (
    `revision_code`, `revision_date`, `scope_type`, `scope_reference`,
    `version_label`, `summary`, `created_by`, `parent_revision_id`
)
VALUES (
    'RKB-2026-07-12-K3.3.6-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.6',
    '1.0',
    'Neufassung von Abschnitt 3.3.6; Aktualisierung von Axiom A4, Registrierung der Gleichungen (3.68) und (3.69) sowie der Abhängigkeiten von A1 bis A3.',
    'Olaf Thiele / ChatGPT',
    (SELECT MAX(r.`revision_id`) FROM `repository_revisions` r)
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3.6'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `title` = 'Axiom A4 – Prinzip stabiler funktionaler Organisation',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A4 sowie die Gleichungen (3.68) und (3.69). Keine neue Literaturquelle.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 wird abschnittsweise als eigenständige axiomatische Grundlage des FRZK neu gefasst.'
WHERE `section_id` = @chapter_id;

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

SET @axiom_a1_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A1' LIMIT 1
);
SET @axiom_a2_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A2' LIMIT 1
);
SET @axiom_a3_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A3' LIMIT 1
);
SET @axiom_a4_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A4' LIMIT 1
);

UPDATE `axioms`
SET
    `section_id` = @section_id,
    `title` = 'Prinzip stabiler funktionaler Organisation',
    `axiom_text` = 'Rekursive funktionale Transformationen besitzen grundsätzlich das Potenzial, stabile funktionale Organisationsstrukturen hervorzubringen.',
    `formal_latex` = '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    `word_latex` = '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    `motivation` = 'Rekursive Transformation allein erzeugt noch keine Organisation. A4 eröffnet die Möglichkeit, dass sich aus fortgesetzter funktionaler Transformation stabile oder metastabile Organisationsformen herausbilden.',
    `independence_note` = 'A4 setzt A1 bis A3 voraus, führt jedoch weder Zustandsraum, Attraktor, Metrik noch zeitliche Dauer als primitive Struktur ein.',
    `consistency_note` = 'Stabilität bedeutet nicht Unveränderlichkeit, sondern die mögliche Erhaltung einer funktionalen Organisationsform trotz weiterer Transformation.',
    `operationalization_note` = 'Funktionale Organisationsräume, Stabilitätsbegriffe und Attraktorstrukturen werden erst in Kapitel 3.4 mathematisch konstruiert.',
    `status` = 'review',
    `created_revision_id` = @revision_id
WHERE `axiom_id` = @axiom_a4_id;

INSERT INTO `axioms` (
    `axiom_number`, `section_id`, `title`, `axiom_text`,
    `formal_latex`, `word_latex`, `motivation`,
    `independence_note`, `consistency_note`,
    `operationalization_note`, `source_assumption_id`,
    `status`, `created_revision_id`
)
SELECT
    'A4',
    @section_id,
    'Prinzip stabiler funktionaler Organisation',
    'Rekursive funktionale Transformationen besitzen grundsätzlich das Potenzial, stabile funktionale Organisationsstrukturen hervorzubringen.',
    '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    'Rekursive Transformation allein erzeugt noch keine Organisation. A4 eröffnet stabile oder metastabile Organisationsbildung.',
    'A4 setzt A1 bis A3 voraus, führt jedoch weder Zustandsraum, Attraktor, Metrik noch Zeitdauer ein.',
    'Stabilität bedeutet nicht Unveränderlichkeit, sondern mögliche Strukturerhaltung trotz Transformation.',
    'Funktionale Organisationsräume und Stabilitätsbegriffe werden erst in Kapitel 3.4 konstruiert.',
    NULL,
    'review',
    @revision_id
WHERE @axiom_a4_id IS NULL;

SET @axiom_a4_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A4' LIMIT 1
);

/* Alte Gleichungsbelegungen vollständig bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from` = 'equation' AND `object_id_from` IN (
        SELECT e.`equation_id` FROM `equations` e
        WHERE e.`equation_number` IN ('3.68','3.69')
    ))
    OR
    (`object_type_to` = 'equation' AND `object_id_to` IN (
        SELECT e.`equation_id` FROM `equations` e
        WHERE e.`equation_number` IN ('3.68','3.69')
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.68','3.69');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.68','3.69');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.68','3.69');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.68','3.69');

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
VALUES (
    '3.68',
    @section_id,
    'Formale Darstellung von Axiom A4',
    '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    'Rekursive funktionale Transformation eröffnet die Möglichkeit stabiler funktionaler Organisation.',
    'axiom',
    'original',
    NULL,
    'Formale Repräsentation des qualitativen Axioms A4.',
    'A1 bis A3 gelten. Organisation und Stabilität werden noch nicht als metrische oder topologische Strukturen vorausgesetzt.',
    'checked',
    @revision_id
);

SET @equation_3_68_id := LAST_INSERT_ID();

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
VALUES (
    '3.69',
    @section_id,
    'Strukturelle Voraussetzung von Axiom A4',
    'A1,\\;A2,\\;A3\\Longrightarrow\\text{Voraussetzung für }A4',
    'A1,\\;A2,\\;A3\\Longrightarrow\\text{Voraussetzung für }A4',
    'Axiom A4 setzt funktionale Unterscheidbarkeit, Relationierbarkeit und rekursive Transformation strukturell voraus, ohne aus ihnen logisch zwingend ableitbar zu sein.',
    'schema',
    'original',
    NULL,
    'Schematische Darstellung der axiomatischen Abhängigkeitsstruktur.',
    'A1, A2 und A3 sind bereits registriert.',
    'checked',
    @revision_id
);

SET @equation_3_69_id := LAST_INSERT_ID();

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@equation_3_68_id, @equation_3_69_id);

INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(
    @equation_3_68_id,
    '\\mathcal{T}_F',
    'rekursive funktionale Transformation',
    'Qualitative Möglichkeit fortgesetzter funktionaler Transformation gemäß Axiom A3.',
    NULL,
    'prämathematisches Transformationssymbol',
    1
),
(
    @equation_3_68_id,
    '\\Diamond',
    'Möglichkeitsoperator',
    'Kennzeichnet, dass stabile Organisation möglich, aber nicht notwendig realisiert ist.',
    NULL,
    'modal-logischer Operator',
    2
),
(
    @equation_3_68_id,
    '\\mathcal{O}_F',
    'stabile funktionale Organisation',
    'Qualitative funktionale Organisationsform, die trotz weiterer Transformation in relevanten Eigenschaften erhalten bleiben kann.',
    NULL,
    'prämathematisches Organisationssymbol',
    3
),
(
    @equation_3_69_id,
    'A1',
    'Axiom der funktionalen Unterscheidbarkeit',
    'Erste strukturelle Voraussetzung für A4.',
    NULL,
    'Axiom',
    1
),
(
    @equation_3_69_id,
    'A2',
    'Axiom der funktionalen Relationierbarkeit',
    'Zweite strukturelle Voraussetzung für A4.',
    NULL,
    'Axiom',
    2
),
(
    @equation_3_69_id,
    'A3',
    'Axiom der rekursiven Transformation',
    'Dritte strukturelle Voraussetzung für A4.',
    NULL,
    'Axiom',
    3
),
(
    @equation_3_69_id,
    'A4',
    'Axiom stabiler funktionaler Organisation',
    'Axiom, dessen strukturelle Voraussetzungen dargestellt werden.',
    NULL,
    'Axiom',
    4
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* Axiomabhängigkeiten erneuern. */
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a4_id;

INSERT INTO `axiom_dependencies` (
    `axiom_id`, `depends_on_axiom_id`,
    `dependency_type`, `note`
)
VALUES
(@axiom_a4_id, @axiom_a1_id, 'depends_on',
 'A4 setzt funktionale Unterscheidbarkeit nach A1 voraus.'),
(@axiom_a4_id, @axiom_a2_id, 'depends_on',
 'A4 setzt funktionale Relationierbarkeit nach A2 voraus.'),
(@axiom_a4_id, @axiom_a3_id, 'depends_on',
 'A4 setzt rekursive funktionale Transformation nach A3 voraus.');

/* Gleichung (3.68) mit Axiom A4 verknüpfen. */
INSERT INTO `object_dependencies` (
    `object_type_from`, `object_id_from`,
    `object_type_to`, `object_id_to`,
    `dependency_type`, `note`
)
VALUES (
    'equation',
    @equation_3_68_id,
    'axiom',
    @axiom_a4_id,
    'derives_from',
    'Gleichung (3.68) ist die formale Darstellung von Axiom A4.'
);

/* Gleichungsabhängigkeiten registrieren. */
SET @equation_3_64_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.64' LIMIT 1
);
SET @equation_3_65_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.65' LIMIT 1
);
SET @equation_3_66_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.66' LIMIT 1
);

INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@equation_3_68_id, @equation_3_66_id, 'uses',
 'Die formale Darstellung von A4 verwendet die in (3.66) eröffnete rekursive Transformation.'),
(@equation_3_69_id, @equation_3_64_id, 'uses',
 'Die strukturelle Voraussetzung von A4 umfasst Axiom A1 beziehungsweise Gleichung (3.64).'),
(@equation_3_69_id, @equation_3_65_id, 'uses',
 'Die strukturelle Voraussetzung von A4 umfasst Axiom A2 beziehungsweise Gleichung (3.65).'),
(@equation_3_69_id, @equation_3_66_id, 'uses',
 'Die strukturelle Voraussetzung von A4 umfasst Axiom A3 beziehungsweise Gleichung (3.66).');

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`,
    `object_type`, `object_reference`, `change_summary`,
    `previous_value`, `new_value`
)
VALUES
(
    @revision_id,
    @section_id,
    'rewritten',
    'section',
    '3.3.6',
    'Abschnitt 3.3.6 wurde vollständig als Axiom A4 – Prinzip stabiler funktionaler Organisation neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.6.',
    'Neufassung mit Axiom A4 sowie den Gleichungen (3.68) und (3.69).'
),
(
    @revision_id,
    @section_id,
    'axiom_added',
    'axiom',
    'A4',
    'Axiom A4 wurde als Prinzip stabiler funktionaler Organisation aktualisiert.',
    '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.68), (3.69)',
    'Die formale Axiomdarstellung und die strukturelle Axiomabhängigkeit wurden registriert.',
    'Frühere Belegungen der Gleichungsnummern.',
    'Stabile funktionale Organisation und A1 bis A3 als Voraussetzungen von A4.'
),
(
    @revision_id,
    @section_id,
    'dependency_added',
    'axiom_dependency',
    'A4 -> A1, A2, A3',
    'Die strukturellen Abhängigkeiten von A4 von A1 bis A3 wurden explizit registriert.',
    NULL,
    'A4 depends_on A1; A4 depends_on A2; A4 depends_on A3'
);

INSERT INTO `repository_counters` (
    `counter_key`, `counter_value`
)
VALUES
    ('next_equation_number', '3.70'),
    ('next_axiom_number', 'A5'),
    ('last_edited_section', '3.3.6'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.6-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.3.6: review
   - Axiom A4: genau 1 Datensatz
   - Gleichungen: (3.68), (3.69)
   - A4 depends_on A1, A2 und A3
   - (3.68) uses (3.66)
   - (3.69) uses (3.64), (3.65), (3.66)
   - Quellenverwendungen: 0
   - next_equation_number = 3.70
   - next_axiom_number = A5
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.6')
ORDER BY ds.`section_code`;

SELECT
    a.`axiom_id`,
    a.`axiom_number`,
    a.`title`,
    a.`axiom_text`,
    a.`formal_latex`,
    a.`word_latex`,
    a.`status`
FROM `axioms` a
WHERE a.`axiom_number` = 'A4';

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`equation_type`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.68','3.69')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.68','3.69')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    ad.`dependency_type`,
    a_from.`axiom_number` AS `axiom_number`,
    a_to.`axiom_number` AS `depends_on_axiom`,
    ad.`note`
FROM `axiom_dependencies` ad
INNER JOIN `axioms` a_from
    ON a_from.`axiom_id` = ad.`axiom_id`
INNER JOIN `axioms` a_to
    ON a_to.`axiom_id` = ad.`depends_on_axiom_id`
WHERE ad.`axiom_id` = @axiom_a4_id
ORDER BY a_to.`axiom_number`;

SELECT
    ed.`dependency_type`,
    e_from.`equation_number` AS `equation_number`,
    e_to.`equation_number` AS `depends_on_equation`,
    ed.`dependency_note`
FROM `equation_dependencies` ed
INNER JOIN `equations` e_from
    ON e_from.`equation_id` = ed.`equation_id`
INNER JOIN `equations` e_to
    ON e_to.`equation_id` = ed.`depends_on_equation_id`
WHERE e_from.`equation_number` IN ('3.68','3.69')
ORDER BY
    CAST(SUBSTRING_INDEX(e_from.`equation_number`,'.',-1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(e_to.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    COUNT(*) AS `registered_source_usages`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'next_axiom_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
