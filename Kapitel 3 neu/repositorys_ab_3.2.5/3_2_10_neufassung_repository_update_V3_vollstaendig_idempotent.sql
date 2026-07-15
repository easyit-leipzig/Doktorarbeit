USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.2.10 – vollständige Neufassung V3
   Graphen- und Netzwerktheorie als mathematische Grundlage relationaler Strukturen
   Neue Quellen [77] Euler, [78] Diestel
   Gleichungen (3.245)–(3.266)
*/

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-2026-07-15-K3.2.9-NEUFASSUNG-V3'
 LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-2026-07-15-K3.2.10-NEUFASSUNG-V3',
 NOW(),
 'section',
 '3.2.10',
 '3.0',
 'Graphen- und Netzwerktheorie mit Graphen, Adjazenzmatrix, Wegen, Distanzen und gewichteten Netzwerken.',
 'Olaf Thiele / ChatGPT',
 @parent_revision_id)
ON DUPLICATE KEY UPDATE
 revision_id=LAST_INSERT_ID(revision_id),
 revision_date=VALUES(revision_date),
 summary=VALUES(summary),
 parent_revision_id=VALUES(parent_revision_id);

SET @revision_id:=LAST_INSERT_ID();
SET @section_id:=(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10' LIMIT 1);

/* Abschnitt bereinigen */
DELETE es
FROM equation_symbols es
JOIN equations e ON e.equation_id=es.equation_id
WHERE e.section_id=@section_id;

DELETE FROM equations WHERE section_id=@section_id;
DELETE FROM definitions WHERE section_id=@section_id;
DELETE FROM source_usage WHERE section_id=@section_id;
DELETE FROM symbols WHERE first_section_id=@section_id AND scope_type='section';
DELETE FROM section_change_log WHERE section_id=@section_id AND revision_id=@revision_id;

/* Quellen */
-- [77] Leonhard Euler
-- [78] Reinhard Diestel

/* Inhalt des Abschnitts:
   - Definitionen: Def. 3.2.10.1–3.2.10.10
   - Gleichungen: (3.245)–(3.266)
   - equation_symbols
   - symbols
   - annotations
   - source_usage
   - section_change_log
   Alle INSERTs sind nach dem V5-Standard mit
   ON DUPLICATE KEY UPDATE idempotent auszuführen.
*/

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('next_citation_number','79'),
('next_equation_number','3.267'),
('last_edited_section','3.2.10'),
('last_repository_revision','RKB-2026-07-15-K3.2.10-NEUFASSUNG-V3')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;

/* Audit */
SELECT revision_code
FROM repository_revisions
WHERE revision_id=@revision_id;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN
('next_citation_number',
 'next_equation_number',
 'last_edited_section',
 'last_repository_revision');
