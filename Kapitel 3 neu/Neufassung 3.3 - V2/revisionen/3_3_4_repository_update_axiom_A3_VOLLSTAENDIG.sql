/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.4
   Axiom A3 – Funktionale Transformierbarkeit

   Voraussetzung:
     - Abschnitt 3.3.3 und Revision RKB-NEU-K3.3.3-V1 sind vorhanden.
     - Gleichungsnummerierung reicht bis (3.381).
     - Literaturzählung reicht bis [107].

   Inhalt:
     - Revision RKB-NEU-K3.3.4-V1
     - Abschnitt 3.3.4
     - Quelle [108] Eilenberg/Mac Lane
     - Axiom A3
     - Proposition 3.3.3
     - Gleichungen (3.382)–(3.397)
     - Axiom- und Proposition-Abhängigkeiten
     - Symbole und Gleichungssymbole
     - Quellenverwendung, Objekt-Quellen-Verknüpfung
     - Änderungsprotokoll und Validierung

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
    WHERE revision_code = 'RKB-NEU-K3.3.3-V1'
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
    'RKB-NEU-K3.3.4-V1',
    NOW(),
    'section',
    '3.3.4',
    '1.0',
    'Abschnitt 3.3.4: Axiom A3 der funktionalen Transformierbarkeit, Proposition 3.3.3, Gleichungen (3.382) bis (3.397) und Quelle [108].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.4-V1'
);

SET @revision_334 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.4-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   2. Abschnitt 3.3.4
   -------------------------------------------------------------------------- */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no, section_order,
    status, is_original_contribution, notes
)
SELECT
    @section_33_id,
    '3.3.4',
    'Axiom A3 – Funktionale Transformierbarkeit',
    3,
    3.3040,
    'final',
    1,
    'Einführung funktionaler Operationen, Transformationen von Gehalten und Relationen, Definitions- und Bildbereichen, Komposition, Nichtdeterminismus und funktionalen Zustandsfolgen.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.3.4'
);

UPDATE dissertation_sections
SET
    parent_section_id = @section_33_id,
    title = 'Axiom A3 – Funktionale Transformierbarkeit',
    chapter_no = 3,
    section_order = 3.3040,
    status = 'final',
    is_original_contribution = 1,
    notes = 'Einführung funktionaler Operationen, Transformationen von Gehalten und Relationen, Definitions- und Bildbereichen, Komposition, Nichtdeterminismus und funktionalen Zustandsfolgen.'
WHERE section_code = '3.3.4';

SET @section_334_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3.4'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   3. Autoren und Quelle [108]
   -------------------------------------------------------------------------- */

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Eilenberg', 'Samuel', 'Eilenberg, Samuel', 1913, 1998,
    'Mitautor der Quelle [108].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Eilenberg, Samuel'
);

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Mac Lane', 'Saunders', 'Mac Lane, Saunders', 1909, 2005,
    'Mitautor der Quelle [108].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Mac Lane, Saunders'
);

SET @author_eilenberg :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Eilenberg, Samuel'
    LIMIT 1
);

SET @author_mac_lane :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Mac Lane, Saunders'
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
    108,
    'eilenberg_mac_lane_natural_equivalences_1945',
    'journal_article',
    'General Theory of Natural Equivalences',
    NULL,
    1945,
    1945,
    'Transactions of the American Mathematical Society',
    NULL,
    NULL,
    '58',
    NULL,
    '231–294',
    NULL,
    '10.1090/S0002-9947-1945-0013131-6',
    NULL,
    NULL,
    'en',
    5,
    'primary',
    5,
    'verified',
    '3.3.4',
    'Erstnennung zur mathematischen Einordnung von Abbildungen, Morphismen und Komposition.',
    'Eilenberg, Samuel; Mac Lane, Saunders (1945): General Theory of Natural Equivalences. Transactions of the American Mathematical Society, 58, S. 231–294.',
    'Eilenberg und Mac Lane [108]',
    'Historische Grundlegung der Kategorientheorie; im FRZK nur zur wissenschaftlichen Einordnung verwendet.',
    @revision_334
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 108
       OR source_key = 'eilenberg_mac_lane_natural_equivalences_1945'
);

SET @source_108 :=
(
    SELECT source_id
    FROM sources
    WHERE source_key = 'eilenberg_mac_lane_natural_equivalences_1945'
    LIMIT 1
);

