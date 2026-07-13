USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.10
   Graphen- und Netzwerktheorie als mathematische Beschreibung
   komplexer Beziehungsstrukturen

   Repository-konsistente Quellen:
   [47] Diestel – Erstnennung
   [48] Newman – Erstnennung
   [15] Barabási – Wiederverwendung

   Gleichungen:
   (3.46) Graph
   (3.47) Adjazenzmatrix
   (3.48) Knotengrad
   (3.49) Pfad
   (3.50) Netzwerkdichte
   (3.51) Lokaler Clusterkoeffizient

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
    'RKB-2026-07-12-K3.2.10-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.10',
    '1.0',
    'Neufassung von Abschnitt 3.2.10 mit den Quellen [15], [47] und [48] sowie den Gleichungen (3.46) bis (3.51).',
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
    WHERE ds.`section_code` = '3.2.10'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Graphen- und Netzwerktheorie als mathematische Beschreibung komplexer Beziehungsstrukturen',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [15], [47] und [48] und enthält die Gleichungen (3.46) bis (3.51).'
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

/* [47] Diestel */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Diestel dient als Hauptreferenz für Graphen, Knoten, Kanten, Wege und grundlegende graphentheoretische Strukturen.',
    'Abschnitt 3.2.10', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [47].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 47;

/* [48] Newman */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Newman dient als Hauptreferenz für Netzwerkmaße, Gradverteilungen, Dichte, Clusterbildung und komplexe Netzwerke.',
    'Abschnitt 3.2.10', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [48].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 48;

/* [15] Barabási */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Barabási wird als Referenz für emergente Netzwerkstrukturen, Wachstum und skalenfreie Organisation wiederverwendet.',
    'Abschnitt 3.2.10', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 15;

/* 5. Quellen-IDs bestimmen. */
SET @source_47_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 47 LIMIT 1
);

SET @source_48_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 48 LIMIT 1
);

/* 6. Alte Belegungen der Gleichungsnummern (3.46) bis (3.51) vollständig bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.46','3.47','3.48','3.49','3.50','3.51');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.46','3.47','3.48','3.49','3.50','3.51');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.46','3.47','3.48','3.49','3.50','3.51');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.46','3.47','3.48','3.49','3.50','3.51');

/* 7. Gleichungen der Neufassung einfügen. */
INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.46', @section_id, 'Graph',
    'G=(V,E)',
    'G=(V,E)',
    'Ein Graph G besteht aus einer Knotenmenge V und einer Kantenmenge E.',
    'definition', 'literature', @source_47_id,
    NULL, 'V ist eine Menge von Knoten und E eine Menge zulässiger Kanten.',
    'checked', @revision_id
),
(
    '3.47', @section_id, 'Adjazenzmatrix',
    'A_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}',
    'A_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}',
    'Die Adjazenzmatrix codiert, ob zwischen zwei Knoten eine Kante besteht.',
    'definition', 'literature', @source_47_id,
    NULL, 'G ist ein einfacher ungewichteter Graph.',
    'checked', @revision_id
),
(
    '3.48', @section_id, 'Knotengrad',
    'k_i=\\sum_{j=1}^{n}A_{ij}',
    'k_i=\\sum_{j=1}^{n}A_{ij}',
    'Der Grad eines Knotens entspricht der Anzahl seiner adjazenten Knoten.',
    'metric', 'literature', @source_48_id,
    NULL, 'A ist die Adjazenzmatrix eines einfachen Graphen mit n Knoten.',
    'checked', @revision_id
),
(
    '3.49', @section_id, 'Pfad',
    'P=(v_0,v_1,\\ldots,v_m),\\qquad (v_{r-1},v_r)\\in E\\;\\text{für}\\;r=1,\\ldots,m',
    'P=(v_0,v_1,\\ldots,v_m),\\qquad (v_{r-1},v_r)\\in E\\;\\text{für}\\;r=1,\\ldots,m',
    'Ein Pfad ist eine geordnete Knotenfolge, deren aufeinanderfolgende Knoten durch Kanten verbunden sind.',
    'definition', 'literature', @source_47_id,
    NULL, 'Alle v_r gehören zur Knotenmenge V.',
    'checked', @revision_id
),
(
    '3.50', @section_id, 'Netzwerkdichte',
    '\\rho=\\frac{2|E|}{|V|(|V|-1)}',
    '\\rho=\\frac{2|E|}{|V|(|V|-1)}',
    'Die Dichte eines einfachen ungerichteten Graphen ist das Verhältnis vorhandener zu maximal möglichen Kanten.',
    'metric', 'literature', @source_48_id,
    NULL, 'Der Graph ist einfach, ungerichtet und besitzt mindestens zwei Knoten.',
    'checked', @revision_id
),
(
    '3.51', @section_id, 'Lokaler Clusterkoeffizient',
    'C_i=\\frac{2e_i}{k_i(k_i-1)}',
    'C_i=\\frac{2e_i}{k_i(k_i-1)}',
    'Der lokale Clusterkoeffizient misst den Anteil realisierter Verbindungen zwischen den Nachbarn eines Knotens.',
    'metric', 'literature', @source_48_id,
    NULL, 'k_i\\ge2 und e_i ist die Zahl der Kanten zwischen den Nachbarn von v_i.',
    'checked', @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_46 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.46');
SET @eq_3_47 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.47');
SET @eq_3_48 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.48');
SET @eq_3_49 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.49');
SET @eq_3_50 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.50');
SET @eq_3_51 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.51');

/* 9. Symbolregister unmittelbar vor Einfügen sicher bereinigen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_46,@eq_3_47,@eq_3_48,@eq_3_49,@eq_3_50,@eq_3_51
);

/* 10. Symbolregister idempotent anlegen. */
INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_3_46, 'G', 'Graph',
 'Geordnetes Paar aus Knotenmenge und Kantenmenge.', NULL, 'Graph', 1),
