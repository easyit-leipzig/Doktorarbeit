/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.6
   Axiom A5 – Funktionale Kohärenz

   Voraussetzung:
     - Abschnitt 3.3.5 und Revision RKB-NEU-K3.3.5-V1 sind vorhanden.
     - Gleichungsnummerierung reicht bis (3.411).
     - Literaturzählung bleibt bei [108].

   Inhalt:
     - Revision RKB-NEU-K3.3.6-V1
     - Abschnitt 3.3.6
     - Axiom A5
     - Proposition 3.3.5
     - Gleichungen (3.412)–(3.431)
     - Axiom- und Proposition-Abhängigkeiten
     - Symbole und Gleichungssymbole
     - Änderungsprotokoll
     - Repository-Validierungen
     - Abschluss- und Kontrollabfragen

   Das Skript ist idempotent.
   ============================================================================ */

START TRANSACTION;

/* --------------------------------------------------------------------------
   1. Voraussetzungen und Revision
   -------------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.5-V1'
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
    'RKB-NEU-K3.3.6-V1',
    NOW(),
    'section',
    '3.3.6',
    '1.0',
    'Abschnitt 3.3.6: Axiom A5 der funktionalen Kohärenz, Proposition 3.3.5 und Gleichungen (3.412) bis (3.431).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.6-V1'
);

SET @revision_336 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.6-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   2. Abschnitt 3.3.6
   -------------------------------------------------------------------------- */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no, section_order,
    status, is_original_contribution, notes
)
SELECT
    @section_33_id,
    '3.3.6',
    'Axiom A5 – Funktionale Kohärenz',
    3,
    3.3060,
    'final',
    1,
    'Einführung funktionaler Kohärenz, lokaler und globaler Kohärenz, gewichteter Aggregation, relationaler Dichte, Transformationseffekten und kritischem Kohärenzwert.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.6'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_33_id,
    title = 'Axiom A5 – Funktionale Kohärenz',
    chapter_no = 3,
    section_order = 3.3060,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Einführung funktionaler Kohärenz, lokaler und globaler Kohärenz, gewichteter Aggregation, relationaler Dichte, Transformationseffekten und kritischem Kohärenzwert.'
WHERE section_code = '3.3.6';

SET @section_336_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.6'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   3. Axiom A5
   -------------------------------------------------------------------------- */

INSERT INTO axioms
(
    axiom_number, section_id, title, axiom_text,
    formal_latex, word_latex, motivation,
    independence_note, consistency_note, operationalization_note,
    source_assumption_id, status, created_revision_id
)
SELECT
    'A5',
    @section_336_id,
    'Funktionale Kohärenz',
    'Eine funktionale Organisation besteht genau dann fort, wenn ihre unterscheidbaren Gehalte, Relationen und Transformationen einen hinreichenden gemeinsamen funktionalen Zusammenhang bilden.',
    'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}',
    'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}',
    'Kompatibilität allein erklärt noch nicht, weshalb funktionale Organisationen über Transformationsfolgen hinweg stabil bleiben. Axiom A5 führt daher einen messbaren gemeinsamen funktionalen Zusammenhang als Fortbestandsbedingung ein.',
    'Axiom A5 ist nicht aus Axiom A4 ableitbar. Axiom A4 sichert Rekonstruierbarkeit, aber nicht den Grad des inneren funktionalen Zusammenhangs.',
    'Das Axiom ist mit A1 bis A4 vereinbar, weil Kohärenz weder Identität noch Unveränderlichkeit verlangt. Lokale Veränderungen und begrenzte Kohärenzverluste bleiben zulässig.',
    'Operationalisierung über die Kohärenzabbildung C_F, lokale Teilkohärenzen, funktionale Gewichte, relationale Dichte, Kohärenzänderungen und den kritischen Kohärenzwert C_krit.',
    NULL,
    'accepted',
    @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM axioms
    WHERE axiom_number = 'A5'
);

