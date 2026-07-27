USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE scope_reference='3.1.3'
 ORDER BY revision_id DESC LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-NEU-K3.1.4-ABSCHLUSS-V2',NOW(),'section','3.1.4','3.1.4-Abschluss-v2',
'Vollständiger Abschluss von 3.1.4 Erkenntnistheoretische Grundlagen; Quellen [15], [19], [23] und [45]–[59]; keine Gleichungen.',
'Olaf Thiele / ChatGPT',@parent_revision_id)
ON DUPLICATE KEY UPDATE
 revision_id=LAST_INSERT_ID(revision_id),
 revision_date=VALUES(revision_date),
 summary=VALUES(summary),
 parent_revision_id=VALUES(parent_revision_id);

SET @revision_id := LAST_INSERT_ID();
SET @parent_section_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.1' LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section_id,'3.1.4','Erkenntnistheoretische Grundlagen',3,3.1400,'final',1,
'Abgeschlossen. Wiederverwendung [15], [19], [23]; neue Quellen [45]–[59]; keine nummerierten Gleichungen.'
WHERE NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.1.4');

UPDATE dissertation_sections SET
 parent_section_id=@parent_section_id,title='Erkenntnistheoretische Grundlagen',
 chapter_no=3,section_order=3.1400,status='final',is_original_contribution=1,
 notes='Abgeschlossen. Wiederverwendung [15], [19], [23]; neue Quellen [45]–[59]; keine nummerierten Gleichungen.'
WHERE section_code='3.1.4';

