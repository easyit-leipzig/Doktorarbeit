/* =====================================================================
   FRZK-RKB – Repository-Update Abschnitt 3.4.7
   Funktionale Kohärenz von Zuständen und Entwicklungspfaden
   Gleichungen (3.823)–(3.861)
   Definitionen 3.4.21–3.4.26
   Lemma 3.4.8–3.4.9
   Satz 3.4.9–3.4.10
   Korollar 3.4.9
   Beweise, Quellenverwendungen, Änderungsprotokoll und Audit
   Schema geprüft gegen frzk_rkb(3).sql und Revision 3.4.6
   ===================================================================== */

ROLLBACK;
START TRANSACTION;

SET @revision_code := 'RKB-REV-K3.4.7-V1';

SELECT section_id INTO @parent_section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section_id,'3.4.7','Funktionale Kohärenz von Zuständen und Entwicklungspfaden',3,3.4700,'review',1,
'Literaturgestützte Rekonstruktion funktionaler Kohärenz, kohärenzerhaltender Operatoren und kohärenter Entwicklungspfade.'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.4.7');

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4.7'
LIMIT 1;

SELECT source_id INTO @source_dummit FROM sources WHERE citation_number=31 LIMIT 1;
SELECT source_id INTO @source_conway FROM sources WHERE citation_number=35 LIMIT 1;
SELECT source_id INTO @source_hirsch FROM sources WHERE citation_number=40 LIMIT 1;

SELECT revision_id INTO @parent_revision_id
FROM repository_revisions
ORDER BY revision_id DESC LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT @revision_code,NOW(),'section','3.4.7','1.0-complete',
'Vollständige literaturgestützte Revision von 3.4.7: kohärenztragende Relationsstruktur, Relationserhaltung, kohärente Zustände, kohärenzerhaltende Operatoren, Untermonoid, kohärente Entwicklungspfade und Kohärenzbruch.',
'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SELECT revision_id INTO @revision_id
FROM repository_revisions WHERE revision_code=@revision_code LIMIT 1;

DROP PROCEDURE IF EXISTS frzk_assert_347;
DELIMITER $$
CREATE PROCEDURE frzk_assert_347()
BEGIN
 IF @parent_section_id IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Übergeordneter Abschnitt 3.4 fehlt.'; END IF;
 IF @section_id IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Abschnitt 3.4.7 konnte nicht bestimmt werden.'; END IF;
 IF @source_dummit IS NULL OR @source_conway IS NULL OR @source_hirsch IS NULL THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Bestandsquelle [31], [35] oder [40] fehlt.';
 END IF;
END$$
DELIMITER ;
CALL frzk_assert_347();
DROP PROCEDURE frzk_assert_347;

UPDATE dissertation_sections
SET title='Funktionale Kohärenz von Zuständen und Entwicklungspfaden',
    status='review',is_original_contribution=1,
    notes='Vollständige literaturgestützte Revision: kohärenztragende Relationen, Relationserhaltung, kohärente Zustände, kohärenzerhaltende Operatoren, kohärente Pfade und Kohärenzbruch.'
WHERE section_id=@section_id;

UPDATE equations SET
 section_id=@section_id,title='Kohärenztragende Relationsstruktur',equation_latex='\\mathcal R_F^{K}(\\mathcal S)\\subseteq\\mathcal R_F(\\mathcal S),\\qquad\\mathcal R_F^{K}(\\mathcal S)\\neq\\varnothing',word_latex='\\mathcal R_F^{K}(\\mathcal S)\\subseteq\\mathcal R_F(\\mathcal S),\\qquad\\mathcal R_F^{K}(\\mathcal S)\\neq\\varnothing',
 plain_description='Nichtleere Teilmenge der für die Kohärenz maßgeblichen funktionalen Relationen.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.823';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.823',@section_id,'Kohärenztragende Relationsstruktur','\\mathcal R_F^{K}(\\mathcal S)\\subseteq\\mathcal R_F(\\mathcal S),\\qquad\\mathcal R_F^{K}(\\mathcal S)\\neq\\varnothing','\\mathcal R_F^{K}(\\mathcal S)\\subseteq\\mathcal R_F(\\mathcal S),\\qquad\\mathcal R_F^{K}(\\mathcal S)\\neq\\varnothing','Nichtleere Teilmenge der für die Kohärenz maßgeblichen funktionalen Relationen.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.823');

UPDATE equations SET
 section_id=@section_id,title='Zugehörigkeit kohärenztragender Relationen',equation_latex='r_F\\in\\mathcal R_F^{K}(\\mathcal S)\\Longrightarrow r_F\\in\\mathcal R_F(\\mathcal S)',word_latex='r_F\\in\\mathcal R_F^{K}(\\mathcal S)\\Longrightarrow r_F\\in\\mathcal R_F(\\mathcal S)',
 plain_description='Jede kohärenztragende Relation ist eine funktionale Relation der Organisation.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.824';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.824',@section_id,'Zugehörigkeit kohärenztragender Relationen','r_F\\in\\mathcal R_F^{K}(\\mathcal S)\\Longrightarrow r_F\\in\\mathcal R_F(\\mathcal S)','r_F\\in\\mathcal R_F^{K}(\\mathcal S)\\Longrightarrow r_F\\in\\mathcal R_F(\\mathcal S)','Jede kohärenztragende Relation ist eine funktionale Relation der Organisation.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.824');

UPDATE equations SET
 section_id=@section_id,title='Zustände der Relationserhaltung',equation_latex='z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)',word_latex='z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)',
 plain_description='Ausgangs- und Folgezustand gehören zum funktionalen Zustandsraum.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.825';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.825',@section_id,'Zustände der Relationserhaltung','z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)','z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)','Ausgangs- und Folgezustand gehören zum funktionalen Zustandsraum.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.825');

