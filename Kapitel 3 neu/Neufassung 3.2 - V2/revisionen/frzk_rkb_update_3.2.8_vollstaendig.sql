-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Vollständiges Repository-Update nach Abschnitt 3.2.8
-- Abschnitt: Skalarprodukte, Normen und Metriken als mathematische
--            Beschreibung von Ähnlichkeit und Abstand
--
-- Aufbauend auf: RKB-NEU-K3.2.7-V1
-- Revision:       RKB-NEU-K3.2.8-V1
-- Wiederverwendung: [85] Grassmann
-- Neue Quellen:   [91]-[92]
-- Definitionen:   3.2.52-3.2.59
-- Sätze:          3.2.14-3.2.15
-- Beweise:        3.2.14-P, 3.2.15-P
-- Gleichungen:    (3.293)-(3.310)
-- Nächste Quelle: [93]
--
-- Schema: frzk_rkb(3).sql
-- Das Skript ist idempotent angelegt.
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
    WHERE revision_code = 'RKB-NEU-K3.2.7-V1'
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
        THEN 'FEHLER: Revision RKB-NEU-K3.2.7-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach Abschnitt 3.2.7 vorhanden.'
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
    'RKB-NEU-K3.2.8-V1',
    NOW(),
    'section',
    '3.2.8',
    '1.0',
    'Abschluss von Abschnitt 3.2.8: Skalarprodukte, Normen, Winkel, Orthogonalität, Metriken und Projektionen; Quellen [91] bis [92], Wiederverwendung von [85], Definitionen 3.2.52 bis 3.2.59, Sätze 3.2.14 bis 3.2.15 und Gleichungen (3.293) bis (3.310).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.8-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.8-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsteil 3.2.8
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
    '3.2.8',
    'Skalarprodukte, Normen und Metriken als mathematische Beschreibung von Ähnlichkeit und Abstand',
    3,
    3.2800,
    'final',
    0,
    'Der Abschnitt führt Skalarprodukte, Normen, Winkel, Orthogonalität, Metriken und orthogonale Projektionen als mathematische Grundlage von Ähnlichkeit, Länge und Abstand ein.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.8'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Skalarprodukte, Normen und Metriken als mathematische Beschreibung von Ähnlichkeit und Abstand',
    chapter_no = 3,
    section_order = 3.2800,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt führt Skalarprodukte, Normen, Winkel, Orthogonalität, Metriken und orthogonale Projektionen als mathematische Grundlage von Ähnlichkeit, Länge und Abstand ein.'
WHERE section_code = '3.2.8';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.8'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren
-- ---------------------------------------------------------------------

-- David Hilbert ist im Basisschema bereits vorhanden; Eintrag wird nur ergänzt,
-- falls er in der aktuellen Datenbank fehlt.
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
    'Autor der Quelle [91].'