UPDATE axioms
SET
    section_id = @section_336_id,
    title = 'Funktionale Kohärenz',
    axiom_text = 'Eine funktionale Organisation besteht genau dann fort, wenn ihre unterscheidbaren Gehalte, Relationen und Transformationen einen hinreichenden gemeinsamen funktionalen Zusammenhang bilden.',
    formal_latex = 'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}',
    word_latex = 'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}',
    motivation = 'Kompatibilität allein erklärt noch nicht, weshalb funktionale Organisationen über Transformationsfolgen hinweg stabil bleiben. Axiom A5 führt daher einen messbaren gemeinsamen funktionalen Zusammenhang als Fortbestandsbedingung ein.',
    independence_note = 'Axiom A5 ist nicht aus Axiom A4 ableitbar. Axiom A4 sichert Rekonstruierbarkeit, aber nicht den Grad des inneren funktionalen Zusammenhangs.',
    consistency_note = 'Das Axiom ist mit A1 bis A4 vereinbar, weil Kohärenz weder Identität noch Unveränderlichkeit verlangt. Lokale Veränderungen und begrenzte Kohärenzverluste bleiben zulässig.',
    operationalization_note = 'Operationalisierung über die Kohärenzabbildung C_F, lokale Teilkohärenzen, funktionale Gewichte, relationale Dichte, Kohärenzänderungen und den kritischen Kohärenzwert C_krit.',
    status = 'accepted',
    created_revision_id = @revision_336
WHERE axiom_number = 'A5'
  AND @section_336_id IS NOT NULL;

SET @axiom_a1_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A1' LIMIT 1);
SET @axiom_a2_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A2' LIMIT 1);
SET @axiom_a3_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A3' LIMIT 1);
SET @axiom_a4_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A4' LIMIT 1);
SET @axiom_a5_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A5' LIMIT 1);

INSERT INTO axiom_dependencies
(axiom_id, depends_on_axiom_id, dependency_type, note)
SELECT
    @axiom_a5_id,
    @axiom_a4_id,
    'extends',
    'Axiom A5 erweitert funktionale Rekonstruierbarkeit um einen hinreichenden Grad gemeinsamen funktionalen Zusammenhangs.'
WHERE @axiom_a5_id IS NOT NULL
  AND @axiom_a4_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM axiom_dependencies
    WHERE axiom_id=@axiom_a5_id
      AND depends_on_axiom_id=@axiom_a4_id
      AND dependency_type='extends'
);