SET @section_id := (
 SELECT section_id FROM dissertation_sections WHERE section_code='3.1.4' LIMIT 1
);

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(45,'helmholtz_handbuch_phys_optik_1867','book','Handbuch der physiologischen Optik',NULL,1867,1867,NULL,'Leopold Voss','Leipzig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',9,'verified','3.1.4','Wahrnehmung als Ergebnis unbewusster Schlussprozesse.','Helmholtz, Hermann von: Handbuch der physiologischen Optik. Leipzig: Leopold Voss, 1867.','Helmholtz [45]','Erkenntnistheoretische Vermittlung zwischen Reiz, Wahrnehmung und Gegenstandsbezug.',@revision_id),
(46,'hanson_patterns_discovery_1958','book','Patterns of Discovery','An Inquiry into the Conceptual Foundations of Science',1958,1958,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Theorieabhängigkeit wissenschaftlicher Beobachtung.','Hanson, Norwood Russell: Patterns of Discovery. Cambridge: Cambridge University Press, 1958.','Hanson [46]','Theoriegeladenheit wissenschaftlichen Sehens.',@revision_id),
(47,'kuhn_structure_scientific_revolutions_1962','book','The Structure of Scientific Revolutions',NULL,1962,1962,NULL,'University of Chicago Press','Chicago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.4','Paradigmen und historische Theorieentwicklung.','Kuhn, Thomas S.: The Structure of Scientific Revolutions. Chicago: University of Chicago Press, 1962.','Kuhn [47]','Paradigmatische Einbettung wissenschaftlicher Begriffe.',@revision_id),
(48,'popper_logik_forschung_1935','book','Logik der Forschung','Zur Erkenntnistheorie der modernen Naturwissenschaft',1935,1935,NULL,'Julius Springer','Wien',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',10,'verified','3.1.4','Falsifizierbarkeit empirischer Wissenschaft.','Popper, Karl R.: Logik der Forschung. Wien: Julius Springer, 1935.','Popper [48]','Falsifizierbarkeit wissenschaftlicher Aussagen.',@revision_id),
(49,'lakatos_falsification_research_programmes_1970','book_chapter','Falsification and the Methodology of Scientific Research Programmes',NULL,1970,1970,NULL,'Cambridge University Press','Cambridge',NULL,NULL,'91–196',NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.4','Progressive und degenerative Forschungsprogramme.','Lakatos, Imre: Falsification and the Methodology of Scientific Research Programmes. In: Lakatos/Musgrave (Hrsg.): Criticism and the Growth of Knowledge. Cambridge, 1970, S. 91–196.','Lakatos [49]','Methodische Selbstprüfung des FRZK.',@revision_id),
(50,'quine_two_dogmas_empiricism_1951','journal_article','Two Dogmas of Empiricism',NULL,1951,1951,'The Philosophical Review',NULL,NULL,'60',NULL,'20–43',NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.4','Holismus wissenschaftlicher Überprüfung.','Quine, Willard Van Orman: Two Dogmas of Empiricism. The Philosophical Review 60 (1951), S. 20–43.','Quine [50]','Bestätigungs- und Überprüfungsholismus.',@revision_id),
(51,'duhem_theorie_physique_1906','book','La théorie physique','Son objet et sa structure',1906,1906,NULL,'Chevalier & Rivière','Paris',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'fr',1,'primary',10,'verified','3.1.4','Experimente prüfen Bündel von Voraussetzungen.','Duhem, Pierre: La théorie physique. Son objet et sa structure. Paris: Chevalier & Rivière, 1906.','Duhem [51]','Unterbestimmtheit physikalischer Theorien.',@revision_id),
(52,'van_fraassen_scientific_image_1980','book','The Scientific Image',NULL,1980,1980,NULL,'Clarendon Press','Oxford',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Konstruktiver Empirismus.','van Fraassen, Bas C.: The Scientific Image. Oxford: Clarendon Press, 1980.','van Fraassen [52]','Zurückhaltende ontologische Interpretation.',@revision_id),
(53,'worrall_structural_realism_1989','journal_article','Structural Realism: The Best of Both Worlds?',NULL,1989,1989,'Dialectica',NULL,NULL,'43',NULL,'99–124',NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.4','Strukturerhaltung bei Theorieumbrüchen.','Worrall, John: Structural Realism: The Best of Both Worlds? Dialectica 43 (1989), S. 99–124.','Worrall [53]','Epistemischer Strukturenrealismus.',@revision_id),
(54,'ladyman_what_structural_realism_1998','journal_article','What is Structural Realism?',NULL,1998,1998,'Studies in History and Philosophy of Science',NULL,NULL,'29',NULL,'409–424',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Ontischer Strukturenrealismus.','Ladyman, James: What is Structural Realism? Studies in History and Philosophy of Science 29 (1998), S. 409–424.','Ladyman [54]','Ontische Interpretation wissenschaftlicher Strukturen.',@revision_id),
(55,'french_ladyman_remodelling_structural_realism_2003','journal_article','Remodelling Structural Realism','Quantum Physics and the Metaphysics of Structure',2003,2003,'Synthese',NULL,NULL,'136',NULL,'31–56',NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Strukturenrealismus und Quantenphysik.','French, Steven; Ladyman, James: Remodelling Structural Realism. Synthese 136 (2003), S. 31–56.','French/Ladyman [55]','Strukturalistische Interpretation moderner Physik.',@revision_id),
(56,'hesse_models_analogies_science_1963','book','Models and Analogies in Science',NULL,1963,1963,NULL,'Sheed and Ward','London',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Positive, negative und neutrale Analogien.','Hesse, Mary B.: Models and Analogies in Science. London: Sheed and Ward, 1963.','Hesse [56]','Selektive und analoge Funktion wissenschaftlicher Modelle.',@revision_id),
(57,'giere_explaining_science_1988','book','Explaining Science','A Cognitive Approach',1988,1988,NULL,'University of Chicago Press','Chicago',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.4','Modelle als zielgerichtete Repräsentationen.','Giere, Ronald N.: Explaining Science. Chicago: University of Chicago Press, 1988.','Giere [57]','Ziel- und zweckabhängige Modellrepräsentation.',@revision_id),
(58,'suppes_models_mathematics_empirical_sciences_1960','journal_article','A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences',NULL,1960,1960,'Synthese',NULL,NULL,'12',NULL,'287–301',NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.4','Theorien als Klassen mathematischer Strukturen.','Suppes, Patrick: A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences. Synthese 12 (1960), S. 287–301.','Suppes [58]','Modelltheoretische Auffassung wissenschaftlicher Theorien.',@revision_id),
(59,'tarski_truth_formalized_languages_1933_1956','book_chapter','The Concept of Truth in Formalized Languages',NULL,1933,1956,NULL,'Clarendon Press','Oxford',NULL,NULL,'152–278',NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.4','Objekt- und Metasprache sowie Erfüllungsbedingungen.','Tarski, Alfred: The Concept of Truth in Formalized Languages. In: Logic, Semantics, Metamathematics. Oxford: Clarendon Press, 1956, S. 152–278.','Tarski [59]','Trennung formaler Systemebenen.',@revision_id)
ON DUPLICATE KEY UPDATE
source_key=VALUES(source_key),source_type=VALUES(source_type),title=VALUES(title),subtitle=VALUES(subtitle),
year_original=VALUES(year_original),year_edition=VALUES(year_edition),journal=VALUES(journal),
publisher=VALUES(publisher),place=VALUES(place),volume=VALUES(volume),issue=VALUES(issue),
pages=VALUES(pages),edition=VALUES(edition),doi=VALUES(doi),isbn=VALUES(isbn),url=VALUES(url),
language_code=VALUES(language_code),priority=VALUES(priority),evidence_type=VALUES(evidence_type),
frzk_relevance=VALUES(frzk_relevance),verification_status=VALUES(verification_status),
first_citation_section_code=VALUES(first_citation_section_code),first_citation_note=VALUES(first_citation_note),
full_citation_text=VALUES(full_citation_text),short_citation_text=VALUES(short_citation_text),
notes=VALUES(notes),created_revision_id=VALUES(created_revision_id);

INSERT INTO authors
(family_name,given_names,normalized_name,birth_year,death_year,notes)
VALUES
('Helmholtz','Hermann von','Helmholtz, Hermann von',1821,1894,'Autor von Quelle [45].'),
('Hanson','Norwood Russell','Hanson, Norwood Russell',1924,1967,'Autor von Quelle [46].'),
('Kuhn','Thomas S.','Kuhn, Thomas S.',1922,1996,'Autor von Quelle [47].'),
('Popper','Karl R.','Popper, Karl R.',1902,1994,'Autor von Quelle [48].'),
('Lakatos','Imre','Lakatos, Imre',1922,1974,'Autor von Quelle [49].'),
('Quine','Willard Van Orman','Quine, Willard Van Orman',1908,2000,'Autor von Quelle [50].'),
('Duhem','Pierre','Duhem, Pierre',1861,1916,'Autor von Quelle [51].'),
('van Fraassen','Bas C.','van Fraassen, Bas C.',1941,NULL,'Autor von Quelle [52].'),
('Worrall','John','Worrall, John',1946,NULL,'Autor von Quelle [53].'),
('Ladyman','James','Ladyman, James',NULL,NULL,'Autor der Quellen [54] und [55].'),
('French','Steven','French, Steven',NULL,NULL,'Erstautor von Quelle [55].'),
('Hesse','Mary B.','Hesse, Mary B.',1924,2016,'Autorin von Quelle [56].'),
('Giere','Ronald N.','Giere, Ronald N.',1938,2020,'Autor von Quelle [57].'),
('Suppes','Patrick','Suppes, Patrick',1922,2014,'Autor von Quelle [58].'),
('Tarski','Alfred','Tarski, Alfred',1901,1983,'Autor von Quelle [59].')
ON DUPLICATE KEY UPDATE family_name=VALUES(family_name),given_names=VALUES(given_names),
birth_year=VALUES(birth_year),death_year=VALUES(death_year),notes=VALUES(notes);

INSERT IGNORE INTO source_authors(source_id,author_id,author_order,role)
SELECT s.source_id,a.author_id,1,'author'
FROM sources s JOIN authors a ON
 (s.citation_number=45 AND a.normalized_name='Helmholtz, Hermann von') OR
 (s.citation_number=46 AND a.normalized_name='Hanson, Norwood Russell') OR
 (s.citation_number=47 AND a.normalized_name='Kuhn, Thomas S.') OR
 (s.citation_number=48 AND a.normalized_name='Popper, Karl R.') OR
 (s.citation_number=49 AND a.normalized_name='Lakatos, Imre') OR
 (s.citation_number=50 AND a.normalized_name='Quine, Willard Van Orman') OR
 (s.citation_number=51 AND a.normalized_name='Duhem, Pierre') OR
 (s.citation_number=52 AND a.normalized_name='van Fraassen, Bas C.') OR
 (s.citation_number=53 AND a.normalized_name='Worrall, John') OR
 (s.citation_number=54 AND a.normalized_name='Ladyman, James') OR
 (s.citation_number=55 AND a.normalized_name='French, Steven') OR
 (s.citation_number=56 AND a.normalized_name='Hesse, Mary B.') OR
 (s.citation_number=57 AND a.normalized_name='Giere, Ronald N.') OR
 (s.citation_number=58 AND a.normalized_name='Suppes, Patrick') OR
 (s.citation_number=59 AND a.normalized_name='Tarski, Alfred')
WHERE s.citation_number BETWEEN 45 AND 59;

INSERT IGNORE INTO source_authors(source_id,author_id,author_order,role)
SELECT s.source_id,a.author_id,2,'author'
FROM sources s JOIN authors a
 ON s.citation_number=55 AND a.normalized_name='Ladyman, James';

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'reuse',
CASE s.citation_number
 WHEN 15 THEN 'Kants Unterscheidung zwischen Erkenntnisbedingungen und Dingen an sich.'
 WHEN 19 THEN 'Cassirers relationale Bestimmung wissenschaftlicher Gegenstände.'
 WHEN 23 THEN 'Carnaps Forderung nach expliziten Definitionen und Zuordnungsregeln.'
END,'3.1.4',0,1,'Wiederverwendung.',@revision_id
FROM sources s WHERE s.citation_number IN (15,19,23)
AND NOT EXISTS (SELECT 1 FROM source_usage u WHERE u.source_id=s.source_id AND u.section_id=@section_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT s.source_id,@section_id,'first_citation',
CONCAT('Erstverwendung der erkenntnistheoretischen Quelle [',s.citation_number,'].'),
'3.1.4',1,1,'Erstverwendung in den erkenntnistheoretischen Grundlagen.',@revision_id
FROM sources s WHERE s.citation_number BETWEEN 45 AND 59
AND NOT EXISTS (SELECT 1 FROM source_usage u WHERE u.source_id=s.source_id AND u.section_id=@section_id);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_id,@section_id,'created','section','3.1.4',
'Abschnitt 3.1.4 vollständig angelegt und abgeschlossen.',NULL,
'Quellen [15], [19], [23] und [45]–[59]; keine Gleichungen.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_reference='3.1.4');

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.1.4'),('current_section','3.1.5'),
('last_citation_number','59'),('next_citation_number','60')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

SET @section_count := (SELECT COUNT(*) FROM dissertation_sections WHERE section_code='3.1.4');
SET @source_count := (SELECT COUNT(*) FROM sources WHERE citation_number BETWEEN 45 AND 59);
SET @usage_count := (SELECT COUNT(DISTINCT s.citation_number) FROM source_usage u JOIN sources s ON s.source_id=u.source_id WHERE u.section_id=@section_id AND s.citation_number BETWEEN 45 AND 59);
SET @reuse_count := (SELECT COUNT(DISTINCT s.citation_number) FROM source_usage u JOIN sources s ON s.source_id=u.source_id WHERE u.section_id=@section_id AND s.citation_number IN (15,19,23));
SET @equation_count := (SELECT COUNT(*) FROM equations WHERE section_id=@section_id);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
VALUES
(@revision_id,'K3_1_4_SECTION',IF(@section_count=1,'passed','failed'),'1',CAST(@section_count AS CHAR),'Abschnitt 3.1.4 genau einmal vorhanden.'),
(@revision_id,'K3_1_4_SOURCES',IF(@source_count=15,'passed','failed'),'15',CAST(@source_count AS CHAR),'Quellen [45]–[59] vollständig.'),
(@revision_id,'K3_1_4_USAGE',IF(@usage_count=15,'passed','failed'),'15',CAST(@usage_count AS CHAR),'Neue Quellen vollständig verknüpft.'),
(@revision_id,'K3_1_4_REUSE',IF(@reuse_count=3,'passed','failed'),'3',CAST(@reuse_count AS CHAR),'Wiederverwendete Quellen vollständig verknüpft.'),
(@revision_id,'K3_1_4_NO_EQUATIONS',IF(@equation_count=0,'passed','failed'),'0',CAST(@equation_count AS CHAR),'Keine nummerierten Gleichungen.')
ON DUPLICATE KEY UPDATE validation_status=VALUES(validation_status),expected_value=VALUES(expected_value),
actual_value=VALUES(actual_value),validation_message=VALUES(validation_message),checked_at=CURRENT_TIMESTAMP;

COMMIT;

SELECT revision_code,scope_reference,parent_revision_id FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.1.4-ABSCHLUSS-V2';
SELECT section_code,title,status,section_order FROM dissertation_sections WHERE section_code='3.1.4';
SELECT citation_number,title FROM sources WHERE citation_number BETWEEN 45 AND 59 ORDER BY citation_number;
SELECT validation_code,validation_status,expected_value,actual_value
FROM repository_validation_results WHERE revision_id=@revision_id ORDER BY validation_code;
