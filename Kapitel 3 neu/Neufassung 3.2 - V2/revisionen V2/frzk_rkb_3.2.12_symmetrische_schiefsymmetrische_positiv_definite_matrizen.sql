-- FRZK-REPOSITORY-UPDATE
-- Kapitel 3.2.12: Symmetrische, schiefsymmetrische und positiv definite Matrizen
-- MariaDB 10.4 / MySQL-kompatibel

START TRANSACTION;

SET @parent_section_id := (
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.2' LIMIT 1
);

SET @parent_revision_id := (
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.11-V1' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.12-V1',NOW(),'section','3.2.12','3.2.12-v1',
'Aufnahme von Abschnitt 3.2.12 mit Definitionen 3.2.33 bis 3.2.36 und Gleichungen 3.295 bis 3.318.',
'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.12-V1'
);

SET @revision_id := (
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.12-V1' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section_id,'3.2.12',
'Symmetrische, schiefsymmetrische und positiv definite Matrizen',
3,3.21200,'final',0,
'Definitionen 3.2.33 bis 3.2.36; Gleichungen 3.295 bis 3.318; Quellen 71, 74, 76 und 82.'
WHERE NOT EXISTS (
    SELECT 1 FROM dissertation_sections WHERE section_code='3.2.12'
);

SET @section_id := (
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.2.12' LIMIT 1
);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
'3.2.33',@section_id,'Transponierte Matrix','Die transponierte Matrix entsteht durch Vertauschen von Zeilen und Spalten.','A^{\\mathrm T}=(a_{ji})','A^{\\mathrm T}=(a_{ji})','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.',
'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.33'
);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
'3.2.34',@section_id,'Symmetrische Matrix','Eine quadratische Matrix A heißt symmetrisch, wenn A^T=A gilt.','A^{\\mathrm T}=A','A^{\\mathrm T}=A','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.',
'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.34'
);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
'3.2.35',@section_id,'Schiefsymmetrische Matrix','Eine quadratische Matrix A heißt schiefsymmetrisch, wenn A^T=-A gilt.','A^{\\mathrm T}=-A','A^{\\mathrm T}=-A','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.',
'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.35'
);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
'3.2.36',@section_id,'Positiv definite Matrix','Eine reelle symmetrische Matrix A heißt positiv definit, wenn x^T A x für jeden von null verschiedenen Vektor x positiv ist.','x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0','x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.',
'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number='3.2.36'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.295',@section_id,'Allgemeine Matrix','A=(a_{ij})\\in\\mathbb{R}^{m\\times n}','A=(a_{ij})\\in\\mathbb{R}^{m\\times n}',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.295'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.296',@section_id,'Transponierte Matrix','A^{\\mathrm T}=(a_{ji})','A^{\\mathrm T}=(a_{ji})',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.296'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.297',@section_id,'Doppelte Transposition','(A^{\\mathrm T})^{\\mathrm T}=A','(A^{\\mathrm T})^{\\mathrm T}=A',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.297'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.298',@section_id,'Symmetriebedingung','A^{\\mathrm T}=A','A^{\\mathrm T}=A',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.298'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.299',@section_id,'Beispiel einer symmetrischen Matrix','A=\\begin{pmatrix}2&3\\\\3&5 \\end{pmatrix}','A=\\begin{pmatrix}2&3\\\\3&5 \\end{pmatrix}',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.299'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.300',@section_id,'Symmetrieprüfung','A^{\\mathrm T}=A','A^{\\mathrm T}=A',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.300'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.301',@section_id,'Schiefsymmetriebedingung','A^{\\mathrm T}=-A','A^{\\mathrm T}=-A',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.301'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.302',@section_id,'Diagonaleinträge schiefsymmetrischer Matrizen','a_{ii}=0\\qquad(i=1,\\ldots,n)','a_{ii}=0\\qquad(i=1,\\ldots,n)',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.302'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.303',@section_id,'Beispiel einer schiefsymmetrischen Matrix','A=\\begin{pmatrix}0&2\\\\-2&0 \\end{pmatrix}','A=\\begin{pmatrix}0&2\\\\-2&0 \\end{pmatrix}',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.303'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.304',@section_id,'Schiefsymmetrieprüfung','A^{\\mathrm T}=-A','A^{\\mathrm T}=-A',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.304'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.305',@section_id,'Positive Definitheit','x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0','x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.305'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.306',@section_id,'Quadratische Form','x^{\\mathrm T}Ax','x^{\\mathrm T}Ax',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.306'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.307',@section_id,'Positiv definite Diagonalmatrix','A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}','A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.307'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.308',@section_id,'Allgemeiner zweidimensionaler Vektor','x=\\begin{pmatrix}x_1\\\\x_2 \\end{pmatrix}','x=\\begin{pmatrix}x_1\\\\x_2 \\end{pmatrix}',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.308'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.309',@section_id,'Quadratische Form des Beispiels','x^{\\mathrm T}Ax=2x_1^2+3x_2^2','x^{\\mathrm T}Ax=2x_1^2+3x_2^2',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.309'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.310',@section_id,'Positivitätsnachweis','x^{\\mathrm T}Ax>0\\qquad(x\\neq0)','x^{\\mathrm T}Ax>0\\qquad(x\\neq0)',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.310'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.311',@section_id,'Positive Eigenwerte','\\lambda_i>0\\qquad(i=1,\\ldots,n)','\\lambda_i>0\\qquad(i=1,\\ldots,n)',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.311'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.312',@section_id,'Orthogonale Diagonalisierungsmatrix','Q','Q',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.312'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.313',@section_id,'Orthogonale Diagonalisierung','Q^{\\mathrm T}AQ=D','Q^{\\mathrm T}AQ=D',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.313'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.314',@section_id,'Diagonalmatrix der Eigenwerte','D=\\operatorname{diag}(\\lambda_1,\\ldots,\\lambda_n)','D=\\operatorname{diag}(\\lambda_1,\\ldots,\\lambda_n)',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.314'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.315',@section_id,'Quadratische Form als Funktion','q(x)=x^{\\mathrm T}Ax','q(x)=x^{\\mathrm T}Ax',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.315'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.316',@section_id,'Quadratische Zielfunktion','f(x)=\\frac12x^{\\mathrm T}Ax-b^{\\mathrm T}x','f(x)=\\frac12x^{\\mathrm T}Ax-b^{\\mathrm T}x',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.316'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.317',@section_id,'Gradientenbedingung','\\nabla f(x)=Ax-b=0','\\nabla f(x)=Ax-b=0',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.317'
);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
'3.318',@section_id,'Lineares Gleichungssystem','Ax=b','Ax=b',
'Gleichung aus Abschnitt 3.2.12.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.',
'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.318'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT
s.source_id,@section_id,
CASE WHEN s.citation_number=74 THEN 'example'
     WHEN s.citation_number=76 THEN 'theory'
     WHEN s.citation_number=82 THEN 'context'
     ELSE 'definition' END,
