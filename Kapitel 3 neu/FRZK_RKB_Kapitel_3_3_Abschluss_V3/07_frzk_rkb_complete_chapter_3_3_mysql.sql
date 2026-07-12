-- ============================================================
-- FRZK-RKB V3: vollständiges Abschlussskript für Kapitel 3.3
-- Voraussetzung:
--   1. FRZK_RKB_V3_COMPLETE_MYSQL.sql
--   2. 06_frzk_rkb_complete_chapter_3_2_mysql.sql
--
-- Kapitelstatus nach Import: review
-- Neue Literatur: keine
-- Bestehende Literatur: wird über source_usage wiederverwendet
-- Neue Gleichungen: (3.87) bis (3.115), insgesamt 29
-- Nächste freie Gleichungsnummer: (3.116)
-- Nächste freie Literaturnummer bleibt: [53]
-- ============================================================

USE frzk_rkb;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;

-- Zusätzliche, für die überarbeitete Fassung 3.3.6 notwendige Tabelle
CREATE TABLE IF NOT EXISTS propositions (
    proposition_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposition_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    logical_derivation LONGTEXT NOT NULL,
    based_on_axioms VARCHAR(255),
    status ENUM('draft','review','accepted','revised','rejected') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_proposition_number (proposition_number),
    CONSTRAINT fk_propositions_section
        FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_propositions_revision
        FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS proposition_dependencies (
    proposition_dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposition_id BIGINT UNSIGNED NOT NULL,
    axiom_id BIGINT UNSIGNED NULL,
    assumption_id BIGINT UNSIGNED NULL,
    dependency_type ENUM('derived_from','uses','motivated_by','contrasts') NOT NULL DEFAULT 'derived_from',
    note TEXT,
    UNIQUE KEY uq_proposition_axiom_dependency (proposition_id, axiom_id, assumption_id, dependency_type),
    CONSTRAINT fk_prop_dep_proposition
        FOREIGN KEY (proposition_id) REFERENCES propositions(proposition_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_prop_dep_axiom
        FOREIGN KEY (axiom_id) REFERENCES axioms(axiom_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_prop_dep_assumption
        FOREIGN KEY (assumption_id) REFERENCES assumptions(assumption_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

START TRANSACTION;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by)
VALUES
('RKB-2026-07-12-K3.3-COMPLETE','2026-07-12 13:00:00','chapter','3.3','1.0',
 'Vollständiger Abschlussimport für Kapitel 3.3: Axiome, Propositionen, Gleichungen, Symbole, Quellenverwendungen und Änderungsprotokoll.',
 'Olaf Thiele / ChatGPT')
ON DUPLICATE KEY UPDATE
 revision_date=VALUES(revision_date),
 version_label=VALUES(version_label),
 summary=VALUES(summary);

SET @revision_id=(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-12-K3.3-COMPLETE'
);

-- Kapitelstruktur 3.3 vollständig anlegen oder aktualisieren
INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution)
VALUES
(NULL,'3.3','Mathematische Axiome des Funktionalen Raum-Zeit-Kohärenzsystems',3,3.4000,'review',TRUE)
ON DUPLICATE KEY UPDATE
 title=VALUES(title),section_order=VALUES(section_order),status='review',is_original_contribution=TRUE;

SET @section_33=(SELECT section_id FROM dissertation_sections WHERE section_code='3.3');

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution)
VALUES
(@section_33,'3.3.0','Einleitung',3,3.4001,'review',TRUE),
(@section_33,'3.3.1','Axiom der funktionalen Unterscheidbarkeit',3,3.4100,'review',TRUE),
(@section_33,'3.3.2','Axiom der funktionalen Relationierung',3,3.4200,'review',TRUE),
(@section_33,'3.3.3','Axiom der rekursiven Operatorbildung',3,3.4300,'review',TRUE),
(@section_33,'3.3.4','Axiom der dynamischen Zustandsraumentstehung',3,3.4400,'review',TRUE),
(@section_33,'3.3.5','Axiom der emergenten Kohärenzbildung',3,3.4500,'review',TRUE),
(@section_33,'3.3.6','Logische Konsequenzen des Axiomensystems',3,3.4600,'review',TRUE)
ON DUPLICATE KEY UPDATE
 parent_section_id=VALUES(parent_section_id),
 title=VALUES(title),
 section_order=VALUES(section_order),
 status='review',
 is_original_contribution=TRUE;


-- Axiome A1 bis A5

INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,formal_latex,word_latex,motivation,
 source_assumption_id,status,created_revision_id)
VALUES
('A1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'Funktionale Unterscheidbarkeit','Es existiert mindestens eine funktionale Differenz zwischen möglichen funktionalen Konfigurationen.','\\Delta_F:\\Omega\\longrightarrow\\{0,1\\},\\qquad\\exists\\,\\omega_i,\\omega_j\\in\\Omega:\\Delta_F(\\omega_i)\\neq\\Delta_F(\\omega_j)','\\Delta_F:\\Omega\\longrightarrow\\{0,1\\},\\qquad\\exists\\,\\omega_i,\\omega_j\\in\\Omega:\\Delta_F(\\omega_i)\\neq\\Delta_F(\\omega_j)','Antwort auf A-3.2-1: Entstehung funktionaler Zustände.',
 (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-1'),
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 axiom_text=VALUES(axiom_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 motivation=VALUES(motivation),
 source_assumption_id=VALUES(source_assumption_id),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,formal_latex,word_latex,motivation,
 source_assumption_id,status,created_revision_id)
VALUES
('A2',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'Funktionale Relationierung','Funktionale Differenzen können miteinander in Beziehung treten und dadurch neue funktionale Zusammenhänge erzeugen.','\\mathcal{R}_F:\\Omega\\times\\Omega\\longrightarrow\\mathbb{R}','\\mathcal{R}_F:\\Omega\\times\\Omega\\longrightarrow\\mathbb{R}','Antwort auf A-3.2-2: Entstehung funktionaler Relationen.',
 (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-2'),
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 axiom_text=VALUES(axiom_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 motivation=VALUES(motivation),
 source_assumption_id=VALUES(source_assumption_id),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,formal_latex,word_latex,motivation,
 source_assumption_id,status,created_revision_id)
VALUES
('A3',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'Rekursive Operatorbildung','Wiederholt auftretende funktionale Relationen erzeugen rekursive Transformationsregeln, die als funktionale Operatoren beschrieben werden können.','\\mathcal{O}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','\\mathcal{O}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','Antwort auf A-3.2-3: rekursive Operatorbildung.',
 (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-3'),
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 axiom_text=VALUES(axiom_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 motivation=VALUES(motivation),
 source_assumption_id=VALUES(source_assumption_id),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,formal_latex,word_latex,motivation,
 source_assumption_id,status,created_revision_id)
VALUES
('A4',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'Dynamische Zustandsraumentstehung','Rekursive funktionale Operatoren erzeugen und erweitern den funktionalen Zustandsraum fortlaufend.','\\Phi:\\mathcal{O}_F\\longrightarrow\\mathcal{X}_F','\\Phi:\\mathcal{O}_F\\longrightarrow\\mathcal{X}_F','Antwort auf A-3.2-4: dynamische Zustandsraumentstehung.',
 (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-4'),
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 axiom_text=VALUES(axiom_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 motivation=VALUES(motivation),
 source_assumption_id=VALUES(source_assumption_id),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,formal_latex,word_latex,motivation,
 source_assumption_id,status,created_revision_id)
VALUES
('A5',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'Emergente Kohärenzbildung','Rekursive funktionale Operatoren erzeugen stabile Kohärenzstrukturen, welche die langfristige Organisation funktionaler Zustände bestimmen.','\\Psi:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','\\Psi:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','Antwort auf A-3.2-5: Kohärenz als emergente Eigenschaft.',
 (SELECT assumption_id FROM assumptions WHERE assumption_number='A-3.2-5'),
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 axiom_text=VALUES(axiom_text),
 formal_latex=VALUES(formal_latex),
 word_latex=VALUES(word_latex),
 motivation=VALUES(motivation),
 source_assumption_id=VALUES(source_assumption_id),
 status='review',
 created_revision_id=@revision_id;

-- Gleichungen (3.87) bis (3.115)

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.87',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 'Axiomatische Entwicklungsrichtung','\\mathcal{A}_{F}\\Longrightarrow\\mathcal{D}_{F}\\Longrightarrow\\mathcal{R}_{F}\\Longrightarrow\\mathcal{O}_{F}\\Longrightarrow\\mathcal{K}_{F}\\Longrightarrow\\mathcal{X}_{F}','\\mathcal{A}_{F}\\Longrightarrow\\mathcal{D}_{F}\\Longrightarrow\\mathcal{R}_{F}\\Longrightarrow\\mathcal{O}_{F}\\Longrightarrow\\mathcal{K}_{F}\\Longrightarrow\\mathcal{X}_{F}','Logische Entwicklungsfolge von der funktionalen Axiomatik zum funktionalen Zustandsraum.','schema','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.88',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 'FRZK-Axiomensystem','\\mathfrak{A}_{\\mathrm{FRZK}}=\\left\\{A_{1},A_{2},A_{3},A_{4},A_{5}\\right\\}','\\mathfrak{A}_{\\mathrm{FRZK}}=\\left\\{A_{1},A_{2},A_{3},A_{4},A_{5}\\right\\}','Menge der fünf Grundaxiome des FRZK.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.89',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'Funktionale Unterscheidungsabbildung','\\Delta_F:\\Omega\\longrightarrow\\{0,1\\},\\qquad\\exists\\,\\omega_i,\\omega_j\\in\\Omega:\\Delta_F(\\omega_i)\\neq\\Delta_F(\\omega_j)','\\Delta_F:\\Omega\\longrightarrow\\{0,1\\},\\qquad\\exists\\,\\omega_i,\\omega_j\\in\\Omega:\\Delta_F(\\omega_i)\\neq\\Delta_F(\\omega_j)','Formale Darstellung mindestens einer funktionalen Differenz.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.90',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'Vollständige funktionale Homogenität','\\forall\\,\\omega_i,\\omega_j\\in\\Omega:\\Delta_F(\\omega_i)=\\Delta_F(\\omega_j)','\\forall\\,\\omega_i,\\omega_j\\in\\Omega:\\Delta_F(\\omega_i)=\\Delta_F(\\omega_j)','Gegenfall vollständiger funktionaler Ununterscheidbarkeit.','schema','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.91',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'Nichttriviale funktionale Differenz','\\Delta_F\\neq0','\\Delta_F\\neq0','Notwendige Bedingung einer nichttrivialen funktionalen Differenz.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.92',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'Funktionale Relationierungsabbildung','\\mathcal{R}_F:\\Omega\\times\\Omega\\longrightarrow\\mathbb{R}','\\mathcal{R}_F:\\Omega\\times\\Omega\\longrightarrow\\mathbb{R}','Allgemeine Abbildung zur Beschreibung funktionaler Beziehungen.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.93',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'Möglichkeit funktionaler Relationierung','\\Delta_F(\\omega_i)\\neq\\Delta_F(\\omega_j)\\Longrightarrow\\exists\\,\\mathcal{R}_F(\\omega_i,\\omega_j)','\\Delta_F(\\omega_i)\\neq\\Delta_F(\\omega_j)\\Longrightarrow\\exists\\,\\mathcal{R}_F(\\omega_i,\\omega_j)','Funktionale Unterscheidbarkeit ermöglicht funktionale Relationierung.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.94',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'Gerichtete funktionale Relation','\\mathcal{R}_F(\\omega_i,\\omega_j)\\neq\\mathcal{R}_F(\\omega_j,\\omega_i)','\\mathcal{R}_F(\\omega_i,\\omega_j)\\neq\\mathcal{R}_F(\\omega_j,\\omega_i)','Zulässigkeit asymmetrischer funktionaler Relationen.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.95',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'Funktionale Relationsstruktur','\\mathcal{G}_F=\\left(\\Omega,\\mathcal{R}_F\\right)','\\mathcal{G}_F=\\left(\\Omega,\\mathcal{R}_F\\right)','Gesamtheit funktionaler Konfigurationen und Relationen.','definition','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.96',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'Funktionaler Operator','\\mathcal{O}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','\\mathcal{O}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','Operator auf funktionalen Relationierungsstrukturen.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.97',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'Rekursive Relationsentwicklung','\\mathcal{R}_F^{(n+1)}=\\mathcal{O}_F\\left(\\mathcal{R}_F^{(n)}\\right)','\\mathcal{R}_F^{(n+1)}=\\mathcal{O}_F\\left(\\mathcal{R}_F^{(n)}\\right)','Rekursive Transformation funktionaler Relationen.','model','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.98',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'Iterierte Operatorwirkung','\\mathcal{R}_F^{(n)}=\\mathcal{O}_F^{\\,n}\\left(\\mathcal{R}_F^{(0)}\\right)','\\mathcal{R}_F^{(n)}=\\mathcal{O}_F^{\\,n}\\left(\\mathcal{R}_F^{(0)}\\right)','n-fache Anwendung des funktionalen Operators.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.99',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'Stabile Relationierungsstruktur','\\lim_{n\\rightarrow\\infty}\\mathcal{R}_F^{(n)}=\\mathcal{R}_F^{\\,*}','\\lim_{n\\rightarrow\\infty}\\mathcal{R}_F^{(n)}=\\mathcal{R}_F^{\\,*}','Konvergenz zu einer funktional stabilen Relationierungsstruktur.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.100',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'Klassische Entwicklungsrichtung','\\mathcal{X}\\Longrightarrow\\mathcal{O}\\Longrightarrow\\mathcal{D}','\\mathcal{X}\\Longrightarrow\\mathcal{O}\\Longrightarrow\\mathcal{D}','Klassische Reihenfolge aus Zustandsraum, Operator und Dynamik.','schema','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.101',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'FRZK-Zustandsraumentstehung','\\mathcal{O}_F\\Longrightarrow\\mathcal{X}_F','\\mathcal{O}_F\\Longrightarrow\\mathcal{X}_F','Funktionaler Zustandsraum als Ergebnis rekursiver Operatorbildung.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.102',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'Zustandsraumentstehungsabbildung','\\Phi:\\mathcal{O}_F\\longrightarrow\\mathcal{X}_F','\\Phi:\\mathcal{O}_F\\longrightarrow\\mathcal{X}_F','Strukturelle Abbildung von Operatoren auf funktionale Zustandsräume.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.103',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'Dynamische Zustandsraumerweiterung','\\mathcal{X}_F^{(n+1)}=\\mathcal{X}_F^{(n)}\\cup\\Phi\\left(\\mathcal{O}_F^{(n)}\\right)','\\mathcal{X}_F^{(n+1)}=\\mathcal{X}_F^{(n)}\\cup\\Phi\\left(\\mathcal{O}_F^{(n)}\\right)','Erweiterung des Zustandsraums durch neue Operatorstrukturen.','model','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.104',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'Nichtabnehmende Zustandsraumdimension','\\dim\\left(\\mathcal{X}_F^{(n+1)}\\right)\\ge\\dim\\left(\\mathcal{X}_F^{(n)}\\right)','\\dim\\left(\\mathcal{X}_F^{(n+1)}\\right)\\ge\\dim\\left(\\mathcal{X}_F^{(n)}\\right)','Zulässigkeit wachsender funktionaler Freiheitsgrade.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.105',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'Operator-Zustandsraum-Rückkopplung','\\mathcal{O}_F^{(n)}\\Longrightarrow\\mathcal{X}_F^{(n+1)}\\Longrightarrow\\mathcal{O}_F^{(n+1)}','\\mathcal{O}_F^{(n)}\\Longrightarrow\\mathcal{X}_F^{(n+1)}\\Longrightarrow\\mathcal{O}_F^{(n+1)}','Rekursive Rückkopplung zwischen Operatoren und Zustandsraum.','model','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.106',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'Kohärenzabbildung','\\Psi:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','\\Psi:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','Abbildung funktionaler Zustandsräume auf Kohärenzstrukturen.','axiom','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.107',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'Kohärenzbedingung','\\lim_{n\\rightarrow\\infty}d\\left(\\mathcal{O}_F^{(n)},\\mathcal{O}_F^{(n+1)}\\right)=0','\\lim_{n\\rightarrow\\infty}d\\left(\\mathcal{O}_F^{(n)},\\mathcal{O}_F^{(n+1)}\\right)=0','Langfristige Stabilisierung aufeinanderfolgender Operatorstrukturen.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.108',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'Funktionale Kohärenzstruktur','\\mathcal{K}_F=\\Psi\\left(\\mathcal{X}_F\\right)','\\mathcal{K}_F=\\Psi\\left(\\mathcal{X}_F\\right)','Funktionale Kohärenz als Ergebnis der Kohärenzabbildung.','definition','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.109',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'Erhalt oder Erweiterung funktionaler Kohärenz','\\mathcal{K}_F^{(n+1)}\\ge\\mathcal{K}_F^{(n)}','\\mathcal{K}_F^{(n+1)}\\ge\\mathcal{K}_F^{(n)}','Nichtnumerische Ordnungsrelation für Erhalt oder Erweiterung von Kohärenz.','derived','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.110',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'Gesamte axiomatische Entwicklungsfolge','\\mathcal{A}_F\\Longrightarrow\\mathcal{D}_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{O}_F\\Longrightarrow\\mathcal{X}_F\\Longrightarrow\\mathcal{K}_F','\\mathcal{A}_F\\Longrightarrow\\mathcal{D}_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{O}_F\\Longrightarrow\\mathcal{X}_F\\Longrightarrow\\mathcal{K}_F','Zusammenfassung der vollständigen funktionalen Entwicklungsfolge.','schema','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.111',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Proposition 3.1','A_1\\land A_2\\Longrightarrow\\exists\\,\\mathcal{R}_F','A_1\\land A_2\\Longrightarrow\\exists\\,\\mathcal{R}_F','Logische Möglichkeit funktionaler Relationen.','theorem','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.112',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Proposition 3.2','\\exists\\mathcal{R}_F\\Longrightarrow\\exists\\mathcal{O}_F','\\exists\\mathcal{R}_F\\Longrightarrow\\exists\\mathcal{O}_F','Logische Möglichkeit rekursiver Operatorbildung.','theorem','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.113',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Proposition 3.3','\\exists\\mathcal{O}_F\\Longrightarrow\\exists\\mathcal{X}_F','\\exists\\mathcal{O}_F\\Longrightarrow\\exists\\mathcal{X}_F','Logische Möglichkeit funktionaler Zustandsraumentstehung.','theorem','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.114',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Proposition 3.4','\\exists\\mathcal{X}_F\\Longrightarrow\\exists\\mathcal{K}_F','\\exists\\mathcal{X}_F\\Longrightarrow\\exists\\mathcal{K}_F','Logische Möglichkeit funktionaler Kohärenzbildung.','theorem','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES
('3.115',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Proposition 3.5','A_1\\Longrightarrow A_2\\Longrightarrow A_3\\Longrightarrow A_4\\Longrightarrow A_5','A_1\\Longrightarrow A_2\\Longrightarrow A_3\\Longrightarrow A_4\\Longrightarrow A_5','Geschlossene axiomatische Entwicklungsrichtung.','theorem','original',NULL,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 equation_latex=VALUES(equation_latex),
 word_latex=VALUES(word_latex),
 plain_description=VALUES(plain_description),
 equation_type=VALUES(equation_type),
 provenance='original',
 source_id=NULL,
 validation_status='checked',
 created_revision_id=@revision_id;

-- Propositionen 3.1 bis 3.5

INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,
 logical_derivation,based_on_axioms,status,created_revision_id)
VALUES
('Prop. 3.1',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Existenz funktionaler Relationen','Aus den Axiomen A1 und A2 folgt, dass funktionale Relationen prinzipiell entstehen können.','A_1\\land A_2\\Longrightarrow\\exists\\,\\mathcal{R}_F','A_1\\land A_2\\Longrightarrow\\exists\\,\\mathcal{R}_F','Axiom A1 führt funktionale Unterscheidbarkeit ein; Axiom A2 ermöglicht Relationierung. Gemeinsam begründen sie die Möglichkeit funktionaler Relationen.','A1,A2',
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 statement_text=VALUES(statement_text),
 statement_latex=VALUES(statement_latex),
 word_latex=VALUES(word_latex),
 logical_derivation=VALUES(logical_derivation),
 based_on_axioms=VALUES(based_on_axioms),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,
 logical_derivation,based_on_axioms,status,created_revision_id)
VALUES
('Prop. 3.2',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Existenz rekursiver Operatorbildung','Aus funktionalen Relationen folgt die Möglichkeit rekursiver Operatorbildung.','\\exists\\mathcal{R}_F\\Longrightarrow\\exists\\mathcal{O}_F','\\exists\\mathcal{R}_F\\Longrightarrow\\exists\\mathcal{O}_F','Axiom A3 beschreibt Operatoren als Folge wiederkehrender funktionaler Relationen.','A3',
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 statement_text=VALUES(statement_text),
 statement_latex=VALUES(statement_latex),
 word_latex=VALUES(word_latex),
 logical_derivation=VALUES(logical_derivation),
 based_on_axioms=VALUES(based_on_axioms),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,
 logical_derivation,based_on_axioms,status,created_revision_id)
VALUES
('Prop. 3.3',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Entstehung funktionaler Zustandsräume','Existieren rekursive Operatoren, so kann ein funktionaler Zustandsraum entstehen.','\\exists\\mathcal{O}_F\\Longrightarrow\\exists\\mathcal{X}_F','\\exists\\mathcal{O}_F\\Longrightarrow\\exists\\mathcal{X}_F','Axiom A4 ordnet der rekursiven Operatorentwicklung die Entstehung eines funktionalen Zustandsraums zu.','A4',
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 statement_text=VALUES(statement_text),
 statement_latex=VALUES(statement_latex),
 word_latex=VALUES(word_latex),
 logical_derivation=VALUES(logical_derivation),
 based_on_axioms=VALUES(based_on_axioms),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,
 logical_derivation,based_on_axioms,status,created_revision_id)
VALUES
('Prop. 3.4',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Entstehung funktionaler Kohärenz','Aus rekursiv entwickelten funktionalen Zustandsräumen kann funktionale Kohärenz entstehen.','\\exists\\mathcal{X}_F\\Longrightarrow\\exists\\mathcal{K}_F','\\exists\\mathcal{X}_F\\Longrightarrow\\exists\\mathcal{K}_F','Axiom A5 beschreibt Kohärenz als emergente Folge rekursiver funktionaler Entwicklungen.','A5',
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 statement_text=VALUES(statement_text),
 statement_latex=VALUES(statement_latex),
 word_latex=VALUES(word_latex),
 logical_derivation=VALUES(logical_derivation),
 based_on_axioms=VALUES(based_on_axioms),
 status='review',
 created_revision_id=@revision_id;
INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,
 logical_derivation,based_on_axioms,status,created_revision_id)
VALUES
('Prop. 3.5',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'Geschlossene Entwicklungsrichtung','Die fünf Axiome definieren gemeinsam eine funktionale Entwicklungsrichtung.','A_1\\Longrightarrow A_2\\Longrightarrow A_3\\Longrightarrow A_4\\Longrightarrow A_5','A_1\\Longrightarrow A_2\\Longrightarrow A_3\\Longrightarrow A_4\\Longrightarrow A_5','Jedes Axiom erweitert den durch die vorhergehenden Axiome bereitgestellten strukturellen Rahmen.','A1,A2,A3,A4,A5',
 'review',@revision_id)
ON DUPLICATE KEY UPDATE
 section_id=VALUES(section_id),
 title=VALUES(title),
 statement_text=VALUES(statement_text),
 statement_latex=VALUES(statement_latex),
 word_latex=VALUES(word_latex),
 logical_derivation=VALUES(logical_derivation),
 based_on_axioms=VALUES(based_on_axioms),
 status='review',
 created_revision_id=@revision_id;

DELETE pd
FROM proposition_dependencies pd
JOIN propositions p ON p.proposition_id=pd.proposition_id
WHERE p.proposition_number LIKE 'Prop. 3.%';

INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.1'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A1'),
 NULL,'derived_from',
 'Prop. 3.1 wird logisch aus A1 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.1'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A2'),
 NULL,'derived_from',
 'Prop. 3.1 wird logisch aus A2 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.2'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A3'),
 NULL,'derived_from',
 'Prop. 3.2 wird logisch aus A3 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.3'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A4'),
 NULL,'derived_from',
 'Prop. 3.3 wird logisch aus A4 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.4'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A5'),
 NULL,'derived_from',
 'Prop. 3.4 wird logisch aus A5 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.5'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A1'),
 NULL,'derived_from',
 'Prop. 3.5 wird logisch aus A1 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.5'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A2'),
 NULL,'derived_from',
 'Prop. 3.5 wird logisch aus A2 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.5'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A3'),
 NULL,'derived_from',
 'Prop. 3.5 wird logisch aus A3 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.5'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A4'),
 NULL,'derived_from',
 'Prop. 3.5 wird logisch aus A4 hergeleitet.');
INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
VALUES
((SELECT proposition_id FROM propositions WHERE proposition_number='Prop. 3.5'),
 (SELECT axiom_id FROM axioms WHERE axiom_number='A5'),
 NULL,'derived_from',
 'Prop. 3.5 wird logisch aus A5 hergeleitet.');

-- Symbolverzeichnis 3.3

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,is_vector,is_matrix,is_operator,
 validation_status,created_revision_id)
VALUES
('\\mathcal{A}_F','\\mathcal{A}_F','funktionale Axiomatik','Gesamtheit der funktionalen Grundaxiome.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 (SELECT equation_id FROM equations WHERE equation_number='3.87'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathfrak{A}_{\\mathrm{FRZK}}','\\mathfrak{A}_{\\mathrm{FRZK}}','FRZK-Axiomensystem','Menge der fünf FRZK-Axiome.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 (SELECT equation_id FROM equations WHERE equation_number='3.88'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\Omega','\\Omega','funktionale Möglichkeitsgesamtheit','Noch nicht geometrisch interpretierte Gesamtheit möglicher funktionaler Konfigurationen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 (SELECT equation_id FROM equations WHERE equation_number='3.89'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\omega_i','\\omega_i','funktionale Konfiguration','Einzelne funktionale Konfiguration.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 (SELECT equation_id FROM equations WHERE equation_number='3.89'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\Delta_F','\\Delta_F','funktionale Differenzabbildung','Abbildung zur Kennzeichnung funktionaler Unterscheidbarkeit.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 (SELECT equation_id FROM equations WHERE equation_number='3.89'),
 0,0,1,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{D}_F','\\mathcal{D}_F','funktionale Unterscheidungen','Gesamtheit funktionaler Differenzen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 (SELECT equation_id FROM equations WHERE equation_number='3.87'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{R}_F','\\mathcal{R}_F','funktionale Relation','Struktur funktionaler Beziehungen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 (SELECT equation_id FROM equations WHERE equation_number='3.92'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{G}_F','\\mathcal{G}_F','funktionale Relationsstruktur','Gesamtheit funktionaler Konfigurationen und Beziehungen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 (SELECT equation_id FROM equations WHERE equation_number='3.95'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{O}_F','\\mathcal{O}_F','funktionaler Operator','Rekursive Transformationsregel funktionaler Relationen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 (SELECT equation_id FROM equations WHERE equation_number='3.96'),
 0,0,1,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{R}_F^{*}','\\mathcal{R}_F^{*}','stabile Relationierungsstruktur','Grenz- oder Stabilitätsstruktur rekursiver Relationierung.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 (SELECT equation_id FROM equations WHERE equation_number='3.99'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\Phi','\\Phi','Zustandsraumentstehungsabbildung','Strukturelle Abbildung von Operatoren auf Zustandsräume.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 (SELECT equation_id FROM equations WHERE equation_number='3.102'),
 0,0,1,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{X}_F','\\mathcal{X}_F','funktionaler Zustandsraum','Aus rekursiven Operatoren hervorgehender Zustandsraum.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 (SELECT equation_id FROM equations WHERE equation_number='3.101'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\Psi','\\Psi','Kohärenzabbildung','Abbildung funktionaler Zustandsräume auf Kohärenzstrukturen.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 (SELECT equation_id FROM equations WHERE equation_number='3.106'),
 0,0,1,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
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
('\\mathcal{K}_F','\\mathcal{K}_F','funktionale Kohärenzstruktur','Stabilisierte funktionale Organisationsform.','chapter',
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 (SELECT equation_id FROM equations WHERE equation_number='3.106'),
 0,0,0,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 symbol_name=VALUES(symbol_name),
 definition_text=VALUES(definition_text),
 first_equation_id=VALUES(first_equation_id),
 is_vector=VALUES(is_vector),
 is_matrix=VALUES(is_matrix),
 is_operator=VALUES(is_operator),
 validation_status='checked',
 created_revision_id=@revision_id;

-- Bestehende Literatur wird ausschließlich wiederverwendet.
DELETE su
FROM source_usage su
JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE ds.section_code LIKE '3.3%';

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=7),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 'background',
 'Wiederverwendung von Quelle [7] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.0',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=8),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 'background',
 'Wiederverwendung von Quelle [8] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.0',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=17),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 'background',
 'Wiederverwendung von Quelle [17] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.0',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=18),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0'),
 'background',
 'Wiederverwendung von Quelle [18] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.0',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=23),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'background',
 'Wiederverwendung von Quelle [23] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.1',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=24),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'background',
 'Wiederverwendung von Quelle [24] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.1',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=25),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'background',
 'Wiederverwendung von Quelle [25] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.1',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=26),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'background',
 'Wiederverwendung von Quelle [26] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.1',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=45),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'background',
 'Wiederverwendung von Quelle [45] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.1',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=46),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1'),
 'background',
 'Wiederverwendung von Quelle [46] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.1',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=27),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'background',
 'Wiederverwendung von Quelle [27] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.2',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=28),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'background',
 'Wiederverwendung von Quelle [28] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.2',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=47),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'background',
 'Wiederverwendung von Quelle [47] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.2',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=48),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2'),
 'background',
 'Wiederverwendung von Quelle [48] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.2',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=12),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [12] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=14),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [14] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=35),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [35] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=36),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [36] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=37),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [37] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=41),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [41] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=42),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [42] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=51),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [51] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=52),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3'),
 'background',
 'Wiederverwendung von Quelle [52] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.3',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=12),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [12] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=14),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [14] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=37),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [37] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=38),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [38] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=39),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [39] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=40),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [40] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=43),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [43] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=44),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [44] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=51),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [51] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=52),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4'),
 'background',
 'Wiederverwendung von Quelle [52] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.4',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=12),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [12] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=14),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [14] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=37),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [37] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=43),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [43] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=44),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [44] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=51),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [51] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=52),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5'),
 'background',
 'Wiederverwendung von Quelle [52] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.5',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=8),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'background',
 'Wiederverwendung von Quelle [8] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.6',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
