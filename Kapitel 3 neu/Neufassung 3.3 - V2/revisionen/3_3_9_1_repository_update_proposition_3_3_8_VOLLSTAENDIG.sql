/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.9.1
   Proposition 3.3.8 – Existenz eines funktionalen Dynamikraums

   Grundlage:
   - tatsächlicher Datenbankstand: frzk_rkb_3.3.8.sql
   - Elternrevision: RKB-NEU-K3.3.8-V1
   - Gleichungsfortsetzung: (3.486) bis (3.491)

   Enthalten:
   - Revision RKB-NEU-K3.3.9.1-V1
   - Abschnitt 3.3.9.1
   - Proposition 3.3.8
   - Gleichungen (3.486)–(3.491)
   - Abhängigkeiten von A1 bis A7
   - Symbol \mathfrak{D}_F
   - ausgewählte Gleichungssymbole
   - Änderungsprotokoll
   - Repository-Validierungen
   - Abschlusskontrollen

   Kompatibilität:
   - Zeichenkonvertierung ausschließlich über CONCAT
   - idempotente INSERT-/UPDATE-Struktur
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.8-V1'
    LIMIT 1
);

SET @section_339_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.9.1-V1',
    NOW(),
    'section',
    '3.3.9.1',
    '1.0',
    'Abschnitt 3.3.9.1: Proposition 3.3.8 zur Existenz eines funktionalen Dynamikraums und Gleichungen (3.486) bis (3.491).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.1-V1'
);

SET @revision_3391 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.9.1-V1'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @section_339_id,
    '3.3.9.1',
    'Möglichkeit funktionaler Dynamik',
    3,
    3.3091,
    'final',
    1,
    'Logische Ableitung eines funktionalen Dynamikraums aus den Axiomen A1 bis A7.'
WHERE @section_339_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.9.1'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_339_id,
    title = 'Möglichkeit funktionaler Dynamik',
    chapter_no = 3,
    section_order = 3.3091,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Logische Ableitung eines funktionalen Dynamikraums aus den Axiomen A1 bis A7.'
WHERE section_code = '3.3.9.1';

SET @section_3391_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.9.1'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.486',
    @section_3391_id,
    'Existenz eines funktionalen Dynamikraums',
    'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Longrightarrow\\exists\\mathfrak{D}_F',
    'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Longrightarrow\\exists\\mathfrak{D}_F',
    'Aus der gemeinsamen Gültigkeit der Axiome A1 bis A7 folgt die Existenz eines funktionalen Dynamikraums.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.1.',
    'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.486'
);

UPDATE equations
SET
    section_id = @section_3391_id,
    title = 'Existenz eines funktionalen Dynamikraums',
    equation_latex = 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Longrightarrow\\exists\\mathfrak{D}_F',
    word_latex = 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Longrightarrow\\exists\\mathfrak{D}_F',
    plain_description = 'Aus der gemeinsamen Gültigkeit der Axiome A1 bis A7 folgt die Existenz eines funktionalen Dynamikraums.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.1.',
    assumptions = 'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    validation_status = 'checked',
    created_revision_id = @revision_3391
WHERE equation_number = '3.486';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.487',
    @section_3391_id,
    'Symbol des funktionalen Dynamikraums',
    '\\mathfrak{D}_F',
    '\\mathfrak{D}_F',
    'Bezeichnung des durch das Axiomensystem eröffneten funktionalen Dynamikraums.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.1.',
    'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.487'
);

UPDATE equations
SET
    section_id = @section_3391_id,
    title = 'Symbol des funktionalen Dynamikraums',
    equation_latex = '\\mathfrak{D}_F',
    word_latex = '\\mathfrak{D}_F',
    plain_description = 'Bezeichnung des durch das Axiomensystem eröffneten funktionalen Dynamikraums.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.1.',
    assumptions = 'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    validation_status = 'checked',
    created_revision_id = @revision_3391
