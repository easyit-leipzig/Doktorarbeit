USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.3
   Konstruktion funktionaler Transformationen

   Grundlage:
   - Axiom A3: rekursive Transformation
   - Def. 3.4.2: Klasse funktionaler Zustände
   - Def. 3.4.3: Funktionale Relation
   - Def. 3.4.4: Funktionale Relationsstruktur

   Definitionen:
   - Def. 3.4.5: Funktionale Transformation
   - Def. 3.4.6: Rekursive Transformation

   Satz:
   - Satz 3.4.3: Abgeschlossenheit funktionaler Transformationen

   Gleichungen:
   - (3.79): T_F:X->X
   - (3.80): T_F^n:X->X
   - (3.81): forall x in X: T_F(x) in X

   Neue Quellen: keine
   Nächste Gleichung: (3.82)
   Nächste Definition: Def. 3.4.7
   Nächster Satz: Satz 3.4.4

   WICHTIG:
   Vorhandene Datensätze werden aktualisiert und nicht gelöscht,
   damit definition_id und theorem_id erhalten bleiben.
   ============================================================ */

/* 1. Revision anlegen oder wiederverwenden. */
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
    'RKB-2026-07-12-K3.4.3-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.3',
    '1.0',
    'Neufassung von Abschnitt 3.4.3 mit Def. 3.4.5, Def. 3.4.6, Satz 3.4.3 sowie den Gleichungen (3.79) bis (3.81).',
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

/* 2. Abschnitts- und Kapitel-IDs ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.3'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4'
    LIMIT 1
);

/* 3. Abschnitt aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Konstruktion funktionaler Transformationen',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt konstruiert funktionale und rekursive Transformationen auf der Klasse funktionaler Zustände und weist ihre Abgeschlossenheit nach.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.4 wird als mathematische Rekonstruktion funktionaler Organisation abschnittsweise neu entwickelt.'
WHERE `section_id` = @chapter_id;

/* 4. Keine Literaturverwendungen in diesem Abschnitt. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 5. Abhängige Grundobjekte ermitteln. */
SET @axiom_a3_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A3'
    LIMIT 1
);

SET @def_342_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.2'
    LIMIT 1
);

SET @def_343_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.3'
    LIMIT 1
);

SET @def_344_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.4'
    LIMIT 1
);

SET @def_345_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.5'
    LIMIT 1
);

SET @def_346_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.6'
    LIMIT 1
);

SET @theorem_343_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.3'
    LIMIT 1
);

