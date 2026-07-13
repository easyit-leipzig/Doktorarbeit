USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.1.4 – Forschungsstand zur Emergenz von Raum und Zeit
   Repository-konsistente Literaturnummerierung:
   [19] Rovelli (bereits vorhanden)
   [21] Wheeler (bereits vorhanden)
   [53] Thiemann
   [54] Bombelli et al.
   [55] Van Raamsdonk
   [56] Swingle
   [57] Verlinde
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
    'RKB-2026-07-12-K3.1.4-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.1.4',
    '1.0',
    'Neufassung von Abschnitt 3.1.4; Registrierung des Forschungsstands zur Emergenz von Raum und Zeit mit zwei wiederverwendeten und fünf neuen Quellen.',
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
    WHERE ds.`section_code` = '3.1.4'
    LIMIT 1
);

/* 2. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Der Forschungsstand zur Emergenz von Raum und Zeit',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Forschungsstand zu Schleifenquantengravitation, Causal-Set-Theorie, Holographie, Tensornetzwerken, emergenter Gravitation und informationeller Physik. Keine nummerierte Gleichung.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `notes` = 'Kapitel 3.1 befindet sich aufgrund der abschnittsweisen Neufassung im Review-Status.'
WHERE `section_code` = '3.1';

/* 3. Autoren idempotent anlegen. */
INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Thiemann', 'Thomas', 'Thiemann, Thomas')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_thiemann := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Bombelli', 'Luca', 'Bombelli, Luca')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_bombelli := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Lee', 'Joohan', 'Lee, Joohan')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_lee := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Meyer', 'David', 'Meyer, David')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_meyer := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Sorkin', 'Rafael D.', 'Sorkin, Rafael D.')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_sorkin := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Van Raamsdonk', 'Mark', 'Van Raamsdonk, Mark')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_vanraamsdonk := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Swingle', 'Brian', 'Swingle, Brian')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_swingle := LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`, `given_names`, `normalized_name`)
VALUES ('Verlinde', 'Erik', 'Verlinde, Erik')
ON DUPLICATE KEY UPDATE `author_id` = LAST_INSERT_ID(`author_id`);
SET @author_verlinde := LAST_INSERT_ID();

/* 4. Neue Quellen [53] bis [57] idempotent anlegen. */

