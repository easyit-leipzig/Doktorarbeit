USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.12
   Gruppenstruktur funktionaler Symmetrien

   Definitionen:
   - Def. 3.4.23 Identische funktionale Symmetrie
   - Def. 3.4.24 Inverse funktionale Symmetrie

   Lemma:
   - Lemma 3.4.10 Inversenerhaltung funktionaler Erhaltungsgesetze

   Satz:
   - Satz 3.4.12 Gruppe funktionaler Symmetrien

   Gleichungen:
   - (3.114) Identische funktionale Symmetrie
   - (3.115) Neutralität der identischen Symmetrie
   - (3.116) Inverse funktionale Symmetrie
   - (3.117) Erhaltung durch inverse Symmetrien
   - (3.118) Gruppe funktionaler Symmetrien
   - (3.119) Gruppenaxiome funktionaler Symmetrien

   Neue Quellen: keine

   Nächste Gleichung:   (3.120)
   Nächste Definition:  Def. 3.4.25
   Nächstes Lemma:      Lemma 3.4.11
   Nächster Satz:       Satz 3.4.13
   ============================================================ */

/* 1. Parent-Revision separat ermitteln, um MySQL #1093 zu vermeiden. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

/* 2. Revision anlegen oder wiederverwenden. */
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
    'RKB-2026-07-13-K3.4.12-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.12',
    '1.0',
    'Neufassung von Abschnitt 3.4.12 mit Def. 3.4.23, Def. 3.4.24, Lemma 3.4.10, Satz 3.4.12 und den Gleichungen (3.114) bis (3.119).',
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
    '3.4.12',
    'Gruppenstruktur funktionaler Symmetrien',
    3,
    3.5930,
    'review',
    1,
    'Rekonstruktion der Gruppenstruktur funktionaler Symmetrien aus Identität, Inversen, Komposition und Assoziativität.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code` = '3.4.12'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.12'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Gruppenstruktur funktionaler Symmetrien',
    `chapter_no` = 3,
    `section_order` = 3.5930,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.23, Def. 3.4.24, Lemma 3.4.10, Satz 3.4.12 und die Gleichungen (3.114) bis (3.119).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1
WHERE `section_id` = @chapter_id;

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Vorgänger- und Zielobjekte ermitteln. */
SET @def_3421_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.21'
    LIMIT 1
);

SET @def_3422_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.22'
    LIMIT 1
);

SET @def_3423_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.23'
    LIMIT 1
);

SET @def_3424_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.24'
    LIMIT 1
);

SET @lemma_3410_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.10'
    LIMIT 1
);

SET @theorem_3412_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.12'
    LIMIT 1
);

