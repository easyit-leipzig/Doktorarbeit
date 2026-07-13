USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`) FROM `repository_revisions` r
);

INSERT INTO `repository_revisions` (
    `revision_code`,`revision_date`,`scope_type`,`scope_reference`,
    `version_label`,`summary`,`created_by`,`parent_revision_id`
)
VALUES (
    'RKB-2026-07-13-K3.4.10-NEUFASSUNG-V1',
    NOW(),'section','3.4.10','1.0',
    'Neufassung von Abschnitt 3.4.10 mit Def. 3.4.19, Def. 3.4.20, Lemma 3.4.8, Satz 3.4.10 und den Gleichungen (3.106) bis (3.109).',
    'Olaf Thiele / ChatGPT',@parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id`=LAST_INSERT_ID(`revision_id`),
    `revision_date`=VALUES(`revision_date`),
    `version_label`=VALUES(`version_label`),
    `summary`=VALUES(`summary`),
    `created_by`=VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

SET @chapter_id := (
    SELECT `section_id` FROM `dissertation_sections`
    WHERE `section_code`='3.4' LIMIT 1
);

INSERT INTO `dissertation_sections` (
    `parent_section_id`,`section_code`,`title`,`chapter_no`,
    `section_order`,`status`,`is_original_contribution`,`notes`
)
SELECT
    @chapter_id,'3.4.10',
    'Mathematische Rekonstruktion funktionaler Erhaltungsgesetze',
    3,3.5910,'review',1,
    'Rekonstruktion funktionaler Erhaltungsgesetze aus der Invarianz gegenüber zulässigen funktionalen Transformationen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM `dissertation_sections`
      WHERE `section_code`='3.4.10'
  );

SET @section_id := (
    SELECT `section_id` FROM `dissertation_sections`
    WHERE `section_code`='3.4.10' LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Mathematische Rekonstruktion funktionaler Erhaltungsgesetze',
    `chapter_no`=3,
    `section_order`=3.5910,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.19, Def. 3.4.20, Lemma 3.4.8, Satz 3.4.10 und die Gleichungen (3.106) bis (3.109).'
WHERE `section_id`=@section_id;

DELETE FROM `source_usage` WHERE `section_id`=@section_id;

SET @def_3417_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.17' LIMIT 1
);
SET @def_3419_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.19' LIMIT 1
);
SET @def_3420_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.20' LIMIT 1
);
SET @lemma_348_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.8' LIMIT 1
);
SET @theorem_3410_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.10' LIMIT 1
);

/* Def. 3.4.19 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionales Erhaltungsgesetz',
    `definition_text`='Ein funktionales Erhaltungsgesetz liegt vor, wenn eine funktionale Invariante unter jeder zulässigen funktionalen Transformation erhalten bleibt.',
    `formal_latex`='\\forall\\,\\mathcal{T}_F\\in\\mathfrak{T}:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    `word_latex`='\\forall\\,\\mathcal{T}_F\\in\\mathfrak{T}:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.17 gilt; die Transformationsklasse \\mathfrak{T} ist wohldefiniert.',
    `notes`='Erhaltung gegenüber jeder zulässigen Transformation.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3419_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.19',@section_id,'Funktionales Erhaltungsgesetz',
    'Ein funktionales Erhaltungsgesetz liegt vor, wenn eine funktionale Invariante unter jeder zulässigen funktionalen Transformation erhalten bleibt.',
    '\\forall\\,\\mathcal{T}_F\\in\\mathfrak{T}:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    '\\forall\\,\\mathcal{T}_F\\in\\mathfrak{T}:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    'original',NULL,
    'Def. 3.4.17 gilt; die Transformationsklasse \\mathfrak{T} ist wohldefiniert.',
    'Erhaltung gegenüber jeder zulässigen Transformation.',
    'checked',@revision_id
WHERE @def_3419_id IS NULL;

SET @def_3419_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.19' LIMIT 1
);

/* Def. 3.4.20 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Klasse funktionaler Erhaltungsgesetze',
    `definition_text`='Die Klasse funktionaler Erhaltungsgesetze umfasst alle funktionalen Invarianten, die unter jeder zulässigen funktionalen Transformation erhalten bleiben.',
    `formal_latex`='\\mathcal{E}_F=\\left\\{I_F\\mid\\forall\\mathcal{T}_F\\in\\mathfrak{T}:I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    `word_latex`='\\mathcal{E}_F=\\left\\{I_F\\mid\\forall\\mathcal{T}_F\\in\\mathfrak{T}:I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.19 gilt.',
    `notes`='Klasse aller universell erhaltenen funktionalen Invarianten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3420_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.20',@section_id,'Klasse funktionaler Erhaltungsgesetze',
    'Die Klasse funktionaler Erhaltungsgesetze umfasst alle funktionalen Invarianten, die unter jeder zulässigen funktionalen Transformation erhalten bleiben.',
    '\\mathcal{E}_F=\\left\\{I_F\\mid\\forall\\mathcal{T}_F\\in\\mathfrak{T}:I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    '\\mathcal{E}_F=\\left\\{I_F\\mid\\forall\\mathcal{T}_F\\in\\mathfrak{T}:I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    'original',NULL,'Def. 3.4.19 gilt.',
    'Klasse aller universell erhaltenen funktionalen Invarianten.',
    'checked',@revision_id
WHERE @def_3420_id IS NULL;

SET @def_3420_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.20' LIMIT 1
);

/* Lemma 3.4.8 */
UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Kompositionserhaltung',
    `statement_text`='Sind zwei zulässige funktionale Transformationen bezüglich derselben funktionalen Invarianten erhaltend, dann ist auch ihre Komposition erhaltend.',
    `statement_latex`='I_F\\!\\left((\\mathcal{T}_{F,2}\\circ\\mathcal{T}_{F,1})(\\mathfrak{O})\\right)=I_F(\\mathfrak{O})',
    `word_latex`='I_F\\!\\left((\\mathcal{T}_{F,2}\\circ\\mathcal{T}_{F,1})(\\mathfrak{O})\\right)=I_F(\\mathfrak{O})',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.19 gilt; beide Transformationen erhalten I_F.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_348_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.8',@section_id,'Kompositionserhaltung',
    'Sind zwei zulässige funktionale Transformationen bezüglich derselben funktionalen Invarianten erhaltend, dann ist auch ihre Komposition erhaltend.',
    'I_F\\!\\left((\\mathcal{T}_{F,2}\\circ\\mathcal{T}_{F,1})(\\mathfrak{O})\\right)=I_F(\\mathfrak{O})',
    'I_F\\!\\left((\\mathcal{T}_{F,2}\\circ\\mathcal{T}_{F,1})(\\mathfrak{O})\\right)=I_F(\\mathfrak{O})',
    'original',NULL,
    'Def. 3.4.19 gilt; beide Transformationen erhalten I_F.',
    'checked',@revision_id