/* --------------------------------------------------------------------------
   4. Gleichungen (3.412)–(3.431)
   -------------------------------------------------------------------------- */

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.412', @section_336_id, 'Erweiterte funktionale Organisation',
       '\\mathcal{S}=(\\mathcal{F},\\mathcal{R}_F,\\mathcal{O}_F)',
       '\\mathcal{S}=(\\mathcal{F},\\mathcal{R}_F,\\mathcal{O}_F)',
       'Die funktionale Organisation umfasst funktionale Gehalte, Relationen und Operationen.',
       'definition', 'original', NULL,
       'Erweiterung der Organisationsdefinition aus Abschnitt 3.3.5 um funktionale Operationen.',
       'Axiome A1 bis A3.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.412');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.413', @section_336_id, 'Funktionale Kohärenzabbildung',
       'C_F:\\mathcal{S}\\rightarrow[0,1]',
       'C_F:\\mathcal{S}\\rightarrow[0,1]',
       'Die Kohärenzabbildung ordnet jeder funktionalen Organisation einen normierten Kohärenzwert zu.',
       'definition', 'original', NULL,
       'Quantitative Formalisierung funktionalen Zusammenhangs.',
       'Die funktionale Organisation ist definiert.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.413');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.414', @section_336_id, 'Vollständige funktionale Kohärenz',
       'C_F(\\mathcal{S})=1',
       'C_F(\\mathcal{S})=1',
       'Der Kohärenzwert eins bezeichnet vollständige funktionale Kohärenz.',
       'definition', 'original', NULL,
       'Oberer Grenzfall der Kohärenzabbildung.',
       'Gleichung (3.413).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.414');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.415', @section_336_id, 'Vollständiger Kohärenzverlust',
       'C_F(\\mathcal{S})=0',
       'C_F(\\mathcal{S})=0',
       'Der Kohärenzwert null bezeichnet den vollständigen Verlust funktionalen Zusammenhangs.',
       'definition', 'original', NULL,
       'Unterer Grenzfall der Kohärenzabbildung.',
       'Gleichung (3.413).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.415');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.416', @section_336_id, 'Funktionale Teilorganisation',
       '\\mathcal{S}_i\\subseteq\\mathcal{S}',
       '\\mathcal{S}_i\\subseteq\\mathcal{S}',
       'Eine lokale funktionale Teilorganisation ist Teil der Gesamtorganisation.',
       'definition', 'original', NULL,
       'Einführung lokaler Organisationseinheiten.',
       'Die Gesamtorganisation S ist definiert.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.416');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.417', @section_336_id, 'Lokale funktionale Kohärenz',
       'C_F(\\mathcal{S}_i)\\in[0,1]',
       'C_F(\\mathcal{S}_i)\\in[0,1]',
       'Jeder Teilorganisation wird ein lokaler Kohärenzwert zugeordnet.',
       'definition', 'original', NULL,
       'Anwendung der Kohärenzabbildung auf Teilorganisationen.',
       'Gleichungen (3.413) und (3.416).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.417');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.418', @section_336_id, 'Normierte funktionale Gewichte',
       'w_i\\geq0\\qquad\\text{und}\\qquad\\sum_{i=1}^{n}w_i=1',
       'w_i\\geq0\\qquad\\text{und}\\qquad\\sum_{i=1}^{n}w_i=1',
       'Die Gewichte lokaler Teilorganisationen sind nichtnegativ und summieren sich zu eins.',
       'definition', 'original', NULL,
       'Normierungsbedingung für die gewichtete globale Kohärenz.',
       'Es existieren n Teilorganisationen.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.418');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.419', @section_336_id, 'Gewichtete globale Kohärenz',
       'C_F(\\mathcal{S})=\\sum_{i=1}^{n}w_iC_F(\\mathcal{S}_i)',
       'C_F(\\mathcal{S})=\\sum_{i=1}^{n}w_iC_F(\\mathcal{S}_i)',
       'Die globale Kohärenz wird als gewichtete Summe lokaler Kohärenzen operationalisiert.',
       'model', 'original', NULL,
       'Erste lineare Operationalisierung globaler Kohärenz.',
       'Gleichungen (3.417) und (3.418).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.419');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.420', @section_336_id, 'Normierte relationale Dichte',
       'D_R(\\mathcal{S})=\\frac{|\\mathcal{R}_F|}{|\\mathcal{F}|\\,(|\\mathcal{F}|-1)}',
       'D_R(\\mathcal{S})=\\frac{|\\mathcal{R}_F|}{|\\mathcal{F}|\\,(|\\mathcal{F}|-1)}',
       'Normierte Dichte einer gerichteten funktionalen Organisation ohne Selbstrelationen.',
       'definition', 'adapted', NULL,
       'Übertragung der üblichen gerichteten Graphdichte auf funktionale Relationen.',
       '|F| ist größer als eins; Selbstrelationen werden nicht gezählt.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.420');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.421', @section_336_id, 'Nichtimplikation zwischen Dichte und Kohärenz',
       'D_R(\\mathcal{S})\\uparrow\\not\\Rightarrow C_F(\\mathcal{S})\\uparrow',
       'D_R(\\mathcal{S})\\uparrow\\not\\Rightarrow C_F(\\mathcal{S})\\uparrow',
       'Eine steigende relationale Dichte impliziert keine steigende funktionale Kohärenz.',
       'proposition', 'original', NULL,
       'Begriffliche Trennung von Relationsanzahl und funktionalem Zusammenhang.',
       'Gleichungen (3.413) und (3.420).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.421');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.422', @section_336_id, 'Transformierte Organisation',
       '\\mathcal{S}^{\\prime}=O_F(\\mathcal{S})',
       '\\mathcal{S}^{\\prime}=O_F(\\mathcal{S})',
       'Die transformierte Organisation entsteht durch Anwendung einer funktionalen Operation.',
       'model', 'original', NULL,
       'Übernahme der Transformationslogik aus Axiom A3.',
       'Axiom A3.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.422');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.423', @section_336_id, 'Kohärenzerhaltende Transformation',
       'C_F(\\mathcal{S}^{\\prime})\\geq C_F(\\mathcal{S})-\\varepsilon',
       'C_F(\\mathcal{S}^{\\prime})\\geq C_F(\\mathcal{S})-\\varepsilon',
       'Eine Transformation gilt innerhalb der Toleranz epsilon als kohärenzerhaltend.',
       'definition', 'original', NULL,
       'Einführung einer toleranzbehafteten Erhaltungsbedingung.',
       '\\varepsilon\\geq0.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.423');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.424', @section_336_id, 'Kohärenzsteigernde Transformation',
       'C_F(\\mathcal{S}^{\\prime})>C_F(\\mathcal{S})',
       'C_F(\\mathcal{S}^{\\prime})>C_F(\\mathcal{S})',
       'Die Transformation erhöht den funktionalen Kohärenzwert.',
       'definition', 'original', NULL,
       'Vergleich von Ausgangs- und Folgekohärenz.',
       'Gleichung (3.422).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.424');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.425', @section_336_id, 'Kohärenzmindernde Transformation',
       'C_F(\\mathcal{S}^{\\prime})<C_F(\\mathcal{S})',
       'C_F(\\mathcal{S}^{\\prime})<C_F(\\mathcal{S})',
       'Die Transformation vermindert den funktionalen Kohärenzwert.',
       'definition', 'original', NULL,
       'Vergleich von Ausgangs- und Folgekohärenz.',
       'Gleichung (3.422).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.425');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.426', @section_336_id, 'Kritischer Kohärenzwert',
       'C_{\\mathrm{krit}}\\in[0,1]',
       'C_{\\mathrm{krit}}\\in[0,1]',
       'Der kritische Kohärenzwert markiert die Mindestkohärenz hinreichender funktionaler Fortsetzbarkeit.',
       'definition', 'original', NULL,
       'Einführung einer Schwelle zwischen hinreichender und unzureichender Kohärenz.',
       'Die Kohärenzabbildung ist normiert.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.426');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.427', @section_336_id, 'Hinreichend kohärente Organisation',
       'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}',
       'C_F(\\mathcal{S})\\geq C_{\\mathrm{krit}}',
       'Die Organisation liegt oberhalb oder auf dem kritischen Kohärenzwert.',
       'axiom', 'original', NULL,
       'Formale Fortbestandsbedingung von Axiom A5.',
       'Axiom A5.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.427');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.428', @section_336_id, 'Unterschreitung des kritischen Kohärenzwertes',
       'C_F(\\mathcal{S})<C_{\\mathrm{krit}}',
       'C_F(\\mathcal{S})<C_{\\mathrm{krit}}',
       'Die Organisation unterschreitet die Mindestkohärenz hinreichender funktionaler Fortsetzbarkeit.',
       'definition', 'original', NULL,
       'Komplementärer Fall zu Gleichung (3.427).',
       'Gleichung (3.426).', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.428');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.429', @section_336_id, 'Folge funktionaler Organisationen',
       '\\mathcal{S}_0,\\mathcal{S}_1,\\dots,\\mathcal{S}_n',
       '\\mathcal{S}_0,\\mathcal{S}_1,\\dots,\\mathcal{S}_n',
       'Die Organisationen bilden einen geordneten funktionalen Transformationspfad.',
       'definition', 'original', NULL,
       'Ausgangspunkt der Proposition 3.3.5.',
       'Die funktionale Organisation ist definiert.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.429');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.430', @section_336_id, 'Rekursive Transformation des Organisationspfades',
       '\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)',
       '\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)',
       'Jede Folgeorganisation entsteht durch Anwendung einer funktionalen Operation.',
       'model', 'original', NULL,
       'Rekursive Konstruktion der Organisationsfolge.',
       'Axiom A3.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.430');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.431', @section_336_id, 'Kohärenzbedingung des Organisationspfades',
       'C_F(\\mathcal{S}_i)\\geq C_{\\mathrm{krit}}\\qquad\\forall i',
       'C_F(\\mathcal{S}_i)\\geq C_{\\mathrm{krit}}\\qquad\\forall i',
       'Alle Zustände des Organisationspfades bleiben oberhalb des kritischen Kohärenzwertes.',
       'theorem', 'original', NULL,
       'Formale Bedingung der Proposition 3.3.5.',
       'Axiome A4 und A5.', 'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.431');

