/* =====================================================================
   FRZK-RKB – Repository-Update Abschnitt 3.4.6
   Funktionale Übergänge und Operatorfolgen
   Gleichungen (3.771)–(3.822)
   Definitionen 3.4.15–3.4.20
   Lemma 3.4.6–3.4.7
   Satz 3.4.7–3.4.8
   Korollar 3.4.7–3.4.8
   Beweise, Quellenverwendungen, Änderungsprotokoll und Audit
   Schema geprüft gegen frzk_rkb(3).sql
   ===================================================================== */

ROLLBACK;
START TRANSACTION;

SET @revision_code := 'RKB-REV-K3.4.6-V1';

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4.6'
LIMIT 1;

SELECT source_id INTO @source_dummit
FROM sources WHERE citation_number=31 LIMIT 1;

SELECT source_id INTO @source_hirsch
FROM sources WHERE citation_number=40 LIMIT 1;

SELECT source_id INTO @source_diestel
FROM sources WHERE citation_number=47 LIMIT 1;

SELECT revision_id INTO @parent_revision_id
FROM repository_revisions
ORDER BY revision_id DESC LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT @revision_code,NOW(),'section','3.4.6','1.0-complete',
'Vollständige literaturgestützte Revision von 3.4.6: funktionale Übergänge, Operatorfolgen, Zustandsfolgen, Entwicklungspfade und funktionale Übergangsordnung.',
'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SELECT revision_id INTO @revision_id
FROM repository_revisions WHERE revision_code=@revision_code LIMIT 1;

DROP PROCEDURE IF EXISTS frzk_assert_346;
DELIMITER $$
CREATE PROCEDURE frzk_assert_346()
BEGIN
 IF @section_id IS NULL THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Abschnitt 3.4.6 fehlt.';
 END IF;
 IF @source_dummit IS NULL OR @source_hirsch IS NULL OR @source_diestel IS NULL THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Bestandsquelle [31], [40] oder [47] fehlt.';
 END IF;
END$$
DELIMITER ;
CALL frzk_assert_346();
DROP PROCEDURE frzk_assert_346;

UPDATE dissertation_sections
SET title='Funktionale Übergänge und Operatorfolgen',
    status='review',
    is_original_contribution=1,
    notes='Vollständige literaturgestützte Revision: Übergänge, Operatorfolgen, Zustandsfolgen, Entwicklungspfade und Übergangsordnung.'
WHERE section_id=@section_id;

UPDATE equations SET
 section_id=@section_id,title='Zustände eines funktionalen Übergangs',
 equation_latex='z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)',word_latex='z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)',
 plain_description='Ausgangs- und Folgezustand gehören zum funktionalen Zustandsraum.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.771';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.771',@section_id,'Zustände eines funktionalen Übergangs','z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)','z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S)','Ausgangs- und Folgezustand gehören zum funktionalen Zustandsraum.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.771');

UPDATE equations SET
 section_id=@section_id,title='Operator eines funktionalen Übergangs',
 equation_latex='O_F\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Der Übergangsoperator gehört zur funktionalen Operatormenge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.772';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.772',@section_id,'Operator eines funktionalen Übergangs','O_F\\in\\mathcal O_F(\\mathcal S)','O_F\\in\\mathcal O_F(\\mathcal S)','Der Übergangsoperator gehört zur funktionalen Operatormenge.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.772');

UPDATE equations SET
 section_id=@section_id,title='Funktionaler Übergang',
 equation_latex='\\tau_F=\\left(z_F,O_F,z_F^{\\prime}\\right)',word_latex='\\tau_F=\\left(z_F,O_F,z_F^{\\prime}\\right)',
 plain_description='Geordnetes Tripel aus Ausgangszustand, Operator und Folgezustand.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.773';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.773',@section_id,'Funktionaler Übergang','\\tau_F=\\left(z_F,O_F,z_F^{\\prime}\\right)','\\tau_F=\\left(z_F,O_F,z_F^{\\prime}\\right)','Geordnetes Tripel aus Ausgangszustand, Operator und Folgezustand.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.773');

UPDATE equations SET
 section_id=@section_id,title='Übergangsbedingung',
 equation_latex='z_F^{\\prime}=O_F(z_F)',word_latex='z_F^{\\prime}=O_F(z_F)',
 plain_description='Der Folgezustand entsteht durch die Operatorwirkung.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.774';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.774',@section_id,'Übergangsbedingung','z_F^{\\prime}=O_F(z_F)','z_F^{\\prime}=O_F(z_F)','Der Folgezustand entsteht durch die Operatorwirkung.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.774');

UPDATE equations SET
 section_id=@section_id,title='Notation des funktionalen Übergangs',
 equation_latex='z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}',word_latex='z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}',
 plain_description='Gerichtete Notation eines funktionalen Übergangs.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.775';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.775',@section_id,'Notation des funktionalen Übergangs','z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}','z_F\\xrightarrow{\\,O_F\\,}z_F^{\\prime}','Gerichtete Notation eines funktionalen Übergangs.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.775');

UPDATE equations SET
 section_id=@section_id,title='Funktionale Übergangsmenge',
 equation_latex='\\mathcal T_F(\\mathcal S)=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S),O_F\\in\\mathcal O_F(\\mathcal S),z_F^{\\prime}=O_F(z_F)\\right\\}',word_latex='\\mathcal T_F(\\mathcal S)=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S),O_F\\in\\mathcal O_F(\\mathcal S),z_F^{\\prime}=O_F(z_F)\\right\\}',
 plain_description='Menge aller zulässigen konkreten funktionalen Übergänge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.776';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.776',@section_id,'Funktionale Übergangsmenge','\\mathcal T_F(\\mathcal S)=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S),O_F\\in\\mathcal O_F(\\mathcal S),z_F^{\\prime}=O_F(z_F)\\right\\}','\\mathcal T_F(\\mathcal S)=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F,z_F^{\\prime}\\in\\Omega_F(\\mathcal S),O_F\\in\\mathcal O_F(\\mathcal S),z_F^{\\prime}=O_F(z_F)\\right\\}','Menge aller zulässigen konkreten funktionalen Übergänge.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.776');

