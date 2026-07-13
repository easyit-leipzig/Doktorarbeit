USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.15
   Topologie funktionaler Organisationsräume

   Definitionen:
   - Def. 3.4.28 Funktionale offene Umgebung
   - Def. 3.4.29 Funktionale Topologie

   Lemma:
   - Lemma 3.4.13 Offene Kugeln bilden eine Basis

   Satz:
   - Satz 3.4.15 Die funktionale Metrik erzeugt eine Topologie

   Gleichungen:
   - (3.132) Funktionale offene Umgebung
   - (3.133) Funktionale Topologie
   - (3.134) Metrik erzeugt Topologie
   - (3.135) Funktionale Konvergenz
   - (3.136) Funktionale Stetigkeit

   Neue Quellen: keine

   Nächste Gleichung:   (3.137)
   Nächste Definition:  Def. 3.4.30
   Nächstes Lemma:      Lemma 3.4.14
   Nächster Satz:       Satz 3.4.16
   ============================================================ */

/* 1. Parent-Revision separat bestimmen, um MySQL #1093 zu vermeiden. */
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
    'RKB-2026-07-13-K3.4.15-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.15',
    '1.0',
    'Neufassung von Abschnitt 3.4.15 mit Def. 3.4.28, Def. 3.4.29, Lemma 3.4.13, Satz 3.4.15 und den Gleichungen (3.132) bis (3.136).',
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
    '3.4.15',
    'Topologie funktionaler Organisationsräume',
    3,
    3.5960,
    'review',
    1,
    'Rekonstruktion einer durch die funktionale Metrik erzeugten Topologie einschließlich Konvergenz und Stetigkeit.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code` = '3.4.15'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.15'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Topologie funktionaler Organisationsräume',
    `chapter_no` = 3,
    `section_order` = 3.5960,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.28, Def. 3.4.29, Lemma 3.4.13, Satz 3.4.15 und die Gleichungen (3.132) bis (3.136).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1
WHERE `section_id` = @chapter_id;

/* Abschnitt 3.4.15 führt keine neue Literaturverwendung ein. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Vorgänger- und Zielobjekte ermitteln. */
SET @def_3427_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.27'
    LIMIT 1
);

SET @def_3428_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.28'
    LIMIT 1
);

SET @def_3429_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.29'
    LIMIT 1
);

SET @lemma_3413_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.13'
    LIMIT 1
);

SET @theorem_3415_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.15'
    LIMIT 1
);

