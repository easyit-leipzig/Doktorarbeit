USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.5
   Mathematische Rekonstruktion funktionaler Kohärenz

   Definitionen:
   - Def. 3.4.9  Funktionale Kohärenz
   - Def. 3.4.10 Kohärenzerhaltende Transformation

   Lemma:
   - Lemma 3.4.3 Rekursive Kohärenzerhaltung

   Satz:
   - Satz 3.4.5 Existenz kohärenter Organisationsräume

   Gleichungen:
   - (3.86) Kohärenzfunktion
   - (3.87) Kohärenzerhaltende Transformation
   - (3.88) Rekursive Kohärenzerhaltung
   - (3.89) Existenz kohärenter Organisationsräume

   Neue Quellen: keine
   Nächste Gleichung: (3.90)
   Nächste Definition: Def. 3.4.11
   Nächstes Lemma: Lemma 3.4.4
   Nächster Satz: Satz 3.4.6
   ============================================================ */

/* 1. Parent-Revision separat bestimmen, um MySQL #1093 zu vermeiden. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

/* 2. Revision anlegen bzw. wiederverwenden. */
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
    'RKB-2026-07-12-K3.4.5-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.5',
    '1.0',
    'Neufassung von Abschnitt 3.4.5 mit Def. 3.4.9, Def. 3.4.10, Lemma 3.4.3, Satz 3.4.5 sowie den Gleichungen (3.86) bis (3.89).',
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
    '3.4.5',
    'Mathematische Rekonstruktion funktionaler Kohärenz',
    3,
    3.5500,
    'review',
    1,
    'Rekonstruktion einer Kohärenzfunktion und kohärenzerhaltender Transformationen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code` = '3.4.5'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.5'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Mathematische Rekonstruktion funktionaler Kohärenz',
    `chapter_no` = 3,
    `section_order` = 3.5500,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Def. 3.4.9, Def. 3.4.10, Lemma 3.4.3, Satz 3.4.5 und die Gleichungen (3.86) bis (3.89).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1
WHERE `section_id` = @chapter_id;

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Abhängige Objekte ermitteln. */
SET @axiom_a4_id := (
    SELECT `axiom_id` FROM `axioms`
    WHERE `axiom_number` = 'A4' LIMIT 1
);

SET @def_347_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.7' LIMIT 1
);

SET @def_348_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.8' LIMIT 1
);

SET @def_349_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.9' LIMIT 1
);

SET @def_3410_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.10' LIMIT 1
);

SET @lemma_343_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.3' LIMIT 1
);

SET @theorem_345_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.5' LIMIT 1
);

