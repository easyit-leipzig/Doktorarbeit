USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.2
   Wissenschaftstheoretische Begründung der primitiven Begriffe

   Quellen:
   [8] Hilbert – Wiederverwendung
   [18] Whitehead / Russell – Wiederverwendung
   [24] Zermelo – Wiederverwendung

   Neue Quellen:     keine
   Neue Gleichungen: keine
   Neue Axiome:      keine
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
    'RKB-2026-07-12-K3.3.2-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.2',
    '1.0',
    'Neufassung von Abschnitt 3.3.2 zur wissenschaftstheoretischen Begründung der primitiven Begriffe; Wiederverwendung der Quellen [8], [18] und [24]; keine neuen Gleichungen oder Axiome.',
    'Olaf Thiele / ChatGPT',
    (
        SELECT MAX(r.`revision_id`)
        FROM `repository_revisions` r
    )
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* 2. Abschnitts- und Kapitel-ID ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3.2'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Wissenschaftstheoretische Begründung der primitiven Begriffe',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt begründet die Auswahl der primitiven Begriffe des FRZK und grenzt sie von bereits mathematisch strukturierten Begriffen ab. Verwendet werden [8], [18] und [24]. Keine nummerierte Gleichung und noch kein Axiom.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 wird abschnittsweise als eigenständige axiomatische Grundlage des FRZK neu gefasst.'
WHERE `section_id` = @chapter_id;

/* 4. Frühere Quellenverwendungen dieses Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* [8] Hilbert */
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
    'method',
    'Hilberts axiomatische Methode dient als Referenz für die Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten Aussagen.',
    'Abschnitt 3.3.2',
    0,
    1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 8;

/* [18] Whitehead / Russell */
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
    'comparison',
    'Whitehead und Russell dienen als Referenz für die systematische Reduktion komplexer mathematischer Strukturen auf explizite logische Ausgangsannahmen.',
    'Abschnitt 3.3.2',
    0,
    1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.3.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 18;

/* [24] Zermelo */
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
    'comparison',
    'Zermelos axiomatische Mengenlehre dient zur Abgrenzung des FRZK von Theorien, die Mengen und Elemente bereits als primitive mathematische Objekte voraussetzen.',
    'Abschnitt 3.3.2',
    0,
    1,
    'Wiederverwendung einer bereits nummerierten Masterquelle.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 24;

/* 5. Alte Gleichungszuordnungen dieses Abschnitts entfernen.
      Die Neufassung enthält bewusst keine nummerierte Gleichung. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`section_id` = @section_id;

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`section_id` = @section_id;

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`section_id` = @section_id;

DELETE FROM `equations`
WHERE `section_id` = @section_id;

/* 6. Sicherstellen, dass diesem Abschnitt noch kein Axiom zugeordnet ist. */
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` IN (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`section_id` = @section_id
);

DELETE FROM `axioms`
WHERE `section_id` = @section_id;

/* 7. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.3.2',
    'Abschnitt 3.3.2 wurde vollständig als wissenschaftstheoretische Begründung der primitiven Begriffe neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.2.',
    'Neufassung mit den Quellen [8], [18] und [24], ohne nummerierte Gleichung und ohne Axiom.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'sources',
    '[8], [18], [24]',
    'Drei vorhandene Grundlagenquellen wurden für die methodische Begründung der primitiven Begriffe registriert.',
    NULL,
    '3 Quellenverwendungen'
),
(
    @revision_id,
    @section_id,
    'other',
    'repository',
    'Bereinigung 3.3.2',
    'Nicht mehr zur Neufassung gehörende Gleichungen und Axiome wurden aus Abschnitt 3.3.2 entfernt.',
    'Mögliche ältere Zuordnungen.',
    '0 Gleichungen und 0 Axiome in Abschnitt 3.3.2.'
);

/* 8. Bearbeitungsstand aktualisieren.
      Literatur- und Gleichungszähler bleiben unverändert. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section', '3.3.2'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.2-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.3.2: review
   - Originalbeitrag: 1
   - Quellenverwendungen: 3
   - Quellen: [8], [18], [24]
   - Gleichungen: 0
   - Axiome: 0
   - Literatur- und Gleichungszähler unverändert
   ============================================================ */

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    ds.`notes`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.2')
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
    COUNT(*) AS `equations_in_section`
FROM `equations`
WHERE `section_id` = @section_id;

SELECT
    COUNT(*) AS `axioms_in_section`
FROM `axioms`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
