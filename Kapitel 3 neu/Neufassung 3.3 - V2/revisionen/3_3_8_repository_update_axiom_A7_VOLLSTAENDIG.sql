/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.8
   Axiom A7 – Funktionale Zustandsübergänge

   Grundlage:
   - tatsächlicher Datenbankstand: frzk_rkb_nach_3.3.7.sql
   - Elternrevision: RKB-NEU-K3.3.7-V1
   - Gleichungsfortsetzung: (3.457) bis (3.485)

   Enthalten:
   - Revision RKB-NEU-K3.3.8-V1
   - Abschnitt 3.3.8
   - Axiom A7
   - Proposition 3.3.7
   - Gleichungen (3.457)–(3.485)
   - Axiom- und Proposition-Abhängigkeiten
   - neue Symbole und ausgewählte Gleichungssymbole
   - Änderungsprotokoll
   - idempotente Repository-Validierungen
   - Abschlusskontrollen

   Kompatibilität:
   - Zeichenkonvertierung ausschließlich über CONCAT
   - keine vorausgesetzten Spalten außerhalb des geprüften Schemas
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.7-V1'
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
    'RKB-NEU-K3.3.8-V1',
    NOW(),
    'section',
    '3.3.8',
    '1.0',
    'Abschnitt 3.3.8: Axiom A7 der funktionalen Zustandsübergänge, Proposition 3.3.7 und Gleichungen (3.457) bis (3.485).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.8-V1'
);

SET @revision_338 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.8-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @section_33_id,
    '3.3.8',
    'Axiom A7 – Funktionale Zustandsübergänge',
    3,
    3.3080,
    'final',
    1,
    'Einführung funktionaler Übergangsabbildungen, Übergangszulässigkeit, tragfähiger Übergänge, Übergangspfade sowie reversibler und irreversibler Zustandsübergänge.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.8'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_33_id,
    title = 'Axiom A7 – Funktionale Zustandsübergänge',
    chapter_no = 3,
    section_order = 3.3080,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Einführung funktionaler Übergangsabbildungen, Übergangszulässigkeit, tragfähiger Übergänge, Übergangspfade sowie reversibler und irreversibler Zustandsübergänge.'
WHERE section_code = '3.3.8';

SET @section_338_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.8'
    LIMIT 1
);

INSERT INTO axioms
(
    axiom_number, section_id, title, axiom_text,
    formal_latex, word_latex, motivation,
    independence_note, consistency_note, operationalization_note,
    source_assumption_id, status, created_revision_id
)
SELECT
    'A7',
    @section_338_id,
    'Funktionale Zustandsübergänge',
    'Ein funktionaler Zustand kann genau dann in einen anderen funktionalen Zustand übergehen, wenn mindestens eine zulässige funktionale Operation auf den Ausgangszustand wirkt und der daraus hervorgehende Folgezustand dem funktionalen Zustandsraum der Organisation angehört.',
    'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    'Axiom A7 erweitert die durch Axiom A6 eingeführte Zustandsbildung um die formale Möglichkeit dynamischer Veränderungen zwischen zulässigen funktionalen Zuständen.',
    'Axiom A7 ist nicht aus der bloßen Existenz funktionaler Zustände ableitbar. Axiom A6 sichert Zustandsbildung; Axiom A7 setzt zusätzlich die Möglichkeit operationsvermittelter Übergänge.',
    'Axiom A7 ist mit A1 bis A6 vereinbar. Es verlangt weder vollständige Reversibilität noch Kohärenzsteigerung, sondern lediglich die funktionale Zulässigkeit von Ausgangszustand, Operation und Folgezustand.',
    'Operationalisierung über T_F, die Übergangsmenge T_F, die Zulässigkeitsfunktion Lambda_F, Kohärenzänderungen, Übergangspfade sowie Reversibilität und Irreversibilität.',
    NULL,
    'accepted',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM axioms
    WHERE axiom_number = 'A7'
);

UPDATE axioms
SET
    section_id = @section_338_id,
    title = 'Funktionale Zustandsübergänge',
    axiom_text = 'Ein funktionaler Zustand kann genau dann in einen anderen funktionalen Zustand übergehen, wenn mindestens eine zulässige funktionale Operation auf den Ausgangszustand wirkt und der daraus hervorgehende Folgezustand dem funktionalen Zustandsraum der Organisation angehört.',
    formal_latex = 'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    word_latex = 'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    motivation = 'Axiom A7 erweitert die durch Axiom A6 eingeführte Zustandsbildung um die formale Möglichkeit dynamischer Veränderungen zwischen zulässigen funktionalen Zuständen.',
    independence_note = 'Axiom A7 ist nicht aus der bloßen Existenz funktionaler Zustände ableitbar. Axiom A6 sichert Zustandsbildung; Axiom A7 setzt zusätzlich die Möglichkeit operationsvermittelter Übergänge.',
    consistency_note = 'Axiom A7 ist mit A1 bis A6 vereinbar. Es verlangt weder vollständige Reversibilität noch Kohärenzsteigerung, sondern lediglich die funktionale Zulässigkeit von Ausgangszustand, Operation und Folgezustand.',
    operationalization_note = 'Operationalisierung über T_F, die Übergangsmenge T_F, die Zulässigkeitsfunktion Lambda_F, Kohärenzänderungen, Übergangspfade sowie Reversibilität und Irreversibilität.',
    source_assumption_id = NULL,
    status = 'accepted',
    created_revision_id = @revision_338
