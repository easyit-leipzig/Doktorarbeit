-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Vollständiges Repository-Update nach Abschnitt 3.2.9
--
-- Abschnitt: Eigenwerte, Eigenvektoren und Invarianz funktionaler Zustände
-- Aufbauend auf: RKB-NEU-K3.2.8-V1
-- Revision:       RKB-NEU-K3.2.9-V1
-- Neue Quellen:   [93]-[95]
-- Definitionen:   3.2.60-3.2.67
-- Sätze:          3.2.16-3.2.20
-- Beweise:        3.2.16-P-3.2.20-P
-- Gleichungen:    (3.311)-(3.322)
-- Nächste Quelle: [96]
-- Nächste Gleichung: (3.323)
--
-- Schema: frzk_rkb(3).sql
-- Idempotentes Update.
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
    WHERE revision_code = 'RKB-NEU-K3.2.8-V1'
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
        THEN 'FEHLER: Revision RKB-NEU-K3.2.8-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach Abschnitt 3.2.8 vorhanden.'
END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Repository-Revision
-- ---------------------------------------------------------------------

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
    'RKB-NEU-K3.2.9-V1',
    NOW(),
    'section',
    '3.2.9',
    '1.0',
    'Abschluss von Abschnitt 3.2.9: Eigenwerte, Eigenvektoren, Eigenräume, Spektrum, Vielfachheiten, Diagonalisierbarkeit, Spur, Determinante und invariante Unterräume; Quellen [93] bis [95], Definitionen 3.2.60 bis 3.2.67, Sätze 3.2.16 bis 3.2.20 und Gleichungen (3.311) bis (3.322).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.9-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.9-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsteil 3.2.9
-- ---------------------------------------------------------------------

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
    @chapter_section_id,
    '3.2.9',
    'Eigenwerte, Eigenvektoren und Invarianz funktionaler Zustände',
    3,
    3.2900,
    'final',
    0,
    'Der Abschnitt führt Eigenwerte, Eigenvektoren, Eigenräume, Spektren, Vielfachheiten, Diagonalisierung sowie invariante Unterräume als Grundlage stabiler Transformationsrichtungen ein.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.9'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Eigenwerte, Eigenvektoren und Invarianz funktionaler Zustände',
    chapter_no = 3,
    section_order = 3.2900,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt führt Eigenwerte, Eigenvektoren, Eigenräume, Spektren, Vielfachheiten, Diagonalisierung sowie invariante Unterräume als Grundlage stabiler Transformationsrichtungen ein.'
WHERE section_code = '3.2.9';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.9'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren
-- ---------------------------------------------------------------------

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
SELECT
    'Lagrange',
    'Joseph-Louis',
    'Lagrange, Joseph-Louis',
    1736,
    1813,
    'Autor der Quelle [93].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Lagrange, Joseph-Louis'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
SELECT
    'Cauchy',
    'Augustin-Louis',
    'Cauchy, Augustin-Louis',
    1789,
    1857,
    'Autor der Quelle [94].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Cauchy, Augustin-Louis'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
SELECT
    'von Neumann',
    'John',
    'von Neumann, John',
    1903,
    1957,
    'Autor der Quelle [95].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'von Neumann, John'
);

SET @author_lagrange := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Lagrange, Joseph-Louis'
    LIMIT 1
);

SET @author_cauchy := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Cauchy, Augustin-Louis'
    LIMIT 1
);

