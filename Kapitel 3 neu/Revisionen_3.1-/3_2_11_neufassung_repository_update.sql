USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.11
   Metriken und Ähnlichkeitsmaße als Grundlage funktionaler Distanz

   Repository-konsistente Quellen:
   [49] Burago / Burago / Ivanov – Erstnennung
   [50] Manning / Raghavan / Schütze – Erstnennung

   Gleichungen:
   (3.52) Metrik
   (3.53) Nichtnegativität und Definitheit
   (3.54) Symmetrie
   (3.55) Dreiecksungleichung
   (3.56) Euklidische Distanz
   (3.57) Kosinusähnlichkeit

   Neue Quellen: keine
   Nächste freie Literaturnummer bleibt [59].
   ============================================================ */

/* 1. Revision idempotent anlegen oder wiederverwenden. */
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
    'RKB-2026-07-12-K3.2.11-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.11',
    '1.0',
    'Neufassung von Abschnitt 3.2.11 mit den Quellen [49] und [50] sowie den Gleichungen (3.52) bis (3.57).',
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
    WHERE ds.`section_code` = '3.2.11'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Metriken und Ähnlichkeitsmaße als Grundlage funktionaler Distanz',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [49] und [50] und enthält die Gleichungen (3.52) bis (3.57).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* 4. Quellenverwendungen vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* [49] Burago / Burago / Ivanov */
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
    'first_citation',
    'Burago, Burago und Ivanov dienen als Hauptreferenz für metrische Räume, Metrikaxiome und geometrische Distanzstrukturen.',
    'Abschnitt 3.2.11',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [49].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 49;

/* [50] Manning / Raghavan / Schütze */
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
    'first_citation',
    'Manning, Raghavan und Schütze dienen als Referenz für Vektorraummodelle und Kosinusähnlichkeit im Information Retrieval.',
    'Abschnitt 3.2.11',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [50].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 50;

/* 5. Quellen-IDs bestimmen. */
SET @source_49_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 49
    LIMIT 1
);

SET @source_50_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 50
    LIMIT 1
);

/* 6. Alte Belegungen der Gleichungsnummern (3.52) bis (3.57) vollständig bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.52','3.53','3.54','3.55','3.56','3.57');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.52','3.53','3.54','3.55','3.56','3.57');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.52','3.53','3.54','3.55','3.56','3.57');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.52','3.53','3.54','3.55','3.56','3.57');

/* 7. Gleichungen der Neufassung einfügen. */
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
    '3.52',
    @section_id,
    'Metrik',
    'd:X\\times X\\rightarrow\\mathbb{R}_{\\ge0}',
    'd:X\\times X\\rightarrow\\mathbb{R}_{\\ge0}',
    'Eine Metrik ordnet jedem geordneten Paar von Zuständen eine nichtnegative reelle Distanz zu.',
    'definition',
    'literature',
    @source_49_id,
    NULL,
    'X ist eine nichtleere Menge.',
    'checked',
    @revision_id
),
(
    '3.53',
    @section_id,
    'Nichtnegativität und Definitheit',
    'd(x,y)\\ge0,\\qquad d(x,y)=0\\Longleftrightarrow x=y',
    'd(x,y)\\ge0,\\qquad d(x,y)=0\\Longleftrightarrow x=y',
    'Eine Metrik ist nichtnegativ und verschwindet genau für identische Elemente.',
    'definition',
    'literature',
    @source_49_id,
    NULL,
    'x,y\\in X und d ist eine Metrik auf X.',
    'checked',
    @revision_id
),
(
    '3.54',
    @section_id,
    'Symmetrie einer Metrik',
    'd(x,y)=d(y,x)',
    'd(x,y)=d(y,x)',
    'Der Abstand zweier Elemente ist unabhängig von der Reihenfolge seiner Argumente.',
    'definition',
    'literature',
    @source_49_id,
    NULL,
    'x,y\\in X und d ist eine Metrik auf X.',
    'checked',
    @revision_id
),
(
    '3.55',
    @section_id,
    'Dreiecksungleichung',
    'd(x,z)\\le d(x,y)+d(y,z)',
    'd(x,z)\\le d(x,y)+d(y,z)',
    'Der direkte Abstand zweier Elemente ist nicht größer als der Weg über ein drittes Element.',
    'definition',
    'literature',
    @source_49_id,
    NULL,
    'x,y,z\\in X und d ist eine Metrik auf X.',
    'checked',
    @revision_id
),
(
    '3.56',
    @section_id,
    'Euklidische Distanz',
    'd_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}',
    'd_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}',
    'Die euklidische Distanz misst den geometrischen Abstand zweier Vektoren im n-dimensionalen Raum.',
    'metric',
    'literature',
    @source_49_id,
    NULL,
    'x,y\\in\\mathbb{R}^{n}.',
    'checked',
    @revision_id
),
(
    '3.57',
    @section_id,
    'Kosinusähnlichkeit',
    '\\operatorname{cos}(x,y)=\\frac{x^{\\top}y}{\\|x\\|\\,\\|y\\|}',
    '\\operatorname{cos}(x,y)=\\frac{x^{\\top}y}{\\|x\\|\\,\\|y\\|}',
    'Die Kosinusähnlichkeit misst die Richtungsähnlichkeit zweier von Null verschiedener Vektoren.',
    'metric',
    'literature',
    @source_50_id,
    NULL,
    'x,y\\in\\mathbb{R}^{n}\\setminus\\{0\\}.',
    'checked',
    @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_52 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.52'
);

