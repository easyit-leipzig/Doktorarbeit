-- ###########################################################################
-- FRZK-Repository – Weiter-Skript zu Abschnitt 3.2.20
-- Partielle Differentialgleichungen und räumlich verteilte Zustandsentwicklung
-- Definitionen 3.2.85–3.2.102
-- Sätze 3.2.20–3.2.23
-- Gleichungen (3.890)–(3.1048)
-- Literatur: [84], [85], [90], neu [91]
-- Kollation: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.20-V1',NOW(),'section','3.2.20','3.2.20-v1',
'Abschnitt 3.2.20 mit Definitionen 3.2.85–3.2.102, Sätzen 3.2.20–3.2.23, Gleichungen 3.890–3.1048 und Literatur [84], [85], [90], [91].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.20-V1' COLLATE utf8mb4_unicode_ci);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.20-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.20','Partielle Differentialgleichungen und räumlich verteilte Zustandsentwicklung',
3,3.2200,'final',0,
'PDE, Klassifikation, Randbedingungen, schwache Lösungen, Sobolev-Räume, Erhaltungsgleichungen, Diffusion, Advektion, Reaktions-Diffusions-Systeme, Energieabschätzungen und räumliche Diskretisierung.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.20' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.20' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Evans','Lawrence C.','Evans, Lawrence C.','Autor der Quelle [91].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Evans, Lawrence C.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
91,'evans_pde_2010','book',
'Partial Differential Equations',
2010,2010,'American Mathematical Society','Providence, Rhode Island','2nd edition',
'978-0-8218-4974-3','en',1,'monograph',9,'verified','3.2.20',
'Erstnennung für Klassifikation partieller Differentialgleichungen, schwache Lösungen, Sobolev-Räume und Maximumprinzipien.',
'Evans, Lawrence C.: Partial Differential Equations. 2nd edition. Providence, Rhode Island: American Mathematical Society, 2010.',
'Evans, Partial Differential Equations [91]',
'Zentrale Referenz für partielle Differentialgleichungen.',
@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources WHERE citation_number=91
 OR source_key COLLATE utf8mb4_unicode_ci='evans_pde_2010' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_85 := (SELECT source_id FROM sources WHERE citation_number=85 LIMIT 1);
SET @src_90 := (SELECT source_id FROM sources WHERE citation_number=90 LIMIT 1);
SET @src_91 := (SELECT source_id FROM sources WHERE citation_number=91 LIMIT 1);
SET @author_91 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Evans, Lawrence C.' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_91,@author_91,1,'author'
WHERE @src_91 IS NOT NULL AND @author_91 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_91 AND author_id=@author_91
);

DELETE FROM source_usage
WHERE section_id=@section AND source_id IN (@src_84,@src_85,@src_90,@src_91);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Räumliche Diskretisierung und diskrete Operatoren.','3.2.20',0,1,'Wiederverwendung [84].',@revision),
(@src_85,@section,'background','Diskretisierungsfehler und numerische Stabilität.','3.2.20',0,1,'Wiederverwendung [85].',@revision),
(@src_90,@section,'background','Methode der Linien und Zeitintegration.','3.2.20',0,1,'Wiederverwendung [90].',@revision),
(@src_91,@section,'first_citation','Partielle Differentialgleichungen, schwache Lösungen, Sobolev-Räume und Maximumprinzipien.','3.2.20',1,1,'Erstnennung [91].',@revision);

