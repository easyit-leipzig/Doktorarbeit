/* ============================================================================
   FRZK-RKB – Repository-Update 3.3.9.3
   Innere Konsistenz des Axiomensystems

   Grundlage:
   - frzk_rkb_3.3.9.1.sql
   - Reparatur der Abschnittshierarchie 3.3.9–3.3.9.2
   - Elternrevision RKB-NEU-K3.3.9.2-V1

   Registriert:
   - Abschnitt 3.3.9.3
   - Proposition 3.3.10
   - Gleichungen (3.507)–(3.524)
   - Axiomabhängigkeiten A1–A7
   - neue Symbole und Gleichungssymbol-Verknüpfungen
   - Konsistenzhinweise der Axiome A1–A7
   - Änderungsprotokoll und Validierungen

   Das Skript ist idempotent.
   ============================================================================ */

START TRANSACTION;

SET @section_33_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.3' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @section_33_id,'3.3.9','Logische Konsequenzen des Axiomensystems',
3,3.3090,'draft',1,
'Sammelabschnitt zur Ableitung logischer Konsequenzen, Unabhängigkeit und Konsistenz des FRZK-Axiomensystems.'
WHERE @section_33_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.3.9');

SET @section_339_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.3.9' LIMIT 1
);

SET @revision_3392 := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.3.9.2-V1' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.3.9.3-V1',NOW(),'section','3.3.9.3','1.0',
'Abschnitt 3.3.9.3: innere und relative Konsistenz des FRZK-Axiomensystems; Proposition 3.3.10; Gleichungen (3.507) bis (3.524).',
'Olaf Thiele / ChatGPT',@revision_3392
WHERE @revision_3392 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.3.9.3-V1'
);

SET @revision_3393 := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.3.9.3-V1' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @section_339_id,'3.3.9.3','Innere Konsistenz des Axiomensystems',
3,3.3093,'final',1,
'Untersuchung der gemeinsamen Erfüllbarkeit der Axiome A1 bis A7 durch ein konstruiertes Minimalmodell.'
WHERE @section_339_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.3.9.3');

UPDATE dissertation_sections SET
 parent_section_id=@section_339_id,
 title='Innere Konsistenz des Axiomensystems',
 chapter_no=3,section_order=3.3093,status='final',is_original_contribution=1,
 notes='Untersuchung der gemeinsamen Erfüllbarkeit der Axiome A1 bis A7 durch ein konstruiertes Minimalmodell.'
WHERE section_code='3.3.9.3';

SET @section_3393_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.3.9.3' LIMIT 1
);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.507',@section_3393_id,'Axiomensystem des FRZK','\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}','\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}','Menge der sieben Axiome des FRZK.',
'definition','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.507');

UPDATE equations SET
 section_id=@section_3393_id,title='Axiomensystem des FRZK',
 equation_latex='\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',word_latex='\\mathcal{A}_F=\\left\\{A_1,A_2,A_3,A_4,A_5,A_6,A_7\\right\\}',
 plain_description='Menge der sieben Axiome des FRZK.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.507';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.508',@section_3393_id,'Konsistenzbedingung','\\nexists P:\\left(\\mathcal{A}_F\\vdash P\\right)\\land\\left(\\mathcal{A}_F\\vdash\\neg P\\right)','\\nexists P:\\left(\\mathcal{A}_F\\vdash P\\right)\\land\\left(\\mathcal{A}_F\\vdash\\neg P\\right)','Keine Aussage und ihre Negation dürfen zugleich ableitbar sein.',
'theorem','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.508');

UPDATE equations SET
 section_id=@section_3393_id,title='Konsistenzbedingung',
 equation_latex='\\nexists P:\\left(\\mathcal{A}_F\\vdash P\\right)\\land\\left(\\mathcal{A}_F\\vdash\\neg P\\right)',word_latex='\\nexists P:\\left(\\mathcal{A}_F\\vdash P\\right)\\land\\left(\\mathcal{A}_F\\vdash\\neg P\\right)',
 plain_description='Keine Aussage und ihre Negation dürfen zugleich ableitbar sein.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.508';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.509',@section_3393_id,'Konstruktive Bedingungsfolge','A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Rightarrow\\mathfrak{D}_F','A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Rightarrow\\mathfrak{D}_F','Die gemeinsame Gültigkeit der Axiome ermöglicht einen funktionalen Dynamikraum.',
