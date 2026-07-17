/* ============================================================
   FRZK-RKB – REPOSITORY-UPDATE
   Abschnitt 3.1.3 – Physikalische Grundlagen

   VERBINDLICHE AUSGANGSBASIS:
   frzk_rkb_rev_3.1.2.sql

   Bereits vorhandene und wiederverwendete Quellen:
   [1] Newton, Principia (1687)
   [2] Einstein, Allgemeine Relativitätstheorie (1916)
   [3] Rovelli, Quantum Gravity (2004)
   [5] Weinberg, The Quantum Theory of Fields I (1995)

   Neue Quellen dieses Abschnitts:
   [26]–[40]

   Konsequenz für den Manuskripttext von 3.1.3:
   - Newton: [1], nicht [26]
   - Einstein 1916: [2], nicht [30]
   - Rovelli: [3], nicht [38]
   - Weinberg: [5], nicht [36]

   Keine neuen Gleichungen in Abschnitt 3.1.3.
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;


/* ============================================================
   0. VERBINDLICHE BASIS PRÜFEN
   ============================================================ */

SET @parent_revision_id := (
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `revision_code` = 'RKB-NEU-K3.1.2-V1'
    LIMIT 1
);

SET @parent_section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1'
    LIMIT 1
);

SET @source_1 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` = 'newton_principia_1687'
      AND `citation_number` = 1
    LIMIT 1
);

SET @source_2 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` = 'einstein_allgemeine_relativitaetstheorie_1916'
      AND `citation_number` = 2
    LIMIT 1
);

SET @source_3 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` = 'rovelli_quantum_gravity_2004'
      AND `citation_number` = 3
    LIMIT 1
);

SET @source_5 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` = 'weinberg_quantum_fields_vol1_1995'
      AND `citation_number` = 5
    LIMIT 1
);

DROP PROCEDURE IF EXISTS `frzk_preflight_3_1_3`;

DELIMITER $$

CREATE PROCEDURE `frzk_preflight_3_1_3`()
BEGIN
    IF @parent_revision_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Elternrevision RKB-NEU-K3.1.2-V1 fehlt.';
    END IF;

    IF @parent_section_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Übergeordneter Abschnitt 3.1 fehlt.';
    END IF;

    IF @source_1 IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Vorhandene Quelle [1] Newton wurde nicht gefunden.';
    END IF;

    IF @source_2 IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Vorhandene Quelle [2] Einstein 1916 wurde nicht gefunden.';
    END IF;

    IF @source_3 IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Vorhandene Quelle [3] Rovelli wurde nicht gefunden.';
    END IF;

    IF @source_5 IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Vorhandene Quelle [5] Weinberg wurde nicht gefunden.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `repository_revisions`
        WHERE `revision_code` = 'RKB-NEU-K3.1.3-V1'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Revision RKB-NEU-K3.1.3-V1 existiert bereits.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `dissertation_sections`
        WHERE `section_code` = '3.1.3'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Abschnitt 3.1.3 existiert bereits.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `sources`
        WHERE `citation_number` BETWEEN 26 AND 40
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.3: Mindestens eine Literaturzahl [26]-[40] ist bereits belegt.';
    END IF;
END$$

DELIMITER ;

CALL `frzk_preflight_3_1_3`();
DROP PROCEDURE `frzk_preflight_3_1_3`;


