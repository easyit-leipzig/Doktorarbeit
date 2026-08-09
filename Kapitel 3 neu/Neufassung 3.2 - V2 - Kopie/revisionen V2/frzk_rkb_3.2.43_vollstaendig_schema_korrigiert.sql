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
