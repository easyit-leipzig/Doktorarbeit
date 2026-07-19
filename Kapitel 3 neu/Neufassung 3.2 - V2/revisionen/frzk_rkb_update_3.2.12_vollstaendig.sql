-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Vollständiges Repository-Update nach Abschnitt 3.2.12
--
-- Abschnitt: Spektraltheorie als mathematische Grundlage funktionaler
--            Zustandsräume
-- Aufbauend auf: RKB-NEU-K3.2.11-V1
-- Revision:       RKB-NEU-K3.2.12-V1
-- Neue Quellen:   [101]-[102]
-- Wiederverwendung: [99]
-- Definitionen:   3.2.81-3.2.86
-- Sätze:          3.2.29-3.2.32
-- Beweise:        3.2.29-P-3.2.32-P
-- Gleichungen:    (3.345)-(3.353)
-- Nächste Quelle: [103]
-- Nächste Gleichung: (3.354)
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Ausgangsstand und Revision
-- ---------------------------------------------------------------------

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.11-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

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
    'RKB-NEU-K3.2.12-V1',
    NOW(),
    'section',
    '3.2.12',
    '1.0',
    'Abschluss von Abschnitt 3.2.12: Eigenwerte, Eigenräume, charakteristisches Polynom, Spektrum, Spektralsatz, Spektralzerlegung, Orthogonalität verschiedener Eigenräume, dominanter Eigenwert, Langzeitverhalten und funktionales Spektrum des FRZK.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.12-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.12-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 2. Abschnitt 3.2.12
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
    '3.2.12',
    'Spektraltheorie als mathematische Grundlage funktionaler Zustandsräume',
    3,
    3.2120,
    'final',
    1,
    'Der Abschnitt schließt die mathematischen Grundlagen mit der spektralen Beschreibung linearer Operatoren und dem FRZK-spezifischen funktionalen Spektrum ab.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.12'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Spektraltheorie als mathematische Grundlage funktionaler Zustandsräume',
    chapter_no = 3,
    section_order = 3.2120,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Der Abschnitt schließt die mathematischen Grundlagen mit der spektralen Beschreibung linearer Operatoren und dem FRZK-spezifischen funktionalen Spektrum ab.'
WHERE section_code = '3.2.12';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.12'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Autoren
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
    'Hilbert',
    'David',
    'Hilbert, David',
    1862,
    1943,
    'Autor der Quelle [101].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Hilbert, David'
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
    'Autor der Quelle [102].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'von Neumann, John'
);

SET @author_hilbert := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Hilbert, David'
    LIMIT 1
);

SET @author_von_neumann := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'von Neumann, John'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Quellen [101]-[102] und Wiederverwendung [99]
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
    101,
    'hilbert_integralgleichungen_1912',
    'book',
    'Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen',
    NULL,
    1912,
    1912,
    NULL,
    'B. G. Teubner',
    'Leipzig',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'historical',
    10,
    'partially_verified',
    '3.2.12',
    'Historische Grundlage der Operator- und Spektraltheorie in unendlichdimensionalen Räumen.',
    'Hilbert, David: Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen. Leipzig: B. G. Teubner, 1912.',
    'Hilbert [101]',
    'Bibliografische Detailprüfung im Gesamtaudit vorgesehen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number = 101
       OR source_key = 'hilbert_integralgleichungen_1912'
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
    102,
    'von_neumann_mathematical_foundations_qm_1932',
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
    'historical',
    10,
    'partially_verified',
    '3.2.12',
    'Moderne Formulierung der Spektraltheorie selbstadjungierter Operatoren.',
    'von Neumann, John: Mathematical Foundations of Quantum Mechanics. Princeton: Princeton University Press, 1932.',
    'von Neumann [102]',
    'Der englische Titel wird entsprechend der im Kapitel verwendeten Ausgabe geführt.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number = 102
       OR source_key = 'von_neumann_mathematical_foundations_qm_1932'
);

SET @source_99 := (
    SELECT source_id
    FROM sources
    WHERE citation_number = 99
       OR source_key = 'schmidt_integralgleichungen_1907'
    LIMIT 1
);

SET @source_101 := (
    SELECT source_id
    FROM sources
    WHERE citation_number = 101
       OR source_key = 'hilbert_integralgleichungen_1912'
    LIMIT 1
);

