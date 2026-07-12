-- ============================================================
-- FRZK-RKB: vollständiges Abschlussskript für Kapitel 3.4
-- Grundlage:
--   frzk_rkb_aktualisiert_nach_3_3_neufassung_korrigiert.sql
--
-- Nummerierungsstand nach Import:
--   Literatur: unverändert [1] bis [52]
--   nächste freie Literaturnummer: [53]
--   Gleichungen 3.4: (3.100) bis (3.148), insgesamt 49
--   nächste freie Gleichungsnummer: (3.149)
--
-- Status:
--   Kapitel 3.4 = review
--   Definitionen/Lemmata/Sätze/Korollare = checked
--   Beweise = draft, da eine mathematische Endprüfung noch aussteht
-- ============================================================

USE frzk_rkb;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-2026-07-12-K3.4-COMPLETE',NOW(),'chapter','3.4','1.0',
 'Vollständiger Abschlussimport für Kapitel 3.4: Abschnittsstruktur, Gleichungen, Definitionen, Lemmata, Sätze, Korollare, Beweise, Symbole, Zähler und Validierungen.',
 'Olaf Thiele / ChatGPT',
 (SELECT MAX(r2.revision_id) FROM repository_revisions r2))
ON DUPLICATE KEY UPDATE
 revision_date=VALUES(revision_date),
 version_label=VALUES(version_label),
 summary=VALUES(summary);

