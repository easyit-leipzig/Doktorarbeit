-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschluss von Abschnitt 3.2.3
-- Abschnitt: 3.2.3 Algebraische Strukturen als Träger mathematischer Operationen
-- Grundlage: frzk_rkb_update_3.2.2.sql / importierter Stand nach 3.2.2
-- Zielsystem: MariaDB 10.4 / MySQL-kompatibel
--
-- Neue Quellen: [76]–[78]
-- Wiederverwendete Quelle: [72] Bourbaki
-- Definitionen: 3.2.14–3.2.21
-- Gleichungen: (3.193)–(3.202)
-- Nächste freie Literaturziffer: [79]
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
    WHERE revision_code = 'RKB-NEU-K3.2.2-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

SELECT
    CASE
        WHEN @parent_revision_id IS NULL
            THEN 'FEHLER: Revision RKB-NEU-K3.2.2-V1 fehlt.'
        WHEN @chapter_section_id IS NULL
            THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
        ELSE 'OK: Ausgangsstand nach 3.2.2 vorhanden.'
    END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Repository-Revision anlegen
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
    'RKB-NEU-K3.2.3-V1',
    NOW(),
    'section',
    '3.2.3',
    '1.0',
    'Abschluss von Abschnitt 3.2.3 Algebraische Strukturen als Träger mathematischer Operationen. Registriert werden die Quellen [76] bis [78], die Wiederverwendung von [72], die Definitionen 3.2.14 bis 3.2.21 sowie die Gleichungen (3.193) bis (3.202). Der Abschnitt bleibt Forschungsstand und enthält keine eigenständige FRZK-Axiomatik.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.3-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.3-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsabschnitt anlegen/aktualisieren
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
    '3.2.3',
    'Algebraische Strukturen als Träger mathematischer Operationen',
    3,
    3.2300,
    'final',
    0,
    'Der Abschnitt rekonstruiert algebraische Strukturen als Mengen mit inneren Verknüpfungen. Behandelt werden Abgeschlossenheit, Assoziativität, neutrales und inverses Element sowie Gruppen, Ringe und Körper. Die Darstellung bleibt mathematischer Forschungsstand und bereitet den späteren Übergang zu funktionalen Operationen vor.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.3'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Algebraische Strukturen als Träger mathematischer Operationen',
    chapter_no = 3,
    section_order = 3.2300,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt rekonstruiert algebraische Strukturen als Mengen mit inneren Verknüpfungen. Behandelt werden Abgeschlossenheit, Assoziativität, neutrales und inverses Element sowie Gruppen, Ringe und Körper. Die Darstellung bleibt mathematischer Forschungsstand und bereitet den späteren Übergang zu funktionalen Operationen vor.'
WHERE section_code = '3.2.3';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.3'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren
-- ---------------------------------------------------------------------

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
VALUES
('Noether', 'Emmy', 'Noether, Emmy', 1882, 1935, 'Autorin der Quelle [76].'),
('van der Waerden', 'Bartel Leendert', 'van der Waerden, Bartel Leendert', 1903, 1996, 'Autor der Quelle [77].'),
('Galois', 'Évariste', 'Galois, Évariste', 1811, 1832, 'Autor der Quelle [78].')
ON DUPLICATE KEY UPDATE
    notes = VALUES(notes);

SET @author_noether := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Noether, Emmy'
    LIMIT 1
);

SET @author_vanderwaerden := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'van der Waerden, Bartel Leendert'
    LIMIT 1
);

