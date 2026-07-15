USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;
/* Abschnitt 3.2.5 – vollständige Neufassung V2
   Voraussetzung: 3_2_4_neufassung_repository_update_V2_korrigiert.sql wurde ausgeführt.
   Neue Quellen [66]–[67]. Gleichungen (3.107)–(3.135). */

SET @parent_revision_id := (SELECT `revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-14-K3.2.4-NEUFASSUNG-V2' LIMIT 1);
INSERT INTO `repository_revisions` (`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`) VALUES ('RKB-2026-07-15-K3.2.5-NEUFASSUNG-V2',NOW(),'section','3.2.5','2.0','Vollständige Neufassung von Abschnitt 3.2.5 mit allgemeinem Operatorbegriff, Definitions- und Wertebereich, linearen Operatoren, Kern und Bild, Operatoralgebra, Invertierbarkeit und Spektrum.','Olaf Thiele / ChatGPT',@parent_revision_id) ON DUPLICATE KEY UPDATE `revision_id`=LAST_INSERT_ID(`revision_id`),`revision_date`=VALUES(`revision_date`),`summary`=VALUES(`summary`),`parent_revision_id`=VALUES(`parent_revision_id`);
SET @revision_id := LAST_INSERT_ID();
SET @revision_id := COALESCE(@revision_id,(SELECT `revision_id` FROM `repository_revisions` WHERE `scope_reference`='3.2.5' ORDER BY `revision_id` DESC LIMIT 1));
SET @section_id := (SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.5' LIMIT 1);
UPDATE `dissertation_sections` SET `title`='Operatoren als mathematische Beschreibung funktionaler Transformationen',`status`='review',`is_original_contribution`=0,`notes`='Vollständige Neufassung V2 mit Quellen [66]–[67] und Gleichungen (3.107)–(3.135).' WHERE `section_id`=@section_id;

/* Abschnittsbezogene Altinhalte entfernen */
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';

/* Etwaige frühere Belegung der neuen Literaturziffern kontrolliert ersetzen */
SET @old_source_66 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=66 LIMIT 1);
SET @old_source_67 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=67 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id` IN (@old_source_66,@old_source_67);
DELETE FROM `annotations` WHERE `source_id` IN (@old_source_66,@old_source_67);
DELETE FROM `source_topics` WHERE `source_id` IN (@old_source_66,@old_source_67);
DELETE FROM `source_relations` WHERE `source_id_from` IN (@old_source_66,@old_source_67) OR `source_id_to` IN (@old_source_66,@old_source_67);
DELETE FROM `source_authors` WHERE `source_id` IN (@old_source_66,@old_source_67);
DELETE FROM `sources` WHERE `source_id` IN (@old_source_66,@old_source_67);

/* Autoren */
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Hilbert','David','Hilbert, David',1862,1943,'Historische Primärquelle zu Integralgleichungen und Operatoren.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Banach','Stefan','Banach, Stefan',1892,1945,'Primärquelle zur linearen Funktionalanalysis und Operatorentheorie.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_hilbert := (SELECT `author_id` FROM `authors` WHERE `normalized_name`='Hilbert, David' LIMIT 1);
SET @author_banach := (SELECT `author_id` FROM `authors` WHERE `normalized_name`='Banach, Stefan' LIMIT 1);

/* Quellen [66]–[67] */
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (66,'hilbert_integralgleichungen_1912','book','Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen',1912,1912,NULL,'B. G. Teubner','Leipzig',NULL,NULL,NULL,'de',5,'primary',5,'partially_verified','3.2.5','Historische Primärquelle zur Entwicklung der Operatorentheorie.','Hilbert, David: Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen. Leipzig: B. G. Teubner, 1912.','Hilbert [66]','Begründet die systematische Betrachtung linearer Integraloperatoren.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_66_id := LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (67,'banach_operations_lineaires_1932','book','Théorie des opérations linéaires',1932,1932,NULL,'Monografie Matematyczne','Warszawa','1',NULL,NULL,'fr',5,'primary',5,'partially_verified','3.2.5','Primärquelle zur allgemeinen Theorie linearer Operatoren auf normierten Räumen.','Banach, Stefan: Théorie des opérations linéaires. Warszawa: Monografie Matematyczne, 1932.','Banach [67]','Grundlage der linearen Funktionalanalysis und der Theorie beschränkter Operatoren.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_67_id := LAST_INSERT_ID();
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_66_id,@author_hilbert,1,'author'),(@source_67_id,@author_banach,1,'author') ON DUPLICATE KEY UPDATE `role`=VALUES(`role`);

/* Quellenannotationen */
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_66_id,'Systematische Theorie linearer Integralgleichungen und Integraloperatoren.','Historische Grundlage der Operatorentheorie in 3.2.5.','Belegt den Übergang von konkreten Integralgleichungen zur Untersuchung von Operatoren auf Funktionenräumen.','Operatoren können als eigenständige mathematische Transformationsobjekte behandelt werden.','Historische Darstellung vor der vollständigen Banachraumtheorie.','Wird durch Banachs allgemeinen funktionalanalytischen Rahmen ergänzt.','reviewed',NOW()) ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`annotation_status`='reviewed',`reviewed_at`=NOW();
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_67_id,'Allgemeine Theorie linearer Operationen auf normierten und vollständigen Räumen.','Zentrale Primärquelle für lineare Operatoren, Kern, Bild und Operatoralgebra.','Belegt die funktionalanalytische Fundierung der Operatorentheorie.','Lineare Operatoren werden durch Raumstruktur, Linearität und Abbildungseigenschaften charakterisiert.','Schwerpunkt auf linearer Theorie.','Nichtlineare Entwicklungen werden in späteren Abschnitten getrennt behandelt.','reviewed',NOW()) ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`annotation_status`='reviewed',`reviewed_at`=NOW();

