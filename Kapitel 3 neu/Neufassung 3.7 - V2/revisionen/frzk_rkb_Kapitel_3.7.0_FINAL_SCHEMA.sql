/* FRZK-RKB Kapitel 3.7.0 FINAL_SCHEMA
   Funktionale Operatorenkaskade und technische Operationalisierung des FRZK
*/

START TRANSACTION;

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
 'RKB-K3.7.0-V1',
 NOW(),
 'section',
 '3.7.0',
 '1.0',
 'Beginn Kapitel 3.7 Funktionale Operatorenkaskade und technische Operationalisierung des FRZK.',
 'Olaf Thiele',
 (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS
(
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-K3.7.0-V1'
);

SET @revision_id =
(
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-K3.7.0-V1'
 LIMIT 1
);

INSERT INTO dissertation_sections
(
 section_code,title,chapter_no,section_order,status,
 is_original_contribution,notes
)
SELECT
 '3.7',
 'Funktionale Operatorenkaskade und technische Operationalisierung des FRZK',
 3,3.7,'in_progress',1,
 'Operationalisierung der funktionalen Strukturen.'
WHERE NOT EXISTS
(
 SELECT 1 FROM dissertation_sections WHERE section_code='3.7'
);

SET @chapter_id =
(
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.7' LIMIT 1
);

INSERT INTO dissertation_sections
(
 parent_section_id,section_code,title,chapter_no,
 section_order,status,is_original_contribution,notes
)
SELECT
 @chapter_id,'3.7.0','Einleitung',3,3.7001,
 'completed',1,'Einleitung Kapitel 3.7.'
WHERE NOT EXISTS
(
 SELECT 1 FROM dissertation_sections WHERE section_code='3.7.0'
);

SET @section_id =
(
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.7.0' LIMIT 1
);

INSERT INTO equations
(
 equation_number,section_id,title,equation_latex,
 word_latex,plain_description,equation_type,
 provenance,validation_status,created_revision_id
)
SELECT
 '3.432',@section_id,
 'Operatorenkaskade als rekursive Transformation',
 'S_n=O_n\circ O_{n-1}\circ...\circ O_1(S_0)',
 'S_n=O_n\circ O_{n-1}\circ...\circ O_1(S_0)',
 'Darstellung einer Folge funktionaler Transformationen.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.432'
);

INSERT INTO equations
(
 equation_number,section_id,title,equation_latex,
 word_latex,plain_description,equation_type,
 provenance,validation_status,created_revision_id
)
SELECT
 '3.433',@section_id,
 'Entwicklungsfolge funktionaler Organisation',
 '\emptyset\rightarrow\text{Unterscheidbarkeit}\rightarrow\text{Relation}\rightarrow\text{Transformation}\rightarrow\text{Organisation}\rightarrow\text{Kohärenz}\rightarrow\text{Operatorenkaskade}',
 '\emptyset\rightarrow\text{Unterscheidbarkeit}\rightarrow\text{Relation}\rightarrow\text{Transformation}\rightarrow\text{Organisation}\rightarrow\text{Kohärenz}\rightarrow\text{Operatorenkaskade}',
 'Logische Entwicklungsfolge des FRZK.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.433'
);

INSERT INTO definitions
(
 section_id,title,definition_text,
 provenance,validation_status,created_revision_id
)
SELECT
 @section_id,
 'Funktionale Operatorenkaskade',
 'Eine funktionale Operatorenkaskade bezeichnet eine geordnete Folge zulässiger Transformationen.',
 'original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM definitions
 WHERE title='Funktionale Operatorenkaskade'
);

INSERT INTO symbols
(
 symbol_latex,symbol_word_latex,symbol_name,
 definition_text,scope_type,first_section_id,
 validation_status,created_revision_id
)
SELECT
 'S_0','S_0','Ausgangszustand',
 'Ausgangszustand einer funktionalen Organisation.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='S_0'
);

INSERT INTO symbols
(
 symbol_latex,symbol_word_latex,symbol_name,
 definition_text,scope_type,first_section_id,
 validation_status,created_revision_id
)
SELECT
 'S_n','S_n','Transformierter Zustand',
 'Zustand nach n Transformationen.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='S_n'
);

INSERT INTO symbols
(
 symbol_latex,symbol_word_latex,symbol_name,
 definition_text,scope_type,first_section_id,
 validation_status,created_revision_id
)
SELECT
 'O_n','O_n','Transformationsoperator',
 'n-ter Transformationsoperator.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='O_n'
);

INSERT INTO section_change_log
(
 revision_id,section_id,change_type,
 object_type,object_reference,
 change_summary,previous_value,new_value
)
VALUES
(
 @revision_id,@section_id,'created',
 'section','3.7.0',
 'Kapitel 3.7.0 Repository-Eintrag erstellt.',
 NULL,'completed'
);

COMMIT;
