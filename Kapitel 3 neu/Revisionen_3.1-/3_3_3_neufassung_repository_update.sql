USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.3
   Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit

   Neue Quellen:     keine
   Neue Gleichung:   (3.64)
   Axiom:             A1 (bestehenden Datensatz aktualisieren)
   Nächste Gleichung: (3.65)
   Nächstes Axiom:    A2

   WICHTIG:
   Der vorhandene Axiomdatensatz A1 wird nicht gelöscht, damit
   bestehende Abhängigkeiten aus Propositionen und Kapitel 3.4
   erhalten bleiben.
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
    'RKB-2026-07-12-K3.3.3-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.3',
    '1.0',
    'Neufassung von Abschnitt 3.3.3; Aktualisierung von Axiom A1, Registrierung der formalen Gleichung (3.64) und explizite Verknüpfung zwischen Axiom und Gleichung.',
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
    WHERE ds.`section_code` = '3.3.3'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3'
    LIMIT 1
);

/* 3. Existenzkontrolle. */
SELECT
    CASE
        WHEN @section_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.3 wurde nicht gefunden.'
        ELSE CONCAT('OK: section_id=', @section_id)
    END AS `section_validation`,
    CASE
        WHEN @chapter_id IS NULL
            THEN 'FEHLER: Kapitel 3.3 wurde nicht gefunden.'
        ELSE CONCAT('OK: chapter_id=', @chapter_id)
    END AS `chapter_validation`;

/* 4. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A1 und die formale Darstellung (3.64). Keine neue Literaturquelle.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 wird abschnittsweise als eigenständige axiomatische Grundlage des FRZK neu gefasst.'
WHERE `section_id` = @chapter_id;

/* 5. Quellenverwendungen entfernen.
      Abschnitt 3.3.3 enthält bewusst keine Literaturquelle. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 6. Bestehendes Axiom A1 ermitteln. */
SET @axiom_a1_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A1'
    LIMIT 1
);

/* 7. Axiom A1 aktualisieren, ohne die axiom_id zu verändern. */
UPDATE `axioms`
SET
    `section_id` = @section_id,
    `title` = 'Prinzip der funktionalen Unterscheidbarkeit',
    `axiom_text` = 'Es existiert die Möglichkeit funktionaler Unterscheidbarkeit.',
    `formal_latex` = '\\exists\\,a,b:\\;a\\not\\equiv_F b',
    `word_latex` = '\\exists\\,a,b:\\;a\\not\\equiv_F b',
    `motivation` = 'Funktionale Unterscheidbarkeit ist die minimal notwendige Voraussetzung jeder späteren Relationierung, Transformation, Organisation und Informationsbildung.',
    `independence_note` = 'A1 setzt weder eine Menge noch eine mathematische Relation, einen Zustand, einen Raum oder eine Zeitordnung voraus.',
    `consistency_note` = 'Das Axiom fordert ausschließlich die prinzipielle Möglichkeit funktionaler Nichtidentität und führt keine weitergehende mathematische Struktur ein.',
    `operationalization_note` = 'Die mathematische Konstruktion von Differenzklassen und funktionaler Äquivalenz erfolgt erst in Kapitel 3.4.',
    `status` = 'review',
    `created_revision_id` = @revision_id
WHERE `axiom_id` = @axiom_a1_id;

/* 8. Falls A1 wider Erwarten fehlt, idempotent ergänzen. */
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
    'A1',
    @section_id,
    'Prinzip der funktionalen Unterscheidbarkeit',
    'Es existiert die Möglichkeit funktionaler Unterscheidbarkeit.',
    '\\exists\\,a,b:\\;a\\not\\equiv_F b',
    '\\exists\\,a,b:\\;a\\not\\equiv_F b',
    'Funktionale Unterscheidbarkeit ist die minimal notwendige Voraussetzung jeder späteren Relationierung, Transformation, Organisation und Informationsbildung.',
    'A1 setzt weder eine Menge noch eine mathematische Relation, einen Zustand, einen Raum oder eine Zeitordnung voraus.',
    'Das Axiom fordert ausschließlich die prinzipielle Möglichkeit funktionaler Nichtidentität und führt keine weitergehende mathematische Struktur ein.',
    'Die mathematische Konstruktion von Differenzklassen und funktionaler Äquivalenz erfolgt erst in Kapitel 3.4.',
    NULL,
    'review',
    @revision_id
WHERE @axiom_a1_id IS NULL;

SET @axiom_a1_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A1'
    LIMIT 1
);

/* 9. Vorhandene Gleichung (3.64) vollständig bereinigen.
      In der Ausgangsdatenbank war (3.64) noch graphentheoretisch
      belegt. Die Nummer wird jetzt repositoryweit neu verwendet. */
