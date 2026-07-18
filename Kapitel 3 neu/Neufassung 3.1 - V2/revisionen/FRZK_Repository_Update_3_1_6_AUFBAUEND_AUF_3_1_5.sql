/* ============================================================
   FRZK-RKB – REPOSITORY-UPDATE
   Abschnitt 3.1.6 – Funktion statt Objekt:
   Paradigmenwechsel moderner Wissenschaft

   AUSGANGSBASIS:
   - erfolgreicher Import von 3.1.5
   - Elternrevision: RKB-NEU-K3.1.5-V1
   - nächste freie Literaturzahl: 58

   WIEDERVERWENDETE QUELLEN:
   - Cassirer [18]
   - Whitehead [16]
   - Mac Lane [56]
   - Eilenberg/Mac Lane [57]

   NEUE QUELLEN:
   - [58] Frege
   - [59] Bertalanffy
   - [60] Wiener
   - [61] Ashby
   - [62] Resnik
   - [63] Shapiro
   - [64] von Foerster
   - [65] Luhmann

   Nächste freie Literaturzahl nach Import: 66
   Keine neuen Gleichungen.
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;


/* ============================================================
   0. AUSGANGSSTAND ERMITTELN
   ============================================================ */

SET @parent_revision_id := (
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `revision_code` = 'RKB-NEU-K3.1.5-V1'
      AND `scope_reference` = '3.1.5'
    LIMIT 1
);

SET @parent_section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1'
    LIMIT 1
);

SET @source_16 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 16
      AND `source_key` = 'whitehead_process_reality_1978'
    LIMIT 1
);

SET @source_18 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 18
      AND `source_key` = 'cassirer_substanzbegriff_funktionsbegriff_1910'
    LIMIT 1
);

SET @source_56 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 56
      AND `source_key` = 'mac_lane_mathematics_form_function_1986'
    LIMIT 1
);

SET @source_57 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `citation_number` = 57
      AND `source_key` = 'eilenberg_mac_lane_natural_equivalences_1945'
    LIMIT 1
);

SET @counter_value := (
    SELECT CAST(`counter_value` AS UNSIGNED)
    FROM `repository_counters`
    WHERE `counter_key` = 'next_citation_number'
    LIMIT 1
);


/* ============================================================
   1. PREFLIGHT
   ============================================================ */

DROP PROCEDURE IF EXISTS `frzk_preflight_3_1_6`;

DELIMITER $$

CREATE PROCEDURE `frzk_preflight_3_1_6`()
BEGIN
    IF @parent_revision_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Elternrevision RKB-NEU-K3.1.5-V1 fehlt.';
    END IF;

    IF @parent_section_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Übergeordneter Abschnitt 3.1 fehlt.';
    END IF;

    IF @source_16 IS NULL
       OR @source_18 IS NULL
       OR @source_56 IS NULL
       OR @source_57 IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Eine wiederzuverwendende Quelle [16], [18], [56] oder [57] fehlt.';
    END IF;

    IF @counter_value IS NULL OR @counter_value <> 58 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: next_citation_number ist nicht 58.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `repository_revisions`
        WHERE `revision_code` = 'RKB-NEU-K3.1.6-V1'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Revision existiert bereits.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `dissertation_sections`
        WHERE `section_code` = '3.1.6'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Abschnitt existiert bereits.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `sources`
        WHERE `citation_number` BETWEEN 58 AND 65
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Mindestens eine Literaturzahl [58] bis [65] ist bereits belegt.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `sources`
        WHERE `source_key` IN (
            'frege_grundlagen_arithmetik_1884',
            'bertalanffy_general_system_theory_1968',
            'wiener_cybernetics_1948',
            'ashby_introduction_cybernetics_1956',
            'resnik_mathematics_science_patterns_1997',
            'shapiro_philosophy_mathematics_structure_ontology_1997',
            'von_foerster_observing_systems_1981',
            'luhmann_soziale_systeme_1984'
        )
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.6: Mindestens ein neuer source_key existiert bereits.';
    END IF;
END$$

DELIMITER ;

CALL `frzk_preflight_3_1_6`();
DROP PROCEDURE `frzk_preflight_3_1_6`;


/* ============================================================
   2. REVISION
   ============================================================ */

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
    'RKB-NEU-K3.1.6-V1',
    NOW(),
    'section',
    '3.1.6',
    '1.0',
    'Neufassung von Abschnitt 3.1.6 Funktion statt Objekt. Wiederverwendung von [16], [18], [56], [57] und Aufnahme der Quellen [58] bis [65].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);