/* Vorhandene Standardquellen auflösen */
SET @source_11_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=11 LIMIT 1);
SET @source_35_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=35 LIMIT 1);
SET @source_36_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=36 LIMIT 1);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_66_id,@section_id,'first_citation','Historische Entwicklung linearer Integraloperatoren','Einleitender Forschungsstand zu Hilbert',1,1,'Neue Erstnennung [66].',@revision_id),(@source_67_id,@section_id,'first_citation','Allgemeine Theorie linearer Operatoren auf normierten Räumen','Einleitender Forschungsstand zu Banach',1,1,'Neue Erstnennung [67].',@revision_id),(@source_35_id,@section_id,'definition','Allgemeiner Operatorbegriff, Komposition und Spektrum','Mathematische Definitionen und Operatoralgebra',0,1,'Bestehende Standardquelle wiederverwendet.',@revision_id),(@source_36_id,@section_id,'definition','Lineare Operatoren, Kern, Bild und Invertierbarkeit','Abschnitte zu linearen Operatoren und Operatoralgebra',0,1,'Bestehende Standardquelle wiederverwendet.',@revision_id),(@source_11_id,@section_id,'background','Spektraltheorie und Operatoren auf Funktionenräumen','Abschnitt zum Spektrum',0,1,'Bestehende Standardquelle wiederverwendet.',@revision_id);

