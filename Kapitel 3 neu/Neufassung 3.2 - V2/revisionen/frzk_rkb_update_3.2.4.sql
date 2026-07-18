-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschluss von Abschnitt 3.2.4
-- Abschnitt: 3.2.4 Graphen und Netzwerke als Darstellung relationaler Gesamtstrukturen
-- Grundlage: frzk_rkb_update_3.2.3.sql / importierter Stand nach 3.2.3
-- Zielsystem: MariaDB 10.4 / MySQL-kompatibel
-- Neue Quellen: [79]–[82]
-- Wiederverwendete Quellen: [72], [75]
-- Definitionen: 3.2.22–3.2.31
-- Sätze: 3.2.4–3.2.5
-- Beweise: 3.2.4-P, 3.2.5-P
-- Gleichungen: (3.203)–(3.231)
-- Nächste freie Literaturziffer: [83]
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
START TRANSACTION;

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.3-V1' LIMIT 1
);
SET @chapter_section_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1
);

SELECT CASE
 WHEN @parent_revision_id IS NULL THEN 'FEHLER: Revision RKB-NEU-K3.2.3-V1 fehlt.'
 WHEN @chapter_section_id IS NULL THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
 ELSE 'OK: Ausgangsstand nach 3.2.3 vorhanden.'
END AS precondition_status;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
 'RKB-NEU-K3.2.4-V1',NOW(),'section','3.2.4','1.0',
 'Abschluss von Abschnitt 3.2.4 Graphen und Netzwerke als Darstellung relationaler Gesamtstrukturen. Aufnahme der Quellen [79] bis [82], Wiederverwendung von [72] und [75], Registrierung der Definitionen 3.2.22 bis 3.2.31, der Sätze 3.2.4 und 3.2.5, der Beweise sowie der Gleichungen (3.203) bis (3.231).',
 'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_revision_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.4-V1');

SET @revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.4-V1' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @chapter_section_id,'3.2.4','Graphen und Netzwerke als Darstellung relationaler Gesamtstrukturen',
 3,3.2400,'final',0,
 'Der Abschnitt rekonstruiert Graphen als relationale Gesamtstrukturen und behandelt gerichtete sowie ungerichtete Graphen, Grade, Adjazenzmatrizen, Pfade, Zusammenhang, Distanz, Zyklen, Bäume, gewichtete Graphen, Gradverteilungen, Clusterkoeffizienten und Gradzentralität.'
WHERE @chapter_section_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.4');

UPDATE dissertation_sections SET
 parent_section_id=@chapter_section_id,
 title='Graphen und Netzwerke als Darstellung relationaler Gesamtstrukturen',
 chapter_no=3,section_order=3.2400,status='final',is_original_contribution=0,
 notes='Der Abschnitt rekonstruiert Graphen als relationale Gesamtstrukturen und behandelt gerichtete sowie ungerichtete Graphen, Grade, Adjazenzmatrizen, Pfade, Zusammenhang, Distanz, Zyklen, Bäume, gewichtete Graphen, Gradverteilungen, Clusterkoeffizienten und Gradzentralität.'
WHERE section_code='3.2.4';

SET @section_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4' LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,birth_year,death_year,notes)
VALUES
('Euler','Leonhard','Euler, Leonhard',1707,1783,'Autor der Quelle [79].'),
('Diestel','Reinhard','Diestel, Reinhard',1959,NULL,'Autor der Quelle [80].'),
('Newman','Mark','Newman, Mark',1968,NULL,'Autor der Quelle [81].'),
('Barabási','Albert-László','Barabási, Albert-László',1967,NULL,'Autor der Quelle [82].')
ON DUPLICATE KEY UPDATE notes=VALUES(notes);

SET @author_euler := (SELECT author_id FROM authors WHERE normalized_name='Euler, Leonhard' LIMIT 1);
SET @author_diestel := (SELECT author_id FROM authors WHERE normalized_name='Diestel, Reinhard' LIMIT 1);
SET @author_newman := (SELECT author_id FROM authors WHERE normalized_name='Newman, Mark' LIMIT 1);
SET @author_barabasi := (SELECT author_id FROM authors WHERE normalized_name='Barabási, Albert-László' LIMIT 1);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(79,'euler_solutio_geometriam_situs_1741','journal_article','Solutio problematis ad geometriam situs pertinentis',1736,1741,
 'Commentarii Academiae Scientiarum Imperialis Petropolitanae',NULL,'Petropoli','8','128–140',NULL,
 'la',1,'primary',9,'verified','3.2.4','Erstnennung zur historischen Entstehung der Graphentheorie.',
 'Euler, Leonhard (1741): Solutio problematis ad geometriam situs pertinentis. In: Commentarii Academiae Scientiarum Imperialis Petropolitanae 8, S. 128–140.',
 'Euler (1741)','Historische Primärquelle zur frühen Graphentheorie.',@revision_id),
