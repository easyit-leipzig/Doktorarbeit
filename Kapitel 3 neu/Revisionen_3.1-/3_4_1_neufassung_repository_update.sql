USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.1
   Konstruktion funktionaler Zustände

   Grundlage:
   - Axiom A4: stabile funktionale Organisation
   - Axiom A5: reproduzierbare Organisationsmuster
   - Proposition Prop. 3.1: Möglichkeit funktionaler Entwicklungsprozesse

   Definitionen:
   - Def. 3.4.1: Funktionaler Zustand
   - Def. 3.4.2: Klasse funktionaler Zustände

   Gleichungen:
   - (3.74): x := O_F
   - (3.75): X = {x_1, x_2, ..., x_n}

   Neue Quellen: keine
   Nächste Gleichung: (3.76)

   WICHTIG:
   Die vorhandenen Definitionen Def. 3.4.1 und Def. 3.4.2 werden
   aktualisiert, nicht gelöscht. Dadurch bleiben definition_id und
   bestehende Verweise erhalten.

   Der Abschnitt 3.4.1 wird entsprechend der zuletzt entwickelten
   Textfassung von „Konstruktion funktionaler Differenzstrukturen“
   zu „Konstruktion funktionaler Zustände“ umgewidmet.
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
    'RKB-2026-07-12-K3.4.1-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.1',
    '1.0',
    'Neufassung von Abschnitt 3.4.1 als Konstruktion funktionaler Zustände mit Def. 3.4.1, Def. 3.4.2 sowie den Gleichungen (3.74) und (3.75).',
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
    WHERE ds.`section_code` = '3.4.1'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4'
    LIMIT 1
);

/* 3. Existenzkontrolle. */
SELECT
    CASE
        WHEN @section_id IS NULL
            THEN 'FEHLER: Abschnitt 3.4.1 wurde nicht gefunden.'
        ELSE CONCAT('OK: section_id=', @section_id)
    END AS `section_validation`,
    CASE
        WHEN @chapter_id IS NULL
            THEN 'FEHLER: Kapitel 3.4 wurde nicht gefunden.'
        ELSE CONCAT('OK: chapter_id=', @chapter_id)
    END AS `chapter_validation`;

/* 4. Abschnitt und Kapitel aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Konstruktion funktionaler Zustände',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt rekonstruiert aus stabiler funktionaler Organisation den funktionalen Zustand und die Klasse funktionaler Zustände. Enthält Def. 3.4.1, Def. 3.4.2 sowie die Gleichungen (3.74) und (3.75).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.4 wird als mathematische Rekonstruktion funktionaler Organisation abschnittsweise neu entwickelt.'
WHERE `section_id` = @chapter_id;

/* 5. Keine Literaturverwendungen in diesem Abschnitt. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 6. Axiom-IDs und Proposition ermitteln. */
SET @axiom_a4_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A4'
    LIMIT 1
);

SET @axiom_a5_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A5'
    LIMIT 1
);

SET @prop_31_id := (
    SELECT p.`proposition_id`
    FROM `propositions` p
    WHERE p.`proposition_number` = 'Prop. 3.1'
    LIMIT 1
);

/* 7. Definitionen ermitteln. */
SET @definition_341_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.1'
    LIMIT 1
);

SET @definition_342_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.2'
    LIMIT 1
);

/* 8. Def. 3.4.1 aktualisieren. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionaler Zustand',
    `definition_text` = 'Ein funktionaler Zustand ist die mathematische Repräsentation einer stabilen funktionalen Organisation im Sinne von Axiom A4.',
    `formal_latex` = 'x:=\\mathcal{O}_F',
    `word_latex` = 'x:=\\mathcal{O}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Axiom A4 gilt. Eine stabile funktionale Organisation kann als mathematisch unterscheidbare Repräsentation behandelt werden.',
    `notes` = 'Der funktionale Zustand besitzt zunächst weder Koordinaten noch Metrik, Dimension, räumliche Position oder Zeitparameter.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @definition_341_id;

/* 9. Falls Def. 3.4.1 fehlt, ergänzen. */
INSERT INTO `definitions` (
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
SELECT
    'Def. 3.4.1',
    @section_id,
    'Funktionaler Zustand',
    'Ein funktionaler Zustand ist die mathematische Repräsentation einer stabilen funktionalen Organisation im Sinne von Axiom A4.',
    'x:=\\mathcal{O}_F',
    'x:=\\mathcal{O}_F',
    'original',
    NULL,
    'Axiom A4 gilt. Eine stabile funktionale Organisation kann als mathematisch unterscheidbare Repräsentation behandelt werden.',
    'Der funktionale Zustand besitzt zunächst weder Koordinaten noch Metrik, Dimension, räumliche Position oder Zeitparameter.',
    'checked',
    @revision_id
WHERE @definition_341_id IS NULL;

SET @definition_341_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.1'
    LIMIT 1
);

