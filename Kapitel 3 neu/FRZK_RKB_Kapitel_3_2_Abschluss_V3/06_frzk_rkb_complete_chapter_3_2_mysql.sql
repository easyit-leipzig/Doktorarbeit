-- ============================================================
-- FRZK-RKB V3: vollständiges Abschlussskript für Kapitel 3.2
-- Voraussetzung: FRZK_RKB_V3_COMPLETE_MYSQL.sql wurde importiert.
-- Das Skript ist weitgehend idempotent und kann erneut ausgeführt werden.
--
-- Deduplizierte Literatur:
--   neue Quellen: [23] bis [52]
--   wiederverwendet: Haken [12], Holland [14], Barabási [15]
--   nächste freie Literaturnummer: [53]
--
-- Gleichungen:
--   neu: (3.3) bis (3.86), insgesamt 84
--   nächste freie Gleichungsnummer: (3.87)
-- ============================================================

USE frzk_rkb;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;

-- Zusätzliche notwendige Repository-Erweiterungen
CREATE TABLE IF NOT EXISTS citation_corrections (
    correction_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    old_citation_label VARCHAR(50) NOT NULL,
    corrected_citation_label VARCHAR(50) NOT NULL,
    section_code VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    revision_id BIGINT UNSIGNED NULL,
    corrected_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_citation_correction (old_citation_label, section_code),
    CONSTRAINT fk_citation_correction_revision
        FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS repository_counters (
    counter_key VARCHAR(100) PRIMARY KEY,
    counter_value VARCHAR(100) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS repository_validation_results (
    validation_result_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_id BIGINT UNSIGNED NOT NULL,
    validation_code VARCHAR(100) NOT NULL,
    validation_status ENUM('passed','warning','failed') NOT NULL,
    expected_value VARCHAR(255),
    actual_value VARCHAR(255),
    validation_message TEXT NOT NULL,
    checked_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_validation_revision_code (revision_id, validation_code),
    CONSTRAINT fk_validation_revision
        FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

START TRANSACTION;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by)
VALUES
('RKB-2026-07-12-K3.2-COMPLETE','2026-07-12 12:00:00','chapter','3.2','1.0',
 'Vollständiger Abschlussimport für Kapitel 3.2: Literatur, Annotationen, Verwendungen, Gleichungen, Definitionen, Symbole, Anforderungen, Verzeichnisse, Korrekturen und Validierungen.',
 'Olaf Thiele / ChatGPT')
ON DUPLICATE KEY UPDATE
 revision_date=VALUES(revision_date),
 version_label=VALUES(version_label),
 summary=VALUES(summary);

SET @revision_id = (
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-2026-07-12-K3.2-COMPLETE'
);
SET @chapter_section_id = (
    SELECT section_id FROM dissertation_sections WHERE section_code='3.2'
);

-- Kapitelüberschriften und Status an die aktuelle Fassung angleichen
UPDATE dissertation_sections SET title='Mathematische Grundlagen',status='review' WHERE section_code='3.2';
UPDATE dissertation_sections SET title='Einleitung',status='review' WHERE section_code='3.2.0';
UPDATE dissertation_sections SET title='Mengen als Grundlage mathematischer Modellbildung',status='review' WHERE section_code='3.2.1';
UPDATE dissertation_sections SET title='Relationen als mathematische Beschreibung struktureller Zusammenhänge',status='review' WHERE section_code='3.2.2';
UPDATE dissertation_sections SET title='Funktionen als mathematische Beschreibung gerichteter Transformationen',status='review' WHERE section_code='3.2.3';
UPDATE dissertation_sections SET title='Algebraische Strukturen als Grundlage mathematischer Operationen',status='review' WHERE section_code='3.2.4';
UPDATE dissertation_sections SET title='Operatorentheorie als mathematische Grundlage funktionaler Transformationen',status='review' WHERE section_code='3.2.5';
UPDATE dissertation_sections SET title='Zustandsräume als mathematische Grundlage funktionaler Entwicklungen',status='review' WHERE section_code='3.2.6';
UPDATE dissertation_sections SET title='Funktionalanalysis als mathematischer Rahmen unendlichdimensionaler Zustandsräume',status='review' WHERE section_code='3.2.7';
UPDATE dissertation_sections SET title='Dynamische Systeme als mathematische Beschreibung zeitlicher Entwicklungen',status='review' WHERE section_code='3.2.8';
UPDATE dissertation_sections SET title='Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse',status='review' WHERE section_code='3.2.9';
UPDATE dissertation_sections SET title='Graphen- und Netzwerktheorie als mathematische Beschreibung komplexer Beziehungsstrukturen',status='review' WHERE section_code='3.2.10';
UPDATE dissertation_sections SET title='Metriken und Ähnlichkeitsmaße als Grundlage funktionaler Kohärenz',status='review' WHERE section_code='3.2.11';
UPDATE dissertation_sections SET title='Emergenz und Selbstorganisation als mathematische Grundlagen funktionaler Strukturbildung',status='review' WHERE section_code='3.2.12';
UPDATE dissertation_sections SET title='Grenzen bestehender mathematischer Modelle und Herleitung der Forschungslücke',status='review' WHERE section_code='3.2.13';


-- ------------------------------------------------------------
-- Neue, deduplizierte Literatur [23]-[52]
-- ------------------------------------------------------------

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(23,'cantor_beitraege_1895_1897','journal_article','Beiträge zur Begründung der transfiniten Mengenlehre',1895,1897,'Mathematische Annalen',NULL,NULL,
 '46/49',NULL,'481–512; 207–246',NULL,'de',5,'primary',4,
 'needs_review','3.2.1','Cantor, Georg: Beiträge zur Begründung der transfiniten Mengenlehre. Mathematische Annalen, 46, 1895, S. 481–512; 49, 1897, S. 207–246.','Cantor [23]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=23),
 'Begründet die transfinite Mengenlehre und etabliert den allgemeinen Mengenbegriff.','Primärquelle für Abschnitt 3.2.1 und die historische Herleitung der Mengenlehre.','Belegt die Einführung von Mengen als allgemeine mathematische Objektstruktur.','Allgemeiner Mengenbegriff; transfinite Mächtigkeiten; Abstraktion mathematischer Objekte.','Noch keine vollständig axiomatisierte Mengenlehre.','Wird durch Zermelo [24], Jech [25] und Halmos [26] formalisiert beziehungsweise systematisiert.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(24,'zermelo_grundlagen_1908','journal_article','Untersuchungen über die Grundlagen der Mengenlehre I',1908,1908,'Mathematische Annalen',NULL,NULL,
 '65',NULL,'261–281',NULL,'de',5,'primary',4,
 'needs_review','3.2.1','Zermelo, Ernst: Untersuchungen über die Grundlagen der Mengenlehre I. Mathematische Annalen, 65, 1908, S. 261–281.','Zermelo [24]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=24),
 'Formuliert eines der ersten axiomatischen Systeme der Mengenlehre.','Belegt die axiomatische Fundierung der Mengenlehre in 3.2.1.','Dient zur Einordnung von Extensionalität, Aussonderung und kontrollierter Mengenbildung.','Axiomatisierung der Mengenlehre; Begrenzung uneingeschränkter Mengenbildung.','Spätere Ergänzungen durch Fraenkel, Skolem und das Auswahlaxiom erforderlich.','Historische Grundlage der heutigen ZFC-Formulierung.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(25,'jech_set_theory_2003','book','Set Theory',1978,2003,NULL,'Springer','Berlin',
 NULL,NULL,NULL,'3rd Millennium Edition','en',5,'reference',4,
 'needs_review','3.2.1','Jech, Thomas: Set Theory. 3rd Millennium Edition. Berlin: Springer, 2003.','Jech [25]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=25),
 'Internationales Referenzwerk zur modernen axiomatischen Mengenlehre.','Standardreferenz für Definitionen und Axiome in 3.2.1.','Absicherung der modernen ZFC-Darstellung.','ZFC, Ordinalzahlen, Kardinalzahlen und Modelle der Mengenlehre.','Sekundärquelle; historische Erstleistungen liegen bei Cantor und Zermelo.','Systematisiert die durch [23] und [24] begründete Theorie.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(26,'halmos_naive_set_theory_1960','book','Naive Set Theory',1960,1960,NULL,'D. Van Nostrand Company','Princeton',
 NULL,NULL,NULL,NULL,'en',4,'reference',3,
 'needs_review','3.2.1','Halmos, Paul R.: Naive Set Theory. Princeton: D. Van Nostrand Company, 1960.','Halmos [26]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=26),
 'Kompakte Standarddarstellung elementarer mengentheoretischer Strukturen.','Ergänzende Referenz für Mengen, Teilmengen, Abbildungen und kartesische Produkte.','Unterstützt die verständliche Formalisierung elementarer Begriffe.','Elementrelation, Teilmenge, kartesisches Produkt und Abbildungen.','Bewusst keine vollständige axiomatische Grundlagenmonographie.','Ergänzt Jech [25] auf elementarer Darstellungsebene.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(27,'enderton_elements_set_theory_1977','book','Elements of Set Theory',1977,1977,NULL,'Academic Press','New York',
 NULL,NULL,NULL,NULL,'en',4,'reference',3,
 'needs_review','3.2.2','Enderton, Herbert B.: Elements of Set Theory. New York: Academic Press, 1977.','Enderton [27]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=27),
 'Systematische Darstellung von Mengen, Relationen und Funktionen.','Grundlage für die formale Einführung binärer Relationen in 3.2.2.','Belegt die Definition von Relationen als Teilmengen kartesischer Produkte.','Relationen, Äquivalenzklassen und Ordnungsstrukturen.','Sekundärquelle ohne originären Anspruch.','Verbindet Mengenlehre mit Relationentheorie.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(28,'davey_priestley_lattices_order_2002','book','Introduction to Lattices and Order',1990,2002,NULL,'Cambridge University Press','Cambridge',
 NULL,NULL,NULL,'2nd Edition','en',4,'reference',3,
 'needs_review','3.2.2','Davey, Brian A.; Priestley, Hilary A.: Introduction to Lattices and Order. 2nd Edition. Cambridge: Cambridge University Press, 2002.','Davey und Priestley [28]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=28),
 'Standardwerk zu Ordnungsrelationen, Verbänden und strukturellen Hierarchien.','Referenz für Halbordnungen und geordnete Strukturen in 3.2.2.','Belegt die mathematische Bedeutung von Reflexivität, Antisymmetrie und Transitivität.','Halbordnungen, Verbände und Ordnungstheorie.','Spezialisiert auf Ordnungsstrukturen.','Erweitert die allgemeine Relationentheorie aus [27].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(29,'lang_undergraduate_analysis_1997','book','Undergraduate Analysis',1983,1997,NULL,'Springer','New York',
 NULL,NULL,NULL,'2nd Edition','en',4,'textbook',3,
 'needs_review','3.2.3','Lang, Serge: Undergraduate Analysis. 2nd Edition. New York: Springer, 1997.','Lang [29]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=29),
 'Systematisiert den Funktionsbegriff und die Grundlagen der Analysis.','Referenz für gerichtete Abbildungen und Funktionsklassen in 3.2.3.','Belegt die Verwendung von Funktionen als zentrale Transformationsstruktur.','Definitions- und Zielmenge, Bild, Injektivität, Surjektivität und Komposition.','Lehrbuchartige Sekundärdarstellung.','Ergänzt Rudin [30].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(30,'rudin_principles_analysis_1976','book','Principles of Mathematical Analysis',1953,1976,NULL,'McGraw-Hill','New York',
 NULL,NULL,NULL,'3rd Edition','en',5,'reference',3,
 'needs_review','3.2.3','Rudin, Walter: Principles of Mathematical Analysis. 3rd Edition. New York: McGraw-Hill, 1976.','Rudin [30]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=30),
 'Internationales Standardwerk der reellen und komplexen Analysis.','Mathematische Absicherung des Funktions- und Abbildungsbegriffs.','Belegt zentrale Definitionen und Eigenschaften von Funktionen.','Abbildungen, Folgen, Grenzwerte und Stetigkeit.','Konzentriert sich auf Analysis, nicht auf funktionale Genese.','Wird später durch Funktionalanalysis erweitert.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(31,'dummit_foote_abstract_algebra_2004','book','Abstract Algebra',1991,2004,NULL,'John Wiley & Sons','Hoboken',
 NULL,NULL,NULL,'3rd Edition','en',5,'reference',3,
 'needs_review','3.2.4','Dummit, David S.; Foote, Richard M.: Abstract Algebra. 3rd Edition. Hoboken: John Wiley & Sons, 2004.','Dummit und Foote [31]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=31),
 'Umfassendes Standardwerk zu Gruppen, Ringen, Körpern und Modulen.','Hauptreferenz für algebraische Strukturen in 3.2.4.','Belegt die axiomatische Definition algebraischer Verknüpfungen.','Gruppen, Ringe, Körper, Homomorphismen und Vektorräume.','Sekundärwerk; historische Originalarbeiten werden nicht vollständig diskutiert.','Ergänzt Lang [32] und Artin [34].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(32,'lang_algebra_2002','book','Algebra',1965,2002,NULL,'Springer','New York',
 NULL,NULL,NULL,'Revised 3rd Edition','en',5,'reference',3,
 'needs_review','3.2.4','Lang, Serge: Algebra. Revised 3rd Edition. New York: Springer, 2002.','Lang [32]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=32),
 'Internationales Referenzwerk der abstrakten Algebra.','Ergänzende Quelle für Gruppen, Körper und lineare Strukturen.','Absicherung algebraischer Definitionen und Strukturprinzipien.','Algebraische Strukturen und Verknüpfungsgesetze.','Hoher Abstraktionsgrad.','Vertieft die Darstellung aus [31].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(33,'hall_lie_groups_2015','book','Lie Groups, Lie Algebras, and Representations: An Elementary Introduction',2003,2015,NULL,'Springer','Cham',
 NULL,NULL,NULL,'2nd Edition','en',4,'reference',3,
 'needs_review','3.2.4','Hall, Brian C.: Lie Groups, Lie Algebras, and Representations: An Elementary Introduction. 2nd Edition. Cham: Springer, 2015.','Hall [33]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=33),
 'Stellt kontinuierliche Gruppen und ihre Darstellungen dar.','Belegt die Bedeutung algebraischer Symmetrien für mathematische Physik.','Dient zur Einordnung von Gruppen als Transformationsstrukturen.','Lie-Gruppen, Lie-Algebren und Darstellungen.','Spezialisierte Erweiterung der allgemeinen Algebra.','Verbindet Algebra und Operatorentheorie.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(34,'artin_algebra_2011','book','Algebra',1991,2011,NULL,'Pearson','Boston',
 NULL,NULL,NULL,'2nd Edition','en',4,'reference',3,
 'needs_review','3.2.4','Artin, Michael: Algebra. 2nd Edition. Boston: Pearson, 2011.','Artin [34]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=34),
 'Verbindet abstrakte Algebra mit linearer Algebra und Geometrie.','Referenz für Körper und Vektorräume.','Belegt die strukturelle Rolle algebraischer Operationen.','Gruppen, Ringe, Körper und lineare Abbildungen.','Sekundärdarstellung.','Ergänzt [31] und [32].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(35,'conway_functional_analysis_1990','book','A Course in Functional Analysis',1985,1990,NULL,'Springer','New York',
 NULL,NULL,NULL,'2nd Edition','en',5,'reference',4,
 'needs_review','3.2.5','Conway, John B.: A Course in Functional Analysis. 2nd Edition. New York: Springer, 1990.','Conway [35]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=35),
 'Standardwerk zu Operatoren auf Banach- und Hilberträumen.','Hauptreferenz für die Operatorentheorie in 3.2.5.','Belegt Operatorbegriff, Komposition und lineare Operatoren.','Lineare Operatoren, Spektraltheorie und Funktionenräume.','Setzt mathematische Räume bereits voraus.','Wird durch [36], [41] und [42] ergänzt.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(36,'kreyszig_functional_analysis_1978','book','Introductory Functional Analysis with Applications',1978,1978,NULL,'John Wiley & Sons','New York',
 NULL,NULL,NULL,NULL,'en',4,'textbook',3,
 'needs_review','3.2.5','Kreyszig, Erwin: Introductory Functional Analysis with Applications. New York: John Wiley & Sons, 1978.','Kreyszig [36]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=36),
 'Anwendungsorientierte Darstellung von Normen, Räumen und Operatoren.','Ergänzende Referenz für Linearität und Operatoranwendungen.','Dient zur verständlichen Absicherung funktionalanalytischer Grundbegriffe.','Normierte Räume, Banachräume, Hilberträume und Operatoren.','Lehrbuchcharakter.','Ergänzt Conway [35].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(37,'strogatz_nonlinear_dynamics_2015','book','Nonlinear Dynamics and Chaos',1994,2015,NULL,'Westview Press','Boulder',
 NULL,NULL,NULL,'2nd Edition','en',5,'reference',4,
 'needs_review','3.2.5','Strogatz, Steven H.: Nonlinear Dynamics and Chaos. 2nd Edition. Boulder: Westview Press, 2015.','Strogatz [37]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=37),
 'Standardwerk zu nichtlinearer Dynamik, Bifurkationen und Chaos.','Belegt die Rolle nichtlinearer Operatoren und rekursiver Systeme.','Dient zur Einordnung von Nichtlinearität und Iteration.','Fixpunkte, Bifurkationen, Attraktoren und Chaos.','Arbeitet in vorgegebenen Zustandsräumen.','Wird in 3.2.8 erneut verwendet.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(38,'sontag_control_theory_1998','book','Mathematical Control Theory: Deterministic Finite Dimensional Systems',1990,1998,NULL,'Springer','New York',
 NULL,NULL,NULL,'2nd Edition','en',5,'reference',4,
 'needs_review','3.2.6','Sontag, Eduardo D.: Mathematical Control Theory: Deterministic Finite Dimensional Systems. 2nd Edition. New York: Springer, 1998.','Sontag [38]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=38),
 'Systematisiert Zustandsraummodelle und Kontrollsysteme.','Hauptreferenz für Zustandsvektoren und Zustandsentwicklung.','Belegt die mathematische Formulierung deterministischer Zustandsräume.','Zustandsraum, Systemdynamik und Kontrollierbarkeit.','Beschränkt auf vorgegebene endlichdimensionale Systeme.','Wird durch nichtlineare und unendlichdimensionale Ansätze ergänzt.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(39,'khalil_nonlinear_systems_2002','book','Nonlinear Systems',1992,2002,NULL,'Prentice Hall','Upper Saddle River',
 NULL,NULL,NULL,'3rd Edition','en',5,'reference',4,
 'needs_review','3.2.6','Khalil, Hassan K.: Nonlinear Systems. 3rd Edition. Upper Saddle River: Prentice Hall, 2002.','Khalil [39]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=39),
 'Standardwerk zur Stabilität nichtlinearer Systeme.','Referenz für nichtlineare Zustandsraummodelle.','Belegt die Erweiterung linearer Zustandsmodelle.','Nichtlineare Systeme, Stabilität und Lyapunov-Methoden.','Setzt Zustandsraum und Dynamik voraus.','Ergänzt Sontag [38].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(40,'hirsch_smale_devaney_2013','book','Differential Equations, Dynamical Systems, and an Introduction to Chaos',1974,2013,NULL,'Academic Press','Amsterdam',
 NULL,NULL,NULL,'3rd Edition','en',5,'reference',4,
 'needs_review','3.2.6','Hirsch, Morris W.; Smale, Stephen; Devaney, Robert L.: Differential Equations, Dynamical Systems, and an Introduction to Chaos. 3rd Edition. Amsterdam: Academic Press, 2013.','Hirsch, Smale und Devaney [40]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=40),
 'Verbindet Differentialgleichungen, Phasenräume und Chaos.','Referenz für geometrische Zustandsraumdarstellungen.','Belegt Trajektorien, Fixpunkte und Attraktoren im Phasenraum.','Dynamische Systeme und qualitative Analyse.','Beschreibt Dynamik in vorgegebenen Räumen.','Bereitet 3.2.8 vor.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(41,'reed_simon_functional_analysis_1980','book','Methods of Modern Mathematical Physics. Vol. I: Functional Analysis',1972,1980,NULL,'Academic Press','New York',
 NULL,NULL,NULL,NULL,'en',5,'reference',4,
 'needs_review','3.2.7','Reed, Michael; Simon, Barry: Methods of Modern Mathematical Physics. Vol. I: Functional Analysis. New York: Academic Press, 1980.','Reed und Simon [41]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=41),
 'Referenzwerk zur Funktionalanalysis und mathematischen Physik.','Hauptquelle für Hilberträume und Operatoren in 3.2.7.','Belegt unendlichdimensionale Zustandsräume der mathematischen Physik.','Hilberträume, Operatoren und Spektraltheorie.','Setzt Funktionenräume und deren Struktur voraus.','Ergänzt Conway [35] und Yosida [42].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(42,'yosida_functional_analysis_1980','book','Functional Analysis',1965,1980,NULL,'Springer','Berlin',
 NULL,NULL,NULL,'6th Edition','en',5,'reference',4,
 'needs_review','3.2.7','Yosida, Kôsaku: Functional Analysis. 6th Edition. Berlin: Springer, 1980.','Yosida [42]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=42),
 'Klassisches Referenzwerk zur Funktionalanalysis und Operatorhalbgruppen.','Ergänzende Quelle für Banach- und Hilberträume.','Belegt Vollständigkeit, Operatoren und Funktionenräume.','Funktionalanalysis und lineare Operatoren.','Hoher Abstraktionsgrad.','Ergänzt [35], [36] und [41].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(43,'katok_hasselblatt_dynamical_1995','book','Introduction to the Modern Theory of Dynamical Systems',1995,1995,NULL,'Cambridge University Press','Cambridge',
 NULL,NULL,NULL,NULL,'en',5,'reference',4,
 'needs_review','3.2.8','Katok, Anatole; Hasselblatt, Boris: Introduction to the Modern Theory of Dynamical Systems. Cambridge: Cambridge University Press, 1995.','Katok und Hasselblatt [43]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=43),
 'Umfassendes Referenzwerk der modernen Dynamik.','Hauptquelle für Flüsse, Iterationen und langfristiges Verhalten.','Belegt den mathematischen Rahmen dynamischer Systeme.','Diskrete und kontinuierliche Dynamik, Ergodentheorie und Hyperbolizität.','Setzt Raum und Dynamik voraus.','Ergänzt Strogatz [37] und Ott [44].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(44,'ott_chaos_2002','book','Chaos in Dynamical Systems',1993,2002,NULL,'Cambridge University Press','Cambridge',
 NULL,NULL,NULL,'2nd Edition','en',5,'reference',4,
 'needs_review','3.2.8','Ott, Edward: Chaos in Dynamical Systems. 2nd Edition. Cambridge: Cambridge University Press, 2002.','Ott [44]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=44),
 'Referenzwerk zu Chaos, Attraktoren und Lyapunov-Exponenten.','Belegt empfindliche Anfangswertabhängigkeit in 3.2.8.','Dient zur Definition chaotischer Divergenz.','Chaotische Attraktoren und Lyapunov-Exponenten.','Beschreibt keine Genese des Zustandsraums.','Ergänzt [37] und [43].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(45,'cover_thomas_information_2006','book','Elements of Information Theory',1991,2006,NULL,'John Wiley & Sons','Hoboken',
 NULL,NULL,NULL,'2nd Edition','en',5,'reference',4,
 'needs_review','3.2.9','Cover, Thomas M.; Thomas, Joy A.: Elements of Information Theory. 2nd Edition. Hoboken: John Wiley & Sons, 2006.','Cover und Thomas [45]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=45),
 'Internationales Standardwerk der Informationstheorie.','Referenz für Entropie, gegenseitige Information und Divergenzen.','Belegt die mathematische Quantifizierung von Unsicherheit.','Entropie, gemeinsame Entropie, gegenseitige Information und Codierung.','Semantische und funktionale Bedeutung bleiben außerhalb des Formalismus.','Systematisiert Shannons Primärarbeit [46].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(46,'shannon_communication_1948','journal_article','A Mathematical Theory of Communication',1948,1948,'Bell System Technical Journal',NULL,NULL,
 '27',NULL,'379–423; 623–656',NULL,'en',5,'primary',5,
 'needs_review','3.2.9','Shannon, Claude E.: A Mathematical Theory of Communication. Bell System Technical Journal, 27, 1948, S. 379–423 und 623–656.','Shannon [46]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=46),
 'Begründet die mathematische Informationstheorie.','Primärquelle für Informationsgehalt und Shannon-Entropie.','Belegt die statistische Quantifizierung von Information.','Informationsgehalt, Entropie, Kanal und Kapazität.','Abstrahiert bewusst von semantischer Bedeutung.','Wird durch Cover und Thomas [45] systematisiert.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(47,'diestel_graph_theory_2017','book','Graph Theory',1997,2017,NULL,'Springer','Berlin',
 NULL,NULL,NULL,'5th Edition','en',5,'reference',4,
 'needs_review','3.2.10','Diestel, Reinhard: Graph Theory. 5th Edition. Berlin: Springer, 2017.','Diestel [47]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=47),
 'Internationales Standardwerk der Graphentheorie.','Hauptreferenz für Graphen, Knoten, Kanten und Pfade.','Belegt die formale Graphdefinition.','Graphen, Pfade, Zusammenhang und strukturelle Eigenschaften.','Statische Grundstruktur; dynamische Genese nicht behandelt.','Wird durch Newman [48] und Barabási [15] ergänzt.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(48,'newman_networks_2018','book','Networks',2010,2018,NULL,'Oxford University Press','Oxford',
 NULL,NULL,NULL,'2nd Edition','en',5,'reference',4,
 'needs_review','3.2.10','Newman, Mark: Networks. 2nd Edition. Oxford: Oxford University Press, 2018.','Newman [48]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=48),
 'Umfassendes Referenzwerk zu komplexen Netzwerken.','Referenz für Zentralitäten und Netzwerkanalyse.','Belegt Gradzentralität und strukturelle Netzwerkeigenschaften.','Zentralität, Gemeinschaften und Netzwerkmodelle.','Setzt Knoten und Kanten voraus.','Ergänzt Diestel [47] und Barabási [15].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(49,'burago_metric_geometry_2001','book','A Course in Metric Geometry',2001,2001,NULL,'American Mathematical Society','Providence',
 NULL,NULL,NULL,NULL,'en',5,'reference',4,
 'needs_review','3.2.11','Burago, Dmitri; Burago, Yuri; Ivanov, Sergei: A Course in Metric Geometry. Providence: American Mathematical Society, 2001.','Burago, Burago und Ivanov [49]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=49),
 'Standardwerk der metrischen Geometrie.','Hauptquelle für Metrikaxiome und Minkowski-Distanzen.','Belegt die formale Definition metrischer Räume.','Metriken, geodätische Räume und metrische Geometrie.','Beschreibt Abstände, nicht deren funktionale Genese.','Grundlage für 3.2.11.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(50,'manning_raghavan_schuetze_2008','book','Introduction to Information Retrieval',2008,2008,NULL,'Cambridge University Press','Cambridge',
 NULL,NULL,NULL,NULL,'en',4,'reference',3,
 'needs_review','3.2.11','Manning, Christopher D.; Raghavan, Prabhakar; Schütze, Hinrich: Introduction to Information Retrieval. Cambridge: Cambridge University Press, 2008.','Manning, Raghavan und Schütze [50]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=50),
 'Standardwerk zu Vektorraummodellen und Kosinusähnlichkeit.','Referenz für semantische Ähnlichkeitsmaße.','Belegt die Verwendung der Kosinusähnlichkeit im Information Retrieval.','Vektorraummodell, Kosinusähnlichkeit und Retrieval.','Anwendungsbezogene Sekundärquelle.','Verbindet Metrik mit semantischen Vektorräumen.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(51,'camazine_self_organization_2001','book','Self-Organization in Biological Systems',2001,2001,NULL,'Princeton University Press','Princeton',
 NULL,NULL,NULL,NULL,'en',5,'reference',4,
 'needs_review','3.2.12','Camazine, Scott; Deneubourg, Jean-Louis; Franks, Nigel R.; Sneyd, James; Theraulaz, Guy; Bonabeau, Eric: Self-Organization in Biological Systems. Princeton: Princeton University Press, 2001.','Camazine et al. [51]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=51),
 'Systematisiert Selbstorganisation in biologischen Systemen.','Hauptreferenz für lokale Interaktionen und globale Ordnungsbildung.','Belegt Selbstorganisation ohne zentrale Steuerung.','Lokale Regeln, Rückkopplung und Musterbildung.','Setzt Agenten und Wechselwirkungsregeln voraus.','Ergänzt Haken [12] und Holland [14].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,
 language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,
 full_citation_text,short_citation_text)
VALUES
(52,'mitchell_complexity_2009','book','Complexity: A Guided Tour',2009,2009,NULL,'Oxford University Press','Oxford',
 NULL,NULL,NULL,NULL,'en',4,'secondary',3,
 'needs_review','3.2.12','Mitchell, Melanie: Complexity: A Guided Tour. Oxford: Oxford University Press, 2009.','Mitchell [52]')
ON DUPLICATE KEY UPDATE
 source_key=VALUES(source_key),
 title=VALUES(title),
 year_original=VALUES(year_original),
 year_edition=VALUES(year_edition),
 journal=VALUES(journal),
 publisher=VALUES(publisher),
 place=VALUES(place),
 volume=VALUES(volume),
 issue=VALUES(issue),
 pages=VALUES(pages),
 edition=VALUES(edition),
 priority=VALUES(priority),
 evidence_type=VALUES(evidence_type),
 frzk_relevance=VALUES(frzk_relevance),
 first_citation_section_code=VALUES(first_citation_section_code),
 full_citation_text=VALUES(full_citation_text),
 short_citation_text=VALUES(short_citation_text);

INSERT INTO annotations
(source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,
 limitations,scientific_discussion,annotation_status,reviewed_at)
VALUES
((SELECT source_id FROM sources WHERE citation_number=52),
 'Überblick über Komplexität, Emergenz und adaptive Systeme.','Ergänzende Quelle für den Emergenzbegriff.','Belegt das Auftreten globaler Eigenschaften aus lokalen Regeln.','Komplexität, Emergenz und Berechnung.','Übersichtswerk, keine mathematische Primärquelle.','Ergänzt [12], [14] und [51].',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 contribution=VALUES(contribution),
 significance_for_dissertation=VALUES(significance_for_dissertation),
 citation_reason=VALUES(citation_reason),
 adopted_claims=VALUES(adopted_claims),
 limitations=VALUES(limitations),
 scientific_discussion=VALUES(scientific_discussion),
 annotation_status='reviewed',
 reviewed_at=NOW();


-- ------------------------------------------------------------
-- Quellenverwendungen des Kapitels 3.2 konsistent neu aufbauen
-- ------------------------------------------------------------
DELETE su
FROM source_usage su
JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE ds.section_code LIKE '3.2%';

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=23),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'first_citation','Verwendung von Quelle [23] im Abschnitt 3.2.1.',CONCAT('Abschnitt ','3.2.1'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=24),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'first_citation','Verwendung von Quelle [24] im Abschnitt 3.2.1.',CONCAT('Abschnitt ','3.2.1'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=25),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'first_citation','Verwendung von Quelle [25] im Abschnitt 3.2.1.',CONCAT('Abschnitt ','3.2.1'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=26),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'first_citation','Verwendung von Quelle [26] im Abschnitt 3.2.1.',CONCAT('Abschnitt ','3.2.1'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=27),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'first_citation','Verwendung von Quelle [27] im Abschnitt 3.2.2.',CONCAT('Abschnitt ','3.2.2'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=28),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'first_citation','Verwendung von Quelle [28] im Abschnitt 3.2.2.',CONCAT('Abschnitt ','3.2.2'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=29),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'first_citation','Verwendung von Quelle [29] im Abschnitt 3.2.3.',CONCAT('Abschnitt ','3.2.3'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=30),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'first_citation','Verwendung von Quelle [30] im Abschnitt 3.2.3.',CONCAT('Abschnitt ','3.2.3'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=31),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'first_citation','Verwendung von Quelle [31] im Abschnitt 3.2.4.',CONCAT('Abschnitt ','3.2.4'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=32),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'first_citation','Verwendung von Quelle [32] im Abschnitt 3.2.4.',CONCAT('Abschnitt ','3.2.4'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=33),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'first_citation','Verwendung von Quelle [33] im Abschnitt 3.2.4.',CONCAT('Abschnitt ','3.2.4'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=34),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'first_citation','Verwendung von Quelle [34] im Abschnitt 3.2.4.',CONCAT('Abschnitt ','3.2.4'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=35),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'first_citation','Verwendung von Quelle [35] im Abschnitt 3.2.5.',CONCAT('Abschnitt ','3.2.5'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=36),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'first_citation','Verwendung von Quelle [36] im Abschnitt 3.2.5.',CONCAT('Abschnitt ','3.2.5'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=37),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'first_citation','Verwendung von Quelle [37] im Abschnitt 3.2.5.',CONCAT('Abschnitt ','3.2.5'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=38),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'first_citation','Verwendung von Quelle [38] im Abschnitt 3.2.6.',CONCAT('Abschnitt ','3.2.6'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=39),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'first_citation','Verwendung von Quelle [39] im Abschnitt 3.2.6.',CONCAT('Abschnitt ','3.2.6'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=40),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'first_citation','Verwendung von Quelle [40] im Abschnitt 3.2.6.',CONCAT('Abschnitt ','3.2.6'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=41),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'first_citation','Verwendung von Quelle [41] im Abschnitt 3.2.7.',CONCAT('Abschnitt ','3.2.7'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=42),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'first_citation','Verwendung von Quelle [42] im Abschnitt 3.2.7.',CONCAT('Abschnitt ','3.2.7'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=35),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'background','Verwendung von Quelle [35] im Abschnitt 3.2.7.',CONCAT('Abschnitt ','3.2.7'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=36),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'background','Verwendung von Quelle [36] im Abschnitt 3.2.7.',CONCAT('Abschnitt ','3.2.7'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=43),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'first_citation','Verwendung von Quelle [43] im Abschnitt 3.2.8.',CONCAT('Abschnitt ','3.2.8'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=44),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'first_citation','Verwendung von Quelle [44] im Abschnitt 3.2.8.',CONCAT('Abschnitt ','3.2.8'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=37),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'background','Verwendung von Quelle [37] im Abschnitt 3.2.8.',CONCAT('Abschnitt ','3.2.8'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=45),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'first_citation','Verwendung von Quelle [45] im Abschnitt 3.2.9.',CONCAT('Abschnitt ','3.2.9'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=46),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'first_citation','Verwendung von Quelle [46] im Abschnitt 3.2.9.',CONCAT('Abschnitt ','3.2.9'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=47),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'first_citation','Verwendung von Quelle [47] im Abschnitt 3.2.10.',CONCAT('Abschnitt ','3.2.10'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=48),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'first_citation','Verwendung von Quelle [48] im Abschnitt 3.2.10.',CONCAT('Abschnitt ','3.2.10'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=15),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'background','Verwendung von Quelle [15] im Abschnitt 3.2.10.',CONCAT('Abschnitt ','3.2.10'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=49),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'first_citation','Verwendung von Quelle [49] im Abschnitt 3.2.11.',CONCAT('Abschnitt ','3.2.11'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=50),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'first_citation','Verwendung von Quelle [50] im Abschnitt 3.2.11.',CONCAT('Abschnitt ','3.2.11'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=51),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'first_citation','Verwendung von Quelle [51] im Abschnitt 3.2.12.',CONCAT('Abschnitt ','3.2.12'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=52),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'first_citation','Verwendung von Quelle [52] im Abschnitt 3.2.12.',CONCAT('Abschnitt ','3.2.12'),1,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=12),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'background','Verwendung von Quelle [12] im Abschnitt 3.2.12.',CONCAT('Abschnitt ','3.2.12'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=14),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'background','Verwendung von Quelle [14] im Abschnitt 3.2.12.',CONCAT('Abschnitt ','3.2.12'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=23),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [23] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=24),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [24] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=27),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [27] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=29),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [29] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=31),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [31] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=35),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [35] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=38),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [38] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=41),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [41] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=43),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [43] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=45),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [45] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=47),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [47] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=49),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [49] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=51),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [51] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=12),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [12] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=14),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [14] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=15),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'research_gap','Verwendung von Quelle [15] im Abschnitt 3.2.13.',CONCAT('Abschnitt ','3.2.13'),0,FALSE,
 'Automatisch durch Kapitelabschluss-Revision registriert.');

