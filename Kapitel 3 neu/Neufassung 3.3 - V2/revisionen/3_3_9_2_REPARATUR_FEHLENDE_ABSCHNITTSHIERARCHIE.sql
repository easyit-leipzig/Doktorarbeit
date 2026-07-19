/* ============================================================================
   FRZK-RKB – Reparatur 3.3.9 / 3.3.9.1 / 3.3.9.2

   Fehlerursache:
   - Revision RKB-NEU-K3.3.9.1-V1 war vorhanden.
   - Die Abschnitte 3.3.9 und 3.3.9.1 fehlten jedoch in dissertation_sections.
   - Deshalb blieb @section_3392_id ungültig und section_change_log verletzte
     den Fremdschlüssel fk_change_section.

   Wirkung:
   1. legt den fehlenden Sammelabschnitt 3.3.9 an,
   2. legt 3.3.9.1 nachträglich an,
   3. legt bzw. korrigiert 3.3.9.2,
   4. repariert die Abschnittszuordnung vorhandener Gleichungen/Propositionen,
   5. trägt Change-Log-Einträge nur bei gültigen IDs ein,
   6. führt Abschlusskontrollen aus.

   Das Skript ist idempotent.
   ============================================================================ */

START TRANSACTION;

/* --------------------------------------------------------------------------
   1. Bestehende Hauptabschnitte und Revisionen ermitteln
   -------------------------------------------------------------------------- */

SET @section_33_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3'
    LIMIT 1
);

SET @revision_3391 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.1-V1'
    LIMIT 1
);

SET @revision_3392 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.2-V1'
    LIMIT 1
);

/* Falls die Revision 3.3.9.2 wegen des vorangegangenen Fehlers noch nicht
   existiert, wird sie idempotent angelegt. */

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.9.2-V1',
    NOW(),
    'section',
    '3.3.9.2',
    '1.0',
    'Abschnitt 3.3.9.2: Proposition 3.3.9 und Gleichungen (3.492) bis (3.506).',
    'Olaf Thiele / ChatGPT',
    @revision_3391
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.2-V1'
);

SET @revision_3392 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.2-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   2. Fehlenden Sammelabschnitt 3.3.9 anlegen
   -------------------------------------------------------------------------- */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @section_33_id,
    '3.3.9',
    'Logische Konsequenzen des Axiomensystems',
    3,
    3.3090,
    'draft',
    1,
    'Sammelabschnitt zur Ableitung logischer Konsequenzen, Unabhängigkeit, Konsistenz und weiterer Eigenschaften des FRZK-Axiomensystems.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.9'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_33_id,
    title = 'Logische Konsequenzen des Axiomensystems',
    chapter_no = 3,
    section_order = 3.3090,
    is_original_contribution = 1,
    notes = 'Sammelabschnitt zur Ableitung logischer Konsequenzen, Unabhängigkeit, Konsistenz und weiterer Eigenschaften des FRZK-Axiomensystems.'
WHERE section_code = '3.3.9';

SET @section_339_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   3. Fehlenden Abschnitt 3.3.9.1 nachtragen
   -------------------------------------------------------------------------- */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @section_339_id,
    '3.3.9.1',
    'Möglichkeit funktionaler Dynamik',
    3,
    3.3091,
    'final',
    1,
    'Logische Ableitung eines funktionalen Dynamikraums aus den Axiomen A1 bis A7.'
WHERE @section_339_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.9.1'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_339_id,
    title = 'Möglichkeit funktionaler Dynamik',
    chapter_no = 3,
    section_order = 3.3091,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Logische Ableitung eines funktionalen Dynamikraums aus den Axiomen A1 bis A7.'
WHERE section_code = '3.3.9.1';

SET @section_3391_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9.1'
    LIMIT 1
);

/* Bereits vorhandene Objekte aus 3.3.9.1 korrekt zuordnen. */

UPDATE equations
SET section_id = @section_3391_id
WHERE @section_3391_id IS NOT NULL
  AND equation_number IN
  (
      '3.486','3.487','3.488','3.489','3.490','3.491'
  );

UPDATE propositions
SET section_id = @section_3391_id
WHERE @section_3391_id IS NOT NULL
  AND proposition_number = '3.3.8';