/* Gleichungs-IDs */
SET @eq_3412 := (SELECT equation_id FROM equations WHERE equation_number='3.412' LIMIT 1);
SET @eq_3413 := (SELECT equation_id FROM equations WHERE equation_number='3.413' LIMIT 1);
SET @eq_3416 := (SELECT equation_id FROM equations WHERE equation_number='3.416' LIMIT 1);
SET @eq_3418 := (SELECT equation_id FROM equations WHERE equation_number='3.418' LIMIT 1);
SET @eq_3420 := (SELECT equation_id FROM equations WHERE equation_number='3.420' LIMIT 1);
SET @eq_3422 := (SELECT equation_id FROM equations WHERE equation_number='3.422' LIMIT 1);
SET @eq_3423 := (SELECT equation_id FROM equations WHERE equation_number='3.423' LIMIT 1);
SET @eq_3426 := (SELECT equation_id FROM equations WHERE equation_number='3.426' LIMIT 1);
SET @eq_3429 := (SELECT equation_id FROM equations WHERE equation_number='3.429' LIMIT 1);
SET @eq_3431 := (SELECT equation_id FROM equations WHERE equation_number='3.431' LIMIT 1);

/* --------------------------------------------------------------------------
   5. Proposition 3.3.5
   -------------------------------------------------------------------------- */

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.5',
    @section_336_id,
    'Kohärenz begrenzt den funktionalen Zerfall',
    'Sei S_0 bis S_n eine Folge funktionaler Organisationen mit S_i+1 gleich O_F,i von S_i. Gilt für alle Folgezustände C_F von S_i größer oder gleich C_krit, so bleibt die funktionale Organisation entlang des betrachteten Transformationspfades hinreichend zusammenhängend und rekonstruierbar.',
    '\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land C_F(\\mathcal{S}_i)\\geq C_{\\mathrm{krit}}\\;\\forall i\\Longrightarrow\\mathcal{S}_n\\text{ bleibt hinreichend kohärent und rekonstruierbar}',
    '\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land C_F(\\mathcal{S}_i)\\geq C_{\\mathrm{krit}}\\;\\forall i\\Longrightarrow\\mathcal{S}_n\\text{ bleibt hinreichend kohärent und rekonstruierbar}',
    'Axiom A4 sichert die grundsätzliche Rekonstruierbarkeit kompatibler Transformationspfade. Axiom A5 fordert zusätzlich, dass der funktionale Zusammenhang jedes Zustands oberhalb des kritischen Mindestwertes bleibt. Solange beide Bedingungen erfüllt sind, wird der funktionale Zerfall begrenzt.',
    'A1,A2,A3,A4,A5',
    'accepted',
    @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM propositions
    WHERE proposition_number='3.3.5'
);

