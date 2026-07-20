/* =====================================================================
   FRZK-RKB – Revision Abschnitt 3.4.5, Teil 2 / Abschluss
   Gleichungen (3.734)–(3.770)
   Definitionen 3.4.12–3.4.14
   Lemma 3.4.4–3.4.5
   Satz 3.4.5–3.4.6
   Korollar 3.4.5–3.4.6
   Beweise und Quellenverwendungen
   Schema: geprüft gegen frzk_rkb(3).sql
   ===================================================================== */

ROLLBACK;
START TRANSACTION;

SET @revision_code := 'RKB-REV-K3.4.5-P2-V1';

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4.5'
LIMIT 1;

SELECT source_id INTO @source_rudin
FROM sources WHERE citation_number=11 LIMIT 1;

SELECT source_id INTO @source_dummit
FROM sources WHERE citation_number=31 LIMIT 1;

SELECT source_id INTO @source_conway
FROM sources WHERE citation_number=35 LIMIT 1;

SELECT revision_id INTO @parent_revision_id
FROM repository_revisions
ORDER BY revision_id DESC LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT @revision_code,NOW(),'section','3.4.5','2.0-complete',
'Abschluss der literaturgestützten Revision von 3.4.5: Operatormenge, Komposition, Assoziativität, Identität, Invertierbarkeit, Monoid- und Gruppenstruktur.',
'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SELECT revision_id INTO @revision_id
FROM repository_revisions WHERE revision_code=@revision_code LIMIT 1;

DROP PROCEDURE IF EXISTS frzk_assert_345_p2;
DELIMITER $$
CREATE PROCEDURE frzk_assert_345_p2()
BEGIN
 IF @section_id IS NULL THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Abschnitt 3.4.5 fehlt.';
 END IF;
 IF @source_rudin IS NULL OR @source_dummit IS NULL OR @source_conway IS NULL THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Bestandsquelle [11], [31] oder [35] fehlt.';
 END IF;
END$$
DELIMITER ;
CALL frzk_assert_345_p2();
DROP PROCEDURE frzk_assert_345_p2;

UPDATE dissertation_sections
SET title='Funktionale Operatoren',
    status='review',
    is_original_contribution=1,
    notes='Literaturgestützte vollständige Revision: funktionale Operatormenge, Komposition, Assoziativität, Identität, Invertierbarkeit, Monoid- und Gruppenstruktur.'
WHERE section_id=@section_id;

UPDATE equations SET
 section_id=@section_id,title='Funktionale Operatormenge',
 equation_latex='\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',word_latex='\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',
 plain_description='Menge aller zulässigen funktionalen Selbstabbildungen des Zustandsraumes.',equation_type='definition',
 provenance='adapted',source_id=@source_rudin,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.734';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.734',@section_id,'Funktionale Operatormenge','\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}','\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',
'Menge aller zulässigen funktionalen Selbstabbildungen des Zustandsraumes.','definition','adapted',@source_rudin,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.734');

UPDATE equations SET
 section_id=@section_id,title='Zugehörigkeit zur Operatormenge',
 equation_latex='O_F\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Ein funktionaler Operator gehört zur funktionalen Operatormenge.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.735';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.735',@section_id,'Zugehörigkeit zur Operatormenge','O_F\\in\\mathcal O_F(\\mathcal S)','O_F\\in\\mathcal O_F(\\mathcal S)',
'Ein funktionaler Operator gehört zur funktionalen Operatormenge.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.735');

UPDATE equations SET
 section_id=@section_id,title='Operatorwirkung',
 equation_latex='z_F''=O_F(z_F)',word_latex='z_F''=O_F(z_F)',
 plain_description='Der funktionale Operator erzeugt aus einem Ausgangszustand einen Folgezustand.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.736';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.736',@section_id,'Operatorwirkung','z_F''=O_F(z_F)','z_F''=O_F(z_F)',
'Der funktionale Operator erzeugt aus einem Ausgangszustand einen Folgezustand.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.736');

UPDATE equations SET
 section_id=@section_id,title='Abgeschlossenheit der Operatorwirkung',
 equation_latex='z_F\\in\\Omega_F(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F(\\mathcal S)',word_latex='z_F\\in\\Omega_F(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F(\\mathcal S)',
 plain_description='Eine zulässige Operatorwirkung verbleibt im funktionalen Zustandsraum.',equation_type='lemma',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.737';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.737',@section_id,'Abgeschlossenheit der Operatorwirkung','z_F\\in\\Omega_F(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F(\\mathcal S)','z_F\\in\\Omega_F(\\mathcal S)\\Longrightarrow O_F(z_F)\\in\\Omega_F(\\mathcal S)',
'Eine zulässige Operatorwirkung verbleibt im funktionalen Zustandsraum.','lemma','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.737');

UPDATE equations SET
 section_id=@section_id,title='Ergebnis der Operatorwirkung',
 equation_latex='O_F(z_F)\\in\\Omega_F(\\mathcal S)',word_latex='O_F(z_F)\\in\\Omega_F(\\mathcal S)',
 plain_description='Aussage der Abgeschlossenheit funktionaler Operatorwirkungen.',equation_type='lemma',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.738';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.738',@section_id,'Ergebnis der Operatorwirkung','O_F(z_F)\\in\\Omega_F(\\mathcal S)','O_F(z_F)\\in\\Omega_F(\\mathcal S)',