WHERE axiom_number = 'A7';

SET @axiom_a5_id :=
(
    SELECT axiom_id FROM axioms
    WHERE axiom_number = 'A5'
    LIMIT 1
);

SET @axiom_a6_id :=
(
    SELECT axiom_id FROM axioms
    WHERE axiom_number = 'A6'
    LIMIT 1
);

SET @axiom_a7_id :=
(
    SELECT axiom_id FROM axioms
    WHERE axiom_number = 'A7'
    LIMIT 1
);

INSERT INTO axiom_dependencies
(axiom_id, depends_on_axiom_id, dependency_type, note)
SELECT
    @axiom_a7_id,
    @axiom_a6_id,
    'extends',
    'Axiom A7 erweitert die durch Axiom A6 eingeführte Zustandsbildung um operationsvermittelte Übergänge zwischen funktionalen Zuständen.'
WHERE @axiom_a7_id IS NOT NULL
  AND @axiom_a6_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM axiom_dependencies
    WHERE axiom_id = @axiom_a7_id
      AND depends_on_axiom_id = @axiom_a6_id
      AND dependency_type = 'extends'
);


INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.457',
    @section_338_id,
    'Erster funktionaler Zustand',
    'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})',
    'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})',
    'Der Ausgangszustand gehört zum funktionalen Zustandsraum.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.457'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Erster funktionaler Zustand',
    equation_latex = 'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})',
    word_latex = 'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})',
    plain_description = 'Der Ausgangszustand gehört zum funktionalen Zustandsraum.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.457';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.458',
    @section_338_id,
    'Zweiter funktionaler Zustand',
    'z_F^{(j)}\\in\\Omega_F(\\mathcal{S})',
    'z_F^{(j)}\\in\\Omega_F(\\mathcal{S})',
    'Der Folgezustand gehört zum funktionalen Zustandsraum.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.458'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Zweiter funktionaler Zustand',
    equation_latex = 'z_F^{(j)}\\in\\Omega_F(\\mathcal{S})',
    word_latex = 'z_F^{(j)}\\in\\Omega_F(\\mathcal{S})',
    plain_description = 'Der Folgezustand gehört zum funktionalen Zustandsraum.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.458';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.459',
    @section_338_id,
    'Elementarer Zustandsübergang',
    'z_F^{(i)}\\longrightarrow z_F^{(j)}',
    'z_F^{(i)}\\longrightarrow z_F^{(j)}',
    'Darstellung eines funktionalen Übergangs vom Ausgangs- zum Folgezustand.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.459'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Elementarer Zustandsübergang',
    equation_latex = 'z_F^{(i)}\\longrightarrow z_F^{(j)}',
    word_latex = 'z_F^{(i)}\\longrightarrow z_F^{(j)}',
    plain_description = 'Darstellung eines funktionalen Übergangs vom Ausgangs- zum Folgezustand.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.459';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.460',
    @section_338_id,
    'Funktionale Übergangsabbildung',
    'T_F:\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F\\rightarrow\\Omega_F(\\mathcal{S})',
    'T_F:\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F\\rightarrow\\Omega_F(\\mathcal{S})',
    'Die Übergangsabbildung ordnet einem Zustand und einer Operation einen Folgezustand zu.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.460'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Funktionale Übergangsabbildung',
    equation_latex = 'T_F:\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F\\rightarrow\\Omega_F(\\mathcal{S})',
    word_latex = 'T_F:\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F\\rightarrow\\Omega_F(\\mathcal{S})',
    plain_description = 'Die Übergangsabbildung ordnet einem Zustand und einer Operation einen Folgezustand zu.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.460';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.461',
    @section_338_id,
    'Anwendung der Übergangsabbildung',
    'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    'Der Folgezustand entsteht durch Anwendung einer funktionalen Operation auf den Ausgangszustand.',
    'model',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.461'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Anwendung der Übergangsabbildung',
    equation_latex = 'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    word_latex = 'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    plain_description = 'Der Folgezustand entsteht durch Anwendung einer funktionalen Operation auf den Ausgangszustand.',
    equation_type = 'model',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.461';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.462',
    @section_338_id,
    'Axiomatische Übergangsbedingung',
    'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    'Axiom A7: Ausgangszustand, Operation und Folgezustand müssen funktional zulässig sein.',
    'axiom',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.462'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Axiomatische Übergangsbedingung',
    equation_latex = 'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    word_latex = 'z_F^{(i)}\\in\\Omega_F(\\mathcal{S})\\land O_{F,k}\\in\\mathcal{O}_F\\land T_F\\left(z_F^{(i)},O_{F,k}\\right)\\in\\Omega_F(\\mathcal{S})',
    plain_description = 'Axiom A7: Ausgangszustand, Operation und Folgezustand müssen funktional zulässig sein.',
    equation_type = 'axiom',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.462';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.463',
    @section_338_id,
    'Menge funktionaler Übergänge',
    '\\mathcal{T}_F\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    '\\mathcal{T}_F\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    'Die Menge zulässiger Übergänge ist eine Teilmenge des kartesischen Produkts des Zustandsraums.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.463'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Menge funktionaler Übergänge',
    equation_latex = '\\mathcal{T}_F\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    word_latex = '\\mathcal{T}_F\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    plain_description = 'Die Menge zulässiger Übergänge ist eine Teilmenge des kartesischen Produkts des Zustandsraums.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.463';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.464',
    @section_338_id,
    'Zulässiger Übergang',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    'Das geordnete Zustandspaar bezeichnet einen zulässigen funktionalen Übergang.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.464'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Zulässiger Übergang',
    equation_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    word_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    plain_description = 'Das geordnete Zustandspaar bezeichnet einen zulässigen funktionalen Übergang.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.464';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.465',
    @section_338_id,
    'Unzulässiger Übergang',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\notin\\mathcal{T}_F',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\notin\\mathcal{T}_F',
    'Das geordnete Zustandspaar bezeichnet keinen zulässigen funktionalen Übergang.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.465'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Unzulässiger Übergang',
    equation_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\notin\\mathcal{T}_F',
    word_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\notin\\mathcal{T}_F',
    plain_description = 'Das geordnete Zustandspaar bezeichnet keinen zulässigen funktionalen Übergang.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.465';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.466',
    @section_338_id,
    'Übergangszulässigkeitsfunktion',
    '\\Lambda_F:\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\rightarrow\\{0,1\\}',
    '\\Lambda_F:\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\rightarrow\\{0,1\\}',
    'Binäre Funktion zur Prüfung der Zulässigkeit funktionaler Zustandsübergänge.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.466'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Übergangszulässigkeitsfunktion',
    equation_latex = '\\Lambda_F:\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\rightarrow\\{0,1\\}',
    word_latex = '\\Lambda_F:\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\rightarrow\\{0,1\\}',
    plain_description = 'Binäre Funktion zur Prüfung der Zulässigkeit funktionaler Zustandsübergänge.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.466';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.467',
    @section_338_id,
    'Zulässigkeitswert eines Übergangs',
    '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
    '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
    'Kennzeichnung eines zulässigen funktionalen Zustandsübergangs.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.467'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Zulässigkeitswert eines Übergangs',
    equation_latex = '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
    word_latex = '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
    plain_description = 'Kennzeichnung eines zulässigen funktionalen Zustandsübergangs.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.467';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.468',
    @section_338_id,
    'Unzulässigkeitswert eines Übergangs',
    '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=0',
    '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=0',
    'Kennzeichnung eines unzulässigen funktionalen Zustandsübergangs.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.468'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Unzulässigkeitswert eines Übergangs',
    equation_latex = '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=0',
    word_latex = '\\Lambda_F\\left(z_F^{(i)},z_F^{(j)}\\right)=0',
    plain_description = 'Kennzeichnung eines unzulässigen funktionalen Zustandsübergangs.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.468';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.469',
    @section_338_id,
    'Kohärenzerhaltender Zustandsübergang',
    'C_F\\left(z_F^{(j)}\\right)\\geq C_F\\left(z_F^{(i)}\\right)-\\varepsilon',
    'C_F\\left(z_F^{(j)}\\right)\\geq C_F\\left(z_F^{(i)}\\right)-\\varepsilon',
    'Der Kohärenzverlust bleibt innerhalb einer zugelassenen Toleranz.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.469'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Kohärenzerhaltender Zustandsübergang',
    equation_latex = 'C_F\\left(z_F^{(j)}\\right)\\geq C_F\\left(z_F^{(i)}\\right)-\\varepsilon',
    word_latex = 'C_F\\left(z_F^{(j)}\\right)\\geq C_F\\left(z_F^{(i)}\\right)-\\varepsilon',
    plain_description = 'Der Kohärenzverlust bleibt innerhalb einer zugelassenen Toleranz.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.469';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.470',
    @section_338_id,
    'Kohärenzsteigernder Zustandsübergang',
    'C_F\\left(z_F^{(j)}\\right)>C_F\\left(z_F^{(i)}\\right)',
    'C_F\\left(z_F^{(j)}\\right)>C_F\\left(z_F^{(i)}\\right)',
    'Der Folgezustand besitzt einen höheren Kohärenzwert als der Ausgangszustand.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.470'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Kohärenzsteigernder Zustandsübergang',
    equation_latex = 'C_F\\left(z_F^{(j)}\\right)>C_F\\left(z_F^{(i)}\\right)',
    word_latex = 'C_F\\left(z_F^{(j)}\\right)>C_F\\left(z_F^{(i)}\\right)',
    plain_description = 'Der Folgezustand besitzt einen höheren Kohärenzwert als der Ausgangszustand.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.470';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.471',
    @section_338_id,
    'Kohärenzmindernder Zustandsübergang',
    'C_F\\left(z_F^{(j)}\\right)<C_F\\left(z_F^{(i)}\\right)',
    'C_F\\left(z_F^{(j)}\\right)<C_F\\left(z_F^{(i)}\\right)',
    'Der Folgezustand besitzt einen niedrigeren Kohärenzwert als der Ausgangszustand.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.471'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Kohärenzmindernder Zustandsübergang',
    equation_latex = 'C_F\\left(z_F^{(j)}\\right)<C_F\\left(z_F^{(i)}\\right)',
    word_latex = 'C_F\\left(z_F^{(j)}\\right)<C_F\\left(z_F^{(i)}\\right)',
    plain_description = 'Der Folgezustand besitzt einen niedrigeren Kohärenzwert als der Ausgangszustand.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.471';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.472',
    @section_338_id,
    'Tragfähiger Folgezustand',
    'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    'Der Folgezustand bleibt oberhalb der kritischen Kohärenzschwelle.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.472'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Tragfähiger Folgezustand',
    equation_latex = 'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    word_latex = 'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    plain_description = 'Der Folgezustand bleibt oberhalb der kritischen Kohärenzschwelle.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.472';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.473',
    @section_338_id,
    'Nicht tragfähiger Folgezustand',
    'C_F\\left(z_F^{(j)}\\right)<C_{\\mathrm{krit}}',
    'C_F\\left(z_F^{(j)}\\right)<C_{\\mathrm{krit}}',
    'Der Folgezustand unterschreitet die kritische Kohärenzschwelle.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.473'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Nicht tragfähiger Folgezustand',
    equation_latex = 'C_F\\left(z_F^{(j)}\\right)<C_{\\mathrm{krit}}',
    word_latex = 'C_F\\left(z_F^{(j)}\\right)<C_{\\mathrm{krit}}',
    plain_description = 'Der Folgezustand unterschreitet die kritische Kohärenzschwelle.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.473';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.474',
    @section_338_id,
    'Menge tragfähiger Übergänge',
    '\\mathcal{T}_F^{+}=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\mid C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}\\right\\}',
    '\\mathcal{T}_F^{+}=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\mid C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}\\right\\}',
    'Teilmenge zulässiger Übergänge mit tragfähigem Folgezustand.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.474'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Menge tragfähiger Übergänge',
    equation_latex = '\\mathcal{T}_F^{+}=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\mid C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}\\right\\}',
    word_latex = '\\mathcal{T}_F^{+}=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\mid C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}\\right\\}',
    plain_description = 'Teilmenge zulässiger Übergänge mit tragfähigem Folgezustand.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.474';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.475',
    @section_338_id,
    'Unmittelbarer Zustandsübergang',
    'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    'Ein unmittelbarer Übergang wird durch genau eine wirksame Operation vermittelt.',
    'model',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.475'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Unmittelbarer Zustandsübergang',
    equation_latex = 'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    word_latex = 'z_F^{(j)}=T_F\\left(z_F^{(i)},O_{F,k}\\right)',
    plain_description = 'Ein unmittelbarer Übergang wird durch genau eine wirksame Operation vermittelt.',
    equation_type = 'model',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.475';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.476',
    @section_338_id,
    'Mehrstufige Zustandsfolge',
    'z_F^{(0)}\\rightarrow z_F^{(1)}\\rightarrow\\dots\\rightarrow z_F^{(n)}',
    'z_F^{(0)}\\rightarrow z_F^{(1)}\\rightarrow\\dots\\rightarrow z_F^{(n)}',
    'Folge mehrerer elementarer funktionaler Zustandsübergänge.',
    'model',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.476'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Mehrstufige Zustandsfolge',
    equation_latex = 'z_F^{(0)}\\rightarrow z_F^{(1)}\\rightarrow\\dots\\rightarrow z_F^{(n)}',
    word_latex = 'z_F^{(0)}\\rightarrow z_F^{(1)}\\rightarrow\\dots\\rightarrow z_F^{(n)}',
    plain_description = 'Folge mehrerer elementarer funktionaler Zustandsübergänge.',
    equation_type = 'model',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.476';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.477',
    @section_338_id,
    'Teilschritt eines Übergangspfades',
    'z_F^{(i+1)}=T_F\\left(z_F^{(i)},O_{F,i}\\right)',
    'z_F^{(i+1)}=T_F\\left(z_F^{(i)},O_{F,i}\\right)',
    'Jeder Teilschritt eines Übergangspfades wird durch eine funktionale Operation erzeugt.',
    'model',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.477'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Teilschritt eines Übergangspfades',
    equation_latex = 'z_F^{(i+1)}=T_F\\left(z_F^{(i)},O_{F,i}\\right)',
    word_latex = 'z_F^{(i+1)}=T_F\\left(z_F^{(i)},O_{F,i}\\right)',
    plain_description = 'Jeder Teilschritt eines Übergangspfades wird durch eine funktionale Operation erzeugt.',
    equation_type = 'model',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.477';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.478',
    @section_338_id,
    'Funktionaler Übergangspfad',
    '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    'Geordnete Folge funktionaler Zustände eines Übergangspfades.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.478'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Funktionaler Übergangspfad',
    equation_latex = '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    word_latex = '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    plain_description = 'Geordnete Folge funktionaler Zustände eines Übergangspfades.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.478';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.479',
    @section_338_id,
    'Tragfähigkeit des gesamten Übergangspfades',
    'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}\\qquad\\forall i\\in\\{0,\\dots,n\\}',
    'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}\\qquad\\forall i\\in\\{0,\\dots,n\\}',
    'Alle Zustände des Übergangspfades erfüllen die kritische Kohärenzbedingung.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.479'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Tragfähigkeit des gesamten Übergangspfades',
    equation_latex = 'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}\\qquad\\forall i\\in\\{0,\\dots,n\\}',
    word_latex = 'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}\\qquad\\forall i\\in\\{0,\\dots,n\\}',
    plain_description = 'Alle Zustände des Übergangspfades erfüllen die kritische Kohärenzbedingung.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.479';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.480',
    @section_338_id,
    'Rückführende Operation',
    'z_F^{(i)}=T_F\\left(z_F^{(j)},O_{F,l}\\right)',
    'z_F^{(i)}=T_F\\left(z_F^{(j)},O_{F,l}\\right)',
    'Eine geeignete Operation führt vom Folgezustand zum Ausgangszustand zurück.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.480'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Rückführende Operation',
    equation_latex = 'z_F^{(i)}=T_F\\left(z_F^{(j)},O_{F,l}\\right)',
    word_latex = 'z_F^{(i)}=T_F\\left(z_F^{(j)},O_{F,l}\\right)',
    plain_description = 'Eine geeignete Operation führt vom Folgezustand zum Ausgangszustand zurück.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.480';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.481',
    @section_338_id,
    'Reversibler Zustandsübergang',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\in\\mathcal{T}_F',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\in\\mathcal{T}_F',
    'Ein Übergang ist reversibel, wenn auch der Rückübergang zulässig ist.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.481'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Reversibler Zustandsübergang',
    equation_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\in\\mathcal{T}_F',
    word_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\in\\mathcal{T}_F',
    plain_description = 'Ein Übergang ist reversibel, wenn auch der Rückübergang zulässig ist.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.481';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.482',
    @section_338_id,
    'Irreversibler Zustandsübergang',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\notin\\mathcal{T}_F',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\notin\\mathcal{T}_F',
    'Ein Übergang ist irreversibel, wenn der Rückübergang nicht zulässig ist.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.482'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Irreversibler Zustandsübergang',
    equation_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\notin\\mathcal{T}_F',
    word_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F\\land\\left(z_F^{(j)},z_F^{(i)}\\right)\\notin\\mathcal{T}_F',
    plain_description = 'Ein Übergang ist irreversibel, wenn der Rückübergang nicht zulässig ist.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.482';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.483',
    @section_338_id,
    'Übergangspfad der Proposition',
    '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    'Funktionaler Übergangspfad als Grundlage von Proposition 3.3.7.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.483'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Übergangspfad der Proposition',
    equation_latex = '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    word_latex = '\\Pi_F=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    plain_description = 'Funktionaler Übergangspfad als Grundlage von Proposition 3.3.7.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.483';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.484',
    @section_338_id,
    'Zulässigkeit aller Teilschritte',
    '\\Lambda_F\\left(z_F^{(i)},z_F^{(i+1)}\\right)=1',
    '\\Lambda_F\\left(z_F^{(i)},z_F^{(i+1)}\\right)=1',
    'Jeder Teilschritt des Übergangspfades ist zulässig.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.484'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Zulässigkeit aller Teilschritte',
    equation_latex = '\\Lambda_F\\left(z_F^{(i)},z_F^{(i+1)}\\right)=1',
    word_latex = '\\Lambda_F\\left(z_F^{(i)},z_F^{(i+1)}\\right)=1',
    plain_description = 'Jeder Teilschritt des Übergangspfades ist zulässig.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.484';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.485',
    @section_338_id,
    'Kohärenz aller Pfadzustände',
    'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}',
    'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}',
    'Jeder Zustand des Übergangspfades bleibt funktional tragfähig.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.8.',
    'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    'checked',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.485'
);

