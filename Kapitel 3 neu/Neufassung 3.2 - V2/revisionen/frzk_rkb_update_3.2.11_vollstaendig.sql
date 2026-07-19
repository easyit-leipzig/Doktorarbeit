-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Vollständiges Repository-Update nach Abschnitt 3.2.11
--
-- Abschnitt: Orthogonale Projektionen und Zerlegungen als Grundlage
--            funktionaler Separation
-- Aufbauend auf: RKB-NEU-K3.2.10-V1
-- Revision:       RKB-NEU-K3.2.11-V1
-- Neue Quellen:   [98]-[100]
-- Definitionen:   3.2.76-3.2.80
-- Sätze:          3.2.25-3.2.28
-- Beweise:        3.2.25-P-3.2.28-P
-- Gleichungen:    (3.335)-(3.344)
-- Nächste Quelle: [101]
-- Nächste Gleichung: (3.345)
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
    WHERE revision_code = 'RKB-NEU-K3.2.10-V1'
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
        THEN 'FEHLER: Revision RKB-NEU-K3.2.10-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach Abschnitt 3.2.10 vorhanden.'
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
    'RKB-NEU-K3.2.11-V1',
    NOW(),
    'section',
    '3.2.11',
    '1.0',
    'Abschluss von Abschnitt 3.2.11: orthogonale Projektionen, Projektionszerlegung, Projektionsmatrizen, beste Approximation, Orthogonalkomplement, orthogonale direkte Summe, Gram-Schmidt-Orthogonalisierung und funktionale Separation; Quellen [98] bis [100], Definitionen 3.2.76 bis 3.2.80, Sätze 3.2.25 bis 3.2.28 und Gleichungen (3.335) bis (3.344).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.11-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.11-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsteil 3.2.11
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
    '3.2.11',
    'Orthogonale Projektionen und Zerlegungen als Grundlage funktionaler Separation',
    3,
    3.2110,
    'final',
    1,
    'Der Abschnitt führt orthogonale Projektionen und Zerlegungen als mathematische Grundlage funktionaler Separation ein.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM dissertation_sections
      WHERE section_code = '3.2.11'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Orthogonale Projektionen und Zerlegungen als Grundlage funktionaler Separation',
    chapter_no = 3,
    section_order = 3.2110,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Der Abschnitt führt orthogonale Projektionen und Zerlegungen als mathematische Grundlage funktionaler Separation ein.'
WHERE section_code = '3.2.11';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.11'
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
    'Grassmann',
    'Hermann',
    'Grassmann, Hermann',
    1809,
    1877,
    'Autor der Quelle [98].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Grassmann, Hermann'
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
    'Schmidt',
    'Erhard',
    'Schmidt, Erhard',
    1876,
    1959,
    'Autor der Quelle [99].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Schmidt, Erhard'
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
    'Autor der Quelle [100].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Riesz, Frigyes'
);

SET @author_grassmann := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Grassmann, Hermann'
    LIMIT 1
);

SET @author_schmidt := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Schmidt, Erhard'
    LIMIT 1
);