'Aussage der Abgeschlossenheit funktionaler Operatorwirkungen.','lemma','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.738');

UPDATE equations SET
 section_id=@section_id,title='Selbstabbildung des Zustandsraumes',
 equation_latex='O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',word_latex='O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
 plain_description='Definitions- und Zielbereich eines funktionalen Operators.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.739';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.739',@section_id,'Selbstabbildung des Zustandsraumes','O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)','O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'Definitions- und Zielbereich eines funktionalen Operators.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.739');

UPDATE equations SET
 section_id=@section_id,title='Ausgangszustand im Zustandsraum',
 equation_latex='z_F\\in\\Omega_F(\\mathcal S)',word_latex='z_F\\in\\Omega_F(\\mathcal S)',
 plain_description='Voraussetzung des Abgeschlossenheitsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.740';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.740',@section_id,'Ausgangszustand im Zustandsraum','z_F\\in\\Omega_F(\\mathcal S)','z_F\\in\\Omega_F(\\mathcal S)',
'Voraussetzung des Abgeschlossenheitsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.740');

UPDATE equations SET
 section_id=@section_id,title='Folgezustand im Zustandsraum',
 equation_latex='O_F(z_F)\\in\\Omega_F(\\mathcal S)',word_latex='O_F(z_F)\\in\\Omega_F(\\mathcal S)',
 plain_description='Folgerung aus der Selbstabbildungseigenschaft.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.741';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.741',@section_id,'Folgezustand im Zustandsraum','O_F(z_F)\\in\\Omega_F(\\mathcal S)','O_F(z_F)\\in\\Omega_F(\\mathcal S)',
'Folgerung aus der Selbstabbildungseigenschaft.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.741');

UPDATE equations SET
 section_id=@section_id,title='Zwei funktionale Operatoren',
 equation_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Voraussetzung der Operatorkomposition.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.742';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.742',@section_id,'Zwei funktionale Operatoren','O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)','O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)',
'Voraussetzung der Operatorkomposition.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.742');

UPDATE equations SET
 section_id=@section_id,title='Komposition funktionaler Operatoren',
 equation_latex='O_{F,2}\\circ O_{F,1}:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',word_latex='O_{F,2}\\circ O_{F,1}:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
 plain_description='Die Komposition zweier funktionaler Operatoren ist eine Selbstabbildung.',equation_type='definition',
 provenance='adapted',source_id=@source_rudin,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.743';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.743',@section_id,'Komposition funktionaler Operatoren','O_{F,2}\\circ O_{F,1}:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)','O_{F,2}\\circ O_{F,1}:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'Die Komposition zweier funktionaler Operatoren ist eine Selbstabbildung.','definition','adapted',@source_rudin,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.743');

UPDATE equations SET
 section_id=@section_id,title='Wirkung der Operatorkomposition',
 equation_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',word_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',
 plain_description='Der rechts stehende Operator wirkt zuerst.',equation_type='definition',
 provenance='adapted',source_id=@source_rudin,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.744';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.744',@section_id,'Wirkung der Operatorkomposition','\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)','\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',
'Der rechts stehende Operator wirkt zuerst.','definition','adapted',@source_rudin,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.744');

UPDATE equations SET
 section_id=@section_id,title='Definitionsbereich der Komposition',
 equation_latex='z_F\\in\\Omega_F(\\mathcal S)',word_latex='z_F\\in\\Omega_F(\\mathcal S)',
 plain_description='Zulässiger Ausgangszustand einer Operatorkomposition.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.745';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.745',@section_id,'Definitionsbereich der Komposition','z_F\\in\\Omega_F(\\mathcal S)','z_F\\in\\Omega_F(\\mathcal S)',
'Zulässiger Ausgangszustand einer Operatorkomposition.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.745');

UPDATE equations SET
 section_id=@section_id,title='Erster Zwischenzustand',
 equation_latex='z_F^{(1)}=O_{F,1}(z_F)',word_latex='z_F^{(1)}=O_{F,1}(z_F)',
 plain_description='Ergebnis der ersten Operatorwirkung.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.746';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.746',@section_id,'Erster Zwischenzustand','z_F^{(1)}=O_{F,1}(z_F)','z_F^{(1)}=O_{F,1}(z_F)',
'Ergebnis der ersten Operatorwirkung.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.746');

UPDATE equations SET
 section_id=@section_id,title='Zweiter Folgezustand',
 equation_latex='z_F^{(2)}=O_{F,2}\\left(z_F^{(1)}\\right)',word_latex='z_F^{(2)}=O_{F,2}\\left(z_F^{(1)}\\right)',
 plain_description='Ergebnis der zweiten Operatorwirkung.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.747';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.747',@section_id,'Zweiter Folgezustand','z_F^{(2)}=O_{F,2}\\left(z_F^{(1)}\\right)','z_F^{(2)}=O_{F,2}\\left(z_F^{(1)}\\right)',
'Ergebnis der zweiten Operatorwirkung.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.747');

