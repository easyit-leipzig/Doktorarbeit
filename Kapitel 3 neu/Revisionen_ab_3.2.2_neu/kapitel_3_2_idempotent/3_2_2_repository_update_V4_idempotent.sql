USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;
/* Abschnitt 3.2.2 – vollständige Neufassung V2 – korrigiert
   Voraussetzung: 3_2_1_reset_und_neufassung_V2_korrigiert.sql wurde ausgeführt.
   Quellen [27], [28] vorhanden; [59] Tarski neu.
   Gleichungen (3.17)–(3.41). */
/* Parent-Revision vor dem INSERT separat ermitteln.
   Dadurch wird MySQL-Fehler #1093 vermieden, weil repository_revisions
   nicht zugleich Ziel- und Quelltabelle desselben INSERT ist. */
SET @parent_revision_id := (
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `revision_code` = 'RKB-2026-07-14-K3.2.1-NEUFASSUNG-V2'
    LIMIT 1
);

INSERT INTO `repository_revisions`
    (`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,
     `summary`,`created_by`,`parent_revision_id`)
VALUES
    ('RKB-2026-07-14-K3.2.2-NEUFASSUNG-V2',NOW(),'section','3.2.2','2.0',
     'Vollständige Neufassung von Abschnitt 3.2.2 mit Relationseigenschaften, Äquivalenz- und Ordnungsrelationen, Relationskomposition und Graphinterpretation.',
     'Olaf Thiele / ChatGPT',@parent_revision_id)
ON DUPLICATE KEY UPDATE
    `revision_id`       = LAST_INSERT_ID(`revision_id`),
    `revision_date`     = VALUES(`revision_date`),
    `summary`           = VALUES(`summary`),
    `parent_revision_id`= VALUES(`parent_revision_id`);
SET @revision_id:=LAST_INSERT_ID();
SET @revision_id := COALESCE(@revision_id,(SELECT `revision_id` FROM `repository_revisions` WHERE `scope_reference`='3.2.2' ORDER BY `revision_id` DESC LIMIT 1));
SET @section_id:=(SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.2' LIMIT 1);
UPDATE `dissertation_sections` SET `title`='Relationen als mathematische Beschreibung struktureller Zusammenhänge',`status`='review',`is_original_contribution`=0,`notes`='Vollständige Neufassung V2 mit Quellen [27], [28], [59] und Gleichungen (3.17)–(3.41).' WHERE `section_id`=@section_id;
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`notes`) VALUES ('Tarski','Alfred','Tarski, Alfred','Autor von On the Calculus of Relations.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_tarski:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES (59,'tarski_calculus_relations_1941','journal_article','On the Calculus of Relations',1941,1941,'The Journal of Symbolic Logic','6','3','73–89','en',5,'primary',4,'verified','3.2.2','Erstnennung zur Algebra und Komposition von Relationen.','Tarski, Alfred: On the Calculus of Relations. The Journal of Symbolic Logic, Bd. 6, Nr. 3, 1941, S. 73–89.','Tarski [59]','Primärquelle zur Relationsalgebra.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`title`=VALUES(`title`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_59_id:=LAST_INSERT_ID();
INSERT IGNORE INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_59_id,@author_tarski,1,'author');
SET @source_27_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=27 LIMIT 1);
SET @source_28_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=28 LIMIT 1);
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_27_id,@section_id,'state_of_research','Enderton fundiert den mengentheoretischen Relationsbegriff, geordnete Paare, kartesische Produkte und grundlegende Relationseigenschaften.','Abschnitt 3.2.2',0,1,'Neufassung V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_28_id,@section_id,'state_of_research','Davey und Priestley fundieren Halbordnungen, Totalordnungen und hierarchische relationale Strukturen.','Abschnitt 3.2.2',0,1,'Neufassung V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_59_id,@section_id,'first_citation','Tarski fundiert Relationskomposition und die algebraische Behandlung von Relationen.','Abschnitt 3.2.2',1,1,'Neufassung V2.',@revision_id);
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.17',@section_id,'Geordnetes Paar','(a,b)','(a,b)','Geordnetes Paar aus den Komponenten a und b.','definition','literature',@source_27_id,NULL,'a und b sind Elemente geeigneter Mengen.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.18',@section_id,'Identität geordneter Paare','(a,b)=(c,d)\Longleftrightarrow a=c\land b=d','(a,b)=(c,d)\Longleftrightarrow a=c\land b=d','Zwei geordnete Paare sind genau dann gleich, wenn ihre jeweiligen Komponenten übereinstimmen.','definition','literature',@source_27_id,NULL,'a,b,c,d sind mathematische Objekte.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.19',@section_id,'Reihenfolge geordneter Paare','(a,b)\neq(b,a)','(a,b)\neq(b,a)','Bei verschiedenen Komponenten ist die Reihenfolge eines geordneten Paares wesentlich.','derived','literature',@source_27_id,NULL,'a\neq b.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.20',@section_id,'Kartesisches Produkt','A\times B=\left\{(a,b)\mid a\in A\land b\in B\right\}','A\times B=\left\{(a,b)\mid a\in A\land b\in B\right\}','Das kartesische Produkt enthält alle geordneten Paare aus A und B.','definition','literature',@source_27_id,NULL,'A und B sind Mengen.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Ziel- oder Vergleichsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.21',@section_id,'Binäre Relation','R\subseteq A\times B','R\subseteq A\times B','Eine binäre Relation zwischen A und B ist eine Teilmenge ihres kartesischen Produkts.','definition','literature',@source_27_id,NULL,'A und B sind Mengen.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Ziel- oder Vergleichsmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.22',@section_id,'Relationsnotation','aRb\Longleftrightarrow(a,b)\in R','aRb\Longleftrightarrow(a,b)\in R','Die Schreibweise aRb bedeutet, dass das geordnete Paar (a,b) zur Relation R gehört.','definition','literature',@source_27_id,NULL,'R\subseteq A\times B.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.23',@section_id,'Relation auf einer Menge','R\subseteq A\times A','R\subseteq A\times A','Eine Relation auf A ist eine Teilmenge von A mal A.','definition','literature',@source_27_id,NULL,'A ist eine Menge.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.24',@section_id,'Definitionsbereich einer Relation','\operatorname{dom}(R)=\left\{a\in A\mid\exists b\in B:(a,b)\in R\right\}','\operatorname{dom}(R)=\left\{a\in A\mid\exists b\in B:(a,b)\in R\right\}','Der Definitionsbereich enthält alle ersten Komponenten, die in mindestens einem Relationspaar auftreten.','definition','literature',@source_27_id,NULL,'R\subseteq A\times B.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Ziel- oder Vergleichsmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.25',@section_id,'Wertebereich einer Relation','\operatorname{ran}(R)=\left\{b\in B\mid\exists a\in A:(a,b)\in R\right\}','\operatorname{ran}(R)=\left\{b\in B\mid\exists a\in A:(a,b)\in R\right\}','Der Wertebereich enthält alle zweiten Komponenten, die in mindestens einem Relationspaar auftreten.','definition','literature',@source_27_id,NULL,'R\subseteq A\times B.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Ziel- oder Vergleichsmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.26',@section_id,'Inverse Relation','R^{-1}=\left\{(b,a)\mid(a,b)\in R\right\}','R^{-1}=\left\{(b,a)\mid(a,b)\in R\right\}','Die inverse Relation entsteht durch Vertauschung der Komponenten aller Relationspaare.','definition','literature',@source_27_id,NULL,'R ist eine binäre Relation.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.27',@section_id,'Reflexivität','\forall a\in A:\;aRa','\forall a\in A:\;aRa','Eine Relation ist reflexiv, wenn jedes Element zu sich selbst in Relation steht.','definition','literature',@source_27_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.28',@section_id,'Irreflexivität','\forall a\in A:\;\neg(aRa)','\forall a\in A:\;\neg(aRa)','Eine Relation ist irreflexiv, wenn kein Element zu sich selbst in Relation steht.','definition','literature',@source_27_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.29',@section_id,'Symmetrie','\forall a,b\in A:\;aRb\Longrightarrow bRa','\forall a,b\in A:\;aRb\Longrightarrow bRa','Eine Relation ist symmetrisch, wenn jede Beziehung auch in der Gegenrichtung gilt.','definition','literature',@source_27_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.30',@section_id,'Antisymmetrie','\forall a,b\in A:\;\left(aRb\land bRa\right)\Longrightarrow a=b','\forall a,b\in A:\;\left(aRb\land bRa\right)\Longrightarrow a=b','Eine Relation ist antisymmetrisch, wenn wechselseitige Relation Identität erzwingt.','definition','literature',@source_28_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.31',@section_id,'Asymmetrie','\forall a,b\in A:\;aRb\Longrightarrow\neg(bRa)','\forall a,b\in A:\;aRb\Longrightarrow\neg(bRa)','Eine Relation ist asymmetrisch, wenn aus aRb die Nichtgeltung von bRa folgt.','definition','literature',@source_28_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.32',@section_id,'Transitivität','\forall a,b,c\in A:\;\left(aRb\land bRc\right)\Longrightarrow aRc','\forall a,b,c\in A:\;\left(aRb\land bRc\right)\Longrightarrow aRc','Eine Relation ist transitiv, wenn verkettete Beziehungen wieder eine Beziehung ergeben.','definition','literature',@source_27_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.33',@section_id,'Äquivalenzrelation','R\text{ ist Äquivalenzrelation}\Longleftrightarrow R\text{ ist reflexiv, symmetrisch und transitiv}','R\text{ ist Äquivalenzrelation}\Longleftrightarrow R\text{ ist reflexiv, symmetrisch und transitiv}','Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.','definition','literature',@source_27_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.34',@section_id,'Äquivalenzklasse','[a]_R=\left\{x\in A\mid xRa\right\}','[a]_R=\left\{x\in A\mid xRa\right\}','Die Äquivalenzklasse eines Elements enthält alle zu ihm äquivalenten Elemente.','definition','literature',@source_27_id,NULL,'R ist eine Äquivalenzrelation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.35',@section_id,'Quotientenmenge','A/R=\left\{[a]_R\mid a\in A\right\}','A/R=\left\{[a]_R\mid a\in A\right\}','Die Quotientenmenge besteht aus allen Äquivalenzklassen von A bezüglich R.','definition','literature',@source_27_id,NULL,'R ist eine Äquivalenzrelation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.36',@section_id,'Halbordnung','R\text{ ist Halbordnung}\Longleftrightarrow R\text{ ist reflexiv, antisymmetrisch und transitiv}','R\text{ ist Halbordnung}\Longleftrightarrow R\text{ ist reflexiv, antisymmetrisch und transitiv}','Eine Halbordnung ist reflexiv, antisymmetrisch und transitiv.','definition','literature',@source_28_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.37',@section_id,'Partiell geordnete Menge','\left(A,\preceq\right)','\left(A,\preceq\right)','Ein Paar aus einer Menge A und einer Halbordnung bildet eine partiell geordnete Menge.','definition','literature',@source_28_id,NULL,'\preceq ist eine Halbordnung auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\preceq','Ordnungsrelation','Halb- oder Totalordnung.','Relation auf A',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.38',@section_id,'Totalordnung','\forall a,b\in A:\;a\preceq b\lor b\preceq a','\forall a,b\in A:\;a\preceq b\lor b\preceq a','In einer Totalordnung sind je zwei Elemente vergleichbar.','definition','literature',@source_28_id,NULL,'\preceq ist eine Halbordnung auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\preceq','Ordnungsrelation','Halb- oder Totalordnung.','Relation auf A',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.39',@section_id,'Komposition von Relationen','S\circ R=\left\{(a,c)\in A\times C\mid\exists b\in B:\;aRb\land bSc\right\}','S\circ R=\left\{(a,c)\in A\times C\mid\exists b\in B:\;aRb\land bSc\right\}','Die Komposition erfasst Beziehungen, die über ein Zwischenelement vermittelt werden.','definition','literature',@source_59_id,NULL,'R\subseteq A\times B und S\subseteq B\times C.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Ziel- oder Vergleichsmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\circ','Relationskomposition','Komposition zweier Relationen.','Relationsoperation',4)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.40',@section_id,'Transitivität als Selbstkomposition','R\circ R\subseteq R','R\circ R\subseteq R','Eine Relation ist transitiv, wenn ihre Selbstkomposition in ihr enthalten ist.','derived','literature',@source_59_id,NULL,'R ist eine Relation auf A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\circ','Relationskomposition','Komposition zweier Relationen.','Relationsoperation',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.41',@section_id,'Graph einer Relation','G_R=\left(A,R\right)','G_R=\left(A,R\right)','Eine binäre Relation auf A kann als gerichteter Graph mit Knotenmenge A und Kantenmenge R interpretiert werden.','model','literature',@source_27_id,NULL,'R\subseteq A\times A.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
  `equation_id`=LAST_INSERT_ID(`equation_id`),
  `section_id`=VALUES(`section_id`),
  `title`=VALUES(`title`),
  `equation_latex`=VALUES(`equation_latex`),
  `word_latex`=VALUES(`word_latex`),
  `plain_description`=VALUES(`plain_description`),
  `equation_type`=VALUES(`equation_type`),
  `provenance`=VALUES(`provenance`),
  `source_id`=VALUES(`source_id`),
  `derivation`=VALUES(`derivation`),
  `assumptions`=VALUES(`assumptions`),
  `validation_status`=VALUES(`validation_status`),
  `created_revision_id`=VALUES(`created_revision_id`);
SET @eq_id:=LAST_INSERT_ID();
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'R','Relation','Binäre Relation.','Relation',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Grundmenge','Ausgangs- oder Grundmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.1',@section_id,'Geordnetes Paar','Ein geordnetes Paar ist ein Paar mathematischer Objekte, bei dem die Reihenfolge der Komponenten wesentlich ist.','(a,b)','(a,b)','literature',@source_27_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.2',@section_id,'Binäre Relation','Eine binäre Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts A\times B.','R\subseteq A\times B','R\subseteq A\times B','literature',@source_27_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.3',@section_id,'Inverse Relation','Die inverse Relation entsteht durch Vertauschung der Komponenten aller Paare einer Relation.','R^{-1}=\{(b,a)\mid(a,b)\in R\}','R^{-1}=\{(b,a)\mid(a,b)\in R\}','literature',@source_27_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.4',@section_id,'Äquivalenzrelation','Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.',NULL,NULL,'literature',@source_27_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.5',@section_id,'Äquivalenzklasse','Die Äquivalenzklasse eines Elements enthält alle Elemente, die bezüglich der Relation zu ihm äquivalent sind.','[a]_R=\{x\in A\mid xRa\}','[a]_R=\{x\in A\mid xRa\}','literature',@source_27_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.6',@section_id,'Halbordnung','Eine Halbordnung ist reflexiv, antisymmetrisch und transitiv.',NULL,NULL,'literature',@source_28_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.7',@section_id,'Totalordnung','Eine Totalordnung ist eine Halbordnung, in der je zwei Elemente vergleichbar sind.',NULL,NULL,'literature',@source_28_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.2.8',@section_id,'Relationskomposition','Die Komposition zweier Relationen beschreibt mittelbare Beziehungen über ein Zwischenelement.','S\circ R=\{(a,c)\mid\exists b:aRb\land bSc\}','S\circ R=\{(a,c)\mid\exists b:aRb\land bSc\}','literature',@source_59_id,NULL,'Neufassung 3.2.2 V2.','checked',@revision_id)
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
DELETE FROM `symbols` WHERE `first_section_id`=@section_id;
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('R','R','Relation','Binäre Relation zwischen mathematischen Elementen.','section',@section_id,NULL,'Relation',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('R^{-1}','R^{-1}','inverse Relation','Relation mit vertauschten Komponenten.','section',@section_id,NULL,'Relation',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('\operatorname{dom}(R)','\operatorname{dom}(R)','Definitionsbereich','Menge aller ersten Komponenten einer Relation.','section',@section_id,NULL,'Menge',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('\operatorname{ran}(R)','\operatorname{ran}(R)','Wertebereich','Menge aller zweiten Komponenten einer Relation.','section',@section_id,NULL,'Menge',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('\preceq','\preceq','Ordnungsrelation','Symbol für eine Halb- oder Totalordnung.','section',@section_id,NULL,'Relation',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('S\circ R','S\circ R','Relationskomposition','Komposition zweier Relationen.','section',@section_id,NULL,'Relation',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('A/R','A/R','Quotientenmenge','Menge der Äquivalenzklassen von A bezüglich R.','section',@section_id,NULL,'Menge',NULL,0,0,0,'Abschnitt 3.2.2 V2.','checked',@revision_id);
DELETE FROM `section_change_log` WHERE `revision_id`=@revision_id;
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'rewritten','section','3.2.2','Abschnitt 3.2.2 wurde vollständig neu gefasst.','Vorheriger Repository-Stand.','Neufassung V2 mit 25 Gleichungen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'source_added','source','[59]','Tarskis Primärquelle zur Relationsalgebra wurde aufgenommen.',NULL,'On the Calculus of Relations.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'source_reused','sources','[27], [28]','Enderton sowie Davey und Priestley wurden wiederverwendet.',NULL,'Drei Quellenverwendungen insgesamt.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'equation_added','equations','(3.17)–(3.41)','Relationen, Eigenschaften, Klassen, Ordnungen, Komposition und Graphmodell wurden registriert.',NULL,'25 Gleichungen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'definition_added','definitions','Def. 3.2.2.1–3.2.2.8','Acht Definitionen wurden registriert.',NULL,'8 Definitionen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'status_changed','section','3.2.2','Abschnitt auf review gesetzt.','planned','review');
INSERT INTO `repository_counters` (`counter_key`,`counter_value`,`updated_at`) VALUES ('last_edited_section','3.2.2',NOW()),('last_repository_revision','RKB-2026-07-14-K3.2.2-NEUFASSUNG-V2',NOW()),('next_citation_number','60',NOW()),('next_equation_number','3.42',NOW()) ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`),`updated_at`=VALUES(`updated_at`);
COMMIT;
/* Kontrollabfragen */
SELECT `revision_id`,`revision_code`,`parent_revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-14-K3.2.2-NEUFASSUNG-V2';
SELECT `section_code`,`title`,`status` FROM `dissertation_sections` WHERE `section_code`='3.2.2';
SELECT `citation_number`,`short_citation_text`,`verification_status` FROM `sources` WHERE `citation_number` IN (27,28,59) ORDER BY `citation_number`;
SELECT COUNT(*) AS `equation_count` FROM `equations` WHERE `section_id`=@section_id;
SELECT MIN(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `first_eq`,MAX(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `last_eq` FROM `equations` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `definition_count` FROM `definitions` WHERE `section_id`=@section_id;
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('last_edited_section','last_repository_revision','next_citation_number','next_equation_number') ORDER BY `counter_key`;
