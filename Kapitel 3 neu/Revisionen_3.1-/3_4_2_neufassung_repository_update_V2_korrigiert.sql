USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.2
   Konstruktion funktionaler Relationen

   Grundlage:
   - Axiom A2: funktionale Relationierbarkeit
   - Def. 3.4.1: Funktionaler Zustand
   - Def. 3.4.2: Klasse funktionaler Zustände

   Definitionen:
   - Def. 3.4.3: Funktionale Relation
   - Def. 3.4.4: Funktionale Relationsstruktur

   Gleichungen:
   - (3.76): R_F subseteq X x X
   - (3.77): x_i R_F x_j iff rho_F(x_i,x_j)=1
   - (3.78): G_F=(X,R_F)

   Neue Quellen: keine
   Nächste Gleichung: (3.79)
   ============================================================ */

/* Parent-Revision vor dem INSERT separat ermitteln.
   Dadurch wird MySQL-Fehler #1093 vermieden, weil
   repository_revisions nicht gleichzeitig Ziel und Quelle
   desselben INSERT-Statements ist. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

INSERT INTO `repository_revisions` (
    `revision_code`, `revision_date`, `scope_type`, `scope_reference`,
    `version_label`, `summary`, `created_by`, `parent_revision_id`
)
VALUES (
    'RKB-2026-07-12-K3.4.2-NEUFASSUNG-V2',
    NOW(),
    'section',
    '3.4.2',
    '2.0',
    'Korrigierte Neufassung von Abschnitt 3.4.2 als Konstruktion funktionaler Relationen mit Def. 3.4.3, Def. 3.4.4 und den Gleichungen (3.76) bis (3.78).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

SET @section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.4.2'
    LIMIT 1
);

SET @chapter_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.4'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `title` = 'Konstruktion funktionaler Relationen',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt konstruiert funktionale Relationen zwischen den in 3.4.1 definierten Zuständen und fasst sie zu einer funktionalen Relationsstruktur zusammen.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1
WHERE `section_id` = @chapter_id;

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

SET @axiom_a2_id := (
    SELECT `axiom_id`
    FROM `axioms`
    WHERE `axiom_number` = 'A2'
    LIMIT 1
);

SET @def_341_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.1'
    LIMIT 1
);

SET @def_342_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.2'
    LIMIT 1
);

SET @def_343_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.3'
    LIMIT 1
);

SET @def_344_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.4'
    LIMIT 1
);

UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Relation',
    `definition_text` = 'Eine funktionale Relation ist eine wohldefinierte Zuordnung zwischen zwei funktionalen Zuständen, durch die die funktionale Relevanz eines Zustands für einen anderen dargestellt wird.',
    `formal_latex` = '\\mathcal{R}_F\\subseteq X\\times X',
    `word_latex` = '\\mathcal{R}_F\\subseteq X\\times X',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Axiom A2 sowie Def. 3.4.1 und Def. 3.4.2 gelten.',
    `notes` = 'Die Relation besitzt zunächst weder Symmetrie noch Transitivität oder metrische Bedeutung.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_343_id;

INSERT INTO `definitions` (
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
SELECT
    'Def. 3.4.3', @section_id, 'Funktionale Relation',
    'Eine funktionale Relation ist eine wohldefinierte Zuordnung zwischen zwei funktionalen Zuständen, durch die die funktionale Relevanz eines Zustands für einen anderen dargestellt wird.',
    '\\mathcal{R}_F\\subseteq X\\times X',
    '\\mathcal{R}_F\\subseteq X\\times X',
    'original', NULL,
    'Axiom A2 sowie Def. 3.4.1 und Def. 3.4.2 gelten.',
    'Die Relation besitzt zunächst weder Symmetrie noch Transitivität oder metrische Bedeutung.',
    'checked', @revision_id
WHERE @def_343_id IS NULL;

SET @def_343_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.3'
    LIMIT 1
);

UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Relationsstruktur',
    `definition_text` = 'Die funktionale Relationsstruktur ist das geordnete Paar aus der Klasse funktionaler Zustände und der auf ihr definierten funktionalen Relation.',
    `formal_latex` = '\\mathfrak{G}_F=(X,\\mathcal{R}_F)',
    `word_latex` = '\\mathfrak{G}_F=(X,\\mathcal{R}_F)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.2 und Def. 3.4.3 gelten.',
    `notes` = 'Die Relationsstruktur ist noch kein metrischer, topologischer oder dynamischer Raum.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_344_id;

INSERT INTO `definitions` (
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
SELECT
    'Def. 3.4.4', @section_id, 'Funktionale Relationsstruktur',
    'Die funktionale Relationsstruktur ist das geordnete Paar aus der Klasse funktionaler Zustände und der auf ihr definierten funktionalen Relation.',
    '\\mathfrak{G}_F=(X,\\mathcal{R}_F)',
    '\\mathfrak{G}_F=(X,\\mathcal{R}_F)',
    'original', NULL,
    'Def. 3.4.2 und Def. 3.4.3 gelten.',
    'Die Relationsstruktur ist noch kein metrischer, topologischer oder dynamischer Raum.',
    'checked', @revision_id
WHERE @def_344_id IS NULL;

SET @def_344_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.4'
    LIMIT 1
);

/* Alte Gleichungsbelegungen bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='equation' AND `object_id_from` IN (
        SELECT `equation_id` FROM `equations`
        WHERE `equation_number` IN ('3.76','3.77','3.78')
    ))
    OR
    (`object_type_to`='equation' AND `object_id_to` IN (
        SELECT `equation_id` FROM `equations`
        WHERE `equation_number` IN ('3.76','3.77','3.78')
    ));

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.76','3.77','3.78');

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.76','3.77','3.78');

DELETE es
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.76','3.77','3.78');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.76','3.77','3.78');

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`, `equation_latex`,
    `word_latex`, `plain_description`, `equation_type`,
    `provenance`, `source_id`, `derivation`, `assumptions`,
    `validation_status`, `created_revision_id`
)
VALUES
(
    '3.76', @section_id, 'Funktionale Relation',
    '\\mathcal{R}_F\\subseteq X\\times X',
    '\\mathcal{R}_F\\subseteq X\\times X',
    'Die funktionale Relation ist eine Teilmenge des kartesischen Produkts der Klasse funktionaler Zustände mit sich selbst.',
    'definition', 'original', NULL,
    'Formale Darstellung von Def. 3.4.3.',
    'Def. 3.4.2 gilt.',
    'checked', @revision_id
),
(
    '3.77', @section_id, 'Indikator funktionaler Relation',
    'x_i\\,\\mathcal{R}_F\\,x_j\\Longleftrightarrow\\rho_F(x_i,x_j)=1',
    'x_i\\,\\mathcal{R}_F\\,x_j\\Longleftrightarrow\\rho_F(x_i,x_j)=1',
    'Die Indikatorfunktion rho_F kennzeichnet, ob zwischen zwei funktionalen Zuständen eine funktionale Relation besteht.',
    'definition', 'original', NULL,
    'Binäre Darstellung der Zugehörigkeit eines geordneten Zustandspaares zur funktionalen Relation.',
    'x_i,x_j\\in X und \\rho_F:X\\times X\\rightarrow\\{0,1\\}.',
    'checked', @revision_id
),
(
    '3.78', @section_id, 'Funktionale Relationsstruktur',
    '\\mathfrak{G}_F=(X,\\mathcal{R}_F)',
    '\\mathfrak{G}_F=(X,\\mathcal{R}_F)',
    'Die Klasse funktionaler Zustände und die funktionale Relation bilden gemeinsam eine funktionale Relationsstruktur.',
    'definition', 'original', NULL,
    'Formale Darstellung von Def. 3.4.4.',
    'Def. 3.4.2 und Def. 3.4.3 gelten.',
    'checked', @revision_id
);

SET @eq_376 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.76' LIMIT 1);
SET @eq_377 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.77' LIMIT 1);
SET @eq_378 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.78' LIMIT 1);
SET @eq_375 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.75' LIMIT 1);

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_376,@eq_377,@eq_378);

INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`, `definition_text`,
    `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_376,'\\mathcal{R}_F','funktionale Relation','Menge funktional relevanter geordneter Zustandspaare.',NULL,'Teilmenge von X\\times X',1),
(@eq_376,'X','Klasse funktionaler Zustände','In Abschnitt 3.4.1 definierte Zustandsklasse.',NULL,'Menge beziehungsweise Zustandsklasse',2),
(@eq_377,'x_i','erster funktionaler Zustand','Erstes Argument der funktionalen Relation.',NULL,'x_i\\in X',1),
(@eq_377,'x_j','zweiter funktionaler Zustand','Zweites Argument der funktionalen Relation.',NULL,'x_j\\in X',2),
(@eq_377,'\\rho_F','Relationsindikator','Binäre Funktion zur Kennzeichnung einer funktionalen Relation.',NULL,'X\\times X\\rightarrow\\{0,1\\}',3),
(@eq_378,'\\mathfrak{G}_F','funktionale Relationsstruktur','Geordnetes Paar aus Zustandsklasse und funktionaler Relation.',NULL,'strukturtragendes Paar',1),
(@eq_378,'X','Klasse funktionaler Zustände','Trägermenge der Relationsstruktur.',NULL,'Zustandsklasse',2),
(@eq_378,'\\mathcal{R}_F','funktionale Relation','Relationsmenge der Struktur.',NULL,'Relation auf X',3)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from` IN (@def_343_id,@def_344_id))
    OR
    (`object_type_from`='equation' AND `object_id_from` IN (@eq_376,@eq_377,@eq_378));

INSERT INTO `object_dependencies` (
    `object_type_from`, `object_id_from`, `object_type_to`,
    `object_id_to`, `dependency_type`, `note`
)
VALUES
('definition',@def_343_id,'axiom',@axiom_a2_id,'derives_from','Def. 3.4.3 formalisiert die durch A2 eröffnete Relationierbarkeit.'),
('definition',@def_343_id,'definition',@def_342_id,'depends_on','Funktionale Relationen werden auf der Klasse funktionaler Zustände definiert.'),
('definition',@def_344_id,'definition',@def_343_id,'depends_on','Die Relationsstruktur setzt die funktionale Relation voraus.'),
('definition',@def_344_id,'definition',@def_342_id,'depends_on','Die Relationsstruktur setzt die Zustandsklasse voraus.'),
('equation',@eq_376,'definition',@def_343_id,'derives_from','Gleichung (3.76) formalisiert Def. 3.4.3.'),
('equation',@eq_377,'definition',@def_343_id,'derives_from','Gleichung (3.77) konkretisiert Def. 3.4.3 durch einen binären Indikator.'),
('equation',@eq_378,'definition',@def_344_id,'derives_from','Gleichung (3.78) formalisiert Def. 3.4.4.');

INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@eq_376,@eq_375,'uses','Die funktionale Relation wird auf der in Gleichung (3.75) definierten Zustandsklasse aufgebaut.'),
(@eq_377,@eq_376,'uses','Der Relationsindikator konkretisiert die in Gleichung (3.76) definierte Relation.'),
(@eq_378,@eq_376,'uses','Die Relationsstruktur enthält die funktionale Relation aus Gleichung (3.76).'),
(@eq_378,@eq_375,'uses','Die Relationsstruktur enthält die Zustandsklasse aus Gleichung (3.75).');

DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.2',
 'Abschnitt 3.4.2 wurde vollständig als Konstruktion funktionaler Relationen neu gefasst.',
 'Bisheriger Repository-Stand von 3.4.2.',
 'Def. 3.4.3, Def. 3.4.4 und Gleichungen (3.76) bis (3.78).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.3–Def. 3.4.4',
 'Die funktionale Relation und die funktionale Relationsstruktur wurden registriert.',
 NULL,
 '2 Definitionen'),
(@revision_id,@section_id,'equation_added','equation','(3.76)–(3.78)',
 'Die formalen Darstellungen der funktionalen Relation, ihres Indikators und der Relationsstruktur wurden registriert.',
 NULL,
 '3 Gleichungen');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.79'),
('next_definition_number','Def. 3.4.5'),
('last_edited_section','3.4.2'),
('last_repository_revision','RKB-2026-07-12-K3.4.2-NEUFASSUNG-V2')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen */
SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.2')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.3','Def. 3.4.4')
ORDER BY `definition_number`;

SELECT `equation_number`,`title`,`equation_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.76','3.77','3.78')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN (
    'next_equation_number',
    'next_definition_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY `counter_key`;
