/* ============================================================================
   FRZK-RKB – Repository-Update 3.3.9.4

   Abschnitt:
     3.3.9.4 Verhältnis von Axiomen, Definitionen und abgeleiteten Aussagen

   Ausgangsstand:
     frzk_rkb_3.3.9.3.sql
     Elternrevision: RKB-NEU-K3.3.9.3-V1

   Registriert:
     - Revision RKB-NEU-K3.3.9.4-V1
     - Abschnitt 3.3.9.4
     - Proposition 3.3.11
     - Gleichungen (3.525) bis (3.557)
     - Axiomabhängigkeiten A1 bis A7
     - zentrale neue Symbole
     - Gleichung-Symbol-Zuordnungen
     - Änderungsprotokoll
     - Repository-Validierungen

   Eigenschaften:
     - idempotent
     - keine fest codierten Primärschlüssel
     - Fremdschlüssel vor Change-Log-Einträgen geprüft
     - Importabbruch bei fehlender Elternrevision
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_3394 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.3-V1'
    LIMIT 1
);

SET @parent_section_3394 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9'
    LIMIT 1
);

/* Harte Vorbedingungen */
SET @precondition_ok_3394 := (
    @parent_revision_3394 IS NOT NULL
    AND @parent_section_3394 IS NOT NULL
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.9.4-V1',
    NOW(),
    'section',
    '3.3.9.4',
    '1.0',
    'Abschnitt 3.3.9.4: Verhältnis von Axiomen, Definitionen und Propositionen; Proposition 3.3.11; Gleichungen (3.525) bis (3.557).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_3394
WHERE @precondition_ok_3394 = 1
AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.4-V1'
);

SET @revision_3394 := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.4-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @parent_section_3394,
    '3.3.9.4',
    'Verhältnis von Axiomen, Definitionen und abgeleiteten Aussagen',
    3,
    3.3094,
    'final',
    1,
    'Formale Trennung von Grundsetzungen, Begriffsbestimmungen und abgeleiteten Aussagen sowie Einführung eines azyklischen Abhängigkeitsgraphen.'
WHERE @revision_3394 IS NOT NULL
AND @parent_section_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.9.4'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_3394,
    title = 'Verhältnis von Axiomen, Definitionen und abgeleiteten Aussagen',
    chapter_no = 3,
    section_order = 3.3094,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Formale Trennung von Grundsetzungen, Begriffsbestimmungen und abgeleiteten Aussagen sowie Einführung eines azyklischen Abhängigkeitsgraphen.'
WHERE section_code = '3.3.9.4'
AND @parent_section_3394 IS NOT NULL;

