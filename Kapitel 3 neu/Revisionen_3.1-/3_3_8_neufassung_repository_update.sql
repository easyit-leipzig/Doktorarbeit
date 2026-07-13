USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.8
   Zusammenfassung der axiomatischen Grundlagen

   Neue Quellen:     keine
   Neue Gleichung:   (3.72)
   Neue Axiome:      keine
   Nächste Gleichung: (3.73)

   Die fünf Axiome werden NICHT als logisch auseinander folgend
   dargestellt. Gleichung (3.72) fasst sie als gemeinsam
   vorausgesetztes Axiomensystem zusammen.
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
    'RKB-2026-07-12-K3.3.8-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.8',
    '1.0',
    'Neufassung von Abschnitt 3.3.8 als Zusammenfassung der fünf gleichrangig angenommenen FRZK-Grundaxiome; Registrierung der Systemgleichung (3.72).',
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
    WHERE ds.`section_code` = '3.3.8'
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
    `title` = 'Zusammenfassung der axiomatischen Grundlagen',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Fasst A1 bis A5 als gemeinsam vorausgesetztes, nicht als linear ableitbares Axiomensystem zusammen. Enthält Gleichung (3.72).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 enthält fünf gleichrangige Grundaxiome. Deren logische Konsequenzen werden erst in Abschnitt 3.3.9 als Propositionen formuliert.'
WHERE `section_id` = @chapter_id;

/* 4. Abschnitt enthält bewusst keine Literaturverwendung. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 5. Axiom-IDs ermitteln. */
SET @axiom_a1_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A1' LIMIT 1
);
SET @axiom_a2_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A2' LIMIT 1
);
SET @axiom_a3_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A3' LIMIT 1
);
SET @axiom_a4_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A4' LIMIT 1
);
SET @axiom_a5_id := (
    SELECT a.`axiom_id` FROM `axioms` a
    WHERE a.`axiom_number` = 'A5' LIMIT 1
);

/* 6. Alte Gleichungen dieses Abschnitts sowie die alte Belegung
      von (3.72) einschließlich abhängiger Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`section_id` = @section_id
               OR e.`equation_number` = '3.72'
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`section_id` = @section_id
               OR e.`equation_number` = '3.72'
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`section_id` = @section_id
   OR e.`equation_number` = '3.72';

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`section_id` = @section_id
   OR e.`equation_number` = '3.72';

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`section_id` = @section_id
   OR e.`equation_number` = '3.72';

DELETE FROM `equations`
WHERE `section_id` = @section_id
   OR `equation_number` = '3.72';

/* 7. Systemgleichung (3.72) einfügen. */
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
VALUES (
    '3.72',
    @section_id,
    'Gemeinsamer axiomatischer Ausgangspunkt des FRZK',
    'A1\\land A2\\land A3\\land A4\\land A5\\Longrightarrow\\Diamond\\,\\mathcal{E}_F',
    'A1\\land A2\\land A3\\land A4\\land A5\\Longrightarrow\\Diamond\\,\\mathcal{E}_F',
    'Die fünf gemeinsam angenommenen Grundaxiome eröffnen die Möglichkeit einer funktionalen Entwicklungsstruktur. Die Gleichung behauptet keine logische Ableitung der Axiome auseinander.',
    'schema',
    'original',
    NULL,
    'Zusammenfassende Darstellung des gemeinsam vorausgesetzten Axiomensystems.',
    'A1 bis A5 werden gemeinsam angenommen. Die Möglichkeit einer funktionalen Entwicklungsstruktur wird erst in Abschnitt 3.3.9 propositionell präzisiert und in Kapitel 3.4 mathematisch konstruiert.',
    'checked',
    @revision_id
);

SET @equation_3_72_id := LAST_INSERT_ID();