-- ------------------------------------------------------------
-- Korrektur der in der Rohfassung doppelt oder verschoben vergebenen Nummern
-- ------------------------------------------------------------
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[49]','[15]','3.2.10','Barabási wurde bereits in 3.1 unter [15] erfasst und darf nicht erneut als [49] geführt werden.',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[50]','[49]','3.2.11','Burago et al. verschieben sich nach der Dublettenbereinigung auf [49].',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[51]','[50]','3.2.11','Manning et al. verschieben sich nach der Dublettenbereinigung auf [50].',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[52]','[51]','3.2.12','Camazine et al. verschieben sich nach der Dublettenbereinigung auf [51].',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[53]','[52]','3.2.12','Mitchell verschiebt sich nach der Dublettenbereinigung auf [52].',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[54]','[12]','3.2.12','Haken wurde bereits in 3.1 unter [12] erfasst.',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);
INSERT INTO citation_corrections
(old_citation_label,corrected_citation_label,section_code,reason,revision_id)
VALUES ('[55]','[14]','3.2.12','Holland wurde bereits in 3.1 unter [14] erfasst.',@revision_id)
ON DUPLICATE KEY UPDATE
 corrected_citation_label=VALUES(corrected_citation_label),
 reason=VALUES(reason),
 revision_id=VALUES(revision_id);

