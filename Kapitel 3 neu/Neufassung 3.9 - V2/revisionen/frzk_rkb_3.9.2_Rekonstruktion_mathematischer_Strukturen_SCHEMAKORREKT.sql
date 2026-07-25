/* ============================================================================
   FRZK-Repository – Kapitel 3.9.2
   Rekonstruktion mathematischer Strukturen

   Schema-Grundlage: frzk_rkb(3).sql
   Zielsystem: MariaDB 10.4.x
   - keine temporären Tabellen
   - keine MEMORY-Engine
   - ausschließlich vorhandene Tabellen, Spalten und ENUM-Werte
   - idempotente Anlage
   - Gleichungen 3.439 bis 3.460
   ============================================================================ */

START TRANSACTION;

SET @parent_revision_id := (
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='3.9.1' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT '3.9.2',NOW(),'section','3.9.2','Kapitel 3.9.2',
       'Rekonstruktion der mathematischen Strukturen des Funktionalen Raum-Zeit-Kohärenzsystems.',
       'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='3.9.2');

SET @revision_id := (SELECT revision_id FROM repository_revisions WHERE revision_code='3.9.2' LIMIT 1);
SET @chapter_39_id := (SELECT section_id FROM dissertation_sections WHERE section_code='3.9' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @chapter_39_id,'3.9.2','Rekonstruktion mathematischer Strukturen',3,9.0200,'draft',1,
       'Führt Mengen, Relationen, Graphen, Matrizen, Zustandsvektoren, Operatoren, Trajektorien und Kohärenz zu einem gemeinsamen mathematischen Rahmen zusammen.'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.9.2');

UPDATE dissertation_sections
SET parent_section_id=@chapter_39_id,
    title='Rekonstruktion mathematischer Strukturen',chapter_no=3,section_order=9.0200,
    status='draft',is_original_contribution=1,
    notes='Führt Mengen, Relationen, Graphen, Matrizen, Zustandsvektoren, Operatoren, Trajektorien und Kohärenz zu einem gemeinsamen mathematischen Rahmen zusammen.'
WHERE section_code='3.9.2';

SET @section_id := (SELECT section_id FROM dissertation_sections WHERE section_code='3.9.2' LIMIT 1);

/* 3.439 – Menge funktionaler Einheiten */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.439',@section_id,'Menge funktionaler Einheiten','F=\\{f_1,f_2,\\ldots,f_n\\}','F=\\{f_1,f_2,\\ldots,f_n\\}','Menge der funktional unterscheidbaren Einheiten.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.439');

UPDATE equations
SET section_id=@section_id,title='Menge funktionaler Einheiten',equation_latex='F=\\{f_1,f_2,\\ldots,f_n\\}',word_latex='F=\\{f_1,f_2,\\ldots,f_n\\}',
    plain_description='Menge der funktional unterscheidbaren Einheiten.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.439';

/* 3.440 – Funktionale Relationsstruktur */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.440',@section_id,'Funktionale Relationsstruktur','R\\subseteq F\\times F','R\\subseteq F\\times F','Relation zwischen funktionalen Einheiten.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.440');

UPDATE equations
SET section_id=@section_id,title='Funktionale Relationsstruktur',equation_latex='R\\subseteq F\\times F',word_latex='R\\subseteq F\\times F',
    plain_description='Relation zwischen funktionalen Einheiten.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.440';

/* 3.441 – Gewichtungsabbildung */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.441',@section_id,'Gewichtungsabbildung','w:R\\rightarrow\\mathbb{R}','w:R\\rightarrow\\mathbb{R}','Zuordnung reeller Gewichte zu funktionalen Relationen.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.441');

UPDATE equations
SET section_id=@section_id,title='Gewichtungsabbildung',equation_latex='w:R\\rightarrow\\mathbb{R}',word_latex='w:R\\rightarrow\\mathbb{R}',
    plain_description='Zuordnung reeller Gewichte zu funktionalen Relationen.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.441';

/* 3.442 – Gewichteter funktionaler Graph */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.442',@section_id,'Gewichteter funktionaler Graph','G=(F,R,w)','G=(F,R,w)','Graphische Zusammenfassung funktionaler Einheiten, Relationen und Gewichtungen.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.442');

UPDATE equations
SET section_id=@section_id,title='Gewichteter funktionaler Graph',equation_latex='G=(F,R,w)',word_latex='G=(F,R,w)',
    plain_description='Graphische Zusammenfassung funktionaler Einheiten, Relationen und Gewichtungen.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.442';

/* 3.443 – Adjazenzmatrix */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.443',@section_id,'Adjazenzmatrix','A=\\begin{pmatrix}a_{11}&a_{12}&\\cdots&a_{1n}\\\\a_{21}&a_{22}&\\cdots&a_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\a_{n1}&a_{n2}&\\cdots&a_{nn}\\end{pmatrix}','A=\\begin{pmatrix}a_{11}&a_{12}&\\cdots&a_{1n}\\\\a_{21}&a_{22}&\\cdots&a_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\a_{n1}&a_{n2}&\\cdots&a_{nn}\\end{pmatrix}','Matrixdarstellung der gewichteten Relationsstruktur.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.443');

UPDATE equations
SET section_id=@section_id,title='Adjazenzmatrix',equation_latex='A=\\begin{pmatrix}a_{11}&a_{12}&\\cdots&a_{1n}\\\\a_{21}&a_{22}&\\cdots&a_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\a_{n1}&a_{n2}&\\cdots&a_{nn}\\end{pmatrix}',word_latex='A=\\begin{pmatrix}a_{11}&a_{12}&\\cdots&a_{1n}\\\\a_{21}&a_{22}&\\cdots&a_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\a_{n1}&a_{n2}&\\cdots&a_{nn}\\end{pmatrix}',
    plain_description='Matrixdarstellung der gewichteten Relationsstruktur.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.443';

/* 3.444 – Einträge der Adjazenzmatrix */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.444',@section_id,'Einträge der Adjazenzmatrix','a_{ij}=\\begin{cases}w(f_i,f_j),&\\text{falls }(f_i,f_j)\\in R,\\\\0,&\\text{falls }(f_i,f_j)\\notin R.\\end{cases}','a_{ij}=\\begin{cases}w(f_i,f_j),&\\text{falls }(f_i,f_j)\\in R,\\\\0,&\\text{falls }(f_i,f_j)\\notin R.\\end{cases}','Definition der Matrixeinträge aus der gewichteten Relation.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.444');

UPDATE equations
SET section_id=@section_id,title='Einträge der Adjazenzmatrix',equation_latex='a_{ij}=\\begin{cases}w(f_i,f_j),&\\text{falls }(f_i,f_j)\\in R,\\\\0,&\\text{falls }(f_i,f_j)\\notin R.\\end{cases}',word_latex='a_{ij}=\\begin{cases}w(f_i,f_j),&\\text{falls }(f_i,f_j)\\in R,\\\\0,&\\text{falls }(f_i,f_j)\\notin R.\\end{cases}',
    plain_description='Definition der Matrixeinträge aus der gewichteten Relation.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.444';

/* 3.445 – Funktionaler Zustandsvektor */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.445',@section_id,'Funktionaler Zustandsvektor','\\mathbf{z}_t=\\begin{pmatrix}z_1(t)\\\\z_2(t)\\\\\\vdots\\\\z_n(t)\\end{pmatrix}','\\mathbf{z}_t=\\begin{pmatrix}z_1(t)\\\\z_2(t)\\\\\\vdots\\\\z_n(t)\\end{pmatrix}','Vektordarstellung des funktionalen Systemzustands.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.445');

UPDATE equations
SET section_id=@section_id,title='Funktionaler Zustandsvektor',equation_latex='\\mathbf{z}_t=\\begin{pmatrix}z_1(t)\\\\z_2(t)\\\\\\vdots\\\\z_n(t)\\end{pmatrix}',word_latex='\\mathbf{z}_t=\\begin{pmatrix}z_1(t)\\\\z_2(t)\\\\\\vdots\\\\z_n(t)\\end{pmatrix}',
    plain_description='Vektordarstellung des funktionalen Systemzustands.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.445';

/* 3.446 – Lineare Zustandsentwicklung */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.446',@section_id,'Lineare Zustandsentwicklung','\\mathbf{z}_{t+1}=A_t\\mathbf{z}_t','\\mathbf{z}_{t+1}=A_t\\mathbf{z}_t','Lineare Abbildung eines Zustands auf seinen Folgezustand.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.446');

UPDATE equations
SET section_id=@section_id,title='Lineare Zustandsentwicklung',equation_latex='\\mathbf{z}_{t+1}=A_t\\mathbf{z}_t',word_latex='\\mathbf{z}_{t+1}=A_t\\mathbf{z}_t',
    plain_description='Lineare Abbildung eines Zustands auf seinen Folgezustand.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.446';

/* 3.447 – Allgemeiner Zustandsoperator */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.447',@section_id,'Allgemeiner Zustandsoperator','\\mathcal{O}_t:\\mathcal{Z}\\rightarrow\\mathcal{Z}','\\mathcal{O}_t:\\mathcal{Z}\\rightarrow\\mathcal{Z}','Operator auf dem zulässigen funktionalen Zustandsraum.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.447');

UPDATE equations
SET section_id=@section_id,title='Allgemeiner Zustandsoperator',equation_latex='\\mathcal{O}_t:\\mathcal{Z}\\rightarrow\\mathcal{Z}',word_latex='\\mathcal{O}_t:\\mathcal{Z}\\rightarrow\\mathcal{Z}',
    plain_description='Operator auf dem zulässigen funktionalen Zustandsraum.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.447';

/* 3.448 – Nichtlineare Zustandsentwicklung */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.448',@section_id,'Nichtlineare Zustandsentwicklung','\\mathbf{z}_{t+1}=\\mathcal{O}_t(\\mathbf{z}_t)','\\mathbf{z}_{t+1}=\\mathcal{O}_t(\\mathbf{z}_t)','Allgemeine operatorische Zustandsentwicklung.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.448');

UPDATE equations
SET section_id=@section_id,title='Nichtlineare Zustandsentwicklung',equation_latex='\\mathbf{z}_{t+1}=\\mathcal{O}_t(\\mathbf{z}_t)',word_latex='\\mathbf{z}_{t+1}=\\mathcal{O}_t(\\mathbf{z}_t)',
    plain_description='Allgemeine operatorische Zustandsentwicklung.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.448';

/* 3.449 – Operatorenmenge */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.449',@section_id,'Operatorenmenge','\\Omega=\\{\\mathcal{O}_1,\\mathcal{O}_2,\\ldots,\\mathcal{O}_m\\}','\\Omega=\\{\\mathcal{O}_1,\\mathcal{O}_2,\\ldots,\\mathcal{O}_m\\}','Menge der im Modell zulässigen funktionalen Operatoren.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.449');

UPDATE equations
SET section_id=@section_id,title='Operatorenmenge',equation_latex='\\Omega=\\{\\mathcal{O}_1,\\mathcal{O}_2,\\ldots,\\mathcal{O}_m\\}',word_latex='\\Omega=\\{\\mathcal{O}_1,\\mathcal{O}_2,\\ldots,\\mathcal{O}_m\\}',
    plain_description='Menge der im Modell zulässigen funktionalen Operatoren.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.449';

/* 3.450 – Operatorenkaskade */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.450',@section_id,'Operatorenkaskade','\\mathcal{K}_n=\\mathcal{O}_n\\circ\\mathcal{O}_{n-1}\\circ\\cdots\\circ\\mathcal{O}_1','\\mathcal{K}_n=\\mathcal{O}_n\\circ\\mathcal{O}_{n-1}\\circ\\cdots\\circ\\mathcal{O}_1','Geordnete Komposition mehrerer funktionaler Operatoren.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.450');

UPDATE equations
SET section_id=@section_id,title='Operatorenkaskade',equation_latex='\\mathcal{K}_n=\\mathcal{O}_n\\circ\\mathcal{O}_{n-1}\\circ\\cdots\\circ\\mathcal{O}_1',word_latex='\\mathcal{K}_n=\\mathcal{O}_n\\circ\\mathcal{O}_{n-1}\\circ\\cdots\\circ\\mathcal{O}_1',
    plain_description='Geordnete Komposition mehrerer funktionaler Operatoren.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.450';

/* 3.451 – Kaskadierter Folgezustand */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.451',@section_id,'Kaskadierter Folgezustand','\\mathbf{z}_n=\\mathcal{K}_n(\\mathbf{z}_0)','\\mathbf{z}_n=\\mathcal{K}_n(\\mathbf{z}_0)','Anwendung der Operatorenkaskade auf den Ausgangszustand.','derived','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.451');

UPDATE equations
SET section_id=@section_id,title='Kaskadierter Folgezustand',equation_latex='\\mathbf{z}_n=\\mathcal{K}_n(\\mathbf{z}_0)',word_latex='\\mathbf{z}_n=\\mathcal{K}_n(\\mathbf{z}_0)',
    plain_description='Anwendung der Operatorenkaskade auf den Ausgangszustand.',equation_type='derived',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.451';

/* 3.452 – Nichtkommutativität funktionaler Operatoren */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.452',@section_id,'Nichtkommutativität funktionaler Operatoren','\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i','\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i','Die Wirkung einer Operatorenfolge hängt im Allgemeinen von ihrer Reihenfolge ab.','derived','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.452');

UPDATE equations
SET section_id=@section_id,title='Nichtkommutativität funktionaler Operatoren',equation_latex='\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i',word_latex='\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i',
    plain_description='Die Wirkung einer Operatorenfolge hängt im Allgemeinen von ihrer Reihenfolge ab.',equation_type='derived',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.452';

/* 3.453 – Zeitabhängige Relationsmatrix */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.453',@section_id,'Zeitabhängige Relationsmatrix','A=A(t)','A=A(t)','Zeit- beziehungsweise schrittabhängige Relationsstruktur.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.453');

UPDATE equations
SET section_id=@section_id,title='Zeitabhängige Relationsmatrix',equation_latex='A=A(t)',word_latex='A=A(t)',
    plain_description='Zeit- beziehungsweise schrittabhängige Relationsstruktur.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.453';

/* 3.454 – Gekoppelte Zustandsentwicklung */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.454',@section_id,'Gekoppelte Zustandsentwicklung','\\mathbf{z}_{t+1}=\\mathcal{O}\\bigl(\\mathbf{z}_t,A_t\\bigr)','\\mathbf{z}_{t+1}=\\mathcal{O}\\bigl(\\mathbf{z}_t,A_t\\bigr)','Zustandsentwicklung in Abhängigkeit von Zustand und Relationsstruktur.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.454');

UPDATE equations
SET section_id=@section_id,title='Gekoppelte Zustandsentwicklung',equation_latex='\\mathbf{z}_{t+1}=\\mathcal{O}\\bigl(\\mathbf{z}_t,A_t\\bigr)',word_latex='\\mathbf{z}_{t+1}=\\mathcal{O}\\bigl(\\mathbf{z}_t,A_t\\bigr)',
    plain_description='Zustandsentwicklung in Abhängigkeit von Zustand und Relationsstruktur.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.454';

/* 3.455 – Gekoppelte Relationsentwicklung */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.455',@section_id,'Gekoppelte Relationsentwicklung','A_{t+1}=\\mathcal{R}\\bigl(A_t,\\mathbf{z}_t\\bigr)','A_{t+1}=\\mathcal{R}\\bigl(A_t,\\mathbf{z}_t\\bigr)','Veränderung der Relationsstruktur in Abhängigkeit von Relation und Zustand.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.455');

UPDATE equations
SET section_id=@section_id,title='Gekoppelte Relationsentwicklung',equation_latex='A_{t+1}=\\mathcal{R}\\bigl(A_t,\\mathbf{z}_t\\bigr)',word_latex='A_{t+1}=\\mathcal{R}\\bigl(A_t,\\mathbf{z}_t\\bigr)',
    plain_description='Veränderung der Relationsstruktur in Abhängigkeit von Relation und Zustand.',equation_type='model',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.455';

/* 3.456 – Funktionale Trajektorie */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.456',@section_id,'Funktionale Trajektorie','\\Gamma(\\mathbf{z}_0)=\\{\\mathbf{z}_0,\\mathbf{z}_1,\\mathbf{z}_2,\\ldots\\}','\\Gamma(\\mathbf{z}_0)=\\{\\mathbf{z}_0,\\mathbf{z}_1,\\mathbf{z}_2,\\ldots\\}','Folge der aus einem Ausgangszustand hervorgehenden Systemzustände.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.456');

UPDATE equations
SET section_id=@section_id,title='Funktionale Trajektorie',equation_latex='\\Gamma(\\mathbf{z}_0)=\\{\\mathbf{z}_0,\\mathbf{z}_1,\\mathbf{z}_2,\\ldots\\}',word_latex='\\Gamma(\\mathbf{z}_0)=\\{\\mathbf{z}_0,\\mathbf{z}_1,\\mathbf{z}_2,\\ldots\\}',
    plain_description='Folge der aus einem Ausgangszustand hervorgehenden Systemzustände.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.456';

/* 3.457 – Fixpunktbedingung */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.457',@section_id,'Fixpunktbedingung','\\mathcal{O}(\\mathbf{z}^{*})=\\mathbf{z}^{*}','\\mathcal{O}(\\mathbf{z}^{*})=\\mathbf{z}^{*}','Bedingung eines unter dem Operator invarianten Zustands.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.457');

UPDATE equations
SET section_id=@section_id,title='Fixpunktbedingung',equation_latex='\\mathcal{O}(\\mathbf{z}^{*})=\\mathbf{z}^{*}',word_latex='\\mathcal{O}(\\mathbf{z}^{*})=\\mathbf{z}^{*}',
    plain_description='Bedingung eines unter dem Operator invarianten Zustands.',equation_type='definition',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.457';

/* 3.458 – Kohärenzmaß */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.458',@section_id,'Kohärenzmaß','\\kappa:\\mathcal{Z}\\times\\mathcal{A}\\rightarrow[0,1]','\\kappa:\\mathcal{Z}\\times\\mathcal{A}\\rightarrow[0,1]','Abbildung von Zustand und Relationsstruktur auf ein normiertes Kohärenzintervall.','metric','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.458');

UPDATE equations
SET section_id=@section_id,title='Kohärenzmaß',equation_latex='\\kappa:\\mathcal{Z}\\times\\mathcal{A}\\rightarrow[0,1]',word_latex='\\kappa:\\mathcal{Z}\\times\\mathcal{A}\\rightarrow[0,1]',
    plain_description='Abbildung von Zustand und Relationsstruktur auf ein normiertes Kohärenzintervall.',equation_type='metric',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.458';

/* 3.459 – Aktuelle funktionale Kohärenz */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.459',@section_id,'Aktuelle funktionale Kohärenz','\\kappa_t=\\kappa(\\mathbf{z}_t,A_t)','\\kappa_t=\\kappa(\\mathbf{z}_t,A_t)','Kohärenzwert des aktuellen Zustands und seiner Relationsstruktur.','metric','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.459');

UPDATE equations
SET section_id=@section_id,title='Aktuelle funktionale Kohärenz',equation_latex='\\kappa_t=\\kappa(\\mathbf{z}_t,A_t)',word_latex='\\kappa_t=\\kappa(\\mathbf{z}_t,A_t)',
    plain_description='Kohärenzwert des aktuellen Zustands und seiner Relationsstruktur.',equation_type='metric',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.459';

/* 3.460 – Rekonstruktionskette mathematischer Strukturen */
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.460',@section_id,'Rekonstruktionskette mathematischer Strukturen','F\\rightarrow R\\rightarrow G\\rightarrow A\\rightarrow\\mathbf{z}\\rightarrow\\Omega\\rightarrow\\Gamma\\rightarrow\\kappa','F\\rightarrow R\\rightarrow G\\rightarrow A\\rightarrow\\mathbf{z}\\rightarrow\\Omega\\rightarrow\\Gamma\\rightarrow\\kappa','Verdichtete Abfolge der mathematischen Rekonstruktion funktionaler Organisation.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.460');

UPDATE equations
SET section_id=@section_id,title='Rekonstruktionskette mathematischer Strukturen',equation_latex='F\\rightarrow R\\rightarrow G\\rightarrow A\\rightarrow\\mathbf{z}\\rightarrow\\Omega\\rightarrow\\Gamma\\rightarrow\\kappa',word_latex='F\\rightarrow R\\rightarrow G\\rightarrow A\\rightarrow\\mathbf{z}\\rightarrow\\Omega\\rightarrow\\Gamma\\rightarrow\\kappa',
    plain_description='Verdichtete Abfolge der mathematischen Rekonstruktion funktionaler Organisation.',equation_type='schema',provenance='original',validation_status='checked',created_revision_id=@revision_id
WHERE equation_number='3.460';

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Graphentheorie als formaler Rahmen für Knoten-, Kanten- und Pfadstrukturen.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=47
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Operatoren auf Funktionen- und Zustandsräumen als Grundlage der operatorischen Beschreibung.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=11
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Funktionalanalytische Grundlagen linearer Operatoren und Zustandsräume.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=35
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Erweiterte funktionalanalytische Operatorstrukturen.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=41
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Mathematische Behandlung von Operatoren und Spektralstrukturen.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=42
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'comparison','Komplexe Netzwerke und strukturell-dynamische Kopplungen.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=15
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'comparison','Netzwerktheoretische Beschreibung von Struktur, Dynamik und Organisation.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=48
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Dynamische Systeme, Trajektorien und Stabilitätsbegriffe.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=37
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Nichtlineare Dynamik und qualitative Zustandsentwicklung.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=40
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Stabilität, Attraktoren und Bifurkationen dynamischer Systeme.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=43
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'background','Qualitative Analyse dynamischer Zustandsräume.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=44
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'comparison','Informationstheoretische Maße als Teilgrundlage quantifizierter Kohärenz.','Abschnitt 3.9.2',0,1,
       'Wiederverwendung einer bereits im Master-Literaturbestand vorhandenen Quelle.',@revision_id
FROM sources s
WHERE s.citation_number=46
  AND NOT EXISTS (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.2'
  );

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value,changed_at)
SELECT @revision_id,@section_id,'created','section','3.9.2',
       'Abschnitt 3.9.2 zur Rekonstruktion mathematischer Strukturen angelegt.',NULL,'draft',NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM section_change_log
  WHERE revision_id=@revision_id AND section_id=@section_id
    AND change_type='created' AND object_reference='3.9.2'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value,changed_at)