SET @revision_id=(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-12-K3.4-COMPLETE'
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
VALUES
(NULL,'3.4','Mathematische Rekonstruktion funktionaler Organisation',3,3.5000,'review',1,
 'Mathematische Eigenleistung: Rekonstruktion funktionaler Differenz-, Relations-, Transformations-, Organisations-, Zustands-, Kohärenz-, Raum- und Zeitstrukturen.')
ON DUPLICATE KEY UPDATE
 title=VALUES(title),
 section_order=VALUES(section_order),
 status='review',
 is_original_contribution=1,
 notes=VALUES(notes);

SET @section_34=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4');


INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
VALUES
(@section_34,'3.4.0','Einleitung',3,3.5001,'review',1,NULL),
(@section_34,'3.4.1','Konstruktion funktionaler Differenzstrukturen',3,3.5100,'review',1,NULL),
(@section_34,'3.4.2','Konstruktion funktionaler Relationen',3,3.5200,'review',1,NULL),
(@section_34,'3.4.3','Konstruktion rekursiver Transformationen',3,3.5300,'review',1,NULL),
(@section_34,'3.4.4','Konstruktion funktionaler Organisationsräume',3,3.5400,'review',1,NULL),
(@section_34,'3.4.5','Konstruktion funktionaler Zustandsräume',3,3.5500,'review',1,NULL),
(@section_34,'3.4.6','Konstruktion funktionaler Kohärenz',3,3.5600,'review',1,NULL),
(@section_34,'3.4.7','Rekonstruktion funktionaler Raumstrukturen',3,3.5700,'review',1,NULL),
(@section_34,'3.4.8','Rekonstruktion funktionaler Zeitstrukturen',3,3.5800,'review',1,NULL),
(@section_34,'3.4.9','Zusammenfassung der mathematischen Rekonstruktion',3,3.5900,'review',1,NULL),
(@section_34,'3.4.10','Wissenschaftliche Konsequenzen der mathematischen Rekonstruktion',3,3.6000,'review',1,NULL)
ON DUPLICATE KEY UPDATE
 parent_section_id=VALUES(parent_section_id),
 title=VALUES(title),
 section_order=VALUES(section_order),
 status='review',
 is_original_contribution=1;

SET @sec_340=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.0');
SET @sec_341=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1');
SET @sec_342=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2');
SET @sec_343=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3');
SET @sec_344=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.4');
SET @sec_345=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5');
SET @sec_346=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.6');
SET @sec_347=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.7');
SET @sec_348=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.8');
SET @sec_349=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.9');
SET @sec_3410=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.10');

-- Vorhandene 3.4-Inhalte für einen idempotenten Neuaufbau entfernen.
DELETE pd
FROM proposition_dependencies pd
JOIN propositions p ON p.proposition_id=pd.proposition_id
JOIN dissertation_sections ds ON ds.section_id=p.section_id
WHERE ds.section_code LIKE '3.4%';

DELETE FROM proofs
WHERE section_id IN (SELECT section_id FROM dissertation_sections WHERE section_code LIKE '3.4%');

DELETE FROM corollaries
WHERE section_id IN (SELECT section_id FROM dissertation_sections WHERE section_code LIKE '3.4%');

DELETE FROM lemmas
WHERE section_id IN (SELECT section_id FROM dissertation_sections WHERE section_code LIKE '3.4%');

DELETE FROM theorems
WHERE section_id IN (SELECT section_id FROM dissertation_sections WHERE section_code LIKE '3.4%');

DELETE FROM definitions
WHERE section_id IN (SELECT section_id FROM dissertation_sections WHERE section_code LIKE '3.4%');

DELETE FROM symbols
WHERE first_section_id IN (SELECT section_id FROM dissertation_sections WHERE section_code LIKE '3.4%');

DELETE FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 100 AND 148;

DELETE su
FROM source_usage su
JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE ds.section_code LIKE '3.4%';


-- Gleichungen (3.100) bis (3.148)

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.100',@sec_341,'Funktionale Differenzabbildung','\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}','\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}','Definition einer nichtnegativen funktionalen Differenzabbildung.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.101',@sec_341,'Funktionale Identität','\\Delta_F(\\omega_i,\\omega_j)=0','\\Delta_F(\\omega_i,\\omega_j)=0','Funktionale Identität zweier Konfigurationen.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.102',@sec_341,'Nichtnegativität','\\Delta_F(\\omega_i,\\omega_j)\\ge0','\\Delta_F(\\omega_i,\\omega_j)\\ge0','Nichtnegativität der funktionalen Differenzabbildung.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.103',@sec_341,'Reflexivität funktionaler Identität','\\Delta_F(\\omega,\\omega)=0','\\Delta_F(\\omega,\\omega)=0','Eine Konfiguration unterscheidet sich funktional nicht von sich selbst.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.104',@sec_341,'Funktionale Differenzstruktur','\\left(\\Omega_F,\\Delta_F\\right)','\\left(\\Omega_F,\\Delta_F\\right)','Geordnetes Paar aus Trägermenge und Differenzabbildung.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.105',@sec_342,'Funktionale Relation','\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F','\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F','Relation auf der Trägermenge funktionaler Konfigurationen.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.106',@sec_342,'Aktive funktionale Relation','\\Delta_F(\\omega_i,\\omega_j)>0','\\Delta_F(\\omega_i,\\omega_j)>0','Aktive Relation bei positiver funktionaler Differenz.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.107',@sec_342,'Triviale Relation','(\\omega,\\omega)\\in\\mathcal{R}_F','(\\omega,\\omega)\\in\\mathcal{R}_F','Identitätsrelation einer funktionalen Konfiguration.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.108',@sec_342,'Nichttriviale Relation','\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F','\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F','Positive Differenz induziert eine aktive Relation.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.109',@sec_342,'Funktionale Relationsstruktur','\\left(\\Omega_F,\\mathcal{R}_F\\right)','\\left(\\Omega_F,\\mathcal{R}_F\\right)','Struktur aus Konfigurationen und funktionalen Relationen.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.110',@sec_342,'Übergang zur Relationsstruktur','(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)','(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)','Übergang von Differenz- zu Relationsstruktur.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.111',@sec_343,'Funktionaler Transformationsoperator','\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','Operator auf funktionalen Relationen.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.112',@sec_343,'Rekursive Transformation','\\mathcal{T}_F^{\\,n}=\\underbrace{\\mathcal{T}_F\\circ\\mathcal{T}_F\\circ\\cdots\\circ\\mathcal{T}_F}_{n\\text{-mal}}','\\mathcal{T}_F^{\\,n}=\\underbrace{\\mathcal{T}_F\\circ\\mathcal{T}_F\\circ\\cdots\\circ\\mathcal{T}_F}_{n\\text{-mal}}','n-fache Komposition des Transformationsoperators.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.113',@sec_343,'Abgeschlossenheit unter Transformation','\\mathcal{T}_F(r)\\in\\mathcal{R}_F','\\mathcal{T}_F(r)\\in\\mathcal{R}_F','Transformierte Relationen verbleiben in der Relationsstruktur.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.114',@sec_343,'Rekursive Abgeschlossenheit','\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F','\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F','Abgeschlossenheit unter beliebig endlicher Iteration.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.115',@sec_343,'Funktionaler Transformationsraum','\\left(\\mathcal{R}_F,\\mathcal{T}_F\\right)','\\left(\\mathcal{R}_F,\\mathcal{T}_F\\right)','Struktur aus Relationsraum und Transformationsoperator.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.116',@sec_343,'Übergang zum Transformationsraum','(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)','(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)','Übergang von Relations- zu Transformationsstruktur.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.117',@sec_344,'Organisationserzeugende Transformation','\\exists\\,\\mathcal{O}\\subseteq\\mathcal{R}_F:\\quad\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}','\\exists\\,\\mathcal{O}\\subseteq\\mathcal{R}_F:\\quad\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}','Existenz einer invarianten Relationsstruktur.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.118',@sec_344,'Funktionaler Organisationsraum','\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)','\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)','Geordnetes Paar aus Organisationsstruktur und Transformation.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.119',@sec_344,'Strukturerhaltung','\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}','\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}','Invarianz der Organisation unter rekursiver Transformation.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.120',@sec_344,'Abgeschlossenheit des Organisationsraums','\\mathcal{T}_F(r)\\in\\mathcal{O}','\\mathcal{T}_F(r)\\in\\mathcal{O}','Transformation einer Relation innerhalb der Organisation.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.121',@sec_344,'Existenz funktionaler Organisationsräume','\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F','\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F','Organisationserzeugende Transformationen begründen Organisationsräume.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.122',@sec_344,'Rekursive Abgeschlossenheit der Organisation','\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}','\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}','Korollar zur rekursiven Invarianz.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.123',@sec_345,'Funktionaler Zustand','x\\in\\mathcal{X}_F','x\\in\\mathcal{X}_F','Zugehörigkeit eines funktionalen Zustands zum Zustandsbestand.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.124',@sec_345,'Funktionaler Zustandsraum','\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)','\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)','Tripel aus Zuständen, Organisation und Transformation.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.125',@sec_345,'Abgeschlossenheit des Zustandsraums','\\mathcal{T}_F(x)\\in\\mathcal{X}_F','\\mathcal{T}_F(x)\\in\\mathcal{X}_F','Transformierte Zustände verbleiben im Zustandsraum.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.126',@sec_345,'Erreichbarkeit funktionaler Zustände','x_j=\\mathcal{T}_F^{\\,n}(x_i)','x_j=\\mathcal{T}_F^{\\,n}(x_i)','Erreichbarkeit eines Zustands durch endliche Transformation.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.127',@sec_345,'Existenz funktionaler Zustandsräume','\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F','\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F','Organisationsräume begründen zugehörige Zustandsräume.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.128',@sec_345,'Interne Transformationsstruktur','\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F','\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F','Transformationsoperator auf dem Zustandsraum.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.129',@sec_346,'Funktionale Kohärenz','\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}','\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}','Invarianz einer kohärenten Zustandsmenge.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.130',@sec_346,'Kohärenzoperator','\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','Zuordnung von Zuständen zu kohärenten Organisationsstrukturen.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.131',@sec_346,'Erhaltung der Kohärenz','\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}','\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}','Rekursive Invarianz kohärenter Zustandsmengen.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.132',@sec_346,'Existenz kohärenter Teilräume','\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F','\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F','Existenz mindestens einer kohärenten Teilstruktur.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.133',@sec_346,'Existenz funktionaler Kohärenz','\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F','\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F','Zustandsräume besitzen mindestens eine Kohärenzstruktur.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.134',@sec_346,'Einbettung der Kohärenzstruktur','\\mathcal{K}_F\\subseteq\\mathcal{X}_F','\\mathcal{K}_F\\subseteq\\mathcal{X}_F','Kohärenzstrukturen sind Teil des Zustandsraums.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.135',@sec_347,'Funktionale Erreichbarkeit','x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)','x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)','Erreichbarkeitsrelation zwischen funktionalen Zuständen.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.136',@sec_347,'Reflexivität der Erreichbarkeit','x\\leadsto x','x\\leadsto x','Jeder funktionale Zustand ist von sich selbst erreichbar.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.137',@sec_347,'Transitivität der Erreichbarkeit','x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k','x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k','Transitivität der funktionalen Erreichbarkeitsrelation.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.138',@sec_347,'Funktionale Raumstruktur','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)','Raumstruktur aus Zuständen und Erreichbarkeitsrelation.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.139',@sec_347,'Rekonstruktion des Raumbegriffs','\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F','\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F','Zustandsräume induzieren funktionale Raumstrukturen.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.140',@sec_347,'Koordinatenfreie Raumstruktur','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)','Raum ist vollständig durch funktionale Erreichbarkeit bestimmt.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.141',@sec_348,'Transformationsordnung','x_i\\prec_T x_j\\Longleftrightarrow\\exists\\,n>0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)','x_i\\prec_T x_j\\Longleftrightarrow\\exists\\,n>0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)','Strikte Ordnung funktionaler Zustände durch positive Transformationsanzahl.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.142',@sec_348,'Funktionale Zeitstruktur','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)','Zeitstruktur aus Raumstruktur und Transformationsordnung.',
 'definition','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.143',@sec_348,'Irreflexivität der Transformationsordnung','x\\not\\prec_T x','x\\not\\prec_T x','Kein Zustand liegt in der Transformationsordnung vor sich selbst.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.144',@sec_348,'Transitivität der Transformationsordnung','x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k','x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k','Transitivität der funktionalen Transformationsordnung.',
 'lemma','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.145',@sec_348,'Rekonstruktion der Zeitstruktur','\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F','\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F','Funktionale Raumstrukturen induzieren Zeitstrukturen.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.146',@sec_348,'Transformationsbestimmte Zeitstruktur','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)','Zeit wird durch die Ordnung rekursiver Transformationen bestimmt.',
 'derived','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.147',@sec_349,'Leitgleichung der Rekonstruktion','\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F','\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F','Vollständige mathematische Rekonstruktionskette des FRZK.',
 'schema','original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.148',@sec_3410,'Zusammenfassender Hauptsatz des Kapitels','\\boxed{\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F}','\\boxed{\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F}','Gerahmte Zusammenfassung der vollständigen FRZK-Rekonstruktion.',
 'schema','original',NULL,NULL,NULL,'checked',@revision_id);

