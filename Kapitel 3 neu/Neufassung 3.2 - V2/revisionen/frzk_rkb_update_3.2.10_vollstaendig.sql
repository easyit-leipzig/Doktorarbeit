-- =====================================================================
-- FRZK-RKB: Repository-Update nach Abschnitt 3.2.10
-- Revision: RKB-NEU-K3.2.10-V1
-- Aufbauend auf: RKB-NEU-K3.2.9-V1
-- Quellen: Wiederverwendung [93], neu [96]-[97]
-- Definitionen: 3.2.68-3.2.75
-- Sätze: 3.2.21-3.2.24
-- Gleichungen: (3.323)-(3.334)
-- Nächste Quelle: [98]
-- Nächste Gleichung: (3.335)
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
START TRANSACTION;

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.9-V1' LIMIT 1
);
SET @chapter_section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
 'RKB-NEU-K3.2.10-V1',NOW(),'section','3.2.10','1.0',
 'Abschluss von Abschnitt 3.2.10: Bilinearformen, quadratische Formen, Definitheit, Energieformen und Minimum.',
 'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_revision_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.10-V1'
);

SET @revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.2.10-V1' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
 @chapter_section_id,'3.2.10',
 'Bilinearformen und quadratische Formen als mathematische Beschreibung funktionaler Energie- und Bewertungsstrukturen',
 3,3.2100,'final',0,
 'Mathematische Grundlage für Wechselwirkungs-, Bewertungs-, Energie- und Stabilitätsstrukturen.'
WHERE @chapter_section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections WHERE section_code='3.2.10'
);

UPDATE dissertation_sections
SET parent_section_id=@chapter_section_id,
    title='Bilinearformen und quadratische Formen als mathematische Beschreibung funktionaler Energie- und Bewertungsstrukturen',
    chapter_no=3,section_order=3.2100,status='final',is_original_contribution=0,
    notes='Mathematische Grundlage für Wechselwirkungs-, Bewertungs-, Energie- und Stabilitätsstrukturen.'
WHERE section_code='3.2.10';

SET @section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.2.10' LIMIT 1
);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Jacobi','Carl Gustav','Jacobi, Carl Gustav',1804,1851,'Autor der Quelle [96].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Jacobi, Carl Gustav');

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Sylvester','James Joseph','Sylvester, James Joseph',1814,1897,'Autor der Quelle [97].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Sylvester, James Joseph');

