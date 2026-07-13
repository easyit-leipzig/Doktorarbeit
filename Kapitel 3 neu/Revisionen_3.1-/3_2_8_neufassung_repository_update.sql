USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.8
   Dynamische Systeme als mathematische Grundlage
   funktionaler Entwicklung

   Quellen:
   [37] Strogatz – Wiederverwendung
   [39] Khalil – Wiederverwendung
   [40] Hirsch / Smale / Devaney – Wiederverwendung
   [43] Katok / Hasselblatt – Erstnennung
   [44] Ott – Erstnennung

   Gleichungen:
   (3.35) Kontinuierliches dynamisches System
   (3.36) Diskretes dynamisches System
   (3.37) Fixpunkt
   (3.38) Jacobi-Matrix
   (3.39) Attraktorbedingung
   (3.40) Lyapunov-Entwicklung

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
    'RKB-2026-07-12-K3.2.8-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.8',
    '1.0',
    'Neufassung von Abschnitt 3.2.8 mit den Quellen [37], [39], [40], [43] und [44] sowie den Gleichungen (3.35) bis (3.40).',
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
    WHERE ds.`section_code` = '3.2.8'
    LIMIT 1
);

/* 3. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Dynamische Systeme als mathematische Grundlage funktionaler Entwicklung',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [37], [39], [40], [43] und [44] und enthält die Gleichungen (3.35) bis (3.40).'
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

/* [37] Strogatz */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Strogatz dient als Referenz für Fixpunkte, Bifurkationen, Attraktoren und nichtlineare Dynamik.',
    'Abschnitt 3.2.8', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.2.5.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 37;

/* [39] Khalil */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Khalil dient als Referenz für lokale Stabilität, Linearisierung und Lyapunov-Methoden nichtlinearer Systeme.',
    'Abschnitt 3.2.8', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.2.6.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 39;

/* [40] Hirsch / Smale / Devaney */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Hirsch, Smale und Devaney dienen als Referenz für Phasenräume, Trajektorien und qualitative Dynamik.',
    'Abschnitt 3.2.8', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.2.6.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 40;

/* [43] Katok / Hasselblatt */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Katok und Hasselblatt dienen als Hauptreferenz für die moderne Theorie dynamischer Systeme, Invarianz und langfristige Zustandsentwicklung.',
    'Abschnitt 3.2.8', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [43].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 43;

/* [44] Ott */
INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Ott dient als Referenz für Chaos, sensitive Abhängigkeit von Anfangsbedingungen und Lyapunov-Exponenten.',
    'Abschnitt 3.2.8', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [44].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 44;

/* 5. Quellen-IDs bestimmen. */
SET @source_37_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 37 LIMIT 1
);
SET @source_39_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 39 LIMIT 1
);
SET @source_40_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 40 LIMIT 1
);
SET @source_43_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 43 LIMIT 1
);
SET @source_44_id := (
    SELECT s.`source_id` FROM `sources` s
    WHERE s.`citation_number` = 44 LIMIT 1
);

