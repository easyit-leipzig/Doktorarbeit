/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.5

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql

   Abschnitt:
     3.3.5 Axiom A4 – Funktionale Organisationsbildung

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1
     letzte Literaturquelle:      [86]
     nächste freie Literatur-Nr.: [87]
     letzte Gleichung:            (3.286)
     nächste Gleichungen:         (3.287)–(3.290)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquellen:       keine
     wiederverwendete Quellen:    [12] Haken, [13] Prigogine/Stengers, [14] Holland
     nächste freie Literatur-Nr.: [87]
     neue Gleichungen:            (3.287), (3.288), (3.289), (3.290)
     nächste freie Gleichung:     (3.291)
     neue Revision:               RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1

   Registrierte Repository-Objekte:
     repository_revisions, dissertation_sections, source_usage, definitions, axioms,
     axiom_dependencies, object_source_links, equations, equation_symbols, symbols,
     section_change_log, repository_counters sowie vollständige Audit-Abfragen.

   Schemaentscheidungen:
     - axioms.source_assumption_id bleibt NULL.
     - source_usage.usage_type = 'background'.
     - object_source_links.usage_type = 'supporting_source'.
     - Es werden ausschließlich vorhandene Quellen wiederverwendet.
     - Das Skript ist transaktional, idempotent und phpMyAdmin-kompatibel.
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* 1. Parent-Revision */
SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.4-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;
SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      = @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_335`;
CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_335`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;
INSERT INTO `tmp_frzk_parent_revision_335` (`revision_id`) VALUES (@parent_revision_id);
DROP TEMPORARY TABLE `tmp_frzk_parent_revision_335`;

/* 2. Revision */
SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