UPDATE propositions
SET
    section_id=@section_336_id,
    title='Kohärenz begrenzt den funktionalen Zerfall',
    statement_text='Sei S_0 bis S_n eine Folge funktionaler Organisationen mit S_i+1 gleich O_F,i von S_i. Gilt für alle Folgezustände C_F von S_i größer oder gleich C_krit, so bleibt die funktionale Organisation entlang des betrachteten Transformationspfades hinreichend zusammenhängend und rekonstruierbar.',
    statement_latex='\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land C_F(\\mathcal{S}_i)\\geq C_{\\mathrm{krit}}\\;\\forall i\\Longrightarrow\\mathcal{S}_n\\text{ bleibt hinreichend kohärent und rekonstruierbar}',
    word_latex='\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land C_F(\\mathcal{S}_i)\\geq C_{\\mathrm{krit}}\\;\\forall i\\Longrightarrow\\mathcal{S}_n\\text{ bleibt hinreichend kohärent und rekonstruierbar}',
    logical_derivation='Axiom A4 sichert die grundsätzliche Rekonstruierbarkeit kompatibler Transformationspfade. Axiom A5 fordert zusätzlich, dass der funktionale Zusammenhang jedes Zustands oberhalb des kritischen Mindestwertes bleibt. Solange beide Bedingungen erfüllt sind, wird der funktionale Zerfall begrenzt.',
    based_on_axioms='A1,A2,A3,A4,A5',
    status='accepted',
    created_revision_id=@revision_336