/* 6. Alte Belegungen (3.35) bis (3.40) vollständig bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.35','3.36','3.37','3.38','3.39','3.40');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.35','3.36','3.37','3.38','3.39','3.40');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.35','3.36','3.37','3.38','3.39','3.40');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.35','3.36','3.37','3.38','3.39','3.40');

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
    '3.35', @section_id, 'Kontinuierliches dynamisches System',
    '\\dot{x}(t)=F(x(t))',
    '\\dot{x}(t)=F(x(t))',
    'Die zeitlich oder parametrisch kontinuierliche Zustandsänderung wird durch das Vektorfeld F bestimmt.',
    'model', 'literature', @source_40_id,
    NULL, 'x(t) ist differenzierbar und F ist auf dem Zustandsraum definiert.',
    'checked', @revision_id
),
(
    '3.36', @section_id, 'Diskretes dynamisches System',
    'x_{n+1}=F(x_n)',
    'x_{n+1}=F(x_n)',
    'Der Folgezustand eines diskreten dynamischen Systems entsteht durch Anwendung der Abbildung F.',
    'model', 'literature', @source_43_id,
    NULL, 'F bildet den betrachteten Zustandsraum in sich selbst ab.',
    'checked', @revision_id
),
(
    '3.37', @section_id, 'Fixpunkt',
    'F(x^{\\ast})=x^{\\ast}',
    'F(x^{\\ast})=x^{\\ast}',
    'Ein Fixpunkt bleibt unter der Dynamik unverändert.',
    'definition', 'literature', @source_37_id,
    NULL, 'x^{\\ast} liegt im Definitionsbereich von F.',
    'checked', @revision_id
),
(
    '3.38', @section_id, 'Jacobi-Matrix',
    'J_F(x)=\\left(\\frac{\\partial F_i}{\\partial x_j}(x)\\right)_{i,j}',
    'J_F(x)=\\left(\\frac{\\partial F_i}{\\partial x_j}(x)\\right)_{i,j}',
    'Die Jacobi-Matrix enthält die partiellen Ableitungen der Komponenten des Vektorfeldes F.',
    'definition', 'literature', @source_39_id,
    NULL, 'F ist in einer Umgebung von x differenzierbar.',
    'checked', @revision_id
),
(
    '3.39', @section_id, 'Attraktorbedingung',
    '\\operatorname{dist}(F^{n}(x_0),A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)',
    '\\operatorname{dist}(F^{n}(x_0),A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)',
    'Die iterierten Zustände eines Anfangswertes nähern sich der invarianten Menge A an.',
    'definition', 'literature', @source_43_id,
    NULL, 'A ist invariant und x_0 liegt in ihrem Einzugsgebiet.',
    'checked', @revision_id
),
(
    '3.40', @section_id, 'Lyapunov-Entwicklung benachbarter Trajektorien',
    '\\|\\delta x(t)\\|\\approx\\|\\delta x(0)\\|e^{\\lambda t}',
    '\\|\\delta x(t)\\|\\approx\\|\\delta x(0)\\|e^{\\lambda t}',
    'Die lokale Trennung benachbarter Trajektorien wird näherungsweise durch den Lyapunov-Exponenten lambda beschrieben.',
    'model', 'literature', @source_44_id,
    NULL, 'Die linearisierte lokale Entwicklung ist im betrachteten Bereich anwendbar.',
    'checked', @revision_id
);

/* 8. Gleichungs-IDs bestimmen. */
SET @eq_3_35 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.35');
SET @eq_3_36 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.36');
SET @eq_3_37 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.37');
SET @eq_3_38 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.38');
SET @eq_3_39 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.39');
SET @eq_3_40 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.40');

/* 9. Symbolregister unmittelbar vor Einfügen sicher bereinigen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_35,@eq_3_36,@eq_3_37,@eq_3_38,@eq_3_39,@eq_3_40
);

/* 10. Symbolregister idempotent anlegen. */
INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_3_35, 'x(t)', 'Zustandstrajektorie',
 'Vom Entwicklungsparameter abhängiger Zustand.', NULL, 'x(t)\\in X', 1),
(@eq_3_35, '\\dot{x}(t)', 'Zustandsänderung',
 'Ableitung der Zustandstrajektorie nach dem Entwicklungsparameter.', NULL, 'Tangentialraum', 2),
(@eq_3_35, 'F', 'Vektorfeld',
 'Regel der kontinuierlichen Zustandsentwicklung.', NULL, 'F:X\\rightarrow TX', 3),

(@eq_3_36, 'x_n', 'aktueller Zustand',
 'Zustand im diskreten Entwicklungsschritt n.', NULL, 'x_n\\in X', 1),
(@eq_3_36, 'x_{n+1}', 'Folgezustand',
 'Zustand im nachfolgenden Entwicklungsschritt.', NULL, 'x_{n+1}\\in X', 2),
(@eq_3_36, 'F', 'diskrete Dynamik',
 'Abbildung zur Erzeugung des Folgezustands.', NULL, 'F:X\\rightarrow X', 3),

(@eq_3_37, 'x^{\\ast}', 'Fixpunkt',
 'Zustand, der unter der Abbildung F unverändert bleibt.', NULL, 'x^{\\ast}\\in X', 1),
(@eq_3_37, 'F', 'Dynamik',
 'Abbildung des dynamischen Systems.', NULL, 'F:X\\rightarrow X', 2),