/* 6. Def. 3.4.5 aktualisieren. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Transformation',
    `definition_text` = 'Eine funktionale Transformation ist eine wohldefinierte Abbildung, die jedem funktionalen Zustand genau einen funktionalen Folgezustand innerhalb derselben Zustandsklasse zuordnet.',
    `formal_latex` = '\\mathcal{T}_F:X\\rightarrow X',
    `word_latex` = '\\mathcal{T}_F:X\\rightarrow X',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Axiom A3 sowie Def. 3.4.2 bis Def. 3.4.4 gelten.',
    `notes` = 'Die Transformation setzt noch keine physikalische Zeit, Linearität, Stetigkeit oder Invertierbarkeit voraus.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_345_id;

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
    'Def. 3.4.5',
    @section_id,
    'Funktionale Transformation',
    'Eine funktionale Transformation ist eine wohldefinierte Abbildung, die jedem funktionalen Zustand genau einen funktionalen Folgezustand innerhalb derselben Zustandsklasse zuordnet.',
    '\\mathcal{T}_F:X\\rightarrow X',
    '\\mathcal{T}_F:X\\rightarrow X',
    'original',
    NULL,
    'Axiom A3 sowie Def. 3.4.2 bis Def. 3.4.4 gelten.',
    'Die Transformation setzt noch keine physikalische Zeit, Linearität, Stetigkeit oder Invertierbarkeit voraus.',
    'checked',
    @revision_id
WHERE @def_345_id IS NULL;

SET @def_345_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.5'
    LIMIT 1
);

/* 7. Def. 3.4.6 aktualisieren. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Rekursive Transformation',
    `definition_text` = 'Eine funktionale Transformation heißt rekursiv, wenn jede endliche wiederholte Anwendung derselben Transformation wieder eine wohldefinierte Abbildung der Zustandsklasse in sich selbst ergibt.',
    `formal_latex` = '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}',
    `word_latex` = '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.5 gilt und die endliche Komposition von T_F ist wohldefiniert.',
    `notes` = 'Der Exponent n bezeichnet die n-fache Komposition und keine algebraische Potenz.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_346_id;

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
    'Def. 3.4.6',
    @section_id,
    'Rekursive Transformation',
    'Eine funktionale Transformation heißt rekursiv, wenn jede endliche wiederholte Anwendung derselben Transformation wieder eine wohldefinierte Abbildung der Zustandsklasse in sich selbst ergibt.',
    '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}',
    '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}',
    'original',
    NULL,
    'Def. 3.4.5 gilt und die endliche Komposition von T_F ist wohldefiniert.',
    'Der Exponent n bezeichnet die n-fache Komposition und keine algebraische Potenz.',
    'checked',
    @revision_id
WHERE @def_346_id IS NULL;

SET @def_346_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.6'
    LIMIT 1
);

/* 8. Satz 3.4.3 aktualisieren. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Abgeschlossenheit funktionaler Transformationen',
    `statement_text` = 'Jede nach Def. 3.4.5 definierte funktionale Transformation bildet einen funktionalen Zustand wieder auf einen funktionalen Zustand derselben Zustandsklasse ab.',
    `statement_latex` = '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X',
    `word_latex` = '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.2 und Def. 3.4.5 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_343_id;

INSERT INTO `theorems` (
    `theorem_number`,
    `section_id`,
    `title`,
    `statement_text`,
    `statement_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
SELECT
    'Satz 3.4.3',
    @section_id,
    'Abgeschlossenheit funktionaler Transformationen',
    'Jede nach Def. 3.4.5 definierte funktionale Transformation bildet einen funktionalen Zustand wieder auf einen funktionalen Zustand derselben Zustandsklasse ab.',
    '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X',
    '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X',
    'original',
    NULL,
    'Def. 3.4.2 und Def. 3.4.5 gelten.',
    'checked',
    @revision_id
WHERE @theorem_343_id IS NULL;

SET @theorem_343_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.3'
    LIMIT 1
);

/* 9. Alte Gleichungsbelegungen (3.79) bis (3.81) bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.79','3.80','3.81')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.79','3.80','3.81')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.79','3.80','3.81');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.79','3.80','3.81');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.79','3.80','3.81');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.79','3.80','3.81');

/* 10. Gleichungen einfügen. */
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
    '3.79',
    @section_id,
    'Funktionale Transformation',
    '\\mathcal{T}_F:X\\rightarrow X',
    '\\mathcal{T}_F:X\\rightarrow X',
    'Die funktionale Transformation bildet die Klasse funktionaler Zustände in sich selbst ab.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.5.',
    'Def. 3.4.2 gilt.',
    'checked',
    @revision_id
),
(
    '3.80',
    @section_id,
    'Rekursive funktionale Transformation',
    '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}',
    '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}',
    'Jede endliche Iteration der funktionalen Transformation bildet die Zustandsklasse wieder in sich selbst ab.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.6.',
    'Def. 3.4.5 gilt und die endliche Komposition ist wohldefiniert.',
    'checked',
    @revision_id
),
(
    '3.81',
    @section_id,
    'Abgeschlossenheit funktionaler Transformationen',
    '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X',
    '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X',
    'Jeder transformierte funktionale Zustand verbleibt innerhalb der Zustandsklasse.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.3; folgt unmittelbar aus der Abbildungsdefinition T_F:X->X.',
    'Def. 3.4.2 und Def. 3.4.5 gelten.',
    'checked',
    @revision_id
);

SET @eq_379 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.79'
    LIMIT 1
);

SET @eq_380 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.80'
    LIMIT 1
);

SET @eq_381 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.81'
    LIMIT 1
);

SET @eq_375 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.75'
    LIMIT 1
);

SET @eq_376 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.76'
    LIMIT 1
);

SET @eq_378 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.78'
    LIMIT 1
);

