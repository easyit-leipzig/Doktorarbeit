USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.2 – Relationen als mathematische Beschreibung
   struktureller Zusammenhänge

   Literatur:
   [27] Enderton – bereits vorhanden
   [28] Davey / Priestley – bereits vorhanden

   Gleichungen:
   (3.4) Relation zwischen zwei Mengen
   (3.5) Relation auf einer Menge
   (3.6) Relationsnotation
   (3.7) Reflexivität
   (3.8) Symmetrie
   (3.9) Transitivität

   Neue Literaturquellen: keine
   ============================================================ */

/* 1. Revision idempotent anlegen bzw. wiederverwenden. */
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
    'RKB-2026-07-12-K3.2.2-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.2',
    '1.0',
    'Neufassung von Abschnitt 3.2.2: Relationen als mathematische Beschreibung struktureller Zusammenhänge; Aktualisierung der Gleichungen (3.4) bis (3.9).',
    'Olaf Thiele / ChatGPT',
    (
        SELECT MAX(r.`revision_id`)
        FROM `repository_revisions` r
    )
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* 2. Abschnitts-ID ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.2'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Relationen als mathematische Beschreibung struktureller Zusammenhänge',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt verwendet die bestehenden Quellen [27] und [28] und enthält die Gleichungen (3.4) bis (3.9).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* 4. Quellenverwendungen des Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* [27] Enderton */
INSERT INTO `source_usage` (
    `source_id`,
    `section_id`,
    `usage_type`,
    `claim_summary`,
    `exact_location`,
    `is_first_mention`,
    `citation_checked`,
    `notes`,
    `created_revision_id`
)
SELECT
    s.`source_id`,
    @section_id,
    'state_of_research',
    'Enderton dient als Referenz für den mengentheoretischen Relationsbegriff und seine formale Einbettung in kartesische Produkte.',
    'Abschnitt 3.2.2',
    0,
    1,
    'Wiederverwendung einer bereits im Repository vorhandenen Quelle.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 27;

/* [28] Davey / Priestley */
INSERT INTO `source_usage` (
    `source_id`,
    `section_id`,
    `usage_type`,
    `claim_summary`,
    `exact_location`,
    `is_first_mention`,
    `citation_checked`,
    `notes`,
    `created_revision_id`
)
SELECT
    s.`source_id`,
    @section_id,
    'state_of_research',
    'Davey und Priestley dienen als Referenz für Ordnungsrelationen, Äquivalenzrelationen und strukturierte relationale Systeme.',
    'Abschnitt 3.2.2',
    0,
    1,
    'Wiederverwendung einer bereits im Repository vorhandenen Quelle.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 28;

/* 5. Quellen-ID für Gleichungen bestimmen. */
SET @source_27_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 27
    LIMIT 1
);

