/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.7
   Axiom A6 – Funktionale Zustandsbildung

   Enthalten:
   - Revision RKB-NEU-K3.3.7-V1
   - Abschnitt 3.3.7
   - Axiom A6
   - Proposition 3.3.6
   - Gleichungen (3.432)–(3.456)
   - Abhängigkeiten, Symbole, Gleichungssymbole
   - Änderungsprotokoll und Validierungen

   Das Skript ist idempotent und verwendet ausschließlich Spalten
   der vorliegenden FRZK-RKB-Struktur.
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.6-V1'
    LIMIT 1
);

SET @section_33_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.7-V1', NOW(), 'section', '3.3.7', '1.0',
    'Abschnitt 3.3.7: Axiom A6 der funktionalen Zustandsbildung, Proposition 3.3.6 und Gleichungen (3.432) bis (3.456).',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.7-V1'
);

SET @revision_337 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.7-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @section_33_id, '3.3.7', 'Axiom A6 – Funktionale Zustandsbildung',
    3, 3.3070, 'final', 1,
    'Einführung funktionaler Zustände, Zustandsräume, Zulässigkeit, deterministischer und nichtdeterministischer Zustandsbildung sowie tragfähiger Zustände.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.3.7'
);

UPDATE dissertation_sections
SET parent_section_id=@section_33_id,
    title='Axiom A6 – Funktionale Zustandsbildung',
    chapter_no=3,
    section_order=3.3070,
    status='final',
    is_original_contribution=1,
    notes='Einführung funktionaler Zustände, Zustandsräume, Zulässigkeit, deterministischer und nichtdeterministischer Zustandsbildung sowie tragfähiger Zustände.'
WHERE section_code='3.3.7';

SET @section_337_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.3.7' LIMIT 1
);

INSERT INTO axioms
(
    axiom_number, section_id, title, axiom_text,
    formal_latex, word_latex, motivation,
    independence_note, consistency_note, operationalization_note,
    source_assumption_id, status, created_revision_id
)
SELECT
    'A6', @section_337_id, 'Funktionale Zustandsbildung',
    'Jede hinreichend kohärente funktionale Organisation kann mindestens einen bestimmten funktionalen Zustand ausbilden.',
    'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    'Die Kohärenz einer Organisation muss sich in mindestens einer konkret bestimmbaren funktionalen Konfiguration realisieren können.',
    'Axiom A6 ist nicht mit Axiom A5 identisch. Axiom A5 bestimmt die Kohärenzbedingung; Axiom A6 fordert die Ausbildung mindestens eines konkreten Zustands.',
    'Axiom A6 ist mit A1 bis A5 vereinbar und setzt weder Eindeutigkeit noch Determinismus der Zustandsbildung voraus.',
    'Operationalisierung über Zustandsmenge, Zustandsraum, Zulässigkeitsfunktion, Zustandsbildungsfunktion, Wahrscheinlichkeitsverteilung und tragfähige Zustände.',
    NULL, 'accepted', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM axioms WHERE axiom_number='A6');

UPDATE axioms
SET section_id=@section_337_id,
    title='Funktionale Zustandsbildung',
    axiom_text='Jede hinreichend kohärente funktionale Organisation kann mindestens einen bestimmten funktionalen Zustand ausbilden.',
    formal_latex='C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    word_latex='C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    motivation='Die Kohärenz einer Organisation muss sich in mindestens einer konkret bestimmbaren funktionalen Konfiguration realisieren können.',
    independence_note='Axiom A6 ist nicht mit Axiom A5 identisch. Axiom A5 bestimmt die Kohärenzbedingung; Axiom A6 fordert die Ausbildung mindestens eines konkreten Zustands.',
    consistency_note='Axiom A6 ist mit A1 bis A5 vereinbar und setzt weder Eindeutigkeit noch Determinismus der Zustandsbildung voraus.',
    operationalization_note='Operationalisierung über Zustandsmenge, Zustandsraum, Zulässigkeitsfunktion, Zustandsbildungsfunktion, Wahrscheinlichkeitsverteilung und tragfähige Zustände.',
    status='accepted',
    created_revision_id=@revision_337
WHERE axiom_number='A6';

SET @axiom_a5_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A5' LIMIT 1);
SET @axiom_a6_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A6' LIMIT 1);

