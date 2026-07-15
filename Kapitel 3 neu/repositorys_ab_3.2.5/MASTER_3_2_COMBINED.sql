/* FRZK Repository V5 - combined build for phpMyAdmin/Adminer. */
/* Import this file into the existing frzk_rkb database. */

/* ===== 3_2_1.sql_V5.sql ===== */
USE `frzk_rkb`;

SET NAMES utf8mb4;



START TRANSACTION;



/* ============================================================
   Abschnitt 3.2.1 – Mengen als Grundlage mathematischer Modellbildung
   Vollständiges Revisionsskript V2

   Ausgangspunkt: Repository-Stand nach 3.2.0
   Quellen:
   [23] Cantor – vorhanden
   [24] Zermelo – vorhanden
   [58] Fraenkel / Bar-Hillel / Levy – neu bzw. idempotent aktualisiert

   Gleichungen: (3.3)–(3.16)
   Nächste Gleichung: (3.17)
   Nächste neue Literaturquelle: [59]
   ============================================================ */



INSERT INTO `repository_revisions`
(`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`)
VALUES
('RKB-2026-07-14-K3.2.1-NEUFASSUNG-V2',NOW(),'section','3.2.1','2.0',
 'Vollständige Neufassung von Abschnitt 3.2.1 mit Mengenbegriff, Axiomatik, Mengenoperationen, kartesischem Produkt, Potenzmenge und Forschungsgrenze.',
 'Olaf Thiele / ChatGPT',
 (SELECT MAX(r.`revision_id`) FROM `repository_revisions` r))
ON DUPLICATE KEY UPDATE
 `revision_id`=LAST_INSERT_ID(`revision_id`),
 `revision_date`=VALUES(`revision_date`),
 `summary`=VALUES(`summary`),
 `created_by`=VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();
SET @revision_id := COALESCE(@revision_id,(SELECT `revision_id` FROM `repository_revisions` WHERE `scope_reference`='3.2.1' ORDER BY `revision_id` DESC LIMIT 1));

SET @section_id := (
 SELECT `section_id` FROM `dissertation_sections`
 WHERE `section_code`='3.2.1' LIMIT 1
);

SELECT CASE WHEN @section_id IS NULL
 THEN 'FEHLER: Abschnitt 3.2.1 fehlt.'
 ELSE CONCAT('OK: section_id=',@section_id) END AS `section_validation`;

UPDATE `dissertation_sections`
SET `title`='Mengen als Grundlage mathematischer Modellbildung',
    `status`='review',
    `is_original_contribution`=0,
    `notes`='Am 14.07.2026 vollständig neu gefasst. Forschungsstand zur axiomatischen Mengenlehre mit den Quellen [23], [24] und [58]; Gleichungen (3.3)–(3.16).'
WHERE `section_id`=@section_id;

UPDATE `dissertation_sections`
SET `status`='review',`is_original_contribution`=0,
    `notes`='Kapitel 3.2 wird abschnittsweise neu gefasst; Stand der Forschung, keine FRZK-Eigenleistung.'
WHERE `section_code`='3.2';

INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`notes`)
VALUES ('Fraenkel','Abraham A.','Fraenkel, Abraham A.','Mitautor von Foundations of Set Theory.')
ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),
`family_name`=VALUES(`family_name`),`given_names`=VALUES(`given_names`),`notes`=VALUES(`notes`);
SET @author_fraenkel:=LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`notes`)
VALUES ('Bar-Hillel','Yehoshua','Bar-Hillel, Yehoshua','Mitautor von Foundations of Set Theory.')
ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),
`family_name`=VALUES(`family_name`),`given_names`=VALUES(`given_names`),`notes`=VALUES(`notes`);
SET @author_bar_hillel:=LAST_INSERT_ID();

INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`notes`)
VALUES ('Levy','Azriel','Levy, Azriel','Mitautor von Foundations of Set Theory.')
ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),
`family_name`=VALUES(`family_name`),`given_names`=VALUES(`given_names`),`notes`=VALUES(`notes`);
SET @author_levy:=LAST_INSERT_ID();

INSERT INTO `sources`
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(58,'fraenkel_bar_hillel_levy_foundations_set_theory_1973','book','Foundations of Set Theory',NULL,1958,1973,NULL,'North-Holland','Amsterdam',NULL,NULL,NULL,'Second Revised Edition',NULL,NULL,NULL,'en',5,'reference',4,'checked','3.2.1',
 'Erstnennung in der Neufassung von Abschnitt 3.2.1.',
 'Fraenkel, Abraham A.; Bar-Hillel, Yehoshua; Levy, Azriel: Foundations of Set Theory. Second Revised Edition. Amsterdam: North-Holland, 1973.',
 'Fraenkel, Bar-Hillel und Levy [58]',
 'Referenzwerk zur axiomatischen Mengenlehre, zu ZFC und zur Begrenzung zulässiger Mengenbildungen.',@revision_id)
ON DUPLICATE KEY UPDATE
`source_id`=LAST_INSERT_ID(`source_id`),`title`=VALUES(`title`),`year_original`=VALUES(`year_original`),
`year_edition`=VALUES(`year_edition`),`publisher`=VALUES(`publisher`),`place`=VALUES(`place`),
`edition`=VALUES(`edition`),`verification_status`=VALUES(`verification_status`),
`first_citation_section_code`=VALUES(`first_citation_section_code`),
`full_citation_text`=VALUES(`full_citation_text`),`short_citation_text`=VALUES(`short_citation_text`),
`notes`=VALUES(`notes`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_58:=LAST_INSERT_ID();

DELETE FROM `source_authors` WHERE `source_id`=@source_58;
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES
(@source_58,@author_fraenkel,1,'author'),
(@source_58,@author_bar_hillel,2,'author'),
(@source_58,@author_levy,3,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);

SET @source_23 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=23 LIMIT 1);
SET @source_24 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=24 LIMIT 1);