SET @section_3394 := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9.4'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.525',
    @section_3394,
    'Formale Aussageklassen des FRZK',
    '\\mathfrak{L}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F\\right)',
    '\\mathfrak{L}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F\\right)',
    'Zusammenfassung von Axiomen, Definitionen und Propositionen als formales System.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.525'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Formale Aussageklassen des FRZK',
    equation_latex = '\\mathfrak{L}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F\\right)',
    word_latex = '\\mathfrak{L}_F=\\left(\\mathcal{A}_F,\\mathcal{D}\\!ef_F,\\mathcal{P}_F\\right)',
    plain_description = 'Zusammenfassung von Axiomen, Definitionen und Propositionen als formales System.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.525'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.526',
    @section_3394,
    'Menge der Axiome',
    '\\mathcal{A}_F',
    '\\mathcal{A}_F',
    'Bezeichnung der Axiomenmenge des FRZK.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.526'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Menge der Axiome',
    equation_latex = '\\mathcal{A}_F',
    word_latex = '\\mathcal{A}_F',
    plain_description = 'Bezeichnung der Axiomenmenge des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.526'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.527',
    @section_3394,
    'Menge der Definitionen',
    '\\mathcal{D}\\!ef_F',
    '\\mathcal{D}\\!ef_F',
    'Bezeichnung der Definitionsmenge des FRZK.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.527'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Menge der Definitionen',
    equation_latex = '\\mathcal{D}\\!ef_F',
    word_latex = '\\mathcal{D}\\!ef_F',
    plain_description = 'Bezeichnung der Definitionsmenge des FRZK.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.527'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.528',
    @section_3394,
    'Menge der Propositionen',
    '\\mathcal{P}_F',
    '\\mathcal{P}_F',
    'Bezeichnung der Menge abgeleiteter Propositionen.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.528'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Menge der Propositionen',
    equation_latex = '\\mathcal{P}_F',
    word_latex = '\\mathcal{P}_F',
    plain_description = 'Bezeichnung der Menge abgeleiteter Propositionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.528'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.529',
    @section_3394,
    'Axiomenmenge A1 bis A7',
    '\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    '\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    'Explizite Darstellung der sieben Grundaxiome.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.529'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Axiomenmenge A1 bis A7',
    equation_latex = '\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    word_latex = '\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
    plain_description = 'Explizite Darstellung der sieben Grundaxiome.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.529'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.530',
    @section_3394,
    'Systeminterne Nichtableitbarkeit der Axiome',
    'A_k\\in\\mathcal{A}_F\\Rightarrow\\mathcal{A}_F\\nvdash_{\\mathrm{int}}A_k',
    'A_k\\in\\mathcal{A}_F\\Rightarrow\\mathcal{A}_F\\nvdash_{\\mathrm{int}}A_k',
    'Axiome werden innerhalb des Systems nicht aus den übrigen Aussagen hergeleitet.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.530'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Systeminterne Nichtableitbarkeit der Axiome',
    equation_latex = 'A_k\\in\\mathcal{A}_F\\Rightarrow\\mathcal{A}_F\\nvdash_{\\mathrm{int}}A_k',
    word_latex = 'A_k\\in\\mathcal{A}_F\\Rightarrow\\mathcal{A}_F\\nvdash_{\\mathrm{int}}A_k',
    plain_description = 'Axiome werden innerhalb des Systems nicht aus den übrigen Aussagen hergeleitet.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.530'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.531',
    @section_3394,
    'Index der systeminternen Ableitung',
    '\\mathrm{int}',
    '\\mathrm{int}',
    'Kennzeichnung einer systeminternen Ableitung.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.531'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Index der systeminternen Ableitung',
    equation_latex = '\\mathrm{int}',
    word_latex = '\\mathrm{int}',
    plain_description = 'Kennzeichnung einer systeminternen Ableitung.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.531'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.532',
    @section_3394,
    'Allgemeines Definitionsschema',
    'D_j:\\quad B_j\\coloneqq\\Phi_j',
    'D_j:\\quad B_j\\coloneqq\\Phi_j',
    'Ein neu eingeführter Begriff wird durch eine strukturierende Beschreibung festgelegt.',
    'schema',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.532'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Allgemeines Definitionsschema',
    equation_latex = 'D_j:\\quad B_j\\coloneqq\\Phi_j',
    word_latex = 'D_j:\\quad B_j\\coloneqq\\Phi_j',
    plain_description = 'Ein neu eingeführter Begriff wird durch eine strukturierende Beschreibung festgelegt.',
    equation_type = 'schema',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.532'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.533',
    @section_3394,
    'Definitorische Äquivalenz',
    'D_j\\in\\mathcal{D}\\!ef_F\\Rightarrow B_j\\equiv_{\\mathrm{def}}\\Phi_j',
    'D_j\\in\\mathcal{D}\\!ef_F\\Rightarrow B_j\\equiv_{\\mathrm{def}}\\Phi_j',
    'Definitionen legen die Äquivalenz eines Begriffs mit seiner strukturierenden Beschreibung fest.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.533'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Definitorische Äquivalenz',
    equation_latex = 'D_j\\in\\mathcal{D}\\!ef_F\\Rightarrow B_j\\equiv_{\\mathrm{def}}\\Phi_j',
    word_latex = 'D_j\\in\\mathcal{D}\\!ef_F\\Rightarrow B_j\\equiv_{\\mathrm{def}}\\Phi_j',
    plain_description = 'Definitionen legen die Äquivalenz eines Begriffs mit seiner strukturierenden Beschreibung fest.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.533'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.534',
    @section_3394,
    'Symbol der definitorischen Äquivalenz',
    '\\equiv_{\\mathrm{def}}',
    '\\equiv_{\\mathrm{def}}',
    'Bezeichnung der definitorischen Äquivalenz.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.534'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Symbol der definitorischen Äquivalenz',
    equation_latex = '\\equiv_{\\mathrm{def}}',
    word_latex = '\\equiv_{\\mathrm{def}}',
    plain_description = 'Bezeichnung der definitorischen Äquivalenz.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.534'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.535',
    @section_3394,
    'Ableitung einer Proposition',
    '\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\vdash P_m',
    '\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\vdash P_m',
    'Eine Proposition folgt aus Axiomen, Definitionen und logisch vorhergehenden Propositionen.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.535'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Ableitung einer Proposition',
    equation_latex = '\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\vdash P_m',
    word_latex = '\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\vdash P_m',
    plain_description = 'Eine Proposition folgt aus Axiomen, Definitionen und logisch vorhergehenden Propositionen.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.535'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.536',
    @section_3394,
    'Menge vorhergehender Propositionen',
    '\\mathcal{P}_F^{(<m)}',
    '\\mathcal{P}_F^{(<m)}',
    'Menge der vor einer Proposition bereits hergeleiteten Propositionen.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.536'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Menge vorhergehender Propositionen',
    equation_latex = '\\mathcal{P}_F^{(<m)}',
    word_latex = '\\mathcal{P}_F^{(<m)}',
    plain_description = 'Menge der vor einer Proposition bereits hergeleiteten Propositionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.536'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.537',
    @section_3394,
    'Gerichtete logische Abhängigkeit',
    '\\mathcal{A}_F\\longrightarrow\\mathcal{D}\\!ef_F\\longrightarrow\\mathcal{P}_F',
    '\\mathcal{A}_F\\longrightarrow\\mathcal{D}\\!ef_F\\longrightarrow\\mathcal{P}_F',
    'Vereinfachte Abhängigkeitsrichtung von Axiomen über Definitionen zu Propositionen.',
    'schema',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.537'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Gerichtete logische Abhängigkeit',
    equation_latex = '\\mathcal{A}_F\\longrightarrow\\mathcal{D}\\!ef_F\\longrightarrow\\mathcal{P}_F',
    word_latex = '\\mathcal{A}_F\\longrightarrow\\mathcal{D}\\!ef_F\\longrightarrow\\mathcal{P}_F',
    plain_description = 'Vereinfachte Abhängigkeitsrichtung von Axiomen über Definitionen zu Propositionen.',
    equation_type = 'schema',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.537'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.538',
    @section_3394,
    'Zulässigkeit statt Ableitbarkeit einer Definition',
    '\\mathcal{A}_F\\nvdash D_j,\\qquad\\mathcal{A}_F\\models\\operatorname{zul}\\left(D_j\\right)',
    '\\mathcal{A}_F\\nvdash D_j,\\qquad\\mathcal{A}_F\\models\\operatorname{zul}\\left(D_j\\right)',
    'Definitionen werden nicht zwingend aus Axiomen abgeleitet, müssen aber mit ihnen vereinbar sein.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.538'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Zulässigkeit statt Ableitbarkeit einer Definition',
    equation_latex = '\\mathcal{A}_F\\nvdash D_j,\\qquad\\mathcal{A}_F\\models\\operatorname{zul}\\left(D_j\\right)',
    word_latex = '\\mathcal{A}_F\\nvdash D_j,\\qquad\\mathcal{A}_F\\models\\operatorname{zul}\\left(D_j\\right)',
    plain_description = 'Definitionen werden nicht zwingend aus Axiomen abgeleitet, müssen aber mit ihnen vereinbar sein.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.538'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.539',
    @section_3394,
    'Zulässigkeitsprädikat einer Definition',
    '\\operatorname{zul}\\left(D_j\\right)',
    '\\operatorname{zul}\\left(D_j\\right)',
    'Prädikat für die Zulässigkeit einer Definition im Axiomensystem.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.539'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Zulässigkeitsprädikat einer Definition',
    equation_latex = '\\operatorname{zul}\\left(D_j\\right)',
    word_latex = '\\operatorname{zul}\\left(D_j\\right)',
    plain_description = 'Prädikat für die Zulässigkeit einer Definition im Axiomensystem.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.539'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.540',
    @section_3394,
    'Bedingungen definitorischer Zulässigkeit',
    '\\operatorname{zul}\\left(D_j\\right)\\Leftrightarrow E_j\\land W_j\\land A_j',
    '\\operatorname{zul}\\left(D_j\\right)\\Leftrightarrow E_j\\land W_j\\land A_j',
    'Zulässigkeit verlangt Eindeutigkeit, Widerspruchsfreiheit und Anschlussfähigkeit.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.540'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Bedingungen definitorischer Zulässigkeit',
    equation_latex = '\\operatorname{zul}\\left(D_j\\right)\\Leftrightarrow E_j\\land W_j\\land A_j',
    word_latex = '\\operatorname{zul}\\left(D_j\\right)\\Leftrightarrow E_j\\land W_j\\land A_j',
    plain_description = 'Zulässigkeit verlangt Eindeutigkeit, Widerspruchsfreiheit und Anschlussfähigkeit.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.540'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.541',
    @section_3394,
    'Eindeutigkeitsbedingung',
    'E_j\\Leftrightarrow\\forall x:B_j(x)\\Rightarrow\\exists!\\Phi_j(x)',
    'E_j\\Leftrightarrow\\forall x:B_j(x)\\Rightarrow\\exists!\\Phi_j(x)',
    'Der definierte Ausdruck besitzt im gegebenen Kontext eine eindeutige strukturierende Beschreibung.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.541'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Eindeutigkeitsbedingung',
    equation_latex = 'E_j\\Leftrightarrow\\forall x:B_j(x)\\Rightarrow\\exists!\\Phi_j(x)',
    word_latex = 'E_j\\Leftrightarrow\\forall x:B_j(x)\\Rightarrow\\exists!\\Phi_j(x)',
    plain_description = 'Der definierte Ausdruck besitzt im gegebenen Kontext eine eindeutige strukturierende Beschreibung.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.541'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.542',
    @section_3394,
    'Widerspruchsfreiheitsbedingung',
    'W_j\\Leftrightarrow\\nexists x:\\Phi_j(x)\\land\\neg\\Phi_j(x)',
    'W_j\\Leftrightarrow\\nexists x:\\Phi_j(x)\\land\\neg\\Phi_j(x)',
    'Eine Definition darf nicht zugleich eine Eigenschaft und deren Negation fordern.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.542'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Widerspruchsfreiheitsbedingung',
    equation_latex = 'W_j\\Leftrightarrow\\nexists x:\\Phi_j(x)\\land\\neg\\Phi_j(x)',
    word_latex = 'W_j\\Leftrightarrow\\nexists x:\\Phi_j(x)\\land\\neg\\Phi_j(x)',
    plain_description = 'Eine Definition darf nicht zugleich eine Eigenschaft und deren Negation fordern.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.542'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.543',
    @section_3394,
    'Anschlussfähigkeitsbedingung',
    'A_j\\Leftrightarrow\\operatorname{Sym}\\left(\\Phi_j\\right)\\subseteq\\operatorname{Sym}\\left(\\mathfrak{L}_F\\right)',
    'A_j\\Leftrightarrow\\operatorname{Sym}\\left(\\Phi_j\\right)\\subseteq\\operatorname{Sym}\\left(\\mathfrak{L}_F\\right)',
    'Die Symbole einer Definition müssen im formalen System vorhanden oder daraus konstruierbar sein.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.543'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Anschlussfähigkeitsbedingung',
    equation_latex = 'A_j\\Leftrightarrow\\operatorname{Sym}\\left(\\Phi_j\\right)\\subseteq\\operatorname{Sym}\\left(\\mathfrak{L}_F\\right)',
    word_latex = 'A_j\\Leftrightarrow\\operatorname{Sym}\\left(\\Phi_j\\right)\\subseteq\\operatorname{Sym}\\left(\\mathfrak{L}_F\\right)',
    plain_description = 'Die Symbole einer Definition müssen im formalen System vorhanden oder daraus konstruierbar sein.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.543'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.544',
    @section_3394,
    'Symbolmenge eines Ausdrucks',
    '\\operatorname{Sym}\\left(\\Phi_j\\right)',
    '\\operatorname{Sym}\\left(\\Phi_j\\right)',
    'Menge der in einer Definition verwendeten Symbole.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.544'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Symbolmenge eines Ausdrucks',
    equation_latex = '\\operatorname{Sym}\\left(\\Phi_j\\right)',
    word_latex = '\\operatorname{Sym}\\left(\\Phi_j\\right)',
    plain_description = 'Menge der in einer Definition verwendeten Symbole.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.544'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.545',
    @section_3394,
    'Ableitungsrelation einer Proposition',
    '\\Delta_F\\left(P_m\\right)=\\left(V_m,S_m,R_m\\right)',
    '\\Delta_F\\left(P_m\\right)=\\left(V_m,S_m,R_m\\right)',
    'Darstellung einer Proposition durch Voraussetzungen, Ableitungsschritte und Schlussregeln.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.545'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Ableitungsrelation einer Proposition',
    equation_latex = '\\Delta_F\\left(P_m\\right)=\\left(V_m,S_m,R_m\\right)',
    word_latex = '\\Delta_F\\left(P_m\\right)=\\left(V_m,S_m,R_m\\right)',
    plain_description = 'Darstellung einer Proposition durch Voraussetzungen, Ableitungsschritte und Schlussregeln.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.545'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.546',
    @section_3394,
    'Formale Begründungsbedingung',
    '\\operatorname{Begr}\\left(P_m\\right)\\Leftrightarrow V_m\\subseteq\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\land S_m\\neq\\varnothing',
    '\\operatorname{Begr}\\left(P_m\\right)\\Leftrightarrow V_m\\subseteq\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\land S_m\\neq\\varnothing',
    'Eine Proposition ist begründet, wenn ihre Voraussetzungen zulässig und ihre Ableitungsschritte vorhanden sind.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.546'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Formale Begründungsbedingung',
    equation_latex = '\\operatorname{Begr}\\left(P_m\\right)\\Leftrightarrow V_m\\subseteq\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\land S_m\\neq\\varnothing',
    word_latex = '\\operatorname{Begr}\\left(P_m\\right)\\Leftrightarrow V_m\\subseteq\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F^{(<m)}\\land S_m\\neq\\varnothing',
    plain_description = 'Eine Proposition ist begründet, wenn ihre Voraussetzungen zulässig und ihre Ableitungsschritte vorhanden sind.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.546'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.547',
    @section_3394,
    'Logischer Abhängigkeitsgraph',
    'G_{\\mathfrak{L}}=\\left(V_{\\mathfrak{L}},E_{\\mathfrak{L}}\\right)',
    'G_{\\mathfrak{L}}=\\left(V_{\\mathfrak{L}},E_{\\mathfrak{L}}\\right)',
    'Gerichteter Graph der Abhängigkeiten zwischen Axiomen, Definitionen und Propositionen.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.547'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Logischer Abhängigkeitsgraph',
    equation_latex = 'G_{\\mathfrak{L}}=\\left(V_{\\mathfrak{L}},E_{\\mathfrak{L}}\\right)',
    word_latex = 'G_{\\mathfrak{L}}=\\left(V_{\\mathfrak{L}},E_{\\mathfrak{L}}\\right)',
    plain_description = 'Gerichteter Graph der Abhängigkeiten zwischen Axiomen, Definitionen und Propositionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.547'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.548',
    @section_3394,
    'Knotenmenge des Abhängigkeitsgraphen',
    'V_{\\mathfrak{L}}=\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F',
    'V_{\\mathfrak{L}}=\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F',
    'Knotenmenge aus Axiomen, Definitionen und Propositionen.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.548'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Knotenmenge des Abhängigkeitsgraphen',
    equation_latex = 'V_{\\mathfrak{L}}=\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F',
    word_latex = 'V_{\\mathfrak{L}}=\\mathcal{A}_F\\cup\\mathcal{D}\\!ef_F\\cup\\mathcal{P}_F',
    plain_description = 'Knotenmenge aus Axiomen, Definitionen und Propositionen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.548'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.549',
    @section_3394,
    'Abhängigkeitskante',
    '\\left(u,v\\right)\\in E_{\\mathfrak{L}}',
    '\\left(u,v\\right)\\in E_{\\mathfrak{L}}',
    'Eine Kante zeigt die inhaltliche oder logische Abhängigkeit von v gegenüber u.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.549'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Abhängigkeitskante',
    equation_latex = '\\left(u,v\\right)\\in E_{\\mathfrak{L}}',
    word_latex = '\\left(u,v\\right)\\in E_{\\mathfrak{L}}',
    plain_description = 'Eine Kante zeigt die inhaltliche oder logische Abhängigkeit von v gegenüber u.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.549'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.550',
    @section_3394,
    'Azyklizitätsforderung',
    'G_{\\mathfrak{L}}\\text{ ist azyklisch}',
    'G_{\\mathfrak{L}}\\text{ ist azyklisch}',
    'Der logische Abhängigkeitsgraph darf keine Begründungszyklen enthalten.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.550'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Azyklizitätsforderung',
    equation_latex = 'G_{\\mathfrak{L}}\\text{ ist azyklisch}',
    word_latex = 'G_{\\mathfrak{L}}\\text{ ist azyklisch}',
    plain_description = 'Der logische Abhängigkeitsgraph darf keine Begründungszyklen enthalten.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.550'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.551',
    @section_3394,
    'Formale Zyklenfreiheit',
    '\\nexists v_1,\\ldots,v_n\\in V_{\\mathfrak{L}}:v_1\\rightarrow v_2\\rightarrow\\cdots\\rightarrow v_n\\rightarrow v_1',
    '\\nexists v_1,\\ldots,v_n\\in V_{\\mathfrak{L}}:v_1\\rightarrow v_2\\rightarrow\\cdots\\rightarrow v_n\\rightarrow v_1',
    'Es existiert kein geschlossener gerichteter Ableitungsweg.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.551'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Formale Zyklenfreiheit',
    equation_latex = '\\nexists v_1,\\ldots,v_n\\in V_{\\mathfrak{L}}:v_1\\rightarrow v_2\\rightarrow\\cdots\\rightarrow v_n\\rightarrow v_1',
    word_latex = '\\nexists v_1,\\ldots,v_n\\in V_{\\mathfrak{L}}:v_1\\rightarrow v_2\\rightarrow\\cdots\\rightarrow v_n\\rightarrow v_1',
    plain_description = 'Es existiert kein geschlossener gerichteter Ableitungsweg.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.551'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.552',
    @section_3394,
    'Rangfunktion des formalen Systems',
    '\\rho:V_{\\mathfrak{L}}\\rightarrow\\mathbb{N}_0',
    '\\rho:V_{\\mathfrak{L}}\\rightarrow\\mathbb{N}_0',
    'Rangfunktion zur hierarchischen Ordnung der Aussagen.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.552'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Rangfunktion des formalen Systems',
    equation_latex = '\\rho:V_{\\mathfrak{L}}\\rightarrow\\mathbb{N}_0',
    word_latex = '\\rho:V_{\\mathfrak{L}}\\rightarrow\\mathbb{N}_0',
    plain_description = 'Rangfunktion zur hierarchischen Ordnung der Aussagen.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.552'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.553',
    @section_3394,
    'Rang der Axiome',
    '\\rho\\left(A_k\\right)=0',
    '\\rho\\left(A_k\\right)=0',
    'Axiome bilden die unterste Rangstufe.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.553'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Rang der Axiome',
    equation_latex = '\\rho\\left(A_k\\right)=0',
    word_latex = '\\rho\\left(A_k\\right)=0',
    plain_description = 'Axiome bilden die unterste Rangstufe.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.553'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.554',
    @section_3394,
    'Rang der Definitionen',
    '\\rho\\left(D_j\\right)\\geq1',
    '\\rho\\left(D_j\\right)\\geq1',
    'Definitionen liegen oberhalb der Axiomenebene.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.554'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Rang der Definitionen',
    equation_latex = '\\rho\\left(D_j\\right)\\geq1',
    word_latex = '\\rho\\left(D_j\\right)\\geq1',
    plain_description = 'Definitionen liegen oberhalb der Axiomenebene.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.554'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.555',
    @section_3394,
    'Rang einer Proposition',
    '\\rho\\left(P_m\\right)>\\max\\left\\{\\rho(v)\\mid v\\in V_m\\right\\}',
    '\\rho\\left(P_m\\right)>\\max\\left\\{\\rho(v)\\mid v\\in V_m\\right\\}',
    'Jede Proposition liegt logisch oberhalb aller ihrer Voraussetzungen.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.555'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Rang einer Proposition',
    equation_latex = '\\rho\\left(P_m\\right)>\\max\\left\\{\\rho(v)\\mid v\\in V_m\\right\\}',
    word_latex = '\\rho\\left(P_m\\right)>\\max\\left\\{\\rho(v)\\mid v\\in V_m\\right\\}',
    plain_description = 'Jede Proposition liegt logisch oberhalb aller ihrer Voraussetzungen.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.555'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.556',
    @section_3394,
    'Hierarchische Geschlossenheit',
    '\\forall D_j\\in\\mathcal{D}\\!ef_F:\\operatorname{zul}\\left(D_j\\right)\\quad\\land\\quad\\forall P_m\\in\\mathcal{P}_F:\\operatorname{Begr}\\left(P_m\\right)',
    '\\forall D_j\\in\\mathcal{D}\\!ef_F:\\operatorname{zul}\\left(D_j\\right)\\quad\\land\\quad\\forall P_m\\in\\mathcal{P}_F:\\operatorname{Begr}\\left(P_m\\right)',
    'Alle Definitionen sind zulässig und alle Propositionen formal begründet.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.556'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Hierarchische Geschlossenheit',
    equation_latex = '\\forall D_j\\in\\mathcal{D}\\!ef_F:\\operatorname{zul}\\left(D_j\\right)\\quad\\land\\quad\\forall P_m\\in\\mathcal{P}_F:\\operatorname{Begr}\\left(P_m\\right)',
    word_latex = '\\forall D_j\\in\\mathcal{D}\\!ef_F:\\operatorname{zul}\\left(D_j\\right)\\quad\\land\\quad\\forall P_m\\in\\mathcal{P}_F:\\operatorname{Begr}\\left(P_m\\right)',
    plain_description = 'Alle Definitionen sind zulässig und alle Propositionen formal begründet.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.556'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.557',
    @section_3394,
    'Hierarchische Ordnung aus Azyklizität',
    'G_{\\mathfrak{L}}\\text{ azyklisch}\\Rightarrow\\mathfrak{L}_F\\text{ hierarchisch geordnet}',
    'G_{\\mathfrak{L}}\\text{ azyklisch}\\Rightarrow\\mathfrak{L}_F\\text{ hierarchisch geordnet}',
    'Ein azyklischer Abhängigkeitsgraph begründet die hierarchische Ordnung des formalen Systems.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.4.',
    'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.557'
);