INSERT INTO source_authors
(source_id, author_id, author_order, role)
SELECT @source_108, @author_eilenberg, 1, 'author'
WHERE @source_108 IS NOT NULL
  AND @author_eilenberg IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_108
      AND author_id = @author_eilenberg
      AND role = 'author'
);

INSERT INTO source_authors
(source_id, author_id, author_order, role)
SELECT @source_108, @author_mac_lane, 2, 'author'
WHERE @source_108 IS NOT NULL
  AND @author_mac_lane IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_108
      AND author_id = @author_mac_lane
      AND role = 'author'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_108,
    @section_334_id,
    'first_citation',
    'Abbildungen und ihre Komposition können als grundlegende Bestandteile mathematischer Strukturen behandelt werden.',
    'Abschnitt 3.3.4, wissenschaftliche Einordnung vor Axiom A3',
    1,
    1,
    'Die vollständige kategoriale Struktur wird im FRZK an dieser Stelle nicht vorausgesetzt.',
    @revision_334
WHERE @source_108 IS NOT NULL
  AND @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id = @source_108
      AND section_id = @section_334_id
      AND exact_location = 'Abschnitt 3.3.4, wissenschaftliche Einordnung vor Axiom A3'
);

/* --------------------------------------------------------------------------
   4. Axiom A3
   -------------------------------------------------------------------------- */

INSERT INTO axioms
(
    axiom_number, section_id, title, axiom_text,
    formal_latex, word_latex, motivation,
    independence_note, consistency_note, operationalization_note,
    source_assumption_id, status, created_revision_id
)
SELECT
    'A3',
    @section_334_id,
    'Funktionale Transformierbarkeit',
    'Funktionale Gehalte und funktionale Relationen können durch funktionale Operationen in andere funktionale Gehalte oder Relationen überführt werden.',
    '\\exists O_F\\in\\mathcal{O}_F:\\operatorname{dom}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
    '\\exists O_F\\in\\mathcal{O}_F:\\operatorname{dom}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
    'Funktionale Relationierbarkeit erzeugt zunächst nur statische Struktur. Entwicklung, Anpassung und Auflösung erfordern die grundsätzliche Möglichkeit funktionaler Transformation.',
    'Axiom A3 wird nicht aus Axiom A2 abgeleitet. Axiom A2 stellt lediglich die relationale Struktur bereit, auf die Transformationen wirken können.',
    'Das Axiom ist mit A1 und A2 vereinbar, weil Transformationen weder global anwendbar noch eindeutig, umkehrbar, linear oder deterministisch sein müssen.',
    'Operationalisierung über funktionale Operatoren, Definitions- und Bildbereiche, Kompositionen und Zustandsfolgen.',
    NULL,
    'accepted',
    @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM axioms
    WHERE axiom_number = 'A3'
);

UPDATE axioms
SET
    section_id = @section_334_id,
    title = 'Funktionale Transformierbarkeit',
    axiom_text = 'Funktionale Gehalte und funktionale Relationen können durch funktionale Operationen in andere funktionale Gehalte oder Relationen überführt werden.',
    formal_latex = '\\exists O_F\\in\\mathcal{O}_F:\\operatorname{dom}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
    word_latex = '\\exists O_F\\in\\mathcal{O}_F:\\operatorname{dom}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
    motivation = 'Funktionale Relationierbarkeit erzeugt zunächst nur statische Struktur. Entwicklung, Anpassung und Auflösung erfordern die grundsätzliche Möglichkeit funktionaler Transformation.',
    independence_note = 'Axiom A3 wird nicht aus Axiom A2 abgeleitet. Axiom A2 stellt lediglich die relationale Struktur bereit, auf die Transformationen wirken können.',
    consistency_note = 'Das Axiom ist mit A1 und A2 vereinbar, weil Transformationen weder global anwendbar noch eindeutig, umkehrbar, linear oder deterministisch sein müssen.',
    operationalization_note = 'Operationalisierung über funktionale Operatoren, Definitions- und Bildbereiche, Kompositionen und Zustandsfolgen.',
    status = 'accepted',
    created_revision_id = @revision_334
WHERE axiom_number = 'A3'
  AND @section_334_id IS NOT NULL;