-- Definitionen Def. 3.4.1 bis Def. 3.4.17

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.1',@sec_341,'Funktionale Konfiguration','Eine funktionale Konfiguration ist ein abstraktes mathematisches Objekt, das ausschließlich durch seine funktionalen Eigenschaften charakterisiert wird.','\\omega\\in\\Omega_F','\\omega\\in\\Omega_F',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.2',@sec_341,'Funktionale Differenzabbildung','Die funktionale Differenzabbildung ordnet jedem Paar funktionaler Konfigurationen einen nichtnegativen Wert ihrer funktionalen Verschiedenheit zu.','\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}','\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.3',@sec_341,'Funktionale Identität','Zwei funktionale Konfigurationen heißen funktional identisch, wenn ihre funktionale Differenz gleich null ist.','\\Delta_F(\\omega_i,\\omega_j)=0','\\Delta_F(\\omega_i,\\omega_j)=0',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.4',@sec_342,'Funktionale Relation','Eine funktionale Relation ist eine Relation auf der Trägermenge funktionaler Konfigurationen.','\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F','\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.5',@sec_342,'Aktive Relation','Eine funktionale Relation heißt aktiv, wenn die funktionale Differenz der verbundenen Konfigurationen positiv ist.','\\Delta_F(\\omega_i,\\omega_j)>0','\\Delta_F(\\omega_i,\\omega_j)>0',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.6',@sec_343,'Funktionaler Transformationsoperator','Ein funktionaler Transformationsoperator bildet funktionale Relationen auf funktionale Relationen ab.','\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F','\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.7',@sec_343,'Rekursive Transformation','Eine Transformation heißt rekursiv, wenn ihre wiederholte Komposition zulässig ist.','\\mathcal{T}_F^{\\,n}','\\mathcal{T}_F^{\\,n}',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.8',@sec_344,'Organisationserzeugende Transformation','Eine Transformation heißt organisationserzeugend, wenn sie eine nichttriviale invariante Relationsstruktur hervorbringt.','\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}','\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.9',@sec_344,'Funktionaler Organisationsraum','Ein funktionaler Organisationsraum ist das geordnete Paar aus einer invarianten Organisationsstruktur und dem auf ihr wirkenden Transformationsoperator.','\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)','\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.10',@sec_345,'Funktionaler Zustand','Ein funktionaler Zustand ist eine eindeutig beschreibbare funktionale Konfiguration innerhalb eines Organisationsraums.','x\\in\\mathcal{X}_F','x\\in\\mathcal{X}_F',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.11',@sec_345,'Funktionaler Zustandsraum','Der funktionale Zustandsraum ist das Tripel aus Zustandsmenge, Organisationsstruktur und Transformationsoperator.','\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)','\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.12',@sec_346,'Funktionale Kohärenz','Eine Zustandsmenge heißt funktional kohärent, wenn sie unter rekursiven Transformationen invariant bleibt.','\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}','\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.13',@sec_346,'Kohärenzoperator','Der Kohärenzoperator ordnet funktionalen Zuständen kohärente Organisationsstrukturen zu.','\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F','\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.14',@sec_347,'Funktionale Erreichbarkeit','Ein Zustand ist von einem anderen funktional erreichbar, wenn eine endliche Folge rekursiver Transformationen ihn hervorbringt.','x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)','x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.15',@sec_347,'Funktionale Raumstruktur','Die funktionale Raumstruktur ist das Paar aus funktionalem Zustandsraum und Erreichbarkeitsrelation.','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.16',@sec_348,'Transformationsordnung','Die Transformationsordnung ordnet Zustände nach ihrer Erzeugung durch eine positive Anzahl rekursiver Transformationen.','x_i\\prec_T x_j','x_i\\prec_T x_j',
 'original',NULL,NULL,NULL,'checked',@revision_id);
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Def. 3.4.17',@sec_348,'Funktionale Zeitstruktur','Die funktionale Zeitstruktur ist das Paar aus funktionaler Raumstruktur und Transformationsordnung.','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)',
 'original',NULL,NULL,NULL,'checked',@revision_id);

