/* ============================================================
   FRZK-RKB – Kapitel 3.2
   Abschnitt 3.2.1 – Mengen, Elemente und elementare Relationen

   VORAUSSETZUNG:
   Das freigegebene Skript für 3.2.0 wurde bereits importiert.
   Erwarteter Stand:
   - Abschnitt 3.2.0 vorhanden und final
   - Literatur [71] bis [79] vorhanden
   - next_citation_number = 80
   - keine nummerierten Gleichungen vor 3.2.1

   Grundlage:
   frzk_rkb_stand_ende_3.1(5).sql und Fortschreibung 3.2.0
   ============================================================ */

START TRANSACTION;

SET @parent_revision_id := (SELECT MAX(revision_id) FROM repository_revisions);
SET @section32 := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);

INSERT INTO repository_revisions
(
 revision_code, revision_date, scope_type, scope_reference,
 version_label, summary, created_by, parent_revision_id
)
SELECT
 'RKB-NEU-K3.2.1-V1', NOW(), 'section', '3.2.1',
 '3.2.1-v1',
 'Repositorygerechte Aufnahme von Abschnitt 3.2.1 mit Literatur [80] und [81], Wiederverwendung bestehender Quellen, Definitionen 3.2.1 und 3.2.2 sowie Gleichungen (3.1) bis (3.23).',
 'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.1-V1'
);

SET @revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.1-V1' LIMIT 1
);

INSERT INTO dissertation_sections
(
 parent_section_id, section_code, title, chapter_no,
 section_order, status, is_original_contribution, notes
)
SELECT
 @section32, '3.2.1', 'Mengen, Elemente und elementare Relationen',
 3, 3.2100, 'final', 0,
 'Mathematische Grundlegung von Mengen, Elementen, Teilmengen, Mengenoperationen, kartesischen Produkten und binären Relationen. Gleichungen (3.1) bis (3.23); neue Literatur [80] und [81].'
WHERE @section32 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM dissertation_sections WHERE section_code='3.2.1'
);

SET @section321 := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2.1' LIMIT 1
);

/* ============================================================
   Autoren [80] und [81]
   ============================================================ */

INSERT INTO authors
(family_name, given_names, normalized_name, notes)
SELECT 'Enderton', 'Herbert B.', 'Enderton, Herbert B.',
       'Autor der mengentheoretischen Grundlagenquelle [80].'
WHERE NOT EXISTS
(SELECT 1 FROM authors WHERE normalized_name='Enderton, Herbert B.');

INSERT INTO authors
(family_name, given_names, normalized_name, notes)
SELECT 'Jech', 'Thomas', 'Jech, Thomas',
       'Autor der axiomatischen und weiterführenden Mengenlehre [81].'
WHERE NOT EXISTS
(SELECT 1 FROM authors WHERE normalized_name='Jech, Thomas');

/* ============================================================
   Neue Quellen [80] und [81]
   ============================================================ */

INSERT INTO sources
(
 citation_number, source_key, source_type, title,
 year_original, year_edition, publisher, place, edition, isbn,
 language_code, priority, evidence_type, frzk_relevance,
 verification_status, first_citation_section_code,
 first_citation_note, full_citation_text, short_citation_text,
 notes, created_revision_id
)
SELECT
 80, 'enderton_elements_set_theory_1977', 'book',
 'Elements of Set Theory',
 1977, 1977, 'Academic Press', 'New York, San Francisco and London',
 NULL, '978-0-12-238440-0',
 'en', 2, 'textbook', 8,
 'verified', '3.2.1',
 'Erstmalige Einführung als systematische Grundlage elementarer Mengenlehre.',
 'Enderton, Herbert B.: Elements of Set Theory. New York, San Francisco and London: Academic Press, 1977.',
 'Enderton: Elements of Set Theory, 1977.',
 'Systematische Einführung in Mengen, Relationen, Funktionen, natürliche Zahlen und Kardinalzahlen.',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM sources
 WHERE citation_number=80 OR source_key='enderton_elements_set_theory_1977'
);

