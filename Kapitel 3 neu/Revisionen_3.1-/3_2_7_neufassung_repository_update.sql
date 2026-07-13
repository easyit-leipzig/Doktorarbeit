USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.7
   Funktionalanalysis als mathematischer Rahmen
   unendlichdimensionaler Zustandsräume

   Quellen:
   [41] Reed / Simon – Erstnennung
   [42] Yosida – Erstnennung
   [35] Conway – Wiederverwendung
   [36] Kreyszig – Wiederverwendung

   Gleichungen:
   (3.29) Funktionenraum
   (3.30) Punktweise Addition
   (3.31) Punktweise Skalarmultiplikation
   (3.32) Normaxiome
   (3.33) Cauchy-Bedingung
   (3.34) Durch das Skalarprodukt induzierte Norm

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
    'RKB-2026-07-12-K3.2.7-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.7',
    '1.0',
    'Neufassung von Abschnitt 3.2.7 mit den Quellen [35], [36], [41] und [42] sowie den Gleichungen (3.29) bis (3.34).',
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
    WHERE ds.`section_code` = '3.2.7'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Funktionalanalysis als mathematischer Rahmen unendlichdimensionaler Zustandsräume',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [35], [36], [41] und [42] und enthält die Gleichungen (3.29) bis (3.34).'
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

/* [41] Reed / Simon */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Reed und Simon dienen als Hauptreferenz für Hilberträume, Operatoren und spektrale Strukturen in der mathematischen Physik.',
    'Abschnitt 3.2.7', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [41].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 41;

/* [42] Yosida */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Yosida dient als Hauptreferenz für normierte Räume, Banachräume, Vollständigkeit und lineare Funktionalanalysis.',
    'Abschnitt 3.2.7', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [42].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 42;

/* [35] Conway */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'background',
    'Conway wird als ergänzende Referenz für Operatoren und Hilbertraumstrukturen wiederverwendet.',
    'Abschnitt 3.2.7', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.2.5.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 35;

/* [36] Kreyszig */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'background',
    'Kreyszig wird als ergänzende Referenz für normierte Räume, Banachräume und Anwendungen der Funktionalanalysis wiederverwendet.',
    'Abschnitt 3.2.7', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.2.5.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 36;

/* 5. Quellen-IDs bestimmen. */
SET @source_41_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 41
    LIMIT 1
);

SET @source_42_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 42
    LIMIT 1
);

