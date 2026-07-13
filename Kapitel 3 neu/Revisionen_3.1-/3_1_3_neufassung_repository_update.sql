USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.1.3 – Neufassung
   Anforderungen an eine funktionale Theorie von Raum und Zeit
   ============================================================ */

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
    'RKB-2026-07-12-K3.1.3-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.1.3',
    '1.0',
    'Neufassung von Abschnitt 3.1.3 mit den methodischen Anforderungen an eine funktionale Theorie von Raum und Zeit; Wiederverwendung bestehender Quellen [8] und [12] bis [15] sowie Erstverwendung der Quellen [17] und [18].',
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
    WHERE ds.`section_code` = '3.1.3'
    LIMIT 1
);

/* 2. Abschnittsmetadaten an die Neufassung anpassen. */
UPDATE `dissertation_sections`
SET
    `title` = 'Anforderungen an eine funktionale Theorie von Raum und Zeit',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt formuliert die methodischen Anforderungen an die spätere FRZK-Axiomatik. Er enthält keine nummerierte Gleichung. Verwendet werden die bestehenden Quellen [8], [12] bis [15], [17] und [18].'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `notes` = 'Kapitel 3.1 befindet sich aufgrund der abschnittsweisen Neufassung erneut im Review-Status.'
WHERE `section_code` = '3.1';

/* 3. Bisherige Quellenverwendungen des Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Quellenverwendungen der Neufassung registrieren. */
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
    'Abschnitt 3.1.3',
    u.`is_first_mention`,
    0,
    u.`notes`,
    @revision_id
FROM (
    SELECT 8 AS citation_number, 'method' AS usage_type,
           'Hilberts axiomatische Methode begründet die notwendige Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten Aussagen.' AS claim_summary,
           0 AS is_first_mention,
           'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.' AS notes
    UNION ALL SELECT 12, 'state_of_research',
           'Die Synergetik belegt, dass makroskopische Ordnungsstrukturen aus lokalen Wechselwirkungen hervorgehen können.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 13, 'state_of_research',
           'Die Theorie dissipativer Strukturen belegt die Entstehung stabiler Organisation fern vom thermodynamischen Gleichgewicht.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 14, 'state_of_research',
           'Die Theorie komplexer adaptiver Systeme belegt, dass globale Ordnung aus lokalen Regeln und Rückkopplungen entstehen kann.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 15, 'state_of_research',
           'Die Netzwerkwissenschaft belegt die Entstehung globaler Struktur aus lokalen Verknüpfungs- und Wachstumsmechanismen.',
           0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.'
    UNION ALL SELECT 17, 'first_citation',
           'Gödels Unvollständigkeitssätze begrenzen den Anspruch formaler Systeme, sämtliche für sie relevanten Wahrheiten aus sich selbst heraus abzuleiten.',
           1, 'Vollständige Erstnennung im Fließtext von Abschnitt 3.1.3.'
    UNION ALL SELECT 18, 'first_citation',
           'Whitehead und Russell stehen für den Versuch, mathematische Aussagen auf eine kleine Menge logisch formulierter Grundannahmen zurückzuführen.',
           1, 'Vollständige Erstnennung im Fließtext von Abschnitt 3.1.3.'
) AS u
INNER JOIN `sources` s
    ON s.`citation_number` = u.`citation_number`;

/* 5. Änderungsprotokoll idempotent neu erzeugen. */
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
    '3.1.3',
    'Abschnitt 3.1.3 wurde vollständig neu gefasst und formuliert nun die methodischen Anforderungen an eine funktionale Theorie von Raum und Zeit.',
    'Bisheriger Repository-Stand von Abschnitt 3.1.3.',
    'Neufassung mit sieben registrierten Quellenverwendungen und ohne nummerierte Gleichung.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source_usage',
    '[8], [12]-[15]',
    'Die bereits eingeführten Quellen wurden zur Begründung axiomatischer Minimalität und emergenter Strukturbildung erneut registriert.',
    NULL,
    '5 Wiederverwendungen in source_usage.'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'source_usage',
    '[17]-[18]',
    'Die Quellen [17] und [18] wurden erstmals in Abschnitt 3.1.3 verwendet.',
    NULL,
    '2 Erstverwendungen in source_usage.'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.1.3',
    'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.',
    'final',
    'review'
);

/* 6. Repository-Zähler aktualisieren, ohne Literatur- oder Gleichungszählung zu verändern. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('last_edited_section', '3.1.3'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.1.3-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* 7. Kontrollabfragen.
   Erwartet:
   - Abschnitt 3.1.3 im Status review
   - 7 Quellenverwendungen
   - 2 Erstnennungen
   - höchste verwendete Literaturnummer 18
   - 0 Gleichungen
*/
SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` = '3.1.3';

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
