-- ###########################################################################
-- FRZK-Repository – vollständiges Weiter-Skript zu Abschnitt 3.2.15
-- Matrixnormen, Kondition und numerische Stabilität
-- Definitionen 3.2.44–3.2.50
-- Satz 3.2.12
-- Gleichungen (3.439)–(3.503)
-- Literatur: [74], [82], [84], neu [85]
-- Kollation temporärer Tabellen: utf8mb4_general_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.15-V1',NOW(),'section','3.2.15','3.2.15-v1',
       'Vollständige repositorygerechte Aufnahme von 3.2.15 einschließlich Literatur [74], [82], [84], [85], Definitionen 3.2.44–3.2.50, Satz 3.2.12 und Gleichungen 3.439–3.503.',
       'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.15-V1');
SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.15-V1' LIMIT 1);

SET @parent_section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);
INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.15','Matrixnormen, Kondition und numerische Stabilität',3,3.2150,'final',0,
       'Vektor- und Matrixnormen, Fehlerfortpflanzung, Konditionszahl, Vorwärts- und Rückwärtsstabilität; Definitionen 3.2.44–3.2.50; Satz 3.2.12; Gleichungen (3.439)–(3.503); Literatur [74], [82], [84], [85].'
WHERE @parent_section IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.15');
SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.15' LIMIT 1);
UPDATE dissertation_sections SET title='Matrixnormen, Kondition und numerische Stabilität',status='final',
 notes='Vektor- und Matrixnormen, Fehlerfortpflanzung, Konditionszahl, Vorwärts- und Rückwärtsstabilität; Definitionen 3.2.44–3.2.50; Satz 3.2.12; Gleichungen (3.439)–(3.503); Literatur [74], [82], [84], [85].'
WHERE section_id=@section;

-- Neue Quelle [85]
INSERT INTO authors (family_name,given_names,normalized_name,notes)
SELECT 'Higham','Nicholas J.','Higham, Nicholas J.','Autor der Quelle [85].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Higham, Nicholas J.');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 85,'higham_accuracy_stability_2002','book','Accuracy and Stability of Numerical Algorithms',1996,2002,
       'Society for Industrial and Applied Mathematics','Philadelphia','2nd edition','978-0-89871-521-7','en',1,'monograph',9,'verified','3.2.15',
       'Erstnennung als zentrale Referenz für Rundungsfehler, Fehlerfortpflanzung, Kondition sowie Vorwärts- und Rückwärtsstabilität.',
       'Higham, Nicholas J.: Accuracy and Stability of Numerical Algorithms. 2nd edition. Philadelphia: Society for Industrial and Applied Mathematics, 2002.',
       'Higham, Accuracy and Stability [85]',
       'Zentrale Referenz zur numerischen Stabilitäts- und Fehleranalyse.',@revision
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=85 OR source_key='higham_accuracy_stability_2002');

SET @src_74 := (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1);
SET @src_82 := (SELECT source_id FROM sources WHERE citation_number=82 LIMIT 1);
SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_85 := (SELECT source_id FROM sources WHERE citation_number=85 LIMIT 1);
SET @author_higham := (SELECT author_id FROM authors WHERE normalized_name='Higham, Nicholas J.' LIMIT 1);
INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_85,@author_higham,1,'author'
WHERE @src_85 IS NOT NULL AND @author_higham IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_85 AND author_id=@author_higham);

