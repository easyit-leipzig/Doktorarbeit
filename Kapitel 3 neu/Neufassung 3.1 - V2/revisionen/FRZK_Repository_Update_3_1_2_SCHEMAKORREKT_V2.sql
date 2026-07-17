/* ============================================================
   FRZK-RKB – Repository-Update
   Abschnitt 3.1.2
   Philosophische Grundlagen

   Grundlage: reale Tabellenstruktur aus frzk_rkb(3).sql
   Voraussetzung:
   - Updates 3.1.0 und 3.1.1 wurden erfolgreich importiert.
   - Abschnitt 3.1.2 und Quellen [7]–[25] existieren noch nicht.
   ============================================================ */

SET NAMES utf8mb4;
START TRANSACTION;

SET @parent_revision_id := (
  SELECT revision_id FROM repository_revisions
  WHERE revision_code='RKB-NEU-K3.1.1-V1' LIMIT 1
);
SET @section_3_1_id := (
  SELECT section_id FROM dissertation_sections
  WHERE section_code='3.1' LIMIT 1
);
SET @existing_revision := (
  SELECT COUNT(*) FROM repository_revisions
  WHERE revision_code='RKB-NEU-K3.1.2-V1'
);
SET @existing_section := (
  SELECT COUNT(*) FROM dissertation_sections
  WHERE section_code='3.1.2'
);
SET @existing_sources := (
  SELECT COUNT(*) FROM sources
  WHERE citation_number BETWEEN 7 AND 25
);

DROP PROCEDURE IF EXISTS frzk_preflight_3_1_2;
DELIMITER $$
CREATE PROCEDURE frzk_preflight_3_1_2()
BEGIN
  IF @parent_revision_id IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='FRZK 3.1.2: Elternrevision RKB-NEU-K3.1.1-V1 fehlt.';
  END IF;
  IF @section_3_1_id IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='FRZK 3.1.2: Übergeordneter Abschnitt 3.1 fehlt.';
  END IF;
  IF @existing_revision > 0 OR @existing_section > 0 OR @existing_sources > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='FRZK 3.1.2: Revision, Abschnitt oder Quellen [7]-[25] existieren bereits.';
  END IF;
END$$
DELIMITER ;
CALL frzk_preflight_3_1_2();
DROP PROCEDURE frzk_preflight_3_1_2;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-NEU-K3.1.2-V1',NOW(),'section','3.1.2','1.0',
 'Vollständige Neufassung von Abschnitt 3.1.2 Philosophische Grundlagen. Aufnahme der erstmals verwendeten Quellen [7] bis [25] einschließlich Autoren-, Herausgeber- und Übersetzerrollen.',
 'Olaf Thiele / ChatGPT',@parent_revision_id);
SET @revision_id := LAST_INSERT_ID();

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
VALUES
(@section_3_1_id,'3.1.2','Philosophische Grundlagen',3,3.1200,'final',1,
 'Vollständige Neufassung. Systematische Untersuchung philosophischer Begriffe von Sein, Nichtsein, Differenz, Relation, Prozess, Raum, Zeit, Erkenntnis und Information als Grundlage des FRZK.');
SET @section_id := LAST_INSERT_ID();



