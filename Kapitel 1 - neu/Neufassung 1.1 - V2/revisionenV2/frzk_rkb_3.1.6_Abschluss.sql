USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   FRZK-RKB – Abschnitt 3.1.6
   Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft

   Wiederverwendete Literatur:
   [18] Cassirer
   [60] Mac Lane
   [61] Eilenberg / Mac Lane

   Neue Literatur:
   [62] Frege
   [63] Whitehead
   [64] Bertalanffy
   [65] Wiener
   [66] Ashby
   [67] Resnik
   [68] Shapiro
   [69] von Foerster
   [70] Luhmann

   Nummerierte Gleichungen: keine
   Nächste Literaturstelle: [71]
   ============================================================ */

/* ============================================================
   1. Parent-Revision ermitteln und Revision anlegen
   ============================================================ */

SET @parent_revision_id :=
(
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `scope_reference` = '3.1.5'
    ORDER BY `revision_id` DESC
    LIMIT 1
);

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
    'RKB-NEU-K3.1.6-ABSCHLUSS-V1',
    NOW(),
    'section',
    '3.1.6',
    '3.1.6-Abschluss-v1',
    'Vollständiger Abschluss des Abschnitts 3.1.6 „Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft“ mit Wiederverwendung der Quellen [18], [60] und [61] sowie Aufnahme der Quellen [62] bis [70]. Keine nummerierten Gleichungen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`),
    `parent_revision_id` = VALUES(`parent_revision_id`);

SET @revision_id := LAST_INSERT_ID();

/* ============================================================
   2. Abschnitt 3.1.6 anlegen oder aktualisieren
   ============================================================ */

