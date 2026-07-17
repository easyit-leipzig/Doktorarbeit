/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3 / Abschnitt 3.1 / Abschnitt 3.1.0

   Titel Kapitel 3:
   Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen

   Titel Abschnitt 3.1:
   Grundlagen der funktionalen Beschreibung von Raum und Zeit

   Titel Abschnitt 3.1.0:
   Einleitung

   Grundlage: reale Tabellenstruktur aus frzk_rkb(3).sql
   Voraussetzung: Repository wurde vor der Neufassung geleert.
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   1. Repository-Revision
   Tatsächliche Spalten:
   revision_code, revision_date, scope_type, scope_reference,
   version_label, summary, created_by, parent_revision_id
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
    'RKB-NEU-K3.1.0-V1',
    NOW(),
    'section',
    '3.1.0',
    '1.0',
    'Neubeginn des FRZK-Repositories: Aufnahme der Kapitelüberschrift 3, der Abschnittsüberschrift 3.1 und des vollständig neu entwickelten Abschnitts 3.1.0 Einleitung einschließlich der erstmals verwendeten Quellen [1] bis [3].',
    'Olaf Thiele / ChatGPT',
    NULL
);

SET @revision_id := LAST_INSERT_ID();

/* ============================================================
   2. Gliederungsstruktur
   3 -> 3.1 -> 3.1.0
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
    NULL,
    '3',
    'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen',
    3,
    3.0000,
    'final',
    0,
    'Übergeordnete Kapitelüberschrift des vollständig neu aufgebauten Kapitels 3.'
);

SET @section_3_id := LAST_INSERT_ID();

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
    @section_3_id,
    '3.1',
    'Grundlagen der funktionalen Beschreibung von Raum und Zeit',
    3,
    3.1000,
    'final',
    0,
    'Grundlagenabschnitt des vollständig neu aufgebauten Kapitels 3.'
);

SET @section_3_1_id := LAST_INSERT_ID();

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
    '3.1.0',
    'Einleitung',
    3,
    3.1001,
    'final',
    0,
    'Vollständige Neufassung. Der Abschnitt grenzt den funktionalen Ausgangspunkt des FRZK von klassischen und quantengravitativen Raum-Zeit-Konzeptionen ab.'
);

SET @section_3_1_0_id := LAST_INSERT_ID();

/* ============================================================
   3. Autoren
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
(
    'Newton',
    'Isaac',
    'Newton, Isaac',
    1643,
    1727,
    'Autor der Quelle [1].'
);
SET @author_newton_id := LAST_INSERT_ID();

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
(
    'Einstein',
    'Albert',
    'Einstein, Albert',
    1879,
    1955,
    'Autor der Quelle [2].'
);
SET @author_einstein_id := LAST_INSERT_ID();

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
(
    'Rovelli',
    'Carlo',
    'Rovelli, Carlo',
    1956,
    NULL,
    'Autor der Quelle [3].'
);
SET @author_rovelli_id := LAST_INSERT_ID();

/* ============================================================
   4. Quellen [1]–[3]
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
    1,
    'newton_principia_1687',
    'historical_work',
    'Philosophiæ Naturalis Principia Mathematica',
    NULL,
    1687,
    1687,
    NULL,
    'Joseph Streater',
    'London',
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
    7,
    'verified',
    '3.1.0',
    'Erstnennung zur klassischen Konzeption von absolutem Raum und absoluter Zeit.',
    'Newton, Isaac (1687): Philosophiæ Naturalis Principia Mathematica. London: Joseph Streater.',
    'Newton (1687)',
    'Historische Primärquelle zur klassischen Mechanik und zur absoluten Raum-Zeit-Konzeption.',
    @revision_id
);
SET @source_1_id := LAST_INSERT_ID();

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
    2,
    'einstein_allgemeine_relativitaetstheorie_1916',
    'journal_article',
    'Die Grundlage der allgemeinen Relativitätstheorie',
    NULL,
    1916,
    1916,
    'Annalen der Physik',
    'Johann Ambrosius Barth',
    'Leipzig',
    '354',
    '7',
    '769–822',
    NULL,
    '10.1002/andp.19163540702',
    NULL,
    NULL,
    'de',
    1,
    'primary',
    9,
    'verified',
    '3.1.0',
    'Erstnennung zur dynamischen geometrischen Beschreibung der Raumzeit.',
    'Einstein, Albert (1916): Die Grundlage der allgemeinen Relativitätstheorie. In: Annalen der Physik, Bd. 354, Nr. 7, S. 769–822. DOI: 10.1002/andp.19163540702.',
    'Einstein (1916)',
    'Primärquelle zur Allgemeinen Relativitätstheorie.',
    @revision_id
);
SET @source_2_id := LAST_INSERT_ID();

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
    3,
    'rovelli_quantum_gravity_2004',
    'book',
    'Quantum Gravity',
    NULL,
    2004,
    2004,
    NULL,
    'Cambridge University Press',
    'Cambridge',
    NULL,
    NULL,
    NULL,
    '1',
    NULL,
    '978-0-521-83733-0',
    NULL,
    'en',
    1,
    'textbook',
    9,
    'verified',
    '3.1.0',
    'Erstnennung zur Quantengravitation und zur möglichen Emergenz von Raum und Zeit.',
    'Rovelli, Carlo (2004): Quantum Gravity. Cambridge: Cambridge University Press. ISBN 978-0-521-83733-0.',
    'Rovelli (2004)',
    'Grundlegende Monografie zur Schleifenquantengravitation.',
    @revision_id
);
SET @source_3_id := LAST_INSERT_ID();

/* ============================================================
   5. Zuordnung Autoren zu Quellen
   ============================================================ */

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
VALUES
(@source_1_id, @author_newton_id, 1, 'author'),
(@source_2_id, @author_einstein_id, 1, 'author'),
(@source_3_id, @author_rovelli_id, 1, 'author');

