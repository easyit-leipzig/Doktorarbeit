-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschluss von Abschnitt 3.2.1
-- Abschnitt: 3.2.1 Mengen als Grundlage mathematischer Modellbildung
-- Grundlage: frzk_rkb_nach_3.2.0.sql
-- Zielsystem: MariaDB 10.4 / MySQL-kompatibel
--
-- WICHTIGE NUMMERIERUNGSKORREKTUR:
-- Der Datenbankstand nach 3.2.0 endet bei Quelle [65].
-- Daher werden die im Manuskript vorläufig als [53]-[59] bezeichneten
-- Quellen repositorykonform als [66]-[72] registriert.
--
-- Das Skript ist wiederholbar/idempotent angelegt.
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Ausgangsstand prüfen
-- ---------------------------------------------------------------------

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.0-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

-- Harte Schutzprüfung: Das Skript darf nur auf dem Abschlussstand 3.2.0
-- ausgeführt werden.
SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.2.0-V1 fehlt.'
        WHEN @chapter_section_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
        ELSE 'OK: Ausgangsstand 3.2.0 vorhanden.'
    END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Repository-Revision 3.2.1 anlegen
-- ---------------------------------------------------------------------

INSERT INTO repository_revisions
(
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    summary,
    created_by,
    parent_revision_id
)
SELECT
    'RKB-NEU-K3.2.1-V1',
    NOW(),
    'section',
    '3.2.1',
    '1.0',
    'Abschluss von Abschnitt 3.2.1 Mengen als Grundlage mathematischer Modellbildung. Registriert werden die Quellen [66] bis [72], drei Definitionen, das Extensionalitätsprinzip, Cantors Satz einschließlich Widerspruchsbeweis sowie die Gleichungen (3.149) bis (3.158). Der Abschnitt bleibt Forschungsstand und enthält keine eigenständige FRZK-Axiomatik.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.1-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.1-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsabschnitt 3.2.1 anlegen/aktualisieren
-- ---------------------------------------------------------------------

INSERT INTO dissertation_sections
(
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution,
    notes
)
SELECT
    @chapter_section_id,
    '3.2.1',
    'Mengen als Grundlage mathematischer Modellbildung',
    3,
    3.2100,
    'final',
    0,
    'Der Abschnitt rekonstruiert die Mengenlehre als formale Trägerstruktur moderner Mathematik. Behandelt werden Elementbeziehung, Extensionalität, Teilmengen, Potenzmengen, Cantors Satz, geordnete Paare und kartesische Produkte. Die Leistungsfähigkeit der Mengenlehre wird von der weiterführenden Frage nach Entstehung, Auswahl und funktionaler Wirksamkeit mathematischer Strukturen abgegrenzt.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.1'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Mengen als Grundlage mathematischer Modellbildung',
    chapter_no = 3,
    section_order = 3.2100,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt rekonstruiert die Mengenlehre als formale Trägerstruktur moderner Mathematik. Behandelt werden Elementbeziehung, Extensionalität, Teilmengen, Potenzmengen, Cantors Satz, geordnete Paare und kartesische Produkte. Die Leistungsfähigkeit der Mengenlehre wird von der weiterführenden Frage nach Entstehung, Auswahl und funktionaler Wirksamkeit mathematischer Strukturen abgegrenzt.'
WHERE section_code = '3.2.1';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren anlegen
-- ---------------------------------------------------------------------

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
VALUES
('Cantor', 'Georg', 'Cantor, Georg', 1845, 1918, 'Begründer der transfiniten Mengenlehre; Quelle [66].'),
('Zermelo', 'Ernst', 'Zermelo, Ernst', 1871, 1953, 'Begründer der axiomatischen Mengenlehre; Quelle [68].'),
('Fraenkel', 'Abraham A.', 'Fraenkel, Abraham A.', 1891, 1965, 'Mitbegründer der Zermelo-Fraenkel-Mengenlehre; Quelle [69].'),
('Skolem', 'Thoralf', 'Skolem, Thoralf', 1887, 1963, 'Beiträge zur Formalisierung der axiomatischen Mengenlehre; Quelle [70].'),
('Kuratowski', 'Kazimierz', 'Kuratowski, Kazimierz', 1896, 1980, 'Mengentheoretische Darstellung geordneter Paare; Quelle [71].'),
('Bourbaki', 'Nicolas', 'Bourbaki, Nicolas', NULL, NULL, 'Autorenkollektiv; strukturelle mengentheoretische Grundlegung; Quelle [72].')
ON DUPLICATE KEY UPDATE
    notes = VALUES(notes);

