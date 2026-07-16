/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.8

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql / aktueller Repository-Stand der Kapitelrevisionen 3.3.1–3.3.7

   Abschnitt:
     3.3.8 Minimalität, Unabhängigkeit und Konsistenz des Axiomensystems

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1
     letzte Literaturquelle:      [87]
     neue Literaturquellen:       [88], [89]
     letzte Gleichung:            (3.306)
     neue Gleichungen:            (3.307)–(3.326)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquellen:
       [88] Herbert B. Enderton
       [89] Elliott Mendelson
     wiederverwendete Quellen:
       [82] Alfred Tarski
       [83] Patrick Suppes
     nächste freie Literatur-Nr.: [90]
     neue Gleichungen:            (3.307)–(3.326)
     nächste freie Gleichung:     (3.327)
     neue Revision:               RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1

   Registrierte Repository-Objekte:
     - repository_revisions
     - dissertation_sections
     - authors
     - sources
     - source_authors
     - annotations
     - source_usage
     - definitions
     - propositions
     - object_source_links
     - equations
     - equation_symbols
     - symbols
     - section_change_log
     - repository_counters
     - vollständige Audit- und Kontrollabfragen

   Schemaentscheidungen:
     - Es werden keine assumptions konstruiert.
     - Es werden keine neuen Axiome angelegt.
     - propositions.status verwendet ausschließlich 'review'.
     - source_usage.usage_type verwendet ausschließlich gültige Werte.
     - object_source_links.usage_type verwendet ausschließlich 'supporting_source'.
     - section_change_log.change_type verwendet ausschließlich gültige Werte.
     - Das Skript ist transaktional, idempotent und phpMyAdmin-kompatibel.
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Parent-Revision laden und zwingend prüfen
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.7-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_338`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_338`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_338` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_338`;

