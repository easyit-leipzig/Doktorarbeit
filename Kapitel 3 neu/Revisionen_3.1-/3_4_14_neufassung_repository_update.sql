USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.14
   Funktionale Metrik auf der Quotientenstruktur

   Definition:
   - Def. 3.4.27 Funktionale Metrik

   Lemma:
   - Lemma 3.4.12 Repräsentantenunabhängigkeit

   Satz:
   - Satz 3.4.14 Funktionaler metrischer Raum

   Gleichungen:
   - (3.126) Funktionale Metrik
   - (3.127) Nichtnegativität
   - (3.128) Identität der Ununterscheidbaren
   - (3.129) Symmetrie
   - (3.130) Dreiecksungleichung
   - (3.131) Funktionaler metrischer Raum

   Neue Quellen: keine

   Nächste Gleichung:   (3.132)
   Nächste Definition:  Def. 3.4.28
   Nächstes Lemma:      Lemma 3.4.13
   Nächster Satz:       Satz 3.4.15
   ============================================================ */

/* 1. Parent-Revision separat ermitteln, um MySQL #1093 zu vermeiden. */
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
    'RKB-2026-07-13-K3.4.14-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.14',
    '1.0',
    'Neufassung von Abschnitt 3.4.14 mit Def. 3.4.27, Lemma 3.4.12, Satz 3.4.14 und den Gleichungen (3.126) bis (3.131).',
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

/* 3. Kapitel und Abschnitt ermitteln; Abschnitt bei Bedarf anlegen. */
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
    '3.4.14',
    'Funktionale Metrik auf der Quotientenstruktur',
    3,
    3.5950,
    'review',
    1,
    'Rekonstruktion einer repräsentantenunabhängigen funktionalen Metrik auf der Quotientenstruktur.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code` = '3.4.14'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.14'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Funktionale Metrik auf der Quotientenstruktur',
    `chapter_no` = 3,
    `section_order` = 3.5950,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.27, Lemma 3.4.12, Satz 3.4.14 und die Gleichungen (3.126) bis (3.131).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1
WHERE `section_id` = @chapter_id;

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Vorgänger- und Zielobjekte ermitteln. */
SET @def_3426_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.26'
    LIMIT 1
);

SET @def_3427_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.27'
    LIMIT 1
);

SET @lemma_3412_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.12'
    LIMIT 1
);

SET @theorem_3414_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.14'
    LIMIT 1
);

