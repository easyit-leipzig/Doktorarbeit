USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.4
   Axiom A2 – Prinzip der funktionalen Relationierbarkeit

   Neue Quellen:     keine
   Neue Gleichung:   (3.65)
   Axiom:             A2 (vorhandenen Datensatz aktualisieren)
   Abhängigkeit:      A2 depends_on A1
   Nächste Gleichung: (3.66)
   Nächstes Axiom:    A3

   WICHTIG:
   Der vorhandene Axiomdatensatz A2 wird nicht gelöscht, damit
   bestehende Verweise aus Propositionen und Kapitel 3.4 erhalten
   bleiben.
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
    'RKB-2026-07-12-K3.3.4-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.4',
    '1.0',
    'Neufassung von Abschnitt 3.3.4; Aktualisierung von Axiom A2, Registrierung der formalen Gleichung (3.65) sowie der Abhängigkeit A2 von A1.',
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
    WHERE ds.`section_code` = '3.3.4'
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
    `title` = 'Axiom A2 – Prinzip der funktionalen Relationierbarkeit',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A2 und die formale Darstellung (3.65). Keine neue Literaturquelle.'
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

/* 6. Vorhandenes Axiom A2 aktualisieren. */
UPDATE `axioms`
SET
    `section_id` = @section_id,
    `title` = 'Prinzip der funktionalen Relationierbarkeit',
    `axiom_text` = 'Funktional unterscheidbare Konfigurationen besitzen grundsätzlich die Möglichkeit, funktional miteinander in Beziehung zu treten.',
    `formal_latex` = '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)',
    `word_latex` = '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)',
    `motivation` = 'Unterscheidbarkeit allein erzeugt noch keine Organisation. Erst die prinzipielle Möglichkeit funktionaler Relationierung eröffnet die Bildung strukturierter Zusammenhänge.',
    `independence_note` = 'A2 setzt A1 voraus, führt jedoch weder eine fertige mathematische Relation noch eine Menge geordneter Paare ein. Es behauptet ausschließlich die Möglichkeit funktionaler Bezugnahme.',
    `consistency_note` = 'A2 widerspricht A1 nicht, sondern erweitert dessen funktionale Nichtidentität um die Möglichkeit einer nicht notwendig realisierten Beziehung.',
    `operationalization_note` = 'Die mathematische Konstruktion funktionaler Relationen und Relationsklassen erfolgt erst in Kapitel 3.4.',
    `status` = 'review',
    `created_revision_id` = @revision_id
WHERE `axiom_id` = @axiom_a2_id;

/* 7. Falls A2 fehlt, ergänzen. */
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
    'A2',
    @section_id,
    'Prinzip der funktionalen Relationierbarkeit',
    'Funktional unterscheidbare Konfigurationen besitzen grundsätzlich die Möglichkeit, funktional miteinander in Beziehung zu treten.',
    '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)',
    '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)',
    'Unterscheidbarkeit allein erzeugt noch keine Organisation. Erst die prinzipielle Möglichkeit funktionaler Relationierung eröffnet die Bildung strukturierter Zusammenhänge.',
    'A2 setzt A1 voraus, führt jedoch weder eine fertige mathematische Relation noch eine Menge geordneter Paare ein.',
    'A2 erweitert A1 widerspruchsfrei um die Möglichkeit funktionaler Bezugnahme.',
    'Die mathematische Konstruktion funktionaler Relationen erfolgt erst in Kapitel 3.4.',
    NULL,
    'review',
    @revision_id
WHERE @axiom_a2_id IS NULL;

SET @axiom_a2_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A2'
    LIMIT 1
);

/* 8. Alte Belegung von Gleichung (3.65) einschließlich abhängiger
      Registereinträge vollständig entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` = '3.65'
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` = '3.65'
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` = '3.65';

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` = '3.65';

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` = '3.65';

DELETE FROM `equations`
WHERE `equation_number` = '3.65';

/* 9. Gleichung (3.65) einfügen. */
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
    '3.65',
    @section_id,
    'Formale Darstellung von Axiom A2',
    '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)',
    '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)',
    'Funktionale Nichtäquivalenz eröffnet die Möglichkeit einer funktionalen Relation zwischen den unterschiedenen Konfigurationen.',
    'axiom',
    'original',
    NULL,
    'Formale Repräsentation des qualitativen Axioms A2 auf Grundlage von A1.',
    'A1 gilt. Das Modalzeichen kennzeichnet ausschließlich eine Möglichkeit; eine mathematische Relation wird noch nicht vorausgesetzt.',
    'checked',
    @revision_id
);

SET @equation_3_65_id := LAST_INSERT_ID();