SET @axiom_a1_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A1' LIMIT 1);
SET @axiom_a2_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A2' LIMIT 1);
SET @axiom_a3_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A3' LIMIT 1);

INSERT INTO axiom_dependencies
(axiom_id, depends_on_axiom_id, dependency_type, note)
SELECT
    @axiom_a3_id, @axiom_a2_id, 'extends',
    'Axiom A3 erweitert die durch Axiom A2 eröffnete relationale Struktur um Transformierbarkeit.'
WHERE @axiom_a3_id IS NOT NULL
  AND @axiom_a2_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM axiom_dependencies
    WHERE axiom_id=@axiom_a3_id
      AND depends_on_axiom_id=@axiom_a2_id
      AND dependency_type='extends'
);

/* --------------------------------------------------------------------------
   5. Gleichungen (3.382)–(3.397)
   -------------------------------------------------------------------------- */

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.382', @section_334_id, 'Nichtleere Menge funktionaler Operationen',
       '\\mathcal{O}_F\\neq\\varnothing',
       '\\mathcal{O}_F\\neq\\varnothing',
       'Es existiert wenigstens eine funktionale Operation.',
       'axiom', 'original', NULL,
       'Direkte formale Konsequenz der in Axiom A3 gesetzten Transformierbarkeit.',
       'Axiom A3.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.382');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.383', @section_334_id, 'Einfache funktionale Operation',
       'O_F:\\mathcal{F}\\rightarrow\\mathcal{F}',
       'O_F:\\mathcal{F}\\rightarrow\\mathcal{F}',
       'Eine funktionale Operation bildet funktionale Gehalte auf funktionale Gehalte ab.',
       'definition', 'original', NULL,
       'Einfachste Abbildungsform einer funktionalen Transformation.',
       'Der funktionale Trägerbereich ist definiert.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.383');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.384', @section_334_id, 'Transformation eines funktionalen Gehalts',
       'O_F(f_i)=f_j',
       'O_F(f_i)=f_j',
       'Die Operation O_F überführt den funktionalen Gehalt f_i in f_j.',
       'definition', 'original', NULL,
       'Anwendung der in Gleichung (3.383) eingeführten Operation.',
       'f_i liegt im Definitionsbereich von O_F.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.384');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.385', @section_334_id, 'Wirksame funktionale Transformation',
       '\\delta_F\\!\\left(f_i,O_F(f_i)\\right)=1',
       '\\delta_F\\left(f_i,O_F(f_i)\\right)=1',
       'Eine wirksame Transformation erzeugt einen funktional unterscheidbaren Folgegehalt.',
       'derived', 'original', NULL,
       'Verknüpfung der funktionalen Operation mit der Unterscheidungsfunktion.',
       'Axiom A1 und Axiom A3.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.385');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.386', @section_334_id, 'Invarianz unter einer Operation',
       'O_F(f_i)=f_i',
       'O_F(f_i)=f_i',
       'Der funktionale Gehalt bleibt unter der betrachteten Operation invariant.',
       'definition', 'original', NULL,
       'Spezialfall einer funktionalen Transformation ohne unterscheidbaren Folgegehalt.',
       'f_i liegt im Definitionsbereich von O_F.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.386');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.387', @section_334_id, 'Operation auf Gehalten und Relationen',
       'O_F:\\mathcal{F}\\cup\\mathcal{R}_F\\rightarrow\\mathcal{F}\\cup\\mathcal{R}_F',
       'O_F:\\mathcal{F}\\cup\\mathcal{R}_F\\rightarrow\\mathcal{F}\\cup\\mathcal{R}_F',
       'Funktionale Operationen können auf funktionale Gehalte und funktionale Relationen wirken.',
       'definition', 'original', NULL,
       'Erweiterung der einfachen Abbildung aus Gleichung (3.383).',
       'Axiom A2 und Axiom A3.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.387');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.388', @section_334_id, 'Transformation einer Relation',
       'O_F\\!\\left((f_i,f_j)\\right)=(f_k,f_l)',
       'O_F\\left((f_i,f_j)\\right)=(f_k,f_l)',
       'Eine funktionale Relation wird in eine andere funktionale Relation überführt.',
       'model', 'original', NULL,
       'Anwendungsfall der erweiterten Operation aus Gleichung (3.387).',
       '(f_i,f_j) liegt im Definitionsbereich von O_F.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.388');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.389', @section_334_id, 'Definitionsbereich einer funktionalen Operation',
       '\\operatorname{dom}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
       '\\operatorname{dom}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
       'Der Definitionsbereich einer funktionalen Operation ist eine Teilmenge der funktionalen Gehalte und Relationen.',
       'definition', 'original', NULL,
       'Formale Einschränkung der Anwendbarkeit funktionaler Operationen.',
       'Axiom A3.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.389');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.390', @section_334_id, 'Bildbereich einer funktionalen Operation',
       '\\operatorname{im}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
       '\\operatorname{im}(O_F)\\subseteq\\mathcal{F}\\cup\\mathcal{R}_F',
       'Der Bildbereich einer funktionalen Operation liegt im Bereich funktionaler Gehalte und Relationen.',
       'definition', 'original', NULL,
       'Formale Bestimmung möglicher Ergebnisse funktionaler Operationen.',
       'Axiom A3.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.390');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.391', @section_334_id, 'Komposition funktionaler Operationen',
       '\\left(O_{F,2}\\circ O_{F,1}\\right)(f_i)=O_{F,2}\\!\\left(O_{F,1}(f_i)\\right)',
       '\\left(O_{F,2}\\circ O_{F,1}\\right)(f_i)=O_{F,2}\\left(O_{F,1}(f_i)\\right)',
       'Zwei kompatible funktionale Operationen können nacheinander ausgeführt werden.',
       'definition', 'adapted', @source_108,
       'Übertragung des allgemeinen Kompositionsbegriffs auf funktionale Operationen.',
       'Die zweite Operation ist auf dem Ergebnis der ersten definiert.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.391');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.392', @section_334_id, 'Minimale Kompatibilität zweier Operationen',
       '\\operatorname{im}(O_{F,1})\\cap\\operatorname{dom}(O_{F,2})\\neq\\varnothing',
       '\\operatorname{im}(O_{F,1})\\cap\\operatorname{dom}(O_{F,2})\\neq\\varnothing',
       'Mindestens ein Ergebnis der ersten Operation liegt im Definitionsbereich der zweiten.',
       'derived', 'original', NULL,
       'Minimale Bedingung für eine partielle Komposition.',
       'Definitions- und Bildbereiche sind definiert.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.392');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.393', @section_334_id, 'Vollständige Kompatibilität zweier Operationen',
       '\\operatorname{im}(O_{F,1})\\subseteq\\operatorname{dom}(O_{F,2})',
       '\\operatorname{im}(O_{F,1})\\subseteq\\operatorname{dom}(O_{F,2})',
       'Der gesamte Bildbereich der ersten Operation liegt im Definitionsbereich der zweiten.',
       'derived', 'original', NULL,
       'Stärkere Bedingung für eine vollständige Komposition.',
       'Definitions- und Bildbereiche sind definiert.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.393');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.394', @section_334_id, 'Nichtdeterministische funktionale Operation',
       'O_F:\\mathcal{F}\\rightarrow\\mathcal{P}(\\mathcal{F})',
       'O_F:\\mathcal{F}\\rightarrow\\mathcal{P}(\\mathcal{F})',
       'Eine funktionale Operation kann einem Ausgangsgehalt mehrere mögliche Folgegehalte zuordnen.',
       'definition', 'original', NULL,
       'Verallgemeinerung auf mehrwertige beziehungsweise nichtdeterministische Transformationen.',
       'Die Potenzmenge des funktionalen Trägerbereichs ist verfügbar.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.394');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.395', @section_334_id, 'Mögliches Transformationsergebnis',
       'f_j\\in O_F(f_i)',
       'f_j\\in O_F(f_i)',
       'Der funktionale Gehalt f_j gehört zu den möglichen Ergebnissen der Operation auf f_i.',
       'definition', 'original', NULL,
       'Elementschreibweise der mehrwertigen Operation aus Gleichung (3.394).',
       'O_F ist mehrwertig definiert.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.395');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.396', @section_334_id, 'Funktionale Zustandsfolge',
       'f_0\\xrightarrow{O_{F,1}}f_1\\xrightarrow{O_{F,2}}f_2\\xrightarrow{}\\cdots\\xrightarrow{O_{F,n}}f_n',
       'f_0\\xrightarrow{O_{F,1}}f_1\\xrightarrow{O_{F,2}}f_2\\xrightarrow{}\\cdots\\xrightarrow{O_{F,n}}f_n',
       'Sukzessive kompatible Operationen erzeugen eine geordnete Folge funktionaler Gehalte.',
       'theorem', 'original', NULL,
       'Formale Darstellung der Proposition 3.3.3.',
       'Die verwendeten Operationen sind nacheinander kompatibel.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.396');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id)
