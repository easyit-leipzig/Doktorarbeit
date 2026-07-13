USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.9
   Informationstheorie als mathematische Grundlage
   funktionaler Informationsprozesse

   Repository-konsistente Quellen:
   [45] Cover / Thomas
   [46] Shannon

   Gleichungen:
   (3.41) Informationsgehalt
   (3.42) Shannon-Entropie
   (3.43) Gemeinsame Entropie
   (3.44) Gegenseitige Information
   (3.45) Kullback-Leibler-Divergenz

   Neue Quellen: keine
   Nächste freie Literaturnummer bleibt [59].
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
    'RKB-2026-07-12-K3.2.9-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.9',
    '1.0',
    'Neufassung von Abschnitt 3.2.9 mit den Quellen [45] und [46] sowie den Gleichungen (3.41) bis (3.45).',
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

/* 2. Abschnitts-ID ermitteln. */
SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.9'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [45] und [46] und enthält die Gleichungen (3.41) bis (3.45).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* 4. Quellenverwendungen vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* [45] Cover / Thomas */
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
    'first_citation',
    'Cover und Thomas dienen als Referenz für Entropie, gemeinsame Entropie, gegenseitige Information und Divergenzmaße.',
    'Abschnitt 3.2.9',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [45].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 45;

/* [46] Shannon */
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
    'first_citation',
    'Shannon dient als Primärquelle für Informationsgehalt, Entropie, Kanal und statistische Quantifizierung von Unsicherheit.',
    'Abschnitt 3.2.9',
    1,
    1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [46].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 46;

/* 5. Quellen-IDs bestimmen. */
SET @source_45_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 45
    LIMIT 1
);

SET @source_46_id := (
    SELECT s.`source_id`
    FROM `sources` s
    WHERE s.`citation_number` = 46
    LIMIT 1
);

/* 6. Alte Belegungen der Gleichungsnummern (3.41) bis (3.45) vollständig bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.41','3.42','3.43','3.44','3.45');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.41','3.42','3.43','3.44','3.45');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.41','3.42','3.43','3.44','3.45');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.41','3.42','3.43','3.44','3.45');

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
    '3.41',
    @section_id,
    'Informationsgehalt eines Ereignisses',
    'I(x)=-\\log_{2}p(x)',
    'I(x)=-\\log_{2}p(x)',
    'Der Informationsgehalt eines Ereignisses steigt mit abnehmender Eintrittswahrscheinlichkeit.',
    'definition',
    'literature',
    @source_46_id,
    NULL,
    '0<p(x)\\le1.',
    'checked',
    @revision_id
),
(
    '3.42',
    @section_id,
    'Shannon-Entropie',
    'H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i',
    'H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i',
    'Die Shannon-Entropie beschreibt die mittlere Unsicherheit einer diskreten Zufallsvariablen.',
    'definition',
    'literature',
    @source_46_id,
    NULL,
    'p_i\\ge0 und \\sum_{i=1}^{n}p_i=1.',
    'checked',
    @revision_id
),
(
    '3.43',
    @section_id,
    'Gemeinsame Entropie',
    'H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)',
    'H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)',
    'Die gemeinsame Entropie beschreibt die Unsicherheit zweier gemeinsam verteilter Zufallsvariablen.',
    'definition',
    'literature',
    @source_45_id,
    NULL,
    'p(x_i,y_j) ist eine gemeinsame Wahrscheinlichkeitsverteilung.',
    'checked',
    @revision_id
),
(
    '3.44',
    @section_id,
    'Gegenseitige Information',
    'I(X;Y)=H(X)+H(Y)-H(X,Y)',
    'I(X;Y)=H(X)+H(Y)-H(X,Y)',
    'Die gegenseitige Information misst die statistische Abhängigkeit zweier Zufallsvariablen.',
    'metric',
    'literature',
    @source_45_id,
    NULL,
    'X und Y besitzen definierte Rand- und gemeinsame Verteilungen.',
    'checked',
    @revision_id
),
(
    '3.45',
    @section_id,
    'Kullback-Leibler-Divergenz',
    'D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}',
    'D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}',
    'Die Kullback-Leibler-Divergenz quantifiziert die Abweichung einer Wahrscheinlichkeitsverteilung P von einer Referenzverteilung Q.',
    'metric',
    'literature',
    @source_45_id,
    NULL,
    'P(i)\\ge0, Q(i)>0 für alle i mit P(i)>0 und \\sum_iP(i)=\\sum_iQ(i)=1.',
    'checked',
    @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_41 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.41'
);
SET @eq_3_42 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.42'
);
SET @eq_3_43 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.43'
);
SET @eq_3_44 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.44'
);
SET @eq_3_45 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.45'
);

/* 9. Symbolregister unmittelbar vor Einfügen sicher bereinigen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_41,
    @eq_3_42,
    @eq_3_43,
    @eq_3_44,
    @eq_3_45
);

/* 10. Symbolregister idempotent anlegen. */
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
(@eq_3_41, 'I(x)', 'Informationsgehalt',
 'Informationswert des Ereignisses x.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_41, 'p(x)', 'Ereigniswahrscheinlichkeit',
 'Wahrscheinlichkeit des Ereignisses x.', NULL, '(0,1]', 2),