/* ============================================================
   1. REVISION UND ABSCHNITT 3.1.3
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
    'RKB-NEU-K3.1.3-V1',
    NOW(),
    'section',
    '3.1.3',
    '1.0',
    'Vollständige Neufassung von Abschnitt 3.1.3 Physikalische Grundlagen. Wiederverwendung der Quellen [1], [2], [3] und [5] sowie Aufnahme der neuen Quellen [26] bis [40].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);

SET @revision_id := LAST_INSERT_ID();

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
    '3.1.3',
    'Physikalische Grundlagen',
    3,
    3.1300,
    'final',
    0,
    'Analyse klassischer, relativistischer, quantenmechanischer und emergenter Raum-Zeit-Konzeptionen. Klare Trennung zwischen mathematischer Rekonstruktion und physikalischem Geltungsanspruch.'
);

SET @section_id := LAST_INSERT_ID();


/* ============================================================
   2. AUTOREN
   Vorhandene Autoren werden wiederverwendet.
   Neue Autoren werden nur angelegt, wenn sie fehlen.
   ============================================================ */

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Mach', 'Ernst', 'Mach, Ernst', 1838, 1916, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Mach, Ernst'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Minkowski', 'Hermann', 'Minkowski, Hermann', 1864, 1909, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Minkowski, Hermann'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Weyl', 'Hermann', 'Weyl, Hermann', 1885, 1955, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Weyl, Hermann'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Wald', 'Robert M.', 'Wald, Robert M.', 1947, NULL, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Wald, Robert M.'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Hawking', 'Stephen W.', 'Hawking, Stephen W.', 1942, 2018, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Hawking, Stephen W.'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Ellis', 'George F. R.', 'Ellis, George F. R.', 1939, NULL, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Ellis, George F. R.'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'von Neumann', 'John', 'von Neumann, John', 1903, 1957, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'von Neumann, John'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Dirac', 'Paul A. M.', 'Dirac, Paul A. M.', 1902, 1984, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Dirac, Paul A. M.'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'DeWitt', 'Bryce S.', 'DeWitt, Bryce S.', 1923, 2004, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'DeWitt, Bryce S.'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `death_year`, `notes`)
SELECT 'Kiefer', 'Claus', 'Kiefer, Claus', 1958, NULL, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Kiefer, Claus'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `notes`)
SELECT 'Bombelli', 'Luca', 'Bombelli, Luca', 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Bombelli, Luca'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `notes`)
SELECT 'Lee', 'Joohan', 'Lee, Joohan', 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Lee, Joohan'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `notes`)
SELECT 'Meyer', 'David', 'Meyer, David', 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Meyer, David'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `notes`)
SELECT 'Sorkin', 'Rafael D.', 'Sorkin, Rafael D.', 1945, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Sorkin, Rafael D.'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `notes`)
SELECT 'Jacobson', 'Ted', 'Jacobson, Ted', 1954, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Jacobson, Ted'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `notes`)
SELECT 'Ryu', 'Shinsei', 'Ryu, Shinsei', 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Ryu, Shinsei'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `notes`)
SELECT 'Takayanagi', 'Tadashi', 'Takayanagi, Tadashi', 1975, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Takayanagi, Tadashi'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `notes`)
SELECT 'Van Raamsdonk', 'Mark', 'Van Raamsdonk, Mark', 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Van Raamsdonk, Mark'
);

INSERT INTO `authors`
(`family_name`, `given_names`, `normalized_name`, `birth_year`, `notes`)
SELECT 'Verlinde', 'Erik', 'Verlinde, Erik', 1962, 'Für Abschnitt 3.1.3 registriert.'
WHERE NOT EXISTS (
    SELECT 1 FROM `authors`
    WHERE `normalized_name` = 'Verlinde, Erik'
);

SET @author_mach := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Mach, Ernst' LIMIT 1
);
SET @author_einstein := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Einstein, Albert' LIMIT 1
);
SET @author_minkowski := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Minkowski, Hermann' LIMIT 1
);
SET @author_weyl := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Weyl, Hermann' LIMIT 1
);
SET @author_wald := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Wald, Robert M.' LIMIT 1
);
SET @author_hawking := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Hawking, Stephen W.' LIMIT 1
);
SET @author_ellis := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Ellis, George F. R.' LIMIT 1
);
SET @author_neumann := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'von Neumann, John' LIMIT 1
);
SET @author_dirac := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Dirac, Paul A. M.' LIMIT 1
);
SET @author_dewitt := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'DeWitt, Bryce S.' LIMIT 1
);
SET @author_kiefer := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Kiefer, Claus' LIMIT 1
);
SET @author_bombelli := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Bombelli, Luca' LIMIT 1
);
SET @author_lee := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Lee, Joohan' LIMIT 1
);
SET @author_meyer := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Meyer, David' LIMIT 1
);
SET @author_sorkin := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Sorkin, Rafael D.' LIMIT 1
);
SET @author_jacobson := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Jacobson, Ted' LIMIT 1
);
SET @author_ryu := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Ryu, Shinsei' LIMIT 1
);
SET @author_takayanagi := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Takayanagi, Tadashi' LIMIT 1
);
SET @author_van_raamsdonk := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Van Raamsdonk, Mark' LIMIT 1
);
SET @author_verlinde := (
    SELECT `author_id` FROM `authors`
    WHERE `normalized_name` = 'Verlinde, Erik' LIMIT 1
);