/* 11. Symbolregister anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_379,@eq_380,@eq_381);

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
    @eq_379,
    '\\mathcal{T}_F',
    'funktionale Transformation',
    'Wohldefinierte Abbildung eines funktionalen Zustands auf einen funktionalen Folgezustand.',
    NULL,
    'X\\rightarrow X',
    1
),
(
    @eq_379,
    'X',
    'Klasse funktionaler Zustände',
    'In Abschnitt 3.4.1 definierte Klasse funktionaler Zustände.',
    NULL,
    'Zustandsklasse',
    2
),
(
    @eq_380,
    '\\mathcal{T}_F^{\\,n}',
    'n-fache funktionale Transformation',
    'n-fache Komposition der funktionalen Transformation mit sich selbst.',
    NULL,
    'X\\rightarrow X',
    1
),
(
    @eq_380,
    'n',
    'Iterationszahl',
    'Anzahl der endlichen Anwendungen der funktionalen Transformation.',
    NULL,
    '\\mathbb{N}',
    2
),
(
    @eq_380,
    'X',
    'Klasse funktionaler Zustände',
    'Definitions- und Zielklasse der rekursiven Transformation.',
    NULL,
    'Zustandsklasse',
    3
),
(
    @eq_381,
    'x',
    'funktionaler Zustand',
    'Beliebiger funktionaler Zustand der Klasse X.',
    NULL,
    'x\\in X',
    1
),
(
    @eq_381,
    '\\mathcal{T}_F(x)',
    'transformierter Zustand',
    'Durch die funktionale Transformation erzeugter Folgezustand.',
    NULL,
    'Element von X',
    2
),
(
    @eq_381,
    'X',
    'Klasse funktionaler Zustände',
    'Abgeschlossene Zustandsklasse der funktionalen Transformation.',
    NULL,
    'Zustandsklasse',
    3
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 12. Objektabhängigkeiten aktualisieren. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'definition'
        AND `object_id_from` IN (@def_345_id,@def_346_id)
    )
    OR
    (
        `object_type_from` = 'theorem'
        AND `object_id_from` = @theorem_343_id
    )
    OR
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (@eq_379,@eq_380,@eq_381)
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
    @def_345_id,
    'axiom',
    @axiom_a3_id,
    'derives_from',
    'Def. 3.4.5 formalisiert die durch Axiom A3 eröffnete funktionale Transformation.'
),
(
    'definition',
    @def_345_id,
    'definition',
    @def_342_id,
    'depends_on',
    'Die funktionale Transformation wird auf der Klasse funktionaler Zustände definiert.'
),
(
    'definition',
    @def_345_id,
    'definition',
    @def_344_id,
    'depends_on',
    'Die Transformation baut auf der funktionalen Relationsstruktur auf.'
),
(
    'definition',
    @def_346_id,
    'definition',
    @def_345_id,
    'depends_on',
    'Die rekursive Transformation setzt die funktionale Transformation voraus.'
),
(
    'theorem',
    @theorem_343_id,
    'definition',
    @def_345_id,
    'derives_from',
    'Die Abgeschlossenheit folgt unmittelbar aus der Abbildung T_F:X->X.'
),
(
    'theorem',
    @theorem_343_id,
    'definition',
    @def_342_id,
    'depends_on',
    'Der Satz verwendet die Klasse funktionaler Zustände.'
),
(
    'equation',
    @eq_379,
    'definition',
    @def_345_id,
    'derives_from',
    'Gleichung (3.79) ist die formale Darstellung von Def. 3.4.5.'
),
(
    'equation',
    @eq_380,
    'definition',
    @def_346_id,
    'derives_from',
    'Gleichung (3.80) ist die formale Darstellung von Def. 3.4.6.'
),
(
    'equation',
    @eq_381,
    'theorem',
    @theorem_343_id,
    'derives_from',
    'Gleichung (3.81) ist die formale Darstellung von Satz 3.4.3.'
);

/* 13. Gleichungsabhängigkeiten registrieren. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_379,@eq_380,@eq_381);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_379,
    @eq_375,
    'uses',
    'Die funktionale Transformation wird auf der in Gleichung (3.75) definierten Zustandsklasse aufgebaut.'
),
(
    @eq_379,
    @eq_378,
    'uses',
    'Die funktionale Transformation setzt die in Gleichung (3.78) zusammengefasste Relationsstruktur voraus.'
),
(
    @eq_380,
    @eq_379,
    'uses',
    'Die rekursive Transformation ist die endliche Iteration der in Gleichung (3.79) definierten Transformation.'
),
(
    @eq_381,
    @eq_379,
    'derived_from',
    'Die Abgeschlossenheitsaussage folgt unmittelbar aus der Abbildung T_F:X->X.'
);

/* 14. Änderungsprotokoll aktualisieren. */
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
    '3.4.3',
    'Abschnitt 3.4.3 wurde vollständig als Konstruktion funktionaler Transformationen neu gefasst.',
    'Konstruktion rekursiver Transformationen auf Relationsstrukturen.',
    'Konstruktion funktionaler und rekursiver Transformationen auf der Klasse funktionaler Zustände.'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.5–Def. 3.4.6',
    'Die Definitionen der funktionalen und rekursiven Transformation wurden aktualisiert.',
    'Aktive Relation und funktionaler Transformationsoperator auf Relationen.',
    'Funktionale Transformation und rekursive Transformation auf X.'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'theorem',
    'Satz 3.4.3',
    'Der Satz zur Abgeschlossenheit funktionaler Transformationen wurde aktualisiert.',
    'Existenz rekursiver Transformationsräume.',
    'Abgeschlossenheit funktionaler Transformationen.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.79)–(3.81)',
    'Die Gleichungen der funktionalen Transformation, Rekursion und Abgeschlossenheit wurden registriert.',
    'Frühere Belegungen der Gleichungsnummern.',
    'T_F:X->X; T_F^n:X->X; forall x in X: T_F(x) in X.'
);

/* 15. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.82'),
    ('next_definition_number', 'Def. 3.4.7'),
    ('next_theorem_number', 'Satz 3.4.4'),
    ('last_edited_section', '3.4.3'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.4.3-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.4.3: review
   - Def. 3.4.5 und Def. 3.4.6
   - Satz 3.4.3
   - Gleichungen (3.79) bis (3.81)
   - Quellenverwendungen: 0
   - nächste Gleichung: 3.82
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.3')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_id`,
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.5','Def. 3.4.6')
ORDER BY d.`definition_number`;

SELECT
    t.`theorem_id`,
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.3';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.79','3.80','3.81')
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
WHERE e.`equation_number` IN ('3.79','3.80','3.81')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    COUNT(*) AS `source_usages_in_3_4_3`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_equation_number',
    'next_definition_number',
    'next_theorem_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
