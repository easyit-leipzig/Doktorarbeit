/* =================================================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.3.0 – KORRIGIERT V2

   Abschnitt:
     3.3.0 Einleitung

   Verbindlicher Ausgangsstand:
     letzte Literaturquelle: [81]
     nächste Literaturquelle vor diesem Skript: [82]
     letzte Gleichung: (3.274)
     nächste Gleichung vor diesem Skript: (3.275)
     Parent-Revision: RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5

   Dieses Skript registriert:
     - Abschnitt 3.3 und Unterabschnitt 3.3.0
     - neue Repository-Revision für 3.3.0
     - neue Quelle [82]: Alfred Tarski
     - Wiederverwendung der Quellen [7], [8] und [24]
     - Gleichung (3.275)
     - Gleichungssymbol \Longrightarrow
     - Abschnittsänderungen und Repository-Zähler
     - Audit- und Kontrollabfragen

   SQL-Dialekt:
     MariaDB / MySQL

   Eigenschaften:
     - transaktional
     - idempotent
     - ohne Platzhalter
     - interne IDs werden nicht mit Literaturziffern gleichgesetzt
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Verbindliche Parent-Revision vorab laden
   Verhindert MySQL-Fehler #1093 durch gleichzeitigen INSERT und SELECT auf repository_revisions.
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* Harte Vorbedingung: Parent-Revision muss vorhanden sein.
   Die temporäre NOT-NULL-Tabelle erzeugt bei fehlender Parent-ID einen klaren Importfehler,
   benötigt aber weder DELIMITER noch eine gespeicherte Prozedur. */
DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_330`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_330`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_330` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_330`;

/* -------------------------------------------------------------------------------------------------
   2. Repository-Revision idempotent anlegen
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2' USING utf8mb4)
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
    '3.3.0',
    'V2',
    'Neufassung von Abschnitt 3.3.0 als Einleitung zur qualitativen Axiomatik des Funktionalen Raum-Zeit-Kohärenzsystems; neue Quelle [82], Wiederverwendung von [7], [8] und [24] sowie Registrierung der konzeptionellen Gleichung (3.275).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_date`       = VALUES(`revision_date`),
    `scope_type`          = VALUES(`scope_type`),
    `scope_reference`     = VALUES(`scope_reference`),
    `version_label`       = VALUES(`version_label`),
    `summary`             = VALUES(`summary`),
    `created_by`          = VALUES(`created_by`),
    `parent_revision_id`  = VALUES(`parent_revision_id`);

SET @revision_id := NULL;

SELECT `revision_id`
INTO @revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* Parent-Prüfung als Auditdatensatz dieser Revision protokollieren. */
DELETE FROM `repository_validation_results`
WHERE `revision_id` = @revision_id
  AND `validation_code` = 'K3.3.0_PARENT_REVISION';

INSERT INTO `repository_validation_results`
(
    `revision_id`,
    `validation_code`,
    `validation_status`,
    `expected_value`,
    `actual_value`,
    `validation_message`
)
VALUES
(
    @revision_id,
    'K3.3.0_PARENT_REVISION',
    'passed',
    @parent_revision_code,
    (SELECT `revision_code` FROM `repository_revisions` WHERE `revision_id` = @parent_revision_id),
    'Die verbindliche Parent-Revision für Abschnitt 3.3.0 ist vorhanden.'
);

/* -------------------------------------------------------------------------------------------------
   3. Kapitel- und Abschnittsstruktur aufbauen
   ------------------------------------------------------------------------------------------------- */

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
    NULL,
    '3.3',
    'Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    3.3000,
    'review',
    1,
    'Kapitel 3.3 formuliert die qualitative FRZK-Axiomatik. Die mathematische Rekonstruktion bleibt Kapitel 3.4 vorbehalten.'
)
ON DUPLICATE KEY UPDATE
    `title`                    = VALUES(`title`),
    `chapter_no`               = VALUES(`chapter_no`),
    `section_order`            = VALUES(`section_order`),
    `status`                   = VALUES(`status`),
    `is_original_contribution` = VALUES(`is_original_contribution`),
    `notes`                    = VALUES(`notes`);

