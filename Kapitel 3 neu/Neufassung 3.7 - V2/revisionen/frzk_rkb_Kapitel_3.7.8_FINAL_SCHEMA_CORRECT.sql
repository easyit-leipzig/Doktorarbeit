/* =========================================================================
   FRZK-RKB Repository Update
   Kapitel 3.7.8
   Zusammenfassung der Operatorenkaskade und Ausblick
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.8 anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.8',
 'Zusammenfassung der Operatorenkaskade und Ausblick auf 3.8',
 3,
 3.7800,
 'in_progress',
 1,
 'Kapitel 3.7.8 fasst die Operatorenkaskade zusammen und gibt Ausblick auf 3.8'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.7.8');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.7.8' LIMIT 1);

-- Neue Revision erzeugen
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.7.8-V1', NOW(), 'section', '3.7.8', '1.0',
 'Zusammenfassung der Operatorenkaskade und Ausblick auf 3.8',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.8-V1');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.7.8-V1' LIMIT 1);

-- Gleichung 3.454: Zusammenfassung der Kaskade
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.454', @section_id, 'Zusammenfassung der Operatorenkaskade',
 'S_{t+1}^{(E)} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma), \quad K(S_{t+1}) \ge \kappa_{\min}, \quad V(S_{t+1}) = 1',
 'S_{t+1}^{(E)} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma), \quad K(S_{t+1}) \ge \kappa_{\min}, \quad V(S_{t+1}) = 1',
 'Kombinierte Darstellung der Operatorenkaskade inklusive Kohärenzprüfung und Validierung.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.454');

-- Definition Zusammenfassung
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT
 @section_id, 'D-3.7.8-1',
 'Zusammenfassung der Operatorenkaskade',
 'Die Operatorenkaskade fasst alle vorherigen Schritte zusammen: Iterative Anwendung von σ, M, R, E, inklusive Kohärenzprüfung K(S_{t+1}) und Validierung V(S_{t+1}).',
 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.7.8-1');

-- Symbole
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'S_{t+1}^{(E)}','S_{t+1}^{(E)}','Folgezustand nach Emergenz','Endzustand nach Anwendung der Operatorenkaskade und Extraktion der emergenten Strukturen.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='S_{t+1}^{(E)}');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id,@section_id,'created','section','3.7.8','Kapitel 3.7.8 Zusammenfassung der Operatorenkaskade und Ausblick auf 3.8 angelegt.',NULL,'in_progress');

COMMIT;