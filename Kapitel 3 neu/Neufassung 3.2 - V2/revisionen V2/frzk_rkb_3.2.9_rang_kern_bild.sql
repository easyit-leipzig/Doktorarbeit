-- ---------------------------------------------------------------------
-- FRZK-REPOSITORY-UPDATE
-- Kapitel 3.2.9: Rang, Kern und Bild linearer Abbildungen
-- Grundlage: Repository-Stand nach Abschnitt 3.2.8
-- MariaDB 10.4 / MySQL-kompatibel
-- ---------------------------------------------------------------------

START TRANSACTION;

SET @parent_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2'
    LIMIT 1
);

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.8-V1'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.2.9-V1',
    NOW(),
    'section',
    '3.2.9',
    '3.2.9-v1',
    'Aufnahme von Abschnitt 3.2.9 mit den Definitionen 3.2.23 bis 3.2.25 und den Gleichungen (3.205) bis (3.228).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_section_id IS NOT NULL
  AND @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM repository_revisions
      WHERE revision_code='RKB-NEU-K3.2.9-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.9-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no, section_order,
    status, is_original_contribution, notes
)
SELECT
    @parent_section_id,
    '3.2.9',
    'Rang, Kern und Bild linearer Abbildungen',
    3,
    3.2900,
    'final',
    0,
    'Definitionen 3.2.23 bis 3.2.25; Gleichungen (3.205) bis (3.228); Quellen [71], [74] und [82].'
WHERE NOT EXISTS (
    SELECT 1 FROM dissertation_sections WHERE section_code='3.2.9'
);

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.9'
    LIMIT 1
);

UPDATE dissertation_sections
SET
    parent_section_id=@parent_section_id,
    title='Rang, Kern und Bild linearer Abbildungen',
    chapter_no=3,
    section_order=3.2900,
    status='final',
    is_original_contribution=0,
    notes='Definitionen 3.2.23 bis 3.2.25; Gleichungen (3.205) bis (3.228); Quellen [71], [74] und [82].'
WHERE section_id=@section_id;

-- Definitionen 3.2.23 bis 3.2.25

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text, formal_latex,
    word_latex, provenance, source_id, assumptions, notes,
    validation_status, created_revision_id
)
SELECT
    '3.2.23', @section_id, 'Bild einer linearen Abbildung', 'Das Bild einer linearen Abbildung T:V→W ist die Menge aller Vektoren des Zielraums, die als T(v) für mindestens ein v aus V entstehen.',
    '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', 'adapted',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Lineare Abbildungen und endlichdimensionale Vektorräume sind definiert.',
    'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.23'
);

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text, formal_latex,
    word_latex, provenance, source_id, assumptions, notes,
    validation_status, created_revision_id
)
SELECT
    '3.2.24', @section_id, 'Kern einer linearen Abbildung', 'Der Kern einer linearen Abbildung T:V→W ist die Menge aller Vektoren des Definitionsbereichs, die auf den Nullvektor des Zielraums abgebildet werden.',
    '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', 'adapted',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Lineare Abbildungen und endlichdimensionale Vektorräume sind definiert.',
    'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.24'
);

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text, formal_latex,
    word_latex, provenance, source_id, assumptions, notes,
    validation_status, created_revision_id
)
SELECT
    '3.2.25', @section_id, 'Rang einer linearen Abbildung', 'Der Rang einer linearen Abbildung ist die Dimension ihres Bildes.',
    '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', 'adapted',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Lineare Abbildungen und endlichdimensionale Vektorräume sind definiert.',
    'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.25'
);