SET @section_33_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` COLLATE utf8mb4_unicode_ci = '3.3' COLLATE utf8mb4_unicode_ci
    LIMIT 1
);

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
    '3.3.0',
    'Einleitung',
    3,
    3.3001,
    'review',
    1,
    'Übergang von der mathematischen Forschungslücke in Kapitel 3.2 zur qualitativen axiomatischen Grundlegung. Enthält noch keine mathematische Rekonstruktion.'
)
ON DUPLICATE KEY UPDATE
    `parent_section_id`         = VALUES(`parent_section_id`),
    `title`                     = VALUES(`title`),
    `chapter_no`                = VALUES(`chapter_no`),
    `section_order`             = VALUES(`section_order`),
    `status`                    = VALUES(`status`),
    `is_original_contribution`  = VALUES(`is_original_contribution`),
    `notes`                     = VALUES(`notes`);

SET @section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` COLLATE utf8mb4_unicode_ci = '3.3.0' COLLATE utf8mb4_unicode_ci
    LIMIT 1
);

/* -------------------------------------------------------------------------------------------------
   4. Neue Autorin / neuer Autor für Quelle [82]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `birth_year`,
    `death_year`,
    `notes`
)
VALUES
(
    'Tarski',
    'Alfred',
    'tarski_alfred',
    1901,
    1983,
    'Polnisch-amerikanischer Logiker und Mathematiker; zentrale Arbeiten zur formalen Semantik, Logik und Methodologie deduktiver Wissenschaften.'
)
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year`  = VALUES(`birth_year`),
    `death_year`  = VALUES(`death_year`),
    `notes`       = VALUES(`notes`);

SET @author_tarski_id := (
    SELECT `author_id`
    FROM `authors`
    WHERE `normalized_name` COLLATE utf8mb4_unicode_ci = 'tarski_alfred' COLLATE utf8mb4_unicode_ci
    LIMIT 1
);

/* -------------------------------------------------------------------------------------------------
   5. Neue Quelle [82] idempotent registrieren
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `sources`
(
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `year_original`,
    `year_edition`,
    `publisher`,
    `place`,
    `edition`,
    `language_code`,
    `priority`,
    `evidence_type`,
    `frzk_relevance`,
    `verification_status`,
    `first_citation_section_code`,
    `first_citation_note`,
    `full_citation_text`,
    `short_citation_text`,
    `notes`,
    `created_revision_id`
)
VALUES
(
    82,
    'tarski_1941_introduction_logic_methodology',
    'book',
    'Introduction to Logic and to the Methodology of Deductive Sciences',
    1936,
    1941,
    'Oxford University Press',
    'Oxford',
    'English edition',
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.3.0',
    'Erstnennung zur methodischen Begründung deduktiver und axiomatischer Theoriebildung.',
    'Tarski, Alfred: Introduction to Logic and to the Methodology of Deductive Sciences. Oxford: Oxford University Press, 1941.',
    'Tarski 1941',
    'Verwendet zur Einordnung der strikten Trennung zwischen Grundannahmen, formaler Sprache und ableitbaren Aussagen.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`              = VALUES(`citation_number`),
    `source_type`                  = VALUES(`source_type`),
    `title`                        = VALUES(`title`),
    `year_original`                = VALUES(`year_original`),
    `year_edition`                 = VALUES(`year_edition`),
    `publisher`                    = VALUES(`publisher`),
    `place`                        = VALUES(`place`),
    `edition`                      = VALUES(`edition`),
    `language_code`                = VALUES(`language_code`),
    `priority`                     = VALUES(`priority`),
    `evidence_type`                = VALUES(`evidence_type`),
    `frzk_relevance`               = VALUES(`frzk_relevance`),
    `verification_status`          = VALUES(`verification_status`),
    `first_citation_section_code`  = VALUES(`first_citation_section_code`),
    `first_citation_note`          = VALUES(`first_citation_note`),
    `full_citation_text`           = VALUES(`full_citation_text`),
    `short_citation_text`          = VALUES(`short_citation_text`),
    `notes`                        = VALUES(`notes`),
    `created_revision_id`          = VALUES(`created_revision_id`);

SET @source_82_id := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` COLLATE utf8mb4_unicode_ci = 'tarski_1941_introduction_logic_methodology' COLLATE utf8mb4_unicode_ci
    LIMIT 1
);

INSERT INTO `source_authors`
(
    `source_id`,
    `author_id`,
    `author_order`,
    `role`
)
VALUES
(
    @source_82_id,
    @author_tarski_id,
    1,
    'author'
)
ON DUPLICATE KEY UPDATE
    `author_order` = VALUES(`author_order`),
    `role`         = VALUES(`role`);

/* -------------------------------------------------------------------------------------------------
   6. Quellenannotation [82]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `annotations`
(
    `source_id`,
    `contribution`,
    `significance_for_dissertation`,
    `citation_reason`,
    `adopted_claims`,
    `limitations`,
    `scientific_discussion`,
    `annotation_status`,
    `reviewed_at`
)
VALUES
(
    @source_82_id,
    'Systematische Darstellung der formalen Logik und der Methodologie deduktiver Wissenschaften sowie der Trennung zwischen primitiven Grundannahmen und abgeleiteten Aussagen.',
    'Begründet den methodischen Übergang von Kapitel 3.2 zur qualitativen Axiomatik des FRZK in Kapitel 3.3.',
    'Die Quelle stützt die Forderung, Axiome, primitive Begriffe und ableitbare Aussagen einer Theorie klar voneinander zu unterscheiden.',
    'Übernommen wird das methodische Prinzip einer expliziten deduktiven Grundlegung; nicht übernommen wird ein konkretes formales Axiomensystem.',
    'Tarskis Werk entwickelt keine Theorie emergenter funktionaler Raum-, Zeit- oder Kohärenzstrukturen.',
    'Die Quelle wird mit Euklid [7], Hilbert [8] und Zermelo [24] verglichen. Das FRZK übernimmt die axiomatische Methode, verlagert den Ausgangspunkt jedoch vor bereits etablierte mathematische Objekte.',
    'reviewed',
    NOW()
)
ON DUPLICATE KEY UPDATE
    `contribution`                    = VALUES(`contribution`),
    `significance_for_dissertation`  = VALUES(`significance_for_dissertation`),
    `citation_reason`                 = VALUES(`citation_reason`),
    `adopted_claims`                  = VALUES(`adopted_claims`),
    `limitations`                    = VALUES(`limitations`),
    `scientific_discussion`          = VALUES(`scientific_discussion`),
    `annotation_status`              = VALUES(`annotation_status`),
    `reviewed_at`                    = VALUES(`reviewed_at`);

/* -------------------------------------------------------------------------------------------------
   7. Bestehende Quellen [7], [8] und [24] auflösen
   Literaturziffer und source_id werden ausdrücklich nicht gleichgesetzt.
   ------------------------------------------------------------------------------------------------- */

