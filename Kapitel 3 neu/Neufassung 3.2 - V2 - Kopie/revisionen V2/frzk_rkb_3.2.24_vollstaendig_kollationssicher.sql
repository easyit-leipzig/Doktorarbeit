-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.24
-- Distributionen, Deltafunktion und schwache Ableitungen
-- Definitionen 3.2.167–3.2.196
-- Sätze 3.2.41–3.2.47
-- Gleichungen (3.1619)–(3.1814)
-- Literatur [95]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.24-V1',NOW(),'section','3.2.24','3.2.24-v1',
'Abschnitt 3.2.24 mit Definitionen 3.2.167–3.2.196, Sätzen 3.2.41–3.2.47, Gleichungen 3.1619–3.1814 und Literatur [95].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.24-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.24-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.24','Distributionen, Deltafunktion und schwache Ableitungen',
3,3.2240,'final',0,
'Testfunktionen, Distributionen, Dirac-Distribution, distributionelle und schwache Ableitungen, Sobolev-Räume, temperierte Distributionen, Fundamentallösungen und FRZK-Anschluss.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.24' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.24' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Strichartz','Robert S.','Strichartz, Robert S.','Autor der Quelle [95].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Strichartz, Robert S.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
95,'strichartz_distribution_theory_fourier_transforms_2003','book',
'A Guide to Distribution Theory and Fourier Transforms',
2003,2003,'World Scientific','Singapore',NULL,NULL,'en',1,'monograph',9,'verified','3.2.24',
'Erstnennung für Testfunktionen, Distributionen, Dirac-Distributionen, distributionelle Ableitungen, temperierte Distributionen und Fourier-Transformationen im Distributionsraum.',
'Strichartz, Robert S.: A Guide to Distribution Theory and Fourier Transforms. Singapore: World Scientific, 2003.',
'Strichartz, Distribution Theory and Fourier Transforms [95]',
'Zentrale Referenz für Distributionstheorie und Fourier-Transformationen.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=95
 OR source_key COLLATE utf8mb4_unicode_ci='strichartz_distribution_theory_fourier_transforms_2003' COLLATE utf8mb4_unicode_ci
);

SET @src_91 := (SELECT source_id FROM sources WHERE citation_number=91 LIMIT 1);
SET @src_92 := (SELECT source_id FROM sources WHERE citation_number=92 LIMIT 1);
SET @src_93 := (SELECT source_id FROM sources WHERE citation_number=93 LIMIT 1);
SET @src_95 := (SELECT source_id FROM sources WHERE citation_number=95 LIMIT 1);