UPDATE equations SET
 section_id=@section_id,title='Gesamtwirkung der Komposition',
 equation_latex='z_F^{(2)}=\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)',word_latex='z_F^{(2)}=\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)',
 plain_description='Zusammenfassung beider Operatorwirkungen.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.748';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.748',@section_id,'Gesamtwirkung der Komposition','z_F^{(2)}=\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)','z_F^{(2)}=\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)',
'Zusammenfassung beider Operatorwirkungen.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.748');

UPDATE equations SET
 section_id=@section_id,title='Abgeschlossenheit der Operatorkomposition',
 equation_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Die Komposition zulässiger Operatoren ist erneut zulässig.',equation_type='lemma',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.749';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.749',@section_id,'Abgeschlossenheit der Operatorkomposition','O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)','O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
'Die Komposition zulässiger Operatoren ist erneut zulässig.','lemma','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.749');

UPDATE equations SET
 section_id=@section_id,title='Abgeschlossenheit der ersten Wirkung',
 equation_latex='O_{F,1}(z_F)\\in\\Omega_F(\\mathcal S)',word_latex='O_{F,1}(z_F)\\in\\Omega_F(\\mathcal S)',
 plain_description='Erster Schritt des Kompositionsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.750';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.750',@section_id,'Abgeschlossenheit der ersten Wirkung','O_{F,1}(z_F)\\in\\Omega_F(\\mathcal S)','O_{F,1}(z_F)\\in\\Omega_F(\\mathcal S)',
'Erster Schritt des Kompositionsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.750');

UPDATE equations SET
 section_id=@section_id,title='Abgeschlossenheit der zweiten Wirkung',
 equation_latex='O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F(\\mathcal S)',word_latex='O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F(\\mathcal S)',
 plain_description='Zweiter Schritt des Kompositionsbeweises.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.751';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.751',@section_id,'Abgeschlossenheit der zweiten Wirkung','O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F(\\mathcal S)','O_{F,2}\\left(O_{F,1}(z_F)\\right)\\in\\Omega_F(\\mathcal S)',
'Zweiter Schritt des Kompositionsbeweises.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.751');

UPDATE equations SET
 section_id=@section_id,title='Abgeschlossenheit des Gesamtoperators',
 equation_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F(\\mathcal S)',word_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F(\\mathcal S)',
 plain_description='Komposition als funktionaler Operator.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.752';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.752',@section_id,'Abgeschlossenheit des Gesamtoperators','\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F(\\mathcal S)','\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)\\in\\Omega_F(\\mathcal S)',
'Komposition als funktionaler Operator.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.752');

UPDATE equations SET
 section_id=@section_id,title='Drei funktionale Operatoren',
 equation_latex='O_{F,1},O_{F,2},O_{F,3}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_{F,1},O_{F,2},O_{F,3}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Voraussetzung des Assoziativitätssatzes.',equation_type='theorem',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.753';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.753',@section_id,'Drei funktionale Operatoren','O_{F,1},O_{F,2},O_{F,3}\\in\\mathcal O_F(\\mathcal S)','O_{F,1},O_{F,2},O_{F,3}\\in\\mathcal O_F(\\mathcal S)',
'Voraussetzung des Assoziativitätssatzes.','theorem','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.753');

UPDATE equations SET
 section_id=@section_id,title='Assoziativität',
 equation_latex='O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)=\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}',word_latex='O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)=\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}',
 plain_description='Assoziativität funktionaler Operatorkompositionen.',equation_type='theorem',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.754';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.754',@section_id,'Assoziativität','O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)=\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}','O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)=\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}',
'Assoziativität funktionaler Operatorkompositionen.','theorem','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.754');

UPDATE equations SET
 section_id=@section_id,title='Linke Klammerung',
 equation_latex='\\left[O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)',word_latex='\\left[O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)',
 plain_description='Auswertung der linken Klammerung.',equation_type='derived',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.755';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.755',@section_id,'Linke Klammerung','\\left[O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)','\\left[O_{F,3}\\circ\\left(O_{F,2}\\circ O_{F,1}\\right)\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)',
'Auswertung der linken Klammerung.','derived','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.755');

UPDATE equations SET
 section_id=@section_id,title='Rechte Klammerung',
 equation_latex='\\left[\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)',word_latex='\\left[\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)',
 plain_description='Auswertung der rechten Klammerung.',equation_type='derived',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.756';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.756',@section_id,'Rechte Klammerung','\\left[\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)','\\left[\\left(O_{F,3}\\circ O_{F,2}\\right)\\circ O_{F,1}\\right](z_F)=O_{F,3}\\left(O_{F,2}\\left(O_{F,1}(z_F)\\right)\\right)',
'Auswertung der rechten Klammerung.','derived','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.756');

UPDATE equations SET
 section_id=@section_id,title='Endliche Operatorfolge',
 equation_latex='O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,2}\\circ O_{F,1}',word_latex='O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,2}\\circ O_{F,1}',
 plain_description='Klammerungsfreie Notation einer endlichen Operatorfolge.',equation_type='schema',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.757';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.757',@section_id,'Endliche Operatorfolge','O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,2}\\circ O_{F,1}','O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,2}\\circ O_{F,1}',
