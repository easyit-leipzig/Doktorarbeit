/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9 / Abschnitt 3.9.0
   Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems

   Schema-Grundlage:
   frzk_rkb(3).sql

   Bestätigte Feldnamen:
   - repository_revisions.revision_code
   - dissertation_sections.is_original_contribution
   - dissertation_sections besitzt KEIN created_revision_id
   - section_change_log.change_summary ist NOT NULL
   - source_usage.created_revision_id ist vorhanden

   Eigenschaften:
   - idempotent
   - transaktional
   - mit Literaturverknüpfungen
   - mit Abschlussvalidierungen
   ============================================================ */

START TRANSACTION;

/* ============================================================
   1. Repository-Revision anlegen
   ============================================================ */

SET @revision_code := 'RKB-2026-07-25-K3.9.0-V2';

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
    @revision_code,
    NOW(),
    'section',
    '3.9.0',
    '2.0',
    'Anlage von Kapitel 3.9 und Abschnitt 3.9.0 einschließlich Literaturverknüpfungen und MariaDB-10.4-kompatibler Repository-Validierung.',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = @revision_code
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = @revision_code
    LIMIT 1
);

/* ============================================================
   2. Kapitel 3.9 anlegen oder vorhandenen Eintrag aktualisieren

   Kapitel 3.1 bis 3.4 sind im geprüften Schema eigenständige
   Hauptabschnitte mit parent_section_id = NULL. Kapitel 3.9 wird
   daher nach demselben Strukturprinzip angelegt.
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
    NULL,
    '3.9',
    'Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    3.9000,
    'draft',
    1,
    'Abschließende theoretische Synthese der in den Kapiteln 3.1 bis 3.8 entwickelten Grundlagen, Rekonstruktionen, Operatorstrukturen und Simulationsarchitekturen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.9'
);

UPDATE dissertation_sections
SET
    parent_section_id = NULL,
    title = 'Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    chapter_no = 3,
    section_order = 3.9000,
    is_original_contribution = 1,
    notes = 'Abschließende theoretische Synthese der in den Kapiteln 3.1 bis 3.8 entwickelten Grundlagen, Rekonstruktionen, Operatorstrukturen und Simulationsarchitekturen.'
WHERE section_code = '3.9';

SET @chapter_39_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.9'
    LIMIT 1
);

/* ============================================================
   3. Abschnitt 3.9.0 anlegen oder aktualisieren
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
    @chapter_39_id,
    '3.9.0',
    'Einleitung – Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    3.9001,
    'draft',
    1,
    'Einführung in die systematische Zusammenführung der erkenntnistheoretischen, mathematischen, axiomatischen, dynamischen und simulationsbezogenen Ergebnisse des dritten Kapitels.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.9.0'
);

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_39_id,
    title = 'Einleitung – Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    chapter_no = 3,
    section_order = 3.9001,
    is_original_contribution = 1,
    notes = 'Einführung in die systematische Zusammenführung der erkenntnistheoretischen, mathematischen, axiomatischen, dynamischen und simulationsbezogenen Ergebnisse des dritten Kapitels.'
WHERE section_code = '3.9.0';

SET @section_390_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.9.0'
    LIMIT 1
);

/* ============================================================
   4. Literaturverwendungen für Abschnitt 3.9.0

   Es werden ausschließlich bereits im geprüften Dump vorhandene
   Masterquellen verwendet. Die Quellen werden über ihre eindeutige
   citation_number aufgelöst; feste source_id-Werte werden vermieden.

   Verwendete Quellen:
   [9]  Bourbaki – General Topology
   [12] Haken – Synergetics
   [15] Barabási – Network Science
   [37] Strogatz – Nonlinear Dynamics and Chaos
   [45] Cover/Thomas – Elements of Information Theory
   [46] Shannon – A Mathematical Theory of Communication
   [47] Diestel – Graph Theory
   [48] Newman – Networks
   [51] Camazine et al. – Self-Organization in Biological Systems
   [52] Mitchell – Complexity: A Guided Tour
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
    @section_390_id,
    x.usage_type,
    x.claim_summary,
    'Abschnitt 3.9.0',
    0,
    1,
    'Wiederverwendung einer bereits nummerierten und im Repository vorhandenen Masterquelle für die Gesamtsynthese.',
    @revision_id
FROM
(
    SELECT 9 AS citation_number,
           'background' AS usage_type,
           'Topologische Strukturbegriffe bilden einen mathematischen Bezugsrahmen für die Rekonstruktion funktionaler Raumstrukturen.' AS claim_summary
    UNION ALL
    SELECT 12,
           'background',
           'Synergetische Selbstorganisation dient als etablierter Vergleichshorizont für die Entstehung stabiler Organisationsmuster.'
    UNION ALL
    SELECT 15,
           'comparison',
           'Netzwerkwissenschaftliche Strukturen werden als Vergleichsebene für relationale und organisationale Rekonstruktionen herangezogen.'
    UNION ALL
    SELECT 37,
           'background',
           'Nichtlineare Dynamik bildet einen mathematischen Bezugsrahmen für Zustandsentwicklung, Trajektorien und Attraktorstrukturen.'
    UNION ALL
    SELECT 45,
           'background',
           'Informationstheoretische Maße bilden einen Vergleichsrahmen für die funktionale Beschreibung von Information und Kohärenz.'
    UNION ALL
    SELECT 46,
           'historical_context',
           'Shannons mathematische Informationstheorie markiert einen zentralen historischen Ausgangspunkt der formalen Informationsbeschreibung.'
    UNION ALL
    SELECT 47,
           'background',
           'Graphentheoretische Begriffe dienen der formalen Darstellung relationaler Strukturen und ihrer Verknüpfungen.'
    UNION ALL
    SELECT 48,
           'comparison',
           'Moderne Netzwerktheorie dient zur wissenschaftlichen Abgrenzung des FRZK gegenüber Modellen, die Knoten und Netzwerke bereits voraussetzen.'
    UNION ALL
    SELECT 51,
           'comparison',
           'Modelle biologischer Selbstorganisation bilden einen Vergleichshorizont für emergente funktionale Organisationsprozesse.'
    UNION ALL
    SELECT 52,
           'state_of_research',
           'Komplexitätsforschung bildet den übergeordneten Forschungsrahmen für Emergenz, Selbstorganisation und nichtlineare Systementwicklung.'
) AS x
INNER JOIN sources AS s
    ON s.citation_number = x.citation_number
WHERE NOT EXISTS
(
    SELECT 1
    FROM source_usage AS su
    WHERE su.source_id = s.source_id
      AND su.section_id = @section_390_id
      AND su.usage_type = x.usage_type
      AND su.exact_location = 'Abschnitt 3.9.0'
);

/* ============================================================
   5. Änderungsprotokoll – Kapitel 3.9
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
    new_value,
    changed_at
)
SELECT
    @revision_id,
    @chapter_39_id,
    'created',
    'section',
    '3.9',
    'Kapitel 3.9 als abschließendes Synthesekapitel des theoretischen Hauptteils angelegt beziehungsweise schema-konform aktualisiert.',
    NULL,
    'draft',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @chapter_39_id
      AND change_type = 'created'
      AND object_reference = '3.9'
);

/* ============================================================
   6. Änderungsprotokoll – Abschnitt 3.9.0
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
    new_value,
    changed_at
)
SELECT
    @revision_id,
    @section_390_id,
    'created',
    'section',
    '3.9.0',
    'Abschnitt 3.9.0 als Einleitung zur Gesamtsynthese angelegt beziehungsweise schema-konform aktualisiert.',
    NULL,
    'draft',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_390_id
      AND change_type = 'created'
      AND object_reference = '3.9.0'
);

/* ============================================================
   7. Änderungsprotokoll – Literaturverknüpfungen
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
    new_value,
    changed_at
)
SELECT
    @revision_id,
    @section_390_id,
    'source_reused',
    'source_usage',
    '3.9.0-literature',
    'Zehn bereits vorhandene Masterquellen wurden als Literaturgrundlage der Gesamtsynthese mit Abschnitt 3.9.0 verknüpft.',
    NULL,
    CONCAT(
        '',
        (
            SELECT COUNT(*)
            FROM source_usage
            WHERE section_id = @section_390_id
              AND exact_location = 'Abschnitt 3.9.0'
        )
    ),
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_390_id
      AND change_type = 'source_reused'
      AND object_reference = '3.9.0-literature'
);

/* ============================================================
   8. Repository-Validierungen
   ============================================================ */

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
VALUES
(
    @revision_id,
    'K3.9.0.CHAPTER_EXISTS',
    IF(@chapter_39_id IS NOT NULL, 'passed', 'failed'),
    '1',
    IF(@chapter_39_id IS NOT NULL, '1', '0'),
    'Prüfung, ob Kapitel 3.9 im Abschnittsregister vorhanden ist.',
    NOW()
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = VALUES(checked_at);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
VALUES
(
    @revision_id,
    'K3.9.0.SECTION_EXISTS',
    IF(@section_390_id IS NOT NULL, 'passed', 'failed'),
    '1',
    IF(@section_390_id IS NOT NULL, '1', '0'),
    'Prüfung, ob Abschnitt 3.9.0 im Abschnittsregister vorhanden ist.',
    NOW()
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = VALUES(checked_at);

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id = @section_390_id
      AND exact_location = 'Abschnitt 3.9.0'
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
VALUES
(
    @revision_id,
    'K3.9.0.SOURCE_USAGE',
    IF(@source_usage_count = 10, 'passed', 'warning'),
    '10',
    CONCAT('', @source_usage_count),
    'Prüfung der zehn vorgesehenen Literaturverknüpfungen für Abschnitt 3.9.0.',
    NOW()
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = VALUES(checked_at);

SET @missing_source_count :=
(
    SELECT COUNT(*)
    FROM
    (
        SELECT 9 AS citation_number
        UNION ALL SELECT 12
        UNION ALL SELECT 15
        UNION ALL SELECT 37
        UNION ALL SELECT 45
        UNION ALL SELECT 46
        UNION ALL SELECT 47
        UNION ALL SELECT 48
        UNION ALL SELECT 51
        UNION ALL SELECT 52
    ) AS required_sources
    LEFT JOIN sources AS s
        ON s.citation_number = required_sources.citation_number
    WHERE s.source_id IS NULL
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
VALUES
(
    @revision_id,
    'K3.9.0.REQUIRED_SOURCES',
    IF(@missing_source_count = 0, 'passed', 'failed'),
    '0 fehlende Quellen',
    CONCAT(@missing_source_count, ' fehlende Quellen'),
    'Prüfung, ob alle für Abschnitt 3.9.0 vorgesehenen Masterquellen im Quellenregister vorhanden sind.',
    NOW()
)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = VALUES(checked_at);

/* ============================================================
   9. Abschluss
   ============================================================ */

COMMIT;

/* ============================================================
   10. Importkontrolle
   ============================================================ */

SELECT
    rr.revision_id,
    rr.revision_code,
    rr.scope_reference,
    rr.version_label
FROM repository_revisions AS rr
WHERE rr.revision_code = @revision_code;

SELECT
    ds.section_id,
    ds.parent_section_id,
    ds.section_code,
    ds.title,
    ds.chapter_no,
    ds.section_order,
    ds.status,
    ds.is_original_contribution
FROM dissertation_sections AS ds
WHERE ds.section_code IN ('3.9', '3.9.0')
ORDER BY ds.section_order;

SELECT
    s.citation_number,
    s.short_citation_text,
    su.usage_type,
    su.exact_location,
    su.citation_checked
FROM source_usage AS su
INNER JOIN sources AS s
    ON s.source_id = su.source_id
WHERE su.section_id = @section_390_id
  AND su.exact_location = 'Abschnitt 3.9.0'
ORDER BY s.citation_number;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_id
  AND validation_code LIKE 'K3.9.0.%'
ORDER BY validation_code;