(80,'diestel_graph_theory_2017','book','Graph Theory',1997,2017,NULL,'Springer','Berlin/Heidelberg',NULL,NULL,'5. Auflage',
 'en',1,'secondary',10,'verified','3.2.4','Erstnennung zur modernen Graphentheorie.',
 'Diestel, Reinhard (2017): Graph Theory. 5. Auflage. Berlin/Heidelberg: Springer.',
 'Diestel (2017)','Standardwerk der modernen Graphentheorie.',@revision_id),
(81,'newman_networks_2018','book','Networks',2010,2018,NULL,'Oxford University Press','Oxford',NULL,NULL,'2. Auflage',
 'en',1,'secondary',10,'verified','3.2.4','Erstnennung zur Netzwerkwissenschaft.',
 'Newman, Mark (2018): Networks. 2. Auflage. Oxford: Oxford University Press.',
 'Newman (2018)','Grundlegendes Werk zu komplexen Netzwerken und Netzwerkmaßen.',@revision_id),
(82,'barabasi_network_science_2016','book','Network Science',2016,2016,NULL,'Cambridge University Press','Cambridge',NULL,NULL,'1. Auflage',
 'en',1,'secondary',10,'verified','3.2.4','Erstnennung zu Gradverteilungen und skalenfreien Netzwerken.',
 'Barabási, Albert-László (2016): Network Science. Cambridge: Cambridge University Press.',
 'Barabási (2016)','Grundlegendes Werk zu komplexen Netzwerken.',@revision_id)
ON DUPLICATE KEY UPDATE
 source_type=VALUES(source_type),title=VALUES(title),year_original=VALUES(year_original),year_edition=VALUES(year_edition),
 journal=VALUES(journal),publisher=VALUES(publisher),place=VALUES(place),volume=VALUES(volume),pages=VALUES(pages),edition=VALUES(edition),
 language_code=VALUES(language_code),priority=VALUES(priority),evidence_type=VALUES(evidence_type),frzk_relevance=VALUES(frzk_relevance),
 verification_status=VALUES(verification_status),first_citation_section_code=VALUES(first_citation_section_code),
 first_citation_note=VALUES(first_citation_note),full_citation_text=VALUES(full_citation_text),short_citation_text=VALUES(short_citation_text),
 notes=VALUES(notes),created_revision_id=VALUES(created_revision_id);

SET @source_72 := (SELECT source_id FROM sources WHERE citation_number=72 LIMIT 1);
SET @source_75 := (SELECT source_id FROM sources WHERE citation_number=75 LIMIT 1);
SET @source_79 := (SELECT source_id FROM sources WHERE source_key='euler_solutio_geometriam_situs_1741' LIMIT 1);
SET @source_80 := (SELECT source_id FROM sources WHERE source_key='diestel_graph_theory_2017' LIMIT 1);
SET @source_81 := (SELECT source_id FROM sources WHERE source_key='newman_networks_2018' LIMIT 1);
SET @source_82 := (SELECT source_id FROM sources WHERE source_key='barabasi_network_science_2016' LIMIT 1);

