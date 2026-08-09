-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.33
-- LaSalle-Invarianzprinzip und erweiterte Stabilitätsaussagen
--
-- Definitionen : 3.2.512–3.2.528
-- Sätze        : 3.2.107–3.2.112
-- Gleichungen  : (3.2849)–(3.2895)
-- Literatur    : [105] weiterverwendet, [106]–[107] neu
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.33-V1',NOW(),'section','3.2.33','3.2.33-v1',
'LaSalle-Invarianzprinzip, Omega-Grenzmengen, Barbalat-Lemma sowie funktionale FRZK-Übertragungen.',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.33-V1'
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.33-V1'
 LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2'
 LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.33','LaSalle-Invarianzprinzip und erweiterte Stabilitätsaussagen',
3,3233,'final',1,
'LaSalle-Invarianzprinzip, Niveaumengen, Omega-Grenzmengen, Barbalat-Lemma und funktionale FRZK-Erweiterungen.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections WHERE section_code='3.2.33'
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2.33'
 LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Literatur [106] und [107]
-- [105] wird aus Abschnitt 3.2.32 weiterverwendet.
-- ---------------------------------------------------------------------------

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'LaSalle','Joseph P.','LaSalle, Joseph P.','Autor der Quelle [106].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors WHERE normalized_name='LaSalle, Joseph P.'
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Slotine','Jean-Jacques E.','Slotine, Jean-Jacques E.','Erstautor der Quelle [107].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors WHERE normalized_name='Slotine, Jean-Jacques E.'
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Li','Weiping','Li, Weiping','Mitautor der Quelle [107].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors WHERE normalized_name='Li, Weiping'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
106,'lasalle_stability_theory_1968','book','Stability Theory for Ordinary Differential Equations',
1968,1968,'Journal of Differential Equations / Academic Press','New York',NULL,NULL,'en',1,'monograph',10,'verified','3.2.33',
'Erstnennung für das LaSalle-Invarianzprinzip, invariante Mengen und Omega-Grenzmengen.',
'LaSalle, Joseph P.: Stability Theory for Ordinary Differential Equations. New York, 1968.',
'LaSalle, Stability Theory [106]',
'Grundlage für das Invarianzprinzip und die asymptotische Analyse.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources WHERE citation_number=106 OR source_key='lasalle_stability_theory_1968'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
107,'slotine_li_applied_nonlinear_control_1991','book','Applied Nonlinear Control',
1991,1991,'Prentice Hall','Englewood Cliffs, New Jersey',NULL,'9780130408907','en',1,'textbook',9,'verified','3.2.33',
'Erstnennung für das Barbalat-Lemma und Konvergenzaussagen aus Lyapunov-Funktionen.',
'Slotine, Jean-Jacques E.; Li, Weiping: Applied Nonlinear Control. Englewood Cliffs, New Jersey: Prentice Hall, 1991.',
'Slotine/Li, Applied Nonlinear Control [107]',
'Grundlage für Barbalat-Lemma und ergänzende Konvergenzkriterien.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources WHERE citation_number=107 OR source_key='slotine_li_applied_nonlinear_control_1991'
);