(@eq_3_38, 'J_F(x)', 'Jacobi-Matrix',
 'Matrix der ersten partiellen Ableitungen von F am Punkt x.', NULL, 'Matrix', 1),
(@eq_3_38, 'F_i', 'Komponente des Vektorfeldes',
 'i-te Komponente der Abbildung F.', NULL, 'Komponentenfunktion', 2),
(@eq_3_38, 'x_j', 'Zustandskomponente',
 'j-te Koordinate des Zustandes x.', NULL, 'Koordinate', 3),

(@eq_3_39, 'A', 'Attraktor',
 'Invariante Menge, der sich Trajektorien aus ihrem Einzugsgebiet annähern.', NULL, 'A\\subseteq X', 1),
(@eq_3_39, 'F^{n}', 'n-fache Iteration',
 'n-malige Anwendung der Dynamik F.', NULL, 'Iteration', 2),
(@eq_3_39, '\\operatorname{dist}', 'Abstand',
 'Abstand eines Zustandes von der Menge A.', NULL, '\\mathbb{R}_{\\ge0}', 3),

(@eq_3_40, '\\delta x(t)', 'Trajektoriendifferenz',
 'Lokale Differenz zweier benachbarter Trajektorien zum Parameterwert t.', NULL, 'Tangentialraum', 1),
(@eq_3_40, '\\lambda', 'Lyapunov-Exponent',
 'Mittlere exponentielle Wachstums- oder Zerfallsrate lokaler Störungen.', NULL, '\\mathbb{R}', 2),
(@eq_3_40, 't', 'Entwicklungsparameter',
 'Parameter der kontinuierlichen Entwicklung.', NULL, 'Parameterbereich', 3)

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
(@eq_3_36, @eq_3_35, 'contrasts',
 'Die diskrete Dynamik wird der kontinuierlichen Dynamik gegenübergestellt.'),
(@eq_3_37, @eq_3_36, 'uses',
 'Der Fixpunkt ist eine spezielle Invarianzbedingung der diskreten Dynamik.'),
(@eq_3_38, @eq_3_35, 'uses',
 'Die Jacobi-Matrix linearisiert das kontinuierliche Vektorfeld lokal.'),
(@eq_3_39, @eq_3_36, 'uses',
 'Die Attraktorbedingung beruht auf wiederholter Anwendung der diskreten Dynamik.'),
(@eq_3_40, @eq_3_38, 'derived_from',
 'Die lokale Lyapunov-Entwicklung wird aus der linearisierten Dynamik motiviert.');

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
    @revision_id, @section_id, 'rewritten', 'section', '3.2.8',
    'Abschnitt 3.2.8 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit älterer Gleichungsnummerierung.',
    'Neufassung mit den Quellen [37], [39], [40], [43], [44] und den Gleichungen (3.35) bis (3.40).'
),
(
    @revision_id, @section_id, 'source_reused', 'sources', '[37], [39], [40], [43], [44]',
    'Die vorhandenen Quellen zur Dynamik, Stabilität und Chaostheorie wurden registriert.',
    NULL, '5 Quellenverwendungen'
),
(
    @revision_id, @section_id, 'equation_changed', 'equations', '(3.35)–(3.40)',
    'Die Gleichungen dynamischer Systeme wurden neu nummeriert und inhaltlich präzisiert.',
    'Ältere Gleichungsbelegungen.',
    'Kontinuierliche und diskrete Dynamik, Fixpunkt, Jacobi-Matrix, Attraktor und Lyapunov-Entwicklung.'
);

/* 13. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.41'),
    ('last_edited_section', '3.2.8'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.8-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   Kontrollabfragen

   Erwartet:
   - Abschnitt 3.2.8: review
   - 5 Quellenverwendungen
   - 2 Erstnennungen: [43], [44]
   - Gleichungen (3.35) bis (3.40)
   - next_citation_number = 59
   - next_equation_number = 3.41
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.8')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`), 0) AS `first_mentions_in_section`,
    GROUP_CONCAT(s.`citation_number`
                 ORDER BY s.`citation_number`
                 SEPARATOR ', ') AS `citation_numbers`
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
