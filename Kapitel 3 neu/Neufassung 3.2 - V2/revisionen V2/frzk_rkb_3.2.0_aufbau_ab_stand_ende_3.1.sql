/* ============================================================
   FRZK-RKB – Neuaufbau Kapitel 3.2
   Abschnitt 3.2.0 – Einleitung

   VERBINDLICHER AUSGANGSSTAND:
   frzk_rkb_stand_ende_3.1(5).sql
   - Kapitel 3.1 abgeschlossen
   - letzte Literaturstelle: [70]
   - nächste Literaturstelle: [71]
   - Kapitel 3.2 noch nicht angelegt

   Dieses Skript verwendet ausschließlich Felder, die im
   Ausgangsdump tatsächlich vorhanden sind.
   MariaDB 10.4 / InnoDB
   ============================================================ */

START TRANSACTION;

/* ============================================================
   1. Ausgangsstand prüfen
   ============================================================ */

SET @parent_revision_id :=
(
    SELECT MAX(revision_id)
    FROM repository_revisions
);

SET @chapter3_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3'
    LIMIT 1
);

SET @source_halmos :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number = 6
    LIMIT 1
);

/* Der Neuaufbau darf nur auf dem Abschlussstand von 3.1 erfolgen. */
SELECT
    @parent_revision_id AS parent_revision_id,
    @chapter3_id AS chapter3_id,
    @source_halmos AS reused_source_6,
    (SELECT counter_value
       FROM repository_counters
      WHERE counter_key = 'last_completed_chapter') AS last_completed_chapter,
    (SELECT counter_value
       FROM repository_counters
      WHERE counter_key = 'next_citation_number') AS next_citation_number;

/* ============================================================
   2. Repository-Revision für 3.2.0 anlegen
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
SELECT
    'RKB-NEU-K3.2.0-V1',
    NOW(),
    'section',
    '3.2.0',
    '3.2.0-v1',
    'Neuaufbau von Abschnitt 3.2.0 auf Grundlage des Repository-Standes nach Kapitel 3.1; Wiederverwendung von Quelle [6] und Erstaufnahme der mathematischen Grundlagenliteratur [71] bis [79].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.0-V1'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.0-V1'
    LIMIT 1
);

/* ============================================================
   3. Kapitel 3.2 und Abschnitt 3.2.0 anlegen
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
    @chapter3_id,
    '3.2',
    'Mathematische Grundlagen',
    3,
    3.2000,
    'draft',
    0,
    'Kapitel 3.2 stellt die etablierten mathematischen Grundlagen bereit. Die eigenständige FRZK-Axiomatik beginnt erst in Kapitel 3.3.'
WHERE @chapter3_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2'
  );

SET @section32 :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
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
    @section32,
    '3.2.0',
    'Einleitung',
    3,
    3.2000,
    'final',
    0,
    'Einleitung in die mathematischen Grundlagen; Abgrenzung zwischen etablierter Mathematik und der ab Kapitel 3.3 entwickelten FRZK-Eigenleistung.'
WHERE @section32 IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.0'
  );

SET @section320 :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.0'
    LIMIT 1
);

/* ============================================================
   4. Autoren der neuen Literatur [71] bis [79]
   ============================================================ */

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Lang', 'Serge', 'Lang, Serge',
       'Autor der in Kapitel 3.2 verwendeten algebraischen Grundlagenliteratur.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Lang, Serge'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Rudin', 'Walter', 'Rudin, Walter',
       'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur Analysis.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Rudin, Walter'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Munkres', 'James R.', 'Munkres, James R.',
       'Autor der in Kapitel 3.2 verwendeten topologischen Grundlagenliteratur.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Munkres, James R.'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Strang', 'Gilbert', 'Strang, Gilbert',
       'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur linearen Algebra.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Strang, Gilbert'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Kreyszig', 'Erwin', 'Kreyszig, Erwin',
       'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur Funktionalanalysis.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Kreyszig, Erwin'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Reed', 'Michael', 'Reed, Michael',
       'Erstautor der operatorentheoretischen Referenz [76].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Reed, Michael'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Simon', 'Barry', 'Simon, Barry',
       'Zweitautor der operatorentheoretischen Referenz [76].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Simon, Barry'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Diestel', 'Reinhard', 'Diestel, Reinhard',
       'Autor der in Kapitel 3.2 verwendeten graphentheoretischen Grundlagenliteratur.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Diestel, Reinhard'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Mac Lane', 'Saunders', 'Mac Lane, Saunders',
       'Autor der in Kapitel 3.2 verwendeten kategorientheoretischen Grundlagenliteratur.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Mac Lane, Saunders'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT 'Kleene', 'Stephen Cole', 'Kleene, Stephen Cole',
       'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur mathematischen Logik.'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Kleene, Stephen Cole'
);