/* 10. Def. 3.4.2 aktualisieren. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Klasse funktionaler Zustände',
    `definition_text` = 'Die Klasse funktionaler Zustände umfasst alle im betrachteten Modell mathematisch repräsentierten funktionalen Zustände.',
    `formal_latex` = 'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}',
    `word_latex` = 'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.1 gilt. Mehrere funktionale Zustände können innerhalb desselben Modells unterschieden werden.',
    `notes` = 'X ist in diesem Abschnitt noch kein vollständiger Zustandsraum, sondern zunächst nur die Klasse der definierten funktionalen Zustände.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @definition_342_id;

/* 11. Falls Def. 3.4.2 fehlt, ergänzen. */
INSERT INTO `definitions` (
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
SELECT
    'Def. 3.4.2',
    @section_id,
    'Klasse funktionaler Zustände',
    'Die Klasse funktionaler Zustände umfasst alle im betrachteten Modell mathematisch repräsentierten funktionalen Zustände.',
    'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}',
    'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}',
    'original',
    NULL,
    'Def. 3.4.1 gilt. Mehrere funktionale Zustände können innerhalb desselben Modells unterschieden werden.',
    'X ist in diesem Abschnitt noch kein vollständiger Zustandsraum, sondern zunächst nur die Klasse der definierten funktionalen Zustände.',
    'checked',
    @revision_id
WHERE @definition_342_id IS NULL;

SET @definition_342_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.2'
    LIMIT 1
);

/* 12. Alte Belegungen der Gleichungen (3.74) und (3.75)
       einschließlich abhängiger Einträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.74','3.75')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.74','3.75')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.74','3.75');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.74','3.75');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.74','3.75');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.74','3.75');

/* 13. Gleichung (3.74) einfügen. */
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
    '3.74',
    @section_id,
    'Definition des funktionalen Zustands',
    'x:=\\mathcal{O}_F',
    'x:=\\mathcal{O}_F',
    'Der funktionale Zustand x wird als mathematische Repräsentation einer stabilen funktionalen Organisation definiert.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.1 auf Grundlage von Axiom A4.',
    'Axiom A4 gilt. Das Symbol x bezeichnet noch keinen Punkt eines metrischen oder topologischen Raumes.',
    'checked',
    @revision_id
);

SET @equation_3_74_id := LAST_INSERT_ID();

/* 14. Gleichung (3.75) einfügen. */
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
    '3.75',
    @section_id,
    'Klasse funktionaler Zustände',
    'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}',
    'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}',
    'Die Klasse X enthält die im betrachteten Modell definierten funktionalen Zustände.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.2 auf Grundlage von Def. 3.4.1 und Axiom A5.',
    'Die Zustände x_i sind nach Def. 3.4.1 definiert. X ist noch kein vollständig strukturierter Zustandsraum.',
    'checked',
    @revision_id
);

SET @equation_3_75_id := LAST_INSERT_ID();

/* 15. Symbolregister sicher anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@equation_3_74_id, @equation_3_75_id);

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
    @equation_3_74_id,
    'x',
    'funktionaler Zustand',
    'Mathematische Repräsentation einer stabilen funktionalen Organisation.',
    NULL,
    'funktionale Zustandsrepräsentation',
    1
),
(
    @equation_3_74_id,
    ':=',
    'Definitionszeichen',
    'Kennzeichnet die definitorische Festlegung des funktionalen Zustands.',
    NULL,
    'logisch-mathematischer Operator',
    2
),
(
    @equation_3_74_id,
    '\\mathcal{O}_F',
    'stabile funktionale Organisation',
    'Nach Axiom A4 mögliche funktionale Organisationsform, deren relevante Struktur trotz weiterer Transformation erhalten bleibt.',
    NULL,
    'funktionale Organisationsstruktur',
    3
),
(
    @equation_3_75_id,
    'X',
    'Klasse funktionaler Zustände',
    'Gesamtheit der im betrachteten Modell mathematisch repräsentierten funktionalen Zustände.',
    NULL,
    'Zustandsklasse',
    1
),
(
    @equation_3_75_id,
    'x_i',
    'i-ter funktionaler Zustand',
    'Ein nach Def. 3.4.1 definierter funktionaler Zustand.',
    NULL,
    'x_i\\in X',
    2
),
(
    @equation_3_75_id,
    'n',
    'Anzahl betrachteter Zustände',
    'Endliche Anzahl der im dargestellten Modell berücksichtigten funktionalen Zustände.',
    NULL,
    '\\mathbb{N}',
    3
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 16. Definitionen mit Gleichungen und Axiomen verknüpfen.
       object_dependencies unterstützt Definition, Gleichung und Axiom. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'definition'
        AND `object_id_from` IN (@definition_341_id, @definition_342_id)
    )
    OR
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (@equation_3_74_id, @equation_3_75_id)
    );

INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
(
    'definition',
    @definition_341_id,
    'axiom',
    @axiom_a4_id,
    'derives_from',
    'Def. 3.4.1 rekonstruiert den funktionalen Zustand aus stabiler funktionaler Organisation gemäß Axiom A4.'
),
(
    'definition',
    @definition_342_id,
    'definition',
    @definition_341_id,
    'depends_on',
    'Def. 3.4.2 setzt die Definition des funktionalen Zustands voraus.'
),
(
    'definition',
    @definition_342_id,
    'axiom',
    @axiom_a5_id,
    'derives_from',
    'Die Vergleichbarkeit und mögliche Wiedererkennbarkeit mehrerer funktionaler Zustände wird durch Axiom A5 vorbereitet.'
),
(
    'equation',
    @equation_3_74_id,
    'definition',
    @definition_341_id,
    'derives_from',
    'Gleichung (3.74) ist die formale Darstellung von Def. 3.4.1.'
),
(
    'equation',
    @equation_3_75_id,
    'definition',
    @definition_342_id,
    'derives_from',
    'Gleichung (3.75) ist die formale Darstellung von Def. 3.4.2.'
);

/* 17. Gleichungsabhängigkeit (3.75) -> (3.74). */
INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES (
    @equation_3_75_id,
    @equation_3_74_id,
    'uses',
    'Die Klasse funktionaler Zustände setzt die Definition des einzelnen funktionalen Zustands aus Gleichung (3.74) voraus.'
);