SET @revision_id := LAST_INSERT_ID();


/* ============================================================
   3. ABSCHNITT
   ============================================================ */

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
    @parent_section_id,
    '3.1.6',
    'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft',
    3,
    3.1600,
    'final',
    1,
    'Begründung des methodischen Übergangs von vorausgesetzten Objekten zu funktionaler Wirksamkeit, relationaler Bestimmung, Prozessualität, Rekursivität und funktionaler Stabilisierung.'
);

SET @section_id := LAST_INSERT_ID();


/* ============================================================
   4. AUTOREN
   ============================================================ */

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'Frege','Gottlob','Frege, Gottlob',1848,1925,
       'Logiker und Mathematiker; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='Frege, Gottlob'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'von Bertalanffy','Ludwig','von Bertalanffy, Ludwig',1901,1972,
       'Biologe und Systemtheoretiker; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='von Bertalanffy, Ludwig'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'Wiener','Norbert','Wiener, Norbert',1894,1964,
       'Mathematiker und Begründer der Kybernetik.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='Wiener, Norbert'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'Ashby','W. Ross','Ashby, W. Ross',1903,1972,
       'Psychiater und Kybernetiker; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='Ashby, W. Ross'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'Resnik','Michael D.','Resnik, Michael D.',1938,NULL,
       'Philosoph der Mathematik; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='Resnik, Michael D.'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'Shapiro','Stewart','Shapiro, Stewart',1951,NULL,
       'Philosoph der Mathematik; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='Shapiro, Stewart'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'von Foerster','Heinz','von Foerster, Heinz',1911,2002,
       'Kybernetiker; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='von Foerster, Heinz'
);

INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
SELECT 'Luhmann','Niklas','Luhmann, Niklas',1927,1998,
       'Soziologe und Systemtheoretiker; für Abschnitt 3.1.6 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name`='Luhmann, Niklas'
);

