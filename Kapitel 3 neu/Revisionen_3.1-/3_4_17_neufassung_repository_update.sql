USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.17 – Kompaktheit funktionaler Räume

   Definitionen:
   - Def. 3.4.32 Funktionale Überdeckung
   - Def. 3.4.33 Funktionale Kompaktheit

   Lemma:
   - Lemma 3.4.15 Funktionale Folgenkompaktheit

   Satz:
   - Satz 3.4.17 Existenz funktionaler Grenzorganisationen

   Gleichungen:
   - (3.140) Funktionale Überdeckung
   - (3.141) Funktionale Kompaktheit
   - (3.142) Existenz funktionaler Grenzorganisationen

   Neue Quellen: keine
   Nächste Gleichung:   (3.143)
   Nächste Definition:  Def. 3.4.34
   Nächstes Lemma:      Lemma 3.4.16
   Nächster Satz:       Satz 3.4.18

   Mathematische Präzisierung:
   In metrischen Räumen sind Kompaktheit und Folgenkompaktheit
   äquivalent. Der Grenzwert der konvergenten Teilfolge liegt
   bei Kompaktheit bereits in K; eine zusätzliche
   Vollständigkeitsannahme ist nicht erforderlich.
   ============================================================ */

SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

INSERT INTO `repository_revisions` (
    `revision_code`,`revision_date`,`scope_type`,`scope_reference`,
    `version_label`,`summary`,`created_by`,`parent_revision_id`
)
VALUES (
    'RKB-2026-07-13-K3.4.17-NEUFASSUNG-V1',
    NOW(),'section','3.4.17','1.0',
    'Neufassung von Abschnitt 3.4.17 mit Def. 3.4.32, Def. 3.4.33, Lemma 3.4.15, Satz 3.4.17 und den Gleichungen (3.140) bis (3.142).',
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
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code`='3.4'
    LIMIT 1
);

INSERT INTO `dissertation_sections` (
    `parent_section_id`,`section_code`,`title`,`chapter_no`,
    `section_order`,`status`,`is_original_contribution`,`notes`
)
SELECT
    @chapter_id,'3.4.17','Kompaktheit funktionaler Räume',
    3,3.5980,'review',1,
    'Rekonstruktion funktionaler Überdeckungen, funktionaler Kompaktheit und funktionaler Grenzorganisationen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code`='3.4.17'
  );

