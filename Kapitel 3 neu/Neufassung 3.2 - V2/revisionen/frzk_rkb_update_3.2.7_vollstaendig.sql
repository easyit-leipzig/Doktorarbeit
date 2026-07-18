-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Vollständiges Repository-Update nach Abschnitt 3.2.7
-- Abschnitt: Lineare Abbildungen, Matrizen und Operatoren
--
-- Aufbauend auf: RKB-NEU-K3.2.6-V1
-- Revision:       RKB-NEU-K3.2.7-V1
-- Quellen:        [88]-[90]
-- Definitionen:   3.2.45-3.2.51
-- Sätze:          3.2.10-3.2.13
-- Beweise:        3.2.10-P, 3.2.11-P
-- Gleichungen:    (3.266)-(3.292)
-- Nächste Quelle: [91]
--
-- Idempotent für das Schema aus frzk_rkb(3).sql.
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Ausgangsstand
-- ---------------------------------------------------------------------

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.6-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

SELECT CASE
    WHEN @parent_revision_id IS NULL
        THEN 'FEHLER: Revision RKB-NEU-K3.2.6-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach Abschnitt 3.2.6 vorhanden.'
END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Repository-Revision
-- ---------------------------------------------------------------------

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.2.7-V1',
    NOW(),
    'section',
    '3.2.7',
    '1.0',
    'Abschluss von Abschnitt 3.2.7: Quellen [88] bis [90], Definitionen 3.2.45 bis 3.2.51, Sätze 3.2.10 bis 3.2.13, zwei Beweise und Gleichungen (3.266) bis (3.292).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.7-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.7-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsteil 3.2.7
-- ---------------------------------------------------------------------

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_section_id,
    '3.2.7',
    'Lineare Abbildungen, Matrizen und Operatoren',
    3,
    3.2700,
    'final',
    0,
    'Der Abschnitt behandelt lineare Abbildungen, Kern, Bild, Rang, Nullität, Darstellungsmatrizen, lineare Operatoren, Komposition und Invertierbarkeit.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.7'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Lineare Abbildungen, Matrizen und Operatoren',
    chapter_no = 3,
    section_order = 3.2700,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt behandelt lineare Abbildungen, Kern, Bild, Rang, Nullität, Darstellungsmatrizen, lineare Operatoren, Komposition und Invertierbarkeit.'
WHERE section_code = '3.2.7';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.7'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren
-- ---------------------------------------------------------------------

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Sylvester', 'James Joseph', 'Sylvester, James Joseph',
    1814, 1897, 'Autor der Quelle [88].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Sylvester, James Joseph'
);

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Cayley', 'Arthur', 'Cayley, Arthur',
    1821, 1895, 'Autor der Quelle [89].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Cayley, Arthur'
);

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Halmos', 'Paul Richard', 'Halmos, Paul Richard',
    1916, 2006, 'Autor der Quelle [90].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Halmos, Paul Richard'
);

SET @author_sylvester := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Sylvester, James Joseph'
    LIMIT 1
);

SET @author_cayley := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Cayley, Arthur'
    LIMIT 1
);

SET @author_halmos := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Halmos, Paul Richard'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen [88]-[90]
-- ---------------------------------------------------------------------

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    88,
    'sylvester_additions_matrix_1850',
    'journal_article',
    'Additions to the Articles in the September Number of This Journal, ''On a New Class of Theorems,'' and on Pascal''s Theorem',
    NULL,
    1850,
    1850,
    'The London, Edinburgh, and Dublin Philosophical Magazine and Journal of Science',
    NULL,
    NULL,
    '37',
    NULL,
    '363-370',
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    8,
    'verified',
    '3.2.7',
    'Historische Erstnennung des Matrixbegriffs.',
    'Sylvester, James Joseph (1850): Additions to the Articles in the September Number of This Journal, ''On a New Class of Theorems,'' and on Pascal''s Theorem. In: The London, Edinburgh, and Dublin Philosophical Magazine and Journal of Science, Series 3, Band 37, S. 363-370.',
    'Sylvester (1850)',
    'Historische Primärquelle zur Entstehung des Matrixbegriffs.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 88
       OR source_key = 'sylvester_additions_matrix_1850'
);

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    89,
    'cayley_memoir_matrices_1858',
    'journal_article',
    'A Memoir on the Theory of Matrices',
    NULL,
    1858,
    1858,
    'Philosophical Transactions of the Royal Society of London',
    NULL,
    NULL,
    '148',
    NULL,
    '17-37',
    NULL,
    '10.1098/rstl.1858.0002',
    NULL,
    NULL,
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.2.7',
    'Historische Entwicklung einer eigenständigen Matrizentheorie.',
    'Cayley, Arthur (1858): A Memoir on the Theory of Matrices. In: Philosophical Transactions of the Royal Society of London, Band 148, S. 17-37.',
    'Cayley (1858)',
    'Historische Primärquelle zur Theorie der Matrizen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 89
       OR source_key = 'cayley_memoir_matrices_1858'
);

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    90,
    'halmos_finite_dimensional_vector_spaces_1942',
    'book',
    'Finite-Dimensional Vector Spaces',
    NULL,
    1942,
    1942,
    NULL,
    'Princeton University Press',
    'Princeton',
    NULL,
    NULL,
    NULL,
    'First edition',
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'reference',
    10,
    'verified',
    '3.2.7',
    'Systematische Grundlage für endlichdimensionale Vektorräume und lineare Transformationen.',
    'Halmos, Paul Richard (1942): Finite-Dimensional Vector Spaces. Princeton: Princeton University Press.',
    'Halmos (1942)',
    'Grundlagenquelle für lineare Abbildungen, Kern, Bild, Rang und Operatoren.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 90
       OR source_key = 'halmos_finite_dimensional_vector_spaces_1942'
);

