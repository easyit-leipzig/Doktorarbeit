/* ============================================================
   FRZK-RKB – Repository-Update
   Abschnitt 3.1.1
   Das Nichts als mathematischer Ausgangspunkt

   Grundlage: reale Tabellenstruktur aus frzk_rkb(3).sql
   Voraussetzung:
   - FRZK_Repository_Update_3_1_0_SCHEMAKORREKT.sql wurde
     erfolgreich importiert.
   - Abschnitt 3.1.1 sowie die Quellen [4]–[6] sind noch
     nicht im Repository vorhanden.

   Das Skript erzeugt:
   - Repository-Revision 2 für Abschnitt 3.1.1
   - Gliederungseintrag 3.1.1
   - neue Autoren und Herausgeber
   - Quellen [4]–[6]
   - Autoren-/Herausgeberzuordnungen
   - Quellenverwendungen
   - Änderungsprotokoll
   - Validierungsabfragen
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   1. Voraussetzungen prüfen
   ============================================================ */

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.0-V1'
    LIMIT 1
);

SET @section_3_1_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1'
    LIMIT 1
);

SET @section_3_1_0_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1.0'
    LIMIT 1
);

SET @existing_revision := (
    SELECT COUNT(*)
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.1-V1'
);

SET @existing_section := (
    SELECT COUNT(*)
    FROM dissertation_sections
    WHERE section_code = '3.1.1'
);

SET @existing_sources := (
    SELECT COUNT(*)
    FROM sources
    WHERE citation_number IN (4, 5, 6)
       OR source_key IN (
           'parmenides_fragmente_diels_kranz_1951',
           'weinberg_quantum_fields_vol1_1995',
           'halmos_naive_set_theory_1974'
       )
);

/* Harte Vorprüfung: Der Import wird bei Inkonsistenzen abgebrochen. */
DROP PROCEDURE IF EXISTS frzk_preflight_3_1_1;
DELIMITER $$
CREATE PROCEDURE frzk_preflight_3_1_1()
BEGIN
    IF @parent_revision_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'FRZK 3.1.1: Elternrevision RKB-NEU-K3.1.0-V1 fehlt.';
    END IF;

    IF @section_3_1_id IS NULL OR @section_3_1_0_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'FRZK 3.1.1: Abschnitt 3.1 oder 3.1.0 fehlt.';
    END IF;

    IF @existing_revision > 0 OR @existing_section > 0 OR @existing_sources > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'FRZK 3.1.1: Revision, Abschnitt oder Quellen [4]-[6] existieren bereits.';
    END IF;
END$$
DELIMITER ;

CALL frzk_preflight_3_1_1();
DROP PROCEDURE frzk_preflight_3_1_1;

/* ============================================================
   2. Repository-Revision
   ============================================================ */

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
VALUES
(
    'RKB-NEU-K3.1.1-V1',
    NOW(),
    'section',
    '3.1.1',
    '1.0',
    'Vollständige Neufassung von Abschnitt 3.1.1 Das Nichts als mathematischer Ausgangspunkt. Aufnahme der erstmals verwendeten Quellen [4] bis [6] und ihrer Verwendungen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);

SET @revision_id := LAST_INSERT_ID();

/* ============================================================
   3. Gliederungseintrag 3.1.1
   ============================================================ */

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
VALUES
(
    @section_3_1_id,
    '3.1.1',
    'Das Nichts als mathematischer Ausgangspunkt',
    3,
    3.1100,
    'final',
    1,
    'Vollständige Neufassung. Der Abschnitt grenzt das absolute Nichts von mathematisch und physikalisch strukturierten Formen der Leere ab und leitet funktionale Unterscheidbarkeit als minimale Voraussetzung mathematischer Beschreibung her.'
);

SET @section_3_1_1_id := LAST_INSERT_ID();

/* ============================================================
   4. Autoren und Herausgeber
   ============================================================ */

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
VALUES
('Parmenides', NULL, 'Parmenides', -515, -450, 'Antiker Autor der Fragmente in Quelle [4].');
SET @author_parmenides_id := LAST_INSERT_ID();

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
VALUES
('Diels', 'Hermann', 'Diels, Hermann', 1848, 1922, 'Herausgeber der Fragmente der Vorsokratiker, Quelle [4].');
SET @author_diels_id := LAST_INSERT_ID();

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
VALUES
('Kranz', 'Walther', 'Kranz, Walther', 1884, 1960, 'Bearbeiter und Herausgeber der Fragmente der Vorsokratiker, Quelle [4].');
SET @author_kranz_id := LAST_INSERT_ID();

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
VALUES
('Weinberg', 'Steven', 'Weinberg, Steven', 1933, 2021, 'Autor der Quelle [5].');
SET @author_weinberg_id := LAST_INSERT_ID();

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    birth_year,
    death_year,
    notes
)
VALUES
('Halmos', 'Paul R.', 'Halmos, Paul R.', 1916, 2006, 'Autor der Quelle [6].');
SET @author_halmos_id := LAST_INSERT_ID();

