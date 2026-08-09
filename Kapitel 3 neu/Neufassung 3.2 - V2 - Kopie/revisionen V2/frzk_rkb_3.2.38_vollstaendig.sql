-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.38
-- Kontraktive Abbildungen und Fixpunkttheorie
--
-- Definitionen : 3.2.580–3.2.588
-- Sätze        : 3.2.125–3.2.128
-- Gleichungen  : (3.2979)–(3.2997)
-- Literatur    : [112]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.38-V1',
NOW(),
'section',
'3.2.38',
'3.2.38-v1',
'Kontraktive Abbildungen, Banachscher Fixpunktsatz, Fehlerabschätzungen und funktionale Fixpunkttheorie des FRZK.',
'Olaf Thiele / ChatGPT',
@parent_revision
WHERE NOT EXISTS (
    SELECT 1 FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.38-V1'
);

SET @revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.38-V1'
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
'3.2.38',
'Kontraktive Abbildungen und Fixpunkttheorie',
3,
3238,
'final',
1,
'Banachscher Fixpunktsatz, Iterationsfehler und funktionale FRZK-Übertragung.'
WHERE NOT EXISTS (
    SELECT 1 FROM dissertation_sections
    WHERE section_code='3.2.38'
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.38'
    LIMIT 1
);

-- Literatur [112]
INSERT INTO authors
(family_name,given_names,normalized_name,notes)
SELECT
'Banach',
'Stefan',
'Banach, Stefan',
'Autor der Quelle [112].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name='Banach, Stefan'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
112,
'banach_operations_ensembles_abstraits_1922',
'journal',
'Sur les opérations dans les ensembles abstraits et leur application aux équations intégrales',
1922,
1922,
'Fundamenta Mathematicae',
'Warszawa',
NULL,
'fr',
1,
'primary_source',
10,
'pending',
'3.2.38',
'Erstnennung für kontraktive Abbildungen und den Banachschen Fixpunktsatz.',
'Banach, Stefan: Sur les opérations dans les ensembles abstraits et leur application aux équations intégrales. Fundamenta Mathematicae 3 (1922), S. 133–181.',
'Banach, Fixpunktsatz [112]',
'Bibliografischer Arbeitsstand; vor Endredaktion gegen den offiziellen Literaturbestand prüfen.',
@revision
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number=112
       OR source_key='banach_operations_ensembles_abstraits_1922'
);

SET @src112 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=112
    LIMIT 1
);

SET @author112 := (
    SELECT author_id
    FROM authors
    WHERE normalized_name='Banach, Stefan'
    LIMIT 1
);

INSERT INTO source_authors
(source_id,author_id,author_order,role)
SELECT
@src112,@author112,1,'author'
WHERE @src112 IS NOT NULL
  AND @author112 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_authors
      WHERE source_id=@src112
        AND author_id=@author112
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT
@src112,
@section,
'first_citation',
'Fixpunkte, vollständige metrische Räume, Kontraktionen, Banachscher Fixpunktsatz und geometrische Fehlerabschätzungen.',
'3.2.38',
1,
0,
'Quelle [112] vor Endredaktion bibliografisch prüfen.',
@revision
WHERE @src112 IS NOT NULL
  AND @section IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id=@src112
        AND section_id=@section
        AND exact_location='3.2.38'
  );

