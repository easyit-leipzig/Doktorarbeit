/* ============================================================================
   FRZK-RKB – Repository-Update 3.3.9.6

   Abschnitt:
     3.3.9.6 Metatheoretischer Abschluss des Axiomensystems

   Ausgangsstand:
     frzk_rkb_3.3.9.5.sql

   Elternrevision:
     RKB-NEU-K3.3.9.5-V1

   Registriert:
     - Revision RKB-NEU-K3.3.9.6-V1
     - Abschnitt 3.3.9.6
     - Proposition 3.3.13
     - Gleichungen (3.589) bis (3.618)
     - Axiomabhängigkeiten A1 bis A7
     - zentrale neue Symbole
     - Gleichung-Symbol-Zuordnungen
     - Änderungsprotokoll
     - Repository-Validierungen

   Eigenschaften:
     - idempotent
     - lookup-basiert
     - fremdschlüsselsicher
     - transaktionsgeschützt
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_3396 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.5-V1'
    LIMIT 1
);

SET @parent_section_3396 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9'
    LIMIT 1
);

SET @precondition_ok_3396 := (
    @parent_revision_3396 IS NOT NULL
    AND @parent_section_3396 IS NOT NULL
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.9.6-V1',
    NOW(),
    'section',
    '3.3.9.6',
    '1.0',
    'Abschnitt 3.3.9.6: Metatheoretischer Abschluss des Axiomensystems; Proposition 3.3.13; Gleichungen (3.589) bis (3.618).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_3396
WHERE @precondition_ok_3396 = 1
AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.6-V1'
);

SET @revision_3396 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.6-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @parent_section_3396,
    '3.3.9.6',
    'Metatheoretischer Abschluss des Axiomensystems',
    3,
    3.3096,
    'final',
    1,
    'Zusammenführung von Unabhängigkeit, Konsistenz, Hierarchie und zielbezogener Vollständigkeit.'
WHERE @revision_3396 IS NOT NULL
AND @parent_section_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3.9.6'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_3396,
    title = 'Metatheoretischer Abschluss des Axiomensystems',
    chapter_no = 3,
    section_order = 3.3096,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Zusammenführung von Unabhängigkeit, Konsistenz, Hierarchie und zielbezogener Vollständigkeit.'
WHERE section_code = '3.3.9.6'
AND @parent_section_3396 IS NOT NULL;

SET @section_3396 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9.6'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.589', @section_3396, 'Metatheoretische Gesamtstruktur',
    '\\mathfrak{M}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F,G_{\\mathfrak{L}},\\mathcal{Q}_F\\right)', '\\mathfrak{M}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F,G_{\\mathfrak{L}},\\mathcal{Q}_F\\right)',
    'Tupel der metatheoretischen Gesamtstruktur des FRZK.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.589'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Metatheoretische Gesamtstruktur',
    equation_latex = '\\mathfrak{M}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F,G_{\\mathfrak{L}},\\mathcal{Q}_F\\right)',
    word_latex = '\\mathfrak{M}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F,G_{\\mathfrak{L}},\\mathcal{Q}_F\\right)',
    plain_description = 'Tupel der metatheoretischen Gesamtstruktur des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.589'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.590', @section_3396, 'Metatheoretische Bedingungen',
    '\\mathcal{B}_{\\mathfrak{M}}=\\left\\{B_{\\mathrm{unabh}},B_{\\mathrm{kons}},B_{\\mathrm{hier}},B_{\\mathrm{ziel}}\\right\\}', '\\mathcal{B}_{\\mathfrak{M}}=\\left\\{B_{\\mathrm{unabh}},B_{\\mathrm{kons}},B_{\\mathrm{hier}},B_{\\mathrm{ziel}}\\right\\}',
    'Menge der vier metatheoretischen Sicherungsbedingungen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.590'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Metatheoretische Bedingungen',
    equation_latex = '\\mathcal{B}_{\\mathfrak{M}}=\\left\\{B_{\\mathrm{unabh}},B_{\\mathrm{kons}},B_{\\mathrm{hier}},B_{\\mathrm{ziel}}\\right\\}',
    word_latex = '\\mathcal{B}_{\\mathfrak{M}}=\\left\\{B_{\\mathrm{unabh}},B_{\\mathrm{kons}},B_{\\mathrm{hier}},B_{\\mathrm{ziel}}\\right\\}',
    plain_description = 'Menge der vier metatheoretischen Sicherungsbedingungen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.590'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.591', @section_3396, 'Unabhängigkeitsbedingung',
    'B_{\\mathrm{unabh}}', 'B_{\\mathrm{unabh}}',
    'Relative Unabhängigkeit der Axiome.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.591'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Unabhängigkeitsbedingung',
    equation_latex = 'B_{\\mathrm{unabh}}',
    word_latex = 'B_{\\mathrm{unabh}}',
    plain_description = 'Relative Unabhängigkeit der Axiome.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.591'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.592', @section_3396, 'Konsistenzbedingung',
    'B_{\\mathrm{kons}}', 'B_{\\mathrm{kons}}',
    'Relative Konsistenz des Systems.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.592'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Konsistenzbedingung',
    equation_latex = 'B_{\\mathrm{kons}}',
    word_latex = 'B_{\\mathrm{kons}}',
    plain_description = 'Relative Konsistenz des Systems.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.592'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.593', @section_3396, 'Hierarchiebedingung',
    'B_{\\mathrm{hier}}', 'B_{\\mathrm{hier}}',
    'Hierarchische und azyklische Ordnung der Aussagen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.593'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Hierarchiebedingung',
    equation_latex = 'B_{\\mathrm{hier}}',
    word_latex = 'B_{\\mathrm{hier}}',
    plain_description = 'Hierarchische und azyklische Ordnung der Aussagen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.593'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.594', @section_3396, 'Zielbedingung',
    'B_{\\mathrm{ziel}}', 'B_{\\mathrm{ziel}}',
    'Zielbezogene Vollständigkeit hinsichtlich der Rekonstruktionsaufgaben.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.594'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Zielbedingung',
    equation_latex = 'B_{\\mathrm{ziel}}',
    word_latex = 'B_{\\mathrm{ziel}}',
    plain_description = 'Zielbezogene Vollständigkeit hinsichtlich der Rekonstruktionsaufgaben.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.594'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.595', @section_3396, 'Hinreichende metatheoretische Bestimmtheit',
    '\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)\\Leftrightarrow B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}', '\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)\\Leftrightarrow B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}',
    'Konjunktion der vier metatheoretischen Bedingungen.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.595'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Hinreichende metatheoretische Bestimmtheit',
    equation_latex = '\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)\\Leftrightarrow B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}',
    word_latex = '\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)\\Leftrightarrow B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}',
    plain_description = 'Konjunktion der vier metatheoretischen Bedingungen.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.595'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.596', @section_3396, 'Prädikat hinreichender Bestimmtheit',
    '\\operatorname{Hinr}', '\\operatorname{Hinr}',
    'Prädikat der hinreichenden metatheoretischen Bestimmtheit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.596'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Prädikat hinreichender Bestimmtheit',
    equation_latex = '\\operatorname{Hinr}',
    word_latex = '\\operatorname{Hinr}',
    plain_description = 'Prädikat der hinreichenden metatheoretischen Bestimmtheit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.596'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.597', @section_3396, 'Relative Axiomenunabhängigkeit',
    '\\forall A_i\\in\\mathcal{A}_F:\\mathcal{A}_F\\setminus\\left\\{A_i\\right\\}\\nvdash A_i', '\\forall A_i\\in\\mathcal{A}_F:\\mathcal{A}_F\\setminus\\left\\{A_i\\right\\}\\nvdash A_i',
    'Kein Axiom ist aus den übrigen Axiomen ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.597'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Relative Axiomenunabhängigkeit',
    equation_latex = '\\forall A_i\\in\\mathcal{A}_F:\\mathcal{A}_F\\setminus\\left\\{A_i\\right\\}\\nvdash A_i',
    word_latex = '\\forall A_i\\in\\mathcal{A}_F:\\mathcal{A}_F\\setminus\\left\\{A_i\\right\\}\\nvdash A_i',
    plain_description = 'Kein Axiom ist aus den übrigen Axiomen ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.597'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.598', @section_3396, 'Konsistenzbedingung des Systems',
    '\\nexists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\land\\mathfrak{L}_F\\vdash\\neg P', '\\nexists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\land\\mathfrak{L}_F\\vdash\\neg P',
    'Keine Aussage und ihre Negation sind gleichzeitig ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.598'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Konsistenzbedingung des Systems',
    equation_latex = '\\nexists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\land\\mathfrak{L}_F\\vdash\\neg P',
    word_latex = '\\nexists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\land\\mathfrak{L}_F\\vdash\\neg P',
    plain_description = 'Keine Aussage und ihre Negation sind gleichzeitig ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.598'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.599', @section_3396, 'Hierarchische Rückführbarkeit',
    '\\forall v\\in V_{\\mathfrak{L}}\\setminus\\mathcal{A}_F:\\exists U_v\\subseteq V_{\\mathfrak{L}}:\\forall u\\in U_v:\\rho(u)<\\rho(v)', '\\forall v\\in V_{\\mathfrak{L}}\\setminus\\mathcal{A}_F:\\exists U_v\\subseteq V_{\\mathfrak{L}}:\\forall u\\in U_v:\\rho(u)<\\rho(v)',
    'Jede nichtaxiomatische Aussage wird auf logisch vorhergehende Elemente zurückgeführt.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.599'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Hierarchische Rückführbarkeit',
    equation_latex = '\\forall v\\in V_{\\mathfrak{L}}\\setminus\\mathcal{A}_F:\\exists U_v\\subseteq V_{\\mathfrak{L}}:\\forall u\\in U_v:\\rho(u)<\\rho(v)',
    word_latex = '\\forall v\\in V_{\\mathfrak{L}}\\setminus\\mathcal{A}_F:\\exists U_v\\subseteq V_{\\mathfrak{L}}:\\forall u\\in U_v:\\rho(u)<\\rho(v)',
    plain_description = 'Jede nichtaxiomatische Aussage wird auf logisch vorhergehende Elemente zurückgeführt.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.599'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.600', @section_3396, 'Zielbezogene Rekonstruktionsbedingung',
    '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i', '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    'Jede zentrale Rekonstruktionsaufgabe ist aus einer endlichen Teilmenge ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.600'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Zielbezogene Rekonstruktionsbedingung',
    equation_latex = '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    word_latex = '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    plain_description = 'Jede zentrale Rekonstruktionsaufgabe ist aus einer endlichen Teilmenge ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.600'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.601', @section_3396, 'Metatheoretischer Prüfoperator',
    '\\Pi_{\\mathfrak{M}}:\\mathfrak{M}_F\\rightarrow\\left\\{0,1\\right\\}', '\\Pi_{\\mathfrak{M}}:\\mathfrak{M}_F\\rightarrow\\left\\{0,1\\right\\}',
    'Binärer Prüfoperator für die metatheoretische Bestimmtheit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.601'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Metatheoretischer Prüfoperator',
    equation_latex = '\\Pi_{\\mathfrak{M}}:\\mathfrak{M}_F\\rightarrow\\left\\{0,1\\right\\}',
    word_latex = '\\Pi_{\\mathfrak{M}}:\\mathfrak{M}_F\\rightarrow\\left\\{0,1\\right\\}',
    plain_description = 'Binärer Prüfoperator für die metatheoretische Bestimmtheit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.601'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.602', @section_3396, 'Positive Prüfentscheidung',
    '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=1\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)', '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=1\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)',
    'Der Prüfoperator liefert eins genau bei hinreichender Bestimmtheit.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.602'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Positive Prüfentscheidung',
    equation_latex = '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=1\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)',
    word_latex = '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=1\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)',
    plain_description = 'Der Prüfoperator liefert eins genau bei hinreichender Bestimmtheit.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.602'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.603', @section_3396, 'Negative Prüfentscheidung',
    '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=0', '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=0',
    'Mindestens eine metatheoretische Bedingung ist nicht erfüllt.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.603'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Negative Prüfentscheidung',
    equation_latex = '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=0',
    word_latex = '\\Pi_{\\mathfrak{M}}\\left(\\mathfrak{M}_F\\right)=0',
    plain_description = 'Mindestens eine metatheoretische Bedingung ist nicht erfüllt.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.603'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.604', @section_3396, 'Metatheoretischer Qualitätsvektor',
    '\\mathbf{m}_F=\\begin{pmatrix}m_{\\mathrm{unabh}}\\\\m_{\\mathrm{kons}}\\\\m_{\\mathrm{hier}}\\\\m_{\\mathrm{ziel}}\\end{pmatrix}', '\\mathbf{m}_F=\\begin{pmatrix}m_{\\mathrm{unabh}}\\\\m_{\\mathrm{kons}}\\\\m_{\\mathrm{hier}}\\\\m_{\\mathrm{ziel}}\\end{pmatrix}',
    'Vektor gradueller metatheoretischer Qualitätsbewertungen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.604'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Metatheoretischer Qualitätsvektor',
    equation_latex = '\\mathbf{m}_F=\\begin{pmatrix}m_{\\mathrm{unabh}}\\\\m_{\\mathrm{kons}}\\\\m_{\\mathrm{hier}}\\\\m_{\\mathrm{ziel}}\\end{pmatrix}',
    word_latex = '\\mathbf{m}_F=\\begin{pmatrix}m_{\\mathrm{unabh}}\\\\m_{\\mathrm{kons}}\\\\m_{\\mathrm{hier}}\\\\m_{\\mathrm{ziel}}\\end{pmatrix}',
    plain_description = 'Vektor gradueller metatheoretischer Qualitätsbewertungen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.604'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.605', @section_3396, 'Wertebereich der Qualitätskomponenten',
    'm_j\\in\\left[0,1\\right]', 'm_j\\in\\left[0,1\\right]',
    'Normierter Wertebereich der Qualitätskomponenten.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.605'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Wertebereich der Qualitätskomponenten',
    equation_latex = 'm_j\\in\\left[0,1\\right]',
    word_latex = 'm_j\\in\\left[0,1\\right]',
    plain_description = 'Normierter Wertebereich der Qualitätskomponenten.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.605'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.606', @section_3396, 'Metatheoretische Gesamtqualität',
    'Q_{\\mathfrak{M}}\\left(\\mathbf{m}_F\\right)=\\sum_{j=1}^{4}w_jm_j', 'Q_{\\mathfrak{M}}\\left(\\mathbf{m}_F\\right)=\\sum_{j=1}^{4}w_jm_j',
    'Gewichtete Summe der metatheoretischen Qualitätskomponenten.', 'metric', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.606'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Metatheoretische Gesamtqualität',
    equation_latex = 'Q_{\\mathfrak{M}}\\left(\\mathbf{m}_F\\right)=\\sum_{j=1}^{4}w_jm_j',
    word_latex = 'Q_{\\mathfrak{M}}\\left(\\mathbf{m}_F\\right)=\\sum_{j=1}^{4}w_jm_j',
    plain_description = 'Gewichtete Summe der metatheoretischen Qualitätskomponenten.',
    equation_type = 'metric',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.606'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.607', @section_3396, 'Nichtnegative Gewichtung',
    'w_j\\geq0', 'w_j\\geq0',
    'Gewichtungen der Qualitätskomponenten sind nichtnegativ.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.607'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Nichtnegative Gewichtung',
    equation_latex = 'w_j\\geq0',
    word_latex = 'w_j\\geq0',
    plain_description = 'Gewichtungen der Qualitätskomponenten sind nichtnegativ.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.607'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.608', @section_3396, 'Normierung der Gewichtungen',
    '\\sum_{j=1}^{4}w_j=1', '\\sum_{j=1}^{4}w_j=1',
    'Summe der Gewichtungen ist eins.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.608'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Normierung der Gewichtungen',
    equation_latex = '\\sum_{j=1}^{4}w_j=1',
    word_latex = '\\sum_{j=1}^{4}w_j=1',
    plain_description = 'Summe der Gewichtungen ist eins.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.608'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.609', @section_3396, 'Freigabebedingung für Kapitel 3.4',
    '\\operatorname{Freig}_{3.4}\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)', '\\operatorname{Freig}_{3.4}\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)',
    'Formale Freigabe des Axiomensystems bei hinreichender Bestimmtheit.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.609'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Freigabebedingung für Kapitel 3.4',
    equation_latex = '\\operatorname{Freig}_{3.4}\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)',
    word_latex = '\\operatorname{Freig}_{3.4}\\Leftrightarrow\\operatorname{Hinr}\\left(\\mathfrak{M}_F\\right)',
    plain_description = 'Formale Freigabe des Axiomensystems bei hinreichender Bestimmtheit.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.609'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.610', @section_3396, 'Freigabeprädikat',
    '\\operatorname{Freig}_{3.4}', '\\operatorname{Freig}_{3.4}',
    'Prädikat der formalen Freigabe für Kapitel 3.4.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.610'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Freigabeprädikat',
    equation_latex = '\\operatorname{Freig}_{3.4}',
    word_latex = '\\operatorname{Freig}_{3.4}',
    plain_description = 'Prädikat der formalen Freigabe für Kapitel 3.4.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.610'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.611', @section_3396, 'Ableitungsrichtung zur Rekonstruktion',
    '\\mathcal{A}_F\\rightarrow\\mathcal{D}\\!ef_F\\rightarrow\\mathcal{P}_F\\rightarrow\\mathcal{R}_F', '\\mathcal{A}_F\\rightarrow\\mathcal{D}\\!ef_F\\rightarrow\\mathcal{P}_F\\rightarrow\\mathcal{R}_F',
    'Ableitungskette von Axiomen über Definitionen und Propositionen zur Rekonstruktion.', 'schema', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.611'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Ableitungsrichtung zur Rekonstruktion',
    equation_latex = '\\mathcal{A}_F\\rightarrow\\mathcal{D}\\!ef_F\\rightarrow\\mathcal{P}_F\\rightarrow\\mathcal{R}_F',
    word_latex = '\\mathcal{A}_F\\rightarrow\\mathcal{D}\\!ef_F\\rightarrow\\mathcal{P}_F\\rightarrow\\mathcal{R}_F',
    plain_description = 'Ableitungskette von Axiomen über Definitionen und Propositionen zur Rekonstruktion.',
    equation_type = 'schema',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.611'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.612', @section_3396, 'Menge mathematischer Rekonstruktionen',
    '\\mathcal{R}_F', '\\mathcal{R}_F',
    'Menge der mathematischen Rekonstruktionen des FRZK.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.612'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Menge mathematischer Rekonstruktionen',
    equation_latex = '\\mathcal{R}_F',
    word_latex = '\\mathcal{R}_F',
    plain_description = 'Menge der mathematischen Rekonstruktionen des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.612'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.613', @section_3396, 'Ableitbarkeit einer Rekonstruktion',
    'R_i\\in\\mathcal{R}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\left(\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F\\right):\\Gamma_i\\vdash R_i', 'R_i\\in\\mathcal{R}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\left(\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F\\right):\\Gamma_i\\vdash R_i',
    'Jede Rekonstruktion ist aus einer endlichen Teilmenge des formalen Systems ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.613'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Ableitbarkeit einer Rekonstruktion',
    equation_latex = 'R_i\\in\\mathcal{R}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\left(\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F\\right):\\Gamma_i\\vdash R_i',
    word_latex = 'R_i\\in\\mathcal{R}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\left(\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F\\right):\\Gamma_i\\vdash R_i',
    plain_description = 'Jede Rekonstruktion ist aus einer endlichen Teilmenge des formalen Systems ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.613'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.614', @section_3396, 'Trennung formaler und empirischer Gültigkeit',
    '\\operatorname{Gült}_{\\mathrm{formal}}\\neq\\operatorname{Bew}_{\\mathrm{emp}}', '\\operatorname{Gült}_{\\mathrm{formal}}\\neq\\operatorname{Bew}_{\\mathrm{emp}}',
    'Formale Gültigkeit und empirische Bewährung sind verschiedene Ebenen.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.614'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Trennung formaler und empirischer Gültigkeit',
    equation_latex = '\\operatorname{Gült}_{\\mathrm{formal}}\\neq\\operatorname{Bew}_{\\mathrm{emp}}',
    word_latex = '\\operatorname{Gült}_{\\mathrm{formal}}\\neq\\operatorname{Bew}_{\\mathrm{emp}}',
    plain_description = 'Formale Gültigkeit und empirische Bewährung sind verschiedene Ebenen.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.614'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.615', @section_3396, 'Theoretische Tragfähigkeit',
    '\\operatorname{Trag}_F=\\operatorname{Gült}_{\\mathrm{formal}}\\land\\operatorname{Bew}_{\\mathrm{emp}}', '\\operatorname{Trag}_F=\\operatorname{Gült}_{\\mathrm{formal}}\\land\\operatorname{Bew}_{\\mathrm{emp}}',
    'Theoretische Tragfähigkeit erfordert formale Gültigkeit und empirische Bewährung.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.615'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Theoretische Tragfähigkeit',
    equation_latex = '\\operatorname{Trag}_F=\\operatorname{Gült}_{\\mathrm{formal}}\\land\\operatorname{Bew}_{\\mathrm{emp}}',
    word_latex = '\\operatorname{Trag}_F=\\operatorname{Gült}_{\\mathrm{formal}}\\land\\operatorname{Bew}_{\\mathrm{emp}}',
    plain_description = 'Theoretische Tragfähigkeit erfordert formale Gültigkeit und empirische Bewährung.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.615'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.616', @section_3396, 'Tragfähigkeitsprädikat',
    '\\operatorname{Trag}_F', '\\operatorname{Trag}_F',
    'Prädikat der theoretischen Tragfähigkeit des FRZK.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.616'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Tragfähigkeitsprädikat',
    equation_latex = '\\operatorname{Trag}_F',
    word_latex = '\\operatorname{Trag}_F',
    plain_description = 'Prädikat der theoretischen Tragfähigkeit des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.616'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.617', @section_3396, 'Metatheoretische Anschlussfähigkeit',
    'B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}\\Rightarrow\\operatorname{Freig}_{3.4}', 'B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}\\Rightarrow\\operatorname{Freig}_{3.4}',
    'Erfüllung der vier Bedingungen führt zur formalen Freigabe.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.617'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Metatheoretische Anschlussfähigkeit',
    equation_latex = 'B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}\\Rightarrow\\operatorname{Freig}_{3.4}',
    word_latex = 'B_{\\mathrm{unabh}}\\land B_{\\mathrm{kons}}\\land B_{\\mathrm{hier}}\\land B_{\\mathrm{ziel}}\\Rightarrow\\operatorname{Freig}_{3.4}',
    plain_description = 'Erfüllung der vier Bedingungen führt zur formalen Freigabe.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.617'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.618', @section_3396, 'Folgerung aus der Freigabe',
    '\\operatorname{Freig}_{3.4}\\Rightarrow\\forall R_i\\in\\mathcal{R}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash R_i', '\\operatorname{Freig}_{3.4}\\Rightarrow\\forall R_i\\in\\mathcal{R}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash R_i',
    'Jede zulässige Rekonstruktion ist nach der Freigabe aus einer endlichen Teilmenge ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.6.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.618'
);

UPDATE equations
SET
    section_id = @section_3396,
    title = 'Folgerung aus der Freigabe',
    equation_latex = '\\operatorname{Freig}_{3.4}\\Rightarrow\\forall R_i\\in\\mathcal{R}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash R_i',
    word_latex = '\\operatorname{Freig}_{3.4}\\Rightarrow\\forall R_i\\in\\mathcal{R}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash R_i',
    plain_description = 'Jede zulässige Rekonstruktion ist nach der Freigabe aus einer endlichen Teilmenge ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.6.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.5 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3396
WHERE equation_number = '3.618'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.13',
    @section_3396,
    'Metatheoretische Anschlussfähigkeit',
    'Erfüllt das FRZK die Bedingungen relativer Unabhängigkeit, relativer Konsistenz, hierarchischer Ordnung und zielbezogener Vollständigkeit, dann ist das Axiomensystem hinreichend bestimmt, um als formale Grundlage der mathematischen Rekonstruktion zu dienen.',
    'B_{\mathrm{unabh}}\land B_{\mathrm{kons}}\land B_{\mathrm{hier}}\land B_{\mathrm{ziel}}\Rightarrow\operatorname{Freig}_{3.4}',
    'B_{\mathrm{unabh}}\land B_{\mathrm{kons}}\land B_{\mathrm{hier}}\land B_{\mathrm{ziel}}\Rightarrow\operatorname{Freig}_{3.4}',
    'Die Proposition führt die zuvor einzeln bestimmten metatheoretischen Bedingungen in einer gemeinsamen Freigabebedingung zusammen. Aus der Freigabe folgt die endliche Ableitbarkeit jeder für Kapitel 3.4 zugelassenen Rekonstruktion aus dem formalen System.',
    'A1,A2,A3,A4,A5,A6,A7',
    'accepted',
    @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM propositions WHERE proposition_number = '3.3.13'
);

UPDATE propositions
SET
    section_id = @section_3396,
    title = 'Metatheoretische Anschlussfähigkeit',
    statement_text = 'Erfüllt das FRZK die Bedingungen relativer Unabhängigkeit, relativer Konsistenz, hierarchischer Ordnung und zielbezogener Vollständigkeit, dann ist das Axiomensystem hinreichend bestimmt, um als formale Grundlage der mathematischen Rekonstruktion zu dienen.',
    statement_latex = 'B_{\mathrm{unabh}}\land B_{\mathrm{kons}}\land B_{\mathrm{hier}}\land B_{\mathrm{ziel}}\Rightarrow\operatorname{Freig}_{3.4}',
    word_latex = 'B_{\mathrm{unabh}}\land B_{\mathrm{kons}}\land B_{\mathrm{hier}}\land B_{\mathrm{ziel}}\Rightarrow\operatorname{Freig}_{3.4}',
    logical_derivation = 'Die Proposition führt die zuvor einzeln bestimmten metatheoretischen Bedingungen in einer gemeinsamen Freigabebedingung zusammen. Aus der Freigabe folgt die endliche Ableitbarkeit jeder für Kapitel 3.4 zugelassenen Rekonstruktion aus dem formalen System.',
    based_on_axioms = 'A1,A2,A3,A4,A5,A6,A7',
    status = 'accepted',
    created_revision_id = @revision_3396
WHERE proposition_number = '3.3.13'
AND @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL;

SET @proposition_3313 := (
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.13'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(
    proposition_id, axiom_id, assumption_id, dependency_type, note
)
SELECT
    @proposition_3313,
    a.axiom_id,
    NULL,
    'derived_from',
    CONCAT('Proposition 3.3.13 verwendet ', a.axiom_number,
           ' als Bestandteil der metatheoretischen Anschlussfähigkeit.')
FROM axioms a
WHERE @proposition_3313 IS NOT NULL
AND a.axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies pd
    WHERE pd.proposition_id = @proposition_3313
      AND pd.axiom_id = a.axiom_id
      AND pd.assumption_id IS NULL
      AND pd.dependency_type = 'derived_from'
);


SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.589' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\mathfrak{M}_F', '\\mathfrak{M}_F', 'Metatheoretische Gesamtstruktur', 'Gesamtstruktur aus Axiomen, Definitionen, Propositionen, Abhängigkeitsgraph und Rekonstruktionsaufgaben',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathfrak{M}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\mathfrak{M}_F', 'Metatheoretische Gesamtstruktur',
    'Gesamtstruktur aus Axiomen, Definitionen, Propositionen, Abhängigkeitsgraph und Rekonstruktionsaufgaben', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\mathfrak{M}_F'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.590' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\mathcal{B}_{\\mathfrak{M}}', '\\mathcal{B}_{\\mathfrak{M}}', 'Metatheoretische Bedingungen', 'Menge der Bedingungen Unabhängigkeit, Konsistenz, Hierarchie und Zielvollständigkeit',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{B}_{\\mathfrak{M}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\mathcal{B}_{\\mathfrak{M}}', 'Metatheoretische Bedingungen',
    'Menge der Bedingungen Unabhängigkeit, Konsistenz, Hierarchie und Zielvollständigkeit', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\mathcal{B}_{\\mathfrak{M}}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.596' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{Hinr}', '\\operatorname{Hinr}', 'Hinreichende Bestimmtheit', 'Prädikat der hinreichenden metatheoretischen Bestimmtheit',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Hinr}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\operatorname{Hinr}', 'Hinreichende Bestimmtheit',
    'Prädikat der hinreichenden metatheoretischen Bestimmtheit', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\operatorname{Hinr}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.601' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\Pi_{\\mathfrak{M}}', '\\Pi_{\\mathfrak{M}}', 'Metatheoretischer Prüfoperator', 'Prüfoperator für die metatheoretische Bestimmtheit',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\Pi_{\\mathfrak{M}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\Pi_{\\mathfrak{M}}', 'Metatheoretischer Prüfoperator',
    'Prüfoperator für die metatheoretische Bestimmtheit', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\Pi_{\\mathfrak{M}}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.604' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\mathbf{m}_F', '\\mathbf{m}_F', 'Metatheoretischer Qualitätsvektor', 'Vektor gradueller Qualitätsbewertungen',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 1, 0, 0,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathbf{m}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\mathbf{m}_F', 'Metatheoretischer Qualitätsvektor',
    'Vektor gradueller Qualitätsbewertungen', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\mathbf{m}_F'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.606' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    'Q_{\\mathfrak{M}}', 'Q_{\\mathfrak{M}}', 'Metatheoretische Qualitätsfunktion', 'Gewichtete Bewertungsfunktion der metatheoretischen Qualität',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = 'Q_{\\mathfrak{M}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, 'Q_{\\mathfrak{M}}', 'Metatheoretische Qualitätsfunktion',
    'Gewichtete Bewertungsfunktion der metatheoretischen Qualität', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = 'Q_{\\mathfrak{M}}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.610' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{Freig}_{3.4}', '\\operatorname{Freig}_{3.4}', 'Freigabeprädikat', 'Prädikat der formalen Freigabe für Kapitel 3.4',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Freig}_{3.4}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\operatorname{Freig}_{3.4}', 'Freigabeprädikat',
    'Prädikat der formalen Freigabe für Kapitel 3.4', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\operatorname{Freig}_{3.4}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.612' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\mathcal{R}_F', '\\mathcal{R}_F', 'Rekonstruktionsmenge', 'Menge der mathematischen Rekonstruktionen',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{R}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\mathcal{R}_F', 'Rekonstruktionsmenge',
    'Menge der mathematischen Rekonstruktionen', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\mathcal{R}_F'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.614' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{Gült}_{\\mathrm{formal}}', '\\operatorname{Gült}_{\\mathrm{formal}}', 'Formale Gültigkeit', 'Gültigkeit einer Ableitung innerhalb des formalen Systems',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Gült}_{\\mathrm{formal}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\operatorname{Gült}_{\\mathrm{formal}}', 'Formale Gültigkeit',
    'Gültigkeit einer Ableitung innerhalb des formalen Systems', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\operatorname{Gült}_{\\mathrm{formal}}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.614' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{Bew}_{\\mathrm{emp}}', '\\operatorname{Bew}_{\\mathrm{emp}}', 'Empirische Bewährung', 'Bewährung einer rekonstruierten Struktur an Beobachtungsdaten',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Bew}_{\\mathrm{emp}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\operatorname{Bew}_{\\mathrm{emp}}', 'Empirische Bewährung',
    'Bewährung einer rekonstruierten Struktur an Beobachtungsdaten', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\operatorname{Bew}_{\\mathrm{emp}}'
);

SET @eq_symbol_3396 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.616' LIMIT 1
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{Trag}_F', '\\operatorname{Trag}_F', 'Theoretische Tragfähigkeit', 'Verbindung formaler Gültigkeit und empirischer Bewährung',
    'chapter', @section_3396, @eq_symbol_3396,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.6 eingeführt oder metatheoretisch präzisiert.',
    'checked', @revision_3396
WHERE @section_3396 IS NOT NULL
AND @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Trag}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3396, '\\operatorname{Trag}_F', 'Theoretische Tragfähigkeit',
    'Verbindung formaler Gültigkeit und empirischer Bewährung', NULL, NULL, 1
WHERE @eq_symbol_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3396
      AND symbol_latex = '\\operatorname{Trag}_F'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3396, @section_3396, 'created', 'section', '3.3.9.6',
    'Abschnitt 3.3.9.6 vollständig angelegt.',
    NULL, 'Metatheoretischer Abschluss des Axiomensystems'
WHERE @revision_3396 IS NOT NULL
AND @section_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3396
      AND object_type = 'section'
      AND object_reference = '3.3.9.6'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3396, @section_3396, 'proposition_added', 'proposition', '3.3.13',
    'Proposition 3.3.13 registriert.',
    NULL, 'Metatheoretische Anschlussfähigkeit'
WHERE @revision_3396 IS NOT NULL
AND @section_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3396
      AND object_type = 'proposition'
      AND object_reference = '3.3.13'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3396, @section_3396, 'equation_added', 'equation', '(3.589)–(3.618)',
    '30 Gleichungen und formale Schemata registriert.',
    NULL, 'Gleichungen (3.589) bis (3.618)'
WHERE @revision_3396 IS NOT NULL
AND @section_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3396
      AND object_type = 'equation'
      AND object_reference = '(3.589)–(3.618)'
);

SET @equation_count_3396 := (
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
        '3.589','3.590','3.591','3.592','3.593','3.594','3.595','3.596',
        '3.597','3.598','3.599','3.600','3.601','3.602','3.603','3.604',
        '3.605','3.606','3.607','3.608','3.609','3.610','3.611','3.612',
        '3.613','3.614','3.615','3.616','3.617','3.618'
    )
);

SET @dependency_count_3396 := (
    SELECT COUNT(*)
    FROM proposition_dependencies
    WHERE proposition_id = @proposition_3313
      AND dependency_type = 'derived_from'
);

SET @symbol_count_3396 := (
    SELECT COUNT(*)
    FROM symbols
    WHERE scope_type = 'chapter'
      AND symbol_latex IN
      (
          '\mathfrak{M}_F',
          '\mathcal{B}_{\mathfrak{M}}',
          '\operatorname{Hinr}',
          '\Pi_{\mathfrak{M}}',
          '\mathbf{m}_F',
          'Q_{\mathfrak{M}}',
          '\operatorname{Freig}_{3.4}',
          '\mathcal{R}_F',
          '\operatorname{Gült}_{\mathrm{formal}}',
          '\operatorname{Bew}_{\mathrm{emp}}',
          '\operatorname{Trag}_F'
      )
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3396, 'K3.3.9.6.PRECONDITION',
    CASE WHEN @precondition_ok_3396 = 1 THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @precondition_ok_3396 = 1 THEN '1' ELSE '0' END,
    'Prüfung der Elternrevision und des übergeordneten Abschnitts.'
WHERE @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3396
      AND validation_code = 'K3.3.9.6.PRECONDITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3396, 'K3.3.9.6.SECTION',
    CASE WHEN @section_3396 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @section_3396 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung des Abschnitts 3.3.9.6.'
WHERE @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3396
      AND validation_code = 'K3.3.9.6.SECTION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3396, 'K3.3.9.6.PROPOSITION',
    CASE WHEN @proposition_3313 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @proposition_3313 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung der Proposition 3.3.13.'
WHERE @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3396
      AND validation_code = 'K3.3.9.6.PROPOSITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3396, 'K3.3.9.6.EQUATIONS',
    CASE WHEN @equation_count_3396 = 30 THEN 'passed' ELSE 'failed' END,
    '30', CAST(@equation_count_3396 AS CHAR),
    'Prüfung der Gleichungen (3.589) bis (3.618).'
WHERE @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3396
      AND validation_code = 'K3.3.9.6.EQUATIONS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3396, 'K3.3.9.6.AXIOM_DEPENDENCIES',
    CASE WHEN @dependency_count_3396 = 7 THEN 'passed' ELSE 'failed' END,
    '7', CAST(@dependency_count_3396 AS CHAR),
    'Prüfung der sieben Axiomabhängigkeiten von Proposition 3.3.13.'
WHERE @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3396
      AND validation_code = 'K3.3.9.6.AXIOM_DEPENDENCIES'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3396, 'K3.3.9.6.SYMBOLS',
    CASE WHEN @symbol_count_3396 = 11 THEN 'passed' ELSE 'failed' END,
    '11', CAST(@symbol_count_3396 AS CHAR),
    'Prüfung der elf zentralen Symbolregistrierungen.'
WHERE @revision_3396 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3396
      AND validation_code = 'K3.3.9.6.SYMBOLS'
);

COMMIT;

SELECT
    CASE
        WHEN @parent_revision_3396 IS NULL
            THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.9.5-V1 fehlt.'
        WHEN @parent_section_3396 IS NULL
            THEN 'FEHLER: Übergeordneter Abschnitt 3.3.9 fehlt.'
        WHEN @revision_3396 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.9.6-V1 wurde nicht angelegt.'
        WHEN @section_3396 IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9.6 wurde nicht angelegt.'
        WHEN @proposition_3313 IS NULL
            THEN 'FEHLER: Proposition 3.3.13 wurde nicht angelegt.'
        WHEN @equation_count_3396 <> 30
            THEN CONCAT('FEHLER: ', @equation_count_3396, ' statt 30 Gleichungen vorhanden.')
        WHEN @dependency_count_3396 <> 7
            THEN CONCAT('FEHLER: ', @dependency_count_3396, ' statt 7 Axiomabhängigkeiten vorhanden.')
        WHEN @symbol_count_3396 <> 11
            THEN CONCAT('FEHLER: ', @symbol_count_3396, ' statt 11 zentralen Symbolen vorhanden.')
        ELSE 'OK: Repository-Update 3.3.9.6 vollständig und konsistent ausgeführt.'
    END AS import_status;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_3396
ORDER BY validation_code;
