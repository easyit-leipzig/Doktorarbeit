/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.7

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql

   Abschnitt:
     3.3.7 Qualitative Konsequenzen des vollständigen Axiomensystems

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1
     letzte Literaturquelle:      [87]
     nächste freie Literatur-Nr.: [88]
     letzte Gleichung:            (3.294)
     nächste Gleichungen:         (3.295)–(3.306)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquellen:       keine
     wiederverwendete Quellen:    [12], [13], [87]
     nächste freie Literatur-Nr.: [88]
     neue Gleichungen:            (3.295)–(3.306)
     nächste freie Gleichung:     (3.307)
     neue Revision:               RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1

   Registrierte Repository-Objekte:
     - repository_revisions
     - dissertation_sections
     - source_usage
     - definitions
     - object_source_links
     - equations
     - equation_symbols
     - symbols
     - section_change_log
     - repository_counters
     - vollständige Audit- und Kontrollabfragen

   Wichtige Schemaentscheidungen:
     - Es werden keine neuen Quellen angelegt.
     - source_usage.usage_type verwendet ausschließlich gültige ENUM-Werte.
     - object_source_links.usage_type verwendet ausschließlich gültige ENUM-Werte.
     - section_change_log.change_type verwendet ausschließlich gültige ENUM-Werte.
     - Keine assumption_id und kein zusätzliches Axiom werden konstruiert.
     - Das Skript ist transaktional, idempotent und phpMyAdmin-kompatibel.
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Parent-Revision laden und prüfen
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.6-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_337`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_337`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_337` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_337`;

/* -------------------------------------------------------------------------------------------------
   2. Neue Abschnittsrevision
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

INSERT INTO `repository_revisions`
(
    `revision_code`,
    `revision_date`,
    `scope_type`,
    `scope_reference`,
    `version_label`,
    `summary`,
    `created_by`,
    `parent_revision_id`
)
VALUES
(
    @revision_code,
    NOW(),
    'section',
    '3.3.7',
    'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.7: Qualitative Konsequenzen des vollständigen Axiomensystems. Registriert werden die qualitative Zusammenfassung des Axiomensystems, die Konsequenzen relationaler Bestimmbarkeit, Veränderbarkeit ohne vorausgesetzte Zeit, möglicher Selbstorganisation, prozessualer Identität, dynamischer Kohärenz, funktionaler Raum- und Zeitrekonstruktion, notwendiger Kohärenzbedingungen, Modellpluralität und der Trennung zwischen axiomatischer Möglichkeit und empirischer Realisierung sowie die Gleichungen (3.295) bis (3.306), Symbole, Quellenverwendungen, Objekt-Quellen-Verknüpfungen, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_date`      = VALUES(`revision_date`),
    `scope_type`         = VALUES(`scope_type`),
    `scope_reference`    = VALUES(`scope_reference`),
    `version_label`      = VALUES(`version_label`),
    `summary`            = VALUES(`summary`),
    `created_by`         = VALUES(`created_by`),
    `parent_revision_id` = VALUES(`parent_revision_id`);

SET @revision_id := NULL;

SELECT `revision_id`
INTO @revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   3. Abschnitt 3.3.7 registrieren
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_337`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_337`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_337` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_337`;

INSERT INTO `dissertation_sections`
(
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`,
    `notes`
)
VALUES
(
    @section_33_id,
    '3.3.7',
    'Qualitative Konsequenzen des vollständigen Axiomensystems',
    3,
    3.3008,
    'review',
    1,
    'Der Abschnitt führt keine neuen Axiome ein. Er systematisiert die unmittelbaren qualitativen Konsequenzen der Axiome A1 bis A5 und grenzt sie ausdrücklich von mathematischen Beweisen und empirischen Realisierungen ab.'
)
ON DUPLICATE KEY UPDATE
    `parent_section_id`        = VALUES(`parent_section_id`),
    `title`                    = VALUES(`title`),
    `chapter_no`               = VALUES(`chapter_no`),
    `section_order`            = VALUES(`section_order`),
    `status`                   = VALUES(`status`),
    `is_original_contribution` = VALUES(`is_original_contribution`),
    `notes`                    = VALUES(`notes`);

SET @section_id := NULL;

SELECT `section_id`
INTO @section_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.7' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   4. Bereits vorhandene Quellen [12], [13], [87] laden
   ------------------------------------------------------------------------------------------------- */