UPDATE symbols
SET first_section_id = @section_3391_id
WHERE @section_3391_id IS NOT NULL
  AND symbol_latex = '\\mathfrak{D}_F'
  AND scope_type = 'chapter';

/* --------------------------------------------------------------------------
   4. Abschnitt 3.3.9.2 anlegen oder reparieren
   -------------------------------------------------------------------------- */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @section_339_id,
    '3.3.9.2',
    'Eigenständigkeit der Axiome',
    3,
    3.3092,
    'final',
    1,
    'Untersuchung der funktionalen Nichtreduzierbarkeit und schwachen Unabhängigkeit der Axiome A1 bis A7.'
WHERE @section_339_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.9.2'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_339_id,
    title = 'Eigenständigkeit der Axiome',
    chapter_no = 3,
    section_order = 3.3092,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Untersuchung der funktionalen Nichtreduzierbarkeit und schwachen Unabhängigkeit der Axiome A1 bis A7.'
WHERE section_code = '3.3.9.2';

SET @section_3392_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9.2'
    LIMIT 1
);

/* Bereits vor dem Fehler angelegte Objekte korrekt zuordnen. */

UPDATE equations
SET section_id = @section_3392_id
WHERE @section_3392_id IS NOT NULL
  AND equation_number IN
  (
      '3.492','3.493','3.494','3.495','3.496',
      '3.497','3.498','3.499','3.500','3.501',
      '3.502','3.503','3.504','3.505','3.506'
  );

UPDATE propositions
SET section_id = @section_3392_id
WHERE @section_3392_id IS NOT NULL
  AND proposition_number = '3.3.9';

UPDATE symbols
SET first_section_id = @section_3392_id
WHERE @section_3392_id IS NOT NULL
  AND symbol_latex IN
  (
      '\\mathcal{A}_F',
      '\\mathcal{A}_F^{(-k)}',
      '\\nRightarrow',
      '\\nvdash'
  )
  AND scope_type = 'chapter';

/* --------------------------------------------------------------------------
   5. Fehlende Change-Log-Einträge sicher nachtragen
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3391,
    @section_339_id,
    'created',
    'section',
    '3.3.9',
    'Sammelabschnitt 3.3.9 nachträglich angelegt.',
    NULL,
    'Logische Konsequenzen des Axiomensystems'
WHERE @revision_3391 IS NOT NULL
  AND @section_339_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3391
      AND section_id = @section_339_id
      AND object_type = 'section'
      AND object_reference = '3.3.9'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3391,
    @section_3391_id,
    'created',
    'section',
    '3.3.9.1',
    'Abschnitt 3.3.9.1 nachträglich in dissertation_sections registriert.',
    NULL,
    'Möglichkeit funktionaler Dynamik'
WHERE @revision_3391 IS NOT NULL
  AND @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3391
      AND section_id = @section_3391_id
      AND object_type = 'section'
      AND object_reference = '3.3.9.1'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3392,
    @section_3392_id,
    'created',
    'section',
    '3.3.9.2',
    'Abschnitt 3.3.9.2 vollständig angelegt beziehungsweise repariert.',
    NULL,
    'Eigenständigkeit der Axiome'
WHERE @revision_3392 IS NOT NULL
  AND @section_3392_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3392
      AND section_id = @section_3392_id
      AND object_type = 'section'
      AND object_reference = '3.3.9.2'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3392,
    @section_3392_id,
    'proposition_added',
    'proposition',
    '3.3.9',
    'Proposition 3.3.9 registriert.',
    NULL,
    'Schwache Unabhängigkeit des Axiomensystems'
WHERE @revision_3392 IS NOT NULL
  AND @section_3392_id IS NOT NULL
  AND EXISTS
  (
      SELECT 1
      FROM propositions
      WHERE proposition_number = '3.3.9'
  )
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_3392
        AND section_id = @section_3392_id
        AND object_type = 'proposition'
        AND object_reference = '3.3.9'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3392,
    @section_3392_id,
    'equation_added',
    'equation',
    '(3.492)–(3.506)',
    '15 Gleichungen zur schwachen Unabhängigkeit registriert.',
    NULL,
    'Gleichungen (3.492) bis (3.506)'
WHERE @revision_3392 IS NOT NULL
  AND @section_3392_id IS NOT NULL
  AND
  (
      SELECT COUNT(*)
      FROM equations
      WHERE equation_number IN
      (
          '3.492','3.493','3.494','3.495','3.496',
          '3.497','3.498','3.499','3.500','3.501',
          '3.502','3.503','3.504','3.505','3.506'
      )
  ) = 15
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_3392
        AND section_id = @section_3392_id
        AND object_type = 'equation'
        AND object_reference = '(3.492)–(3.506)'
  );

/* --------------------------------------------------------------------------
   6. Validierungen aktualisieren oder ergänzen
   -------------------------------------------------------------------------- */

