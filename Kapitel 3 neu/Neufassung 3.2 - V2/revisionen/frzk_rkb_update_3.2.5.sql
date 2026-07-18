-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschluss von Abschnitt 3.2.5
-- Abschnitt: 3.2.5 Funktionen und Abbildungen als formale Beschreibung
--             eindeutiger Zuordnungen
-- Grundlage: frzk_rkb_update_3.2.4.sql
--
-- Neue Quellen: [83]–[84]
-- Wiederverwendete Quelle: [72]
-- Definitionen: 3.2.32–3.2.38
-- Sätze: 3.2.6–3.2.7
-- Beweise: 3.2.6-P, 3.2.7-P
-- Gleichungen: (3.232)–(3.246)
-- Nächste freie Literaturziffer: [85]
--
-- Idempotent für das Repository-Schema aus frzk_rkb(3).sql.
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Ausgangsstand
-- ---------------------------------------------------------------------

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.4-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

SELECT CASE
    WHEN @parent_revision_id IS NULL
        THEN 'FEHLER: Revision RKB-NEU-K3.2.4-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach 3.2.4 vorhanden.'
END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Revision
-- ---------------------------------------------------------------------

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.2.5-V1',
    NOW(),
    'section',
    '3.2.5',
    '1.0',
    'Abschluss von Abschnitt 3.2.5. Registriert werden die Quellen [83] und [84], die Wiederverwendung von [72], die Definitionen 3.2.32 bis 3.2.38, die Sätze 3.2.6 und 3.2.7 mit Beweisen sowie die Gleichungen (3.232) bis (3.246).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.5-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.5-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Abschnitt
-- ---------------------------------------------------------------------

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_section_id,
    '3.2.5',
    'Funktionen und Abbildungen als formale Beschreibung eindeutiger Zuordnungen',
    3,
    3.2500,
    'final',
    0,
    'Der Abschnitt rekonstruiert Funktionen als eindeutige Relationen zwischen Mengen. Behandelt werden Definitions- und Zielbereich, Bildmenge, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung. Die Darstellung bleibt mathematischer Forschungsstand.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.5'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Funktionen und Abbildungen als formale Beschreibung eindeutiger Zuordnungen',
    chapter_no = 3,
    section_order = 3.2500,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt rekonstruiert Funktionen als eindeutige Relationen zwischen Mengen. Behandelt werden Definitions- und Zielbereich, Bildmenge, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung. Die Darstellung bleibt mathematischer Forschungsstand.'
WHERE section_code = '3.2.5';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.5'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren
-- ---------------------------------------------------------------------

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Euler', 'Leonhard', 'Euler, Leonhard', 1707, 1783, 'Autor der Quelle [83].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors WHERE normalized_name = 'Euler, Leonhard'
);

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Dirichlet', 'Peter Gustav Lejeune', 'Dirichlet, Peter Gustav Lejeune',
       1805, 1859, 'Autor der Quelle [84].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Dirichlet, Peter Gustav Lejeune'
);

SET @author_euler := (
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Euler, Leonhard'
    LIMIT 1
);

SET @author_dirichlet := (
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Dirichlet, Peter Gustav Lejeune'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen
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
SELECT
    83,
    'euler_introductio_analysin_infinitorum_1748',
    'historical_work',
    'Introductio in analysin infinitorum',
    NULL,
    1748,
    1748,
    NULL,
    'Marc-Michel Bousquet',
    'Lausanne',
    NULL,
    NULL,
    NULL,
    'Erstausgabe',
    NULL,
    NULL,
    NULL,
    'la',
    1,
    'historical',
    8,
    'verified',
    '3.2.5',
    'Erstnennung zur historischen Entwicklung des Funktionsbegriffs.',
    'Euler, Leonhard (1748): Introductio in analysin infinitorum. Lausanne: Marc-Michel Bousquet.',
    'Euler (1748)',
    'Historische Primärquelle zum frühen analytischen Funktionsbegriff.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number = 83
       OR source_key = 'euler_introductio_analysin_infinitorum_1748'
);

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
SELECT
    84,
    'dirichlet_darstellung_willkuerlicher_funktionen_1829',
    'historical_work',
    'Über die Darstellung ganz willkürlicher Funktionen durch Sinus- und Cosinusreihen',
    NULL,
    1829,
    1829,
    NULL,
    NULL,
    'Berlin',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'historical',
    9,
    'partially_verified',
    '3.2.5',
    'Erstnennung zur Loslösung des Funktionsbegriffs von einer konkreten analytischen Formel.',
    'Dirichlet, Peter Gustav Lejeune (1829): Über die Darstellung ganz willkürlicher Funktionen durch Sinus- und Cosinusreihen. Berlin.',
    'Dirichlet (1829)',
    'Historische Primärquelle zum allgemeinen Zuordnungsbegriff.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number = 84
       OR source_key = 'dirichlet_darstellung_willkuerlicher_funktionen_1829'
);