UPDATE equations SET
 section_id=@section_id,title='Zugehörigkeit zur Übergangsmenge',
 equation_latex='\\tau_F\\in\\mathcal T_F(\\mathcal S)',word_latex='\\tau_F\\in\\mathcal T_F(\\mathcal S)',
 plain_description='Ein funktionaler Übergang gehört zur Übergangsmenge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.777';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.777',@section_id,'Zugehörigkeit zur Übergangsmenge','\\tau_F\\in\\mathcal T_F(\\mathcal S)','\\tau_F\\in\\mathcal T_F(\\mathcal S)','Ein funktionaler Übergang gehört zur Übergangsmenge.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.777');

UPDATE equations SET
 section_id=@section_id,title='Funktionale Operatorfolge',
 equation_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},O_{F,2},\\ldots,O_{F,n}\\right)',word_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},O_{F,2},\\ldots,O_{F,n}\\right)',
 plain_description='Geordnetes Tupel funktionaler Operatoren.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.778';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.778',@section_id,'Funktionale Operatorfolge','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},O_{F,2},\\ldots,O_{F,n}\\right)','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},O_{F,2},\\ldots,O_{F,n}\\right)','Geordnetes Tupel funktionaler Operatoren.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.778');

UPDATE equations SET
 section_id=@section_id,title='Zugehörigkeit der Folgeglieder',
 equation_latex='O_{F,k}\\in\\mathcal O_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n',word_latex='O_{F,k}\\in\\mathcal O_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n',
 plain_description='Jedes Folgenglied ist ein funktionaler Operator.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.779';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.779',@section_id,'Zugehörigkeit der Folgeglieder','O_{F,k}\\in\\mathcal O_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n','O_{F,k}\\in\\mathcal O_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n','Jedes Folgenglied ist ein funktionaler Operator.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.779');

UPDATE equations SET
 section_id=@section_id,title='Gesamtoperator einer Operatorfolge',
 equation_latex='O_F^{[n]}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',word_latex='O_F^{[n]}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
 plain_description='Komposition aller Operatoren einer endlichen Folge.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.780';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.780',@section_id,'Gesamtoperator einer Operatorfolge','O_F^{[n]}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}','O_F^{[n]}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}','Komposition aller Operatoren einer endlichen Folge.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.780');

UPDATE equations SET
 section_id=@section_id,title='Endzustand einer Operatorfolge',
 equation_latex='z_F^{(n)}=O_F^{[n]}\\left(z_F^{(0)}\\right)',word_latex='z_F^{(n)}=O_F^{[n]}\\left(z_F^{(0)}\\right)',
 plain_description='Wirkung des Gesamtoperators auf den Ausgangszustand.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.781';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.781',@section_id,'Endzustand einer Operatorfolge','z_F^{(n)}=O_F^{[n]}\\left(z_F^{(0)}\\right)','z_F^{(n)}=O_F^{[n]}\\left(z_F^{(0)}\\right)','Wirkung des Gesamtoperators auf den Ausgangszustand.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.781');

UPDATE equations SET
 section_id=@section_id,title='Ausgeschachtelte Operatorwirkung',
 equation_latex='z_F^{(n)}=O_{F,n}\\left(O_{F,n-1}\\left(\\cdots O_{F,1}\\left(z_F^{(0)}\\right)\\cdots\\right)\\right)',word_latex='z_F^{(n)}=O_{F,n}\\left(O_{F,n-1}\\left(\\cdots O_{F,1}\\left(z_F^{(0)}\\right)\\cdots\\right)\\right)',
 plain_description='Ausgeschriebene Wirkung der Operatorfolge.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.782';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.782',@section_id,'Ausgeschachtelte Operatorwirkung','z_F^{(n)}=O_{F,n}\\left(O_{F,n-1}\\left(\\cdots O_{F,1}\\left(z_F^{(0)}\\right)\\cdots\\right)\\right)','z_F^{(n)}=O_{F,n}\\left(O_{F,n-1}\\left(\\cdots O_{F,1}\\left(z_F^{(0)}\\right)\\cdots\\right)\\right)','Ausgeschriebene Wirkung der Operatorfolge.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.782');

UPDATE equations SET
 section_id=@section_id,title='Operatorfolge im Lemma',
 equation_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',word_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',
 plain_description='Voraussetzung des Induktionsbeweises.',equation_type='lemma',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.783';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.783',@section_id,'Operatorfolge im Lemma','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)','Voraussetzung des Induktionsbeweises.','lemma','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.783');

UPDATE equations SET
 section_id=@section_id,title='Existenz des Gesamtoperators',
 equation_latex='O_F^{[n]}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F^{[n]}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Jede endliche Operatorfolge erzeugt einen funktionalen Gesamtoperator.',equation_type='lemma',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.784';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.784',@section_id,'Existenz des Gesamtoperators','O_F^{[n]}\\in\\mathcal O_F(\\mathcal S)','O_F^{[n]}\\in\\mathcal O_F(\\mathcal S)','Jede endliche Operatorfolge erzeugt einen funktionalen Gesamtoperator.','lemma','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.784');

UPDATE equations SET
 section_id=@section_id,title='Induktionsanfang',
 equation_latex='O_F^{[1]}=O_{F,1}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F^{[1]}=O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Basisfall des Induktionsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.785';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.785',@section_id,'Induktionsanfang','O_F^{[1]}=O_{F,1}\\in\\mathcal O_F(\\mathcal S)','O_F^{[1]}=O_{F,1}\\in\\mathcal O_F(\\mathcal S)','Basisfall des Induktionsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.785');

UPDATE equations SET
 section_id=@section_id,title='Induktionsannahme',
 equation_latex='O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Induktionsannahme für Folgen der Länge n.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.786';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.786',@section_id,'Induktionsannahme','O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)','O_F^{[n]}=O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)','Induktionsannahme für Folgen der Länge n.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.786');

UPDATE equations SET
 section_id=@section_id,title='Induktionsschritt',
 equation_latex='O_F^{[n+1]}=O_{F,n+1}\\circ O_F^{[n]}',word_latex='O_F^{[n+1]}=O_{F,n+1}\\circ O_F^{[n]}',
 plain_description='Rekursive Bildung des Gesamtoperators.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.787';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.787',@section_id,'Induktionsschritt','O_F^{[n+1]}=O_{F,n+1}\\circ O_F^{[n]}','O_F^{[n+1]}=O_{F,n+1}\\circ O_F^{[n]}','Rekursive Bildung des Gesamtoperators.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.787');

