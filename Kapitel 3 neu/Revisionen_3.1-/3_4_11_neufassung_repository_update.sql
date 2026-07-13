USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.11
   Mathematische Rekonstruktion funktionaler Symmetrien

   Definitionen:
   - Def. 3.4.21 Funktionale Symmetrie
   - Def. 3.4.22 Klasse funktionaler Symmetrien

   Lemma:
   - Lemma 3.4.9 Abschluss funktionaler Symmetrien

   Satz:
   - Satz 3.4.11 Erhaltungsgesetze unter funktionalen Symmetrien

   Gleichungen:
   - (3.110) Funktionale Symmetrie
   - (3.111) Klasse funktionaler Symmetrien
   - (3.112) Abschluss unter Komposition
   - (3.113) Erhaltungsgesetze unter Symmetrien

   Neue Quellen: keine

   Nächste Gleichung:  (3.114)
   Nächste Definition: Def. 3.4.23
   Nächstes Lemma:     Lemma 3.4.10
   Nächster Satz:      Satz 3.4.12

   Präzisierung:
   Ohne Nachweis von neutralem Element und inversen Elementen wird
   nicht von einer Gruppe, sondern zunächst von einer unter
   Komposition abgeschlossenen Klasse funktionaler Symmetrien
   gesprochen. Ebenso folgt aus der bloßen Existenz einer Symmetrie
   nicht die Existenz einer nichttrivialen Erhaltungsgröße. Der Satz
   formuliert daher korrekt die Erhaltung bereits definierter
   Elemente von E_F unter funktionalen Symmetrien.
   ============================================================ */

/* 1. Parent-Revision separat ermitteln, um MySQL #1093 zu vermeiden. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

/* 2. Revision idempotent anlegen oder wiederverwenden. */
INSERT INTO `repository_revisions` (
    `revision_code`,`revision_date`,`scope_type`,`scope_reference`,
    `version_label`,`summary`,`created_by`,`parent_revision_id`
)
VALUES (
    'RKB-2026-07-13-K3.4.11-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.11',
    '1.0',
    'Neufassung von Abschnitt 3.4.11 mit Def. 3.4.21, Def. 3.4.22, Lemma 3.4.9, Satz 3.4.11 und den Gleichungen (3.110) bis (3.113).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id`=LAST_INSERT_ID(`revision_id`),
    `revision_date`=VALUES(`revision_date`),
    `version_label`=VALUES(`version_label`),
    `summary`=VALUES(`summary`),
    `created_by`=VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* 3. Kapitel und Abschnitt ermitteln; Abschnitt bei Bedarf anlegen. */
SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code`='3.4'
    LIMIT 1
);

INSERT INTO `dissertation_sections` (
    `parent_section_id`,`section_code`,`title`,`chapter_no`,
    `section_order`,`status`,`is_original_contribution`,`notes`
)
SELECT
    @chapter_id,
    '3.4.11',
    'Mathematische Rekonstruktion funktionaler Symmetrien',
    3,
    3.5920,
    'review',
    1,
    'Rekonstruktion funktionaler Symmetrien als erhaltungsgesetzerhaltende Transformationen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code`='3.4.11'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code`='3.4.11'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Mathematische Rekonstruktion funktionaler Symmetrien',
    `chapter_no`=3,
    `section_order`=3.5920,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.21, Def. 3.4.22, Lemma 3.4.9, Satz 3.4.11 und die Gleichungen (3.110) bis (3.113).'
WHERE `section_id`=@section_id;

UPDATE `dissertation_sections`
SET `status`='review',`is_original_contribution`=1
WHERE `section_id`=@chapter_id;

DELETE FROM `source_usage`
WHERE `section_id`=@section_id;

/* 4. Vorgänger- und Zielobjekte ermitteln. */
SET @def_3419_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number`='Def. 3.4.19'
    LIMIT 1
);

SET @def_3420_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number`='Def. 3.4.20'
    LIMIT 1
);

SET @def_3421_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number`='Def. 3.4.21'
    LIMIT 1
);