DELETE FROM `source_usage` WHERE `section_id`=@section_id;
INSERT INTO `source_usage`
(`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES
(@source_23,@section_id,'historical_context','Cantors Arbeiten begründen den modernen Mengenbegriff, die transfinite Mengenlehre, die Potenzmengenbildung und den Satz über die größere Mächtigkeit der Potenzmenge.','3.2.1: historische Entwicklung und Mengenoperationen',0,1,'Bestehende Quelle [23] wird wiederverwendet.',@revision_id),
(@source_24,@section_id,'state_of_research','Zermelos Axiomatisierung begrenzt zulässige Mengenbildungen und fundiert Extensionalität, Aussonderung, Vereinigung und Potenzmenge.','3.2.1: axiomatische Fundierung und Mengenoperationen',0,1,'Bestehende Quelle [24] wird wiederverwendet.',@revision_id),
(@source_58,@section_id,'first_citation','Das Referenzwerk systematisiert die axiomatischen Grundlagen von ZFC und grenzt Konstruktion vorhandener Mengen von einer Erklärung ihrer Genese ab.','3.2.1: axiomatische Einordnung und wissenschaftliche Grenze',1,1,'Neue Erstnennung [58].',@revision_id);

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id;
DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`section_id`=@section_id;
DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.1',@section_id,'Menge','Eine Menge ist im axiomatischen Rahmen ein primitiver mathematischer Gegenstand, dessen Bedeutung durch die Elementrelation und die Axiome der Mengenlehre bestimmt wird.',NULL,NULL,'literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id)
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

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.2',@section_id,'Elementzugehörigkeit','Die Aussage x∈M bezeichnet die Zugehörigkeit des Objekts x zur Menge M.','x\\in M','x\\in M','literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id)
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

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.3',@section_id,'Leere Menge','Die leere Menge ist die eindeutig bestimmte Menge, die kein Element enthält.','\\emptyset','\\emptyset','literature',@source_24,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id)
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

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.4',@section_id,'Teilmenge','A ist Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','literature',@source_24,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id)
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

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.5',@section_id,'Kartesisches Produkt','Das kartesische Produkt A×B ist die Menge aller geordneten Paare (a,b) mit a∈A und b∈B.','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id)
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

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.6',@section_id,'Potenzmenge','Die Potenzmenge P(A) ist die Menge aller Teilmengen von A.','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.3',@section_id,'Elementzugehörigkeit','x\\in M','x\\in M','Das Objekt x ist Element der Menge M.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.4',@section_id,'Nichtzugehörigkeit','x\\notin M','x\\notin M','Das Objekt x ist kein Element der Menge M.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.5',@section_id,'Leere Menge','\\emptyset','\\emptyset','Bezeichnung der eindeutig bestimmten Menge ohne Elemente.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.6',@section_id,'Extensionalitätsaxiom','A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)','A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)','Zwei Mengen sind genau dann identisch, wenn sie dieselben Elemente besitzen.','axiom','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.7',@section_id,'Teilmengenrelation','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.8',@section_id,'Aussonderungsmenge','A_P=\\left\\{x\\in A\\mid P(x)\\right\\}','A_P=\\left\\{x\\in A\\mid P(x)\\right\\}','Teilmenge von A, deren Elemente die Eigenschaft P erfüllen.','definition','literature',@source_58,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.9',@section_id,'Vereinigung','A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}','A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}','Vereinigung der Mengen A und B.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.10',@section_id,'Durchschnitt','A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}','A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}','Durchschnitt der Mengen A und B.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.11',@section_id,'Differenzmenge','A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}','A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}','Differenzmenge von A bezüglich B.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.12',@section_id,'Komplement','A^{c}=U\\setminus A','A^{c}=U\\setminus A','Komplement von A relativ zur Grundmenge U.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.13',@section_id,'Kartesisches Produkt','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','Menge aller geordneten Paare aus A und B.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.14',@section_id,'Potenzmenge','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','Menge aller Teilmengen von A.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.15',@section_id,'Satz von Cantor','|\\mathcal P(A)|>|A|','|\\mathcal P(A)|>|A|','Die Potenzmenge besitzt eine strikt größere Mächtigkeit als ihre Ausgangsmenge.','theorem','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.16',@section_id,'Schema mengenbildender Operationen','\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)','\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)','Schematische Darstellung einer Operation auf Teilmengen einer Grundmenge.','schema','adapted',@source_58,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id)
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

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.3' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges mathematisches Objekt.',NULL,'Objekt',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'M','Menge','Menge, deren Elementzugehörigkeit geprüft wird.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.4' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges mathematisches Objekt.',NULL,'Objekt',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'M','Menge','Menge, zu der x nicht gehört.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.5' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\emptyset','Leere Menge','Eindeutig bestimmte Menge ohne Elemente.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.6' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Vergleichsmenge.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Vergleichsmenge.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges Prüfelement.',NULL,'Objekt',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.7' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Teilmenge','Mögliche Teilmenge von B.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Obermenge','Menge, die alle Elemente von A enthält.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges Element.',NULL,'Objekt',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.8' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A_P','Aussonderungsmenge','Teilmenge der Elemente von A mit Eigenschaft P.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Grundmenge','Bereits vorhandene Menge.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'P(x)','Prädikat','Auswahlbedingung für x.',NULL,'Aussage',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.9' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Vereinigungsmenge.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Vereinigungsmenge.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Element mindestens einer Ausgangsmenge.',NULL,'Objekt',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.10' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Schnittmenge.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Schnittmenge.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Gemeinsames Element beider Mengen.',NULL,'Objekt',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.11' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Ausgangsmenge.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Auszuschließende Menge.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Element von A, das nicht in B liegt.',NULL,'Objekt',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.12' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A^c','Komplement','Komplement von A relativ zu U.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'U','Grundmenge','Bezugsuniversum des Komplements.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Teilmenge','Zu komplementierende Teilmenge.',NULL,'Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.13' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Faktormenge.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Faktormenge.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'(a,b)','Geordnetes Paar','Paar mit erster Komponente aus A und zweiter aus B.',NULL,'Geordnetes Paar',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.14' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\mathcal P(A)','Potenzmenge','Menge aller Teilmengen von A.',NULL,'Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'X','Teilmenge','Beliebige Teilmenge von A.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Ausgangsmenge','Menge, deren Potenzmenge gebildet wird.',NULL,'Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.15' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'|\\mathcal P(A)|','Mächtigkeit der Potenzmenge','Kardinalität der Potenzmenge von A.',NULL,'Kardinalzahl',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'|A|','Mächtigkeit von A','Kardinalität der Ausgangsmenge A.',NULL,'Kardinalzahl',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.16' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\Omega','Mengenoperation','Allgemeine Operation auf Teilmengen von M.',NULL,'Operator',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\mathcal P(M)','Potenzmenge','Definitions- und Zielbereich der Operation.',NULL,'Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'M','Grundmenge','Zugrunde liegende Menge.',NULL,'Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('M','M','Menge','Allgemeine Menge mathematischer Objekte.','global',@section_id,NULL,NULL,NULL,NULL,0,0,0,
'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('x','x','Element','Beliebiges mathematisches Objekt beziehungsweise Mengenelement.','section',@section_id,NULL,NULL,NULL,NULL,0,0,0,
'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('\\emptyset','\\emptyset','Leere Menge','Eindeutig bestimmte Menge ohne Elemente.','global',@section_id,NULL,NULL,NULL,NULL,0,0,0,
'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('\\mathcal P(A)','\\mathcal P(A)','Potenzmenge','Menge aller Teilmengen von A.','section',@section_id,NULL,NULL,NULL,NULL,0,0,0,
'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('\\Omega','\\Omega','Mengenoperation','Schematische Operation auf der Potenzmenge einer Grundmenge.','section',@section_id,NULL,NULL,NULL,NULL,0,0,1,
'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
`symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),
`definition_text`=VALUES(`definition_text`),`is_operator`=VALUES(`is_operator`),
`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),
`created_revision_id`=VALUES(`created_revision_id`);

DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;
INSERT INTO `section_change_log`
(`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES
(@revision_id,@section_id,'rewritten','section','3.2.1','Abschnitt 3.2.1 vollständig neu gefasst.','Frühere Arbeitsfassung.','Dissertationsfähige Neufassung mit historischem Forschungsstand, Axiomatik, Mengenoperationen und expliziter Forschungsgrenze.'),
(@revision_id,@section_id,'source_added','source','[58]','Fraenkel, Bar-Hillel und Levy als neue Referenzquelle aufgenommen.',NULL,'Foundations of Set Theory.'),
(@revision_id,@section_id,'source_reused','source','[23], [24]','Cantor und Zermelo mit bestehenden Literaturnummern wiederverwendet.',NULL,'Primärquellen zur Mengenlehre.'),
(@revision_id,@section_id,'equation_changed','equation','(3.3)–(3.16)','Gleichungsbestand des Abschnitts vollständig neu aufgebaut.',NULL,'14 Gleichungen mit Word-LaTeX und Symbolzuordnungen.'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.2.1.1–3.2.1.6','Sechs zentrale Definitionen registriert.',NULL,'Menge, Element, leere Menge, Teilmenge, kartesisches Produkt und Potenzmenge.');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES
('next_citation_number','59'),
('next_equation_number','3.17'),
('last_edited_section','3.2.1'),
('last_repository_revision','RKB-2026-07-14-K3.2.1-NEUFASSUNG-V2')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;



/* ====================== KONTROLLABFRAGEN ====================== */
SELECT ds.`section_code`,ds.`title`,ds.`status`,ds.`is_original_contribution`,ds.`notes`
FROM `dissertation_sections` ds WHERE ds.`section_code` IN ('3.2','3.2.1') ORDER BY ds.`section_code`;

SELECT s.`citation_number`,s.`full_citation_text`,su.`usage_type`,su.`is_first_mention`,su.`citation_checked`
FROM `source_usage` su JOIN `sources` s ON s.`source_id`=su.`source_id`
WHERE su.`section_id`=@section_id ORDER BY s.`citation_number`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions` WHERE `section_id`=@section_id ORDER BY `definition_number`;

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`equation_type`,`validation_status`
FROM `equations` WHERE `section_id`=@section_id
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT e.`equation_number`,COUNT(es.`equation_symbol_id`) AS `symbol_count`
FROM `equations` e LEFT JOIN `equation_symbols` es ON es.`equation_id`=e.`equation_id`
WHERE e.`section_id`=@section_id GROUP BY e.`equation_id`,e.`equation_number`
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT `counter_key`,`counter_value` FROM `repository_counters`
WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision')
ORDER BY `counter_key`;

SELECT
CASE WHEN (SELECT COUNT(*) FROM `equations` WHERE `section_id`=@section_id)=14
THEN 'OK: 14 Gleichungen registriert' ELSE 'FEHLER: Gleichungsanzahl abweichend' END AS `equation_validation`,
CASE WHEN (SELECT COUNT(*) FROM `definitions` WHERE `section_id`=@section_id)=6
THEN 'OK: 6 Definitionen registriert' ELSE 'FEHLER: Definitionsanzahl abweichend' END AS `definition_validation`,
CASE WHEN (SELECT COUNT(*) FROM `source_usage` WHERE `section_id`=@section_id)=3
THEN 'OK: 3 Quellenverwendungen registriert' ELSE 'FEHLER: Quellenverwendungen abweichend' END AS `source_validation`;

SELECT rr.`revision_id`,rr.`revision_code`,rr.`scope_reference`,rr.`version_label`,rr.`revision_date`
FROM `repository_revisions` rr WHERE rr.`revision_id`=@revision_id;

/* ===== 3_2_2.sql_V5.sql ===== */
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

/* ===== 3_2_3.sql_V5.sql ===== */
USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;
/* Abschnitt 3.2.3 – vollständige Neufassung V2 – korrigiert
   Voraussetzung: 3_2_1_reset_und_neufassung_V2_korrigiert.sql und
   3_2_2_neufassung_repository_update_V2_korrigiert.sql wurden ausgeführt.
   Quellen [29], [30] vorhanden; [60] Dirichlet neu.
   Gleichungen (3.42)–(3.64). */
SET @parent_revision_id := (SELECT `revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-14-K3.2.2-NEUFASSUNG-V2' LIMIT 1);
INSERT INTO `repository_revisions` (`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`) VALUES ('RKB-2026-07-14-K3.2.3-NEUFASSUNG-V2',NOW(),'section','3.2.3','2.0','Vollständige Neufassung von Abschnitt 3.2.3 mit modernem Funktionsbegriff, Bild und Urbild, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung.','Olaf Thiele / ChatGPT',@parent_revision_id) ON DUPLICATE KEY UPDATE `revision_id`=LAST_INSERT_ID(`revision_id`),`revision_date`=VALUES(`revision_date`),`summary`=VALUES(`summary`),`parent_revision_id`=VALUES(`parent_revision_id`);
SET @revision_id:=LAST_INSERT_ID();
SET @revision_id := COALESCE(@revision_id,(SELECT `revision_id` FROM `repository_revisions` WHERE `scope_reference`='3.2.3' ORDER BY `revision_id` DESC LIMIT 1));
SET @section_id:=(SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.3' LIMIT 1);
UPDATE `dissertation_sections` SET `title`='Funktionen als mathematische Beschreibung gerichteter Transformationen',`status`='review',`is_original_contribution`=0,`notes`='Vollständige Neufassung V2 mit Quellen [29], [30], [60] und Gleichungen (3.42)–(3.64).' WHERE `section_id`=@section_id;
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Dirichlet','Peter Gustav Lejeune','Dirichlet, Peter Gustav Lejeune',1805,1859,'Autor der Primärquelle zum modernen Funktionsbegriff.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_dirichlet:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`volume`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (60,'dirichlet_functions_1837','journal_article','Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen',1837,1889,'Repertorium der Physik','1','152–174','de',5,'primary',4,'partially_verified','3.2.3','Erstnennung zur historischen Ablösung des Funktionsbegriffs von einer ausschließlich analytischen Darstellung.','Dirichlet, Peter Gustav Lejeune: Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen. Repertorium der Physik, Bd. 1, 1837, S. 152–174; wiederabgedruckt in: Dirichlet’s Werke, Bd. 1, Berlin: Georg Reimer, 1889, S. 133–160.','Dirichlet [60]','Primärquelle zum modernen abstrakten Funktionsbegriff.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_60_id:=LAST_INSERT_ID();
INSERT IGNORE INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_60_id,@author_dirichlet,1,'author');
SET @source_29_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=29 LIMIT 1);
SET @source_30_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=30 LIMIT 1);
DELETE FROM `annotations` WHERE `source_id`=@source_60_id;
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_60_id,'Historische Primärquelle zur Ablösung des Funktionsbegriffs von einer einheitlichen analytischen Formel.','Begründet den Übergang zum abstrakten Zuordnungsbegriff in Abschnitt 3.2.3.','Belegt die wissenschaftshistorische Erweiterung des Funktionsbegriffs.','Eine Funktion wird durch die eindeutige Zuordnung von Argumenten zu Werten bestimmt.','Historische Darstellung ohne moderne mengentheoretische Formalisierung.','Die formale Präzisierung erfolgt mit Lang [29] und Rudin [30].','reviewed',NOW());
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_60_id,@section_id,'first_citation','Historische Entwicklung des modernen Funktionsbegriffs und Ablösung von einer ausschließlich analytischen Darstellung.','Historische Entwicklung in 3.2.3',1,1,'Neufassung 3.2.3 V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_29_id,@section_id,'definition','Formale Definition einer Funktion, Bild, Urbild sowie Existenz- und Eindeutigkeitsbedingungen.','Definitionen in 3.2.3',0,1,'Neufassung 3.2.3 V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_30_id,@section_id,'definition','Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung.','Eigenschaften in 3.2.3',0,1,'Neufassung 3.2.3 V2.',@revision_id);
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.42',@section_id,'Funktion als Abbildung','f:A\\longrightarrow B','f:A\\longrightarrow B','Eine Funktion f bildet die Definitionsmenge A in die Zielmenge B ab.','definition','literature',@source_29_id,NULL,'A und B sind Mengen.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.43',@section_id,'Existenz und Eindeutigkeit','\\forall x\\in A\\;\\exists!\\,y\\in B:\\;f(x)=y','\\forall x\\in A\\;\\exists!\\,y\\in B:\\;f(x)=y','Jedem Element des Definitionsbereichs wird genau ein Element des Zielbereichs zugeordnet.','definition','literature',@source_29_id,NULL,'f ist eine Funktion von A nach B.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.44',@section_id,'Existenzbedingung','\\forall x\\in A\\;\\exists y\\in B:\\;f(x)=y','\\forall x\\in A\\;\\exists y\\in B:\\;f(x)=y','Für jedes Element des Definitionsbereichs existiert mindestens ein Funktionswert.','definition','literature',@source_29_id,NULL,'f ist eine totale Funktion auf A.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.45',@section_id,'Eindeutigkeitsbedingung','\\forall x\\in A\\;\\forall y_1,y_2\\in B:\\;\\left(f(x)=y_1\\land f(x)=y_2\\right)\\Longrightarrow y_1=y_2','\\forall x\\in A\\;\\forall y_1,y_2\\in B:\\;\\left(f(x)=y_1\\land f(x)=y_2\\right)\\Longrightarrow y_1=y_2','Zu einem Ausgangselement können nicht zwei verschiedene Funktionswerte gehören.','definition','literature',@source_29_id,NULL,'x liegt in A; y_1 und y_2 liegen in B.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.46',@section_id,'Funktion als spezielle Relation','f\\subseteq A\\times B','f\\subseteq A\\times B','Eine Funktion ist eine spezielle Relation zwischen A und B.','definition','literature',@source_29_id,NULL,'Zusätzlich gilt die Existenz- und Eindeutigkeitsbedingung.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.47',@section_id,'Funktionswert und Relationspaar','f(x)=y\\Longleftrightarrow(x,y)\\in f','f(x)=y\\Longleftrightarrow(x,y)\\in f','Der Funktionswert y entspricht dem eindeutig zugeordneten Relationspaar.','definition','literature',@source_29_id,NULL,'f ist mengentheoretisch als Relation aufgefasst.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.48',@section_id,'Bild einer Menge','f(A)=\\left\\{f(x)\\mid x\\in A\\right\\}','f(A)=\\left\\{f(x)\\mid x\\in A\\right\\}','Das Bild von A enthält alle tatsächlich auftretenden Funktionswerte.','definition','literature',@source_29_id,NULL,'f ist auf A definiert.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.49',@section_id,'Bildmenge als Teilmenge','f(A)\\subseteq B','f(A)\\subseteq B','Das Bild einer Funktion ist Teilmenge ihrer Zielmenge.','derived','literature',@source_29_id,NULL,'f bildet A nach B ab.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.50',@section_id,'Bild einer Teilmenge','f(M)=\\left\\{f(x)\\mid x\\in M\\right\\}','f(M)=\\left\\{f(x)\\mid x\\in M\\right\\}','Bild einer Teilmenge M des Definitionsbereichs.','definition','literature',@source_29_id,NULL,'M ist Teilmenge von A.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.51',@section_id,'Urbild einer Teilmenge','f^{-1}(N)=\\left\\{x\\in A\\mid f(x)\\in N\\right\\}','f^{-1}(N)=\\left\\{x\\in A\\mid f(x)\\in N\\right\\}','Das Urbild enthält alle Ausgangselemente, deren Bilder in N liegen.','definition','literature',@source_29_id,NULL,'N ist Teilmenge von B; keine inverse Funktion erforderlich.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.52',@section_id,'Injektivität','\\forall x_1,x_2\\in A:\\;f(x_1)=f(x_2)\\Longrightarrow x_1=x_2','\\forall x_1,x_2\\in A:\\;f(x_1)=f(x_2)\\Longrightarrow x_1=x_2','Eine Funktion ist injektiv, wenn gleiche Bilder nur von gleichen Urbildern stammen.','definition','literature',@source_30_id,NULL,'f ist eine Funktion von A nach B.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.53',@section_id,'Äquivalente Injektivitätsbedingung','x_1\\neq x_2\\Longrightarrow f(x_1)\\neq f(x_2)','x_1\\neq x_2\\Longrightarrow f(x_1)\\neq f(x_2)','Verschiedene Ausgangselemente besitzen bei einer injektiven Funktion verschiedene Bilder.','derived','literature',@source_30_id,NULL,'f ist injektiv.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.54',@section_id,'Surjektivität','\\forall y\\in B\\;\\exists x\\in A:\\;f(x)=y','\\forall y\\in B\\;\\exists x\\in A:\\;f(x)=y','Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.','definition','literature',@source_30_id,NULL,'f ist eine Funktion von A nach B.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.55',@section_id,'Bildmenge einer surjektiven Funktion','f(A)=B','f(A)=B','Bei einer surjektiven Funktion stimmen Bild- und Zielmenge überein.','derived','literature',@source_30_id,NULL,'f ist surjektiv.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.56',@section_id,'Bijektivität','f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv}\\land f\\text{ ist surjektiv}','f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv}\\land f\\text{ ist surjektiv}','Bijektivität verbindet Injektivität und Surjektivität.','definition','literature',@source_30_id,NULL,'f ist eine Funktion von A nach B.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.57',@section_id,'Umkehrfunktion','f^{-1}:B\\longrightarrow A','f^{-1}:B\\longrightarrow A','Eine bijektive Funktion besitzt eine Umkehrfunktion von B nach A.','definition','literature',@source_30_id,NULL,'f ist bijektiv.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.58',@section_id,'Linke Umkehrbeziehung','f^{-1}(f(x))=x','f^{-1}(f(x))=x','Die Umkehrfunktion hebt die Wirkung von f auf Elementen aus A auf.','derived','literature',@source_30_id,NULL,'x liegt in A und f ist bijektiv.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.59',@section_id,'Rechte Umkehrbeziehung','f(f^{-1}(y))=y','f(f^{-1}(y))=y','Die Funktion hebt die Wirkung ihrer Umkehrfunktion auf Elementen aus B auf.','derived','literature',@source_30_id,NULL,'y liegt in B und f ist bijektiv.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.60',@section_id,'Komposition von Funktionen','(g\\circ f)(x)=g(f(x))','(g\\circ f)(x)=g(f(x))','Die Komposition wendet zunächst f und anschließend g an.','definition','literature',@source_30_id,NULL,'f:A nach B und g:B nach C.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'g','zweite Funktion','zweite Funktion.','Abbildung',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.61',@section_id,'Assoziativität der Komposition','h\\circ(g\\circ f)=(h\\circ g)\\circ f','h\\circ(g\\circ f)=(h\\circ g)\\circ f','Die Komposition von Funktionen ist assoziativ.','derived','literature',@source_30_id,NULL,'Definitions- und Zielmengen sind kompositionsverträglich.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'g','zweite Funktion','zweite Funktion.','Abbildung',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.62',@section_id,'Identitätsabbildung','\\operatorname{id}_A:A\\longrightarrow A','\\operatorname{id}_A:A\\longrightarrow A','Die Identitätsabbildung ist eine Funktion von A nach A.','definition','literature',@source_30_id,NULL,'A ist eine Menge.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\\operatorname{id}','Identitätsabbildung','Identitätsabbildung.','Abbildung',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.63',@section_id,'Wirkung der Identitätsabbildung','\\operatorname{id}_A(x)=x','\\operatorname{id}_A(x)=x','Die Identitätsabbildung lässt jedes Element unverändert.','definition','literature',@source_30_id,NULL,'x liegt in A.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\\operatorname{id}','Identitätsabbildung','Identitätsabbildung.','Abbildung',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.64',@section_id,'Identität als neutrales Element','f\\circ\\operatorname{id}_A=f=\\operatorname{id}_B\\circ f','f\\circ\\operatorname{id}_A=f=\\operatorname{id}_B\\circ f','Identitätsabbildungen sind neutrale Elemente der Funktionskomposition.','derived','literature',@source_30_id,NULL,'f bildet A nach B ab.','checked',@revision_id)
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
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'f','Funktion','Funktion.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'A','Definitionsmenge','Definitionsmenge.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'B','Zielmenge','Zielmenge.','Menge',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_id,'\\operatorname{id}','Identitätsabbildung','Identitätsabbildung.','Abbildung',4)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.1',@section_id,'Funktion','Eine Funktion von A nach B ist eine Relation, die jedem Element von A genau ein Element von B zuordnet.','f:A\\longrightarrow B','f:A\\longrightarrow B','literature',@source_29_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.2',@section_id,'Bildmenge','Die Bildmenge enthält alle Werte, die durch die Funktion tatsächlich erreicht werden.','f(A)=\\{f(x)\\mid x\\in A\\}','f(A)=\\{f(x)\\mid x\\in A\\}','literature',@source_29_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.3',@section_id,'Urbild','Das Urbild einer Teilmenge N enthält alle Elemente des Definitionsbereichs, deren Bilder in N liegen.','f^{-1}(N)=\\{x\\in A\\mid f(x)\\in N\\}','f^{-1}(N)=\\{x\\in A\\mid f(x)\\in N\\}','literature',@source_29_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.4',@section_id,'Injektive Funktion','Eine Funktion ist injektiv, wenn verschiedene Ausgangselemente verschiedene Bilder besitzen.',NULL,NULL,'literature',@source_30_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.5',@section_id,'Surjektive Funktion','Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.',NULL,NULL,'literature',@source_30_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.6',@section_id,'Bijektive Funktion','Eine Funktion ist bijektiv, wenn sie injektiv und surjektiv ist.',NULL,NULL,'literature',@source_30_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.7',@section_id,'Umkehrfunktion','Die Umkehrfunktion einer bijektiven Funktion ordnet jedem Zielwert sein eindeutiges Urbild zu.','f^{-1}:B\\longrightarrow A','f^{-1}:B\\longrightarrow A','literature',@source_30_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.8',@section_id,'Funktionskomposition','Die Komposition zweier Funktionen wendet die zweite Abbildung auf das Ergebnis der ersten an.','(g\\circ f)(x)=g(f(x))','(g\\circ f)(x)=g(f(x))','literature',@source_30_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.3.9',@section_id,'Identitätsabbildung','Die Identitätsabbildung auf A ordnet jedem Element sich selbst zu.','\\operatorname{id}_A(x)=x','\\operatorname{id}_A(x)=x','literature',@source_30_id,NULL,'Neufassung 3.2.3 V2.','checked',@revision_id)
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
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('f','f','Funktion','Eindeutige Abbildung von A nach B.','section',@section_id,'A','B',0,0,0,'Zentrales Symbol des Abschnitts 3.2.3.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('f^{-1}','f^{-1}','Umkehrfunktion','Inverse Abbildung einer bijektiven Funktion.','section',@section_id,'B','A',0,0,0,'Zentrales Symbol des Abschnitts 3.2.3.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('g\\circ f','g\\circ f','Funktionskomposition','Verkettung zweier kompositionsverträglicher Funktionen.','section',@section_id,'A','C',0,0,0,'Zentrales Symbol des Abschnitts 3.2.3.','checked',@revision_id);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('\\operatorname{id}_A','\\operatorname{id}_A','Identitätsabbildung','Neutrale Abbildung auf A.','section',@section_id,'A','A',0,0,0,'Zentrales Symbol des Abschnitts 3.2.3.','checked',@revision_id);
DELETE FROM `section_change_log` WHERE `revision_id`=@revision_id AND `section_id`=@section_id;
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'rewritten','section','3.2.3','Abschnitt 3.2.3 wurde vollständig neu gefasst.','Bisheriger oder geplanter Abschnittsstand.','Neufassung mit Funktionen, Abbildungseigenschaften, Komposition und Identität.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'source_added','sources','[60]','Dirichlet [60] wurde als neue Primärquelle registriert.',NULL,'1 neue Quelle.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'source_reused','sources','[29], [30]','Die bestehenden Quellen [29] und [30] wurden wiederverwendet.',NULL,'2 Quellenwiederverwendungen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'equation_added','equations','(3.42)–(3.64)','23 Gleichungen wurden registriert.',NULL,'23 Gleichungen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'definition_added','definitions','Def. 3.2.3.1–3.2.3.9','Neun Definitionen wurden registriert.',NULL,'9 Definitionen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'symbol_added','symbols','3.2.3','Zentrale Funktionssymbole wurden registriert.',NULL,'4 Abschnittssymbole.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'status_changed','section','3.2.3','Der Abschnitt wurde auf review gesetzt.',NULL,'review');
INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES ('next_citation_number','61'),('next_equation_number','3.65'),('last_edited_section','3.2.3'),('last_repository_revision','RKB-2026-07-14-K3.2.3-NEUFASSUNG-V2') ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`),`updated_at`=NOW();
COMMIT;

/* Kontrollabfragen */
SELECT `revision_id`,`revision_code`,`parent_revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-14-K3.2.3-NEUFASSUNG-V2';
SELECT `section_code`,`title`,`status`,`notes` FROM `dissertation_sections` WHERE `section_code`='3.2.3';
SELECT s.`citation_number`,s.`full_citation_text`,su.`usage_type`,su.`is_first_mention`,su.`citation_checked` FROM `source_usage` su JOIN `sources` s ON s.`source_id`=su.`source_id` WHERE su.`section_id`=@section_id ORDER BY s.`citation_number`;
SELECT `equation_number`,`title`,`equation_type`,`validation_status` FROM `equations` WHERE `section_id`=@section_id ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);
SELECT `definition_number`,`title`,`validation_status` FROM `definitions` WHERE `section_id`=@section_id ORDER BY `definition_id`;
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision') ORDER BY `counter_key`;

