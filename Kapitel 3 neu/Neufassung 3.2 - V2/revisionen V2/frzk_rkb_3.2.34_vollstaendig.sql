-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.34
-- Eingangs-Zustands-Stabilität, Störungen und Robustheit
--
-- Verbindliche Grundlage: zuletzt festgelegte Textfassung von 3.2.34
-- Definitionen : 3.2.529–3.2.541
-- Sätze        : 3.2.113
-- Gleichungen  : (3.2896)–(3.2918)
-- Literatur    : [108]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.34-V1',NOW(),'section','3.2.34','3.2.34-v1',
'Eingangs-Zustands-Stabilität, ISS-Lyapunov-Funktionen sowie funktionale Eingänge und Robustheit im FRZK.',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.34-V1'
);

SET @revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.34-V1'
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
'3.2.34',
'Eingangs-Zustands-Stabilität, Störungen und Robustheit',
3,
3234,
'final',
1,
'ISS-Grundlagen, Vergleichsfunktionen, ISS-Lyapunov-Kriterium und FRZK-spezifische Übertragung.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.2.34'
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.34'
    LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Literatur [108]
-- Bibliografischer Arbeitsstand:
-- Sontag, Eduardo D.: Input to State Stability: Basic Concepts and Results.
-- In: Nistri, P.; Stefani, G. (Hrsg.): Nonlinear and Optimal Control Theory.
-- Springer, Berlin/Heidelberg, 2008, S. 163–220.
-- ---------------------------------------------------------------------------

INSERT INTO authors
(family_name,given_names,normalized_name,notes)
SELECT
'Sontag',
'Eduardo D.',
'Sontag, Eduardo D.',
'Autor der Quelle [108].'
WHERE NOT EXISTS (
    SELECT 1
    FROM authors
    WHERE normalized_name='Sontag, Eduardo D.'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
108,
'sontag_input_to_state_stability_2008',
'book_chapter',
'Input to State Stability: Basic Concepts and Results',
2008,
2008,
'Springer',
'Berlin/Heidelberg',
NULL,
NULL,
'en',
1,
'book_chapter',
10,
'pending',
'3.2.34',
'Erstnennung für Input-to-State Stability, Vergleichsfunktionen und ISS-Lyapunov-Funktionen.',
'Sontag, Eduardo D.: Input to State Stability: Basic Concepts and Results. In: Nistri, Paolo; Stefani, Gianna (Hrsg.): Nonlinear and Optimal Control Theory. Berlin/Heidelberg: Springer, 2008, S. 163–220.',
'Sontag, Input to State Stability [108]',
'Bibliografischer Arbeitsstand; vor der Endredaktion gegen den offiziellen Repository-Literaturstand prüfen.',
@revision
WHERE NOT EXISTS (
    SELECT 1
    FROM sources
    WHERE citation_number=108
       OR source_key='sontag_input_to_state_stability_2008'
);

SET @src108 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=108
    LIMIT 1
);

SET @author108 := (
    SELECT author_id
    FROM authors
    WHERE normalized_name='Sontag, Eduardo D.'
    LIMIT 1
);