SET @author_vonneumann := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'von Neumann, John'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen [93]-[95]
-- ---------------------------------------------------------------------

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
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
    93,
    'lagrange_mecanique_analytique_1788',
    'historical_work',
    'Mécanique analytique',
    NULL,
    1788,
    1788,
    NULL,
    'Veuve Desaint',
    'Paris',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'fr',
    1,
    'historical',
    8,
    'partially_verified',
    '3.2.9',
    'Historische Einordnung charakteristischer Gleichungen in der Mechanik.',
    'Lagrange, Joseph-Louis: Mécanique analytique. Paris, 1788.',
    'Lagrange [93]',
    'Historische Primärquelle; bibliografische Detailprüfung im Gesamtaudit vorgesehen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 93
       OR source_key = 'lagrange_mecanique_analytique_1788'
);

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
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
    94,
    'cauchy_oeuvres_serie2_band9_1829',
    'historical_work',
    'Œuvres complètes',
    'Série II, Band 9',
    1829,
    1829,
    NULL,
    NULL,
    'Paris',
    'Série II, 9',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'fr',
    1,
    'historical',
    8,
    'needs_review',
    '3.2.9',
    'Historische Entwicklung charakteristischer Gleichungen und linearer Transformationen.',
    'Cauchy, Augustin-Louis: Œuvres complètes. Série II, Band 9. Paris, 1829.',
    'Cauchy [94]',
    'Die im Dissertationstext verwendete bibliografische Angabe wird gespeichert; Jahres- und Bandzuordnung ist im Literaturgesamtaudit nochmals zu prüfen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 94
       OR source_key = 'cauchy_oeuvres_serie2_band9_1829'
);

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
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
    95,
    'von_neumann_mathematical_foundations_1932',
    'book',
    'Mathematical Foundations of Quantum Mechanics',
    NULL,
    1932,
    1932,
    NULL,
    'Princeton University Press',
    'Princeton',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    9,
    'partially_verified',
    '3.2.9',
    'Historische Einordnung der modernen Spektraltheorie.',
    'von Neumann, John: Mathematical Foundations of Quantum Mechanics. Princeton: Princeton University Press, 1932.',
    'von Neumann [95]',
    'Die im Text verwendete englische Ausgabe und Jahresangabe werden im Literaturgesamtaudit geprüft.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 95
       OR source_key = 'von_neumann_mathematical_foundations_1932'
);

SET @source_93 := (
    SELECT source_id FROM sources
    WHERE citation_number = 93
       OR source_key = 'lagrange_mecanique_analytique_1788'
    ORDER BY (source_key = 'lagrange_mecanique_analytique_1788') DESC
    LIMIT 1
);

SET @source_94 := (
    SELECT source_id FROM sources
    WHERE citation_number = 94
       OR source_key = 'cauchy_oeuvres_serie2_band9_1829'
    ORDER BY (source_key = 'cauchy_oeuvres_serie2_band9_1829') DESC
    LIMIT 1
);

SET @source_95 := (
    SELECT source_id FROM sources
    WHERE citation_number = 95
       OR source_key = 'von_neumann_mathematical_foundations_1932'
    ORDER BY (source_key = 'von_neumann_mathematical_foundations_1932') DESC
    LIMIT 1
);

INSERT IGNORE INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
VALUES
(@source_93, @author_lagrange, 1, 'author'),
(@source_94, @author_cauchy, 1, 'author'),
(@source_95, @author_vonneumann, 1, 'author');

-- ---------------------------------------------------------------------
-- 6. Quellenverwendung
-- ---------------------------------------------------------------------

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
    @source_93,
    @section_id,
    'first_citation',
    'Lagrange wird zur historischen Einordnung charakteristischer Gleichungen in mechanischen Schwingungssystemen herangezogen.',
    'Abschnitt 3.2.9, historische Einleitung',
    1,
    1,
    'Erstnennung als Quelle [93].',
    @revision_id
WHERE @source_93 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_93
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

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
    @source_94,
    @section_id,
    'first_citation',
    'Cauchy wird zur historischen Entwicklung der Eigenwerttheorie und charakteristischer Gleichungen verwendet.',
    'Abschnitt 3.2.9, historische Einleitung',
    1,
    0,
    'Erstnennung als Quelle [94]; bibliografische Detailprüfung offen.',
    @revision_id
WHERE @source_94 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_94
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

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
    @source_95,
    @section_id,
    'first_citation',
    'Von Neumann wird zur historischen Einordnung der Spektraltheorie und operatorentheoretischen Beschreibung verwendet.',
    'Abschnitt 3.2.9, historische Einleitung',
    1,
    0,
    'Erstnennung als Quelle [95]; Editionsprüfung offen.',
    @revision_id
