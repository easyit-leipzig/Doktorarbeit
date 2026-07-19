/* ============================================================================
   FRZK-RKB – Vollständiges Repository-Update Kapitel 3.3.3
   Axiom A2 – Funktionale Relationierbarkeit

   Voraussetzung:
     - Update 3.3.2 erfolgreich ausgeführt
     - Revision RKB-NEU-K3.3.2-V1 vorhanden
     - Gleichungen bis (3.373)
     - Literatur bis [106]
     - Newman ist bereits als Quelle [48] vorhanden

   Inhalt:
     - Abschnitt 3.3.3
     - neue Quelle Birkhoff [107]
     - Wiederverwendung Newman [48]
     - Axiom A2
     - Proposition 3.3.2
     - Gleichungen (3.374) bis (3.381)
     - globale Symbole und Gleichungssymbole
     - Quellenverwendungen und Objekt-Quellen-Verknüpfungen
     - Änderungsprotokoll und Validierungsabfragen

   Eigenschaften:
     - idempotent
     - Fremdschlüssel-IDs werden ausschließlich aus vorhandenen Datensätzen ermittelt
     - bestehendes älteres Axiom A2 wird auf die Neufassung aktualisiert
   ============================================================================ */

START TRANSACTION;

/* --------------------------------------------------------------------------
   0. Sicherheitsprüfung des vorausgesetzten Repository-Standes
   -------------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.2-V1'
    LIMIT 1
);

SET @section_33_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3'
    LIMIT 1
);

-- Bei fehlender Voraussetzung erzeugen die folgenden gezielten Prüfungen
-- absichtlich keine Kinddatensätze. Die Abschlussprüfung zeigt den Fehler.

/* --------------------------------------------------------------------------
   1. Neue Repository-Revision
   -------------------------------------------------------------------------- */

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.3-V1',
    NOW(),
    'section',
    '3.3.3',
    '1.0',
    'Abschluss von Abschnitt 3.3.3: Axiom A2 der funktionalen Relationierbarkeit, Proposition 3.3.2, Gleichungen (3.374) bis (3.381), neue Quelle Birkhoff [107] und Wiederverwendung Newman [48].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.3-V1'
);

SET @revision_333 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.3-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   2. Abschnitt 3.3.3
   -------------------------------------------------------------------------- */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no, section_order,
    status, is_original_contribution, notes
)
SELECT
    @section_33_id,
    '3.3.3',
    'Axiom A2 – Funktionale Relationierbarkeit',
    3,
    3.3030,
    'final',
    1,
    'Formulierung der Möglichkeit funktionaler Relationierung, Einführung der Relationsmenge, qualitativer und gewichteter Kopplung sowie Proposition zur Entstehung funktionaler Struktur.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.3'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_33_id,
    title = 'Axiom A2 – Funktionale Relationierbarkeit',
    chapter_no = 3,
    section_order = 3.3030,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Formulierung der Möglichkeit funktionaler Relationierung, Einführung der Relationsmenge, qualitativer und gewichteter Kopplung sowie Proposition zur Entstehung funktionaler Struktur.'
WHERE section_code = '3.3.3';

SET @section_333_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.3'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   3. Autoren und Literatur
   -------------------------------------------------------------------------- */

INSERT INTO authors
(
    family_name, given_names, normalized_name,
    birth_year, death_year, notes
)
SELECT
    'Birkhoff',
    'Garrett',
    'Birkhoff, Garrett',
    1911,
    1996,
    'Autor der in Abschnitt 3.3.3 neu aufgenommenen Quelle [107].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name = 'Birkhoff, Garrett'
);