UPDATE equations
SET
    section_id = @section_3394,
    title = 'Hierarchische Ordnung aus Azyklizität',
    equation_latex = 'G_{\\mathfrak{L}}\\text{ azyklisch}\\Rightarrow\\mathfrak{L}_F\\text{ hierarchisch geordnet}',
    word_latex = 'G_{\\mathfrak{L}}\\text{ azyklisch}\\Rightarrow\\mathfrak{L}_F\\text{ hierarchisch geordnet}',
    plain_description = 'Ein azyklischer Abhängigkeitsgraph begründet die hierarchische Ordnung des formalen Systems.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.4.',
    assumptions = 'Axiome A1 bis A7 sowie die zuvor eingeführten Definitionen und Propositionen des FRZK.',
    validation_status = 'checked',
    created_revision_id = @revision_3394
WHERE equation_number = '3.557'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.11',
    @section_3394,
    'Hierarchische Geschlossenheit des formalen Systems',
    'Das formale System des FRZK ist hierarchisch geschlossen, wenn jede Definition auf bereits eingeführten Symbolen beruht und jede Proposition ausschließlich aus Axiomen, zulässigen Definitionen und logisch vorhergehenden Propositionen abgeleitet wird.',
    '\forall D_j\in\mathcal{D}\!ef_F:\operatorname{zul}\left(D_j\right)\quad\land\quad\forall P_m\in\mathcal{P}_F:\operatorname{Begr}\left(P_m\right)',
    '\forall D_j\in\mathcal{D}\!ef_F:\operatorname{zul}\left(D_j\right)\quad\land\quad\forall P_m\in\mathcal{P}_F:\operatorname{Begr}\left(P_m\right)',
    'Die zulässigen Definitionen und formal begründeten Propositionen bilden einen gerichteten Abhängigkeitsgraphen. Ist dieser Graph azyklisch, kann jedem Element ein Rang zugewiesen werden. Dadurch liegt jede abgeleitete Aussage logisch oberhalb ihrer Voraussetzungen und das System ist hierarchisch geordnet.',
    'A1,A2,A3,A4,A5,A6,A7',
    'accepted',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM propositions
    WHERE proposition_number = '3.3.11'
);