INSERT INTO axiom_dependencies
(axiom_id, depends_on_axiom_id, dependency_type, note)
SELECT @axiom_a6_id, @axiom_a5_id, 'extends',
       'Axiom A6 erweitert die Kohärenzbedingung um die Möglichkeit konkreter funktionaler Zustandsbildung.'
WHERE @axiom_a6_id IS NOT NULL
  AND @axiom_a5_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM axiom_dependencies
    WHERE axiom_id=@axiom_a6_id
      AND depends_on_axiom_id=@axiom_a5_id
      AND dependency_type='extends'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.432', @section_337_id, 'Funktionale Zustandsmenge',
    '\\mathcal{Z}_F', '\\mathcal{Z}_F',
    'Menge aller funktional zulässigen Zustände einer Organisation.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.432'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Funktionale Zustandsmenge',
    equation_latex='\\mathcal{Z}_F',
    word_latex='\\mathcal{Z}_F',
    plain_description='Menge aller funktional zulässigen Zustände einer Organisation.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.432';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.433', @section_337_id, 'Einzelner funktionaler Zustand',
    'z_F\\in\\mathcal{Z}_F', 'z_F\\in\\mathcal{Z}_F',
    'Ein funktionaler Zustand ist Element der funktionalen Zustandsmenge.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.433'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Einzelner funktionaler Zustand',
    equation_latex='z_F\\in\\mathcal{Z}_F',
    word_latex='z_F\\in\\mathcal{Z}_F',
    plain_description='Ein funktionaler Zustand ist Element der funktionalen Zustandsmenge.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.433';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.434', @section_337_id, 'Allgemeines funktionales Zustandstupel',
    'z_F=\\left(\\mathbf{f},\\mathbf{r},\\mathbf{o},\\mathbf{w}\\right)', 'z_F=\\left(\\mathbf{f},\\mathbf{r},\\mathbf{o},\\mathbf{w}\\right)',
    'Ein funktionaler Zustand umfasst Gehalte, Relationen, Operationen und Gewichtungen.', 'model', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.434'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Allgemeines funktionales Zustandstupel',
    equation_latex='z_F=\\left(\\mathbf{f},\\mathbf{r},\\mathbf{o},\\mathbf{w}\\right)',
    word_latex='z_F=\\left(\\mathbf{f},\\mathbf{r},\\mathbf{o},\\mathbf{w}\\right)',
    plain_description='Ein funktionaler Zustand umfasst Gehalte, Relationen, Operationen und Gewichtungen.',
    equation_type='model',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.434';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.435', @section_337_id, 'Vektor funktionaler Gehalte',
    '\\mathbf{f}=(f_1,\\dots,f_n)', '\\mathbf{f}=(f_1,\\dots,f_n)',
    'Vektor der aktuellen Ausprägungen funktionaler Gehalte.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.435'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Vektor funktionaler Gehalte',
    equation_latex='\\mathbf{f}=(f_1,\\dots,f_n)',
    word_latex='\\mathbf{f}=(f_1,\\dots,f_n)',
    plain_description='Vektor der aktuellen Ausprägungen funktionaler Gehalte.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.435';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.436', @section_337_id, 'Vektor funktionaler Relationen',
    '\\mathbf{r}=(r_1,\\dots,r_m)', '\\mathbf{r}=(r_1,\\dots,r_m)',
    'Vektor der aktuell wirksamen funktionalen Relationen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.436'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Vektor funktionaler Relationen',
    equation_latex='\\mathbf{r}=(r_1,\\dots,r_m)',
    word_latex='\\mathbf{r}=(r_1,\\dots,r_m)',
    plain_description='Vektor der aktuell wirksamen funktionalen Relationen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.436';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.437', @section_337_id, 'Vektor funktionaler Operationen',
    '\\mathbf{o}=(o_1,\\dots,o_p)', '\\mathbf{o}=(o_1,\\dots,o_p)',
    'Vektor der aktuell wirksamen funktionalen Operationen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.437'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Vektor funktionaler Operationen',
    equation_latex='\\mathbf{o}=(o_1,\\dots,o_p)',
    word_latex='\\mathbf{o}=(o_1,\\dots,o_p)',
    plain_description='Vektor der aktuell wirksamen funktionalen Operationen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.437';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.438', @section_337_id, 'Vektor funktionaler Gewichtungen',
    '\\mathbf{w}=(w_1,\\dots,w_q)', '\\mathbf{w}=(w_1,\\dots,w_q)',
    'Vektor der aktuellen funktionalen Gewichtungen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.438'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Vektor funktionaler Gewichtungen',
    equation_latex='\\mathbf{w}=(w_1,\\dots,w_q)',
    word_latex='\\mathbf{w}=(w_1,\\dots,w_q)',
    plain_description='Vektor der aktuellen funktionalen Gewichtungen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.438';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.439', @section_337_id, 'Existenz funktionaler Zustände',
    'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F', 'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    'Axiomatische Verknüpfung hinreichender Kohärenz mit der Existenz eines funktionalen Zustands.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.439'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Existenz funktionaler Zustände',
    equation_latex='C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    word_latex='C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}\\Longrightarrow\\exists z_F\\in\\mathcal{Z}_F',
    plain_description='Axiomatische Verknüpfung hinreichender Kohärenz mit der Existenz eines funktionalen Zustands.',
    equation_type='axiom',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.439';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.440', @section_337_id, 'Nichtleere Zustandsmenge',
    '|\\mathcal{Z}_F|\\geq1', '|\\mathcal{Z}_F|\\geq1',
    'Jede zustandsbildende Organisation besitzt mindestens einen zulässigen Zustand.', 'derived', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.440'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Nichtleere Zustandsmenge',
    equation_latex='|\\mathcal{Z}_F|\\geq1',
    word_latex='|\\mathcal{Z}_F|\\geq1',
    plain_description='Jede zustandsbildende Organisation besitzt mindestens einen zulässigen Zustand.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.440';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.441', @section_337_id, 'Mehrzuständigkeit komplexer Organisationen',
    '|\\mathcal{Z}_F|>1', '|\\mathcal{Z}_F|>1',
    'Komplexe funktionale Organisationen können mehrere zulässige Zustände besitzen.', 'model', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.441'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Mehrzuständigkeit komplexer Organisationen',
    equation_latex='|\\mathcal{Z}_F|>1',
    word_latex='|\\mathcal{Z}_F|>1',
    plain_description='Komplexe funktionale Organisationen können mehrere zulässige Zustände besitzen.',
    equation_type='model',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.441';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.442', @section_337_id, 'Funktionaler Zustandsraum',
    '\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid z_F\\text{ ist mit }\\mathcal{S}\\text{ vereinbar}\\right\\}', '\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid z_F\\text{ ist mit }\\mathcal{S}\\text{ vereinbar}\\right\\}',
    'Menge aller mit einer funktionalen Organisation vereinbaren Zustände.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.442'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Funktionaler Zustandsraum',
    equation_latex='\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid z_F\\text{ ist mit }\\mathcal{S}\\text{ vereinbar}\\right\\}',
    word_latex='\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid z_F\\text{ ist mit }\\mathcal{S}\\text{ vereinbar}\\right\\}',
    plain_description='Menge aller mit einer funktionalen Organisation vereinbaren Zustände.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.442';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.443', @section_337_id, 'Funktionale Zulässigkeitsfunktion',
    '\\Gamma_F:\\mathcal{Z}_F\\rightarrow\\{0,1\\}', '\\Gamma_F:\\mathcal{Z}_F\\rightarrow\\{0,1\\}',
    'Binäre Funktion zur Kennzeichnung zulässiger und unzulässiger funktionaler Zustände.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.443'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Funktionale Zulässigkeitsfunktion',
    equation_latex='\\Gamma_F:\\mathcal{Z}_F\\rightarrow\\{0,1\\}',
    word_latex='\\Gamma_F:\\mathcal{Z}_F\\rightarrow\\{0,1\\}',
    plain_description='Binäre Funktion zur Kennzeichnung zulässiger und unzulässiger funktionaler Zustände.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.443';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.444', @section_337_id, 'Zulässiger funktionaler Zustand',
    '\\Gamma_F(z_F)=1', '\\Gamma_F(z_F)=1',
    'Kennzeichnung eines zulässigen funktionalen Zustands.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.444'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Zulässiger funktionaler Zustand',
    equation_latex='\\Gamma_F(z_F)=1',
    word_latex='\\Gamma_F(z_F)=1',
    plain_description='Kennzeichnung eines zulässigen funktionalen Zustands.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.444';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.445', @section_337_id, 'Unzulässiger funktionaler Zustand',
    '\\Gamma_F(z_F)=0', '\\Gamma_F(z_F)=0',
    'Kennzeichnung eines unzulässigen funktionalen Zustands.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.445'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Unzulässiger funktionaler Zustand',
    equation_latex='\\Gamma_F(z_F)=0',
    word_latex='\\Gamma_F(z_F)=0',
    plain_description='Kennzeichnung eines unzulässigen funktionalen Zustands.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.445';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.446', @section_337_id, 'Zustandsraum über Zulässigkeit',
    '\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid\\Gamma_F(z_F)=1\\right\\}', '\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid\\Gamma_F(z_F)=1\\right\\}',
    'Äquivalente Definition des Zustandsraums über die Zulässigkeitsfunktion.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.446'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Zustandsraum über Zulässigkeit',
    equation_latex='\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid\\Gamma_F(z_F)=1\\right\\}',
    word_latex='\\Omega_F(\\mathcal{S})=\\left\\{z_F\\in\\mathcal{Z}_F\\mid\\Gamma_F(z_F)=1\\right\\}',
    plain_description='Äquivalente Definition des Zustandsraums über die Zulässigkeitsfunktion.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.446';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.447', @section_337_id, 'Deterministische Zustandsbildungsfunktion',
    '\\Phi_F:\\mathcal{S}\\rightarrow\\Omega_F(\\mathcal{S})', '\\Phi_F:\\mathcal{S}\\rightarrow\\Omega_F(\\mathcal{S})',
    'Abbildung einer Organisation auf einen funktionalen Zustand.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.447'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Deterministische Zustandsbildungsfunktion',
    equation_latex='\\Phi_F:\\mathcal{S}\\rightarrow\\Omega_F(\\mathcal{S})',
    word_latex='\\Phi_F:\\mathcal{S}\\rightarrow\\Omega_F(\\mathcal{S})',
    plain_description='Abbildung einer Organisation auf einen funktionalen Zustand.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.447';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.448', @section_337_id, 'Deterministische Zustandszuordnung',
    '\\Phi_F(\\mathcal{S})=z_F', '\\Phi_F(\\mathcal{S})=z_F',
    'Im deterministischen Fall wird genau ein funktionaler Zustand zugeordnet.', 'model', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.448'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Deterministische Zustandszuordnung',
    equation_latex='\\Phi_F(\\mathcal{S})=z_F',
    word_latex='\\Phi_F(\\mathcal{S})=z_F',
    plain_description='Im deterministischen Fall wird genau ein funktionaler Zustand zugeordnet.',
    equation_type='model',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.448';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.449', @section_337_id, 'Nichtdeterministische Zustandsbildung',
    '\\Phi_F(\\mathcal{S})\\subseteq\\Omega_F(\\mathcal{S})', '\\Phi_F(\\mathcal{S})\\subseteq\\Omega_F(\\mathcal{S})',
    'Im nichtdeterministischen Fall bezeichnet Phi_F eine Menge möglicher Zustände.', 'model', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.449'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Nichtdeterministische Zustandsbildung',
    equation_latex='\\Phi_F(\\mathcal{S})\\subseteq\\Omega_F(\\mathcal{S})',
    word_latex='\\Phi_F(\\mathcal{S})\\subseteq\\Omega_F(\\mathcal{S})',
    plain_description='Im nichtdeterministischen Fall bezeichnet Phi_F eine Menge möglicher Zustände.',
    equation_type='model',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.449';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.450', @section_337_id, 'Mehrere mögliche Zustände',
    '|\\Phi_F(\\mathcal{S})|>1', '|\\Phi_F(\\mathcal{S})|>1',
    'Die Zustandsbildungsfunktion liefert mehr als einen möglichen Zustand.', 'model', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.450'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Mehrere mögliche Zustände',
    equation_latex='|\\Phi_F(\\mathcal{S})|>1',
    word_latex='|\\Phi_F(\\mathcal{S})|>1',
    plain_description='Die Zustandsbildungsfunktion liefert mehr als einen möglichen Zustand.',
    equation_type='model',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.450';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.451', @section_337_id, 'Wahrscheinlichkeitsfunktion über Zustände',
    'P_F:\\Omega_F(\\mathcal{S})\\rightarrow[0,1]', 'P_F:\\Omega_F(\\mathcal{S})\\rightarrow[0,1]',
    'Wahrscheinlichkeitszuordnung für zulässige funktionale Zustände.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.451'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Wahrscheinlichkeitsfunktion über Zustände',
    equation_latex='P_F:\\Omega_F(\\mathcal{S})\\rightarrow[0,1]',
    word_latex='P_F:\\Omega_F(\\mathcal{S})\\rightarrow[0,1]',
    plain_description='Wahrscheinlichkeitszuordnung für zulässige funktionale Zustände.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.451';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.452', @section_337_id, 'Normierung der Zustandswahrscheinlichkeiten',
    '\\sum_{z_F\\in\\Omega_F(\\mathcal{S})}P_F(z_F)=1', '\\sum_{z_F\\in\\Omega_F(\\mathcal{S})}P_F(z_F)=1',
    'Die Wahrscheinlichkeiten aller zulässigen Zustände summieren sich zu eins.', 'derived', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.452'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Normierung der Zustandswahrscheinlichkeiten',
    equation_latex='\\sum_{z_F\\in\\Omega_F(\\mathcal{S})}P_F(z_F)=1',
    word_latex='\\sum_{z_F\\in\\Omega_F(\\mathcal{S})}P_F(z_F)=1',
    plain_description='Die Wahrscheinlichkeiten aller zulässigen Zustände summieren sich zu eins.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.452';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.453', @section_337_id, 'Kohärenzwert eines Zustands',
    'C_F(z_F)\\in[0,1]', 'C_F(z_F)\\in[0,1]',
    'Jedem funktionalen Zustand wird ein normierter Kohärenzwert zugeordnet.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.453'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Kohärenzwert eines Zustands',
    equation_latex='C_F(z_F)\\in[0,1]',
    word_latex='C_F(z_F)\\in[0,1]',
    plain_description='Jedem funktionalen Zustand wird ein normierter Kohärenzwert zugeordnet.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.453';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.454', @section_337_id, 'Tragfähiger funktionaler Zustand',
    'C_F(z_F)\\geq C_{\\mathrm{krit}}', 'C_F(z_F)\\geq C_{\\mathrm{krit}}',
    'Ein Zustand ist funktional tragfähig, wenn er die kritische Kohärenzschwelle erreicht.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.454'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Tragfähiger funktionaler Zustand',
    equation_latex='C_F(z_F)\\geq C_{\\mathrm{krit}}',
    word_latex='C_F(z_F)\\geq C_{\\mathrm{krit}}',
    plain_description='Ein Zustand ist funktional tragfähig, wenn er die kritische Kohärenzschwelle erreicht.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.454';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.455', @section_337_id, 'Menge tragfähiger Zustände',
    '\\Omega_F^{+}(\\mathcal{S})=\\left\\{z_F\\in\\Omega_F(\\mathcal{S})\\mid C_F(z_F)\\geq C_{\\mathrm{krit}}\\right\\}', '\\Omega_F^{+}(\\mathcal{S})=\\left\\{z_F\\in\\Omega_F(\\mathcal{S})\\mid C_F(z_F)\\geq C_{\\mathrm{krit}}\\right\\}',
    'Teilmenge aller zulässigen Zustände, die funktional tragfähig sind.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.455'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Menge tragfähiger Zustände',
    equation_latex='\\Omega_F^{+}(\\mathcal{S})=\\left\\{z_F\\in\\Omega_F(\\mathcal{S})\\mid C_F(z_F)\\geq C_{\\mathrm{krit}}\\right\\}',
    word_latex='\\Omega_F^{+}(\\mathcal{S})=\\left\\{z_F\\in\\Omega_F(\\mathcal{S})\\mid C_F(z_F)\\geq C_{\\mathrm{krit}}\\right\\}',
    plain_description='Teilmenge aller zulässigen Zustände, die funktional tragfähig sind.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.455';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.456', @section_337_id, 'Existenz eines tragfähigen Zustands',
    'z_F\\in\\Omega_F^{+}(\\mathcal{S})', 'z_F\\in\\Omega_F^{+}(\\mathcal{S})',
    'Proposition 3.3.6: Eine hinreichend kohärente Organisation besitzt mindestens einen tragfähigen Zustand.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.7.',
    'Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    'checked', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.456'
);