SET @source_102 := (
    SELECT source_id
    FROM sources
    WHERE citation_number = 102
       OR source_key = 'von_neumann_mathematical_foundations_qm_1932'
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
(@source_101, @author_hilbert, 1, 'author'),
(@source_102, @author_von_neumann, 1, 'author');

-- ---------------------------------------------------------------------
-- 5. Quellenverwendung
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
    @source_101,
    @section_id,
    'first_citation',
    'Hilbert wird für die historischen Grundlagen unendlichdimensionaler Operatorräume und der Spektraltheorie verwendet.',
    'Abschnitt 3.2.12, historische Einleitung',
    1,
    1,
    'Erstnennung als Quelle [101].',
    @revision_id
WHERE @source_101 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_101
        AND section_id = @section_id
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
    @source_99,
    @section_id,
    'reuse',
    'Schmidt wird für die Untersuchung kompakter Operatoren und als historische Verbindung zur Spektraltheorie wiederverwendet.',
    'Abschnitt 3.2.12, historische Einleitung',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [99].',
    @revision_id
WHERE @source_99 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_99
        AND section_id = @section_id
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
    @source_102,
    @section_id,
    'first_citation',
    'Von Neumann wird für die moderne Spektraltheorie und ihre Bedeutung in der mathematischen Physik verwendet.',
    'Abschnitt 3.2.12, historische Einleitung und Spektralsatz',
    1,
    1,
    'Erstnennung als Quelle [102].',
    @revision_id
WHERE @source_102 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_102
        AND section_id = @section_id
  );