'Klammerungsfreie Notation einer endlichen Operatorfolge.','schema','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.757');

UPDATE equations SET
 section_id=@section_id,title='Nichtkommutativität im Allgemeinen',
 equation_latex='O_{F,2}\\circ O_{F,1}\\neq O_{F,1}\\circ O_{F,2}',word_latex='O_{F,2}\\circ O_{F,1}\\neq O_{F,1}\\circ O_{F,2}',
 plain_description='Funktionale Operatoren sind im Allgemeinen nicht kommutativ.',equation_type='other',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.758';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.758',@section_id,'Nichtkommutativität im Allgemeinen','O_{F,2}\\circ O_{F,1}\\neq O_{F,1}\\circ O_{F,2}','O_{F,2}\\circ O_{F,1}\\neq O_{F,1}\\circ O_{F,2}',
'Funktionale Operatoren sind im Allgemeinen nicht kommutativ.','other','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.758');

UPDATE equations SET
 section_id=@section_id,title='Gesamtoperator',
 equation_latex='O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',word_latex='O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
 plain_description='Gesamtoperator einer fest geordneten endlichen Operatorfolge.',equation_type='derived',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.759';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.759',@section_id,'Gesamtoperator','O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}','O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
'Gesamtoperator einer fest geordneten endlichen Operatorfolge.','derived','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.759');

UPDATE equations SET
 section_id=@section_id,title='Funktionaler Identitätsoperator',
 equation_latex='I_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',word_latex='I_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
 plain_description='Identitätsoperator auf dem funktionalen Zustandsraum.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.760';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.760',@section_id,'Funktionaler Identitätsoperator','I_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)','I_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'Identitätsoperator auf dem funktionalen Zustandsraum.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.760');

UPDATE equations SET
 section_id=@section_id,title='Wirkung des Identitätsoperators',
 equation_latex='I_F(z_F)=z_F',word_latex='I_F(z_F)=z_F',
 plain_description='Der Identitätsoperator lässt jeden Zustand unverändert.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.761';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.761',@section_id,'Wirkung des Identitätsoperators','I_F(z_F)=z_F','I_F(z_F)=z_F',
'Der Identitätsoperator lässt jeden Zustand unverändert.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.761');

UPDATE equations SET
 section_id=@section_id,title='Gültigkeitsbereich der Identität',
 equation_latex='z_F\\in\\Omega_F(\\mathcal S)',word_latex='z_F\\in\\Omega_F(\\mathcal S)',
 plain_description='Die Identitätswirkung gilt für alle funktionalen Zustände.',equation_type='definition',
 provenance='original',source_id=NULL,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.762';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.762',@section_id,'Gültigkeitsbereich der Identität','z_F\\in\\Omega_F(\\mathcal S)','z_F\\in\\Omega_F(\\mathcal S)',
'Die Identitätswirkung gilt für alle funktionalen Zustände.','definition','original',NULL,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.762');

UPDATE equations SET
 section_id=@section_id,title='Linksneutrale Identität',
 equation_latex='I_F\\circ O_F=O_F',word_latex='I_F\\circ O_F=O_F',
 plain_description='Der Identitätsoperator ist linksneutral.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.763';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.763',@section_id,'Linksneutrale Identität','I_F\\circ O_F=O_F','I_F\\circ O_F=O_F',
'Der Identitätsoperator ist linksneutral.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.763');

UPDATE equations SET
 section_id=@section_id,title='Rechtsneutrale Identität',
 equation_latex='O_F\\circ I_F=O_F',word_latex='O_F\\circ I_F=O_F',
 plain_description='Der Identitätsoperator ist rechtsneutral.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.764';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.764',@section_id,'Rechtsneutrale Identität','O_F\\circ I_F=O_F','O_F\\circ I_F=O_F',
'Der Identitätsoperator ist rechtsneutral.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.764');

UPDATE equations SET
 section_id=@section_id,title='Inverser funktionaler Operator',
 equation_latex='O_F^{-1}\\in\\mathcal O_F(\\mathcal S)',word_latex='O_F^{-1}\\in\\mathcal O_F(\\mathcal S)',
 plain_description='Ein inverser Operator gehört zur funktionalen Operatormenge.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.765';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.765',@section_id,'Inverser funktionaler Operator','O_F^{-1}\\in\\mathcal O_F(\\mathcal S)','O_F^{-1}\\in\\mathcal O_F(\\mathcal S)',
'Ein inverser Operator gehört zur funktionalen Operatormenge.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.765');

UPDATE equations SET
 section_id=@section_id,title='Linksinverse Bedingung',
 equation_latex='O_F^{-1}\\circ O_F=I_F',word_latex='O_F^{-1}\\circ O_F=I_F',
 plain_description='Erste Bedingung der Invertierbarkeit.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.766';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.766',@section_id,'Linksinverse Bedingung','O_F^{-1}\\circ O_F=I_F','O_F^{-1}\\circ O_F=I_F',
'Erste Bedingung der Invertierbarkeit.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.766');

