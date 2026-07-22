/* ============================================================
   FRZK Repository Update
   Kapitel 3.6.4

   Abschnitt:
   Empirische Anwendung funktionaler Organisationsanalyse

   Neue Gleichungen:
   (3.1226) - (3.1230)

   ============================================================ */


USE frzk_rkb;

SET NAMES utf8mb4;

START TRANSACTION;


/* ============================================================
   Parent Revision bestimmen
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
    'RKB-REV-K3.6.4-V1',
    NOW(),
    'section',
    '3.6.4',
    '1.0',
    'Kapitel 3.6.4: Empirische Anwendung funktionaler Organisationsanalyse.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);


SET @revision_id = LAST_INSERT_ID();



/* ============================================================
   Abschnitt 3.6.4
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
    '3.6.4',
    'Empirische Anwendung funktionaler Organisationsanalyse',
    3,
    3.64,
    'completed',
    1,
    'Überführung mathematischer FRZK-Strukturen in empirisch beobachtbare Organisationsanalysen.'
FROM dissertation_sections
WHERE section_code='3.6'
LIMIT 1;


SET @section_id = LAST_INSERT_ID();



/* ============================================================
   Gleichungen 3.1226 - 3.1230
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
    '3.1226',
    @section_id,
    'Funktionale Beobachtungsrepräsentation',
    '\\Phi_F:\\mathcal{S}_F\\rightarrow V_F',
    '\\Phi_F:\\mathcal{S}_F\\rightarrow V_F',
    'Abbildung einer funktionalen Organisation in einen beobachtbaren Merkmalsraum.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1227',
    @section_id,
    'Funktionaler Beobachtungsvektor',
    'v_F=\\begin{pmatrix}a_1\\\\a_2\\\\\\vdots\\\\a_n\\end{pmatrix}',
    'v_F=\\begin{pmatrix}a_1\\\\a_2\\\\\\vdots\\\\a_n\\end{pmatrix}',
    'Darstellung beobachtbarer funktionaler Eigenschaften als Vektor.',
    'representation',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1228',
    @section_id,
    'Funktionale Zustandsüberführung',
    'T_F(v_F(t_i))=v_F(t_{i+1})',
    'T_F(v_F(t_i))=v_F(t_{i+1})',
    'Transformation zwischen aufeinanderfolgenden funktionalen Zuständen.',
    'operator',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1229',
    @section_id,
    'Zeitabhängige funktionale Kohärenz',
    'K_F(t)=f(\\mathcal{V}_F(t),\\Gamma_F(t),T_F(t))',
    'K_F(t)=f(\\mathcal{V}_F(t),\\Gamma_F(t),T_F(t))',
    'Abhängigkeit funktionaler Kohärenz von Zuständen, Relationen und Transformationen.',
    'model',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1230',
    @section_id,
    'Lernprozess als Zustandsraumtransformation',
    'L_F:V_F(t)\\rightarrow V_F(t+1)',
    'L_F:V_F(t)\\rightarrow V_F(t+1)',
    'Darstellung eines Lernprozesses als funktionale Veränderung eines Zustandsraums.',
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
    '3.6.4',
    NOW()
);



COMMIT;



/* ============================================================
   Audit
   ============================================================ */

SELECT
    'Kapitel 3.6.4 Update erfolgreich'
    AS status,
    @revision_id AS revision_id,
    @section_id AS section_id;