WHERE @lemma_348_id IS NULL;

SET @lemma_348_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.8' LIMIT 1
);

/* Satz 3.4.10 */
UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Stabilität funktionaler Erhaltungsgesetze',
    `statement_text`='Ist eine funktionale Invariante unter jeder einzelnen Transformation einer endlichen Transformationsfolge erhalten, dann bleibt sie auch unter der gesamten Komposition erhalten.',
    `statement_latex`='\\left(\\forall i\\in\\{1,\\ldots,n\\}:I_F\\circ\\mathcal{T}_{F,i}=I_F\\right)\\Longrightarrow I_F\\circ\\left(\\mathcal{T}_{F,n}\\circ\\cdots\\circ\\mathcal{T}_{F,1}\\right)=I_F',
    `word_latex`='\\left(\\forall i\\in\\{1,\\ldots,n\\}:I_F\\circ\\mathcal{T}_{F,i}=I_F\\right)\\Longrightarrow I_F\\circ\\left(\\mathcal{T}_{F,n}\\circ\\cdots\\circ\\mathcal{T}_{F,1}\\right)=I_F',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.19, Def. 3.4.20 und Lemma 3.4.8 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3410_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.10',@section_id,
    'Stabilität funktionaler Erhaltungsgesetze',
    'Ist eine funktionale Invariante unter jeder einzelnen Transformation einer endlichen Transformationsfolge erhalten, dann bleibt sie auch unter der gesamten Komposition erhalten.',
    '\\left(\\forall i\\in\\{1,\\ldots,n\\}:I_F\\circ\\mathcal{T}_{F,i}=I_F\\right)\\Longrightarrow I_F\\circ\\left(\\mathcal{T}_{F,n}\\circ\\cdots\\circ\\mathcal{T}_{F,1}\\right)=I_F',
    '\\left(\\forall i\\in\\{1,\\ldots,n\\}:I_F\\circ\\mathcal{T}_{F,i}=I_F\\right)\\Longrightarrow I_F\\circ\\left(\\mathcal{T}_{F,n}\\circ\\cdots\\circ\\mathcal{T}_{F,1}\\right)=I_F',
    'original',NULL,
    'Def. 3.4.19, Def. 3.4.20 und Lemma 3.4.8 gelten.',
    'checked',@revision_id
WHERE @theorem_3410_id IS NULL;

SET @theorem_3410_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.10' LIMIT 1
);

