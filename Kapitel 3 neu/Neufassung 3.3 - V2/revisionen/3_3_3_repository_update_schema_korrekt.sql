/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.3.3
   Prämathematische Grundbegriffe des FRZK

   Ausgangsstand:
     RKB-NEU-K3.3.2-V1

   Neue Revision:
     RKB-NEU-K3.3.3-V1

   Eigenschaften:
     - am tatsächlichen Schema von fortgeschriebenen FRZK-RKB-Schema ausgerichtet
     - idempotent ausführbar
     - keine neuen Quellen
     - keine neuen Gleichungen
     - keine formalen Definitionen oder Axiome vorweggenommen
   ===================================================================== */

SET NAMES utf8mb4;
START TRANSACTION;

/* ---------------------------------------------------------------------
   1. Vorhandene IDs und Zählerstand ermitteln
   --------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.2-V1'
    LIMIT 1
);

SET @chapter_33_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   2. Repository-Revision für 3.3.3 anlegen
   --------------------------------------------------------------------- */

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
    'RKB-NEU-K3.3.3-V1',
    NOW(),
    'section',
    '3.3.3',
    '1.0',
    'Neufassung von Abschnitt 3.3.3. Der Abschnitt führt die prämathematischen Grundbegriffe des FRZK ein und grenzt funktionalen Gehalt, Unterscheidbarkeit, Relation, Transformation, Organisation, Kohärenz, Stabilität, Reproduzierbarkeit, Grenze und Identität gegenüber bereits formalisierten mathematischen oder physikalischen Begriffen ab.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.3.3-V1'
  );

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.3-V1'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   3. Abschnitt 3.3.3 anlegen
   --------------------------------------------------------------------- */

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
    @chapter_33_id,
    '3.3.3',
    'Prämathematische Grundbegriffe des FRZK',
    3,
    3.4300,
    'review',
    1,
    'Einführung der prämathematischen Grundbegriffe des FRZK. Der Abschnitt bestimmt deren minimale Bedeutung, ohne bereits mathematische Objekte, physikalische Entitäten oder formale Definitionen vorwegzunehmen. Es werden noch keine Axiome, Quellen oder Gleichungen registriert.'
WHERE @chapter_33_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.3.3'
  );

SET @section_333_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.3'
    LIMIT 1
);

/* Bestehenden Datensatz bei erneutem Lauf auf den vorgesehenen Stand bringen. */
UPDATE dissertation_sections
SET
    parent_section_id = @chapter_33_id,
    title = 'Prämathematische Grundbegriffe des FRZK',
    chapter_no = 3,
    section_order = 3.4300,
    status = 'review',
    is_original_contribution = 1,
    notes = 'Einführung der prämathematischen Grundbegriffe des FRZK. Der Abschnitt bestimmt deren minimale Bedeutung, ohne bereits mathematische Objekte, physikalische Entitäten oder formale Definitionen vorwegzunehmen. Es werden noch keine Axiome, Quellen oder Gleichungen registriert.'
WHERE section_code = '3.3.3';

/* ---------------------------------------------------------------------
   4. Änderungsprotokoll
   --------------------------------------------------------------------- */

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
    @section_333_id,
    'created',
    'section',
    '3.3.3',
    'Abschnitt 3.3.3 wurde vollständig neu erstellt und repositoryseitig registriert.',
    NULL,
    'Prämathematische Grundbegriffe des FRZK'
WHERE @revision_id IS NOT NULL
  AND @section_333_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_333_id
        AND change_type = 'created'
        AND object_reference = '3.3.3'
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
    @section_333_id,
    'other',
    'methodological_result',
    'Prämathematische Grundbegriffe',
    'Der Abschnitt führt funktionalen Gehalt, funktionale Unterscheidbarkeit, funktionale Relation, funktionale Transformation, funktionale Organisation, funktionale Kohärenz, funktionale Stabilität, funktionale Reproduzierbarkeit, funktionale Grenze und funktionale Identität als prämathematische Grundbegriffe ein.',
    NULL,
    'Prämathematisches Begriffsgerüst für die folgende Axiomatik dokumentiert.'
WHERE @revision_id IS NOT NULL
  AND @section_333_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_333_id
        AND change_type = 'other'
        AND object_reference = 'Prämathematische Grundbegriffe'
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
    @section_333_id,
    'status_changed',
    'section',
    '3.3.3',
    'Der Bearbeitungsstatus des Abschnitts wurde auf review gesetzt.',
    'planned',
    'review'
WHERE @revision_id IS NOT NULL
  AND @section_333_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_333_id
        AND change_type = 'status_changed'
        AND object_reference = '3.3.3'
  );