UPDATE equations SET
 section_id=@section_id,title='Operatorwirkung bei Relationserhaltung',equation_latex='z_F^{\\prime}=O_F(z_F)',word_latex='z_F^{\\prime}=O_F(z_F)',
 plain_description='Der Folgezustand entsteht durch die Wirkung des Operators.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.826';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.826',@section_id,'Operatorwirkung bei Relationserhaltung','z_F^{\\prime}=O_F(z_F)','z_F^{\\prime}=O_F(z_F)','Der Folgezustand entsteht durch die Wirkung des Operators.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.826');

UPDATE equations SET
 section_id=@section_id,title='Funktionale Äquivalenz erhaltener Relationen',equation_latex='r_F^{\\prime}\\sim_F r_F',word_latex='r_F^{\\prime}\\sim_F r_F',
 plain_description='Die Folgerelation ist funktional äquivalent zur Ausgangsrelation.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.827';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.827',@section_id,'Funktionale Äquivalenz erhaltener Relationen','r_F^{\\prime}\\sim_F r_F','r_F^{\\prime}\\sim_F r_F','Die Folgerelation ist funktional äquivalent zur Ausgangsrelation.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.827');

UPDATE equations SET
 section_id=@section_id,title='Identität als stärkerer Sonderfall',equation_latex='r_F^{\\prime}=r_F',word_latex='r_F^{\\prime}=r_F',
 plain_description='Strenge Identität ist eine stärkere, aber nicht notwendige Erhaltungsbedingung.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.828';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.828',@section_id,'Identität als stärkerer Sonderfall','r_F^{\\prime}=r_F','r_F^{\\prime}=r_F','Strenge Identität ist eine stärkere, aber nicht notwendige Erhaltungsbedingung.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.828');

UPDATE equations SET
 section_id=@section_id,title='Gleichheit funktionaler Äquivalenzklassen',equation_latex='[r_F^{\\prime}]_F=[r_F]_F',word_latex='[r_F^{\\prime}]_F=[r_F]_F',
 plain_description='Erhaltene Relationen gehören derselben funktionalen Äquivalenzklasse an.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.829';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.829',@section_id,'Gleichheit funktionaler Äquivalenzklassen','[r_F^{\\prime}]_F=[r_F]_F','[r_F^{\\prime}]_F=[r_F]_F','Erhaltene Relationen gehören derselben funktionalen Äquivalenzklasse an.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.829');

UPDATE equations SET
 section_id=@section_id,title='Kohärenzerhaltender Operator',equation_latex='O_F\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Ein kohärenzerhaltender Operator ist zunächst ein funktionaler Operator.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.830';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.830',@section_id,'Kohärenzerhaltender Operator','O_F\\in\\mathcal O_F(\\mathcal S)','O_F\\in\\mathcal O_F(\\mathcal S)','Ein kohärenzerhaltender Operator ist zunächst ein funktionaler Operator.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.830');

UPDATE equations SET
 section_id=@section_id,title='Bedingung der Kohärenzerhaltung',equation_latex='\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\Longrightarrow\\exists r_F^{\\prime}\\subseteq O_F(z_F):\\;r_F^{\\prime}\\sim_F r_F',word_latex='\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\Longrightarrow\\exists r_F^{\\prime}\\subseteq O_F(z_F):\\;r_F^{\\prime}\\sim_F r_F',
 plain_description='Jede realisierte kohärenztragende Relation wird funktional äquivalent fortgeführt.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.831';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.831',@section_id,'Bedingung der Kohärenzerhaltung','\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\Longrightarrow\\exists r_F^{\\prime}\\subseteq O_F(z_F):\\;r_F^{\\prime}\\sim_F r_F','\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\Longrightarrow\\exists r_F^{\\prime}\\subseteq O_F(z_F):\\;r_F^{\\prime}\\sim_F r_F','Jede realisierte kohärenztragende Relation wird funktional äquivalent fortgeführt.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.831');

UPDATE equations SET
 section_id=@section_id,title='Menge kohärenzerhaltender Operatoren',equation_latex='\\mathcal O_F^{K}(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F\\text{ erhält }\\mathcal R_F^{K}(\\mathcal S)\\right\\}',word_latex='\\mathcal O_F^{K}(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F\\text{ erhält }\\mathcal R_F^{K}(\\mathcal S)\\right\\}',
 plain_description='Menge aller Operatoren, welche die kohärenztragende Relationsstruktur erhalten.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.832';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.832',@section_id,'Menge kohärenzerhaltender Operatoren','\\mathcal O_F^{K}(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F\\text{ erhält }\\mathcal R_F^{K}(\\mathcal S)\\right\\}','\\mathcal O_F^{K}(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F\\text{ erhält }\\mathcal R_F^{K}(\\mathcal S)\\right\\}','Menge aller Operatoren, welche die kohärenztragende Relationsstruktur erhalten.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.832');

UPDATE equations SET
 section_id=@section_id,title='Teilmengenbeziehung kohärenzerhaltender Operatoren',equation_latex='\\mathcal O_F^{K}(\\mathcal S)\\subseteq\\mathcal O_F(\\mathcal S)',word_latex='\\mathcal O_F^{K}(\\mathcal S)\\subseteq\\mathcal O_F(\\mathcal S)',
 plain_description='Jeder kohärenzerhaltende Operator ist ein funktionaler Operator.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.833';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.833',@section_id,'Teilmengenbeziehung kohärenzerhaltender Operatoren','\\mathcal O_F^{K}(\\mathcal S)\\subseteq\\mathcal O_F(\\mathcal S)','\\mathcal O_F^{K}(\\mathcal S)\\subseteq\\mathcal O_F(\\mathcal S)','Jeder kohärenzerhaltende Operator ist ein funktionaler Operator.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.833');

UPDATE equations SET
 section_id=@section_id,title='Funktionaler Zustand',equation_latex='z_F\\in\\Omega_F(\\mathcal S)',word_latex='z_F\\in\\Omega_F(\\mathcal S)',
 plain_description='Ein kohärenter Zustand gehört zum funktionalen Zustandsraum.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.834';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.834',@section_id,'Funktionaler Zustand','z_F\\in\\Omega_F(\\mathcal S)','z_F\\in\\Omega_F(\\mathcal S)','Ein kohärenter Zustand gehört zum funktionalen Zustandsraum.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.834');

