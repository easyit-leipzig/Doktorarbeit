/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.5

   Informationsstruktur funktionaler Organisation

   Grundlage:
   - Kapitel 3.5.4 abgeschlossen
   - Gleichungen (3.1189)-(3.1192)
   - Neue Literatur [64]-[65]

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.5
   ============================================================ */

INSERT INTO repository_revisions
(
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    summary
)
SELECT
    'RKB-K3.5.5-V1',
    NOW(),
    'section',
    '3.5.5',
    '1.0',
    'Informationsstruktur funktionaler Organisation'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.5-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.5-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.5
   ============================================================ */

SET @chapter35_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5'
    LIMIT 1
);


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
    @chapter35_id,
    '3.5.5',
    'Informationsstruktur funktionaler Organisation',
    3,
    5.5000,
    'final',
    1,
    'Mathematische Beschreibung funktionaler Information und Informationskopplung'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.5'
);



SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.5'
    LIMIT 1
);



/* ============================================================
   3. Literatur [64]-[65]
   ============================================================ */


INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original,
    journal,
    volume,
    issue,
    pages,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    full_citation_text,
    short_citation_text,
    created_revision_id
)
SELECT
    64,
    'shannon_mathematical_theory_communication',
    'journal_article',
    'A Mathematical Theory of Communication',
    1948,
    'Bell System Technical Journal',
    '27',
    '3/4',
    '379-423; 623-656',
    'primary',
    4,
    'verified',
    '3.5.5',
    'Claude E. Shannon: A Mathematical Theory of Communication. Bell System Technical Journal 27(3), 1948, 379-423; 27(4), 1948, 623-656.',
    'Shannon (1948)',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=64
);



INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original,
    publisher,
    place,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    full_citation_text,
    short_citation_text,
    created_revision_id
)
SELECT
    65,
    'wiener_cybernetics',
    'book',
    'Cybernetics: Or Control and Communication in the Animal and the Machine',
    1948,
    'MIT Press',
    'Cambridge',
    'primary',
    4,
    'verified',
    '3.5.5',
    'Norbert Wiener: Cybernetics: Or Control and Communication in the Animal and the Machine. Cambridge: MIT Press, 1948.',
    'Wiener (1948)',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=65
);



/* ============================================================
   4. Gleichung 3.1189
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
    provenance
)
SELECT
    '3.1189',
    @section_id,
    'Funktionaler Informationszustand',
    'I_F(\mathcal{S})=(\Delta_F,\Gamma_F,T_F)',
    'I_F(\mathcal{S})=(\Delta_F,\Gamma_F,T_F)',
    'Beschreibung funktionaler Information durch Differenzen, Relationen und Transformationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1189'
);



/* ============================================================
   5. Gleichung 3.1190
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
    provenance
)
SELECT
    '3.1190',
    @section_id,
    'Funktionale Informationsabbildung',
    '\mathcal{I}_F:\mathcal{S}\rightarrow\mathbb{R}_{\geq0}',
    '\mathcal{I}_F:\mathcal{S}\rightarrow\mathbb{R}_{\geq0}',
    'Zuordnung eines Informationswertes zu einer funktionalen Organisation',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1190'
);



/* ============================================================
   6. Gleichung 3.1191
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
    provenance
)
SELECT
    '3.1191',
    @section_id,
    'Informationserhaltung unter Transformation',
    '\mathcal{I}_F(T_F(\mathcal{S}))\approx\mathcal{I}_F(\mathcal{S})',
    '\mathcal{I}_F(T_F(\mathcal{S}))\approx\mathcal{I}_F(\mathcal{S})',
    'Erhaltung funktionaler Informationsstruktur unter kohärenter Transformation',
    'lemma',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1191'
);



/* ============================================================
   7. Gleichung 3.1192
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
    provenance
)
SELECT
    '3.1192',
    @section_id,
    'Informationskopplung funktionaler Organisationen',
    'C_I:\mathcal{S}_i\times\mathcal{S}_j\rightarrow\mathbb{R}_{\geq0}',
    'C_I:\mathcal{S}_i\times\mathcal{S}_j\rightarrow\mathbb{R}_{\geq0}',
    'Beschreibung der Informationsbeziehung zwischen funktionalen Organisationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1192'
);



/* ============================================================
   8. Änderungsprotokoll
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
    new_value
)
VALUES
(
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.5.5',
    'Abschnitt 3.5.5 Informationsstruktur funktionaler Organisation abgeschlossen.',
    NULL,
    '3.5.5 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.5 Repository Update erfolgreich'
    AS status;