-- Bertrand Russell ist im Repository bereits als Autor vorhanden.
SET @author_cantor     := (SELECT author_id FROM authors WHERE normalized_name = 'Cantor, Georg' LIMIT 1);
SET @author_russell    := (SELECT author_id FROM authors WHERE normalized_name = 'Russell, Bertrand' LIMIT 1);
SET @author_zermelo    := (SELECT author_id FROM authors WHERE normalized_name = 'Zermelo, Ernst' LIMIT 1);
SET @author_fraenkel   := (SELECT author_id FROM authors WHERE normalized_name = 'Fraenkel, Abraham A.' LIMIT 1);
SET @author_skolem     := (SELECT author_id FROM authors WHERE normalized_name = 'Skolem, Thoralf' LIMIT 1);
SET @author_kuratowski := (SELECT author_id FROM authors WHERE normalized_name = 'Kuratowski, Kazimierz' LIMIT 1);
SET @author_bourbaki   := (SELECT author_id FROM authors WHERE normalized_name = 'Bourbaki, Nicolas' LIMIT 1);

-- ---------------------------------------------------------------------
-- 5. Quellen [66] bis [72] anlegen
-- ---------------------------------------------------------------------

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
VALUES
(
    66,
    'cantor_beitraege_transfinite_mengenlehre_1895_1897',
    'journal_article',
    'Beiträge zur Begründung der transfiniten Mengenlehre',
    'Erster und zweiter Artikel',
    1895,
    1897,
    'Mathematische Annalen',
    NULL,
    NULL,
    '46; 49',
    NULL,
    '481–512; 207–246',
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'primary',
    8,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur Entwicklung der transfiniten Mengenlehre, zur Mächtigkeit unendlicher Mengen und zu Cantors Satz.',
    'Cantor, Georg (1895/1897): Beiträge zur Begründung der transfiniten Mengenlehre. In: Mathematische Annalen 46, S. 481–512, und 49, S. 207–246.',
    'Cantor (1895/1897)',
    'Historische Primärquelle. Die beiden zusammengehörigen Artikel werden unter einer Literaturziffer geführt.',
    @revision_id
),
(
    67,
    'russell_principles_mathematics_1903',
    'book',
    'The Principles of Mathematics',
    NULL,
    1903,
    1903,
    NULL,
    'Cambridge University Press',
    'Cambridge',
    NULL,
    NULL,
    NULL,
    'First edition',
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'primary',
    7,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur Grundlagenkrise der naiven Mengenbildung, zur Russellschen Antinomie und zur Typentheorie.',
    'Russell, Bertrand (1903): The Principles of Mathematics. Cambridge: Cambridge University Press.',
    'Russell (1903)',
    'Historische Primärquelle zur Logik und zu den Grundlagen der Mathematik.',
    @revision_id
),
(
    68,
    'zermelo_grundlagen_mengenlehre_1908',
    'journal_article',
    'Untersuchungen über die Grundlagen der Mengenlehre I',
    NULL,
    1908,
    1908,
    'Mathematische Annalen',
    NULL,
    NULL,
    '65',
    NULL,
    '261–281',
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'primary',
    9,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur axiomatischen Begrenzung der Mengenbildung und zur Vermeidung mengentheoretischer Antinomien.',
    'Zermelo, Ernst (1908): Untersuchungen über die Grundlagen der Mengenlehre I. In: Mathematische Annalen 65, S. 261–281.',
    'Zermelo (1908)',
    'Historische Primärquelle zur axiomatischen Mengenlehre.',
    @revision_id
),
(
    69,
    'fraenkel_grundlagen_cantor_zermelo_1922',
    'journal_article',
    'Zu den Grundlagen der Cantor-Zermeloschen Mengenlehre',
    NULL,
    1922,
    1922,
    'Mathematische Annalen',
    NULL,
    NULL,
    '86',
    NULL,
    '230–237',
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'primary',
    8,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur Weiterentwicklung des Zermeloschen Axiomensystems und zum Ersetzungsprinzip.',
    'Fraenkel, Abraham A. (1922): Zu den Grundlagen der Cantor-Zermeloschen Mengenlehre. In: Mathematische Annalen 86, S. 230–237.',
    'Fraenkel (1922)',
    'Historische Primärquelle zur Weiterentwicklung der axiomatischen Mengenlehre.',
    @revision_id
),
(
    70,
    'skolem_axiomatische_mengenlehre_1923',
    'conference_paper',
    'Einige Bemerkungen zur axiomatischen Begründung der Mengenlehre',
    NULL,
    1922,
    1923,
    NULL,
    NULL,
    'Helsinki',
    NULL,
    NULL,
    '217–232',
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'primary',
    8,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur Formalisierung der Mengenlehre in einer Sprache erster Stufe.',
    'Skolem, Thoralf (1923): Einige Bemerkungen zur axiomatischen Begründung der Mengenlehre. In: Matematikerkongressen i Helsingfors den 4–7 Juli 1922. Den femte skandinaviska matematikerkongressen, S. 217–232.',
    'Skolem (1923)',
    'Kongressbeitrag von 1922, veröffentlicht 1923.',
    @revision_id
),
(
    71,
    'kuratowski_ordre_theorie_ensembles_1921',
    'journal_article',
    'Sur la notion de l’ordre dans la théorie des ensembles',
    NULL,
    1921,
    1921,
    'Fundamenta Mathematicae',
    NULL,
    NULL,
    '2',
    NULL,
    '161–171',
    NULL,
    NULL,
    NULL,
    NULL,
    'fr',
    1,
    'primary',
    8,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur rein mengentheoretischen Konstruktion geordneter Paare.',
    'Kuratowski, Kazimierz (1921): Sur la notion de l’ordre dans la théorie des ensembles. In: Fundamenta Mathematicae 2, S. 161–171.',
    'Kuratowski (1921)',
    'Historische Primärquelle zur mengentheoretischen Darstellung geordneter Paare.',
    @revision_id
),
(
    72,
    'bourbaki_theory_sets_2004',
    'book',
    'Theory of Sets',
    'Elements of Mathematics',
    1954,
    2004,
    NULL,
    'Springer',
    'Berlin, Heidelberg',
    NULL,
    NULL,
    NULL,
    'English edition',
    NULL,
    NULL,
    NULL,
    'en',
    2,
    'reference',
    8,
    'partially_verified',
    '3.2.1',
    'Erstnennung zur strukturalen Darstellung mathematischer Theorien auf mengentheoretischen Grundmengen.',
    'Bourbaki, Nicolas (2004): Theory of Sets. Berlin, Heidelberg: Springer. Französische Originalausgabe: Théorie des ensembles. Paris: Hermann, 1954–1957.',
    'Bourbaki (2004)',
    'Referenzwerk zur mengentheoretischen und strukturalen Grundlegung.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    source_type = VALUES(source_type),
    title = VALUES(title),
    subtitle = VALUES(subtitle),
    year_original = VALUES(year_original),
    year_edition = VALUES(year_edition),
    journal = VALUES(journal),
    publisher = VALUES(publisher),
    place = VALUES(place),
    volume = VALUES(volume),
    pages = VALUES(pages),
    language_code = VALUES(language_code),
    priority = VALUES(priority),
    evidence_type = VALUES(evidence_type),
    frzk_relevance = VALUES(frzk_relevance),
    verification_status = VALUES(verification_status),
    first_citation_section_code = VALUES(first_citation_section_code),
    first_citation_note = VALUES(first_citation_note),
    full_citation_text = VALUES(full_citation_text),
    short_citation_text = VALUES(short_citation_text),
    notes = VALUES(notes),
    created_revision_id = VALUES(created_revision_id);

SET @source_66 := (SELECT source_id FROM sources WHERE source_key = 'cantor_beitraege_transfinite_mengenlehre_1895_1897' LIMIT 1);
SET @source_67 := (SELECT source_id FROM sources WHERE source_key = 'russell_principles_mathematics_1903' LIMIT 1);
SET @source_68 := (SELECT source_id FROM sources WHERE source_key = 'zermelo_grundlagen_mengenlehre_1908' LIMIT 1);
SET @source_69 := (SELECT source_id FROM sources WHERE source_key = 'fraenkel_grundlagen_cantor_zermelo_1922' LIMIT 1);
SET @source_70 := (SELECT source_id FROM sources WHERE source_key = 'skolem_axiomatische_mengenlehre_1923' LIMIT 1);
SET @source_71 := (SELECT source_id FROM sources WHERE source_key = 'kuratowski_ordre_theorie_ensembles_1921' LIMIT 1);
SET @source_72 := (SELECT source_id FROM sources WHERE source_key = 'bourbaki_theory_sets_2004' LIMIT 1);

-- ---------------------------------------------------------------------
-- 6. Autoren den Quellen zuordnen
-- ---------------------------------------------------------------------

INSERT IGNORE INTO source_authors (source_id, author_id, author_order, role)
VALUES
(@source_66, @author_cantor,     1, 'author'),
(@source_67, @author_russell,    1, 'author'),
(@source_68, @author_zermelo,    1, 'author'),
(@source_69, @author_fraenkel,   1, 'author'),
(@source_70, @author_skolem,     1, 'author'),
(@source_71, @author_kuratowski, 1, 'author'),
(@source_72, @author_bourbaki,   1, 'author');

-- ---------------------------------------------------------------------
-- 7. Quellenverwendungen in 3.2.1 registrieren
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_66, @section_id, 'first_citation',
       'Entwicklung der transfiniten Mengenlehre, Unterscheidung unendlicher Mächtigkeiten und Grundlage von Cantors Satz.',
       'Abschnitt 3.2.1: historische Entwicklung und Cantors Satz',
       1, 1, 'Erstnennung als Quelle [66].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_66 AND section_id = @section_id
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_67, @section_id, 'first_citation',
       'Grundlagenkrise der uneingeschränkten Mengenbildung, Russellsche Antinomie und typentheoretische Reaktion.',
       'Abschnitt 3.2.1: Übergang von naiver zu axiomatischer Mengenlehre',
       1, 1, 'Erstnennung als Quelle [67].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_67 AND section_id = @section_id
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_68, @section_id, 'first_citation',
       'Axiomatische Begrenzung der Mengenbildung und systematische Vermeidung der bekannten Antinomien.',
       'Abschnitt 3.2.1: Zermelos Axiomatisierung',
       1, 1, 'Erstnennung als Quelle [68].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_68 AND section_id = @section_id
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_69, @section_id, 'first_citation',
       'Weiterentwicklung des Zermeloschen Systems und Präzisierung des Ersetzungsprinzips.',
       'Abschnitt 3.2.1: Entwicklung zur Zermelo-Fraenkel-Mengenlehre',
       1, 1, 'Erstnennung als Quelle [69].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_69 AND section_id = @section_id
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_70, @section_id, 'first_citation',
       'Einordnung der axiomatischen Mengenlehre in eine formale Sprache erster Stufe.',
       'Abschnitt 3.2.1: Formalisierung der Mengenlehre',
       1, 1, 'Erstnennung als Quelle [70].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_70 AND section_id = @section_id
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_71, @section_id, 'first_citation',
       'Mengentheoretische Konstruktion des geordneten Paares als Grundlage kartesischer Produkte und Relationen.',
       'Abschnitt 3.2.1: geordnetes Paar und kartesisches Produkt',
       1, 1, 'Erstnennung als Quelle [71].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_71 AND section_id = @section_id
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_72, @section_id, 'first_citation',
       'Strukturale Darstellung mathematischer Theorien auf mengentheoretischen Grundmengen.',
       'Abschnitt 3.2.1: Mengen als Träger weiterführender mathematischer Strukturen',
       1, 1, 'Erstnennung als Quelle [72].', @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id = @source_72 AND section_id = @section_id
);