SET @author_birkhoff :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Birkhoff, Garrett'
    LIMIT 1
);

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    107,
    'birkhoff_lattice_theory_1967',
    'book',
    'Lattice Theory',
    NULL,
    1940,
    1967,
    NULL,
    'American Mathematical Society',
    'Providence, Rhode Island',
    NULL,
    NULL,
    NULL,
    '3rd Edition',
    NULL,
    NULL,
    NULL,
    'en',
    3,
    'reference',
    6,
    'verified',
    '3.3.3',
    'Erstnennung zur mathematischen Bedeutung relationaler Strukturen, Ordnungen und Verbände.',
    'Birkhoff, Garrett (1967): Lattice Theory. 3rd Edition. Providence, Rhode Island: American Mathematical Society.',
    'Birkhoff (1967)',
    'Klassische Referenz für Ordnungs- und Verbandsstrukturen.',
    @revision_333
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 107
       OR source_key = 'birkhoff_lattice_theory_1967'
);

SET @source_birkhoff :=
(
    SELECT source_id
    FROM sources
    WHERE source_key = 'birkhoff_lattice_theory_1967'
    LIMIT 1
);

SET @source_newman :=
(
    SELECT source_id
    FROM sources
    WHERE source_key = 'newman_networks_2018'
    LIMIT 1
);

INSERT INTO source_authors
(source_id, author_id, author_order, role)
SELECT
    @source_birkhoff,
    @author_birkhoff,
    1,
    'author'
WHERE @source_birkhoff IS NOT NULL
  AND @author_birkhoff IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_authors
    WHERE source_id = @source_birkhoff
      AND author_id = @author_birkhoff
      AND role = 'author'
);

/* --------------------------------------------------------------------------
   4. Quellenverwendungen
   -------------------------------------------------------------------------- */

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_birkhoff,
    @section_333_id,
    'first_citation',
    'Relationen bilden die Grundlage mathematischer Ordnungs-, Äquivalenz- und Verbandsstrukturen.',
    'Abschnitt 3.3.3, wissenschaftliche Einordnung vor Axiom A2',
    1,
    1,
    'Erstnennung als neue Quelle [107].',
    @revision_333
WHERE @source_birkhoff IS NOT NULL
  AND @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id = @source_birkhoff
      AND section_id = @section_333_id
      AND exact_location = 'Abschnitt 3.3.3, wissenschaftliche Einordnung vor Axiom A2'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_newman,
    @section_333_id,
    'background',
    'Netzwerkstrukturen machen Relationen zu Trägern der Organisation und bestimmen die Einbettung einzelner Knoten.',
    'Abschnitt 3.3.3, wissenschaftliche Einordnung vor Axiom A2',
    0,
    1,
    'Bereits vorhandene Quelle [48]; keine neue Literaturzahl.',
    @revision_333
WHERE @source_newman IS NOT NULL
  AND @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id = @source_newman
      AND section_id = @section_333_id
      AND exact_location = 'Abschnitt 3.3.3, wissenschaftliche Einordnung vor Axiom A2'
);

/* --------------------------------------------------------------------------
   5. Axiom A2 – vorhandenen Altbestand auf Neufassung aktualisieren
   -------------------------------------------------------------------------- */

INSERT INTO axioms
(
    axiom_number, section_id, title, axiom_text,
    formal_latex, word_latex, motivation,
    independence_note, consistency_note, operationalization_note,
    source_assumption_id, status, created_revision_id
)
SELECT
    'A2',
    @section_333_id,
    'Funktionale Relationierbarkeit',
    'Zwischen funktional unterscheidbaren Gehalten können funktionale Relationen entstehen.',
    '\\delta_F(f_i,f_j)=1\\;\\Longrightarrow\\;\\Diamond\\bigl((f_i,f_j)\\in\\mathcal{R}_F\\bigr)',
    '\\delta_F(f_i,f_j)=1\\;\\Longrightarrow\\;\\Diamond\\bigl((f_i,f_j)\\in\\mathcal{R}_F\\bigr)',
    'Funktionale Differenz allein erzeugt noch keine Organisation. Erst die Möglichkeit einer Relation lässt funktionale Gehalte zu einer gemeinsamen Struktur werden.',
    'Axiom A2 setzt Relationierbarkeit als Möglichkeit und wird nicht aus Axiom A1 abgeleitet. Axiom A1 liefert lediglich die vorausgesetzte funktionale Unterscheidbarkeit.',
    'Die Setzung ist mit Axiom A1 vereinbar, weil nicht jede funktionale Differenz automatisch eine tatsächlich bestehende Relation erzeugt.',
    'Operationalisierbar über binäre Kopplungsindikatoren rho_F und spätere gewichtete Kopplungsmaße kappa_F.',
    NULL,
    'accepted',
    @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM axioms
    WHERE axiom_number = 'A2'
);

