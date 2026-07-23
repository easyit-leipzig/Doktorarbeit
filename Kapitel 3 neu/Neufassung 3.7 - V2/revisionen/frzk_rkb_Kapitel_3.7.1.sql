/* ============================================================================
   FRZK-RKB Repository Update
   Kapitel 3.7.1
   Definition und Eigenschaften der funktionalen Operatorenkaskade
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.1 anlegen
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
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.1',
 'Definition und Eigenschaften der funktionalen Operatorenkaskade',
 3,
 3.7100,
 'in_progress',
 1,
 'Formale Definition der Operatorenkaskade und ihrer Eigenschaften im FRZK.'
WHERE NOT EXISTS
(
 SELECT 1 FROM dissertation_sections WHERE section_code='3.7.1'
);

SET @section_id =
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.7.1'
 LIMIT 1
);

-- Neue Revision erzeugen
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
 'RKB-K3.7.1-V1',
 NOW(),
 'section',
 '3.7.1',
 '1.0',
 'Definition und Eigenschaften der funktionalen Operatorenkaskade',
 'Olaf Thiele',
 (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS
(
 SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.1-V1'
);

SET @revision_id =
(
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-K3.7.1-V1'
 LIMIT 1
);

-- Gleichung: Operatorenkaskade allgemein
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.434',
 @section_id,
 'Operatorenkaskade als geordnete Folge',
 'S_n = O_n \circ O_{n-1} \circ ... \circ O_1(S_0)',
 'S_n = O_n \circ O_{n-1} \circ ... \circ O_1(S_0)',
 'Darstellung einer Operatorenkaskade als geordnete Folge funktionaler Transformationen.',
 'definition',
 'original',
 'draft',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.434'
);

-- Gleichung: Eigenschaften der Kaskade (rekursiv)
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.435',
 @section_id,
 'Rekursiver Endzustand',
 'S_{n+1} = O_{n+1}(S_n)',
 'S_{n+1} = O_{n+1}(S_n)',
 'Jeder Operator der Kaskade erzeugt den nächsten Zustand aus dem vorherigen.',
 'definition',
 'original',
 'draft',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.435'
);

-- Definition der Operatorenkaskade
INSERT INTO definitions
(
 section_id,
 title,
 definition_text,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 @section_id,
 'Funktionale Operatorenkaskade',
 'Eine funktionale Operatorenkaskade ist eine geordnete Folge von zulässigen Transformationen, deren sukzessive Anwendung neue funktionale Organisationszustände erzeugt.',
 'original',
 'draft',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM definitions WHERE title='Funktionale Operatorenkaskade'
);

-- Symbole registrieren
INSERT INTO symbols
(
 symbol_latex,
 symbol_word_latex,
 symbol_name,
 definition_text,
 scope_type,
 first_section_id,
 validation_status,
 created_revision_id
)
SELECT
 'S_n','S_n','Zustand nach n Transformationen',
 'Zustand nach n aufeinanderfolgenden Operatoren.',
 'section',
 @section_id,
 'draft',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='S_n'
);

INSERT INTO symbols
(
 symbol_latex,
 symbol_word_latex,
 symbol_name,
 definition_text,
 scope_type,
 first_section_id,
 validation_status,
 created_revision_id
)
SELECT
 'O_n','O_n','Transformationsoperator',
 'n-ter Transformationsoperator innerhalb der Operatorenkaskade.',
 'section',
 @section_id,
 'draft',
 @revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='O_n'
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
VALUES
(
 @revision_id,
 @section_id,
 'created',
 'section',
 '3.7.1',
 'Kapitel 3.7.1 Definition und Eigenschaften der Operatorenkaskade angelegt.',
 NULL,
 'in_progress'
);

COMMIT;