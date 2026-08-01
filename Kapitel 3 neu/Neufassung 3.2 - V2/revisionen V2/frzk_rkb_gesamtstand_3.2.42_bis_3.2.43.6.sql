-- ###########################################################################
-- FRZK REPOSITORY – KONSOLIDIERTER GESAMTSTAND
-- Ausgangsstand : 3.2.42
-- Enthalten     : 3.2.43.1–3.2.43.6
--
-- Endstand:
-- Definitionen : bis 3.2.667
-- Sätze        : bis 3.2.153
-- Gleichungen  : bis (3.3175)
-- Literatur    : bis [117]
--
-- Importreihenfolge innerhalb dieser Datei:
-- 1. 3.2.42 – hochgeladener Ausgangsstand
-- 2. 3.2.43.1–3.2.43.4 – Lorentz-Transformationen
-- 3. 3.2.43.5 – Kausalstruktur und Intervallklassen
-- 4. 3.2.43.6 – relativistische kinematische Effekte
-- ###########################################################################


-- ==================== BEGINN 3.2.42 ====================
-- ###########################################################################
-- FRZK Repository
-- Abschnitt 3.2.42
-- Pseudo-Riemannsche Geometrie und Raumzeitstrukturen
--
-- Definitionen : 3.2.621–3.2.637
-- Sätze        : 3.2.141–3.2.144
-- Gleichungen  : (3.3029)–(3.3065)
-- Literatur    : [116]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

-- Revision
SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.42-V1',
NOW(),
'section',
'3.2.42',
'3.2.42-v1',
'Pseudo-Riemannsche Geometrie, Lorentz-Mannigfaltigkeiten, Lichtkegel, Eigenzeit und funktionale Signaturen.',
'Olaf Thiele / ChatGPT',
@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.42-V1'
);

SET @revision=(SELECT revision_id FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.42-V1' LIMIT 1);

SET @parent_section=(SELECT section_id FROM dissertation_sections
WHERE section_code='3.2' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,
'3.2.42',
'Pseudo-Riemannsche Geometrie und Raumzeitstrukturen',
3,
3242,
'final',
1,
'Lorentz-Mannigfaltigkeiten, Lichtkegel, Eigenzeit sowie funktionale pseudo-Riemannsche Strukturen.'
WHERE NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code='3.2.42'
);

-- Literatur [116]
INSERT INTO authors(family_name,given_names,normalized_name)
SELECT 'O''Neill','Barrett','O''Neill, Barrett'
WHERE NOT EXISTS(
SELECT 1 FROM authors WHERE normalized_name='O''Neill, Barrett');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,publisher,language_code,verification_status,created_revision_id)
SELECT
116,
'oneill_semi_riemannian_geometry',
'book',
'Semi-Riemannian Geometry',
1983,
'Academic Press',
'en',
'pending',
@revision
WHERE NOT EXISTS(
SELECT 1 FROM sources WHERE citation_number=116);

SET @src116=(SELECT source_id FROM sources WHERE citation_number=116 LIMIT 1);

-- -------------------------------------------------------------------
-- Repository-Zähler
-- -------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.42'),
('current_section','3.2.43'),
('last_definition_number','3.2.637'),
('next_definition_number','3.2.638'),
('last_theorem_number','3.2.144'),
('next_theorem_number','3.2.145'),
('last_equation_number','3.3065'),
('next_equation_number','3.3066'),
('last_citation_number','116'),
('next_citation_number','117')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

COMMIT;

-- Validierung

SELECT 'Definitionen' AS typ,'3.2.621-3.2.637' AS bereich;
SELECT 'Saetze' AS typ,'3.2.141-3.2.144' AS bereich;
SELECT 'Gleichungen' AS typ,'3.3029-3.3065' AS bereich;
SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key LIKE 'last_%'
   OR counter_key LIKE 'next_%';

-- ===================== ENDE 3.2.42 =====================

-- ================ BEGINN 3.2.43.1–3.2.43.4 ================
USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

/* FRZK-Repository 3.2.43 – Lorentz-Transformationen und Invarianz
   Definitionen 3.2.638–3.2.652; Sätze 3.2.145–3.2.148;
   Gleichungen 3.3066–3.3115; Literatur [117]. */

SET @parent_revision=(SELECT revision_id FROM repository_revisions WHERE scope_reference='3.2.42' ORDER BY revision_id DESC LIMIT 1);
SET @parent_section=(SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);

