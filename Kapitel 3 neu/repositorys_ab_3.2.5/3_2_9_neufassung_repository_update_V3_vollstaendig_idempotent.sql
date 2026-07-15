USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.2.9 – vollständige Neufassung V3, vollständig idempotent
   Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse
   Neue Quellen [75] Shannon und [76] Wiener
   Gleichungen (3.212)–(3.244) */

SET @parent_revision_id := (SELECT `revision_id` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-15-K3.2.8-NEUFASSUNG-V2' LIMIT 1);
INSERT INTO `repository_revisions` (`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`) VALUES
('RKB-2026-07-15-K3.2.9-NEUFASSUNG-V3',NOW(),'section','3.2.9','3.0','Vollständige Repository-Neufassung von Abschnitt 3.2.9 mit Shannon-Entropie, bedingter Entropie, gegenseitiger Information und Divergenzmaßen.','Olaf Thiele / ChatGPT',@parent_revision_id)
ON DUPLICATE KEY UPDATE `revision_id`=LAST_INSERT_ID(`revision_id`),`revision_date`=VALUES(`revision_date`),`summary`=VALUES(`summary`),`parent_revision_id`=VALUES(`parent_revision_id`);
SET @revision_id:=LAST_INSERT_ID();
SET @section_id:=(SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.9' LIMIT 1);
UPDATE `dissertation_sections` SET `title`='Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse',`status`='review',`is_original_contribution`=0,`notes`='Vollständige Neufassung V3 mit Quellen [75]–[76] und Gleichungen (3.212)–(3.244).',`updated_at`=NOW() WHERE `section_id`=@section_id;

/* Abschnittsartefakte kontrolliert bereinigen. */
DELETE es FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';
DELETE FROM `section_change_log` WHERE `section_id`=@section_id AND `revision_id`=@revision_id;

/* Eventuelle frühere Belegung der Literaturziffern [75]–[76] entfernen. */
SET @old_source_75:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=75 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id`=@old_source_75;
DELETE FROM `annotations` WHERE `source_id`=@old_source_75;
DELETE FROM `source_topics` WHERE `source_id`=@old_source_75;
DELETE FROM `source_relations` WHERE `source_id_from`=@old_source_75 OR `source_id_to`=@old_source_75;
DELETE FROM `source_authors` WHERE `source_id`=@old_source_75;
DELETE FROM `sources` WHERE `source_id`=@old_source_75;
SET @old_source_76:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=76 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id`=@old_source_76;
DELETE FROM `annotations` WHERE `source_id`=@old_source_76;
DELETE FROM `source_topics` WHERE `source_id`=@old_source_76;
DELETE FROM `source_relations` WHERE `source_id_from`=@old_source_76 OR `source_id_to`=@old_source_76;
DELETE FROM `source_authors` WHERE `source_id`=@old_source_76;
DELETE FROM `sources` WHERE `source_id`=@old_source_76;

/* Autoren. */
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Shannon','Claude E.','Shannon, Claude E.',1916,2001,'Begründer der mathematischen Informationstheorie.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_shannon:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Shannon, Claude E.' LIMIT 1);
INSERT INTO `authors` (`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`) VALUES ('Wiener','Norbert','Wiener, Norbert',1894,1964,'Begründer der Kybernetik und der informationsbezogenen Rückkopplungstheorie.') ON DUPLICATE KEY UPDATE `author_id`=LAST_INSERT_ID(`author_id`),`notes`=VALUES(`notes`);
SET @author_wiener:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Wiener, Norbert' LIMIT 1);

/* Quellen [75] und [76]. */
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES
(75,'shannon_mathematical_theory_communication_1948','journal_article','A Mathematical Theory of Communication',1948,1948,'Bell System Technical Journal',NULL,NULL,'27',NULL,'379–423; 623–656','en',5,'primary',5,'verified','3.2.9','Erstnennung zur mathematischen Definition von Information und Entropie.','Shannon, Claude E.: A Mathematical Theory of Communication. Bell System Technical Journal, Bd. 27, 1948, S. 379–423 und 623–656.','Shannon [75]','Primärquelle der mathematischen Informationstheorie.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_75_id:=LAST_INSERT_ID();
INSERT INTO `sources` (`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`publisher`,`place`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`) VALUES
(76,'wiener_cybernetics_1948','book','Cybernetics or Control and Communication in the Animal and the Machine',1948,1948,'Hermann / MIT Press','Paris / Cambridge, Massachusetts','en',5,'primary',5,'verified','3.2.9','Erstnennung zur funktionalen Bedeutung von Information in Rückkopplungs- und Regelungssystemen.','Wiener, Norbert: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann; Cambridge, Massachusetts: MIT Press, 1948.','Wiener [76]','Grundlagenwerk der Kybernetik.',@revision_id)
ON DUPLICATE KEY UPDATE `source_id`=LAST_INSERT_ID(`source_id`),`source_key`=VALUES(`source_key`),`title`=VALUES(`title`),`full_citation_text`=VALUES(`full_citation_text`),`verification_status`=VALUES(`verification_status`),`created_revision_id`=VALUES(`created_revision_id`);
SET @source_76_id:=LAST_INSERT_ID();
INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`) VALUES (@source_75_id,@author_shannon,1,'author'),(@source_76_id,@author_wiener,1,'author') ON DUPLICATE KEY UPDATE `author_order`=VALUES(`author_order`),`role`=VALUES(`role`);

/* Annotationen. */
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES
(@source_75_id,'Mathematische Quantifizierung von Selbstinformation, Entropie, bedingter Entropie und Informationsübertragung.','Zentrale Primärquelle für sämtliche informationstheoretischen Definitionen in Abschnitt 3.2.9.','Belegt die probabilistische Definition von Information unabhängig von Semantik.','Information wird als Verringerung probabilistischer Unbestimmtheit quantifiziert.','Die semantische Bedeutung von Nachrichten wird bewusst ausgeklammert.','Diese Begrenzung ist für die spätere FRZK-Forschungslücke ausdrücklich relevant.','reviewed',NOW())
ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`adopted_claims`=VALUES(`adopted_claims`),`limitations`=VALUES(`limitations`),`scientific_discussion`=VALUES(`scientific_discussion`),`annotation_status`='reviewed',`reviewed_at`=NOW();
INSERT INTO `annotations` (`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,`scientific_discussion`,`annotation_status`,`reviewed_at`) VALUES
(@source_76_id,'Verknüpfung von Information, Kommunikation, Steuerung und Rückkopplung.','Erweitert die rein probabilistische Perspektive um die funktionale Rolle von Information in dynamischen Systemen.','Belegt die Bedeutung von Information innerhalb regulierter Prozesse.','Information ist für Steuerung und Rückkopplung funktional wirksam.','Keine allgemeine mathematische Genese semantischer oder funktionaler Raum-Zeit-Strukturen.','Wieners funktionale Perspektive ergänzt Shannons quantitative Theorie.','reviewed',NOW())
ON DUPLICATE KEY UPDATE `contribution`=VALUES(`contribution`),`significance_for_dissertation`=VALUES(`significance_for_dissertation`),`citation_reason`=VALUES(`citation_reason`),`adopted_claims`=VALUES(`adopted_claims`),`limitations`=VALUES(`limitations`),`scientific_discussion`=VALUES(`scientific_discussion`),`annotation_status`='reviewed',`reviewed_at`=NOW();

INSERT INTO `source_usage` (`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`) VALUES
(@source_75_id,@section_id,'first_citation','Begründung der mathematischen Informationstheorie sowie der Shannon-Entropie.','Einleitung und Selbstinformation',1,1,'Neue Erstnennung [75].',@revision_id),
(@source_75_id,@section_id,'definition','Definitionen von Entropie, bedingter Entropie, Mutual Information und Divergenzmaßen.','Gesamter mathematischer Formalismus 3.2.9',0,1,'Primärquelle und etablierte Weiterentwicklung.',@revision_id),
(@source_76_id,@section_id,'first_citation','Funktionale Bedeutung von Information in Kommunikation, Steuerung und Rückkopplung.','Einleitender Forschungsstand',1,1,'Neue Erstnennung [76].',@revision_id),
(@source_76_id,@section_id,'comparison','Vergleich der quantitativen Shannon-Perspektive mit der funktionalen kybernetischen Perspektive.','Wissenschaftliche Einordnung',0,1,'Ergänzende Primärquelle.',@revision_id);

/* Definitionen. */
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.1',@section_id,'Diskrete Zufallsvariable','Eine diskrete Zufallsvariable ordnet elementaren Ergebnissen Werte aus einem endlichen oder abzählbaren Alphabet zu.','X:\\Omega\\to\\mathcal X','X:\\Omega\\to\\mathcal X','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.2',@section_id,'Selbstinformation','Die Selbstinformation eines Ereignisses ist der negative Logarithmus seiner Wahrscheinlichkeit.','I(x_i)=-\\log_b p_i','I(x_i)=-\\log_b p_i','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.3',@section_id,'Shannon-Entropie','Die Shannon-Entropie ist der Erwartungswert der Selbstinformation einer Zufallsvariablen.','H(X)=-\\sum_i p_i\\log_b p_i','H(X)=-\\sum_i p_i\\log_b p_i','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.4',@section_id,'Gemeinsame Entropie','Die gemeinsame Entropie quantifiziert die gesamte Unbestimmtheit zweier Zufallsvariablen.','H(X,Y)=-\\sum_i\\sum_jp(x_i,y_j)\\log p(x_i,y_j)','H(X,Y)=-\\sum_i\\sum_jp(x_i,y_j)\\log p(x_i,y_j)','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.5',@section_id,'Bedingte Entropie','Die bedingte Entropie misst die verbleibende Unsicherheit einer Variablen bei Kenntnis einer anderen.','H(X|Y)','H(X|Y)','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.6',@section_id,'Gegenseitige Information','Die gegenseitige Information misst die Reduktion der Unsicherheit einer Variablen durch Kenntnis einer anderen.','I(X;Y)=H(X)-H(X|Y)','I(X;Y)=H(X)-H(X|Y)','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.7',@section_id,'Kullback-Leibler-Divergenz','Die Kullback-Leibler-Divergenz quantifiziert den gerichteten Informationsverlust bei Approximation einer Verteilung P durch Q.','D_{KL}(P||Q)=\\sum_iP(x_i)\\log\\frac{P(x_i)}{Q(x_i)}','D_{KL}(P||Q)=\\sum_iP(x_i)\\log\\frac{P(x_i)}{Q(x_i)}','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.8',@section_id,'Jensen-Shannon-Divergenz','Die Jensen-Shannon-Divergenz ist eine symmetrische Divergenz auf Grundlage zweier Kullback-Leibler-Divergenzen zur Mischverteilung.','D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)','D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.9',@section_id,'Informationsabhängigkeit','Informationsabhängigkeit liegt vor, wenn die gegenseitige Information zweier Variablen positiv ist.','I(X;Y)>0','I(X;Y)>0','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.9.10',@section_id,'Informationsunabhängigkeit','Zwei Zufallsvariablen sind informationsunabhängig, wenn ihre gegenseitige Information verschwindet.','I(X;Y)=0','I(X;Y)=0','literature',@source_75_id,NULL,'Vollständige Neufassung 3.2.9 V3.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`definition_text`=VALUES(`definition_text`),`formal_latex`=VALUES(`formal_latex`),`word_latex`=VALUES(`word_latex`),`source_id`=VALUES(`source_id`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);

/* Gleichungen (3.212)–(3.244). */
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.212',@section_id,'Alphabet der Zufallsvariablen','\\mathcal{X}=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}','\\mathcal{X}=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}','Menge möglicher Werte einer diskreten Zufallsvariablen.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_212:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.213',@section_id,'Ereigniswahrscheinlichkeit','p_i=P(X=x_i)','p_i=P(X=x_i)','Wahrscheinlichkeit des Ereignisses X=x_i.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_213:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.214',@section_id,'Nichtnegativität der Wahrscheinlichkeiten','p_i\\geq0\\qquad\\forall i','p_i\\geq0\\qquad\\forall i','Nichtnegativitätsbedingung diskreter Wahrscheinlichkeiten.','axiom','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_214:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.215',@section_id,'Normierung der Wahrscheinlichkeitsverteilung','\\sum_{i=1}^{n}p_i=1','\\sum_{i=1}^{n}p_i=1','Normierungsbedingung einer diskreten Wahrscheinlichkeitsverteilung.','axiom','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_215:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.216',@section_id,'Selbstinformation','I(x_i)=-\\log_b p_i','I(x_i)=-\\log_b p_i','Informationsgehalt eines Ereignisses mit Wahrscheinlichkeit p_i.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_216:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.217',@section_id,'Bit als Informationseinheit','b=2','b=2','Logarithmusbasis zwei definiert die Einheit Bit.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_217:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.218',@section_id,'Information eines sicheren Ereignisses','P(X=x_i)=1\\Longrightarrow I(x_i)=0','P(X=x_i)=1\\Longrightarrow I(x_i)=0','Ein sicheres Ereignis liefert keinen zusätzlichen Informationsgewinn.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_218:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.219',@section_id,'Monotonie der Selbstinformation','p_i<p_j\\Longrightarrow I(x_i)>I(x_j)','p_i<p_j\\Longrightarrow I(x_i)>I(x_j)','Seltenere Ereignisse besitzen einen höheren Selbstinformationswert.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_219:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.220',@section_id,'Unabhängigkeit zweier Ereignisse','P(x_i,y_j)=P(x_i)P(y_j)','P(x_i,y_j)=P(x_i)P(y_j)','Faktorisierung der gemeinsamen Wahrscheinlichkeit unabhängiger Ereignisse.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_220:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.221',@section_id,'Additivität unabhängiger Informationen','I(x_i,y_j)=I(x_i)+I(y_j)','I(x_i,y_j)=I(x_i)+I(y_j)','Informationsgehalte unabhängiger Ereignisse addieren sich.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_221:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.222',@section_id,'Entropie als Erwartungswert','H(X)=\\mathbb{E}\\left[I(X)\\right]','H(X)=\\mathbb{E}\\left[I(X)\\right]','Shannon-Entropie als Erwartungswert der Selbstinformation.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_222:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.223',@section_id,'Diskrete Shannon-Entropie','H(X)=-\\sum_{i=1}^{n}p_i\\log_b p_i','H(X)=-\\sum_{i=1}^{n}p_i\\log_b p_i','Mittlere Unbestimmtheit einer diskreten Zufallsvariablen.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_223:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.224',@section_id,'Entropie eines sicheren Ereignisses','H(X)=0','H(X)=0','Eine deterministische Zufallsvariable besitzt keine Shannon-Entropie.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_224:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.225',@section_id,'Gleichverteilung','p_i=\\frac{1}{n}\\qquad\\forall i','p_i=\\frac{1}{n}\\qquad\\forall i','Gleichverteilung über n mögliche Zustände.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_225:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.226',@section_id,'Maximale Entropie der Gleichverteilung','H(X)=\\log_b n','H(X)=\\log_b n','Maximale Entropie einer diskreten Zufallsvariablen mit n Zuständen.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_226:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.227',@section_id,'Gemeinsame Wahrscheinlichkeitsverteilung','p(x_i,y_j)=P(X=x_i,Y=y_j)','p(x_i,y_j)=P(X=x_i,Y=y_j)','Gemeinsame Wahrscheinlichkeit zweier diskreter Zufallsvariablen.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_227:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.228',@section_id,'Randverteilung von X','p(x_i)=\\sum_j p(x_i,y_j)','p(x_i)=\\sum_j p(x_i,y_j)','Marginalisierung der gemeinsamen Verteilung über Y.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_228:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.229',@section_id,'Randverteilung von Y','p(y_j)=\\sum_i p(x_i,y_j)','p(y_j)=\\sum_i p(x_i,y_j)','Marginalisierung der gemeinsamen Verteilung über X.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_229:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.230',@section_id,'Gemeinsame Entropie','H(X,Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i,y_j)','H(X,Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i,y_j)','Gemeinsame Unbestimmtheit zweier Zufallsvariablen.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_230:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.231',@section_id,'Additivität der Entropie bei Unabhängigkeit','H(X,Y)=H(X)+H(Y)','H(X,Y)=H(X)+H(Y)','Gemeinsame Entropie unabhängiger Zufallsvariablen.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_231:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.232',@section_id,'Bedingte Entropie','H(X|Y)','H(X|Y)','Verbleibende Unsicherheit von X bei Kenntnis von Y.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_232:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.233',@section_id,'Formel der bedingten Entropie','H(X|Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i|y_j)','H(X|Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i|y_j)','Erwartete bedingte Selbstinformation.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_233:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.234',@section_id,'Kettenregel der Entropie I','H(X,Y)=H(Y)+H(X|Y)','H(X,Y)=H(Y)+H(X|Y)','Zerlegung der gemeinsamen Entropie.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_234:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.235',@section_id,'Kettenregel der Entropie II','H(X,Y)=H(X)+H(Y|X)','H(X,Y)=H(X)+H(Y|X)','Symmetrische Zerlegung der gemeinsamen Entropie.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_235:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.236',@section_id,'Gegenseitige Information','I(X;Y)=H(X)-H(X|Y)','I(X;Y)=H(X)-H(X|Y)','Reduktion der Unsicherheit über X durch Kenntnis von Y.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_236:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.237',@section_id,'Symmetrische Darstellung der gegenseitigen Information','I(X;Y)=H(X)+H(Y)-H(X,Y)','I(X;Y)=H(X)+H(Y)-H(X,Y)','Darstellung durch Einzel- und gemeinsame Entropie.','derived','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_237:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.238',@section_id,'Symmetrie der gegenseitigen Information','I(X;Y)=I(Y;X)','I(X;Y)=I(Y;X)','Mutual Information ist symmetrisch.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_238:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.239',@section_id,'Kullback-Leibler-Divergenz','D_{KL}(P||Q)=\\sum_i P(x_i)\\log\\frac{P(x_i)}{Q(x_i)}','D_{KL}(P||Q)=\\sum_i P(x_i)\\log\\frac{P(x_i)}{Q(x_i)}','Gerichtetes Divergenzmaß zwischen zwei Wahrscheinlichkeitsverteilungen.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_239:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.240',@section_id,'Nichtnegativität der Kullback-Leibler-Divergenz','D_{KL}(P||Q)\\geq0','D_{KL}(P||Q)\\geq0','Gibbs-Ungleichung.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_240:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.241',@section_id,'Nullbedingung der Kullback-Leibler-Divergenz','D_{KL}(P||Q)=0\\Longleftrightarrow P=Q','D_{KL}(P||Q)=0\\Longleftrightarrow P=Q','Die Divergenz verschwindet genau bei identischen Verteilungen.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_241:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.242',@section_id,'Mischverteilung','M=\\frac12(P+Q)','M=\\frac12(P+Q)','Mittlere Verteilung für die Jensen-Shannon-Divergenz.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_242:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.243',@section_id,'Jensen-Shannon-Divergenz','D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)','D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)','Symmetrisierte und geglättete Divergenz zwischen P und Q.','definition','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_243:=LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.244',@section_id,'Symmetrie der Jensen-Shannon-Divergenz','D_{JS}(P,Q)=D_{JS}(Q,P)','D_{JS}(P,Q)=D_{JS}(Q,P)','Die Jensen-Shannon-Divergenz ist symmetrisch.','theorem','literature',@source_75_id,NULL,NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE `equation_id`=LAST_INSERT_ID(`equation_id`),`section_id`=VALUES(`section_id`),`title`=VALUES(`title`),`equation_latex`=VALUES(`equation_latex`),`word_latex`=VALUES(`word_latex`),`plain_description`=VALUES(`plain_description`),`equation_type`=VALUES(`equation_type`),`source_id`=VALUES(`source_id`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
SET @eq_3_244:=LAST_INSERT_ID();

