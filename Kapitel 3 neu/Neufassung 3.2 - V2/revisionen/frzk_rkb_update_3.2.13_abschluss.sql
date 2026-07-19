-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschnitt 3.2.13
--
-- Abschnitt: Zusammenfassung und mathematische Einordnung
-- Aufbauend auf: RKB-NEU-K3.2.12-V1
-- Revision:       RKB-NEU-K3.2.13-V1
-- Neue Quellen:   keine
-- Neue Definitionen: keine
-- Neue Sätze:     keine
-- Neue Beweise:   keine
-- Neue Gleichungen: keine
-- Nächste Quelle: [103]
-- Nächste Gleichung: (3.354)
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Ausgangsstand
-- ---------------------------------------------------------------------

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.12-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

SELECT CASE
    WHEN @parent_revision_id IS NULL
        THEN 'FEHLER: Revision RKB-NEU-K3.2.12-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach Abschnitt 3.2.12 vorhanden.'
END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Repository-Revision
-- ---------------------------------------------------------------------

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
    'RKB-NEU-K3.2.13-V1',
    NOW(),
    'section',
    '3.2.13',
    '1.0',
    'Redaktioneller und mathematischer Abschluss von Kapitel 3.2. Der Abschnitt fasst die eingeführten Strukturen zusammen, ordnet ihre Funktion im FRZK ein und bereitet den Übergang zur axiomatischen Entwicklung in Kapitel 3.3 vor. Es werden keine neuen Quellen, Definitionen, Sätze, Beweise oder Gleichungen angelegt.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.13-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.13-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Abschnitt 3.2.13
-- ---------------------------------------------------------------------

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
    @chapter_section_id,
    '3.2.13',
    'Zusammenfassung und mathematische Einordnung',
    3,
    3.2130,
    'final',
    0,
    'Zusammenfassungs- und Übergangsabschnitt. Er ordnet die mathematischen Grundlagen des Kapitels 3.2 in das FRZK ein und führt ohne neue mathematische Objekte zur Axiomatik des Kapitels 3.3.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.13'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Zusammenfassung und mathematische Einordnung',
    chapter_no = 3,
    section_order = 3.2130,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Zusammenfassungs- und Übergangsabschnitt. Er ordnet die mathematischen Grundlagen des Kapitels 3.2 in das FRZK ein und führt ohne neue mathematische Objekte zur Axiomatik des Kapitels 3.3.'
WHERE section_code = '3.2.13';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.13'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Kapitelstatus 3.2
-- ---------------------------------------------------------------------

UPDATE dissertation_sections
SET
    status = 'final',
    notes = CONCAT(
        COALESCE(NULLIF(notes, ''), ''),
        CASE
            WHEN notes IS NULL OR notes = '' THEN ''
            ELSE ' '
        END,
        'Kapitel 3.2 ist mit Abschnitt 3.2.13 redaktionell abgeschlossen. ',
        'Nächste freie Literaturnummer: [103]. ',
        'Nächste freie Gleichungsnummer: (3.354).'
    )
WHERE section_code = '3.2'
  AND (
      notes IS NULL
      OR notes NOT LIKE '%Kapitel 3.2 ist mit Abschnitt 3.2.13 redaktionell abgeschlossen.%'
  );

-- ---------------------------------------------------------------------
-- 5. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_citation_number', '103')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 103 THEN '103'
        ELSE counter_value
    END;

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_equation_number', '3.354')
ON DUPLICATE KEY UPDATE
    counter_value = '3.354';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_completed_section', '3.2.13')
ON DUPLICATE KEY UPDATE
    counter_value = '3.2.13';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_repository_revision', 'RKB-NEU-K3.2.13-V1')
ON DUPLICATE KEY UPDATE
    counter_value = 'RKB-NEU-K3.2.13-V1';

-- ---------------------------------------------------------------------
-- 6. Änderungsprotokoll
-- ---------------------------------------------------------------------

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
    'rewritten',
    'section',
    '3.2.13',
    'Abschnitt 3.2.13 wurde als Zusammenfassung und mathematische Einordnung vollständig aufgenommen.',
    'Grenzen bestehender mathematischer Modelle und Herleitung der Forschungslücke',
    'Zusammenfassung und mathematische Einordnung'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '3.2.13'
        AND change_type = 'rewritten'
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
    @chapter_section_id,
    'status_changed',
    'section',
    '3.2',
    'Kapitel 3.2 wurde nach Abschluss von Abschnitt 3.2.13 auf final gesetzt.',
    'review',
    'final'