/* 10. Symbolregister sicher und idempotent anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` = @equation_3_65_id;

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
    @equation_3_65_id,
    'a',
    'erste funktionale Konfiguration',
    'Erster prämathematischer Platzhalter für eine funktional unterscheidbare Konfiguration.',
    NULL,
    'prämathematischer Platzhalter',
    1
),
(
    @equation_3_65_id,
    'b',
    'zweite funktionale Konfiguration',
    'Zweiter prämathematischer Platzhalter für eine funktional unterscheidbare Konfiguration.',
    NULL,
    'prämathematischer Platzhalter',
    2
),
(
    @equation_3_65_id,
    '\\not\\equiv_F',
    'funktionale Nichtäquivalenz',
    'Aus Axiom A1 übernommener Ausdruck funktionaler Unterscheidbarkeit.',
    NULL,
    'prämathematisches Vergleichssymbol',
    3
),
(
    @equation_3_65_id,
    '\\Diamond',
    'Möglichkeitsoperator',
    'Kennzeichnet, dass funktionale Relationierung möglich, aber noch nicht notwendig realisiert ist.',
    NULL,
    'modal-logischer Operator',
    4
),
(
    @equation_3_65_id,
    '\\mathcal{R}_F',
    'funktionale Relationierbarkeit',
    'Qualitative Möglichkeit einer funktionalen Bezugnahme; noch keine mengentheoretisch definierte Relation.',
    NULL,
    'prämathematisches Relationssymbol',
    5
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 11. Axiomabhängigkeit A2 -> A1 aktualisieren.
       Nur ausgehende Abhängigkeiten von A2 werden ersetzt;
       eingehende Abhängigkeiten späterer Axiome bleiben erhalten. */
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a2_id;

INSERT INTO `axiom_dependencies` (
    `axiom_id`,
    `depends_on_axiom_id`,
    `dependency_type`,
    `note`
)
VALUES (
    @axiom_a2_id,
    @axiom_a1_id,
    'depends_on',
    'A2 setzt die durch A1 eröffnete funktionale Unterscheidbarkeit voraus.'
);

/* 12. Gleichung (3.65) explizit mit Axiom A2 verknüpfen. */
DELETE FROM `object_dependencies`
WHERE
    `object_type_from` = 'equation'
    AND `object_id_from` = @equation_3_65_id
    AND `object_type_to` = 'axiom'
    AND `object_id_to` = @axiom_a2_id;

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
    @equation_3_65_id,
    'axiom',
    @axiom_a2_id,
    'derives_from',
    'Gleichung (3.65) ist die formale Darstellung von Axiom A2.'
);

/* 13. Formale Gleichungsabhängigkeit (3.65) -> (3.64) registrieren. */
SET @equation_3_64_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.64'
    LIMIT 1
);

DELETE FROM `equation_dependencies`
WHERE `equation_id` = @equation_3_65_id;

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES (
    @equation_3_65_id,
    @equation_3_64_id,
    'uses',
    'Die formale Darstellung von A2 verwendet die in Gleichung (3.64) eingeführte funktionale Nichtäquivalenz.'
);

/* 14. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.3.4',
    'Abschnitt 3.3.4 wurde vollständig als Axiom A2 – Prinzip der funktionalen Relationierbarkeit neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.4.',
    'Neufassung mit Axiom A2 und Gleichung (3.65).'
),
(
    @revision_id,
    @section_id,
    'axiom_added',
    'axiom',
    'A2',
    'Axiom A2 wurde in einer prämathematischen, nichtmengentheoretischen Fassung aktualisiert.',
    '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F',
    '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.65)',
    'Die formale Darstellung von Axiom A2 wurde unter der fortlaufenden Gleichungsnummer (3.65) registriert.',
    'Frühere Belegung der Gleichungsnummer (3.65).',
    '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)'
),
(
    @revision_id,
    @section_id,
    'dependency_added',
    'axiom_dependency',
    'A2 -> A1',
    'Die logische Abhängigkeit von Axiom A2 von Axiom A1 wurde explizit registriert.',
    NULL,
    'A2 depends_on A1'
);

/* 15. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.66'),
    ('next_axiom_number', 'A3'),
    ('last_edited_section', '3.3.4'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.4-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* Literaturzähler bleibt unverändert. */

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.3.4: review
   - Axiom A2: genau 1 Datensatz
   - Gleichung (3.65): genau 1 Datensatz
   - Symbolzuordnungen: 5
   - A2 depends_on A1: genau 1 Datensatz
   - Gleichung (3.65) uses (3.64): genau 1 Datensatz
   - Quellenverwendungen: 0
   - next_equation_number = 3.66
   - next_axiom_number = A3
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.4')
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
WHERE a.`axiom_number` = 'A2';

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`equation_type`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` = '3.65';

SELECT
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`definition_text`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
WHERE es.`equation_id` = @equation_3_65_id
ORDER BY es.`symbol_order`;

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
WHERE ad.`axiom_id` = @axiom_a2_id;

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
WHERE ed.`equation_id` = @equation_3_65_id;

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
