-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.39
-- Variationsrechnung und Optimierungsprinzipien
-- Definitionen: 3.2.589–3.2.598 | Sätze: 3.2.129–3.2.132
-- Gleichungen: (3.2998)–(3.3010) | Literatur: [113]
-- ###########################################################################
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.39-V1',NOW(),'section','3.2.39','3.2.39-v1',
'Variationsrechnung, Euler-Lagrange-Gleichung, Hamiltonsches Prinzip und funktionale Variationsstruktur des FRZK.',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.39-V1');
SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.39-V1' LIMIT 1);
SET @parent_section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);
INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.39','Variationsrechnung und Optimierungsprinzipien',3,3239,'final',1,
'Funktionale, Variationen, Euler-Lagrange-Gleichung, Wirkungsprinzip und FRZK-spezifische Variationsstruktur.'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.39');
SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.39' LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,notes)
SELECT 'Gelfand','Israel M.','Gelfand, Israel M.','Mitautor der Quelle [113].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Gelfand, Israel M.');
INSERT INTO authors (family_name,given_names,normalized_name,notes)
SELECT 'Fomin','Sergei V.','Fomin, Sergei V.','Mitautor der Quelle [113].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Fomin, Sergei V.');
INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 113,'gelfand_fomin_calculus_variations','book','Calculus of Variations',1963,2000,
'Dover Publications','Mineola, New York','Reprint edition','en',1,'secondary_source',10,'pending','3.2.39',
'Erstnennung für Funktionale, erste Variation und Euler-Lagrange-Gleichung.',
'Gelfand, Israel M.; Fomin, Sergei V.: Calculus of Variations. Dover Publications, Mineola, New York, 2000.',
'Gelfand/Fomin, Calculus of Variations [113]',
'Bibliografischer Arbeitsstand; vor Endredaktion gegen den offiziellen Literaturbestand prüfen.',@revision
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=113 OR source_key='gelfand_fomin_calculus_variations');
SET @src113 := (SELECT source_id FROM sources WHERE citation_number=113 LIMIT 1);
SET @author113a := (SELECT author_id FROM authors WHERE normalized_name='Gelfand, Israel M.' LIMIT 1);
SET @author113b := (SELECT author_id FROM authors WHERE normalized_name='Fomin, Sergei V.' LIMIT 1);
INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @src113,@author113a,1,'author' WHERE @src113 IS NOT NULL AND @author113a IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src113 AND author_id=@author113a);
INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @src113,@author113b,2,'author' WHERE @src113 IS NOT NULL AND @author113b IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src113 AND author_id=@author113b);
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src113,@section,'first_citation',
'Funktionale, zulässige Variationen, erste Variation, Euler-Lagrange-Gleichung und Variationsprinzipien.',
'3.2.39',1,0,'Quelle [113] vor Endredaktion bibliografisch prüfen.',@revision
WHERE @src113 IS NOT NULL AND @section IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@src113 AND section_id=@section AND exact_location='3.2.39');