INSERT IGNORE INTO source_authors(source_id,author_id,author_order,role)
VALUES
(@source_79,@author_euler,1,'author'),
(@source_80,@author_diestel,1,'author'),
(@source_81,@author_newman,1,'author'),
(@source_82,@author_barabasi,1,'author');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_79,@section_id,'first_citation','Historische Entstehung der Graphentheorie am Königsberger Brückenproblem.','Historische Einleitung',1,1,'Erstnennung als Quelle [79].',@revision_id
WHERE @source_79 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_79 AND section_id=@section_id AND usage_type='first_citation');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_80,@section_id,'first_citation','Definitionen und Sätze der modernen Graphentheorie.','Graphentheoretische Grundbegriffe',1,1,'Erstnennung als Quelle [80].',@revision_id
WHERE @source_80 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_80 AND section_id=@section_id AND usage_type='first_citation');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_81,@section_id,'first_citation','Statistische Beschreibung komplexer Netzwerke und Netzwerkmaße.','Netzwerkwissenschaft',1,1,'Erstnennung als Quelle [81].',@revision_id
WHERE @source_81 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_81 AND section_id=@section_id AND usage_type='first_citation');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_82,@section_id,'first_citation','Gradverteilungen und skalenfreie Netzwerkstrukturen.','Gradverteilung',1,1,'Erstnennung als Quelle [82].',@revision_id
WHERE @source_82 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_82 AND section_id=@section_id AND usage_type='first_citation');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_72,@section_id,'background','Mengentheoretische Darstellung von Knoten- und Kantenmengen.','Grunddefinitionen',0,1,'Wiederverwendung der Quelle [72].',@revision_id
WHERE @source_72 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_72 AND section_id=@section_id AND usage_type='background');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_75,@section_id,'background','Verbindung gerichteter Graphen mit binären Relationen.','Gerichtete Graphen',0,1,'Wiederverwendung der Quelle [75].',@revision_id
WHERE @source_75 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_75 AND section_id=@section_id AND usage_type='background');

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.22',@section_id,'Graph','Ein Graph ist ein geordnetes Paar G=(V,E), wobei V die Knotenmenge und E die Kantenmenge bezeichnet.','G=(V,E)','G=(V,E)','adapted',@source_80,'V und E sind Mengen.','Grunddefinition eines Graphen.','checked',@revision_id),
('3.2.23',@section_id,'Gerichteter Graph','Ein gerichteter Graph ist ein Paar G=(V,E) mit E⊆V×V.','E\\subseteq V\\times V','E\\subseteq V\\times V','adapted',@source_80,'V ist eine Knotenmenge.','Gerichtete Kanten sind geordnete Paare.','checked',@revision_id),
('3.2.24',@section_id,'Knotengrad','Der Grad eines Knotens ist die Anzahl seiner unmittelbaren Nachbarn; in gerichteten Graphen werden Eingangs- und Ausgangsgrad unterschieden.','\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|','\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|','adapted',@source_80,'G=(V,E) und v∈V.','Lokales Vernetzungsmaß.','checked',@revision_id),
('3.2.25',@section_id,'Adjazenzmatrix','Die Adjazenzmatrix A_G=(a_ij) bildet die Kantenstruktur eines endlichen Graphen binär ab.','\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}','\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}','adapted',@source_81,'V ist endlich und geordnet.','Matrixdarstellung der Kantenstruktur.','checked',@revision_id),
('3.2.26',@section_id,'Kantenzug und Pfad','Ein Kantenzug ist eine Folge benachbarter Knoten. Ein Pfad ist ein Kantenzug ohne mehrfach vorkommende Knoten.','W=(v_0,v_1,\\ldots,v_k)','W=(v_0,v_1,\\ldots,v_k)','adapted',@source_80,'Die Kantenfolge ist zulässig.','Grundlage für Erreichbarkeit und Distanz.','checked',@revision_id),
('3.2.27',@section_id,'Zusammenhang','Ein Graph heißt zusammenhängend, wenn zwischen je zwei Knoten ein Pfad existiert.','\\forall u,v\\in V\\;\\exists P_{uv}','\\forall u,v\\in V\\;\\exists P_{uv}','adapted',@source_80,'G=(V,E).','Globale Erreichbarkeitseigenschaft.','checked',@revision_id),
('3.2.28',@section_id,'Graphendistanz','Die Distanz d_G(u,v) ist die minimale Länge eines Pfades von u nach v.','d_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}','d_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}','adapted',@source_80,'Zwischen u und v existiert ein Pfad.','Strukturelle Entfernung.','checked',@revision_id),
('3.2.29',@section_id,'Zyklus','Ein Zyklus ist ein geschlossener Pfad mit paarweise verschiedenen inneren Knoten.','C=(v_0,v_1,\\ldots,v_{k-1},v_0)','C=(v_0,v_1,\\ldots,v_{k-1},v_0)','adapted',@source_80,'Die Kantenfolge ist geschlossen.','Geschlossene Verbindungsfolge.','checked',@revision_id),
('3.2.30',@section_id,'Baum','Ein Baum ist ein zusammenhängender ungerichteter Graph ohne Zyklen.','|E|=|V|-1','|E|=|V|-1','adapted',@source_80,'Der Graph ist endlich, ungerichtet und azyklisch.','Für endliche Bäume gilt |E|=|V|-1.','checked',@revision_id),
('3.2.31',@section_id,'Gewichteter Graph','Ein gewichteter Graph ist ein Tripel G=(V,E,w) mit einer Gewichtsfunktion w:E→R.','w:E\\rightarrow\\mathbb{R}','w:E\\rightarrow\\mathbb{R}','adapted',@source_81,'G=(V,E).','Kanten erhalten quantitative Werte.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),
 provenance=VALUES(provenance),source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('3.2.4',@section_id,'Handschlaglemma','Für jeden endlichen ungerichteten Graphen ist die Summe aller Knotengrade gleich dem Doppelten der Kantenzahl.','\\sum_{v\\in V}\\deg(v)=2|E|','\\sum_{v\\in V}\\deg(v)=2|E|','literature',@source_80,'G ist endlich und ungerichtet.','checked',@revision_id),
('3.2.5',@section_id,'Eindeutigkeit der Pfade in einem Baum','In einem Baum existiert zwischen je zwei verschiedenen Knoten genau ein Pfad.','\\forall u,v\\in V,\\;u\\neq v:\\;\\exists!\\,P_{uv}','\\forall u,v\\in V,\\;u\\neq v:\\;\\exists!\\,P_{uv}','literature',@source_80,'T=(V,E) ist ein Baum.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),statement_text=VALUES(statement_text),statement_latex=VALUES(statement_latex),word_latex=VALUES(word_latex),
 provenance=VALUES(provenance),source_id=VALUES(source_id),assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

SET @theorem_324 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.4' LIMIT 1);
SET @theorem_325 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.5' LIMIT 1);

INSERT INTO proofs
(proof_number,section_id,theorem_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT '3.2.4-P',@section_id,@theorem_324,'Beweis des Handschlaglemmas',
 'Jede ungerichtete Kante besitzt zwei Endknoten und wird in der Summe der Knotengrade genau zweimal gezählt.',
 '\\sum_{v\\in V}\\deg(v)=2|E|','double_counting','literature',@source_80,'checked',@revision_id
WHERE @theorem_324 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.4-P');
INSERT INTO proofs
(proof_number,section_id,theorem_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT '3.2.5-P',@section_id,@theorem_325,'Beweis der Eindeutigkeit der Pfade in einem Baum',
 'Der Zusammenhang sichert die Existenz eines Pfades. Zwei verschiedene Pfade zwischen denselben Knoten würden einen Zyklus erzeugen und damit der Azyklizität widersprechen.',
 '\\forall u,v\\in V,\\;u\\neq v:\\;\\exists!\\,P_{uv}','contradiction','literature',@source_80,'checked',@revision_id
WHERE @theorem_325 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.5-P');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.203',@section_id,'Graph als geordnetes Paar','G=(V,E)','G=(V,E)','Graph aus Knoten- und Kantenmenge.','definition','adapted',@source_80,NULL,'V und E sind Mengen.','checked',@revision_id),
('3.204',@section_id,'Kantenmenge eines einfachen ungerichteten Graphen','E\\subseteq\\left\\{\\{u,v\\}\\mid u,v\\in V,\\;u\\neq v\\right\\}','E\\subseteq\\left\\{\\{u,v\\}\\mid u,v\\in V,\\;u\\neq v\\right\\}','Ungerichtete Kanten als zweielementige Teilmengen.','definition','adapted',@source_80,NULL,'Graph ist einfach und ungerichtet.','checked',@revision_id),
('3.205',@section_id,'Gerichteter Graph','G=(V,E)','G=(V,E)','Gerichteter Graph als Paar.','definition','adapted',@source_80,NULL,'E enthält geordnete Paare.','checked',@revision_id),
('3.206',@section_id,'Kantenmenge eines gerichteten Graphen','E\\subseteq V\\times V','E\\subseteq V\\times V','Gerichtete Kanten sind geordnete Knotenpaare.','definition','adapted',@source_80,NULL,'V ist die Knotenmenge.','checked',@revision_id),
('3.207',@section_id,'Gerichtete Kante','(u,v)\\in E','(u,v)\\in E','Kante von u nach v.','definition','adapted',@source_80,NULL,'u,v∈V.','checked',@revision_id),
('3.208',@section_id,'Fehlende Umkehrkante','(v,u)\\notin E','(v,u)\\notin E','Keine notwendige Gegenkante.','relation','adapted',@source_75,NULL,'Graph ist nicht symmetrisch.','checked',@revision_id),
('3.209',@section_id,'Grad eines Knotens','\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|','\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|','Anzahl unmittelbarer Nachbarn.','definition','adapted',@source_80,NULL,'G ist ungerichtet.','checked',@revision_id),
('3.210',@section_id,'Eingangsgrad','\\deg^{-}(v)=\\left|\\left\\{u\\in V\\mid(u,v)\\in E\\right\\}\\right|','\\deg^{-}(v)=\\left|\\left\\{u\\in V\\mid(u,v)\\in E\\right\\}\\right|','Zahl eingehender Kanten.','definition','adapted',@source_80,NULL,'G ist gerichtet.','checked',@revision_id),
('3.211',@section_id,'Ausgangsgrad','\\deg^{+}(v)=\\left|\\left\\{w\\in V\\mid(v,w)\\in E\\right\\}\\right|','\\deg^{+}(v)=\\left|\\left\\{w\\in V\\mid(v,w)\\in E\\right\\}\\right|','Zahl ausgehender Kanten.','definition','adapted',@source_80,NULL,'G ist gerichtet.','checked',@revision_id),
('3.212',@section_id,'Handschlaglemma','\\sum_{v\\in V}\\deg(v)=2|E|','\\sum_{v\\in V}\\deg(v)=2|E|','Summe der Grade ist doppelte Kantenzahl.','theorem','literature',@source_80,'Jede Kante wird zweimal gezählt.','G ist endlich und ungerichtet.','checked',@revision_id),
('3.213',@section_id,'Geordnete endliche Knotenmenge','V=\\{v_1,v_2,\\ldots,v_n\\}','V=\\{v_1,v_2,\\ldots,v_n\\}','Endliche geordnete Knotenmenge.','schema','adapted',@source_72,NULL,'V ist endlich.','checked',@revision_id),
('3.214',@section_id,'Adjazenzmatrix','\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}','\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}','Binäre Matrixdarstellung.','definition','adapted',@source_81,NULL,'V besitzt n Knoten.','checked',@revision_id),
('3.215',@section_id,'Einträge der Adjazenzmatrix','a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}','a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}','Binäre Kantenkodierung.','definition','adapted',@source_81,NULL,'G ist endlich.','checked',@revision_id),
('3.216',@section_id,'Symmetrie der Adjazenzmatrix','\\mathbf{A}_G^{\\mathsf T}=\\mathbf{A}_G','\\mathbf{A}_G^{\\mathsf T}=\\mathbf{A}_G','Symmetrische Matrix bei ungerichtetem Graphen.','theorem','adapted',@source_81,NULL,'G ist ungerichtet.','checked',@revision_id),
('3.217',@section_id,'Potenz der Adjazenzmatrix','\\left(\\mathbf{A}_G^k\\right)_{ij}','\\left(\\mathbf{A}_G^k\\right)_{ij}','Zahl der Kantenzüge der Länge k.','derived','adapted',@source_81,'Matrixmultiplikation über natürlichen Zahlen.','k>0.','checked',@revision_id),
('3.218',@section_id,'Kantenzug','W=(v_0,v_1,\\ldots,v_k)','W=(v_0,v_1,\\ldots,v_k)','Folge benachbarter Knoten.','definition','adapted',@source_80,NULL,'Kantenfolge ist zulässig.','checked',@revision_id),
('3.219',@section_id,'Kantenbedingung eines Kantenzugs','(v_{i-1},v_i)\\in E\\qquad\\text{für alle }i\\in\\{1,\\ldots,k\\}','(v_{i-1},v_i)\\in E\\qquad\\text{für alle }i\\in\\{1,\\ldots,k\\}','Benachbarungsbedingung.','definition','adapted',@source_80,NULL,'Orientierung wird beachtet.','checked',@revision_id),
('3.220',@section_id,'Zusammenhang','\\forall u,v\\in V\\;\\exists P_{uv}','\\forall u,v\\in V\\;\\exists P_{uv}','Pfad zwischen je zwei Knoten.','definition','adapted',@source_80,NULL,'G ist ungerichtet.','checked',@revision_id),
('3.221',@section_id,'Starker Zusammenhang','\\forall u,v\\in V:\\;u\\leadsto v','\\forall u,v\\in V:\\;u\\leadsto v','Jeder Knoten ist von jedem anderen erreichbar.','definition','adapted',@source_80,NULL,'G ist gerichtet.','checked',@revision_id),
('3.222',@section_id,'Graphendistanz','d_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}','d_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}','Länge eines kürzesten Pfades.','definition','adapted',@source_80,NULL,'Pfad existiert.','checked',@revision_id),
('3.223',@section_id,'Zyklus','C=(v_0,v_1,\\ldots,v_{k-1},v_0)','C=(v_0,v_1,\\ldots,v_{k-1},v_0)','Geschlossener Pfad.','definition','adapted',@source_80,NULL,'Innere Knoten sind verschieden.','checked',@revision_id),
('3.224',@section_id,'Kantenanzahl eines endlichen Baumes','|E|=|V|-1','|E|=|V|-1','Kanten-Knoten-Beziehung eines Baumes.','theorem','literature',@source_80,NULL,'T ist ein endlicher Baum.','checked',@revision_id),
('3.225',@section_id,'Gewichteter Graph','G=(V,E,w)','G=(V,E,w)','Graph mit Gewichtsfunktion.','definition','adapted',@source_81,NULL,'G ist ein Graph.','checked',@revision_id),
('3.226',@section_id,'Gewichtsfunktion','w:E\\rightarrow\\mathbb{R}','w:E\\rightarrow\\mathbb{R}','Reelles Gewicht je Kante.','definition','adapted',@source_81,NULL,'E ist die Kantenmenge.','checked',@revision_id),
('3.227',@section_id,'Gewichtete Pfadlänge','L_w(P)=\\sum_{e\\in P}w(e)','L_w(P)=\\sum_{e\\in P}w(e)','Summe der Kantengewichte.','definition','adapted',@source_81,NULL,'P ist ein Pfad.','checked',@revision_id),
('3.228',@section_id,'Gewichtete Distanz','d_w(u,v)=\\min_{P:u\\leadsto v}L_w(P)','d_w(u,v)=\\min_{P:u\\leadsto v}L_w(P)','Minimale gewichtete Pfadlänge.','definition','adapted',@source_81,NULL,'Pfad existiert.','checked',@revision_id),
('3.229',@section_id,'Gradverteilung','P(k)=\\frac{\\left|\\left\\{v\\in V\\mid\\deg(v)=k\\right\\}\\right|}{|V|}','P(k)=\\frac{\\left|\\left\\{v\\in V\\mid\\deg(v)=k\\right\\}\\right|}{|V|}','Anteil der Knoten mit Grad k.','definition','adapted',@source_82,NULL,'V ist endlich.','checked',@revision_id),
('3.230',@section_id,'Lokaler Clusterkoeffizient','C(v)=\\frac{2e_v}{k_v(k_v-1)}','C(v)=\\frac{2e_v}{k_v(k_v-1)}','Lokale Nachbarschaftsverdichtung.','definition','adapted',@source_81,NULL,'k_v>=2.','checked',@revision_id),
('3.231',@section_id,'Normierte Gradzentralität','C_D(v)=\\frac{\\deg(v)}{|V|-1}','C_D(v)=\\frac{\\deg(v)}{|V|-1}','Normierter Knotengrad.','definition','adapted',@source_81,NULL,'|V|>1.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),derivation=VALUES(derivation),assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES('next_citation_number','83')
ON DUPLICATE KEY UPDATE counter_value=CASE WHEN CAST(counter_value AS UNSIGNED)<83 THEN '83' ELSE counter_value END;

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'created','section','3.2.4','Abschnitt 3.2.4 vollständig angelegt.',NULL,'status=final'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND section_id=@section_id AND change_type='created' AND object_reference='3.2.4');
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'source_added','sources','[79]-[82]','Vier neue Quellen aufgenommen.','next_citation_number=79','next_citation_number=83'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND section_id=@section_id AND change_type='source_added' AND object_reference='[79]-[82]');
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'definition_added','definitions','3.2.22-3.2.31','Zehn Definitionen registriert.',NULL,'10 Definitionen'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND section_id=@section_id AND change_type='definition_added' AND object_reference='3.2.22-3.2.31');
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'statement_added','theorems','3.2.4-3.2.5','Zwei Sätze registriert.',NULL,'2 Sätze'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND section_id=@section_id AND change_type='statement_added' AND object_reference='3.2.4-3.2.5');
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'proof_added','proofs','3.2.4-P;3.2.5-P','Zwei Beweise registriert.',NULL,'2 Beweise'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND section_id=@section_id AND change_type='proof_added' AND object_reference='3.2.4-P;3.2.5-P');
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'equation_added','equations','(3.203)-(3.231)','29 Gleichungen registriert.',NULL,'29 Gleichungen'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND section_id=@section_id AND change_type='equation_added' AND object_reference='(3.203)-(3.231)');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-SECTION',IF(COUNT(*)=1,'passed','failed'),'1',CAST(COUNT(*) AS CHAR),'Abschnitt 3.2.4 muss genau einmal vorhanden sein.'
FROM dissertation_sections WHERE section_code='3.2.4'
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-NEW-SOURCES',IF(COUNT(*)=4,'passed','failed'),'4',CAST(COUNT(*) AS CHAR),'Die Quellen [79] bis [82] müssen vorhanden sein.'
FROM sources WHERE citation_number BETWEEN 79 AND 82
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-DEFINITIONS',IF(COUNT(*)=10,'passed','failed'),'10',CAST(COUNT(*) AS CHAR),'Die Definitionen 3.2.22 bis 3.2.31 müssen vorhanden sein.'
FROM definitions WHERE section_id=@section_id AND definition_number IN ('3.2.22','3.2.23','3.2.24','3.2.25','3.2.26','3.2.27','3.2.28','3.2.29','3.2.30','3.2.31')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-THEOREMS',IF(COUNT(*)=2,'passed','failed'),'2',CAST(COUNT(*) AS CHAR),'Die Sätze 3.2.4 und 3.2.5 müssen vorhanden sein.'
FROM theorems WHERE section_id=@section_id AND theorem_number IN ('3.2.4','3.2.5')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-PROOFS',IF(COUNT(*)=2,'passed','failed'),'2',CAST(COUNT(*) AS CHAR),'Zwei Beweise müssen vorhanden sein.'
FROM proofs WHERE section_id=@section_id AND proof_number IN ('3.2.4-P','3.2.5-P')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-EQUATIONS',IF(COUNT(*)=29,'passed','failed'),'29',CAST(COUNT(*) AS CHAR),'Die Gleichungen (3.203) bis (3.231) müssen vorhanden sein.'
FROM equations WHERE section_id=@section_id AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 203 AND 231
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-WORD-LATEX',IF(COUNT(*)=29,'passed','failed'),'29',CAST(COUNT(*) AS CHAR),'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations WHERE section_id=@section_id AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 203 AND 231 AND word_latex IS NOT NULL AND TRIM(word_latex)<>''
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.4-NEXT-CITATION',IF(CAST(counter_value AS UNSIGNED)>=83,'passed','failed'),'>=83',counter_value,'Die nächste freie Literaturziffer muss mindestens [83] sein.'
FROM repository_counters WHERE counter_key='next_citation_number'
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

COMMIT;

SELECT revision_id,revision_code,scope_reference,version_label,parent_revision_id,revision_date
FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.4-V1';
SELECT section_id,parent_section_id,section_code,title,status,is_original_contribution
FROM dissertation_sections WHERE section_code='3.2.4';
SELECT citation_number,source_key,short_citation_text,verification_status
FROM sources WHERE citation_number BETWEEN 79 AND 82 ORDER BY citation_number;
SELECT definition_number,title,validation_status FROM definitions WHERE section_id=@section_id ORDER BY definition_number;
SELECT theorem_number,title,validation_status FROM theorems WHERE section_id=@section_id ORDER BY theorem_number;
SELECT proof_number,title,proof_method,validation_status FROM proofs WHERE section_id=@section_id ORDER BY proof_number;
SELECT equation_number,title,equation_type,validation_status FROM equations WHERE section_id=@section_id ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results WHERE revision_id=@revision_id ORDER BY validation_code;