/* ============================================================
   3. NEUE QUELLEN [26]–[40]
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
(26,'mach_mechanik_1883','historical_work',
 'Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt',
 NULL,1883,1883,NULL,'F. A. Brockhaus','Leipzig',
 NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'de',1,'historical',9,'verified','3.1.3',
 'Erstnennung zur relationalen Kritik des absoluten Raumes.',
 'Mach, Ernst: Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt. Leipzig: F. A. Brockhaus, 1883.',
 'Mach, Mechanik [26]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(27,'einstein_elektrodynamik_1905','journal_article',
 'Zur Elektrodynamik bewegter Körper',
 NULL,1905,1905,'Annalen der Physik',NULL,NULL,
 '17',NULL,'891–921',NULL,NULL,NULL,NULL,
 'de',1,'primary',10,'verified','3.1.3',
 'Erstnennung zur Speziellen Relativitätstheorie und Relativität der Gleichzeitigkeit.',
 'Einstein, Albert: Zur Elektrodynamik bewegter Körper. In: Annalen der Physik, Band 17, 1905, S. 891–921.',
 'Einstein (1905) [27]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(28,'minkowski_raum_zeit_1909','historical_work',
 'Raum und Zeit',
 NULL,1908,1909,NULL,'B. G. Teubner','Leipzig',
 NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'de',1,'historical',10,'verified','3.1.3',
 'Erstnennung zur vierdimensionalen Zusammenführung von Raum und Zeit.',
 'Minkowski, Hermann: Raum und Zeit. Leipzig: B. G. Teubner, 1909.',
 'Minkowski, Raum und Zeit [28]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(29,'weyl_raum_zeit_materie_1923','book',
 'Raum – Zeit – Materie',
 'Vorlesungen über allgemeine Relativitätstheorie',
 1918,1923,NULL,'Springer','Berlin',
 NULL,NULL,NULL,'5. Auflage',NULL,NULL,NULL,
 'de',1,'primary',9,'verified','3.1.3',
 'Erstnennung zur Verbindung von Geometrie, Materie und Feldstrukturen.',
 'Weyl, Hermann: Raum – Zeit – Materie. Vorlesungen über allgemeine Relativitätstheorie. 5. Auflage. Berlin: Springer, 1923.',
 'Weyl, Raum – Zeit – Materie [29]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(30,'wald_general_relativity_1984','book',
 'General Relativity',
 NULL,1984,1984,NULL,'University of Chicago Press','Chicago',
 NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'en',1,'textbook',9,'verified','3.1.3',
 'Erstnennung zur mathematischen Struktur der Allgemeinen Relativitätstheorie.',
 'Wald, Robert M.: General Relativity. Chicago: University of Chicago Press, 1984.',
 'Wald (1984) [30]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(31,'hawking_ellis_large_scale_1973','book',
 'The Large Scale Structure of Space-Time',
 NULL,1973,1973,NULL,'Cambridge University Press','Cambridge',
 NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'en',1,'primary',9,'verified','3.1.3',
 'Erstnennung zu Raumzeitstruktur, geodätischer Unvollständigkeit und Singularitätssätzen.',
 'Hawking, Stephen W.; Ellis, George F. R.: The Large Scale Structure of Space-Time. Cambridge: Cambridge University Press, 1973.',
 'Hawking und Ellis [31]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(32,'von_neumann_quantenmechanik_1932','book',
 'Mathematische Grundlagen der Quantenmechanik',
 NULL,1932,1932,NULL,'Julius Springer','Berlin',
 NULL,NULL,NULL,NULL,NULL,NULL,NULL,
 'de',1,'primary',10,'verified','3.1.3',
 'Erstnennung zur Hilbertraumformulierung der Quantenmechanik.',
 'von Neumann, John: Mathematische Grundlagen der Quantenmechanik. Berlin: Julius Springer, 1932.',
 'von Neumann (1932) [32]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(33,'dirac_principles_quantum_mechanics_1930','book',
 'The Principles of Quantum Mechanics',
 NULL,1930,1930,NULL,'Clarendon Press','Oxford',
 NULL,NULL,NULL,'1st edition',NULL,NULL,NULL,
 'en',1,'primary',10,'verified','3.1.3',
 'Erstnennung zur abstrakten Zustands- und Operatorformulierung der Quantenmechanik.',
 'Dirac, Paul A. M.: The Principles of Quantum Mechanics. Oxford: Clarendon Press, 1930.',
 'Dirac (1930) [33]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(34,'dewitt_quantum_gravity_canonical_1967','journal_article',
 'Quantum Theory of Gravity. I. The Canonical Theory',
 NULL,1967,1967,'Physical Review',NULL,NULL,
 '160',NULL,'1113–1148',NULL,'10.1103/PhysRev.160.1113',NULL,NULL,
 'en',1,'primary',10,'verified','3.1.3',
 'Erstnennung zur kanonischen Quantisierung der Gravitation.',
 'DeWitt, Bryce S.: Quantum Theory of Gravity. I. The Canonical Theory. In: Physical Review, Band 160, 1967, S. 1113–1148.',
 'DeWitt (1967) [34]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(35,'kiefer_quantum_gravity_2012','book',
 'Quantum Gravity',
 NULL,2004,2012,NULL,'Oxford University Press','Oxford',
 NULL,NULL,NULL,'3rd edition',NULL,NULL,NULL,
 'en',1,'textbook',9,'verified','3.1.3',
 'Erstnennung zur vergleichenden Darstellung quantengravitativer Ansätze.',
 'Kiefer, Claus: Quantum Gravity. 3. Auflage. Oxford: Oxford University Press, 2012.',
 'Kiefer (2012) [35]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(36,'bombelli_lee_meyer_sorkin_causal_set_1987','journal_article',
 'Space-Time as a Causal Set',
 NULL,1987,1987,'Physical Review Letters',NULL,NULL,
 '59',NULL,'521–524',NULL,'10.1103/PhysRevLett.59.521',NULL,NULL,
 'en',1,'primary',10,'verified','3.1.3',
 'Erstnennung zur diskreten kausalen Ordnung als möglicher Grundlage kontinuierlicher Raumzeit.',
 'Bombelli, Luca; Lee, Joohan; Meyer, David; Sorkin, Rafael D.: Space-Time as a Causal Set. In: Physical Review Letters, Band 59, 1987, S. 521–524.',
 'Bombelli et al. (1987) [36]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(37,'jacobson_thermodynamics_spacetime_1995','journal_article',
 'Thermodynamics of Spacetime: The Einstein Equation of State',
 NULL,1995,1995,'Physical Review Letters',NULL,NULL,
 '75',NULL,'1260–1263',NULL,'10.1103/PhysRevLett.75.1260',NULL,NULL,
 'en',1,'primary',10,'verified','3.1.3',
 'Erstnennung zur thermodynamischen Herleitung der Einstein-Gleichung.',
 'Jacobson, Ted: Thermodynamics of Spacetime: The Einstein Equation of State. In: Physical Review Letters, Band 75, 1995, S. 1260–1263.',
 'Jacobson (1995) [37]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(38,'ryu_takayanagi_holographic_entanglement_2006','journal_article',
 'Holographic Derivation of Entanglement Entropy from AdS/CFT',
 NULL,2006,2006,'Physical Review Letters',NULL,NULL,
 '96',NULL,'181602',NULL,'10.1103/PhysRevLett.96.181602',NULL,NULL,
 'en',1,'primary',10,'verified','3.1.3',
 'Erstnennung zum Zusammenhang von Verschränkungsentropie und Geometrie.',
 'Ryu, Shinsei; Takayanagi, Tadashi: Holographic Derivation of Entanglement Entropy from AdS/CFT. In: Physical Review Letters, Band 96, 2006, Artikel 181602.',
 'Ryu und Takayanagi [38]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(39,'van_raamsdonk_building_spacetime_2010','journal_article',
 'Building up Spacetime with Quantum Entanglement',
 NULL,2010,2010,'General Relativity and Gravitation',NULL,NULL,
 '42',NULL,'2323–2329',NULL,'10.1007/s10714-010-1034-0',NULL,NULL,
 'en',1,'primary',10,'verified','3.1.3',
 'Erstnennung zum Zusammenhang zwischen Raumzeitzusammenhang und Verschränkungsstruktur.',
 'Van Raamsdonk, Mark: Building up Spacetime with Quantum Entanglement. In: General Relativity and Gravitation, Band 42, 2010, S. 2323–2329.',
 'Van Raamsdonk (2010) [39]',
 'Quelle für Abschnitt 3.1.3.',@revision_id),

(40,'verlinde_origin_gravity_2011','journal_article',
 'On the Origin of Gravity and the Laws of Newton',
 NULL,2011,2011,'Journal of High Energy Physics',NULL,NULL,
 NULL,'04','029',NULL,'10.1007/JHEP04(2011)029',NULL,NULL,
 'en',1,'primary',8,'verified','3.1.3',
 'Erstnennung zur entropischen und informationellen Interpretation von Gravitation.',
 'Verlinde, Erik: On the Origin of Gravity and the Laws of Newton. In: Journal of High Energy Physics, Ausgabe 04, 2011, Artikel 029.',
 'Verlinde (2011) [40]',
 'Quelle für Abschnitt 3.1.3.',@revision_id);

SET @source_26 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='mach_mechanik_1883' LIMIT 1
);
SET @source_27 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='einstein_elektrodynamik_1905' LIMIT 1
);
SET @source_28 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='minkowski_raum_zeit_1909' LIMIT 1
);
SET @source_29 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='weyl_raum_zeit_materie_1923' LIMIT 1
);
SET @source_30 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='wald_general_relativity_1984' LIMIT 1
);
SET @source_31 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='hawking_ellis_large_scale_1973' LIMIT 1
);
SET @source_32 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='von_neumann_quantenmechanik_1932' LIMIT 1
);
SET @source_33 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='dirac_principles_quantum_mechanics_1930' LIMIT 1
);
SET @source_34 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='dewitt_quantum_gravity_canonical_1967' LIMIT 1
);
SET @source_35 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='kiefer_quantum_gravity_2012' LIMIT 1
);
SET @source_36 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='bombelli_lee_meyer_sorkin_causal_set_1987' LIMIT 1
);
SET @source_37 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='jacobson_thermodynamics_spacetime_1995' LIMIT 1
);
SET @source_38 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='ryu_takayanagi_holographic_entanglement_2006' LIMIT 1
);
SET @source_39 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='van_raamsdonk_building_spacetime_2010' LIMIT 1
);
SET @source_40 := (
 SELECT `source_id` FROM `sources`
 WHERE `source_key`='verlinde_origin_gravity_2011' LIMIT 1
);


/* ============================================================
   4. AUTORENVERKNÜPFUNGEN DER NEUEN QUELLEN
   ============================================================ */