(@eq_3_46, 'V', 'Knotenmenge',
 'Menge aller Knoten des Graphen.', NULL, 'Menge', 2),
(@eq_3_46, 'E', 'Kantenmenge',
 'Menge aller Kanten des Graphen.', NULL, 'Menge', 3),

(@eq_3_47, 'A_{ij}', 'Adjazenzeintrag',
 'Eintrag der Adjazenzmatrix für die Knoten v_i und v_j.', NULL, '\\{0,1\\}', 1),
(@eq_3_47, 'v_i', 'erster Knoten',
 'i-ter Knoten des Graphen.', NULL, 'v_i\\in V', 2),
(@eq_3_47, 'v_j', 'zweiter Knoten',
 'j-ter Knoten des Graphen.', NULL, 'v_j\\in V', 3),

(@eq_3_48, 'k_i', 'Knotengrad',
 'Anzahl der an v_i angrenzenden Knoten.', NULL, '\\mathbb{N}_0', 1),
(@eq_3_48, 'A_{ij}', 'Adjazenzeintrag',
 'Binärer Eintrag für die Verbindung zwischen v_i und v_j.', NULL, '\\{0,1\\}', 2),
(@eq_3_48, 'n', 'Knotenzahl',
 'Anzahl aller Knoten des Graphen.', NULL, '\\mathbb{N}', 3),

(@eq_3_49, 'P', 'Pfad',
 'Geordnete Folge paarweise benachbarter Knoten.', NULL, 'Knotenfolge', 1),
(@eq_3_49, 'v_r', 'Pfadknoten',
 'r-ter Knoten des Pfades.', NULL, 'v_r\\in V', 2),
(@eq_3_49, 'm', 'Pfadlänge',
 'Anzahl der Kanten des Pfades.', NULL, '\\mathbb{N}_0', 3),

(@eq_3_50, '\\rho', 'Netzwerkdichte',
 'Anteil der vorhandenen an den maximal möglichen Kanten.', NULL, '[0,1]', 1),
(@eq_3_50, '|E|', 'Kantenzahl',
 'Anzahl der Kanten des Graphen.', NULL, '\\mathbb{N}_0', 2),
(@eq_3_50, '|V|', 'Knotenzahl',
 'Anzahl der Knoten des Graphen.', NULL, '\\mathbb{N}', 3),

(@eq_3_51, 'C_i', 'lokaler Clusterkoeffizient',
 'Anteil realisierter Nachbarschaftsverbindungen am Knoten v_i.', NULL, '[0,1]', 1),
(@eq_3_51, 'e_i', 'Nachbarschaftskanten',
 'Zahl der Kanten zwischen den Nachbarn von v_i.', NULL, '\\mathbb{N}_0', 2),
(@eq_3_51, 'k_i', 'Knotengrad',
 'Anzahl der Nachbarn des Knotens v_i.', NULL, '\\mathbb{N}', 3)

ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 11. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@eq_3_47, @eq_3_46, 'uses',
 'Die Adjazenzmatrix codiert die Kantenstruktur des Graphen.'),
(@eq_3_48, @eq_3_47, 'derived_from',
 'Der Knotengrad ergibt sich aus der Zeilensumme der Adjazenzmatrix.'),
(@eq_3_49, @eq_3_46, 'uses',
 'Die Pfaddefinition setzt Knoten- und Kantenmenge voraus.'),
(@eq_3_50, @eq_3_46, 'derived_from',
 'Die Netzwerkdichte wird aus der Zahl der Knoten und Kanten berechnet.'),
(@eq_3_51, @eq_3_48, 'uses',
 'Der lokale Clusterkoeffizient verwendet den Knotengrad.');

/* 12. Änderungsprotokoll aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.2.10',
    'Abschnitt 3.2.10 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit älterer Gleichungsnummerierung.',
    'Neufassung mit den Quellen [15], [47], [48] und den Gleichungen (3.46) bis (3.51).'
),
(
    @revision_id, @section_id, 'source_reused', 'sources', '[15], [47], [48]',
    'Die vorhandenen Quellen zur Graphen- und Netzwerktheorie wurden registriert.',
    NULL, '3 Quellenverwendungen'
),
(
    @revision_id, @section_id, 'equation_changed', 'equations', '(3.46)–(3.51)',
    'Die graphen- und netzwerktheoretischen Gleichungen wurden neu nummeriert und inhaltlich präzisiert.',
    'Ältere Gleichungsbelegungen.',
    'Graph, Adjazenzmatrix, Knotengrad, Pfad, Netzwerkdichte und Clusterkoeffizient.'
);

/* 13. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.52'),
    ('last_edited_section', '3.2.10'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.10-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.10: review
   - 3 Quellenverwendungen
   - 2 Erstnennungen: [47], [48]
   - Gleichungen (3.46) bis (3.51)
   - next_citation_number = 59
   - next_equation_number = 3.52
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.10')
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
