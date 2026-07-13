USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.3.7
   Axiom A5 – Prinzip reproduzierbarer Organisationsmuster

   Neue Quellen:       keine
   Neue Gleichungen:   (3.70), (3.71)
   Axiom:               A5 (bestehenden Datensatz aktualisieren)
   Axiomabhängigkeiten: A5 depends_on A1, A2, A3 und A4
   Nächste Gleichung:   (3.72)
   Grundaxiome:         abgeschlossen

   WICHTIG:
   Der vorhandene Datensatz A5 wird nicht gelöscht, damit seine
   axiom_id und bestehende eingehende Verweise erhalten bleiben.
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
    'RKB-2026-07-12-K3.3.7-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.3.7',
    '1.0',
    'Neufassung von Abschnitt 3.3.7; Aktualisierung von Axiom A5, Registrierung der Gleichungen (3.70) und (3.71) sowie der Abhängigkeiten von A1 bis A4.',
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
    WHERE ds.`section_code` = '3.3.7'
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
    `title` = 'Axiom A5 – Prinzip reproduzierbarer Organisationsmuster',
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A5 sowie die Gleichungen (3.70) und (3.71). Keine neue Literaturquelle. Mit A5 sind die fünf Grundaxiome abgeschlossen.'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.3 wird abschnittsweise als eigenständige axiomatische Grundlage des FRZK neu gefasst. Die fünf Grundaxiome A1 bis A5 sind mit Abschnitt 3.3.7 vollständig formuliert.'
WHERE `section_id` = @chapter_id;

/* 4. Abschnitt enthält bewusst keine Literaturverwendung. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 5. Axiom-IDs ermitteln. */
SET @axiom_a1_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A1'
    LIMIT 1
);

SET @axiom_a2_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A2'
    LIMIT 1
);

SET @axiom_a3_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A3'
    LIMIT 1
);

SET @axiom_a4_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A4'
    LIMIT 1
);

SET @axiom_a5_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A5'
    LIMIT 1
);

/* 6. Vorhandenes Axiom A5 aktualisieren. */
UPDATE `axioms`
SET
    `section_id` = @section_id,
    `title` = 'Prinzip reproduzierbarer Organisationsmuster',
    `axiom_text` = 'Stabile funktionale Organisationsstrukturen besitzen grundsätzlich die Möglichkeit reproduzierbarer Organisationsmuster.',
    `formal_latex` = '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    `word_latex` = '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    `motivation` = 'Stabilität allein genügt nicht für wissenschaftliche Vergleichbarkeit. A5 eröffnet die Möglichkeit, dass funktional äquivalente Organisationsmuster unter vergleichbaren Bedingungen erneut hervorgebracht werden.',
    `independence_note` = 'A5 setzt A1 bis A4 voraus, führt jedoch weder mathematische Äquivalenzklassen, Wahrscheinlichkeiten noch empirische Wiederholungsraten als primitive Strukturen ein.',
    `consistency_note` = 'Reproduzierbarkeit bedeutet funktionale Vergleichbarkeit und nicht vollständige Identität aller lokalen Eigenschaften.',
    `operationalization_note` = 'Äquivalenzklassen, Kohärenzmaße und Kriterien empirischer Reproduzierbarkeit werden erst in Kapitel 3.4 und den Anwendungskapiteln mathematisch operationalisiert.',
    `status` = 'review',
    `created_revision_id` = @revision_id
WHERE `axiom_id` = @axiom_a5_id;

/* 7. Falls A5 fehlt, idempotent ergänzen. */
INSERT INTO `axioms` (
    `axiom_number`,
    `section_id`,
    `title`,
    `axiom_text`,
    `formal_latex`,
    `word_latex`,
    `motivation`,
    `independence_note`,
    `consistency_note`,
    `operationalization_note`,
    `source_assumption_id`,
    `status`,
    `created_revision_id`
)
SELECT
    'A5',
    @section_id,
    'Prinzip reproduzierbarer Organisationsmuster',
    'Stabile funktionale Organisationsstrukturen besitzen grundsätzlich die Möglichkeit reproduzierbarer Organisationsmuster.',
    '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    'Stabilität allein genügt nicht für wissenschaftliche Vergleichbarkeit. A5 eröffnet reproduzierbare funktionale Organisationsmuster.',
    'A5 setzt A1 bis A4 voraus, führt jedoch keine fertigen Äquivalenzklassen oder Wahrscheinlichkeitsstrukturen ein.',
    'Reproduzierbarkeit bedeutet funktionale Vergleichbarkeit und nicht vollständige Identität.',
    'Äquivalenzklassen, Kohärenzmaße und empirische Reproduzierbarkeit werden später operationalisiert.',
    NULL,
    'review',
    @revision_id
WHERE @axiom_a5_id IS NULL;

SET @axiom_a5_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A5'
    LIMIT 1
);

