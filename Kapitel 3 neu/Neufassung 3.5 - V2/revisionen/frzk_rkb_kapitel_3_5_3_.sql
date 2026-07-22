/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.3

   Mehrskalige Organisation

   Grundlage:
   - Kapitel 3.5.2 abgeschlossen
   - Gleichungen (3.1179)-(3.1182)
   - Neue Literatur [63]

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.3
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
    'RKB-K3.5.3-V1',
    NOW(),
    'section',
    '3.5.3',
    '1.0',
    'Mehrskalige Organisation funktionaler Strukturen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.3-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.3-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.3
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
    '3.5.3',
    'Mehrskalige Organisation',
    3,
    5.3000,
    'final',
    1,
    'Rekursive Bildung funktionaler Organisationsebenen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.3'
);


SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.3'
    LIMIT 1
);



/* ============================================================
   3. Literatur [63]
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
    63,
    'simon_architecture_complexity',
    'journal_article',
    'The Architecture of Complexity',
    1962,
    'Proceedings of the American Philosophical Society',
    '106(6)',
    '467-482',
    'primary',
    4,
    'verified',
    '3.5.3',
    'Herbert A. Simon: The Architecture of Complexity. Proceedings of the American Philosophical Society 106(6) (1962), 467-482.',
    'Simon (1962)',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=63
);



/* ============================================================
   4. Gleichung 3.1179
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
    '3.1179',
    @section_id,
    'Funktionale Organisationsebene',
    '\mathcal{L}_m=\{\mathcal{S}_{m,1},\mathcal{S}_{m,2},\ldots,\mathcal{S}_{m,n}\}',
    '\mathcal{L}_m=\{\mathcal{S}_{m,1},\mathcal{S}_{m,2},\ldots,\mathcal{S}_{m,n}\}',
    'Menge funktionaler Strukturen einer Organisationsebene',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1179'
);



/* ============================================================
   5. Gleichung 3.1180
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
    '3.1180',
    @section_id,
    'Rekursive Bildung höherer Organisationsebenen',
    '\mathcal{L}_{m+1}=F(\mathcal{L}_m,K_F)',
    '\mathcal{L}_{m+1}=F(\mathcal{L}_m,K_F)',
    'Bildung einer höheren Organisationsebene aus bestehender Ebene und Kopplungen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1180'
);



/* ============================================================
   6. Gleichung 3.1181
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
    '3.1181',
    @section_id,
    'Übergang zwischen Organisationsebenen',
    '\Phi_F:\mathcal{L}_m\rightarrow\mathcal{L}_{m+1}',
    '\Phi_F:\mathcal{L}_m\rightarrow\mathcal{L}_{m+1}',
    'Abbildung zur Beschreibung der Ebenentransformation',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1181'
);



/* ============================================================
   7. Gleichung 3.1182
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
    '3.1182',
    @section_id,
    'Erhaltung untergeordneter Organisationsebenen',
    '\Phi_F(\mathcal{L}_m)\supseteq\mathcal{I}_m',
    '\Phi_F(\mathcal{L}_m)\supseteq\mathcal{I}_m',
    'Erhaltung strukturtragender Invarianten bei Ebenenübergängen',
    'lemma',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1182'
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
    '3.5.3',
    'Abschnitt 3.5.3 Mehrskalige Organisation abgeschlossen.',
    NULL,
    '3.5.3 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.3 Repository Update erfolgreich'
    AS status;