UPDATE equations
SET
    section_id = @section_338_id,
    title = 'Kohärenz aller Pfadzustände',
    equation_latex = 'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}',
    word_latex = 'C_F\\left(z_F^{(i)}\\right)\\geq C_{\\mathrm{krit}}',
    plain_description = 'Jeder Zustand des Übergangspfades bleibt funktional tragfähig.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.8.',
    assumptions = 'Axiome A1 bis A7 sowie die in Abschnitt 3.3.7 eingeführte funktionale Zustandsbildung.',
    validation_status = 'checked',
    created_revision_id = @revision_338
WHERE equation_number = '3.485';

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.7',
    @section_338_id,
    'Funktionale Dynamik entsteht aus zulässigen Zustandsübergängen',
    'Sei Pi_F ein funktionaler Übergangspfad. Sind sämtliche Teilschritte zulässig und bleiben alle Zustände oberhalb der kritischen Kohärenzschwelle, so bildet der Übergangspfad eine tragfähige funktionale Dynamik.',
    '\Pi_F=\left(z_F^{(0)},z_F^{(1)},\dots,z_F^{(n)}\right),\quad \Lambda_F\left(z_F^{(i)},z_F^{(i+1)}\right)=1,\quad C_F\left(z_F^{(i)}\right)\geq C_{\mathrm{krit}}',
    '\Pi_F=\left(z_F^{(0)},z_F^{(1)},\dots,z_F^{(n)}\right),\quad \Lambda_F\left(z_F^{(i)},z_F^{(i+1)}\right)=1,\quad C_F\left(z_F^{(i)}\right)\geq C_{\mathrm{krit}}',
    'Axiom A6 sichert die Existenz konkreter funktionaler Zustände. Axiom A7 bestimmt die Bedingungen ihrer operationsvermittelten Übergänge. Axiom A5 fordert den hinreichenden funktionalen Zusammenhang. Sind alle Einzelübergänge zulässig und bleiben sämtliche Zustände oberhalb der kritischen Kohärenzschwelle, ist der gesamte Übergangspfad funktional tragfähig.',
    'A5,A6,A7',
    'accepted',
    @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM propositions
    WHERE proposition_number = '3.3.7'
);