SET @source_88 := (
    SELECT source_id FROM sources
    WHERE source_key = 'sylvester_additions_matrix_1850'
       OR citation_number = 88
    ORDER BY (source_key = 'sylvester_additions_matrix_1850') DESC
    LIMIT 1
);

SET @source_89 := (
    SELECT source_id FROM sources
    WHERE source_key = 'cayley_memoir_matrices_1858'
       OR citation_number = 89
    ORDER BY (source_key = 'cayley_memoir_matrices_1858') DESC
    LIMIT 1
);

SET @source_90 := (
    SELECT source_id FROM sources
    WHERE source_key = 'halmos_finite_dimensional_vector_spaces_1942'
       OR citation_number = 90
    ORDER BY (source_key = 'halmos_finite_dimensional_vector_spaces_1942') DESC
    LIMIT 1
);

INSERT IGNORE INTO source_authors
(source_id, author_id, author_order, role)
VALUES
(@source_88, @author_sylvester, 1, 'author'),
(@source_89, @author_cayley, 1, 'author'),
(@source_90, @author_halmos, 1, 'author');

-- ---------------------------------------------------------------------
-- 6. Quellenverwendung
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_88, @section_id, 'first_citation',
    'Historische Einführung des Begriffs Matrix.',
    'Abschnitt 3.2.7, historische Einleitung',
    1, 1, 'Erstnennung als Quelle [88].', @revision_id
WHERE @source_88 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_88
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_89, @section_id, 'first_citation',
    'Historische Entwicklung der Matrizentheorie und Matrixmultiplikation.',
    'Abschnitt 3.2.7, historische Einleitung',
    1, 1, 'Erstnennung als Quelle [89].', @revision_id
WHERE @source_89 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_89
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_90, @section_id, 'first_citation',
    'Systematische Behandlung linearer Transformationen in endlichdimensionalen Vektorräumen.',
    'Abschnitt 3.2.7, Definitionen und Sätze',
    1, 1, 'Erstnennung als Quelle [90].', @revision_id
