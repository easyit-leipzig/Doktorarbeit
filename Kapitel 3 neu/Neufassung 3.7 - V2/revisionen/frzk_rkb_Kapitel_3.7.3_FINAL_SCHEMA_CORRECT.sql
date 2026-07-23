/* =========================================================================
   FRZK-RKB Kapitel 3.7.3 FINAL - Korrigiert
   Parametrisierung und Zustandsübergänge der Operatorenkaskade
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.3 anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.3',
 'Parametrisierung und Zustandsübergänge der Operatorenkaskade',
 3,
 3.7300,
 'in_progress',
 1,
 'Parametrisierung der Operatoren und Darstellung der rekursiven Zustandsübergänge.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.7.3');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.7.3' LIMIT 1);

-- Neue Revision
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.7.3-V1', NOW(), 'section', '3.7.3', '1.0',
 'Parametrisierung und Zustandsübergänge der Operatorenkaskade',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.3-V1');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.7.3-V1' LIMIT 1);

-- Gleichungen 3.441–3.442
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.441', @section_id, 'Parametrisierter Operator',
'S_{t+1} = \mathcal{O}_i(S_t, \theta_i),\quad \theta_i \in \Theta_i',
'S_{t+1} = \mathcal{O}_i(S_t, \theta_i),\quad \theta_i \in \Theta_i',
'Darstellung eines Operators mit Parametern aus Parameterraum Θ_i.',
'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.441');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.442', @section_id, 'Rekursiver Zustandsübergang',
'S_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma)',
'S_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma)',
'Rekursive Anwendung der Operatorenkaskade zur Erzeugung des nächsten Zustands.',
'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.442');

-- Definition
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT
 @section_id, 'D-3.7.3-1',
 'Parametrisierung und Zustandsübergänge',
 'Die Operatoren der Kaskade werden parametrisiert, und jeder Zustandsübergang wird rekursiv aus dem vorherigen Zustand berechnet. Dies ermöglicht Simulation und dynamische Analyse.',
 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.7.3-1');

-- Symbole θ_i und Θ_i
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'θ_i','theta_i','Operatorparameter','Parameter des Operators O_i zur Steuerung der Transformation.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='θ_i');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'Θ_i','Theta_i','Parameterraum','Menge aller gültigen Parameter für Operator O_i.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='Θ_i');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id, @section_id, 'created', 'section', '3.7.3',
'Kapitel 3.7.3 Parametrisierung und Zustandsübergänge der Operatorenkaskade angelegt.',
NULL,'in_progress');

COMMIT;
