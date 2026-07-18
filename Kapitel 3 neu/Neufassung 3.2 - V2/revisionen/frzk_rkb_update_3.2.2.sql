-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschluss von Abschnitt 3.2.2
-- Abschnitt: 3.2.2 Relationen als Beschreibung mathematischer Zusammenhänge
-- Grundlage: frzk_rkb_update_3.2.1.sql / importierter Stand nach 3.2.1
-- Zielsystem: MariaDB 10.4 / MySQL-kompatibel
--
-- Neue Quellen: [73]–[75]
-- Wiederverwendete Quelle: [72] Bourbaki
-- Definitionen: 3.2.4–3.2.13
-- Sätze: 3.2.2–3.2.3
-- Gleichungen: (3.159)–(3.192)
-- Nächste freie Literaturziffer: [76]
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
START TRANSACTION;

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.1-V1' LIMIT 1
);
SET @chapter_section_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1
);

SELECT CASE
 WHEN @parent_revision_id IS NULL THEN 'FEHLER: Revision RKB-NEU-K3.2.1-V1 fehlt.'
 WHEN @chapter_section_id IS NULL THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
 ELSE 'OK: Ausgangsstand nach 3.2.1 vorhanden.'
END AS precondition_status;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
 'RKB-NEU-K3.2.2-V1',NOW(),'section','3.2.2','1.0',
 'Abschluss von Abschnitt 3.2.2 Relationen als Beschreibung mathematischer Zusammenhänge. Aufnahme der Quellen [73] bis [75], Wiederverwendung von [72], Registrierung der Definitionen 3.2.4 bis 3.2.13, der Sätze 3.2.2 und 3.2.3, der zugehörigen Beweise sowie der Gleichungen (3.159) bis (3.192).',
 'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_revision_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.2-V1');

SET @revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.2-V1' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @chapter_section_id,'3.2.2','Relationen als Beschreibung mathematischer Zusammenhänge',
 3,3.2200,'final',0,
 'Der Abschnitt rekonstruiert Relationen als Auswahl geordneter Tupel aus kartesischen Produkten. Behandelt werden Relationseigenschaften, Äquivalenzen, Ordnungen, Umkehrung, Komposition, Hüllen und Matrixdarstellungen. Die Darstellung bleibt Forschungsstand und nimmt keine FRZK-Axiomatik vorweg.'
WHERE @chapter_section_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.2');

UPDATE dissertation_sections SET
 parent_section_id=@chapter_section_id,
 title='Relationen als Beschreibung mathematischer Zusammenhänge',
 chapter_no=3,section_order=3.2200,status='final',is_original_contribution=0,
 notes='Der Abschnitt rekonstruiert Relationen als Auswahl geordneter Tupel aus kartesischen Produkten. Behandelt werden Relationseigenschaften, Äquivalenzen, Ordnungen, Umkehrung, Komposition, Hüllen und Matrixdarstellungen. Die Darstellung bleibt Forschungsstand und nimmt keine FRZK-Axiomatik vorweg.'
WHERE section_code='3.2.2';

SET @section_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2' LIMIT 1
);


-- Autoren
INSERT INTO authors(family_name,given_names,normalized_name,birth_year,death_year,notes)
VALUES
('Peirce','Charles Sanders','Peirce, Charles Sanders',1839,1914,'Autor der Quelle [73].'),
('Schröder','Ernst','Schröder, Ernst',1841,1902,'Autor der Quelle [74].'),
('Tarski','Alfred','Tarski, Alfred',1901,1983,'Autor der Quelle [75].')
ON DUPLICATE KEY UPDATE notes=VALUES(notes);

SET @author_peirce := (SELECT author_id FROM authors WHERE normalized_name='Peirce, Charles Sanders' LIMIT 1);
SET @author_schroeder := (SELECT author_id FROM authors WHERE normalized_name='Schröder, Ernst' LIMIT 1);
SET @author_tarski := (SELECT author_id FROM authors WHERE normalized_name='Tarski, Alfred' LIMIT 1);


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(73,'peirce_logic_relatives_1870','journal_article','Description of a Notation for the Logic of Relatives, Resulting from an Amplification of the Conceptions of Boole’s Calculus of Logic',1870,1870,'Memoirs of the American Academy of Arts and Sciences',NULL,NULL,'9',NULL,'317–378',
 'en',1,'primary',8,'partially_verified','3.2.2',
 'Erstnennung in Abschnitt 3.2.2.','Peirce, Charles Sanders (1870): Description of a Notation for the Logic of Relatives, Resulting from an Amplification of the Conceptions of Boole’s Calculus of Logic. In: Memoirs of the American Academy of Arts and Sciences, New Series 9, S. 317–378.','Peirce (1870)','Historische Primärquelle zur Erweiterung der Booleschen Logik um einen Kalkül mehrstelliger Relationen.',@revision_id)