/* 5. Def. 3.4.27 – Funktionale Metrik. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Metrik',
    `definition_text` = 'Eine funktionale Metrik ist eine Abbildung auf der funktionalen Quotientenstruktur, die Nichtnegativität, Identität der Ununterscheidbaren, Symmetrie und Dreiecksungleichung erfüllt.',
    `formal_latex` = 'd_F:\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',
    `word_latex` = 'd_F:\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.26 und Satz 3.4.13 gelten.',
    `notes` = 'Die Metrik wird auf Quotientenklassen und nicht auf beliebigen Repräsentanten definiert.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3427_id;

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
    'Def. 3.4.27',
    @section_id,
    'Funktionale Metrik',
    'Eine funktionale Metrik ist eine Abbildung auf der funktionalen Quotientenstruktur, die Nichtnegativität, Identität der Ununterscheidbaren, Symmetrie und Dreiecksungleichung erfüllt.',
    'd_F:\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',
    'd_F:\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',
    'original',
    NULL,
    'Def. 3.4.26 und Satz 3.4.13 gelten.',
    'Die Metrik wird auf Quotientenklassen und nicht auf beliebigen Repräsentanten definiert.',
    'checked',
    @revision_id
WHERE @def_3427_id IS NULL;

SET @def_3427_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.27'
    LIMIT 1
);

/* 6. Lemma 3.4.12 – Repräsentantenunabhängigkeit. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Repräsentantenunabhängigkeit der funktionalen Metrik',
    `statement_text` = 'Ist die funktionale Metrik auf Quotientenklassen definiert, dann ist ihr Wert unabhängig von der Wahl der Repräsentanten innerhalb derselben Symmetrieorbitklassen.',
    `statement_latex` = '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_1'',\\;\\mathfrak{O}_2\\sim_S\\mathfrak{O}_2''\\Longrightarrow d_F([\\mathfrak{O}_1],[\\mathfrak{O}_2])=d_F([\\mathfrak{O}_1''],[\\mathfrak{O}_2''])',
    `word_latex` = '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_1'',\\;\\mathfrak{O}_2\\sim_S\\mathfrak{O}_2''\\Longrightarrow d_F([\\mathfrak{O}_1],[\\mathfrak{O}_2])=d_F([\\mathfrak{O}_1''],[\\mathfrak{O}_2''])',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.26, Def. 3.4.27 und Lemma 3.4.11 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_3412_id;

INSERT INTO `lemmas` (
    `lemma_number`,
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
    'Lemma 3.4.12',
    @section_id,
    'Repräsentantenunabhängigkeit der funktionalen Metrik',
    'Ist die funktionale Metrik auf Quotientenklassen definiert, dann ist ihr Wert unabhängig von der Wahl der Repräsentanten innerhalb derselben Symmetrieorbitklassen.',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_1'',\\;\\mathfrak{O}_2\\sim_S\\mathfrak{O}_2''\\Longrightarrow d_F([\\mathfrak{O}_1],[\\mathfrak{O}_2])=d_F([\\mathfrak{O}_1''],[\\mathfrak{O}_2''])',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_1'',\\;\\mathfrak{O}_2\\sim_S\\mathfrak{O}_2''\\Longrightarrow d_F([\\mathfrak{O}_1],[\\mathfrak{O}_2])=d_F([\\mathfrak{O}_1''],[\\mathfrak{O}_2''])',
    'original',
    NULL,
    'Def. 3.4.26, Def. 3.4.27 und Lemma 3.4.11 gelten.',
    'checked',
    @revision_id
WHERE @lemma_3412_id IS NULL;

SET @lemma_3412_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.12'
    LIMIT 1
);

/* 7. Satz 3.4.14 – Funktionaler metrischer Raum. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Funktionaler metrischer Raum',
    `statement_text` = 'Erfüllt d_F auf der funktionalen Quotientenstruktur die vier Metrikaxiome, dann bildet das Paar aus Quotientenstruktur und funktionaler Metrik einen metrischen Raum.',
    `statement_latex` = '\\left(\\mathfrak{Q}_F,d_F\\right)\\text{ ist ein metrischer Raum}',
    `word_latex` = '\\left(\\mathfrak{Q}_F,d_F\\right)\\text{ ist ein metrischer Raum}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.27 und Lemma 3.4.12 gelten; die Metrikaxiome sind erfüllt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_3414_id;

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
    'Satz 3.4.14',
    @section_id,
    'Funktionaler metrischer Raum',
    'Erfüllt d_F auf der funktionalen Quotientenstruktur die vier Metrikaxiome, dann bildet das Paar aus Quotientenstruktur und funktionaler Metrik einen metrischen Raum.',
    '\\left(\\mathfrak{Q}_F,d_F\\right)\\text{ ist ein metrischer Raum}',
    '\\left(\\mathfrak{Q}_F,d_F\\right)\\text{ ist ein metrischer Raum}',
    'original',
    NULL,
    'Def. 3.4.27 und Lemma 3.4.12 gelten; die Metrikaxiome sind erfüllt.',
    'checked',
    @revision_id
WHERE @theorem_3414_id IS NULL;

SET @theorem_3414_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.14'
    LIMIT 1
);

/* 8. Alte Gleichungen und abhängige Einträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='equation' AND `object_id_from` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131')
    ))
    OR
    (`object_type_to`='equation' AND `object_id_to` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131')
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131');

/* 9. Gleichungen neu einfügen. */
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
    '3.126',
    @section_id,
    'Funktionale Metrik',
    'd_F:\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',
    'd_F:\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',
    'Die funktionale Metrik ordnet jedem Paar funktionaler Quotientenklassen einen nichtnegativen reellen Abstand zu.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.27.',
    'Def. 3.4.26 gilt.',
    'checked',
    @revision_id
),
(
    '3.127',
    @section_id,
    'Nichtnegativität',
    'd_F(A,B)\\ge0',
    'd_F(A,B)\\ge0',
    'Funktionale Abstände sind nichtnegativ.',
    'axiom',
    'original',
    NULL,
    'Erstes Metrikaxiom.',
    'A,B\\in\\mathfrak{Q}_F.',
    'checked',
    @revision_id
),
(
    '3.128',
    @section_id,
    'Identität der Ununterscheidbaren',
    'd_F(A,B)=0\\Longleftrightarrow A=B',
    'd_F(A,B)=0\\Longleftrightarrow A=B',
    'Genau identische Quotientenklassen besitzen Abstand null.',
    'axiom',
    'original',
    NULL,
    'Zweites Metrikaxiom.',
    'A,B\\in\\mathfrak{Q}_F.',
    'checked',
    @revision_id
),
(
    '3.129',
    @section_id,
    'Symmetrie der funktionalen Metrik',
    'd_F(A,B)=d_F(B,A)',
    'd_F(A,B)=d_F(B,A)',
    'Der funktionale Abstand ist unabhängig von der Reihenfolge der Quotientenklassen.',
    'axiom',
    'original',
    NULL,
    'Drittes Metrikaxiom.',
    'A,B\\in\\mathfrak{Q}_F.',
    'checked',
    @revision_id
),
(
    '3.130',
    @section_id,
    'Dreiecksungleichung',
    'd_F(A,C)\\le d_F(A,B)+d_F(B,C)',
    'd_F(A,C)\\le d_F(A,B)+d_F(B,C)',
    'Der direkte funktionale Abstand ist höchstens so groß wie der Umweg über eine dritte Quotientenklasse.',
    'axiom',
    'original',
    NULL,
    'Viertes Metrikaxiom.',
    'A,B,C\\in\\mathfrak{Q}_F.',
    'checked',
    @revision_id
),
(
    '3.131',
    @section_id,
    'Funktionaler metrischer Raum',
    '\\left(\\mathfrak{Q}_F,d_F\\right)',
    '\\left(\\mathfrak{Q}_F,d_F\\right)',
    'Die funktionale Quotientenstruktur bildet zusammen mit der funktionalen Metrik einen metrischen Raum.',
    'theorem',
    'original',
    NULL,
    'Formale Kurzbezeichnung von Satz 3.4.14.',
    'Die Gleichungen (3.127) bis (3.130) gelten.',
    'checked',
    @revision_id
);