/* Definitionen */
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.1',@section_id,'Operator','Ein Operator ist eine Abbildung zwischen mathematisch strukturierten Räumen.','T:X\\longrightarrow Y','T:X\\longrightarrow Y','literature',@source_35_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.2',@section_id,'Endomorpher Operator','Ein Operator auf X bildet den Raum X in sich selbst ab.','T:X\\longrightarrow X','T:X\\longrightarrow X','literature',@source_35_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.3',@section_id,'Definitionsbereich eines Operators','Der Definitionsbereich enthält alle Elemente, auf denen der Operator tatsächlich definiert ist.','\\mathcal{D}(T)\\subseteq X','\\mathcal{D}(T)\\subseteq X','literature',@source_36_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.4',@section_id,'Wertebereich eines Operators','Der Wertebereich enthält alle durch den Operator tatsächlich erzeugten Bilder.','\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}','\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}','literature',@source_36_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.5',@section_id,'Linearer Operator','Ein Operator ist linear, wenn er Addition und Skalarmultiplikation erhält.','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','literature',@source_67_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.6',@section_id,'Kern eines linearen Operators','Der Kern enthält alle Elemente, die auf den Nullvektor abgebildet werden.','\\ker(T)=\\{x\\in X\\mid T(x)=0\\}','\\ker(T)=\\{x\\in X\\mid T(x)=0\\}','literature',@source_67_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.7',@section_id,'Bild eines linearen Operators','Das Bild enthält alle durch den Operator erreichbaren Elemente des Zielraums.','\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}','\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}','literature',@source_67_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.8',@section_id,'Invertierbarer Operator','Ein Operator ist invertierbar, wenn eine beidseitige Umkehrabbildung existiert.','T^{-1}\\circ T=I_X,\\quad T\\circ T^{-1}=I_Y','T^{-1}\\circ T=I_X,\\quad T\\circ T^{-1}=I_Y','literature',@source_35_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.9',@section_id,'Endomorphismenring','Die Menge aller linearen Endomorphismen eines Vektorraums bildet unter Addition und Komposition eine Operatoralgebra.','\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}','\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}','literature',@source_36_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.5.10',@section_id,'Spektrum eines Operators','Das Spektrum besteht aus allen komplexen Zahlen, für die T minus Lambda mal I nicht invertierbar ist.','\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}','\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}','literature',@source_11_id,NULL,'Stand der Forschung; keine FRZK-Eigenleistung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `definition_id`=LAST_INSERT_ID(`definition_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `definition_text`=VALUES(`definition_text`),
  `formal_latex`=VALUES(`formal_latex`),
  `word_latex`=VALUES(`word_latex`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `assumptions`=VALUES(`assumptions`),
  `notes`=VALUES(`notes`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);

/* Gleichungen (3.107)–(3.135) */
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.107',@section_id,'Allgemeiner Operator','T:X\\longrightarrow Y','T:X\\longrightarrow Y','Operator als Abbildung zwischen mathematisch strukturierten Räumen.','definition','literature',@source_35_id,NULL,'X und Y sind geeignete mathematische Räume.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_107 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.108',@section_id,'Operatorbild eines Elements','T(x)\\in Y','T(x)\\in Y','Bild eines Elements unter dem Operator.','derived','literature',@source_35_id,NULL,'x\\in X.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_108 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.109',@section_id,'Operator auf einem Raum','T:X\\longrightarrow X','T:X\\longrightarrow X','Endomorpher Operator auf X.','definition','literature',@source_35_id,NULL,'Definitions- und Zielraum stimmen überein.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_109 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.110',@section_id,'Rekursive Operatorwirkung','x_{n+1}=T(x_n)','x_{n+1}=T(x_n)','Ein Folgezustand entsteht durch Operatoranwendung.','model','literature',@source_35_id,NULL,'x_n\\in X.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_110 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.111',@section_id,'Iterierte Operatorwirkung','x_n=T^n(x_0)','x_n=T^n(x_0)','n-fache Komposition eines Operators.','derived','literature',@source_35_id,NULL,'n\\in\\mathbb N.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_111 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.112',@section_id,'Definitionsbereich','\\mathcal{D}(T)\\subseteq X','\\mathcal{D}(T)\\subseteq X','Tatsächlicher Definitionsbereich eines Operators.','definition','literature',@source_36_id,NULL,'T ist möglicherweise nicht auf ganz X definiert.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_112 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.113',@section_id,'Operator mit explizitem Definitionsbereich','T:\\mathcal{D}(T)\\longrightarrow Y','T:\\mathcal{D}(T)\\longrightarrow Y','Operatorabbildung mit eingeschränkter Domäne.','definition','literature',@source_36_id,NULL,'\\mathcal{D}(T)\\subseteq X.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_113 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.114',@section_id,'Wertebereich eines Operators','\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}\\subseteq Y','\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}\\subseteq Y','Menge aller tatsächlich erzeugten Operatorbilder.','definition','literature',@source_36_id,NULL,NULL,'checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_114 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.115',@section_id,'Linearitätsbedingung','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','Erhalt von Linearkombinationen.','definition','literature',@source_67_id,NULL,'X und Y sind Vektorräume über demselben Körper.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_115 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.116',@section_id,'Additivität','T(x+y)=T(x)+T(y)','T(x+y)=T(x)+T(y)','Erhalt der Vektoraddition.','derived','literature',@source_67_id,NULL,'T ist linear.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_116 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.117',@section_id,'Homogenität','T(\\alpha x)=\\alpha T(x)','T(\\alpha x)=\\alpha T(x)','Erhalt der Skalarmultiplikation.','derived','literature',@source_67_id,NULL,'T ist linear.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_117 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.118',@section_id,'Kern eines Operators','\\ker(T)=\\{x\\in X\\mid T(x)=0\\}','\\ker(T)=\\{x\\in X\\mid T(x)=0\\}','Menge aller auf Null abgebildeten Elemente.','definition','literature',@source_67_id,NULL,'T ist linear.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_118 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.119',@section_id,'Bild eines Operators','\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}','\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}','Menge aller erreichbaren Operatorbilder.','definition','literature',@source_67_id,NULL,'T ist linear.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_119 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.120',@section_id,'Kern und Bild als Unterräume','\\ker(T)\\leq X\\qquad\\text{und}\\qquad\\operatorname{im}(T)\\leq Y','\\ker(T)\\leq X\\qquad\\text{und}\\qquad\\operatorname{im}(T)\\leq Y','Kern und Bild linearer Operatoren sind Unterräume.','theorem','literature',@source_67_id,NULL,'T ist linear.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_120 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.121',@section_id,'Injektivitätskriterium','\\ker(T)=\\{0\\}','\\ker(T)=\\{0\\}','Ein linearer Operator ist genau dann injektiv, wenn sein Kern trivial ist.','theorem','literature',@source_67_id,NULL,'T ist linear.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_121 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.122',@section_id,'Surjektivitätskriterium','\\operatorname{im}(T)=Y','\\operatorname{im}(T)=Y','Ein Operator ist surjektiv, wenn sein Bild dem Zielraum entspricht.','definition','literature',@source_67_id,NULL,NULL,'checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_122 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.123',@section_id,'Operatorenkomposition','(S\\circ T)(x)=S(T(x))','(S\\circ T)(x)=S(T(x))','Aufeinanderfolgende Anwendung zweier Operatoren.','definition','literature',@source_35_id,NULL,'T:X\\to Y und S:Y\\to Z.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_123 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.124',@section_id,'Abbildungstyp der Komposition','S\\circ T:X\\longrightarrow Z','S\\circ T:X\\longrightarrow Z','Komposition als Operator von X nach Z.','derived','literature',@source_35_id,NULL,'Kompatible Definitions- und Zielräume.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_124 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.125',@section_id,'Assoziativität der Komposition','R\\circ(S\\circ T)=(R\\circ S)\\circ T','R\\circ(S\\circ T)=(R\\circ S)\\circ T','Assoziativität der Operatorverkettung.','theorem','literature',@source_35_id,NULL,'Kompositionen sind definiert.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_125 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.126',@section_id,'Nichtkommutativität','S\\circ T\\neq T\\circ S','S\\circ T\\neq T\\circ S','Operatorenkomposition ist im Allgemeinen nicht kommutativ.','other','literature',@source_35_id,NULL,'Beide Kompositionen sind definiert.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_126 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.127',@section_id,'Identitätsoperator','I_X:X\\longrightarrow X','I_X:X\\longrightarrow X','Identitätsoperator auf X.','definition','literature',@source_35_id,NULL,NULL,'checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_127 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.128',@section_id,'Wirkung des Identitätsoperators','I_X(x)=x','I_X(x)=x','Der Identitätsoperator lässt jedes Element unverändert.','definition','literature',@source_35_id,NULL,'x\\in X.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_128 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.129',@section_id,'Neutralität des Identitätsoperators','T\\circ I_X=T=I_Y\\circ T','T\\circ I_X=T=I_Y\\circ T','Identitätsoperator als neutrales Element der Komposition.','theorem','literature',@source_35_id,NULL,'T:X\\to Y.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_129 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.130',@section_id,'Linksinverse','T^{-1}\\circ T=I_X','T^{-1}\\circ T=I_X','Linksinverse hebt T auf X auf.','definition','literature',@source_35_id,NULL,'T ist invertierbar.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_130 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.131',@section_id,'Rechtsinverse','T\\circ T^{-1}=I_Y','T\\circ T^{-1}=I_Y','Rechtsinverse hebt T auf Y auf.','definition','literature',@source_35_id,NULL,'T ist invertierbar.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_131 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.132',@section_id,'Endomorphismenmenge','\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}','\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}','Menge aller linearen Endomorphismen von V.','definition','literature',@source_36_id,NULL,'V ist ein Vektorraum.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_132 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.133',@section_id,'Addition von Operatoren','(S+T)(x)=S(x)+T(x)','(S+T)(x)=S(x)+T(x)','Punktweise Addition linearer Operatoren.','definition','literature',@source_36_id,NULL,'S und T sind lineare Operatoren V nach V.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_133 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.134',@section_id,'Skalarmultiplikation von Operatoren','(\\lambda T)(x)=\\lambda T(x)','(\\lambda T)(x)=\\lambda T(x)','Punktweise Skalarmultiplikation eines Operators.','definition','literature',@source_36_id,NULL,'\\lambda liegt im Skalarkörper.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_134 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.135',@section_id,'Spektrum eines Operators','\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}','\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}','Spektrum als Menge der Nichtinvertierbarkeitswerte.','definition','literature',@source_11_id,NULL,'T ist ein geeigneter linearer Operator.','checked',@revision_id) ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`assumptions`=VALUES(`assumptions`),`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_135 := LAST_INSERT_ID();