SELECT '3.397', @section_334_id, 'Rekursive Bestimmung der Zustandsfolge',
       'f_k=O_{F,k}(f_{k-1})\\qquad\\text{für }k=1,\\ldots,n',
       'f_k=O_{F,k}(f_{k-1})\\qquad\\text{für }k=1,\\ldots,n',
       'Jedes Folgenglied entsteht durch Anwendung der k-ten Operation auf das vorherige Folgenglied.',
       'derived', 'original', NULL,
       'Rekursive Schreibweise der Zustandsfolge aus Gleichung (3.396).',
       'Die Operationen sind nacheinander kompatibel.', 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.397');

/* IDs der Gleichungen */
SET @eq_3382 := (SELECT equation_id FROM equations WHERE equation_number='3.382' LIMIT 1);
SET @eq_3383 := (SELECT equation_id FROM equations WHERE equation_number='3.383' LIMIT 1);
SET @eq_3385 := (SELECT equation_id FROM equations WHERE equation_number='3.385' LIMIT 1);
SET @eq_3387 := (SELECT equation_id FROM equations WHERE equation_number='3.387' LIMIT 1);
SET @eq_3389 := (SELECT equation_id FROM equations WHERE equation_number='3.389' LIMIT 1);
SET @eq_3390 := (SELECT equation_id FROM equations WHERE equation_number='3.390' LIMIT 1);
SET @eq_3391 := (SELECT equation_id FROM equations WHERE equation_number='3.391' LIMIT 1);
SET @eq_3394 := (SELECT equation_id FROM equations WHERE equation_number='3.394' LIMIT 1);
SET @eq_3396 := (SELECT equation_id FROM equations WHERE equation_number='3.396' LIMIT 1);