UPDATE axioms
SET
    section_id = @section_333_id,
    title = 'Funktionale Relationierbarkeit',
    axiom_text = 'Zwischen funktional unterscheidbaren Gehalten können funktionale Relationen entstehen.',
    formal_latex = '\\delta_F(f_i,f_j)=1\\;\\Longrightarrow\\;\\Diamond\\bigl((f_i,f_j)\\in\\mathcal{R}_F\\bigr)',
    word_latex = '\\delta_F(f_i,f_j)=1\\;\\Longrightarrow\\;\\Diamond\\bigl((f_i,f_j)\\in\\mathcal{R}_F\\bigr)',
    motivation = 'Funktionale Differenz allein erzeugt noch keine Organisation. Erst die Möglichkeit einer Relation lässt funktionale Gehalte zu einer gemeinsamen Struktur werden.',
    independence_note = 'Axiom A2 setzt Relationierbarkeit als Möglichkeit und wird nicht aus Axiom A1 abgeleitet. Axiom A1 liefert lediglich die vorausgesetzte funktionale Unterscheidbarkeit.',
    consistency_note = 'Die Setzung ist mit Axiom A1 vereinbar, weil nicht jede funktionale Differenz automatisch eine tatsächlich bestehende Relation erzeugt.',
    operationalization_note = 'Operationalisierbar über binäre Kopplungsindikatoren rho_F und spätere gewichtete Kopplungsmaße kappa_F.',
    status = 'accepted',
    created_revision_id = @revision_333
WHERE axiom_number = 'A2'
  AND @section_333_id IS NOT NULL;

SET @axiom_a1_id :=
(
    SELECT axiom_id
    FROM axioms
    WHERE axiom_number = 'A1'
    LIMIT 1
);

