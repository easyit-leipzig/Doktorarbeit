/* ============================================================
   FRZK-RKB – VOLLSTÄNDIGES REPARATUR- UND VALIDIERUNGSSKRIPT
   Fehlerbehebung:
   #1054 - Unbekanntes Tabellenfeld 's.citation_number'
           in ORDER BY
   #1054 - Unbekanntes Tabellenfeld 'counter_name'
           in WHERE

   Schema-Grundlage – direkt aus frzk_rkb(3).sql geprüft:
   - source_authors besitzt nur source_id, author_id, author_order, role
   - sources.citation_number
   - repository_counters.counter_key
   - repository_counters.counter_value
   - repository_counters.updated_at

   Wirkung:
   - KEINE Löschung oder Änderung von Quelleninhalten
   - KEINE erneute Einfügung der Quellen [7]–[25]
   - Reparatur der Literatur-Views
   - Prüfung des Imports von Abschnitt 3.1.2
   - Synchronisierung des Literaturzählers

   Stand: korrigierte Gesamtfassung
   ============================================================ */

SET NAMES utf8mb4;


/* ============================================================
   1. REALE TABELLENSTRUKTUREN PRÜFEN
   ============================================================ */

SHOW COLUMNS FROM `sources`;

SHOW COLUMNS FROM `repository_counters`;

SHOW COLUMNS FROM `source_usage`;

SHOW COLUMNS FROM `dissertation_sections`;


/* ============================================================
   2. DIREKTEN ZUGRIFF AUF SOURCES PRÜFEN

   Die Sortierung erfolgt absichtlich über die Ergebnispositionen,
   nicht über den Tabellenalias s.
   ============================================================ */

SELECT
    `source_id`,
    `citation_number`,
    `source_key`,
    `title`,
    `verification_status`
FROM `sources`
ORDER BY 2, 1
LIMIT 100;


/* ============================================================
   3. VIEW v_chapter_bibliography REPARIEREN

   Das ORDER BY wird vollständig aus der View entfernt.
   Sortierungen erfolgen ausschließlich bei der späteren Abfrage.
   SQL SECURITY INVOKER vermeidet Abhängigkeiten von einem
   möglicherweise nicht vorhandenen DEFINER-Konto.
   ============================================================ */

CREATE OR REPLACE
ALGORITHM = UNDEFINED
SQL SECURITY INVOKER
VIEW `v_chapter_bibliography` AS
SELECT DISTINCT
    ds.`chapter_no`            AS `chapter_no`,
    s.`citation_number`        AS `citation_number`,
    s.`full_citation_text`     AS `full_citation_text`,
    s.`short_citation_text`    AS `short_citation_text`,
    s.`priority`               AS `priority`,
    s.`frzk_relevance`         AS `frzk_relevance`,
    s.`verification_status`    AS `verification_status`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
INNER JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE s.`citation_number` IS NOT NULL;


/* ============================================================
   4. VIEW v_citation_audit REPARIEREN

   Auch diese View enthält kein internes ORDER BY.
   ============================================================ */

CREATE OR REPLACE
ALGORITHM = UNDEFINED
SQL SECURITY INVOKER
VIEW `v_citation_audit` AS
SELECT
    s.`citation_number` AS `citation_number`,
    s.`source_key` AS `source_key`,
    s.`full_citation_text` AS `full_citation_text`,
    s.`verification_status` AS `verification_status`,
    COUNT(su.`usage_id`) AS `usage_count`,
    SUM(
        CASE
            WHEN su.`is_first_mention` = 1 THEN 1
            ELSE 0
        END
    ) AS `first_mention_count`,
    MIN(ds.`section_code`) AS `first_used_section`
FROM `sources` s
LEFT JOIN `source_usage` su
    ON su.`source_id` = s.`source_id`
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
GROUP BY
    s.`source_id`,
    s.`citation_number`,
    s.`source_key`,
    s.`full_citation_text`,
    s.`verification_status`;


