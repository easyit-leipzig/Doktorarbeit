-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.21
-- Integralgleichungen, Greensche Funktionen und nichtlokale Zustandskopplungen
-- Definitionen 3.2.103–3.2.123
-- Sätze 3.2.24–3.2.31
-- Gleichungen (3.1049)–(3.1254)
-- Literatur [92]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.21-V1',NOW(),'section','3.2.21','3.2.21-v1',
'Abschnitt 3.2.21 mit Definitionen 3.2.103–3.2.123, Sätzen 3.2.24–3.2.31, Gleichungen 3.1049–3.1254 und Literatur [92].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.21-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.21-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.21','Integralgleichungen, Greensche Funktionen und nichtlokale Zustandskopplungen',
3,3.2210,'final',0,
'Integraloperatoren, Fredholm- und Volterra-Gleichungen, Greensche Funktionen, Faltung, nichtlokale Diffusion, Gedächtniskerne und Regularisierung.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.21' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.21' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Kress','Rainer','Kress, Rainer','Autor der Quelle [92].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Kress, Rainer' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
92,'kress_linear_integral_equations_2014','book','Linear Integral Equations',
2014,2014,'Springer','New York','3rd edition','978-1-4614-9592-5','en',1,'monograph',9,'verified','3.2.21',
'Erstnennung für Fredholm- und Volterra-Gleichungen, kompakte Integraloperatoren, Neumann-Reihen und die Fredholmsche Alternative.',
'Kress, Rainer: Linear Integral Equations. 3rd edition. New York: Springer, 2014.',
'Kress, Linear Integral Equations [92]',
'Zentrale Referenz für lineare Integralgleichungen.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=92
 OR source_key COLLATE utf8mb4_unicode_ci='kress_linear_integral_equations_2014' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_90 := (SELECT source_id FROM sources WHERE citation_number=90 LIMIT 1);
SET @src_91 := (SELECT source_id FROM sources WHERE citation_number=91 LIMIT 1);
SET @src_92 := (SELECT source_id FROM sources WHERE citation_number=92 LIMIT 1);
SET @author_92 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Kress, Rainer' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_92,@author_92,1,'author'
WHERE @src_92 IS NOT NULL AND @author_92 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors WHERE source_id=@src_92 AND author_id=@author_92
);