-- Gleichungen (3.205) bis (3.228)

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.205', @section_id, 'Lineare Abbildung zwischen Vektorräumen', 'T:V\\rightarrow W', 'T:V\\rightarrow W',
    'Lineare Abbildung vom Vektorraum V in den Vektorraum W.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.205'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.206', @section_id, 'Bild einer linearen Abbildung', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}',
    'Menge aller durch T erreichbaren Vektoren im Zielraum.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.206'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.207', @section_id, 'Kern einer linearen Abbildung', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}',
    'Menge aller Vektoren, die auf den Nullvektor abgebildet werden.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.207'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.208', @section_id, 'Rang einer linearen Abbildung', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))',
    'Der Rang ist die Dimension des Bildraums.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.208'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.209', @section_id, 'Rang einer Matrix', '\\operatorname{rang}(A)', '\\operatorname{rang}(A)',
    'Notation des Rangs einer Matrix.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.209'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.210', @section_id, 'Rechteckige Matrix', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}',
    'Allgemeine reelle m-mal-n-Matrix.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.210'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.211', @section_id, 'Gleichheit von Spalten- und Zeilenrang', '\\operatorname{Spaltenrang}(A)=\\operatorname{Zeilenrang}(A)', '\\operatorname{Spaltenrang}(A)=\\operatorname{Zeilenrang}(A)',
    'Spaltenrang und Zeilenrang einer Matrix stimmen überein.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.211'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.212', @section_id, 'Beispielmatrix', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}',
    'Beispiel einer Matrix mit linear abhängigen Spalten.', 'example', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.212'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.213', @section_id, 'Abhängigkeit der Spalten', '\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}', '\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}',
    'Die zweite Spalte ist ein skalares Vielfaches der ersten.', 'example', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.213'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.214', @section_id, 'Rang der Beispielmatrix', '\\operatorname{rang}(A)=1', '\\operatorname{rang}(A)=1',
    'Die Beispielmatrix besitzt genau eine unabhängige Spaltenrichtung.', 'example', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.214'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.215', @section_id, 'Allgemeine Matrix für vollen Rang', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}',
    'Allgemeine Matrix zur Formulierung der Rangschranke.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.215'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.216', @section_id, 'Rangschranke', '\\operatorname{rang}(A)\\le\\min(m,n)', '\\operatorname{rang}(A)\\le\\min(m,n)',
    'Der Rang ist höchstens so groß wie die kleinere Matrixdimension.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.216'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.217', @section_id, 'Voller Rang einer quadratischen Matrix', '\\operatorname{rang}(A)=n', '\\operatorname{rang}(A)=n',
    'Bedingung für vollen Rang bei einer n-mal-n-Matrix.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.217'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.218', @section_id, 'Determinantenkriterium', '\\det(A)\\neq0', '\\det(A)\\neq0',
    'Nichtverschwindende Determinante als Äquivalent zu vollem Rang.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.218'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.219', @section_id, 'Lineare Abbildung für den Dimensionssatz', 'T:V\\rightarrow W', 'T:V\\rightarrow W',
    'Lineare Abbildung mit endlichdimensionalem Definitionsbereich.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.219'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.220', @section_id, 'Dimensionssatz', '\\dim(V)=\\dim(\\ker(T))+\\operatorname{rang}(T)', '\\dim(V)=\\dim(\\ker(T))+\\operatorname{rang}(T)',
    'Rang-Nullitätssatz für lineare Abbildungen.', 'theorem', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.220'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.221', @section_id, 'Beispielmatrix zum Dimensionssatz', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}',
    'Erneute Verwendung der singulären Beispielmatrix.', 'example', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.221'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.222', @section_id, 'Rang im Dimensionsbeispiel', '\\operatorname{rang}(A)=1', '\\operatorname{rang}(A)=1',
    'Rang der Beispielmatrix.', 'example', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.222'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.223', @section_id, 'Dimension des Definitionsbereichs', '\\dim(\\mathbb{R}^2)=2', '\\dim(\\mathbb{R}^2)=2',
    'Dimension des zweidimensionalen Definitionsbereichs.', 'example', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.223'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.224', @section_id, 'Dimension des Kerns', '\\dim(\\ker(A))=1', '\\dim(\\ker(A))=1',
    'Aus dem Dimensionssatz abgeleitete Kerndimension.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.224'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.225', @section_id, 'Lineares Gleichungssystem', 'Ax=b', 'Ax=b',
    'Matrixdarstellung eines linearen Gleichungssystems.', 'definition', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.225'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.226', @section_id, 'Bedingung für eindeutige Lösung', '\\operatorname{rang}(A)=n', '\\operatorname{rang}(A)=n',
    'Voller Spaltenrang als Bedingung für Eindeutigkeit im quadratischen Fall.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.226'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.227', @section_id, 'Rangdefizit', '\\operatorname{rang}(A)<n', '\\operatorname{rang}(A)<n',
    'Bedingung für fehlende Eindeutigkeit.', 'derived', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.227'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id, derivation,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.228', @section_id, 'Äquivalenzen für quadratische Matrizen', '\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff\\ker(A)=\\{0\\}', '\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff\\ker(A)=\\{0\\}',
    'Zusammenhang zwischen Determinante, Rang und trivialem Kern.', 'theorem', 'literature',
    (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
    'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.',
    'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.',
    'verified', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.228'
);


INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    CASE
        WHEN s.citation_number=74 THEN 'example'
        ELSE 'definition'
    END,
    CASE s.citation_number
        WHEN 71 THEN 'Lang stützt die Definitionen von Bild, Kern und Rang sowie den Rang-Nullitätssatz.'
        WHEN 74 THEN 'Strang stützt die Matrixbeispiele, Rangberechnung und geometrische Interpretation.'
        WHEN 82 THEN 'Halmos stützt die abstrakte Einordnung linearer Abbildungen und ihrer Unterräume.'
    END,
    'Abschnitt 3.2.9',
    0,
    1,
    CONCAT('Wiederverwendung der Literaturstelle [', s.citation_number, '].'),
    @revision_id
FROM sources s
WHERE s.citation_number IN (71,74,82)
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
VALUES
(
    @revision_id, @section_id, 'created', 'section', '3.2.9',
    'Abschnitt 3.2.9 wurde angelegt und finalisiert.',
    NULL,
    'Definitionen 3.2.23 bis 3.2.25; Gleichungen (3.205) bis (3.228).'
),
(
    @revision_id, @section_id, 'definition_added', 'definition', '3.2.23–3.2.25',
    'Drei Definitionen wurden aufgenommen.',
    'Letzte Definition: 3.2.22.',
    'Letzte Definition: 3.2.25.'
),
(
    @revision_id, @section_id, 'equation_added', 'equation', '(3.205)–(3.228)',
    'Vierundzwanzig Gleichungen wurden aufgenommen.',
    'Letzte Gleichung: (3.204).',
    'Letzte Gleichung: (3.228).'
),
(
    @revision_id, @section_id, 'source_reused', 'source', '[71], [74], [82]',
    'Vorhandene Literaturstellen wurden verknüpft.',
    'Letzte Literaturstelle: [83].',
    'Letzte Literaturstelle bleibt [83].'
);

INSERT INTO repository_counters(counter_key, counter_value)
VALUES
('current_section','3.2.10'),
('last_completed_section','3.2.9'),
('last_definition_number','3.2.25'),
('next_definition_number','3.2.26'),
('last_equation_number','3.228'),
('next_equation_number','3.229'),
('last_citation_number','83'),
('next_citation_number','84')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

COMMIT;

-- Abschlussaudit
SELECT
    @revision_id AS revision_id,
    @section_id AS section_id,
    (SELECT COUNT(*) FROM definitions WHERE section_id=@section_id) AS definitions_count,
    (SELECT COUNT(*) FROM equations WHERE section_id=@section_id) AS equations_count,
    (SELECT COUNT(*) FROM source_usage WHERE section_id=@section_id) AS source_usage_count,
    (SELECT counter_value FROM repository_counters WHERE counter_key='next_definition_number') AS next_definition_number,
    (SELECT counter_value FROM repository_counters WHERE counter_key='next_equation_number') AS next_equation_number,
    (SELECT counter_value FROM repository_counters WHERE counter_key='next_citation_number') AS next_citation_number;