SET @section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code`='3.4.17'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Kompaktheit funktionaler Räume',
    `chapter_no`=3,
    `section_order`=3.5980,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.32, Def. 3.4.33, Lemma 3.4.15, Satz 3.4.17 und die Gleichungen (3.140) bis (3.142).'
WHERE `section_id`=@section_id;

UPDATE `dissertation_sections`
SET `status`='review',`is_original_contribution`=1
WHERE `section_id`=@chapter_id;

DELETE FROM `source_usage`
WHERE `section_id`=@section_id;

SET @def_3429_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.29' LIMIT 1
);
SET @def_3432_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.32' LIMIT 1
);
SET @def_3433_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.33' LIMIT 1
);
SET @lemma_3415_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.15' LIMIT 1
);
SET @theorem_3417_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.17' LIMIT 1
);

/* Def. 3.4.32 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Überdeckung',
    `definition_text`='Eine Familie funktional offener Mengen heißt funktionale offene Überdeckung einer Teilmenge M, wenn M in der Vereinigung dieser Mengen enthalten ist.',
    `formal_latex`='M\\subseteq\\bigcup_{i\\in I}U_i',
    `word_latex`='M\\subseteq\\bigcup_{i\\in I}U_i',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.29 gilt; jedes U_i ist funktional offen.',
    `notes`='Die Indexmenge I kann endlich oder unendlich sein.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3432_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.32',@section_id,'Funktionale Überdeckung',
    'Eine Familie funktional offener Mengen heißt funktionale offene Überdeckung einer Teilmenge M, wenn M in der Vereinigung dieser Mengen enthalten ist.',
    'M\\subseteq\\bigcup_{i\\in I}U_i',
    'M\\subseteq\\bigcup_{i\\in I}U_i',
    'original',NULL,
    'Def. 3.4.29 gilt; jedes U_i ist funktional offen.',
    'Die Indexmenge I kann endlich oder unendlich sein.',
    'checked',@revision_id
WHERE @def_3432_id IS NULL;

SET @def_3432_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.32' LIMIT 1
);

/* Def. 3.4.33 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Kompaktheit',
    `definition_text`='Eine Teilmenge der funktionalen Quotientenstruktur heißt funktional kompakt, wenn jede funktionale offene Überdeckung eine endliche Teilüberdeckung besitzt.',
    `formal_latex`='K\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n\\in I:\\;K\\subseteq\\bigcup_{k=1}^{n}U_{i_k}',
    `word_latex`='K\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n\\in I:\\;K\\subseteq\\bigcup_{k=1}^{n}U_{i_k}',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.32 gilt.',
    `notes`='Im funktionalen metrischen Raum ist Kompaktheit äquivalent zur Folgenkompaktheit.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3433_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.33',@section_id,'Funktionale Kompaktheit',
    'Eine Teilmenge der funktionalen Quotientenstruktur heißt funktional kompakt, wenn jede funktionale offene Überdeckung eine endliche Teilüberdeckung besitzt.',
    'K\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n\\in I:\\;K\\subseteq\\bigcup_{k=1}^{n}U_{i_k}',
    'K\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n\\in I:\\;K\\subseteq\\bigcup_{k=1}^{n}U_{i_k}',
    'original',NULL,'Def. 3.4.32 gilt.',
    'Im funktionalen metrischen Raum ist Kompaktheit äquivalent zur Folgenkompaktheit.',
    'checked',@revision_id
WHERE @def_3433_id IS NULL;

SET @def_3433_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.33' LIMIT 1
);

/* Lemma 3.4.15 */
UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Funktionale Folgenkompaktheit',
    `statement_text`='In einem funktionalen metrischen Raum besitzt jede Folge in einer funktional kompakten Teilmenge eine Teilfolge, die gegen ein Element dieser Teilmenge konvergiert.',
    `statement_latex`='(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    `word_latex`='(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.27, Def. 3.4.33 und Satz 3.4.14 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_3415_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.15',@section_id,'Funktionale Folgenkompaktheit',
    'In einem funktionalen metrischen Raum besitzt jede Folge in einer funktional kompakten Teilmenge eine Teilfolge, die gegen ein Element dieser Teilmenge konvergiert.',
    '(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    '(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    'original',NULL,
    'Def. 3.4.27, Def. 3.4.33 und Satz 3.4.14 gelten.',
    'checked',@revision_id
WHERE @lemma_3415_id IS NULL;

SET @lemma_3415_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.15' LIMIT 1
);

/* Satz 3.4.17 */
UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Existenz funktionaler Grenzorganisationen',
    `statement_text`='Jede Folge funktionaler Organisationsklassen in einer funktional kompakten Teilmenge besitzt eine konvergente Teilfolge mit Grenzwert innerhalb derselben Teilmenge.',
    `statement_latex`='(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    `word_latex`='(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.33 und Lemma 3.4.15 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3417_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.17',@section_id,'Existenz funktionaler Grenzorganisationen',
    'Jede Folge funktionaler Organisationsklassen in einer funktional kompakten Teilmenge besitzt eine konvergente Teilfolge mit Grenzwert innerhalb derselben Teilmenge.',
    '(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    '(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    'original',NULL,'Def. 3.4.33 und Lemma 3.4.15 gelten.',
    'checked',@revision_id
WHERE @theorem_3417_id IS NULL;

SET @theorem_3417_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.17' LIMIT 1
);

/* 9. Gleichungen neu aufbauen. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='equation' AND `object_id_from` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.140','3.141','3.142')
 ))
 OR
 (`object_type_to`='equation' AND `object_id_to` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.140','3.141','3.142')
 ));

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.140','3.141','3.142');

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.140','3.141','3.142');

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.140','3.141','3.142');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.140','3.141','3.142');

INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.140',@section_id,'Funktionale Überdeckung',
    'M\\subseteq\\bigcup_{i\\in I}U_i',
    'M\\subseteq\\bigcup_{i\\in I}U_i',
    'Eine Familie funktional offener Mengen überdeckt die Teilmenge M.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.32.',
    'Jedes U_i ist funktional offen.','checked',@revision_id
),
(
    '3.141',@section_id,'Funktionale Kompaktheit',
    'K\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n\\in I:\\;K\\subseteq\\bigcup_{k=1}^{n}U_{i_k}',
    'K\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n\\in I:\\;K\\subseteq\\bigcup_{k=1}^{n}U_{i_k}',
    'Jede funktionale offene Überdeckung einer kompakten Teilmenge besitzt eine endliche Teilüberdeckung.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.33.',
    'Def. 3.4.32 gilt.','checked',@revision_id
),
(
    '3.142',@section_id,'Existenz funktionaler Grenzorganisationen',
    '(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    '(A_n)\\subseteq K\\Longrightarrow\\exists(A_{n_k}),\\;A\\in K:\\;A_{n_k}\\rightarrow A',
    'Jede Folge in einer funktional kompakten Teilmenge besitzt eine konvergente Teilfolge mit Grenzwert in K.',
    'theorem','original',NULL,'Formale Darstellung von Lemma 3.4.15 und Satz 3.4.17.',
    'K ist funktional kompakt.','checked',@revision_id
);

SET @eq_3140 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.140' LIMIT 1);
SET @eq_3141 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.141' LIMIT 1);
SET @eq_3142 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.142' LIMIT 1);
SET @eq_3132 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.132' LIMIT 1);
SET @eq_3133 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.133' LIMIT 1);
SET @eq_3135 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.135' LIMIT 1);

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3140,@eq_3141,@eq_3142);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3140,'M','überdeckte Teilmenge','Teilmenge der funktionalen Quotientenstruktur.',NULL,'M\\subseteq\\mathfrak{Q}_F',1),
(@eq_3140,'U_i','funktional offene Menge','Element einer funktionalen offenen Überdeckung.',NULL,'U_i\\in\\mathcal{T}_F',2),
(@eq_3140,'I','Indexmenge','Indexmenge der offenen Überdeckung.',NULL,'Indexmenge',3),
(@eq_3141,'K','funktional kompakte Teilmenge','Teilmenge mit endlicher Teilüberdeckungseigenschaft.',NULL,'K\\subseteq\\mathfrak{Q}_F',1),
(@eq_3141,'i_1,\\ldots,i_n','endliche Indexauswahl','Endliche Auswahl aus der ursprünglichen Indexmenge.',NULL,'I',2),
(@eq_3142,'A_{n_k}','konvergente Teilfolge','Aus der ursprünglichen Folge ausgewählte konvergente Teilfolge.',NULL,'K',1),
(@eq_3142,'A','funktionale Grenzorganisation','Grenzwert der konvergenten Teilfolge innerhalb von K.',NULL,'A\\in K',2)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* 10. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='definition' AND `object_id_from` IN (@def_3432_id,@def_3433_id))
 OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3415_id)
 OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3417_id)
 OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3140,@eq_3141,@eq_3142));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3432_id,'definition',@def_3429_id,'depends_on','Die funktionale Überdeckung verwendet funktional offene Mengen.'),
('definition',@def_3433_id,'definition',@def_3432_id,'depends_on','Funktionale Kompaktheit wird über funktionale offene Überdeckungen definiert.'),
('lemma',@lemma_3415_id,'definition',@def_3433_id,'depends_on','Folgenkompaktheit folgt aus funktionaler Kompaktheit im metrischen Raum.'),
('theorem',@theorem_3417_id,'lemma',@lemma_3415_id,'derives_from','Die Existenz einer Grenzorganisation folgt aus der konvergenten Teilfolge.'),
('equation',@eq_3140,'definition',@def_3432_id,'derives_from','Gleichung (3.140) formalisiert Def. 3.4.32.'),
('equation',@eq_3141,'definition',@def_3433_id,'derives_from','Gleichung (3.141) formalisiert Def. 3.4.33.'),
('equation',@eq_3142,'lemma',@lemma_3415_id,'derives_from','Gleichung (3.142) formalisiert Lemma 3.4.15.'),
('equation',@eq_3142,'theorem',@theorem_3417_id,'derives_from','Gleichung (3.142) formalisiert Satz 3.4.17.');

DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3140,@eq_3141,@eq_3142);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3140,@eq_3133,'depends_on','Die Überdeckung besteht aus Mengen der funktionalen Topologie.'),
(@eq_3140,@eq_3132,'depends_on','Funktional offene Mengen werden aus offenen Umgebungen gebildet.'),
(@eq_3141,@eq_3140,'derives_from','Funktionale Kompaktheit wird über offene Überdeckungen definiert.'),
(@eq_3142,@eq_3141,'derives_from','Die konvergente Teilfolge folgt aus funktionaler Kompaktheit im metrischen Raum.'),
(@eq_3142,@eq_3135,'depends_on','Die Aussage verwendet die funktionale Konvergenz.');

/* 11. Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.17',
 'Abschnitt 3.4.17 wurde vollständig als Rekonstruktion funktionaler Kompaktheit neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.17.',
 'Def. 3.4.32, Def. 3.4.33, Lemma 3.4.15, Satz 3.4.17 und Gleichungen (3.140) bis (3.142).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.32–Def. 3.4.33',
 'Funktionale Überdeckung und funktionale Kompaktheit wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.15',
 'Die funktionale Folgenkompaktheit wurde registriert.',NULL,'Konvergente Teilfolge in kompakten funktionalen Räumen'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.17',
 'Die Existenz funktionaler Grenzorganisationen wurde registriert.',
 'Grenzwertbegründung über zusätzliche Vollständigkeit.',
 'Grenzwert liegt aufgrund der Kompaktheit bereits innerhalb von K.'),
(@revision_id,@section_id,'equation_added','equation','(3.140)–(3.142)',
 'Funktionale Überdeckung, Kompaktheit und Grenzorganisation wurden formal registriert.',NULL,'3 Gleichungen');

/* 12. Repository-Zähler. */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.143'),
('next_definition_number','Def. 3.4.34'),
('next_lemma_number','Lemma 3.4.16'),
('next_theorem_number','Satz 3.4.18'),
('last_edited_section','3.4.17'),
('last_repository_revision','RKB-2026-07-13-K3.4.17-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN
   ============================================================ */

SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.17')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.32','Def. 3.4.33')
ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas`
WHERE `lemma_number`='Lemma 3.4.15';

SELECT `theorem_number`,`title`,`statement_latex`,`validation_status`
FROM `theorems`
WHERE `theorem_number`='Satz 3.4.17';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.140','3.141','3.142')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT e.`equation_number`,es.`symbol_latex`,es.`symbol_name`,
       es.`domain_text`,es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.140','3.141','3.142')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
         es.`symbol_order`;

SELECT COUNT(*) AS `source_usages_in_3_4_17`
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
