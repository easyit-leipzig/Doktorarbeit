USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.4.20 – Funktionale Tangentialräume */
SET @parent_revision_id := (SELECT MAX(`revision_id`) FROM `repository_revisions`);

INSERT INTO `repository_revisions` (
 `revision_code`,`revision_date`,`scope_type`,`scope_reference`,
 `version_label`,`summary`,`created_by`,`parent_revision_id`
) VALUES (
 'RKB-2026-07-14-K3.4.20-NEUFASSUNG-V1',NOW(),'section','3.4.20','1.0',
 'Neufassung von Abschnitt 3.4.20 mit Def. 3.4.38, Def. 3.4.39, Lemma 3.4.18, Satz 3.4.20 und den Gleichungen (3.151) bis (3.154).',
 'Olaf Thiele / ChatGPT',@parent_revision_id
)
ON DUPLICATE KEY UPDATE
 `revision_id`=LAST_INSERT_ID(`revision_id`),
 `revision_date`=VALUES(`revision_date`),
 `version_label`=VALUES(`version_label`),
 `summary`=VALUES(`summary`),
 `created_by`=VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();
SET @chapter_id := (SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.4' LIMIT 1);

INSERT INTO `dissertation_sections` (
 `parent_section_id`,`section_code`,`title`,`chapter_no`,`section_order`,
 `status`,`is_original_contribution`,`notes`
)
SELECT @chapter_id,'3.4.20','Funktionale Tangentialräume',3,3.6010,'review',1,
 'Rekonstruktion funktionaler Tangentialvektoren, Tangentialräume und lokaler Entwicklungsrichtungen.'
WHERE @chapter_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM `dissertation_sections` WHERE `section_code`='3.4.20');

