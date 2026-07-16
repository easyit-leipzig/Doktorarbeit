/* =================================================================================================
   FRZK-RKB – ABSCHLUSSREVISION KAPITEL 3.3

   Revision:
     RKB-2026-07-16-K3.3-FINAL-V1

   Parent-Revision:
     RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2

   Zweck:
     - formaler Abschluss von Kapitel 3.3
     - keine neuen fachlichen Inhalte
     - Statusfortschreibung der Kapitel- und Unterabschnitte
     - Dokumentation des redaktionellen Abschlusses
     - Festschreibung des Übergangs zu Kapitel 3.4
     - Festschreibung der nächsten freien Literatur- und Gleichungsnummer
     - vollständige Audit- und Konsistenzprüfungen

   Finaler Stand Kapitel 3.3:
     letzte Literaturquelle:      [95]
     nächste freie Literatur-Nr.: [96]
     letzte Gleichung:            (3.339)
     nächste freie Gleichung:     (3.340)
     letzte Definition:           Def. 3.3.9.7
     letzte Proposition:          Prop. 3.3.9.6
     Axiome:                      A1 bis A5

   Schemaquelle:
     frzk_rkb(5).sql und Repository-Stand bis 3.3.9 V2

   Eigenschaften:
     - transaktional
     - idempotent
     - phpMyAdmin-kompatibel
     - keine Änderung bestehender Literatur-, Gleichungs- oder Axiomnummern
   ================================================================================================= */

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';

START TRANSACTION;

/* -------------------------------------------------------------------------------------------------
   1. Parent-Revision laden und zwingend prüfen
   ------------------------------------------------------------------------------------------------- */

SET @parent_revision_code :=
    CONVERT('RKB-2026-07-16-K3.3.9-NEUFASSUNG-V2' USING utf8mb4)
    COLLATE utf8mb4_unicode_ci;

SET @parent_revision_id := NULL;

SELECT `revision_id`
INTO @parent_revision_id
FROM `repository_revisions`
WHERE `revision_code` COLLATE utf8mb4_unicode_ci
      =
      @parent_revision_code COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_parent_revision_33_final`;

CREATE TEMPORARY TABLE `tmp_frzk_parent_revision_33_final`
(
    `revision_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_parent_revision_33_final` (`revision_id`)
VALUES (@parent_revision_id);

DROP TEMPORARY TABLE `tmp_frzk_parent_revision_33_final`;

/* -------------------------------------------------------------------------------------------------
   2. Kapitelabschnitt 3.3 laden und zwingend prüfen
   ------------------------------------------------------------------------------------------------- */

SET @section_33_id := NULL;

SELECT `section_id`
INTO @section_33_id
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci
LIMIT 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_frzk_section_33_final`;

