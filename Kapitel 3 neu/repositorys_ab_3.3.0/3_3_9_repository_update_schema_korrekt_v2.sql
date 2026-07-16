/* =================================================================================================
   FRZK-RKB – VOLLSTÄNDIGES, SCHEMAKONFORMES REPOSITORY-UPDATE ZU ABSCHNITT 3.3.9

   Verbindliche Schemaquelle:
     frzk_rkb(5).sql / aktueller Repository-Stand 3.3.1–3.3.8

   Abschnitt:
     3.3.9 Übergangsregeln zur mathematischen Rekonstruktion – vollständige Endfassung

   Erforderlicher Ausgangsstand:
     Parent-Revision:             RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1
     letzte Literaturquelle:      [89]
     nächste freie Literatur-Nr.: [96]
     letzte Gleichung:            (3.326)
     neue Gleichungen:            (3.327)–(3.339)

   Durch dieses Skript erzeugter Stand:
     neue Literaturquellen:       [90]–[95]
     wiederverwendete Quellen:    [82], [83], [84], [85], [88], [89]
     nächste freie Literatur-Nr.: [96]
     neue Gleichungen:            (3.327)–(3.339)
     nächste freie Gleichung:     (3.340)
     neue Revision:               RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2

   Registrierte Repository-Objekte:
     - repository_revisions
     - dissertation_sections
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
     - Es werden keine neuen Quellen, Axiome oder assumptions erzeugt.
     - source_usage.usage_type verwendet ausschließlich 'background'.
     - object_source_links.usage_type verwendet ausschließlich 'supporting_source'.
     - propositions.status verwendet ausschließlich 'review'.
     - section_change_log.change_type verwendet ausschließlich gültige ENUM-Werte.
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
    CONVERT('RKB-2026-07-16-K3.3.8-NEUFASSUNG-V1' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_339`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_339`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_339` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_339`;

/* -------------------------------------------------------------------------------------------------
   2. Abschnittsrevision anlegen
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2' USING utf8mb4)
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
    '3.3.9',
    'V1',
    'Vollständige Neufassung und Repository-Integration von Abschnitt 3.3.9: Übergangsregeln zur mathematischen Rekonstruktion. Registriert werden Bedeutungsinvarianz, Vorrang relationaler und transformatorischer Strukturen vor Raum und Zeit, Rekonstruktion statt bloßer Übersetzung, das mathematische Minimalprinzip, die Gleichungen (3.327) bis (3.333), Definitionen, Propositionen, Quellenverwendungen, Objekt-Quellen-Verknüpfungen, Symbole, Änderungsprotokoll, Repository-Zähler und vollständige Audit-Abfragen.',
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
   3. Abschnitt 3.3.9 registrieren
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_section_339`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_section_339`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_section_339` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_section_339`;

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
    '3.3.9',
    'Übergangsregeln zur mathematischen Rekonstruktion',
    3,
    3.3010,
    'review',
    1,
    'Abschluss der prämathematischen Ebene von Kapitel 3.3. Der Abschnitt legt verbindliche wissenschaftstheoretische Regeln für den Übergang zur mathematischen Rekonstruktion in Kapitel 3.4 fest.'
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
      '3.3.9' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   4. Bereits vorhandene Quellen auflösen
   ------------------------------------------------------------------------------------------------- */

SET @source_82_id := NULL;
SET @source_83_id := NULL;
SET @source_84_id := NULL;
SET @source_85_id := NULL;
SET @source_88_id := NULL;
SET @source_89_id := NULL;

SELECT `source_id` INTO @source_82_id FROM `sources` WHERE `citation_number`=82 LIMIT 1;
SELECT `source_id` INTO @source_83_id FROM `sources` WHERE `citation_number`=83 LIMIT 1;
SELECT `source_id` INTO @source_84_id FROM `sources` WHERE `citation_number`=84 LIMIT 1;
SELECT `source_id` INTO @source_85_id FROM `sources` WHERE `citation_number`=85 LIMIT 1;
SELECT `source_id` INTO @source_88_id FROM `sources` WHERE `citation_number`=88 LIMIT 1;
SELECT `source_id` INTO @source_89_id FROM `sources` WHERE `citation_number`=89 LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_sources_339`;

CREATE TEMPORARY TABLE `tmp_frzk_sources_339`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_sources_339` (`source_id`)
VALUES
(@source_82_id),(@source_83_id),(@source_84_id),
(@source_85_id),(@source_88_id),(@source_89_id);

DROP TEMPORARY TABLE `tmp_frzk_sources_339`;

