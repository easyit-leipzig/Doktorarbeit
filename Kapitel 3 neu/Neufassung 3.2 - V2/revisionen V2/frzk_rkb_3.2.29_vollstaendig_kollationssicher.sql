-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.29
-- Graphentheorie, Netzwerke und diskrete Kopplungsoperatoren
-- Definitionen 3.2.395–3.2.449
-- Sätze 3.2.91–3.2.99
-- Gleichungen (3.2595)–(3.2744)
-- Literatur [100]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.29-V1',NOW(),'section','3.2.29','3.2.29-v1',
'Abschnitt 3.2.29 mit Definitionen 3.2.395–3.2.449, Sätzen 3.2.91–3.2.99, Gleichungen 3.2595–3.2744 und Literatur [100].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.29-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.29-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.29',
'Graphentheorie, Netzwerke und diskrete Kopplungsoperatoren',
3,3.2290,'final',0,
'Graphen, Adjazenz- und Laplace-Matrizen, Spektralstruktur, Diffusion, Konsens, Zufallswege, Zentralität, temporale und mehrschichtige Netzwerke sowie FRZK-Kopplungsgraphen.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.29' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.29' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Chung','Fan R. K.','Chung, Fan R. K.','Autorin der Quelle [100].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Chung, Fan R. K.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
100,'chung_spectral_graph_theory_1997','book',
'Spectral Graph Theory',
1997,1997,'American Mathematical Society','Providence, Rhode Island',NULL,NULL,'en',1,'monograph',10,'verified','3.2.29',
'Erstnennung für Graphen, Adjazenzmatrizen, Laplace-Matrizen, spektrale Zusammenhangsmaße, Zufallswege und graphbasierte Diffusionsoperatoren.',
'Chung, Fan R. K.: Spectral Graph Theory. Providence, Rhode Island: American Mathematical Society, 1997.',
'Chung, Spectral Graph Theory [100]',
'Zentrale Referenz für die graphentheoretischen und spektralen Grundlagen des Abschnitts.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=100
 OR source_key COLLATE utf8mb4_unicode_ci='chung_spectral_graph_theory_1997' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_98 := (SELECT source_id FROM sources WHERE citation_number=98 LIMIT 1);
SET @src_99 := (SELECT source_id FROM sources WHERE citation_number=99 LIMIT 1);
SET @src_100 := (SELECT source_id FROM sources WHERE citation_number=100 LIMIT 1);

