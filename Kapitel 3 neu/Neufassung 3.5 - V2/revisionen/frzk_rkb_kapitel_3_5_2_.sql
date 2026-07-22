/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.2

   Funktionale Netzwerke

   Grundlage:
   - Kapitel 3.5.1 abgeschlossen
   - Gleichungen (3.1174)-(3.1178)
   - Neue Literatur [60]-[62]

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.2
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
    'RKB-K3.5.2-V1',
    NOW(),
    'section',
    '3.5.2',
    '1.0',
    'Funktionale Netzwerke und mathematische Beschreibung gekoppelter Organisationen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.2-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.2-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.2
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
    '3.5.2',
    'Funktionale Netzwerke',
    3,
    5.2000,
    'final',
    1,
    'Mathematische Beschreibung von Netzwerken funktionaler Organisationen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.2'
);


SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.2'
    LIMIT 1
);



/* ============================================================
   3. Literatur [60]-[62]
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
    60,
    'euler_graph_theory',
    'historical_work',
    'Solutio problematis ad geometriam situs pertinentis',
    1741,
    'Commentarii Academiae Scientiarum Imperialis Petropolitanae',
    '8',
    '128-140',
    'historical',
    3,
    'verified',
    '3.5.2',
    'Leonhard Euler: Solutio problematis ad geometriam situs pertinentis. Commentarii Academiae Scientiarum Imperialis Petropolitanae 8 (1741), 128-140.',
    'Euler (1741)',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=60
);



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
    61,
    'erdos_renyi_random_graphs',
    'journal_article',
    'On Random Graphs',
    1959,
    'Publicationes Mathematicae',
    '6',
    '290-297',
    'primary',
    4,
    'verified',
    '3.5.2',
    'Paul Erdős; Alfréd Rényi: On Random Graphs. Publicationes Mathematicae 6 (1959), 290-297.',
    'Erdős/Rényi (1959)',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=61
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
    62,
    'barabasi_network_science',
    'book',
    'Network Science',
    2016,
    'Cambridge University Press',
    'Cambridge',
    'textbook',
    4,
    'verified',
    '3.5.2',
    'Albert-László Barabási: Network Science. Cambridge: Cambridge University Press, 2016.',
    'Barabási (2016)',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=62
);



/* ============================================================
   4. Gleichungen 3.1174 - 3.1178
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
    '3.1174',
    @section_id,
    'Funktionales Netzwerk',
    '\mathcal{N}_F=(\mathcal{V}_F,\mathcal{E}_F)',
    '\mathcal{N}_F=(\mathcal{V}_F,\mathcal{E}_F)',
    'Netzwerkstruktur aus funktionalen Organisationseinheiten und Kopplungen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1 FROM equations
    WHERE equation_number='3.1174'
);



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
    '3.1175',
    @section_id,
    'Knotenmenge funktionaler Organisationen',
    '\mathcal{V}_F=\{\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n\}',
    '\mathcal{V}_F=\{\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n\}',
    'Menge rekonstruierter funktionaler Organisationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1 FROM equations
    WHERE equation_number='3.1175'
);



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
    '3.1176',
    @section_id,
    'Kantenmenge funktionaler Kopplungen',
    '\mathcal{E}_F=\{K_F(\mathcal{S}_i,\mathcal{S}_j)\}',
    '\mathcal{E}_F=\{K_F(\mathcal{S}_i,\mathcal{S}_j)\}',
    'Menge der funktionalen Kopplungsbeziehungen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1 FROM equations
    WHERE equation_number='3.1176'
);



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
    '3.1177',
    @section_id,
    'Funktionaler Netzwerkgrad',
    'k_F(\mathcal{S}_i)=|\{K_F(\mathcal{S}_i,\mathcal{S}_j)\}|',
    'k_F(\mathcal{S}_i)=|\{K_F(\mathcal{S}_i,\mathcal{S}_j)\}|',
    'Anzahl direkter funktionaler Kopplungen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1 FROM equations
    WHERE equation_number='3.1177'
);



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
    '3.1178',
    @section_id,
    'Funktionale Kopplungsqualität',
    'Q_F(\mathcal{S}_i)=\sum_j\Gamma_F(\mathcal{S}_i,\mathcal{S}_j)',
    'Q_F(\mathcal{S}_i)=\sum_j\Gamma_F(\mathcal{S}_i,\mathcal{S}_j)',
    'Gesamtheit gewichteter funktionaler Kopplungen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1 FROM equations
    WHERE equation_number='3.1178'
);



/* ============================================================
   5. Änderungsprotokoll
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
    '3.5.2',
    'Abschnitt 3.5.2 Funktionale Netzwerke abgeschlossen.',
    NULL,
    '3.5.2 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.2 Repository Update erfolgreich'
    AS status;