INSERT INTO `repository_revisions`
(
    `revision_code`, `revision_date`, `scope_type`, `scope_reference`,
    `version_label`, `summary`, `created_by`, `parent_revision_id`
)
VALUES
(
    @revision_code, NOW(), 'section', '3.3.5', 'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.5: Axiom A4 – Funktionale Organisationsbildung. Registriert werden die qualitative Definition funktionaler Organisation, das originäre Axiom A4, Abhängigkeiten von A1 bis A3, die Wiederverwendung der Quellen [12], [13] und [14], die Gleichungen (3.287) bis (3.290), Gleichungssymbole, Abschnittssymbole, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
    'Olaf Thiele / ChatGPT', @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_date`=VALUES(`revision_date`),
    `scope_type`=VALUES(`scope_type`),
    `scope_reference`=VALUES(`scope_reference`),
    `version_label`=VALUES(`version_label`),
    `summary`=VALUES(`summary`),
    `created_by`=VALUES(`created_by`),
    `parent_revision_id`=VALUES(`parent_revision_id`);

SET @revision_id := NULL;
SELECT `revision_id`
INTO @revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      = @revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* 3. Abschnitt */
SET @section_33_id := NULL;
SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci = '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_335`;
CREATE TEMPORARY TABLE `tmp_frzk_parent_section_335`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;
INSERT INTO `tmp_frzk_parent_section_335` (`section_id`) VALUES (@section_33_id);
DROP TEMPORARY TABLE `tmp_frzk_parent_section_335`;

INSERT INTO `dissertation_sections`
(
    `parent_section_id`, `section_code`, `title`, `chapter_no`, `section_order`,
    `status`, `is_original_contribution`, `notes`
)
VALUES
(
    @section_33_id, '3.3.5', 'Axiom A4 – Funktionale Organisationsbildung',
    3, 3.3006, 'review', 1,
    'Viertes originäres FRZK-Axiom. Organisationsbildung wird qualitativ vor Graphen, Zustandsräumen, Topologien und konkreten Emergenzmodellen eingeführt. Raum und Zeit werden nicht vorausgesetzt.'
)
ON DUPLICATE KEY UPDATE
    `parent_section_id`=VALUES(`parent_section_id`),
    `title`=VALUES(`title`),
    `chapter_no`=VALUES(`chapter_no`),
    `section_order`=VALUES(`section_order`),
    `status`=VALUES(`status`),
    `is_original_contribution`=VALUES(`is_original_contribution`),
    `notes`=VALUES(`notes`);

SET @section_id := NULL;
SELECT `section_id`
INTO @section_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci = '3.3.5' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* 4. Quellen [12], [13], [14] */
SET @source_12_id := NULL;
SET @source_13_id := NULL;
SET @source_14_id := NULL;

SELECT `source_id` INTO @source_12_id FROM `sources` WHERE `citation_number`=12 LIMIT 1;
SELECT `source_id` INTO @source_13_id FROM `sources` WHERE `citation_number`=13 LIMIT 1;
SELECT `source_id` INTO @source_14_id FROM `sources` WHERE `citation_number`=14 LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_sources_12_14_335`;
CREATE TEMPORARY TABLE `tmp_frzk_sources_12_14_335`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;
INSERT INTO `tmp_frzk_sources_12_14_335` (`source_id`)
VALUES (@source_12_id), (@source_13_id), (@source_14_id);
DROP TEMPORARY TABLE `tmp_frzk_sources_12_14_335`;

/* 5. Quellenverwendungen */
DELETE FROM `source_usage` WHERE `section_id`=@section_id;

INSERT INTO `source_usage`
(
    `source_id`, `section_id`, `usage_type`, `claim_summary`, `exact_location`,
    `is_first_mention`, `citation_checked`, `notes`, `created_revision_id`
)
VALUES
(
    @source_12_id, @section_id, 'background',
    'Haken wird als Forschungsanschluss für die Möglichkeit makroskopischer Ordnungsstrukturen aus dem Zusammenwirken vieler Freiheitsgrade verwendet.',
    '3.3.5, Absatz zum wissenschaftlichen Forschungsstand der Organisationsbildung',
    0, 1,
    'Wiederverwendung der bereits in Kapitel 3.1 eingeführten Quelle [12]. Keine Übernahme eines konkreten synergetischen Modells.',
    @revision_id
),
(
    @source_13_id, @section_id, 'background',
    'Prigogine und Stengers werden als Forschungsanschluss für dissipative Strukturbildung in offenen nichtlinearen Systemen verwendet.',
    '3.3.5, Absatz zum wissenschaftlichen Forschungsstand der Organisationsbildung',
    0, 1,
    'Wiederverwendung der bereits in Kapitel 3.1 eingeführten Quelle [13]. Keine thermodynamischen Voraussetzungen im Axiom.',
    @revision_id
),
(
    @source_14_id, @section_id, 'background',
    'Holland wird als Forschungsanschluss für globale Muster aus lokalen Interaktionen in komplexen adaptiven Systemen verwendet.',
    '3.3.5, Absatz zum wissenschaftlichen Forschungsstand der Organisationsbildung',
    0, 1,
    'Wiederverwendung der bereits in Kapitel 3.1 eingeführten Quelle [14]. Keine Agentenpopulation wird axiomatisch vorausgesetzt.',
    @revision_id
);

/* 6. Definition funktionale Organisation */
INSERT INTO `definitions`
(
    `definition_number`, `section_id`, `title`, `definition_text`,
    `formal_latex`, `word_latex`, `provenance`, `source_id`,
    `assumptions`, `notes`, `validation_status`, `created_revision_id`
)
VALUES
(
    'Def. 3.3.5.1', @section_id, 'Funktionale Organisation',
    'Eine funktionale Organisation bezeichnet in Kapitel 3.3 einen übergeordneten, prinzipiell wiedererkennbaren Zusammenhang mehrerer funktionaler Zustände, Relationierungen oder Transformationen, der nicht vollständig auf eine einzelne isolierte Relation oder Veränderung reduziert werden kann. Sie ist noch keine mathematische Menge, kein Graph, kein Zustandsraum und keine topologische Struktur.',
    NULL, NULL, 'original', NULL,
    'Axiom A1, Axiom A2 und Axiom A3 sowie die primitiven Begriffe Organisation, Relationierbarkeit und Transformation werden vorausgesetzt.',
    'Qualitative Sprachdefinition. Stabilität oder Kohärenz werden noch nicht vorausgesetzt.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `definition_text`=VALUES(`definition_text`),
    `formal_latex`=VALUES(`formal_latex`),
    `word_latex`=VALUES(`word_latex`),
    `provenance`=VALUES(`provenance`),
    `source_id`=VALUES(`source_id`),
    `assumptions`=VALUES(`assumptions`),
    `notes`=VALUES(`notes`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

SET @definition_id := NULL;
SELECT `definition_id`
INTO @definition_id
FROM `definitions`
WHERE `definition_number` COLLATE utf8mb4_unicode_ci
      = 'Def. 3.3.5.1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* 7. Axiome A1–A3 laden */
SET @axiom_a1_id := NULL;
SET @axiom_a2_id := NULL;
SET @axiom_a3_id := NULL;

SELECT `axiom_id` INTO @axiom_a1_id FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci='A1' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `axiom_id` INTO @axiom_a2_id FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci='A2' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `axiom_id` INTO @axiom_a3_id FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci='A3' COLLATE utf8mb4_unicode_ci LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_axioms_a1_a3_335`;
CREATE TEMPORARY TABLE `tmp_frzk_axioms_a1_a3_335`
(
    `axiom_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;
INSERT INTO `tmp_frzk_axioms_a1_a3_335` (`axiom_id`)
VALUES (@axiom_a1_id), (@axiom_a2_id), (@axiom_a3_id);
DROP TEMPORARY TABLE `tmp_frzk_axioms_a1_a3_335`;

/* 8. Axiom A4 */
INSERT INTO `axioms`
(
    `axiom_number`, `section_id`, `title`, `axiom_text`,
    `formal_latex`, `word_latex`, `motivation`, `independence_note`,
    `consistency_note`, `operationalization_note`,
    `source_assumption_id`, `status`, `created_revision_id`
)
VALUES
(
    'A4', @section_id, 'Funktionale Organisationsbildung',
    'Relationierte und transformierbare funktionale Zustände können zusammenhängende und wiedererkennbare Organisationsmuster bilden.',
    'A_4:\\quad\\text{Funktionale Relationierungen und Transformationen sind prinzipiell organisationsbildend.}',
    'A_4:\\quad\\text{Funktionale Relationierungen und Transformationen sind prinzipiell organisationsbildend.}',
    'Axiom A1 bis Axiom A3 ermöglichen Unterscheidbarkeit, Relationierbarkeit und Transformation, begründen jedoch noch keine übergeordnete Organisationsstruktur. Axiom A4 ergänzt die eigenständige Möglichkeit strukturierter Zusammenfassung.',
    'Axiom A4 setzt Axiom A1, Axiom A2 und Axiom A3 voraus, ist aus deren gemeinsamer Geltung jedoch nicht ableitbar. Ein Modell ungeordneter, fortlaufend entstehender und zerfallender Relationen bleibt begrifflich möglich.',
    'Das Axiom ist mit Axiom A1 bis Axiom A3 vereinbar, weil es lediglich die Möglichkeit organisationsbildender Muster ergänzt und keine konkrete Organisationsform fordert.',
    'In Kapitel 3.4 wird aus Axiom A4 eine funktionale Organisationsstruktur rekonstruiert. Konnektivität, Topologie, Netzwerke, Attraktoren oder Hierarchien werden nicht axiomatisch vorweggenommen.',
    NULL, 'review', @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `axiom_text`=VALUES(`axiom_text`),
    `formal_latex`=VALUES(`formal_latex`),
    `word_latex`=VALUES(`word_latex`),
    `motivation`=VALUES(`motivation`),
    `independence_note`=VALUES(`independence_note`),
    `consistency_note`=VALUES(`consistency_note`),
    `operationalization_note`=VALUES(`operationalization_note`),
    `source_assumption_id`=VALUES(`source_assumption_id`),
    `status`=VALUES(`status`),
    `created_revision_id`=VALUES(`created_revision_id`);

SET @axiom_a4_id := NULL;
SELECT `axiom_id`
INTO @axiom_a4_id
FROM `axioms`
WHERE `axiom_number` COLLATE utf8mb4_unicode_ci='A4' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* 9. Abhängigkeiten */
DELETE FROM `axiom_dependencies` WHERE `axiom_id`=@axiom_a4_id;

INSERT INTO `axiom_dependencies`
(`axiom_id`,`depends_on_axiom_id`,`dependency_type`,`note`)
VALUES
(@axiom_a4_id,@axiom_a1_id,'depends_on','Organisationsbildung setzt funktional unterscheidbare Zuständlichkeit voraus.'),
(@axiom_a4_id,@axiom_a2_id,'depends_on','Organisationsbildung setzt funktionale Relationierbarkeit voraus.'),
(@axiom_a4_id,@axiom_a3_id,'depends_on','Organisationsbildung setzt Transformierbarkeit funktionaler Zustände und Zusammenhänge voraus.')
ON DUPLICATE KEY UPDATE `note`=VALUES(`note`);

/* 10. Objekt-Quellen-Verknüpfungen */
DELETE FROM `object_source_links`
WHERE `object_type`='axiom' AND `object_id`=@axiom_a4_id
  AND `source_id` IN (@source_12_id,@source_13_id,@source_14_id);

INSERT INTO `object_source_links`
(`object_type`,`object_id`,`source_id`,`usage_type`,`note`)
VALUES
('axiom',@axiom_a4_id,@source_12_id,'supporting_source',
 'Haken dient als Forschungsanschluss für emergente Ordnungsbildung. Axiom A4 übernimmt kein konkretes synergetisches Modell.'),
('axiom',@axiom_a4_id,@source_13_id,'supporting_source',
 'Prigogine und Stengers dienen als Forschungsanschluss für dissipative Strukturbildung. Axiom A4 setzt keine Thermodynamik voraus.'),
('axiom',@axiom_a4_id,@source_14_id,'supporting_source',
 'Holland dient als Forschungsanschluss für globale Muster aus lokalen Interaktionen. Axiom A4 setzt keine Agentenpopulation voraus.');

DELETE FROM `object_source_links`
WHERE `object_type`='definition' AND `object_id`=@definition_id
  AND `source_id` IN (@source_12_id,@source_13_id,@source_14_id);

INSERT INTO `object_source_links`
(`object_type`,`object_id`,`source_id`,`usage_type`,`note`)
VALUES
('definition',@definition_id,@source_12_id,'supporting_source',
 'Forschungsanschluss zur Möglichkeit emergenter Organisationsformen. Die Definition ist originäre FRZK-Eigenleistung.'),
('definition',@definition_id,@source_13_id,'supporting_source',
 'Forschungsanschluss zur Strukturbildung unter Dynamik. Keine thermodynamische Definition wird übernommen.'),
('definition',@definition_id,@source_14_id,'supporting_source',
 'Forschungsanschluss zu komplexer adaptiver Organisationsbildung. Die qualitative Definition bleibt allgemeiner.');

/* 11. Gleichungen */
INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
 `plain_description`,`equation_type`,`provenance`,`source_id`,
 `derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES
('3.287',@section_id,'Axiom A4 – komprimierte axiomatische Schreibweise',
 'A_4:\\quad\\text{Funktionale Relationierungen und Transformationen sind prinzipiell organisationsbildend.}',
 'A_4:\\quad\\text{Funktionale Relationierungen und Transformationen sind prinzipiell organisationsbildend.}',
 'Komprimierte qualitative Formulierung des vierten FRZK-Axioms. Sie führt weder Graph, Topologie, Zustandsraum noch konkrete Emergenzmechanismen ein.',
 'axiom','original',NULL,
 'Originäre axiomatische Setzung auf Grundlage funktionaler Unterscheidbarkeit, Relationierbarkeit und Transformierbarkeit.',
 'Axiom A1, Axiom A2 und Axiom A3 werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),
`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),
`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),
`provenance`=VALUES(`provenance`),`source_id`=VALUES(`source_id`),
`derivation`=VALUES(`derivation`),`assumptions`=VALUES(`assumptions`),
`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
 `plain_description`,`equation_type`,`provenance`,`source_id`,
 `derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES
('3.288',@section_id,'Qualitative Abhängigkeit von Axiom A4 von Axiom A1 bis Axiom A3',
 'A_4\\;\\Longrightarrow\\;A_1\\land A_2\\land A_3',
 'A_4\\Longrightarrow A_1\\land A_2\\land A_3',
 'Qualitative axiomatische Abhängigkeit: Organisationsbildung benötigt unterscheidbare, relationierbare und transformierbare Zuständlichkeit.',
 'schema','original',NULL,
 'Axiom A4 kann nur auf den durch Axiom A1 bis Axiom A3 eröffneten qualitativen Strukturen angewendet werden.',
 'Noch kein vollständig formalisierter Beweis.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),
`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),
`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),
`provenance`=VALUES(`provenance`),`source_id`=VALUES(`source_id`),
`derivation`=VALUES(`derivation`),`assumptions`=VALUES(`assumptions`),
`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
 `plain_description`,`equation_type`,`provenance`,`source_id`,
 `derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES
('3.289',@section_id,'Qualitative Nichtableitbarkeit von Axiom A4 aus Axiom A1 bis Axiom A3',
 'A_1\\land A_2\\land A_3\\;\\not\\Longrightarrow\\;A_4',
 'A_1\\land A_2\\land A_3\\not\\Longrightarrow A_4',
 'Qualitative Aussage, dass Unterscheidbarkeit, Relationierbarkeit und Transformierbarkeit allein noch keine Organisationsbildung begründen.',
 'schema','original',NULL,
 'Ein begriffliches Modell ungeordneter und fortlaufend zerfallender funktionaler Verknüpfungen zeigt die eigenständige Rolle von Axiom A4.',
 'Noch kein vollständiger modelltheoretischer Unabhängigkeitsbeweis.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),
`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),
`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),
`provenance`=VALUES(`provenance`),`source_id`=VALUES(`source_id`),
`derivation`=VALUES(`derivation`),`assumptions`=VALUES(`assumptions`),
`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
 `plain_description`,`equation_type`,`provenance`,`source_id`,
 `derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES
('3.290',@section_id,'Gemeinsame qualitative Reichweite der Axiome A1 bis A4',
 'A_1\\land A_2\\land A_3\\land A_4\\;\\Longrightarrow\\;\\text{funktional unterscheidbare, relationierbare, transformierbare und organisationsbildende Zuständlichkeit}',
 'A_1\\land A_2\\land A_3\\land A_4\\Longrightarrow\\text{funktional unterscheidbare, relationierbare, transformierbare und organisationsbildende Zuständlichkeit}',
 'Qualitative Zusammenfassung der gemeinsamen Reichweite der ersten vier FRZK-Axiome.',
 'schema','original',NULL,
 'Zusammenführung der qualitativen Reichweite von Axiom A1 bis Axiom A4.',
 'Es wird noch keine mathematisch vollständig rekonstruierte Organisation behauptet.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),
`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),
`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),
`provenance`=VALUES(`provenance`),`source_id`=VALUES(`source_id`),
`derivation`=VALUES(`derivation`),`assumptions`=VALUES(`assumptions`),
`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

SET @eq_3287:=NULL; SET @eq_3288:=NULL; SET @eq_3289:=NULL; SET @eq_3290:=NULL;
SELECT `equation_id` INTO @eq_3287 FROM `equations` WHERE `equation_number`='3.287' LIMIT 1;
SELECT `equation_id` INTO @eq_3288 FROM `equations` WHERE `equation_number`='3.288' LIMIT 1;
SELECT `equation_id` INTO @eq_3289 FROM `equations` WHERE `equation_number`='3.289' LIMIT 1;
SELECT `equation_id` INTO @eq_3290 FROM `equations` WHERE `equation_number`='3.290' LIMIT 1;

/* 12. Gleichungssymbole */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3287,@eq_3288,@eq_3289,@eq_3290);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES
(@eq_3287,'A_4','Axiom A4','Bezeichnung des vierten FRZK-Axioms der funktionalen Organisationsbildung.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3288,'A_4','Axiom A4','Bezeichnung des Axioms der funktionalen Organisationsbildung.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3288,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative axiomatische Voraussetzung.',NULL,'qualitative axiomatische Abhängigkeit',2),
(@eq_3288,'A_1','Axiom A1','Bezeichnung des ersten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3288,'\\land','logische Konjunktion','Verknüpft die vorausgesetzten Axiome.',NULL,'qualitative logische Verknüpfung',4),
(@eq_3288,'A_2','Axiom A2','Bezeichnung des zweiten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3288,'A_3','Axiom A3','Bezeichnung des dritten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',6),
(@eq_3289,'A_1','Axiom A1','Bezeichnung des ersten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3289,'\\land','logische Konjunktion','Verknüpft die vorausgesetzten Axiome.',NULL,'qualitative logische Verknüpfung',2),
(@eq_3289,'A_2','Axiom A2','Bezeichnung des zweiten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3289,'A_3','Axiom A3','Bezeichnung des dritten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3289,'\\not\\Longrightarrow','qualitativer Nichtableitungspfeil','Kennzeichnet die behauptete qualitative Nichtableitbarkeit von A4 aus A1 bis A3.',NULL,'qualitative axiomatische Nichtableitbarkeit',5),
(@eq_3289,'A_4','Axiom A4','Bezeichnung des vierten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',6),
(@eq_3290,'A_1','Axiom A1','Bezeichnung des ersten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3290,'\\land','logische Konjunktion','Verknüpft Axiom A1 bis Axiom A4.',NULL,'qualitative logische Verknüpfung',2),
(@eq_3290,'A_2','Axiom A2','Bezeichnung des zweiten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3290,'A_3','Axiom A3','Bezeichnung des dritten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3290,'A_4','Axiom A4','Bezeichnung des vierten FRZK-Axioms.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3290,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet die gemeinsame qualitative Reichweite der Axiome.',NULL,'qualitative axiomatische Zusammenfassung',6)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),
`symbol_order`=VALUES(`symbol_order`);

/* 13. Abschnittssymbole */
INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,
 `scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,
 `domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,
 `notes`,`validation_status`,`created_revision_id`)
VALUES
('A_4','A_4','Axiom A4',
 'Bezeichnung des vierten FRZK-Axioms der funktionalen Organisationsbildung.',
 'section',@section_id,@eq_3287,NULL,
 'qualitative FRZK-Axiomatik','qualitative FRZK-Axiomatik',
 0,0,0,'Kein mathematisches Objekt.','checked',@revision_id),
('\\not\\Longrightarrow','\\not\\Longrightarrow','qualitativer Nichtableitungspfeil',
 'Kennzeichnet die qualitative Nichtableitbarkeit von Axiom A4 aus Axiom A1 bis Axiom A3.',
 'section',@section_id,@eq_3289,NULL,
 'qualitative axiomatische Nichtableitbarkeit','qualitative axiomatische Nichtableitbarkeit',
 0,0,0,'Kein abgeschlossener modelltheoretischer Unabhängigkeitsbeweis.','checked',@revision_id),
('\\land','\\land','logische Konjunktion',
 'Logisches Und zur qualitativen Verknüpfung der Axiome A1 bis A4.',
 'section',@section_id,@eq_3288,NULL,
 'qualitative logische Aussagen','qualitative logische Aussagen',
 0,0,0,'Dient ausschließlich der komprimierten Darstellung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),`first_equation_id`=VALUES(`first_equation_id`),
`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),
`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),
`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

/* 14. Änderungsprotokoll */
DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;

INSERT INTO `section_change_log`
(`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,
 `change_summary`,`previous_value`,`new_value`)
VALUES
(@revision_id,@section_id,'rewritten','section','3.3.5',
 'Abschnitt 3.3.5 wurde vollständig als Formulierung und Begründung von Axiom A4 neu gefasst.',
 'Älterer Planungsstand.','Axiom A4 – Funktionale Organisationsbildung.'),
(@revision_id,@section_id,'source_reused','source_usage','[12], [13], [14]',
 'Haken, Prigogine/Stengers und Holland wurden als Forschungsanschlüsse wiederverwendet.',
 NULL,'Drei geprüfte Wiederverwendungen.'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.3.5.1',
 'Der qualitative Begriff funktionaler Organisation wurde registriert und von mathematischen Strukturen abgegrenzt.',
 NULL,'Def. 3.3.5.1 Funktionale Organisation.'),
(@revision_id,@section_id,'axiom_added','axioms','A4',
 'Axiom A4 wurde einschließlich Motivation, Konsistenz-, Unabhängigkeits- und Operationalisierungshinweis registriert.',
 NULL,'A4 – Funktionale Organisationsbildung.'),
(@revision_id,@section_id,'equation_added','equations','(3.287)–(3.290)',
 'Vier qualitative axiomatische Darstellungen wurden vollständig registriert.',
 NULL,'Axiom A4, Abhängigkeit, Nichtableitbarkeit und gemeinsame Reichweite von A1 bis A4.'),
(@revision_id,@section_id,'symbol_added','symbols','A_4, \\not\\Longrightarrow, \\land',
 'Die neuen abschnittsspezifischen Symbole wurden registriert.',
 NULL,'Drei Abschnittssymbole.'),
(@revision_id,@section_id,'status_changed','section','3.3.5',
 'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
 'planned','review');

/* 15. Counter */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('last_edited_section','3.3.5'),
('last_repository_revision','RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1'),
('next_citation_number','87'),
('next_equation_number','3.291')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

/* =================================================================================================
   16. AUDIT
   ================================================================================================= */

SELECT r.`revision_code`, p.`revision_code` AS `parent_revision_code`,
       r.`scope_reference`, r.`version_label`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p ON p.`revision_id`=r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci
      ='RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

SELECT ds.`section_code`, ds.`title`, ds.`status`,
       ds.`is_original_contribution`, p.`section_code` AS `parent_section_code`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` p ON p.`section_id`=ds.`parent_section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci='3.3.5' COLLATE utf8mb4_unicode_ci;

SELECT s.`citation_number`, s.`short_citation_text`, su.`usage_type`,
       su.`is_first_mention`, su.`citation_checked`, su.`claim_summary`
FROM `source_usage` su
JOIN `sources` s ON s.`source_id`=su.`source_id`
WHERE su.`section_id`=@section_id
ORDER BY s.`citation_number`;

SELECT d.`definition_number`, d.`title`, d.`provenance`, d.`validation_status`
FROM `definitions` d
WHERE d.`section_id`=@section_id;

SELECT ax.`axiom_number`, ax.`title`, ax.`status`, ax.`source_assumption_id`,
       rr.`revision_code`
FROM `axioms` ax
LEFT JOIN `repository_revisions` rr ON rr.`revision_id`=ax.`created_revision_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci='A4' COLLATE utf8mb4_unicode_ci;

SELECT ax.`axiom_number`, parent_ax.`axiom_number` AS `depends_on_axiom`,
       ad.`dependency_type`, ad.`note`
FROM `axiom_dependencies` ad
JOIN `axioms` ax ON ax.`axiom_id`=ad.`axiom_id`
JOIN `axioms` parent_ax ON parent_ax.`axiom_id`=ad.`depends_on_axiom_id`
WHERE ax.`axiom_number` COLLATE utf8mb4_unicode_ci='A4' COLLATE utf8mb4_unicode_ci
ORDER BY parent_ax.`axiom_number`;

SELECT osl.`object_type`, s.`citation_number`, osl.`usage_type`, osl.`note`
FROM `object_source_links` osl
JOIN `sources` s ON s.`source_id`=osl.`source_id`
WHERE ((osl.`object_type`='axiom' AND osl.`object_id`=@axiom_a4_id)
    OR (osl.`object_type`='definition' AND osl.`object_id`=@definition_id))
ORDER BY osl.`object_type`, s.`citation_number`;

SELECT e.`equation_number`, e.`title`, e.`equation_type`, e.`validation_status`,
       CASE WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`)='' THEN 'FEHLT' ELSE 'OK' END AS `word_latex_audit`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND e.`equation_number` IN ('3.287','3.288','3.289','3.290')
ORDER BY e.`equation_number`;

SELECT e.`equation_number`, es.`symbol_latex`, es.`symbol_name`, es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id
  AND e.`equation_number` IN ('3.287','3.288','3.289','3.290')
ORDER BY e.`equation_number`, es.`symbol_order`;

SELECT sy.`symbol_latex`, sy.`symbol_name`, sy.`scope_type`,
       sy.`validation_status`, e.`equation_number` AS `first_equation_number`
FROM `symbols` sy
LEFT JOIN `equations` e ON e.`equation_id`=sy.`first_equation_id`
WHERE sy.`first_section_id`=@section_id
ORDER BY sy.`symbol_latex`;

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
('last_edited_section','last_repository_revision','next_citation_number','next_equation_number')
ORDER BY `counter_key`;

SELECT `equation_number`, COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*)>1;

SELECT `equation_id`,`symbol_latex`,COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`,`symbol_latex`
HAVING COUNT(*)>1;

SELECT `equation_number`,`title`
FROM `equations`
WHERE `section_id`=@section_id
  AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');

SELECT 'source_usage' AS `table_name`, CAST(`usage_id` AS CHAR) AS `row_id`, `usage_type` AS `enum_value`
FROM `source_usage`
WHERE `section_id`=@section_id AND (`usage_type` IS NULL OR TRIM(`usage_type`)='')
UNION ALL
SELECT 'section_change_log', CAST(`change_id` AS CHAR), `change_type`
FROM `section_change_log`
WHERE `section_id`=@section_id AND (`change_type` IS NULL OR TRIM(`change_type`)='')
UNION ALL
SELECT 'object_source_links', CAST(`object_source_link_id` AS CHAR), `usage_type`
FROM `object_source_links`
WHERE (((`object_type`='axiom' AND `object_id`=@axiom_a4_id)
     OR (`object_type`='definition' AND `object_id`=@definition_id)))
  AND (`usage_type` IS NULL OR TRIM(`usage_type`)='');

SELECT scl.`change_type`, scl.`object_type`, scl.`object_reference`, scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id`=@revision_id AND scl.`section_id`=@section_id
ORDER BY scl.`change_id`;

SELECT
'Repository-Update 3.3.5 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [87], Gleichung (3.291), letzte Revision RKB-2026-07-16-K3.3.5-NEUFASSUNG-V1.'
AS `result`;