/* ===== 3_2_4.sql_V5.sql ===== */
USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;
/* Abschnitt 3.2.4 – vollständige Neufassung V2
   Voraussetzung: 3_2_3_neufassung_repository_update_V2_korrigiert.sql wurde ausgeführt.
   Neue Quellen [61]–[65]. Gleichungen (3.65)–(3.106). */
SET @parent_revision_id := (SELECT `revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-14-K3.2.3-NEUFASSUNG-V2' LIMIT 1);
INSERT INTO `repository_revisions` (`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`) VALUES ('RKB-2026-07-14-K3.2.4-NEUFASSUNG-V2',NOW(),'section','3.2.4','2.0','Vollständige Neufassung von Abschnitt 3.2.4 mit Magmen, Halbgruppen, Monoiden, Gruppen, Ringen, Körpern, Vektorräumen, Homomorphismen und Symmetriebezug.','Olaf Thiele / ChatGPT',@parent_revision_id) ON DUPLICATE KEY UPDATE `revision_id`=LAST_INSERT_ID(`revision_id`),`revision_date`=VALUES(`revision_date`),`summary`=VALUES(`summary`),`parent_revision_id`=VALUES(`parent_revision_id`);
SET @revision_id := (SELECT `revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-14-K3.2.4-NEUFASSUNG-V2' LIMIT 1);
SET @section_id:=(SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.4' LIMIT 1);

/* ============================================================
   REPARATUR DER GLOBALEN GLEICHUNGSNUMMERIERUNG

   Die Neufassung von 3.2.4 verwendet (3.65)–(3.106).
   Im bisherigen Repository beginnen 3.3 und 3.4 bereits bei (3.87).
   Da equation_number global eindeutig ist, müssen die alten fachlichen
   Artefakte von 3.3 und 3.4 vorübergehend entfernt werden. Die
   Abschnittsgerüste und Literaturquellen bleiben erhalten. 3.3 und 3.4
   werden später mit der neuen fortlaufenden Nummerierung neu aufgebaut.
   ============================================================ */
DROP TEMPORARY TABLE IF EXISTS `tmp_downstream_sections_324`;
CREATE TEMPORARY TABLE `tmp_downstream_sections_324` (
  `section_id` BIGINT UNSIGNED PRIMARY KEY
) ENGINE=MEMORY;

INSERT INTO `tmp_downstream_sections_324` (`section_id`)
SELECT `section_id`
FROM `dissertation_sections`
WHERE `section_code` LIKE '3.3%'
   OR `section_code` LIKE '3.4%';

/* abhängige Gleichungsobjekte zuerst entfernen */
DELETE es
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
JOIN `tmp_downstream_sections_324` t ON t.`section_id`=e.`section_id`;

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
JOIN `tmp_downstream_sections_324` t ON t.`section_id`=e.`section_id`;

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
JOIN `tmp_downstream_sections_324` t ON t.`section_id`=e.`section_id`;

DELETE osl
FROM `object_source_links` osl
WHERE (`osl`.`object_type`='equation' AND `osl`.`object_id` IN (
         SELECT e.`equation_id` FROM `equations` e
         JOIN `tmp_downstream_sections_324` t ON t.`section_id`=e.`section_id`
       ))
   OR (`osl`.`object_type`='definition' AND `osl`.`object_id` IN (
         SELECT d.`definition_id` FROM `definitions` d
         JOIN `tmp_downstream_sections_324` t ON t.`section_id`=d.`section_id`
       ));

DELETE od
FROM `object_dependencies` od
WHERE (`od`.`object_type_from`='equation' AND `od`.`object_id_from` IN (
         SELECT e.`equation_id` FROM `equations` e
         JOIN `tmp_downstream_sections_324` t ON t.`section_id`=e.`section_id`
       ))
   OR (`od`.`object_type_to`='equation' AND `od`.`object_id_to` IN (
         SELECT e.`equation_id` FROM `equations` e
         JOIN `tmp_downstream_sections_324` t ON t.`section_id`=e.`section_id`
       ));

DELETE pd
FROM `proposition_dependencies` pd
JOIN `propositions` p ON p.`proposition_id`=pd.`proposition_id`
JOIN `tmp_downstream_sections_324` t ON t.`section_id`=p.`section_id`;

DELETE ad
FROM `axiom_dependencies` ad
JOIN `axioms` a ON a.`axiom_id`=ad.`axiom_id`
JOIN `tmp_downstream_sections_324` t ON t.`section_id`=a.`section_id`;

DELETE FROM `proofs` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `corollaries` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `lemmas` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `theorems` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `propositions` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `axioms` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `assumptions` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `figures` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `dissertation_tables` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `definitions` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `equations` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `source_usage` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `symbols` WHERE `first_section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);
DELETE FROM `section_change_log` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);

UPDATE `dissertation_sections`
SET `status`='planned',
    `notes`='Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.'
WHERE `section_id` IN (SELECT `section_id` FROM `tmp_downstream_sections_324`);

/* Sicherheitsprüfung: Nach der Bereinigung darf die Nummer (3.87)
   nicht mehr vorhanden sein. */
SET @conflict_count := (
  SELECT COUNT(*) FROM `equations`
  WHERE CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED) BETWEEN 65 AND 106
    AND `section_id` <> @section_id
);

/* Ein absichtlicher Fehler wird erzeugt, falls trotz Bereinigung noch
   globale Nummernkonflikte vorhanden sind. */
DROP TEMPORARY TABLE IF EXISTS `tmp_assert_no_equation_conflict_324`;
CREATE TEMPORARY TABLE `tmp_assert_no_equation_conflict_324` (`ok` TINYINT NOT NULL, UNIQUE KEY (`ok`));
INSERT INTO `tmp_assert_no_equation_conflict_324` (`ok`) VALUES (1);
INSERT INTO `tmp_assert_no_equation_conflict_324` (`ok`)
SELECT 1 WHERE @conflict_count > 0;
UPDATE `dissertation_sections` SET `title`='Algebraische Strukturen als Grundlage regelhafter Verknüpfungen',`status`='review',`is_original_contribution`=0,`notes`='Vollständige Neufassung V2 mit Quellen [61]–[65] und Gleichungen (3.65)–(3.106).' WHERE `section_id`=@section_id;
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Galois','Évariste','Galois, Évariste',1811,1832,'Primärquelle zur Entstehung der Gruppentheorie.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_9:=LAST_INSERT_ID();
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Noether','Emmy','Noether, Emmy',1882,1935,'Primärquellen zur strukturellen Algebra und zum Symmetrie-Erhaltungssatz.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_10:=LAST_INSERT_ID();
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('van der Waerden','Bartel Leendert','van der Waerden, Bartel Leendert',1903,1996,'Systematische Darstellung der modernen abstrakten Algebra.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_11:=LAST_INSERT_ID();
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Mac Lane','Saunders','Mac Lane, Saunders',1909,2005,'Mitautor eines Standardwerks der abstrakten Algebra.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_12:=LAST_INSERT_ID();
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Birkhoff','Garrett','Birkhoff, Garrett',1911,1996,'Mitautor eines Standardwerks der abstrakten Algebra.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_13:=LAST_INSERT_ID();
SET @author_galois:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Galois, Évariste' LIMIT 1);
SET @author_noether:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Noether, Emmy' LIMIT 1);
SET @author_vdw:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='van der Waerden, Bartel Leendert' LIMIT 1);
SET @author_maclane:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Mac Lane, Saunders' LIMIT 1);
SET @author_birkhoff:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Birkhoff, Garrett' LIMIT 1);
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (61,'galois_resolubilite_1846','journal_article','Mémoire sur les conditions de résolubilité des équations par radicaux',1831,1846,'Journal de Mathématiques Pures et Appliquées',NULL,NULL,'11',NULL,'417–433','fr',5,'primary',4,'partially_verified','3.2.4','Historische Primärquelle zur Entstehung der Gruppentheorie.','Galois, Évariste: Mémoire sur les conditions de résolubilité des équations par radicaux. Eingereicht 1831; veröffentlicht in: Journal de Mathématiques Pures et Appliquées, Bd. 11, 1846, S. 417–433.','Galois [61]','Primärquelle zur Symmetriestruktur algebraischer Gleichungen.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_61_id:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (62,'noether_idealtheorie_1921','journal_article','Idealtheorie in Ringbereichen',1921,1921,'Mathematische Annalen',NULL,NULL,'83',NULL,'24–66','de',5,'primary',5,'verified','3.2.4','Primärquelle zur strukturellen Ring- und Idealtheorie.','Noether, Emmy: Idealtheorie in Ringbereichen. Mathematische Annalen, Bd. 83, 1921, S. 24–66.','Noether [62]','Grundlage der modernen strukturellen Algebra.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_62_id:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (63,'van_der_waerden_moderne_algebra_1930','book','Moderne Algebra',1930,1931,NULL,'Springer','Berlin',NULL,NULL,NULL,'de',5,'secondary',5,'partially_verified','3.2.4','Systematische Darstellung abstrakter algebraischer Strukturen.','van der Waerden, Bartel Leendert: Moderne Algebra. Berlin: Springer, 1930–1931.','van der Waerden [63]','Standardwerk zur strukturellen Algebra.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_63_id:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (64,'mac_lane_birkhoff_algebra_1988','book','Algebra',1967,1988,NULL,'Chelsea Publishing','New York',NULL,NULL,NULL,'en',4,'secondary',4,'partially_verified','3.2.4','Standardreferenz zu Gruppen, Homomorphismen und algebraischen Strukturen.','Mac Lane, Saunders; Birkhoff, Garrett: Algebra. 3. Auflage. New York: Chelsea Publishing, 1988.','Mac Lane/Birkhoff [64]','Standardwerk der abstrakten Algebra.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_64_id:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES (65,'noether_invariante_variationsprobleme_1918','journal_article','Invariante Variationsprobleme',1918,1918,'Nachrichten von der Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse',NULL,NULL,NULL,NULL,'235–257','de',5,'primary',5,'verified','3.2.4','Primärquelle zum Zusammenhang von kontinuierlichen Symmetrien und Erhaltungssätzen.','Noether, Emmy: Invariante Variationsprobleme. Nachrichten von der Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse, 1918, S. 235–257.','Noether [65]','Primärquelle zum Noether-Theorem.',@revision_id) ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_65_id:=LAST_INSERT_ID();
DELETE FROM `source_authors` WHERE `source_id`=@source_61_id;
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_61_id,@author_galois,1,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);
DELETE FROM `source_authors` WHERE `source_id`=@source_62_id;
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_62_id,@author_noether,1,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);
DELETE FROM `source_authors` WHERE `source_id`=@source_63_id;
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_63_id,@author_vdw,1,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);
DELETE FROM `source_authors` WHERE `source_id`=@source_64_id;
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_64_id,@author_maclane,1,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_64_id,@author_birkhoff,2,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);
DELETE FROM `source_authors` WHERE `source_id`=@source_65_id;
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_65_id,@author_noether,1,'author')
ON DUPLICATE KEY UPDATE
  `author_order`=VALUES(`author_order`),
  `role`=VALUES(`role`);
DELETE FROM `annotations` WHERE `source_id`=@source_61_id;
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_61_id,'Historische Primärquelle zur gruppentheoretischen Analyse der Lösbarkeit algebraischer Gleichungen.','Begründet den historischen Übergang von Rechenverfahren zu abstrakten Symmetriestrukturen.','Erstnennung zur Entstehung der Gruppentheorie.','Symmetrien der Nullstellen bestimmen die Lösbarkeit durch Radikale.','Historische Primärquelle in älterer Terminologie.','Wird durch moderne algebraische Standardwerke formal präzisiert.','reviewed',NOW());
DELETE FROM `annotations` WHERE `source_id`=@source_62_id;
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_62_id,'Begründet die abstrakte Ideal- und Ringtheorie in axiomatischer Form.','Zentrale Quelle für den strukturellen Paradigmenwechsel der Algebra.','Belegt die systematische Ablösung algebraischer Aussagen von konkreten Zahlbereichen.','Ring- und Idealstrukturen können allgemein axiomatisch untersucht werden.','Fokussiert auf Ringbereiche und Idealtheorie.','Wird mit van der Waerden [63] systematisch eingeordnet.','reviewed',NOW());
DELETE FROM `annotations` WHERE `source_id`=@source_63_id;
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_63_id,'Systematisiert Gruppen, Ringe, Körper und weitere algebraische Strukturen.','Formale Hauptreferenz für die Definitionen in Abschnitt 3.2.4.','Belegt die axiomatische Strukturhierarchie der abstrakten Algebra.','Algebraische Strukturen werden durch Trägermengen, Operationen und Axiome bestimmt.','Historisches Standardwerk; moderne Terminologie kann abweichen.','Wird durch Mac Lane/Birkhoff [64] ergänzt.','reviewed',NOW());
DELETE FROM `annotations` WHERE `source_id`=@source_64_id;
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_64_id,'Stellt Gruppen, Homomorphismen und Isomorphismen in moderner struktureller Form dar.','Referenz für Gruppen, Untergruppen und strukturerhaltende Abbildungen.','Belegt die strukturelle Gleichwertigkeit isomorpher algebraischer Objekte.','Homomorphismen erhalten Verknüpfungsstrukturen.','Lehrbuchdarstellung statt Primärquelle.','Ergänzt die historischen Primärquellen.','reviewed',NOW());
DELETE FROM `annotations` WHERE `source_id`=@source_65_id;
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES (@source_65_id,'Beweist den Zusammenhang kontinuierlicher Symmetrien mit Erhaltungssätzen.','Belegt die wissenschaftliche Bedeutung von Gruppen als Symmetriemodelle.','Primärquelle zur Verbindung von Algebra und theoretischer Physik.','Kontinuierliche Symmetrien führen zu Erhaltungsgrößen.','Setzt variationsanalytische Voraussetzungen voraus.','Dient als Anwendungsbezug der Gruppentheorie.','reviewed',NOW());
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_61_id,@section_id,'first_citation','Historische Entstehung der Gruppentheorie aus der Analyse algebraischer Gleichungen.','Einleitung 3.2.4',1,1,'Neufassung 3.2.4 V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_62_id,@section_id,'first_citation','Strukturelle Ring- und Idealtheorie als Wendepunkt der modernen Algebra.','Einleitung sowie Ringabschnitt 3.2.4',1,1,'Neufassung 3.2.4 V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_63_id,@section_id,'first_citation','Systematische Definition algebraischer Grundstrukturen von der binären Verknüpfung bis zum Vektorraum.','Definitionen und Strukturhierarchie 3.2.4',1,1,'Neufassung 3.2.4 V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_64_id,@section_id,'first_citation','Gruppen, Untergruppen, Homomorphismen und Isomorphismen.','Gruppenabschnitt 3.2.4',1,1,'Neufassung 3.2.4 V2.',@revision_id);
INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES (@source_65_id,@section_id,'first_citation','Zusammenhang von Symmetriegruppen und Erhaltungssätzen.','Symmetrieabschnitt 3.2.4',1,1,'Neufassung 3.2.4 V2.',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.1',@section_id,'Innere binäre Verknüpfung','Eine innere binäre Verknüpfung auf A ordnet jedem Paar aus A×A eindeutig ein Element aus A zu.','\star:A\times A\longrightarrow A','\star:A\times A\longrightarrow A','literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.2',@section_id,'Magma','Ein Magma ist eine nichtleere Menge mit einer abgeschlossenen inneren binären Verknüpfung.','\left(A,\star\right)','\left(A,\star\right)','literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.3',@section_id,'Halbgruppe','Eine Halbgruppe ist ein Magma mit assoziativer Verknüpfung.','\left(A,\star\right)','\left(A,\star\right)','literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.4',@section_id,'Neutrales Element','Ein neutrales Element lässt jedes Element bei links- und rechtsseitiger Verknüpfung unverändert.','e\star a=a\star e=a','e\star a=a\star e=a','literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.5',@section_id,'Monoid','Ein Monoid ist eine Halbgruppe mit neutralem Element.','\left(A,\star,e\right)','\left(A,\star,e\right)','literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.6',@section_id,'Gruppe','Eine Gruppe ist ein Monoid, in dem jedes Element ein inverses Element besitzt.','\left(A,\star\right)','\left(A,\star\right)','literature',@source_64_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.7',@section_id,'Abelsche Gruppe','Eine abelsche Gruppe ist eine Gruppe mit kommutativer Verknüpfung.','a\star b=b\star a','a\star b=b\star a','literature',@source_64_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.8',@section_id,'Untergruppe','Eine Untergruppe ist eine Teilmenge einer Gruppe, die bezüglich derselben Verknüpfung selbst eine Gruppe bildet.','H\subseteq G','H\subseteq G','literature',@source_64_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.9',@section_id,'Homomorphismus','Ein Homomorphismus ist eine Abbildung, die die algebraische Verknüpfung erhält.','\varphi(a\star b)=\varphi(a)\circ\varphi(b)','\varphi(a\star b)=\varphi(a)\circ\varphi(b)','literature',@source_64_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.10',@section_id,'Isomorphismus','Ein Isomorphismus ist ein bijektiver Homomorphismus.','G\cong H','G\cong H','literature',@source_64_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.11',@section_id,'Ring','Ein Ring ist eine Menge mit additiver abelscher Gruppenstruktur und einer assoziativen Multiplikation, die distributiv miteinander verknüpft sind.','\left(R,+,\cdot\right)','\left(R,+,\cdot\right)','literature',@source_62_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.12',@section_id,'Körper','Ein Körper ist ein kommutativer Ring mit Eins, in dem jedes von null verschiedene Element multiplikativ invertierbar ist.',NULL,NULL,'literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`validation_status`,`created_revision_id`) VALUES ('Def. 3.2.4.13',@section_id,'Vektorraum','Ein Vektorraum über K ist eine abelsche Gruppe mit kompatibler Skalarmultiplikation.','K\times V\longrightarrow V','K\times V\longrightarrow V','literature',@source_63_id,'checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.65',@section_id,'Innere binäre Verknüpfung','\star:A\times A\longrightarrow A','\star:A\times A\longrightarrow A','Eine innere Verknüpfung bildet Paare aus A wieder nach A ab.','definition','literature',@source_63_id,NULL,'A ist eine nichtleere Menge.','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.66',@section_id,'Abgeschlossenheit','\forall a,b\in A:\;a\star b\in A','\forall a,b\in A:\;a\star b\in A','Das Ergebnis der Verknüpfung liegt wieder in A.','definition','literature',@source_63_id,NULL,'a,b liegen in A.','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.67',@section_id,'Magma','\left(A,\star\right)','\left(A,\star\right)','Paar aus Trägermenge und innerer Verknüpfung.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.68',@section_id,'Linke Klammerung','\left(a\star b\right)\star c','\left(a\star b\right)\star c','Erste Klammerung einer dreifachen Verknüpfung.','other','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.69',@section_id,'Rechte Klammerung','a\star\left(b\star c\right)','a\star\left(b\star c\right)','Zweite Klammerung einer dreifachen Verknüpfung.','other','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.70',@section_id,'Assoziativität','\forall a,b,c\in A:\;\left(a\star b\right)\star c=a\star\left(b\star c\right)','\forall a,b,c\in A:\;\left(a\star b\right)\star c=a\star\left(b\star c\right)','Assoziativgesetz.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.71',@section_id,'Halbgruppe','\left(A,\star\right)\text{ ist Halbgruppe}\Longleftrightarrow\star\text{ ist abgeschlossen und assoziativ}','\left(A,\star\right)\text{ ist Halbgruppe}\Longleftrightarrow\star\text{ ist abgeschlossen und assoziativ}','Charakterisierung einer Halbgruppe.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.72',@section_id,'Verknüpfungsfolge','a_1\star a_2\star\cdots\star a_n','a_1\star a_2\star\cdots\star a_n','Assoziativ interpretierbare endliche Verknüpfungsfolge.','schema','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.73',@section_id,'Linksneutrales Element','\forall a\in A:\;e\star a=a','\forall a\in A:\;e\star a=a','Linke Neutralität.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.74',@section_id,'Rechtsneutrales Element','\forall a\in A:\;a\star e=a','\forall a\in A:\;a\star e=a','Rechte Neutralität.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.75',@section_id,'Eindeutigkeit des neutralen Elements','e_1=e_1\star e_2=e_2','e_1=e_1\star e_2=e_2','Nachweis der Eindeutigkeit eines neutralen Elements.','derived','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.76',@section_id,'Monoid','\left(A,\star,e\right)\text{ ist Monoid}\Longleftrightarrow\left\{\begin{array}{l}\star\text{ ist assoziativ}\\e\text{ ist neutrales Element}\end{array}\right.','\left(A,\star,e\right)\text{ ist Monoid}\Longleftrightarrow\left\{\begin{array}{l}\star\text{ ist assoziativ}\\e\text{ ist neutrales Element}\end{array}\right.','Charakterisierung eines Monoids.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.77',@section_id,'Positive Potenz','a^n=\underbrace{a\star a\star\cdots\star a}_{n\text{ Faktoren}}','a^n=\underbrace{a\star a\star\cdots\star a}_{n\text{ Faktoren}}','Wiederholte Verknüpfung eines Elements.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.78',@section_id,'Nullte Potenz','a^0=e','a^0=e','Die nullte Potenz entspricht dem neutralen Element.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.79',@section_id,'Freies Wortmonoid','\left(\Sigma^\ast,\cdot,\varepsilon\right)','\left(\Sigma^\ast,\cdot,\varepsilon\right)','Monoid endlicher Wörter unter Konkatenation.','model','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.80',@section_id,'Rechtsinverses','a\star a^{-1}=e','a\star a^{-1}=e','Rechtsseitige Inversenbedingung.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.81',@section_id,'Linksinverses','a^{-1}\star a=e','a^{-1}\star a=e','Linksseitige Inversenbedingung.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.82',@section_id,'Gruppe','\left(A,\star\right)\text{ ist Gruppe}\Longleftrightarrow\left\{\begin{array}{l}\star\text{ ist assoziativ}\\e\text{ existiert}\\\forall a\in A\;\exists a^{-1}\in A\end{array}\right.','\left(A,\star\right)\text{ ist Gruppe}\Longleftrightarrow\left\{\begin{array}{l}\star\text{ ist assoziativ}\\e\text{ existiert}\\\forall a\in A\;\exists a^{-1}\in A\end{array}\right.','Charakterisierung einer Gruppe.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.83',@section_id,'Eindeutigkeit inverser Elemente','b=b\star e=b\star\left(a\star c\right)=\left(b\star a\right)\star c=e\star c=c','b=b\star e=b\star\left(a\star c\right)=\left(b\star a\right)\star c=e\star c=c','Herleitung der Eindeutigkeit des Inversen.','derived','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.84',@section_id,'Kommutativität','\forall a,b\in A:\;a\star b=b\star a','\forall a,b\in A:\;a\star b=b\star a','Kommutativgesetz einer abelschen Gruppe.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.85',@section_id,'Untergruppenkriterium','\forall a,b\in H:\;a\star b^{-1}\in H','\forall a,b\in H:\;a\star b^{-1}\in H','Praktisches Kriterium für eine Untergruppe.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.86',@section_id,'Gruppenhomomorphismus','\varphi\left(a\star b\right)=\varphi(a)\circ\varphi(b)','\varphi\left(a\star b\right)=\varphi(a)\circ\varphi(b)','Erhaltung der Gruppenverknüpfung.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.87',@section_id,'Isomorphie','G\cong H','G\cong H','Kennzeichnung strukturgleicher Gruppen.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.88',@section_id,'Ringstruktur','\left(R,+,\cdot\right)','\left(R,+,\cdot\right)','Ring mit zwei inneren Operationen.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.89',@section_id,'Assoziativität der Addition','\forall a,b,c\in R:\;\left(a+b\right)+c=a+\left(b+c\right)','\forall a,b,c\in R:\;\left(a+b\right)+c=a+\left(b+c\right)','Assoziativgesetz der Addition.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.90',@section_id,'Additives neutrales Element','a+0=a','a+0=a','Additive Neutralität.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.91',@section_id,'Additives Inverses','a+\left(-a\right)=0','a+\left(-a\right)=0','Additive Inversenbedingung.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.92',@section_id,'Assoziativität der Multiplikation','\left(a\cdot b\right)\cdot c=a\cdot\left(b\cdot c\right)','\left(a\cdot b\right)\cdot c=a\cdot\left(b\cdot c\right)','Assoziativgesetz der Multiplikation.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.93',@section_id,'Linkes Distributivgesetz','a\cdot\left(b+c\right)=a\cdot b+a\cdot c','a\cdot\left(b+c\right)=a\cdot b+a\cdot c','Linke Distributivität.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.94',@section_id,'Rechtes Distributivgesetz','\left(a+b\right)\cdot c=a\cdot c+b\cdot c','\left(a+b\right)\cdot c=a\cdot c+b\cdot c','Rechte Distributivität.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.95',@section_id,'Kommutative Multiplikation','a\cdot b=b\cdot a','a\cdot b=b\cdot a','Kommutativität in einem kommutativen Ring.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.96',@section_id,'Multiplikatives neutrales Element','1\cdot a=a=a\cdot 1','1\cdot a=a=a\cdot 1','Multiplikative Neutralität.','definition','literature',@source_62_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.97',@section_id,'Multiplikatives Inverses im Körper','\forall a\neq0\;\exists a^{-1}:\;a\cdot a^{-1}=1','\forall a\neq0\;\exists a^{-1}:\;a\cdot a^{-1}=1','Inverseigenschaft von Körperelementen.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.98',@section_id,'Grundkörper','\mathbb{Q},\;\mathbb{R},\;\mathbb{C}','\mathbb{Q},\;\mathbb{R},\;\mathbb{C}','Beispiele wichtiger Körper.','schema','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.99',@section_id,'Skalarmultiplikation','K\times V\longrightarrow V','K\times V\longrightarrow V','Skalarmultiplikation eines Vektorraums.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.100',@section_id,'Distributivität über Vektoraddition','\lambda\left(u+v\right)=\lambda u+\lambda v','\lambda\left(u+v\right)=\lambda u+\lambda v','Erstes Distributivgesetz des Vektorraums.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.101',@section_id,'Distributivität über Skalaraddition','\left(\lambda+\mu\right)v=\lambda v+\mu v','\left(\lambda+\mu\right)v=\lambda v+\mu v','Zweites Distributivgesetz des Vektorraums.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.102',@section_id,'Assoziativität der Skalarmultiplikation','\left(\lambda\mu\right)v=\lambda\left(\mu v\right)','\left(\lambda\mu\right)v=\lambda\left(\mu v\right)','Verträglichkeit der Skalarmultiplikation.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.103',@section_id,'Skalare Identität','1v=v','1v=v','Wirkung der skalaren Eins.','definition','literature',@source_63_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.104',@section_id,'Homomorphismus','\varphi\left(a\star b\right)=\varphi(a)\star\varphi(b)','\varphi\left(a\star b\right)=\varphi(a)\star\varphi(b)','Allgemeine Erhaltung einer algebraischen Verknüpfung.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.105',@section_id,'Additive Strukturerhaltung','\varphi\left(a+b\right)=\varphi(a)+\varphi(b)','\varphi\left(a+b\right)=\varphi(a)+\varphi(b)','Erhaltung der Ringaddition.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES ('3.106',@section_id,'Multiplikative Strukturerhaltung','\varphi\left(a\cdot b\right)=\varphi(a)\cdot\varphi(b)','\varphi\left(a\cdot b\right)=\varphi(a)\cdot\varphi(b)','Erhaltung der Ringmultiplikation.','definition','literature',@source_64_id,NULL,'','checked',@revision_id)
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
SET @eq_65:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.65' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_65,'\star','binäre Verknüpfung','Innere Verknüpfung auf A.','A×A→A',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_65,'A','Trägermenge','Grundmenge der algebraischen Struktur.','Menge',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @eq_73:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.73' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_73,'e','neutrales Element','Element ohne verändernde Wirkung.','A',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @eq_80:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.80' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_80,'a^{-1}','inverses Element','Inverse zu a.','A',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @eq_86:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.86' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_86,'\varphi','Homomorphismus','Strukturerhaltende Abbildung.','Abbildung',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @eq_88:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.88' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_88,'R','Ring','Trägermenge des Ringes.','Ring',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @eq_99:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.99' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_99,'K','Skalarkörper','Körper der Skalare.','Körper',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_99,'V','Vektorraum','Träger der Vektoren.','Vektorraum',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @eq_100:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.100' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_100,'\lambda','Skalar','Element des Körpers K.','K',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_100,'u','Vektor','Element von V.','V',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`domain_text`,`symbol_order`) VALUES (@eq_100,'v','Vektor','Element von V.','V',3)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.65' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('\star','\star','binäre Verknüpfung','Abgeschlossene innere binäre Verknüpfung.','section',@section_id,@first_eq,NULL,'A×A','A',0,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.73' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('e','e','neutrales Element','Element, das unter der Verknüpfung keine Änderung bewirkt.','section',@section_id,@first_eq,NULL,'A','A',0,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.80' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('a^{-1}','a^{-1}','inverses Element','Inverse zu a bezüglich der Gruppenverknüpfung.','section',@section_id,@first_eq,NULL,'A','A',0,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.86' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('\varphi','\varphi','Homomorphismus','Strukturerhaltende Abbildung zwischen algebraischen Strukturen.','section',@section_id,@first_eq,NULL,NULL,NULL,0,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.88' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('R','R','Ring','Trägermenge mit additiver und multiplikativer Verknüpfung.','section',@section_id,@first_eq,NULL,'Ring',NULL,0,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.99' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('K','K','Skalarkörper','Körper der Skalare eines Vektorraums.','section',@section_id,@first_eq,NULL,'Körper',NULL,0,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @first_eq:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.99' AND `section_id`=@section_id LIMIT 1);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES ('V','V','Vektorraum','Vektorraum über dem Körper K.','section',@section_id,@first_eq,NULL,'Vektorraum',NULL,1,0,0,'Neufassung 3.2.4 V2.','checked',@revision_id) ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);
DELETE FROM `section_change_log` WHERE `revision_id`=@revision_id AND `section_id`=@section_id;
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'rewritten','section','3.2.4','Abschnitt 3.2.4 vollständig neu gefasst.','Bisheriger Repository-Stand.','Neufassung mit fünf neuen Quellen, dreizehn Definitionen und 42 Gleichungen.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'source_added','sources','[61]–[65]','Fünf neue Literaturquellen registriert.',NULL,'Galois [61], Noether [62], van der Waerden [63], Mac Lane/Birkhoff [64], Noether [65].');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'definition_added','definitions','Def. 3.2.4.1–Def. 3.2.4.13','Dreizehn algebraische Definitionen registriert.',NULL,'Binäre Verknüpfung bis Vektorraum.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'equation_added','equations','(3.65)–(3.106)','42 Gleichungen registriert.',NULL,'Algebraische Strukturen und Strukturerhaltung.');
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES (@revision_id,@section_id,'symbol_added','symbols','\star, e, a^{-1}, \varphi, R, K, V','Zentrale Abschnittssymbole registriert.',NULL,'Symbolregister 3.2.4 V2.');
INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES ('next_citation_number','66'),('next_equation_number','3.107'),('last_edited_section','3.2.4'),('last_repository_revision','RKB-2026-07-14-K3.2.4-NEUFASSUNG-V2') ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);
COMMIT;

/* Kontrollabfragen */
SELECT `revision_code`,`scope_reference`,`version_label`,`parent_revision_id` FROM `repository_revisions` WHERE `revision_id`=@revision_id;
SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes` FROM `dissertation_sections` WHERE `section_id`=@section_id;
SELECT s.`citation_number`,s.`source_key`,s.`title`,s.`verification_status` FROM `sources` s WHERE s.`citation_number` BETWEEN 61 AND 65 ORDER BY s.`citation_number`;
SELECT COUNT(*) AS `source_usages`,SUM(`is_first_mention`) AS `first_mentions` FROM `source_usage` WHERE `section_id`=@section_id;
SELECT `definition_number`,`title`,`validation_status` FROM `definitions` WHERE `section_id`=@section_id ORDER BY CAST(SUBSTRING_INDEX(`definition_number`,'.',-1) AS UNSIGNED);
SELECT `equation_number`,`title`,`equation_type`,`word_latex`,`validation_status` FROM `equations` WHERE `section_id`=@section_id ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);
SELECT COUNT(*) AS `equation_count` FROM `equations` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `orphan_equation_symbols` FROM `equation_symbols` es LEFT JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`equation_id` IS NULL;
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision') ORDER BY `counter_key`;
SELECT COUNT(*) AS `invalid_equation_types` FROM `equations` WHERE `section_id`=@section_id AND `equation_type` NOT IN ('definition','axiom','theorem','lemma','derived','schema','model','metric','other');

/* ===== 3_2_5.sql_V5.sql ===== */
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

/* ===== 3_2_6.sql_V5.sql ===== */
USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.2.6 – vollständige Neufassung V2
   Grundlage: Datenbankstand bis einschließlich 3.2.5.
   Neue Quellen [68]–[69]. Gleichungen (3.136)–(3.158). */

SET @parent_revision_id := (
  SELECT `revision_id` FROM `repository_revisions`
  WHERE `revision_code`='RKB-2026-07-15-K3.2.5-NEUFASSUNG-V2' LIMIT 1
);

INSERT INTO `repository_revisions`
(`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`)
VALUES
('RKB-2026-07-15-K3.2.6-NEUFASSUNG-V2',NOW(),'section','3.2.6','2.0',
'Vollständige Neufassung von Abschnitt 3.2.6 mit Zustandsraumbegriff, vollständiger Zustandsbeschreibung, diskreten und kontinuierlichen Zustandsentwicklungen, Flüssen, Trajektorien und Gleichgewichtspunkten.',
'Olaf Thiele / ChatGPT',@parent_revision_id)
ON DUPLICATE KEY UPDATE
`revision_id`=LAST_INSERT_ID(`revision_id`),
`revision_date`=VALUES(`revision_date`),
`summary`=VALUES(`summary`),
`parent_revision_id`=VALUES(`parent_revision_id`);
SET @revision_id := LAST_INSERT_ID();
SET @revision_id := COALESCE(@revision_id,(SELECT `revision_id` FROM `repository_revisions` WHERE `scope_reference`='3.2.6' ORDER BY `revision_id` DESC LIMIT 1));
SET @section_id := (SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.6' LIMIT 1);

UPDATE `dissertation_sections` SET
`title`='Zustandsräume als mathematische Grundlage funktionaler Dynamik',
`status`='review',
`is_original_contribution`=0,
`notes`='Vollständige Neufassung V2 mit Quellen [68]–[69] und Gleichungen (3.136)–(3.158).',
`updated_at`=NOW()
WHERE `section_id`=@section_id;

/* Abschnittsbezogene Altinhalte kontrolliert entfernen */
DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id` OR e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`section_id`=@section_id;
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';

/* Eventuelle frühere Belegung der neuen Literaturziffern entfernen */
SET @old_source_68 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=68 LIMIT 1);
SET @old_source_69 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=69 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id` IN (@old_source_68,@old_source_69);
DELETE FROM `annotations` WHERE `source_id` IN (@old_source_68,@old_source_69);
DELETE FROM `source_topics` WHERE `source_id` IN (@old_source_68,@old_source_69);
DELETE FROM `source_relations` WHERE `source_id_from` IN (@old_source_68,@old_source_69) OR `source_id_to` IN (@old_source_68,@old_source_69);
DELETE FROM `source_authors` WHERE `source_id` IN (@old_source_68,@old_source_69);
DELETE FROM `sources` WHERE `source_id` IN (@old_source_68,@old_source_69);

/* Autoren */
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
VALUES ('Kalman','Rudolf E.','Kalman, Rudolf E.',1930,2016,'Grundlegende Quelle zur modernen Zustandsraumdarstellung linearer dynamischer Systeme.')
ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_kalman := (SELECT `author_id` FROM `authors` WHERE `normalized_name`='Kalman, Rudolf E.' LIMIT 1);
SET @author_arnold := (SELECT `author_id` FROM `authors` WHERE `normalized_name`='Arnold, Vladimir I.' LIMIT 1);

/* Quellen [68]–[69] */
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES (68,'kalman_linear_dynamical_systems_1963','journal_article','Mathematical Description of Linear Dynamical Systems',1963,1963,'Journal of the Society for Industrial and Applied Mathematics, Series A: Control',NULL,NULL,'1','2','152–192','en',5,'primary',5,'partially_verified','3.2.6','Primärquelle zur modernen Zustandsraumdarstellung linearer Systeme.','Kalman, Rudolf E.: Mathematical Description of Linear Dynamical Systems. Journal of the Society for Industrial and Applied Mathematics, Series A: Control, Bd. 1, Nr. 2, 1963, S. 152–192.','Kalman [68]','Grundlage des modernen Zustandsraumansatzes.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_68_id := LAST_INSERT_ID();

INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES (69,'arnold_ordinary_differential_equations_1973','book','Ordinary Differential Equations',1973,1973,NULL,'MIT Press','Cambridge, Massachusetts',NULL,NULL,NULL,NULL,'en',5,'reference',5,'partially_verified','3.2.6','Standardwerk zu Flüssen, Trajektorien und Gleichgewichtspunkten.','Arnold, Vladimir I.: Ordinary Differential Equations. Cambridge, Massachusetts: MIT Press, 1973.','Arnold [69]','Mathematische Grundlage kontinuierlicher Zustandsentwicklungen.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_69_id := LAST_INSERT_ID();

INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES
(@source_68_id,@author_kalman,1,'author'),
(@source_69_id,@author_arnold,1,'author')
ON DUPLICATE KEY UPDATE `role`=VALUES(`role`);

/* Quellenannotationen */
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES
(@source_68_id,'Formalisierung linearer dynamischer Systeme durch Zustandsvektoren und Zustandsraumdarstellungen.','Zentrale Primärquelle für den modernen Zustandsraumbegriff in 3.2.6.','Belegt die vollständige interne Zustandsbeschreibung als Grundlage weiterer Systementwicklung.','Der Zustand enthält die für die weitere Entwicklung relevanten Systeminformationen.','Schwerpunkt auf linearen endlichdimensionalen Systemen.','Wird durch allgemeine dynamische Systemtheorie und nichtlineare Modelle ergänzt.','reviewed',NOW())
ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`annotation_status`='reviewed',`reviewed_at`=NOW();
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES
(@source_69_id,'Allgemeine Theorie gewöhnlicher Differentialgleichungen, Flüsse und Trajektorien.','Grundlage für die kontinuierliche Zustandsentwicklung in 3.2.6.','Belegt die mathematische Beschreibung autonomer und nichtautonomer Dynamik im Zustandsraum.','Kontinuierliche Systementwicklung kann durch Anfangswertprobleme und Flüsse dargestellt werden.','Behandelt primär gewöhnliche Differentialgleichungen.','Unendlichdimensionale und stochastische Entwicklungen werden später gesondert betrachtet.','reviewed',NOW())
ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`annotation_status`='reviewed',`reviewed_at`=NOW();

/* Vorhandene Standardquellen */
SET @source_38_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=38 LIMIT 1);
SET @source_39_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=39 LIMIT 1);
SET @source_40_id := (SELECT `source_id` FROM `sources` WHERE `citation_number`=40 LIMIT 1);

INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES
(@source_68_id,@section_id,'first_citation','Moderner Zustandsraumansatz mit internem Zustandsvektor.','Einleitender Forschungsstand und Zustandsdefinition',1,1,'Neue Erstnennung [68].',@revision_id),
(@source_69_id,@section_id,'first_citation','Kontinuierliche Zustandsentwicklung, Anfangswertproblem, Fluss und Trajektorie.','Kontinuierliche Zustandsentwicklung',1,1,'Neue Erstnennung [69].',@revision_id),
(@source_38_id,@section_id,'method','Zustandsraumdarstellung, Nebenbedingungen und Übergangsabbildungen.','Vollständige Zustandsbeschreibung und zulässige Zustände',0,1,'Bestehende Standardquelle wiederverwendet.',@revision_id),
(@source_39_id,@section_id,'definition','Gleichgewichtspunkte und nichtlineare Systemdarstellungen.','Gleichgewichtszustände',0,1,'Bestehende Standardquelle wiederverwendet.',@revision_id),
(@source_40_id,@section_id,'state_of_research','Diskrete Dynamik, Trajektorien und geometrische Interpretation dynamischer Systeme.','Diskrete Zustandsentwicklung und Trajektorien',0,1,'Bestehende Standardquelle wiederverwendet.',@revision_id);

/* Definitionen */
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.1',@section_id,'Zustand','Ein Zustand eines Systems ist ein Element des Zustandsraumes und enthält die für die weitere Modellentwicklung relevanten Angaben.','x\\in X','x\\in X','literature',@source_68_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.2',@section_id,'Zustandsraum','Der Zustandsraum ist die Menge aller im Modell zulässigen Zustände eines Systems.','X','X','literature',@source_68_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.3',@section_id,'Vollständige Zustandsbeschreibung','Eine Zustandsbeschreibung ist vollständig, wenn der aktuelle Zustand zusammen mit der Übergangsregel die weitere Entwicklung bestimmt.','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','literature',@source_68_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.4',@section_id,'Zulässiger Zustandsraum','Der zulässige Zustandsraum ist die Teilmenge aller Zustände, welche die Modellnebenbedingungen erfüllen.','X_{\\mathrm{zul}}\\subseteq X','X_{\\mathrm{zul}}\\subseteq X','literature',@source_38_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.5',@section_id,'Diskrete Zustandsentwicklung','Eine diskrete Zustandsentwicklung ist eine durch Iteration einer Übergangsabbildung erzeugte Zustandsfolge.','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','literature',@source_40_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.6',@section_id,'Zeitabhängige Zustandsfunktion','Eine zeitabhängige Zustandsfunktion ordnet jedem Zeitpunkt eines Intervalls genau einen Zustand zu.','x:I\\longrightarrow X','x:I\\longrightarrow X','literature',@source_69_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.7',@section_id,'Fluss','Ein Fluss ist eine zeitparametrisierte Familie von Zustandsabbildungen mit Identitäts- und Kompositionseigenschaft.','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','literature',@source_69_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.8',@section_id,'Trajektorie','Eine Trajektorie ist die Menge aller Zustände, die aus einem Anfangszustand entlang eines Flusses erreicht werden.','\\gamma(x_0)=\\{\\Phi(t,x_0)\\mid t\\in I\\}','\\gamma(x_0)=\\{\\Phi(t,x_0)\\mid t\\in I\\}','literature',@source_40_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.9',@section_id,'Gleichgewichtspunkt','Ein Gleichgewichtspunkt ist ein Zustand, dessen zeitliche Entwicklung unverändert bleibt.','F(x^\\ast)=0','F(x^\\ast)=0','literature',@source_39_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id)
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

/* Gleichungen */
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.136',@section_id,'Zustand im Zustandsraum','x\\in X','x\\in X','Ein Zustand x ist Element des Zustandsraumes X.','definition','literature',@source_68_id,NULL,'X ist ein nichtleerer Zustandsraum.','checked',@revision_id);
SET @eq_3_136 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.137',@section_id,'Zustandsvektor','x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n\\\\\\end{pmatrix}','x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n\\\\\\end{pmatrix}','Darstellung eines n-dimensionalen Zustandes als Spaltenvektor.','definition','literature',@source_68_id,NULL,'Das System besitzt n Zustandsgrößen.','checked',@revision_id)
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
SET @eq_3_137 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.138',@section_id,'Endlichdimensionaler Zustandsraum','X\\subseteq\\mathbb{R}^{n}','X\\subseteq\\mathbb{R}^{n}','Zulässiger Zustandsraum als Teilmenge des reellen n-dimensionalen Raumes.','definition','literature',@source_68_id,NULL,'Endlichdimensionale reelle Zustandsbeschreibung.','checked',@revision_id)
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
SET @eq_3_138 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.139',@section_id,'Übergangsabbildung','F:X\\longrightarrow X','F:X\\longrightarrow X','Abbildung eines Zustandes auf einen Folgezustand desselben Zustandsraumes.','definition','literature',@source_38_id,NULL,'Vollständige Zustandsbeschreibung und deterministische Übergangsregel.','checked',@revision_id)
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
SET @eq_3_139 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.140',@section_id,'Diskreter Zustandsübergang','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','Rekursive Erzeugung des Folgezustandes aus dem aktuellen Zustand.','model','literature',@source_38_id,NULL,'Diskrete deterministische Dynamik.','checked',@revision_id)
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
SET @eq_3_140 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.141',@section_id,'Zulässige Zustände mit Gleichungsnebenbedingung','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)=0\\right\\}','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)=0\\right\\}','Zulässige Zustände unter einer Gleichungsnebenbedingung.','definition','literature',@source_38_id,NULL,'g ist eine geeignete Nebenbedingungsabbildung.','checked',@revision_id)
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
SET @eq_3_141 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.142',@section_id,'Zulässige Zustände mit Ungleichungsnebenbedingung','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)\\leq0\\right\\}','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)\\leq0\\right\\}','Zulässige Zustände unter einer Ungleichungsnebenbedingung.','definition','literature',@source_38_id,NULL,'g ist eine geeignete Nebenbedingungsabbildung.','checked',@revision_id)
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
SET @eq_3_142 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.143',@section_id,'Diskrete Zustandsfolge','x_0,x_1,x_2,\\ldots','x_0,x_1,x_2,\\ldots','Geordnete Folge diskreter Zustände.','schema','literature',@source_40_id,NULL,'Diskrete Zeitindizes k∈N.','checked',@revision_id)
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
SET @eq_3_143 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.144',@section_id,'Rekursive diskrete Dynamik','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','Erneute Darstellung der rekursiven Zustandsentwicklung im Kontext diskreter Systeme.','model','literature',@source_40_id,NULL,'Diskrete deterministische Dynamik.','checked',@revision_id)
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
SET @eq_3_144 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.145',@section_id,'Iterierte Zustandsentwicklung','x_k=F^{\\,k}(x_0)','x_k=F^{\\,k}(x_0)','Zustand nach k-facher Iteration der Übergangsabbildung.','derived','literature',@source_40_id,NULL,'F ist k-fach kompositionsfähig.','checked',@revision_id)
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
SET @eq_3_145 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.146',@section_id,'Zeitabhängige Zustandsfunktion','x:I\\longrightarrow X','x:I\\longrightarrow X','Zuordnung eines Zustandes zu jedem Zeitpunkt eines Intervalls I.','definition','literature',@source_69_id,NULL,'I ist ein reelles Zeitintervall.','checked',@revision_id)
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
SET @eq_3_146 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.147',@section_id,'Zeitliche Ableitung des Zustandes','\\dot{x}(t)=\\frac{dx(t)}{dt}','\\dot{x}(t)=\\frac{dx(t)}{dt}','Ableitung der Zustandsfunktion nach der Zeit.','definition','literature',@source_69_id,NULL,'x ist differenzierbar.','checked',@revision_id)
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
SET @eq_3_147 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.148',@section_id,'Nichtautonome Zustandsgleichung','\\dot{x}(t)=F(x(t),t)','\\dot{x}(t)=F(x(t),t)','Allgemeines zeitabhängiges Entwicklungsgesetz.','model','literature',@source_69_id,NULL,'F ist hinreichend regulär.','checked',@revision_id)
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
SET @eq_3_148 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.149',@section_id,'Autonome Zustandsgleichung','\\dot{x}=F(x)','\\dot{x}=F(x)','Zeitinvariante kontinuierliche Zustandsentwicklung.','model','literature',@source_69_id,NULL,'F hängt nicht explizit von t ab.','checked',@revision_id)
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
SET @eq_3_149 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.150',@section_id,'Anfangsbedingung','x(t_0)=x_0','x(t_0)=x_0','Festlegung des Anfangszustandes zum Zeitpunkt t0.','definition','literature',@source_69_id,NULL,'x0 liegt im Zustandsraum.','checked',@revision_id)
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
SET @eq_3_150 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.151',@section_id,'Anfangswertproblem','\\left\\{\\begin{array}{l}\\dot{x}=F(x,t)\\\\x(t_0)=x_0\\end{array}\\right.','\\left\\{\\begin{array}{l}\\dot{x}=F(x,t)\\\\x(t_0)=x_0\\end{array}\\right.','Kombination aus Entwicklungsgleichung und Anfangsbedingung.','model','literature',@source_69_id,NULL,'Existenz- und Eindeutigkeitsbedingungen sind gesondert zu prüfen.','checked',@revision_id)
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
SET @eq_3_151 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.152',@section_id,'Flussabbildung','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','Fluss als zeitparametrisierte Zustandsabbildung.','definition','literature',@source_69_id,NULL,'Globale Definition des Flusses vorausgesetzt.','checked',@revision_id)
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
SET @eq_3_152 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.153',@section_id,'Fluss und Lösung','\\Phi(t,x_0)=x(t)','\\Phi(t,x_0)=x(t)','Zuordnung der Lösungskurve zum Anfangszustand.','definition','literature',@source_69_id,NULL,'x(t) ist Lösung des Anfangswertproblems.','checked',@revision_id)
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
SET @eq_3_153 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.154',@section_id,'Identität des Flusses','\\Phi(0,x)=x','\\Phi(0,x)=x','Der Fluss lässt den Zustand bei Zeitparameter Null unverändert.','definition','literature',@source_69_id,NULL,'Flussstruktur.','checked',@revision_id)
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
SET @eq_3_154 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.155',@section_id,'Flusseigenschaft','\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)','\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)','Kompositionsgesetz zeitlicher Entwicklungen.','definition','literature',@source_69_id,NULL,'Kompatible Existenzintervalle.','checked',@revision_id)
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
SET @eq_3_155 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.156',@section_id,'Trajektorie','\\gamma(x_0)=\\left\\{\\Phi(t,x_0)\\mid t\\in I\\right\\}','\\gamma(x_0)=\\left\\{\\Phi(t,x_0)\\mid t\\in I\\right\\}','Menge aller entlang des Flusses erreichten Zustände.','definition','literature',@source_40_id,NULL,'I ist das betrachtete Zeitintervall.','checked',@revision_id)
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
SET @eq_3_156 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.157',@section_id,'Gleichgewichtspunkt','F(x^\\ast)=0','F(x^\\ast)=0','Ein Gleichgewichtspunkt ist eine Nullstelle des Vektorfeldes.','definition','literature',@source_39_id,NULL,'Autonomes dynamisches System.','checked',@revision_id)
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
SET @eq_3_157 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.158',@section_id,'Invarianz eines Gleichgewichtspunktes','\\Phi(t,x^\\ast)=x^\\ast','\\Phi(t,x^\\ast)=x^\\ast','Ein Gleichgewichtspunkt bleibt unter dem Fluss unverändert.','derived','literature',@source_39_id,NULL,'x* ist Gleichgewichtspunkt.','checked',@revision_id)
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
SET @eq_3_158 := LAST_INSERT_ID();