SET @parent_section_id :=
(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1'
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
SELECT
    @parent_section_id,
    '3.1.6',
    'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft',
    3,
    3.1600,
    'final',
    1,
    'Abschnitt vollständig abgeschlossen. Wiederverwendung der Quellen [18], [60] und [61]; neue Quellen [62] bis [70]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.6'
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @parent_section_id,
    `title` = 'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft',
    `chapter_no` = 3,
    `section_order` = 3.1600,
    `status` = 'final',
    `is_original_contribution` = 1,
    `notes` = 'Abschnitt vollständig abgeschlossen. Wiederverwendung der Quellen [18], [60] und [61]; neue Quellen [62] bis [70]; keine nummerierten Gleichungen.'
WHERE `section_code` = '3.1.6';

SET @section_id :=
(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.6'
    LIMIT 1
);

/* ============================================================
   3. Neue Quellen [62] bis [70]
   ============================================================ */

INSERT INTO `sources`
(
    `citation_number`, `source_key`, `source_type`, `title`, `subtitle`,
    `year_original`, `year_edition`, `journal`, `publisher`, `place`,
    `volume`, `issue`, `pages`, `edition`, `doi`, `isbn`, `url`,
    `language_code`, `priority`, `evidence_type`, `frzk_relevance`,
    `verification_status`, `first_citation_section_code`,
    `first_citation_note`, `full_citation_text`, `short_citation_text`,
    `notes`, `created_revision_id`
)
VALUES
(62,'frege_grundlagen_arithmetik_1884','book','Die Grundlagen der Arithmetik','Eine logisch mathematische Untersuchung über den Begriff der Zahl',1884,1884,NULL,'Wilhelm Koebner','Breslau',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',9,'verified','3.1.6','Logische und relationale Bestimmbarkeit mathematischer Bedeutung.','Frege, Gottlob: Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl. Breslau: Wilhelm Koebner, 1884.','Frege, Grundlagen der Arithmetik [62]','Quelle zur Abkehr von rein anschaulichen Objektvorstellungen in der Mathematik.',@revision_id),
(63,'whitehead_process_reality_1929','book','Process and Reality','An Essay in Cosmology',1929,1929,NULL,'Macmillan','New York',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.6','Prozessontologie und Stabilität als Ergebnis wiederholter Prozesszusammenhänge.','Whitehead, Alfred North: Process and Reality. An Essay in Cosmology. New York: Macmillan, 1929.','Whitehead, Process and Reality [63]','Quelle zur Verschiebung von Substanz zu Prozess.',@revision_id),
(64,'bertalanffy_general_system_theory_1968','book','General System Theory','Foundations, Development, Applications',1968,1968,NULL,'George Braziller','New York',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.6','Systeme als geordnete Ganzheiten mit wechselwirkenden Bestandteilen.','von Bertalanffy, Ludwig: General System Theory. Foundations, Development, Applications. New York: George Braziller, 1968.','Bertalanffy, General System Theory [64]','Grundlage der systemischen Organisationsperspektive.',@revision_id),
(65,'wiener_cybernetics_1948','book','Cybernetics','Or Control and Communication in the Animal and the Machine',1948,1948,NULL,'Hermann & Cie / MIT Press','Paris / Cambridge, MA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.6','Steuerung, Kommunikation und Rückkopplung in technischen und biologischen Systemen.','Wiener, Norbert: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann & Cie; Cambridge, MA: MIT Press, 1948.','Wiener, Cybernetics [65]','Quelle für Rückkopplung, Rekursion und funktionale Organisation.',@revision_id),
(66,'ashby_introduction_cybernetics_1956','book','An Introduction to Cybernetics',NULL,1956,1956,NULL,'Chapman & Hall','London',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.6','Zustandsübergänge und Regelungsprozesse als formale Systembeschreibung.','Ashby, W. Ross: An Introduction to Cybernetics. London: Chapman & Hall, 1956.','Ashby, Introduction to Cybernetics [66]','Quelle zur formalen Beschreibung von Zustandsübergängen.',@revision_id),
(67,'resnik_mathematics_patterns_1997','book','Mathematics as a Science of Patterns',NULL,1997,1997,NULL,'Clarendon Press','Oxford',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.6','Mathematische Objekte als Positionen in Strukturen und Mustern.','Resnik, Michael D.: Mathematics as a Science of Patterns. Oxford: Clarendon Press, 1997.','Resnik, Mathematics as Patterns [67]','Quelle zum mathematischen Strukturalismus.',@revision_id),
(68,'shapiro_structure_ontology_1997','book','Philosophy of Mathematics','Structure and Ontology',1997,1997,NULL,'Oxford University Press','New York',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.6','Mathematische Gegenstände als Stellen innerhalb von Strukturen.','Shapiro, Stewart: Philosophy of Mathematics. Structure and Ontology. New York: Oxford University Press, 1997.','Shapiro, Structure and Ontology [68]','Quelle zur strukturalistischen Bestimmung mathematischer Identität.',@revision_id),
(69,'von_foerster_observing_systems_1981','book','Observing Systems',NULL,1981,1981,NULL,'Intersystems Publications','Seaside, CA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.6','Beobachter als Bestandteil rekursiver Beschreibungszusammenhänge.','von Foerster, Heinz: Observing Systems. Seaside, CA: Intersystems Publications, 1981.','von Foerster, Observing Systems [69]','Quelle zur Kybernetik zweiter Ordnung und Beobachterabhängigkeit.',@revision_id),
(70,'luhmann_soziale_systeme_1984','book','Soziale Systeme','Grundriß einer allgemeinen Theorie',1984,1984,NULL,'Suhrkamp','Frankfurt am Main',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',8,'verified','3.1.6','Systembestand durch rekursiv anschließende Operationen statt dauerhafter Bestandteile.','Luhmann, Niklas: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984.','Luhmann, Soziale Systeme [70]','Quelle zur operativen Geschlossenheit und Anschlussfähigkeit.',@revision_id)
ON DUPLICATE KEY UPDATE
    `source_key` = VALUES(`source_key`),
    `source_type` = VALUES(`source_type`),
    `title` = VALUES(`title`),
    `subtitle` = VALUES(`subtitle`),
    `year_original` = VALUES(`year_original`),
    `year_edition` = VALUES(`year_edition`),
    `journal` = VALUES(`journal`),
    `publisher` = VALUES(`publisher`),
    `place` = VALUES(`place`),
    `volume` = VALUES(`volume`),
    `issue` = VALUES(`issue`),
    `pages` = VALUES(`pages`),
    `edition` = VALUES(`edition`),
    `doi` = VALUES(`doi`),
    `isbn` = VALUES(`isbn`),
    `url` = VALUES(`url`),
    `language_code` = VALUES(`language_code`),
    `priority` = VALUES(`priority`),
    `evidence_type` = VALUES(`evidence_type`),
    `frzk_relevance` = VALUES(`frzk_relevance`),
    `verification_status` = VALUES(`verification_status`),
    `first_citation_section_code` = VALUES(`first_citation_section_code`),
    `first_citation_note` = VALUES(`first_citation_note`),
    `full_citation_text` = VALUES(`full_citation_text`),
    `short_citation_text` = VALUES(`short_citation_text`),
    `notes` = VALUES(`notes`),
    `created_revision_id` = VALUES(`created_revision_id`);

/* ============================================================
   4. Autoren
   ============================================================ */

INSERT INTO `authors`
(
    `family_name`, `given_names`, `normalized_name`,
    `birth_year`, `death_year`, `notes`
)
VALUES
('Frege','Gottlob','Frege, Gottlob',1848,1925,'Autor von Quelle [62].'),
('Whitehead','Alfred North','Whitehead, Alfred North',1861,1947,'Autor von Quelle [63].'),
('von Bertalanffy','Ludwig','von Bertalanffy, Ludwig',1901,1972,'Autor von Quelle [64].'),
('Wiener','Norbert','Wiener, Norbert',1894,1964,'Autor von Quelle [65].'),
('Ashby','W. Ross','Ashby, W. Ross',1903,1972,'Autor von Quelle [66].'),
('Resnik','Michael D.','Resnik, Michael D.',1938,NULL,'Autor von Quelle [67].'),
('Shapiro','Stewart','Shapiro, Stewart',1951,NULL,'Autor von Quelle [68].'),
('von Foerster','Heinz','von Foerster, Heinz',1911,2002,'Autor von Quelle [69].'),
('Luhmann','Niklas','Luhmann, Niklas',1927,1998,'Autor von Quelle [70].')
ON DUPLICATE KEY UPDATE
    `family_name` = VALUES(`family_name`),
    `given_names` = VALUES(`given_names`),
    `birth_year` = VALUES(`birth_year`),
    `death_year` = VALUES(`death_year`),
    `notes` = VALUES(`notes`);

/* ============================================================
   5. Quellen-Autoren-Verknüpfungen
   ============================================================ */

SET @s62 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 62 LIMIT 1);
SET @s63 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 63 LIMIT 1);
SET @s64 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 64 LIMIT 1);
SET @s65 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 65 LIMIT 1);
SET @s66 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 66 LIMIT 1);
SET @s67 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 67 LIMIT 1);
SET @s68 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 68 LIMIT 1);
SET @s69 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 69 LIMIT 1);
SET @s70 := (SELECT `source_id` FROM `sources` WHERE `citation_number` = 70 LIMIT 1);