/* 6. Alte Belegungen (3.29) bis (3.34) vollständig bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.29','3.30','3.31','3.32','3.33','3.34');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.29','3.30','3.31','3.32','3.33','3.34');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.29','3.30','3.31','3.32','3.33','3.34');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.29','3.30','3.31','3.32','3.33','3.34');

/* 7. Gleichungen der Neufassung einfügen. */
INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.29', @section_id, 'Funktionenraum',
    '\\mathcal{F}(\\Omega,V)=\\{f\\mid f:\\Omega\\rightarrow V\\}',
    '\\mathcal{F}(\\Omega,V)=\\{f\\mid f:\\Omega\\rightarrow V\\}',
    'Der Funktionenraum enthält alle Funktionen von der Grundmenge Omega in den Wertebereich V.',
    'definition', 'literature', @source_42_id,
    NULL, 'Omega ist eine nichtleere Grundmenge und V ein Vektorraum.',
    'checked', @revision_id
),
(
    '3.30', @section_id, 'Punktweise Addition von Funktionen',
    '(f+g)(x)=f(x)+g(x)',
    '(f+g)(x)=f(x)+g(x)',
    'Die Addition zweier Funktionen wird punktweise über ihre Funktionswerte definiert.',
    'definition', 'literature', @source_41_id,
    NULL, 'f und g gehören zu demselben Funktionenraum mit vektoriellem Wertebereich.',
    'checked', @revision_id
),
(
    '3.31', @section_id, 'Punktweise Skalarmultiplikation',
    '(\\alpha f)(x)=\\alpha f(x)',
    '(\\alpha f)(x)=\\alpha f(x)',
    'Die Multiplikation einer Funktion mit einem Skalar wird punktweise definiert.',
    'definition', 'literature', @source_41_id,
    NULL, 'alpha ist ein Skalar und f gehört zu einem Funktionenraum über demselben Skalarkörper.',
    'checked', @revision_id
),
(
    '3.32', @section_id, 'Normaxiome',
    '\\|f\\|\\ge0,\\quad \\|f\\|=0\\Longleftrightarrow f=0,\\quad \\|\\alpha f\\|=|\\alpha|\\,\\|f\\|,\\quad \\|f+g\\|\\le\\|f\\|+\\|g\\|',
    '\\|f\\|\\ge0,\\quad \\|f\\|=0\\Longleftrightarrow f=0,\\quad \\|\\alpha f\\|=|\\alpha|\\,\\|f\\|,\\quad \\|f+g\\|\\le\\|f\\|+\\|g\\|',
    'Eine Norm erfüllt Nichtnegativität, Definitheit, absolute Homogenität und Dreiecksungleichung.',
    'definition', 'literature', @source_42_id,
    NULL, 'f und g gehören zu einem Vektorraum; alpha ist ein Skalar.',
    'checked', @revision_id
),
(
    '3.33', @section_id, 'Cauchy-Bedingung',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow\\|f_n-f_m\\|<\\varepsilon',
    '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow\\|f_n-f_m\\|<\\varepsilon',
    'Eine Folge ist eine Cauchy-Folge, wenn ihre Folgenglieder ab einem Index beliebig nahe beieinander liegen.',
    'definition', 'literature', @source_42_id,
    NULL, 'Die Folge liegt in einem normierten Vektorraum.',
    'checked', @revision_id
),
(
    '3.34', @section_id, 'Durch das Skalarprodukt induzierte Norm',
    '\\|f\\|=\\sqrt{\\langle f,f\\rangle}',
    '\\|f\\|=\\sqrt{\\langle f,f\\rangle}',
    'In einem Skalarproduktraum wird die Norm durch das Skalarprodukt eines Elements mit sich selbst induziert.',
    'derived', 'literature', @source_41_id,
    NULL, 'Es ist ein positives definites Skalarprodukt definiert.',
    'checked', @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_29 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.29');
SET @eq_3_30 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.30');
SET @eq_3_31 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.31');
SET @eq_3_32 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.32');
SET @eq_3_33 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.33');
SET @eq_3_34 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.34');

/* 9. Symbolregister unmittelbar vor dem Einfügen nochmals sicher bereinigen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_29,@eq_3_30,@eq_3_31,@eq_3_32,@eq_3_33,@eq_3_34
);

/* 10. Symbolregister idempotent anlegen. */
INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_3_29, '\\mathcal{F}(\\Omega,V)', 'Funktionenraum',
 'Gesamtheit der Funktionen von Omega nach V.', NULL, 'Funktionenmenge', 1),
(@eq_3_29, '\\Omega', 'Grundmenge',
 'Definitionsbereich der Funktionen.', NULL, 'Menge', 2),
(@eq_3_29, 'V', 'Wertebereich',
 'Vektorraum der Funktionswerte.', NULL, 'Vektorraum', 3),

(@eq_3_30, 'f', 'erste Funktion',
 'Erste Funktion der punktweisen Addition.', NULL, 'f\\in\\mathcal{F}(\\Omega,V)', 1),
(@eq_3_30, 'g', 'zweite Funktion',
 'Zweite Funktion der punktweisen Addition.', NULL, 'g\\in\\mathcal{F}(\\Omega,V)', 2),
(@eq_3_30, 'x', 'Argument',
 'Element der Grundmenge Omega.', NULL, 'x\\in\\Omega', 3),