UPDATE equations SET
 section_id=@section_id,title='Abschluss des Induktionsschritts',
 equation_latex='O_F^{[n+1]}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F^{[n+1]}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Die verlängerte Folge erzeugt erneut einen funktionalen Operator.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.788';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.788',@section_id,'Abschluss des Induktionsschritts','O_F^{[n+1]}\\in\\mathcal O_F(\\mathcal S)','O_F^{[n+1]}\\in\\mathcal O_F(\\mathcal S)','Die verlängerte Folge erzeugt erneut einen funktionalen Operator.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.788');

UPDATE equations SET
 section_id=@section_id,title='Funktionaler Ausgangszustand',
 equation_latex='z_F^{(0)}\\in\\Omega_F(\\mathcal S)',word_latex='z_F^{(0)}\\in\\Omega_F(\\mathcal S)',
 plain_description='Ausgangszustand einer Zustandsfolge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.789';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.789',@section_id,'Funktionaler Ausgangszustand','z_F^{(0)}\\in\\Omega_F(\\mathcal S)','z_F^{(0)}\\in\\Omega_F(\\mathcal S)','Ausgangszustand einer Zustandsfolge.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.789');

UPDATE equations SET
 section_id=@section_id,title='Operatorfolge einer Zustandsfolge',
 equation_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',word_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',
 plain_description='Operatorfolge zur Erzeugung einer Zustandsfolge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.790';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.790',@section_id,'Operatorfolge einer Zustandsfolge','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)','Operatorfolge zur Erzeugung einer Zustandsfolge.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.790');

UPDATE equations SET
 section_id=@section_id,title='Funktionale Zustandsfolge',
 equation_latex='\\boldsymbol z_F^{(n)}=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',word_latex='\\boldsymbol z_F^{(n)}=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
 plain_description='Geordnete Folge funktionaler Zustände.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.791';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.791',@section_id,'Funktionale Zustandsfolge','\\boldsymbol z_F^{(n)}=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)','\\boldsymbol z_F^{(n)}=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)','Geordnete Folge funktionaler Zustände.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.791');

UPDATE equations SET
 section_id=@section_id,title='Rekursion der Zustandsfolge',
 equation_latex='z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n',word_latex='z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n',
 plain_description='Rekursive Erzeugung der Folgezustände.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.792';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.792',@section_id,'Rekursion der Zustandsfolge','z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n','z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n','Rekursive Erzeugung der Folgezustände.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.792');

UPDATE equations SET
 section_id=@section_id,title='Einzelübergang einer Zustandsfolge',
 equation_latex='\\tau_{F,k}=\\left(z_F^{(k-1)},O_{F,k},z_F^{(k)}\\right)',word_latex='\\tau_{F,k}=\\left(z_F^{(k-1)},O_{F,k},z_F^{(k)}\\right)',
 plain_description='Zuordnung eines Operators zu einem Zustandsübergang.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.793';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.793',@section_id,'Einzelübergang einer Zustandsfolge','\\tau_{F,k}=\\left(z_F^{(k-1)},O_{F,k},z_F^{(k)}\\right)','\\tau_{F,k}=\\left(z_F^{(k-1)},O_{F,k},z_F^{(k)}\\right)','Zuordnung eines Operators zu einem Zustandsübergang.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.793');

UPDATE equations SET
 section_id=@section_id,title='Zugehörigkeit der Einzelübergänge',
 equation_latex='\\tau_{F,k}\\in\\mathcal T_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n',word_latex='\\tau_{F,k}\\in\\mathcal T_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n',
 plain_description='Jeder Schritt der Zustandsfolge ist ein funktionaler Übergang.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.794';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.794',@section_id,'Zugehörigkeit der Einzelübergänge','\\tau_{F,k}\\in\\mathcal T_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n','\\tau_{F,k}\\in\\mathcal T_F(\\mathcal S)\\qquad\\text{für }k=1,\\ldots,n','Jeder Schritt der Zustandsfolge ist ein funktionaler Übergang.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.794');

UPDATE equations SET
 section_id=@section_id,title='Ausgangszustand des Entwicklungspfads',
 equation_latex='z_F^{(0)}\\in\\Omega_F(\\mathcal S)',word_latex='z_F^{(0)}\\in\\Omega_F(\\mathcal S)',
 plain_description='Voraussetzung des Bestimmtheitssatzes.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.795';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.795',@section_id,'Ausgangszustand des Entwicklungspfads','z_F^{(0)}\\in\\Omega_F(\\mathcal S)','z_F^{(0)}\\in\\Omega_F(\\mathcal S)','Voraussetzung des Bestimmtheitssatzes.','theorem','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.795');

UPDATE equations SET
 section_id=@section_id,title='Vollständige Operatorfolge',
 equation_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',word_latex='\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',
 plain_description='Vollständige Operatorfolge des Bestimmtheitssatzes.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.796';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.796',@section_id,'Vollständige Operatorfolge','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)','\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)','Vollständige Operatorfolge des Bestimmtheitssatzes.','theorem','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.796');

UPDATE equations SET
 section_id=@section_id,title='Erster eindeutig bestimmter Zustand',
 equation_latex='z_F^{(1)}=O_{F,1}\\left(z_F^{(0)}\\right)',word_latex='z_F^{(1)}=O_{F,1}\\left(z_F^{(0)}\\right)',
 plain_description='Erster Schritt des Eindeutigkeitsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.797';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.797',@section_id,'Erster eindeutig bestimmter Zustand','z_F^{(1)}=O_{F,1}\\left(z_F^{(0)}\\right)','z_F^{(1)}=O_{F,1}\\left(z_F^{(0)}\\right)','Erster Schritt des Eindeutigkeitsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.797');

UPDATE equations SET
 section_id=@section_id,title='Rekursiv eindeutig bestimmter Zustand',
 equation_latex='z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)',word_latex='z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)',
 plain_description='Rekursiver Schritt des Eindeutigkeitsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.798';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.798',@section_id,'Rekursiv eindeutig bestimmter Zustand','z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)','z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)','Rekursiver Schritt des Eindeutigkeitsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.798');