SET @author_galois := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Galois, Évariste'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen [76]–[78]
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
    76,
    'noether_abstrakter_aufbau_idealtheorie_1927',
    'journal_article',
    'Abstrakter Aufbau der Idealtheorie in algebraischen Zahl- und Funktionenkörpern',
    NULL,
    1927,
    1927,
    'Mathematische Annalen',
    NULL,
    NULL,
    '96',
    NULL,
    '26–61',
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'primary',
    8,
    'partially_verified',
    '3.2.3',
    'Erstnennung zur strukturellen und axiomatischen Entwicklung der modernen Algebra.',
    'Noether, Emmy (1927): Abstrakter Aufbau der Idealtheorie in algebraischen Zahl- und Funktionenkörpern. In: Mathematische Annalen 96, S. 26–61.',
    'Noether (1927)',
    'Historische Primärquelle zur strukturellen Algebra und Idealtheorie.',
    @revision_id
),
(
    77,
    'van_der_waerden_moderne_algebra_1930_1931',
    'book',
    'Moderne Algebra',
    NULL,
    1930,
    1931,
    NULL,
    'Springer',
    'Berlin',
    '1–2',
    NULL,
    NULL,
    'Erstausgabe',
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'primary',
    8,
    'partially_verified',
    '3.2.3',
    'Erstnennung zur systematischen axiomatischen Darstellung algebraischer Strukturen.',
    'van der Waerden, Bartel Leendert (1930–1931): Moderne Algebra. Band 1 und 2. Berlin: Springer.',
    'van der Waerden (1930–1931)',
    'Grundlegendes Werk zur modernen abstrakten Algebra.',
    @revision_id
),
(
    78,
    'galois_oeuvres_mathematiques_1846',
    'book',
    'Œuvres Mathématiques',
    NULL,
    1832,
    1846,
    NULL,
    NULL,
    'Paris',
    NULL,
    NULL,
    NULL,
    'Posthume Veröffentlichung',
    NULL,
    NULL,
    NULL,
    'fr',
    1,
    'primary',
    7,
    'partially_verified',
    '3.2.3',
    'Erstnennung zur historischen Entstehung der Gruppentheorie aus der Untersuchung algebraischer Gleichungen.',
    'Galois, Évariste (1846): Œuvres Mathématiques. Posthum veröffentlicht.',
    'Galois (1846)',
    'Historische Primärquelle zur Entstehung der Gruppentheorie.',
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
    issue = VALUES(issue),
    pages = VALUES(pages),
    edition = VALUES(edition),
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

SET @source_72 := (
    SELECT source_id FROM sources
    WHERE citation_number = 72
    LIMIT 1
);

SET @source_76 := (
    SELECT source_id FROM sources
    WHERE source_key = 'noether_abstrakter_aufbau_idealtheorie_1927'
    LIMIT 1
);

SET @source_77 := (
    SELECT source_id FROM sources
    WHERE source_key = 'van_der_waerden_moderne_algebra_1930_1931'
    LIMIT 1
);

SET @source_78 := (
    SELECT source_id FROM sources
    WHERE source_key = 'galois_oeuvres_mathematiques_1846'
    LIMIT 1
);

INSERT IGNORE INTO source_authors
(source_id, author_id, author_order, role)
VALUES
(@source_76, @author_noether, 1, 'author'),
(@source_77, @author_vanderwaerden, 1, 'author'),
(@source_78, @author_galois, 1, 'author');

-- ---------------------------------------------------------------------
-- 6. Quellenverwendungen
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_76, @section_id, 'first_citation',
    'Strukturelle und axiomatische Neuorientierung der Algebra durch Emmy Noether.',
    'Abschnitt 3.2.3: historische Entwicklung der modernen Algebra',
    1, 1, 'Erstnennung als Quelle [76].', @revision_id
WHERE @source_76 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_76
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_77, @section_id, 'first_citation',
    'Systematische axiomatische Darstellung von Gruppen, Ringen und Körpern.',
    'Abschnitt 3.2.3: abstrakte algebraische Strukturen',
    1, 1, 'Erstnennung als Quelle [77].', @revision_id
WHERE @source_77 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_77
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_78, @section_id, 'first_citation',
    'Historische Entstehung des Gruppenbegriffs aus der Theorie algebraischer Gleichungen.',
    'Abschnitt 3.2.3: Gruppenbegriff und historische Einordnung',
    1, 1, 'Erstnennung als Quelle [78].', @revision_id
WHERE @source_78 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_78
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_72, @section_id, 'background',
    'Mengentheoretische und strukturelle Grundlegung algebraischer Verknüpfungen und Strukturen.',
    'Abschnitt 3.2.3: Definitionen und strukturelle Einordnung',
    0, 1, 'Wiederverwendung der Quelle [72].', @revision_id
WHERE @source_72 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_72
        AND section_id = @section_id
        AND usage_type = 'background'
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.14–3.2.21
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
VALUES
(
    '3.2.14',
    @section_id,
    'Algebraische Verknüpfung',
    'Sei M eine Menge. Eine zweistellige Verknüpfung auf M ist eine Abbildung von M×M nach M, die jedem geordneten Paar (a,b) genau ein Element a∗b aus M zuordnet.',
    '\ast:M\times M\rightarrow M',
    '\ast:M\times M\rightarrow M',
    'adapted',
    @source_77,
    'M ist eine nichtleere Menge.',
    'Die Definition beschreibt eine innere zweistellige Operation.',
    'checked',
    @revision_id
),
(
    '3.2.15',
    @section_id,
    'Abgeschlossenheit',
    'Eine Verknüpfung ∗ heißt auf M abgeschlossen, wenn für alle a,b aus M auch a∗b wieder Element von M ist.',
    '\forall a,b\in M:\;a\ast b\in M',
    '\forall a,b\in M:\;a\ast b\in M',
    'adapted',
    @source_77,
    'Auf M ist eine zweistellige Verknüpfung definiert.',
    'Die Abgeschlossenheit hält sämtliche Operationsergebnisse im Trägerbereich.',
    'checked',
    @revision_id
),
(
    '3.2.16',
    @section_id,
    'Assoziativität',
    'Eine Verknüpfung ∗ heißt assoziativ, wenn für alle a,b,c aus M die Gleichheit (a∗b)∗c=a∗(b∗c) gilt.',
    '(a\ast b)\ast c=a\ast(b\ast c)',
    '(a\ast b)\ast c=a\ast(b\ast c)',
    'adapted',
    @source_77,
    'Auf M ist eine abgeschlossene zweistellige Verknüpfung definiert.',
    'Die Klammerung längerer Verknüpfungsfolgen verändert das Ergebnis nicht.',
    'checked',
    @revision_id
),
(
    '3.2.17',
    @section_id,
    'Neutrales Element',
    'Ein Element e aus M heißt neutrales Element bezüglich ∗, wenn e∗a=a∗e=a für alle a aus M gilt.',
    'e\ast a=a\ast e=a',
    'e\ast a=a\ast e=a',
    'adapted',
    @source_77,
    'Auf M ist eine zweistellige Verknüpfung definiert.',
    'Das neutrale Element lässt jedes andere Element bei der Verknüpfung unverändert.',
    'checked',
    @revision_id
),
(
    '3.2.18',
    @section_id,
    'Inverses Element',
    'Zu a aus M heißt a^{-1} invers, wenn a∗a^{-1}=a^{-1}∗a=e gilt.',
    'a\ast a^{-1}=a^{-1}\ast a=e',
    'a\ast a^{-1}=a^{-1}\ast a=e',
    'adapted',
    @source_77,
    'Ein neutrales Element e ist bestimmt.',
    'Das inverse Element hebt die Wirkung eines Elements bezüglich der Verknüpfung auf.',
    'checked',
    @revision_id
),
(
    '3.2.19',
    @section_id,
    'Gruppe',
    'Ein Paar (M,∗) heißt Gruppe, wenn die Verknüpfung abgeschlossen und assoziativ ist, ein neutrales Element existiert und jedes Element ein Inverses besitzt. Gilt zusätzlich a∗b=b∗a, heißt die Gruppe abelsch.',
    '(M,\ast)',
    '(M,\ast)',
    'adapted',
    @source_77,
    'M ist eine nichtleere Menge mit innerer zweistelliger Verknüpfung.',
    'Gruppen abstrahieren invertierbare Operationen und Symmetrien.',
    'checked',
    @revision_id
),
(
    '3.2.20',
    @section_id,
    'Ring',
    'Ein Ring ist eine Menge R mit zwei Verknüpfungen + und ·, sodass (R,+) eine abelsche Gruppe bildet, die Multiplikation assoziativ ist und beide Operationen durch die Distributivgesetze verbunden sind.',
    'a\cdot(b+c)=a\cdot b+a\cdot c',
    'a\cdot(b+c)=a\cdot b+a\cdot c',
    'adapted',
    @source_77,
    'Auf R sind Addition und Multiplikation definiert.',
    'Die Definition folgt der im Abschnitt verwendeten vereinfachten Ringfassung.',
    'checked',
    @revision_id
),
(
    '3.2.21',
    @section_id,
    'Körper',
    'Ein Körper ist ein Ring, in dem jedes von Null verschiedene Element ein multiplikatives Inverses besitzt.',
    'a\cdot a^{-1}=1',
    'a\cdot a^{-1}=1',
    'adapted',
    @source_77,
    'a ist ein von Null verschiedenes Ringelement.',
    'Körper ermöglichen die vier elementaren arithmetischen Operationen unter den üblichen Einschränkungen.',
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
-- 8. Gleichungen (3.193)–(3.202)
-- ---------------------------------------------------------------------

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.193', @section_id, 'Zweistellige innere Verknüpfung',
    '\ast:M\times M\rightarrow M',
    '\ast:M\times M\rightarrow M',
    'Eine zweistellige innere Verknüpfung ordnet jedem Paar aus M×M ein Element aus M zu.',
    'definition', 'adapted', @source_77,
    NULL,
    'M ist eine Menge.',
    'checked', @revision_id
),
(
    '3.194', @section_id, 'Ergebnis einer Verknüpfung',
    'a\ast b\in M',
    'a\ast b\in M',
    'Das Ergebnis der Verknüpfung zweier Elemente aus M liegt wieder in M.',
    'definition', 'adapted', @source_77,
    NULL,
    'a und b sind Elemente von M.',
    'checked', @revision_id
),
(
    '3.195', @section_id, 'Abgeschlossenheit',
    '\forall a,b\in M:\;a\ast b\in M',
    '\forall a,b\in M:\;a\ast b\in M',
    'Die Verknüpfung ist auf M abgeschlossen.',
    'definition', 'adapted', @source_77,
    NULL,
    'Auf M ist eine zweistellige Verknüpfung definiert.',
    'checked', @revision_id
),
(
    '3.196', @section_id, 'Assoziativität',
    '(a\ast b)\ast c=a\ast(b\ast c)',
    '(a\ast b)\ast c=a\ast(b\ast c)',
    'Die Klammerung einer dreifachen Verknüpfung verändert das Ergebnis nicht.',
    'definition', 'adapted', @source_77,
    NULL,
    'a,b,c sind Elemente von M.',
    'checked', @revision_id
),
(
    '3.197', @section_id, 'Neutrales Element',
    'e\ast a=a\ast e=a',
    'e\ast a=a\ast e=a',
    'Das neutrale Element e lässt jedes Element a unverändert.',
    'definition', 'adapted', @source_77,
    NULL,
    'e und a sind Elemente von M.',
    'checked', @revision_id
),
(
    '3.198', @section_id, 'Inverses Element',
    'a\ast a^{-1}=a^{-1}\ast a=e',
    'a\ast a^{-1}=a^{-1}\ast a=e',
    'Das inverse Element führt bei beidseitiger Verknüpfung zum neutralen Element.',
    'definition', 'adapted', @source_77,
    NULL,
    'e ist das neutrale Element.',
    'checked', @revision_id
),
(
    '3.199', @section_id, 'Gruppe als geordnetes Paar',
    '(M,\ast)',
    '(M,\ast)',
    'Eine Gruppe wird als Menge zusammen mit ihrer Verknüpfung dargestellt.',
    'definition', 'adapted', @source_77,
    NULL,
    'Die Gruppenaxiome sind erfüllt.',
    'checked', @revision_id
),
(
    '3.200', @section_id, 'Kommutativität',
    'a\ast b=b\ast a',
    'a\ast b=b\ast a',
    'Die Reihenfolge der verknüpften Elemente verändert das Ergebnis nicht.',
    'definition', 'adapted', @source_77,
    NULL,
    'a und b sind Elemente einer abelschen Gruppe.',
    'checked', @revision_id
),
(
    '3.201', @section_id, 'Distributivgesetz',
    'a\cdot(b+c)=a\cdot b+a\cdot c',
    'a\cdot(b+c)=a\cdot b+a\cdot c',
    'Die Multiplikation verteilt sich über die Addition.',
    'axiom', 'adapted', @source_77,
    NULL,
    'a,b,c sind Elemente eines Rings.',
    'checked', @revision_id
),
(
    '3.202', @section_id, 'Multiplikatives Inverses im Körper',
    'a\cdot a^{-1}=1',
    'a\cdot a^{-1}=1',
    'Jedes von Null verschiedene Körperelement besitzt ein multiplikatives Inverses.',
    'axiom', 'adapted', @source_77,
    NULL,
    'a ist von Null verschieden.',
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
-- 9. Gleichungssymbole
-- ---------------------------------------------------------------------

SET @eq_193 := (SELECT equation_id FROM equations WHERE equation_number='3.193' LIMIT 1);
SET @eq_194 := (SELECT equation_id FROM equations WHERE equation_number='3.194' LIMIT 1);
SET @eq_195 := (SELECT equation_id FROM equations WHERE equation_number='3.195' LIMIT 1);
SET @eq_196 := (SELECT equation_id FROM equations WHERE equation_number='3.196' LIMIT 1);
SET @eq_197 := (SELECT equation_id FROM equations WHERE equation_number='3.197' LIMIT 1);
SET @eq_198 := (SELECT equation_id FROM equations WHERE equation_number='3.198' LIMIT 1);
SET @eq_199 := (SELECT equation_id FROM equations WHERE equation_number='3.199' LIMIT 1);
SET @eq_200 := (SELECT equation_id FROM equations WHERE equation_number='3.200' LIMIT 1);
SET @eq_201 := (SELECT equation_id FROM equations WHERE equation_number='3.201' LIMIT 1);
SET @eq_202 := (SELECT equation_id FROM equations WHERE equation_number='3.202' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
VALUES
(@eq_193, '\ast', 'Verknüpfung', 'Zweistellige innere Operation auf M.', NULL, 'M×M nach M', 1),
(@eq_193, 'M', 'Trägermenge', 'Menge, auf der die Verknüpfung definiert ist.', NULL, 'Menge', 2),

(@eq_194, 'a', 'Erstes Element', 'Erster Operand der Verknüpfung.', NULL, 'Element von M', 1),
(@eq_194, 'b', 'Zweites Element', 'Zweiter Operand der Verknüpfung.', NULL, 'Element von M', 2),

(@eq_195, '\forall', 'Allquantor', 'Die Aussage gilt für alle Elemente a und b aus M.', NULL, 'Logischer Operator', 1),

(@eq_196, 'c', 'Drittes Element', 'Drittes Element der assoziativen Verknüpfungsfolge.', NULL, 'Element von M', 1),

(@eq_197, 'e', 'Neutrales Element', 'Element, das jedes andere Element bei der Verknüpfung unverändert lässt.', NULL, 'Element von M', 1),

(@eq_198, 'a^{-1}', 'Inverses Element', 'Element, das mit a zum neutralen Element verknüpft wird.', NULL, 'Element von M', 1),

(@eq_199, '(M,\ast)', 'Algebraische Struktur', 'Trägermenge zusammen mit ihrer Verknüpfung.', NULL, 'Geordnetes Paar', 1),

(@eq_200, '\ast', 'Kommutative Verknüpfung', 'Verknüpfung, deren Ergebnis unabhängig von der Reihenfolge ist.', NULL, 'Binäre Operation', 1),

(@eq_201, '+', 'Addition', 'Additive Ringverknüpfung.', NULL, 'Binäre Operation auf R', 1),
(@eq_201, '\cdot', 'Multiplikation', 'Multiplikative Ringverknüpfung.', NULL, 'Binäre Operation auf R', 2),

(@eq_202, '1', 'Multiplikativ neutrales Element', 'Neutrales Element der Multiplikation.', NULL, 'Element des Körpers', 1),
(@eq_202, 'a^{-1}', 'Multiplikatives Inverses', 'Inverses des von Null verschiedenen Elements a.', NULL, 'Element des Körpers', 2);

-- ---------------------------------------------------------------------
-- 10. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('next_citation_number', '79')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 79 THEN '79'
        ELSE counter_value
    END;

-- ---------------------------------------------------------------------
-- 11. Änderungsprotokoll
-- ---------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'created', 'section',
    '3.2.3',
    'Abschnitt 3.2.3 wurde vollständig angelegt und repositoryseitig abgeschlossen.',
    NULL,
    'status=final; Forschungsstand ohne FRZK-Eigenaxiomatik'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.2.3'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources',
    '[76]-[78]',
    'Drei historische Quellen zur Entwicklung der modernen Algebra und Gruppentheorie wurden aufgenommen.',
    'next_citation_number=76',
    'next_citation_number=79'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_added'
      AND object_reference='[76]-[78]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_reused', 'source',
    '[72]',
    'Bourbaki wurde zur strukturellen Einordnung algebraischer Verknüpfungen erneut verwendet.',
    NULL,
    'source_usage registriert'
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
    '3.2.14-3.2.21',
    'Acht Definitionen zu algebraischen Verknüpfungen, Gruppen, Ringen und Körpern wurden registriert.',
    NULL,
    '8 Definitionen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='definition_added'
      AND object_reference='3.2.14-3.2.21'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations',
    '(3.193)-(3.202)',
    'Zehn Gleichungen einschließlich Word-LaTeX und Symbolzuordnungen wurden aufgenommen.',
    NULL,
    '10 Gleichungen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='(3.193)-(3.202)'
);

-- ---------------------------------------------------------------------
-- 12. Validierungen
-- ---------------------------------------------------------------------

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.3-SECTION',
    IF(COUNT(*)=1,'passed','failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.3 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code='3.2.3'
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
    'K3.2.3-NEW-SOURCES',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die neuen Quellen [76] bis [78] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number BETWEEN 76 AND 78
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
    'K3.2.3-SOURCE-USAGE',
    IF(COUNT(*)=4,'passed','failed'),
    '4',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [72] sowie [76] bis [78] müssen mit Abschnitt 3.2.3 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (72,76,77,78)
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
    'K3.2.3-DEFINITIONS',
    IF(COUNT(*)=8,'passed','failed'),
    '8',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.14 bis 3.2.21 müssen vollständig registriert sein.'
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.14','3.2.15','3.2.16','3.2.17',
       '3.2.18','3.2.19','3.2.20','3.2.21')
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
    'K3.2.3-EQUATIONS',
    IF(COUNT(*)=10,'passed','failed'),
    '10',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.193) bis (3.202) müssen vollständig registriert sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 193 AND 202
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
    'K3.2.3-WORD-LATEX',
    IF(COUNT(*)=10,'passed','failed'),
    '10',
    CAST(COUNT(*) AS CHAR),
    'Für alle zehn Gleichungen muss eine Word-LaTeX-Repräsentation vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 193 AND 202
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
    'K3.2.3-PARENT-REVISION',
    IF(parent_revision_id=@parent_revision_id,'passed','failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision 3.2.3 muss unmittelbar auf der Revision 3.2.2 aufbauen.'
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
    'K3.2.3-NEXT-CITATION',
    IF(CAST(counter_value AS UNSIGNED)>=79,'passed','failed'),
    '>=79',
    counter_value,
    'Nach Quelle [78] muss die nächste freie Literaturziffer mindestens [79] sein.'
FROM repository_counters
WHERE counter_key='next_citation_number'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

-- ---------------------------------------------------------------------
-- 13. Abschluss
-- ---------------------------------------------------------------------

COMMIT;

-- ---------------------------------------------------------------------
-- 14. Audit-Ausgabe
-- ---------------------------------------------------------------------

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    parent_revision_id,
    revision_date
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.3-V1';

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code='3.2.3';

SELECT
    citation_number,
    source_key,
    short_citation_text,
    verification_status
FROM sources
WHERE citation_number BETWEEN 76 AND 78
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY definition_number;

SELECT
    equation_number,
    title,
    equation_type,
    validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
