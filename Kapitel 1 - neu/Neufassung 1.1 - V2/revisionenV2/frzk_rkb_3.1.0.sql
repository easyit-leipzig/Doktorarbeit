/* ============================================================
   FRZK Repository
   Kapitel 3.1.0 – Einleitung
   ============================================================ */

START TRANSACTION;

SET @revision_id =
(
    SELECT COALESCE(MAX(revision_id),0)+1
    FROM repository_revisions
);

SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.1.0'
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
    is_original
)
SELECT
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.1'
 LIMIT 1
),
'3.1.0',
'Einleitung',
3,
0,
'completed',
1
WHERE NOT EXISTS
(
 SELECT 1
 FROM dissertation_sections
 WHERE section_code='3.1.0'
);

SET @section_id =
(
SELECT section_id
FROM dissertation_sections
WHERE section_code='3.1.0'
LIMIT 1
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'background',
'Historische Grundlage des klassischen Raum- und Zeitbegriffs.',
'3.1.0 Einleitung',1,1,'Erstnennung Kapitel 3',@revision_id
FROM sources WHERE citation_number=1;

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'background',
'Raumzeit als dynamische geometrische Struktur.',
'3.1.0 Einleitung',1,1,'Erstnennung Kapitel 3',@revision_id
FROM sources WHERE citation_number=2;

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'background',
'Emergenz von Raum und Zeit in der Quantengravitation.',
'3.1.0 Einleitung',1,1,'Erstnennung Kapitel 3',@revision_id
FROM sources WHERE citation_number=3;

INSERT INTO section_change_log
(section_id,revision_id,change_type,object_type,object_reference,changed_at)
VALUES
(@section_id,@revision_id,'completed','section','3.1.0',NOW());

COMMIT;