INSERT INTO `sources` (
    `citation_number`, `source_key`, `source_type`, `title`,
    `year_original`, `year_edition`, `publisher`, `place`,
    `language_code`, `priority`, `evidence_type`, `frzk_relevance`,
    `verification_status`, `first_citation_section_code`,
    `full_citation_text`, `short_citation_text`, `notes`,
    `created_revision_id`
)
VALUES (
    53, 'thiemann_modern_canonical_qgr_2007', 'book',
    'Modern Canonical Quantum General Relativity',
    2007, 2007, 'Cambridge University Press', 'Cambridge',
    'en', 5, 'reference', 4, 'partially_verified', '3.1.4',
    'Thiemann, Thomas: Modern Canonical Quantum General Relativity. Cambridge: Cambridge University Press, 2007.',
    'Thiemann [53]',
    'Grundlagenwerk zur kanonischen Schleifenquantengravitation.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `title` = VALUES(`title`),
    `publisher` = VALUES(`publisher`),
    `place` = VALUES(`place`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `first_citation_section_code` = VALUES(`first_citation_section_code`),
    `created_revision_id` = VALUES(`created_revision_id`);
SET @source_thiemann := LAST_INSERT_ID();

INSERT INTO `sources` (
    `citation_number`, `source_key`, `source_type`, `title`,
    `year_original`, `year_edition`, `journal`, `volume`, `pages`,
    `doi`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`,
    `verification_status`, `first_citation_section_code`,
    `full_citation_text`, `short_citation_text`, `notes`,
    `created_revision_id`
)
VALUES (
    54, 'bombelli_lee_meyer_sorkin_causal_set_1987', 'journal_article',
    'Space-Time as a Causal Set',
    1987, 1987, 'Physical Review Letters', '59', '521–524',
    '10.1103/PhysRevLett.59.521', 'en', 5, 'primary', 5,
    'verified', '3.1.4',
    'Bombelli, Luca; Lee, Joohan; Meyer, David; Sorkin, Rafael D.: Space-Time as a Causal Set. Physical Review Letters, 59, 1987, S. 521–524.',
    'Bombelli et al. [54]',
    'Originäre Arbeit zur Causal-Set-Theorie.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `journal` = VALUES(`journal`),
    `volume` = VALUES(`volume`),
    `pages` = VALUES(`pages`),
    `doi` = VALUES(`doi`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `created_revision_id` = VALUES(`created_revision_id`);
SET @source_bombelli := LAST_INSERT_ID();

INSERT INTO `sources` (
    `citation_number`, `source_key`, `source_type`, `title`,
    `year_original`, `year_edition`, `journal`, `volume`, `pages`,
    `doi`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`,
    `verification_status`, `first_citation_section_code`,
    `full_citation_text`, `short_citation_text`, `notes`,
    `created_revision_id`
)
VALUES (
    55, 'van_raamsdonk_building_spacetime_2010', 'journal_article',
    'Building up Spacetime with Quantum Entanglement',
    2010, 2010, 'General Relativity and Gravitation', '42', '2323–2329',
    '10.1007/s10714-010-1034-0', 'en', 5, 'primary', 5,
    'verified', '3.1.4',
    'Van Raamsdonk, Mark: Building up Spacetime with Quantum Entanglement. General Relativity and Gravitation, 42, 2010, S. 2323–2329.',
    'Van Raamsdonk [55]',
    'Grundlegende Arbeit zur Rekonstruktion von Raumzeit aus Quantenverschränkung.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `journal` = VALUES(`journal`),
    `volume` = VALUES(`volume`),
    `pages` = VALUES(`pages`),
    `doi` = VALUES(`doi`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `created_revision_id` = VALUES(`created_revision_id`);
SET @source_vanraamsdonk := LAST_INSERT_ID();

INSERT INTO `sources` (
    `citation_number`, `source_key`, `source_type`, `title`,
    `year_original`, `year_edition`, `journal`, `volume`, `issue`,
    `doi`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`,
    `verification_status`, `first_citation_section_code`,
    `full_citation_text`, `short_citation_text`, `notes`,
    `created_revision_id`
)
VALUES (
    56, 'swingle_entanglement_renormalization_2012', 'journal_article',
    'Entanglement Renormalization and Holography',
    2012, 2012, 'Physical Review D', '86', '6',
    '10.1103/PhysRevD.86.065007', 'en', 5, 'primary', 5,
    'verified', '3.1.4',
    'Swingle, Brian: Entanglement Renormalization and Holography. Physical Review D, 86(6), 2012, 065007.',
    'Swingle [56]',
    'Originäre Arbeit zur Verbindung von Tensornetzwerken und holographischer Geometrie.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `journal` = VALUES(`journal`),
    `volume` = VALUES(`volume`),
    `issue` = VALUES(`issue`),
    `doi` = VALUES(`doi`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `created_revision_id` = VALUES(`created_revision_id`);
SET @source_swingle := LAST_INSERT_ID();

INSERT INTO `sources` (
    `citation_number`, `source_key`, `source_type`, `title`,
    `year_original`, `year_edition`, `journal`, `volume`,
    `doi`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`,
    `verification_status`, `first_citation_section_code`,
    `full_citation_text`, `short_citation_text`, `notes`,
    `created_revision_id`
)
VALUES (
    57, 'verlinde_origin_gravity_2011', 'journal_article',
    'On the Origin of Gravity and the Laws of Newton',
    2011, 2011, 'Journal of High Energy Physics', '2011',
    '10.1007/JHEP04(2011)029', 'en', 5, 'primary', 4,
    'verified', '3.1.4',
    'Verlinde, Erik: On the Origin of Gravity and the Laws of Newton. Journal of High Energy Physics, 2011(4), Artikel 29.',
    'Verlinde [57]',
    'Arbeit zur Interpretation der Gravitation als emergentes bzw. entropisches Phänomen.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `source_id` = LAST_INSERT_ID(`source_id`),
    `journal` = VALUES(`journal`),
    `volume` = VALUES(`volume`),
    `doi` = VALUES(`doi`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `created_revision_id` = VALUES(`created_revision_id`);
SET @source_verlinde := LAST_INSERT_ID();

/* 5. Autoren-Zuordnungen idempotent erneuern. */
DELETE FROM `source_authors`
WHERE `source_id` IN (
    @source_thiemann, @source_bombelli, @source_vanraamsdonk,
    @source_swingle, @source_verlinde
);

INSERT INTO `source_authors` (`source_id`, `author_id`, `author_order`, `role`) VALUES
(@source_thiemann, @author_thiemann, 1, 'author'),
(@source_bombelli, @author_bombelli, 1, 'author'),
(@source_bombelli, @author_lee, 2, 'author'),
(@source_bombelli, @author_meyer, 3, 'author'),
(@source_bombelli, @author_sorkin, 4, 'author'),
(@source_vanraamsdonk, @author_vanraamsdonk, 1, 'author'),
(@source_swingle, @author_swingle, 1, 'author'),
(@source_verlinde, @author_verlinde, 1, 'author');

/* 6. Quellenverwendungen des Abschnitts vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`,
    @section_id,
    u.`usage_type`,
    u.`claim_summary`,
    'Abschnitt 3.1.4',
    u.`is_first_mention`,
    u.`citation_checked`,
    u.`notes`,
    @revision_id
FROM (
    SELECT 19 AS citation_number,
           'state_of_research' AS usage_type,
           'Schleifenquantengravitation als Ansatz diskreter und quantisierter Geometrie.' AS claim_summary,
           0 AS is_first_mention,
           1 AS citation_checked,
           'Quelle war bereits im Repository vorhanden.' AS notes
    UNION ALL SELECT 53, 'first_citation',
           'Kanonische und mathematische Grundlagen der Schleifenquantengravitation.',
           1, 1, 'Neue Quelle des Abschnitts.'
    UNION ALL SELECT 54, 'first_citation',
           'Causal-Set-Theorie: Raumzeit als diskrete kausale Ordnungsstruktur.',
           1, 1, 'Neue Quelle des Abschnitts.'
    UNION ALL SELECT 55, 'first_citation',
           'Rekonstruktion von Raumzeitgeometrie aus Quantenverschränkung.',
           1, 1, 'Neue Quelle des Abschnitts.'
    UNION ALL SELECT 56, 'first_citation',
           'Tensornetzwerke und Entanglement-Renormalisierung als holographische Geometriestruktur.',
           1, 1, 'Neue Quelle des Abschnitts.'
    UNION ALL SELECT 57, 'first_citation',
           'Gravitation als emergentes beziehungsweise entropisches Phänomen.',
           1, 1, 'Neue Quelle des Abschnitts.'
    UNION ALL SELECT 21, 'state_of_research',
           'Information als möglicher Ausgangspunkt physikalischer Realität im It-from-Bit-Ansatz.',
           0, 1, 'Wheeler ist bereits als Quelle [21] im Repository vorhanden.'
) AS u
INNER JOIN `sources` s
    ON s.`citation_number` = u.`citation_number`;

/* 7. Änderungsprotokoll idempotent aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.1.4',
    'Abschnitt 3.1.4 wurde vollständig als Forschungsstand zur Emergenz von Raum und Zeit neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.1.4.',
    'Neufassung mit sieben Quellenverwendungen und ohne nummerierte Gleichung.'
),
(
    @revision_id, @section_id, 'source_added', 'sources', '[53]–[57]',
    'Fünf neue Quellen zur Schleifenquantengravitation, Causal-Set-Theorie, Verschränkungsgeometrie, Tensornetzwerken und emergenter Gravitation wurden ergänzt.',
    NULL, '5 neue Quellen'
),
(
    @revision_id, @section_id, 'source_reused', 'sources', '[19], [21]',
    'Rovelli und Wheeler wurden mit ihren vorhandenen Repositorynummern wiederverwendet.',
    NULL, '2 wiederverwendete Quellen'
),
(
    @revision_id, @section_id, 'status_changed', 'section', '3.1.4',
    'Abschnitt 3.1.4 wurde für die Endredaktion auf review gesetzt.',
    'final', 'review'
);

/* 8. Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '58'),
    ('last_edited_section', '3.1.4'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.1.4-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* Keine Gleichung hinzugefügt: next_equation_number bleibt unverändert. */

COMMIT;

/* 9. Kontrollabfragen.
   Erwartet:
   - Abschnitt 3.1.4: review
   - 7 Quellenverwendungen
   - 5 Erstnennungen
   - verwendete Nummern: 19, 21, 53, 54, 55, 56, 57
   - nächste freie Literaturnummer: 58
   - 0 Gleichungen im Abschnitt
*/
SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` = '3.1.4';

SELECT
    COUNT(*) AS `registered_source_usages`,
    SUM(su.`is_first_mention`) AS `first_mentions_in_section`,
    GROUP_CONCAT(s.`citation_number` ORDER BY s.`citation_number` SEPARATOR ', ') AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id;

SELECT
    s.`citation_number`,
    s.`full_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN ('next_citation_number', 'next_equation_number');

SELECT
    COUNT(*) AS `equations_in_section`
FROM `equations`
WHERE `section_id` = @section_id;