WHERE equation_number = '3.487';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.488',
    @section_3391_id,
    'Minimalstruktur des funktionalen Dynamikraums',
    '\\mathfrak{D}_F=\\left(\\Omega_F,\\mathcal{O}_F,\\mathcal{T}_F\\right)',
    '\\mathfrak{D}_F=\\left(\\Omega_F,\\mathcal{O}_F,\\mathcal{T}_F\\right)',
    'Der funktionale Dynamikraum umfasst mindestens Zustandsraum, Operationsmenge und Übergangsmenge.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.1.',
    'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.488'
);

UPDATE equations
SET
    section_id = @section_3391_id,
    title = 'Minimalstruktur des funktionalen Dynamikraums',
    equation_latex = '\\mathfrak{D}_F=\\left(\\Omega_F,\\mathcal{O}_F,\\mathcal{T}_F\\right)',
    word_latex = '\\mathfrak{D}_F=\\left(\\Omega_F,\\mathcal{O}_F,\\mathcal{T}_F\\right)',
    plain_description = 'Der funktionale Dynamikraum umfasst mindestens Zustandsraum, Operationsmenge und Übergangsmenge.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.1.',
    assumptions = 'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    validation_status = 'checked',
    created_revision_id = @revision_3391
WHERE equation_number = '3.488';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.489',
    @section_3391_id,
    'Konstruktive Axiomfolge',
    'A_1\\Rightarrow A_2\\Rightarrow A_3\\Rightarrow A_4\\Rightarrow A_5\\Rightarrow A_6\\Rightarrow A_7\\Rightarrow\\mathfrak{D}_F',
    'A_1\\Rightarrow A_2\\Rightarrow A_3\\Rightarrow A_4\\Rightarrow A_5\\Rightarrow A_6\\Rightarrow A_7\\Rightarrow\\mathfrak{D}_F',
    'Darstellung der konstruktiven Reihenfolge, in der die Axiome zur Bildung des Dynamikraums beitragen.',
    'model',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.1.',
    'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.489'
);

UPDATE equations
SET
    section_id = @section_3391_id,
    title = 'Konstruktive Axiomfolge',
    equation_latex = 'A_1\\Rightarrow A_2\\Rightarrow A_3\\Rightarrow A_4\\Rightarrow A_5\\Rightarrow A_6\\Rightarrow A_7\\Rightarrow\\mathfrak{D}_F',
    word_latex = 'A_1\\Rightarrow A_2\\Rightarrow A_3\\Rightarrow A_4\\Rightarrow A_5\\Rightarrow A_6\\Rightarrow A_7\\Rightarrow\\mathfrak{D}_F',
    plain_description = 'Darstellung der konstruktiven Reihenfolge, in der die Axiome zur Bildung des Dynamikraums beitragen.',
    equation_type = 'model',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.1.',
    assumptions = 'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    validation_status = 'checked',
    created_revision_id = @revision_3391
WHERE equation_number = '3.489';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.490',
    @section_3391_id,
    'Zulässigkeit eines Übergangs im Dynamikraum',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    'Ein Zustandsübergang gehört nur dann zum Dynamikraum, wenn er der Menge zulässiger funktionaler Übergänge angehört.',
    'definition',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.1.',
    'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.490'
);

UPDATE equations
SET
    section_id = @section_3391_id,
    title = 'Zulässigkeit eines Übergangs im Dynamikraum',
    equation_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    word_latex = '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\mathcal{T}_F',
    plain_description = 'Ein Zustandsübergang gehört nur dann zum Dynamikraum, wenn er der Menge zulässiger funktionaler Übergänge angehört.',
    equation_type = 'definition',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.1.',
    assumptions = 'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    validation_status = 'checked',
    created_revision_id = @revision_3391
WHERE equation_number = '3.490';

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.491',
    @section_3391_id,
    'Kohärenzbedingung des Folgezustands',
    'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    'Der Folgezustand muss mindestens die kritische Kohärenzschwelle erfüllen, damit die funktionale Organisation fortbestehen kann.',
    'theorem',
    'original',
    NULL,
    'Formalisierung in Abschnitt 3.3.9.1.',
    'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.491'
);