/* 5. Def. 3.4.23 – Identische funktionale Symmetrie. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Identische funktionale Symmetrie',
    `definition_text` = 'Die identische funktionale Symmetrie ist die Transformation, die jeden funktionalen Organisationsraum auf sich selbst abbildet.',
    `formal_latex` = '\\operatorname{id}_F(\\mathfrak{O})=\\mathfrak{O}',
    `word_latex` = '\\operatorname{id}_F(\\mathfrak{O})=\\mathfrak{O}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.21 und Def. 3.4.22 gelten.',
    `notes` = 'Die identische funktionale Symmetrie ist das neutrale Element der Komposition.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3423_id;

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
    'Def. 3.4.23',
    @section_id,
    'Identische funktionale Symmetrie',
    'Die identische funktionale Symmetrie ist die Transformation, die jeden funktionalen Organisationsraum auf sich selbst abbildet.',
    '\\operatorname{id}_F(\\mathfrak{O})=\\mathfrak{O}',
    '\\operatorname{id}_F(\\mathfrak{O})=\\mathfrak{O}',
    'original',
    NULL,
    'Def. 3.4.21 und Def. 3.4.22 gelten.',
    'Die identische funktionale Symmetrie ist das neutrale Element der Komposition.',
    'checked',
    @revision_id
WHERE @def_3423_id IS NULL;

SET @def_3423_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.23'
    LIMIT 1
);

/* 6. Def. 3.4.24 – Inverse funktionale Symmetrie. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Inverse funktionale Symmetrie',
    `definition_text` = 'Zu einer funktionalen Symmetrie heißt eine funktionale Transformation inverse funktionale Symmetrie, wenn beide Kompositionsrichtungen die identische funktionale Symmetrie ergeben.',
    `formal_latex` = '\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F',
    `word_latex` = '\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.21 bis Def. 3.4.23 gelten; S_F ist bijektiv.',
    `notes` = 'Nicht jede funktionale Transformation ist invertierbar. Die Definition gilt nur für reversible Symmetrien.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3424_id;

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
    'Def. 3.4.24',
    @section_id,
    'Inverse funktionale Symmetrie',
    'Zu einer funktionalen Symmetrie heißt eine funktionale Transformation inverse funktionale Symmetrie, wenn beide Kompositionsrichtungen die identische funktionale Symmetrie ergeben.',
    '\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F',
    '\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F',
    'original',
    NULL,
    'Def. 3.4.21 bis Def. 3.4.23 gelten; S_F ist bijektiv.',
    'Nicht jede funktionale Transformation ist invertierbar. Die Definition gilt nur für reversible Symmetrien.',
    'checked',
    @revision_id
WHERE @def_3424_id IS NULL;

SET @def_3424_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.24'
    LIMIT 1
);

/* 7. Lemma 3.4.10. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Inversenerhaltung funktionaler Erhaltungsgesetze',
    `statement_text` = 'Ist eine funktionale Symmetrie bijektiv und existiert ihre inverse Transformation, dann erhält auch die inverse Transformation jedes funktionale Erhaltungsgesetz.',
    `statement_latex` = '\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F^{-1}=I_F',
    `word_latex` = '\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F^{-1}=I_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.21, Def. 3.4.22 und Def. 3.4.24 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_3410_id;

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
    'Lemma 3.4.10',
    @section_id,
    'Inversenerhaltung funktionaler Erhaltungsgesetze',
    'Ist eine funktionale Symmetrie bijektiv und existiert ihre inverse Transformation, dann erhält auch die inverse Transformation jedes funktionale Erhaltungsgesetz.',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F^{-1}=I_F',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F^{-1}=I_F',
    'original',
    NULL,
    'Def. 3.4.21, Def. 3.4.22 und Def. 3.4.24 gelten.',
    'checked',
    @revision_id
WHERE @lemma_3410_id IS NULL;

SET @lemma_3410_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.10'
    LIMIT 1
);

/* 8. Satz 3.4.12. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Gruppe funktionaler Symmetrien',
    `statement_text` = 'Ist die Klasse funktionaler Symmetrien nichtleer, unter Komposition abgeschlossen und assoziativ, enthält sie die identische funktionale Symmetrie und zu jedem Element eine inverse funktionale Symmetrie, dann bildet sie mit der Komposition eine Gruppe.',
    `statement_latex` = '\\left(\\mathfrak{S}_F,\\circ\\right)\\text{ ist eine Gruppe}',
    `word_latex` = '\\left(\\mathfrak{S}_F,\\circ\\right)\\text{ ist eine Gruppe}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.22 bis Def. 3.4.24 und Lemma 3.4.9 sowie Lemma 3.4.10 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_3412_id;

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
    'Satz 3.4.12',
    @section_id,
    'Gruppe funktionaler Symmetrien',
    'Ist die Klasse funktionaler Symmetrien nichtleer, unter Komposition abgeschlossen und assoziativ, enthält sie die identische funktionale Symmetrie und zu jedem Element eine inverse funktionale Symmetrie, dann bildet sie mit der Komposition eine Gruppe.',
    '\\left(\\mathfrak{S}_F,\\circ\\right)\\text{ ist eine Gruppe}',
    '\\left(\\mathfrak{S}_F,\\circ\\right)\\text{ ist eine Gruppe}',
    'original',
    NULL,
    'Def. 3.4.22 bis Def. 3.4.24 und Lemma 3.4.9 sowie Lemma 3.4.10 gelten.',
    'checked',
    @revision_id
WHERE @theorem_3412_id IS NULL;

SET @theorem_3412_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.12'
    LIMIT 1
);

/* 9. Alte Gleichungen und abhängige Einträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='equation' AND `object_id_from` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119')
    ))
    OR
    (`object_type_to`='equation' AND `object_id_to` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119')
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119');

/* 10. Gleichungen neu einfügen. */
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
    '3.114',
    @section_id,
    'Identische funktionale Symmetrie',
    '\\operatorname{id}_F(\\mathfrak{O})=\\mathfrak{O}',
    '\\operatorname{id}_F(\\mathfrak{O})=\\mathfrak{O}',
    'Die identische funktionale Symmetrie bildet jeden funktionalen Organisationsraum auf sich selbst ab.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.23.',
    'Def. 3.4.21 und Def. 3.4.22 gelten.',
    'checked',
    @revision_id
),
(
    '3.115',
    @section_id,
    'Neutralität der identischen Symmetrie',
    '\\operatorname{id}_F\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\operatorname{id}_F=\\mathcal{S}_F',
    '\\operatorname{id}_F\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\operatorname{id}_F=\\mathcal{S}_F',
    'Die identische funktionale Symmetrie ist neutrales Element der Komposition.',
    'definition',
    'original',
    NULL,
    'Folgerung aus Def. 3.4.23.',
    'Def. 3.4.23 gilt.',
    'checked',
    @revision_id
),
(
    '3.116',
    @section_id,
    'Inverse funktionale Symmetrie',
    '\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F',
    '\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F',
    'Die inverse funktionale Symmetrie macht die Wirkung der ursprünglichen Symmetrie rückgängig.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.24.',
    'Def. 3.4.23 gilt; S_F ist bijektiv.',
    'checked',
    @revision_id
),
(
    '3.117',
    @section_id,
    'Erhaltung durch inverse Symmetrien',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F^{-1}=I_F',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F^{-1}=I_F',
    'Auch die inverse funktionale Symmetrie erhält jedes funktionale Erhaltungsgesetz.',
    'lemma',
    'original',
    NULL,
    'Formale Darstellung von Lemma 3.4.10.',
    'Def. 3.4.24 gilt.',
    'checked',
    @revision_id
),
(
    '3.118',
    @section_id,
    'Gruppe funktionaler Symmetrien',
    '\\left(\\mathfrak{S}_F,\\circ\\right)',
    '\\left(\\mathfrak{S}_F,\\circ\\right)',
    'Die Klasse funktionaler Symmetrien bildet zusammen mit der Komposition die betrachtete algebraische Struktur.',
    'theorem',
    'original',
    NULL,
    'Formale Kurzbezeichnung von Satz 3.4.12.',
    'Die Gruppenaxiome sind erfüllt.',
    'checked',
    @revision_id
),
(
    '3.119',
    @section_id,
    'Gruppenaxiome funktionaler Symmetrien',
    '\\begin{aligned}\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F&\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F,\\\\\\left(\\mathcal{S}_{F,3}\\circ\\mathcal{S}_{F,2}\\right)\\circ\\mathcal{S}_{F,1}&=\\mathcal{S}_{F,3}\\circ\\left(\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\right),\\\\\\operatorname{id}_F\\circ\\mathcal{S}_F&=\\mathcal{S}_F\\circ\\operatorname{id}_F=\\mathcal{S}_F,\\\\\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F&=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F\\end{aligned}',
    '\\begin{aligned}\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F&\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F,\\\\\\left(\\mathcal{S}_{F,3}\\circ\\mathcal{S}_{F,2}\\right)\\circ\\mathcal{S}_{F,1}&=\\mathcal{S}_{F,3}\\circ\\left(\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\right),\\\\\\operatorname{id}_F\\circ\\mathcal{S}_F&=\\mathcal{S}_F\\circ\\operatorname{id}_F=\\mathcal{S}_F,\\\\\\mathcal{S}_F^{-1}\\circ\\mathcal{S}_F&=\\mathcal{S}_F\\circ\\mathcal{S}_F^{-1}=\\operatorname{id}_F\\end{aligned}',
    'Die funktionalen Symmetrien erfüllen Abschluss, Assoziativität, Identität und Invertierbarkeit.',
    'theorem',
    'original',
    NULL,
    'Ausführliche formale Darstellung von Satz 3.4.12.',
    'Def. 3.4.22 bis Def. 3.4.24 und Lemma 3.4.9 bis Lemma 3.4.10 gelten.',
    'checked',
    @revision_id
);