/* Gleichungssymbole – idempotent. */
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_212,'\\mathcal X','Alphabet','Menge möglicher Werte der Zufallsvariablen.',NULL,'\\{x_1,\\ldots,x_n\\}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_213,'p_i','Ereigniswahrscheinlichkeit','Wahrscheinlichkeit des Ereignisses X=x_i.',NULL,'[0,1]',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_216,'I','Selbstinformation','Informationsgehalt eines Ereignisses.',NULL,'\\mathbb R_{\\ge0}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_216,'b','Logarithmusbasis','Basis des Informationsmaßes.',NULL,'\\mathbb R_{>1}',2)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_223,'H','Shannon-Entropie','Mittlere Unbestimmtheit einer Zufallsvariablen.',NULL,'\\mathbb R_{\\ge0}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_227,'p(x_i,y_j)','gemeinsame Wahrscheinlichkeit','Gemeinsame Wahrscheinlichkeit zweier Ereignisse.',NULL,'[0,1]',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_232,'H(X|Y)','bedingte Entropie','Verbleibende Unsicherheit von X bei Kenntnis von Y.',NULL,'\\mathbb R_{\\ge0}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_236,'I(X;Y)','gegenseitige Information','Statistische Informationsabhängigkeit zwischen X und Y.',NULL,'\\mathbb R_{\\ge0}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_239,'D_{KL}','Kullback-Leibler-Divergenz','Gerichtetes Divergenzmaß zweier Verteilungen.',NULL,'\\mathbb R_{\\ge0}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_242,'M','Mischverteilung','Arithmetisches Mittel der Verteilungen P und Q.',NULL,NULL,1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_243,'D_{JS}','Jensen-Shannon-Divergenz','Symmetrisches Divergenzmaß.',NULL,'\\mathbb R_{\\ge0}',1)
ON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);