/* 6. Gleichungen (3.4) bis (3.9) aktualisieren oder ergänzen. */

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Relation zwischen zwei Mengen',
    `equation_latex` = 'R\\subseteq A\\times B',
    `word_latex` = 'R\\subseteq A\\times B',
    `plain_description` = 'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge ihres kartesischen Produkts.',
    `equation_type` = 'definition',
    `provenance` = 'literature',
    `source_id` = @source_27_id,
    `derivation` = NULL,
    `assumptions` = 'A und B sind Mengen; A\\times B ist ihr kartesisches Produkt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.4';

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.4', @section_id, 'Relation zwischen zwei Mengen',
    'R\\subseteq A\\times B',
    'R\\subseteq A\\times B',
    'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge ihres kartesischen Produkts.',
    'definition', 'literature', @source_27_id,
    NULL, 'A und B sind Mengen; A\\times B ist ihr kartesisches Produkt.',
    'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.4'
);

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Relation auf einer Menge',
    `equation_latex` = 'R\\subseteq A\\times A',
    `word_latex` = 'R\\subseteq A\\times A',
    `plain_description` = 'Eine binäre Relation auf A ist eine Teilmenge des kartesischen Produkts A mal A.',
    `equation_type` = 'definition',
    `provenance` = 'literature',
    `source_id` = @source_27_id,
    `derivation` = NULL,
    `assumptions` = 'A ist eine Menge.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.5';

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.5', @section_id, 'Relation auf einer Menge',
    'R\\subseteq A\\times A',
    'R\\subseteq A\\times A',
    'Eine binäre Relation auf A ist eine Teilmenge des kartesischen Produkts A mal A.',
    'definition', 'literature', @source_27_id,
    NULL, 'A ist eine Menge.',
    'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.5'
);

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Relationsnotation',
    `equation_latex` = 'aRb\\Longleftrightarrow(a,b)\\in R',
    `word_latex` = 'aRb\\Longleftrightarrow(a,b)\\in R',
    `plain_description` = 'Die Schreibweise aRb ist äquivalent dazu, dass das geordnete Paar (a,b) Element der Relation R ist.',
    `equation_type` = 'definition',
    `provenance` = 'literature',
    `source_id` = @source_27_id,
    `derivation` = NULL,
    `assumptions` = 'a und b gehören zu den für R zulässigen Grundmengen.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.6';

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.6', @section_id, 'Relationsnotation',
    'aRb\\Longleftrightarrow(a,b)\\in R',
    'aRb\\Longleftrightarrow(a,b)\\in R',
    'Die Schreibweise aRb ist äquivalent dazu, dass das geordnete Paar (a,b) Element der Relation R ist.',
    'definition', 'literature', @source_27_id,
    NULL, 'a und b gehören zu den für R zulässigen Grundmengen.',
    'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.6'
);

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Reflexivität einer Relation',
    `equation_latex` = '\\forall a\\in A:\\;aRa',
    `word_latex` = '\\forall a\\in A:\\;aRa',
    `plain_description` = 'Eine Relation R auf A ist reflexiv, wenn jedes Element von A zu sich selbst in Relation steht.',
    `equation_type` = 'property',
    `provenance` = 'literature',
    `source_id` = @source_27_id,
    `derivation` = NULL,
    `assumptions` = 'R ist eine Relation auf A.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.7';

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.7', @section_id, 'Reflexivität einer Relation',
    '\\forall a\\in A:\\;aRa',
    '\\forall a\\in A:\\;aRa',
    'Eine Relation R auf A ist reflexiv, wenn jedes Element von A zu sich selbst in Relation steht.',
    'property', 'literature', @source_27_id,
    NULL, 'R ist eine Relation auf A.',
    'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.7'
);

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Symmetrie einer Relation',
    `equation_latex` = '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa',
    `word_latex` = '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa',
    `plain_description` = 'Eine Relation R auf A ist symmetrisch, wenn aus aRb stets bRa folgt.',
    `equation_type` = 'property',
    `provenance` = 'literature',
    `source_id` = @source_27_id,
    `derivation` = NULL,
    `assumptions` = 'R ist eine Relation auf A.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.8';

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.8', @section_id, 'Symmetrie einer Relation',
    '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa',
    '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa',
    'Eine Relation R auf A ist symmetrisch, wenn aus aRb stets bRa folgt.',
    'property', 'literature', @source_27_id,
    NULL, 'R ist eine Relation auf A.',
    'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.8'
);

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Transitivität einer Relation',
    `equation_latex` = '\\forall a,b,c\\in A:\\;(aRb\\land bRc)\\Longrightarrow aRc',
    `word_latex` = '\\forall a,b,c\\in A:\\;(aRb\\land bRc)\\Longrightarrow aRc',
    `plain_description` = 'Eine Relation R auf A ist transitiv, wenn aus aRb und bRc stets aRc folgt.',
    `equation_type` = 'property',
    `provenance` = 'literature',
    `source_id` = @source_27_id,
    `derivation` = NULL,
    `assumptions` = 'R ist eine Relation auf A.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.9';

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.9', @section_id, 'Transitivität einer Relation',
    '\\forall a,b,c\\in A:\\;(aRb\\land bRc)\\Longrightarrow aRc',
    '\\forall a,b,c\\in A:\\;(aRb\\land bRc)\\Longrightarrow aRc',
    'Eine Relation R auf A ist transitiv, wenn aus aRb und bRc stets aRc folgt.',
    'property', 'literature', @source_27_id,
    NULL, 'R ist eine Relation auf A.',
    'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.9'
);