WHERE @source_95 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_95
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.60-3.2.67
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number,
    section_id,
    title,
    definition_text,
    formal_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    notes,
    validation_status,
    created_revision_id
)
VALUES
(
    '3.2.60',
    @section_id,
    'Eigenvektor',
    'Ein von Null verschiedener Vektor v heißt Eigenvektor eines linearen Operators T, wenn ein Skalar λ existiert, sodass T(v)=λv gilt.',
    'v\neq0\land T(v)=\lambda v',
    'v\neq0\land T(v)=\lambda v',
    'adapted',
    @source_95,
    'T:V→V ist linear und v∈V.',
    'Die Richtung des Eigenvektors bleibt unter der Transformation erhalten.',
    'checked',
    @revision_id
),
(
    '3.2.61',
    @section_id,
    'Eigenwert',
    'Der Skalar λ in der Gleichung T(v)=λv heißt Eigenwert des Operators T zum Eigenvektor v.',
    'T(v)=\lambda v',
    'T(v)=\lambda v',
    'adapted',
    @source_95,
    'v ist ein Eigenvektor von T.',
    'Der Eigenwert beschreibt die Skalierung in der invarianten Richtung.',
    'checked',
    @revision_id
),
(
    '3.2.62',
    @section_id,
    'Eigenraum',
    'Der Eigenraum zum Eigenwert λ ist der Kern des Operators T-λI.',
    'E_\lambda=\ker(T-\lambda I)',
    'E_\lambda=\ker(T-\lambda I)',
    'adapted',
    @source_95,
    'λ ist ein Eigenwert von T.',
    'Der Eigenraum enthält den Nullvektor und sämtliche Eigenvektoren zum Eigenwert λ.',
    'checked',
    @revision_id
),
(
    '3.2.63',
    @section_id,
    'Spektrum',
    'Das Spektrum eines endlichdimensionalen Operators ist die Menge aller Skalare λ, für die T-λI nicht invertierbar ist beziehungsweise die charakteristische Gleichung erfüllt wird.',
    '\sigma(T)=\{\lambda\in K\mid\det(T-\lambda I)=0\}',
    '\sigma(T)=\{\lambda\in K\mid\det(T-\lambda I)=0\}',
    'adapted',
    @source_95,
    'V ist endlichdimensional.',
    'Die determinantengestützte Form gilt in endlicher Dimension.',
    'checked',
    @revision_id
),
(
    '3.2.64',
    @section_id,
    'Algebraische Vielfachheit',
    'Die algebraische Vielfachheit eines Eigenwertes ist seine Vielfachheit als Nullstelle des charakteristischen Polynoms.',
    'm_\lambda^{(a)}=\operatorname{ord}_{\lambda}\chi_T',
    'm_\lambda^{(a)}=\operatorname{ord}_{\lambda}\chi_T',
    'adapted',
    @source_95,
    'χ_T ist das charakteristische Polynom von T.',
    'Die algebraische Vielfachheit berücksichtigt die Nullstellenordnung.',
    'checked',
    @revision_id
),
(
    '3.2.65',
    @section_id,
    'Geometrische Vielfachheit',
    'Die geometrische Vielfachheit eines Eigenwertes ist die Dimension seines Eigenraums.',
    'm_\lambda^{(g)}=\dim(E_\lambda)',
    'm_\lambda^{(g)}=\dim(E_\lambda)',
    'adapted',
    @source_95,
    'λ ist ein Eigenwert von T.',
    'Sie ist mindestens eins und höchstens so groß wie die algebraische Vielfachheit.',
    'checked',
    @revision_id
),
(
    '3.2.66',
    @section_id,
    'Diagonalform',
    'Ein diagonalisierbarer Operator besitzt bezüglich einer Eigenvektorbasis eine Darstellung T=PDP^{-1}, wobei D die Eigenwerte auf der Hauptdiagonalen enthält.',
    'T=PDP^{-1}',
    'T=PDP^{-1}',
    'adapted',
    @source_95,
    'P ist invertierbar und seine Spalten bilden eine Eigenvektorbasis.',
    'D ist eine Diagonalmatrix.',
    'checked',
    @revision_id
),
(
    '3.2.67',
    @section_id,
    'Invarianter Unterraum',
    'Ein Unterraum U von V heißt unter T invariant, wenn T(U) eine Teilmenge von U ist.',
    'T(U)\subseteq U',
    'T(U)\subseteq U',
    'adapted',
    @source_95,
    'U⊆V ist ein Untervektorraum und T:V→V ist linear.',
    'Ein Eigenraum ist ein spezieller invarianter Unterraum.',
    'checked',
    @revision_id
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
-- 8. Sätze 3.2.16-3.2.20
-- ---------------------------------------------------------------------

INSERT INTO theorems
(
    theorem_number,
    section_id,
    title,
    statement_text,
    statement_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    validation_status,
    created_revision_id
)
VALUES
(
    '3.2.16',
    @section_id,
    'Charakteristische Gleichung',
    'Ein Skalar λ ist genau dann Eigenwert eines endlichdimensionalen Operators T, wenn det(T-λI)=0 gilt.',
    '\lambda\in\sigma(T)\Longleftrightarrow\det(T-\lambda I)=0',
    '\lambda\in\sigma(T)\Longleftrightarrow\det(T-\lambda I)=0',
    'adapted',
    @source_95,
    'V ist endlichdimensional.',
    'checked',
    @revision_id
),
(
    '3.2.17',
    @section_id,
    'Lineare Unabhängigkeit von Eigenvektoren',
    'Eigenvektoren zu paarweise verschiedenen Eigenwerten sind linear unabhängig.',
    '\lambda_i\neq\lambda_j\Rightarrow\{v_1,\ldots,v_k\}\text{ linear unabhängig}',
    '\lambda_i\neq\lambda_j\Rightarrow\{v_1,\ldots,v_k\}\text{ linear unabhängig}',
    'adapted',
    @source_95,
    'T(v_i)=λ_i v_i und v_i≠0.',
    'checked',
    @revision_id
),
(
    '3.2.18',
    @section_id,
    'Charakterisierung der Diagonalisierbarkeit',
    'Ein Operator auf einem n-dimensionalen Vektorraum ist genau dann diagonalisierbar, wenn eine Basis aus Eigenvektoren existiert; äquivalent ist die Summe der Dimensionen der Eigenräume gleich n.',
    'T\text{ diagonalisierbar}\Longleftrightarrow\sum_{\lambda\in\sigma(T)}\dim(E_\lambda)=\dim(V)',
    'T\text{ diagonalisierbar}\Longleftrightarrow\sum_{\lambda\in\sigma(T)}\dim(E_\lambda)=\dim(V)',
    'adapted',
    @source_95,
    'V ist endlichdimensional und das charakteristische Polynom zerfällt über K.',
    'checked',
    @revision_id
),
(
    '3.2.19',
    @section_id,
    'Spur als Summe der Eigenwerte',
    'Die Spur eines endlichdimensionalen Operators ist gleich der Summe seiner mit algebraischer Vielfachheit gezählten Eigenwerte.',
    '\operatorname{tr}(T)=\sum_i\lambda_i',
    '\operatorname{tr}(T)=\sum_i\lambda_i',
    'adapted',
    @source_95,
    'Das charakteristische Polynom zerfällt über K.',
    'checked',
    @revision_id
),
(
    '3.2.20',
    @section_id,
    'Determinante als Produkt der Eigenwerte',
    'Die Determinante eines endlichdimensionalen Operators ist gleich dem Produkt seiner mit algebraischer Vielfachheit gezählten Eigenwerte.',
    '\det(T)=\prod_i\lambda_i',
    '\det(T)=\prod_i\lambda_i',
    'adapted',
    @source_95,
    'Das charakteristische Polynom zerfällt über K.',
    'checked',
    @revision_id
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

SET @theorem_3216 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.16' LIMIT 1
);
SET @theorem_3217 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.17' LIMIT 1
);
SET @theorem_3218 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.18' LIMIT 1
);
SET @theorem_3219 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.19' LIMIT 1
);
SET @theorem_3220 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.20' LIMIT 1
);

