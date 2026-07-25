/* ============================================================
   FRZK Repository Update
   Kapitel 3.8.1
   Motivation der Simulation
   ============================================================ */

START TRANSACTION;

/* ============================================================
   Neue Revision
   ============================================================ */

INSERT INTO repository_revisions
(
    revision_number,
    description,
    created_at
)
SELECT
    '3.8.1',
    'Kapitel 3.8.1 Motivation der Simulation ergänzt',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_number='3.8.1'
);

SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_number='3.8.1'
    ORDER BY revision_id DESC
    LIMIT 1
);

/* ============================================================
   Kapitel suchen
   ============================================================ */

SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.8.1'
    LIMIT 1
);

/* ============================================================
   Abschnitt anlegen (falls noch nicht vorhanden)
   ============================================================ */

INSERT INTO dissertation_sections
(
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original,
    created_revision_id
)
SELECT
    (
        SELECT section_id
        FROM dissertation_sections
        WHERE section_code='3.8'
        LIMIT 1
    ),
    '3.8.1',
    'Motivation der Simulation',
    3,
    1,
    'draft',
    1,
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.8.1'
);

SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.8.1'
    LIMIT 1
);

/* ============================================================
   Änderungsprotokoll
   ============================================================ */

INSERT INTO section_change_log
(
    section_id,
    revision_id,
    change_type,
    object_type,
    object_reference,
    changed_at
)
SELECT
    @section_id,
    @revision_id,
    'created',
    'section',
    '3.8.1',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE
        section_id=@section_id
        AND revision_id=@revision_id
        AND object_reference='3.8.1'
);

/* ============================================================
   Definition:
   Simulation
   ============================================================ */

INSERT INTO definitions
(
    section_id,
    title,
    definition_text,
    provenance,
    validation_status,
    created_revision_id
)
SELECT
    @section_id,
    'Simulation der Operatorenkaskade',
    'Die Simulation der Operatorenkaskade bezeichnet die rekursive Anwendung sämtlicher im Funktionalen Raum-Zeit-Kohärenzsystem definierten Operatoren auf eine Folge funktionaler Zustände, um Stabilität, Emergenz und Kohärenz mathematisch zu untersuchen.',
    'original',
    'draft',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions
    WHERE title='Simulation der Operatorenkaskade'
);

/* ============================================================
   Definition:
   Rekursive Zustandsentwicklung
   ============================================================ */

INSERT INTO definitions
(
    section_id,
    title,
    definition_text,
    provenance,
    validation_status,
    created_revision_id
)
SELECT
    @section_id,
    'Rekursive Zustandsentwicklung',
    'Unter rekursiver Zustandsentwicklung wird die sukzessive Berechnung eines neuen funktionalen Zustands aus dem unmittelbar vorhergehenden Zustand durch Anwendung der vollständigen Operatorenkaskade verstanden.',
    'original',
    'draft',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions
    WHERE title='Rekursive Zustandsentwicklung'
);

/* ============================================================
   Lemma
   ============================================================ */

INSERT INTO lemmas
(
    section_id,
    title,
    statement,
    proof,
    provenance,
    validation_status,
    created_revision_id
)
SELECT
    @section_id,
    'Reproduzierbarkeit deterministischer Operatorfolgen',
    'Eine vollständig deterministische Operatorenkaskade erzeugt bei identischem Anfangszustand identische Zustandsfolgen.',
    'Folgt unmittelbar aus der eindeutigen Definition sämtlicher Operatoren und ihrer festen Reihenfolge.',
    'original',
    'draft',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM lemmas
    WHERE title='Reproduzierbarkeit deterministischer Operatorfolgen'
);

/* ============================================================
   Theorem
   ============================================================ */

INSERT INTO theorems
(
    section_id,
    title,
    statement,
    proof,
    provenance,
    validation_status,
    created_revision_id
)
SELECT
    @section_id,
    'Simulation als mathematische Analyse rekursiver Organisation',
    'Die rekursive Simulation erlaubt Aussagen über Stabilität, Emergenz und Kohärenzerhaltung eines funktionalen Organisationssystems.',
    'Die Aussage folgt aus der wiederholten Anwendung der wohldefinierten Operatoren auf eine Zustandsfolge und der anschließenden Analyse der resultierenden Trajektorie.',
    'original',
    'draft',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems
    WHERE title='Simulation als mathematische Analyse rekursiver Organisation'
);

/* ============================================================
   Audit
   ============================================================ */

INSERT INTO section_change_log
(
    section_id,
    revision_id,
    change_type,
    object_type,
    object_reference,
    changed_at
)
SELECT
    @section_id,
    @revision_id,
    'completed',
    'section',
    '3.8.1',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE
        section_id=@section_id
        AND revision_id=@revision_id
        AND change_type='completed'
        AND object_reference='3.8.1'
);

COMMIT;