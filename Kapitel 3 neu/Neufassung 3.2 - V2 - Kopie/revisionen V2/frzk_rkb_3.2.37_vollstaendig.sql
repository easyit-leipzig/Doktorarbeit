-- FRZK Repository – Abschnitt 3.2.37
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.37-V1',NOW(),'section','3.2.37','3.2.37-v1',
'Direkte Lyapunov-Methode, globale Stabilität, LaSalle-Invarianz und funktionale Lyapunov-Theorie des FRZK.',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.37-V1');

SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.37-V1' LIMIT 1);
SET @parent_section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.37','Lyapunov-Funktionen und globale Stabilitätsanalyse',3,3237,'final',1,
'Direkte Lyapunov-Methode, LaSalle-Invarianz und funktionale FRZK-Übertragung.'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.37');

SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.37' LIMIT 1);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Khalil','Hassan K.','Khalil, Hassan K.','Autor der Quelle [111].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Khalil, Hassan K.');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 111,'khalil_nonlinear_systems_2002','book','Nonlinear Systems',2002,2002,'Prentice Hall','Upper Saddle River','3','en',1,'textbook',10,'pending','3.2.37',
'Erstnennung für Lyapunov-Stabilität, globale Stabilität und LaSalle-Invarianz.',
'Khalil, Hassan K.: Nonlinear Systems. 3. Auflage. Upper Saddle River: Prentice Hall, 2002.',
'Khalil, Nonlinear Systems [111]',
'Bibliografischer Arbeitsstand; vor der Endredaktion prüfen.',@revision
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=111 OR source_key='khalil_nonlinear_systems_2002');

SET @src111 := (SELECT source_id FROM sources WHERE citation_number=111 LIMIT 1);
SET @author111 := (SELECT author_id FROM authors WHERE normalized_name='Khalil, Hassan K.' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src111,@author111,1,'author'
WHERE @src111 IS NOT NULL AND @author111 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src111 AND author_id=@author111);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src111,@section,'first_citation',
'Direkte Lyapunov-Methode, positive Definitheit, radiale Unbeschränktheit, globale asymptotische Stabilität und LaSalle-Invarianz.',
'3.2.37',1,0,'Quelle [111] vor Endredaktion bibliografisch prüfen.',@revision
WHERE @src111 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@src111 AND section_id=@section AND exact_location='3.2.37');