/* 7. Symbolzuordnungen für (3.4) bis (3.9) neu aufbauen. */
DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.4','3.5','3.6','3.7','3.8','3.9');

SET @eq_3_4 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.4' LIMIT 1);
SET @eq_3_5 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.5' LIMIT 1);
SET @eq_3_6 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.6' LIMIT 1);
SET @eq_3_7 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.7' LIMIT 1);
SET @eq_3_8 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.8' LIMIT 1);
SET @eq_3_9 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.9' LIMIT 1);

INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_3_4, 'R', 'Relation', 'Binäre Relation zwischen den Mengen A und B.', NULL, 'R\\subseteq A\\times B', 1),
(@eq_3_4, 'A', 'Ausgangsmenge', 'Erste Grundmenge der Relation.', NULL, 'Menge', 2),
(@eq_3_4, 'B', 'Zielmenge', 'Zweite Grundmenge der Relation.', NULL, 'Menge', 3),
(@eq_3_5, 'R', 'Relation', 'Binäre Relation auf der Menge A.', NULL, 'R\\subseteq A\\times A', 1),
(@eq_3_5, 'A', 'Grundmenge', 'Grundmenge der Relation.', NULL, 'Menge', 2),
(@eq_3_6, 'a', 'erstes Element', 'Erstes Element des geordneten Paares.', NULL, 'a\\in A', 1),
(@eq_3_6, 'b', 'zweites Element', 'Zweites Element des geordneten Paares.', NULL, 'b\\in B', 2),
(@eq_3_6, 'R', 'Relation', 'Relation, der das geordnete Paar angehört.', NULL, 'Relation', 3),
(@eq_3_7, 'R', 'reflexive Relation', 'Relation, in der jedes Element zu sich selbst in Beziehung steht.', NULL, 'R\\subseteq A\\times A', 1),
(@eq_3_7, 'A', 'Grundmenge', 'Grundmenge der reflexiven Relation.', NULL, 'Menge', 2),
(@eq_3_8, 'R', 'symmetrische Relation', 'Relation, deren Beziehungen in beide Richtungen gelten.', NULL, 'R\\subseteq A\\times A', 1),
(@eq_3_8, 'A', 'Grundmenge', 'Grundmenge der symmetrischen Relation.', NULL, 'Menge', 2),
(@eq_3_9, 'R', 'transitive Relation', 'Relation, deren verkettete Beziehungen transitiv abgeschlossen sind.', NULL, 'R\\subseteq A\\times A', 1),
(@eq_3_9, 'A', 'Grundmenge', 'Grundmenge der transitiven Relation.', NULL, 'Menge', 2);

/* 8. Änderungsprotokoll idempotent aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.2.2',
    'Abschnitt 3.2.2 wurde vollständig neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.2.2.',
    'Neufassung mit zwei Quellenverwendungen und sechs Gleichungen.'
),
(
    @revision_id, @section_id, 'source_reused', 'sources', '[27], [28]',
    'Die bestehenden Quellen Enderton sowie Davey und Priestley wurden erneut verwendet.',
    NULL,
    '2 Quellenverwendungen'
),
(
    @revision_id, @section_id, 'equation_changed', 'equations', '(3.4)–(3.9)',
    'Die Relationsdefinitionen und Relationseigenschaften wurden neu geordnet und inhaltlich aktualisiert.',
    'Bisherige Gleichungsfassungen des Repository.',
    'Relation, Relation auf einer Menge, Relationsnotation, Reflexivität, Symmetrie und Transitivität.'
);

/* 9. Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.10'),
    ('last_edited_section', '3.2.2'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.2-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* 10. Kontrollabfragen.
   Erwartet:
   - Abschnitt 3.2.2: review
   - 2 Quellenverwendungen: [27], [28]
   - 0 Erstnennungen
   - 6 Gleichungen: (3.4) bis (3.9)
   - next_citation_number = 59
   - next_equation_number = 3.10
*/
SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.2')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`),0) AS `first_mentions_in_section`,
    GROUP_CONCAT(s.`citation_number` ORDER BY s.`citation_number` SEPARATOR ', ') AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

SELECT
    e.`equation_number`,
    e.`title`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`section_id` = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY `counter_key`;
