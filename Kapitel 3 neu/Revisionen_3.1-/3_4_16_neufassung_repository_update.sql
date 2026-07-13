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
    'RKB-2026-07-13-K3.4.16-NEUFASSUNG-V1',
    NOW(),'section','3.4.16','1.0',
    'Neufassung von Abschnitt 3.4.16 mit Def. 3.4.30, Def. 3.4.31, Lemma 3.4.14, Satz 3.4.16 und den Gleichungen (3.137) bis (3.139).',
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
    @chapter_id,'3.4.16','Vollständigkeit funktionaler Räume',
    3,3.5970,'review',1,
    'Rekonstruktion funktionaler Cauchy-Folgen, Vollständigkeit und eindeutiger funktionaler Grenzwerte.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM `dissertation_sections`
      WHERE `section_code`='3.4.16'
  );

SET @section_id := (
    SELECT `section_id` FROM `dissertation_sections`
    WHERE `section_code`='3.4.16' LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Vollständigkeit funktionaler Räume',
    `chapter_no`=3,
    `section_order`=3.5970,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.30, Def. 3.4.31, Lemma 3.4.14, Satz 3.4.16 und die Gleichungen (3.137) bis (3.139).'
WHERE `section_id`=@section_id;

DELETE FROM `source_usage` WHERE `section_id`=@section_id;

SET @def_3427_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.27' LIMIT 1
);
SET @def_3430_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.30' LIMIT 1
);
SET @def_3431_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.31' LIMIT 1
);
SET @lemma_3414_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.14' LIMIT 1
);
SET @theorem_3416_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.16' LIMIT 1
);

UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Cauchy-Folge',
    `definition_text`='Eine Folge funktionaler Quotientenklassen heißt funktionale Cauchy-Folge, wenn ihre Folgenglieder ab einem hinreichend großen Index paarweise beliebig kleine funktionale Abstände besitzen.',
    `formal_latex`='\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow d_F(A_m,A_n)<\\varepsilon',
    `word_latex`='\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow d_F(A_m,A_n)<\\varepsilon',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.27 und Satz 3.4.14 gelten.',
    `notes`='Die Definition setzt keinen Grenzwert voraus, sondern nur die innere Annäherung der Folge.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3430_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.30',@section_id,'Funktionale Cauchy-Folge',
    'Eine Folge funktionaler Quotientenklassen heißt funktionale Cauchy-Folge, wenn ihre Folgenglieder ab einem hinreichend großen Index paarweise beliebig kleine funktionale Abstände besitzen.',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow d_F(A_m,A_n)<\\varepsilon',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow d_F(A_m,A_n)<\\varepsilon',
    'original',NULL,'Def. 3.4.27 und Satz 3.4.14 gelten.',
    'Die Definition setzt keinen Grenzwert voraus, sondern nur die innere Annäherung der Folge.',
    'checked',@revision_id
WHERE @def_3430_id IS NULL;

SET @def_3430_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.30' LIMIT 1
);

UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Vollständigkeit',
    `definition_text`='Ein funktionaler metrischer Raum heißt funktional vollständig, wenn jede funktionale Cauchy-Folge gegen eine Quotientenklasse desselben Raumes konvergiert.',
    `formal_latex`='(A_n)\\text{ Cauchy}\\Longrightarrow\\exists A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    `word_latex`='(A_n)\\text{ Cauchy}\\Longrightarrow\\exists A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.30 und Gleichung (3.135) gelten.',
    `notes`='Vollständigkeit stellt sicher, dass funktionale Grenzprozesse den betrachteten Raum nicht verlassen.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3431_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.31',@section_id,'Funktionale Vollständigkeit',
    'Ein funktionaler metrischer Raum heißt funktional vollständig, wenn jede funktionale Cauchy-Folge gegen eine Quotientenklasse desselben Raumes konvergiert.',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    'original',NULL,'Def. 3.4.30 und Gleichung (3.135) gelten.',
    'Vollständigkeit stellt sicher, dass funktionale Grenzprozesse den betrachteten Raum nicht verlassen.',
    'checked',@revision_id
WHERE @def_3431_id IS NULL;

SET @def_3431_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.31' LIMIT 1
);

UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Eindeutigkeit funktionaler Grenzwerte',
    `statement_text`='Konvergiert eine Folge funktionaler Quotientenklassen, dann besitzt sie höchstens einen Grenzwert.',
    `statement_latex`='A_n\\rightarrow A\\;\\land\\;A_n\\rightarrow B\\Longrightarrow A=B',
    `word_latex`='A_n\\rightarrow A\\;\\land\\;A_n\\rightarrow B\\Longrightarrow A=B',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Gleichung (3.128), Gleichung (3.130) und Gleichung (3.135) gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_3414_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.14',@section_id,'Eindeutigkeit funktionaler Grenzwerte',
    'Konvergiert eine Folge funktionaler Quotientenklassen, dann besitzt sie höchstens einen Grenzwert.',
    'A_n\\rightarrow A\\;\\land\\;A_n\\rightarrow B\\Longrightarrow A=B',
    'A_n\\rightarrow A\\;\\land\\;A_n\\rightarrow B\\Longrightarrow A=B',
    'original',NULL,
    'Gleichung (3.128), Gleichung (3.130) und Gleichung (3.135) gelten.',
    'checked',@revision_id
WHERE @lemma_3414_id IS NULL;

SET @lemma_3414_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.14' LIMIT 1
);

UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Vollständiger funktionaler Raum',
    `statement_text`='In einem funktional vollständigen metrischen Raum besitzt jede funktionale Cauchy-Folge einen eindeutig bestimmten Grenzwert innerhalb der funktionalen Quotientenstruktur.',
    `statement_latex`='(A_n)\\text{ Cauchy}\\Longrightarrow\\exists!\\,A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    `word_latex`='(A_n)\\text{ Cauchy}\\Longrightarrow\\exists!\\,A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.30, Def. 3.4.31 und Lemma 3.4.14 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3416_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.16',@section_id,'Vollständiger funktionaler Raum',
    'In einem funktional vollständigen metrischen Raum besitzt jede funktionale Cauchy-Folge einen eindeutig bestimmten Grenzwert innerhalb der funktionalen Quotientenstruktur.',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists!\\,A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists!\\,A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    'original',NULL,
    'Def. 3.4.30, Def. 3.4.31 und Lemma 3.4.14 gelten.',
    'checked',@revision_id
WHERE @theorem_3416_id IS NULL;

SET @theorem_3416_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.16' LIMIT 1
);

DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='equation' AND `object_id_from` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.137','3.138','3.139')
 ))
 OR
 (`object_type_to`='equation' AND `object_id_to` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.137','3.138','3.139')
 ));

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.137','3.138','3.139');

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.137','3.138','3.139');

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.137','3.138','3.139');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.137','3.138','3.139');

INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.137',@section_id,'Funktionale Cauchy-Folge',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow d_F(A_m,A_n)<\\varepsilon',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow d_F(A_m,A_n)<\\varepsilon',
    'Die Folgenglieder einer funktionalen Cauchy-Folge besitzen ab einem hinreichend großen Index beliebig kleine paarweise Abstände.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.30.',
    'Def. 3.4.27 gilt.','checked',@revision_id
),
(
    '3.138',@section_id,'Funktionale Vollständigkeit',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    'Jede funktionale Cauchy-Folge konvergiert in einem vollständigen funktionalen Raum gegen eine Quotientenklasse desselben Raumes.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.31.',
    'Def. 3.4.30 und Gleichung (3.135) gelten.','checked',@revision_id
),
(
    '3.139',@section_id,'Vollständiger funktionaler Raum',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists!\\,A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    '(A_n)\\text{ Cauchy}\\Longrightarrow\\exists!\\,A\\in\\mathfrak{Q}_F:\\;A_n\\rightarrow A',
    'Jede funktionale Cauchy-Folge besitzt in einem vollständigen funktionalen Raum einen eindeutig bestimmten Grenzwert.',
    'theorem','original',NULL,'Formale Darstellung von Satz 3.4.16.',
    'Def. 3.4.31 und Lemma 3.4.14 gelten.','checked',@revision_id
);

