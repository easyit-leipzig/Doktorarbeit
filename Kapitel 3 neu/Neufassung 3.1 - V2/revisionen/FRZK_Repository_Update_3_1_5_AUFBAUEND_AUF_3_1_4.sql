/* ============================================================
   FRZK-RKB – REPOSITORY-UPDATE
   Abschnitt 3.1.5 – Methodologische Konsequenzen für das
   Funktionale Raum-Zeit-Kohärenzsystem

   VERBINDLICHE AUSGANGSBASIS:
   frzk_rkb_nach_3.1.4.sql

   Verifizierter Ausgangsstand:
   - Elternrevision: RKB-NEU-K3.1.4-V1
   - Abschnitt 3.1 vorhanden
   - nächste freie Literaturzahl: 56
   - neue Quellen: [56]–[57]
   - keine neuen Gleichungen
   - keine neuen Definitionen, Theoreme oder Axiome

   Das Skript ist für den einmaligen Import auf genau diesem
   Ausgangsstand vorgesehen und bricht bei Abweichungen kontrolliert ab.
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;


/* ============================================================
   0. AUSGANGSSTAND ERMITTELN
   ============================================================ */

SET @parent_revision_id := (
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `revision_code` = 'RKB-NEU-K3.1.4-V1'
      AND `scope_reference` = '3.1.4'
    LIMIT 1
);

SET @parent_section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '3.1'
    LIMIT 1
);

SET @counter_value := (
    SELECT CAST(`counter_value` AS UNSIGNED)
    FROM `repository_counters`
    WHERE `counter_key` = 'next_citation_number'
    LIMIT 1
);


/* ============================================================
   1. PREFLIGHT-PRÜFUNG
   ============================================================ */

DROP PROCEDURE IF EXISTS `frzk_preflight_3_1_5`;

DELIMITER $$

CREATE PROCEDURE `frzk_preflight_3_1_5`()
BEGIN
    IF @parent_revision_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: Elternrevision RKB-NEU-K3.1.4-V1 fehlt.';
    END IF;

    IF @parent_section_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: Übergeordneter Abschnitt 3.1 fehlt.';
    END IF;

    IF @counter_value IS NULL OR @counter_value <> 56 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: next_citation_number ist nicht 56.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `repository_revisions`
        WHERE `revision_code` = 'RKB-NEU-K3.1.5-V1'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: Revision RKB-NEU-K3.1.5-V1 existiert bereits.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `dissertation_sections`
        WHERE `section_code` = '3.1.5'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: Abschnitt 3.1.5 existiert bereits.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `sources`
        WHERE `citation_number` IN (56,57)
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: Literaturzahl [56] oder [57] ist bereits belegt.';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM `sources`
        WHERE `source_key` IN (
            'mac_lane_mathematics_form_function_1986',
            'eilenberg_mac_lane_natural_equivalences_1945'
        )
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            '3.1.5: Mindestens ein vorgesehener source_key existiert bereits.';
    END IF;
END$$

DELIMITER ;

CALL `frzk_preflight_3_1_5`();
DROP PROCEDURE `frzk_preflight_3_1_5`;


/* ============================================================
   2. REVISION ANLEGEN
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
    'RKB-NEU-K3.1.5-V1',
    NOW(),
    'section',
    '3.1.5',
    '1.0',
    'Vollständige Neufassung von Abschnitt 3.1.5 Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem. Aufnahme der neuen Quellen [56] und [57].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);

SET @revision_id := LAST_INSERT_ID();


/* ============================================================
   3. ABSCHNITT 3.1.5 ANLEGEN
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
    '3.1.5',
    'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem',
    3,
    3.1500,
    'final',
    1,
    'Festlegung der methodologischen Arbeitsregeln des FRZK: schrittweiser Aufbau, Vermeidung verdeckter Voraussetzungen, Trennung von mathematischer Konstruktion und empirischer Interpretation, Strukturerhaltung, Modularisierung, Versionierung und Vorrang der mathematischen Rekonstruktion.'
);

SET @section_id := LAST_INSERT_ID();


/* ============================================================
   4. AUTOREN ANLEGEN ODER WIEDERVERWENDEN
   ============================================================ */

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `birth_year`,
    `death_year`,
    `notes`
)
SELECT
    'Mac Lane',
    'Saunders',
    'Mac Lane, Saunders',
    1909,
    2005,
    'Mathematiker; für Abschnitt 3.1.5 registriert.'