INSERT INTO sources
(
 citation_number, source_key, source_type, title,
 year_original, year_edition, publisher, place, edition, isbn,
 language_code, priority, evidence_type, frzk_relevance,
 verification_status, first_citation_section_code,
 first_citation_note, full_citation_text, short_citation_text,
 notes, created_revision_id
)
SELECT
 81, 'jech_set_theory_2006', 'book',
 'Set Theory',
 1978, 2006, 'Springer', 'Berlin and Heidelberg',
 'The Third Millennium Edition, Revised and Expanded',
 '978-3-540-44085-7',
 'en', 2, 'textbook', 8,
 'verified', '3.2.1',
 'Erstmalige Einführung zur axiomatischen und weiterführenden Einordnung der Mengenlehre.',
 'Jech, Thomas: Set Theory. The Third Millennium Edition, Revised and Expanded. Berlin and Heidelberg: Springer, 2006.',
 'Jech: Set Theory, 2006.',
 'Axiomatische und weiterführende Darstellung moderner Mengenlehre.',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM sources
 WHERE citation_number=81 OR source_key='jech_set_theory_2006'
);

/* Autorenverknüpfungen */
INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name='Enderton, Herbert B.'
WHERE s.citation_number=80
AND NOT EXISTS
(
 SELECT 1 FROM source_authors sa
 WHERE sa.source_id=s.source_id AND sa.author_id=a.author_id
);

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT s.source_id, a.author_id, 1, 'author'
FROM sources s
JOIN authors a ON a.normalized_name='Jech, Thomas'
WHERE s.citation_number=81
AND NOT EXISTS
(
 SELECT 1 FROM source_authors sa
 WHERE sa.source_id=s.source_id AND sa.author_id=a.author_id
);

/* ============================================================
   Literaturverwendungen
   ============================================================ */

/* Neue Quellen */
INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT s.source_id, @section321, 'first_citation',
 CASE s.citation_number
  WHEN 80 THEN 'Schrittweise formale Grundlegung von Mengen, Relationen, Funktionen und Kardinalität.'
  WHEN 81 THEN 'Axiomatische Einordnung der Mengenlehre, insbesondere Extensionalität und weiterführende Mengenkonstruktionen.'
 END,
 CONCAT('Abschnitt 3.2.1 – Erstnennung [',s.citation_number,']'),
 1, 1, 'Vollständige bibliografische Erstnennung im Abschnittstext.', @revision_id
FROM sources s
WHERE s.citation_number IN (80,81)
AND @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM source_usage su
 WHERE su.source_id=s.source_id AND su.section_id=@section321
);

/* Wiederverwendete Quellen [6], [59], [60], [62], [67], [68] */
INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT s.source_id, @section321,
 CASE
  WHEN s.citation_number IN (67,68) THEN 'state_of_research'
  WHEN s.citation_number IN (59,60,62) THEN 'background'
  ELSE 'background'
 END,
 CASE s.citation_number
  WHEN 6 THEN 'Elementare Mengenlehre und Abgrenzung der leeren Menge vom absoluten Nichts.'
  WHEN 59 THEN 'Formale Bedeutung von Relationen und logischer Struktur.'
  WHEN 60 THEN 'Strukturen werden wesentlich auch durch Abbildungen und Beziehungen zwischen Objekten bestimmt.'
  WHEN 62 THEN 'Logische und relationale Grundlagen mathematischer Beschreibung.'
  WHEN 67 THEN 'Strukturalistische Einordnung mathematischer Gegenstände.'
  WHEN 68 THEN 'Mathematische Gegenstände als Positionen innerhalb von Strukturen.'
 END,
 CONCAT('Abschnitt 3.2.1 – Wiederverwendung [',s.citation_number,']'),
 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', @revision_id
FROM sources s
WHERE s.citation_number IN (6,59,60,62,67,68)
AND @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM source_usage su
 WHERE su.source_id=s.source_id AND su.section_id=@section321
);

/* ============================================================
   Definitionen
   ============================================================ */

SET @source80 := (SELECT source_id FROM sources WHERE citation_number=80 LIMIT 1);