UPDATE equations
SET section_id=@section_337_id,
    title='Existenz eines tragfähigen Zustands',
    equation_latex='z_F\\in\\Omega_F^{+}(\\mathcal{S})',
    word_latex='z_F\\in\\Omega_F^{+}(\\mathcal{S})',
    plain_description='Proposition 3.3.6: Eine hinreichend kohärente Organisation besitzt mindestens einen tragfähigen Zustand.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Formalisierung in Abschnitt 3.3.7.',
    assumptions='Axiome A1 bis A6 und die zuvor eingeführte funktionale Kohärenz.',
    validation_status='checked',
    created_revision_id=@revision_337
WHERE equation_number='3.456';

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.6', @section_337_id,
    'Zustandsbildung konkretisiert funktionale Organisation',
    'Sei S eine hinreichend kohärente funktionale Organisation. Dann existiert mindestens ein funktional tragfähiger Zustand z_F in Omega_F plus von S.',
    'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\exists z_F\in\Omega_F^{+}(\mathcal{S})',
    'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\exists z_F\in\Omega_F^{+}(\mathcal{S})',
    'Aus Axiom A5 folgt die hinreichende Kohärenz der Organisation. Axiom A6 fordert für eine solche Organisation die Ausbildung mindestens eines konkreten Zustands. Die Tragfähigkeitsbedingung grenzt die kohärent fortsetzbaren Zustände ein.',
    'A5,A6', 'accepted', @revision_337