SET @source_12_id := NULL;
SET @source_13_id := NULL;
SET @source_87_id := NULL;

SELECT `source_id`
INTO @source_12_id
FROM `sources`
WHERE `citation_number` = 12
LIMIT 1;

SELECT `source_id`
INTO @source_13_id
FROM `sources`
WHERE `citation_number` = 13
LIMIT 1;

SELECT `source_id`
INTO @source_87_id
FROM `sources`
WHERE `citation_number` = 87
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_sources_337`;

CREATE TEMPORARY TABLE `tmp_frzk_sources_337`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_sources_337` (`source_id`)
VALUES
    (@source_12_id),
    (@source_13_id),
    (@source_87_id);

DROP TEMPORARY TABLE `tmp_frzk_sources_337`;

/* -------------------------------------------------------------------------------------------------
   5. Quellenverwendungen des Abschnitts
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

INSERT INTO `source_usage`
(
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
VALUES
(
    @source_12_id,
    @section_id,
    'background',
    'Haken wird als wissenschaftlicher Hintergrund für dynamische Ordnungsbildung, Selbstorganisation und den Erhalt makroskopischer Organisationsformen verwendet.',
    '3.3.7, Konsequenzen zur Selbstorganisation und dynamischen Kohärenz',
    0,
    1,
    'Wiederverwendung der Quelle [12]. Keine neue theoretische Übernahme und kein neues Axiom.',
    @revision_id
),
(
    @source_13_id,
    @section_id,
    'background',
    'Prigogine und Stengers werden als wissenschaftlicher Hintergrund für dynamische Strukturbildung und Erhalt unter fortlaufender Veränderung verwendet.',
    '3.3.7, Konsequenzen zur Organisationsbildung und dynamischen Kohärenz',
    0,
    1,
    'Wiederverwendung der Quelle [13]. Keine thermodynamischen Spezialbedingungen werden vorausgesetzt.',
    @revision_id
),
(
    @source_87_id,
    @section_id,
    'background',
    'Maturana und Varela werden als wissenschaftlicher Hintergrund für prozessuale funktionale Identität und organisatorische Reproduktion verwendet.',
    '3.3.7, Konsequenz zur prozessualen funktionalen Identität',
    0,
    1,
    'Wiederverwendung der Quelle [87]. Keine biologische Autopoiesisdefinition wird übernommen.',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   6. Qualitative Sammeldefinition des vollständigen Axiomensystems
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `definitions`
(
    `definition_number`,
    `section_id`,
    `title`,
    `definition_text`,
    `formal_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    'Def. 3.3.7.1',
    @section_id,
    'Vollständiges qualitatives FRZK-Axiomensystem',
    'Das vollständige qualitative FRZK-Axiomensystem umfasst die fünf Axiome A1 bis A5: funktionale Unterscheidbarkeit, funktionale Relationierbarkeit, funktionale Transformierbarkeit, funktionale Organisationsbildung sowie funktionale Kohärenz und Stabilisierung. Die Zusammenfassung besitzt in Abschnitt 3.3.7 noch keinen vollständig formalisierten mengentheoretischen oder modelltheoretischen Status.',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5\\right\\}',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5\\right\\}',
    'original',
    NULL,
    'Die Axiome A1 bis A5 aus den Abschnitten 3.3.2 bis 3.3.6 werden vorausgesetzt.',
    'Sammeldefinition zur Kennzeichnung des vollständigen qualitativen Axiomensystems.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `definition_text`     = VALUES(`definition_text`),
    `formal_latex`        = VALUES(`formal_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `assumptions`         = VALUES(`assumptions`),
    `notes`               = VALUES(`notes`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

SET @definition_axiom_system_id := NULL;

SELECT `definition_id`
INTO @definition_axiom_system_id
FROM `definitions`
WHERE `definition_number` COLLATE utf8mb4_unicode_ci
      =
      'Def. 3.3.7.1' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   7. Objekt-Quellen-Verknüpfungen der Sammeldefinition
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE `object_type` = 'definition'
  AND `object_id` = @definition_axiom_system_id
  AND `source_id` IN (@source_12_id, @source_13_id, @source_87_id);

INSERT INTO `object_source_links`
(
    `object_type`,
    `object_id`,
    `source_id`,
    `usage_type`,
    `note`
)
VALUES
(
    'definition',
    @definition_axiom_system_id,
    @source_12_id,
    'supporting_source',
    'Haken dient als Forschungsanschluss für Selbstorganisation und dynamische Ordnungsbildung. Die FRZK-Sammeldefinition ist originär.'
),
(
    'definition',
    @definition_axiom_system_id,
    @source_13_id,
    'supporting_source',
    'Prigogine und Stengers dienen als Forschungsanschluss für dynamische Strukturbildung. Die FRZK-Sammeldefinition bleibt allgemeiner.'
),
(
    'definition',
    @definition_axiom_system_id,
    @source_87_id,
    'supporting_source',
    'Maturana und Varela dienen als Forschungsanschluss für prozessuale Identität und organisatorische Reproduktion. Die FRZK-Sammeldefinition ist keine Autopoiesisdefinition.'
);

/* -------------------------------------------------------------------------------------------------
   8. Gleichungen (3.295) bis (3.306)
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
    `plain_description`,`equation_type`,`provenance`,`source_id`,
    `derivation`,`assumptions`,`validation_status`,`created_revision_id`
)
VALUES
(
    '3.295',@section_id,'Vollständiges qualitatives FRZK-Axiomensystem',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5\\right\\}',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5\\right\\}',
    'Zusammenfassende Bezeichnung des vollständigen qualitativen FRZK-Axiomensystems.',
    'definition','original',NULL,
    'Zusammenführung der Axiome A1 bis A5.',
    'Noch kein vollständig formalisiertes mengentheoretisches oder modelltheoretisches System.',
    'checked',@revision_id
)
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
(
    '3.296',@section_id,'Relationale Bestimmbarkeit funktionaler Zuständlichkeit',
    'A_1\\land A_2\\Longrightarrow\\text{relationale Bestimmbarkeit funktionaler Zuständlichkeit}',
    'A_1\\land A_2\\Longrightarrow\\text{relationale Bestimmbarkeit funktionaler Zuständlichkeit}',
    'Qualitative Konsequenz aus Axiom A1 und Axiom A2.',
    'schema','original',NULL,
    'Unterscheidbare funktionale Zustände können innerhalb funktionaler Zusammenhänge bestimmt werden.',
    'Keine mathematische Relation wird eingeführt.',
    'checked',@revision_id
)
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
(
    '3.297',@section_id,'Bestimmbare funktionale Veränderung ohne vorausgesetzte Zeit',
    'A_1\\land A_2\\land A_3\\Longrightarrow\\text{bestimmbare funktionale Veränderung ohne vorausgesetzte Zeit}',
    'A_1\\land A_2\\land A_3\\Longrightarrow\\text{bestimmbare funktionale Veränderung ohne vorausgesetzte Zeit}',
    'Qualitative Konsequenz der Trennung von Veränderung und bereits vorausgesetzter Zeit.',
    'schema','original',NULL,
    'Axiom A3 erlaubt funktionale Veränderung, ohne eine Zeitachse oder einen Zeitparameter einzuführen.',
    'Noch keine Zeitrekonstruktion.',
    'checked',@revision_id
)
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
(
    '3.298',@section_id,'Mögliche funktionale Selbstorganisation',
    'A_1\\land A_2\\land A_3\\land A_4\\Longrightarrow\\text{mögliche funktionale Selbstorganisation}',
    'A_1\\land A_2\\land A_3\\land A_4\\Longrightarrow\\text{mögliche funktionale Selbstorganisation}',
    'Qualitative Konsequenz, dass Organisationsbildung nicht zwingend eine vollständige äußere Vorgabe benötigt.',
    'schema','original',NULL,
    'Axiom A4 eröffnet organisationsbildende Strukturbildung aus funktionalen Zusammenhängen und Transformationen.',
    'Nicht jede funktionale Organisation ist notwendig selbstorganisiert.',
    'checked',@revision_id
)
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
(
    '3.299',@section_id,'Mögliche prozessuale funktionale Identität',
    'A_4\\land A_5\\Longrightarrow\\text{mögliche prozessuale funktionale Identität}',
    'A_4\\land A_5\\Longrightarrow\\text{mögliche prozessuale funktionale Identität}',
    'Qualitative Konsequenz, dass funktionale Identität im Erhalt organisatorischer Zusammenhänge trotz innerer Veränderung liegen kann.',
    'schema','original',NULL,
    'Axiom A5 erlaubt Erhalt und Reproduktion funktionaler Organisation.',
    'Noch kein mathematisches Identitätskriterium.',
    'checked',@revision_id
)
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
(
    '3.300',@section_id,'Kohärenz als Erhalt unter Transformation',
    'A_3\\land A_5\\Longrightarrow\\text{Kohärenz als Erhalt unter Transformation}',
    'A_3\\land A_5\\Longrightarrow\\text{Kohärenz als Erhalt unter Transformation}',
    'Qualitative Konsequenz, dass Kohärenz nicht mit Starrheit gleichgesetzt wird.',
    'schema','original',NULL,
    'Axiom A3 erlaubt Transformation, Axiom A5 funktionalen Erhalt und Reproduktion.',
    'Kein mathematisches Kohärenzmaß.',
    'checked',@revision_id
)
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
(
    '3.301',@section_id,'Möglichkeit einer funktionalen Raumrekonstruktion',
    'A_1\\land A_2\\land A_4\\Longrightarrow\\text{Möglichkeit einer funktionalen Raumrekonstruktion}',
    'A_1\\land A_2\\land A_4\\Longrightarrow\\text{Möglichkeit einer funktionalen Raumrekonstruktion}',
    'Qualitative Voraussetzung für die spätere Rekonstruktion einer räumlich interpretierbaren Relations- und Organisationsstruktur.',
    'schema','original',NULL,
    'Unterscheidbarkeit, Relationierbarkeit und Organisationsbildung bilden eine qualitative Vorstruktur.',
    'Noch kein geometrischer, topologischer oder metrischer Raum.',
    'checked',@revision_id
)
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
(
    '3.302',@section_id,'Möglichkeit einer funktionalen Zeitrekonstruktion',
    'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\text{Möglichkeit einer funktionalen Zeitrekonstruktion}',
    'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\text{Möglichkeit einer funktionalen Zeitrekonstruktion}',
    'Qualitative Voraussetzung für die spätere Rekonstruktion einer geordneten und kohärenten Transformationsstruktur.',
    'schema','original',NULL,
    'Das vollständige Axiomensystem eröffnet die Möglichkeit geordneter, relationierter und kohärent rekonstruierbarer Transformation.',
    'Noch kein Zeitparameter und keine Zeitrichtung.',
    'checked',@revision_id
)
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
(
    '3.303',@section_id,'Notwendige Kohärenzbedingungen für Raum- und Zeitrekonstruktion',
    '\\text{Raumrekonstruktion}\\land\\text{Zeitrekonstruktion}\\Longrightarrow\\text{notwendige Kohärenzbedingungen}',
    '\\text{Raumrekonstruktion}\\land\\text{Zeitrekonstruktion}\\Longrightarrow\\text{notwendige Kohärenzbedingungen}',
    'Qualitative Theorieabsicht, Raum und Zeit als kohärent bestimmbare Organisationsformen zu rekonstruieren.',
    'schema','original',NULL,
    'Relationale und dynamische Organisationsformen müssen über Transformationen hinweg bestimmbar bleiben.',
    'Noch kein mathematischer Notwendigkeitsbeweis.',
    'checked',@revision_id
)
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
(
    '3.304',@section_id,'Mögliche Modellpluralität',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\Longrightarrow\\text{mögliche Modellpluralität}',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\Longrightarrow\\text{mögliche Modellpluralität}',
    'Qualitative Konsequenz, dass verschiedene mathematische Modelle dieselben qualitativen Axiome realisieren können.',
    'schema','original',NULL,
    'Die Axiome legen noch keine eindeutige mathematische Realisierung fest.',
    'Die Auswahl konkreter mathematischer Strukturen erfolgt erst in Kapitel 3.4.',
    'checked',@revision_id
)
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
(
    '3.305',@section_id,'Trennung axiomatischer Möglichkeit und empirischer Realisierung',
    '\\text{axiomatische Möglichkeit}\\neq\\text{empirische Realisierung}',
    '\\text{axiomatische Möglichkeit}\\neq\\text{empirische Realisierung}',
    'Grundlegende Trennung zwischen theoretischem Möglichkeitsraum und empirischer Beobachtung.',
    'principle','original',NULL,
    'Die Axiome formulieren Möglichkeiten und keine universellen empirischen Tatsachen.',
    'Empirische Realisierung muss gesondert operationalisiert und geprüft werden.',
    'checked',@revision_id
)
ON DUPLICATE KEY UPDATE
`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),
`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),
`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),
`provenance`=VALUES(`provenance`),`source_id`=VALUES(`source_id`),
`derivation`=VALUES(`derivation`),`assumptions`=VALUES(`assumptions`),
`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations`
(
    `equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
    `plain_description`,`equation_type`,`provenance`,`source_id`,
    `derivation`,`assumptions`,`validation_status`,`created_revision_id`
)
VALUES
(
    '3.306',
    @section_id,
    'Zusammenfassung der qualitativen Konsequenzen',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\Longrightarrow\\left\\{\\begin{array}{l}\\text{relationale Bestimmbarkeit},\\\\\\text{Veränderbarkeit ohne vorausgesetzte Zeit},\\\\\\text{Organisationsbildung},\\\\\\text{prozessuale funktionale Identität},\\\\\\text{dynamische Kohärenz},\\\\\\text{Möglichkeit funktionaler Raumrekonstruktion},\\\\\\text{Möglichkeit funktionaler Zeitrekonstruktion},\\\\\\text{Modellpluralität}\\end{array}\\right\\}',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\Longrightarrow\\left\\{\\begin{array}{l}\\text{relationale Bestimmbarkeit},\\\\\\text{Veränderbarkeit ohne vorausgesetzte Zeit},\\\\\\text{Organisationsbildung},\\\\\\text{prozessuale funktionale Identität},\\\\\\text{dynamische Kohärenz},\\\\\\text{Möglichkeit funktionaler Raumrekonstruktion},\\\\\\text{Möglichkeit funktionaler Zeitrekonstruktion},\\\\\\text{Modellpluralität}\\end{array}\\right\\}',
    'Qualitative Zusammenfassung der unmittelbaren Konsequenzen des vollständigen FRZK-Axiomensystems.',
    'schema',
    'original',
    NULL,
    'Zusammenführung der in Abschnitt 3.3.7 entwickelten Konsequenzen.',
    'Noch keine mathematisch bewiesene Satzsammlung.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),
`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),
`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),
`provenance`=VALUES(`provenance`),`source_id`=VALUES(`source_id`),
`derivation`=VALUES(`derivation`),`assumptions`=VALUES(`assumptions`),
`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   9. Gleichungs-IDs laden
   ------------------------------------------------------------------------------------------------- */

