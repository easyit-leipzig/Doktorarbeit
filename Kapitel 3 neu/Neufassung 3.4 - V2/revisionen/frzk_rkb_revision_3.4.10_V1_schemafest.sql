
/* =====================================================================
   FRZK-RKB – Repository-Update Abschnitt 3.4.10
   Rekonstruktion funktionaler Raum-Zeit-Strukturen
   Gleichungen (3.987)–(3.1055)
   Definitionen 3.4.50–3.4.62
   Lemmata 3.4.17–3.4.19
   Sätze 3.4.18–3.4.21
   Korollare 3.4.14–3.4.16
   ===================================================================== */

ROLLBACK;
START TRANSACTION;

SET @revision_code := 'RKB-REV-K3.4.10-V1';

SELECT section_id INTO @parent_section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section_id,'3.4.10','Rekonstruktion funktionaler Raum-Zeit-Strukturen',3,3.4100,'review',1,
       'Zusammenführung funktionaler Raum- und Zeitstrukturen zu einer gemeinsamen Ereignis-, Pfad-, Ordnungs- und Kohärenzstruktur.'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.4.10');

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4.10'
LIMIT 1;

SELECT source_id INTO @source_dummit FROM sources WHERE citation_number=31 LIMIT 1;
SELECT source_id INTO @source_diestel FROM sources WHERE citation_number=47 LIMIT 1;

SELECT revision_id INTO @parent_revision_id
FROM repository_revisions
ORDER BY revision_id DESC
LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT @revision_code,NOW(),'section','3.4.10','1.0-complete',
       'Vollständige Revision 3.4.10: funktionale Raum-Zeit-Ereignisse, Nachbarschaften, Pfade, Abstand, Kegel, Gleichzeitigkeit, Kohärenz und Isomorphie.',
       'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SELECT revision_id INTO @revision_id
FROM repository_revisions
WHERE revision_code=@revision_code
LIMIT 1;

DROP PROCEDURE IF EXISTS frzk_assert_3410;
DELIMITER $$
CREATE PROCEDURE frzk_assert_3410()
BEGIN
    IF @parent_section_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Übergeordneter Abschnitt 3.4 fehlt.';
    END IF;
    IF @section_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Abschnitt 3.4.10 konnte nicht bestimmt werden.';
    END IF;
    IF @revision_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Revision 3.4.10 konnte nicht bestimmt werden.';
    END IF;
    IF @source_dummit IS NULL OR @source_diestel IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Bestandsquelle [31] oder [47] fehlt.';
    END IF;
END$$
DELIMITER ;

CALL frzk_assert_3410();
DROP PROCEDURE frzk_assert_3410;

UPDATE dissertation_sections
SET title='Rekonstruktion funktionaler Raum-Zeit-Strukturen',
    status='review',
    is_original_contribution=1,
    notes='Zusammenführung funktionaler Raum- und Zeitstrukturen zu einer gemeinsamen Ereignis-, Pfad-, Ordnungs- und Kohärenzstruktur.'
WHERE section_id=@section_id;


UPDATE equations
SET section_id=@section_id,title='Kohärenter Zustandsraum',equation_latex='\\Omega_F^{K}(\\mathcal S)',word_latex='\\Omega_F^{K}(\\mathcal S)',
    plain_description='Kohärenter Zustandsraum als gemeinsame Grundlage.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.987';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.987',@section_id,'Kohärenter Zustandsraum','\\Omega_F^{K}(\\mathcal S)','\\Omega_F^{K}(\\mathcal S)','Kohärenter Zustandsraum als gemeinsame Grundlage.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.987');


UPDATE equations
SET section_id=@section_id,title='Funktionale Erreichbarkeitsrelation',equation_latex='\\leadsto_F',word_latex='\\leadsto_F',
    plain_description='Relation funktionaler Erreichbarkeit.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.988';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.988',@section_id,'Funktionale Erreichbarkeitsrelation','\\leadsto_F','\\leadsto_F','Relation funktionaler Erreichbarkeit.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.988');


UPDATE equations
SET section_id=@section_id,title='Funktionale Vorordnung',equation_latex='\\preceq_F',word_latex='\\preceq_F',
    plain_description='Funktionale zeitliche Vorordnung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.989';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.989',@section_id,'Funktionale Vorordnung','\\preceq_F','\\preceq_F','Funktionale zeitliche Vorordnung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.989');


UPDATE equations
SET section_id=@section_id,title='Funktionales Raum-Zeit-Ereignis',equation_latex='\\varepsilon_F^{(k)}=\\left(z_F^{(k)},\\zeta_F^{(k)}\\right)',word_latex='\\varepsilon_F^{(k)}=\\left(z_F^{(k)},\\zeta_F^{(k)}\\right)',
    plain_description='Ereignis aus Zustand und Zustandsinstanz.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.990';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.990',@section_id,'Funktionales Raum-Zeit-Ereignis','\\varepsilon_F^{(k)}=\\left(z_F^{(k)},\\zeta_F^{(k)}\\right)','\\varepsilon_F^{(k)}=\\left(z_F^{(k)},\\zeta_F^{(k)}\\right)','Ereignis aus Zustand und Zustandsinstanz.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.990');


UPDATE equations
SET section_id=@section_id,title='Zustandsinstanz',equation_latex='\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)',word_latex='\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)',
    plain_description='Zustandsinstanz mit Pfadposition.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.991';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.991',@section_id,'Zustandsinstanz','\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)','\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)','Zustandsinstanz mit Pfadposition.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.991');


UPDATE equations
SET section_id=@section_id,title='Äquivalente Ereignisdarstellung',equation_latex='\\varepsilon_F^{(k)}=\\left(z_F^{(k)},k\\right)',word_latex='\\varepsilon_F^{(k)}=\\left(z_F^{(k)},k\\right)',
    plain_description='Ereignis bei eindeutig festgelegtem Entwicklungspfad.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.992';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.992',@section_id,'Äquivalente Ereignisdarstellung','\\varepsilon_F^{(k)}=\\left(z_F^{(k)},k\\right)','\\varepsilon_F^{(k)}=\\left(z_F^{(k)},k\\right)','Ereignis bei eindeutig festgelegtem Entwicklungspfad.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.992');


UPDATE equations
SET section_id=@section_id,title='Ereignismenge eines Entwicklungspfads',equation_latex='\\mathcal E_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right\\}',word_latex='\\mathcal E_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right\\}',
    plain_description='Menge funktionaler Raum-Zeit-Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.993';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.993',@section_id,'Ereignismenge eines Entwicklungspfads','\\mathcal E_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right\\}','\\mathcal E_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right\\}','Menge funktionaler Raum-Zeit-Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.993');


UPDATE equations
SET section_id=@section_id,title='Erstes Raum-Zeit-Ereignis',equation_latex='\\varepsilon_F^{(i)}=\\left(z_F^{(i)},i\\right)',word_latex='\\varepsilon_F^{(i)}=\\left(z_F^{(i)},i\\right)',
    plain_description='Erstes Ereignis der Nachbarschaftsdefinition.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.994';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.994',@section_id,'Erstes Raum-Zeit-Ereignis','\\varepsilon_F^{(i)}=\\left(z_F^{(i)},i\\right)','\\varepsilon_F^{(i)}=\\left(z_F^{(i)},i\\right)','Erstes Ereignis der Nachbarschaftsdefinition.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.994');


UPDATE equations
SET section_id=@section_id,title='Zweites Raum-Zeit-Ereignis',equation_latex='\\varepsilon_F^{(j)}=\\left(z_F^{(j)},j\\right)',word_latex='\\varepsilon_F^{(j)}=\\left(z_F^{(j)},j\\right)',
    plain_description='Zweites Ereignis der Nachbarschaftsdefinition.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.995';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.995',@section_id,'Zweites Raum-Zeit-Ereignis','\\varepsilon_F^{(j)}=\\left(z_F^{(j)},j\\right)','\\varepsilon_F^{(j)}=\\left(z_F^{(j)},j\\right)','Zweites Ereignis der Nachbarschaftsdefinition.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.995');


UPDATE equations
SET section_id=@section_id,title='Unmittelbare funktionale Nachfolge',equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    plain_description='Räumliche Übergangsbedingung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.996';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.996',@section_id,'Unmittelbare funktionale Nachfolge','z_F^{(i)}\\prec_F z_F^{(j)}','z_F^{(i)}\\prec_F z_F^{(j)}','Räumliche Übergangsbedingung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.996');


