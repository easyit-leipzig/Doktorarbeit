-- FRZK Repository Update 3.2.8
START TRANSACTION;

SET @parent_section_id := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);
SET @parent_revision_id := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.7-V1' LIMIT 1);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.8-V1',NOW(),'section','3.2.8','3.2.8-v1',
'Abschnitt 3.2.8 mit Definition 3.2.22 und Gleichungen (3.167) bis (3.204).',
'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_section_id IS NOT NULL AND @parent_revision_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.8-V1');

SET @revision_id := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.8-V1' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section_id,'3.2.8','Determinanten, Orientierung und Volumenänderung',3,3.2800,'final',0,
'Definition 3.2.22; Gleichungen (3.167) bis (3.204); Quellen [71], [74] und [82].'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.8');

SET @section_id := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8' LIMIT 1);

UPDATE dissertation_sections SET parent_section_id=@parent_section_id,
title='Determinanten, Orientierung und Volumenänderung',chapter_no=3,section_order=3.2800,status='final',
is_original_contribution=0,notes='Definition 3.2.22; Gleichungen (3.167) bis (3.204); Quellen [71], [74] und [82].'
WHERE section_id=@section_id;

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.2.22',@section_id,'Determinante einer quadratischen Matrix',
'Die Determinante einer quadratischen Matrix A ist eine reelle Zahl und beschreibt den orientierten Volumenskalierungsfaktor der zugehörigen linearen Abbildung.',
'\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}',
'\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}',
'adapted',(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Quadratische Matrizen und lineare Abbildungen sind definiert.',
'Etablierte Definition; keine FRZK-spezifische Eigenleistung.','verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.2.22');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.167',@section_id,'Quadratische Matrix','A\\in\\mathbb{R}^{n\\times n}','A\\in\\mathbb{R}^{n\\times n}','A ist eine reelle quadratische n-mal-n-Matrix.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.167');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.168',@section_id,'Determinantennotation','\\det(A)','\\det(A)','Notation der Determinante.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.168');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.169',@section_id,'Alternative Determinantennotation','|A|','|A|','Alternative Notation der Determinante.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.169');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.170',@section_id,'Determinante als Abbildung','\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}','\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}','Die Determinante ordnet jeder quadratischen Matrix einen reellen Skalar zu.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.170');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.171',@section_id,'Allgemeine 2x2-Matrix','A=\\begin{pmatrix}a&b\\\\c&d \\end{pmatrix}','A=\\begin{pmatrix}a&b\\\\c&d \\end{pmatrix}','Allgemeine reelle 2x2-Matrix.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.171');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.172',@section_id,'Determinante einer 2x2-Matrix','\\det(A)=\\begin{matrix}a&b\\\\c&d \\end{matrix}=ad-bc','\\det(A)=\\begin{matrix}a&b\\\\c&d \\end{matrix}=ad-bc','Berechnung der Determinante einer 2x2-Matrix.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.172');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.173',@section_id,'Diagonalmatrix im Beispiel','A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}','A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}','Beispiel einer diagonalen Matrix.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.173');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.174',@section_id,'Determinante des Beispiels','\\det(A)=2\\cdot3-0\\cdot0=6','\\det(A)=2\\cdot3-0\\cdot0=6','Berechnung der Determinante des Beispiels.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.174');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.175',@section_id,'Allgemeine 3x3-Matrix','A=\\begin{pmatrix}a_{11}&a_{12}&a_{13}\\\\a_{21}&a_{22}&a_{23}\\\\a_{31}&a_{32}&a_{33} \\end{pmatrix}','A=\\begin{pmatrix}a_{11}&a_{12}&a_{13}\\\\a_{21}&a_{22}&a_{23}\\\\a_{31}&a_{32}&a_{33} \\end{pmatrix}','Allgemeine reelle 3x3-Matrix.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.175');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.176',@section_id,'Laplace-Entwicklung','\\det(A)=a_{11}\\begin{matrix}a_{22}&a_{23}\\\\a_{32}&a_{33} \\end{matrix}-a_{12}\\begin{matrix}a_{21}&a_{23}\\\\a_{31}&a_{33} \\end{matrix}+a_{13}\\begin{matrix}a_{21}&a_{22}\\\\a_{31}&a_{32} \\end{matrix}','\\det(A)=a_{11}\\begin{matrix}a_{22}&a_{23}\\\\a_{32}&a_{33} \\end{matrix}-a_{12}\\begin{matrix}a_{21}&a_{23}\\\\a_{31}&a_{33} \\end{matrix}+a_{13}\\begin{matrix}a_{21}&a_{22}\\\\a_{31}&a_{32} \\end{matrix}','Laplace-Entwicklung nach der ersten Zeile.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.176');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.177',@section_id,'Lineare Abbildung zur Matrix','T_A:\\mathbb{R}^n\\rightarrow\\mathbb{R}^n','T_A:\\mathbb{R}^n\\rightarrow\\mathbb{R}^n','Durch A dargestellte lineare Abbildung.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.177');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.178',@section_id,'Volumenskalierung','\\operatorname{Vol}(T_A(M))=|\\det(A)|\\operatorname{Vol}(M)','\\operatorname{Vol}(T_A(M))=|\\det(A)|\\operatorname{Vol}(M)','Der Betrag der Determinante skaliert Volumina.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.178');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.179',@section_id,'Volumenvergrößerung','|\\det(A)|>1','|\\det(A)|>1','Bedingung für Volumenvergrößerung.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.179');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.180',@section_id,'Volumenverkleinerung','0<|\\det(A)|<1','0<|\\det(A)|<1','Bedingung für Volumenverkleinerung.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.180');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.181',@section_id,'Volumenerhaltung','|\\det(A)|=1','|\\det(A)|=1','Bedingung für Volumenerhaltung.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.181');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.182',@section_id,'Positive Determinante','\\det(A)>0','\\det(A)>0','Orientierungserhaltende Transformation.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.182');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.183',@section_id,'Negative Determinante','\\det(A)<0','\\det(A)<0','Orientierungsumkehrende Transformation.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.183');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.184',@section_id,'Spiegelungsmatrix','S=\\begin{pmatrix}-1&0\\\\0&1 \\end{pmatrix}','S=\\begin{pmatrix}-1&0\\\\0&1 \\end{pmatrix}','Beispiel einer Spiegelungsmatrix.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.184');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.185',@section_id,'Determinante der Spiegelung','\\det(S)=-1','\\det(S)=-1','Determinante der Spiegelungsmatrix.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.185');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.186',@section_id,'Singularitätsbedingung','\\det(A)=0','\\det(A)=0','Bedingung für Singularität.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.186');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.187',@section_id,'Regularitätsbedingung','\\det(A)\\neq0','\\det(A)\\neq0','Bedingung für Regularität.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.187');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.188',@section_id,'Invertierbarkeitskriterium','A\\text{ ist invertierbar}\\iff\\det(A)\\neq0','A\\text{ ist invertierbar}\\iff\\det(A)\\neq0','Äquivalenz von Invertierbarkeit und nichtverschwindender Determinante.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.188');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.189',@section_id,'Singuläre Beispielmatrix','A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}','A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}','Beispiel einer singulären Matrix.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.189');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.190',@section_id,'Determinante der singulären Matrix','\\det(A)=1\\cdot4-2\\cdot2=0','\\det(A)=1\\cdot4-2\\cdot2=0','Berechnung der verschwindenden Determinante.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.190');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.191',@section_id,'Lineare Abhängigkeit der Spalten','\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}','\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}','Die zweite Spalte ist ein Vielfaches der ersten.','example','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.191');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.192',@section_id,'Nichtverschwindende Determinante','\\det(A)\\neq0','\\det(A)\\neq0','Ausgangspunkt der Äquivalenzbedingungen.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.192');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.193',@section_id,'Voller Rang','\\operatorname{rang}(A)=n','\\operatorname{rang}(A)=n','Reguläre quadratische Matrix mit vollem Rang.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.193');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.194',@section_id,'Inverse Matrix','A^{-1}','A^{-1}','Notation der inversen Matrix.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.194');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.195',@section_id,'Äquivalenzen regulärer Matrizen','\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff A^{-1}\\text{ existiert}','\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff A^{-1}\\text{ existiert}','Äquivalenz von Determinante, Rang und Invertierbarkeit.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.195');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.196',@section_id,'Quadratische Matrizen A und B','A,B\\in\\mathbb{R}^{n\\times n}','A,B\\in\\mathbb{R}^{n\\times n}','Zwei quadratische Matrizen gleicher Ordnung.','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.196');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.197',@section_id,'Multiplikativität','\\det(AB)=\\det(A)\\det(B)','\\det(AB)=\\det(A)\\det(B)','Multiplikativität der Determinante.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.197');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.198',@section_id,'Inverse Identitätsbeziehung','AA^{-1}=I','AA^{-1}=I','Produkt einer Matrix mit ihrer Inversen.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.198');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.199',@section_id,'Determinante der Einheitsmatrix','\\det(I)=1','\\det(I)=1','Die Einheitsmatrix besitzt Determinante eins.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.199');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.200',@section_id,'Determinante der inversen Matrix','\\det(A^{-1})=\\frac{1}{\\det(A)}','\\det(A^{-1})=\\frac{1}{\\det(A)}','Kehrwertbeziehung der Determinanten.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.200');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.201',@section_id,'Ähnlichkeitstransformation','A_C=P^{-1}A_BP','A_C=P^{-1}A_BP','Darstellung desselben Operators in einer anderen Basis.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.201');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.202',@section_id,'Determinante der Ähnlichkeitstransformation','\\det(A_C)=\\det(P^{-1})\\det(A_B)\\det(P)','\\det(A_C)=\\det(P^{-1})\\det(A_B)\\det(P)','Multiplikativität bei Ähnlichkeitstransformationen.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.202');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.203',@section_id,'Determinantenprodukt inverser Matrizen','\\det(P^{-1})\\det(P)=1','\\det(P^{-1})\\det(P)=1','Produkt der Determinanten inverser Matrizen.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.203');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.204',@section_id,'Basisinvarianz der Determinante','\\det(A_C)=\\det(A_B)','\\det(A_C)=\\det(A_B)','Ähnliche Matrizen besitzen dieselbe Determinante.','derived','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.',
'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.',
'verified',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.204');


INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,
CASE WHEN s.citation_number=74 THEN 'example' ELSE 'definition' END,
CASE s.citation_number
WHEN 71 THEN 'Lang stützt Definition und algebraische Eigenschaften der Determinante.'
WHEN 74 THEN 'Strang stützt geometrische Interpretation und Rechenbeispiele.'
WHEN 82 THEN 'Halmos stützt die abstrakte Einordnung und Basisinvarianz.'
END,
'Abschnitt 3.2.8',0,1,CONCAT('Wiederverwendung der Literaturstelle [',s.citation_number,'].'),
@revision_id
FROM sources s
WHERE s.citation_number IN (71,74,82)
AND NOT EXISTS (SELECT 1 FROM source_usage su WHERE su.source_id=s.source_id AND su.section_id=@section_id);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_id,'created','section','3.2.8','Abschnitt 3.2.8 wurde angelegt.',NULL,'Definition 3.2.22; Gleichungen (3.167) bis (3.204).'),
(@revision_id,@section_id,'definition_added','definition','3.2.22','Definition der Determinante aufgenommen.','Letzte Definition: 3.2.21.','Letzte Definition: 3.2.22.'),
(@revision_id,@section_id,'equation_added','equation','(3.167)–(3.204)','38 Gleichungen aufgenommen.','Letzte Gleichung: (3.166).','Letzte Gleichung: (3.204).'),
(@revision_id,@section_id,'source_reused','source','[71], [74], [82]','Vorhandene Quellen verknüpft.','Letzte Literaturstelle: [83].','Letzte Literaturstelle bleibt [83].');

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.9'),
('last_completed_section','3.2.8'),
('last_definition_number','3.2.22'),
('next_definition_number','3.2.23'),
('last_equation_number','3.204'),
('next_equation_number','3.205'),
('last_citation_number','83'),
('next_citation_number','84')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;

SELECT @revision_id AS revision_id,@section_id AS section_id,
(SELECT COUNT(*) FROM definitions WHERE section_id=@section_id) AS definitions_count,
(SELECT COUNT(*) FROM equations WHERE section_id=@section_id) AS equations_count,
(SELECT COUNT(*) FROM source_usage WHERE section_id=@section_id) AS source_usage_count,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_definition_number') AS next_definition,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_equation_number') AS next_equation;