/* ---------------------------------------------------------------------
   5. Repository-Zähler aktualisieren
   --------------------------------------------------------------------- */

INSERT INTO repository_counters
(
    counter_key,
    counter_value,
    updated_at
)
VALUES
    ('last_completed_section', '3.3.3', NOW()),
    ('last_repository_revision', 'RKB-NEU-K3.3.3-V1', NOW()),
    ('next_citation_number', '103', NOW()),
    ('next_equation_number', '3.354', NOW())
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value),
    updated_at = VALUES(updated_at);

/* ---------------------------------------------------------------------
   6. Validierungsergebnisse registrieren
   --------------------------------------------------------------------- */

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-SECTION-EXISTS',
    CASE WHEN COUNT(*) = 1 THEN 'passed' ELSE 'failed' END,
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.3.3 muss genau einmal im Repository vorhanden sein.'
FROM dissertation_sections
WHERE section_code = '3.3.3'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-PARENT',
    CASE WHEN @section_333_id IS NOT NULL
              AND (SELECT parent_section_id FROM dissertation_sections WHERE section_id = @section_333_id) = @chapter_33_id
         THEN 'passed' ELSE 'failed' END,
    CAST(@chapter_33_id AS CHAR),
    CAST((SELECT parent_section_id FROM dissertation_sections WHERE section_id = @section_333_id) AS CHAR),
    'Abschnitt 3.3.3 muss dem Hauptabschnitt 3.3 untergeordnet sein.'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-PARENT-REVISION',
    CASE WHEN parent_revision_id = @parent_revision_id THEN 'passed' ELSE 'failed' END,
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision von 3.3.3 muss unmittelbar auf RKB-NEU-K3.3.2-V1 aufbauen.'
FROM repository_revisions
WHERE revision_id = @revision_id
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-NO-NEW-SOURCES',
    CASE WHEN COUNT(*) = 0 THEN 'passed' ELSE 'failed' END,
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.3.3 führt planmäßig keine neue Quellenverwendung ein.'
FROM source_usage
WHERE section_id = @section_333_id
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-NO-EQUATIONS',
    CASE WHEN COUNT(*) = 0 THEN 'passed' ELSE 'failed' END,
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.3.3 enthält planmäßig keine registrierungspflichtige Gleichung.'
FROM equations
WHERE section_id = @section_333_id
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-NO-FORMAL-OBJECTS',
    CASE WHEN
        (SELECT COUNT(*) FROM definitions WHERE section_id = @section_333_id) = 0
        AND (SELECT COUNT(*) FROM assumptions WHERE section_id = @section_333_id) = 0
        AND (SELECT COUNT(*) FROM axioms WHERE section_id = @section_333_id) = 0
        THEN 'passed' ELSE 'failed' END,
    '0',
    CAST(
        (SELECT COUNT(*) FROM definitions WHERE section_id = @section_333_id)
        + (SELECT COUNT(*) FROM assumptions WHERE section_id = @section_333_id)
        + (SELECT COUNT(*) FROM axioms WHERE section_id = @section_333_id)
        AS CHAR
    ),
    'Der prämathematische Begriffsabschnitt darf noch keine formale Definition, Annahme oder kein Axiom registrieren.'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.3.3-NEXT-COUNTERS',
    CASE WHEN
        (SELECT counter_value FROM repository_counters WHERE counter_key = 'next_citation_number') = '103'
        AND (SELECT counter_value FROM repository_counters WHERE counter_key = 'next_equation_number') = '3.354'
        THEN 'passed' ELSE 'failed' END,
    '103 / 3.354',
    CONCAT(
        COALESCE((SELECT counter_value FROM repository_counters WHERE counter_key = 'next_citation_number'), 'NULL'),
        ' / ',
        COALESCE((SELECT counter_value FROM repository_counters WHERE counter_key = 'next_equation_number'), 'NULL')
    ),
    'Da Abschnitt 3.3.3 keine Quellen und Gleichungen einführt, müssen die nächsten freien Nummern unverändert bleiben.'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

COMMIT;

/* ---------------------------------------------------------------------
   7. Abschlusskontrolle
   --------------------------------------------------------------------- */

SELECT
    rr.revision_id,
    rr.revision_code,
    rr.scope_reference,
    rr.parent_revision_id,
    ds.section_id,
    ds.section_code,
    ds.title,
    ds.status,
    ds.is_original_contribution
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code = rr.scope_reference
WHERE rr.revision_code = 'RKB-NEU-K3.3.3-V1';

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.3-V1'
    LIMIT 1
)
ORDER BY validation_code;