-- ---------------------------------------------------------------------
-- 6. Definitionen 3.2.81-3.2.86
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
    '3.2.81',
    @section_id,
    'Eigenwert',
    'Für einen linearen Operator A:V→V heißt λ Eigenwert, wenn ein von Null verschiedener Vektor v existiert, für den Av=λv gilt.',
    'A:V\rightarrow V,\quad Av=\lambda v,\quad v\neq 0',
    'A:V\rightarrow V,\quad Av=\lambda v,\quad v\neq 0',
    'adapted',
    @source_101,
    'A ist ein linearer Operator auf V.',
    'Der Vektor v heißt Eigenvektor zum Eigenwert λ.',
    'checked',
    @revision_id
),
(
    '3.2.82',
    @section_id,
    'Eigenraum',
    'Der Eigenraum E_λ ist die Menge aller Vektoren, die durch A mit dem Faktor λ skaliert werden, einschließlich des Nullvektors.',
    'E_\lambda=\{v\in V\mid Av=\lambda v\}',
    'E_\lambda=\{v\in V\mid Av=\lambda v\}',
    'adapted',
    @source_101,
    'λ ist ein Eigenwert von A.',
    'Der Eigenraum entspricht dem Kern von A-λI.',
    'checked',
    @revision_id
),
(
    '3.2.83',
    @section_id,
    'Spektrum',
    'Das Spektrum σ(A) ist die Menge aller Skalare λ, für die A-λI nicht invertierbar ist. Im endlichdimensionalen Fall entspricht es der Menge der Eigenwerte.',
    '\sigma(A)=\{\lambda\mid A-\lambda I\ \text{ist nicht invertierbar}\}',
    '\sigma(A)=\{\lambda\mid A-\lambda I\ \text{ist nicht invertierbar}\}',
    'adapted',
    @source_102,
    'A ist ein linearer Operator.',
    'Die im Text verwendete endliche Darstellung {λ1,...,λn} ist ein Spezialfall.',
    'checked',
    @revision_id
),
(
    '3.2.84',
    @section_id,
    'Spektralzerlegung',
    'Eine Spektralzerlegung stellt einen selbstadjungierten Operator als Summe seiner Eigenwerte, gewichtet mit den zugehörigen orthogonalen Projektoren, dar.',
    'A=\sum_i\lambda_iP_i',
    'A=\sum_i\lambda_iP_i',
    'adapted',
    @source_102,
    'A ist im endlichdimensionalen Fall reell symmetrisch beziehungsweise selbstadjungiert.',
    'Die Projektoren P_i projizieren auf die Eigenräume E_i.',
    'checked',
    @revision_id
),
(
    '3.2.85',
    @section_id,
    'Dominanter Eigenwert',
    'Ein dominanter Eigenwert ist ein Eigenwert mit maximalem Betrag innerhalb des Spektrums.',
    '|\lambda_{\max}|=\max_i|\lambda_i|',
    '|\lambda_{\max}|=\max_i|\lambda_i|',
    'adapted',
    @source_102,
    'Das Spektrum ist endlich oder besitzt einen betragsmäßig maximalen Eigenwert.',
    'Bei eindeutiger Dominanz bestimmt der zugehörige Eigenraum häufig das asymptotische Verhalten.',
    'checked',
    @revision_id
),
(
    '3.2.86',
    @section_id,
    'Funktionales Spektrum',
    'Im FRZK bezeichnet das funktionale Spektrum die Menge aller Eigenwerte eines funktionalen Operators, deren Eigenräume stabile funktionale Zustände, Resonanzrichtungen oder Attraktoren repräsentieren.',
    '\sigma_F(\mathcal{A})=\{\lambda_i\mid\mathcal{A}v_i=\lambda_iv_i\}',
    '\sigma_F(\mathcal{A})=\{\lambda_i\mid\mathcal{A}v_i=\lambda_iv_i\}',
    'original',
    NULL,
    '𝒜 ist ein funktionaler Operator auf einem funktionalen Zustandsraum.',
    'FRZK-spezifische Definition und Übergang zur axiomatischen Beschreibung in Kapitel 3.3.',
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
-- 7. Sätze 3.2.29-3.2.32
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
    '3.2.29',
    @section_id,
    'Charakteristisches Polynom',
    'Ein Skalar λ ist genau dann Eigenwert einer quadratischen Matrix A, wenn det(A-λI)=0 gilt.',
    '\det(A-\lambda I)=0',
    '\det(A-\lambda I)=0',
    'adapted',
    @source_101,
    'A ist eine quadratische Matrix über einem Körper, in dem das charakteristische Polynom zerfällt.',
    'checked',
    @revision_id
),
(
    '3.2.30',
    @section_id,
    'Spektralsatz',
    'Jede reelle symmetrische Matrix A ist orthogonal diagonalisierbar und besitzt eine Darstellung A=QΛQ^T.',
    'A=Q\Lambda Q^T',
    'A=Q\Lambda Q^T',
    'adapted',
    @source_102,
    'A ist reell und symmetrisch.',
    'checked',
    @revision_id
),
(
    '3.2.31',
    @section_id,
    'Orthogonalität verschiedener Eigenräume',
    'Eigenvektoren einer reellen symmetrischen Matrix zu verschiedenen Eigenwerten sind orthogonal.',
    '\lambda_i\neq\lambda_j\Rightarrow E_i\perp E_j',
    '\lambda_i\neq\lambda_j\Rightarrow E_i\perp E_j',
    'adapted',
    @source_102,
    'A ist reell und symmetrisch beziehungsweise selbstadjungiert.',
    'checked',
    @revision_id
),
(
    '3.2.32',
    @section_id,
    'Langzeitverhalten iterierter Operatoren',
    'Besitzt A einen betragsmäßig eindeutig dominanten Eigenwert λ_max und hat der Anfangsvektor eine von Null verschiedene Komponente im zugehörigen Eigenraum, dann wird die Richtung von A^n v asymptotisch durch diesen Eigenraum bestimmt.',
    'A^nv\sim c\lambda_{\max}^nv_{\max}',
    'A^nv\sim c\lambda_{\max}^nv_{\max}',
    'adapted',
    @source_102,
    'A ist diagonalisierbar; |λ_max|>|λ_i| für alle übrigen Eigenwerte und c≠0.',
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

SET @theorem_3229 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.29'
    LIMIT 1
);

SET @theorem_3230 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.30'
    LIMIT 1
);

SET @theorem_3231 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.31'
    LIMIT 1
);

SET @theorem_3232 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.32'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 8. Beweise 3.2.29-P-3.2.32-P
-- ---------------------------------------------------------------------