SET @author_riesz := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Riesz, Frigyes'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen [98]-[100]
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
    98,
    'grassmann_lineale_ausdehnungslehre_1844',
    'book',
    'Die lineale Ausdehnungslehre',
    NULL,
    1844,
    1844,
    NULL,
    'Otto Wigand',
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
    9,
    'partially_verified',
    '3.2.11',
    'Historische Einordnung geometrischer und linearer Zerlegungsstrukturen.',
    'Grassmann, Hermann: Die lineale Ausdehnungslehre. Leipzig: Otto Wigand, 1844.',
    'Grassmann [98]',
    'Bibliografische Detailprüfung im Gesamtaudit vorgesehen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 98
       OR source_key = 'grassmann_lineale_ausdehnungslehre_1844'
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
    99,
    'schmidt_integralgleichungen_1907',
    'article',
    'Zur Theorie der linearen und nichtlinearen Integralgleichungen',
    NULL,
    1907,
    1907,
    'Mathematische Annalen',
    NULL,
    NULL,
    '63',
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
    'partially_verified',
    '3.2.11',
    'Historische Einordnung des Gram-Schmidt-Orthogonalisierungsverfahrens.',
    'Schmidt, Erhard: Zur Theorie der linearen und nichtlinearen Integralgleichungen. Mathematische Annalen 63, 1907.',
    'Schmidt [99]',
    'Seitenbereich und DOI werden im Literaturgesamtaudit ergänzt.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 99
       OR source_key = 'schmidt_integralgleichungen_1907'
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
    100,
    'riesz_systemes_equations_lineaires_1913',
    'book',
    'Les systèmes d''équations linéaires à une infinité d''inconnues',
    NULL,
    1913,
    1913,
    NULL,
    'Gauthier-Villars',
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
    9,
    'partially_verified',
    '3.2.11',
    'Übertragung orthogonaler Zerlegungen auf unendlichdimensionale Räume.',
    'Riesz, Frigyes: Les systèmes d''équations linéaires à une infinité d''inconnues. Paris: Gauthier-Villars, 1913.',
    'Riesz [100]',
    'Bibliografische Detailprüfung im Gesamtaudit vorgesehen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 100
       OR source_key = 'riesz_systemes_equations_lineaires_1913'
);

SET @source_98 := (
    SELECT source_id FROM sources
    WHERE citation_number = 98
       OR source_key = 'grassmann_lineale_ausdehnungslehre_1844'
    LIMIT 1
);

SET @source_99 := (
    SELECT source_id FROM sources
    WHERE citation_number = 99
       OR source_key = 'schmidt_integralgleichungen_1907'
    LIMIT 1
);

