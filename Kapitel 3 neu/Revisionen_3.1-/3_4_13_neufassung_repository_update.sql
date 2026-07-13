USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.13
   Orbits und Quotientenstrukturen funktionaler Symmetrien

   Definitionen:
   - Def. 3.4.25 Funktionaler Symmetrieorbit
   - Def. 3.4.26 Funktionale Quotientenstruktur

   Lemma:
   - Lemma 3.4.11 Invarianz auf Symmetrieorbits

   Satz:
   - Satz 3.4.13 Wohldefiniertheit der Quotientenstruktur

   Gleichungen:
   - (3.120) Funktionaler Symmetrieorbit
   - (3.121) Orbitäquivalenz
   - (3.122) Funktionale Quotientenstruktur
   - (3.123) Projektion auf die Quotientenstruktur
   - (3.124) Invarianz auf Symmetrieorbits
   - (3.125) Wohldefiniertheit der Quotientenabbildung

   Neue Quellen: keine

   Nächste Gleichung:   (3.126)
   Nächste Definition:  Def. 3.4.27
   Nächstes Lemma:      Lemma 3.4.12
   Nächster Satz:       Satz 3.4.14
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
    'RKB-2026-07-13-K3.4.13-NEUFASSUNG-V1',
    NOW(),'section','3.4.13','1.0',
    'Neufassung von Abschnitt 3.4.13 mit Def. 3.4.25, Def. 3.4.26, Lemma 3.4.11, Satz 3.4.13 und den Gleichungen (3.120) bis (3.125).',
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
    @chapter_id,'3.4.13',
    'Orbits und Quotientenstrukturen funktionaler Symmetrien',
    3,3.5940,'review',1,
    'Rekonstruktion von Symmetrieorbits, Orbitäquivalenz und funktionalen Quotientenstrukturen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM `dissertation_sections`
      WHERE `section_code`='3.4.13'
  );