/* Ausgewählte Gleichungssymbole */
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_136,'x','Zustand','Aktueller Zustand des Systems.',NULL,'X',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_136,'X','Zustandsraum','Menge aller zulässigen Zustände.',NULL,'Menge oder Raum',2)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_137,'x_i','Zustandskomponente','i-te Komponente des Zustandsvektors.',NULL,'\\mathbb R',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_139,'F','Übergangsabbildung','Abbildung eines Zustandes auf den Folgezustand.',NULL,'X\\to X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_140,'k','diskreter Index','Index des diskreten Entwicklungsschrittes.',NULL,'\\mathbb N',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_141,'X_{\\mathrm{zul}}','zulässiger Zustandsraum','Menge aller nebenbedingungskonformen Zustände.',NULL,'Teilmenge von X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_146,'I','Zeitintervall','Definitionsintervall der Zustandsfunktion.',NULL,'Teilmenge von \\mathbb R',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_147,'\\dot{x}(t)','Zustandsableitung','Zeitliche Änderungsrate des Zustandes.',NULL,'Tangentialraum',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_152,'\\Phi','Fluss','Zeitparametrisierte Zustandsabbildung.',NULL,'\\mathbb R\\times X\\to X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_156,'\\gamma(x_0)','Trajektorie','Bahn des Anfangszustandes im Zustandsraum.',NULL,'Teilmenge von X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_157,'x^\\ast','Gleichgewichtspunkt','Zustand mit verschwindendem Vektorfeld.',NULL,'X',1)
ON DUPLICATE KEY UPDATE
  `symbol_name`=VALUES(`symbol_name`),
  `definition_text`=VALUES(`definition_text`),
  `unit_text`=VALUES(`unit_text`),
  `domain_text`=VALUES(`domain_text`),
  `symbol_order`=VALUES(`symbol_order`);