/* 8. Alte Belegungen der Gleichungsnummern (3.70) und (3.71)
      einschließlich abhängiger Registereinträge bereinigen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.70','3.71')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.70','3.71')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.70','3.71');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.70','3.71');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.70','3.71');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.70','3.71');

/* 9. Gleichung (3.70) – formale Darstellung von A5. */
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
    '3.70',
    @section_id,
    'Formale Darstellung von Axiom A5',
    '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    'Stabile funktionale Organisation eröffnet die Möglichkeit reproduzierbarer funktionaler Organisationsmuster.',
    'axiom',
    'original',
    NULL,
    'Formale Repräsentation des qualitativen Axioms A5.',
    'A1 bis A4 gelten. Reproduzierbarkeit wird qualitativ verstanden; Äquivalenzklasse, Häufigkeit und Wahrscheinlichkeit werden noch nicht vorausgesetzt.',
    'checked',
    @revision_id
);

SET @equation_3_70_id := LAST_INSERT_ID();

/* 10. Gleichung (3.71) – strukturelle Voraussetzung von A5. */
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
    '3.71',
    @section_id,
    'Strukturelle Voraussetzung von Axiom A5',
    'A1,\\;A2,\\;A3,\\;A4\\Longrightarrow\\text{Voraussetzung für }A5',
    'A1,\\;A2,\\;A3,\\;A4\\Longrightarrow\\text{Voraussetzung für }A5',
    'Axiom A5 setzt funktionale Unterscheidbarkeit, Relationierbarkeit, rekursive Transformation und stabile Organisation strukturell voraus, ohne logisch aus ihnen ableitbar zu sein.',
    'schema',
    'original',
    NULL,
    'Schematische Darstellung der axiomatischen Abhängigkeitsstruktur.',
    'A1 bis A4 sind bereits registriert.',
    'checked',
    @revision_id
);

SET @equation_3_71_id := LAST_INSERT_ID();

/* 11. Symbolregister unmittelbar vor Einfügen sicher bereinigen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@equation_3_70_id, @equation_3_71_id);

/* 12. Symbolregister idempotent anlegen. */
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
    @equation_3_70_id,
    '\\mathcal{O}_F',
    'stabile funktionale Organisation',
    'Qualitative, über Transformationen hinweg hinreichend erhaltene funktionale Organisationsform gemäß Axiom A4.',
    NULL,
    'prämathematisches Organisationssymbol',
    1
),
(
    @equation_3_70_id,
    '\\Diamond',
    'Möglichkeitsoperator',
    'Kennzeichnet, dass reproduzierbare Muster möglich, aber nicht notwendig realisiert sind.',
    NULL,
    'modal-logischer Operator',
    2
),
(
    @equation_3_70_id,
    '\\mathcal{P}_F',
    'reproduzierbares Organisationsmuster',
    'Funktional vergleichbare Organisationsform, die unter vergleichbaren Bedingungen erneut hervorgebracht werden kann.',
    NULL,
    'prämathematisches Mustersymbol',
    3
),
(
    @equation_3_71_id,
    'A1',
    'Axiom der funktionalen Unterscheidbarkeit',
    'Erste strukturelle Voraussetzung für A5.',
    NULL,
    'Axiom',
    1
),
(
    @equation_3_71_id,
    'A2',
    'Axiom der funktionalen Relationierbarkeit',
    'Zweite strukturelle Voraussetzung für A5.',
    NULL,
    'Axiom',
    2
),
(
    @equation_3_71_id,
    'A3',
    'Axiom der rekursiven Transformation',
    'Dritte strukturelle Voraussetzung für A5.',
    NULL,
    'Axiom',
    3
),
(
    @equation_3_71_id,
    'A4',
    'Axiom stabiler funktionaler Organisation',
    'Vierte strukturelle Voraussetzung für A5.',
    NULL,
    'Axiom',
    4
),
(
    @equation_3_71_id,
    'A5',
    'Axiom reproduzierbarer Organisationsmuster',
    'Axiom, dessen strukturelle Voraussetzungen dargestellt werden.',
    NULL,
    'Axiom',
    5
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 13. Axiomabhängigkeiten A5 -> A1 bis A4 erneuern.
       Eingehende Abhängigkeiten späterer Objekte bleiben erhalten. */
DELETE FROM `axiom_dependencies`
WHERE `axiom_id` = @axiom_a5_id;

INSERT INTO `axiom_dependencies` (
    `axiom_id`,
    `depends_on_axiom_id`,
    `dependency_type`,
    `note`
)
VALUES
(
    @axiom_a5_id,
    @axiom_a1_id,
    'depends_on',
    'A5 setzt funktionale Unterscheidbarkeit nach A1 voraus.'
),
(
    @axiom_a5_id,
    @axiom_a2_id,
    'depends_on',
    'A5 setzt funktionale Relationierbarkeit nach A2 voraus.'
),
(
    @axiom_a5_id,
    @axiom_a3_id,
    'depends_on',
    'A5 setzt rekursive funktionale Transformation nach A3 voraus.'
),
(
    @axiom_a5_id,
    @axiom_a4_id,
    'depends_on',
    'A5 setzt stabile funktionale Organisation nach A4 voraus.'
);

/* 14. Gleichung (3.70) explizit mit Axiom A5 verknüpfen. */
INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES (
    'equation',
    @equation_3_70_id,
    'axiom',
    @axiom_a5_id,
    'derives_from',
    'Gleichung (3.70) ist die formale Darstellung von Axiom A5.'
);

/* 15. Gleichungsabhängigkeiten zu den Axiomgleichungen registrieren. */
SET @equation_3_64_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.64'
    LIMIT 1
);