/* ============================================================
   5. REPARIERTE VIEWS PRÜFEN

   ORDER BY 1,2 verhindert die fehlerhafte Auflösung eines
   Tabellenaliases innerhalb der Sortierung.
   ============================================================ */

SELECT
    `chapter_no`,
    `citation_number`,
    `full_citation_text`,
    `short_citation_text`,
    `priority`,
    `frzk_relevance`,
    `verification_status`
FROM `v_chapter_bibliography`
ORDER BY 1, 2;

SELECT
    `citation_number`,
    `source_key`,
    `full_citation_text`,
    `verification_status`,
    `usage_count`,
    `first_mention_count`,
    `first_used_section`
FROM `v_citation_audit`
ORDER BY 1;


/* ============================================================
   6. QUELLEN [7]–[25] AUS ABSCHNITT 3.1.2 PRÜFEN
   ============================================================ */

SELECT
    `citation_number`,
    `source_key`,
    `source_type`,
    `title`,
    `year_original`,
    `year_edition`,
    `first_citation_section_code`,
    `verification_status`
FROM `sources`
WHERE `citation_number` BETWEEN 7 AND 25
ORDER BY 1;


/* Erwarteter Umfang: 19 Quellen. */
SELECT
    COUNT(*) AS `anzahl_quellen_7_bis_25`,
    MIN(`citation_number`) AS `kleinste_literaturnummer`,
    MAX(`citation_number`) AS `groesste_literaturnummer`
FROM `sources`
WHERE `citation_number` BETWEEN 7 AND 25;


/* Prüfung auf doppelte Literaturnummern im gesamten Repository. */
SELECT
    `citation_number`,
    COUNT(*) AS `anzahl`
FROM `sources`
WHERE `citation_number` IS NOT NULL
GROUP BY `citation_number`
HAVING COUNT(*) > 1
ORDER BY 1;


/* Prüfung auf doppelte source_keys. */
SELECT
    `source_key`,
    COUNT(*) AS `anzahl`
FROM `sources`
GROUP BY `source_key`
HAVING COUNT(*) > 1
ORDER BY 1;


/* ============================================================
   7. AUTORENZUORDNUNGEN DER QUELLEN [7]–[25] PRÜFEN
   ============================================================ */

SELECT
    s.`citation_number` AS `citation_number`,
    sa.`author_order` AS `author_order`,
    sa.`role` AS `role`,
    a.`normalized_name` AS `normalized_name`
FROM `sources` s
INNER JOIN `source_authors` sa
    ON sa.`source_id` = s.`source_id`
INNER JOIN `authors` a
    ON a.`author_id` = sa.`author_id`
WHERE s.`citation_number` BETWEEN 7 AND 25
ORDER BY 1, 2;