UPDATE equations SET
 section_id=@section_id,title='Rechtsinverse Bedingung',
 equation_latex='O_F\\circ O_F^{-1}=I_F',word_latex='O_F\\circ O_F^{-1}=I_F',
 plain_description='Zweite Bedingung der Invertierbarkeit.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.767';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.767',@section_id,'Rechtsinverse Bedingung','O_F\\circ O_F^{-1}=I_F','O_F\\circ O_F^{-1}=I_F',
'Zweite Bedingung der Invertierbarkeit.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.767');

UPDATE equations SET
 section_id=@section_id,title='Monoid funktionaler Operatoren',
 equation_latex='\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)',word_latex='\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)',
 plain_description='Algebraische Monoidstruktur der funktionalen Operatormenge.',equation_type='theorem',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.768';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.768',@section_id,'Monoid funktionaler Operatoren','\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)','\\left(\\mathcal O_F(\\mathcal S),\\circ,I_F\\right)',
'Algebraische Monoidstruktur der funktionalen Operatormenge.','theorem','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.768');

UPDATE equations SET
 section_id=@section_id,title='Invertierbare funktionale Operatoren',
 equation_latex='\\mathcal G_F(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F^{-1}\\in\\mathcal O_F(\\mathcal S)\\right\\}',word_latex='\\mathcal G_F(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F^{-1}\\in\\mathcal O_F(\\mathcal S)\\right\\}',
 plain_description='Teilmenge aller invertierbaren funktionalen Operatoren.',equation_type='definition',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.769';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.769',@section_id,'Invertierbare funktionale Operatoren','\\mathcal G_F(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F^{-1}\\in\\mathcal O_F(\\mathcal S)\\right\\}','\\mathcal G_F(\\mathcal S)=\\left\\{O_F\\in\\mathcal O_F(\\mathcal S)\\middle|O_F^{-1}\\in\\mathcal O_F(\\mathcal S)\\right\\}',
'Teilmenge aller invertierbaren funktionalen Operatoren.','definition','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.769');

UPDATE equations SET
 section_id=@section_id,title='Gruppe invertierbarer Operatoren',
 equation_latex='\\left(\\mathcal G_F(\\mathcal S),\\circ,I_F\\right)',word_latex='\\left(\\mathcal G_F(\\mathcal S),\\circ,I_F\\right)',
 plain_description='Gruppenstruktur der invertierbaren funktionalen Operatoren.',equation_type='theorem',
 provenance='adapted',source_id=@source_dummit,
 derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
 assumptions='Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
 validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.770';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.770',@section_id,'Gruppe invertierbarer Operatoren','\\left(\\mathcal G_F(\\mathcal S),\\circ,I_F\\right)','\\left(\\mathcal G_F(\\mathcal S),\\circ,I_F\\right)',
'Gruppenstruktur der invertierbaren funktionalen Operatoren.','theorem','adapted',@source_dummit,
'Literaturgestützte Rekonstruktion in Abschnitt 3.4.5.',
'Definition 3.4.11 und der funktionale Zustandsraum werden vorausgesetzt.',
'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.770');


/* Definitionen */
UPDATE definitions SET section_id=@section_id,title='Funktionale Operatormenge',
definition_text='Die funktionale Operatormenge einer Organisation ist die Menge aller zulässigen funktionalen Operatoren, die den funktionalen Zustandsraum in sich selbst abbilden.',
formal_latex='\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',
word_latex='\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',
provenance='original',source_id=NULL,assumptions='Definition 3.4.11.',
notes='FRZK-spezifische Operatormenge ohne vorausgesetzte Norm oder Topologie.',
validation_status='checked',created_revision_id=@revision_id
WHERE definition_number IN ('3.4.12','Def. 3.4.12');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.4.12',@section_id,'Funktionale Operatormenge',
'Die funktionale Operatormenge einer Organisation ist die Menge aller zulässigen funktionalen Operatoren, die den funktionalen Zustandsraum in sich selbst abbilden.',
'\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',
'\\mathcal O_F(\\mathcal S)=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)\\right\\}',
'original',NULL,'Definition 3.4.11.','FRZK-spezifische Operatormenge ohne vorausgesetzte Norm oder Topologie.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number IN ('3.4.12','Def. 3.4.12'));

UPDATE definitions SET section_id=@section_id,title='Komposition funktionaler Operatoren',
definition_text='Die Komposition zweier funktionaler Operatoren ist ihre geordnete Hintereinanderausführung; der rechts stehende Operator wirkt zuerst.',
formal_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',
word_latex='\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',
provenance='adapted',source_id=@source_dummit,assumptions='Beide Operatoren gehören zu derselben funktionalen Operatormenge.',
notes='Übertragung der klassischen Funktionskomposition auf funktionale Zustände.',
validation_status='checked',created_revision_id=@revision_id
WHERE definition_number IN ('3.4.13','Def. 3.4.13');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.4.13',@section_id,'Komposition funktionaler Operatoren',
'Die Komposition zweier funktionaler Operatoren ist ihre geordnete Hintereinanderausführung; der rechts stehende Operator wirkt zuerst.',
'\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',
'\\left(O_{F,2}\\circ O_{F,1}\\right)(z_F)=O_{F,2}\\left(O_{F,1}(z_F)\\right)',
'adapted',@source_dummit,'Beide Operatoren gehören zu derselben funktionalen Operatormenge.',
'Übertragung der klassischen Funktionskomposition auf funktionale Zustände.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number IN ('3.4.13','Def. 3.4.13'));