/* 5. Definition 3.4.9 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Kohärenz',
    `definition_text` = 'Die funktionale Kohärenz eines funktionalen Organisationsraums ist ein normiertes Maß seiner strukturellen Erhaltung unter rekursiven funktionalen Transformationen.',
    `formal_latex` = '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]',
    `word_latex` = '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.8 gilt.',
    `notes` = 'Der Wert 1 bezeichnet maximale funktionale Kohärenz; der Wert 0 bezeichnet vollständigen Verlust funktionaler Organisation. Die konkrete Operationalisierung wird später festgelegt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_349_id;

INSERT INTO `definitions` (
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
SELECT
    'Def. 3.4.9',
    @section_id,
    'Funktionale Kohärenz',
    'Die funktionale Kohärenz eines funktionalen Organisationsraums ist ein normiertes Maß seiner strukturellen Erhaltung unter rekursiven funktionalen Transformationen.',
    '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]',
    '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]',
    'original',
    NULL,
    'Def. 3.4.8 gilt.',
    'Der Wert 1 bezeichnet maximale funktionale Kohärenz; der Wert 0 bezeichnet vollständigen Verlust funktionaler Organisation.',
    'checked',
    @revision_id
WHERE @def_349_id IS NULL;

SET @def_349_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.9' LIMIT 1
);

/* 6. Definition 3.4.10 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Kohärenzerhaltende Transformation',
    `definition_text` = 'Eine funktionale Transformation heißt kohärenzerhaltend, wenn sie den Kohärenzwert eines funktionalen Organisationsraums unverändert lässt.',
    `formal_latex` = '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    `word_latex` = '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.8 und Def. 3.4.9 gelten.',
    `notes` = 'Einzelne Zustände oder Relationen dürfen sich verändern; erhalten bleibt der globale Kohärenzwert.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3410_id;

INSERT INTO `definitions` (
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
SELECT
    'Def. 3.4.10',
    @section_id,
    'Kohärenzerhaltende Transformation',
    'Eine funktionale Transformation heißt kohärenzerhaltend, wenn sie den Kohärenzwert eines funktionalen Organisationsraums unverändert lässt.',
    '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    'original',
    NULL,
    'Def. 3.4.8 und Def. 3.4.9 gelten.',
    'Einzelne Zustände oder Relationen dürfen sich verändern; erhalten bleibt der globale Kohärenzwert.',
    'checked',
    @revision_id
WHERE @def_3410_id IS NULL;

SET @def_3410_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.10' LIMIT 1
);

/* 7. Lemma 3.4.3 aktualisieren oder anlegen. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Rekursive Kohärenzerhaltung',
    `statement_text` = 'Ist eine funktionale Transformation kohärenzerhaltend, dann bleibt der Kohärenzwert unter jeder endlichen Iteration dieser Transformation erhalten.',
    `statement_latex` = '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    `word_latex` = '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.10 gilt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_343_id;

INSERT INTO `lemmas` (
    `lemma_number`, `section_id`, `title`, `statement_text`,
    `statement_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `validation_status`, `created_revision_id`
)
SELECT
    'Lemma 3.4.3',
    @section_id,
    'Rekursive Kohärenzerhaltung',
    'Ist eine funktionale Transformation kohärenzerhaltend, dann bleibt der Kohärenzwert unter jeder endlichen Iteration dieser Transformation erhalten.',
    '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    'original',
    NULL,
    'Def. 3.4.10 gilt.',
    'checked',
    @revision_id
WHERE @lemma_343_id IS NULL;

SET @lemma_343_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.3' LIMIT 1
);

/* 8. Satz 3.4.5 aktualisieren oder anlegen. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Existenz kohärenter Organisationsräume',
    `statement_text` = 'Existiert für einen funktionalen Organisationsraum eine kohärenzerhaltende Transformation, dann besitzt dieser Organisationsraum einen wohldefinierten Kohärenzwert.',
    `statement_latex` = '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)',
    `word_latex` = '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.9 und Def. 3.4.10 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_345_id;

INSERT INTO `theorems` (
    `theorem_number`, `section_id`, `title`, `statement_text`,
    `statement_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `validation_status`, `created_revision_id`
)
SELECT
    'Satz 3.4.5',
    @section_id,
    'Existenz kohärenter Organisationsräume',
    'Existiert für einen funktionalen Organisationsraum eine kohärenzerhaltende Transformation, dann besitzt dieser Organisationsraum einen wohldefinierten Kohärenzwert.',
    '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)',
    '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)',
    'original',
    NULL,
    'Def. 3.4.9 und Def. 3.4.10 gelten.',
    'checked',
    @revision_id
WHERE @theorem_345_id IS NULL;

SET @theorem_345_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.5' LIMIT 1
);

/* 9. Alte Gleichungsbelegungen (3.86) bis (3.89) vollständig bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from` = 'equation' AND `object_id_from` IN (
        SELECT `equation_id` FROM `equations`
        WHERE `equation_number` IN ('3.86','3.87','3.88','3.89')
    ))
    OR
    (`object_type_to` = 'equation' AND `object_id_to` IN (
        SELECT `equation_id` FROM `equations`
        WHERE `equation_number` IN ('3.86','3.87','3.88','3.89')
    ));

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.86','3.87','3.88','3.89');

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.86','3.87','3.88','3.89');

DELETE es
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.86','3.87','3.88','3.89');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.86','3.87','3.88','3.89');

/* 10. Gleichungen neu einfügen. */
INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`, `equation_latex`,
    `word_latex`, `plain_description`, `equation_type`,
    `provenance`, `source_id`, `derivation`, `assumptions`,
    `validation_status`, `created_revision_id`
)
VALUES
(
    '3.86', @section_id, 'Funktionale Kohärenzfunktion',
    '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]',
    '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]',
    'Die Kohärenzfunktion ordnet jedem funktionalen Organisationsraum einen normierten Kohärenzwert zu.',
    'definition', 'original', NULL,
    'Formale Darstellung von Def. 3.4.9.',
    'Def. 3.4.8 gilt.',
    'checked', @revision_id
),
(
    '3.87', @section_id, 'Kohärenzerhaltende Transformation',
    '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    'Eine kohärenzerhaltende Transformation lässt den Kohärenzwert des Organisationsraums invariant.',
    'definition', 'original', NULL,
    'Formale Darstellung von Def. 3.4.10.',
    'Def. 3.4.9 gilt.',
    'checked', @revision_id
),
(
    '3.88', @section_id, 'Rekursive Kohärenzerhaltung',
    '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)',
    'Der Kohärenzwert bleibt unter jeder endlichen Iteration einer kohärenzerhaltenden Transformation unverändert.',
    'lemma', 'original', NULL,
    'Formale Darstellung von Lemma 3.4.3.',
    'Def. 3.4.10 gilt.',
    'checked', @revision_id
),
(
    '3.89', @section_id, 'Existenz kohärenter Organisationsräume',
    '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)',
    '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)',
    'Eine kohärenzerhaltende Transformation begründet einen wohldefinierten Kohärenzwert des Organisationsraums.',
    'theorem', 'original', NULL,
    'Formale Darstellung von Satz 3.4.5.',
    'Def. 3.4.9 und Def. 3.4.10 gelten.',
    'checked', @revision_id
);

SET @eq_386 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.86' LIMIT 1);
SET @eq_387 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.87' LIMIT 1);
SET @eq_388 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.88' LIMIT 1);
SET @eq_389 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.89' LIMIT 1);
SET @eq_384 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.84' LIMIT 1);
SET @eq_385 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.85' LIMIT 1);

/* 11. Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_386,@eq_387,@eq_388,@eq_389);

INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`, `definition_text`,
    `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_386,'\\kappa','Kohärenzfunktion','Normiertes Maß der funktionalen Geschlossenheit eines Organisationsraums.',NULL,'\\mathfrak{O}_F\\rightarrow[0,1]',1),
(@eq_386,'\\mathfrak{O}_F','funktionaler Organisationsraum','In Def. 3.4.8 definierter Organisationsraum.',NULL,'Organisationsraum',2),
(@eq_387,'\\mathcal{T}_F','kohärenzerhaltende Transformation','Transformation, die den Kohärenzwert invariant lässt.',NULL,'Abbildung',1),
(@eq_387,'\\kappa(\\mathfrak{O}_F)','Kohärenzwert','Kohärenzwert des funktionalen Organisationsraums.',NULL,'[0,1]',2),
(@eq_388,'n','Iterationszahl','Anzahl endlicher Anwendungen der Transformation.',NULL,'\\mathbb{N}',1),
(@eq_388,'\\mathcal{T}_F^{\\,n}','n-fache Transformation','n-fache Komposition der kohärenzerhaltenden Transformation.',NULL,'Abbildung',2),
(@eq_389,'\\exists','Existenzquantor','Kennzeichnet die Existenz einer kohärenzerhaltenden Transformation beziehungsweise eines Kohärenzwerts.',NULL,'Logik',1),
(@eq_389,'\\kappa(\\mathfrak{O}_F)','wohldefinierter Kohärenzwert','Dem Organisationsraum eindeutig zugeordneter Kohärenzwert.',NULL,'[0,1]',2)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 12. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from` IN (@def_349_id,@def_3410_id))
    OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_343_id)
    OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_345_id)
    OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_386,@eq_387,@eq_388,@eq_389));