-- ---------------------------------------------------------------------
-- 9. Beweise
-- ---------------------------------------------------------------------

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.16-P', @section_id, @theorem_3216, NULL, NULL,
    'Beweis der charakteristischen Gleichung',
    'λ ist genau dann Eigenwert, wenn ein Vektor v≠0 mit (T-λI)v=0 existiert. Dies ist genau dann der Fall, wenn der Kern von T-λI nichttrivial ist. In endlicher Dimension ist dies äquivalent zur Nichtinvertierbarkeit von T-λI und damit zu det(T-λI)=0.',
    '\lambda\in\sigma(T)\Longleftrightarrow\ker(T-\lambda I)\neq\{0\}\Longleftrightarrow T-\lambda I\text{ nicht invertierbar}\Longleftrightarrow\det(T-\lambda I)=0',
    'equivalence', 'adapted', @source_95, 'checked', @revision_id
WHERE @theorem_3216 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.16-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.17-P', @section_id, @theorem_3217, NULL, NULL,
    'Beweis der linearen Unabhängigkeit',
    'Der Beweis erfolgt durch Induktion über die Anzahl der Eigenvektoren. Wird eine minimale lineare Relation mit T transformiert und anschließend das λ_k-fache der ursprünglichen Relation subtrahiert, entsteht eine Relation zwischen k-1 Eigenvektoren mit Faktoren λ_i-λ_k. Wegen der Verschiedenheit der Eigenwerte und der Induktionsannahme verschwinden alle Koeffizienten.',
    '\sum_{i=1}^{k}a_iv_i=0\Rightarrow\sum_{i=1}^{k-1}a_i(\lambda_i-\lambda_k)v_i=0\Rightarrow a_1=\cdots=a_k=0',
    'induction', 'adapted', @source_95, 'checked', @revision_id