ON DUPLICATE KEY UPDATE
 source_type=VALUES(source_type),title=VALUES(title),year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),journal=VALUES(journal),publisher=VALUES(publisher),
 place=VALUES(place),volume=VALUES(volume),issue=VALUES(issue),pages=VALUES(pages),
 language_code=VALUES(language_code),verification_status=VALUES(verification_status),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),short_citation_text=VALUES(short_citation_text),
 notes=VALUES(notes),created_revision_id=VALUES(created_revision_id);


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(74,'schroeder_algebra_logik_relative_1895','book','Vorlesungen über die Algebra der Logik (Exakte Logik)',1895,1895,NULL,'B. G. Teubner','Leipzig','3',NULL,NULL,
 'de',1,'primary',8,'partially_verified','3.2.2',
 'Erstnennung in Abschnitt 3.2.2.','Schröder, Ernst (1895): Vorlesungen über die Algebra der Logik (Exakte Logik). Band 3: Algebra und Logik der Relative. Leipzig: B. G. Teubner.','Schröder (1895)','Historische Primärquelle zur algebraischen Behandlung von Relationen.',@revision_id)
ON DUPLICATE KEY UPDATE
 source_type=VALUES(source_type),title=VALUES(title),year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),journal=VALUES(journal),publisher=VALUES(publisher),
 place=VALUES(place),volume=VALUES(volume),issue=VALUES(issue),pages=VALUES(pages),
 language_code=VALUES(language_code),verification_status=VALUES(verification_status),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),short_citation_text=VALUES(short_citation_text),
 notes=VALUES(notes),created_revision_id=VALUES(created_revision_id);


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(75,'tarski_calculus_relations_1941','journal_article','On the Calculus of Relations',1941,1941,'The Journal of Symbolic Logic',NULL,NULL,'6','3','73–89',
 'en',1,'primary',8,'partially_verified','3.2.2',
 'Erstnennung in Abschnitt 3.2.2.','Tarski, Alfred (1941): On the Calculus of Relations. In: The Journal of Symbolic Logic 6(3), S. 73–89.','Tarski (1941)','Primärquelle zur modernen axiomatischen und algebraischen Fassung des Relationskalküls.',@revision_id)
ON DUPLICATE KEY UPDATE
 source_type=VALUES(source_type),title=VALUES(title),year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),journal=VALUES(journal),publisher=VALUES(publisher),
 place=VALUES(place),volume=VALUES(volume),issue=VALUES(issue),pages=VALUES(pages),
 language_code=VALUES(language_code),verification_status=VALUES(verification_status),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),short_citation_text=VALUES(short_citation_text),
 notes=VALUES(notes),created_revision_id=VALUES(created_revision_id);


SET @source_72 := (SELECT source_id FROM sources WHERE citation_number=72 LIMIT 1);
SET @source_73 := (SELECT source_id FROM sources WHERE source_key='peirce_logic_relatives_1870' LIMIT 1);
SET @source_74 := (SELECT source_id FROM sources WHERE source_key='schroeder_algebra_logik_relative_1895' LIMIT 1);
SET @source_75 := (SELECT source_id FROM sources WHERE source_key='tarski_calculus_relations_1941' LIMIT 1);

INSERT IGNORE INTO source_authors(source_id,author_id,author_order,role)
VALUES
(@source_73,@author_peirce,1,'author'),
(@source_74,@author_schroeder,1,'author'),
(@source_75,@author_tarski,1,'author');


INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_73,@section_id,'first_citation','Historische Entwicklung eines Kalküls relativer Terme und mehrstelliger Relationen.','Historische Entwicklung der Relationslogik',1,1,
 'Erstnennung als Quelle [73].',@revision_id