SET @section_id := (SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.4.20' LIMIT 1);

UPDATE `dissertation_sections`
SET `parent_section_id`=@chapter_id,
    `title`='Funktionale Tangentialräume',
    `chapter_no`=3,
    `section_order`=3.6010,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 14.07.2026 vollständig neu gefasst. Enthält Def. 3.4.38, Def. 3.4.39, Lemma 3.4.18, Satz 3.4.20 und die Gleichungen (3.151) bis (3.154).'
WHERE `section_id`=@section_id;

DELETE FROM `source_usage` WHERE `section_id`=@section_id;

SET @def_3435_id := (SELECT `definition_id` FROM `definitions` WHERE `definition_number`='Def. 3.4.35' LIMIT 1);
SET @def_3437_id := (SELECT `definition_id` FROM `definitions` WHERE `definition_number`='Def. 3.4.37' LIMIT 1);
SET @def_3438_id := (SELECT `definition_id` FROM `definitions` WHERE `definition_number`='Def. 3.4.38' LIMIT 1);
SET @def_3439_id := (SELECT `definition_id` FROM `definitions` WHERE `definition_number`='Def. 3.4.39' LIMIT 1);
SET @lemma_3418_id := (SELECT `lemma_id` FROM `lemmas` WHERE `lemma_number`='Lemma 3.4.18' LIMIT 1);
SET @theorem_3420_id := (SELECT `theorem_id` FROM `theorems` WHERE `theorem_number`='Satz 3.4.20' LIMIT 1);

UPDATE `definitions`
SET `section_id`=@section_id,
    `title`='Funktionaler Tangentialvektor',
    `definition_text`='Ein funktionaler Tangentialvektor im Punkt A ist eine lineare Derivation auf dem Raum glatter reellwertiger Funktionen der funktionalen Mannigfaltigkeit, welche die Leibniz-Regel erfüllt.',
    `formal_latex`='v(fg)=v(f)\\,g(A)+f(A)\\,v(g)',
    `word_latex`='v(fg)=v(f)\\,g(A)+f(A)\\,v(g)',
    `provenance`='original',`source_id`=NULL,
    `assumptions`='Satz 3.4.19 gilt; f und g sind glatte reellwertige Funktionen auf der funktionalen Mannigfaltigkeit.',
    `notes`='Der Tangentialvektor beschreibt eine lokale funktionale Änderungsrichtung im Punkt A.',
    `validation_status`='checked',`created_revision_id`=@revision_id
WHERE `definition_id`=@def_3438_id;

INSERT INTO `definitions` (
 `definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,
 `provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT 'Def. 3.4.38',@section_id,'Funktionaler Tangentialvektor',
 'Ein funktionaler Tangentialvektor im Punkt A ist eine lineare Derivation auf dem Raum glatter reellwertiger Funktionen der funktionalen Mannigfaltigkeit, welche die Leibniz-Regel erfüllt.',
 'v(fg)=v(f)\\,g(A)+f(A)\\,v(g)','v(fg)=v(f)\\,g(A)+f(A)\\,v(g)',
 'original',NULL,
 'Satz 3.4.19 gilt; f und g sind glatte reellwertige Funktionen auf der funktionalen Mannigfaltigkeit.',
 'Der Tangentialvektor beschreibt eine lokale funktionale Änderungsrichtung im Punkt A.',
 'checked',@revision_id
WHERE @def_3438_id IS NULL;
SET @def_3438_id := (SELECT `definition_id` FROM `definitions` WHERE `definition_number`='Def. 3.4.38' LIMIT 1);

UPDATE `definitions`
SET `section_id`=@section_id,
    `title`='Funktionaler Tangentialraum',
    `definition_text`='Der funktionale Tangentialraum im Punkt A ist die Gesamtheit aller funktionalen Tangentialvektoren im Punkt A.',
    `formal_latex`='T_A\\mathcal{M}_F=\\left\\{v\\mid v\\text{ ist funktionaler Tangentialvektor in }A\\right\\}',
    `word_latex`='T_A\\mathcal{M}_F=\\left\\{v\\mid v\\text{ ist funktionaler Tangentialvektor in }A\\right\\}',
    `provenance`='original',`source_id`=NULL,
    `assumptions`='Def. 3.4.38 gilt.',
    `notes`='Der Tangentialraum sammelt sämtliche lokalen Entwicklungsrichtungen im Punkt A.',
    `validation_status`='checked',`created_revision_id`=@revision_id
WHERE `definition_id`=@def_3439_id;

INSERT INTO `definitions` (
 `definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,
 `provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT 'Def. 3.4.39',@section_id,'Funktionaler Tangentialraum',
 'Der funktionale Tangentialraum im Punkt A ist die Gesamtheit aller funktionalen Tangentialvektoren im Punkt A.',
 'T_A\\mathcal{M}_F=\\left\\{v\\mid v\\text{ ist funktionaler Tangentialvektor in }A\\right\\}',
 'T_A\\mathcal{M}_F=\\left\\{v\\mid v\\text{ ist funktionaler Tangentialvektor in }A\\right\\}',
 'original',NULL,'Def. 3.4.38 gilt.',
 'Der Tangentialraum sammelt sämtliche lokalen Entwicklungsrichtungen im Punkt A.',
 'checked',@revision_id
WHERE @def_3439_id IS NULL;
SET @def_3439_id := (SELECT `definition_id` FROM `definitions` WHERE `definition_number`='Def. 3.4.39' LIMIT 1);

UPDATE `lemmas`
SET `section_id`=@section_id,
    `title`='Lineare Struktur des funktionalen Tangentialraums',
    `statement_text`='Der funktionale Tangentialraum ist unter Addition und Skalarmultiplikation abgeschlossen und bildet einen reellen Vektorraum.',
    `statement_latex`='u,v\\in T_A\\mathcal{M}_F,\\;\\alpha,\\beta\\in\\mathbb{R}\\Longrightarrow\\alpha u+\\beta v\\in T_A\\mathcal{M}_F',
    `word_latex`='u,v\\in T_A\\mathcal{M}_F,\\;\\alpha,\\beta\\in\\mathbb{R}\\Longrightarrow\\alpha u+\\beta v\\in T_A\\mathcal{M}_F',
    `provenance`='original',`source_id`=NULL,
    `assumptions`='Def. 3.4.38 und Def. 3.4.39 gelten.',
    `validation_status`='checked',`created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_3418_id;

INSERT INTO `lemmas` (
 `lemma_number`,`section_id`,`title`,`statement_text`,`statement_latex`,`word_latex`,
 `provenance`,`source_id`,`assumptions`,`validation_status`,`created_revision_id`
)
SELECT 'Lemma 3.4.18',@section_id,'Lineare Struktur des funktionalen Tangentialraums',
 'Der funktionale Tangentialraum ist unter Addition und Skalarmultiplikation abgeschlossen und bildet einen reellen Vektorraum.',
 'u,v\\in T_A\\mathcal{M}_F,\\;\\alpha,\\beta\\in\\mathbb{R}\\Longrightarrow\\alpha u+\\beta v\\in T_A\\mathcal{M}_F',
 'u,v\\in T_A\\mathcal{M}_F,\\;\\alpha,\\beta\\in\\mathbb{R}\\Longrightarrow\\alpha u+\\beta v\\in T_A\\mathcal{M}_F',
 'original',NULL,'Def. 3.4.38 und Def. 3.4.39 gelten.','checked',@revision_id
WHERE @lemma_3418_id IS NULL;
SET @lemma_3418_id := (SELECT `lemma_id` FROM `lemmas` WHERE `lemma_number`='Lemma 3.4.18' LIMIT 1);

UPDATE `theorems`
SET `section_id`=@section_id,
    `title`='Lokale Entwicklungsrichtungen',
    `statement_text`='Jeder Punkt einer differenzierbaren funktionalen Mannigfaltigkeit besitzt einen wohldefinierten funktionalen Tangentialraum, dessen Dimension der lokalen Mannigfaltigkeitsdimension entspricht.',
    `statement_latex`='A\\in\\mathcal{M}_F\\Longrightarrow\\exists\\,T_A\\mathcal{M}_F,\\qquad\\dim T_A\\mathcal{M}_F=\\dim\\mathcal{M}_F',
    `word_latex`='A\\in\\mathcal{M}_F\\Longrightarrow\\exists\\,T_A\\mathcal{M}_F,\\qquad\\dim T_A\\mathcal{M}_F=\\dim\\mathcal{M}_F',
    `provenance`='original',`source_id`=NULL,
    `assumptions`='Satz 3.4.19 sowie Def. 3.4.38 und Def. 3.4.39 gelten.',
    `validation_status`='checked',`created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3420_id;

INSERT INTO `theorems` (
 `theorem_number`,`section_id`,`title`,`statement_text`,`statement_latex`,`word_latex`,
 `provenance`,`source_id`,`assumptions`,`validation_status`,`created_revision_id`
)
SELECT 'Satz 3.4.20',@section_id,'Lokale Entwicklungsrichtungen',
 'Jeder Punkt einer differenzierbaren funktionalen Mannigfaltigkeit besitzt einen wohldefinierten funktionalen Tangentialraum, dessen Dimension der lokalen Mannigfaltigkeitsdimension entspricht.',
 'A\\in\\mathcal{M}_F\\Longrightarrow\\exists\\,T_A\\mathcal{M}_F,\\qquad\\dim T_A\\mathcal{M}_F=\\dim\\mathcal{M}_F',
 'A\\in\\mathcal{M}_F\\Longrightarrow\\exists\\,T_A\\mathcal{M}_F,\\qquad\\dim T_A\\mathcal{M}_F=\\dim\\mathcal{M}_F',
 'original',NULL,'Satz 3.4.19 sowie Def. 3.4.38 und Def. 3.4.39 gelten.','checked',@revision_id
WHERE @theorem_3420_id IS NULL;
SET @theorem_3420_id := (SELECT `theorem_id` FROM `theorems` WHERE `theorem_number`='Satz 3.4.20' LIMIT 1);

DELETE FROM `object_dependencies`
WHERE (`object_type_from`='equation' AND `object_id_from` IN (
 SELECT `equation_id` FROM `equations` WHERE `equation_number` IN ('3.151','3.152','3.153','3.154')))
OR (`object_type_to`='equation' AND `object_id_to` IN (
 SELECT `equation_id` FROM `equations` WHERE `equation_number` IN ('3.151','3.152','3.153','3.154')));

DELETE ed FROM `equation_dependencies` ed JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.151','3.152','3.153','3.154');
DELETE ed FROM `equation_dependencies` ed JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.151','3.152','3.153','3.154');
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.151','3.152','3.153','3.154');
DELETE FROM `equations` WHERE `equation_number` IN ('3.151','3.152','3.153','3.154');

INSERT INTO `equations` (
 `equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,
 `equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`
) VALUES
('3.151',@section_id,'Leibniz-Regel des funktionalen Tangentialvektors',
 'v(fg)=v(f)\\,g(A)+f(A)\\,v(g)','v(fg)=v(f)\\,g(A)+f(A)\\,v(g)',
 'Ein funktionaler Tangentialvektor wirkt als Derivation und erfüllt die Leibniz-Regel.',
 'definition','original',NULL,'Formale Darstellung von Def. 3.4.38.',
 'f und g sind glatte reellwertige Funktionen.','checked',@revision_id),
('3.152',@section_id,'Funktionaler Tangentialraum',
 'T_A\\mathcal{M}_F=\\left\\{v\\mid v\\text{ ist funktionaler Tangentialvektor in }A\\right\\}',
 'T_A\\mathcal{M}_F=\\left\\{v\\mid v\\text{ ist funktionaler Tangentialvektor in }A\\right\\}',
 'Der funktionale Tangentialraum enthält sämtliche funktionalen Tangentialvektoren im Punkt A.',
 'definition','original',NULL,'Formale Darstellung von Def. 3.4.39.','Def. 3.4.38 gilt.','checked',@revision_id),
('3.153',@section_id,'Lineare Struktur des Tangentialraums',
 'u,v\\in T_A\\mathcal{M}_F,\\;\\alpha,\\beta\\in\\mathbb{R}\\Longrightarrow\\alpha u+\\beta v\\in T_A\\mathcal{M}_F',
 'u,v\\in T_A\\mathcal{M}_F,\\;\\alpha,\\beta\\in\\mathbb{R}\\Longrightarrow\\alpha u+\\beta v\\in T_A\\mathcal{M}_F',
 'Der funktionale Tangentialraum ist unter Linearkombinationen abgeschlossen.',
 'lemma','original',NULL,'Formale Darstellung von Lemma 3.4.18.','Def. 3.4.38 und Def. 3.4.39 gelten.','checked',@revision_id),
('3.154',@section_id,'Existenz des funktionalen Tangentialraums',
 'A\\in\\mathcal{M}_F\\Longrightarrow\\exists\\,T_A\\mathcal{M}_F,\\qquad\\dim T_A\\mathcal{M}_F=\\dim\\mathcal{M}_F',
 'A\\in\\mathcal{M}_F\\Longrightarrow\\exists\\,T_A\\mathcal{M}_F,\\qquad\\dim T_A\\mathcal{M}_F=\\dim\\mathcal{M}_F',
 'Jeder Punkt einer differenzierbaren funktionalen Mannigfaltigkeit besitzt einen wohldefinierten Tangentialraum.',
 'theorem','original',NULL,'Formale Darstellung von Satz 3.4.20.','Satz 3.4.19 gilt.','checked',@revision_id);

SET @eq_3151 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.151' LIMIT 1);
SET @eq_3152 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.152' LIMIT 1);
SET @eq_3153 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.153' LIMIT 1);
SET @eq_3154 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.154' LIMIT 1);
SET @eq_3148 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.148' LIMIT 1);
SET @eq_3149 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.149' LIMIT 1);
SET @eq_3150 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.150' LIMIT 1);

DELETE FROM `equation_symbols` WHERE `equation_id` IN (@eq_3151,@eq_3152,@eq_3153,@eq_3154);
INSERT INTO `equation_symbols` (
 `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`
) VALUES
(@eq_3151,'v','funktionaler Tangentialvektor','Lineare Derivation im Punkt A.',NULL,'T_A\\mathcal{M}_F',1),
(@eq_3151,'f,g','glatte funktionale Größen','Glatte reellwertige Funktionen auf der funktionalen Mannigfaltigkeit.',NULL,'C^\\infty(\\mathcal{M}_F)',2),
(@eq_3151,'A','funktionaler Organisationspunkt','Punkt der funktionalen Mannigfaltigkeit.',NULL,'A\\in\\mathcal{M}_F',3),
(@eq_3152,'T_A\\mathcal{M}_F','funktionaler Tangentialraum','Vektorraum aller Tangentialvektoren im Punkt A.',NULL,'reeller Vektorraum',1),
(@eq_3153,'u,v','Tangentialvektoren','Zwei Elemente des funktionalen Tangentialraums.',NULL,'T_A\\mathcal{M}_F',1),
(@eq_3153,'\\alpha,\\beta','reelle Skalare','Koeffizienten einer Linearkombination.',NULL,'\\mathbb{R}',2),
(@eq_3154,'\\dim T_A\\mathcal{M}_F','Tangentialraumdimension','Dimension des Tangentialraums im Punkt A.',NULL,'\\mathbb{N}',1),
(@eq_3154,'\\dim\\mathcal{M}_F','Mannigfaltigkeitsdimension','Lokale Dimension der funktionalen Mannigfaltigkeit.',NULL,'\\mathbb{N}',2)
ON DUPLICATE KEY UPDATE
 `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),
 `unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);

DELETE FROM `object_dependencies`
WHERE (`object_type_from`='definition' AND `object_id_from` IN (@def_3438_id,@def_3439_id))
OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3418_id)
OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3420_id)
OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3151,@eq_3152,@eq_3153,@eq_3154));

INSERT INTO `object_dependencies` (
 `object_type_from`,`object_id_from`,`object_type_to`,`object_id_to`,`dependency_type`,`note`
) VALUES
('definition',@def_3438_id,'definition',@def_3435_id,'depends_on','Der Tangentialvektor wird auf der funktionalen Mannigfaltigkeit definiert.'),
('definition',@def_3438_id,'definition',@def_3437_id,'depends_on','Die Ableitungsstruktur setzt einen differenzierbaren Atlas voraus.'),
('definition',@def_3439_id,'definition',@def_3438_id,'depends_on','Der Tangentialraum besteht aus funktionalen Tangentialvektoren.'),
('lemma',@lemma_3418_id,'definition',@def_3439_id,'depends_on','Das Lemma beschreibt die lineare Struktur des Tangentialraums.'),
('theorem',@theorem_3420_id,'definition',@def_3439_id,'depends_on','Der Satz behauptet die Existenz des funktionalen Tangentialraums.'),
('theorem',@theorem_3420_id,'lemma',@lemma_3418_id,'depends_on','Der Tangentialraum besitzt die Struktur eines reellen Vektorraums.'),
('equation',@eq_3151,'definition',@def_3438_id,'derives_from','Gleichung (3.151) formalisiert Def. 3.4.38.'),
('equation',@eq_3152,'definition',@def_3439_id,'derives_from','Gleichung (3.152) formalisiert Def. 3.4.39.'),
('equation',@eq_3153,'lemma',@lemma_3418_id,'derives_from','Gleichung (3.153) formalisiert Lemma 3.4.18.'),
('equation',@eq_3154,'theorem',@theorem_3420_id,'derives_from','Gleichung (3.154) formalisiert Satz 3.4.20.');

DELETE FROM `equation_dependencies` WHERE `equation_id` IN (@eq_3151,@eq_3152,@eq_3153,@eq_3154);
INSERT INTO `equation_dependencies` (
 `equation_id`,`depends_on_equation_id`,`dependency_type`,`dependency_note`
) VALUES
(@eq_3151,@eq_3150,'depends_on','Die Tangentialvektordefinition setzt die differenzierbare funktionale Mannigfaltigkeit voraus.'),
(@eq_3151,@eq_3148,'depends_on','Die Ableitungsstruktur wird durch differenzierbare Kartenübergänge abgesichert.'),
(@eq_3152,@eq_3151,'derives_from','Der Tangentialraum wird als Menge funktionaler Tangentialvektoren gebildet.'),
(@eq_3153,@eq_3152,'depends_on','Die lineare Struktur wird auf dem Tangentialraum formuliert.'),
(@eq_3154,@eq_3152,'depends_on','Die Existenzaussage bezieht sich auf den Tangentialraum.'),
(@eq_3154,@eq_3149,'depends_on','Die Kartenstruktur bestimmt die lokale Dimension des Tangentialraums.');

DELETE FROM `section_change_log` WHERE `revision_id`=@revision_id AND `section_id`=@section_id;
INSERT INTO `section_change_log` (
 `revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,
 `change_summary`,`previous_value`,`new_value`
) VALUES
(@revision_id,@section_id,'rewritten','section','3.4.20',
 'Abschnitt 3.4.20 wurde vollständig als Rekonstruktion funktionaler Tangentialräume neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.20.',
 'Def. 3.4.38, Def. 3.4.39, Lemma 3.4.18, Satz 3.4.20 und Gleichungen (3.151) bis (3.154).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.38–Def. 3.4.39',
 'Funktionaler Tangentialvektor und funktionaler Tangentialraum wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.18',
 'Die lineare Struktur des funktionalen Tangentialraums wurde registriert.',NULL,'Reeller Vektorraum'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.20',
 'Die Existenz lokaler funktionaler Entwicklungsrichtungen wurde registriert.',NULL,'Wohldefinierter Tangentialraum in jedem Punkt'),
(@revision_id,@section_id,'equation_added','equation','(3.151)–(3.154)',
 'Leibniz-Regel, Tangentialraum, lineare Struktur und Existenzsatz wurden formal registriert.',NULL,'4 Gleichungen');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES
('next_equation_number','3.155'),
('next_definition_number','Def. 3.4.40'),
('next_lemma_number','Lemma 3.4.19'),
('next_theorem_number','Satz 3.4.21'),
('last_edited_section','3.4.20'),
('last_repository_revision','RKB-2026-07-14-K3.4.20-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.20') ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.38','Def. 3.4.39') ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas` WHERE `lemma_number`='Lemma 3.4.18';

SELECT `theorem_number`,`title`,`statement_latex`,`validation_status`
FROM `theorems` WHERE `theorem_number`='Satz 3.4.20';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.151','3.152','3.153','3.154')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_20`
FROM `source_usage` WHERE `section_id`=@section_id;

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN (
 'next_equation_number','next_definition_number','next_lemma_number',
 'next_theorem_number','last_edited_section','last_repository_revision'
)
ORDER BY `counter_key`;