-- Literaturverwendung
DELETE FROM source_usage WHERE section_id=@section AND source_id IN (@src_74,@src_82,@src_84,@src_85);
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_74,@section,'background','Einführung gebräuchlicher Vektor- und Matrixnormen sowie anschauliche Interpretation linearer Verstärkung und Kondition.','Abschnitt 3.2.15: Normbegriffe und didaktisches Beispiel',0,1,'Wiederverwendung der Quelle [74].',@revision),
(@src_82,@section,'background','Normtheoretische Einordnung endlichdimensionaler Vektorräume und Äquivalenz von Normen.','Abschnitt 3.2.15: Vektornormen und Normäquivalenz',0,1,'Wiederverwendung der Quelle [82].',@revision),
(@src_84,@section,'background','Induzierte Matrixnormen, Spektralnorm, Frobeniusnorm, Konditionszahlen und Operatorabschätzungen.','Abschnitt 3.2.15: Matrixnormen, Kondition und Kaskaden',0,1,'Wiederverwendung der Quelle [84].',@revision),
(@src_85,@section,'first_citation','Rundungsfehler, Fehlerfortpflanzung, Vorwärts- und Rückwärtsstabilität sowie Trennung von Kondition und Stabilität.','Abschnitt 3.2.15 vollständig',1,1,'Erstnennung der Quelle [85].',@revision);