/* ============================================================
   5. Quellen [71] bis [79]
   Die Vollzitate entsprechen den in 3.2.0 eingeführten Werken.
   ============================================================ */

/* [71] */
INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original,
    year_edition,
    publisher,
    place,
    edition,
    isbn,
    language_code,
    priority,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    first_citation_note,
    full_citation_text,
    short_citation_text,
    notes,
    created_revision_id
)
SELECT
    71,
    'lang_algebra_2002',
    'book',
    'Algebra',
    1965,
    2002,
    'Springer',
    'New York',
    'Revised 3rd edition',
    '978-0-387-95385-4',
    'en',
    2,
    'textbook',
    7,
    'verified',
    '3.2.0',
    'Erstmalige Einführung als Referenz für algebraische Strukturen.',
    'Lang, Serge: Algebra. Revised 3rd edition. New York: Springer, 2002.',
    'Lang: Algebra, 2002.',
    'Grundlagenwerk zu Gruppen, Ringen, Körpern, Moduln und linearen Abbildungen.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 71 OR source_key = 'lang_algebra_2002'
);

/* [72] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    72, 'rudin_principles_mathematical_analysis_1976', 'book',
    'Principles of Mathematical Analysis',
    1953, 1976, 'McGraw-Hill', 'New York', '3rd edition',
    '978-0-07-054235-8',
    'en', 2, 'textbook', 7, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für die Grundlagen der Analysis.',
    'Rudin, Walter: Principles of Mathematical Analysis. 3rd edition. New York: McGraw-Hill, 1976.',
    'Rudin: Principles of Mathematical Analysis, 1976.',
    'Grundlagenwerk zu Konvergenz, Stetigkeit, Differenzierbarkeit und Integration.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 72
       OR source_key = 'rudin_principles_mathematical_analysis_1976'
);

/* [73] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    73, 'munkres_topology_2000', 'book', 'Topology',
    1975, 2000, 'Prentice Hall', 'Upper Saddle River, NJ', '2nd edition',
    '978-0-13-181629-9',
    'en', 2, 'textbook', 8, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für topologische Räume und Zusammenhangsstrukturen.',
    'Munkres, James R.: Topology. 2nd edition. Upper Saddle River, NJ: Prentice Hall, 2000.',
    'Munkres: Topology, 2000.',
    'Grundlagenwerk zu topologischen Räumen, Zusammenhang, Kompaktheit und Trennungsaxiomen.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 73 OR source_key = 'munkres_topology_2000'
);

/* [74] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    74, 'strang_introduction_linear_algebra_2016', 'book',
    'Introduction to Linear Algebra',
    1993, 2016, 'Wellesley-Cambridge Press', 'Wellesley, MA', '5th edition',
    '978-0-9802327-7-6',
    'en', 2, 'textbook', 9, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für Vektorräume, Matrizen und lineare Transformationen.',
    'Strang, Gilbert: Introduction to Linear Algebra. 5th edition. Wellesley, MA: Wellesley-Cambridge Press, 2016.',
    'Strang: Introduction to Linear Algebra, 2016.',
    'Grundlagenwerk zur linearen Algebra.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 74
       OR source_key = 'strang_introduction_linear_algebra_2016'
);

/* [75] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    75, 'kreyszig_introductory_functional_analysis_1978', 'book',
    'Introductory Functional Analysis with Applications',
    1978, 1978, 'John Wiley & Sons', 'New York', NULL,
    '978-0-471-50731-4',
    'en', 2, 'textbook', 9, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für normierte Räume, Hilberträume und Operatoren.',
    'Kreyszig, Erwin: Introductory Functional Analysis with Applications. New York: John Wiley & Sons, 1978.',
    'Kreyszig: Introductory Functional Analysis, 1978.',
    'Grundlagenwerk zur Funktionalanalysis.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 75
       OR source_key = 'kreyszig_introductory_functional_analysis_1978'
);

/* [76] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    76, 'reed_simon_methods_mathematical_physics_1_1980', 'book',
    'Methods of Modern Mathematical Physics',
    'Volume I: Functional Analysis',
    1972, 1980, 'Academic Press', 'San Diego', 'Revised and enlarged edition',
    '978-0-12-585050-6',
    'en', 2, 'textbook', 9, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für Operatoren, Spektren und funktionalanalytische Strukturen.',
    'Reed, Michael; Simon, Barry: Methods of Modern Mathematical Physics. Volume I: Functional Analysis. Revised and enlarged edition. San Diego: Academic Press, 1980.',
    'Reed/Simon: Methods of Modern Mathematical Physics I, 1980.',
    'Operatorentheoretische und funktionalanalytische Referenz.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 76
       OR source_key = 'reed_simon_methods_mathematical_physics_1_1980'
);

/* [77] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    77, 'diestel_graph_theory_2017', 'book', 'Graph Theory',
    1997, 2017, 'Springer', 'Berlin/Heidelberg', '5th edition',
    '978-3-662-53621-6',
    'en', 2, 'textbook', 8, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für diskrete relationale Strukturen.',
    'Diestel, Reinhard: Graph Theory. 5th edition. Berlin/Heidelberg: Springer, 2017.',
    'Diestel: Graph Theory, 2017.',
    'Grundlagenwerk zur Graphentheorie.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 77 OR source_key = 'diestel_graph_theory_2017'
);

/* [78] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    78, 'mac_lane_categories_working_mathematician_1998', 'book',
    'Categories for the Working Mathematician',
    1971, 1998, 'Springer', 'New York', '2nd edition',
    '978-0-387-98403-2',
    'en', 2, 'textbook', 7, 'verified', '3.2.0',
    'Erstmalige Einführung als Referenz für Kategorien, Morphismen und strukturelle Beziehungen.',
    'Mac Lane, Saunders: Categories for the Working Mathematician. 2nd edition. New York: Springer, 1998.',
    'Mac Lane: Categories for the Working Mathematician, 1998.',
    'Grundlagenwerk zur Kategorientheorie.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 78
       OR source_key = 'mac_lane_categories_working_mathematician_1998'
);

/* [79] */
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, publisher, place, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    79, 'kleene_mathematical_logic_1967', 'book', 'Mathematical Logic',
    1967, 1967, 'John Wiley & Sons', 'New York', NULL,
    NULL,
    'en', 2, 'textbook', 7, 'partially_verified', '3.2.0',
    'Erstmalige Einführung als Referenz für mathematische Logik und formale Systeme.',
    'Kleene, Stephen Cole: Mathematical Logic. New York: John Wiley & Sons, 1967.',
    'Kleene: Mathematical Logic, 1967.',
    'Grundlagenwerk zur mathematischen Logik; bibliografische Detailprüfung bleibt dokumentiert.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 79 OR source_key = 'kleene_mathematical_logic_1967'
);