SET @src105 := (SELECT source_id FROM sources WHERE citation_number=105 LIMIT 1);
SET @src106 := (SELECT source_id FROM sources WHERE citation_number=106 LIMIT 1);
SET @src107 := (SELECT source_id FROM sources WHERE citation_number=107 LIMIT 1);
SET @author106 := (SELECT author_id FROM authors WHERE normalized_name='LaSalle, Joseph P.' LIMIT 1);
SET @author107a := (SELECT author_id FROM authors WHERE normalized_name='Slotine, Jean-Jacques E.' LIMIT 1);
SET @author107b := (SELECT author_id FROM authors WHERE normalized_name='Li, Weiping' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src106,@author106,1,'author'
WHERE @src106 IS NOT NULL AND @author106 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src106 AND author_id=@author106);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src107,@author107a,1,'author'
WHERE @src107 IS NOT NULL AND @author107a IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src107 AND author_id=@author107a);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src107,@author107b,2,'author'
WHERE @src107 IS NOT NULL AND @author107b IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src107 AND author_id=@author107b);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src105,@section,'supporting_citation',
'Direkte Lyapunov-Methode im Beispiel mit negativ definiter Ableitung.',
'3.2.33.6',0,1,'Weiterverwendung von [105].',@revision
WHERE @src105 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage WHERE source_id=@src105 AND section_id=@section AND exact_location='3.2.33.6'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src106,@section,'first_citation',
'LaSalle-Invarianzprinzip, Niveaumengen, invariante Kernmengen und Omega-Grenzmengen.',
'3.2.33',1,1,'Erstnennung [106].',@revision
WHERE @src106 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage WHERE source_id=@src106 AND section_id=@section AND exact_location='3.2.33'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src107,@section,'first_citation',
'Barbalat-Lemma, gleichmäßige Stetigkeit und Konvergenz aus beschränkten Lyapunov-Funktionen.',
'3.2.33.7',1,1,'Erstnennung [107].',@revision
WHERE @src107 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage WHERE source_id=@src107 AND section_id=@section AND exact_location='3.2.33.7'
);

