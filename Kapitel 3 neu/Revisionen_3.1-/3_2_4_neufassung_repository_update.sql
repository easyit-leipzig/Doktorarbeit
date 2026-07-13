USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.4
   Algebraische Strukturen als Grundlage mathematischer Verknüpfungen

   Verwendete bestehende Quellen:
   [31] Dummit / Foote
   [32] Lang
   [33] Hall
   [34] Artin

   Gleichungen:
   (3.14) Innere Verknüpfung
   (3.15) Abgeschlossenheit
   (3.16) Assoziativität
   (3.17) Neutrales Element
   (3.18) Inverses Element

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
    'RKB-2026-07-12-K3.2.4-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.4',
    '1.0',
    'Neufassung von Abschnitt 3.2.4 mit den Gleichungen (3.14) bis (3.18) und den bestehenden Quellen [31] bis [34].',
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

/* 2. Abschnitt ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.4'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Algebraische Strukturen als Grundlage mathematischer Verknüpfungen',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [31] bis [34] und enthält die Gleichungen (3.14) bis (3.18).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* 4. Quellenverwendungen des Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* [31] Dummit / Foote */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Dummit und Foote dienen als Hauptreferenz für Halbgruppen, Monoide, Gruppen, Ringe und Körper.',
    'Abschnitt 3.2.4', 0, 1,
    'Wiederverwendung der bereits vorhandenen Quelle [31].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 31;

/* [32] Lang */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Lang dient als Referenz für abstrakte algebraische Verknüpfungen und Gruppenstrukturen.',
    'Abschnitt 3.2.4', 0, 1,
    'Wiederverwendung der bereits vorhandenen Quelle [32].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 32;

/* [33] Hall */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Hall dient als Referenz für Lie-Gruppen und deren Bedeutung für kontinuierliche Transformationen und Symmetrien.',
    'Abschnitt 3.2.4', 0, 1,
    'Wiederverwendung der bereits vorhandenen Quelle [33].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 33;

/* [34] Artin */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Artin dient als ergänzende Referenz für Gruppen, Vektorräume und algebraische Strukturbegriffe.',
    'Abschnitt 3.2.4', 0, 1,
    'Wiederverwendung der bereits vorhandenen Quelle [34].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 34;

/* 5. Quellen-IDs bestimmen. */
SET @source_31_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 31
    LIMIT 1
);

SET @source_32_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 32
    LIMIT 1
);

/* 6. Alte Belegungen der Gleichungsnummern (3.14) bis (3.18) bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.14','3.15','3.16','3.17','3.18');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.14','3.15','3.16','3.17','3.18');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.14','3.15','3.16','3.17','3.18');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.14','3.15','3.16','3.17','3.18');

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
    '3.14',
    @section_id,
    'Innere Verknüpfung',
    '\\circ:A\\times A\\rightarrow A',
    '\\circ:A\\times A\\rightarrow A',
    'Eine innere Verknüpfung ordnet jedem Paar aus A mal A wieder ein Element aus A zu.',
    'definition',
    'literature',
    @source_31_id,
    NULL,
    'A ist eine Menge und die Verknüpfung ist auf A definiert.',
    'checked',
    @revision_id
),
(
    '3.15',
    @section_id,
    'Abgeschlossenheit',
    '\\forall a,b\\in A:\\;a\\circ b\\in A',
    '\\forall a,b\\in A:\\;a\\circ b\\in A',
    'Die Verknüpfung zweier Elemente aus A liefert erneut ein Element aus A.',
    'definition',
    'literature',
    @source_31_id,
    NULL,
    'Die Verknüpfung ist eine innere Verknüpfung auf A.',
    'checked',
    @revision_id
),
(
    '3.16',
    @section_id,
    'Assoziativität',
    '(a\\circ b)\\circ c=a\\circ(b\\circ c)',
    '(a\\circ b)\\circ c=a\\circ(b\\circ c)',
    'Die Klammerung dreier verknüpfter Elemente verändert das Ergebnis nicht.',
    'definition',
    'literature',
    @source_31_id,
    NULL,
    'a, b und c gehören zu A.',
    'checked',
    @revision_id
),
(
    '3.17',
    @section_id,
    'Neutrales Element',
    'e\\circ a=a\\circ e=a',
    'e\\circ a=a\\circ e=a',
    'Das neutrale Element e verändert ein Element a bei der Verknüpfung nicht.',
    'definition',
    'literature',
    @source_32_id,
    NULL,
    'e und a gehören zu A.',
    'checked',
    @revision_id
),
(
    '3.18',
    @section_id,
    'Inverses Element',
    'a\\circ a^{-1}=a^{-1}\\circ a=e',
    'a\\circ a^{-1}=a^{-1}\\circ a=e',
    'Die Verknüpfung eines Elements mit seinem inversen Element ergibt das neutrale Element.',
    'definition',
    'literature',
    @source_32_id,
    NULL,
    'A besitzt ein neutrales Element e und zu a existiert ein inverses Element.',
    'checked',
    @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_14 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.14'
    LIMIT 1
);
SET @eq_3_15 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.15'
    LIMIT 1
);
SET @eq_3_16 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.16'
    LIMIT 1
);
SET @eq_3_17 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.17'
    LIMIT 1
);
SET @eq_3_18 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.18'
    LIMIT 1
);

/* 9. Symbolregister anlegen. */
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
(@eq_3_14, '\\circ', 'innere Verknüpfung', 'Binäre Verknüpfung auf der Menge A.', NULL, '\\circ:A\\times A\\rightarrow A', 1),
(@eq_3_14, 'A', 'Trägermenge', 'Menge, auf der die Verknüpfung definiert ist.', NULL, 'Menge', 2),