WHERE @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM propositions WHERE proposition_number='3.3.6'
);

UPDATE propositions
SET section_id=@section_337_id,
    title='Zustandsbildung konkretisiert funktionale Organisation',
    statement_text='Sei S eine hinreichend kohärente funktionale Organisation. Dann existiert mindestens ein funktional tragfähiger Zustand z_F in Omega_F plus von S.',
    statement_latex='C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\exists z_F\in\Omega_F^{+}(\mathcal{S})',
    word_latex='C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\exists z_F\in\Omega_F^{+}(\mathcal{S})',
    logical_derivation='Aus Axiom A5 folgt die hinreichende Kohärenz der Organisation. Axiom A6 fordert für eine solche Organisation die Ausbildung mindestens eines konkreten Zustands. Die Tragfähigkeitsbedingung grenzt die kohärent fortsetzbaren Zustände ein.',
    based_on_axioms='A5,A6',
    status='accepted',
    created_revision_id=@revision_337
WHERE proposition_number='3.3.6';

SET @prop_336_id :=
(
    SELECT proposition_id FROM propositions
    WHERE proposition_number='3.3.6' LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_336_id, @axiom_a5_id, NULL, 'uses',
       'Die Proposition verwendet die kritische Kohärenzbedingung aus Axiom A5.'
WHERE @prop_336_id IS NOT NULL AND @axiom_a5_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_336_id
      AND axiom_id=@axiom_a5_id
      AND dependency_type='uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_336_id, @axiom_a6_id, NULL, 'derived_from',
       'Die Existenz eines konkreten Zustands folgt aus Axiom A6.'
WHERE @prop_336_id IS NOT NULL AND @axiom_a6_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_336_id
      AND axiom_id=@axiom_a6_id
      AND dependency_type='derived_from'
);