UPDATE equations SET
 section_id=@section_id,title='Nichtbestimmtheit ohne Operatorfolge',
 equation_latex='O_{F,1}\\left(z_F^{(0)}\\right)\\neq O_{F,2}\\left(z_F^{(0)}\\right)',word_latex='O_{F,1}\\left(z_F^{(0)}\\right)\\neq O_{F,2}\\left(z_F^{(0)}\\right)',
 plain_description='Verschiedene Operatoren können aus demselben Ausgangszustand verschiedene Folgezustände erzeugen.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.799';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.799',@section_id,'Nichtbestimmtheit ohne Operatorfolge','O_{F,1}\\left(z_F^{(0)}\\right)\\neq O_{F,2}\\left(z_F^{(0)}\\right)','O_{F,1}\\left(z_F^{(0)}\\right)\\neq O_{F,2}\\left(z_F^{(0)}\\right)','Verschiedene Operatoren können aus demselben Ausgangszustand verschiedene Folgezustände erzeugen.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.799');

UPDATE equations SET
 section_id=@section_id,title='Funktionaler Entwicklungspfad',
 equation_latex='\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},O_{F,2},\\ldots,O_{F,n},z_F^{(n)}\\right)',word_latex='\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},O_{F,2},\\ldots,O_{F,n},z_F^{(n)}\\right)',
 plain_description='Geordnete Struktur aus Zuständen und Operatoren.',equation_type='definition',
 provenance='adapted',source_id=@source_diestel,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.800';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.800',@section_id,'Funktionaler Entwicklungspfad','\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},O_{F,2},\\ldots,O_{F,n},z_F^{(n)}\\right)','\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},O_{F,2},\\ldots,O_{F,n},z_F^{(n)}\\right)','Geordnete Struktur aus Zuständen und Operatoren.','definition','adapted',@source_diestel,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.800');

UPDATE equations SET
 section_id=@section_id,title='Pfadbedingung',
 equation_latex='z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n',word_latex='z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n',
 plain_description='Jeder Pfadschritt erfüllt die Übergangsbedingung.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.801';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.801',@section_id,'Pfadbedingung','z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n','z_F^{(k)}=O_{F,k}\\left(z_F^{(k-1)}\\right)\\qquad\\text{für }k=1,\\ldots,n','Jeder Pfadschritt erfüllt die Übergangsbedingung.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.801');

UPDATE equations SET
 section_id=@section_id,title='Pfeilnotation des Entwicklungspfads',
 equation_latex='z_F^{(0)}\\xrightarrow{\\,O_{F,1}\\,}z_F^{(1)}\\xrightarrow{\\,O_{F,2}\\,}\\cdots\\xrightarrow{\\,O_{F,n}\\,}z_F^{(n)}',word_latex='z_F^{(0)}\\xrightarrow{\\,O_{F,1}\\,}z_F^{(1)}\\xrightarrow{\\,O_{F,2}\\,}\\cdots\\xrightarrow{\\,O_{F,n}\\,}z_F^{(n)}',
 plain_description='Verkürzte Darstellung eines funktionalen Entwicklungspfads.',equation_type='schema',
 provenance='adapted',source_id=@source_diestel,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.802';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.802',@section_id,'Pfeilnotation des Entwicklungspfads','z_F^{(0)}\\xrightarrow{\\,O_{F,1}\\,}z_F^{(1)}\\xrightarrow{\\,O_{F,2}\\,}\\cdots\\xrightarrow{\\,O_{F,n}\\,}z_F^{(n)}','z_F^{(0)}\\xrightarrow{\\,O_{F,1}\\,}z_F^{(1)}\\xrightarrow{\\,O_{F,2}\\,}\\cdots\\xrightarrow{\\,O_{F,n}\\,}z_F^{(n)}','Verkürzte Darstellung eines funktionalen Entwicklungspfads.','schema','adapted',@source_diestel,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.802');

UPDATE equations SET
 section_id=@section_id,title='Alternative Pfade mit gleichem Endzustand',
 equation_latex='z_F^{(0)}\\xrightarrow{\\;\\boldsymbol O_F\\;}z_F^{(n)}\\qquad\\text{und}\\qquad z_F^{(0)}\\xrightarrow{\\;\\widetilde{\\boldsymbol O}_F\\;}z_F^{(n)}',word_latex='z_F^{(0)}\\xrightarrow{\\;\\boldsymbol O_F\\;}z_F^{(n)}\\qquad\\text{und}\\qquad z_F^{(0)}\\xrightarrow{\\;\\widetilde{\\boldsymbol O}_F\\;}z_F^{(n)}',
 plain_description='Zwei verschiedene Pfade können denselben Anfangs- und Endzustand besitzen.',equation_type='schema',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.803';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.803',@section_id,'Alternative Pfade mit gleichem Endzustand','z_F^{(0)}\\xrightarrow{\\;\\boldsymbol O_F\\;}z_F^{(n)}\\qquad\\text{und}\\qquad z_F^{(0)}\\xrightarrow{\\;\\widetilde{\\boldsymbol O}_F\\;}z_F^{(n)}','z_F^{(0)}\\xrightarrow{\\;\\boldsymbol O_F\\;}z_F^{(n)}\\qquad\\text{und}\\qquad z_F^{(0)}\\xrightarrow{\\;\\widetilde{\\boldsymbol O}_F\\;}z_F^{(n)}','Zwei verschiedene Pfade können denselben Anfangs- und Endzustand besitzen.','schema','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.803');

UPDATE equations SET
 section_id=@section_id,title='Verschiedene Operatorfolgen',
 equation_latex='\\boldsymbol O_F\\neq\\widetilde{\\boldsymbol O}_F',word_latex='\\boldsymbol O_F\\neq\\widetilde{\\boldsymbol O}_F',
 plain_description='Die Operatorfolgen zweier wirkungsgleicher Pfade können verschieden sein.',equation_type='other',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.804';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.804',@section_id,'Verschiedene Operatorfolgen','\\boldsymbol O_F\\neq\\widetilde{\\boldsymbol O}_F','\\boldsymbol O_F\\neq\\widetilde{\\boldsymbol O}_F','Die Operatorfolgen zweier wirkungsgleicher Pfade können verschieden sein.','other','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.804');

