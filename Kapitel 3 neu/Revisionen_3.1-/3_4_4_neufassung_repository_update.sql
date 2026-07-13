USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.4
   Konstruktion funktionaler Organisationsräume

   Grundlage:
   - Axiom A4: stabile funktionale Organisation
   - Def. 3.4.5: Funktionale Transformation
   - Def. 3.4.6: Rekursive Transformation
   - Satz 3.4.3: Abgeschlossenheit funktionaler Transformationen

   Definitionen:
   - Def. 3.4.7: Organisationserzeugende Transformation
   - Def. 3.4.8: Funktionaler Organisationsraum

   Satz:
   - Satz 3.4.4: Existenz funktionaler Organisationsräume

   Gleichungen:
   - (3.82): Existenz einer invarianten Organisationsmenge
   - (3.83): Invarianz der Organisationsmenge
   - (3.84): Funktionaler Organisationsraum
   - (3.85): Rekursive Abgeschlossenheit

   Neue Quellen: keine
   Nächste Gleichung: (3.86)
   Nächste Definition: Def. 3.4.9
   Nächster Satz: Satz 3.4.5
   ============================================================ */

/* 1. Parent-Revision vor dem INSERT separat bestimmen. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

/* 2. Revision idempotent anlegen oder wiederverwenden. */
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
    'RKB-2026-07-12-K3.4.4-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.4',
    '1.0',
    'Neufassung von Abschnitt 3.4.4 mit Def. 3.4.7, Def. 3.4.8, Satz 3.4.4 sowie den Gleichungen (3.82) bis (3.85).',
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

/* 3. Kapitel 3.4 und Abschnitt 3.4.4 ermitteln. */
SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4'
    LIMIT 1
);

INSERT INTO `dissertation_sections` (
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`,
    `notes`
)
SELECT
    @chapter_id,
    '3.4.4',
    'Konstruktion funktionaler Organisationsräume',
    3,
    3.5400,
    'review',
    1,
    'Mathematische Rekonstruktion stabiler Organisationsstrukturen aus rekursiven funktionalen Transformationen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections` ds
      WHERE ds.`section_code` = '3.4.4'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.4'
    LIMIT 1
);

/* 4. Abschnitt und Kapitel aktualisieren. */
UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Konstruktion funktionaler Organisationsräume',
    `chapter_no` = 3,
    `section_order` = 3.5400,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt rekonstruiert aus rekursiven funktionalen Transformationen invariante Organisationsmengen und daraus funktionale Organisationsräume.'
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

/* 6. Abhängige Grundobjekte ermitteln. */
SET @axiom_a4_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A4'
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

SET @def_347_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.7'
    LIMIT 1
);

SET @def_348_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.8'
    LIMIT 1
);

SET @theorem_344_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.4'
    LIMIT 1
);