(@eq_3_15, 'a', 'erstes Element', 'Erstes Element der Verknüpfung.', NULL, 'a\\in A', 1),
(@eq_3_15, 'b', 'zweites Element', 'Zweites Element der Verknüpfung.', NULL, 'b\\in A', 2),
(@eq_3_15, '\\circ', 'Verknüpfung', 'Innere Verknüpfung auf A.', NULL, 'A\\times A\\rightarrow A', 3),

(@eq_3_16, 'a', 'erstes Element', 'Erstes Element der assoziativen Verknüpfung.', NULL, 'a\\in A', 1),
(@eq_3_16, 'b', 'zweites Element', 'Zweites Element der assoziativen Verknüpfung.', NULL, 'b\\in A', 2),
(@eq_3_16, 'c', 'drittes Element', 'Drittes Element der assoziativen Verknüpfung.', NULL, 'c\\in A', 3),

(@eq_3_17, 'e', 'neutrales Element', 'Element, das andere Elemente bei der Verknüpfung unverändert lässt.', NULL, 'e\\in A', 1),
(@eq_3_17, 'a', 'beliebiges Element', 'Beliebiges Element der Trägermenge A.', NULL, 'a\\in A', 2),

(@eq_3_18, 'a^{-1}', 'inverses Element', 'Zu a inverses Element bezüglich der Verknüpfung.', NULL, 'a^{-1}\\in A', 1),
(@eq_3_18, 'a', 'Ausgangselement', 'Element, zu dem das inverse Element gehört.', NULL, 'a\\in A', 2),
(@eq_3_18, 'e', 'neutrales Element', 'Ergebnis der Verknüpfung eines Elements mit seinem Inversen.', NULL, 'e\\in A', 3);

/* 10. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_3_15,
    @eq_3_14,
    'uses',
    'Die Abgeschlossenheit konkretisiert die innere Verknüpfung aus Gleichung (3.14).'
),
(
    @eq_3_16,
    @eq_3_14,
    'uses',
    'Die Assoziativität setzt die innere Verknüpfung aus Gleichung (3.14) voraus.'
),
(
    @eq_3_17,
    @eq_3_14,
    'uses',
    'Das neutrale Element wird bezüglich der inneren Verknüpfung definiert.'
),
(
    @eq_3_18,
    @eq_3_17,
    'uses',
    'Die Definition des inversen Elements setzt die Existenz des neutralen Elements voraus.'
);

/* 11. Änderungsprotokoll aktualisieren. */
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
    '3.2.4',
    'Abschnitt 3.2.4 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit älterer Gleichungsnummerierung.',
    'Neufassung mit den Quellen [31] bis [34] und den Gleichungen (3.14) bis (3.18).'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'sources',
    '[31]–[34]',
    'Die bereits vorhandenen algebraischen Standardwerke wurden wiederverwendet.',
    NULL,
    '4 Quellenverwendungen'
),
(
    @revision_id,
    @section_id,
    'equation_changed',
    'equations',
    '(3.14)–(3.18)',
    'Die Gleichungsnummern wurden bereinigt und mit den algebraischen Definitionen der Neufassung neu belegt.',
    'Ältere Relations- und Funktionsgleichungen unter denselben Nummern.',
    'Innere Verknüpfung, Abgeschlossenheit, Assoziativität, neutrales Element und inverses Element.'
);

/* 12. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.19'),
    ('last_edited_section', '3.2.4'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.4-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.4: review
   - 4 Quellenverwendungen: [31], [32], [33], [34]
   - 0 Erstnennungen
   - Gleichungen (3.14) bis (3.18)
   - next_citation_number = 59
   - next_equation_number = 3.19
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.4')
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
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`section_id` = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED);

SELECT
    ed.`dependency_type`,
    e1.`equation_number` AS `equation_number`,
    e2.`equation_number` AS `depends_on`,
    ed.`dependency_note`
FROM `equation_dependencies` ed
INNER JOIN `equations` e1
    ON e1.`equation_id` = ed.`equation_id`
INNER JOIN `equations` e2
    ON e2.`equation_id` = ed.`depends_on_equation_id`
WHERE e1.`section_id` = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e1.`equation_number`, '.', -1) AS UNSIGNED);

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