/* Abschnittssymbole. */
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('\\mathcal X','\\mathcal X','Alphabet','Menge möglicher Werte einer diskreten Zufallsvariablen.','section',@section_id,@eq_3_212,NULL,'\\{x_1,\\ldots,x_n\\}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('p_i','p_i','Ereigniswahrscheinlichkeit','Wahrscheinlichkeit des i-ten Ereignisses.','section',@section_id,@eq_3_213,NULL,'[0,1]',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('I','I','Selbstinformation','Informationsgehalt eines Einzelereignisses.','section',@section_id,@eq_3_216,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('H','H','Shannon-Entropie','Mittlere probabilistische Unbestimmtheit.','section',@section_id,@eq_3_223,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('H(X|Y)','H(X|Y)','bedingte Entropie','Verbleibende Unsicherheit von X bei Kenntnis von Y.','section',@section_id,@eq_3_232,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('I(X;Y)','I(X;Y)','gegenseitige Information','Informationsabhängigkeit zwischen X und Y.','section',@section_id,@eq_3_236,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('D_{KL}','D_{KL}','Kullback-Leibler-Divergenz','Gerichteter Vergleich zweier Wahrscheinlichkeitsverteilungen.','section',@section_id,@eq_3_239,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);
INSERT INTO `symbols` (`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,`unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`) VALUES
('D_{JS}','D_{JS}','Jensen-Shannon-Divergenz','Symmetrischer Vergleich zweier Wahrscheinlichkeitsverteilungen.','section',@section_id,@eq_3_243,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.9.','checked',@revision_id)
ON DUPLICATE KEY UPDATE `symbol_word_latex`=VALUES(`symbol_word_latex`),`symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`first_section_id`=VALUES(`first_section_id`),`first_equation_id`=VALUES(`first_equation_id`),`domain_text`=VALUES(`domain_text`),`codomain_text`=VALUES(`codomain_text`),`notes`=VALUES(`notes`),`validation_status`='checked',`created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `section_change_log` (`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`) VALUES
(@revision_id,@section_id,'rewritten','section','3.2.9','Abschnitt 3.2.9 vollständig neu gefasst.',NULL,'Informationstheorie mit Entropie, Mutual Information und Divergenzen.'),
(@revision_id,@section_id,'source_added','sources','[75]–[76]','Zwei Primärquellen registriert.',NULL,'Shannon [75], Wiener [76].'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.2.9.1–Def. 3.2.9.10','Zehn Definitionen registriert.',NULL,'Zufallsvariable bis Informationsunabhängigkeit.'),
(@revision_id,@section_id,'equation_added','equations','(3.212)–(3.244)','33 Gleichungen registriert.',NULL,'Vollständiger mathematischer Formalismus des Abschnitts.');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`) VALUES
('next_citation_number','77'),('next_equation_number','3.245'),('last_edited_section','3.2.9'),('last_repository_revision','RKB-2026-07-15-K3.2.9-NEUFASSUNG-V3')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);
COMMIT;