SET @eq_3_53 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.53'
);

SET @eq_3_54 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.54'
);

SET @eq_3_55 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.55'
);

SET @eq_3_56 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.56'
);

SET @eq_3_57 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.57'
);

/* 9. Symbolregister unmittelbar vor dem Einfügen nochmals sicher bereinigen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_52,
    @eq_3_53,
    @eq_3_54,
    @eq_3_55,
    @eq_3_56,
    @eq_3_57
);

/* 10. Symbolregister idempotent anlegen. */
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
(@eq_3_52, 'd', 'Metrik',
 'Distanzfunktion auf dem Raum X.', NULL, 'd:X\\times X\\rightarrow\\mathbb{R}_{\\ge0}', 1),
(@eq_3_52, 'X', 'Grundmenge',
 'Menge der Elemente, zwischen denen Distanzen bestimmt werden.', NULL, 'Menge', 2),

(@eq_3_53, 'x', 'erstes Element',
 'Erstes Element der Distanzbestimmung.', NULL, 'x\\in X', 1),
(@eq_3_53, 'y', 'zweites Element',
 'Zweites Element der Distanzbestimmung.', NULL, 'y\\in X', 2),
(@eq_3_53, 'd(x,y)', 'Distanz',
 'Nichtnegative Distanz zwischen x und y.', NULL, '\\mathbb{R}_{\\ge0}', 3),

(@eq_3_54, 'd(x,y)', 'Distanz von x nach y',
 'Distanz des geordneten Paares x und y.', NULL, '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_54, 'd(y,x)', 'Distanz von y nach x',
 'Umgekehrte Reihenfolge derselben Distanzbestimmung.', NULL, '\\mathbb{R}_{\\ge0}', 2),

(@eq_3_55, 'z', 'Zwischenelement',
 'Drittes Element zur Formulierung der Dreiecksungleichung.', NULL, 'z\\in X', 1),
(@eq_3_55, 'd(x,z)', 'direkte Distanz',
 'Direkter Abstand zwischen x und z.', NULL, '\\mathbb{R}_{\\ge0}', 2),
(@eq_3_55, 'd(x,y)+d(y,z)', 'indirekte Distanz',
 'Summe der Distanzen über das Zwischenelement y.', NULL, '\\mathbb{R}_{\\ge0}', 3),

