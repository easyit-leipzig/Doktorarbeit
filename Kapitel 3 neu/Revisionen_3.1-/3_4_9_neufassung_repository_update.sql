USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.9 – Funktionale Invarianten
   Definitionen: Def. 3.4.17, Def. 3.4.18
   Lemma: Lemma 3.4.7
   Satz: Satz 3.4.9
   Gleichungen: (3.102)–(3.105)
   Neue Quellen: keine
   ============================================================ */

/* Parent-Revision separat ermitteln: verhindert MySQL #1093. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`) FROM `repository_revisions` r
);

INSERT INTO `repository_revisions` (
    `revision_code`,`revision_date`,`scope_type`,`scope_reference`,
    `version_label`,`summary`,`created_by`,`parent_revision_id`
)
VALUES (
    'RKB-2026-07-13-K3.4.9-NEUFASSUNG-V1',
    NOW(),'section','3.4.9','1.0',
    'Neufassung von Abschnitt 3.4.9 mit Def. 3.4.17, Def. 3.4.18, Lemma 3.4.7, Satz 3.4.9 und den Gleichungen (3.102) bis (3.105).',
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
    @chapter_id,'3.4.9',
    'Mathematische Rekonstruktion funktionaler Invarianten',
    3,3.5900,'review',1,
    'Rekonstruktion funktionaler Erhaltungsgrößen und der Invariantenäquivalenz funktionaler Entwicklungsbahnen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM `dissertation_sections`
      WHERE `section_code`='3.4.9'
  );

SET @section_id := (
    SELECT `section_id` FROM `dissertation_sections`
    WHERE `section_code`='3.4.9' LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Mathematische Rekonstruktion funktionaler Invarianten',
    `chapter_no`=3,
    `section_order`=3.5900,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.17, Def. 3.4.18, Lemma 3.4.7, Satz 3.4.9 und die Gleichungen (3.102) bis (3.105).'
WHERE `section_id`=@section_id;

UPDATE `dissertation_sections`
SET `status`='review',`is_original_contribution`=1
WHERE `section_id`=@chapter_id;

DELETE FROM `source_usage` WHERE `section_id`=@section_id;

/* Vorgängerobjekte. */
SET @axiom_a4_id := (
    SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A4' LIMIT 1
);
SET @axiom_a5_id := (
    SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A5' LIMIT 1
);
SET @def_346_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.6' LIMIT 1
);
SET @def_348_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.8' LIMIT 1
);
SET @def_3414_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.14' LIMIT 1
);

/* Zielobjekte. */
SET @def_3417_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.17' LIMIT 1
);
SET @def_3418_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.18' LIMIT 1
);
SET @lemma_347_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.7' LIMIT 1
);
SET @theorem_349_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.9' LIMIT 1
);

/* Def. 3.4.17 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Invariante',
    `definition_text`='Eine Größe heißt funktionale Invariante, wenn ihr Wert unter jeder zulässigen funktionalen Transformation unverändert bleibt.',
    `formal_latex`='I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    `word_latex`='I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.6 und Def. 3.4.8 gelten; I_F ist wohldefiniert.',
    `notes`='Die Invariante kann skalar, vektoriell oder strukturell sein.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3417_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.17',@section_id,'Funktionale Invariante',
    'Eine Größe heißt funktionale Invariante, wenn ihr Wert unter jeder zulässigen funktionalen Transformation unverändert bleibt.',
    'I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    'I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    'original',NULL,
    'Def. 3.4.6 und Def. 3.4.8 gelten; I_F ist wohldefiniert.',
    'Die Invariante kann skalar, vektoriell oder strukturell sein.',
    'checked',@revision_id
WHERE @def_3417_id IS NULL;

SET @def_3417_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.17' LIMIT 1
);

/* Def. 3.4.18 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Menge funktionaler Invarianten',
    `definition_text`='Die Menge funktionaler Invarianten umfasst alle wohldefinierten Größen, die unter jeder zulässigen funktionalen Transformation unverändert bleiben.',
    `formal_latex`='\\mathcal{I}_F=\\left\\{I_F\\mid I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    `word_latex`='\\mathcal{I}_F=\\left\\{I_F\\mid I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.17 gilt.',
    `notes`='Die Invariantenmenge charakterisiert die erhaltenen funktionalen Eigenschaften.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3418_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.18',@section_id,'Menge funktionaler Invarianten',
    'Die Menge funktionaler Invarianten umfasst alle wohldefinierten Größen, die unter jeder zulässigen funktionalen Transformation unverändert bleiben.',
    '\\mathcal{I}_F=\\left\\{I_F\\mid I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    '\\mathcal{I}_F=\\left\\{I_F\\mid I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    'original',NULL,'Def. 3.4.17 gilt.',
    'Die Invariantenmenge charakterisiert die erhaltenen funktionalen Eigenschaften.',
    'checked',@revision_id
WHERE @def_3418_id IS NULL;

SET @def_3418_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.18' LIMIT 1
);

/* Lemma 3.4.7 */
UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Invarianz entlang funktionaler Entwicklungsbahnen',
    `statement_text`='Ist I_F eine funktionale Invariante, dann besitzt sie entlang jeder durch zulässige Transformationen erzeugten funktionalen Entwicklungsbahn denselben Wert.',
    `statement_latex`='I_F(\\mathfrak{O}_0)=I_F(\\mathfrak{O}_1)=\\cdots=I_F(\\mathfrak{O}_n)',
    `word_latex`='I_F(\\mathfrak{O}_0)=I_F(\\mathfrak{O}_1)=\\cdots=I_F(\\mathfrak{O}_n)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.14 und Def. 3.4.17 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_347_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.7',@section_id,
    'Invarianz entlang funktionaler Entwicklungsbahnen',
    'Ist I_F eine funktionale Invariante, dann besitzt sie entlang jeder durch zulässige Transformationen erzeugten funktionalen Entwicklungsbahn denselben Wert.',
    'I_F(\\mathfrak{O}_0)=I_F(\\mathfrak{O}_1)=\\cdots=I_F(\\mathfrak{O}_n)',
    'I_F(\\mathfrak{O}_0)=I_F(\\mathfrak{O}_1)=\\cdots=I_F(\\mathfrak{O}_n)',
    'original',NULL,'Def. 3.4.14 und Def. 3.4.17 gelten.',
    'checked',@revision_id