/* Autoren anlegen oder vorhandene Datensätze wiederverwenden */

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Platon',NULL,'Platon',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Platon');
SET @a1 := (SELECT author_id FROM authors WHERE normalized_name='Platon' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Eigler','Gunther','Eigler, Gunther',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Eigler, Gunther');
SET @a2 := (SELECT author_id FROM authors WHERE normalized_name='Eigler, Gunther' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Aristoteles',NULL,'Aristoteles',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Aristoteles');
SET @a3 := (SELECT author_id FROM authors WHERE normalized_name='Aristoteles' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Zekl','Hans Günter','Zekl, Hans Günter',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Zekl, Hans Günter');
SET @a4 := (SELECT author_id FROM authors WHERE normalized_name='Zekl, Hans Günter' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Plotin',NULL,'Plotin',204,270,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Plotin');
SET @a5 := (SELECT author_id FROM authors WHERE normalized_name='Plotin' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Harder','Richard','Harder, Richard',1896,1957,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Harder, Richard');
SET @a6 := (SELECT author_id FROM authors WHERE normalized_name='Harder, Richard' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Beutler','Rudolf','Beutler, Rudolf',1911,1975,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Beutler, Rudolf');
SET @a7 := (SELECT author_id FROM authors WHERE normalized_name='Beutler, Rudolf' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Theiler','Willy','Theiler, Willy',1899,1977,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Theiler, Willy');
SET @a8 := (SELECT author_id FROM authors WHERE normalized_name='Theiler, Willy' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Nikolaus von Kues',NULL,'Nikolaus von Kues',1401,1464,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Nikolaus von Kues');
SET @a9 := (SELECT author_id FROM authors WHERE normalized_name='Nikolaus von Kues' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Wilpert','Paul','Wilpert, Paul',1906,1967,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Wilpert, Paul');
SET @a10 := (SELECT author_id FROM authors WHERE normalized_name='Wilpert, Paul' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Spinoza','Baruch de','Spinoza, Baruch de',1632,1677,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Spinoza, Baruch de');
SET @a11 := (SELECT author_id FROM authors WHERE normalized_name='Spinoza, Baruch de' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Bartuschat','Wolfgang','Bartuschat, Wolfgang',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Bartuschat, Wolfgang');
SET @a12 := (SELECT author_id FROM authors WHERE normalized_name='Bartuschat, Wolfgang' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Leibniz','Gottfried Wilhelm','Leibniz, Gottfried Wilhelm',1646,1716,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Leibniz, Gottfried Wilhelm');
SET @a13 := (SELECT author_id FROM authors WHERE normalized_name='Leibniz, Gottfried Wilhelm' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Clarke','Samuel','Clarke, Samuel',1675,1729,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Clarke, Samuel');
SET @a14 := (SELECT author_id FROM authors WHERE normalized_name='Clarke, Samuel' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Alexander','H. G.','Alexander, H. G.',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Alexander, H. G.');
SET @a15 := (SELECT author_id FROM authors WHERE normalized_name='Alexander, H. G.' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Kant','Immanuel','Kant, Immanuel',1724,1804,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Kant, Immanuel');
SET @a16 := (SELECT author_id FROM authors WHERE normalized_name='Kant, Immanuel' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Timmermann','Jens','Timmermann, Jens',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Timmermann, Jens');
SET @a17 := (SELECT author_id FROM authors WHERE normalized_name='Timmermann, Jens' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Hegel','Georg Wilhelm Friedrich','Hegel, Georg Wilhelm Friedrich',1770,1831,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Hegel, Georg Wilhelm Friedrich');
SET @a18 := (SELECT author_id FROM authors WHERE normalized_name='Hegel, Georg Wilhelm Friedrich' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Russell','Bertrand','Russell, Bertrand',1872,1970,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Russell, Bertrand');
SET @a19 := (SELECT author_id FROM authors WHERE normalized_name='Russell, Bertrand' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Whitehead','Alfred North','Whitehead, Alfred North',1861,1947,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Whitehead, Alfred North');
SET @a20 := (SELECT author_id FROM authors WHERE normalized_name='Whitehead, Alfred North' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Griffin','David Ray','Griffin, David Ray',1939,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Griffin, David Ray');
SET @a21 := (SELECT author_id FROM authors WHERE normalized_name='Griffin, David Ray' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Sherburne','Donald W.','Sherburne, Donald W.',NULL,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Sherburne, Donald W.');
SET @a22 := (SELECT author_id FROM authors WHERE normalized_name='Sherburne, Donald W.' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Husserl','Edmund','Husserl, Edmund',1859,1938,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Husserl, Edmund');
SET @a23 := (SELECT author_id FROM authors WHERE normalized_name='Husserl, Edmund' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Boehm','Rudolf','Boehm, Rudolf',1927,2019,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Boehm, Rudolf');
SET @a24 := (SELECT author_id FROM authors WHERE normalized_name='Boehm, Rudolf' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Cassirer','Ernst','Cassirer, Ernst',1874,1945,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Cassirer, Ernst');
SET @a25 := (SELECT author_id FROM authors WHERE normalized_name='Cassirer, Ernst' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Heidegger','Martin','Heidegger, Martin',1889,1976,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Heidegger, Martin');
SET @a26 := (SELECT author_id FROM authors WHERE normalized_name='Heidegger, Martin' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Wittgenstein','Ludwig','Wittgenstein, Ludwig',1889,1951,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Wittgenstein, Ludwig');
SET @a27 := (SELECT author_id FROM authors WHERE normalized_name='Wittgenstein, Ludwig' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Carnap','Rudolf','Carnap, Rudolf',1891,1970,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Carnap, Rudolf');
SET @a28 := (SELECT author_id FROM authors WHERE normalized_name='Carnap, Rudolf' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Spencer-Brown','George','Spencer-Brown, George',1923,2016,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Spencer-Brown, George');
SET @a29 := (SELECT author_id FROM authors WHERE normalized_name='Spencer-Brown, George' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Floridi','Luciano','Floridi, Luciano',1964,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Floridi, Luciano');
SET @a30 := (SELECT author_id FROM authors WHERE normalized_name='Floridi, Luciano' ORDER BY author_id LIMIT 1);