WHERE proposition_number='3.3.5'
  AND @section_336_id IS NOT NULL;

SET @prop_335_id :=
(
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number='3.3.5'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_335_id, @axiom_a4_id, NULL, 'uses',
       'Die Proposition setzt die Rekonstruierbarkeit kompatibler Organisationspfade voraus.'
WHERE @prop_335_id IS NOT NULL
  AND @axiom_a4_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_335_id
      AND axiom_id=@axiom_a4_id
      AND dependency_type='uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_335_id, @axiom_a5_id, NULL, 'derived_from',
       'Die Begrenzung funktionalen Zerfalls folgt aus der fortlaufenden Einhaltung der Kohärenzschwelle.'
WHERE @prop_335_id IS NOT NULL
  AND @axiom_a5_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_335_id
      AND axiom_id=@axiom_a5_id
      AND dependency_type='derived_from'
);

/* --------------------------------------------------------------------------
   6. Symbole
   -------------------------------------------------------------------------- */

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT '\\mathcal{S}', '\\mathcal{S}', 'erweiterte funktionale Organisation',
       'Geordnetes Tripel aus funktionalem Trägerbereich, funktionaler Relationsmenge und funktionaler Operationsmenge.',
       'chapter', @section_336_id, @eq_3412,
       NULL, NULL, NULL, 0, 0, 0,
       'Erweiterte Organisationsdefinition aus Abschnitt 3.3.6.',
       'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\\mathcal{S}'
      AND symbol_name='erweiterte funktionale Organisation'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT 'C_F', 'C_F', 'funktionale Kohärenzabbildung',
       'Normierte Abbildung des funktionalen Zusammenhangs einer Organisation auf das Intervall null bis eins.',
       'chapter', @section_336_id, @eq_3413,
       NULL, '\\mathcal{S}', '[0,1]', 0, 0, 1,
       'Zentrales Kohärenzmaß des FRZK.',
       'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='C_F'
      AND symbol_name='funktionale Kohärenzabbildung'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT 'w_i', 'w_i', 'funktionales Gewicht',
       'Nichtnegatives normiertes Gewicht der i-ten lokalen Teilorganisation.',
       'section', @section_336_id, @eq_3418,
       NULL, NULL, '[0,1]', 0, 0, 0,
       'Gewichtung lokaler Kohärenzen.',
       'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='w_i'
      AND symbol_name='funktionales Gewicht'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT 'D_R', 'D_R', 'relationale Dichte',
       'Normierte Dichte gerichteter funktionaler Relationen ohne Selbstrelationen.',
       'chapter', @section_336_id, @eq_3420,
       NULL, '\\mathcal{S}', '[0,1]', 0, 0, 1,
       'Von funktionaler Kohärenz ausdrücklich zu unterscheiden.',
       'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='D_R'
      AND symbol_name='relationale Dichte'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT '\\varepsilon', '\\varepsilon', 'Kohärenztoleranz',
       'Nichtnegative Toleranz für begrenzte Kohärenzverluste unter Transformationen.',
       'section', @section_336_id, @eq_3423,
       NULL, NULL, '[0,1]', 0, 0, 0,
       'Erlaubt vorübergehende oder begrenzte Kohärenzverluste.',
       'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\\varepsilon'
      AND symbol_name='Kohärenztoleranz'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT 'C_{\\mathrm{krit}}', 'C_{\\mathrm{krit}}', 'kritischer Kohärenzwert',
       'Mindestwert hinreichender funktionaler Fortsetzbarkeit.',
       'chapter', @section_336_id, @eq_3426,
       NULL, NULL, '[0,1]', 0, 0, 0,
       'Schwelle für hinreichend kohärente funktionale Organisationen.',
       'checked', @revision_336
