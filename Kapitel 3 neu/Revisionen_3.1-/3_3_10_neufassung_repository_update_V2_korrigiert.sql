USE `frzk_rkb`;
SET NAMES utf8mb4;

/* ============================================================
   KORRIGIERTE FASSUNG – Abschnitt 3.3.10
   Übergang zur mathematischen Rekonstruktion

   Fehlerursache der vorherigen Fassung:
   In dissertation_sections existierte kein Datensatz mit
   section_code = '3.3.10'. Dadurch blieb @section_id NULL.
   Der INSERT in section_change_log verletzte deshalb den
   Fremdschlüssel fk_change_section.

   Diese Fassung:
   1. legt 3.3.10 bei Bedarf zuerst an,
   2. ermittelt danach die section_id,
   3. bricht bei fehlendem Kapitel 3.3 kontrolliert ab,
   4. aktualisiert anschließend Revision, Metadaten, Log und Zähler.
   ============================================================ */

START TRANSACTION;

/* 1. Übergeordnetes Kapitel 3.3 ermitteln. */
SET @chapter_33_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3'
    LIMIT 1
);

/* 2. Abschnitt 3.3.10 anlegen, falls er im Repository fehlt.
      section_order 3.4910 liegt zwischen 3.3.9 (3.4900)
      und Kapitel 3.4 (3.5000). */
INSERT INTO `dissertation_sections` (
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`,
    `notes`
)
SELECT
    @chapter_33_id,
    '3.3.10',
    'Übergang zur mathematischen Rekonstruktion',
    3,
    3.4910,
    'review',
    1,
    'Übergangsabschnitt zwischen der qualitativen Axiomatik in Kapitel 3.3 und der mathematischen Rekonstruktion in Kapitel 3.4.'
WHERE @chapter_33_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections` ds
      WHERE ds.`section_code` = '3.3.10'
  );

/* 3. Abschnitts-ID jetzt sicher ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3.10'
    LIMIT 1
);

/* 4. Revision idempotent anlegen oder wiederverwenden. */
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
SELECT
    'RKB-2026-07-12-K3.3.10-NEUFASSUNG-V2',
    NOW(),
    'section',
    '3.3.10',
    '2.0',
    'Korrigierte Neufassung von Abschnitt 3.3.10; der fehlende Abschnitt wird vor allen abhängigen Einträgen angelegt.',
    'Olaf Thiele / ChatGPT',
    (
        SELECT MAX(r.`revision_id`)
        FROM `repository_revisions` r
    )
WHERE @section_id IS NOT NULL
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* 5. Abschnitt 3.3.10 aktualisieren. */
UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_33_id,
    `title` = 'Übergang zur mathematischen Rekonstruktion',
    `chapter_no` = 3,
    `section_order` = 3.4910,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt schließt die qualitative Axiomatik ab und begründet die methodische Reihenfolge der mathematischen Rekonstruktion in Kapitel 3.4. Keine neue Literaturquelle, kein neues Axiom, keine neue Proposition und keine neue Gleichung.'
WHERE `section_id` = @section_id;

/* 6. Kapitel 3.3 als inhaltlich vollständig, aber noch im Review markieren. */
UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 ist inhaltlich vollständig entwickelt. Es umfasst die wissenschaftstheoretische Begründung, die fünf Grundaxiome A1 bis A5, deren Zusammenfassung, Proposition Prop. 3.1 und den Übergang zur mathematischen Rekonstruktion. Die abschließende Endredaktion steht noch aus.'
WHERE `section_id` = @chapter_33_id;

/* 7. Abschnitt 3.3.10 enthält bewusst keine Quellenverwendungen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 8. Abschnitt 3.3.10 enthält bewusst keine Gleichungen.
      Nur möglicherweise fälschlich diesem Abschnitt zugeordnete
      Gleichungen werden entfernt. Die Gleichungen anderer
      Abschnitte bleiben unberührt. */
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

/* 9. Änderungsprotokoll idempotent aktualisieren.
      Der Fremdschlüssel ist nun gültig, weil @section_id
      garantiert aus dissertation_sections stammt. */
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
SELECT
    @revision_id,
    @section_id,
    'rewritten',
    'section',
    '3.3.10',
    'Abschnitt 3.3.10 wurde vollständig als Übergang zur mathematischen Rekonstruktion neu gefasst.',
    'Der Abschnitt fehlte im Repository beziehungsweise war noch nicht als eigener Datensatz registriert.',
    'Methodischer Abschluss der Axiomatik und Vorbereitung der mathematischen Rekonstruktion in Kapitel 3.4.'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL;

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
SELECT
    @revision_id,
    @section_id,
    'status_changed',
    'chapter',
    '3.3',
    'Kapitel 3.3 wurde als inhaltlich vollständig entwickelt und weiterhin im Status review gekennzeichnet.',
    'Kapitel 3.3 in laufender Bearbeitung.',
    'Kapitel 3.3 inhaltlich vollständig; Endredaktion ausstehend.'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL;

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
SELECT
    @revision_id,
    @section_id,
    'other',
    'transition',
    '3.3 -> 3.4',
    'Der Übergang von der qualitativen Axiomatik zur mathematischen Rekonstruktion wurde im Repository dokumentiert.',
    'Kein eigener Übergangsabschnitt im Repository.',
    'Abschnitt 3.3.10 als Übergang zu Kapitel 3.4 angelegt.'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL;

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
SELECT
    @revision_id,
    @section_id,
    'other',
    'repository',
    'Fachobjekte 3.3.10',
    'Es wurden bewusst keine Quellen, Axiome, Propositionen oder Gleichungen angelegt.',
    NULL,
    'Metadatenrevision ohne neue fachliche Objekte.'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL;

/* 10. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.74'),
    ('next_proposition_number', 'Prop. 3.2'),
    ('next_axiom_number', 'COMPLETE'),
    ('axiom_system_status', 'A1-A5 complete'),
    ('chapter_3_3_status', 'content_complete_review_pending'),
    ('next_section', '3.4.1'),
    ('last_edited_section', '3.3.10'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.10-NEUFASSUNG-V2')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - 3.3.10 existiert genau einmal
   - parent_section_id verweist auf Kapitel 3.3
   - section_order = 3.4910
   - Status = review
   - 4 Logeinträge für die neue Revision
   - keine Quellenverwendungen
   - keine Gleichungen in 3.3.10
   ============================================================ */

SELECT
    ds.`section_id`,
    ds.`parent_section_id`,
    parent_ds.`section_code` AS `parent_section_code`,
    ds.`section_code`,
    ds.`title`,
    ds.`section_order`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` parent_ds
    ON parent_ds.`section_id` = ds.`parent_section_id`
WHERE ds.`section_code` = '3.3.10';

SELECT
    rr.`revision_id`,
    rr.`revision_code`,
    rr.`scope_reference`,
    rr.`version_label`,
    rr.`revision_date`
FROM `repository_revisions` rr
WHERE rr.`revision_code` = 'RKB-2026-07-12-K3.3.10-NEUFASSUNG-V2';

SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id` = @revision_id
  AND scl.`section_id` = @section_id
ORDER BY scl.`change_id`;

SELECT
    COUNT(*) AS `source_usages_in_3_3_10`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    COUNT(*) AS `equations_in_3_3_10`
FROM `equations`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_equation_number',
    'next_proposition_number',
    'next_axiom_number',
    'axiom_system_status',
    'chapter_3_3_status',
    'next_section',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