(@eq_3_42, 'H(X)', 'Shannon-Entropie',
 'Mittlere Unsicherheit der Zufallsvariablen X.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_42, 'p_i', 'Ereigniswahrscheinlichkeit',
 'Wahrscheinlichkeit des i-ten möglichen Ereignisses.', NULL, '[0,1]', 2),

(@eq_3_43, 'H(X,Y)', 'gemeinsame Entropie',
 'Gemeinsame Unsicherheit der Zufallsvariablen X und Y.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_43, 'p(x_i,y_j)', 'gemeinsame Wahrscheinlichkeit',
 'Gemeinsame Wahrscheinlichkeit der Ereignisse x_i und y_j.', NULL, '[0,1]', 2),

(@eq_3_44, 'I(X;Y)', 'gegenseitige Information',
 'Gemeinsam getragene Information der Zufallsvariablen X und Y.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_44, 'H(X)', 'Entropie von X',
 'Mittlere Unsicherheit der Zufallsvariablen X.', 'bit', '\\mathbb{R}_{\\ge0}', 2),
(@eq_3_44, 'H(Y)', 'Entropie von Y',
 'Mittlere Unsicherheit der Zufallsvariablen Y.', 'bit', '\\mathbb{R}_{\\ge0}', 3),
(@eq_3_44, 'H(X,Y)', 'gemeinsame Entropie',
 'Gemeinsame Unsicherheit von X und Y.', 'bit', '\\mathbb{R}_{\\ge0}', 4),

(@eq_3_45, 'D_{KL}(P\\parallel Q)', 'Kullback-Leibler-Divergenz',
 'Divergenz der Verteilung P relativ zur Verteilung Q.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(@eq_3_45, 'P(i)', 'Zielverteilung',
 'Wahrscheinlichkeit des i-ten Ereignisses unter P.', NULL, '[0,1]', 2),
(@eq_3_45, 'Q(i)', 'Referenzverteilung',
 'Wahrscheinlichkeit des i-ten Ereignisses unter Q.', NULL, '(0,1]', 3)

ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 11. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_3_42,
    @eq_3_41,
    'derived_from',
    'Die Shannon-Entropie ist der Erwartungswert des Informationsgehalts einzelner Ereignisse.'
),
(
    @eq_3_43,
    @eq_3_42,
    'generalizes',
    'Die gemeinsame Entropie erweitert den Entropiebegriff auf gemeinsam verteilte Zufallsvariablen.'
),
(
    @eq_3_44,
    @eq_3_43,
    'uses',
    'Die gegenseitige Information verwendet die gemeinsame Entropie.'
),
(
    @eq_3_44,
    @eq_3_42,
    'uses',
    'Die gegenseitige Information verwendet die Randentropien.'
),
(
    @eq_3_45,
    @eq_3_41,
    'uses',
    'Die Kullback-Leibler-Divergenz beruht auf logarithmischen Informationsverhältnissen.'
);

/* 12. Änderungsprotokoll aktualisieren. */
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
    '3.2.9',
    'Abschnitt 3.2.9 wurde als informationstheoretischer Grundlagenabschnitt vollständig neu gefasst.',
    'Bisherige Fassung mit den Gleichungen (3.58) bis (3.62).',
    'Neufassung mit den Quellen [45] und [46] und den Gleichungen (3.41) bis (3.45).'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'sources',
    '[45], [46]',
    'Die bestehenden Quellen Cover/Thomas und Shannon wurden als Erstnennungen des Abschnitts registriert.',
    NULL,
    '2 Quellenverwendungen'
),
(
    @revision_id,
    @section_id,
    'equation_changed',
    'equations',
    '(3.41)–(3.45)',
    'Die informationstheoretischen Gleichungen wurden neu nummeriert und an die Neufassung angepasst.',
    'Bisherige Gleichungen (3.58) bis (3.62).',
    'Informationsgehalt, Shannon-Entropie, gemeinsame Entropie, gegenseitige Information und Kullback-Leibler-Divergenz.'
);

/* 13. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.46'),
    ('last_edited_section', '3.2.9'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.9-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.9: review
   - Titel: Informationstheorie ...
   - 2 Quellenverwendungen: [45], [46]
   - 2 Erstnennungen
   - Gleichungen (3.41) bis (3.45)
   - next_citation_number = 59
   - next_equation_number = 3.46
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.9')
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
    s.`citation_number`,
    s.`full_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

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
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`section_id` = @section_id
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED),
    es.`symbol_order`;

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