/* Abschnittssymbole */
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('X','X','Zustandsraum','Menge oder Raum aller zulässigen Zustände.','section',@section_id,@eq_3_136,NULL,'Zustände',NULL,0,0,0,'Zentrales Symbol des Abschnitts 3.2.6.','checked',@revision_id),
('x','x','Zustand','Einzelner Zustand eines Systems.','section',@section_id,@eq_3_136,NULL,'X',NULL,1,0,0,'Kontextabhängig skalar, Vektor oder Funktion.','checked',@revision_id),
('F','F','Entwicklungs- oder Übergangsabbildung','Regel zur Erzeugung von Folgezuständen.','section',@section_id,@eq_3_139,NULL,'X','X',0,0,1,'Diskrete oder kontinuierliche Dynamik.','checked',@revision_id),
('X_{\mathrm{zul}}','X_{\mathrm{zul}}','zulässiger Zustandsraum','Teilmenge aller nebenbedingungskonformen Zustände.','section',@section_id,@eq_3_141,NULL,'X',NULL,0,0,0,'Durch Modellnebenbedingungen eingeschränkt.','checked',@revision_id),
('\Phi','\Phi','Fluss','Zeitparametrisierte Familie von Zustandsabbildungen.','section',@section_id,@eq_3_152,NULL,'\mathbb R\times X','X',0,0,1,'Kontinuierliche Zustandsentwicklung.','checked',@revision_id),
('\gamma(x_0)','\gamma(x_0)','Trajektorie','Menge der aus x0 entlang des Flusses erreichten Zustände.','section',@section_id,@eq_3_156,NULL,'Zeitintervall','Teilmenge von X',0,0,0,'Geometrische Bahn im Zustandsraum.','checked',@revision_id),
('x^\ast','x^\ast','Gleichgewichtspunkt','Zustand mit verschwindender Dynamik.','section',@section_id,@eq_3_157,NULL,'X',NULL,0,0,0,'Invarianter stationärer Zustand.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`is_vector`=VALUES(`is_vector`),`is_operator`=VALUES(`is_operator`),`notes`=VALUES(`notes`),`validation_status`=VALUES(`validation_status`),`created_revision_id`=VALUES(`created_revision_id`);

DELETE FROM `section_change_log` WHERE `revision_id`=@revision_id AND `section_id`=@section_id;
INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES
(@revision_id,@section_id,'rewritten','section','3.2.6','Abschnitt 3.2.6 vollständig neu gefasst.','Bisheriger Repository-Stand.','Neufassung mit Zustandsraum, diskreter und kontinuierlicher Dynamik, Fluss, Trajektorie und Gleichgewicht.'),
(@revision_id,@section_id,'source_added','sources','[68]–[69]','Zwei neue Quellen registriert.',NULL,'Kalman [68], Arnold [69].'),
(@revision_id,@section_id,'source_reused','sources','[38]–[40]','Drei bestehende Standardquellen wiederverwendet.',NULL,'Sontag [38], Khalil [39], Hirsch/Smale/Devaney [40].'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.2.6.1–Def. 3.2.6.9','Neun Definitionen registriert.',NULL,'Zustand bis Gleichgewichtspunkt.'),
(@revision_id,@section_id,'equation_added','equations','(3.136)–(3.158)','23 Gleichungen registriert.',NULL,'Zustandsraum, Übergänge, Nebenbedingungen, Fluss, Trajektorie und Gleichgewicht.'),
(@revision_id,@section_id,'symbol_added','symbols','X, x, F, X_zul, Phi, gamma(x0), x*','Zentrale Zustandsraumsymbole registriert.',NULL,'Symbolregister 3.2.6.');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES
('next_citation_number','70'),
('next_equation_number','3.159'),
('last_edited_section','3.2.6'),
('last_repository_revision','RKB-2026-07-15-K3.2.6-NEUFASSUNG-V2')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen */
SELECT `revision_id`,`revision_code`,`parent_revision_id`,`scope_reference`,`version_label` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-15-K3.2.6-NEUFASSUNG-V2';
SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes` FROM `dissertation_sections` WHERE `section_code`='3.2.6';
SELECT `citation_number`,`source_key`,`title`,`verification_status` FROM `sources` WHERE `citation_number` IN (38,39,40,68,69) ORDER BY `citation_number`;
SELECT COUNT(*) AS `source_usage_count`,SUM(`is_first_mention`) AS `first_mentions`,SUM(`citation_checked`) AS `checked_usages` FROM `source_usage` WHERE `section_id`=@section_id;
SELECT `definition_number`,`title`,`validation_status` FROM `definitions` WHERE `section_id`=@section_id ORDER BY `definition_number`;
SELECT `equation_number`,`title`,`equation_type`,`word_latex`,`validation_status` FROM `equations` WHERE `section_id`=@section_id ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);
SELECT COUNT(*) AS `equation_count` FROM `equations` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `equation_symbol_count` FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision') ORDER BY `counter_key`;
SELECT COUNT(*) AS `duplicate_equation_numbers` FROM (SELECT `equation_number` FROM `equations` GROUP BY `equation_number` HAVING COUNT(*)>1) q;
SELECT COUNT(*) AS `invalid_equation_types` FROM `equations` WHERE `section_id`=@section_id AND `equation_type` NOT IN ('definition','axiom','theorem','lemma','derived','schema','model','metric','other');
SELECT COUNT(*) AS `missing_word_latex` FROM `equations` WHERE `section_id`=@section_id AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');
SELECT COUNT(*) AS `orphan_equation_symbols` FROM `equation_symbols` es LEFT JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`equation_id` IS NULL;
/* ===== FINAL AUDIT ===== */
USE `frzk_rkb`;
SET NAMES utf8mb4;

SELECT 'REVISION_CHAIN' AS audit_block;
SELECT r.revision_id,r.revision_code,r.scope_reference,r.parent_revision_id,p.revision_code AS parent_code
FROM repository_revisions r
LEFT JOIN repository_revisions p ON p.revision_id=r.parent_revision_id
WHERE r.scope_reference IN ('3.2.1','3.2.2','3.2.3','3.2.4','3.2.5','3.2.6')
ORDER BY r.revision_id;

SELECT 'SECTION_STATUS' AS audit_block;
SELECT section_code,title,status,is_original_contribution
FROM dissertation_sections
WHERE section_code BETWEEN '3.2.1' AND '3.2.6'
ORDER BY section_code;

SELECT 'EQUATION_COUNTS' AS audit_block;
SELECT ds.section_code,COUNT(e.equation_id) AS equation_count,
       MIN(CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED)) AS min_number,
       MAX(CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED)) AS max_number,
       SUM(e.word_latex IS NULL OR TRIM(e.word_latex)='') AS missing_word_latex
FROM dissertation_sections ds
LEFT JOIN equations e ON e.section_id=ds.section_id
WHERE ds.section_code BETWEEN '3.2.1' AND '3.2.6'
GROUP BY ds.section_id,ds.section_code
ORDER BY ds.section_code;

SELECT 'DUPLICATE_EQUATIONS' AS audit_block;
SELECT equation_number,COUNT(*) AS duplicate_count
FROM equations
GROUP BY equation_number
HAVING COUNT(*)>1;

SELECT 'DUPLICATE_EQUATION_SYMBOLS' AS audit_block;
SELECT equation_id,symbol_latex,COUNT(*) AS duplicate_count
FROM equation_symbols
GROUP BY equation_id,symbol_latex
HAVING COUNT(*)>1;

SELECT 'ORPHANS' AS audit_block;
SELECT 'equation_symbols_without_equation' AS orphan_type,COUNT(*) AS orphan_count
FROM equation_symbols es LEFT JOIN equations e ON e.equation_id=es.equation_id
WHERE e.equation_id IS NULL
UNION ALL
SELECT 'equations_without_section',COUNT(*)
FROM equations e LEFT JOIN dissertation_sections ds ON ds.section_id=e.section_id
WHERE ds.section_id IS NULL
UNION ALL
SELECT 'source_usage_without_source',COUNT(*)
FROM source_usage su LEFT JOIN sources s ON s.source_id=su.source_id
WHERE s.source_id IS NULL
UNION ALL
SELECT 'source_usage_without_section',COUNT(*)
FROM source_usage su LEFT JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE ds.section_id IS NULL;

SELECT 'SOURCE_NUMBERING' AS audit_block;
SELECT citation_number,source_key,title
FROM sources
WHERE citation_number BETWEEN 58 AND 69
ORDER BY citation_number;

SELECT 'SOURCE_DUPLICATES' AS audit_block;
SELECT citation_number,COUNT(*) AS duplicate_count
FROM sources
GROUP BY citation_number
HAVING COUNT(*)>1;

SELECT 'COUNTERS' AS audit_block;
SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision')
ORDER BY counter_key;

SELECT 'EXPECTED_FINAL_STATE' AS audit_block;
SELECT
  (SELECT counter_value FROM repository_counters WHERE counter_key='last_edited_section')='3.2.6' AS last_section_ok,
  (SELECT counter_value FROM repository_counters WHERE counter_key='next_citation_number')='70' AS citation_counter_ok,
  (SELECT counter_value FROM repository_counters WHERE counter_key='next_equation_number')='3.159' AS equation_counter_ok,
  NOT EXISTS(SELECT 1 FROM equations GROUP BY equation_number HAVING COUNT(*)>1) AS equations_unique,
  NOT EXISTS(SELECT 1 FROM equation_symbols GROUP BY equation_id,symbol_latex HAVING COUNT(*)>1) AS equation_symbols_unique;