SET @def_3422_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number`='Def. 3.4.22'
    LIMIT 1
);

SET @lemma_349_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.9'
    LIMIT 1
);

SET @theorem_3411_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.11'
    LIMIT 1
);

/* 5. Def. 3.4.21 – Funktionale Symmetrie. */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Symmetrie',
    `definition_text`='Eine zulässige funktionale Transformation heißt funktionale Symmetrie bezüglich der Klasse funktionaler Erhaltungsgesetze, wenn sie den Wert jedes Elements dieser Klasse erhält.',
    `formal_latex`='\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)',
    `word_latex`='\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.19 und Def. 3.4.20 gelten; S_F ist eine zulässige funktionale Transformation.',
    `notes`='Die Symmetrie ist funktional und setzt keine geometrische Raumstruktur voraus.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3421_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.21',
    @section_id,
    'Funktionale Symmetrie',
    'Eine zulässige funktionale Transformation heißt funktionale Symmetrie bezüglich der Klasse funktionaler Erhaltungsgesetze, wenn sie den Wert jedes Elements dieser Klasse erhält.',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)',
    'original',
    NULL,
    'Def. 3.4.19 und Def. 3.4.20 gelten; S_F ist eine zulässige funktionale Transformation.',
    'Die Symmetrie ist funktional und setzt keine geometrische Raumstruktur voraus.',
    'checked',
    @revision_id
WHERE @def_3421_id IS NULL;

SET @def_3421_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number`='Def. 3.4.21'
    LIMIT 1
);

/* 6. Def. 3.4.22 – Klasse funktionaler Symmetrien. */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Klasse funktionaler Symmetrien',
    `definition_text`='Die Klasse funktionaler Symmetrien umfasst alle zulässigen funktionalen Transformationen, die sämtliche funktionalen Erhaltungsgesetze erhalten.',
    `formal_latex`='\\mathfrak{S}_F=\\left\\{\\mathcal{S}_F\\mid\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)\\right\\}',
    `word_latex`='\\mathfrak{S}_F=\\left\\{\\mathcal{S}_F\\mid\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)\\right\\}',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.21 gilt.',
    `notes`='Eine Gruppenstruktur wird erst nach zusätzlichem Nachweis von Identität und Inversen behauptet.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3422_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.22',
    @section_id,
    'Klasse funktionaler Symmetrien',
    'Die Klasse funktionaler Symmetrien umfasst alle zulässigen funktionalen Transformationen, die sämtliche funktionalen Erhaltungsgesetze erhalten.',
    '\\mathfrak{S}_F=\\left\\{\\mathcal{S}_F\\mid\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)\\right\\}',
    '\\mathfrak{S}_F=\\left\\{\\mathcal{S}_F\\mid\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)\\right\\}',
    'original',
    NULL,
    'Def. 3.4.21 gilt.',
    'Eine Gruppenstruktur wird erst nach zusätzlichem Nachweis von Identität und Inversen behauptet.',
    'checked',
    @revision_id
WHERE @def_3422_id IS NULL;

