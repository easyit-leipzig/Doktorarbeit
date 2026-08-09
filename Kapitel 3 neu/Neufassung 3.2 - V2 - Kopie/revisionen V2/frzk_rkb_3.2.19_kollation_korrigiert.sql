-- FRZK-Repository – Abschnitt 3.2.19
-- Korrigierte Fassung: einheitliche Kollation utf8mb4_unicode_ci
-- Behebt MySQL-Fehler #1267 bei Vergleichen in NOT EXISTS
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.19-V1',NOW(),'section','3.2.19','3.2.19-v1',
'Abschnitt 3.2.19: gewöhnliche Differentialgleichungen und dynamische Zustandsentwicklung.',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.19-V1');

SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.19-V1' LIMIT 1);
SET @parent_section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.19','Gewöhnliche Differentialgleichungen und dynamische Zustandsentwicklung',
3,3.2190,'final',0,
'Definitionen 3.2.69–3.2.84; Sätze 3.2.17–3.2.19; Gleichungen 3.769–3.889; Literatur [84], [85], [90].'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.19');

SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.19' LIMIT 1);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Hairer','Ernst','Hairer, Ernst','Autor der Quelle [90].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Hairer, Ernst');
INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Nørsett','Syvert P.','Nørsett, Syvert P.','Autor der Quelle [90].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Nørsett, Syvert P.');
INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Wanner','Gerhard','Wanner, Gerhard','Autor der Quelle [90].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Wanner, Gerhard');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 90,'hairer_norsett_wanner_ode1_1993','book',
'Solving Ordinary Differential Equations I: Nonstiff Problems',
1993,1993,'Springer','Berlin, Heidelberg','2nd revised edition','978-3-540-56670-0','en',
1,'monograph',9,'verified','3.2.19',
'Erstnennung für Anfangswertprobleme und numerische Zeitintegration.',
'Hairer, Ernst; Nørsett, Syvert P.; Wanner, Gerhard: Solving Ordinary Differential Equations I: Nonstiff Problems. 2nd revised edition. Springer, 1993.',
'Hairer/Nørsett/Wanner, ODE I [90]',
'Zentrale Referenz für gewöhnliche Differentialgleichungen.',@revision
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=90 OR source_key='hairer_norsett_wanner_ode1_1993');

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_85 := (SELECT source_id FROM sources WHERE citation_number=85 LIMIT 1);
SET @src_90 := (SELECT source_id FROM sources WHERE citation_number=90 LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_90,author_id,1,'author' FROM authors
WHERE normalized_name='Hairer, Ernst'
AND NOT EXISTS (SELECT 1 FROM source_authors sa WHERE sa.source_id=@src_90 AND sa.author_id=authors.author_id);
INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_90,author_id,2,'author' FROM authors
WHERE normalized_name='Nørsett, Syvert P.'
AND NOT EXISTS (SELECT 1 FROM source_authors sa WHERE sa.source_id=@src_90 AND sa.author_id=authors.author_id);
INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_90,author_id,3,'author' FROM authors
WHERE normalized_name='Wanner, Gerhard'
AND NOT EXISTS (SELECT 1 FROM source_authors sa WHERE sa.source_id=@src_90 AND sa.author_id=authors.author_id);

DELETE FROM source_usage WHERE section_id=@section AND source_id IN (@src_84,@src_85,@src_90);
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Matrixexponentialfunktion und lineare Systeme.','3.2.19',0,1,'Wiederverwendung [84].',@revision),
(@src_85,@section,'background','Rundungsfehler und numerische Stabilität.','3.2.19',0,1,'Wiederverwendung [85].',@revision),
(@src_90,@section,'first_citation','Anfangswertprobleme und numerische Zeitintegration.','3.2.19',1,1,'Erstnennung [90].',@revision);

CREATE TEMPORARY TABLE tmp_defs (
definition_number VARCHAR(50)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_unicode_ci
        PRIMARY KEY,
title VARCHAR(500),
definition_text LONGTEXT,
formal_latex LONGTEXT,
source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.69','Gewöhnliche Differentialgleichung erster Ordnung','Differentialgleichung erster Ordnung.','\\dot{x}=f(t,x)',@src_90),
('3.2.70','Anfangswertproblem','Differentialgleichung mit Anfangszustand.','\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0',@src_90),
('3.2.71','Klassische Lösung','Stetig differenzierbare punktweise Lösung.','\\dot{x}(t)=f(t,x(t))',@src_90),
('3.2.72','Fluss eines autonomen Systems','Zeitentwicklungsabbildung.','\\Phi_t(x_0)=x(t;x_0)',@src_90),
('3.2.73','Trajektorie','Weg eines Zustands durch den Zustandsraum.','\\mathcal{T}(x_0)=\\{\\Phi_t(x_0)\\mid t\\in I\\}',@src_90),
('3.2.74','Gleichgewichtspunkt','Zustand mit verschwindendem Vektorfeld.','f(x^\\ast)=0',@src_90),
('3.2.75','Matrixexponentialfunktion','Potenzreihendefinition der Matrixexponentialfunktion.','\\mathrm{e}^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}',@src_84),
('3.2.76','Stabilität im Sinne von Ljapunow','Kleine Anfangsabweichungen bleiben klein.','\\|x(0)-x^\\ast\\|<\\delta\\Rightarrow\\|x(t)-x^\\ast\\|<\\varepsilon',@src_90),
('3.2.77','Asymptotische Stabilität','Stabilität mit Konvergenz zum Gleichgewicht.','x(t)\\rightarrow x^\\ast',@src_90),
('3.2.78','Hyperbolischer Gleichgewichtspunkt','Kein Eigenwert liegt auf der imaginären Achse.','\\operatorname{Re}(\\lambda_i)\\neq0',@src_90),
('3.2.79','Explizites Euler-Verfahren','Explizites Einschrittverfahren erster Ordnung.','x^{(k+1)}=x^{(k)}+hf(t_k,x^{(k)})',@src_90),
('3.2.80','Implizites Euler-Verfahren','Implizites Einschrittverfahren.','x^{(k+1)}=x^{(k)}+hf(t_{k+1},x^{(k+1)})',@src_90),
('3.2.81','Konsistenz eines Zeitintegrationsverfahrens','Lokaler Fehler verschwindet für h gegen null.','\\tau_k\\rightarrow0',@src_90),
('3.2.82','Konvergenz eines Zeitintegrationsverfahrens','Diskrete Lösung nähert sich der exakten Lösung.','\\max_k\\|x(t_k)-x^{(k)}\\|\\rightarrow0',@src_90),
('3.2.83','Steifes Differentialgleichungssystem','System mit stark verschiedenen Zeitskalen.','|\\operatorname{Re}(\\lambda_{\\max})|\\gg|\\operatorname{Re}(\\lambda_{\\min})|',@src_90),
('3.2.84','Adaptive Schrittweitensteuerung','Fehlerabhängige Anpassung der Schrittweite.','h_{\\mathrm{neu}}=\\eta h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}}',@src_90);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT definition_number,@section,title,definition_text,formal_latex,formal_latex,'adapted',source_id,
'Voraussetzungen gemäß Abschnitt 3.2.19.','Etablierte Definition.','verified',@revision
FROM tmp_defs t WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number COLLATE utf8mb4_unicode_ci
        = t.definition_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_thms (
theorem_number VARCHAR(50)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_unicode_ci
        PRIMARY KEY,
title VARCHAR(500),
statement_text LONGTEXT,
statement_latex LONGTEXT,
assumptions LONGTEXT,
source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms VALUES
('3.2.17','Lokale Existenz und Eindeutigkeit','Unter Stetigkeit und lokaler Lipschitz-Stetigkeit besitzt das Anfangswertproblem lokal genau eine Lösung.','\\|f(t,x)-f(t,y)\\|\\leq L\\|x-y\\|','Stetigkeit und lokale Lipschitz-Bedingung.',@src_90),
('3.2.18','Stabilität linearer autonomer Systeme','Negative Realteile aller Eigenwerte sichern asymptotische Stabilität; ein positiver Realteil erzeugt Instabilität.','\\operatorname{Re}(\\lambda_i)<0','Lineares autonomes System.',@src_90),
('3.2.19','Lokale Stabilität durch Linearisierung','Das Spektrum der Jacobi-Matrix bestimmt bei hyperbolischem Gleichgewicht die lokale Stabilität.','A=J_f(x^\\ast)','Differenzierbarkeit und Hyperbolizität.',@src_90);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT theorem_number,@section,title,statement_text,statement_latex,statement_latex,'literature',source_id,assumptions,'verified',@revision
FROM tmp_thms t WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number COLLATE utf8mb4_unicode_ci
        = t.theorem_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_eq (
equation_number VARCHAR(50)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_unicode_ci
        PRIMARY KEY,
title VARCHAR(500),
latex TEXT,
equation_type VARCHAR(20),
source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eq VALUES
('3.769','Gleichung 3.769','\\frac{\\mathrm{d}x}{\\mathrm{d}t}=f(t,x)','other',@src_90),
('3.770','Gleichung 3.770','t\\in I\\subseteq\\mathbb{R}','other',@src_90),
('3.771','Gleichung 3.771','x:I\\rightarrow\\mathbb{R}^{n}','other',@src_90),
('3.772','Gleichung 3.772','f:I\\times\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{n}','other',@src_90),
('3.773','Gleichung 3.773','\\dot{x}(t)=\\frac{\\mathrm{d}x(t)}{\\mathrm{d}t}','other',@src_90),
('3.774','Gleichung 3.774','\\dot{x}=f(t,x)','other',@src_90),
('3.775','Gleichung 3.775','\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0','other',@src_90),
('3.776','Gleichung 3.776','t_0\\in I','other',@src_90),
('3.777','Gleichung 3.777','x_0\\in\\mathbb{R}^{n}','other',@src_90),
('3.778','Gleichung 3.778','x:I\\rightarrow\\mathbb{R}^{n}','other',@src_90),
('3.779','Gleichung 3.779','\\dot{x}(t)=f(t,x(t))','other',@src_90),
('3.780','Gleichung 3.780','x(t_0)=x_0','other',@src_90),
('3.781','Gleichung 3.781','\\dot{x}(t)=f(t,x(t))','other',@src_90),
('3.782','Gleichung 3.782','x(t)-x(t_0)=\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau','other',@src_90),
('3.783','Gleichung 3.783','x(t)=x_0+\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau','other',@src_90),
('3.784','Gleichung 3.784','\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0','other',@src_90),
('3.785','Gleichung 3.785','\\|f(t,x)-f(t,y)\\|\\leq L\\|x-y\\|','other',@src_90),
('3.786','Gleichung 3.786','L\\geq 0','other',@src_90),
('3.787','Gleichung 3.787','\\dot{x}=f(x)','other',@src_90),
('3.788','Gleichung 3.788','\\dot{x}(t)=f(x(t)),\\qquad x(0)=x_0','other',@src_90),
('3.789','Gleichung 3.789','\\Phi_t(x_0)=x(t;x_0)','other',@src_90),
('3.790','Gleichung 3.790','x(t;x_0)','other',@src_90),
('3.791','Gleichung 3.791','\\Phi_0(x)=x','other',@src_90),
('3.792','Gleichung 3.792','\\Phi_{t+s}(x)=\\Phi_t(\\Phi_s(x))','other',@src_90),
('3.793','Gleichung 3.793','\\mathcal{T}(x_0)=\\left\\{\\Phi_t(x_0)\\;\\middle|\\;t\\in I\\right\\}','other',@src_90),
('3.794','Gleichung 3.794','\\dot{x}=f(x)','other',@src_90),
('3.795','Gleichung 3.795','f(x^\\ast)=0','other',@src_90),
('3.796','Gleichung 3.796','x(0)=x^\\ast\\quad\\Longrightarrow\\quad x(t)=x^\\ast','other',@src_90),
('3.797','Gleichung 3.797','\\dot{x}(t)=Ax(t)','other',@src_90),
('3.798','Gleichung 3.798','A\\in\\mathbb{R}^{n\\times n}','other',@src_90),
('3.799','Gleichung 3.799','\\dot{x}(t)=Ax(t),\\qquad x(0)=x_0','other',@src_90),
('3.800','Gleichung 3.800','x(t)=\\mathrm{e}^{tA}x_0','other',@src_90),
('3.801','Gleichung 3.801','\\mathrm{e}^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}','other',@src_90),
('3.802','Gleichung 3.802','\\mathrm{e}^{tA}=I+tA+\\frac{t^2A^2}{2!}+\\frac{t^3A^3}{3!}+\\cdots','other',@src_90),
('3.803','Gleichung 3.803','\\mathrm{e}^{0A}=I','other',@src_90),
('3.804','Gleichung 3.804','\\frac{\\mathrm{d}}{\\mathrm{d}t}\\mathrm{e}^{tA}=A\\mathrm{e}^{tA}=\\mathrm{e}^{tA}A','other',@src_90),
('3.805','Gleichung 3.805','\\frac{\\mathrm{d}}{\\mathrm{d}t}\\left(\\mathrm{e}^{tA}x_0\\right)=A\\mathrm{e}^{tA}x_0','other',@src_90),
('3.806','Gleichung 3.806','A=PDP^{-1}','other',@src_90),
('3.807','Gleichung 3.807','A^k=PD^kP^{-1}','other',@src_90),
('3.808','Gleichung 3.808','\\mathrm{e}^{tA}=P\\mathrm{e}^{tD}P^{-1}','other',@src_90),
('3.809','Gleichung 3.809','D=\\operatorname{diag}(\\lambda_1,\\lambda_2,\\ldots,\\lambda_n)','other',@src_90),
('3.810','Gleichung 3.810','\\mathrm{e}^{tD}=\\operatorname{diag}\\left(\\mathrm{e}^{\\lambda_1t},\\mathrm{e}^{\\lambda_2t},\\ldots,\\mathrm{e}^{\\lambda_nt}\\right)','other',@src_90),
('3.811','Gleichung 3.811','\\dot{x}(t)=Ax(t)+g(t)','other',@src_90),
('3.812','Gleichung 3.812','x(t_0)=x_0','other',@src_90),
('3.813','Gleichung 3.813','x(t)=\\mathrm{e}^{(t-t_0)A}x_0+\\int_{t_0}^{t}\\mathrm{e}^{(t-\\tau)A}g(\\tau)\\,\\mathrm{d}\\tau','other',@src_90),
('3.814','Gleichung 3.814','\\varepsilon>0','other',@src_90),
('3.815','Gleichung 3.815','\\delta>0','other',@src_90),
('3.816','Gleichung 3.816','\\|x(0)-x^\\ast\\|<\\delta','other',@src_90),
('3.817','Gleichung 3.817','\\|x(t)-x^\\ast\\|<\\varepsilon','other',@src_90),
('3.818','Gleichung 3.818','x(t)\\rightarrow x^\\ast\\qquad\\text{für }t\\rightarrow\\infty','other',@src_90),
('3.819','Gleichung 3.819','\\text{kleine Abweichungen bleiben klein}','other',@src_90),
('3.820','Gleichung 3.820','\\text{kleine Abweichungen verschwinden langfristig}','other',@src_90),
('3.821','Gleichung 3.821','\\dot{x}=Ax','other',@src_90),
('3.822','Gleichung 3.822','x^\\ast=0','other',@src_90),
('3.823','Gleichung 3.823','\\operatorname{Re}(\\lambda_i)<0\\qquad\\text{für alle }i','other',@src_90),
('3.824','Gleichung 3.824','\\operatorname{Re}(\\lambda_i)>0','other',@src_90),
('3.825','Gleichung 3.825','\\mathrm{e}^{\\lambda_i t}','other',@src_90),
('3.826','Gleichung 3.826','\\operatorname{Re}(\\lambda_i)<0','other',@src_90),
('3.827','Gleichung 3.827','\\left|\\mathrm{e}^{\\lambda_i t}\\right|=\\mathrm{e}^{\\operatorname{Re}(\\lambda_i)t}\\rightarrow 0','other',@src_90),
('3.828','Gleichung 3.828','\\dot{x}=f(x)','other',@src_90),
('3.829','Gleichung 3.829','f(x^\\ast)=0','other',@src_90),
('3.830','Gleichung 3.830','\\xi=x-x^\\ast','other',@src_90),
('3.831','Gleichung 3.831','f(x^\\ast+\\xi)\\approx f(x^\\ast)+J_f(x^\\ast)\\xi','other',@src_90),
('3.832','Gleichung 3.832','\\dot{\\xi}\\approx J_f(x^\\ast)\\xi','other',@src_90),
('3.833','Gleichung 3.833','A=J_f(x^\\ast)','other',@src_90),
('3.834','Gleichung 3.834','\\dot{x}=f(x)','other',@src_90),
('3.835','Gleichung 3.835','J_f(x^\\ast)','other',@src_90),
('3.836','Gleichung 3.836','\\operatorname{Re}(\\lambda_i)\\neq 0\\qquad\\text{für alle }i','other',@src_90),
('3.837','Gleichung 3.837','t_k=t_0+kh','other',@src_90),
('3.838','Gleichung 3.838','h>0','other',@src_90),
('3.839','Gleichung 3.839','x^{(k)}\\approx x(t_k)','other',@src_90),
('3.840','Gleichung 3.840','\\dot{x}(t_k)\\approx\\frac{x(t_{k+1})-x(t_k)}{h}','other',@src_90),
('3.841','Gleichung 3.841','\\dot{x}(t_k)=f(t_k,x(t_k))','other',@src_90),
('3.842','Gleichung 3.842','x(t_{k+1})\\approx x(t_k)+hf(t_k,x(t_k))','other',@src_90),
('3.843','Gleichung 3.843','x^{(k+1)}=x^{(k)}+hf(t_k,x^{(k)})','other',@src_90),
('3.844','Gleichung 3.844','x^{(k+1)}=x^{(k)}+hf(t_{k+1},x^{(k+1)})','other',@src_90),
('3.845','Gleichung 3.845','G(x^{(k+1)})=x^{(k+1)}-x^{(k)}-hf(t_{k+1},x^{(k+1)})=0','other',@src_90),
('3.846','Gleichung 3.846','x(t_{k+1})=x(t_k)+h\\dot{x}(t_k)+\\frac{h^2}{2}\\ddot{x}(\\xi_k)','other',@src_90),
('3.847','Gleichung 3.847','\\xi_k\\in(t_k,t_{k+1})','other',@src_90),
('3.848','Gleichung 3.848','\\mathcal{O}(h^2)','other',@src_90),
('3.849','Gleichung 3.849','\\mathcal{O}(h)','other',@src_90),
('3.850','Gleichung 3.850','h\\rightarrow 0','other',@src_90),
('3.851','Gleichung 3.851','\\tau_k\\rightarrow 0\\qquad\\text{für }h\\rightarrow 0','other',@src_90),
('3.852','Gleichung 3.852','\\max_{0\\leq k\\leq N}\\|x(t_k)-x^{(k)}\\|\\rightarrow 0\\qquad\\text{für }h\\rightarrow 0','other',@src_90),
('3.853','Gleichung 3.853','Nh=T-t_0','other',@src_90),
('3.854','Gleichung 3.854','\\dot{x}=\\lambda x','other',@src_90),
('3.855','Gleichung 3.855','x(t)=\\mathrm{e}^{\\lambda t}x_0','other',@src_90),
('3.856','Gleichung 3.856','x^{(k+1)}=x^{(k)}+h\\lambda x^{(k)}','other',@src_90),
('3.857','Gleichung 3.857','x^{(k+1)}=(1+h\\lambda)x^{(k)}','other',@src_90),
('3.858','Gleichung 3.858','x^{(k)}=(1+h\\lambda)^kx^{(0)}','other',@src_90),
('3.859','Gleichung 3.859','|1+h\\lambda|<1','other',@src_90),
('3.860','Gleichung 3.860','|1+h\\lambda|<1','other',@src_90),
('3.861','Gleichung 3.861','0<h<\\frac{2}{|\\lambda|}','other',@src_90),
('3.862','Gleichung 3.862','\\dot{x}=Ax','other',@src_90),
('3.863','Gleichung 3.863','|\\operatorname{Re}(\\lambda_{\\max})|\\gg|\\operatorname{Re}(\\lambda_{\\min})|','other',@src_90),
('3.864','Gleichung 3.864','k_1=f(t_k,x^{(k)})','other',@src_90),
('3.865','Gleichung 3.865','k_2=f\\left(t_k+\\frac{h}{2},x^{(k)}+\\frac{h}{2}k_1\\right)','other',@src_90),
('3.866','Gleichung 3.866','k_3=f\\left(t_k+\\frac{h}{2},x^{(k)}+\\frac{h}{2}k_2\\right)','other',@src_90),
('3.867','Gleichung 3.867','k_4=f\\left(t_k+h,x^{(k)}+hk_3\\right)','other',@src_90),
('3.868','Gleichung 3.868','x^{(k+1)}=x^{(k)}+\\frac{h}{6}(k_1+2k_2+2k_3+k_4)','other',@src_90),
('3.869','Gleichung 3.869','\\mathcal{O}(h^4)','other',@src_90),
('3.870','Gleichung 3.870','E_k','other',@src_90),
('3.871','Gleichung 3.871','h_{\\mathrm{neu}}=h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}}','other',@src_90),
('3.872','Gleichung 3.872','\\mathrm{TOL}>0','other',@src_90),
('3.873','Gleichung 3.873','h_{\\mathrm{neu}}=\\eta h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}},\\qquad 0<\\eta<1','other',@src_90),
('3.874','Gleichung 3.874','\\dot{x}=f(t,x),\\qquad x(t_0)=x_0','other',@src_90),
('3.875','Gleichung 3.875','S(t)=\\frac{\\partial x(t;x_0)}{\\partial x_0}','other',@src_90),
('3.876','Gleichung 3.876','\\dot{S}(t)=J_f(t,x(t))S(t)','other',@src_90),
('3.877','Gleichung 3.877','S(t_0)=I','other',@src_90),
('3.878','Gleichung 3.878','\\dot{x}=f(t,x)','other',@src_90),
('3.879','Gleichung 3.879','\\text{lokale Änderungsregel}','other',@src_90),
('3.880','Gleichung 3.880','\\text{Anfangszustand}','other',@src_90),
('3.881','Gleichung 3.881','\\text{resultierende Trajektorie}','other',@src_90),
('3.882','Gleichung 3.882','t_0','other',@src_90),
('3.883','Gleichung 3.883','x_0','other',@src_90),
('3.884','Gleichung 3.884','h','other',@src_90),
('3.885','Gleichung 3.885','\\mathrm{TOL}','other',@src_90),
('3.886','Gleichung 3.886','T','other',@src_90),
('3.887','Gleichung 3.887','\\dot{x}(t)=f(t,x(t))','other',@src_90),
('3.888','Gleichung 3.888','x(t)=x_0+\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau','other',@src_90),
('3.889','Gleichung 3.889','\\text{kontinuierliche Differentialgleichung}\\neq\\text{diskretes Rechenverfahren}','other',@src_90);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT equation_number,@section,title,latex,latex,
CONCAT('Formale Gleichung ',equation_number,' aus Abschnitt 3.2.19.'),
equation_type,'adapted',source_id,'In Abschnitt 3.2.19 verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.19.','verified',@revision
FROM tmp_eq t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number COLLATE utf8mb4_unicode_ci
        = t.equation_number COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'created',
'Abschnitt 3.2.19 mit 16 Definitionen, 3 Sätzen, 121 Gleichungen und Literatur [84], [85], [90] eingetragen.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.20'),('last_completed_section','3.2.19'),
('last_definition_number','3.2.84'),('next_definition_number','3.2.85'),
('last_theorem_number','3.2.19'),('next_theorem_number','3.2.20'),
('last_equation_number','3.889'),('next_equation_number','3.890'),
('last_citation_number','90'),('next_citation_number','91')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_eq;
COMMIT;

SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.2.19';
SELECT COUNT(*) AS definitionen_3_2_19 FROM definitions WHERE section_id=@section;
SELECT COUNT(*) AS saetze_3_2_19 FROM theorems WHERE section_id=@section AND theorem_number IN ('3.2.17','3.2.18','3.2.19');
SELECT COUNT(*) AS gleichungen_3_2_19 FROM equations WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 769 AND 889;
SELECT COUNT(*) AS literaturverwendungen_3_2_19 FROM source_usage WHERE section_id=@section;