SET @author_frege := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='Frege, Gottlob' LIMIT 1
);
SET @author_bertalanffy := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='von Bertalanffy, Ludwig' LIMIT 1
);
SET @author_wiener := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='Wiener, Norbert' LIMIT 1
);
SET @author_ashby := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='Ashby, W. Ross' LIMIT 1
);
SET @author_resnik := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='Resnik, Michael D.' LIMIT 1
);
SET @author_shapiro := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='Shapiro, Stewart' LIMIT 1
);
SET @author_foerster := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='von Foerster, Heinz' LIMIT 1
);
SET @author_luhmann := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name`='Luhmann, Niklas' LIMIT 1
);


/* ============================================================
   5. NEUE QUELLEN [58]–[65]
   ============================================================ */

INSERT INTO `sources`
(
    `citation_number`,`source_key`,`source_type`,`title`,`subtitle`,
    `year_original`,`year_edition`,`journal`,`publisher`,`place`,
    `volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,
    `language_code`,`priority`,`evidence_type`,`frzk_relevance`,
    `verification_status`,`first_citation_section_code`,
    `first_citation_note`,`full_citation_text`,`short_citation_text`,
    `notes`,`created_revision_id`
)
VALUES
(
    58,
    'frege_grundlagen_arithmetik_1884',
    'book',
    'Die Grundlagen der Arithmetik',
    'Eine logisch mathematische Untersuchung über den Begriff der Zahl',
    1884,1884,NULL,'Wilhelm Koebner','Breslau',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'de',1,'primary',9,'verified','3.1.6',
    'Erstnennung zur logischen und funktionalen Bestimmung mathematischer Begriffe.',
    'Frege, Gottlob: Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl. Breslau: Wilhelm Koebner, 1884.',
    'Frege (1884) [58]',
    'Grundlagenquelle zur Abkehr von rein anschaulichen Objektvorstellungen.',
    @revision_id
),
(
    59,
    'bertalanffy_general_system_theory_1968',
    'book',
    'General System Theory',
    'Foundations, Development, Applications',
    1968,1968,NULL,'George Braziller','New York',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'en',1,'primary',9,'verified','3.1.6',
    'Erstnennung zur Bestimmung von Systemen als organisierte Ganzheiten miteinander wechselwirkender Bestandteile.',
    'von Bertalanffy, Ludwig: General System Theory. Foundations, Development, Applications. New York: George Braziller, 1968.',
    'von Bertalanffy (1968) [59]',
    'Systemtheoretische Grundlage für relationale Organisation und emergente Systemeigenschaften.',
    @revision_id
),
(
    60,
    'wiener_cybernetics_1948',
    'book',
    'Cybernetics or Control and Communication in the Animal and the Machine',
    NULL,
    1948,1948,NULL,'Hermann & Cie / MIT Press','Paris / Cambridge, MA',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'en',1,'primary',10,'verified','3.1.6',
    'Erstnennung zu Steuerung, Kommunikation, Rückkopplung und rekursiver funktionaler Organisation.',
    'Wiener, Norbert: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann & Cie; Cambridge, MA: MIT Press, 1948.',
    'Wiener (1948) [60]',
    'Primärquelle zur Kybernetik und zu funktionalen Rückkopplungszusammenhängen.',
    @revision_id
),
(
    61,
    'ashby_introduction_cybernetics_1956',
    'book',
    'An Introduction to Cybernetics',
    NULL,
    1956,1956,NULL,'Chapman & Hall','London',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'en',1,'primary',10,'verified','3.1.6',
    'Erstnennung zur formalen Beschreibung von Zuständen, Zustandsübergängen und Regelungsprozessen.',
    'Ashby, W. Ross: An Introduction to Cybernetics. London: Chapman & Hall, 1956.',
    'Ashby (1956) [61]',
    'Grundlage für die spätere Rekonstruktion funktionaler Zustandsübergänge.',
    @revision_id
),
(
    62,
    'resnik_mathematics_science_patterns_1997',
    'book',
    'Mathematics as a Science of Patterns',
    NULL,
    1997,1997,NULL,'Clarendon Press','Oxford',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'en',1,'secondary',9,'verified','3.1.6',
    'Erstnennung zur strukturalistischen Auffassung mathematischer Gegenstände als Positionen in Mustern.',
    'Resnik, Michael D.: Mathematics as a Science of Patterns. Oxford: Clarendon Press, 1997.',
    'Resnik (1997) [62]',
    'Quelle zum mathematischen Strukturalismus.',
    @revision_id
),
(
    63,
    'shapiro_philosophy_mathematics_structure_ontology_1997',
    'book',
    'Philosophy of Mathematics',
    'Structure and Ontology',
    1997,1997,NULL,'Oxford University Press','New York',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'en',1,'secondary',9,'verified','3.1.6',
    'Erstnennung zur Identifikation mathematischer Gegenstände als Stellen innerhalb von Strukturen.',
    'Shapiro, Stewart: Philosophy of Mathematics. Structure and Ontology. New York: Oxford University Press, 1997.',
    'Shapiro (1997) [63]',
    'Quelle zur ontologischen und mathematischen Strukturalismusdebatte.',
    @revision_id
),
(
    64,
    'von_foerster_observing_systems_1981',
    'book',
    'Observing Systems',
    NULL,
    1981,1981,NULL,'Intersystems Publications','Seaside, CA',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'en',1,'primary',9,'verified','3.1.6',
    'Erstnennung zur Kybernetik zweiter Ordnung und zur Einbeziehung des Beobachters in rekursive Beschreibungszusammenhänge.',
    'von Foerster, Heinz: Observing Systems. Seaside, CA: Intersystems Publications, 1981.',
    'von Foerster (1981) [64]',
    'Grundlage zur Reflexion beobachterabhängiger Unterscheidungs- und Beschreibungsoperationen.',
    @revision_id
),
(
    65,
    'luhmann_soziale_systeme_1984',
    'book',
    'Soziale Systeme',
    'Grundriß einer allgemeinen Theorie',
    1984,1984,NULL,'Suhrkamp','Frankfurt am Main',
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'de',1,'primary',8,'verified','3.1.6',
    'Erstnennung zur rekursiven Anschlussfähigkeit von Operationen und zur funktionalen Stabilisierung von Systemen.',
    'Luhmann, Niklas: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984.',
    'Luhmann (1984) [65]',
    'Systemtheoretische Vergleichsquelle; keine vollständige Übernahme der Theorie sozialer Systeme.',
    @revision_id
);