(@eq_3_56, 'd_E(x,y)', 'euklidische Distanz',
 'Euklidischer Abstand zwischen den Vektoren x und y.', NULL, '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_56, 'x_i', 'i-te Komponente von x',
 'i-te Koordinate des Vektors x.', NULL, '\\mathbb{R}', 2),
(@eq_3_56, 'y_i', 'i-te Komponente von y',
 'i-te Koordinate des Vektors y.', NULL, '\\mathbb{R}', 3),
(@eq_3_56, 'n', 'Dimension',
 'Anzahl der Komponenten der betrachteten Vektoren.', NULL, '\\mathbb{N}', 4),

(@eq_3_57, '\\operatorname{cos}(x,y)', 'Kosinusähnlichkeit',
 'Normiertes Skalarprodukt der Vektoren x und y.', NULL, '[-1,1]', 1),
(@eq_3_57, 'x^{\\top}y', 'Skalarprodukt',
 'Inneres Produkt der Vektoren x und y.', NULL, '\\mathbb{R}', 2),
(@eq_3_57, '\\|x\\|', 'Norm von x',
 'Euklidische Norm des Vektors x.', NULL, '\\mathbb{R}_{>0}', 3),
(@eq_3_57, '\\|y\\|', 'Norm von y',
 'Euklidische Norm des Vektors y.', NULL, '\\mathbb{R}_{>0}', 4)

ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 11. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_3_53,
    @eq_3_52,
    'uses',
    'Nichtnegativität und Definitheit konkretisieren die allgemeine Metrikdefinition.'
),
(
    @eq_3_54,
    @eq_3_52,
    'uses',
    'Die Symmetrie ist eines der definierenden Axiome einer Metrik.'
),
(
    @eq_3_55,
    @eq_3_52,
    'uses',
    'Die Dreiecksungleichung ist eines der definierenden Axiome einer Metrik.'
),
(
    @eq_3_56,
    @eq_3_52,
    'special_case_of',
    'Die euklidische Distanz ist eine konkrete Metrik auf dem reellen Vektorraum.'
),
(
    @eq_3_57,
    @eq_3_56,
    'contrasts',
    'Die Kosinusähnlichkeit misst Richtungsähnlichkeit statt absoluten euklidischen Abstand.'
);

/* 12. Änderungsprotokoll aktualisieren. */
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
    @revision_id,
    @section_id,
    'rewritten',
    'section',
    '3.2.11',
    'Abschnitt 3.2.11 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit älterer Gleichungsnummerierung.',
    'Neufassung mit den Quellen [49] und [50] und den Gleichungen (3.52) bis (3.57).'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'sources',
    '[49], [50]',
    'Die vorhandenen Quellen zur metrischen Geometrie und zur Kosinusähnlichkeit wurden als Erstnennungen registriert.',
    NULL,
    '2 Quellenverwendungen'
),
(
    @revision_id,
    @section_id,
    'equation_changed',
    'equations',
    '(3.52)–(3.57)',
    'Die Gleichungen zu Metriken und Ähnlichkeitsmaßen wurden neu nummeriert und inhaltlich präzisiert.',
    'Ältere Gleichungsbelegungen.',
    'Metrik, Metrikaxiome, euklidische Distanz und Kosinusähnlichkeit.'
);

/* 13. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.58'),
    ('last_edited_section', '3.2.11'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.11-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.11: review
   - 2 Quellenverwendungen: [49], [50]
   - 2 Erstnennungen
   - Gleichungen (3.52) bis (3.57)
   - next_citation_number = 59
   - next_equation_number = 3.58
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.11')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`), 0) AS `first_mentions_in_section`,
    GROUP_CONCAT(
        s.`citation_number`
        ORDER BY s.`citation_number`
        SEPARATOR ', '
    ) AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

SELECT
    s.`citation_number`,
    s.`full_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`section_id` = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`section_id` = @section_id
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED),
    es.`symbol_order`;

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