SET @axiom_a2_id :=
(
    SELECT axiom_id
    FROM axioms
    WHERE axiom_number = 'A2'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   6. Gleichungen (3.374) bis (3.381)
   -------------------------------------------------------------------------- */

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.374', @section_333_id, 'Menge funktionaler Relationen',
    '\\mathcal{R}_F\\subseteq\\mathcal{F}\\times\\mathcal{F}',
    '\\mathcal{R}_F\\subseteq\\mathcal{F}\\times\\mathcal{F}',
    'Die Menge funktionaler Relationen ist eine Teilmenge des kartesischen Produkts des funktionalen Trägerbereichs mit sich selbst.',
    'definition', 'original', NULL,
    'Formale Einführung der Relationsmenge auf Grundlage von Axiom A2.',
    'Der funktionale Trägerbereich F ist in Abschnitt 3.3.1 eingeführt.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.374');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.375', @section_333_id, 'Bestehende funktionale Relation',
    '(f_i,f_j)\\in\\mathcal{R}_F',
    '(f_i,f_j)\\in\\mathcal{R}_F',
    'Zwischen den funktionalen Gehalten f_i und f_j besteht eine funktionale Relation.',
    'definition', 'original', NULL,
    'Elementschreibweise der in Gleichung (3.374) eingeführten Relationsmenge.',
    'Die Relationsmenge R_F ist definiert.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.375');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.376', @section_333_id, 'Unterscheidbarkeit relational gekoppelter Gehalte',
    '(f_i,f_j)\\in\\mathcal{R}_F\\Longrightarrow\\delta_F(f_i,f_j)=1',
    '(f_i,f_j)\\in\\mathcal{R}_F\\Longrightarrow\\delta_F(f_i,f_j)=1',
    'Eine funktionale Relation setzt im Modell funktional unterscheidbare Gehalte voraus.',
    'axiom', 'original', NULL,
    'Formale Präzisierung der Bindung von Axiom A2 an Axiom A1.',
    'Axiom A1 und die Unterscheidungsfunktion delta_F gelten.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.376');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.377', @section_333_id, 'Unterscheidbarkeit ist nicht hinreichend für Relation',
    '\\delta_F(f_i,f_j)=1\\;\\not\\Rightarrow\\;(f_i,f_j)\\in\\mathcal{R}_F',
    '\\delta_F(f_i,f_j)=1\\;\\not\\Rightarrow\\;(f_i,f_j)\\in\\mathcal{R}_F',
    'Aus funktionaler Unterscheidbarkeit folgt nicht automatisch eine tatsächlich bestehende Relation.',
    'derived', 'original', NULL,
    'Abgrenzung der Möglichkeit funktionaler Relationierung von einer vollständigen Kopplung aller unterscheidbaren Gehalte.',
    'Axiom A2 ist als Möglichkeitsaussage formuliert.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.377');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.378', @section_333_id, 'Qualitative Kopplungsfunktion',
    '\\rho_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}',
    '\\rho_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}',
    'Die qualitative Kopplungsfunktion bildet Paare funktionaler Gehalte auf das Bestehen oder Nichtbestehen einer Relation ab.',
    'definition', 'original', NULL,
    'Einführung eines binären Indikators für funktionale Relationen.',
    'Der funktionale Trägerbereich F und die Relationsmenge R_F sind definiert.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.378');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.379', @section_333_id, 'Fallunterscheidung der qualitativen Kopplung',
    '\\rho_F(f_i,f_j)=\\begin{cases}1,&(f_i,f_j)\\in\\mathcal{R}_F,\\\\0,&(f_i,f_j)\\notin\\mathcal{R}_F.\\end{cases}',
    '\\rho_F(f_i,f_j)=\\begin{cases}1,&(f_i,f_j)\\in\\mathcal{R}_F,\\\\0,&(f_i,f_j)\\notin\\mathcal{R}_F.\\end{cases}',
    'Die Kopplungsfunktion besitzt den Wert eins bei bestehender und null bei nicht bestehender funktionaler Relation.',
    'definition', 'original', NULL,
    'Explizite Definition der in Gleichung (3.378) eingeführten Kopplungsfunktion.',
    'Die Relationsmenge R_F ist definiert.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.379');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.380', @section_333_id, 'Gewichtete funktionale Kopplung',
    '\\kappa_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\mathbb{R}_{\\geq 0}',
    '\\kappa_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\mathbb{R}_{\\geq 0}',
    'Die gewichtete Kopplungsfunktion ordnet Paaren funktionaler Gehalte eine nichtnegative Kopplungsstärke zu.',
    'definition', 'original', NULL,
    'Vorbereitung der späteren mathematischen Rekonstruktion gewichteter funktionaler Beziehungen.',
    'Symmetrie, Linearität und konkrete Messvorschriften werden noch nicht vorausgesetzt.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.380');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.381', @section_333_id, 'Funktionaler Organisationsgraph',
    '\\mathcal{G}_F=(\\mathcal{F},\\mathcal{R}_F)',
    '\\mathcal{G}_F=(\\mathcal{F},\\mathcal{R}_F)',
    'Der funktionale Organisationsgraph besteht aus dem funktionalen Trägerbereich und der Menge funktionaler Relationen.',
    'definition', 'original', NULL,
    'Strukturelle Zusammenfassung der durch Axiom A2 ermöglichten Organisation.',
    'F und R_F sind definiert.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.381');

