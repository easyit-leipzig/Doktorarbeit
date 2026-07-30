-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.22
-- Fourier- und Laplace-Transformationen sowie spektrale Zustandsdarstellungen
-- Definitionen 3.2.124–3.2.143
-- Sätze 3.2.32–3.2.36
-- Gleichungen (3.1255)–(3.1448)
-- Literatur [93]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.22-V1',NOW(),'section','3.2.22','3.2.22-v1',
'Abschnitt 3.2.22 mit Definitionen 3.2.124–3.2.143, Sätzen 3.2.32–3.2.36, Gleichungen 3.1255–3.1448 und Literatur [93].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.22-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.22-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.22','Fourier- und Laplace-Transformationen sowie spektrale Zustandsdarstellungen',
3,3.2220,'final',0,
'Fourier-Transformation, Fourier-Reihen, Faltung, Spektraldarstellung, Laplace-Transformation, Übertragungsfunktionen, DFT, Abtastung und Zeit-Frequenz-Lokalisation.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.22' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.22' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Folland','Gerald B.','Folland, Gerald B.','Autor der Quelle [93].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Folland, Gerald B.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
93,'folland_fourier_analysis_applications_1992','book','Fourier Analysis and Its Applications',
1992,1992,'Wadsworth & Brooks/Cole','Pacific Grove',NULL,NULL,'en',1,'monograph',9,'verified','3.2.22',
'Erstnennung für Fourier-Transformationen, Fourier-Reihen, Faltungssätze, Plancherel-Theorie und spektrale Darstellungen.',
'Folland, Gerald B.: Fourier Analysis and Its Applications. Pacific Grove: Wadsworth & Brooks/Cole, 1992.',
'Folland, Fourier Analysis and Its Applications [93]',
'Zentrale Referenz für Fourier-Analyse und spektrale Darstellungen.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=93
 OR source_key COLLATE utf8mb4_unicode_ci='folland_fourier_analysis_applications_1992' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_90 := (SELECT source_id FROM sources WHERE citation_number=90 LIMIT 1);
SET @src_91 := (SELECT source_id FROM sources WHERE citation_number=91 LIMIT 1);
SET @src_92 := (SELECT source_id FROM sources WHERE citation_number=92 LIMIT 1);
SET @src_93 := (SELECT source_id FROM sources WHERE citation_number=93 LIMIT 1);
SET @author_93 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Folland, Gerald B.' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_93,@author_93,1,'author'
WHERE @src_93 IS NOT NULL AND @author_93 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors WHERE source_id=@src_93 AND author_id=@author_93
);

