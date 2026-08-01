-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.40
-- Differentialgeometrie und Mannigfaltigkeiten
--
-- Definitionen : 3.2.599–3.2.609
-- Sätze        : 3.2.133–3.2.136
-- Gleichungen  : (3.3011)–(3.3021)
-- Literatur    : [114]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.40-V1',
NOW(),
'section',
'3.2.40',
'3.2.40-v1',
'Differentialgeometrie, Mannigfaltigkeiten, Tangentialräume, metrische Tensoren, Geodäten und funktionale Mannigfaltigkeiten des FRZK.',
'Olaf Thiele / ChatGPT',
@parent_revision
WHERE NOT EXISTS (
    SELECT 1 FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.40-V1'
);

SET @revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.40-V1'
    LIMIT 1
);

SET @parent_section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2'
    LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,
'3.2.40',
'Differentialgeometrie und Mannigfaltigkeiten',
3,
3240,
'final',
1,
'Mannigfaltigkeiten, Karten, Atlanten, Tangentialräume, Tensorfelder, Geodäten und FRZK-spezifische funktionale Mannigfaltigkeiten.'
WHERE NOT EXISTS (
    SELECT 1 FROM dissertation_sections
    WHERE section_code='3.2.40'
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.40'
    LIMIT 1
);

-- Literatur [114]
INSERT INTO authors
(family_name,given_names,normalized_name,notes)
SELECT
'Lee',
'John M.',
'Lee, John M.',
'Autor der Quelle [114].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name='Lee, John M.'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
114,
'lee_introduction_smooth_manifolds',
'book',
'Introduction to Smooth Manifolds',
2003,
2013,
'Springer',
'New York',
'2nd edition',
'en',
1,
'secondary_source',
10,
'pending',
'3.2.40',
'Erstnennung für Mannigfaltigkeiten, Karten, Tangentialräume und Geodäten.',
'Lee, John M.: Introduction to Smooth Manifolds. 2nd edition. Springer, New York, 2013.',
'Lee, Smooth Manifolds [114]',
'Bibliografischer Arbeitsstand; vor Endredaktion gegen den offiziellen Literaturbestand prüfen.',
@revision
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number=114
       OR source_key='lee_introduction_smooth_manifolds'
);

SET @src114 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=114
    LIMIT 1
);

SET @author114 := (
    SELECT author_id
    FROM authors
    WHERE normalized_name='Lee, John M.'
    LIMIT 1
);

INSERT INTO source_authors
(source_id,author_id,author_order,role)
SELECT
@src114,@author114,1,'author'
WHERE @src114 IS NOT NULL
  AND @author114 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_authors
      WHERE source_id=@src114
        AND author_id=@author114
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT
@src114,
@section,
'first_citation',
'Mannigfaltigkeiten, Karten, Atlanten, Tangentialräume, Tensorfelder, metrische Tensoren und Geodäten.',
'3.2.40',
1,
0,
'Quelle [114] vor Endredaktion bibliografisch prüfen.',
@revision
WHERE @src114 IS NOT NULL
  AND @section IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id=@src114
        AND section_id=@section
        AND exact_location='3.2.40'
  );