UPDATE equations
SET section_id=@section_id,title='Unmittelbare Instanzfolge',equation_latex='j=i+1',word_latex='j=i+1',
    plain_description='Zeitliche Bedingung unmittelbarer Nachbarschaft.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.997';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.997',@section_id,'Unmittelbare Instanzfolge','j=i+1','j=i+1','Zeitliche Bedingung unmittelbarer Nachbarschaft.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.997');


UPDATE equations
SET section_id=@section_id,title='Raum-Zeit-Nachbarschaft',equation_latex='\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}',word_latex='\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}',
    plain_description='Notation gerichteter Raum-Zeit-Nachbarschaft.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.998';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.998',@section_id,'Raum-Zeit-Nachbarschaft','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}','Notation gerichteter Raum-Zeit-Nachbarschaft.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.998');


UPDATE equations
SET section_id=@section_id,title='Gerichtete Nachbarschaft',equation_latex='\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}',word_latex='\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}',
    plain_description='Ausgangsrelation von Lemma 3.4.17.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.999';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.999',@section_id,'Gerichtete Nachbarschaft','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}','Ausgangsrelation von Lemma 3.4.17.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.999');


UPDATE equations
SET section_id=@section_id,title='Keine automatische Umkehrung',equation_latex='\\varepsilon_F^{(j)}\\blacktriangleright_F\\varepsilon_F^{(i)}',word_latex='\\varepsilon_F^{(j)}\\blacktriangleright_F\\varepsilon_F^{(i)}',
    plain_description='Die Umkehrrelation folgt nicht automatisch.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1000';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1000',@section_id,'Keine automatische Umkehrung','\\varepsilon_F^{(j)}\\blacktriangleright_F\\varepsilon_F^{(i)}','\\varepsilon_F^{(j)}\\blacktriangleright_F\\varepsilon_F^{(i)}','Die Umkehrrelation folgt nicht automatisch.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1000');


UPDATE equations
SET section_id=@section_id,title='Funktionaler Raum-Zeit-Pfad',equation_latex='\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right)',word_latex='\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right)',
    plain_description='Endliche Folge funktionaler Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1001';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1001',@section_id,'Funktionaler Raum-Zeit-Pfad','\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right)','\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(1)},\\ldots,\\varepsilon_F^{(n)}\\right)','Endliche Folge funktionaler Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1001');


UPDATE equations
SET section_id=@section_id,title='Pfadnachbarschaft',equation_latex='\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}',word_latex='\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}',
    plain_description='Nachbarschaft aufeinanderfolgender Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1002';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1002',@section_id,'Pfadnachbarschaft','\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}','\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}','Nachbarschaft aufeinanderfolgender Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1002');


UPDATE equations
SET section_id=@section_id,title='Pfadindexbereich',equation_latex='k=0,\\ldots,n-1',word_latex='k=0,\\ldots,n-1',
    plain_description='Indexbereich der Pfadübergänge.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1003';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1003',@section_id,'Pfadindexbereich','k=0,\\ldots,n-1','k=0,\\ldots,n-1','Indexbereich der Pfadübergänge.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1003');


UPDATE equations
SET section_id=@section_id,title='Ungewichtete Pfadlänge',equation_latex='L_F\\left(\\Gamma_F^{(n)}\\right)=n',word_latex='L_F\\left(\\Gamma_F^{(n)}\\right)=n',
    plain_description='Anzahl der Übergänge eines Raum-Zeit-Pfads.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1004';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1004',@section_id,'Ungewichtete Pfadlänge','L_F\\left(\\Gamma_F^{(n)}\\right)=n','L_F\\left(\\Gamma_F^{(n)}\\right)=n','Anzahl der Übergänge eines Raum-Zeit-Pfads.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1004');


UPDATE equations
SET section_id=@section_id,title='Gewichtete Raum-Zeit-Pfadlänge',equation_latex='L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\sum_{k=0}^{n-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)',word_latex='L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\sum_{k=0}^{n-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)',
    plain_description='Summe funktionaler Übergangsgewichte.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1005';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1005',@section_id,'Gewichtete Raum-Zeit-Pfadlänge','L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\sum_{k=0}^{n-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)','L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\sum_{k=0}^{n-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)','Summe funktionaler Übergangsgewichte.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1005');


UPDATE equations
SET section_id=@section_id,title='Pfadlänge und funktionale Zeitdifferenz',equation_latex='L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\Delta\\tau_F^{w}\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(n)}\\right)',word_latex='L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\Delta\\tau_F^{w}\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(n)}\\right)',
    plain_description='Gleichheit gewichteter Pfadlänge und Zeitdifferenz.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1006';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1006',@section_id,'Pfadlänge und funktionale Zeitdifferenz','L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\Delta\\tau_F^{w}\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(n)}\\right)','L_F^{w}\\left(\\Gamma_F^{(n)}\\right)=\\Delta\\tau_F^{w}\\left(\\varepsilon_F^{(0)},\\varepsilon_F^{(n)}\\right)','Gleichheit gewichteter Pfadlänge und Zeitdifferenz.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1006');


UPDATE equations
SET section_id=@section_id,title='Funktionale Raum-Zeit-Struktur',equation_latex='\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F,w_F\\right)',word_latex='\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F,w_F\\right)',
    plain_description='Vollständiges Raum-Zeit-Strukturtupel.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1007';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1007',@section_id,'Funktionale Raum-Zeit-Struktur','\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F,w_F\\right)','\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F,w_F\\right)','Vollständiges Raum-Zeit-Strukturtupel.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1007');


UPDATE equations
SET section_id=@section_id,title='Ereignismenge',equation_latex='\\mathcal E_F',word_latex='\\mathcal E_F',
    plain_description='Menge funktionaler Raum-Zeit-Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1008';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1008',@section_id,'Ereignismenge','\\mathcal E_F','\\mathcal E_F','Menge funktionaler Raum-Zeit-Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1008');


UPDATE equations
SET section_id=@section_id,title='Raum-Zeit-Nachbarschaftsrelation',equation_latex='\\blacktriangleright_F',word_latex='\\blacktriangleright_F',
    plain_description='Unmittelbare gerichtete Raum-Zeit-Nachbarschaft.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1009';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1009',@section_id,'Raum-Zeit-Nachbarschaftsrelation','\\blacktriangleright_F','\\blacktriangleright_F','Unmittelbare gerichtete Raum-Zeit-Nachbarschaft.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1009');


UPDATE equations
SET section_id=@section_id,title='Erreichbarkeitskomponente',equation_latex='\\leadsto_F',word_latex='\\leadsto_F',
    plain_description='Funktionale Erreichbarkeit innerhalb der Raum-Zeit-Struktur.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1010';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1010',@section_id,'Erreichbarkeitskomponente','\\leadsto_F','\\leadsto_F','Funktionale Erreichbarkeit innerhalb der Raum-Zeit-Struktur.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1010');


UPDATE equations
SET section_id=@section_id,title='Vorordnungskomponente',equation_latex='\\preceq_F',word_latex='\\preceq_F',
    plain_description='Funktionale Vorordnung innerhalb der Raum-Zeit-Struktur.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1011';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1011',@section_id,'Vorordnungskomponente','\\preceq_F','\\preceq_F','Funktionale Vorordnung innerhalb der Raum-Zeit-Struktur.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1011');


UPDATE equations
SET section_id=@section_id,title='Gewichtungskomponente',equation_latex='w_F',word_latex='w_F',
    plain_description='Optionale nichtnegative Übergangsgewichtung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1012';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1012',@section_id,'Gewichtungskomponente','w_F','w_F','Optionale nichtnegative Übergangsgewichtung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1012');


UPDATE equations
SET section_id=@section_id,title='Reduzierte Raum-Zeit-Struktur',equation_latex='\\mathfrak{RZ}_F^{0}=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F\\right)',word_latex='\\mathfrak{RZ}_F^{0}=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F\\right)',
    plain_description='Raum-Zeit-Struktur ohne explizite Gewichtung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1013';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1013',@section_id,'Reduzierte Raum-Zeit-Struktur','\\mathfrak{RZ}_F^{0}=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F\\right)','\\mathfrak{RZ}_F^{0}=\\left(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F\\right)','Raum-Zeit-Struktur ohne explizite Gewichtung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1013');


