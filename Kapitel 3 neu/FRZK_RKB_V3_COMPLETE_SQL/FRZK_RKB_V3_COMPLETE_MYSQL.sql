-- FRZK Research Knowledge Base (FRZK-RKB)
-- MySQL 8.0+ schema
-- Character set: utf8mb4
-- Initial scope: complete dissertation, seeded with chapter 3.1

CREATE DATABASE IF NOT EXISTS frzk_rkb
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE frzk_rkb;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP VIEW IF EXISTS v_chapter_bibliography;
DROP VIEW IF EXISTS v_citation_audit;
DROP VIEW IF EXISTS v_equation_register;
DROP TABLE IF EXISTS equation_symbols;
DROP TABLE IF EXISTS equations;
DROP TABLE IF EXISTS source_usage;
DROP TABLE IF EXISTS source_relations;
DROP TABLE IF EXISTS source_topics;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS annotations;
DROP TABLE IF EXISTS source_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS sources;
DROP TABLE IF EXISTS dissertation_sections;
DROP TABLE IF EXISTS documents;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE documents (
    document_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    file_name VARCHAR(500),
    document_type ENUM('dissertation','chapter','article','book','dataset','appendix','other') NOT NULL DEFAULT 'other',
    version_label VARCHAR(100),
    file_path VARCHAR(1000),
    checksum_sha256 CHAR(64),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_documents_file_version (file_name, version_label)
) ENGINE=InnoDB;

