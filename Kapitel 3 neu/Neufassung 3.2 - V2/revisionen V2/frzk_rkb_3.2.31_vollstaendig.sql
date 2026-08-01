-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.31
-- Gleichgewichtszustände, Stabilität und Attraktoren
-- Definitionen 3.2.459–3.2.500
-- Sätze 3.2.101–3.2.103
-- Gleichungen (3.2760)–(3.2821)
-- Literatur [103]–[104]
-- Schema geprüft gegen frzk_rkb_stand_ende_3.2.29.sql
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.31-V1',NOW(),'section','3.2.31','3.2.31-v1',
'Abschnitt 3.2.31 mit Gleichgewichtszuständen, Stabilitätsbegriffen, Linearisierung, Attraktoren und FRZK-spezifischen Stabilitätsgrößen.',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.31-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.31-V1' COLLATE utf8mb4_unicode_ci
 LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci
 LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.31','Gleichgewichtszustände, Stabilität und Attraktoren',
3,3.2310,'final',1,
'Gleichgewichte kontinuierlicher und diskreter Systeme, invariante Mengen, Lyapunov-Stabilität, Linearisierung, Attraktoren sowie FRZK-spezifische Begriffe für Drift, Robustheit und Resilienz.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.31' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.31' COLLATE utf8mb4_unicode_ci
 LIMIT 1
);

-- Quellen [103] und [104]
INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Khalil','Hassan K.','Khalil, Hassan K.','Autor der Quelle [103].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Khalil, Hassan K.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Strogatz','Steven H.','Strogatz, Steven H.','Autor der Quelle [104].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Strogatz, Steven H.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
103,'khalil_nonlinear_systems_2002','book','Nonlinear Systems',
1992,2002,'Prentice Hall','Upper Saddle River, New Jersey','3rd edition','9780130673893','en',1,'textbook',10,'verified','3.2.31',
'Erstnennung für Gleichgewichte, Lyapunov-Stabilität, exponentielle Stabilität, Linearisierung und Eigenwertkriterien.',
'Khalil, Hassan K.: Nonlinear Systems. 3rd ed. Upper Saddle River, New Jersey: Prentice Hall, 2002.',
'Khalil, Nonlinear Systems [103]',
'Grundlage für die Stabilitäts- und Linearisierungsbegriffe des Abschnitts.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=103
 OR source_key COLLATE utf8mb4_unicode_ci='khalil_nonlinear_systems_2002' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
104,'strogatz_nonlinear_dynamics_chaos_2015','book','Nonlinear Dynamics and Chaos',
1994,2015,'Westview Press','Boulder, Colorado','2nd edition','9780813349107','en',1,'textbook',9,'verified','3.2.31',
'Erstnennung für invariante Mengen, Attraktoren, Einzugsgebiete, Grenzzyklen und seltsame Attraktoren.',
'Strogatz, Steven H.: Nonlinear Dynamics and Chaos. 2nd ed. Boulder, Colorado: Westview Press, 2015.',
'Strogatz, Nonlinear Dynamics and Chaos [104]',
'Grundlage für die qualitative Dynamik und Attraktorbegriffe des Abschnitts.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=104
 OR source_key COLLATE utf8mb4_unicode_ci='strogatz_nonlinear_dynamics_chaos_2015' COLLATE utf8mb4_unicode_ci
);

SET @src_103 := (SELECT source_id FROM sources WHERE citation_number=103 LIMIT 1);
SET @src_104 := (SELECT source_id FROM sources WHERE citation_number=104 LIMIT 1);
SET @author_103 := (SELECT author_id FROM authors WHERE normalized_name='Khalil, Hassan K.' LIMIT 1);
SET @author_104 := (SELECT author_id FROM authors WHERE normalized_name='Strogatz, Steven H.' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_103,@author_103,1,'author'
WHERE @src_103 IS NOT NULL AND @author_103 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_103 AND author_id=@author_103);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_104,@author_104,1,'author'
WHERE @src_104 IS NOT NULL AND @author_104 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_104 AND author_id=@author_104);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src_103,@section,'first_citation',
'Gleichgewichte, Lyapunov-Stabilität, Attraktivität, exponentielle Stabilität, diskrete Stabilität und Linearisierung.',
'3.2.31',1,1,'Erstnennung [103].',@revision
WHERE @src_103 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@src_103 AND section_id=@section AND exact_location='3.2.31'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src_104,@section,'first_citation',
'Invariante Mengen, Attraktoren, Einzugsgebiete, Grenzzyklen und seltsame Attraktoren.',
'3.2.31',1,1,'Erstnennung [104].',@revision
WHERE @src_104 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@src_104 AND section_id=@section AND exact_location='3.2.31'
);