UPDATE equations
SET section_id=@section_id,title='Zwei kohärente Zustände',equation_latex='z_F^{(0)},z_F^{(1)}\\in\\Omega_F^{K}(\\mathcal S)',word_latex='z_F^{(0)},z_F^{(1)}\\in\\Omega_F^{K}(\\mathcal S)',
    plain_description='Zustände des Existenzsatzes.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1014';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1014',@section_id,'Zwei kohärente Zustände','z_F^{(0)},z_F^{(1)}\\in\\Omega_F^{K}(\\mathcal S)','z_F^{(0)},z_F^{(1)}\\in\\Omega_F^{K}(\\mathcal S)','Zustände des Existenzsatzes.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1014');


UPDATE equations
SET section_id=@section_id,title='Nichtidentischer Übergang',equation_latex='z_F^{(0)}\\prec_F z_F^{(1)}',word_latex='z_F^{(0)}\\prec_F z_F^{(1)}',
    plain_description='Voraussetzung der Existenz einer nichttrivialen Raum-Zeit-Struktur.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1015';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1015',@section_id,'Nichtidentischer Übergang','z_F^{(0)}\\prec_F z_F^{(1)}','z_F^{(0)}\\prec_F z_F^{(1)}','Voraussetzung der Existenz einer nichttrivialen Raum-Zeit-Struktur.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1015');


UPDATE equations
SET section_id=@section_id,title='Erstes Existenzereignis',equation_latex='\\varepsilon_F^{(0)}=\\left(z_F^{(0)},0\\right)',word_latex='\\varepsilon_F^{(0)}=\\left(z_F^{(0)},0\\right)',
    plain_description='Ausgangsereignis.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1016';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1016',@section_id,'Erstes Existenzereignis','\\varepsilon_F^{(0)}=\\left(z_F^{(0)},0\\right)','\\varepsilon_F^{(0)}=\\left(z_F^{(0)},0\\right)','Ausgangsereignis.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1016');


UPDATE equations
SET section_id=@section_id,title='Zweites Existenzereignis',equation_latex='\\varepsilon_F^{(1)}=\\left(z_F^{(1)},1\\right)',word_latex='\\varepsilon_F^{(1)}=\\left(z_F^{(1)},1\\right)',
    plain_description='Folgeereignis.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1017';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1017',@section_id,'Zweites Existenzereignis','\\varepsilon_F^{(1)}=\\left(z_F^{(1)},1\\right)','\\varepsilon_F^{(1)}=\\left(z_F^{(1)},1\\right)','Folgeereignis.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1017');


UPDATE equations
SET section_id=@section_id,title='Nichttriviale Raum-Zeit-Verbindung',equation_latex='\\varepsilon_F^{(0)}\\blacktriangleright_F\\varepsilon_F^{(1)}',word_latex='\\varepsilon_F^{(0)}\\blacktriangleright_F\\varepsilon_F^{(1)}',
    plain_description='Gerichtete Verbindung zwischen zwei Ereignissen.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1018';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1018',@section_id,'Nichttriviale Raum-Zeit-Verbindung','\\varepsilon_F^{(0)}\\blacktriangleright_F\\varepsilon_F^{(1)}','\\varepsilon_F^{(0)}\\blacktriangleright_F\\varepsilon_F^{(1)}','Gerichtete Verbindung zwischen zwei Ereignissen.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1018');


UPDATE equations
SET section_id=@section_id,title='Funktionale Nachbarschaft',equation_latex='\\text{funktionale Nachbarschaft}',word_latex='\\text{funktionale Nachbarschaft}',
    plain_description='Erste Folge einer Operatorwirkung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1019';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1019',@section_id,'Funktionale Nachbarschaft','\\text{funktionale Nachbarschaft}','\\text{funktionale Nachbarschaft}','Erste Folge einer Operatorwirkung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1019');


UPDATE equations
SET section_id=@section_id,title='Funktionale Nachfolge',equation_latex='\\text{funktionale Nachfolge}',word_latex='\\text{funktionale Nachfolge}',
    plain_description='Zweite Folge derselben Operatorwirkung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1020';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1020',@section_id,'Funktionale Nachfolge','\\text{funktionale Nachfolge}','\\text{funktionale Nachfolge}','Zweite Folge derselben Operatorwirkung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1020');


UPDATE equations
SET section_id=@section_id,title='Gerichteter Raum-Zeit-Abstand',equation_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\inf_{\\Gamma_F}L_F^{w}\\left(\\Gamma_F\\right)',word_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\inf_{\\Gamma_F}L_F^{w}\\left(\\Gamma_F\\right)',
    plain_description='Infimum der gewichteten Pfadlängen.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1021';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1021',@section_id,'Gerichteter Raum-Zeit-Abstand','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\inf_{\\Gamma_F}L_F^{w}\\left(\\Gamma_F\\right)','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\inf_{\\Gamma_F}L_F^{w}\\left(\\Gamma_F\\right)','Infimum der gewichteten Pfadlängen.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1021');


UPDATE equations
SET section_id=@section_id,title='Unendlicher Abstand ohne Pfad',equation_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\infty',word_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\infty',
    plain_description='Abstand nicht erreichbarer Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1022';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1022',@section_id,'Unendlicher Abstand ohne Pfad','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\infty','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=\\infty','Abstand nicht erreichbarer Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1022');


UPDATE equations
SET section_id=@section_id,title='Nullabstand identischer Ereignisse',equation_latex='d_{RZ,F}\\left(\\varepsilon_F,\\varepsilon_F\\right)=0',word_latex='d_{RZ,F}\\left(\\varepsilon_F,\\varepsilon_F\\right)=0',
    plain_description='Identitätsbedingung des Raum-Zeit-Abstands.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1023';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1023',@section_id,'Nullabstand identischer Ereignisse','d_{RZ,F}\\left(\\varepsilon_F,\\varepsilon_F\\right)=0','d_{RZ,F}\\left(\\varepsilon_F,\\varepsilon_F\\right)=0','Identitätsbedingung des Raum-Zeit-Abstands.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1023');


UPDATE equations
SET section_id=@section_id,title='Dreiecksungleichung',equation_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(k)}\\right)\\leq d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)+d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(k)}\\right)',word_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(k)}\\right)\\leq d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)+d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(k)}\\right)',
    plain_description='Dreiecksungleichung des gerichteten Abstands.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1024';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1024',@section_id,'Dreiecksungleichung','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(k)}\\right)\\leq d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)+d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(k)}\\right)','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(k)}\\right)\\leq d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)+d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(k)}\\right)','Dreiecksungleichung des gerichteten Abstands.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1024');


UPDATE equations
SET section_id=@section_id,title='Positive Übergangsgewichte',equation_latex='w_F\\left(O_F,z_F\\right)>0',word_latex='w_F\\left(O_F,z_F\\right)>0',
    plain_description='Positivitätsbedingung nichtidentischer Übergänge.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1025';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1025',@section_id,'Positive Übergangsgewichte','w_F\\left(O_F,z_F\\right)>0','w_F\\left(O_F,z_F\\right)>0','Positivitätsbedingung nichtidentischer Übergänge.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1025');


UPDATE equations
SET section_id=@section_id,title='Asymmetrie des Raum-Zeit-Abstands',equation_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\neq d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(i)}\\right)',word_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\neq d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(i)}\\right)',
    plain_description='Gerichtete Quasimetrik ist im Allgemeinen nicht symmetrisch.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1026';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1026',@section_id,'Asymmetrie des Raum-Zeit-Abstands','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\neq d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(i)}\\right)','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\neq d_{RZ,F}\\left(\\varepsilon_F^{(j)},\\varepsilon_F^{(i)}\\right)','Gerichtete Quasimetrik ist im Allgemeinen nicht symmetrisch.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1026');


UPDATE equations
SET section_id=@section_id,title='Funktionaler Zukunftskegel',equation_latex='J_F^{+}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F\\preceq_F\\varepsilon_F''\\right\\}',word_latex='J_F^{+}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F\\preceq_F\\varepsilon_F''\\right\\}',
    plain_description='Menge funktional nachgeordneter Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1027';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1027',@section_id,'Funktionaler Zukunftskegel','J_F^{+}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F\\preceq_F\\varepsilon_F''\\right\\}','J_F^{+}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F\\preceq_F\\varepsilon_F''\\right\\}','Menge funktional nachgeordneter Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1027');