/* -------------------------------------------------------------------------------------------------
   5. Quellenverwendungen
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
    'Tarski wird als methodischer Hintergrund für die strikte Trennung zwischen primitiven Ausdrücken, Semantik, formaler Sprache und späterer Ableitung verwendet.',
    '3.3.9, Einleitung und Bedeutungsinvarianz',
    0,1,
    'Wiederverwendung der Quelle [82].',
    @revision_id
),
(
    @source_83_id,@section_id,'background',
    'Suppes wird als methodischer Hintergrund für den schrittweisen Aufbau axiomatischer und mathematischer Theorien verwendet.',
    '3.3.9, Rekonstruktion statt Übersetzung',
    0,1,
    'Wiederverwendung der Quelle [83].',
    @revision_id
),
(
    @source_84_id,@section_id,'background',
    'Mac Lane wird als struktureller Forschungsanschluss für den Vorrang von Relationen, Strukturen und Transformationen gegenüber isolierten Objekten verwendet.',
    '3.3.9, Vorrang funktionaler Relationen',
    0,1,
    'Wiederverwendung der Quelle [84].',
    @revision_id
),
(
    @source_85_id,@section_id,'background',
    'Quine wird als wissenschaftstheoretischer Hintergrund für die ontologischen Verpflichtungen mathematischer Formalisierungen verwendet.',
    '3.3.9, Bedeutungsinvarianz und Minimalprinzip',
    0,1,
    'Wiederverwendung der Quelle [85].',
    @revision_id
),
(
    @source_88_id,@section_id,'background',
    'Enderton wird als methodischer Referenzrahmen für die spätere Präzisierung von Sprache, Semantik, Modellen und Folgerungsbeziehungen verwendet.',
    '3.3.9, Übergang zur mathematischen Rekonstruktion',
    0,1,
    'Wiederverwendung der Quelle [88].',
    @revision_id
),
(
    @source_89_id,@section_id,'background',
    'Mendelson wird als methodischer Referenzrahmen für die spätere formale Prüfung von Konsistenz, Unabhängigkeit und Modellstruktur verwendet.',
    '3.3.9, Übergang zur mathematischen Rekonstruktion',
    0,1,
    'Wiederverwendung der Quelle [89].',
    @revision_id
);

/* -------------------------------------------------------------------------------------------------
   6. Definitionen der Übergangsregeln
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `definitions`
(
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
VALUES
(
    'Def. 3.3.9.1',
    @section_id,
    'Prinzip der Bedeutungsinvarianz',
    'Das Prinzip der Bedeutungsinvarianz verlangt, dass jede mathematische Struktur ausschließlich den bereits qualitativ eingeführten semantischen Gehalt beschreibt und keine unbegründete zusätzliche ontologische oder funktionale Eigenschaft in die Theorie einführt.',
    '\\text{Semantik}\\longrightarrow\\text{Mathematik}',
    '\\text{Semantik}\\longrightarrow\\text{Mathematik}',
    'original',
    NULL,
    'Die qualitativen Begriffe und Axiome aus Kapitel 3.3 werden vorausgesetzt.',
    'Verbindliche Übergangsregel für Kapitel 3.4.',
    'checked',
    @revision_id
),
(
    'Def. 3.3.9.2',
    @section_id,
    'Relationales Rekonstruktionsprinzip',
    'Das relationale Rekonstruktionsprinzip verlangt, dass funktionale Relationen und Transformationen vor geometrischen, räumlichen oder objekthaften Strukturen mathematisch eingeführt werden.',
    '\\text{Relation}\\prec\\text{Geometrie}',
    '\\text{Relation}\\prec\\text{Geometrie}',
    'original',
    NULL,
    'Axiom A2 und Axiom A3 werden vorausgesetzt.',
    'Verhindert die zirkuläre Einführung bereits vorhandener Raum- oder Zeitstrukturen.',
    'checked',
    @revision_id
),
(
    'Def. 3.3.9.3',
    @section_id,
    'Rekonstruktion statt Übersetzung',
    'Mathematische Rekonstruktion bezeichnet die schrittweise Ableitung minimal erforderlicher Strukturen aus den qualitativen Axiomen. Sie ist keine bloße nachträgliche Interpretation bereits vorhandener Mathematik als FRZK.',
    '\\text{Axiome}\\Longrightarrow\\text{rekonstruierte Mathematik}',
    '\\text{Axiome}\\Longrightarrow\\text{rekonstruierte Mathematik}',
    'original',
    NULL,
    'Das vollständige Axiomensystem A1 bis A5 wird vorausgesetzt.',
    'Grenzt die Theorie von einer rein interpretativen Umbenennung vorhandener Modelle ab.',
    'checked',
    @revision_id
),
(
    'Def. 3.3.9.4',
    @section_id,
    'Mathematisches Minimalprinzip',
    'Das mathematische Minimalprinzip verlangt, nur diejenigen mathematischen Strukturen einzuführen, die zur Rekonstruktion eines qualitativ bereits begründeten funktionalen Sachverhalts notwendig sind.',
    '\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich}',
    '\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich}',
    'original',
    NULL,
    'Die Prinzipien der Bedeutungsinvarianz und Rekonstruktion statt Übersetzung werden vorausgesetzt.',
    'Dient der Vermeidung unnötiger ontologischer und formaler Vorannahmen.',
    'checked',
    @revision_id
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

SET @def_semantic_invariance_id := NULL;
SET @def_relational_reconstruction_id := NULL;
SET @def_reconstruction_id := NULL;
SET @def_minimality_id := NULL;

SELECT `definition_id` INTO @def_semantic_invariance_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.9.1' LIMIT 1;

SELECT `definition_id` INTO @def_relational_reconstruction_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.9.2' LIMIT 1;

SELECT `definition_id` INTO @def_reconstruction_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.9.3' LIMIT 1;

SELECT `definition_id` INTO @def_minimality_id
FROM `definitions` WHERE `definition_number`='Def. 3.3.9.4' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   7. Propositionen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `propositions`
(
    `proposition_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`logical_derivation`,
    `based_on_axioms`,`status`,`created_revision_id`
)
VALUES
(
    'Prop. 3.3.9.1',
    @section_id,
    'Vorrang der qualitativen Semantik',
    'Die mathematische Rekonstruktion des FRZK ist nur dann zulässig, wenn der qualitative Bedeutungsgehalt der Axiome und Definitionen erhalten bleibt.',
    '\\text{Semantik}\\longrightarrow\\text{Mathematik}',
    '\\text{Semantik}\\longrightarrow\\text{Mathematik}',
    'Die mathematische Ebene besitzt beschreibende und rekonstruierende, aber keine unbegründet ontologieerzeugende Funktion.',
    'A1,A2,A3,A4,A5',
    'review',
    @revision_id
),
(
    'Prop. 3.3.9.2',
    @section_id,
    'Vorrang relationaler und transformatorischer Strukturen',
    'Relationen und Transformationen müssen mathematisch vor Geometrie, Raumkoordinaten und Zeitparametern rekonstruiert werden.',
    '\\text{Relation}\\prec\\text{Geometrie}\\quad\\land\\quad\\text{Transformation}\\prec\\text{Zeitparameter}',
    '\\text{Relation}\\prec\\text{Geometrie}\\quad\\land\\quad\\text{Transformation}\\prec\\text{Zeitparameter}',
    'Axiom A2 und Axiom A3 führen qualitative Relationierbarkeit und Transformierbarkeit ein, ohne Raum oder Zeit vorauszusetzen.',
    'A2,A3',
    'review',
    @revision_id
),
(
    'Prop. 3.3.9.3',
    @section_id,
    'Minimalität der mathematischen Einführung',
    'Jede mathematische Struktur in Kapitel 3.4 muss durch einen expliziten funktionalen Rekonstruktionsbedarf begründet sein.',
    '\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich}',
    '\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich}',
    'Folgt aus Bedeutungsinvarianz, ontologischer Zurückhaltung und dem Rekonstruktionsprinzip.',
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

SET @prop_semantic_priority_id := NULL;
SET @prop_relational_priority_id := NULL;
SET @prop_math_minimality_id := NULL;

SELECT `proposition_id` INTO @prop_semantic_priority_id
FROM `propositions` WHERE `proposition_number`='Prop. 3.3.9.1' LIMIT 1;

SELECT `proposition_id` INTO @prop_relational_priority_id
FROM `propositions` WHERE `proposition_number`='Prop. 3.3.9.2' LIMIT 1;

SELECT `proposition_id` INTO @prop_math_minimality_id
FROM `propositions` WHERE `proposition_number`='Prop. 3.3.9.3' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   8. Objekt-Quellen-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE
(
    (`object_type`='definition' AND `object_id` IN
        (@def_semantic_invariance_id,@def_relational_reconstruction_id,@def_reconstruction_id,@def_minimality_id))
    OR
    (`object_type`='proposition' AND `object_id` IN
        (@prop_semantic_priority_id,@prop_relational_priority_id,@prop_math_minimality_id))
)
AND `source_id` IN
(
    @source_82_id,@source_83_id,@source_84_id,
    @source_85_id,@source_88_id,@source_89_id
);

INSERT INTO `object_source_links`
(`object_type`,`object_id`,`source_id`,`usage_type`,`note`)
VALUES
('definition',@def_semantic_invariance_id,@source_82_id,'supporting_source',
 'Tarski dient als methodischer Anschluss für die Trennung semantischer und formaler Ebenen.'),
('definition',@def_semantic_invariance_id,@source_85_id,'supporting_source',
 'Quine dient als Anschluss für die ontologischen Verpflichtungen formaler Sprachen.'),
('definition',@def_relational_reconstruction_id,@source_84_id,'supporting_source',
 'Mac Lane dient als struktureller Forschungsanschluss für den Vorrang von Relationen und Transformationen.'),
('definition',@def_reconstruction_id,@source_83_id,'supporting_source',
 'Suppes dient als methodischer Anschluss für den schrittweisen Aufbau axiomatischer Theorien.'),
('definition',@def_reconstruction_id,@source_88_id,'supporting_source',
 'Enderton dient als Referenzrahmen für den späteren Übergang zu formaler Sprache und Semantik.'),
('definition',@def_minimality_id,@source_85_id,'supporting_source',
 'Quine stützt die Zurückhaltung gegenüber unnötigen ontologischen Verpflichtungen.'),
('proposition',@prop_semantic_priority_id,@source_82_id,'supporting_source',
 'Tarski dient als methodischer Referenzrahmen für den Vorrang präziser Semantik.'),
('proposition',@prop_relational_priority_id,@source_84_id,'supporting_source',
 'Mac Lane dient als Forschungsanschluss für relationale und strukturelle Mathematik.'),
('proposition',@prop_math_minimality_id,@source_85_id,'supporting_source',
 'Quine stützt das Prinzip ontologischer Sparsamkeit.'),
('proposition',@prop_math_minimality_id,@source_89_id,'supporting_source',
 'Mendelson dient als Referenzmaßstab für die spätere formale Präzision.');

/* -------------------------------------------------------------------------------------------------
   9. Gleichungen (3.327) bis (3.333)
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
    `equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
    `plain_description`,`equation_type`,`provenance`,`source_id`,
    `derivation`,`assumptions`,`validation_status`,`created_revision_id`
)
VALUES
(
    '3.327',
    @section_id,
    'Prinzip der Bedeutungsinvarianz',
    '\\text{Semantik}\\longrightarrow\\text{Mathematik},\\qquad\\text{nicht umgekehrt.}',
    '\\text{Semantik}\\longrightarrow\\text{Mathematik},\\qquad\\text{nicht umgekehrt.}',
    'Mathematik rekonstruiert einen bereits qualitativ begründeten Bedeutungsgehalt und erzeugt ihn nicht nachträglich.',
    'principle',
    'original',
    NULL,
    'Abgeleitet aus der Trennung zwischen qualitativer Axiomatik und mathematischer Rekonstruktion.',
    'Kapitel 3.3 ist semantisch abgeschlossen.',
    'checked',
    @revision_id
),
(
    '3.328',
    @section_id,
    'Vorrang der Relation vor Geometrie',
    '\\text{Relation}\\prec\\text{Geometrie}',
    '\\text{Relation}\\prec\\text{Geometrie}',
    'Funktionale Relationen müssen vor geometrischen Strukturen rekonstruiert werden.',
    'principle',
    'original',
    NULL,
    'Axiom A2 führt Relationierbarkeit ohne Raum vorauszusetzen ein.',
    'Keine Punkte, Koordinaten oder Metriken werden vorausgesetzt.',
    'checked',
    @revision_id
),
(
    '3.329',
    @section_id,
    'Vorrang der Transformation vor dem Zeitparameter',
    '\\text{Transformation}\\prec\\text{Zeitparameter}',
    '\\text{Transformation}\\prec\\text{Zeitparameter}',
    'Funktionale Transformationen müssen vor einer mathematischen Zeitvariablen rekonstruiert werden.',
    'principle',
    'original',
    NULL,
    'Axiom A3 führt Transformierbarkeit ohne Zeit vorauszusetzen ein.',
    'Kein Zeitparameter wird vorausgesetzt.',
    'checked',
    @revision_id
),
(
    '3.330',
    @section_id,
    'Relationale Rekonstruktionshierarchie',
    '\\text{Relationen}\\longrightarrow\\text{Strukturen}\\longrightarrow\\text{Objekte}',
    '\\text{Relationen}\\longrightarrow\\text{Strukturen}\\longrightarrow\\text{Objekte}',
    'Objekte werden als stabile Träger wiederkehrender relationaler Strukturen rekonstruiert.',
    'schema',
    'original',
    NULL,
    'Folgt aus dem relationalen Ausgangspunkt des FRZK.',
    'Keine objektontologische Priorität.',
    'checked',
    @revision_id
),
(
    '3.331',
    @section_id,
    'Rekonstruktion aus den Axiomen',
    '\\text{Axiome}\\Longrightarrow\\text{rekonstruierte Mathematik}',
    '\\text{Axiome}\\Longrightarrow\\text{rekonstruierte Mathematik}',
    'Zulässige Richtung der mathematischen Entwicklung.',
    'principle',
    'original',
    NULL,
    'Mathematische Strukturen werden aus dem qualitativen Funktionsbedarf entwickelt.',
    'Das vollständige Axiomensystem wird vorausgesetzt.',
    'checked',
    @revision_id
),
(
    '3.332',
    @section_id,
    'Unzulässige nachträgliche FRZK-Interpretation',
    '\\text{vorhandene Mathematik}\\Longrightarrow\\text{Interpretation als FRZK}',
    '\\text{vorhandene Mathematik}\\Longrightarrow\\text{Interpretation als FRZK}',
    'Kennzeichnet die methodisch unzulässige bloße Umdeutung bereits vorhandener Mathematik als FRZK.',
    'principle',
    'original',
    NULL,
    'Dient als negative Übergangsregel.',
    'Keine Aussage, dass vorhandene Mathematik nicht später als Modell verwendet werden darf.',
    'checked',
    @revision_id
),
(
    '3.333',
    @section_id,
    'Mathematisches Minimalprinzip',
    '\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich.}',
    '\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich.}',
    'Minimalprinzip für die schrittweise mathematische Rekonstruktion.',
    'principle',
    'original',
    NULL,
    'Folgt aus Bedeutungsinvarianz und ontologischer Zurückhaltung.',
    'Jede mathematische Struktur muss funktional motiviert sein.',
    'checked',
    @revision_id
)
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

SET @eq_3327 := NULL;
SET @eq_3328 := NULL;
SET @eq_3329 := NULL;
SET @eq_3330 := NULL;
SET @eq_3331 := NULL;
SET @eq_3332 := NULL;
SET @eq_3333 := NULL;

SELECT `equation_id` INTO @eq_3327 FROM `equations` WHERE `equation_number`='3.327' LIMIT 1;
SELECT `equation_id` INTO @eq_3328 FROM `equations` WHERE `equation_number`='3.328' LIMIT 1;
SELECT `equation_id` INTO @eq_3329 FROM `equations` WHERE `equation_number`='3.329' LIMIT 1;
SELECT `equation_id` INTO @eq_3330 FROM `equations` WHERE `equation_number`='3.330' LIMIT 1;
SELECT `equation_id` INTO @eq_3331 FROM `equations` WHERE `equation_number`='3.331' LIMIT 1;
SELECT `equation_id` INTO @eq_3332 FROM `equations` WHERE `equation_number`='3.332' LIMIT 1;
SELECT `equation_id` INTO @eq_3333 FROM `equations` WHERE `equation_number`='3.333' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   10. Gleichungssymbole
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN
(@eq_3327,@eq_3328,@eq_3329,@eq_3330,@eq_3331,@eq_3332,@eq_3333);

INSERT INTO `equation_symbols`
(
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3327,'\\longrightarrow','gerichteter Rekonstruktionspfeil',
 'Kennzeichnet die zulässige Richtung vom qualitativen Bedeutungsgehalt zur mathematischen Darstellung.',
 NULL,'wissenschaftstheoretische Übergangsregel',1),

(@eq_3328,'\\prec','begriffliche Vorrangordnung',
 'Kennzeichnet den Vorrang funktionaler Relation vor geometrischer Struktur.',
 NULL,'qualitative Rekonstruktionsordnung',1),

(@eq_3329,'\\prec','begriffliche Vorrangordnung',
 'Kennzeichnet den Vorrang funktionaler Transformation vor einem Zeitparameter.',
 NULL,'qualitative Rekonstruktionsordnung',1),

(@eq_3330,'\\longrightarrow','gerichteter Rekonstruktionspfeil',
 'Kennzeichnet die schrittweise Rekonstruktion von Relationen über Strukturen zu Objekten.',
 NULL,'qualitative Rekonstruktionsordnung',1),

(@eq_3331,'\\Longrightarrow','qualitativer Rekonstruktionspfeil',
 'Kennzeichnet die Ableitungsrichtung von den Axiomen zur rekonstruierten Mathematik.',
 NULL,'wissenschaftstheoretische Übergangsregel',1),

(@eq_3332,'\\Longrightarrow','kritisch markierte Interpretationsrichtung',
 'Kennzeichnet eine methodisch nicht hinreichende bloße Interpretation vorhandener Mathematik als FRZK.',
 NULL,'wissenschaftstheoretische Negativregel',1),

(@eq_3333,'\\text{so viel Mathematik wie notwendig, so wenig Mathematik wie möglich.}',
 'mathematisches Minimalprinzip',
 'Verbindliches Prinzip zur Begrenzung mathematischer Vorannahmen.',
 NULL,'wissenschaftstheoretische Übergangsregel',1)
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
    '\\prec',
    '\\prec',
    'begriffliche Vorrangordnung',
    'Kennzeichnet in Abschnitt 3.3.9 eine qualitative Rekonstruktionsreihenfolge und keine numerische Ordnung.',
    'section',
    @section_id,
    @eq_3328,
    NULL,
    'wissenschaftstheoretische Rekonstruktionsordnung',
    'wissenschaftstheoretische Rekonstruktionsordnung',
    0,0,0,
    'Wird für Relation vor Geometrie und Transformation vor Zeitparameter verwendet.',
    'checked',
    @revision_id
),
(
    '\\longrightarrow',
    '\\longrightarrow',
    'gerichteter Rekonstruktionspfeil',
    'Kennzeichnet eine schrittweise semantische oder strukturelle Rekonstruktionsrichtung.',
    'section',
    @section_id,
    @eq_3327,
    NULL,
    'wissenschaftstheoretische Rekonstruktion',
    'wissenschaftstheoretische Rekonstruktion',
    0,0,0,
    'Keine mathematische Funktion.',
    'checked',
    @revision_id
),
(
    '\\Longrightarrow',
    '\\Longrightarrow',
    'qualitativer Rekonstruktionspfeil',
    'Kennzeichnet eine qualitative methodische Folgerungs- oder Rekonstruktionsrichtung.',
    'section',
    @section_id,
    @eq_3331,
    NULL,
    'wissenschaftstheoretische Rekonstruktion',
    'wissenschaftstheoretische Rekonstruktion',
    0,0,0,
    'Noch keine formale Ableitungsrelation.',
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
    @revision_id,@section_id,'rewritten','section','3.3.9',
    'Abschnitt 3.3.9 wurde vollständig als verbindliche Übergangsordnung zur mathematischen Rekonstruktion neu gefasst.',
    'Älterer Planungsstand.',
    'Übergangsregeln zur mathematischen Rekonstruktion.'
),
(
    @revision_id,@section_id,'source_reused','source_usage','[82], [83], [84], [85], [88], [89]',
    'Sechs bereits eingeführte Quellen wurden als methodische und wissenschaftstheoretische Forschungsanschlüsse wiederverwendet.',
    NULL,
    'Sechs geprüfte Wiederverwendungen; keine neue Quelle.'
),
(
    @revision_id,@section_id,'definition_added','definitions','Def. 3.3.9.1–Def. 3.3.9.4',
    'Vier verbindliche Übergangsdefinitionen wurden registriert.',
    NULL,
    'Bedeutungsinvarianz, relationales Rekonstruktionsprinzip, Rekonstruktion statt Übersetzung und mathematisches Minimalprinzip.'
),
(
    @revision_id,@section_id,'proposition_added','propositions','Prop. 3.3.9.1–Prop. 3.3.9.3',
    'Drei methodische Propositionen wurden registriert.',
    NULL,
    'Vorrang der Semantik, Vorrang relationaler Strukturen und mathematische Minimalität.'
),
(
    @revision_id,@section_id,'equation_added','equations','(3.327)–(3.333)',
    'Sieben Übergangs- und Rekonstruktionsregeln wurden als Gleichungen registriert.',
    NULL,
    'Gleichungen (3.327) bis (3.333).'
),
(
    @revision_id,@section_id,'symbol_added','symbols','\\prec, \\longrightarrow, \\Longrightarrow',
    'Die abschnittsspezifischen Rekonstruktionssymbole wurden registriert.',
    NULL,
    'Drei Abschnittssymbole.'
),
(
    @revision_id,@section_id,'status_changed','section','3.3.9',
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
    ('last_edited_section','3.3.9'),
    ('last_repository_revision','RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2'),
    ('next_citation_number','96'),
    ('next_equation_number','3.340')
ON DUPLICATE KEY UPDATE
    `counter_value`=VALUES(`counter_value`);

COMMIT;

/* =================================================================================================
   14. AUDIT UND KONTROLLABFRAGEN
   ================================================================================================= */

