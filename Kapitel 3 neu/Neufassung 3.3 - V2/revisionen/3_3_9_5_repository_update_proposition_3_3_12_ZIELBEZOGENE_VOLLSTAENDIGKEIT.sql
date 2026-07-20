/* ============================================================================
   FRZK-RKB – Repository-Update 3.3.9.5

   Abschnitt:
     3.3.9.5 Reichweite und Grenzen der Vollständigkeit

   Ausgangsstand:
     frzk_rkb_3.3.9.4.sql

   Elternrevision:
     RKB-NEU-K3.3.9.4-V1

   Registriert:
     - Revision RKB-NEU-K3.3.9.5-V1
     - Abschnitt 3.3.9.5
     - Proposition 3.3.12
     - Gleichungen (3.558) bis (3.588)
     - Axiomabhängigkeiten A1 bis A7
     - zentrale neue Symbole
     - Gleichung-Symbol-Zuordnungen
     - Änderungsprotokoll
     - Repository-Validierungen

   Eigenschaften:
     - idempotent
     - keine fest codierten Primärschlüssel
     - Fremdschlüssel vor Protokolleinträgen geprüft
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_3395 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.4-V1'
    LIMIT 1
);

SET @parent_section_3395 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9'
    LIMIT 1
);

SET @precondition_ok_3395 := (
    @parent_revision_3395 IS NOT NULL
    AND @parent_section_3395 IS NOT NULL
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.9.5-V1',
    NOW(),
    'section',
    '3.3.9.5',
    '1.0',
    'Abschnitt 3.3.9.5: Reichweite und Grenzen der Vollständigkeit; Proposition 3.3.12; Gleichungen (3.558) bis (3.588).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_3395
WHERE @precondition_ok_3395 = 1
AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.5-V1'
);

SET @revision_3395 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.5-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @parent_section_3395,
    '3.3.9.5',
    'Reichweite und Grenzen der Vollständigkeit',
    3,
    3.3095,
    'final',
    1,
    'Differenzierung begrifflicher, funktionaler, formallogischer und zielbezogener Vollständigkeit.'
WHERE @revision_3395 IS NOT NULL
AND @parent_section_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3.9.5'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_3395,
    title = 'Reichweite und Grenzen der Vollständigkeit',
    chapter_no = 3,
    section_order = 3.3095,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Differenzierung begrifflicher, funktionaler, formallogischer und zielbezogener Vollständigkeit.'
WHERE section_code = '3.3.9.5'
AND @parent_section_3395 IS NOT NULL;

SET @section_3395 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9.5'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.558', @section_3395, 'Formen der Vollständigkeit',
    '\\mathcal{V}_F=\\left\\{\\mathcal{V}_{\\mathrm{begr}},\\mathcal{V}_{\\mathrm{fun}},\\mathcal{V}_{\\mathrm{log}}\\right\\}', '\\mathcal{V}_F=\\left\\{\\mathcal{V}_{\\mathrm{begr}},\\mathcal{V}_{\\mathrm{fun}},\\mathcal{V}_{\\mathrm{log}}\\right\\}',
    'Unterscheidung begrifflicher, funktionaler und formallogischer Vollständigkeit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.558'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Formen der Vollständigkeit',
    equation_latex = '\\mathcal{V}_F=\\left\\{\\mathcal{V}_{\\mathrm{begr}},\\mathcal{V}_{\\mathrm{fun}},\\mathcal{V}_{\\mathrm{log}}\\right\\}',
    word_latex = '\\mathcal{V}_F=\\left\\{\\mathcal{V}_{\\mathrm{begr}},\\mathcal{V}_{\\mathrm{fun}},\\mathcal{V}_{\\mathrm{log}}\\right\\}',
    plain_description = 'Unterscheidung begrifflicher, funktionaler und formallogischer Vollständigkeit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.558'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.559', @section_3395, 'Begriffliche Vollständigkeit',
    '\\mathcal{V}_{\\mathrm{begr}}', '\\mathcal{V}_{\\mathrm{begr}}',
    'Bezeichnung der begrifflichen Vollständigkeit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.559'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Begriffliche Vollständigkeit',
    equation_latex = '\\mathcal{V}_{\\mathrm{begr}}',
    word_latex = '\\mathcal{V}_{\\mathrm{begr}}',
    plain_description = 'Bezeichnung der begrifflichen Vollständigkeit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.559'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.560', @section_3395, 'Funktionale Vollständigkeit',
    '\\mathcal{V}_{\\mathrm{fun}}', '\\mathcal{V}_{\\mathrm{fun}}',
    'Bezeichnung der funktionalen Vollständigkeit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.560'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Funktionale Vollständigkeit',
    equation_latex = '\\mathcal{V}_{\\mathrm{fun}}',
    word_latex = '\\mathcal{V}_{\\mathrm{fun}}',
    plain_description = 'Bezeichnung der funktionalen Vollständigkeit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.560'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.561', @section_3395, 'Formallogische Vollständigkeit',
    '\\mathcal{V}_{\\mathrm{log}}', '\\mathcal{V}_{\\mathrm{log}}',
    'Bezeichnung der formallogischen Vollständigkeit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.561'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Formallogische Vollständigkeit',
    equation_latex = '\\mathcal{V}_{\\mathrm{log}}',
    word_latex = '\\mathcal{V}_{\\mathrm{log}}',
    plain_description = 'Bezeichnung der formallogischen Vollständigkeit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.561'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.562', @section_3395, 'Menge der Grundbegriffe',
    '\\mathcal{B}_F', '\\mathcal{B}_F',
    'Menge aller im FRZK verwendeten Grundbegriffe.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.562'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Menge der Grundbegriffe',
    equation_latex = '\\mathcal{B}_F',
    word_latex = '\\mathcal{B}_F',
    plain_description = 'Menge aller im FRZK verwendeten Grundbegriffe.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.562'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.563', @section_3395, 'Bedingung begrifflicher Vollständigkeit',
    '\\forall B\\in\\mathcal{B}_F:B\\in\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)\\lor B\\in\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)', '\\forall B\\in\\mathcal{B}_F:B\\in\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)\\lor B\\in\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)',
    'Jeder Grundbegriff ist definiert oder ausdrücklich als primitiv angenommen.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.563'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Bedingung begrifflicher Vollständigkeit',
    equation_latex = '\\forall B\\in\\mathcal{B}_F:B\\in\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)\\lor B\\in\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)',
    word_latex = '\\forall B\\in\\mathcal{B}_F:B\\in\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)\\lor B\\in\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)',
    plain_description = 'Jeder Grundbegriff ist definiert oder ausdrücklich als primitiv angenommen.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.563'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.564', @section_3395, 'Menge definierter Begriffe',
    '\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)', '\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)',
    'Menge der im formalen System definierten Begriffe.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.564'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Menge definierter Begriffe',
    equation_latex = '\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)',
    word_latex = '\\operatorname{Def}\\left(\\mathfrak{L}_F\\right)',
    plain_description = 'Menge der im formalen System definierten Begriffe.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.564'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.565', @section_3395, 'Menge primitiver Begriffe',
    '\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)', '\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)',
    'Menge bewusst nicht weiter definierter Ausgangsbegriffe.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.565'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Menge primitiver Begriffe',
    equation_latex = '\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)',
    word_latex = '\\operatorname{Prim}\\left(\\mathfrak{L}_F\\right)',
    plain_description = 'Menge bewusst nicht weiter definierter Ausgangsbegriffe.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.565'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.566', @section_3395, 'Relative begriffliche Vollständigkeit',
    '\\mathcal{V}_{\\mathrm{begr}}\\left(\\mathfrak{L}_F\\mid\\mathcal{G}_F\\right)', '\\mathcal{V}_{\\mathrm{begr}}\\left(\\mathfrak{L}_F\\mid\\mathcal{G}_F\\right)',
    'Begriffliche Vollständigkeit relativ zum Geltungsbereich.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.566'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Relative begriffliche Vollständigkeit',
    equation_latex = '\\mathcal{V}_{\\mathrm{begr}}\\left(\\mathfrak{L}_F\\mid\\mathcal{G}_F\\right)',
    word_latex = '\\mathcal{V}_{\\mathrm{begr}}\\left(\\mathfrak{L}_F\\mid\\mathcal{G}_F\\right)',
    plain_description = 'Begriffliche Vollständigkeit relativ zum Geltungsbereich.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.566'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.567', @section_3395, 'Geltungsbereich des Systems',
    '\\mathcal{G}_F', '\\mathcal{G}_F',
    'Festgelegter Geltungsbereich des FRZK.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.567'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Geltungsbereich des Systems',
    equation_latex = '\\mathcal{G}_F',
    word_latex = '\\mathcal{G}_F',
    plain_description = 'Festgelegter Geltungsbereich des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.567'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.568', @section_3395, 'Komponenten funktionaler Beschreibung',
    '\\mathcal{K}_F=\\left\\{\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right\\}', '\\mathcal{K}_F=\\left\\{\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right\\}',
    'Strukturmenge funktionaler Gehalte, Relationen, Operationen, Kohärenzbedingungen, Zustände und Übergänge.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.568'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Komponenten funktionaler Beschreibung',
    equation_latex = '\\mathcal{K}_F=\\left\\{\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right\\}',
    word_latex = '\\mathcal{K}_F=\\left\\{\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right\\}',
    plain_description = 'Strukturmenge funktionaler Gehalte, Relationen, Operationen, Kohärenzbedingungen, Zustände und Übergänge.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.568'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.569', @section_3395, 'Bedingung funktionaler Repräsentierbarkeit',
    '\\forall\\mathcal{O}\\in\\mathcal{G}_F:\\exists\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right):\\mathcal{O}\\cong\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right)', '\\forall\\mathcal{O}\\in\\mathcal{G}_F:\\exists\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right):\\mathcal{O}\\cong\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right)',
    'Jede betrachtete funktionale Organisation besitzt eine hinreichende funktionale Repräsentation.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.569'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Bedingung funktionaler Repräsentierbarkeit',
    equation_latex = '\\forall\\mathcal{O}\\in\\mathcal{G}_F:\\exists\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right):\\mathcal{O}\\cong\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right)',
    word_latex = '\\forall\\mathcal{O}\\in\\mathcal{G}_F:\\exists\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right):\\mathcal{O}\\cong\\left(\\Omega_F,R_F,O_F,K_F,X_F,T_F\\right)',
    plain_description = 'Jede betrachtete funktionale Organisation besitzt eine hinreichende funktionale Repräsentation.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.569'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.570', @section_3395, 'Funktionale Repräsentierbarkeit',
    '\\cong', '\\cong',
    'Symbol einer hinreichenden funktionalen Repräsentierbarkeit.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.570'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Funktionale Repräsentierbarkeit',
    equation_latex = '\\cong',
    word_latex = '\\cong',
    plain_description = 'Symbol einer hinreichenden funktionalen Repräsentierbarkeit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.570'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.571', @section_3395, 'Relative funktionale Vollständigkeit',
    '\\mathcal{V}_{\\mathrm{fun}}\\left(\\mathfrak{L}_F\\mid\\mathcal{C}_F\\right)', '\\mathcal{V}_{\\mathrm{fun}}\\left(\\mathfrak{L}_F\\mid\\mathcal{C}_F\\right)',
    'Funktionale Vollständigkeit relativ zur Klasse rekonstruierbarer Systeme.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.571'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Relative funktionale Vollständigkeit',
    equation_latex = '\\mathcal{V}_{\\mathrm{fun}}\\left(\\mathfrak{L}_F\\mid\\mathcal{C}_F\\right)',
    word_latex = '\\mathcal{V}_{\\mathrm{fun}}\\left(\\mathfrak{L}_F\\mid\\mathcal{C}_F\\right)',
    plain_description = 'Funktionale Vollständigkeit relativ zur Klasse rekonstruierbarer Systeme.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.571'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.572', @section_3395, 'Klasse funktional rekonstruierbarer Systeme',
    '\\mathcal{C}_F\\subseteq\\mathcal{G}_F', '\\mathcal{C}_F\\subseteq\\mathcal{G}_F',
    'Teilklasse des Geltungsbereichs, die funktional rekonstruierbar ist.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.572'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Klasse funktional rekonstruierbarer Systeme',
    equation_latex = '\\mathcal{C}_F\\subseteq\\mathcal{G}_F',
    word_latex = '\\mathcal{C}_F\\subseteq\\mathcal{G}_F',
    plain_description = 'Teilklasse des Geltungsbereichs, die funktional rekonstruierbar ist.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.572'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.573', @section_3395, 'Formallogische Vollständigkeit',
    '\\mathcal{V}_{\\mathrm{log}}\\Leftrightarrow\\forall P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\lor\\mathfrak{L}_F\\vdash\\neg P', '\\mathcal{V}_{\\mathrm{log}}\\Leftrightarrow\\forall P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\lor\\mathfrak{L}_F\\vdash\\neg P',
    'Jede wohlgeformte Aussage oder ihre Negation ist ableitbar.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.573'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Formallogische Vollständigkeit',
    equation_latex = '\\mathcal{V}_{\\mathrm{log}}\\Leftrightarrow\\forall P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\lor\\mathfrak{L}_F\\vdash\\neg P',
    word_latex = '\\mathcal{V}_{\\mathrm{log}}\\Leftrightarrow\\forall P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\vdash P\\lor\\mathfrak{L}_F\\vdash\\neg P',
    plain_description = 'Jede wohlgeformte Aussage oder ihre Negation ist ableitbar.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.573'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.574', @section_3395, 'Menge wohlgeformter Aussagen',
    '\\operatorname{Form}\\left(\\mathfrak{L}_F\\right)', '\\operatorname{Form}\\left(\\mathfrak{L}_F\\right)',
    'Menge aller wohlgeformten Aussagen der formalen Sprache.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.574'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Menge wohlgeformter Aussagen',
    equation_latex = '\\operatorname{Form}\\left(\\mathfrak{L}_F\\right)',
    word_latex = '\\operatorname{Form}\\left(\\mathfrak{L}_F\\right)',
    plain_description = 'Menge aller wohlgeformten Aussagen der formalen Sprache.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.574'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.575', @section_3395, 'Existenz unentscheidbarer Aussagen',
    '\\exists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\nvdash P\\land\\mathfrak{L}_F\\nvdash\\neg P', '\\exists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\nvdash P\\land\\mathfrak{L}_F\\nvdash\\neg P',
    'Es können Aussagen existieren, für die weder Beweis noch Gegenbeweis ableitbar ist.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.575'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Existenz unentscheidbarer Aussagen',
    equation_latex = '\\exists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\nvdash P\\land\\mathfrak{L}_F\\nvdash\\neg P',
    word_latex = '\\exists P\\in\\operatorname{Form}\\left(\\mathfrak{L}_F\\right):\\mathfrak{L}_F\\nvdash P\\land\\mathfrak{L}_F\\nvdash\\neg P',
    plain_description = 'Es können Aussagen existieren, für die weder Beweis noch Gegenbeweis ableitbar ist.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.575'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.576', @section_3395, 'Unentscheidbarkeitsprädikat',
    '\\operatorname{Unent}_{\\mathfrak{L}_F}\\left(P\\right)', '\\operatorname{Unent}_{\\mathfrak{L}_F}\\left(P\\right)',
    'Kennzeichnung einer innerhalb des Systems unentscheidbaren Aussage.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.576'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Unentscheidbarkeitsprädikat',
    equation_latex = '\\operatorname{Unent}_{\\mathfrak{L}_F}\\left(P\\right)',
    word_latex = '\\operatorname{Unent}_{\\mathfrak{L}_F}\\left(P\\right)',
    plain_description = 'Kennzeichnung einer innerhalb des Systems unentscheidbaren Aussage.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.576'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.577', @section_3395, 'Konsistenz impliziert keine Vollständigkeit',
    '\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)\\nRightarrow\\mathcal{V}_{\\mathrm{log}}', '\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)\\nRightarrow\\mathcal{V}_{\\mathrm{log}}',
    'Ein konsistentes System muss nicht formallogisch vollständig sein.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.577'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Konsistenz impliziert keine Vollständigkeit',
    equation_latex = '\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)\\nRightarrow\\mathcal{V}_{\\mathrm{log}}',
    word_latex = '\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)\\nRightarrow\\mathcal{V}_{\\mathrm{log}}',
    plain_description = 'Ein konsistentes System muss nicht formallogisch vollständig sein.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.577'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.578', @section_3395, 'Unvollständigkeit impliziert keine Inkonsistenz',
    '\\neg\\mathcal{V}_{\\mathrm{log}}\\nRightarrow\\neg\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)', '\\neg\\mathcal{V}_{\\mathrm{log}}\\nRightarrow\\neg\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)',
    'Formallogische Unvollständigkeit bedeutet nicht Inkonsistenz.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.578'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Unvollständigkeit impliziert keine Inkonsistenz',
    equation_latex = '\\neg\\mathcal{V}_{\\mathrm{log}}\\nRightarrow\\neg\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)',
    word_latex = '\\neg\\mathcal{V}_{\\mathrm{log}}\\nRightarrow\\neg\\operatorname{Con}\\left(\\mathfrak{L}_F\\right)',
    plain_description = 'Formallogische Unvollständigkeit bedeutet nicht Inkonsistenz.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.578'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.579', @section_3395, 'Aufgabenmenge der Rekonstruktion',
    '\\mathcal{Q}_F=\\left\\{q_1,q_2,\\ldots,q_n\\right\\}', '\\mathcal{Q}_F=\\left\\{q_1,q_2,\\ldots,q_n\\right\\}',
    'Menge der notwendigen Beschreibungs- und Ableitungsaufgaben.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.579'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Aufgabenmenge der Rekonstruktion',
    equation_latex = '\\mathcal{Q}_F=\\left\\{q_1,q_2,\\ldots,q_n\\right\\}',
    word_latex = '\\mathcal{Q}_F=\\left\\{q_1,q_2,\\ldots,q_n\\right\\}',
    plain_description = 'Menge der notwendigen Beschreibungs- und Ableitungsaufgaben.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.579'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.580', @section_3395, 'Bedingung zielbezogener Vollständigkeit',
    '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq\\mathfrak{L}_F:\\Gamma_i\\vdash q_i', '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    'Jede Rekonstruktionsaufgabe ist durch eine Teilmenge des formalen Systems ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.580'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Bedingung zielbezogener Vollständigkeit',
    equation_latex = '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    word_latex = '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    plain_description = 'Jede Rekonstruktionsaufgabe ist durch eine Teilmenge des formalen Systems ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.580'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.581', @section_3395, 'Aufgabenspezifische Voraussetzungen',
    '\\Gamma_i', '\\Gamma_i',
    'Für eine Rekonstruktionsaufgabe erforderliche Axiome, Definitionen und Propositionen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.581'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Aufgabenspezifische Voraussetzungen',
    equation_latex = '\\Gamma_i',
    word_latex = '\\Gamma_i',
    plain_description = 'Für eine Rekonstruktionsaufgabe erforderliche Axiome, Definitionen und Propositionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.581'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.582', @section_3395, 'Zentrale Rekonstruktionsaufgaben',
    '\\mathcal{Q}_F=\\left\\{q_{\\mathrm{Zustand}},q_{\\mathrm{Relation}},q_{\\mathrm{Operation}},q_{\\mathrm{Kohärenz}},q_{\\mathrm{Transition}},q_{\\mathrm{Attraktor}}\\right\\}', '\\mathcal{Q}_F=\\left\\{q_{\\mathrm{Zustand}},q_{\\mathrm{Relation}},q_{\\mathrm{Operation}},q_{\\mathrm{Kohärenz}},q_{\\mathrm{Transition}},q_{\\mathrm{Attraktor}}\\right\\}',
    'Zentrale Aufgaben der mathematischen Rekonstruktion in Kapitel 3.4.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.582'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Zentrale Rekonstruktionsaufgaben',
    equation_latex = '\\mathcal{Q}_F=\\left\\{q_{\\mathrm{Zustand}},q_{\\mathrm{Relation}},q_{\\mathrm{Operation}},q_{\\mathrm{Kohärenz}},q_{\\mathrm{Transition}},q_{\\mathrm{Attraktor}}\\right\\}',
    word_latex = '\\mathcal{Q}_F=\\left\\{q_{\\mathrm{Zustand}},q_{\\mathrm{Relation}},q_{\\mathrm{Operation}},q_{\\mathrm{Kohärenz}},q_{\\mathrm{Transition}},q_{\\mathrm{Attraktor}}\\right\\}',
    plain_description = 'Zentrale Aufgaben der mathematischen Rekonstruktion in Kapitel 3.4.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.582'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.583', @section_3395, 'Folge erweiterter Systemstände',
    '\\mathfrak{L}_F^{(0)}\\subseteq\\mathfrak{L}_F^{(1)}\\subseteq\\mathfrak{L}_F^{(2)}\\subseteq\\cdots', '\\mathfrak{L}_F^{(0)}\\subseteq\\mathfrak{L}_F^{(1)}\\subseteq\\mathfrak{L}_F^{(2)}\\subseteq\\cdots',
    'Monotone Folge zulässiger Erweiterungen des formalen Systems.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.583'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Folge erweiterter Systemstände',
    equation_latex = '\\mathfrak{L}_F^{(0)}\\subseteq\\mathfrak{L}_F^{(1)}\\subseteq\\mathfrak{L}_F^{(2)}\\subseteq\\cdots',
    word_latex = '\\mathfrak{L}_F^{(0)}\\subseteq\\mathfrak{L}_F^{(1)}\\subseteq\\mathfrak{L}_F^{(2)}\\subseteq\\cdots',
    plain_description = 'Monotone Folge zulässiger Erweiterungen des formalen Systems.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.583'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.584', @section_3395, 'Form einer Systemerweiterung',
    '\\mathfrak{L}_F^{(n+1)}=\\mathfrak{L}_F^{(n)}\\cup\\Delta\\mathfrak{L}_F^{(n)}', '\\mathfrak{L}_F^{(n+1)}=\\mathfrak{L}_F^{(n)}\\cup\\Delta\\mathfrak{L}_F^{(n)}',
    'Erweiterter Systemstand als Vereinigung des Ausgangsstands mit einer Ergänzung.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.584'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Form einer Systemerweiterung',
    equation_latex = '\\mathfrak{L}_F^{(n+1)}=\\mathfrak{L}_F^{(n)}\\cup\\Delta\\mathfrak{L}_F^{(n)}',
    word_latex = '\\mathfrak{L}_F^{(n+1)}=\\mathfrak{L}_F^{(n)}\\cup\\Delta\\mathfrak{L}_F^{(n)}',
    plain_description = 'Erweiterter Systemstand als Vereinigung des Ausgangsstands mit einer Ergänzung.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.584'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.585', @section_3395, 'Konsistenzerhaltende Erweiterung',
    '\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n)}\\right)\\land\\operatorname{Kompat}\\left(\\Delta\\mathfrak{L}_F^{(n)},\\mathfrak{L}_F^{(n)}\\right)\\Rightarrow\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n+1)}\\right)', '\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n)}\\right)\\land\\operatorname{Kompat}\\left(\\Delta\\mathfrak{L}_F^{(n)},\\mathfrak{L}_F^{(n)}\\right)\\Rightarrow\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n+1)}\\right)',
    'Eine kompatible Erweiterung soll die Konsistenz des Systems erhalten.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.585'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Konsistenzerhaltende Erweiterung',
    equation_latex = '\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n)}\\right)\\land\\operatorname{Kompat}\\left(\\Delta\\mathfrak{L}_F^{(n)},\\mathfrak{L}_F^{(n)}\\right)\\Rightarrow\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n+1)}\\right)',
    word_latex = '\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n)}\\right)\\land\\operatorname{Kompat}\\left(\\Delta\\mathfrak{L}_F^{(n)},\\mathfrak{L}_F^{(n)}\\right)\\Rightarrow\\operatorname{Con}\\left(\\mathfrak{L}_F^{(n+1)}\\right)',
    plain_description = 'Eine kompatible Erweiterung soll die Konsistenz des Systems erhalten.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.585'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.586', @section_3395, 'Kompatibilitätsprädikat',
    '\\operatorname{Kompat}', '\\operatorname{Kompat}',
    'Prädikat der logischen und begrifflichen Vereinbarkeit einer Erweiterung.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.586'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Kompatibilitätsprädikat',
    equation_latex = '\\operatorname{Kompat}',
    word_latex = '\\operatorname{Kompat}',
    plain_description = 'Prädikat der logischen und begrifflichen Vereinbarkeit einer Erweiterung.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.586'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.587', @section_3395, 'Zielbezogene Vollständigkeit des FRZK',
    '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i', '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    'Jede Rekonstruktionsaufgabe wird durch eine endliche Teilmenge des formalen Systems bearbeitet.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.587'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Zielbezogene Vollständigkeit des FRZK',
    equation_latex = '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    word_latex = '\\forall q_i\\in\\mathcal{Q}_F:\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash q_i',
    plain_description = 'Jede Rekonstruktionsaufgabe wird durch eine endliche Teilmenge des formalen Systems bearbeitet.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.587'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.588', @section_3395, 'Endliche Teilmenge',
    '\\subseteq_{\\mathrm{fin}}', '\\subseteq_{\\mathrm{fin}}',
    'Symbol für eine endliche Teilmenge.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.9.5.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.588'
);

UPDATE equations
SET
    section_id = @section_3395,
    title = 'Endliche Teilmenge',
    equation_latex = '\\subseteq_{\\mathrm{fin}}',
    word_latex = '\\subseteq_{\\mathrm{fin}}',
    plain_description = 'Symbol für eine endliche Teilmenge.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.5.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.4 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3395
WHERE equation_number = '3.588'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.12',
    @section_3395,
    'Zielbezogene Vollständigkeit des FRZK',
    'Das FRZK ist für die mathematische Rekonstruktion funktionaler Organisationen zielbezogen vollständig, wenn sämtliche in der Aufgabenmenge festgelegten Rekonstruktionsaufgaben durch endliche Teilmengen des formalen Systems bearbeitet werden können.',
    '\forall q_i\in\mathcal{Q}_F:\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash q_i',
    '\forall q_i\in\mathcal{Q}_F:\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash q_i',
    'Die Vollständigkeit wird nicht als universelle formallogische Entscheidbarkeit, sondern relativ zur Menge der in Kapitel 3.4 erforderlichen Rekonstruktionsaufgaben bestimmt. Für jede Aufgabe muss eine endliche Menge zulässiger Axiome, Definitionen und Propositionen existieren, aus der die jeweilige Rekonstruktionsleistung ableitbar ist.',
    'A1,A2,A3,A4,A5,A6,A7',
    'accepted',
    @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM propositions WHERE proposition_number = '3.3.12'
);

UPDATE propositions
SET
    section_id = @section_3395,
    title = 'Zielbezogene Vollständigkeit des FRZK',
    statement_text = 'Das FRZK ist für die mathematische Rekonstruktion funktionaler Organisationen zielbezogen vollständig, wenn sämtliche in der Aufgabenmenge festgelegten Rekonstruktionsaufgaben durch endliche Teilmengen des formalen Systems bearbeitet werden können.',
    statement_latex = '\forall q_i\in\mathcal{Q}_F:\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash q_i',
    word_latex = '\forall q_i\in\mathcal{Q}_F:\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash q_i',
    logical_derivation = 'Die Vollständigkeit wird nicht als universelle formallogische Entscheidbarkeit, sondern relativ zur Menge der in Kapitel 3.4 erforderlichen Rekonstruktionsaufgaben bestimmt. Für jede Aufgabe muss eine endliche Menge zulässiger Axiome, Definitionen und Propositionen existieren, aus der die jeweilige Rekonstruktionsleistung ableitbar ist.',
    based_on_axioms = 'A1,A2,A3,A4,A5,A6,A7',
    status = 'accepted',
    created_revision_id = @revision_3395
WHERE proposition_number = '3.3.12'
AND @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL;

SET @proposition_3312 := (
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.12'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(
    proposition_id, axiom_id, assumption_id, dependency_type, note
)
SELECT
    @proposition_3312,
    a.axiom_id,
    NULL,
    'derived_from',
    CONCAT('Proposition 3.3.12 verwendet ', a.axiom_number,
           ' als Bestandteil des funktionalen Rekonstruktionsrahmens.')
FROM axioms a
WHERE @proposition_3312 IS NOT NULL
AND a.axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies pd
    WHERE pd.proposition_id = @proposition_3312
      AND pd.axiom_id = a.axiom_id
      AND pd.assumption_id IS NULL
      AND pd.dependency_type = 'derived_from'
);


SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.558' LIMIT 1
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
    '\\mathcal{V}_F', '\\mathcal{V}_F', 'Vollständigkeitsstruktur', 'Gesamtstruktur der im FRZK unterschiedenen Vollständigkeitsformen',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{V}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{V}_F', 'Vollständigkeitsstruktur',
    'Gesamtstruktur der im FRZK unterschiedenen Vollständigkeitsformen', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{V}_F'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.559' LIMIT 1
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
    '\\mathcal{V}_{\\mathrm{begr}}', '\\mathcal{V}_{\\mathrm{begr}}', 'Begriffliche Vollständigkeit', 'Vollständigkeit des Begriffssystems relativ zum Geltungsbereich',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{V}_{\\mathrm{begr}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{V}_{\\mathrm{begr}}', 'Begriffliche Vollständigkeit',
    'Vollständigkeit des Begriffssystems relativ zum Geltungsbereich', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{V}_{\\mathrm{begr}}'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.560' LIMIT 1
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
    '\\mathcal{V}_{\\mathrm{fun}}', '\\mathcal{V}_{\\mathrm{fun}}', 'Funktionale Vollständigkeit', 'Vollständigkeit der funktionalen Beschreibung',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{V}_{\\mathrm{fun}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{V}_{\\mathrm{fun}}', 'Funktionale Vollständigkeit',
    'Vollständigkeit der funktionalen Beschreibung', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{V}_{\\mathrm{fun}}'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.561' LIMIT 1
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
    '\\mathcal{V}_{\\mathrm{log}}', '\\mathcal{V}_{\\mathrm{log}}', 'Formallogische Vollständigkeit', 'Entscheidbarkeit jeder wohlgeformten Aussage oder ihrer Negation',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{V}_{\\mathrm{log}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{V}_{\\mathrm{log}}', 'Formallogische Vollständigkeit',
    'Entscheidbarkeit jeder wohlgeformten Aussage oder ihrer Negation', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{V}_{\\mathrm{log}}'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.562' LIMIT 1
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
    '\\mathcal{B}_F', '\\mathcal{B}_F', 'Grundbegriffsmenge', 'Menge aller Grundbegriffe des FRZK',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{B}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{B}_F', 'Grundbegriffsmenge',
    'Menge aller Grundbegriffe des FRZK', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{B}_F'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.567' LIMIT 1
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
    '\\mathcal{G}_F', '\\mathcal{G}_F', 'Geltungsbereich', 'Festgelegter Geltungsbereich des FRZK',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{G}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{G}_F', 'Geltungsbereich',
    'Festgelegter Geltungsbereich des FRZK', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{G}_F'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.568' LIMIT 1
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
    '\\mathcal{K}_F', '\\mathcal{K}_F', 'Komponentenmenge', 'Strukturkomponenten einer funktionalen Beschreibung',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{K}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{K}_F', 'Komponentenmenge',
    'Strukturkomponenten einer funktionalen Beschreibung', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{K}_F'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.572' LIMIT 1
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
    '\\mathcal{C}_F', '\\mathcal{C}_F', 'Rekonstruierbare Systemklasse', 'Klasse funktional rekonstruierbarer Systeme',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{C}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{C}_F', 'Rekonstruierbare Systemklasse',
    'Klasse funktional rekonstruierbarer Systeme', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{C}_F'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.574' LIMIT 1
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
    '\\operatorname{Form}', '\\operatorname{Form}', 'Formoperator', 'Operator für die Menge wohlgeformter Aussagen',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Form}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\operatorname{Form}', 'Formoperator',
    'Operator für die Menge wohlgeformter Aussagen', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\operatorname{Form}'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.576' LIMIT 1
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
    '\\operatorname{Unent}', '\\operatorname{Unent}', 'Unentscheidbarkeitsprädikat', 'Kennzeichnet innerhalb des Systems unentscheidbare Aussagen',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Unent}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\operatorname{Unent}', 'Unentscheidbarkeitsprädikat',
    'Kennzeichnet innerhalb des Systems unentscheidbare Aussagen', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\operatorname{Unent}'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.579' LIMIT 1
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
    '\\mathcal{Q}_F', '\\mathcal{Q}_F', 'Rekonstruktionsaufgaben', 'Menge der zielbezogenen Rekonstruktionsaufgaben',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{Q}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\mathcal{Q}_F', 'Rekonstruktionsaufgaben',
    'Menge der zielbezogenen Rekonstruktionsaufgaben', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\mathcal{Q}_F'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.581' LIMIT 1
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
    '\\Gamma_i', '\\Gamma_i', 'Aufgabenvoraussetzungen', 'Endliche Teilmenge der für eine Aufgabe benötigten Systemelemente',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\Gamma_i'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\Gamma_i', 'Aufgabenvoraussetzungen',
    'Endliche Teilmenge der für eine Aufgabe benötigten Systemelemente', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\Gamma_i'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.586' LIMIT 1
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
    '\\operatorname{Kompat}', '\\operatorname{Kompat}', 'Kompatibilitätsprädikat', 'Prädikat der Vereinbarkeit einer Systemerweiterung',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{Kompat}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\operatorname{Kompat}', 'Kompatibilitätsprädikat',
    'Prädikat der Vereinbarkeit einer Systemerweiterung', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\operatorname{Kompat}'
);

SET @eq_symbol_3395 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.588' LIMIT 1
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
    '\\subseteq_{\\mathrm{fin}}', '\\subseteq_{\\mathrm{fin}}', 'Endliche Teilmengenrelation', 'Relation der endlichen Teilmengenbildung',
    'chapter', @section_3395, @eq_symbol_3395,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.9.5 eingeführt oder präzisiert.',
    'checked', @revision_3395
WHERE @section_3395 IS NOT NULL
AND @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\subseteq_{\\mathrm{fin}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3395, '\\subseteq_{\\mathrm{fin}}', 'Endliche Teilmengenrelation',
    'Relation der endlichen Teilmengenbildung', NULL, NULL, 1
WHERE @eq_symbol_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3395
      AND symbol_latex = '\\subseteq_{\\mathrm{fin}}'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3395, @section_3395, 'created', 'section', '3.3.9.5',
    'Abschnitt 3.3.9.5 vollständig angelegt.',
    NULL, 'Reichweite und Grenzen der Vollständigkeit'
WHERE @revision_3395 IS NOT NULL
AND @section_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3395
      AND object_type = 'section'
      AND object_reference = '3.3.9.5'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3395, @section_3395, 'proposition_added', 'proposition', '3.3.12',
    'Proposition 3.3.12 registriert.',
    NULL, 'Zielbezogene Vollständigkeit des FRZK'
WHERE @revision_3395 IS NOT NULL
AND @section_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3395
      AND object_type = 'proposition'
      AND object_reference = '3.3.12'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3395, @section_3395, 'equation_added', 'equation', '(3.558)–(3.588)',
    '31 Gleichungen und formale Schemata registriert.',
    NULL, 'Gleichungen (3.558) bis (3.588)'
WHERE @revision_3395 IS NOT NULL
AND @section_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3395
      AND object_type = 'equation'
      AND object_reference = '(3.558)–(3.588)'
);

SET @equation_count_3395 := (
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
        '3.558','3.559','3.560','3.561','3.562','3.563','3.564','3.565',
        '3.566','3.567','3.568','3.569','3.570','3.571','3.572','3.573',
        '3.574','3.575','3.576','3.577','3.578','3.579','3.580','3.581',
        '3.582','3.583','3.584','3.585','3.586','3.587','3.588'
    )
);

SET @dependency_count_3395 := (
    SELECT COUNT(*)
    FROM proposition_dependencies
    WHERE proposition_id = @proposition_3312
      AND dependency_type = 'derived_from'
);

SET @symbol_count_3395 := (
    SELECT COUNT(*)
    FROM symbols
    WHERE scope_type = 'chapter'
      AND symbol_latex IN
      (
          '\mathcal{V}_F',
          '\mathcal{V}_{\mathrm{begr}}',
          '\mathcal{V}_{\mathrm{fun}}',
          '\mathcal{V}_{\mathrm{log}}',
          '\mathcal{B}_F',
          '\mathcal{G}_F',
          '\mathcal{K}_F',
          '\mathcal{C}_F',
          '\operatorname{Form}',
          '\operatorname{Unent}',
          '\mathcal{Q}_F',
          '\Gamma_i',
          '\operatorname{Kompat}',
          '\subseteq_{\mathrm{fin}}'
      )
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3395, 'K3.3.9.5.PRECONDITION',
    CASE WHEN @precondition_ok_3395 = 1 THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @precondition_ok_3395 = 1 THEN '1' ELSE '0' END,
    'Prüfung der Elternrevision und des übergeordneten Abschnitts.'
WHERE @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3395
      AND validation_code = 'K3.3.9.5.PRECONDITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3395, 'K3.3.9.5.SECTION',
    CASE WHEN @section_3395 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @section_3395 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung des Abschnitts 3.3.9.5.'
WHERE @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3395
      AND validation_code = 'K3.3.9.5.SECTION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3395, 'K3.3.9.5.PROPOSITION',
    CASE WHEN @proposition_3312 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @proposition_3312 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung der Proposition 3.3.12.'
WHERE @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3395
      AND validation_code = 'K3.3.9.5.PROPOSITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3395, 'K3.3.9.5.EQUATIONS',
    CASE WHEN @equation_count_3395 = 31 THEN 'passed' ELSE 'failed' END,
    '31', CAST(@equation_count_3395 AS CHAR),
    'Prüfung der Gleichungen (3.558) bis (3.588).'
WHERE @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3395
      AND validation_code = 'K3.3.9.5.EQUATIONS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3395, 'K3.3.9.5.AXIOM_DEPENDENCIES',
    CASE WHEN @dependency_count_3395 = 7 THEN 'passed' ELSE 'failed' END,
    '7', CAST(@dependency_count_3395 AS CHAR),
    'Prüfung der sieben Axiomabhängigkeiten von Proposition 3.3.12.'
WHERE @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3395
      AND validation_code = 'K3.3.9.5.AXIOM_DEPENDENCIES'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3395, 'K3.3.9.5.SYMBOLS',
    CASE WHEN @symbol_count_3395 = 14 THEN 'passed' ELSE 'failed' END,
    '14', CAST(@symbol_count_3395 AS CHAR),
    'Prüfung der vierzehn zentralen Symbolregistrierungen.'
WHERE @revision_3395 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3395
      AND validation_code = 'K3.3.9.5.SYMBOLS'
);

COMMIT;

SELECT
    CASE
        WHEN @parent_revision_3395 IS NULL
            THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.9.4-V1 fehlt.'
        WHEN @parent_section_3395 IS NULL
            THEN 'FEHLER: Übergeordneter Abschnitt 3.3.9 fehlt.'
        WHEN @revision_3395 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.9.5-V1 wurde nicht angelegt.'
        WHEN @section_3395 IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9.5 wurde nicht angelegt.'
        WHEN @proposition_3312 IS NULL
            THEN 'FEHLER: Proposition 3.3.12 wurde nicht angelegt.'
        WHEN @equation_count_3395 <> 31
            THEN CONCAT('FEHLER: ', @equation_count_3395, ' statt 31 Gleichungen vorhanden.')
        WHEN @dependency_count_3395 <> 7
            THEN CONCAT('FEHLER: ', @dependency_count_3395, ' statt 7 Axiomabhängigkeiten vorhanden.')
        WHEN @symbol_count_3395 <> 14
            THEN CONCAT('FEHLER: ', @symbol_count_3395, ' statt 14 zentralen Symbolen vorhanden.')
        ELSE 'OK: Repository-Update 3.3.9.5 vollständig und konsistent ausgeführt.'
    END AS import_status;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_3395
ORDER BY validation_code;