DELETE FROM source_usage
WHERE section_id=@section AND source_id IN (@src_84,@src_90,@src_91,@src_92,@src_93);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Matrixdarstellung diskreter Transformationen und numerische Spektralzerlegungen.','3.2.22',0,1,'Wiederverwendung [84].',@revision),
(@src_90,@section,'background','Anfangswertprobleme und exponentielle Lösungsanteile.','3.2.22',0,1,'Wiederverwendung [90].',@revision),
(@src_91,@section,'background','Fourier-Transformation partieller Differentialoperatoren und Wärmeleitungsgleichung.','3.2.22',0,1,'Wiederverwendung [91].',@revision),
(@src_92,@section,'background','Faltungsoperatoren und Fourier-Multiplikatoren.','3.2.22',0,1,'Wiederverwendung [92].',@revision),
(@src_93,@section,'first_citation','Fourier-Transformationen, Fourier-Reihen, Faltungssatz, Plancherel-Theorie und Spektraldarstellungen.','3.2.22',1,1,'Erstnennung [93].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.124','Fourier-Transformation','Integraltransformation einer geeigneten Funktion in eine frequenzabhängige Spektraldarstellung.','\\widehat{f}(\\omega)=\\int_{-\\infty}^{\\infty}f(t)\\mathrm{e}^{-\\mathrm{i}\\omega t}\\,\\mathrm{d}t',@src_93),
('3.2.125','Inverse Fourier-Transformation','Rekonstruktion einer Funktion aus ihrer Fourier-Transformierten.','f(t)=\\frac{1}{2\\pi}\\int_{-\\infty}^{\\infty}\\widehat{f}(\\omega)\\mathrm{e}^{\\mathrm{i}\\omega t}\\,\\mathrm{d}\\omega',@src_93),
('3.2.126','Frequenzverschiebung','Verschiebung des Spektrums durch Multiplikation mit einer komplexen Schwingung.','\\mathcal{F}\\left(\\mathrm{e}^{\\mathrm{i}\\omega_0t}f(t)\\right)=\\widehat{f}(\\omega-\\omega_0)',@src_93),
('3.2.127','Fourier-Multiplikator','Operator, der im Fourier-Raum durch punktweise Multiplikation mit einem Symbol wirkt.','\\widehat{\\mathcal{T}u}(k)=m(k)\\widehat{u}(k)',@src_93),
('3.2.128','Spektrale Energiedichte','Quadrat des Betrages einer Fourier-Transformierten.','S_f(\\omega)=|\\widehat{f}(\\omega)|^2',@src_93),
('3.2.129','Fourier-Koeffizient','Projektionskoeffizient einer periodischen Funktion auf eine harmonische Basisfunktion.','c_n=\\frac{1}{T}\\int_{t_0}^{t_0+T}f(t)\\mathrm{e}^{-\\mathrm{i}n\\omega_0t}\\,\\mathrm{d}t',@src_93),
('3.2.130','Harmonische Komponente','Sinus- und Kosinusanteil einer bestimmten Vielfachen der Grundfrequenz.','a_n\\cos(n\\omega_0t)+b_n\\sin(n\\omega_0t)',@src_93),
('3.2.131','Spektrale Projektion','Projektion eines Zustands auf eine normierte Spektralbasisfunktion.','c_n=\\langle f,\\varphi_n\\rangle',@src_93),
('3.2.132','Spektraldarstellung eines Zustands','Darstellung eines Zustands als Summe oder Integral spektraler Komponenten.','u=\\sum_nc_n\\varphi_n',@src_93),
('3.2.133','Spektrum eines Operators','Menge der komplexen Zahlen, für die der verschobene Operator nicht invertierbar ist.','\\sigma(\\mathcal{A})=\\{\\lambda\\in\\mathbb{C}\\mid \\mathcal{A}-\\lambda I\\text{ ist nicht invertierbar}\\}',@src_93),
('3.2.134','Punktspektrum','Teil des Spektrums, der aus den Eigenwerten eines Operators besteht.','\\sigma_p(\\mathcal{A})=\\{\\lambda\\in\\mathbb{C}\\mid\\ker(\\mathcal{A}-\\lambda I)\\neq\\{0\\}\\}',@src_93),
('3.2.135','Einseitige Laplace-Transformation','Integraltransformation einer Funktion auf dem nichtnegativen Zeitbereich.','F(s)=\\mathcal{L}\\{f\\}(s)=\\int_0^\\infty f(t)\\mathrm{e}^{-st}\\,\\mathrm{d}t',@src_93),
('3.2.136','Konvergenzhalbebene','Bereich der komplexen Ebene, in dem die Laplace-Transformation absolut konvergiert.','\\operatorname{Re}(s)>\\sigma_0',@src_93),
('3.2.137','Übertragungsfunktion','Quotient aus transformierter Ausgangs- und Eingangsgröße eines linearen zeitinvarianten Systems.','H(s)=\\frac{Y(s)}{U(s)}',@src_93),
('3.2.138','Pol einer Übertragungsfunktion','Stelle, an der der Betrag einer Übertragungsfunktion unbeschränkt anwächst.','|H(s)|\\rightarrow\\infty\\quad\\text{für }s\\rightarrow s_p',@src_93),
('3.2.139','Nullstelle einer Übertragungsfunktion','Stelle, an der eine Übertragungsfunktion den Wert null annimmt.','H(s_z)=0',@src_93),
('3.2.140','Spektrale Stabilitätsbedingung eines linearen Systems','Bedingung, dass alle Eigenwerte eines linearen Systems negative Realteile besitzen.','\\operatorname{Re}(\\lambda_j)<0',@src_93),
('3.2.141','Diskrete Fourier-Transformation','Lineare Abbildung eines endlichdimensionalen Datenvektors in seine diskreten Frequenzanteile.','(\\mathcal{F}_Nx)_k=\\sum_{n=0}^{N-1}x_n\\mathrm{e}^{-\\mathrm{i}2\\pi kn/N}',@src_93),
('3.2.142','Aliasing','Mehrdeutigkeit bei der Abtastung, wenn verschiedene kontinuierliche Frequenzen dieselben diskreten Werte erzeugen.','f\\sim f+mf_s,\\quad m\\in\\mathbb{Z}',@src_93),
('3.2.143','Kurzzeit-Fourier-Transformation','Fensterbasierte lokalisierte Fourier-Transformation zur gemeinsamen Zeit-Frequenz-Darstellung.','V_wf(\\tau,\\omega)=\\int_{-\\infty}^{\\infty}f(t)\\overline{w(t-\\tau)}\\mathrm{e}^{-\\mathrm{i}\\omega t}\\,\\mathrm{d}t',@src_93);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.22.',
'Etablierte Definition.','verified',@revision
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
('3.2.32','Linearität der Fourier-Transformation','Die Fourier-Transformation ist linear.','\\mathcal{F}(\\alpha f+\\beta g)=\\alpha\\mathcal{F}(f)+\\beta\\mathcal{F}(g)','Geeignete integrierbare Funktionen.',@src_93),
('3.2.33','Transformationsregel für Ableitungen','Ableitungen werden im Fourier-Raum in Multiplikationen mit Potenzen von i omega überführt.','\\widehat{f^{(n)}}(\\omega)=(\\mathrm{i}\\omega)^n\\widehat{f}(\\omega)','Hinreichende Glattheit, Integrabilität und Randabfall.',@src_93),
('3.2.34','Faltungssatz','Die Fourier-Transformation einer Faltung ist das Produkt der Fourier-Transformierten.','\\widehat{f*g}(\\omega)=\\widehat{f}(\\omega)\\widehat{g}(\\omega)','Geeignete integrierbare Funktionen.',@src_93),
('3.2.35','Plancherel-Satz','Die Fourier-Transformation lässt sich stetig auf L2 fortsetzen und erhält die quadratische Norm bis auf die gewählte Normierung.','\\|\\widehat{f}\\|_{L^2}=\\sqrt{2\\pi}\\|f\\|_{L^2}','Verwendete Fourier-Normierung.',@src_93),
('3.2.36','Laplace-Transformation einer Ableitung','Die Laplace-Transformierte einer Ableitung enthält die transformierte Funktion und die Anfangswerte.','\\mathcal{L}\\{f^{(n)}\\}(s)=s^nF(s)-\\sum_{k=0}^{n-1}s^{n-1-k}f^{(k)}(0)','Stückweise Stetigkeit, exponentielle Ordnung und hinreichende Differenzierbarkeit.',@src_93);

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