UPDATE equations
SET section_id=@section_id,title='Funktionaler Vergangenheitskegel',equation_latex='J_F^{-}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F''\\preceq_F\\varepsilon_F\\right\\}',word_latex='J_F^{-}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F''\\preceq_F\\varepsilon_F\\right\\}',
    plain_description='Menge funktional vorgeordneter Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1028';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1028',@section_id,'Funktionaler Vergangenheitskegel','J_F^{-}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F''\\preceq_F\\varepsilon_F\\right\\}','J_F^{-}\\left(\\varepsilon_F\\right)=\\left\\{\\varepsilon_F''\\in\\mathcal E_F\\middle|\\varepsilon_F''\\preceq_F\\varepsilon_F\\right\\}','Menge funktional vorgeordneter Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1028');


UPDATE equations
SET section_id=@section_id,title='Ereignis außerhalb beider Kegel',equation_latex='\\varepsilon_F''\\notin J_F^{+}\\left(\\varepsilon_F\\right)\\cup J_F^{-}\\left(\\varepsilon_F\\right)',word_latex='\\varepsilon_F''\\notin J_F^{+}\\left(\\varepsilon_F\\right)\\cup J_F^{-}\\left(\\varepsilon_F\\right)',
    plain_description='Außerhalb von Zukunfts- und Vergangenheitskegel.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1029';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1029',@section_id,'Ereignis außerhalb beider Kegel','\\varepsilon_F''\\notin J_F^{+}\\left(\\varepsilon_F\\right)\\cup J_F^{-}\\left(\\varepsilon_F\\right)','\\varepsilon_F''\\notin J_F^{+}\\left(\\varepsilon_F\\right)\\cup J_F^{-}\\left(\\varepsilon_F\\right)','Außerhalb von Zukunfts- und Vergangenheitskegel.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1029');


UPDATE equations
SET section_id=@section_id,title='Funktionale Unvergleichbarkeit',equation_latex='\\varepsilon_F\\parallel_F\\varepsilon_F''',word_latex='\\varepsilon_F\\parallel_F\\varepsilon_F''',
    plain_description='Unvergleichbarkeit außerhalb beider Kegel.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1030';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1030',@section_id,'Funktionale Unvergleichbarkeit','\\varepsilon_F\\parallel_F\\varepsilon_F''','\\varepsilon_F\\parallel_F\\varepsilon_F''','Unvergleichbarkeit außerhalb beider Kegel.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1030');


UPDATE equations
SET section_id=@section_id,title='Endliche lokale Operatorenmenge',equation_latex='\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|<\\infty',word_latex='\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|<\\infty',
    plain_description='Endliche Anzahl lokal zulässiger Operatoren.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1031';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1031',@section_id,'Endliche lokale Operatorenmenge','\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|<\\infty','\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|<\\infty','Endliche Anzahl lokal zulässiger Operatoren.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1031');


UPDATE equations
SET section_id=@section_id,title='Begrenzte Nachfolgermenge',equation_latex='\\left|\\operatorname{Succ}_F\\left(\\varepsilon_F\\right)\\right|\\leq\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|',word_latex='\\left|\\operatorname{Succ}_F\\left(\\varepsilon_F\\right)\\right|\\leq\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|',
    plain_description='Begrenzung unmittelbarer Zukunftsmöglichkeiten.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1032';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1032',@section_id,'Begrenzte Nachfolgermenge','\\left|\\operatorname{Succ}_F\\left(\\varepsilon_F\\right)\\right|\\leq\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|','\\left|\\operatorname{Succ}_F\\left(\\varepsilon_F\\right)\\right|\\leq\\left|\\mathcal O_F^{K}\\left(\\varepsilon_F\\right)\\right|','Begrenzung unmittelbarer Zukunftsmöglichkeiten.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1032');


UPDATE equations
SET section_id=@section_id,title='Gemeinsamer funktionaler Zeitschnitt',equation_latex='\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\in\\Sigma_F',word_latex='\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\in\\Sigma_F',
    plain_description='Ereignisse gehören demselben Zeitschnitt an.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1033';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1033',@section_id,'Gemeinsamer funktionaler Zeitschnitt','\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\in\\Sigma_F','\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\in\\Sigma_F','Ereignisse gehören demselben Zeitschnitt an.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1033');


UPDATE equations
SET section_id=@section_id,title='Unvergleichbare Ereignisse',equation_latex='\\varepsilon_F^{(i)}\\parallel_F\\varepsilon_F^{(j)}',word_latex='\\varepsilon_F^{(i)}\\parallel_F\\varepsilon_F^{(j)}',
    plain_description='Bedingung funktionaler Gleichzeitigkeit.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1034';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1034',@section_id,'Unvergleichbare Ereignisse','\\varepsilon_F^{(i)}\\parallel_F\\varepsilon_F^{(j)}','\\varepsilon_F^{(i)}\\parallel_F\\varepsilon_F^{(j)}','Bedingung funktionaler Gleichzeitigkeit.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1034');


UPDATE equations
SET section_id=@section_id,title='Notation funktionaler Gleichzeitigkeit',equation_latex='\\varepsilon_F^{(i)}\\sim_{\\tau_F}\\varepsilon_F^{(j)}',word_latex='\\varepsilon_F^{(i)}\\sim_{\\tau_F}\\varepsilon_F^{(j)}',
    plain_description='Funktionale Gleichzeitigkeit relativ zu einem Zeitschnitt.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1035';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1035',@section_id,'Notation funktionaler Gleichzeitigkeit','\\varepsilon_F^{(i)}\\sim_{\\tau_F}\\varepsilon_F^{(j)}','\\varepsilon_F^{(i)}\\sim_{\\tau_F}\\varepsilon_F^{(j)}','Funktionale Gleichzeitigkeit relativ zu einem Zeitschnitt.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1035');


UPDATE equations
SET section_id=@section_id,title='Kohärenter Raum-Zeit-Pfad',equation_latex='\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\ldots,\\varepsilon_F^{(n)}\\right)',word_latex='\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\ldots,\\varepsilon_F^{(n)}\\right)',
    plain_description='Pfad funktionaler Ereignisse.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1036';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1036',@section_id,'Kohärenter Raum-Zeit-Pfad','\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\ldots,\\varepsilon_F^{(n)}\\right)','\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\ldots,\\varepsilon_F^{(n)}\\right)','Pfad funktionaler Ereignisse.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1036');


UPDATE equations
SET section_id=@section_id,title='Übergang eines kohärenten Pfads',equation_latex='\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}',word_latex='\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}',
    plain_description='Einzelner Raum-Zeit-Übergang.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1037';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1037',@section_id,'Übergang eines kohärenten Pfads','\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}','\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}','Einzelner Raum-Zeit-Übergang.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1037');


UPDATE equations
SET section_id=@section_id,title='Kohärenzerhaltender Operator',equation_latex='O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)',word_latex='O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)',
    plain_description='Operatorbedingung des kohärenten Pfads.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1038';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1038',@section_id,'Kohärenzerhaltender Operator','O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)','O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)','Operatorbedingung des kohärenten Pfads.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1038');


UPDATE equations
SET section_id=@section_id,title='Kohärente Pfadzustände',equation_latex='z_F^{(k)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)\\qquad\\text{für alle }k',word_latex='z_F^{(k)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)\\qquad\\text{für alle }k',
    plain_description='Alle Zustände des Pfads bleiben kohärent.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1039';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1039',@section_id,'Kohärente Pfadzustände','z_F^{(k)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)\\qquad\\text{für alle }k','z_F^{(k)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)\\qquad\\text{für alle }k','Alle Zustände des Pfads bleiben kohärent.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1039');


UPDATE equations
SET section_id=@section_id,title='Kohärenter Ausgangszustand',equation_latex='z_F^{(0)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)',word_latex='z_F^{(0)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)',
    plain_description='Induktionsanfang des Kohärenzerhaltungssatzes.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1040';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1040',@section_id,'Kohärenter Ausgangszustand','z_F^{(0)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)','z_F^{(0)}\\in\\Omega_F^{K}\\left(\\mathcal S\\right)','Induktionsanfang des Kohärenzerhaltungssatzes.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1040');


UPDATE equations
SET section_id=@section_id,title='Rekursive Zustandsentwicklung',equation_latex='z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)',word_latex='z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)',
    plain_description='Operatorische Fortschreibung des Zustands.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1041';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1041',@section_id,'Rekursive Zustandsentwicklung','z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)','z_F^{(k+1)}=O_{F,k+1}\\left(z_F^{(k)}\\right)','Operatorische Fortschreibung des Zustands.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1041');


