/* =========================================================================
   FRZK-RKB Repository Update
   Kapitel 3.7.2
   Spezifikation der Operatoren σ, M, R, E - Korrekt
   ============================================================================ */

START TRANSACTION;

-- Abschnitt 3.7.2 anlegen
INSERT INTO dissertation_sections
(
 parent_section_id,
 section_code,
 title,
 chapter_no,
 section_order,
 status,
 is_original_contribution,
 notes
)
SELECT
 (SELECT section_id FROM dissertation_sections WHERE section_code='3.7'),
 '3.7.2',
 'Spezifikation der Operatoren σ, M, R, E',
 3,
 3.7200,
 'in_progress',
 1,
 'Definition und Eigenschaften der einzelnen Operatoren der FRZK-Operatorenkaskade.'
WHERE NOT EXISTS
(
 SELECT 1 FROM dissertation_sections WHERE section_code='3.7.2'
);

SET @section_id =
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.7.2'
 LIMIT 1
);

-- Neue Revision erzeugen
INSERT INTO repository_revisions
(
 revision_code,
 revision_date,
 scope_type,
 scope_reference,
 version_label,
 summary,
 created_by,
 parent_revision_id
)
SELECT
 'RKB-K3.7.2-V1',
 NOW(),
 'section',
 '3.7.2',
 '1.0',
 'Definition der Operatoren σ, M, R, E in der funktionalen Operatorenkaskade.',
 'Olaf Thiele',
 (SELECT MAX(revision_id) FROM repository_revisions)
WHERE NOT EXISTS
(
 SELECT 1 FROM repository_revisions WHERE revision_code='RKB-K3.7.2-V1'
);

SET @revision_id =
(
 SELECT revision_id FROM repository_revisions
 WHERE revision_code='RKB-K3.7.2-V1'
 LIMIT 1
);

-- Gleichung 3.436: Selektionsoperator σ
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.436', @section_id,
 'Selektionsoperator σ',
 'S''_t = \sigma(S_t, \kappa)',
 'S''_t = \sigma(S_t, \kappa)',
 'Selektion von Komponenten des Zustands nach funktionalem Kriterium κ.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.436'
);

-- Gleichung 3.437: Mapping-Operator M
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.437', @section_id,
 'Mapping-Operator M',
 'S''_t = M(S''_t)',
 'S''_t = M(S''_t)',
 'Erzeugung von Relationen zwischen ausgewählten Komponenten.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.437'
);

-- Gleichung 3.438: Transformationsoperator R
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.438', @section_id,
 'Transformationsoperator R',
 'S_{t+1} = R(S''_t)',
 'S_{t+1} = R(S''_t)',
 'Iterative Transformation des Zustands zu S_{t+1}.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.438'
);

-- Gleichung 3.439: Emergenzoperator E
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.439', @section_id,
 'Emergenzoperator E',
 'S^{(E)}_{t+1} = E(S_{t+1})',
 'S^{(E)}_{t+1} = E(S_{t+1})',
 'Extraktion emergenter Strukturen aus S_{t+1}.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.439'
);

-- Gleichung 3.440: Komposition der Operatoren
INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 '3.440', @section_id,
 'Komposition der Operatoren',
 'S^{(E)}_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma)',
 'S^{(E)}_{t+1} = E \circ R \circ M \circ \sigma(S_t, \theta_\sigma)',
 'Komposition der vier Operatoren der Kaskade.',
 'definition','original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM equations WHERE equation_number='3.440'
);

-- Definition der Operatoren
INSERT INTO definitions
(
 section_id,
 definition_number,
 title,
 definition_text,
 provenance,
 validation_status,
 created_revision_id
)
SELECT
 @section_id,
 'D-3.7.2-1',
 'Operatoren σ, M, R, E',
 'Definition der Operatoren innerhalb der funktionalen Operatorenkaskade: Selektionsoperator σ, Mapping-Operator M, Transformationsoperator R, Emergenzoperator E.',
 'original','draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM definitions WHERE definition_number='D-3.7.2-1'
);

-- Symbole σ, M, R, E
INSERT INTO symbols
(
 symbol_latex,
 symbol_word_latex,
 symbol_name,
 definition_text,
 scope_type,
 first_section_id,
 validation_status,
 created_revision_id
)
SELECT
 'σ','sigma','Selektionsoperator',
 'Operator σ selektiert Komponenten nach funktionalem Kriterium.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='σ'
);

INSERT INTO symbols
(
 symbol_latex,
 symbol_word_latex,
 symbol_name,
 definition_text,
 scope_type,
 first_section_id,
 validation_status,
 created_revision_id
)
SELECT
 'M','M','Mapping-Operator',
 'Operator M erzeugt Relationen zwischen ausgewählten Komponenten.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='M'
);

INSERT INTO symbols
(
 symbol_latex,
 symbol_word_latex,
 symbol_name,
 definition_text,
 scope_type,
 first_section_id,
 validation_status,
 created_revision_id
)
SELECT
 'R','R','Transformationsoperator',
 'Operator R transformiert ausgewählte Komponenten iterativ.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='R'
);

INSERT INTO symbols
(
 symbol_latex,
 symbol_word_latex,
 symbol_name,
 definition_text,
 scope_type,
 first_section_id,
 validation_status,
 created_revision_id
)
SELECT
 'E','E','Emergenzoperator',
 'Operator E extrahiert emergente Strukturen aus transformierten Zuständen.',
 'section',@section_id,'draft',@revision_id
WHERE NOT EXISTS
(
 SELECT 1 FROM symbols WHERE symbol_latex='E'
);

-- Change log
INSERT INTO section_change_log
(
 revision_id,
 section_id,
 change_type,
 object_type,
 object_reference,
 change_summary,
 previous_value,
 new_value
)
VALUES
(
 @revision_id,
 @section_id,
 'created',
 'section',
 '3.7.2',
 'Kapitel 3.7.2 Operatoren korrekt definiert und dokumentiert.',
 NULL,
 'in_progress'
);

COMMIT;