UPDATE definitions SET section_id=@section_id,title='Identität und Invertierbarkeit funktionaler Operatoren',
definition_text='Der funktionale Identitätsoperator lässt jeden Zustand unverändert. Ein funktionaler Operator ist invertierbar, wenn ein beidseitiger inverser Operator existiert.',
formal_latex='I_F(z_F)=z_F,\\quad O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=I_F',
word_latex='I_F(z_F)=z_F,\\quad O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=I_F',
provenance='adapted',source_id=@source_dummit,assumptions='Komposition funktionaler Operatoren.',
notes='Algebraische Standardbegriffe, auf den funktionalen Zustandsraum übertragen.',
validation_status='checked',created_revision_id=@revision_id
WHERE definition_number IN ('3.4.14','Def. 3.4.14');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT '3.4.14',@section_id,'Identität und Invertierbarkeit funktionaler Operatoren',
'Der funktionale Identitätsoperator lässt jeden Zustand unverändert. Ein funktionaler Operator ist invertierbar, wenn ein beidseitiger inverser Operator existiert.',
'I_F(z_F)=z_F,\\quad O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=I_F',
'I_F(z_F)=z_F,\\quad O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=I_F',
'adapted',@source_dummit,'Komposition funktionaler Operatoren.',
'Algebraische Standardbegriffe, auf den funktionalen Zustandsraum übertragen.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number IN ('3.4.14','Def. 3.4.14'));

/* Lemmata */
UPDATE lemmas SET section_id=@section_id,title='Abgeschlossenheit funktionaler Operatorwirkungen',
statement_text='Für jeden funktionalen Operator und jeden funktionalen Zustand liegt das Ergebnis der Operatorwirkung wiederum im funktionalen Zustandsraum.',
statement_latex='O_F(z_F)\\in\\Omega_F(\\mathcal S)',word_latex='O_F(z_F)\\in\\Omega_F(\\mathcal S)',
provenance='original',source_id=NULL,assumptions='Definition 3.4.11.',validation_status='checked',created_revision_id=@revision_id
WHERE lemma_number='Lemma 3.4.4';

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT 'Lemma 3.4.4',@section_id,'Abgeschlossenheit funktionaler Operatorwirkungen',
'Für jeden funktionalen Operator und jeden funktionalen Zustand liegt das Ergebnis der Operatorwirkung wiederum im funktionalen Zustandsraum.',
'O_F(z_F)\\in\\Omega_F(\\mathcal S)','O_F(z_F)\\in\\Omega_F(\\mathcal S)',
'original',NULL,'Definition 3.4.11.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='Lemma 3.4.4');

UPDATE lemmas SET section_id=@section_id,title='Abgeschlossenheit der Operatorkomposition',
statement_text='Die Komposition zweier funktionaler Operatoren derselben Organisation ist erneut ein funktionaler Operator dieser Organisation.',
statement_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
word_latex='O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
provenance='original',source_id=NULL,assumptions='Definitionen 3.4.11 bis 3.4.13.',validation_status='checked',created_revision_id=@revision_id
WHERE lemma_number='Lemma 3.4.5';

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT 'Lemma 3.4.5',@section_id,'Abgeschlossenheit der Operatorkomposition',
'Die Komposition zweier funktionaler Operatoren derselben Organisation ist erneut ein funktionaler Operator dieser Organisation.',
'O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
'O_{F,1},O_{F,2}\\in\\mathcal O_F(\\mathcal S)\\Longrightarrow O_{F,2}\\circ O_{F,1}\\in\\mathcal O_F(\\mathcal S)',
'original',NULL,'Definitionen 3.4.11 bis 3.4.13.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='Lemma 3.4.5');

/* Sätze */
UPDATE theorems SET section_id=@section_id,title='Assoziativität funktionaler Operatorkompositionen',
statement_text='Die Komposition funktionaler Operatoren ist assoziativ.',
statement_latex='O_{F,3}\\circ(O_{F,2}\\circ O_{F,1})=(O_{F,3}\\circ O_{F,2})\\circ O_{F,1}',
word_latex='O_{F,3}\\circ(O_{F,2}\\circ O_{F,1})=(O_{F,3}\\circ O_{F,2})\\circ O_{F,1}',
provenance='adapted',source_id=@source_dummit,assumptions='Komposition von Selbstabbildungen.',validation_status='checked',created_revision_id=@revision_id
WHERE theorem_number='Satz 3.4.5';

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT 'Satz 3.4.5',@section_id,'Assoziativität funktionaler Operatorkompositionen',
'Die Komposition funktionaler Operatoren ist assoziativ.',
'O_{F,3}\\circ(O_{F,2}\\circ O_{F,1})=(O_{F,3}\\circ O_{F,2})\\circ O_{F,1}',
'O_{F,3}\\circ(O_{F,2}\\circ O_{F,1})=(O_{F,3}\\circ O_{F,2})\\circ O_{F,1}',
'adapted',@source_dummit,'Komposition von Selbstabbildungen.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='Satz 3.4.5');

