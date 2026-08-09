SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;
START TRANSACTION;
SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.18-V1',NOW(),'section','3.2.18','3.2.18-v1','Abschnitt 3.2.18: Nichtlineare Gleichungssysteme und lokale Linearisierung.','Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.18-V1');
SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.18-V1' LIMIT 1);
SET @parent_section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);
INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.18','Nichtlineare Gleichungssysteme und lokale Linearisierung',3,3.2180,'final',0,'Definitionen 3.2.63–3.2.68; Sätze 3.2.15–3.2.16; Gleichungen 3.674–3.768; Literatur [84], [85], [89].'
WHERE @parent_section IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.18');
SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.18' LIMIT 1);
UPDATE dissertation_sections SET title='Nichtlineare Gleichungssysteme und lokale Linearisierung',status='final',notes='Definitionen 3.2.63–3.2.68; Sätze 3.2.15–3.2.16; Gleichungen 3.674–3.768; Literatur [84], [85], [89].' WHERE section_id=@section;

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Kelley','C. T.','Kelley, C. T.','Autor der Quelle [89].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Kelley, C. T.');
INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 89,'kelley_newton_method_2003','book','Solving Nonlinear Equations with Newton''s Method',2003,2003,'Society for Industrial and Applied Mathematics','Philadelphia',NULL,'978-0-89871-546-0','en',1,'monograph',9,'verified','3.2.18','Erstnennung für Newton-Verfahren, Fixpunktiteration und Globalisierung.','Kelley, C. T.: Solving Nonlinear Equations with Newton''s Method. Philadelphia: SIAM, 2003.','Kelley, Newton''s Method [89]','Zentrale Referenz für nichtlineare Gleichungssysteme.',@revision
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=89 OR source_key='kelley_newton_method_2003');
SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_85 := (SELECT source_id FROM sources WHERE citation_number=85 LIMIT 1);
SET @src_89 := (SELECT source_id FROM sources WHERE citation_number=89 LIMIT 1);
SET @author_kelley := (SELECT author_id FROM authors WHERE normalized_name='Kelley, C. T.' LIMIT 1);
INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_89,@author_kelley,1,'author' WHERE @src_89 IS NOT NULL AND @author_kelley IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_89 AND author_id=@author_kelley);
DELETE FROM source_usage WHERE section_id=@section AND source_id IN (@src_84,@src_85,@src_89);
INSERT INTO source_usage(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id) VALUES
(@src_84,@section,'background','Lineare Newton-Teilsysteme und Jacobi-Matrix.','3.2.18',0,1,'Wiederverwendung [84].',@revision),
(@src_85,@section,'background','Kondition, Rundungsfehler und numerische Differentiation.','3.2.18',0,1,'Wiederverwendung [85].',@revision),
(@src_89,@section,'first_citation','Newton-Verfahren, Fixpunktiteration und Globalisierung.','3.2.18',1,1,'Erstnennung [89].',@revision);