UPDATE equations SET
 section_id=@section_id,title='Bedingung funktionaler Zustandskohärenz',equation_latex='\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F',word_latex='\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F',
 plain_description='Alle kohärenztragenden Relationen sind im Zustand realisiert.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.835';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.835',@section_id,'Bedingung funktionaler Zustandskohärenz','\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F','\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F','Alle kohärenztragenden Relationen sind im Zustand realisiert.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.835');

UPDATE equations SET
 section_id=@section_id,title='Menge funktional kohärenter Zustände',equation_latex='\\Omega_F^{K}(\\mathcal S)=\\left\\{z_F\\in\\Omega_F(\\mathcal S)\\middle|\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):r_F\\subseteq z_F\\right\\}',word_latex='\\Omega_F^{K}(\\mathcal S)=\\left\\{z_F\\in\\Omega_F(\\mathcal S)\\middle|\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):r_F\\subseteq z_F\\right\\}',
 plain_description='Der kohärente Bereich des funktionalen Zustandsraumes.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.836';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.836',@section_id,'Menge funktional kohärenter Zustände','\\Omega_F^{K}(\\mathcal S)=\\left\\{z_F\\in\\Omega_F(\\mathcal S)\\middle|\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):r_F\\subseteq z_F\\right\\}','\\Omega_F^{K}(\\mathcal S)=\\left\\{z_F\\in\\Omega_F(\\mathcal S)\\middle|\\forall r_F\\in\\mathcal R_F^{K}(\\mathcal S):r_F\\subseteq z_F\\right\\}','Der kohärente Bereich des funktionalen Zustandsraumes.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.836');

UPDATE equations SET
 section_id=@section_id,title='Teilmengenbeziehung kohärenter Zustände',equation_latex='\\Omega_F^{K}(\\mathcal S)\\subseteq\\Omega_F(\\mathcal S)',word_latex='\\Omega_F^{K}(\\mathcal S)\\subseteq\\Omega_F(\\mathcal S)',
 plain_description='Kohärente Zustände bilden eine Teilmenge des Zustandsraumes.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.837';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.837',@section_id,'Teilmengenbeziehung kohärenter Zustände','\\Omega_F^{K}(\\mathcal S)\\subseteq\\Omega_F(\\mathcal S)','\\Omega_F^{K}(\\mathcal S)\\subseteq\\Omega_F(\\mathcal S)','Kohärente Zustände bilden eine Teilmenge des Zustandsraumes.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.837');

UPDATE equations SET
 section_id=@section_id,title='Erhaltung kohärenter Zustände',equation_latex='z_F\\in\\Omega_F^{K}(\\mathcal S)\\land O_F\\in\\mathcal O_F^{K}(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)',word_latex='z_F\\in\\Omega_F^{K}(\\mathcal S)\\land O_F\\in\\mathcal O_F^{K}(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Kohärenzerhaltende Operatoren bilden kohärente Zustände auf kohärente Zustände ab.',equation_type='lemma',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.838';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.838',@section_id,'Erhaltung kohärenter Zustände','z_F\\in\\Omega_F^{K}(\\mathcal S)\\land O_F\\in\\mathcal O_F^{K}(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)','z_F\\in\\Omega_F^{K}(\\mathcal S)\\land O_F\\in\\mathcal O_F^{K}(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)','Kohärenzerhaltende Operatoren bilden kohärente Zustände auf kohärente Zustände ab.','lemma','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.838');

UPDATE equations SET
 section_id=@section_id,title='Kohärenter Ausgangszustand',equation_latex='z_F\\in\\Omega_F^{K}(\\mathcal S)',word_latex='z_F\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Voraussetzung des Beweises zu Lemma 3.4.8.',equation_type='other',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.839';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.839',@section_id,'Kohärenter Ausgangszustand','z_F\\in\\Omega_F^{K}(\\mathcal S)','z_F\\in\\Omega_F^{K}(\\mathcal S)','Voraussetzung des Beweises zu Lemma 3.4.8.','other','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.839');

UPDATE equations SET
 section_id=@section_id,title='Kohärenztragende Relation im Beweis',equation_latex='r_F\\in\\mathcal R_F^{K}(\\mathcal S)',word_latex='r_F\\in\\mathcal R_F^{K}(\\mathcal S)',
 plain_description='Beliebige kohärenztragende Relation im Beweis.',equation_type='other',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.840';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.840',@section_id,'Kohärenztragende Relation im Beweis','r_F\\in\\mathcal R_F^{K}(\\mathcal S)','r_F\\in\\mathcal R_F^{K}(\\mathcal S)','Beliebige kohärenztragende Relation im Beweis.','other','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.840');

UPDATE equations SET
 section_id=@section_id,title='Kohärenzerhaltender Operator im Beweis',equation_latex='O_F\\in\\mathcal O_F^{K}(\\mathcal S)',word_latex='O_F\\in\\mathcal O_F^{K}(\\mathcal S)',
 plain_description='Voraussetzung des Beweises zu Lemma 3.4.8.',equation_type='other',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.841';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.841',@section_id,'Kohärenzerhaltender Operator im Beweis','O_F\\in\\mathcal O_F^{K}(\\mathcal S)','O_F\\in\\mathcal O_F^{K}(\\mathcal S)','Voraussetzung des Beweises zu Lemma 3.4.8.','other','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.841');

UPDATE equations SET
 section_id=@section_id,title='Kohärenter Folgezustand',equation_latex='O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)',word_latex='O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Ergebnis des Beweises zu Lemma 3.4.8.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.842';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.842',@section_id,'Kohärenter Folgezustand','O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)','O_F(z_F)\\in\\Omega_F^{K}(\\mathcal S)','Ergebnis des Beweises zu Lemma 3.4.8.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.842');