WHERE @lemma_347_id IS NULL;

SET @lemma_347_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.7' LIMIT 1
);

/* Satz 3.4.9:
   ~_I wird explizit als Gleichheit der Invariantenmengen definiert. */
UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Vergleichbarkeit funktionaler Entwicklungsbahnen',
    `statement_text`='Zwei funktionale Entwicklungsbahnen heißen invariantengleich und werden als funktional äquivalent klassifiziert, wenn ihre Mengen funktionaler Invarianten übereinstimmen.',
    `statement_latex`='\\mathcal{I}_F(\\Gamma_1)=\\mathcal{I}_F(\\Gamma_2)\\Longrightarrow\\Gamma_1\\sim_I\\Gamma_2',
    `word_latex`='\\mathcal{I}_F(\\Gamma_1)=\\mathcal{I}_F(\\Gamma_2)\\Longrightarrow\\Gamma_1\\sim_I\\Gamma_2',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.14 und Def. 3.4.18 gelten; ~_I ist durch Gleichheit der Invariantenmengen definiert.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_349_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.9',@section_id,
    'Vergleichbarkeit funktionaler Entwicklungsbahnen',
    'Zwei funktionale Entwicklungsbahnen heißen invariantengleich und werden als funktional äquivalent klassifiziert, wenn ihre Mengen funktionaler Invarianten übereinstimmen.',
    '\\mathcal{I}_F(\\Gamma_1)=\\mathcal{I}_F(\\Gamma_2)\\Longrightarrow\\Gamma_1\\sim_I\\Gamma_2',
    '\\mathcal{I}_F(\\Gamma_1)=\\mathcal{I}_F(\\Gamma_2)\\Longrightarrow\\Gamma_1\\sim_I\\Gamma_2',
    'original',NULL,
    'Def. 3.4.14 und Def. 3.4.18 gelten; ~_I ist durch Gleichheit der Invariantenmengen definiert.',
    'checked',@revision_id
WHERE @theorem_349_id IS NULL;

SET @theorem_349_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.9' LIMIT 1
);

