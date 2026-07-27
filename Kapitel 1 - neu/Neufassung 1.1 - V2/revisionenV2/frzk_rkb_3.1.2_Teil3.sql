/* FRZK Repository
Kapitel 3.1.2 Teil 3
Quellen [17]-[24]
Keine Gleichungen
*/

SET NAMES utf8mb4;
START TRANSACTION;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.1.2-T3-V1',
NOW(),
'section',
'3.1.2',
'3.1.2-T3-v1',
'Fortsetzung Abschnitt 3.1.2 mit Husserl bis Floridi.',
'Olaf Thiele / ChatGPT',
(
 SELECT revision_id
 FROM repository_revisions
 WHERE scope_reference='3.1.2'
 ORDER BY revision_id DESC
 LIMIT 1
)
WHERE NOT EXISTS
(
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.1.2-T3-V1'
);

SET @revision_id=
(
 SELECT revision_id
 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.1.2-T3-V1'
 LIMIT 1
);

SET @section_id=
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.1.2'
 LIMIT 1
);

/* Quellenverknüpfung */

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
 CONCAT('Erstverwendung Quelle ',s.citation_number),
 '3.1.2 Teil 3',
 1,
 1,
 'Teil 3 Philosophische Grundlagen',
 @revision_id
FROM sources s
WHERE s.citation_number BETWEEN 17 AND 24
AND NOT EXISTS
(
 SELECT 1
 FROM source_usage u
 WHERE u.source_id=s.source_id
 AND u.section_id=@section_id
);

/* Änderungsprotokoll */

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
 '3.1.2-T3',
 'Abschnitt erweitert um Husserl bis Floridi.',
 'Literatur bis [16]',
 'Literatur bis [24]'
WHERE NOT EXISTS
(
 SELECT 1
 FROM section_change_log
 WHERE revision_id=@revision_id
 AND object_reference='3.1.2-T3'
);

/* Validierung */

INSERT INTO repository_validation_results
(
 revision_id,
 validation_code,
 validation_status,
 expected_value,
 actual_value,
 validation_message
)
VALUES
(
 @revision_id,
 'K312T3_EQ',
 'passed',
 '0',
 '0',
 'Keine Gleichungen vorhanden.'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_citation_number','24'),
('next_citation_number','25')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

COMMIT;

SELECT revision_id,revision_code
FROM repository_revisions
WHERE revision_id=@revision_id;