UPDATE equations SET
 section_id=@section_id,title='Funktionale Übergangsordnung',
 equation_latex='z_F^{(i)}\\preceq_F z_F^{(j)}',word_latex='z_F^{(i)}\\preceq_F z_F^{(j)}',
 plain_description='Nichtstrikte funktionale Übergangsordnung.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.805';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.805',@section_id,'Funktionale Übergangsordnung','z_F^{(i)}\\preceq_F z_F^{(j)}','z_F^{(i)}\\preceq_F z_F^{(j)}','Nichtstrikte funktionale Übergangsordnung.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.805');

UPDATE equations SET
 section_id=@section_id,title='Indexbedingung der Übergangsordnung',
 equation_latex='i\\leq j',word_latex='i\\leq j',
 plain_description='Definition der nichtstrikten Übergangsordnung über Pfadindizes.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.806';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.806',@section_id,'Indexbedingung der Übergangsordnung','i\\leq j','i\\leq j','Definition der nichtstrikten Übergangsordnung über Pfadindizes.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.806');

UPDATE equations SET
 section_id=@section_id,title='Strikte funktionale Übergangsordnung',
 equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
 plain_description='Strikte funktionale Übergangsordnung.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.807';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.807',@section_id,'Strikte funktionale Übergangsordnung','z_F^{(i)}\\prec_F z_F^{(j)}','z_F^{(i)}\\prec_F z_F^{(j)}','Strikte funktionale Übergangsordnung.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.807');

UPDATE equations SET
 section_id=@section_id,title='Indexbedingung der strikten Ordnung',
 equation_latex='i<j',word_latex='i<j',
 plain_description='Definition der strikten Übergangsordnung über Pfadindizes.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.808';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.808',@section_id,'Indexbedingung der strikten Ordnung','i<j','i<j','Definition der strikten Übergangsordnung über Pfadindizes.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.808');

UPDATE equations SET
 section_id=@section_id,title='Ein einzelner Übergangsschritt',
 equation_latex='j-i=1',word_latex='j-i=1',
 plain_description='Zwischen zwei Pfadpositionen liegt genau ein Übergang.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.809';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.809',@section_id,'Ein einzelner Übergangsschritt','j-i=1','j-i=1','Zwischen zwei Pfadpositionen liegt genau ein Übergang.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.809');

UPDATE equations SET
 section_id=@section_id,title='Transitivität der Übergangsordnung',
 equation_latex='z_F^{(i)}\\preceq_F z_F^{(j)}\\land z_F^{(j)}\\preceq_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\preceq_F z_F^{(k)}',word_latex='z_F^{(i)}\\preceq_F z_F^{(j)}\\land z_F^{(j)}\\preceq_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\preceq_F z_F^{(k)}',
 plain_description='Transitivität der funktionalen Übergangsordnung.',equation_type='lemma',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.810';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.810',@section_id,'Transitivität der Übergangsordnung','z_F^{(i)}\\preceq_F z_F^{(j)}\\land z_F^{(j)}\\preceq_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\preceq_F z_F^{(k)}','z_F^{(i)}\\preceq_F z_F^{(j)}\\land z_F^{(j)}\\preceq_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\preceq_F z_F^{(k)}','Transitivität der funktionalen Übergangsordnung.','lemma','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.810');

UPDATE equations SET
 section_id=@section_id,title='Erste Indexrelation',
 equation_latex='i\\leq j',word_latex='i\\leq j',
 plain_description='Erste Voraussetzung des Transitivitätsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.811';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.811',@section_id,'Erste Indexrelation','i\\leq j','i\\leq j','Erste Voraussetzung des Transitivitätsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.811');

UPDATE equations SET
 section_id=@section_id,title='Zweite Indexrelation',
 equation_latex='j\\leq k',word_latex='j\\leq k',
 plain_description='Zweite Voraussetzung des Transitivitätsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.812';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.812',@section_id,'Zweite Indexrelation','j\\leq k','j\\leq k','Zweite Voraussetzung des Transitivitätsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.812');

UPDATE equations SET
 section_id=@section_id,title='Transitive Indexrelation',
 equation_latex='i\\leq k',word_latex='i\\leq k',
 plain_description='Folgerung aus der natürlichen Ordnung.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.813';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.813',@section_id,'Transitive Indexrelation','i\\leq k','i\\leq k','Folgerung aus der natürlichen Ordnung.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.813');

UPDATE equations SET
 section_id=@section_id,title='Transitive Zustandsordnung',
 equation_latex='z_F^{(i)}\\preceq_F z_F^{(k)}',word_latex='z_F^{(i)}\\preceq_F z_F^{(k)}',
 plain_description='Ergebnis des Transitivitätsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.814';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.814',@section_id,'Transitive Zustandsordnung','z_F^{(i)}\\preceq_F z_F^{(k)}','z_F^{(i)}\\preceq_F z_F^{(k)}','Ergebnis des Transitivitätsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.814');

UPDATE equations SET
 section_id=@section_id,title='Irreflexivität der strikten Ordnung',
 equation_latex='\\neg\\left(z_F^{(i)}\\prec_F z_F^{(i)}\\right)',word_latex='\\neg\\left(z_F^{(i)}\\prec_F z_F^{(i)}\\right)',
 plain_description='Ein Zustand steht nicht strikt vor sich selbst.',equation_type='theorem',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.815';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.815',@section_id,'Irreflexivität der strikten Ordnung','\\neg\\left(z_F^{(i)}\\prec_F z_F^{(i)}\\right)','\\neg\\left(z_F^{(i)}\\prec_F z_F^{(i)}\\right)','Ein Zustand steht nicht strikt vor sich selbst.','theorem','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.815');

UPDATE equations SET
 section_id=@section_id,title='Transitivität der strikten Ordnung',
 equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}',word_latex='z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}',
 plain_description='Transitivität der strikten Pfadordnung.',equation_type='theorem',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.816';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.816',@section_id,'Transitivität der strikten Ordnung','z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}','z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}','Transitivität der strikten Pfadordnung.','theorem','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.816');