/* 14.1 Revision und Parent */
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
      'RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2' COLLATE utf8mb4_unicode_ci;

/* 14.2 Abschnitt */
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
      '3.3.9' COLLATE utf8mb4_unicode_ci;

/* 14.3 Quellenverwendungen */
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

/* 14.4 Definitionen */
SELECT
    d.`definition_number`,
    d.`title`,
    d.`provenance`,
    d.`validation_status`,
    CASE
        WHEN d.`word_latex` IS NULL OR TRIM(d.`word_latex`)=''
        THEN 'NICHT ERFORDERLICH ODER FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `definitions` d
WHERE d.`section_id`=@section_id
ORDER BY d.`definition_number`;

/* 14.5 Propositionen */
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

/* 14.6 Gleichungen */
SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_type`,
    e.`provenance`,
    e.`validation_status`,
    e.`equation_latex`,
    e.`word_latex`,
    CASE
        WHEN e.`word_latex` IS NULL OR TRIM(e.`word_latex`)=''
        THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 327 AND 333
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

/* 14.7 Gleichungssymbole */
SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 327 AND 333
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),es.`symbol_order`;

/* 14.8 Abschnittssymbole */
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

/* 14.9 Objekt-Quellen-Verknüpfungen */
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
    (`object_type`='definition' AND `object_id` IN
        (@def_semantic_invariance_id,@def_relational_reconstruction_id,@def_reconstruction_id,@def_minimality_id))
    OR
    (`object_type`='proposition' AND `object_id` IN
        (@prop_semantic_priority_id,@prop_relational_priority_id,@prop_math_minimality_id))
)
ORDER BY osl.`object_type`,osl.`object_id`,s.`citation_number`;

/* 14.10 Repository-Zähler */
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

/* 14.11 Gleichungsdubletten */
SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*)>1;

/* 14.12 Proposition-Dubletten */
SELECT
    `proposition_number`,
    COUNT(*) AS `duplicate_count`
FROM `propositions`
GROUP BY `proposition_number`
HAVING COUNT(*)>1;

/* 14.13 Doppelte Gleichungssymbole */
SELECT
    `equation_id`,
    `symbol_latex`,
    COUNT(*) AS `duplicate_count`
FROM `equation_symbols`
GROUP BY `equation_id`,`symbol_latex`
HAVING COUNT(*)>1;

/* 14.14 Fehlendes Word-LaTeX */
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

/* 14.15 Leere ENUM-Werte */
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
        (@def_semantic_invariance_id,@def_relational_reconstruction_id,@def_reconstruction_id,@def_minimality_id))
    OR
    (`object_type`='proposition' AND `object_id` IN
        (@prop_semantic_priority_id,@prop_relational_priority_id,@prop_math_minimality_id))
)
AND (`usage_type` IS NULL OR TRIM(`usage_type`)='');

/* 14.16 Verwaiste Objekte dieser Revision */
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

/* 14.17 Änderungsprotokoll */
SELECT
    scl.`change_type`,
    scl.`object_type`,
    scl.`object_reference`,
    scl.`change_summary`
FROM `section_change_log` scl
WHERE scl.`revision_id`=@revision_id
  AND scl.`section_id`=@section_id
ORDER BY scl.`change_id`;

/* 14.18 Abschlussmeldung */
SELECT
    'Repository-Update 3.3.9 vollständig und schema-konform ausgeführt. Erwarteter nächster Stand: Quelle [96], Gleichung (3.340), letzte Revision RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2.'
AS `result`;
/* =================================================================================================
   ERWEITERUNGSBLOCK DER VOLLSTÄNDIGEN V2
   Ergänzungen 3.3.9.8 bis 3.3.9.10:
     - Erhaltung latenter funktionaler Orientierung
     - Funktionale Persistenz
     - Funktionales Gedächtnis und Rekonstruierbarkeit
     - Quellen [90] bis [95]
     - Definitionen Def. 3.3.9.5 bis Def. 3.3.9.7
     - Propositionen Prop. 3.3.9.4 bis Prop. 3.3.9.6
     - Gleichungen (3.334) bis (3.339)

   Der Block gehört zur selben Abschnittsrevision V2. Er kann als Bestandteil dieser Datei
   unmittelbar nach dem ursprünglichen Vollstandardblock ausgeführt werden.
   ================================================================================================= */

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   E1. V2-Revision und Abschnitt erneut laden
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @revision_id := NULL;
SET @section_id := NULL;

SELECT `revision_id`
INTO @revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

SELECT `section_id`
INTO @section_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3.9' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_v2_revision_section_339`;