WHERE NOT EXISTS (
    SELECT 1
    FROM `authors`
    WHERE `normalized_name` = 'Mac Lane, Saunders'
);

INSERT INTO `authors`
(
    `family_name`,
    `given_names`,
    `normalized_name`,
    `birth_year`,
    `death_year`,
    `notes`
)
SELECT
    'Eilenberg',
    'Samuel',
    'Eilenberg, Samuel',
    1913,
    1998,
    'Mathematiker; für Abschnitt 3.1.5 registriert.'
WHERE NOT EXISTS (
    SELECT 1
    FROM `authors`
    WHERE `normalized_name` = 'Eilenberg, Samuel'
);

SET @author_mac_lane := (
    SELECT `author_id`
    FROM `authors`
    WHERE `normalized_name` = 'Mac Lane, Saunders'
    LIMIT 1
);

SET @author_eilenberg := (
    SELECT `author_id`
    FROM `authors`
    WHERE `normalized_name` = 'Eilenberg, Samuel'
    LIMIT 1
);


/* ============================================================
   5. QUELLEN [56]–[57]
   ============================================================ */

INSERT INTO `sources`
(
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `subtitle`,
    `year_original`,
    `year_edition`,
    `journal`,
    `publisher`,
    `place`,
    `volume`,
    `issue`,
    `pages`,
    `edition`,
    `doi`,
    `isbn`,
    `url`,
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
    56,
    'mac_lane_mathematics_form_function_1986',
    'book',
    'Mathematics: Form and Function',
    NULL,
    1986,
    1986,
    NULL,
    'Springer',
    'New York',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'secondary',
    9,
    'verified',
    '3.1.5',
    'Erstnennung zur strukturorientierten Auffassung mathematischer Theorien und zur funktionalen Bestimmung mathematischer Objekte.',
    'Mac Lane, Saunders: Mathematics: Form and Function. New York: Springer, 1986.',
    'Mac Lane (1986) [56]',
    'Methodologische Grundlage für die relationale und strukturorientierte Entwicklung des FRZK.',
    @revision_id
),
(
    57,
    'eilenberg_mac_lane_natural_equivalences_1945',
    'journal_article',
    'General Theory of Natural Equivalences',
    NULL,
    1945,
    1945,
    'Transactions of the American Mathematical Society',
    NULL,
    NULL,
    '58',
    NULL,
    '231–294',
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.1.5',
    'Erstnennung zur kategorialen Untersuchung strukturerhaltender Abbildungen und natürlicher Äquivalenzen.',
    'Eilenberg, Samuel; Mac Lane, Saunders: General Theory of Natural Equivalences. In: Transactions of the American Mathematical Society, Band 58, 1945, S. 231–294.',
    'Eilenberg und Mac Lane (1945) [57]',
    'Primärquelle zur Entstehung der Kategorientheorie und zum methodischen Vorrang strukturerhaltender Abbildungen.',
    @revision_id
);