SET @eq_3114 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.114' LIMIT 1);
SET @eq_3115 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.115' LIMIT 1);
SET @eq_3116 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.116' LIMIT 1);
SET @eq_3117 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.117' LIMIT 1);
SET @eq_3118 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.118' LIMIT 1);
SET @eq_3119 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.119' LIMIT 1);
SET @eq_3111 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.111' LIMIT 1);
SET @eq_3112 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.112' LIMIT 1);
SET @eq_3113 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.113' LIMIT 1);

/* 11. Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3114,@eq_3115,@eq_3116,@eq_3117,@eq_3118,@eq_3119);

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
(@eq_3114,'\\operatorname{id}_F','identische funktionale Symmetrie','Neutrale Transformation auf funktionalen Organisationsräumen.',NULL,'Abbildung',1),
(@eq_3114,'\\mathfrak{O}','funktionaler Organisationsraum','Beliebiger funktionaler Organisationsraum.',NULL,'Organisationsraum',2),
(@eq_3115,'\\mathcal{S}_F','funktionale Symmetrie','Beliebige funktionale Symmetrie.',NULL,'Symmetrie',1),
(@eq_3115,'\\circ','Kompositionsoperator','Hintereinanderausführung funktionaler Symmetrien.',NULL,'Abbildungsoperator',2),
(@eq_3116,'\\mathcal{S}_F^{-1}','inverse funktionale Symmetrie','Inverse der funktionalen Symmetrie S_F.',NULL,'inverse Abbildung',1),
(@eq_3116,'\\operatorname{id}_F','identische funktionale Symmetrie','Neutrales Element der Komposition.',NULL,'Abbildung',2),
(@eq_3117,'\\mathcal{E}_F','Klasse funktionaler Erhaltungsgesetze','Gesamtheit der funktionalen Erhaltungsgesetze.',NULL,'Menge',1),
(@eq_3117,'I_F','funktionales Erhaltungsgesetz','Beliebiges Element aus E_F.',NULL,'I_F\\in\\mathcal{E}_F',2),
(@eq_3118,'\\mathfrak{S}_F','Symmetrieklasse','Klasse funktionaler Symmetrien.',NULL,'Menge',1),
(@eq_3118,'\\circ','Gruppenoperation','Komposition funktionaler Symmetrien.',NULL,'Operation',2),
(@eq_3119,'\\mathcal{S}_{F,i}','i-te funktionale Symmetrie','Beliebiges Element der Symmetrieklasse.',NULL,'\\mathfrak{S}_F',1)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* 12. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from` IN (@def_3423_id,@def_3424_id))
    OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3410_id)
    OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3412_id)
    OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3114,@eq_3115,@eq_3116,@eq_3117,@eq_3118,@eq_3119));

INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
('definition',@def_3423_id,'definition',@def_3421_id,'depends_on','Die identische funktionale Symmetrie ist ein Spezialfall der funktionalen Symmetrie.'),
('definition',@def_3423_id,'definition',@def_3422_id,'depends_on','Die Identität gehört zur Klasse funktionaler Symmetrien.'),
('definition',@def_3424_id,'definition',@def_3423_id,'depends_on','Die inverse Symmetrie wird über die identische Symmetrie definiert.'),
('definition',@def_3424_id,'definition',@def_3421_id,'depends_on','Die inverse Abbildung bezieht sich auf eine funktionale Symmetrie.'),
('lemma',@lemma_3410_id,'definition',@def_3424_id,'derives_from','Die Inversenerhaltung folgt aus der Invertierbarkeit der Symmetrie.'),
('theorem',@theorem_3412_id,'definition',@def_3422_id,'depends_on','Der Gruppensatz verwendet die Klasse funktionaler Symmetrien.'),
('theorem',@theorem_3412_id,'definition',@def_3423_id,'depends_on','Der Gruppensatz setzt ein neutrales Element voraus.'),
('theorem',@theorem_3412_id,'definition',@def_3424_id,'depends_on','Der Gruppensatz setzt inverse Elemente voraus.'),
('theorem',@theorem_3412_id,'lemma',@lemma_3410_id,'depends_on','Die inverse Symmetrie bleibt innerhalb der Erhaltungsklasse.'),
('equation',@eq_3114,'definition',@def_3423_id,'derives_from','Gleichung (3.114) formalisiert Def. 3.4.23.'),
('equation',@eq_3115,'definition',@def_3423_id,'derives_from','Gleichung (3.115) beschreibt die Neutralität der Identität.'),
('equation',@eq_3116,'definition',@def_3424_id,'derives_from','Gleichung (3.116) formalisiert Def. 3.4.24.'),
('equation',@eq_3117,'lemma',@lemma_3410_id,'derives_from','Gleichung (3.117) formalisiert Lemma 3.4.10.'),
('equation',@eq_3118,'theorem',@theorem_3412_id,'derives_from','Gleichung (3.118) bezeichnet die Gruppenstruktur.'),
('equation',@eq_3119,'theorem',@theorem_3412_id,'derives_from','Gleichung (3.119) formalisiert die Gruppenaxiome.');

/* 13. Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3114,@eq_3115,@eq_3116,@eq_3117,@eq_3118,@eq_3119);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(@eq_3114,@eq_3111,'depends_on','Die identische Symmetrie ist Element der in Gleichung (3.111) definierten Symmetrieklasse.'),
(@eq_3115,@eq_3114,'derives_from','Die Neutralität folgt aus der Definition der identischen Symmetrie.'),
(@eq_3116,@eq_3114,'depends_on','Die inverse Symmetrie wird über die Identität definiert.'),
(@eq_3116,@eq_3112,'depends_on','Die Inversenbedingung ergänzt den Kompositionsabschluss aus Gleichung (3.112).'),
(@eq_3117,@eq_3113,'depends_on','Die Erhaltung durch inverse Symmetrien baut auf der allgemeinen Symmetrieerhaltung auf.'),
(@eq_3117,@eq_3116,'derives_from','Die Inversenerhaltung folgt aus der Inversenbeziehung.'),
(@eq_3118,@eq_3111,'depends_on','Die Gruppe verwendet die Klasse funktionaler Symmetrien.'),
(@eq_3118,@eq_3112,'depends_on','Die Gruppe setzt Abschluss unter Komposition voraus.'),
(@eq_3119,@eq_3115,'depends_on','Die Gruppenaxiome enthalten das neutrale Element.'),
(@eq_3119,@eq_3116,'depends_on','Die Gruppenaxiome enthalten inverse Elemente.'),
(@eq_3119,@eq_3118,'derives_from','Die Gruppenaxiome entfalten die in Gleichung (3.118) bezeichnete Gruppenstruktur.');

/* 14. Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

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
    @revision_id,@section_id,'rewritten','section','3.4.12',
    'Abschnitt 3.4.12 wurde vollständig als Gruppenstruktur funktionaler Symmetrien neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.12.',
    'Def. 3.4.23, Def. 3.4.24, Lemma 3.4.10, Satz 3.4.12 und Gleichungen (3.114) bis (3.119).'
),
(
    @revision_id,@section_id,'definition_added','definition','Def. 3.4.23–Def. 3.4.24',
    'Identische und inverse funktionale Symmetrie wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,@section_id,'statement_added','lemma','Lemma 3.4.10',
    'Die Erhaltung funktionaler Erhaltungsgesetze unter inversen Symmetrien wurde registriert.',
    NULL,
    'Inversenerhaltung'
),
(
    @revision_id,@section_id,'statement_added','theorem','Satz 3.4.12',
    'Die Gruppenstruktur funktionaler Symmetrien wurde registriert.',
    'Symmetrieklasse ohne vollständigen Gruppennachweis.',
    'Gruppenstruktur unter Abschluss, Assoziativität, Identität und Invertierbarkeit.'
),
(
    @revision_id,@section_id,'equation_added','equation','(3.114)–(3.119)',
    'Identität, Neutralität, Inverse, Inversenerhaltung, Gruppenstruktur und Gruppenaxiome wurden formal registriert.',
    NULL,
    '6 Gleichungen'
);

/* 15. Repository-Zähler. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
('next_equation_number','3.120'),
('next_definition_number','Def. 3.4.25'),
('next_lemma_number','Lemma 3.4.11'),
('next_theorem_number','Satz 3.4.13'),
('last_edited_section','3.4.12'),
('last_repository_revision','RKB-2026-07-13-K3.4.12-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

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
WHERE ds.`section_code` IN ('3.4','3.4.12')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.23','Def. 3.4.24')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number`='Lemma 3.4.10';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`assumptions`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number`='Satz 3.4.12';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.114','3.115','3.116','3.117','3.118','3.119')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT COUNT(*) AS `source_usages_in_3_4_12`
FROM `source_usage`
WHERE `section_id`=@section_id;

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
