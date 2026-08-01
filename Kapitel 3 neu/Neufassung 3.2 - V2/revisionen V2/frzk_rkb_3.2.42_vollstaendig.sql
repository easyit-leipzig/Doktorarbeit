-- ###########################################################################
-- FRZK Repository
-- Abschnitt 3.2.42
-- Pseudo-Riemannsche Geometrie und Raumzeitstrukturen
--
-- Definitionen : 3.2.621–3.2.637
-- Sätze        : 3.2.141–3.2.144
-- Gleichungen  : (3.3029)–(3.3065)
-- Literatur    : [116]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

-- Revision
SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.42-V1',
NOW(),
'section',
'3.2.42',
'3.2.42-v1',
'Pseudo-Riemannsche Geometrie, Lorentz-Mannigfaltigkeiten, Lichtkegel, Eigenzeit und funktionale Signaturen.',
'Olaf Thiele / ChatGPT',
@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.42-V1'
);

SET @revision=(SELECT revision_id FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.42-V1' LIMIT 1);

SET @parent_section=(SELECT section_id FROM dissertation_sections
WHERE section_code='3.2' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,
'3.2.42',
'Pseudo-Riemannsche Geometrie und Raumzeitstrukturen',
3,
3242,
'final',
1,
'Lorentz-Mannigfaltigkeiten, Lichtkegel, Eigenzeit sowie funktionale pseudo-Riemannsche Strukturen.'
WHERE NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code='3.2.42'
);

-- Literatur [116]
INSERT INTO authors(family_name,given_names,normalized_name)
SELECT 'O''Neill','Barrett','O''Neill, Barrett'
WHERE NOT EXISTS(
SELECT 1 FROM authors WHERE normalized_name='O''Neill, Barrett');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,publisher,language_code,verification_status,created_revision_id)
SELECT
116,
'oneill_semi_riemannian_geometry',
'book',
'Semi-Riemannian Geometry',
1983,
'Academic Press',
'en',
'pending',
@revision
WHERE NOT EXISTS(
SELECT 1 FROM sources WHERE citation_number=116);

SET @src116=(SELECT source_id FROM sources WHERE citation_number=116 LIMIT 1);

-- -------------------------------------------------------------------
-- Repository-Zähler
-- -------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.42'),
('current_section','3.2.43'),
('last_definition_number','3.2.637'),
('next_definition_number','3.2.638'),
('last_theorem_number','3.2.144'),
('next_theorem_number','3.2.145'),
('last_equation_number','3.3065'),
('next_equation_number','3.3066'),
('last_citation_number','116'),
('next_citation_number','117')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

COMMIT;

-- Validierung

SELECT 'Definitionen' AS typ,'3.2.621-3.2.637' AS bereich;
SELECT 'Saetze' AS typ,'3.2.141-3.2.144' AS bereich;
SELECT 'Gleichungen' AS typ,'3.3029-3.3065' AS bereich;
SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key LIKE 'last_%'
   OR counter_key LIKE 'next_%';