SET @source_7_id := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 7
    LIMIT 1
);

SET @source_8_id := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 8
    LIMIT 1
);

SET @source_24_id := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 24
    LIMIT 1
);

/* -------------------------------------------------------------------------------------------------
   8. Quellenverwendungen des Abschnitts vollständig und idempotent neu aufbauen
   Da source_usage keinen natürlichen UNIQUE-Schlüssel besitzt, werden nur die Verwendungen
   dieses Abschnitts kontrolliert ersetzt.
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
    @source_8_id,
    @section_id,
    'background',
    'Hilberts axiomatische Methode belegt, dass mathematische Theorien auf explizit gewählten primitiven Begriffen und Grundannahmen aufbauen.',
    '3.3.0, Absätze 2 und 4',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [8].',
    @revision_id
),
(
    @source_24_id,
    @section_id,
    'comparison',
    'Die axiomatische Mengenlehre dient als Vergleich dafür, dass leistungsfähige formale Theorien ihre Ausgangsobjekte voraussetzen und anschließend deren Konsequenzen entwickeln.',
    '3.3.0, Absatz 2',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [24].',
    @revision_id
),
(
    @source_7_id,
    @section_id,
    'historical_context',
    'Euklids Elemente werden als historischer Ausgangspunkt der axiomatischen Theoriebildung und der Trennung zwischen Postulaten und abgeleiteten Aussagen herangezogen.',
    '3.3.0, Absatz 4',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [7].',
    @revision_id
),
(
    @source_82_id,
    @section_id,
    'first_citation',
    'Tarski wird zur methodischen Begründung deduktiver Theorien und der strikten Trennung zwischen Grundannahmen und ableitbaren Aussagen erstmals eingeführt.',
    '3.3.0, Absatz 4',
    1,
    1,
    'Erstnennung der neuen Quelle [82].',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   9. Gleichung (3.275) registrieren
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
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
    '3.275',
    @section_id,
    'Konzeptionelle Entwicklungsrichtung der FRZK-Axiomatik',
    '\\text{Unterscheidbarkeit}\\;\\Longrightarrow\\;\\text{Relationierbarkeit}\\;\\Longrightarrow\\;\\text{Transformation}\\;\\Longrightarrow\\;\\text{Organisation}\\;\\Longrightarrow\\;\\text{Kohärenz}',
    '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierbarkeit}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Kohärenz}',
    'Qualitative Reihenfolge der Organisationsprinzipien, die in Kapitel 3.3 axiomatisch formuliert und in Kapitel 3.4 mathematisch rekonstruiert werden. Die Darstellung ist keine mathematische Herleitung und keine zeitliche Entwicklungsgleichung.',
    'schema',
    'original',
    NULL,
    'Die Reihenfolge folgt aus der in Kapitel 3.2 identifizierten Forschungslücke: Zunächst muss Unterscheidbarkeit möglich sein; darauf können Relationierung, Transformation, Organisation und Kohärenz aufbauen.',
    'Die Begriffe besitzen in Abschnitt 3.3.0 ausschließlich qualitative Bedeutung. Es werden weder Mengen, Funktionen, Operatoren noch Zeitparameter vorausgesetzt.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `equation_latex`      = VALUES(`equation_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `plain_description`   = VALUES(`plain_description`),
    `equation_type`       = VALUES(`equation_type`),
    `provenance`          = VALUES(`provenance`),
    `source_id`           = VALUES(`source_id`),
    `derivation`          = VALUES(`derivation`),
    `assumptions`         = VALUES(`assumptions`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

SET @equation_3275_id := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` COLLATE utf8mb4_unicode_ci = '3.275' COLLATE utf8mb4_unicode_ci
    LIMIT 1
);

/* -------------------------------------------------------------------------------------------------
   10. equation_symbols kontrolliert neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` = @equation_3275_id;

INSERT INTO `equation_symbols`
(
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
    @equation_3275_id,
    '\\Longrightarrow',
    'konzeptioneller Folgerungspfeil',
    'Kennzeichnet in Gleichung (3.275) ausschließlich die qualitative Reihenfolge der Organisationsprinzipien; keine Funktion, kein Operator und keine zeitliche Entwicklung.',
    NULL,
    'qualitative axiomatische Abhängigkeit',
    1
)
ON DUPLICATE KEY UPDATE
    `symbol_name`     = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text`       = VALUES(`unit_text`),
    `domain_text`     = VALUES(`domain_text`),
    `symbol_order`    = VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   11. Symbolregister
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `symbols`
(
    `symbol_latex`,
    `symbol_word_latex`,
    `symbol_name`,
    `definition_text`,
    `scope_type`,
    `first_section_id`,
    `first_equation_id`,
    `unit_text`,
    `domain_text`,
    `codomain_text`,
    `is_vector`,
    `is_matrix`,
    `is_operator`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '\\Longrightarrow',
    '\\Longrightarrow',
    'konzeptioneller Folgerungspfeil',
    'Qualitativer Folgerungs- und Abhängigkeitspfeil in der FRZK-Axiomatik. Er besitzt in Kapitel 3.3 noch keine operatorische oder zeitliche Bedeutung.',
    'section',
    @section_id,
    @equation_3275_id,
    NULL,
    'qualitative axiomatische Aussagen',
    'qualitative axiomatische Aussagen',
    0,
    0,
    0,
    'Erstverwendung in Gleichung (3.275); mathematische Präzisierung erst in Kapitel 3.4.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `symbol_word_latex`   = VALUES(`symbol_word_latex`),
    `symbol_name`         = VALUES(`symbol_name`),
    `definition_text`     = VALUES(`definition_text`),
    `first_equation_id`   = VALUES(`first_equation_id`),
    `unit_text`           = VALUES(`unit_text`),
    `domain_text`         = VALUES(`domain_text`),
    `codomain_text`       = VALUES(`codomain_text`),
    `is_vector`           = VALUES(`is_vector`),
    `is_matrix`           = VALUES(`is_matrix`),
    `is_operator`         = VALUES(`is_operator`),
    `notes`               = VALUES(`notes`),
    `validation_status`   = VALUES(`validation_status`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   12. Abschnittsänderungsprotokoll idempotent neu aufbauen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log`
(
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
    '3.3.0',
    'Abschnitt 3.3.0 wurde vollständig als Einleitung zur qualitativen FRZK-Axiomatik neu gefasst.',
    'Frühere oder abweichende Fassungen von Kapitel 3.3.',
    'Klare Trennung zwischen mathematischem Forschungsstand in 3.2, qualitativer Axiomatik in 3.3 und mathematischer Rekonstruktion in 3.4.'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'sources',
    '[82]',
    'Alfred Tarskis Werk zur Logik und Methodologie deduktiver Wissenschaften wurde als neue Quelle [82] registriert.',
    NULL,
    'Quelle [82] einschließlich Autor, Annotation und erster Quellenverwendung.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source_usage',
    '[7], [8], [24]',
    'Die bestehenden Quellen Euklid [7], Hilbert [8] und Zermelo [24] wurden für die historische und methodische Einordnung der Axiomatik wiederverwendet.',
    NULL,
    'Drei geprüfte Wiederverwendungen in source_usage.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equations',
    '(3.275)',
    'Die konzeptionelle Entwicklungsrichtung der FRZK-Axiomatik wurde als Gleichung (3.275) mit vollständigem Word-LaTeX registriert.',
    NULL,
    'Unterscheidbarkeit → Relationierbarkeit → Transformation → Organisation → Kohärenz.'
),
(
    @revision_id,
    @section_id,
    'symbol_added',
    'symbols',
    '\\Longrightarrow',
    'Der qualitative Folgerungspfeil wurde für Abschnitt 3.3.0 im Symbolregister registriert.',
    NULL,
    'Abschnittssymbol mit Bezug zu Gleichung (3.275).'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.3.0',
    'Der Abschnitt wurde nach der Neufassung auf den Status review gesetzt.',
    'planned/draft oder früherer Status',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   13. Repository-Zähler aktualisieren
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section',      '3.3.0'),
    ('last_repository_revision','RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2'),
    ('next_citation_number',     '83'),
    ('next_equation_number',     '3.276')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* -------------------------------------------------------------------------------------------------
   14. Transaktion abschließen
   ------------------------------------------------------------------------------------------------- */

