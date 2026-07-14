USE `frzk_rkb`;

SET NAMES utf8mb4;



START TRANSACTION;

/* ============================================================
   VORGESCHALTETE BEREINIGUNG

   Ausgangsdatenbank:
   frzk_rkb_backup.sql (enthält bereits 3.2.2 und 3.2.3 sowie
   ältere Sammelimporte für nachfolgende Abschnitte von Kapitel 3.2)

   Zielzustand vor Einspielung dieser Revision:
   - Kapitel 3.1 vollständig erhalten
   - 3.2.0 vollständig erhalten
   - bisherige Revision 3.2.1 als Parent erhalten
   - sämtliche inhaltlichen Artefakte der Abschnitte 3.2.2 ff. entfernt
   - Revisionsdatensätze 3.2.2 und 3.2.3 entfernt
   - Abschnittsgerüste 3.2.2 ff. bleiben bestehen, werden aber auf planned gesetzt
   - ausschließlich die neue Fassung von 3.2.1 wird anschließend eingespielt
   ============================================================ */

DROP TEMPORARY TABLE IF EXISTS `tmp_reset_sections_321`;
CREATE TEMPORARY TABLE `tmp_reset_sections_321` (
  `section_id` BIGINT UNSIGNED PRIMARY KEY
) ENGINE=MEMORY;

INSERT INTO `tmp_reset_sections_321` (`section_id`)
SELECT `section_id`
FROM `dissertation_sections`
WHERE `section_code` LIKE '3.2.%'
  AND `section_code` NOT IN ('3.2.0','3.2.1');

/* abhängige Gleichungsobjekte zuerst entfernen */
DELETE es
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
JOIN `tmp_reset_sections_321` t ON t.`section_id`=e.`section_id`;

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
JOIN `tmp_reset_sections_321` t ON t.`section_id`=e.`section_id`;

DELETE ed
FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
JOIN `tmp_reset_sections_321` t ON t.`section_id`=e.`section_id`;

/* generische Objektverknüpfungen zu den zurückzusetzenden Abschnitten */
DELETE osl
FROM `object_source_links` osl
WHERE (`osl`.`object_type`='equation' AND `osl`.`object_id` IN (
         SELECT e.`equation_id` FROM `equations` e
         JOIN `tmp_reset_sections_321` t ON t.`section_id`=e.`section_id`
       ))
   OR (`osl`.`object_type`='definition' AND `osl`.`object_id` IN (
         SELECT d.`definition_id` FROM `definitions` d
         JOIN `tmp_reset_sections_321` t ON t.`section_id`=d.`section_id`
       ));

DELETE od
FROM `object_dependencies` od
WHERE (`od`.`object_type_from`='equation' AND `od`.`object_id_from` IN (
         SELECT e.`equation_id` FROM `equations` e
         JOIN `tmp_reset_sections_321` t ON t.`section_id`=e.`section_id`
       ))
   OR (`od`.`object_type_to`='equation' AND `od`.`object_id_to` IN (
         SELECT e.`equation_id` FROM `equations` e
         JOIN `tmp_reset_sections_321` t ON t.`section_id`=e.`section_id`
       ));

/* Aussageabhängigkeiten vor den Aussageobjekten entfernen */
DELETE pd
FROM `proposition_dependencies` pd
JOIN `propositions` p ON p.`proposition_id`=pd.`proposition_id`
JOIN `tmp_reset_sections_321` t ON t.`section_id`=p.`section_id`;

DELETE ad
FROM `axiom_dependencies` ad
JOIN `axioms` a ON a.`axiom_id`=ad.`axiom_id`
JOIN `tmp_reset_sections_321` t ON t.`section_id`=a.`section_id`;

/* fachliche Artefakte der späteren 3.2-Abschnitte entfernen */
DELETE FROM `proofs` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `corollaries` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `lemmas` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `theorems` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `propositions` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `axioms` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `assumptions` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `figures` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `dissertation_tables` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `definitions` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `equations` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `source_usage` WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);
DELETE FROM `symbols` WHERE `first_section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);

/* Änderungsprotokolle der zurückzusetzenden Abschnitte entfernen */
DELETE FROM `section_change_log`
WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`)
   OR `revision_id` IN (
       SELECT `revision_id` FROM `repository_revisions`
       WHERE `revision_code` IN (
         'RKB-2026-07-12-K3.2.2-NEUFASSUNG-V1',
         'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V1'
       )
   );

/* Nur Quellen entfernen, die durch die späteren Einzelrevisionen neu entstanden sind.
   Der ältere Literaturkatalog [25]–[57] bleibt als zentraler Quellenbestand erhalten. */