SET @source_58 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='frege_grundlagen_arithmetik_1884' LIMIT 1
);
SET @source_59 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='bertalanffy_general_system_theory_1968' LIMIT 1
);
SET @source_60 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='wiener_cybernetics_1948' LIMIT 1
);
SET @source_61 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='ashby_introduction_cybernetics_1956' LIMIT 1
);
SET @source_62 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='resnik_mathematics_science_patterns_1997' LIMIT 1
);
SET @source_63 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='shapiro_philosophy_mathematics_structure_ontology_1997' LIMIT 1
);
SET @source_64 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='von_foerster_observing_systems_1981' LIMIT 1
);
SET @source_65 := (
    SELECT `source_id` FROM `sources`
    WHERE `source_key`='luhmann_soziale_systeme_1984' LIMIT 1
);


/* ============================================================
   6. QUELLEN-AUTOREN
   ============================================================ */

INSERT INTO `source_authors`
(`source_id`,`author_id`,`author_order`,`role`)
VALUES
(@source_58,@author_frege,1,'author'),
(@source_59,@author_bertalanffy,1,'author'),
(@source_60,@author_wiener,1,'author'),
(@source_61,@author_ashby,1,'author'),
(@source_62,@author_resnik,1,'author'),
(@source_63,@author_shapiro,1,'author'),
(@source_64,@author_foerster,1,'author'),
(@source_65,@author_luhmann,1,'author');


/* ============================================================
   7. QUELLENVERWENDUNG – WIEDERVERWENDUNGEN
   ============================================================ */

INSERT INTO `source_usage`
(
    `source_id`,`section_id`,`usage_type`,`claim_summary`,
    `exact_location`,`is_first_mention`,`citation_checked`,
    `notes`,`created_revision_id`
)
VALUES
(
    @source_18,@section_id,'background',
    'Übergang vom Substanzbegriff zur funktionalen und relationalen Bestimmung wissenschaftlicher Gegenstände.',
    'Abschnitt 3.1.6',0,1,
    'Wiederverwendung von Cassirer [18].',@revision_id
),
(
    @source_16,@section_id,'background',
    'Prozessontologischer Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaft vorausgesetzten Substanzen.',
    'Abschnitt 3.1.6',0,1,
    'Wiederverwendung von Whitehead [16].',@revision_id
),
(
    @source_57,@section_id,'method',
    'Strukturerhaltende Abbildungen und natürliche Äquivalenzen als Orientierung für transformationsbezogene mathematische Beschreibungen.',
    'Abschnitt 3.1.6',0,1,
    'Wiederverwendung von Eilenberg und Mac Lane [57].',@revision_id
),
(
    @source_56,@section_id,'method',
    'Mathematik als Untersuchung von Formen, Funktionen, Beziehungen und Transformationen.',
    'Abschnitt 3.1.6',0,1,
    'Wiederverwendung von Mac Lane [56].',@revision_id
);


/* ============================================================
   8. QUELLENVERWENDUNG – ERSTNENNUNGEN
   ============================================================ */

INSERT INTO `source_usage`
(
    `source_id`,`section_id`,`usage_type`,`claim_summary`,
    `exact_location`,`is_first_mention`,`citation_checked`,
    `notes`,`created_revision_id`
)
VALUES
(
    @source_58,@section_id,'first_citation',
    'Logische und funktionale Bestimmung mathematischer Begriffe ohne notwendige Rückführung auf anschauliche Objekte.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [58].',@revision_id
),
(
    @source_59,@section_id,'first_citation',
    'Systeme als organisierte Ganzheiten, deren Eigenschaften durch Wechselwirkungen und Beziehungsorganisation mitbestimmt werden.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [59].',@revision_id
),
(
    @source_60,@section_id,'first_citation',
    'Steuerung, Kommunikation und Rückkopplung als rekursive funktionale Organisationsprinzipien.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [60].',@revision_id
),
(
    @source_61,@section_id,'first_citation',
    'Beschreibung von Systementwicklung durch Zustände, Zustandsübergänge und Regelungsprozesse.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [61].',@revision_id
),
(
    @source_62,@section_id,'first_citation',
    'Mathematische Gegenstände werden durch Positionen innerhalb von Mustern und Strukturen bestimmt.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [62].',@revision_id
),
(
    @source_63,@section_id,'first_citation',
    'Mathematische Objekte als Stellen in Strukturen, deren Identität relational festgelegt ist.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [63].',@revision_id
),
(
    @source_64,@section_id,'first_citation',
    'Beobachter und beschreibende Systeme als Bestandteile rekursiver Beobachtungs- und Rückkopplungszusammenhänge.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [64].',@revision_id
),
(
    @source_65,@section_id,'first_citation',
    'Systemstabilität durch rekursive Anschlussfähigkeit von Operationen statt allein durch dauerhafte materielle Bestandteile.',
    'Abschnitt 3.1.6',1,1,'Erstnennung als Quelle [65].',@revision_id
);