/* Symbolregistrierung */
SET @eq_3432 := (SELECT equation_id FROM equations WHERE equation_number='3.432' LIMIT 1);
SET @eq_3433 := (SELECT equation_id FROM equations WHERE equation_number='3.433' LIMIT 1);
SET @eq_3442 := (SELECT equation_id FROM equations WHERE equation_number='3.442' LIMIT 1);
SET @eq_3443 := (SELECT equation_id FROM equations WHERE equation_number='3.443' LIMIT 1);
SET @eq_3447 := (SELECT equation_id FROM equations WHERE equation_number='3.447' LIMIT 1);
SET @eq_3451 := (SELECT equation_id FROM equations WHERE equation_number='3.451' LIMIT 1);
SET @eq_3455 := (SELECT equation_id FROM equations WHERE equation_number='3.455' LIMIT 1);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT '\mathcal{Z}_F','\mathcal{Z}_F','funktionale Zustandsmenge',
       'Menge aller funktional zulässigen Zustände einer Organisation.',
       'chapter',@section_337_id,@eq_3432,NULL,NULL,NULL,0,0,0,
       'In Abschnitt 3.3.7 eingeführt.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\mathcal{Z}_F'
      AND symbol_name='funktionale Zustandsmenge'
);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT 'z_F','z_F','funktionaler Zustand',
       'Konkrete funktionale Konfiguration innerhalb des Zustandsraums.',
       'chapter',@section_337_id,@eq_3433,NULL,NULL,NULL,0,0,0,
       'In Abschnitt 3.3.7 eingeführt.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='z_F'
      AND symbol_name='funktionaler Zustand'
);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT '\Omega_F','\Omega_F','funktionaler Zustandsraum',
       'Menge aller mit einer Organisation vereinbaren funktionalen Zustände.',
       'chapter',@section_337_id,@eq_3442,NULL,NULL,NULL,0,0,0,
       'Nicht mit älteren historischen Zustandsraumsymbolen gleichzusetzen.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\Omega_F'
      AND symbol_name='funktionaler Zustandsraum'
);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT '\Gamma_F','\Gamma_F','funktionale Zulässigkeitsfunktion',
       'Binäre Funktion zur Prüfung der Zulässigkeit funktionaler Zustände.',
       'chapter',@section_337_id,@eq_3443,NULL,'\mathcal{Z}_F','\{0,1\}',0,0,1,
       'In Abschnitt 3.3.7 eingeführt.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='\Gamma_F'
);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT '\Phi_F','\Phi_F','funktionale Zustandsbildungsfunktion',
       'Zuordnung einer funktionalen Organisation zu einem oder mehreren zulässigen Zuständen.',
       'chapter',@section_337_id,@eq_3447,NULL,'\mathcal{S}','\Omega_F(\mathcal{S})',0,0,1,
       'Kann deterministisch oder nichtdeterministisch interpretiert werden.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='\Phi_F'
);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT 'P_F','P_F','Zustandswahrscheinlichkeit',
       'Wahrscheinlichkeitsfunktion über dem funktionalen Zustandsraum.',
       'chapter',@section_337_id,@eq_3451,NULL,'\Omega_F(\mathcal{S})','[0,1]',0,0,1,
       'Optionale stochastische Erweiterung der Zustandsbildung.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='P_F'
      AND symbol_name='Zustandswahrscheinlichkeit'
);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text,
 scope_type, first_section_id, first_equation_id, unit_text,
 domain_text, codomain_text, is_vector, is_matrix, is_operator,
 notes, validation_status, created_revision_id)