WHERE @source_73 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@source_73 AND section_id=@section_id AND usage_type='first_citation'
);


INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_74,@section_id,'first_citation','Algebraische Behandlung von Relationen und Übergang zu operativen Relationskalkülen.','Historische Entwicklung und Matrixdarstellung',1,1,
 'Erstnennung als Quelle [74].',@revision_id
WHERE @source_74 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@source_74 AND section_id=@section_id AND usage_type='first_citation'
);


INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_75,@section_id,'first_citation','Moderne axiomatische und algebraische Fassung des Relationskalküls einschließlich Umkehrung und Komposition.','Definitionen, Relationseigenschaften und Komposition',1,1,
 'Erstnennung als Quelle [75].',@revision_id
WHERE @source_75 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@source_75 AND section_id=@section_id AND usage_type='first_citation'
);


INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_72,@section_id,'background','Mengentheoretische Definition von Relationen, Äquivalenzstrukturen, Quotientenmengen und Ordnungen.','Grundbegriffe und strukturelle Einordnung',0,1,
 'Wiederverwendung der Quelle [72].',@revision_id
WHERE @source_72 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@source_72 AND section_id=@section_id AND usage_type='background'
);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.4',@section_id,'Binäre Relation','Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge des kartesischen Produkts A×B. Für a∈A und b∈B gilt aRb genau dann, wenn (a,b)∈R.','R\\subseteq A\\times B,\\qquad aRb\\iff(a,b)\\in R','R\\subseteq A\\times B,\\qquad aRb\\iff(a,b)\\in R','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.5',@section_id,'Relation auf einer Menge','Eine binäre Relation R auf einer Menge M ist eine Teilmenge von M×M.','R\\subseteq M\\times M','R\\subseteq M\\times M','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.6',@section_id,'n-stellige Relation','Für Mengen A_1 bis A_n ist eine n-stellige Relation R eine Teilmenge des kartesischen Produkts A_1×…×A_n.','R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n','R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n','adapted',@source_73,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.7',@section_id,'Reflexivität','Eine Relation R auf M heißt reflexiv, wenn jedes Element zu sich selbst in Relation steht; sie heißt irreflexiv, wenn kein Element zu sich selbst in Relation steht.','\\forall x\\in M:\\;xRx','\\forall x\\in M:\\;xRx','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.8',@section_id,'Symmetrie und Antisymmetrie','Eine Relation R auf M heißt symmetrisch, wenn aus xRy stets yRx folgt. Sie heißt antisymmetrisch, wenn aus xRy und yRx die Gleichheit x=y folgt.','\\forall x,y\\in M:\\;xRy\\rightarrow yRx','\\forall x,y\\in M:\\;xRy\\rightarrow yRx','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.9',@section_id,'Transitivität','Eine Relation R auf M heißt transitiv, wenn aus xRy und yRz stets xRz folgt.','\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz','\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.10',@section_id,'Äquivalenzrelation','Eine Relation auf M heißt Äquivalenzrelation, wenn sie reflexiv, symmetrisch und transitiv ist.','\\sim\\;\\text{ist reflexiv, symmetrisch und transitiv}','\\sim\\;\\text{ist reflexiv, symmetrisch und transitiv}','adapted',@source_72,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.11',@section_id,'Partielle Ordnung','Eine Relation auf M heißt partielle Ordnung, wenn sie reflexiv, antisymmetrisch und transitiv ist.','\\preceq\\;\\text{ist reflexiv, antisymmetrisch und transitiv}','\\preceq\\;\\text{ist reflexiv, antisymmetrisch und transitiv}','adapted',@source_72,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.12',@section_id,'Umkehrrelation','Für R⊆A×B ist die Umkehrrelation R^{-1}⊆B×A durch Vertauschung aller geordneten Paare definiert.','R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}','R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.13',@section_id,'Relationale Komposition','Für R⊆A×B und S⊆B×C enthält S∘R genau diejenigen Paare (a,c), für die ein vermittelndes b∈B mit aRb und bSc existiert.','S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}','S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}','adapted',@source_75,
 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.',
 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
 source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);


INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('3.2.2',@section_id,'Äquivalenzrelationen und Partitionen',
 'Jede Äquivalenzrelation auf einer Menge M erzeugt eine Partition von M. Umgekehrt bestimmt jede Partition von M eine Äquivalenzrelation.',
 '\sim\;\longleftrightarrow\;\mathcal{C}',
 '\sim\;\longleftrightarrow\;\mathcal{C}',
 'adapted',@source_72,
 'Die Begriffe Äquivalenzrelation, Äquivalenzklasse und Partition sind definiert.','checked',@revision_id),
('3.2.3',@section_id,'Assoziativität der relationalen Komposition',
 'Für Relationen R⊆A×B, S⊆B×C und T⊆C×D gilt T∘(S∘R)=(T∘S)∘R.',
 'T\circ(S\circ R)=(T\circ S)\circ R',
 'T\circ(S\circ R)=(T\circ S)\circ R',
 'literature',@source_75,
 'Die beteiligten Relationen besitzen kompatible Definitions- und Zielmengen.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),statement_text=VALUES(statement_text),
 statement_latex=VALUES(statement_latex),word_latex=VALUES(word_latex),
 provenance=VALUES(provenance),source_id=VALUES(source_id),assumptions=VALUES(assumptions),
 validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

SET @theorem_322 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.2' LIMIT 1);
SET @theorem_323 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.3' LIMIT 1);

INSERT INTO proofs
(proof_number,section_id,theorem_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT
 '3.2.2-P',@section_id,@theorem_322,'Beweis der Korrespondenz zwischen Äquivalenzrelationen und Partitionen',
 'Die Äquivalenzklassen überdecken wegen der Reflexivität die gesamte Menge. Schneiden sich zwei Klassen, folgen aus Symmetrie und Transitivität ihre Gleichheit; sie sind daher identisch oder disjunkt. Umgekehrt definiert die gemeinsame Zugehörigkeit zu genau einem Block einer Partition eine reflexive, symmetrische und transitive Relation.',
 'x\sim_{\mathcal C}y\iff\exists C\in\mathcal C:\;x\in C\land y\in C',
 'equivalence','adapted',@source_72,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.2-P');

INSERT INTO proofs
(proof_number,section_id,theorem_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT
 '3.2.3-P',@section_id,@theorem_323,'Beweis der Assoziativität relationaler Komposition',
 'Die elementweise Auflösung beider Kompositionen führt jeweils auf dieselbe Existenzbedingung: Es existieren b und c mit (a,b)∈R, (b,c)∈S und (c,d)∈T. Daher sind beide Relationen extensional gleich.',
 '(a,d)\in T\circ(S\circ R)\iff\exists b\exists c:\;(a,b)\in R\land(b,c)\in S\land(c,d)\in T\iff(a,d)\in(T\circ S)\circ R',
 'direct','adapted',@source_75,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.3-P');


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.159',@section_id,'Binäre Relation','R\\subseteq A\\times B','R\\subseteq A\\times B','Formale Darstellung: Binäre Relation.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.160',@section_id,'Relationsschreibweise','aRb \\iff (a,b)\\in R','aRb \\iff (a,b)\\in R','Formale Darstellung: Relationsschreibweise.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.161',@section_id,'Relation auf einer Menge','R\\subseteq M\\times M','R\\subseteq M\\times M','Formale Darstellung: Relation auf einer Menge.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.162',@section_id,'n-stellige Relation','R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n','R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n','Formale Darstellung: n-stellige Relation.','definition',
 'adapted',@source_73,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.163',@section_id,'Tupelzugehörigkeit','(a_1,a_2,\\ldots,a_n)\\in R','(a_1,a_2,\\ldots,a_n)\\in R','Formale Darstellung: Tupelzugehörigkeit.','definition',
 'adapted',@source_73,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.164',@section_id,'Reflexivität','\\forall x\\in M:\\;xRx','\\forall x\\in M:\\;xRx','Formale Darstellung: Reflexivität.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.165',@section_id,'Irreflexivität','\\forall x\\in M:\\;\\neg(xRx)','\\forall x\\in M:\\;\\neg(xRx)','Formale Darstellung: Irreflexivität.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.166',@section_id,'Diagonale','\\Delta_M=\\{(x,x)\\mid x\\in M\\}','\\Delta_M=\\{(x,x)\\mid x\\in M\\}','Formale Darstellung: Diagonale.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.167',@section_id,'Reflexivität über die Diagonale','\\Delta_M\\subseteq R','\\Delta_M\\subseteq R','Formale Darstellung: Reflexivität über die Diagonale.','theorem',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.168',@section_id,'Symmetrie','\\forall x,y\\in M:\\;xRy\\rightarrow yRx','\\forall x,y\\in M:\\;xRy\\rightarrow yRx','Formale Darstellung: Symmetrie.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.169',@section_id,'Antisymmetrie','\\forall x,y\\in M:\\;(xRy\\land yRx)\\rightarrow x=y','\\forall x,y\\in M:\\;(xRy\\land yRx)\\rightarrow x=y','Formale Darstellung: Antisymmetrie.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.170',@section_id,'Transitivität','\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz','\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz','Formale Darstellung: Transitivität.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.171',@section_id,'Äquivalenzrelation','\\begin{aligned}&\\forall x\\in M:\\;x\\sim x,\\\\&\\forall x,y\\in M:\\;x\\sim y\\rightarrow y\\sim x,\\\\&\\forall x,y,z\\in M:\\;(x\\sim y\\land y\\sim z)\\rightarrow x\\sim z.\\end{aligned}','\\begin{aligned}&\\forall x\\in M:\\;x\\sim x,\\\\&\\forall x,y\\in M:\\;x\\sim y\\rightarrow y\\sim x,\\\\&\\forall x,y,z\\in M:\\;(x\\sim y\\land y\\sim z)\\rightarrow x\\sim z.\\end{aligned}','Formale Darstellung: Äquivalenzrelation.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.172',@section_id,'Äquivalenzklasse','[x]_{\\sim}=\\{y\\in M\\mid y\\sim x\\}','[x]_{\\sim}=\\{y\\in M\\mid y\\sim x\\}','Formale Darstellung: Äquivalenzklasse.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.173',@section_id,'Quotientenmenge','M/{\\sim}=\\{[x]_{\\sim}\\mid x\\in M\\}','M/{\\sim}=\\{[x]_{\\sim}\\mid x\\in M\\}','Formale Darstellung: Quotientenmenge.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.174',@section_id,'Von einer Partition induzierte Äquivalenz','x\\sim_{\\mathcal{C}}y\\iff\\exists C\\in\\mathcal{C}:\\;x\\in C\\land y\\in C','x\\sim_{\\mathcal{C}}y\\iff\\exists C\\in\\mathcal{C}:\\;x\\in C\\land y\\in C','Formale Darstellung: Von einer Partition induzierte Äquivalenz.','derived',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.175',@section_id,'Partielle Ordnung','\\begin{aligned}&\\forall x\\in M:\\;x\\preceq x,\\\\&\\forall x,y\\in M:\\;(x\\preceq y\\land y\\preceq x)\\rightarrow x=y,\\\\&\\forall x,y,z\\in M:\\;(x\\preceq y\\land y\\preceq z)\\rightarrow x\\preceq z.\\end{aligned}','\\begin{aligned}&\\forall x\\in M:\\;x\\preceq x,\\\\&\\forall x,y\\in M:\\;(x\\preceq y\\land y\\preceq x)\\rightarrow x=y,\\\\&\\forall x,y,z\\in M:\\;(x\\preceq y\\land y\\preceq z)\\rightarrow x\\preceq z.\\end{aligned}','Formale Darstellung: Partielle Ordnung.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.176',@section_id,'Partiell geordnete Menge','(M,\\preceq)','(M,\\preceq)','Formale Darstellung: Partiell geordnete Menge.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.177',@section_id,'Totale Vergleichbarkeit','\\forall x,y\\in M:\\;x\\preceq y\\lor y\\preceq x','\\forall x,y\\in M:\\;x\\preceq y\\lor y\\preceq x','Formale Darstellung: Totale Vergleichbarkeit.','definition',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.178',@section_id,'Umkehrrelation','R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}','R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}','Formale Darstellung: Umkehrrelation.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.179',@section_id,'Umkehrrelation in Infixnotation','bR^{-1}a\\iff aRb','bR^{-1}a\\iff aRb','Formale Darstellung: Umkehrrelation in Infixnotation.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.180',@section_id,'Symmetriekriterium','R^{-1}=R','R^{-1}=R','Formale Darstellung: Symmetriekriterium.','theorem',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.181',@section_id,'Relationale Komposition','S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}','S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}','Formale Darstellung: Relationale Komposition.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.182',@section_id,'Assoziativität der Komposition','T\\circ(S\\circ R)=(T\\circ S)\\circ R','T\\circ(S\\circ R)=(T\\circ S)\\circ R','Formale Darstellung: Assoziativität der Komposition.','theorem',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.183',@section_id,'Elementweiser Nachweis der Assoziativität','\\begin{aligned}(a,d)\\in T\\circ(S\\circ R)&\\iff\\exists c\\in C:\\bigl((a,c)\\in S\\circ R\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B\\;\\exists c\\in C:\\bigl((a,b)\\in R\\land(b,c)\\in S\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B:\\bigl((a,b)\\in R\\land(b,d)\\in T\\circ S\\bigr)\\\\&\\iff(a,d)\\in(T\\circ S)\\circ R.\\end{aligned}','\\begin{aligned}(a,d)\\in T\\circ(S\\circ R)&\\iff\\exists c\\in C:\\bigl((a,c)\\in S\\circ R\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B\\;\\exists c\\in C:\\bigl((a,b)\\in R\\land(b,c)\\in S\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B:\\bigl((a,b)\\in R\\land(b,d)\\in T\\circ S\\bigr)\\\\&\\iff(a,d)\\in(T\\circ S)\\circ R.\\end{aligned}','Formale Darstellung: Elementweiser Nachweis der Assoziativität.','derived',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.184',@section_id,'Nichtkommutativität im Allgemeinen','S\\circ R\\neq R\\circ S','S\\circ R\\neq R\\circ S','Formale Darstellung: Nichtkommutativität im Allgemeinen.','other',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.185',@section_id,'Erste Relationspotenz','R^1=R','R^1=R','Formale Darstellung: Erste Relationspotenz.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.186',@section_id,'Rekursive Relationspotenz','R^{n+1}=R\\circ R^n','R^{n+1}=R\\circ R^n','Formale Darstellung: Rekursive Relationspotenz.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.187',@section_id,'Transitive Hülle','R^{+}=\\bigcup_{n=1}^{\\infty}R^n','R^{+}=\\bigcup_{n=1}^{\\infty}R^n','Formale Darstellung: Transitive Hülle.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.188',@section_id,'Reflexiv-transitive Hülle','R^{*}=\\Delta_M\\cup R^{+}','R^{*}=\\Delta_M\\cup R^{+}','Formale Darstellung: Reflexiv-transitive Hülle.','definition',
 'adapted',@source_75,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.189',@section_id,'Endliche Trägermengen','A=\\{a_1,\\ldots,a_m\\},\\qquad B=\\{b_1,\\ldots,b_n\\}','A=\\{a_1,\\ldots,a_m\\},\\qquad B=\\{b_1,\\ldots,b_n\\}','Formale Darstellung: Endliche Trägermengen.','schema',
 'adapted',@source_72,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.190',@section_id,'Relationsmatrix','\\mathbf{M}_R=(r_{ij})','\\mathbf{M}_R=(r_{ij})','Formale Darstellung: Relationsmatrix.','definition',
 'adapted',@source_74,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.191',@section_id,'Einträge der Relationsmatrix','r_{ij}=\\begin{cases}1,&(a_i,b_j)\\in R,\\\\0,&(a_i,b_j)\\notin R\\end{cases}','r_{ij}=\\begin{cases}1,&(a_i,b_j)\\in R,\\\\0,&(a_i,b_j)\\notin R\\end{cases}','Formale Darstellung: Einträge der Relationsmatrix.','definition',
 'adapted',@source_74,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,
 provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.192',@section_id,'Boolesche Matrixkomposition','(\\mathbf{M}_{S\\circ R})_{ik}=\\bigvee_{j=1}^{n}\\left((\\mathbf{M}_R)_{ij}\\land(\\mathbf{M}_S)_{jk}\\right)','(\\mathbf{M}_{S\\circ R})_{ik}=\\bigvee_{j=1}^{n}\\left((\\mathbf{M}_R)_{ij}\\land(\\mathbf{M}_S)_{jk}\\right)','Formale Darstellung: Boolesche Matrixkomposition.','derived',
 'adapted',@source_74,NULL,
 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
 assumptions=VALUES(assumptions),validation_status=VALUES(validation_status),
 created_revision_id=VALUES(created_revision_id);


-- Gleichungssymbole: zentrale, abschnittsübergreifend verwendete Zeichen


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.159' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'R','Relation R','Ausgewählte Teilmenge eines kartesischen Produkts.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.159' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'A\\times B','Kartesisches Produkt','Menge aller geordneten Paare aus A und B.',NULL,'Relationentheorie',2
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.166' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'\\Delta_M','Diagonale von M','Menge aller Paare (x,x) mit x aus M.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.171' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'\\sim','Äquivalenzrelation','Reflexive, symmetrische und transitive Relation.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.172' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'[x]_{\\sim}','Äquivalenzklasse','Klasse aller zu x äquivalenten Elemente.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.173' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'M/{\\sim}','Quotientenmenge','Menge sämtlicher Äquivalenzklassen.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.175' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'\\preceq','Partielle Ordnung','Reflexive, antisymmetrische und transitive Relation.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.178' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'R^{-1}','Umkehrrelation','Relation mit vertauschter Paarreihenfolge.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.181' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'S\\circ R','Relationale Komposition','Über ein Zwischenelement vermittelte Verkettung von R und S.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.187' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'R^{+}','Transitive Hülle','Vereinigung aller positiven Relationspotenzen.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.188' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'R^{*}','Reflexiv-transitive Hülle','Transitive Hülle einschließlich Identitätsrelation.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.190' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'\\mathbf{M}_R','Relationsmatrix','Binäre Matrixdarstellung einer endlichen Relation.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.192' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'\\bigvee','Boolesche Disjunktion','Boolesche Addition bei der Matrixkomposition.',NULL,'Relationentheorie',1
WHERE @eq_id IS NOT NULL;


SET @eq_id := (SELECT equation_id FROM equations WHERE equation_number='3.192' LIMIT 1);
INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_id,'\\land','Boolesche Konjunktion','Boolesche Multiplikation bei der Matrixkomposition.',NULL,'Relationentheorie',2
WHERE @eq_id IS NOT NULL;


-- Zähler
INSERT INTO repository_counters(counter_key,counter_value)
VALUES('next_citation_number','76')
ON DUPLICATE KEY UPDATE
 counter_value=CASE WHEN CAST(counter_value AS UNSIGNED)<76 THEN '76' ELSE counter_value END;

-- Änderungsprotokoll
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'created','section','3.2.2',
 'Abschnitt 3.2.2 wurde vollständig angelegt und repositoryseitig abgeschlossen.',
 NULL,'status=final; Forschungsstand ohne FRZK-Eigenaxiomatik'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='created' AND object_reference='3.2.2'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'source_added','sources','[73]-[75]',
 'Drei neue Primärquellen zur Relationslogik und zum Relationskalkül wurden aufgenommen.',
 'next_citation_number=73','next_citation_number=76'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='source_added' AND object_reference='[73]-[75]'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'source_reused','source','[72]',
 'Bourbaki wurde für mengentheoretische Relationen, Äquivalenzklassen, Quotientenmengen und Ordnungen wiederverwendet.',
 NULL,'source_usage registriert'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='source_reused' AND object_reference='[72]'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'definition_added','definitions','3.2.4-3.2.13',
 'Zehn Definitionen der Relationentheorie wurden registriert.',NULL,'10 Definitionen'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='definition_added' AND object_reference='3.2.4-3.2.13'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'statement_added','theorems','3.2.2-3.2.3',
 'Die Sätze zur Korrespondenz von Äquivalenzrelationen und Partitionen sowie zur Assoziativität der relationalen Komposition wurden registriert.',
 NULL,'2 Sätze'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='statement_added' AND object_reference='3.2.2-3.2.3'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'proof_added','proofs','3.2.2-P;3.2.3-P',
 'Zu beiden Sätzen wurden vollständige Beweisdatensätze aufgenommen.',NULL,'2 Beweise'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='proof_added' AND object_reference='3.2.2-P;3.2.3-P'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'equation_added','equations','(3.159)-(3.192)',
 'Vierunddreißig Gleichungen einschließlich Word-LaTeX wurden registriert.',
 NULL,'34 Gleichungen'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='equation_added' AND object_reference='(3.159)-(3.192)'
);

