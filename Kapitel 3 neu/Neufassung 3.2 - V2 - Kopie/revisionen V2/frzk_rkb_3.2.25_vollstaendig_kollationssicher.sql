-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.25
-- Variationsrechnung, Energieprinzipien und schwache Minimierungsprobleme
-- Definitionen 3.2.197–3.2.229
-- Sätze 3.2.48–3.2.59
-- Gleichungen (3.1815)–(3.1999)
-- Literatur [96]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.25-V1',NOW(),'section','3.2.25','3.2.25-v1',
'Abschnitt 3.2.25 mit Definitionen 3.2.197–3.2.229, Sätzen 3.2.48–3.2.59, Gleichungen 3.1815–3.1999 und Literatur [96].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.25-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.25-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.25',
'Variationsrechnung, Energieprinzipien und schwache Minimierungsprobleme',
3,3.2250,'final',0,
'Funktionale, Variationen, Euler-Lagrange-Gleichung, Konvexität, Koerzivität, direkte Methode, Lax-Milgram, Galerkin- und Ritz-Verfahren sowie FRZK-Zustandsfunktionale.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.25' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.25' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Dacorogna','Bernard','Dacorogna, Bernard','Autor der Quelle [96].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Dacorogna, Bernard' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
96,'dacorogna_direct_methods_calculus_variations_2008','book',
'Direct Methods in the Calculus of Variations',
2008,2008,'Springer','New York','2nd edition',NULL,'en',1,'monograph',9,'verified','3.2.25',
'Erstnennung für Funktionale, Variationen, Euler-Lagrange-Gleichungen, Konvexität, Koerzivität, schwache Unterhalbstetigkeit und direkte Variationsmethoden.',
'Dacorogna, Bernard: Direct Methods in the Calculus of Variations. 2nd edition. New York: Springer, 2008.',
'Dacorogna, Direct Methods in the Calculus of Variations [96]',
'Zentrale Referenz für Variationsrechnung und direkte Methoden.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=96
 OR source_key COLLATE utf8mb4_unicode_ci='dacorogna_direct_methods_calculus_variations_2008' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_91 := (SELECT source_id FROM sources WHERE citation_number=91 LIMIT 1);
SET @src_95 := (SELECT source_id FROM sources WHERE citation_number=95 LIMIT 1);
SET @src_96 := (SELECT source_id FROM sources WHERE citation_number=96 LIMIT 1);