/* Alte Gleichungen und abhängige Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='equation' AND `object_id_from` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.102','3.103','3.104','3.105')
 ))
 OR
 (`object_type_to`='equation' AND `object_id_to` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.102','3.103','3.104','3.105')
 ));

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.102','3.103','3.104','3.105');

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.102','3.103','3.104','3.105');

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.102','3.103','3.104','3.105');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.102','3.103','3.104','3.105');

INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.102',@section_id,'Funktionale Invariante',
    'I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    'I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)',
    'Eine funktionale Invariante besitzt vor und nach einer zulässigen Transformation denselben Wert.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.17.',
    'Def. 3.4.6 und Def. 3.4.8 gelten.','checked',@revision_id
),
(
    '3.103',@section_id,'Menge funktionaler Invarianten',
    '\\mathcal{I}_F=\\left\\{I_F\\mid I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    '\\mathcal{I}_F=\\left\\{I_F\\mid I_F(\\mathfrak{O})=I_F\\!\\left(\\mathcal{T}_F(\\mathfrak{O})\\right)\\right\\}',
    'Die Invariantenmenge enthält alle unter zulässigen Transformationen erhaltenen funktionalen Größen.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.18.',
    'Def. 3.4.17 gilt.','checked',@revision_id
),
(
    '3.104',@section_id,'Invarianz entlang einer Entwicklungsbahn',
    'I_F(\\mathfrak{O}_0)=I_F(\\mathfrak{O}_1)=\\cdots=I_F(\\mathfrak{O}_n)',
    'I_F(\\mathfrak{O}_0)=I_F(\\mathfrak{O}_1)=\\cdots=I_F(\\mathfrak{O}_n)',
    'Der Wert einer funktionalen Invarianten bleibt entlang einer zulässigen Entwicklungsbahn konstant.',
    'lemma','original',NULL,'Formale Darstellung von Lemma 3.4.7.',
    'Def. 3.4.14 und Def. 3.4.17 gelten.','checked',@revision_id
),
(
    '3.105',@section_id,'Invariantenäquivalenz funktionaler Entwicklungsbahnen',
    '\\mathcal{I}_F(\\Gamma_1)=\\mathcal{I}_F(\\Gamma_2)\\Longrightarrow\\Gamma_1\\sim_I\\Gamma_2',
    '\\mathcal{I}_F(\\Gamma_1)=\\mathcal{I}_F(\\Gamma_2)\\Longrightarrow\\Gamma_1\\sim_I\\Gamma_2',
    'Zwei Entwicklungsbahnen werden als invariantengleich klassifiziert, wenn ihre Invariantenmengen übereinstimmen.',
    'theorem','original',NULL,
    'Formale Darstellung von Satz 3.4.9; ~_I ist durch Gleichheit der Invariantenmengen definiert.',
    'Def. 3.4.14 und Def. 3.4.18 gelten.','checked',@revision_id
);

SET @eq_3102 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.102' LIMIT 1);
SET @eq_3103 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.103' LIMIT 1);
SET @eq_3104 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.104' LIMIT 1);
SET @eq_3105 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.105' LIMIT 1);
SET @eq_380 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.80' LIMIT 1);
SET @eq_384 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.84' LIMIT 1);
SET @eq_395 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.95' LIMIT 1);

/* Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3102,@eq_3103,@eq_3104,@eq_3105);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3102,'I_F','funktionale Invariante','Unter zulässigen Transformationen erhaltene funktionale Größe.',NULL,'Abbildung auf Organisationsräumen',1),
(@eq_3102,'\\mathfrak{O}','funktionaler Organisationsraum','Beliebiger funktionaler Organisationsraum.',NULL,'Organisationsraum',2),
(@eq_3102,'\\mathcal{T}_F','funktionale Transformation','Zulässige Transformation des Organisationsraums.',NULL,'Abbildung',3),
(@eq_3103,'\\mathcal{I}_F','Menge funktionaler Invarianten','Gesamtheit aller funktionalen Invarianten.',NULL,'Menge',1),
(@eq_3103,'I_F','Element der Invariantenmenge','Eine die Invarianzbedingung erfüllende Größe.',NULL,'I_F\\in\\mathcal{I}_F',2),
(@eq_3104,'\\mathfrak{O}_i','i-ter Organisationsraum','Organisationsraum an Position i der Entwicklungsbahn.',NULL,'Organisationsraum',1),
(@eq_3104,'I_F(\\mathfrak{O}_i)','Invariantenwert','Wert der Invarianten am i-ten Organisationsraum.',NULL,'Wertebereich von I_F',2),
(@eq_3105,'\\Gamma_1','erste Entwicklungsbahn','Erste zu vergleichende Entwicklungsbahn.',NULL,'Entwicklungsbahn',1),
(@eq_3105,'\\Gamma_2','zweite Entwicklungsbahn','Zweite zu vergleichende Entwicklungsbahn.',NULL,'Entwicklungsbahn',2),
(@eq_3105,'\\sim_I','Invariantenäquivalenz','Durch Gleichheit der Invariantenmengen definierte Äquivalenzrelation.',NULL,'Äquivalenzrelation',3)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='definition' AND `object_id_from` IN (@def_3417_id,@def_3418_id))
 OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_347_id)
 OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_349_id)
 OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3102,@eq_3103,@eq_3104,@eq_3105));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3417_id,'axiom',@axiom_a4_id,'derives_from','Funktionale Invarianten präzisieren die Erhaltung stabiler funktionaler Organisation nach A4.'),
('definition',@def_3417_id,'definition',@def_346_id,'depends_on','Die Invarianz wird gegenüber rekursiven Transformationen definiert.'),
('definition',@def_3417_id,'definition',@def_348_id,'depends_on','Die Invariante wird auf funktionalen Organisationsräumen ausgewertet.'),
('definition',@def_3418_id,'definition',@def_3417_id,'depends_on','Die Invariantenmenge setzt die funktionale Invariante voraus.'),
('lemma',@lemma_347_id,'definition',@def_3414_id,'depends_on','Das Lemma wird entlang funktionaler Entwicklungsbahnen formuliert.'),
('lemma',@lemma_347_id,'definition',@def_3417_id,'derives_from','Die Bahnkonstanz folgt aus der Invarianz jedes Transformationsschrittes.'),
('theorem',@theorem_349_id,'axiom',@axiom_a5_id,'derives_from','Die Vergleichbarkeit konkretisiert reproduzierbare Organisationsmuster nach A5.'),
('theorem',@theorem_349_id,'definition',@def_3414_id,'depends_on','Der Satz vergleicht funktionale Entwicklungsbahnen.'),
('theorem',@theorem_349_id,'definition',@def_3418_id,'depends_on','Der Vergleich erfolgt über Invariantenmengen.'),
('equation',@eq_3102,'definition',@def_3417_id,'derives_from','Gleichung (3.102) formalisiert Def. 3.4.17.'),
('equation',@eq_3103,'definition',@def_3418_id,'derives_from','Gleichung (3.103) formalisiert Def. 3.4.18.'),
('equation',@eq_3104,'lemma',@lemma_347_id,'derives_from','Gleichung (3.104) formalisiert Lemma 3.4.7.'),
('equation',@eq_3105,'theorem',@theorem_349_id,'derives_from','Gleichung (3.105) formalisiert Satz 3.4.9.');

/* Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3102,@eq_3103,@eq_3104,@eq_3105);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3102,@eq_380,'depends_on','Die Invarianz verwendet die rekursive Transformation aus Gleichung (3.80).'),
(@eq_3102,@eq_384,'depends_on','Die Invariante wird auf Organisationsräumen nach Gleichung (3.84) ausgewertet.'),
(@eq_3103,@eq_3102,'derives_from','Die Invariantenmenge wird aus der Invarianzbedingung gebildet.'),
(@eq_3104,@eq_3102,'derives_from','Die Bahnkonstanz folgt durch wiederholte Anwendung der Invarianzbedingung.'),
(@eq_3104,@eq_395,'depends_on','Die Aussage wird entlang der Entwicklungsbahn aus Gleichung (3.95) formuliert.'),
(@eq_3105,@eq_3103,'depends_on','Die Äquivalenzklassifikation verwendet die Invariantenmengen.'),
(@eq_3105,@eq_395,'depends_on','Die verglichenen Objekte sind funktionale Entwicklungsbahnen.');

/* Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.9',
 'Abschnitt 3.4.9 wurde vollständig als mathematische Rekonstruktion funktionaler Invarianten neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.9.',
 'Def. 3.4.17, Def. 3.4.18, Lemma 3.4.7, Satz 3.4.9 und Gleichungen (3.102) bis (3.105).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.17–Def. 3.4.18',
 'Funktionale Invariante und Invariantenmenge wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.7',
 'Die Invarianz entlang funktionaler Entwicklungsbahnen wurde registriert.',NULL,'Bahninvarianz'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.9',
 'Die Invariantenäquivalenz wurde logisch präzisiert und registriert.',
 'Nicht explizit definierte allgemeine funktionale Äquivalenz.',
 'Äquivalenzrelation ~_I durch Gleichheit der Invariantenmengen.'),
(@revision_id,@section_id,'equation_added','equation','(3.102)–(3.105)',
 'Invarianzbedingung, Invariantenmenge, Bahnkonstanz und Invariantenäquivalenz wurden registriert.',
 NULL,'4 Gleichungen');

/* Zähler. */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.106'),
('next_definition_number','Def. 3.4.19'),
('next_lemma_number','Lemma 3.4.8'),
('next_theorem_number','Satz 3.4.10'),
('last_edited_section','3.4.9'),
('last_repository_revision','RKB-2026-07-13-K3.4.9-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen */
SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.9')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.17','Def. 3.4.18')
ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas`
WHERE `lemma_number`='Lemma 3.4.7';

SELECT `theorem_number`,`title`,`statement_latex`,`assumptions`,`validation_status`
FROM `theorems`
WHERE `theorem_number`='Satz 3.4.9';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.102','3.103','3.104','3.105')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_9`
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