UPDATE propositions
SET
    section_id = @section_3394,
    title = 'Hierarchische Geschlossenheit des formalen Systems',
    statement_text = 'Das formale System des FRZK ist hierarchisch geschlossen, wenn jede Definition auf bereits eingeführten Symbolen beruht und jede Proposition ausschließlich aus Axiomen, zulässigen Definitionen und logisch vorhergehenden Propositionen abgeleitet wird.',
    statement_latex = '\forall D_j\in\mathcal{D}\!ef_F:\operatorname{zul}\left(D_j\right)\quad\land\quad\forall P_m\in\mathcal{P}_F:\operatorname{Begr}\left(P_m\right)',
    word_latex = '\forall D_j\in\mathcal{D}\!ef_F:\operatorname{zul}\left(D_j\right)\quad\land\quad\forall P_m\in\mathcal{P}_F:\operatorname{Begr}\left(P_m\right)',
    logical_derivation = 'Die zulässigen Definitionen und formal begründeten Propositionen bilden einen gerichteten Abhängigkeitsgraphen. Ist dieser Graph azyklisch, kann jedem Element ein Rang zugewiesen werden. Dadurch liegt jede abgeleitete Aussage logisch oberhalb ihrer Voraussetzungen und das System ist hierarchisch geordnet.',
    based_on_axioms = 'A1,A2,A3,A4,A5,A6,A7',
    status = 'accepted',
    created_revision_id = @revision_3394
