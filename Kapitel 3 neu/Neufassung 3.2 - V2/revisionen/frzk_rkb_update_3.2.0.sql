/* ============================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.2.0
   Abschnitt: 3.2 Mathematische Grundlagen – Einleitung
   Grundlage: frzk_rkb_nach_abschluss_3.1.sql
   Stand: 2026-07-18

   Inhalt:
   - Anlage bzw. Aktualisierung des Hauptabschnitts 3.2
   - Anlage bzw. Aktualisierung von Abschnitt 3.2.0
   - Repository-Revision mit Parent-Verknüpfung zur Revision von 3.1.7
   - Änderungsprotokoll
   - Validierungsprüfungen
   - keine neuen Quellen, Gleichungen, Definitionen oder Symbole

   Eigenschaften:
   - idempotent
   - keine fest codierten Primärschlüssel
   - bestehende Literatur- und Gleichungsnummerierung bleibt unverändert
   ============================================================================ */

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @old_sql_safe_updates := @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

START TRANSACTION;

/* ============================================================================
   1. Ausgangsstand bestimmen
   ============================================================================ */

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.7-V1'
    LIMIT 1
);

SET @chapter_3_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3'
    LIMIT 1
);

/* Vorbedingungen werden am Ende als eigene Validierungen geprüft. Das Skript
   setzt den vollständig importierten Stand nach Abschluss von 3.1 voraus. */

/* ============================================================================
   2. Hauptabschnitt 3.2 anlegen oder aktualisieren
   ============================================================================ */

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
VALUES
(
    @chapter_3_id,
    '3.2',
    'Mathematische Grundlagen',
    3,
    3.2000,
    'review',
    0,
    'Mathematische Brücke zwischen den wissenschaftstheoretischen Grundlagen aus Kapitel 3.1 und der axiomatischen Grundlegung in Kapitel 3.3. Der Abschnitt rekonstruiert den etablierten mathematischen Forschungsstand, ohne die eigene FRZK-Mathematik vorwegzunehmen.'
)
ON DUPLICATE KEY UPDATE
    parent_section_id        = VALUES(parent_section_id),
    title                    = VALUES(title),
    chapter_no               = VALUES(chapter_no),
    section_order            = VALUES(section_order),
    status                   = VALUES(status),
    is_original_contribution = VALUES(is_original_contribution),
    notes                    = VALUES(notes),
    updated_at               = CURRENT_TIMESTAMP;

SET @section_3_2_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

/* ============================================================================
   3. Abschnitt 3.2.0 anlegen oder aktualisieren
   ============================================================================ */

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
VALUES
(
    @section_3_2_id,
    '3.2.0',
    'Einleitung',
    3,
    3.2001,
    'final',
    0,
    'Die Einleitung bestimmt Kapitel 3.2 als mathematischen Forschungsstandsabschnitt. Sie erläutert den Übergang von der wissenschaftstheoretischen Grundlegung zu den etablierten mathematischen Strukturbegriffen und macht sichtbar, dass mathematische Theorien Mengen, Relationen, Funktionen, Operatoren, Zustandsräume und weitere Strukturen regelmäßig bereits voraussetzen. Die eigene FRZK-Axiomatik und mathematische Rekonstruktion bleiben den Kapiteln 3.3 und 3.4 vorbehalten.'
)
ON DUPLICATE KEY UPDATE
    parent_section_id        = VALUES(parent_section_id),
    title                    = VALUES(title),
    chapter_no               = VALUES(chapter_no),
    section_order            = VALUES(section_order),
    status                   = VALUES(status),
    is_original_contribution = VALUES(is_original_contribution),
    notes                    = VALUES(notes),
    updated_at               = CURRENT_TIMESTAMP;

SET @section_3_2_0_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.0'
    LIMIT 1
);

/* ============================================================================
   4. Repository-Revision anlegen oder aktualisieren
   ============================================================================ */

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
VALUES
(
    'RKB-NEU-K3.2.0-V1',
    '2026-07-18 07:30:00',
    'section',
    '3.2.0',
    '1.0',
    'Neuanlage von Kapitel 3.2 Mathematische Grundlagen und Abschluss von Abschnitt 3.2.0 Einleitung. Der Abschnitt legt Funktion, Abgrenzung, wissenschaftliche Zielsetzung und Aufbau des mathematischen Forschungsstands fest. Es werden keine neuen Quellen, Gleichungen, Definitionen oder FRZK-spezifischen mathematischen Objekte eingeführt.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    revision_date      = VALUES(revision_date),
    scope_type         = VALUES(scope_type),
    scope_reference    = VALUES(scope_reference),
    version_label      = VALUES(version_label),
    summary            = VALUES(summary),
    created_by         = VALUES(created_by),
    parent_revision_id = VALUES(parent_revision_id);

SET @revision_3_2_0_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.0-V1'
    LIMIT 1
);