-- Validierungen
INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-SECTION',
 IF(COUNT(*)=1,'passed','failed'),'1',CAST(COUNT(*) AS CHAR),
 'Abschnitt 3.2.2 muss genau einmal vorhanden sein.'
FROM dissertation_sections WHERE section_code='3.2.2'
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-NEW-SOURCES',
 IF(COUNT(*)=3,'passed','failed'),'3',CAST(COUNT(*) AS CHAR),
 'Die neuen Quellen [73] bis [75] müssen vollständig vorhanden sein.'
FROM sources WHERE citation_number BETWEEN 73 AND 75
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-SOURCE-USAGE',
 IF(COUNT(*)=4,'passed','failed'),'4',CAST(COUNT(*) AS CHAR),
 'Die Quellen [72] bis [75] müssen mit Abschnitt 3.2.2 verknüpft sein.'
FROM source_usage su JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id AND s.citation_number BETWEEN 72 AND 75
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-DEFINITIONS',
 IF(COUNT(*)=10,'passed','failed'),'10',CAST(COUNT(*) AS CHAR),
 'Die Definitionen 3.2.4 bis 3.2.13 müssen vollständig registriert sein.'
FROM definitions WHERE section_id=@section_id
AND definition_number IN ('3.2.4','3.2.5','3.2.6','3.2.7','3.2.8','3.2.9','3.2.10','3.2.11','3.2.12','3.2.13')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-THEOREMS',
 IF(COUNT(*)=2,'passed','failed'),'2',CAST(COUNT(*) AS CHAR),
 'Die Sätze 3.2.2 und 3.2.3 müssen vollständig registriert sein.'