SET @eq_3137 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.137' LIMIT 1);
SET @eq_3138 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.138' LIMIT 1);
SET @eq_3139 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.139' LIMIT 1);
SET @eq_3128 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.128' LIMIT 1);
SET @eq_3130 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.130' LIMIT 1);
SET @eq_3131 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.131' LIMIT 1);
SET @eq_3135 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.135' LIMIT 1);

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3137,@eq_3138,@eq_3139);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3137,'A_n','funktionale Folge','Folge funktionaler Quotientenklassen.',NULL,'A_n\\in\\mathfrak{Q}_F',1),
(@eq_3137,'m,n','Folgenindizes','Indizes zweier Folgenglieder.',NULL,'\\mathbb{N}',2),
(@eq_3137,'N','Cauchy-Index','Index, ab dem alle Folgenglieder paarweise nahe beieinander liegen.',NULL,'\\mathbb{N}',3),
(@eq_3137,'\\varepsilon','Abstandsschranke','Beliebige positive Schranke des funktionalen Abstands.',NULL,'\\mathbb{R}_{>0}',4),
(@eq_3138,'A','funktionaler Grenzwert','Grenzklasse der funktionalen Cauchy-Folge.',NULL,'A\\in\\mathfrak{Q}_F',1),
(@eq_3138,'\\mathfrak{Q}_F','funktionale Quotientenstruktur','Grundmenge des vollständigen funktionalen Raumes.',NULL,'Quotientenmenge',2),
(@eq_3139,'\\exists!','eindeutiger Existenzquantor','Kennzeichnet Existenz und Eindeutigkeit des Grenzwertes.',NULL,'Logik',1)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='definition' AND `object_id_from` IN (@def_3430_id,@def_3431_id))
 OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3414_id)
 OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3416_id)
 OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3137,@eq_3138,@eq_3139));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3430_id,'definition',@def_3427_id,'depends_on','Die Cauchy-Folge wird durch die funktionale Metrik definiert.'),
('definition',@def_3431_id,'definition',@def_3430_id,'depends_on','Funktionale Vollständigkeit setzt funktionale Cauchy-Folgen voraus.'),
('lemma',@lemma_3414_id,'definition',@def_3427_id,'depends_on','Die Eindeutigkeit verwendet die Metrikaxiome.'),
('theorem',@theorem_3416_id,'definition',@def_3431_id,'depends_on','Die Existenz folgt aus funktionaler Vollständigkeit.'),
('theorem',@theorem_3416_id,'lemma',@lemma_3414_id,'depends_on','Die Eindeutigkeit folgt aus Lemma 3.4.14.'),
('equation',@eq_3137,'definition',@def_3430_id,'derives_from','Gleichung (3.137) formalisiert Def. 3.4.30.'),
('equation',@eq_3138,'definition',@def_3431_id,'derives_from','Gleichung (3.138) formalisiert Def. 3.4.31.'),
('equation',@eq_3139,'theorem',@theorem_3416_id,'derives_from','Gleichung (3.139) formalisiert Satz 3.4.16.');

DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3137,@eq_3138,@eq_3139);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3137,@eq_3131,'depends_on','Die Cauchy-Bedingung wird im funktionalen metrischen Raum formuliert.'),
(@eq_3138,@eq_3137,'depends_on','Funktionale Vollständigkeit quantifiziert über Cauchy-Folgen.'),
(@eq_3138,@eq_3135,'depends_on','Die Konvergenzaussage verwendet Gleichung (3.135).'),
(@eq_3139,@eq_3138,'derives_from','Die Existenz des Grenzwertes folgt aus Vollständigkeit.'),
(@eq_3139,@eq_3128,'depends_on','Die Eindeutigkeit verwendet die Identität der Ununterscheidbaren.'),
(@eq_3139,@eq_3130,'depends_on','Die Eindeutigkeit verwendet die Dreiecksungleichung.');

DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.16',
 'Abschnitt 3.4.16 wurde vollständig als Rekonstruktion funktionaler Vollständigkeit neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.16.',
 'Def. 3.4.30, Def. 3.4.31, Lemma 3.4.14, Satz 3.4.16 und Gleichungen (3.137) bis (3.139).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.30–Def. 3.4.31',
 'Funktionale Cauchy-Folge und funktionale Vollständigkeit wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.14',
 'Die Eindeutigkeit funktionaler Grenzwerte wurde registriert.',NULL,'Eindeutigkeit funktionaler Grenzwerte'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.16',
 'Der vollständige funktionale Raum wurde registriert.',NULL,'Existenz und Eindeutigkeit funktionaler Grenzwerte'),
(@revision_id,@section_id,'equation_added','equation','(3.137)–(3.139)',
 'Cauchy-Bedingung, funktionale Vollständigkeit und eindeutiger Grenzwert wurden formal registriert.',NULL,'3 Gleichungen');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.140'),
('next_definition_number','Def. 3.4.32'),
('next_lemma_number','Lemma 3.4.15'),
('next_theorem_number','Satz 3.4.17'),
('last_edited_section','3.4.16'),
('last_repository_revision','RKB-2026-07-13-K3.4.16-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.16')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.30','Def. 3.4.31')
ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas`
WHERE `lemma_number`='Lemma 3.4.14';

SELECT `theorem_number`,`title`,`statement_latex`,`validation_status`
FROM `theorems`
WHERE `theorem_number`='Satz 3.4.16';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.137','3.138','3.139')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_16`
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