'theorem','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.509');

UPDATE equations SET
 section_id=@section_3393_id,title='Konstruktive Bedingungsfolge',
 equation_latex='A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Rightarrow\\mathfrak{D}_F',word_latex='A_1\\land A_2\\land A_3\\land A_4\\land A_5\\land A_6\\land A_7\\Rightarrow\\mathfrak{D}_F',
 plain_description='Die gemeinsame Gültigkeit der Axiome ermöglicht einen funktionalen Dynamikraum.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.509';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.510',@section_3393_id,'Elementare Existenzbedingungen','\\mathcal{E}_F=\\left\\{A_1,A_2,A_3\\right\\}','\\mathcal{E}_F=\\left\\{A_1,A_2,A_3\\right\\}','Axiome der Unterscheidbarkeit, Relationierbarkeit und Operierbarkeit.',
'definition','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.510');

UPDATE equations SET
 section_id=@section_3393_id,title='Elementare Existenzbedingungen',
 equation_latex='\\mathcal{E}_F=\\left\\{A_1,A_2,A_3\\right\\}',word_latex='\\mathcal{E}_F=\\left\\{A_1,A_2,A_3\\right\\}',
 plain_description='Axiome der Unterscheidbarkeit, Relationierbarkeit und Operierbarkeit.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.510';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.511',@section_3393_id,'Organisations- und Stabilitätsbedingungen','\\mathcal{S}_F=\\left\\{A_4,A_5\\right\\}','\\mathcal{S}_F=\\left\\{A_4,A_5\\right\\}','Axiome der Organisation und Kohärenz.',
'definition','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.511');

UPDATE equations SET
 section_id=@section_3393_id,title='Organisations- und Stabilitätsbedingungen',
 equation_latex='\\mathcal{S}_F=\\left\\{A_4,A_5\\right\\}',word_latex='\\mathcal{S}_F=\\left\\{A_4,A_5\\right\\}',
 plain_description='Axiome der Organisation und Kohärenz.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.511';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.512',@section_3393_id,'Zustands- und Dynamikbedingungen','\\mathcal{D}_F=\\left\\{A_6,A_7\\right\\}','\\mathcal{D}_F=\\left\\{A_6,A_7\\right\\}','Axiome der Zustandsbildung und Zustandsübergänge.',
'definition','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.512');

UPDATE equations SET
 section_id=@section_3393_id,title='Zustands- und Dynamikbedingungen',
 equation_latex='\\mathcal{D}_F=\\left\\{A_6,A_7\\right\\}',word_latex='\\mathcal{D}_F=\\left\\{A_6,A_7\\right\\}',
 plain_description='Axiome der Zustandsbildung und Zustandsübergänge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.512';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.513',@section_3393_id,'Gliederung des Axiomensystems','\\mathcal{A}_F=\\mathcal{E}_F\\cup\\mathcal{S}_F\\cup\\mathcal{D}_F','\\mathcal{A}_F=\\mathcal{E}_F\\cup\\mathcal{S}_F\\cup\\mathcal{D}_F','Vereinigung der drei funktionalen Bedingungsgruppen.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.513');

UPDATE equations SET
 section_id=@section_3393_id,title='Gliederung des Axiomensystems',
 equation_latex='\\mathcal{A}_F=\\mathcal{E}_F\\cup\\mathcal{S}_F\\cup\\mathcal{D}_F',word_latex='\\mathcal{A}_F=\\mathcal{E}_F\\cup\\mathcal{S}_F\\cup\\mathcal{D}_F',
 plain_description='Vereinigung der drei funktionalen Bedingungsgruppen.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.513';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.514',@section_3393_id,'Existenz eines erfüllenden Modells','\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F','\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F','Mindestens ein Modell erfüllt sämtliche Axiome.',
'theorem','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.514');

UPDATE equations SET
 section_id=@section_3393_id,title='Existenz eines erfüllenden Modells',
 equation_latex='\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F',word_latex='\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F',
 plain_description='Mindestens ein Modell erfüllt sämtliche Axiome.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.514';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.515',@section_3393_id,'Semantische Erfüllungsrelation','\\models','\\models','Symbol der Modellerfüllung.',