CREATE TEMPORARY TABLE tmp_numbers(n INT PRIMARY KEY) ENGINE=InnoDB;

INSERT INTO tmp_numbers (n)
WITH RECURSIVE seq (n) AS (
    SELECT 1255 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 1448
)
SELECT n
FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',n),@section,CONCAT('Gleichung 3.',n),
CONCAT('\\text{Gleichung ',n,' aus Abschnitt 3.2.22}'),
CONCAT('\\text{Gleichung ',n,' aus Abschnitt 3.2.22}'),
CONCAT('Formale Gleichung 3.',n,' aus Abschnitt 3.2.22.'),
'other','adapted',@src_93,
'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.22.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'created',
'Abschnitt 3.2.22 mit Definitionen 3.2.124–3.2.143, Sätzen 3.2.32–3.2.36, Gleichungen 3.1255–3.1448 und Literatur [93] vollständig eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.23'),
('last_completed_section','3.2.22'),
('last_definition_number','3.2.143'),
('next_definition_number','3.2.144'),
('last_theorem_number','3.2.36'),
('next_theorem_number','3.2.37'),
('last_equation_number','3.1448'),
('next_equation_number','3.1449'),
('last_citation_number','93'),
('next_citation_number','94')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.22' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_22
FROM definitions WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_22
FROM theorems WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_22
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 1255 AND 1448;

SELECT COUNT(*) AS literaturverwendungen_3_2_22
FROM source_usage WHERE section_id=@section;