CREATE TEMPORARY TABLE tmp_defs_3237(
definition_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500),definition_text LONGTEXT,formal_latex LONGTEXT,word_latex LONGTEXT,
provenance ENUM('original','adapted','literature'),source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_defs_3237 VALUES
('3.2.570','Positive Definitheit','Eine Funktion V:X→R heißt positiv definit, wenn V(0)=0 und V(x)>0 für x≠0 gelten.','V:X\\rightarrow\\mathbb{R},\\qquad V(0)=0,\\qquad V(x)>0\\ (x\\neq0)','V:X\\rightarrow\\mathbb{R},\\qquad V(0)=0,\\qquad V(x)>0\\ (x\\neq0)','literature',@src111),
('3.2.571','Radiale Unbeschränktheit','Eine Lyapunov-Funktion heißt radial unbeschränkt, wenn aus ||x||→∞ auch V(x)→∞ folgt.','\\|x\\|\\rightarrow\\infty\\Longrightarrow V(x)\\rightarrow\\infty','\\|x\\|\\rightarrow\\infty\\Longrightarrow V(x)\\rightarrow\\infty','literature',@src111),
('3.2.572','Zeitableitung einer Lyapunov-Funktion','Entlang einer Trajektorie eines autonomen Systems gilt die Ableitung der Lyapunov-Funktion als Gradientenprodukt mit dem Vektorfeld.','\\dot V(x)=\\nabla V(x)^\\top f(x)','\\dot V(x)=\\nabla V(x)^\\top f(x)','literature',@src111),
('3.2.573','Negativ semidefinite Ableitung','Eine Lyapunov-Funktion besitzt eine negativ semidefinite Ableitung, wenn ihre zeitliche Ableitung für alle betrachteten Zustände kleiner oder gleich null ist.','\\dot V(x)\\leq0','\\dot V(x)\\leq0','literature',@src111),
('3.2.574','Negativ definite Ableitung','Eine Lyapunov-Funktion besitzt eine negativ definite Ableitung, wenn ihre zeitliche Ableitung für alle von null verschiedenen Zustände streng negativ ist.','\\dot V(x)<0\\qquad(x\\neq0)','\\dot V(x)<0\\qquad(x\\neq0)','literature',@src111),
('3.2.575','Invariante Menge','Eine Menge M⊆X heißt invariant, wenn jede Trajektorie, die in M startet, vollständig in M verbleibt.','M\\subseteq X','M\\subseteq X','literature',@src111),
('3.2.576','Funktionale Lyapunov-Funktion','Eine funktionale Lyapunov-Funktion V_F(z) ordnet jedem funktionalen Zustand einen skalaren Kohärenzwert zu.','V_F(z)','V_F(z)','original',NULL),
('3.2.577','Funktionale Stabilität','Ein funktionaler Zustand heißt stabil, wenn die zeitliche Änderung seiner funktionalen Lyapunov-Funktion nicht positiv ist.','\\dot V_F\\leq0','\\dot V_F\\leq0','original',NULL),
('3.2.578','Funktionale Attraktormenge','Die Menge aller funktionalen Zustände, für welche die zeitliche Änderung der funktionalen Lyapunov-Funktion verschwindet, heißt funktionale Attraktormenge.','A_F=\\{z\\mid\\dot V_F=0\\}','A_F=\\{z\\mid\\dot V_F=0\\}','original',NULL),
('3.2.579','Funktionale globale Stabilität','Ein funktionales System heißt global stabil, wenn seine funktionale Lyapunov-Funktion radial unbeschränkt ist und entlang aller von null verschiedenen funktionalen Zustände streng abnimmt.','V_F\\rightarrow\\infty\\Longrightarrow\\|z\\|\\rightarrow\\infty,\\qquad\\dot V_F<0','V_F\\rightarrow\\infty\\Longrightarrow\\|z\\|\\rightarrow\\infty,\\qquad\\dot V_F<0','original',NULL);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT definition_number,@section,title,definition_text,formal_latex,word_latex,provenance,source_id,
'Voraussetzungen gemäß Abschnitt 3.2.37.',
IF(provenance='original','FRZK-spezifische Eigenkonstruktion.','Begriff aus der klassischen Lyapunov- und Invarianztheorie.'),
'verified',@revision
FROM tmp_defs_3237 t
WHERE NOT EXISTS (SELECT 1 FROM definitions d WHERE d.definition_number=t.definition_number);