UPDATE equations
SET section_id=@section_id,title='Kohärenzerhaltende Pfadoperatoren',equation_latex='O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)',word_latex='O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)',
    plain_description='Induktionsvoraussetzung für jeden Übergang.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1042';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1042',@section_id,'Kohärenzerhaltende Pfadoperatoren','O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)','O_{F,k+1}\\in\\mathcal O_F^{K}\\left(\\mathcal S\\right)','Induktionsvoraussetzung für jeden Übergang.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1042');


UPDATE equations
SET section_id=@section_id,title='Kohärente Raum-Zeit-Komponente',equation_latex='\\mathcal C_{RZ,F}^{K}\\left(\\varepsilon_F^{(0)}\\right)',word_latex='\\mathcal C_{RZ,F}^{K}\\left(\\varepsilon_F^{(0)}\\right)',
    plain_description='Erreichbare kohärente Ereigniskomponente.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1043';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1043',@section_id,'Kohärente Raum-Zeit-Komponente','\\mathcal C_{RZ,F}^{K}\\left(\\varepsilon_F^{(0)}\\right)','\\mathcal C_{RZ,F}^{K}\\left(\\varepsilon_F^{(0)}\\right)','Erreichbare kohärente Ereigniskomponente.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1043');


UPDATE equations
SET section_id=@section_id,title='Lokale Ereignismenge',equation_latex='\\mathcal E_F^{\\mathrm{lok}}\\subseteq\\mathcal E_F',word_latex='\\mathcal E_F^{\\mathrm{lok}}\\subseteq\\mathcal E_F',
    plain_description='Teilmenge für lokale Raum-Zeit-Struktur.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1044';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1044',@section_id,'Lokale Ereignismenge','\\mathcal E_F^{\\mathrm{lok}}\\subseteq\\mathcal E_F','\\mathcal E_F^{\\mathrm{lok}}\\subseteq\\mathcal E_F','Teilmenge für lokale Raum-Zeit-Struktur.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1044');


UPDATE equations
SET section_id=@section_id,title='Lokale Raum-Zeit-Einschränkung',equation_latex='\\mathfrak{RZ}_F^{\\mathrm{lok}}=\\mathfrak{RZ}_F\\big|_{\\mathcal E_F^{\\mathrm{lok}}}',word_latex='\\mathfrak{RZ}_F^{\\mathrm{lok}}=\\mathfrak{RZ}_F\\big|_{\\mathcal E_F^{\\mathrm{lok}}}',
    plain_description='Einschränkung der globalen Struktur.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1045';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1045',@section_id,'Lokale Raum-Zeit-Einschränkung','\\mathfrak{RZ}_F^{\\mathrm{lok}}=\\mathfrak{RZ}_F\\big|_{\\mathcal E_F^{\\mathrm{lok}}}','\\mathfrak{RZ}_F^{\\mathrm{lok}}=\\mathfrak{RZ}_F\\big|_{\\mathcal E_F^{\\mathrm{lok}}}','Einschränkung der globalen Struktur.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1045');


UPDATE equations
SET section_id=@section_id,title='Globale Raum-Zeit-Struktur',equation_latex='\\mathfrak{RZ}_F^{\\mathrm{glob}}=\\bigcup_{\\alpha\\in A}\\mathfrak{RZ}_{F,\\alpha}^{\\mathrm{lok}}',word_latex='\\mathfrak{RZ}_F^{\\mathrm{glob}}=\\bigcup_{\\alpha\\in A}\\mathfrak{RZ}_{F,\\alpha}^{\\mathrm{lok}}',
    plain_description='Vereinigung lokaler Ereigniskomponenten.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1046';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1046',@section_id,'Globale Raum-Zeit-Struktur','\\mathfrak{RZ}_F^{\\mathrm{glob}}=\\bigcup_{\\alpha\\in A}\\mathfrak{RZ}_{F,\\alpha}^{\\mathrm{lok}}','\\mathfrak{RZ}_F^{\\mathrm{glob}}=\\bigcup_{\\alpha\\in A}\\mathfrak{RZ}_{F,\\alpha}^{\\mathrm{lok}}','Vereinigung lokaler Ereigniskomponenten.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1046');


UPDATE equations
SET section_id=@section_id,title='Verbindung lokaler Komponenten',equation_latex='\\exists\\varepsilon_F^{(i)}\\in\\mathcal E_{F,\\alpha},\\;\\varepsilon_F^{(j)}\\in\\mathcal E_{F,\\beta}:\\quad\\varepsilon_F^{(i)}\\leadsto_F\\varepsilon_F^{(j)}',word_latex='\\exists\\varepsilon_F^{(i)}\\in\\mathcal E_{F,\\alpha},\\;\\varepsilon_F^{(j)}\\in\\mathcal E_{F,\\beta}:\\quad\\varepsilon_F^{(i)}\\leadsto_F\\varepsilon_F^{(j)}',
    plain_description='Existenz eines Übergangs zwischen lokalen Komponenten.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1047';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1047',@section_id,'Verbindung lokaler Komponenten','\\exists\\varepsilon_F^{(i)}\\in\\mathcal E_{F,\\alpha},\\;\\varepsilon_F^{(j)}\\in\\mathcal E_{F,\\beta}:\\quad\\varepsilon_F^{(i)}\\leadsto_F\\varepsilon_F^{(j)}','\\exists\\varepsilon_F^{(i)}\\in\\mathcal E_{F,\\alpha},\\;\\varepsilon_F^{(j)}\\in\\mathcal E_{F,\\beta}:\\quad\\varepsilon_F^{(i)}\\leadsto_F\\varepsilon_F^{(j)}','Existenz eines Übergangs zwischen lokalen Komponenten.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1047');


UPDATE equations
SET section_id=@section_id,title='Erste isomorphe Raum-Zeit-Struktur',equation_latex='\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\preceq_F,w_F\\right)',word_latex='\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\preceq_F,w_F\\right)',
    plain_description='Ausgangsstruktur des Isomorphismus.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1048';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1048',@section_id,'Erste isomorphe Raum-Zeit-Struktur','\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\preceq_F,w_F\\right)','\\mathfrak{RZ}_F=\\left(\\mathcal E_F,\\blacktriangleright_F,\\preceq_F,w_F\\right)','Ausgangsstruktur des Isomorphismus.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1048');


UPDATE equations
SET section_id=@section_id,title='Zweite isomorphe Raum-Zeit-Struktur',equation_latex='\\mathfrak{RZ}_F''=\\left(\\mathcal E_F'',\\blacktriangleright_F'',\\preceq_F'',w_F''\\right)',word_latex='\\mathfrak{RZ}_F''=\\left(\\mathcal E_F'',\\blacktriangleright_F'',\\preceq_F'',w_F''\\right)',
    plain_description='Zielstruktur des Isomorphismus.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1049';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1049',@section_id,'Zweite isomorphe Raum-Zeit-Struktur','\\mathfrak{RZ}_F''=\\left(\\mathcal E_F'',\\blacktriangleright_F'',\\preceq_F'',w_F''\\right)','\\mathfrak{RZ}_F''=\\left(\\mathcal E_F'',\\blacktriangleright_F'',\\preceq_F'',w_F''\\right)','Zielstruktur des Isomorphismus.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1049');


UPDATE equations
SET section_id=@section_id,title='Raum-Zeit-Isomorphismus',equation_latex='\\Phi_F:\\mathcal E_F\\to\\mathcal E_F''',word_latex='\\Phi_F:\\mathcal E_F\\to\\mathcal E_F''',
    plain_description='Bijektive Ereignisabbildung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1050';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1050',@section_id,'Raum-Zeit-Isomorphismus','\\Phi_F:\\mathcal E_F\\to\\mathcal E_F''','\\Phi_F:\\mathcal E_F\\to\\mathcal E_F''','Bijektive Ereignisabbildung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1050');


UPDATE equations
SET section_id=@section_id,title='Erhaltung der Nachbarschaft',equation_latex='\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\blacktriangleright_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)',word_latex='\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\blacktriangleright_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)',
    plain_description='Isomorphe Erhaltung unmittelbarer Übergänge.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1051';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1051',@section_id,'Erhaltung der Nachbarschaft','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\blacktriangleright_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\blacktriangleright_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)','Isomorphe Erhaltung unmittelbarer Übergänge.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1051');