SET @eq_3126 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.126' LIMIT 1);
SET @eq_3127 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.127' LIMIT 1);
SET @eq_3128 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.128' LIMIT 1);
SET @eq_3129 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.129' LIMIT 1);
SET @eq_3130 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.130' LIMIT 1);
SET @eq_3131 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.131' LIMIT 1);
SET @eq_3122 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.122' LIMIT 1);
SET @eq_3123 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.123' LIMIT 1);
SET @eq_3124 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.124' LIMIT 1);
SET @eq_3125 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.125' LIMIT 1);

/* 10. Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3126,@eq_3127,@eq_3128,@eq_3129,@eq_3130,@eq_3131);

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
(@eq_3126,'d_F','funktionale Metrik','Abstandsfunktion auf der funktionalen Quotientenstruktur.',NULL,'\\mathfrak{Q}_F\\times\\mathfrak{Q}_F\\rightarrow\\mathbb{R}_{\\ge0}',1),
(@eq_3126,'\\mathfrak{Q}_F','funktionale Quotientenstruktur','Menge funktionaler Symmetrieorbitklassen.',NULL,'Quotientenmenge',2),
(@eq_3127,'A','erste Quotientenklasse','Erste funktionale Quotientenklasse.',NULL,'A\\in\\mathfrak{Q}_F',1),
(@eq_3127,'B','zweite Quotientenklasse','Zweite funktionale Quotientenklasse.',NULL,'B\\in\\mathfrak{Q}_F',2),
(@eq_3128,'0','Nullabstand','Kennzeichnet Identität der beiden Quotientenklassen.',NULL,'\\mathbb{R}_{\\ge0}',1),
(@eq_3129,'d_F(A,B)','funktionaler Abstand','Abstand zwischen den Quotientenklassen A und B.',NULL,'\\mathbb{R}_{\\ge0}',1),
(@eq_3130,'C','dritte Quotientenklasse','Zwischenklasse der Dreiecksungleichung.',NULL,'C\\in\\mathfrak{Q}_F',1),
(@eq_3131,'\\left(\\mathfrak{Q}_F,d_F\\right)','funktionaler metrischer Raum','Paar aus Quotientenstruktur und funktionaler Metrik.',NULL,'metrischer Raum',1)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 11. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from`=@def_3427_id)
    OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3412_id)
    OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3414_id)
    OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3126,@eq_3127,@eq_3128,@eq_3129,@eq_3130,@eq_3131));

INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
('definition',@def_3427_id,'definition',@def_3426_id,'depends_on','Die funktionale Metrik wird auf der funktionalen Quotientenstruktur definiert.'),
('lemma',@lemma_3412_id,'definition',@def_3427_id,'depends_on','Die Repräsentantenunabhängigkeit betrifft die funktionale Metrik.'),
('theorem',@theorem_3414_id,'definition',@def_3427_id,'depends_on','Der metrische Raum setzt die funktionale Metrik voraus.'),
('theorem',@theorem_3414_id,'lemma',@lemma_3412_id,'depends_on','Die Metrik muss auf Quotientenklassen wohldefiniert sein.'),
('equation',@eq_3126,'definition',@def_3427_id,'derives_from','Gleichung (3.126) formalisiert Def. 3.4.27.'),
('equation',@eq_3131,'theorem',@theorem_3414_id,'derives_from','Gleichung (3.131) formalisiert Satz 3.4.14.');

/* 12. Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3126,@eq_3127,@eq_3128,@eq_3129,@eq_3130,@eq_3131);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(@eq_3126,@eq_3122,'depends_on','Die funktionale Metrik wird auf der Quotientenstruktur aus Gleichung (3.122) definiert.'),
(@eq_3126,@eq_3125,'depends_on','Die Wohldefiniertheit der Quotientenklassen wird durch Gleichung (3.125) gesichert.'),
(@eq_3127,@eq_3126,'derives_from','Nichtnegativität ist ein Metrikaxiom von d_F.'),
(@eq_3128,@eq_3126,'derives_from','Identität der Ununterscheidbaren ist ein Metrikaxiom von d_F.'),
(@eq_3129,@eq_3126,'derives_from','Symmetrie ist ein Metrikaxiom von d_F.'),
(@eq_3130,@eq_3126,'derives_from','Die Dreiecksungleichung ist ein Metrikaxiom von d_F.'),
(@eq_3131,@eq_3126,'depends_on','Der metrische Raum verwendet die funktionale Metrik.'),
(@eq_3131,@eq_3127,'depends_on','Der metrische Raum setzt Nichtnegativität voraus.'),
(@eq_3131,@eq_3128,'depends_on','Der metrische Raum setzt Identität der Ununterscheidbaren voraus.'),
(@eq_3131,@eq_3129,'depends_on','Der metrische Raum setzt Symmetrie voraus.'),
(@eq_3131,@eq_3130,'depends_on','Der metrische Raum setzt die Dreiecksungleichung voraus.');

/* 13. Änderungsprotokoll. */
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
    @revision_id,@section_id,'rewritten','section','3.4.14',
    'Abschnitt 3.4.14 wurde vollständig als funktionale Metrik auf der Quotientenstruktur neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.14.',
    'Def. 3.4.27, Lemma 3.4.12, Satz 3.4.14 und Gleichungen (3.126) bis (3.131).'
),
(
    @revision_id,@section_id,'definition_added','definition','Def. 3.4.27',
    'Die funktionale Metrik wurde registriert.',
    NULL,
    '1 Definition'
),
(
    @revision_id,@section_id,'statement_added','lemma','Lemma 3.4.12',
    'Die Repräsentantenunabhängigkeit der funktionalen Metrik wurde registriert.',
    NULL,
    'Repräsentantenunabhängigkeit'
),
(
    @revision_id,@section_id,'statement_added','theorem','Satz 3.4.14',
    'Der funktionale metrische Raum wurde registriert.',
    NULL,
    'Metrischer Raum auf der Quotientenstruktur'
),
(
    @revision_id,@section_id,'equation_added','equation','(3.126)–(3.131)',
    'Funktionale Metrik, vier Metrikaxiome und funktionaler metrischer Raum wurden formal registriert.',
    NULL,
    '6 Gleichungen'
);

/* 14. Repository-Zähler. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
('next_equation_number','3.132'),
('next_definition_number','Def. 3.4.28'),
('next_lemma_number','Lemma 3.4.13'),
('next_theorem_number','Satz 3.4.15'),
('last_edited_section','3.4.14'),
('last_repository_revision','RKB-2026-07-13-K3.4.14-NEUFASSUNG-V1')
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
WHERE ds.`section_code` IN ('3.4','3.4.14')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` = 'Def. 3.4.27';

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number` = 'Lemma 3.4.12';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.14';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.126','3.127','3.128','3.129','3.130','3.131')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_14`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_equation_number',
    'next_definition_number',
    'next_lemma_number',
    'next_theorem_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