INSERT INTO definitions
(
 definition_number, section_id, title, definition_text,
 formal_latex, word_latex, provenance, source_id,
 assumptions, notes, validation_status, created_revision_id
)
SELECT
 '3.2.1', @section321, 'Menge und Element',
 'Eine Menge M ist eine formal bestimmte Zusammenfassung unterscheidbarer Objekte. Die zu M gehörenden Objekte werden als Elemente der Menge bezeichnet.',
 'x\in M;\quad x\notin M',
 'x\in M;\quad x\notin M',
 'adapted', @source80,
 'Es wird eine formale Sprache mit einer wohldefinierten Zugehörigkeitsrelation vorausgesetzt.',
 'An die etablierte Mengenlehre angepasste Arbeitsdefinition; keine FRZK-spezifische Eigenleistung.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM definitions WHERE definition_number='3.2.1'
);

INSERT INTO definitions
(
 definition_number, section_id, title, definition_text,
 formal_latex, word_latex, provenance, source_id,
 assumptions, notes, validation_status, created_revision_id
)
SELECT
 '3.2.2', @section321, 'Binäre Relation',
 'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge ihres kartesischen Produkts A × B.',
 'R\subseteq A\times B',
 'R\subseteq A\times B',
 'adapted', @source80,
 'Die Mengen A und B sowie ihr kartesisches Produkt sind definiert.',
 'An die etablierte Mengenlehre angepasste Arbeitsdefinition.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM definitions WHERE definition_number='3.2.2'
);

