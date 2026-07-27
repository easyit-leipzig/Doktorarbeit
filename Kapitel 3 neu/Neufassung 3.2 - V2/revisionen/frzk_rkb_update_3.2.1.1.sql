/* ============================================================
   FRZK Repository
   Kapitel 3.2.1.1
   Historische Entwicklung des Mengenbegriffs
   ============================================================ */

START TRANSACTION;

/* ------------------------------------------------------------
   Neue Literatur
   ------------------------------------------------------------ */

/* [80] Georg Cantor */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    journal,
    year_original
)
VALUES
(
    80,
    'Cantor1895',
    'journal_article',
    'Beiträge zur Begründung der transfiniten Mengenlehre',
    'Mathematische Annalen',
    1895
);

SET @source80 = LAST_INSERT_ID();

INSERT INTO source_authors
(source_id, author_order, lastname, firstname)
VALUES
(@source80,1,'Cantor','Georg');


/* [81] Bertrand Russell */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    publisher,
    year_original
)
VALUES
(
    81,
    'Russell1903',
    'book',
    'The Principles of Mathematics',
    'Cambridge University Press',
    1903
);

SET @source81 = LAST_INSERT_ID();

INSERT INTO source_authors
(source_id, author_order, lastname, firstname)
VALUES
(@source81,1,'Russell','Bertrand');


/* [82] Ernst Zermelo */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    journal,
    year_original
)
VALUES
(
    82,
    'Zermelo1908',
    'journal_article',
    'Untersuchungen über die Grundlagen der Mengenlehre I',
    'Mathematische Annalen',
    1908
);

SET @source82 = LAST_INSERT_ID();

INSERT INTO source_authors
(source_id, author_order, lastname, firstname)
VALUES
(@source82,1,'Zermelo','Ernst');


/* [83] Abraham Fraenkel */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    journal,
    year_original
)
VALUES
(
    83,
    'Fraenkel1922',
    'journal_article',
    'Zu den Grundlagen der Cantor-Zermeloschen Mengenlehre',
    'Mathematische Annalen',
    1922
);

SET @source83 = LAST_INSERT_ID();

INSERT INTO source_authors
(source_id, author_order, lastname, firstname)
VALUES
(@source83,1,'Fraenkel','Abraham A.');


/* [84] Thoralf Skolem */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original
)
VALUES
(
    84,
    'Skolem1923',
    'conference_paper',
    'Einige Bemerkungen zur axiomatischen Begründung der Mengenlehre',
    1923
);

SET @source84 = LAST_INSERT_ID();

INSERT INTO source_authors
(source_id, author_order, lastname, firstname)
VALUES
(@source84,1,'Skolem','Thoralf');


/* ------------------------------------------------------------
   Source Usage
   ------------------------------------------------------------ */

INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes
)
SELECT
source_id,
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.1.1'
),
'background',
'Historische Entwicklung der Mengenlehre.',
'3.2.1.1',
1,
1,
'Master Rebuild 3.2'
FROM sources
WHERE citation_number BETWEEN 80 AND 84;


/* ------------------------------------------------------------
   Änderungsprotokoll
   ------------------------------------------------------------ */

INSERT INTO section_change_log
(
    section_id,
    change_type,
    object_type,
    object_reference,
    changed_at
)
SELECT
section_id,
'created',
'section',
'3.2.1.1',
NOW()
FROM dissertation_sections
WHERE section_code='3.2.1.1';

COMMIT;