UPDATE equations SET
 section_id=@section_id,title='Vergleichbarkeit verschiedener Pfadpositionen',
 equation_latex='i\\neq j\\Longrightarrow\\left(z_F^{(i)}\\prec_F z_F^{(j)}\\right)\\lor\\left(z_F^{(j)}\\prec_F z_F^{(i)}\\right)',word_latex='i\\neq j\\Longrightarrow\\left(z_F^{(i)}\\prec_F z_F^{(j)}\\right)\\lor\\left(z_F^{(j)}\\prec_F z_F^{(i)}\\right)',
 plain_description='Vergleichbarkeit verschiedener Positionen entlang eines Pfades.',equation_type='theorem',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.817';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.817',@section_id,'Vergleichbarkeit verschiedener Pfadpositionen','i\\neq j\\Longrightarrow\\left(z_F^{(i)}\\prec_F z_F^{(j)}\\right)\\lor\\left(z_F^{(j)}\\prec_F z_F^{(i)}\\right)','i\\neq j\\Longrightarrow\\left(z_F^{(i)}\\prec_F z_F^{(j)}\\right)\\lor\\left(z_F^{(j)}\\prec_F z_F^{(i)}\\right)','Vergleichbarkeit verschiedener Positionen entlang eines Pfades.','theorem','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.817');

UPDATE equations SET
 section_id=@section_id,title='Unmögliche Selbstordnung',
 equation_latex='i<i',word_latex='i<i',
 plain_description='Unmögliche Indexrelation als Begründung der Irreflexivität.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.818';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.818',@section_id,'Unmögliche Selbstordnung','i<i','i<i','Unmögliche Indexrelation als Begründung der Irreflexivität.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.818');

UPDATE equations SET
 section_id=@section_id,title='Transitivität der natürlichen Ordnung',
 equation_latex='i<j\\land j<k\\Longrightarrow i<k',word_latex='i<j\\land j<k\\Longrightarrow i<k',
 plain_description='Ordnungsgrundlage der strikten Übergangsordnung.',equation_type='derived',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.819';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.819',@section_id,'Transitivität der natürlichen Ordnung','i<j\\land j<k\\Longrightarrow i<k','i<j\\land j<k\\Longrightarrow i<k','Ordnungsgrundlage der strikten Übergangsordnung.','derived','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.819');

UPDATE equations SET
 section_id=@section_id,title='Erster Vergleichsfall',
 equation_latex='i<j',word_latex='i<j',
 plain_description='Erster möglicher Vergleich zweier verschiedener Indizes.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.820';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.820',@section_id,'Erster Vergleichsfall','i<j','i<j','Erster möglicher Vergleich zweier verschiedener Indizes.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.820');

UPDATE equations SET
 section_id=@section_id,title='Zweiter Vergleichsfall',
 equation_latex='j<i',word_latex='j<i',
 plain_description='Zweiter möglicher Vergleich zweier verschiedener Indizes.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.821';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.821',@section_id,'Zweiter Vergleichsfall','j<i','j<i','Zweiter möglicher Vergleich zweier verschiedener Indizes.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.821');

UPDATE equations SET
 section_id=@section_id,title='Ordnung ohne Zeitmaß',
 equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
 plain_description='Die Pfadordnung gibt eine Reihenfolge, aber keine Dauer an.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
 assumptions='Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.822';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.822',@section_id,'Ordnung ohne Zeitmaß','z_F^{(i)}\\prec_F z_F^{(j)}','z_F^{(i)}\\prec_F z_F^{(j)}','Die Pfadordnung gibt eine Reihenfolge, aber keine Dauer an.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.6.',
'Die Definitionen und Sätze der Abschnitte 3.4.4 und 3.4.5 werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.822');


/* Definitionen */
DELETE FROM definitions WHERE definition_number IN ('3.4.15','Def. 3.4.15','3.4.16','Def. 3.4.16','3.4.17','Def. 3.4.17','3.4.18','Def. 3.4.18','3.4.19','Def. 3.4.19','3.4.20','Def. 3.4.20');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('3.4.15',@section_id,'Funktionaler Übergang',
'Ein funktionaler Übergang ist das geordnete Tripel aus Ausgangszustand, funktionalem Operator und dem durch dessen Wirkung erzeugten Folgezustand.',
'\\tau_F=\\left(z_F,O_F,z_F\\prime\\right),\\quad z_F\\prime=O_F(z_F)',
'\\tau_F=\\left(z_F,O_F,z_F\\prime\\right),\\quad z_F\\prime=O_F(z_F)',
'original',NULL,'Definition 3.4.11 und funktionaler Zustandsraum.','Der Pfeil bezeichnet eine gerichtete Zuordnung, noch keine physikalische Zeit.','checked',@revision_id),
('3.4.16',@section_id,'Funktionale Übergangsmenge',
'Die funktionale Übergangsmenge enthält sämtliche zulässigen konkreten Anwendungen funktionaler Operatoren auf funktionale Zustände.',
'\\mathcal T_F(\\mathcal S)=\\left\\{(z_F,O_F,z_F\\prime)\\middle|z_F\\prime=O_F(z_F)\\right\\}',
'\\mathcal T_F(\\mathcal S)=\\left\\{(z_F,O_F,z_F\\prime)\\middle|z_F\\prime=O_F(z_F)\\right\\}',
'original',NULL,'Definition 3.4.15.','Abgrenzung zwischen allgemeiner Operatorregel und konkreter Operatoranwendung.','checked',@revision_id),
('3.4.17',@section_id,'Funktionale Operatorfolge',
'Eine funktionale Operatorfolge ist ein endliches geordnetes Tupel funktionaler Operatoren derselben Organisation.',
'\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',
'\\boldsymbol O_F^{(n)}=\\left(O_{F,1},\\ldots,O_{F,n}\\right)',
'adapted',@source_dummit,'Funktionale Operatormenge und Komposition.','Die Reihenfolge ist wegen möglicher Nichtkommutativität wesentlich.','checked',@revision_id),
('3.4.18',@section_id,'Funktionale Zustandsfolge',
'Die funktionale Zustandsfolge ist die durch eine Operatorfolge aus einem gegebenen Ausgangszustand rekursiv erzeugte geordnete Folge funktionaler Zustände.',
'\\boldsymbol z_F^{(n)}=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
'\\boldsymbol z_F^{(n)}=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
'adapted',@source_hirsch,'Ausgangszustand und vollständige Operatorfolge.','Übertragung der Trajektorienidee auf funktionale Organisationszustände.','checked',@revision_id),
('3.4.19',@section_id,'Funktionaler Entwicklungspfad',
'Ein funktionaler Entwicklungspfad ist die geordnete alternierende Folge von funktionalen Zuständen und den jeweils zwischen ihnen wirkenden Operatoren.',
'\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
'\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
'adapted',@source_diestel,'Definitionen 3.4.15 bis 3.4.18.','Graphentheoretischer Pfadbegriff mit operatorbeschrifteten Übergängen.','checked',@revision_id),
('3.4.20',@section_id,'Funktionale Übergangsordnung',
'Die funktionale Übergangsordnung ordnet Zustände desselben Entwicklungspfads anhand ihrer Position in der durch Operatoranwendungen erzeugten Zustandsfolge.',
'z_F^{(i)}\\preceq_F z_F^{(j)}\\Longleftrightarrow i\\leq j',
'z_F^{(i)}\\preceq_F z_F^{(j)}\\Longleftrightarrow i\\leq j',
'adapted',@source_dummit,'Ein festgelegter funktionaler Entwicklungspfad.','Die Ordnung ist noch keine metrische oder physikalische Zeitstruktur.','checked',@revision_id);