/* ============================================================
   6. Quellenverwendungen in Abschnitt 3.1.0
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
    @source_1_id,
    @section_3_1_0_id,
    'first_citation',
    'Historischer Ausgangspunkt der klassischen Konzeption eines absoluten Raumes und einer absoluten Zeit.',
    '3.1.0, Absatz 1 und 2',
    1,
    1,
    'Erstnennung als Quelle [1].',
    @revision_id
),
(
    @source_2_id,
    @section_3_1_0_id,
    'first_citation',
    'Grundlage der dynamischen geometrischen Raumzeitbeschreibung in der Allgemeinen Relativitätstheorie.',
    '3.1.0, Absatz 1 und 2',
    1,
    1,
    'Erstnennung als Quelle [2].',
    @revision_id
),
(
    @source_3_id,
    @section_3_1_0_id,
    'first_citation',
    'Einordnung quantengravitativer Ansätze, in denen Raum und Zeit als nichtfundamental oder emergent untersucht werden.',
    '3.1.0, Absatz 1 und 2',
    1,
    1,
    'Erstnennung als Quelle [3].',
    @revision_id
);

/* ============================================================
   7. Änderungsprotokoll
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
    @section_3_id,
    'created',
    'section',
    '3',
    'Kapitelüberschrift 3 neu angelegt.',
    NULL,
    'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen'
),
(
    @revision_id,
    @section_3_1_id,
    'created',
    'section',
    '3.1',
    'Abschnittsüberschrift 3.1 neu angelegt.',
    NULL,
    'Grundlagen der funktionalen Beschreibung von Raum und Zeit'
),
(
    @revision_id,
    @section_3_1_0_id,
    'created',
    'section',
    '3.1.0',
    'Abschnitt 3.1.0 vollständig neu erstellt und repositoryseitig abgeschlossen.',
    NULL,
    'Einleitung einschließlich Quellen [1] bis [3]'
),
(
    @revision_id,
    @section_3_1_0_id,
    'source_added',
    'source',
    '[1]–[3]',
    'Drei erstmals zitierte Grundlagenquellen aufgenommen und mit Abschnitt 3.1.0 verknüpft.',
    NULL,
    'Newton (1687), Einstein (1916), Rovelli (2004)'
),
(
    @revision_id,
    @section_3_1_0_id,
    'status_changed',
    'section',
    '3.1.0',
    'Bearbeitungsstatus des Abschnitts auf final gesetzt.',
    'draft',
    'final'
);

COMMIT;

/* ============================================================
   8. Validierung – erwarteter Repository-Stand
   ============================================================ */

SELECT
    revision_id,
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
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
    status
FROM dissertation_sections
WHERE section_code IN ('3', '3.1', '3.1.0')
ORDER BY section_order;

SELECT
    s.citation_number,
    s.source_key,
    s.source_type,
    s.title,
    s.year_original,
    CONCAT_WS(', ', a.family_name, a.given_names) AS author,
    s.first_citation_section_code,
    s.verification_status
FROM sources s
JOIN source_authors sa ON sa.source_id = s.source_id
JOIN authors a ON a.author_id = sa.author_id
WHERE s.citation_number BETWEEN 1 AND 3
ORDER BY s.citation_number;

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
WHERE ds.section_code = '3.1.0'
ORDER BY s.citation_number;

SELECT
    scl.change_id,
    ds.section_code,
    scl.change_type,
    scl.object_reference,
    scl.change_summary
FROM section_change_log scl
JOIN dissertation_sections ds ON ds.section_id = scl.section_id
WHERE scl.revision_id = @revision_id
ORDER BY scl.change_id;

/* Erwartete Zählwerte:
   Revisionen dieser Neufassung: 1
   Gliederungseinträge:          3  (3, 3.1, 3.1.0)
   Autoren:                      3
   Quellen:                      3  ([1]–[3])
   Quellenverwendungen:          3
   Definitionen:                 0
   Gleichungen:                  0
   Symbole:                      0
*/