UPDATE equations
SET section_id=@section_id,title='Erhaltung der Vorordnung',equation_latex='\\varepsilon_F^{(i)}\\preceq_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\preceq_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)',word_latex='\\varepsilon_F^{(i)}\\preceq_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\preceq_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)',
    plain_description='Isomorphe Erhaltung zeitlicher Ordnung.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1052';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1052',@section_id,'Erhaltung der Vorordnung','\\varepsilon_F^{(i)}\\preceq_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\preceq_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)','\\varepsilon_F^{(i)}\\preceq_F\\varepsilon_F^{(j)}\\Longleftrightarrow\\Phi_F\\left(\\varepsilon_F^{(i)}\\right)\\preceq_F''\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)','Isomorphe Erhaltung zeitlicher Ordnung.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1052');


UPDATE equations
SET section_id=@section_id,title='Erhaltung der Gewichtung',equation_latex='w_F\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=w_F''\\left(\\Phi_F\\left(\\varepsilon_F^{(i)}\\right),\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)',word_latex='w_F\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=w_F''\\left(\\Phi_F\\left(\\varepsilon_F^{(i)}\\right),\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)',
    plain_description='Gewichtserhaltung bei gewichteten Isomorphismen.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1053';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1053',@section_id,'Erhaltung der Gewichtung','w_F\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=w_F''\\left(\\Phi_F\\left(\\varepsilon_F^{(i)}\\right),\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)','w_F\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)=w_F''\\left(\\Phi_F\\left(\\varepsilon_F^{(i)}\\right),\\Phi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)','Gewichtserhaltung bei gewichteten Isomorphismen.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1053');


UPDATE equations
SET section_id=@section_id,title='Physikalische Interpretationsabbildung',equation_latex='\\chi_F:\\mathcal E_F\\to M',word_latex='\\chi_F:\\mathcal E_F\\to M',
    plain_description='Abbildung funktionaler Ereignisse in eine physikalische Raumzeitmannigfaltigkeit.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1054';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1054',@section_id,'Physikalische Interpretationsabbildung','\\chi_F:\\mathcal E_F\\to M','\\chi_F:\\mathcal E_F\\to M','Abbildung funktionaler Ereignisse in eine physikalische Raumzeitmannigfaltigkeit.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1054');


UPDATE equations
SET section_id=@section_id,title='Zuordnung funktionaler und physikalischer Abstände',equation_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\longmapsto d_M\\left(\\chi_F\\left(\\varepsilon_F^{(i)}\\right),\\chi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)',word_latex='d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\longmapsto d_M\\left(\\chi_F\\left(\\varepsilon_F^{(i)}\\right),\\chi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)',
    plain_description='Mögliche spätere empirische Korrespondenz.',equation_type='definition',provenance='original',
    source_id=NULL,derivation='Rekonstruktion in Abschnitt 3.4.10.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
    validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.1055';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.1055',@section_id,'Zuordnung funktionaler und physikalischer Abstände','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\longmapsto d_M\\left(\\chi_F\\left(\\varepsilon_F^{(i)}\\right),\\chi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)','d_{RZ,F}\\left(\\varepsilon_F^{(i)},\\varepsilon_F^{(j)}\\right)\\longmapsto d_M\\left(\\chi_F\\left(\\varepsilon_F^{(i)}\\right),\\chi_F\\left(\\varepsilon_F^{(j)}\\right)\\right)','Mögliche spätere empirische Korrespondenz.','definition','original',NULL,
       'Rekonstruktion in Abschnitt 3.4.10.',
       'Die funktionalen Zustands-, Kohärenz-, Raum- und Zeitstrukturen der Abschnitte 3.4.6 bis 3.4.9 werden vorausgesetzt.',
       'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.1055');


DELETE FROM definitions
WHERE definition_number IN (
'Definition 3.4.50','Definition 3.4.51','Definition 3.4.52','Definition 3.4.53',
'Definition 3.4.54','Definition 3.4.55','Definition 3.4.56','Definition 3.4.57',
'Definition 3.4.58','Definition 3.4.59','Definition 3.4.60','Definition 3.4.61',
'Definition 3.4.62');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.50',@section_id,'Funktionales Raum-Zeit-Ereignis','Ein funktionales Raum-Zeit-Ereignis verbindet einen funktionalen Zustand mit seiner konkreten Zustandsinstanz innerhalb eines Entwicklungspfads.','\\varepsilon_F^{(k)}=\\left(z_F^{(k)},\\zeta_F^{(k)}\\right)','\\varepsilon_F^{(k)}=\\left(z_F^{(k)},\\zeta_F^{(k)}\\right)','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.51',@section_id,'Unmittelbare funktionale Raum-Zeit-Nachbarschaft','Zwei Ereignisse sind unmittelbar funktional raum-zeitlich benachbart, wenn ihre Zustände unmittelbar funktional aufeinanderfolgen und ihre Instanzindizes sich um eins unterscheiden.','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}','\\varepsilon_F^{(i)}\\blacktriangleright_F\\varepsilon_F^{(j)}','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.52',@section_id,'Funktionaler Raum-Zeit-Pfad','Ein funktionaler Raum-Zeit-Pfad ist eine endliche Folge unmittelbar benachbarter funktionaler Raum-Zeit-Ereignisse.','\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\ldots,\\varepsilon_F^{(n)}\\right)','\\Gamma_F^{(n)}=\\left(\\varepsilon_F^{(0)},\\ldots,\\varepsilon_F^{(n)}\\right)','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.53',@section_id,'Gewichtete funktionale Raum-Zeit-Pfadlänge','Die gewichtete Raum-Zeit-Pfadlänge ist die Summe der Gewichte aller Operatorwirkungen entlang eines Raum-Zeit-Pfads.','L_F^{w}(\\Gamma_F^{(n)})=\\sum_{k=0}^{n-1}w_F(O_{F,k+1},z_F^{(k)})','L_F^{w}(\\Gamma_F^{(n)})=\\sum_{k=0}^{n-1}w_F(O_{F,k+1},z_F^{(k)})','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.54',@section_id,'Funktionale Raum-Zeit-Struktur','Eine funktionale Raum-Zeit-Struktur vereinigt Ereignismenge, gerichtete Nachbarschaft, Erreichbarkeit, Vorordnung und optionale Übergangsgewichtung.','\\mathfrak{RZ}_F=(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F,w_F)','\\mathfrak{RZ}_F=(\\mathcal E_F,\\blacktriangleright_F,\\leadsto_F,\\preceq_F,w_F)','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.55',@section_id,'Gerichteter funktionaler Raum-Zeit-Abstand','Der gerichtete funktionale Raum-Zeit-Abstand ist das Infimum der gewichteten Längen aller gerichteten Raum-Zeit-Pfade zwischen zwei Ereignissen.','d_{RZ,F}(\\varepsilon_i,\\varepsilon_j)=\\inf_{\\Gamma_F}L_F^w(\\Gamma_F)','d_{RZ,F}(\\varepsilon_i,\\varepsilon_j)=\\inf_{\\Gamma_F}L_F^w(\\Gamma_F)','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.56',@section_id,'Funktionaler Zukunftskegel','Der funktionale Zukunftskegel enthält alle Ereignisse, die funktional nach einem gegebenen Ereignis liegen.','J_F^+(\\varepsilon_F)=\\{\\varepsilon_F''\\in\\mathcal E_F\\mid\\varepsilon_F\\preceq_F\\varepsilon_F''\\}','J_F^+(\\varepsilon_F)=\\{\\varepsilon_F''\\in\\mathcal E_F\\mid\\varepsilon_F\\preceq_F\\varepsilon_F''\\}','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.57',@section_id,'Funktionaler Vergangenheitskegel','Der funktionale Vergangenheitskegel enthält alle Ereignisse, die funktional vor einem gegebenen Ereignis liegen.','J_F^-(\\varepsilon_F)=\\{\\varepsilon_F''\\in\\mathcal E_F\\mid\\varepsilon_F''\\preceq_F\\varepsilon_F\\}','J_F^-(\\varepsilon_F)=\\{\\varepsilon_F''\\in\\mathcal E_F\\mid\\varepsilon_F''\\preceq_F\\varepsilon_F\\}','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.58',@section_id,'Funktionale Gleichzeitigkeit','Zwei Ereignisse sind funktional gleichzeitig, wenn sie zu demselben funktionalen Zeitschnitt gehören und funktional unvergleichbar sind.','\\varepsilon_F^{(i)}\\sim_{\\tau_F}\\varepsilon_F^{(j)}','\\varepsilon_F^{(i)}\\sim_{\\tau_F}\\varepsilon_F^{(j)}','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.59',@section_id,'Kohärenter funktionaler Raum-Zeit-Pfad','Ein Raum-Zeit-Pfad ist kohärent, wenn jeder Übergang durch einen kohärenzerhaltenden Operator erzeugt wird und alle Zustände kohärent bleiben.','O_{F,k}\\in\\mathcal O_F^K(\\mathcal S)','O_{F,k}\\in\\mathcal O_F^K(\\mathcal S)','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.60',@section_id,'Lokale funktionale Raum-Zeit-Struktur','Eine lokale funktionale Raum-Zeit-Struktur ist die Einschränkung einer Raum-Zeit-Struktur auf eine ausgewählte lokale Ereignismenge.','\\mathfrak{RZ}_F^{\\mathrm{lok}}=\\mathfrak{RZ}_F|_{\\mathcal E_F^{\\mathrm{lok}}}','\\mathfrak{RZ}_F^{\\mathrm{lok}}=\\mathfrak{RZ}_F|_{\\mathcal E_F^{\\mathrm{lok}}}','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.61',@section_id,'Globale funktionale Raum-Zeit-Struktur','Die globale funktionale Raum-Zeit-Struktur ist die Vereinigung aller lokalen Ereigniskomponenten und ihrer zulässigen Übergänge.','\\mathfrak{RZ}_F^{\\mathrm{glob}}=\\bigcup_{\\alpha\\in A}\\mathfrak{RZ}_{F,\\alpha}^{\\mathrm{lok}}','\\mathfrak{RZ}_F^{\\mathrm{glob}}=\\bigcup_{\\alpha\\in A}\\mathfrak{RZ}_{F,\\alpha}^{\\mathrm{lok}}','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES ('Definition 3.4.62',@section_id,'Funktionaler Raum-Zeit-Isomorphismus','Ein funktionaler Raum-Zeit-Isomorphismus ist eine bijektive Abbildung, welche Nachbarschaft, Vorordnung und gegebenenfalls Übergangsgewichte erhält.','\\Phi_F:\\mathcal E_F\\to\\mathcal E_F''','\\Phi_F:\\mathcal E_F\\to\\mathcal E_F''','original',NULL,
        'Abschnitte 3.4.6 bis 3.4.9.','FRZK-spezifische Rekonstruktion.','checked',@revision_id);


