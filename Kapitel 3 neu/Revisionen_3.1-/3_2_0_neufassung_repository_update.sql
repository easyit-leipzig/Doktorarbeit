USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.0 – Einleitung
   Verwendete bestehende Quellen: [8], [9], [11]–[16]
   Neue Quellen: keine
   Neue Gleichungen: keine
   ============================================================ */

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
    'RKB-2026-07-12-K3.2.0-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.0',
    '1.0',
    'Neufassung der Einleitung zu Kapitel 3.2; mathematische Grundlagen als Forschungsstand und Übergang zur FRZK-Axiomatik.',
    'Olaf Thiele / ChatGPT',
    (SELECT MAX(r.`revision_id`) FROM `repository_revisions` r)
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.0'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `title` = 'Einleitung',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Die Einleitung ordnet Kapitel 3.2 als mathematischen Forschungsstand ein und grenzt es von der Eigenleistung ab Kapitel 3.3 ab. Keine nummerierte Gleichung.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu entwickelt und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'method',
    'Hilberts axiomatische Methode begründet die Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten mathematischen Strukturen.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 8;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'background',
    'Die Topologie steht beispielhaft für mathematische Theorien, die auf bereits definierten Grundmengen und Strukturen aufbauen.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 9;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'background',
    'Die Funktionalanalysis steht beispielhaft für Operatoren auf vorausgesetzten Banach- und Hilberträumen.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 11;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Die Synergetik dient als Referenz für mathematische Modelle emergenter Ordnungsbildung.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 12;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Dissipative Strukturen dienen als Referenz für dynamisch erhaltene Organisation.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 13;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Komplexe adaptive Systeme dienen als Referenz für rekursive Organisationsbildung.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 14;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Die Netzwerkwissenschaft dient als Referenz für mathematische Beziehungsstrukturen komplexer Systeme.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 15;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'background',
    'Die Theorie dynamischer Systeme steht für zeitliche Entwicklungen in vorausgesetzten Zustands- und Phasenräumen.',
    'Abschnitt 3.2.0', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.2.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 16;

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES (
    @revision_id, @section_id, 'rewritten', 'section', '3.2.0',
    'Die Einleitung zu Kapitel 3.2 wurde vollständig neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.2.0.',
    'Neufassung mit acht wiederverwendeten Quellen und ohne nummerierte Gleichung.'
);

INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('last_edited_section', '3.2.0'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.0-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen: erwartet 8 Quellenverwendungen, 0 Erstnennungen, 0 Gleichungen. */
SELECT
    ds.`section_code`, ds.`title`, ds.`status`, ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.0')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`), 0) AS `first_mentions_in_section`,
    GROUP_CONCAT(s.`citation_number` ORDER BY s.`citation_number` SEPARATOR ', ') AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

SELECT COUNT(*) AS `equations_in_section`
FROM `equations`
WHERE `section_id` = @section_id;
