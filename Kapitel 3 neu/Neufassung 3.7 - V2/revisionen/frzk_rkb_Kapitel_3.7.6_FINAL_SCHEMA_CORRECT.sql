/* =========================================================================
   FRZK-RKB Repository Update
   Kapitel 3.7.6
   Python-Implementierung der Operatorenkaskade - Final
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.6 anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.6',
 'Python-Implementierung der Operatorenkaskade',
 3,
 3.7600,
 'in_progress',
 1,
 'Python-Implementierung der Operatorenkaskade basierend auf den Operatoren σ, M, R, E und Kohärenzprüfung.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.7.6');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.7.6' LIMIT 1);

-- Neue Revision erzeugen
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.7.6-V1', NOW(), 'section', '3.7.6', '1.0',
 'Python-Implementierung der Operatorenkaskade als Dissertationsfassung',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.6-V1');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.7.6-V1' LIMIT 1);

-- Gleichungen 3.447–3.452
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.447', @section_id, 'Ausgangszustand', 'S_0 = \emptyset', 'S_0 = \emptyset', 'Initialisierung des Ausgangszustands der Operatorenkaskade.', 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.447');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.448', @section_id, 'Selektionsoperator σ', 'S''_t = \sigma(S_t, \theta_\sigma)', 'S''_t = \sigma(S_t, \theta_\sigma)', 'Selektionsoperator wählt relevante Komponenten aus.', 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.448');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.449', @section_id, 'Mapping-Operator M', 'S''_t = M(S''_t)', 'S''_t = M(S''_t)', 'Bildet Relationen zwischen ausgewählten Komponenten.', 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.449');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.450', @section_id, 'Transformationsoperator R', 'S_{t+1} = R(S''_t)', 'S_{t+1} = R(S''_t)', 'Transformiert die relationalen Strukturen in neue Zustände.', 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.450');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.451', @section_id, 'Emergenzoperator E', 'S^{(E)}_{t+1} = E(S_{t+1})', 'S^{(E)}_{t+1} = E(S_{t+1})', 'Extrahiert emergente Muster und stabilisierte Strukturen.', 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.451');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT '3.452', @section_id, 'Kohärenzprüfung', 'K(S_{t+1}) \ge \kappa_{\min}', 'K(S_{t+1}) \ge \kappa_{\min}', 'Validierung, dass jeder Folgezustand mindestens die minimale Kohärenz erfüllt.', 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.452');

-- Definition Python-Operatorenkaskade
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT @section_id, 'D-3.7.6-1', 'Python-Operatorenkaskade', 'Simulation der Operatorenkaskade Schritt für Schritt: Initialisierung von S0, sukzessive Anwendung von σ, M, R, E, Kohärenzprüfung, Speicherung der Endzustände.', 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.7.6-1');

-- Symbole
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_0','S_0','Initialzustand','Ausgangszustand der Operatorenkaskade.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_0');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_{t+1}','S_{t+1}','Folgezustand','Zustand nach Anwendung der Operatorenkaskade.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_{t+1}');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id,@section_id,'created','section','3.7.6','Kapitel 3.7.6 Python-Implementierung der Operatorenkaskade angelegt.',NULL,'in_progress');

COMMIT;