SET @a62 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Frege, Gottlob' LIMIT 1);
SET @a63 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Whitehead, Alfred North' LIMIT 1);
SET @a64 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'von Bertalanffy, Ludwig' LIMIT 1);
SET @a65 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Wiener, Norbert' LIMIT 1);
SET @a66 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Ashby, W. Ross' LIMIT 1);
SET @a67 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Resnik, Michael D.' LIMIT 1);
SET @a68 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Shapiro, Stewart' LIMIT 1);
SET @a69 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'von Foerster, Heinz' LIMIT 1);
SET @a70 := (SELECT `author_id` FROM `authors` WHERE `normalized_name` = 'Luhmann, Niklas' LIMIT 1);

INSERT IGNORE INTO `source_authors`
(`source_id`, `author_id`, `author_order`, `role`)
VALUES
(@s62,@a62,1,'author'),
(@s63,@a63,1,'author'),
(@s64,@a64,1,'author'),
(@s65,@a65,1,'author'),
(@s66,@a66,1,'author'),
(@s67,@a67,1,'author'),
(@s68,@a68,1,'author'),
(@s69,@a69,1,'author'),
(@s70,@a70,1,'author');

/* ============================================================
   6. Quellenverwendung – Wiederverwendungen
   ============================================================ */

INSERT INTO `source_usage`
(
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`,
    @section_id,
    'reuse',
    CASE s.`citation_number`
        WHEN 18 THEN 'Cassirers Übergang vom Substanz- zum Funktionsbegriff begründet die relationale Bestimmung wissenschaftlicher Gegenstände.'
        WHEN 60 THEN 'Mac Lanes strukturorientierte Mathematik unterstützt den Vorrang von Formen, Funktionen und Transformationen.'
        WHEN 61 THEN 'Eilenberg und Mac Lane begründen den methodischen Vorrang strukturerhaltender Abbildungen.'
    END,
    '3.1.6',
    0,
    1,
    'Bereits früher eingeführte Quelle; in Abschnitt 3.1.6 erneut verwendet.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` IN (18,60,61)
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM `source_usage` u
      WHERE u.`source_id` = s.`source_id`
        AND u.`section_id` = @section_id
        AND u.`usage_type` = 'reuse'
  );