/* 18. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.4.1',
    'Abschnitt 3.4.1 wurde vollständig als Konstruktion funktionaler Zustände neu gefasst.',
    'Konstruktion funktionaler Differenzstrukturen.',
    'Konstruktion funktionaler Zustände.'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.1',
    'Die bestehende Definition wurde als funktionaler Zustand aktualisiert.',
    'Funktionale Konfiguration.',
    'Funktionaler Zustand.'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.2',
    'Die bestehende Definition wurde als Klasse funktionaler Zustände aktualisiert.',
    'Funktionale Differenzabbildung.',
    'Klasse funktionaler Zustände.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.74), (3.75)',
    'Die Gleichungen zur Definition des funktionalen Zustands und seiner Zustandsklasse wurden registriert.',
    'Frühere Belegungen der Gleichungsnummern.',
    'x:=\\mathcal{O}_F; X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}'
),
(
    @revision_id,
    @section_id,
    'dependency_added',
    'object_dependency',
    'Def. 3.4.1 / Def. 3.4.2',
    'Die Definitionen wurden mit Axiom A4, Axiom A5 und ihren Gleichungsdarstellungen verknüpft.',
    NULL,
    '5 Objektabhängigkeiten und 1 Gleichungsabhängigkeit.'
);

/* 19. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.76'),
    ('next_definition_number', 'Def. 3.4.3'),
    ('last_edited_section', '3.4.1'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.4.1-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.4.1: review
   - Titel: Konstruktion funktionaler Zustände
   - Definitionen: Def. 3.4.1, Def. 3.4.2
   - Gleichungen: (3.74), (3.75)
   - Quellenverwendungen: 0
   - next_equation_number = 3.76
   ============================================================ */

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    ds.`notes`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4', '3.4.1')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_id`,
    d.`definition_number`,
    d.`title`,
    d.`definition_text`,
    d.`formal_latex`,
    d.`word_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.1', 'Def. 3.4.2')
ORDER BY d.`definition_number`;

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.74', '3.75')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.74', '3.75')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    od.`object_type_from`,
    od.`object_id_from`,
    od.`object_type_to`,
    od.`object_id_to`,
    od.`dependency_type`,
    od.`note`
FROM `object_dependencies` od
WHERE
    (
        od.`object_type_from` = 'definition'
        AND od.`object_id_from` IN (@definition_341_id, @definition_342_id)
    )
    OR
    (
        od.`object_type_from` = 'equation'
        AND od.`object_id_from` IN (@equation_3_74_id, @equation_3_75_id)
    )
ORDER BY od.`object_dependency_id`;

SELECT
    e_from.`equation_number` AS `equation_number`,
    e_to.`equation_number` AS `depends_on_equation`,
    ed.`dependency_type`,
    ed.`dependency_note`
FROM `equation_dependencies` ed
INNER JOIN `equations` e_from
    ON e_from.`equation_id` = ed.`equation_id`
INNER JOIN `equations` e_to
    ON e_to.`equation_id` = ed.`depends_on_equation_id`
WHERE ed.`equation_id` = @equation_3_75_id;

SELECT
    COUNT(*) AS `source_usages_in_3_4_1`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'next_definition_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