SELECT @revision_id,@section_id,'equation_added','equations','3.439-3.460',
       '22 Gleichungen einschließlich Word-LaTeX für die mathematische Rekonstruktionskette registriert.',NULL,'22',NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM section_change_log
  WHERE revision_id=@revision_id AND section_id=@section_id
    AND change_type='equation_added' AND object_reference='3.439-3.460'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value,changed_at)
SELECT @revision_id,@section_id,'source_reused','literature','3.9.2-literature',
       'Vorhandene Masterquellen zu Graphentheorie, Funktionalanalysis, Netzwerktheorie, dynamischen Systemen und Informationstheorie wurden verknüpft.',
       NULL,CONCAT('',(SELECT COUNT(*) FROM source_usage WHERE section_id=@section_id AND exact_location='Abschnitt 3.9.2')),NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM section_change_log
  WHERE revision_id=@revision_id AND section_id=@section_id
    AND change_type='source_reused' AND object_reference='3.9.2-literature'
);

/* Validierungen */
SET @equation_count := (
  SELECT COUNT(*) FROM equations
  WHERE section_id=@section_id
    AND equation_number IN ('3.439','3.440','3.441','3.442','3.443','3.444','3.445','3.446','3.447','3.448','3.449','3.450','3.451','3.452','3.453','3.454','3.455','3.456','3.457','3.458','3.459','3.460')
);
SET @source_usage_count := (SELECT COUNT(*) FROM source_usage WHERE section_id=@section_id AND exact_location='Abschnitt 3.9.2');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT @revision_id,'K3_9_2_SECTION_COUNT',
       IF((SELECT COUNT(*) FROM dissertation_sections WHERE section_code='3.9.2')=1,'passed','failed'),
       '1',CONCAT('',(SELECT COUNT(*) FROM dissertation_sections WHERE section_code='3.9.2')),
       'Prüft die eindeutige Anlage von Abschnitt 3.9.2.',NOW()