SET @source_56 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` = 'mac_lane_mathematics_form_function_1986'
    LIMIT 1
);

SET @source_57 := (
    SELECT `source_id`
    FROM `sources`
    WHERE `source_key` = 'eilenberg_mac_lane_natural_equivalences_1945'
    LIMIT 1
);


/* ============================================================
   6. AUTOREN MIT QUELLEN VERKNÜPFEN
   ============================================================ */

INSERT INTO `source_authors`
(
    `source_id`,
    `author_id`,
    `author_order`,
    `role`
)
VALUES
(
    @source_56,
    @author_mac_lane,
    1,
    'author'
),
(
    @source_57,
    @author_eilenberg,
    1,
    'author'
),
(
    @source_57,
    @author_mac_lane,
    2,
    'author'
);


/* ============================================================
   7. QUELLENVERWENDUNGEN DOKUMENTIEREN
   ============================================================ */

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
    @source_56,
    @section_id,
    'first_citation',
    'Mathematische Theorien werden methodisch durch Formen, Funktionen und Beziehungen zwischen Objekten bestimmt; dies stützt die strukturorientierte Identifikation funktionaler Zustände.',
    'Abschnitt 3.1.5',
    1,
    1,
    'Erstnennung als Quelle [56].',
    @revision_id
),
(
    @source_57,
    @section_id,
    'first_citation',
    'Strukturerhaltende Abbildungen und natürliche Äquivalenzen bilden eine methodische Grundlage für die Untersuchung von Transformationen, ohne das FRZK selbst kategorial zu definieren.',
    'Abschnitt 3.1.5',
    1,
    1,
    'Erstnennung als Quelle [57].',
    @revision_id
);


/* ============================================================
   8. ÄNDERUNGSPROTOKOLL
   ============================================================ */

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
    'created',
    'section',
    '3.1.5',
    'Abschnitt 3.1.5 vollständig neu erstellt.',
    NULL,
    'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem'
),
(
    @revision_id,
    @section_id,
    'source_added',
    'source',
    '[56]–[57]',
    'Zwei neue methodologische und mathematische Grundlagenquellen wurden aufgenommen.',
    NULL,
    'Mac Lane [56]; Eilenberg und Mac Lane [57]'
),
(
    @revision_id,
    @section_id,
    'other',
    'methodological_framework',
    'FRZK-Arbeitsregeln',
    'Methodologische Regeln für den weiteren Aufbau des FRZK wurden explizit dokumentiert.',
    NULL,
    'Schrittweiser Aufbau; keine verdeckten Voraussetzungen; Strukturerhaltung; Trennung von Konstruktion und Interpretation; Modularisierung; Reproduzierbarkeit; Vorrang der mathematischen Rekonstruktion'
),
(
    @revision_id,
    @section_id,
    'status_changed',
    'section',
    '3.1.5',
    'Bearbeitungsstatus auf final gesetzt.',
    'draft',
    'final'
);


/* ============================================================
   9. REPOSITORY-ZÄHLER AKTUALISIEREN
   Nach Quelle [57] ist die nächste freie Literaturzahl 58.
   ============================================================ */

UPDATE `repository_counters`
SET
    `counter_value` = '58',
    `updated_at` = CURRENT_TIMESTAMP
WHERE `counter_key` = 'next_citation_number';

COMMIT;


/* ============================================================
   10. ABSCHLUSSVALIDIERUNG
   ============================================================ */

SELECT
    `revision_id`,
    `revision_code`,
    `scope_reference`,
    `version_label`,
    `parent_revision_id`,
    `summary`
FROM `repository_revisions`
WHERE `revision_code` = 'RKB-NEU-K3.1.5-V1';

SELECT
    `section_id`,
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` = '3.1.5';

SELECT
    `citation_number`,
    `source_key`,
    `title`,
    `first_citation_section_code`,
    `verification_status`
FROM `sources`
WHERE `citation_number` BETWEEN 56 AND 57
ORDER BY `citation_number`;

SELECT
    s.`citation_number`,
    s.`source_key`,
    a.`normalized_name`,
    sa.`author_order`,
    sa.`role`
FROM `source_authors` sa
INNER JOIN `sources` s
    ON s.`source_id` = sa.`source_id`
INNER JOIN `authors` a
    ON a.`author_id` = sa.`author_id`
WHERE s.`citation_number` BETWEEN 56 AND 57
ORDER BY s.`citation_number`, sa.`author_order`;

SELECT
    s.`citation_number`,
    su.`usage_type`,
    su.`is_first_mention`,
    su.`citation_checked`,
    su.`claim_summary`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
WHERE su.`section_id` = @section_id
ORDER BY s.`citation_number`;

SELECT
    `counter_key`,
    `counter_value`,
    `updated_at`
FROM `repository_counters`
WHERE `counter_key` = 'next_citation_number';

SELECT
    'IMPORT 3.1.5 AUF BASIS DES STANDS NACH 3.1.4 ABGESCHLOSSEN'
    AS `status`;
