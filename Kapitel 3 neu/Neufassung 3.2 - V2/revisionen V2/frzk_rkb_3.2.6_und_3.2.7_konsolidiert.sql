-- Konsolidiertes Repository-Update 3.2.6 und 3.2.7
START TRANSACTION;

SET @parent_section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);
SET @parent_revision_id=(SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.5-V1' LIMIT 1);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.6-V1',NOW(),'section','3.2.6','3.2.6-v1',
'Abschnitt 3.2.6 mit Definitionen 3.2.18 bis 3.2.21 und Gleichungen 3.121 bis 3.146.',
'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_section_id IS NOT NULL AND @parent_revision_id IS NOT NULL
AND NOT EXISTS(SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.6-V1');

SET @revision_326=(SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.6-V1' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section_id,'3.2.6','Lineare Unabhängigkeit, Basis und Dimension',3,3.2600,'final',0,
'Definitionen 3.2.18 bis 3.2.21; Gleichungen 3.121 bis 3.146; Quellen [71], [74], [82].'
WHERE NOT EXISTS(SELECT 1 FROM dissertation_sections WHERE section_code='3.2.6');

SET @section_326=(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6' LIMIT 1);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.2.18',@section_326,'Lineare Unabhängigkeit','Die Vektoren v_1 bis v_n heißen linear unabhängig, wenn aus einer Linearkombination mit Ergebnis Nullvektor notwendig folgt, dass sämtliche Koeffizienten null sind.','\\lambda_1v_1+\\cdots+\\lambda_nv_n=0_V\\Rightarrow\\lambda_1=\\cdots=\\lambda_n=0','\\lambda_1v_1+\\cdots+\\lambda_nv_n=0_V\\Rightarrow\\lambda_1=\\cdots=\\lambda_n=0','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die vorausgehenden Begriffe sind definiert.','Etablierte Definition.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM definitions WHERE definition_number='3.2.18');
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.2.19',@section_326,'Lineare Abhängigkeit','Eine Vektormenge heißt linear abhängig, wenn eine nichttriviale Linearkombination ihrer Vektoren den Nullvektor ergibt.','\\sum_{i=1}^{n}\\lambda_i v_i=0_V','\\sum_{i=1}^{n}\\lambda_i v_i=0_V','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die vorausgehenden Begriffe sind definiert.','Etablierte Definition.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM definitions WHERE definition_number='3.2.19');
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.2.20',@section_326,'Basis','Eine Basis eines Vektorraums ist ein linear unabhängiges Erzeugendensystem dieses Vektorraums.','B=(b_1,\\ldots,b_n),\\quad V=\\operatorname{span}(b_1,\\ldots,b_n)','B=(b_1,\\ldots,b_n),\\quad V=\\operatorname{span}(b_1,\\ldots,b_n)','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die vorausgehenden Begriffe sind definiert.','Etablierte Definition.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM definitions WHERE definition_number='3.2.20');
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.2.21',@section_326,'Dimension','Besitzt ein Vektorraum eine endliche Basis mit n Elementen, so heißt n die Dimension des Vektorraums.','\\dim(V)=n','\\dim(V)=n','adapted',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Die vorausgehenden Begriffe sind definiert.','Etablierte Definition.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM definitions WHERE definition_number='3.2.21');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.121',@section_326,'Vektoren für die Unabhängigkeitsprüfung','v_1,v_2,\\ldots,v_n\\in V','v_1,v_2,\\ldots,v_n\\in V','Vektoren für die Unabhängigkeitsprüfung','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.121');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.122',@section_326,'Homogene Linearkombination','\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n=0_V','\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n=0_V','Homogene Linearkombination','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.122');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.123',@section_326,'Triviale Koeffizientenlösung','\\lambda_1=\\lambda_2=\\cdots=\\lambda_n=0','\\lambda_1=\\lambda_2=\\cdots=\\lambda_n=0','Triviale Koeffizientenlösung','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.123');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.124',@section_326,'Vektormenge','\\{v_1,\\ldots,v_n\\}','\\{v_1,\\ldots,v_n\\}','Vektormenge','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.124');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.125',@section_326,'Reelle Koeffizienten','\\lambda_1,\\ldots,\\lambda_n\\in\\mathbb{R}','\\lambda_1,\\ldots,\\lambda_n\\in\\mathbb{R}','Reelle Koeffizienten','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.125');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.126',@section_326,'Kriterium linearer Abhängigkeit','\\sum_{i=1}^{n}\\lambda_i v_i=0_V','\\sum_{i=1}^{n}\\lambda_i v_i=0_V','Kriterium linearer Abhängigkeit','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.126');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.127',@section_326,'Darstellung eines abhängigen Vektors','v_k=-\\sum_{\\substack{i=1\\\\i\\neq k}}^{n}\\frac{\\lambda_i}{\\lambda_k}v_i','v_k=-\\sum_{\\substack{i=1\\\\i\\neq k}}^{n}\\frac{\\lambda_i}{\\lambda_k}v_i','Darstellung eines abhängigen Vektors','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.127');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.128',@section_326,'Abhängige Beispielvektoren','v_1=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}2\\\\4 \\end{pmatrix}','v_1=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}2\\\\4 \\end{pmatrix}','Abhängige Beispielvektoren','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.128');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.129',@section_326,'Skalare Abhängigkeit','v_2=2v_1','v_2=2v_1','Skalare Abhängigkeit','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.129');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.130',@section_326,'Nichttriviale Nullkombination','2v_1-v_2=0_{\\mathbb{R}^2}','2v_1-v_2=0_{\\mathbb{R}^2}','Nichttriviale Nullkombination','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.130');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.131',@section_326,'Standardbasis in R2','e_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}','e_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}','Standardbasis in R2','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.131');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.132',@section_326,'Unabhängigkeitsprüfung','\\lambda_1e_1+\\lambda_2e_2=\\begin{pmatrix}\\lambda_1\\\\\\lambda_2 \\end{pmatrix}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}','\\lambda_1e_1+\\lambda_2e_2=\\begin{pmatrix}\\lambda_1\\\\\\lambda_2 \\end{pmatrix}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}','Unabhängigkeitsprüfung','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.132');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.133',@section_326,'Triviale Lösung','\\lambda_1=0\\qquad\\text{und}\\qquad\\lambda_2=0','\\lambda_1=0\\qquad\\text{und}\\qquad\\lambda_2=0','Triviale Lösung','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.133');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.134',@section_326,'Geordnete Basis','B=(b_1,\\ldots,b_n)','B=(b_1,\\ldots,b_n)','Geordnete Basis','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.134');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.135',@section_326,'Erzeugungseigenschaft','V=\\operatorname{span}(b_1,\\ldots,b_n)','V=\\operatorname{span}(b_1,\\ldots,b_n)','Erzeugungseigenschaft','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.135');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.136',@section_326,'Eindeutige Basisdarstellung','v=\\alpha_1b_1+\\cdots+\\alpha_nb_n','v=\\alpha_1b_1+\\cdots+\\alpha_nb_n','Eindeutige Basisdarstellung','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.136');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.137',@section_326,'Standardbasis allgemein','e_1,\\ldots,e_n','e_1,\\ldots,e_n','Standardbasis allgemein','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.137');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.138',@section_326,'Standardbasis in R3','e_1=\\begin{pmatrix}1\\\\0\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1\\\\0 \\end{pmatrix},\\qquad e_3=\\begin{pmatrix}0\\\\0\\\\1 \\end{pmatrix}','e_1=\\begin{pmatrix}1\\\\0\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1\\\\0 \\end{pmatrix},\\qquad e_3=\\begin{pmatrix}0\\\\0\\\\1 \\end{pmatrix}','Standardbasis in R3','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.138');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.139',@section_326,'Vektor in R3','v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3','v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3','Vektor in R3','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.139');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.140',@section_326,'Basiszerlegung in R3','v=v_1e_1+v_2e_2+v_3e_3','v=v_1e_1+v_2e_2+v_3e_3','Basiszerlegung in R3','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.140');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.141',@section_326,'Allgemeine Basisnotation','B=(b_1,\\ldots,b_n)','B=(b_1,\\ldots,b_n)','Allgemeine Basisnotation','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.141');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.142',@section_326,'Koordinatenvektor','[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}','[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}','Koordinatenvektor','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.142');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.143',@section_326,'Dimension','\\dim(V)=n','\\dim(V)=n','Dimension','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.143');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.144',@section_326,'Dimension von Rn','\\dim(\\mathbb{R}^n)=n','\\dim(\\mathbb{R}^n)=n','Dimension von Rn','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.144');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.145',@section_326,'Dimension von R2','\\dim(\\mathbb{R}^2)=2','\\dim(\\mathbb{R}^2)=2','Dimension von R2','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.145');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.146',@section_326,'Dimension von R3','\\dim(\\mathbb{R}^3)=3','\\dim(\\mathbb{R}^3)=3','Dimension von R3','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_326
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.146');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_326,'definition',
CONCAT('Grundlage für lineare Unabhängigkeit, Basis und Dimension; Literaturstelle [',s.citation_number,'].'),
'Abschnitt 3.2.6',0,1,'Wiederverwendung vorhandener Literatur.',@revision_326
FROM sources s WHERE s.citation_number IN(71,74,82)
AND NOT EXISTS(SELECT 1 FROM source_usage su WHERE su.source_id=s.source_id AND su.section_id=@section_326);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_326,@section_326,'created','section','3.2.6','Abschnitt 3.2.6 angelegt.',NULL,'final'),
(@revision_326,@section_326,'definition_added','definition','3.2.18–3.2.21','Vier Definitionen ergänzt.','3.2.17','3.2.21'),
(@revision_326,@section_326,'equation_added','equation','3.121–3.146','26 Gleichungen ergänzt.','3.120','3.146');

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.7-V1',NOW(),'section','3.2.7','3.2.7-v1',
'Abschnitt 3.2.7 mit Gleichungen 3.147 bis 3.166 zu Basiswechsel und Koordinatentransformation.',
'Olaf Thiele / ChatGPT',@revision_326
WHERE @revision_326 IS NOT NULL
AND NOT EXISTS(SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.7-V1');

SET @revision_327=(SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.7-V1' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section_id,'3.2.7','Basiswechsel und Koordinatentransformationen',3,3.2700,'final',0,
'Gleichungen 3.147 bis 3.166; Quellen [71], [74], [76], [82].'
WHERE NOT EXISTS(SELECT 1 FROM dissertation_sections WHERE section_code='3.2.7');

SET @section_327=(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7' LIMIT 1);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.147',@section_327,'Basis B','B=(b_1,b_2,\\ldots,b_n)','B=(b_1,b_2,\\ldots,b_n)','Basis B','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.147');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.148',@section_327,'Vektor im Vektorraum','v\\in V','v\\in V','Vektor im Vektorraum','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.148');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.149',@section_327,'Basisdarstellung','v=\\sum_{i=1}^{n}\\alpha_i b_i','v=\\sum_{i=1}^{n}\\alpha_i b_i','Basisdarstellung','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.149');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.150',@section_327,'Koordinatenvektor bezüglich B','[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\alpha_2\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}','[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\alpha_2\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}','Koordinatenvektor bezüglich B','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.150');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.151',@section_327,'Erste Basis','B=(b_1,\\ldots,b_n)','B=(b_1,\\ldots,b_n)','Erste Basis','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.151');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.152',@section_327,'Zweite Basis','C=(c_1,\\ldots,c_n)','C=(c_1,\\ldots,c_n)','Zweite Basis','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.152');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.153',@section_327,'Koordinaten bezüglich B','[v]_B','[v]_B','Koordinaten bezüglich B','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.153');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.154',@section_327,'Koordinaten bezüglich C','[v]_C','[v]_C','Koordinaten bezüglich C','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.154');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.155',@section_327,'Basiswechselmatrix','P_{B\\rightarrow C}','P_{B\\rightarrow C}','Basiswechselmatrix','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.155');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.156',@section_327,'Koordinatentransformation','[v]_C=P_{B\\rightarrow C}[v]_B','[v]_C=P_{B\\rightarrow C}[v]_B','Koordinatentransformation','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.156');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.157',@section_327,'Inverse Basiswechselmatrix','P_{C\\rightarrow B}=P_{B\\rightarrow C}^{-1}','P_{C\\rightarrow B}=P_{B\\rightarrow C}^{-1}','Inverse Basiswechselmatrix','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.157');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.158',@section_327,'Rücktransformation','[v]_B=P_{C\\rightarrow B}[v]_C','[v]_B=P_{C\\rightarrow B}[v]_C','Rücktransformation','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.158');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.159',@section_327,'Standardbasis in R2','B=\\left(\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\begin{pmatrix}0\\\\1 \\end{pmatrix}\\right)','B=\\left(\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\begin{pmatrix}0\\\\1 \\end{pmatrix}\\right)','Standardbasis in R2','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.159');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.160',@section_327,'Alternative Basis in R2','C=\\left(\\begin{pmatrix}1\\\\1 \\end{pmatrix},\\begin{pmatrix}1\\\\-1 \\end{pmatrix}\\right)','C=\\left(\\begin{pmatrix}1\\\\1 \\end{pmatrix},\\begin{pmatrix}1\\\\-1 \\end{pmatrix}\\right)','Alternative Basis in R2','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.160');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.161',@section_327,'Basiswechselmatrix im Beispiel','P_{C\\rightarrow B}=\\begin{pmatrix}1&1\\\\1&-1 \\end{pmatrix}','P_{C\\rightarrow B}=\\begin{pmatrix}1&1\\\\1&-1 \\end{pmatrix}','Basiswechselmatrix im Beispiel','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.161');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.162',@section_327,'Linearer Operator','T:V\\rightarrow V','T:V\\rightarrow V','Linearer Operator','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.162');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.163',@section_327,'Matrixdarstellung bezüglich B','A_B','A_B','Matrixdarstellung bezüglich B','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.163');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.164',@section_327,'Ähnlichkeitstransformation','A_C=P_{B\\rightarrow C}A_BP_{C\\rightarrow B}','A_C=P_{B\\rightarrow C}A_BP_{C\\rightarrow B}','Ähnlichkeitstransformation','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.164');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.165',@section_327,'Determinanteninvarianz','\\det(A_C)=\\det(A_B)','\\det(A_C)=\\det(A_B)','Determinanteninvarianz','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.165');
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.166',@section_327,'Spektralinvarianz','\\sigma(A_B)=\\sigma(A_C)','\\sigma(A_B)=\\sigma(A_C)','Spektralinvarianz','definition','literature',
(SELECT source_id FROM sources WHERE citation_number=76 LIMIT 1),
'Im zugehörigen Abschnitt eingeführt und erläutert.','Die vorausgehenden Strukturen sind definiert.','verified',@revision_327
WHERE NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.166');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_327,'definition',
CONCAT('Grundlage für Basiswechsel und Koordinatentransformation; Literaturstelle [',s.citation_number,'].'),
'Abschnitt 3.2.7',0,1,'Wiederverwendung vorhandener Literatur.',@revision_327
FROM sources s WHERE s.citation_number IN(71,74,76,82)
AND NOT EXISTS(SELECT 1 FROM source_usage su WHERE su.source_id=s.source_id AND su.section_id=@section_327);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_327,@section_327,'created','section','3.2.7','Abschnitt 3.2.7 angelegt.',NULL,'final'),
(@revision_327,@section_327,'equation_added','equation','3.147–3.166','20 Gleichungen ergänzt.','3.146','3.166');

INSERT INTO repository_counters(counter_key,counter_value) VALUES
('current_section','3.2.8'),
('last_completed_section','3.2.7'),
('last_definition_number','3.2.21'),
('next_definition_number','3.2.22'),
('last_equation_number','3.166'),
('next_equation_number','3.167'),
('last_citation_number','83'),
('next_citation_number','84')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;

SELECT
(SELECT COUNT(*) FROM definitions WHERE section_id=@section_326) AS definitions_326,
(SELECT COUNT(*) FROM equations WHERE section_id=@section_326) AS equations_326,
(SELECT COUNT(*) FROM equations WHERE section_id=@section_327) AS equations_327,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_definition_number') AS next_definition,
(SELECT counter_value FROM repository_counters WHERE counter_key='next_equation_number') AS next_equation;