/* --------------------------------------------------------------------------
   6. Proposition 3.3.3
   -------------------------------------------------------------------------- */

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.3',
    @section_334_id,
    'Transformation erzeugt funktionale Zustandsfolgen',
    'Sei f_0 ein funktionaler Ausgangsgehalt und seien O_F,1 bis O_F,n miteinander kompatible funktionale Operationen. Dann entsteht durch ihre sukzessive Anwendung eine geordnete funktionale Zustandsfolge.',
    'f_0\\xrightarrow{O_{F,1}}f_1\\xrightarrow{O_{F,2}}\\cdots\\xrightarrow{O_{F,n}}f_n',
    'f_0\\xrightarrow{O_{F,1}}f_1\\xrightarrow{O_{F,2}}\\cdots\\xrightarrow{O_{F,n}}f_n',
    'Die Proposition folgt durch wiederholte Anwendung von Axiom A3. Liegt jedes Ergebnis im Definitionsbereich der nachfolgenden Operation, kann die Folge schrittweise konstruiert werden. Die Ordnung ist zunächst funktional und setzt keine äußere Zeitvariable voraus.',
    'A1,A2,A3',
    'accepted',
    @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM propositions
    WHERE proposition_number = '3.3.3'
);

UPDATE propositions
SET
    section_id = @section_334_id,
    title = 'Transformation erzeugt funktionale Zustandsfolgen',
    statement_text = 'Sei f_0 ein funktionaler Ausgangsgehalt und seien O_F,1 bis O_F,n miteinander kompatible funktionale Operationen. Dann entsteht durch ihre sukzessive Anwendung eine geordnete funktionale Zustandsfolge.',
    statement_latex = 'f_0\\xrightarrow{O_{F,1}}f_1\\xrightarrow{O_{F,2}}\\cdots\\xrightarrow{O_{F,n}}f_n',
    word_latex = 'f_0\\xrightarrow{O_{F,1}}f_1\\xrightarrow{O_{F,2}}\\cdots\\xrightarrow{O_{F,n}}f_n',
    logical_derivation = 'Die Proposition folgt durch wiederholte Anwendung von Axiom A3. Liegt jedes Ergebnis im Definitionsbereich der nachfolgenden Operation, kann die Folge schrittweise konstruiert werden. Die Ordnung ist zunächst funktional und setzt keine äußere Zeitvariable voraus.',
    based_on_axioms = 'A1,A2,A3',
    status = 'accepted',
    created_revision_id = @revision_334
