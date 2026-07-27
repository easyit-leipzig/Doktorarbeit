/* ============================================================
   FRZK Repository
   Abschnitt 3.1.2 – Philosophische Grundlagen, Teil 2
   Quellen: [13]–[16]
   Autoren: Kant, Timmermann, Hegel, Russell,
             Whitehead, Griffin, Sherburne
   Gleichungen: keine
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   1. Gültige Repository-Revision
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
SELECT
    'RKB-NEU-K3.1.2-T2-V1',
    NOW(),
    'section',
    '3.1.2',
    '3.1.2-T2-v1',
    'Fortsetzung von Abschnitt 3.1.2 mit Kant, Hegel, Russell und Whitehead sowie den Literaturquellen [13] bis [16].',
    'Olaf Thiele / ChatGPT',
    (
        SELECT r.revision_id
        FROM repository_revisions r
        WHERE r.revision_code = 'RKB-NEU-K3.1.2-T1-V1'
           OR r.scope_reference = '3.1.2'
        ORDER BY
            (r.revision_code = 'RKB-NEU-K3.1.2-T1-V1') DESC,
            r.revision_id DESC
        LIMIT 1
    )
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.2-T2-V1'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.1.2-T2-V1'
    LIMIT 1
);

/* ============================================================
   2. Abschnitt 3.1.2 ermitteln und fortschreiben
   ============================================================ */

SET @parent_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1'
    LIMIT 1
);

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
    @parent_id,
    '3.1.2',
    'Philosophische Grundlagen',
    3,
    3.1200,
    'draft',
    1,
    'Bearbeitungsstand Teil 2: Platon bis Whitehead; Literatur [7] bis [16]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.1.2'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_id,
    title = 'Philosophische Grundlagen',
    chapter_no = 3,
    section_order = 3.1200,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Bearbeitungsstand Teil 2: Platon bis Whitehead; Literatur [7] bis [16]; keine nummerierten Gleichungen.'
WHERE section_code = '3.1.2';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.1.2'
    LIMIT 1
);