/* 7. Def. 3.4.7 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Organisationserzeugende Transformation',
    `definition_text` = 'Eine rekursive funktionale Transformation heißt organisationserzeugend, wenn eine nichtleere Teilmenge der Zustandsklasse unter ihr invariant bleibt.',
    `formal_latex` = '\\exists\\,\\mathcal{O}_F\\subseteq X,\\;\\mathcal{O}_F\\neq\\varnothing:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F',
    `word_latex` = '\\exists\\,\\mathcal{O}_F\\subseteq X,\\;\\mathcal{O}_F\\neq\\varnothing:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Axiom A4 sowie Def. 3.4.5 und Def. 3.4.6 gelten.',
    `notes` = 'Invarianz bezeichnet die Erhaltung der Organisationsmenge als Ganzes; einzelne Zustände dürfen innerhalb der Menge wechseln.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_347_id;

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
    'Def. 3.4.7',
    @section_id,
    'Organisationserzeugende Transformation',
    'Eine rekursive funktionale Transformation heißt organisationserzeugend, wenn eine nichtleere Teilmenge der Zustandsklasse unter ihr invariant bleibt.',
    '\\exists\\,\\mathcal{O}_F\\subseteq X,\\;\\mathcal{O}_F\\neq\\varnothing:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F',
    '\\exists\\,\\mathcal{O}_F\\subseteq X,\\;\\mathcal{O}_F\\neq\\varnothing:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F',
    'original',
    NULL,
    'Axiom A4 sowie Def. 3.4.5 und Def. 3.4.6 gelten.',
    'Invarianz bezeichnet die Erhaltung der Organisationsmenge als Ganzes; einzelne Zustände dürfen innerhalb der Menge wechseln.',
    'checked',
    @revision_id
WHERE @def_347_id IS NULL;

SET @def_347_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.7'
    LIMIT 1
);

/* 8. Def. 3.4.8 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionaler Organisationsraum',
    `definition_text` = 'Ein funktionaler Organisationsraum ist das geordnete Paar aus einer nichtleeren invarianten Organisationsmenge und der auf ihr wirkenden organisationserzeugenden Transformation.',
    `formal_latex` = '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)',
    `word_latex` = '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.7 gilt.',
    `notes` = 'Der Organisationsraum ist noch kein metrischer oder topologischer Raum. Er beschreibt die invariante funktionale Organisation unter rekursiver Transformation.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_348_id;

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
    'Def. 3.4.8',
    @section_id,
    'Funktionaler Organisationsraum',
    'Ein funktionaler Organisationsraum ist das geordnete Paar aus einer nichtleeren invarianten Organisationsmenge und der auf ihr wirkenden organisationserzeugenden Transformation.',
    '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)',
    '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)',
    'original',
    NULL,
    'Def. 3.4.7 gilt.',
    'Der Organisationsraum ist noch kein metrischer oder topologischer Raum. Er beschreibt die invariante funktionale Organisation unter rekursiver Transformation.',
    'checked',
    @revision_id
WHERE @def_348_id IS NULL;

SET @def_348_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.8'
    LIMIT 1
);

/* 9. Satz 3.4.4 aktualisieren oder anlegen. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Existenz funktionaler Organisationsräume',
    `statement_text` = 'Existiert eine organisationserzeugende Transformation mit einer nichtleeren invarianten Organisationsmenge, dann existiert ein funktionaler Organisationsraum.',
    `statement_latex` = '\\exists\\,\\mathcal{T}_F,\\mathcal{O}_F:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F',
    `word_latex` = '\\exists\\,\\mathcal{T}_F,\\mathcal{O}_F:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.7 und Def. 3.4.8 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_344_id;

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
    'Satz 3.4.4',
    @section_id,
    'Existenz funktionaler Organisationsräume',
    'Existiert eine organisationserzeugende Transformation mit einer nichtleeren invarianten Organisationsmenge, dann existiert ein funktionaler Organisationsraum.',
    '\\exists\\,\\mathcal{T}_F,\\mathcal{O}_F:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F',
    '\\exists\\,\\mathcal{T}_F,\\mathcal{O}_F:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F',
    'original',
    NULL,
    'Def. 3.4.7 und Def. 3.4.8 gelten.',
    'checked',
    @revision_id
WHERE @theorem_344_id IS NULL;

SET @theorem_344_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.4'
    LIMIT 1
);

/* 10. Alte Gleichungsbelegungen (3.82) bis (3.85) bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.82','3.83','3.84','3.85')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.82','3.83','3.84','3.85')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.82','3.83','3.84','3.85');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.82','3.83','3.84','3.85');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.82','3.83','3.84','3.85');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.82','3.83','3.84','3.85');

/* 11. Gleichungen einfügen. */
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
    '3.82',
    @section_id,
    'Existenz einer funktionalen Organisationsmenge',
    '\\exists\\,\\mathcal{O}_F\\subseteq X,\\qquad\\mathcal{O}_F\\neq\\varnothing',
    '\\exists\\,\\mathcal{O}_F\\subseteq X,\\qquad\\mathcal{O}_F\\neq\\varnothing',
    'Es existiert eine nichtleere Teilmenge der Zustandsklasse, die als Kandidat einer stabilen funktionalen Organisation dient.',
    'definition',
    'original',
    NULL,
    'Erster Bestandteil von Def. 3.4.7.',
    'Die Zustandsklasse X ist definiert.',
    'checked',
    @revision_id
),
(
    '3.83',
    @section_id,
    'Invarianz der funktionalen Organisationsmenge',
    '\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F',
    '\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F',
    'Die Organisationsmenge bleibt unter der funktionalen Transformation als Menge invariant.',
    'definition',
    'original',
    NULL,
    'Zweiter Bestandteil von Def. 3.4.7.',
    'Def. 3.4.5 und Def. 3.4.7 gelten.',
    'checked',
    @revision_id
),
(
    '3.84',
    @section_id,
    'Funktionaler Organisationsraum',
    '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)',
    '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)',
    'Die invariante Organisationsmenge und die auf ihr wirkende Transformation bilden gemeinsam einen funktionalen Organisationsraum.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.8.',
    'Def. 3.4.7 gilt.',
    'checked',
    @revision_id
),
(
    '3.85',
    @section_id,
    'Rekursive Abgeschlossenheit des Organisationsraums',
    '\\forall n\\in\\mathbb{N}:\\;\\mathcal{T}_F^{\\,n}(\\mathcal{O}_F)=\\mathcal{O}_F',
    '\\forall n\\in\\mathbb{N}:\\;\\mathcal{T}_F^{\\,n}(\\mathcal{O}_F)=\\mathcal{O}_F',
    'Die Organisationsmenge bleibt unter jeder endlichen Iteration der organisationserzeugenden Transformation invariant.',
    'theorem',
    'original',
    NULL,
    'Folgt aus der Invarianzbedingung durch vollständige Induktion.',
    'Def. 3.4.6 und Gleichung (3.83) gelten.',
    'checked',
    @revision_id
);