INSERT INTO `source_authors`
(`source_id`,`author_id`,`author_order`,`role`)
VALUES
(@source_26,@author_mach,1,'author'),
(@source_27,@author_einstein,1,'author'),
(@source_28,@author_minkowski,1,'author'),
(@source_29,@author_weyl,1,'author'),
(@source_30,@author_wald,1,'author'),
(@source_31,@author_hawking,1,'author'),
(@source_31,@author_ellis,2,'author'),
(@source_32,@author_neumann,1,'author'),
(@source_33,@author_dirac,1,'author'),
(@source_34,@author_dewitt,1,'author'),
(@source_35,@author_kiefer,1,'author'),
(@source_36,@author_bombelli,1,'author'),
(@source_36,@author_lee,2,'author'),
(@source_36,@author_meyer,3,'author'),
(@source_36,@author_sorkin,4,'author'),
(@source_37,@author_jacobson,1,'author'),
(@source_38,@author_ryu,1,'author'),
(@source_38,@author_takayanagi,2,'author'),
(@source_39,@author_van_raamsdonk,1,'author'),
(@source_40,@author_verlinde,1,'author');


/* ============================================================
   5. QUELLENVERWENDUNGEN
   Vier vorhandene Quellen werden wiederverwendet.
   Fünfzehn neue Quellen werden erstmals zitiert.
   ============================================================ */

