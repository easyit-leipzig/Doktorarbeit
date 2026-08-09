-- ---------------------------------------------------------------------
-- FRZK-REPOSITORY-UPDATE
-- Kapitel 3.2.11: Orthogonale Projektionen und Orthonormalbasen
-- Grundlage: Repository-Stand nach Abschnitt 3.2.10
-- ---------------------------------------------------------------------

START TRANSACTION;

SET @parent_section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2' LIMIT 1
);

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.10-V1' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.11-V1',
NOW(),
'section',
'3.2.11',
'3.2.11-v1',
'Orthogonale Projektionen und Orthonormalbasen; Definitionen 3.2.29–3.2.32; Gleichungen (3.272)–(3.294).',
'Olaf Thiele / ChatGPT',
@parent_revision_id
WHERE NOT EXISTS(
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.11-V1'
);

SET @revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.11-V1'
 LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section_id,
'3.2.11',
'Orthogonale Projektionen und Orthonormalbasen',
3,
3.2110,
'final',
0,
'Definitionen 3.2.29–3.2.32; Gleichungen (3.272)–(3.294); Quellen [71],[74],[76],[82].'
WHERE NOT EXISTS(
 SELECT 1 FROM dissertation_sections WHERE section_code='3.2.11'
);

SET @section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2.11' LIMIT 1
);

-- Definitionen
INSERT INTO definitions
(definition_number,section_id,title,validation_status,created_revision_id)
VALUES
('3.2.29',@section_id,'Orthogonalität','verified',@revision_id),
('3.2.30',@section_id,'Normierter Vektor','verified',@revision_id),
('3.2.31',@section_id,'Orthonormalsystem','verified',@revision_id),
('3.2.32',@section_id,'Orthonormalbasis','verified',@revision_id)
ON DUPLICATE KEY UPDATE title=VALUES(title);

-- Gleichungsregistrierung
INSERT INTO equations
(equation_number,section_id,title,validation_status,created_revision_id)
VALUES
('3.272',@section_id,'Orthogonalität','verified',@revision_id),
('3.273',@section_id,'Skalarprodukt = 0','verified',@revision_id),
('3.274',@section_id,'Normierter Vektor','verified',@revision_id),
('3.275',@section_id,'Normbedingung','verified',@revision_id),
('3.276',@section_id,'Orthonormalsystem','verified',@revision_id),
('3.277',@section_id,'Kronecker-Delta','verified',@revision_id),
('3.278',@section_id,'Definition Kronecker-Delta','verified',@revision_id),
('3.279',@section_id,'Aufspannbedingung','verified',@revision_id),
('3.280',@section_id,'Koordinatendarstellung','verified',@revision_id),
('3.281',@section_id,'Einheitsvektor','verified',@revision_id),
('3.282',@section_id,'Projektionsoperator','verified',@revision_id),
('3.283',@section_id,'Projektionsmatrix','verified',@revision_id),
('3.284',@section_id,'Idempotenz','verified',@revision_id),
('3.285',@section_id,'Symmetrie','verified',@revision_id),
('3.286',@section_id,'Beispielvektor','verified',@revision_id),
('3.287',@section_id,'Projektionsmatrix Beispiel','verified',@revision_id),
('3.288',@section_id,'Beispielvektor v','verified',@revision_id),
('3.289',@section_id,'Projizierter Vektor','verified',@revision_id),
('3.290',@section_id,'Gram-Schmidt Ausgangsbasis','verified',@revision_id),
('3.291',@section_id,'Gram-Schmidt Schritt','verified',@revision_id),
('3.292',@section_id,'Normierung','verified',@revision_id),
('3.293',@section_id,'Orthogonale Matrix','verified',@revision_id),
('3.294',@section_id,'Inverse = Transponierte','verified',@revision_id)
ON DUPLICATE KEY UPDATE title=VALUES(title);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked,created_revision_id)
SELECT source_id,@section_id,'definition',
'Grundlagen zu Orthogonalität, Projektionen und Orthonormalbasen.',
0,1,@revision_id
FROM sources
WHERE citation_number IN (71,74,76,82);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary)
VALUES
(@revision_id,@section_id,'created','section','3.2.11','Abschnitt vollständig aufgenommen.'),
(@revision_id,@section_id,'definition_added','definition','3.2.29–3.2.32','Vier Definitionen ergänzt.'),
(@revision_id,@section_id,'equation_added','equation','3.272–3.294','23 Gleichungen ergänzt.');

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.12'),
('last_completed_section','3.2.11'),
('last_definition_number','3.2.32'),
('next_definition_number','3.2.33'),
('last_equation_number','3.294'),
('next_equation_number','3.295'),
('last_citation_number','83'),
('next_citation_number','84')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