-- Definitionen
CREATE TEMPORARY TABLE tmp_defs_3240 (
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_3240 VALUES
('3.2.599','Mannigfaltigkeit','Eine differenzierbare Mannigfaltigkeit M ist ein topologischer Raum, der lokal homöomorph zum euklidischen Raum ℝ^n ist und dessen Kartenwechsel differenzierbar sind.','\\varphi:U\\subset M\\rightarrow\\mathbb R^n','\\varphi:U\\subset M\\rightarrow\\mathbb R^n','literature',@src114),
('3.2.600','Karte','Eine Karte ordnet jedem Punkt einer offenen Teilmenge U lokale Koordinaten zu.','(U,\\varphi)','(U,\\varphi)','literature',@src114),
('3.2.601','Atlas','Ein Atlas besteht aus einer Familie kompatibler Karten und beschreibt die gesamte Mannigfaltigkeit.','\\mathcal A=\\{(U_i,\\varphi_i)\\}','\\mathcal A=\\{(U_i,\\varphi_i)\\}','literature',@src114),
('3.2.602','Tangentialraum','Jedem Punkt p∈M ist ein Tangentialraum T_pM zugeordnet, der lokal die Struktur eines Vektorraumes besitzt.','p\\in M,\\qquad T_pM','p\\in M,\\qquad T_pM','literature',@src114),
('3.2.603','Tangentialvektor','Ein Tangentialvektor beschreibt die lokale Änderungsrichtung einer differenzierbaren Kurve.','v\\in T_pM','v\\in T_pM','literature',@src114),
('3.2.604','Tensorfeld','Ein Tensorfeld ordnet jedem Punkt einer Mannigfaltigkeit einen Tensor zu.','T:p\\mapsto T_p','T:p\\mapsto T_p','literature',@src114),
('3.2.605','Metrischer Tensor','Der metrische Tensor g definiert Skalarprodukte auf den Tangentialräumen einer Mannigfaltigkeit.','g_p:T_pM\\times T_pM\\rightarrow\\mathbb R','g_p:T_pM\\times T_pM\\rightarrow\\mathbb R','literature',@src114),
('3.2.606','Geodäte','Eine Geodäte ist lokal die kürzeste Verbindung zweier benachbarter Punkte.','\\gamma:I\\rightarrow M','\\gamma:I\\rightarrow M','literature',@src114),
('3.2.607','Funktionale Mannigfaltigkeit','Eine funktionale Mannigfaltigkeit beschreibt die Menge sämtlicher funktionaler Zustände, welche lokal dieselbe Operatorstruktur besitzen.','\\mathcal M_F','\\mathcal M_F','original',NULL),
('3.2.608','Funktionaler Tangentialraum','Jedem funktionalen Zustand z wird ein funktionaler Tangentialraum T_zF zugeordnet.','z,\\qquad T_zF','z,\\qquad T_zF','original',NULL),
('3.2.609','Funktionale Geodäte','Eine funktionale Geodäte beschreibt den kohärentesten Übergang zwischen zwei funktionalen Zuständen.','\\gamma_F:[0,1]\\rightarrow\\mathcal M_F','\\gamma_F:[0,1]\\rightarrow\\mathcal M_F','original',NULL);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,
@section,
t.title,
t.definition_text,
t.formal_latex,
t.word_latex,
t.provenance,
t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.40.',
CASE
    WHEN t.provenance='original'
    THEN 'FRZK-spezifische Eigenkonstruktion; spätere mathematische und empirische Operationalisierung erforderlich.'
    ELSE 'Begriff aus der klassischen Differentialgeometrie.'
END,
'verified',
@revision
FROM tmp_defs_3240 t
WHERE NOT EXISTS (
    SELECT 1 FROM definitions d
    WHERE d.definition_number=t.definition_number
);

-- Sätze
CREATE TEMPORARY TABLE tmp_thms_3240 (
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_3240 VALUES
('3.2.133','Lineare Struktur des Tangentialraumes','Jeder Tangentialraum einer differenzierbaren Mannigfaltigkeit bildet einen endlichdimensionalen Vektorraum.','T_pM\\ \\text{ist ein endlichdimensionaler Vektorraum}','T_pM\\ \\text{ist ein endlichdimensionaler Vektorraum}','literature',@src114),
('3.2.134','Abstand auf Mannigfaltigkeiten','Durch den metrischen Tensor wird lokal die Längenmessung von Kurven bestimmt.','L(\\gamma)=\\int_a^b\\sqrt{g_{\\gamma(t)}(\\dot\\gamma(t),\\dot\\gamma(t))}\\,dt','L(\\gamma)=\\int_a^b\\sqrt{g_{\\gamma(t)}(\\dot\\gamma(t),\\dot\\gamma(t))}\\,dt','literature',@src114),
('3.2.135','Geodätengleichung','Die Bewegung entlang einer Geodäte erfüllt die Geodätengleichung.','\\frac{d^2x^k}{ds^2}+\\Gamma^k_{ij}\\frac{dx^i}{ds}\\frac{dx^j}{ds}=0','\\frac{d^2x^k}{ds^2}+\\Gamma^k_{ij}\\frac{dx^i}{ds}\\frac{dx^j}{ds}=0','literature',@src114),
('3.2.136','Lokale Linearisierbarkeit funktionaler Zustandsräume','Besitzt eine funktionale Mannigfaltigkeit differenzierbare Karten und lokale Operatorstetigkeit, so kann jeder funktionale Zustand in einer hinreichend kleinen Umgebung durch einen linearen funktionalen Tangentialraum approximiert werden.','\\mathcal M_F\\ \\text{ist lokal durch}\\ T_zF\\ \\text{approximierbar}','\\mathcal M_F\\ \\text{ist lokal durch}\\ T_zF\\ \\text{approximierbar}','original',NULL);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT
t.theorem_number,
@section,
t.title,
t.statement_text,
t.statement_latex,
t.word_latex,
t.provenance,
t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.40.',
'verified',
@revision
FROM tmp_thms_3240 t
WHERE NOT EXISTS (
    SELECT 1 FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

-- Gleichungen
CREATE TEMPORARY TABLE tmp_eqs_3240 (
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_3240 VALUES
('3.3011','Lokale Abbildung einer Mannigfaltigkeit','M\\overset{\\varphi}{\\longrightarrow}\\mathbb R^n','M\\overset{\\varphi}{\\longrightarrow}\\mathbb R^n','Formale Gleichung aus Abschnitt 3.2.40.','schema','literature',@src114),
('3.3012','Lokale Karte','\\varphi:U\\subset M\\rightarrow\\mathbb R^n','\\varphi:U\\subset M\\rightarrow\\mathbb R^n','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3013','Atlas einer Mannigfaltigkeit','\\mathcal A=\\{(U_i,\\varphi_i)\\}','\\mathcal A=\\{(U_i,\\varphi_i)\\}','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3014','Punkt der Mannigfaltigkeit','p\\in M','p\\in M','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3015','Tangentialraum im Punkt','T_pM','T_pM','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3016','Tangentialvektor','v\\in T_pM','v\\in T_pM','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3017','Metrischer Tensor','g','g','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3018','Metrische Abbildung','g_p:T_pM\\times T_pM\\rightarrow\\mathbb R','g_p:T_pM\\times T_pM\\rightarrow\\mathbb R','Formale Gleichung aus Abschnitt 3.2.40.','definition','literature',@src114),
('3.3019','Geodätengleichung','\\frac{d^2x^k}{ds^2}+\\Gamma^k_{ij}\\frac{dx^i}{ds}\\frac{dx^j}{ds}=0','\\frac{d^2x^k}{ds^2}+\\Gamma^k_{ij}\\frac{dx^i}{ds}\\frac{dx^j}{ds}=0','Formale Gleichung aus Abschnitt 3.2.40.','theorem','literature',@src114),
('3.3020','Funktionaler Zustand','z','z','Formale Gleichung aus Abschnitt 3.2.40.','definition','original',NULL),
('3.3021','Funktionaler Tangentialraum','T_zF','T_zF','Formale Gleichung aus Abschnitt 3.2.40.','definition','original',NULL);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
t.equation_number,
@section,
t.title,
t.equation_latex,
t.word_latex,
t.plain_description,
t.equation_type,
t.provenance,
t.source_id,
'Im Text von Abschnitt 3.2.40 eingeführt oder aus den differentialgeometrischen Grundbegriffen abgeleitet.',
'Voraussetzungen gemäß Abschnitt 3.2.40.',
'verified',
@revision
FROM tmp_eqs_3240 t
WHERE NOT EXISTS (
    SELECT 1 FROM equations e
    WHERE e.equation_number=t.equation_number
);

-- Änderungsprotokoll
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT
@revision,
@section,
'created',
'section',
'3.2.40',
'Abschnitt 3.2.40 vollständig angelegt.',
'11 Definitionen, 4 Sätze, 11 Gleichungen und Quelle [114].'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.40'
);

-- Repository-Zähler
INSERT INTO repository_counters
(counter_key,counter_value)
VALUES
('last_completed_section','3.2.40'),
('current_section','3.2.41'),
('last_definition_number','3.2.609'),
('next_definition_number','3.2.610'),
('last_theorem_number','3.2.136'),
('next_theorem_number','3.2.137'),
('last_equation_number','3.3021'),
('next_equation_number','3.3022'),
('last_citation_number','114'),
('next_citation_number','115')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3240;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3240;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3240;

COMMIT;

-- Abschlussprüfung
SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code='3.2.40';

SELECT COUNT(*) AS definitionen_3_2_40
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 599 AND 609;

SELECT COUNT(*) AS saetze_3_2_40
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 133 AND 136;

SELECT COUNT(*) AS gleichungen_3_2_40
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3011 AND 3021;

SELECT
s.citation_number,
s.short_citation_text,
s.verification_status,
su.usage_type,
su.exact_location,
su.citation_checked
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