WHERE proposition_number = '3.3.11'
AND @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL;

SET @proposition_3311 := (
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.11'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(
    proposition_id, axiom_id, assumption_id, dependency_type, note
)
SELECT
    @proposition_3311,
    a.axiom_id,
    NULL,
    'derived_from',
    CONCAT(
        'Proposition 3.3.11 verwendet ',
        a.axiom_number,
        ' als Bestandteil des hierarchisch geordneten formalen Ausgangssystems.'
    )
FROM axioms a
WHERE @proposition_3311 IS NOT NULL
AND a.axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies pd
    WHERE pd.proposition_id = @proposition_3311
      AND pd.axiom_id = a.axiom_id
      AND pd.assumption_id IS NULL
      AND pd.dependency_type = 'derived_from'
);

/* Relevante Gleichungs-IDs */
SET @eq_3525 := (SELECT equation_id FROM equations WHERE equation_number='3.525' LIMIT 1);
SET @eq_3527 := (SELECT equation_id FROM equations WHERE equation_number='3.527' LIMIT 1);
SET @eq_3528 := (SELECT equation_id FROM equations WHERE equation_number='3.528' LIMIT 1);
SET @eq_3534 := (SELECT equation_id FROM equations WHERE equation_number='3.534' LIMIT 1);
SET @eq_3539 := (SELECT equation_id FROM equations WHERE equation_number='3.539' LIMIT 1);
SET @eq_3544 := (SELECT equation_id FROM equations WHERE equation_number='3.544' LIMIT 1);
SET @eq_3545 := (SELECT equation_id FROM equations WHERE equation_number='3.545' LIMIT 1);
SET @eq_3546 := (SELECT equation_id FROM equations WHERE equation_number='3.546' LIMIT 1);
SET @eq_3547 := (SELECT equation_id FROM equations WHERE equation_number='3.547' LIMIT 1);
SET @eq_3548 := (SELECT equation_id FROM equations WHERE equation_number='3.548' LIMIT 1);
SET @eq_3549 := (SELECT equation_id FROM equations WHERE equation_number='3.549' LIMIT 1);
SET @eq_3552 := (SELECT equation_id FROM equations WHERE equation_number='3.552' LIMIT 1);