WHERE @source_90 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_90
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.45-3.2.51
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
VALUES
(
    '3.2.45', @section_id, 'Lineare Abbildung',
    'Eine Abbildung T von V nach W heißt linear, wenn sie Vektoraddition und Skalarmultiplikation erhält.',
    'T:V\rightarrow W,\quad T(u+v)=T(u)+T(v),\quad T(\lambda v)=\lambda T(v)',
    'T:V\rightarrow W,\quad T(u+v)=T(u)+T(v),\quad T(\lambda v)=\lambda T(v)',
    'adapted', @source_90,
    'V und W sind Vektorräume über demselben Körper K.',
    'Additivität und Homogenität können zur Erhaltung beliebiger Linearkombinationen zusammengefasst werden.',
    'checked', @revision_id
),
(
    '3.2.46', @section_id, 'Kern einer linearen Abbildung',
    'Der Kern einer linearen Abbildung ist die Menge aller Vektoren des Ausgangsraums, die auf den Nullvektor des Zielraums abgebildet werden.',
    '\ker(T)=\left\{v\in V\mid T(v)=0_W\right\}',
    '\ker(T)=\left\{v\in V\mid T(v)=0_W\right\}',
    'adapted', @source_90,
    'T:V→W ist linear.',
    'Der Kern beschreibt die unter der Abbildung ausgelöschten Richtungen.',
    'checked', @revision_id
),
(
    '3.2.47', @section_id, 'Bild einer linearen Abbildung',
    'Das Bild einer linearen Abbildung enthält alle durch die Abbildung erreichbaren Vektoren des Zielraums.',
    '\operatorname{im}(T)=\left\{T(v)\mid v\in V\right\}',
    '\operatorname{im}(T)=\left\{T(v)\mid v\in V\right\}',
    'adapted', @source_90,
    'T:V→W ist linear.',
    'Das Bild ist ein Untervektorraum des Zielraums.',
    'checked', @revision_id
),
(
    '3.2.48', @section_id, 'Rang und Nullität',
    'Der Rang einer linearen Abbildung ist die Dimension ihres Bildes; ihre Nullität ist die Dimension ihres Kerns.',
    '\operatorname{rang}(T)=\dim(\operatorname{im}(T)),\quad\operatorname{null}(T)=\dim(\ker(T))',
    '\operatorname{rang}(T)=\dim(\operatorname{im}(T)),\quad\operatorname{null}(T)=\dim(\ker(T))',
    'adapted', @source_90,
    'Kern und Bild sind endlichdimensional.',
    'Rang und Nullität zerlegen im Dimensionssatz die Dimension des Ausgangsraums.',
    'checked', @revision_id
),
(
    '3.2.49', @section_id, 'Darstellungsmatrix einer linearen Abbildung',
    'Die Darstellungsmatrix einer linearen Abbildung enthält spaltenweise die Koordinaten der Bilder der Basisvektoren des Ausgangsraums bezüglich einer Basis des Zielraums.',
    '[T]_{C\leftarrow B}=(a_{ij})',
    '[T]_{C\leftarrow B}=(a_{ij})',
    'adapted', @source_90,
    'B ist eine Basis von V und C eine Basis von W.',
    'Die Matrix hängt von den gewählten Basen ab, die lineare Abbildung selbst nicht.',
    'checked', @revision_id
),
(
    '3.2.50', @section_id, 'Linearer Operator',
    'Ein linearer Operator ist eine lineare Abbildung eines Vektorraums in sich selbst.',
    'T:V\rightarrow V',
    'T:V\rightarrow V',
    'adapted', @source_90,
    'V ist ein Vektorraum.',
    'Ausgangsraum und Zielraum stimmen überein.',
    'checked', @revision_id
),
(
    '3.2.51', @section_id, 'Invertierbarer linearer Operator',
    'Ein linearer Operator heißt invertierbar, wenn ein linearer inverser Operator existiert, dessen beidseitige Komposition mit T die Identität ergibt.',
    'T^{-1}\circ T=T\circ T^{-1}=\operatorname{id}_V',
    'T^{-1}\circ T=T\circ T^{-1}=\operatorname{id}_V',
    'adapted', @source_90,
    'T:V→V ist linear.',
    'Invertierbarkeit ermöglicht die eindeutige Rekonstruktion des Ausgangsvektors.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    definition_text = VALUES(definition_text),
    formal_latex = VALUES(formal_latex),
    word_latex = VALUES(word_latex),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    assumptions = VALUES(assumptions),
    notes = VALUES(notes),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

-- ---------------------------------------------------------------------
-- 8. Sätze 3.2.10-3.2.13
-- ---------------------------------------------------------------------

INSERT INTO theorems
(
    theorem_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.2.10', @section_id, 'Erhaltung des Nullvektors',
    'Jede lineare Abbildung bildet den Nullvektor des Ausgangsraums auf den Nullvektor des Zielraums ab.',
    'T(0_V)=0_W',
    'T(0_V)=0_W',
    'literature', @source_90,
    'T:V→W ist linear.',
    'checked', @revision_id
),
(
    '3.2.11', @section_id, 'Kern und Bild als Untervektorräume',
    'Der Kern einer linearen Abbildung ist ein Untervektorraum des Ausgangsraums, und ihr Bild ist ein Untervektorraum des Zielraums.',
    '\ker(T)\leq V,\quad\operatorname{im}(T)\leq W',
    '\ker(T)\leq V,\quad\operatorname{im}(T)\leq W',
    'literature', @source_90,
    'T:V→W ist linear.',
    'checked', @revision_id
),
(
    '3.2.12', @section_id, 'Dimensionssatz',
    'Für eine lineare Abbildung mit endlichdimensionalem Ausgangsraum ist dessen Dimension gleich der Summe aus Rang und Nullität.',
    '\dim(V)=\operatorname{rang}(T)+\operatorname{null}(T)',
    '\dim(V)=\operatorname{rang}(T)+\operatorname{null}(T)',
    'literature', @source_90,
    'V ist endlichdimensional und T:V→W linear.',
    'checked', @revision_id
),
(
    '3.2.13', @section_id, 'Charakterisierung der Invertierbarkeit',
    'Für einen linearen Operator auf einem endlichdimensionalen Vektorraum sind Invertierbarkeit, trivialer Kern, Surjektivität und voller Rang äquivalent.',
    'T\text{ invertierbar}\Longleftrightarrow\ker(T)=\{0\}\Longleftrightarrow\operatorname{im}(T)=V\Longleftrightarrow\operatorname{rang}(T)=\dim(V)',
    'T\text{ invertierbar}\Longleftrightarrow\ker(T)=\{0\}\Longleftrightarrow\operatorname{im}(T)=V\Longleftrightarrow\operatorname{rang}(T)=\dim(V)',
    'literature', @source_90,
    'T:V→V ist linear und V endlichdimensional.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    statement_text = VALUES(statement_text),
    statement_latex = VALUES(statement_latex),
    word_latex = VALUES(word_latex),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    assumptions = VALUES(assumptions),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

SET @theorem_3210 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.10'
    LIMIT 1
);

SET @theorem_3211 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.11'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 9. Beweise
-- ---------------------------------------------------------------------

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.10-P',
    @section_id,
    @theorem_3210,
    'Beweis der Erhaltung des Nullvektors',
    'Für jeden Vektor v gilt 0_V=0_Kv. Aus der Homogenität folgt T(0_V)=T(0_Kv)=0_KT(v)=0_W.',
    'T(0_V)=T(0_Kv)=0_KT(v)=0_W',
    'direct',
    'adapted',
    @source_90,
    'checked',
    @revision_id
WHERE @theorem_3210 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.10-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.11-P',
    @section_id,
    @theorem_3211,
    'Beweis der Untervektorraumeigenschaft von Kern und Bild',
    'Der Nullvektor liegt im Kern. Jede Linearkombination zweier Kernelemente wird erneut auf den Nullvektor abgebildet. Für zwei Bildelemente x=T(u) und y=T(v) ist jede Linearkombination λx+μy gleich T(λu+μv) und liegt daher wieder im Bild.',
    'T(\lambda u+\mu v)=\lambda T(u)+\mu T(v)=0_W,\quad\lambda x+\mu y=T(\lambda u+\mu v)',
    'direct',
    'adapted',
    @source_90,
    'checked',
    @revision_id
WHERE @theorem_3211 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.11-P'
  );

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.266)-(3.292)
-- ---------------------------------------------------------------------

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
VALUES
('3.266',@section_id,'Abbildung zwischen Vektorräumen',
'T:V\rightarrow W','T:V\rightarrow W',
'Eine Abbildung vom Vektorraum V in den Vektorraum W.',
'definition','adapted',@source_90,NULL,
'V und W sind Vektorräume über demselben Körper.','checked',@revision_id),