UPDATE equations SET
 section_id=@section_id,title='Zwei kohärenzerhaltende Operatoren',equation_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F^{K}(\\mathcal S)',word_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F^{K}(\\mathcal S)',
 plain_description='Voraussetzung der Abgeschlossenheit unter Komposition.',equation_type='other',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.843';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.843',@section_id,'Zwei kohärenzerhaltende Operatoren','O_{F,1},O_{F,2}\\in\\mathcal O_F^{K}(\\mathcal S)','O_{F,1},O_{F,2}\\in\\mathcal O_F^{K}(\\mathcal S)','Voraussetzung der Abgeschlossenheit unter Komposition.','other','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.843');

UPDATE equations SET
 section_id=@section_id,title='Abgeschlossenheit der Komposition',equation_latex='O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)',word_latex='O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)',
 plain_description='Die Komposition kohärenzerhaltender Operatoren ist kohärenzerhaltend.',equation_type='lemma',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.844';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.844',@section_id,'Abgeschlossenheit der Komposition','O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)','O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)','Die Komposition kohärenzerhaltender Operatoren ist kohärenzerhaltend.','lemma','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.844');

UPDATE equations SET
 section_id=@section_id,title='Erster kohärenter Zwischenzustand',equation_latex='O_{F,1}(z_F)\\in\\Omega_F^{K}(\\mathcal S)',word_latex='O_{F,1}(z_F)\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Der erste Operator erhält die Zustandskohärenz.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.845';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.845',@section_id,'Erster kohärenter Zwischenzustand','O_{F,1}(z_F)\\in\\Omega_F^{K}(\\mathcal S)','O_{F,1}(z_F)\\in\\Omega_F^{K}(\\mathcal S)','Der erste Operator erhält die Zustandskohärenz.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.845');

UPDATE equations SET
 section_id=@section_id,title='Zweiter kohärenter Zwischenzustand',equation_latex='O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F^{K}(\\mathcal S)',word_latex='O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Auch die zweite Operatorwirkung erhält die Zustandskohärenz.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.846';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.846',@section_id,'Zweiter kohärenter Zwischenzustand','O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F^{K}(\\mathcal S)','O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F^{K}(\\mathcal S)','Auch die zweite Operatorwirkung erhält die Zustandskohärenz.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.846');

UPDATE equations SET
 section_id=@section_id,title='Kohärenz der zusammengesetzten Wirkung',equation_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F^{K}(\\mathcal S)',word_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Die zusammengesetzte Wirkung bildet kohärente Zustände auf kohärente Zustände ab.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.847';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.847',@section_id,'Kohärenz der zusammengesetzten Wirkung','\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F^{K}(\\mathcal S)','\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F^{K}(\\mathcal S)','Die zusammengesetzte Wirkung bildet kohärente Zustände auf kohärente Zustände ab.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.847');

UPDATE equations SET
 section_id=@section_id,title='Untermonoid kohärenzerhaltender Operatoren',equation_latex='\\left(\\mathcal O_F^{K}(\\mathcal S),\\circ,I_F\\right)\\leq\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)',word_latex='\\left(\\mathcal O_F^{K}(\\mathcal S),\\circ,I_F\\right)\\leq\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)',
 plain_description='Die kohärenzerhaltenden Operatoren bilden ein Untermonoid.',equation_type='theorem',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.848';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.848',@section_id,'Untermonoid kohärenzerhaltender Operatoren','\\left(\\mathcal O_F^{K}(\\mathcal S),\\circ,I_F\\right)\\leq\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)','\\left(\\mathcal O_F^{K}(\\mathcal S),\\circ,I_F\\right)\\leq\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)','Die kohärenzerhaltenden Operatoren bilden ein Untermonoid.','theorem','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.848');

UPDATE equations SET
 section_id=@section_id,title='Identitätsoperator als kohärenzerhaltender Operator',equation_latex='I_F\\in\\mathcal O_F^{K}(\\mathcal S)',word_latex='I_F\\in\\mathcal O_F^{K}(\\mathcal S)',
 plain_description='Der Identitätsoperator erhält jede kohärenztragende Relation.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.849';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.849',@section_id,'Identitätsoperator als kohärenzerhaltender Operator','I_F\\in\\mathcal O_F^{K}(\\mathcal S)','I_F\\in\\mathcal O_F^{K}(\\mathcal S)','Der Identitätsoperator erhält jede kohärenztragende Relation.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.849');

UPDATE equations SET
 section_id=@section_id,title='Funktionaler Entwicklungspfad',equation_latex='\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',word_latex='\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
 plain_description='Allgemeine Form eines funktionalen Entwicklungspfads.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.850';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.850',@section_id,'Funktionaler Entwicklungspfad','\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)','\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)','Allgemeine Form eines funktionalen Entwicklungspfads.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.850');

UPDATE equations SET
 section_id=@section_id,title='Kohärenter Ausgangszustand eines Pfads',equation_latex='z_F^{(0)}\\in\\Omega_F^{K}(\\mathcal S)',word_latex='z_F^{(0)}\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Der Ausgangszustand eines kohärenten Pfads ist kohärent.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.851';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.851',@section_id,'Kohärenter Ausgangszustand eines Pfads','z_F^{(0)}\\in\\Omega_F^{K}(\\mathcal S)','z_F^{(0)}\\in\\Omega_F^{K}(\\mathcal S)','Der Ausgangszustand eines kohärenten Pfads ist kohärent.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.851');

UPDATE equations SET
 section_id=@section_id,title='Kohärenzerhaltende Operatorfolge',equation_latex='O_{F,k}\\in\\mathcal O_F^{K}(\\mathcal S)\\qquad\\text{für alle }k=1,\\ldots,n',word_latex='O_{F,k}\\in\\mathcal O_F^{K}(\\mathcal S)\\qquad\\text{für alle }k=1,\\ldots,n',
 plain_description='Jeder Operator eines kohärenten Entwicklungspfads ist kohärenzerhaltend.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.852';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.852',@section_id,'Kohärenzerhaltende Operatorfolge','O_{F,k}\\in\\mathcal O_F^{K}(\\mathcal S)\\qquad\\text{für alle }k=1,\\ldots,n','O_{F,k}\\in\\mathcal O_F^{K}(\\mathcal S)\\qquad\\text{für alle }k=1,\\ldots,n','Jeder Operator eines kohärenten Entwicklungspfads ist kohärenzerhaltend.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.852');

