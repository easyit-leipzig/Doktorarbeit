USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.5
   Axiom A3 – Prinzip der rekursiven Transformation

   Neue Quellen:       keine
   Neue Gleichungen:   (3.66), (3.67)
   Axiom:               A3 (bestehenden Datensatz aktualisieren)
   Axiomabhängigkeiten: A3 depends_on A1 und A2
   Nächste Gleichung:   (3.68)
   Nächstes Axiom:      A4

   WICHTIG:
   Der vorhandene Datensatz A3 wird nicht gelöscht, damit seine
   axiom_id und bestehende eingehende Verweise erhalten bleiben.
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
    'RKB-2026-07-12-K3.3.5-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.5',
    '1.0',
    'Neufassung von Abschnitt 3.3.5; Aktualisierung von Axiom A3, Registrierung der Gleichungen (3.66) und (3.67) sowie der Abhängigkeiten von A1 und A2.',
    'Olaf Thiele / ChatGPT',
    (
        SELECT MAX(r.`revision_id`)
        FROM `repository_revisions` r
    )
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* 2. Abschnitts- und Kapitel-ID ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3.5'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Axiom A3 – Prinzip der rekursiven Transformation',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A3 sowie die Gleichungen (3.66) und (3.67). Keine neue Literaturquelle.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 wird abschnittsweise als eigenständige axiomatische Grundlage des FRZK neu gefasst.'
WHERE `section_id` = @chapter_id;

/* 4. Abschnitt enthält bewusst keine Literaturverwendung. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 5. Axiom-IDs ermitteln. */
SET @axiom_a1_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A1'
    LIMIT 1
);

SET @axiom_a2_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A2'
    LIMIT 1
);

SET @axiom_a3_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A3'
    LIMIT 1
);

/* 6. Vorhandenes Axiom A3 aktualisieren. */
UPDATE `axioms`
SET
    `section_id` = @section_id,
    `title` = 'Prinzip der rekursiven Transformation',
    `axiom_text` = 'Jede funktionale Relation besitzt grundsätzlich die Möglichkeit, neue funktionale Konfigurationen hervorzubringen, die wiederum funktional relationierbar sind.',
    `formal_latex` = '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)',
    `word_latex` = '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)',
    `motivation` = 'Funktionale Unterscheidbarkeit und Relationierbarkeit erzeugen noch keine Entwicklung. A3 eröffnet die Möglichkeit, dass funktionale Wechselwirkung neue Konfigurationen hervorbringt, die erneut funktional wirksam werden können.',
    `independence_note` = 'A3 setzt A1 und A2 voraus, führt jedoch weder eine fertige Folge, einen Zeitparameter noch einen mathematischen Transformationsoperator ein.',
    `consistency_note` = 'A3 erweitert A1 und A2 widerspruchsfrei um die Möglichkeit rekursiver Hervorbringung. Determiniertheit und Stabilität werden nicht behauptet.',
    `operationalization_note` = 'Die mathematische Rekonstruktion von Transformation, Iteration, Operator und Zustandsfolge erfolgt erst in Kapitel 3.4.',
    `status` = 'review',
    `created_revision_id` = @revision_id
WHERE `axiom_id` = @axiom_a3_id;

/* 7. Falls A3 fehlt, idempotent ergänzen. */
INSERT INTO `axioms` (
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
SELECT
    'A3',
    @section_id,
    'Prinzip der rekursiven Transformation',
    'Jede funktionale Relation besitzt grundsätzlich die Möglichkeit, neue funktionale Konfigurationen hervorzubringen, die wiederum funktional relationierbar sind.',
    '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)',
    '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)',
    'Funktionale Unterscheidbarkeit und Relationierbarkeit erzeugen noch keine Entwicklung. A3 eröffnet rekursive Hervorbringung.',
    'A3 setzt A1 und A2 voraus, führt aber weder Zeit, Folge noch Operator voraus.',
    'A3 erweitert A1 und A2 widerspruchsfrei; Determiniertheit und Stabilität werden nicht behauptet.',
    'Transformation, Iteration und Operatoren werden erst in Kapitel 3.4 formal konstruiert.',
    NULL,
    'review',
    @revision_id
WHERE @axiom_a3_id IS NULL;

SET @axiom_a3_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A3'
    LIMIT 1
);