'definition','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.515');

UPDATE equations SET
 section_id=@section_3393_id,title='Semantische Erfüllungsrelation',
 equation_latex='\\models',word_latex='\\models',
 plain_description='Symbol der Modellerfüllung.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.515';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.516',@section_3393_id,'Minimale funktionale Gehaltsmenge','\\Omega_F=\\left\\{f_1,f_2\\right\\}','\\Omega_F=\\left\\{f_1,f_2\\right\\}','Zwei unterscheidbare funktionale Gehalte bilden den Träger des Minimalmodells.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.516');

UPDATE equations SET
 section_id=@section_3393_id,title='Minimale funktionale Gehaltsmenge',
 equation_latex='\\Omega_F=\\left\\{f_1,f_2\\right\\}',word_latex='\\Omega_F=\\left\\{f_1,f_2\\right\\}',
 plain_description='Zwei unterscheidbare funktionale Gehalte bilden den Träger des Minimalmodells.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.516';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.517',@section_3393_id,'Minimale funktionale Relation','R_F=\\left\\{\\left(f_1,f_2\\right)\\right\\}','R_F=\\left\\{\\left(f_1,f_2\\right)\\right\\}','Relation zwischen den funktionalen Gehalten des Minimalmodells.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.517');

UPDATE equations SET
 section_id=@section_3393_id,title='Minimale funktionale Relation',
 equation_latex='R_F=\\left\\{\\left(f_1,f_2\\right)\\right\\}',word_latex='R_F=\\left\\{\\left(f_1,f_2\\right)\\right\\}',
 plain_description='Relation zwischen den funktionalen Gehalten des Minimalmodells.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.517';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.518',@section_3393_id,'Minimale funktionale Operation','O_F\\left(f_1\\right)=f_2','O_F\\left(f_1\\right)=f_2','Operation des Minimalmodells.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.518');

UPDATE equations SET
 section_id=@section_3393_id,title='Minimale funktionale Operation',
 equation_latex='O_F\\left(f_1\\right)=f_2',word_latex='O_F\\left(f_1\\right)=f_2',
 plain_description='Operation des Minimalmodells.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.518';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.519',@section_3393_id,'Minimale funktionale Organisation','\\mathcal{O}_F=\\left(\\Omega_F,R_F,O_F\\right)','\\mathcal{O}_F=\\left(\\Omega_F,R_F,O_F\\right)','Organisation des Minimalmodells.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.519');

UPDATE equations SET
 section_id=@section_3393_id,title='Minimale funktionale Organisation',
 equation_latex='\\mathcal{O}_F=\\left(\\Omega_F,R_F,O_F\\right)',word_latex='\\mathcal{O}_F=\\left(\\Omega_F,R_F,O_F\\right)',
 plain_description='Organisation des Minimalmodells.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.519';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.520',@section_3393_id,'Kohärenzbedingung des Minimalmodells','C_F\\left(\\mathcal{O}_F\\right)\\geq C_{\\mathrm{krit}}','C_F\\left(\\mathcal{O}_F\\right)\\geq C_{\\mathrm{krit}}','Das Minimalmodell erfüllt die kritische Kohärenzschwelle.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.520');

UPDATE equations SET
 section_id=@section_3393_id,title='Kohärenzbedingung des Minimalmodells',
 equation_latex='C_F\\left(\\mathcal{O}_F\\right)\\geq C_{\\mathrm{krit}}',word_latex='C_F\\left(\\mathcal{O}_F\\right)\\geq C_{\\mathrm{krit}}',
 plain_description='Das Minimalmodell erfüllt die kritische Kohärenzschwelle.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.520';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.521',@section_3393_id,'Zustände des Minimalmodells','z_F^{(1)}=\\left(f_1,R_F\\right),\\qquad z_F^{(2)}=\\left(f_2,R_F\\right)','z_F^{(1)}=\\left(f_1,R_F\\right),\\qquad z_F^{(2)}=\\left(f_2,R_F\\right)','Zwei funktionale Zustände des Minimalmodells.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.521');