/* 8. Symbolregister sicher und idempotent anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` = @equation_3_72_id;

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
(
    @equation_3_72_id,
    'A1',
    'Axiom der funktionalen Unterscheidbarkeit',
    'Erstes gleichrangig angenommenes Grundaxiom des FRZK.',
    NULL,
    'Axiom',
    1
),
(
    @equation_3_72_id,
    'A2',
    'Axiom der funktionalen Relationierbarkeit',
    'Zweites gleichrangig angenommenes Grundaxiom des FRZK.',
    NULL,
    'Axiom',
    2
),
(
    @equation_3_72_id,
    'A3',
    'Axiom der rekursiven Transformation',
    'Drittes gleichrangig angenommenes Grundaxiom des FRZK.',
    NULL,
    'Axiom',
    3
),
(
    @equation_3_72_id,
    'A4',
    'Axiom stabiler funktionaler Organisation',
    'Viertes gleichrangig angenommenes Grundaxiom des FRZK.',
    NULL,
    'Axiom',
    4
),
(
    @equation_3_72_id,
    'A5',
    'Axiom reproduzierbarer Organisationsmuster',
    'Fünftes gleichrangig angenommenes Grundaxiom des FRZK.',
    NULL,
    'Axiom',
    5
),
(
    @equation_3_72_id,
    '\\land',
    'logische Konjunktion',
    'Kennzeichnet, dass A1 bis A5 gemeinsam angenommen werden.',
    NULL,
    'logischer Operator',
    6
),
(
    @equation_3_72_id,
    '\\Diamond',
    'Möglichkeitsoperator',
    'Kennzeichnet, dass das Axiomensystem die Möglichkeit einer funktionalen Entwicklungsstruktur eröffnet.',
    NULL,
    'modal-logischer Operator',
    7
),
(
    @equation_3_72_id,
    '\\mathcal{E}_F',
    'funktionale Entwicklungsstruktur',
    'Noch nicht mathematisch konstruierte Gesamtstruktur aus Unterscheidbarkeit, Relationierbarkeit, Transformation, Organisation und Reproduzierbarkeit.',
    NULL,
    'prämathematisches Struktursymbol',
    8
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 9. Gleichungsabhängigkeiten zu den fünf Axiomgleichungen registrieren. */
SET @equation_3_64_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.64' LIMIT 1
);
SET @equation_3_65_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.65' LIMIT 1
);
SET @equation_3_66_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.66' LIMIT 1
);
SET @equation_3_68_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.68' LIMIT 1
);
SET @equation_3_70_id := (
    SELECT e.`equation_id` FROM `equations` e
    WHERE e.`equation_number` = '3.70' LIMIT 1
);

DELETE FROM `equation_dependencies`
WHERE `equation_id` = @equation_3_72_id;

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @equation_3_72_id,
    @equation_3_64_id,
    'uses',
    'Die Systemzusammenfassung umfasst Axiom A1 beziehungsweise Gleichung (3.64).'
),
(
    @equation_3_72_id,
    @equation_3_65_id,
    'uses',
    'Die Systemzusammenfassung umfasst Axiom A2 beziehungsweise Gleichung (3.65).'
),
(
    @equation_3_72_id,
    @equation_3_66_id,
    'uses',
    'Die Systemzusammenfassung umfasst Axiom A3 beziehungsweise Gleichung (3.66).'
),
(
    @equation_3_72_id,
    @equation_3_68_id,
    'uses',
    'Die Systemzusammenfassung umfasst Axiom A4 beziehungsweise Gleichung (3.68).'
),
(
    @equation_3_72_id,
    @equation_3_70_id,
    'uses',
    'Die Systemzusammenfassung umfasst Axiom A5 beziehungsweise Gleichung (3.70).'
);