SET @author_100 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Chung, Fan R. K.' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_100,@author_100,1,'author'
WHERE @src_100 IS NOT NULL AND @author_100 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_100 AND author_id=@author_100
);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_84,@src_98,@src_99,@src_100);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Matrizen, Eigenwerte, Rangbedingungen und lineare Operatoren.','3.2.29',0,1,'Wiederverwendung [84].',@revision),
(@src_98,@section,'background','Verbindung zwischen Zufallswegen, stochastischen Zuständen und zeitabhängigen Prozessen.','3.2.29',0,1,'Wiederverwendung [98].',@revision),
(@src_99,@section,'background','Informationsbezogene Interpretationen von Netzwerkpfaden, Übergängen und Beobachtungsstrukturen.','3.2.29',0,1,'Wiederverwendung [99].',@revision),
(@src_100,@section,'first_citation','Graphen, Adjazenz- und Laplace-Matrizen, Spektralstruktur, Zufallswege und Graphdiffusion.','3.2.29',1,1,'Erstnennung [100].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.395','Graph','Geordnetes Paar aus Knotenmenge und Kantenmenge.','G=(V,E)',@src_100),
('3.2.396','Ungerichteter Graph','Graph mit ungeordneten Knotenpaaren als Kanten.','E\\subseteq\\{\\{v_i,v_j\\}\\mid v_i,v_j\\in V\\}',@src_100),
('3.2.397','Gerichteter Graph','Graph mit geordneten Knotenpaaren als Kanten.','E\\subseteq V\\times V',@src_100),
('3.2.398','Einfacher Graph','Graph ohne Mehrfachkanten und Schleifen.','\\{v_i,v_i\\}\\notin E',@src_100),
('3.2.399','Gewichteter Graph','Graph mit einer Gewichtsfunktion auf der Kantenmenge.','w:E\\rightarrow\\mathbb{R}',@src_100),
('3.2.400','Nachbarschaft eines Knotens','Menge aller unmittelbar mit einem Knoten verbundenen Knoten.','N(v_i)=\\{v_j\\in V\\mid\\{v_i,v_j\\}\\in E\\}',@src_100),
('3.2.401','Eingangs- und Ausgangsnachbarschaft','Nachbarschaften eines gerichteten Graphen getrennt nach Kantenrichtung.','N^{+}(v_i),\\ N^{-}(v_i)',@src_100),
('3.2.402','Grad eines Knotens','Anzahl der Nachbarn eines Knotens in einem ungerichteten Graphen.','d_i=\\deg(v_i)=|N(v_i)|',@src_100),
('3.2.403','Eingangs- und Ausgangsgrad','Anzahl eingehender beziehungsweise ausgehender Kanten eines Knotens.','d_i^{+}=|N^{+}(v_i)|,\\quad d_i^{-}=|N^{-}(v_i)|',@src_100),
('3.2.404','Gewichteter Knotengrad','Summe der an einem Knoten anliegenden Kantengewichte.','s_i=\\sum_{j=1}^{n}w_{ij}',@src_100),
('3.2.405','Adjazenzmatrix','Matrixdarstellung der Kantenbeziehungen eines Graphen.','A=(a_{ij})_{i,j=1}^{n}',@src_100),
('3.2.406','Gradmatrix','Diagonalmatrix der Knotengrade eines Graphen.','D=\\operatorname{diag}(d_1,\\ldots,d_n)',@src_100),
('3.2.407','Weg','Folge von Knoten, bei der aufeinanderfolgende Knoten durch Kanten verbunden sind.','v_{i_0},v_{i_1},\\ldots,v_{i_k}',@src_100),
('3.2.408','Pfad','Weg ohne mehrfach vorkommende Knoten.','\\ell(P)=k',@src_100),
('3.2.409','Zyklus','Geschlossener Weg mit identischem Anfangs- und Endknoten.','v_{i_0}=v_{i_k}',@src_100),
('3.2.410','Zusammenhängender Graph','Graph, in dem jedes Knotenpaar durch einen Pfad verbunden ist.','\\forall v_i,v_j\\in V\\ \\exists\\text{ Pfad }v_i\\leadsto v_j',@src_100),
('3.2.411','Zusammenhangskomponente','Maximal zusammenhängender Teilgraph.','c(G)',@src_100),
('3.2.412','Graphendistanz','Länge eines kürzesten Pfades zwischen zwei Knoten.','d_G(v_i,v_j)=\\min\\{\\ell(P)\\mid P:v_i\\leadsto v_j\\}',@src_100),
('3.2.413','Exzentrizität','Größte Distanz eines Knotens zu einem anderen Knoten.','\\varepsilon(v_i)=\\max_{v_j\\in V}d_G(v_i,v_j)',@src_100),
('3.2.414','Radius und Durchmesser','Minimum beziehungsweise Maximum der Knotenexzentrizitäten.','r(G)=\\min_i\\varepsilon(v_i),\\quad\\operatorname{diam}(G)=\\max_i\\varepsilon(v_i)',@src_100),
('3.2.415','Kombinatorische Laplace-Matrix','Differenz aus Gradmatrix und Adjazenzmatrix.','L=D-A',@src_100),
('3.2.416','Wirkung des Graph-Laplace-Operators','Vergleich eines Knotenwertes mit den Werten seiner Nachbarn.','(Lx)_i=\\sum_{j=1}^{n}a_{ij}(x_i-x_j)',@src_100),
('3.2.417','Algebraische Zusammenhangszahl','Zweitkleinster Eigenwert der Laplace-Matrix.','\\lambda_2(L)',@src_100),
('3.2.418','Symmetrisch normierte Laplace-Matrix','Symmetrisch gradnormierte Form der Laplace-Matrix.','L_{\\mathrm{sym}}=I-D^{-1/2}AD^{-1/2}',@src_100),
('3.2.419','Zufallsweg-Laplace-Matrix','Normierte Laplace-Matrix in Beziehung zur Übergangsmatrix eines Zufallswegs.','L_{\\mathrm{rw}}=I-D^{-1}A',@src_100),
('3.2.420','Inzidenzmatrix','Matrix der Zuordnung orientierter Kanten zu ihren Endknoten.','B\\in\\mathbb{R}^{n\\times m}',@src_100),
('3.2.421','Diskreter Gradient','Kantendifferenzen eines Knotenwertvektors.','\\nabla_Gx=B^{\\mathsf{T}}x',@src_100),
('3.2.422','Diskrete Divergenz','Knotenbilanz eines Kantenflusses.','\\operatorname{div}_Gf=Bf',@src_100),
('3.2.423','Dirichlet-Energie auf einem Graphen','Quadratisches Maß der Unterschiede benachbarter Knotenwerte.','\\mathcal{E}_G(x)=x^{\\mathsf{T}}Lx',@src_100),
('3.2.424','Graph-Wärmekern','Matrixexponential der negativen Laplace-Matrix.','K_t=\\exp(-tL)',@src_100),
('3.2.425','Lineare Konsensdynamik','Dynamik zur Angleichung gekoppelter Knotenwerte.','\\frac{\\mathrm{d}x}{\\mathrm{d}t}=-Lx',@src_100),
('3.2.426','Übergangsmatrix eines Zufallswegs','Gradnormierte Adjazenzmatrix eines einfachen Zufallswegs.','P=D^{-1}A',@src_100),
('3.2.427','Stationäre Verteilung eines Zufallswegs','Verteilung, die unter Anwendung der Übergangsmatrix unverändert bleibt.','\\pi^{\\mathsf{T}}P=\\pi^{\\mathsf{T}}',@src_100),
('3.2.428','Gradzentralität','Normierter Knotengrad als Zentralitätsmaß.','C_D(v_i)=\\frac{d_i}{n-1}',@src_100),
('3.2.429','Nähezentralität','Kehrwert der mittleren Distanz eines Knotens zu allen anderen Knoten.','C_C(v_i)=\\frac{n-1}{\\sum_{j\\neq i}d_G(v_i,v_j)}',@src_100),
('3.2.430','Zwischenzentralität','Anteil kürzester Pfade, die durch einen Knoten verlaufen.','C_B(v_i)=\\sum\\frac{\\sigma_{st}(v_i)}{\\sigma_{st}}',@src_100),
('3.2.431','Eigenvektorzentralität','Zentralitätsmaß als Eigenvektor der Adjazenzmatrix.','Ac=\\lambda c',@src_100),
('3.2.432','Induzierter Teilgraph','Teilgraph auf einer Knotenmenge mit allen zwischen diesen Knoten vorhandenen Kanten.','G[S]=(S,E_S)',@src_100),
('3.2.433','Schnittkante','Kante zwischen einer Knotenmenge und ihrem Komplement.','\\partial S=\\{\\{v_i,v_j\\}\\in E\\mid v_i\\in S,\\ v_j\\notin S\\}',@src_100),
('3.2.434','Volumen einer Knotenmenge','Summe der Knotengrade innerhalb einer Knotenmenge.','\\operatorname{vol}(S)=\\sum_{v_i\\in S}d_i',@src_100),
('3.2.435','Leitfähigkeit eines Schnitts','Normiertes Maß für die Randkopplung einer Knotenmenge.','\\phi(S)=\\frac{|\\partial S|}{\\min(\\operatorname{vol}(S),\\operatorname{vol}(V\\setminus S))}',@src_100),
('3.2.436','Zeitabhängiger Graph','Graphenfamilie mit zeitabhängigen Knoten, Kanten oder Gewichten.','G(t)=(V(t),E(t))',@src_100),
('3.2.437','Temporaler Pfad','Zeitlich zulässige Folge von Kanten mit nicht abnehmenden Zeitpunkten.','t_1\\leq t_2\\leq\\cdots\\leq t_k',@src_100),
('3.2.438','Mehrschichtiger Graph','Netzwerk aus mehreren Beziehungsebenen.','G^{(1)},G^{(2)},\\ldots,G^{(m)}',@src_100),
('3.2.439','Supra-Adjazenzmatrix','Blockmatrix für inner- und zwischenschichtige Kopplungen.','\\mathcal{A}=\\begin{pmatrix}A^{(1)}&C^{(12)}\\\\C^{(21)}&A^{(2)}\\end{pmatrix}',@src_100),
('3.2.440','FRZK-Kopplungsgraph','Gewichteter, gegebenenfalls gerichteter Graph funktionaler Zustandskomponenten.','G_{\\mathrm{FRZK}}=(V_{\\mathrm{F}},E_{\\mathrm{F}},w_{\\mathrm{F}})',@src_100),
('3.2.441','FRZK-Adjazenzoperator','Matrix der direkten funktionalen Wirkungen zwischen FRZK-Zustandskomponenten.','A_{\\mathrm{F}}=(a_{ij}^{\\mathrm{F}})',@src_100),
('3.2.442','FRZK-Kopplungsstärke','Summierte ein- beziehungsweise ausgehende Kopplungsgewichte einer Zustandskomponente.','s_i^{\\mathrm{in}}=\\sum_j a_{ij}^{\\mathrm{F}}',@src_100),
('3.2.443','FRZK-Laplace-Operator','Laplace-Operator eines symmetrischen nichtnegativ gewichteten FRZK-Kopplungsgraphen.','L_{\\mathrm{F}}=D_{\\mathrm{F}}-A_{\\mathrm{F}}',@src_100),
('3.2.444','Funktionale Graph-Energie des FRZK','Quadratische Energie der Zustandsunterschiede entlang der FRZK-Kanten.','E_{\\mathrm{F}}(u)=u^{\\mathsf{T}}L_{\\mathrm{F}}u',@src_100),
('3.2.445','Graphbasierte FRZK-Kohärenz','Normierte Ergänzung der funktionalen Graph-Energie.','K_G(u)=\\frac{1}{1+E_{\\mathrm{F}}(u)}',@src_100),
('3.2.446','Zeitabhängiger FRZK-Kopplungsgraph','FRZK-Kopplungsgraph mit zeitabhängigen Kanten oder Gewichten.','G_{\\mathrm{F}}(t)=(V_{\\mathrm{F}},E_{\\mathrm{F}}(t),w_{\\mathrm{F}}(t))',@src_100),
('3.2.447','FRZK-Kopplungsdrift','Änderung der FRZK-Adjazenzmatrix zwischen zwei Zeitpunkten.','\\Delta A_{\\mathrm{F}}=A_{\\mathrm{F}}(t_2)-A_{\\mathrm{F}}(t_1)',@src_100),
('3.2.448','Gekoppelte Struktur-Zustands-Dynamik','Wechselseitige zeitliche Entwicklung von Zustandsvektor und Netzwerkstruktur.','\\dot{u}=F(u,A,t),\\quad\\dot{A}=G(u,A,t)',@src_100),
('3.2.449','Graphbasierte FRZK-Beobachtbarkeit','Eindeutige Rekonstruierbarkeit eines graphbasierten Zustands aus Beobachtungen und bekanntem Kopplungsoperator.','\\operatorname{rang}(\\mathcal{O})=n',@src_100);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.29.',
'Etablierte Definition oder FRZK-Anschlussdefinition.','verified',@revision
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
('3.2.91','Kantenanzahl eines ungerichteten Graphen','Die Summe aller Knotengrade ist gleich dem Doppelten der Kantenanzahl.','\\sum_{i=1}^{n}d_i=2|E|','Endlicher ungerichteter Graph.',@src_100),
('3.2.92','Wegzählung durch Potenzen der Adjazenzmatrix','Der Eintrag der k-ten Potenz der Adjazenzmatrix zählt Wege der Länge k.','(A^k)_{ij}=\\text{Anzahl der Wege der Länge }k\\text{ von }v_i\\text{ nach }v_j','Ungewichteter Graph.',@src_100),
('3.2.93','Symmetrie und positive Semidefinitheit der Laplace-Matrix','Die Laplace-Matrix eines ungerichteten Graphen ist symmetrisch und positiv semidefinit.','L=L^{\\mathsf{T}},\\quad x^{\\mathsf{T}}Lx\\geq0','Ungerichteter Graph mit nichtnegativen Gewichten.',@src_100),
('3.2.94','Nullraum der Laplace-Matrix','Der Einsvektor liegt im Nullraum; dessen Dimension entspricht der Anzahl der Zusammenhangskomponenten.','L\\mathbf{1}=0,\\quad\\dim\\ker(L)=c(G)','Endlicher ungerichteter Graph.',@src_100),
('3.2.95','Spektrales Zusammenhangskriterium','Ein ungerichteter Graph ist genau dann zusammenhängend, wenn der zweitkleinste Laplace-Eigenwert positiv ist.','G\\text{ zusammenhängend}\\Longleftrightarrow\\lambda_2(L)>0','Endlicher ungerichteter Graph.',@src_100),
('3.2.96','Faktorisierung der Laplace-Matrix','Die Laplace-Matrix lässt sich über die Inzidenzmatrix faktorisieren.','L=BB^{\\mathsf{T}},\\quad L_w=BW_EB^{\\mathsf{T}}','Ungerichteter Graph mit festgelegter Kantenorientierung.',@src_100),
('3.2.97','Erhaltung des Gesamtwertes bei ungerichteter Graphdiffusion','Die Summe der Knotenwerte bleibt unter ungerichteter Laplace-Diffusion erhalten.','\\frac{\\mathrm{d}}{\\mathrm{d}t}(\\mathbf{1}^{\\mathsf{T}}x)=0','Ungerichteter Graph und Dynamik \\dot{x}=-\\kappa Lx.',@src_100),
('3.2.98','Konsens in einem zusammenhängenden ungerichteten Graphen','Die lineare Konsensdynamik konvergiert gegen den Mittelwert der Anfangszustände.','x(t)\\rightarrow\\overline{x}(0)\\mathbf{1}','Zusammenhängender ungerichteter Graph.',@src_100),
('3.2.99','Rangbedingung der linearen Beobachtbarkeit','Ein lineares System ist vollständig beobachtbar, wenn die Beobachtbarkeitsmatrix vollen Rang besitzt.','\\operatorname{rang}(\\mathcal{O})=n','Lineares zeitinvariantes System.',@src_100);

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

CREATE TEMPORARY TABLE tmp_numbers(
 n INT PRIMARY KEY
) ENGINE=InnoDB;

INSERT INTO tmp_numbers(n)
WITH RECURSIVE seq(n) AS (
 SELECT 2595
 UNION ALL
 SELECT n+1 FROM seq WHERE n<2744
)
SELECT n FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.29}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.29}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.29.'),
'other','adapted',@src_100,
'Im Abschnitt 3.2.29 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.29.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.29 mit Definitionen 3.2.395–3.2.449, Sätzen 3.2.91–3.2.99, Gleichungen 3.2595–3.2744 und Literatur [100] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.30'),
('last_completed_section','3.2.29'),
('last_definition_number','3.2.449'),
('next_definition_number','3.2.450'),
('last_theorem_number','3.2.99'),
('next_theorem_number','3.2.100'),
('last_equation_number','3.2744'),
('next_equation_number','3.2745'),
('last_citation_number','100'),
('next_citation_number','101')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.29' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_29
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_29
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_29
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 2595 AND 2744;

SELECT COUNT(*) AS literaturverwendungen_3_2_29
FROM source_usage
WHERE section_id=@section;