UPDATE theorems SET section_id=@section_id,title='Monoidstruktur der funktionalen Operatormenge',
statement_text='Die funktionale Operatormenge bildet mit Komposition und Identitätsoperator ein Monoid.',
statement_latex='(\\mathcal O_F(\\mathcal S),\\circ,I_F)',
word_latex='(\\mathcal O_F(\\mathcal S),\\circ,I_F)',
provenance='adapted',source_id=@source_dummit,assumptions='Abgeschlossenheit, Assoziativität und Identitätsoperator.',validation_status='checked',created_revision_id=@revision_id
WHERE theorem_number='Satz 3.4.6';

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT 'Satz 3.4.6',@section_id,'Monoidstruktur der funktionalen Operatormenge',
'Die funktionale Operatormenge bildet mit Komposition und Identitätsoperator ein Monoid.',
'(\\mathcal O_F(\\mathcal S),\\circ,I_F)','(\\mathcal O_F(\\mathcal S),\\circ,I_F)',
'adapted',@source_dummit,'Abgeschlossenheit, Assoziativität und Identitätsoperator.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='Satz 3.4.6');

/* IDs der Aussagen */
SELECT lemma_id INTO @lemma_344 FROM lemmas WHERE lemma_number='Lemma 3.4.4' LIMIT 1;
SELECT lemma_id INTO @lemma_345 FROM lemmas WHERE lemma_number='Lemma 3.4.5' LIMIT 1;
SELECT theorem_id INTO @satz_345 FROM theorems WHERE theorem_number='Satz 3.4.5' LIMIT 1;
SELECT theorem_id INTO @satz_346 FROM theorems WHERE theorem_number='Satz 3.4.6' LIMIT 1;

/* Korollare */
UPDATE corollaries SET section_id=@section_id,title='Eindeutigkeit des Gesamtoperators bei fester Reihenfolge',
statement_text='Jede endliche, fest geordnete Folge funktionaler Operatoren bestimmt genau einen Gesamtoperator.',
statement_latex='O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
word_latex='O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
parent_theorem_id=@satz_345,parent_lemma_id=NULL,provenance='original',source_id=NULL,
validation_status='checked',created_revision_id=@revision_id
WHERE corollary_number='Korollar 3.4.5';

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
SELECT 'Korollar 3.4.5',@section_id,'Eindeutigkeit des Gesamtoperators bei fester Reihenfolge',
'Jede endliche, fest geordnete Folge funktionaler Operatoren bestimmt genau einen Gesamtoperator.',
'O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
'O_F^{\\ast}=O_{F,n}\\circ O_{F,n-1}\\circ\\cdots\\circ O_{F,1}',
@satz_345,NULL,'original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='Korollar 3.4.5');

UPDATE corollaries SET section_id=@section_id,title='Gruppenstruktur der invertierbaren Operatoren',
statement_text='Die Menge der invertierbaren funktionalen Operatoren bildet bezüglich der Komposition eine Gruppe.',
statement_latex='(\\mathcal G_F(\\mathcal S),\\circ,I_F)',
word_latex='(\\mathcal G_F(\\mathcal S),\\circ,I_F)',
parent_theorem_id=@satz_346,parent_lemma_id=NULL,provenance='adapted',source_id=@source_dummit,
validation_status='checked',created_revision_id=@revision_id
WHERE corollary_number='Korollar 3.4.6';

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
SELECT 'Korollar 3.4.6',@section_id,'Gruppenstruktur der invertierbaren Operatoren',
'Die Menge der invertierbaren funktionalen Operatoren bildet bezüglich der Komposition eine Gruppe.',
'(\\mathcal G_F(\\mathcal S),\\circ,I_F)','(\\mathcal G_F(\\mathcal S),\\circ,I_F)',
@satz_346,NULL,'adapted',@source_dummit,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='Korollar 3.4.6');

SELECT corollary_id INTO @kor_345 FROM corollaries WHERE corollary_number='Korollar 3.4.5' LIMIT 1;
SELECT corollary_id INTO @kor_346 FROM corollaries WHERE corollary_number='Korollar 3.4.6' LIMIT 1;