UPDATE equations SET
 section_id=@section_id,title='Menge kohärenter Entwicklungspfade',equation_latex='\\mathfrak P_F^{K}(\\mathcal S)',word_latex='\\mathfrak P_F^{K}(\\mathcal S)',
 plain_description='Bezeichnung der Menge aller kohärenten Entwicklungspfade.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.853';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.853',@section_id,'Menge kohärenter Entwicklungspfade','\\mathfrak P_F^{K}(\\mathcal S)','\\mathfrak P_F^{K}(\\mathcal S)','Bezeichnung der Menge aller kohärenten Entwicklungspfade.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.853');

UPDATE equations SET
 section_id=@section_id,title='Zustandserhaltung entlang kohärenter Pfade',equation_latex='\\mathcal P_F^{(n)}\\in\\mathfrak P_F^{K}(\\mathcal S)\\Longrightarrow\\forall k\\in\\{0,\\ldots,n\\}:\\;z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)',word_latex='\\mathcal P_F^{(n)}\\in\\mathfrak P_F^{K}(\\mathcal S)\\Longrightarrow\\forall k\\in\\{0,\\ldots,n\\}:\\;z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Alle Zustände eines kohärenten Entwicklungspfads sind kohärent.',equation_type='theorem',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.854';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.854',@section_id,'Zustandserhaltung entlang kohärenter Pfade','\\mathcal P_F^{(n)}\\in\\mathfrak P_F^{K}(\\mathcal S)\\Longrightarrow\\forall k\\in\\{0,\\ldots,n\\}:\\;z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)','\\mathcal P_F^{(n)}\\in\\mathfrak P_F^{K}(\\mathcal S)\\Longrightarrow\\forall k\\in\\{0,\\ldots,n\\}:\\;z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)','Alle Zustände eines kohärenten Entwicklungspfads sind kohärent.','theorem','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.854');

UPDATE equations SET
 section_id=@section_id,title='Induktionsannahme der Pfadkohärenz',equation_latex='z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)',word_latex='z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Induktionsannahme im Beweis zu Satz 3.4.10.',equation_type='other',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.855';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.855',@section_id,'Induktionsannahme der Pfadkohärenz','z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)','z_F^{(k)}\\in\\Omega_F^{K}(\\mathcal S)','Induktionsannahme im Beweis zu Satz 3.4.10.','other','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.855');

UPDATE equations SET
 section_id=@section_id,title='Nächster kohärenzerhaltender Operator',equation_latex='O_{F,k+1}\\in\\mathcal O_F^{K}(\\mathcal S)',word_latex='O_{F,k+1}\\in\\mathcal O_F^{K}(\\mathcal S)',
 plain_description='Der nächste Operator des Pfads ist kohärenzerhaltend.',equation_type='other',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.856';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.856',@section_id,'Nächster kohärenzerhaltender Operator','O_{F,k+1}\\in\\mathcal O_F^{K}(\\mathcal S)','O_{F,k+1}\\in\\mathcal O_F^{K}(\\mathcal S)','Der nächste Operator des Pfads ist kohärenzerhaltend.','other','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.856');

UPDATE equations SET
 section_id=@section_id,title='Kohärenter nächster Zustand',equation_latex='z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)\\in\\Omega_F^{K}(\\mathcal S)',word_latex='z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)\\in\\Omega_F^{K}(\\mathcal S)',
 plain_description='Der nächste Zustand bleibt kohärent.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.857';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.857',@section_id,'Kohärenter nächster Zustand','z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)\\in\\Omega_F^{K}(\\mathcal S)','z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)\\in\\Omega_F^{K}(\\mathcal S)','Der nächste Zustand bleibt kohärent.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.857');

UPDATE equations SET
 section_id=@section_id,title='Kohärenz des Gesamtoperators',equation_latex='O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)',word_latex='O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)',
 plain_description='Der Gesamtoperator eines kohärenten Pfads ist kohärenzerhaltend.',equation_type='derived',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.858';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.858',@section_id,'Kohärenz des Gesamtoperators','O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)','O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F^{K}(\\mathcal S)','Der Gesamtoperator eines kohärenten Pfads ist kohärenzerhaltend.','derived','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.858');

UPDATE equations SET
 section_id=@section_id,title='Übergang mit möglichem Kohärenzbruch',equation_latex='z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}',word_latex='z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}',
 plain_description='Darstellung eines Übergangs zur Definition des Kohärenzbruchs.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.859';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.859',@section_id,'Übergang mit möglichem Kohärenzbruch','z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}','z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}','Darstellung eines Übergangs zur Definition des Kohärenzbruchs.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.859');

UPDATE equations SET
 section_id=@section_id,title='Bedingung eines funktionalen Kohärenzbruchs',equation_latex='z_F\\in\\Omega_F^{K}(\\mathcal S)\\land z_F^{\\prime}\\notin\\Omega_F^{K}(\\mathcal S)',word_latex='z_F\\in\\Omega_F^{K}(\\mathcal S)\\land z_F^{\\prime}\\notin\\Omega_F^{K}(\\mathcal S)',
 plain_description='Ein kohärenter Ausgangszustand wird in einen inkohärenten Folgezustand überführt.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.860';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.860',@section_id,'Bedingung eines funktionalen Kohärenzbruchs','z_F\\in\\Omega_F^{K}(\\mathcal S)\\land z_F^{\\prime}\\notin\\Omega_F^{K}(\\mathcal S)','z_F\\in\\Omega_F^{K}(\\mathcal S)\\land z_F^{\\prime}\\notin\\Omega_F^{K}(\\mathcal S)','Ein kohärenter Ausgangszustand wird in einen inkohärenten Folgezustand überführt.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.860');