CREATE TEMPORARY TABLE `tmp_frzk_section_33_final`
(
    `section_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MEMORY;

INSERT INTO `tmp_frzk_section_33_final` (`section_id`)
VALUES (@section_33_id);

DROP TEMPORARY TABLE `tmp_frzk_section_33_final`;

/* -------------------------------------------------------------------------------------------------
   3. Abschlussrevision idempotent registrieren
   ------------------------------------------------------------------------------------------------- */

SET @revision_code :=
    CONVERT('RKB-2026-07-16-K3.3-FINAL-V1' USING utf8mb4)
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
    'chapter',
    '3.3',
    'FINAL-V1',
    'Formaler und redaktioneller Abschluss von Kapitel 3.3. Die qualitative FRZK-Axiomatik mit A1 bis A5, ihren Konsequenzen, der Minimalitäts-, Unabhängigkeits- und Konsistenzvorprüfung sowie den Übergangsregeln einschließlich latenter funktionaler Orientierung, funktionaler Persistenz und funktionalem Gedächtnis ist abgeschlossen. Keine neuen fachlichen Inhalte. Übergang zu Kapitel 3.4 bei Quelle [96] und Gleichung (3.340).',
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
   4. Kapitel 3.3 auf completed setzen
   ------------------------------------------------------------------------------------------------- */

UPDATE `dissertation_sections`
SET
    `status` = 'completed',
    `notes` =
    'Kapitel 3.3 vollständig abgeschlossen. Enthalten sind die qualitative FRZK-Axiomatik A1 bis A5, qualitative Konsequenzen, Minimalitäts-, Unabhängigkeits- und Konsistenzvorprüfung, Übergangsregeln zur mathematischen Rekonstruktion sowie latente funktionale Orientierung, funktionale Persistenz und funktionales Gedächtnis. Übergang zu Kapitel 3.4 mit Quelle [96] und Gleichung (3.340).'
WHERE `section_id` = @section_33_id;

/* -------------------------------------------------------------------------------------------------
   5. Alle vorhandenen Unterabschnitte 3.3.* abschließen
   Bereits fehlende oder nicht angelegte Abschnitte werden nicht erzeugt.
   ------------------------------------------------------------------------------------------------- */

UPDATE `dissertation_sections`
SET
    `status` = 'completed'
WHERE `section_code` COLLATE utf8mb4_unicode_ci LIKE '3.3.%'
  AND `status` IN ('planned','draft','review');

/* -------------------------------------------------------------------------------------------------
   6. Redaktionellen Abschluss als Proposition registrieren
   Keine neue fachliche Theorieaussage, sondern Dokumentation des Übergangs.
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `propositions`
(
    `proposition_number`,
    `section_id`,
    `title`,
    `statement_text`,
    `statement_latex`,
    `word_latex`,
    `logical_derivation`,
    `based_on_axioms`,
    `status`,
    `created_revision_id`
)
VALUES
(
    'Prop. 3.3.A',
    @section_33_id,
    'Redaktioneller Abschluss von Kapitel 3.3',
    'Die prämathematische FRZK-Axiomatik ist abgeschlossen. Jede mathematische Struktur in Kapitel 3.4 muss aus den in Kapitel 3.3 eingeführten funktionalen Begriffen, Axiomen und Übergangsregeln rekonstruiert werden. Die klassische Vektoralgebra bleibt unverändert; latente Orientierung, Persistenz und funktionales Gedächtnis gehören zum erweiterten funktionalen Zustandsbegriff.',
    '\\text{Abschluss Kapitel 3.3}\\Longrightarrow\\text{mathematische Rekonstruktion ab Kapitel 3.4}',
    '\\text{Abschluss Kapitel 3.3}\\Longrightarrow\\text{mathematische Rekonstruktion ab Kapitel 3.4}',
    'Zusammenfassung der in Abschnitt 3.3.9 formulierten Übergangsregeln und der redaktionellen Schlussfolgerung für Kapitel 3.4.',
    'A1,A2,A3,A4,A5',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    `section_id`          = VALUES(`section_id`),
    `title`               = VALUES(`title`),
    `statement_text`      = VALUES(`statement_text`),
    `statement_latex`     = VALUES(`statement_latex`),
    `word_latex`          = VALUES(`word_latex`),
    `logical_derivation`  = VALUES(`logical_derivation`),
    `based_on_axioms`     = VALUES(`based_on_axioms`),
    `status`              = VALUES(`status`),
    `created_revision_id` = VALUES(`created_revision_id`);

SET @prop_33_closure_id := NULL;

SELECT `proposition_id`
INTO @prop_33_closure_id
FROM `propositions`
WHERE `proposition_number` COLLATE utf8mb4_unicode_ci
      =
      'Prop. 3.3.A' COLLATE utf8mb4_unicode_ci
LIMIT 1;

/* -------------------------------------------------------------------------------------------------
   7. Kapitelabschluss im Änderungsprotokoll registrieren
   ------------------------------------------------------------------------------------------------- */

DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_33_id;

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
    @section_33_id,
    'status_changed',
    'section',
    '3.3',
    'Kapitel 3.3 wurde nach vollständiger inhaltlicher und redaktioneller Bearbeitung formal abgeschlossen.',
    'review',
    'completed'
),
(
    @revision_id,
    @section_33_id,
    'proposition_added',
    'propositions',
    'Prop. 3.3.A',
    'Der redaktionelle Abschluss und der verbindliche Übergang zur mathematischen Rekonstruktion in Kapitel 3.4 wurden dokumentiert.',
    NULL,
    'Redaktioneller Abschluss von Kapitel 3.3'
),
(
    @revision_id,
    @section_33_id,
    'counter_updated',
    'repository_counters',
    'next_citation_number / next_equation_number',
    'Die nächsten freien Nummern für Kapitel 3.4 wurden festgeschrieben.',
    'Quelle [96], Gleichung (3.340) gemäß Stand 3.3.9 V2',
    'Quelle [96], Gleichung (3.340) bestätigt'
),
(
    @revision_id,
    @section_33_id,
    'completed',
    'chapter',
    '3.3',
    'Die qualitative FRZK-Axiomatik und ihre Übergangsregeln sind vollständig abgeschlossen.',
    NULL,
    'Kapitel 3.3 abgeschlossen'
);

/* -------------------------------------------------------------------------------------------------
   8. Repository-Counter festschreiben
   ------------------------------------------------------------------------------------------------- */

INSERT INTO `repository_counters`
(
    `counter_key`,
    `counter_value`
)
VALUES
    ('last_edited_section',       '3.3'),
    ('last_completed_chapter',    '3.3'),
    ('next_chapter',              '3.4'),
    ('last_repository_revision',  'RKB-2026-07-16-K3.3-FINAL-V1'),
    ('next_citation_number',      '96'),
    ('next_equation_number',      '3.340')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

/* -------------------------------------------------------------------------------------------------
   9. Konsistenzhinweise in Repository-Revision ergänzen
   ------------------------------------------------------------------------------------------------- */

UPDATE `repository_revisions`
SET
    `summary` =
    'Formaler und redaktioneller Abschluss von Kapitel 3.3. Endstand: Axiome A1 bis A5; Literatur bis [95]; Gleichungen bis (3.339); Definitionen bis Def. 3.3.9.7; Propositionen bis Prop. 3.3.9.6 plus redaktionelle Abschlussproposition Prop. 3.3.A. Die klassische Vektoralgebra bleibt unverändert. Latente funktionale Orientierung, Persistenz und funktionales Gedächtnis werden als Eigenschaften eines erweiterten funktionalen Zustandes in Kapitel 3.4 mathematisch rekonstruiert. Nächster Stand: Quelle [96], Gleichung (3.340).',
    `revision_date` = NOW()
WHERE `revision_id` = @revision_id;

COMMIT;

/* =================================================================================================
   10. AUDIT UND KONTROLLABFRAGEN
   ================================================================================================= */

/* 10.1 Abschlussrevision und Parent */
SELECT
    r.`revision_id`,
    r.`revision_code`,
    r.`scope_type`,
    r.`scope_reference`,
    r.`version_label`,
    p.`revision_code` AS `parent_revision_code`,
    r.`summary`
FROM `repository_revisions` r
LEFT JOIN `repository_revisions` p
    ON p.`revision_id` = r.`parent_revision_id`
WHERE r.`revision_code` COLLATE utf8mb4_unicode_ci
      =
      'RKB-2026-07-16-K3.3-FINAL-V1' COLLATE utf8mb4_unicode_ci;

/* 10.2 Kapitelstatus */
SELECT
    `section_id`,
    `section_code`,
    `title`,
    `status`,
    `is_original_contribution`,
    `notes`
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci
      =
      '3.3' COLLATE utf8mb4_unicode_ci;

/* 10.3 Status aller Unterabschnitte */
SELECT
    `section_code`,
    `title`,
    `status`
FROM `dissertation_sections`
WHERE `section_code` COLLATE utf8mb4_unicode_ci LIKE '3.3.%'
ORDER BY
    CAST(SUBSTRING_INDEX(`section_code`,'.',2) AS DECIMAL(10,4)),
    `section_order`,
    `section_code`;

/* 10.4 Axiome A1 bis A5 */
SELECT
    `axiom_number`,
    `title`,
    `status`,
    `section_id`
FROM `axioms`
WHERE `axiom_number` IN ('A1','A2','A3','A4','A5')
ORDER BY `axiom_number`;

/* 10.5 Letzte Definitionen von Kapitel 3.3 */
SELECT
    d.`definition_number`,
    d.`title`,
    d.`validation_status`,
    ds.`section_code`
FROM `definitions` d
JOIN `dissertation_sections` ds
    ON ds.`section_id` = d.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci LIKE '3.3%'
ORDER BY d.`definition_id` DESC
LIMIT 15;

/* 10.6 Propositionen des Kapitelabschlusses */
SELECT
    p.`proposition_number`,
    p.`title`,
    p.`status`,
    p.`word_latex`,
    rr.`revision_code`
FROM `propositions` p
LEFT JOIN `repository_revisions` rr
    ON rr.`revision_id` = p.`created_revision_id`
WHERE p.`proposition_number` COLLATE utf8mb4_unicode_ci
      =
      'Prop. 3.3.A' COLLATE utf8mb4_unicode_ci;

/* 10.7 Letzte Gleichungen und maximaler Gleichungsstand */
SELECT
    e.`equation_number`,
    e.`title`,
    e.`validation_status`,
    ds.`section_code`
FROM `equations` e
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci LIKE '3.3%'
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED) DESC
LIMIT 15;

/* 10.8 Prüfen, dass (3.339) existiert und (3.340) noch frei ist */
SELECT
    '3.339' AS `equation_number`,
    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM `equations`
            WHERE `equation_number` COLLATE utf8mb4_unicode_ci
                  =
                  '3.339' COLLATE utf8mb4_unicode_ci
        )
        THEN 'OK – letzte Gleichung vorhanden'
        ELSE 'FEHLT'
    END AS `audit_result`

UNION ALL

SELECT
    '3.340',
    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM `equations`
            WHERE `equation_number` COLLATE utf8mb4_unicode_ci
                  =
                  '3.340' COLLATE utf8mb4_unicode_ci
        )
        THEN 'ACHTUNG – bereits belegt'
        ELSE 'OK – nächste Gleichung frei'
    END;

/* 10.9 Quellenstand [95]/[96] prüfen */
SELECT
    95 AS `citation_number`,
    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM `sources`
            WHERE `citation_number` = 95
        )
        THEN 'OK – letzte Quelle vorhanden'
        ELSE 'FEHLT'
    END AS `audit_result`

UNION ALL

SELECT
    96,
    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM `sources`
            WHERE `citation_number` = 96
        )
        THEN 'ACHTUNG – bereits belegt'
        ELSE 'OK – nächste Quelle frei'
    END;

/* 10.10 Repository-Counter */
SELECT
    `counter_key`,
    `counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
(
    'last_edited_section',
    'last_completed_chapter',
    'next_chapter',
    'last_repository_revision',
    'next_citation_number',
    'next_equation_number'
)
ORDER BY `counter_key`;

/* 10.11 Doppelte Quellen- und Gleichungsnummern */
SELECT
    'sources' AS `table_name`,
    CAST(`citation_number` AS CHAR) AS `duplicate_key`,
    COUNT(*) AS `duplicate_count`
FROM `sources`
GROUP BY `citation_number`
HAVING COUNT(*) > 1

UNION ALL

SELECT
    'equations',
    `equation_number`,
    COUNT(*)
FROM `equations`
GROUP BY `equation_number`
HAVING COUNT(*) > 1

UNION ALL

SELECT
    'definitions',
    `definition_number`,
    COUNT(*)
FROM `definitions`
GROUP BY `definition_number`
HAVING COUNT(*) > 1

UNION ALL

SELECT
    'propositions',
    `proposition_number`,
    COUNT(*)
FROM `propositions`
GROUP BY `proposition_number`
HAVING COUNT(*) > 1;

/* 10.12 Fehlendes Word-LaTeX in Kapitel 3.3 */
SELECT
    'equation' AS `object_type`,
    e.`equation_number` AS `object_reference`,
    e.`title`
FROM `equations` e
JOIN `dissertation_sections` ds
    ON ds.`section_id` = e.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci LIKE '3.3%'
  AND (e.`word_latex` IS NULL OR TRIM(e.`word_latex`) = '')

UNION ALL

SELECT
    'proposition',
    p.`proposition_number`,
    p.`title`
FROM `propositions` p
JOIN `dissertation_sections` ds
    ON ds.`section_id` = p.`section_id`
WHERE ds.`section_code` COLLATE utf8mb4_unicode_ci LIKE '3.3%'
  AND (p.`word_latex` IS NULL OR TRIM(p.`word_latex`) = '');

/* 10.13 Verwaiste Kapitelobjekte */
SELECT
    'definition' AS `object_type`,
    d.`definition_id` AS `object_id`,
    d.`definition_number` AS `object_reference`
FROM `definitions` d
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = d.`section_id`
WHERE d.`created_revision_id` = @revision_id
  AND ds.`section_id` IS NULL

UNION ALL

SELECT
    'proposition',
    p.`proposition_id`,
    p.`proposition_number`
FROM `propositions` p
LEFT JOIN `dissertation_sections` ds
    ON ds.`section_id` = p.`section_id`
WHERE p.`created_revision_id` = @revision_id
  AND ds.`section_id` IS NULL;

/* 10.14 Änderungsprotokoll der Abschlussrevision */
SELECT
    `change_type`,
    `object_type`,
    `object_reference`,
    `change_summary`,
    `previous_value`,
    `new_value`
FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_33_id
ORDER BY `change_id`;

/* 10.15 Revisionskette ab Abschluss rückwärts anzeigen */
WITH RECURSIVE `revision_chain` AS
(
    SELECT
        r.`revision_id`,
        r.`revision_code`,
        r.`parent_revision_id`,
        0 AS `depth`
    FROM `repository_revisions` r
    WHERE r.`revision_id` = @revision_id

    UNION ALL

    SELECT
        p.`revision_id`,
        p.`revision_code`,
        p.`parent_revision_id`,
        rc.`depth` + 1
    FROM `repository_revisions` p
    JOIN `revision_chain` rc
        ON p.`revision_id` = rc.`parent_revision_id`
    WHERE rc.`depth` < 25
)
SELECT
    `depth`,
    `revision_id`,
    `revision_code`,
    `parent_revision_id`
FROM `revision_chain`
ORDER BY `depth`;

/* 10.16 Abschlussmeldung */
SELECT
    'Kapitel 3.3 vollständig abgeschlossen. Finaler Stand: Literatur bis [95], Gleichungen bis (3.339), Definitionen bis Def. 3.3.9.7, Propositionen bis Prop. 3.3.9.6 plus Prop. 3.3.A. Kapitel 3.4 beginnt mit Quelle [96] und Gleichung (3.340).'
    AS `result`;