WHERE @theorem_3217 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.17-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.18-P', @section_id, @theorem_3218, NULL, NULL,
    'Beweis der Charakterisierung der Diagonalisierbarkeit',
    'Besitzt T eine Eigenvektorbasis, so ist seine Darstellung bezüglich dieser Basis diagonal. Ist T umgekehrt diagonal darstellbar, so bestehen die Basisvektoren der zugehörigen Basis aus Eigenvektoren. Die Dimension der direkten Summe der Eigenräume entspricht dann der Zahl der Basisvektoren und damit dim(V).',
    'T=PDP^{-1}\Longleftrightarrow V=\bigoplus_{\lambda\in\sigma(T)}E_\lambda',
    'equivalence', 'adapted', @source_95, 'checked', @revision_id
WHERE @theorem_3218 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.18-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.19-P', @section_id, @theorem_3219, NULL, NULL,
    'Beweis der Spurformel',
    'Über einem Zerfällungskörper ist die Matrixdarstellung von T zu einer oberen Dreiecksmatrix ähnlich, deren Diagonaleinträge die Eigenwerte mit algebraischer Vielfachheit sind. Die Spur ist unter Ähnlichkeit invariant und entspricht der Summe der Diagonaleinträge.',
    '\operatorname{tr}(T)=\operatorname{tr}(P^{-1}TP)=\sum_i\lambda_i',
    'direct', 'adapted', @source_95, 'checked', @revision_id
WHERE @theorem_3219 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.19-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.20-P', @section_id, @theorem_3220, NULL, NULL,
    'Beweis der Determinantenformel',
    'Über einem Zerfällungskörper ist T zu einer oberen Dreiecksmatrix mit den Eigenwerten auf der Diagonalen ähnlich. Die Determinante ist unter Ähnlichkeit invariant und für Dreiecksmatrizen gleich dem Produkt der Diagonaleinträge.',
    '\det(T)=\det(P^{-1}TP)=\prod_i\lambda_i',
    'direct', 'adapted', @source_95, 'checked', @revision_id