-- ---------------------------------------------------------------------
-- 8. Definitionen
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
VALUES
(
    '3.2.1',
    @section_id,
    'Menge und Elementbeziehung',
    'Eine Menge M ist innerhalb der Mengenlehre ein mathematischer Träger, für dessen mögliche Gegenstände x bestimmt ist, ob x Element von M ist oder nicht. Die Elementbeziehung wird durch x ∈ M, ihre Negation durch x ∉ M bezeichnet.',
    'x \in M,\qquad x \notin M',
    'x \in M,\qquad x \notin M',
    'adapted',
    @source_72,
    'Es wird ein axiomatischer mengentheoretischer Rahmen vorausgesetzt.',
    'Die Definition beschreibt die formale Träger- und Zugehörigkeitsstruktur, nicht die funktionale Genese von Elementen.',
    'checked',
    @revision_id
),
(
    '3.2.2',
    @section_id,
    'Teilmenge',
    'Eine Menge A heißt Teilmenge einer Menge B, wenn jedes Element von A zugleich Element von B ist.',
    'A\subseteq B \iff \forall x\,(x\in A\rightarrow x\in B)',
    'A\subseteq B \iff \forall x\,(x\in A\rightarrow x\in B)',
    'adapted',
    @source_72,
    'A und B sind Mengen innerhalb desselben axiomatischen Rahmens.',
    'Die Teilmengenrelation bildet eine Ordnungsstruktur auf der Potenzmenge.',
    'checked',
    @revision_id
),
(
    '3.2.3',
    @section_id,
    'Potenzmenge',
    'Die Potenzmenge einer Menge M ist die Menge sämtlicher Teilmengen von M.',
    '\mathcal{P}(M)=\{A\mid A\subseteq M\}',
    '\mathcal{P}(M)=\{A\mid A\subseteq M\}',
    'adapted',
    @source_66,
    'M ist eine Menge und die Potenzmengenbildung ist im verwendeten Axiomensystem zugelassen.',
    'Die Potenzmenge hebt die Beschreibung von Elementen auf die Ebene möglicher Teilmengen.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    definition_text = VALUES(definition_text),
    formal_latex = VALUES(formal_latex),
    word_latex = VALUES(word_latex),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    assumptions = VALUES(assumptions),
    notes = VALUES(notes),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

-- ---------------------------------------------------------------------
-- 9. Satz und Beweis
-- ---------------------------------------------------------------------

INSERT INTO theorems
(
    theorem_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.2.1',
    @section_id,
    'Cantors Satz',
    'Für keine Menge M existiert eine surjektive Abbildung von M auf ihre Potenzmenge P(M). Folglich besitzt P(M) eine strikt größere Mächtigkeit als M.',
    '\nexists f:M\to\mathcal{P}(M)\text{ surjektiv};\qquad |M|<|\mathcal{P}(M)|',
    '\nexists f:M\to\mathcal{P}(M)\text{ surjektiv};\qquad |M|<|\mathcal{P}(M)|',
    'literature',
    @source_66,
    'Es gelten die üblichen Begriffe von Abbildung, Surjektivität, Teilmenge und Mächtigkeit.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    statement_text = VALUES(statement_text),
    statement_latex = VALUES(statement_latex),
    word_latex = VALUES(word_latex),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    assumptions = VALUES(assumptions),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

SET @theorem_id := (
    SELECT theorem_id
    FROM theorems
    WHERE theorem_number = '3.2.1'
    LIMIT 1
);

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.1-P',
    @section_id,
    @theorem_id,
    'Diagonalbeweis zu Cantors Satz',
    'Angenommen, es existiere eine surjektive Abbildung f von M auf P(M). Es sei D die Menge aller x aus M, für die x nicht Element von f(x) ist. Wegen D ⊆ M gilt D ∈ P(M). Aus der angenommenen Surjektivität folgt ein d ∈ M mit f(d)=D. Dann gilt d ∈ D genau dann, wenn d ∉ f(d), also genau dann, wenn d ∉ D. Dieser Widerspruch widerlegt die angenommene Surjektivität.',
    'D=\{x\in M\mid x\notin f(x)\},\qquad d\in D\iff d\notin f(d)\iff d\notin D',
    'contradiction',
    'adapted',
    @source_66,
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM proofs
    WHERE proof_number = '3.2.1-P'
);

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.149) bis (3.158)
-- ---------------------------------------------------------------------

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.149', @section_id, 'Elementbeziehung',
    'x \in M',
    'x \in M',
    'x ist Element der Menge M.',
    'definition', 'adapted', @source_72,
    NULL,
    'M ist eine Menge; x ist ein möglicher Gegenstand der Elementbeziehung.',
    'checked', @revision_id
),
(
    '3.150', @section_id, 'Negierte Elementbeziehung',
    'x \notin M',
    'x \notin M',
    'x ist kein Element der Menge M.',
    'definition', 'adapted', @source_72,
    NULL,
    'M ist eine Menge; x ist ein möglicher Gegenstand der Elementbeziehung.',
    'checked', @revision_id
),
(
    '3.151', @section_id, 'Extensionalitätsprinzip',
    'A=B \iff \forall x\,(x\in A \leftrightarrow x\in B)',
    'A=B \iff \forall x\,(x\in A \leftrightarrow x\in B)',
    'Zwei Mengen sind genau dann gleich, wenn sie dieselben Elemente besitzen.',
    'axiom', 'literature', @source_68,
    'Formale Darstellung des Extensionalitätsaxioms.',
    'A und B sind Mengen im zugrunde gelegten Axiomensystem.',
    'checked', @revision_id
),
(
    '3.152', @section_id, 'Teilmengenrelation',
    'A\subseteq B \iff \forall x\,(x\in A\rightarrow x\in B)',
    'A\subseteq B \iff \forall x\,(x\in A\rightarrow x\in B)',
    'A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.',
    'definition', 'adapted', @source_72,
    NULL,
    'A und B sind Mengen.',
    'checked', @revision_id
),
(
    '3.153', @section_id, 'Potenzmenge',
    '\mathcal{P}(M)=\{A\mid A\subseteq M\}',
    '\mathcal{P}(M)=\{A\mid A\subseteq M\}',
    'Die Potenzmenge von M besteht aus sämtlichen Teilmengen von M.',
    'definition', 'adapted', @source_66,
    NULL,
    'M ist eine Menge.',
    'checked', @revision_id
),
(
    '3.154', @section_id, 'Mächtigkeit der Potenzmenge',
    '|M|<|\mathcal{P}(M)|',
    '|M|<|\mathcal{P}(M)|',
    'Die Potenzmenge besitzt eine strikt größere Mächtigkeit als die Ausgangsmenge.',
    'theorem', 'literature', @source_66,
    'Folgerung aus Cantors Diagonalargument.',
    'Die Mächtigkeit wird über Bijektionen beziehungsweise Injektionen verglichen.',
    'checked', @revision_id
),
(
    '3.155', @section_id, 'Diagonalmenge',
    'D=\{x\in M\mid x\notin f(x)\}',
    'D=\{x\in M\mid x\notin f(x)\}',
    'D enthält genau diejenigen Elemente x aus M, die nicht Element ihres Bildes f(x) sind.',
    'derived', 'adapted', @source_66,
    'Konstruktion innerhalb des Widerspruchsbeweises zu Cantors Satz.',
    'Es wird vorübergehend eine surjektive Abbildung f von M nach P(M) angenommen.',
    'checked', @revision_id
),
(
    '3.156', @section_id, 'Widerspruch des Diagonalarguments',
    'd\in D \iff d\notin f(d) \iff d\notin D',
    'd\in D \iff d\notin f(d) \iff d\notin D',
    'Für das Element d mit f(d)=D entsteht der Widerspruch, dass d genau dann Element von D ist, wenn d nicht Element von D ist.',
    'derived', 'adapted', @source_66,
    'Aus der Definition der Diagonalmenge und der angenommenen Surjektivität.',
    'f(d)=D.',
    'checked', @revision_id
),
(
    '3.157', @section_id, 'Kuratowski-Paar',
    '(a,b)=\{\{a\},\{a,b\}\}',
    '(a,b)=\{\{a\},\{a,b\}\}',
    'Das geordnete Paar wird ausschließlich durch Mengen konstruiert.',
    'definition', 'literature', @source_71,
    NULL,
    'a und b sind beliebige mengentheoretisch darstellbare Gegenstände.',
    'checked', @revision_id
),
(
    '3.158', @section_id, 'Kartesisches Produkt',
    'A\times B=\{(a,b)\mid a\in A\land b\in B\}',
    'A\times B=\{(a,b)\mid a\in A\land b\in B\}',
    'Das kartesische Produkt enthält sämtliche geordneten Paare mit erster Komponente aus A und zweiter Komponente aus B.',
    'definition', 'adapted', @source_72,
    NULL,
    'A und B sind Mengen; geordnete Paare sind definiert.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    equation_latex = VALUES(equation_latex),
    word_latex = VALUES(word_latex),
    plain_description = VALUES(plain_description),
    equation_type = VALUES(equation_type),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    derivation = VALUES(derivation),
    assumptions = VALUES(assumptions),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

-- ---------------------------------------------------------------------
-- 11. Gleichungssymbole
-- ---------------------------------------------------------------------

SET @eq_149 := (SELECT equation_id FROM equations WHERE equation_number = '3.149' LIMIT 1);
SET @eq_150 := (SELECT equation_id FROM equations WHERE equation_number = '3.150' LIMIT 1);
SET @eq_151 := (SELECT equation_id FROM equations WHERE equation_number = '3.151' LIMIT 1);
SET @eq_152 := (SELECT equation_id FROM equations WHERE equation_number = '3.152' LIMIT 1);
SET @eq_153 := (SELECT equation_id FROM equations WHERE equation_number = '3.153' LIMIT 1);
SET @eq_154 := (SELECT equation_id FROM equations WHERE equation_number = '3.154' LIMIT 1);
SET @eq_155 := (SELECT equation_id FROM equations WHERE equation_number = '3.155' LIMIT 1);
SET @eq_156 := (SELECT equation_id FROM equations WHERE equation_number = '3.156' LIMIT 1);
SET @eq_157 := (SELECT equation_id FROM equations WHERE equation_number = '3.157' LIMIT 1);
SET @eq_158 := (SELECT equation_id FROM equations WHERE equation_number = '3.158' LIMIT 1);

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
VALUES
(@eq_149, 'x', 'Element x', 'Möglicher Gegenstand der Elementbeziehung.', NULL, 'Beliebiges mengentheoretisches Objekt', 1),
(@eq_149, 'M', 'Menge M', 'Mengentheoretischer Träger.', NULL, 'Menge', 2),
(@eq_149, '\in', 'Elementrelation', 'Bezeichnet die Zugehörigkeit eines Elements zu einer Menge.', NULL, 'Binäre Relation', 3),

(@eq_150, 'x', 'Element x', 'Möglicher Gegenstand der negierten Elementbeziehung.', NULL, 'Beliebiges mengentheoretisches Objekt', 1),
(@eq_150, 'M', 'Menge M', 'Mengentheoretischer Träger.', NULL, 'Menge', 2),
(@eq_150, '\notin', 'Negierte Elementrelation', 'Bezeichnet die Nichtzugehörigkeit eines Gegenstands zu einer Menge.', NULL, 'Negierte binäre Relation', 3),

(@eq_151, 'A', 'Menge A', 'Erste der auf Gleichheit geprüften Mengen.', NULL, 'Menge', 1),
(@eq_151, 'B', 'Menge B', 'Zweite der auf Gleichheit geprüften Mengen.', NULL, 'Menge', 2),
(@eq_151, 'x', 'Elementvariable', 'Beliebiges Element, über das quantifiziert wird.', NULL, 'Beliebiges mengentheoretisches Objekt', 3),

(@eq_152, 'A', 'Teilmenge A', 'Menge, deren Elemente auf Zugehörigkeit zu B geprüft werden.', NULL, 'Menge', 1),
(@eq_152, 'B', 'Obermenge B', 'Menge, die alle Elemente von A enthält.', NULL, 'Menge', 2),
(@eq_152, '\subseteq', 'Teilmengenrelation', 'Bezeichnet die inklusive Teilmengenbeziehung.', NULL, 'Binäre Relation auf Mengen', 3),

(@eq_153, '\mathcal{P}(M)', 'Potenzmenge von M', 'Menge sämtlicher Teilmengen von M.', NULL, 'Menge von Mengen', 1),
(@eq_153, 'A', 'Teilmenge A', 'Beliebige Teilmenge der Ausgangsmenge M.', NULL, 'Teilmenge von M', 2),

(@eq_154, '|M|', 'Mächtigkeit von M', 'Kardinalität der Ausgangsmenge M.', NULL, 'Kardinalzahl', 1),
(@eq_154, '|\mathcal{P}(M)|', 'Mächtigkeit der Potenzmenge', 'Kardinalität der Potenzmenge von M.', NULL, 'Kardinalzahl', 2),

(@eq_155, 'D', 'Diagonalmenge', 'Menge der Elemente, die nicht in ihrem jeweiligen Bild unter f enthalten sind.', NULL, 'Teilmenge von M', 1),
(@eq_155, 'f', 'Abbildung f', 'Im Widerspruchsbeweis angenommene Abbildung von M nach P(M).', NULL, 'Abbildung M nach P(M)', 2),

(@eq_156, 'd', 'Diagonalelement d', 'Element mit f(d)=D, dessen Existenz aus der angenommenen Surjektivität folgt.', NULL, 'Element von M', 1),
(@eq_156, 'D', 'Diagonalmenge', 'Im Beweis konstruierte Teilmenge von M.', NULL, 'Teilmenge von M', 2),

(@eq_157, '(a,b)', 'Geordnetes Paar', 'Geordnetes Paar mit erster Komponente a und zweiter Komponente b.', NULL, 'Mengentheoretisch konstruiertes Paar', 1),
(@eq_157, 'a', 'Erste Komponente', 'Erstes Element des geordneten Paares.', NULL, 'Beliebiges mengentheoretisches Objekt', 2),
(@eq_157, 'b', 'Zweite Komponente', 'Zweites Element des geordneten Paares.', NULL, 'Beliebiges mengentheoretisches Objekt', 3),

(@eq_158, 'A\times B', 'Kartesisches Produkt', 'Menge sämtlicher geordneter Paare aus A und B.', NULL, 'Menge geordneter Paare', 1),
(@eq_158, '(a,b)', 'Geordnetes Paar', 'Paar mit a aus A und b aus B.', NULL, 'Element von A×B', 2)
ON DUPLICATE KEY UPDATE
    symbol_name = VALUES(symbol_name),
    definition_text = VALUES(definition_text),
    unit_text = VALUES(unit_text),
    domain_text = VALUES(domain_text),
    symbol_order = VALUES(symbol_order);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler aktualisieren
-- ---------------------------------------------------------------------

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('next_citation_number', '73')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 73 THEN '73'
        ELSE counter_value
    END;

-- ---------------------------------------------------------------------
-- 13. Änderungsprotokoll
-- ---------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'created', 'section',
    '3.2.1',
    'Abschnitt 3.2.1 wurde als mathematischer Forschungsstandsabschnitt vollständig angelegt und abgeschlossen.',
    NULL,
    'status=final; keine FRZK-Eigenaxiomatik'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'created'
      AND object_reference = '3.2.1'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources',
    '[66]-[72]',
    'Sieben neue Quellen zur Entwicklung, Axiomatisierung und strukturalen Verwendung der Mengenlehre wurden aufgenommen.',
    'next_citation_number=66',
    'next_citation_number=73'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'source_added'
      AND object_reference = '[66]-[72]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definitions',
    '3.2.1-3.2.3',
    'Definitionen von Menge und Elementbeziehung, Teilmenge und Potenzmenge wurden registriert.',
    NULL,
    '3 Definitionen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'definition_added'
      AND object_reference = '3.2.1-3.2.3'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'theorem',
    'Satz 3.2.1',
    'Cantors Satz wurde einschließlich des zugehörigen Diagonalbeweises registriert.',
    NULL,
    'theorem=checked; proof=checked'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'statement_added'
      AND object_reference = 'Satz 3.2.1'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations',
    '(3.149)-(3.158)',
    'Zehn Gleichungen einschließlich Word-LaTeX-Repräsentationen und Symbolzuordnungen wurden aufgenommen.',
    NULL,
    '10 Gleichungen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'equation_added'
      AND object_reference = '(3.149)-(3.158)'
);