UPDATE equations SET
 section_id=@section_id,title='Verlust einer kohärenztragenden Relation',equation_latex='\\exists r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\land\\nexists r_F^{\\prime}\\subseteq z_F^{\\prime}:\\;r_F^{\\prime}\\sim_F r_F',word_latex='\\exists r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\land\\nexists r_F^{\\prime}\\subseteq z_F^{\\prime}:\\;r_F^{\\prime}\\sim_F r_F',
 plain_description='Mindestens eine kohärenztragende Relation wird nicht funktional äquivalent fortgeführt.',equation_type='definition',provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.',assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.861';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.861',@section_id,'Verlust einer kohärenztragenden Relation','\\exists r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\land\\nexists r_F^{\\prime}\\subseteq z_F^{\\prime}:\\;r_F^{\\prime}\\sim_F r_F','\\exists r_F\\in\\mathcal R_F^{K}(\\mathcal S):\\quad r_F\\subseteq z_F\\land\\nexists r_F^{\\prime}\\subseteq z_F^{\\prime}:\\;r_F^{\\prime}\\sim_F r_F','Mindestens eine kohärenztragende Relation wird nicht funktional äquivalent fortgeführt.','definition','original',NULL,'Literaturgestützte Rekonstruktion in Abschnitt 3.4.7.','Die Definitionen und Sätze der Abschnitte 3.4.4 bis 3.4.6 werden vorausgesetzt.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.861');

/* Definitionen */
DELETE FROM definitions WHERE definition_number IN
('3.4.21','Def. 3.4.21','3.4.22','Def. 3.4.22','3.4.23','Def. 3.4.23','3.4.24','Def. 3.4.24','3.4.25','Def. 3.4.25','3.4.26','Def. 3.4.26');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('3.4.21',@section_id,'Kohärenztragende Relationsstruktur',
'Eine kohärenztragende Relationsstruktur ist eine nichtleere Teilmenge der funktionalen Relationen einer Organisation, deren Erhaltung als Kohärenzbedingung festgelegt wird.',
'\mathcal R_F^{K}(\mathcal S)\subseteq\mathcal R_F(\mathcal S),\quad\mathcal R_F^{K}(\mathcal S)\neq\varnothing',
'\mathcal R_F^{K}(\mathcal S)\subseteq\mathcal R_F(\mathcal S),\quad\mathcal R_F^{K}(\mathcal S)\neq\varnothing',
'original',NULL,'Eine funktionale Organisation und ihre Relationsmenge sind gegeben.','Die sachliche Auswahl kohärenztragender Relationen ist Teil der jeweiligen Modellierung.','checked',@revision_id),
('3.4.22',@section_id,'Funktionale Relationserhaltung',
'Eine kohärenztragende Relation gilt unter einer Operatorwirkung als funktional erhalten, wenn im Folgezustand eine zu ihr funktional äquivalente Relation existiert.',
'r_F^{\prime}\sim_F r_F',
'r_F^{\prime}\sim_F r_F',
'original',NULL,'Funktionale Äquivalenz und kohärenztragende Relationsstruktur.','Strenge Identität ist nicht erforderlich.','checked',@revision_id),
('3.4.23',@section_id,'Kohärenzerhaltender Operator',
'Ein funktionaler Operator ist kohärenzerhaltend, wenn er jede im Ausgangszustand realisierte kohärenztragende Relation durch eine funktional äquivalente Relation im Folgezustand fortführt.',
'\forall r_F\in\mathcal R_F^{K}(\mathcal S):r_F\subseteq z_F\Longrightarrow\exists r_F^{\prime}\subseteq O_F(z_F):r_F^{\prime}\sim_F r_F',
'\forall r_F\in\mathcal R_F^{K}(\mathcal S):r_F\subseteq z_F\Longrightarrow\exists r_F^{\prime}\subseteq O_F(z_F):r_F^{\prime}\sim_F r_F',
'original',NULL,'Definitionen 3.4.21 und 3.4.22.','Kohärenzerhaltung wird relativ zur gewählten Relationsstruktur bestimmt.','checked',@revision_id),
('3.4.24',@section_id,'Funktional kohärenter Zustand',
'Ein funktionaler Zustand ist bezüglich einer kohärenztragenden Relationsstruktur kohärent, wenn sämtliche darin geforderten Relationen im Zustand realisiert sind.',
'\forall r_F\in\mathcal R_F^{K}(\mathcal S):r_F\subseteq z_F',
'\forall r_F\in\mathcal R_F^{K}(\mathcal S):r_F\subseteq z_F',
'original',NULL,'Definition 3.4.21.','Kohärenz ist keine vom Organisationsbezug unabhängige Zustandseigenschaft.','checked',@revision_id),
('3.4.25',@section_id,'Funktional kohärenter Entwicklungspfad',
'Ein funktionaler Entwicklungspfad ist kohärent, wenn sein Ausgangszustand kohärent ist und jeder Operator der Folge kohärenzerhaltend wirkt.',
'z_F^{(0)}\in\Omega_F^{K}(\mathcal S),\quad O_{F,k}\in\mathcal O_F^{K}(\mathcal S)',
'z_F^{(0)}\in\Omega_F^{K}(\mathcal S),\quad O_{F,k}\in\mathcal O_F^{K}(\mathcal S)',
'original',NULL,'Definition 3.4.19 sowie Definitionen 3.4.23 und 3.4.24.','Lokale Kohärenzerhaltung wird auf vollständige Pfade erweitert.','checked',@revision_id),
('3.4.26',@section_id,'Funktionaler Kohärenzbruch',
'Ein funktionaler Kohärenzbruch liegt vor, wenn ein kohärenter Ausgangszustand durch einen Übergang in einen nicht kohärenten Folgezustand überführt wird.',
'z_F\in\Omega_F^{K}(\mathcal S)\land z_F^{\prime}\notin\Omega_F^{K}(\mathcal S)',
'z_F\in\Omega_F^{K}(\mathcal S)\land z_F^{\prime}\notin\Omega_F^{K}(\mathcal S)',
'original',NULL,'Definitionen 3.4.22 bis 3.4.25.','Mindestens eine kohärenztragende Relation wird nicht funktional äquivalent fortgeführt.','checked',@revision_id);

