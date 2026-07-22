/* ============================================================
   FRZK Repository Update
   Kapitel 3.6.1

   Abschnitt:
   Von funktionalen Zuständen zu beobachtbaren Zustandsräumen

   Neue Gleichungen:
   (3.1214) - (3.1217)

   Neue Quelle:
   [70]

   Schema-Version:
   frzk_rkb aktuell

   ============================================================ */


USE frzk_rkb;

SET NAMES utf8mb4;

START TRANSACTION;


/* ============================================================
   Parent Revision
   ============================================================ */

SET @parent_revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    ORDER BY revision_id DESC
    LIMIT 1
);


/* ============================================================
   Neue Revision
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
VALUES
(
    'RKB-REV-K3.6.1-V2',
    NOW(),
    'section',
    '3.6.1',
    '1.0',
    'Kapitel 3.6.1: Von funktionalen Zuständen zu beobachtbaren Zustandsräumen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);


SET @revision_id = LAST_INSERT_ID();



/* ============================================================
   Abschnitt 3.6.1
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
    section_id,
    '3.6.1',
    'Von funktionalen Zuständen zu beobachtbaren Zustandsräumen',
    3,
    3.61,
    'completed',
    1,
    'Operationalisierung funktionaler Zustände und Überführung in beobachtbare Zustandsräume.'
FROM dissertation_sections
WHERE section_code='3.6'
LIMIT 1;


SET @section_id = LAST_INSERT_ID();



/* ============================================================
   Quelle [70]
   ============================================================ */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original,
    publisher,
    place,
    created_at,
    updated_at
)
VALUES
(
    70,
    'rugh_analytical_dynamics_infinite_dimensional',
    'book',
    'Analytical Dynamics of Infinite Dimensional Systems',
    1981,
    'Springer',
    'New York',
    NOW(),
    NOW()
);


SET @source_id = LAST_INSERT_ID();



/* ============================================================
   Source Usage
   ============================================================ */

INSERT INTO source_usage
(
    source_id,
    section_id,
    claim_summary,
    usage_type,
    exact_location,
    is_first_mention,
    citation_checked,
    created_at
)
VALUES
(
    @source_id,
    @section_id,
    'Zustandsräume dynamischer Systeme als Grundlage mathematischer Systembeschreibung.',
    'theoretical_background',
    'Kapitel 3.6.1',
    1,
    1,
    NOW()
);



/* ============================================================
   Gleichung 3.1214
   ============================================================ */

INSERT INTO equations
(
    equation_number,
    section_id,
    title,
    equation_latex,
    word_latex,
    plain_description,
    equation_type,
    provenance,
    validation_status,
    created_revision_id
)
VALUES
(
    '3.1214',
    @section_id,
    'Funktionaler Zustandsraum',
    '\\mathcal{V}_F=\\{\\Phi_F(\\mathcal{S}_i)\\mid \\mathcal{S}_i\\in\\mathcal{G}_F\\}',
    '\\mathcal{V}_F=\\{\\Phi_F(\\mathcal{S}_i)\\mid \\mathcal{S}_i\\in\\mathcal{G}_F\\}',
    'Menge beobachtbarer Repräsentationen funktionaler Organisationen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1215',
    @section_id,
    'Funktionale Differenz beobachtbarer Zustände',
    '\\Delta_V:\\mathcal{V}_F\\times\\mathcal{V}_F\\rightarrow\\mathbb{R}_{\\geq0}',
    '\\Delta_V:\\mathcal{V}_F\\times\\mathcal{V}_F\\rightarrow\\mathbb{R}_{\\geq0}',
    'Abbildung funktionaler Unterschiede zwischen Zustandsrepräsentationen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1216',
    @section_id,
    'Zustandsfolge funktionaler Repräsentationen',
    '\\mathcal{V}_F(t)=\\left(v_1(t),v_2(t),\\ldots,v_n(t)\\right)',
    '\\mathcal{V}_F(t)=\\left(v_1(t),v_2(t),\\ldots,v_n(t)\\right)',
    'Darstellung einer Folge beobachtbarer funktionaler Zustände.',
    'representation',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1217',
    @section_id,
    'Funktionale Zustandsüberführung',
    'T_F:\\mathcal{V}_F(t)\\rightarrow\\mathcal{V}_F(t+1)',
    'T_F:\\mathcal{V}_F(t)\\rightarrow\\mathcal{V}_F(t+1)',
    'Transformation zwischen aufeinanderfolgenden funktionalen Zuständen.',
    'operator',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
);



/* ============================================================
   Abschnittsänderung protokollieren
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
VALUES
(
    @section_id,
    @revision_id,
    'completed',
    'section',
    '3.6.1',
    NOW()
);



COMMIT;


/* ============================================================
   Audit
   ============================================================ */

SELECT
    'Kapitel 3.6.1 Update erfolgreich'
    AS status,
    @revision_id AS revision_id,
    @section_id AS section_id;