SELECT '\Omega_F^{+}','\Omega_F^{+}','Menge tragfähiger funktionaler Zustände',
       'Teilmenge der zulässigen Zustände oberhalb der kritischen Kohärenzschwelle.',
       'chapter',@section_337_id,@eq_3455,NULL,NULL,NULL,0,0,0,
       'In Abschnitt 3.3.7 eingeführt.','checked',@revision_337
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='\Omega_F^{+}'
);

/* Ausgewählte Gleichungssymbole */
INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3432,'\mathcal{Z}_F','funktionale Zustandsmenge',
       'Menge aller funktional zulässigen Zustände.',NULL,NULL,1
WHERE @eq_3432 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3432 AND symbol_latex='\mathcal{Z}_F'
);

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3442,'\Omega_F','funktionaler Zustandsraum',
       'Menge der mit einer Organisation vereinbaren Zustände.',NULL,NULL,1
WHERE @eq_3442 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3442 AND symbol_latex='\Omega_F'
);

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3443,'\Gamma_F','funktionale Zulässigkeitsfunktion',
       'Binäre Zulässigkeitsprüfung.',NULL,'\mathcal{Z}_F',1
WHERE @eq_3443 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3443 AND symbol_latex='\Gamma_F'
);

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3447,'\Phi_F','funktionale Zustandsbildungsfunktion',
       'Zuordnung möglicher funktionaler Zustände.',NULL,'\mathcal{S}',1