-- ------------------------------------------------------------
-- Gleichungen (3.3) bis (3.86)
-- Vorhandene Einträge dieses Nummernbereichs werden aktualisiert.
-- ------------------------------------------------------------

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.3',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Mengenbildung','M=\\{x\\mid x\\ \\text{erfüllt Eigenschaft}\\ P\\}','M=\\{x\\mid x\\ \\text{erfüllt Eigenschaft}\\ P\\}','Definition einer Menge über eine charakteristische Eigenschaft.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=25),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.4',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Elementrelation','x\\in M','x\\in M','Zugehörigkeit eines Elements zu einer Menge.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=25),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.5',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Nichtzugehörigkeit','x\\notin M','x\\notin M','Nichtzugehörigkeit eines Elements zu einer Menge.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=25),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.6',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Teilmengenrelation','A\\subseteq B','A\\subseteq B','A ist Teilmenge von B.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=25),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.7',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Logische Teilmengenbedingung','\\forall x\\,(x\\in A\\Rightarrow x\\in B)','\\forall x\\,(x\\in A\\Rightarrow x\\in B)','Logische Bedingung der Teilmengenbeziehung.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=25),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.8',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Extensionalitätsprinzip','A=B\\Longleftrightarrow\\forall x\\,(x\\in A\\Leftrightarrow x\\in B)','A=B\\Longleftrightarrow\\forall x\\,(x\\in A\\Leftrightarrow x\\in B)','Mengen sind genau dann gleich, wenn sie dieselben Elemente besitzen.','theorem','literature',(SELECT source_id FROM sources WHERE citation_number=24),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.9',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Relation zwischen Mengen','R\\subseteq A\\times B','R\\subseteq A\\times B','Relation als Teilmenge eines kartesischen Produkts.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=27),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.10',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Relation auf einer Menge','R\\subseteq A\\times A','R\\subseteq A\\times A','Binäre Relation auf derselben Grundmenge.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=27),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.11',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Relationsnotation','aRb\\Longleftrightarrow(a,b)\\in R','aRb\\Longleftrightarrow(a,b)\\in R','Äquivalenz zwischen Kurznotation und geordnetem Paar.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=27),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.12',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Reflexivität','\\forall a\\in A:\\;aRa','\\forall a\\in A:\\;aRa','Reflexivität einer Relation.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=28),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.13',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Symmetrie','aRb\\Rightarrow bRa','aRb\\Rightarrow bRa','Symmetrie einer Relation.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=28),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.14',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Transitivität','(aRb)\\land(bRc)\\Rightarrow aRc','(aRb)\\land(bRc)\\Rightarrow aRc','Transitivität einer Relation.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=28),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.15',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Äquivalenzklasse','[a]=\\{x\\in A\\mid x\\sim a\\}','[a]=\\{x\\in A\\mid x\\sim a\\}','Äquivalenzklasse eines Elements.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=27),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.16',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Halbordnungsrelation','a\\preceq b','a\\preceq b','Notation einer Halbordnung.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=28),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.17',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Funktion','f:A\\rightarrow B','f:A\\rightarrow B','Abbildung von der Definitionsmenge in die Zielmenge.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=29),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.18',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Eindeutige Zuordnung','\\forall x\\in A\\;\\exists!\\,y\\in B:f(x)=y','\\forall x\\in A\\;\\exists!\\,y\\in B:f(x)=y','Jedem Element wird genau ein Bild zugeordnet.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=29),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.19',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Bildmenge','f(A)=\\{f(x)\\mid x\\in A\\}','f(A)=\\{f(x)\\mid x\\in A\\}','Bild einer Menge unter einer Funktion.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=29),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.20',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Injektivität','f(x_1)=f(x_2)\\Rightarrow x_1=x_2','f(x_1)=f(x_2)\\Rightarrow x_1=x_2','Definition der Injektivität.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=30),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.21',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Surjektivität','\\forall y\\in B\\;\\exists x\\in A:f(x)=y','\\forall y\\in B\\;\\exists x\\in A:f(x)=y','Definition der Surjektivität.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=30),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.22',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Bijektion','f:A\\leftrightarrow B','f:A\\leftrightarrow B','Kurznotation einer bijektiven Abbildung.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=30),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.23',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Funktionskomposition','(g\\circ f)(x)=g(f(x))','(g\\circ f)(x)=g(f(x))','Komposition zweier Funktionen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=29),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.24',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Innere Verknüpfung','\\ast:A\\times A\\rightarrow A','\\ast:A\\times A\\rightarrow A','Binäre algebraische Verknüpfung.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=31),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.25',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Abbildungsregel der Verknüpfung','(a,b)\\longmapsto a\\ast b','(a,b)\\longmapsto a\\ast b','Zuordnung eines Paares zum Verknüpfungsergebnis.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=31),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.26',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Assoziativität','(a\\ast b)\\ast c=a\\ast(b\\ast c)','(a\\ast b)\\ast c=a\\ast(b\\ast c)','Assoziativgesetz.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=31),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.27',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Neutrales Element','a\\ast e=e\\ast a=a','a\\ast e=e\\ast a=a','Definition eines neutralen Elements.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=31),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.28',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Inverses Element','a\\ast a^{-1}=a^{-1}\\ast a=e','a\\ast a^{-1}=a^{-1}\\ast a=e','Definition eines inversen Elements.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=31),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.29',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Vektoraddition','+:V\\times V\\rightarrow V','+:V\\times V\\rightarrow V','Innere Addition im Vektorraum.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=34),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.30',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Skalarmultiplikation','\\cdot:K\\times V\\rightarrow V','\\cdot:K\\times V\\rightarrow V','Skalarmultiplikation im Vektorraum.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=34),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.31',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operator','T:X\\rightarrow Y','T:X\\rightarrow Y','Allgemeine Operatordefinition.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=35),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.32',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operatorwirkung','y=T(x)','y=T(x)','Wirkung eines Operators auf ein Element.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=35),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.33',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Linearität','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','Linearitätsbedingung eines Operators.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=35),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.34',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Nichtlinearität','T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)','T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)','Abgrenzung eines nichtlinearen Operators.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=37),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.35',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operatorkomposition','(T\\circ S)(x)=T(S(x))','(T\\circ S)(x)=T(S(x))','Komposition zweier Operatoren.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=35),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.36',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operatoriteration','x_{n+1}=T(x_n)','x_{n+1}=T(x_n)','Rekursive Anwendung eines Operators.','model','literature',(SELECT source_id FROM sources WHERE citation_number=37),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.37',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Zustandsvektor','X=\\left(x_1,x_2,\\ldots,x_n\\right)^T','X=\\left(x_1,x_2,\\ldots,x_n\\right)^T','Vektorielle Darstellung eines Systemzustands.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=38),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.38',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Zustandsraum','\\mathcal{X}=\\left\\{X\\mid X\\text{ zulässig}\\right\\}','\\mathcal{X}=\\left\\{X\\mid X\\text{ zulässig}\\right\\}','Menge aller zulässigen Systemzustände.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=38),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.39',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Diskrete Zustandsentwicklung','X(t+\\Delta t)=F\\!\\left(X(t)\\right)','X(t+\\Delta t)=F\\!\\left(X(t)\\right)','Diskrete Zustandsentwicklung.','model','literature',(SELECT source_id FROM sources WHERE citation_number=38),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.40',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Kontinuierliche Zustandsentwicklung','\\frac{dX}{dt}=F(X,t)','\\frac{dX}{dt}=F(X,t)','Kontinuierliches Zustandsraummodell.','model','literature',(SELECT source_id FROM sources WHERE citation_number=38),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.41',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Lineares Zustandsraummodell','\\frac{dX}{dt}=AX','\\frac{dX}{dt}=AX','Lineare Zustandsdynamik.','model','literature',(SELECT source_id FROM sources WHERE citation_number=38),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.42',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Lösung des linearen Systems','X(t)=e^{At}X(0)','X(t)=e^{At}X(0)','Formale Lösung eines autonomen linearen Systems.','derived','literature',(SELECT source_id FROM sources WHERE citation_number=38),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.43',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Nichtlineares Zustandsraummodell','\\frac{dX}{dt}=F(X)','\\frac{dX}{dt}=F(X)','Autonome nichtlineare Zustandsdynamik.','model','literature',(SELECT source_id FROM sources WHERE citation_number=39),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.44',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Addition von Funktionen','(f+g)(x)=f(x)+g(x)','(f+g)(x)=f(x)+g(x)','Punktweise Addition von Funktionen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=41),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.45',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Skalarmultiplikation von Funktionen','(\\alpha f)(x)=\\alpha\\,f(x)','(\\alpha f)(x)=\\alpha\\,f(x)','Punktweise Skalarmultiplikation.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=41),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.46',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Positivität der Norm','\\|f\\|\\ge0,\\qquad\\|f\\|=0\\Longleftrightarrow f=0','\\|f\\|\\ge0,\\qquad\\|f\\|=0\\Longleftrightarrow f=0','Positivität und Definitheit einer Norm.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=42),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.47',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Dreiecksungleichung der Norm','\\|f+g\\|\\le\\|f\\|+\\|g\\|','\\|f+g\\|\\le\\|f\\|+\\|g\\|','Dreiecksungleichung einer Norm.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=42),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.48',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Cauchy-Bedingung','\\forall\\varepsilon>0\\;\\exists N:m,n>N\\Rightarrow\\|f_n-f_m\\|<\\varepsilon','\\forall\\varepsilon>0\\;\\exists N:m,n>N\\Rightarrow\\|f_n-f_m\\|<\\varepsilon','Cauchy-Bedingung in einem normierten Raum.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=42),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.49',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Skalarprodukt','\\langle f,g\\rangle','\\langle f,g\\rangle','Skalarprodukt zweier Elemente.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=41),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.50',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Induzierte Norm','\\|f\\|=\\sqrt{\\langle f,f\\rangle}','\\|f\\|=\\sqrt{\\langle f,f\\rangle}','Durch ein Skalarprodukt induzierte Norm.','derived','literature',(SELECT source_id FROM sources WHERE citation_number=41),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.51',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Allgemeines dynamisches System','\\frac{dX}{dt}=F(X,t)','\\frac{dX}{dt}=F(X,t)','Allgemeine kontinuierliche Dynamik.','model','literature',(SELECT source_id FROM sources WHERE citation_number=43),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.52',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Diskrete Dynamik','X_{n+1}=F(X_n)','X_{n+1}=F(X_n)','Diskrete rekursive Systementwicklung.','model','literature',(SELECT source_id FROM sources WHERE citation_number=43),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.53',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Fixpunkt','F(X^\\ast)=X^\\ast','F(X^\\ast)=X^\\ast','Fixpunktbedingung.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=43),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.54',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Asymptotische Stabilität','\\lim_{t\\rightarrow\\infty}X(t)=X^\\ast','\\lim_{t\\rightarrow\\infty}X(t)=X^\\ast','Konvergenz gegen einen stabilen Fixpunkt.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=43),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.55',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Attraktorbedingung','\\operatorname{dist}(X(t),A)\\longrightarrow0\\qquad(t\\rightarrow\\infty)','\\operatorname{dist}(X(t),A)\\longrightarrow0\\qquad(t\\rightarrow\\infty)','Annäherung an einen Attraktor.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=44),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.56',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Parametrisierte Dynamik','\\frac{dX}{dt}=F(X,\\mu)','\\frac{dX}{dt}=F(X,\\mu)','Dynamik mit Steuerparameter.','model','literature',(SELECT source_id FROM sources WHERE citation_number=37),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.57',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Lyapunov-Divergenz','\\delta(t)\\approx\\delta_0e^{\\lambda t}','\\delta(t)\\approx\\delta_0e^{\\lambda t}','Exponentielle Divergenz benachbarter Trajektorien.','model','literature',(SELECT source_id FROM sources WHERE citation_number=44),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.58',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Informationsgehalt','I(x)=-\\log_{2}p(x)','I(x)=-\\log_{2}p(x)','Informationsgehalt eines Ereignisses.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=46),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.59',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Shannon-Entropie','H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i','H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i','Mittlere Unsicherheit einer Zufallsvariablen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=46),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.60',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Gemeinsame Entropie','H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)','H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)','Gemeinsame Entropie zweier Zufallsvariablen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=45),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.61',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Gegenseitige Information','I(X;Y)=H(X)+H(Y)-H(X,Y)','I(X;Y)=H(X)+H(Y)-H(X,Y)','Statistische Abhängigkeit zweier Zufallsvariablen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=45),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.62',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Kullback-Leibler-Divergenz','D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}','D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}','Divergenz zweier Wahrscheinlichkeitsverteilungen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=45),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.63',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Graph','G=(V,E)','G=(V,E)','Definition eines Graphen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=47),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.64',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Gerichtete Kantenmenge','E\\subseteq V\\times V','E\\subseteq V\\times V','Kanten als gerichtete Relationen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=47),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.65',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Knotengrad','\\deg(v)=|\\{u\\in V\\mid(u,v)\\in E\\}|','\\deg(v)=|\\{u\\in V\\mid(u,v)\\in E\\}|','Grad eines Knotens.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=47),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.66',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Adjazenzmatrix','A=(a_{ij})','A=(a_{ij})','Matrixdarstellung eines Graphen.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=47),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.67',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Adjazenzmatrixelement','a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}','a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}','Eintrag der Adjazenzmatrix.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=47),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.68',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Pfad','P=(v_1,v_2,\\ldots,v_n)','P=(v_1,v_2,\\ldots,v_n)','Folge verbundener Knoten.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=47),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.69',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Gradzentralität','C_D(v)=\\frac{\\deg(v)}{|V|-1}','C_D(v)=\\frac{\\deg(v)}{|V|-1}','Normierte Gradzentralität.','metric','literature',(SELECT source_id FROM sources WHERE citation_number=48),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.70',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Metrik','d:X\\times X\\rightarrow\\mathbb{R}','d:X\\times X\\rightarrow\\mathbb{R}','Allgemeine Metrikfunktion.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.71',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Nichtnegativität','d(x,y)\\ge0','d(x,y)\\ge0','Nichtnegativitätsaxiom einer Metrik.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.72',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Identität','d(x,y)=0\\Longleftrightarrow x=y','d(x,y)=0\\Longleftrightarrow x=y','Identitätsaxiom einer Metrik.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.73',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Symmetrie der Metrik','d(x,y)=d(y,x)','d(x,y)=d(y,x)','Symmetrieaxiom einer Metrik.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.74',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Dreiecksungleichung der Metrik','d(x,z)\\le d(x,y)+d(y,z)','d(x,z)\\le d(x,y)+d(y,z)','Dreiecksungleichung einer Metrik.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.75',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Euklidische Distanz','d_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}','d_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}','Euklidischer Abstand zweier Vektoren.','metric','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.76',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Minkowski-Metrik','d_p(x,y)=\\left(\\sum_{i=1}^{n}|x_i-y_i|^p\\right)^{1/p}','d_p(x,y)=\\left(\\sum_{i=1}^{n}|x_i-y_i|^p\\right)^{1/p}','Allgemeine Minkowski-Metrik.','metric','literature',(SELECT source_id FROM sources WHERE citation_number=49),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.77',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Kosinusähnlichkeit','\\operatorname{cos}(x,y)=\\frac{x\\cdot y}{\\|x\\|\\;\\|y\\|}','\\operatorname{cos}(x,y)=\\frac{x\\cdot y}{\\|x\\|\\;\\|y\\|}','Winkelbasierte Ähnlichkeit zweier Vektoren.','metric','literature',(SELECT source_id FROM sources WHERE citation_number=50),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.78',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Pearson-Korrelation','r=\\frac{\\sum_{i=1}^{n}(x_i-\\bar{x})(y_i-\\bar{y})}{\\sqrt{\\sum_{i=1}^{n}(x_i-\\bar{x})^2}\\sqrt{\\sum_{i=1}^{n}(y_i-\\bar{y})^2}}','r=\\frac{\\sum_{i=1}^{n}(x_i-\\bar{x})(y_i-\\bar{y})}{\\sqrt{\\sum_{i=1}^{n}(x_i-\\bar{x})^2}\\sqrt{\\sum_{i=1}^{n}(y_i-\\bar{y})^2}}','Linearer Korrelationskoeffizient.','metric','literature',(SELECT source_id FROM sources WHERE citation_number=50),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.79',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Gekoppelte Systemdynamik','\\frac{dX}{dt}=F(X)+C(X)','\\frac{dX}{dt}=F(X)+C(X)','Dynamik eines Systems mit Kopplungsterm.','model','literature',(SELECT source_id FROM sources WHERE citation_number=51),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.80',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Rekursive Selbstorganisation','X_{n+1}=F(X_n,X_n^{\\,\\mathrm{Umgebung}})','X_{n+1}=F(X_n,X_n^{\\,\\mathrm{Umgebung}})','Zustandsentwicklung unter Einbeziehung der Umgebung.','model','literature',(SELECT source_id FROM sources WHERE citation_number=51),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.81',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Ordnungsparameter','\\eta=\\Phi(X)','\\eta=\\Phi(X)','Makroskopischer Ordnungsparameter als Funktion des Gesamtzustands.','definition','literature',(SELECT source_id FROM sources WHERE citation_number=12),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.82',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Attraktordynamik','X(t)\\longrightarrow A,\\qquad t\\rightarrow\\infty','X(t)\\longrightarrow A,\\qquad t\\rightarrow\\infty','Langfristige Entwicklung zu einem Attraktor.','model','literature',(SELECT source_id FROM sources WHERE citation_number=12),'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.83',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Allgemeines mathematisches Modell','\\mathcal{M}=(M,R,F,O,\\mathcal{X})','\\mathcal{M}=(M,R,F,O,\\mathcal{X})','Schematische Zusammenfassung vorausgesetzter Modellbestandteile.','schema','original',NULL,'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.84',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Klassische Modellrichtung','\\mathcal{M}\\Longrightarrow\\text{Analyse}(\\mathcal{M})','\\mathcal{M}\\Longrightarrow\\text{Analyse}(\\mathcal{M})','Klassische Analyse eines bereits gegebenen Modells.','schema','original',NULL,'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.85',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Forschungslücke','?\\Longrightarrow\\mathcal{M}','?\\Longrightarrow\\mathcal{M}','Offene Frage nach der Genese des mathematischen Modells.','schema','original',NULL,'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status)
VALUES
('3.86',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Funktionale Entwicklungsrichtung','\\mathcal{F}\\Longrightarrow\\mathcal{M}\\Longrightarrow\\mathcal{P}','\\mathcal{F}\\Longrightarrow\\mathcal{M}\\Longrightarrow\\mathcal{P}','Funktionale Wechselwirkungen erzeugen mathematische Strukturen und physikalische Manifestationen.','schema','original',NULL,'checked')
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance=VALUES(provenance),
 source_id=VALUES(source_id),
 validation_status='checked';

-- ------------------------------------------------------------
-- Globales Symbolverzeichnis
-- ------------------------------------------------------------

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('M','M','Menge','Allgemeine Menge mathematischer Objekte.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 (SELECT equation_id FROM equations WHERE equation_number='3.3'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('A','A','Grundmenge oder Matrix','Kontextabhängig eine Menge oder Systemmatrix.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 (SELECT equation_id FROM equations WHERE equation_number='3.6'),
 0,1,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('B','B','Ziel- oder Vergleichsmenge','Kontextabhängig eine mathematische Menge.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 (SELECT equation_id FROM equations WHERE equation_number='3.6'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('R','R','Relation','Binäre Relation zwischen mathematischen Elementen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 (SELECT equation_id FROM equations WHERE equation_number='3.9'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('f','f','Funktion','Eindeutige Abbildung zwischen Mengen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 (SELECT equation_id FROM equations WHERE equation_number='3.17'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('T','T','Operator','Transformation zwischen mathematischen Räumen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 (SELECT equation_id FROM equations WHERE equation_number='3.31'),
 0,0,1,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('X','X','Zustandsvektor','Vollständiger Zustand eines Systems.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 (SELECT equation_id FROM equations WHERE equation_number='3.37'),
 1,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('\\mathcal{X}','\\mathcal{X}','Zustandsraum','Menge aller zulässigen Zustände.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 (SELECT equation_id FROM equations WHERE equation_number='3.38'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('F','F','Entwicklungsfunktion','Funktion oder Operator der Zustandsentwicklung.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 (SELECT equation_id FROM equations WHERE equation_number='3.39'),
 0,0,1,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('G','G','Graph','Geordnetes Paar aus Knoten- und Kantenmenge.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 (SELECT equation_id FROM equations WHERE equation_number='3.63'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('V','V','Knotenmenge oder Vektorraum','Kontextabhängig Knotenmenge beziehungsweise Vektorraum.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 (SELECT equation_id FROM equations WHERE equation_number='3.29'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('E','E','Kantenmenge','Menge der Kanten eines Graphen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 (SELECT equation_id FROM equations WHERE equation_number='3.63'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('d','d','Metrik','Abstandsfunktion auf einem metrischen Raum.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 (SELECT equation_id FROM equations WHERE equation_number='3.70'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('H','H','Entropie','Shannon-Entropie einer Zufallsvariablen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 (SELECT equation_id FROM equations WHERE equation_number='3.59'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('I','I','Information','Informationsgehalt oder gegenseitige Information.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 (SELECT equation_id FROM equations WHERE equation_number='3.58'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('D_{KL}','D_{KL}','Kullback-Leibler-Divergenz','Divergenz zweier Wahrscheinlichkeitsverteilungen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 (SELECT equation_id FROM equations WHERE equation_number='3.62'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('\\eta','\\eta','Ordnungsparameter','Makroskopischer Parameter der Systemordnung.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 (SELECT equation_id FROM equations WHERE equation_number='3.81'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('\\mathcal{M}','\\mathcal{M}','Mathematisches Modell','Zusammenfassung von Menge, Relationen, Funktionen, Operatoren und Zustandsraum.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 (SELECT equation_id FROM equations WHERE equation_number='3.83'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('\\mathcal{F}','\\mathcal{F}','Funktionale Wechselwirkungen','Gesamtheit funktionaler Wechselwirkungen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 (SELECT equation_id FROM equations WHERE equation_number='3.86'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('\\mathcal{P}','\\mathcal{P}','Physikalische Manifestationen','Physikalische Manifestation mathematischer Strukturen.','global',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 (SELECT equation_id FROM equations WHERE equation_number='3.86'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_word_latex=VALUES(symbol_word_latex),
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;

-- ------------------------------------------------------------
-- Definitionen aus Kapitel 3.2
-- ------------------------------------------------------------

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Menge','Eine Menge ist eine wohldefinierte Zusammenfassung unterscheidbarer mathematischer Objekte.','M=\\{x\\mid P(x)\\}','M=\\{x\\mid P(x)\\}','literature',
 (SELECT source_id FROM sources WHERE citation_number=23),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.2',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Teilmenge','A ist Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.','A\\subseteq B','A\\subseteq B','literature',
 (SELECT source_id FROM sources WHERE citation_number=25),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.3',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Relation','Eine Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts A×B.','R\\subseteq A\\times B','R\\subseteq A\\times B','literature',
 (SELECT source_id FROM sources WHERE citation_number=27),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.4',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Äquivalenzrelation','Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=27),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.5',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Funktion','Eine Funktion ordnet jedem Element der Definitionsmenge genau ein Element der Zielmenge zu.','f:A\\rightarrow B','f:A\\rightarrow B','literature',
 (SELECT source_id FROM sources WHERE citation_number=29),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.6',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Bijektion','Eine Funktion ist bijektiv, wenn sie injektiv und surjektiv ist.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=30),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.7',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Innere Verknüpfung','Eine innere Verknüpfung bildet zwei Elemente einer Menge wieder in diese Menge ab.','\\ast:A\\times A\\rightarrow A','\\ast:A\\times A\\rightarrow A','literature',
 (SELECT source_id FROM sources WHERE citation_number=31),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.8',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Monoid','Ein Monoid ist eine Menge mit assoziativer innerer Verknüpfung und neutralem Element.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=31),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.9',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Gruppe','Eine Gruppe ist ein Monoid, in dem jedes Element ein inverses Element besitzt.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=31),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.10',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.4'),
 'Vektorraum','Ein Vektorraum ist eine Menge von Vektoren mit Vektoraddition und Skalarmultiplikation über einem Körper.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=34),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.11',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operator','Ein Operator ist eine Abbildung zwischen mathematischen Räumen, deren Elemente selbst strukturierte mathematische Objekte sein können.','T:X\\rightarrow Y','T:X\\rightarrow Y','literature',
 (SELECT source_id FROM sources WHERE citation_number=35),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.12',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Linearer Operator','Ein Operator ist linear, wenn er Addition und Skalarmultiplikation erhält.','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)','literature',
 (SELECT source_id FROM sources WHERE citation_number=35),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.13',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Zustandsraum','Ein Zustandsraum ist die Menge aller zulässigen vollständigen Zustände eines Systems.','\\mathcal{X}=\\{X\\mid X\\text{ zulässig}\\}','\\mathcal{X}=\\{X\\mid X\\text{ zulässig}\\}','literature',
 (SELECT source_id FROM sources WHERE citation_number=38),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.14',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Norm','Eine Norm ordnet jedem Element eines Vektorraums eine nichtnegative Größe zu und erfüllt Definitheit, Homogenität und Dreiecksungleichung.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=42),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.15',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Banachraum','Ein Banachraum ist ein vollständiger normierter Vektorraum.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=42),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.16',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'Hilbertraum','Ein Hilbertraum ist ein vollständiger Skalarproduktraum.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=41),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.17',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Dynamisches System','Ein dynamisches System beschreibt die Entwicklung eines Zustands unter einer kontinuierlichen oder diskreten Dynamik.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=43),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.18',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Fixpunkt','Ein Fixpunkt ist ein Zustand, der durch die Dynamik unverändert bleibt.','F(X^\\ast)=X^\\ast','F(X^\\ast)=X^\\ast','literature',
 (SELECT source_id FROM sources WHERE citation_number=43),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.19',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Attraktor','Ein Attraktor ist eine invariante Zustandsmenge, der sich benachbarte Trajektorien langfristig annähern.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=44),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.20',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Shannon-Entropie','Die Shannon-Entropie ist der Erwartungswert des Informationsgehalts einer diskreten Zufallsvariablen.','H(X)=-\\sum_i p_i\\log_2 p_i','H(X)=-\\sum_i p_i\\log_2 p_i','literature',
 (SELECT source_id FROM sources WHERE citation_number=46),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.21',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'Gegenseitige Information','Die gegenseitige Information misst die Verringerung der Unsicherheit einer Zufallsvariablen durch Kenntnis einer zweiten.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=45),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.22',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Graph','Ein Graph ist ein geordnetes Paar aus einer Knotenmenge und einer Kantenmenge.','G=(V,E)','G=(V,E)','literature',
 (SELECT source_id FROM sources WHERE citation_number=47),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.23',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Metrik','Eine Metrik ist eine Abstandsfunktion, die Nichtnegativität, Identität, Symmetrie und Dreiecksungleichung erfüllt.','d:X\\times X\\rightarrow\\mathbb{R}','d:X\\times X\\rightarrow\\mathbb{R}','literature',
 (SELECT source_id FROM sources WHERE citation_number=49),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.24',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Selbstorganisation','Selbstorganisation bezeichnet die Entstehung makroskopischer Ordnung aus lokalen Wechselwirkungen ohne zentrale Steuerung.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=51),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,validation_status,created_revision_id)
VALUES
('Def. 3.2.25',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Emergenz','Emergenz bezeichnet das Auftreten neuer Systemeigenschaften auf einer höheren Organisationsebene.',NULL,NULL,'literature',
 (SELECT source_id FROM sources WHERE citation_number=52),
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 definition_text=VALUES(definition_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 source_id=VALUES(source_id),
 validation_status='checked',
 created_revision_id=@revision_id;

-- ------------------------------------------------------------
-- Aus der Forschungslücke abgeleitete Anforderungen
-- Noch keine FRZK-Axiome; diese werden erst in Kapitel 3.3 finalisiert.
-- ------------------------------------------------------------

INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,
 status,created_revision_id)
VALUES
('A-3.2-1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Entstehung funktionaler Zustände','Eine weiterführende Theorie muss die Entstehung funktionaler Zustände beschreiben, ohne diese als primitive Objekte vorauszusetzen.','Abgeleitet aus den Grenzen von Mengenlehre, Zustandsraumtheorie und Funktionalanalysis.','accepted',@revision_id)
ON DUPLICATE KEY UPDATE
 title=VALUES(title),
 assumption_text=VALUES(assumption_text),
 derivation_from_research_gap=VALUES(derivation_from_research_gap),
 status='accepted',
 created_revision_id=@revision_id;
INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,
 status,created_revision_id)
VALUES
('A-3.2-2',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Entstehung funktionaler Relationen','Eine weiterführende Theorie muss erklären, wie Relationen aus funktionalen Wechselwirkungen entstehen.','Abgeleitet aus der statischen Voraussetzung von Relationen und Graphen.','accepted',@revision_id)
ON DUPLICATE KEY UPDATE
 title=VALUES(title),
 assumption_text=VALUES(assumption_text),
 derivation_from_research_gap=VALUES(derivation_from_research_gap),
 status='accepted',
 created_revision_id=@revision_id;
INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,
 status,created_revision_id)
VALUES
('A-3.2-3',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Rekursive Operatorbildung','Eine weiterführende Theorie muss die rekursive Bildung und Veränderung von Operatoren ermöglichen.','Abgeleitet aus der klassischen Voraussetzung fest vorgegebener Operatoren.','accepted',@revision_id)
ON DUPLICATE KEY UPDATE
 title=VALUES(title),
 assumption_text=VALUES(assumption_text),
 derivation_from_research_gap=VALUES(derivation_from_research_gap),
 status='accepted',
 created_revision_id=@revision_id;
INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,
 status,created_revision_id)
VALUES
('A-3.2-4',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Dynamische Zustandsraumentstehung','Eine weiterführende Theorie muss die Entwicklung und Erweiterung des Zustandsraumes selbst beschreiben.','Abgeleitet aus der Voraussetzung fester Zustandsräume in klassischen dynamischen Systemen.','accepted',@revision_id)
ON DUPLICATE KEY UPDATE
 title=VALUES(title),
 assumption_text=VALUES(assumption_text),
 derivation_from_research_gap=VALUES(derivation_from_research_gap),
 status='accepted',
 created_revision_id=@revision_id;
INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,
 status,created_revision_id)
VALUES
('A-3.2-5',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Kohärenz als emergente Eigenschaft','Eine weiterführende Theorie muss Kohärenz als emergente Folge rekursiver funktionaler Prozesse formulieren.','Abgeleitet aus den Grenzen statischer Metriken, Korrelationen und klassischer Emergenzmodelle.','accepted',@revision_id)
ON DUPLICATE KEY UPDATE
 title=VALUES(title),
 assumption_text=VALUES(assumption_text),
 derivation_from_research_gap=VALUES(derivation_from_research_gap),
 status='accepted',
 created_revision_id=@revision_id;

-- ------------------------------------------------------------
-- Abkürzungen
-- ------------------------------------------------------------
INSERT INTO acronyms
(acronym,full_form,explanation,first_section_id,language_code,category,
 is_project_specific,validation_status,created_revision_id)
VALUES
('ZFC','Zermelo-Fraenkel-Mengenlehre mit Auswahlaxiom',
 'Axiomatische Grundlage großer Teile der modernen Mathematik.',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'de','Mathematik',FALSE,'checked',@revision_id),
('KL','Kullback-Leibler',
 'Bezeichnung der Kullback-Leibler-Divergenz.',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.9'),
 'de','Informationstheorie',FALSE,'checked',@revision_id),
('ODE','Ordinary Differential Equation',
 'Gewöhnliche Differentialgleichung.',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'en','Mathematik',FALSE,'checked',@revision_id),
('PDE','Partial Differential Equation',
 'Partielle Differentialgleichung.',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.7'),
 'en','Mathematik',FALSE,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 full_form=VALUES(full_form),
 explanation=VALUES(explanation),
 first_section_id=VALUES(first_section_id),
 validation_status='checked',
 created_revision_id=@revision_id;

-- Geplante Abbildungen
INSERT INTO figures
(figure_number,section_id,title,caption,figure_type,provenance,
 validation_status,created_revision_id)
VALUES
('Abb. 3.1',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),
 'Mengenhierarchie','Schematische Darstellung von Element, Menge und Teilmenge.','schema','original','draft',@revision_id),
('Abb. 3.2',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.2'),
 'Relationen','Schematische Darstellung binärer Relationen.','schema','original','draft',@revision_id),
('Abb. 3.3',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.3'),
 'Funktionen','Schematische Darstellung von Definitionsmenge, Zielmenge und eindeutiger Zuordnung.','schema','original','draft',@revision_id),
('Abb. 3.4',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operatoren','Schematische Darstellung einer rekursiven Operatoranwendung.','schema','original','draft',@revision_id),
('Abb. 3.5',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.6'),
 'Zustandsraum','Schematische Darstellung eines Zustandsraumes mit Trajektorie.','plot','original','draft',@revision_id),
('Abb. 3.6',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.8'),
 'Dynamische Systeme','Schematische Darstellung von Fixpunkt, Attraktor und Bifurkation.','plot','original','draft',@revision_id),
('Abb. 3.7',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.10'),
 'Netzwerkstruktur','Schematische Darstellung von Knoten, Kanten und Hubs.','network','original','draft',@revision_id),
('Abb. 3.8',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.12'),
 'Emergente Ordnungsbildung','Schematische Darstellung lokaler Wechselwirkungen und globaler Ordnung.','schema','original','draft',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 caption=VALUES(caption),
 figure_type=VALUES(figure_type),
 validation_status=VALUES(validation_status),
 created_revision_id=@revision_id;

-- Geplante Tabellen
INSERT INTO dissertation_tables
(table_number,section_id,title,caption,table_schema_json,table_data_json,
 provenance,validation_status,created_revision_id)
VALUES
('Tab. 3.1',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Mathematische Grundbegriffe','Vergleich der mathematischen Grundstrukturen.',
 JSON_OBJECT('columns',JSON_ARRAY('Formalismus','Leistung','Voraussetzung','Grenze')),JSON_ARRAY(),
 'original','draft',@revision_id),
('Tab. 3.2',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.5'),
 'Operatoren','Systematik linearer, nichtlinearer und rekursiver Operatoren.',
 JSON_OBJECT('columns',JSON_ARRAY('Operatortyp','Definition','Eigenschaften','FRZK-Relevanz')),JSON_ARRAY(),
 'original','draft',@revision_id),
('Tab. 3.3',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.11'),
 'Metriken und Ähnlichkeitsmaße','Vergleich ausgewählter Distanz- und Ähnlichkeitsmaße.',
 JSON_OBJECT('columns',JSON_ARRAY('Maß','Formel','Eigenschaften','Grenzen')),JSON_ARRAY(),
 'original','draft',@revision_id),
('Tab. 3.4',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Vergleich mathematischer Modelle','Vergleich der Reichweite bestehender Formalismen.',
 JSON_OBJECT('columns',JSON_ARRAY('Theorie','Beschreibt','Setzt voraus','Erklärt nicht')),JSON_ARRAY(),
 'original','draft',@revision_id),
('Tab. 3.5',(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'Forschungslücken und Anforderungen','Aus Kapitel 3.2 abgeleitete Anforderungen an Kapitel 3.3.',
 JSON_OBJECT('columns',JSON_ARRAY('Anforderung','Begründung','Weiterführung in 3.3')),JSON_ARRAY(),
 'original','draft',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 caption=VALUES(caption),
 table_schema_json=VALUES(table_schema_json),
 validation_status=VALUES(validation_status),
 created_revision_id=@revision_id;


-- ------------------------------------------------------------
-- Repository-Zähler
-- ------------------------------------------------------------
INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('next_citation_number','53'),
('next_equation_number','3.87'),
('last_completed_section','3.2'),
('last_repository_revision','RKB-2026-07-12-K3.2-COMPLETE')
ON DUPLICATE KEY UPDATE
 counter_value=VALUES(counter_value);

-- ------------------------------------------------------------
-- Änderungsprotokoll
-- ------------------------------------------------------------
DELETE FROM section_change_log
WHERE revision_id=@revision_id;

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary)
VALUES
(@revision_id,@chapter_section_id,'source_added','sources','[23]–[52]',
 '30 neue, deduplizierte Literaturquellen und drei Wiederverwendungen aufgenommen.'),
(@revision_id,@chapter_section_id,'equation_added','equations','(3.3)–(3.86)',
 '84 Gleichungen einschließlich Word-LaTeX und Quellenzuordnung registriert.'),
(@revision_id,@chapter_section_id,'definition_added','definitions','Def. 3.2.1–Def. 3.2.25',
 '25 mathematische Definitionen registriert.'),
(@revision_id,(SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13'),
 'assumption_added','assumptions','A-3.2-1–A-3.2-5',
 'Fünf Anforderungen aus der Forschungslücke abgeleitet.'),
(@revision_id,@chapter_section_id,'symbol_added','symbols','Symbolverzeichnis 3.2',
 'Zentrale mathematische Symbole aus Kapitel 3.2 registriert.'),
(@revision_id,@chapter_section_id,'figure_added','figures','Abb. 3.1–Abb. 3.8',
 'Acht geplante Abbildungen registriert.'),
(@revision_id,@chapter_section_id,'table_added','tables','Tab. 3.1–Tab. 3.5',
 'Fünf geplante Tabellen registriert.'),
(@revision_id,@chapter_section_id,'renumbered','citations','Dublettenbereinigung',
 'Barabási, Haken und Holland werden mit [15], [12] und [14] wiederverwendet; die nachfolgenden neuen Quellen wurden auf [49]–[52] korrigiert.'),
(@revision_id,@chapter_section_id,'status_changed','section','3.2',
 'Kapitel 3.2 auf Status review gesetzt.');

-- ------------------------------------------------------------
-- Validierungen
-- ------------------------------------------------------------
DELETE FROM repository_validation_results
WHERE revision_id=@revision_id;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_2_EQUATION_COUNT',
       IF(COUNT(*)=84,'passed','failed'),'84',CAST(COUNT(*) AS CHAR),
       'Anzahl der Gleichungen im Bereich (3.3) bis (3.86).'
FROM equations
WHERE CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 3 AND 86
  AND equation_number LIKE '3.%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_2_NEW_SOURCE_COUNT',
       IF(COUNT(*)=30,'passed','failed'),'30',CAST(COUNT(*) AS CHAR),
       'Anzahl der neuen deduplizierten Quellen [23] bis [52].'
FROM sources
WHERE citation_number BETWEEN 23 AND 52;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_2_DEFINITION_COUNT',
       IF(COUNT(*)=25,'passed','warning'),'25',CAST(COUNT(*) AS CHAR),
       'Anzahl der registrierten Definitionen für Kapitel 3.2.'
FROM definitions d
JOIN dissertation_sections ds ON ds.section_id=d.section_id
WHERE ds.section_code LIKE '3.2%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_2_ASSUMPTION_COUNT',
       IF(COUNT(*)=5,'passed','failed'),'5',CAST(COUNT(*) AS CHAR),
       'Anzahl der aus 3.2.13 abgeleiteten Anforderungen.'
FROM assumptions
WHERE assumption_number LIKE 'A-3.2-%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_2_MISSING_ANNOTATIONS',
       IF(COUNT(*)=0,'passed','failed'),'0',CAST(COUNT(*) AS CHAR),
       'Neue Quellen ohne Annotation.'
FROM sources s
LEFT JOIN annotations a ON a.source_id=s.source_id
WHERE s.citation_number BETWEEN 23 AND 52
  AND a.annotation_id IS NULL;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'GLOBAL_DUPLICATE_CITATION_NUMBERS',
       IF(COUNT(*)=0,'passed','failed'),'0',CAST(COUNT(*) AS CHAR),
       'Doppelte feste Literaturnummern im Repository.'
FROM (
    SELECT citation_number
    FROM sources
    WHERE citation_number IS NOT NULL
    GROUP BY citation_number
    HAVING COUNT(*)>1
) duplicate_numbers;

COMMIT;

-- ------------------------------------------------------------
-- Abschlussbericht
-- ------------------------------------------------------------
SELECT * FROM repository_validation_results WHERE revision_id=@revision_id ORDER BY validation_code;
SELECT counter_key,counter_value FROM repository_counters ORDER BY counter_key;
SELECT * FROM v_chapter_bibliography WHERE chapter_no=3 ORDER BY citation_number;
SELECT * FROM v_equation_register WHERE section_code LIKE '3.2%' ORDER BY equation_number;