/* -------------------------------------------------------------------------------------------------
   2. Neue Abschnittsrevision
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1' USING utf8mb4)
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
    '3.3.8',
    'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.8: Minimalität, Unabhängigkeit und Konsistenz des Axiomensystems. Registriert werden qualitative Gegenmodelle, schwache und starke Unabhängigkeit, qualitative Erfüllbarkeit, die Ergebnisse der Minimalitäts-, Unabhängigkeits- und Konsistenzprüfung, die Quellen [88] und [89], Wiederverwendungen von [82] und [83], die Gleichungen (3.307) bis (3.326), Propositionen, Symbole, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
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
   3. Abschnitt 3.3.8 registrieren
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_338`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_338`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_338` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_338`;

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
    '3.3.8',
    'Minimalität, Unabhängigkeit und Konsistenz des Axiomensystems',
    3,
    3.3009,
    'review',
    1,
    'Qualitative Vorprüfung des vollständigen FRZK-Axiomensystems. Es werden begriffliche Gegenmodelle und ein qualitatives Erfüllbarkeitsmodell verwendet. Eine starke formale Unabhängigkeit und ein formaler Konsistenzbeweis werden ausdrücklich noch nicht behauptet.'
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
      '3.3.8' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   4. Autoren der neuen Quellen [88] und [89]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `authors`
(
    `family_name`, `given_names`, `normalized_name`, `orcid`,
    `birth_year`, `death_year`, `notes`
)
VALUES
(
    'Enderton',
    'Herbert B.',
    'Enderton, Herbert B.',
    NULL,
    1936,
    2010,
    'US-amerikanischer Logiker. In Abschnitt 3.3.8 als methodische Referenz für Modell, Erfüllbarkeit, semantische Folgerung und Konsistenz verwendet.'
)
ON DUPLICATE KEY UPDATE
    `family_name`=VALUES(`family_name`),
    `given_names`=VALUES(`given_names`),
    `orcid`=VALUES(`orcid`),
    `birth_year`=VALUES(`birth_year`),
    `death_year`=VALUES(`death_year`),
    `notes`=VALUES(`notes`);

INSERT INTO `authors`
(
    `family_name`, `given_names`, `normalized_name`, `orcid`,
    `birth_year`, `death_year`, `notes`
)
VALUES
(
    'Mendelson',
    'Elliott',
    'Mendelson, Elliott',
    NULL,
    1924,
    2020,
    'US-amerikanischer Logiker. In Abschnitt 3.3.8 als methodische Referenz für syntaktische Konsistenz, semantische Erfüllbarkeit und Axiomenunabhängigkeit verwendet.'
)
ON DUPLICATE KEY UPDATE
    `family_name`=VALUES(`family_name`),
    `given_names`=VALUES(`given_names`),
    `orcid`=VALUES(`orcid`),
    `birth_year`=VALUES(`birth_year`),
    `death_year`=VALUES(`death_year`),
    `notes`=VALUES(`notes`);

SET @author_88_id := NULL;
SET @author_89_id := NULL;

SELECT `author_id`
INTO @author_88_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Enderton, Herbert B.' COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `author_id`
INTO @author_89_id
FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci
      =
      'Mendelson, Elliott' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   5. Neue Quellen [88] und [89]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `sources`
(
    `citation_number`,`source_key`,`source_type`,`title`,`subtitle`,
    `year_original`,`year_edition`,`journal`,`publisher`,`place`,
    `volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,
    `language_code`,`priority`,`evidence_type`,`frzk_relevance`,
    `verification_status`,`first_citation_section_code`,`first_citation_note`,
    `full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`
)
VALUES
(
    88,
    'enderton_mathematical_introduction_logic_2001',
    'book',
    'A Mathematical Introduction to Logic',
    NULL,
    1972,
    2001,
    NULL,
    'Academic Press',
    'San Diego',
    NULL,NULL,NULL,
    '2nd Edition',
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'reference',
    9,
    'verified',
    '3.3.8',
    'Erstnennung zur modelltheoretischen Untersuchung von Erfüllbarkeit, semantischer Folgerung, Konsistenz und Unabhängigkeit.',
    'Enderton, Herbert B.: A Mathematical Introduction to Logic. 2nd Edition. San Diego: Academic Press, 2001.',
    'Enderton [88]',
    'Methodische Referenz. Die qualitativen Gegenmodelle des FRZK sind noch keine vollständigen Modelle im formal-logischen Sinn.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`=VALUES(`citation_number`),
    `source_type`=VALUES(`source_type`),
    `title`=VALUES(`title`),
    `subtitle`=VALUES(`subtitle`),
    `year_original`=VALUES(`year_original`),
    `year_edition`=VALUES(`year_edition`),
    `publisher`=VALUES(`publisher`),
    `place`=VALUES(`place`),
    `edition`=VALUES(`edition`),
    `language_code`=VALUES(`language_code`),
    `priority`=VALUES(`priority`),
    `evidence_type`=VALUES(`evidence_type`),
    `frzk_relevance`=VALUES(`frzk_relevance`),
    `verification_status`=VALUES(`verification_status`),
    `first_citation_section_code`=VALUES(`first_citation_section_code`),
    `first_citation_note`=VALUES(`first_citation_note`),
    `full_citation_text`=VALUES(`full_citation_text`),
    `short_citation_text`=VALUES(`short_citation_text`),
    `notes`=VALUES(`notes`),
    `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `sources`
(
    `citation_number`,`source_key`,`source_type`,`title`,`subtitle`,
    `year_original`,`year_edition`,`journal`,`publisher`,`place`,
    `volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,
    `language_code`,`priority`,`evidence_type`,`frzk_relevance`,
    `verification_status`,`first_citation_section_code`,`first_citation_note`,
    `full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`
)
VALUES
(
    89,
    'mendelson_introduction_mathematical_logic_2015',
    'book',
    'Introduction to Mathematical Logic',
    NULL,
    1964,
    2015,
    NULL,
    'CRC Press',
    'Boca Raton',
    NULL,NULL,NULL,
    '6th Edition',
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'reference',
    9,
    'verified',
    '3.3.8',
    'Erstnennung zur Beziehung zwischen syntaktischer Konsistenz, semantischer Erfüllbarkeit und Unabhängigkeit axiomatischer Systeme.',
    'Mendelson, Elliott: Introduction to Mathematical Logic. 6th Edition. Boca Raton: CRC Press, 2015.',
    'Mendelson [89]',
    'Methodische Referenz. Der Abschnitt beansprucht nur qualitative Vorprüfungen.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `citation_number`=VALUES(`citation_number`),
    `source_type`=VALUES(`source_type`),
    `title`=VALUES(`title`),
    `subtitle`=VALUES(`subtitle`),
    `year_original`=VALUES(`year_original`),
    `year_edition`=VALUES(`year_edition`),
    `publisher`=VALUES(`publisher`),
    `place`=VALUES(`place`),
    `edition`=VALUES(`edition`),
    `language_code`=VALUES(`language_code`),
    `priority`=VALUES(`priority`),
    `evidence_type`=VALUES(`evidence_type`),
    `frzk_relevance`=VALUES(`frzk_relevance`),
    `verification_status`=VALUES(`verification_status`),
    `first_citation_section_code`=VALUES(`first_citation_section_code`),
    `first_citation_note`=VALUES(`first_citation_note`),
    `full_citation_text`=VALUES(`full_citation_text`),
    `short_citation_text`=VALUES(`short_citation_text`),
    `notes`=VALUES(`notes`),
    `created_revision_id`=VALUES(`created_revision_id`);

SET @source_82_id := NULL;
SET @source_83_id := NULL;
SET @source_88_id := NULL;
SET @source_89_id := NULL;

SELECT `source_id` INTO @source_82_id FROM `sources` WHERE `citation_number`=82 LIMIT 1;
SELECT `source_id` INTO @source_83_id FROM `sources` WHERE `citation_number`=83 LIMIT 1;
SELECT `source_id` INTO @source_88_id FROM `sources` WHERE `citation_number`=88 LIMIT 1;
SELECT `source_id` INTO @source_89_id FROM `sources` WHERE `citation_number`=89 LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_sources_338`;

CREATE TEMPORARY TABLE `tmp_frzk_sources_338`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_sources_338` (`source_id`)
VALUES (@source_82_id),(@source_83_id),(@source_88_id),(@source_89_id);

DROP TEMPORARY TABLE `tmp_frzk_sources_338`;

/* -------------------------------------------------------------------------------------------------
   6. Quellen-Autor-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `source_authors`
(`source_id`,`author_id`,`author_order`,`role`)
VALUES
(@source_88_id,@author_88_id,1,'author'),
(@source_89_id,@author_89_id,1,'author')
ON DUPLICATE KEY UPDATE
    `author_order`=VALUES(`author_order`),
    `role`=VALUES(`role`);

/* -------------------------------------------------------------------------------------------------
   7. Annotationen der neuen Quellen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `annotations`
(
    `source_id`,`contribution`,`significance_for_dissertation`,
    `citation_reason`,`adopted_claims`,`limitations`,
    `scientific_discussion`,`annotation_status`,`reviewed_at`
)
VALUES
(
    @source_88_id,
    'Systematische Einführung in formale Logik, Modelle, semantische Folgerung, Erfüllbarkeit und Konsistenz.',
    'Bietet die methodische Grundlage zur Abgrenzung qualitativer Gegenmodelle von formalen modelltheoretischen Unabhängigkeitsbeweisen.',
    'Die Quelle wird verwendet, um den Status der Prüfung in Abschnitt 3.3.8 wissenschaftlich einzuordnen.',
    'Übernommen werden die allgemeinen Unterscheidungen zwischen Modell, Erfüllbarkeit, Folgerung und Konsistenz.',
    'Der Abschnitt konstruiert noch keine vollständige formale Sprache und keine mathematisch präzise Modellklasse.',
    'Enderton begründet den formalen Zielstandard; das FRZK verbleibt hier bewusst auf einer qualitativen Vorstufe.',
    'reviewed',
    NOW()
),
(
    @source_89_id,
    'Darstellung mathematischer Logik mit besonderer Behandlung syntaktischer Konsistenz, semantischer Erfüllbarkeit und Axiomenunabhängigkeit.',
    'Stützt die methodische Trennung zwischen qualitativer Widerspruchsfreiheit und formal bewiesener Konsistenz.',
    'Die Quelle wird zur wissenschaftlichen Einordnung der Konsistenz- und Unabhängigkeitsprüfung verwendet.',
    'Übernommen werden die allgemeinen methodischen Unterscheidungen, nicht ein spezieller Kalkül.',
    'Die FRZK-Axiomatik ist in Kapitel 3.3 noch nicht formal genug für die vollständigen Beweismethoden der Quelle.',
    'Mendelson dient als Referenzmaßstab für die spätere Formalisierung in Kapitel 3.4 und darüber hinaus.',
    'reviewed',
    NOW()
)
ON DUPLICATE KEY UPDATE
    `contribution`=VALUES(`contribution`),
    `significance_for_dissertation`=VALUES(`significance_for_dissertation`),
    `citation_reason`=VALUES(`citation_reason`),
    `adopted_claims`=VALUES(`adopted_claims`),
    `limitations`=VALUES(`limitations`),
    `scientific_discussion`=VALUES(`scientific_discussion`),
    `annotation_status`=VALUES(`annotation_status`),
    `reviewed_at`=VALUES(`reviewed_at`);

/* -------------------------------------------------------------------------------------------------
   8. Quellenverwendungen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `source_usage`
WHERE `section_id`=@section_id;

INSERT INTO `source_usage`
(
    `source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,
    `is_first_mention`,`citation_checked`,`notes`,`created_revision_id`
)
VALUES
(
    @source_82_id,@section_id,'background',
    'Tarski wird als methodischer Forschungsanschluss für semantische Modellbetrachtungen und die Untersuchung deduktiver Systeme wiederverwendet.',
    '3.3.8, Einleitung zur Unabhängigkeitsprüfung',
    0,1,
    'Wiederverwendung der Quelle [82].',
    @revision_id
),
(
    @source_83_id,@section_id,'background',
    'Suppes wird als methodischer Forschungsanschluss für axiomatische Theorien und die Bedeutung erfüllender Strukturen wiederverwendet.',
    '3.3.8, Einleitung zur Unabhängigkeitsprüfung',
    0,1,
    'Wiederverwendung der Quelle [83].',
    @revision_id
),
(
    @source_88_id,@section_id,'first_citation',
    'Enderton wird zur formalen Einordnung der Begriffe Modell, Erfüllbarkeit, Folgerung und Konsistenz erstmals eingeführt.',
    '3.3.8, Absatz zur modelltheoretischen Methode',
    1,1,
    'Erstnennung der Quelle [88].',
    @revision_id
),
(
    @source_89_id,@section_id,'first_citation',
    'Mendelson wird zur Einordnung syntaktischer Konsistenz, semantischer Erfüllbarkeit und Axiomenunabhängigkeit erstmals eingeführt.',
    '3.3.8, Absatz zur modelltheoretischen Methode und qualitative Konsistenz',
    1,1,
    'Erstnennung der Quelle [89].',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   9. Definitionen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `definitions`
(
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
VALUES
(
    'Def. 3.3.8.1',
    @section_id,
    'Qualitatives Gegenmodell',
    'Ein qualitatives Gegenmodell ist eine begrifflich widerspruchsfreie Konfiguration, in der ausgewählte FRZK-Axiome gelten und mindestens ein zu prüfendes Axiom ausgeschlossen bleibt. Es ist noch kein Modell einer vollständig formalisierten Sprache.',
    NULL,NULL,'original',NULL,
    'Die qualitative Bedeutung der Axiome A1 bis A5 wird vorausgesetzt.',
    'Methodische Hilfsdefinition für die schwache Unabhängigkeitsprüfung.',
    'checked',@revision_id
),
(
    'Def. 3.3.8.2',
    @section_id,
    'Schwache qualitative Unabhängigkeit',
    'Schwache qualitative Unabhängigkeit liegt vor, wenn ein Axiom eine funktionale Möglichkeit einführt, die begrifflich nicht bereits vollständig in den übrigen Axiomen enthalten ist.',
    NULL,NULL,'original',NULL,
    'Qualitative Gegenmodelle sind beschreibbar.',
    'Keine formale modelltheoretische Unabhängigkeit.',
    'checked',@revision_id
),
(
    'Def. 3.3.8.3',
    @section_id,
    'Starke formale Unabhängigkeit',
    'Starke formale Unabhängigkeit liegt vor, wenn in einer präzise definierten Modellsprache für jedes Axiom ein Modell existiert, das alle übrigen Axiome erfüllt, das betreffende Axiom jedoch nicht.',
    NULL,NULL,'adapted',@source_88_id,
    'Eine formale Sprache, Semantik, Modellklasse und Erfüllungsrelation sind definiert.',
    'Zielbegriff für spätere modelltheoretische Arbeiten; in Abschnitt 3.3.8 noch nicht nachgewiesen.',
    'checked',@revision_id
),
(
    'Def. 3.3.8.4',
    @section_id,
    'Qualitative gemeinsame Erfüllbarkeit',
    'Qualitative gemeinsame Erfüllbarkeit liegt vor, wenn eine begrifflich widerspruchsfreie Konfiguration beschrieben werden kann, in der die Axiome A1 bis A5 gemeinsam gelten.',
    NULL,NULL,'original',NULL,
    'Es wird noch keine formale semantische Erfüllungsrelation vorausgesetzt.',
    'Vorstufe einer späteren formalen Erfüllbarkeits- und Konsistenzprüfung.',
    'checked',@revision_id
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

SET @def_countermodel_id := NULL;
SET @def_weak_independence_id := NULL;
SET @def_strong_independence_id := NULL;
SET @def_satisfiability_id := NULL;

SELECT `definition_id` INTO @def_countermodel_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.8.1' LIMIT 1;
SELECT `definition_id` INTO @def_weak_independence_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.8.2' LIMIT 1;
SELECT `definition_id` INTO @def_strong_independence_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.8.3' LIMIT 1;
SELECT `definition_id` INTO @def_satisfiability_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.8.4' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   10. Propositionen zu den drei Prüfergebnissen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `propositions`
(
    `proposition_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`logical_derivation`,
    `based_on_axioms`,`status`,`created_revision_id`
)
VALUES
(
    'Prop. 3.3.8.1',
    @section_id,
    'Qualitative funktionale Minimalität',
    'Das Axiomensystem A1 bis A5 ist auf der qualitativen Ebene funktional minimal, weil die Entfernung jedes einzelnen Axioms eine eigenständige funktionale Möglichkeit beseitigt.',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ funktional minimal.}',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ funktional minimal.}',
    'Die qualitativen Gegenmodelle zu A1 bis A5 zeigen jeweils den Verlust von Unterscheidbarkeit, Relationierbarkeit, Transformierbarkeit, Organisationsbildung beziehungsweise Kohärenz und Stabilisierung.',
    'A1,A2,A3,A4,A5',
    'review',
    @revision_id
),
(
    'Prop. 3.3.8.2',
    @section_id,
    'Schwache qualitative Unabhängigkeit',
    'Jedes Axiom A1 bis A5 besitzt einen eigenständigen funktionalen Gehalt, der durch die übrigen Axiome auf der qualitativen Ebene nicht vollständig ersetzt wird.',
    '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad A_i\\text{ besitzt einen eigenständigen funktionalen Gehalt.}',
    '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad A_i\\text{ besitzt einen eigenständigen funktionalen Gehalt.}',
    'Für jedes Axiom wird ein qualitatives Gegenmodell beziehungsweise ein spezifischer Funktionsverlust bei seiner Entfernung beschrieben.',
    'A1,A2,A3,A4,A5',
    'review',
    @revision_id
),
(
    'Prop. 3.3.8.3',
    @section_id,
    'Qualitative gemeinsame Erfüllbarkeit',
    'Das vollständige FRZK-Axiomensystem ist qualitativ gemeinsam erfüllbar, weil eine begrifflich widerspruchsfreie Konfiguration beschrieben werden kann, in der alle fünf Axiome gelten.',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ gemeinsam erfüllbar.}',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ gemeinsam erfüllbar.}',
    'Ein qualitatives Modell mit unterscheidbaren, relationierbaren und transformierbaren Konfigurationen, organisationsbildenden Mustern und deren Erhalt unter weiterer Transformation erfüllt alle fünf Axiome.',
    'A1,A2,A3,A4,A5',
    'review',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `statement_text`=VALUES(`statement_text`),
    `statement_latex`=VALUES(`statement_latex`),
    `word_latex`=VALUES(`word_latex`),
    `logical_derivation`=VALUES(`logical_derivation`),
    `based_on_axioms`=VALUES(`based_on_axioms`),
    `status`=VALUES(`status`),
    `created_revision_id`=VALUES(`created_revision_id`);

SET @prop_minimality_id := NULL;
SET @prop_independence_id := NULL;
SET @prop_satisfiability_id := NULL;

SELECT `proposition_id` INTO @prop_minimality_id
FROM `propositions` WHERE `proposition_number`='Prop. 3.3.8.1' LIMIT 1;
SELECT `proposition_id` INTO @prop_independence_id
FROM `propositions` WHERE `proposition_number`='Prop. 3.3.8.2' LIMIT 1;
SELECT `proposition_id` INTO @prop_satisfiability_id
FROM `propositions` WHERE `proposition_number`='Prop. 3.3.8.3' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   11. Objekt-Quellen-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE
(
    (`object_type`='definition' AND `object_id` IN
        (@def_countermodel_id,@def_weak_independence_id,@def_strong_independence_id,@def_satisfiability_id))
    OR
    (`object_type`='proposition' AND `object_id` IN
        (@prop_minimality_id,@prop_independence_id,@prop_satisfiability_id))
)
AND `source_id` IN (@source_82_id,@source_83_id,@source_88_id,@source_89_id);

INSERT INTO `object_source_links`
(`object_type`,`object_id`,`source_id`,`usage_type`,`note`)
VALUES
('definition',@def_countermodel_id,@source_88_id,'supporting_source',
 'Enderton dient als formaler Referenzrahmen für Modelle und Gegenmodelle. Die qualitative Hilfsdefinition ist originär.'),
('definition',@def_weak_independence_id,@source_83_id,'supporting_source',
 'Suppes dient als methodischer Anschluss zur axiomatischen Theoriebildung.'),
('definition',@def_strong_independence_id,@source_88_id,'supporting_source',
 'Enderton stützt den formalen Zielbegriff modelltheoretischer Unabhängigkeit.'),
('definition',@def_strong_independence_id,@source_89_id,'supporting_source',
 'Mendelson stützt die Abgrenzung formaler Unabhängigkeit von qualitativer Vorprüfung.'),
('definition',@def_satisfiability_id,@source_88_id,'supporting_source',
 'Enderton stützt die semantische Einordnung von Erfüllbarkeit.'),
('proposition',@prop_minimality_id,@source_83_id,'supporting_source',
 'Suppes dient als methodischer Anschluss zur Prüfung axiomatischer Grundannahmen.'),
('proposition',@prop_independence_id,@source_88_id,'supporting_source',
 'Enderton dient als formaler Referenzrahmen für Unabhängigkeitsprüfungen.'),
('proposition',@prop_independence_id,@source_89_id,'supporting_source',
 'Mendelson dient als zusätzlicher Referenzrahmen zur Axiomenunabhängigkeit.'),
('proposition',@prop_satisfiability_id,@source_88_id,'supporting_source',
 'Enderton stützt die Unterscheidung zwischen qualitativer und formaler Erfüllbarkeit.'),
('proposition',@prop_satisfiability_id,@source_89_id,'supporting_source',
 'Mendelson stützt die Abgrenzung semantischer Erfüllbarkeit und syntaktischer Konsistenz.');

/* -------------------------------------------------------------------------------------------------
   12. Gleichungen (3.307) bis (3.326)
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
    `plain_description`,`equation_type`,`provenance`,`source_id`,
    `derivation`,`assumptions`,`validation_status`,`created_revision_id`
)
VALUES
('3.307',@section_id,'Vollständiges FRZK-Axiomensystem',
 '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5\\right\\}',
 '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5\\right\\}',
 'Zusammenfassende Bezeichnung des vollständigen Axiomensystems.',
 'definition','original',NULL,
 'Wiederaufnahme der Sammelbezeichnung aus Abschnitt 3.3.7.',
 'Qualitative Axiomatik.', 'checked',@revision_id),

('3.308',@section_id,'Qualitatives Minimalitätskriterium',
 '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad\\mathcal{A}_{\\mathrm{FRZK}}\\setminus\\left\\{A_i\\right\\}\\text{ besitzt eine geringere funktionale Reichweite als }\\mathcal{A}_{\\mathrm{FRZK}}',
 '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad\\mathcal{A}_{\\mathrm{FRZK}}\\setminus\\left\\{A_i\\right\\}\\text{ besitzt eine geringere funktionale Reichweite als }\\mathcal{A}_{\\mathrm{FRZK}}',
 'Qualitatives Kriterium funktionaler Minimalität.',
 'schema','original',NULL,
 'Für jedes entfernte Axiom muss ein eigenständiger Funktionsverlust angegeben werden.',
 'Noch kein formaler Minimalitätsbeweis.', 'checked',@revision_id),

('3.309',@section_id,'Qualitatives Gegenmodell zu Axiom A1',
 '\\mathfrak{M}_{\\neg A_1}:\\quad\\neg A_1\\land\\neg A_2\\land\\neg A_3\\land\\neg A_4\\land\\neg A_5',
 '\\mathfrak{M}_{\\neg A_1}:\\quad\\neg A_1\\land\\neg A_2\\land\\neg A_3\\land\\neg A_4\\land\\neg A_5',
 'Vollständig unbestimmte Konfiguration ohne funktionale Unterscheidbarkeit.',
 'model','original',NULL,
 'Ohne A1 fehlt den übrigen Axiomen ihre Anwendungsgrundlage.',
 'Qualitatives Gegenmodell.', 'checked',@revision_id),

('3.310',@section_id,'Qualitatives Gegenmodell zu Axiom A2',
 '\\mathfrak{M}_{\\neg A_2}:\\quad A_1\\land\\neg A_2',
 '\\mathfrak{M}_{\\neg A_2}:\\quad A_1\\land\\neg A_2',
 'Unterscheidbare, aber vollständig isolierte funktionale Zustände.',
 'model','original',NULL,
 'Unterscheidbarkeit impliziert keine Relationierbarkeit.',
 'Qualitatives Gegenmodell.', 'checked',@revision_id),

('3.311',@section_id,'Qualitatives Gegenmodell zu Axiom A3',
 '\\mathfrak{M}_{\\neg A_3}:\\quad A_1\\land A_2\\land\\neg A_3',
 '\\mathfrak{M}_{\\neg A_3}:\\quad A_1\\land A_2\\land\\neg A_3',
 'Statische relationale Struktur ohne Transformierbarkeit.',
 'model','original',NULL,
 'Unterscheidbarkeit und Relationierbarkeit implizieren keine Veränderbarkeit.',
 'Qualitatives Gegenmodell.', 'checked',@revision_id),

('3.312',@section_id,'Qualitatives Gegenmodell zu Axiom A4',
 '\\mathfrak{M}_{\\neg A_4}:\\quad A_1\\land A_2\\land A_3\\land\\neg A_4',
 '\\mathfrak{M}_{\\neg A_4}:\\quad A_1\\land A_2\\land A_3\\land\\neg A_4',
 'Ungeordnete Transformationen ohne übergeordnetes Organisationsmuster.',
 'model','original',NULL,
 'Dynamik impliziert keine Organisationsbildung.',
 'Qualitatives Gegenmodell.', 'checked',@revision_id),

('3.313',@section_id,'Qualitatives Gegenmodell zu Axiom A5',
 '\\mathfrak{M}_{\\neg A_5}:\\quad A_1\\land A_2\\land A_3\\land A_4\\land\\neg A_5',
 '\\mathfrak{M}_{\\neg A_5}:\\quad A_1\\land A_2\\land A_3\\land A_4\\land\\neg A_5',
 'Organisationsbildung ohne Erhalt oder Reproduktion unter weiterer Transformation.',
 'model','original',NULL,
 'Organisation impliziert keine Kohärenz.',
 'Qualitatives Gegenmodell.', 'checked',@revision_id),

('3.314',@section_id,'Qualitative Nichtfolgerung der Einzelaxiome',
 '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad\\mathcal{A}_{\\mathrm{FRZK}}\\setminus\\left\\{A_i\\right\\}\\not\\models_{\\mathrm{qual}}A_i',
 '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad\\mathcal{A}_{\\mathrm{FRZK}}\\setminus\\left\\{A_i\\right\\}\\not\\models_{\\mathrm{qual}}A_i',
 'Qualitative Unabhängigkeitsvermutung auf Grundlage begrifflicher Gegenmodelle.',
 'schema','original',NULL,
 'Für jedes Axiom wird ein eigenständiger Funktionsverlust beschrieben.',
 'Keine formale Erfüllungsrelation.', 'checked',@revision_id),

('3.315',@section_id,'Begriffliche Aufbauordnung der Axiome',
 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5',
 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5',
 'Gerichtete begriffliche Vorrang- und Aufbauordnung ohne logische Implikation.',
 'schema','original',NULL,
 'Jedes spätere Axiom benötigt die funktionale Anwendungsgrundlage der vorausgehenden Stufen.',
 'Keine deduktive Äquivalenz.', 'checked',@revision_id),

('3.316',@section_id,'Qualitative Gegenmodelle und schwache Unabhängigkeit',
 '\\text{qualitative Gegenmodelle}\\Longrightarrow\\text{schwache Unabhängigkeit}',
 '\\text{qualitative Gegenmodelle}\\Longrightarrow\\text{schwache Unabhängigkeit}',
 'Methodische Einordnung des in Abschnitt 3.3.8 erreichten Prüfstatus.',
 'schema','original',NULL,
 'Begriffliche Gegenmodelle zeigen eigenständigen funktionalen Gehalt.',
 'Noch keine starke formale Unabhängigkeit.', 'checked',@revision_id),

('3.317',@section_id,'Voraussetzungen starker formaler Unabhängigkeit',
 '\\text{formale Modelle}+\\text{präzise Semantik}\\Longrightarrow\\text{prüfbare starke Unabhängigkeit}',
 '\\text{formale Modelle}+\\text{präzise Semantik}\\Longrightarrow\\text{prüfbare starke Unabhängigkeit}',
 'Abgrenzung des später erforderlichen formalen Prüfstandards.',
 'schema','adapted',@source_88_id,
 'Formale Unabhängigkeit benötigt Sprache, Semantik, Modellklasse und Erfüllungsrelation.',
 'Methodische Zielaussage.', 'checked',@revision_id),

('3.318',@section_id,'Qualitative Konsistenzforderung',
 '\\neg\\exists A_i,A_j\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad A_i\\Longrightarrow\\neg A_j',
 '\\neg\\exists A_i,A_j\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad A_i\\Longrightarrow\\neg A_j',
 'Kein Axiom soll auf qualitativer Ebene unmittelbar die Negation eines anderen erzwingen.',
 'schema','original',NULL,
 'Prüfung auf offensichtliche begriffliche Widersprüche.',
 'Keine syntaktische Konsistenzprüfung.', 'checked',@revision_id),

('3.319',@section_id,'Qualitatives Erfüllbarkeitsmodell',
 '\\mathfrak{M}_{\\mathrm{FRZK}}\\models_{\\mathrm{qual}}A_1\\land A_2\\land A_3\\land A_4\\land A_5',
 '\\mathfrak{M}_{\\mathrm{FRZK}}\\models_{\\mathrm{qual}}A_1\\land A_2\\land A_3\\land A_4\\land A_5',
 'Qualitative gemeinsame Interpretation aller fünf Axiome.',
 'model','original',NULL,
 'Begrifflich widerspruchsfreie Konfiguration mit allen fünf funktionalen Möglichkeiten.',
 'Keine formale Modellrelation.', 'checked',@revision_id),

('3.320',@section_id,'Qualitative Existenz eines Erfüllbarkeitsmodells',
 '\\exists\\mathfrak{M}_{\\mathrm{FRZK}}:\\quad\\mathfrak{M}_{\\mathrm{FRZK}}\\models_{\\mathrm{qual}}\\mathcal{A}_{\\mathrm{FRZK}}',
 '\\exists\\mathfrak{M}_{\\mathrm{FRZK}}:\\quad\\mathfrak{M}_{\\mathrm{FRZK}}\\models_{\\mathrm{qual}}\\mathcal{A}_{\\mathrm{FRZK}}',
 'Qualitative Plausibilität gemeinsamer Erfüllbarkeit.',
 'model','original',NULL,
 'Ein begriffliches Erfüllbarkeitsmodell kann beschrieben werden.',
 'Kein formaler Existenzbeweis.', 'checked',@revision_id),

('3.321',@section_id,'Abgrenzung qualitativer und formaler Konsistenz',
 '\\text{qualitative Widerspruchsfreiheit}\\neq\\text{formal bewiesene Konsistenz}',
 '\\text{qualitative Widerspruchsfreiheit}\\neq\\text{formal bewiesene Konsistenz}',
 'Wissenschaftstheoretische Abgrenzung des erreichten Prüfstatus.',
 'principle','original',NULL,
 'Qualitative Vereinbarkeit ersetzt keinen formalen Konsistenzbeweis.',
 'Methodische Begrenzung.', 'checked',@revision_id),

('3.322',@section_id,'Funktionsverlust bei Entfernung eines Axioms',
 '\\begin{array}{c|l}\\text{entferntes Axiom}&\\text{verlorene funktionale Möglichkeit}\\\\\\hline A_1&\\text{funktionale Unterscheidbarkeit}\\\\A_2&\\text{funktionale Relationierbarkeit}\\\\A_3&\\text{funktionale Transformierbarkeit}\\\\A_4&\\text{funktionale Organisationsbildung}\\\\A_5&\\text{funktionale Kohärenz und Stabilisierung}\\end{array}',
 '\\begin{array}{c|l}\\text{entferntes Axiom}&\\text{verlorene funktionale Möglichkeit}\\\\\\hline A_1&\\text{funktionale Unterscheidbarkeit}\\\\A_2&\\text{funktionale Relationierbarkeit}\\\\A_3&\\text{funktionale Transformierbarkeit}\\\\A_4&\\text{funktionale Organisationsbildung}\\\\A_5&\\text{funktionale Kohärenz und Stabilisierung}\\end{array}',
 'Tabellarische Zusammenfassung des Funktionsverlustes bei Entfernung jedes Axioms.',
 'schema','original',NULL,
 'Ergebnis der qualitativen Gegenmodellprüfung.',
 'Qualitative Zusammenfassung.', 'checked',@revision_id),

('3.323',@section_id,'Ergebnis der Minimalitätsprüfung',
 '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ funktional minimal.}',
 '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ funktional minimal.}',
 'Qualitatives Ergebnis der Minimalitätsprüfung.',
 'derived','original',NULL,
 'Folgt auf qualitativer Ebene aus den fünf Gegenmodellbetrachtungen.',
 'Keine formale Minimalität.', 'checked',@revision_id),

('3.324',@section_id,'Ergebnis der Unabhängigkeitsprüfung',
 '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad A_i\\text{ besitzt einen eigenständigen funktionalen Gehalt.}',
 '\\forall A_i\\in\\mathcal{A}_{\\mathrm{FRZK}}:\\quad A_i\\text{ besitzt einen eigenständigen funktionalen Gehalt.}',
 'Qualitatives Ergebnis der schwachen Unabhängigkeitsprüfung.',
 'derived','original',NULL,
 'Jedes Axiom ergänzt eine nicht vollständig ersetzbare funktionale Möglichkeit.',
 'Keine starke formale Unabhängigkeit.', 'checked',@revision_id),

('3.325',@section_id,'Ergebnis der qualitativen Erfüllbarkeitsprüfung',
 '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ gemeinsam erfüllbar.}',
 '\\mathcal{A}_{\\mathrm{FRZK}}\\text{ ist qualitativ gemeinsam erfüllbar.}',
 'Qualitatives Ergebnis der Konsistenzvorprüfung.',
 'derived','original',NULL,
 'Ein begrifflich widerspruchsfreies Erfüllbarkeitsmodell kann beschrieben werden.',
 'Keine formal bewiesene Konsistenz.', 'checked',@revision_id),

('3.326',@section_id,'Gesamtbewertung der qualitativen Axiomenprüfung',
 '\\mathcal{A}_{\\mathrm{FRZK}}\\Longrightarrow\\left\\{\\begin{array}{l}\\text{qualitative funktionale Minimalität},\\\\\\text{schwache qualitative Unabhängigkeit},\\\\\\text{qualitative gemeinsame Erfüllbarkeit}\\end{array}\\right\\}',
 '\\mathcal{A}_{\\mathrm{FRZK}}\\Longrightarrow\\left\\{\\begin{array}{l}\\text{qualitative funktionale Minimalität},\\\\\\text{schwache qualitative Unabhängigkeit},\\\\\\text{qualitative gemeinsame Erfüllbarkeit}\\end{array}\\right\\}',
 'Zusammenfassung der drei vorläufigen Prüfergebnisse.',
 'schema','original',NULL,
 'Zusammenführung von Minimalitäts-, Unabhängigkeits- und Erfüllbarkeitsprüfung.',
 'Qualitative Vorprüfung.', 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
    `section_id`=VALUES(`section_id`),
    `title`=VALUES(`title`),
    `equation_latex`=VALUES(`equation_latex`),
    `word_latex`=VALUES(`word_latex`),
    `plain_description`=VALUES(`plain_description`),
    `equation_type`=VALUES(`equation_type`),
    `provenance`=VALUES(`provenance`),
    `source_id`=VALUES(`source_id`),
    `derivation`=VALUES(`derivation`),
    `assumptions`=VALUES(`assumptions`),
    `validation_status`=VALUES(`validation_status`),
    `created_revision_id`=VALUES(`created_revision_id`);

/* -------------------------------------------------------------------------------------------------
   13. Gleichungs-IDs laden
   ------------------------------------------------------------------------------------------------- */