UPDATE propositions
SET
    section_id = @section_338_id,
    title = 'Funktionale Dynamik entsteht aus zulässigen Zustandsübergängen',
    statement_text = 'Sei Pi_F ein funktionaler Übergangspfad. Sind sämtliche Teilschritte zulässig und bleiben alle Zustände oberhalb der kritischen Kohärenzschwelle, so bildet der Übergangspfad eine tragfähige funktionale Dynamik.',
    statement_latex = '\Pi_F=\left(z_F^{(0)},z_F^{(1)},\dots,z_F^{(n)}\right),\quad \Lambda_F\left(z_F^{(i)},z_F^{(i+1)}\right)=1,\quad C_F\left(z_F^{(i)}\right)\geq C_{\mathrm{krit}}',
    word_latex = '\Pi_F=\left(z_F^{(0)},z_F^{(1)},\dots,z_F^{(n)}\right),\quad \Lambda_F\left(z_F^{(i)},z_F^{(i+1)}\right)=1,\quad C_F\left(z_F^{(i)}\right)\geq C_{\mathrm{krit}}',
    logical_derivation = 'Axiom A6 sichert die Existenz konkreter funktionaler Zustände. Axiom A7 bestimmt die Bedingungen ihrer operationsvermittelten Übergänge. Axiom A5 fordert den hinreichenden funktionalen Zusammenhang. Sind alle Einzelübergänge zulässig und bleiben sämtliche Zustände oberhalb der kritischen Kohärenzschwelle, ist der gesamte Übergangspfad funktional tragfähig.',
    based_on_axioms = 'A5,A6,A7',
    status = 'accepted',
    created_revision_id = @revision_338
