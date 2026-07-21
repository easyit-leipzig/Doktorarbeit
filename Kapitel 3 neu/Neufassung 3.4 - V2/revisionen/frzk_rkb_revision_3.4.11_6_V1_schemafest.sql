/* FRZK-RKB Repository Update
   3.4.11.6 Emergenz funktionaler Organisationsstrukturen
   Gleichungen 3.1123-3.1136
   Definitionen 3.4.75-3.4.76
   Lemma 3.4.24
   Satz 3.4.25
   Korollar 3.4.20
*/

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4.11.6-V1';

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
@revision_code,NOW(),'section','3.4.11.6','1.0-complete',
'Emergenz funktionaler Organisationsstrukturen durch Kopplung lokaler Dynamiken.',
'Olaf Thiele / ChatGPT',NULL
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SELECT revision_id INTO @revision_id
FROM repository_revisions
WHERE revision_code=@revision_code
LIMIT 1;

/* Definitionen */

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Definition 3.4.75',@section_id,'Funktionale Emergenz',
'Eine funktionale Eigenschaft entsteht aus der Kopplung mehrerer funktionaler Strukturen.',
'E_F(\\mathfrak{RZ}_{F}^{glob})\\neq\\sum_{\\alpha}E_F(\\mathfrak{RZ}_{F,\\alpha})',
'E_F(\\mathfrak{RZ}_{F}^{glob})\\neq\\sum_{\\alpha}E_F(\\mathfrak{RZ}_{F,\\alpha})',
'original',NULL,'Mehrere gekoppelte Strukturen.','Neue Organisationsebene.','checked',@revision_id),

('Definition 3.4.76',@section_id,'Funktionale Kopplungsstruktur',
'Eine Kopplungsstruktur beschreibt zusätzliche Relationen zwischen funktionalen Strukturen.',
'\\mathcal C_F\\subset\\mathcal R_F',
'\\mathcal C_F\\subset\\mathcal R_F',
'original',NULL,'Funktionale Relationen vorhanden.','Grundlage funktionaler Emergenz.','checked',@revision_id);

/* Lemma */

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.24',@section_id,'Neue Eigenschaften durch Kopplung',
'Gekoppelte funktionale Strukturen können eine neue gemeinsame Organisationsstruktur bilden.',
'\\mathfrak{RZ}_{F}^{new}\\supset\\mathfrak{RZ}_{F,1}\\cup\\mathfrak{RZ}_{F,2}',
'\\mathfrak{RZ}_{F}^{new}\\supset\\mathfrak{RZ}_{F,1}\\cup\\mathfrak{RZ}_{F,2}',
'original',NULL,'Kopplungsrelationen vorhanden.','checked',@revision_id);

/* Satz */

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.25',@section_id,'Emergenz durch funktionale Rekonfiguration',
'Gekoppelte kohärente Strukturen können eine neue stabile Organisationsebene erzeugen.',
'\\exists\\mathcal E_F^{new}',
'\\exists\\mathcal E_F^{new}',
'original',NULL,'Stabile Kopplung.','checked',@revision_id);

/* Korollar */

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.20',@section_id,'Emergenz ohne neue Grundelemente',
'Neue funktionale Organisation entsteht durch neue Ordnung vorhandener Elemente.',
'\\Delta\\mathcal R_F\\Rightarrow\\Delta\\mathcal O_F\\Rightarrow\\Delta\\mathfrak{RZ}_F',
'\\Delta\\mathcal R_F\\Rightarrow\\Delta\\mathcal O_F\\Rightarrow\\Delta\\mathfrak{RZ}_F',
NULL,'original',NULL,'checked',@revision_id);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_repository_revision','RKB-REV-K3.4.11.6-V1'),
('next_equation_number','3.1137')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