WHERE @theorem_3220 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.20-P'
  );

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.311)-(3.322)
-- ---------------------------------------------------------------------

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
VALUES
(
    '3.311', @section_id, 'Linearer Operator auf V',
    'T:V\rightarrow V',
    'T:V\rightarrow V',
    'Ein linearer Operator bildet den Vektorraum V in sich selbst ab.',
    'definition', 'adapted', @source_95, NULL,
    'V ist ein Vektorraum.', 'checked', @revision_id
),
(
    '3.312', @section_id, 'Eigenwertgleichung',
    'T(v)=\lambda v',
    'T(v)=\lambda v',
    'Ein Eigenvektor behält unter T seine Richtung und wird mit λ skaliert.',
    'definition', 'adapted', @source_95, NULL,
    'v≠0.', 'checked', @revision_id
),
(
    '3.313', @section_id, 'Eigenraum',
    'E_\lambda=\ker(T-\lambda I)',
    'E_\lambda=\ker(T-\lambda I)',
    'Der Eigenraum ist der Kern des verschobenen Operators T-λI.',
    'definition', 'adapted', @source_95, NULL,
    'λ ist ein Eigenwert.', 'checked', @revision_id
),
(
    '3.314', @section_id, 'Charakteristische Gleichung',
    '\det(T-\lambda I)=0',
    '\det(T-\lambda I)=0',
    'Die Eigenwerte sind Nullstellen des charakteristischen Polynoms.',
    'theorem', 'adapted', @source_95, NULL,
    'V ist endlichdimensional.', 'checked', @revision_id
),
(
    '3.315', @section_id, 'Spektrum',
    '\sigma(T)=\{\lambda\in K\mid\det(T-\lambda I)=0\}',
    '\sigma(T)=\{\lambda\in K\mid\det(T-\lambda I)=0\}',
    'Das Spektrum enthält sämtliche Eigenwerte des Operators.',
    'definition', 'adapted', @source_95, NULL,
    'V ist endlichdimensional.', 'checked', @revision_id
),
(
    '3.316', @section_id, 'Geometrische Vielfachheit',
    '\dim(E_\lambda)',
    '\dim(E_\lambda)',
    'Die Dimension des Eigenraums ist die geometrische Vielfachheit.',
    'definition', 'adapted', @source_95, NULL,
    'λ ist ein Eigenwert.', 'checked', @revision_id
),
(
    '3.317', @section_id, 'Schranken der geometrischen Vielfachheit',
    '1\leq\dim(E_\lambda)\leq m_\lambda',
    '1\leq\dim(E_\lambda)\leq m_\lambda',
    'Die geometrische Vielfachheit liegt zwischen eins und der algebraischen Vielfachheit.',
    'theorem', 'adapted', @source_95, NULL,
    'm_λ bezeichnet die algebraische Vielfachheit.', 'checked', @revision_id
),
(
    '3.318', @section_id, 'Ähnlichkeit zur Diagonalform',
    'T=PDP^{-1}',
    'T=PDP^{-1}',
    'Ein diagonalisierbarer Operator ist zu einer Diagonalmatrix ähnlich.',
    'theorem', 'adapted', @source_95, NULL,
    'P ist invertierbar.', 'checked', @revision_id
),
(
    '3.319', @section_id, 'Diagonalmatrix der Eigenwerte',
    'D=\operatorname{diag}(\lambda_1,\ldots,\lambda_n)',
    'D=\operatorname{diag}(\lambda_1,\ldots,\lambda_n)',
    'Die Diagonalmatrix enthält die Eigenwerte auf der Hauptdiagonalen.',
    'definition', 'adapted', @source_95, NULL,
    'T besitzt eine Eigenvektorbasis.', 'checked', @revision_id
),
(
    '3.320', @section_id, 'Spurformel',
    '\operatorname{tr}(T)=\sum_i\lambda_i',
    '\operatorname{tr}(T)=\sum_i\lambda_i',
    'Die Spur entspricht der Summe der Eigenwerte mit algebraischer Vielfachheit.',
    'theorem', 'adapted', @source_95, NULL,
    'Das charakteristische Polynom zerfällt.', 'checked', @revision_id
),
(
    '3.321', @section_id, 'Determinantenformel',
    '\det(T)=\prod_i\lambda_i',
    '\det(T)=\prod_i\lambda_i',
    'Die Determinante entspricht dem Produkt der Eigenwerte mit algebraischer Vielfachheit.',
    'theorem', 'adapted', @source_95, NULL,
    'Das charakteristische Polynom zerfällt.', 'checked', @revision_id
),
(
    '3.322', @section_id, 'Invarianter Unterraum',
    'T(U)\subseteq U',
    'T(U)\subseteq U',
    'Der Operator führt jeden Vektor des Unterraums U wieder in U.',
    'definition', 'adapted', @source_95, NULL,
    'U ist ein Untervektorraum von V.', 'checked', @revision_id
)
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