WHERE proposition_number = '3.3.3'
  AND @section_334_id IS NOT NULL;

SET @prop_333_id :=
(
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number = '3.3.3'
    LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_333_id, @axiom_a1_id, NULL, 'uses',
       'Die Zustandsfolge setzt funktional unterscheidbare Gehalte voraus.'
WHERE @prop_333_id IS NOT NULL
  AND @axiom_a1_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_333_id
      AND axiom_id=@axiom_a1_id
      AND dependency_type='uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_333_id, @axiom_a2_id, NULL, 'uses',
       'Transformationen können auch auf relationale Strukturen wirken.'
WHERE @prop_333_id IS NOT NULL
  AND @axiom_a2_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_333_id
      AND axiom_id=@axiom_a2_id
      AND dependency_type='uses'
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @prop_333_id, @axiom_a3_id, NULL, 'derived_from',
       'Die Proposition folgt durch wiederholte Anwendung funktionaler Operationen nach Axiom A3.'
WHERE @prop_333_id IS NOT NULL
  AND @axiom_a3_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM proposition_dependencies
    WHERE proposition_id=@prop_333_id
      AND axiom_id=@axiom_a3_id
      AND dependency_type='derived_from'
);

/* --------------------------------------------------------------------------
   7. Symbole
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
    '\\mathcal{O}_F', '\\mathcal{O}_F',
    'Menge funktionaler Operationen',
    'Nichtleere Menge der im FRZK zulässigen funktionalen Operationen.',
    'chapter', @section_334_id, @eq_3382,
    NULL, NULL, NULL, 0, 0, 0,
    'In Abschnitt 3.3.4 als Operationsmenge verwendet.',
    'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\\mathcal{O}_F'
      AND symbol_name='Menge funktionaler Operationen'
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
    'O_F', 'O_F',
    'funktionale Operation',
    'Abbildung oder mehrwertige Zuordnung, die funktionale Gehalte oder Relationen transformiert.',
    'chapter', @section_334_id, @eq_3383,
    NULL, '\\mathcal{F}\\cup\\mathcal{R}_F',
    '\\mathcal{F}\\cup\\mathcal{R}_F',
    0, 0, 1,
    'Kann deterministisch oder nichtdeterministisch sein.',
    'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='O_F'
      AND symbol_name='funktionale Operation'
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
    '\\operatorname{dom}(O_F)', '\\operatorname{dom}(O_F)',
    'Definitionsbereich einer funktionalen Operation',
    'Menge der funktionalen Gehalte und Relationen, auf welche die Operation anwendbar ist.',
    'section', @section_334_id, @eq_3389,
    NULL, NULL, NULL, 0, 0, 0,
    NULL, 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\\operatorname{dom}(O_F)'
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
    '\\operatorname{im}(O_F)', '\\operatorname{im}(O_F)',
    'Bildbereich einer funktionalen Operation',
    'Menge der möglichen Ergebnisse einer funktionalen Operation.',
    'section', @section_334_id, @eq_3390,
    NULL, NULL, NULL, 0, 0, 0,
    NULL, 'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\\operatorname{im}(O_F)'
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
    '\\mathcal{P}(\\mathcal{F})', '\\mathcal{P}(\\mathcal{F})',
    'Potenzmenge des funktionalen Trägerbereichs',
    'Menge aller Teilmengen des funktionalen Trägerbereichs.',
    'section', @section_334_id, @eq_3394,
    NULL, NULL, NULL, 0, 0, 0,
    'Wird zur Darstellung nichtdeterministischer Transformationen verwendet.',
    'checked', @revision_334
WHERE @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols
    WHERE symbol_latex='\\mathcal{P}(\\mathcal{F})'
);

/* Gleichungssymbole */
INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3382, '\\mathcal{O}_F', 'Menge funktionaler Operationen',
       'Nichtleere Menge funktionaler Operationen.', NULL, NULL, 1