(@eq_3_31, '\\alpha', 'Skalar',
 'Skalarer Multiplikator.', NULL, 'Skalarkörper', 1),
(@eq_3_31, 'f', 'Funktion',
 'Mit dem Skalar multiplizierte Funktion.', NULL, 'f\\in\\mathcal{F}(\\Omega,V)', 2),

(@eq_3_32, '\\|f\\|', 'Norm von f',
 'Nichtnegative Größe des Elements f.', NULL, '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_32, '\\alpha', 'Skalar',
 'Skalar zur Prüfung der absoluten Homogenität.', NULL, 'Skalarkörper', 2),
(@eq_3_32, 'g', 'zweites Element',
 'Zweites Element für die Dreiecksungleichung.', NULL, 'Vektorraum', 3),

(@eq_3_33, '\\varepsilon', 'Toleranz',
 'Beliebige positive Schranke für den Abstand der Folgenglieder.', NULL, '\\mathbb{R}_{>0}', 1),
(@eq_3_33, 'N', 'Schwellenindex',
 'Index, ab dem alle betrachteten Folgenglieder näher als epsilon liegen.', NULL, '\\mathbb{N}', 2),
(@eq_3_33, 'f_n', 'Folgenglied',
 'n-tes Element der betrachteten Folge.', NULL, 'normierter Raum', 3),

(@eq_3_34, '\\langle f,f\\rangle', 'Selbstskalarprodukt',
 'Skalarprodukt des Elements f mit sich selbst.', NULL, 'Skalarkörper', 1),
(@eq_3_34, '\\|f\\|', 'induzierte Norm',
 'Durch das Skalarprodukt erzeugte Norm.', NULL, '\\mathbb{R}_{\\ge0}', 2)

ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 11. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@eq_3_30, @eq_3_29, 'uses',
 'Die punktweise Addition setzt den Funktionenraum voraus.'),
(@eq_3_31, @eq_3_29, 'uses',
 'Die Skalarmultiplikation setzt den Funktionenraum voraus.'),
(@eq_3_32, @eq_3_30, 'uses',
 'Die Dreiecksungleichung verwendet die Addition des Funktionenraums.'),
(@eq_3_33, @eq_3_32, 'uses',
 'Die Cauchy-Bedingung setzt eine Norm voraus.'),
(@eq_3_34, @eq_3_32, 'special_case_of',
 'Die durch das Skalarprodukt induzierte Norm ist eine spezielle Normkonstruktion.');

/* 12. Änderungsprotokoll aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.2.7',
    'Abschnitt 3.2.7 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit den Gleichungen (3.44) bis (3.50).',
    'Neufassung mit den Quellen [35], [36], [41], [42] und den Gleichungen (3.29) bis (3.34).'
),
(
    @revision_id, @section_id, 'source_reused', 'sources', '[35], [36], [41], [42]',
    'Die vorhandenen funktionalanalytischen Quellen wurden registriert.',
    NULL, '4 Quellenverwendungen'
),
(
    @revision_id, @section_id, 'equation_changed', 'equations', '(3.29)–(3.34)',
    'Die Gleichungen der Funktionalanalysis wurden neu nummeriert und inhaltlich verdichtet.',
    'Bisherige Gleichungen (3.44) bis (3.50).',
    'Funktionenraum, punktweise Operationen, Norm, Cauchy-Bedingung und induzierte Norm.'
);

/* 13. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.35'),
    ('last_edited_section', '3.2.7'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.7-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.7: review
   - 4 Quellenverwendungen: [35], [36], [41], [42]
   - 2 Erstnennungen: [41], [42]
   - Gleichungen (3.29) bis (3.34)
   - next_citation_number = 59
   - next_equation_number = 3.35
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.7')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`), 0) AS `first_mentions_in_section`,
    GROUP_CONCAT(s.`citation_number`
                 ORDER BY s.`citation_number`
                 SEPARATOR ', ') AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

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
