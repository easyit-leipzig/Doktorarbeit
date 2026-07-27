/* ============================================================
   FRZK-RKB
   FINAL AUDIT – KAPITEL 3
   Kapitel 3.1–3.9
   ============================================================ */

START TRANSACTION;

/* ------------------------------------------------------------
   Abschluss-Revision
------------------------------------------------------------ */

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
 'RKB-2026-07-25-KAPITEL3-FINAL',
 NOW(),
 'chapter',
 '3',
 '1.0',
 'Kapitel 3 vollständig abgeschlossen (3.1–3.9).',
 'Olaf Thiele / ChatGPT',
 NULL
WHERE NOT EXISTS
(
 SELECT 1
 FROM repository_revisions
 WHERE revision_code='RKB-2026-07-25-KAPITEL3-FINAL'
);

SET @revision_id :=
(
 SELECT revision_id
 FROM repository_revisions
 WHERE revision_code='RKB-2026-07-25-KAPITEL3-FINAL'
 LIMIT 1
);

/* ------------------------------------------------------------
   Kapitelstatus
------------------------------------------------------------ */

UPDATE dissertation_sections
SET status='completed'
WHERE section_code='3.9';

UPDATE dissertation_sections
SET status='completed'
WHERE section_code='3';

/* ------------------------------------------------------------
   Kapitel-IDs
------------------------------------------------------------ */

SET @chapter3 :=
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3'
 LIMIT 1
);

/* ------------------------------------------------------------
   Abschlussprotokoll
------------------------------------------------------------ */

INSERT INTO section_change_log
(
 revision_id,
 section_id,
 change_type,
 object_type,
 object_reference,
 change_summary,
 previous_value,
 new_value,
 changed_at
)
SELECT
 @revision_id,
 @chapter3,
 'completed',
 'chapter',
 '3',
 'Kapitel 3 vollständig abgeschlossen.',
 'draft',
 'completed',
 NOW()
WHERE NOT EXISTS
(
 SELECT 1
 FROM section_change_log
 WHERE revision_id=@revision_id
   AND object_reference='3'
   AND change_type='completed'
);

/* ------------------------------------------------------------
   Kennzahlen
------------------------------------------------------------ */

SET @sections :=
(
 SELECT COUNT(*)
 FROM dissertation_sections
 WHERE section_code LIKE '3.%'
);

SET @equations :=
(
 SELECT COUNT(*)
 FROM equations
 WHERE equation_number REGEXP '^3\\.'
);

SET @definitions :=
(
 SELECT COUNT(*)
 FROM definitions
);

SET @lemmas :=
(
 SELECT COUNT(*)
 FROM lemmas
);

SET @theorems :=
(
 SELECT COUNT(*)
 FROM theorems
);

SET @corollaries :=
(
 SELECT COUNT(*)
 FROM corollaries
);

SET @symbols :=
(
 SELECT COUNT(*)
 FROM equation_symbols
);

SET @missing_wordlatex :=
(
 SELECT COUNT(*)
 FROM equations
 WHERE equation_number REGEXP '^3\\.'
   AND (word_latex IS NULL OR word_latex='')
);

/* ------------------------------------------------------------
   Validierungen
------------------------------------------------------------ */

INSERT INTO repository_validation_results
(
 revision_id,
 validation_code,
 validation_status,
 expected_value,
 actual_value,
 validation_message,
 checked_at
)
SELECT
 @revision_id,
 'CHAPTER3_FINAL',
 CASE WHEN @missing_wordlatex=0 THEN 'passed' ELSE 'warning' END,
 'Kapitel abgeschlossen',
 CONCAT('Abschnitte=',@sections,
 '; Gleichungen=',@equations,
 '; Definitionen=',@definitions,
 '; Lemmata=',@lemmas,
 '; Saetze=',@theorems,
 '; Korollare=',@corollaries,
 '; Symbole=',@symbols,
 '; Fehlendes WordLaTeX=',@missing_wordlatex),
 'Abschlussvalidierung Kapitel 3',
 NOW()
WHERE NOT EXISTS
(
 SELECT 1
 FROM repository_validation_results
 WHERE revision_id=@revision_id
   AND validation_code='CHAPTER3_FINAL'
);

COMMIT;

/* ------------------------------------------------------------
   Abschlussübersicht
------------------------------------------------------------ */

SELECT
 @sections AS sections,
 @equations AS equations,
 @definitions AS definitions,
 @lemmas AS lemmas,
 @theorems AS theorems,
 @corollaries AS corollaries,
 @symbols AS equation_symbols,
 @missing_wordlatex AS missing_wordlatex;

SELECT
 validation_code,
 validation_status,
 actual_value
FROM repository_validation_results
WHERE revision_id=@revision_id;