/* 8. Alte Belegungen der Gleichungsnummern (3.66) und (3.67)
      vollständig bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.66','3.67')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.66','3.67')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.66','3.67');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.66','3.67');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.66','3.67');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.66','3.67');

/* 9. Gleichung (3.66) – formale Darstellung von A3. */
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
VALUES (
    '3.66',
    @section_id,
    'Formale Darstellung von Axiom A3',
    '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)',
    '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)',
    'Eine funktionale Relation kann eine neue funktionale Konfiguration hervorbringen, die ihrerseits erneut funktional relationierbar ist.',
    'axiom',
    'original',
    NULL,
    'Formale Repräsentation des qualitativen Axioms A3.',
    'A1 und A2 gelten. Das Modalzeichen beschreibt nur Möglichkeit; eine Folge, ein Operator und Zeit werden nicht vorausgesetzt.',
    'checked',
    @revision_id
);

SET @equation_3_66_id := LAST_INSERT_ID();

/* 10. Gleichung (3.67) – strukturelle Axiomabhängigkeit. */
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
VALUES (
    '3.67',
    @section_id,
    'Strukturelle Voraussetzung von Axiom A3',
    'A1,\\;A2\\Longrightarrow\\text{Voraussetzung für }A3',
    'A1,\\;A2\\Longrightarrow\\text{Voraussetzung für }A3',
    'Axiom A3 setzt funktionale Unterscheidbarkeit und funktionale Relationierbarkeit strukturell voraus, ohne logisch aus A1 und A2 ableitbar zu sein.',
    'schema',
    'original',
    NULL,
    'Schematische Darstellung der axiomatischen Abhängigkeitsstruktur.',
    'A1 und A2 sind bereits registriert.',
    'checked',
    @revision_id
);

SET @equation_3_67_id := LAST_INSERT_ID();

/* 11. Symbolregister für (3.66) sicher anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@equation_3_66_id, @equation_3_67_id);

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
    @equation_3_66_id,
    'a',
    'erste funktionale Konfiguration',
    'Erster prämathematischer Platzhalter einer funktionalen Relation.',
    NULL,
    'prämathematischer Platzhalter',
    1
),
(
    @equation_3_66_id,
    'b',
    'zweite funktionale Konfiguration',
    'Zweiter prämathematischer Platzhalter einer funktionalen Relation.',
    NULL,
    'prämathematischer Platzhalter',
    2
),
(
    @equation_3_66_id,
    '\\mathcal{R}_F',
    'funktionaler Zusammenhang',
    'Qualitative funktionale Relationierbarkeit, noch keine mengentheoretische Relation.',
    NULL,
    'prämathematisches Relationssymbol',
    3
),
(
    @equation_3_66_id,
    'c',
    'neu hervorgebrachte funktionale Konfiguration',
    'Durch funktionale Wechselwirkung potenziell entstehende neue Konfiguration.',
    NULL,
    'prämathematischer Platzhalter',
    4
),
(
    @equation_3_66_id,
    '\\Diamond',
    'Möglichkeitsoperator',
    'Kennzeichnet die Möglichkeit rekursiver Hervorbringung.',
    NULL,
    'modal-logischer Operator',
    5
),
(
    @equation_3_66_id,
    '(\\cdot)',
    'offene Bezugsmöglichkeit',
    'Nicht näher bestimmter zukünftiger funktionaler Bezugspunkt.',
    NULL,
    'prämathematischer Platzhalter',
    6
),
(
    @equation_3_67_id,
    'A1',
    'Axiom der funktionalen Unterscheidbarkeit',
    'Erste strukturelle Voraussetzung für A3.',
    NULL,
    'Axiom',
    1
),
(
    @equation_3_67_id,
    'A2',
    'Axiom der funktionalen Relationierbarkeit',
    'Zweite strukturelle Voraussetzung für A3.',
    NULL,
    'Axiom',
    2
),
(
    @equation_3_67_id,
    'A3',
    'Axiom der rekursiven Transformation',
    'Axiom, dessen strukturelle Voraussetzungen dargestellt werden.',
    NULL,
    'Axiom',
    3
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 12. Axiomabhängigkeiten A3 -> A1 und A3 -> A2 erneuern.
       Eingehende Abhängigkeiten späterer Axiome bleiben erhalten. */
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a3_id;

