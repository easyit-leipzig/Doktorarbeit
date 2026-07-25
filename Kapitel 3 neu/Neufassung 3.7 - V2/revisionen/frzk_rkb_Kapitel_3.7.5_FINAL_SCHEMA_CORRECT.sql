/* =========================================================================
   FRZK-RKB Repository Update
   Kapitel 3.7.5
   Kohärenzprüfung / Validierung der Operatorenkaskade - Final
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.5 neu anlegen
INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no, section_order, status, is_original_contribution, notes)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.5',
 'Kohärenzprüfung / Validierung der Operatorenkaskade',
 3,
 3.7500,
 'in_progress',
 1,
 'Abschnitt 3.7.5: Kohärenzprüfung der Operatorenkaskade, neu aufgesetzt auf Basis von 3.7.4'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.7.5');

SET @section_id = (SELECT section_id FROM dissertation_sections WHERE section_code='3.7.5' LIMIT 1);

-- Neue Revision erzeugen
INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference, version_label, summary, created_by, parent_revision_id)
SELECT
 'RKB-K3.7.5-V2', NOW(), 'section', '3.7.5', '1.0',
 'Kohärenzprüfung und Validierung der Operatorenkaskade, auf Basis von 3.7.4 neu aufgesetzt',
 'Olaf Thiele', (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.5-V2');

SET @revision_id = (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-K3.7.5-V2' LIMIT 1);

-- Gleichung 3.445: Kohärenzfunktion
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.445', @section_id, 'Kohärenzfunktion',
 'K(S_t) \in [0,1]',
 'K(S_t) \in [0,1]',
 'Bewertung der Kohärenz eines Zustands S_t innerhalb der Operatorenkaskade.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.445');

-- Gleichung 3.446: Kohärenz-Schwelle
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, validation_status, created_revision_id)
SELECT
 '3.446', @section_id, 'Kohärenz-Schwelle',
 'S_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma),\quad K(S_{t+1}) \ge \kappa_{\min}',
 'S_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma),\quad K(S_{t+1}) \ge \kappa_{\min}',
 'Validierung, dass jeder Folgezustand mindestens die minimale Kohärenz erfüllt.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.446');

-- Definition Kohärenz
INSERT INTO definitions
(section_id, definition_number, title, definition_text, provenance, validation_status, created_revision_id)
SELECT
 @section_id, 'D-3.7.5-1',
 'Kohärenzfunktion',
 'Kohärenzfunktion K bewertet jeden Zustand S_t der Operatorenkaskade. Ein Wert K(S_t)=1 entspricht maximaler Kohärenz; K(S_t)=0 zeigt Verlust der funktionalen Organisation.',
 'original','draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='D-3.7.5-1');

-- Symbole K und κ_min
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT 'K','K','Kohärenzfunktion','Bewertung der Kohärenz eines Zustands S_t.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='K');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, validation_status, created_revision_id)
SELECT '\kappa_{\min}','kappa_min','Minimal-Kohärenz','Mindestwert für Kohärenz zur Validierung eines Zustands.','section',@section_id,'draft',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\kappa_{\min}');

-- Change log
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
VALUES (@revision_id,@section_id,'created','section','3.7.5','Kapitel 3.7.5 Kohärenzprüfung der Operatorenkaskade neu auf Basis 3.7.4 angelegt.',NULL,'in_progress');

COMMIT;