WHERE proposition_number = '3.3.7';

SET @prop_337_id :=
(
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.7'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT
    @prop_337_id,
    @axiom_a5_id,
    NULL,
    'uses',
    'Axiom A5 liefert die kritische Kohärenzbedingung für alle Zustände des Übergangspfades.'
WHERE @prop_337_id IS NOT NULL
  AND @axiom_a5_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies
    WHERE proposition_id = @prop_337_id
      AND axiom_id = @axiom_a5_id
      AND assumption_id IS NULL
      AND dependency_type = 'uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT
    @prop_337_id,
    @axiom_a6_id,
    NULL,
    'uses',
    'Axiom A6 sichert die Existenz der im Übergangspfad enthaltenen funktionalen Zustände.'
WHERE @prop_337_id IS NOT NULL
  AND @axiom_a6_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies
    WHERE proposition_id = @prop_337_id
      AND axiom_id = @axiom_a6_id
      AND assumption_id IS NULL
      AND dependency_type = 'uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT
    @prop_337_id,
    @axiom_a7_id,
    NULL,
    'derived_from',
    'Proposition 3.3.7 folgt unmittelbar aus den durch Axiom A7 bestimmten Bedingungen funktionaler Zustandsübergänge.'
WHERE @prop_337_id IS NOT NULL
  AND @axiom_a7_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies
    WHERE proposition_id = @prop_337_id
      AND axiom_id = @axiom_a7_id
      AND assumption_id IS NULL
      AND dependency_type = 'derived_from'
);