-- Lemmata Lemma 3.4.1 bis Lemma 3.4.16

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.1',@sec_341,'Nichtnegativität','Für alle funktionalen Konfigurationen ist die funktionale Differenz nichtnegativ.','\\Delta_F(\\omega_i,\\omega_j)\\ge0','\\Delta_F(\\omega_i,\\omega_j)\\ge0',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.2',@sec_341,'Reflexivität der funktionalen Identität','Jede funktionale Konfiguration besitzt zu sich selbst die Differenz null.','\\Delta_F(\\omega,\\omega)=0','\\Delta_F(\\omega,\\omega)=0',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.3',@sec_342,'Existenz trivialer Relationen','Jede funktionale Konfiguration besitzt die Identitätsrelation zu sich selbst.','(\\omega,\\omega)\\in\\mathcal{R}_F','(\\omega,\\omega)\\in\\mathcal{R}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.4',@sec_342,'Existenz nichttrivialer Relationen','Positive funktionale Differenz begründet eine aktive funktionale Relation.','\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F','\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.5',@sec_343,'Abgeschlossenheit unter Transformation','Die Transformation einer funktionalen Relation ist wieder eine funktionale Relation.','\\mathcal{T}_F(r)\\in\\mathcal{R}_F','\\mathcal{T}_F(r)\\in\\mathcal{R}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.6',@sec_343,'Rekursive Abgeschlossenheit','Jede endliche Iteration des Transformationsoperators verbleibt in der Relationsstruktur.','\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F','\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.7',@sec_344,'Strukturerhaltung','Eine invariante Organisationsstruktur bleibt unter jeder endlichen Iteration erhalten.','\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}','\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.8',@sec_344,'Abgeschlossenheit des Organisationsraums','Die Transformation einer Relation der Organisation verbleibt in der Organisation.','\\mathcal{T}_F(r)\\in\\mathcal{O}','\\mathcal{T}_F(r)\\in\\mathcal{O}',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.9',@sec_345,'Abgeschlossenheit des Zustandsraums','Transformierte funktionale Zustände verbleiben im Zustandsraum.','\\mathcal{T}_F(x)\\in\\mathcal{X}_F','\\mathcal{T}_F(x)\\in\\mathcal{X}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.10',@sec_345,'Erreichbarkeit funktionaler Zustände','Ein funktionaler Zustand kann durch eine endliche Transformationsfolge aus einem anderen hervorgehen.','x_j=\\mathcal{T}_F^{\\,n}(x_i)','x_j=\\mathcal{T}_F^{\\,n}(x_i)',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.11',@sec_346,'Erhaltung der Kohärenz','Kohärente Zustandsmengen bleiben unter jeder endlichen Iteration invariant.','\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}','\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.12',@sec_346,'Existenz kohärenter Teilräume','Ein funktionaler Organisationsraum besitzt mindestens eine kohärente Teilstruktur.','\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F','\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.13',@sec_347,'Reflexivität der Erreichbarkeit','Jeder funktionale Zustand ist von sich selbst erreichbar.','x\\leadsto x','x\\leadsto x',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.14',@sec_347,'Transitivität der Erreichbarkeit','Die funktionale Erreichbarkeitsrelation ist transitiv.','x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k','x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.15',@sec_348,'Irreflexivität der Transformationsordnung','Kein Zustand liegt in der strikten Transformationsordnung vor sich selbst.','x\\not\\prec_T x','x\\not\\prec_T x',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.16',@sec_348,'Transitivität der Transformationsordnung','Die funktionale Transformationsordnung ist transitiv.','x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k','x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k',
 'original',NULL,NULL,'checked',@revision_id);

