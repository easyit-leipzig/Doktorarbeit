/* ============================================================
   FRZK-RKB Abschlussupdate Kapitel 3.4 V3

   Korrektur:
   section_change_log nur mit bestätigten Feldern

   Inhalt:
   - Abschluss-Audit Kapitel 3.4
   - Kapitelstatus final
   - Repository-Zähler
   ============================================================ */

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4-ABSCHLUSS-V3';

SELECT section_id INTO @chapter_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;


/* Revision anlegen */

INSERT INTO repository_revisions
(
 revision_code,
 revision_date,
 scope_type,
 scope_reference,
 version_label,
 summary,
 created_by,
 parent_revision_id
)
SELECT
 @revision_code,
 NOW(),
 'chapter',
 '3.4',
 '1.0-final',
 'Abschlussrevision Kapitel 3.4 nach Audit-Schema-Korrektur.',
 'Olaf Thiele / ChatGPT',
 NULL
WHERE NOT EXISTS
(
 SELECT 1
 FROM repository_revisions
 WHERE revision_code=@revision_code
);


SELECT revision_id INTO @revision_id
FROM repository_revisions
WHERE revision_code=@revision_code
LIMIT 1;


/* ============================================================
   Abschluss-Audit
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
 @chapter_id,
 @revision_id,
 'completed',
 'chapter',
 '3.4',
 NOW()
);


/* ============================================================
   Kapitelstatus
   ============================================================ */

UPDATE dissertation_sections
SET
 status='final',
 notes=CONCAT(
 COALESCE(notes,''),
 ' Kapitel 3.4 abgeschlossen.',
 ' Mathematische Rekonstruktion funktionaler Organisation vollständig dokumentiert.',
 ' Dynamik, Stabilität, Instabilität, Emergenz und Selbstorganisation integriert.'
 )
WHERE section_code='3.4';


/* ============================================================
   Repository-Zähler
   ============================================================ */

INSERT INTO repository_counters
(
 counter_key,
 counter_value
)
VALUES
('last_completed_section','3.4'),
('last_repository_revision','RKB-REV-K3.4-ABSCHLUSS-V3'),
('next_equation_number','3.1167'),
('next_citation_number','55')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);


COMMIT;