/* Zentrale Symbolregistrierungen */

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\mathfrak{L}_F',
    '\\mathfrak{L}_F',
    'Formales System des FRZK',
    'Geordnete Struktur aus Axiomen, Definitionen und Propositionen.',
    'chapter',
    @section_3394,
    @eq_3525,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\mathfrak{L}_F'
      AND scope_type = 'chapter'
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
    '\\mathcal{D}\\!ef_F',
    '\\mathcal{D}\\!ef_F',
    'Definitionsmenge des FRZK',
    'Menge der im FRZK eingeführten Definitionen.',
    'chapter',
    @section_3394,
    @eq_3527,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\mathcal{D}\\!ef_F'
      AND scope_type = 'chapter'
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
    '\\mathcal{P}_F',
    '\\mathcal{P}_F',
    'Propositionsmenge des FRZK',
    'Menge der aus Axiomen und Definitionen abgeleiteten Propositionen.',
    'chapter',
    @section_3394,
    @eq_3528,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\mathcal{P}_F'
      AND scope_type = 'chapter'
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
    '\\equiv_{\\mathrm{def}}',
    '\\equiv_{\\mathrm{def}}',
    'Definitorische Äquivalenz',
    'Relation der definitorischen Gleichbedeutung.',
    'chapter',
    @section_3394,
    @eq_3534,
    NULL,
    NULL,
    NULL,
    0,
    0,
    1,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\equiv_{\\mathrm{def}}'
      AND scope_type = 'chapter'
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
    '\\operatorname{zul}',
    '\\operatorname{zul}',
    'Zulässigkeitsprädikat',
    'Prädikat für die Zulässigkeit einer Definition innerhalb des FRZK.',
    'chapter',
    @section_3394,
    @eq_3539,
    NULL,
    NULL,
    NULL,
    0,
    0,
    1,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\operatorname{zul}'
      AND scope_type = 'chapter'
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
    '\\operatorname{Sym}',
    '\\operatorname{Sym}',
    'Symbolmengenoperator',
    'Operator zur Bestimmung der in einem Ausdruck verwendeten Symbole.',
    'chapter',
    @section_3394,
    @eq_3544,
    NULL,
    NULL,
    NULL,
    0,
    0,
    1,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\operatorname{Sym}'
      AND scope_type = 'chapter'
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
    '\\Delta_F',
    '\\Delta_F',
    'Ableitungsrelation',
    'Struktur aus Voraussetzungen, Ableitungsschritten und Schlussregeln einer Proposition.',
    'chapter',
    @section_3394,
    @eq_3545,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\Delta_F'
      AND scope_type = 'chapter'
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
    '\\operatorname{Begr}',
    '\\operatorname{Begr}',
    'Begründungsprädikat',
    'Prädikat der formalen Begründetheit einer Proposition.',
    'chapter',
    @section_3394,
    @eq_3546,
    NULL,
    NULL,
    NULL,
    0,
    0,
    1,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\operatorname{Begr}'
      AND scope_type = 'chapter'
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
    'G_{\\mathfrak{L}}',
    'G_{\\mathfrak{L}}',
    'Logischer Abhängigkeitsgraph',
    'Gerichteter Graph der Abhängigkeiten im formalen System.',
    'chapter',
    @section_3394,
    @eq_3547,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = 'G_{\\mathfrak{L}}'
      AND scope_type = 'chapter'
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
    'V_{\\mathfrak{L}}',
    'V_{\\mathfrak{L}}',
    'Knotenmenge des Abhängigkeitsgraphen',
    'Menge aller Axiome, Definitionen und Propositionen als Graphknoten.',
    'chapter',
    @section_3394,
    @eq_3548,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = 'V_{\\mathfrak{L}}'
      AND scope_type = 'chapter'
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
    'E_{\\mathfrak{L}}',
    'E_{\\mathfrak{L}}',
    'Kantenmenge des Abhängigkeitsgraphen',
    'Menge gerichteter logischer oder inhaltlicher Abhängigkeiten.',
    'chapter',
    @section_3394,
    @eq_3549,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = 'E_{\\mathfrak{L}}'
      AND scope_type = 'chapter'
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
    '\\rho',
    '\\rho',
    'Rangfunktion',
    'Funktion zur hierarchischen Ordnung der Elemente des formalen Systems.',
    'chapter',
    @section_3394,
    @eq_3552,
    NULL,
    NULL,
    NULL,
    0,
    0,
    1,
    'In Abschnitt 3.3.9.4 eingeführt oder präzisiert.',
    'checked',
    @revision_3394