-- Sätze Satz 3.4.1 bis Satz 3.4.8

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.1',@sec_341,'Existenz einer funktionalen Differenzstruktur','Das Paar aus funktionalen Konfigurationen und Differenzabbildung bildet eine funktionale Differenzstruktur.','(\\Omega_F,\\Delta_F)','(\\Omega_F,\\Delta_F)',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.2',@sec_342,'Funktionale Relationsstruktur','Das Paar aus funktionalen Konfigurationen und funktionaler Relation bildet eine funktionale Relationsstruktur.','(\\Omega_F,\\mathcal{R}_F)','(\\Omega_F,\\mathcal{R}_F)',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.3',@sec_343,'Existenz rekursiver Transformationsräume','Das Paar aus Relationsstruktur und Transformationsoperator bildet einen funktionalen Transformationsraum.','(\\mathcal{R}_F,\\mathcal{T}_F)','(\\mathcal{R}_F,\\mathcal{T}_F)',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.4',@sec_344,'Existenz funktionaler Organisationsräume','Existiert eine organisationserzeugende Transformation, so existiert ein funktionaler Organisationsraum.','\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F','\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.5',@sec_345,'Existenz funktionaler Zustandsräume','Jeder funktionale Organisationsraum besitzt mindestens einen zugehörigen funktionalen Zustandsraum.','\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F','\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.6',@sec_346,'Existenz funktionaler Kohärenz','Jeder funktionale Zustandsraum besitzt mindestens eine funktional kohärente Organisationsstruktur.','\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F','\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.7',@sec_347,'Rekonstruktion des Raumbegriffs','Jeder funktionale Zustandsraum induziert eine funktionale Raumstruktur.','\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F','\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F',
 'original',NULL,NULL,'checked',@revision_id);
INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.8',@sec_348,'Rekonstruktion der Zeitstruktur','Jede funktionale Raumstruktur induziert eine funktionale Zeitstruktur.','\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F','\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F',
 'original',NULL,NULL,'checked',@revision_id);

-- Korollare Korollar 3.4.1 bis Korollar 3.4.7

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.1',@sec_342,'Übergang zur Relationsstruktur','Jede funktionale Differenzstruktur besitzt eine zugehörige funktionale Relationsstruktur.','(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)','(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.2'),
 NULL,'original',NULL,'checked',@revision_id);
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.2',@sec_343,'Übergang zum Transformationsraum','Jede funktionale Relationsstruktur besitzt eine zugehörige Transformationsstruktur.','(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)','(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.3'),
 NULL,'original',NULL,'checked',@revision_id);
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.3',@sec_344,'Rekursive Abgeschlossenheit','Jeder funktionale Organisationsraum ist unter rekursiven Transformationen abgeschlossen.','\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}','\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.4'),
 NULL,'original',NULL,'checked',@revision_id);
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.4',@sec_345,'Interne Transformationsstruktur','Jede rekursive Transformation induziert eine Abbildung auf dem funktionalen Zustandsraum.','\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F','\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.5'),
 NULL,'original',NULL,'checked',@revision_id);
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.5',@sec_346,'Einbettung der Kohärenzstruktur','Jede funktionale Kohärenzstruktur ist Bestandteil eines funktionalen Zustandsraums.','\\mathcal{K}_F\\subseteq\\mathcal{X}_F','\\mathcal{K}_F\\subseteq\\mathcal{X}_F',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.6'),
 NULL,'original',NULL,'checked',@revision_id);
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.6',@sec_347,'Koordinatenfreie Raumstruktur','Der rekonstruierte Raumbegriff ist durch Zustände und Erreichbarkeit bestimmt.','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)','\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.7'),
 NULL,'original',NULL,'checked',@revision_id);
INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,
 parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.7',@sec_348,'Transformationsbestimmte Zeitstruktur','Die funktionale Zeitstruktur ist vollständig durch die Transformationsordnung bestimmt.','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)','\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)',
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.8'),
 NULL,'original',NULL,'checked',@revision_id);