/* Lemmata */
DELETE FROM lemmas WHERE lemma_number IN ('Lemma 3.4.8','Lemma 3.4.9');
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.8',@section_id,'Erhaltung kohärenter Zustände durch kohärenzerhaltende Operatoren',
'Jeder kohärenzerhaltende Operator bildet einen kohärenten Zustand auf einen kohärenten Folgezustand ab.',
'z_F\in\Omega_F^{K}(\mathcal S)\land O_F\in\mathcal O_F^{K}(\mathcal S)\Longrightarrow O_F(z_F)\in\Omega_F^{K}(\mathcal S)',
'z_F\in\Omega_F^{K}(\mathcal S)\land O_F\in\mathcal O_F^{K}(\mathcal S)\Longrightarrow O_F(z_F)\in\Omega_F^{K}(\mathcal S)',
'original',NULL,'Definitionen 3.4.23 und 3.4.24.','checked',@revision_id),
('Lemma 3.4.9',@section_id,'Abgeschlossenheit kohärenzerhaltender Operatorkompositionen',
'Die Komposition zweier kohärenzerhaltender Operatoren ist wiederum kohärenzerhaltend.',
'O_{F,1},O_{F,2}\in\mathcal O_F^{K}(\mathcal S)\Longrightarrow O_{F,2}\circ O_{F,1}\in\mathcal O_F^{K}(\mathcal S)',
'O_{F,1},O_{F,2}\in\mathcal O_F^{K}(\mathcal S)\Longrightarrow O_{F,2}\circ O_{F,1}\in\mathcal O_F^{K}(\mathcal S)',
'original',NULL,'Lemma 3.4.8 und Abgeschlossenheit der funktionalen Operatormenge.','checked',@revision_id);

/* Sätze */
DELETE FROM theorems WHERE theorem_number IN ('Satz 3.4.9','Satz 3.4.10');
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.9',@section_id,'Monoid kohärenzerhaltender Operatoren',
'Die kohärenzerhaltenden Operatoren bilden mit der Komposition und dem Identitätsoperator ein Untermonoid der funktionalen Operatormenge.',
'\left(\mathcal O_F^{K}(\mathcal S),\circ,I_F\right)\leq\left(\mathcal O_F(\mathcal S),\circ,I_F\right)',
'\left(\mathcal O_F^{K}(\mathcal S),\circ,I_F\right)\leq\left(\mathcal O_F(\mathcal S),\circ,I_F\right)',
'adapted',@source_dummit,'Lemma 3.4.9, Assoziativität und Identitätsoperator.','checked',@revision_id),
('Satz 3.4.10',@section_id,'Zustandserhaltung entlang kohärenter Entwicklungspfade',
'In einem funktional kohärenten Entwicklungspfad sind sämtliche durchlaufenen Zustände funktional kohärent.',
'\mathcal P_F^{(n)}\in\mathfrak P_F^{K}(\mathcal S)\Longrightarrow\forall k\in\{0,\ldots,n\}:z_F^{(k)}\in\Omega_F^{K}(\mathcal S)',
'\mathcal P_F^{(n)}\in\mathfrak P_F^{K}(\mathcal S)\Longrightarrow\forall k\in\{0,\ldots,n\}:z_F^{(k)}\in\Omega_F^{K}(\mathcal S)',
'original',NULL,'Definition 3.4.25 und Lemma 3.4.8.','checked',@revision_id);

SELECT lemma_id INTO @lemma_348 FROM lemmas WHERE lemma_number='Lemma 3.4.8' LIMIT 1;
SELECT lemma_id INTO @lemma_349 FROM lemmas WHERE lemma_number='Lemma 3.4.9' LIMIT 1;
SELECT theorem_id INTO @satz_349 FROM theorems WHERE theorem_number='Satz 3.4.9' LIMIT 1;
SELECT theorem_id INTO @satz_3410 FROM theorems WHERE theorem_number='Satz 3.4.10' LIMIT 1;

/* Korollar */
DELETE FROM corollaries WHERE corollary_number IN ('Korollar 3.4.9');
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.9',@section_id,'Kohärenz des Gesamtoperators',
'Der Gesamtoperator jedes funktional kohärenten Entwicklungspfads ist kohärenzerhaltend.',
'O_F^{[n]}=O_{F,n}\circ\cdots\circ O_{F,1}\in\mathcal O_F^{K}(\mathcal S)',
'O_F^{[n]}=O_{F,n}\circ\cdots\circ O_{F,1}\in\mathcal O_F^{K}(\mathcal S)',
@satz_3410,NULL,'original',NULL,'checked',@revision_id);

SELECT corollary_id INTO @kor_349 FROM corollaries WHERE corollary_number='Korollar 3.4.9' LIMIT 1;