/* ============================================================
   6. Autoren mit Quellen verknüpfen
   ============================================================ */

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Lang, Serge'
WHERE s.citation_number = 71
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Rudin, Walter'
WHERE s.citation_number = 72
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Munkres, James R.'
WHERE s.citation_number = 73
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Strang, Gilbert'
WHERE s.citation_number = 74
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Kreyszig, Erwin'
WHERE s.citation_number = 75
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Reed, Michael'
WHERE s.citation_number = 76
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 2, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Simon, Barry'
WHERE s.citation_number = 76
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Diestel, Reinhard'
WHERE s.citation_number = 77
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Mac Lane, Saunders'
WHERE s.citation_number = 78
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name = 'Kleene, Stephen Cole'
WHERE s.citation_number = 79
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors sa
      WHERE sa.source_id = s.source_id
        AND sa.author_id = a.author_id
        AND sa.role = 'author'
  );

/* ============================================================
   7. Literaturverwendungen in 3.2.0
   [6] wird wiederverwendet.
   [71] bis [79] werden erstmals genannt.
   ============================================================ */

/* Wiederverwendung [6] Halmos */
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
    @section320,
    'background',
    'Mengen, Elemente, Teilmengen, Relationen und Abbildungen als gemeinsame Grundsprache der modernen Mathematik.',
    'Abschnitt 3.2.0 – Absatz zur Mengenlehre',
    0,
    1,
    'Quelle [6] wurde bereits in Kapitel 3.1 eingeführt und wird hier wiederverwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 6
  AND @section320 IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section320
  );