WHERE @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='C_{\\mathrm{krit}}'
);

/* --------------------------------------------------------------------------
   7. Gleichungssymbole
   -------------------------------------------------------------------------- */

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3412, '\\mathcal{S}', 'funktionale Organisation',
       'Tripel aus Gehalten, Relationen und Operationen.', NULL, NULL, 1
WHERE @eq_3412 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3412 AND symbol_latex='\\mathcal{S}'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3413, 'C_F', 'funktionale Kohärenzabbildung',
       'Normiertes Kohärenzmaß.', NULL, '\\mathcal{S}', 1
WHERE @eq_3413 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3413 AND symbol_latex='C_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3416, '\\mathcal{S}_i', 'funktionale Teilorganisation',
       'Lokale Teilstruktur der Gesamtorganisation.', NULL, NULL, 1
WHERE @eq_3416 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3416 AND symbol_latex='\\mathcal{S}_i'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3418, 'w_i', 'funktionales Gewicht',
       'Normiertes Gewicht einer lokalen Teilorganisation.', NULL, '[0,1]', 1
WHERE @eq_3418 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3418 AND symbol_latex='w_i'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3420, 'D_R', 'relationale Dichte',
       'Normierte Dichte gerichteter Relationen.', NULL, '\\mathcal{S}', 1
WHERE @eq_3420 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3420 AND symbol_latex='D_R'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3423, '\\varepsilon', 'Kohärenztoleranz',
       'Zulässiger begrenzter Kohärenzverlust.', NULL, '[0,1]', 1
WHERE @eq_3423 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3423 AND symbol_latex='\\varepsilon'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3426, 'C_{\\mathrm{krit}}', 'kritischer Kohärenzwert',
       'Schwelle hinreichender Kohärenz.', NULL, '[0,1]', 1
WHERE @eq_3426 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3426 AND symbol_latex='C_{\\mathrm{krit}}'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3431, '\\mathcal{S}_i', 'i-te funktionale Organisation',
       'Zustand innerhalb eines Transformationspfades.', NULL, NULL, 1
WHERE @eq_3431 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3431 AND symbol_latex='\\mathcal{S}_i'
);

/* --------------------------------------------------------------------------
   8. Änderungsprotokoll
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_336, @section_336_id, 'created', 'section', '3.3.6',
       'Abschnitt 3.3.6 vollständig angelegt und abgeschlossen.',
       NULL, 'Axiom A5 – Funktionale Kohärenz'
WHERE @revision_336 IS NOT NULL
  AND @section_336_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_336
      AND object_reference='3.3.6'
      AND change_type='created'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_336, @section_336_id, 'axiom_added', 'axiom', 'A5',
       'Axiom A5 der funktionalen Kohärenz registriert.',
       NULL, 'A5 – Funktionale Kohärenz'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_336
      AND object_reference='A5'
      AND object_type='axiom'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_336, @section_336_id, 'proposition_added', 'proposition', '3.3.5',
       'Proposition 3.3.5 zur Begrenzung funktionalen Zerfalls registriert.',
       NULL, 'Kohärenz begrenzt den funktionalen Zerfall'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_336
      AND object_reference='3.3.5'
      AND object_type='proposition'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_336, @section_336_id, 'equation_added', 'equation', '(3.412)–(3.431)',
       'Zwanzig Gleichungen zur funktionalen Kohärenz aufgenommen.',
       NULL, 'Gleichungen (3.412) bis (3.431)'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_336
      AND object_reference='(3.412)–(3.431)'
);

/* --------------------------------------------------------------------------
   9. Repository-Validierungen
   -------------------------------------------------------------------------- */

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_336,
    'K3.3.6.SECTION',
    CASE WHEN @section_336_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_336_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung, ob Abschnitt 3.3.6 vorhanden ist.'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_336
      AND validation_code='K3.3.6.SECTION'
);

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_336,
    'K3.3.6.EQUATIONS',
    CASE
      WHEN
      (
        SELECT COUNT(*)
        FROM equations
        WHERE equation_number IN
        (
          '3.412','3.413','3.414','3.415','3.416','3.417','3.418','3.419','3.420','3.421',
          '3.422','3.423','3.424','3.425','3.426','3.427','3.428','3.429','3.430','3.431'
        )
      ) = 20
      THEN 'passed' ELSE 'failed'
    END,
    '20',
    CONCAT
    (
      (
        SELECT COUNT(*)
        FROM equations
        WHERE equation_number IN
        (
          '3.412','3.413','3.414','3.415','3.416','3.417','3.418','3.419','3.420','3.421',
          '3.422','3.423','3.424','3.425','3.426','3.427','3.428','3.429','3.430','3.431'
        )
      ),
      ''
    ),
    'Prüfung der Gleichungen (3.412) bis (3.431).'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_336
      AND validation_code='K3.3.6.EQUATIONS'
);

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_336,
    'K3.3.6.AXIOM_A5',
    CASE WHEN @axiom_a5_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @axiom_a5_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung von Axiom A5.'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_336
      AND validation_code='K3.3.6.AXIOM_A5'
);

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_336,
    'K3.3.6.PROPOSITION',
    CASE WHEN @prop_335_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @prop_335_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung von Proposition 3.3.5.'