-- Definitionen 3.2.44–3.2.50
CREATE TEMPORARY TABLE tmp_3215_definitions (
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,
 title VARCHAR(500), definition_text LONGTEXT, formal_latex LONGTEXT, source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_3215_definitions VALUES
('3.2.44','Vektornorm','Eine Abbildung ||·|| von einem reellen Vektorraum V nach R heißt Norm, wenn Nichtnegativität, Definitheit, absolute Homogenität und Dreiecksungleichung erfüllt sind.','\|\cdot\|:V\rightarrow\mathbb{R}',@src_82),
('3.2.45','Induzierte Matrixnorm','Die zu einer Vektornorm induzierte Matrixnorm ist die größte Verstärkung eines von null verschiedenen Vektors durch die Matrix.','\|A\|=\sup_{x\neq 0}\frac{\|Ax\|}{\|x\|}',@src_84),
('3.2.46','Frobeniusnorm','Die Frobeniusnorm einer Matrix ist die Quadratwurzel aus der Summe der Quadrate aller Matrixeinträge.','\|A\|_{\mathrm F}=\sqrt{\sum_{i=1}^{m}\sum_{j=1}^{n}|a_{ij}|^2}',@src_84),
('3.2.47','Absolute und relative Abweichung','Die absolute Abweichung ist die Differenz zwischen Näherungswert und exaktem Wert. Die relative Abweichung setzt deren Norm zur Norm des Bezugswertes ins Verhältnis.','\Delta x=\widetilde{x}-x,\qquad\delta_x=\frac{\|\widetilde{x}-x\|}{\|x\|}',@src_85),
('3.2.48','Konditionszahl einer Matrix','Für eine invertierbare quadratische Matrix ist die Konditionszahl bezüglich einer induzierten Norm das Produkt aus der Norm der Matrix und der Norm ihrer Inversen.','\kappa(A)=\|A\|\,\|A^{-1}\|',@src_84),
('3.2.49','Gut und schlecht konditioniertes Problem','Ein Problem ist gut konditioniert, wenn kleine Eingabeänderungen nur kleine Lösungsänderungen verursachen, und schlecht konditioniert, wenn kleine Eingabeänderungen stark vergrößerte Lösungsänderungen hervorrufen können.','\kappa(A)',@src_85),
('3.2.50','Numerische Stabilität','Ein Verfahren heißt vorwärtsstabil, wenn das berechnete Ergebnis nahe der exakten Lösung liegt, und rückwärtsstabil, wenn es die exakte Lösung eines nur geringfügig gestörten Ausgangsproblems ist.','(A+\Delta A)\widetilde{x}=b+\Delta b',@src_85);
INSERT INTO definitions(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,'adapted',t.source_id,
       'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.',
       'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.','verified',@revision
FROM tmp_3215_definitions t
WHERE NOT EXISTS (SELECT 1 FROM definitions d WHERE d.definition_number COLLATE utf8mb4_general_ci=t.definition_number COLLATE utf8mb4_general_ci);
UPDATE definitions d JOIN tmp_3215_definitions t
 ON d.definition_number COLLATE utf8mb4_general_ci=t.definition_number COLLATE utf8mb4_general_ci
SET d.section_id=@section,d.title=t.title,d.definition_text=t.definition_text,d.formal_latex=t.formal_latex,d.word_latex=t.formal_latex,
 d.provenance='adapted',d.source_id=t.source_id,d.assumptions='Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.',
 d.notes='Etablierte Definition aus linearer beziehungsweise numerischer Algebra.',d.validation_status='verified',d.created_revision_id=COALESCE(d.created_revision_id,@revision)
WHERE d.section_id=@section OR d.definition_number IN ('3.2.44','3.2.45','3.2.46','3.2.47','3.2.48','3.2.49','3.2.50');

-- Satz 3.2.12
INSERT INTO theorems
(
 theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id
)
SELECT
 '3.2.12',@section,'Submultiplikativität induzierter Matrixnormen',
 'Für kompatible Matrizen A und B gilt für jede induzierte Matrixnorm die Ungleichung ||AB|| kleiner oder gleich ||A|| mal ||B||.',
 '\|AB\|\leq\|A\|\,\|B\|','\|AB\|\leq\|A\|\,\|B\|',
 'literature',@src_84,
 'A und B sind kompatible reelle Matrizen; die verwendete Matrixnorm ist induziert. Begründung: Für jeden Vektor x gilt ||ABx|| ≤ ||A||·||Bx|| und ||Bx|| ≤ ||B||·||x||. Für ||x||=1 und nach Bildung des Supremums folgt die Behauptung.',
 'verified',@revision
WHERE NOT EXISTS
(
 SELECT 1 FROM theorems WHERE theorem_number='3.2.12'
);

UPDATE theorems
SET section_id=@section,
 title='Submultiplikativität induzierter Matrixnormen',
 statement_text='Für kompatible Matrizen A und B gilt für jede induzierte Matrixnorm die Ungleichung ||AB|| kleiner oder gleich ||A|| mal ||B||.',
 statement_latex='\|AB\|\leq\|A\|\,\|B\|',
 word_latex='\|AB\|\leq\|A\|\,\|B\|',
 provenance='literature',
 source_id=@src_84,
 assumptions='A und B sind kompatible reelle Matrizen; die verwendete Matrixnorm ist induziert. Begründung: Für jeden Vektor x gilt ||ABx|| ≤ ||A||·||Bx|| und ||Bx|| ≤ ||B||·||x||. Für ||x||=1 und nach Bildung des Supremums folgt die Behauptung.',
 validation_status='verified',
 created_revision_id=COALESCE(created_revision_id,@revision)
WHERE theorem_number='3.2.12';

-- Gleichungen (3.439)–(3.503)
CREATE TEMPORARY TABLE tmp_3215_equations (
 equation_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,
 title VARCHAR(500), latex TEXT, equation_type VARCHAR(20), source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_3215_equations VALUES
('3.439','Normabbildung','\\|\\cdot\\|:V\\rightarrow\\mathbb{R}','definition',@src_85),
('3.440','Nichtnegativität der Norm','\\|x\\|\\geq 0','definition',@src_82),
('3.441','Definitheit der Norm','\\|x\\|=0\\quad\\Longleftrightarrow\\quad x=0','definition',@src_82),
('3.442','Absolute Homogenität der Norm','\\|\\alpha x\\|=|\\alpha|\\,\\|x\\|','definition',@src_82),
('3.443','Dreiecksungleichung','\\|x+y\\|\\leq\\|x\\|+\\|y\\|','theorem',@src_82),
('3.444','Allgemeiner Vektor in R hoch n','x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n \\end{pmatrix}\\in\\mathbb{R}^n','definition',@src_74),
('3.445','Einsnorm eines Vektors','\\|x\\|_1=\\sum_{i=1}^{n}|x_i|','definition',@src_74),
('3.446','Euklidische Norm','\\|x\\|_2=\\sqrt{\\sum_{i=1}^{n}x_i^2}','definition',@src_74),
('3.447','Euklidische Norm über Skalarprodukt','\\|x\\|_2=\\sqrt{x^{\\mathsf T}x}','derived',@src_74),
('3.448','Maximumsnorm','\\|x\\|_{\\infty}=\\max_{1\\leq i\\leq n}|x_i|','definition',@src_74),
('3.449','Allgemeine p-Norm','\\|x\\|_p=\\left(\\sum_{i=1}^{n}|x_i|^p\\right)^{1/p}','definition',@src_82),
('3.450','Äquivalenz endlichdimensionaler Normen','c\\|x\\|_a\\leq\\|x\\|_b\\leq C\\|x\\|_a','theorem',@src_82),
('3.451','Matrix für induzierte Norm','A\\in\\mathbb{R}^{m\\times n}','definition',@src_84),
('3.452','Induzierte Matrixnorm','\\|A\\|=\\sup_{x\\neq 0}\\frac{\\|Ax\\|}{\\|x\\|}','definition',@src_84),
('3.453','Induzierte Matrixnorm auf Einheitsvektoren','\\|A\\|=\\sup_{\\|x\\|=1}\\|Ax\\|','derived',@src_84),
('3.454','Grundlegende Operatorabschätzung','\\|Ax\\|\\leq\\|A\\|\\,\\|x\\|','theorem',@src_84),
('3.455','Allgemeine Matrixeinträge','A=(a_{ij})\\in\\mathbb{R}^{m\\times n}','definition',@src_84),
('3.456','Induzierte Einsnorm einer Matrix','\\|A\\|_1=\\max_{1\\leq j\\leq n}\\sum_{i=1}^{m}|a_{ij}|','definition',@src_84),
('3.457','Induzierte Unendlichnorm einer Matrix','\\|A\\|_{\\infty}=\\max_{1\\leq i\\leq m}\\sum_{j=1}^{n}|a_{ij}|','definition',@src_84),
('3.458','Spektralnorm über Eigenwert','\\|A\\|_2=\\sqrt{\\lambda_{\\max}\\left(A^{\\mathsf T}A\\right)}','definition',@src_84),
('3.459','Spektralnorm über größten Singulärwert','\\|A\\|_2=\\sigma_{\\max}(A)=\\sigma_1','theorem',@src_84),
('3.460','Matrix für Frobeniusnorm','A=(a_{ij})\\in\\mathbb{R}^{m\\times n}','definition',@src_84),
('3.461','Frobeniusnorm über Matrixeinträge','\\|A\\|_{\\mathrm F}=\\sqrt{\\sum_{i=1}^{m}\\sum_{j=1}^{n}|a_{ij}|^2}','definition',@src_84),
('3.462','Frobeniusnorm über Spur','\\|A\\|_{\\mathrm F}=\\sqrt{\\operatorname{tr}\\left(A^{\\mathsf T}A\\right)}','derived',@src_84),
('3.463','Frobeniusnorm über Singulärwerte','\\|A\\|_{\\mathrm F}=\\sqrt{\\sum_{i=1}^{r}\\sigma_i^2}','theorem',@src_84),
('3.464','Submultiplikativität','\\|AB\\|\\leq\\|A\\|\\,\\|B\\|','theorem',@src_84),
('3.465','Erster Beweisschritt der Submultiplikativität','\\|ABx\\|\\leq\\|A\\|\\,\\|Bx\\|','derived',@src_84),
('3.466','Zweiter Beweisschritt der Submultiplikativität','\\|Bx\\|\\leq\\|B\\|\\,\\|x\\|','derived',@src_84),
('3.467','Kombinierte Abschätzung','\\|ABx\\|\\leq\\|A\\|\\,\\|B\\|\\,\\|x\\|','derived',@src_84),
('3.468','Abschätzung auf dem Einheitsvektor','\\|ABx\\|\\leq\\|A\\|\\,\\|B\\|','derived',@src_84),
('3.469','Schlussfolgerung der Submultiplikativität','\\|AB\\|\\leq\\|A\\|\\,\\|B\\|','theorem',@src_84),
('3.470','Absolute Abweichung','\\Delta x=\\widetilde{x}-x','definition',@src_85),
('3.471','Norm der absoluten Abweichung','\\|\\Delta x\\|=\\|\\widetilde{x}-x\\|','definition',@src_85),
('3.472','Relative Abweichung','\\delta_x=\\frac{\\|\\widetilde{x}-x\\|}{\\|x\\|}','definition',@src_85),
('3.473','Invertierbare Matrix zur Konditionszahl','A\\in\\mathbb{R}^{n\\times n}','definition',@src_84),
('3.474','Konditionszahl einer Matrix','\\kappa(A)=\\|A\\|\\,\\|A^{-1}\\|','definition',@src_84),
('3.475','Konditionszahl in Spektralnorm','\\kappa_2(A)=\\|A\\|_2\\|A^{-1}\\|_2','definition',@src_84),
('3.476','Konditionszahl über Singulärwerte','\\kappa_2(A)=\\frac{\\sigma_{\\max}(A)}{\\sigma_{\\min}(A)}','theorem',@src_84),
('3.477','Untere Schranke der Konditionszahl','\\kappa(A)\\geq 1','theorem',@src_84),
('3.478','Konditionszahl singulärer Matrizen','\\kappa(A)=\\infty','definition',@src_84),
('3.479','Lineares Gleichungssystem zur Fehlerfortpflanzung','Ax=b','other',@src_84),
('3.480','Gestörtes lineares Gleichungssystem','A(x+\\Delta x)=b+\\Delta b','definition',@src_85),
('3.481','Ungestörtes lineares Gleichungssystem','Ax=b','other',@src_84),
('3.482','Differenzgleichung der Störungen','A\\Delta x=\\Delta b','derived',@src_85),
('3.483','Lösungsstörung','\\Delta x=A^{-1}\\Delta b','derived',@src_85),
('3.484','Normabschätzung der Lösungsstörung','\\|\\Delta x\\|\\leq\\|A^{-1}\\|\\,\\|\\Delta b\\|','derived',@src_85),
('3.485','Rechte Seite als Operatorwirkung','b=Ax','other',@src_84),
('3.486','Normabschätzung der rechten Seite','\\|b\\|\\leq\\|A\\|\\,\\|x\\|','derived',@src_84),
('3.487','Reziproke Lösungsabschätzung','\\frac{1}{\\|x\\|}\\leq\\frac{\\|A\\|}{\\|b\\|}','derived',@src_85),
('3.488','Relative Fehlerabschätzung','\\frac{\\|\\Delta x\\|}{\\|x\\|}\\leq\\kappa(A)\\frac{\\|\\Delta b\\|}{\\|b\\|}','theorem',@src_85),
('3.489','Konditionsmaß','\\kappa(A)','definition',@src_85),
('3.490','Vorwärtsfehler','\\frac{\\|\\widetilde{x}-x\\|}{\\|x\\|}\\ll 1','definition',@src_85),
('3.491','Rückwärtsstabiles gestörtes Problem','(A+\\Delta A)\\widetilde{x}=b+\\Delta b','definition',@src_85),
('3.492','Relative Matrixstörung','\\frac{\\|\\Delta A\\|}{\\|A\\|}','metric',@src_85),
('3.493','Relative Störung der rechten Seite','\\frac{\\|\\Delta b\\|}{\\|b\\|}','metric',@src_85),
('3.494','Begriffliche Wirkung der Kondition','\\text{Eingabestörung}\\longrightarrow\\text{Lösungsänderung}','other',@src_85),
('3.495','Begriffliche Wirkung der Stabilität','\\text{Rechenverfahren}\\longrightarrow\\text{zusätzlicher numerischer Fehler}','other',@src_85),
('3.496','Begriffliche Gesamtfehlerzerlegung','\\text{Gesamtfehler}=\\text{Problemempfindlichkeit}+\\text{Verfahrensfehler}','other',@src_85),
('3.497','Operatorenfolge','A_1,A_2,\\ldots,A_k','definition',@src_84),
('3.498','Gesamtoperator einer Kaskade','T=A_kA_{k-1}\\cdots A_1','definition',@src_84),
('3.499','Normabschätzung der Operatorenkaskade','\\|T\\|\\leq\\|A_k\\|\\|A_{k-1}\\|\\cdots\\|A_1\\|','theorem',@src_84),
('3.500','Wirkungsabschätzung der Operatorenkaskade','\\|Tx\\|\\leq\\left(\\prod_{i=1}^{k}\\|A_i\\|\\right)\\|x\\|','theorem',@src_84),
('3.501','Mögliche Einzelverstärkung','\\|A_i\\|>1','other',@src_84),
('3.502','Didaktischer Beispielvektor','x=\\begin{pmatrix}3\\\\-4 \\end{pmatrix}','example',@src_74),
('3.503','Vergleich dreier Vektornormen','\\|x\\|_1=7,\\qquad\\|x\\|_2=5,\\qquad\\|x\\|_{\\infty}=4','example',@src_74);

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT t.equation_number,@section,t.title,t.latex,t.latex,CONCAT('Formale Gleichung ',t.equation_number,' aus Abschnitt 3.2.15.'),t.equation_type,'adapted',t.source_id,
       'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.',
       'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.','verified',@revision
FROM tmp_3215_equations t
WHERE NOT EXISTS (SELECT 1 FROM equations e WHERE e.equation_number COLLATE utf8mb4_general_ci=t.equation_number COLLATE utf8mb4_general_ci);
UPDATE equations e JOIN tmp_3215_equations t
 ON e.equation_number COLLATE utf8mb4_general_ci=t.equation_number COLLATE utf8mb4_general_ci
SET e.section_id=@section,e.title=t.title,e.equation_latex=t.latex,e.word_latex=t.latex,
 e.plain_description=CONCAT('Formale Gleichung ',e.equation_number,' aus Abschnitt 3.2.15.'),e.equation_type=t.equation_type,e.provenance='adapted',e.source_id=t.source_id,
 e.derivation='Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.',
 e.assumptions='Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.',e.validation_status='verified',e.created_revision_id=COALESCE(e.created_revision_id,@revision)
WHERE e.section_id=@section OR CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED) BETWEEN 439 AND 503;

-- Änderungsprotokoll
INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'inserted','Abschnitt 3.2.15 vollständig mit Literatur, sieben Definitionen, Satz 3.2.12 und Gleichungen 3.439–3.503 eingetragen.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section);

-- Repository-Zähler
INSERT INTO repository_counters(counter_key,counter_value) VALUES
('current_section','3.2.16'),('last_completed_section','3.2.15'),('last_definition_number','3.2.50'),('next_definition_number','3.2.51'),
('last_theorem_number','3.2.12'),('next_theorem_number','3.2.13'),('last_equation_number','3.503'),('next_equation_number','3.504'),
('last_citation_number','85'),('next_citation_number','86')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_3215_definitions;
DROP TEMPORARY TABLE IF EXISTS tmp_3215_equations;
COMMIT;

-- Abschlusskontrolle
SELECT section_id,section_code,title,status,notes FROM dissertation_sections WHERE section_code='3.2.15';
SELECT COUNT(*) AS definitionen_3_2_15 FROM definitions WHERE section_id=@section AND definition_number IN ('3.2.44','3.2.45','3.2.46','3.2.47','3.2.48','3.2.49','3.2.50');
SELECT COUNT(*) AS saetze_3_2_15 FROM theorems WHERE section_id=@section AND theorem_number='3.2.12';
SELECT COUNT(*) AS gleichungen_3_2_15 FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 439 AND 503;
SELECT COUNT(*) AS literaturverwendungen_3_2_15 FROM source_usage WHERE section_id=@section AND citation_checked=1;
SELECT citation_number,short_citation_text,verification_status FROM sources WHERE citation_number IN (74,82,84,85) ORDER BY citation_number;
SELECT counter_key,counter_value FROM repository_counters WHERE counter_key IN
('current_section','last_completed_section','last_definition_number','next_definition_number','last_theorem_number','next_theorem_number','last_equation_number','next_equation_number','last_citation_number','next_citation_number') ORDER BY counter_key;