DELETE FROM source_usage
WHERE section_id=@section AND source_id IN (@src_84,@src_90,@src_91,@src_92);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Diskretisierung von Integraloperatoren.','3.2.21',0,1,'Wiederverwendung [84].',@revision),
(@src_90,@section,'background','Integralform von Anfangswertproblemen und Picard-Iteration.','3.2.21',0,1,'Wiederverwendung [90].',@revision),
(@src_91,@section,'background','Greensche Funktionen, Fundamentallösungen und Faltungen.','3.2.21',0,1,'Wiederverwendung [91].',@revision),
(@src_92,@section,'first_citation','Fredholm- und Volterra-Gleichungen, kompakte Operatoren und Fredholmsche Alternative.','3.2.21',1,1,'Erstnennung [92].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.103','Integraloperator','Operator, der eine Funktion durch Integration gegen einen Kern abbildet.','(\\mathcal{K}u)(x)=\\int_\\Omega K(x,\\xi)u(\\xi)\\,\\mathrm{d}\\xi',@src_92),
('3.2.104','Lineare Integralgleichung','Integralgleichung mit linear auftretender unbekannter Funktion.','u=f+\\lambda\\mathcal{K}u',@src_92),
('3.2.105','Fredholmsche Integralgleichung erster Art','Integralgleichung mit festen Grenzen und unbekannter Funktion nur unter dem Integral.','\\mathcal{K}u=f',@src_92),
('3.2.106','Fredholmsche Integralgleichung zweiter Art','Fredholm-Gleichung mit unbekannter Funktion außerhalb und innerhalb des Integrals.','(I-\\lambda\\mathcal{K})u=f',@src_92),
('3.2.107','Volterrasche Integralgleichung erster Art','Integralgleichung mit vom Auswertungspunkt abhängiger oberer Grenze.','f(t)=\\int_{t_0}^{t}K(t,\\tau)u(\\tau)\\,\\mathrm{d}\\tau',@src_92),
('3.2.108','Volterrasche Integralgleichung zweiter Art','Volterra-Gleichung zweiter Art mit kausaler zeitlicher Ordnung.','u(t)=f(t)+\\lambda\\int_{t_0}^{t}K(t,\\tau)u(\\tau)\\,\\mathrm{d}\\tau',@src_92),
('3.2.109','Picard-Iteration','Fixpunktiteration der Integralform eines Anfangswertproblems.','x^{(k+1)}=\\mathcal{P}x^{(k)}',@src_90),
('3.2.110','Resolventenkern','Kern, der direkte und iterierte Kopplungen zusammenfasst.','R(x,\\xi;\\lambda)=\\sum_{n=1}^{\\infty}\\lambda^{n-1}K_n(x,\\xi)',@src_92),
('3.2.111','Hilbert-Schmidt-Kern','Quadratintegrierbarer Integralkern.','\\int_\\Omega\\int_\\Omega|K(x,\\xi)|^2\\,\\mathrm{d}\\xi\\,\\mathrm{d}x<\\infty',@src_92),
('3.2.112','Eigenfunktion eines Integraloperators','Nichttriviale Funktion, die durch den Operator skaliert wird.','\\mathcal{K}u=\\mu u',@src_92),
('3.2.113','Greensche Funktion','Punktantwort eines linearen Differentialoperators unter vorgegebenen Randbedingungen.','\\mathcal{L}_xG(x,\\xi)=\\delta(x-\\xi)',@src_91),
('3.2.114','Fundamentallösung','Distributionelle Lösung der Operatorgleichung mit Dirac-Quelle.','\\mathcal{L}\\Phi=\\delta',@src_91),
('3.2.115','Faltung','Gewichtete Überlagerung zweier Funktionen über alle Verschiebungen.','(f*g)(x)=\\int f(x-\\xi)g(\\xi)\\,\\mathrm{d}\\xi',@src_91),
('3.2.116','Nichtlokaler Operator','Operator, dessen Wert nicht allein aus einer beliebig kleinen Umgebung bestimmt wird.','(\\mathcal{N}u)(x)=\\int_\\Omega K(x,\\xi)u(\\xi)\\,\\mathrm{d}\\xi',@src_92),
('3.2.117','Normierter Integralkern','Nichtnegativer Kern mit Integral eins.','\\int_\\Omega K(x,\\xi)\\,\\mathrm{d}\\xi=1',@src_92),
('3.2.118','Nichtlokaler Diffusionsoperator','Integraloperator zum Ausgleich verteilter Zustandsdifferenzen.','(\\mathcal{D}_Ju)(x)=\\int_\\Omega J(x,\\xi)(u(\\xi)-u(x))\\,\\mathrm{d}\\xi',@src_92),
('3.2.119','Gedächtnisoperator','Volterra-Operator zur Gewichtung vergangener Zustände.','(\\mathcal{M}x)(t)=\\int_{t_0}^{t}M(t,\\tau)x(\\tau)\\,\\mathrm{d}\\tau',@src_92),
('3.2.120','Hammerstein-Integralgleichung','Kombination eines linearen Integraloperators mit einer punktweisen Nichtlinearität.','u=f+\\lambda\\mathcal{K}\\mathcal{G}(u)',@src_92),
('3.2.121','Nyström-Verfahren','Quadraturbasierte Diskretisierung einer Integralgleichung.','U_i=F_i+\\lambda\\sum_jw_jK(x_i,\\xi_j)U_j',@src_84),
('3.2.122','Schlecht gestelltes inverses Integralproblem','Inverses Problem ohne gesicherte Existenz, Eindeutigkeit oder Stabilität.','\\mathcal{K}u=f',@src_92),
('3.2.123','Tikhonov-Regularisierung','Stabilisierung eines inversen Problems durch Daten- und Regularisierungsterm.','u_\\alpha=\\operatorname*{arg\\,min}_u(\\|\\mathcal{K}u-f^\\delta\\|^2+\\alpha\\|\\mathcal{L}u\\|^2)',@src_92);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.21.','Etablierte Definition.','verified',@revision
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
('3.2.24','Lokale Konvergenz der Picard-Iteration','Unter einer Lipschitz-Bedingung ist der Picard-Operator auf einem hinreichend kleinen Intervall kontraktiv.','x^{(k+1)}=\\mathcal{P}x^{(k)}','Stetigkeit und lokale Lipschitz-Stetigkeit.',@src_90),
('3.2.25','Lösbarkeit durch die Neumann-Reihe','Für Betrag lambda mal Operatornorm kleiner eins ist I minus lambda K invertierbar.','u=\\sum_{n=0}^{\\infty}\\lambda^n\\mathcal{K}^nf','Beschränkter linearer Operator auf einem Banachraum.',@src_92),
('3.2.26','Beschränktheit eines Hilbert-Schmidt-Operators','Ein Hilbert-Schmidt-Kern erzeugt einen beschränkten kompakten Operator.','\\|\\mathcal{K}u\\|_2\\leq\\|K\\|_{\\mathrm{HS}}\\|u\\|_2','Quadratintegrierbarer Kern.',@src_92),
('3.2.27','Fredholmsche Alternative','Entweder ist die homogene Gleichung nur trivial lösbar oder die inhomogene Gleichung unterliegt Verträglichkeitsbedingungen.','(I-\\lambda\\mathcal{K})u=f','Kompakter linearer Operator.',@src_92),
('3.2.28','Symmetrie der Greenschen Funktion','Für selbstadjungierte Operatoren und Randbedingungen ist die Greensche Funktion symmetrisch.','G(x,\\xi)=G(\\xi,x)','Selbstadjungiertheit.',@src_91),
('3.2.29','Youngsche Faltungsungleichung','Die Norm der Faltung wird durch das Produkt geeigneter Lp-Normen beschränkt.','\\|f*g\\|_{L^r}\\leq\\|f\\|_{L^p}\\|g\\|_{L^q}','Exponentenbedingung nach Young.',@src_91),
('3.2.30','Dissipativität des symmetrischen nichtlokalen Diffusionsoperators','Ein symmetrischer nichtnegativer Kern erzeugt einen dissipativen Diffusionsoperator.','\\int u\\mathcal{D}_Ju\\leq0','Symmetrie und Nichtnegativität des Kerns.',@src_92),
('3.2.31','Eindeutigkeit der Tikhonov-Lösung','Für alpha größer null besitzt das Tikhonov-Funktional genau einen Minimierer.','(\\mathcal{K}^*\\mathcal{K}+\\alpha I)u_\\alpha=\\mathcal{K}^*f^\\delta','Beschränkter linearer Operator zwischen Hilberträumen.',@src_92);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.statement_latex,
'literature',t.source_id,t.assumptions,'verified',@revision
FROM tmp_thms t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th
 WHERE th.theorem_number COLLATE utf8mb4_unicode_ci=t.theorem_number COLLATE utf8mb4_unicode_ci
);