INSERT INTO authors (family_name,given_names,normalized_name,birth_year,death_year,notes)
SELECT 'Bitbol','Michel','Bitbol, Michel',1954,NULL,'Für Abschnitt 3.1.2 registriert.'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Bitbol, Michel');
SET @a31 := (SELECT author_id FROM authors WHERE normalized_name='Bitbol, Michel' ORDER BY author_id LIMIT 1);


/* Quellen [7]–[25] */

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(7,'platon_sophistes_eigler_1990','historical_work','Sophistes','In: Werke in acht Bänden, griechisch und deutsch, Band 6',NULL,1990,NULL,'Wissenschaftliche Buchgesellschaft','Darmstadt','6',NULL,'254d–259d',NULL,NULL,NULL,NULL,'de',1,'historical',8,'verified','3.1.2','Erstnennung zur Bestimmung des Nichtseins als Andersheit und zur relationalen Fassung von Verschiedenheit.','Platon: Sophistes. In: Platon, Werke in acht Bänden, griechisch und deutsch. Herausgegeben von Gunther Eigler. Band 6. Darmstadt: Wissenschaftliche Buchgesellschaft, 1990, insbesondere 254d–259d.','Platon, Sophistes [7]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_7 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(8,'aristoteles_physikvorlesung_zekl_1987','historical_work','Physikvorlesung','Bücher IV und VI',NULL,1987,NULL,'Felix Meiner Verlag','Hamburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',8,'verified','3.1.2','Erstnennung zu Ort, Bewegung sowie Zeit als Zahl beziehungsweise Maß der Bewegung hinsichtlich des Früher und Später.','Aristoteles: Physikvorlesung. Übersetzt von Hans Günter Zekl. Hamburg: Felix Meiner Verlag, 1987, Bücher IV und VI.','Aristoteles, Physikvorlesung [8]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_8 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(9,'plotin_schriften_harder_1956_1960','historical_work','Schriften','Griechisch-deutsch; insbesondere Enneaden V.1 und V.2',NULL,1960,NULL,'Felix Meiner Verlag','Hamburg','I–V',NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',7,'verified','3.1.2','Erstnennung zur neuplatonischen Hervorbringung geordneter Vielheit aus dem Einen.','Plotin: Schriften. Griechisch-deutsch. Übersetzt von Richard Harder; Neubearbeitung fortgeführt von Rudolf Beutler und Willy Theiler. Bände I–V. Hamburg: Felix Meiner Verlag, 1956–1960, insbesondere Enneaden V.1 und V.2.','Plotin, Schriften [9]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_9 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(10,'cusanus_de_docta_ignorantia_wilpert_1994','historical_work','De docta ignorantia – Die belehrte Unwissenheit','Lateinisch-deutsch',1440,1994,NULL,'Felix Meiner Verlag','Hamburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',7,'verified','3.1.2','Erstnennung zur coincidentia oppositorum und zur erkenntnistheoretischen Begrenztheit bestimmender Begriffe.','Nikolaus von Kues: De docta ignorantia – Die belehrte Unwissenheit. Lateinisch-deutsch. Übersetzt und herausgegeben von Paul Wilpert. Hamburg: Felix Meiner Verlag, 1994.','Nikolaus von Kues [10]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_10 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(11,'spinoza_ethik_bartuschat_2015','historical_work','Ethik in geometrischer Ordnung dargestellt','Lateinisch-deutsch',1677,2015,NULL,'Felix Meiner Verlag','Hamburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',7,'verified','3.1.2','Erstnennung zur immanenten Ordnung von Substanz, Attributen und Modi sowie zur geometrischen Darstellungsweise.','Spinoza, Baruch de: Ethik in geometrischer Ordnung dargestellt. Lateinisch-deutsch. Übersetzt und herausgegeben von Wolfgang Bartuschat. Hamburg: Felix Meiner Verlag, 2015.','Spinoza, Ethik [11]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_11 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(12,'leibniz_clarke_correspondence_alexander_1956','book','The Leibniz–Clarke Correspondence','Insbesondere Leibniz’ dritte bis fünfte Schreiben',1717,1956,NULL,'Manchester University Press','Manchester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'historical',9,'verified','3.1.2','Erstnennung zur relationalen Auffassung von Raum als Ordnung des Zugleichseins und Zeit als Ordnung des Nacheinanders.','Leibniz, Gottfried Wilhelm; Clarke, Samuel: The Leibniz–Clarke Correspondence. Herausgegeben von H. G. Alexander. Manchester: Manchester University Press, 1956, insbesondere Leibniz’ dritte bis fünfte Schreiben.','Leibniz–Clarke [12]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_12 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(13,'kant_kritik_reinen_vernunft_timmermann_1998','historical_work','Kritik der reinen Vernunft','Insbesondere A19/B33–A49/B73',1781,1998,NULL,'Felix Meiner Verlag','Hamburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',8,'verified','3.1.2','Erstnennung zu Raum und Zeit als reinen Formen der sinnlichen Anschauung und Bedingungen möglicher Erfahrung.','Kant, Immanuel: Kritik der reinen Vernunft. Herausgegeben von Jens Timmermann. Hamburg: Felix Meiner Verlag, 1998, insbesondere A19/B33–A49/B73.','Kant, Kritik der reinen Vernunft [13]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_13 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(14,'hegel_wissenschaft_logik_1986','historical_work','Wissenschaft der Logik I','Werke, Band 5; Sein, Nichts und Werden',1812,1986,NULL,'Suhrkamp','Frankfurt am Main','5',NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'historical',8,'verified','3.1.2','Erstnennung zur dialektischen Vermittlung von Sein, Nichts und Werden sowie zur Bestimmung durch Negation.','Hegel, Georg Wilhelm Friedrich: Wissenschaft der Logik I. Werke, Band 5. Frankfurt am Main: Suhrkamp, 1986, insbesondere „Sein“, „Nichts“ und „Werden“.','Hegel, Wissenschaft der Logik I [14]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_14 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(15,'russell_principles_mathematics_1903','book','The Principles of Mathematics',NULL,1903,1903,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',8,'verified','3.1.2','Erstnennung zur formalen Eigenständigkeit mehrstelliger Relationen in der modernen Logik.','Russell, Bertrand: The Principles of Mathematics. Cambridge: Cambridge University Press, 1903.','Russell (1903) [15]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_15 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(16,'whitehead_process_reality_1978','book','Process and Reality','An Essay in Cosmology',1929,1978,NULL,'Free Press','New York',NULL,NULL,NULL,'Corrected edition',NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.2','Erstnennung zur Prozessontologie und zum Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaften Substanzen.','Whitehead, Alfred North: Process and Reality. An Essay in Cosmology. Corrected edition. Herausgegeben von David Ray Griffin und Donald W. Sherburne. New York: Free Press, 1978.','Whitehead, Process and Reality [16]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_16 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(17,'husserl_inneres_zeitbewusstsein_hua10_1966','book','Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917)','Husserliana, Band X',1917,1966,NULL,'Martinus Nijhoff','Den Haag','X',NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',8,'verified','3.1.2','Erstnennung zur zeitlichen Bewusstseinsstruktur aus Urimpression, Retention und Protention.','Husserl, Edmund: Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917). Husserliana, Band X. Herausgegeben von Rudolf Boehm. Den Haag: Martinus Nijhoff, 1966.','Husserl, Zeitbewusstsein [17]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_17 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(18,'cassirer_substanzbegriff_funktionsbegriff_1910','book','Substanzbegriff und Funktionsbegriff','Untersuchungen über die Grundfragen der Erkenntniskritik',1910,1910,NULL,'Bruno Cassirer','Berlin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',10,'verified','3.1.2','Erstnennung zum wissenschaftstheoretischen Übergang vom Substanzbegriff zum Funktions- und Relationsbegriff.','Cassirer, Ernst: Substanzbegriff und Funktionsbegriff. Untersuchungen über die Grundfragen der Erkenntniskritik. Berlin: Bruno Cassirer, 1910.','Cassirer (1910) [18]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_18 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(19,'heidegger_sein_zeit_2006','book','Sein und Zeit','Insbesondere §§ 65–71',1927,2006,NULL,'Max Niemeyer Verlag','Tübingen',NULL,NULL,NULL,'19. Auflage',NULL,NULL,NULL,'de',1,'primary',7,'verified','3.1.2','Erstnennung zur Kritik der Zeit als bloßer Abfolge von Jetztpunkten und zur existenzialen Zeitlichkeit.','Heidegger, Martin: Sein und Zeit. 19. Auflage. Tübingen: Max Niemeyer Verlag, 2006, insbesondere §§ 65–71.','Heidegger, Sein und Zeit [19]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_19 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(20,'wittgenstein_tractatus_1963','book','Tractatus logico-philosophicus',NULL,1921,1963,NULL,'Suhrkamp','Frankfurt am Main',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',7,'verified','3.1.2','Erstnennung zur Welt als Gesamtheit von Tatsachen und zur logischen Struktur sinnvoller Aussagen.','Wittgenstein, Ludwig: Tractatus logico-philosophicus. Frankfurt am Main: Suhrkamp, 1963.','Wittgenstein, Tractatus [20]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_20 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(21,'wittgenstein_philosophische_untersuchungen_2003','book','Philosophische Untersuchungen',NULL,1953,2003,NULL,'Suhrkamp','Frankfurt am Main',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',7,'verified','3.1.2','Erstnennung zur Bedeutung als regelgeleitetem Gebrauch innerhalb von Sprachspielen.','Wittgenstein, Ludwig: Philosophische Untersuchungen. Frankfurt am Main: Suhrkamp, 2003.','Wittgenstein, Philosophische Untersuchungen [21]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_21 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(22,'carnap_logischer_aufbau_1998','book','Der logische Aufbau der Welt',NULL,1928,1998,NULL,'Felix Meiner Verlag','Hamburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',1,'primary',9,'verified','3.1.2','Erstnennung zum konstruktiven Aufbau wissenschaftlicher Begriffe aus einer begrenzten Basis und expliziten Konstruktionsregeln.','Carnap, Rudolf: Der logische Aufbau der Welt. Hamburg: Felix Meiner Verlag, 1998. Erstveröffentlichung 1928.','Carnap, Logischer Aufbau [22]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_22 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(23,'spencer_brown_laws_form_1969','book','Laws of Form',NULL,1969,1969,NULL,'George Allen & Unwin','London',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',10,'verified','3.1.2','Erstnennung zur Unterscheidung als elementarer Operation der Formbildung.','Spencer-Brown, George: Laws of Form. London: George Allen & Unwin, 1969.','Spencer-Brown (1969) [23]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_23 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(24,'floridi_philosophy_information_2011','book','The Philosophy of Information',NULL,2011,2011,NULL,'Oxford University Press','Oxford',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',9,'verified','3.1.2','Erstnennung zur philosophischen Analyse informationeller Strukturen, Unterschiede und Relationen.','Floridi, Luciano: The Philosophy of Information. Oxford: Oxford University Press, 2011.','Floridi (2011) [24]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_24 := LAST_INSERT_ID();

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
VALUES
(25,'bitbol_reflective_metaphysics_2021','book','Reflective Metaphysics','Understanding Quantum Mechanics from a Kantian Standpoint',2021,2021,NULL,'Springer','Cham',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',1,'primary',8,'verified','3.1.2','Erstnennung zur erkenntnistheoretischen Zurückhaltung gegenüber unmittelbaren ontologischen Schlüssen aus physikalischen Formalismen.','Bitbol, Michel: Reflective Metaphysics. Understanding Quantum Mechanics from a Kantian Standpoint. Cham: Springer, 2021.','Bitbol (2021) [25]','Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.',@revision_id);

SET @source_25 := LAST_INSERT_ID();


/* Autoren-, Herausgeber- und Übersetzerzuordnungen */

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_7,@a1,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_7,@a2,2,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_8,@a3,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_8,@a4,2,'translator');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_9,@a5,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_9,@a6,2,'translator');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_9,@a7,3,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_9,@a8,4,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_10,@a9,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_10,@a10,2,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_11,@a11,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_11,@a12,2,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_12,@a13,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_12,@a14,2,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_12,@a15,3,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_13,@a16,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_13,@a17,2,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_14,@a18,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_15,@a19,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_16,@a20,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_16,@a21,2,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_16,@a22,3,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_17,@a23,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_17,@a24,2,'editor');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_18,@a25,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_19,@a26,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_20,@a27,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_21,@a27,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_22,@a28,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_23,@a29,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_24,@a30,1,'author');

INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES (@source_25,@a31,1,'author');


/* Quellenverwendungen */

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_7,@section_id,'first_citation','Erstnennung zur Bestimmung des Nichtseins als Andersheit und zur relationalen Fassung von Verschiedenheit.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [7]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_8,@section_id,'first_citation','Erstnennung zu Ort, Bewegung sowie Zeit als Zahl beziehungsweise Maß der Bewegung hinsichtlich des Früher und Später.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [8]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_9,@section_id,'first_citation','Erstnennung zur neuplatonischen Hervorbringung geordneter Vielheit aus dem Einen.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [9]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_10,@section_id,'first_citation','Erstnennung zur coincidentia oppositorum und zur erkenntnistheoretischen Begrenztheit bestimmender Begriffe.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [10]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_11,@section_id,'first_citation','Erstnennung zur immanenten Ordnung von Substanz, Attributen und Modi sowie zur geometrischen Darstellungsweise.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [11]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_12,@section_id,'first_citation','Erstnennung zur relationalen Auffassung von Raum als Ordnung des Zugleichseins und Zeit als Ordnung des Nacheinanders.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [12]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_13,@section_id,'first_citation','Erstnennung zu Raum und Zeit als reinen Formen der sinnlichen Anschauung und Bedingungen möglicher Erfahrung.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [13]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_14,@section_id,'first_citation','Erstnennung zur dialektischen Vermittlung von Sein, Nichts und Werden sowie zur Bestimmung durch Negation.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [14]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_15,@section_id,'first_citation','Erstnennung zur formalen Eigenständigkeit mehrstelliger Relationen in der modernen Logik.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [15]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_16,@section_id,'first_citation','Erstnennung zur Prozessontologie und zum Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaften Substanzen.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [16]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_17,@section_id,'first_citation','Erstnennung zur zeitlichen Bewusstseinsstruktur aus Urimpression, Retention und Protention.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [17]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_18,@section_id,'first_citation','Erstnennung zum wissenschaftstheoretischen Übergang vom Substanzbegriff zum Funktions- und Relationsbegriff.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [18]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_19,@section_id,'first_citation','Erstnennung zur Kritik der Zeit als bloßer Abfolge von Jetztpunkten und zur existenzialen Zeitlichkeit.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [19]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_20,@section_id,'first_citation','Erstnennung zur Welt als Gesamtheit von Tatsachen und zur logischen Struktur sinnvoller Aussagen.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [20]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_21,@section_id,'first_citation','Erstnennung zur Bedeutung als regelgeleitetem Gebrauch innerhalb von Sprachspielen.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [21]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_22,@section_id,'first_citation','Erstnennung zum konstruktiven Aufbau wissenschaftlicher Begriffe aus einer begrenzten Basis und expliziten Konstruktionsregeln.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [22]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_23,@section_id,'first_citation','Erstnennung zur Unterscheidung als elementarer Operation der Formbildung.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [23]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_24,@section_id,'first_citation','Erstnennung zur philosophischen Analyse informationeller Strukturen, Unterschiede und Relationen.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [24]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@source_25,@section_id,'first_citation','Erstnennung zur erkenntnistheoretischen Zurückhaltung gegenüber unmittelbaren ontologischen Schlüssen aus physikalischen Formalismen.','Abschnitt 3.1.2',1,1,
 'Erstnennung als Quelle [25]; bibliografische Angaben entsprechend dem Manuskript.',@revision_id);


INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_id,'created','section','3.1.2',
 'Abschnitt 3.1.2 vollständig neu erstellt und repositoryseitig abgeschlossen.',NULL,'Philosophische Grundlagen'),
(@revision_id,@section_id,'source_added','sources','[7]–[25]',
 'Neunzehn erstmals zitierte Quellen aufgenommen und mit Abschnitt 3.1.2 verknüpft.',NULL,'Quellen [7]–[25]'),
(@revision_id,@section_id,'other','conceptual_result','philosophische Arbeitsprinzipien',
 'Vier Arbeitsprinzipien dokumentiert: minimale Unterscheidbarkeit; Vorrang von Relationen und Prozessen; Trennung von Konstruktion, Erkenntnis und Ontologie; rekonstruierbare Raum- und Zeitordnungen.',
 NULL,'Konzeptionelle Grundlage, noch keine formale Definition und kein Axiom.'),
(@revision_id,@section_id,'status_changed','section','3.1.2',
 'Bearbeitungsstatus des Abschnitts auf final gesetzt.','draft','final');

COMMIT;

/* Abschlussvalidierung */
SELECT revision_id,revision_code,scope_reference,version_label,parent_revision_id,summary
FROM repository_revisions WHERE revision_id=@revision_id;

SELECT section_id,parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution
FROM dissertation_sections WHERE section_code='3.1.2';

SELECT citation_number,source_key,source_type,title,year_original,year_edition,first_citation_section_code,verification_status
FROM sources WHERE citation_number BETWEEN 7 AND 25 ORDER BY citation_number;

SELECT s.citation_number,sa.author_order,sa.role,a.normalized_name
FROM sources s
JOIN source_authors sa ON sa.source_id=s.source_id
JOIN authors a ON a.author_id=sa.author_id
WHERE s.citation_number BETWEEN 7 AND 25
ORDER BY 1,2;

SELECT s.citation_number,ds.section_code,su.usage_type,su.is_first_mention,su.citation_checked,su.claim_summary
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE ds.section_code='3.1.2'
ORDER BY 1;

SELECT change_id,change_type,object_type,object_reference,change_summary
FROM section_change_log
WHERE revision_id=@revision_id
ORDER BY change_id;