/* Quellen ohne Autoren- oder Herausgeberzuordnung anzeigen. */
SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`
FROM `sources` s
LEFT JOIN `source_authors` sa
    ON sa.`source_id` = s.`source_id`
WHERE s.`citation_number` BETWEEN 7 AND 25
GROUP BY
    s.`source_id`,
    s.`citation_number`,
    s.`source_key`,
    s.`title`
HAVING COUNT(sa.`source_id`) = 0
ORDER BY 1;


/* ============================================================
   8. QUELLENVERWENDUNGEN FÜR ABSCHNITT 3.1.2 PRÜFEN
   ============================================================ */

SELECT
    s.`citation_number` AS `citation_number`,
    ds.`section_code` AS `section_code`,
    su.`usage_type` AS `usage_type`,
    su.`is_first_mention` AS `is_first_mention`,
    su.`citation_checked` AS `citation_checked`,
    su.`claim_summary` AS `claim_summary`
FROM `source_usage` su
INNER JOIN `sources` s
    ON s.`source_id` = su.`source_id`
INNER JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE ds.`section_code` = '3.1.2'
ORDER BY 1;


/* Erwarteter Umfang: grundsätzlich eine Verwendung je Quelle [7]–[25]. */
SELECT
    COUNT(*) AS `anzahl_quellenverwendungen_3_1_2`,
    COUNT(DISTINCT su.`source_id`) AS `unterschiedliche_quellen_3_1_2`
FROM `source_usage` su
INNER JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
WHERE ds.`section_code` = '3.1.2';


/* Quellen [7]–[25] ohne Verwendung in Abschnitt 3.1.2. */
SELECT
    s.`citation_number`,
    s.`source_key`,
    s.`title`
FROM `sources` s
LEFT JOIN `source_usage` su
    ON su.`source_id` = s.`source_id`
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = su.`section_id`
   AND ds.`section_code` = '3.1.2'
WHERE s.`citation_number` BETWEEN 7 AND 25
GROUP BY
    s.`source_id`,
    s.`citation_number`,
    s.`source_key`,
    s.`title`
HAVING COUNT(ds.`section_id`) = 0
ORDER BY 1;


/* ============================================================
   9. REVISION UND ABSCHNITT 3.1.2 PRÜFEN
   ============================================================ */

SELECT
    `revision_id`,
    `revision_code`,
    `revision_date`,
    `scope_type`,
    `scope_reference`,
    `version_label`,
    `parent_revision_id`,
    `summary`
FROM `repository_revisions`
WHERE `revision_code` = 'RKB-NEU-K3.1.2-V1'
   OR `scope_reference` = '3.1.2'
ORDER BY 1;

SELECT
    `section_id`,
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`,
    `notes`
FROM `dissertation_sections`
WHERE `section_code` = '3.1.2';


/* ============================================================
   10. LITERATURZÄHLER KORRIGIEREN

   Reale Spalten:
   - counter_key
   - counter_value
   - updated_at

   Der Zähler wird nur erhöht, niemals vermindert.
   ============================================================ */

UPDATE `repository_counters`
SET
    `counter_value` = CAST(
        GREATEST(
            CAST(`counter_value` AS UNSIGNED),
            COALESCE(
                (
                    SELECT MAX(src.`citation_number`) + 1
                    FROM `sources` src
                ),
                1
            )
        )
        AS CHAR
    ),
    `updated_at` = CURRENT_TIMESTAMP
WHERE `counter_key` = 'next_citation_number';


/* Falls der Zähler wider Erwarten noch nicht existiert, wird er angelegt. */
INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`,
    `updated_at`
)
SELECT
    'next_citation_number',
    CAST(
        COALESCE(
            (
                SELECT MAX(src.`citation_number`) + 1
                FROM `sources` src
            ),
            1
        )
        AS CHAR
    ),
    CURRENT_TIMESTAMP
WHERE NOT EXISTS
(
    SELECT 1
    FROM `repository_counters`
    WHERE `counter_key` = 'next_citation_number'
);


/* ============================================================
   11. ABSCHLUSSPRÜFUNG DES ZÄHLERS
   ============================================================ */

SELECT
    `counter_key`,
    `counter_value`,
    `updated_at`
FROM `repository_counters`
WHERE `counter_key` = 'next_citation_number';

SELECT
    MAX(`citation_number`) AS `hoechste_vergebene_literaturnummer`,
    MAX(`citation_number`) + 1 AS `berechnete_naechste_literaturnummer`
FROM `sources`;


/* ============================================================
   12. ABSCHLUSSSTATUS

   Sind alle folgenden Punkte erfüllt, ist die Reparatur erfolgreich:
   - sources ist direkt lesbar;
   - beide Views sind lesbar;
   - Quellen [7]–[25] werden angezeigt;
   - keine unerwarteten Dubletten erscheinen;
   - Abschnitt 3.1.2 und seine Revision sind vorhanden;
   - next_citation_number entspricht mindestens MAX + 1.
   ============================================================ */

SELECT
    'REPARATUR UND VALIDIERUNG ABGESCHLOSSEN' AS `status`;