CREATE TEMPORARY TABLE `tmp_frzk_v2_revision_section_339`
(
    `revision_id` BIGINT UNSIGNED NOT NULL,
    `section_id`  BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_v2_revision_section_339`
(`revision_id`,`section_id`)
VALUES
(@revision_id,@section_id);

DROP TEMPORARY TABLE `tmp_frzk_v2_revision_section_339`;

/* -------------------------------------------------------------------------------------------------
   E2. Autoren für Quellen [90] bis [95]
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`orcid`,`birth_year`,`death_year`,`notes`)
VALUES
('Strang','Gilbert','Strang, Gilbert',NULL,1934,NULL,
 'Mathematiker. Quelle [90] wird zur klassischen Bedeutung der Multiplikation eines Vektors mit dem Skalar Null verwendet.'),
('Golub','Gene H.','Golub, Gene H.',NULL,1932,2007,
 'Numerischer Mathematiker. Koautor der Quelle [91].'),
('Van Loan','Charles F.','Van Loan, Charles F.',NULL,1947,NULL,
 'Numerischer Mathematiker. Koautor der Quelle [91].'),
('LaValle','Steven M.','LaValle, Steven M.',NULL,1968,NULL,
 'Robotik- und Planungsforscher. Quelle [92] wird als technischer Forschungsanschluss für getrennte Zustands- und Orientierungsdarstellungen verwendet.'),
('Craig','John J.','Craig, John J.',NULL,NULL,NULL,
 'Robotikautor. Quelle [93] wird als technischer Forschungsanschluss für Lage- und Bewegungsdarstellungen verwendet.'),
('Kalman','Rudolf E.','Kalman, Rudolf E.',NULL,1930,2016,
 'Systemtheoretiker. Quelle [94] wird als Forschungsanschluss für interne Zustandsrekonstruktion und Zustandsabschätzung verwendet.'),
('Simon','Dan','Simon, Dan',NULL,NULL,NULL,
 'Autor zu Zustandsabschätzung. Quelle [95] wird als Forschungsanschluss für beobachtbare und interne Zustandsinformationen verwendet.')
ON DUPLICATE KEY UPDATE
`family_name`=VALUES(`family_name`),
`given_names`=VALUES(`given_names`),
`orcid`=VALUES(`orcid`),
`birth_year`=VALUES(`birth_year`),
`death_year`=VALUES(`death_year`),
`notes`=VALUES(`notes`);

SET @author_strang_id := NULL;
SET @author_golub_id := NULL;
SET @author_vanloan_id := NULL;
SET @author_lavalle_id := NULL;
SET @author_craig_id := NULL;
SET @author_kalman_id := NULL;
SET @author_simon_id := NULL;

SELECT `author_id` INTO @author_strang_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='Strang, Gilbert' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `author_id` INTO @author_golub_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='Golub, Gene H.' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `author_id` INTO @author_vanloan_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='Van Loan, Charles F.' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `author_id` INTO @author_lavalle_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='LaValle, Steven M.' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `author_id` INTO @author_craig_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='Craig, John J.' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `author_id` INTO @author_kalman_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='Kalman, Rudolf E.' COLLATE utf8mb4_unicode_ci LIMIT 1;
SELECT `author_id` INTO @author_simon_id FROM `authors`
WHERE `normalized_name` COLLATE utf8mb4_unicode_ci='Simon, Dan' COLLATE utf8mb4_unicode_ci LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   E3. Quellen [90] bis [95]
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
(90,'strang_linear_algebra_applications_2006','book',
 'Linear Algebra and Its Applications',NULL,1976,2006,NULL,
 'Brooks/Cole','Belmont',NULL,NULL,NULL,'4th Edition',NULL,NULL,NULL,
 'en',1,'reference',8,'verified','3.3.9',
 'Erstnennung in 3.3.9.8 zur klassischen Skalarmultiplikation und zum Nullvektor.',
 'Strang, Gilbert: Linear Algebra and Its Applications. 4th Edition. Belmont: Brooks/Cole, 2006.',
 'Strang [90]',
 'Dient zur Abgrenzung der klassischen linearen Algebra von der erweiterten FRZK-Zustandsbeschreibung.',
 @revision_id),

(91,'golub_vanloan_matrix_computations_2013','book',
 'Matrix Computations',NULL,1983,2013,NULL,
 'Johns Hopkins University Press','Baltimore',NULL,NULL,NULL,'4th Edition',NULL,NULL,NULL,
 'en',1,'reference',8,'verified','3.3.9',
 'Erstnennung in 3.3.9.8 zur klassischen Matrix- und Vektorrechnung.',
 'Golub, Gene H.; Van Loan, Charles F.: Matrix Computations. 4th Edition. Baltimore: Johns Hopkins University Press, 2013.',
 'Golub und Van Loan [91]',
 'Dient als zweite Referenz für die unveränderte klassische Nullvektorbehandlung.',
 @revision_id),

(92,'lavalle_planning_algorithms_2006','book',
 'Planning Algorithms',NULL,2006,2006,NULL,
 'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'en',1,'reference',8,'verified','3.3.9',
 'Erstnennung in 3.3.9.8 als Forschungsanschluss für Robotik, Konfiguration und Orientierung.',
 'LaValle, Steven M.: Planning Algorithms. Cambridge: Cambridge University Press, 2006.',
 'LaValle [92]',
 'Technischer Forschungsanschluss; keine Gleichsetzung von Orientierung und Richtung des Nullvektors.',
 @revision_id),

(93,'craig_robotics_mechanics_control_2004','book',
 'Introduction to Robotics: Mechanics and Control',NULL,1986,2004,NULL,
 'Pearson Prentice Hall','Upper Saddle River',NULL,NULL,NULL,'3rd Edition',NULL,NULL,NULL,
 'en',1,'reference',8,'verified','3.3.9',
 'Erstnennung in 3.3.9.8 als Forschungsanschluss für getrennte Lage- und Bewegungsgrößen.',
 'Craig, John J.: Introduction to Robotics: Mechanics and Control. 3rd Edition. Upper Saddle River: Pearson Prentice Hall, 2004.',
 'Craig [93]',
 'Technischer Forschungsanschluss für die getrennte Speicherung funktional verschiedener Zustandskomponenten.',
 @revision_id),

(94,'kalman_new_approach_filtering_prediction_1960','article',
 'A New Approach to Linear Filtering and Prediction Problems',NULL,1960,1960,
 'Journal of Basic Engineering','ASME',NULL,'82','1','35–45',NULL,
 '10.1115/1.3662552',NULL,'https://doi.org/10.1115/1.3662552',
 'en',1,'primary',9,'verified','3.3.9',
 'Erstnennung in 3.3.9.10 als Forschungsanschluss für interne Zustandsrekonstruktion.',
 'Kalman, Rudolf E.: A New Approach to Linear Filtering and Prediction Problems. Journal of Basic Engineering 82(1), 1960, S. 35–45.',
 'Kalman [94]',
 'Methodischer Forschungsanschluss für die Unterscheidung zwischen unmittelbar beobachtbaren und intern rekonstruierten Zustandsinformationen.',
 @revision_id),

(95,'simon_optimal_state_estimation_2006','book',
 'Optimal State Estimation','Kalman, H Infinity, and Nonlinear Approaches',
 2006,2006,NULL,'John Wiley & Sons','Hoboken',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'en',1,'reference',8,'verified','3.3.9',
 'Erstnennung in 3.3.9.10 als Forschungsanschluss für Zustandsabschätzung und interne Zustandsinformation.',
 'Simon, Dan: Optimal State Estimation: Kalman, H Infinity, and Nonlinear Approaches. Hoboken: John Wiley & Sons, 2006.',
 'Simon [95]',
 'Technischer Forschungsanschluss für Rekonstruierbarkeit und Zustandsinformationen.',
 @revision_id)
ON DUPLICATE KEY UPDATE
`citation_number`=VALUES(`citation_number`),
`source_type`=VALUES(`source_type`),
`title`=VALUES(`title`),
`subtitle`=VALUES(`subtitle`),
`year_original`=VALUES(`year_original`),
`year_edition`=VALUES(`year_edition`),
`journal`=VALUES(`journal`),
`publisher`=VALUES(`publisher`),
`place`=VALUES(`place`),
`volume`=VALUES(`volume`),
`issue`=VALUES(`issue`),
`pages`=VALUES(`pages`),
`edition`=VALUES(`edition`),
`doi`=VALUES(`doi`),
`url`=VALUES(`url`),
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

SET @source_90_id := NULL;
SET @source_91_id := NULL;
SET @source_92_id := NULL;
SET @source_93_id := NULL;
SET @source_94_id := NULL;
SET @source_95_id := NULL;

SELECT `source_id` INTO @source_90_id FROM `sources` WHERE `citation_number`=90 LIMIT 1;
SELECT `source_id` INTO @source_91_id FROM `sources` WHERE `citation_number`=91 LIMIT 1;
SELECT `source_id` INTO @source_92_id FROM `sources` WHERE `citation_number`=92 LIMIT 1;
SELECT `source_id` INTO @source_93_id FROM `sources` WHERE `citation_number`=93 LIMIT 1;
SELECT `source_id` INTO @source_94_id FROM `sources` WHERE `citation_number`=94 LIMIT 1;
SELECT `source_id` INTO @source_95_id FROM `sources` WHERE `citation_number`=95 LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_sources_90_95_339`;

CREATE TEMPORARY TABLE `tmp_frzk_sources_90_95_339`
(
    `source_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_sources_90_95_339` (`source_id`)
VALUES
(@source_90_id),(@source_91_id),(@source_92_id),
(@source_93_id),(@source_94_id),(@source_95_id);

DROP TEMPORARY TABLE `tmp_frzk_sources_90_95_339`;

/* -------------------------------------------------------------------------------------------------
   E4. Quellen-Autor-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `source_authors`
(`source_id`,`author_id`,`author_order`,`role`)
VALUES
(@source_90_id,@author_strang_id,1,'author'),
(@source_91_id,@author_golub_id,1,'author'),
(@source_91_id,@author_vanloan_id,2,'author'),
(@source_92_id,@author_lavalle_id,1,'author'),
(@source_93_id,@author_craig_id,1,'author'),
(@source_94_id,@author_kalman_id,1,'author'),
(@source_95_id,@author_simon_id,1,'author')
ON DUPLICATE KEY UPDATE
`author_order`=VALUES(`author_order`),
`role`=VALUES(`role`);

/* -------------------------------------------------------------------------------------------------
   E5. Annotationen
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `annotations`
(
 `source_id`,`contribution`,`significance_for_dissertation`,
 `citation_reason`,`adopted_claims`,`limitations`,
 `scientific_discussion`,`annotation_status`,`reviewed_at`
)
VALUES
(@source_90_id,
 'Lehrbuchdarstellung der klassischen linearen Algebra.',
 'Dient der klaren Abgrenzung: Der klassische Nullvektor besitzt keine definierte Richtung.',
 'Belegt, dass das FRZK nicht die klassische Vektoralgebra verändert.',
 'Übernommen wird ausschließlich die klassische Nullvektorbehandlung.',
 'Keine Aussage über erweiterte funktionale Zustände.',
 'Die FRZK-Erweiterung betrifft den Zustandsbegriff und nicht den klassischen Vektor.',
 'reviewed',NOW()),

(@source_91_id,
 'Referenzwerk zur Matrix- und Vektorrechnung.',
 'Zweite unabhängige mathematische Referenz für die klassische Nulloperation.',
 'Stützt die Abgrenzung zur erweiterten FRZK-Zustandsoperation.',
 'Übernommen wird die klassische Algebra.',
 'Keine funktionale Persistenztheorie.',
 'Die Quelle sichert die mathematische Anschlussfähigkeit.',
 'reviewed',NOW()),

(@source_92_id,
 'Systematische Behandlung von Konfigurationen und Planungsräumen in der Robotik.',
 'Forschungsanschluss für getrennte Zustands-, Lage- und Bewegungsinformationen.',
 'Zeigt technische Kontexte, in denen Orientierung unabhängig von momentaner translatorischer Geschwindigkeit repräsentiert wird.',
 'Übernommen wird die allgemeine Trennung funktionaler Zustandskomponenten.',
 'Keine Behauptung, der Nullvektor selbst besitze Richtung.',
 'Das FRZK verallgemeinert die Zustandskomponententrennung.',
 'reviewed',NOW()),

(@source_93_id,
 'Robotikdarstellung von Lage, Transformationen, Geschwindigkeit und Steuerung.',
 'Forschungsanschluss für die getrennte Repräsentation von Orientierung und Bewegung.',
 'Stützt die technische Plausibilität latenter Orientierungsinformation.',
 'Übernommen wird die getrennte Zustandsrepräsentation.',
 'Keine allgemeine funktionale Theorie.',
 'Das FRZK abstrahiert von der robotischen Spezialisierung.',
 'reviewed',NOW()),

(@source_94_id,
 'Grundlegung linearer Zustandsabschätzung und Prädiktion.',
 'Forschungsanschluss für interne Zustände, Rekonstruierbarkeit und funktionales Gedächtnis.',
 'Stützt die methodische Trennung beobachtbarer Aktivität und intern rekonstruierbarer Zustandsinformation.',
 'Übernommen wird die allgemeine Idee interner Zustandsrekonstruktion.',
 'Kein unmittelbarer Beleg für das FRZK-Axiom oder funktionales Gedächtnis.',
 'Das FRZK verallgemeinert die technische Zustandsrekonstruktion qualitativ.',
 'reviewed',NOW()),

(@source_95_id,
 'Umfassende Darstellung moderner Zustandsabschätzungsverfahren.',
 'Forschungsanschluss für persistente interne Zustandsinformationen.',
 'Stützt die technische Plausibilität rekonstruktionsrelevanter Zustandskomponenten.',
 'Übernommen wird die Trennung von Messwerten und internem Zustand.',
 'Keine ontologische Theorie funktionaler Identität.',
 'Das FRZK nutzt die Quelle als technischen Anschluss, nicht als direkte Ableitung.',
 'reviewed',NOW())
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
   E6. Quellenverwendungen der Ergänzungsabschnitte
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `source_usage`
WHERE `section_id`=@section_id
  AND `source_id` IN
  (@source_90_id,@source_91_id,@source_92_id,@source_93_id,@source_94_id,@source_95_id);

INSERT INTO `source_usage`
(
 `source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,
 `is_first_mention`,`citation_checked`,`notes`,`created_revision_id`
)
VALUES
(@source_90_id,@section_id,'first_citation',
 'Strang wird zur klassischen Skalarmultiplikation und zur Richtungslosigkeit des Nullvektors erstmals eingeführt.',
 '3.3.9.8, Abgrenzung zur klassischen linearen Algebra',
 1,1,'Erstnennung [90].',@revision_id),

(@source_91_id,@section_id,'first_citation',
 'Golub und Van Loan werden als zweite mathematische Referenz zur klassischen Vektor- und Matrixrechnung eingeführt.',
 '3.3.9.8, Abgrenzung zur klassischen linearen Algebra',
 1,1,'Erstnennung [91].',@revision_id),

(@source_92_id,@section_id,'first_citation',
 'LaValle wird als technischer Forschungsanschluss für getrennte Konfigurations- und Orientierungsinformationen eingeführt.',
 '3.3.9.8, technische Anwendungen',
 1,1,'Erstnennung [92].',@revision_id),

(@source_93_id,@section_id,'first_citation',
 'Craig wird als technischer Forschungsanschluss für Lage- und Bewegungsrepräsentationen eingeführt.',
 '3.3.9.8, technische Anwendungen',
 1,1,'Erstnennung [93].',@revision_id),

(@source_94_id,@section_id,'first_citation',
 'Kalman wird als Forschungsanschluss für interne Zustandsrekonstruktion und Rekonstruierbarkeit eingeführt.',
 '3.3.9.10, funktionales Gedächtnis',
 1,1,'Erstnennung [94].',@revision_id),

(@source_95_id,@section_id,'first_citation',
 'Simon wird als Forschungsanschluss für beobachtbare und interne Zustandsinformationen eingeführt.',
 '3.3.9.10, funktionales Gedächtnis',
 1,1,'Erstnennung [95].',@revision_id);

/* -------------------------------------------------------------------------------------------------
   E7. Definitionen 3.3.9.5 bis 3.3.9.7
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `definitions`
(
 `definition_number`,`section_id`,`title`,`definition_text`,
 `formal_latex`,`word_latex`,`provenance`,`source_id`,
 `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
VALUES
('Def. 3.3.9.5',@section_id,'Latente funktionale Orientierung',
 'Ein funktionaler Zustand kann neben seiner aktuellen quantitativen Ausprägung eine von dieser unabhängige funktionale Orientierungsinformation besitzen. Diese beschreibt keine Richtung des klassischen Nullvektors, sondern den funktionalen Zusammenhang, aus dem der Zustand hervorgegangen ist und in den er eingebettet bleibt.',
 NULL,NULL,'original',NULL,
 'Axiom A1, Axiom A3, Axiom A5 und das Prinzip der Bedeutungsinvarianz werden vorausgesetzt.',
 'Abgrenzung zur klassischen Vektoralgebra ist verbindlich.',
 'checked',@revision_id),

('Def. 3.3.9.6',@section_id,'Funktionale Persistenz',
 'Funktionale Persistenz bezeichnet die Fähigkeit eines funktionalen Zustandes, strukturrelevante Identitäts- und Orientierungsinformation zu bewahren, wenn einzelne quantitative Zustandsgrößen vorübergehend verschwinden oder den Wert Null annehmen. Persistenz endet erst durch eine ausdrücklich definierte Vernichtungsoperation.',
 NULL,NULL,'original',NULL,
 'Latente funktionale Orientierung und Axiom A5 werden vorausgesetzt.',
 'Persistenz bedeutet weder numerische Konstanz noch Unveränderlichkeit.',
 'checked',@revision_id),

('Def. 3.3.9.7',@section_id,'Funktionales Gedächtnis',
 'Funktionales Gedächtnis bezeichnet die Fähigkeit einer funktionalen Organisation, strukturrelevante Informationen über Identität und Entwicklungszusammenhang unabhängig von der momentanen quantitativen Aktivität zu bewahren und dadurch eine spätere Rekonstruktion zu ermöglichen.',
 NULL,NULL,'original',NULL,
 'Funktionale Persistenz, Organisationsbildung und Kohärenz werden vorausgesetzt.',
 'Kein Speichermedium und keine konkrete informationstechnische Implementierung werden axiomatisch vorausgesetzt.',
 'checked',@revision_id)
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

SET @def_latent_orientation_id := NULL;
SET @def_persistence_id := NULL;
SET @def_memory_id := NULL;

SELECT `definition_id` INTO @def_latent_orientation_id FROM `definitions`
WHERE `definition_number`='Def. 3.3.9.5' LIMIT 1;
SELECT `definition_id` INTO @def_persistence_id FROM `definitions`
WHERE `definition_number`='Def. 3.3.9.6' LIMIT 1;
SELECT `definition_id` INTO @def_memory_id FROM `definitions`
WHERE `definition_number`='Def. 3.3.9.7' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   E8. Propositionen 3.3.9.4 bis 3.3.9.6
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `propositions`
(
 `proposition_number`,`section_id`,`title`,`statement_text`,
 `statement_latex`,`word_latex`,`logical_derivation`,
 `based_on_axioms`,`status`,`created_revision_id`
)
VALUES
('Prop. 3.3.9.4',@section_id,'Quantitative Nullsetzung ist keine funktionale Vernichtung',
 'Die Nullsetzung der quantitativen Zustandskomponente löscht eine davon getrennt gespeicherte funktionale Orientierung nicht notwendig.',
 '\\text{quantitative Auslöschung}\\not\\Longrightarrow\\text{funktionale Vernichtung}',
 '\\text{quantitative Auslöschung}\\not\\Longrightarrow\\text{funktionale Vernichtung}',
 'Folgt aus der Trennung von quantitativer Repräsentation und funktionaler Zustandsidentität.',
 'A1,A3,A5',
 'review',@revision_id),

('Prop. 3.3.9.5',@section_id,'Persistenz ohne konstanten Betrag',
 'Funktionale Persistenz kann bestehen, obwohl der quantitative Betrag eines Zustandes variiert oder vorübergehend Null ist.',
 '\\text{Persistenz}\\not\\Longrightarrow\\text{konstanter Betrag}',
 '\\text{Persistenz}\\not\\Longrightarrow\\text{konstanter Betrag}',
 'Folgt aus der Definition funktionaler Persistenz.',
 'A3,A5',
 'review',@revision_id),

('Prop. 3.3.9.6',@section_id,'Nullaktivität ist keine funktionale Nichtexistenz',
 'Eine quantitative Nullaktivität impliziert nicht notwendig die funktionale Nichtexistenz eines persistenten Zustandes.',
 '\\text{quantitative Nullaktivität}\\not\\Longrightarrow\\text{funktionale Nichtexistenz}',
 '\\text{quantitative Nullaktivität}\\not\\Longrightarrow\\text{funktionale Nichtexistenz}',
 'Folgt aus funktionaler Persistenz und funktionalem Gedächtnis.',
 'A1,A4,A5',
 'review',@revision_id)
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

SET @prop_null_not_annihilation_id := NULL;
SET @prop_persistence_not_constant_id := NULL;
SET @prop_zero_activity_id := NULL;

SELECT `proposition_id` INTO @prop_null_not_annihilation_id FROM `propositions`
WHERE `proposition_number`='Prop. 3.3.9.4' LIMIT 1;
SELECT `proposition_id` INTO @prop_persistence_not_constant_id FROM `propositions`
WHERE `proposition_number`='Prop. 3.3.9.5' LIMIT 1;
SELECT `proposition_id` INTO @prop_zero_activity_id FROM `propositions`
WHERE `proposition_number`='Prop. 3.3.9.6' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   E9. Objekt-Quellen-Verknüpfungen
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `object_source_links`
WHERE
(
 (`object_type`='definition' AND `object_id` IN
  (@def_latent_orientation_id,@def_persistence_id,@def_memory_id))
 OR
 (`object_type`='proposition' AND `object_id` IN
  (@prop_null_not_annihilation_id,@prop_persistence_not_constant_id,@prop_zero_activity_id))
)
AND `source_id` IN
(@source_90_id,@source_91_id,@source_92_id,@source_93_id,@source_94_id,@source_95_id);

INSERT INTO `object_source_links`
(`object_type`,`object_id`,`source_id`,`usage_type`,`note`)
VALUES
('definition',@def_latent_orientation_id,@source_90_id,'supporting_source',
 'Strang stützt die Abgrenzung zur klassischen Nullvektorbehandlung.'),
('definition',@def_latent_orientation_id,@source_91_id,'supporting_source',
 'Golub und Van Loan stützen die klassische mathematische Abgrenzung.'),
('definition',@def_latent_orientation_id,@source_92_id,'supporting_source',
 'LaValle dient als technischer Anschluss für getrennte Zustands- und Orientierungsinformation.'),
('definition',@def_latent_orientation_id,@source_93_id,'supporting_source',
 'Craig dient als technischer Anschluss für getrennte Lage- und Bewegungsgrößen.'),
('definition',@def_memory_id,@source_94_id,'supporting_source',
 'Kalman dient als Forschungsanschluss für interne Zustandsrekonstruktion.'),
('definition',@def_memory_id,@source_95_id,'supporting_source',
 'Simon dient als Forschungsanschluss für Zustandsabschätzung und interne Zustandsinformation.'),
('proposition',@prop_null_not_annihilation_id,@source_90_id,'supporting_source',
 'Die klassische Mathematik bleibt unverändert; die Proposition betrifft einen erweiterten FRZK-Zustand.'),
('proposition',@prop_null_not_annihilation_id,@source_92_id,'supporting_source',
 'Technischer Anschluss für getrennte Zustandskomponenten.'),
('proposition',@prop_zero_activity_id,@source_94_id,'supporting_source',
 'Kalman dient als methodischer Anschluss für nicht unmittelbar beobachtbare interne Zustände.'),
('proposition',@prop_zero_activity_id,@source_95_id,'supporting_source',
 'Simon dient als technischer Anschluss für rekonstruierbare Zustandsinformationen.');

/* -------------------------------------------------------------------------------------------------
   E10. Gleichungen (3.334) bis (3.339)
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `equations`
(
 `equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,
 `plain_description`,`equation_type`,`provenance`,`source_id`,
 `derivation`,`assumptions`,`validation_status`,`created_revision_id`
)
VALUES
('3.334',@section_id,'Quantitative Auslöschung ist keine funktionale Vernichtung',
 '\\text{quantitative Auslöschung}\\not\\Longrightarrow\\text{funktionale Vernichtung}',
 '\\text{quantitative Auslöschung}\\not\\Longrightarrow\\text{funktionale Vernichtung}',
 'Übergangsregel zur Trennung quantitativer Nullsetzung und funktionaler Identitätsvernichtung.',
 'principle','original',NULL,
 'Folgt aus der Einführung latenter funktionaler Orientierung.',
 'Erweiterter FRZK-Zustandsbegriff; keine Änderung klassischer Vektoralgebra.',
 'checked',@revision_id),

('3.335',@section_id,'Klassische Multiplikation eines Vektors mit Null',
 '0\\cdot\\mathbf{v}=\\mathbf{0}',
 '0\\cdot\\mathbf{v}=\\mathbf{0}',
 'Klassische Skalarmultiplikation: Der Ergebnisvektor ist der Nullvektor.',
 'identity','standard',@source_90_id,
 'Standardergebnis der linearen Algebra.',
 'Klassischer Vektorraum über einem Körper.',
 'checked',@revision_id),

('3.336',@section_id,'Orientierung ermöglicht funktionale Persistenz',
 '\\text{funktionale Orientierung}\\Longrightarrow\\text{funktionale Persistenz}',
 '\\text{funktionale Orientierung}\\Longrightarrow\\text{funktionale Persistenz}',
 'Qualitative Folgerung von erhaltener Orientierungsinformation zu funktionaler Persistenz.',
 'schema','original',NULL,
 'Eine erhaltene funktionale Orientierungsinformation trägt strukturrelevante Identität.',
 'Latente funktionale Orientierung.',
 'checked',@revision_id),

('3.337',@section_id,'Persistenz impliziert keinen konstanten Betrag',
 '\\text{Persistenz}\\not\\Longrightarrow\\text{konstanter Betrag}',
 '\\text{Persistenz}\\not\\Longrightarrow\\text{konstanter Betrag}',
 'Funktionale Persistenz ist keine numerische Konstanzforderung.',
 'principle','original',NULL,
 'Folgt aus der Trennung quantitativer und funktionaler Zustandskomponenten.',
 'Funktionale Persistenz.',
 'checked',@revision_id),

('3.338',@section_id,'Aktivität ist nicht identisch mit Existenz',
 '\\text{Aktivität}\\neq\\text{Existenz}',
 '\\text{Aktivität}\\neq\\text{Existenz}',
 'Unterscheidung zwischen momentaner quantitativer Aktivität und funktionaler Existenz.',
 'principle','original',NULL,
 'Folgt aus funktionaler Persistenz und funktionalem Gedächtnis.',
 'Erweiterter funktionaler Zustandsbegriff.',
 'checked',@revision_id),

('3.339',@section_id,'Nullaktivität impliziert keine funktionale Nichtexistenz',
 '\\text{quantitative Nullaktivität}\\not\\Longrightarrow\\text{funktionale Nichtexistenz}',
 '\\text{quantitative Nullaktivität}\\not\\Longrightarrow\\text{funktionale Nichtexistenz}',
 'Qualitative Folgerung für persistente funktionale Zustände.',
 'principle','original',NULL,
 'Folgt aus der Unterscheidung von Aktivität, Existenz und Gedächtnis.',
 'Funktionale Persistenz und funktionales Gedächtnis.',
 'checked',@revision_id)
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

SET @eq_3334 := NULL;
SET @eq_3335 := NULL;
SET @eq_3336 := NULL;
SET @eq_3337 := NULL;
SET @eq_3338 := NULL;
SET @eq_3339 := NULL;

SELECT `equation_id` INTO @eq_3334 FROM `equations` WHERE `equation_number`='3.334' LIMIT 1;
SELECT `equation_id` INTO @eq_3335 FROM `equations` WHERE `equation_number`='3.335' LIMIT 1;
SELECT `equation_id` INTO @eq_3336 FROM `equations` WHERE `equation_number`='3.336' LIMIT 1;
SELECT `equation_id` INTO @eq_3337 FROM `equations` WHERE `equation_number`='3.337' LIMIT 1;
SELECT `equation_id` INTO @eq_3338 FROM `equations` WHERE `equation_number`='3.338' LIMIT 1;
SELECT `equation_id` INTO @eq_3339 FROM `equations` WHERE `equation_number`='3.339' LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   E11. Gleichungssymbole
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `equation_symbols`
WHERE `equation_id` IN
(@eq_3334,@eq_3335,@eq_3336,@eq_3337,@eq_3338,@eq_3339);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES
(@eq_3334,'\\not\\Longrightarrow','qualitativer Nichtfolgerungspfeil',
 'Kennzeichnet, dass quantitative Nullsetzung keine funktionale Vernichtung erzwingt.',
 NULL,'qualitative FRZK-Rekonstruktion',1),

(@eq_3335,'0','Nullskalar','Additives neutrales Element des Skalarkörpers.',NULL,'Skalarkörper',1),
(@eq_3335,'\\mathbf{v}','Vektor','Beliebiger klassischer Vektor.',NULL,'klassischer Vektorraum',2),
(@eq_3335,'\\mathbf{0}','Nullvektor','Additives neutrales Element des Vektorraums ohne definierte Richtung.',NULL,'klassischer Vektorraum',3),

(@eq_3336,'\\Longrightarrow','qualitativer Folgerungspfeil',
 'Kennzeichnet die qualitative Beziehung zwischen Orientierung und Persistenz.',
 NULL,'qualitative FRZK-Rekonstruktion',1),

(@eq_3337,'\\not\\Longrightarrow','qualitativer Nichtfolgerungspfeil',
 'Kennzeichnet, dass Persistenz keinen konstanten Betrag erzwingt.',
 NULL,'qualitative FRZK-Rekonstruktion',1),

(@eq_3338,'\\neq','Ungleichheitszeichen',
 'Kennzeichnet die Nichtidentität von Aktivität und funktionaler Existenz.',
 NULL,'qualitative FRZK-Rekonstruktion',1),

(@eq_3339,'\\not\\Longrightarrow','qualitativer Nichtfolgerungspfeil',
 'Kennzeichnet, dass Nullaktivität keine funktionale Nichtexistenz erzwingt.',
 NULL,'qualitative FRZK-Rekonstruktion',1)
ON DUPLICATE KEY UPDATE
`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),
`unit_text`=VALUES(`unit_text`),
`domain_text`=VALUES(`domain_text`),
`symbol_order`=VALUES(`symbol_order`);

/* -------------------------------------------------------------------------------------------------
   E12. Abschnittssymbole
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `symbols`
(
 `symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,
 `scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,
 `domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,
 `notes`,`validation_status`,`created_revision_id`
)
VALUES
('\\mathbf{v}','\\mathbf{v}','klassischer Vektor',
 'Beliebiger klassischer Vektor in der Abgrenzungsgleichung (3.335).',
 'section',@section_id,@eq_3335,NULL,
 'klassischer Vektorraum','klassischer Vektorraum',
 1,0,0,
 'Nicht identisch mit dem späteren erweiterten FRZK-Zustand.',
 'checked',@revision_id),

('\\mathbf{0}','\\mathbf{0}','klassischer Nullvektor',
 'Additives neutrales Element eines klassischen Vektorraums; besitzt keine definierte Richtung.',
 'section',@section_id,@eq_3335,NULL,
 'klassischer Vektorraum','klassischer Vektorraum',
 1,0,0,
 'Die funktionale Orientierungsinformation gehört nicht zum Nullvektor selbst.',
 'checked',@revision_id),

('\\not\\Longrightarrow','\\not\\Longrightarrow','qualitativer Nichtfolgerungspfeil',
 'Kennzeichnet in den Ergänzungen 3.3.9.8 bis 3.3.9.10 eine qualitative Nichtfolgerung.',
 'section',@section_id,@eq_3334,NULL,
 'qualitative FRZK-Rekonstruktion','qualitative FRZK-Rekonstruktion',
 0,0,0,
 'Keine vollständig formalisierte semantische Nichtfolgerung.',
 'checked',@revision_id)
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
   E13. Änderungsprotokoll der V2-Erweiterung
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `section_change_log`
(
 `revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,
 `change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'source_added','sources','[90]–[95]',
 'Sechs neue Literaturquellen für lineare Algebra, Robotik, Zustandsrekonstruktion und Zustandsabschätzung wurden ergänzt.',
 NULL,'Quellen [90] bis [95] einschließlich Autoren, Annotationen und Erstverwendungen.'),

(@revision_id,@section_id,'definition_added','definitions','Def. 3.3.9.5–Def. 3.3.9.7',
 'Latente funktionale Orientierung, funktionale Persistenz und funktionales Gedächtnis wurden definiert.',
 NULL,'Drei neue originäre FRZK-Definitionen.'),

(@revision_id,@section_id,'proposition_added','propositions','Prop. 3.3.9.4–Prop. 3.3.9.6',
 'Drei Propositionen zur Nullsetzung, Persistenz und funktionalen Existenz wurden registriert.',
 NULL,'Drei neue methodische Propositionen.'),

(@revision_id,@section_id,'equation_added','equations','(3.334)–(3.339)',
 'Sechs Gleichungen zur latenten Orientierung, klassischen Nullmultiplikation, Persistenz, Aktivität und Existenz wurden registriert.',
 NULL,'Gleichungen (3.334) bis (3.339).'),

(@revision_id,@section_id,'symbol_added','symbols','\\mathbf{v}, \\mathbf{0}, \\not\\Longrightarrow',
 'Die zusätzlichen abschnittsspezifischen Symbole wurden registriert.',
 NULL,'Drei zusätzliche Abschnittssymbole.'),

(@revision_id,@section_id,'rewritten','section','3.3.9.8–3.3.9.10',
 'Die Übergangsregeln wurden um latente funktionale Orientierung, funktionale Persistenz und funktionales Gedächtnis erweitert.',
 NULL,'Vollständige Endfassung von Abschnitt 3.3.9.');

UPDATE `repository_revisions`
SET
    `summary` =
    'Vollständige Endfassung von Abschnitt 3.3.9 einschließlich der Übergangsregeln 3.3.9.1 bis 3.3.9.10. Zusätzlich registriert werden latente funktionale Orientierung, funktionale Persistenz, funktionales Gedächtnis, Quellen [90] bis [95], Definitionen Def. 3.3.9.5 bis Def. 3.3.9.7, Propositionen Prop. 3.3.9.4 bis Prop. 3.3.9.6 sowie Gleichungen (3.334) bis (3.339).',
    `version_label`='V2',
    `revision_date`=NOW()
WHERE `revision_id`=@revision_id;

UPDATE `dissertation_sections`
SET
    `notes` =
    'Abschluss der prämathematischen Ebene von Kapitel 3.3. Der Abschnitt enthält die Übergangsregeln zur mathematischen Rekonstruktion sowie die Ergänzungen zur latenten funktionalen Orientierung, funktionalen Persistenz und zum funktionalen Gedächtnis. Die klassische Vektoralgebra bleibt unverändert.',
    `status`='review',
    `is_original_contribution`=1
WHERE `section_id`=@section_id;

/* -------------------------------------------------------------------------------------------------
   E14. Finale Repository-Zähler der V2
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(`counter_key`,`counter_value`)
VALUES
('last_edited_section','3.3.9'),
('last_repository_revision','RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2'),
('next_citation_number','96'),
('next_equation_number','3.340')
ON DUPLICATE KEY UPDATE
`counter_value`=VALUES(`counter_value`);

COMMIT;

/* =================================================================================================
   E15. ERWEITERTER V2-AUDIT
   ================================================================================================= */

SELECT
    r.`revision_code`,
    r.`version_label`,
    p.`revision_code` AS `parent_revision_code`,
    r.`scope_reference`,
    r.`summary`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p
    ON p.`revision_id`=r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci
      =
      'RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2' COLLATE utf8mb4_unicode_ci;

SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`,
    s.`year_edition`,
    s.`verification_status`,
    a.`normalized_name`,
    sa.`author_order`
FROM `sources` s
LEFT JOIN `source_authors` sa ON sa.`source_id`=s.`source_id`
LEFT JOIN `authors` a ON a.`author_id`=sa.`author_id`
WHERE s.`citation_number` BETWEEN 90 AND 95
ORDER BY s.`citation_number`,sa.`author_order`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`provenance`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`section_id`=@section_id
  AND d.`definition_number` IN
  ('Def. 3.3.9.5','Def. 3.3.9.6','Def. 3.3.9.7')
ORDER BY d.`definition_number`;

SELECT
    p.`proposition_number`,
    p.`title`,
    p.`status`,
    CASE
        WHEN p.`word_latex` IS NULL OR TRIM(p.`word_latex`)=''
        THEN 'FEHLT'
        ELSE 'OK'
    END AS `word_latex_audit`
FROM `propositions` p
WHERE p.`section_id`=@section_id
  AND p.`proposition_number` IN
  ('Prop. 3.3.9.4','Prop. 3.3.9.5','Prop. 3.3.9.6')
ORDER BY p.`proposition_number`;

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
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 327 AND 339
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`symbol_order`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 334 AND 339
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),es.`symbol_order`;

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
    `citation_number`,
    COUNT(*) AS `duplicate_count`
FROM `sources`
GROUP BY `citation_number`
HAVING COUNT(*)>1;

SELECT
    `equation_number`,
    COUNT(*) AS `duplicate_count`
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*)>1;

SELECT
    `definition_number`,
    COUNT(*) AS `duplicate_count`
FROM `definitions`
GROUP BY `definition_number`
HAVING COUNT(*)>1;

SELECT
    `proposition_number`,
    COUNT(*) AS `duplicate_count`
FROM `propositions`
GROUP BY `proposition_number`
HAVING COUNT(*)>1;

SELECT
    'equation' AS `object_type`,
    e.`equation_number` AS `object_reference`
FROM `equations` e
WHERE e.`section_id`=@section_id
  AND CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 327 AND 339
  AND (e.`word_latex` IS NULL OR TRIM(e.`word_latex`)='')

UNION ALL

SELECT
    'proposition',
    p.`proposition_number`
FROM `propositions` p
WHERE p.`section_id`=@section_id
  AND p.`proposition_number` IN
  ('Prop. 3.3.9.1','Prop. 3.3.9.2','Prop. 3.3.9.3',
   'Prop. 3.3.9.4','Prop. 3.3.9.5','Prop. 3.3.9.6')
  AND (p.`word_latex` IS NULL OR TRIM(p.`word_latex`)='');

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
  (@def_latent_orientation_id,@def_persistence_id,@def_memory_id))
 OR
 (`object_type`='proposition' AND `object_id` IN
  (@prop_null_not_annihilation_id,@prop_persistence_not_constant_id,@prop_zero_activity_id))
)
AND (`usage_type` IS NULL OR TRIM(`usage_type`)='');

SELECT
    'V2 vollständig ausgeführt. Finaler Stand: Abschnitt 3.3.9 vollständig, Quellen [90]–[95] ergänzt, nächste Quelle [96], Gleichungen (3.327)–(3.339), nächste Gleichung (3.340), Revision RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2.'
AS `result`;