/* Beweise */
DELETE FROM proofs WHERE proof_number IN ('Bew. 3.4.7-R1','Bew. 3.4.7-R2','Bew. 3.4.7-R3','Bew. 3.4.7-R4','Bew. 3.4.7-R5');
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.7-R1',@section_id,NULL,@lemma_348,NULL,'Beweis zu Lemma 3.4.8',
'In einem kohärenten Ausgangszustand ist jede kohärenztragende Relation realisiert. Ein kohärenzerhaltender Operator führt jede dieser Relationen funktional äquivalent fort. Daher sind alle geforderten Relationen auch im Folgezustand realisiert.',
'O_F(z_F)\in\Omega_F^{K}(\mathcal S)','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.7-R2',@section_id,NULL,@lemma_349,NULL,'Beweis zu Lemma 3.4.9',
'Der erste kohärenzerhaltende Operator bildet einen kohärenten Zustand auf einen kohärenten Zwischenzustand ab. Der zweite kohärenzerhaltende Operator bildet auch diesen Zwischenzustand auf einen kohärenten Zustand ab. Damit ist die Komposition kohärenzerhaltend.',
'\left(O_{F,2}\circ O_{F,1}\right)(z_F)\in\Omega_F^{K}(\mathcal S)','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.7-R3',@section_id,@satz_349,NULL,NULL,'Beweis zu Satz 3.4.9',
'Die Abgeschlossenheit folgt aus Lemma 3.4.9. Die Assoziativität wird von der funktionalen Operatormenge übernommen. Der Identitätsoperator erhält jede Relation unverändert und gehört deshalb zur kohärenzerhaltenden Operatormenge.',
'I_F\in\mathcal O_F^{K}(\mathcal S)','direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.7-R4',@section_id,@satz_3410,NULL,NULL,'Beweis zu Satz 3.4.10',
'Der Ausgangszustand ist nach Definition kohärent. Unter der Induktionsannahme ist der aktuelle Zustand kohärent; der nächste Operator ist kohärenzerhaltend. Nach Lemma 3.4.8 ist deshalb auch der nächste Zustand kohärent. Die Aussage folgt durch vollständige Induktion.',
'z_F^{(k+1)}=O_{F,k+1}(z_F^{(k)})\in\Omega_F^{K}(\mathcal S)','induction','original',NULL,'checked',@revision_id),
('Bew. 3.4.7-R5',@section_id,NULL,NULL,@kor_349,'Begründung zu Korollar 3.4.9',
'Der Gesamtoperator ist eine endliche Komposition kohärenzerhaltender Operatoren. Aufgrund der Abgeschlossenheit des Untermonoids ist auch der Gesamtoperator kohärenzerhaltend.',
'O_F^{[n]}\in\mathcal O_F^{K}(\mathcal S)','direct','original',NULL,'checked',@revision_id);

/* Quellenverwendungen */
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_dummit,@section_id,'background','Algebraische Grundlagen von Monoiden, Untermonoiden, Abgeschlossenheit und Identität.','3.4.7.5',0,1,'Bestandsquelle [31].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_dummit AND section_id=@section_id AND exact_location='3.4.7.5');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_conway,@section_id,'comparison','Invariante Teilräume und Operatorwirkungen als funktionalanalytische Vergleichsgrundlage.','3.4.7.8',0,1,'Bestandsquelle [35].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_conway AND section_id=@section_id AND exact_location='3.4.7.8');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_hirsch,@section_id,'comparison','Stabilität und invariante Zustandsbereiche dynamischer Systeme als wissenschaftliche Abgrenzung.','3.4.7.1 und 3.4.7.8',0,1,'Bestandsquelle [40].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_hirsch AND section_id=@section_id AND exact_location='3.4.7.1 und 3.4.7.8');

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'rewritten','section','3.4.7','Abschnitt 3.4.7 vollständig literaturgestützt neu gefasst.','Frühere oder fehlende Fassung','Revision mit relationaler Kohärenz, kohärenzerhaltenden Operatoren, kohärenten Pfaden und Kohärenzbruch'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.4.7');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'equation_changed','equations','3.823–3.861','39 Gleichungen aktualisiert beziehungsweise ergänzt.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.823–3.861');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'definition_added','definitions','3.4.21–3.4.26','Sechs Definitionen registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.4.21–3.4.26');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'statement_added','statements','Lemma/Satz/Korollar 3.4.7','Zwei Lemmata, zwei Sätze und ein Korollar registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='Lemma/Satz/Korollar 3.4.7');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'proof_added','proofs','Bew. 3.4.7-R1–R5','Fünf Beweis- und Begründungsdatensätze registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='Bew. 3.4.7-R1–R5');

/* Repository-Zähler */
INSERT INTO repository_counters(counter_key,counter_value) VALUES ('last_completed_section','3.4.7')
ON DUPLICATE KEY UPDATE counter_value='3.4.7';
INSERT INTO repository_counters(counter_key,counter_value) VALUES ('last_repository_revision','RKB-REV-K3.4.7-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-REV-K3.4.7-V1';
INSERT INTO repository_counters(counter_key,counter_value) VALUES ('next_equation_number','3.862')
ON DUPLICATE KEY UPDATE counter_value='3.862';

COMMIT;

/* Audit */
SELECT revision_id,revision_code,scope_reference,version_label FROM repository_revisions WHERE revision_code=@revision_code;
SELECT section_id,section_code,title,status,is_original_contribution FROM dissertation_sections WHERE section_code='3.4.7';
SELECT COUNT(*) AS equations_3_823_to_3_861 FROM equations
WHERE section_id=@section_id AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 823 AND 861;
SELECT equation_number,title,equation_type,validation_status FROM equations
WHERE section_id=@section_id AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 823 AND 861
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
SELECT definition_number,title,validation_status FROM definitions WHERE section_id=@section_id ORDER BY definition_number;
SELECT lemma_number,title,validation_status FROM lemmas WHERE section_id=@section_id AND lemma_number IN ('Lemma 3.4.8','Lemma 3.4.9');
SELECT theorem_number,title,validation_status FROM theorems WHERE section_id=@section_id AND theorem_number IN ('Satz 3.4.9','Satz 3.4.10');
SELECT corollary_number,title,validation_status FROM corollaries WHERE section_id=@section_id AND corollary_number='Korollar 3.4.9';
SELECT proof_number,title,validation_status FROM proofs WHERE section_id=@section_id AND proof_number LIKE 'Bew. 3.4.7-R%';
SELECT s.citation_number,s.title,su.exact_location,su.citation_checked
FROM source_usage su JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id AND s.citation_number IN (31,35,40)
ORDER BY s.citation_number;
SELECT counter_key,counter_value FROM repository_counters
WHERE counter_key IN ('last_completed_section','last_repository_revision','next_equation_number')
ORDER BY counter_key;