SET @eq_3295 := NULL;
SET @eq_3296 := NULL;
SET @eq_3297 := NULL;
SET @eq_3298 := NULL;
SET @eq_3299 := NULL;
SET @eq_3300 := NULL;
SET @eq_3301 := NULL;
SET @eq_3302 := NULL;
SET @eq_3303 := NULL;
SET @eq_3304 := NULL;
SET @eq_3305 := NULL;
SET @eq_3306 := NULL;

SELECT `equation_id` INTO @eq_3295 FROM `equations` WHERE `equation_number`='3.295' LIMIT 1;
SELECT `equation_id` INTO @eq_3296 FROM `equations` WHERE `equation_number`='3.296' LIMIT 1;
SELECT `equation_id` INTO @eq_3297 FROM `equations` WHERE `equation_number`='3.297' LIMIT 1;
SELECT `equation_id` INTO @eq_3298 FROM `equations` WHERE `equation_number`='3.298' LIMIT 1;
SELECT `equation_id` INTO @eq_3299 FROM `equations` WHERE `equation_number`='3.299' LIMIT 1;
SELECT `equation_id` INTO @eq_3300 FROM `equations` WHERE `equation_number`='3.300' LIMIT 1;
SELECT `equation_id` INTO @eq_3301 FROM `equations` WHERE `equation_number`='3.301' LIMIT 1;
SELECT `equation_id` INTO @eq_3302 FROM `equations` WHERE `equation_number`='3.302' LIMIT 1;
SELECT `equation_id` INTO @eq_3303 FROM `equations` WHERE `equation_number`='3.303' LIMIT 1;
SELECT `equation_id` INTO @eq_3304 FROM `equations` WHERE `equation_number`='3.304' LIMIT 1;
SELECT `equation_id` INTO @eq_3305 FROM `equations` WHERE `equation_number`='3.305' LIMIT 1;
SELECT `equation_id` INTO @eq_3306 FROM `equations` WHERE `equation_number`='3.306' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   10. Gleichungssymbole kontrolliert neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN
(
    @eq_3295,@eq_3296,@eq_3297,@eq_3298,@eq_3299,@eq_3300,
    @eq_3301,@eq_3302,@eq_3303,@eq_3304,@eq_3305,@eq_3306
);

