USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.2.12
   Emergenz und Selbstorganisation als mathematische Grundlagen
   funktionaler Strukturbildung

   Quellen:
   [51] Camazine et al. – Erstnennung
   [52] Mitchell – Erstnennung
   [12] Haken – Wiederverwendung
   [14] Holland – Wiederverwendung

   Gleichungen:
   (3.58) Lokale Zustandsaktualisierung
   (3.59) Gekoppelte Systemdynamik
   (3.60) Rekursive Selbstorganisation
   (3.61) Ordnungsparameter
   (3.62) Rückkopplung
   (3.63) Attraktordynamik

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
    'RKB-2026-07-12-K3.2.12-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.2.12',
    '1.0',
    'Neufassung von Abschnitt 3.2.12 mit den Quellen [12], [14], [51] und [52] sowie den Gleichungen (3.58) bis (3.63).',
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

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.2.12'
    LIMIT 1
);

/* 2. Abschnittsmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `title` = 'Emergenz und Selbstorganisation als mathematische Grundlagen funktionaler Strukturbildung',
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [12], [14], [51] und [52] und enthält die Gleichungen (3.58) bis (3.63).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 0,
    `notes` = 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.'
WHERE `section_code` = '3.2';

/* 3. Quellenverwendungen vollständig ersetzen. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Camazine et al. dienen als Hauptreferenz für Selbstorganisation in biologischen Systemen, lokale Interaktion und stigmergische Strukturbildung.',
    'Abschnitt 3.2.12', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [51].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 51;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'first_citation',
    'Mitchell dient als Referenz für Komplexität, emergente Muster und die Grenzen rein reduktionistischer Beschreibungen.',
    'Abschnitt 3.2.12', 1, 1,
    'Erstnennung der bereits im Repository vorhandenen Quelle [52].',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 52;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Haken wird als Referenz für Ordnungsparameter, Versklavungsprinzip und makroskopische Musterbildung wiederverwendet.',
    'Abschnitt 3.2.12', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 12;

INSERT INTO `source_usage` (
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`, @section_id, 'state_of_research',
    'Holland wird als Referenz für adaptive Systeme, lokale Regeln und globale Organisationsbildung wiederverwendet.',
    'Abschnitt 3.2.12', 0, 1,
    'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` = 14;

/* 4. Quellen-IDs bestimmen. */
SET @source_51_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=51 LIMIT 1);
SET @source_52_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=52 LIMIT 1);
SET @source_12_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=12 LIMIT 1);
SET @source_14_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=14 LIMIT 1);

/* 5. Alte Belegungen (3.58) bis (3.63) vollständig bereinigen. */
DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.58','3.59','3.60','3.61','3.62','3.63');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.58','3.59','3.60','3.61','3.62','3.63');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.58','3.59','3.60','3.61','3.62','3.63');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.58','3.59','3.60','3.61','3.62','3.63');