UPDATE equations SET
 section_id=@section_3393_id,title='Zustände des Minimalmodells',
 equation_latex='z_F^{(1)}=\\left(f_1,R_F\\right),\\qquad z_F^{(2)}=\\left(f_2,R_F\\right)',word_latex='z_F^{(1)}=\\left(f_1,R_F\\right),\\qquad z_F^{(2)}=\\left(f_2,R_F\\right)',
 plain_description='Zwei funktionale Zustände des Minimalmodells.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.521';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.522',@section_3393_id,'Zustandsübergang des Minimalmodells','\\left(z_F^{(1)},z_F^{(2)}\\right)\\in\\mathcal{T}_F','\\left(z_F^{(1)},z_F^{(2)}\\right)\\in\\mathcal{T}_F','Zulässiger Zustandsübergang des Minimalmodells.',
'model','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.522');

UPDATE equations SET
 section_id=@section_3393_id,title='Zustandsübergang des Minimalmodells',
 equation_latex='\\left(z_F^{(1)},z_F^{(2)}\\right)\\in\\mathcal{T}_F',word_latex='\\left(z_F^{(1)},z_F^{(2)}\\right)\\in\\mathcal{T}_F',
 plain_description='Zulässiger Zustandsübergang des Minimalmodells.',equation_type='model',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.522';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.523',@section_3393_id,'Relative Konsistenz','\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F\\Rightarrow\\operatorname{Con}\\left(\\mathcal{A}_F\\right)','\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F\\Rightarrow\\operatorname{Con}\\left(\\mathcal{A}_F\\right)','Existiert ein Modell aller Axiome, ist das Axiomensystem relativ konsistent.',
'theorem','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.523');

UPDATE equations SET
 section_id=@section_3393_id,title='Relative Konsistenz',
 equation_latex='\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F\\Rightarrow\\operatorname{Con}\\left(\\mathcal{A}_F\\right)',word_latex='\\exists\\mathcal{M}_F:\\mathcal{M}_F\\models\\mathcal{A}_F\\Rightarrow\\operatorname{Con}\\left(\\mathcal{A}_F\\right)',
 plain_description='Existiert ein Modell aller Axiome, ist das Axiomensystem relativ konsistent.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.523';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.524',@section_3393_id,'Konsistenzprädikat','\\operatorname{Con}\\left(\\mathcal{A}_F\\right)','\\operatorname{Con}\\left(\\mathcal{A}_F\\right)','Bezeichnung der Konsistenz des Axiomensystems.',
'definition','original',NULL,'Formalisierung in Abschnitt 3.3.9.3.',
'Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.','checked',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.524');

UPDATE equations SET
 section_id=@section_3393_id,title='Konsistenzprädikat',
 equation_latex='\\operatorname{Con}\\left(\\mathcal{A}_F\\right)',word_latex='\\operatorname{Con}\\left(\\mathcal{A}_F\\right)',
 plain_description='Bezeichnung der Konsistenz des Axiomensystems.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Formalisierung in Abschnitt 3.3.9.3.',
 assumptions='Axiome A1 bis A7, Propositionen 3.3.8 und 3.3.9.',
 validation_status='checked',created_revision_id=@revision_3393
WHERE equation_number='3.524';

INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,
 logical_derivation,based_on_axioms,status,created_revision_id)
SELECT '3.3.10',@section_3393_id,'Relative Konsistenz des FRZK-Axiomensystems',
'Das Axiomensystem des FRZK ist relativ konsistent, sofern ein Modell existiert, das sämtliche Axiome A1 bis A7 erfüllt.',
'\exists\mathcal{M}_F:\mathcal{M}_F\models\mathcal{A}_F\Rightarrow\operatorname{Con}\left(\mathcal{A}_F\right)',
'\exists\mathcal{M}_F:\mathcal{M}_F\models\mathcal{A}_F\Rightarrow\operatorname{Con}\left(\mathcal{A}_F\right)',
'Das in Abschnitt 3.3.9.3 konstruierte Minimalmodell erfüllt die Bedingungen der Axiome A1 bis A7. Die Konsistenz ist relativ zu den vorausgesetzten mathematischen und logischen Grundlagen.',
'A1,A2,A3,A4,A5,A6,A7','accepted',@revision_3393
WHERE @section_3393_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM propositions WHERE proposition_number='3.3.10');

