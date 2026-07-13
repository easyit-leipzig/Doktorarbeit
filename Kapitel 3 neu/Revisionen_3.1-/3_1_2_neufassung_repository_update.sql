USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* 1. Revisionsdatensatz idempotent anlegen bzw. wiederverwenden. */
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
    'RKB-2026-07-12-K3.1.2-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.1.2',
    '1.0',
    'Neufassung von Abschnitt 3.1.2 einschließlich Neuordnung der Quellenverwendungen [1] bis [11] sowie Erstverwendung von Quelle [16].',
    'Olaf Thiele / ChatGPT',
    (SELECT MAX(r.`revision_id`) FROM `repository_revisions` r)
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.1.2'
    LIMIT 1
);

/* 2. Abschnittsmetadaten an die Neufassung anpassen. */
UPDATE `dissertation_sections`
SET
    `title` = 'Wissenschaftstheoretische Entwicklung des Raum- und Zeitbegriffs',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt enthält keine nummerierte Gleichung. Verwendet werden die bestehenden Quellen [1] bis [11] und [16].'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `notes` = 'Kapitel 3.1 befindet sich aufgrund der abschnittsweisen Neufassung erneut im Review-Status.'
WHERE `section_code` = '3.1';

/* 3. Alte Verwendungsregistrierungen dieses Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Quellenverwendungen für die Neufassung registrieren. */
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
    u.`usage_type`,
    u.`claim_summary`,
    'Abschnitt 3.1.2',
    u.`is_first_mention`,
    0,
    u.`notes`,
    @revision_id
FROM (
    SELECT 1 AS citation_number, 'historical_context' AS usage_type,
           'Aristoteles belegt die frühe relationale und bewegungsbezogene Bestimmung von Raum und Zeit.' AS claim_summary,
           0 AS is_first_mention,
           'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.' AS notes
    UNION ALL SELECT 2, 'comparison',
           'Newton belegt die Trennung von beobachtbaren Prozessen und absoluten Raum- und Zeitstrukturen.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 3, 'critique',
           'Mach belegt die wissenschaftstheoretische Kritik an unbeobachtbaren absoluten Bezugsgrößen.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 4, 'state_of_research',
           'Die Spezielle Relativitätstheorie belegt die Abhängigkeit räumlicher und zeitlicher Messgrößen vom Bezugssystem.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 5, 'state_of_research',
           'Die Allgemeine Relativitätstheorie belegt die physikalische Dynamisierung der Raumzeitgeometrie.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 6, 'state_of_research',
           'Minkowski belegt die mathematische Vereinigung räumlicher und zeitlicher Koordinaten in einer Raumzeitstruktur.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 7, 'historical_context',
           'Euklid belegt die axiomatische Verwendung primitiver räumlicher Grundbegriffe.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 8, 'critique',
           'Hilbert belegt die methodische Notwendigkeit primitiver Begriffe und zugleich deren Abhängigkeit vom gewählten Axiomensystem.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 9, 'comparison',
           'Bourbaki belegt, dass moderne Topologie eine Grundmenge und eine darauf definierte Struktur voraussetzt.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 10, 'comparison',
           'Lang belegt, dass Differentialgeometrie bereits differenzierbare Mannigfaltigkeiten voraussetzt.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 11, 'comparison',
           'Rudin belegt, dass funktionalanalytische Modelle bereits definierte normierte Räume voraussetzen.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 16, 'first_citation',
           'Arnold belegt, dass auch die moderne Theorie dynamischer Systeme Entwicklungen innerhalb eines vorgegebenen Phasenraums beschreibt.',
           1, 'Vollständige Erstnennung im Fließtext von Abschnitt 3.1.2.'
) AS u
INNER JOIN `sources` s
    ON s.`citation_number` = u.`citation_number`;

/* 5. Änderungsprotokoll für diese Revision idempotent neu erzeugen. */
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
    '3.1.2',
    'Abschnitt 3.1.2 wurde vollständig neu gefasst und als wissenschaftstheoretische Rekonstruktion der Entwicklung des Raum- und Zeitbegriffs ausgerichtet.',
    'Bisheriger Repository-Stand von Abschnitt 3.1.2.',
    'Neufassung mit wiederverwendeten Quellen [1] bis [11], Erstverwendung von [16] und ohne neue Gleichung.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source_usage',
    '[1]-[11]',
    'Die bereits in Abschnitt 3.1.1 vollständig eingeführten Quellen [1] bis [11] wurden für die wissenschaftstheoretische Vergleichsanalyse erneut registriert.',
    NULL,
    '11 Wiederverwendungen in source_usage.'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'source_usage',
    '[16]',
    'Quelle [16] wurde erstmals in Abschnitt 3.1.2 verwendet.',
    NULL,
    '1 Erstverwendung in source_usage.'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.1.2',
    'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.',
    'final',
    'review'
);

/* 6. Repository-Zähler aktualisieren, ohne Literatur- oder Gleichungszählung zu verändern. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('last_edited_section', '3.1.2'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.1.2-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* 7. Unmittelbare Kontrollabfragen. Erwartet: 1 Abschnitt, 12 Verwendungen, 1 Erstnennung, 0 Gleichungen. */
SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` = '3.1.2';

SELECT
    COUNT(*) AS `registered_source_usages`,
    SUM(su.`is_first_mention`) AS `first_mentions_in_section`,
    MIN(s.`citation_number`) AS `first_citation_number`,
    MAX(s.`citation_number`) AS `last_citation_number`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

SELECT
    s.`citation_number`,
    s.`short_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`claim_summary`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

SELECT
    COUNT(*) AS `equations_in_section`
FROM `equations`
WHERE `section_id` = @section_id;

SELECT
    rr.`revision_id`,
    rr.`revision_code`,
    rr.`scope_reference`,
    rr.`version_label`,
    rr.`revision_date`
FROM `repository_revisions` rr
WHERE rr.`revision_id` = @revision_id;