CREATE TEMPORARY TABLE tmp_defs_3231 (
 definition_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 definition_text LONGTEXT NOT NULL,
 formal_latex LONGTEXT NULL,
 word_latex LONGTEXT NULL,
 provenance ENUM('original','adapted','literature') NOT NULL,
 source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_3231 VALUES
('3.2.459','Gleichgewichtszustand eines kontinuierlichen Systems','Ein Zustand x* heißt Gleichgewichtszustand des autonomen Systems, wenn f(x*)=0 gilt.','f(x^\\ast)=0','f(x^\\ast)=0','literature',@src_103),
('3.2.460','Stationäre Lösung','Eine stationäre Lösung ist eine zeitlich konstante Lösung eines dynamischen Systems.','x(t)\\equiv x^\\ast','x(t)\\equiv x^\\ast','literature',@src_103),
('3.2.461','Fixpunkt eines diskreten Systems','Ein Zustand x* heißt Fixpunkt einer Abbildung F, wenn F(x*)=x* gilt.','F(x^\\ast)=x^\\ast','F(x^\\ast)=x^\\ast','literature',@src_103),
('3.2.462','Periodischer Punkt','Ein Zustand x* heißt periodischer Punkt der Periode p, wenn F^p(x*)=x* und für alle q<p keine frühere Rückkehr erfolgt.','F^p(x^\\ast)=x^\\ast','F^p(x^\\ast)=x^\\ast','literature',@src_103),
('3.2.463','Positiv invariante Menge','Eine Menge M heißt positiv invariant, wenn jede in M beginnende Trajektorie für alle zukünftigen Zeiten in M verbleibt.','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\quad\\forall t\\geq0','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\quad\\forall t\\geq0','literature',@src_104),
('3.2.464','Invariante Menge','Eine Menge M heißt invariant, wenn sie durch den Fluss auf sich selbst abgebildet wird.','\\Phi_t(M)=M','\\Phi_t(M)=M','literature',@src_104),
('3.2.465','Negativ invariante Menge','Eine Menge M heißt negativ invariant, wenn jede rückwärts fortsetzbare Trajektorie für negative Zeiten in M verbleibt.','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\quad\\forall t\\leq0','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\quad\\forall t\\leq0','literature',@src_104),
('3.2.466','Randinvarianz','Der Rand einer Menge heißt invariant, wenn er durch den Fluss nicht verlassen wird.','\\Phi_t(\\partial M)\\subseteq\\partial M','\\Phi_t(\\partial M)\\subseteq\\partial M','literature',@src_104),
('3.2.467','Umgebung eines Gleichgewichts','Die offene Epsilon-Umgebung eines Gleichgewichts besteht aus allen Zuständen mit Normabstand kleiner Epsilon.','B_\\varepsilon(x^\\ast)=\\{x\\in\\mathbb{R}^n\\mid\\|x-x^\\ast\\|<\\varepsilon\\}','B_\\varepsilon(x^\\ast)=\\{x\\in\\mathbb{R}^n\\mid\\|x-x^\\ast\\|<\\varepsilon\\}','literature',@src_103),
('3.2.468','Stabilität im Sinne von Lyapunov','Ein Gleichgewicht heißt stabil, wenn hinreichend kleine Anfangsstörungen für alle zukünftigen Zeiten klein bleiben.','\\forall\\varepsilon>0\\ \\exists\\delta>0:\\|x_0-x^\\ast\\|<\\delta\\Rightarrow\\|x(t;x_0)-x^\\ast\\|<\\varepsilon','\\forall\\varepsilon>0\\ \\exists\\delta>0:\\|x_0-x^\\ast\\|<\\delta\\Rightarrow\\|x(t;x_0)-x^\\ast\\|<\\varepsilon','literature',@src_103),
('3.2.469','Instabilität','Ein Gleichgewicht heißt instabil, wenn es nicht stabil im Sinne von Lyapunov ist.','\\exists\\varepsilon_0>0\\ \\forall\\delta>0\\ \\exists x_0,t:\\|x_0-x^\\ast\\|<\\delta\\land\\|x(t;x_0)-x^\\ast\\|\\geq\\varepsilon_0','\\exists\\varepsilon_0>0\\ \\forall\\delta>0\\ \\exists x_0,t:\\|x_0-x^\\ast\\|<\\delta\\land\\|x(t;x_0)-x^\\ast\\|\\geq\\varepsilon_0','literature',@src_103),
('3.2.470','Attraktivität','Ein Gleichgewicht heißt attraktiv, wenn Trajektorien aus einer Umgebung asymptotisch gegen dieses Gleichgewicht konvergieren.','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','literature',@src_103),
('3.2.471','Asymptotische Stabilität','Ein Gleichgewicht heißt asymptotisch stabil, wenn es Lyapunov-stabil und attraktiv ist.','\\text{stabil}\\land\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','\\text{stabil}\\land\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','literature',@src_103),
('3.2.472','Globale asymptotische Stabilität','Ein Gleichgewicht heißt global asymptotisch stabil, wenn alle Zustände des betrachteten Zustandsraums gegen dieses Gleichgewicht konvergieren.','\\forall x_0\\in X:\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','\\forall x_0\\in X:\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','literature',@src_103),
('3.2.473','Exponentielle Stabilität','Ein Gleichgewicht heißt exponentiell stabil, wenn Zustandsabweichungen mindestens exponentiell abklingen.','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|','literature',@src_103),
('3.2.474','Lyapunov-Stabilität eines diskreten Fixpunktes','Ein diskreter Fixpunkt heißt stabil, wenn kleine Anfangsstörungen für alle diskreten Zeitpunkte klein bleiben.','\\forall\\varepsilon>0\\ \\exists\\delta>0:\\|x_0-x^\\ast\\|<\\delta\\Rightarrow\\|x_k-x^\\ast\\|<\\varepsilon','\\forall\\varepsilon>0\\ \\exists\\delta>0:\\|x_0-x^\\ast\\|<\\delta\\Rightarrow\\|x_k-x^\\ast\\|<\\varepsilon','literature',@src_103),
('3.2.475','Asymptotische Stabilität eines diskreten Fixpunktes','Ein diskreter Fixpunkt heißt asymptotisch stabil, wenn er stabil ist und x_k gegen x* konvergiert.','\\lim_{k\\rightarrow\\infty}x_k=x^\\ast','\\lim_{k\\rightarrow\\infty}x_k=x^\\ast','literature',@src_103),
('3.2.476','Exponentielle Stabilität eines diskreten Fixpunktes','Ein diskreter Fixpunkt heißt exponentiell stabil, wenn seine Abweichung geometrisch abnimmt.','\\|x_k-x^\\ast\\|\\leq c q^k\\|x_0-x^\\ast\\|','\\|x_k-x^\\ast\\|\\leq c q^k\\|x_0-x^\\ast\\|','literature',@src_103),
('3.2.477','Jacobi-Matrix des Vektorfeldes','Die Jacobi-Matrix enthält die partiellen Ableitungen der Komponenten eines Vektorfeldes.','J_f(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)_{i,j=1}^{n}','J_f(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)_{i,j=1}^{n}','literature',@src_103),
('3.2.478','Linearisierung am Gleichgewicht','Die Linearisierung zerlegt die Dynamik in einen linearen Hauptteil und einen höherwertigen Restterm.','\\dot{\\xi}=A\\xi+r(\\xi),\\quad A=J_f(x^\\ast)','\\dot{\\xi}=A\\xi+r(\\xi),\\quad A=J_f(x^\\ast)','literature',@src_103),
('3.2.479','Hyperbolisches Gleichgewicht','Ein Gleichgewicht heißt hyperbolisch, wenn kein Eigenwert der Jacobi-Matrix einen verschwindenden Realteil besitzt.','\\operatorname{Re}(\\lambda_i)\\neq0\\quad\\forall i','\\operatorname{Re}(\\lambda_i)\\neq0\\quad\\forall i','literature',@src_103),
('3.2.480','Stabiles Eigenwertteilgebiet','Der stabile Spektralbereich umfasst alle Eigenwerte mit negativem Realteil.','\\sigma_s(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)<0\\}','\\sigma_s(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)<0\\}','literature',@src_103),
('3.2.481','Instabiles Eigenwertteilgebiet','Der instabile Spektralbereich umfasst alle Eigenwerte mit positivem Realteil.','\\sigma_u(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)>0\\}','\\sigma_u(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)>0\\}','literature',@src_103),
('3.2.482','Zentrales Eigenwertteilgebiet','Der zentrale Spektralbereich umfasst alle Eigenwerte mit verschwindendem Realteil.','\\sigma_c(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)=0\\}','\\sigma_c(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)=0\\}','literature',@src_103),
('3.2.483','Attraktor','Eine kompakte invariante Menge heißt Attraktor, wenn Zustände aus einer Umgebung asymptotisch zu ihr gelangen.','\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0','\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0','literature',@src_104),
('3.2.484','Einzugsgebiet eines Attraktors','Das Einzugsgebiet umfasst alle Anfangszustände, deren Trajektorien sich dem Attraktor annähern.','\\mathcal{B}(A)=\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0\\}','\\mathcal{B}(A)=\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0\\}','literature',@src_104),
('3.2.485','Punktattraktor','Ein Punktattraktor besteht aus einem einzelnen asymptotisch stabilen Gleichgewicht.','A=\\{x^\\ast\\}','A=\\{x^\\ast\\}','literature',@src_104),
('3.2.486','Periodischer Attraktor','Eine stabile periodische Trajektorie heißt periodischer Attraktor.','x(t+T)=x(t)','x(t+T)=x(t)','literature',@src_104),
('3.2.487','Grenzzyklus','Ein Grenzzyklus ist eine isolierte geschlossene Trajektorie eines kontinuierlichen dynamischen Systems.','','','literature',@src_104),
('3.2.488','Seltsamer Attraktor','Ein seltsamer Attraktor ist eine anziehende invariante Menge mit komplexer, häufig fraktaler Struktur und empfindlicher Abhängigkeit von Anfangsbedingungen.','','','literature',@src_104),
('3.2.489','Funktionaler Gleichgewichtszustand des FRZK','Ein Zustand u* heißt funktionaler Gleichgewichtszustand, wenn der FRZK-Entwicklungsoperator keine Zustandsänderung erzeugt.','F_{\\mathrm{FRZK}}(u^\\ast)=0','F_{\\mathrm{FRZK}}(u^\\ast)=0','original',NULL),
('3.2.490','Funktionale Stabilität des FRZK','Ein funktionaler Gleichgewichtszustand heißt stabil, wenn kleine Anfangsabweichungen innerhalb eines vorgegebenen Toleranzbereichs verbleiben.','\\|u_0-u^\\ast\\|<\\delta\\Rightarrow\\|u(t)-u^\\ast\\|<\\varepsilon','\\|u_0-u^\\ast\\|<\\delta\\Rightarrow\\|u(t)-u^\\ast\\|<\\varepsilon','original',NULL),
('3.2.491','Funktionale Attraktivität','Ein funktionaler Gleichgewichtszustand heißt attraktiv, wenn die Zustandsabweichung asymptotisch verschwindet.','\\lim_{t\\rightarrow\\infty}\\|u(t)-u^\\ast\\|=0','\\lim_{t\\rightarrow\\infty}\\|u(t)-u^\\ast\\|=0','original',NULL),
('3.2.492','Funktionaler Attraktor','Eine invariante Menge im FRZK-Zustandsraum heißt funktionaler Attraktor, wenn sich Trajektorien aus ihrem Einzugsgebiet asymptotisch annähern.','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0','original',NULL),
('3.2.493','Funktionales Einzugsgebiet','Das funktionale Einzugsgebiet enthält alle Anfangszustände, deren Trajektorien gegen einen funktionalen Attraktor konvergieren.','\\mathcal{B}_{\\mathrm{F}}(A_{\\mathrm{F}})=\\{u_0\\in S\\mid\\operatorname{dist}(u(t;u_0),A_{\\mathrm{F}})\\rightarrow0\\}','\\mathcal{B}_{\\mathrm{F}}(A_{\\mathrm{F}})=\\{u_0\\in S\\mid\\operatorname{dist}(u(t;u_0),A_{\\mathrm{F}})\\rightarrow0\\}','original',NULL),
('3.2.494','Funktionale Drift','Die funktionale Drift ist der Normabstand eines Zustands zu einem Referenzzustand.','D_{\\mathrm{F}}(t)=\\|u(t)-u_{\\mathrm{ref}}\\|','D_{\\mathrm{F}}(t)=\\|u(t)-u_{\\mathrm{ref}}\\|','original',NULL),
('3.2.495','Relative funktionale Drift','Die relative funktionale Drift normiert den Zustandsabstand auf die Norm des Referenzzustands.','D_{\\mathrm{F,rel}}(t)=\\frac{\\|u(t)-u_{\\mathrm{ref}}\\|}{\\|u_{\\mathrm{ref}}\\|}','D_{\\mathrm{F,rel}}(t)=\\frac{\\|u(t)-u_{\\mathrm{ref}}\\|}{\\|u_{\\mathrm{ref}}\\|}','original',NULL),
('3.2.496','Funktionale Rückkehrrate','Die funktionale Rückkehrrate beschreibt die lokale logarithmische Abnahme des Abstands zu einem Referenzzustand.','r_{\\mathrm{F}}(t)=-\\frac{\\mathrm{d}}{\\mathrm{d}t}\\ln\\|u(t)-u^\\ast\\|','r_{\\mathrm{F}}(t)=-\\frac{\\mathrm{d}}{\\mathrm{d}t}\\ln\\|u(t)-u^\\ast\\|','original',NULL),
('3.2.497','Funktionale Störung','Eine funktionale Störung ist eine Zustandsabweichung oder externe Einwirkung auf das FRZK-Entwicklungsgesetz.','\\dot{u}=F_{\\mathrm{FRZK}}(u)+\\eta(t)','\\dot{u}=F_{\\mathrm{FRZK}}(u)+\\eta(t)','original',NULL),
('3.2.498','Funktionale Robustheit','Ein funktionaler Zustand heißt robust, wenn zulässige Störungen nur begrenzte Zustandsabweichungen hervorrufen.','\\sup_{t\\geq0}\\|u_\\eta(t)-u_0(t)\\|\\leq C\\|\\eta\\|_{\\mathcal{H}}','\\sup_{t\\geq0}\\|u_\\eta(t)-u_0(t)\\|\\leq C\\|\\eta\\|_{\\mathcal{H}}','original',NULL),
('3.2.499','Funktionale Resilienz','Funktionale Resilienz bezeichnet die Rückkehr in das Einzugsgebiet eines funktionalen Attraktors nach einer zeitlich begrenzten Störung.','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0','original',NULL),
('3.2.500','Funktionaler Stabilitätsbereich','Der funktionale Stabilitätsbereich enthält alle Anfangszustände, für die die gewählte Stabilitätsbedingung erfüllt ist.','\\mathcal{S}_{\\mathrm{stab}}(u^\\ast)=\\{u_0\\in S\\mid u(t;u_0)\\text{ erfüllt die Stabilitätsbedingung}\\}','\\mathcal{S}_{\\mathrm{stab}}(u^\\ast)=\\{u_0\\in S\\mid u(t;u_0)\\text{ erfüllt die Stabilitätsbedingung}\\}','original',NULL);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,NULLIF(t.formal_latex,''),NULLIF(t.word_latex,''),
t.provenance,t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.31.',
CASE WHEN t.provenance='original'
     THEN 'FRZK-spezifische Eigenkonstruktion; empirische Operationalisierung gesondert erforderlich.'
     ELSE 'Etablierte Definition aus der Theorie dynamischer Systeme.'
END,
'verified',@revision
FROM tmp_defs_3231 t
WHERE NOT EXISTS (
 SELECT 1 FROM definitions d
 WHERE d.definition_number COLLATE utf8mb4_unicode_ci=t.definition_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_thms_3231 (
 theorem_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 statement_text LONGTEXT NOT NULL,
 statement_latex LONGTEXT NULL,
 word_latex LONGTEXT NULL,
 provenance ENUM('original','adapted','literature') NOT NULL,
 source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_3231 VALUES
('3.2.101','Äquivalenz von Gleichgewicht und stationärer Lösung','Für ein autonomes System sind Gleichgewicht, stationäre Lösung und invariantes Verhalten unter dem Fluss äquivalent.','f(x^\\ast)=0\\iff x(t)\\equiv x^\\ast\\iff\\Phi_t(x^\\ast)=x^\\ast','f(x^\\ast)=0\\iff x(t)\\equiv x^\\ast\\iff\\Phi_t(x^\\ast)=x^\\ast','literature',@src_103),
('3.2.102','Exponentielle Stabilität impliziert asymptotische Stabilität','Jedes exponentiell stabile Gleichgewicht ist asymptotisch stabil.','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|\\Rightarrow x(t;x_0)\\rightarrow x^\\ast','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|\\Rightarrow x(t;x_0)\\rightarrow x^\\ast','literature',@src_103),
('3.2.103','Lokale Stabilität durch Linearisierung','Sind alle Eigenwerte der Jacobi-Matrix strikt links in der komplexen Ebene, ist das Gleichgewicht lokal asymptotisch stabil; ein Eigenwert mit positivem Realteil impliziert Instabilität.','\\operatorname{Re}(\\lambda_i)<0\\ \\forall i\\Rightarrow\\text{lokal asymptotisch stabil}','\\operatorname{Re}(\\lambda_i)<0\\ \\forall i\\Rightarrow\\text{lokal asymptotisch stabil}','literature',@src_103);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT
t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.word_latex,
t.provenance,t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.31.','verified',@revision
FROM tmp_thms_3231 t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th
 WHERE th.theorem_number COLLATE utf8mb4_unicode_ci=t.theorem_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_eqs_3231 (
 equation_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500),
 equation_latex TEXT NOT NULL,
 word_latex TEXT NOT NULL,
 plain_description TEXT NOT NULL,
 equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL,
 provenance ENUM('original','adapted','literature') NOT NULL,
 source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_3231 VALUES
('3.2760','Gleichung 3.2760','\\dot{x}=f(x)','\\dot{x}=f(x)','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2761','Gleichung 3.2761','f(x^\\ast)=0','f(x^\\ast)=0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2762','Gleichung 3.2762','x(t)=x^\\ast\\qquad\\forall t\\geq0','x(t)=x^\\ast\\qquad\\forall t\\geq0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2763','Gleichung 3.2763','x(t)\\equiv x^\\ast','x(t)\\equiv x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2764','Gleichung 3.2764','f(x^\\ast)=0\\iff x(t)\\equiv x^\\ast\\iff\\Phi_t(x^\\ast)=x^\\ast','f(x^\\ast)=0\\iff x(t)\\equiv x^\\ast\\iff\\Phi_t(x^\\ast)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2765','Gleichung 3.2765','F(x^\\ast)=x^\\ast','F(x^\\ast)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2766','Gleichung 3.2766','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2767','Gleichung 3.2767','x_k=x^\\ast\\qquad\\forall k\\in\\mathbb{N}_0','x_k=x^\\ast\\qquad\\forall k\\in\\mathbb{N}_0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2768','Gleichung 3.2768','F^p(x^\\ast)=x^\\ast','F^p(x^\\ast)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2769','Gleichung 3.2769','F^q(x^\\ast)\\neq x^\\ast','F^q(x^\\ast)\\neq x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2770','Gleichung 3.2770','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\qquad\\forall t\\geq0','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\qquad\\forall t\\geq0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2771','Gleichung 3.2771','\\Phi_t(M)=M','\\Phi_t(M)=M','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2772','Gleichung 3.2772','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\qquad\\forall t\\leq0','x_0\\in M\\Longrightarrow\\Phi_t(x_0)\\in M\\qquad\\forall t\\leq0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2773','Gleichung 3.2773','\\Phi_t(\\partial M)\\subseteq\\partial M','\\Phi_t(\\partial M)\\subseteq\\partial M','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2774','Gleichung 3.2774','B_\\varepsilon(x^\\ast)=\\{x\\in\\mathbb{R}^n\\mid\\|x-x^\\ast\\|<\\varepsilon\\}','B_\\varepsilon(x^\\ast)=\\{x\\in\\mathbb{R}^n\\mid\\|x-x^\\ast\\|<\\varepsilon\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2775','Gleichung 3.2775','\\|x_0-x^\\ast\\|<\\delta','\\|x_0-x^\\ast\\|<\\delta','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2776','Gleichung 3.2776','\\|x(t;x_0)-x^\\ast\\|<\\varepsilon\\qquad\\forall t\\geq0','\\|x(t;x_0)-x^\\ast\\|<\\varepsilon\\qquad\\forall t\\geq0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2777','Gleichung 3.2777','\\|x_0-x^\\ast\\|<\\delta','\\|x_0-x^\\ast\\|<\\delta','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2778','Gleichung 3.2778','\\|x(t;x_0)-x^\\ast\\|\\geq\\varepsilon_0','\\|x(t;x_0)-x^\\ast\\|\\geq\\varepsilon_0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2779','Gleichung 3.2779','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2780','Gleichung 3.2780','\\forall\\varepsilon>0\\;\\exists\\delta>0:\\|x_0-x^\\ast\\|<\\delta\\Longrightarrow\\|x(t;x_0)-x^\\ast\\|<\\varepsilon','\\forall\\varepsilon>0\\;\\exists\\delta>0:\\|x_0-x^\\ast\\|<\\delta\\Longrightarrow\\|x(t;x_0)-x^\\ast\\|<\\varepsilon','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2781','Gleichung 3.2781','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2782','Gleichung 3.2782','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','\\lim_{t\\rightarrow\\infty}x(t;x_0)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2783','Gleichung 3.2783','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2784','Gleichung 3.2784','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|','\\|x(t;x_0)-x^\\ast\\|\\leq c e^{-\\lambda t}\\|x_0-x^\\ast\\|','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2785','Gleichung 3.2785','\\lim_{t\\rightarrow\\infty}e^{-\\lambda t}=0','\\lim_{t\\rightarrow\\infty}e^{-\\lambda t}=0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2786','Gleichung 3.2786','\\lim_{t\\rightarrow\\infty}\\|x(t;x_0)-x^\\ast\\|=0','\\lim_{t\\rightarrow\\infty}\\|x(t;x_0)-x^\\ast\\|=0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2787','Gleichung 3.2787','\\|x_0-x^\\ast\\|<\\delta','\\|x_0-x^\\ast\\|<\\delta','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2788','Gleichung 3.2788','\\|x_k-x^\\ast\\|<\\varepsilon\\qquad\\forall k\\in\\mathbb{N}_0','\\|x_k-x^\\ast\\|<\\varepsilon\\qquad\\forall k\\in\\mathbb{N}_0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2789','Gleichung 3.2789','\\lim_{k\\rightarrow\\infty}x_k=x^\\ast','\\lim_{k\\rightarrow\\infty}x_k=x^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2790','Gleichung 3.2790','\\|x_k-x^\\ast\\|\\leq c q^k\\|x_0-x^\\ast\\|','\\|x_k-x^\\ast\\|\\leq c q^k\\|x_0-x^\\ast\\|','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2791','Gleichung 3.2791','f:\\mathbb{R}^n\\rightarrow\\mathbb{R}^n','f:\\mathbb{R}^n\\rightarrow\\mathbb{R}^n','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2792','Gleichung 3.2792','J_f(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)_{i,j=1}^{n}','J_f(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)_{i,j=1}^{n}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2793','Gleichung 3.2793','\\dot{\\xi}=A\\xi+r(\\xi)','\\dot{\\xi}=A\\xi+r(\\xi)','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2794','Gleichung 3.2794','A=J_f(x^\\ast)','A=J_f(x^\\ast)','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2795','Gleichung 3.2795','\\lim_{\\|\\xi\\|\\rightarrow0}\\frac{\\|r(\\xi)\\|}{\\|\\xi\\|}=0','\\lim_{\\|\\xi\\|\\rightarrow0}\\frac{\\|r(\\xi)\\|}{\\|\\xi\\|}=0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2796','Gleichung 3.2796','\\operatorname{Re}(\\lambda_i)<0\\qquad\\forall i','\\operatorname{Re}(\\lambda_i)<0\\qquad\\forall i','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2797','Gleichung 3.2797','\\operatorname{Re}(\\lambda_i)>0','\\operatorname{Re}(\\lambda_i)>0','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2798','Gleichung 3.2798','\\operatorname{Re}(\\lambda_i)\\neq0\\qquad\\forall i','\\operatorname{Re}(\\lambda_i)\\neq0\\qquad\\forall i','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2799','Gleichung 3.2799','\\sigma_s(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)<0\\}','\\sigma_s(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)<0\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2800','Gleichung 3.2800','\\sigma_u(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)>0\\}','\\sigma_u(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)>0\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2801','Gleichung 3.2801','\\sigma_c(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)=0\\}','\\sigma_c(A)=\\{\\lambda\\in\\sigma(A)\\mid\\operatorname{Re}(\\lambda)=0\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_103),
('3.2802','Gleichung 3.2802','\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_104),
('3.2803','Gleichung 3.2803','\\operatorname{dist}(x,A)=\\inf_{a\\in A}\\|x-a\\|','\\operatorname{dist}(x,A)=\\inf_{a\\in A}\\|x-a\\|','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_104),
('3.2804','Gleichung 3.2804','\\mathcal{B}(A)=\\left\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0\\right\\}','\\mathcal{B}(A)=\\left\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi_t(x_0),A)\\rightarrow0\\right\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_104),
('3.2805','Gleichung 3.2805','A=\\{x^\\ast\\}','A=\\{x^\\ast\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_104),
('3.2806','Gleichung 3.2806','x(t+T)=x(t)','x(t+T)=x(t)','Formale Gleichung aus Abschnitt 3.2.31.','other','literature',@src_104),
('3.2807','Gleichung 3.2807','F_{\\mathrm{FRZK}}(u^\\ast)=0','F_{\\mathrm{FRZK}}(u^\\ast)=0','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2808','Gleichung 3.2808','\\mathcal{T}_{\\mathrm{FRZK}}(u^\\ast)=u^\\ast','\\mathcal{T}_{\\mathrm{FRZK}}(u^\\ast)=u^\\ast','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2809','Gleichung 3.2809','\\|u_0-u^\\ast\\|<\\delta\\Longrightarrow\\|u(t)-u^\\ast\\|<\\varepsilon\\qquad\\forall t\\geq0','\\|u_0-u^\\ast\\|<\\delta\\Longrightarrow\\|u(t)-u^\\ast\\|<\\varepsilon\\qquad\\forall t\\geq0','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2810','Gleichung 3.2810','\\lim_{t\\rightarrow\\infty}\\|u(t)-u^\\ast\\|=0','\\lim_{t\\rightarrow\\infty}\\|u(t)-u^\\ast\\|=0','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2811','Gleichung 3.2811','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2812','Gleichung 3.2812','\\mathcal{B}_{\\mathrm{F}}(A_{\\mathrm{F}})=\\left\\{u_0\\in S\\mid\\operatorname{dist}(u(t;u_0),A_{\\mathrm{F}})\\rightarrow0\\right\\}','\\mathcal{B}_{\\mathrm{F}}(A_{\\mathrm{F}})=\\left\\{u_0\\in S\\mid\\operatorname{dist}(u(t;u_0),A_{\\mathrm{F}})\\rightarrow0\\right\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2813','Gleichung 3.2813','D_{\\mathrm{F}}(t)=\\|u(t)-u_{\\mathrm{ref}}\\|','D_{\\mathrm{F}}(t)=\\|u(t)-u_{\\mathrm{ref}}\\|','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2814','Gleichung 3.2814','D_{\\mathrm{F,rel}}(t)=\\frac{\\|u(t)-u_{\\mathrm{ref}}\\|}{\\|u_{\\mathrm{ref}}\\|}','D_{\\mathrm{F,rel}}(t)=\\frac{\\|u(t)-u_{\\mathrm{ref}}\\|}{\\|u_{\\mathrm{ref}}\\|}','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2815','Gleichung 3.2815','r_{\\mathrm{F}}(t)=-\\frac{\\mathrm{d}}{\\mathrm{d}t}\\ln\\|u(t)-u^\\ast\\|','r_{\\mathrm{F}}(t)=-\\frac{\\mathrm{d}}{\\mathrm{d}t}\\ln\\|u(t)-u^\\ast\\|','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2816','Gleichung 3.2816','\\eta(t)\\in S','\\eta(t)\\in S','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2817','Gleichung 3.2817','\\dot{u}=F_{\\mathrm{FRZK}}(u)+\\eta(t)','\\dot{u}=F_{\\mathrm{FRZK}}(u)+\\eta(t)','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2818','Gleichung 3.2818','\\sup_{t\\geq0}\\|u_\\eta(t)-u_0(t)\\|\\leq C\\|\\eta\\|_{\\mathcal{H}}','\\sup_{t\\geq0}\\|u_\\eta(t)-u_0(t)\\|\\leq C\\|\\eta\\|_{\\mathcal{H}}','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2819','Gleichung 3.2819','\\eta(t)=0\\qquad\\forall t\\geq t_1','\\eta(t)=0\\qquad\\forall t\\geq t_1','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2820','Gleichung 3.2820','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','\\operatorname{dist}(u(t),A_{\\mathrm{F}})\\rightarrow0\\qquad\\text{für }t\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL),
('3.2821','Gleichung 3.2821','\\mathcal{S}_{\\mathrm{stab}}(u^\\ast)=\\left\\{u_0\\in S\\mid u(t;u_0)\\text{ erfüllt die Stabilitätsbedingung}\\right\\}','\\mathcal{S}_{\\mathrm{stab}}(u^\\ast)=\\left\\{u_0\\in S\\mid u(t;u_0)\\text{ erfüllt die Stabilitätsbedingung}\\right\\}','Formale Gleichung aus Abschnitt 3.2.31.','other','original',NULL);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
t.equation_number,@section,t.title,t.equation_latex,t.word_latex,t.plain_description,
t.equation_type,t.provenance,t.source_id,
'Im Text von Abschnitt 3.2.31 eingeführt, verwendet oder hergeleitet.',
'Voraussetzungen gemäß Abschnitt 3.2.31.','verified',@revision
FROM tmp_eqs_3231 t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=t.equation_number COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT
@revision,@section,'created','section','3.2.31',
'Abschnitt 3.2.31 vollständig angelegt.',
'42 Definitionen, 3 Sätze, 62 Gleichungen und 2 neue Literaturquellen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section AND object_reference='3.2.31'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.31'),
('current_section','3.2.32'),
('last_definition_number','3.2.500'),
('next_definition_number','3.2.501'),
('last_theorem_number','3.2.103'),
('next_theorem_number','3.2.104'),
('last_equation_number','3.2821'),
('next_equation_number','3.2822'),
('last_citation_number','104'),
('next_citation_number','105')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3231;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3231;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3231;

COMMIT;

-- Abschlussprüfung
SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code='3.2.31';

SELECT COUNT(*) AS definitionen_3_2_31
FROM definitions WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_31
FROM theorems WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_31
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 2760 AND 2821;

SELECT
s.citation_number,s.source_id,s.short_citation_text,s.verification_status,
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