INSERT INTO `axiom_dependencies` (
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
    'A3 setzt funktionale Unterscheidbarkeit nach A1 voraus.'
),
(
    @axiom_a3_id,
    @axiom_a2_id,
    'depends_on',
    'A3 setzt funktionale Relationierbarkeit nach A2 voraus.'
);

/* 13. Gleichung (3.66) mit Axiom A3 verknüpfen. */
INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES (
    'equation',
    @equation_3_66_id,
    'axiom',
    @axiom_a3_id,
    'derives_from',
    'Gleichung (3.66) ist die formale Darstellung von Axiom A3.'
);

/* 14. Gleichungsabhängigkeiten zu (3.64) und (3.65) registrieren. */
SET @equation_3_64_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.64'
    LIMIT 1
);

SET @equation_3_65_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.65'
    LIMIT 1
);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @equation_3_66_id,
    @equation_3_65_id,
    'uses',
    'Die formale Darstellung von A3 verwendet die in (3.65) eingeführte funktionale Relationierbarkeit.'
),
(
    @equation_3_67_id,
    @equation_3_64_id,
    'uses',
    'Die strukturelle Voraussetzung von A3 umfasst Axiom A1 beziehungsweise Gleichung (3.64).'
),
(
    @equation_3_67_id,
    @equation_3_65_id,
    'uses',
    'Die strukturelle Voraussetzung von A3 umfasst Axiom A2 beziehungsweise Gleichung (3.65).'
);

/* 15. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.3.5',
    'Abschnitt 3.3.5 wurde vollständig als Axiom A3 – Prinzip der rekursiven Transformation neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.5.',
    'Neufassung mit Axiom A3 sowie den Gleichungen (3.66) und (3.67).'
),
(
    @revision_id,
    @section_id,
    'axiom_added',
    'axiom',
    'A3',
    'Axiom A3 wurde als Prinzip rekursiver funktionaler Hervorbringung aktualisiert.',
    '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F',
    '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.66), (3.67)',
    'Die formale Axiomdarstellung und die strukturelle Axiomabhängigkeit wurden registriert.',
    'Frühere Belegungen der Gleichungsnummern.',
    'Rekursive Hervorbringung und A1/A2 als Voraussetzungen von A3.'
),
(
    @revision_id,
    @section_id,
    'dependency_added',
    'axiom_dependency',
    'A3 -> A1, A2',
    'Die strukturellen Abhängigkeiten von A3 von A1 und A2 wurden explizit registriert.',
    NULL,
    'A3 depends_on A1; A3 depends_on A2'
);

/* 16. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.68'),
    ('next_axiom_number', 'A4'),
    ('last_edited_section', '3.3.5'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.5-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* Literaturzähler bleibt unverändert. */

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.3.5: review
   - Axiom A3: genau 1 Datensatz
   - Gleichungen: (3.66), (3.67)
   - Symbolzuordnungen: 9
   - A3 depends_on A1 und A2
   - (3.66) uses (3.65)
   - (3.67) uses (3.64) und (3.65)
   - Quellenverwendungen: 0
   - next_equation_number = 3.68
   - next_axiom_number = A4
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.5')
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
WHERE a.`axiom_number` = 'A3';

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`equation_type`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.66','3.67')
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
WHERE e.`equation_number` IN ('3.66','3.67')
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
WHERE ad.`axiom_id` = @axiom_a3_id
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
WHERE e_from.`equation_number` IN ('3.66','3.67')
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