UPDATE equations
SET
    section_id = @section_3391_id,
    title = 'Kohärenzbedingung des Folgezustands',
    equation_latex = 'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    word_latex = 'C_F\\left(z_F^{(j)}\\right)\\geq C_{\\mathrm{krit}}',
    plain_description = 'Der Folgezustand muss mindestens die kritische Kohärenzschwelle erfüllen, damit die funktionale Organisation fortbestehen kann.',
    equation_type = 'theorem',
    provenance = 'original',
    source_id = NULL,
    derivation = 'Formalisierung in Abschnitt 3.3.9.1.',
    assumptions = 'Axiome A1 bis A7 sowie die in den Abschnitten 3.3.7 und 3.3.8 eingeführten Zustands- und Übergangsstrukturen.',
    validation_status = 'checked',
    created_revision_id = @revision_3391
WHERE equation_number = '3.491';

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.8',
    @section_3391_id,
    'Existenz eines funktionalen Dynamikraums',
    'Unter der gemeinsamen Annahme der Axiome A1 bis A7 existiert ein theoretisch konsistenter Rahmen, innerhalb dessen funktionale Organisationen Zustände ausbilden und zulässige Übergänge zwischen diesen Zuständen vollziehen können.',
    'A_1\land A_2\land A_3\land A_4\land A_5\land A_6\land A_7\Longrightarrow\exists\mathfrak{D}_F',
    'A_1\land A_2\land A_3\land A_4\land A_5\land A_6\land A_7\Longrightarrow\exists\mathfrak{D}_F',
    'Axiom A1 ermöglicht funktionale Unterscheidung, A2 Relationierung, A3 Transformation, A4 stabile Organisation, A5 Kohärenz, A6 Zustandsbildung und A7 zulässige Zustandsübergänge. Erst ihr Zusammenwirken eröffnet einen konsistenten funktionalen Dynamikraum.',
    'A1,A2,A3,A4,A5,A6,A7',
    'accepted',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM propositions
    WHERE proposition_number = '3.3.8'
);

UPDATE propositions
SET
    section_id = @section_3391_id,
    title = 'Existenz eines funktionalen Dynamikraums',
    statement_text = 'Unter der gemeinsamen Annahme der Axiome A1 bis A7 existiert ein theoretisch konsistenter Rahmen, innerhalb dessen funktionale Organisationen Zustände ausbilden und zulässige Übergänge zwischen diesen Zuständen vollziehen können.',
    statement_latex = 'A_1\land A_2\land A_3\land A_4\land A_5\land A_6\land A_7\Longrightarrow\exists\mathfrak{D}_F',
    word_latex = 'A_1\land A_2\land A_3\land A_4\land A_5\land A_6\land A_7\Longrightarrow\exists\mathfrak{D}_F',
    logical_derivation = 'Axiom A1 ermöglicht funktionale Unterscheidung, A2 Relationierung, A3 Transformation, A4 stabile Organisation, A5 Kohärenz, A6 Zustandsbildung und A7 zulässige Zustandsübergänge. Erst ihr Zusammenwirken eröffnet einen konsistenten funktionalen Dynamikraum.',
    based_on_axioms = 'A1,A2,A3,A4,A5,A6,A7',
    status = 'accepted',
    created_revision_id = @revision_3391
WHERE proposition_number = '3.3.8';

SET @prop_338_id :=
(
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.8'
    LIMIT 1
);

SET @axiom_a1_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A1' LIMIT 1);
SET @axiom_a2_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A2' LIMIT 1);
SET @axiom_a3_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A3' LIMIT 1);
SET @axiom_a4_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A4' LIMIT 1);
SET @axiom_a5_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A5' LIMIT 1);
SET @axiom_a6_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A6' LIMIT 1);
SET @axiom_a7_id := (SELECT axiom_id FROM axioms WHERE axiom_number = 'A7' LIMIT 1);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_338_id, a.axiom_id, NULL, 'derived_from',
       CONCAT('Proposition 3.3.8 wird aus ', a.axiom_number, ' als Bestandteil des vollständigen Axiomensystems abgeleitet.')