/* ============================================================
   3. Quellen [13]–[16]
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
    publisher,
    place,
    edition,
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
    13,
    'kant_kritik_reinen_vernunft_timmermann_1998',
    'historical_work',
    'Kritik der reinen Vernunft',
    'Insbesondere A19/B33–A49/B73',
    1781,
    1998,
    'Felix Meiner Verlag',
    'Hamburg',
    NULL,
    'de',
    1,
    'historical',
    8,
    'verified',
    '3.1.2',
    'Erstnennung zu Raum und Zeit als reinen Formen der sinnlichen Anschauung und Bedingungen möglicher Erfahrung.',
    'Kant, Immanuel: Kritik der reinen Vernunft. Herausgegeben von Jens Timmermann. Hamburg: Felix Meiner Verlag, 1998, insbesondere A19/B33–A49/B73.',
    'Kant, Kritik der reinen Vernunft [13]',
    'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',
    @revision_id
),
(
    14,
    'hegel_wissenschaft_logik_1986',
    'historical_work',
    'Wissenschaft der Logik I',
    'Werke, Band 5; insbesondere Sein, Nichts und Werden',
    1812,
    1986,
    'Suhrkamp',
    'Frankfurt am Main',
    NULL,
    'de',
    1,
    'historical',
    8,
    'verified',
    '3.1.2',
    'Erstnennung zur dialektischen Verbindung von Sein, Nichts und Werden sowie zur prozessualen Bestimmtheit.',
    'Hegel, Georg Wilhelm Friedrich: Wissenschaft der Logik I. Werke, Band 5. Frankfurt am Main: Suhrkamp, 1986, insbesondere „Sein“, „Nichts“ und „Werden“.',
    'Hegel, Wissenschaft der Logik I [14]',
    'Historische Primärquelle zur philosophischen Bestimmung von Differenz, Negation und Vermittlung.',
    @revision_id
),
(
    15,
    'russell_principles_mathematics_1903',
    'book',
    'The Principles of Mathematics',
    NULL,
    1903,
    1903,
    'Cambridge University Press',
    'Cambridge',
    NULL,
    'en',
    1,
    'primary',
    7,
    'partially_verified',
    '3.1.2',
    'Erstnennung zur formalen Eigenständigkeit mehrstelliger Relationen in der modernen Logik.',
    'Russell, Bertrand: The Principles of Mathematics. Cambridge: Cambridge University Press, 1903.',
    'Russell, The Principles of Mathematics [15]',
    'Historische Primärquelle zur relationalen Logik und zu den Grundlagen der Mathematik.',
    @revision_id
),
(
    16,
    'whitehead_process_reality_1978',
    'book',
    'Process and Reality',
    'An Essay in Cosmology',
    1929,
    1978,
    'Free Press',
    'New York',
    'Corrected edition',
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.1.2',
    'Erstnennung zur Prozessontologie und zum Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaften Substanzen.',
    'Whitehead, Alfred North: Process and Reality. An Essay in Cosmology. Corrected edition. Herausgegeben von David Ray Griffin und Donald W. Sherburne. New York: Free Press, 1978.',
    'Whitehead, Process and Reality [16]',
    'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    source_key = VALUES(source_key),
    source_type = VALUES(source_type),
    title = VALUES(title),
    subtitle = VALUES(subtitle),
    year_original = VALUES(year_original),
    year_edition = VALUES(year_edition),
    publisher = VALUES(publisher),
    place = VALUES(place),
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
    notes = VALUES(notes);

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
('Kant', 'Immanuel', 'Kant, Immanuel', 1724, 1804, 'Für Abschnitt 3.1.2 registriert.'),
('Timmermann', 'Jens', 'Timmermann, Jens', NULL, NULL, 'Herausgeber der verwendeten Kant-Ausgabe.'),
('Hegel', 'Georg Wilhelm Friedrich', 'Hegel, Georg Wilhelm Friedrich', 1770, 1831, 'Für Abschnitt 3.1.2 registriert.'),
('Russell', 'Bertrand', 'Russell, Bertrand', 1872, 1970, 'Für Abschnitt 3.1.2 registriert.'),
('Whitehead', 'Alfred North', 'Whitehead, Alfred North', 1861, 1947, 'Für Abschnitt 3.1.2 registriert.'),
('Griffin', 'David Ray', 'Griffin, David Ray', 1939, NULL, 'Herausgeber der korrigierten Ausgabe von Process and Reality.'),
('Sherburne', 'Donald W.', 'Sherburne, Donald W.', 1929, 2016, 'Herausgeber der korrigierten Ausgabe von Process and Reality.')
ON DUPLICATE KEY UPDATE
    family_name = VALUES(family_name),
    given_names = VALUES(given_names),
    birth_year = VALUES(birth_year),
    death_year = VALUES(death_year),
    notes = VALUES(notes);

SET @s13 := (SELECT source_id FROM sources WHERE citation_number = 13 LIMIT 1);
SET @s14 := (SELECT source_id FROM sources WHERE citation_number = 14 LIMIT 1);
SET @s15 := (SELECT source_id FROM sources WHERE citation_number = 15 LIMIT 1);
SET @s16 := (SELECT source_id FROM sources WHERE citation_number = 16 LIMIT 1);

SET @a_kant       := (SELECT author_id FROM authors WHERE normalized_name = 'Kant, Immanuel' LIMIT 1);
SET @a_timmermann := (SELECT author_id FROM authors WHERE normalized_name = 'Timmermann, Jens' LIMIT 1);
SET @a_hegel      := (SELECT author_id FROM authors WHERE normalized_name = 'Hegel, Georg Wilhelm Friedrich' LIMIT 1);
SET @a_russell    := (SELECT author_id FROM authors WHERE normalized_name = 'Russell, Bertrand' LIMIT 1);
SET @a_whitehead  := (SELECT author_id FROM authors WHERE normalized_name = 'Whitehead, Alfred North' LIMIT 1);
SET @a_griffin    := (SELECT author_id FROM authors WHERE normalized_name = 'Griffin, David Ray' LIMIT 1);
SET @a_sherburne  := (SELECT author_id FROM authors WHERE normalized_name = 'Sherburne, Donald W.' LIMIT 1);

INSERT IGNORE INTO source_authors(source_id, author_id, author_order, role)
VALUES
(@s13, @a_kant, 1, 'author'),
(@s13, @a_timmermann, 2, 'editor'),
(@s14, @a_hegel, 1, 'author'),
(@s15, @a_russell, 1, 'author'),
(@s16, @a_whitehead, 1, 'author'),
(@s16, @a_griffin, 2, 'editor'),
(@s16, @a_sherburne, 3, 'editor');

/* ============================================================
   5. Quellenverwendungen
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
SELECT
    s.source_id,
    @section_id,
    'first_citation',
    CASE s.citation_number
        WHEN 13 THEN 'Kant bestimmt Raum und Zeit als reine Formen der Anschauung und Bedingungen möglicher Erfahrung.'
        WHEN 14 THEN 'Hegel verbindet vollständige Bestimmungslosigkeit von Sein und Nichts mit dem Prozess des Werdens.'
        WHEN 15 THEN 'Russell weist mehrstelligen Relationen einen eigenständigen formalen Status zu.'
        WHEN 16 THEN 'Whitehead begründet eine Prozessontologie, in der Ereignisse, Relationen und Werden gegenüber dauerhaften Substanzen vorrangig sind.'
    END,
    CASE s.citation_number
        WHEN 13 THEN '3.1.2, Kant'
        WHEN 14 THEN '3.1.2, Hegel'
        WHEN 15 THEN '3.1.2, Russell'
        WHEN 16 THEN '3.1.2, Whitehead'
    END,
    1,
    1,
    CONCAT('Erstnennung als Quelle [', s.citation_number, '] in Abschnitt 3.1.2.'),
    @revision_id
FROM sources s
WHERE s.citation_number BETWEEN 13 AND 16
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.usage_type = 'first_citation'
  );

/* ============================================================
   6. Änderungsprotokoll
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
SELECT
    @revision_id,
    @section_id,
    'edited',
    'section',
    '3.1.2-T2',
    'Abschnitt 3.1.2 wurde um die philosophischen Positionen von Kant, Hegel, Russell und Whitehead erweitert.',
    'Bearbeitungsstand Teil 1: Literatur [7] bis [12].',
    'Bearbeitungsstand Teil 2: Literatur [7] bis [16]; keine Gleichungen.'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND object_reference = '3.1.2-T2'
  );

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
SELECT
    @revision_id,
    @section_id,
    'source_added',
    'sources',
    '[13]–[16]',
    'Vier neue philosophische Quellen wurden aufgenommen und mit Abschnitt 3.1.2 verknüpft.',
    'next_citation_number=13',
    'next_citation_number=17'
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM section_change_log
      WHERE revision_id = @revision_id
        AND section_id = @section_id
        AND change_type = 'source_added'
        AND object_reference = '[13]–[16]'
  );

/* ============================================================
   7. Validierungen
   ============================================================ */

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.1.2-T2-SOURCES',
    CASE WHEN COUNT(*) = 4 THEN 'passed' ELSE 'failed' END,
    '4',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [13] bis [16] müssen vollständig registriert sein.'