SET @src59 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=59 AND `created_revision_id` IN (22,23) LIMIT 1);
SET @src60 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=60 AND `created_revision_id` IN (22,23) LIMIT 1);
SET @src61 := (SELECT `source_id` FROM `sources` WHERE `citation_number`=61 AND `created_revision_id` IN (22,23) LIMIT 1);

DELETE FROM `source_usage` WHERE `source_id` IN (@src59,@src60,@src61);
DELETE FROM `annotations` WHERE `source_id` IN (@src59,@src60,@src61);
DELETE FROM `source_topics` WHERE `source_id` IN (@src59,@src60,@src61);
DELETE FROM `source_relations` WHERE `source_id_from` IN (@src59,@src60,@src61) OR `source_id_to` IN (@src59,@src60,@src61);
DELETE FROM `source_authors` WHERE `source_id` IN (@src59,@src60,@src61);
DELETE FROM `sources` WHERE `source_id` IN (@src59,@src60,@src61);

/* revisionsbezogene Validierungsdaten und Revisionen nach 3.2.1 entfernen */
DELETE FROM `repository_validation_results`
WHERE `revision_id` IN (
  SELECT `revision_id` FROM `repository_revisions`
  WHERE `revision_code` IN (
    'RKB-2026-07-12-K3.2.2-NEUFASSUNG-V1',
    'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V1'
  )
);

DELETE FROM `repository_revisions`
WHERE `revision_code` IN (
  'RKB-2026-07-12-K3.2.2-NEUFASSUNG-V1',
  'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V1'
);

/* Abschnittsgerüste erhalten, inhaltlich jedoch als noch nicht bearbeitet markieren */
UPDATE `dissertation_sections`
SET `status`='planned',
    `notes`=NULL
WHERE `section_id` IN (SELECT `section_id` FROM `tmp_reset_sections_321`);

/* Zähler auf den Stand vor der neuen 3.2.1-V2-Revision zurückstellen */
INSERT INTO `repository_counters` (`counter_key`,`counter_value`,`updated_at`)
VALUES
('last_edited_section','3.2.0',NOW()),
('last_repository_revision','RKB-2026-07-12-K3.2.0-NEUFASSUNG-V1',NOW()),
('next_citation_number','58',NOW()),
('next_equation_number','3.3',NOW())
ON DUPLICATE KEY UPDATE
`counter_value`=VALUES(`counter_value`),
`updated_at`=VALUES(`updated_at`);





