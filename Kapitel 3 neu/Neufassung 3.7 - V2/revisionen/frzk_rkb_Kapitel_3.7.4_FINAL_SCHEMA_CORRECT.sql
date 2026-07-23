/* =========================================================================
   FRZK-RKB Kapitel 3.7.4 FINAL - Korrigiert
   Algorithmische Umsetzung der Operatorenkaskade
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.4 anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.4',
 'Algorithmische Umsetzung der Operatorenkaskade',
 3,
 3.7400,
 'in_progress',
 1,
 'Algorithmische Umsetzung der Operatorenkaskade basierend auf parametrisierten Operatoren.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.7.4');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.7.4' LIMIT 1);

-- Neue Revision
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.7.4-V1', NOW(), 'section', '3.7.4', '1.0',
 'Algorithmische Umsetzung der Operatorenkaskade für FRZK',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.4-V1');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.7.4-V1' LIMIT 1);

-- Gleichungen 3.443–3.444
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.443', @section_id, 'Iterativer Ablauf der Operatorenkaskade',
'S_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma)',
'S_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma)',
'Berechnung des nächsten Zustands durch sukzessive Anwendung aller Operatoren.',
'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.443');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.444', @section_id, 'Initialzustand S0',
'S_0 = \emptyset',
'S_0 = \emptyset',
'Ausgangszustand der funktionalen Organisation vor Anwendung der Operatorenkaskade.',
'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.444');

-- Definition
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT
 @section_id, 'D-3.7.4-1',
 'Algorithmische Umsetzung',
 'Die Operatorenkaskade wird algorithmisch umgesetzt, indem jeder Operator sukzessive auf den aktuellen Zustand angewendet wird. Dies ermöglicht Simulation, Analyse und Validierung der Zustandsentwicklung.',
 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.7.4-1');

-- Symbole S_0 und S_{t+1}
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_0','S_0','Initialzustand','Ausgangszustand der Organisation.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_0');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_{t+1}','S_{t+1}','Folgezustand','Zustand nach Anwendung der Operatorenkaskade.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_{t+1}');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id,@section_id,'created','section','3.7.4','Kapitel 3.7.4 Algorithmische Umsetzung der Operatorenkaskade angelegt.',NULL,'in_progress');

COMMIT;