/* 10. Systemgleichung zusätzlich mit allen fünf Axiomen verknüpfen. */
INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
(
    'equation',
    @equation_3_72_id,
    'axiom',
    @axiom_a1_id,
    'uses',
    'Gleichung (3.72) fasst Axiom A1 als Teil des gemeinsamen Axiomensystems zusammen.'
),
(
    'equation',
    @equation_3_72_id,
    'axiom',
    @axiom_a2_id,
    'uses',
    'Gleichung (3.72) fasst Axiom A2 als Teil des gemeinsamen Axiomensystems zusammen.'
),
(
    'equation',
    @equation_3_72_id,
    'axiom',
    @axiom_a3_id,
    'uses',
    'Gleichung (3.72) fasst Axiom A3 als Teil des gemeinsamen Axiomensystems zusammen.'
),
(
    'equation',
    @equation_3_72_id,
    'axiom',
    @axiom_a4_id,
    'uses',
    'Gleichung (3.72) fasst Axiom A4 als Teil des gemeinsamen Axiomensystems zusammen.'
),
(
    'equation',
    @equation_3_72_id,
    'axiom',
    @axiom_a5_id,
    'uses',
    'Gleichung (3.72) fasst Axiom A5 als Teil des gemeinsamen Axiomensystems zusammen.'
);

/* 11. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.3.8',
    'Abschnitt 3.3.8 wurde vollständig als Zusammenfassung der axiomatischen Grundlagen neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.8.',
    'Zusammenfassung von A1 bis A5 als gemeinsam vorausgesetztes Axiomensystem mit Gleichung (3.72).'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.72)',
    'Die gemeinsame Systemdarstellung der fünf Grundaxiome wurde registriert.',
    'Mögliche ältere lineare Axiomkette.',
    'A1\\land A2\\land A3\\land A4\\land A5\\Longrightarrow\\Diamond\\,\\mathcal{E}_F'
),
(
    @revision_id,
    @section_id,
    'dependency_added',
    'equation_dependency',
    '(3.72) -> (3.64), (3.65), (3.66), (3.68), (3.70)',
    'Die Systemgleichung wurde mit sämtlichen formalen Axiomdarstellungen verknüpft.',
    NULL,
    '5 Gleichungsabhängigkeiten'
),
(
    @revision_id,
    @section_id,
    'other',
    'axiom_system',
    'A1–A5',
    'Die Axiome werden ausdrücklich als gleichrangige Grundannahmen und nicht als logisch auseinander ableitbare Kette dargestellt.',
    'Lineare oder missverständliche Folgekette.',
    'Gemeinsam vorausgesetzte Konjunktion der fünf Axiome.'
);

/* 12. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.73'),
    ('next_axiom_number', 'COMPLETE'),
    ('axiom_system_status', 'A1-A5 summarized'),
    ('last_edited_section', '3.3.8'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.8-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.3.8: review
   - Quellenverwendungen: 0
   - Gleichung (3.72): genau 1
   - Symbolzuordnungen: 8
   - Gleichungsabhängigkeiten: 5
   - Objektverknüpfungen zu A1 bis A5: 5
   - next_equation_number = 3.73
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    ds.`notes`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.8')
ORDER BY ds.`section_code`;

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`equation_type`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` = '3.72';

SELECT
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`definition_text`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
WHERE es.`equation_id` = @equation_3_72_id
ORDER BY es.`symbol_order`;

SELECT
    ed.`dependency_type`,
    e_from.`equation_number` AS `equation_number`,
    e_to.`equation_number` AS `depends_on_equation`,
    ed.`dependency_note`
FROM `equation_dependencies` ed
INNER JOIN `equations` e_from
    ON e_from.`equation_id` = ed.`equation_id`
INNER JOIN `equations` e_to
    ON e_to.`equation_id` = ed.`depends_on_equation_id`
WHERE ed.`equation_id` = @equation_3_72_id
ORDER BY CAST(SUBSTRING_INDEX(e_to.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    od.`object_type_from`,
    od.`object_id_from`,
    od.`object_type_to`,
    a.`axiom_number`,
    od.`dependency_type`,
    od.`note`
FROM `object_dependencies` od
INNER JOIN `axioms` a
    ON a.`axiom_id` = od.`object_id_to`
WHERE od.`object_type_from` = 'equation'
  AND od.`object_id_from` = @equation_3_72_id
  AND od.`object_type_to` = 'axiom'
ORDER BY a.`axiom_number`;

SELECT
    COUNT(*) AS `registered_source_usages`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_citation_number',
    'next_equation_number',
    'next_axiom_number',
    'axiom_system_status',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
