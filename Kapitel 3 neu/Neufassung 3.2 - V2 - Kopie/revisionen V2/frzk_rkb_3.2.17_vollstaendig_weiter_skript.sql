-- FRZK-Repository: Abschnitt 3.2.17
SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.17-V1',NOW(),'section','3.2.17','3.2.17-v1',
       'Abschnitt 3.2.17: iterative Lösungsverfahren und Konvergenz.',
       'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
  SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.17-V1'
);

SET @revision := (
  SELECT revision_id FROM repository_revisions
  WHERE revision_code='RKB-NEU-K3.2.17-V1' LIMIT 1
);
SET @parent_section := (
  SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.17','Iterative Lösungsverfahren und Konvergenz',
       3,3.2170,'final',0,
       'Definitionen 3.2.57–3.2.62; Satz 3.2.14; Gleichungen 3.574–3.673; Literatur [84], [85], [88].'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.17');

SET @section := (
  SELECT section_id FROM dissertation_sections WHERE section_code='3.2.17' LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Saad','Yousef','Saad, Yousef','Autor der Quelle [88].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Saad, Yousef');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 88,'saad_iterative_methods_2003','book','Iterative Methods for Sparse Linear Systems',
       2003,2003,'Society for Industrial and Applied Mathematics','Philadelphia','2nd edition',
       '978-0-89871-534-7','en',1,'monograph',9,'verified','3.2.17',
       'Erstnennung für iterative Verfahren, Krylov-Unterräume und Vorkonditionierung.',
       'Saad, Yousef: Iterative Methods for Sparse Linear Systems. 2nd edition. Philadelphia: SIAM, 2003.',
       'Saad, Iterative Methods [88]',
       'Zentrale Referenz für iterative Lösungsverfahren.',@revision
WHERE NOT EXISTS (
  SELECT 1 FROM sources WHERE citation_number=88 OR source_key='saad_iterative_methods_2003'
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_85 := (SELECT source_id FROM sources WHERE citation_number=85 LIMIT 1);
SET @src_88 := (SELECT source_id FROM sources WHERE citation_number=88 LIMIT 1);
SET @author_saad := (SELECT author_id FROM authors WHERE normalized_name='Saad, Yousef' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_88,@author_saad,1,'author'
WHERE @src_88 IS NOT NULL AND @author_saad IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM source_authors WHERE source_id=@src_88 AND author_id=@author_saad
);

DELETE FROM source_usage
WHERE section_id=@section AND source_id IN (@src_84,@src_85,@src_88);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Jacobi-, Gauß-Seidel- und CG-Verfahren.','3.2.17',0,1,'Wiederverwendung [84].',@revision),
(@src_85,@section,'background','Residuum, Fehler und numerische Stabilität.','3.2.17',0,1,'Wiederverwendung [85].',@revision),
(@src_88,@section,'first_citation','Iterationsverfahren, Konvergenz und Vorkonditionierung.','3.2.17',1,1,'Erstnennung [88].',@revision);

CREATE TEMPORARY TABLE tmp_3217_definitions (
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,
 title VARCHAR(500), definition_text LONGTEXT, formal_latex LONGTEXT, source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO tmp_3217_definitions VALUES
('3.2.57','Stationäres Iterationsverfahren','Iteration mit fester Matrix B und konstantem Vektor c.','x^{(k+1)}=Bx^{(k)}+c',@src_88),
('3.2.58','Iterationsfehler','Differenz zwischen exakter Lösung und aktueller Näherung.','e^{(k)}=x^\ast-x^{(k)}',@src_88),
('3.2.59','Residuum eines Iterationsschrittes','Abweichung der Näherung von der Systemgleichung.','r^{(k)}=b-Ax^{(k)}',@src_85),
('3.2.60','Strikte Diagonaldominanz','Der Betrag jedes Diagonaleintrags übersteigt die Summe der übrigen Beträge seiner Zeile.','|a_{ii}|>\sum_{\substack{j=1\\j\neq i}}^n|a_{ij}|',@src_88),
('3.2.61','Konvergenzordnung','Asymptotische Beziehung zwischen aufeinanderfolgenden Fehlern.','\|x^{(k+1)}-x^\ast\|\leq C\|x^{(k)}-x^\ast\|^p',@src_88),
('3.2.62','Vorkonditioniertes Gleichungssystem','Transformation eines Systems durch einen einfach invertierbaren Vorkonditionierer.','P^{-1}Ax=P^{-1}b',@src_88);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
SELECT t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
       'adapted',t.source_id,'Reelle endlichdimensionale Räume.',
       'Etablierte Definition der numerischen linearen Algebra.','verified',@revision
FROM tmp_3217_definitions t
WHERE NOT EXISTS (
  SELECT 1 FROM definitions d
  WHERE d.definition_number COLLATE utf8mb4_general_ci =
        t.definition_number COLLATE utf8mb4_general_ci
);

UPDATE definitions d
JOIN tmp_3217_definitions t
 ON d.definition_number COLLATE utf8mb4_general_ci =
    t.definition_number COLLATE utf8mb4_general_ci
SET d.section_id=@section,d.title=t.title,d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,d.word_latex=t.formal_latex,
    d.provenance='adapted',d.source_id=t.source_id,d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,
 assumptions,validation_status,created_revision_id)
SELECT '3.2.14',@section,'Konvergenzkriterium stationärer Iterationen',
       'Das Verfahren x^(k+1)=Bx^(k)+c konvergiert für jeden Startvektor genau dann, wenn rho(B)<1 gilt.',
       '\rho(B)<1','\rho(B)<1','literature',@src_88,
       'B ist quadratisch; aus e^(k)=B^k e^(0) folgt das Spektralradiuskriterium.',
       'verified',@revision
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.2.14');

UPDATE theorems
SET section_id=@section,title='Konvergenzkriterium stationärer Iterationen',
    statement_text='Das Verfahren x^(k+1)=Bx^(k)+c konvergiert für jeden Startvektor genau dann, wenn rho(B)<1 gilt.',
    statement_latex='\rho(B)<1',word_latex='\rho(B)<1',provenance='literature',
    source_id=@src_88,
    assumptions='B ist quadratisch; aus e^(k)=B^k e^(0) folgt das Spektralradiuskriterium.',
    validation_status='verified',created_revision_id=COALESCE(created_revision_id,@revision)
WHERE theorem_number='3.2.14';

CREATE TEMPORARY TABLE tmp_3217_equations (
 equation_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,
 title VARCHAR(500), latex TEXT, equation_type VARCHAR(20), source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO tmp_3217_equations VALUES
('3.574','Lineares Gleichungssystem','Ax=b,\\qquad A\\in\\mathbb{R}^{n\\times n},\\qquad b\\in\\mathbb{R}^{n}','definition',@src_84),
('3.575','Stationäre Iterationsvorschrift','x^{(k+1)}=Bx^{(k)}+c','definition',@src_88),
('3.576','Iterationsnäherung','x^{(k)}','definition',@src_88),
('3.577','Iterationsmatrix','B\\in\\mathbb{R}^{n\\times n}','definition',@src_88),
('3.578','Konstanter Iterationsvektor','c\\in\\mathbb{R}^{n}','definition',@src_88),
('3.579','Fixpunktgleichung','x^\\ast=Bx^\\ast+c','definition',@src_88),
('3.580','Umgeformte Fixpunktgleichung','(I-B)x^\\ast=c','derived',@src_88),
('3.581','Übereinstimmung mit Ausgangssystem','Ax^\\ast=b','derived',@src_88),
('3.582','Matrixzerlegung','A=M-N','definition',@src_88),
('3.583','Zerlegte Systemgleichung','(M-N)x=b','derived',@src_88),
('3.584','Umgestellte Systemgleichung','Mx=Nx+b','derived',@src_88),
('3.585','Implizite Iterationsvorschrift','Mx^{(k+1)}=Nx^{(k)}+b','definition',@src_88),
('3.586','Explizite Iterationsvorschrift','x^{(k+1)}=M^{-1}Nx^{(k)}+M^{-1}b','definition',@src_88),
('3.587','Iterationsmatrix aus der Zerlegung','B=M^{-1}N','definition',@src_88),
('3.588','Iterationsvektor aus der Zerlegung','c=M^{-1}b','definition',@src_88),
('3.589','Exakte Lösung','Ax^\\ast=b','definition',@src_88),
('3.590','Iterationsfehler','e^{(k)}=x^\\ast-x^{(k)}','definition',@src_88),
('3.591','Iterationsgleichung','x^{(k+1)}=Bx^{(k)}+c','definition',@src_88),
('3.592','Fixpunktgleichung der exakten Lösung','x^\\ast=Bx^\\ast+c','definition',@src_88),
('3.593','Fehlerrekursion','e^{(k+1)}=Be^{(k)}','theorem',@src_88),
('3.594','Fehler nach k Schritten','e^{(k)}=B^k e^{(0)}','theorem',@src_88),
('3.595','Stationäre Iteration','x^{(k+1)}=Bx^{(k)}+c','definition',@src_88),
('3.596','Spektralradiuskriterium','\\rho(B)<1','theorem',@src_88),
('3.597','Definition des Spektralradius','\\rho(B)=\\max\\left\\{|\\lambda|\\;\\middle|\\;\\lambda\\in\\sigma(B)\\right\\}','definition',@src_88),
('3.598','Fehlerdarstellung über Matrixpotenzen','e^{(k)}=B^k e^{(0)}','derived',@src_88),
('3.599','Verschwinden des Fehlers','e^{(k)}\\rightarrow 0','theorem',@src_88),
('3.600','Verschwinden der Matrixpotenzen','B^k\\rightarrow 0','theorem',@src_88),
('3.601','Äquivalentes Spektralradiuskriterium','\\rho(B)<1','theorem',@src_88),
('3.602','Nichtkonvergenter Eigenwertbereich','|\\lambda|\\geq 1','theorem',@src_88),
('3.603','Residuum eines Iterationsschritts','r^{(k)}=b-Ax^{(k)}','definition',@src_85),
('3.604','Residuum der exakten Lösung','r^\\ast=b-Ax^\\ast=0','definition',@src_85),
('3.605','Beziehung zwischen Residuum und Fehler','r^{(k)}=Ae^{(k)}','theorem',@src_85),
('3.606','Fehlerdefinition','e^{(k)}=x^\\ast-x^{(k)}','definition',@src_85),
('3.607','Herleitung der Residuum-Fehler-Beziehung','Ae^{(k)}=Ax^\\ast-Ax^{(k)}=b-Ax^{(k)}','derived',@src_85),
('3.608','Fehler aus Residuum','e^{(k)}=A^{-1}r^{(k)}','theorem',@src_85),
('3.609','Fehlerabschätzung über Residuum','\\|e^{(k)}\\|\\leq\\|A^{-1}\\|\\,\\|r^{(k)}\\|','theorem',@src_85),
('3.610','Jacobi-Zerlegung','A=D+L+U','definition',@src_88),
('3.611','Diagonalmatrix','D=\\operatorname{diag}(a_{11},a_{22},\\ldots,a_{nn})','definition',@src_88),
('3.612','Zerlegte Jacobi-Gleichung','(D+L+U)x=b','derived',@src_88),
('3.613','Umgestellte Jacobi-Gleichung','Dx=-(L+U)x+b','derived',@src_88),
('3.614','Implizites Jacobi-Verfahren','Dx^{(k+1)}=-(L+U)x^{(k)}+b','definition',@src_88),
('3.615','Explizites Jacobi-Verfahren','x^{(k+1)}=-D^{-1}(L+U)x^{(k)}+D^{-1}b','definition',@src_88),
('3.616','Jacobi-Iterationsmatrix','B_J=-D^{-1}(L+U)','definition',@src_88),
('3.617','Komponentenform des Jacobi-Verfahrens','x_i^{(k+1)}=\\frac{1}{a_{ii}}\\left(b_i-\\sum_{\\substack{j=1\\\\j\\neq i}}^{n}a_{ij}x_j^{(k)}\\right)','definition',@src_88),
('3.618','Nichtverschwindende Diagonaleinträge','a_{ii}\\neq 0\\qquad\\text{für alle }i','definition',@src_88),
('3.619','Gauß-Seidel-Zerlegung','A=D+L+U','definition',@src_88),
('3.620','Umgestellte Gauß-Seidel-Gleichung','(D+L)x=-Ux+b','derived',@src_88),
('3.621','Implizites Gauß-Seidel-Verfahren','(D+L)x^{(k+1)}=-Ux^{(k)}+b','definition',@src_88),
('3.622','Explizites Gauß-Seidel-Verfahren','x^{(k+1)}=-(D+L)^{-1}Ux^{(k)}+(D+L)^{-1}b','definition',@src_88),
('3.623','Gauß-Seidel-Iterationsmatrix','B_{\\mathrm{GS}}=-(D+L)^{-1}U','definition',@src_88),
('3.624','Komponentenform des Gauß-Seidel-Verfahrens','x_i^{(k+1)}=\\frac{1}{a_{ii}}\\left(b_i-\\sum_{j=1}^{i-1}a_{ij}x_j^{(k+1)}-\\sum_{j=i+1}^{n}a_{ij}x_j^{(k)}\\right)','definition',@src_88),
('3.625','Allgemeine quadratische Matrix','A=(a_{ij})\\in\\mathbb{R}^{n\\times n}','definition',@src_88),
('3.626','Strikte Diagonaldominanz','|a_{ii}|>\\sum_{\\substack{j=1\\\\j\\neq i}}^{n}|a_{ij}|','definition',@src_88),
('3.627','Vorläufiger Iterationswert','\\widetilde{x}^{(k+1)}','definition',@src_88),
('3.628','Relaxationsschritt','x^{(k+1)}=x^{(k)}+\\omega\\left(\\widetilde{x}^{(k+1)}-x^{(k)}\\right)','definition',@src_88),
('3.629','Positiver Relaxationsparameter','\\omega>0','definition',@src_88),
('3.630','Unterrelaxation','0<\\omega<1','definition',@src_88),
('3.631','Unverändertes Grundverfahren','\\omega=1','definition',@src_88),
('3.632','Überrelaxation','\\omega>1','definition',@src_88),
('3.633','Konvergenzordnung','\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^p','definition',@src_88),
('3.634','Positive Konvergenzkonstante','C>0','definition',@src_88),
('3.635','Lineare Konvergenzordnung','p=1','definition',@src_88),
('3.636','Quadratische Konvergenzordnung','p=2','definition',@src_88),
('3.637','Asymptotische Fehlerabschätzung','\\|e^{(k)}\\|\\approx C\\,\\rho(B)^k','metric',@src_88),
('3.638','Tatsächlicher Iterationsfehler','\\|x^\\ast-x^{(k)}\\|','metric',@src_85),
('3.639','Absolutes Residualkriterium','\\|r^{(k)}\\|\\leq\\varepsilon_{\\mathrm{abs}}','metric',@src_85),
('3.640','Relatives Residualkriterium','\\frac{\\|r^{(k)}\\|}{\\|b\\|}\\leq\\varepsilon_{\\mathrm{rel}}','metric',@src_85),
('3.641','Absolutes Änderungskriterium','\\|x^{(k+1)}-x^{(k)}\\|\\leq\\varepsilon_x','metric',@src_85),
('3.642','Relatives Änderungskriterium','\\frac{\\|x^{(k+1)}-x^{(k)}\\|}{\\max\\{1,\\|x^{(k+1)}\\|\\}}\\leq\\varepsilon_x','metric',@src_85),
('3.643','Maximale Iterationszahl','k\\leq k_{\\max}','metric',@src_85),
('3.644','Vorkonditionierer','P\\in\\mathbb{R}^{n\\times n}','definition',@src_88),
('3.645','Linke Vorkonditionierung','P^{-1}Ax=P^{-1}b','definition',@src_88),
('3.646','Substitution bei rechter Vorkonditionierung','x=P^{-1}y','definition',@src_88),
('3.647','Rechts vorkonditioniertes System','AP^{-1}y=b','definition',@src_88),
('3.648','Ideale Vorkonditionierung','P^{-1}A\\approx I','other',@src_88),
('3.649','Qualität der Approximation','\\text{Qualität der Approximation}','other',@src_88),
('3.650','Aufwand des Vorkonditionierers','\\text{Aufwand der Anwendung von }P^{-1}','other',@src_88),
('3.651','Allgemeiner nichtstationärer Schritt','x^{(k+1)}=x^{(k)}+\\alpha_k p^{(k)}','definition',@src_88),
('3.652','Suchrichtung','p^{(k)}','definition',@src_88),
('3.653','Schrittlänge','\\alpha_k','definition',@src_88),
('3.654','A-Konjugiertheit der Suchrichtungen','(p^{(i)})^{\\mathsf T}Ap^{(j)}=0\\qquad\\text{für }i\\neq j','theorem',@src_88),
('3.655','CG-Iterationsschritt','x^{(k+1)}=x^{(k)}+\\alpha_k p^{(k)}','definition',@src_88),
('3.656','CG-Residualaktualisierung','r^{(k+1)}=r^{(k)}-\\alpha_kAp^{(k)}','definition',@src_88),
('3.657','CG-Schrittlänge','\\alpha_k=\\frac{(r^{(k)})^{\\mathsf T}r^{(k)}}{(p^{(k)})^{\\mathsf T}Ap^{(k)}}','definition',@src_88),
('3.658','CG-Suchrichtungsaktualisierung','p^{(k+1)}=r^{(k+1)}+\\beta_k p^{(k)}','definition',@src_88),
('3.659','CG-Koeffizient Beta','\\beta_k=\\frac{(r^{(k+1)})^{\\mathsf T}r^{(k+1)}}{(r^{(k)})^{\\mathsf T}r^{(k)}}','definition',@src_88),
('3.660','CG-Fehlerabschätzung','\\|e^{(k)}\\|_A\\leq 2\\left(\\frac{\\sqrt{\\kappa_2(A)}-1}{\\sqrt{\\kappa_2(A)}+1}\\right)^k\\|e^{(0)}\\|_A','theorem',@src_88),
('3.661','Energienorm','\\|x\\|_A=\\sqrt{x^{\\mathsf T}Ax}','definition',@src_88),
('3.662','Große Konditionszahl','\\kappa_2(A)\\gg 1','metric',@src_85),
('3.663','Verbesserte Kondition durch Vorkonditionierung','\\kappa_2(P^{-1}A)<\\kappa_2(A)','metric',@src_88),
('3.664','Startvektor','x^{(0)}','definition',@src_88),
('3.665','Toleranz','\\varepsilon','definition',@src_85),
('3.666','Maximale Iterationszahl','k_{\\max}','definition',@src_85),
('3.667','Verwendete Norm','\\|\\cdot\\|','definition',@src_85),
('3.668','Vorkonditionierer als Dokumentationsgröße','P','definition',@src_88),
('3.669','Dokumentierter Residualverlauf','\\left\\{\\|r^{(k)}\\|\\right\\}_{k=0}^{K}','metric',@src_85),
('3.670','Fehlerfortschritt','e^{(k+1)}=Be^{(k)}','theorem',@src_88),
('3.671','Gedämpfte Eigenwertrichtung','|\\lambda|<1','theorem',@src_88),
('3.672','Verstärkte Eigenwertrichtung','|\\lambda|>1','theorem',@src_88),
('3.673','Residuum-Fehler-Zusammenhang','r^{(k)}=Ae^{(k)}','theorem',@src_85);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT t.equation_number,@section,t.title,t.latex,t.latex,
       CONCAT('Formale Gleichung ',t.equation_number,' aus Abschnitt 3.2.17.'),
       t.equation_type,'adapted',t.source_id,
       'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.',
       'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.',
       'verified',@revision
FROM tmp_3217_equations t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_general_ci =
       t.equation_number COLLATE utf8mb4_general_ci
);

UPDATE equations e
JOIN tmp_3217_equations t
 ON e.equation_number COLLATE utf8mb4_general_ci =
    t.equation_number COLLATE utf8mb4_general_ci
SET e.section_id=@section,e.title=t.title,e.equation_latex=t.latex,e.word_latex=t.latex,
    e.plain_description=CONCAT('Formale Gleichung ',e.equation_number,' aus Abschnitt 3.2.17.'),
    e.equation_type=t.equation_type,e.provenance='adapted',e.source_id=t.source_id,
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'created',
       'Abschnitt 3.2.17 einschließlich Literatur, Definitionen, Satz und Gleichungen vollständig eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.18'),
('last_completed_section','3.2.17'),
('last_definition_number','3.2.62'),
('next_definition_number','3.2.63'),
('last_theorem_number','3.2.14'),
('next_theorem_number','3.2.15'),
('last_equation_number','3.673'),
('next_equation_number','3.674'),
('last_citation_number','88'),
('next_citation_number','89')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_3217_definitions;
DROP TEMPORARY TABLE IF EXISTS tmp_3217_equations;
COMMIT;

SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.2.17';
SELECT COUNT(*) AS definitionen FROM definitions WHERE section_id=@section;
SELECT COUNT(*) AS saetze FROM theorems WHERE section_id=@section AND theorem_number='3.2.14';
SELECT COUNT(*) AS gleichungen FROM equations
 WHERE section_id=@section
 AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 574 AND 673;
SELECT COUNT(*) AS literaturverwendungen FROM source_usage WHERE section_id=@section;