WHERE @revision_id IS NOT NULL
  AND @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @chapter_section_id
        AND object_reference = '3.2'
        AND change_type = 'status_changed'
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
    'source_reused',
    'sources',
    'keine neuen Quellen',
    'Der Abschlussabschnitt führt keine neue Literatur ein; die nächste freie Literaturnummer bleibt [103].',
    'next_citation_number=103',
    'next_citation_number=103'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = 'keine neuen Quellen'
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
    'other',
    'equations',
    'keine neuen Gleichungen',
    'Der Abschlussabschnitt führt keine neue Gleichung ein; die nächste freie Gleichungsnummer bleibt (3.354).',
    'next_equation_number=3.354',
    'next_equation_number=3.354'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = 'keine neuen Gleichungen'
  );

-- ---------------------------------------------------------------------
-- 7. Validierungen
-- ---------------------------------------------------------------------

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
    'K3.2.13_SECTION',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.13 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code = '3.2.13'
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
    'K3.2.13_TITLE',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    'Zusammenfassung und mathematische Einordnung',
    COALESCE(MAX(title), 'nicht vorhanden'),
    'Der Abschnitt muss den festgelegten Abschlusstitel tragen.'
FROM dissertation_sections
WHERE section_code = '3.2.13'
  AND title = 'Zusammenfassung und mathematische Einordnung'
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
    'K3.2.13_NO_NEW_SOURCES',
    IF(COUNT(*) = 0, 'passed', 'failed'),
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.13 darf keine neu angelegte Quelle besitzen.'
FROM sources
WHERE created_revision_id = @revision_id
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
    'K3.2.13_NO_NEW_DEFINITIONS',
    IF(COUNT(*) = 0, 'passed', 'failed'),
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.13 darf keine neue Definition besitzen.'
FROM definitions
WHERE section_id = @section_id
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
    'K3.2.13_NO_NEW_THEOREMS',
    IF(COUNT(*) = 0, 'passed', 'failed'),
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.13 darf keinen neuen Satz besitzen.'
FROM theorems
WHERE section_id = @section_id
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
    'K3.2.13_NO_NEW_PROOFS',
    IF(COUNT(*) = 0, 'passed', 'failed'),
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.13 darf keinen neuen Beweis besitzen.'
FROM proofs
WHERE section_id = @section_id
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
    'K3.2.13_NO_NEW_EQUATIONS',
    IF(COUNT(*) = 0, 'passed', 'failed'),
    '0',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.13 darf keine neue Gleichung besitzen.'
FROM equations
WHERE section_id = @section_id
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
    'K3.2.13_CHAPTER_FINAL',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    'final',
    COALESCE(MAX(status), 'nicht vorhanden'),
    'Kapitel 3.2 muss nach dem Abschlussabschnitt den Status final besitzen.'
FROM dissertation_sections
WHERE section_code = '3.2'
  AND status = 'final'
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
    'K3.2.13_NEXT_SOURCE',
    IF(MAX(counter_value) = '103', 'passed', 'failed'),
    '103',
    COALESCE(MAX(counter_value), 'nicht vorhanden'),
    'Die nächste freie Literaturnummer muss [103] bleiben.'
FROM repository_counters
WHERE counter_key = 'next_citation_number'
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
    'K3.2.13_NEXT_EQUATION',
    IF(MAX(counter_value) = '3.354', 'passed', 'failed'),
    '3.354',
    COALESCE(MAX(counter_value), 'nicht vorhanden'),
    'Die nächste freie Gleichungsnummer muss (3.354) bleiben.'
FROM repository_counters
WHERE counter_key = 'next_equation_number'
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
    'K3.2.13_PARENT_REVISION',
    IF(parent_revision_id = @parent_revision_id, 'passed', 'failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision muss unmittelbar auf RKB-NEU-K3.2.12-V1 aufbauen.'
FROM repository_revisions
WHERE revision_id = @revision_id
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

COMMIT;

-- ---------------------------------------------------------------------
-- 8. Audit-Abfragen
-- ---------------------------------------------------------------------

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    parent_revision_id,
    revision_date
FROM repository_revisions
WHERE revision_code = 'RKB-NEU-K3.2.13-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution,
    notes
FROM dissertation_sections
WHERE section_code IN ('3.2', '3.2.13')
ORDER BY section_order;

SELECT
    counter_key,
    counter_value,
    updated_at
FROM repository_counters
WHERE counter_key IN
(
    'next_citation_number',
    'next_equation_number',
    'last_completed_section',
    'last_repository_revision'
)
ORDER BY counter_key;

SELECT
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
FROM section_change_log
WHERE revision_id = @revision_id
ORDER BY change_id;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_id
ORDER BY validation_code;

SELECT
    CASE
        WHEN SUM(validation_status = 'failed') = 0
            THEN 'PASS: Abschnitt 3.2.13 und Kapitel 3.2 sind konsistent abgeschlossen.'
        ELSE 'FAIL: Mindestens eine Validierung ist fehlgeschlagen.'
    END AS final_audit_status,
    SUM(validation_status = 'passed') AS passed_checks,
    SUM(validation_status = 'warning') AS warning_checks,
    SUM(validation_status = 'failed') AS failed_checks
FROM repository_validation_results
WHERE revision_id = @revision_id;