/* Bereits vorhandene Gleichungsnummern werden auf den aktuellen Abschnitt
   und die aktuelle Revision bezogen, ohne ihren Inhalt stillschweigend zu
   überschreiben. Dadurch bleibt das Skript idempotent und revisionssicher. */

SET @eq_3374 := (SELECT equation_id FROM equations WHERE equation_number='3.374' LIMIT 1);
SET @eq_3375 := (SELECT equation_id FROM equations WHERE equation_number='3.375' LIMIT 1);
SET @eq_3376 := (SELECT equation_id FROM equations WHERE equation_number='3.376' LIMIT 1);
SET @eq_3377 := (SELECT equation_id FROM equations WHERE equation_number='3.377' LIMIT 1);
SET @eq_3378 := (SELECT equation_id FROM equations WHERE equation_number='3.378' LIMIT 1);
SET @eq_3379 := (SELECT equation_id FROM equations WHERE equation_number='3.379' LIMIT 1);
SET @eq_3380 := (SELECT equation_id FROM equations WHERE equation_number='3.380' LIMIT 1);
SET @eq_3381 := (SELECT equation_id FROM equations WHERE equation_number='3.381' LIMIT 1);

/* --------------------------------------------------------------------------
   7. Proposition 3.3.2
   -------------------------------------------------------------------------- */

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.2',
    @section_333_id,
    'Relationen erzeugen funktionale Struktur',
    'Sei G_F das geordnete Paar aus funktionalem Trägerbereich F und funktionaler Relationsmenge R_F. Dann bildet jedes nichtleere relationale Paar eine funktionale Organisationsstruktur, die als funktionaler Organisationsgraph dargestellt werden kann.',
    '\\mathcal{G}_F=(\\mathcal{F},\\mathcal{R}_F),\\quad\\mathcal{R}_F\\neq\\varnothing\\;\\Longrightarrow\\;\\mathcal{G}_F\\text{ ist ein funktionaler Organisationsgraph}',
    '\\mathcal{G}_F=(\\mathcal{F},\\mathcal{R}_F),\\quad\\mathcal{R}_F\\neq\\varnothing\\;\\Longrightarrow\\;\\mathcal{G}_F\\text{ ist ein funktionaler Organisationsgraph}',
    'Nach Gleichung (3.374) besteht R_F aus geordneten Paaren funktionaler Gehalte. Werden die Gehalte als Knoten und die Relationen als gerichtete Kanten repräsentiert, entsteht unmittelbar eine Graphstruktur. Die Proposition behauptet noch keine Dynamik, Stabilität oder Selbstorganisation.',
    'A1,A2',
    'accepted',
    @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM propositions
    WHERE proposition_number = '3.3.2'
);

UPDATE propositions
SET
    section_id = @section_333_id,
    title = 'Relationen erzeugen funktionale Struktur',
    statement_text = 'Sei G_F das geordnete Paar aus funktionalem Trägerbereich F und funktionaler Relationsmenge R_F. Dann bildet jedes nichtleere relationale Paar eine funktionale Organisationsstruktur, die als funktionaler Organisationsgraph dargestellt werden kann.',
    statement_latex = '\\mathcal{G}_F=(\\mathcal{F},\\mathcal{R}_F),\\quad\\mathcal{R}_F\\neq\\varnothing\\;\\Longrightarrow\\;\\mathcal{G}_F\\text{ ist ein funktionaler Organisationsgraph}',
    word_latex = '\\mathcal{G}_F=(\\mathcal{F},\\mathcal{R}_F),\\quad\\mathcal{R}_F\\neq\\varnothing\\;\\Longrightarrow\\;\\mathcal{G}_F\\text{ ist ein funktionaler Organisationsgraph}',
    logical_derivation = 'Nach Gleichung (3.374) besteht R_F aus geordneten Paaren funktionaler Gehalte. Werden die Gehalte als Knoten und die Relationen als gerichtete Kanten repräsentiert, entsteht unmittelbar eine Graphstruktur. Die Proposition behauptet noch keine Dynamik, Stabilität oder Selbstorganisation.',
    based_on_axioms = 'A1,A2',
    status = 'accepted',
    created_revision_id = @revision_333