/* --------------------------------------------------------------------------
   Symbolregistrierung
   -------------------------------------------------------------------------- */

SET @eq_3460 := (SELECT equation_id FROM equations WHERE equation_number = '3.460' LIMIT 1);
SET @eq_3463 := (SELECT equation_id FROM equations WHERE equation_number = '3.463' LIMIT 1);
SET @eq_3466 := (SELECT equation_id FROM equations WHERE equation_number = '3.466' LIMIT 1);
SET @eq_3474 := (SELECT equation_id FROM equations WHERE equation_number = '3.474' LIMIT 1);
SET @eq_3478 := (SELECT equation_id FROM equations WHERE equation_number = '3.478' LIMIT 1);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id, unit_text,
    domain_text, codomain_text, is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    'T_F', 'T_F', 'Funktionale Übergangsabbildung',
    'Abbildung eines funktionalen Ausgangszustands und einer wirksamen Operation auf einen funktionalen Folgezustand.',
    'chapter', @section_338_id, @eq_3460, NULL,
    '\Omega_F(\mathcal{S})\times\mathcal{O}_F',
    '\Omega_F(\mathcal{S})',
    0, 0, 1,
    'In Abschnitt 3.3.8 eingeführt.',
    'checked', @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = 'T_F'
      AND scope_type = 'chapter'
      AND first_section_id = @section_338_id
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id, unit_text,
    domain_text, codomain_text, is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\mathcal{T}_F', '\mathcal{T}_F', 'Menge funktionaler Zustandsübergänge',
    'Menge aller zulässigen geordneten Paare funktionaler Ausgangs- und Folgezustände.',
    'chapter', @section_338_id, @eq_3463, NULL,
    '\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})',
    NULL,
    0, 0, 0,
    'In Abschnitt 3.3.8 eingeführt.',
    'checked', @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\mathcal{T}_F'
      AND scope_type = 'chapter'
      AND first_section_id = @section_338_id
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id, unit_text,
    domain_text, codomain_text, is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\Lambda_F', '\Lambda_F', 'Übergangszulässigkeitsfunktion',
    'Binäre Funktion zur Prüfung der Zulässigkeit eines funktionalen Zustandsübergangs.',
    'chapter', @section_338_id, @eq_3466, NULL,
    '\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})',
    '\{0,1\}',
    0, 0, 1,
    'In Abschnitt 3.3.8 eingeführt.',
    'checked', @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\Lambda_F'
      AND scope_type = 'chapter'
      AND first_section_id = @section_338_id
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id, unit_text,
    domain_text, codomain_text, is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\mathcal{T}_F^{+}', '\mathcal{T}_F^{+}', 'Menge tragfähiger funktionaler Übergänge',
    'Teilmenge der zulässigen Zustandsübergänge, deren Folgezustände die kritische Kohärenzschwelle erfüllen.',
    'chapter', @section_338_id, @eq_3474, NULL,
    '\mathcal{T}_F',
    NULL,
    0, 0, 0,
    'In Abschnitt 3.3.8 eingeführt.',
    'checked', @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\mathcal{T}_F^{+}'
      AND scope_type = 'chapter'
      AND first_section_id = @section_338_id
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id, unit_text,
    domain_text, codomain_text, is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\Pi_F', '\Pi_F', 'Funktionaler Übergangspfad',
    'Geordnete Folge funktionaler Zustände, deren aufeinanderfolgende Paare zulässige Übergänge bilden.',
    'chapter', @section_338_id, @eq_3478, NULL,
    '\Omega_F(\mathcal{S})',
    NULL,
    0, 0, 0,
    'In Abschnitt 3.3.8 eingeführt.',
    'checked', @revision_338