/* ============================================================================
   5. Änderungsprotokoll
   ============================================================================ */

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
    @revision_3_2_0_id,
    @section_3_2_id,
    'created',
    'section',
    '3.2',
    'Hauptabschnitt 3.2 Mathematische Grundlagen wurde als mathematischer Forschungsstandsabschnitt angelegt.',
    NULL,
    'status=review; is_original_contribution=0'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3_2_0_id
      AND section_id = @section_3_2_id
      AND object_reference = '3.2'
      AND change_type = 'created'
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
    @revision_3_2_0_id,
    @section_3_2_0_id,
    'created',
    'section',
    '3.2.0',
    'Abschnitt 3.2.0 Einleitung wurde vollständig neu angelegt und als abgeschlossen markiert.',
    NULL,
    'status=final; keine neuen Quellen oder Gleichungen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3_2_0_id
      AND section_id = @section_3_2_0_id
      AND object_reference = '3.2.0'
      AND change_type = 'created'
);

/* ============================================================================
   6. Repository-Zähler sichern
   Die Einleitung führt keine neue Quelle ein. Die nächste freie
   Literaturziffer bleibt deshalb 66.
   ============================================================================ */

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('next_citation_number', '66')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 66 THEN '66'
        ELSE counter_value
    END;

/* ============================================================================
   7. Validierungsdaten dieser Revision neu schreiben
   ============================================================================ */

DELETE FROM repository_validation_results
WHERE revision_id = @revision_3_2_0_id;

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
    @revision_3_2_0_id,
    'K3.2.0-SECTION-EXISTS',
    CASE WHEN COUNT(*) = 1 THEN 'passed' ELSE 'failed' END,
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.0 muss genau einmal im Repository vorhanden sein.'
FROM dissertation_sections
WHERE section_code = '3.2.0';

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
    @revision_3_2_0_id,
    'K3.2.0-PARENT',
    CASE WHEN parent_section_id = @section_3_2_id THEN 'passed' ELSE 'failed' END,
    CAST(@section_3_2_id AS CHAR),
    CAST(parent_section_id AS CHAR),
    'Abschnitt 3.2.0 muss dem Hauptabschnitt 3.2 untergeordnet sein.'
FROM dissertation_sections
WHERE section_id = @section_3_2_0_id;

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
    @revision_3_2_0_id,
    'K3.2.0-STATUS',
    CASE WHEN status = 'final' THEN 'passed' ELSE 'failed' END,
    'final',
    status,
    'Der abgeschlossene Einleitungsabschnitt muss den Status final besitzen.'
FROM dissertation_sections
WHERE section_id = @section_3_2_0_id;

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
    @revision_3_2_0_id,
    'K3.2.0-NO-NEW-SOURCES',
    CASE WHEN COUNT(*) = 0 THEN 'passed' ELSE 'warning' END,
    '0',
    CAST(COUNT(*) AS CHAR),
    'Für 3.2.0 wurden planmäßig keine neuen Quellenverwendungen registriert.'
FROM source_usage
WHERE section_id = @section_3_2_0_id
  AND created_revision_id = @revision_3_2_0_id;

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
    @revision_3_2_0_id,
    'K3.2.0-NO-EQUATIONS',
    CASE WHEN COUNT(*) = 0 THEN 'passed' ELSE 'warning' END,
    '0',
    CAST(COUNT(*) AS CHAR),
    'Die Einleitung enthält planmäßig keine registrierungspflichtige Gleichung.'
FROM equations
WHERE section_id = @section_3_2_0_id
  AND created_revision_id = @revision_3_2_0_id;

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
    @revision_3_2_0_id,
    'K3.2.0-PARENT-REVISION',
    CASE WHEN parent_revision_id = @parent_revision_id THEN 'passed' ELSE 'failed' END,
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision von 3.2.0 muss unmittelbar auf dem Abschluss von 3.1.7 aufbauen.'
FROM repository_revisions
WHERE revision_id = @revision_3_2_0_id;

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
    @revision_3_2_0_id,
    'K3.2.0-NEXT-CITATION',
    CASE WHEN CAST(counter_value AS UNSIGNED) >= 66 THEN 'passed' ELSE 'failed' END,
    '>=66',
    counter_value,
    'Die nächste freie Literaturziffer darf durch 3.2.0 nicht zurückgesetzt werden.'
FROM repository_counters
WHERE counter_key = 'next_citation_number';

/* ============================================================================
   8. Abschlussprüfung
   ============================================================================ */

SELECT
    rvr.validation_code,
    rvr.validation_status,
    rvr.expected_value,
    rvr.actual_value,
    rvr.validation_message
FROM repository_validation_results AS rvr
WHERE rvr.revision_id = @revision_3_2_0_id
ORDER BY rvr.validation_code;

COMMIT;
SET SQL_SAFE_UPDATES = @old_sql_safe_updates;

/* ============================================================================
   Erwarteter Repository-Stand nach erfolgreichem Import
   --------------------------------------------------------------------------
   letzter Abschnitt:       3.2.0
   nächste Sektion:         3.2.1
   letzte Revision:         RKB-NEU-K3.2.0-V1
   nächste Literaturziffer: 66
   neue Gleichungen:        keine
   neue Definitionen:       keine
   ============================================================================ */