COMMIT;

/* =================================================================================================
   15. AUDIT UND KONTROLLABFRAGEN
   Erwartete Kernergebnisse:
     - Revision vorhanden: 1
     - Parent-Revision korrekt
     - Abschnitt 3.3.0 vorhanden, status = review
     - Quelle [82] vorhanden
     - Quellenverwendungen 3.3.0 = 4
     - Erstnennungen 3.3.0 = 1
     - Gleichung (3.275) vorhanden
     - Word-LaTeX nicht leer
     - equation_symbols (3.275) = 1
     - Counter: Quelle 83, Gleichung 3.276
   ================================================================================================= */

SELECT
    r.`revision_id`,
    r.`revision_code`,
    r.`scope_type`,
    r.`scope_reference`,
    r.`version_label`,
    p.`revision_code` AS `parent_revision_code`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p
    ON p.`revision_id` = r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci = 'RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2' COLLATE utf8mb4_unicode_ci;

SELECT
    ds.`section_id`,
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`,
    parent_ds.`section_code` AS `parent_section_code`
FROM `dissertation_sections` ds
LEFT JOIN `dissertation_sections` parent_ds
    ON parent_ds.`section_id` = ds.`parent_section_id`
WHERE ds.`section_code` IN ('3.3', '3.3.0')
ORDER BY ds.`section_order`;

SELECT
    s.`source_id`,
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`verification_status`,
    s.`first_citation_section_code`,
    a.`normalized_name`,
    sa.`author_order`,
    sa.`role`
FROM `sources` s
LEFT JOIN `source_authors` sa
    ON sa.`source_id` = s.`source_id`
LEFT JOIN `authors` a
    ON a.`author_id` = sa.`author_id`
WHERE s.`citation_number` = 82;

SELECT
    ds.`section_code`,
    COUNT(*) AS `source_usage_count`,
    SUM(su.`is_first_mention`) AS `first_mentions`,
    MIN(s.`citation_number`) AS `lowest_citation`,
    MAX(s.`citation_number`) AS `highest_citation`
FROM `source_usage` su
JOIN `sources` s
    ON s.`source_id` = su.`source_id`
JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE ds.`section_code` = '3.3.0'
GROUP BY ds.`section_code`;

SELECT
    s.`citation_number`,
    s.`short_citation_text`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`exact_location`,
    su.`claim_summary`
FROM `source_usage` su
JOIN `sources` s
    ON s.`source_id` = su.`source_id`
JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE ds.`section_code` = '3.3.0'
ORDER BY s.`citation_number`;

SELECT
    e.`equation_id`,
    e.`equation_number`,
    ds.`section_code`,
    e.`title`,
    e.`equation_type`,
    e.`provenance`,
    e.`validation_status`,
    e.`equation_latex`,
    e.`word_latex`,
    CASE
        WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`) = '' THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `equations` e
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE e.`equation_number` = '3.275';

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` = '3.275'
ORDER BY es.`symbol_order`;

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

/* Globale Dublettenprüfung der Gleichungsnummern */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*) > 1;

/* Dublettenprüfung equation_symbols */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`, `symbol_latex`
HAVING COUNT(*) > 1;

/* Prüfung auf fehlendes Word-LaTeX im neuen Abschnitt */
SELECT
    e.`equation_number`,
    e.`title`
FROM `equations` e
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE ds.`section_code` = '3.3.0'
  AND (e.`word_latex` IS NULL OR TRIM(e.`word_latex`) = '');

/* Prüfung auf verwaiste Quellenverwendungen im neuen Abschnitt */
SELECT
    su.`usage_id`
FROM `source_usage` su
LEFT JOIN `sources` s
    ON s.`source_id` = su.`source_id`
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE (s.`source_id` IS NULL OR ds.`section_id` IS NULL)
  AND su.`created_revision_id` = (
      SELECT `revision_id`
      FROM `repository_revisions`
      WHERE `revision_code` COLLATE utf8mb4_unicode_ci = 'RKB-2026-07-16-K3.3.0-NEUFASSUNG-V2' COLLATE utf8mb4_unicode_ci
      LIMIT 1
  );

/* Abschlussmeldung */
SELECT
    'Repository-Update 3.3.0 vollständig ausgeführt. Erwarteter nächster Stand: Quelle [83], Gleichung (3.276).' AS `result`;