/* 6. Gleichungen einfügen. */
INSERT INTO `equations` (
    `equation_number`, `section_id`, `title`,
    `equation_latex`, `word_latex`, `plain_description`,
    `equation_type`, `provenance`, `source_id`,
    `derivation`, `assumptions`, `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.58', @section_id, 'Lokale Zustandsaktualisierung',
    'x_i^{(n+1)}=F_i\\!\\left(x_i^{(n)},\\mathcal{N}_i^{(n)}\\right)',
    'x_i^{(n+1)}=F_i\\!\\left(x_i^{(n)},\\mathcal{N}_i^{(n)}\\right)',
    'Der Folgezustand einer lokalen Einheit entsteht aus ihrem aktuellen Zustand und ihrer funktionalen Nachbarschaft.',
    'model', 'literature', @source_51_id,
    NULL, 'Die lokale Aktualisierungsregel F_i und die Nachbarschaft N_i sind definiert.',
    'checked', @revision_id
),
(
    '3.59', @section_id, 'Gekoppelte Systemdynamik',
    '\\frac{dX}{dt}=F(X)+C(X)',
    '\\frac{dX}{dt}=F(X)+C(X)',
    'Die Gesamtdynamik setzt sich aus intrinsischer Entwicklung und Kopplung zwischen Systembestandteilen zusammen.',
    'model', 'literature', @source_51_id,
    NULL, 'X ist ein Systemzustand; F und C sind auf dem Zustandsraum definiert.',
    'checked', @revision_id
),
(
    '3.60', @section_id, 'Rekursive Selbstorganisation',
    'X_{n+1}=F\\!\\left(X_n,X_n^{\\mathrm{Umgebung}}\\right)',
    'X_{n+1}=F\\!\\left(X_n,X_n^{\\mathrm{Umgebung}}\\right)',
    'Der nächste Gesamtzustand entsteht aus dem aktuellen Systemzustand und seiner Umgebung.',
    'model', 'literature', @source_51_id,
    NULL, 'Die System-Umwelt-Kopplung ist in F enthalten.',
    'checked', @revision_id
),
(
    '3.61', @section_id, 'Ordnungsparameter',
    '\\eta=\\Phi(X)',
    '\\eta=\\Phi(X)',
    'Ein makroskopischer Ordnungsparameter wird aus dem mikroskopischen Gesamtzustand abgeleitet.',
    'definition', 'literature', @source_12_id,
    NULL, 'Phi ist eine geeignete Reduktionsabbildung auf eine makroskopische Größe.',
    'checked', @revision_id
),
(
    '3.62', @section_id, 'Rückkopplung zwischen Ordnung und Mikrodynamik',
    'X_{n+1}=F\\!\\left(X_n,\\eta_n\\right),\\qquad \\eta_n=\\Phi(X_n)',
    'X_{n+1}=F\\!\\left(X_n,\\eta_n\\right),\\qquad \\eta_n=\\Phi(X_n)',
    'Der Ordnungsparameter wird aus dem Gesamtzustand gebildet und beeinflusst anschließend die weitere Zustandsentwicklung.',
    'model', 'literature', @source_12_id,
    NULL, 'Die Abbildungen F und Phi sind definiert und kompatibel.',
    'checked', @revision_id
),
(
    '3.63', @section_id, 'Attraktordynamik emergenter Organisation',
    '\\operatorname{dist}(X_n,A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)',
    '\\operatorname{dist}(X_n,A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)',
    'Die rekursive Dynamik nähert sich einer stabilen oder metastabilen Organisationsmenge A an.',
    'model', 'literature', @source_52_id,
    NULL, 'A ist invariant oder hinreichend stabil und X_0 liegt in ihrem Einzugsgebiet.',
    'checked', @revision_id
);

/* 7. Gleichungs-IDs bestimmen. */
SET @eq_3_58 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.58');
SET @eq_3_59 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.59');
SET @eq_3_60 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.60');
SET @eq_3_61 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.61');
SET @eq_3_62 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.62');
SET @eq_3_63 := (SELECT MIN(`equation_id`) FROM `equations` WHERE `equation_number`='3.63');

/* 8. Symbolregister sicher bereinigen und idempotent neu anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_58,@eq_3_59,@eq_3_60,@eq_3_61,@eq_3_62,@eq_3_63
);

INSERT INTO `equation_symbols` (
    `equation_id`, `symbol_latex`, `symbol_name`,
    `definition_text`, `unit_text`, `domain_text`, `symbol_order`
)
VALUES
(@eq_3_58, 'x_i^{(n)}', 'lokaler Zustand',
 'Zustand der i-ten Einheit im Entwicklungsschritt n.', NULL, 'lokaler Zustandsraum', 1),
(@eq_3_58, 'F_i', 'lokale Aktualisierungsregel',
 'Regel zur Aktualisierung der i-ten Einheit.', NULL, 'Abbildung', 2),
(@eq_3_58, '\\mathcal{N}_i^{(n)}', 'funktionale Nachbarschaft',
 'Für die Aktualisierung relevante Umgebung der i-ten Einheit.', NULL, 'Nachbarschaftsstruktur', 3),

(@eq_3_59, 'X', 'Gesamtzustand',
 'Gesamtzustand des gekoppelten Systems.', NULL, 'Zustandsraum', 1),
(@eq_3_59, 'F(X)', 'intrinsische Dynamik',
 'Systeminterne Entwicklung ohne zusätzlichen Kopplungsterm.', NULL, 'Änderungsraum', 2),
(@eq_3_59, 'C(X)', 'Kopplungsterm',
 'Beitrag der Wechselwirkungen zwischen Systembestandteilen.', NULL, 'Änderungsraum', 3),

(@eq_3_60, 'X_n', 'aktueller Gesamtzustand',
 'Gesamtzustand im Entwicklungsschritt n.', NULL, 'Zustandsraum', 1),
(@eq_3_60, 'X_n^{\\mathrm{Umgebung}}', 'Umgebungszustand',
 'Für die weitere Entwicklung relevante Umgebung des Systems.', NULL, 'Umgebungsraum', 2),
(@eq_3_60, 'F', 'System-Umwelt-Transformation',
 'Abbildung zur Erzeugung des Folgezustands.', NULL, 'Abbildung', 3),

(@eq_3_61, '\\eta', 'Ordnungsparameter',
 'Makroskopische Größe zur Beschreibung globaler Organisation.', NULL, 'Ordnungsparameterraum', 1),
(@eq_3_61, '\\Phi', 'Reduktionsabbildung',
 'Abbildung des Gesamtzustands auf den Ordnungsparameter.', NULL, 'Abbildung', 2),
(@eq_3_61, 'X', 'mikroskopischer Gesamtzustand',
 'Gesamtheit der mikroskopischen Freiheitsgrade.', NULL, 'Zustandsraum', 3),

(@eq_3_62, '\\eta_n', 'aktueller Ordnungsparameter',
 'Makroskopischer Ordnungsparameter im Entwicklungsschritt n.', NULL, 'Ordnungsparameterraum', 1),
(@eq_3_62, 'X_{n+1}', 'Folgezustand',
 'Durch Zustand und Ordnungsparameter beeinflusster Folgezustand.', NULL, 'Zustandsraum', 2),
(@eq_3_62, '\\Phi', 'Makroabbildung',
 'Abbildung des Mikrozustands auf die makroskopische Ordnung.', NULL, 'Abbildung', 3),

(@eq_3_63, 'A', 'Organisationsattraktor',
 'Stabile oder metastabile Menge organisierter Zustände.', NULL, 'A\\subseteq X', 1),
(@eq_3_63, '\\operatorname{dist}', 'Abstand',
 'Abstand des Gesamtzustands von der Organisationsmenge A.', NULL, '\\mathbb{R}_{\\ge0}', 2),
(@eq_3_63, 'X_n', 'Systemzustand',
 'Gesamtzustand im Entwicklungsschritt n.', NULL, 'Zustandsraum', 3)

ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 9. Gleichungsabhängigkeiten registrieren. */
INSERT INTO `equation_dependencies` (
    `equation_id`, `depends_on_equation_id`,
    `dependency_type`, `dependency_note`
)
VALUES
(@eq_3_59, @eq_3_58, 'generalizes',
 'Die gekoppelte Gesamtdynamik verallgemeinert lokale Aktualisierungsregeln.'),
(@eq_3_60, @eq_3_59, 'discretizes',
 'Die rekursive Selbstorganisation ist eine diskrete Darstellung gekoppelter Systemdynamik.'),
(@eq_3_61, @eq_3_60, 'derived_from',
 'Der Ordnungsparameter wird aus dem rekursiv entwickelten Gesamtzustand bestimmt.'),
(@eq_3_62, @eq_3_61, 'uses',
 'Die Rückkopplung verwendet den aus dem Zustand abgeleiteten Ordnungsparameter.'),
(@eq_3_63, @eq_3_60, 'uses',
 'Die Attraktordynamik beschreibt das langfristige Verhalten der rekursiven Zustandsfolge.');

/* 10. Änderungsprotokoll aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
VALUES
(
    @revision_id, @section_id, 'rewritten', 'section', '3.2.12',
    'Abschnitt 3.2.12 wurde vollständig neu gefasst.',
    'Bisherige Fassung mit den Gleichungen (3.79) bis (3.82).',
    'Neufassung mit den Quellen [12], [14], [51], [52] und den Gleichungen (3.58) bis (3.63).'
),
(
    @revision_id, @section_id, 'source_reused', 'sources', '[12], [14], [51], [52]',
    'Die vorhandenen Quellen zu Emergenz, Selbstorganisation und Komplexität wurden registriert.',
    NULL, '4 Quellenverwendungen'
),
(
    @revision_id, @section_id, 'equation_changed', 'equations', '(3.58)–(3.63)',
    'Die Gleichungen zur Selbstorganisation wurden neu nummeriert und inhaltlich erweitert.',
    'Bisherige Gleichungen (3.79) bis (3.82).',
    'Lokale Aktualisierung, Kopplung, Rekursion, Ordnungsparameter, Rückkopplung und Attraktordynamik.'
);

/* 11. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('next_citation_number', '59'),
    ('next_equation_number', '3.64'),
    ('last_edited_section', '3.2.12'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.2.12-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* 12. Kontrollabfragen. */
SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.2', '3.2.12')
ORDER BY ds.`section_code`;

SELECT
    COUNT(*) AS `registered_source_usages`,
    COALESCE(SUM(su.`is_first_mention`), 0) AS `first_mentions_in_section`,
    GROUP_CONCAT(s.`citation_number`
                 ORDER BY s.`citation_number`
                 SEPARATOR ', ') AS `citation_numbers`
FROM `source_usage` su
INNER JOIN `sources` s ON s.`source_id` = su.`source_id`
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
INNER JOIN `equations` e ON e.`equation_id` = es.`equation_id`
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