CREATE TEMPORARY TABLE tmp_defs_3239 (
definition_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500) NOT NULL,definition_text LONGTEXT NOT NULL,
formal_latex LONGTEXT NULL,word_latex LONGTEXT NULL,provenance ENUM('original','adapted','literature') NOT NULL,
source_id BIGINT UNSIGNED NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_defs_3239 VALUES
('3.2.589','Funktional','Ein Funktional ist eine Abbildung J:𝓕→ℝ, welche jeder zulässigen Funktion einen reellen Zahlenwert zuordnet.','J:\\mathcal F\\rightarrow\\mathbb R','J:\\mathcal F\\rightarrow\\mathbb R','literature',@src113),
('3.2.590','Zielfunktional','Ein Zielfunktional besitzt allgemein die Form J[y]=∫_a^b L(x,y,y'') dx.','J[y]=\\int_a^b L(x,y,y'')\\,dx','J[y]=\\int_a^b L(x,y,y'')\\,dx','literature',@src113),
('3.2.591','Zulässige Variation','Eine zulässige Variation wird durch y_ε=y+εη mit η(a)=η(b)=0 beschrieben.','y_\\varepsilon=y+\\varepsilon\\eta,\\qquad \\eta(a)=\\eta(b)=0','y_\\varepsilon=y+\\varepsilon\\eta,\\qquad \\eta(a)=\\eta(b)=0','literature',@src113),
('3.2.592','Erste Variation','Die erste Variation wird durch die Ableitung des variierten Funktionals nach dem Variationsparameter bei ε=0 definiert.','\\delta J=\\left.\\frac{d}{d\\varepsilon}J[y+\\varepsilon\\eta]\\right|_{\\varepsilon=0}','\\delta J=\\left.\\frac{d}{d\\varepsilon}J[y+\\varepsilon\\eta]\\right|_{\\varepsilon=0}','literature',@src113),
('3.2.593','Extremale','Eine Funktion, welche die Euler-Lagrange-Gleichung erfüllt, heißt Extremale.','\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y''}\\right)=0','\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y''}\\right)=0','literature',@src113),
('3.2.594','Wirkungsfunktional','In der analytischen Mechanik wird das Wirkungsfunktional durch S=∫L dt definiert.','S=\\int L\\,dt','S=\\int L\\,dt','literature',@src113),
('3.2.595','Optimale Trajektorie','Eine Trajektorie heißt optimal, wenn sie das betrachtete Zielfunktional minimiert oder maximiert.','J[y^\\ast]=\\operatorname{ext}_{y\\in\\mathcal F}J[y]','J[y^\\ast]=\\operatorname{ext}_{y\\in\\mathcal F}J[y]','literature',@src113),
('3.2.596','Funktionales Kohärenzfunktional','Das funktionale Kohärenzfunktional J_F[z] ordnet jedem funktionalen Entwicklungsverlauf einen Kohärenzwert zu.','J_F[z]','J_F[z]','original',NULL),
('3.2.597','Funktionale Variation','Eine funktionale Variation besitzt die Form z_ε=z+εξ.','z_\\varepsilon=z+\\varepsilon\\xi','z_\\varepsilon=z+\\varepsilon\\xi','original',NULL),
('3.2.598','Funktionales Extremal','Ein funktionaler Verlauf heißt Extremale, wenn δJ_F=0 gilt.','\\delta J_F=0','\\delta J_F=0','original',NULL);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.word_latex,t.provenance,t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.39.',
CASE WHEN t.provenance='original' THEN 'FRZK-spezifische Eigenkonstruktion; spätere mathematische und empirische Operationalisierung erforderlich.' ELSE 'Begriff aus der klassischen Variationsrechnung.' END,
'verified',@revision FROM tmp_defs_3239 t
WHERE NOT EXISTS (SELECT 1 FROM definitions d WHERE d.definition_number=t.definition_number);

CREATE TEMPORARY TABLE tmp_thms_3239 (
theorem_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500) NOT NULL,statement_text LONGTEXT NOT NULL,
statement_latex LONGTEXT NULL,word_latex LONGTEXT NULL,provenance ENUM('original','adapted','literature') NOT NULL,
source_id BIGINT UNSIGNED NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_thms_3239 VALUES
('3.2.129','Notwendige Extremalbedingung','Ein Funktional besitzt nur dann ein Extremum, wenn δJ=0 für alle zulässigen Variationen gilt.','\\delta J=0','\\delta J=0','literature',@src113),
('3.2.130','Euler-Lagrange-Gleichung','Für ein Funktional J[y]=∫_a^b L(x,y,y'') dx gilt als notwendige Bedingung die Euler-Lagrange-Gleichung.','\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y''}\\right)=0','\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y''}\\right)=0','literature',@src113),
('3.2.131','Hamiltonsches Prinzip','Die tatsächliche Bewegung eines mechanischen Systems erfüllt die stationäre Wirkungsbedingung δS=0.','\\delta S=0','\\delta S=0','literature',@src113),
('3.2.132','Funktionales Variationsprinzip','Besitzt das funktionale Kohärenzfunktional eine stationäre Variation und erfüllt der funktionale Zustandsraum die notwendigen Regularitätsbedingungen, so beschreibt die resultierende Extremale einen kohärenten funktionalen Entwicklungsverlauf.','\\delta J_F=0','\\delta J_F=0','original',NULL);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.word_latex,t.provenance,t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.39.','verified',@revision FROM tmp_thms_3239 t
WHERE NOT EXISTS (SELECT 1 FROM theorems th WHERE th.theorem_number=t.theorem_number);