/* Abschlussaudit. */
SELECT `revision_id`,`revision_code`,`parent_revision_id`,`scope_reference`,`version_label` FROM `repository_revisions` WHERE `revision_code`='RKB-2026-07-15-K3.2.9-NEUFASSUNG-V3';
SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes` FROM `dissertation_sections` WHERE `section_code`='3.2.9';
SELECT `citation_number`,`source_key`,`title`,`verification_status` FROM `sources` WHERE `citation_number` IN (75,76) ORDER BY `citation_number`;
SELECT COUNT(*) AS `source_usage_count`,SUM(`is_first_mention`) AS `first_mentions`,SUM(`citation_checked`) AS `checked_usages` FROM `source_usage` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `definition_count` FROM `definitions` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `equation_count` FROM `equations` WHERE `section_id`=@section_id;
SELECT MIN(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `first_equation`,MAX(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `last_equation` FROM `equations` WHERE `section_id`=@section_id;
SELECT COUNT(*) AS `equation_symbol_count` FROM `equation_symbols` es JOIN `equations` e ON e.`equation_id`=es.`equation_id` WHERE e.`section_id`=@section_id;
SELECT COUNT(*) AS `duplicate_equation_numbers` FROM (SELECT `equation_number` FROM `equations` GROUP BY `equation_number` HAVING COUNT(*)>1) d;
SELECT COUNT(*) AS `duplicate_equation_symbols` FROM (SELECT `equation_id`,`symbol_latex` FROM `equation_symbols` GROUP BY `equation_id`,`symbol_latex` HAVING COUNT(*)>1) d;
SELECT COUNT(*) AS `missing_word_latex` FROM `equations` WHERE `section_id`=@section_id AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');
SELECT `counter_key`,`counter_value` FROM `repository_counters` WHERE `counter_key` IN ('next_citation_number','next_equation_number','last_edited_section','last_repository_revision') ORDER BY `counter_key`;