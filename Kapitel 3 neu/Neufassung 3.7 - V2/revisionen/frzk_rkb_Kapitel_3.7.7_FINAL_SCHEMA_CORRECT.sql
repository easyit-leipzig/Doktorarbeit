/* =========================================================================
   FRZK-RKB Repository Update
   Kapitel 3.7.7
   Validierung der Operatorenkaskade - Final
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.7 anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.7',
 'Validierung der Operatorenkaskade',
 3,
 3.7700,
 'in_progress',
 1,
 'Kapitel 3.7.7 Validierung der Operatorenkaskade, inkl. Kohärenz- und Integritätsprüfung.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.7.7');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.7.7' LIMIT 1);

-- Neue Revision erzeugen
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.7.7-V1', NOW(), 'section', '3.7.7', '1.0',
 'Validierung der Operatorenkaskade im FRZK',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.7-V1');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.7.7-V1' LIMIT 1);

-- Gleichung 3.453: Validierungsfunktion
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.453', @section_id, 'Validierungsfunktion',
 'V(S_{t+1}) = \begin{cases}1 & \text{wenn } K(S_{t+1}) \ge \kappa_{\min} \text{ und alle Relationen gültig} \\ 0 & \text{sonst}\end{cases}',
 'V(S_{t+1}) = ...',
 'Bewertung, ob jeder Folgezustand die minimale Kohärenz erfüllt und alle Relationen gültig sind.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.453');

-- Definition der Validierungsfunktion
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT
 @section_id, 'D-3.7.7-1',
 'Validierungsfunktion der Operatorenkaskade',
 'Die Validierungsfunktion V überprüft, ob ein Folgezustand S_{t+1} die minimale Kohärenz erfüllt und alle Relationen intakt sind. V(S_{t+1})=1 bedeutet gültig, V(S_{t+1})=0 bedeutet inkonsistent.',
 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.7.7-1');

-- Symbole
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'V','V','Validierungsfunktion','Funktion zur Überprüfung der Kohärenz und relationalen Integrität eines Folgezustands.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='V');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT '\kappa_{\min}','kappa_min','Minimal-Kohärenz','Mindestwert für Kohärenz eines Zustands.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\kappa_{\min}');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id,@section_id,'created','section','3.7.7','Kapitel 3.7.7 Validierung der Operatorenkaskade angelegt.',NULL,'in_progress');

COMMIT;