INSERT INTO `source_usage`
(
 `source_id`,`section_id`,`usage_type`,`claim_summary`,
 `exact_location`,`is_first_mention`,`citation_checked`,
 `notes`,`created_revision_id`
)
VALUES
(@source_1,@section_id,'historical_context',
 'Wiederverwendung der Quelle [1] zur klassischen Konzeption von absolutem Raum und absoluter Zeit.',
 'Abschnitt 3.1.3',0,1,
 'Bereits in 3.1.0 erstmals zitierte Quelle.',@revision_id),

(@source_2,@section_id,'background',
 'Wiederverwendung der Quelle [2] zur dynamischen geometrischen Raumzeitbeschreibung der Allgemeinen Relativitätstheorie.',
 'Abschnitt 3.1.3',0,1,
 'Bereits in 3.1.0 erstmals zitierte Quelle.',@revision_id),

(@source_3,@section_id,'state_of_research',
 'Wiederverwendung der Quelle [3] zur Schleifenquantengravitation und relationalen Quantisierung geometrischer Strukturen.',
 'Abschnitt 3.1.3',0,1,
 'Bereits in 3.1.0 erstmals zitierte Quelle.',@revision_id),

(@source_5,@section_id,'background',
 'Wiederverwendung der Quelle [5] zu Grundlagen der Quantenfeldtheorie und zum strukturierten Vakuumbegriff.',
 'Abschnitt 3.1.3',0,1,
 'Bereits in 3.1.1 erstmals zitierte Quelle.',@revision_id),