WHERE @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\Pi_F'
      AND scope_type = 'chapter'
      AND first_section_id = @section_338_id
);

/* Ausgewählte Gleichungssymbole */

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT
    @eq_3460, 'T_F', 'Funktionale Übergangsabbildung',
    'Abbildung von Ausgangszustand und Operation auf einen Folgezustand.',
    NULL, '\Omega_F(\mathcal{S})\times\mathcal{O}_F', 1
WHERE @eq_3460 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3460
      AND symbol_latex = 'T_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT
    @eq_3463, '\mathcal{T}_F', 'Menge funktionaler Zustandsübergänge',
    'Menge zulässiger geordneter Zustandspaare.',
    NULL, '\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})', 1
WHERE @eq_3463 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3463
      AND symbol_latex = '\mathcal{T}_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT
    @eq_3466, '\Lambda_F', 'Übergangszulässigkeitsfunktion',
    'Binäre Prüfung der Zulässigkeit eines funktionalen Zustandsübergangs.',
    NULL, '\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})', 1
WHERE @eq_3466 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3466
      AND symbol_latex = '\Lambda_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT
    @eq_3474, '\mathcal{T}_F^{+}', 'Menge tragfähiger Übergänge',
    'Teilmenge zulässiger Übergänge mit tragfähigem Folgezustand.',
    NULL, '\mathcal{T}_F', 1
WHERE @eq_3474 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3474
      AND symbol_latex = '\mathcal{T}_F^{+}'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT
    @eq_3478, '\Pi_F', 'Funktionaler Übergangspfad',
    'Geordnete Folge funktionaler Zustände.',
    NULL, '\Omega_F(\mathcal{S})', 1
WHERE @eq_3478 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3478
      AND symbol_latex = '\Pi_F'
);

/* --------------------------------------------------------------------------
   Änderungsprotokoll
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_338, @section_338_id, 'created', 'section', '3.3.8',
    'Abschnitt 3.3.8 vollständig angelegt.',
    NULL,
    'Axiom A7 – Funktionale Zustandsübergänge'
WHERE @revision_338 IS NOT NULL
  AND @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_338
      AND object_type = 'section'
      AND object_reference = '3.3.8'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_338, @section_338_id, 'axiom_added', 'axiom', 'A7',
    'Axiom A7 der funktionalen Zustandsübergänge registriert.',
    NULL,
    'A7 – Funktionale Zustandsübergänge'
WHERE @revision_338 IS NOT NULL
  AND @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_338
      AND object_type = 'axiom'
      AND object_reference = 'A7'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_338, @section_338_id, 'proposition_added', 'proposition', '3.3.7',
    'Proposition 3.3.7 registriert.',
    NULL,
    'Funktionale Dynamik entsteht aus zulässigen Zustandsübergängen'
WHERE @revision_338 IS NOT NULL
  AND @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_338
      AND object_type = 'proposition'
      AND object_reference = '3.3.7'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_338, @section_338_id, 'equation_added', 'equation', '(3.457)–(3.485)',
    '29 Gleichungen zu funktionalen Zustandsübergängen registriert.',
    NULL,
    'Gleichungen (3.457) bis (3.485)'
WHERE @revision_338 IS NOT NULL
  AND @section_338_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_338
      AND object_type = 'equation'
      AND object_reference = '(3.457)–(3.485)'
);

/* --------------------------------------------------------------------------
   Repository-Validierungen
   -------------------------------------------------------------------------- */

SET @equation_count_338 :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN
    (
        '3.457','3.458','3.459','3.460','3.461','3.462','3.463','3.464',
        '3.465','3.466','3.467','3.468','3.469','3.470','3.471','3.472',
        '3.473','3.474','3.475','3.476','3.477','3.478','3.479','3.480',
        '3.481','3.482','3.483','3.484','3.485'
    )
);

