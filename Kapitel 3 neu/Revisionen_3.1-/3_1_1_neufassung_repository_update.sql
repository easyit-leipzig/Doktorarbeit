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
    'RKB-2026-07-12-K3.1.1-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.1.1',
    '1.0',
    'Neufassung von Abschnitt 3.1.1 einschließlich vollständiger Registrierung der wiederverwendeten Quellen [1] bis [15].',
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
    WHERE ds.`section_code` = '3.1.1'
    LIMIT 1
);

/* 2. Abschnittsmetadaten an die Neufassung anpassen. */
UPDATE `dissertation_sections`
SET
    `title` = 'Problemstellung und wissenschaftlicher Ausgangspunkt',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt enthält keine nummerierte Gleichung und verwendet die bestehenden Quellen [1] bis [15].'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `notes` = 'Kapitel 3.1 befindet sich aufgrund der abschnittsweisen Neufassung erneut im Review-Status.'
WHERE `section_code` = '3.1';

/* 3. Alte Verwendungsregistrierungen dieses Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Quellenverwendungen [1] bis [15] exakt für die Neufassung registrieren. */
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
    'Abschnitt 3.1.1',
    1,
    0,
    'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.',
    @revision_id
FROM (
    SELECT 1 AS citation_number, 'historical_context' AS usage_type,
           'Aristoteles dient als historischer Ausgangspunkt für die relationale und bewegungsbezogene Bestimmung von Raum und Zeit.' AS claim_summary
    UNION ALL SELECT 2, 'historical_context',
           'Newton belegt die klassische Setzung von absolutem Raum und absoluter Zeit als primitive physikalische Bezugsgrößen.'
    UNION ALL SELECT 3, 'critique',
           'Mach belegt die Kritik an unbeobachtbaren absoluten Größen und den Übergang zu relationalen Beschreibungen.'
    UNION ALL SELECT 4, 'state_of_research',
           'Einsteins Spezielle Relativitätstheorie belegt die Relativierung räumlicher und zeitlicher Messgrößen.'
    UNION ALL SELECT 5, 'state_of_research',
           'Einsteins Allgemeine Relativitätstheorie belegt die Dynamisierung der Raumzeitgeometrie durch Materie und Energie.'
    UNION ALL SELECT 6, 'state_of_research',
           'Minkowski belegt die mathematische Vereinigung von Raum und Zeit in einer vierdimensionalen Raumzeitstruktur.'
    UNION ALL SELECT 7, 'historical_context',
           'Euklid belegt den Beginn axiomatischer Geometrie mit primitiven räumlichen Grundbegriffen.'
    UNION ALL SELECT 8, 'historical_context',
           'Hilbert belegt die formale Rolle primitiver Begriffe und Axiome in mathematischen Theorien.'
    UNION ALL SELECT 9, 'comparison',
           'Bourbaki belegt, dass die Topologie bereits eine Grundmenge und eine Topologie voraussetzt.'
    UNION ALL SELECT 10, 'comparison',
           'Lang belegt, dass Differentialgeometrie bereits differenzierbare Mannigfaltigkeiten voraussetzt.'
    UNION ALL SELECT 11, 'comparison',
           'Rudin belegt, dass Funktionalanalysis bereits normierte, Banach- oder Hilberträume voraussetzt.'
    UNION ALL SELECT 12, 'state_of_research',
           'Haken belegt die Entstehung makroskopischer Ordnung aus lokalen Wechselwirkungen und Ordnungsparametern.'
    UNION ALL SELECT 13, 'state_of_research',
           'Prigogine und Stengers belegen die Entstehung dissipativer Strukturen fern vom Gleichgewicht.'
    UNION ALL SELECT 14, 'state_of_research',
           'Holland belegt emergente Ordnung in komplexen adaptiven Systemen aus rekursiven lokalen Regeln.'
    UNION ALL SELECT 15, 'state_of_research',
           'Barabási belegt die Entstehung komplexer Netzwerkstrukturen aus lokalen Verknüpfungs- und Wachstumsmechanismen.'
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
    '3.1.1',
    'Abschnitt 3.1.1 wurde vollständig neu gefasst und auf die Forschungsfrage der funktionalen Genese von Raum und Zeit ausgerichtet.',
    'Bisheriger Repository-Stand von Abschnitt 3.1.1.',
    'Neufassung mit fortlaufenden Literaturangaben [1] bis [15]; keine neue Gleichung.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source_usage',
    '[1]-[15]',
    'Die bestehenden Masterquellen [1] bis [15] wurden für Abschnitt 3.1.1 neu und vollständig registriert.',
    NULL,
    '15 Quellenverwendungen in source_usage.'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.1.1',
    'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.',
    'final',
    'review'
);

/* 6. Repository-Zähler aktualisieren, ohne Literatur- oder Gleichungszählung zu verändern. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('last_edited_section', '3.1.1'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.1.1-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* 7. Unmittelbare Kontrollabfragen. Erwartet: 1 Abschnitt, 15 Verwendungen, 0 Gleichungen. */
SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` = '3.1.1';

SELECT
    COUNT(*) AS `registered_source_usages`,
    MIN(s.`citation_number`) AS `first_citation_number`,
    MAX(s.`citation_number`) AS `last_citation_number`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

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