FROM axioms a
WHERE @prop_338_id IS NOT NULL
  AND a.axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
  AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies pd
    WHERE pd.proposition_id = @prop_338_id
      AND pd.axiom_id = a.axiom_id
      AND pd.assumption_id IS NULL
      AND pd.dependency_type = 'derived_from'
);

/* Symbolregistrierung */

SET @eq_3486 := (SELECT equation_id FROM equations WHERE equation_number = '3.486' LIMIT 1);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id, unit_text,
    domain_text, codomain_text, is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\mathfrak{D}_F',
    '\mathfrak{D}_F',
    'Funktionaler Dynamikraum',
    'Theoretischer Möglichkeitsraum, in dem funktionale Zustände, Operationen und zulässige Übergänge gemeinsam beschrieben werden.',
    'chapter',
    @section_3391_id,
    @eq_3486,
    NULL,
    NULL,
    NULL,
    0,
    0,
    0,
    'In Abschnitt 3.3.9.1 durch Proposition 3.3.8 eingeführt.',
    'checked',
    @revision_3391
WHERE @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\mathfrak{D}_F'
      AND scope_type = 'chapter'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    @eq_3486,
    '\mathfrak{D}_F',
    'Funktionaler Dynamikraum',
    'Durch die Axiome A1 bis A7 eröffneter theoretischer Raum funktionaler Zustände und Übergänge.',
    NULL,
    NULL,
    1
WHERE @eq_3486 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equation_symbols
    WHERE equation_id = @eq_3486
      AND symbol_latex = '\mathfrak{D}_F'
);

/* Änderungsprotokoll */

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_3391,
    @section_3391_id,
    'created',
    'section',
    '3.3.9.1',
    'Abschnitt 3.3.9.1 vollständig angelegt.',
    NULL,
    'Möglichkeit funktionaler Dynamik'
WHERE @revision_3391 IS NOT NULL
  AND @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3391
      AND object_type = 'section'
      AND object_reference = '3.3.9.1'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_3391,
    @section_3391_id,
    'proposition_added',
    'proposition',
    '3.3.8',
    'Proposition 3.3.8 registriert.',
    NULL,
    'Existenz eines funktionalen Dynamikraums'
WHERE @revision_3391 IS NOT NULL
  AND @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3391
      AND object_type = 'proposition'
      AND object_reference = '3.3.8'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT
    @revision_3391,
    @section_3391_id,
    'equation_added',
    'equation',
    '(3.486)–(3.491)',
    'Sechs Gleichungen zum funktionalen Dynamikraum registriert.',
    NULL,
    'Gleichungen (3.486) bis (3.491)'
WHERE @revision_3391 IS NOT NULL
  AND @section_3391_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_3391
      AND object_type = 'equation'
      AND object_reference = '(3.486)–(3.491)'
);

/* Validierungen */

SET @equation_count_3391 :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE equation_number IN ('3.486','3.487','3.488','3.489','3.490','3.491')
);

SET @dependency_count_3391 :=
(
    SELECT COUNT(*)
    FROM proposition_dependencies
    WHERE proposition_id = @prop_338_id
      AND dependency_type = 'derived_from'
      AND axiom_id IN
      (
          @axiom_a1_id, @axiom_a2_id, @axiom_a3_id, @axiom_a4_id,
          @axiom_a5_id, @axiom_a6_id, @axiom_a7_id
      )
);