CREATE TEMPORARY TABLE tmp_d(definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,title VARCHAR(500),definition_text LONGTEXT,formal_latex LONGTEXT,source_id BIGINT UNSIGNED) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_d VALUES
('3.2.63','Nichtlineares Gleichungssystem','Vektorwertige Gleichung F(x)=0 mit nicht ausschließlich linearen Komponenten.','F(x)=0',@src_89),
('3.2.64','Jacobi-Matrix einer nichtlinearen Abbildung','Matrix sämtlicher erster partieller Ableitungen.','J_F(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)',@src_89),
('3.2.65','Newton-Schritt','Lösung des lokal linearisierten Systems.','J_F(x^{(k)})s^{(k)}=-F(x^{(k)})',@src_89),
('3.2.66','Gedämpftes Newton-Verfahren','Gewichteter Newton-Schritt mit 0<alpha_k<=1.','x^{(k+1)}=x^{(k)}+\\alpha_k s^{(k)}',@src_89),
('3.2.67','Quasi-Newton-Verfahren','Ersetzung der exakten Jacobi-Matrix durch eine aktualisierte Näherungsmatrix.','B_k s^{(k)}=-F(x^{(k)})',@src_89),
('3.2.68','Fixpunktiteration','Iteration einer äquivalenten Gleichung x=G(x).','x^{(k+1)}=G(x^{(k)})',@src_89);
INSERT INTO definitions(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT definition_number,@section,title,definition_text,formal_latex,formal_latex,'adapted',source_id,'Differenzierbarkeit und die jeweils genannten Voraussetzungen.','Definition der nichtlinearen numerischen Analysis.','verified',@revision FROM tmp_d
WHERE NOT EXISTS (SELECT 1 FROM definitions d WHERE d.definition_number COLLATE utf8mb4_general_ci=tmp_d.definition_number COLLATE utf8mb4_general_ci);
UPDATE definitions d JOIN tmp_d t ON d.definition_number COLLATE utf8mb4_general_ci=t.definition_number COLLATE utf8mb4_general_ci
SET d.section_id=@section,d.title=t.title,d.definition_text=t.definition_text,d.formal_latex=t.formal_latex,d.word_latex=t.formal_latex,d.provenance='adapted',d.source_id=t.source_id,d.validation_status='verified',d.created_revision_id=COALESCE(d.created_revision_id,@revision);

CREATE TEMPORARY TABLE tmp_t(theorem_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,title VARCHAR(500),statement_text LONGTEXT,statement_latex LONGTEXT,assumptions LONGTEXT,source_id BIGINT UNSIGNED) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_t VALUES
('3.2.15','Lokale quadratische Konvergenz des Newton-Verfahrens','Bei zweimal stetiger Differenzierbarkeit und regulärer Nullstelle konvergiert Newton für hinreichend nahe Startwerte lokal quadratisch.','\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^2','F ist zweimal stetig differenzierbar, F(x*)=0 und det J_F(x*) ist ungleich null.',@src_89),
('3.2.16','Kontraktionskriterium für Fixpunktiterationen','Eine Kontraktion auf einer abgeschlossenen invarianten Menge besitzt genau einen Fixpunkt; die Iteration konvergiert von jedem Startwert der Menge.','\\|G(x)-G(y)\\|\\leq q\\|x-y\\|,\\qquad 0\\leq q<1','D ist abgeschlossen, G(D) liegt in D und G ist eine Kontraktion.',@src_89);
INSERT INTO theorems(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT theorem_number,@section,title,statement_text,statement_latex,statement_latex,'literature',source_id,assumptions,'verified',@revision FROM tmp_t
WHERE NOT EXISTS (SELECT 1 FROM theorems th WHERE th.theorem_number COLLATE utf8mb4_general_ci=tmp_t.theorem_number COLLATE utf8mb4_general_ci);
UPDATE theorems th JOIN tmp_t t ON th.theorem_number COLLATE utf8mb4_general_ci=t.theorem_number COLLATE utf8mb4_general_ci
SET th.section_id=@section,th.title=t.title,th.statement_text=t.statement_text,th.statement_latex=t.statement_latex,th.word_latex=t.statement_latex,th.provenance='literature',th.source_id=t.source_id,th.assumptions=t.assumptions,th.validation_status='verified',th.created_revision_id=COALESCE(th.created_revision_id,@revision);

CREATE TEMPORARY TABLE tmp_e(equation_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,title VARCHAR(500),latex TEXT,equation_type VARCHAR(20),source_id BIGINT UNSIGNED) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_e VALUES
('3.674','Gleichung 3.674','Ax=b','other',@src_84),
('3.675','Gleichung 3.675','F(x)=0','definition',@src_89),
('3.676','Gleichung 3.676','F:\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{n}','definition',@src_89),
('3.677','Gleichung 3.677','x\\in\\mathbb{R}^{n}','definition',@src_89),
('3.678','Gleichung 3.678','f_i(x_1,x_2,\\ldots,x_n)=0,\\qquad i=1,\\ldots,n','definition',@src_89),
('3.679','Gleichung 3.679','F(x)=\\begin{pmatrix}f_1(x)\\\\f_2(x)\\\\\\vdots\\\\f_n(x) \\end{pmatrix}','definition',@src_89),
('3.680','Gleichung 3.680','F(x^\\ast)=0','definition',@src_89),
('3.681','Gleichung 3.681','F=\\begin{pmatrix}f_1\\\\f_2\\\\\\vdots\\\\f_m \\end{pmatrix}:\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{m}','definition',@src_89),
('3.682','Gleichung 3.682','J_F(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)','definition',@src_89),
('3.683','Gleichung 3.683','J_F(x)\\in\\mathbb{R}^{n\\times n}','definition',@src_89),
('3.684','Gleichung 3.684','h\\in\\mathbb{R}^{n}','definition',@src_89),
('3.685','Gleichung 3.685','F(x+h)\\approx F(x)+J_F(x)h','derived',@src_89),
('3.686','Gleichung 3.686','F(x+h)=F(x)+J_F(x)h+r(h)','derived',@src_89),
('3.687','Gleichung 3.687','\\lim_{\\|h\\|\\rightarrow 0}\\frac{\\|r(h)\\|}{\\|h\\|}=0','theorem',@src_89),
('3.688','Gleichung 3.688','F(x)=0','definition',@src_89),
('3.689','Gleichung 3.689','F(x^{(k)}+s^{(k)})\\approx F(x^{(k)})+J_F(x^{(k)})s^{(k)}','derived',@src_89),
('3.690','Gleichung 3.690','F(x^{(k)})+J_F(x^{(k)})s^{(k)}=0','derived',@src_89),
('3.691','Gleichung 3.691','J_F(x^{(k)})s^{(k)}=-F(x^{(k)})','definition',@src_89),
('3.692','Gleichung 3.692','x^{(k+1)}=x^{(k)}+s^{(k)}','definition',@src_89),
('3.693','Gleichung 3.693','s^{(k)}=-J_F(x^{(k)})^{-1}F(x^{(k)})','derived',@src_89),
('3.694','Gleichung 3.694','x^{(k+1)}=x^{(k)}-J_F(x^{(k)})^{-1}F(x^{(k)})','definition',@src_89),
('3.695','Gleichung 3.695','F(x^\\ast)=0','theorem',@src_89),
('3.696','Gleichung 3.696','\\det J_F(x^\\ast)\\neq 0','theorem',@src_89),
('3.697','Gleichung 3.697','\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^2','theorem',@src_89),
('3.698','Gleichung 3.698','F(x^\\ast)=F(x^{(k)})+J_F(x^{(k)})(x^\\ast-x^{(k)})+R^{(k)}','derived',@src_89),
('3.699','Gleichung 3.699','\\|R^{(k)}\\|\\leq C_1\\|x^\\ast-x^{(k)}\\|^2','theorem',@src_89),
('3.700','Gleichung 3.700','F(x^\\ast)=0','derived',@src_89),
('3.701','Gleichung 3.701','J_F(x^{(k)})(x^\\ast-x^{(k)})=-F(x^{(k)})-R^{(k)}','derived',@src_89),
('3.702','Gleichung 3.702','J_F(x^{(k)})s^{(k)}=-F(x^{(k)})','derived',@src_89),
('3.703','Gleichung 3.703','J_F(x^{(k)})(x^\\ast-x^{(k)}-s^{(k)})=-R^{(k)}','derived',@src_89),
('3.704','Gleichung 3.704','x^{(k+1)}=x^{(k)}+s^{(k)}','derived',@src_89),
('3.705','Gleichung 3.705','x^\\ast-x^{(k+1)}=-J_F(x^{(k)})^{-1}R^{(k)}','theorem',@src_89),
('3.706','Gleichung 3.706','f:\\mathbb{R}\\rightarrow\\mathbb{R}','definition',@src_89),
('3.707','Gleichung 3.707','x^{(k+1)}=x^{(k)}-\\frac{f(x^{(k)})}{f''(x^{(k)})}','definition',@src_89),
('3.708','Gleichung 3.708','f''(x^{(k)})\\neq 0','definition',@src_89),
('3.709','Gleichung 3.709','\\left(x^{(k)},f(x^{(k)})\\right)','other',@src_89),
('3.710','Gleichung 3.710','x^2-2=0','other',@src_89),
('3.711','Gleichung 3.711','f(x)=x^2-2','definition',@src_89),
('3.712','Gleichung 3.712','f''(x)=2x','derived',@src_89),
('3.713','Gleichung 3.713','x^{(k+1)}=x^{(k)}-\\frac{(x^{(k)})^2-2}{2x^{(k)}}','derived',@src_89),
('3.714','Gleichung 3.714','x^{(k+1)}=\\frac{1}{2}\\left(x^{(k)}+\\frac{2}{x^{(k)}}\\right)','derived',@src_89),
('3.715','Gleichung 3.715','x^{(0)}=1','other',@src_89),
('3.716','Gleichung 3.716','x^{(1)}=\\frac{1}{2}\\left(1+\\frac{2}{1}\\right)=1{,}5','derived',@src_89),
('3.717','Gleichung 3.717','x^{(2)}=\\frac{1}{2}\\left(1{,}5+\\frac{2}{1{,}5}\\right)\\approx1{,}4167','derived',@src_89),
('3.718','Gleichung 3.718','x^{(3)}\\approx1{,}4142','derived',@src_89),
('3.719','Gleichung 3.719','x^\\ast=\\sqrt{2}','theorem',@src_89),
('3.720','Gleichung 3.720','x^{(k+1)}=x^{(k)}+s^{(k)}','definition',@src_89),
('3.721','Gleichung 3.721','x^{(k+1)}=x^{(k)}+\\alpha_k s^{(k)}','definition',@src_89),
('3.722','Gleichung 3.722','0<\\alpha_k\\leq 1','definition',@src_89),
('3.723','Gleichung 3.723','\\alpha_k=1','definition',@src_89),
('3.724','Gleichung 3.724','0<\\alpha_k<1','definition',@src_89),
('3.725','Gleichung 3.725','\\Phi(x)=\\frac{1}{2}\\|F(x)\\|_2^2','definition',@src_89),
('3.726','Gleichung 3.726','F(x^\\ast)=0\\quad\\Longrightarrow\\quad\\Phi(x^\\ast)=0','theorem',@src_89),
('3.727','Gleichung 3.727','\\Phi(x^{(k+1)})<\\Phi(x^{(k)})','metric',@src_89),
('3.728','Gleichung 3.728','\\Phi(x^{(k)}+\\alpha_k s^{(k)})\\leq\\Phi(x^{(k)})+c\\alpha_k\\nabla\\Phi(x^{(k)})^{\\mathsf T}s^{(k)}','theorem',@src_89),
('3.729','Gleichung 3.729','0<c<1','definition',@src_89),
('3.730','Gleichung 3.730','J_F(x^{(k)})','definition',@src_89),
('3.731','Gleichung 3.731','B_k\\approx J_F(x^{(k)})','definition',@src_89),
('3.732','Gleichung 3.732','B_k s^{(k)}=-F(x^{(k)})','definition',@src_89),
('3.733','Gleichung 3.733','B_{k+1}(x^{(k+1)}-x^{(k)})=F(x^{(k+1)})-F(x^{(k)})','theorem',@src_89),
('3.734','Gleichung 3.734','\\frac{\\partial f_i}{\\partial x_j}(x)\\approx\\frac{f_i(x+h e_j)-f_i(x)}{h}','derived',@src_85),
('3.735','Gleichung 3.735','\\frac{\\partial f_i}{\\partial x_j}(x)\\approx\\frac{f_i(x+h e_j)-f_i(x-h e_j)}{2h}','derived',@src_85),
('3.736','Gleichung 3.736','h\\ \\text{zu groß}\\quad\\Longrightarrow\\quad\\text{großer Diskretisierungsfehler}','other',@src_85),
('3.737','Gleichung 3.737','h\\ \\text{zu klein}\\quad\\Longrightarrow\\quad\\text{großer Rundungsfehler}','other',@src_85),
('3.738','Gleichung 3.738','x=G(x)','definition',@src_89),
('3.739','Gleichung 3.739','x^{(k+1)}=G(x^{(k)})','definition',@src_89),
('3.740','Gleichung 3.740','G(x^\\ast)=x^\\ast','definition',@src_89),
('3.741','Gleichung 3.741','0\\leq q<1','definition',@src_89),
('3.742','Gleichung 3.742','\\|G(x)-G(y)\\|\\leq q\\|x-y\\|','theorem',@src_89),
('3.743','Gleichung 3.743','x^{(k+1)}=G(x^{(k)})','theorem',@src_89),
('3.744','Gleichung 3.744','\\|x^{(k)}-x^\\ast\\|\\leq q^k\\|x^{(0)}-x^\\ast\\|','theorem',@src_89),
('3.745','Gleichung 3.745','\\|x^{(k)}-x^\\ast\\|\\leq\\frac{q}{1-q}\\|x^{(k)}-x^{(k-1)}\\|','theorem',@src_89),
('3.746','Gleichung 3.746','\\sup_{x\\in D}\\|J_G(x)\\|\\leq q<1','theorem',@src_89),
('3.747','Gleichung 3.747','|G''(x)|\\leq q<1','theorem',@src_89),
('3.748','Gleichung 3.748','|G''(x^\\ast)|>1','theorem',@src_89),
('3.749','Gleichung 3.749','\\|F(x^{(k)})\\|\\leq\\varepsilon_F','metric',@src_89),
('3.750','Gleichung 3.750','\\|s^{(k)}\\|\\leq\\varepsilon_x','metric',@src_89),
('3.751','Gleichung 3.751','\\frac{\\|s^{(k)}\\|}{\\max\\{1,\\|x^{(k)}\\|\\}}\\leq\\varepsilon_x','metric',@src_89),
('3.752','Gleichung 3.752','k\\leq k_{\\max}','metric',@src_89),
('3.753','Gleichung 3.753','\\det J_F(x^{(k)})=0','other',@src_85),
('3.754','Gleichung 3.754','\\kappa(J_F(x^{(k)}))','metric',@src_85),
('3.755','Gleichung 3.755','\\delta F\\quad\\Longrightarrow\\quad\\delta s\\ \\text{stark vergrößert}','other',@src_85),
('3.756','Gleichung 3.756','F(x_1^\\ast)=0,\\qquad F(x_2^\\ast)=0,\\qquad x_1^\\ast\\neq x_2^\\ast','other',@src_89),
('3.757','Gleichung 3.757','\\mathcal{B}(x^\\ast)=\\left\\{x^{(0)}\\;\\middle|\\;x^{(k)}\\rightarrow x^\\ast\\right\\}','other',@src_89),
('3.758','Gleichung 3.758','F(x+h)\\approx F(x)+J_F(x)h','derived',@src_89),
('3.759','Gleichung 3.759','x^{(0)}','definition',@src_89),
('3.760','Gleichung 3.760','\\varepsilon_F','definition',@src_89),
('3.761','Gleichung 3.761','\\varepsilon_x','definition',@src_89),
('3.762','Gleichung 3.762','k_{\\max}','definition',@src_89),
('3.763','Gleichung 3.763','\\alpha_k','definition',@src_89),
('3.764','Gleichung 3.764','\\text{nichtlineares Problem}\\quad\\longrightarrow\\quad\\text{lokales lineares Ersatzproblem}','other',@src_89),
('3.765','Gleichung 3.765','J_F(x^{(k)})s^{(k)}=-F(x^{(k)})','derived',@src_89),
('3.766','Gleichung 3.766','\\text{Das Verfahren ist definiert.}','other',@src_89),
('3.767','Gleichung 3.767','\\text{Das Verfahren konvergiert.}','other',@src_89),
('3.768','Gleichung 3.768','\\text{Das Verfahren konvergiert zur gewünschten Lösung.}','other',@src_89);
INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT equation_number,@section,title,latex,latex,CONCAT('Formale Gleichung ',equation_number,' aus Abschnitt 3.2.18.'),equation_type,'adapted',source_id,'In Abschnitt 3.2.18 definiert oder hergeleitet.','Differenzierbarkeit und die jeweils genannten Voraussetzungen.','verified',@revision FROM tmp_e
WHERE NOT EXISTS (SELECT 1 FROM equations e WHERE e.equation_number COLLATE utf8mb4_general_ci=tmp_e.equation_number COLLATE utf8mb4_general_ci);
UPDATE equations e JOIN tmp_e t ON e.equation_number COLLATE utf8mb4_general_ci=t.equation_number COLLATE utf8mb4_general_ci
SET e.section_id=@section,e.title=t.title,e.equation_latex=t.latex,e.word_latex=t.latex,e.plain_description=CONCAT('Formale Gleichung ',e.equation_number,' aus Abschnitt 3.2.18.'),e.equation_type=t.equation_type,e.provenance='adapted',e.source_id=t.source_id,e.validation_status='verified',e.created_revision_id=COALESCE(e.created_revision_id,@revision);
INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'created','Abschnitt 3.2.18 mit Literatur, Definitionen, Sätzen und Gleichungen vollständig eingetragen.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section);
INSERT INTO repository_counters(counter_key,counter_value) VALUES
('current_section','3.2.19'),('last_completed_section','3.2.18'),('last_definition_number','3.2.68'),('next_definition_number','3.2.69'),('last_theorem_number','3.2.16'),('next_theorem_number','3.2.17'),('last_equation_number','3.768'),('next_equation_number','3.769'),('last_citation_number','89'),('next_citation_number','90')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);
DROP TEMPORARY TABLE IF EXISTS tmp_d; DROP TEMPORARY TABLE IF EXISTS tmp_t; DROP TEMPORARY TABLE IF EXISTS tmp_e;
COMMIT;
SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.2.18';
SELECT COUNT(*) AS definitionen FROM definitions WHERE section_id=@section AND definition_number BETWEEN '3.2.63' AND '3.2.68';
SELECT COUNT(*) AS saetze FROM theorems WHERE section_id=@section AND theorem_number IN ('3.2.15','3.2.16');
SELECT COUNT(*) AS gleichungen FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 674 AND 768;
SELECT COUNT(*) AS literaturverwendungen FROM source_usage WHERE section_id=@section;