('3.267',@section_id,'Additivität',
'T(u+v)=T(u)+T(v)','T(u+v)=T(u)+T(v)',
'Eine lineare Abbildung erhält die Vektoraddition.',
'axiom','adapted',@source_90,NULL,
'u,v∈V.','checked',@revision_id),

('3.268',@section_id,'Homogenität',
'T(\lambda v)=\lambda T(v)','T(\lambda v)=\lambda T(v)',
'Eine lineare Abbildung erhält die Skalarmultiplikation.',
'axiom','adapted',@source_90,NULL,
'λ∈K und v∈V.','checked',@revision_id),

('3.269',@section_id,'Erhaltung von Linearkombinationen',
'T(\lambda u+\mu v)=\lambda T(u)+\mu T(v)',
'T(\lambda u+\mu v)=\lambda T(u)+\mu T(v)',
'Zusammenfassung von Additivität und Homogenität.',
'derived_property','adapted',@source_90,
'Folgt durch Anwendung von Additivität und Homogenität.',
'λ,μ∈K und u,v∈V.','checked',@revision_id),

('3.270',@section_id,'Erhaltung des Nullvektors',
'T(0_V)=0_W','T(0_V)=0_W',
'Der Nullvektor des Ausgangsraums wird auf den Nullvektor des Zielraums abgebildet.',
'theorem','adapted',@source_90,NULL,
'T ist linear.','checked',@revision_id),