/* Lemmata */
DELETE FROM lemmas WHERE lemma_number IN ('Lemma 3.4.6','Lemma 3.4.7');
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.6',@section_id,'Jede endliche Operatorfolge erzeugt eine funktionale Transformation',
'Für jede endliche funktionale Operatorfolge existiert ein Gesamtoperator in der funktionalen Operatormenge, der die Wirkung der gesamten Folge beschreibt.',
'O_F^{[n]}\\in\\mathcal O_F(\\mathcal S)',
'O_F^{[n]}\\in\\mathcal O_F(\\mathcal S)',
'original',NULL,'Abgeschlossenheit und Assoziativität der Operatorkomposition.','checked',@revision_id),
('Lemma 3.4.7',@section_id,'Transitivität der funktionalen Übergangsordnung',
'Die funktionale Übergangsordnung ist entlang eines festgelegten Entwicklungspfads transitiv.',
'z_F^{(i)}\\preceq_F z_F^{(j)}\\land z_F^{(j)}\\preceq_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\preceq_F z_F^{(k)}',
'z_F^{(i)}\\preceq_F z_F^{(j)}\\land z_F^{(j)}\\preceq_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\preceq_F z_F^{(k)}',
'adapted',@source_dummit,'Definition 3.4.20.','checked',@revision_id);

/* Sätze */
DELETE FROM theorems WHERE theorem_number IN ('Satz 3.4.7','Satz 3.4.8');
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.7',@section_id,'Bestimmtheit eines funktionalen Entwicklungspfads',
'Sind ein funktionaler Ausgangszustand und eine vollständige endliche Operatorfolge gegeben, so ist die zugehörige funktionale Zustandsfolge eindeutig bestimmt.',
'z_F^{(0)},\\boldsymbol O_F^{(n)}\\Longrightarrow!\\boldsymbol z_F^{(n)}',
'z_F^{(0)},\\boldsymbol O_F^{(n)}\\Longrightarrow!\\boldsymbol z_F^{(n)}',
'original',NULL,'Jeder funktionale Operator ist eine eindeutige Abbildung.','checked',@revision_id),
('Satz 3.4.8',@section_id,'Strikte Ordnung funktionaler Zustände entlang eines Entwicklungspfads',
'Für einen funktionalen Entwicklungspfad mit paarweise verschiedenen Zuständen bildet die strikte funktionale Übergangsrelation eine strikte lineare Ordnung.',
'\\left(\\{z_F^{(0)},\\ldots,z_F^{(n)}\\},\\prec_F\\right)',
'\\left(\\{z_F^{(0)},\\ldots,z_F^{(n)}\\},\\prec_F\\right)',
'adapted',@source_dummit,'Paarweise verschiedene Zustände und Definition 3.4.20.','checked',@revision_id);

SELECT lemma_id INTO @lemma_346 FROM lemmas WHERE lemma_number='Lemma 3.4.6' LIMIT 1;
SELECT lemma_id INTO @lemma_347 FROM lemmas WHERE lemma_number='Lemma 3.4.7' LIMIT 1;
SELECT theorem_id INTO @satz_347 FROM theorems WHERE theorem_number='Satz 3.4.7' LIMIT 1;
SELECT theorem_id INTO @satz_348 FROM theorems WHERE theorem_number='Satz 3.4.8' LIMIT 1;

/* Korollare */
DELETE FROM corollaries WHERE corollary_number IN ('Korollar 3.4.7','Korollar 3.4.8');
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.7',@section_id,'Nichtbestimmtheit ohne vollständige Operatorfolge',
'Aus einem Ausgangszustand allein folgt im Allgemeinen keine eindeutige funktionale Entwicklung.',
'O_{F,1}(z_F^{(0)})\\neq O_{F,2}(z_F^{(0)})',
'O_{F,1}(z_F^{(0)})\\neq O_{F,2}(z_F^{(0)})',
@satz_347,NULL,'original',NULL,'checked',@revision_id),
('Korollar 3.4.8',@section_id,'Übergangsordnung erzeugt noch keine vollständige Zeitstruktur',
'Die funktionale Übergangsordnung bestimmt eine Reihenfolge von Zuständen, aber weder Dauer noch Geschwindigkeit oder gleichmäßige Abstände.',
'z_F^{(i)}\\prec_F z_F^{(j)}',
'z_F^{(i)}\\prec_F z_F^{(j)}',
@satz_348,NULL,'original',NULL,'checked',@revision_id);

SELECT corollary_id INTO @kor_347 FROM corollaries WHERE corollary_number='Korollar 3.4.7' LIMIT 1;
SELECT corollary_id INTO @kor_348 FROM corollaries WHERE corollary_number='Korollar 3.4.8' LIMIT 1;

