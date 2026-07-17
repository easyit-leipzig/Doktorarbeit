/* ============================================================
 FRZK-RKB – UPDATE 3.1.4 Erkenntnistheoretische Grundlagen
 Basis: erfolgreicher Import von 3.1.3
 Wiederverwendet: Kant [13], Cassirer [18], Carnap [22]
 Neu: [41]–[55]
 Keine neuen Gleichungen.
 ============================================================ */
SET NAMES utf8mb4;
START TRANSACTION;

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-NEU-K3.1.3-V1' LIMIT 1
);
SET @parent_section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.1' LIMIT 1
);
SET @source_13 := (
 SELECT source_id FROM sources
 WHERE source_key='kant_kritik_reinen_vernunft_timmermann_1998'
 AND citation_number=13 LIMIT 1
);
SET @source_18 := (
 SELECT source_id FROM sources
 WHERE source_key='cassirer_substanzbegriff_funktionsbegriff_1910'
 AND citation_number=18 LIMIT 1
);
SET @source_22 := (
 SELECT source_id FROM sources
 WHERE source_key='carnap_logischer_aufbau_1998'
 AND citation_number=22 LIMIT 1
);

DROP PROCEDURE IF EXISTS frzk_preflight_3_1_4;
DELIMITER $$
CREATE PROCEDURE frzk_preflight_3_1_4()
BEGIN
 IF @parent_revision_id IS NULL THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='3.1.4: Elternrevision 3.1.3 fehlt.';
 END IF;
 IF @parent_section_id IS NULL THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='3.1.4: Abschnitt 3.1 fehlt.';
 END IF;
 IF @source_13 IS NULL OR @source_18 IS NULL OR @source_22 IS NULL THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='3.1.4: Eine wiederzuverwendende Quelle [13], [18] oder [22] fehlt.';
 END IF;
 IF EXISTS(SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.1.4-V1') THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='3.1.4: Revision existiert bereits.';
 END IF;
 IF EXISTS(SELECT 1 FROM dissertation_sections WHERE section_code='3.1.4') THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='3.1.4: Abschnitt existiert bereits.';
 END IF;
 IF EXISTS(SELECT 1 FROM sources WHERE citation_number BETWEEN 41 AND 55) THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='3.1.4: Literaturzahl [41]-[55] bereits belegt.';
 END IF;
END$$
DELIMITER ;
CALL frzk_preflight_3_1_4();
DROP PROCEDURE frzk_preflight_3_1_4;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-NEU-K3.1.4-V1',NOW(),'section','3.1.4','1.0',
 'Vollständige Neufassung von Abschnitt 3.1.4. Wiederverwendung von [13], [18], [22] und Aufnahme von [41] bis [55].',
 'Olaf Thiele / ChatGPT',@parent_revision_id);
SET @revision_id:=LAST_INSERT_ID();

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
VALUES
(@parent_section_id,'3.1.4','Erkenntnistheoretische Grundlagen',3,3.1400,'final',0,
 'Erkenntnistheoretische Abgrenzung von Konstruktion, Modell, Interpretation, empirischer Geltung und Ontologie.');
SET @section_id:=LAST_INSERT_ID();


INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Helmholtz','Hermann von','Helmholtz, Hermann von',1821,1894,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Helmholtz, Hermann von');
SET @a1:=(SELECT author_id FROM authors WHERE normalized_name='Helmholtz, Hermann von' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Hanson','Norwood Russell','Hanson, Norwood Russell',1924,1967,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Hanson, Norwood Russell');
SET @a2:=(SELECT author_id FROM authors WHERE normalized_name='Hanson, Norwood Russell' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Kuhn','Thomas S.','Kuhn, Thomas S.',1922,1996,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Kuhn, Thomas S.');
SET @a3:=(SELECT author_id FROM authors WHERE normalized_name='Kuhn, Thomas S.' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Popper','Karl R.','Popper, Karl R.',1902,1994,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Popper, Karl R.');
SET @a4:=(SELECT author_id FROM authors WHERE normalized_name='Popper, Karl R.' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Lakatos','Imre','Lakatos, Imre',1922,1974,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Lakatos, Imre');
SET @a5:=(SELECT author_id FROM authors WHERE normalized_name='Lakatos, Imre' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Musgrave','Alan','Musgrave, Alan',1940,NULL,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Musgrave, Alan');
SET @a6:=(SELECT author_id FROM authors WHERE normalized_name='Musgrave, Alan' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Quine','Willard Van Orman','Quine, Willard Van Orman',1908,2000,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Quine, Willard Van Orman');
SET @a7:=(SELECT author_id FROM authors WHERE normalized_name='Quine, Willard Van Orman' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Duhem','Pierre','Duhem, Pierre',1861,1916,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Duhem, Pierre');
SET @a8:=(SELECT author_id FROM authors WHERE normalized_name='Duhem, Pierre' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'van Fraassen','Bas C.','van Fraassen, Bas C.',1941,NULL,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='van Fraassen, Bas C.');
SET @a9:=(SELECT author_id FROM authors WHERE normalized_name='van Fraassen, Bas C.' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Worrall','John','Worrall, John',1946,NULL,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Worrall, John');
SET @a10:=(SELECT author_id FROM authors WHERE normalized_name='Worrall, John' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Ladyman','James','Ladyman, James',NULL,NULL,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Ladyman, James');
SET @a11:=(SELECT author_id FROM authors WHERE normalized_name='Ladyman, James' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'French','Steven','French, Steven',NULL,NULL,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='French, Steven');
SET @a12:=(SELECT author_id FROM authors WHERE normalized_name='French, Steven' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Hesse','Mary B.','Hesse, Mary B.',1924,2016,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Hesse, Mary B.');
SET @a13:=(SELECT author_id FROM authors WHERE normalized_name='Hesse, Mary B.' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Giere','Ronald N.','Giere, Ronald N.',1938,2020,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Giere, Ronald N.');
SET @a14:=(SELECT author_id FROM authors WHERE normalized_name='Giere, Ronald N.' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Suppes','Patrick','Suppes, Patrick',1922,2014,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Suppes, Patrick');
SET @a15:=(SELECT author_id FROM authors WHERE normalized_name='Suppes, Patrick' ORDER BY author_id LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Tarski','Alfred','Tarski, Alfred',1901,1983,'Für Abschnitt 3.1.4 registriert.'
WHERE NOT EXISTS(SELECT 1 FROM authors WHERE normalized_name='Tarski, Alfred');
SET @a16:=(SELECT author_id FROM authors WHERE normalized_name='Tarski, Alfred' ORDER BY author_id LIMIT 1);


/* Neue Quellen [41]–[55] */

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(41,'helmholtz_physiologische_optik_1867','book','Handbuch der physiologischen Optik',NULL,1867,1867,NULL,'Leopold Voss','Leipzig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',9,'verified','3.1.4','Wahrnehmung als Ergebnis unbewusster Schlussprozesse.','Helmholtz, Hermann von: Handbuch der physiologischen Optik. Leipzig: Leopold Voss, 1867.','Helmholtz (1867) [41]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_41:=(SELECT source_id FROM sources WHERE source_key='helmholtz_physiologische_optik_1867' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(42,'hanson_patterns_discovery_1958','book','Patterns of Discovery','An Inquiry into the Conceptual Foundations of Science',1958,1958,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'secondary',9,'verified','3.1.4','Theoriegeladenheit wissenschaftlicher Beobachtung.','Hanson, Norwood Russell: Patterns of Discovery. An Inquiry into the Conceptual Foundations of Science. Cambridge: Cambridge University Press, 1958.','Hanson (1958) [42]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_42:=(SELECT source_id FROM sources WHERE source_key='hanson_patterns_discovery_1958' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(43,'kuhn_structure_scientific_revolutions_1962','book','The Structure of Scientific Revolutions',NULL,1962,1962,NULL,'University of Chicago Press','Chicago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'secondary',9,'verified','3.1.4','Paradigmen, Normalwissenschaft und wissenschaftliche Revolutionen.','Kuhn, Thomas S.: The Structure of Scientific Revolutions. Chicago: University of Chicago Press, 1962.','Kuhn (1962) [43]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_43:=(SELECT source_id FROM sources WHERE source_key='kuhn_structure_scientific_revolutions_1962' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(44,'popper_logik_forschung_1935','book','Logik der Forschung','Zur Erkenntnistheorie der modernen Naturwissenschaft',1935,1935,NULL,'Julius Springer','Wien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',9,'verified','3.1.4','Falsifizierbarkeit und kritische Prüfung wissenschaftlicher Hypothesen.','Popper, Karl R.: Logik der Forschung. Zur Erkenntnistheorie der modernen Naturwissenschaft. Wien: Julius Springer, 1935.','Popper (1935) [44]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_44:=(SELECT source_id FROM sources WHERE source_key='popper_logik_forschung_1935' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(45,'lakatos_falsification_research_programmes_1970','book_chapter','Falsification and the Methodology of Scientific Research Programmes',NULL,1970,1970,NULL,'Cambridge University Press','Cambridge',NULL,NULL,'91–196',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Methodologie wissenschaftlicher Forschungsprogramme.','Lakatos, Imre: Falsification and the Methodology of Scientific Research Programmes. In: Lakatos, Imre; Musgrave, Alan (Hrsg.): Criticism and the Growth of Knowledge. Cambridge: Cambridge University Press, 1970, S. 91–196.','Lakatos (1970) [45]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_45:=(SELECT source_id FROM sources WHERE source_key='lakatos_falsification_research_programmes_1970' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(46,'quine_two_dogmas_1951','journal_article','Two Dogmas of Empiricism',NULL,1951,1951,'The Philosophical Review',NULL,NULL,'60',NULL,'20–43',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Holismus der empirischen Prüfung.','Quine, Willard Van Orman: Two Dogmas of Empiricism. In: The Philosophical Review, Band 60, 1951, S. 20–43.','Quine (1951) [46]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_46:=(SELECT source_id FROM sources WHERE source_key='quine_two_dogmas_1951' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(47,'duhem_theorie_physique_1906','book','La théorie physique','Son objet et sa structure',1906,1906,NULL,'Chevalier & Rivière','Paris',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',9,'verified','3.1.4','Unterbestimmtheit physikalischer Hypothesen durch Experimente.','Duhem, Pierre: La théorie physique. Son objet et sa structure. Paris: Chevalier & Rivière, 1906.','Duhem (1906) [47]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_47:=(SELECT source_id FROM sources WHERE source_key='duhem_theorie_physique_1906' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(48,'van_fraassen_scientific_image_1980','book','The Scientific Image',NULL,1980,1980,NULL,'Clarendon Press','Oxford',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'secondary',9,'verified','3.1.4','Konstruktiver Empirismus und empirische Angemessenheit.','van Fraassen, Bas C.: The Scientific Image. Oxford: Clarendon Press, 1980.','van Fraassen (1980) [48]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_48:=(SELECT source_id FROM sources WHERE source_key='van_fraassen_scientific_image_1980' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(49,'worrall_structural_realism_1989','journal_article','Structural Realism: The Best of Both Worlds?',NULL,1989,1989,'Dialectica',NULL,NULL,'43',NULL,'99–124',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Epistemischer Strukturenrealismus.','Worrall, John: Structural Realism: The Best of Both Worlds? In: Dialectica, Band 43, 1989, S. 99–124.','Worrall (1989) [49]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_49:=(SELECT source_id FROM sources WHERE source_key='worrall_structural_realism_1989' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(50,'ladyman_what_structural_realism_1998','journal_article','What is Structural Realism?',NULL,1998,1998,'Studies in History and Philosophy of Science',NULL,NULL,'29',NULL,'409–424',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Ontischer Strukturenrealismus.','Ladyman, James: What is Structural Realism? In: Studies in History and Philosophy of Science, Band 29, 1998, S. 409–424.','Ladyman (1998) [50]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_50:=(SELECT source_id FROM sources WHERE source_key='ladyman_what_structural_realism_1998' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(51,'french_ladyman_remodelling_structural_realism_2003','journal_article','Remodelling Structural Realism','Quantum Physics and the Metaphysics of Structure',2003,2003,'Synthese',NULL,NULL,'136',NULL,'31–56',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Strukturenrealismus im Kontext der Quantenphysik.','French, Steven; Ladyman, James: Remodelling Structural Realism: Quantum Physics and the Metaphysics of Structure. In: Synthese, Band 136, 2003, S. 31–56.','French und Ladyman (2003) [51]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_51:=(SELECT source_id FROM sources WHERE source_key='french_ladyman_remodelling_structural_realism_2003' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(52,'hesse_models_analogies_science_1963','book','Models and Analogies in Science',NULL,1963,1963,NULL,'Sheed and Ward','London',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'secondary',9,'verified','3.1.4','Positive, negative und neutrale Analogien wissenschaftlicher Modelle.','Hesse, Mary B.: Models and Analogies in Science. London: Sheed and Ward, 1963.','Hesse (1963) [52]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_52:=(SELECT source_id FROM sources WHERE source_key='hesse_models_analogies_science_1963' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(53,'giere_explaining_science_1988','book','Explaining Science','A Cognitive Approach',1988,1988,NULL,'University of Chicago Press','Chicago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'secondary',9,'verified','3.1.4','Modelle als zielgerichtete Repräsentationen.','Giere, Ronald N.: Explaining Science. A Cognitive Approach. Chicago: University of Chicago Press, 1988.','Giere (1988) [53]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_53:=(SELECT source_id FROM sources WHERE source_key='giere_explaining_science_1988' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(54,'suppes_models_mathematics_empirical_sciences_1960','journal_article','A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences',NULL,1960,1960,'Synthese',NULL,NULL,'12',NULL,'287–301',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Modelltheoretische Auffassung wissenschaftlicher Theorien.','Suppes, Patrick: A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences. In: Synthese, Band 12, 1960, S. 287–301.','Suppes (1960) [54]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_54:=(SELECT source_id FROM sources WHERE source_key='suppes_models_mathematics_empirical_sciences_1960' LIMIT 1);

INSERT INTO sources
(`citation_number`,`source_key`,`source_type`,`title`,`subtitle`,`year_original`,`year_edition`,`journal`,`publisher`,`place`,`volume`,`issue`,`pages`,`edition`,`doi`,`isbn`,`url`,`language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,`first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(55,'tarski_concept_truth_formalized_languages_1956','book_chapter','The Concept of Truth in Formalized Languages',NULL,1933,1956,NULL,'Clarendon Press','Oxford',NULL,NULL,'152–278',NULL,NULL,NULL,NULL,'en',1,'historical',9,'verified','3.1.4','Semantische Wahrheitstheorie und Trennung von Objekt- und Metasprache.','Tarski, Alfred: The Concept of Truth in Formalized Languages. In: Tarski, Alfred: Logic, Semantics, Metamathematics. Oxford: Clarendon Press, 1956, S. 152–278; polnische Erstveröffentlichung 1933.','Tarski (1956) [55]','Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.',@revision_id);

SET @source_55:=(SELECT source_id FROM sources WHERE source_key='tarski_concept_truth_formalized_languages_1956' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_41,@a1,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_42,@a2,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_43,@a3,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_44,@a4,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_45,@a5,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_45,@a6,2,'editor');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_46,@a7,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_47,@a8,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_48,@a9,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_49,@a10,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_50,@a11,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_51,@a12,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_51,@a11,2,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_52,@a13,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_53,@a14,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_54,@a15,1,'author');

INSERT INTO source_authors(source_id,author_id,author_order,role) VALUES(@source_55,@a16,1,'author');

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_13,@section_id,'background',
 'Raum und Zeit als Bedingungen möglicher Erfahrung und methodische Trennung von Erkenntnisbedingungen und Gegenstand.',
 'Abschnitt 3.1.4',0,1,'Wiederverwendung von Kant [13].',@revision_id),
(@source_18,@section_id,'background',
 'Funktionale und relationale Bestimmung wissenschaftlicher Gegenstände.',
 'Abschnitt 3.1.4',0,1,'Wiederverwendung von Cassirer [18].',@revision_id),
(@source_22,@section_id,'method',
 'Explizite formale Rekonstruktion wissenschaftlicher Begriffe und ihrer Konstruktionsregeln.',
 'Abschnitt 3.1.4',0,1,'Wiederverwendung von Carnap [22].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_41,@section_id,'first_citation','Wahrnehmung als Ergebnis unbewusster Schlussprozesse.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [41].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_42,@section_id,'first_citation','Theoriegeladenheit wissenschaftlicher Beobachtung.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [42].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_43,@section_id,'first_citation','Paradigmen, Normalwissenschaft und wissenschaftliche Revolutionen.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [43].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_44,@section_id,'first_citation','Falsifizierbarkeit und kritische Prüfung wissenschaftlicher Hypothesen.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [44].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_45,@section_id,'first_citation','Methodologie wissenschaftlicher Forschungsprogramme.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [45].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_46,@section_id,'first_citation','Holismus der empirischen Prüfung.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [46].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_47,@section_id,'first_citation','Unterbestimmtheit physikalischer Hypothesen durch Experimente.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [47].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_48,@section_id,'first_citation','Konstruktiver Empirismus und empirische Angemessenheit.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [48].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_49,@section_id,'first_citation','Epistemischer Strukturenrealismus.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [49].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_50,@section_id,'first_citation','Ontischer Strukturenrealismus.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [50].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_51,@section_id,'first_citation','Strukturenrealismus im Kontext der Quantenphysik.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [51].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_52,@section_id,'first_citation','Positive, negative und neutrale Analogien wissenschaftlicher Modelle.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [52].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_53,@section_id,'first_citation','Modelle als zielgerichtete Repräsentationen.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [53].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_54,@section_id,'first_citation','Modelltheoretische Auffassung wissenschaftlicher Theorien.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [54].',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES(@source_55,@section_id,'first_citation','Semantische Wahrheitstheorie und Trennung von Objekt- und Metasprache.','Abschnitt 3.1.4',1,1,
'Erstnennung als Quelle [55].',@revision_id);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_id,'created','section','3.1.4',
 'Abschnitt 3.1.4 vollständig neu erstellt.',NULL,'Erkenntnistheoretische Grundlagen'),
(@revision_id,@section_id,'source_reused','source','[13], [18], [22]',
 'Drei bereits vorhandene Quellen wurden wiederverwendet.',NULL,'Kant [13], Cassirer [18], Carnap [22]'),
(@revision_id,@section_id,'source_added','source','[41]–[55]',
 'Fünfzehn neue Quellen wurden aufgenommen.',NULL,'Quellen [41] bis [55]'),
(@revision_id,@section_id,'other','conceptual_result','erkenntnistheoretische Grundsätze',
 'Sechs Grundsätze zur Trennung von Konstruktion, Modell, Interpretation, empirischer Geltung und Ontologie dokumentiert.',
 NULL,'Methodisch-strukturalistische und empirisch anschlussfähige Grundposition'),
(@revision_id,@section_id,'status_changed','section','3.1.4',
 'Bearbeitungsstatus auf final gesetzt.','draft','final');

UPDATE repository_counters
SET counter_value=CAST(GREATEST(CAST(counter_value AS UNSIGNED),56) AS CHAR),
    updated_at=CURRENT_TIMESTAMP
WHERE counter_key='next_citation_number';

INSERT INTO repository_counters(counter_key,counter_value,updated_at)
SELECT 'next_citation_number','56',CURRENT_TIMESTAMP
WHERE NOT EXISTS(SELECT 1 FROM repository_counters WHERE counter_key='next_citation_number');

COMMIT;

/* Abschlussvalidierung */
SELECT revision_id,revision_code,scope_reference,parent_revision_id,summary
FROM repository_revisions WHERE revision_code='RKB-NEU-K3.1.4-V1';

SELECT section_id,parent_section_id,section_code,title,status
FROM dissertation_sections WHERE section_code='3.1.4';

SELECT citation_number,source_key,title,verification_status
FROM sources WHERE citation_number BETWEEN 41 AND 55 ORDER BY citation_number;

SELECT s.citation_number,s.source_key,su.usage_type,su.is_first_mention,su.citation_checked
FROM source_usage su JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id ORDER BY s.citation_number;

SELECT counter_key,counter_value,updated_at
FROM repository_counters WHERE counter_key='next_citation_number';

SELECT 'IMPORT 3.1.4 ABGESCHLOSSEN' AS status;