SET @eq_3307 := NULL; SET @eq_3308 := NULL; SET @eq_3309 := NULL; SET @eq_3310 := NULL;
SET @eq_3311 := NULL; SET @eq_3312 := NULL; SET @eq_3313 := NULL; SET @eq_3314 := NULL;
SET @eq_3315 := NULL; SET @eq_3316 := NULL; SET @eq_3317 := NULL; SET @eq_3318 := NULL;
SET @eq_3319 := NULL; SET @eq_3320 := NULL; SET @eq_3321 := NULL; SET @eq_3322 := NULL;
SET @eq_3323 := NULL; SET @eq_3324 := NULL; SET @eq_3325 := NULL; SET @eq_3326 := NULL;

SELECT `equation_id` INTO @eq_3307 FROM `equations` WHERE `equation_number`='3.307' LIMIT 1;
SELECT `equation_id` INTO @eq_3308 FROM `equations` WHERE `equation_number`='3.308' LIMIT 1;
SELECT `equation_id` INTO @eq_3309 FROM `equations` WHERE `equation_number`='3.309' LIMIT 1;
SELECT `equation_id` INTO @eq_3310 FROM `equations` WHERE `equation_number`='3.310' LIMIT 1;
SELECT `equation_id` INTO @eq_3311 FROM `equations` WHERE `equation_number`='3.311' LIMIT 1;
SELECT `equation_id` INTO @eq_3312 FROM `equations` WHERE `equation_number`='3.312' LIMIT 1;
SELECT `equation_id` INTO @eq_3313 FROM `equations` WHERE `equation_number`='3.313' LIMIT 1;
SELECT `equation_id` INTO @eq_3314 FROM `equations` WHERE `equation_number`='3.314' LIMIT 1;
SELECT `equation_id` INTO @eq_3315 FROM `equations` WHERE `equation_number`='3.315' LIMIT 1;
SELECT `equation_id` INTO @eq_3316 FROM `equations` WHERE `equation_number`='3.316' LIMIT 1;
SELECT `equation_id` INTO @eq_3317 FROM `equations` WHERE `equation_number`='3.317' LIMIT 1;
SELECT `equation_id` INTO @eq_3318 FROM `equations` WHERE `equation_number`='3.318' LIMIT 1;
SELECT `equation_id` INTO @eq_3319 FROM `equations` WHERE `equation_number`='3.319' LIMIT 1;
SELECT `equation_id` INTO @eq_3320 FROM `equations` WHERE `equation_number`='3.320' LIMIT 1;
SELECT `equation_id` INTO @eq_3321 FROM `equations` WHERE `equation_number`='3.321' LIMIT 1;
SELECT `equation_id` INTO @eq_3322 FROM `equations` WHERE `equation_number`='3.322' LIMIT 1;
SELECT `equation_id` INTO @eq_3323 FROM `equations` WHERE `equation_number`='3.323' LIMIT 1;
SELECT `equation_id` INTO @eq_3324 FROM `equations` WHERE `equation_number`='3.324' LIMIT 1;
SELECT `equation_id` INTO @eq_3325 FROM `equations` WHERE `equation_number`='3.325' LIMIT 1;
SELECT `equation_id` INTO @eq_3326 FROM `equations` WHERE `equation_number`='3.326' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   14. Gleichungssymbole – kompakt und vollständig
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN
(
 @eq_3307,@eq_3308,@eq_3309,@eq_3310,@eq_3311,@eq_3312,@eq_3313,@eq_3314,@eq_3315,@eq_3316,
 @eq_3317,@eq_3318,@eq_3319,@eq_3320,@eq_3321,@eq_3322,@eq_3323,@eq_3324,@eq_3325,@eq_3326
);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES
(@eq_3307,'\\mathcal{A}_{\\mathrm{FRZK}}','FRZK-Axiomensystem','Zusammenfassende Bezeichnung der Axiome A1 bis A5.',NULL,'qualitative FRZK-Axiomatik',1),

