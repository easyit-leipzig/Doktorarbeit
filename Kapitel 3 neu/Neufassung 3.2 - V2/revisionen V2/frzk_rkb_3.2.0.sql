/* ============================================================
   FRZK Repository
   Kapitel 3.2.0 – Einleitung
   Repository-Update
   Fortsetzung nach Weiter-Skript-Prinzip
   ============================================================ */

START TRANSACTION;

/* ------------------------------------------------------------
   Revision
   ------------------------------------------------------------ */

SET @revision_id :=
(
    SELECT MAX(revision_id)
    FROM repository_revisions
);

/* ------------------------------------------------------------
   Kapitel 3.2.0 ermitteln
   ------------------------------------------------------------ */

SET @section320 :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.0'
    LIMIT 1
);

/* ============================================================
   Neue Literatur
   (Nummern gemäß aktuellem Masterstand fortlaufend)
   ============================================================ */

/* [71] Serge Lang */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
71,
'lang_algebra_2002',
'book',
'Algebra',
2002,
'Springer'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=71
);

/* [72] Walter Rudin */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
72,
'rudin_analysis_1976',
'book',
'Principles of Mathematical Analysis',
1976,
'McGraw-Hill'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=72
);

/* [73] James R. Munkres */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
73,
'munkres_topology_2000',
'book',
'Topology',
2000,
'Prentice Hall'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=73
);

/* [74] Gilbert Strang */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
74,
'strang_linear_algebra_2016',
'book',
'Introduction to Linear Algebra',
2016,
'Wellesley-Cambridge Press'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=74
);

/* [75] Erwin Kreyszig */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
75,
'kreyszig_functional_analysis_1978',
'book',
'Introductory Functional Analysis with Applications',
1978,
'John Wiley & Sons'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=75
);

/* [76] Reed & Simon */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
76,
'reed_simon_mmph1_1980',
'book',
'Methods of Modern Mathematical Physics. Volume I: Functional Analysis',
1980,
'Academic Press'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=76
);

/* [77] Reinhard Diestel */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
77,
'diestel_graph_theory_2017',
'book',
'Graph Theory',
2017,
'Springer'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=77
);

/* [78] Saunders Mac Lane */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
78,
'maclane_categories_1998',
'book',
'Categories for the Working Mathematician',
1998,
'Springer'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=78
);

/* [79] Stephen C. Kleene */

INSERT INTO sources
(
 citation_number,
 source_key,
 source_type,
 title,
 year_original,
 publisher
)
SELECT
79,
'kleene_mathematical_logic_1967',
'book',
'Mathematical Logic',
1967,
'John Wiley & Sons'
WHERE NOT EXISTS
(
 SELECT 1
 FROM sources
 WHERE citation_number=79
);

/* ============================================================
   Source Usage
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
 notes
)
SELECT
s.source_id,
@section320,
'background',
'Mathematische Grundlagen des Kapitels 3.2',
'3.2.0',
1,
1,
'Master-Rebuild Kapitel 3.2'
FROM sources s
WHERE s.citation_number BETWEEN 71 AND 79
AND NOT EXISTS
(
 SELECT 1
 FROM source_usage su
 WHERE su.source_id=s.source_id
   AND su.section_id=@section320
);

/* ============================================================
   Änderungsprotokoll
   ============================================================ */

INSERT INTO section_change_log
(
 section_id,
 revision_id,
 change_type,
 object_type,
 object_reference,
 changed_at
)
VALUES
(
@section320,
@revision_id,
'update',
'section',
'3.2.0',
NOW()
);

/* ============================================================
   Kapitelstatus
   ============================================================ */

UPDATE dissertation_sections
SET status='completed'
WHERE section_id=@section320;

/* ============================================================ */

COMMIT;