INSERT INTO `object_dependencies` (
    `object_type_from`, `object_id_from`, `object_type_to`,
    `object_id_to`, `dependency_type`, `note`
)
VALUES
('definition',@def_349_id,'axiom',@axiom_a4_id,'derives_from','Funktionale Kohärenz konkretisiert stabile funktionale Organisation aus A4.'),
('definition',@def_349_id,'definition',@def_348_id,'depends_on','Die Kohärenzfunktion wird auf funktionalen Organisationsräumen definiert.'),
('definition',@def_3410_id,'definition',@def_349_id,'depends_on','Kohärenzerhaltung setzt die Kohärenzfunktion voraus.'),
('lemma',@lemma_343_id,'definition',@def_3410_id,'derives_from','Die rekursive Kohärenzerhaltung folgt aus der schrittweisen Kohärenzerhaltung.'),
('theorem',@theorem_345_id,'definition',@def_349_id,'depends_on','Der Satz setzt eine definierte Kohärenzfunktion voraus.'),
('theorem',@theorem_345_id,'definition',@def_3410_id,'depends_on','Der Satz setzt eine kohärenzerhaltende Transformation voraus.'),
('equation',@eq_386,'definition',@def_349_id,'derives_from','Gleichung (3.86) formalisiert Def. 3.4.9.'),
('equation',@eq_387,'definition',@def_3410_id,'derives_from','Gleichung (3.87) formalisiert Def. 3.4.10.'),
('equation',@eq_388,'lemma',@lemma_343_id,'derives_from','Gleichung (3.88) formalisiert Lemma 3.4.3.'),
('equation',@eq_389,'theorem',@theorem_345_id,'derives_from','Gleichung (3.89) formalisiert Satz 3.4.5.');