VALUES
((SELECT source_id FROM sources WHERE citation_number=24),
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'background',
 'Wiederverwendung von Quelle [24] zur Begründung oder Abgrenzung der FRZK-Axiomatik.',
 '3.3.6',FALSE,FALSE,
 'Keine neue Literaturnummer; bestehende Masterquelle wiederverwendet.');

-- Registeransicht für Propositionen
CREATE OR REPLACE VIEW v_proposition_register AS
SELECT
    p.proposition_number,
    ds.section_code,
    p.title,
    p.statement_text,
    p.word_latex,
    p.based_on_axioms,
    p.status
FROM propositions p
JOIN dissertation_sections ds ON ds.section_id=p.section_id
ORDER BY p.proposition_number;

-- Repository-Zähler
INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('next_citation_number','53'),
('next_equation_number','3.116'),
('last_completed_section','3.3'),
('last_repository_revision','RKB-2026-07-12-K3.3-COMPLETE')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

-- Änderungsprotokoll
DELETE FROM section_change_log WHERE revision_id=@revision_id;

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary)
VALUES
(@revision_id,@section_33,'axiom_added','axioms','A1–A5',
 'Fünf FRZK-Axiome auf Status review registriert.'),
(@revision_id,@section_33,'equation_added','equations','(3.87)–(3.115)',
 '29 Gleichungen einschließlich Word-LaTeX registriert.'),