WHERE @eq_3447 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3447 AND symbol_latex='\Phi_F'
);

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3451,'P_F','Zustandswahrscheinlichkeit',
       'Wahrscheinlichkeit eines funktionalen Zustands.',NULL,'\Omega_F(\mathcal{S})',1
WHERE @eq_3451 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3451 AND symbol_latex='P_F'
);

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value)
SELECT @revision_337,@section_337_id,'created','section','3.3.7',
       'Abschnitt 3.3.7 vollständig angelegt.',NULL,
       'Axiom A6 – Funktionale Zustandsbildung'
WHERE @revision_337 IS NOT NULL AND @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_337
      AND object_type='section'
      AND object_reference='3.3.7'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value)
SELECT @revision_337,@section_337_id,'axiom_added','axiom','A6',
       'Axiom A6 der funktionalen Zustandsbildung registriert.',NULL,
       'A6 – Funktionale Zustandsbildung'
WHERE @revision_337 IS NOT NULL AND @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_337
      AND object_type='axiom'
      AND object_reference='A6'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value)
SELECT @revision_337,@section_337_id,'proposition_added','proposition','3.3.6',
       'Proposition 3.3.6 registriert.',NULL,
       'Zustandsbildung konkretisiert funktionale Organisation'
WHERE @revision_337 IS NOT NULL AND @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_337
      AND object_type='proposition'
      AND object_reference='3.3.6'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value)