/* Alte Gleichungen bereinigen. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='equation' AND `object_id_from` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.106','3.107','3.108','3.109')
 ))
 OR
 (`object_type_to`='equation' AND `object_id_to` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.106','3.107','3.108','3.109')
 ));

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.106','3.107','3.108','3.109');

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.106','3.107','3.108','3.109');

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.106','3.107','3.108','3.109');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.106','3.107','3.108','3.109');

INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.106',@section_id,'Funktionales Erhaltungsgesetz',
    '\\forall\\,\\mathcal{T}_F\\in\\mathfrak{T}:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    '\\forall\\,\\mathcal{T}_F\\in\\mathfrak{T}:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    'Eine funktionale Invariante bleibt unter jeder zulässigen funktionalen Transformation erhalten.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.19.',
    'Def. 3.4.17 gilt.','checked',@revision_id
),
(
    '3.107',@section_id,'Klasse funktionaler Erhaltungsgesetze',
    '\\mathcal{E}_F=\\left\\{I_F\\mid\\forall\\mathcal{T}_F\\in\\mathfrak{T}:I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    '\\mathcal{E}_F=\\left\\{I_F\\mid\\forall\\mathcal{T}_F\\in\\mathfrak{T}:I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    'Die Klasse enthält alle gegenüber der gesamten Transformationsklasse invarianten Größen.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.20.',
    'Def. 3.4.19 gilt.','checked',@revision_id
),
(
    '3.108',@section_id,'Kompositionserhaltung',
    'I_F\\!\\left((\\mathcal{T}_{F,2}\\circ\\mathcal{T}_{F,1})(\\mathfrak{O})\\right)=I_F(\\mathfrak{O})',
    'I_F\\!\\left((\\mathcal{T}_{F,2}\\circ\\mathcal{T}_{F,1})(\\mathfrak{O})\\right)=I_F(\\mathfrak{O})',
    'Die Komposition zweier bezüglich derselben Invarianten erhaltender Transformationen ist erhaltend.',
    'lemma','original',NULL,'Formale Darstellung von Lemma 3.4.8.',
    'Beide Transformationen erhalten I_F.','checked',@revision_id
),
(
    '3.109',@section_id,'Stabilität funktionaler Erhaltungsgesetze',
    '\\left(\\forall i\\in\\{1,\\ldots,n\\}:I_F\\circ\\mathcal{T}_{F,i}=I_F\\right)\\Longrightarrow I_F\\circ\\left(\\mathcal{T}_{F,n}\\circ\\cdots\\circ\\mathcal{T}_{F,1}\\right)=I_F',
    '\\left(\\forall i\\in\\{1,\\ldots,n\\}:I_F\\circ\\mathcal{T}_{F,i}=I_F\\right)\\Longrightarrow I_F\\circ\\left(\\mathcal{T}_{F,n}\\circ\\cdots\\circ\\mathcal{T}_{F,1}\\right)=I_F',
    'Erhaltung in jedem Einzelschritt impliziert Erhaltung unter jeder endlichen Komposition.',
    'theorem','original',NULL,'Formale Darstellung von Satz 3.4.10.',
    'Def. 3.4.19, Def. 3.4.20 und Lemma 3.4.8 gelten.',
    'checked',@revision_id
);

SET @eq_3106 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.106' LIMIT 1);
SET @eq_3107 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.107' LIMIT 1);
SET @eq_3108 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.108' LIMIT 1);
SET @eq_3109 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.109' LIMIT 1);
SET @eq_3102 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.102' LIMIT 1);
SET @eq_3103 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.103' LIMIT 1);

/* Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3106,@eq_3107,@eq_3108,@eq_3109);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3106,'\\mathfrak{T}','Klasse zulässiger Transformationen','Gesamtheit aller zulässigen funktionalen Transformationen.',NULL,'Transformationsklasse',1),
(@eq_3106,'I_F','funktionale Invariante','Unter jeder zulässigen Transformation erhaltene Größe.',NULL,'Invariante',2),
(@eq_3106,'\\mathfrak{O}','funktionaler Organisationsraum','Beliebiger funktionaler Organisationsraum.',NULL,'Organisationsraum',3),
(@eq_3107,'\\mathcal{E}_F','Klasse funktionaler Erhaltungsgesetze','Gesamtheit aller universell erhaltenen funktionalen Invarianten.',NULL,'Menge',1),
(@eq_3108,'\\mathcal{T}_{F,1}','erste erhaltende Transformation','Erste bezüglich I_F erhaltende Transformation.',NULL,'Abbildung',1),
(@eq_3108,'\\mathcal{T}_{F,2}','zweite erhaltende Transformation','Zweite bezüglich I_F erhaltende Transformation.',NULL,'Abbildung',2),
(@eq_3108,'\\circ','Kompositionsoperator','Hintereinanderausführung funktionaler Transformationen.',NULL,'Abbildungsoperator',3),
(@eq_3109,'n','Anzahl der Transformationsschritte','Endliche Anzahl der komponierten Transformationen.',NULL,'\\mathbb{N}',1),
(@eq_3109,'\\mathcal{T}_{F,i}','i-te erhaltende Transformation','i-te Transformation der endlichen Transformationsfolge.',NULL,'Abbildung',2)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='definition' AND `object_id_from` IN (@def_3419_id,@def_3420_id))
 OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_348_id)
 OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3410_id)
 OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3106,@eq_3107,@eq_3108,@eq_3109));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3419_id,'definition',@def_3417_id,'depends_on','Das Erhaltungsgesetz setzt die funktionale Invariante voraus.'),
('definition',@def_3420_id,'definition',@def_3419_id,'depends_on','Die Erhaltungsgesetzklasse setzt das einzelne Erhaltungsgesetz voraus.'),
('lemma',@lemma_348_id,'definition',@def_3419_id,'derives_from','Die Kompositionserhaltung folgt aus der schrittweisen Erhaltungsbedingung.'),
('theorem',@theorem_3410_id,'definition',@def_3420_id,'depends_on','Der Satz verwendet die Klasse funktionaler Erhaltungsgesetze.'),
('theorem',@theorem_3410_id,'lemma',@lemma_348_id,'derives_from','Der Satz folgt induktiv aus der Kompositionserhaltung.'),
('equation',@eq_3106,'definition',@def_3419_id,'derives_from','Gleichung (3.106) formalisiert Def. 3.4.19.'),
('equation',@eq_3107,'definition',@def_3420_id,'derives_from','Gleichung (3.107) formalisiert Def. 3.4.20.'),
('equation',@eq_3108,'lemma',@lemma_348_id,'derives_from','Gleichung (3.108) formalisiert Lemma 3.4.8.'),
('equation',@eq_3109,'theorem',@theorem_3410_id,'derives_from','Gleichung (3.109) formalisiert Satz 3.4.10.');

/* Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3106,@eq_3107,@eq_3108,@eq_3109);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3106,@eq_3102,'depends_on','Das Erhaltungsgesetz erweitert die Invarianzbedingung aus Gleichung (3.102) auf alle zulässigen Transformationen.'),
(@eq_3107,@eq_3106,'derives_from','Die Erhaltungsgesetzklasse wird aus der universellen Erhaltungsbedingung gebildet.'),
(@eq_3107,@eq_3103,'depends_on','Die Erhaltungsgesetzklasse ist eine Teilklasse der Invariantenmenge.'),
(@eq_3108,@eq_3106,'derives_from','Die Kompositionserhaltung folgt aus der Erhaltung durch beide Einzeltransformationen.'),
(@eq_3109,@eq_3108,'derives_from','Die Stabilität unter endlicher Komposition folgt induktiv aus dem Lemma.'),
(@eq_3109,@eq_3107,'depends_on','Der Satz bezieht sich auf die Klasse funktionaler Erhaltungsgesetze.');

/* Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.10',
 'Abschnitt 3.4.10 wurde vollständig als mathematische Rekonstruktion funktionaler Erhaltungsgesetze neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.10.',
 'Def. 3.4.19, Def. 3.4.20, Lemma 3.4.8, Satz 3.4.10 und Gleichungen (3.106) bis (3.109).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.19–Def. 3.4.20',
 'Funktionales Erhaltungsgesetz und Erhaltungsgesetzklasse wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.8',
 'Die Kompositionserhaltung wurde registriert.',NULL,'Kompositionserhaltung'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.10',
 'Die Stabilität funktionaler Erhaltungsgesetze wurde registriert.',NULL,'Erhaltung unter endlicher Komposition'),
(@revision_id,@section_id,'equation_added','equation','(3.106)–(3.109)',
 'Erhaltungsgesetz, Erhaltungsgesetzklasse, Kompositionserhaltung und Stabilität wurden formal registriert.',
 NULL,'4 Gleichungen');

/* Repository-Zähler. */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.110'),
('next_definition_number','Def. 3.4.21'),
('next_lemma_number','Lemma 3.4.9'),
('next_theorem_number','Satz 3.4.11'),
('last_edited_section','3.4.10'),
('last_repository_revision','RKB-2026-07-13-K3.4.10-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen */
SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.10')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.19','Def. 3.4.20')
ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas`
WHERE `lemma_number`='Lemma 3.4.8';

SELECT `theorem_number`,`title`,`statement_latex`,`assumptions`,`validation_status`
FROM `theorems`
WHERE `theorem_number`='Satz 3.4.10';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.106','3.107','3.108','3.109')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_10`
FROM `source_usage`
WHERE `section_id`=@section_id;

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN (
    'next_equation_number','next_definition_number',
    'next_lemma_number','next_theorem_number',
    'last_edited_section','last_repository_revision'
)
ORDER BY `counter_key`;
