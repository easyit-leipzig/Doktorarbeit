/* =========================================================================
   FRZK-RKB Repository Update
   Kapitel 3.8
   Anwendung und Simulation der Operatorenkaskade - Final
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.8 anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3'),
 '3.8',
 'Anwendung und Simulation der Operatorenkaskade',
 3,
 3.8000,
 'in_progress',
 1,
 'Simulation der Operatorenkaskade, inkl. Kohärenzprüfung und Analyse der Folgezustände.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.8');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.8' LIMIT 1);

-- Neue Revision erzeugen
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.8-V1', NOW(), 'section', '3.8', '1.0',
 'Simulation und Analyse der Operatorenkaskade',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.8-V1');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.8-V1' LIMIT 1);

-- Gleichung 3.455: Ausgangszustand
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.455', @section_id, 'Ausgangszustand S0',
 'S_0 = \emptyset',
 'S_0 = \emptyset',
 'Initialisierung des Ausgangszustands für die Simulation der Operatorenkaskade.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.455');

-- Gleichung 3.456: Selektionsoperator
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.456', @section_id, 'Selektionsoperator σ',
 'S''_t = \sigma(S_t, \theta_\sigma)',
 'S''_t = \sigma(S_t, \theta_\sigma)',
 'Selektion relevanter Komponenten im Folgezustand.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.456');

-- Gleichung 3.457: Mapping-Operator
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.457', @section_id, 'Mapping-Operator M',
 'S''_t = M(S''_t)',
 'S''_t = M(S''_t)',
 'Bildung funktionaler Relationen zwischen selektierten Komponenten.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.457');

-- Gleichung 3.458: Transformationsoperator
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.458', @section_id, 'Transformationsoperator R',
 'S_{t+1} = R(S''_t)',
 'S_{t+1} = R(S''_t)',
 'Transformation der relationalen Strukturen in neue Zustände.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.458');

-- Gleichung 3.459: Emergenzoperator
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.459', @section_id, 'Emergenzoperator E',
 'S^{(E)}_{t+1} = E(S_{t+1})',
 'S^{(E)}_{t+1} = E(S_{t+1})',
 'Extraktion stabiler emergenter Muster aus den transformierten Zuständen.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.459');

-- Gleichung 3.460: Kohärenzprüfung
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.460', @section_id, 'Kohärenzprüfung',
 'K(S_{t+1}) \ge \kappa_{\min}, \quad V(S_{t+1})=1',
 'K(S_{t+1}) \ge \kappa_{\min}, \quad V(S_{t+1})=1',
 'Validierung, dass jeder Folgezustand die minimale Kohärenz erfüllt und gültig ist.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.460');

-- Definition Kapitel 3.8
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT
 @section_id, 'D-3.8-1',
 'Simulation der Operatorenkaskade',
 'Simulation der Operatorenkaskade zur Analyse der dynamischen Entwicklung funktionaler Zustände, inkl. Kohärenzprüfung und Emergenzvalidierung.',
 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.8-1');

-- Symbole
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_0','S_0','Ausgangszustand','Initialer Zustand der Operatorenkaskade.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_0');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_{t+1}','S_{t+1}','Folgezustand','Zustand nach Anwendung der Operatorenkaskade.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_{t+1}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'K','K','Kohärenzfunktion','Bewertung der Kohärenz eines Folgezustands.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='K');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT '\kappa_{\min}','kappa_min','Minimal-Kohärenz','Minimalwert der Kohärenz zur Validierung.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\kappa_{\min}');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id,@section_id,'created','section','3.8','Kapitel 3.8 Anwendung und Simulation der Operatorenkaskade angelegt.',NULL,'in_progress');

COMMIT;