WHERE @revision_336 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_336
      AND validation_code='K3.3.6.PROPOSITION'
);

/* --------------------------------------------------------------------------
   10. Abschluss- und Kontrollabfragen
   -------------------------------------------------------------------------- */

SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Vorgängerrevision RKB-NEU-K3.3.5-V1 fehlt.'
        WHEN @section_33_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
        WHEN @revision_336 IS NULL
            THEN 'FEHLER: Revision 3.3.6 konnte nicht angelegt werden.'
        WHEN @section_336_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.6 konnte nicht angelegt werden.'
        WHEN @axiom_a5_id IS NULL
            THEN 'FEHLER: Axiom A5 konnte nicht angelegt oder aktualisiert werden.'
        WHEN @prop_335_id IS NULL
            THEN 'FEHLER: Proposition 3.3.5 konnte nicht angelegt werden.'
        ELSE 'OK: Repository-Update 3.3.6 vollständig ausgeführt.'
    END AS import_status;

SELECT
    rr.revision_code,
    rr.parent_revision_id,
    ds.section_code,
    ds.title,
    ds.status,
    (
        SELECT COUNT(*)
        FROM equations
        WHERE equation_number IN
        (
          '3.412','3.413','3.414','3.415','3.416','3.417','3.418','3.419','3.420','3.421',
          '3.422','3.423','3.424','3.425','3.426','3.427','3.428','3.429','3.430','3.431'
        )
    ) AS equation_count,
    (
        SELECT COUNT(*)
        FROM axioms
        WHERE axiom_number='A5'
          AND section_id=ds.section_id
    ) AS axiom_count,
    (
        SELECT COUNT(*)
        FROM propositions
        WHERE proposition_number='3.3.5'
          AND section_id=ds.section_id
    ) AS proposition_count
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code=rr.scope_reference
WHERE rr.revision_code='RKB-NEU-K3.3.6-V1';

SELECT equation_number, title, validation_status
FROM equations
WHERE equation_number IN
(
  '3.412','3.413','3.414','3.415','3.416','3.417','3.418','3.419','3.420','3.421',
  '3.422','3.423','3.424','3.425','3.426','3.427','3.428','3.429','3.430','3.431'
)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT axiom_number, section_id, title, status, created_revision_id
FROM axioms
WHERE axiom_number='A5';

SELECT proposition_number, section_id, title, based_on_axioms, status
FROM propositions
WHERE proposition_number='3.3.5';

SELECT validation_code, validation_status, expected_value,
       actual_value, validation_message
FROM repository_validation_results
WHERE revision_id=@revision_336
ORDER BY validation_code;

COMMIT;