INSERT INTO proofs
(
    proof_number,
    section_id,
    theorem_id,
    lemma_id,
    corollary_id,
    title,
    proof_text,
    proof_latex,
    proof_method,
    provenance,
    source_id,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.29-P',
    @section_id,
    @theorem_3229,
    NULL,
    NULL,
    'Beweis zum charakteristischen Polynom',
    'Aus Av=λv folgt (A-λI)v=0. Da v nicht der Nullvektor ist, besitzt A-λI einen nichttrivialen Kern und ist daher nicht invertierbar. Für quadratische Matrizen ist dies äquivalent zu det(A-λI)=0. Umgekehrt erzeugt eine verschwindende Determinante einen nichttrivialen Kern und damit einen Eigenvektor.',
    '(A-\lambda I)v=0\Longleftrightarrow\det(A-\lambda I)=0',
    'equivalence',
    'adapted',
    @source_101,
    'checked',
    @revision_id
WHERE @theorem_3229 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.29-P'
  );

INSERT INTO proofs
(
    proof_number,
    section_id,
    theorem_id,
    lemma_id,
    corollary_id,
    title,
    proof_text,
    proof_latex,
    proof_method,
    provenance,
    source_id,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.30-P',
    @section_id,
    @theorem_3230,
    NULL,
    NULL,
    'Beweisskizze zum Spektralsatz',
    'Eine reelle symmetrische Matrix besitzt ausschließlich reelle Eigenwerte. Eigenvektoren zu verschiedenen Eigenwerten sind orthogonal. Innerhalb mehrfacher Eigenräume kann eine Orthonormalbasis gewählt werden. Die Gesamtheit dieser Basisvektoren bildet die orthogonale Matrix Q; die zugehörigen Eigenwerte bilden die Diagonalmatrix Λ.',
    'Q^TAQ=\Lambda\Longleftrightarrow A=Q\Lambda Q^T',
    'spectral_decomposition',
    'adapted',
    @source_102,
    'checked',
    @revision_id
WHERE @theorem_3230 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.30-P'
  );

INSERT INTO proofs
(
    proof_number,
    section_id,
    theorem_id,
    lemma_id,
    corollary_id,
    title,
    proof_text,
    proof_latex,
    proof_method,
    provenance,
    source_id,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.31-P',
    @section_id,
    @theorem_3231,
    NULL,
    NULL,
    'Beweis der Orthogonalität verschiedener Eigenräume',
    'Für Av_i=λ_i v_i und Av_j=λ_j v_j gilt wegen der Symmetrie von A: λ_i⟨v_i,v_j⟩=⟨Av_i,v_j⟩=⟨v_i,Av_j⟩=λ_j⟨v_i,v_j⟩. Aus λ_i≠λ_j folgt daher ⟨v_i,v_j⟩=0.',
    '(\lambda_i-\lambda_j)\langle v_i,v_j\rangle=0',
    'inner_product',
    'adapted',
    @source_102,
    'checked',
    @revision_id
WHERE @theorem_3231 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.31-P'
  );

INSERT INTO proofs
(
    proof_number,
    section_id,
    theorem_id,
    lemma_id,
    corollary_id,
    title,
    proof_text,
    proof_latex,
    proof_method,
    provenance,
    source_id,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.32-P',
    @section_id,
    @theorem_3232,
    NULL,
    NULL,
    'Beweis des spektralen Langzeitverhaltens',
    'Der Anfangsvektor wird in Eigenvektoren zerlegt. Nach n Iterationen wird jede Komponente mit λ_i^n gewichtet. Ist |λ_max| strikt größer als der Betrag aller übrigen Eigenwerte, verschwinden deren relative Beiträge gegenüber der dominanten Komponente. Die normierte Richtung konvergiert daher gegen den dominanten Eigenraum.',
    'A^nv=\sum_i c_i\lambda_i^nv_i',
    'asymptotic',
    'adapted',
    @source_102,
    'checked',
    @revision_id
WHERE @theorem_3232 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.32-P'
  );