SELECT @revision_337,@section_337_id,'equation_added','equation','(3.432)–(3.456)',
       '25 Gleichungen zur funktionalen Zustandsbildung registriert.',NULL,
       'Gleichungen (3.432) bis (3.456)'
WHERE @revision_337 IS NOT NULL AND @section_337_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_337
      AND object_type='equation'
      AND object_reference='(3.432)–(3.456)'
);

/* Validierungen mit CONCAT-Konvertierung */
SET @equation_count_337 :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
      '3.432','3.433','3.434','3.435','3.436','3.437','3.438','3.439','3.440',
      '3.441','3.442','3.443','3.444','3.445','3.446','3.447','3.448','3.449',
      '3.450','3.451','3.452','3.453','3.454','3.455','3.456'
    )
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,
 expected_value,actual_value,validation_message)
SELECT @revision_337,'K3.3.7.SECTION',
       CASE WHEN @section_337_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
       '1',
       CASE WHEN @section_337_id IS NOT NULL THEN '1' ELSE '0' END,
       'Prüfung, ob Abschnitt 3.3.7 vorhanden ist.'
WHERE @revision_337 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_337
      AND validation_code='K3.3.7.SECTION'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,
 expected_value,actual_value,validation_message)
SELECT @revision_337,'K3.3.7.EQUATIONS',
       CASE WHEN @equation_count_337=25 THEN 'passed' ELSE 'failed' END,
       '25',CONCAT(@equation_count_337,''),
       'Prüfung der Gleichungen (3.432) bis (3.456).'
WHERE @revision_337 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_337
      AND validation_code='K3.3.7.EQUATIONS'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,
 expected_value,actual_value,validation_message)
SELECT @revision_337,'K3.3.7.AXIOM_A6',
       CASE WHEN @axiom_a6_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
       '1',
       CASE WHEN @axiom_a6_id IS NOT NULL THEN '1' ELSE '0' END,
       'Prüfung von Axiom A6.'
WHERE @revision_337 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_337
      AND validation_code='K3.3.7.AXIOM_A6'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,
 expected_value,actual_value,validation_message)
SELECT @revision_337,'K3.3.7.PROPOSITION',
       CASE WHEN @prop_336_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
       '1',
       CASE WHEN @prop_336_id IS NOT NULL THEN '1' ELSE '0' END,
       'Prüfung von Proposition 3.3.6.'
WHERE @revision_337 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_337
      AND validation_code='K3.3.7.PROPOSITION'
);

COMMIT;

/* Abschlusskontrollen */
SELECT
    CASE
      WHEN @section_33_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
      WHEN @revision_337 IS NULL
        THEN 'FEHLER: Revision RKB-NEU-K3.3.7-V1 fehlt.'
      WHEN @section_337_id IS NULL
        THEN 'FEHLER: Abschnitt 3.3.7 fehlt.'
      WHEN @axiom_a6_id IS NULL
        THEN 'FEHLER: Axiom A6 fehlt.'
      WHEN @prop_336_id IS NULL
        THEN 'FEHLER: Proposition 3.3.6 fehlt.'
      WHEN @equation_count_337<>25
        THEN CONCAT('FEHLER: Es wurden ',@equation_count_337,' statt 25 Gleichungen gefunden.')
      ELSE 'OK: Repository-Update 3.3.7 vollständig ausgeführt.'
    END AS import_status;

SELECT rr.revision_code,ds.section_code,ds.title,ds.status,
       @equation_count_337 AS equation_count
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code=rr.scope_reference
WHERE rr.revision_code='RKB-NEU-K3.3.7-V1';

SELECT equation_number,title,equation_type,validation_status
FROM equations
WHERE equation_number IN
(
  '3.432','3.433','3.434','3.435','3.436','3.437','3.438','3.439','3.440',
  '3.441','3.442','3.443','3.444','3.445','3.446','3.447','3.448','3.449',
  '3.450','3.451','3.452','3.453','3.454','3.455','3.456'
)
ORDER BY equation_number;

SELECT validation_code,validation_status,expected_value,
       actual_value,validation_message
FROM repository_validation_results
WHERE revision_id=@revision_337
ORDER BY validation_code;