SET @symbol_count_338 :=
(
    SELECT COUNT(*)
    FROM symbols
    WHERE first_section_id = @section_338_id
      AND symbol_latex IN
      (
          'T_F',
          '\mathcal{T}_F',
          '\Lambda_F',
          '\mathcal{T}_F^{+}',
          '\Pi_F'
      )
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_338,
    'K3.3.8.PARENT_REVISION',
    CASE
        WHEN @parent_revision_id IS NOT NULL THEN 'passed'
        ELSE 'failed'
    END,
    'RKB-NEU-K3.3.7-V1',
    CASE
        WHEN @parent_revision_id IS NOT NULL THEN 'RKB-NEU-K3.3.7-V1'
        ELSE 'missing'
    END,
    'Prüfung der Elternrevision für Abschnitt 3.3.8.'
WHERE @revision_338 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_338
      AND validation_code = 'K3.3.8.PARENT_REVISION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_338,
    'K3.3.8.SECTION',
    CASE
        WHEN @section_338_id IS NOT NULL THEN 'passed'
        ELSE 'failed'
    END,
    '1',
    CASE
        WHEN @section_338_id IS NOT NULL THEN '1'
        ELSE '0'
    END,
    'Prüfung, ob Abschnitt 3.3.8 genau einmal vorhanden ist.'
WHERE @revision_338 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_338
      AND validation_code = 'K3.3.8.SECTION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_338,
    'K3.3.8.AXIOM_A7',
    CASE
        WHEN @axiom_a7_id IS NOT NULL THEN 'passed'
        ELSE 'failed'
    END,
    '1',
    CASE
        WHEN @axiom_a7_id IS NOT NULL THEN '1'
        ELSE '0'
    END,
    'Prüfung von Axiom A7.'
WHERE @revision_338 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_338
      AND validation_code = 'K3.3.8.AXIOM_A7'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_338,
    'K3.3.8.PROPOSITION',
    CASE
        WHEN @prop_337_id IS NOT NULL THEN 'passed'
        ELSE 'failed'
    END,
    '1',
    CASE
        WHEN @prop_337_id IS NOT NULL THEN '1'
        ELSE '0'
    END,
    'Prüfung von Proposition 3.3.7.'
WHERE @revision_338 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_338
      AND validation_code = 'K3.3.8.PROPOSITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_338,
    'K3.3.8.EQUATIONS',
    CASE
        WHEN @equation_count_338 = 29 THEN 'passed'
        ELSE 'failed'
    END,
    '29',
    CONCAT(@equation_count_338, ''),
    'Prüfung der Gleichungen (3.457) bis (3.485).'
WHERE @revision_338 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_338
      AND validation_code = 'K3.3.8.EQUATIONS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_338,
    'K3.3.8.SYMBOLS',
    CASE
        WHEN @symbol_count_338 = 5 THEN 'passed'
        ELSE 'failed'
    END,
    '5',
    CONCAT(@symbol_count_338, ''),
    'Prüfung der fünf in Abschnitt 3.3.8 neu registrierten Hauptsymbole.'
WHERE @revision_338 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_338
      AND validation_code = 'K3.3.8.SYMBOLS'
);

COMMIT;

/* --------------------------------------------------------------------------
   Abschlusskontrollen
   -------------------------------------------------------------------------- */

SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.7-V1 fehlt.'
        WHEN @section_33_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
        WHEN @revision_338 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.8-V1 fehlt.'
        WHEN @section_338_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.8 fehlt.'
        WHEN @axiom_a7_id IS NULL
            THEN 'FEHLER: Axiom A7 fehlt.'
        WHEN @prop_337_id IS NULL
            THEN 'FEHLER: Proposition 3.3.7 fehlt.'
        WHEN @equation_count_338 <> 29
            THEN CONCAT(
                'FEHLER: Es wurden ',
                @equation_count_338,
                ' statt 29 Gleichungen gefunden.'
            )
        WHEN @symbol_count_338 <> 5
            THEN CONCAT(
                'FEHLER: Es wurden ',
                @symbol_count_338,
                ' statt 5 neuen Hauptsymbolen gefunden.'
            )
        ELSE 'OK: Repository-Update 3.3.8 vollständig ausgeführt.'
    END AS import_status;

SELECT
    rr.revision_id,
    rr.revision_code,
    rr.parent_revision_id,
    ds.section_id,
    ds.section_code,
    ds.title,
    ds.status,
    @equation_count_338 AS equation_count,
    @symbol_count_338 AS new_symbol_count
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code = rr.scope_reference
WHERE rr.revision_code = 'RKB-NEU-K3.3.8-V1';

SELECT
    axiom_number,
    title,
    status,
    created_revision_id
FROM axioms
WHERE axiom_number = 'A7';

SELECT
    proposition_number,
    title,
    based_on_axioms,
    status,
    created_revision_id
FROM propositions
WHERE proposition_number = '3.3.7';

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE equation_number IN
(
    '3.457','3.458','3.459','3.460','3.461','3.462','3.463','3.464',
    '3.465','3.466','3.467','3.468','3.469','3.470','3.471','3.472',
    '3.473','3.474','3.475','3.476','3.477','3.478','3.479','3.480',
    '3.481','3.482','3.483','3.484','3.485'
)
ORDER BY equation_number;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_338
ORDER BY validation_code;
