/* ============================================================
   FRZK Repository
   Abschnitt 3.1.2 (Teil 1)
   Philosophische Grundlagen
   Quellen: [7]–[12]
   Gleichungen: keine
   ============================================================ */

START TRANSACTION;

SET @parent :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.1'
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
 @parent,
 '3.1.2',
 'Philosophische Grundlagen',
 3,
 3.1200,
 'draft',
 1,
 'Teil 1: Platon bis Leibniz; Literatur [7]-[12]; keine Gleichungen.'
WHERE NOT EXISTS
(
 SELECT 1
 FROM dissertation_sections
 WHERE section_code='3.1.2'
);

UPDATE dissertation_sections
SET
 title='Philosophische Grundlagen',
 chapter_no=3,
 section_order=3.1200,
 status='draft',
 is_original_contribution=1,
 notes='Teil 1: Platon bis Leibniz; Literatur [7]-[12]; keine Gleichungen.'
WHERE section_code='3.1.2';

SET @section_id :=
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.1.2'
 LIMIT 1
);

/* Quellenverwendungen */

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
 @section_id,
 'first_citation',
 CONCAT('Erstverwendung Quelle ',s.citation_number),
 '3.1.2 Teil 1',
 1,
 1,
 'Automatisch erzeugt'
FROM sources s
WHERE s.citation_number BETWEEN 7 AND 12
AND NOT EXISTS
(
 SELECT 1
 FROM source_usage u
 WHERE u.section_id=@section_id
 AND u.source_id=s.source_id
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
 NULL,
 @section_id,
 'created',
 'section',
 '3.1.2',
 'Abschnitt angelegt.',
 NULL,
 'Literatur [7]-[12], keine Gleichungen.'
WHERE NOT EXISTS
(
 SELECT 1
 FROM section_change_log
 WHERE section_id=@section_id
 AND object_reference='3.1.2'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.1.2'),
('last_citation_number','12'),
('next_citation_number','13')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

COMMIT;

SELECT section_code,title,status
FROM dissertation_sections
WHERE section_code='3.1.2';