(@eq_3308,'\\forall','Allquantor','Bezieht die Minimalitätsforderung auf jedes Axiom des Systems.',NULL,'qualitative Logik',1),
(@eq_3308,'A_i','beliebiges FRZK-Axiom','Beliebiges Axiom aus dem vollständigen Axiomensystem.',NULL,'qualitative FRZK-Axiomatik',2),
(@eq_3308,'\\setminus','Mengendifferenzzeichen','Kennzeichnet das qualitative Entfernen eines Axioms aus der Sammelbezeichnung.',NULL,'qualitative Metasprache',3),

(@eq_3309,'\\mathfrak{M}_{\\neg A_1}','Gegenmodell zu A1','Qualitative Konfiguration ohne Axiom A1.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3310,'\\mathfrak{M}_{\\neg A_2}','Gegenmodell zu A2','Qualitative Konfiguration ohne Axiom A2.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3311,'\\mathfrak{M}_{\\neg A_3}','Gegenmodell zu A3','Qualitative Konfiguration ohne Axiom A3.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3312,'\\mathfrak{M}_{\\neg A_4}','Gegenmodell zu A4','Qualitative Konfiguration ohne Axiom A4.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3313,'\\mathfrak{M}_{\\neg A_5}','Gegenmodell zu A5','Qualitative Konfiguration ohne Axiom A5.',NULL,'qualitative Modellbetrachtung',1),