SET @eq_3311 := (SELECT equation_id FROM equations WHERE equation_number='3.311' LIMIT 1);
SET @eq_3312 := (SELECT equation_id FROM equations WHERE equation_number='3.312' LIMIT 1);
SET @eq_3313 := (SELECT equation_id FROM equations WHERE equation_number='3.313' LIMIT 1);
SET @eq_3314 := (SELECT equation_id FROM equations WHERE equation_number='3.314' LIMIT 1);
SET @eq_3315 := (SELECT equation_id FROM equations WHERE equation_number='3.315' LIMIT 1);
SET @eq_3316 := (SELECT equation_id FROM equations WHERE equation_number='3.316' LIMIT 1);
SET @eq_3318 := (SELECT equation_id FROM equations WHERE equation_number='3.318' LIMIT 1);
SET @eq_3319 := (SELECT equation_id FROM equations WHERE equation_number='3.319' LIMIT 1);
SET @eq_3320 := (SELECT equation_id FROM equations WHERE equation_number='3.320' LIMIT 1);
SET @eq_3322 := (SELECT equation_id FROM equations WHERE equation_number='3.322' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(
    equation_id,
    symbol_latex,
    symbol_name,
    definition_text,
    symbol_order
)
VALUES
(@eq_3311,'T','Linearer Operator','Lineare Selbstabbildung des Vektorraums V.',1),
(@eq_3311,'V','Vektorraum','Definitions- und Zielraum des Operators T.',2),

(@eq_3312,'v','Eigenvektor','Von Null verschiedener Vektor mit invarianter Richtung unter T.',1),
(@eq_3312,'\lambda','Eigenwert','Skalarer Faktor der Transformation des Eigenvektors.',2),

(@eq_3313,'E_\lambda','Eigenraum','Kern des Operators T-λI.',1),
(@eq_3313,'I','Identitätsoperator','Operator mit I(v)=v.',2),

(@eq_3314,'\det','Determinante','Determinantenfunktion einer Matrixdarstellung des Operators.',1),

(@eq_3315,'\sigma(T)','Spektrum','Menge der Eigenwerte des Operators T.',1),
(@eq_3315,'K','Skalarkörper','Grundkörper des Vektorraums.',2),

(@eq_3316,'\dim(E_\lambda)','Geometrische Vielfachheit','Dimension des Eigenraums zum Eigenwert λ.',1),

(@eq_3318,'P','Basiswechselmatrix','Invertierbare Matrix aus Eigenvektoren.',1),
(@eq_3318,'D','Diagonalmatrix','Diagonalform des Operators.',2),

(@eq_3319,'\lambda_i','i-ter Eigenwert','Eigenwert an der i-ten Diagonalposition.',1),

(@eq_3320,'\operatorname{tr}(T)','Spur','Summe der Diagonaleinträge beziehungsweise Eigenwerte.',1),

(@eq_3322,'U','Invarianter Unterraum','Unterraum, der unter T abgeschlossen bleibt.',1);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_citation_number', '96')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 96 THEN '96'
        ELSE counter_value
    END;

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_equation_number', '3.323')
ON DUPLICATE KEY UPDATE
    counter_value = '3.323';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_completed_section', '3.2.9')
ON DUPLICATE KEY UPDATE
    counter_value = '3.2.9';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_repository_revision', 'RKB-NEU-K3.2.9-V1')
ON DUPLICATE KEY UPDATE
    counter_value = 'RKB-NEU-K3.2.9-V1';

-- ---------------------------------------------------------------------
-- 13. Änderungsprotokoll
-- ---------------------------------------------------------------------

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
    @section_id,
    'rewritten',
    'section',
    '3.2.9',
    'Abschnitt 3.2.9 wurde als mathematische Grundlage invarianter Transformationsrichtungen registriert.',
    NULL,
    'Eigenwerte, Eigenvektoren und Invarianz funktionaler Zustände'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND change_type='rewritten'
        AND object_reference='3.2.9'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources', '[93]-[95]',
    'Drei Quellen zur historischen Entwicklung der Eigenwert- und Spektraltheorie wurden aufgenommen.',
    'next_citation_number=93', 'next_citation_number=96'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND change_type='source_added'
        AND object_reference='[93]-[95]'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definitions', '3.2.60-3.2.67',
    'Acht Definitionen wurden registriert.', NULL, '8 Definitionen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND change_type='definition_added'
        AND object_reference='3.2.60-3.2.67'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'theorems', '3.2.16-3.2.20',
    'Fünf Sätze zu charakteristischer Gleichung, Eigenvektorunabhängigkeit, Diagonalisierung, Spur und Determinante wurden registriert.',
    NULL, '5 Sätze'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND change_type='statement_added'
        AND object_reference='3.2.16-3.2.20'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'proof_added', 'proofs', '3.2.16-P-3.2.20-P',
    'Fünf Beweise wurden registriert.', NULL, '5 Beweise'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND change_type='proof_added'
        AND object_reference='3.2.16-P-3.2.20-P'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations', '(3.311)-(3.322)',
    'Zwölf Gleichungen einschließlich Word-LaTeX wurden aufgenommen.',
    NULL, '12 Gleichungen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND change_type='equation_added'
        AND object_reference='(3.311)-(3.322)'
  );