/* ============================================================
   Gleichungen (3.1) bis (3.23)
   ============================================================ */

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.1', @section321, 'Elementzugehörigkeit',
 'x\in M', 'x\in M',
 'Das Objekt x ist Element der Menge M.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.1'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.2', @section321, 'Nichtzugehörigkeit',
 'x\notin M', 'x\notin M',
 'Das Objekt x ist kein Element der Menge M.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.2'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.3', @section321, 'Aufzählende Mengendarstellung',
 'M=\{a,b,c\}', 'M=\{a,b,c\}',
 'Die Menge M enthält die Elemente a, b und c.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.3'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.4', @section321, 'Reihenfolge und Mehrfachnennung',
 '\{a,b,c\}=\{c,a,b\}=\{a,a,b,c\}', '\{a,b,c\}=\{c,a,b\}=\{a,a,b,c\}',
 'Reihenfolge und Mehrfachnennung verändern eine Menge nicht.', 'derived', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.4'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.5', @section321, 'Menge durch Auswahlbedingung',
 'M=\{x\in U\mid P(x)\}', 'M=\{x\in U\mid P(x)\}',
 'M enthält genau die Elemente aus U, für die P(x) gilt.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.5'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.6', @section321, 'Gerade natürliche Zahlen',
 'G=\{n\in\mathbb{N}\mid \exists k\in\mathbb{N}:n=2k\}', 'G=\{n\in\mathbb{N}\mid \exists k\in\mathbb{N}:n=2k\}',
 'Definition der Menge gerader natürlicher Zahlen.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.6'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.7', @section321, 'Teilmengenrelation',
 'A\subseteq B\quad\Longleftrightarrow\quad\forall x\,(x\in A\Rightarrow x\in B)', 'A\subseteq B\quad\Longleftrightarrow\quad\forall x\,(x\in A\Rightarrow x\in B)',
 'A ist Teilmenge von B genau dann, wenn jedes Element von A auch Element von B ist.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.7'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.8', @section321, 'Echte Teilmenge',
 'A\subset B\quad\Longleftrightarrow\quad A\subseteq B\land A\neq B', 'A\subset B\quad\Longleftrightarrow\quad A\subseteq B\land A\neq B',
 'A ist echte Teilmenge von B, wenn A Teilmenge, aber nicht gleich B ist.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.8'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.9', @section321, 'Extensionalität',
 'A=B\quad\Longleftrightarrow\quad\forall x\,(x\in A\Leftrightarrow x\in B)', 'A=B\quad\Longleftrightarrow\quad\forall x\,(x\in A\Leftrightarrow x\in B)',
 'Zwei Mengen sind gleich, wenn sie genau dieselben Elemente enthalten.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=81 LIMIT 1),
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.9'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.10', @section321, 'Leere Menge',
 '\forall x\;(x\notin\varnothing)', '\forall x\;(x\notin\varnothing)',
 'Die leere Menge enthält kein Element.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.10'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.11', @section321, 'Leere Menge als Teilmenge',
 '\forall A\;(\varnothing\subseteq A)', '\forall A\;(\varnothing\subseteq A)',
 'Die leere Menge ist Teilmenge jeder Menge.', 'derived', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.11'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.12', @section321, 'Vereinigung',
 'A\cup B=\{x\mid x\in A\lor x\in B\}', 'A\cup B=\{x\mid x\in A\lor x\in B\}',
 'Die Vereinigung enthält alle Elemente aus A oder B.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.12'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.13', @section321, 'Schnittmenge',
 'A\cap B=\{x\mid x\in A\land x\in B\}', 'A\cap B=\{x\mid x\in A\land x\in B\}',
 'Die Schnittmenge enthält alle Elemente, die zugleich in A und B liegen.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.13'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.14', @section321, 'Differenzmenge',
 'A\setminus B=\{x\mid x\in A\land x\notin B\}', 'A\setminus B=\{x\mid x\in A\land x\notin B\}',
 'Die Differenzmenge enthält Elemente aus A, die nicht in B liegen.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.14'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.15', @section321, 'Disjunktheit',
 'A\cap B=\varnothing', 'A\cap B=\varnothing',
 'A und B sind disjunkt, wenn ihre Schnittmenge leer ist.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.15'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.16', @section321, 'Potenzmenge',
 '\mathcal{P}(A)=\{B\mid B\subseteq A\}', '\mathcal{P}(A)=\{B\mid B\subseteq A\}',
 'Die Potenzmenge enthält sämtliche Teilmengen von A.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.16'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.17', @section321, 'Beispiel einer Potenzmenge',
 '\mathcal{P}(A)=\{\varnothing,\{a\},\{b\},\{a,b\}\}', '\mathcal{P}(A)=\{\varnothing,\{a\},\{b\},\{a,b\}\}',
 'Potenzmenge der zweielementigen Menge A={a,b}.', 'derived', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.17'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.18', @section321, 'Mächtigkeit der Potenzmenge',
 '|A|=n\quad\Longrightarrow\quad|\mathcal{P}(A)|=2^n', '|A|=n\quad\Longrightarrow\quad|\mathcal{P}(A)|=2^n',
 'Eine endliche n-elementige Menge besitzt 2^n Teilmengen.', 'theorem', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.18'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.19', @section321, 'Reihenfolge im geordneten Paar',
 '(a,b)\neq(b,a)', '(a,b)\neq(b,a)',
 'Im Allgemeinen unterscheidet sich ein geordnetes Paar bei Vertauschung der Komponenten.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.19'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.20', @section321, 'Kartesisches Produkt',
 'A\times B=\{(a,b)\mid a\in A\land b\in B\}', 'A\times B=\{(a,b)\mid a\in A\land b\in B\}',
 'Das kartesische Produkt enthält alle geordneten Paare aus A und B.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.20'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.21', @section321, 'Mächtigkeit des kartesischen Produkts',
 '|A\times B|=|A|\cdot|B|', '|A\times B|=|A|\cdot|B|',
 'Für endliche Mengen ist die Mächtigkeit des kartesischen Produkts das Produkt der Mächtigkeiten.', 'theorem', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.21'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.22', @section321, 'Binäre Relation',
 'R\subseteq A\times B', 'R\subseteq A\times B',
 'Eine binäre Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.22'
);

INSERT INTO equations
(
 equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id,
 derivation, assumptions, validation_status, created_revision_id
)
SELECT
 '3.23', @section321, 'Relationsschreibweise',
 'a\,R\,b', 'a\,R\,b',
 'Kurzschreibweise dafür, dass das geordnete Paar (a,b) zur Relation R gehört.', 'definition', 'literature', @source80,
 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.',
 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.',
 'verified', @revision_id
WHERE @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.23'
);

/* ============================================================
   Änderungsprotokoll
   ============================================================ */