INSERT INTO repository_revisions(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.43-V1',NOW(),'section','3.2.43','3.2.43-v1','Lorentz-Transformationen, Vierervektoren, Lorentz-Faktor, inverse Transformation und Invarianz des Minkowski-Intervalls.','Olaf Thiele / ChatGPT',@parent_revision
WHERE @parent_revision IS NOT NULL AND NOT EXISTS(SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.43-V1');
SET @revision=(SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.43-V1' LIMIT 1);

INSERT INTO dissertation_sections(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.43','Lorentz-Transformationen und Invarianz',3,3243,'final',0,'Vierervektoren, Standardkonfiguration, Lorentz-Faktor, Boostmatrix, inverse Transformation und Erhaltung des Minkowski-Intervalls.'
WHERE @parent_section IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dissertation_sections WHERE section_code='3.2.43');
UPDATE dissertation_sections SET parent_section_id=@parent_section,title='Lorentz-Transformationen und Invarianz',chapter_no=3,section_order=3243,status='final',is_original_contribution=0,notes='Vierervektoren, Standardkonfiguration, Lorentz-Faktor, Boostmatrix, inverse Transformation und Erhaltung des Minkowski-Intervalls.' WHERE section_code='3.2.43';
SET @section=(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.43' LIMIT 1);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Einstein','Albert','Einstein, Albert','Autor der Quelle [117].' WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Einstein, Albert');
INSERT INTO sources(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 117,'einstein_elektrodynamik_bewegter_koerper_1905','journal_article','Zur Elektrodynamik bewegter Körper',1905,1905,'Annalen der Physik','Leipzig',NULL,'de',1,'primary_source',9,'pending','3.2.43','Erstnennung für Inertialsysteme, Lorentz-Transformationen und Invarianz.','Einstein, Albert: Zur Elektrodynamik bewegter Körper. Annalen der Physik 17 (1905), S. 891–921.','Einstein, Elektrodynamik bewegter Körper [117]','Bibliografischer Arbeitsstand; vor Endredaktion prüfen.',@revision
WHERE NOT EXISTS(SELECT 1 FROM sources WHERE citation_number=117 OR source_key='einstein_elektrodynamik_bewegter_koerper_1905');
SET @src117=(SELECT source_id FROM sources WHERE citation_number=117 LIMIT 1);
SET @author117=(SELECT author_id FROM authors WHERE normalized_name='Einstein, Albert' LIMIT 1);
INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src117,@author117,1,'author' WHERE @src117 IS NOT NULL AND @author117 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_authors WHERE source_id=@src117 AND author_id=@author117);
INSERT INTO source_usage(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @src117,@section,'first_citation','Inertialsysteme, Lorentz-Faktor, Lorentz-Transformation, inverse Transformation und Invarianz des Minkowski-Intervalls.','Abschnitt 3.2.43',1,0,'Quelle [117] vor Endredaktion bibliografisch und seitenbezogen prüfen.',@revision
WHERE @src117 IS NOT NULL AND @section IS NOT NULL AND NOT EXISTS(SELECT 1 FROM source_usage WHERE source_id=@src117 AND section_id=@section AND exact_location='Abschnitt 3.2.43');

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3243;
CREATE TEMPORARY TABLE tmp_defs_3243(definition_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500),definition_text LONGTEXT,formal_latex LONGTEXT,word_latex LONGTEXT) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_defs_3243 VALUES
('3.2.638','Raumzeitliches Ereignis','Ein raumzeitliches Ereignis ist ein eindeutig bestimmter Punkt innerhalb einer Raumzeit. In einem Inertialsystem kann es durch einen Vierervektor dargestellt werden.','x^\\mu=\\begin{pmatrix}ct\\\\x\\\\y\\\\z\\end{pmatrix}','x^\\mu=\\begin{pmatrix}ct\\x\\y\\z\\ \\end{pmatrix}'),
('3.2.639','Viererkoordinaten','Die Komponenten eines Raumzeitvektors werden als x^0, x^1, x^2 und x^3 bezeichnet, wobei x^0=ct, x^1=x, x^2=y und x^3=z gilt.','x^\\mu=(x^0,x^1,x^2,x^3)','x^\\mu=(x^0,x^1,x^2,x^3)'),
('3.2.640','Inertialsystem','Ein Inertialsystem ist ein Bezugssystem, in welchem sich jeder kräftefreie Körper geradlinig mit konstanter Geschwindigkeit bewegt.','S''\\xrightarrow{v}S','S''\\xrightarrow{v}S'),
('3.2.641','Standardkonfiguration','Zwei Inertialsysteme befinden sich in Standardkonfiguration, wenn ihre Achsen parallel verlaufen, die Relativbewegung entlang der x-Achse erfolgt und beide Ursprünge zum Zeitpunkt t=t''=0 zusammenfallen.','x=x''=0,\\qquad t=t''=0','x=x''=0,\\qquad t=t''=0'),
('3.2.642','Relative Geschwindigkeit','Die dimensionslose Relativgeschwindigkeit ist durch beta=v/c definiert.','\\beta=\\frac{v}{c}','\\beta=\\frac{v}{c}'),
('3.2.643','Lorentz-Faktor','Der Lorentz-Faktor ist der Kehrwert der Quadratwurzel aus 1-beta^2.','\\gamma=\\frac{1}{\\sqrt{1-\\beta^2}}','\\gamma=\\frac{1}{\\sqrt{1-\\beta^2}}'),
('3.2.644','Lorentz-Transformation','Die Lorentz-Transformation ist eine lineare Abbildung zwischen zwei Inertialsystemen, welche das Minkowski-Intervall invariant lässt.','ct''=\\gamma(ct-\\beta x),\\qquad x''=\\gamma(x-\\beta ct)','ct''=\\gamma(ct-\\beta x),\\qquad x''=\\gamma(x-\\beta ct)'),
('3.2.645','Darstellung mit der Relativgeschwindigkeit','Unter Verwendung von beta=v/c kann die Lorentz-Transformation durch x''=gamma(x-vt) und t''=gamma(t-vx/c^2) dargestellt werden.','x''=\\gamma(x-vt),\\qquad t''=\\gamma\\left(t-\\frac{vx}{c^2}\\right)','x''=\\gamma(x-vt),\\qquad t''=\\gamma\\left(t-\\frac{vx}{c^2}\\right)'),
('3.2.646','Matrixdarstellung','Die Lorentz-Transformation kann als Matrixmultiplikation eines Vierervektors mit einer Lorentz-Matrix geschrieben werden.','x''^\\mu=\\Lambda^\\mu{}_{\\nu}x^\\nu','x''^\\mu=\\Lambda^\\mu{}_{\\nu}x^\\nu'),
('3.2.647','Inverse Lorentz-Transformation','Die inverse Lorentz-Transformation entsteht durch Ersetzen der Relativgeschwindigkeit v durch -v.','\\Lambda^{-1}(v)=\\Lambda(-v)','\\Lambda^{-1}(v)=\\Lambda(-v)'),
('3.2.648','Raumzeitintervall','Das Raumzeitintervall zwischen zwei infinitesimal benachbarten Ereignissen ist durch ds^2=-c^2dt^2+dx^2+dy^2+dz^2 definiert.','ds^2=-c^2dt^2+dx^2+dy^2+dz^2','ds^2=-c^2dt^2+dx^2+dy^2+dz^2'),
('3.2.649','Lorentz-Invarianz','Eine Größe heißt Lorentz-invariant, wenn sie unter jeder Lorentz-Transformation unverändert bleibt.','ds''^2=ds^2','ds''^2=ds^2'),
('3.2.650','Metrische Erhaltung','Die Invarianz des Raumzeitintervalls ist äquivalent zur Erhaltung der Minkowski-Metrik durch die Lorentz-Matrix.','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta'),
('3.2.651','Lorentz-Matrix','Eine reelle Matrix Lambda heißt Lorentz-Matrix, wenn sie die Minkowski-Metrik erhält.','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta'),
('3.2.652','Lorentz-Gruppe','Die Lorentz-Gruppe O(1,3) ist die Menge aller invertierbaren reellen 4-mal-4-Matrizen, welche die Minkowski-Metrik erhalten.','O(1,3)=\\left\\{\\Lambda\\in GL(4,\\mathbb R)\\mid\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta\\right\\}','O(1,3)=\\left\\{\\Lambda\\in GL(4,\\mathbb R)\\mid\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta\\right\\}');
INSERT INTO definitions(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT definition_number,@section,title,definition_text,formal_latex,word_latex,'literature',@src117,'Voraussetzungen gemäß Abschnitt 3.2.43.','Etablierte Definition der Speziellen Relativitätstheorie.','verified',@revision FROM tmp_defs_3243 t WHERE NOT EXISTS(SELECT 1 FROM definitions d WHERE d.definition_number=t.definition_number);
UPDATE definitions d JOIN tmp_defs_3243 t ON t.definition_number=d.definition_number SET d.section_id=@section,d.title=t.title,d.definition_text=t.definition_text,d.formal_latex=t.formal_latex,d.word_latex=t.word_latex,d.provenance='literature',d.source_id=@src117,d.assumptions='Voraussetzungen gemäß Abschnitt 3.2.43.',d.notes='Etablierte Definition der Speziellen Relativitätstheorie.',d.validation_status='verified',d.created_revision_id=COALESCE(d.created_revision_id,@revision);

DROP TEMPORARY TABLE IF EXISTS tmp_thms_3243;
CREATE TEMPORARY TABLE tmp_thms_3243(theorem_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500),statement_text LONGTEXT,statement_latex LONGTEXT,proof_text LONGTEXT) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_thms_3243 VALUES
('3.2.145','Positivität des Lorentz-Faktors','Für jede zulässige Relativgeschwindigkeit gilt gamma größer oder gleich eins.','\\gamma\\geq1','Aus 0<=v^2/c^2<1 folgt 0<sqrt(1-v^2/c^2)<=1. Durch Kehrwertbildung ergibt sich gamma>=1.'),
('3.2.146','Linearität der Lorentz-Transformation','Die Lorentz-Transformation ist linear.','\\Lambda(au+bv)=a\\Lambda u+b\\Lambda v','Die Aussage folgt aus der Distributivität und Homogenität der Matrixmultiplikation.'),
('3.2.147','Invertierbarkeit','Die Lorentz-Transformation besitzt für jede zulässige Relativgeschwindigkeit eine eindeutige Inverse.','\\Lambda^{-1}(v)=\\Lambda(-v)','Durch Multiplikation von Lambda(v) und Lambda(-v) in beiden Reihenfolgen entsteht die Identitätsmatrix.'),
('3.2.148','Erhaltung des Minkowski-Intervalls','Jede Lorentz-Transformation erhält das Raumzeitintervall.','-c^2dt''^2+dx''^2+dy''^2+dz''^2=-c^2dt^2+dx^2+dy^2+dz^2','Einsetzen der differentiellen Lorentz-Transformation und Verwendung von gamma^2(1-v^2/c^2)=1 liefert die Invarianz.');
INSERT INTO theorems
(
    theorem_number,
    section_id,
    title,
    statement_text,
    statement_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    t.theorem_number,
    @section,
    t.title,
    t.statement_text,
    t.statement_latex,
    t.statement_latex,
    'literature',
    @src117,
    'Voraussetzungen gemäß Abschnitt 3.2.43.',
    'verified',
    @revision
FROM tmp_thms_3243 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);
UPDATE theorems th
JOIN tmp_thms_3243 t
    ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src117,
    th.assumptions='Voraussetzungen gemäß Abschnitt 3.2.43.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3243;
CREATE TEMPORARY TABLE tmp_eqs_3243(equation_number VARCHAR(50) PRIMARY KEY,title VARCHAR(500),equation_latex TEXT,word_latex TEXT,plain_description TEXT,equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other')) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO tmp_eqs_3243 VALUES
('3.3066','Allgemeine Lorentz-Transformation','x^\\mu\\longmapsto x''^\\mu=\\Lambda^\\mu{}_{\\nu}x^\\nu','x^\\mu\\longmapsto x''^\\mu=\\Lambda^\\mu{}_{\\nu}x^\\nu','Formale Gleichung aus Abschnitt 3.2.43: Allgemeine Lorentz-Transformation.','schema'),
('3.3067','Vierervektor eines Ereignisses','x^\\mu=\\begin{pmatrix}ct\\\\x\\\\y\\\\z\\end{pmatrix}','x^\\mu=\\begin{pmatrix}ct\\x\\y\\z\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43: Vierervektor eines Ereignisses.','definition'),
('3.3068','Viererkoordinaten','x^\\mu=(x^0,x^1,x^2,x^3)','x^\\mu=(x^0,x^1,x^2,x^3)','Formale Gleichung aus Abschnitt 3.2.43: Viererkoordinaten.','definition'),
('3.3069','Zuordnung der Viererkoordinaten','x^0=ct,\\qquad x^1=x,\\qquad x^2=y,\\qquad x^3=z','x^0=ct,\\qquad x^1=x,\\qquad x^2=y,\\qquad x^3=z','Formale Gleichung aus Abschnitt 3.2.43: Zuordnung der Viererkoordinaten.','definition'),
('3.3070','Relativbewegung zweier Inertialsysteme','S''\\xrightarrow{v}S','S''\\xrightarrow{v}S','Formale Gleichung aus Abschnitt 3.2.43: Relativbewegung zweier Inertialsysteme.','schema'),
('3.3071','Gemeinsames Ursprungsereignis','x=x''=0,\\qquad t=t''=0','x=x''=0,\\qquad t=t''=0','Formale Gleichung aus Abschnitt 3.2.43: Gemeinsames Ursprungsereignis.','definition'),
('3.3072','Dimensionslose Relativgeschwindigkeit','\\beta=\\frac{v}{c}','\\beta=\\frac{v}{c}','Formale Gleichung aus Abschnitt 3.2.43: Dimensionslose Relativgeschwindigkeit.','definition'),
('3.3073','Zulässiger Bereich der Relativgeschwindigkeit','|\\beta|<1','|\\beta|<1','Formale Gleichung aus Abschnitt 3.2.43: Zulässiger Bereich der Relativgeschwindigkeit.','definition'),
('3.3074','Lorentz-Faktor mit beta','\\gamma=\\frac{1}{\\sqrt{1-\\beta^2}}','\\gamma=\\frac{1}{\\sqrt{1-\\beta^2}}','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Faktor mit beta.','definition'),
('3.3075','Lorentz-Faktor mit v und c','\\gamma=\\frac{1}{\\sqrt{1-\\frac{v^2}{c^2}}}','\\gamma=\\frac{1}{\\sqrt{1-\\frac{v^2}{c^2}}}','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Faktor mit v und c.','definition'),
('3.3076','Untere Schranke des Lorentz-Faktors','\\gamma\\geq1','\\gamma\\geq1','Formale Gleichung aus Abschnitt 3.2.43: Untere Schranke des Lorentz-Faktors.','theorem'),
('3.3077','Quadratische Geschwindigkeitsbedingung','0\\leq\\frac{v^2}{c^2}<1','0\\leq\\frac{v^2}{c^2}<1','Formale Gleichung aus Abschnitt 3.2.43: Quadratische Geschwindigkeitsbedingung.','derived'),
('3.3078','Differenz zur Lichtgeschwindigkeit','0<1-\\frac{v^2}{c^2}\\leq1','0<1-\\frac{v^2}{c^2}\\leq1','Formale Gleichung aus Abschnitt 3.2.43: Differenz zur Lichtgeschwindigkeit.','derived'),
('3.3079','Wurzelabschätzung','0<\\sqrt{1-\\frac{v^2}{c^2}}\\leq1','0<\\sqrt{1-\\frac{v^2}{c^2}}\\leq1','Formale Gleichung aus Abschnitt 3.2.43: Wurzelabschätzung.','derived'),
('3.3080','Kehrwertabschätzung','\\frac{1}{\\sqrt{1-\\frac{v^2}{c^2}}}\\geq1','\\frac{1}{\\sqrt{1-\\frac{v^2}{c^2}}}\\geq1','Formale Gleichung aus Abschnitt 3.2.43: Kehrwertabschätzung.','derived'),
('3.3081','Transformation der Zeitkoordinate','ct''=\\gamma\\left(ct-\\beta x\\right)','ct''=\\gamma\\left(ct-\\beta x\\right)','Formale Gleichung aus Abschnitt 3.2.43: Transformation der Zeitkoordinate.','definition'),
('3.3082','Transformation der x-Koordinate','x''=\\gamma\\left(x-\\beta ct\\right)','x''=\\gamma\\left(x-\\beta ct\\right)','Formale Gleichung aus Abschnitt 3.2.43: Transformation der x-Koordinate.','definition'),
('3.3083','Unveränderte y-Koordinate','y''=y','y''=y','Formale Gleichung aus Abschnitt 3.2.43: Unveränderte y-Koordinate.','definition'),
('3.3084','Unveränderte z-Koordinate','z''=z','z''=z','Formale Gleichung aus Abschnitt 3.2.43: Unveränderte z-Koordinate.','definition'),
('3.3085','Geschwindigkeitsparameter','\\beta=\\frac{v}{c}','\\beta=\\frac{v}{c}','Formale Gleichung aus Abschnitt 3.2.43: Geschwindigkeitsparameter.','definition'),
('3.3086','Lorentz-Transformation der Ortskoordinate','x''=\\gamma(x-vt)','x''=\\gamma(x-vt)','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Transformation der Ortskoordinate.','definition'),
('3.3087','Lorentz-Transformation der Zeitkoordinate','t''=\\gamma\\left(t-\\frac{vx}{c^2}\\right)','t''=\\gamma\\left(t-\\frac{vx}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Transformation der Zeitkoordinate.','definition'),
('3.3088','Matrixwirkung auf den Vierervektor','x''^\\mu=\\Lambda^\\mu{}_{\\nu}x^\\nu','x''^\\mu=\\Lambda^\\mu{}_{\\nu}x^\\nu','Formale Gleichung aus Abschnitt 3.2.43: Matrixwirkung auf den Vierervektor.','definition'),
('3.3089','Lorentz-Boostmatrix','\\Lambda=\\begin{pmatrix}\\gamma&-\\beta\\gamma&0&0\\\\-\\beta\\gamma&\\gamma&0&0\\\\0&0&1&0\\\\0&0&0&1\\end{pmatrix}','\\Lambda=\\begin{pmatrix}\\gamma&-\\beta\\gamma&0&0\\-\\beta\\gamma&\\gamma&0&0\\0&0&1&0\\0&0&0&1\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Boostmatrix.','definition'),
('3.3090','Distributivität der Lorentz-Matrix','\\Lambda(au+bv)=\\Lambda(au)+\\Lambda(bv)','\\Lambda(au+bv)=\\Lambda(au)+\\Lambda(bv)','Formale Gleichung aus Abschnitt 3.2.43: Distributivität der Lorentz-Matrix.','derived'),
('3.3091','Homogenität im ersten Summanden','\\Lambda(au)=a\\Lambda u','\\Lambda(au)=a\\Lambda u','Formale Gleichung aus Abschnitt 3.2.43: Homogenität im ersten Summanden.','derived'),
('3.3092','Homogenität im zweiten Summanden','\\Lambda(bv)=b\\Lambda v','\\Lambda(bv)=b\\Lambda v','Formale Gleichung aus Abschnitt 3.2.43: Homogenität im zweiten Summanden.','derived'),
('3.3093','Linearitätsgleichung','\\Lambda(au+bv)=a\\Lambda u+b\\Lambda v','\\Lambda(au+bv)=a\\Lambda u+b\\Lambda v','Formale Gleichung aus Abschnitt 3.2.43: Linearitätsgleichung.','theorem'),
('3.3094','Vorzeichenwechsel der Geschwindigkeit','v\\rightarrow-v','v\\rightarrow-v','Formale Gleichung aus Abschnitt 3.2.43: Vorzeichenwechsel der Geschwindigkeit.','definition'),
('3.3095','Inverse Ortskoordinate','x=\\gamma(x''+vt'')','x=\\gamma(x''+vt'')','Formale Gleichung aus Abschnitt 3.2.43: Inverse Ortskoordinate.','definition'),
('3.3096','Inverse Zeitkoordinate','t=\\gamma\\left(t''+\\frac{vx''}{c^2}\\right)','t=\\gamma\\left(t''+\\frac{vx''}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43: Inverse Zeitkoordinate.','definition'),
('3.3097','Inverse Lorentz-Matrix','\\Lambda^{-1}(v)=\\Lambda(-v)','\\Lambda^{-1}(v)=\\Lambda(-v)','Formale Gleichung aus Abschnitt 3.2.43: Inverse Lorentz-Matrix.','theorem'),
('3.3098','Linksinverse Lorentz-Transformation','\\Lambda(-v)\\Lambda(v)=I','\\Lambda(-v)\\Lambda(v)=I','Formale Gleichung aus Abschnitt 3.2.43: Linksinverse Lorentz-Transformation.','derived'),
('3.3099','Rechtsinverse Lorentz-Transformation','\\Lambda(v)\\Lambda(-v)=I','\\Lambda(v)\\Lambda(-v)=I','Formale Gleichung aus Abschnitt 3.2.43: Rechtsinverse Lorentz-Transformation.','derived'),
('3.3100','Minkowski-Raumzeitintervall','ds^2=-c^2dt^2+dx^2+dy^2+dz^2','ds^2=-c^2dt^2+dx^2+dy^2+dz^2','Formale Gleichung aus Abschnitt 3.2.43: Minkowski-Raumzeitintervall.','metric'),
('3.3101','Tensorform des Raumzeitintervalls','ds^2=\\eta_{\\mu\\nu}dx^\\mu dx^\\nu','ds^2=\\eta_{\\mu\\nu}dx^\\mu dx^\\nu','Formale Gleichung aus Abschnitt 3.2.43: Tensorform des Raumzeitintervalls.','metric'),
('3.3102','Lorentz-Invarianz des Intervalls','ds''^2=ds^2','ds''^2=ds^2','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Invarianz des Intervalls.','theorem'),
('3.3103','Metrische Erhaltungsbedingung','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta','Formale Gleichung aus Abschnitt 3.2.43: Metrische Erhaltungsbedingung.','definition'),
('3.3104','Differential der Ortskoordinate','dx''=\\gamma(dx-vdt)','dx''=\\gamma(dx-vdt)','Formale Gleichung aus Abschnitt 3.2.43: Differential der Ortskoordinate.','derived'),
('3.3105','Differential der Zeitkoordinate','dt''=\\gamma\\left(dt-\\frac{v}{c^2}dx\\right)','dt''=\\gamma\\left(dt-\\frac{v}{c^2}dx\\right)','Formale Gleichung aus Abschnitt 3.2.43: Differential der Zeitkoordinate.','derived'),
('3.3106','Einsetzen in das zweidimensionale Intervall','-c^2dt''^2+dx''^2=-c^2\\gamma^2\\left(dt-\\frac{v}{c^2}dx\\right)^2+\\gamma^2(dx-vdt)^2','-c^2dt''^2+dx''^2=-c^2\\gamma^2\\left(dt-\\frac{v}{c^2}dx\\right)^2+\\gamma^2(dx-vdt)^2','Formale Gleichung aus Abschnitt 3.2.43: Einsetzen in das zweidimensionale Intervall.','derived'),
('3.3107','Zusammengefasste Intervalltransformation','-c^2dt''^2+dx''^2=\\gamma^2\\left(1-\\frac{v^2}{c^2}\\right)\\left(-c^2dt^2+dx^2\\right)','-c^2dt''^2+dx''^2=\\gamma^2\\left(1-\\frac{v^2}{c^2}\\right)\\left(-c^2dt^2+dx^2\\right)','Formale Gleichung aus Abschnitt 3.2.43: Zusammengefasste Intervalltransformation.','derived'),
('3.3108','Lorentz-Faktor im Invarianzbeweis','\\gamma=\\frac{1}{\\sqrt{1-\\frac{v^2}{c^2}}}','\\gamma=\\frac{1}{\\sqrt{1-\\frac{v^2}{c^2}}}','Formale Gleichung aus Abschnitt 3.2.43: Lorentz-Faktor im Invarianzbeweis.','derived'),
('3.3109','Normierungsidentität des Lorentz-Faktors','\\gamma^2\\left(1-\\frac{v^2}{c^2}\\right)=1','\\gamma^2\\left(1-\\frac{v^2}{c^2}\\right)=1','Formale Gleichung aus Abschnitt 3.2.43: Normierungsidentität des Lorentz-Faktors.','derived'),
('3.3110','Invarianz des tx-Teilintervalls','-c^2dt''^2+dx''^2=-c^2dt^2+dx^2','-c^2dt''^2+dx''^2=-c^2dt^2+dx^2','Formale Gleichung aus Abschnitt 3.2.43: Invarianz des tx-Teilintervalls.','theorem'),
('3.3111','Differentialinvarianz der y-Koordinate','dy''=dy','dy''=dy','Formale Gleichung aus Abschnitt 3.2.43: Differentialinvarianz der y-Koordinate.','derived'),
('3.3112','Differentialinvarianz der z-Koordinate','dz''=dz','dz''=dz','Formale Gleichung aus Abschnitt 3.2.43: Differentialinvarianz der z-Koordinate.','derived'),
('3.3113','Vollständige Invarianz des Minkowski-Intervalls','-c^2dt''^2+dx''^2+dy''^2+dz''^2=-c^2dt^2+dx^2+dy^2+dz^2','-c^2dt''^2+dx''^2+dy''^2+dz''^2=-c^2dt^2+dx^2+dy^2+dz^2','Formale Gleichung aus Abschnitt 3.2.43: Vollständige Invarianz des Minkowski-Intervalls.','theorem'),
('3.3114','Definitionsbedingung einer Lorentz-Matrix','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta','\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta','Formale Gleichung aus Abschnitt 3.2.43: Definitionsbedingung einer Lorentz-Matrix.','definition'),
('3.3115','Definition der Lorentz-Gruppe','O(1,3)=\\left\\{\\Lambda\\in GL(4,\\mathbb R)\\mid\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta\\right\\}','O(1,3)=\\left\\{\\Lambda\\in GL(4,\\mathbb R)\\mid\\Lambda^{\\mathrm T}\\eta\\Lambda=\\eta\\right\\}','Formale Gleichung aus Abschnitt 3.2.43: Definition der Lorentz-Gruppe.','definition');
INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT equation_number,@section,title,equation_latex,word_latex,plain_description,equation_type,'literature',@src117,'Im Text von Abschnitt 3.2.43 eingeführt, verwendet oder hergeleitet.','Voraussetzungen gemäß Abschnitt 3.2.43.','verified',@revision FROM tmp_eqs_3243 t WHERE NOT EXISTS(SELECT 1 FROM equations e WHERE e.equation_number=t.equation_number);
UPDATE equations e JOIN tmp_eqs_3243 t ON t.equation_number=e.equation_number SET e.section_id=@section,e.title=t.title,e.equation_latex=t.equation_latex,e.word_latex=t.word_latex,e.plain_description=t.plain_description,e.equation_type=t.equation_type,e.provenance='literature',e.source_id=@src117,e.derivation='Im Text von Abschnitt 3.2.43 eingeführt, verwendet oder hergeleitet.',e.assumptions='Voraussetzungen gemäß Abschnitt 3.2.43.',e.validation_status='verified',e.created_revision_id=COALESCE(e.created_revision_id,@revision);

INSERT INTO section_change_log(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision,@section,'created','section','3.2.43','Abschnitt 3.2.43 vollständig in das Repository aufgenommen.',NULL,'15 Definitionen, 4 Sätze, 50 Gleichungen und Literaturstelle [117].' WHERE NOT EXISTS(SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section AND object_reference='3.2.43');

INSERT INTO repository_counters(counter_key,counter_value) VALUES
('last_completed_section','3.2.43'),('current_section','3.2.44'),('last_definition_number','3.2.652'),('next_definition_number','3.2.653'),('last_theorem_number','3.2.148'),('next_theorem_number','3.2.149'),('last_equation_number','3.3115'),('next_equation_number','3.3116'),('last_citation_number','117'),('next_citation_number','118')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3243; DROP TEMPORARY TABLE IF EXISTS tmp_thms_3243; DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3243;
COMMIT;

SELECT section_id,section_code,title,status FROM dissertation_sections WHERE section_code='3.2.43';
SELECT COUNT(*) AS definitionen_3_2_43 FROM definitions WHERE section_id=@section AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED) BETWEEN 638 AND 652;
SELECT COUNT(*) AS saetze_3_2_43 FROM theorems WHERE section_id=@section AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED) BETWEEN 145 AND 148;
SELECT COUNT(*) AS gleichungen_3_2_43 FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 3066 AND 3115;
SELECT COUNT(*) AS fehlende_word_latex FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 3066 AND 3115 AND (word_latex IS NULL OR TRIM(word_latex)='');
SELECT s.citation_number,s.short_citation_text,s.verification_status,su.usage_type,su.exact_location,su.citation_checked FROM source_usage su JOIN sources s ON s.source_id=su.source_id WHERE su.section_id=@section ORDER BY s.citation_number;
SELECT counter_key,counter_value FROM repository_counters WHERE counter_key IN('last_completed_section','current_section','last_definition_number','next_definition_number','last_theorem_number','next_theorem_number','last_equation_number','next_equation_number','last_citation_number','next_citation_number') ORDER BY counter_key;

-- ================= ENDE 3.2.43.1–3.2.43.4 =================

-- =================== BEGINN 3.2.43.5 ===================
USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – Ergänzung zu Abschnitt 3.2.43
   Unterabschnitt 3.2.43.5:
   Kausalstruktur und Klassifikation raumzeitlicher Intervalle

   Definitionen : 3.2.653–3.2.662
   Sätze        : 3.2.149–3.2.150
   Gleichungen  : (3.3116)–(3.3153)
   Literatur    : weiterhin [117]

   Voraussetzung:
   Das korrigierte Basisskript für 3.2.43 bis Gleichung (3.3115)
   wurde bereits importiert.
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43'
    ORDER BY revision_id DESC
    LIMIT 1
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.43'
    LIMIT 1
);

SET @src117 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=117
    LIMIT 1
);

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_frzk_check_32435_prerequisites$$
CREATE PROCEDURE sp_frzk_check_32435_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Eine Revision für Abschnitt 3.2.43 fehlt.';
    END IF;

    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;

    IF @src117 IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Literaturquelle [117] fehlt.';
    END IF;
END$$

CALL sp_frzk_check_32435_prerequisites()$$
DROP PROCEDURE sp_frzk_check_32435_prerequisites$$

DELIMITER ;

INSERT INTO repository_revisions
(
    revision_code,revision_date,scope_type,scope_reference,
    version_label,summary,created_by,parent_revision_id
)
VALUES
(
    'RKB-NEU-K3.2.43.5-V1',
    NOW(),
    'subsection',
    '3.2.43.5',
    '3.2.43.5-v1',
    'Kausalstruktur, Intervallklassen, Eigenzeit, Lichtkegel und Erhaltung der kausalen Ordnung.',
    'Olaf Thiele / ChatGPT',
    @parent_revision
)
ON DUPLICATE KEY UPDATE
    revision_id=LAST_INSERT_ID(revision_id),
    revision_date=VALUES(revision_date),
    summary=VALUES(summary),
    parent_revision_id=VALUES(parent_revision_id);

SET @revision := LAST_INSERT_ID();

UPDATE dissertation_sections
SET
    status='in_progress',
    notes=CONCAT(
        COALESCE(notes,''),
        CASE WHEN COALESCE(notes,'')='' THEN '' ELSE ' ' END,
        'Ergänzt um 3.2.43.5: Kausalstruktur und Klassifikation raumzeitlicher Intervalle.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.5:%';

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.653–3.2.662
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32435;
CREATE TEMPORARY TABLE tmp_defs_32435
(
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_32435 VALUES
('3.2.653','Zeitartiges Intervall','Ein Raumzeitintervall heißt zeitartig, wenn sein Minkowski-Quadrat negativ ist.','\\Delta s^2<0','\\Delta s^2<0'),
('3.2.654','Raumartiges Intervall','Ein Raumzeitintervall heißt raumartig, wenn sein Minkowski-Quadrat positiv ist.','\\Delta s^2>0','\\Delta s^2>0'),
('3.2.655','Lichtartiges Intervall','Ein Raumzeitintervall heißt lichtartig oder nullartig, wenn sein Minkowski-Quadrat null ist.','\\Delta s^2=0','\\Delta s^2=0'),
('3.2.656','Räumlicher Abstand','Der räumliche Abstand zweier Ereignisse ist die euklidische Norm ihrer räumlichen Koordinatendifferenz.','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}'),
('3.2.657','Eigenzeit','Für zwei zeitartig getrennte Ereignisse ist die Eigenzeit durch das negative Minkowski-Quadrat des Intervalls definiert.','c^2\\Delta\\tau^2=-\\Delta s^2','c^2\\Delta\\tau^2=-\\Delta s^2'),
('3.2.658','Eigenzeit bei gleichförmiger Bewegung','Bei gleichförmiger Bewegung mit konstanter Geschwindigkeit v gilt Delta t = gamma Delta tau.','\\Delta t=\\gamma\\Delta\\tau','\\Delta t=\\gamma\\Delta\\tau'),
('3.2.659','Lichtkegel','Die Menge aller lichtartig vom Ursprung getrennten Ereignisse wird als Lichtkegel bezeichnet.','c^2t^2=x^2+y^2+z^2','c^2t^2=x^2+y^2+z^2'),
('3.2.660','Zukunftslichtkegel','Der Zukunftslichtkegel umfasst alle zeitartigen oder lichtartigen Ereignisse, die zeitlich nach dem Ausgangsereignis liegen.','t>0,\\qquad r\\leq ct','t>0,\\qquad r\\leq ct'),
('3.2.661','Vergangenheitslichtkegel','Der Vergangenheitslichtkegel umfasst alle zeitartigen oder lichtartigen Ereignisse, die zeitlich vor dem Ausgangsereignis liegen.','t<0,\\qquad r\\leq c|t|','t<0,\\qquad r\\leq c|t|'),
('3.2.662','Kausal nicht erreichbarer Bereich','Alle Ereignisse außerhalb des Lichtkegels sind vom Ursprung raumartig getrennt und kausal nicht erreichbar.','r>c|t|','r>c|t|');

INSERT INTO definitions
(
    definition_number,section_id,title,definition_text,
    formal_latex,word_latex,provenance,source_id,
    assumptions,notes,validation_status,created_revision_id
)
SELECT
    t.definition_number,@section,t.title,t.definition_text,
    t.formal_latex,t.word_latex,'literature',@src117,
    'Minkowski-Raum mit Signatur (-,+,+,+) und Lorentz-Invarianz gemäß Abschnitt 3.2.43.',
    'Definition aus Unterabschnitt 3.2.43.5.',
    'verified',@revision
FROM tmp_defs_32435 t
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_32435 t
    ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src117,
    d.assumptions='Minkowski-Raum mit Signatur (-,+,+,+) und Lorentz-Invarianz gemäß Abschnitt 3.2.43.',
    d.notes='Definition aus Unterabschnitt 3.2.43.5.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.149–3.2.150
-- Schemahinweis: Die Tabelle `theorems` besitzt kein Feld `proof_text`.
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_thms_32435;
CREATE TEMPORARY TABLE tmp_thms_32435
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_32435 VALUES
('3.2.149','Lorentz-Invarianz der Intervallklasse','Die Einordnung eines Raumzeitintervalls als zeitartig, raumartig oder lichtartig bleibt unter jeder Lorentz-Transformation erhalten.','\\Delta s''^2=\\Delta s^2'),
('3.2.150','Erhaltung der kausalen Ordnung zeitartig getrennter Ereignisse','Die zeitliche Reihenfolge zweier zeitartig getrennter Ereignisse bleibt unter eigentlichen, orthochronen Lorentz-Transformationen erhalten.','\\operatorname{sgn}(\\Delta t'')=\\operatorname{sgn}(\\Delta t)');

INSERT INTO theorems
(
    theorem_number,section_id,title,statement_text,
    statement_latex,word_latex,provenance,source_id,
    assumptions,validation_status,created_revision_id
)
SELECT
    t.theorem_number,@section,t.title,t.statement_text,
    t.statement_latex,t.statement_latex,'literature',@src117,
    'Lorentz-Invarianz des Minkowski-Intervalls; für Satz 3.2.150 zusätzlich eigentliche orthochrone Lorentz-Transformation.',
    'verified',@revision
FROM tmp_thms_32435 t
WHERE NOT EXISTS
(
    SELECT 1 FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_32435 t
    ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src117,
    th.assumptions='Lorentz-Invarianz des Minkowski-Intervalls; für Satz 3.2.150 zusätzlich eigentliche orthochrone Lorentz-Transformation.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3116)–(3.3153)
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32435;
CREATE TEMPORARY TABLE tmp_eqs_32435
(
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM(
        'definition','axiom','theorem','lemma','derived',
        'schema','model','metric','other'
    ) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_32435 VALUES
('3.3116','Differenzvektor zweier Ereignisse','\\Delta x^\\mu=x_Q^\\mu-x_P^\\mu','\\Delta x^\\mu=x_Q^\\mu-x_P^\\mu','Formale Gleichung aus Abschnitt 3.2.43.5: Differenzvektor zweier Ereignisse.','definition'),
('3.3117','Komponenten des Differenzvektors','\\Delta x^\\mu=\\begin{pmatrix}c\\Delta t\\\\\\Delta x\\\\\\Delta y\\\\\\Delta z\\end{pmatrix}','\\Delta x^\\mu=\\begin{pmatrix}c\\Delta t\\Delta x\\Delta y\\Delta z\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.5: Komponenten des Differenzvektors.','definition'),
('3.3118','Minkowski-Quadrat des Differenzvektors','\\Delta s^2=-c^2\\Delta t^2+\\Delta x^2+\\Delta y^2+\\Delta z^2','\\Delta s^2=-c^2\\Delta t^2+\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Minkowski-Quadrat des Differenzvektors.','metric'),
('3.3119','Minkowski-Signatur','\\eta=\\operatorname{diag}(-1,1,1,1)','\\eta=\\operatorname{diag}(-1,1,1,1)','Formale Gleichung aus Abschnitt 3.2.43.5: Minkowski-Signatur.','definition'),
('3.3120','Bedingung für ein zeitartiges Intervall','\\Delta s^2<0','\\Delta s^2<0','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung für ein zeitartiges Intervall.','definition'),
('3.3121','Äquivalente Zeitartigkeitsbedingung','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Äquivalente Zeitartigkeitsbedingung.','derived'),
('3.3122','Bedingung für ein raumartiges Intervall','\\Delta s^2>0','\\Delta s^2>0','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung für ein raumartiges Intervall.','definition'),
('3.3123','Äquivalente Raumartigkeitsbedingung','\\Delta x^2+\\Delta y^2+\\Delta z^2>c^2\\Delta t^2','\\Delta x^2+\\Delta y^2+\\Delta z^2>c^2\\Delta t^2','Formale Gleichung aus Abschnitt 3.2.43.5: Äquivalente Raumartigkeitsbedingung.','derived'),
('3.3124','Bedingung für ein lichtartiges Intervall','\\Delta s^2=0','\\Delta s^2=0','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung für ein lichtartiges Intervall.','definition'),
('3.3125','Äquivalente Lichtartigkeitsbedingung','c^2\\Delta t^2=\\Delta x^2+\\Delta y^2+\\Delta z^2','c^2\\Delta t^2=\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Äquivalente Lichtartigkeitsbedingung.','derived'),
('3.3126','Räumlicher Abstand','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}','Formale Gleichung aus Abschnitt 3.2.43.5: Räumlicher Abstand.','definition'),
('3.3127','Kompakte Intervallform','\\Delta s^2=\\Delta r^2-c^2\\Delta t^2','\\Delta s^2=\\Delta r^2-c^2\\Delta t^2','Formale Gleichung aus Abschnitt 3.2.43.5: Kompakte Intervallform.','metric'),
('3.3128','Invarianz des Differenzintervalls','\\Delta s''^2=\\Delta s^2','\\Delta s''^2=\\Delta s^2','Formale Gleichung aus Abschnitt 3.2.43.5: Invarianz des Differenzintervalls.','theorem'),
('3.3129','Zeitartigkeit im Ausgangssystem','\\Delta s^2<0','\\Delta s^2<0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitartigkeit im Ausgangssystem.','derived'),
('3.3130','Zeitartigkeit im transformierten System','\\Delta s''^2<0','\\Delta s''^2<0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitartigkeit im transformierten System.','derived'),
('3.3131','Erhaltung der Raumartigkeit','\\Delta s^2>0\\Longrightarrow\\Delta s''^2>0','\\Delta s^2>0\\Longrightarrow\\Delta s''^2>0','Formale Gleichung aus Abschnitt 3.2.43.5: Erhaltung der Raumartigkeit.','theorem'),
('3.3132','Erhaltung der Lichtartigkeit','\\Delta s^2=0\\Longrightarrow\\Delta s''^2=0','\\Delta s^2=0\\Longrightarrow\\Delta s''^2=0','Formale Gleichung aus Abschnitt 3.2.43.5: Erhaltung der Lichtartigkeit.','theorem'),
('3.3133','Definition der Eigenzeit','c^2\\Delta\\tau^2=-\\Delta s^2','c^2\\Delta\\tau^2=-\\Delta s^2','Formale Gleichung aus Abschnitt 3.2.43.5: Definition der Eigenzeit.','definition'),
('3.3134','Eigenzeit in Koordinatendifferenzen','c^2\\Delta\\tau^2=c^2\\Delta t^2-\\Delta x^2-\\Delta y^2-\\Delta z^2','c^2\\Delta\\tau^2=c^2\\Delta t^2-\\Delta x^2-\\Delta y^2-\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Eigenzeit in Koordinatendifferenzen.','derived'),
('3.3135','Quadrat der Eigenzeit','\\Delta\\tau^2=\\Delta t^2-\\frac{\\Delta x^2+\\Delta y^2+\\Delta z^2}{c^2}','\\Delta\\tau^2=\\Delta t^2-\\frac{\\Delta x^2+\\Delta y^2+\\Delta z^2}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.5: Quadrat der Eigenzeit.','derived'),
('3.3136','Räumliche Wegdifferenz bei gleichförmiger Bewegung','\\Delta r=v\\Delta t','\\Delta r=v\\Delta t','Formale Gleichung aus Abschnitt 3.2.43.5: Räumliche Wegdifferenz bei gleichförmiger Bewegung.','definition'),
('3.3137','Einsetzen der gleichförmigen Bewegung','\\Delta\\tau^2=\\Delta t^2-\\frac{v^2\\Delta t^2}{c^2}','\\Delta\\tau^2=\\Delta t^2-\\frac{v^2\\Delta t^2}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.5: Einsetzen der gleichförmigen Bewegung.','derived'),
('3.3138','Ausgeklammerte Eigenzeitbeziehung','\\Delta\\tau^2=\\Delta t^2\\left(1-\\frac{v^2}{c^2}\\right)','\\Delta\\tau^2=\\Delta t^2\\left(1-\\frac{v^2}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43.5: Ausgeklammerte Eigenzeitbeziehung.','derived'),
('3.3139','Eigenzeit-Zeit-Beziehung','\\Delta\\tau=\\Delta t\\sqrt{1-\\frac{v^2}{c^2}}','\\Delta\\tau=\\Delta t\\sqrt{1-\\frac{v^2}{c^2}}','Formale Gleichung aus Abschnitt 3.2.43.5: Eigenzeit-Zeit-Beziehung.','derived'),
('3.3140','Zeitdilatationsform','\\Delta t=\\gamma\\Delta\\tau','\\Delta t=\\gamma\\Delta\\tau','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitdilatationsform.','theorem'),
('3.3141','Gleichung des Lichtkegels','c^2t^2=x^2+y^2+z^2','c^2t^2=x^2+y^2+z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Gleichung des Lichtkegels.','definition'),
('3.3142','Radiale Lichtkegelgleichung','r=c|t|','r=c|t|','Formale Gleichung aus Abschnitt 3.2.43.5: Radiale Lichtkegelgleichung.','derived'),
('3.3143','Zeitbedingung des Zukunftslichtkegels','t>0','t>0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitbedingung des Zukunftslichtkegels.','definition'),
('3.3144','Räumliche Bedingung des Zukunftslichtkegels','r\\leq ct','r\\leq ct','Formale Gleichung aus Abschnitt 3.2.43.5: Räumliche Bedingung des Zukunftslichtkegels.','definition'),
('3.3145','Zeitbedingung des Vergangenheitslichtkegels','t<0','t<0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitbedingung des Vergangenheitslichtkegels.','definition'),
('3.3146','Räumliche Bedingung des Vergangenheitslichtkegels','r\\leq c|t|','r\\leq c|t|','Formale Gleichung aus Abschnitt 3.2.43.5: Räumliche Bedingung des Vergangenheitslichtkegels.','definition'),
('3.3147','Bedingung des kausal nicht erreichbaren Bereichs','r>c|t|','r>c|t|','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung des kausal nicht erreichbaren Bereichs.','definition'),
('3.3148','Zeitartigkeitsbedingung im Ordnungsbeweis','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitartigkeitsbedingung im Ordnungsbeweis.','derived'),
('3.3149','Abschätzung der longitudinalen Trennung','c|\\Delta t|>|\\Delta x|','c|\\Delta t|>|\\Delta x|','Formale Gleichung aus Abschnitt 3.2.43.5: Abschätzung der longitudinalen Trennung.','derived'),
('3.3150','Transformierte Zeitdifferenz','\\Delta t''=\\gamma\\left(\\Delta t-\\frac{v\\Delta x}{c^2}\\right)','\\Delta t''=\\gamma\\left(\\Delta t-\\frac{v\\Delta x}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43.5: Transformierte Zeitdifferenz.','derived'),
('3.3151','Abschätzung des Korrekturterms','\\left|\\frac{v\\Delta x}{c^2}\\right|<\\frac{|\\Delta x|}{c}','\\left|\\frac{v\\Delta x}{c^2}\\right|<\\frac{|\\Delta x|}{c}','Formale Gleichung aus Abschnitt 3.2.43.5: Abschätzung des Korrekturterms.','derived'),
('3.3152','Vergleich mit der Zeitdifferenz','\\frac{|\\Delta x|}{c}<|\\Delta t|','\\frac{|\\Delta x|}{c}<|\\Delta t|','Formale Gleichung aus Abschnitt 3.2.43.5: Vergleich mit der Zeitdifferenz.','derived'),
('3.3153','Positivität des Lorentz-Faktors','\\gamma>0','\\gamma>0','Formale Gleichung aus Abschnitt 3.2.43.5: Positivität des Lorentz-Faktors.','derived');

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    t.equation_number,@section,t.title,t.equation_latex,t.word_latex,
    t.plain_description,t.equation_type,'literature',@src117,
    'Im Unterabschnitt 3.2.43.5 eingeführt oder hergeleitet.',
    'Minkowski-Raum mit Signatur (-,+,+,+), Lorentz-Invarianz und |v|<c.',
    'verified',@revision
FROM tmp_eqs_32435 t
WHERE NOT EXISTS
(
    SELECT 1 FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_32435 t
    ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src117,
    e.derivation='Im Unterabschnitt 3.2.43.5 eingeführt oder hergeleitet.',
    e.assumptions='Minkowski-Raum mit Signatur (-,+,+,+), Lorentz-Invarianz und |v|<c.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Literaturverwendung
-- ---------------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    @src117,@section,'supporting_citation',
    'Intervallklassen, Eigenzeit, Lichtkegel und kausale Ordnung unter Lorentz-Transformationen.',
    'Abschnitt 3.2.43.5',
    0,0,
    'Quelle [117] bleibt die verwendete Primärquelle; genaue Seitenangabe vor Endredaktion prüfen.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id=@src117
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.5'
);

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll und Zähler
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,
    object_reference,change_summary,previous_value,new_value
)
SELECT
    @revision,@section,'updated','subsection','3.2.43.5',
    'Unterabschnitt 3.2.43.5 in das Repository aufgenommen.',
    'Stand bis Gleichung (3.3115).',
    'Zusätzlich 10 Definitionen, 2 Sätze und 38 Gleichungen bis (3.3153).'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.5'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.43.5'),
('current_section','3.2.43.6'),
('last_definition_number','3.2.662'),
('next_definition_number','3.2.663'),
('last_theorem_number','3.2.150'),
('next_theorem_number','3.2.151'),
('last_equation_number','3.3153'),
('next_equation_number','3.3154'),
('last_citation_number','117'),
('next_citation_number','118')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32435;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32435;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32435;

COMMIT;

-- ---------------------------------------------------------------------------
-- Abschlussprüfung
-- Erwartet für 3.2.43.5:
-- 10 Definitionen, 2 Sätze, 38 Gleichungen, keine leeren Word-LaTeX-Felder.
-- Gesamtstand 3.2.43:
-- 25 Definitionen, 6 Sätze, 88 Gleichungen.
-- ---------------------------------------------------------------------------

SELECT COUNT(*) AS definitionen_3_2_43_5
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 653 AND 662;

SELECT COUNT(*) AS saetze_3_2_43_5
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 149 AND 150;

SELECT COUNT(*) AS gleichungen_3_2_43_5
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3116 AND 3153;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_5
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3116 AND 3153
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT
    (SELECT COUNT(*) FROM definitions
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
           BETWEEN 638 AND 662) AS definitionen_gesamt_3_2_43,
    (SELECT COUNT(*) FROM theorems
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
           BETWEEN 145 AND 150) AS saetze_gesamt_3_2_43,
    (SELECT COUNT(*) FROM equations
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
           BETWEEN 3066 AND 3153) AS gleichungen_gesamt_3_2_43;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_completed_section','current_section',
    'last_definition_number','next_definition_number',
    'last_theorem_number','next_theorem_number',
    'last_equation_number','next_equation_number',
    'last_citation_number','next_citation_number'
)
ORDER BY counter_key;

-- ==================== ENDE 3.2.43.5 ====================

-- =================== BEGINN 3.2.43.6 ===================

USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – Ergänzung zu Abschnitt 3.2.43
   Unterabschnitt 3.2.43.6:
   Zeitdilatation, Längenkontraktion und Relativität der Gleichzeitigkeit

   Definitionen : 3.2.663–3.2.667
   Sätze        : 3.2.151–3.2.153
   Gleichungen  : (3.3154)–(3.3175)
   Literatur    : weiterhin [117]
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43.5'
    ORDER BY revision_id DESC
    LIMIT 1
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.43'
    LIMIT 1
);

SET @src117 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=117
    LIMIT 1
);

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_frzk_check_32436_prerequisites$$
CREATE PROCEDURE sp_frzk_check_32436_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für Abschnitt 3.2.43.5 fehlt.';
    END IF;
    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
    IF @src117 IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Literaturquelle [117] fehlt.';
    END IF;
END$$

CALL sp_frzk_check_32436_prerequisites()$$
DROP PROCEDURE sp_frzk_check_32436_prerequisites$$

DELIMITER ;

INSERT INTO repository_revisions
(
    revision_code,revision_date,scope_type,scope_reference,
    version_label,summary,created_by,parent_revision_id
)
VALUES
(
    'RKB-NEU-K3.2.43.6-V1',
    NOW(),
    'subsection',
    '3.2.43.6',
    '3.2.43.6-v1',
    'Zeitdilatation, Längenkontraktion und Relativität der Gleichzeitigkeit.',
    'Olaf Thiele / ChatGPT',
    @parent_revision
)
ON DUPLICATE KEY UPDATE
    revision_id=LAST_INSERT_ID(revision_id),
    revision_date=VALUES(revision_date),
    summary=VALUES(summary),
    parent_revision_id=VALUES(parent_revision_id);

SET @revision := LAST_INSERT_ID();

UPDATE dissertation_sections
SET
    status='in_progress',
    notes=CONCAT(
        COALESCE(notes,''),
        CASE WHEN COALESCE(notes,'')='' THEN '' ELSE ' ' END,
        'Ergänzt um 3.2.43.6: Zeitdilatation, Längenkontraktion und Relativität der Gleichzeitigkeit.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.6:%';

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32436;
CREATE TEMPORARY TABLE tmp_defs_32436
(
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_32436 VALUES
('3.2.663','Ruhesystem einer Uhr','Das Ruhesystem einer Uhr ist dasjenige Inertialsystem, in dem sich die Uhr relativ zum Beobachter nicht bewegt.','\\Delta x''=0','\\Delta x''=0'),
('3.2.664','Eigenzeit einer ruhenden Uhr','Im Ruhesystem einer Uhr entspricht die dort gemessene Zeitdifferenz der Eigenzeit.','\\Delta t''=\\Delta\\tau','\\Delta t''=\\Delta\\tau'),
('3.2.665','Eigenlänge','Die Eigenlänge eines Körpers ist seine Länge im Ruhesystem des Körpers.','L_0','L_0'),
('3.2.666','Gleichzeitigkeit','Zwei Ereignisse heißen in einem Inertialsystem gleichzeitig, wenn ihre Zeitkoordinatendifferenz in diesem System null ist.','\\Delta t=0','\\Delta t=0'),
('3.2.667','Kinematische relativistische Effekte','Zeitdilatation, Längenkontraktion und Relativität der Gleichzeitigkeit werden gemeinsam als kinematische relativistische Effekte bezeichnet.',NULL,NULL);

INSERT INTO definitions
(
    definition_number,section_id,title,definition_text,
    formal_latex,word_latex,provenance,source_id,
    assumptions,notes,validation_status,created_revision_id
)
SELECT
    t.definition_number,@section,t.title,t.definition_text,
    t.formal_latex,t.word_latex,'literature',@src117,
    'Lorentz-Transformationen und Inertialsysteme gemäß Abschnitt 3.2.43.',
    'Definition aus Unterabschnitt 3.2.43.6.',
    'verified',@revision
FROM tmp_defs_32436 t
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_32436 t ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src117,
    d.assumptions='Lorentz-Transformationen und Inertialsysteme gemäß Abschnitt 3.2.43.',
    d.notes='Definition aus Unterabschnitt 3.2.43.6.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

DROP TEMPORARY TABLE IF EXISTS tmp_thms_32436;
CREATE TEMPORARY TABLE tmp_thms_32436
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_32436 VALUES
('3.2.151','Zeitdilatation','Eine bewegte Uhr vergeht gegenüber einem ruhenden Beobachter langsamer.','\\Delta t=\\gamma\\Delta\\tau'),
('3.2.152','Längenkontraktion','Ein relativ bewegter Körper erscheint in Bewegungsrichtung verkürzt.','L=\\frac{L_0}{\\gamma}'),
('3.2.153','Relativität der Gleichzeitigkeit','Gleichzeitigkeit ist keine Lorentz-invariante Eigenschaft.','\\Delta t=0,\\ \\Delta x\\neq0\\Longrightarrow\\Delta t''\\neq0');

INSERT INTO theorems
(
    theorem_number,section_id,title,statement_text,
    statement_latex,word_latex,provenance,source_id,
    assumptions,validation_status,created_revision_id
)
SELECT
    t.theorem_number,@section,t.title,t.statement_text,
    t.statement_latex,t.statement_latex,'literature',@src117,
    'Lorentz-Transformationen, Eigenzeit und Eigenlänge gemäß Abschnitt 3.2.43.',
    'verified',@revision
FROM tmp_thms_32436 t
WHERE NOT EXISTS
(
    SELECT 1 FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_32436 t ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src117,
    th.assumptions='Lorentz-Transformationen, Eigenzeit und Eigenlänge gemäß Abschnitt 3.2.43.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32436;
CREATE TEMPORARY TABLE tmp_eqs_32436
(
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM(
        'definition','axiom','theorem','lemma','derived',
        'schema','model','metric','other'
    ) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_32436 VALUES
('3.3154','Ruhebedingung einer Uhr','\\Delta x''=0','\\Delta x''=0','Formale Gleichung aus Abschnitt 3.2.43.6: Ruhebedingung einer Uhr.','definition'),
('3.3155','Eigenzeit im Ruhesystem','\\Delta t''=\\Delta\\tau','\\Delta t''=\\Delta\\tau','Formale Gleichung aus Abschnitt 3.2.43.6: Eigenzeit im Ruhesystem.','definition'),
('3.3156','Inverse Transformation der Zeitdifferenz','\\Delta t=\\gamma\\left(\\Delta t''+\\frac{v\\Delta x''}{c^2}\\right)','\\Delta t=\\gamma\\left(\\Delta t''+\\frac{v\\Delta x''}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43.6: Inverse Transformation der Zeitdifferenz.','derived'),
('3.3157','Ruhebedingung im Zeitdilatationsbeweis','\\Delta x''=0','\\Delta x''=0','Formale Gleichung aus Abschnitt 3.2.43.6: Ruhebedingung im Zeitdilatationsbeweis.','derived'),
('3.3158','Reduzierte Zeittransformation','\\Delta t=\\gamma\\Delta t''','\\Delta t=\\gamma\\Delta t''','Formale Gleichung aus Abschnitt 3.2.43.6: Reduzierte Zeittransformation.','derived'),
('3.3159','Identifikation der Eigenzeit','\\Delta t''=\\Delta\\tau','\\Delta t''=\\Delta\\tau','Formale Gleichung aus Abschnitt 3.2.43.6: Identifikation der Eigenzeit.','derived'),
('3.3160','Zeitdilatationsgleichung','\\Delta t=\\gamma\\Delta\\tau','\\Delta t=\\gamma\\Delta\\tau','Formale Gleichung aus Abschnitt 3.2.43.6: Zeitdilatationsgleichung.','theorem'),
('3.3161','Untere Schranke des Lorentz-Faktors','\\gamma\\geq1','\\gamma\\geq1','Formale Gleichung aus Abschnitt 3.2.43.6: Untere Schranke des Lorentz-Faktors.','derived'),
('3.3162','Vergleich von Koordinatenzeit und Eigenzeit','\\Delta t\\geq\\Delta\\tau','\\Delta t\\geq\\Delta\\tau','Formale Gleichung aus Abschnitt 3.2.43.6: Vergleich von Koordinatenzeit und Eigenzeit.','theorem'),
('3.3163','Symbol der Eigenlänge','L_0','L_0','Formale Gleichung aus Abschnitt 3.2.43.6: Symbol der Eigenlänge.','definition'),
('3.3164','Gleichzeitigkeitsbedingung der Längenmessung','\\Delta t=0','\\Delta t=0','Formale Gleichung aus Abschnitt 3.2.43.6: Gleichzeitigkeitsbedingung der Längenmessung.','definition'),
('3.3165','Transformierte Längendifferenz','\\Delta x''=\\gamma\\Delta x','\\Delta x''=\\gamma\\Delta x','Formale Gleichung aus Abschnitt 3.2.43.6: Transformierte Längendifferenz.','derived'),
('3.3166','Eigenlänge im Ruhesystem','\\Delta x''=L_0','\\Delta x''=L_0','Formale Gleichung aus Abschnitt 3.2.43.6: Eigenlänge im Ruhesystem.','definition'),
('3.3167','Längenkontraktionsgleichung','L=\\Delta x=\\frac{L_0}{\\gamma}','L=\\Delta x=\\frac{L_0}{\\gamma}','Formale Gleichung aus Abschnitt 3.2.43.6: Längenkontraktionsgleichung.','theorem'),
('3.3168','Lorentz-Faktor bei der Längenkontraktion','\\gamma\\geq1','\\gamma\\geq1','Formale Gleichung aus Abschnitt 3.2.43.6: Lorentz-Faktor bei der Längenkontraktion.','derived'),
('3.3169','Vergleich von bewegter Länge und Eigenlänge','L\\leq L_0','L\\leq L_0','Formale Gleichung aus Abschnitt 3.2.43.6: Vergleich von bewegter Länge und Eigenlänge.','theorem'),
('3.3170','Definition der Gleichzeitigkeit','\\Delta t=0','\\Delta t=0','Formale Gleichung aus Abschnitt 3.2.43.6: Definition der Gleichzeitigkeit.','definition'),
('3.3171','Transformation der Zeitdifferenz','\\Delta t''=\\gamma\\left(\\Delta t-\\frac{v\\Delta x}{c^2}\\right)','\\Delta t''=\\gamma\\left(\\Delta t-\\frac{v\\Delta x}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43.6: Transformation der Zeitdifferenz.','derived'),
('3.3172','Gleichzeitigkeit im Ausgangssystem','\\Delta t=0','\\Delta t=0','Formale Gleichung aus Abschnitt 3.2.43.6: Gleichzeitigkeit im Ausgangssystem.','derived'),
('3.3173','Zeitdifferenz im bewegten System','\\Delta t''=-\\gamma\\frac{v\\Delta x}{c^2}','\\Delta t''=-\\gamma\\frac{v\\Delta x}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.6: Zeitdifferenz im bewegten System.','derived'),
('3.3174','Räumliche Trennung gleichzeitiger Ereignisse','\\Delta x\\neq0','\\Delta x\\neq0','Formale Gleichung aus Abschnitt 3.2.43.6: Räumliche Trennung gleichzeitiger Ereignisse.','definition'),
('3.3175','Nichtgleichzeitigkeit im bewegten System','\\Delta t''\\neq0','\\Delta t''\\neq0','Formale Gleichung aus Abschnitt 3.2.43.6: Nichtgleichzeitigkeit im bewegten System.','theorem');

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    t.equation_number,@section,t.title,t.equation_latex,t.word_latex,
    t.plain_description,t.equation_type,'literature',@src117,
    'Im Unterabschnitt 3.2.43.6 eingeführt oder hergeleitet.',
    'Lorentz-Transformationen, |v|<c und die jeweilige Messbedingung.',
    'verified',@revision
FROM tmp_eqs_32436 t
WHERE NOT EXISTS
(
    SELECT 1 FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_32436 t ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src117,
    e.derivation='Im Unterabschnitt 3.2.43.6 eingeführt oder hergeleitet.',
    e.assumptions='Lorentz-Transformationen, |v|<c und die jeweilige Messbedingung.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    @src117,@section,'supporting_citation',
    'Zeitdilatation, Längenkontraktion und Relativität der Gleichzeitigkeit als Folgen der Lorentz-Transformation.',
    'Abschnitt 3.2.43.6',
    0,0,
    'Quelle [117] bleibt die verwendete Primärquelle; genaue Seitenangabe vor Endredaktion prüfen.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id=@src117
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.6'
);

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,
    object_reference,change_summary,previous_value,new_value
)
SELECT
    @revision,@section,'updated','subsection','3.2.43.6',
    'Unterabschnitt 3.2.43.6 in das Repository aufgenommen.',
    'Stand bis Gleichung (3.3153).',
    'Zusätzlich 5 Definitionen, 3 Sätze und 22 Gleichungen bis (3.3175).'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.6'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.43.6'),
('current_section','3.2.43.7'),
('last_definition_number','3.2.667'),
('next_definition_number','3.2.668'),
('last_theorem_number','3.2.153'),
('next_theorem_number','3.2.154'),
('last_equation_number','3.3175'),
('next_equation_number','3.3176'),
('last_citation_number','117'),
('next_citation_number','118')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32436;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32436;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32436;

COMMIT;

SELECT COUNT(*) AS definitionen_3_2_43_6
FROM definitions
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED) BETWEEN 663 AND 667;

SELECT COUNT(*) AS saetze_3_2_43_6
FROM theorems
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED) BETWEEN 151 AND 153;

SELECT COUNT(*) AS gleichungen_3_2_43_6
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 3154 AND 3175;

SELECT
    (SELECT COUNT(*) FROM definitions
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
           BETWEEN 638 AND 667) AS definitionen_gesamt_3_2_43,
    (SELECT COUNT(*) FROM theorems
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
           BETWEEN 145 AND 153) AS saetze_gesamt_3_2_43,
    (SELECT COUNT(*) FROM equations
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
           BETWEEN 3066 AND 3175) AS gleichungen_gesamt_3_2_43;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_completed_section','current_section',
    'last_definition_number','next_definition_number',
    'last_theorem_number','next_theorem_number',
    'last_equation_number','next_equation_number',
    'last_citation_number','next_citation_number'
)
ORDER BY counter_key;

-- ==================== ENDE 3.2.43.6 ====================