DELETE FROM lemmas
WHERE lemma_number IN ('Lemma 3.4.17','Lemma 3.4.18','Lemma 3.4.19');

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.17',@section_id,'Gerichtete Raum-Zeit-Nachbarschaft','Aus einer unmittelbaren funktionalen Raum-Zeit-Nachbarschaft folgt im Allgemeinen nicht ihre Umkehrung.','\\varepsilon_i\\blacktriangleright_F\\varepsilon_j\\nRightarrow\\varepsilon_j\\blacktriangleright_F\\varepsilon_i','\\varepsilon_i\\blacktriangleright_F\\varepsilon_j\\nRightarrow\\varepsilon_j\\blacktriangleright_F\\varepsilon_i','original',NULL,'Definition 3.4.51.','checked',@revision_id),
('Lemma 3.4.18',@section_id,'Dreiecksungleichung des gerichteten Raum-Zeit-Abstands','Der gerichtete funktionale Raum-Zeit-Abstand erfüllt die Dreiecksungleichung.','d_{RZ,F}(\\varepsilon_i,\\varepsilon_k)\\leq d_{RZ,F}(\\varepsilon_i,\\varepsilon_j)+d_{RZ,F}(\\varepsilon_j,\\varepsilon_k)','d_{RZ,F}(\\varepsilon_i,\\varepsilon_k)\\leq d_{RZ,F}(\\varepsilon_i,\\varepsilon_j)+d_{RZ,F}(\\varepsilon_j,\\varepsilon_k)','adapted',@source_diestel,'Definition 3.4.55 und additive Pfadlängen.','checked',@revision_id),
('Lemma 3.4.19',@section_id,'Abhängigkeit funktionaler Gleichzeitigkeit vom Zeitschnitt','Die Zuordnung funktional unvergleichbarer Ereignisse zu einem gemeinsamen Zeitschnitt ist im Allgemeinen nicht eindeutig.','\\varepsilon_i\\parallel_F\\varepsilon_j','\\varepsilon_i\\parallel_F\\varepsilon_j','adapted',@source_dummit,'Partielle Ordnung und Antiketten.','checked',@revision_id);

DELETE FROM theorems
WHERE theorem_number IN ('Satz 3.4.18','Satz 3.4.19','Satz 3.4.20','Satz 3.4.21');

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.18',@section_id,'Existenz einer funktionalen Raum-Zeit-Struktur','Ein kohärenter Zustandsraum mit mindestens einem nichtidentischen kohärenzerhaltenden Übergang besitzt mindestens eine nichttriviale funktionale Raum-Zeit-Struktur.','z_F^{(0)}\\prec_F z_F^{(1)}\\Longrightarrow\\exists\\mathfrak{RZ}_F','z_F^{(0)}\\prec_F z_F^{(1)}\\Longrightarrow\\exists\\mathfrak{RZ}_F','original',NULL,'Definitionen 3.4.50 bis 3.4.54.','checked',@revision_id),
('Satz 3.4.19',@section_id,'Quasimetrische Struktur','Bei positiven Übergangsgewichten bildet der gerichtete Raum-Zeit-Abstand auf stark zusammenhängenden Ereigniskomponenten eine Quasimetrik.','(\\mathcal E_F,d_{RZ,F})','(\\mathcal E_F,d_{RZ,F})','adapted',@source_diestel,'Definition 3.4.55 und Lemma 3.4.18.','checked',@revision_id),
('Satz 3.4.20',@section_id,'Kohärenzerhaltung entlang funktionaler Raum-Zeit-Pfade','Sind alle Operatoren eines Raum-Zeit-Pfades kohärenzerhaltend und ist der Ausgangszustand kohärent, dann bleiben sämtliche Pfadzustände kohärent.','z_F^{(0)}\\in\\Omega_F^K\\land O_{F,k}\\in\\mathcal O_F^K\\Longrightarrow z_F^{(k)}\\in\\Omega_F^K','z_F^{(0)}\\in\\Omega_F^K\\land O_{F,k}\\in\\mathcal O_F^K\\Longrightarrow z_F^{(k)}\\in\\Omega_F^K','original',NULL,'Definition 3.4.59.','checked',@revision_id),
('Satz 3.4.21',@section_id,'Invarianz funktionaler Raum-Zeit-Eigenschaften','Unter einem funktionalen Raum-Zeit-Isomorphismus bleiben Erreichbarkeit, Vorordnung, Zyklizität, Azyklizität, Pfadlänge und Kohärenzzusammenhang erhalten.','\\mathfrak{RZ}_F\\cong\\mathfrak{RZ}_F''','\\mathfrak{RZ}_F\\cong\\mathfrak{RZ}_F''','adapted',@source_dummit,'Definition 3.4.62.','checked',@revision_id);

SELECT lemma_id INTO @lemma_3417 FROM lemmas WHERE lemma_number='Lemma 3.4.17' LIMIT 1;
SELECT lemma_id INTO @lemma_3418 FROM lemmas WHERE lemma_number='Lemma 3.4.18' LIMIT 1;
SELECT lemma_id INTO @lemma_3419 FROM lemmas WHERE lemma_number='Lemma 3.4.19' LIMIT 1;
SELECT theorem_id INTO @satz_3418 FROM theorems WHERE theorem_number='Satz 3.4.18' LIMIT 1;
SELECT theorem_id INTO @satz_3419 FROM theorems WHERE theorem_number='Satz 3.4.19' LIMIT 1;
SELECT theorem_id INTO @satz_3420 FROM theorems WHERE theorem_number='Satz 3.4.20' LIMIT 1;
SELECT theorem_id INTO @satz_3421 FROM theorems WHERE theorem_number='Satz 3.4.21' LIMIT 1;