SET @symbol_count_3391 :=
(
    SELECT COUNT(*)
    FROM symbols
    WHERE symbol_latex = '\mathfrak{D}_F'
      AND scope_type = 'chapter'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3391,
    'K3.3.9.1.PARENT_REVISION',
    CASE WHEN @parent_revision_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    'RKB-NEU-K3.3.8-V1',
    CASE WHEN @parent_revision_id IS NOT NULL THEN 'RKB-NEU-K3.3.8-V1' ELSE 'missing' END,
    'Prüfung der Elternrevision.'
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3391
      AND validation_code = 'K3.3.9.1.PARENT_REVISION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3391,
    'K3.3.9.1.SECTION',
    CASE WHEN @section_3391_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_3391_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung von Abschnitt 3.3.9.1.'
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3391
      AND validation_code = 'K3.3.9.1.SECTION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3391,
    'K3.3.9.1.PROPOSITION',
    CASE WHEN @prop_338_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @prop_338_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung von Proposition 3.3.8.'
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3391
      AND validation_code = 'K3.3.9.1.PROPOSITION'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3391,
    'K3.3.9.1.EQUATIONS',
    CASE WHEN @equation_count_3391 = 6 THEN 'passed' ELSE 'failed' END,
    '6',
    CONCAT(@equation_count_3391, ''),
    'Prüfung der Gleichungen (3.486) bis (3.491).'
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3391
      AND validation_code = 'K3.3.9.1.EQUATIONS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3391,
    'K3.3.9.1.AXIOM_DEPENDENCIES',
    CASE WHEN @dependency_count_3391 = 7 THEN 'passed' ELSE 'failed' END,
    '7',
    CONCAT(@dependency_count_3391, ''),
    'Prüfung der Abhängigkeiten von A1 bis A7.'
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3391
      AND validation_code = 'K3.3.9.1.AXIOM_DEPENDENCIES'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_3391,
    'K3.3.9.1.SYMBOL',
    CASE WHEN @symbol_count_3391 = 1 THEN 'passed' ELSE 'failed' END,
    '1',
    CONCAT(@symbol_count_3391, ''),
    'Prüfung des Symbols des funktionalen Dynamikraums.'
WHERE @revision_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id = @revision_3391
      AND validation_code = 'K3.3.9.1.SYMBOL'
);

COMMIT;

/* Abschlusskontrollen */

SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.8-V1 fehlt.'
        WHEN @section_339_id IS NULL
            THEN 'FEHLER: Übergeordneter Abschnitt 3.3.9 fehlt.'
        WHEN @revision_3391 IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.3.9.1-V1 fehlt.'
        WHEN @section_3391_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.9.1 fehlt.'
        WHEN @prop_338_id IS NULL
            THEN 'FEHLER: Proposition 3.3.8 fehlt.'
        WHEN @equation_count_3391 <> 6
            THEN CONCAT('FEHLER: ', @equation_count_3391, ' statt 6 Gleichungen gefunden.')
        WHEN @dependency_count_3391 <> 7
            THEN CONCAT('FEHLER: ', @dependency_count_3391, ' statt 7 Axiomabhängigkeiten gefunden.')
        WHEN @symbol_count_3391 <> 1
            THEN CONCAT('FEHLER: ', @symbol_count_3391, ' statt 1 Dynamikraumsymbol gefunden.')
        ELSE 'OK: Repository-Update 3.3.9.1 vollständig ausgeführt.'
    END AS import_status;

SELECT
    rr.revision_id,
    rr.revision_code,
    rr.parent_revision_id,
    ds.section_id,
    ds.section_code,
    ds.title,
    ds.status,
    @equation_count_3391 AS equation_count,
    @dependency_count_3391 AS axiom_dependency_count
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code = rr.scope_reference
WHERE rr.revision_code = 'RKB-NEU-K3.3.9.1-V1';

SELECT
    proposition_number,
    title,
    based_on_axioms,
    status,
    created_revision_id
FROM propositions
WHERE proposition_number = '3.3.8';

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE equation_number IN ('3.486','3.487','3.488','3.489','3.490','3.491')
ORDER BY equation_number;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id = @revision_3391
ORDER BY validation_code;