-- Beweisregister: bewusst Status draft bis zur mathematischen Endprüfung

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.1',@sec_341,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.1'),NULL,
 'Beweis zu Lemma 3.4.1','Beweisentwurf zu Lemma 3.4.1: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.1.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.2',@sec_341,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.2'),NULL,
 'Beweis zu Lemma 3.4.2','Beweisentwurf zu Lemma 3.4.2: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.1.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.3',@sec_342,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.3'),NULL,
 'Beweis zu Lemma 3.4.3','Beweisentwurf zu Lemma 3.4.3: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.2.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.4',@sec_342,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.4'),NULL,
 'Beweis zu Lemma 3.4.4','Beweisentwurf zu Lemma 3.4.4: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.2.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.5',@sec_343,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.5'),NULL,
 'Beweis zu Lemma 3.4.5','Beweisentwurf zu Lemma 3.4.5: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.3.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.6',@sec_343,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.6'),NULL,
 'Beweis zu Lemma 3.4.6','Beweisentwurf zu Lemma 3.4.6: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.3.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.7',@sec_344,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.7'),NULL,
 'Beweis zu Lemma 3.4.7','Beweisentwurf zu Lemma 3.4.7: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.4.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.8',@sec_344,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.8'),NULL,
 'Beweis zu Lemma 3.4.8','Beweisentwurf zu Lemma 3.4.8: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.4.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.9',@sec_345,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.9'),NULL,
 'Beweis zu Lemma 3.4.9','Beweisentwurf zu Lemma 3.4.9: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.5.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.10',@sec_345,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.10'),NULL,
 'Beweis zu Lemma 3.4.10','Beweisentwurf zu Lemma 3.4.10: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.5.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.11',@sec_346,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.11'),NULL,
 'Beweis zu Lemma 3.4.11','Beweisentwurf zu Lemma 3.4.11: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.6.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.12',@sec_346,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.12'),NULL,
 'Beweis zu Lemma 3.4.12','Beweisentwurf zu Lemma 3.4.12: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.6.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.13',@sec_347,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.13'),NULL,
 'Beweis zu Lemma 3.4.13','Beweisentwurf zu Lemma 3.4.13: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.7.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.14',@sec_347,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.14'),NULL,
 'Beweis zu Lemma 3.4.14','Beweisentwurf zu Lemma 3.4.14: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.7.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.15',@sec_348,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.15'),NULL,
 'Beweis zu Lemma 3.4.15','Beweisentwurf zu Lemma 3.4.15: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.8.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.16',@sec_348,NULL,
 (SELECT lemma_id FROM lemmas WHERE lemma_number='Lemma 3.4.16'),NULL,
 'Beweis zu Lemma 3.4.16','Beweisentwurf zu Lemma 3.4.16: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.8.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.17',@sec_341,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.1'),NULL,NULL,
 'Beweis zu Satz 3.4.1','Beweisentwurf zu Satz 3.4.1: Der Satz folgt aus den in Abschnitt 3.4.1 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.18',@sec_342,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.2'),NULL,NULL,
 'Beweis zu Satz 3.4.2','Beweisentwurf zu Satz 3.4.2: Der Satz folgt aus den in Abschnitt 3.4.2 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.19',@sec_343,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.3'),NULL,NULL,
 'Beweis zu Satz 3.4.3','Beweisentwurf zu Satz 3.4.3: Der Satz folgt aus den in Abschnitt 3.4.3 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.20',@sec_344,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.4'),NULL,NULL,
 'Beweis zu Satz 3.4.4','Beweisentwurf zu Satz 3.4.4: Der Satz folgt aus den in Abschnitt 3.4.4 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.21',@sec_345,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.5'),NULL,NULL,
 'Beweis zu Satz 3.4.5','Beweisentwurf zu Satz 3.4.5: Der Satz folgt aus den in Abschnitt 3.4.5 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.22',@sec_346,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.6'),NULL,NULL,
 'Beweis zu Satz 3.4.6','Beweisentwurf zu Satz 3.4.6: Der Satz folgt aus den in Abschnitt 3.4.6 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.23',@sec_347,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.7'),NULL,NULL,
 'Beweis zu Satz 3.4.7','Beweisentwurf zu Satz 3.4.7: Der Satz folgt aus den in Abschnitt 3.4.7 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.24',@sec_348,
 (SELECT theorem_id FROM theorems WHERE theorem_number='Satz 3.4.8'),NULL,NULL,
 'Beweis zu Satz 3.4.8','Beweisentwurf zu Satz 3.4.8: Der Satz folgt aus den in Abschnitt 3.4.8 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.25',@sec_342,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.1'),
 'Beweis zu Korollar 3.4.1','Beweisentwurf zu Korollar 3.4.1: Das Korollar folgt unmittelbar aus Satz 3.4.2 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.26',@sec_343,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.2'),
 'Beweis zu Korollar 3.4.2','Beweisentwurf zu Korollar 3.4.2: Das Korollar folgt unmittelbar aus Satz 3.4.3 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.27',@sec_344,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.3'),
 'Beweis zu Korollar 3.4.3','Beweisentwurf zu Korollar 3.4.3: Das Korollar folgt unmittelbar aus Satz 3.4.4 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.28',@sec_345,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.4'),
 'Beweis zu Korollar 3.4.4','Beweisentwurf zu Korollar 3.4.4: Das Korollar folgt unmittelbar aus Satz 3.4.5 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.29',@sec_346,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.5'),
 'Beweis zu Korollar 3.4.5','Beweisentwurf zu Korollar 3.4.5: Das Korollar folgt unmittelbar aus Satz 3.4.6 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.30',@sec_347,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.6'),
 'Beweis zu Korollar 3.4.6','Beweisentwurf zu Korollar 3.4.6: Das Korollar folgt unmittelbar aus Satz 3.4.7 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);
INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,
 proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.31',@sec_348,NULL,NULL,
 (SELECT corollary_id FROM corollaries WHERE corollary_number='Korollar 3.4.7'),
 'Beweis zu Korollar 3.4.7','Beweisentwurf zu Korollar 3.4.7: Das Korollar folgt unmittelbar aus Satz 3.4.8 und den zugehörigen Definitionen.',NULL,
 'direct','original',NULL,'draft',@revision_id);

-- Symbolverzeichnis Kapitel 3.4

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\Omega_F','\\Omega_F','Funktionale Konfigurationsmenge','Trägermenge aller funktionalen Konfigurationen.','chapter',
 @sec_341,(SELECT equation_id FROM equations WHERE equation_number='3.100'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\omega','\\omega','Funktionale Konfiguration','Einzelne funktionale Konfiguration.','chapter',
 @sec_341,(SELECT equation_id FROM equations WHERE equation_number='3.101'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\Delta_F','\\Delta_F','Funktionale Differenzabbildung','Nichtnegative Abbildung zur Beschreibung funktionaler Verschiedenheit.','chapter',
 @sec_341,(SELECT equation_id FROM equations WHERE equation_number='3.100'),
 NULL,NULL,NULL,0,0,1,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathcal{R}_F','\\mathcal{R}_F','Funktionale Relationsstruktur','Menge funktionaler Relationen.','chapter',
 @sec_342,(SELECT equation_id FROM equations WHERE equation_number='3.105'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathcal{T}_F','\\mathcal{T}_F','Funktionaler Transformationsoperator','Rekursiver Operator auf Relationen oder Zuständen.','chapter',
 @sec_343,(SELECT equation_id FROM equations WHERE equation_number='3.111'),
 NULL,NULL,NULL,0,0,1,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathcal{O}','\\mathcal{O}','Invariante Organisationsstruktur','Unter Transformationen invariante Teilstruktur.','chapter',
 @sec_344,(SELECT equation_id FROM equations WHERE equation_number='3.117'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathfrak{O}_F','\\mathfrak{O}_F','Funktionaler Organisationsraum','Paar aus Organisationsstruktur und Transformationsoperator.','chapter',
 @sec_344,(SELECT equation_id FROM equations WHERE equation_number='3.118'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathcal{X}_F','\\mathcal{X}_F','Funktionale Zustandsmenge','Menge aller funktionalen Zustände.','chapter',
 @sec_345,(SELECT equation_id FROM equations WHERE equation_number='3.123'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathfrak{X}_F','\\mathfrak{X}_F','Funktionaler Zustandsraum','Tripel aus Zuständen, Organisation und Transformation.','chapter',
 @sec_345,(SELECT equation_id FROM equations WHERE equation_number='3.124'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathcal{K}','\\mathcal{K}','Kohärente Zustandsmenge','Unter Transformationen invariante Zustandsmenge.','chapter',
 @sec_346,(SELECT equation_id FROM equations WHERE equation_number='3.129'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathcal{K}_F','\\mathcal{K}_F','Funktionale Kohärenzstruktur','Menge beziehungsweise Klasse funktional kohärenter Strukturen.','chapter',
 @sec_346,(SELECT equation_id FROM equations WHERE equation_number='3.130'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\Psi_F','\\Psi_F','Kohärenzoperator','Zuordnung von Zuständen zu Kohärenzstrukturen.','chapter',
 @sec_346,(SELECT equation_id FROM equations WHERE equation_number='3.130'),
 NULL,NULL,NULL,0,0,1,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\leadsto','\\leadsto','Funktionale Erreichbarkeitsrelation','Erreichbarkeit durch eine endliche Folge rekursiver Transformationen.','chapter',
 @sec_347,(SELECT equation_id FROM equations WHERE equation_number='3.135'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathfrak{R}_F','\\mathfrak{R}_F','Funktionale Raumstruktur','Paar aus Zustandsmenge und Erreichbarkeitsrelation.','chapter',
 @sec_347,(SELECT equation_id FROM equations WHERE equation_number='3.138'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\prec_T','\\prec_T','Funktionale Transformationsordnung','Strikte Ordnung funktionaler Zustände durch Transformationen.','chapter',
 @sec_348,(SELECT equation_id FROM equations WHERE equation_number='3.141'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\mathfrak{T}_F','\\mathfrak{T}_F','Funktionale Zeitstruktur','Paar aus Raumstruktur und Transformationsordnung.','chapter',
 @sec_348,(SELECT equation_id FROM equations WHERE equation_number='3.142'),
 NULL,NULL,NULL,0,0,0,
 NULL,'checked',@revision_id);

-- Kapitel 3.4 führt in der vorliegenden Fassung keine neue Literaturquelle ein.
-- Die nächste freie Literaturnummer bleibt [53].

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('next_citation_number','53'),
('next_equation_number','3.149'),
('last_completed_section','3.4'),
('last_repository_revision','RKB-2026-07-12-K3.4-COMPLETE')
ON DUPLICATE KEY UPDATE
 counter_value=VALUES(counter_value),
 updated_at=NOW();

DELETE FROM section_change_log WHERE revision_id=@revision_id;

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_34,'created','chapter','3.4',
 'Kapitel 3.4 als vollständige mathematische Rekonstruktion funktionaler Organisation registriert.',
 NULL,'3.4.0 bis 3.4.10'),
(@revision_id,@section_34,'equation_added','equations','(3.100)–(3.148)',
 '49 fortlaufend nummerierte Gleichungen registriert.',NULL,NULL),
(@revision_id,@section_34,'definition_added','definitions','Def. 3.4.1–Def. 3.4.17',
 '17 originäre Definitionen registriert.',NULL,NULL),
(@revision_id,@section_34,'statement_added','lemmas','Lemma 3.4.1–Lemma 3.4.16',
 '16 Lemmata registriert.',NULL,NULL),
(@revision_id,@section_34,'statement_added','theorems','Satz 3.4.1–Satz 3.4.8',
 '8 Sätze registriert.',NULL,NULL),
(@revision_id,@section_34,'statement_added','corollaries','Korollar 3.4.1–Korollar 3.4.7',
 '7 Korollare registriert.',NULL,NULL),
(@revision_id,@section_34,'proof_added','proofs','Bew. 3.4.1–Bew. 3.4.31',
 '31 Beweisdatensätze im Status draft registriert.',NULL,NULL),
(@revision_id,@section_34,'symbol_added','symbols','Symbolverzeichnis 3.4',
 '16 zentrale Symbole der mathematischen Rekonstruktion registriert.',NULL,NULL),
(@revision_id,@section_34,'source_reused','literature','keine neue Quelle',
 'Die nächste freie Literaturnummer bleibt [53].',NULL,'[53]'),
(@revision_id,@section_34,'status_changed','section','3.4',
 'Kapitel 3.4 auf Status review gesetzt.',NULL,'review');

DELETE FROM repository_validation_results WHERE revision_id=@revision_id;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_EQUATION_COUNT',
       IF(COUNT(*)=49,'passed','failed'),'49',CAST(COUNT(*) AS CHAR),
       'Anzahl der Gleichungen (3.100) bis (3.148).'
FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 100 AND 148;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_DEFINITION_COUNT',
       IF(COUNT(*)=17,'passed','failed'),'17',CAST(COUNT(*) AS CHAR),
       'Anzahl der Definitionen in Kapitel 3.4.'
FROM definitions d
JOIN dissertation_sections ds ON ds.section_id=d.section_id
WHERE ds.section_code LIKE '3.4%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_LEMMA_COUNT',
       IF(COUNT(*)=16,'passed','failed'),'16',CAST(COUNT(*) AS CHAR),
       'Anzahl der Lemmata in Kapitel 3.4.'
FROM lemmas l
JOIN dissertation_sections ds ON ds.section_id=l.section_id
WHERE ds.section_code LIKE '3.4%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_THEOREM_COUNT',
       IF(COUNT(*)=8,'passed','failed'),'8',CAST(COUNT(*) AS CHAR),
       'Anzahl der Sätze in Kapitel 3.4.'
FROM theorems t
JOIN dissertation_sections ds ON ds.section_id=t.section_id
WHERE ds.section_code LIKE '3.4%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_COROLLARY_COUNT',
       IF(COUNT(*)=7,'passed','failed'),'7',CAST(COUNT(*) AS CHAR),
       'Anzahl der Korollare in Kapitel 3.4.'
FROM corollaries c
JOIN dissertation_sections ds ON ds.section_id=c.section_id
WHERE ds.section_code LIKE '3.4%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_PROOF_COUNT',
       IF(COUNT(*)=31,'passed','failed'),'31',CAST(COUNT(*) AS CHAR),
       'Anzahl der Beweisdatensätze in Kapitel 3.4.'
FROM proofs p
JOIN dissertation_sections ds ON ds.section_id=p.section_id
WHERE ds.section_code LIKE '3.4%';

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_4_NEW_SOURCE_COUNT',
       IF(COUNT(*)=0,'passed','warning'),'0',CAST(COUNT(*) AS CHAR),
       'Kapitel 3.4 führt in der aktuellen Fassung keine neue Literaturquelle ein.'
FROM sources
WHERE first_citation_section_code LIKE '3.4%';

COMMIT;

-- Kontrollausgaben
SELECT section_code,title,status
FROM dissertation_sections
WHERE section_code LIKE '3.4%'
ORDER BY section_order;

SELECT equation_number,title,word_latex,validation_status
FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 100 AND 148
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number,title,validation_status
FROM definitions d
JOIN dissertation_sections ds ON ds.section_id=d.section_id
WHERE ds.section_code LIKE '3.4%'
ORDER BY definition_number;

SELECT theorem_number,title,validation_status
FROM theorems t
JOIN dissertation_sections ds ON ds.section_id=t.section_id
WHERE ds.section_code LIKE '3.4%'
ORDER BY theorem_number;

SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