SET @source_72 := (
    SELECT source_id FROM sources
    WHERE citation_number = 72
    LIMIT 1
);

SET @source_83 := (
    SELECT source_id FROM sources
    WHERE source_key = 'euler_introductio_analysin_infinitorum_1748'
       OR citation_number = 83
    ORDER BY (source_key = 'euler_introductio_analysin_infinitorum_1748') DESC
    LIMIT 1
);

SET @source_84 := (
    SELECT source_id FROM sources
    WHERE source_key = 'dirichlet_darstellung_willkuerlicher_funktionen_1829'
       OR citation_number = 84
    ORDER BY (source_key = 'dirichlet_darstellung_willkuerlicher_funktionen_1829') DESC
    LIMIT 1
);

INSERT IGNORE INTO source_authors
(source_id, author_id, author_order, role)
VALUES
(@source_83, @author_euler, 1, 'author'),
(@source_84, @author_dirichlet, 1, 'author');

-- ---------------------------------------------------------------------
-- 6. Quellenverwendung
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_83,
    @section_id,
    'first_citation',
    'Historische Einordnung des frühen analytischen Funktionsbegriffs.',
    'Abschnitt 3.2.5, historische Einführung',
    1,
    1,
    'Erstnennung als Quelle [83].',
    @revision_id
WHERE @source_83 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_83
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_84,
    @section_id,
    'first_citation',
    'Historische Verallgemeinerung des Funktionsbegriffs zu einer eindeutigen Zuordnung.',
    'Abschnitt 3.2.5, historische Einführung',
    1,
    1,
    'Erstnennung als Quelle [84].',
    @revision_id
WHERE @source_84 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_84
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_72,
    @section_id,
    'definition',
    'Mengentheoretische Definition von Funktionen als eindeutige Relationen zwischen Mengen.',
    'Abschnitt 3.2.5, Definitionen 3.2.32 bis 3.2.38',
    0,
    1,
    'Wiederverwendung der Quelle [72].',
    @revision_id