/* Zentrale Gleichungssymbole */
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_107,'T','Operator','Abbildung zwischen mathematischen Räumen.',NULL,'X\\to Y',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_107,'X','Definitionsraum','Mathematischer Ausgangsraum.',NULL,'Raum',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_107,'Y','Zielraum','Mathematischer Zielraum.',NULL,'Raum',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_110,'x_n','Zustand','Zustand nach n Operatoranwendungen.',NULL,'X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_111,'T^n','Operatoriteration','n-fache Komposition von T.',NULL,'X\\to X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_112,'\\mathcal{D}(T)','Definitionsbereich','Tatsächliche Domäne des Operators.',NULL,'Teilmenge von X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_114,'\\mathcal{R}(T)','Wertebereich','Menge der tatsächlich erzeugten Bilder.',NULL,'Teilmenge von Y',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_115,'\\alpha,\\beta','Skalare','Skalare des zugrunde liegenden Körpers.',NULL,'K',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_118,'\\ker(T)','Kern','Nullraum des linearen Operators.',NULL,'Unterraum von X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_119,'\\operatorname{im}(T)','Bild','Bildraum des linearen Operators.',NULL,'Unterraum von Y',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_123,'S\\circ T','Operatorenkomposition','Verkettung der Operatoren T und S.',NULL,'X\\to Z',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_127,'I_X','Identitätsoperator','Neutrale Transformation auf X.',NULL,'X\\to X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_130,'T^{-1}','Inverser Operator','Umkehrabbildung eines invertierbaren Operators.',NULL,'Y\\to X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_132,'\\operatorname{End}(V)','Endomorphismenmenge','Menge aller linearen Endomorphismen von V.',NULL,'Operatorraum',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_135,'\\sigma(T)','Spektrum','Menge der Nichtinvertierbarkeitswerte.',NULL,'Teilmenge von \\mathbb C',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES (@eq_3_135,'\\lambda','Spektralparameter','Komplexer Skalar im Spektrum.',NULL,'\\mathbb C',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

/* Abschnittssymbole */
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('T','T','Operator','Abbildung zwischen mathematisch strukturierten Räumen.','global',@section_id,@eq_3_107,NULL,'X','Y',0,0,1,'Zentrales Operatorsymbol.','checked',@revision_id),
('\\mathcal{D}(T)','\\mathcal{D}(T)','Definitionsbereich eines Operators','Tatsächlicher Bereich, auf dem T definiert ist.','section',@section_id,@eq_3_112,NULL,'Operator T','Teilmenge von X',0,0,0,'Domäne des Operators.','checked',@revision_id),
('\\mathcal{R}(T)','\\mathcal{R}(T)','Wertebereich eines Operators','Menge aller von T erzeugten Bilder.','section',@section_id,@eq_3_114,NULL,'Operator T','Teilmenge von Y',0,0,0,'Range des Operators.','checked',@revision_id),
('\\ker(T)','\\ker(T)','Kern eines Operators','Menge aller auf Null abgebildeten Elemente.','section',@section_id,@eq_3_118,NULL,'linearer Operator T','Unterraum von X',0,0,0,'Nullraum.','checked',@revision_id),
('\\operatorname{im}(T)','\\operatorname{im}(T)','Bild eines Operators','Menge aller erreichbaren Operatorbilder.','section',@section_id,@eq_3_119,NULL,'linearer Operator T','Unterraum von Y',0,0,0,'Bildraum.','checked',@revision_id),
('I_X','I_X','Identitätsoperator','Neutrale Transformation auf X.','section',@section_id,@eq_3_127,NULL,'X','X',0,0,1,'Neutrales Element der Komposition.','checked',@revision_id),
('T^{-1}','T^{-1}','Inverser Operator','Umkehrabbildung eines invertierbaren Operators.','section',@section_id,@eq_3_130,NULL,'Y','X',0,0,1,'Existiert nur bei Invertierbarkeit.','checked',@revision_id),
('\\operatorname{End}(V)','\\operatorname{End}(V)','Endomorphismenmenge','Menge aller linearen Endomorphismen von V.','section',@section_id,@eq_3_132,NULL,'Vektorraum V','Operatorraum',0,0,0,'Träger der Operatoralgebra.','checked',@revision_id),
('\\sigma(T)','\\sigma(T)','Spektrum eines Operators','Menge der Werte, für die T minus Lambda I nicht invertierbar ist.','section',@section_id,@eq_3_135,NULL,'Operator T','Teilmenge von \\mathbb C',0,0,0,'Spektrale Charakterisierung.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

DELETE FROM `section_change_log` WHERE `revision_id`=@revision_id AND `section_id`=@section_id;
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES
(@revision_id,@section_id,'rewritten','section','3.2.5','Abschnitt 3.2.5 vollständig neu gefasst.','Bisheriger Repository-Stand.','Neufassung mit Operatorbegriff, linearer Struktur, Operatoralgebra und Spektrum.'),
(@revision_id,@section_id,'source_added','sources','[66]–[67]','Zwei neue Primärquellen registriert.',NULL,'Hilbert [66], Banach [67].'),
(@revision_id,@section_id,'source_reused','sources','[11], [35], [36]','Drei bestehende Standardquellen wiederverwendet.',NULL,'Rudin [11], Conway [35], Kreyszig [36].'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.2.5.1–Def. 3.2.5.10','Zehn Definitionen registriert.',NULL,'Operator bis Spektrum.'),
(@revision_id,@section_id,'equation_added','equations','(3.107)–(3.135)','29 Gleichungen registriert.',NULL,'Operatorbegriff, Linearität, Kern, Bild, Komposition, Invertierbarkeit und Spektrum.'),
(@revision_id,@section_id,'symbol_added','symbols','T, D(T), R(T), ker(T), im(T), I_X, T^{-1}, End(V), sigma(T)','Zentrale Operatorsymbole registriert.',NULL,'Symbolregister 3.2.5.');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES ('next_citation_number','68'),('next_equation_number','3.136'),('last_edited_section','3.2.5'),('last_repository_revision','RKB-2026-07-15-K3.2.5-NEUFASSUNG-V2') ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);
COMMIT;

/* Kontrollabfragen */
SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes` FROM `dissertation_sections` WHERE `section_code`='3.2.5';
SELECT s.`citation_number`,s.`source_key`,s.`title`,s.`verification_status` FROM `sources` s WHERE s.`citation_number` IN (11,35,36,66,67) ORDER BY s.`citation_number`;
SELECT COUNT(*) AS `source_usages`,SUM(`is_first_mention`) AS `first_mentions`,SUM(`citation_checked`) AS `checked_usages` FROM `source_usage` WHERE `section_id`=@section_id;
SELECT `definition_number`,`title`,`validation_status` FROM `definitions` WHERE `section_id`=@section_id ORDER BY `definition_number`;
SELECT `equation_number`,`title`,`equation_type`,`word_latex`,`validation_status` FROM `equations` WHERE `section_id`=@section_id ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);
SELECT COUNT(*) AS `equation_count` FROM `equations` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `equation_symbol_count` FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision') ORDER BY `counter_key`;
SELECT COUNT(*) AS `invalid_equation_types` FROM `equations` WHERE `section_id`=@section_id AND `equation_type` NOT IN ('definition','axiom','theorem','lemma','derived','schema','model','metric','other');
SELECT COUNT(*) AS `missing_word_latex` FROM `equations` WHERE `section_id`=@section_id AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');
SELECT COUNT(*) AS `orphan_equation_symbols` FROM `equation_symbols` es LEFT JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`equation_id` IS NULL;