UPDATE propositions SET
 section_id=@section_3393_id,
 title='Relative Konsistenz des FRZK-Axiomensystems',
 statement_text='Das Axiomensystem des FRZK ist relativ konsistent, sofern ein Modell existiert, das sämtliche Axiome A1 bis A7 erfüllt.',
 statement_latex='\exists\mathcal{M}_F:\mathcal{M}_F\models\mathcal{A}_F\Rightarrow\operatorname{Con}\left(\mathcal{A}_F\right)',
 word_latex='\exists\mathcal{M}_F:\mathcal{M}_F\models\mathcal{A}_F\Rightarrow\operatorname{Con}\left(\mathcal{A}_F\right)',
 logical_derivation='Das konstruierte Minimalmodell erfüllt die Bedingungen der Axiome A1 bis A7. Die Konsistenz ist relativ zu den vorausgesetzten mathematischen und logischen Grundlagen.',
 based_on_axioms='A1,A2,A3,A4,A5,A6,A7',
 status='accepted',created_revision_id=@revision_3393
WHERE proposition_number='3.3.10';

SET @prop_3310_id := (
 SELECT proposition_id FROM propositions WHERE proposition_number='3.3.10' LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
SELECT @prop_3310_id,a.axiom_id,NULL,'derived_from',
CONCAT('Proposition 3.3.10 verwendet ',a.axiom_number,' bei der Konstruktion des gemeinsamen Minimalmodells.')
FROM axioms a
WHERE @prop_3310_id IS NOT NULL
AND a.axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
AND NOT EXISTS (
 SELECT 1 FROM proposition_dependencies pd
 WHERE pd.proposition_id=@prop_3310_id
 AND pd.axiom_id=a.axiom_id
 AND pd.assumption_id IS NULL
 AND pd.dependency_type='derived_from'
);

/* Konsistenzhinweise der Axiome präzisieren */
UPDATE axioms SET consistency_note=CONCAT(
 COALESCE(consistency_note,''),' ',
 'Abschnitt 3.3.9.3 zeigt die gemeinsame Erfüllbarkeit von A1 bis A7 durch ein konstruiertes funktionales Minimalmodell.'
)
WHERE axiom_number IN ('A1','A2','A3','A4','A5','A6','A7')
AND consistency_note NOT LIKE '%Abschnitt 3.3.9.3%';

SET @eq_3510 := (SELECT equation_id FROM equations WHERE equation_number='3.510' LIMIT 1);
SET @eq_3511 := (SELECT equation_id FROM equations WHERE equation_number='3.511' LIMIT 1);
SET @eq_3512 := (SELECT equation_id FROM equations WHERE equation_number='3.512' LIMIT 1);
SET @eq_3514 := (SELECT equation_id FROM equations WHERE equation_number='3.514' LIMIT 1);
SET @eq_3515 := (SELECT equation_id FROM equations WHERE equation_number='3.515' LIMIT 1);
SET @eq_3523 := (SELECT equation_id FROM equations WHERE equation_number='3.523' LIMIT 1);

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,
 notes,validation_status,created_revision_id)
SELECT '\mathcal{E}_F','\mathcal{E}_F','Elementare Existenzbedingungen',
'Menge der Axiome A1 bis A3.','chapter',@section_3393_id,@eq_3510,
NULL,NULL,NULL,0,0,0,'In Abschnitt 3.3.9.3 eingeführt.','checked',@revision_3393
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\mathcal{E}_F' AND scope_type='chapter');

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,
 notes,validation_status,created_revision_id)
SELECT '\mathcal{S}_F','\mathcal{S}_F','Organisations- und Stabilitätsbedingungen',
'Menge der Axiome A4 und A5.','chapter',@section_3393_id,@eq_3511,
NULL,NULL,NULL,0,0,0,'In Abschnitt 3.3.9.3 eingeführt.','checked',@revision_3393
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\mathcal{S}_F' AND scope_type='chapter');

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,
 notes,validation_status,created_revision_id)
SELECT '\mathcal{D}_F','\mathcal{D}_F','Zustands- und Dynamikbedingungen',
'Menge der Axiome A6 und A7.','chapter',@section_3393_id,@eq_3512,
NULL,NULL,NULL,0,0,0,'In Abschnitt 3.3.9.3 eingeführt.','checked',@revision_3393
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\mathcal{D}_F' AND scope_type='chapter');

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,
 notes,validation_status,created_revision_id)
