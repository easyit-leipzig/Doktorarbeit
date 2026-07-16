USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.2.10 – Masterstandard V5, vollständig und idempotent
   Graphen- und Netzwerktheorie als mathematische Grundlage relationaler Strukturen
   Neue Quellen [77] Euler und [78] Diestel
   Gleichungen (3.245)–(3.266) */

SET @parent_revision_id := (SELECT `revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-15-K3.2.9-NEUFASSUNG-V3' LIMIT 1);
INSERT INTO `repository_revisions` (`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`) VALUES
('RKB-2026-07-15-K3.2.10-NEUFASSUNG-V5',NOW(),'section','3.2.10','5.0','Vollständige Neufassung von Abschnitt 3.2.10 mit Graphen, Adjazenzmatrizen, Graden, Wegen, Distanzen, Zusammenhang und gewichteten Netzwerken.','Olaf Thiele / ChatGPT',@parent_revision_id)
ON DUPLICATE KEY UPDATE `revision_id`=LAST_INSERT_ID(`revision_id`),`revision_date`=VALUES(`revision_date`),`summary`=VALUES(`summary`),`parent_revision_id`=VALUES(`parent_revision_id`);
SET @revision_id:=LAST_INSERT_ID();
SET @section_id:=(SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.10' LIMIT 1);
UPDATE `dissertation_sections` SET `title`='Graphen- und Netzwerktheorie als mathematische Grundlage relationaler Strukturen',`status`='review',`is_original_contribution`=0,`notes`='Masterstandard V5 mit Quellen [77]–[78] und Gleichungen (3.245)–(3.266).',`updated_at`=NOW() WHERE `section_id`=@section_id;

/* Abschnittsartefakte kontrolliert bereinigen. */
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';
DELETE FROM `section_change_log` WHERE `section_id`=@section_id AND `revision_id`=@revision_id;

SET @old_source_77:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=77 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id`=@old_source_77;
DELETE FROM `annotations` WHERE `source_id`=@old_source_77;
DELETE FROM `source_topics` WHERE `source_id`=@old_source_77;
DELETE FROM `source_relations` WHERE `source_id_from`=@old_source_77 OR `source_id_to`=@old_source_77;
DELETE FROM `source_authors` WHERE `source_id`=@old_source_77;
DELETE FROM `sources` WHERE `source_id`=@old_source_77;
SET @old_source_78:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=78 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id`=@old_source_78;
DELETE FROM `annotations` WHERE `source_id`=@old_source_78;
DELETE FROM `source_topics` WHERE `source_id`=@old_source_78;
DELETE FROM `source_relations` WHERE `source_id_from`=@old_source_78 OR `source_id_to`=@old_source_78;
DELETE FROM `source_authors` WHERE `source_id`=@old_source_78;
DELETE FROM `sources` WHERE `source_id`=@old_source_78;

INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Euler','Leonhard','Euler, Leonhard',1707,1783,'Begründer der Graphentheorie durch das Königsberger Brückenproblem.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_euler:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Euler, Leonhard' LIMIT 1);
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Diestel','Reinhard','Diestel, Reinhard',1959,NULL,'Autor eines internationalen Standardwerks der modernen Graphentheorie.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_diestel:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Diestel, Reinhard' LIMIT 1);

INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES
(77,'euler_koenigsberger_bruecken_1736','journal_article','Solutio problematis ad geometriam situs pertinentis',1736,1736,'Commentarii Academiae Scientiarum Imperialis Petropolitanae',NULL,NULL,'8',NULL,'128–140','la',5,'primary',5,'verified','3.2.10','Erstnennung zur historischen Entstehung der Graphentheorie.','Euler, Leonhard: Solutio problematis ad geometriam situs pertinentis. Commentarii Academiae Scientiarum Imperialis Petropolitanae, Bd. 8, 1736, S. 128–140.','Euler [77]','Primärquelle des Königsberger Brückenproblems.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_77_id:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`publisher`,`place`,`edition`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES
(78,'diestel_graph_theory_2017','book','Graph Theory',1997,2017,'Springer','Berlin','5th Edition','en',5,'reference',5,'verified','3.2.10','Erstnennung als modernes Standardwerk der Graphentheorie.','Diestel, Reinhard: Graph Theory. 5. Auflage. Berlin: Springer, 2017.','Diestel [78]','Standardwerk für Definitionen und strukturelle Eigenschaften von Graphen.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`edition`=VALUES(`edition`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_78_id:=LAST_INSERT_ID();
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_77_id,@author_euler,1,'author'),(@source_78_id,@author_diestel,1,'author') ON DUPLICATE KEY UPDATE `author_order`=VALUES(`author_order`),`role`=VALUES(`role`);

INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES
(@source_77_id,'Einführung einer rein relationalen Problembeschreibung unabhängig von geometrischen Längen und Winkeln.','Historischer Ausgangspunkt der Graphentheorie in Abschnitt 3.2.10.','Belegt die Entstehung eines strukturellen, nichtmetrischen Zugangs zu Verbindungsproblemen.','Die relationale Struktur kann unabhängig von geometrischer Einbettung untersucht werden.','Die Arbeit enthält noch keine moderne abstrakte Graphentheorie.','Wird durch Diestels moderne Darstellung ergänzt.','reviewed',NOW())
ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`adopted_claims`=VALUES(`adopted_claims`),`limitations`=VALUES(`limitations`),`scientific_discussion`=VALUES(`scientific_discussion`),`annotation_status`='reviewed',`reviewed_at`=NOW();
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES
(@source_78_id,'Systematische moderne Darstellung von Graphen, Wegen, Zusammenhang, Matrizen und gewichteten Strukturen.','Zentrale Referenz für alle mathematischen Definitionen von Abschnitt 3.2.10.','Belegt die formale Graphstruktur und ihre elementaren Eigenschaften.','Graphen modellieren relationale Systeme unabhängig von der konkreten Bedeutung ihrer Knoten und Kanten.','Funktionale Genese und semantische Bedeutung der Relationen sind nicht Gegenstand der Theorie.','Diese Grenze wird als Übergang zur FRZK-Forschungslücke verwendet.','reviewed',NOW())
ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`adopted_claims`=VALUES(`adopted_claims`),`limitations`=VALUES(`limitations`),`scientific_discussion`=VALUES(`scientific_discussion`),`annotation_status`='reviewed',`reviewed_at`=NOW();

INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES
(@source_77_id,@section_id,'first_citation','Historische Begründung der Graphentheorie durch das Königsberger Brückenproblem.','Einleitender Forschungsstand',1,1,'Neue Erstnennung [77].',@revision_id),
(@source_78_id,@section_id,'first_citation','Moderne Definitionen und Eigenschaften von Graphen und Netzwerken.','Definition eines Graphen und folgende mathematische Grundlagen',1,1,'Neue Erstnennung [78].',@revision_id),
(@source_78_id,@section_id,'definition','Adjazenzmatrix, Knotengrad, Wege, Distanzen, Zusammenhang und Gewichtung.','Gesamter mathematischer Formalismus 3.2.10',0,1,'Zentrale Standardquelle.',@revision_id);

INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.1',@section_id,'Graph','Ein Graph ist ein geordnetes Paar aus einer Knotenmenge und einer Kantenmenge.','G=(V,E)','G=(V,E)','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.2',@section_id,'Gerichteter Graph','Ein gerichteter Graph besitzt Kanten als geordnete Paare von Knoten.','E\\subseteq V\\times V','E\\subseteq V\\times V','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.3',@section_id,'Ungerichteter Graph','Ein ungerichteter Graph besitzt Kanten als ungeordnete Zweiermengen von Knoten.','\\{v_i,v_j\\}\\in E','\\{v_i,v_j\\}\\in E','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.4',@section_id,'Einfacher Graph','Ein einfacher Graph enthält keine Schleifen und höchstens eine Kante zwischen zwei Knoten.','(v_i,v_i)\\notin E','(v_i,v_i)\\notin E','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.5',@section_id,'Adjazenzmatrix','Die Adjazenzmatrix kodiert die Kantenstruktur eines endlichen Graphen in Matrixform.','A=(a_{ij})','A=(a_{ij})','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.6',@section_id,'Knotengrad','Der Knotengrad ist die Anzahl der an einen Knoten angrenzenden Kanten.','\\deg(v_i)=\\sum_j a_{ij}','\\deg(v_i)=\\sum_j a_{ij}','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.7',@section_id,'Weg','Ein Weg ist eine Knotenfolge, in der je zwei aufeinanderfolgende Knoten durch eine Kante verbunden sind.','(v_i,v_{i+1})\\in E','(v_i,v_{i+1})\\in E','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.8',@section_id,'Graphendistanz','Die Graphendistanz ist die Länge eines kürzesten Pfades zwischen zwei Knoten.','d(v_i,v_j)=\\min_{P\\in\\mathcal P(v_i,v_j)}|P|','d(v_i,v_j)=\\min_{P\\in\\mathcal P(v_i,v_j)}|P|','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.9',@section_id,'Zusammenhängender Graph','Ein Graph ist zusammenhängend, wenn zwischen jedem Knotenpaar mindestens ein Pfad existiert.','\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal P(v_i,v_j)','\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal P(v_i,v_j)','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.10',@section_id,'Gewichteter Graph','Ein gewichteter Graph besitzt eine Gewichtsfunktion auf seiner Kantenmenge.','w:E\\to\\mathbb R','w:E\\to\\mathbb R','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.10.11',@section_id,'Knotenstärke','Die Knotenstärke ist die Summe der Gewichte aller an einem Knoten anliegenden Kanten.','s(v_i)=\\sum_j w_{ij}','s(v_i)=\\sum_j w_{ij}','literature',@source_78_id,NULL,'Masterstandard V5 für Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.245',@section_id,'Definition eines Graphen','G=(V,E)','G=(V,E)','Graph als geordnetes Paar aus Knoten- und Kantenmenge.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_245:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.246',@section_id,'Kantenmenge eines gerichteten Graphen','E\\subseteq V\\times V','E\\subseteq V\\times V','Gerichtete Kanten als geordnete Paare von Knoten.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_246:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.247',@section_id,'Gerichtete Kante','(v_i,v_j)\\in E','(v_i,v_j)\\in E','Gerichtete Relation vom Knoten vi zum Knoten vj.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_247:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.248',@section_id,'Ungerichtete Kante','\\{v_i,v_j\\}\\in E','\\{v_i,v_j\\}\\in E','Ungerichtete Verbindung zweier Knoten.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_248:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.249',@section_id,'Schleifenfreiheit eines einfachen Graphen','(v_i,v_i)\\notin E','(v_i,v_i)\\notin E','Ausschluss von Selbstkanten in einfachen Graphen.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_249:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.250',@section_id,'Schleife','(v_i,v_i)\\in E','(v_i,v_i)\\in E','Selbstkante eines Knotens.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_250:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.251',@section_id,'Adjazenzmatrix','A=(a_{ij})\\in\\{0,1\\}^{n\\times n}','A=(a_{ij})\\in\\{0,1\\}^{n\\times n}','Binäre Matrixdarstellung eines endlichen Graphen.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_251:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.252',@section_id,'Elemente der Adjazenzmatrix','a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}','a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}','Definition der Matrixeinträge durch das Vorliegen einer Kante.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_252:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.253',@section_id,'Potenzen der Adjazenzmatrix','(A^k)_{ij}','(A^k)_{ij}','Anzahl gerichteter Wege der Länge k von vi nach vj.','derived','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_253:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.254',@section_id,'Knotengrad im ungerichteten Graphen','\\deg(v_i)=\\sum_{j=1}^{n}a_{ij}','\\deg(v_i)=\\sum_{j=1}^{n}a_{ij}','Anzahl der an vi inzidenten Kanten.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_254:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.255',@section_id,'Eingangsgrad','\\deg^{-}(v_i)=\\sum_{j=1}^{n}a_{ji}','\\deg^{-}(v_i)=\\sum_{j=1}^{n}a_{ji}','Anzahl eingehender Kanten eines Knotens.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_255:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.256',@section_id,'Ausgangsgrad','\\deg^{+}(v_i)=\\sum_{j=1}^{n}a_{ij}','\\deg^{+}(v_i)=\\sum_{j=1}^{n}a_{ij}','Anzahl ausgehender Kanten eines Knotens.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_256:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.257',@section_id,'Knotenfolge eines Weges','v_0,v_1,\\ldots,v_k','v_0,v_1,\\ldots,v_k','Geordnete Knotenfolge eines Weges.','schema','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_257:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.258',@section_id,'Kantenbedingung eines Weges','(v_i,v_{i+1})\\in E\\qquad\\forall i\\in\\{0,\\ldots,k-1\\}','(v_i,v_{i+1})\\in E\\qquad\\forall i\\in\\{0,\\ldots,k-1\\}','Aufeinanderfolgende Knoten eines Weges sind durch Kanten verbunden.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_258:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.259',@section_id,'Länge eines Weges','k','k','Anzahl der Kanten eines Weges.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_259:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.260',@section_id,'Zyklusbedingung','v_0=v_k','v_0=v_k','Identität von Anfangs- und Endknoten eines Zyklus.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_260:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.261',@section_id,'Graphendistanz','d(v_i,v_j)=\\min_{P\\in\\mathcal{P}(v_i,v_j)}|P|','d(v_i,v_j)=\\min_{P\\in\\mathcal{P}(v_i,v_j)}|P|','Länge eines kürzesten Pfades zwischen zwei Knoten.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_261:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.262',@section_id,'Unendliche Distanz','d(v_i,v_j)=\\infty','d(v_i,v_j)=\\infty','Distanz nicht verbundener Knoten.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_262:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.263',@section_id,'Zusammenhang eines Graphen','\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal{P}(v_i,v_j)','\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal{P}(v_i,v_j)','Existenz eines Pfades zwischen jedem Knotenpaar.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_263:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.264',@section_id,'Gewichtsfunktion','w:E\\longrightarrow\\mathbb{R}','w:E\\longrightarrow\\mathbb{R}','Zuordnung numerischer Kantengewichte.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_264:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.265',@section_id,'Gewichtete Adjazenzmatrix','W=(w_{ij})','W=(w_{ij})','Matrixdarstellung eines gewichteten Graphen.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_265:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.266',@section_id,'Knotenstärke','s(v_i)=\\sum_{j=1}^{n}w_{ij}','s(v_i)=\\sum_{j=1}^{n}w_{ij}','Summe der Kantengewichte eines Knotens.','definition','literature',@source_78_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_266:=LAST_INSERT_ID();

INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_245,'G','Graph','Geordnetes Paar aus Knoten- und Kantenmenge.',NULL,NULL,1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_245,'V','Knotenmenge','Menge aller Knoten des Graphen.',NULL,NULL,2)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_245,'E','Kantenmenge','Menge aller Kanten des Graphen.',NULL,NULL,3)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_251,'A','Adjazenzmatrix','Binäre Matrixdarstellung des Graphen.',NULL,'\\{0,1\\}^{n\\times n}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_252,'a_{ij}','Adjazenzeintrag','Kantenindikator zwischen vi und vj.',NULL,'\\{0,1\\}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_254,'\\deg(v_i)','Knotengrad','Anzahl der Nachbarn von vi.',NULL,'\\mathbb N_0',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_261,'d','Graphendistanz','Länge eines kürzesten Pfades.',NULL,'\\mathbb N_0\\cup\\{\\infty\\}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_264,'w','Gewichtsfunktion','Zuordnung eines Wertes zu jeder Kante.',NULL,'\\mathbb R',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_265,'W','gewichtete Adjazenzmatrix','Matrix der Kantengewichte.',NULL,'\\mathbb R^{n\\times n}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_266,'s(v_i)','Knotenstärke','Summe der Kantengewichte eines Knotens.',NULL,'\\mathbb R',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);

INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('G','G','Graph','Geordnetes Paar aus Knoten- und Kantenmenge.','section',@section_id,@eq_3_245,NULL,NULL,NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('V','V','Knotenmenge','Menge aller Knoten.','section',@section_id,@eq_3_245,NULL,NULL,NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('E','E','Kantenmenge','Menge aller Kanten.','section',@section_id,@eq_3_245,NULL,NULL,NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('A','A','Adjazenzmatrix','Binäre Matrixdarstellung eines endlichen Graphen.','section',@section_id,@eq_3_251,NULL,'\\{0,1\\}^{n\\times n}',NULL,0,1,0,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('d','d','Graphendistanz','Länge eines kürzesten Pfades zwischen zwei Knoten.','section',@section_id,@eq_3_261,NULL,NULL,'\\mathbb N_0\\cup\\{\\infty\\}',0,0,0,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('w','w','Gewichtsfunktion','Numerische Bewertung von Kanten.','section',@section_id,@eq_3_264,NULL,'E','\\mathbb R',0,0,1,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('W','W','gewichtete Adjazenzmatrix','Matrix der Kantengewichte.','section',@section_id,@eq_3_265,NULL,'\\mathbb R^{n\\times n}',NULL,0,1,0,'Zentrales Symbol von Abschnitt 3.2.10.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_matrix`=VALUES(`is_matrix`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES
(@revision_id,@section_id,'rewritten','section','3.2.10','Abschnitt 3.2.10 vollständig im Masterstandard V5 neu gefasst.',NULL,'Graphen, Adjazenzmatrizen, Grade, Wege, Distanzen, Zusammenhang und gewichtete Netzwerke.'),
(@revision_id,@section_id,'source_added','sources','[77]–[78]','Zwei Quellen vollständig registriert.',NULL,'Euler [77], Diestel [78].'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.2.10.1–Def. 3.2.10.11','Elf Definitionen registriert.',NULL,'Graph bis Knotenstärke.'),
(@revision_id,@section_id,'equation_added','equations','(3.245)–(3.266)','22 Gleichungen registriert.',NULL,'Vollständiger mathematischer Formalismus des Abschnitts.');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES
('next_citation_number','79'),('next_equation_number','3.267'),('last_edited_section','3.2.10'),('last_repository_revision','RKB-2026-07-15-K3.2.10-NEUFASSUNG-V5')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);
COMMIT;

/* Abschlussaudit. */
SELECT `revision_id`,`revision_code`,`parent_revision_id`,`scope_reference`,`version_label` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-15-K3.2.10-NEUFASSUNG-V5';
SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes` FROM `dissertation_sections` WHERE `section_code`='3.2.10';
SELECT `citation_number`,`source_key`,`title`,`verification_status` FROM `sources` WHERE `citation_number` IN (77,78) ORDER BY `citation_number`;
SELECT COUNT(*) AS `source_usage_count`,SUM(`is_first_mention`) AS `first_mentions`,SUM(`citation_checked`) AS `checked_usages` FROM `source_usage` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `definition_count` FROM `definitions` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `equation_count` FROM `equations` WHERE `section_id`=@section_id;
SELECT MIN(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `first_equation`,MAX(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `last_equation` FROM `equations` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `equation_symbol_count` FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
SELECT COUNT(*) AS `duplicate_equation_numbers` FROM (SELECT `equation_number` FROM `equations` GROUP BY `equation_number` HAVING COUNT(*)>1) d;
SELECT COUNT(*) AS `duplicate_equation_symbols` FROM (SELECT `equation_id`,`symbol_latex` FROM `equation_symbols` GROUP BY `equation_id`,`symbol_latex` HAVING COUNT(*)>1) d;
SELECT COUNT(*) AS `missing_word_latex` FROM `equations` WHERE `section_id`=@section_id AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision') ORDER BY `counter_key`;