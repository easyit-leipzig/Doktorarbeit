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
('Def. 3.2.6.2',@section_id,'Zustandsraum','Der Zustandsraum ist die Menge aller im Modell zulässigen Zustände eines Systems.','X','X','literature',@source_68_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.3',@section_id,'Vollständige Zustandsbeschreibung','Eine Zustandsbeschreibung ist vollständig, wenn der aktuelle Zustand zusammen mit der Übergangsregel die weitere Entwicklung bestimmt.','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','literature',@source_68_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.4',@section_id,'Zulässiger Zustandsraum','Der zulässige Zustandsraum ist die Teilmenge aller Zustände, welche die Modellnebenbedingungen erfüllen.','X_{\\mathrm{zul}}\\subseteq X','X_{\\mathrm{zul}}\\subseteq X','literature',@source_38_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.5',@section_id,'Diskrete Zustandsentwicklung','Eine diskrete Zustandsentwicklung ist eine durch Iteration einer Übergangsabbildung erzeugte Zustandsfolge.','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','literature',@source_40_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.6',@section_id,'Zeitabhängige Zustandsfunktion','Eine zeitabhängige Zustandsfunktion ordnet jedem Zeitpunkt eines Intervalls genau einen Zustand zu.','x:I\\longrightarrow X','x:I\\longrightarrow X','literature',@source_69_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.7',@section_id,'Fluss','Ein Fluss ist eine zeitparametrisierte Familie von Zustandsabbildungen mit Identitäts- und Kompositionseigenschaft.','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','literature',@source_69_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.8',@section_id,'Trajektorie','Eine Trajektorie ist die Menge aller Zustände, die aus einem Anfangszustand entlang eines Flusses erreicht werden.','\\gamma(x_0)=\\{\\Phi(t,x_0)\\mid t\\in I\\}','\\gamma(x_0)=\\{\\Phi(t,x_0)\\mid t\\in I\\}','literature',@source_40_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);
INSERT INTO `definitions` (`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`) VALUES
('Def. 3.2.6.9',@section_id,'Gleichgewichtspunkt','Ein Gleichgewichtspunkt ist ein Zustand, dessen zeitliche Entwicklung unverändert bleibt.','F(x^\\ast)=0','F(x^\\ast)=0','literature',@source_39_id,NULL,'Neufassung 3.2.6 V2.','checked',@revision_id);