/* ============================================================
   9. ÄNDERUNGSPROTOKOLL
   ============================================================ */

INSERT INTO `section_change_log`
(
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(
    @revision_id,@section_id,'created','section','3.1.6',
    'Abschnitt 3.1.6 vollständig neu erstellt.',
    NULL,
    'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft'
),
(
    @revision_id,@section_id,'source_reused','source',
    '[16], [18], [56], [57]',
    'Vier vorhandene Quellen wurden mit unveränderten Literaturzahlen wiederverwendet.',
    NULL,
    'Whitehead [16]; Cassirer [18]; Mac Lane [56]; Eilenberg und Mac Lane [57]'
),
(
    @revision_id,@section_id,'source_added','source',
    '[58]–[65]',
    'Acht neue Quellen wurden aufgenommen.',
    NULL,
    'Frege [58] bis Luhmann [65]'
),
(
    @revision_id,@section_id,'other','conceptual_result',
    'funktionaler Paradigmenwechsel',
    'Objekte werden nicht als primitive Einheiten vorausgesetzt, sondern als mögliche kohärente funktionale Stabilisierung rekonstruiert.',
    NULL,
    'Funktionalität als relational, prozessual und rekursiv; Objektstabilität als Sonderfall funktionaler Kohärenz'
),
(
    @revision_id,@section_id,'other','research_gap',
    'Grenze bestehender Funktionsbeschreibungen',
    'Die Forschungslücke wurde als fehlende Rekonstruktion der Entstehung von Unterscheidbarkeit, Relation, Zustand und Ordnung aus minimaler funktionaler Organisation bestimmt.',
    NULL,
    'Bestehende Ansätze setzen Mengen, Zustände, Systeme, Objekte, Morphismen oder Strukturen bereits voraus.'
),
(
    @revision_id,@section_id,'status_changed','section','3.1.6',
    'Bearbeitungsstatus auf final gesetzt.',
    'draft','final'
);


/* ============================================================
   10. ZÄHLER
   ============================================================ */

UPDATE `repository_counters`
SET
    `counter_value` = '66',
    `updated_at` = CURRENT_TIMESTAMP
WHERE `counter_key` = 'next_citation_number';

COMMIT;


/* ============================================================
   11. ABSCHLUSSVALIDIERUNG
   ============================================================ */

SELECT
    `revision_id`,`revision_code`,`scope_reference`,
    `version_label`,`parent_revision_id`,`summary`
FROM `repository_revisions`
WHERE `revision_code`='RKB-NEU-K3.1.6-V1';

SELECT
    `section_id`,`parent_section_id`,`section_code`,`title`,
    `chapter_no`,`section_order`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code`='3.1.6';

SELECT
    `citation_number`,`source_key`,`title`,
    `first_citation_section_code`,`verification_status`
FROM `sources`
WHERE `citation_number` BETWEEN 58 AND 65
ORDER BY `citation_number`;

SELECT
    s.`citation_number`,
    s.`source_key`,
    a.`normalized_name`,
    sa.`author_order`,
    sa.`role`
FROM `source_authors` sa
INNER JOIN `sources` s
    ON s.`source_id`=sa.`source_id`
INNER JOIN `authors` a
    ON a.`author_id`=sa.`author_id`
WHERE s.`citation_number` BETWEEN 58 AND 65
ORDER BY s.`citation_number`,sa.`author_order`;

SELECT
    s.`citation_number`,
    s.`source_key`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`claim_summary`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id`=su.`source_id`
WHERE su.`section_id`=@section_id
ORDER BY s.`citation_number`;

SELECT
    `counter_key`,`counter_value`,`updated_at`
FROM `repository_counters`
WHERE `counter_key`='next_citation_number';

SELECT
    'IMPORT 3.1.6 ABGESCHLOSSEN – NÄCHSTE LITERATURZAHL 66'
    AS `status`;