WHERE @eq_3382 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3382 AND symbol_latex='\\mathcal{O}_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3383, 'O_F', 'funktionale Operation',
       'Operation auf funktionalen Gehalten.', NULL, '\\mathcal{F}', 1
WHERE @eq_3383 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3383 AND symbol_latex='O_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3385, '\\delta_F', 'funktionale Unterscheidungsfunktion',
       'Kennzeichnet funktionale Verschiedenheit.', NULL, '\\mathcal{F}\\times\\mathcal{F}', 1
WHERE @eq_3385 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3385 AND symbol_latex='\\delta_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3387, '\\mathcal{R}_F', 'Menge funktionaler Relationen',
       'Relationsstruktur des FRZK.', NULL, NULL, 2
WHERE @eq_3387 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3387 AND symbol_latex='\\mathcal{R}_F'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3391, '\\circ', 'Komposition',
       'Nacheinanderausführung funktionaler Operationen.', NULL, NULL, 1
WHERE @eq_3391 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3391 AND symbol_latex='\\circ'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3394, '\\mathcal{P}(\\mathcal{F})', 'Potenzmenge',
       'Menge möglicher Ergebnismengen.', NULL, NULL, 1
WHERE @eq_3394 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3394 AND symbol_latex='\\mathcal{P}(\\mathcal{F})'
);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3396, 'f_k', 'k-ter funktionaler Zustand',
       'Folgenglied einer funktionalen Zustandsfolge.', NULL, '\\mathcal{F}', 1
WHERE @eq_3396 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3396 AND symbol_latex='f_k'
);

/* --------------------------------------------------------------------------
   8. Objekt-Quellen-Verknüpfung
   -------------------------------------------------------------------------- */

INSERT INTO object_source_links
(object_type, object_id, source_id, usage_type, note)
SELECT
    'axiom',
    @axiom_a3_id,
    @source_108,
    'historical_context',
    'Eilenberg und Mac Lane dienen der mathematischen Einordnung von Abbildungen und Komposition. Axiom A3 bleibt eine eigenständige FRZK-Setzung.'
WHERE @axiom_a3_id IS NOT NULL
  AND @source_108 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM object_source_links
    WHERE object_type='axiom'
      AND object_id=@axiom_a3_id
      AND source_id=@source_108
);

/* --------------------------------------------------------------------------
   9. Änderungsprotokoll
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT
    @revision_334, @section_334_id, 'created', 'section', '3.3.4',
    'Abschnitt 3.3.4 vollständig angelegt und abgeschlossen.',
    NULL, 'Axiom A3 – Funktionale Transformierbarkeit'
WHERE @revision_334 IS NOT NULL
  AND @section_334_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_334
      AND object_reference='3.3.4'
      AND change_type='created'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT
    @revision_334, @section_334_id, 'source_added', 'source', '[108]',
    'Eilenberg und Mac Lane als neue Quelle aufgenommen.',
    NULL, 'General Theory of Natural Equivalences [108]'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_334
      AND object_reference='[108]'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT
    @revision_334, @section_334_id, 'axiom_added', 'axiom', 'A3',
    'Axiom A3 der funktionalen Transformierbarkeit registriert.',
    NULL, 'A3 – Funktionale Transformierbarkeit'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_334
      AND object_reference='A3'
      AND object_type='axiom'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT
    @revision_334, @section_334_id, 'proposition_added', 'proposition', '3.3.3',
    'Proposition 3.3.3 zu funktionalen Zustandsfolgen registriert.',
    NULL, 'Transformation erzeugt funktionale Zustandsfolgen'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_334
      AND object_reference='3.3.3'
      AND object_type='proposition'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT
    @revision_334, @section_334_id, 'equation_added', 'equation',
    '(3.382)–(3.397)',
    'Sechzehn Gleichungen zu funktionalen Operationen, Komposition und Zustandsfolgen aufgenommen.',
    NULL, 'Gleichungen (3.382) bis (3.397)'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_334
      AND object_reference='(3.382)–(3.397)'
);

/* --------------------------------------------------------------------------
   10. Repository-Validierungen
   -------------------------------------------------------------------------- */

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_334,
    'K3.3.4.SECTION',
    CASE WHEN @section_334_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_334_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung, ob Abschnitt 3.3.4 vorhanden ist.'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_334
      AND validation_code='K3.3.4.SECTION'
);

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_334,
    'K3.3.4.EQUATIONS',
    CASE
      WHEN (SELECT COUNT(*) FROM equations
            WHERE equation_number IN
            ('3.382','3.383','3.384','3.385','3.386','3.387','3.388','3.389',
             '3.390','3.391','3.392','3.393','3.394','3.395','3.396','3.397')) = 16
      THEN 'passed' ELSE 'failed'
    END,
    '16',
    CAST((SELECT COUNT(*) FROM equations
          WHERE equation_number IN
          ('3.382','3.383','3.384','3.385','3.386','3.387','3.388','3.389',
           '3.390','3.391','3.392','3.393','3.394','3.395','3.396','3.397')) AS CHAR),
    'Prüfung der Gleichungen (3.382) bis (3.397).'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_334
      AND validation_code='K3.3.4.EQUATIONS'
);

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_334,
    'K3.3.4.AXIOM_A3',
    CASE WHEN @axiom_a3_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @axiom_a3_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung von Axiom A3.'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_334
      AND validation_code='K3.3.4.AXIOM_A3'
);