WHERE NOT EXISTS (SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_id AND validation_code='K3_9_2_SECTION_COUNT');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT @revision_id,'K3_9_2_EQUATION_COUNT',IF(@equation_count=22,'passed','failed'),'22',CONCAT('',@equation_count),
       'Prüft die Gleichungen 3.439 bis 3.460.',NOW()
WHERE NOT EXISTS (SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_id AND validation_code='K3_9_2_EQUATION_COUNT');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT @revision_id,'K3_9_2_WORD_LATEX',
       IF((SELECT COUNT(*) FROM equations WHERE section_id=@section_id AND (word_latex IS NULL OR word_latex=''))=0,'passed','failed'),
       '0 fehlende Word-LaTeX-Einträge',
       CONCAT('',(SELECT COUNT(*) FROM equations WHERE section_id=@section_id AND (word_latex IS NULL OR word_latex=''))),
       'Prüft die Word-LaTeX-Vollständigkeit in Abschnitt 3.9.2.',NOW()
WHERE NOT EXISTS (SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_id AND validation_code='K3_9_2_WORD_LATEX');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT @revision_id,'K3_9_2_SOURCE_USAGE',IF(@source_usage_count=12,'passed','warning'),'12',CONCAT('',@source_usage_count),
       'Prüft die zwölf vorgesehenen Literaturverknüpfungen für Abschnitt 3.9.2.',NOW()
WHERE NOT EXISTS (SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_id AND validation_code='K3_9_2_SOURCE_USAGE');

COMMIT;

/* Kontrollausgaben */
SELECT section_id,section_code,title,status,is_original_contribution
FROM dissertation_sections WHERE section_code='3.9.2';

SELECT equation_number,title,equation_type,validation_status
FROM equations
WHERE section_id=@section_id AND equation_number BETWEEN '3.439' AND '3.460'
ORDER BY (SUBSTRING_INDEX(equation_number,'.',-1) + 0);

SELECT s.citation_number,s.title,su.usage_type,su.exact_location
FROM source_usage su JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id AND su.exact_location='Abschnitt 3.9.2'
ORDER BY s.citation_number;

SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
