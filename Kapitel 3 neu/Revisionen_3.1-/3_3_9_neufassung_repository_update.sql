USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.9
   Erste Proposition des Funktionalen Raum-Zeit-Kohärenzsystems

   Neue Quellen:       keine
   Proposition:        Prop. 3.1
   Neue Gleichung:     (3.73)
   Abhängigkeiten:     Prop. 3.1 verwendet A1 bis A5
   Nächste Gleichung:  (3.74)

   Bestehende Proposition Prop. 3.1 wird aktualisiert, damit ihre
   proposition_id erhalten bleibt. Veraltete Propositionen
   Prop. 3.2 bis Prop. 3.5 aus der früheren Abschnittsfassung
   werden nach Bereinigung ihrer Abhängigkeiten entfernt.
   ============================================================ */

/* 1. Revision idempotent anlegen bzw. wiederverwenden. */
INSERT INTO `repository_revisions` (
    `revision_code`, `revision_date`, `scope_type`, `scope_reference`,
    `version_label`, `summary`, `created_by`, `parent_revision_id`
)
VALUES (
    'RKB-2026-07-12-K3.3.9-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.9',
    '1.0',
    'Neufassung von Abschnitt 3.3.9 mit Proposition Prop. 3.1 und Gleichung (3.73).',
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

/* 2. Abschnitts- und Kapitel-ID ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.3.9'
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
    `title` = 'Erste Proposition des Funktionalen Raum-Zeit-Kohärenzsystems',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Proposition Prop. 3.1 sowie Gleichung (3.73). Keine neue Literaturquelle.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 enthält die fünf Grundaxiome und die erste daraus formulierte Proposition.'
WHERE `section_id` = @chapter_id;

/* 4. Abschnitt enthält bewusst keine Literaturverwendung. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 5. Axiom-IDs ermitteln. */
SET @axiom_a1_id := (SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A1' LIMIT 1);
SET @axiom_a2_id := (SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A2' LIMIT 1);
SET @axiom_a3_id := (SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A3' LIMIT 1);
SET @axiom_a4_id := (SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A4' LIMIT 1);
SET @axiom_a5_id := (SELECT `axiom_id` FROM `axioms` WHERE `axiom_number`='A5' LIMIT 1);

/* 6. Bestehende Proposition Prop. 3.1 ermitteln. */
SET @proposition_id := (
    SELECT p.`proposition_id`
    FROM `propositions` p
    WHERE p.`proposition_number` = 'Prop. 3.1'
    LIMIT 1
);

/* 7. Prop. 3.1 aktualisieren. */
UPDATE `propositions`
SET
    `section_id` = @section_id,
    `title` = 'Möglichkeit funktionaler Entwicklungsprozesse',
    `statement_text` = 'Aus der gemeinsamen Annahme der fünf Grundaxiome folgt, dass funktionale Entwicklungsprozesse grundsätzlich möglich sind.',
    `statement_latex` = '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F',
    `word_latex` = '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F',
    `logical_derivation` = 'A1 eröffnet funktionale Unterscheidbarkeit, A2 funktionale Relationierbarkeit, A3 rekursive Transformation, A4 stabile Organisation und A5 reproduzierbare Organisationsmuster. Gemeinsam eröffnen sie die Möglichkeit eines funktionalen Entwicklungsprozesses.',
    `based_on_axioms` = 'A1,A2,A3,A4,A5',
    `status` = 'review',
    `created_revision_id` = @revision_id
WHERE `proposition_id` = @proposition_id;

/* 8. Falls Prop. 3.1 fehlt, ergänzen. */
INSERT INTO `propositions` (
    `proposition_number`, `section_id`, `title`, `statement_text`,
    `statement_latex`, `word_latex`, `logical_derivation`,
    `based_on_axioms`, `status`, `created_revision_id`
)
SELECT
    'Prop. 3.1',
    @section_id,
    'Möglichkeit funktionaler Entwicklungsprozesse',
    'Aus der gemeinsamen Annahme der fünf Grundaxiome folgt, dass funktionale Entwicklungsprozesse grundsätzlich möglich sind.',
    '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F',
    '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F',
    'A1 eröffnet funktionale Unterscheidbarkeit, A2 funktionale Relationierbarkeit, A3 rekursive Transformation, A4 stabile Organisation und A5 reproduzierbare Organisationsmuster. Gemeinsam eröffnen sie die Möglichkeit eines funktionalen Entwicklungsprozesses.',
    'A1,A2,A3,A4,A5',
    'review',
    @revision_id
WHERE @proposition_id IS NULL;

SET @proposition_id := (
    SELECT p.`proposition_id`
    FROM `propositions` p
    WHERE p.`proposition_number` = 'Prop. 3.1'
    LIMIT 1
);

/* 9. Veraltete Propositionen Prop. 3.2 bis Prop. 3.5 entfernen. */
DELETE pd
FROM `proposition_dependencies` pd
INNER JOIN `propositions` p
    ON p.`proposition_id` = pd.`proposition_id`
WHERE p.`proposition_number` IN ('Prop. 3.2','Prop. 3.3','Prop. 3.4','Prop. 3.5');

DELETE osl
FROM `object_source_links` osl
INNER JOIN `propositions` p
    ON p.`proposition_id` = osl.`object_id`
WHERE osl.`object_type` = 'proposition'
  AND p.`proposition_number` IN ('Prop. 3.2','Prop. 3.3','Prop. 3.4','Prop. 3.5');

DELETE FROM `propositions`
WHERE `proposition_number` IN ('Prop. 3.2','Prop. 3.3','Prop. 3.4','Prop. 3.5');

/* 10. Abhängigkeiten von Prop. 3.1 zu A1 bis A5 erneuern. */
DELETE FROM `proposition_dependencies`
WHERE `proposition_id` = @proposition_id;

INSERT INTO `proposition_dependencies` (
    `proposition_id`, `axiom_id`, `assumption_id`,
    `dependency_type`, `note`
)
VALUES
(@proposition_id, @axiom_a1_id, NULL, 'derived_from', 'Prop. 3.1 verwendet A1.'),
(@proposition_id, @axiom_a2_id, NULL, 'derived_from', 'Prop. 3.1 verwendet A2.'),
(@proposition_id, @axiom_a3_id, NULL, 'derived_from', 'Prop. 3.1 verwendet A3.'),
(@proposition_id, @axiom_a4_id, NULL, 'derived_from', 'Prop. 3.1 verwendet A4.'),
(@proposition_id, @axiom_a5_id, NULL, 'derived_from', 'Prop. 3.1 verwendet A5.');

/* 11. Alte Belegung von Gleichung (3.73) vollständig bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='equation' AND `object_id_from` IN (
        SELECT e.`equation_id` FROM `equations` e WHERE e.`equation_number`='3.73'
    ))
    OR
    (`object_type_to`='equation' AND `object_id_to` IN (
        SELECT e.`equation_id` FROM `equations` e WHERE e.`equation_number`='3.73'
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number`='3.73';

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number`='3.73';

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number`='3.73';

DELETE FROM `equations`
WHERE `equation_number`='3.73';

/* 12. Gleichung (3.73) einfügen. */
INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
VALUES (
    '3.73',
    @section_id,
    'Formale Darstellung von Proposition Prop. 3.1',
    '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F',
    '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F',
    'Die gemeinsame Annahme der fünf Grundaxiome eröffnet die Möglichkeit funktionaler Entwicklungsprozesse.',
    'proposition',
    'original',
    NULL,
    'Formale Darstellung von Proposition Prop. 3.1.',
    'A1 bis A5 gelten gemeinsam. Die Proposition behauptet Möglichkeit, nicht notwendige Realisierung.',
    'checked',
    @revision_id
);

SET @equation_3_73_id := LAST_INSERT_ID();

/* 13. Symbolregister anlegen. */
INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@equation_3_73_id, 'A1', 'Axiom A1', 'Prinzip der funktionalen Unterscheidbarkeit.', NULL, 'Axiom', 1),
(@equation_3_73_id, 'A2', 'Axiom A2', 'Prinzip der funktionalen Relationierbarkeit.', NULL, 'Axiom', 2),
(@equation_3_73_id, 'A3', 'Axiom A3', 'Prinzip der rekursiven Transformation.', NULL, 'Axiom', 3),
(@equation_3_73_id, 'A4', 'Axiom A4', 'Prinzip stabiler funktionaler Organisation.', NULL, 'Axiom', 4),
(@equation_3_73_id, 'A5', 'Axiom A5', 'Prinzip reproduzierbarer Organisationsmuster.', NULL, 'Axiom', 5),
(@equation_3_73_id, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet die grundsätzliche Möglichkeit eines funktionalen Entwicklungsprozesses.', NULL, 'modal-logischer Operator', 6),
(@equation_3_73_id, '\\mathcal{D}_F', 'funktionaler Entwicklungsprozess', 'Qualitative, noch nicht mathematisch konstruierte funktionale Entwicklung.', NULL, 'prämathematisches Prozesssymbol', 7)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* 14. Gleichungsabhängigkeiten zu den fünf Axiomgleichungen. */
SET @eq_3_64 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.64' LIMIT 1);
SET @eq_3_65 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.65' LIMIT 1);
SET @eq_3_66 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.66' LIMIT 1);
SET @eq_3_68 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.68' LIMIT 1);
SET @eq_3_70 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.70' LIMIT 1);

INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@equation_3_73_id, @eq_3_64, 'uses', 'Prop. 3.1 verwendet A1 beziehungsweise Gleichung (3.64).'),
(@equation_3_73_id, @eq_3_65, 'uses', 'Prop. 3.1 verwendet A2 beziehungsweise Gleichung (3.65).'),
(@equation_3_73_id, @eq_3_66, 'uses', 'Prop. 3.1 verwendet A3 beziehungsweise Gleichung (3.66).'),
(@equation_3_73_id, @eq_3_68, 'uses', 'Prop. 3.1 verwendet A4 beziehungsweise Gleichung (3.68).'),
(@equation_3_73_id, @eq_3_70, 'uses', 'Prop. 3.1 verwendet A5 beziehungsweise Gleichung (3.70).');

/* 15. Änderungsprotokoll aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.3.9',
    'Abschnitt 3.3.9 wurde vollständig neu gefasst.',
    'Frühere Fassung mit fünf Propositionen.',
    'Neufassung mit ausschließlich Prop. 3.1 und Gleichung (3.73).'
),
(
    @revision_id, @section_id, 'other', 'proposition', 'Prop. 3.1',
    'Proposition Prop. 3.1 wurde als Möglichkeit funktionaler Entwicklungsprozesse aktualisiert.',
    'Möglichkeit funktionaler Organisation.',
    'Möglichkeit funktionaler Entwicklungsprozesse.'
),
(
    @revision_id, @section_id, 'equation_added', 'equation', '(3.73)',
    'Die formale Darstellung von Prop. 3.1 wurde registriert.',
    NULL,
    '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F'
);

/* 16. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
    ('next_equation_number','3.74'),
    ('next_proposition_number','Prop. 3.2'),
    ('last_edited_section','3.3.9'),
    ('last_repository_revision','RKB-2026-07-12-K3.3.9-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN
   ============================================================ */

SELECT
    ds.`section_code`, ds.`title`, ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3','3.3.9')
ORDER BY ds.`section_code`;

SELECT
    p.`proposition_id`, p.`proposition_number`, p.`title`,
    p.`statement_latex`, p.`based_on_axioms`, p.`status`
FROM `propositions` p
WHERE p.`section_id`=@section_id
ORDER BY p.`proposition_number`;

SELECT
    a.`axiom_number`, pd.`dependency_type`, pd.`note`
FROM `proposition_dependencies` pd
INNER JOIN `axioms` a ON a.`axiom_id`=pd.`axiom_id`
WHERE pd.`proposition_id`=@proposition_id
ORDER BY a.`axiom_number`;

SELECT
    e.`equation_number`, e.`title`, e.`equation_latex`,
    e.`word_latex`, e.`validation_status`
FROM `equations` e
WHERE e.`equation_number`='3.73';

SELECT
    es.`symbol_latex`, es.`symbol_name`,
    es.`domain_text`, es.`symbol_order`
FROM `equation_symbols` es
WHERE es.`equation_id`=@equation_3_73_id
ORDER BY es.`symbol_order`;

SELECT
    rc.`counter_key`, rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'next_proposition_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