WHERE proposition_number = '3.3.2'
  AND @section_333_id IS NOT NULL;

SET @proposition_332_id :=
(
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.2'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT
    @proposition_332_id,
    @axiom_a1_id,
    NULL,
    'uses',
    'Proposition 3.3.2 verwendet die durch Axiom A1 gesicherte funktionale Unterscheidbarkeit.'
WHERE @proposition_332_id IS NOT NULL
  AND @axiom_a1_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies
    WHERE proposition_id = @proposition_332_id
      AND axiom_id = @axiom_a1_id
      AND dependency_type = 'uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT
    @proposition_332_id,
    @axiom_a2_id,
    NULL,
    'derived_from',
    'Proposition 3.3.2 folgt aus Axiom A2 und der formalen Einführung der Relationsmenge R_F.'
WHERE @proposition_332_id IS NOT NULL
  AND @axiom_a2_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM proposition_dependencies
    WHERE proposition_id = @proposition_332_id
      AND axiom_id = @axiom_a2_id
      AND dependency_type = 'derived_from'
);

/* --------------------------------------------------------------------------
   8. Globale Symbole
   -------------------------------------------------------------------------- */

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT
    '\\mathcal{R}_F', '\\mathcal{R}_F',
    'Menge funktionaler Relationen',
    'Menge aller im betrachteten FRZK-Zusammenhang bestehenden funktionalen Relationen.',
    'chapter', @section_333_id, @eq_3374,
    NULL, '\\mathcal{F}\\times\\mathcal{F}', NULL,
    0, 0, 0,
    'Erstmalige formale Einführung in Gleichung (3.374).',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{R}_F'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT
    '\\rho_F', '\\rho_F',
    'qualitative funktionale Kopplungsfunktion',
    'Binäre Funktion, die das Bestehen einer funktionalen Relation zwischen zwei Gehalten kennzeichnet.',
    'chapter', @section_333_id, @eq_3378,
    NULL, '\\mathcal{F}\\times\\mathcal{F}', '\\{0,1\\}',
    0, 0, 1,
    'Erstmalige formale Einführung in Gleichung (3.378).',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\rho_F'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT
    '\\kappa_F', '\\kappa_F',
    'gewichtete funktionale Kopplungsfunktion',
    'Funktion zur nichtnegativen Gewichtung der Kopplungsstärke zwischen zwei funktionalen Gehalten.',
    'chapter', @section_333_id, @eq_3380,
    NULL, '\\mathcal{F}\\times\\mathcal{F}', '\\mathbb{R}_{\\geq 0}',
    0, 0, 1,
    'Die konkrete Operationalisierung erfolgt erst in Kapitel 3.4.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\kappa_F'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator, notes,
    validation_status, created_revision_id
)
SELECT
    '\\mathcal{G}_F', '\\mathcal{G}_F',
    'funktionaler Organisationsgraph',
    'Geordnetes Paar aus funktionalem Trägerbereich und funktionaler Relationsmenge.',
    'chapter', @section_333_id, @eq_3381,
    NULL, NULL, NULL,
    0, 0, 0,
    'Strukturelle Darstellung funktionaler Organisation.',
    'checked', @revision_333
WHERE @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex = '\\mathcal{G}_F'
);

/* --------------------------------------------------------------------------
   9. Gleichungssymbole
   -------------------------------------------------------------------------- */

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3374, '\\mathcal{R}_F', 'Menge funktionaler Relationen',
       'Menge der funktionalen Relationen.', NULL, '\\mathcal{F}\\times\\mathcal{F}', 1
