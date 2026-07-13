USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.1.5 – Einordnung des Funktionalen Raum-Zeit-
   Kohärenzsystems
   - Abschluss von Kapitel 3.1
   - Wiederverwendung bestehender Quellen
   - Aktualisierung der vorhandenen Gleichungen (3.1) und (3.2)
   - keine neue Literaturquelle
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
    'RKB-2026-07-12-K3.1.5-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.1.5',
    '1.0',
    'Neufassung von Abschnitt 3.1.5 als wissenschaftliche Einordnung des FRZK; Aktualisierung der Gleichungen (3.1) und (3.2) sowie Abschluss von Kapitel 3.1.',
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
    WHERE ds.`section_code` = '3.1.5'
    LIMIT 1
);

/* 2. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Einordnung des Funktionalen Raum-Zeit-Kohärenzsystems',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Wissenschaftliche Einordnung des FRZK, Abgrenzung von physikalischen Konkurrenztheorien und Übergang zu Kapitel 3.2. Enthält die aktualisierten Gleichungen (3.1) und (3.2).'
WHERE `section_id` = @section_id;

/* Kapitel 3.1 bleibt bis zur gemeinsamen Endredaktion im Review-Status. */
UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `notes` = 'Kapitel 3.1 wurde vollständig neu gefasst. Gemeinsame Endredaktion, Literaturprüfung und Statuswechsel auf final stehen noch aus.'
WHERE `section_code` = '3.1';

/* 3. Quellenverwendungen des Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

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
    'Abschnitt 3.1.5',
    0,
    1,
    u.`notes`,
    @revision_id
FROM (
    SELECT 8 AS citation_number, 'method' AS usage_type,
           'Hilberts axiomatische Methode begründet die Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten Strukturen.' AS claim_summary,
           'Wiederverwendung nach Erstnennung in 3.1.1.' AS notes
    UNION ALL SELECT 12, 'comparison',
           'Die Synergetik dient als Referenz für emergente makroskopische Ordnung aus lokalen Wechselwirkungen.',
           'Wiederverwendung nach Erstnennung in 3.1.1.'
    UNION ALL SELECT 13, 'comparison',
           'Dissipative Strukturen dienen als Referenz für dynamisch erhaltene Organisation.',
           'Wiederverwendung nach Erstnennung in 3.1.1.'
    UNION ALL SELECT 14, 'comparison',
           'Komplexe adaptive Systeme dienen als Referenz für rekursive Organisationsbildung.',
           'Wiederverwendung nach Erstnennung in 3.1.1.'
    UNION ALL SELECT 15, 'comparison',
           'Netzwerkwissenschaft dient als Referenz für globale Struktur aus lokalen Verknüpfungsmechanismen.',
           'Wiederverwendung nach Erstnennung in 3.1.1.'
    UNION ALL SELECT 17, 'method',
           'Gödels Resultate begrenzen einen universalen Vollständigkeitsanspruch des Axiomensystems.',
           'Wiederverwendung nach Erstnennung in 3.1.3.'
    UNION ALL SELECT 19, 'comparison',
           'Schleifenquantengravitation dient zur Abgrenzung des FRZK von physikalischen Quantengravitationsprogrammen.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
    UNION ALL SELECT 21, 'comparison',
           'Wheelers informationeller Ansatz dient zur Abgrenzung des FRZK von einer Ontologie physikalischer Information.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
    UNION ALL SELECT 53, 'comparison',
           'Thiemanns kanonische Quantengravitation dient zur Abgrenzung des FRZK von physikalischen Raumzeitmodellen.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
    UNION ALL SELECT 54, 'comparison',
           'Die Causal-Set-Theorie dient zur Abgrenzung des FRZK von Theorien mit vorausgesetzten Ereignissen und Kausalrelationen.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
    UNION ALL SELECT 55, 'comparison',
           'Verschränkungsbasierte Raumzeitrekonstruktion dient zur Abgrenzung des FRZK von Hilbertraum-basierten Ansätzen.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
    UNION ALL SELECT 56, 'comparison',
           'Tensornetzwerke dienen zur Abgrenzung des FRZK von bereits mathematisch strukturierten Netzwerkmodellen.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
    UNION ALL SELECT 57, 'comparison',
           'Emergente Gravitation dient zur Abgrenzung des FRZK von thermodynamisch-informationellen Gravitationstheorien.',
           'Wiederverwendung nach Erstnennung in 3.1.4.'
) AS u
INNER JOIN `sources` s
    ON s.`citation_number` = u.`citation_number`;

/* 4. Vorhandene Gleichungen (3.1) und (3.2) aktualisieren.
   Es werden keine neuen Gleichungsnummern vergeben. */
UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Klassische theoretische Entwicklungsrichtung',
    `equation_latex` = '\\text{primitive Strukturen}\\longrightarrow\\text{mathematische Räume}\\longrightarrow\\text{Dynamik in diesen Räumen}',
    `word_latex` = '\\text{primitive Strukturen}\\longrightarrow\\text{mathematische Räume}\\longrightarrow\\text{Dynamik in diesen Räumen}',
    `plain_description` = 'Schematische Darstellung klassischer Theorien: Primitive Strukturen und mathematische Räume werden vorausgesetzt, bevor Dynamik innerhalb dieser Räume beschrieben wird.',
    `equation_type` = 'schema',
    `provenance` = 'original',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.1';

UPDATE `equations`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Entwicklungsrichtung des FRZK',
    `equation_latex` = '\\text{funktionale Grundprinzipien}\\longrightarrow\\text{Relationierung}\\longrightarrow\\text{rekursive Transformation}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum- und Zeitstrukturen}',
    `word_latex` = '\\text{funktionale Grundprinzipien}\\longrightarrow\\text{Relationierung}\\longrightarrow\\text{rekursive Transformation}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum- und Zeitstrukturen}',
    `plain_description` = 'Schematische Darstellung des FRZK: Raum- und Zeitstrukturen werden erst nach Relationierung, rekursiver Transformation und Kohärenz rekonstruiert.',
    `equation_type` = 'schema',
    `provenance` = 'original',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `equation_number` = '3.2';

/* Falls die Gleichungen in einer älteren Datenbankversion fehlen,
   werden sie idempotent ergänzt. */
INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.1', @section_id,
    'Klassische theoretische Entwicklungsrichtung',
    '\\text{primitive Strukturen}\\longrightarrow\\text{mathematische Räume}\\longrightarrow\\text{Dynamik in diesen Räumen}',
    '\\text{primitive Strukturen}\\longrightarrow\\text{mathematische Räume}\\longrightarrow\\text{Dynamik in diesen Räumen}',
    'Schematische Darstellung klassischer Theorien: Primitive Strukturen und mathematische Räume werden vorausgesetzt, bevor Dynamik innerhalb dieser Räume beschrieben wird.',
    'schema', 'original', 'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.1'
);

INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `validation_status`,
    `created_revision_id`
)
SELECT
    '3.2', @section_id,
    'Funktionale Entwicklungsrichtung des FRZK',
    '\\text{funktionale Grundprinzipien}\\longrightarrow\\text{Relationierung}\\longrightarrow\\text{rekursive Transformation}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum- und Zeitstrukturen}',
    '\\text{funktionale Grundprinzipien}\\longrightarrow\\text{Relationierung}\\longrightarrow\\text{rekursive Transformation}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum- und Zeitstrukturen}',
    'Schematische Darstellung des FRZK: Raum- und Zeitstrukturen werden erst nach Relationierung, rekursiver Transformation und Kohärenz rekonstruiert.',
    'schema', 'original', 'checked', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM `equations` e WHERE e.`equation_number` = '3.2'
);

/* 5. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.1.5',
    'Abschnitt 3.1.5 wurde als wissenschaftliche Einordnung und Abgrenzung des FRZK vollständig neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.1.5.',
    'Neufassung mit dreizehn Quellenverwendungen und zwei aktualisierten Gleichungen.'
),
(
    @revision_id,
    @section_id,
    'equation_updated',
    'equation',
    '(3.1)',
    'Die klassische Entwicklungsrichtung wurde präzisiert.',
    'Axiome → Raum → Zeit → physikalische Dynamik',
    'primitive Strukturen → mathematische Räume → Dynamik in diesen Räumen'
),
(
    @revision_id,
    @section_id,
    'equation_updated',
    'equation',
    '(3.2)',
    'Die funktionale Entwicklungsrichtung des FRZK wurde präzisiert.',
    'funktionale Axiome → rekursive Entwicklung → Kohärenz → Raum → Zeit',
    'funktionale Grundprinzipien → Relationierung → rekursive Transformation → Kohärenz → Raum- und Zeitstrukturen'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.1.5',
    'Der Abschnitt wurde für die gemeinsame Endredaktion auf review gesetzt.',
    'final',
    'review'
);

/* 6. Zähler und Bearbeitungsstand aktualisieren.
   Die nächste freie Literaturstelle bleibt [58].
   Die nächste freie Gleichungsnummer bleibt unverändert,
   weil nur (3.1) und (3.2) aktualisiert wurden. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '58'),
    ('last_edited_section', '3.1.5'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.1.5-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* 7. Kontrollabfragen.
   Erwartet:
   - Abschnitt 3.1.5: review
   - Originalbeitrag: 1
   - 13 Quellenverwendungen
   - 0 Erstnennungen
   - 2 Gleichungen: (3.1), (3.2)
   - nächste freie Literaturnummer: 58
*/
SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.1', '3.1.5')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    SUM(su.`is_first_mention`) AS `first_mentions_in_section`,
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
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED);

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