/* 13. Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_386,@eq_387,@eq_388,@eq_389);

INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@eq_386,@eq_384,'uses','Die Kohärenzfunktion wird auf dem in Gleichung (3.84) definierten Organisationsraum aufgebaut.'),
(@eq_387,@eq_386,'uses','Die Kohärenzerhaltung verwendet die in Gleichung (3.86) definierte Kohärenzfunktion.'),
(@eq_388,@eq_387,'derived_from','Die rekursive Kohärenzerhaltung folgt durch Iteration aus Gleichung (3.87).'),
(@eq_388,@eq_385,'uses','Die Aussage verwendet die rekursive Transformation aus Gleichung (3.85).'),
(@eq_389,@eq_387,'uses','Der Existenzsatz setzt eine kohärenzerhaltende Transformation voraus.'),
(@eq_389,@eq_386,'uses','Der Existenzsatz verwendet die Kohärenzfunktion.');

/* 14. Änderungsprotokoll. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.5',
 'Abschnitt 3.4.5 wurde vollständig als mathematische Rekonstruktion funktionaler Kohärenz neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.5.',
 'Def. 3.4.9, Def. 3.4.10, Lemma 3.4.3, Satz 3.4.5 und Gleichungen (3.86) bis (3.89).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.9–Def. 3.4.10',
 'Funktionale Kohärenz und kohärenzerhaltende Transformation wurden registriert.',
 NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.3',
 'Die rekursive Kohärenzerhaltung wurde registriert.',
 NULL,'Rekursive Kohärenzerhaltung'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.5',
 'Der Existenzsatz kohärenter Organisationsräume wurde registriert.',
 NULL,'Existenz kohärenter Organisationsräume'),
(@revision_id,@section_id,'equation_added','equation','(3.86)–(3.89)',
 'Die Kohärenzfunktion und ihre Erhaltung wurden formal registriert.',
 NULL,'4 Gleichungen');

/* 15. Repository-Zähler. */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.90'),
('next_definition_number','Def. 3.4.11'),
('next_lemma_number','Lemma 3.4.4'),
('next_theorem_number','Satz 3.4.6'),
('last_edited_section','3.4.5'),
('last_repository_revision','RKB-2026-07-12-K3.4.5-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN
   ============================================================ */

SELECT
    ds.`section_code`, ds.`title`, ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.5')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`, d.`title`, d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.9','Def. 3.4.10')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`, l.`title`, l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number`='Lemma 3.4.3';

SELECT
    t.`theorem_number`, t.`title`, t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number`='Satz 3.4.5';

SELECT
    e.`equation_number`, e.`title`, e.`equation_latex`,
    e.`word_latex`, e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.86','3.87','3.88','3.89')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    COUNT(*) AS `source_usages_in_3_4_5`
FROM `source_usage`
WHERE `section_id`=@section_id;

SELECT
    rc.`counter_key`, rc.`counter_value`
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