SET @equation_3_65_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.65'
    LIMIT 1
);

SET @equation_3_66_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.66'
    LIMIT 1
);

SET @equation_3_68_id := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.68'
    LIMIT 1
);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @equation_3_70_id,
    @equation_3_68_id,
    'uses',
    'Die formale Darstellung von A5 verwendet die in Gleichung (3.68) eingeführte stabile funktionale Organisation.'
),
(
    @equation_3_71_id,
    @equation_3_64_id,
    'uses',
    'Die strukturelle Voraussetzung von A5 umfasst Axiom A1 beziehungsweise Gleichung (3.64).'
),
(
    @equation_3_71_id,
    @equation_3_65_id,
    'uses',
    'Die strukturelle Voraussetzung von A5 umfasst Axiom A2 beziehungsweise Gleichung (3.65).'
),
(
    @equation_3_71_id,
    @equation_3_66_id,
    'uses',
    'Die strukturelle Voraussetzung von A5 umfasst Axiom A3 beziehungsweise Gleichung (3.66).'
),
(
    @equation_3_71_id,
    @equation_3_68_id,
    'uses',
    'Die strukturelle Voraussetzung von A5 umfasst Axiom A4 beziehungsweise Gleichung (3.68).'
);

/* 16. Änderungsprotokoll idempotent aktualisieren. */
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
    '3.3.7',
    'Abschnitt 3.3.7 wurde vollständig als Axiom A5 – Prinzip reproduzierbarer Organisationsmuster neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.3.7.',
    'Neufassung mit Axiom A5 sowie den Gleichungen (3.70) und (3.71).'
),
(
    @revision_id,
    @section_id,
    'axiom_added',
    'axiom',
    'A5',
    'Axiom A5 wurde als Prinzip reproduzierbarer funktionaler Organisationsmuster aktualisiert.',
    '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.70), (3.71)',
    'Die formale Axiomdarstellung und die strukturelle Axiomabhängigkeit wurden registriert.',
    'Frühere Belegungen der Gleichungsnummern.',
    'Reproduzierbare Organisationsmuster und A1 bis A4 als Voraussetzungen von A5.'
),
(
    @revision_id,
    @section_id,
    'dependency_added',
    'axiom_dependency',
    'A5 -> A1, A2, A3, A4',
    'Die strukturellen Abhängigkeiten von A5 von A1 bis A4 wurden explizit registriert.',
    NULL,
    'A5 depends_on A1; A5 depends_on A2; A5 depends_on A3; A5 depends_on A4'
),
(
    @revision_id,
    @section_id,
    'other',
    'axiom_system',
    'A1–A5',
    'Mit Axiom A5 ist das System der fünf FRZK-Grundaxiome vollständig formuliert.',
    'A1 bis A4 vollständig; A5 noch nicht endredigiert.',
    'Grundaxiome A1 bis A5 vollständig im Status review.'
);

/* 17. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.72'),
    ('next_axiom_number', 'COMPLETE'),
    ('axiom_system_status', 'A1-A5 complete'),
    ('last_edited_section', '3.3.7'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.3.7-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* Literaturzähler bleibt unverändert. */

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.3.7: review
   - Axiom A5: genau 1 Datensatz
   - Gleichungen: (3.70), (3.71)
   - Symbolzuordnungen: 8
   - A5 depends_on A1, A2, A3 und A4
   - (3.70) uses (3.68)
   - (3.71) uses (3.64), (3.65), (3.66), (3.68)
   - Quellenverwendungen: 0
   - next_equation_number = 3.72
   - next_axiom_number = COMPLETE
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.3', '3.3.7')
ORDER BY ds.`section_code`;

SELECT
    a.`axiom_id`,
    a.`axiom_number`,
    a.`title`,
    a.`axiom_text`,
    a.`formal_latex`,
    a.`word_latex`,
    a.`status`
FROM `axioms` a
WHERE a.`axiom_number` = 'A5';

SELECT
    e.`equation_id`,
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`equation_type`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.70','3.71')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.70','3.71')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    ad.`dependency_type`,
    a_from.`axiom_number` AS `axiom_number`,
    a_to.`axiom_number` AS `depends_on_axiom`,
    ad.`note`
FROM `axiom_dependencies` ad
INNER JOIN `axioms` a_from
    ON a_from.`axiom_id` = ad.`axiom_id`
INNER JOIN `axioms` a_to
    ON a_to.`axiom_id` = ad.`depends_on_axiom_id`
WHERE ad.`axiom_id` = @axiom_a5_id
ORDER BY a_to.`axiom_number`;

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
WHERE e_from.`equation_number` IN ('3.70','3.71')
ORDER BY
    CAST(SUBSTRING_INDEX(e_from.`equation_number`,'.',-1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(e_to.`equation_number`,'.',-1) AS UNSIGNED);

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
