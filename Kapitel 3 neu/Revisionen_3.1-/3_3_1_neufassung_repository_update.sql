USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.1
   Motivation einer axiomatischen Rekonstruktion

   Neue Quellen:     keine
   Quellenverwendung: keine
   Neue Gleichungen: keine

   Die vorhandenen Literatur- und Gleichungszähler werden nicht
   verändert. Das Skript aktualisiert ausschließlich Revision,
   Abschnittsmetadaten, Änderungsprotokoll und Bearbeitungsstand.
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
    'RKB-2026-07-12-K3.3.1-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.1',
    '1.0',
    'Neufassung von Abschnitt 3.3.1 als Motivation der axiomatischen Rekonstruktion; keine neuen Quellen und keine neuen Gleichungen.',
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
    WHERE ds.`section_code` = '3.3.1'
    LIMIT 1
);

SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3'
    LIMIT 1
);

/* 3. Existenzkontrolle. */
SELECT
    CASE
        WHEN @section_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.1 wurde nicht gefunden.'
        ELSE CONCAT('OK: section_id=', @section_id)
    END AS `section_validation`,
    CASE
        WHEN @chapter_id IS NULL
            THEN 'FEHLER: Kapitel 3.3 wurde nicht gefunden.'
        ELSE CONCAT('OK: chapter_id=', @chapter_id)
    END AS `chapter_validation`;

/* 4. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Motivation einer axiomatischen Rekonstruktion',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt begründet den Übergang vom mathematischen Forschungsstand zur eigenständigen FRZK-Axiomatik. Er enthält keine neue Literaturquelle und keine nummerierte Gleichung.'
WHERE `section_id` = @section_id;

/* 5. Übergeordnetes Kapitel im Review-Status halten. */
UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 wird abschnittsweise als eigenständige axiomatische Grundlage des Funktionalen Raum-Zeit-Kohärenzsystems neu gefasst.'
WHERE `section_id` = @chapter_id;

/* 6. Frühere Quellenverwendungen des Abschnitts entfernen.
      Die Neufassung von 3.3.1 enthält bewusst keine Zitate. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 7. Sicherstellen, dass dem Abschnitt keine Gleichungen
      aus einer älteren Fassung zugeordnet bleiben.

      Es werden nur Gleichungen entfernt, die aktuell unmittelbar
      Abschnitt 3.3.1 zugeordnet sind. Abhängige Registereinträge
      werden vorher gelöscht. */
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

/* 8. Änderungsprotokoll für diese Revision idempotent ersetzen. */
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
    '3.3.1',
    'Abschnitt 3.3.1 wurde vollständig als Motivation einer axiomatischen Rekonstruktion neu gefasst.',
    'Primitive Begriffe und axiomatische Ausgangspunkte; ältere Quellenverwendungen und gegebenenfalls ältere Gleichungszuordnungen.',
    'Motivation einer axiomatischen Rekonstruktion; keine Quellenverwendung und keine nummerierte Gleichung.'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.3.1',
    'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.',
    'review',
    'review'
),
(
    @revision_id,
    @section_id,
    'other',
    'repository',
    'Quellen- und Gleichungsbereinigung 3.3.1',
    'Nicht mehr zur Neufassung gehörende Quellenverwendungen und Gleichungszuordnungen wurden entfernt.',
    'Ältere Repository-Zuordnungen zu Abschnitt 3.3.1.',
    '0 Quellenverwendungen und 0 Gleichungen in Abschnitt 3.3.1.'
);

/* 9. Bearbeitungsstand aktualisieren.
      Literatur- und Gleichungszähler bleiben unverändert. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section', '3.3.1'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.1-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.3.1: review
   - Originalbeitrag: 1
   - Quellenverwendungen: 0
   - Gleichungen: 0
   - next_citation_number unverändert
   - next_equation_number unverändert
   ============================================================ */

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    ds.`notes`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.1')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`
FROM `source_usage`
WHERE `section_id` = @section_id;

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