FROM sources
WHERE citation_number BETWEEN 13 AND 16
AND NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_id
      AND validation_code = 'K3.1.2-T2-SOURCES'
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message
)
SELECT
    @revision_id,
    'K3.1.2-T2-EQUATIONS',
    'passed',
    '0',
    '0',
    'Teil 2 von Abschnitt 3.1.2 enthält keine nummerierten Gleichungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_id
      AND validation_code = 'K3.1.2-T2-EQUATIONS'
);

/* ============================================================
   8. Repository-Zähler
   ============================================================ */

INSERT INTO repository_counters(counter_key, counter_value)
VALUES
('current_section', '3.1.2'),
('last_citation_number', '16'),
('next_citation_number', '17')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value);

COMMIT;

/* ============================================================
   9. Kontrollausgaben
   ============================================================ */

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    parent_revision_id
FROM repository_revisions
WHERE revision_code = 'RKB-NEU-K3.1.2-T2-V1';

SELECT
    section_id,
    section_code,
    title,
    status,
    notes
FROM dissertation_sections
WHERE section_code = '3.1.2';

SELECT
    s.citation_number,
    s.source_key,
    s.title,
    s.verification_status
FROM sources s
WHERE s.citation_number BETWEEN 13 AND 16
ORDER BY s.citation_number;

SELECT
    s.citation_number,
    a.normalized_name,
    sa.author_order,
    sa.role
FROM source_authors sa
JOIN sources s ON s.source_id = sa.source_id
JOIN authors a ON a.author_id = sa.author_id
WHERE s.citation_number BETWEEN 13 AND 16
ORDER BY s.citation_number, sa.author_order;

SELECT
    scl.change_type,
    scl.object_reference,
    scl.change_summary
FROM section_change_log scl
WHERE scl.revision_id = @revision_id
ORDER BY scl.change_id;