WHERE @eq_3374 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3374 AND symbol_latex='\\mathcal{R}_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3374, '\\mathcal{F}', 'funktionaler Trägerbereich',
       'Menge funktionaler Gehalte.', NULL, NULL, 2
WHERE @eq_3374 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3374 AND symbol_latex='\\mathcal{F}'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3376, '\\delta_F', 'funktionale Unterscheidungsfunktion',
       'Qualitative Funktion zur Kennzeichnung funktionaler Unterscheidbarkeit.', NULL, '\\mathcal{F}\\times\\mathcal{F}', 1
WHERE @eq_3376 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3376 AND symbol_latex='\\delta_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3378, '\\rho_F', 'qualitative funktionale Kopplungsfunktion',
       'Binärer Indikator einer funktionalen Relation.', NULL, '\\mathcal{F}\\times\\mathcal{F}', 1
WHERE @eq_3378 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3378 AND symbol_latex='\\rho_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3380, '\\kappa_F', 'gewichtete funktionale Kopplungsfunktion',
       'Nichtnegative Stärke einer funktionalen Kopplung.', NULL, '\\mathcal{F}\\times\\mathcal{F}', 1
WHERE @eq_3380 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3380 AND symbol_latex='\\kappa_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3381, '\\mathcal{G}_F', 'funktionaler Organisationsgraph',
       'Paar aus funktionalem Trägerbereich und Relationsmenge.', NULL, NULL, 1
WHERE @eq_3381 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3381 AND symbol_latex='\\mathcal{G}_F'
);

/* --------------------------------------------------------------------------
   10. Objekt-Quellen-Verknüpfungen
   -------------------------------------------------------------------------- */

INSERT INTO object_source_links
(object_type, object_id, source_id, usage_type, note)
SELECT
    'axiom',
    @axiom_a2_id,
    @source_birkhoff,
    'historical_context',
    'Birkhoff dient der mathematischen Einordnung relationaler Ordnungsstrukturen. Axiom A2 bleibt eine eigenständige FRZK-Setzung.'
WHERE @axiom_a2_id IS NOT NULL
  AND @source_birkhoff IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM object_source_links
    WHERE object_type='axiom'
      AND object_id=@axiom_a2_id
      AND source_id=@source_birkhoff
);

INSERT INTO object_source_links
(object_type, object_id, source_id, usage_type, note)
SELECT
    'proposition',
    @proposition_332_id,
    @source_newman,
    'supporting_source',
    'Newman stützt die Darstellung relationaler Strukturen als Graphen und Netzwerke.'
WHERE @proposition_332_id IS NOT NULL
  AND @source_newman IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM object_source_links
    WHERE object_type='proposition'
      AND object_id=@proposition_332_id
      AND source_id=@source_newman
);