WHERE @section_3394 IS NOT NULL
AND @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\rho'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3525,
    '\\mathfrak{L}_F',
    'Formales System des FRZK',
    'Struktur aus Axiomen, Definitionen und Propositionen.',
    NULL,
    NULL,
    1
WHERE @eq_3525 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3525
      AND symbol_latex = '\\mathfrak{L}_F'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3525,
    '\\mathcal{A}_F',
    'Axiomenmenge',
    'Menge der Axiome des FRZK.',
    NULL,
    NULL,
    2
WHERE @eq_3525 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3525
      AND symbol_latex = '\\mathcal{A}_F'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3525,
    '\\mathcal{D}\\!ef_F',
    'Definitionsmenge',
    'Menge der Definitionen des FRZK.',
    NULL,
    NULL,
    3
WHERE @eq_3525 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3525
      AND symbol_latex = '\\mathcal{D}\\!ef_F'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3525,
    '\\mathcal{P}_F',
    'Propositionsmenge',
    'Menge der Propositionen des FRZK.',
    NULL,
    NULL,
    4
WHERE @eq_3525 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3525
      AND symbol_latex = '\\mathcal{P}_F'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3534,
    '\\equiv_{\\mathrm{def}}',
    'Definitorische Äquivalenz',
    'Relation definitorischer Gleichbedeutung.',
    NULL,
    NULL,
    1
WHERE @eq_3534 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3534
      AND symbol_latex = '\\equiv_{\\mathrm{def}}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3539,
    '\\operatorname{zul}',
    'Zulässigkeitsprädikat',
    'Prädikat der definitorischen Zulässigkeit.',
    NULL,
    NULL,
    1
WHERE @eq_3539 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3539
      AND symbol_latex = '\\operatorname{zul}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3544,
    '\\operatorname{Sym}',
    'Symbolmengenoperator',
    'Operator zur Ermittlung verwendeter Symbole.',
    NULL,
    NULL,
    1
WHERE @eq_3544 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3544
      AND symbol_latex = '\\operatorname{Sym}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3545,
    '\\Delta_F',
    'Ableitungsrelation',
    'Struktur einer formalen Ableitung.',
    NULL,
    NULL,
    1
WHERE @eq_3545 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3545
      AND symbol_latex = '\\Delta_F'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3546,
    '\\operatorname{Begr}',
    'Begründungsprädikat',
    'Prädikat der formalen Begründetheit.',
    NULL,
    NULL,
    1
WHERE @eq_3546 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3546
      AND symbol_latex = '\\operatorname{Begr}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3547,
    'G_{\\mathfrak{L}}',
    'Logischer Abhängigkeitsgraph',
    'Gerichteter Graph formaler Abhängigkeiten.',
    NULL,
    NULL,
    1
WHERE @eq_3547 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3547
      AND symbol_latex = 'G_{\\mathfrak{L}}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3548,
    'V_{\\mathfrak{L}}',
    'Knotenmenge',
    'Knoten des Abhängigkeitsgraphen.',
    NULL,
    NULL,
    1
WHERE @eq_3548 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3548
      AND symbol_latex = 'V_{\\mathfrak{L}}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3549,
    'E_{\\mathfrak{L}}',
    'Kantenmenge',
    'Gerichtete Abhängigkeiten des Graphen.',
    NULL,
    NULL,
    1
WHERE @eq_3549 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3549
      AND symbol_latex = 'E_{\\mathfrak{L}}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name,
    definition_text, unit_text, domain_text, symbol_order
)
SELECT
    @eq_3552,
    '\\rho',
    'Rangfunktion',
    'Hierarchische Rangzuweisung.',
    NULL,
    NULL,
    1
WHERE @eq_3552 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3552
      AND symbol_latex = '\\rho'
);

/* Änderungsprotokoll – nur mit gültigen Fremdschlüsseln */
INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3394,
    @section_3394,
    'created',
    'section',
    '3.3.9.4',
    'Abschnitt 3.3.9.4 vollständig angelegt.',
    NULL,
    'Verhältnis von Axiomen, Definitionen und abgeleiteten Aussagen'