(@eq_3314,'\\not\\models_{\\mathrm{qual}}','qualitative Nichtfolgerung','Kennzeichnet qualitative Nichtfolgerung ohne formale Semantik.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3315,'\\prec','begriffliche Aufbauordnung','Kennzeichnet Vorrang und Aufbauordnung ohne logische Implikation.',NULL,'qualitative Theoriearchitektur',1),
(@eq_3316,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet die methodische Konsequenz qualitativer Gegenmodelle.',NULL,'qualitative Metasprache',1),
(@eq_3317,'+','methodische Kombination','Verknüpft formale Modelle und präzise Semantik als Voraussetzungen.',NULL,'qualitative Metasprache',1),
(@eq_3318,'\\exists','Existenzquantor','Bezeichnet die qualitative Forderung, dass kein widersprechendes Axiompaar existiert.',NULL,'qualitative Logik',1),
(@eq_3319,'\\models_{\\mathrm{qual}}','qualitative Erfüllungsrelation','Kennzeichnet qualitative gemeinsame Interpretierbarkeit.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3320,'\\exists','Existenzquantor','Kennzeichnet die qualitative Existenz eines Erfüllbarkeitsmodells.',NULL,'qualitative Modellbetrachtung',1),
(@eq_3321,'\\neq','Ungleichheitszeichen','Trennt qualitative Widerspruchsfreiheit und formal bewiesene Konsistenz.',NULL,'Wissenschaftstheorie',1),
(@eq_3322,'\\begin{array}{c|l}','tabellarische Darstellung','Ordnet jedem entfernten Axiom den Funktionsverlust zu.',NULL,'qualitative Axiomenprüfung',1),
(@eq_3323,'\\mathcal{A}_{\\mathrm{FRZK}}','FRZK-Axiomensystem','Vollständiges qualitatives Axiomensystem.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3324,'\\forall','Allquantor','Bezieht die Aussage auf jedes Axiom.',NULL,'qualitative Logik',1),
(@eq_3325,'\\mathcal{A}_{\\mathrm{FRZK}}','FRZK-Axiomensystem','Vollständiges qualitatives Axiomensystem.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3326,'\\mathcal{A}_{\\mathrm{FRZK}}','FRZK-Axiomensystem','Vollständiges qualitatives Axiomensystem.',NULL,'qualitative FRZK-Axiomatik',1),
(@eq_3326,'\\Longrightarrow','qualitativer Folgerungspfeil','Kennzeichnet die zusammenfassende qualitative Bewertung.',NULL,'qualitative Folgerung',2)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   15. Abschnittssymbole
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
    '\\mathfrak{M}_{\\neg A_i}',
    '\\mathfrak{M}_{\\neg A_i}',
    'qualitatives Gegenmodell zu Axiom Ai',
    'Sammelnotation für ein qualitatives Gegenmodell, in dem das jeweils betrachtete Axiom ausgeschlossen bleibt.',
    'section',@section_id,@eq_3309,NULL,
    'qualitative Modellbetrachtung','qualitative Modellbetrachtung',
    0,0,0,
    'Keine formale Modellstruktur.',
    'checked',@revision_id
),
(
    '\\models_{\\mathrm{qual}}',
    '\\models_{\\mathrm{qual}}',
    'qualitative Erfüllungsrelation',
    'Kennzeichnet begriffliche gemeinsame Interpretierbarkeit ohne vollständig definierte formale Semantik.',
    'section',@section_id,@eq_3319,NULL,
    'qualitative Modellbetrachtung','qualitative Modellbetrachtung',
    0,0,0,
    'Abgrenzung zur formalen semantischen Erfüllungsrelation.',
    'checked',@revision_id
),
(
    '\\not\\models_{\\mathrm{qual}}',
    '\\not\\models_{\\mathrm{qual}}',
    'qualitative Nichtfolgerung',
    'Kennzeichnet qualitative Nichtableitbarkeit ohne formale Modellsprache.',
    'section',@section_id,@eq_3314,NULL,
    'qualitative Modellbetrachtung','qualitative Modellbetrachtung',
    0,0,0,
    'Abgrenzung zur formalen semantischen Nichtfolgerung.',
    'checked',@revision_id
),
(
    '\\prec',
    '\\prec',
    'begriffliche Aufbauordnung',
    'Kennzeichnet den funktionalen Vorrang eines Axioms gegenüber dem jeweils folgenden Axiom.',
    'section',@section_id,@eq_3315,NULL,
    'qualitative Theoriearchitektur','qualitative Theoriearchitektur',
    0,0,0,
    'Keine logische Implikation und keine numerische Ordnung.',
    'checked',@revision_id
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
   16. Änderungsprotokoll
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
    @revision_id,@section_id,'rewritten','section','3.3.8',
    'Abschnitt 3.3.8 wurde vollständig als qualitative Prüfung von Minimalität, Unabhängigkeit und Konsistenz des Axiomensystems neu gefasst.',
    'Älterer Planungsstand.',
    'Minimalität, Unabhängigkeit und Konsistenz des Axiomensystems.'
),
(
    @revision_id,@section_id,'source_added','sources','[88], [89]',
    'Enderton und Mendelson wurden als neue methodische Quellen registriert.',
    NULL,
    'Zwei neue Quellen einschließlich Autoren, Annotationen und Erstverwendungen.'
),
(
    @revision_id,@section_id,'source_reused','source_usage','[82], [83]',
    'Tarski und Suppes wurden als methodische Forschungsanschlüsse wiederverwendet.',
    NULL,
    'Zwei geprüfte Wiederverwendungen.'
),
(
    @revision_id,@section_id,'definition_added','definitions','Def. 3.3.8.1–Def. 3.3.8.4',
    'Vier methodische Definitionen wurden registriert.',
    NULL,
    'Qualitatives Gegenmodell, schwache qualitative Unabhängigkeit, starke formale Unabhängigkeit und qualitative gemeinsame Erfüllbarkeit.'
),
(
    @revision_id,@section_id,'proposition_added','propositions','Prop. 3.3.8.1–Prop. 3.3.8.3',
    'Drei Ergebnispropositionen wurden registriert.',
    NULL,
    'Qualitative Minimalität, schwache Unabhängigkeit und gemeinsame Erfüllbarkeit.'
),
(
    @revision_id,@section_id,'equation_added','equations','(3.307)–(3.326)',
    'Zwanzig Gleichungen und qualitative Modelldarstellungen wurden registriert.',
    NULL,
    'Axiomensystem, Minimalitätskriterium, Gegenmodelle, Unabhängigkeit, Konsistenz und Gesamtbewertung.'
),
(
    @revision_id,@section_id,'symbol_added','symbols','Gegenmodell- und Erfüllungsnotation',
    'Die abschnittsspezifischen Symbole für qualitative Gegenmodelle, Erfüllung, Nichtfolgerung und Aufbauordnung wurden registriert.',
    NULL,
    'Vier Abschnittssymbole.'
),
(
    @revision_id,@section_id,'status_changed','section','3.3.8',
    'Der Abschnitt wurde nach vollständiger Neufassung auf review gesetzt.',
    'planned',
    'review'
);

/* -------------------------------------------------------------------------------------------------
   17. Repository-Zähler
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(`counter_key`,`counter_value`)
VALUES
('last_edited_section','3.3.8'),
('last_repository_revision','RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1'),
('next_citation_number','90'),
('next_equation_number','3.327')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* =================================================================================================
   18. AUDIT UND KONTROLLABFRAGEN
   ================================================================================================= */

/* 18.1 Revision und Parent */
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
      'RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1' COLLATE utf8mb4_unicode_ci;

/* 18.2 Abschnitt */
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
      '3.3.8' COLLATE utf8mb4_unicode_ci;

/* 18.3 Neue Quellen und Autoren */
SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`edition`,
    s.`publisher`,
    s.`place`,
    s.`year_edition`,
    s.`verification_status`,
    a.`normalized_name`,
    sa.`author_order`,
    sa.`role`
FROM `sources` s
LEFT JOIN `source_authors` sa ON sa.`source_id`=s.`source_id`
LEFT JOIN `authors` a ON a.`author_id`=sa.`author_id`
WHERE s.`citation_number` IN (88,89)
ORDER BY s.`citation_number`,sa.`author_order`;

/* 18.4 Quellenverwendungen */
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

/* 18.5 Definitionen */
SELECT
    d.`definition_number`,
    d.`title`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`section_id`=@section_id
ORDER BY d.`definition_number`;

/* 18.6 Propositionen */
SELECT
    p.`proposition_number`,
    p.`title`,
    p.`based_on_axioms`,
    p.`status`,
    CASE
        WHEN p.`word_latex` IS NULL OR TRIM(p.`word_latex`)=''
        THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `propositions` p
WHERE p.`section_id`=@section_id
ORDER BY p.`proposition_number`;

/* 18.7 Gleichungen */
SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_type`,
    e.`provenance`,
    e.`validation_status`,
    CASE
        WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`)=''
        THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 307 AND 326
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

/* 18.8 Gleichungssymbole */
SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 307 AND 326
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),es.`symbol_order`;

/* 18.9 Abschnittssymbole */
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

/* 18.10 Objekt-Quellen-Verknüpfungen */
SELECT
    osl.`object_type`,
    osl.`object_id`,
    s.`citation_number`,
    osl.`usage_type`,
    osl.`note`
FROM `object_source_links` osl
JOIN `sources` s ON s.`source_id`=osl.`source_id`
WHERE
(
    (osl.`object_type`='definition' AND osl.`object_id` IN
        (@def_countermodel_id,@def_weak_independence_id,@def_strong_independence_id,@def_satisfiability_id))
    OR
    (osl.`object_type`='proposition' AND osl.`object_id` IN
        (@prop_minimality_id,@prop_independence_id,@prop_satisfiability_id))
)
ORDER BY osl.`object_type`,osl.`object_id`,s.`citation_number`;

/* 18.11 Repository-Zähler */
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

/* 18.12 Gleichungsdubletten */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*)>1;

/* 18.13 Proposition-Dubletten */
SELECT
    `proposition_number`,
    COUNT(*) AS `duplicate_count`
FROM `propositions`
GROUP BY `proposition_number`
HAVING COUNT(*)>1;

/* 18.14 Doppelte Gleichungssymbole */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`,`symbol_latex`
HAVING COUNT(*)>1;

/* 18.15 Fehlendes Word-LaTeX */
SELECT
    'equation' AS `object_type`,
    e.`equation_number` AS `object_reference`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND (e.`word_latex` IS NULL OR TRIM(e.`word_latex`)='')

UNION ALL

SELECT
    'proposition',
    p.`proposition_number`
FROM `propositions` p
WHERE p.`section_id`=@section_id
  AND (p.`word_latex` IS NULL OR TRIM(p.`word_latex`)='');

/* 18.16 Leere ENUM-Werte */
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
WHERE
(
    (`object_type`='definition' AND `object_id` IN
        (@def_countermodel_id,@def_weak_independence_id,@def_strong_independence_id,@def_satisfiability_id))
    OR
    (`object_type`='proposition' AND `object_id` IN
        (@prop_minimality_id,@prop_independence_id,@prop_satisfiability_id))
)
AND (`usage_type` IS NULL OR TRIM(`usage_type`)='');

/* 18.17 Verwaiste Objekte */
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
    'proposition',
    p.`proposition_id`,
    p.`proposition_number`
FROM `propositions` p
LEFT JOIN `dissertation_sections` ds ON ds.`section_id`=p.`section_id`
WHERE p.`created_revision_id`=@revision_id
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

/* 18.18 Änderungsprotokoll */
SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id`=@revision_id
  AND scl.`section_id`=@section_id
ORDER BY scl.`change_id`;

/* 18.19 Abschlussmeldung */
SELECT
    'Repository-Update 3.3.8 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [90], Gleichung (3.327), letzte Revision RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1.'
AS `result`;