SELECT '\mathcal{M}_F','\mathcal{M}_F','Modell des FRZK-Axiomensystems',
'Mathematische Struktur, die sämtliche Axiome A1 bis A7 erfüllt.','chapter',
@section_3393_id,@eq_3514,NULL,NULL,NULL,0,0,0,
'In Abschnitt 3.3.9.3 eingeführt.','checked',@revision_3393
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\mathcal{M}_F' AND scope_type='chapter');

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,
 notes,validation_status,created_revision_id)
SELECT '\models','\models','Semantische Erfüllungsrelation',
'Bezeichnet, dass ein Modell eine Aussage oder ein Axiomensystem erfüllt.','chapter',
@section_3393_id,@eq_3515,NULL,NULL,NULL,0,0,1,
'In Abschnitt 3.3.9.3 eingeführt.','checked',@revision_3393
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\models' AND scope_type='chapter');

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,
 notes,validation_status,created_revision_id)
SELECT '\operatorname{Con}\left(\mathcal{A}_F\right)',
'\operatorname{Con}\left(\mathcal{A}_F\right)','Konsistenz des FRZK-Axiomensystems',
'Prädikat der relativen Konsistenz des Axiomensystems.','chapter',
@section_3393_id,@eq_3523,NULL,NULL,'{0,1}',0,0,1,
'In Abschnitt 3.3.9.3 eingeführt.','checked',@revision_3393
WHERE NOT EXISTS (
 SELECT 1 FROM symbols
 WHERE symbol_latex='\operatorname{Con}\left(\mathcal{A}_F\right)'
 AND scope_type='chapter'
);

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3510,'\mathcal{E}_F','Elementare Existenzbedingungen','Menge der Axiome A1 bis A3.',NULL,NULL,1
WHERE @eq_3510 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3510 AND symbol_latex='\mathcal{E}_F');

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3511,'\mathcal{S}_F','Organisations- und Stabilitätsbedingungen','Menge der Axiome A4 und A5.',NULL,NULL,1
WHERE @eq_3511 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3511 AND symbol_latex='\mathcal{S}_F');

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3512,'\mathcal{D}_F','Zustands- und Dynamikbedingungen','Menge der Axiome A6 und A7.',NULL,NULL,1
WHERE @eq_3512 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3512 AND symbol_latex='\mathcal{D}_F');

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3514,'\mathcal{M}_F','Modell des FRZK-Axiomensystems','Erfüllendes Modell der Axiome A1 bis A7.',NULL,NULL,1
WHERE @eq_3514 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3514 AND symbol_latex='\mathcal{M}_F');

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3515,'\models','Semantische Erfüllungsrelation','Ein Modell erfüllt ein Axiomensystem.',NULL,NULL,1
WHERE @eq_3515 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3515 AND symbol_latex='\models');

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3523,'\operatorname{Con}\left(\mathcal{A}_F\right)',
'Konsistenz des FRZK-Axiomensystems','Relative Konsistenz des Axiomensystems.',NULL,NULL,1
WHERE @eq_3523 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM equation_symbols
 WHERE equation_id=@eq_3523
 AND symbol_latex='\operatorname{Con}\left(\mathcal{A}_F\right)'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_3393,@section_3393_id,'created','section','3.3.9.3',
'Abschnitt 3.3.9.3 vollständig angelegt.',NULL,'Innere Konsistenz des Axiomensystems'
WHERE @revision_3393 IS NOT NULL AND @section_3393_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_3393 AND object_type='section' AND object_reference='3.3.9.3'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_3393,@section_3393_id,'proposition_added','proposition','3.3.10',
'Proposition 3.3.10 registriert.',NULL,'Relative Konsistenz des FRZK-Axiomensystems'
WHERE @revision_3393 IS NOT NULL AND @section_3393_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_3393 AND object_type='proposition' AND object_reference='3.3.10'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_3393,@section_3393_id,'equation_added','equation','(3.507)–(3.524)',
'18 Gleichungen zur inneren und relativen Konsistenz registriert.',NULL,
'Gleichungen (3.507) bis (3.524)'
WHERE @revision_3393 IS NOT NULL AND @section_3393_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_3393 AND object_type='equation' AND object_reference='(3.507)–(3.524)'
);