/* --------------------------------------------------------------------------
   11. Änderungsprotokoll
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'created', 'section',
    '3.3.3',
    'Abschnitt 3.3.3 vollständig angelegt und abgeschlossen.',
    NULL,
    'Axiom A2 – Funktionale Relationierbarkeit'
WHERE @revision_333 IS NOT NULL
  AND @section_333_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND section_id=@section_333_id
      AND change_type='created'
      AND object_reference='3.3.3'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'source_added', 'source',
    '[107]',
    'Garrett Birkhoff als neue Quelle aufgenommen.',
    NULL,
    'Lattice Theory [107]'
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND object_reference='[107]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'source_reused', 'source',
    '[48]',
    'Mark Newman mit bestehender Literaturzahl wiederverwendet.',
    NULL,
    'Networks [48]'
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND object_reference='[48]'
      AND section_id=@section_333_id
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'axiom_added', 'axiom',
    'A2',
    'Axiom A2 der funktionalen Relationierbarkeit in der Neufassung registriert.',
    NULL,
    'A2 – Funktionale Relationierbarkeit'
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND object_reference='A2'
      AND object_type='axiom'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'proposition_added', 'proposition',
    '3.3.2',
    'Proposition 3.3.2 zur Entstehung funktionaler Struktur aufgenommen.',
    NULL,
    'Relationen erzeugen funktionale Struktur'
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND object_reference='3.3.2'
      AND object_type='proposition'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'equation_added', 'equation',
    '(3.374)–(3.381)',
    'Acht Gleichungen zu Axiom A2 und Proposition 3.3.2 aufgenommen.',
    NULL,
    'Gleichungen (3.374) bis (3.381)'
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND object_reference='(3.374)–(3.381)'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_333, @section_333_id, 'symbol_added', 'symbol',
    '\\mathcal{R}_F, \\rho_F, \\kappa_F, \\mathcal{G}_F',
    'Zentrale Symbole aus Abschnitt 3.3.3 in das Symbolregister aufgenommen.',
    NULL,
    'Relationsmenge, qualitative Kopplung, gewichtete Kopplung und Organisationsgraph'
WHERE @revision_333 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_333
      AND object_reference='\\mathcal{R}_F, \\rho_F, \\kappa_F, \\mathcal{G}_F'
);

/* --------------------------------------------------------------------------
   12. Abschlussprüfungen
   -------------------------------------------------------------------------- */

SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Vorgängerrevision RKB-NEU-K3.3.2-V1 fehlt.'
        WHEN @section_33_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
        WHEN @revision_333 IS NULL
            THEN 'FEHLER: Revision 3.3.3 konnte nicht angelegt oder ermittelt werden.'
        WHEN @section_333_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.3 konnte nicht angelegt oder ermittelt werden.'
        WHEN @source_birkhoff IS NULL
            THEN 'FEHLER: Quelle Birkhoff konnte nicht angelegt oder ermittelt werden.'
        WHEN @source_newman IS NULL
            THEN 'FEHLER: Vorhandene Quelle Newman [48] wurde nicht gefunden.'
        WHEN @axiom_a2_id IS NULL
            THEN 'FEHLER: Axiom A2 konnte nicht angelegt oder ermittelt werden.'
        WHEN @proposition_332_id IS NULL
            THEN 'FEHLER: Proposition 3.3.2 konnte nicht angelegt oder ermittelt werden.'
        ELSE 'OK: Repository-Update 3.3.3 vollständig ausgeführt.'
    END AS import_status;

SELECT
    rr.revision_code,
    rr.parent_revision_id,
    ds.section_code,
    ds.title,
    ds.status,
    (SELECT COUNT(*) FROM equations e
     WHERE e.equation_number IN ('3.374','3.375','3.376','3.377','3.378','3.379','3.380','3.381')) AS equation_count,
    (SELECT COUNT(*) FROM axioms a
     WHERE a.axiom_number='A2' AND a.section_id=ds.section_id) AS axiom_count,
    (SELECT COUNT(*) FROM propositions p
     WHERE p.proposition_number='3.3.2' AND p.section_id=ds.section_id) AS proposition_count
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code = rr.scope_reference
WHERE rr.revision_code = 'RKB-NEU-K3.3.3-V1';

SELECT
    citation_number,
    source_key,
    title,
    verification_status
FROM sources
WHERE source_key IN
(
    'birkhoff_lattice_theory_1967',
    'newman_networks_2018'
)
ORDER BY citation_number;

SELECT
    equation_number,
    title,
    validation_status
FROM equations
WHERE equation_number IN
(
    '3.374','3.375','3.376','3.377',
    '3.378','3.379','3.380','3.381'
)
ORDER BY CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED);

SELECT
    axiom_number,
    section_id,
    title,
    status,
    created_revision_id
FROM axioms
WHERE axiom_number='A2';

SELECT
    proposition_number,
    section_id,
    title,
    based_on_axioms,
    status
FROM propositions
WHERE proposition_number='3.3.2';

COMMIT;