-- ---------------------------------------------------------------------
-- 14. Validierungsergebnisse schreiben
-- ---------------------------------------------------------------------

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-SECTION-EXISTS',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.1 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code = '3.2.1'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-SOURCES',
    IF(COUNT(*) = 7, 'passed', 'failed'),
    '7',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.1 muss die sieben neuen Quellen [66] bis [72] verwenden.'
FROM source_usage su
JOIN sources s ON s.source_id = su.source_id
WHERE su.section_id = @section_id
  AND s.citation_number BETWEEN 66 AND 72
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-DEFINITIONS',
    IF(COUNT(*) = 3, 'passed', 'failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.1 muss drei Definitionen enthalten.'
FROM definitions
WHERE section_id = @section_id
  AND definition_number IN ('3.2.1','3.2.2','3.2.3')
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-THEOREM',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Cantors Satz muss genau einmal als Satz 3.2.1 registriert sein.'
FROM theorems
WHERE section_id = @section_id
  AND theorem_number = '3.2.1'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-PROOF',
    IF(COUNT(*) = 1, 'passed', 'failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Der Widerspruchsbeweis zu Cantors Satz muss genau einmal registriert sein.'
FROM proofs
WHERE section_id = @section_id
  AND proof_number = '3.2.1-P'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-EQUATIONS',
    IF(COUNT(*) = 10, 'passed', 'failed'),
    '10',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.149) bis (3.158) müssen vollständig registriert sein.'
FROM equations
WHERE section_id = @section_id
  AND equation_number IN
      ('3.149','3.150','3.151','3.152','3.153',
       '3.154','3.155','3.156','3.157','3.158')
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-WORD-LATEX',
    IF(COUNT(*) = 10, 'passed', 'failed'),
    '10',
    CAST(COUNT(*) AS CHAR),
    'Für alle zehn Gleichungen muss eine Word-LaTeX-Repräsentation vorhanden sein.'
FROM equations
WHERE section_id = @section_id
  AND equation_number IN
      ('3.149','3.150','3.151','3.152','3.153',
       '3.154','3.155','3.156','3.157','3.158')
  AND word_latex IS NOT NULL
  AND TRIM(word_latex) <> ''
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-PARENT-REVISION',
    IF(parent_revision_id = @parent_revision_id, 'passed', 'failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision 3.2.1 muss unmittelbar auf der Abschlussrevision 3.2.0 aufbauen.'
FROM repository_revisions
WHERE revision_id = @revision_id
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.1-NEXT-CITATION',
    IF(CAST(counter_value AS UNSIGNED) >= 73, 'passed', 'failed'),
    '>=73',
    counter_value,
    'Nach den Quellen [66] bis [72] muss die nächste freie Literaturziffer mindestens [73] sein.'
FROM repository_counters
WHERE counter_key = 'next_citation_number'
ON DUPLICATE KEY UPDATE
    validation_status = VALUES(validation_status),
    expected_value = VALUES(expected_value),
    actual_value = VALUES(actual_value),
    validation_message = VALUES(validation_message),
    checked_at = CURRENT_TIMESTAMP;

-- ---------------------------------------------------------------------
-- 15. Abschluss
-- ---------------------------------------------------------------------

COMMIT;

-- ---------------------------------------------------------------------
-- 16. Audit-Ausgabe
-- ---------------------------------------------------------------------

SELECT
    rr.revision_id,
    rr.revision_code,
    rr.scope_reference,
    rr.version_label,
    rr.parent_revision_id,
    rr.revision_date
FROM repository_revisions rr
WHERE rr.revision_code = 'RKB-NEU-K3.2.1-V1';

SELECT
    ds.section_id,
    ds.parent_section_id,
    ds.section_code,
    ds.title,
    ds.status,
    ds.is_original_contribution
FROM dissertation_sections ds
WHERE ds.section_code = '3.2.1';

SELECT
    s.citation_number,
    s.source_key,
    s.short_citation_text,
    s.verification_status
FROM sources s
WHERE s.citation_number BETWEEN 66 AND 72
ORDER BY s.citation_number;

SELECT
    d.definition_number,
    d.title,
    d.validation_status
FROM definitions d
WHERE d.section_id = @section_id
ORDER BY d.definition_number;

SELECT
    t.theorem_number,
    t.title,
    t.validation_status
FROM theorems t
WHERE t.section_id = @section_id;

SELECT
    p.proof_number,
    p.title,
    p.proof_method,
    p.validation_status
FROM proofs p
WHERE p.section_id = @section_id;

SELECT
    e.equation_number,
    e.title,
    e.equation_type,
    e.validation_status
FROM equations e
WHERE e.section_id = @section_id
ORDER BY CAST(SUBSTRING_INDEX(e.equation_number, '.', -1) AS UNSIGNED);

SELECT
    rvr.validation_code,
    rvr.validation_status,
    rvr.expected_value,
    rvr.actual_value,
    rvr.validation_message
FROM repository_validation_results rvr
WHERE rvr.revision_id = @revision_id
ORDER BY rvr.validation_code;