WHERE @source_72 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_72
        AND section_id = @section_id
        AND usage_type = 'definition'
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.32–3.2.38
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
VALUES
(
    '3.2.32', @section_id, 'Funktion',
    'Eine Funktion f:A→B ist eine Relation f⊆A×B, die jedem Element a∈A genau ein Element b∈B zuordnet.',
    'f:A\rightarrow B,\qquad\forall a\in A\;\exists!\,b\in B:(a,b)\in f',
    'f:A\rightarrow B,\qquad\forall a\in A\;\exists!\,b\in B:(a,b)\in f',
    'adapted', @source_72,
    'A und B sind Mengen.',
    'Mengentheoretische Definition einer eindeutigen Zuordnung.',
    'checked', @revision_id
),
(
    '3.2.33', @section_id, 'Bildmenge',
    'Die Bildmenge f(A) besteht aus allen Elementen des Zielbereichs, die von mindestens einem Element des Definitionsbereichs angenommen werden.',
    'f(A)=\{f(a)\mid a\in A\}',
    'f(A)=\{f(a)\mid a\in A\}',
    'adapted', @source_72,
    'f:A→B ist eine Funktion.',
    'Die Bildmenge ist im Allgemeinen nur eine Teilmenge des Zielbereichs.',
    'checked', @revision_id
),
(
    '3.2.34', @section_id, 'Injektivität',
    'Eine Funktion ist injektiv, wenn gleiche Funktionswerte nur von gleichen Argumenten erzeugt werden.',
    'f(a_1)=f(a_2)\Longrightarrow a_1=a_2',
    'f(a_1)=f(a_2)\Longrightarrow a_1=a_2',
    'adapted', @source_72,
    'f:A→B ist eine Funktion.',
    'Verschiedene Elemente des Definitionsbereichs besitzen verschiedene Bilder.',
    'checked', @revision_id
),
(
    '3.2.35', @section_id, 'Surjektivität',
    'Eine Funktion ist surjektiv, wenn jedes Element des Zielbereichs mindestens ein Urbild besitzt.',
    '\forall b\in B\;\exists a\in A:f(a)=b',
    '\forall b\in B\;\exists a\in A:f(a)=b',
    'adapted', @source_72,
    'f:A→B ist eine Funktion.',
    'Für eine surjektive Funktion gilt f(A)=B.',
    'checked', @revision_id
),
(
    '3.2.36', @section_id, 'Bijektivität',
    'Eine Funktion ist bijektiv, wenn sie zugleich injektiv und surjektiv ist.',
    'f\text{ bijektiv}\Longleftrightarrow f\text{ injektiv und surjektiv}',
    'f\text{ bijektiv}\Longleftrightarrow f\text{ injektiv und surjektiv}',
    'adapted', @source_72,
    'f:A→B ist eine Funktion.',
    'Bijektivität ist die Voraussetzung für eine eindeutige Umkehrfunktion.',
    'checked', @revision_id
),
(
    '3.2.37', @section_id, 'Funktionskomposition',
    'Für f:A→B und g:B→C ist die Komposition g∘f:A→C durch (g∘f)(a)=g(f(a)) definiert.',
    '(g\circ f)(a)=g(f(a))',
    '(g\circ f)(a)=g(f(a))',
    'adapted', @source_72,
    'Der Zielbereich von f entspricht dem Definitionsbereich von g.',
    'Die Komposition beschreibt eine Folge eindeutiger Transformationen.',
    'checked', @revision_id
),
(
    '3.2.38', @section_id, 'Identitätsabbildung',
    'Die Identitätsabbildung id_A:A→A ordnet jedem Element a∈A sich selbst zu.',
    '\operatorname{id}_A(a)=a',
    '\operatorname{id}_A(a)=a',
    'adapted', @source_72,
    'A ist eine Menge.',
    'Die Identität wirkt bezüglich der Funktionskomposition neutral.',
    'checked', @revision_id
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
-- 8. Sätze
-- ---------------------------------------------------------------------

INSERT INTO theorems
(
    theorem_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.2.6',
    @section_id,
    'Existenz der Umkehrfunktion',
    'Eine Funktion besitzt genau dann eine Umkehrfunktion, wenn sie bijektiv ist.',
    'f^{-1}\text{ existiert}\Longleftrightarrow f\text{ ist bijektiv}',
    'f^{-1}\text{ existiert}\Longleftrightarrow f\text{ ist bijektiv}',
    'literature',
    @source_72,
    'f:A→B ist eine Funktion.',
    'checked',
    @revision_id
),
(
    '3.2.7',
    @section_id,
    'Assoziativität der Funktionskomposition',
    'Für kompatibel definierte Funktionen f, g und h gilt h∘(g∘f)=(h∘g)∘f.',
    'h\circ(g\circ f)=(h\circ g)\circ f',
    'h\circ(g\circ f)=(h\circ g)\circ f',
    'literature',
    @source_72,
    'f:A→B, g:B→C und h:C→D sind Funktionen.',
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

SET @theorem_326 := (
    SELECT theorem_id
    FROM theorems
    WHERE theorem_number = '3.2.6'
    LIMIT 1
);

SET @theorem_327 := (
    SELECT theorem_id
    FROM theorems
    WHERE theorem_number = '3.2.7'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 9. Beweise
-- ---------------------------------------------------------------------

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.6-P',
    @section_id,
    @theorem_326,
    'Beweis zur Existenz der Umkehrfunktion',
    'Ist f bijektiv, besitzt jedes b∈B genau ein Urbild a∈A. Die Zuordnung b↦a ist daher eindeutig und definiert f^{-1}. Existiert umgekehrt f^{-1}, kann kein b ohne Urbild bleiben und kein b zwei verschiedene Urbilder besitzen. Somit ist f surjektiv und injektiv, also bijektiv.',
    'f^{-1}\text{ existiert}\Longleftrightarrow f\text{ ist bijektiv}',
    'equivalence',
    'adapted',
    @source_72,
    'checked',
    @revision_id
WHERE @theorem_326 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number = '3.2.6-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.7-P',
    @section_id,
    @theorem_327,
    'Beweis der Assoziativität der Funktionskomposition',
    'Für jedes a∈A gilt [h∘(g∘f)](a)=h(g(f(a)))=[(h∘g)∘f](a). Da beide Kompositionen für jedes Argument denselben Wert liefern, sind sie als Funktionen identisch.',
    '[h\circ(g\circ f)](a)=h(g(f(a)))=[(h\circ g)\circ f](a)',
    'direct',
    'adapted',
    @source_72,
    'checked',
    @revision_id
WHERE @theorem_327 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs WHERE proof_number = '3.2.7-P'
  );

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.232)–(3.246)
-- ---------------------------------------------------------------------

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
VALUES
('3.232', @section_id, 'Funktion zwischen zwei Mengen',
 'f:A\rightarrow B',
 'f:A\rightarrow B',
 'Die Funktion f bildet Elemente aus A in den Zielbereich B ab.',
 'definition', 'adapted', @source_72, NULL,
 'A und B sind Mengen.', 'checked', @revision_id),

('3.233', @section_id, 'Funktion als Relation',
 'f\subseteq A\times B',
 'f\subseteq A\times B',
 'Eine Funktion ist eine Teilmenge des kartesischen Produkts.',
 'definition', 'adapted', @source_72, NULL,
 'A und B sind Mengen.', 'checked', @revision_id),

('3.234', @section_id, 'Eindeutigkeitsbedingung',
 '\forall a\in A\;\exists!\,b\in B:(a,b)\in f',
 '\forall a\in A\;\exists!\,b\in B:(a,b)\in f',
 'Jedem Element aus A wird genau ein Element aus B zugeordnet.',
 'definition', 'adapted', @source_72, NULL,
 'f ist eine funktionale Relation.', 'checked', @revision_id),

('3.235', @section_id, 'Bildmenge',
 'f(A)=\{f(a)\mid a\in A\}',
 'f(A)=\{f(a)\mid a\in A\}',
 'Die Bildmenge enthält alle tatsächlich angenommenen Funktionswerte.',
 'definition', 'adapted', @source_72, NULL,
 'f:A→B ist eine Funktion.', 'checked', @revision_id),

('3.236', @section_id, 'Bildmenge als Teilmenge',
 'f(A)\subseteq B',
 'f(A)\subseteq B',
 'Die Bildmenge liegt innerhalb des Zielbereichs.',
 'definition', 'adapted', @source_72, NULL,
 'f:A→B ist eine Funktion.', 'checked', @revision_id),

('3.237', @section_id, 'Injektivität',
 'f(a_1)=f(a_2)\Longrightarrow a_1=a_2',
 'f(a_1)=f(a_2)\Longrightarrow a_1=a_2',
 'Gleiche Bilder setzen bei einer injektiven Funktion gleiche Argumente voraus.',
 'definition', 'adapted', @source_72, NULL,
 'a_1,a_2∈A.', 'checked', @revision_id),

('3.238', @section_id, 'Surjektivität',
 '\forall b\in B\;\exists a\in A:f(a)=b',
 '\forall b\in B\;\exists a\in A:f(a)=b',
 'Jedes Element des Zielbereichs wird von mindestens einem Argument getroffen.',
 'definition', 'adapted', @source_72, NULL,
 'f:A→B ist eine Funktion.', 'checked', @revision_id),

('3.239', @section_id, 'Umkehrfunktion',
 'f^{-1}:B\rightarrow A',
 'f^{-1}:B\rightarrow A',
 'Die Umkehrfunktion bildet Zielwerte auf ihre eindeutigen Urbilder ab.',
 'definition', 'adapted', @source_72, NULL,
 'f ist bijektiv.', 'checked', @revision_id),

('3.240', @section_id, 'Linke Umkehridentität',
 'f^{-1}(f(a))=a',
 'f^{-1}(f(a))=a',
 'Die Umkehrfunktion hebt die Wirkung von f auf Elementen aus A auf.',
 'theorem', 'adapted', @source_72, NULL,
 'f ist bijektiv und a∈A.', 'checked', @revision_id),

('3.241', @section_id, 'Rechte Umkehridentität',
 'f(f^{-1}(b))=b',
 'f(f^{-1}(b))=b',
 'Die Funktion hebt die Wirkung ihrer Umkehrfunktion auf Elementen aus B auf.',
 'theorem', 'adapted', @source_72, NULL,
 'f ist bijektiv und b∈B.', 'checked', @revision_id),

('3.242', @section_id, 'Komposition zweier Funktionen',
 'g\circ f:A\rightarrow C',
 'g\circ f:A\rightarrow C',
 'Die Komposition bildet A über B nach C ab.',
 'definition', 'adapted', @source_72, NULL,
 'f:A→B und g:B→C.', 'checked', @revision_id),

('3.243', @section_id, 'Auswertung einer Funktionskomposition',
 '(g\circ f)(a)=g(f(a))',
 '(g\circ f)(a)=g(f(a))',
 'Zuerst wird f und anschließend g ausgewertet.',
 'definition', 'adapted', @source_72, NULL,
 'a∈A.', 'checked', @revision_id),

('3.244', @section_id, 'Assoziativität der Funktionskomposition',
 'h\circ(g\circ f)=(h\circ g)\circ f',
 'h\circ(g\circ f)=(h\circ g)\circ f',
 'Die Klammerung kompatibler Funktionskompositionen verändert das Ergebnis nicht.',
 'theorem', 'literature', @source_72,
 'Beide Seiten liefern für jedes a∈A den Wert h(g(f(a))).',
 'f:A→B, g:B→C und h:C→D.', 'checked', @revision_id),

('3.245', @section_id, 'Identitätsabbildung',
 '\operatorname{id}_A(a)=a',
 '\operatorname{id}_A(a)=a',
 'Die Identitätsabbildung lässt jedes Element unverändert.',
 'definition', 'adapted', @source_72, NULL,
 'a∈A.', 'checked', @revision_id),

('3.246', @section_id, 'Neutralität der Identitätsabbildung',
 'f\circ\operatorname{id}_A=f=\operatorname{id}_B\circ f',
 'f\circ\operatorname{id}_A=f=\operatorname{id}_B\circ f',
 'Die Identität ist das neutrale Element der Funktionskomposition.',
 'theorem', 'adapted', @source_72, NULL,
 'f:A→B ist eine Funktion.', 'checked', @revision_id)

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

SET @eq_232 := (SELECT equation_id FROM equations WHERE equation_number='3.232' LIMIT 1);
SET @eq_234 := (SELECT equation_id FROM equations WHERE equation_number='3.234' LIMIT 1);
SET @eq_235 := (SELECT equation_id FROM equations WHERE equation_number='3.235' LIMIT 1);
SET @eq_237 := (SELECT equation_id FROM equations WHERE equation_number='3.237' LIMIT 1);
SET @eq_238 := (SELECT equation_id FROM equations WHERE equation_number='3.238' LIMIT 1);
SET @eq_239 := (SELECT equation_id FROM equations WHERE equation_number='3.239' LIMIT 1);
SET @eq_242 := (SELECT equation_id FROM equations WHERE equation_number='3.242' LIMIT 1);
SET @eq_245 := (SELECT equation_id FROM equations WHERE equation_number='3.245' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
VALUES
(@eq_232, 'f', 'Funktion', 'Eindeutige Zuordnung von A nach B.', NULL, 'Abbildung', 1),
(@eq_232, 'A', 'Definitionsbereich', 'Menge aller zulässigen Argumente.', NULL, 'Menge', 2),
(@eq_232, 'B', 'Zielbereich', 'Menge aller zulässigen Funktionswerte.', NULL, 'Menge', 3),

(@eq_234, '\exists!', 'Eindeutiger Existenzquantor', 'Es existiert genau ein Element mit der angegebenen Eigenschaft.', NULL, 'Logischer Operator', 1),

(@eq_235, 'f(A)', 'Bildmenge', 'Menge aller von f tatsächlich angenommenen Werte.', NULL, 'Teilmenge von B', 1),

(@eq_237, 'a_1', 'Erstes Argument', 'Element des Definitionsbereichs.', NULL, 'Element von A', 1),
(@eq_237, 'a_2', 'Zweites Argument', 'Element des Definitionsbereichs.', NULL, 'Element von A', 2),

(@eq_238, 'b', 'Zielwert', 'Beliebiges Element des Zielbereichs.', NULL, 'Element von B', 1),

(@eq_239, 'f^{-1}', 'Umkehrfunktion', 'Eindeutige inverse Abbildung zu f.', NULL, 'Abbildung B→A', 1),

(@eq_242, 'g\circ f', 'Funktionskomposition', 'Verkettung der Funktionen f und g.', NULL, 'Abbildung A→C', 1),

(@eq_245, '\operatorname{id}_A', 'Identitätsabbildung', 'Abbildung, die jedes Element auf sich selbst abbildet.', NULL, 'Abbildung A→A', 1);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES ('next_citation_number', '85')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 85 THEN '85'
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
    @revision_id, @section_id, 'created', 'section', '3.2.5',
    'Abschnitt 3.2.5 wurde vollständig angelegt und repositoryseitig abgeschlossen.',
    NULL, 'status=final'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.2.5'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources', '[83]-[84]',
    'Zwei historische Quellen zur Entwicklung des Funktionsbegriffs wurden aufgenommen.',
    'next_citation_number=83', 'next_citation_number=85'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_added'
      AND object_reference='[83]-[84]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_reused', 'source', '[72]',
    'Bourbaki wurde für die mengentheoretische Definition von Funktionen wiederverwendet.',
    NULL, 'source_usage registriert'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_reused'
      AND object_reference='[72]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definitions',
    '3.2.32-3.2.38',
    'Sieben Definitionen zu Funktionen, Bildmengen, Abbildungseigenschaften, Komposition und Identität wurden registriert.',
    NULL, '7 Definitionen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='definition_added'
      AND object_reference='3.2.32-3.2.38'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'theorems',
    '3.2.6-3.2.7',
    'Zwei Sätze zur Umkehrfunktion und zur Assoziativität der Komposition wurden registriert.',
    NULL, '2 Sätze'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='statement_added'
      AND object_reference='3.2.6-3.2.7'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'proof_added', 'proofs',
    '3.2.6-P;3.2.7-P',
    'Zu beiden Sätzen wurden Beweise aufgenommen.',
    NULL, '2 Beweise'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='proof_added'
      AND object_reference='3.2.6-P;3.2.7-P'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations',
    '(3.232)-(3.246)',
    'Fünfzehn Gleichungen einschließlich Word-LaTeX wurden aufgenommen.',
    NULL, '15 Gleichungen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='(3.232)-(3.246)'
);

-- ---------------------------------------------------------------------
-- 14. Validierungen
-- ---------------------------------------------------------------------

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-SECTION',
    IF(COUNT(*)=1,'passed','failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.5 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code='3.2.5'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-NEW-SOURCES',
    IF(COUNT(*)=2,'passed','failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [83] und [84] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (83,84)
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-SOURCE-USAGE',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [72], [83] und [84] müssen mit Abschnitt 3.2.5 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (72,83,84)
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-DEFINITIONS',
    IF(COUNT(*)=7,'passed','failed'),
    '7',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.32 bis 3.2.38 müssen vollständig registriert sein.'
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.32','3.2.33','3.2.34','3.2.35',
       '3.2.36','3.2.37','3.2.38')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-THEOREMS',
    IF(COUNT(*)=2,'passed','failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.6 und 3.2.7 müssen vollständig registriert sein.'
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN ('3.2.6','3.2.7')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-PROOFS',
    IF(COUNT(*)=2,'passed','failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Zu den Sätzen müssen zwei Beweise vorhanden sein.'
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN ('3.2.6-P','3.2.7-P')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-EQUATIONS',
    IF(COUNT(*)=15,'passed','failed'),
    '15',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.232) bis (3.246) müssen vollständig registriert sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 232 AND 246
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-WORD-LATEX',
    IF(COUNT(*)=15,'passed','failed'),
    '15',
    CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 232 AND 246
  AND word_latex IS NOT NULL
  AND TRIM(word_latex)<>''
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-PARENT-REVISION',
    IF(parent_revision_id=@parent_revision_id,'passed','failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision 3.2.5 muss unmittelbar auf der Revision 3.2.4 aufbauen.'
FROM repository_revisions
WHERE revision_id=@revision_id
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.5-NEXT-CITATION',
    IF(CAST(counter_value AS UNSIGNED)>=85,'passed','failed'),
    '>=85',
    counter_value,
    'Nach Quelle [84] muss die nächste freie Literaturziffer mindestens [85] sein.'
FROM repository_counters
WHERE counter_key='next_citation_number'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

COMMIT;

-- ---------------------------------------------------------------------
-- 15. Audit-Ausgabe
-- ---------------------------------------------------------------------

SELECT revision_id, revision_code, scope_reference, version_label,
       parent_revision_id, revision_date
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.5-V1';

SELECT section_id, parent_section_id, section_code, title,
       status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.2.5';

SELECT citation_number, source_key, short_citation_text,
       verification_status
FROM sources
WHERE citation_number IN (83,84)
ORDER BY citation_number;

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED);

SELECT theorem_number, title, validation_status
FROM theorems
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=@section_id
ORDER BY proof_number;

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT validation_code, validation_status, expected_value,
       actual_value, validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