/* ============================================================
   5. Quellen [4]–[6]
   ============================================================ */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
    language_code,
    priority,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    first_citation_note,
    full_citation_text,
    short_citation_text,
    notes,
    created_revision_id
)
VALUES
(
    4,
    'parmenides_fragmente_diels_kranz_1951',
    'historical_work',
    'Die Fragmente der Vorsokratiker',
    'Griechisch und deutsch, Band 1; Fragmente 28 B2, B3 und B6',
    NULL,
    1951,
    NULL,
    'Weidmann',
    'Berlin',
    '1',
    NULL,
    NULL,
    '6. Auflage',
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'historical',
    8,
    'verified',
    '3.1.1',
    'Erstnennung zur philosophischen Unzugänglichkeit des Nichtseins und zur Bindung von Denken, Sagen und Sein.',
    'Parmenides: Fragmente 28 B2, B3 und B6. In: Diels, Hermann; Kranz, Walther (Hrsg.) (1951): Die Fragmente der Vorsokratiker. Griechisch und deutsch. Band 1. 6. Auflage. Berlin: Weidmann.',
    'Parmenides, Fragmente 28 B2, B3 und B6 [4]',
    'Historische Primärüberlieferung in der maßgeblichen Edition von Diels und Kranz.',
    @revision_id
);
SET @source_4_id := LAST_INSERT_ID();

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
    language_code,
    priority,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    first_citation_note,
    full_citation_text,
    short_citation_text,
    notes,
    created_revision_id
)
VALUES
(
    5,
    'weinberg_quantum_fields_vol1_1995',
    'book',
    'The Quantum Theory of Fields',
    'Volume I: Foundations',
    1995,
    1995,
    NULL,
    'Cambridge University Press',
    'Cambridge',
    'I',
    NULL,
    NULL,
    '1',
    NULL,
    '978-0-521-55001-7',
    NULL,
    'en',
    1,
    'textbook',
    8,
    'verified',
    '3.1.1',
    'Erstnennung zur Einordnung des quantenfeldtheoretischen Vakuums als strukturierter Grundzustand eines vorausgesetzten formalen Systems.',
    'Weinberg, Steven (1995): The Quantum Theory of Fields. Volume I: Foundations. Cambridge: Cambridge University Press.',
    'Weinberg (1995) [5]',
    'Grundlegende Darstellung der Quantenfeldtheorie; im Abschnitt insbesondere für den Zustands- und Vakuumbegriff verwendet.',
    @revision_id
);
SET @source_5_id := LAST_INSERT_ID();

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
    language_code,
    priority,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    first_citation_note,
    full_citation_text,
    short_citation_text,
    notes,
    created_revision_id
)
VALUES
(
    6,
    'halmos_naive_set_theory_1974',
    'book',
    'Naive Set Theory',
    NULL,
    1960,
    1974,
    NULL,
    'Springer-Verlag',
    'New York',
    NULL,
    NULL,
    '1–12',
    'Reprint',
    NULL,
    '978-0-387-90092-6',
    NULL,
    'en',
    1,
    'textbook',
    8,
    'verified',
    '3.1.1',
    'Erstnennung zur leeren Menge als wohldefiniertem mathematischem Objekt innerhalb einer bereits vorausgesetzten Mengenstruktur.',
    'Halmos, Paul R. (1974): Naive Set Theory. New York: Springer-Verlag, insbesondere S. 1–12.',
    'Halmos (1974) [6]',
    'Referenzwerk zur elementaren Mengenlehre und zur begrifflichen Stellung der leeren Menge.',
    @revision_id
);
SET @source_6_id := LAST_INSERT_ID();

/* ============================================================
   6. Autoren- und Herausgeberzuordnungen
   ============================================================ */

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
VALUES
(@source_4_id, @author_parmenides_id, 1, 'author'),
(@source_4_id, @author_diels_id, 2, 'editor'),
(@source_4_id, @author_kranz_id, 3, 'editor'),
(@source_5_id, @author_weinberg_id, 1, 'author'),
(@source_6_id, @author_halmos_id, 1, 'author');

/* ============================================================
   7. Quellenverwendungen in Abschnitt 3.1.1
   ============================================================ */

INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
VALUES
(
    @source_4_id,
    @section_3_1_1_id,
    'first_citation',
    'Parmenides begrenzt die Denkbarkeit und sprachliche Bestimmbarkeit des Nichtseins und liefert damit einen historischen Ausgangspunkt für die Frage nach einem voraussetzungslosen Nichts.',
    '3.1.1, Absätze 3 und 4',
    1,
    1,
    'Erstnennung als Quelle [4]; relevante Fragmente: 28 B2, B3 und B6.',
    @revision_id
),
(
    @source_5_id,
    @section_3_1_1_id,
    'first_citation',
    'Das quantenfeldtheoretische Vakuum ist ein definierter Zustand eines bereits strukturierten mathematisch-physikalischen Systems und daher kein absolutes Nichts.',
    '3.1.1, Absatz 5',
    1,
    1,
    'Erstnennung als Quelle [5]; Bezug insbesondere auf die Grundlagenkapitel 2 und 5.',
    @revision_id
),
(
    @source_6_id,
    @section_3_1_1_id,
    'first_citation',
    'Die leere Menge enthält keine Elemente, bleibt aber selbst ein definiertes Objekt innerhalb einer vorausgesetzten Mengenlehre.',
    '3.1.1, Absatz 7',
    1,
    1,
    'Erstnennung als Quelle [6]; Bezug insbesondere auf S. 1–12.',
    @revision_id
);