DELETE FROM corollaries
WHERE corollary_number IN ('Korollar 3.4.14','Korollar 3.4.15','Korollar 3.4.16');

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.14',@section_id,'Gemeinsamer Ursprung von Raum und Zeit','Jeder nichtidentische kohärenzerhaltende Übergang erzeugt zugleich funktionale Nachbarschaft und funktionale Nachfolge.','\\text{Operatorwirkung}\\Longrightarrow\\text{Raum und Zeit}', '\\text{Operatorwirkung}\\Longrightarrow\\text{Raum und Zeit}',@satz_3418,NULL,'original',NULL,'checked',@revision_id),
('Korollar 3.4.15',@section_id,'Lokale Begrenzung funktionaler Zukunft','Bei endlicher lokaler Operatorenmenge und deterministischer Operatorwirkung ist die Menge unmittelbarer funktionaler Nachfolger endlich und durch die Zahl der Operatoren begrenzt.','|\\operatorname{Succ}_F(\\varepsilon_F)|\\leq|\\mathcal O_F^K(\\varepsilon_F)|','|\\operatorname{Succ}_F(\\varepsilon_F)|\\leq|\\mathcal O_F^K(\\varepsilon_F)|',NULL,NULL,'original',NULL,'checked',@revision_id),
('Korollar 3.4.16',@section_id,'Kohärente Raum-Zeit-Komponente','Alle von einem kohärenten Ausgangsereignis ausschließlich über kohärenzerhaltende Operatoren erreichbaren Ereignisse bilden eine kohärente Raum-Zeit-Komponente.','\\mathcal C_{RZ,F}^{K}(\\varepsilon_F^{(0)})','\\mathcal C_{RZ,F}^{K}(\\varepsilon_F^{(0)})',@satz_3420,NULL,'original',NULL,'checked',@revision_id);

SELECT corollary_id INTO @kor_3414 FROM corollaries WHERE corollary_number='Korollar 3.4.14' LIMIT 1;
SELECT corollary_id INTO @kor_3415 FROM corollaries WHERE corollary_number='Korollar 3.4.15' LIMIT 1;
SELECT corollary_id INTO @kor_3416 FROM corollaries WHERE corollary_number='Korollar 3.4.16' LIMIT 1;

DELETE FROM proofs WHERE proof_number LIKE 'Bew. 3.4.10-R%';

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.10-R1',@section_id,NULL,@lemma_3417,NULL,'Beweis zu Lemma 3.4.17','Die Indexbedingungen j=i+1 und i=j+1 können nicht zugleich gelten; außerdem folgt aus einem Hinoperator kein Rückoperator.','j=i+1\\nRightarrow i=j+1','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.10-R2',@section_id,@satz_3418,NULL,NULL,'Beweis zu Satz 3.4.18','Ein nichtidentischer Übergang erzeugt zwei unterscheidbare Ereignisse und eine gerichtete Nachbarschaft zwischen ihnen.','\\varepsilon_F^{(0)}\\blacktriangleright_F\\varepsilon_F^{(1)}','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.10-R3',@section_id,NULL,NULL,@kor_3414,'Begründung zu Korollar 3.4.14','Dieselbe Operatorwirkung erzeugt sowohl die Zustandsverbindung als auch deren gerichtete Instanzfolge.','O_F:z_i\\mapsto z_j','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.10-R4',@section_id,NULL,@lemma_3418,NULL,'Beweis zu Lemma 3.4.18','Zwei Pfade über ein Zwischenereignis können verkettet werden; die Länge der Verkettung ist die Summe der Teillängen.','L(\\Gamma_{ik})\\leq L(\\Gamma_{ij})+L(\\Gamma_{jk})','direct','adapted',@source_diestel,'checked',@revision_id),
('Bew. 3.4.10-R5',@section_id,@satz_3419,NULL,NULL,'Beweis zu Satz 3.4.19','Nichtnegativität, Definitheit und Dreiecksungleichung gelten; Symmetrie wird wegen der gerichteten Übergangsstruktur nicht verlangt.','d(x,y)\\neq d(y,x)','direct','adapted',@source_diestel,'checked',@revision_id),
('Bew. 3.4.10-R6',@section_id,NULL,NULL,@kor_3415,'Begründung zu Korollar 3.4.15','Jeder deterministische lokale Operator erzeugt höchstens einen unmittelbaren Nachfolger.','|\\operatorname{Succ}_F|\\leq|\\mathcal O_F^K|','other','original',NULL,'checked',@revision_id),
('Bew. 3.4.10-R7',@section_id,NULL,@lemma_3419,NULL,'Begründung zu Lemma 3.4.19','Partielle Ordnungen können mehrere Antiketten enthalten, denen dasselbe Ereignis angehört.','\\Sigma_F^{(1)}\\neq\\Sigma_F^{(2)}','other','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.10-R8',@section_id,@satz_3420,NULL,NULL,'Beweis zu Satz 3.4.20','Durch vollständige Induktion folgt aus einem kohärenten Ausgangszustand und kohärenzerhaltenden Operatoren die Kohärenz jedes Folgezustands.','z_k\\in\\Omega_F^K\\Longrightarrow z_{k+1}\\in\\Omega_F^K','induction','original',NULL,'checked',@revision_id),
('Bew. 3.4.10-R9',@section_id,NULL,NULL,@kor_3416,'Begründung zu Korollar 3.4.16','Die Menge aller ausschließlich kohärenzerhaltend erreichbaren Ereignisse ist unter den zugelassenen Übergängen kohärent abgeschlossen.','\\mathcal C_{RZ,F}^{K}(\\varepsilon_0)','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.10-R10',@section_id,@satz_3421,NULL,NULL,'Beweis zu Satz 3.4.21','Ein Isomorphismus erhält die definierenden Relationen und Gewichte; alle ausschließlich daraus bestimmten Struktureigenschaften bleiben daher invariant.','\\Phi_F:\\mathfrak{RZ}_F\\cong\\mathfrak{RZ}_F''','equivalence','adapted',@source_dummit,'checked',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_dummit,@section_id,'background',
       'Ordnungen, Isomorphismen, Antiketten und strukturelle Invarianz als mathematische Grundlage.',
       '3.4.10.8 bis 3.4.10.13',0,1,'Bestandsquelle [31].',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id=@source_dummit AND section_id=@section_id
      AND exact_location='3.4.10.8 bis 3.4.10.13'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_diestel,@section_id,'background',
       'Gerichtete Pfade, Erreichbarkeit, Zusammenhang und kürzeste Pfade als graphentheoretische Grundlage.',
       '3.4.10.3 bis 3.4.10.7',0,1,'Bestandsquelle [47].',@revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id=@source_diestel AND section_id=@section_id
      AND exact_location='3.4.10.3 bis 3.4.10.7'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'rewritten','section','3.4.10',
       'Abschnitt 3.4.10 vollständig neu gefasst.',
       'Frühere oder fehlende Fassung',
       'Funktionale Raum-Zeit-Ereignisse, Pfade, Abstände, Kegel, Gleichzeitigkeit, Kohärenz und Isomorphie'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_reference='3.4.10'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section','3.4.10')
ON DUPLICATE KEY UPDATE counter_value='3.4.10';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-REV-K3.4.10-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-REV-K3.4.10-V1';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('next_equation_number','3.1056')
ON DUPLICATE KEY UPDATE counter_value='3.1056';

COMMIT;

/* Audit */
SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.4.10';
SELECT revision_id,revision_code,scope_reference,version_label FROM repository_revisions WHERE revision_code=@revision_code;
SELECT COUNT(*) AS equations_3_987_to_3_1055
FROM equations
WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 987 AND 1055;
SELECT COUNT(*) AS definitions_3_4_50_to_3_4_62 FROM definitions WHERE section_id=@section_id;
SELECT COUNT(*) AS lemmas_3_4_17_to_3_4_19 FROM lemmas WHERE section_id=@section_id;
SELECT COUNT(*) AS theorems_3_4_18_to_3_4_21 FROM theorems WHERE section_id=@section_id;
SELECT COUNT(*) AS corollaries_3_4_14_to_3_4_16 FROM corollaries WHERE section_id=@section_id;
SELECT COUNT(*) AS proofs_3_4_10 FROM proofs WHERE section_id=@section_id AND proof_number LIKE 'Bew. 3.4.10-R%';
SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN ('last_completed_section','last_repository_revision','next_equation_number')
ORDER BY counter_key;