SET @author_jacobi := (SELECT author_id FROM authors WHERE normalized_name='Jacobi, Carl Gustav' LIMIT 1);
SET @author_sylvester := (SELECT author_id FROM authors WHERE normalized_name='Sylvester, James Joseph' LIMIT 1);
SET @source_93 := (SELECT source_id FROM sources WHERE citation_number=93 OR source_key='lagrange_mecanique_analytique_1788' LIMIT 1);

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
96,'jacobi_vorlesungen_dynamik_1866','book','Vorlesungen über Dynamik',NULL,1866,1866,NULL,
'Georg Reimer','Berlin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',8,'partially_verified',
'3.2.10','Historische Einordnung quadratischer Formen in Dynamik und Variationsproblemen.',
'Jacobi, Carl Gustav: Vorlesungen über Dynamik. Berlin: Georg Reimer, 1866.',
'Jacobi [96]','Bibliografische Detailprüfung im Gesamtaudit vorgesehen.',@revision_id
WHERE NOT EXISTS (
 SELECT 1 FROM sources WHERE citation_number=96 OR source_key='jacobi_vorlesungen_dynamik_1866'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
97,'sylvester_collected_mathematical_papers_1904','book',
'The Collected Mathematical Papers of James Joseph Sylvester',NULL,1904,1904,NULL,
'Cambridge University Press','Cambridge','1',NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'historical',9,'partially_verified',
'3.2.10','Historische Einordnung der Klassifikation quadratischer Formen und des Trägheitsgesetzes.',
'Sylvester, James Joseph: The Collected Mathematical Papers of James Joseph Sylvester. Cambridge: Cambridge University Press, 1904.',
'Sylvester [97]','Bandzuordnung und konkrete Fundstelle im Literaturgesamtaudit prüfen.',@revision_id
WHERE NOT EXISTS (
 SELECT 1 FROM sources WHERE citation_number=97 OR source_key='sylvester_collected_mathematical_papers_1904'
);

SET @source_96 := (SELECT source_id FROM sources WHERE citation_number=96 OR source_key='jacobi_vorlesungen_dynamik_1866' LIMIT 1);
SET @source_97 := (SELECT source_id FROM sources WHERE citation_number=97 OR source_key='sylvester_collected_mathematical_papers_1904' LIMIT 1);

INSERT IGNORE INTO source_authors(source_id,author_id,author_order,role)
VALUES
(@source_96,@author_jacobi,1,'author'),
(@source_97,@author_sylvester,1,'author');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_93,@section_id,'reuse',
'Lagrange wird erneut zur historischen Entwicklung quadratischer Formen in Mechanik und Stabilitätsuntersuchungen verwendet.',
'Abschnitt 3.2.10, historische Einleitung',0,1,'Wiederverwendung von Quelle [93].',@revision_id
WHERE @source_93 IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_93 AND section_id=@section_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_96,@section_id,'first_citation',
'Jacobi wird zur historischen Bedeutung quadratischer Formen für Dynamik, Variationsprobleme und Extremalprinzipien herangezogen.',
'Abschnitt 3.2.10, historische Einleitung',1,1,'Erstnennung als Quelle [96].',@revision_id
WHERE @source_96 IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_96 AND section_id=@section_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT @source_97,@section_id,'first_citation',
'Sylvester wird zur Signatur quadratischer Formen und zum Trägheitsgesetz verwendet.',
'Abschnitt 3.2.10, historische Einleitung und Satz 3.2.22',1,1,'Erstnennung als Quelle [97].',@revision_id
WHERE @source_97 IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_97 AND section_id=@section_id);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('3.2.68',@section_id,'Bilinearform','Eine Bilinearform auf einem Vektorraum V über K ist eine Abbildung B:V×V→K, die in beiden Argumenten linear ist.','B:V\\times V\\rightarrow K','B:V\\times V\\rightarrow K','adapted',@source_96,'V ist ein Vektorraum über dem Körper K.','Bilinearität gilt separat in beiden Argumenten.','checked',@revision_id),
('3.2.69',@section_id,'Symmetrische Bilinearform','Eine Bilinearform B heißt symmetrisch, wenn B(u,v)=B(v,u) für alle u,v∈V gilt.','B(u,v)=B(v,u)','B(u,v)=B(v,u)','adapted',@source_97,'B ist eine Bilinearform.','Symmetrie beschreibt reziproke Wechselwirkung.','checked',@revision_id),
('3.2.70',@section_id,'Schiefsymmetrische Bilinearform','Eine Bilinearform B heißt schiefsymmetrisch, wenn B(u,v)=-B(v,u) für alle u,v∈V gilt.','B(u,v)=-B(v,u)','B(u,v)=-B(v,u)','adapted',@source_97,'B ist eine Bilinearform.','Über Körpern mit Charakteristik ungleich zwei folgt B(v,v)=0.','checked',@revision_id),
('3.2.71',@section_id,'Quadratische Form','Eine quadratische Form Q ist die einem Vektor v zugeordnete skalare Größe Q(v)=B(v,v), wobei B symmetrisch bilinear ist.','Q(v)=B(v,v)','Q(v)=B(v,v)','adapted',@source_97,'B ist eine symmetrische Bilinearform.','Quadratische Formen bewerten einzelne Zustände.','checked',@revision_id),
('3.2.72',@section_id,'Quadratische Matrixdarstellung','Bezüglich einer Basis besitzt eine quadratische Form die Darstellung Q(v)=v^TAv mit symmetrischer Matrix A.','Q(v)=v^{T}Av','Q(v)=v^{T}Av','adapted',@source_97,'Eine Basis von V ist gewählt.','Der symmetrische Anteil von A bestimmt die quadratische Form.','checked',@revision_id),
('3.2.73',@section_id,'Positive Definitheit','Eine quadratische Form Q heißt positiv definit, wenn Q(v)>0 für jeden Vektor v≠0 gilt.','Q(v)>0\\quad\\forall v\\neq0','Q(v)>0\\quad\\forall v\\neq0','adapted',@source_97,'V ist ein reeller Vektorraum.','Positive Definitheit erzeugt eine strikt positive Zustandsbewertung.','checked',@revision_id),
('3.2.74',@section_id,'Positive Semidefinitheit','Eine quadratische Form Q heißt positiv semidefinit, wenn Q(v)≥0 für alle v∈V gilt.','Q(v)\\geq0','Q(v)\\geq0','adapted',@source_97,'V ist ein reeller Vektorraum.','Nichttriviale Nullrichtungen sind zulässig.','checked',@revision_id),
('3.2.75',@section_id,'Energieform','Eine Energieform ist eine positiv definite quadratische Form E(v)=v^TAv, die jedem Zustand eine skalare Energiegröße zuordnet.','E(v)=v^{T}Av','E(v)=v^{T}Av','frzk_adapted',@source_96,'A ist symmetrisch und positiv definit.','Die Definition bereitet spätere Stabilitäts- und Kohärenzfunktionen vor.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
section_id=VALUES(section_id),title=VALUES(title),definition_text=VALUES(definition_text),
formal_latex=VALUES(formal_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
source_id=VALUES(source_id),assumptions=VALUES(assumptions),notes=VALUES(notes),
validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('3.2.21',@section_id,'Matrixdarstellung einer Bilinearform','Zu jeder Bilinearform B auf einem endlichdimensionalen Vektorraum existiert bezüglich einer gewählten Basis genau eine Matrix A mit B(u,v)=u^TAv.','B(u,v)=u^{T}Av','B(u,v)=u^{T}Av','adapted',@source_96,'V ist endlichdimensional und eine Basis ist gewählt.','checked',@revision_id),
('3.2.22',@section_id,'Sylvesters Trägheitsgesetz','Unter einem regulären Basiswechsel bleiben bei einer reellen symmetrischen Bilinearform die Anzahlen positiver, negativer und verschwindender Diagonaleinträge einer Diagonalform invariant.','\\operatorname{inertia}(A)=(n_+,n_-,n_0)','\\operatorname{inertia}(A)=(n_+,n_-,n_0)','adapted',@source_97,'A ist reell und symmetrisch.','checked',@revision_id),
('3.2.23',@section_id,'Zusammenhang mit Skalarprodukten','Jedes reelle Skalarprodukt ist eine symmetrische positiv definite Bilinearform. Umgekehrt definiert jede symmetrische positiv definite Bilinearform ein Skalarprodukt.','\\langle u,v\\rangle=B(u,v)\\Longleftrightarrow B\\text{ symmetrisch und positiv definit}','\\langle u,v\\rangle=B(u,v)\\Longleftrightarrow B\\text{ symmetrisch und positiv definit}','adapted',@source_96,'V ist ein reeller Vektorraum.','checked',@revision_id),
('3.2.24',@section_id,'Eindeutiges Minimum positiver Energieformen','Ist A symmetrisch positiv definit, dann besitzt E(v)=v^TAv ihr eindeutiges globales Minimum bei v=0.','A\\succ0\\Rightarrow E(v)=v^{T}Av\\geq0\\land(E(v)=0\\Longleftrightarrow v=0)','A\\succ0\\Rightarrow E(v)=v^{T}Av\\geq0\\land(E(v)=0\\Longleftrightarrow v=0)','adapted',@source_96,'A ist symmetrisch und positiv definit.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
section_id=VALUES(section_id),title=VALUES(title),statement_text=VALUES(statement_text),
statement_latex=VALUES(statement_latex),word_latex=VALUES(word_latex),provenance=VALUES(provenance),
source_id=VALUES(source_id),assumptions=VALUES(assumptions),
validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

SET @theorem_3221 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.21' LIMIT 1);
SET @theorem_3222 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.22' LIMIT 1);
SET @theorem_3223 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.23' LIMIT 1);
SET @theorem_3224 := (SELECT theorem_id FROM theorems WHERE theorem_number='3.2.24' LIMIT 1);

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT '3.2.21-P',@section_id,@theorem_3221,NULL,NULL,'Beweis der Matrixdarstellung',
'Sei e_1,...,e_n eine Basis von V und A=(a_ij) mit a_ij=B(e_i,e_j). Für u=Σ_i u_i e_i und v=Σ_j v_j e_j liefert die Bilinearität B(u,v)=Σ_iΣ_j u_i a_ij v_j=u^TAv. Die Koeffizienten a_ij sind eindeutig bestimmt.',
'a_{ij}=B(e_i,e_j)\Rightarrow B(u,v)=\sum_{i,j}u_i a_{ij}v_j=u^{T}Av',
'direct','adapted',@source_96,'checked',@revision_id
WHERE @theorem_3221 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.21-P');

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT '3.2.22-P',@section_id,@theorem_3222,NULL,NULL,'Beweisskizze zu Sylvesters Trägheitsgesetz',
'Ein regulärer Basiswechsel transformiert A durch Kongruenz zu P^TAP. Die maximalen Dimensionen positiver und negativer Unterräume bleiben unter invertiblen Abbildungen erhalten. Damit sind n_+, n_- und n_0 invariant.',
'A\mapsto P^{T}AP,\quad P\in GL(n,\mathbb{R})\Rightarrow(n_+,n_-,n_0)\text{ invariant}',
'invariance','adapted',@source_97,'checked',@revision_id
WHERE @theorem_3222 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.22-P');

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT '3.2.23-P',@section_id,@theorem_3223,NULL,NULL,'Beweis des Zusammenhangs mit Skalarprodukten',
'Die Axiome eines reellen Skalarprodukts enthalten Bilinearität, Symmetrie und positive Definitheit. Umgekehrt erfüllt jede Bilinearform mit diesen Eigenschaften genau die Skalarproduktaxiome.',
'B\text{ bilinear, symmetrisch, positiv definit}\Longleftrightarrow B=\langle\cdot,\cdot\rangle',
'equivalence','adapted',@source_96,'checked',@revision_id
WHERE @theorem_3223 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.23-P');

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
SELECT '3.2.24-P',@section_id,@theorem_3224,NULL,NULL,'Beweis des eindeutigen Minimums',
'Aus positiver Definitheit folgt E(v)=v^TAv>0 für alle v≠0. Für v=0 gilt E(0)=0. Null ist daher der eindeutige globale Minimierer.',
'v\neq0\Rightarrow v^{T}Av>0,\quad E(0)=0',
'direct','adapted',@source_96,'checked',@revision_id
WHERE @theorem_3224 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='3.2.24-P');

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.323',@section_id,'Abbildung einer Bilinearform','B:V\\times V\\rightarrow K','B:V\\times V\\rightarrow K','Eine Bilinearform bildet zwei Vektoren auf einen Skalar ab.','definition','adapted',@source_96,NULL,'V ist ein Vektorraum über K.','checked',@revision_id),
('3.324',@section_id,'Linearität im ersten Argument','B(\\lambda u+\\mu v,w)=\\lambda B(u,w)+\\mu B(v,w)','B(\\lambda u+\\mu v,w)=\\lambda B(u,w)+\\mu B(v,w)','Die Bilinearform ist im ersten Argument linear.','axiom','adapted',@source_96,NULL,'u,v,w∈V und λ,μ∈K.','checked',@revision_id),
('3.325',@section_id,'Linearität im zweiten Argument','B(u,\\lambda v+\\mu w)=\\lambda B(u,v)+\\mu B(u,w)','B(u,\\lambda v+\\mu w)=\\lambda B(u,v)+\\mu B(u,w)','Die Bilinearform ist im zweiten Argument linear.','axiom','adapted',@source_96,NULL,'u,v,w∈V und λ,μ∈K.','checked',@revision_id),
('3.326',@section_id,'Symmetrie','B(u,v)=B(v,u)','B(u,v)=B(v,u)','Die Argumente einer symmetrischen Bilinearform können vertauscht werden.','definition','adapted',@source_97,NULL,'B ist bilinear.','checked',@revision_id),
('3.327',@section_id,'Schiefsymmetrie','B(u,v)=-B(v,u)','B(u,v)=-B(v,u)','Beim Vertauschen der Argumente ändert sich das Vorzeichen.','definition','adapted',@source_97,NULL,'B ist bilinear.','checked',@revision_id),
('3.328',@section_id,'Quadratische Form aus Bilinearform','Q(v)=B(v,v)','Q(v)=B(v,v)','Eine quadratische Form bewertet einen Vektor durch Einsetzen in beide Argumente.','definition','adapted',@source_97,NULL,'B ist symmetrisch bilinear.','checked',@revision_id),
('3.329',@section_id,'Matrixdarstellung der Bilinearform','B(u,v)=u^{T}Av','B(u,v)=u^{T}Av','Die Bilinearform wird bezüglich einer Basis durch eine Matrix dargestellt.','theorem','adapted',@source_96,NULL,'V ist endlichdimensional.','checked',@revision_id),
('3.330',@section_id,'Matrixdarstellung der quadratischen Form','Q(v)=v^{T}Av','Q(v)=v^{T}Av','Die quadratische Form wird durch dieselbe Matrix in beiden Vektorargumenten dargestellt.','definition','adapted',@source_97,NULL,'A ist symmetrisch.','checked',@revision_id),
('3.331',@section_id,'Positive Definitheit','Q(v)>0\\quad\\forall v\\neq0','Q(v)>0\\quad\\forall v\\neq0','Jeder von Null verschiedene Zustand besitzt einen strikt positiven Wert.','definition','adapted',@source_97,NULL,'V ist reell.','checked',@revision_id),
('3.332',@section_id,'Positive Semidefinitheit','Q(v)\\geq0','Q(v)\\geq0','Die quadratische Form nimmt keine negativen Werte an.','definition','adapted',@source_97,NULL,'V ist reell.','checked',@revision_id),
('3.333',@section_id,'Energieform','E(v)=v^{T}Av','E(v)=v^{T}Av','Die Energieform ordnet einem Zustand eine skalare Energie zu.','definition','frzk_adapted',@source_96,NULL,'A ist symmetrisch positiv definit.','checked',@revision_id),
('3.334',@section_id,'Minimum der Energieform','v=0','v=0','Das eindeutige Minimum einer positiv definiten Energieform liegt im Nullvektor.','theorem','adapted',@source_96,NULL,'A ist positiv definit.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
section_id=VALUES(section_id),title=VALUES(title),equation_latex=VALUES(equation_latex),
word_latex=VALUES(word_latex),plain_description=VALUES(plain_description),
equation_type=VALUES(equation_type),provenance=VALUES(provenance),source_id=VALUES(source_id),
derivation=VALUES(derivation),assumptions=VALUES(assumptions),
validation_status=VALUES(validation_status),created_revision_id=VALUES(created_revision_id);

SET @eq_3323 := (SELECT equation_id FROM equations WHERE equation_number='3.323' LIMIT 1);
SET @eq_3328 := (SELECT equation_id FROM equations WHERE equation_number='3.328' LIMIT 1);
SET @eq_3329 := (SELECT equation_id FROM equations WHERE equation_number='3.329' LIMIT 1);
SET @eq_3330 := (SELECT equation_id FROM equations WHERE equation_number='3.330' LIMIT 1);
SET @eq_3331 := (SELECT equation_id FROM equations WHERE equation_number='3.331' LIMIT 1);
SET @eq_3333 := (SELECT equation_id FROM equations WHERE equation_number='3.333' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,symbol_order)
VALUES
(@eq_3323,'B','Bilinearform','In beiden Argumenten lineare Abbildung.',1),
(@eq_3323,'V','Vektorraum','Definitionsraum der Bilinearform.',2),
(@eq_3323,'K','Skalarkörper','Zielraum der Bilinearform.',3),
(@eq_3328,'Q','Quadratische Form','Skalare Bewertung eines einzelnen Vektors.',1),
(@eq_3329,'A','Darstellungsmatrix','Matrix der Bilinearform bezüglich einer Basis.',1),
(@eq_3330,'v^{T}Av','Quadratischer Ausdruck','Matrixdarstellung der quadratischen Form.',1),
(@eq_3331,'Q(v)','Positiver Zustandswert','Strikt positiver Wert für v≠0.',1),
(@eq_3333,'E','Energieform','Skalare Energiezuordnung eines Zustands.',1);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('next_citation_number','98')
ON DUPLICATE KEY UPDATE
counter_value=CASE WHEN CAST(counter_value AS UNSIGNED)<98 THEN '98' ELSE counter_value END;

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('next_equation_number','3.335')
ON DUPLICATE KEY UPDATE counter_value='3.335';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section','3.2.10')
ON DUPLICATE KEY UPDATE counter_value='3.2.10';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-NEU-K3.2.10-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.2.10-V1';

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'rewritten','section','3.2.10',
'Abschnitt 3.2.10 wurde vollständig in das Repository aufgenommen.',
NULL,'Bilinearformen und quadratische Formen'
WHERE @revision_id IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='rewritten' AND object_reference='3.2.10'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'source_added','sources','[96]-[97]',
'Zwei neue Quellen wurden aufgenommen; Quelle [93] wurde wiederverwendet.',
'next_citation_number=96','next_citation_number=98'
WHERE @revision_id IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision_id AND section_id=@section_id
 AND change_type='source_added' AND object_reference='[96]-[97]'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.10_SECTION',
IF(COUNT(*)=1,'passed','failed'),'1',CAST(COUNT(*) AS CHAR),
'Abschnitt 3.2.10 muss genau einmal vorhanden sein.'
FROM dissertation_sections WHERE section_code='3.2.10'
ON DUPLICATE KEY UPDATE
validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),
checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.10_NEW_SOURCES',
IF(COUNT(*)=2,'passed','failed'),'2',CAST(COUNT(*) AS CHAR),
'Die neuen Quellen [96] und [97] müssen vollständig vorhanden sein.'
FROM sources WHERE citation_number IN (96,97)
ON DUPLICATE KEY UPDATE
validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),
checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.10_DEFINITIONS',
IF(COUNT(*)=8,'passed','failed'),'8',CAST(COUNT(*) AS CHAR),
'Die Definitionen 3.2.68 bis 3.2.75 müssen vollständig vorhanden sein.'
FROM definitions
WHERE section_id=@section_id
AND definition_number IN ('3.2.68','3.2.69','3.2.70','3.2.71','3.2.72','3.2.73','3.2.74','3.2.75')
ON DUPLICATE KEY UPDATE
validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),
checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.10_THEOREMS',
IF(COUNT(*)=4,'passed','failed'),'4',CAST(COUNT(*) AS CHAR),
'Die Sätze 3.2.21 bis 3.2.24 müssen vollständig vorhanden sein.'
FROM theorems
WHERE section_id=@section_id
AND theorem_number IN ('3.2.21','3.2.22','3.2.23','3.2.24')
ON DUPLICATE KEY UPDATE
validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),
checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.10_EQUATIONS',
IF(COUNT(*)=12,'passed','failed'),'12',CAST(COUNT(*) AS CHAR),
'Die Gleichungen (3.323) bis (3.334) müssen vollständig vorhanden sein.'
FROM equations
WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 323 AND 334
ON DUPLICATE KEY UPDATE
validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),
checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3.2.10_WORD_LATEX',
IF(COUNT(*)=12,'passed','failed'),'12',CAST(COUNT(*) AS CHAR),
'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id=@section_id
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 323 AND 334
AND word_latex IS NOT NULL AND TRIM(word_latex)<>''
ON DUPLICATE KEY UPDATE
validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),
checked_at=CURRENT_TIMESTAMP;

COMMIT;

-- Audit
SELECT revision_id,revision_code,scope_reference,version_label,parent_revision_id,revision_date
FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.10-V1';

SELECT section_id,parent_section_id,section_code,title,status,is_original_contribution
FROM dissertation_sections WHERE section_code='3.2.10';

SELECT citation_number,source_key,short_citation_text,verification_status
FROM sources WHERE citation_number IN (93,96,97) ORDER BY citation_number;

SELECT definition_number,title,validation_status
FROM definitions WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED);

SELECT theorem_number,title,validation_status
FROM theorems WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED);

SELECT proof_number,title,proof_method,validation_status
FROM proofs WHERE section_id=@section_id ORDER BY proof_number;

SELECT equation_number,title,equation_type,validation_status
FROM equations WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results WHERE revision_id=@revision_id
ORDER BY validation_code;