(@source_26,@section_id,'first_citation',
 'Relationale Kritik des absoluten Raumes und Bestimmung von Bewegung gegenüber materiellen Beziehungen.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [26].',@revision_id),

(@source_27,@section_id,'first_citation',
 'Spezielle Relativitätstheorie, Relativität der Gleichzeitigkeit und beobachterabhängige Raum-Zeit-Messung.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [27].',@revision_id),

(@source_28,@section_id,'first_citation',
 'Vierdimensionale Zusammenführung von Raum und Zeit.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [28].',@revision_id),

(@source_29,@section_id,'first_citation',
 'Verbindung von Geometrie, Materie, Symmetrien und physikalischen Feldern.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [29].',@revision_id),

(@source_30,@section_id,'first_citation',
 'Mathematische Struktur der Allgemeinen Relativitätstheorie auf Lorentz-Mannigfaltigkeiten.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [30].',@revision_id),

(@source_31,@section_id,'first_citation',
 'Kosmologische Raumzeitstruktur, Singularitätssätze und geodätische Unvollständigkeit.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [31].',@revision_id),

(@source_32,@section_id,'first_citation',
 'Hilbertraumformulierung quantenmechanischer Zustände und Observablen.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [32].',@revision_id),

(@source_33,@section_id,'first_citation',
 'Abstrakte Zustands- und Operatorformulierung der Quantenmechanik.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [33].',@revision_id),

(@source_34,@section_id,'first_citation',
 'Kanonische Quantisierung der Gravitation und Einbeziehung der Geometrie in die Quantentheorie.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [34].',@revision_id),

(@source_35,@section_id,'first_citation',
 'Vergleichende Darstellung quantengravitativer Forschungsprogramme und ihrer Grenzen.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [35].',@revision_id),

(@source_36,@section_id,'first_citation',
 'Diskrete kausale Ordnungsstruktur als möglicher Ursprung kontinuierlicher Raumzeit.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [36].',@revision_id),