SET @eq_382 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.82'
    LIMIT 1
);

SET @eq_383 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.83'
    LIMIT 1
);

SET @eq_384 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.84'
    LIMIT 1
);

SET @eq_385 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.85'
    LIMIT 1
);

SET @eq_375 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.75'
    LIMIT 1
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

/* 12. Symbolregister anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_382,@eq_383,@eq_384,@eq_385);

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
(@eq_382,'\\mathcal{O}_F','funktionale Organisationsmenge','Nichtleere Teilmenge funktionaler Zustände, die unter T_F invariant sein kann.',NULL,'\\mathcal{O}_F\\subseteq X',1),
(@eq_382,'X','Klasse funktionaler Zustände','In Abschnitt 3.4.1 definierte Zustandsklasse.',NULL,'Zustandsklasse',2),
(@eq_383,'\\mathcal{T}_F','funktionale Transformation','Auf der Zustandsklasse wirkende funktionale Transformation.',NULL,'X\\rightarrow X',1),
(@eq_383,'\\mathcal{O}_F','invariante Organisationsmenge','Unter T_F als Ganzes erhaltene Teilmenge der Zustandsklasse.',NULL,'\\mathcal{O}_F\\subseteq X',2),
(@eq_384,'\\mathfrak{O}_F','funktionaler Organisationsraum','Geordnetes Paar aus Organisationsmenge und organisationserzeugender Transformation.',NULL,'Organisationsstruktur',1),
(@eq_384,'\\mathcal{O}_F','funktionale Organisationsmenge','Trägermenge des Organisationsraums.',NULL,'Teilmenge von X',2),
(@eq_384,'\\mathcal{T}_F','organisationserzeugende Transformation','Transformation, unter der O_F invariant ist.',NULL,'Abbildung',3),
(@eq_385,'n','Iterationszahl','Anzahl der endlichen Anwendungen von T_F.',NULL,'\\mathbb{N}',1),
(@eq_385,'\\mathcal{T}_F^{\\,n}','n-fache Transformation','n-fache Komposition der funktionalen Transformation.',NULL,'X\\rightarrow X',2),
(@eq_385,'\\mathcal{O}_F','rekursiv invariante Organisationsmenge','Unter jeder endlichen Iteration von T_F erhaltene Organisationsmenge.',NULL,'Teilmenge von X',3)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 13. Objektabhängigkeiten aktualisieren. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'definition'
        AND `object_id_from` IN (@def_347_id,@def_348_id)
    )
    OR
    (
        `object_type_from` = 'theorem'
        AND `object_id_from` = @theorem_344_id
    )
    OR
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (@eq_382,@eq_383,@eq_384,@eq_385)
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
('definition',@def_347_id,'axiom',@axiom_a4_id,'derives_from','Def. 3.4.7 formalisiert die durch Axiom A4 eröffnete stabile funktionale Organisation.'),
('definition',@def_347_id,'definition',@def_345_id,'depends_on','Eine organisationserzeugende Transformation setzt eine funktionale Transformation voraus.'),
('definition',@def_347_id,'definition',@def_346_id,'depends_on','Die Invarianz wird für rekursive Transformationen formuliert.'),
('definition',@def_348_id,'definition',@def_347_id,'depends_on','Der funktionale Organisationsraum setzt eine organisationserzeugende Transformation voraus.'),
('theorem',@theorem_344_id,'definition',@def_347_id,'depends_on','Der Existenzsatz verwendet die organisationserzeugende Transformation.'),
('theorem',@theorem_344_id,'definition',@def_348_id,'derives_from','Der Organisationsraum entsteht nach Def. 3.4.8 aus O_F und T_F.'),
('equation',@eq_382,'definition',@def_347_id,'derives_from','Gleichung (3.82) ist Teil der formalen Darstellung von Def. 3.4.7.'),
('equation',@eq_383,'definition',@def_347_id,'derives_from','Gleichung (3.83) ist die Invarianzbedingung von Def. 3.4.7.'),
('equation',@eq_384,'definition',@def_348_id,'derives_from','Gleichung (3.84) ist die formale Darstellung von Def. 3.4.8.'),
('equation',@eq_385,'theorem',@theorem_344_id,'derives_from','Gleichung (3.85) beschreibt die rekursive Abgeschlossenheit des Organisationsraums.');

/* 14. Gleichungsabhängigkeiten registrieren. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_382,@eq_383,@eq_384,@eq_385);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(@eq_382,@eq_375,'uses','Die Organisationsmenge ist eine Teilmenge der in Gleichung (3.75) definierten Zustandsklasse.'),
(@eq_383,@eq_379,'uses','Die Invarianzbedingung verwendet die in Gleichung (3.79) definierte Transformation.'),
(@eq_383,@eq_382,'uses','Die Invarianzbedingung wirkt auf die in Gleichung (3.82) eingeführte Organisationsmenge.'),
(@eq_384,@eq_382,'uses','Der Organisationsraum enthält die Organisationsmenge.'),
(@eq_384,@eq_383,'uses','Der Organisationsraum setzt die Invarianzbedingung voraus.'),
(@eq_385,@eq_380,'uses','Die rekursive Abgeschlossenheit verwendet die in Gleichung (3.80) definierte Iteration.'),
(@eq_385,@eq_383,'derived_from','Die rekursive Invarianz folgt aus der einfachen Invarianzbedingung.');

/* 15. Änderungsprotokoll aktualisieren. */
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
    '3.4.4',
    'Abschnitt 3.4.4 wurde vollständig als Konstruktion funktionaler Organisationsräume neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.4.',
    'Neufassung mit Def. 3.4.7, Def. 3.4.8, Satz 3.4.4 und den Gleichungen (3.82) bis (3.85).'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.7–Def. 3.4.8',
    'Organisationserzeugende Transformation und funktionaler Organisationsraum wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'theorem',
    'Satz 3.4.4',
    'Der Existenzsatz für funktionale Organisationsräume wurde registriert.',
    NULL,
    'Existenz funktionaler Organisationsräume'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.82)–(3.85)',
    'Die Organisationsmenge, ihre Invarianz, der Organisationsraum und seine rekursive Abgeschlossenheit wurden formal registriert.',
    NULL,
    '4 Gleichungen'
);

/* 16. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.86'),
    ('next_definition_number', 'Def. 3.4.9'),
    ('next_theorem_number', 'Satz 3.4.5'),
    ('last_edited_section', '3.4.4'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.4.4-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.4')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.7','Def. 3.4.8')
ORDER BY d.`definition_number`;

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.4';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.82','3.83','3.84','3.85')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    COUNT(*) AS `source_usages_in_3_4_4`
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