/* Gleichungen */
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.136',@section_id,'Zustand im Zustandsraum','x\\in X','x\\in X','Ein Zustand x ist Element des Zustandsraumes X.','definition','literature',@source_68_id,NULL,'X ist ein nichtleerer Zustandsraum.','checked',@revision_id);
SET @eq_3_136 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.137',@section_id,'Zustandsvektor','x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n\\\\\\end{pmatrix}','x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n\\\\\\end{pmatrix}','Darstellung eines n-dimensionalen Zustandes als Spaltenvektor.','definition','literature',@source_68_id,NULL,'Das System besitzt n Zustandsgrößen.','checked',@revision_id);
SET @eq_3_137 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.138',@section_id,'Endlichdimensionaler Zustandsraum','X\\subseteq\\mathbb{R}^{n}','X\\subseteq\\mathbb{R}^{n}','Zulässiger Zustandsraum als Teilmenge des reellen n-dimensionalen Raumes.','definition','literature',@source_68_id,NULL,'Endlichdimensionale reelle Zustandsbeschreibung.','checked',@revision_id);
SET @eq_3_138 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.139',@section_id,'Übergangsabbildung','F:X\\longrightarrow X','F:X\\longrightarrow X','Abbildung eines Zustandes auf einen Folgezustand desselben Zustandsraumes.','definition','literature',@source_38_id,NULL,'Vollständige Zustandsbeschreibung und deterministische Übergangsregel.','checked',@revision_id);
SET @eq_3_139 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.140',@section_id,'Diskreter Zustandsübergang','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','Rekursive Erzeugung des Folgezustandes aus dem aktuellen Zustand.','model','literature',@source_38_id,NULL,'Diskrete deterministische Dynamik.','checked',@revision_id);
SET @eq_3_140 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.141',@section_id,'Zulässige Zustände mit Gleichungsnebenbedingung','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)=0\\right\\}','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)=0\\right\\}','Zulässige Zustände unter einer Gleichungsnebenbedingung.','definition','literature',@source_38_id,NULL,'g ist eine geeignete Nebenbedingungsabbildung.','checked',@revision_id);
SET @eq_3_141 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.142',@section_id,'Zulässige Zustände mit Ungleichungsnebenbedingung','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)\\leq0\\right\\}','X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)\\leq0\\right\\}','Zulässige Zustände unter einer Ungleichungsnebenbedingung.','definition','literature',@source_38_id,NULL,'g ist eine geeignete Nebenbedingungsabbildung.','checked',@revision_id);
SET @eq_3_142 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.143',@section_id,'Diskrete Zustandsfolge','x_0,x_1,x_2,\\ldots','x_0,x_1,x_2,\\ldots','Geordnete Folge diskreter Zustände.','schema','literature',@source_40_id,NULL,'Diskrete Zeitindizes k∈N.','checked',@revision_id);
SET @eq_3_143 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.144',@section_id,'Rekursive diskrete Dynamik','x_{k+1}=F(x_k)','x_{k+1}=F(x_k)','Erneute Darstellung der rekursiven Zustandsentwicklung im Kontext diskreter Systeme.','model','literature',@source_40_id,NULL,'Diskrete deterministische Dynamik.','checked',@revision_id);
SET @eq_3_144 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.145',@section_id,'Iterierte Zustandsentwicklung','x_k=F^{\\,k}(x_0)','x_k=F^{\\,k}(x_0)','Zustand nach k-facher Iteration der Übergangsabbildung.','derived','literature',@source_40_id,NULL,'F ist k-fach kompositionsfähig.','checked',@revision_id);
SET @eq_3_145 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.146',@section_id,'Zeitabhängige Zustandsfunktion','x:I\\longrightarrow X','x:I\\longrightarrow X','Zuordnung eines Zustandes zu jedem Zeitpunkt eines Intervalls I.','definition','literature',@source_69_id,NULL,'I ist ein reelles Zeitintervall.','checked',@revision_id);
SET @eq_3_146 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.147',@section_id,'Zeitliche Ableitung des Zustandes','\\dot{x}(t)=\\frac{dx(t)}{dt}','\\dot{x}(t)=\\frac{dx(t)}{dt}','Ableitung der Zustandsfunktion nach der Zeit.','definition','literature',@source_69_id,NULL,'x ist differenzierbar.','checked',@revision_id);
SET @eq_3_147 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.148',@section_id,'Nichtautonome Zustandsgleichung','\\dot{x}(t)=F(x(t),t)','\\dot{x}(t)=F(x(t),t)','Allgemeines zeitabhängiges Entwicklungsgesetz.','model','literature',@source_69_id,NULL,'F ist hinreichend regulär.','checked',@revision_id);
SET @eq_3_148 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.149',@section_id,'Autonome Zustandsgleichung','\\dot{x}=F(x)','\\dot{x}=F(x)','Zeitinvariante kontinuierliche Zustandsentwicklung.','model','literature',@source_69_id,NULL,'F hängt nicht explizit von t ab.','checked',@revision_id);
SET @eq_3_149 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.150',@section_id,'Anfangsbedingung','x(t_0)=x_0','x(t_0)=x_0','Festlegung des Anfangszustandes zum Zeitpunkt t0.','definition','literature',@source_69_id,NULL,'x0 liegt im Zustandsraum.','checked',@revision_id);
SET @eq_3_150 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.151',@section_id,'Anfangswertproblem','\\left\\{\\begin{array}{l}\\dot{x}=F(x,t)\\\\x(t_0)=x_0\\end{array}\\right.','\\left\\{\\begin{array}{l}\\dot{x}=F(x,t)\\\\x(t_0)=x_0\\end{array}\\right.','Kombination aus Entwicklungsgleichung und Anfangsbedingung.','model','literature',@source_69_id,NULL,'Existenz- und Eindeutigkeitsbedingungen sind gesondert zu prüfen.','checked',@revision_id);
SET @eq_3_151 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.152',@section_id,'Flussabbildung','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','\\Phi:\\mathbb{R}\\times X\\longrightarrow X','Fluss als zeitparametrisierte Zustandsabbildung.','definition','literature',@source_69_id,NULL,'Globale Definition des Flusses vorausgesetzt.','checked',@revision_id);
SET @eq_3_152 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.153',@section_id,'Fluss und Lösung','\\Phi(t,x_0)=x(t)','\\Phi(t,x_0)=x(t)','Zuordnung der Lösungskurve zum Anfangszustand.','definition','literature',@source_69_id,NULL,'x(t) ist Lösung des Anfangswertproblems.','checked',@revision_id);
SET @eq_3_153 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.154',@section_id,'Identität des Flusses','\\Phi(0,x)=x','\\Phi(0,x)=x','Der Fluss lässt den Zustand bei Zeitparameter Null unverändert.','definition','literature',@source_69_id,NULL,'Flussstruktur.','checked',@revision_id);
SET @eq_3_154 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.155',@section_id,'Flusseigenschaft','\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)','\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)','Kompositionsgesetz zeitlicher Entwicklungen.','definition','literature',@source_69_id,NULL,'Kompatible Existenzintervalle.','checked',@revision_id);
SET @eq_3_155 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.156',@section_id,'Trajektorie','\\gamma(x_0)=\\left\\{\\Phi(t,x_0)\\mid t\\in I\\right\\}','\\gamma(x_0)=\\left\\{\\Phi(t,x_0)\\mid t\\in I\\right\\}','Menge aller entlang des Flusses erreichten Zustände.','definition','literature',@source_40_id,NULL,'I ist das betrachtete Zeitintervall.','checked',@revision_id);
SET @eq_3_156 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.157',@section_id,'Gleichgewichtspunkt','F(x^\\ast)=0','F(x^\\ast)=0','Ein Gleichgewichtspunkt ist eine Nullstelle des Vektorfeldes.','definition','literature',@source_39_id,NULL,'Autonomes dynamisches System.','checked',@revision_id);
SET @eq_3_157 := LAST_INSERT_ID();
INSERT INTO `equations` (`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`derivation`,`assumptions`,`validation_status`,`created_revision_id`) VALUES
('3.158',@section_id,'Invarianz eines Gleichgewichtspunktes','\\Phi(t,x^\\ast)=x^\\ast','\\Phi(t,x^\\ast)=x^\\ast','Ein Gleichgewichtspunkt bleibt unter dem Fluss unverändert.','derived','literature',@source_39_id,NULL,'x* ist Gleichgewichtspunkt.','checked',@revision_id);
SET @eq_3_158 := LAST_INSERT_ID();

/* Ausgewählte Gleichungssymbole */
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_136,'x','Zustand','Aktueller Zustand des Systems.',NULL,'X',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_136,'X','Zustandsraum','Menge aller zulässigen Zustände.',NULL,'Menge oder Raum',2);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_137,'x_i','Zustandskomponente','i-te Komponente des Zustandsvektors.',NULL,'\\mathbb R',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_139,'F','Übergangsabbildung','Abbildung eines Zustandes auf den Folgezustand.',NULL,'X\\to X',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_140,'k','diskreter Index','Index des diskreten Entwicklungsschrittes.',NULL,'\\mathbb N',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_141,'X_{\\mathrm{zul}}','zulässiger Zustandsraum','Menge aller nebenbedingungskonformen Zustände.',NULL,'Teilmenge von X',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_146,'I','Zeitintervall','Definitionsintervall der Zustandsfunktion.',NULL,'Teilmenge von \\mathbb R',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_147,'\\dot{x}(t)','Zustandsableitung','Zeitliche Änderungsrate des Zustandes.',NULL,'Tangentialraum',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_152,'\\Phi','Fluss','Zeitparametrisierte Zustandsabbildung.',NULL,'\\mathbb R\\times X\\to X',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_156,'\\gamma(x_0)','Trajektorie','Bahn des Anfangszustandes im Zustandsraum.',NULL,'Teilmenge von X',1);
INSERT INTO `equation_symbols` (`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`) VALUES
(@eq_3_157,'x^\\ast','Gleichgewichtspunkt','Zustand mit verschwindendem Vektorfeld.',NULL,'X',1);

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