(@source_37,@section_id,'first_citation',
 'Thermodynamische Rekonstruktion der Einstein-Gleichung.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [37].',@revision_id),

(@source_38,@section_id,'first_citation',
 'Zusammenhang von Verschränkungsentropie und geometrischen Flächen in holografischen Modellen.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [38].',@revision_id),

(@source_39,@section_id,'first_citation',
 'Zusammenhang zwischen Raumzeitzusammenhang und Verschränkungsstruktur.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [39].',@revision_id),

(@source_40,@section_id,'first_citation',
 'Entropische und informationelle Interpretation der Gravitation.',
 'Abschnitt 3.1.3',1,1,'Erstnennung als Quelle [40].',@revision_id);


/* ============================================================
   6. ÄNDERUNGSPROTOKOLL
   ============================================================ */

INSERT INTO `section_change_log`
(
 `revision_id`,`section_id`,`change_type`,`object_type`,
 `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'created','section','3.1.3',
 'Abschnitt 3.1.3 vollständig neu erstellt.',
 NULL,'Physikalische Grundlagen'),

(@revision_id,@section_id,'source_reused','source','[1], [2], [3], [5]',
 'Vier bereits vorhandene Grundlagenquellen wurden korrekt wiederverwendet.',
 NULL,'Newton [1], Einstein 1916 [2], Rovelli [3], Weinberg [5]'),

(@revision_id,@section_id,'source_added','source','[26]–[40]',
 'Fünfzehn neue physikalische Quellen wurden aufgenommen.',
 NULL,'Neue Quellen [26] bis [40]'),

(@revision_id,@section_id,'status_changed','section','3.1.3',
 'Bearbeitungsstatus auf final gesetzt.',
 'draft','final');


/* ============================================================
   7. LITERATURZÄHLER
   Nach [40] ist die nächste freie Zahl 41.
   ============================================================ */

UPDATE `repository_counters`
SET
 `counter_value` = CAST(
    GREATEST(CAST(`counter_value` AS UNSIGNED),41)
    AS CHAR
 ),
 `updated_at` = CURRENT_TIMESTAMP
WHERE `counter_key` = 'next_citation_number';

INSERT INTO `repository_counters`
(`counter_key`,`counter_value`,`updated_at`)
SELECT 'next_citation_number','41',CURRENT_TIMESTAMP
WHERE NOT EXISTS (
 SELECT 1 FROM `repository_counters`
 WHERE `counter_key` = 'next_citation_number'
);

COMMIT;


/* ============================================================
   8. ABSCHLUSSVALIDIERUNG
   ============================================================ */

SELECT
 `revision_id`,`revision_code`,`scope_reference`,
 `version_label`,`parent_revision_id`,`summary`
FROM `repository_revisions`
WHERE `revision_code`='RKB-NEU-K3.1.3-V1';

SELECT
 `section_id`,`parent_section_id`,`section_code`,`title`,
 `chapter_no`,`section_order`,`status`
FROM `dissertation_sections`
WHERE `section_code`='3.1.3';

SELECT
 `citation_number`,`source_key`,`title`,
 `first_citation_section_code`,`verification_status`
FROM `sources`
WHERE `citation_number` BETWEEN 26 AND 40
ORDER BY 1;

SELECT
 s.`citation_number`,
 su.`usage_type`,
 su.`is_first_mention`,
 su.`citation_checked`
FROM `source_usage` su
INNER JOIN `sources` s
 ON s.`source_id`=su.`source_id`
WHERE su.`section_id`=@section_id
ORDER BY 1;

SELECT
 COUNT(*) AS `neue_quellen_26_bis_40`,
 MIN(`citation_number`) AS `min_literaturzahl`,
 MAX(`citation_number`) AS `max_literaturzahl`
FROM `sources`
WHERE `citation_number` BETWEEN 26 AND 40;

SELECT
 `counter_key`,`counter_value`,`updated_at`
FROM `repository_counters`
WHERE `counter_key`='next_citation_number';

SELECT
 'IMPORT 3.1.3 AUF BASIS VON frzk_rkb_rev_3.1.2.sql ABGESCHLOSSEN'
 AS `status`;
