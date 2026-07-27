/* ============================================================
   FRZK Repository
   Abschnitt 3.1.2 – Philosophische Grundlagen, Teil 1
   Quellen: [7]–[12]
   Gleichungen: keine

   Korrektur:
   - repository_revisions wird zuerst angelegt
   - section_change_log.revision_id erhält eine gültige FK-ID
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
    'RKB-NEU-K3.1.2-T1-V1',
    NOW(),
    'section',
    '3.1.2',
    '3.1.2-T1-v1',
    'Aufnahme des ersten Teils von Abschnitt 3.1.2 mit den philosophischen Positionen von Platon bis Leibniz und den Literaturquellen [7] bis [12].',
    'Olaf Thiele / ChatGPT',
    (
        SELECT r.revision_id
        FROM repository_revisions r
        WHERE r.scope_reference IN ('3.1.1', '3.1.0')
        ORDER BY r.revision_id DESC
        LIMIT 1
    )
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.2-T1-V1'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.2-T1-V1'
    LIMIT 1
);

/* Sicherheitsprüfung */
SELECT
    CASE
        WHEN @revision_id IS NULL
        THEN 'FEHLER: Revision konnte nicht angelegt werden.'
        ELSE CONCAT('Revision-ID: ', @revision_id)
    END AS revision_status;

/* ============================================================
   2. Elternabschnitt 3.1 ermitteln
   ============================================================ */

SET @parent :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1'
    LIMIT 1
);

/* ============================================================
   3. Abschnitt 3.1.2 anlegen oder aktualisieren
   ============================================================ */

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
    @parent,
    '3.1.2',
    'Philosophische Grundlagen',
    3,
    3.1200,
    'draft',
    1,
    'Teil 1: Platon bis Leibniz; Literatur [7] bis [12]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.1.2'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent,
    title = 'Philosophische Grundlagen',
    chapter_no = 3,
    section_order = 3.1200,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Teil 1: Platon bis Leibniz; Literatur [7] bis [12]; keine nummerierten Gleichungen.'
WHERE section_code = '3.1.2';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1.2'
    LIMIT 1
);

/* ============================================================
   4. Quellenverwendungen [7] bis [12]
   Nur vorhandene Quellen werden verknüpft.
   ============================================================ */

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
    CASE s.citation_number
        WHEN 7 THEN 'Platon bestimmt das Nichtsein als Andersheit und macht Differenz relational bestimmbar.'
        WHEN 8 THEN 'Aristoteles bindet Raum und Zeit an Ort, Bewegung sowie die Ordnung des Früher und Später.'
        WHEN 9 THEN 'Plotin beschreibt die stufenweise Hervorbringung von Vielheit aus dem Einen.'
        WHEN 10 THEN 'Nikolaus von Kues thematisiert den Zusammenfall der Gegensätze und die Grenzen menschlicher Bestimmung.'
        WHEN 11 THEN 'Spinoza bestimmt einzelne Entitäten als Ausdrucksweisen einer umfassenden immanenten Ordnung.'
        WHEN 12 THEN 'Leibniz beschreibt Raum und Zeit relational als Ordnung des Zugleichseins und Nacheinanders.'
    END,
    CASE s.citation_number
        WHEN 7 THEN '3.1.2, Platon'
        WHEN 8 THEN '3.1.2, Aristoteles'
        WHEN 9 THEN '3.1.2, Plotin'
        WHEN 10 THEN '3.1.2, Nikolaus von Kues'
        WHEN 11 THEN '3.1.2, Spinoza'
        WHEN 12 THEN '3.1.2, Leibniz'
    END,
    1,
    1,
    CONCAT('Erstnennung der Quelle [', s.citation_number, '] in Abschnitt 3.1.2.'),
    @revision_id
FROM sources s
WHERE s.citation_number BETWEEN 7 AND 12
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage u
      WHERE u.section_id = @section_id
        AND u.source_id = s.source_id
  );

/* ============================================================
   5. Änderungsprotokoll mit gültiger revision_id
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
    '3.1.2',
    'Abschnitt 3.1.2 wurde angelegt beziehungsweise für den ersten Bearbeitungsteil aktualisiert.',
    NULL,
    'Teil 1: Platon bis Leibniz; Literatur [7] bis [12]; keine Gleichungen.'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'created'
        AND object_reference = '3.1.2'
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
    '[7]–[12]',
    'Die im ersten Teil von Abschnitt 3.1.2 verwendeten Literaturquellen wurden mit dem Abschnitt verknüpft.',
    NULL,
    CONCAT
    (
        'Verknüpfte Quellen: ',
        (
            SELECT COUNT(*)
            FROM source_usage su
            JOIN sources s
              ON s.source_id = su.source_id
            WHERE su.section_id = @section_id
              AND s.citation_number BETWEEN 7 AND 12
        )
    )
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'source_added'
        AND object_reference = '[7]–[12]'
  );

/* ============================================================
   6. Repository-Zähler
   Abschnitt bleibt draft, weil 3.1.2 noch nicht vollständig ist.
   ============================================================ */

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
    ('current_section', '3.1.2'),
    ('last_citation_number', '12'),
    ('next_citation_number', '13')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value);

/* Kein Gleichungszähler wird verändert. */

COMMIT;

/* ============================================================
   7. Kontrollausgaben
   ============================================================ */

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label
FROM repository_revisions
WHERE revision_code = 'RKB-NEU-K3.1.2-T1-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code = '3.1.2';

SELECT
    scl.revision_id,
    scl.section_id,
    scl.change_type,
    scl.object_reference,
    scl.change_summary
FROM section_change_log scl
WHERE scl.revision_id = @revision_id
  AND scl.section_id = @section_id
ORDER BY scl.object_reference;

SELECT
    s.citation_number,
    s.title,
    su.usage_type,
    su.citation_checked
FROM source_usage su
JOIN sources s
  ON s.source_id = su.source_id
WHERE su.section_id = @section_id
  AND s.citation_number BETWEEN 7 AND 12
ORDER BY s.citation_number;