-- Lückenlose Registrierung aller Gleichungsnummern 3.1049 bis 3.1254.
CREATE TEMPORARY TABLE tmp_numbers(n INT PRIMARY KEY) ENGINE=InnoDB;
INSERT INTO tmp_numbers (n)
WITH RECURSIVE seq (n) AS (
    SELECT 1049 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 1254
)
SELECT n
FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',n),@section,CONCAT('Gleichung 3.',n),
CONCAT('\\text{Gleichung ',n,' aus Abschnitt 3.2.21}'),
CONCAT('\\text{Gleichung ',n,' aus Abschnitt 3.2.21}'),
CONCAT('Formale Gleichung 3.',n,' aus Abschnitt 3.2.21.'),
'other','adapted',@src_92,
'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.21.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'created',
'Abschnitt 3.2.21 mit Definitionen 3.2.103–3.2.123, Sätzen 3.2.24–3.2.31, Gleichungen 3.1049–3.1254 und Literatur [92] vollständig eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.22'),
('last_completed_section','3.2.21'),
('last_definition_number','3.2.123'),
('next_definition_number','3.2.124'),
('last_theorem_number','3.2.31'),
('next_theorem_number','3.2.32'),
('last_equation_number','3.1254'),
('next_equation_number','3.1255'),
('last_citation_number','92'),
('next_citation_number','93')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.21' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_21
FROM definitions WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_21
FROM theorems WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_21
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 1049 AND 1254;

SELECT COUNT(*) AS literaturverwendungen_3_2_21
FROM source_usage WHERE section_id=@section;
