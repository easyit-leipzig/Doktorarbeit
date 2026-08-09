-- ###########################################################################
-- FRZK Repository
-- Abschnitt 3.2.36
-- Ein-/Ausgangsstabilität, Dissipativität und Passivität
--
-- Definitionen : 3.2.555–3.2.569
-- Sätze        : 3.2.116–3.2.119
-- Gleichungen  : (3.2941)–(3.2959)
-- Literatur    : [110]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision=(SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.36-V1',
NOW(),
'section',
'3.2.36',
'3.2.36-v1',
'Ein-/Ausgangsstabilität, Dissipativität, Passivität und FRZK-Erweiterungen.',
'Olaf Thiele / ChatGPT',
@parent_revision
WHERE NOT EXISTS(
SELECT 1 FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.36-V1'
);

SET @revision=(SELECT revision_id FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.36-V1' LIMIT 1);

SET @parent_section=(SELECT section_id
FROM dissertation_sections
WHERE section_code='3.2'
LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,
'3.2.36',
'Ein- und Ausgangsstabilität, Dissipativität und Passivität',
3,
3236,
'final',
1,
'Signaltheorie, Dissipativität, Passivität und funktionale Erweiterung.'
WHERE NOT EXISTS(
SELECT 1 FROM dissertation_sections
WHERE section_code='3.2.36'
);

SET @section=(SELECT section_id
FROM dissertation_sections
WHERE section_code='3.2.36'
LIMIT 1);

INSERT INTO sources
(citation_number,source_key,source_type,title,verification_status,first_citation_section_code,short_citation_text,created_revision_id)
SELECT
110,
'willems_dissipative_systems_1972',
'journal',
'Dissipative Dynamical Systems',
'pending',
'3.2.36',
'Willems [110]',
@revision
WHERE NOT EXISTS(
SELECT 1 FROM sources WHERE citation_number=110
);

SET @src110=(SELECT source_id FROM sources WHERE citation_number=110 LIMIT 1);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,created_revision_id)
SELECT
@src110,
@section,
'first_citation',
'Ein-/Ausgangsstabilität, Dissipativität und Passivität.',
'3.2.36',
1,
@revision
WHERE NOT EXISTS(
SELECT 1 FROM source_usage
WHERE source_id=@src110 AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.36'),
('current_section','3.2.37'),
('last_definition_number','3.2.569'),
('next_definition_number','3.2.570'),
('last_theorem_number','3.2.119'),
('next_theorem_number','3.2.120'),
('last_equation_number','3.2959'),
('next_equation_number','3.2960'),
('last_citation_number','110'),
('next_citation_number','111')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT
@revision,
@section,
'created',
'section',
'3.2.36',
'Abschnitt vollständig angelegt.',
'Definitionen 3.2.555–3.2.569, Sätze 3.2.116–3.2.119, Gleichungen (3.2941)–(3.2959), Literatur [110].'
WHERE NOT EXISTS(
SELECT 1 FROM section_change_log
WHERE revision_id=@revision
AND object_reference='3.2.36'
);

COMMIT;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN (
'last_completed_section','current_section',
'last_definition_number','next_definition_number',
'last_theorem_number','next_theorem_number',
'last_equation_number','next_equation_number',
'last_citation_number','next_citation_number'
);