SET @source_100 := (
    SELECT source_id FROM sources
    WHERE citation_number = 100
       OR source_key = 'riesz_systemes_equations_lineaires_1913'
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
(@source_98, @author_grassmann, 1, 'author'),
(@source_99, @author_schmidt, 1, 'author'),
(@source_100, @author_riesz, 1, 'author');

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
    @source_98,
    @section_id,
    'first_citation',
    'Grassmann wird zur historischen Einordnung geometrischer und linearer Zerlegungsstrukturen verwendet.',
    'Abschnitt 3.2.11, historische Einleitung',
    1,
    1,
    'Erstnennung als Quelle [98].',
    @revision_id
WHERE @source_98 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_98
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
    'first_citation',
    'Schmidt wird zur historischen Entwicklung des Gram-Schmidt-Orthogonalisierungsverfahrens verwendet.',
    'Abschnitt 3.2.11, historische Einleitung und Definition 3.2.79',
    1,
    1,
    'Erstnennung als Quelle [99].',
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
    @source_100,
    @section_id,
    'first_citation',
    'Riesz wird zur Erweiterung orthogonaler Zerlegungen auf unendlichdimensionale Räume herangezogen.',
    'Abschnitt 3.2.11, historische Einleitung und Satz 3.2.27',
    1,
    1,
    'Erstnennung als Quelle [100].',
    @revision_id
WHERE @source_100 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_100
        AND section_id = @section_id
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.76-3.2.80
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
    '3.2.76',
    @section_id,
    'Orthogonale Projektion',
    'Ein linearer Operator P:V→V heißt orthogonale Projektion, wenn P²=P und P^T=P gelten.',
    'P:V\rightarrow V,\quad P^2=P,\quad P^T=P',
    'P:V\rightarrow V,\quad P^2=P,\quad P^T=P',
    'adapted',
    @source_100,
    'V ist ein reeller Skalarproduktraum.',
    'Idempotenz und Selbstadjungiertheit charakterisieren die orthogonale Projektion.',
    'checked',
    @revision_id
),
(
    '3.2.77',
    @section_id,
    'Projektionsmatrix',
    'Eine Matrix A heißt Projektionsmatrix, wenn A²=A gilt. Ist zusätzlich A^T=A, beschreibt sie eine orthogonale Projektion.',
    'A^2=A',
    'A^2=A',
    'adapted',
    @source_100,
    'A ist eine quadratische Matrix.',
    'Symmetrie unterscheidet orthogonale von schiefen Projektionen.',
    'checked',
    @revision_id
),
(
    '3.2.78',
    @section_id,
    'Orthogonalkomplement',
    'Das Orthogonalkomplement U^⊥ eines Unterraums U enthält alle Vektoren, die zu jedem Vektor aus U orthogonal sind.',
    'U^\perp=\{v\in V\mid\langle v,u\rangle=0\ \forall u\in U\}',
    'U^\perp=\{v\in V\mid\langle v,u\rangle=0\ \forall u\in U\}',
    'adapted',
    @source_100,
    'U ist ein Unterraum eines Skalarproduktraums V.',
    'Das Orthogonalkomplement ist selbst ein Unterraum.',
    'checked',
    @revision_id
),
(
    '3.2.79',
    @section_id,
    'Gram-Schmidt-Orthogonalisierung',
    'Das Gram-Schmidt-Verfahren erzeugt aus linear unabhängigen Vektoren rekursiv ein orthogonales beziehungsweise nach Normierung orthonormales System.',
    'u_k=v_k-\sum_{i=1}^{k-1}\frac{\langle v_k,u_i\rangle}{\langle u_i,u_i\rangle}u_i',
    'u_k=v_k-\sum_{i=1}^{k-1}\frac{\langle v_k,u_i\rangle}{\langle u_i,u_i\rangle}u_i',
    'adapted',
    @source_99,
    'v_1,...,v_n sind linear unabhängig.',
    'Nach anschließender Normierung entsteht eine Orthonormalbasis.',
    'checked',
    @revision_id
),
(
    '3.2.80',
    @section_id,
    'Funktionale Separation',
    'Eine funktionale Separation ist im FRZK die orthogonale Zerlegung eines funktionalen Zustandsraums in unabhängig analysierbare Funktionsanteile.',
    'V_F=\bigoplus_{i=1}^{m}U_i,\quad U_i\perp U_j\ \text{für}\ i\neq j',
    'V_F=\bigoplus_{i=1}^{m}U_i,\quad U_i\perp U_j\ \text{für}\ i\neq j',
    'original',
    NULL,
    'V_F ist ein funktionaler Zustandsraum mit Skalarprodukt.',
    'FRZK-spezifische Arbeitsdefinition als Grundlage späterer Resonanz-, Kohärenz- und Attraktoranalysen.',
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
-- 8. Sätze 3.2.25-3.2.28
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
    '3.2.25',
    @section_id,
    'Projektionszerlegung',
    'Für jede orthogonale Projektion P besitzt jeder Vektor v die eindeutige Zerlegung v=Pv+(I-P)v, wobei Pv im Bild von P und (I-P)v im Kern von P liegt und beide Anteile orthogonal sind.',
    'v=Pv+(I-P)v',
    'v=Pv+(I-P)v',
    'adapted',
    @source_100,
    'P ist eine orthogonale Projektion.',
    'checked',
    @revision_id
),
(
    '3.2.26',
    @section_id,
    'Orthogonale Approximation',
    'Ist P die orthogonale Projektion auf einen abgeschlossenen Unterraum U, dann ist Pv die eindeutig beste Approximation von v in U.',
    '\|v-Pv\|=\min_{u\in U}\|v-u\|',
    '\|v-Pv\|=\min_{u\in U}\|v-u\|',
    'adapted',
    @source_100,
    'U ist abgeschlossen.',
    'checked',
    @revision_id
),
(
    '3.2.27',
    @section_id,
    'Direkte orthogonale Summe',
    'Für jeden abgeschlossenen Unterraum U eines Hilbertraums V gilt V=U⊕U^⊥.',
    'V=U\oplus U^\perp',
    'V=U\oplus U^\perp',
    'adapted',
    @source_100,
    'V ist ein Hilbertraum und U ist abgeschlossen.',
    'checked',
    @revision_id
),
(
    '3.2.28',
    @section_id,
    'Existenz einer Orthonormalbasis',
    'Jeder endlichdimensionale Skalarproduktraum besitzt eine Orthonormalbasis.',
    'V=\operatorname{span}\{e_1,\ldots,e_n\},\quad\langle e_i,e_j\rangle=\delta_{ij}',
    'V=\operatorname{span}\{e_1,\ldots,e_n\},\quad\langle e_i,e_j\rangle=\delta_{ij}',
    'adapted',
    @source_99,
    'V ist endlichdimensional.',
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

SET @theorem_3225 := (
    SELECT theorem_id FROM theorems WHERE theorem_number='3.2.25' LIMIT 1
);
SET @theorem_3226 := (
    SELECT theorem_id FROM theorems WHERE theorem_number='3.2.26' LIMIT 1
);
SET @theorem_3227 := (
    SELECT theorem_id FROM theorems WHERE theorem_number='3.2.27' LIMIT 1
);
SET @theorem_3228 := (
    SELECT theorem_id FROM theorems WHERE theorem_number='3.2.28' LIMIT 1
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
    '3.2.25-P', @section_id, @theorem_3225, NULL, NULL,
    'Beweis der Projektionszerlegung',
    'Aus I=P+(I-P) folgt v=Pv+(I-P)v. Wegen P(I-P)=P-P²=0 liegt (I-P)v im Kern von P, während Pv im Bild von P liegt. Für eine orthogonale Projektion sind Bild und Kern orthogonal. Die Eindeutigkeit folgt aus dem trivialen Schnitt von Bild und Kern.',
    'I=P+(I-P),\quad P(I-P)=0',
    'direct', 'adapted', @source_100, 'checked', @revision_id
WHERE @theorem_3225 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.25-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.26-P', @section_id, @theorem_3226, NULL, NULL,
    'Beweis der besten Approximation',
    'Für jedes u∈U gilt v-u=(v-Pv)+(Pv-u). Dabei ist v-Pv orthogonal zu U und damit zu Pv-u. Der Satz des Pythagoras liefert ||v-u||²=||v-Pv||²+||Pv-u||²≥||v-Pv||². Gleichheit gilt nur für u=Pv.',
    '\|v-u\|^2=\|v-Pv\|^2+\|Pv-u\|^2',
    'pythagorean', 'adapted', @source_100, 'checked', @revision_id
WHERE @theorem_3226 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.26-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.27-P', @section_id, @theorem_3227, NULL, NULL,
    'Beweis der orthogonalen direkten Summe',
    'Nach dem Projektionssatz besitzt jeder Vektor v eine eindeutige Darstellung v=u+w mit u∈U und w∈U^⊥. Da U∩U^⊥={0} gilt, ist die Summe direkt.',
    'v=u+w,\quad u\in U,\quad w\in U^\perp,\quad U\cap U^\perp=\{0\}',
    'projection', 'adapted', @source_100, 'checked', @revision_id
WHERE @theorem_3227 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.27-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method, provenance,
    source_id, validation_status, created_revision_id
)
SELECT
    '3.2.28-P', @section_id, @theorem_3228, NULL, NULL,
    'Beweis der Existenz einer Orthonormalbasis',
    'Ausgehend von einer beliebigen Basis erzeugt das Gram-Schmidt-Verfahren schrittweise orthogonale, von Null verschiedene Vektoren. Durch Normierung entstehen orthonormale Vektoren, die wegen der Dreiecksstruktur des Verfahrens denselben Raum aufspannen.',
    'e_k=\frac{u_k}{\|u_k\|}',
    'construction', 'adapted', @source_99, 'checked', @revision_id
WHERE @theorem_3228 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number='3.2.28-P'
  );

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.335)-(3.344)
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
    '3.335', @section_id, 'Abbildung einer Projektion',
    'P:V\rightarrow V',
    'P:V\rightarrow V',
    'Die Projektion ist ein linearer Operator auf dem Zustandsraum.',
    'definition', 'adapted', @source_100, NULL,
    'V ist ein Skalarproduktraum.', 'checked', @revision_id
),
(
    '3.336', @section_id, 'Idempotenz der Projektion',
    'P^2=P',
    'P^2=P',
    'Eine erneute Projektion verändert das bereits projizierte Ergebnis nicht.',
    'definition', 'adapted', @source_100, NULL,
    'P ist linear.', 'checked', @revision_id
),
(
    '3.337', @section_id, 'Symmetrie der orthogonalen Projektion',
    'P^T=P',
    'P^T=P',
    'Die Projektionsmatrix ist symmetrisch.',
    'definition', 'adapted', @source_100, NULL,
    'Endlichdimensionale reelle Darstellung.', 'checked', @revision_id
),
(
    '3.338', @section_id, 'Projektionszerlegung',
    'v=Pv+(I-P)v',
    'v=Pv+(I-P)v',
    'Ein Vektor zerfällt in projizierten und orthogonalen Anteil.',
    'theorem', 'adapted', @source_100, NULL,
    'P ist eine orthogonale Projektion.', 'checked', @revision_id
),
(
    '3.339', @section_id, 'Projektionsmatrix',
    'A^2=A',
    'A^2=A',
    'Eine Projektionsmatrix ist idempotent.',
    'definition', 'adapted', @source_100, NULL,
    'A ist quadratisch.', 'checked', @revision_id
),
(
    '3.340', @section_id, 'Symmetrische Projektionsmatrix',
    'A^T=A',
    'A^T=A',
    'Eine orthogonale Projektionsmatrix ist symmetrisch.',
    'definition', 'adapted', @source_100, NULL,
    'A beschreibt eine orthogonale Projektion.', 'checked', @revision_id
),
(
    '3.341', @section_id, 'Beste Approximation',
    '\|v-Pv\|=\min_{u\in U}\|v-u\|',
    '\|v-Pv\|=\min_{u\in U}\|v-u\|',
    'Der projizierte Vektor ist die beste Approximation innerhalb des Unterraums U.',
    'theorem', 'adapted', @source_100, NULL,
    'U ist abgeschlossen.', 'checked', @revision_id
),
(
    '3.342', @section_id, 'Orthogonalkomplement',
    'U^\perp=\{v\in V\mid\langle v,u\rangle=0\ \forall u\in U\}',
    'U^\perp=\{v\in V\mid\langle v,u\rangle=0\ \forall u\in U\}',
    'Das Orthogonalkomplement enthält alle zu U orthogonalen Vektoren.',
    'definition', 'adapted', @source_100, NULL,
    'U ist ein Unterraum von V.', 'checked', @revision_id
),
(
    '3.343', @section_id, 'Orthogonale direkte Summe',
    'V=U\oplus U^\perp',
    'V=U\oplus U^\perp',
    'Der Zustandsraum zerfällt in einen Unterraum und dessen Orthogonalkomplement.',
    'theorem', 'adapted', @source_100, NULL,
    'U ist abgeschlossen.', 'checked', @revision_id
),
(
    '3.344', @section_id, 'Gram-Schmidt-Rekursion',
    'u_k=v_k-\sum_{i=1}^{k-1}\frac{\langle v_k,u_i\rangle}{\langle u_i,u_i\rangle}u_i',
    'u_k=v_k-\sum_{i=1}^{k-1}\frac{\langle v_k,u_i\rangle}{\langle u_i,u_i\rangle}u_i',
    'Die Rekursion entfernt aus v_k sämtliche Komponenten entlang der zuvor konstruierten Richtungen.',
    'definition', 'adapted', @source_99, NULL,
    'v_1,...,v_n sind linear unabhängig.', 'checked', @revision_id
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

SET @eq_3335 := (SELECT equation_id FROM equations WHERE equation_number='3.335' LIMIT 1);
SET @eq_3336 := (SELECT equation_id FROM equations WHERE equation_number='3.336' LIMIT 1);
SET @eq_3337 := (SELECT equation_id FROM equations WHERE equation_number='3.337' LIMIT 1);
SET @eq_3338 := (SELECT equation_id FROM equations WHERE equation_number='3.338' LIMIT 1);
SET @eq_3339 := (SELECT equation_id FROM equations WHERE equation_number='3.339' LIMIT 1);
SET @eq_3340 := (SELECT equation_id FROM equations WHERE equation_number='3.340' LIMIT 1);
SET @eq_3341 := (SELECT equation_id FROM equations WHERE equation_number='3.341' LIMIT 1);
SET @eq_3342 := (SELECT equation_id FROM equations WHERE equation_number='3.342' LIMIT 1);
SET @eq_3343 := (SELECT equation_id FROM equations WHERE equation_number='3.343' LIMIT 1);
SET @eq_3344 := (SELECT equation_id FROM equations WHERE equation_number='3.344' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(
    equation_id,
    symbol_latex,
    symbol_name,
    definition_text,
    symbol_order
)
VALUES
(@eq_3335,'P','Projektionsoperator','Linearer Operator auf V.',1),
(@eq_3335,'V','Zustandsraum','Skalarproduktraum der betrachteten Vektoren.',2),

(@eq_3336,'P^2','Zweifache Projektion','Erneute Anwendung des Projektionsoperators.',1),

(@eq_3337,'P^T','Transponierte Projektion','Transponierte Matrixdarstellung von P.',1),

(@eq_3338,'I','Identitätsoperator','Operator mit I(v)=v.',1),
(@eq_3338,'Pv','Projizierter Anteil','Komponente von v im Bild von P.',2),
(@eq_3338,'(I-P)v','Orthogonaler Rest','Komponente außerhalb des Projektionsraums.',3),

(@eq_3339,'A','Projektionsmatrix','Matrixdarstellung einer Projektion.',1),

(@eq_3340,'A^T','Transponierte Matrix','Transponierte Projektionsmatrix.',1),

(@eq_3341,'U','Projektionsunterraum','Abgeschlossener Unterraum, auf den projiziert wird.',1),
(@eq_3341,'\|\cdot\|','Norm','Abstandsmaß im Skalarproduktraum.',2),

(@eq_3342,'U^\perp','Orthogonalkomplement','Menge aller zu U orthogonalen Vektoren.',1),
(@eq_3342,'\langle\cdot,\cdot\rangle','Skalarprodukt','Orthogonalitätsbeziehung im Raum V.',2),

(@eq_3343,'\oplus','Direkte Summe','Eindeutige Zerlegung ohne nichttrivialen Schnitt.',1),

(@eq_3344,'u_k','Orthogonalisierter Vektor','k-ter im Gram-Schmidt-Verfahren erzeugter Vektor.',1),
(@eq_3344,'v_k','Ausgangsvektor','k-ter Vektor des ursprünglichen linear unabhängigen Systems.',2);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_citation_number', '101')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 101 THEN '101'
        ELSE counter_value
    END;

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('next_equation_number', '3.345')
ON DUPLICATE KEY UPDATE
    counter_value = '3.345';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_completed_section', '3.2.11')
ON DUPLICATE KEY UPDATE
    counter_value = '3.2.11';

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
('last_repository_revision', 'RKB-NEU-K3.2.11-V1')
ON DUPLICATE KEY UPDATE
    counter_value = 'RKB-NEU-K3.2.11-V1';

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
    '3.2.11',
    'Abschnitt 3.2.11 wurde vollständig in das Repository aufgenommen.',
    NULL,
    'Orthogonale Projektionen und funktionale Separation'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND object_reference='3.2.11'
        AND change_type='rewritten'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources', '[98]-[100]',
    'Drei neue Quellen zu Ausdehnungslehre, Orthogonalisierung und Hilbertraumzerlegung wurden aufgenommen.',
    'next_citation_number=98', 'next_citation_number=101'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND object_reference='[98]-[100]'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definitions', '3.2.76-3.2.80',
    'Fünf Definitionen wurden aufgenommen, darunter die FRZK-spezifische funktionale Separation.',
    NULL, '5 Definitionen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND object_reference='3.2.76-3.2.80'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'theorems', '3.2.25-3.2.28',
    'Vier Sätze zu Projektionszerlegung, Approximation, orthogonaler Summe und Orthonormalbasis wurden aufgenommen.',
    NULL, '4 Sätze'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND object_reference='3.2.25-3.2.28'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'proof_added', 'proofs', '3.2.25-P-3.2.28-P',
    'Vier Beweise beziehungsweise Konstruktionsnachweise wurden aufgenommen.',
    NULL, '4 Beweise'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND object_reference='3.2.25-P-3.2.28-P'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations', '(3.335)-(3.344)',
    'Zehn Gleichungen einschließlich Word-LaTeX wurden aufgenommen.',
    NULL, '10 Gleichungen'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM section_change_log
      WHERE revision_id=@revision_id
        AND section_id=@section_id
        AND object_reference='(3.335)-(3.344)'
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
    'K3.2.11_SECTION',
    IF(COUNT(*)=1,'passed','failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.11 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code='3.2.11'
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
    'K3.2.11_NEW_SOURCES',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die neuen Quellen [98] bis [100] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (98,99,100)
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
    'K3.2.11_SOURCE_USAGE',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [98] bis [100] müssen mit Abschnitt 3.2.11 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (98,99,100)
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
    'K3.2.11_DEFINITIONS',
    IF(COUNT(*)=5,'passed','failed'),
    '5',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.76 bis 3.2.80 müssen vollständig vorhanden sein.'
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.76','3.2.77','3.2.78','3.2.79','3.2.80')
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
    'K3.2.11_THEOREMS',
    IF(COUNT(*)=4,'passed','failed'),
    '4',
    CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.25 bis 3.2.28 müssen vollständig vorhanden sein.'
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN ('3.2.25','3.2.26','3.2.27','3.2.28')
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
    'K3.2.11_PROOFS',
    IF(COUNT(*)=4,'passed','failed'),
    '4',
    CAST(COUNT(*) AS CHAR),
    'Die Beweise 3.2.25-P bis 3.2.28-P müssen vorhanden sein.'
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN ('3.2.25-P','3.2.26-P','3.2.27-P','3.2.28-P')
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
    'K3.2.11_EQUATIONS',
    IF(COUNT(*)=10,'passed','failed'),
    '10',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.335) bis (3.344) müssen vollständig vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 335 AND 344
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
    'K3.2.11_WORD_LATEX',
    IF(COUNT(*)=10,'passed','failed'),
    '10',
    CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 335 AND 344
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
    'K3.2.11_PARENT_REVISION',
    IF(parent_revision_id=@parent_revision_id,'passed','failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision muss unmittelbar auf RKB-NEU-K3.2.10-V1 aufbauen.'
FROM repository_revisions
WHERE revision_id=@revision_id
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
WHERE revision_code='RKB-NEU-K3.2.11-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code='3.2.11';

SELECT
    citation_number,
    source_key,
    short_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (98,99,100)
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    provenance,
    validation_status
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.76','3.2.77','3.2.78','3.2.79','3.2.80')
ORDER BY CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED);

SELECT
    theorem_number,
    title,
    validation_status
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN ('3.2.25','3.2.26','3.2.27','3.2.28')
ORDER BY CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED);

SELECT
    proof_number,
    title,
    proof_method,
    validation_status
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN ('3.2.25-P','3.2.26-P','3.2.27-P','3.2.28-P')
ORDER BY proof_number;

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 335 AND 344
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