/* ============================================================
   Abschnitt 3.2.1 – Mengen als Grundlage mathematischer Modellbildung
   Vollständiges Revisionsskript V2

   Ausgangspunkt: frzk_rkb_backup.sql; automatische Rücksetzung auf den Arbeitsstand bis einschließlich 3.2.1
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
 (SELECT r.`revision_id` FROM `repository_revisions` r WHERE r.`revision_code`='RKB-2026-07-12-K3.2.1-NEUFASSUNG-V1' LIMIT 1))
ON DUPLICATE KEY UPDATE
 `revision_id`=LAST_INSERT_ID(`revision_id`),
 `revision_date`=VALUES(`revision_date`),
 `summary`=VALUES(`summary`),
 `created_by`=VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

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
(58,'fraenkel_bar_hillel_levy_foundations_set_theory_1973','book','Foundations of Set Theory',NULL,1958,1973,NULL,'North-Holland','Amsterdam',NULL,NULL,NULL,'Second Revised Edition',NULL,NULL,NULL,'en',5,'reference',4,'partially_verified','3.2.1',
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
(@source_58,@author_levy,3,'author');

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
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.2',@section_id,'Elementzugehörigkeit','Die Aussage x∈M bezeichnet die Zugehörigkeit des Objekts x zur Menge M.','x\\in M','x\\in M','literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.3',@section_id,'Leere Menge','Die leere Menge ist die eindeutig bestimmte Menge, die kein Element enthält.','\\emptyset','\\emptyset','literature',@source_24,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.4',@section_id,'Teilmenge','A ist Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','literature',@source_24,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.5',@section_id,'Kartesisches Produkt','Das kartesische Produkt A×B ist die Menge aller geordneten Paare (a,b) mit a∈A und b∈B.','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES ('Def. 3.2.1.6',@section_id,'Potenzmenge','Die Potenzmenge P(A) ist die Menge aller Teilmengen von A.','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','literature',@source_23,
'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.',
'Definition für den Forschungsstandsabschnitt 3.2.1.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.3',@section_id,'Elementzugehörigkeit','x\\in M','x\\in M','Das Objekt x ist Element der Menge M.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.4',@section_id,'Nichtzugehörigkeit','x\\notin M','x\\notin M','Das Objekt x ist kein Element der Menge M.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.5',@section_id,'Leere Menge','\\emptyset','\\emptyset','Bezeichnung der eindeutig bestimmten Menge ohne Elemente.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.6',@section_id,'Extensionalitätsaxiom','A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)','A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)','Zwei Mengen sind genau dann identisch, wenn sie dieselben Elemente besitzen.','axiom','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.7',@section_id,'Teilmengenrelation','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)','A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.8',@section_id,'Aussonderungsmenge','A_P=\\left\\{x\\in A\\mid P(x)\\right\\}','A_P=\\left\\{x\\in A\\mid P(x)\\right\\}','Teilmenge von A, deren Elemente die Eigenschaft P erfüllen.','definition','literature',@source_58,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.9',@section_id,'Vereinigung','A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}','A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}','Vereinigung der Mengen A und B.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.10',@section_id,'Durchschnitt','A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}','A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}','Durchschnitt der Mengen A und B.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.11',@section_id,'Differenzmenge','A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}','A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}','Differenzmenge von A bezüglich B.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.12',@section_id,'Komplement','A^{c}=U\\setminus A','A^{c}=U\\setminus A','Komplement von A relativ zur Grundmenge U.','definition','literature',@source_24,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.13',@section_id,'Kartesisches Produkt','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}','Menge aller geordneten Paare aus A und B.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.14',@section_id,'Potenzmenge','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}','Menge aller Teilmengen von A.','definition','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.15',@section_id,'Satz von Cantor','|\\mathcal P(A)|>|A|','|\\mathcal P(A)|>|A|','Die Potenzmenge besitzt eine strikt größere Mächtigkeit als ihre Ausgangsmenge.','theorem','literature',@source_23,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`)
VALUES ('3.16',@section_id,'Schema mengenbildender Operationen','\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)','\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)','Schematische Darstellung einer Operation auf Teilmengen einer Grundmenge.','schema','adapted',@source_58,NULL,
'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.','checked',@revision_id);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.3' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges mathematisches Objekt.',NULL,'Objekt',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'M','Menge','Menge, deren Elementzugehörigkeit geprüft wird.',NULL,'Menge',2);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.4' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges mathematisches Objekt.',NULL,'Objekt',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'M','Menge','Menge, zu der x nicht gehört.',NULL,'Menge',2);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.5' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\emptyset','Leere Menge','Eindeutig bestimmte Menge ohne Elemente.',NULL,'Menge',1);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.6' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Vergleichsmenge.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Vergleichsmenge.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges Prüfelement.',NULL,'Objekt',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.7' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Teilmenge','Mögliche Teilmenge von B.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Obermenge','Menge, die alle Elemente von A enthält.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Beliebiges Element.',NULL,'Objekt',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.8' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A_P','Aussonderungsmenge','Teilmenge der Elemente von A mit Eigenschaft P.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Grundmenge','Bereits vorhandene Menge.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'P(x)','Prädikat','Auswahlbedingung für x.',NULL,'Aussage',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.9' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Vereinigungsmenge.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Vereinigungsmenge.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Element mindestens einer Ausgangsmenge.',NULL,'Objekt',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.10' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Schnittmenge.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Schnittmenge.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Gemeinsames Element beider Mengen.',NULL,'Objekt',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.11' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Ausgangsmenge.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Auszuschließende Menge.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'x','Element','Element von A, das nicht in B liegt.',NULL,'Objekt',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.12' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A^c','Komplement','Komplement von A relativ zu U.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'U','Grundmenge','Bezugsuniversum des Komplements.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Teilmenge','Zu komplementierende Teilmenge.',NULL,'Menge',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.13' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Menge A','Erste Faktormenge.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'B','Menge B','Zweite Faktormenge.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'(a,b)','Geordnetes Paar','Paar mit erster Komponente aus A und zweiter aus B.',NULL,'Geordnetes Paar',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.14' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\mathcal P(A)','Potenzmenge','Menge aller Teilmengen von A.',NULL,'Menge',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'X','Teilmenge','Beliebige Teilmenge von A.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'A','Ausgangsmenge','Menge, deren Potenzmenge gebildet wird.',NULL,'Menge',3);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.15' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'|\\mathcal P(A)|','Mächtigkeit der Potenzmenge','Kardinalität der Potenzmenge von A.',NULL,'Kardinalzahl',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'|A|','Mächtigkeit von A','Kardinalität der Ausgangsmenge A.',NULL,'Kardinalzahl',2);

SET @eq_id := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.16' LIMIT 1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\Omega','Mengenoperation','Allgemeine Operation auf Teilmengen von M.',NULL,'Operator',1);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'\\mathcal P(M)','Potenzmenge','Definitions- und Zielbereich der Operation.',NULL,'Menge',2);

INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES (@eq_id,'M','Grundmenge','Zugrunde liegende Menge.',NULL,'Menge',3);

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