/* ============================================================
   7. Quellenverwendung – neue Quellen
   ============================================================ */

INSERT INTO `source_usage`
(
    `source_id`, `section_id`, `usage_type`, `claim_summary`,
    `exact_location`, `is_first_mention`, `citation_checked`,
    `notes`, `created_revision_id`
)
SELECT
    s.`source_id`,
    @section_id,
    'first_citation',
    CASE s.`citation_number`
        WHEN 62 THEN 'Mathematische Bedeutung kann logisch und relational bestimmt werden, ohne auf anschauliche Objektvorstellungen zurückzugreifen.'
        WHEN 63 THEN 'Stabilität kann als Ergebnis wiederholter Prozesszusammenhänge und nicht als ursprüngliche Substanz verstanden werden.'
        WHEN 64 THEN 'Systemeigenschaften entstehen wesentlich aus der Organisation von Wechselwirkungen.'
        WHEN 65 THEN 'Rückkopplung, Steuerung und Kommunikation begründen rekursive funktionale Organisation.'
        WHEN 66 THEN 'Zustandsübergänge ermöglichen eine formale Beschreibung von Veränderung ohne notwendige räumliche Bewegung.'
        WHEN 67 THEN 'Mathematische Objekte werden durch Positionen innerhalb von Strukturen und Mustern bestimmt.'
        WHEN 68 THEN 'Die Identität mathematischer Gegenstände entsteht durch ihre Stellung in einer Struktur.'
        WHEN 69 THEN 'Beobachter und Beschreibungssysteme können Teil rekursiver Wirkungszusammenhänge sein.'
        WHEN 70 THEN 'Systembestand kann durch die fortgesetzte Anschlussfähigkeit von Operationen erklärt werden.'
    END,
    '3.1.6',
    1,
    1,
    'Erstverwendung im Abschnitt 3.1.6.',
    @revision_id
FROM `sources` s
WHERE s.`citation_number` BETWEEN 62 AND 70
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM `source_usage` u
      WHERE u.`source_id` = s.`source_id`
        AND u.`section_id` = @section_id
        AND u.`usage_type` = 'first_citation'
  );

/* ============================================================
   8. Änderungsprotokoll
   ============================================================ */

INSERT INTO `section_change_log`
(
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
SELECT
    @revision_id, @section_id, 'created', 'section', '3.1.6',
    'Abschnitt 3.1.6 „Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft“ wurde vollständig angelegt und abgeschlossen.',
    NULL,
    'Quellen [18], [60], [61] sowie [62] bis [70]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `object_reference` = '3.1.6'
);

INSERT INTO `section_change_log`
(
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
SELECT
    @revision_id, @section_id, 'source_added', 'source_range', '[62]-[70]',
    'Die neuen Quellen [62] bis [70] wurden aufgenommen und mit Abschnitt 3.1.6 verknüpft.',
    'last_citation_number=61',
    'last_citation_number=70'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `object_reference` = '[62]-[70]'
);

INSERT INTO `section_change_log`
(
    `revision_id`, `section_id`, `change_type`, `object_type`,
    `object_reference`, `change_summary`, `previous_value`, `new_value`
)
SELECT
    @revision_id, @section_id, 'status_changed', 'section', '3.1.6-ABSCHLUSS',
    'Abschnitt 3.1.6 wurde als vollständig abgeschlossen markiert.',
    'draft',
    'final'
WHERE NOT EXISTS
(
    SELECT 1
    FROM `section_change_log`
    WHERE `revision_id` = @revision_id
      AND `object_reference` = '3.1.6-ABSCHLUSS'
);

/* ============================================================
   9. Repository-Zähler
   ============================================================ */

INSERT INTO `repository_counters` (`counter_key`, `counter_value`)
VALUES
    ('last_completed_section', '3.1.6'),
    ('current_section', '3.1.7'),
    ('last_citation_number', '70'),
    ('next_citation_number', '71')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* ============================================================
   10. Validierungen
   ============================================================ */