-- ---------------------------------------------------------------------
-- 9. Gleichungen (3.345)-(3.353)
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
    '3.345',
    @section_id,
    'Linearer Operator',
    'A:V\rightarrow V',
    'A:V\rightarrow V',
    'A bildet den Zustandsraum V linear auf sich selbst ab.',
    'definition',
    'adapted',
    @source_101,
    NULL,
    'V ist ein Vektorraum.',
    'checked',
    @revision_id
),
(
    '3.346',
    @section_id,
    'Eigenwertgleichung',
    'Av=\lambda v',
    'Av=\lambda v',
    'Ein Eigenvektor wird durch A lediglich skaliert.',
    'definition',
    'adapted',
    @source_101,
    NULL,
    'v ist von Null verschieden.',
    'checked',
    @revision_id
),
(
    '3.347',
    @section_id,
    'Eigenraum',
    'E_\lambda=\{v\in V\mid Av=\lambda v\}',
    'E_\lambda=\{v\in V\mid Av=\lambda v\}',
    'Der Eigenraum enthält alle Eigenvektoren zum Eigenwert λ und den Nullvektor.',
    'definition',
    'adapted',
    @source_101,
    NULL,
    'λ ist ein Eigenwert.',
    'checked',
    @revision_id
),
(
    '3.348',
    @section_id,
    'Charakteristische Gleichung',
    '\det(A-\lambda I)=0',
    '\det(A-\lambda I)=0',
    'Die Eigenwerte sind die Nullstellen des charakteristischen Polynoms.',
    'theorem',
    'adapted',
    @source_101,
    NULL,
    'A ist quadratisch.',
    'checked',
    @revision_id
),
(
    '3.349',
    @section_id,
    'Endlichdimensionales Spektrum',
    '\sigma(A)=\{\lambda_1,\ldots,\lambda_n\}',
    '\sigma(A)=\{\lambda_1,\ldots,\lambda_n\}',
    'Das Spektrum wird im endlichdimensionalen Fall als Menge der Eigenwerte dargestellt.',
    'definition',
    'adapted',
    @source_102,
    NULL,
    'A besitzt endlich viele Eigenwerte.',
    'checked',
    @revision_id
),
(
    '3.350',
    @section_id,
    'Orthogonale Diagonalisierung',
    'A=Q\Lambda Q^T',
    'A=Q\Lambda Q^T',
    'Eine reelle symmetrische Matrix wird durch eine orthogonale Basis diagonalisiert.',
    'theorem',
    'adapted',
    @source_102,
    NULL,
    'A ist reell und symmetrisch.',
    'checked',
    @revision_id
),
(
    '3.351',
    @section_id,
    'Spektralzerlegung',
    'A=\sum_i\lambda_iP_i',
    'A=\sum_i\lambda_iP_i',
    'Der Operator wird als gewichtete Summe orthogonaler Projektoren dargestellt.',
    'definition',
    'adapted',
    @source_102,
    NULL,
    'A ist selbstadjungiert und besitzt eine diskrete Spektralzerlegung.',
    'checked',
    @revision_id
),
(
    '3.352',
    @section_id,
    'Orthogonalität verschiedener Eigenräume',
    '\lambda_i\neq\lambda_j\Rightarrow E_i\perp E_j',
    '\lambda_i\neq\lambda_j\Rightarrow E_i\perp E_j',
    'Eigenräume verschiedener Eigenwerte sind bei selbstadjungierten Operatoren orthogonal.',
    'theorem',
    'adapted',
    @source_102,
    NULL,
    'A ist selbstadjungiert.',
    'checked',
    @revision_id
),
(
    '3.353',
    @section_id,
    'Dominanter Eigenwert',
    '|\lambda_{\max}|=\max_i|\lambda_i|',
    '|\lambda_{\max}|=\max_i|\lambda_i|',
    'Der dominante Eigenwert besitzt den größten Betrag innerhalb des Spektrums.',
    'definition',
    'adapted',
    @source_102,
    NULL,
    'Das Maximum existiert.',
    'checked',
    @revision_id
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
-- 10. Gleichungssymbole
-- ---------------------------------------------------------------------

SET @eq_3345 := (SELECT equation_id FROM equations WHERE equation_number='3.345' LIMIT 1);
SET @eq_3346 := (SELECT equation_id FROM equations WHERE equation_number='3.346' LIMIT 1);
SET @eq_3347 := (SELECT equation_id FROM equations WHERE equation_number='3.347' LIMIT 1);
SET @eq_3348 := (SELECT equation_id FROM equations WHERE equation_number='3.348' LIMIT 1);
SET @eq_3349 := (SELECT equation_id FROM equations WHERE equation_number='3.349' LIMIT 1);
SET @eq_3350 := (SELECT equation_id FROM equations WHERE equation_number='3.350' LIMIT 1);
SET @eq_3351 := (SELECT equation_id FROM equations WHERE equation_number='3.351' LIMIT 1);
SET @eq_3352 := (SELECT equation_id FROM equations WHERE equation_number='3.352' LIMIT 1);
SET @eq_3353 := (SELECT equation_id FROM equations WHERE equation_number='3.353' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(
    equation_id,
    symbol_latex,
    symbol_name,
    definition_text,
    symbol_order
)
VALUES
(@eq_3345,'A','Linearer Operator','Linearer Operator auf dem Zustandsraum V.',1),
(@eq_3345,'V','Zustandsraum','Vektorraum beziehungsweise funktionaler Zustandsraum.',2),

(@eq_3346,'\lambda','Eigenwert','Skalierungsfaktor einer Eigenrichtung.',1),
(@eq_3346,'v','Eigenvektor','Von Null verschiedener Vektor mit Av=λv.',2),

(@eq_3347,'E_\lambda','Eigenraum','Unterraum aller Eigenvektoren zum Eigenwert λ einschließlich Nullvektor.',1),

(@eq_3348,'\det','Determinante','Determinante der charakteristischen Matrix.',1),
(@eq_3348,'I','Identitätsmatrix','Neutrales Element der Matrixmultiplikation.',2),

(@eq_3349,'\sigma(A)','Spektrum','Menge der Eigenwerte beziehungsweise spektralen Werte von A.',1),

(@eq_3350,'Q','Orthogonale Matrix','Matrix aus orthonormalen Eigenvektoren.',1),
(@eq_3350,'\Lambda','Diagonalmatrix','Diagonalmatrix der Eigenwerte.',2),
(@eq_3350,'Q^T','Transponierte Matrix','Transponierte der orthogonalen Matrix Q.',3),

(@eq_3351,'P_i','Spektralprojektor','Orthogonaler Projektor auf den Eigenraum E_i.',1),
(@eq_3351,'\lambda_i','Spektralwert','Eigenwert zum Projektor P_i.',2),

(@eq_3352,'E_i','Eigenraum','Eigenraum zum Eigenwert λ_i.',1),
(@eq_3352,'\perp','Orthogonalität','Orthogonalitätsrelation zwischen Unterräumen.',2),

(@eq_3353,'\lambda_{\max}','Dominanter Eigenwert','Eigenwert mit maximalem Betrag.',1);

-- ---------------------------------------------------------------------
-- 11. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_citation_number', '103')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 103 THEN '103'
        ELSE counter_value
    END;

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_equation_number', '3.354')
ON DUPLICATE KEY UPDATE
    counter_value = '3.354';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_completed_section', '3.2.12')
ON DUPLICATE KEY UPDATE
    counter_value = '3.2.12';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_repository_revision', 'RKB-NEU-K3.2.12-V1')
ON DUPLICATE KEY UPDATE
    counter_value = 'RKB-NEU-K3.2.12-V1';

-- ---------------------------------------------------------------------
-- 12. Änderungsprotokoll
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
    '3.2.12',
    'Abschnitt 3.2.12 wurde vollständig in das Repository aufgenommen.',
    NULL,
    'Spektraltheorie als mathematische Grundlage funktionaler Zustandsräume'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '3.2.12'
        AND change_type = 'rewritten'
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
    @section_id,
    'source_added',
    'sources',
    '[101]-[102]',
    'Zwei neue Quellen zur Operator- und Spektraltheorie wurden aufgenommen; Quelle [99] wurde wiederverwendet.',
    'next_citation_number=101',
    'next_citation_number=103'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '[101]-[102]'
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
    @section_id,
    'definition_added',
    'definitions',
    '3.2.81-3.2.86',
    'Sechs Definitionen einschließlich des FRZK-spezifischen funktionalen Spektrums wurden aufgenommen.',
    NULL,
    '6 Definitionen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '3.2.81-3.2.86'
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
    @section_id,
    'statement_added',
    'theorems',
    '3.2.29-3.2.32',
    'Vier Sätze zu charakteristischem Polynom, Spektralsatz, Orthogonalität und Langzeitverhalten wurden aufgenommen.',
    NULL,
    '4 Sätze'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '3.2.29-3.2.32'
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
    @section_id,
    'proof_added',
    'proofs',
    '3.2.29-P-3.2.32-P',
    'Vier Beweise beziehungsweise Beweisskizzen wurden aufgenommen.',
    NULL,
    '4 Beweise'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '3.2.29-P-3.2.32-P'
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
    @section_id,
    'equation_added',
    'equations',
    '(3.345)-(3.353)',
    'Neun Gleichungen einschließlich Word-LaTeX und Symbolzuordnungen wurden aufgenommen.',
    'next_equation_number=3.345',
    'next_equation_number=3.354'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '(3.345)-(3.353)'
  );

-- ---------------------------------------------------------------------
-- 13. Validierungen
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
    'K3.2.12_SECTION',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.12 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code = '3.2.12'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_NEW_SOURCES',
    IF(COUNT(*) = 2, 'passed', 'failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die neuen Quellen [101] und [102] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (101, 102)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_SOURCE_USAGE',
    IF(COUNT(*) = 3, 'passed', 'failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [99], [101] und [102] müssen mit Abschnitt 3.2.12 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id = su.source_id
WHERE su.section_id = @section_id
  AND s.citation_number IN (99, 101, 102)
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_DEFINITIONS',
    IF(COUNT(*) = 6, 'passed', 'failed'),
    '6',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.81 bis 3.2.86 müssen vollständig vorhanden sein.'
FROM definitions
WHERE section_id = @section_id
  AND definition_number IN
      ('3.2.81','3.2.82','3.2.83','3.2.84','3.2.85','3.2.86')
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_THEOREMS',
    IF(COUNT(*) = 4, 'passed', 'failed'),
    '4',
    CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.29 bis 3.2.32 müssen vollständig vorhanden sein.'
FROM theorems
WHERE section_id = @section_id
  AND theorem_number IN ('3.2.29','3.2.30','3.2.31','3.2.32')
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_PROOFS',
    IF(COUNT(*) = 4, 'passed', 'failed'),
    '4',
    CAST(COUNT(*) AS CHAR),
    'Die Beweise 3.2.29-P bis 3.2.32-P müssen vollständig vorhanden sein.'
FROM proofs
WHERE section_id = @section_id
  AND proof_number IN ('3.2.29-P','3.2.30-P','3.2.31-P','3.2.32-P')
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_EQUATIONS',
    IF(COUNT(*) = 9, 'passed', 'failed'),
    '9',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.345) bis (3.353) müssen vollständig vorhanden sein.'
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)
      BETWEEN 345 AND 353
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_WORD_LATEX',
    IF(COUNT(*) = 9, 'passed', 'failed'),
    '9',
    CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)
      BETWEEN 345 AND 353
  AND word_latex IS NOT NULL
  AND TRIM(word_latex) <> ''
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
    'K3.2.12_PARENT_REVISION',
    IF(parent_revision_id = @parent_revision_id, 'passed', 'failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision muss unmittelbar auf RKB-NEU-K3.2.11-V1 aufbauen.'
FROM repository_revisions
WHERE revision_id = @revision_id
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

COMMIT;

-- ---------------------------------------------------------------------
-- 14. Audit-Abfragen
-- ---------------------------------------------------------------------

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    parent_revision_id,
    revision_date
FROM repository_revisions
WHERE revision_code = 'RKB-NEU-K3.2.12-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code = '3.2.12';

SELECT
    citation_number,
    source_key,
    short_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (99, 101, 102)
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    provenance,
    validation_status
FROM definitions
WHERE section_id = @section_id
  AND definition_number IN
      ('3.2.81','3.2.82','3.2.83','3.2.84','3.2.85','3.2.86')
ORDER BY CAST(SUBSTRING_INDEX(definition_number, '.', -1) AS UNSIGNED);

SELECT
    theorem_number,
    title,
    validation_status
FROM theorems
WHERE section_id = @section_id
  AND theorem_number IN ('3.2.29','3.2.30','3.2.31','3.2.32')
ORDER BY CAST(SUBSTRING_INDEX(theorem_number, '.', -1) AS UNSIGNED);

SELECT
    proof_number,
    title,
    proof_method,
    validation_status
FROM proofs
WHERE section_id = @section_id
  AND proof_number IN ('3.2.29-P','3.2.30-P','3.2.31-P','3.2.32-P')
ORDER BY proof_number;

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)
      BETWEEN 345 AND 353
ORDER BY CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED);

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_id
ORDER BY validation_code;