('3.271',@section_id,'Beweiskette zur Nullvektorerhaltung',
'T(0_V)=T(0_Kv)=0_KT(v)=0_W',
'T(0_V)=T(0_Kv)=0_KT(v)=0_W',
'Beweiskette unter Verwendung der Homogenität.',
'proof_step','adapted',@source_90,
'Es gilt 0_V=0_Kv.',
'v∈V.','checked',@revision_id),

('3.272',@section_id,'Kern einer linearen Abbildung',
'\ker(T)=\left\{v\in V\mid T(v)=0_W\right\}',
'\ker(T)=\left\{v\in V\mid T(v)=0_W\right\}',
'Menge aller Vektoren, die auf den Nullvektor abgebildet werden.',
'definition','adapted',@source_90,NULL,
'T:V→W ist linear.','checked',@revision_id),

('3.273',@section_id,'Bild einer linearen Abbildung',
'\operatorname{im}(T)=\left\{T(v)\mid v\in V\right\}',
'\operatorname{im}(T)=\left\{T(v)\mid v\in V\right\}',
'Menge aller durch T erreichbaren Zielvektoren.',
'definition','adapted',@source_90,NULL,
'T:V→W ist linear.','checked',@revision_id),

('3.274',@section_id,'Kern als Untervektorraum',
'\ker(T)\leq V','\ker(T)\leq V',
'Der Kern ist ein Untervektorraum des Ausgangsraums.',
'theorem','adapted',@source_90,NULL,
'T:V→W ist linear.','checked',@revision_id),

('3.275',@section_id,'Bild als Untervektorraum',
'\operatorname{im}(T)\leq W','\operatorname{im}(T)\leq W',
'Das Bild ist ein Untervektorraum des Zielraums.',
'theorem','adapted',@source_90,NULL,
'T:V→W ist linear.','checked',@revision_id),

('3.276',@section_id,'Abgeschlossenheit des Kerns',
'T(\lambda u+\mu v)=\lambda T(u)+\mu T(v)=0_W',
'T(\lambda u+\mu v)=\lambda T(u)+\mu T(v)=0_W',
'Jede Linearkombination zweier Kernelemente liegt erneut im Kern.',
'proof_step','adapted',@source_90,NULL,
'u,v∈ker(T).','checked',@revision_id),

('3.277',@section_id,'Abgeschlossenheit des Bildes',
'\lambda x+\mu y=\lambda T(u)+\mu T(v)=T(\lambda u+\mu v)',
'\lambda x+\mu y=\lambda T(u)+\mu T(v)=T(\lambda u+\mu v)',
'Jede Linearkombination zweier Bildelemente liegt erneut im Bild.',
'proof_step','adapted',@source_90,NULL,
'x=T(u), y=T(v).','checked',@revision_id),

('3.278',@section_id,'Rang',
'\operatorname{rang}(T)=\dim\bigl(\operatorname{im}(T)\bigr)',
'\operatorname{rang}(T)=\dim\bigl(\operatorname{im}(T)\bigr)',
'Der Rang ist die Dimension des Bildes.',
'definition','adapted',@source_90,NULL,
'Das Bild ist endlichdimensional.','checked',@revision_id),

('3.279',@section_id,'Nullität',
'\operatorname{null}(T)=\dim\bigl(\ker(T)\bigr)',
'\operatorname{null}(T)=\dim\bigl(\ker(T)\bigr)',
'Die Nullität ist die Dimension des Kerns.',
'definition','adapted',@source_90,NULL,
'Der Kern ist endlichdimensional.','checked',@revision_id),

('3.280',@section_id,'Dimensionssatz',
'\dim(V)=\operatorname{rang}(T)+\operatorname{null}(T)',
'\dim(V)=\operatorname{rang}(T)+\operatorname{null}(T)',
'Zerlegung der Dimension des Ausgangsraums in Rang und Nullität.',
'theorem','adapted',@source_90,NULL,
'V ist endlichdimensional.','checked',@revision_id),

('3.281',@section_id,'Bild eines Basisvektors',
'T(e_j)=\sum_{i=1}^{m}a_{ij}f_i',
'T(e_j)=\sum_{i=1}^{m}a_{ij}f_i',
'Darstellung des Bildes eines Basisvektors bezüglich der Zielbasis.',
'definition','adapted',@source_90,NULL,
'B=(e_1,…,e_n), C=(f_1,…,f_m).','checked',@revision_id),