SET @section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code`='3.4.13'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Orbits und Quotientenstrukturen funktionaler Symmetrien',
    `chapter_no`=3,
    `section_order`=3.5940,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.25, Def. 3.4.26, Lemma 3.4.11, Satz 3.4.13 und die Gleichungen (3.120) bis (3.125).'
WHERE `section_id`=@section_id;

DELETE FROM `source_usage`
WHERE `section_id`=@section_id;

SET @def_3422_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.22' LIMIT 1
);
SET @def_3423_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.23' LIMIT 1
);
SET @def_3424_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.24' LIMIT 1
);
SET @def_3425_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.25' LIMIT 1
);
SET @def_3426_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.26' LIMIT 1
);
SET @lemma_3411_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.11' LIMIT 1
);
SET @theorem_3413_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.13' LIMIT 1
);

/* Def. 3.4.25 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionaler Symmetrieorbit',
    `definition_text`='Der funktionale Symmetrieorbit eines Organisationsraums ist die Menge aller Organisationsräume, die durch Anwendung funktionaler Symmetrien aus ihm hervorgehen.',
    `formal_latex`='\\operatorname{Orb}_F(\\mathfrak{O})=\\left\\{\\mathcal{S}_F(\\mathfrak{O})\\mid\\mathcal{S}_F\\in\\mathfrak{S}_F\\right\\}',
    `word_latex`='\\operatorname{Orb}_F(\\mathfrak{O})=\\left\\{\\mathcal{S}_F(\\mathfrak{O})\\mid\\mathcal{S}_F\\in\\mathfrak{S}_F\\right\\}',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Satz 3.4.12 gilt.',
    `notes`='Alle Elemente eines Orbits sind durch funktionale Symmetrien miteinander verbunden.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3425_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.25',@section_id,'Funktionaler Symmetrieorbit',
    'Der funktionale Symmetrieorbit eines Organisationsraums ist die Menge aller Organisationsräume, die durch Anwendung funktionaler Symmetrien aus ihm hervorgehen.',
    '\\operatorname{Orb}_F(\\mathfrak{O})=\\left\\{\\mathcal{S}_F(\\mathfrak{O})\\mid\\mathcal{S}_F\\in\\mathfrak{S}_F\\right\\}',
    '\\operatorname{Orb}_F(\\mathfrak{O})=\\left\\{\\mathcal{S}_F(\\mathfrak{O})\\mid\\mathcal{S}_F\\in\\mathfrak{S}_F\\right\\}',
    'original',NULL,'Satz 3.4.12 gilt.',
    'Alle Elemente eines Orbits sind durch funktionale Symmetrien miteinander verbunden.',
    'checked',@revision_id
WHERE @def_3425_id IS NULL;

SET @def_3425_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.25' LIMIT 1
);

/* Def. 3.4.26 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Quotientenstruktur',
    `definition_text`='Die funktionale Quotientenstruktur ist die Menge der Äquivalenzklassen funktionaler Organisationsräume bezüglich ihrer Zugehörigkeit zum selben Symmetrieorbit.',
    `formal_latex`='\\mathfrak{Q}_F=\\mathfrak{O}_F/\\!\\sim_S',
    `word_latex`='\\mathfrak{Q}_F=\\mathfrak{O}_F/\\!\\sim_S',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.25 gilt und die Orbitrelation ist eine Äquivalenzrelation.',
    `notes`='Jedes Element der Quotientenstruktur repräsentiert einen vollständigen Symmetrieorbit.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3426_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.26',@section_id,'Funktionale Quotientenstruktur',
    'Die funktionale Quotientenstruktur ist die Menge der Äquivalenzklassen funktionaler Organisationsräume bezüglich ihrer Zugehörigkeit zum selben Symmetrieorbit.',
    '\\mathfrak{Q}_F=\\mathfrak{O}_F/\\!\\sim_S',
    '\\mathfrak{Q}_F=\\mathfrak{O}_F/\\!\\sim_S',
    'original',NULL,
    'Def. 3.4.25 gilt und die Orbitrelation ist eine Äquivalenzrelation.',
    'Jedes Element der Quotientenstruktur repräsentiert einen vollständigen Symmetrieorbit.',
    'checked',@revision_id
WHERE @def_3426_id IS NULL;

SET @def_3426_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.26' LIMIT 1
);

/* Lemma 3.4.11 */
UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Invarianz auf Symmetrieorbits',
    `statement_text`='Jedes funktionale Erhaltungsgesetz besitzt auf einem funktionalen Symmetrieorbit einen konstanten Wert.',
    `statement_latex`='\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O}_1)=I_F(\\mathfrak{O}_2)',
    `word_latex`='\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O}_1)=I_F(\\mathfrak{O}_2)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.21, Def. 3.4.25 und Satz 3.4.12 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_3411_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.11',@section_id,'Invarianz auf Symmetrieorbits',
    'Jedes funktionale Erhaltungsgesetz besitzt auf einem funktionalen Symmetrieorbit einen konstanten Wert.',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O}_1)=I_F(\\mathfrak{O}_2)',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O}_1)=I_F(\\mathfrak{O}_2)',
    'original',NULL,
    'Def. 3.4.21, Def. 3.4.25 und Satz 3.4.12 gelten.',
    'checked',@revision_id
WHERE @lemma_3411_id IS NULL;

SET @lemma_3411_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.11' LIMIT 1
);

/* Satz 3.4.13 */
UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Wohldefiniertheit der funktionalen Quotientenstruktur',
    `statement_text`='Die Orbitrelation funktionaler Symmetrien ist reflexiv, symmetrisch und transitiv. Daher zerlegt sie die funktionalen Organisationsräume in disjunkte Äquivalenzklassen und definiert eine wohldefinierte Quotientenstruktur.',
    `statement_latex`='\\pi_F:\\mathfrak{O}_F\\rightarrow\\mathfrak{Q}_F,\\qquad\\pi_F(\\mathfrak{O})=[\\mathfrak{O}]_{\\sim_S}',
    `word_latex`='\\pi_F:\\mathfrak{O}_F\\rightarrow\\mathfrak{Q}_F,\\qquad\\pi_F(\\mathfrak{O})=[\\mathfrak{O}]_{\\sim_S}',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Satz 3.4.12 sowie Def. 3.4.25 und Def. 3.4.26 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3413_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.13',@section_id,
    'Wohldefiniertheit der funktionalen Quotientenstruktur',
    'Die Orbitrelation funktionaler Symmetrien ist reflexiv, symmetrisch und transitiv. Daher zerlegt sie die funktionalen Organisationsräume in disjunkte Äquivalenzklassen und definiert eine wohldefinierte Quotientenstruktur.',
    '\\pi_F:\\mathfrak{O}_F\\rightarrow\\mathfrak{Q}_F,\\qquad\\pi_F(\\mathfrak{O})=[\\mathfrak{O}]_{\\sim_S}',
    '\\pi_F:\\mathfrak{O}_F\\rightarrow\\mathfrak{Q}_F,\\qquad\\pi_F(\\mathfrak{O})=[\\mathfrak{O}]_{\\sim_S}',
    'original',NULL,
    'Satz 3.4.12 sowie Def. 3.4.25 und Def. 3.4.26 gelten.',
    'checked',@revision_id
WHERE @theorem_3413_id IS NULL;

SET @theorem_3413_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.13' LIMIT 1
);

/* Alte Gleichungen bereinigen. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='equation' AND `object_id_from` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125')
 ))
 OR
 (`object_type_to`='equation' AND `object_id_to` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125')
 ));

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125');

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125');

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125');

INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.120',@section_id,'Funktionaler Symmetrieorbit',
    '\\operatorname{Orb}_F(\\mathfrak{O})=\\left\\{\\mathcal{S}_F(\\mathfrak{O})\\mid\\mathcal{S}_F\\in\\mathfrak{S}_F\\right\\}',
    '\\operatorname{Orb}_F(\\mathfrak{O})=\\left\\{\\mathcal{S}_F(\\mathfrak{O})\\mid\\mathcal{S}_F\\in\\mathfrak{S}_F\\right\\}',
    'Der Symmetrieorbit enthält alle durch funktionale Symmetrien erreichbaren Organisationsräume.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.25.',
    'Satz 3.4.12 gilt.','checked',@revision_id
),
(
    '3.121',@section_id,'Orbitäquivalenz',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longleftrightarrow\\exists\\,\\mathcal{S}_F\\in\\mathfrak{S}_F:\\;\\mathfrak{O}_2=\\mathcal{S}_F(\\mathfrak{O}_1)',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longleftrightarrow\\exists\\,\\mathcal{S}_F\\in\\mathfrak{S}_F:\\;\\mathfrak{O}_2=\\mathcal{S}_F(\\mathfrak{O}_1)',
    'Zwei Organisationsräume sind orbitäquivalent, wenn eine funktionale Symmetrie den einen in den anderen überführt.',
    'definition','original',NULL,'Äquivalenzrelation auf Basis von Def. 3.4.25.',
    'Satz 3.4.12 gilt.','checked',@revision_id
),
(
    '3.122',@section_id,'Funktionale Quotientenstruktur',
    '\\mathfrak{Q}_F=\\mathfrak{O}_F/\\!\\sim_S',
    '\\mathfrak{Q}_F=\\mathfrak{O}_F/\\!\\sim_S',
    'Die Quotientenstruktur enthält die Äquivalenzklassen der Orbitrelation.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.26.',
    'Die Orbitrelation ist eine Äquivalenzrelation.','checked',@revision_id
),
(
    '3.123',@section_id,'Projektion auf die Quotientenstruktur',
    '\\pi_F:\\mathfrak{O}_F\\rightarrow\\mathfrak{Q}_F,\\qquad\\pi_F(\\mathfrak{O})=[\\mathfrak{O}]_{\\sim_S}',
    '\\pi_F:\\mathfrak{O}_F\\rightarrow\\mathfrak{Q}_F,\\qquad\\pi_F(\\mathfrak{O})=[\\mathfrak{O}]_{\\sim_S}',
    'Die kanonische Projektion ordnet jedem Organisationsraum seine Orbitklasse zu.',
    'theorem','original',NULL,'Bestandteil von Satz 3.4.13.',
    'Def. 3.4.26 gilt.','checked',@revision_id
),
(
    '3.124',@section_id,'Invarianz auf Symmetrieorbits',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O}_1)=I_F(\\mathfrak{O}_2)',
    '\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2\\Longrightarrow\\forall I_F\\in\\mathcal{E}_F:\\;I_F(\\mathfrak{O}_1)=I_F(\\mathfrak{O}_2)',
    'Funktionale Erhaltungsgesetze sind auf jedem Symmetrieorbit konstant.',
    'lemma','original',NULL,'Formale Darstellung von Lemma 3.4.11.',
    'Def. 3.4.21 und Def. 3.4.25 gelten.','checked',@revision_id
),
(
    '3.125',@section_id,'Wohldefiniertheit der Quotientenabbildung',
    '\\pi_F(\\mathfrak{O}_1)=\\pi_F(\\mathfrak{O}_2)\\Longleftrightarrow\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2',
    '\\pi_F(\\mathfrak{O}_1)=\\pi_F(\\mathfrak{O}_2)\\Longleftrightarrow\\mathfrak{O}_1\\sim_S\\mathfrak{O}_2',
    'Zwei Organisationsräume besitzen genau dann dasselbe Quotientenbild, wenn sie orbitäquivalent sind.',
    'theorem','original',NULL,'Folgerung aus Satz 3.4.13.',
    'Die Orbitrelation ist eine Äquivalenzrelation.','checked',@revision_id
);

SET @eq_3120 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.120' LIMIT 1);
SET @eq_3121 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.121' LIMIT 1);
SET @eq_3122 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.122' LIMIT 1);
SET @eq_3123 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.123' LIMIT 1);
SET @eq_3124 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.124' LIMIT 1);
SET @eq_3125 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.125' LIMIT 1);
SET @eq_3118 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.118' LIMIT 1);
SET @eq_3119 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.119' LIMIT 1);

/* Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3120,@eq_3121,@eq_3122,@eq_3123,@eq_3124,@eq_3125);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3120,'\\operatorname{Orb}_F(\\mathfrak{O})','funktionaler Symmetrieorbit','Menge aller aus O durch funktionale Symmetrien erzeugbaren Organisationsräume.',NULL,'Menge',1),
(@eq_3120,'\\mathfrak{S}_F','Gruppe funktionaler Symmetrien','In Satz 3.4.12 definierte Symmetriegruppe.',NULL,'Gruppe',2),
(@eq_3121,'\\sim_S','Orbitäquivalenz','Äquivalenzrelation der Zugehörigkeit zum selben Symmetrieorbit.',NULL,'Relation',1),
(@eq_3122,'\\mathfrak{Q}_F','funktionale Quotientenstruktur','Menge der Orbitäquivalenzklassen.',NULL,'Quotientenmenge',1),
(@eq_3123,'\\pi_F','kanonische Projektion','Ordnet einem Organisationsraum seine Orbitklasse zu.',NULL,'Abbildung',1),
(@eq_3124,'\\mathcal{E}_F','Klasse funktionaler Erhaltungsgesetze','Auf Symmetrieorbits konstante Invariantenklasse.',NULL,'Menge',1),
(@eq_3125,'[\\mathfrak{O}]_{\\sim_S}','Orbitklasse','Äquivalenzklasse eines Organisationsraums unter der Orbitrelation.',NULL,'Äquivalenzklasse',1)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='definition' AND `object_id_from` IN (@def_3425_id,@def_3426_id))
 OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3411_id)
 OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3413_id)
 OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3120,@eq_3121,@eq_3122,@eq_3123,@eq_3124,@eq_3125));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3425_id,'definition',@def_3422_id,'depends_on','Der Symmetrieorbit setzt die Symmetrieklasse voraus.'),
('definition',@def_3426_id,'definition',@def_3425_id,'depends_on','Die Quotientenstruktur wird aus Symmetrieorbits gebildet.'),
('lemma',@lemma_3411_id,'definition',@def_3425_id,'depends_on','Das Lemma wird auf Symmetrieorbits formuliert.'),
('theorem',@theorem_3413_id,'definition',@def_3426_id,'depends_on','Der Satz begründet die Wohldefiniertheit der Quotientenstruktur.'),
('equation',@eq_3120,'definition',@def_3425_id,'derives_from','Gleichung (3.120) formalisiert Def. 3.4.25.'),
('equation',@eq_3122,'definition',@def_3426_id,'derives_from','Gleichung (3.122) formalisiert Def. 3.4.26.'),
('equation',@eq_3124,'lemma',@lemma_3411_id,'derives_from','Gleichung (3.124) formalisiert Lemma 3.4.11.'),
('equation',@eq_3123,'theorem',@theorem_3413_id,'derives_from','Gleichung (3.123) ist Bestandteil von Satz 3.4.13.'),
('equation',@eq_3125,'theorem',@theorem_3413_id,'derives_from','Gleichung (3.125) formalisiert die Wohldefiniertheit der Quotientenabbildung.');

/* Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3120,@eq_3121,@eq_3122,@eq_3123,@eq_3124,@eq_3125);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3120,@eq_3118,'depends_on','Der Orbit wird durch die Symmetriegruppe aus Gleichung (3.118) erzeugt.'),
(@eq_3121,@eq_3120,'derives_from','Die Orbitäquivalenz folgt aus der Orbitdefinition.'),
(@eq_3121,@eq_3119,'depends_on','Reflexivität, Symmetrie und Transitivität verwenden die Gruppenaxiome.'),
(@eq_3122,@eq_3121,'derives_from','Die Quotientenstruktur wird aus der Orbitäquivalenz gebildet.'),
(@eq_3123,@eq_3122,'depends_on','Die Projektion bildet in die Quotientenstruktur ab.'),
(@eq_3124,@eq_3121,'depends_on','Die Invarianzaussage gilt für orbitäquivalente Organisationsräume.'),
(@eq_3125,@eq_3123,'derives_from','Die Wohldefiniertheit bezieht sich auf die kanonische Projektion.'),
(@eq_3125,@eq_3121,'depends_on','Gleiches Quotientenbild ist äquivalent zur Orbitäquivalenz.');

/* Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.13',
 'Abschnitt 3.4.13 wurde vollständig als Rekonstruktion funktionaler Symmetrieorbits und Quotientenstrukturen neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.13.',
 'Def. 3.4.25, Def. 3.4.26, Lemma 3.4.11, Satz 3.4.13 und Gleichungen (3.120) bis (3.125).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.25–Def. 3.4.26',
 'Funktionaler Symmetrieorbit und funktionale Quotientenstruktur wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.11',
 'Die Invarianz funktionaler Erhaltungsgesetze auf Symmetrieorbits wurde registriert.',NULL,'Orbitinvarianz'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.13',
 'Die Wohldefiniertheit der funktionalen Quotientenstruktur wurde registriert.',NULL,'Wohldefinierte Quotientenstruktur'),
(@revision_id,@section_id,'equation_added','equation','(3.120)–(3.125)',
 'Orbit, Orbitäquivalenz, Quotientenstruktur, Projektion, Invarianz und Wohldefiniertheit wurden formal registriert.',NULL,'6 Gleichungen');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.126'),
('next_definition_number','Def. 3.4.27'),
('next_lemma_number','Lemma 3.4.12'),
('next_theorem_number','Satz 3.4.14'),
('last_edited_section','3.4.13'),
('last_repository_revision','RKB-2026-07-13-K3.4.13-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen */
SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.13')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.25','Def. 3.4.26')
ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas`
WHERE `lemma_number`='Lemma 3.4.11';

SELECT `theorem_number`,`title`,`statement_latex`,`validation_status`
FROM `theorems`
WHERE `theorem_number`='Satz 3.4.13';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.120','3.121','3.122','3.123','3.124','3.125')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_13`
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
