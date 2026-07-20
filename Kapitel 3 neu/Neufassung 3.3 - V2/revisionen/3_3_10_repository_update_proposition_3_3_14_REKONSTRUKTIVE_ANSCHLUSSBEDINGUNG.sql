/* ============================================================================
   FRZK-RKB – Repository-Update 3.3.10

   Abschnitt:
     3.3.10 Zusammenfassung und Übergang zur mathematischen Rekonstruktion

   Ausgangsstand:
     frzk_rkb_3.3.9.6.sql

   Elternrevision:
     RKB-NEU-K3.3.9.6-V1

   Registriert:
     - Revision RKB-NEU-K3.3.10-V1
     - Abschnitt 3.3.10
     - Proposition 3.3.14
     - Gleichungen (3.619) bis (3.641)
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

SET @parent_revision_3310 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.6-V1'
    LIMIT 1
);

SET @chapter_section_3310 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3'
    LIMIT 1
);

SET @precondition_ok_3310 := (
    @parent_revision_3310 IS NOT NULL
    AND @chapter_section_3310 IS NOT NULL
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.10-V1',
    NOW(),
    'section',
    '3.3.10',
    '1.0',
    'Kapitelabschluss 3.3: Zusammenfassung, Rekonstruktionsübergang, Proposition 3.3.14 und Gleichungen (3.619) bis (3.641).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_3310
WHERE @precondition_ok_3310 = 1
AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.10-V1'
);

SET @revision_3310 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.10-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_section_3310,
    '3.3.10',
    'Zusammenfassung und Übergang zur mathematischen Rekonstruktion',
    3,
    3.3100,
    'final',
    1,
    'Redaktioneller und formaler Abschluss von Kapitel 3.3 sowie Überleitung zu Kapitel 3.4.'
WHERE @revision_3310 IS NOT NULL
AND @chapter_section_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3.10'
);

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_3310,
    title = 'Zusammenfassung und Übergang zur mathematischen Rekonstruktion',
    chapter_no = 3,
    section_order = 3.3100,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Redaktioneller und formaler Abschluss von Kapitel 3.3 sowie Überleitung zu Kapitel 3.4.'
WHERE section_code = '3.3.10'
AND @chapter_section_3310 IS NOT NULL;

SET @section_3310 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.10'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.619', @section_3310, 'Grundlegende Ableitungsrichtung',
    'A_F\\rightarrow D_F\\rightarrow R_F\\rightarrow O_F\\rightarrow K_F\\rightarrow X_F\\rightarrow T_F', 'A_F\\rightarrow D_F\\rightarrow R_F\\rightarrow O_F\\rightarrow K_F\\rightarrow X_F\\rightarrow T_F',
    'Logische Ableitungsrichtung von funktionaler Unterscheidbarkeit bis zum Übergang.', 'schema', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.619'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Grundlegende Ableitungsrichtung',
    equation_latex = 'A_F\\rightarrow D_F\\rightarrow R_F\\rightarrow O_F\\rightarrow K_F\\rightarrow X_F\\rightarrow T_F',
    word_latex = 'A_F\\rightarrow D_F\\rightarrow R_F\\rightarrow O_F\\rightarrow K_F\\rightarrow X_F\\rightarrow T_F',
    plain_description = 'Logische Ableitungsrichtung von funktionaler Unterscheidbarkeit bis zum Übergang.',
    equation_type = 'schema',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.619'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.620', @section_3310, 'Rückwärts gerichtete Bedingungsstruktur',
    'T_F\\Rightarrow X_F\\Rightarrow K_F\\Rightarrow O_F\\Rightarrow R_F\\Rightarrow D_F\\Rightarrow A_F', 'T_F\\Rightarrow X_F\\Rightarrow K_F\\Rightarrow O_F\\Rightarrow R_F\\Rightarrow D_F\\Rightarrow A_F',
    'Jede spätere Ebene setzt die logisch vorausgehenden Ebenen voraus.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.620'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Rückwärts gerichtete Bedingungsstruktur',
    equation_latex = 'T_F\\Rightarrow X_F\\Rightarrow K_F\\Rightarrow O_F\\Rightarrow R_F\\Rightarrow D_F\\Rightarrow A_F',
    word_latex = 'T_F\\Rightarrow X_F\\Rightarrow K_F\\Rightarrow O_F\\Rightarrow R_F\\Rightarrow D_F\\Rightarrow A_F',
    plain_description = 'Jede spätere Ebene setzt die logisch vorausgehenden Ebenen voraus.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.620'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.621', @section_3310, 'Nicht notwendige Vorwärtsimplikation',
    'A_F\\nRightarrow D_F\\nRightarrow R_F\\nRightarrow O_F\\nRightarrow K_F\\nRightarrow X_F\\nRightarrow T_F', 'A_F\\nRightarrow D_F\\nRightarrow R_F\\nRightarrow O_F\\nRightarrow K_F\\nRightarrow X_F\\nRightarrow T_F',
    'Aus einer früheren Ebene folgt die nächste nicht notwendig.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.621'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Nicht notwendige Vorwärtsimplikation',
    equation_latex = 'A_F\\nRightarrow D_F\\nRightarrow R_F\\nRightarrow O_F\\nRightarrow K_F\\nRightarrow X_F\\nRightarrow T_F',
    word_latex = 'A_F\\nRightarrow D_F\\nRightarrow R_F\\nRightarrow O_F\\nRightarrow K_F\\nRightarrow X_F\\nRightarrow T_F',
    plain_description = 'Aus einer früheren Ebene folgt die nächste nicht notwendig.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.621'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.622', @section_3310, 'Axiomenmenge des FRZK',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}', '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    'Menge der sieben Grundaxiome des FRZK.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.622'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiomenmenge des FRZK',
    equation_latex = '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    word_latex = '\\mathcal{A}_{\\mathrm{FRZK}}=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    plain_description = 'Menge der sieben Grundaxiome des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.622'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.623', @section_3310, 'Axiom A1',
    'A_1:\\text{funktionale Unterscheidbarkeit}', 'A_1:\\text{funktionale Unterscheidbarkeit}',
    'Kurzbezeichnung des Axioms funktionaler Unterscheidbarkeit.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.623'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A1',
    equation_latex = 'A_1:\\text{funktionale Unterscheidbarkeit}',
    word_latex = 'A_1:\\text{funktionale Unterscheidbarkeit}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Unterscheidbarkeit.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.623'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.624', @section_3310, 'Axiom A2',
    'A_2:\\text{funktionale Relationierbarkeit}', 'A_2:\\text{funktionale Relationierbarkeit}',
    'Kurzbezeichnung des Axioms funktionaler Relationierbarkeit.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.624'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A2',
    equation_latex = 'A_2:\\text{funktionale Relationierbarkeit}',
    word_latex = 'A_2:\\text{funktionale Relationierbarkeit}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Relationierbarkeit.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.624'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.625', @section_3310, 'Axiom A3',
    'A_3:\\text{funktionale Operierbarkeit}', 'A_3:\\text{funktionale Operierbarkeit}',
    'Kurzbezeichnung des Axioms funktionaler Operierbarkeit.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.625'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A3',
    equation_latex = 'A_3:\\text{funktionale Operierbarkeit}',
    word_latex = 'A_3:\\text{funktionale Operierbarkeit}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Operierbarkeit.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.625'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.626', @section_3310, 'Axiom A4',
    'A_4:\\text{funktionale Komponierbarkeit}', 'A_4:\\text{funktionale Komponierbarkeit}',
    'Kurzbezeichnung des Axioms funktionaler Komponierbarkeit.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.626'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A4',
    equation_latex = 'A_4:\\text{funktionale Komponierbarkeit}',
    word_latex = 'A_4:\\text{funktionale Komponierbarkeit}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Komponierbarkeit.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.626'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.627', @section_3310, 'Axiom A5',
    'A_5:\\text{funktionale Kohärenzbildung}', 'A_5:\\text{funktionale Kohärenzbildung}',
    'Kurzbezeichnung des Axioms funktionaler Kohärenzbildung.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.627'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A5',
    equation_latex = 'A_5:\\text{funktionale Kohärenzbildung}',
    word_latex = 'A_5:\\text{funktionale Kohärenzbildung}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Kohärenzbildung.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.627'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.628', @section_3310, 'Axiom A6',
    'A_6:\\text{funktionale Zustandsbildung}', 'A_6:\\text{funktionale Zustandsbildung}',
    'Kurzbezeichnung des Axioms funktionaler Zustandsbildung.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.628'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A6',
    equation_latex = 'A_6:\\text{funktionale Zustandsbildung}',
    word_latex = 'A_6:\\text{funktionale Zustandsbildung}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Zustandsbildung.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.628'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.629', @section_3310, 'Axiom A7',
    'A_7:\\text{funktionale Übergangsfähigkeit}', 'A_7:\\text{funktionale Übergangsfähigkeit}',
    'Kurzbezeichnung des Axioms funktionaler Übergangsfähigkeit.', 'axiom', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.629'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Axiom A7',
    equation_latex = 'A_7:\\text{funktionale Übergangsfähigkeit}',
    word_latex = 'A_7:\\text{funktionale Übergangsfähigkeit}',
    plain_description = 'Kurzbezeichnung des Axioms funktionaler Übergangsfähigkeit.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.629'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.630', @section_3310, 'Funktionaler Vektor',
    '\\mathbf{v}=\\left(\\left\\|\\mathbf{v}\\right\\|,\\widehat{\\mathbf{v}}\\right)', '\\mathbf{v}=\\left(\\left\\|\\mathbf{v}\\right\\|,\\widehat{\\mathbf{v}}\\right)',
    'Darstellung eines funktionalen Vektors durch Betrag und Richtungswert.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.630'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Funktionaler Vektor',
    equation_latex = '\\mathbf{v}=\\left(\\left\\|\\mathbf{v}\\right\\|,\\widehat{\\mathbf{v}}\\right)',
    word_latex = '\\mathbf{v}=\\left(\\left\\|\\mathbf{v}\\right\\|,\\widehat{\\mathbf{v}}\\right)',
    plain_description = 'Darstellung eines funktionalen Vektors durch Betrag und Richtungswert.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.630'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.631', @section_3310, 'Nullbetragszustand',
    '0\\odot\\mathbf{v}=\\left(0,\\widehat{\\mathbf{v}}\\right)', '0\\odot\\mathbf{v}=\\left(0,\\widehat{\\mathbf{v}}\\right)',
    'Nullsetzung des Betrags bei Erhalt des Richtungswerts.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.631'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Nullbetragszustand',
    equation_latex = '0\\odot\\mathbf{v}=\\left(0,\\widehat{\\mathbf{v}}\\right)',
    word_latex = '0\\odot\\mathbf{v}=\\left(0,\\widehat{\\mathbf{v}}\\right)',
    plain_description = 'Nullsetzung des Betrags bei Erhalt des Richtungswerts.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.631'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.632', @section_3310, 'Vollständig gelöschter funktionaler Nullvektor',
    '\\mathbf{0}_F=\\left(0,\\varnothing\\right)', '\\mathbf{0}_F=\\left(0,\\varnothing\\right)',
    'Vollständige Löschung von Betrag und Richtungsinformation.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.632'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Vollständig gelöschter funktionaler Nullvektor',
    equation_latex = '\\mathbf{0}_F=\\left(0,\\varnothing\\right)',
    word_latex = '\\mathbf{0}_F=\\left(0,\\varnothing\\right)',
    plain_description = 'Vollständige Löschung von Betrag und Richtungsinformation.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.632'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.633', @section_3310, 'Rekonstruktionsabbildung',
    '\\mathfrak{R}:\\mathfrak{L}_F\\rightarrow\\mathfrak{S}_F', '\\mathfrak{R}:\\mathfrak{L}_F\\rightarrow\\mathfrak{S}_F',
    'Abbildung vom formalen System auf die Menge konstruierbarer mathematischer Strukturen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.633'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Rekonstruktionsabbildung',
    equation_latex = '\\mathfrak{R}:\\mathfrak{L}_F\\rightarrow\\mathfrak{S}_F',
    word_latex = '\\mathfrak{R}:\\mathfrak{L}_F\\rightarrow\\mathfrak{S}_F',
    plain_description = 'Abbildung vom formalen System auf die Menge konstruierbarer mathematischer Strukturen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.633'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.634', @section_3310, 'Aufgabenspezifische Rekonstruktion',
    '\\mathfrak{R}_{q_i}:\\Gamma_i\\mapsto S_i', '\\mathfrak{R}_{q_i}:\\Gamma_i\\mapsto S_i',
    'Zuordnung einer endlichen formalen Grundlage zu einer rekonstruierten Struktur.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.634'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Aufgabenspezifische Rekonstruktion',
    equation_latex = '\\mathfrak{R}_{q_i}:\\Gamma_i\\mapsto S_i',
    word_latex = '\\mathfrak{R}_{q_i}:\\Gamma_i\\mapsto S_i',
    plain_description = 'Zuordnung einer endlichen formalen Grundlage zu einer rekonstruierten Struktur.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.634'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.635', @section_3310, 'Endliche Rekonstruktionsgrundlage',
    '\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F', '\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F',
    'Endliche Teilmenge der benötigten Axiome, Definitionen und Propositionen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.635'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Endliche Rekonstruktionsgrundlage',
    equation_latex = '\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F',
    word_latex = '\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F',
    plain_description = 'Endliche Teilmenge der benötigten Axiome, Definitionen und Propositionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.635'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.636', @section_3310, 'Rekonstruierte Struktur',
    'S_i\\in\\mathfrak{S}_F', 'S_i\\in\\mathfrak{S}_F',
    'Zugehörigkeit einer Struktur zur Menge zulässiger mathematischer Rekonstruktionen.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.636'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Rekonstruierte Struktur',
    equation_latex = 'S_i\\in\\mathfrak{S}_F',
    word_latex = 'S_i\\in\\mathfrak{S}_F',
    plain_description = 'Zugehörigkeit einer Struktur zur Menge zulässiger mathematischer Rekonstruktionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.636'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.637', @section_3310, 'Gültigkeit einer Rekonstruktion',
    '\\operatorname{RekGült}\\left(S_i\\right)\\Leftrightarrow B_{\\mathrm{ableit}}\\land B_{\\mathrm{def}}\\land B_{\\mathrm{kons}}', '\\operatorname{RekGült}\\left(S_i\\right)\\Leftrightarrow B_{\\mathrm{ableit}}\\land B_{\\mathrm{def}}\\land B_{\\mathrm{kons}}',
    'Eine Rekonstruktion ist gültig bei Ableitbarkeit, eindeutiger Definition und Konsistenz.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.637'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Gültigkeit einer Rekonstruktion',
    equation_latex = '\\operatorname{RekGült}\\left(S_i\\right)\\Leftrightarrow B_{\\mathrm{ableit}}\\land B_{\\mathrm{def}}\\land B_{\\mathrm{kons}}',
    word_latex = '\\operatorname{RekGült}\\left(S_i\\right)\\Leftrightarrow B_{\\mathrm{ableit}}\\land B_{\\mathrm{def}}\\land B_{\\mathrm{kons}}',
    plain_description = 'Eine Rekonstruktion ist gültig bei Ableitbarkeit, eindeutiger Definition und Konsistenz.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.637'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.638', @section_3310, 'Ableitbarkeit zulässiger Rekonstruktionen',
    'S_i\\in\\mathfrak{S}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i', 'S_i\\in\\mathfrak{S}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i',
    'Jede zulässige Rekonstruktion ist aus einer endlichen Teilmenge des formalen Systems ableitbar.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.638'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Ableitbarkeit zulässiger Rekonstruktionen',
    equation_latex = 'S_i\\in\\mathfrak{S}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i',
    word_latex = 'S_i\\in\\mathfrak{S}_F\\Rightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i',
    plain_description = 'Jede zulässige Rekonstruktion ist aus einer endlichen Teilmenge des formalen Systems ableitbar.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.638'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.639', @section_3310, 'Trennung rekonstruktiver und empirischer Gültigkeit',
    '\\operatorname{RekGült}\\left(S_i\\right)\\nRightarrow\\operatorname{Bew}_{\\mathrm{emp}}\\left(S_i\\right)', '\\operatorname{RekGült}\\left(S_i\\right)\\nRightarrow\\operatorname{Bew}_{\\mathrm{emp}}\\left(S_i\\right)',
    'Formale Rekonstruktionsgültigkeit impliziert keine empirische Bewährung.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.639'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Trennung rekonstruktiver und empirischer Gültigkeit',
    equation_latex = '\\operatorname{RekGült}\\left(S_i\\right)\\nRightarrow\\operatorname{Bew}_{\\mathrm{emp}}\\left(S_i\\right)',
    word_latex = '\\operatorname{RekGült}\\left(S_i\\right)\\nRightarrow\\operatorname{Bew}_{\\mathrm{emp}}\\left(S_i\\right)',
    plain_description = 'Formale Rekonstruktionsgültigkeit impliziert keine empirische Bewährung.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.639'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.640', @section_3310, 'Rekonstruktive Anschlussbedingung',
    'S_i\\in\\mathfrak{S}_F\\Leftrightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i\\land\\operatorname{DefEin}\\left(S_i\\right)\\land\\operatorname{Kompat}\\left(S_i,\\mathfrak{L}_F\\right)', 'S_i\\in\\mathfrak{S}_F\\Leftrightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i\\land\\operatorname{DefEin}\\left(S_i\\right)\\land\\operatorname{Kompat}\\left(S_i,\\mathfrak{L}_F\\right)',
    'Zulässigkeit einer Rekonstruktion erfordert Ableitbarkeit, eindeutige Bestimmung und Kompatibilität.', 'theorem', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.640'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Rekonstruktive Anschlussbedingung',
    equation_latex = 'S_i\\in\\mathfrak{S}_F\\Leftrightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i\\land\\operatorname{DefEin}\\left(S_i\\right)\\land\\operatorname{Kompat}\\left(S_i,\\mathfrak{L}_F\\right)',
    word_latex = 'S_i\\in\\mathfrak{S}_F\\Leftrightarrow\\exists\\Gamma_i\\subseteq_{\\mathrm{fin}}\\mathfrak{L}_F:\\Gamma_i\\vdash S_i\\land\\operatorname{DefEin}\\left(S_i\\right)\\land\\operatorname{Kompat}\\left(S_i,\\mathfrak{L}_F\\right)',
    plain_description = 'Zulässigkeit einer Rekonstruktion erfordert Ableitbarkeit, eindeutige Bestimmung und Kompatibilität.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.640'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.641', @section_3310, 'Prädikat eindeutiger Definition',
    '\\operatorname{DefEin}', '\\operatorname{DefEin}',
    'Prädikat der eindeutigen definitorischen Bestimmung einer rekonstruierten Struktur.', 'definition', 'original', NULL,
    'Formalisierung in Abschnitt 3.3.10.',
    'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.641'
);

UPDATE equations
SET
    section_id = @section_3310,
    title = 'Prädikat eindeutiger Definition',
    equation_latex = '\\operatorname{DefEin}',
    word_latex = '\\operatorname{DefEin}',
    plain_description = 'Prädikat der eindeutigen definitorischen Bestimmung einer rekonstruierten Struktur.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.10.',
    assumptions = 'Axiome A1 bis A7 sowie die bis Abschnitt 3.3.9.6 eingeführten Definitionen und Propositionen.',
    validation_status = 'checked',
    created_revision_id = @revision_3310
WHERE equation_number = '3.641'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.14',
    @section_3310,
    'Rekonstruktive Anschlussbedingung',
    'Jede mathematische Struktur des FRZK ist nur dann als zulässige Rekonstruktion anzuerkennen, wenn sie aus einer endlichen Teilmenge des axiomatischen und definitorischen Systems ableitbar, eindeutig bestimmt und mit den bereits eingeführten Strukturen vereinbar ist.',
    'S_i\in\mathfrak{S}_F\Leftrightarrow\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash S_i\land\operatorname{DefEin}\left(S_i\right)\land\operatorname{Kompat}\left(S_i,\mathfrak{L}_F\right)',
    'S_i\in\mathfrak{S}_F\Leftrightarrow\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash S_i\land\operatorname{DefEin}\left(S_i\right)\land\operatorname{Kompat}\left(S_i,\mathfrak{L}_F\right)',
    'Die Proposition verbindet die metatheoretische Freigabe aus Proposition 3.3.13 mit den konkreten Zulässigkeitsbedingungen für die mathematischen Konstruktionen des folgenden Kapitels.',
    'A1,A2,A3,A4,A5,A6,A7',
    'accepted',
    @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM propositions WHERE proposition_number = '3.3.14'
);

UPDATE propositions
SET
    section_id = @section_3310,
    title = 'Rekonstruktive Anschlussbedingung',
    statement_text = 'Jede mathematische Struktur des FRZK ist nur dann als zulässige Rekonstruktion anzuerkennen, wenn sie aus einer endlichen Teilmenge des axiomatischen und definitorischen Systems ableitbar, eindeutig bestimmt und mit den bereits eingeführten Strukturen vereinbar ist.',
    statement_latex = 'S_i\in\mathfrak{S}_F\Leftrightarrow\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash S_i\land\operatorname{DefEin}\left(S_i\right)\land\operatorname{Kompat}\left(S_i,\mathfrak{L}_F\right)',
    word_latex = 'S_i\in\mathfrak{S}_F\Leftrightarrow\exists\Gamma_i\subseteq_{\mathrm{fin}}\mathfrak{L}_F:\Gamma_i\vdash S_i\land\operatorname{DefEin}\left(S_i\right)\land\operatorname{Kompat}\left(S_i,\mathfrak{L}_F\right)',
    logical_derivation = 'Die Proposition verbindet die metatheoretische Freigabe aus Proposition 3.3.13 mit den konkreten Zulässigkeitsbedingungen für die mathematischen Konstruktionen des folgenden Kapitels.',
    based_on_axioms = 'A1,A2,A3,A4,A5,A6,A7',
    status = 'accepted',
    created_revision_id = @revision_3310
WHERE proposition_number = '3.3.14'
AND @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL;

SET @proposition_3314 := (
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.14'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(
    proposition_id, axiom_id, assumption_id, dependency_type, note
)
SELECT
    @proposition_3314,
    a.axiom_id,
    NULL,
    'derived_from',
    CONCAT('Proposition 3.3.14 verwendet ', a.axiom_number,
           ' als Grundlage der rekonstruktiven Anschlussbedingung.')
FROM axioms a
WHERE @proposition_3314 IS NOT NULL
AND a.axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies pd
    WHERE pd.proposition_id = @proposition_3314
      AND pd.axiom_id = a.axiom_id
      AND pd.assumption_id IS NULL
      AND pd.dependency_type = 'derived_from'
);


SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.622' LIMIT 1
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
    '\\mathcal{A}_{\\mathrm{FRZK}}', '\\mathcal{A}_{\\mathrm{FRZK}}', 'Axiomenmenge des FRZK', 'Menge der sieben Grundaxiome des FRZK',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{A}_{\\mathrm{FRZK}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\mathcal{A}_{\\mathrm{FRZK}}', 'Axiomenmenge des FRZK',
    'Menge der sieben Grundaxiome des FRZK', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\mathcal{A}_{\\mathrm{FRZK}}'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.630' LIMIT 1
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
    '\\mathbf{v}', '\\mathbf{v}', 'Funktionaler Vektor', 'Funktionaler Vektor mit Betrag und Richtungswert',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 1, 0, 0,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathbf{v}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\mathbf{v}', 'Funktionaler Vektor',
    'Funktionaler Vektor mit Betrag und Richtungswert', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\mathbf{v}'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.630' LIMIT 1
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
    '\\widehat{\\mathbf{v}}', '\\widehat{\\mathbf{v}}', 'Richtungswert', 'Erhaltener Richtungswert eines funktionalen Vektors',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 1, 0, 0,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\widehat{\\mathbf{v}}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\widehat{\\mathbf{v}}', 'Richtungswert',
    'Erhaltener Richtungswert eines funktionalen Vektors', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\widehat{\\mathbf{v}}'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.632' LIMIT 1
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
    '\\mathbf{0}_F', '\\mathbf{0}_F', 'Funktionaler Nullvektor', 'Vollständig gelöschter funktionaler Nullvektor',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 1, 0, 0,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathbf{0}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\mathbf{0}_F', 'Funktionaler Nullvektor',
    'Vollständig gelöschter funktionaler Nullvektor', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\mathbf{0}_F'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.633' LIMIT 1
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
    '\\mathfrak{R}', '\\mathfrak{R}', 'Rekonstruktionsabbildung', 'Abbildung vom formalen System auf mathematische Strukturen',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathfrak{R}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\mathfrak{R}', 'Rekonstruktionsabbildung',
    'Abbildung vom formalen System auf mathematische Strukturen', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\mathfrak{R}'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.633' LIMIT 1
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
    '\\mathfrak{S}_F', '\\mathfrak{S}_F', 'Rekonstruktionsraum', 'Menge der mathematisch rekonstruierbaren FRZK-Strukturen',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathfrak{S}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\mathfrak{S}_F', 'Rekonstruktionsraum',
    'Menge der mathematisch rekonstruierbaren FRZK-Strukturen', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\mathfrak{S}_F'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.637' LIMIT 1
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
    '\\operatorname{RekGült}', '\\operatorname{RekGült}', 'Rekonstruktionsgültigkeit', 'Prädikat der Gültigkeit einer mathematischen Rekonstruktion',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{RekGült}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\operatorname{RekGült}', 'Rekonstruktionsgültigkeit',
    'Prädikat der Gültigkeit einer mathematischen Rekonstruktion', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\operatorname{RekGült}'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.641' LIMIT 1
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
    '\\operatorname{DefEin}', '\\operatorname{DefEin}', 'Eindeutige Definition', 'Prädikat der eindeutigen definitorischen Bestimmung',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\operatorname{DefEin}'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_symbol_3310, '\\operatorname{DefEin}', 'Eindeutige Definition',
    'Prädikat der eindeutigen definitorischen Bestimmung', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\operatorname{DefEin}'
);

SET @eq_symbol_3310 := (
    SELECT equation_id FROM equations WHERE equation_number = '3.640' LIMIT 1
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
    '\\operatorname{Kompat}', '\\operatorname{Kompat}', 'Kompatibilität', 'Prädikat der Vereinbarkeit einer Rekonstruktion mit dem formalen System',
    'chapter', @section_3310, @eq_symbol_3310,
    NULL, NULL, NULL, 0, 0, 1,
    'In Abschnitt 3.3.10 eingeführt oder abschließend präzisiert.',
    'checked', @revision_3310
WHERE @section_3310 IS NOT NULL
AND @revision_3310 IS NOT NULL
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
    @eq_symbol_3310, '\\operatorname{Kompat}', 'Kompatibilität',
    'Prädikat der Vereinbarkeit einer Rekonstruktion mit dem formalen System', NULL, NULL, 1
WHERE @eq_symbol_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id = @eq_symbol_3310
      AND symbol_latex = '\\operatorname{Kompat}'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3310, @section_3310, 'created', 'section', '3.3.10',
    'Abschnitt 3.3.10 vollständig angelegt.',
    NULL, 'Zusammenfassung und Übergang zur mathematischen Rekonstruktion'
WHERE @revision_3310 IS NOT NULL
AND @section_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3310
      AND object_type = 'section'
      AND object_reference = '3.3.10'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3310, @section_3310, 'proposition_added', 'proposition', '3.3.14',
    'Proposition 3.3.14 registriert.',
    NULL, 'Rekonstruktive Anschlussbedingung'
WHERE @revision_3310 IS NOT NULL
AND @section_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3310
      AND object_type = 'proposition'
      AND object_reference = '3.3.14'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3310, @section_3310, 'equation_added', 'equation', '(3.619)–(3.641)',
    '23 Gleichungen und formale Schemata registriert.',
    NULL, 'Gleichungen (3.619) bis (3.641)'
WHERE @revision_3310 IS NOT NULL
AND @section_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_3310
      AND object_type = 'equation'
      AND object_reference = '(3.619)–(3.641)'
);

SET @equation_count_3310 := (
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
        '3.619','3.620','3.621','3.622','3.623','3.624','3.625','3.626',
        '3.627','3.628','3.629','3.630','3.631','3.632','3.633','3.634',
        '3.635','3.636','3.637','3.638','3.639','3.640','3.641'
    )
);

SET @dependency_count_3310 := (
    SELECT COUNT(*)
    FROM proposition_dependencies
    WHERE proposition_id = @proposition_3314
      AND dependency_type = 'derived_from'
);

SET @symbol_count_3310 := (
    SELECT COUNT(*)
    FROM symbols
    WHERE scope_type = 'chapter'
      AND symbol_latex IN
      (
          '\mathcal{A}_{\mathrm{FRZK}}',
          '\mathbf{v}',
          '\widehat{\mathbf{v}}',
          '\mathbf{0}_F',
          '\mathfrak{R}',
          '\mathfrak{S}_F',
          '\operatorname{RekGült}',
          '\operatorname{DefEin}',
          '\operatorname{Kompat}'
      )
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3310, 'K3.3.10.PRECONDITION',
    CASE WHEN @precondition_ok_3310 = 1 THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @precondition_ok_3310 = 1 THEN '1' ELSE '0' END,
    'Prüfung der Elternrevision und des Kapitelabschnitts 3.3.'
WHERE @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3310
      AND validation_code = 'K3.3.10.PRECONDITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3310, 'K3.3.10.SECTION',
    CASE WHEN @section_3310 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @section_3310 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung des Abschnitts 3.3.10.'
WHERE @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3310
      AND validation_code = 'K3.3.10.SECTION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3310, 'K3.3.10.PROPOSITION',
    CASE WHEN @proposition_3314 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1', CASE WHEN @proposition_3314 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung der Proposition 3.3.14.'
WHERE @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3310
      AND validation_code = 'K3.3.10.PROPOSITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3310, 'K3.3.10.EQUATIONS',
    CASE WHEN @equation_count_3310 = 23 THEN 'passed' ELSE 'failed' END,
    '23', CAST(@equation_count_3310 AS CHAR),
    'Prüfung der Gleichungen (3.619) bis (3.641).'
WHERE @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3310
      AND validation_code = 'K3.3.10.EQUATIONS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3310, 'K3.3.10.AXIOM_DEPENDENCIES',
    CASE WHEN @dependency_count_3310 = 7 THEN 'passed' ELSE 'failed' END,
    '7', CAST(@dependency_count_3310 AS CHAR),
    'Prüfung der sieben Axiomabhängigkeiten von Proposition 3.3.14.'
WHERE @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3310
      AND validation_code = 'K3.3.10.AXIOM_DEPENDENCIES'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3310, 'K3.3.10.SYMBOLS',
    CASE WHEN @symbol_count_3310 = 9 THEN 'passed' ELSE 'failed' END,
    '9', CAST(@symbol_count_3310 AS CHAR),
    'Prüfung der neun zentralen Symbolregistrierungen.'
WHERE @revision_3310 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3310
      AND validation_code = 'K3.3.10.SYMBOLS'
);

COMMIT;

SELECT
    CASE
        WHEN @parent_revision_3310 IS NULL
            THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.9.6-V1 fehlt.'
        WHEN @chapter_section_3310 IS NULL
            THEN 'FEHLER: Kapitelabschnitt 3.3 fehlt.'
        WHEN @revision_3310 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.10-V1 wurde nicht angelegt.'
        WHEN @section_3310 IS NULL
            THEN 'FEHLER: Abschnitt 3.3.10 wurde nicht angelegt.'
        WHEN @proposition_3314 IS NULL
            THEN 'FEHLER: Proposition 3.3.14 wurde nicht angelegt.'
        WHEN @equation_count_3310 <> 23
            THEN CONCAT('FEHLER: ', @equation_count_3310, ' statt 23 Gleichungen vorhanden.')
        WHEN @dependency_count_3310 <> 7
            THEN CONCAT('FEHLER: ', @dependency_count_3310, ' statt 7 Axiomabhängigkeiten vorhanden.')
        WHEN @symbol_count_3310 <> 9
            THEN CONCAT('FEHLER: ', @symbol_count_3310, ' statt 9 zentralen Symbolen vorhanden.')
        ELSE 'OK: Repository-Update 3.3.10 vollständig und konsistent ausgeführt.'
    END AS import_status;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_3310
ORDER BY validation_code;