/* 5. Def. 3.4.28 – Funktionale offene Umgebung. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale offene Umgebung',
    `definition_text` = 'Für eine funktionale Quotientenklasse A und einen Radius epsilon größer null ist die funktionale offene Umgebung die Menge aller Quotientenklassen mit funktionalem Abstand kleiner epsilon zu A.',
    `formal_latex` = 'U_{\\varepsilon}(A)=\\left\\{B\\in\\mathfrak{Q}_F\\mid d_F(A,B)<\\varepsilon\\right\\}',
    `word_latex` = 'U_{\\varepsilon}(A)=\\left\\{B\\in\\mathfrak{Q}_F\\mid d_F(A,B)<\\varepsilon\\right\\}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.27 und Satz 3.4.14 gelten; epsilon ist positiv.',
    `notes` = 'Die offene Umgebung wird durch die funktionale Metrik auf der Quotientenstruktur erzeugt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3428_id;

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
    'Def. 3.4.28',
    @section_id,
    'Funktionale offene Umgebung',
    'Für eine funktionale Quotientenklasse A und einen Radius epsilon größer null ist die funktionale offene Umgebung die Menge aller Quotientenklassen mit funktionalem Abstand kleiner epsilon zu A.',
    'U_{\\varepsilon}(A)=\\left\\{B\\in\\mathfrak{Q}_F\\mid d_F(A,B)<\\varepsilon\\right\\}',
    'U_{\\varepsilon}(A)=\\left\\{B\\in\\mathfrak{Q}_F\\mid d_F(A,B)<\\varepsilon\\right\\}',
    'original',
    NULL,
    'Def. 3.4.27 und Satz 3.4.14 gelten; epsilon ist positiv.',
    'Die offene Umgebung wird durch die funktionale Metrik auf der Quotientenstruktur erzeugt.',
    'checked',
    @revision_id
WHERE @def_3428_id IS NULL;

SET @def_3428_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.28'
    LIMIT 1
);

/* 6. Def. 3.4.29 – Funktionale Topologie. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Topologie',
    `definition_text` = 'Die funktionale Topologie ist die durch alle Vereinigungen funktionaler offener Umgebungen erzeugte Teilmenge der Potenzmenge der funktionalen Quotientenstruktur.',
    `formal_latex` = '\\mathcal{T}_F\\subseteq\\mathcal{P}(\\mathfrak{Q}_F)',
    `word_latex` = '\\mathcal{T}_F\\subseteq\\mathcal{P}(\\mathfrak{Q}_F)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.28 gilt.',
    `notes` = 'Die Topologie enthält die leere Menge und den gesamten Raum, ist unter beliebigen Vereinigungen und endlichen Schnitten abgeschlossen.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3429_id;

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
    'Def. 3.4.29',
    @section_id,
    'Funktionale Topologie',
    'Die funktionale Topologie ist die durch alle Vereinigungen funktionaler offener Umgebungen erzeugte Teilmenge der Potenzmenge der funktionalen Quotientenstruktur.',
    '\\mathcal{T}_F\\subseteq\\mathcal{P}(\\mathfrak{Q}_F)',
    '\\mathcal{T}_F\\subseteq\\mathcal{P}(\\mathfrak{Q}_F)',
    'original',
    NULL,
    'Def. 3.4.28 gilt.',
    'Die Topologie enthält die leere Menge und den gesamten Raum, ist unter beliebigen Vereinigungen und endlichen Schnitten abgeschlossen.',
    'checked',
    @revision_id
WHERE @def_3429_id IS NULL;

SET @def_3429_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.29'
    LIMIT 1
);

/* 7. Lemma 3.4.13 – Offene Kugeln bilden eine Basis. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Offene Kugeln bilden eine Basis',
    `statement_text` = 'Die durch die funktionale Metrik erzeugten offenen Umgebungen bilden eine Basis der funktionalen Topologie.',
    `statement_latex` = '\\mathcal{B}_F=\\left\\{U_{\\varepsilon}(A)\\mid A\\in\\mathfrak{Q}_F,\\;\\varepsilon>0\\right\\}',
    `word_latex` = '\\mathcal{B}_F=\\left\\{U_{\\varepsilon}(A)\\mid A\\in\\mathfrak{Q}_F,\\;\\varepsilon>0\\right\\}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.27 bis Def. 3.4.29 gelten; die Dreiecksungleichung ist erfüllt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_3413_id;

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
    'Lemma 3.4.13',
    @section_id,
    'Offene Kugeln bilden eine Basis',
    'Die durch die funktionale Metrik erzeugten offenen Umgebungen bilden eine Basis der funktionalen Topologie.',
    '\\mathcal{B}_F=\\left\\{U_{\\varepsilon}(A)\\mid A\\in\\mathfrak{Q}_F,\\;\\varepsilon>0\\right\\}',
    '\\mathcal{B}_F=\\left\\{U_{\\varepsilon}(A)\\mid A\\in\\mathfrak{Q}_F,\\;\\varepsilon>0\\right\\}',
    'original',
    NULL,
    'Def. 3.4.27 bis Def. 3.4.29 gelten; die Dreiecksungleichung ist erfüllt.',
    'checked',
    @revision_id
WHERE @lemma_3413_id IS NULL;

SET @lemma_3413_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.13'
    LIMIT 1
);

/* 8. Satz 3.4.15 – Metrik erzeugt Topologie. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Die funktionale Metrik erzeugt eine Topologie',
    `statement_text` = 'Jede funktionale Metrik auf der funktionalen Quotientenstruktur erzeugt über ihre offenen Kugeln eindeutig eine funktionale Topologie.',
    `statement_latex` = 'd_F\\Longrightarrow\\mathcal{T}_F',
    `word_latex` = 'd_F\\Longrightarrow\\mathcal{T}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.27 bis Def. 3.4.29 und Lemma 3.4.13 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_3415_id;

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
    'Satz 3.4.15',
    @section_id,
    'Die funktionale Metrik erzeugt eine Topologie',
    'Jede funktionale Metrik auf der funktionalen Quotientenstruktur erzeugt über ihre offenen Kugeln eindeutig eine funktionale Topologie.',
    'd_F\\Longrightarrow\\mathcal{T}_F',
    'd_F\\Longrightarrow\\mathcal{T}_F',
    'original',
    NULL,
    'Def. 3.4.27 bis Def. 3.4.29 und Lemma 3.4.13 gelten.',
    'checked',
    @revision_id
WHERE @theorem_3415_id IS NULL;

SET @theorem_3415_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.15'
    LIMIT 1
);

/* 9. Alte Gleichungen und abhängige Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from` = 'equation' AND `object_id_from` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.132','3.133','3.134','3.135','3.136')
    ))
    OR
    (`object_type_to` = 'equation' AND `object_id_to` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.132','3.133','3.134','3.135','3.136')
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.132','3.133','3.134','3.135','3.136');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.132','3.133','3.134','3.135','3.136');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.132','3.133','3.134','3.135','3.136');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.132','3.133','3.134','3.135','3.136');

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
    '3.132',
    @section_id,
    'Funktionale offene Umgebung',
    'U_{\\varepsilon}(A)=\\left\\{B\\in\\mathfrak{Q}_F\\mid d_F(A,B)<\\varepsilon\\right\\}',
    'U_{\\varepsilon}(A)=\\left\\{B\\in\\mathfrak{Q}_F\\mid d_F(A,B)<\\varepsilon\\right\\}',
    'Die funktionale offene Umgebung enthält alle Quotientenklassen mit Abstand kleiner epsilon zu A.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.28.',
    'Def. 3.4.27 gilt; epsilon ist positiv.',
    'checked',
    @revision_id
),
(
    '3.133',
    @section_id,
    'Funktionale Topologie',
    '\\mathcal{T}_F\\subseteq\\mathcal{P}(\\mathfrak{Q}_F)',
    '\\mathcal{T}_F\\subseteq\\mathcal{P}(\\mathfrak{Q}_F)',
    'Die funktionale Topologie ist eine Familie offener Teilmengen der funktionalen Quotientenstruktur.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.29.',
    'Def. 3.4.28 gilt.',
    'checked',
    @revision_id
),
(
    '3.134',
    @section_id,
    'Metrik erzeugt Topologie',
    'd_F\\Longrightarrow\\mathcal{T}_F',
    'd_F\\Longrightarrow\\mathcal{T}_F',
    'Die funktionale Metrik erzeugt über ihre offenen Kugeln eine funktionale Topologie.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.15.',
    'Def. 3.4.27 bis Def. 3.4.29 gelten.',
    'checked',
    @revision_id
),
(
    '3.135',
    @section_id,
    'Funktionale Konvergenz',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;n\\ge N\\Longrightarrow d_F(A_n,A)<\\varepsilon',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;n\\ge N\\Longrightarrow d_F(A_n,A)<\\varepsilon',
    'Eine Folge funktionaler Quotientenklassen konvergiert gegen A, wenn sie schließlich in jeder offenen Umgebung von A liegt.',
    'definition',
    'original',
    NULL,
    'Metrische Konvergenz auf dem funktionalen metrischen Raum.',
    'Satz 3.4.14 gilt.',
    'checked',
    @revision_id
),
(
    '3.136',
    @section_id,
    'Funktionale Stetigkeit',
    'A_n\\rightarrow A\\Longrightarrow F(A_n)\\rightarrow F(A)',
    'A_n\\rightarrow A\\Longrightarrow F(A_n)\\rightarrow F(A)',
    'Eine Abbildung ist funktional stetig, wenn sie konvergente Folgen in konvergente Bildfolgen überführt.',
    'definition',
    'original',
    NULL,
    'Folgencharakterisierung funktionaler Stetigkeit.',
    'Quell- und Zielraum sind funktionale metrische Räume.',
    'checked',
    @revision_id
);

SET @eq_3132 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.132' LIMIT 1);
SET @eq_3133 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.133' LIMIT 1);
SET @eq_3134 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.134' LIMIT 1);
SET @eq_3135 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.135' LIMIT 1);
SET @eq_3136 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.136' LIMIT 1);
SET @eq_3126 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.126' LIMIT 1);
SET @eq_3130 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.130' LIMIT 1);
SET @eq_3131 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.131' LIMIT 1);

/* 11. Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3132,@eq_3133,@eq_3134,@eq_3135,@eq_3136);

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
(@eq_3132,'U_{\\varepsilon}(A)','funktionale offene Umgebung','Offene Kugel um A mit Radius epsilon.',NULL,'Teilmenge von \\mathfrak{Q}_F',1),
(@eq_3132,'\\varepsilon','Umgebungsradius','Positiver Radius der funktionalen offenen Umgebung.',NULL,'\\mathbb{R}_{>0}',2),
(@eq_3132,'d_F','funktionale Metrik','Abstandsfunktion auf der funktionalen Quotientenstruktur.',NULL,'Metrik',3),
(@eq_3133,'\\mathcal{T}_F','funktionale Topologie','Familie aller funktional offenen Mengen.',NULL,'Teilmenge von \\mathcal{P}(\\mathfrak{Q}_F)',1),
(@eq_3133,'\\mathcal{P}(\\mathfrak{Q}_F)','Potenzmenge','Menge aller Teilmengen der funktionalen Quotientenstruktur.',NULL,'Menge',2),
(@eq_3134,'d_F\\Longrightarrow\\mathcal{T}_F','Topologieinduktion','Zuordnung der von der Metrik erzeugten Topologie.',NULL,'strukturelle Folgerung',1),
(@eq_3135,'A_n','Folge funktionaler Quotientenklassen','n-tes Element einer Folge in der funktionalen Quotientenstruktur.',NULL,'A_n\\in\\mathfrak{Q}_F',1),
(@eq_3135,'N','Konvergenzindex','Index, ab dem die Folge innerhalb der vorgegebenen Umgebung liegt.',NULL,'\\mathbb{N}',2),
(@eq_3136,'F','funktional stetige Abbildung','Abbildung zwischen funktionalen metrischen Räumen.',NULL,'Abbildung',1)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 12. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from` IN (@def_3428_id,@def_3429_id))
    OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3413_id)
    OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3415_id)
    OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3132,@eq_3133,@eq_3134,@eq_3135,@eq_3136));

INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
('definition',@def_3428_id,'definition',@def_3427_id,'depends_on','Die offene Umgebung wird durch die funktionale Metrik definiert.'),
('definition',@def_3429_id,'definition',@def_3428_id,'depends_on','Die funktionale Topologie wird aus funktionalen offenen Umgebungen erzeugt.'),
('lemma',@lemma_3413_id,'definition',@def_3428_id,'depends_on','Das Basislemma verwendet die funktionalen offenen Umgebungen.'),
('lemma',@lemma_3413_id,'definition',@def_3429_id,'depends_on','Die offenen Kugeln bilden eine Basis der funktionalen Topologie.'),
('theorem',@theorem_3415_id,'definition',@def_3427_id,'depends_on','Der Satz setzt die funktionale Metrik voraus.'),
('theorem',@theorem_3415_id,'definition',@def_3429_id,'depends_on','Der Satz bestimmt die durch die Metrik erzeugte Topologie.'),
('theorem',@theorem_3415_id,'lemma',@lemma_3413_id,'derives_from','Die Topologieerzeugung folgt aus der Basiseigenschaft offener Kugeln.'),
('equation',@eq_3132,'definition',@def_3428_id,'derives_from','Gleichung (3.132) formalisiert Def. 3.4.28.'),
('equation',@eq_3133,'definition',@def_3429_id,'derives_from','Gleichung (3.133) formalisiert Def. 3.4.29.'),
('equation',@eq_3134,'theorem',@theorem_3415_id,'derives_from','Gleichung (3.134) formalisiert Satz 3.4.15.');

/* 13. Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3132,@eq_3133,@eq_3134,@eq_3135,@eq_3136);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(@eq_3132,@eq_3126,'depends_on','Die offene Umgebung verwendet die funktionale Metrik aus Gleichung (3.126).'),
(@eq_3133,@eq_3132,'derives_from','Die funktionale Topologie wird durch Vereinigungen offener Umgebungen erzeugt.'),
(@eq_3134,@eq_3132,'depends_on','Die Topologieinduktion verwendet offene Kugeln.'),
(@eq_3134,@eq_3133,'derives_from','Die erzeugte Struktur ist die funktionale Topologie.'),
(@eq_3134,@eq_3130,'depends_on','Die Basiseigenschaft der offenen Kugeln verwendet die Dreiecksungleichung.'),
(@eq_3135,@eq_3126,'depends_on','Funktionale Konvergenz wird durch die funktionale Metrik definiert.'),
(@eq_3135,@eq_3132,'depends_on','Die Konvergenzbedingung entspricht dem schließlichen Eintritt in jede offene Umgebung.'),
(@eq_3136,@eq_3135,'depends_on','Die Folgenstetigkeit verwendet die funktionale Konvergenz.'),
(@eq_3136,@eq_3131,'depends_on','Quell- und Zielraum sind funktionale metrische Räume.');

/* 14. Änderungsprotokoll. */
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
    @revision_id,@section_id,'rewritten','section','3.4.15',
    'Abschnitt 3.4.15 wurde vollständig als Topologie funktionaler Organisationsräume neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.15.',
    'Def. 3.4.28, Def. 3.4.29, Lemma 3.4.13, Satz 3.4.15 und Gleichungen (3.132) bis (3.136).'
),
(
    @revision_id,@section_id,'definition_added','definition','Def. 3.4.28–Def. 3.4.29',
    'Funktionale offene Umgebung und funktionale Topologie wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,@section_id,'statement_added','lemma','Lemma 3.4.13',
    'Die Basiseigenschaft funktionaler offener Kugeln wurde registriert.',
    NULL,
    'Offene Kugeln bilden eine Basis'
),
(
    @revision_id,@section_id,'statement_added','theorem','Satz 3.4.15',
    'Die Erzeugung einer funktionalen Topologie durch die funktionale Metrik wurde registriert.',
    NULL,
    'Metrikinduzierte funktionale Topologie'
),
(
    @revision_id,@section_id,'equation_added','equation','(3.132)–(3.136)',
    'Offene Umgebung, Topologie, Topologieinduktion, Konvergenz und Stetigkeit wurden formal registriert.',
    NULL,
    '5 Gleichungen'
);

/* 15. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
('next_equation_number','3.137'),
('next_definition_number','Def. 3.4.30'),
('next_lemma_number','Lemma 3.4.14'),
('next_theorem_number','Satz 3.4.16'),
('last_edited_section','3.4.15'),
('last_repository_revision','RKB-2026-07-13-K3.4.15-NEUFASSUNG-V1')
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
WHERE ds.`section_code` IN ('3.4','3.4.15')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.28','Def. 3.4.29')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number` = 'Lemma 3.4.13';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.15';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.132','3.133','3.134','3.135','3.136')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.132','3.133','3.134','3.135','3.136')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT COUNT(*) AS `source_usages_in_3_4_15`
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