CREATE TEMPORARY TABLE tmp_thms_3237(
theorem_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500),statement_text LONGTEXT,statement_latex LONGTEXT,word_latex LONGTEXT,
provenance ENUM('original','adapted','literature'),source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_thms_3237 VALUES
('3.2.120','Lyapunov-Stabilität','Besitzt ein System eine positiv definite Lyapunov-Funktion mit negativ semidefiniter Ableitung, so ist das Gleichgewicht im Sinne von Lyapunov stabil.','V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{stabil}','V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{stabil}','literature',@src111),
('3.2.121','Asymptotische Stabilität','Besitzt ein System eine positiv definite Lyapunov-Funktion mit negativ definiter Ableitung, so ist das betrachtete Gleichgewicht asymptotisch stabil.','\\dot V<0\\Longrightarrow\\text{asymptotisch stabil}','\\dot V<0\\Longrightarrow\\text{asymptotisch stabil}','literature',@src111),
('3.2.122','Globale asymptotische Stabilität','Ist eine positiv definite Lyapunov-Funktion radial unbeschränkt und besitzt sie eine negativ definite Ableitung, so ist das Gleichgewicht global asymptotisch stabil.','V>0,\\quad\\dot V<0,\\quad V\\rightarrow\\infty\\Longrightarrow\\text{globale asymptotische Stabilität}','V>0,\\quad\\dot V<0,\\quad V\\rightarrow\\infty\\Longrightarrow\\text{globale asymptotische Stabilität}','literature',@src111),
('3.2.123','LaSalle-Invarianzprinzip','Besitzt ein System eine Lyapunov-Funktion mit nichtpositiver Ableitung, so konvergieren die Trajektorien gegen die größte invariante Teilmenge von {x|dot V=0}.','\\dot V\\leq0\\Longrightarrow x(t)\\rightarrow M_{\\max}\\subseteq\\{x\\mid\\dot V=0\\}','\\dot V\\leq0\\Longrightarrow x(t)\\rightarrow M_{\\max}\\subseteq\\{x\\mid\\dot V=0\\}','literature',@src111),
('3.2.124','Funktionales Lyapunov-Kriterium','Besitzt ein FRZK-Modell eine positiv definite, radial unbeschränkte und entlang aller funktionalen Trajektorien streng fallende funktionale Lyapunov-Funktion, so ist das Modell strukturell global asymptotisch stabil.','V_F>0,\\quad\\dot V_F<0,\\quad V_F\\rightarrow\\infty\\Longrightarrow\\text{strukturell global asymptotisch stabil}','V_F>0,\\quad\\dot V_F<0,\\quad V_F\\rightarrow\\infty\\Longrightarrow\\text{strukturell global asymptotisch stabil}','original',NULL);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT theorem_number,@section,title,statement_text,statement_latex,word_latex,provenance,source_id,
'Voraussetzungen gemäß Abschnitt 3.2.37.','verified',@revision
FROM tmp_thms_3237 t
WHERE NOT EXISTS (SELECT 1 FROM theorems th WHERE th.theorem_number=t.theorem_number);