-- Definitionen
CREATE TEMPORARY TABLE tmp_defs_3238 (
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_3238 VALUES
('3.2.580','Fixpunkt','Ein Punkt x*∈X heißt Fixpunkt einer Abbildung T:X→X, wenn T(x*)=x* gilt.','x^\\ast\\in X,\\qquad T:X\\rightarrow X,\\qquad T(x^\\ast)=x^\\ast','x^\\ast\\in X,\\qquad T:X\\rightarrow X,\\qquad T(x^\\ast)=x^\\ast','literature',@src112),
('3.2.581','Iterationsfolge','Ausgehend von einem Anfangswert x_0 wird die Iterationsfolge rekursiv durch x_{k+1}=T(x_k) definiert.','x_{k+1}=T(x_k)','x_{k+1}=T(x_k)','literature',@src112),
('3.2.582','Vollständiger metrischer Raum','Ein metrischer Raum heißt vollständig, wenn jede Cauchy-Folge gegen ein Element dieses Raumes konvergiert.','(X,d)\\ \\text{vollständig}','(X,d)\\ \\text{vollständig}','literature',@src112),
('3.2.583','Kontraktion','Eine Abbildung heißt kontraktiv, wenn eine Konstante 0≤q<1 existiert, sodass d(Tx,Ty)≤q d(x,y) gilt.','0\\leq q<1,\\qquad d(Tx,Ty)\\leq q\\,d(x,y)','0\\leq q<1,\\qquad d(Tx,Ty)\\leq q\\,d(x,y)','literature',@src112),
('3.2.584','Fixpunktiteration','Die rekursive Vorschrift x_{k+1}=T(x_k) heißt Fixpunktiteration.','x_{k+1}=T(x_k)','x_{k+1}=T(x_k)','literature',@src112),
('3.2.585','Fehlerfolge','Die Fehlerfolge einer Fixpunktiteration wird durch e_k=d(x_k,x*) definiert.','e_k=d(x_k,x^\\ast)','e_k=d(x_k,x^\\ast)','literature',@src112),
('3.2.586','Funktionaler Operator','Ein funktionaler Operator T_F:Z→Z ordnet jedem funktionalen Zustand einen neuen funktionalen Zustand zu.','\\mathcal T_F:Z\\rightarrow Z','\\mathcal T_F:Z\\rightarrow Z','original',NULL),
('3.2.587','Funktionaler Fixpunkt','Ein funktionaler Zustand z* heißt funktionaler Fixpunkt, wenn T_F(z*)=z* gilt.','\\mathcal T_F(z^\\ast)=z^\\ast','\\mathcal T_F(z^\\ast)=z^\\ast','original',NULL),
('3.2.588','Funktionale Kontraktion','Ein funktionaler Operator heißt kontraktiv, wenn d_F(T_F(z_1),T_F(z_2))≤q_F d_F(z_1,z_2) mit 0≤q_F<1 gilt.','d_F(\\mathcal T_F(z_1),\\mathcal T_F(z_2))\\leq q_F d_F(z_1,z_2),\\qquad 0\\leq q_F<1','d_F(\\mathcal T_F(z_1),\\mathcal T_F(z_2))\\leq q_F d_F(z_1,z_2),\\qquad 0\\leq q_F<1','original',NULL);

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
'Voraussetzungen gemäß Abschnitt 3.2.38.',
CASE
    WHEN t.provenance='original'
    THEN 'FRZK-spezifische Eigenkonstruktion; spätere Operatorpräzisierung erforderlich.'
    ELSE 'Begriff aus der klassischen Fixpunkt- und Kontraktionstheorie.'
END,
'verified',
@revision
FROM tmp_defs_3238 t
WHERE NOT EXISTS (
    SELECT 1 FROM definitions d
    WHERE d.definition_number=t.definition_number
);

-- Sätze
CREATE TEMPORARY TABLE tmp_thms_3238 (
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_3238 VALUES
('3.2.125','Banachscher Fixpunktsatz','Jede kontraktive Selbstabbildung eines vollständigen metrischen Raumes besitzt genau einen Fixpunkt.','\\exists!\\,x^\\ast:\\ T(x^\\ast)=x^\\ast','\\exists!\\,x^\\ast:\\ T(x^\\ast)=x^\\ast','literature',@src112),
('3.2.126','Konvergenzgeschwindigkeit','Für jede durch eine Kontraktion erzeugte Iterationsfolge gilt d(x_k,x*)≤q^k d(x_0,x*).','d(x_k,x^\\ast)\\leq q^k d(x_0,x^\\ast)','d(x_k,x^\\ast)\\leq q^k d(x_0,x^\\ast)','literature',@src112),
('3.2.127','Fehlerabschätzung','Für jeden Iterationsschritt einer kontraktiven Fixpunktiteration gilt e_k≤q^k e_0.','e_k\\leq q^k e_0','e_k\\leq q^k e_0','literature',@src112),
('3.2.128','Funktionaler Fixpunktsatz','Ist der funktionale Zustandsraum vollständig und besitzt der funktionale Operator die Kontraktionseigenschaft, so existiert genau ein funktionaler Fixpunkt.','\\exists!\\,z^\\ast:\\ \\mathcal T_F(z^\\ast)=z^\\ast','\\exists!\\,z^\\ast:\\ \\mathcal T_F(z^\\ast)=z^\\ast','original',NULL);

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
'Voraussetzungen gemäß Abschnitt 3.2.38.',
'verified',
@revision
FROM tmp_thms_3238 t
WHERE NOT EXISTS (
    SELECT 1 FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

-- Gleichungen
CREATE TEMPORARY TABLE tmp_eqs_3238 (
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_3238 VALUES
('3.2979','Iterationsschema bis zum Fixpunkt','x_0\\longrightarrow T(x_0)\\longrightarrow T^2(x_0)\\longrightarrow\\cdots\\longrightarrow x^\\ast','x_0\\longrightarrow T(x_0)\\longrightarrow T^2(x_0)\\longrightarrow\\cdots\\longrightarrow x^\\ast','Formale Gleichung aus Abschnitt 3.2.38.','schema','literature',@src112),
('3.2980','Fixpunkt als Element des Zustandsraums','x^\\ast\\in X','x^\\ast\\in X','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2981','Selbstabbildung des Zustandsraums','T:X\\rightarrow X','T:X\\rightarrow X','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2982','Fixpunktgleichung','T(x^\\ast)=x^\\ast','T(x^\\ast)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2983','Anfangswert der Iteration','x_0','x_0','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2984','Rekursive Iterationsvorschrift','x_{k+1}=T(x_k)','x_{k+1}=T(x_k)','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2985','Kontraktionsfaktor','0\\leq q<1','0\\leq q<1','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2986','Kontraktionsungleichung','d(Tx,Ty)\\leq q\\,d(x,y)','d(Tx,Ty)\\leq q\\,d(x,y)','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2987','Eindeutige Existenz des Fixpunktes','\\exists!\\,x^\\ast\\;:\\;T(x^\\ast)=x^\\ast','\\exists!\\,x^\\ast\\;:\\;T(x^\\ast)=x^\\ast','Formale Gleichung aus Abschnitt 3.2.38.','theorem','literature',@src112),
('3.2988','Geometrische Konvergenz','d(x_k,x^\\ast)\\leq q^k d(x_0,x^\\ast)','d(x_k,x^\\ast)\\leq q^k d(x_0,x^\\ast)','Formale Gleichung aus Abschnitt 3.2.38.','theorem','literature',@src112),
('3.2989','Fixpunktiteration','x_{k+1}=T(x_k)','x_{k+1}=T(x_k)','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2990','Definition der Fehlerfolge','e_k=d(x_k,x^\\ast)','e_k=d(x_k,x^\\ast)','Formale Gleichung aus Abschnitt 3.2.38.','definition','literature',@src112),
('3.2991','Rekursive Fehlerabschätzung','e_{k+1}\\leq q\\,e_k','e_{k+1}\\leq q\\,e_k','Formale Gleichung aus Abschnitt 3.2.38.','derived','literature',@src112),
('3.2992','Explizite Fehlerabschätzung','e_k\\leq q^k e_0','e_k\\leq q^k e_0','Formale Gleichung aus Abschnitt 3.2.38.','theorem','literature',@src112),
('3.2993','Funktionaler Operator','\\mathcal T_F:Z\\rightarrow Z','\\mathcal T_F:Z\\rightarrow Z','Formale Gleichung aus Abschnitt 3.2.38.','definition','original',NULL),
('3.2994','Funktionaler Fixpunktzustand','z^\\ast','z^\\ast','Formale Gleichung aus Abschnitt 3.2.38.','definition','original',NULL),
('3.2995','Funktionale Fixpunktgleichung','\\mathcal T_F(z^\\ast)=z^\\ast','\\mathcal T_F(z^\\ast)=z^\\ast','Formale Gleichung aus Abschnitt 3.2.38.','definition','original',NULL),
('3.2996','Funktionale Kontraktionsungleichung','d_F(\\mathcal T_F(z_1),\\mathcal T_F(z_2))\\leq q_F d_F(z_1,z_2)','d_F(\\mathcal T_F(z_1),\\mathcal T_F(z_2))\\leq q_F d_F(z_1,z_2)','Formale Gleichung aus Abschnitt 3.2.38.','definition','original',NULL),
('3.2997','Funktionaler Kontraktionsfaktor','0\\leq q_F<1','0\\leq q_F<1','Formale Gleichung aus Abschnitt 3.2.38.','definition','original',NULL);

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
'Im Text von Abschnitt 3.2.38 eingeführt oder aus der Kontraktionsbedingung abgeleitet.',
'Voraussetzungen gemäß Abschnitt 3.2.38.',
'verified',
@revision
FROM tmp_eqs_3238 t
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
'3.2.38',
'Abschnitt 3.2.38 vollständig angelegt.',
'9 Definitionen, 4 Sätze, 19 Gleichungen und Quelle [112].'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.38'
);

-- Repository-Zähler
INSERT INTO repository_counters
(counter_key,counter_value)
VALUES
('last_completed_section','3.2.38'),
('current_section','3.2.39'),
('last_definition_number','3.2.588'),
('next_definition_number','3.2.589'),
('last_theorem_number','3.2.128'),
('next_theorem_number','3.2.129'),
('last_equation_number','3.2997'),
('next_equation_number','3.2998'),
('last_citation_number','112'),
('next_citation_number','113')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3238;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3238;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3238;

COMMIT;

-- Abschlussprüfung
SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code='3.2.38';

SELECT COUNT(*) AS definitionen_3_2_38
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 580 AND 588;

SELECT COUNT(*) AS saetze_3_2_38
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 125 AND 128;

SELECT COUNT(*) AS gleichungen_3_2_38
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 2979 AND 2997;

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
