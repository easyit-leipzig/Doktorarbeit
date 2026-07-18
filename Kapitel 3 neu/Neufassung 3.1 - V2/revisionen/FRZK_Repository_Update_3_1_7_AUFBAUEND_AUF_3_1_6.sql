/* FRZK Repository Update 3.1.7
Ausgangsbasis: erfolgreicher Import 3.1.6
Neue Quellen: keine
Neue Gleichungen: keine
Naechste Literaturzahl bleibt 66
*/
SET NAMES utf8mb4;
START TRANSACTION;

SET @parent_revision_id=(SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.1.6-V1' LIMIT 1);
SET @parent_section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.1' LIMIT 1);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-NEU-K3.1.7-V1',NOW(),'section','3.1.7','1.0',
'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung.',
'Olaf Thiele / ChatGPT',@parent_revision_id);

SET @revision_id=LAST_INSERT_ID();

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
VALUES
(@parent_section_id,'3.1.7',
'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung',
3,3.1700,'final',1,
'Zusammenführung des Forschungsstandes.');

SET @section_id=LAST_INSERT_ID();

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'background',
'Wiederverwendung im Forschungsstand.',
'Abschnitt 3.1.7',0,1,
'Bereits vorhandene Quelle.',
@revision_id
FROM sources
WHERE citation_number IN (1,2,3,5,16,18,56,57,58,59,60,61,62,63,64,65);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_id,'created','section','3.1.7',
'Abschnitt neu erstellt.',NULL,
'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung'),
(@revision_id,@section_id,'status_changed','section','3.1.7',
'Status final.','draft','final');

UPDATE repository_counters
SET updated_at=CURRENT_TIMESTAMP
WHERE counter_key='next_citation_number';

COMMIT;

SELECT 'IMPORT 3.1.7 ERFOLGREICH - NAECHSTE LITERATURNUMMER 66' AS status;