/* Vorhandene Beweise dieser Nummern ersetzen */
DELETE FROM proofs WHERE proof_number IN
('Bew. 3.4.5-R1','Bew. 3.4.5-R2','Bew. 3.4.5-R3','Bew. 3.4.5-R4','Bew. 3.4.5-R5','Bew. 3.4.5-R6');

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.5-R1',@section_id,NULL,@lemma_344,NULL,'Beweis zu Lemma 3.4.4',
'Da jeder funktionale Operator definitionsgemäß den funktionalen Zustandsraum in sich selbst abbildet, gehört das Bild jedes zulässigen Ausgangszustandes erneut zum Zustandsraum.',
NULL,'direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.5-R2',@section_id,NULL,@lemma_345,NULL,'Beweis zu Lemma 3.4.5',
'Die erste Operatorwirkung erzeugt einen Zustand im Zustandsraum. Auf diesen ist der zweite Operator definiert und erzeugt wiederum einen Zustand desselben Raumes. Damit ist die Komposition eine Selbstabbildung.',
NULL,'direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.5-R3',@section_id,@satz_345,NULL,NULL,'Beweis zu Satz 3.4.5',
'Beide Klammerungen ordnen jedem Ausgangszustand denselben Zustand O_{F,3}(O_{F,2}(O_{F,1}(z_F))) zu. Daher sind die zusammengesetzten Operatoren gleich.',
NULL,'direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.5-R4',@section_id,@satz_346,NULL,NULL,'Beweis zu Satz 3.4.6',
'Die Operatormenge ist unter Komposition abgeschlossen, die Komposition ist assoziativ und der Identitätsoperator ist ein beidseitig neutrales Element. Damit sind die Monoidaxiome erfüllt.',
NULL,'direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.5-R5',@section_id,NULL,NULL,@kor_345,'Begründung zu Korollar 3.4.5',
'Die Assoziativität beseitigt jede Abhängigkeit von der Klammerung. Bei festgehaltener Reihenfolge besitzt die endliche Operatorfolge daher eine eindeutig bestimmte Gesamtwirkung.',
NULL,'direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.5-R6',@section_id,NULL,NULL,@kor_346,'Begründung zu Korollar 3.4.6',
'Die invertierbaren Operatoren sind unter Komposition abgeschlossen, enthalten die Identität und zu jedem Element das inverse Element; die Assoziativität wird von der gesamten Operatormenge übernommen.',
NULL,'direct','adapted',@source_dummit,'checked',@revision_id);

/* Quellenverwendungen */
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_rudin,@section_id,'background',
'Operatorräume und Kompositionen als funktionalanalytischer Hintergrund.',
'3.4.5.4–3.4.5.5',0,1,'Bestandsquelle [11].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_rudin AND section_id=@section_id AND exact_location='3.4.5.4–3.4.5.5');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_dummit,@section_id,'theorem',
'Algebraische Grundlagen von Komposition, Assoziativität, Identität, Monoid und Gruppe.',
'3.4.5.5–3.4.5.8',0,1,'Bestandsquelle [31].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_dummit AND section_id=@section_id AND exact_location='3.4.5.5–3.4.5.8');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_conway,@section_id,'comparison',
'Funktionalanalytische Einordnung von Operatoren auf einem gemeinsamen Raum.',
'3.4.5.4',0,1,'Bestandsquelle [35].',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_conway AND section_id=@section_id AND exact_location='3.4.5.4');

/* Änderungsprotokoll – nur gültige Enum-Werte */
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'rewritten','section','3.4.5',
'Abschnitt 3.4.5 vollständig literaturgestützt neu gefasst.',
'Frühere Fassung','Revision mit Operatorraum, Komposition, Identität, Invertierbarkeit, Monoid und Gruppe'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.4.5');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'equation_changed','equations','3.734–3.770',
'37 Gleichungen der Revision von 3.4.5 aktualisiert beziehungsweise ergänzt.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.734–3.770');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'definition_added','definitions','3.4.12–3.4.14',
'Drei Definitionen der revidierten Operatorstruktur registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.4.12–3.4.14');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'statement_added','statements','Lemma/Satz/Korollar 3.4.5',
'Lemmata, Sätze und Korollare der revidierten Operatorstruktur registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='Lemma/Satz/Korollar 3.4.5');

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'proof_added','proofs','Bew. 3.4.5-R1–R6',
'Sechs Beweis- und Begründungsdatensätze zur Revision registriert.',NULL,'checked'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='Bew. 3.4.5-R1–R6');

/* Zähler */
INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section','3.4.5')
ON DUPLICATE KEY UPDATE counter_value='3.4.5';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-REV-K3.4.5-P2-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-REV-K3.4.5-P2-V1';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('next_equation_number','3.771')
ON DUPLICATE KEY UPDATE counter_value='3.771';

COMMIT;

/* Validierung */
SELECT revision_id,revision_code,scope_reference,version_label
FROM repository_revisions WHERE revision_code=@revision_code;

SELECT COUNT(*) AS equations_3_734_to_3_770
FROM equations
WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 734 AND 770;

SELECT equation_number,title,validation_status
FROM equations
WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 734 AND 770
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number,title,validation_status
FROM definitions WHERE section_id=@section_id
AND definition_number IN ('3.4.12','Def. 3.4.12','3.4.13','Def. 3.4.13','3.4.14','Def. 3.4.14');

SELECT lemma_number,title,validation_status
FROM lemmas WHERE section_id=@section_id
AND lemma_number IN ('Lemma 3.4.4','Lemma 3.4.5');

SELECT theorem_number,title,validation_status
FROM theorems WHERE section_id=@section_id
AND theorem_number IN ('Satz 3.4.5','Satz 3.4.6');

SELECT corollary_number,title,validation_status
FROM corollaries WHERE section_id=@section_id
AND corollary_number IN ('Korollar 3.4.5','Korollar 3.4.6');

SELECT proof_number,title,validation_status
FROM proofs WHERE section_id=@section_id
AND proof_number LIKE 'Bew. 3.4.5-R%';

SELECT s.citation_number,s.title,su.exact_location,su.citation_checked
FROM source_usage su JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id AND s.citation_number IN (11,31,35)
ORDER BY s.citation_number;