SET @def_3422_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number`='Def. 3.4.22'
    LIMIT 1
);

/* 7. Lemma 3.4.9 – Abschluss unter Komposition. */
UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Abschluss funktionaler Symmetrien unter Komposition',
    `statement_text`='Sind zwei funktionale Symmetrien bezüglich derselben Klasse funktionaler Erhaltungsgesetze gegeben, dann ist auch ihre wohldefinierte Komposition eine funktionale Symmetrie.',
    `statement_latex`='\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F',
    `word_latex`='\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.21 und Def. 3.4.22 gelten; die Komposition ist wohldefiniert.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_349_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.9',
    @section_id,
    'Abschluss funktionaler Symmetrien unter Komposition',
    'Sind zwei funktionale Symmetrien bezüglich derselben Klasse funktionaler Erhaltungsgesetze gegeben, dann ist auch ihre wohldefinierte Komposition eine funktionale Symmetrie.',
    '\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F',
    '\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F',
    'original',
    NULL,
    'Def. 3.4.21 und Def. 3.4.22 gelten; die Komposition ist wohldefiniert.',
    'checked',
    @revision_id
WHERE @lemma_349_id IS NULL;

SET @lemma_349_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.9'
    LIMIT 1
);

/* 8. Satz 3.4.11 – logisch präzisierte Erhaltungsaussage. */
UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Erhaltungsgesetze unter funktionalen Symmetrien',
    `statement_text`='Für jede funktionale Symmetrie und jedes bereits definierte funktionale Erhaltungsgesetz bleibt der zugehörige Invariantenwert unter der Symmetrietransformation erhalten.',
    `statement_latex`='\\mathcal{S}_F\\in\\mathfrak{S}_F\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F=I_F',
    `word_latex`='\\mathcal{S}_F\\in\\mathfrak{S}_F\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F=I_F',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.20 bis Def. 3.4.22 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3411_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.11',
    @section_id,
    'Erhaltungsgesetze unter funktionalen Symmetrien',
    'Für jede funktionale Symmetrie und jedes bereits definierte funktionale Erhaltungsgesetz bleibt der zugehörige Invariantenwert unter der Symmetrietransformation erhalten.',
    '\\mathcal{S}_F\\in\\mathfrak{S}_F\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F=I_F',
    '\\mathcal{S}_F\\in\\mathfrak{S}_F\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F=I_F',
    'original',
    NULL,
    'Def. 3.4.20 bis Def. 3.4.22 gelten.',
    'checked',
    @revision_id
WHERE @theorem_3411_id IS NULL;

SET @theorem_3411_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.11'
    LIMIT 1
);

/* 9. Alte Gleichungsbelegungen und abhängige Einträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='equation' AND `object_id_from` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.110','3.111','3.112','3.113')
    ))
    OR
    (`object_type_to`='equation' AND `object_id_to` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.110','3.111','3.112','3.113')
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.110','3.111','3.112','3.113');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.110','3.111','3.112','3.113');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.110','3.111','3.112','3.113');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.110','3.111','3.112','3.113');

/* 10. Gleichungen neu einfügen. */
INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.110',
    @section_id,
    'Funktionale Symmetrie',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)',
    '\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)',
    'Eine funktionale Symmetrie erhält jedes funktionale Erhaltungsgesetz.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.21.',
    'Def. 3.4.20 gilt; S_F ist zulässig.',
    'checked',
    @revision_id
),
(
    '3.111',
    @section_id,
    'Klasse funktionaler Symmetrien',
    '\\mathfrak{S}_F=\\left\\{\\mathcal{S}_F\\mid\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)\\right\\}',
    '\\mathfrak{S}_F=\\left\\{\\mathcal{S}_F\\mid\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{S}_F(\\mathfrak{O})\\right)\\right\\}',
    'Die Klasse funktionaler Symmetrien enthält alle erhaltungsgesetzerhaltenden Transformationen.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.22.',
    'Def. 3.4.21 gilt.',
    'checked',
    @revision_id
),
(
    '3.112',
    @section_id,
    'Abschluss funktionaler Symmetrien unter Komposition',
    '\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F',
    '\\mathcal{S}_{F,1},\\mathcal{S}_{F,2}\\in\\mathfrak{S}_F\\Longrightarrow\\mathcal{S}_{F,2}\\circ\\mathcal{S}_{F,1}\\in\\mathfrak{S}_F',
    'Die wohldefinierte Komposition zweier funktionaler Symmetrien ist wieder eine funktionale Symmetrie.',
    'lemma',
    'original',
    NULL,
    'Formale Darstellung von Lemma 3.4.9.',
    'Def. 3.4.21 und Def. 3.4.22 gelten.',
    'checked',
    @revision_id
),
(
    '3.113',
    @section_id,
    'Erhaltungsgesetze unter funktionalen Symmetrien',
    '\\mathcal{S}_F\\in\\mathfrak{S}_F\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F=I_F',
    '\\mathcal{S}_F\\in\\mathfrak{S}_F\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F\\circ\\mathcal{S}_F=I_F',
    'Jede funktionale Symmetrie erhält jedes bereits definierte funktionale Erhaltungsgesetz.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.11.',
    'Def. 3.4.20 bis Def. 3.4.22 gelten.',
    'checked',
    @revision_id
);

SET @eq_3110 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.110'
    LIMIT 1
);

SET @eq_3111 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.111'
    LIMIT 1
);

SET @eq_3112 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.112'
    LIMIT 1
);

SET @eq_3113 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.113'
    LIMIT 1
);

SET @eq_3106 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.106'
    LIMIT 1
);

SET @eq_3107 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.107'
    LIMIT 1
);

SET @eq_3108 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number`='3.108'
    LIMIT 1
);