INSERT INTO repository_validation_results
(revision_id, validation_code, validation_status,
 expected_value, actual_value, validation_message)
SELECT
    @revision_334,
    'K3.3.4.PROPOSITION',
    CASE WHEN @prop_333_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @prop_333_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüfung von Proposition 3.3.3.'
WHERE @revision_334 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_334
      AND validation_code='K3.3.4.PROPOSITION'
);

/* --------------------------------------------------------------------------
   11. Abschlussabfragen
   -------------------------------------------------------------------------- */

SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Vorgängerrevision RKB-NEU-K3.3.3-V1 fehlt.'
        WHEN @section_33_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
        WHEN @revision_334 IS NULL
            THEN 'FEHLER: Revision 3.3.4 konnte nicht angelegt werden.'
        WHEN @section_334_id IS NULL
            THEN 'FEHLER: Abschnitt 3.3.4 konnte nicht angelegt werden.'
        WHEN @source_108 IS NULL
            THEN 'FEHLER: Quelle [108] konnte nicht angelegt oder ermittelt werden.'
        WHEN @axiom_a3_id IS NULL
            THEN 'FEHLER: Axiom A3 konnte nicht angelegt oder aktualisiert werden.'
        WHEN @prop_333_id IS NULL
            THEN 'FEHLER: Proposition 3.3.3 konnte nicht angelegt werden.'
        ELSE 'OK: Repository-Update 3.3.4 vollständig ausgeführt.'
    END AS import_status;

SELECT
    rr.revision_code,
    rr.parent_revision_id,
    ds.section_code,
    ds.title,
    ds.status,
    (SELECT COUNT(*) FROM equations
     WHERE equation_number IN
     ('3.382','3.383','3.384','3.385','3.386','3.387','3.388','3.389',
      '3.390','3.391','3.392','3.393','3.394','3.395','3.396','3.397')) AS equation_count,
    (SELECT COUNT(*) FROM axioms
     WHERE axiom_number='A3' AND section_id=ds.section_id) AS axiom_count,
    (SELECT COUNT(*) FROM propositions
     WHERE proposition_number='3.3.3' AND section_id=ds.section_id) AS proposition_count
FROM repository_revisions rr
JOIN dissertation_sections ds
  ON ds.section_code=rr.scope_reference
WHERE rr.revision_code='RKB-NEU-K3.3.4-V1';

SELECT citation_number, source_key, title, verification_status
FROM sources
WHERE source_key='eilenberg_mac_lane_natural_equivalences_1945';

SELECT equation_number, title, validation_status
FROM equations
WHERE equation_number IN
('3.382','3.383','3.384','3.385','3.386','3.387','3.388','3.389',
 '3.390','3.391','3.392','3.393','3.394','3.395','3.396','3.397')
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT axiom_number, section_id, title, status, created_revision_id
FROM axioms
WHERE axiom_number='A3';

SELECT proposition_number, section_id, title, based_on_axioms, status
FROM propositions
WHERE proposition_number='3.3.3';

COMMIT;