INSERT INTO section_change_log
(
 revision_id, section_id, change_type, object_type,
 object_reference, change_summary, previous_value, new_value
)
SELECT
 @revision_id, @section321, 'created', 'section', '3.2.1',
 'Abschnitt 3.2.1 wurde mit Literaturführung, zwei Definitionen und 23 nummerierten Gleichungen angelegt.',
 NULL,
 'Status final; neue Quellen [80] und [81]; Gleichungen (3.1) bis (3.23); Definitionen 3.2.1 und 3.2.2.'
WHERE @revision_id IS NOT NULL
AND @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id
 AND section_id=@section321
 AND change_type='created'
 AND object_reference='3.2.1'
);

INSERT INTO section_change_log
(
 revision_id, section_id, change_type, object_type,
 object_reference, change_summary, previous_value, new_value
)
SELECT
 @revision_id, @section321, 'source_added', 'source', '[80]–[81]',
 'Zwei neue Grundlagenwerke zur Mengenlehre wurden aufgenommen.',
 'Letzte Literaturstelle nach 3.2.0: [79].',
 'Neue Literaturstellen: [80] und [81].'
WHERE @revision_id IS NOT NULL
AND @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id
 AND section_id=@section321
 AND change_type='source_added'
 AND object_reference='[80]–[81]'
);

INSERT INTO section_change_log
(
 revision_id, section_id, change_type, object_type,
 object_reference, change_summary, previous_value, new_value
)
SELECT
 @revision_id, @section321, 'equation_added', 'equation', '(3.1)–(3.23)',
 'Die ersten nummerierten Gleichungen des neu aufgebauten Kapitels 3 wurden aufgenommen.',
 'Keine nummerierten Gleichungen nach 3.2.0.',
 'Gleichungen (3.1) bis (3.23) registriert.'
WHERE @revision_id IS NOT NULL
AND @section321 IS NOT NULL
AND NOT EXISTS
(
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id
 AND section_id=@section321
 AND change_type='equation_added'
 AND object_reference='(3.1)–(3.23)'
);

/* ============================================================
   Zähler fortschreiben
   ============================================================ */

INSERT INTO repository_counters (counter_key, counter_value)
VALUES
 ('current_section','3.2.2'),
 ('last_citation_number','81'),
 ('next_citation_number','82'),
 ('last_equation_number','3.23'),
 ('next_equation_number','3.24'),
 ('last_definition_number','3.2.2'),
 ('next_definition_number','3.2.3'),
 ('last_completed_section','3.2.1')
ON DUPLICATE KEY UPDATE
 counter_value=VALUES(counter_value);

/* Kapitel 3.2 bleibt im Status draft, da weitere Abschnitte folgen. */
UPDATE dissertation_sections
SET status='draft'
WHERE section_code='3.2';

UPDATE dissertation_sections
SET status='final'
WHERE section_code='3.2.1';

/* ============================================================
   Abschlussaudit
   ============================================================ */

SELECT
 ds.section_code, ds.title, ds.status,
 COUNT(DISTINCT su.source_id) AS source_count,
 COUNT(DISTINCT d.definition_id) AS definition_count,
 COUNT(DISTINCT e.equation_id) AS equation_count
FROM dissertation_sections ds
LEFT JOIN source_usage su ON su.section_id=ds.section_id
LEFT JOIN definitions d ON d.section_id=ds.section_id
LEFT JOIN equations e ON e.section_id=ds.section_id
WHERE ds.section_code='3.2.1'
GROUP BY ds.section_id, ds.section_code, ds.title, ds.status;

SELECT
 equation_number, title, word_latex, validation_status
FROM equations
WHERE section_id=@section321
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT
 citation_number, full_citation_text, first_citation_section_code
FROM sources
WHERE citation_number IN (80,81)
ORDER BY citation_number;

SELECT counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
(
 'current_section',
 'last_citation_number',
 'next_citation_number',
 'last_equation_number',
 'next_equation_number',
 'last_definition_number',
 'next_definition_number',
 'last_completed_section'
)
ORDER BY counter_key;

COMMIT;