FROM theorems WHERE section_id=@section_id AND theorem_number IN ('3.2.2','3.2.3')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-PROOFS',
 IF(COUNT(*)=2,'passed','failed'),'2',CAST(COUNT(*) AS CHAR),
 'Zu den Sätzen 3.2.2 und 3.2.3 müssen zwei Beweise vorhanden sein.'
FROM proofs WHERE section_id=@section_id AND proof_number IN ('3.2.2-P','3.2.3-P')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-EQUATIONS',
 IF(COUNT(*)=34,'passed','failed'),'34',CAST(COUNT(*) AS CHAR),
 'Die Gleichungen (3.159) bis (3.192) müssen vollständig registriert sein.'
FROM equations WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 159 AND 192
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-WORD-LATEX',
 IF(COUNT(*)=34,'passed','failed'),'34',CAST(COUNT(*) AS CHAR),
 'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 159 AND 192
AND word_latex IS NOT NULL AND TRIM(word_latex)<>''
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-PARENT-REVISION',
 IF(parent_revision_id=@parent_revision_id,'passed','failed'),
 CAST(@parent_revision_id AS CHAR),CAST(parent_revision_id AS CHAR),
 'Die Revision 3.2.2 muss unmittelbar auf 3.2.1 aufbauen.'
FROM repository_revisions WHERE revision_id=@revision_id
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.2-NEXT-CITATION',
 IF(CAST(counter_value AS UNSIGNED)>=76,'passed','failed'),'>=76',counter_value,
 'Nach [75] muss die nächste freie Literaturziffer mindestens [76] sein.'
FROM repository_counters WHERE counter_key='next_citation_number'
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),
 expected_value=VALUES(expected_value),actual_value=VALUES(actual_value),
 validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

COMMIT;

-- Audit
SELECT revision_id,revision_code,scope_reference,version_label,parent_revision_id,revision_date
FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.2-V1';

SELECT section_id,parent_section_id,section_code,title,status,is_original_contribution
FROM dissertation_sections WHERE section_code='3.2.2';

SELECT citation_number,source_key,short_citation_text,verification_status
FROM sources WHERE citation_number BETWEEN 73 AND 75 ORDER BY citation_number;

SELECT definition_number,title,validation_status
FROM definitions WHERE section_id=@section_id ORDER BY definition_number;

SELECT theorem_number,title,validation_status
FROM theorems WHERE section_id=@section_id ORDER BY theorem_number;

SELECT proof_number,title,proof_method,validation_status
FROM proofs WHERE section_id=@section_id ORDER BY proof_number;

SELECT equation_number,title,equation_type,validation_status
FROM equations WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results WHERE revision_id=@revision_id
ORDER BY validation_code;