-- ---------------------------------------------------------------------
-- 14. Validierungen
-- ---------------------------------------------------------------------

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.2.9_SECTION',
    IF(COUNT(*)=1,'passed','failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.9 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code='3.2.9'
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
    @revision_id,
    'K3.2.9_NEW_SOURCES',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die neuen Quellen [93] bis [95] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (93,94,95)
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
    @revision_id,
    'K3.2.9_SOURCE_USAGE',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [93] bis [95] müssen mit Abschnitt 3.2.9 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (93,94,95)
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
    @revision_id,
    'K3.2.9_DEFINITIONS',
    IF(COUNT(*)=8,'passed','failed'),
    '8',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.60 bis 3.2.67 müssen vollständig vorhanden sein.'
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.60','3.2.61','3.2.62','3.2.63',
       '3.2.64','3.2.65','3.2.66','3.2.67')
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
    @revision_id,
    'K3.2.9_THEOREMS',
    IF(COUNT(*)=5,'passed','failed'),
    '5',
    CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.16 bis 3.2.20 müssen vollständig vorhanden sein.'
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN
      ('3.2.16','3.2.17','3.2.18','3.2.19','3.2.20')
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
    @revision_id,
    'K3.2.9_PROOFS',
    IF(COUNT(*)=5,'passed','failed'),
    '5',
    CAST(COUNT(*) AS CHAR),
    'Die Beweise 3.2.16-P bis 3.2.20-P müssen vorhanden sein.'
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN
      ('3.2.16-P','3.2.17-P','3.2.18-P','3.2.19-P','3.2.20-P')
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
    @revision_id,
    'K3.2.9_EQUATIONS',
    IF(COUNT(*)=12,'passed','failed'),
    '12',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.311) bis (3.322) müssen vollständig vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 311 AND 322
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
    @revision_id,
    'K3.2.9_WORD_LATEX',
    IF(COUNT(*)=12,'passed','failed'),
    '12',
    CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 311 AND 322
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
    @revision_id,
    'K3.2.9_PARENT_REVISION',
    IF(parent_revision_id=@parent_revision_id,'passed','failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision muss unmittelbar auf RKB-NEU-K3.2.8-V1 aufbauen.'
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
    @revision_id,
    'K3.2.9_NEXT_CITATION',
    IF(CAST(counter_value AS UNSIGNED)>=96,'passed','failed'),
    '>=96',
    counter_value,
    'Nach Quelle [95] muss die nächste freie Literaturziffer mindestens [96] sein.'
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

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    parent_revision_id,
    revision_date
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.9-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code='3.2.9';

SELECT
    citation_number,
    source_key,
    short_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (93,94,95)
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    validation_status
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.60','3.2.61','3.2.62','3.2.63',
       '3.2.64','3.2.65','3.2.66','3.2.67')
ORDER BY CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED);

SELECT
    theorem_number,
    title,
    validation_status
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN
      ('3.2.16','3.2.17','3.2.18','3.2.19','3.2.20')
ORDER BY CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED);

SELECT
    proof_number,
    title,
    proof_method,
    validation_status
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN
      ('3.2.16-P','3.2.17-P','3.2.18-P','3.2.19-P','3.2.20-P')
ORDER BY proof_number;

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 311 AND 322
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