-- ---------------------------------------------------------------------------
-- Definitionen
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_defs_3233 (
 definition_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 definition_text LONGTEXT NOT NULL,
 formal_latex LONGTEXT NULL,
 word_latex LONGTEXT NULL,
 provenance ENUM('original','adapted','literature') NOT NULL,
 source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_3233 VALUES
('3.2.512','Niveaumenge','Für eine Funktion V:X→R und c∈R ist L_c={x∈X | V(x)=c} die Niveaumenge zum Niveau c.','L_c=\\{x\\in X\\mid V(x)=c\\}','L_c=\\{x\\in X\\mid V(x)=c\\}','literature',@src106),
('3.2.513','Subniveaumenge','Die Subniveaumenge von V zum Wert c ist Ω_c={x∈X | V(x)≤c}.','\\Omega_c=\\{x\\in X\\mid V(x)\\leq c\\}','\\Omega_c=\\{x\\in X\\mid V(x)\\leq c\\}','literature',@src106),
('3.2.514','Nullstellenmenge der Lyapunov-Ableitung','Die Menge E={x∈X | V̇(x)=0} heißt Nullstellenmenge der Ableitung von V entlang der Systemtrajektorien.','E=\\{x\\in X\\mid \\dot V(x)=0\\}','E=\\{x\\in X\\mid \\dot V(x)=0\\}','literature',@src106),
('3.2.515','Größte invariante Teilmenge','Die größte invariante Teilmenge M⊆E ist die Vereinigung aller invarianten Teilmengen von E.','M=\\bigcup\\{N\\subseteq E\\mid N\\text{ ist invariant}\\}','M=\\bigcup\\{N\\subseteq E\\mid N\\text{ ist invariant}\\}','literature',@src106),
('3.2.516','Omega-Grenzpunkt','Ein Zustand y heißt Omega-Grenzpunkt einer Trajektorie, wenn eine Folge t_k→∞ mit x(t_k;x_0)→y existiert.','t_k\\rightarrow\\infty,\\quad x(t_k;x_0)\\rightarrow y','t_k\\rightarrow\\infty,\\quad x(t_k;x_0)\\rightarrow y','literature',@src106),
('3.2.517','Omega-Grenzmenge','Die Omega-Grenzmenge enthält alle Omega-Grenzpunkte einer Trajektorie.','\\omega(x_0)=\\{y\\in X\\mid\\exists\\,t_k\\rightarrow\\infty:x(t_k;x_0)\\rightarrow y\\}','\\omega(x_0)=\\{y\\in X\\mid\\exists\\,t_k\\rightarrow\\infty:x(t_k;x_0)\\rightarrow y\\}','literature',@src106),
('3.2.518','Abstand zu einer Menge','Der Abstand eines Zustands x zu einer nichtleeren Menge M ist das Infimum der Normabstände zu den Elementen von M.','\\operatorname{dist}(x,M)=\\inf_{y\\in M}\\|x-y\\|','\\operatorname{dist}(x,M)=\\inf_{y\\in M}\\|x-y\\|','literature',@src106),
('3.2.519','Gleichmäßige Stetigkeit','Eine Funktion g:[0,∞)→R heißt gleichmäßig stetig, wenn zu jedem ε>0 ein δ>0 existiert, das unabhängig von den betrachteten Zeitpunkten gilt.','|t_1-t_2|<\\delta\\Longrightarrow|g(t_1)-g(t_2)|<\\varepsilon','|t_1-t_2|<\\delta\\Longrightarrow|g(t_1)-g(t_2)|<\\varepsilon','literature',@src107),
('3.2.520','Funktionale Nullstellenmenge','Für eine funktionale Lyapunov-Funktion V_F ist E_F={u∈S | V̇_F(u)=0} die funktionale Nullstellenmenge.','E_F=\\{u\\in S\\mid\\dot V_F(u)=0\\}','E_F=\\{u\\in S\\mid\\dot V_F(u)=0\\}','original',NULL),
('3.2.521','Funktionale invariante Kernmenge','Die größte unter der FRZK-Dynamik invariante Teilmenge von E_F heißt funktionale invariante Kernmenge.','M_F=\\operatorname{Inv}(E_F)','M_F=\\operatorname{Inv}(E_F)','original',NULL),
('3.2.522','Funktionale Omega-Grenzmenge','Die funktionale Omega-Grenzmenge enthält alle langfristig angenäherten Zustände einer FRZK-Trajektorie.','\\omega_F(u_0)=\\{v\\in S\\mid\\exists\\,t_k\\rightarrow\\infty:u(t_k;u_0)\\rightarrow v\\}','\\omega_F(u_0)=\\{v\\in S\\mid\\exists\\,t_k\\rightarrow\\infty:u(t_k;u_0)\\rightarrow v\\}','original',NULL),
('3.2.523','Funktionale Restdynamik','Die Dynamik innerhalb der funktionalen Nullstellenmenge E_F heißt funktionale Restdynamik.','\\dot u=F_{\\mathrm{FRZK}}(u),\\quad u\\in E_F','\\dot u=F_{\\mathrm{FRZK}}(u),\\quad u\\in E_F','original',NULL),
('3.2.524','Funktionale Ruhedynamik','Eine funktionale Restdynamik heißt Ruhedynamik, wenn der FRZK-Entwicklungsoperator auf der invarianten Kernmenge verschwindet.','F_{\\mathrm{FRZK}}(u)=0\\quad\\forall u\\in M_F','F_{\\mathrm{FRZK}}(u)=0\\quad\\forall u\\in M_F','original',NULL),
('3.2.525','Funktionale Umlaufdynamik','Eine funktionale Restdynamik heißt Umlaufdynamik, wenn Zustände innerhalb von M_F zeitlich veränderlich bleiben, ohne M_F zu verlassen.','u(t)\\in M_F\\ \\forall t\\geq0,\\quad \\dot u(t)\\neq0','u(t)\\in M_F\\ \\forall t\\geq0,\\quad \\dot u(t)\\neq0','original',NULL),
('3.2.526','Funktionale Zustandsklasse','Eine funktionale Zustandsklasse ist eine Teilmenge C_F⊆S, deren Elemente hinsichtlich eines festgelegten funktionalen Kriteriums als äquivalent behandelt werden.','C_F\\subseteq S','C_F\\subseteq S','original',NULL),
('3.2.527','Konvergenz zu einer funktionalen Zustandsklasse','Eine Trajektorie konvergiert zu C_F, wenn ihr Abstand zu dieser Zustandsklasse gegen null geht.','\\operatorname{dist}(u(t),C_F)\\rightarrow0','\\operatorname{dist}(u(t),C_F)\\rightarrow0','original',NULL),
('3.2.528','Funktionale Konvergenztoleranz','Die ε_F-Umgebung einer funktionalen Zustandsklasse enthält alle Zustände mit Abstand kleiner ε_F.','B_{\\varepsilon_F}(C_F)=\\{u\\in S\\mid\\operatorname{dist}(u,C_F)<\\varepsilon_F\\}','B_{\\varepsilon_F}(C_F)=\\{u\\in S\\mid\\operatorname{dist}(u,C_F)<\\varepsilon_F\\}','original',NULL);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,NULLIF(t.formal_latex,''),NULLIF(t.word_latex,''),
t.provenance,t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.33.',
CASE WHEN t.provenance='original'
     THEN 'FRZK-spezifische Eigenkonstruktion; empirische Operationalisierung gesondert erforderlich.'
     ELSE 'Begriff aus der Theorie nichtlinearer dynamischer Systeme.'
END,
'verified',@revision
FROM tmp_defs_3233 t
WHERE NOT EXISTS (
 SELECT 1 FROM definitions d WHERE d.definition_number=t.definition_number
);

-- ---------------------------------------------------------------------------
-- Sätze
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_thms_3233 (
 theorem_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 statement_text LONGTEXT NOT NULL,
 statement_latex LONGTEXT NULL,
 word_latex LONGTEXT NULL,
 provenance ENUM('original','adapted','literature') NOT NULL,
 source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_3233 VALUES
('3.2.107','Positive Invarianz einer Subniveaumenge','Ist V stetig differenzierbar und gilt V̇≤0 in Ω_c, so ist Ω_c positiv invariant, sofern die Lösung für alle positiven Zeiten existiert.','\\dot V(x)\\leq0\\Longrightarrow\\Omega_c\\text{ positiv invariant}','\\dot V(x)\\leq0\\Longrightarrow\\Omega_c\\text{ positiv invariant}','literature',@src106),
('3.2.108','LaSalle-Invarianzprinzip','In einer kompakten positiv invarianten Menge nähert sich jede Trajektorie der größten invarianten Teilmenge der Nullstellenmenge von V̇ an.','\\operatorname{dist}(x(t;x_0),M)\\rightarrow0','\\operatorname{dist}(x(t;x_0),M)\\rightarrow0','literature',@src106),
('3.2.109','Asymptotische Stabilität bei singulärer invarianten Nullstellenmenge','Besteht die größte invariante Teilmenge der Nullstellenmenge ausschließlich aus dem Gleichgewicht, so ist dieses asymptotisch stabil.','M=\\{x^\\ast\\}\\Longrightarrow x^\\ast\\text{ asymptotisch stabil}','M=\\{x^\\ast\\}\\Longrightarrow x^\\ast\\text{ asymptotisch stabil}','literature',@src106),
('3.2.110','Barbalat-Lemma','Ist g gleichmäßig stetig und besitzt ihr Integral einen endlichen Grenzwert, so gilt g(t)→0.','\\lim_{t\\rightarrow\\infty}\\int_0^t g(\\tau)\\,\\mathrm d\\tau\\text{ endlich}\\Longrightarrow\\lim_{t\\rightarrow\\infty}g(t)=0','\\lim_{t\\rightarrow\\infty}\\int_0^t g(\\tau)\\,\\mathrm d\\tau\\text{ endlich}\\Longrightarrow\\lim_{t\\rightarrow\\infty}g(t)=0','literature',@src107),
('3.2.111','Konvergenz aus einer beschränkten Lyapunov-Funktion','Ist V nach unten beschränkt und V̇=-g≤0, so ist g integrierbar; bei gleichmäßiger Stetigkeit folgt g(t)→0.','\\dot V=-g\\leq0,\\ g\\text{ gleichmäßig stetig}\\Longrightarrow g(t)\\rightarrow0','\\dot V=-g\\leq0,\\ g\\text{ gleichmäßig stetig}\\Longrightarrow g(t)\\rightarrow0','literature',@src107),
('3.2.112','Funktionales Invarianzprinzip des FRZK','Unter den funktionalen Entsprechungen der LaSalle-Voraussetzungen nähert sich jede Trajektorie der größten invarianten Teilmenge der funktionalen Nullstellenmenge an.','\\operatorname{dist}(u(t;u_0),M_F)\\rightarrow0','\\operatorname{dist}(u(t;u_0),M_F)\\rightarrow0','original',NULL);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT
t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.word_latex,
t.provenance,t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.33.','verified',@revision
FROM tmp_thms_3233 t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th WHERE th.theorem_number=t.theorem_number
);

-- ---------------------------------------------------------------------------
-- Gleichungen
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_eqs_3233 (
 equation_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500),
 equation_latex TEXT NOT NULL,
 word_latex TEXT NOT NULL,
 plain_description TEXT NOT NULL,
 equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL,
 provenance ENUM('original','adapted','literature') NOT NULL,
 source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_3233 VALUES
('3.2849','Gleichung 3.2849','\\dot V(x)\\leq0','\\dot V(x)\\leq0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2850','Gleichung 3.2850','\\dot V(x)\\leq0\\longrightarrow E=\\{x\\mid\\dot V(x)=0\\}\\longrightarrow M\\subseteq E\\longrightarrow\\omega(x_0)\\subseteq M','\\dot V(x)\\leq0\\longrightarrow E=\\{x\\mid\\dot V(x)=0\\}\\longrightarrow M\\subseteq E\\longrightarrow\\omega(x_0)\\subseteq M','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2851','Gleichung 3.2851','V:X\\rightarrow\\mathbb{R}','V:X\\rightarrow\\mathbb{R}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2852','Gleichung 3.2852','L_c=\\{x\\in X\\mid V(x)=c\\}','L_c=\\{x\\in X\\mid V(x)=c\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2853','Gleichung 3.2853','\\Omega_c=\\{x\\in X\\mid V(x)\\leq c\\}','\\Omega_c=\\{x\\in X\\mid V(x)\\leq c\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2854','Gleichung 3.2854','\\dot V(x)\\leq0','\\dot V(x)\\leq0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2855','Gleichung 3.2855','V(x_0)\\leq c','V(x_0)\\leq c','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2856','Gleichung 3.2856','V(x(t))\\leq V(x_0)\\leq c\\qquad\\forall t\\geq0','V(x(t))\\leq V(x_0)\\leq c\\qquad\\forall t\\geq0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2857','Gleichung 3.2857','E=\\{x\\in X\\mid\\dot V(x)=0\\}','E=\\{x\\in X\\mid\\dot V(x)=0\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2858','Gleichung 3.2858','M=\\bigcup\\{N\\subseteq E\\mid N\\text{ ist invariant}\\}','M=\\bigcup\\{N\\subseteq E\\mid N\\text{ ist invariant}\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2859','Gleichung 3.2859','t_k\\rightarrow\\infty','t_k\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2860','Gleichung 3.2860','x(t_k;x_0)\\rightarrow y','x(t_k;x_0)\\rightarrow y','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2861','Gleichung 3.2861','\\omega(x_0)=\\{y\\in X\\mid\\exists\\,t_k\\rightarrow\\infty:x(t_k;x_0)\\rightarrow y\\}','\\omega(x_0)=\\{y\\in X\\mid\\exists\\,t_k\\rightarrow\\infty:x(t_k;x_0)\\rightarrow y\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2862','Gleichung 3.2862','\\operatorname{dist}(x,M)=\\inf_{y\\in M}\\|x-y\\|','\\operatorname{dist}(x,M)=\\inf_{y\\in M}\\|x-y\\|','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2863','Gleichung 3.2863','\\lim_{t\\rightarrow\\infty}\\operatorname{dist}(x(t),M)=0','\\lim_{t\\rightarrow\\infty}\\operatorname{dist}(x(t),M)=0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2864','Gleichung 3.2864','V:\\Omega\\rightarrow\\mathbb{R}','V:\\Omega\\rightarrow\\mathbb{R}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2865','Gleichung 3.2865','\\dot V(x)\\leq0\\qquad\\forall x\\in\\Omega','\\dot V(x)\\leq0\\qquad\\forall x\\in\\Omega','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2866','Gleichung 3.2866','E=\\{x\\in\\Omega\\mid\\dot V(x)=0\\}','E=\\{x\\in\\Omega\\mid\\dot V(x)=0\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2867','Gleichung 3.2867','\\operatorname{dist}(x(t;x_0),M)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','\\operatorname{dist}(x(t;x_0),M)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2868','Gleichung 3.2868','\\dot V(x)\\leq0','\\dot V(x)\\leq0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2869','Gleichung 3.2869','E=\\{x\\in\\Omega\\mid\\dot V(x)=0\\}','E=\\{x\\in\\Omega\\mid\\dot V(x)=0\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2870','Gleichung 3.2870','M=\\{x^\\ast\\}','M=\\{x^\\ast\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2871','Gleichung 3.2871','\\dot x_1=-x_1+x_2','\\dot x_1=-x_1+x_2','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2872','Gleichung 3.2872','\\dot x_2=-x_1-x_2','\\dot x_2=-x_1-x_2','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2873','Gleichung 3.2873','V(x_1,x_2)=\\frac{1}{2}(x_1^2+x_2^2)','V(x_1,x_2)=\\frac{1}{2}(x_1^2+x_2^2)','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2874','Gleichung 3.2874','\\dot V=x_1\\dot x_1+x_2\\dot x_2','\\dot V=x_1\\dot x_1+x_2\\dot x_2','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2875','Gleichung 3.2875','\\dot V=x_1(-x_1+x_2)+x_2(-x_1-x_2)','\\dot V=x_1(-x_1+x_2)+x_2(-x_1-x_2)','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2876','Gleichung 3.2876','\\dot V=-x_1^2-x_2^2','\\dot V=-x_1^2-x_2^2','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src106),
('3.2877','Gleichung 3.2877','|t_1-t_2|<\\delta\\Longrightarrow|g(t_1)-g(t_2)|<\\varepsilon','|t_1-t_2|<\\delta\\Longrightarrow|g(t_1)-g(t_2)|<\\varepsilon','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src107),
('3.2878','Gleichung 3.2878','\\lim_{t\\rightarrow\\infty}\\int_0^t g(\\tau)\\,\\mathrm d\\tau','\\lim_{t\\rightarrow\\infty}\\int_0^t g(\\tau)\\,\\mathrm d\\tau','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src107),
('3.2879','Gleichung 3.2879','\\lim_{t\\rightarrow\\infty}g(t)=0','\\lim_{t\\rightarrow\\infty}g(t)=0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src107),
('3.2880','Gleichung 3.2880','\\dot V(t)=-g(t)\\leq0','\\dot V(t)=-g(t)\\leq0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src107),
('3.2881','Gleichung 3.2881','\\int_0^\\infty g(t)\\,\\mathrm dt<\\infty','\\int_0^\\infty g(t)\\,\\mathrm dt<\\infty','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src107),
('3.2882','Gleichung 3.2882','\\lim_{t\\rightarrow\\infty}g(t)=0','\\lim_{t\\rightarrow\\infty}g(t)=0','Formale Gleichung aus Abschnitt 3.2.33.','other','literature',@src107),
('3.2883','Gleichung 3.2883','E_F=\\{u\\in S\\mid\\dot V_F(u)=0\\}','E_F=\\{u\\in S\\mid\\dot V_F(u)=0\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2884','Gleichung 3.2884','M_F=\\operatorname{Inv}(E_F)','M_F=\\operatorname{Inv}(E_F)','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2885','Gleichung 3.2885','\\omega_F(u_0)=\\{v\\in S\\mid\\exists\\,t_k\\rightarrow\\infty:u(t_k;u_0)\\rightarrow v\\}','\\omega_F(u_0)=\\{v\\in S\\mid\\exists\\,t_k\\rightarrow\\infty:u(t_k;u_0)\\rightarrow v\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2886','Gleichung 3.2886','\\dot V_F(u)\\leq0\\qquad\\forall u\\in\\Omega_F','\\dot V_F(u)\\leq0\\qquad\\forall u\\in\\Omega_F','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2887','Gleichung 3.2887','E_F=\\{u\\in\\Omega_F\\mid\\dot V_F(u)=0\\}','E_F=\\{u\\in\\Omega_F\\mid\\dot V_F(u)=0\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2888','Gleichung 3.2888','\\operatorname{dist}(u(t;u_0),M_F)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','\\operatorname{dist}(u(t;u_0),M_F)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2889','Gleichung 3.2889','\\dot u=F_{\\mathrm{FRZK}}(u),\\qquad u\\in E_F','\\dot u=F_{\\mathrm{FRZK}}(u),\\qquad u\\in E_F','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2890','Gleichung 3.2890','F_{\\mathrm{FRZK}}(u)=0\\qquad\\forall u\\in M_F','F_{\\mathrm{FRZK}}(u)=0\\qquad\\forall u\\in M_F','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2891','Gleichung 3.2891','u(t)\\in M_F\\qquad\\forall t\\geq0','u(t)\\in M_F\\qquad\\forall t\\geq0','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2892','Gleichung 3.2892','\\dot u(t)\\neq0','\\dot u(t)\\neq0','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2893','Gleichung 3.2893','C_F\\subseteq S','C_F\\subseteq S','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2894','Gleichung 3.2894','\\operatorname{dist}(u(t),C_F)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','\\operatorname{dist}(u(t),C_F)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL),
('3.2895','Gleichung 3.2895','B_{\\varepsilon_F}(C_F)=\\{u\\in S\\mid\\operatorname{dist}(u,C_F)<\\varepsilon_F\\}','B_{\\varepsilon_F}(C_F)=\\{u\\in S\\mid\\operatorname{dist}(u,C_F)<\\varepsilon_F\\}','Formale Gleichung aus Abschnitt 3.2.33.','other','original',NULL);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
t.equation_number,@section,t.title,t.equation_latex,t.word_latex,t.plain_description,
t.equation_type,t.provenance,t.source_id,
'Im Text von Abschnitt 3.2.33 eingeführt, verwendet oder hergeleitet.',
'Voraussetzungen gemäß Abschnitt 3.2.33.','verified',@revision
FROM tmp_eqs_3233 t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e WHERE e.equation_number=t.equation_number
);

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll und Repository-Zähler
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT
@revision,@section,'created','section','3.2.33',
'Abschnitt 3.2.33 vollständig angelegt.',
'17 Definitionen, 6 Sätze, 47 Gleichungen, zwei neue Quellen und eine weiterverwendete Quelle.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section AND object_reference='3.2.33'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.33'),
('current_section','3.2.34'),
('last_definition_number','3.2.528'),
('next_definition_number','3.2.529'),
('last_theorem_number','3.2.112'),
('next_theorem_number','3.2.113'),
('last_equation_number','3.2895'),
('next_equation_number','3.2896'),
('last_citation_number','107'),
('next_citation_number','108')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3233;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3233;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3233;

COMMIT;

-- ---------------------------------------------------------------------------
-- Abschlussprüfung
-- ---------------------------------------------------------------------------

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code='3.2.33';

SELECT COUNT(*) AS definitionen_3_2_33
FROM definitions
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED) BETWEEN 512 AND 528;

SELECT COUNT(*) AS saetze_3_2_33
FROM theorems
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED) BETWEEN 107 AND 112;

SELECT COUNT(*) AS gleichungen_3_2_33
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 2849 AND 2895;

SELECT
s.citation_number,s.short_citation_text,s.verification_status,
su.usage_type,su.exact_location
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section
ORDER BY s.citation_number;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN (
'last_completed_section','current_section',
'last_definition_number','next_definition_number',
'last_theorem_number','next_theorem_number',
'last_equation_number','next_equation_number',
'last_citation_number','next_citation_number'
)
ORDER BY counter_key;