/* 11. Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3110,@eq_3111,@eq_3112,@eq_3113);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3110,'\\mathcal{S}_F','funktionale Symmetrie','Zulässige Transformation, die alle Elemente von E_F erhält.',NULL,'funktionale Transformation',1),
(@eq_3110,'\\mathcal{E}_F','Klasse funktionaler Erhaltungsgesetze','In Def. 3.4.20 definierte Klasse erhaltener Invarianten.',NULL,'Menge',2),
(@eq_3110,'I_F','funktionales Erhaltungsgesetz','Ein Element der Klasse funktionaler Erhaltungsgesetze.',NULL,'I_F\\in\\mathcal{E}_F',3),
(@eq_3111,'\\mathfrak{S}_F','Klasse funktionaler Symmetrien','Gesamtheit aller erhaltungsgesetzerhaltenden Transformationen.',NULL,'Transformationsklasse',1),
(@eq_3111,'\\mathcal{S}_F','Element der Symmetrieklasse','Eine funktionale Symmetrie.',NULL,'\\mathcal{S}_F\\in\\mathfrak{S}_F',2),
(@eq_3112,'\\mathcal{S}_{F,1}','erste funktionale Symmetrie','Erste zu komponierende funktionale Symmetrie.',NULL,'Symmetrie',1),
(@eq_3112,'\\mathcal{S}_{F,2}','zweite funktionale Symmetrie','Zweite zu komponierende funktionale Symmetrie.',NULL,'Symmetrie',2),
(@eq_3112,'\\circ','Kompositionsoperator','Hintereinanderausführung zweier funktionaler Symmetrien.',NULL,'Abbildungsoperator',3),
(@eq_3113,'I_F\\circ\\mathcal{S}_F=I_F','Symmetrieerhaltung','Funktionsgleichheit der Invarianten vor und nach Symmetrietransformation.',NULL,'Funktionsgleichheit',1)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* 12. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from` IN (@def_3421_id,@def_3422_id))
    OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_349_id)
    OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3411_id)
    OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3110,@eq_3111,@eq_3112,@eq_3113));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3421_id,'definition',@def_3420_id,'depends_on','Die funktionale Symmetrie wird relativ zur Klasse funktionaler Erhaltungsgesetze definiert.'),
('definition',@def_3421_id,'definition',@def_3419_id,'depends_on','Die Symmetriedefinition verwendet das einzelne funktionale Erhaltungsgesetz.'),
('definition',@def_3422_id,'definition',@def_3421_id,'depends_on','Die Symmetrieklasse setzt die Definition der funktionalen Symmetrie voraus.'),
('lemma',@lemma_349_id,'definition',@def_3422_id,'depends_on','Das Abschlusslemma bezieht sich auf die Klasse funktionaler Symmetrien.'),
('theorem',@theorem_3411_id,'definition',@def_3420_id,'depends_on','Der Satz verwendet die Klasse funktionaler Erhaltungsgesetze.'),
('theorem',@theorem_3411_id,'definition',@def_3421_id,'derives_from','Die Erhaltungsaussage folgt unmittelbar aus der Symmetriedefinition.'),
('equation',@eq_3110,'definition',@def_3421_id,'derives_from','Gleichung (3.110) formalisiert Def. 3.4.21.'),
('equation',@eq_3111,'definition',@def_3422_id,'derives_from','Gleichung (3.111) formalisiert Def. 3.4.22.'),
('equation',@eq_3112,'lemma',@lemma_349_id,'derives_from','Gleichung (3.112) formalisiert Lemma 3.4.9.'),
('equation',@eq_3113,'theorem',@theorem_3411_id,'derives_from','Gleichung (3.113) formalisiert Satz 3.4.11.');

/* 13. Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3110,@eq_3111,@eq_3112,@eq_3113);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3110,@eq_3107,'depends_on','Die Symmetriedefinition verwendet die in Gleichung (3.107) definierte Klasse funktionaler Erhaltungsgesetze.'),
(@eq_3110,@eq_3106,'depends_on','Die Symmetrie erhält die in Gleichung (3.106) formulierten Erhaltungsgesetze.'),
(@eq_3111,@eq_3110,'derives_from','Die Symmetrieklasse wird aus der Symmetriebedingung gebildet.'),
(@eq_3112,@eq_3111,'depends_on','Das Abschlusslemma wird auf der Klasse funktionaler Symmetrien formuliert.'),
(@eq_3112,@eq_3108,'depends_on','Die Kompositionserhaltung folgt derselben Kompositionslogik wie Gleichung (3.108).'),
(@eq_3113,@eq_3110,'derives_from','Die Erhaltungsaussage ist die Funktionsform der Symmetriedefinition.'),
(@eq_3113,@eq_3107,'depends_on','Der Satz quantifiziert über die Klasse funktionaler Erhaltungsgesetze.');

/* 14. Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(
    @revision_id,@section_id,'rewritten','section','3.4.11',
    'Abschnitt 3.4.11 wurde vollständig als mathematische Rekonstruktion funktionaler Symmetrien neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.11.',
    'Def. 3.4.21, Def. 3.4.22, Lemma 3.4.9, Satz 3.4.11 und Gleichungen (3.110) bis (3.113).'
),
(
    @revision_id,@section_id,'definition_added','definition','Def. 3.4.21–Def. 3.4.22',
    'Funktionale Symmetrie und Klasse funktionaler Symmetrien wurden registriert.',
    'Bezeichnung als Gruppe ohne Nachweis aller Gruppenaxiome.',
    'Zunächst unter Komposition abgeschlossene Symmetrieklasse.'
),
(
    @revision_id,@section_id,'statement_added','lemma','Lemma 3.4.9',
    'Der Abschluss funktionaler Symmetrien unter wohldefinierter Komposition wurde registriert.',
    NULL,
    'Abschluss unter Komposition'
),
(
    @revision_id,@section_id,'statement_added','theorem','Satz 3.4.11',
    'Die Erhaltung bereits definierter funktionaler Erhaltungsgesetze unter Symmetrien wurde registriert.',
    'Nicht begründete Behauptung, dass jede Symmetrie nichttriviale Erhaltungsgesetze erzeugt.',
    'Korrekte Erhaltungsaussage für bereits definierte Elemente von E_F.'
),
(
    @revision_id,@section_id,'equation_added','equation','(3.110)–(3.113)',
    'Symmetriebedingung, Symmetrieklasse, Kompositionsabschluss und Erhaltungssatz wurden formal registriert.',
    NULL,
    '4 Gleichungen'
);

/* 15. Repository-Zähler. */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.114'),
('next_definition_number','Def. 3.4.23'),
('next_lemma_number','Lemma 3.4.10'),
('next_theorem_number','Satz 3.4.12'),
('last_edited_section','3.4.11'),
('last_repository_revision','RKB-2026-07-13-K3.4.11-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN
   ============================================================ */

SELECT
    ds.`section_code`,ds.`title`,ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.11')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,d.`title`,d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.21','Def. 3.4.22')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,l.`title`,l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number`='Lemma 3.4.9';

SELECT
    t.`theorem_number`,t.`title`,t.`statement_latex`,
    t.`assumptions`,t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number`='Satz 3.4.11';

SELECT
    e.`equation_number`,e.`title`,e.`equation_latex`,
    e.`word_latex`,e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.110','3.111','3.112','3.113')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,es.`symbol_latex`,es.`symbol_name`,
    es.`domain_text`,es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.110','3.111','3.112','3.113')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT COUNT(*) AS `source_usages_in_3_4_11`
FROM `source_usage`
WHERE `section_id`=@section_id;

SELECT
    rc.`counter_key`,rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_equation_number','next_definition_number',
    'next_lemma_number','next_theorem_number',
    'last_edited_section','last_repository_revision'
)
ORDER BY rc.`counter_key`;