/* Beweise */
DELETE FROM proofs WHERE proof_number IN ('Bew. 3.4.6-R1','Bew. 3.4.6-R2','Bew. 3.4.6-R3','Bew. 3.4.6-R4','Bew. 3.4.6-R5','Bew. 3.4.6-R6');
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.6-R1',@section_id,NULL,@lemma_346,NULL,'Beweis zu Lemma 3.4.6',
'Der Basisfall n=1 ist unmittelbar erfüllt. Unter der Induktionsannahme gehört der Gesamtoperator einer Folge der Länge n zur Operatormenge. Seine Komposition mit dem nächsten funktionalen Operator gehört wegen der Abgeschlossenheit erneut zur Operatormenge.','O_F^{[n+1]}=O_{F,n+1}\\circ O_F^{[n]}','induction','original',NULL,'checked',@revision_id),
('Bew. 3.4.6-R2',@section_id,@satz_347,NULL,NULL,'Beweis zu Satz 3.4.7',
'Jeder funktionale Operator ordnet jedem gegebenen Zustand genau einen Folgezustand zu. Durch rekursive Anwendung der vollständig angegebenen Operatorfolge ist daher jedes Folgenglied und damit die gesamte Zustandsfolge eindeutig bestimmt.',NULL,'induction','original',NULL,'checked',@revision_id),
('Bew. 3.4.6-R3',@section_id,NULL,NULL,@kor_347,'Begründung zu Korollar 3.4.7',
'Sind auf denselben Ausgangszustand mehrere funktionale Operatoren anwendbar und erzeugen diese verschiedene Bilder, ist ohne Auswahl der Operatorfolge keine eindeutige Entwicklung bestimmt.',NULL,'construction','original',NULL,'checked',@revision_id),
('Bew. 3.4.6-R4',@section_id,NULL,@lemma_347,NULL,'Beweis zu Lemma 3.4.7',
'Aus i kleiner oder gleich j und j kleiner oder gleich k folgt aufgrund der Transitivität der natürlichen Ordnung i kleiner oder gleich k. Nach Definition der funktionalen Übergangsordnung folgt die Behauptung.',NULL,'direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.6-R5',@section_id,@satz_348,NULL,NULL,'Beweis zu Satz 3.4.8',
'Irreflexivität, Transitivität und Vergleichbarkeit folgen unmittelbar aus der strikten linearen Ordnung der Pfadindizes. Die vorausgesetzte paarweise Verschiedenheit der Zustände überträgt diese Ordnung eindeutig auf die Zustände selbst.',NULL,'direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.6-R6',@section_id,NULL,NULL,@kor_348,'Begründung zu Korollar 3.4.8',
'Die Relation präzisiert ausschließlich die Reihenfolge der Pfadpositionen. Da keine Maßfunktion für Übergangsdauern definiert ist, folgt daraus keine vollständige physikalische Zeitstruktur.',NULL,'direct','original',NULL,'checked',@revision_id);

/* Quellenverwendungen */
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_dummit,@section_id,'background','Algebraische Grundlagen von Folgen, Kompositionen und Ordnungsrelationen.','3.4.6.3 und 3.4.6.6',0,1,'Bestandsquelle [31].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_dummit AND section_id=@section_id AND exact_location='3.4.6.3 und 3.4.6.6');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_hirsch,@section_id,'background','Dynamische Systeme, wiederholte Abbildungsanwendung und Trajektorien als mathematischer Hintergrund.','3.4.6.1 und 3.4.6.4',0,1,'Bestandsquelle [40].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_hirsch AND section_id=@section_id AND exact_location='3.4.6.1 und 3.4.6.4');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_diestel,@section_id,'comparison','Graphentheoretischer Weg- und Pfadbegriff als Vergleichsgrundlage.','3.4.6.1 und 3.4.6.5',0,1,'Bestandsquelle [47].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_diestel AND section_id=@section_id AND exact_location='3.4.6.1 und 3.4.6.5');

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'rewritten','section','3.4.6','Abschnitt 3.4.6 vollständig literaturgestützt neu gefasst.','Frühere Fassung','Revision mit Übergängen, Operatorfolgen, Zustandsfolgen, Entwicklungspfaden und Übergangsordnung'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.4.6');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'equation_changed','equations','3.771–3.822','52 Gleichungen aktualisiert beziehungsweise ergänzt.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.771–3.822');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'definition_added','definitions','3.4.15–3.4.20','Sechs Definitionen registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.4.15–3.4.20');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'statement_added','statements','Lemma/Satz/Korollar 3.4.6','Lemmata, Sätze und Korollare registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='Lemma/Satz/Korollar 3.4.6');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'proof_added','proofs','Bew. 3.4.6-R1–R6','Sechs Beweis- und Begründungsdatensätze registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='Bew. 3.4.6-R1–R6');

/* Repository-Zähler */
INSERT INTO repository_counters(counter_key,counter_value) VALUES ('last_completed_section','3.4.6')
ON DUPLICATE KEY UPDATE counter_value='3.4.6';
INSERT INTO repository_counters(counter_key,counter_value) VALUES ('last_repository_revision','RKB-REV-K3.4.6-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-REV-K3.4.6-V1';
INSERT INTO repository_counters(counter_key,counter_value) VALUES ('next_equation_number','3.823')
ON DUPLICATE KEY UPDATE counter_value='3.823';

COMMIT;

/* Audit */
SELECT revision_id,revision_code,scope_reference,version_label FROM repository_revisions WHERE revision_code=@revision_code;
SELECT COUNT(*) AS equations_3_771_to_3_822 FROM equations
WHERE section_id=@section_id AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 771 AND 822;
SELECT equation_number,title,validation_status FROM equations
WHERE section_id=@section_id AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 771 AND 822
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
SELECT definition_number,title,validation_status FROM definitions WHERE section_id=@section_id ORDER BY definition_number;
SELECT lemma_number,title,validation_status FROM lemmas WHERE section_id=@section_id AND lemma_number IN ('Lemma 3.4.6','Lemma 3.4.7');
SELECT theorem_number,title,validation_status FROM theorems WHERE section_id=@section_id AND theorem_number IN ('Satz 3.4.7','Satz 3.4.8');
SELECT corollary_number,title,validation_status FROM corollaries WHERE section_id=@section_id AND corollary_number IN ('Korollar 3.4.7','Korollar 3.4.8');
SELECT proof_number,title,validation_status FROM proofs WHERE section_id=@section_id AND proof_number LIKE 'Bew. 3.4.6-R%';
SELECT s.citation_number,s.title,su.exact_location,su.citation_checked
FROM source_usage su JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id AND s.citation_number IN (31,40,47)
ORDER BY s.citation_number;