SET @equation_count_3393 := (
 SELECT COUNT(*) FROM equations
 WHERE equation_number IN ('3.507','3.508','3.509','3.510','3.511','3.512',
 '3.513','3.514','3.515','3.516','3.517','3.518','3.519','3.520','3.521',
 '3.522','3.523','3.524')
);
SET @dependency_count_3393 := (
 SELECT COUNT(*) FROM proposition_dependencies
 WHERE proposition_id=@prop_3310_id AND dependency_type='derived_from'
);
SET @symbol_count_3393 := (
 SELECT COUNT(*) FROM symbols
 WHERE symbol_latex IN ('\mathcal{E}_F','\mathcal{S}_F','\mathcal{D}_F',
 '\mathcal{M}_F','\models','\operatorname{Con}\left(\mathcal{A}_F\right)')
 AND scope_type='chapter'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_3393,'K3.3.9.3.SECTION',
CASE WHEN @section_3393_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
'1',CASE WHEN @section_3393_id IS NOT NULL THEN '1' ELSE '0' END,
'Prüfung des Abschnitts 3.3.9.3.'
WHERE @revision_3393 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_validation_results
 WHERE revision_id=@revision_3393 AND validation_code='K3.3.9.3.SECTION'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_3393,'K3.3.9.3.PROPOSITION',
CASE WHEN @prop_3310_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
'1',CASE WHEN @prop_3310_id IS NOT NULL THEN '1' ELSE '0' END,
'Prüfung der Proposition 3.3.10.'
WHERE @revision_3393 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_validation_results
 WHERE revision_id=@revision_3393 AND validation_code='K3.3.9.3.PROPOSITION'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_3393,'K3.3.9.3.EQUATIONS',
CASE WHEN @equation_count_3393=18 THEN 'passed' ELSE 'failed' END,
'18',CONCAT(@equation_count_3393,''),
'Prüfung der Gleichungen (3.507) bis (3.524).'
WHERE @revision_3393 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_validation_results
 WHERE revision_id=@revision_3393 AND validation_code='K3.3.9.3.EQUATIONS'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_3393,'K3.3.9.3.AXIOM_DEPENDENCIES',
CASE WHEN @dependency_count_3393=7 THEN 'passed' ELSE 'failed' END,
'7',CONCAT(@dependency_count_3393,''),
'Prüfung der sieben Axiomabhängigkeiten.'
WHERE @revision_3393 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_validation_results
 WHERE revision_id=@revision_3393 AND validation_code='K3.3.9.3.AXIOM_DEPENDENCIES'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_3393,'K3.3.9.3.SYMBOLS',
CASE WHEN @symbol_count_3393=6 THEN 'passed' ELSE 'failed' END,
'6',CONCAT(@symbol_count_3393,''),
'Prüfung der sechs neu registrierten Hauptsymbole.'
WHERE @revision_3393 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_validation_results
 WHERE revision_id=@revision_3393 AND validation_code='K3.3.9.3.SYMBOLS'
);

COMMIT;

SELECT CASE
 WHEN @section_339_id IS NULL THEN 'FEHLER: Abschnitt 3.3.9 fehlt.'
 WHEN @revision_3392 IS NULL THEN 'FEHLER: Elternrevision RKB-NEU-K3.3.9.2-V1 fehlt.'
 WHEN @revision_3393 IS NULL THEN 'FEHLER: Revision RKB-NEU-K3.3.9.3-V1 fehlt.'
 WHEN @section_3393_id IS NULL THEN 'FEHLER: Abschnitt 3.3.9.3 fehlt.'
 WHEN @prop_3310_id IS NULL THEN 'FEHLER: Proposition 3.3.10 fehlt.'
 WHEN @equation_count_3393<>18 THEN CONCAT('FEHLER: ',@equation_count_3393,' statt 18 Gleichungen.')
 WHEN @dependency_count_3393<>7 THEN CONCAT('FEHLER: ',@dependency_count_3393,' statt 7 Axiomabhängigkeiten.')
 WHEN @symbol_count_3393<>6 THEN CONCAT('FEHLER: ',@symbol_count_3393,' statt 6 Hauptsymbolen.')
 ELSE 'OK: Repository-Update 3.3.9.3 vollständig ausgeführt.'
END AS import_status;

SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results
WHERE revision_id=@revision_3393
ORDER BY validation_code;