CREATE TABLE dissertation_sections (
    section_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_section_id BIGINT UNSIGNED NULL,
    section_code VARCHAR(50) NOT NULL,
    title VARCHAR(500) NOT NULL,
    chapter_no INT NOT NULL,
    section_order DECIMAL(10,4) NOT NULL,
    status ENUM('planned','draft','review','final') NOT NULL DEFAULT 'planned',
    is_original_contribution BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    UNIQUE KEY uq_section_code (section_code),
    CONSTRAINT fk_sections_parent
        FOREIGN KEY (parent_section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sources (
    source_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    citation_number INT UNSIGNED NULL,
    source_key VARCHAR(150) NOT NULL,
    source_type ENUM(
        'journal_article','book','book_chapter','conference_paper','thesis',
        'report','standard','website','historical_work','edited_volume','other'
    ) NOT NULL,
    title VARCHAR(1000) NOT NULL,
    subtitle VARCHAR(1000),
    year_original SMALLINT,
    year_edition SMALLINT,
    journal VARCHAR(500),
    publisher VARCHAR(500),
    place VARCHAR(255),
    volume VARCHAR(100),
    issue VARCHAR(100),
    pages VARCHAR(100),
    edition VARCHAR(100),
    doi VARCHAR(255),
    isbn VARCHAR(100),
    url VARCHAR(1500),
    language_code CHAR(2) DEFAULT 'de',
    priority TINYINT UNSIGNED NOT NULL DEFAULT 3,
    evidence_type ENUM('primary','secondary','review','textbook','historical','reference') NOT NULL DEFAULT 'secondary',
    frzk_relevance TINYINT UNSIGNED NOT NULL DEFAULT 0,
    verification_status ENUM('imported','partially_verified','verified','needs_review') NOT NULL DEFAULT 'imported',
    first_citation_section_code VARCHAR(50),
    first_citation_note TEXT,
    full_citation_text TEXT NOT NULL,
    short_citation_text VARCHAR(500),
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_sources_citation_number (citation_number),
    UNIQUE KEY uq_sources_source_key (source_key),
    KEY idx_sources_title (title(191)),
    KEY idx_sources_year (year_original),
    KEY idx_sources_priority (priority),
    KEY idx_sources_frzk_relevance (frzk_relevance)
) ENGINE=InnoDB;

CREATE TABLE authors (
    author_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    family_name VARCHAR(255) NOT NULL,
    given_names VARCHAR(255),
    normalized_name VARCHAR(500) NOT NULL,
    orcid VARCHAR(50),
    birth_year SMALLINT,
    death_year SMALLINT,
    notes TEXT,
    UNIQUE KEY uq_authors_normalized_name (normalized_name)
) ENGINE=InnoDB;

CREATE TABLE source_authors (
    source_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    author_order SMALLINT UNSIGNED NOT NULL,
    role ENUM('author','editor','translator') NOT NULL DEFAULT 'author',
    PRIMARY KEY (source_id, author_id, role),
    UNIQUE KEY uq_source_author_order (source_id, role, author_order),
    CONSTRAINT fk_source_authors_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_authors_author
        FOREIGN KEY (author_id) REFERENCES authors(author_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE annotations (
    annotation_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_id BIGINT UNSIGNED NOT NULL,
    contribution TEXT,
    significance_for_dissertation TEXT,
    citation_reason TEXT,
    adopted_claims TEXT,
    limitations TEXT,
    scientific_discussion TEXT,
    annotation_status ENUM('draft','reviewed','approved') NOT NULL DEFAULT 'draft',
    reviewed_at DATETIME,
    UNIQUE KEY uq_annotation_source (source_id),
    CONSTRAINT fk_annotations_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE topics (
    topic_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_topic_id BIGINT UNSIGNED NULL,
    topic_code VARCHAR(100) NOT NULL,
    label VARCHAR(255) NOT NULL,
    description TEXT,
    UNIQUE KEY uq_topic_code (topic_code),
    CONSTRAINT fk_topics_parent
        FOREIGN KEY (parent_topic_id) REFERENCES topics(topic_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE source_topics (
    source_id BIGINT UNSIGNED NOT NULL,
    topic_id BIGINT UNSIGNED NOT NULL,
    relevance TINYINT UNSIGNED NOT NULL DEFAULT 3,
    PRIMARY KEY (source_id, topic_id),
    CONSTRAINT fk_source_topics_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_topics_topic
        FOREIGN KEY (topic_id) REFERENCES topics(topic_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE source_relations (
    relation_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_id_from BIGINT UNSIGNED NOT NULL,
    source_id_to BIGINT UNSIGNED NOT NULL,
    relation_type ENUM(
        'extends','criticizes','formalizes','applies','reviews',
        'historical_predecessor','alternative_to','supports','contradicts','related'
    ) NOT NULL,
    relation_note TEXT,
    UNIQUE KEY uq_source_relation (source_id_from, source_id_to, relation_type),
    CONSTRAINT fk_source_relations_from
        FOREIGN KEY (source_id_from) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_relations_to
        FOREIGN KEY (source_id_to) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE source_usage (
    usage_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_id BIGINT UNSIGNED NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    usage_type ENUM(
        'first_citation','background','definition','theorem','method',
        'historical_context','state_of_research','critique','research_gap',
        'comparison','equation_source','figure_source','table_source','other'
    ) NOT NULL,
    claim_summary TEXT NOT NULL,
    exact_location VARCHAR(255),
    is_first_mention BOOLEAN NOT NULL DEFAULT FALSE,
    citation_checked BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    KEY idx_usage_section (section_id),
    KEY idx_usage_source (source_id),
    CONSTRAINT fk_source_usage_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_usage_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE equations (
    equation_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equation_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500),
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL DEFAULT 'other',
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    derivation TEXT,
    assumptions TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    UNIQUE KEY uq_equation_number (equation_number),
    CONSTRAINT fk_equations_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_equations_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE equation_symbols (
    equation_symbol_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equation_id BIGINT UNSIGNED NOT NULL,
    symbol_latex VARCHAR(255) NOT NULL,
    symbol_name VARCHAR(255) NOT NULL,
    definition_text TEXT NOT NULL,
    unit_text VARCHAR(255),
    domain_text VARCHAR(500),
    symbol_order SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    UNIQUE KEY uq_equation_symbol (equation_id, symbol_latex),
    CONSTRAINT fk_equation_symbols_equation
        FOREIGN KEY (equation_id) REFERENCES equations(equation_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE VIEW v_chapter_bibliography AS
SELECT DISTINCT
    ds.chapter_no,
    s.citation_number,
    s.full_citation_text,
    s.short_citation_text,
    s.priority,
    s.frzk_relevance,
    s.verification_status
FROM source_usage su
JOIN sources s ON s.source_id = su.source_id
JOIN dissertation_sections ds ON ds.section_id = su.section_id
WHERE s.citation_number IS NOT NULL
ORDER BY ds.chapter_no, s.citation_number;

CREATE VIEW v_citation_audit AS
SELECT
    s.citation_number,
    s.source_key,
    s.full_citation_text,
    s.verification_status,
    COUNT(su.usage_id) AS usage_count,
    SUM(CASE WHEN su.is_first_mention = TRUE THEN 1 ELSE 0 END) AS first_mention_count,
    MIN(ds.section_code) AS first_used_section
FROM sources s
LEFT JOIN source_usage su ON su.source_id = s.source_id
LEFT JOIN dissertation_sections ds ON ds.section_id = su.section_id
GROUP BY s.source_id, s.citation_number, s.source_key, s.full_citation_text, s.verification_status;

CREATE VIEW v_equation_register AS
SELECT
    e.equation_number,
    ds.section_code,
    ds.title AS section_title,
    e.title,
    e.word_latex,
    e.plain_description,
    e.provenance,
    s.citation_number AS source_citation_number,
    e.validation_status
FROM equations e
JOIN dissertation_sections ds ON ds.section_id = e.section_id
LEFT JOIN sources s ON s.source_id = e.source_id
ORDER BY
    CAST(SUBSTRING_INDEX(e.equation_number, '.', 1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(e.equation_number, '.', -1) AS UNSIGNED);
USE frzk_rkb;
SET NAMES utf8mb4;

-- Documents
INSERT INTO documents (title,file_name,document_type,version_label,file_path) VALUES
('Kapitel 3.1 – Grundlagen der funktionalen Beschreibung von Raum und Zeit','3.1 Grundlagen der funktionalen Beschreibung von Raum und Zeit(1).docx','chapter','11.07.2026','/mnt/data/3.1 Grundlagen der funktionalen Beschreibung von Raum und Zeit(1).docx');

-- Dissertation sections
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES (NULL,'3.1','Grundlagen der funktionalen Beschreibung von Raum und Zeit',3,3.1,'final',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.1'),'3.1.1','Problemstellung und wissenschaftlicher Ausgangspunkt',3,3.11,'final',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.1'),'3.1.2','Wissenschaftstheoretische Entwicklung des Raum- und Zeitbegriffs',3,3.12,'final',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.1'),'3.1.3','Anforderungen an eine funktionale Theorie von Raum und Zeit',3,3.13,'final',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.1'),'3.1.4','Forschungsstand und Forschungslücke',3,3.14,'final',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.1'),'3.1.5','Einordnung des Funktionalen Raum-Zeit-Kohärenzsystems',3,3.15,'final',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES (NULL,'3.2','Mathematische Grundlagen',3,3.2,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.0','Einleitung',3,3.2001,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.1','Mengen als Grundlage mathematischer Modellbildung',3,3.21,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.2','Relationen als mathematische Beschreibung struktureller Zusammenhänge',3,3.22,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.3','Funktionen als mathematische Beschreibung deterministischer Transformationen',3,3.23,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.4','Algebraische Strukturen',3,3.24,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.5','Operatorentheorie',3,3.25,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.6','Zustandsräume',3,3.26,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.7','Funktionalanalysis',3,3.27,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.8','Dynamische Systeme',3,3.28,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.9','Informationstheorie',3,3.29,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.10','Graphen- und Netzwerktheorie',3,3.3,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.11','Metriken und Ähnlichkeitsmaße',3,3.31,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.12','Emergenz und Selbstorganisation',3,3.32,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES ((SELECT section_id FROM dissertation_sections p WHERE p.section_code='3.2'),'3.2.13','Grenzen bestehender mathematischer Modelle und Forschungslücke',3,3.33,'planned',0);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES (NULL,'3.3','Mathematische Axiome des Funktionalen Raum-Zeit-Kohärenzsystems',3,3.4,'planned',1);
INSERT INTO dissertation_sections (parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution) VALUES (NULL,'3.4','Mathematische Herleitung des Funktionalen Raum-Zeit-Kohärenzsystems',3,3.5,'planned',1);

-- Sources and annotations
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (1,'aristoteles_physik','historical_work','Physik',NULL,-350,1987,NULL,'Felix Meiner Verlag','Hamburg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',5,'historical',2,'imported','3.1.1','Aristoteles: Physik. Übersetzt von Hans Günter Zekl. Hamburg: Felix Meiner Verlag, 1987.','Aristoteles [1]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=1),'Grundlegende Analyse von Ort und Zeit als Ordnung körperlicher Gegenstände bzw. Maß der Veränderung.','Historischer Ausgangspunkt des Raum- und Zeitbegriffs in 3.1.','Belegt die frühe relationale und bewegungsbezogene Bestimmung von Raum und Zeit.','Raum als Ort; Zeit als Maß von Bewegung hinsichtlich Früher und Später.','Historische Quelle; keine moderne mathematische Formalisierung.','Wird Newtons absolutem Raum-Zeit-Konzept gegenübergestellt.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (2,'newton_principia_1687','historical_work','Philosophiae Naturalis Principia Mathematica',NULL,1687,1687,NULL,NULL,'London',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'la',5,'primary',3,'imported','3.1.1','Newton, Isaac: Philosophiae Naturalis Principia Mathematica. London, 1687.','Newton [2]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=2),'Formuliert den absoluten Raum und die absolute Zeit als unabhängigen Bezugsrahmen der klassischen Mechanik.','Dient in 3.1 als Gegenposition zu relationalen Raum-Zeit-Konzepten.','Belegt die klassische Setzung von Raum und Zeit als primitive Größen.','Absoluter Raum; absolute Zeit; unabhängiger Rahmen physikalischer Prozesse.','Historische Physik; durch Relativitätstheorie in ihrem universellen Anspruch begrenzt.','Wird mit Mach, Einstein und Minkowski kontrastiert.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (3,'mach_mechanik_1883','book','Die Mechanik in ihrer Entwicklung',NULL,1883,1883,NULL,'F. A. Brockhaus','Leipzig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',5,'primary',3,'imported','3.1.1','Mach, Ernst: Die Mechanik in ihrer Entwicklung. Leipzig: F. A. Brockhaus, 1883.','Mach [3]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=3),'Kritisiert unbeobachtbare absolute Größen und betont Relationen zwischen physikalischen Systemen.','Unterstützt den Übergang vom absoluten zum relationalen Raum-Zeit-Verständnis.','Belegt die wissenschaftshistorische Kritik an Newtons absoluten Größen.','Empirische Bedeutung relationaler Größen; Kritik an absolutem Raum und absoluter Zeit.','Noch keine vollständige relativistische Raumzeit-Theorie.','Historischer Vorläufer der Relativitätstheorie.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (4,'einstein_srt_1905','journal_article','Zur Elektrodynamik bewegter Körper',NULL,1905,1905,'Annalen der Physik',NULL,NULL,'17',NULL,'891–921',NULL,NULL,NULL,NULL,'de',5,'primary',4,'imported','3.1.1','Einstein, Albert: Zur Elektrodynamik bewegter Körper. Annalen der Physik, 17, 1905, S. 891–921.','Einstein [4]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=4),'Begründet die Spezielle Relativitätstheorie und hebt die Trennung absoluter Raum- und Zeitgrößen auf.','Zentrale Referenz für die wissenschaftliche Entwicklung zur gemeinsamen Raumzeit.','Belegt die Relativierung räumlicher und zeitlicher Messgrößen.','Relativität von Gleichzeitigkeit, Raum und Zeit; Konstanz der Lichtgeschwindigkeit.','Behandelt keine Gravitation und keine Genese der Raumzeit.','Wird durch Einstein 1916 und Minkowski geometrisch erweitert.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (5,'einstein_art_1916','journal_article','Die Grundlage der allgemeinen Relativitätstheorie',NULL,1916,1916,'Annalen der Physik',NULL,NULL,'49',NULL,'769–822',NULL,NULL,NULL,NULL,'de',5,'primary',4,'imported','3.1.1','Einstein, Albert: Die Grundlage der allgemeinen Relativitätstheorie. Annalen der Physik, 49, 1916, S. 769–822.','Einstein [5]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=5),'Formuliert die Allgemeine Relativitätstheorie und verbindet Raumzeitgeometrie mit Materie und Energie.','Belegt die Dynamisierung der Geometrie, ohne die Raumzeit selbst aus tieferen Prinzipien herzuleiten.','Dient als maßgeblicher Stand physikalischer Raumzeitbeschreibung.','Raumzeitkrümmung; Gravitation als geometrische Eigenschaft.','Setzt eine differenzierbare Raumzeitmannigfaltigkeit voraus.','Zentraler Vergleichspunkt für die FRZK-Abgrenzung.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (6,'minkowski_raum_zeit_1909','historical_work','Raum und Zeit',NULL,1909,1909,NULL,'B. G. Teubner','Leipzig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',5,'primary',4,'imported','3.1.1','Minkowski, Hermann: Raum und Zeit. Leipzig: B. G. Teubner, 1909.','Minkowski [6]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=6),'Vereinigt Raum und Zeit mathematisch in einer vierdimensionalen Raumzeitstruktur.','Liefert den geometrischen Formalismus für die relativistische Raumzeitdarstellung.','Belegt den Übergang von getrennten Größen zu einer gemeinsamen mathematischen Struktur.','Vierdimensionale Raumzeit; geometrische Vereinheitlichung.','Setzt die Raumzeitstruktur voraus und erklärt nicht ihre Genese.','Erweitert die Spezielle Relativitätstheorie geometrisch.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (7,'euklid_elemente','historical_work','Die Elemente',NULL,-300,1908,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',5,'historical',2,'imported','3.1.1','Euklid: Die Elemente. Übersetzung von Thomas L. Heath. Cambridge: Cambridge University Press, 1908.','Euklid [7]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=7),'Begründet die klassische axiomatische Geometrie aus primitiven Begriffen und Postulaten.','Dient als historischer Ausgangspunkt der axiomatischen Raumkonstruktion.','Belegt, dass Geometrien mit vorausgesetzten Punkten, Geraden und Ebenen beginnen.','Axiomatische Ableitung geometrischer Aussagen.','Primitive Begriffe werden nicht genetisch hergeleitet.','Wird durch Hilberts formale Axiomatik präzisiert.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (8,'hilbert_grundlagen_geometrie_1899','book','Grundlagen der Geometrie',NULL,1899,1899,NULL,'B. G. Teubner','Leipzig',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'de',5,'primary',4,'imported','3.1.1','Hilbert, David: Grundlagen der Geometrie. Leipzig: B. G. Teubner, 1899.','Hilbert [8]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=8),'Formuliert eine streng axiomatische Geometrie und präzisiert die Rolle primitiver Begriffe.','Grundlage für die Diskussion von Konsistenz, Unabhängigkeit und Minimalität der FRZK-Axiomatik.','Belegt die Notwendigkeit klarer Grundannahmen und die Grenzen definitorischer Rückführung.','Axiomatische Methode; primitive Begriffe; Konsistenz und Unabhängigkeit.','Die Geometrie setzt ihre Grundobjekte weiterhin voraus.','Verbindet 3.1 mit der Axiomatik in 3.3.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (9,'bourbaki_general_topology_1989','book','General Topology',NULL,1966,1989,NULL,'Springer','Berlin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',4,'reference',3,'imported','3.1.1','Bourbaki, Nicolas: General Topology. Berlin: Springer, 1989.','Bourbaki [9]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=9),'Systematisiert topologische Räume und deren strukturelle Eigenschaften.','Belegt, dass moderne Topologie Mengen und Nachbarschaftsstrukturen voraussetzt.','Dient als Referenz für die mathematische Reichweite und Voraussetzung topologischer Modelle.','Topologische Räume; Nachbarschaften; Stetigkeit.','Keine Herleitung der zugrunde liegenden Menge oder Topologie.','Wird in 3.2 und 3.4 erneut relevant.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (10,'lang_diff_riemannian_1995','book','Differential and Riemannian Manifolds',NULL,1995,1995,NULL,'Springer','New York',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',4,'reference',3,'imported','3.1.1','Lang, Serge: Differential and Riemannian Manifolds. New York: Springer, 1995.','Lang [10]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=10),'Stellt die mathematischen Grundlagen differenzierbarer und riemannscher Mannigfaltigkeiten dar.','Belegt die strukturellen Voraussetzungen moderner Raumtheorien.','Referenz für die Aussage, dass Differentialgeometrie bereits differenzierbare Räume voraussetzt.','Mannigfaltigkeiten; Tangentialräume; riemannsche Strukturen.','Keine Genese des zugrunde liegenden Raumes.','Relevant für die Abgrenzung des FRZK von klassischer Raumgeometrie.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (11,'rudin_functional_analysis_1991','book','Functional Analysis',NULL,1973,1991,NULL,'McGraw-Hill','New York',NULL,NULL,NULL,'2nd ed.',NULL,NULL,NULL,'en',5,'reference',4,'imported','3.1.1','Rudin, Walter: Functional Analysis. Second Edition. New York: McGraw-Hill, 1991.','Rudin [11]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=11),'Standardwerk zu Banach- und Hilberträumen sowie linearen Operatoren.','Mathematische Grundlage für 3.2 zu Zustandsräumen, Funktionalanalysis und Operatoren.','Belegt, dass Operatoren auf bereits definierten Funktionen- und Zustandsräumen wirken.','Normierte Räume; Vollständigkeit; Operatoren; Dualität.','Setzt den Raum und seine Struktur voraus.','Wird in 3.2 mehrfach wiederverwendet.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (12,'haken_synergetics_1983','book','Synergetics – An Introduction',NULL,1977,1983,NULL,'Springer','Berlin',NULL,NULL,NULL,'3rd ed.',NULL,NULL,NULL,'en',5,'reference',4,'imported','3.1.1','Haken, Hermann: Synergetics – An Introduction. Third Edition. Berlin: Springer, 1983.','Haken [12]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=12),'Entwickelt die Synergetik als Theorie selbstorganisierter makroskopischer Ordnungsbildung.','Direkte Grundlage für Emergenz, Selbstorganisation und Attraktoren in 3.2 und 3.4.','Belegt, dass globale Ordnung aus lokalen Wechselwirkungen und Ordnungsparametern entstehen kann.','Ordnungsparameter; Versklavungsprinzip; Selbstorganisation.','Arbeitet in vorausgesetzten Zustandsräumen und Dynamiken.','Verbindet Komplexitätstheorie mit der späteren FRZK-Strukturbildung.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (13,'prigogine_stengers_order_1984','book','Order out of Chaos',NULL,1984,1984,NULL,'Bantam Books','New York',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',4,'secondary',4,'imported','3.1.1','Prigogine, Ilya; Stengers, Isabelle: Order out of Chaos. New York: Bantam Books, 1984.','Prigogine und Stengers [13]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=13),'Stellt dissipative Strukturen und nichtgleichgewichtige Selbstorganisation dar.','Unterstützt die Argumentation zur Entstehung stabiler Strukturen aus Dynamik.','Belegt die produktive Rolle von Nichtgleichgewicht und Rekursion.','Dissipative Strukturen; Irreversibilität; Ordnung aus Fluktuation.','Populärwissenschaftlicher als die Primärarbeiten Prigogines; später durch Originalquellen zu ergänzen.','Verwandt mit Haken und komplexen adaptiven Systemen.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (14,'holland_hidden_order_1995','book','Hidden Order',NULL,1995,1995,NULL,'Addison-Wesley','Reading, MA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',4,'secondary',3,'imported','3.1.1','Holland, John H.: Hidden Order. Reading, MA: Addison-Wesley, 1995.','Holland [14]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=14),'Beschreibt komplexe adaptive Systeme und emergente Ordnung aus lokalen Regeln.','Dient als Brücke zwischen mathematischer Dynamik, Adaptation und emergenter Systemstruktur.','Belegt die Entstehung globaler Muster durch rekursive lokale Interaktionen.','Adaptive Agenten; Rückkopplung; emergente Ordnung.','Nicht als axiomatische Mathematik formuliert.','Ergänzt Haken, Prigogine und Netzwerkforschung.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (15,'barabasi_network_science_2016','book','Network Science',NULL,2016,2016,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',5,'reference',4,'imported','3.1.1','Barabási, Albert-László: Network Science. Cambridge: Cambridge University Press, 2016.','Barabási [15]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=15),'Systematisiert moderne Netzwerkwissenschaft, Wachstumsmodelle und skalenfreie Strukturen.','Grundlage für Graphen- und Netzwerktheorie in 3.2 sowie relationale FRZK-Strukturen in 3.4.','Belegt, dass einfache Wachstumsregeln komplexe globale Netzwerke erzeugen.','Netzwerkwachstum; Gradverteilungen; Zentralität; Robustheit.','Setzt Knoten und Kanten als primitive Strukturen voraus.','Wird mit klassischer Graphentheorie und dynamischen Netzwerken ergänzt.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (16,'arnold_classical_mechanics_1989','book','Mathematical Methods of Classical Mechanics',NULL,1978,1989,NULL,'Springer','New York',NULL,NULL,NULL,'2nd ed.',NULL,NULL,NULL,'en',5,'reference',4,'imported','3.1.2','Arnold, Vladimir I.: Mathematical Methods of Classical Mechanics. Second Edition. New York: Springer, 1989.','Arnold [16]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=16),'Formuliert klassische Mechanik in geometrischer und dynamischer Systemsprache.','Referenz für Zustandsräume, Phasenräume und zeitabhängige Entwicklungen in 3.2.','Belegt, dass dynamische Systeme vorgegebene Zustandsräume und Entwicklungsgesetze voraussetzen.','Hamiltonsche Dynamik; Phasenraum; Flüsse.','Beschreibt Entwicklung im Raum, nicht die Genese des Raumes.','Zentrale Standardquelle für 3.2.8.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (17,'goedel_unentscheidbar_1931','journal_article','Über formal unentscheidbare Sätze der Principia Mathematica und verwandter Systeme I',NULL,1931,1931,'Monatshefte für Mathematik und Physik',NULL,NULL,'38',NULL,'173–198',NULL,NULL,NULL,NULL,'de',5,'primary',3,'imported','3.1.3','Gödel, Kurt: Über formal unentscheidbare Sätze der Principia Mathematica und verwandter Systeme I. Monatshefte für Mathematik und Physik, 38, 1931, S. 173–198.','Gödel [17]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=17),'Beweist die Unvollständigkeit hinreichend mächtiger formaler Systeme.','Begrenzt den Vollständigkeitsanspruch der späteren FRZK-Axiomatik.','Belegt, dass formale Systeme prinzipielle interne Grenzen besitzen.','Unvollständigkeit; Unentscheidbarkeit; Grenzen formaler Systeme.','Keine Aussage gegen die praktische Tragfähigkeit konsistenter Axiomensysteme.','Wird in 3.3 zur methodischen Einordnung genutzt.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (18,'whitehead_russell_principia_1910','book','Principia Mathematica',NULL,1910,1913,NULL,'Cambridge University Press','Cambridge','I–III',NULL,NULL,NULL,NULL,NULL,NULL,'en',5,'primary',3,'imported','3.1.3','Whitehead, Alfred North; Russell, Bertrand: Principia Mathematica. Cambridge: Cambridge University Press, Vol. I–III, 1910–1913.','Whitehead und Russell [18]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=18),'Versucht, große Teile der Mathematik aus wenigen logischen Grundannahmen abzuleiten.','Referenz für axiomatische Sparsamkeit und logische Fundierung.','Belegt den historischen Anspruch minimaler primitiver Begriffe.','Logizismus; formale Ableitung; axiomatische Reduktion.','Das Programm wird durch Gödels Resultate prinzipiell begrenzt.','Historischer Bezug zwischen Axiomatik und formaler Logik.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (19,'rovelli_quantum_gravity_2004','book','Quantum Gravity',NULL,2004,2004,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',5,'reference',3,'imported','3.1.4','Rovelli, Carlo: Quantum Gravity. Cambridge: Cambridge University Press, 2004.','Rovelli [19]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=19),'Stellt die Loop-Quantengravitation und diskrete geometrische Größen dar.','Dient zur Einordnung emergenter bzw. nichtklassischer Raumzeitkonzepte.','Belegt, dass moderne Physik die Fundamentalität kontinuierlicher Raumzeit hinterfragt.','Quantisierte Fläche und Volumen; spin-netzartige Strukturen.','Setzt mathematische Netzwerk- und Zustandsstrukturen voraus.','Wird mit Stringtheorie und Informationsansätzen verglichen.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (20,'green_schwarz_witten_superstring_1987','book','Superstring Theory',NULL,1987,1987,NULL,'Cambridge University Press','Cambridge',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',5,'reference',3,'imported','3.1.4','Green, Michael B.; Schwarz, John H.; Witten, Edward: Superstring Theory. Cambridge: Cambridge University Press, 1987.','Green, Schwarz und Witten [20]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=20),'Systematisiert die mathematischen Grundlagen der Superstringtheorie.','Referenz für höherdimensionale Raumzeitmodelle im Forschungsstand.','Belegt alternative mikroskopische Strukturen der Raumzeit.','Strings; zusätzliche Dimensionen; konsistente Quantisierung.','Setzt hochentwickelte mathematische Räume und Strukturen voraus.','Kontrastiert mit Loop-Quantengravitation und FRZK-Zielsetzung.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (21,'wheeler_it_from_bit_1990','book_chapter','Information, Physics, Quantum: The Search for Links',NULL,1990,1990,NULL,'Addison-Wesley',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',5,'primary',4,'imported','3.1.4','Wheeler, John Archibald: Information, Physics, Quantum: The Search for Links. In: Zurek, W. H. (Hrsg.): Complexity, Entropy and the Physics of Information. Addison-Wesley, 1990.','Wheeler [21]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=21),'Formuliert das Programm „It from Bit“, nach dem physikalische Wirklichkeit aus Information hervorgehen könnte.','Zentrale Brücke zwischen Physik, Information und funktionaler Genese.','Belegt die Forschungslinie, Information als fundamentalen Ausgangspunkt zu behandeln.','It from Bit; informationelle Grundlage physikalischer Realität.','Keine vollständige mathematische Herleitung von Raum, Zeit und Kohärenz.','Wird mit Shannon, Floridi und FRZK verglichen.','reviewed');
INSERT INTO sources (citation_number,source_key,source_type,title,subtitle,year_original,year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,url,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,full_citation_text,short_citation_text) VALUES (22,'floridi_philosophy_information_2011','book','The Philosophy of Information',NULL,2011,2011,NULL,'Oxford University Press','Oxford',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',4,'reference',3,'imported','3.1.4','Floridi, Luciano: The Philosophy of Information. Oxford: Oxford University Press, 2011.','Floridi [22]');
INSERT INTO annotations (source_id,contribution,significance_for_dissertation,citation_reason,adopted_claims,limitations,scientific_discussion,annotation_status) VALUES ((SELECT source_id FROM sources WHERE citation_number=22),'Entwickelt eine systematische Philosophie informationeller Strukturen.','Unterstützt die erkenntnistheoretische Einordnung von Information in Kapitel 3.','Belegt die Interpretation von Information als grundlegendes Organisationsprinzip.','Informationelle Strukturen; Informationsontologie; epistemische Rollen.','Keine axiomatische mathematische Genese von Raum und Zeit.','Ergänzt Wheeler und spätere Informationstheorie.','reviewed');

-- Authors
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Aristoteles',NULL,'Aristoteles');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Newton','Isaac','Newton, Isaac');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Mach','Ernst','Mach, Ernst');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Einstein','Albert','Einstein, Albert');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Minkowski','Hermann','Minkowski, Hermann');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Euklid',NULL,'Euklid');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Hilbert','David','Hilbert, David');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Bourbaki','Nicolas','Bourbaki, Nicolas');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Lang','Serge','Lang, Serge');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Rudin','Walter','Rudin, Walter');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Haken','Hermann','Haken, Hermann');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Prigogine','Ilya','Prigogine, Ilya');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Stengers','Isabelle','Stengers, Isabelle');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Holland','John H.','Holland, John H.');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Barabási','Albert-László','Barabási, Albert-László');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Arnold','Vladimir I.','Arnold, Vladimir I.');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Gödel','Kurt','Gödel, Kurt');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Whitehead','Alfred North','Whitehead, Alfred North');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Russell','Bertrand','Russell, Bertrand');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Rovelli','Carlo','Rovelli, Carlo');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Green','Michael B.','Green, Michael B.');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Schwarz','John H.','Schwarz, John H.');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Witten','Edward','Witten, Edward');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Wheeler','John Archibald','Wheeler, John Archibald');
INSERT INTO authors (family_name,given_names,normalized_name) VALUES ('Floridi','Luciano','Floridi, Luciano');

-- Source-author links
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=1),(SELECT author_id FROM authors WHERE normalized_name='Aristoteles'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=2),(SELECT author_id FROM authors WHERE normalized_name='Newton, Isaac'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=3),(SELECT author_id FROM authors WHERE normalized_name='Mach, Ernst'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=4),(SELECT author_id FROM authors WHERE normalized_name='Einstein, Albert'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=5),(SELECT author_id FROM authors WHERE normalized_name='Einstein, Albert'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=6),(SELECT author_id FROM authors WHERE normalized_name='Minkowski, Hermann'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=7),(SELECT author_id FROM authors WHERE normalized_name='Euklid'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=8),(SELECT author_id FROM authors WHERE normalized_name='Hilbert, David'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=9),(SELECT author_id FROM authors WHERE normalized_name='Bourbaki, Nicolas'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=10),(SELECT author_id FROM authors WHERE normalized_name='Lang, Serge'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=11),(SELECT author_id FROM authors WHERE normalized_name='Rudin, Walter'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=12),(SELECT author_id FROM authors WHERE normalized_name='Haken, Hermann'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=13),(SELECT author_id FROM authors WHERE normalized_name='Prigogine, Ilya'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=13),(SELECT author_id FROM authors WHERE normalized_name='Stengers, Isabelle'),2,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=14),(SELECT author_id FROM authors WHERE normalized_name='Holland, John H.'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=15),(SELECT author_id FROM authors WHERE normalized_name='Barabási, Albert-László'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=16),(SELECT author_id FROM authors WHERE normalized_name='Arnold, Vladimir I.'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=17),(SELECT author_id FROM authors WHERE normalized_name='Gödel, Kurt'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=18),(SELECT author_id FROM authors WHERE normalized_name='Whitehead, Alfred North'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=18),(SELECT author_id FROM authors WHERE normalized_name='Russell, Bertrand'),2,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=19),(SELECT author_id FROM authors WHERE normalized_name='Rovelli, Carlo'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=20),(SELECT author_id FROM authors WHERE normalized_name='Green, Michael B.'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=20),(SELECT author_id FROM authors WHERE normalized_name='Schwarz, John H.'),2,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=20),(SELECT author_id FROM authors WHERE normalized_name='Witten, Edward'),3,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=21),(SELECT author_id FROM authors WHERE normalized_name='Wheeler, John Archibald'),1,'author');
INSERT INTO source_authors (source_id,author_id,author_order,role) VALUES ((SELECT source_id FROM sources WHERE citation_number=22),(SELECT author_id FROM authors WHERE normalized_name='Floridi, Luciano'),1,'author');

-- Topics
INSERT INTO topics (topic_code,label) VALUES ('PHIL_SPACE_TIME','Raum- und Zeitphilosophie');
INSERT INTO topics (topic_code,label) VALUES ('PHYS_RELATIVITY','Relativitätstheorie');
INSERT INTO topics (topic_code,label) VALUES ('MATH_AXIOMATICS','Axiomatik');
INSERT INTO topics (topic_code,label) VALUES ('MATH_TOPOLOGY','Topologie');
INSERT INTO topics (topic_code,label) VALUES ('MATH_DIFFERENTIAL_GEOMETRY','Differentialgeometrie');
INSERT INTO topics (topic_code,label) VALUES ('MATH_FUNCTIONAL_ANALYSIS','Funktionalanalysis');
INSERT INTO topics (topic_code,label) VALUES ('MATH_DYNAMICAL_SYSTEMS','Dynamische Systeme');
INSERT INTO topics (topic_code,label) VALUES ('COMPLEXITY_SELF_ORGANIZATION','Selbstorganisation und Emergenz');
INSERT INTO topics (topic_code,label) VALUES ('NETWORK_SCIENCE','Netzwerkwissenschaft');
INSERT INTO topics (topic_code,label) VALUES ('QUANTUM_GRAVITY','Quantengravitation');
INSERT INTO topics (topic_code,label) VALUES ('INFORMATION_FOUNDATIONS','Information als Grundlage');
INSERT INTO topics (topic_code,label) VALUES ('FRZK_FOUNDATION','FRZK-Grundlegung');

-- Source-topic links
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=1),(SELECT topic_id FROM topics WHERE topic_code='PHIL_SPACE_TIME'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=2),(SELECT topic_id FROM topics WHERE topic_code='PHIL_SPACE_TIME'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=3),(SELECT topic_id FROM topics WHERE topic_code='PHIL_SPACE_TIME'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=3),(SELECT topic_id FROM topics WHERE topic_code='PHYS_RELATIVITY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=4),(SELECT topic_id FROM topics WHERE topic_code='PHYS_RELATIVITY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=5),(SELECT topic_id FROM topics WHERE topic_code='PHYS_RELATIVITY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=6),(SELECT topic_id FROM topics WHERE topic_code='PHYS_RELATIVITY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=7),(SELECT topic_id FROM topics WHERE topic_code='MATH_AXIOMATICS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=8),(SELECT topic_id FROM topics WHERE topic_code='MATH_AXIOMATICS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=9),(SELECT topic_id FROM topics WHERE topic_code='MATH_TOPOLOGY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=10),(SELECT topic_id FROM topics WHERE topic_code='MATH_DIFFERENTIAL_GEOMETRY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=11),(SELECT topic_id FROM topics WHERE topic_code='MATH_FUNCTIONAL_ANALYSIS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=12),(SELECT topic_id FROM topics WHERE topic_code='COMPLEXITY_SELF_ORGANIZATION'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=13),(SELECT topic_id FROM topics WHERE topic_code='COMPLEXITY_SELF_ORGANIZATION'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=14),(SELECT topic_id FROM topics WHERE topic_code='COMPLEXITY_SELF_ORGANIZATION'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=15),(SELECT topic_id FROM topics WHERE topic_code='NETWORK_SCIENCE'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=16),(SELECT topic_id FROM topics WHERE topic_code='MATH_DYNAMICAL_SYSTEMS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=17),(SELECT topic_id FROM topics WHERE topic_code='MATH_AXIOMATICS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=18),(SELECT topic_id FROM topics WHERE topic_code='MATH_AXIOMATICS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=19),(SELECT topic_id FROM topics WHERE topic_code='QUANTUM_GRAVITY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=20),(SELECT topic_id FROM topics WHERE topic_code='QUANTUM_GRAVITY'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=21),(SELECT topic_id FROM topics WHERE topic_code='INFORMATION_FOUNDATIONS'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=21),(SELECT topic_id FROM topics WHERE topic_code='FRZK_FOUNDATION'),5);
INSERT INTO source_topics (source_id,topic_id,relevance) VALUES ((SELECT source_id FROM sources WHERE citation_number=22),(SELECT topic_id FROM topics WHERE topic_code='INFORMATION_FOUNDATIONS'),5);

-- Source usage
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=1),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Historische Definition von Raum und Zeit als Ordnung bzw. Maß der Veränderung',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=2),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Absoluter Raum und absolute Zeit als primitive Größen der klassischen Mechanik',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=3),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Kritik absoluter Größen und relationale physikalische Beschreibung',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=4),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Spezielle Relativitätstheorie und Relativierung von Raum und Zeit',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=5),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Allgemeine Relativitätstheorie und dynamische Raumzeitgeometrie',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=6),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Vierdimensionale geometrische Raumzeitformulierung',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=7),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Klassische axiomatische Geometrie mit primitiven Grundbegriffen',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=8),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Formale Axiomatik und primitive Begriffe',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=9),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Topologische Räume setzen Mengen und Strukturen voraus',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=10),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Differenzierbare Mannigfaltigkeiten als vorausgesetzte Räume',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=11),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Operatoren auf vorausgesetzten Banach- und Hilberträumen',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=12),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Selbstorganisation durch Ordnungsparameter und rekursive Wechselwirkungen',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=13),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Dissipative Strukturen und Ordnung aus Nichtgleichgewicht',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=14),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Komplexe adaptive Systeme und emergente Ordnung',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=15),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.1'),'first_citation','Komplexe Netzwerke aus einfachen Wachstumsregeln',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=16),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'first_citation','Dynamische Systeme entwickeln sich in vorgegebenen Phasenräumen',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=17),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.3'),'first_citation','Prinzipielle Grenzen formaler Systeme',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=18),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.3'),'first_citation','Axiomatische Reduktion auf wenige logische Grundannahmen',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=19),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.4'),'first_citation','Diskrete geometrische Strukturen der Loop-Quantengravitation',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=20),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.4'),'first_citation','Höherdimensionale Raumzeitstrukturen der Stringtheorie',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=21),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.4'),'first_citation','Information als möglicher Ursprung physikalischer Realität',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=22),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.4'),'first_citation','Philosophie informationeller Strukturen',1,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=1),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'historical_context','Wiederverwendung der aristotelischen Zeitdefinition',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=2),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'comparison','Kontrast zu relationalen und relativistischen Modellen',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=3),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'comparison','Relationale Kritik an absoluten Größen',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=4),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'state_of_research','Spezielle Relativitätstheorie',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=5),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'state_of_research','Allgemeine Relativitätstheorie',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=6),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'state_of_research','Minkowski-Raumzeit',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=7),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'historical_context','Primitive Begriffe der euklidischen Geometrie',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=8),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'critique','Grenzen axiomatisch vorausgesetzter Raumbegriffe',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=9),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'critique','Topologische Voraussetzungen',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=10),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'critique','Differentialgeometrische Voraussetzungen',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=11),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.2'),'critique','Funktionalanalytische Voraussetzungen',0,1);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,is_first_mention,citation_checked) VALUES ((SELECT source_id FROM sources WHERE citation_number=15),(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.4'),'state_of_research','Netzwerkforschung als Modell emergenter Strukturbildung',0,1);

-- Equations from final section 3.1
INSERT INTO equations (equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,validation_status) VALUES ('3.1',(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.5'),'Klassische Entwicklungsrichtung','\\text{Axiome}\\longrightarrow\\text{Raum}\\longrightarrow\\text{Zeit}\\longrightarrow\\text{physikalische Dynamik}','\\text{Axiome}\\longrightarrow\\text{Raum}\\longrightarrow\\text{Zeit}\\longrightarrow\\text{physikalische Dynamik}','Schematische Darstellung etablierter Theorien: Aus Axiomen werden Raum und Zeit als vorausgesetzte Strukturen verwendet, bevor physikalische Dynamik beschrieben wird.','schema','original','checked');
INSERT INTO equations (equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,validation_status) VALUES ('3.2',(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.5'),'FRZK-Entwicklungsrichtung','\\text{funktionale Axiome}\\longrightarrow\\text{rekursive Entwicklung}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum}\\longrightarrow\\text{Zeit}','\\text{funktionale Axiome}\\longrightarrow\\text{rekursive Entwicklung}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum}\\longrightarrow\\text{Zeit}','Schematische Darstellung des FRZK: Raum und Zeit werden als Ergebnisse rekursiver funktionaler Entwicklung und Kohärenz hergeleitet.','schema','original','checked');

-- Initial source relations
INSERT INTO source_relations (source_id_from,source_id_to,relation_type,relation_note) VALUES
((SELECT source_id FROM sources WHERE citation_number=3),(SELECT source_id FROM sources WHERE citation_number=2),'criticizes','Mach kritisiert Newtons absolute Raum- und Zeitgrößen.'),
((SELECT source_id FROM sources WHERE citation_number=4),(SELECT source_id FROM sources WHERE citation_number=2),'alternative_to','Die Spezielle Relativitätstheorie ersetzt absolute Raum- und Zeitmessungen.'),
((SELECT source_id FROM sources WHERE citation_number=6),(SELECT source_id FROM sources WHERE citation_number=4),'formalizes','Minkowski formuliert die Spezielle Relativitätstheorie geometrisch als Raumzeit.'),
((SELECT source_id FROM sources WHERE citation_number=5),(SELECT source_id FROM sources WHERE citation_number=4),'extends','Die Allgemeine Relativitätstheorie erweitert die Spezielle Relativitätstheorie um Gravitation.'),
((SELECT source_id FROM sources WHERE citation_number=17),(SELECT source_id FROM sources WHERE citation_number=18),'criticizes','Gödels Unvollständigkeitssätze begrenzen das logizistische Vollständigkeitsprogramm.'),
((SELECT source_id FROM sources WHERE citation_number=21),(SELECT source_id FROM sources WHERE citation_number=22),'historical_predecessor','Wheelers informationeller Physikansatz ist ein wichtiger Vorläufer philosophischer Informationsontologien.');
-- FRZK Research Knowledge Base
-- Repository extension v2.0
-- Extends the existing frzk_rkb schema into a complete dissertation repository.
-- MySQL 8.0+

USE frzk_rkb;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP VIEW IF EXISTS v_section_inventory;
DROP VIEW IF EXISTS v_acronym_register;
DROP VIEW IF EXISTS v_symbol_register;
DROP VIEW IF EXISTS v_table_register;
DROP VIEW IF EXISTS v_figure_register;
DROP VIEW IF EXISTS v_statement_register;
DROP VIEW IF EXISTS v_definition_register;
DROP VIEW IF EXISTS v_pending_source_audit;

CREATE TABLE IF NOT EXISTS pending_sources (
    pending_source_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposed_source_key VARCHAR(150),
    title VARCHAR(1000) NOT NULL,
    authors_text VARCHAR(1000),
    year_text VARCHAR(50),
    publication_text VARCHAR(1000),
    doi_or_url VARCHAR(1500),
    proposed_section_code VARCHAR(50),
    discovery_context TEXT NOT NULL,
    proposed_claim TEXT,
    priority TINYINT UNSIGNED NOT NULL DEFAULT 3,
    review_status ENUM('open','in_review','accepted','rejected','merged') NOT NULL DEFAULT 'open',
    merged_source_id BIGINT UNSIGNED NULL,
    discovered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at DATETIME,
    review_notes TEXT,
    KEY idx_pending_status (review_status),
    KEY idx_pending_section (proposed_section_code),
    CONSTRAINT fk_pending_merged_source
        FOREIGN KEY (merged_source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS repository_revisions (
    revision_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_code VARCHAR(100) NOT NULL,
    revision_date DATETIME NOT NULL,
    scope_type ENUM('repository','chapter','section','source','equation','definition','statement','figure','table','symbol','acronym') NOT NULL,
    scope_reference VARCHAR(255),
    version_label VARCHAR(100) NOT NULL,
    summary TEXT NOT NULL,
    created_by VARCHAR(255) DEFAULT 'Olaf Thiele / ChatGPT',
    parent_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_revision_code (revision_code),
    CONSTRAINT fk_revision_parent
        FOREIGN KEY (parent_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS section_change_log (
    change_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_id BIGINT UNSIGNED NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    change_type ENUM(
        'created','rewritten','edited','renumbered','source_added','source_reused',
        'equation_added','equation_changed','definition_added','statement_added',
        'figure_added','table_added','symbol_added','acronym_added','status_changed','other'
    ) NOT NULL,
    object_type VARCHAR(100),
    object_reference VARCHAR(255),
    change_summary TEXT NOT NULL,
    previous_value LONGTEXT,
    new_value LONGTEXT,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_change_section (section_id),
    KEY idx_change_revision (revision_id),
    CONSTRAINT fk_change_revision
        FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_change_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS definitions (
    definition_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    definition_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT,
    word_latex LONGTEXT,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    notes TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_definition_number (definition_number),
    KEY idx_definition_section (section_id),
    CONSTRAINT fk_definitions_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_definitions_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_definitions_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS theorems (
    theorem_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    theorem_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    proof_text LONGTEXT,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'literature',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_theorem_number (theorem_number),
    CONSTRAINT fk_theorems_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_theorems_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_theorems_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS lemmas (
    lemma_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    lemma_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    proof_text LONGTEXT,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'literature',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_lemma_number (lemma_number),
    CONSTRAINT fk_lemmas_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_lemmas_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_lemmas_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS corollaries (
    corollary_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    corollary_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    derivation_text LONGTEXT,
    parent_theorem_id BIGINT UNSIGNED NULL,
    parent_lemma_id BIGINT UNSIGNED NULL,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'literature',
    source_id BIGINT UNSIGNED NULL,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_corollary_number (corollary_number),
    CONSTRAINT fk_corollaries_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_corollaries_theorem
        FOREIGN KEY (parent_theorem_id) REFERENCES theorems(theorem_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_corollaries_lemma
        FOREIGN KEY (parent_lemma_id) REFERENCES lemmas(lemma_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_corollaries_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_corollaries_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS figures (
    figure_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    figure_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    caption LONGTEXT NOT NULL,
    file_name VARCHAR(500),
    file_path VARCHAR(1500),
    alt_text LONGTEXT,
    figure_type ENUM('diagram','plot','photograph','schema','flowchart','network','other') NOT NULL DEFAULT 'other',
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    generation_method TEXT,
    data_reference TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_figure_number (figure_number),
    CONSTRAINT fk_figures_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_figures_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_figures_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dissertation_tables (
    table_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    caption LONGTEXT,
    table_schema_json JSON,
    table_data_json JSON,
    file_name VARCHAR(500),
    file_path VARCHAR(1500),
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    generation_method TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_table_number (table_number),
    CONSTRAINT fk_tables_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_tables_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_tables_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS symbols (
    symbol_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    symbol_latex VARCHAR(255) NOT NULL,
    symbol_word_latex VARCHAR(255) NOT NULL,
    symbol_name VARCHAR(255) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    scope_type ENUM('global','chapter','section','equation') NOT NULL DEFAULT 'global',
    first_section_id BIGINT UNSIGNED NULL,
    first_equation_id BIGINT UNSIGNED NULL,
    unit_text VARCHAR(255),
    domain_text VARCHAR(1000),
    codomain_text VARCHAR(1000),
    is_vector BOOLEAN NOT NULL DEFAULT FALSE,
    is_matrix BOOLEAN NOT NULL DEFAULT FALSE,
    is_operator BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_symbol_scope (symbol_latex, scope_type, first_section_id),
    CONSTRAINT fk_symbols_section
        FOREIGN KEY (first_section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_symbols_equation
        FOREIGN KEY (first_equation_id) REFERENCES equations(equation_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_symbols_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS acronyms (
    acronym_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    acronym VARCHAR(100) NOT NULL,
    full_form VARCHAR(1000) NOT NULL,
    explanation LONGTEXT,
    first_section_id BIGINT UNSIGNED NULL,
    language_code CHAR(2) NOT NULL DEFAULT 'de',
    category VARCHAR(255),
    is_project_specific BOOLEAN NOT NULL DEFAULT FALSE,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_acronym (acronym),
    CONSTRAINT fk_acronyms_section
        FOREIGN KEY (first_section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_acronyms_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS equation_dependencies (
    dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equation_id BIGINT UNSIGNED NOT NULL,
    depends_on_equation_id BIGINT UNSIGNED NOT NULL,
    dependency_type ENUM('derived_from','uses','special_case_of','generalizes','validates','contrasts') NOT NULL,
    dependency_note TEXT,
    UNIQUE KEY uq_equation_dependency (equation_id, depends_on_equation_id, dependency_type),
    CONSTRAINT fk_equation_dependencies_equation
        FOREIGN KEY (equation_id) REFERENCES equations(equation_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_equation_dependencies_parent
        FOREIGN KEY (depends_on_equation_id) REFERENCES equations(equation_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS object_source_links (
    object_source_link_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    object_type ENUM('definition','theorem','lemma','corollary','equation','figure','table','symbol','acronym') NOT NULL,
    object_id BIGINT UNSIGNED NOT NULL,
    source_id BIGINT UNSIGNED NOT NULL,
    usage_type ENUM('primary_source','supporting_source','adapted_from','contrasts','historical_context','verification') NOT NULL,
    note TEXT,
    UNIQUE KEY uq_object_source (object_type, object_id, source_id, usage_type),
    CONSTRAINT fk_object_source_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE VIEW v_pending_source_audit AS
SELECT
    pending_source_id,
    proposed_source_key,
    title,
    authors_text,
    proposed_section_code,
    priority,
    review_status,
    discovered_at,
    reviewed_at
FROM pending_sources
ORDER BY FIELD(review_status,'open','in_review','accepted','merged','rejected'), priority DESC, discovered_at;

CREATE VIEW v_definition_register AS
SELECT
    d.definition_number,
    ds.section_code,
    ds.title AS section_title,
    d.title,
    d.definition_text,
    d.word_latex,
    d.provenance,
    s.citation_number AS source_citation_number,
    d.validation_status
FROM definitions d
JOIN dissertation_sections ds ON ds.section_id = d.section_id
LEFT JOIN sources s ON s.source_id = d.source_id
ORDER BY d.definition_number;

CREATE VIEW v_statement_register AS
SELECT 'theorem' AS statement_type, t.theorem_number AS statement_number,
       ds.section_code, t.title, t.statement_text, t.word_latex,
       t.provenance, s.citation_number AS source_citation_number, t.validation_status
FROM theorems t
JOIN dissertation_sections ds ON ds.section_id=t.section_id
LEFT JOIN sources s ON s.source_id=t.source_id
UNION ALL
SELECT 'lemma', l.lemma_number, ds.section_code, l.title, l.statement_text, l.word_latex,
       l.provenance, s.citation_number, l.validation_status
FROM lemmas l
JOIN dissertation_sections ds ON ds.section_id=l.section_id
LEFT JOIN sources s ON s.source_id=l.source_id
UNION ALL
SELECT 'corollary', c.corollary_number, ds.section_code, c.title, c.statement_text, c.word_latex,
       c.provenance, s.citation_number, c.validation_status
FROM corollaries c
JOIN dissertation_sections ds ON ds.section_id=c.section_id
LEFT JOIN sources s ON s.source_id=c.source_id;

CREATE VIEW v_figure_register AS
SELECT f.figure_number, ds.section_code, f.title, f.caption, f.file_name, f.file_path,
       f.provenance, s.citation_number AS source_citation_number, f.validation_status
FROM figures f
JOIN dissertation_sections ds ON ds.section_id=f.section_id
LEFT JOIN sources s ON s.source_id=f.source_id
ORDER BY f.figure_number;

CREATE VIEW v_table_register AS
SELECT t.table_number, ds.section_code, t.title, t.caption, t.file_name, t.file_path,
       t.provenance, s.citation_number AS source_citation_number, t.validation_status
FROM dissertation_tables t
JOIN dissertation_sections ds ON ds.section_id=t.section_id
LEFT JOIN sources s ON s.source_id=t.source_id
ORDER BY t.table_number;

CREATE VIEW v_symbol_register AS
SELECT s.symbol_latex, s.symbol_word_latex, s.symbol_name, s.definition_text,
       s.scope_type, ds.section_code AS first_section_code, e.equation_number AS first_equation_number,
       s.unit_text, s.domain_text, s.codomain_text, s.validation_status
FROM symbols s
LEFT JOIN dissertation_sections ds ON ds.section_id=s.first_section_id
LEFT JOIN equations e ON e.equation_id=s.first_equation_id
ORDER BY s.symbol_name, s.symbol_latex;

CREATE VIEW v_acronym_register AS
SELECT a.acronym, a.full_form, a.explanation, ds.section_code AS first_section_code,
       a.category, a.is_project_specific, a.validation_status
FROM acronyms a
LEFT JOIN dissertation_sections ds ON ds.section_id=a.first_section_id
ORDER BY a.acronym;

CREATE VIEW v_section_inventory AS
SELECT
    ds.section_code,
    ds.title,
    ds.status,
    COUNT(DISTINCT su.source_id) AS source_count,
    COUNT(DISTINCT e.equation_id) AS equation_count,
    COUNT(DISTINCT d.definition_id) AS definition_count,
    COUNT(DISTINCT th.theorem_id) AS theorem_count,
    COUNT(DISTINCT l.lemma_id) AS lemma_count,
    COUNT(DISTINCT c.corollary_id) AS corollary_count,
    COUNT(DISTINCT f.figure_id) AS figure_count,
    COUNT(DISTINCT dt.table_id) AS table_count
FROM dissertation_sections ds
LEFT JOIN source_usage su ON su.section_id=ds.section_id
LEFT JOIN equations e ON e.section_id=ds.section_id
LEFT JOIN definitions d ON d.section_id=ds.section_id
LEFT JOIN theorems th ON th.section_id=ds.section_id
LEFT JOIN lemmas l ON l.section_id=ds.section_id
LEFT JOIN corollaries c ON c.section_id=ds.section_id
LEFT JOIN figures f ON f.section_id=ds.section_id
LEFT JOIN dissertation_tables dt ON dt.section_id=ds.section_id
GROUP BY ds.section_id, ds.section_code, ds.title, ds.status
ORDER BY ds.section_order;

SET FOREIGN_KEY_CHECKS = 1;
-- FRZK-RKB repository extension seed v2.0
USE frzk_rkb;
SET NAMES utf8mb4;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary)
VALUES
('RKB-2026-07-11-V2','2026-07-11 16:00:00','repository','frzk_rkb','2.0',
 'Erweiterung der FRZK-RKB zu einem vollständigen Dissertations-Repository.');

-- Initial acronyms
INSERT INTO acronyms
(acronym,full_form,explanation,first_section_id,language_code,category,is_project_specific,validation_status,created_revision_id)
VALUES
('FRZK','Funktionales Raum-Zeit-Kohärenzsystem',
 'Zentrale, in dieser Dissertation entwickelte Theorie zur funktionalen Herleitung von Raum, Zeit und Kohärenz.',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.1'),'de','Theorie',1,'checked',
 (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2')),
('ZFC','Zermelo-Fraenkel-Mengenlehre mit Auswahlaxiom',
 'International verbreitete axiomatische Grundlage großer Teile der modernen Mathematik.',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.1'),'de','Mathematik',0,'draft',
 (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'));

-- Global symbols from the two existing equations
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,
 validation_status,created_revision_id)
VALUES
('\\longrightarrow','\\longrightarrow','gerichteter Entwicklungspfeil',
 'Kennzeichnet in den schematischen Gleichungen eine logisch oder funktional gerichtete Entwicklungsfolge.',
 'global',(SELECT section_id FROM dissertation_sections WHERE section_code='3.1.5'),'checked',
 (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'));

-- Initial definitions already explicitly present in the existing chapter logic
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,
 validation_status,created_revision_id)
VALUES
('Def. 3.1.1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.1.3'),
 'Funktionale Theorie von Raum und Zeit',
 'Eine funktionale Theorie von Raum und Zeit führt Raum und Zeit nicht als primitive Begriffe ein, sondern verlangt ihre Herleitung aus allgemeineren funktionalen Prinzipien.',
 NULL,NULL,'original',NULL,'checked',
 (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'));

-- Initial figures and tables are registered as planned repository objects.
INSERT INTO figures
(figure_number,section_id,title,caption,figure_type,provenance,validation_status,created_revision_id)
VALUES
('Abb. 3.P1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.4'),
 'Geplante Übersicht der funktionalen Entwicklungsfolge',
 'Geplante schematische Darstellung der Entwicklung von funktionalen Axiomen über Rekursion und Kohärenz zu Raum und Zeit.',
 'schema','original','draft',
 (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'));

INSERT INTO dissertation_tables
(table_number,section_id,title,caption,table_schema_json,table_data_json,provenance,validation_status,created_revision_id)
VALUES
('Tab. 3.P1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.4'),
 'Geplantes Gleichungskataster Kapitel 3',
 'Geplante Zusammenstellung aller Gleichungen aus Kapitel 3 mit Textstelle, Nummer, Word-LaTeX und Herkunft.',
 JSON_OBJECT('columns',JSON_ARRAY('Textstelle','Gleichungsnummer','Word-LaTeX','Herkunft')),
 JSON_ARRAY(),
 'original','draft',
 (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'));

-- Initial equation dependency: equation 3.2 contrasts equation 3.1
INSERT INTO equation_dependencies
(equation_id,depends_on_equation_id,dependency_type,dependency_note)
VALUES
((SELECT equation_id FROM equations WHERE equation_number='3.2'),
 (SELECT equation_id FROM equations WHERE equation_number='3.1'),
 'contrasts',
 'Die FRZK-Entwicklungsrichtung wird der klassischen Entwicklungsrichtung gegenübergestellt.');

-- Initial change-log entries
INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary)
VALUES
((SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.1'),
 'acronym_added','acronym','FRZK','FRZK in das globale Abkürzungsverzeichnis aufgenommen.'),
((SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.1.3'),
 'definition_added','definition','Def. 3.1.1','Erste repositoryweite Definition registriert.'),
((SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-11-V2'),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.1.5'),
 'symbol_added','symbol','\\longrightarrow','Gerichteten Entwicklungspfeil in das Symbolverzeichnis aufgenommen.');

-- ============================================================
-- FRZK-RKB V3.0: zusätzliche Erweiterungen
-- Beweise, Annahmen, Axiome und axiomatische Abhängigkeiten
-- ============================================================
USE frzk_rkb;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP VIEW IF EXISTS v_axiom_register;
DROP VIEW IF EXISTS v_assumption_register;
DROP VIEW IF EXISTS v_proof_register;

CREATE TABLE IF NOT EXISTS proofs (
    proof_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proof_number VARCHAR(50),
    section_id BIGINT UNSIGNED NOT NULL,
    theorem_id BIGINT UNSIGNED NULL,
    lemma_id BIGINT UNSIGNED NULL,
    corollary_id BIGINT UNSIGNED NULL,
    title VARCHAR(500),
    proof_text LONGTEXT NOT NULL,
    proof_latex LONGTEXT,
    proof_method ENUM('direct','contradiction','induction','construction','equivalence','existence','uniqueness','computational','other') NOT NULL DEFAULT 'direct',
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    KEY idx_proofs_section (section_id),
    KEY idx_proofs_theorem (theorem_id),
    KEY idx_proofs_lemma (lemma_id),
    KEY idx_proofs_corollary (corollary_id),
    CONSTRAINT fk_proofs_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_proofs_theorem FOREIGN KEY (theorem_id) REFERENCES theorems(theorem_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_proofs_lemma FOREIGN KEY (lemma_id) REFERENCES lemmas(lemma_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_proofs_corollary FOREIGN KEY (corollary_id) REFERENCES corollaries(corollary_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_proofs_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_proofs_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS assumptions (
    assumption_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    assumption_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    assumption_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT,
    word_latex LONGTEXT,
    derivation_from_research_gap LONGTEXT,
    status ENUM('proposed','accepted','rejected','superseded') NOT NULL DEFAULT 'proposed',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_assumption_number (assumption_number),
    CONSTRAINT fk_assumptions_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_assumptions_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS axioms (
    axiom_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    axiom_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    axiom_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT,
    word_latex LONGTEXT,
    motivation LONGTEXT,
    independence_note LONGTEXT,
    consistency_note LONGTEXT,
    operationalization_note LONGTEXT,
    source_assumption_id BIGINT UNSIGNED NULL,
    status ENUM('draft','review','accepted','revised','rejected') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_axiom_number (axiom_number),
    CONSTRAINT fk_axioms_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_axioms_assumption FOREIGN KEY (source_assumption_id) REFERENCES assumptions(assumption_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_axioms_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS axiom_dependencies (
    axiom_dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    axiom_id BIGINT UNSIGNED NOT NULL,
    depends_on_axiom_id BIGINT UNSIGNED NOT NULL,
    dependency_type ENUM('depends_on','extends','specializes','contrasts','independent_of') NOT NULL,
    note TEXT,
    UNIQUE KEY uq_axiom_dependency (axiom_id, depends_on_axiom_id, dependency_type),
    CONSTRAINT fk_axiom_dependencies_axiom FOREIGN KEY (axiom_id) REFERENCES axioms(axiom_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_axiom_dependencies_parent FOREIGN KEY (depends_on_axiom_id) REFERENCES axioms(axiom_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS object_dependencies (
    object_dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    object_type_from ENUM('definition','theorem','lemma','corollary','proof','equation','assumption','axiom','figure','table') NOT NULL,
    object_id_from BIGINT UNSIGNED NOT NULL,
    object_type_to ENUM('definition','theorem','lemma','corollary','proof','equation','assumption','axiom','figure','table') NOT NULL,
    object_id_to BIGINT UNSIGNED NOT NULL,
    dependency_type ENUM('depends_on','derives_from','supports','contrasts','generalizes','specializes','validates') NOT NULL,
    note TEXT,
    UNIQUE KEY uq_object_dependency (object_type_from,object_id_from,object_type_to,object_id_to,dependency_type)
) ENGINE=InnoDB;

CREATE VIEW v_proof_register AS
SELECT p.proof_number, ds.section_code, p.title, p.proof_method, p.provenance,
       s.citation_number AS source_citation_number, p.validation_status
FROM proofs p
JOIN dissertation_sections ds ON ds.section_id=p.section_id
LEFT JOIN sources s ON s.source_id=p.source_id
ORDER BY ds.section_order, p.proof_number;

CREATE VIEW v_assumption_register AS
SELECT a.assumption_number, ds.section_code, a.title, a.assumption_text,
       a.word_latex, a.status
FROM assumptions a
JOIN dissertation_sections ds ON ds.section_id=a.section_id
ORDER BY ds.section_order, a.assumption_number;

CREATE VIEW v_axiom_register AS
SELECT a.axiom_number, ds.section_code, a.title, a.axiom_text, a.word_latex,
       a.status, asm.assumption_number AS based_on_assumption
FROM axioms a
JOIN dissertation_sections ds ON ds.section_id=a.section_id
LEFT JOIN assumptions asm ON asm.assumption_id=a.source_assumption_id
ORDER BY ds.section_order, a.axiom_number;

-- Kapitel-3.2-Anforderungen als vorbereitete Datensätze
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary)
VALUES
('RKB-2026-07-12-K3.2-V3','2026-07-12 12:00:00','chapter','3.2','3.0',
 'Erweiterung um Beweise, Annahmen und Axiome; Vorbereitung des Übergangs von Kapitel 3.2 zu Kapitel 3.3.')
ON DUPLICATE KEY UPDATE summary=VALUES(summary);

SET @rev_v3 = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-2026-07-12-K3.2-V3');

INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,status,created_revision_id)
SELECT 'A-3.2-1',section_id,'Entstehung funktionaler Zustände',
       'Eine weiterführende Theorie muss die Entstehung funktionaler Zustände beschreiben, ohne diese als primitive Objekte vorauszusetzen.',
       'Abgeleitet aus den Grenzen von Mengenlehre, Zustandsraumtheorie und Funktionalanalysis.',
       'accepted',@rev_v3
FROM dissertation_sections WHERE section_code='3.2.13'
ON DUPLICATE KEY UPDATE assumption_text=VALUES(assumption_text),status=VALUES(status);

INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,status,created_revision_id)
SELECT 'A-3.2-2',section_id,'Entstehung funktionaler Relationen',
       'Eine weiterführende Theorie muss erklären, wie Relationen aus funktionalen Wechselwirkungen entstehen.',
       'Abgeleitet aus der statischen Voraussetzung von Relationen und Graphen.',
       'accepted',@rev_v3
FROM dissertation_sections WHERE section_code='3.2.13'
ON DUPLICATE KEY UPDATE assumption_text=VALUES(assumption_text),status=VALUES(status);

INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,status,created_revision_id)
SELECT 'A-3.2-3',section_id,'Rekursive Operatorbildung',
       'Eine weiterführende Theorie muss die rekursive Bildung und Modifikation von Operatoren ermöglichen.',
       'Abgeleitet aus der klassischen Voraussetzung fest vorgegebener Operatoren.',
       'accepted',@rev_v3
FROM dissertation_sections WHERE section_code='3.2.13'
ON DUPLICATE KEY UPDATE assumption_text=VALUES(assumption_text),status=VALUES(status);

INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,status,created_revision_id)
SELECT 'A-3.2-4',section_id,'Dynamische Zustandsraumentstehung',
       'Eine weiterführende Theorie muss die Entwicklung des Zustandsraumes selbst beschreiben.',
       'Abgeleitet aus der Voraussetzung fester Zustandsräume in klassischen dynamischen Systemen.',
       'accepted',@rev_v3
FROM dissertation_sections WHERE section_code='3.2.13'
ON DUPLICATE KEY UPDATE assumption_text=VALUES(assumption_text),status=VALUES(status);

INSERT INTO assumptions
(assumption_number,section_id,title,assumption_text,derivation_from_research_gap,status,created_revision_id)
SELECT 'A-3.2-5',section_id,'Kohärenz als emergente Eigenschaft',
       'Eine weiterführende Theorie muss Kohärenz als emergente Folge rekursiver funktionaler Prozesse formulieren.',
       'Abgeleitet aus den Grenzen statischer Metriken, Korrelationen und klassischer Emergenzmodelle.',
       'accepted',@rev_v3
FROM dissertation_sections WHERE section_code='3.2.13'
ON DUPLICATE KEY UPDATE assumption_text=VALUES(assumption_text),status=VALUES(status);

-- Vorläufige Axiome für Kapitel 3.3; Status bleibt bewusst draft.
INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,motivation,source_assumption_id,status,created_revision_id)
SELECT 'A1',section_id,'Existenz funktionaler Differenzierbarkeit',
       'Es existiert mindestens eine funktionale Unterscheidung, aus der weitere funktionale Zustände hervorgehen können.',
       'Antwort auf die Anforderung A-3.2-1.',
       (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-1'),'draft',@rev_v3
FROM dissertation_sections WHERE section_code='3.3'
ON DUPLICATE KEY UPDATE axiom_text=VALUES(axiom_text),status=VALUES(status);

INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,motivation,source_assumption_id,status,created_revision_id)
SELECT 'A2',section_id,'Funktionale Relationierung',
       'Jede funktionale Unterscheidung kann in Relation zu mindestens einer weiteren funktionalen Unterscheidung treten.',
       'Antwort auf die Anforderung A-3.2-2.',
       (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-2'),'draft',@rev_v3
FROM dissertation_sections WHERE section_code='3.3'
ON DUPLICATE KEY UPDATE axiom_text=VALUES(axiom_text),status=VALUES(status);

INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,motivation,source_assumption_id,status,created_revision_id)
SELECT 'A3',section_id,'Rekursive Operatorbildung',
       'Funktionale Relationen können Operatoren hervorbringen, die auf funktionale Zustände und auf Operatoren selbst wirken.',
       'Antwort auf die Anforderung A-3.2-3.',
       (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-3'),'draft',@rev_v3
FROM dissertation_sections WHERE section_code='3.3'
ON DUPLICATE KEY UPDATE axiom_text=VALUES(axiom_text),status=VALUES(status);

INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,motivation,source_assumption_id,status,created_revision_id)
SELECT 'A4',section_id,'Dynamische Zustandsraumerweiterung',
       'Die rekursive Anwendung funktionaler Operatoren kann neue Zustandsdimensionen und Zustandsräume erzeugen.',
       'Antwort auf die Anforderung A-3.2-4.',
       (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-4'),'draft',@rev_v3
FROM dissertation_sections WHERE section_code='3.3'
ON DUPLICATE KEY UPDATE axiom_text=VALUES(axiom_text),status=VALUES(status);

INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,motivation,source_assumption_id,status,created_revision_id)
SELECT 'A5',section_id,'Emergente Kohärenzbildung',
       'Stabile rekursive Kopplungen funktionaler Zustände bilden Kohärenzstrukturen, aus denen Raum- und Zeitordnungen hervorgehen können.',
       'Antwort auf die Anforderung A-3.2-5.',
       (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-5'),'draft',@rev_v3
FROM dissertation_sections WHERE section_code='3.3'
ON DUPLICATE KEY UPDATE axiom_text=VALUES(axiom_text),status=VALUES(status);

SET FOREIGN_KEY_CHECKS = 1;

-- Ende FRZK-RKB V3.0