WHERE @revision_3394 IS NOT NULL
AND @section_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3394
      AND object_type = 'section'
      AND object_reference = '3.3.9.4'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3394,
    @section_3394,
    'proposition_added',
    'proposition',
    '3.3.11',
    'Proposition 3.3.11 registriert.',
    NULL,
    'Hierarchische Geschlossenheit des formalen Systems'
WHERE @revision_3394 IS NOT NULL
AND @section_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3394
      AND object_type = 'proposition'
      AND object_reference = '3.3.11'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3394,
    @section_3394,
    'equation_added',
    'equation',
    '(3.525)–(3.557)',
    '33 Gleichungen und formale Schemata registriert.',
    NULL,
    'Gleichungen (3.525) bis (3.557)'
WHERE @revision_3394 IS NOT NULL
AND @section_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3394
      AND object_type = 'equation'
      AND object_reference = '(3.525)–(3.557)'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_3394,
    @section_3394,
    'symbol_added',
    'symbol',
    '3.3.9.4-symbols',
    'Zentrale Symbole des formalen Abhängigkeits- und Rangsystems registriert.',
    NULL,
    '12 zentrale Symboldefinitionen'
WHERE @revision_3394 IS NOT NULL
AND @section_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3394
      AND object_type = 'symbol'
      AND object_reference = '3.3.9.4-symbols'
);

/* Validierungswerte */
SET @equation_count_3394 := (
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
        '3.525','3.526','3.527','3.528','3.529','3.530','3.531',
        '3.532','3.533','3.534','3.535','3.536','3.537','3.538',
        '3.539','3.540','3.541','3.542','3.543','3.544','3.545',
        '3.546','3.547','3.548','3.549','3.550','3.551','3.552',
        '3.553','3.554','3.555','3.556','3.557'
    )
);

SET @dependency_count_3394 := (
    SELECT COUNT(*)
    FROM proposition_dependencies
    WHERE proposition_id = @proposition_3311
      AND dependency_type = 'derived_from'
);

SET @symbol_count_3394 := (
    SELECT COUNT(*)
    FROM symbols
    WHERE scope_type = 'chapter'
      AND symbol_latex IN
      (
          '\mathfrak{L}_F',
          '\mathcal{D}\!ef_F',
          '\mathcal{P}_F',
          '\equiv_{\mathrm{def}}',
          '\operatorname{zul}',
          '\operatorname{Sym}',
          '\Delta_F',
          '\operatorname{Begr}',
          'G_{\mathfrak{L}}',
          'V_{\mathfrak{L}}',
          'E_{\mathfrak{L}}',
          '\rho'
      )
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3394,
    'K3.3.9.4.PRECONDITION',
    CASE WHEN @precondition_ok_3394 = 1 THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @precondition_ok_3394 = 1 THEN '1' ELSE '0' END,
    'Prüfung der Elternrevision und des übergeordneten Abschnitts.'
WHERE @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3394
      AND validation_code = 'K3.3.9.4.PRECONDITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3394,
    'K3.3.9.4.SECTION',
    CASE WHEN @section_3394 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_3394 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung des Abschnitts 3.3.9.4.'
WHERE @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3394
      AND validation_code = 'K3.3.9.4.SECTION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3394,
    'K3.3.9.4.PROPOSITION',
    CASE WHEN @proposition_3311 IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @proposition_3311 IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung der Proposition 3.3.11.'
WHERE @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3394
      AND validation_code = 'K3.3.9.4.PROPOSITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3394,
    'K3.3.9.4.EQUATIONS',
    CASE WHEN @equation_count_3394 = 33 THEN 'passed' ELSE 'failed' END,
    '33',
    CAST(@equation_count_3394 AS CHAR),
    'Prüfung der Gleichungen (3.525) bis (3.557).'
WHERE @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3394
      AND validation_code = 'K3.3.9.4.EQUATIONS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3394,
    'K3.3.9.4.AXIOM_DEPENDENCIES',
    CASE WHEN @dependency_count_3394 = 7 THEN 'passed' ELSE 'failed' END,
    '7',
    CAST(@dependency_count_3394 AS CHAR),
    'Prüfung der Axiomabhängigkeiten von Proposition 3.3.11.'
WHERE @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3394
      AND validation_code = 'K3.3.9.4.AXIOM_DEPENDENCIES'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3394,
    'K3.3.9.4.SYMBOLS',
    CASE WHEN @symbol_count_3394 = 12 THEN 'passed' ELSE 'failed' END,
    '12',
    CAST(@symbol_count_3394 AS CHAR),
    'Prüfung der zwölf zentralen Symbolregistrierungen.'
WHERE @revision_3394 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_3394
      AND validation_code = 'K3.3.9.4.SYMBOLS'
);

COMMIT;

/* Abschlussaudit */
SELECT
    CASE
        WHEN @parent_revision_3394 IS NULL
            THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.9.3-V1 fehlt.'
        WHEN @parent_section_3394 IS NULL
            THEN 'FEHLER: Übergeordneter Abschnitt 3.3.9 fehlt.'
        WHEN @revision_3394 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.9.4-V1 wurde nicht angelegt.'
        WHEN @section_3394 IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9.4 wurde nicht angelegt.'
        WHEN @proposition_3311 IS NULL
            THEN 'FEHLER: Proposition 3.3.11 wurde nicht angelegt.'
        WHEN @equation_count_3394 <> 33
            THEN CONCAT('FEHLER: ', @equation_count_3394, ' statt 33 Gleichungen vorhanden.')
        WHEN @dependency_count_3394 <> 7
            THEN CONCAT('FEHLER: ', @dependency_count_3394, ' statt 7 Axiomabhängigkeiten vorhanden.')
        WHEN @symbol_count_3394 <> 12
            THEN CONCAT('FEHLER: ', @symbol_count_3394, ' statt 12 zentralen Symbolen vorhanden.')
        ELSE 'OK: Repository-Update 3.3.9.4 vollständig und konsistent ausgeführt.'
    END AS import_status;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_3394
ORDER BY validation_code;
