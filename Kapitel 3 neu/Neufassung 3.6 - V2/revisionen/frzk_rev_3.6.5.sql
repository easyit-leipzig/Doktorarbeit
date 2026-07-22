/* ============================================================
   FRZK Repository Update
   Kapitel 3.6.5

   Abschnitt:
   Funktionale Netzwerke und emergente Organisationsmuster

   Neue Gleichungen:
   (3.1231) - (3.1235)

   Quellen:
   [73] Newman bereits vorhanden

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
    'RKB-REV-K3.6.5-V1',
    NOW(),
    'section',
    '3.6.5',
    '1.0',
    'Kapitel 3.6.5: Funktionale Netzwerke und emergente Organisationsmuster.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);


SET @revision_id = LAST_INSERT_ID();



/* ============================================================
   Abschnitt 3.6.5
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
    '3.6.5',
    'Funktionale Netzwerke und emergente Organisationsmuster',
    3,
    3.65,
    'completed',
    1,
    'Erweiterung funktionaler Organisationen zu dynamischen Netzwerken und emergenten Strukturen.'
FROM dissertation_sections
WHERE section_code='3.6'
LIMIT 1;


SET @section_id = LAST_INSERT_ID();



/* ============================================================
   Source Usage [73]
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
SELECT
    source_id,
    @section_id,
    'Netzwerktheorie als Grundlage zur Beschreibung komplexer relationaler Strukturen.',
    'theoretical_background',
    'Kapitel 3.6.5',
    0,
    1,
    NOW()
FROM sources
WHERE citation_number=73;



/* ============================================================
   Gleichungen 3.1231 - 3.1235
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
    '3.1231',
    @section_id,
    'Funktionale Organisationsstruktur',
    '\\mathcal{O}_F=(\\mathcal{V}_F,\\Gamma_F)',
    '\\mathcal{O}_F=(\\mathcal{V}_F,\\Gamma_F)',
    'Darstellung einer funktionalen Organisation aus Zuständen und Relationen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1232',
    @section_id,
    'Funktionales Netzwerk',
    '\\mathcal{N}_F=(\\mathcal{V}_F,\\Gamma_F,W_F)',
    '\\mathcal{N}_F=(\\mathcal{V}_F,\\Gamma_F,W_F)',
    'Erweiterung der Organisationsstruktur um gewichtete funktionale Relationen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1233',
    @section_id,
    'Funktionale Zentralität',
    'Z_F(v_i)=f(d_i,w_i,\\kappa_i)',
    'Z_F(v_i)=f(d_i,w_i,\\kappa_i)',
    'Beschreibung der funktionalen Bedeutung eines Zustands innerhalb eines Netzwerks.',
    'model',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1234',
    @section_id,
    'Emergenz funktionaler Organisation',
    'E_F:\\mathcal{N}_F\\rightarrow\\mathcal{O}_F^{*}',
    'E_F:\\mathcal{N}_F\\rightarrow\\mathcal{O}_F^{*}',
    'Transformation eines funktionalen Netzwerks in eine höherwertige Organisationsform.',
    'operator',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),


(
    '3.1235',
    @section_id,
    'Zeitabhängiges funktionales Netzwerk',
    '\\mathcal{N}_F(t)=(\\mathcal{V}_F(t),\\Gamma_F(t),W_F(t))',
    '\\mathcal{N}_F(t)=(\\mathcal{V}_F(t),\\Gamma_F(t),W_F(t))',
    'Dynamische Darstellung eines funktionalen Netzwerks über die Zeit.',
    'model',
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
    '3.6.5',
    NOW()
);



COMMIT;


/* ============================================================
   Audit
   ============================================================ */

SELECT
    'Kapitel 3.6.5 Update erfolgreich'
    AS status,
    @revision_id AS revision_id,
    @section_id AS section_id;