SET @count_sections :=
(
    SELECT COUNT(*)
    FROM dissertation_sections
    WHERE section_code IN ('3.3.9','3.3.9.1','3.3.9.2')
);

SET @count_eq_3391 :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    ('3.486','3.487','3.488','3.489','3.490','3.491')
      AND section_id = @section_3391_id
);

SET @count_eq_3392 :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
        '3.492','3.493','3.494','3.495','3.496',
        '3.497','3.498','3.499','3.500','3.501',
        '3.502','3.503','3.504','3.505','3.506'
    )
      AND section_id = @section_3392_id
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3392,
    'K3.3.9.2.SECTION_HIERARCHY_REPAIR',
    CASE WHEN @count_sections = 3 THEN 'passed' ELSE 'failed' END,
    '3',
    CONCAT(@count_sections, ''),
    'Prüfung der Abschnittshierarchie 3.3.9, 3.3.9.1 und 3.3.9.2.'
WHERE @revision_3392 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3392
      AND validation_code = 'K3.3.9.2.SECTION_HIERARCHY_REPAIR'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3392,
    'K3.3.9.2.EQUATION_SECTION_ASSIGNMENT',
    CASE WHEN @count_eq_3391 = 6 AND @count_eq_3392 = 15 THEN 'passed' ELSE 'failed' END,
    '6/15',
    CONCAT(@count_eq_3391, '/', @count_eq_3392),
    'Prüfung der Abschnittszuordnung der Gleichungen aus 3.3.9.1 und 3.3.9.2.'
WHERE @revision_3392 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3392
      AND validation_code = 'K3.3.9.2.EQUATION_SECTION_ASSIGNMENT'
);

COMMIT;

/* --------------------------------------------------------------------------
   7. Abschlusskontrollen
   -------------------------------------------------------------------------- */

SELECT
    CASE
        WHEN @section_33_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
        WHEN @revision_3391 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.9.1-V1 fehlt.'
        WHEN @revision_3392 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.9.2-V1 fehlt.'
        WHEN @section_339_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9 konnte nicht angelegt werden.'
        WHEN @section_3391_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9.1 konnte nicht angelegt werden.'
        WHEN @section_3392_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9.2 konnte nicht angelegt werden.'
        WHEN @count_sections <> 3
            THEN CONCAT('FEHLER: Nur ', @count_sections, ' von 3 Abschnitten vorhanden.')
        WHEN @count_eq_3391 <> 6
            THEN CONCAT('FEHLER: ', @count_eq_3391, ' statt 6 Gleichungen 3.3.9.1 korrekt zugeordnet.')
        WHEN @count_eq_3392 <> 15
            THEN CONCAT('FEHLER: ', @count_eq_3392, ' statt 15 Gleichungen 3.3.9.2 korrekt zugeordnet.')
        ELSE 'OK: Abschnittshierarchie 3.3.9 bis 3.3.9.2 vollständig repariert.'
    END AS repair_status;

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    section_order,
    status
FROM dissertation_sections
WHERE section_code IN ('3.3','3.3.9','3.3.9.1','3.3.9.2')
ORDER BY section_order, section_code;

SELECT
    scl.change_id,
    scl.revision_id,
    scl.section_id,
    ds.section_code,
    scl.change_type,
    scl.object_type,
    scl.object_reference,
    scl.change_summary
FROM section_change_log scl
JOIN dissertation_sections ds
  ON ds.section_id = scl.section_id
WHERE ds.section_code IN ('3.3.9','3.3.9.1','3.3.9.2')
ORDER BY scl.change_id;