SET @section_count :=
(
    SELECT COUNT(*)
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1.6'
);

SET @new_source_count :=
(
    SELECT COUNT(*)
    FROM `sources`
    WHERE `citation_number` BETWEEN 62 AND 70
);

SET @reuse_count :=
(
    SELECT COUNT(DISTINCT s.`citation_number`)
    FROM `source_usage` u
    JOIN `sources` s ON s.`source_id` = u.`source_id`
    WHERE u.`section_id` = @section_id
      AND s.`citation_number` IN (18,60,61)
);

SET @new_usage_count :=
(
    SELECT COUNT(DISTINCT s.`citation_number`)
    FROM `source_usage` u
    JOIN `sources` s ON s.`source_id` = u.`source_id`
    WHERE u.`section_id` = @section_id
      AND s.`citation_number` BETWEEN 62 AND 70
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM `equations`
    WHERE `section_id` = @section_id
);

INSERT INTO `repository_validation_results`
(
    `revision_id`, `validation_code`, `validation_status`,
    `expected_value`, `actual_value`, `validation_message`
)
VALUES
(@revision_id,'K3_1_6_SECTION',IF(@section_count=1,'passed','failed'),'1',CAST(@section_count AS CHAR),'Abschnitt 3.1.6 muss genau einmal vorhanden sein.'),
(@revision_id,'K3_1_6_NEW_SOURCES',IF(@new_source_count=9,'passed','failed'),'9',CAST(@new_source_count AS CHAR),'Die Quellen [62] bis [70] müssen vollständig vorhanden sein.'),
(@revision_id,'K3_1_6_REUSED_SOURCES',IF(@reuse_count=3,'passed','failed'),'3',CAST(@reuse_count AS CHAR),'Die Quellen [18], [60] und [61] müssen mit Abschnitt 3.1.6 verknüpft sein.'),
(@revision_id,'K3_1_6_NEW_USAGE',IF(@new_usage_count=9,'passed','failed'),'9',CAST(@new_usage_count AS CHAR),'Alle Quellen [62] bis [70] müssen mit Abschnitt 3.1.6 verknüpft sein.'),
(@revision_id,'K3_1_6_NO_EQUATIONS',IF(@equation_count=0,'passed','failed'),'0',CAST(@equation_count AS CHAR),'Abschnitt 3.1.6 enthält keine nummerierten Gleichungen.')
ON DUPLICATE KEY UPDATE
    `validation_status` = VALUES(`validation_status`),
    `expected_value` = VALUES(`expected_value`),
    `actual_value` = VALUES(`actual_value`),
    `validation_message` = VALUES(`validation_message`),
    `checked_at` = CURRENT_TIMESTAMP;

COMMIT;

/* ============================================================
   11. Kontrollausgaben
   ============================================================ */

SELECT
    `revision_id`, `revision_code`, `scope_reference`,
    `version_label`, `parent_revision_id`
FROM `repository_revisions`
WHERE `revision_code` = 'RKB-NEU-K3.1.6-ABSCHLUSS-V1';

SELECT
    `section_id`, `parent_section_id`, `section_code`, `title`,
    `chapter_no`, `section_order`, `status`, `notes`
FROM `dissertation_sections`
WHERE `section_code` = '3.1.6';

SELECT
    `citation_number`, `source_key`, `title`, `year_edition`
FROM `sources`
WHERE `citation_number` BETWEEN 62 AND 70
ORDER BY `citation_number`;

SELECT
    s.`citation_number`, u.`usage_type`, u.`claim_summary`
FROM `source_usage` u
JOIN `sources` s ON s.`source_id` = u.`source_id`
WHERE u.`section_id` = @section_id
  AND s.`citation_number` IN (18,60,61)
ORDER BY s.`citation_number`;

SELECT
    `validation_code`, `validation_status`,
    `expected_value`, `actual_value`, `validation_message`
FROM `repository_validation_results`
WHERE `revision_id` = @revision_id
ORDER BY `validation_code`;

SELECT `counter_key`, `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
(
    'last_completed_section',
    'current_section',
    'last_citation_number',
    'next_citation_number'
)
ORDER BY `counter_key`;