'Grundlagen zu Transposition, Symmetrie, Schiefsymmetrie, quadratischen Formen, Spektralsatz und positiver Definitheit.',
'Abschnitt 3.2.12',0,1,
CONCAT('Wiederverwendung der Literaturstelle [',s.citation_number,'].'),
@revision_id
FROM sources s
WHERE s.citation_number IN (71,74,76,82)
AND NOT EXISTS (
    SELECT 1 FROM source_usage su
    WHERE su.source_id=s.source_id AND su.section_id=@section_id
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_id,'created','section','3.2.12',
 'Abschnitt 3.2.12 wurde angelegt und finalisiert.',NULL,
 'Definitionen 3.2.33 bis 3.2.36; Gleichungen 3.295 bis 3.318.'),
(@revision_id,@section_id,'definition_added','definition','3.2.33-3.2.36',
 'Vier Definitionen wurden aufgenommen.','Letzte Definition: 3.2.32.','Letzte Definition: 3.2.36.'),
(@revision_id,@section_id,'equation_added','equation','3.295-3.318',
 'Vierundzwanzig Gleichungen wurden aufgenommen.','Letzte Gleichung: 3.294.','Letzte Gleichung: 3.318.'),
(@revision_id,@section_id,'source_reused','source','71,74,76,82',
 'Vorhandene Literaturstellen wurden verknüpft.','Letzte Literaturstelle: 83.','Letzte Literaturstelle bleibt 83.');

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.13'),
('last_completed_section','3.2.12'),
('last_definition_number','3.2.36'),
('next_definition_number','3.2.37'),
('last_equation_number','3.318'),
('next_equation_number','3.319'),
('last_citation_number','83'),
('next_citation_number','84')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;

SELECT
@revision_id AS revision_id,
@section_id AS section_id,
(SELECT COUNT(*) FROM definitions WHERE section_id=@section_id) AS definitions_count,
(SELECT COUNT(*) FROM equations WHERE section_id=@section_id) AS equations_count,
(SELECT COUNT(*) FROM source_usage WHERE section_id=@section_id) AS source_usage_count,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_definition_number') AS next_definition_number,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_equation_number') AS next_equation_number,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_citation_number') AS next_citation_number;