WHERE NOT EXISTS (
    SELECT 1
    FROM authors
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
    'Riesz',
    'Frigyes',
    'Riesz, Frigyes',
    1880,
    1956,
    'Erstautor der Quelle [92].'
WHERE NOT EXISTS (
    SELECT 1
    FROM authors
    WHERE normalized_name = 'Riesz, Frigyes'
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
    'Sz.-Nagy',
    'Béla',
    'Sz.-Nagy, Béla',
    1913,
    1998,
    'Zweitautor der Quelle [92].'
WHERE NOT EXISTS (
    SELECT 1
    FROM authors
    WHERE normalized_name = 'Sz.-Nagy, Béla'
);

SET @author_hilbert := (
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Hilbert, David'
    LIMIT 1
);

SET @author_riesz := (
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Riesz, Frigyes'
    LIMIT 1
);

SET @author_sznagy := (
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Sz.-Nagy, Béla'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen [91]-[92]
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
    91,
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
    'primary',
    9,
    'verified',
    '3.2.8',
    'Historische Einordnung von Skalarprodukträumen und Hilberträumen.',
    'Hilbert, David: Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen. Leipzig: B. G. Teubner, 1912.',
    'Hilbert [91]',
    'Historische Primärquelle zur Entwicklung der Theorie von Integralgleichungen und Hilberträumen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number = 91
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
    92,
    'riesz_sznagy_functional_analysis_1955',
    'book',
    'Functional Analysis',
    NULL,
    1952,
    1955,
    NULL,
    'Frederick Ungar Publishing',
    'New York',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'reference',
    9,
    'verified',
    '3.2.8',
    'Grundlage zu Skalarprodukten, Normen, Hilberträumen und linearen Funktionalen.',
    'Riesz, Frigyes; Sz.-Nagy, Béla: Functional Analysis. New York: Frederick Ungar Publishing, 1955.',
    'Riesz und Sz.-Nagy [92]',
    'Grundlagenquelle zur Funktionalanalysis und zu Skalarprodukträumen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number = 92
       OR source_key = 'riesz_sznagy_functional_analysis_1955'
);

SET @source_85 := (
    SELECT source_id
    FROM sources
    WHERE citation_number = 85
    LIMIT 1
);

SET @source_91 := (
    SELECT source_id
    FROM sources
    WHERE source_key = 'hilbert_integralgleichungen_1912'
       OR citation_number = 91
    ORDER BY (source_key = 'hilbert_integralgleichungen_1912') DESC
    LIMIT 1
);

SET @source_92 := (
    SELECT source_id
    FROM sources
    WHERE source_key = 'riesz_sznagy_functional_analysis_1955'
       OR citation_number = 92
    ORDER BY (source_key = 'riesz_sznagy_functional_analysis_1955') DESC
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
(@source_91, @author_hilbert, 1, 'author'),
(@source_92, @author_riesz,   1, 'author'),
(@source_92, @author_sznagy,  2, 'author');

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
    @source_85,
    @section_id,
    'historical_context',
    'Grassmanns Ausdehnungslehre wird als historische Grundlage gerichteter Größen und der algebraischen Geometrisierung wiederverwendet.',
    'Abschnitt 3.2.8, historische Einleitung',
    0,
    1,
    'Wiederverwendung der bereits eingeführten Quelle [85].',
    @revision_id
WHERE @source_85 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_85
        AND section_id = @section_id
        AND usage_type = 'historical_context'
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
    @source_91,
    @section_id,
    'first_citation',
    'Hilberts Arbeiten werden als historische Grundlage der Theorie von Skalarprodukt- und Hilberträumen herangezogen.',
    'Abschnitt 3.2.8, historische Einleitung',
    1,
    1,
    'Erstnennung als Quelle [91].',
    @revision_id
WHERE @source_91 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_91
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
    @source_92,
    @section_id,
    'first_citation',
    'Riesz und Sz.-Nagy dienen als systematische Referenz für Skalarprodukte, Normen, Orthogonalität und Funktionalanalysis.',
    'Abschnitt 3.2.8, Definitionen und Sätze',
    1,
    1,
    'Erstnennung als Quelle [92].',
    @revision_id
WHERE @source_92 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_92
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.52-3.2.59
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
    '3.2.52',
    @section_id,
    'Skalarprodukt',
    'Ein Skalarprodukt auf einem reellen Vektorraum ist eine symmetrische, lineare und positiv definite Abbildung von V×V nach R.',
    '\langle\cdot,\cdot\rangle:V\times V\rightarrow\mathbb{R}',
    '\langle\cdot,\cdot\rangle:V\times V\rightarrow\mathbb{R}',
    'adapted',
    @source_92,
    'V ist ein reeller Vektorraum.',
    'Die Linearität wird im reellen Fall im ersten Argument formuliert; aus der Symmetrie folgt sie auch im zweiten Argument.',
    'checked',
    @revision_id
),
(
    '3.2.53',
    @section_id,
    'Euklidisches Skalarprodukt',
    'Das Standard-Skalarprodukt auf R^n ist die Summe der komponentenweisen Produkte.',
    '\langle u,v\rangle=\sum_{i=1}^{n}u_iv_i',
    '\langle u,v\rangle=\sum_{i=1}^{n}u_iv_i',
    'adapted',
    @source_92,
    'u,v∈R^n.',
    'Das euklidische Skalarprodukt induziert die euklidische Norm.',
    'checked',
    @revision_id
),
(
    '3.2.54',
    @section_id,
    'Norm',
    'Die durch ein Skalarprodukt induzierte Norm eines Vektors ist die Quadratwurzel seines Skalarprodukts mit sich selbst.',
    '\|v\|=\sqrt{\langle v,v\rangle}',
    '\|v\|=\sqrt{\langle v,v\rangle}',
    'adapted',
    @source_92,
    'V ist ein Skalarproduktraum.',
    'Die Norm beschreibt die Größe beziehungsweise Länge eines Vektors.',
    'checked',
    @revision_id
),
(
    '3.2.55',
    @section_id,
    'Winkel zwischen zwei Vektoren',
    'Der Winkel zwischen zwei von Null verschiedenen Vektoren wird über den Quotienten aus Skalarprodukt und Produkt ihrer Normen bestimmt.',
    '\cos\theta=\frac{\langle u,v\rangle}{\|u\|\|v\|}',
    '\cos\theta=\frac{\langle u,v\rangle}{\|u\|\|v\|}',
    'adapted',
    @source_92,
    'u≠0 und v≠0.',
    'Die Wohldefiniertheit folgt aus der Cauchy-Schwarz-Ungleichung.',
    'checked',
    @revision_id
),
(
    '3.2.56',
    @section_id,
    'Orthogonalität',
    'Zwei Vektoren heißen orthogonal, wenn ihr Skalarprodukt gleich Null ist.',
    '\langle u,v\rangle=0',
    '\langle u,v\rangle=0',
    'adapted',
    @source_92,
    'u und v gehören demselben Skalarproduktraum an.',
    'Orthogonale Vektoren besitzen keinen gegenseitigen Projektionsanteil.',
    'checked',
    @revision_id
),
(
    '3.2.57',
    @section_id,
    'Metrik',
    'Eine Metrik ist eine nichtnegative, definite und symmetrische Abstandsfunktion, welche die Dreiecksungleichung erfüllt.',
    'd:V\times V\rightarrow\mathbb{R}',
    'd:V\times V\rightarrow\mathbb{R}',
    'adapted',
    @source_92,
    'V ist eine nichtleere Menge beziehungsweise ein Vektorraum.',
    'Die Metrik beschreibt Abstände unabhängig davon, ob sie durch eine Norm induziert wird.',
    'checked',
    @revision_id
),
(
    '3.2.58',
    @section_id,
    'Euklidische Metrik',
    'Die durch eine Norm induzierte Abstandsfunktion ist der Abstand der Differenz zweier Vektoren vom Nullvektor.',
    'd(u,v)=\|u-v\|',
    'd(u,v)=\|u-v\|',
    'adapted',
    @source_92,
    'V ist ein normierter Vektorraum.',
    'Im euklidischen Raum wird die Norm durch das Standardskalarprodukt erzeugt.',
    'checked',
    @revision_id
),
(
    '3.2.59',
    @section_id,
    'Orthogonale Projektion',
    'Die orthogonale Projektion von v auf die von u erzeugte Richtung ist der mit dem normierten Skalarproduktkoeffizienten skalierte Vektor u.',
    '\operatorname{proj}_{u}(v)=\frac{\langle u,v\rangle}{\langle u,u\rangle}u',
    '\operatorname{proj}_{u}(v)=\frac{\langle u,v\rangle}{\langle u,u\rangle}u',
    'adapted',
    @source_92,
    'u≠0.',
    'Die Projektion zerlegt v in einen Anteil parallel zu u und einen orthogonalen Rest.',
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
-- 8. Sätze 3.2.14-3.2.15
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
    '3.2.14',
    @section_id,
    'Cauchy-Schwarz-Ungleichung',
    'Für alle Vektoren u und v eines reellen Skalarproduktraums ist der Betrag ihres Skalarprodukts höchstens gleich dem Produkt ihrer Normen.',
    '|\langle u,v\rangle|\leq\|u\|\|v\|',
    '|\langle u,v\rangle|\leq\|u\|\|v\|',
    'literature',
    @source_92,
    'V ist ein reeller Skalarproduktraum.',
    'checked',
    @revision_id
),
(
    '3.2.15',
    @section_id,
    'Dreiecksungleichung der induzierten Norm',
    'Für alle Vektoren u und v eines Skalarproduktraums ist die Norm ihrer Summe höchstens gleich der Summe ihrer Normen.',
    '\|u+v\|\leq\|u\|+\|v\|',
    '\|u+v\|\leq\|u\|+\|v\|',
    'literature',
    @source_92,
    'Die Norm wird durch ein Skalarprodukt induziert.',
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

SET @theorem_3214 := (
    SELECT theorem_id
    FROM theorems
    WHERE theorem_number = '3.2.14'
    LIMIT 1
);

SET @theorem_3215 := (
    SELECT theorem_id
    FROM theorems
    WHERE theorem_number = '3.2.15'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 9. Beweise
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
    '3.2.14-P',
    @section_id,
    @theorem_3214,
    NULL,
    NULL,
    'Beweis der Cauchy-Schwarz-Ungleichung',
    'Für v=0 ist die Aussage unmittelbar erfüllt. Für v≠0 ist die positive Definitheit auf u-λv mit λ=<u,v>/<v,v> anzuwenden. Aus 0≤<u-λv,u-λv>=<u,u>-|<u,v>|²/<v,v> folgt |<u,v>|²≤<u,u><v,v> und damit nach Wurzelziehen die Behauptung.',
    '0\leq\left\langle u-\frac{\langle u,v\rangle}{\langle v,v\rangle}v,u-\frac{\langle u,v\rangle}{\langle v,v\rangle}v\right\rangle=\langle u,u\rangle-\frac{|\langle u,v\rangle|^2}{\langle v,v\rangle}',
    'direct',
    'adapted',
    @source_92,
    'checked',
    @revision_id
WHERE @theorem_3214 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM proofs
      WHERE proof_number = '3.2.14-P'
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
    '3.2.15-P',
    @section_id,
    @theorem_3215,
    NULL,
    NULL,
    'Beweis der Dreiecksungleichung',
    'Aus der Definition der induzierten Norm folgt ||u+v||²=||u||²+2<u,v>+||v||². Mit der Cauchy-Schwarz-Ungleichung wird der mittlere Term durch 2||u||||v|| abgeschätzt. Damit gilt ||u+v||²≤(||u||+||v||)². Da beide Seiten nichtnegativ sind, folgt nach Wurzelziehen die Dreiecksungleichung.',
    '\|u+v\|^2=\|u\|^2+2\langle u,v\rangle+\|v\|^2\leq(\|u\|+\|v\|)^2',
    'direct',
    'adapted',
    @source_92,
    'checked',
    @revision_id
WHERE @theorem_3215 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM proofs
      WHERE proof_number = '3.2.15-P'
  );

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.293)-(3.310)
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
    '3.293',
    @section_id,
    'Abbildungstyp des Skalarprodukts',
    '\langle\cdot,\cdot\rangle:V\times V\rightarrow\mathbb{R}',
    '\langle\cdot,\cdot\rangle:V\times V\rightarrow\mathbb{R}',
    'Das Skalarprodukt ordnet zwei Vektoren eine reelle Zahl zu.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'V ist ein reeller Vektorraum.',
    'checked',
    @revision_id
),
(
    '3.294',
    @section_id,
    'Symmetrie des Skalarprodukts',
    '\langle u,v\rangle=\langle v,u\rangle',
    '\langle u,v\rangle=\langle v,u\rangle',
    'Das Skalarprodukt ist im reellen Fall symmetrisch.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'u,v∈V.',
    'checked',
    @revision_id
),
(
    '3.295',
    @section_id,
    'Linearität des Skalarprodukts',
    '\langle\lambda u+\mu v,w\rangle=\lambda\langle u,w\rangle+\mu\langle v,w\rangle',
    '\langle\lambda u+\mu v,w\rangle=\lambda\langle u,w\rangle+\mu\langle v,w\rangle',
    'Das Skalarprodukt ist im ersten Argument linear.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'λ,μ∈R und u,v,w∈V.',
    'checked',
    @revision_id
),
(
    '3.296',
    @section_id,
    'Nichtnegativität',
    '\langle v,v\rangle\geq0',
    '\langle v,v\rangle\geq0',
    'Das Skalarprodukt eines Vektors mit sich selbst ist nichtnegativ.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'v∈V.',
    'checked',
    @revision_id
),
(
    '3.297',
    @section_id,
    'Definitheit',
    '\langle v,v\rangle=0\Longleftrightarrow v=0',
    '\langle v,v\rangle=0\Longleftrightarrow v=0',
    'Nur der Nullvektor besitzt das Selbstskalarprodukt Null.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'v∈V.',
    'checked',
    @revision_id
),
(
    '3.298',
    @section_id,
    'Euklidisches Skalarprodukt',
    '\langle u,v\rangle=\sum_{i=1}^{n}u_iv_i',
    '\langle u,v\rangle=\sum_{i=1}^{n}u_iv_i',
    'Das euklidische Skalarprodukt ist die Summe der komponentenweisen Produkte.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'u,v∈R^n.',
    'checked',
    @revision_id
),
(
    '3.299',
    @section_id,
    'Induzierte Norm',
    '\|v\|=\sqrt{\langle v,v\rangle}',
    '\|v\|=\sqrt{\langle v,v\rangle}',
    'Die Norm wird durch das Skalarprodukt eines Vektors mit sich selbst induziert.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'V ist ein Skalarproduktraum.',
    'checked',
    @revision_id
),
(
    '3.300',
    @section_id,
    'Cauchy-Schwarz-Ungleichung',
    '|\langle u,v\rangle|\leq\|u\|\|v\|',
    '|\langle u,v\rangle|\leq\|u\|\|v\|',
    'Der Betrag des Skalarprodukts ist durch das Produkt der Normen beschränkt.',
    'theorem',
    'adapted',
    @source_92,
    NULL,
    'u,v∈V.',
    'checked',
    @revision_id
),
(
    '3.301',
    @section_id,
    'Winkeldefinition',
    '\cos\theta=\frac{\langle u,v\rangle}{\|u\|\|v\|}',
    '\cos\theta=\frac{\langle u,v\rangle}{\|u\|\|v\|}',
    'Der Kosinus des Winkels wird durch das normierte Skalarprodukt bestimmt.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'u≠0 und v≠0.',
    'checked',
    @revision_id
),
(
    '3.302',
    @section_id,
    'Orthogonalitätsbedingung',
    '\langle u,v\rangle=0',
    '\langle u,v\rangle=0',
    'Zwei Vektoren sind orthogonal, wenn ihr Skalarprodukt verschwindet.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'u,v∈V.',
    'checked',
    @revision_id
),
(
    '3.303',
    @section_id,
    'Abbildungstyp einer Metrik',
    'd:V\times V\rightarrow\mathbb{R}',
    'd:V\times V\rightarrow\mathbb{R}',
    'Eine Metrik ordnet zwei Zuständen einen reellen Abstand zu.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'V ist nichtleer.',
    'checked',
    @revision_id
),
(
    '3.304',
    @section_id,
    'Nichtnegativität der Metrik',
    'd(x,y)\geq0',
    'd(x,y)\geq0',
    'Abstände sind nichtnegativ.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'x,y∈V.',
    'checked',
    @revision_id
),
(
    '3.305',
    @section_id,
    'Definitheit der Metrik',
    'd(x,y)=0\Longleftrightarrow x=y',
    'd(x,y)=0\Longleftrightarrow x=y',
    'Der Abstand ist genau dann Null, wenn beide Punkte identisch sind.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'x,y∈V.',
    'checked',
    @revision_id
),
(
    '3.306',
    @section_id,
    'Symmetrie der Metrik',
    'd(x,y)=d(y,x)',
    'd(x,y)=d(y,x)',
    'Der Abstand ist unabhängig von der Messrichtung.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'x,y∈V.',
    'checked',
    @revision_id
),
(
    '3.307',
    @section_id,
    'Dreiecksungleichung der Metrik',
    'd(x,z)\leq d(x,y)+d(y,z)',
    'd(x,z)\leq d(x,y)+d(y,z)',
    'Der direkte Abstand ist nicht größer als der Weg über einen Zwischenpunkt.',
    'axiom',
    'adapted',
    @source_92,
    NULL,
    'x,y,z∈V.',
    'checked',
    @revision_id
),
(
    '3.308',
    @section_id,
    'Norminduzierte Metrik',
    'd(u,v)=\|u-v\|',
    'd(u,v)=\|u-v\|',
    'Die Norm der Differenz definiert den Abstand zweier Vektoren.',
    'metric',
    'adapted',
    @source_92,
    NULL,
    'V ist ein normierter Vektorraum.',
    'checked',
    @revision_id
),
(
    '3.309',
    @section_id,
    'Dreiecksungleichung der Norm',
    '\|u+v\|\leq\|u\|+\|v\|',
    '\|u+v\|\leq\|u\|+\|v\|',
    'Die Norm einer Summe ist höchstens die Summe der Einzelnormen.',
    'theorem',
    'adapted',
    @source_92,
    NULL,
    'u,v∈V.',
    'checked',
    @revision_id
),
(
    '3.310',
    @section_id,
    'Orthogonale Projektion',
    '\operatorname{proj}_{u}(v)=\frac{\langle u,v\rangle}{\langle u,u\rangle}u',
    '\operatorname{proj}_{u}(v)=\frac{\langle u,v\rangle}{\langle u,u\rangle}u',
    'Der Anteil von v in Richtung des von u aufgespannten Unterraums.',
    'definition',
    'adapted',
    @source_92,
    NULL,
    'u≠0.',
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
-- 11. Gleichungssymbole
-- ---------------------------------------------------------------------

SET @eq_3293 := (SELECT equation_id FROM equations WHERE equation_number='3.293' LIMIT 1);
SET @eq_3298 := (SELECT equation_id FROM equations WHERE equation_number='3.298' LIMIT 1);
SET @eq_3299 := (SELECT equation_id FROM equations WHERE equation_number='3.299' LIMIT 1);
SET @eq_3300 := (SELECT equation_id FROM equations WHERE equation_number='3.300' LIMIT 1);
SET @eq_3301 := (SELECT equation_id FROM equations WHERE equation_number='3.301' LIMIT 1);
SET @eq_3302 := (SELECT equation_id FROM equations WHERE equation_number='3.302' LIMIT 1);
SET @eq_3303 := (SELECT equation_id FROM equations WHERE equation_number='3.303' LIMIT 1);
SET @eq_3308 := (SELECT equation_id FROM equations WHERE equation_number='3.308' LIMIT 1);
SET @eq_3310 := (SELECT equation_id FROM equations WHERE equation_number='3.310' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(
    equation_id,
    symbol_latex,
    symbol_name,
    definition_text,
    symbol_order
)
VALUES
(@eq_3293,'\langle\cdot,\cdot\rangle','Skalarprodukt','Abbildung, die zwei Vektoren eine reelle Zahl zuordnet.',1),
(@eq_3293,'V','Vektorraum','Reeller Vektorraum, auf dem das Skalarprodukt definiert ist.',2),
(@eq_3293,'\mathbb{R}','Reelle Zahlen','Zielmenge des reellen Skalarprodukts.',3),

(@eq_3298,'u_i','Komponente von u','i-te Komponente des Vektors u.',1),
(@eq_3298,'v_i','Komponente von v','i-te Komponente des Vektors v.',2),
(@eq_3298,'n','Dimension','Anzahl der Komponenten des Vektorraums R^n.',3),

(@eq_3299,'\|v\|','Norm von v','Durch das Skalarprodukt induzierte Länge des Vektors v.',1),

(@eq_3300,'|\langle u,v\rangle|','Betrag des Skalarprodukts','Absolutwert des Skalarprodukts von u und v.',1),

(@eq_3301,'\theta','Winkel','Winkel zwischen zwei von Null verschiedenen Vektoren.',1),
(@eq_3301,'\cos\theta','Kosinusähnlichkeit','Normiertes Skalarprodukt der beiden Vektoren.',2),

(@eq_3302,'\perp','Orthogonalitätsrelation','Bezeichnet senkrecht beziehungsweise unkorreliert zueinander stehende Richtungen.',1),

(@eq_3303,'d','Metrik','Abstandsfunktion auf V×V.',1),

(@eq_3308,'u-v','Differenzvektor','Gerichtete Differenz zwischen u und v.',1),

(@eq_3310,'\operatorname{proj}_{u}(v)','Orthogonale Projektion','Projektionsvektor von v auf die von u erzeugte Richtung.',1);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_citation_number', '93')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 93 THEN '93'
        ELSE counter_value
    END;

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_equation_number', '3.311')
ON DUPLICATE KEY UPDATE
    counter_value = '3.311';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_completed_section', '3.2.8')
ON DUPLICATE KEY UPDATE
    counter_value = '3.2.8';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_repository_revision', 'RKB-NEU-K3.2.8-V1')
ON DUPLICATE KEY UPDATE
    counter_value = 'RKB-NEU-K3.2.8-V1';

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
    '3.2.8',
    'Abschnitt 3.2.8 wurde in der neuen Kapitelarchitektur als Einführung in Skalarprodukte, Normen, Metriken und Projektionen registriert.',
    'Dynamische Systeme als mathematische Beschreibung zeitlicher Entwicklungen',
    'Skalarprodukte, Normen und Metriken als mathematische Beschreibung von Ähnlichkeit und Abstand'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'rewritten'
        AND object_reference = '3.2.8'
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
    '[91]-[92]',
    'Zwei neue Quellen zu Hilberträumen, Skalarprodukten und Funktionalanalysis wurden aufgenommen.',
    'next_citation_number=91',
    'next_citation_number=93'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'source_added'
        AND object_reference = '[91]-[92]'
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
    'source_reused',
    'source',
    '[85]',
    'Grassmann wird als historische Grundlage erneut verwendet.',
    NULL,
    'Quelle [85] im Abschnitt 3.2.8'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND @source_85 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'source_reused'
        AND object_reference = '[85]'
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
    '3.2.52-3.2.59',
    'Acht Definitionen wurden registriert.',
    NULL,
    '8 Definitionen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'definition_added'
        AND object_reference = '3.2.52-3.2.59'
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
    '3.2.14-3.2.15',
    'Die Cauchy-Schwarz-Ungleichung und die Dreiecksungleichung wurden als Sätze registriert.',
    NULL,
    '2 Sätze'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'statement_added'
        AND object_reference = '3.2.14-3.2.15'
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
    '3.2.14-P;3.2.15-P',
    'Zwei direkte Beweise wurden registriert.',
    NULL,
    '2 Beweise'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'proof_added'
        AND object_reference = '3.2.14-P;3.2.15-P'
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
    '(3.293)-(3.310)',
    'Achtzehn Gleichungen einschließlich Word-LaTeX wurden aufgenommen.',
    NULL,
    '18 Gleichungen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'equation_added'
        AND object_reference = '(3.293)-(3.310)'
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
    'K3.2.8_SECTION',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.8 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code = '3.2.8'
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
    'K3.2.8_NEW_SOURCES',
    IF(COUNT(*) = 2, 'passed', 'failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die neuen Quellen [91] und [92] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (91, 92)
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
    'K3.2.8_SOURCE_USAGE',
    IF(COUNT(*) = 3, 'passed', 'failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [85], [91] und [92] müssen mit Abschnitt 3.2.8 verknüpft sein.'
FROM source_usage su
JOIN sources s
  ON s.source_id = su.source_id
WHERE su.section_id = @section_id
  AND s.citation_number IN (85, 91, 92)
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
    'K3.2.8_DEFINITIONS',
    IF(COUNT(*) = 8, 'passed', 'failed'),
    '8',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.52 bis 3.2.59 müssen vollständig vorhanden sein.'
FROM definitions
WHERE section_id = @section_id
  AND definition_number IN
      ('3.2.52','3.2.53','3.2.54','3.2.55',
       '3.2.56','3.2.57','3.2.58','3.2.59')
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
    'K3.2.8_THEOREMS',
    IF(COUNT(*) = 2, 'passed', 'failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.14 und 3.2.15 müssen vollständig vorhanden sein.'
FROM theorems
WHERE section_id = @section_id
  AND theorem_number IN ('3.2.14','3.2.15')
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
    'K3.2.8_PROOFS',
    IF(COUNT(*) = 2, 'passed', 'failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die Beweise 3.2.14-P und 3.2.15-P müssen vorhanden sein.'
FROM proofs
WHERE section_id = @section_id
  AND proof_number IN ('3.2.14-P','3.2.15-P')
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
    'K3.2.8_EQUATIONS',
    IF(COUNT(*) = 18, 'passed', 'failed'),
    '18',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.293) bis (3.310) müssen vollständig vorhanden sein.'
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)
      BETWEEN 293 AND 310
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
    'K3.2.8_WORD_LATEX',
    IF(COUNT(*) = 18, 'passed', 'failed'),
    '18',
    CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)
      BETWEEN 293 AND 310
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
    'K3.2.8_PARENT_REVISION',
    IF(parent_revision_id = @parent_revision_id, 'passed', 'failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision muss unmittelbar auf RKB-NEU-K3.2.7-V1 aufbauen.'
FROM repository_revisions
WHERE revision_id = @revision_id
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
    'K3.2.8_NEXT_CITATION',
    IF(CAST(counter_value AS UNSIGNED) >= 93, 'passed', 'failed'),
    '>=93',
    counter_value,
    'Nach Quelle [92] muss die nächste freie Literaturziffer mindestens [93] sein.'
FROM repository_counters
WHERE counter_key = 'next_citation_number'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

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
WHERE revision_code = 'RKB-NEU-K3.2.8-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code = '3.2.8';

SELECT
    citation_number,
    source_key,
    short_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (85, 91, 92)
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    validation_status
FROM definitions
WHERE section_id = @section_id
  AND definition_number IN
      ('3.2.52','3.2.53','3.2.54','3.2.55',
       '3.2.56','3.2.57','3.2.58','3.2.59')
ORDER BY CAST(SUBSTRING_INDEX(definition_number, '.', -1) AS UNSIGNED);

SELECT
    theorem_number,
    title,
    validation_status
FROM theorems
WHERE section_id = @section_id
  AND theorem_number IN ('3.2.14','3.2.15')
ORDER BY CAST(SUBSTRING_INDEX(theorem_number, '.', -1) AS UNSIGNED);

SELECT
    proof_number,
    title,
    proof_method,
    validation_status
FROM proofs
WHERE section_id = @section_id
  AND proof_number IN ('3.2.14-P','3.2.15-P')
ORDER BY proof_number;

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)
      BETWEEN 293 AND 310
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