/* ============================================================
   8. Änderungsprotokoll
   ============================================================ */

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
)
VALUES
(
    @revision_id,
    @section_3_1_1_id,
    'created',
    'section',
    '3.1.1',
    'Abschnitt 3.1.1 vollständig neu erstellt und repositoryseitig abgeschlossen.',
    NULL,
    'Das Nichts als mathematischer Ausgangspunkt'
),
(
    @revision_id,
    @section_3_1_1_id,
    'source_added',
    'sources',
    '[4]–[6]',
    'Drei erstmals zitierte Quellen aufgenommen und mit Abschnitt 3.1.1 verknüpft.',
    NULL,
    'Parmenides/Diels/Kranz (1951), Weinberg (1995), Halmos (1974)'
),
(
    @revision_id,
    @section_3_1_1_id,
    'other',
    'conceptual_result',
    'funktionale Unterscheidbarkeit',
    'Zentrales Arbeitsergebnis des Abschnitts dokumentiert: Ein absolutes Nichts ist mathematisch unzugänglich; minimale Beschreibung setzt funktionale Unterscheidbarkeit voraus.',
    NULL,
    'Vorbereitende konzeptionelle Grundlage; noch keine formale Definition und kein Axiom.'
),
(
    @revision_id,
    @section_3_1_1_id,
    'status_changed',
    'section',
    '3.1.1',
    'Bearbeitungsstatus des Abschnitts auf final gesetzt.',
    'draft',
    'final'
);

COMMIT;

/* ============================================================
   9. Validierung – erwarteter Repository-Stand
   ============================================================ */

SELECT
    revision_id,
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    parent_revision_id,
    summary
FROM repository_revisions
WHERE revision_id = @revision_id;

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code IN ('3.1.0', '3.1.1')
ORDER BY section_order;

SELECT
    s.citation_number,
    s.source_key,
    s.source_type,
    s.title,
    s.subtitle,
    s.year_original,
    s.year_edition,
    s.first_citation_section_code,
    s.verification_status
FROM sources s
WHERE s.citation_number BETWEEN 4 AND 6
ORDER BY s.citation_number;

SELECT
    s.citation_number,
    sa.author_order,
    sa.role,
    a.normalized_name
FROM sources s
JOIN source_authors sa ON sa.source_id = s.source_id
JOIN authors a ON a.author_id = sa.author_id
WHERE s.citation_number BETWEEN 4 AND 6
ORDER BY s.citation_number, sa.author_order;

SELECT
    su.usage_id,
    s.citation_number,
    ds.section_code,
    su.usage_type,
    su.is_first_mention,
    su.citation_checked,
    su.claim_summary
FROM source_usage su
JOIN sources s ON s.source_id = su.source_id
JOIN dissertation_sections ds ON ds.section_id = su.section_id
WHERE ds.section_code = '3.1.1'
ORDER BY s.citation_number;

SELECT
    scl.change_id,
    ds.section_code,
    scl.change_type,
    scl.object_type,
    scl.object_reference,
    scl.change_summary
FROM section_change_log scl
JOIN dissertation_sections ds ON ds.section_id = scl.section_id
WHERE scl.revision_id = @revision_id
ORDER BY scl.change_id;

SELECT
    (SELECT COUNT(*) FROM repository_revisions
     WHERE revision_code = 'RKB-NEU-K3.1.1-V1') AS revision_count,
    (SELECT COUNT(*) FROM dissertation_sections
     WHERE section_code = '3.1.1') AS section_count,
    (SELECT COUNT(*) FROM sources
     WHERE citation_number BETWEEN 4 AND 6) AS source_count,
    (SELECT COUNT(*) FROM source_usage su
     JOIN dissertation_sections ds ON ds.section_id = su.section_id
     WHERE ds.section_code = '3.1.1') AS source_usage_count,
    (SELECT COUNT(*) FROM section_change_log
     WHERE revision_id = @revision_id) AS change_log_count;

/* Erwartete Werte der letzten Kontrollabfrage:
   revision_count     = 1
   section_count      = 1
   source_count       = 3
   source_usage_count = 3
   change_log_count   = 4

   Keine Gleichungen, Definitionen, Symbole, Axiome oder Annahmen
   werden in Abschnitt 3.1.1 formal registriert.
   ============================================================ */