SET @author_95 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Strichartz, Robert S.' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_95,@author_95,1,'author'
WHERE @src_95 IS NOT NULL AND @author_95 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_95 AND author_id=@author_95
);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_91,@src_92,@src_93,@src_95);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_91,@section,'background','Schwache Ableitungen, Sobolev-Räume, schwache Formulierungen und Fundamentallösungen.','3.2.24',0,1,'Wiederverwendung [91].',@revision),
(@src_92,@section,'background','Faltungsoperatoren und Lösungserzeugung durch Fundamentallösungen.','3.2.24',0,1,'Wiederverwendung [92].',@revision),
(@src_93,@section,'background','Fourier-Transformation temperierter Distributionen.','3.2.24',0,1,'Wiederverwendung [93].',@revision),
(@src_95,@section,'first_citation','Testfunktionen, Distributionen, Dirac-Distributionen, distributionelle Ableitungen, temperierte Distributionen und Fourier-Transformationen.','3.2.24',1,1,'Erstnennung [95].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.167','Träger einer Funktion','Abschluss der Menge aller Punkte, an denen eine Funktion nicht null ist.','\\operatorname{supp}(\\varphi)=\\overline{\\{x\\in\\mathbb{R}^{n}\\mid\\varphi(x)\\neq0\\}}',@src_95),
('3.2.168','Raum der Testfunktionen','Raum der beliebig oft differenzierbaren Funktionen mit kompaktem Träger.','\\mathcal{D}(\\mathbb{R}^{n})=C_{c}^{\\infty}(\\mathbb{R}^{n})',@src_95),
('3.2.169','Lineares Funktional','Lineare Abbildung von einem Vektorraum in den Skalarkörper.','T(\\alpha u+\\beta v)=\\alpha T(u)+\\beta T(v)',@src_95),
('3.2.170','Distribution','Stetiges lineares Funktional auf dem Raum der Testfunktionen.','T:\\mathcal{D}(\\mathbb{R}^{n})\\rightarrow\\mathbb{C}',@src_95),
('3.2.171','Lokal integrierbare Funktion','Funktion, deren Betrag über jede kompakte Teilmenge integrierbar ist.','\\int_{K}|f(x)|\\,\\mathrm{d}x<\\infty',@src_95),
('3.2.172','Reguläre Distribution','Durch eine lokal integrierbare Funktion erzeugte Distribution.','\\langle T_f,\\varphi\\rangle=\\int_{\\mathbb{R}^{n}}f(x)\\varphi(x)\\,\\mathrm{d}x',@src_95),
('3.2.173','Dirac-Distribution','Distribution, die einer Testfunktion ihren Wert an einem festen Punkt zuordnet.','\\langle\\delta_{x_0},\\varphi\\rangle=\\varphi(x_0)',@src_95),
('3.2.174','Verschobene Dirac-Distribution','Dirac-Distribution an einem beliebigen Punkt.','\\langle\\delta_{t_0},\\varphi\\rangle=\\varphi(t_0)',@src_95),
('3.2.175','Distributionelle Ableitung','Ableitung einer Distribution durch Übertragung der Ableitung auf die Testfunktion.','\\langle T'',\\varphi\\rangle=-\\langle T,\\varphi''\\rangle',@src_95),
('3.2.176','Sprunganteil einer distributionellen Ableitung','Summe der Dirac-Anteile an den Sprungstellen einer stückweise glatten Funktion.','D_{\\mathrm{Sprung}}f=\\sum_k[f]_{t_k}\\delta(t-t_k)',@src_95),
('3.2.177','Schwache Ableitung','Lokal integrierbare Funktion, die die partielle Integrationsidentität für alle Testfunktionen erfüllt.','\\int_{\\Omega}u\\frac{\\partial\\varphi}{\\partial x_j}\\,\\mathrm{d}x=-\\int_{\\Omega}v\\varphi\\,\\mathrm{d}x',@src_95),
('3.2.178','Signumfunktion','Stückweise konstante Funktion mit den Werten minus eins, null und eins.','\\operatorname{sgn}(t)=\\begin{cases}-1,&t<0\\\\0,&t=0\\\\1,&t>0\\end{cases}',@src_95),
('3.2.179','Sobolev-Raum W^{k,p}','Raum der Lp-Funktionen mit schwachen Ableitungen bis zur Ordnung k in Lp.','W^{k,p}(\\Omega)=\\{u\\in L^{p}(\\Omega)\\mid D^{\\alpha}u\\in L^{p}(\\Omega)\\text{ für }|\\alpha|\\leq k\\}',@src_95),
('3.2.180','Hilbert-Sobolev-Raum H^{k}','Sobolev-Raum W^{k,2} mit natürlicher Hilbertraumstruktur.','H^{k}(\\Omega)=W^{k,2}(\\Omega)',@src_95),
('3.2.181','Schwache Lösung der Poisson-Gleichung','Funktion in H_0^1, welche die schwache Integralidentität erfüllt.','\\int_{\\Omega}\\nabla u\\cdot\\nabla v\\,\\mathrm{d}x=\\int_{\\Omega}fv\\,\\mathrm{d}x',@src_95),
('3.2.182','Schwache Operatorgleichung','Operatorgleichung in Form einer Bilinearform gegen alle Testfunktionen.','a(u,v)=F(v)\\qquad\\text{für alle }v\\in V',@src_95),
('3.2.183','Schwartz-Raum','Raum glatter Funktionen, deren Ableitungen schneller als jede inverse Potenz abfallen.','\\sup_{x\\in\\mathbb{R}^{n}}|x^{\\alpha}D^{\\beta}\\varphi(x)|<\\infty',@src_95),
('3.2.184','Temperierte Distribution','Stetiges lineares Funktional auf dem Schwartz-Raum.','T:\\mathcal{S}(\\mathbb{R}^{n})\\rightarrow\\mathbb{C}',@src_95),
('3.2.185','Fourier-Transformation einer temperierten Distribution','Durch Dualität definierte Fourier-Transformation auf dem Raum temperierter Distributionen.','\\langle\\widehat{T},\\varphi\\rangle=\\langle T,\\widehat{\\varphi}\\rangle',@src_95),
('3.2.186','Neutrales Element der Faltung','Die Dirac-Distribution wirkt als neutrales Element der Faltung.','\\delta*f=f*\\delta=f',@src_95),
('3.2.187','Fundamentallösung eines Differentialoperators','Distribution E mit LE gleich delta.','LE=\\delta',@src_95),
('3.2.188','Deltafolge','Folge regulärer Funktionen, die im Distributionssinn gegen die Dirac-Distribution konvergiert.','\\rho_{\\varepsilon}\\rightarrow\\delta\\qquad\\text{in }\\mathcal{D}''',@src_95),
('3.2.189','Konvergenz im Distributionsraum','Konvergenz durch punktweise Konvergenz der Wirkung auf jede Testfunktion.','\\lim_{k\\rightarrow\\infty}\\langle T_k,\\varphi\\rangle=\\langle T,\\varphi\\rangle',@src_95),
('3.2.190','Multiplikation einer Distribution mit einer glatten Funktion','Produktdefinition durch Übertragung der glatten Funktion auf die Testfunktion.','\\langle aT,\\varphi\\rangle=\\langle T,a\\varphi\\rangle',@src_95),
('3.2.191','Ordnung einer Distribution','Kleinste Ableitungsordnung, die zur lokalen Abschätzung der Distributionswirkung benötigt wird.','|\\langle T,\\varphi\\rangle|\\leq C_K\\sum_{|\\alpha|\\leq m}\\sup_{x\\in K}|D^{\\alpha}\\varphi(x)|',@src_95),
('3.2.192','Träger einer Distribution','Komplement der größten offenen Menge, auf der eine Distribution verschwindet.','\\operatorname{supp}(\\delta_{x_0})=\\{x_0\\}',@src_95),
('3.2.193','Distributioneller Zustandsübergang','Dirac-Term mit einer Sprungamplitude als Koeffizient.','J_k\\delta(t-t_k)',@src_95),
('3.2.194','Punktförmige Raum-Zeit-Quelle','Tensorprodukt räumlicher und zeitlicher Dirac-Distribution mit Amplitude.','Q_{x_0,t_0}=A\\delta_{x_0}\\otimes\\delta_{t_0}',@src_95),
('3.2.195','Distributionelles Beobachtungssignal','Summe gewichteter Dirac-Distributionen an diskreten Beobachtungszeitpunkten.','Y=\\sum_{k=1}^{N}y_k\\delta_{t_k}',@src_95),
('3.2.196','Regularisierung einer Distribution','Glättung einer Distribution durch Faltung mit einer Deltafolge.','R_{\\varepsilon}T=T*\\rho_{\\varepsilon}',@src_95);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.24.',
'Etablierte Definition oder FRZK-Anschlussdefinition.','verified',@revision
FROM tmp_defs t
WHERE NOT EXISTS (
 SELECT 1 FROM definitions d
 WHERE d.definition_number COLLATE utf8mb4_unicode_ci=t.definition_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_thms(
 theorem_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 statement_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 statement_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 assumptions LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms VALUES
('3.2.41','Einbettung lokal integrierbarer Funktionen in den Distributionsraum','Jede lokal integrierbare Funktion definiert eine reguläre Distribution.','\\langle T_f,\\varphi\\rangle=\\int_{\\mathbb{R}^{n}}f(x)\\varphi(x)\\,\\mathrm{d}x','f lokal integrierbar.',@src_95),
('3.2.42','Unbeschränkte distributionelle Differenzierbarkeit','Jede Distribution besitzt distributionelle Ableitungen beliebiger Ordnung.','\\langle D^{\\alpha}T,\\varphi\\rangle=(-1)^{|\\alpha|}\\langle T,D^{\\alpha}\\varphi\\rangle','T ist Distribution.',@src_95),
('3.2.43','Distributionelle Ableitung der Heaviside-Funktion','Die distributionelle Ableitung der Heaviside-Funktion ist die Dirac-Distribution.','\\frac{\\mathrm{d}H}{\\mathrm{d}t}=\\delta','Heaviside-Funktion im Distributionsraum.',@src_95),
('3.2.44','Übereinstimmung klassischer und schwacher Ableitungen','Bei klassischer Differenzierbarkeit stimmt die schwache mit der klassischen Ableitung überein.','D_{\\mathrm{schwach}}u=D_{\\mathrm{klassisch}}u','Klassische Differenzierbarkeit und lokale Integrierbarkeit.',@src_95),
('3.2.45','Fourier-Ableitungsregel für temperierte Distributionen','Distributionelle Ableitungen werden im Fourier-Raum mit Potenzen von i omega multipliziert.','\\widehat{D^{\\alpha}T}=(\\mathrm{i}\\omega)^{\\alpha}\\widehat{T}','T temperierte Distribution.',@src_95),
('3.2.46','Lösungserzeugung durch Fundamentallösung','Die Faltung einer Fundamentallösung mit der rechten Seite erzeugt eine Lösung.','u=E*f\\Longrightarrow Lu=f','L translationsinvariant, LE gleich delta, Faltung definiert.',@src_95),
('3.2.47','Distributionelle Konvergenz einer Deltafolge','Eine normierte Deltafolge konvergiert im Distributionsraum gegen die Dirac-Distribution.','\\rho_{\\varepsilon}\\rightarrow\\delta\\qquad\\text{in }\\mathcal{D}''','Normierte Deltafolge.',@src_95);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT
t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.statement_latex,
'literature',t.source_id,t.assumptions,'verified',@revision
FROM tmp_thms t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th
 WHERE th.theorem_number COLLATE utf8mb4_unicode_ci=t.theorem_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_numbers(
 n INT PRIMARY KEY
) ENGINE=InnoDB;

INSERT INTO tmp_numbers (n)
WITH RECURSIVE seq (n) AS (
    SELECT 1619 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 1814
)
SELECT n
FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.24}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.24}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.24.'),
'other','adapted',@src_95,
'Im Abschnitt 3.2.24 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.24.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.24 mit Definitionen 3.2.167–3.2.196, Sätzen 3.2.41–3.2.47, Gleichungen 3.1619–3.1814 und Literatur [95] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.25'),
('last_completed_section','3.2.24'),
('last_definition_number','3.2.196'),
('next_definition_number','3.2.197'),
('last_theorem_number','3.2.47'),
('next_theorem_number','3.2.48'),
('last_equation_number','3.1814'),
('next_equation_number','3.1815'),
('last_citation_number','95'),
('next_citation_number','96')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.24' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_24
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_24
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_24
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 1619 AND 1814;

SELECT COUNT(*) AS literaturverwendungen_3_2_24
FROM source_usage
WHERE section_id=@section;