('3.282',@section_id,'Darstellungsmatrix',
'[T]_{C\leftarrow B}=\begin{pmatrix}a_{11}&\cdots&a_{1n}\\\vdots&\ddots&\vdots\\a_{m1}&\cdots&a_{mn}\end{pmatrix}',
'[T]_{C\leftarrow B}=\begin{pmatrix}a_{11}&\cdots&a_{1n}\\\vdots&\ddots&\vdots\\a_{m1}&\cdots&a_{mn}\end{pmatrix}',
'Matrixdarstellung der linearen Abbildung bezüglich der Basen B und C.',
'definition','adapted',@source_90,NULL,
'Die Spalten enthalten die Koordinaten der Bilder der Basisvektoren.','checked',@revision_id),

('3.283',@section_id,'Koordinatenwirkung der Darstellungsmatrix',
'[T(v)]_C=[T]_{C\leftarrow B}[v]_B',
'[T(v)]_C=[T]_{C\leftarrow B}[v]_B',
'Die Wirkung der linearen Abbildung wird in Koordinaten durch Matrixmultiplikation dargestellt.',
'derived_property','adapted',@source_90,NULL,
'B und C sind fest gewählte Basen.','checked',@revision_id),

('3.284',@section_id,'Linearer Operator',
'T:V\rightarrow V','T:V\rightarrow V',
'Ein linearer Operator bildet einen Vektorraum in sich selbst ab.',
'definition','adapted',@source_90,NULL,
'V ist ein Vektorraum.','checked',@revision_id),

('3.285',@section_id,'Komposition linearer Abbildungen',
'S\circ T:V\rightarrow X','S\circ T:V\rightarrow X',
'Die Hintereinanderausführung zweier linearer Abbildungen ist wieder linear.',
'definition','adapted',@source_90,NULL,
'T:V→W und S:W→X.','checked',@revision_id),

('3.286',@section_id,'Matrix der Komposition',
'[S\circ T]=[S][T]','[S\circ T]=[S][T]',
'Die Matrix der Komposition ist das Produkt der Darstellungsmatrizen.',
'derived_property','adapted',@source_90,NULL,
'Kompatible Basen und Matrixdimensionen.','checked',@revision_id),

('3.287',@section_id,'Nichtkommutativität der Operatorreihenfolge',
'S\circ T\neq T\circ S','S\circ T\neq T\circ S',
'Die Reihenfolge zweier Transformationen ist im Allgemeinen relevant.',
'derived_property','adapted',@source_90,NULL,
'Beide Kompositionen sind definiert.','checked',@revision_id),

('3.288',@section_id,'Invertierbarer Operator',
'T^{-1}\circ T=T\circ T^{-1}=\operatorname{id}_V',
'T^{-1}\circ T=T\circ T^{-1}=\operatorname{id}_V',
'Definition eines beidseitig invertierbaren linearen Operators.',
'definition','adapted',@source_90,NULL,
'T und T^{-1} sind lineare Operatoren auf V.','checked',@revision_id),

('3.289',@section_id,'Invertierbarkeit',
'T\text{ ist invertierbar}','T\text{ ist invertierbar}',
'Erste Bedingung der Äquivalenzcharakterisierung.',
'theorem','adapted',@source_90,NULL,
'T:V→V, V endlichdimensional.','checked',@revision_id),

('3.290',@section_id,'Trivialer Kern',
'\ker(T)=\{0\}','\ker(T)=\{0\}',
'Zweite Bedingung der Äquivalenzcharakterisierung.',
'theorem','adapted',@source_90,NULL,
'T:V→V, V endlichdimensional.','checked',@revision_id),

('3.291',@section_id,'Volles Bild',
'\operatorname{im}(T)=V','\operatorname{im}(T)=V',
'Dritte Bedingung der Äquivalenzcharakterisierung.',
'theorem','adapted',@source_90,NULL,
'T:V→V, V endlichdimensional.','checked',@revision_id),

('3.292',@section_id,'Voller Rang',
'\operatorname{rang}(T)=\dim(V)',
'\operatorname{rang}(T)=\dim(V)',
'Vierte Bedingung der Äquivalenzcharakterisierung.',
'theorem','adapted',@source_90,NULL,
'T:V→V, V endlichdimensional.','checked',@revision_id)

ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    equation_latex = VALUES(equation_latex),
    word_latex = VALUES(word_latex),
    plain_description = VALUES(plain_description),
    equation_type = VALUES(equation_type),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    derivation = VALUES(derivation),
    assumptions = VALUES(assumptions),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