/* Erstverwendungen [71] bis [79] */
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
    @section320,
    'first_citation',
    CASE s.citation_number
        WHEN 71 THEN 'Algebraische Strukturen: Gruppen, Ringe, Körper, Moduln und lineare Abbildungen.'
        WHEN 72 THEN 'Grundbegriffe der Analysis: Konvergenz, Stetigkeit, Differenzierbarkeit und Integration.'
        WHEN 73 THEN 'Topologische Räume, Zusammenhang, Kompaktheit und Trennungsaxiome.'
        WHEN 74 THEN 'Vektorräume, Matrizen, Basen, Dimensionen und lineare Transformationen.'
        WHEN 75 THEN 'Normierte Räume, Hilberträume, lineare Funktionale und Operatoren.'
        WHEN 76 THEN 'Operatoren, Spektren und funktionalanalytische Zustandsräume.'
        WHEN 77 THEN 'Graphen als diskrete relationale Strukturen.'
        WHEN 78 THEN 'Kategorien und Morphismen als abstrakte Beschreibung struktureller Beziehungen.'
        WHEN 79 THEN 'Mathematische Logik, Formalisierung und Berechenbarkeit.'
    END,
    CONCAT('Abschnitt 3.2.0 – Erstnennung [', s.citation_number, ']'),
    1,
    1,
    'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.',
    @revision_id
FROM sources s
WHERE s.citation_number BETWEEN 71 AND 79
  AND @section320 IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section320
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
SELECT
    @revision_id,
    @section320,
    'created',
    'section',
    '3.2.0',
    'Abschnitt 3.2.0 wurde auf Grundlage des Repository-Abschlussstandes von Kapitel 3.1 neu angelegt.',
    NULL,
    'Status final; Quelle [6] wiederverwendet; Quellen [71] bis [79] erstmals aufgenommen.'
WHERE @revision_id IS NOT NULL
  AND @section320 IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section320
        AND change_type = 'created'
        AND object_reference = '3.2.0'
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
    @revision_id,
    @section320,
    'source_reused',
    'source',
    '[6]',
    'Die bereits in Kapitel 3.1 eingeführte Quelle [6] wird in Abschnitt 3.2.0 erneut verwendet.',
    NULL,
    'Verknüpfung über source_usage mit is_first_mention = 0.'
WHERE @revision_id IS NOT NULL
  AND @section320 IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section320
        AND change_type = 'source_reused'
        AND object_reference = '[6]'
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
    @revision_id,
    @section320,
    'source_added',
    'source',
    '[71]–[79]',
    'Neun mathematische Grundlagenwerke wurden mit fortlaufenden Literaturstellen neu aufgenommen und Abschnitt 3.2.0 zugeordnet.',
    'Letzte Literaturstelle nach Kapitel 3.1: [70].',
    'Neue Literaturstellen: [71] bis [79].'
WHERE @revision_id IS NOT NULL
  AND @section320 IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section320
        AND change_type = 'source_added'
        AND object_reference = '[71]–[79]'
  );

/* ============================================================
   9. Repository-Zähler aktualisieren
   ============================================================ */

INSERT INTO repository_counters (counter_key, counter_value)
VALUES
    ('current_section', '3.2.1'),
    ('last_citation_number', '79'),
    ('last_completed_section', '3.2.0'),
    ('next_citation_number', '80')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value);

/* Kapitel 3.2 ist begonnen, aber noch nicht abgeschlossen.
   last_completed_chapter bleibt daher unverändert auf 3.1. */

/* ============================================================
   10. Abschlussprüfung
   ============================================================ */

SELECT
    ds.section_id,
    ds.parent_section_id,
    ds.section_code,
    ds.title,
    ds.status,
    ds.is_original_contribution
FROM dissertation_sections ds
WHERE ds.section_code IN ('3.2', '3.2.0')
ORDER BY ds.section_order, ds.section_id;

SELECT
    s.citation_number,
    s.source_key,
    s.full_citation_text,
    s.first_citation_section_code,
    s.created_revision_id
FROM sources s
WHERE s.citation_number = 6
   OR s.citation_number BETWEEN 71 AND 79
ORDER BY s.citation_number;

SELECT
    su.usage_id,
    s.citation_number,
    ds.section_code,
    su.usage_type,
    su.is_first_mention,
    su.citation_checked
FROM source_usage su
JOIN sources s
    ON s.source_id = su.source_id
JOIN dissertation_sections ds
    ON ds.section_id = su.section_id
WHERE ds.section_code = '3.2.0'
ORDER BY s.citation_number;

SELECT
    counter_key,
    counter_value
FROM repository_counters
WHERE counter_key IN
(
    'current_section',
    'last_citation_number',
    'last_completed_chapter',
    'last_completed_section',
    'next_citation_number'
)
ORDER BY counter_key;

COMMIT;