DELETE od
FROM `object_dependencies` od
WHERE
    (
        od.`object_type_from` = 'equation'
        AND od.`object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` = '3.64'
        )
    )
    OR
    (
        od.`object_type_to` = 'equation'
        AND od.`object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` = '3.64'
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` = '3.64';

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` = '3.64';

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` = '3.64';

DELETE FROM `equations`
WHERE `equation_number` = '3.64';

/* 10. Gleichung (3.64) einfügen. */
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
    '3.64',
    @section_id,
    'Formale Darstellung von Axiom A1',
    '\\exists\\,a,b:\\;a\\not\\equiv_F b',
    '\\exists\\,a,b:\\;a\\not\\equiv_F b',
    'Es existieren mindestens zwei funktional nicht äquivalente Konfigurationen beziehungsweise die prinzipielle Möglichkeit funktionaler Nichtidentität.',
    'axiom',
    'original',
    NULL,
    'Formale Repräsentation des qualitativen Axioms A1.',
    'Die Symbole a und b dienen ausschließlich als formale Platzhalter; es wird noch keine Menge von Konfigurationen vorausgesetzt.',
    'checked',
    @revision_id
);

SET @equation_3_64_id := LAST_INSERT_ID();

/* 11. Symbolregister sicher und idempotent anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` = @equation_3_64_id;

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
    @equation_3_64_id,
    'a',
    'erste funktionale Konfiguration',
    'Formaler Platzhalter für eine funktionale Konfiguration; noch kein Element einer vorausgesetzten Menge.',
    NULL,
    'prämathematischer Platzhalter',
    1
),
(
    @equation_3_64_id,
    'b',
    'zweite funktionale Konfiguration',
    'Formaler Platzhalter für eine funktionale Konfiguration; noch kein Element einer vorausgesetzten Menge.',
    NULL,
    'prämathematischer Platzhalter',
    2
),
(
    @equation_3_64_id,
    '\\equiv_F',
    'funktionale Äquivalenz',
    'Qualitative Gleichwertigkeit hinsichtlich funktionaler Wirksamkeit; die mathematische Äquivalenzrelation wird erst in Kapitel 3.4 konstruiert.',
    NULL,
    'prämathematisches Vergleichssymbol',
    3
),
(
    @equation_3_64_id,
    '\\not\\equiv_F',
    'funktionale Nichtäquivalenz',
    'Ausdruck der prinzipiellen funktionalen Unterscheidbarkeit.',
    NULL,
    'prämathematisches Vergleichssymbol',
    4
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 12. Explizite Verknüpfung zwischen Gleichung (3.64) und Axiom A1.
       Das Schema besitzt kein equation_id-Feld in axioms.
       Deshalb wird die vorhandene generische Abhängigkeitstabelle
       object_dependencies verwendet. */
DELETE FROM `object_dependencies`
WHERE
    `object_type_from` = 'equation'
    AND `object_id_from` = @equation_3_64_id
    AND `object_type_to` = 'axiom'
    AND `object_id_to` = @axiom_a1_id;

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
    @equation_3_64_id,
    'axiom',
    @axiom_a1_id,
    'derives_from',
    'Gleichung (3.64) ist die formale Darstellung von Axiom A1.'
);

/* 13. Axiomabhängigkeiten:
       A1 ist das erste Axiom und besitzt keine Vorgängerabhängigkeit.
       Vorhandene ausgehende Abhängigkeiten von A1 werden daher entfernt.
       Eingehende Abhängigkeiten späterer Axiome bleiben erhalten. */
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a1_id;

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
    '3.3.3',
    'Abschnitt 3.3.3 wurde vollständig als Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.3.',
    'Neufassung mit Axiom A1 und Gleichung (3.64).'
),
(
    @revision_id,
    @section_id,
    'axiom_added',
    'axiom',
    'A1',
    'Axiom A1 wurde in seiner neuen, nichtzirkulären Fassung aktualisiert.',
    '\\exists\\,\\Delta_F',
    '\\exists\\,a,b:\\;a\\not\\equiv_F b'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.64)',
    'Die formale Darstellung von Axiom A1 wurde unter der fortlaufenden Gleichungsnummer (3.64) registriert.',
    'Frühere graphentheoretische Belegung von (3.64).',
    '\\exists\\,a,b:\\;a\\not\\equiv_F b'
),
(
    @revision_id,
    @section_id,
    'other',
    'object_dependency',
    'A1 ↔ (3.64)',
    'Axiom A1 und Gleichung (3.64) wurden über object_dependencies explizit miteinander verknüpft.',
    NULL,
    'equation derives_from axiom'
);

/* 15. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.65'),
    ('next_axiom_number', 'A2'),
    ('last_edited_section', '3.3.3'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.3-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* Literaturzähler bleibt unverändert. */

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.3.3: review
   - Originalbeitrag: 1
   - Axiom A1: genau 1 Datensatz
   - Gleichung (3.64): genau 1 Datensatz
   - Symbolzuordnungen: 4
   - Objektverknüpfung A1 ↔ (3.64): genau 1
   - Quellenverwendungen: 0
   - next_equation_number = 3.65
   - next_axiom_number = A2
   ============================================================ */

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    ds.`notes`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.3')
ORDER BY ds.`section_code`;

SELECT
    a.`axiom_id`,
    a.`axiom_number`,
    a.`title`,
    a.`axiom_text`,
    a.`formal_latex`,
    a.`word_latex`,
    a.`status`,
    a.`section_id`
FROM `axioms` a
WHERE a.`axiom_number` = 'A1';

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`equation_type`,
    e.`provenance`,
    e.`validation_status`,
    e.`section_id`
FROM `equations` e
WHERE e.`equation_number` = '3.64';

SELECT
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`definition_text`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
WHERE es.`equation_id` = @equation_3_64_id
ORDER BY es.`symbol_order`;

SELECT
    od.`object_type_from`,
    od.`object_id_from`,
    od.`object_type_to`,
    od.`object_id_to`,
    od.`dependency_type`,
    od.`note`
FROM `object_dependencies` od
WHERE
    od.`object_type_from` = 'equation'
    AND od.`object_id_from` = @equation_3_64_id
    AND od.`object_type_to` = 'axiom'
    AND od.`object_id_to` = @axiom_a1_id;

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