-- ---------------------------------------------------------------------
-- 11. Gleichungssymbole
-- ---------------------------------------------------------------------

SET @eq_3266 := (SELECT equation_id FROM equations WHERE equation_number='3.266' LIMIT 1);
SET @eq_3270 := (SELECT equation_id FROM equations WHERE equation_number='3.270' LIMIT 1);
SET @eq_3272 := (SELECT equation_id FROM equations WHERE equation_number='3.272' LIMIT 1);
SET @eq_3273 := (SELECT equation_id FROM equations WHERE equation_number='3.273' LIMIT 1);
SET @eq_3278 := (SELECT equation_id FROM equations WHERE equation_number='3.278' LIMIT 1);
SET @eq_3279 := (SELECT equation_id FROM equations WHERE equation_number='3.279' LIMIT 1);
SET @eq_3281 := (SELECT equation_id FROM equations WHERE equation_number='3.281' LIMIT 1);
SET @eq_3282 := (SELECT equation_id FROM equations WHERE equation_number='3.282' LIMIT 1);
SET @eq_3283 := (SELECT equation_id FROM equations WHERE equation_number='3.283' LIMIT 1);
SET @eq_3284 := (SELECT equation_id FROM equations WHERE equation_number='3.284' LIMIT 1);
SET @eq_3288 := (SELECT equation_id FROM equations WHERE equation_number='3.288' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
VALUES
(@eq_3266,'T','Lineare Abbildung','Abbildung, die Addition und Skalarmultiplikation erhält.',NULL,'V→W',1),
(@eq_3266,'V','Ausgangsraum','Vektorraum, aus dem die Argumente stammen.',NULL,'Vektorraum über K',2),
(@eq_3266,'W','Zielraum','Vektorraum, in den abgebildet wird.',NULL,'Vektorraum über K',3),

(@eq_3270,'0_V','Nullvektor des Ausgangsraums','Additives neutrales Element von V.',NULL,'Element von V',1),
(@eq_3270,'0_W','Nullvektor des Zielraums','Additives neutrales Element von W.',NULL,'Element von W',2),

(@eq_3272,'\ker(T)','Kern','Menge aller auf 0_W abgebildeten Vektoren.',NULL,'Untervektorraum von V',1),

(@eq_3273,'\operatorname{im}(T)','Bild','Menge aller erreichbaren Vektoren des Zielraums.',NULL,'Untervektorraum von W',1),

(@eq_3278,'\operatorname{rang}(T)','Rang','Dimension des Bildes der linearen Abbildung.',NULL,'Nichtnegative ganze Zahl',1),

(@eq_3279,'\operatorname{null}(T)','Nullität','Dimension des Kerns der linearen Abbildung.',NULL,'Nichtnegative ganze Zahl',1),

(@eq_3281,'e_j','Basisvektor des Ausgangsraums','j-ter Basisvektor der Basis B.',NULL,'Element von V',1),
(@eq_3281,'f_i','Basisvektor des Zielraums','i-ter Basisvektor der Basis C.',NULL,'Element von W',2),
(@eq_3281,'a_{ij}','Matrixkoeffizient','i-te Koordinate des Bildes von e_j.',NULL,'Element von K',3),

(@eq_3282,'[T]_{C\leftarrow B}','Darstellungsmatrix','Matrix von T bezüglich der Ausgangsbasis B und Zielbasis C.',NULL,'K^{m×n}',1),

(@eq_3283,'[v]_B','Koordinatenvektor','Koordinaten von v bezüglich der Basis B.',NULL,'K^n',1),
(@eq_3283,'[T(v)]_C','Bildkoordinaten','Koordinaten des Bildvektors bezüglich der Basis C.',NULL,'K^m',2),

(@eq_3284,'T','Linearer Operator','Lineare Selbstabbildung eines Vektorraums.',NULL,'V→V',1),

(@eq_3288,'T^{-1}','Inverser Operator','Beidseitige inverse Abbildung von T.',NULL,'V→V',1),
(@eq_3288,'\operatorname{id}_V','Identitätsoperator','Operator, der jeden Vektor unverändert lässt.',NULL,'V→V',2);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES ('next_citation_number', '91')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 91 THEN '91'
        ELSE counter_value
    END;

-- ---------------------------------------------------------------------
-- 13. Änderungsprotokoll
-- ---------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'created', 'section', '3.2.7',
    'Abschnitt 3.2.7 wurde vollständig im Repository registriert.',
    NULL, 'status=final'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.2.7'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources', '[88]-[90]',
    'Drei Quellen zur Geschichte der Matrizen und zu linearen Transformationen wurden aufgenommen.',
    'next_citation_number=88', 'next_citation_number=91'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_added'
      AND object_reference='[88]-[90]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definitions',
    '3.2.45-3.2.51',
    'Sieben Definitionen wurden registriert.',
    NULL, '7 Definitionen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='definition_added'
      AND object_reference='3.2.45-3.2.51'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'theorems',
    '3.2.10-3.2.13',
    'Vier Sätze wurden registriert.',
    NULL, '4 Sätze'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='statement_added'
      AND object_reference='3.2.10-3.2.13'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'proof_added', 'proofs',
    '3.2.10-P;3.2.11-P',
    'Zwei direkte Beweise wurden registriert.',
    NULL, '2 Beweise'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='proof_added'
      AND object_reference='3.2.10-P;3.2.11-P'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations',
    '(3.266)-(3.292)',
    'Siebenundzwanzig Gleichungen einschließlich Word-LaTeX wurden aufgenommen.',
    NULL, '27 Gleichungen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='(3.266)-(3.292)'
);