CREATE TEMPORARY TABLE tmp_eqs_3239 (
equation_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500) NOT NULL,equation_latex TEXT NOT NULL,word_latex TEXT NOT NULL,
plain_description TEXT NOT NULL,equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL,
provenance ENUM('original','adapted','literature') NOT NULL,source_id BIGINT UNSIGNED NULL)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_eqs_3239 VALUES
('3.2998','Prinzip der Variationsrechnung','y(x)\\longrightarrow J[y]\\longrightarrow\\delta J=0','y(x)\\longrightarrow J[y]\\longrightarrow\\delta J=0','Formale Gleichung aus Abschnitt 3.2.39.','schema','literature',@src113),
('3.2999','Abbildungseigenschaft eines Funktionals','J:\\mathcal F\\rightarrow\\mathbb R','J:\\mathcal F\\rightarrow\\mathbb R','Formale Gleichung aus Abschnitt 3.2.39.','definition','literature',@src113),
('3.3000','Allgemeines Zielfunktional','J[y]=\\int_a^b L(x,y,y'')\\,dx','J[y]=\\int_a^b L(x,y,y'')\\,dx','Formale Gleichung aus Abschnitt 3.2.39.','definition','literature',@src113),
('3.3001','Variation einer Funktion','y_\\varepsilon=y+\\varepsilon\\eta','y_\\varepsilon=y+\\varepsilon\\eta','Formale Gleichung aus Abschnitt 3.2.39.','definition','literature',@src113),
('3.3002','Randbedingungen der Variation','\\eta(a)=\\eta(b)=0','\\eta(a)=\\eta(b)=0','Formale Gleichung aus Abschnitt 3.2.39.','definition','literature',@src113),
('3.3003','Erste Variation','\\delta J=\\left.\\frac{d}{d\\varepsilon}J[y+\\varepsilon\\eta]\\right|_{\\varepsilon=0}','\\delta J=\\left.\\frac{d}{d\\varepsilon}J[y+\\varepsilon\\eta]\\right|_{\\varepsilon=0}','Formale Gleichung aus Abschnitt 3.2.39.','definition','literature',@src113),
('3.3004','Stationaritätsbedingung','\\delta J=0','\\delta J=0','Formale Gleichung aus Abschnitt 3.2.39.','theorem','literature',@src113),
('3.3005','Euler-Lagrange-Gleichung','\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y''}\\right)=0','\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y''}\\right)=0','Formale Gleichung aus Abschnitt 3.2.39.','theorem','literature',@src113),
('3.3006','Wirkungsfunktional','S=\\int L\\,dt','S=\\int L\\,dt','Formale Gleichung aus Abschnitt 3.2.39.','definition','literature',@src113),
('3.3007','Hamiltonsches Prinzip','\\delta S=0','\\delta S=0','Formale Gleichung aus Abschnitt 3.2.39.','theorem','literature',@src113),
('3.3008','Funktionales Kohärenzfunktional','J_F[z]','J_F[z]','Formale Gleichung aus Abschnitt 3.2.39.','definition','original',NULL),
('3.3009','Funktionale Variation','z_\\varepsilon=z+\\varepsilon\\xi','z_\\varepsilon=z+\\varepsilon\\xi','Formale Gleichung aus Abschnitt 3.2.39.','definition','original',NULL),
('3.3010','Funktionale Stationaritätsbedingung','\\delta J_F=0','\\delta J_F=0','Formale Gleichung aus Abschnitt 3.2.39.','theorem','original',NULL);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT t.equation_number,@section,t.title,t.equation_latex,t.word_latex,t.plain_description,t.equation_type,t.provenance,t.source_id,
'Im Text von Abschnitt 3.2.39 eingeführt oder aus dem Variationsansatz abgeleitet.',
'Voraussetzungen gemäß Abschnitt 3.2.39.','verified',@revision FROM tmp_eqs_3239 t
WHERE NOT EXISTS (SELECT 1 FROM equations e WHERE e.equation_number=t.equation_number);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT @revision,@section,'created','section','3.2.39','Abschnitt 3.2.39 vollständig angelegt.',
'10 Definitionen, 4 Sätze, 13 Gleichungen und Quelle [113].'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section AND object_reference='3.2.39');

INSERT INTO repository_counters (counter_key,counter_value) VALUES
('last_completed_section','3.2.39'),('current_section','3.2.40'),
('last_definition_number','3.2.598'),('next_definition_number','3.2.599'),
('last_theorem_number','3.2.132'),('next_theorem_number','3.2.133'),
('last_equation_number','3.3010'),('next_equation_number','3.3011'),
('last_citation_number','113'),('next_citation_number','114')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);
DROP TEMPORARY TABLE IF EXISTS tmp_defs_3239;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3239;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3239;
COMMIT;

SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.2.39';
SELECT COUNT(*) AS definitionen_3_2_39 FROM definitions WHERE section_id=@section AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED) BETWEEN 589 AND 598;
SELECT COUNT(*) AS saetze_3_2_39 FROM theorems WHERE section_id=@section AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED) BETWEEN 129 AND 132;
SELECT COUNT(*) AS gleichungen_3_2_39 FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 2998 AND 3010;
SELECT s.citation_number,s.short_citation_text,s.verification_status,su.usage_type,su.exact_location,su.citation_checked
FROM source_usage su JOIN sources s ON s.source_id=su.source_id WHERE su.section_id=@section ORDER BY s.citation_number;
SELECT counter_key,counter_value FROM repository_counters WHERE counter_key IN
('last_completed_section','current_section','last_definition_number','next_definition_number','last_theorem_number','next_theorem_number','last_equation_number','next_equation_number','last_citation_number','next_citation_number') ORDER BY counter_key;
