/* ============================================================
   FRZK Repository Update
   Kapitel 3.6.6

   Abschnitt:
   Grenzen und Validierungsanforderungen

   Neue Gleichungen:
   (3.1236) - (3.1238)

   ============================================================ */


USE frzk_rkb;

SET NAMES utf8mb4;

START TRANSACTION;


/* ============================================================
   Revision bestimmen
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
    'RKB-REV-K3.6.6-V1',
    NOW(),
    'section',
    '3.6.6',
    '1.0',
    'Kapitel 3.6.6: Grenzen und Validierungsanforderungen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);


SET @revision_id = LAST_INSERT_ID();



/* ============================================================
   Abschnitt 3.6.6
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
    '3.6.6',
    'Grenzen und Validierungsanforderungen',
    3,
    6.60,
    'completed',
    1,
    'Kritische Einordnung der funktionalen Organisationsanalyse und Anforderungen an empirische Validierung.'
FROM dissertation_sections
WHERE section_code='3.6'
LIMIT 1;


SET @section_id = LAST_INSERT_ID();



/* ============================================================
   Gleichungen 3.1236 - 3.1238
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
'3.1236',
@section_id,
'Funktionale Beobachtungsrepräsentation',
'\Phi_F:\mathcal{S}_F\rightarrow V_F',
'\Phi_F:\mathcal{S}_F\rightarrow V_F',
'Abbildung einer funktionalen Organisation in einen Beobachtungsraum.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1237',
@section_id,
'Funktionale Relationsstruktur',
'\Gamma_F\subseteq V_F\times V_F',
'\Gamma_F\subseteq V_F\times V_F',
'Darstellung funktionaler Beziehungen zwischen Zuständen.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1238',
@section_id,
'Skalierte funktionale Kohärenz',
'K_F^{(n)}=f(V_F^{(n)},\Gamma_F^{(n)},T_F^{(n)})',
'K_F^{(n)}=f(V_F^{(n)},\Gamma_F^{(n)},T_F^{(n)})',
'Beschreibung funktionaler Kohärenz auf unterschiedlichen Organisationsebenen.',
'model',
'FRZK Eigenentwicklung',
'checked',
@revision_id
);



/* ============================================================
   Change Log
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
    '3.6.6',
    NOW()
);



COMMIT;



/* ============================================================
   Audit
   ============================================================ */

SELECT
    'Kapitel 3.6.6 Update erfolgreich'
    AS status,
    @revision_id AS revision_id,
    @section_id AS section_id;


SELECT
    equation_number,
    title
FROM equations
WHERE equation_number BETWEEN '3.1236'
AND '3.1238'
ORDER BY equation_number;