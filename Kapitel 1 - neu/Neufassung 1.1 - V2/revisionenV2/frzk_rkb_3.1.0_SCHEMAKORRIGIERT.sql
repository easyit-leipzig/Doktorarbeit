/* ============================================================
   FRZK-RKB – Kapitel 3.1.0
   Korrigiertes Repository-Skript gemäß frzk_rkb_empty.sql
   Stand: 2026-07-26
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   1. Repository-Revision anlegen
   ============================================================ */

INSERT INTO repository_revisions
(
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    summary,
    created_by,
    parent_revision_id
)
SELECT
    'K3_1_0_REBUILD_V1',
    NOW(),
    'section',
    '3.1.0',
    '3.1.0-v1',
    'Repositorygerechte Anlage und Dokumentation des Abschnitts 3.1.0 einschließlich der Literaturverwendungen [1] bis [3].',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'K3_1_0_REBUILD_V1'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'K3_1_0_REBUILD_V1'
    LIMIT 1
);

/* ============================================================
   2. Kapitelhierarchie sicherstellen
   ============================================================ */

/* Wurzelkapitel 3 */
INSERT INTO dissertation_sections
(
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution,
    notes
)
SELECT
    NULL,
    '3',
    'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen',
    3,
    3.0000,
    'draft',
    1,
    'Übergeordnetes Wurzelkapitel für den Neuaufbau von Kapitel 3.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3'
);

SET @chapter3_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3'
    LIMIT 1
);

/* Kapitel 3.1 */
INSERT INTO dissertation_sections
(
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution,
    notes
)
SELECT
    @chapter3_id,
    '3.1',
    'Grundlagen der funktionalen Beschreibung von Raum und Zeit',
    3,
    3.1000,
    'draft',
    1,
    'Kapitel 3.1 wird nach dem Weiter-Skript-Prinzip unterabschnittsweise aufgebaut.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.1'
);

SET @chapter31_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1'
    LIMIT 1
);

/* Unterabschnitt 3.1.0 */
INSERT INTO dissertation_sections
(
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution,
    notes
)
SELECT
    @chapter31_id,
    '3.1.0',
    'Einleitung',
    3,
    3.1000,
    'final',
    0,
    'Einleitung zu Kapitel 3.1; Literaturverweise [1] bis [3]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.1.0'
);

/* Vorhandenen Datensatz schema- und statusgerecht aktualisieren */
UPDATE dissertation_sections
SET
    parent_section_id = @chapter31_id,
    title = 'Einleitung',
    chapter_no = 3,
    section_order = 3.1000,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Einleitung zu Kapitel 3.1; Literaturverweise [1] bis [3]; keine nummerierten Gleichungen.'
WHERE section_code = '3.1.0';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1.0'
    LIMIT 1
);

/* ============================================================
   3. Literaturverwendungen [1] bis [3]
   Voraussetzung: Quellen [1], [2] und [3] sind bereits in
   der Tabelle sources angelegt.
   Doppelte Verknüpfungen werden verhindert.
   ============================================================ */

/* [1] Newton */
INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'first_citation',
    'Historischer Ausgangspunkt der klassischen Konzeption eines absoluten Raumes und einer absoluten Zeit.',
    '3.1.0, Absatz 1 und 2',
    1,
    1,
    'Erstnennung als Quelle [1].',
    @revision_id
FROM sources s
WHERE s.citation_number = 1
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
  );

/* [2] Einstein */
INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'first_citation',
    'Grundlage der dynamischen geometrischen Raumzeitbeschreibung in der Allgemeinen Relativitätstheorie.',
    '3.1.0, Absatz 1 und 2',
    1,
    1,
    'Erstnennung als Quelle [2].',
    @revision_id
FROM sources s
WHERE s.citation_number = 2
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
  );

/* [3] Rovelli */
INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'first_citation',
    'Einordnung quantengravitativer Ansätze, in denen Raum und Zeit als nichtfundamental oder emergent untersucht werden.',
    '3.1.0, Absatz 1 und 2',
    1,
    1,
    'Erstnennung als Quelle [3].',
    @revision_id
FROM sources s
WHERE s.citation_number = 3
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
  );

/* ============================================================
   4. Änderungsprotokoll
   ============================================================ */

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.1.0',
    'Abschnitt 3.1.0 schemagerecht angelegt beziehungsweise aktualisiert.',
    NULL,
    'Einleitung; Status final; Literatur [1] bis [3]; keine Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'created'
      AND object_reference = '3.1.0'
);

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'source_added',
    'sources',
    '[1]–[3]',
    'Die drei Grundlagenquellen des Einleitungsabschnitts wurden, soweit in sources vorhanden, mit Abschnitt 3.1.0 verknüpft.',
    NULL,
    CONCAT(
        'Verknüpfte Quellen: ',
        (
            SELECT COUNT(*)
            FROM source_usage su
            JOIN sources s ON s.source_id = su.source_id
            WHERE su.section_id = @section_id
              AND s.citation_number IN (1,2,3)
        )
    )
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'source_added'
      AND object_reference = '[1]–[3]'
);

/* ============================================================
   5. Validierungen
   ============================================================ */

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
VALUES
(
    @revision_id,
    'K3_1_0_SECTION_EXISTS',
    IF(@section_id IS NOT NULL, 'passed', 'failed'),
    '1',
    IF(@section_id IS NOT NULL, '1', '0'),
    'Prüft, ob Abschnitt 3.1.0 vorhanden ist.'
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage su
    JOIN sources s ON s.source_id = su.source_id
    WHERE su.section_id = @section_id
      AND s.citation_number IN (1,2,3)
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
VALUES
(
    @revision_id,
    'K3_1_0_SOURCE_USAGE',
    IF(@source_usage_count = 3, 'passed', 'warning'),
    '3',
    CAST(@source_usage_count AS CHAR),
    'Prüft die Verknüpfung der Literaturquellen [1] bis [3]. Ein Warnstatus bedeutet, dass die Quellen zuvor noch in sources angelegt werden müssen.'
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id = @section_id
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
VALUES
(
    @revision_id,
    'K3_1_0_NO_EQUATIONS',
    IF(@equation_count = 0, 'passed', 'failed'),
    '0',
    CAST(@equation_count AS CHAR),
    'Abschnitt 3.1.0 enthält keine nummerierten Gleichungen.'
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

/* ============================================================
   6. Repository-Zähler aktualisieren
   ============================================================ */

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
    ('last_completed_section', '3.1.0'),
    ('last_citation_number', '3'),
    ('next_citation_number', '4')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value);

/* Kapitel 3.1 besitzt in diesem Abschnitt keine Gleichung.
   Ein vorhandener Gleichungszähler wird daher nicht verändert. */

COMMIT;

/* ============================================================
   Kontrollausgabe
   ============================================================ */

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code IN ('3', '3.1', '3.1.0')
ORDER BY section_order, section_code;

SELECT
    s.citation_number,
    s.title,
    su.usage_type,
    su.is_first_mention,
    su.citation_checked
FROM source_usage su
JOIN sources s ON s.source_id = su.source_id
WHERE su.section_id = @section_id
ORDER BY s.citation_number;