INSERT INTO `equation_symbols`
(
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3295,'\\mathcal{A}_{\\mathrm{FRZK}}','vollständiges FRZK-Axiomensystem',
 'Zusammenfassende Bezeichnung der Axiome A1 bis A5.',NULL,'qualitative FRZK-Axiomatik',1),

(@eq_3296,'A_1','Axiom A1','Erstes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3296,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3296,'A_2','Axiom A2','Zweites FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3296,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',4),

(@eq_3297,'A_1','Axiom A1','Erstes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3297,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3297,'A_2','Axiom A2','Zweites FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3297,'A_3','Axiom A3','Drittes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3297,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',5),

(@eq_3298,'A_1','Axiom A1','Erstes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3298,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3298,'A_2','Axiom A2','Zweites FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3298,'A_3','Axiom A3','Drittes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3298,'A_4','Axiom A4','Viertes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3298,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',6),

(@eq_3299,'A_4','Axiom A4','Viertes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3299,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3299,'A_5','Axiom A5','Fünftes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3299,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',4),

(@eq_3300,'A_3','Axiom A3','Drittes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3300,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3300,'A_5','Axiom A5','Fünftes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3300,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',4),

(@eq_3301,'A_1','Axiom A1','Erstes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3301,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3301,'A_2','Axiom A2','Zweites FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3301,'A_4','Axiom A4','Viertes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3301,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',5),

(@eq_3302,'A_1','Axiom A1','Erstes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3302,'\\land','logische Konjunktion','Verknüpft mehrere axiomatische Voraussetzungen.',NULL,'qualitative Logik',2),
(@eq_3302,'A_2','Axiom A2','Zweites FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',3),
(@eq_3302,'A_3','Axiom A3','Drittes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',4),
(@eq_3302,'A_4','Axiom A4','Viertes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',5),
(@eq_3302,'A_5','Axiom A5','Fünftes FRZK-Axiom.',NULL,'qualitative FRZK-Axiomatik',6),
(@eq_3302,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',7),

(@eq_3303,'\\land','logische Konjunktion','Verknüpft Raum- und Zeitrekonstruktion.',NULL,'qualitative Logik',1),
(@eq_3303,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',2),

(@eq_3304,'\\mathcal{A}_{\\mathrm{FRZK}}','vollständiges FRZK-Axiomensystem',
 'Zusammenfassende Bezeichnung der Axiome A1 bis A5.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3304,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet eine qualitative Konsequenz.',NULL,'qualitative Folgerung',2),

(@eq_3305,'\\neq','Ungleichheitszeichen','Kennzeichnet die Nichtidentität von axiomatischer Möglichkeit und empirischer Realisierung.',NULL,'qualitative Wissenschaftstheorie',1),

(@eq_3306,'\\mathcal{A}_{\\mathrm{FRZK}}','vollständiges FRZK-Axiomensystem',
 'Zusammenfassende Bezeichnung der Axiome A1 bis A5.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3306,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet die qualitative Zusammenfassung der Konsequenzen.',NULL,'qualitative Folgerung',2)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   11. Abschnittssymbole
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `symbols`
(
    `symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,
    `scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,
    `domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,
    `notes`,`validation_status`,`created_revision_id`
)
VALUES
(
    '\\mathcal{A}_{\\mathrm{FRZK}}',
    '\\mathcal{A}_{\\mathrm{FRZK}}',
    'vollständiges qualitatives FRZK-Axiomensystem',
    'Zusammenfassende Bezeichnung der Axiome A1 bis A5.',
    'section',
    @section_id,
    @eq_3295,
    NULL,
    'qualitative FRZK-Axiomatik',
    'qualitative FRZK-Axiomatik',
    0,0,0,
    'Noch keine vollständig formalisierte mathematische Menge.',
    'checked',
    @revision_id
),
(
    '\\neq',
    '\\neq',
    'Ungleichheitszeichen',
    'Kennzeichnet die wissenschaftstheoretische Trennung zwischen axiomatischer Möglichkeit und empirischer Realisierung.',
    'section',
    @section_id,
    @eq_3305,
    NULL,
    'qualitative Wissenschaftstheorie',
    'qualitative Wissenschaftstheorie',
    0,0,0,
    'Kein numerischer Vergleich.',
    'checked',
    @revision_id
),
(
    '\\land',
    '\\land',
    'logische Konjunktion',
    'Logisches Und zur qualitativen Verknüpfung mehrerer Axiome oder Rekonstruktionsbedingungen.',
    'section',
    @section_id,
    @eq_3296,
    NULL,
    'qualitative Logik',
    'qualitative Logik',
    0,0,0,
    'Dient ausschließlich der komprimierten Darstellung.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `symbol_word_latex`=VALUES(`symbol_word_latex`),
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `first_equation_id`=VALUES(`first_equation_id`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `codomain_text`=VALUES(`codomain_text`),
    `is_vector`=VALUES(`is_vector`),
    `is_matrix`=VALUES(`is_matrix`),
    `is_operator`=VALUES(`is_operator`),
    `notes`=VALUES(`notes`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   12. Änderungsprotokoll
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id
  AND `section_id`=@section_id;

INSERT INTO `section_change_log`
(
    `revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,
    `change_summary`,`previous_value`,`new_value`
)
VALUES
(
    @revision_id,@section_id,'rewritten','section','3.3.7',
    'Abschnitt 3.3.7 wurde vollständig als systematische Darstellung der qualitativen Konsequenzen des Axiomensystems neu gefasst.',
    'Älterer Planungsstand.',
    'Qualitative Konsequenzen des vollständigen Axiomensystems.'
),
(
    @revision_id,@section_id,'source_reused','source_usage','[12], [13], [87]',
    'Haken, Prigogine/Stengers sowie Maturana/Varela wurden als wissenschaftliche Forschungsanschlüsse wiederverwendet.',
    NULL,
    'Drei geprüfte Wiederverwendungen.'
),
(
    @revision_id,@section_id,'definition_added','definitions','Def. 3.3.7.1',
    'Das vollständige qualitative FRZK-Axiomensystem wurde als Sammeldefinition registriert.',
    NULL,
    'Def. 3.3.7.1.'
),
(
    @revision_id,@section_id,'equation_added','equations','(3.295)–(3.306)',
    'Zwölf qualitative Darstellungen zu Axiomensystem, Konsequenzen, Raum- und Zeitrekonstruktion, Modellpluralität und empirischer Abgrenzung wurden registriert.',
    NULL,
    'Gleichungen (3.295) bis (3.306).'
),
(
    @revision_id,@section_id,'symbol_added','symbols','\\mathcal{A}_{\\mathrm{FRZK}}, \\neq, \\land',
    'Die neuen abschnittsspezifischen Symbole wurden registriert.',
    NULL,
    'Drei Abschnittssymbole.'
),
(
    @revision_id,@section_id,'status_changed','section','3.3.7',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   13. Repository-Zähler
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section','3.3.7'),
    ('last_repository_revision','RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1'),
    ('next_citation_number','88'),
    ('next_equation_number','3.307')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* =================================================================================================
   14. AUDIT UND KONTROLLABFRAGEN
   ================================================================================================= */

SELECT
    r.`revision_code`,
    p.`revision_code` AS `parent_revision_code`,
    r.`scope_reference`,
    r.`version_label`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p
    ON p.`revision_id`=r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci
      =
      'RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    p.`section_code` AS `parent_section_code`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` p
    ON p.`section_id`=ds.`parent_section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.7' COLLATE utf8mb4_unicode_ci;

SELECT
    s.`citation_number`,
    s.`short_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`claim_summary`
FROM `source_usage` su
JOIN `sources` s ON s.`source_id`=su.`source_id`
WHERE su.`section_id`=@section_id
ORDER BY s.`citation_number`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`provenance`,
    d.`validation_status`,
    d.`formal_latex`,
    d.`word_latex`
FROM `definitions` d
WHERE d.`section_id`=@section_id
ORDER BY d.`definition_number`;

SELECT
    osl.`object_type`,
    s.`citation_number`,
    osl.`usage_type`,
    osl.`note`
FROM `object_source_links` osl
JOIN `sources` s ON s.`source_id`=osl.`source_id`
WHERE osl.`object_type`='definition'
  AND osl.`object_id`=@definition_axiom_system_id
ORDER BY s.`citation_number`;

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_type`,
    e.`validation_status`,
    CASE
        WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`)=''
        THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND e.`equation_number` BETWEEN '3.295' AND '3.306'
ORDER BY e.`equation_number`;

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id
  AND e.`equation_number` BETWEEN '3.295' AND '3.306'
ORDER BY e.`equation_number`,es.`symbol_order`;

SELECT
    sy.`symbol_latex`,
    sy.`symbol_name`,
    sy.`scope_type`,
    sy.`validation_status`,
    e.`equation_number` AS `first_equation_number`
FROM `symbols` sy
LEFT JOIN `equations` e ON e.`equation_id`=sy.`first_equation_id`
WHERE sy.`first_section_id`=@section_id
ORDER BY sy.`symbol_latex`;

SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
(
    'last_edited_section',
    'last_repository_revision',
    'next_citation_number',
    'next_equation_number'
)
ORDER BY `counter_key`;

SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*)>1;

SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`,`symbol_latex`
HAVING COUNT(*)>1;

SELECT
    `equation_number`,
    `title`
FROM `equations`
WHERE `section_id`=@section_id
  AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');

SELECT
    'source_usage' AS `table_name`,
    CAST(`usage_id` AS CHAR) AS `row_id`,
    `usage_type` AS `enum_value`
FROM `source_usage`
WHERE `section_id`=@section_id
  AND (`usage_type` IS NULL OR TRIM(`usage_type`)='')

UNION ALL

SELECT
    'section_change_log',
    CAST(`change_id` AS CHAR),
    `change_type`
FROM `section_change_log`
WHERE `section_id`=@section_id
  AND (`change_type` IS NULL OR TRIM(`change_type`)='')

UNION ALL

SELECT
    'object_source_links',
    CAST(`object_source_link_id` AS CHAR),
    `usage_type`
FROM `object_source_links`
WHERE `object_type`='definition'
  AND `object_id`=@definition_axiom_system_id
  AND (`usage_type` IS NULL OR TRIM(`usage_type`)='');

SELECT
    'definition' AS `object_type`,
    d.`definition_id` AS `object_id`,
    d.`definition_number` AS `object_reference`
FROM `definitions` d
LEFT JOIN `dissertation_sections` ds ON ds.`section_id`=d.`section_id`
WHERE d.`created_revision_id`=@revision_id
  AND ds.`section_id` IS NULL

UNION ALL

SELECT
    'equation',
    e.`equation_id`,
    e.`equation_number`
FROM `equations` e
LEFT JOIN `dissertation_sections` ds ON ds.`section_id`=e.`section_id`
WHERE e.`created_revision_id`=@revision_id
  AND ds.`section_id` IS NULL;

SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id`=@revision_id
  AND scl.`section_id`=@section_id
ORDER BY scl.`change_id`;

SELECT
    'Repository-Update 3.3.7 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [88], Gleichung (3.307), letzte Revision RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1.'
AS `result`;