-- ---------------------------------------------------------------------
-- 14. Validierungen
-- ---------------------------------------------------------------------

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-SECTION',
    IF(COUNT(*)=1,'passed','failed'),
    '1', CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.7 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code='3.2.7'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-SOURCES',
    IF(COUNT(*)=3,'passed','failed'),
    '3', CAST(COUNT(*) AS CHAR),
    'Die Quellen [88] bis [90] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (88,89,90)
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-SOURCE-USAGE',
    IF(COUNT(*)=3,'passed','failed'),
    '3', CAST(COUNT(*) AS CHAR),
    'Die drei neuen Quellen müssen mit Abschnitt 3.2.7 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (88,89,90)
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-DEFINITIONS',
    IF(COUNT(*)=7,'passed','failed'),
    '7', CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.45 bis 3.2.51 müssen vollständig vorhanden sein.'
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.45','3.2.46','3.2.47','3.2.48',
       '3.2.49','3.2.50','3.2.51')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-THEOREMS',
    IF(COUNT(*)=4,'passed','failed'),
    '4', CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.10 bis 3.2.13 müssen vollständig vorhanden sein.'
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN ('3.2.10','3.2.11','3.2.12','3.2.13')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-PROOFS',
    IF(COUNT(*)=2,'passed','failed'),
    '2', CAST(COUNT(*) AS CHAR),
    'Die Beweise 3.2.10-P und 3.2.11-P müssen vorhanden sein.'
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN ('3.2.10-P','3.2.11-P')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-EQUATIONS',
    IF(COUNT(*)=27,'passed','failed'),
    '27', CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.266) bis (3.292) müssen vollständig vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 266 AND 292
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-WORD-LATEX',
    IF(COUNT(*)=27,'passed','failed'),
    '27', CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 266 AND 292
  AND word_latex IS NOT NULL
  AND TRIM(word_latex)<>''
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-PARENT-REVISION',
    IF(parent_revision_id=@parent_revision_id,'passed','failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision muss unmittelbar auf RKB-NEU-K3.2.6-V1 aufbauen.'
FROM repository_revisions
WHERE revision_id=@revision_id
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id, 'K3.2.7-NEXT-CITATION',
    IF(CAST(counter_value AS UNSIGNED)>=91,'passed','failed'),
    '>=91', counter_value,
    'Nach Quelle [90] muss die nächste freie Literaturziffer mindestens [91] sein.'
FROM repository_counters
WHERE counter_key='next_citation_number'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

COMMIT;

-- ---------------------------------------------------------------------
-- 15. Audit
-- ---------------------------------------------------------------------

SELECT revision_id, revision_code, scope_reference, version_label,
       parent_revision_id, revision_date
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.7-V1';

SELECT section_id, parent_section_id, section_code, title,
       status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.2.7';

SELECT citation_number, source_key, short_citation_text,
       verification_status
FROM sources
WHERE citation_number IN (88,89,90)
ORDER BY citation_number;

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED);

SELECT theorem_number, title, validation_status
FROM theorems
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=@section_id
ORDER BY proof_number;

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT validation_code, validation_status, expected_value,
       actual_value, validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