CREATE TEMPORARY TABLE tmp_defs (
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.85','Partielle Differentialgleichung','Gleichung für eine unbekannte Funktion mehrerer unabhängiger Variablen und deren partielle Ableitungen.','F(\xi,u,\nabla u,\nabla^2u,\ldots,\nabla^mu)=0',@src_91),
('3.2.86','Partielle Ableitung','Grenzwertige lokale Änderung einer Funktion in einer Koordinatenrichtung.','\frac{\partial u}{\partial \xi_i}(\xi)=\lim_{h\to0}\frac{u(\xi+he_i)-u(\xi)}{h}',@src_91),
('3.2.87','Divergenz','Lokale Quellen- oder Senkenwirkung eines Vektorfeldes.','\nabla\cdot q=\sum_{i=1}^d\frac{\partial q_i}{\partial \xi_i}',@src_91),
('3.2.88','Laplace-Operator','Divergenz des Gradienten einer skalaren Funktion.','\Delta u=\nabla\cdot\nabla u',@src_91),
('3.2.89','Quasilineare partielle Differentialgleichung','PDE, deren höchste Ableitungen linear auftreten.','\sum_{i,j}a_{ij}(\xi,u,\nabla u)u_{\xi_i\xi_j}=f(\xi,u,\nabla u)',@src_91),
('3.2.90','Elliptische partielle Differentialgleichung','PDE mit definiter Koeffizientenmatrix der höchsten Ableitungen.','\sum_{i,j}a_{ij}v_iv_j>0',@src_91),
('3.2.91','Parabolische partielle Differentialgleichung','PDE des Diffusions- und Ausgleichstyps.','\frac{\partial u}{\partial t}-\kappa\Delta u=0',@src_91),
('3.2.92','Hyperbolische partielle Differentialgleichung','PDE des Wellen- und Ausbreitungstyps.','\frac{\partial^2u}{\partial t^2}-c^2\Delta u=0',@src_91),
('3.2.93','Dirichlet-Randbedingung','Vorgabe des Funktionswertes auf dem Rand.','u=g\text{ auf }\partial\Omega',@src_91),
('3.2.94','Neumann-Randbedingung','Vorgabe der Normalenableitung auf dem Rand.','\frac{\partial u}{\partial n}=g',@src_91),
('3.2.95','Robin-Randbedingung','Lineare Kombination aus Funktionswert und Normalenableitung.','\alpha u+\beta\frac{\partial u}{\partial n}=g',@src_91),
('3.2.96','Anfangs-Randwertproblem','PDE mit Anfangs- und Randbedingungen.','\text{PDE}+\text{Anfangsbedingung}+\text{Randbedingung}',@src_91),
('3.2.97','Testfunktion','Glatte Funktion mit kompaktem Träger.','\varphi\in C_c^\infty(\Omega)',@src_91),
('3.2.98','Schwache Lösung der Poisson-Gleichung','Funktion, die die variationale Form der Poisson-Gleichung erfüllt.','\int_\Omega\nabla u\cdot\nabla\varphi=\int_\Omega f\varphi',@src_91),
('3.2.99','Sobolev-Raum H1','Raum quadratintegrierbarer Funktionen mit quadratintegrierbaren schwachen ersten Ableitungen.','H^1(\Omega)=\{u\in L^2(\Omega):\partial_i u\in L^2(\Omega)\}',@src_91),
('3.2.100','Lokale Erhaltungsgleichung','Bilanz aus gespeicherter Dichte, Fluss und Quelle.','\frac{\partial u}{\partial t}+\nabla\cdot q=s',@src_91),
('3.2.101','Räumlich homogener Zustand','Zustand ohne Abhängigkeit vom Ortsparameter.','u(t,\xi)=\bar u(t)',@src_91),
('3.2.102','Feldzustand','Zustand als Funktion über einem Parameterraum.','u:\Omega\rightarrow V',@src_91);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.20.',
'Etablierte Definition aus der Theorie partieller Differentialgleichungen.','verified',@revision
FROM tmp_defs t
WHERE NOT EXISTS (
 SELECT 1 FROM definitions d
 WHERE d.definition_number COLLATE utf8mb4_unicode_ci
     = t.definition_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_thms (
 theorem_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 statement_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 statement_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 assumptions LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms VALUES
('3.2.20','Existenz und Eindeutigkeit schwacher Lösungen','Eine stetige und koerzive Bilinearform auf einem Hilbertraum erzeugt für jedes stetige lineare Funktional genau eine schwache Lösung.','a(u,v)=\ell(v)','Hilbertraum, Stetigkeit und Koerzivität.',@src_91),
('3.2.21','Dissipation der Wärmeleitungsgleichung','Die L2-Norm einer Lösung der homogenen Wärmeleitungsgleichung mit homogenen Dirichlet-Randwerten nimmt nicht zu.','\|u(t_2)\|_{L^2}\leq\|u(t_1)\|_{L^2}','Hinreichende Regularität und homogene Dirichlet-Randbedingungen.',@src_91),
('3.2.22','Parabolisches Maximumprinzip','Das Maximum einer subkalorischen Funktion wird auf dem parabolischen Rand angenommen.','\max_{[0,T]\times\overline\Omega}u=\max_{\Gamma_P}u','Parabolizität und hinreichende Regularität.',@src_91),
('3.2.23','Stabilitätsbedingung des expliziten Wärmeleitungsschemas','Das eindimensionale explizite Differenzenschema ist für 0 kleiner gleich mu kleiner gleich 1/2 stabil.','0\leq\mu\leq\frac12','Eindimensionales explizites Schema.',@src_91);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.statement_latex,
'literature',t.source_id,t.assumptions,'verified',@revision
FROM tmp_thms t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th
 WHERE th.theorem_number COLLATE utf8mb4_unicode_ci
     = t.theorem_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_eq (
 equation_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 latex TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 equation_type VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eq VALUES
('3.890','Gleichung 3.890','x(t)\\in\\mathbb{R}^{n}','other',@src_91),
('3.891','Gleichung 3.891','u(t,\\xi)','other',@src_91),
('3.892','Gleichung 3.892','u:\\Omega\\rightarrow\\mathbb{R}','other',@src_91),
('3.893','Gleichung 3.893','\\Omega\\subseteq\\mathbb{R}^{d}','other',@src_91),
('3.894','Gleichung 3.894','F\\left(\\xi,u,\\nabla u,\\nabla^{2}u,\\ldots,\\nabla^{m}u\\right)=0','other',@src_91),
('3.895','Gleichung 3.895','\\xi=\\begin{pmatrix}\\xi_1\\\\\\xi_2\\\\\\vdots\\\\\\xi_d\\ \\end{pmatrix}\\in\\Omega','other',@src_91),
('3.896','Gleichung 3.896','\\frac{\\partial u}{\\partial \\xi_i}(\\xi)=\\lim_{h\\rightarrow0}\\frac{u(\\xi+he_i)-u(\\xi)}{h}','other',@src_91),
('3.897','Gleichung 3.897','e_i=\\begin{pmatrix}0\\\\\\vdots\\\\1\\\\\\vdots\\\\0\\ \\end{pmatrix}','other',@src_91),
('3.898','Gleichung 3.898','u:\\Omega\\subseteq\\mathbb{R}^{d}\\rightarrow\\mathbb{R}','other',@src_91),
('3.899','Gleichung 3.899','\\nabla u=\\begin{pmatrix}\\frac{\\partial u}{\\partial \\xi_1}\\\\\\frac{\\partial u}{\\partial \\xi_2}\\\\\\vdots\\\\\\frac{\\partial u}{\\partial \\xi_d}\\ \\end{pmatrix}','other',@src_91),
('3.900','Gleichung 3.900','v\\in\\mathbb{R}^{d},\\qquad\\|v\\|=1','other',@src_91),
('3.901','Gleichung 3.901','D_vu=\\nabla u\\cdot v','other',@src_91),
('3.902','Gleichung 3.902','q:\\Omega\\subseteq\\mathbb{R}^{d}\\rightarrow\\mathbb{R}^{d}','other',@src_91),
('3.903','Gleichung 3.903','q=\\begin{pmatrix}q_1\\\\q_2\\\\\\vdots\\\\q_d\\ \\end{pmatrix}','other',@src_91),
('3.904','Gleichung 3.904','\\nabla\\cdot q=\\sum_{i=1}^{d}\\frac{\\partial q_i}{\\partial \\xi_i}','other',@src_91),
('3.905','Gleichung 3.905','\\nabla\\cdot q>0','other',@src_91),
('3.906','Gleichung 3.906','\\nabla\\cdot q<0','other',@src_91),
('3.907','Gleichung 3.907','\\Delta u=\\nabla\\cdot\\nabla u','other',@src_91),
('3.908','Gleichung 3.908','\\Delta u=\\sum_{i=1}^{d}\\frac{\\partial^{2}u}{\\partial \\xi_i^{2}}','other',@src_91),
('3.909','Gleichung 3.909','\\Delta u=\\frac{\\partial^{2}u}{\\partial x^{2}}+\\frac{\\partial^{2}u}{\\partial y^{2}}+\\frac{\\partial^{2}u}{\\partial z^{2}}','other',@src_91),
('3.910','Gleichung 3.910','\\frac{\\partial u}{\\partial t}+a\\frac{\\partial u}{\\partial x}=0','other',@src_91),
('3.911','Gleichung 3.911','\\frac{\\partial u}{\\partial t}-\\kappa\\frac{\\partial^{2}u}{\\partial x^{2}}=0','other',@src_91),
('3.912','Gleichung 3.912','\\sum_{i,j=1}^{d}a_{ij}(\\xi)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}+\\sum_{i=1}^{d}b_i(\\xi)\\frac{\\partial u}{\\partial \\xi_i}+c(\\xi)u=f(\\xi)','other',@src_91),
('3.913','Gleichung 3.913','\\sum_{i,j=1}^{d}a_{ij}(\\xi,u,\\nabla u)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}=f(\\xi,u,\\nabla u)','other',@src_91),
('3.914','Gleichung 3.914','A\\frac{\\partial^{2}u}{\\partial x^{2}}+2B\\frac{\\partial^{2}u}{\\partial x\\partial y}+C\\frac{\\partial^{2}u}{\\partial y^{2}}+\\text{Terme niedrigerer Ordnung}=0','other',@src_91),
('3.915','Gleichung 3.915','D=B^{2}-AC','other',@src_91),
('3.916','Gleichung 3.916','B^{2}-AC<0','other',@src_91),
('3.917','Gleichung 3.917','B^{2}-AC=0','other',@src_91),
('3.918','Gleichung 3.918','B^{2}-AC>0','other',@src_91),
('3.919','Gleichung 3.919','\\sum_{i,j=1}^{d}a_{ij}(\\xi)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}=f(\\xi)','other',@src_91),
('3.920','Gleichung 3.920','\\sum_{i,j=1}^{d}a_{ij}(\\xi)v_iv_j>0','other',@src_91),
('3.921','Gleichung 3.921','\\Delta u=0','other',@src_91),
('3.922','Gleichung 3.922','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0','other',@src_91),
('3.923','Gleichung 3.923','\\kappa>0','other',@src_91),
('3.924','Gleichung 3.924','\\frac{\\partial^{2}u}{\\partial t^{2}}-c^{2}\\Delta u=0','other',@src_91),
('3.925','Gleichung 3.925','c>0','other',@src_91),
('3.926','Gleichung 3.926','\\Omega\\subseteq\\mathbb{R}^{d}','other',@src_91),
('3.927','Gleichung 3.927','\\partial\\Omega','other',@src_91),
('3.928','Gleichung 3.928','u(\\xi)=g(\\xi)\\qquad\\text{für }\\xi\\in\\partial\\Omega','other',@src_91),
('3.929','Gleichung 3.929','\\frac{\\partial u}{\\partial n}=g\\qquad\\text{auf }\\partial\\Omega','other',@src_91),
('3.930','Gleichung 3.930','\\frac{\\partial u}{\\partial n}=\\nabla u\\cdot n','other',@src_91),
('3.931','Gleichung 3.931','\\alpha u+\\beta\\frac{\\partial u}{\\partial n}=g\\qquad\\text{auf }\\partial\\Omega','other',@src_91),
('3.932','Gleichung 3.932','\\beta=0','other',@src_91),
('3.933','Gleichung 3.933','\\alpha=0','other',@src_91),
('3.934','Gleichung 3.934','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=f','other',@src_91),
('3.935','Gleichung 3.935','u(0,\\xi)=u_0(\\xi)','other',@src_91),
('3.936','Gleichung 3.936','u(0,\\xi)=u_0(\\xi)','other',@src_91),
('3.937','Gleichung 3.937','\\frac{\\partial u}{\\partial t}(0,\\xi)=v_0(\\xi)','other',@src_91),
('3.938','Gleichung 3.938','\\text{partieller Differentialgleichung}','other',@src_91),
('3.939','Gleichung 3.939','\\text{Anfangsbedingung}','other',@src_91),
('3.940','Gleichung 3.940','\\text{Randbedingung}','other',@src_91),
('3.941','Gleichung 3.941','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=f\\qquad\\text{in }(0,T)\\times\\Omega','other',@src_91),
('3.942','Gleichung 3.942','u(0,\\xi)=u_0(\\xi)\\qquad\\text{in }\\Omega','other',@src_91),
('3.943','Gleichung 3.943','u(t,\\xi)=g(t,\\xi)\\qquad\\text{auf }(0,T)\\times\\partial\\Omega','other',@src_91),
('3.944','Gleichung 3.944','\\varphi\\in C_c^\\infty(\\Omega)','other',@src_91),
('3.945','Gleichung 3.945','-\\Delta u=f\\qquad\\text{in }\\Omega','other',@src_91),
('3.946','Gleichung 3.946','\\int_{\\Omega}(-\\Delta u)\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi','other',@src_91),
('3.947','Gleichung 3.947','\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi-\\int_{\\partial\\Omega}\\frac{\\partial u}{\\partial n}\\varphi\\,\\mathrm{d}S=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi','other',@src_91),
('3.948','Gleichung 3.948','\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi','other',@src_91),
('3.949','Gleichung 3.949','u\\in H_0^1(\\Omega)','other',@src_91),
('3.950','Gleichung 3.950','\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi','other',@src_91),
('3.951','Gleichung 3.951','\\varphi\\in H_0^1(\\Omega)','other',@src_91),
('3.952','Gleichung 3.952','H^1(\\Omega)=\\left\\{u\\in L^2(\\Omega)\\;\\middle|\\;\\frac{\\partial u}{\\partial \\xi_i}\\in L^2(\\Omega)\\text{ für }i=1,\\ldots,d\\right\\}','other',@src_91),
('3.953','Gleichung 3.953','\\|u\\|_{H^1(\\Omega)}=\\left(\\|u\\|_{L^2(\\Omega)}^2+\\|\\nabla u\\|_{L^2(\\Omega)}^2\\right)^{1/2}','other',@src_91),
('3.954','Gleichung 3.954','H_0^1(\\Omega)','other',@src_91),
('3.955','Gleichung 3.955','a(u,\\varphi)=\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi','other',@src_91),
('3.956','Gleichung 3.956','\\ell(\\varphi)=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi','other',@src_91),
('3.957','Gleichung 3.957','u\\in H_0^1(\\Omega)','other',@src_91),
('3.958','Gleichung 3.958','a(u,\\varphi)=\\ell(\\varphi)\\qquad\\text{für alle }\\varphi\\in H_0^1(\\Omega)','other',@src_91),
('3.959','Gleichung 3.959','a:V\\times V\\rightarrow\\mathbb{R}','other',@src_91),
('3.960','Gleichung 3.960','|a(u,v)|\\leq C_a\\|u\\|_V\\|v\\|_V','other',@src_91),
('3.961','Gleichung 3.961','a(v,v)\\geq\\alpha\\|v\\|_V^2','other',@src_91),
('3.962','Gleichung 3.962','\\alpha>0','other',@src_91),
('3.963','Gleichung 3.963','\\ell\\in V^\\ast','other',@src_91),
('3.964','Gleichung 3.964','a(u,v)=\\ell(v)\\qquad\\text{für alle }v\\in V','other',@src_91),
('3.965','Gleichung 3.965','\\|u\\|_V\\leq\\frac{1}{\\alpha}\\|\\ell\\|_{V^\\ast}','other',@src_91),
('3.966','Gleichung 3.966','u(t,\\xi)','other',@src_91),
('3.967','Gleichung 3.967','q(t,\\xi)','other',@src_91),
('3.968','Gleichung 3.968','V\\subseteq\\Omega','other',@src_91),
('3.969','Gleichung 3.969','\\frac{\\mathrm{d}}{\\mathrm{d}t}\\int_Vu\\,\\mathrm{d}\\xi=-\\int_{\\partial V}q\\cdot n\\,\\mathrm{d}S+\\int_Vs\\,\\mathrm{d}\\xi','other',@src_91),
('3.970','Gleichung 3.970','\\int_{\\partial V}q\\cdot n\\,\\mathrm{d}S=\\int_V\\nabla\\cdot q\\,\\mathrm{d}\\xi','other',@src_91),
('3.971','Gleichung 3.971','\\int_V\\left(\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q-s\\right)\\,\\mathrm{d}\\xi=0','other',@src_91),
('3.972','Gleichung 3.972','\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q=s','other',@src_91),
('3.973','Gleichung 3.973','\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q=s','other',@src_91),
('3.974','Gleichung 3.974','s=0','other',@src_91),
('3.975','Gleichung 3.975','q=-\\kappa\\nabla u','other',@src_91),
('3.976','Gleichung 3.976','\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(-\\kappa\\nabla u)=s','other',@src_91),
('3.977','Gleichung 3.977','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=s','other',@src_91),
('3.978','Gleichung 3.978','q=uv','other',@src_91),
('3.979','Gleichung 3.979','\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(uv)=s','other',@src_91),
('3.980','Gleichung 3.980','\\nabla\\cdot v=0','other',@src_91),
('3.981','Gleichung 3.981','\\nabla\\cdot(uv)=v\\cdot\\nabla u','other',@src_91),
('3.982','Gleichung 3.982','\\frac{\\partial u}{\\partial t}+v\\cdot\\nabla u=s','other',@src_91),
('3.983','Gleichung 3.983','q=uv-\\kappa\\nabla u','other',@src_91),
('3.984','Gleichung 3.984','\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(uv)-\\nabla\\cdot(\\kappa\\nabla u)=s','other',@src_91),
('3.985','Gleichung 3.985','\\frac{\\partial u}{\\partial t}+v\\cdot\\nabla u-\\kappa\\Delta u=s','other',@src_91),
('3.986','Gleichung 3.986','u=\\begin{pmatrix}u_1\\\\u_2\\\\\\vdots\\\\u_m\\ \\end{pmatrix}','other',@src_91),
('3.987','Gleichung 3.987','\\frac{\\partial u}{\\partial t}=D\\Delta u+R(u)','other',@src_91),
('3.988','Gleichung 3.988','D=\\operatorname{diag}(D_1,D_2,\\ldots,D_m)','other',@src_91),
('3.989','Gleichung 3.989','R(u)=\\begin{pmatrix}R_1(u)\\\\R_2(u)\\\\\\vdots\\\\R_m(u)\\ \\end{pmatrix}','other',@src_91),
('3.990','Gleichung 3.990','u(t,\\xi)=\\bar{u}(t)','other',@src_91),
('3.991','Gleichung 3.991','\\nabla u=0','other',@src_91),
('3.992','Gleichung 3.992','\\Delta u=0','other',@src_91),
('3.993','Gleichung 3.993','\\frac{\\mathrm{d}\\bar{u}}{\\mathrm{d}t}=R(\\bar{u})','other',@src_91),
('3.994','Gleichung 3.994','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0','other',@src_91),
('3.995','Gleichung 3.995','\\int_{\\Omega}u\\frac{\\partial u}{\\partial t}\\,\\mathrm{d}\\xi-\\kappa\\int_{\\Omega}u\\Delta u\\,\\mathrm{d}\\xi=0','other',@src_91),
('3.996','Gleichung 3.996','\\int_{\\Omega}u\\frac{\\partial u}{\\partial t}\\,\\mathrm{d}\\xi=\\frac{1}{2}\\frac{\\mathrm{d}}{\\mathrm{d}t}\\int_{\\Omega}u^2\\,\\mathrm{d}\\xi','other',@src_91),
('3.997','Gleichung 3.997','-\\int_{\\Omega}u\\Delta u\\,\\mathrm{d}\\xi=\\int_{\\Omega}|\\nabla u|^2\\,\\mathrm{d}\\xi','other',@src_91),
('3.998','Gleichung 3.998','\\frac{1}{2}\\frac{\\mathrm{d}}{\\mathrm{d}t}\\|u(t)\\|_{L^2(\\Omega)}^2+\\kappa\\|\\nabla u(t)\\|_{L^2(\\Omega)}^2=0','other',@src_91),
('3.999','Gleichung 3.999','\\frac{\\mathrm{d}}{\\mathrm{d}t}\\|u(t)\\|_{L^2(\\Omega)}^2\\leq0','other',@src_91),
('3.1000','Gleichung 3.1000','\\|u(t_2)\\|_{L^2(\\Omega)}\\leq\\|u(t_1)\\|_{L^2(\\Omega)}','other',@src_91),
('3.1001','Gleichung 3.1001','t_2\\geq t_1\\geq0','other',@src_91),
('3.1002','Gleichung 3.1002','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u\\leq0','other',@src_91),
('3.1003','Gleichung 3.1003','(0,T]\\times\\Omega','other',@src_91),
('3.1004','Gleichung 3.1004','\\max_{[0,T]\\times\\overline{\\Omega}}u=\\max_{\\Gamma_P}u','other',@src_91),
('3.1005','Gleichung 3.1005','\\Gamma_P=\\left(\\{0\\}\\times\\overline{\\Omega}\\right)\\cup\\left([0,T]\\times\\partial\\Omega\\right)','other',@src_91),
('3.1006','Gleichung 3.1006','[a,b]','other',@src_91),
('3.1007','Gleichung 3.1007','x_i=a+i\\Delta x','other',@src_91),
('3.1008','Gleichung 3.1008','\\Delta x=\\frac{b-a}{N}','other',@src_91),
('3.1009','Gleichung 3.1009','\\frac{\\partial^{2}u}{\\partial x^{2}}(x_i)\\approx\\frac{u(x_{i+1})-2u(x_i)+u(x_{i-1})}{(\\Delta x)^2}','other',@src_91),
('3.1010','Gleichung 3.1010','u_i^{(k+1)}=u_i^{(k)}+\\mu\\left(u_{i+1}^{(k)}-2u_i^{(k)}+u_{i-1}^{(k)}\\right)','other',@src_91),
('3.1011','Gleichung 3.1011','\\mu=\\frac{\\kappa\\Delta t}{(\\Delta x)^2}','other',@src_91),
('3.1012','Gleichung 3.1012','0\\leq\\mu\\leq\\frac{1}{2}','other',@src_91),
('3.1013','Gleichung 3.1013','\\Delta t\\leq\\frac{(\\Delta x)^2}{2\\kappa}','other',@src_91),
('3.1014','Gleichung 3.1014','\\frac{\\mathrm{d}U}{\\mathrm{d}t}=F(t,U)','other',@src_91),
('3.1015','Gleichung 3.1015','U(t)=\\begin{pmatrix}u_1(t)\\\\u_2(t)\\\\\\vdots\\\\u_N(t)\\ \\end{pmatrix}','other',@src_91),
('3.1016','Gleichung 3.1016','\\text{partielle Differentialgleichung}','other',@src_91),
('3.1017','Gleichung 3.1017','\\longrightarrow\\text{räumliche Diskretisierung}','other',@src_91),
('3.1018','Gleichung 3.1018','\\longrightarrow\\text{gewöhnliches Differentialgleichungssystem}','other',@src_91),
('3.1019','Gleichung 3.1019','\\longrightarrow\\text{numerische Zeitintegration}','other',@src_91),
('3.1020','Gleichung 3.1020','u(t)\\in X','other',@src_91),
('3.1021','Gleichung 3.1021','X=L^2(\\Omega)','other',@src_91),
('3.1022','Gleichung 3.1022','X=H^1(\\Omega)','other',@src_91),
('3.1023','Gleichung 3.1023','X=C(\\overline{\\Omega})','other',@src_91),
('3.1024','Gleichung 3.1024','\\frac{\\mathrm{d}u}{\\mathrm{d}t}=\\mathcal{A}u+\\mathcal{N}(u)','other',@src_91),
('3.1025','Gleichung 3.1025','\\mathcal{A}:D(\\mathcal{A})\\subseteq X\\rightarrow X','other',@src_91),
('3.1026','Gleichung 3.1026','\\mathcal{N}:X\\rightarrow X','other',@src_91),
('3.1027','Gleichung 3.1027','u:\\Omega\\rightarrow V','other',@src_91),
('3.1028','Gleichung 3.1028','u:[0,T]\\times\\Omega\\rightarrow V','other',@src_91),
('3.1029','Gleichung 3.1029','u(t,\\cdot)','other',@src_91),
('3.1030','Gleichung 3.1030','\\text{lokale Zustandsänderung}+\\text{räumliche Kopplung}=\\text{äußere und innere Einwirkung}','other',@src_91),
('3.1031','Gleichung 3.1031','\\Omega','other',@src_91),
('3.1032','Gleichung 3.1032','\\partial\\Omega','other',@src_91),
('3.1033','Gleichung 3.1033','u_0','other',@src_91),
('3.1034','Gleichung 3.1034','\\text{Randbedingungen}','other',@src_91),
('3.1035','Gleichung 3.1035','\\text{Koeffizienten}','other',@src_91),
('3.1036','Gleichung 3.1036','\\text{Lösungsbegriff}','other',@src_91),
('3.1037','Gleichung 3.1037','\\text{klassischer Lösung}','other',@src_91),
('3.1038','Gleichung 3.1038','\\text{schwacher Lösung}','other',@src_91),
('3.1039','Gleichung 3.1039','\\text{numerischer Näherung}','other',@src_91),
('3.1040','Gleichung 3.1040','\\frac{\\partial u}{\\partial t}=\\mathcal{D}(u)+\\mathcal{R}(u)+\\mathcal{E}(t,\\xi)','other',@src_91),
('3.1041','Gleichung 3.1041','\\mathcal{D}(u)','other',@src_91),
('3.1042','Gleichung 3.1042','\\mathcal{R}(u)','other',@src_91),
('3.1043','Gleichung 3.1043','\\mathcal{E}(t,\\xi)','other',@src_91),
('3.1044','Gleichung 3.1044','x(t)=\\begin{pmatrix}x_1(t)\\\\x_2(t)\\\\\\vdots\\\\x_n(t)\\ \\end{pmatrix}','other',@src_91),
('3.1045','Gleichung 3.1045','u(t)=u(t,\\cdot)','other',@src_91),
('3.1046','Gleichung 3.1046','\\text{endlichdimensionaler Zustandsvektor}\\longrightarrow\\text{unendlichdimensionaler Feldzustand}','other',@src_91),
('3.1047','Gleichung 3.1047','\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0','other',@src_91),
('3.1048','Gleichung 3.1048','\\text{Feldgleichung}+\\text{Zustandsraum}+\\text{Anfangsdaten}+\\text{Randbedingungen}+\\text{Lösungsbegriff}','other',@src_91);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT t.equation_number,@section,t.title,t.latex,t.latex,
CONCAT('Formale Gleichung ',t.equation_number,' aus Abschnitt 3.2.20.'),
t.equation_type,'adapted',t.source_id,
'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.20.','verified',@revision
FROM tmp_eq t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci
     = t.equation_number COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'created',
'Abschnitt 3.2.20 mit Definitionen 3.2.85–3.2.102, Sätzen 3.2.20–3.2.23, Gleichungen 3.890–3.1048 und Literatur [84], [85], [90], [91] vollständig eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.21'),
('last_completed_section','3.2.20'),
('last_definition_number','3.2.102'),
('next_definition_number','3.2.103'),
('last_theorem_number','3.2.23'),
('next_theorem_number','3.2.24'),
('last_equation_number','3.1048'),
('next_equation_number','3.1049'),
('last_citation_number','91'),
('next_citation_number','92')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_eq;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.20' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_20
FROM definitions WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_20
FROM theorems
WHERE section_id=@section
AND theorem_number COLLATE utf8mb4_unicode_ci IN
('3.2.20' COLLATE utf8mb4_unicode_ci,'3.2.21' COLLATE utf8mb4_unicode_ci,'3.2.22' COLLATE utf8mb4_unicode_ci,'3.2.23' COLLATE utf8mb4_unicode_ci);

SELECT COUNT(*) AS gleichungen_3_2_20
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 890 AND 1048;

SELECT COUNT(*) AS literaturverwendungen_3_2_20
FROM source_usage WHERE section_id=@section;