(@revision_id,(SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6'),
 'statement_added','propositions','Prop. 3.1–Prop. 3.5',
 'Fünf logische Propositionen anstelle vorgezogener mathematischer Sätze registriert.'),
(@revision_id,@section_33,'source_reused','sources','bestehende Literatur',
 'Kapitel 3.3 verwendet ausschließlich bereits nummerierte Literaturquellen.'),
(@revision_id,@section_33,'symbol_added','symbols','Symbolverzeichnis 3.3',
 'Zentrale FRZK-Symbole registriert.'),
(@revision_id,@section_33,'status_changed','section','3.3',
 'Kapitel 3.3 auf Status review gesetzt.');

-- Validierungen
DELETE FROM repository_validation_results WHERE revision_id=@revision_id;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_EQUATION_COUNT',
       IF(COUNT(*)=29,'passed','failed'),'29',CAST(COUNT(*) AS CHAR),
       'Anzahl der Gleichungen (3.87) bis (3.115).'
FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 87 AND 115;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_AXIOM_COUNT',
       IF(COUNT(*)=5,'passed','failed'),'5',CAST(COUNT(*) AS CHAR),
       'Anzahl der FRZK-Axiome A1 bis A5.'
FROM axioms
WHERE axiom_number IN ('A1','A2','A3','A4','A5');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_PROPOSITION_COUNT',
       IF(COUNT(*)=5,'passed','failed'),'5',CAST(COUNT(*) AS CHAR),
       'Anzahl der logischen Propositionen in 3.3.6.'
FROM propositions
WHERE proposition_number IN ('Prop. 3.1','Prop. 3.2','Prop. 3.3','Prop. 3.4','Prop. 3.5');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_NEW_SOURCE_COUNT',
       IF(COUNT(*)=0,'passed','warning'),'0',CAST(COUNT(*) AS CHAR),
       'Kapitel 3.3 soll keine neue Literaturnummer anlegen.'
FROM sources
WHERE first_citation_section_code LIKE '3.3%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_AXIOM_ASSUMPTION_LINKS',
       IF(COUNT(*)=5,'passed','failed'),'5',CAST(COUNT(*) AS CHAR),
       'Jedes Axiom muss mit genau einer Anforderung aus 3.2.13 verknüpft sein.'
FROM axioms
WHERE axiom_number IN ('A1','A2','A3','A4','A5')
  AND source_assumption_id IS NOT NULL;

COMMIT;

-- Abschlussberichte
SELECT * FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;

SELECT * FROM v_axiom_register
WHERE section_code LIKE '3.3%'
ORDER BY axiom_number;

SELECT * FROM v_proposition_register
WHERE section_code='3.3.6'
ORDER BY proposition_number;

SELECT * FROM v_equation_register
WHERE section_code LIKE '3.3%'
ORDER BY equation_number;