INSERT INTO source_authors
(source_id,author_id,author_order,role)
SELECT
@src108,@author108,1,'author'
WHERE @src108 IS NOT NULL
  AND @author108 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_authors
      WHERE source_id=@src108
        AND author_id=@author108
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT
@src108,
@section,
'first_citation',
'Input-to-State Stability, Vergleichsfunktionen, ISS-Abschätzung und ISS-Lyapunov-Kriterium.',
'3.2.34',
1,
0,
'Quelle [108] vor Endredaktion bibliografisch prüfen.',
@revision
WHERE @src108 IS NOT NULL
  AND @section IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage
      WHERE source_id=@src108
        AND section_id=@section
        AND exact_location='3.2.34'
  );

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.529–3.2.541
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_defs_3234 (
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_3234 VALUES
('3.2.529','Eingangsbehaftetes dynamisches System','Ein eingangsbehaftetes kontinuierliches System besitzt die Form ẋ=f(x,u), wobei x∈X der Zustand und u∈U der Eingang ist.','\\dot x=f(x,u),\\qquad x\\in X,\\quad u\\in U','\\dot x=f(x,u),\\qquad x\\in X,\\quad u\\in U','literature',@src108),
('3.2.530','Zulässiger Eingang','Eine Funktion u:[0,∞)→U heißt zulässiger Eingang, wenn sie den für das Modell geforderten Regularitätsbedingungen genügt.','u:[0,\\infty)\\rightarrow U','u:[0,\\infty)\\rightarrow U','literature',@src108),
('3.2.531','Ungestörtes System','Für u(t)≡0 geht das eingangsbehaftete System in das autonome System ẋ=f(x,0) über.','u(t)\\equiv0,\\qquad\\dot x=f(x,0)','u(t)\\equiv0,\\qquad\\dot x=f(x,0)','literature',@src108),
('3.2.532','Supremumsnorm eines Eingangs','Für einen beschränkten Eingang ist die Supremumsnorm durch das Supremum der Eingangsnorm über alle nichtnegativen Zeiten definiert.','\\|u\\|_\\infty=\\sup_{t\\geq0}\\|u(t)\\|','\\|u\\|_\\infty=\\sup_{t\\geq0}\\|u(t)\\|','literature',@src108),
('3.2.533','Beschränkter Eingang','Ein Eingang heißt beschränkt, wenn seine Supremumsnorm endlich ist.','\\|u\\|_\\infty<\\infty','\\|u\\|_\\infty<\\infty','literature',@src108),
('3.2.534','Klasse-K-Funktion','Eine Funktion α:[0,∞)→[0,∞) gehört zur Klasse K, wenn α(0)=0 gilt und α streng monoton wächst.','\\alpha:[0,\\infty)\\rightarrow[0,\\infty),\\qquad\\alpha(0)=0','\\alpha:[0,\\infty)\\rightarrow[0,\\infty),\\qquad\\alpha(0)=0','literature',@src108),
('3.2.535','Klasse-K-unendlich-Funktion','Eine Klasse-K-Funktion gehört zu K∞, wenn sie zusätzlich unbeschränkt ist.','\\alpha(r)\\rightarrow\\infty\\qquad(r\\rightarrow\\infty)','\\alpha(r)\\rightarrow\\infty\\qquad(r\\rightarrow\\infty)','literature',@src108),
('3.2.536','Klasse-KL-Funktion','Eine Funktion β(r,t) gehört zur Klasse KL, wenn β(·,t) für festes t zur Klasse K gehört und β(r,t) für festes r gegen null konvergiert.','\\beta(\\cdot,t)\\in\\mathcal K,\\qquad\\beta(r,t)\\rightarrow0\\quad(t\\rightarrow\\infty)','\\beta(\\cdot,t)\\in\\mathcal K,\\qquad\\beta(r,t)\\rightarrow0\\quad(t\\rightarrow\\infty)','literature',@src108),
('3.2.537','Input-to-State Stability','Ein System heißt Input-to-State-stabil, wenn Funktionen β∈KL und γ∈K existieren, welche den Zustand durch einen abklingenden Anfangswertterm und einen Eingangsterm abschätzen.','\\|x(t)\\|\\leq\\beta(\\|x_0\\|,t)+\\gamma(\\|u\\|_\\infty)','\\|x(t)\\|\\leq\\beta(\\|x_0\\|,t)+\\gamma(\\|u\\|_\\infty)','literature',@src108),
('3.2.538','ISS-Lyapunov-Funktion','Eine Funktion V heißt ISS-Lyapunov-Funktion, wenn sie den Zustand durch K∞-Funktionen beidseitig abschätzt und ihre Ableitung durch einen negativen Zustandsterm plus Eingangsterm begrenzt wird.','\\alpha_1(\\|x\\|)\\leq V(x)\\leq\\alpha_2(\\|x\\|),\\qquad\\dot V(x)\\leq-\\alpha_3(\\|x\\|)+\\sigma(\\|u\\|)','\\alpha_1(\\|x\\|)\\leq V(x)\\leq\\alpha_2(\\|x\\|),\\qquad\\dot V(x)\\leq-\\alpha_3(\\|x\\|)+\\sigma(\\|u\\|)','literature',@src108),
('3.2.539','Funktionaler Eingang','Ein funktionaler Eingang ist eine zeitabhängige Abbildung e(t)∈E_F, welche den funktionalen Zustandsraum beeinflusst.','e(t)\\in E_F','e(t)\\in E_F','original',NULL),
('3.2.540','Funktionale Störgröße','Eine funktionale Störung ist ein Eingang η_F(t), der nicht Bestandteil der internen FRZK-Dynamik ist.','\\eta_F(t)','\\eta_F(t)','original',NULL),
('3.2.541','Funktionale Robustheit gegenüber Eingängen','Ein funktionaler Zustand heißt robust gegenüber Eingängen, wenn seine Norm durch einen abklingenden Anfangszustandsterm und einen von der funktionalen Störung abhängigen Term beschränkt wird.','\\|u(t)\\|\\leq\\beta(\\|u_0\\|,t)+\\gamma(\\|\\eta_F\\|_\\infty)','\\|u(t)\\|\\leq\\beta(\\|u_0\\|,t)+\\gamma(\\|\\eta_F\\|_\\infty)','original',NULL);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,
@section,
t.title,
t.definition_text,
NULLIF(t.formal_latex,''),
NULLIF(t.word_latex,''),
t.provenance,
t.source_id,
'Voraussetzungen gemäß Abschnitt 3.2.34.',
CASE
    WHEN t.provenance='original'
    THEN 'FRZK-spezifische Eigenkonstruktion; empirische Operationalisierung und Kalibrierung gesondert erforderlich.'
    ELSE 'Begriff oder Kriterium aus der Theorie eingangsabhängiger nichtlinearer Systeme.'
END,
'verified',
@revision
FROM tmp_defs_3234 t
WHERE NOT EXISTS (
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=t.definition_number
);

-- ---------------------------------------------------------------------------
-- Satz 3.2.113
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_thms_3234 (
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_3234 VALUES
('3.2.113','Lyapunov-Kriterium der Input-to-State Stability','Besitzt ein System eine ISS-Lyapunov-Funktion, so ist das System Input-to-State-stabil.','V\\Longrightarrow\\mathrm{ISS}','V\\Longrightarrow\\mathrm{ISS}','literature',@src108);

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
'Existenz einer ISS-Lyapunov-Funktion unter den Regularitätsvoraussetzungen von Abschnitt 3.2.34.',
'verified',
@revision
FROM tmp_thms_3234 t
WHERE NOT EXISTS (
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.2896)–(3.2918)
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_eqs_3234 (
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_3234 VALUES
('3.2896','Schema eingangsabhängiger Stabilitätsanalyse','u(t)\\longrightarrow x(t)\\longrightarrow V(x)\\longrightarrow\\text{Stabilitätsaussage}','u(t)\\longrightarrow x(t)\\longrightarrow V(x)\\longrightarrow\\text{Stabilitätsaussage}','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2897','Eingangsbehaftetes dynamisches System','\\dot x=f(x,u)','\\dot x=f(x,u)','Formale Gleichung aus Abschnitt 3.2.34.','model','literature',@src108),
('3.2898','Zustands- und Eingangsraum','x\\in X,\\qquad u\\in U','x\\in X,\\qquad u\\in U','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2899','Zulässiger Eingang','u:[0,\\infty)\\rightarrow U','u:[0,\\infty)\\rightarrow U','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2900','Verschwindender Eingang','u(t)\\equiv0','u(t)\\equiv0','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2901','Ungestörtes System','\\dot x=f(x,0)','\\dot x=f(x,0)','Formale Gleichung aus Abschnitt 3.2.34.','model','literature',@src108),
('3.2902','Supremumsnorm','\\|u\\|_\\infty=\\sup_{t\\geq0}\\|u(t)\\|','\\|u\\|_\\infty=\\sup_{t\\geq0}\\|u(t)\\|','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2903','Beschränkter Eingang','\\|u\\|_\\infty<\\infty','\\|u\\|_\\infty<\\infty','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2904','Definitionsbereich einer Klasse-K-Funktion','\\alpha:[0,\\infty)\\rightarrow[0,\\infty)','\\alpha:[0,\\infty)\\rightarrow[0,\\infty)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2905','Unbeschränktheit einer Klasse-K-unendlich-Funktion','\\alpha(r)\\rightarrow\\infty\\qquad(r\\rightarrow\\infty)','\\alpha(r)\\rightarrow\\infty\\qquad(r\\rightarrow\\infty)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2906','Klasse-KL-Funktion','\\beta(r,t)','\\beta(r,t)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2907','Klasse-K-Eigenschaft','\\beta(\\cdot,t)\\in\\mathcal K','\\beta(\\cdot,t)\\in\\mathcal K','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2908','Zeitliches Abklingen','\\beta(r,t)\\rightarrow0\\qquad(t\\rightarrow\\infty)','\\beta(r,t)\\rightarrow0\\qquad(t\\rightarrow\\infty)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2909','ISS-Vergleichsfunktionen','\\beta\\in\\mathcal{KL},\\qquad\\gamma\\in\\mathcal K','\\beta\\in\\mathcal{KL},\\qquad\\gamma\\in\\mathcal K','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2910','ISS-Abschätzung','\\|x(t)\\|\\leq\\beta(\\|x_0\\|,t)+\\gamma(\\|u\\|_\\infty)','\\|x(t)\\|\\leq\\beta(\\|x_0\\|,t)+\\gamma(\\|u\\|_\\infty)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2911','ISS-Lyapunov-Funktion','V(x)','V(x)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2912','Vergleichsfunktionen der ISS-Lyapunov-Funktion','\\alpha_1,\\alpha_2,\\alpha_3\\in\\mathcal K_\\infty','\\alpha_1,\\alpha_2,\\alpha_3\\in\\mathcal K_\\infty','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2913','Beidseitige Lyapunov-Abschätzung','\\alpha_1(\\|x\\|)\\leq V(x)\\leq\\alpha_2(\\|x\\|)','\\alpha_1(\\|x\\|)\\leq V(x)\\leq\\alpha_2(\\|x\\|)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2914','ISS-Dissipationsungleichung','\\dot V(x)\\leq-\\alpha_3(\\|x\\|)+\\sigma(\\|u\\|)','\\dot V(x)\\leq-\\alpha_3(\\|x\\|)+\\sigma(\\|u\\|)','Formale Gleichung aus Abschnitt 3.2.34.','definition','literature',@src108),
('3.2915','ISS-Lyapunov-Kriterium','V\\Longrightarrow\\mathrm{ISS}','V\\Longrightarrow\\mathrm{ISS}','Formale Gleichung aus Abschnitt 3.2.34.','theorem','literature',@src108),
('3.2916','Funktionaler Eingang','e(t)\\in E_F','e(t)\\in E_F','Formale Gleichung aus Abschnitt 3.2.34.','definition','original',NULL),
('3.2917','Funktionale Störgröße','\\eta_F(t)','\\eta_F(t)','Formale Gleichung aus Abschnitt 3.2.34.','definition','original',NULL),
('3.2918','Funktionale Robustheitsabschätzung','\\|u(t)\\|\\leq\\beta(\\|u_0\\|,t)+\\gamma(\\|\\eta_F\\|_\\infty)','\\|u(t)\\|\\leq\\beta(\\|u_0\\|,t)+\\gamma(\\|\\eta_F\\|_\\infty)','Formale Gleichung aus Abschnitt 3.2.34.','definition','original',NULL);

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
'Im Text von Abschnitt 3.2.34 eingeführt, verwendet oder aus den ISS-Voraussetzungen abgeleitet.',
'Voraussetzungen gemäß Abschnitt 3.2.34.',
'verified',
@revision
FROM tmp_eqs_3234 t
WHERE NOT EXISTS (
    SELECT 1
    FROM equations e
    WHERE e.equation_number=t.equation_number
);

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,new_value)
SELECT
@revision,
@section,
'created',
'section',
'3.2.34',
'Abschnitt 3.2.34 vollständig angelegt.',
'13 Definitionen, 1 Satz, 23 Gleichungen und Quelle [108].'
WHERE NOT EXISTS (
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.34'
);

-- ---------------------------------------------------------------------------
-- Repository-Zähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters
(counter_key,counter_value)
VALUES
('last_completed_section','3.2.34'),
('current_section','3.2.35'),
('last_definition_number','3.2.541'),
('next_definition_number','3.2.542'),
('last_theorem_number','3.2.113'),
('next_theorem_number','3.2.114'),
('last_equation_number','3.2918'),
('next_equation_number','3.2919'),
('last_citation_number','108'),
('next_citation_number','109')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3234;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3234;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3234;

COMMIT;

-- ---------------------------------------------------------------------------
-- Abschlussprüfung
-- Erwartete Werte:
-- Definitionen = 13
-- Sätze        = 1
-- Gleichungen  = 23
-- ---------------------------------------------------------------------------

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code='3.2.34';

SELECT COUNT(*) AS definitionen_3_2_34
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 529 AND 541;

SELECT COUNT(*) AS saetze_3_2_34
FROM theorems
WHERE section_id=@section
  AND theorem_number='3.2.113';

SELECT COUNT(*) AS gleichungen_3_2_34
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 2896 AND 2918;

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