CREATE TEMPORARY TABLE tmp_eqs_3237(
equation_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500),equation_latex TEXT,word_latex TEXT,plain_description TEXT,
equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other'),
provenance ENUM('original','adapted','literature'),source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_eqs_3237 VALUES
('3.2960','Grundschema der direkten Lyapunov-Methode','x(t)\\longrightarrow V(x)\\longrightarrow\\dot V(x)','x(t)\\longrightarrow V(x)\\longrightarrow\\dot V(x)','Formale Gleichung aus Abschnitt 3.2.37.','schema','literature',@src111),
('3.2961','Lyapunov-Funktion als reellwertige Abbildung','V:X\\rightarrow\\mathbb{R}','V:X\\rightarrow\\mathbb{R}','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2962','Nullwert im Gleichgewicht','V(0)=0','V(0)=0','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2963','Positive Definitheit außerhalb des Gleichgewichts','V(x)>0\\qquad(x\\neq0)','V(x)>0\\qquad(x\\neq0)','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2964','Radiale Unbeschränktheit','\\|x\\|\\rightarrow\\infty\\Longrightarrow V(x)\\rightarrow\\infty','\\|x\\|\\rightarrow\\infty\\Longrightarrow V(x)\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2965','Zeitableitung entlang der Systemtrajektorie','\\dot V(x)=\\nabla V(x)^\\top f(x)','\\dot V(x)=\\nabla V(x)^\\top f(x)','Formale Gleichung aus Abschnitt 3.2.37.','derived','literature',@src111),
('3.2966','Negativ semidefinite Ableitung','\\dot V(x)\\leq0','\\dot V(x)\\leq0','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2967','Negativ definite Ableitung','\\dot V(x)<0\\qquad(x\\neq0)','\\dot V(x)<0\\qquad(x\\neq0)','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2968','Lyapunov-Stabilitätskriterium','V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{stabil}','V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{stabil}','Formale Gleichung aus Abschnitt 3.2.37.','theorem','literature',@src111),
('3.2969','Kriterium asymptotischer Stabilität','\\dot V<0','\\dot V<0','Formale Gleichung aus Abschnitt 3.2.37.','theorem','literature',@src111),
('3.2970','Kriterium globaler asymptotischer Stabilität','V>0,\\quad\\dot V<0,\\quad V\\rightarrow\\infty\\Longrightarrow\\text{globale asymptotische Stabilität}','V>0,\\quad\\dot V<0,\\quad V\\rightarrow\\infty\\Longrightarrow\\text{globale asymptotische Stabilität}','Formale Gleichung aus Abschnitt 3.2.37.','theorem','literature',@src111),
('3.2971','Invariante Menge','M\\subseteq X','M\\subseteq X','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2972','Nichtpositive Ableitung im LaSalle-Prinzip','\\dot V\\leq0','\\dot V\\leq0','Formale Gleichung aus Abschnitt 3.2.37.','theorem','literature',@src111),
('3.2973','Nullableitungsmenge','\\{x\\mid\\dot V=0\\}','\\{x\\mid\\dot V=0\\}','Formale Gleichung aus Abschnitt 3.2.37.','definition','literature',@src111),
('3.2974','Funktionale Lyapunov-Funktion','V_F(z)','V_F(z)','Formale Gleichung aus Abschnitt 3.2.37.','definition','original',NULL),
('3.2975','Funktionale Stabilitätsbedingung','\\dot V_F\\leq0','\\dot V_F\\leq0','Formale Gleichung aus Abschnitt 3.2.37.','definition','original',NULL),
('3.2976','Funktionale Attraktormenge','A_F=\\{z\\mid\\dot V_F=0\\}','A_F=\\{z\\mid\\dot V_F=0\\}','Formale Gleichung aus Abschnitt 3.2.37.','definition','original',NULL),
('3.2977','Radiale Unbeschränktheit der funktionalen Lyapunov-Funktion','V_F\\rightarrow\\infty\\Longrightarrow\\|z\\|\\rightarrow\\infty','V_F\\rightarrow\\infty\\Longrightarrow\\|z\\|\\rightarrow\\infty','Formale Gleichung aus Abschnitt 3.2.37.','definition','original',NULL),
('3.2978','Strenges funktionales Abklingen','\\dot V_F<0','\\dot V_F<0','Formale Gleichung aus Abschnitt 3.2.37.','definition','original',NULL);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT equation_number,@section,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,
'Im Text von Abschnitt 3.2.37 eingeführt oder hergeleitet.','Voraussetzungen gemäß Abschnitt 3.2.37.','verified',@revision
FROM tmp_eqs_3237 t
WHERE NOT EXISTS (SELECT 1 FROM equations e WHERE e.equation_number=t.equation_number);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT @revision,@section,'created','section','3.2.37','Abschnitt 3.2.37 vollständig angelegt.',
'10 Definitionen, 5 Sätze, 19 Gleichungen und Quelle [111].'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section AND object_reference='3.2.37');

INSERT INTO repository_counters(counter_key,counter_value) VALUES
('last_completed_section','3.2.37'),('current_section','3.2.38'),
('last_definition_number','3.2.579'),('next_definition_number','3.2.580'),
('last_theorem_number','3.2.124'),('next_theorem_number','3.2.125'),
('last_equation_number','3.2978'),('next_equation_number','3.2979'),
('last_citation_number','111'),('next_citation_number','112')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3237;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3237;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3237;
COMMIT;

SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.2.37';
SELECT COUNT(*) AS definitionen FROM definitions WHERE section_id=@section AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED) BETWEEN 570 AND 579;
SELECT COUNT(*) AS saetze FROM theorems WHERE section_id=@section AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED) BETWEEN 120 AND 124;
SELECT COUNT(*) AS gleichungen FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 2960 AND 2978;
SELECT counter_key,counter_value FROM repository_counters WHERE counter_key IN(
'last_completed_section','current_section','last_definition_number','next_definition_number',
'last_theorem_number','next_theorem_number','last_equation_number','next_equation_number',
'last_citation_number','next_citation_number') ORDER BY counter_key;