SET @author_96 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Dacorogna, Bernard' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_96,@author_96,1,'author'
WHERE @src_96 IS NOT NULL AND @author_96 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_96 AND author_id=@author_96
);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_84,@src_91,@src_95,@src_96);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Matrixdarstellungen diskreter Variationsprobleme und numerische Gleichungssysteme.','3.2.25',0,1,'Wiederverwendung [84].',@revision),
(@src_91,@section,'background','Schwache Lösungen, Sobolev-Räume, Variationsformulierungen und Energieprinzipien.','3.2.25',0,1,'Wiederverwendung [91].',@revision),
(@src_95,@section,'background','Übergang von schwachen Ableitungen zu schwachen Operatorgleichungen.','3.2.25',0,1,'Wiederverwendung [95].',@revision),
(@src_96,@section,'first_citation','Funktionale, Variationen, Euler-Lagrange-Gleichungen, Konvexität, Koerzivität, schwache Unterhalbstetigkeit und direkte Methode.','3.2.25',1,1,'Erstnennung [96].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.197','Funktional','Abbildung von einem Funktionenraum in den Skalarkörper.','J:V\\rightarrow\\mathbb{R}',@src_96),
('3.2.198','Integralfunktional erster Ordnung','Funktional mit Integrand in Abhängigkeit von Ort, Zustand und Gradient.','J(u)=\\int_{\\Omega}F(x,u(x),\\nabla u(x))\\,\\mathrm{d}x',@src_96),
('3.2.199','Zulässige Menge','Teilmenge eines Funktionenraums, die alle für das Variationsproblem erlaubten Zustände enthält.','\\mathcal{A}\\subset V',@src_96),
('3.2.200','Globaler Minimierer','Zulässiger Zustand mit kleinstem Funktionalwert auf der gesamten zulässigen Menge.','J(u_{\\ast})=\\inf_{v\\in\\mathcal{A}}J(v)',@src_96),
('3.2.201','Lokaler Minimierer','Zulässiger Zustand mit kleinstem Funktionalwert in einer Umgebung.','J(u_{\\ast})\\leq J(v)\\quad\\text{für }v\\in\\mathcal{A}\\cap U',@src_96),
('3.2.202','Variationsrichtung','Richtung, entlang der eine hinreichend kleine Störung zulässig bleibt.','u+\\varepsilon v\\in\\mathcal{A}',@src_96),
('3.2.203','Erste Variation','Richtungsabhängige erste Änderung eines Funktionals.','\\delta J(u;v)=\\left.\\frac{\\mathrm{d}}{\\mathrm{d}\\varepsilon}J(u+\\varepsilon v)\\right|_{\\varepsilon=0}',@src_96),
('3.2.204','Gâteaux-Ableitung','Richtungsableitung eines Funktionals entlang einer einzelnen Richtung.','D_{\\mathrm{G}}J(u)[v]=\\lim_{\\varepsilon\\rightarrow0}\\frac{J(u+\\varepsilon v)-J(u)}{\\varepsilon}',@src_96),
('3.2.205','Fréchet-Ableitung eines Funktionals','Beschränktes lineares Funktional, das die erste Änderung gleichmäßig approximiert.','J(u+h)=J(u)+DJ(u)[h]+r(h)',@src_96),
('3.2.206','Stationärer Zustand eines Funktionals','Zustand, dessen erste Variation in allen zulässigen Richtungen verschwindet.','\\delta J(u_{\\ast};v)=0',@src_96),
('3.2.207','Zweite Variation','Zweite richtungsabhängige Änderung eines Funktionals.','\\delta^{2}J(u;v,w)=\\left.\\frac{\\partial^{2}}{\\partial\\varepsilon\\partial\\eta}J(u+\\varepsilon v+\\eta w)\\right|_{\\varepsilon=\\eta=0}',@src_96),
('3.2.208','Konvexes Funktional','Funktional, dessen Wert auf Verbindungsstrecken höchstens der gewichteten Summe der Endwerte entspricht.','J(\\lambda u+(1-\\lambda)v)\\leq\\lambda J(u)+(1-\\lambda)J(v)',@src_96),
('3.2.209','Strikt konvexes Funktional','Konvexes Funktional mit strenger Ungleichung für verschiedene Zustände.','J(\\lambda u+(1-\\lambda)v)<\\lambda J(u)+(1-\\lambda)J(v)',@src_96),
('3.2.210','Koerzives Funktional','Funktional, das bei wachsender Norm gegen unendlich wächst.','\\|u\\|_V\\rightarrow\\infty\\Longrightarrow J(u)\\rightarrow\\infty',@src_96),
('3.2.211','Koerzive Bilinearform','Bilinearform mit positiver unterer quadratischer Schranke.','a(v,v)\\geq\\alpha\\|v\\|_V^{2}',@src_96),
('3.2.212','Stetige Bilinearform','Bilinearform mit einer Produktnormabschätzung.','|a(u,v)|\\leq M\\|u\\|_V\\|v\\|_V',@src_96),
('3.2.213','Minimierende Folge','Folge zulässiger Zustände, deren Funktionalwerte gegen das Infimum konvergieren.','J(u_k)\\rightarrow\\inf_{v\\in\\mathcal{A}}J(v)',@src_96),
('3.2.214','Schwache Unterhalbstetigkeit','Eigenschaft, dass der Grenzwertwert das Limes inferior einer schwach konvergenten Folge nicht überschreitet.','u_k\\rightharpoonup u\\Longrightarrow J(u)\\leq\\liminf_{k\\rightarrow\\infty}J(u_k)',@src_96),
('3.2.215','Variationsproblem mit Gleichungsnebenbedingung','Minimierungsproblem unter einer funktionalen Gleichungsbedingung.','u_{\\ast}=\\operatorname*{arg\\,min}_{u\\in V}J(u)\\quad\\text{unter }G(u)=0',@src_96),
('3.2.216','Erweitertes Lagrange-Funktional','Funktional aus Zielfunktional und gewichteter Nebenbedingung.','\\mathcal{L}(u,\\lambda)=J(u)+\\lambda G(u)',@src_96),
('3.2.217','Rayleigh-Quotient','Quotient aus quadratischer Operatorform und Zustandsnormquadrat.','R_A(u)=\\frac{\\langle Au,u\\rangle}{\\langle u,u\\rangle}',@src_96),
('3.2.218','Variationsungleichung','Schwache Ungleichungsform auf einer abgeschlossenen konvexen Menge.','a(u,v-u)\\geq F(v-u)',@src_96),
('3.2.219','Gradient eines Funktionals','Riesz-Repräsentant der Fréchet-Ableitung in einem Hilbertraum.','DJ(u)[v]=\\langle\\nabla J(u),v\\rangle_V',@src_96),
('3.2.220','Gradientenfluss','Zeitentwicklung entlang des negativen Funktionalgradienten.','\\frac{\\mathrm{d}u}{\\mathrm{d}t}=-\\nabla J(u)',@src_96),
('3.2.221','Galerkin-Approximation','Einschränkung einer schwachen Operatorgleichung auf einen endlichdimensionalen Unterraum.','a(u_h,v_h)=F(v_h)\\quad\\text{für alle }v_h\\in V_h',@src_96),
('3.2.222','Galerkin-Systemmatrix','Matrixdarstellung einer diskreten Bilinearform bezüglich einer Basis.','A_{ij}=a(\\phi_j,\\phi_i)',@src_96),
('3.2.223','Ritz-Approximation','Minimierer eines Funktionals in einem endlichdimensionalen Ansatzraum.','u_h=\\operatorname*{arg\\,min}_{v_h\\in V_h}J(v_h)',@src_96),
('3.2.224','FRZK-Zustandsfunktional','Funktional, das einem zulässigen FRZK-Zustand einen skalaren Bewertungswert zuordnet.','J_{\\mathrm{FRZK}}:\\mathcal{U}\\rightarrow\\mathbb{R}',@src_96),
('3.2.225','Regularisiertes Variationsproblem','Minimierung aus Datenanpassung und gewichteter Regularisierung.','u_{\\lambda}=\\operatorname*{arg\\,min}_{u\\in\\mathcal{A}}\\left[J_{\\mathrm{Daten}}(u)+\\lambda R(u)\\right]',@src_96),
('3.2.226','Quadratische Tikhonov-Regularisierung','Quadratische Regularisierung eines inversen oder datenangepassten Problems.','u_{\\lambda}=\\operatorname*{arg\\,min}_{u}\\left[\\|\\mathcal{H}u-y\\|_Y^{2}+\\lambda\\|Lu\\|_Z^{2}\\right]',@src_96),
('3.2.227','Funktionales Abweichungsmaß','Norm der Abweichung eines Zustands von einer vorgegebenen funktionalen Relation.','E_{\\mathcal{R}}(u)=\\|\\mathcal{R}(u)\\|',@src_96),
('3.2.228','Gewichtetes Mehrzielfunktional','Gewichtete Summe mehrerer Teilfunktionale.','J_{\\lambda}(u)=\\sum_{i=1}^{m}\\lambda_iJ_i(u)',@src_96),
('3.2.229','Pareto-optimaler Zustand','Zustand, der nicht in allen Zielgrößen gleichzeitig verbessert werden kann.','J_i(v)\\leq J_i(u_{\\ast})\\ \\forall i,\\quad J_j(v)<J_j(u_{\\ast})\\ \\text{für mindestens ein }j',@src_96);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.25.',
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
('3.2.48','Notwendige Stationaritätsbedingung','Ein lokaler Minimierer eines differenzierbaren Funktionals besitzt verschwindende erste Variation in allen beidseitig zulässigen Richtungen.','\\delta J(u_{\\ast};v)=0','Lokaler Minimierer, differenzierbares Funktional, beidseitig zulässige Variation.',@src_96),
('3.2.49','Fundamentallemma der Variationsrechnung','Verschwindet das Integral von g gegen jede Testfunktion, so ist g fast überall null.','\\int_{\\Omega}g(x)v(x)\\,\\mathrm{d}x=0\\ \\forall v\\in C_c^\\infty(\\Omega)\\Longrightarrow g=0\\ \\text{fast überall}','g lokal integrierbar.',@src_96),
('3.2.50','Euler-Lagrange-Gleichung','Ein stationärer Zustand eines hinreichend glatten Integralfunktionals erfüllt die Euler-Lagrange-Gleichung.','\\frac{\\partial F}{\\partial u}-\\operatorname{div}\\left(\\frac{\\partial F}{\\partial(\\nabla u)}\\right)=0','Hinreichende Glattheit und verschwindende Randvariation.',@src_96),
('3.2.51','Äquivalenz von Energie-Minimierung und schwacher Poisson-Gleichung','Der Minimierer eines quadratischen Energie-Funktionals erfüllt die zugehörige schwache Operatorgleichung.','J(u)=\\frac12a(u,u)-F(u)\\Longrightarrow a(u_{\\ast},v)=F(v)','Symmetrische Bilinearform; bei Eindeutigkeit zusätzlich Koerzivität.',@src_96),
('3.2.52','Notwendige Bedingung zweiter Ordnung','Bei einem lokalen Minimum ist die zweite Variation in jeder zulässigen Richtung nichtnegativ.','\\delta^{2}J(u_{\\ast};v,v)\\geq0','Zweimal differenzierbares Funktional und lokaler Minimierer.',@src_96),
('3.2.53','Stationärer Punkt eines konvexen Funktionals','Die Variationsungleichung eines differenzierbaren konvexen Funktionals kennzeichnet einen globalen Minimierer.','DJ(u_{\\ast})[v-u_{\\ast}]\\geq0\\Longrightarrow u_{\\ast}\\text{ globaler Minimierer}','Konvexes differenzierbares Funktional auf konvexer Menge.',@src_96),
('3.2.54','Lax-Milgram-Satz','Eine stetige koerzive Bilinearform und ein stetiges lineares Funktional bestimmen genau eine schwache Lösung.','a(u,v)=F(v)\\quad\\forall v\\in V','V Hilbertraum, a stetig und koerziv, F stetig linear.',@src_96),
('3.2.55','Existenz eines Minimierers nach der direkten Methode','Koerzivität und schwache Unterhalbstetigkeit sichern auf einer schwach abgeschlossenen Menge die Existenz eines Minimierers.','J(u_{\\ast})=\\inf_{v\\in\\mathcal{A}}J(v)','Reflexiver Banachraum, schwach abgeschlossene zulässige Menge.',@src_96),
('3.2.56','Notwendige Lagrange-Multiplikatorbedingung','Unter geeigneten Regularitätsbedingungen erfüllt ein Minimierer mit Gleichungsnebenbedingung eine stationäre Lagrange-Bedingung.','DJ(u_{\\ast})+\\lambda DG(u_{\\ast})=0','Lokaler Minimierer unter regulärer Gleichungsnebenbedingung.',@src_96),
('3.2.57','Monotonie eines Gradientenflusses','Entlang eines hinreichend regulären Gradientenflusses nimmt das Funktional nicht zu.','\\frac{\\mathrm{d}}{\\mathrm{d}t}J(u(t))=-\\|\\nabla J(u(t))\\|_V^{2}\\leq0','Hinreichende Regularität des Gradientenflusses.',@src_96),
('3.2.58','Galerkin-Orthogonalität','Der Fehler einer Galerkin-Lösung ist bezüglich der Bilinearform orthogonal zum diskreten Ansatzraum.','a(u-u_h,v_h)=0','Exakte und diskrete schwache Lösung.',@src_96),
('3.2.59','Céa-Lemma','Der Galerkin-Fehler ist bis auf das Verhältnis von Stetigkeits- und Koerzivitätskonstante optimal.','\\|u-u_h\\|_V\\leq\\frac{M}{\\alpha}\\inf_{v_h\\in V_h}\\|u-v_h\\|_V','Stetige und koerzive Bilinearform.',@src_96);

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
    SELECT 1815 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 1999
)
SELECT n
FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.25}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.25}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.25.'),
'other','adapted',@src_96,
'Im Abschnitt 3.2.25 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.25.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.25 mit Definitionen 3.2.197–3.2.229, Sätzen 3.2.48–3.2.59, Gleichungen 3.1815–3.1999 und Literatur [96] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.26'),
('last_completed_section','3.2.25'),
('last_definition_number','3.2.229'),
('next_definition_number','3.2.230'),
('last_theorem_number','3.2.59'),
('next_theorem_number','3.2.60'),
('last_equation_number','3.1999'),
('next_equation_number','3.2000'),
('last_citation_number','96'),
('next_citation_number','97')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.25' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_25
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_25
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_25
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 1815 AND 1999;

SELECT COUNT(*) AS literaturverwendungen_3_2_25
FROM source_usage
WHERE section_id=@section;
