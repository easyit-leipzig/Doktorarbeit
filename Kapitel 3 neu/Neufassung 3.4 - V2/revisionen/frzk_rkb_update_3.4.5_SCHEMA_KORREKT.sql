/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.5
   Abschnitt: Funktionale Operatoren
   Voraussetzung: erfolgreicher Import bis einschließlich 3.4.4
   Gleichungen: (3.730) bis (3.770)
   Letzte Literaturquelle bleibt [109]
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.5-V1';

SET @parent_revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.4.4-V1'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    @revision_code, NOW(), 'section', '3.4.5', '1.0',
    'Rekonstruktion des funktionalen Operatorraums, der Komposition, Kommutativität, Invertierbarkeit, Monoidstruktur und Gruppe invertierbarer Operatoren.',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code
);

SET @revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code=@revision_code LIMIT 1
);

SET @chapter_34_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.4' LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_34_id, '3.4.5', 'Funktionale Operatoren', 3,
    3.4050, 'final', 1,
    'Einführung des funktionalen Operatorraums einschließlich Komposition, Kommutativität, Invertierbarkeit, Monoidstruktur und Gruppe invertierbarer Operatoren.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.4.5'
);

SET @section_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.4.5' LIMIT 1
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.730', @section_id, 'Menge funktionaler Transformationen', '\\mathcal{T}_F(\\mathcal{S}):=\\left\\{T_F\\middle|T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})\\right\\}', '\\mathcal{T}_F(\\mathcal{S}):=\\left\\{T_F\\middle|T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})\\right\\}',
    'Menge aller internen funktionalen Transformationen.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.730'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.731', @section_id, 'Allgemeiner funktionaler Operator', 'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Allgemeine Wirkungsvorschrift auf funktionalen Zuständen.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.731'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.732', @section_id, 'Funktionaler Operator', 'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Formale Definition des funktionalen Operators.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.732'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.733', @section_id, 'Operatorbild', 'O_F(z_F)\\in\\Omega_F(\\mathcal{S})', 'O_F(z_F)\\in\\Omega_F(\\mathcal{S})',
    'Das Bild eines funktionalen Zustands liegt erneut in der Zustandsmenge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.733'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.734', @section_id, 'Vom Operator erzeugte Transformation', 'T_{O_F}(z_F):=O_F(z_F)', 'T_{O_F}(z_F):=O_F(z_F)',
    'Zuordnung der Operatorwirkung zur erzeugten Transformation.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.734'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.735', @section_id, 'Operatorinduzierte Transformation', 'T_{O_F}\\in\\mathcal{T}_F(\\mathcal{S})', 'T_{O_F}\\in\\mathcal{T}_F(\\mathcal{S})',
    'Jeder funktionale Operator erzeugt eine funktionale Transformation.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.735'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.736', @section_id, 'Funktionaler Operatorraum', '\\mathcal{O}_F(\\mathcal{S}):=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})\\right\\}', '\\mathcal{O}_F(\\mathcal{S}):=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})\\right\\}',
    'Menge aller zulässigen funktionalen Operatoren.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.736'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.737', @section_id, 'Bezeichnung des Operatorraums', '\\mathcal{O}_F(\\mathcal{S})', '\\mathcal{O}_F(\\mathcal{S})',
    'Kurzbezeichnung des funktionalen Operatorraums.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.737'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.738', @section_id, 'Identität im Operatorraum', '\\operatorname{id}_{\\Omega_F}\\in\\mathcal{O}_F(\\mathcal{S})', '\\operatorname{id}_{\\Omega_F}\\in\\mathcal{O}_F(\\mathcal{S})',
    'Die Identität gehört zum funktionalen Operatorraum.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.738'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.739', @section_id, 'Wirkung der Identität', '\\operatorname{id}_{\\Omega_F}(z_F)=z_F', '\\operatorname{id}_{\\Omega_F}(z_F)=z_F',
    'Die Identität erhält jeden Zustand.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.739'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.740', @section_id, 'Zwei Operatoren', 'O_F^{(1)},O_F^{(2)}\\in\\mathcal{O}_F(\\mathcal{S})', 'O_F^{(1)},O_F^{(2)}\\in\\mathcal{O}_F(\\mathcal{S})',
    'Zwei Elemente des funktionalen Operatorraums.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.740'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.741', @section_id, 'Operatorkomposition', '\\left(O_F^{(2)}\\circ O_F^{(1)}\\right)(z_F)=O_F^{(2)}\\left(O_F^{(1)}(z_F)\\right)', '\\left(O_F^{(2)}\\circ O_F^{(1)}\\right)(z_F)=O_F^{(2)}\\left(O_F^{(1)}(z_F)\\right)',
    'Komposition zweier funktionaler Operatoren.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.741'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.742', @section_id, 'Abgeschlossenheit der Operatorkomposition', 'O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F(\\mathcal{S})', 'O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F(\\mathcal{S})',
    'Die Komposition liegt erneut im Operatorraum.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.742'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.743', @section_id, 'Lemma der Kompositionsabgeschlossenheit', 'O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F(\\mathcal{S})', 'O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F(\\mathcal{S})',
    'Aussage von Lemma 3.4.5.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.743'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.744', @section_id, 'Beliebiger funktionaler Zustand', 'z_F\\in\\Omega_F(\\mathcal{S})', 'z_F\\in\\Omega_F(\\mathcal{S})',
    'Ausgangspunkt des Beweises.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.744'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.745', @section_id, 'Bild unter erstem Operator', 'O_F^{(1)}(z_F)\\in\\Omega_F(\\mathcal{S})', 'O_F^{(1)}(z_F)\\in\\Omega_F(\\mathcal{S})',
    'Das erste Operatorbild ist zulässig.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.745'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.746', @section_id, 'Bild unter Operatorfolge', 'O_F^{(2)}\\left(O_F^{(1)}(z_F)\\right)\\in\\Omega_F(\\mathcal{S})', 'O_F^{(2)}\\left(O_F^{(1)}(z_F)\\right)\\in\\Omega_F(\\mathcal{S})',
    'Die Komposition bleibt in der Zustandsmenge.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.746'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.747', @section_id, 'Nichtkommutativität', 'O_F^{(2)}\\circ O_F^{(1)}\\neq O_F^{(1)}\\circ O_F^{(2)}', 'O_F^{(2)}\\circ O_F^{(1)}\\neq O_F^{(1)}\\circ O_F^{(2)}',
    'Operatoren müssen im Allgemeinen nicht kommutieren.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.747'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.748', @section_id, 'Zielzustand der Reihenfolge 1 dann 2', 'z_F^{(12)}:=\\left(O_F^{(2)}\\circ O_F^{(1)}\\right)(z_F)', 'z_F^{(12)}:=\\left(O_F^{(2)}\\circ O_F^{(1)}\\right)(z_F)',
    'Zielzustand einer Operatorreihenfolge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.748'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.749', @section_id, 'Zielzustand der Reihenfolge 2 dann 1', 'z_F^{(21)}:=\\left(O_F^{(1)}\\circ O_F^{(2)}\\right)(z_F)', 'z_F^{(21)}:=\\left(O_F^{(1)}\\circ O_F^{(2)}\\right)(z_F)',
    'Zielzustand der umgekehrten Operatorreihenfolge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.749'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.750', @section_id, 'Pfadabhängigkeit', 'z_F^{(12)}\\neq z_F^{(21)}', 'z_F^{(12)}\\neq z_F^{(21)}',
    'Nichtkommutative Operatoren erzeugen unterschiedliche Zielzustände.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.750'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.751', @section_id, 'Kommutierende Operatoren', 'O_F^{(2)}\\circ O_F^{(1)}=O_F^{(1)}\\circ O_F^{(2)}', 'O_F^{(2)}\\circ O_F^{(1)}=O_F^{(1)}\\circ O_F^{(2)}',
    'Definition kommutierender funktionaler Operatoren.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.751'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.752', @section_id, 'Inverser Operator', 'O_F^{-1}\\in\\mathcal{O}_F(\\mathcal{S})', 'O_F^{-1}\\in\\mathcal{O}_F(\\mathcal{S})',
    'Existenz eines inversen funktionalen Operators.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.752'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.753', @section_id, 'Inverseigenschaft', 'O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=\\operatorname{id}_{\\Omega_F}', 'O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=\\operatorname{id}_{\\Omega_F}',
    'Definition der Invertierbarkeit.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.753'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.754', @section_id, 'Rückführung eines Zustands', 'O_F^{-1}\\left(O_F(z_F)\\right)=z_F', 'O_F^{-1}\\left(O_F(z_F)\\right)=z_F',
    'Der inverse Operator rekonstruiert den Ausgangszustand.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.754'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.755', @section_id, 'Verschiedene Ausgangszustände', 'z_F^{(i)}\\neq z_F^{(j)}', 'z_F^{(i)}\\neq z_F^{(j)}',
    'Zwei unterschiedliche funktionale Zustände.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.755'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.756', @section_id, 'Gleiches Operatorbild', 'O_F\\left(z_F^{(i)}\\right)=O_F\\left(z_F^{(j)}\\right)', 'O_F\\left(z_F^{(i)}\\right)=O_F\\left(z_F^{(j)}\\right)',
    'Mehrere Ausgangszustände werden auf dasselbe Bild abgebildet.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.756'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.757', @section_id, 'Operator im Invertierbarkeitssatz', 'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Voraussetzung von Satz 3.4.5.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.757'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.758', @section_id, 'Linksinverse Bedingung', 'O_F^{-1}\\circ O_F=\\operatorname{id}_{\\Omega_F}', 'O_F^{-1}\\circ O_F=\\operatorname{id}_{\\Omega_F}',
    'Teil der Invertierbarkeitsbedingung.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.758'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.759', @section_id, 'Gleichheit zweier Bilder', 'O_F\\left(z_F^{(i)}\\right)=O_F\\left(z_F^{(j)}\\right)', 'O_F\\left(z_F^{(i)}\\right)=O_F\\left(z_F^{(j)}\\right)',
    'Annahme im Injektivitätsnachweis.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.759'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.760', @section_id, 'Gleichheit der Urbilder', 'z_F^{(i)}=z_F^{(j)}', 'z_F^{(i)}=z_F^{(j)}',
    'Folgerung aus der Anwendung des inversen Operators.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.760'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.761', @section_id, 'Darstellung jedes Zielzustands', 'z_F^{\\prime}=O_F\\left(O_F^{-1}(z_F^{\\prime})\\right)', 'z_F^{\\prime}=O_F\\left(O_F^{-1}(z_F^{\\prime})\\right)',
    'Nachweis der Surjektivität.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.761'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.762', @section_id, 'Definition des inversen Operators', 'O_F^{-1}(z_F^{\\prime}):=z_F\\quad\\text{mit}\\quad O_F(z_F)=z_F^{\\prime}', 'O_F^{-1}(z_F^{\\prime}):=z_F\\quad\\text{mit}\\quad O_F(z_F)=z_F^{\\prime}',
    'Konstruktion des inversen Operators aus Bijektivität.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.762'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.763', @section_id, 'Beidseitige Inverse', 'O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=\\operatorname{id}_{\\Omega_F}', 'O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=\\operatorname{id}_{\\Omega_F}',
    'Abschluss des Invertierbarkeitsbeweises.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.763'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.764', @section_id, 'Nichtinjektive Verdichtung', 'O_F\\left(z_F^{(i)}\\right)=O_F\\left(z_F^{(j)}\\right)', 'O_F\\left(z_F^{(i)}\\right)=O_F\\left(z_F^{(j)}\\right)',
    'Bedingung informationsverdichtender Operatoren.', 'corollary', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.764'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.765', @section_id, 'Operator-Monoid', '\\left(\\mathcal{O}_F(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)', '\\left(\\mathcal{O}_F(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)',
    'Algebraische Struktur des Operatorraums.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.765'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.766', @section_id, 'Assoziativität', 'O_F^{(3)}\\circ\\left(O_F^{(2)}\\circ O_F^{(1)}\\right)=\\left(O_F^{(3)}\\circ O_F^{(2)}\\right)\\circ O_F^{(1)}', 'O_F^{(3)}\\circ\\left(O_F^{(2)}\\circ O_F^{(1)}\\right)=\\left(O_F^{(3)}\\circ O_F^{(2)}\\right)\\circ O_F^{(1)}',
    'Assoziativität der Operatorkomposition.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.766'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.767', @section_id, 'Monoidstruktur', '\\left(\\mathcal{O}_F(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)', '\\left(\\mathcal{O}_F(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)',
    'Aussage von Satz 3.4.6.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.767'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.768', @section_id, 'Neutralität der Identität', 'O_F\\circ\\operatorname{id}_{\\Omega_F}=\\operatorname{id}_{\\Omega_F}\\circ O_F=O_F', 'O_F\\circ\\operatorname{id}_{\\Omega_F}=\\operatorname{id}_{\\Omega_F}\\circ O_F=O_F',
    'Identität als neutrales Element.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.768'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.769', @section_id, 'Invertierbare Operatoren', '\\mathcal{O}_F^{\\times}(\\mathcal{S}):=\\left\\{O_F\\in\\mathcal{O}_F(\\mathcal{S})\\middle|O_F\\text{ ist invertierbar}\\right\\}', '\\mathcal{O}_F^{\\times}(\\mathcal{S}):=\\left\\{O_F\\in\\mathcal{O}_F(\\mathcal{S})\\middle|O_F\\text{ ist invertierbar}\\right\\}',
    'Teilmenge aller invertierbaren funktionalen Operatoren.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.769'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.770', @section_id, 'Gruppe invertierbarer Operatoren', '\\left(\\mathcal{O}_F^{\\times}(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)', '\\left(\\mathcal{O}_F^{\\times}(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)',
    'Gruppenstruktur der invertierbaren Operatoren.', 'corollary', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.5.',
    'Abschnitte 3.4.1 bis 3.4.4 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.770'
);


/* Definitionen */
INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.11', @section_id, 'Funktionaler Operator',
       'Ein funktionaler Operator ist eine auf der funktionalen Zustandsmenge definierte Wirkungsvorschrift, die jedem funktionalen Zustand genau einen funktionalen Zielzustand zuordnet.',
       'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
       'O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
       'original', NULL, 'Definitionen der funktionalen Zustandsmenge und Transformation.',
       'Der Operator bezeichnet die Wirkungsvorschrift, die Transformation deren konkrete Zustandszuordnung.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.11');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.12', @section_id, 'Funktionaler Operatorraum',
       'Die Menge aller auf der funktionalen Zustandsmenge zulässigen funktionalen Operatoren heißt funktionaler Operatorraum.',
       '\\mathcal{O}_F(\\mathcal{S}):=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})\\right\\}',
       '\\mathcal{O}_F(\\mathcal{S}):=\\left\\{O_F\\middle|O_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})\\right\\}',
       'original', NULL, 'Definition 3.4.11.',
       'Raum wird zunächst strukturell und nicht bereits vektoriell oder topologisch verstanden.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.12');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.13', @section_id, 'Kommutierende funktionale Operatoren',
       'Zwei funktionale Operatoren heißen kommutierend, wenn ihre Komposition unabhängig von der Reihenfolge dasselbe Ergebnis liefert.',
       'O_F^{(2)}\\circ O_F^{(1)}=O_F^{(1)}\\circ O_F^{(2)}',
       'O_F^{(2)}\\circ O_F^{(1)}=O_F^{(1)}\\circ O_F^{(2)}',
       'original', NULL, 'Definition 3.4.12 und Operatorkomposition.',
       'Nichtkommutativität begründet funktionale Pfadabhängigkeit.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.13');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.14', @section_id, 'Invertierbarer funktionaler Operator',
       'Ein funktionaler Operator heißt invertierbar, wenn ein beidseitiger inverser Operator existiert, dessen Komposition mit dem Ausgangsoperator die Identität ergibt.',
       'O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=\\operatorname{id}_{\\Omega_F}',
       'O_F^{-1}\\circ O_F=O_F\\circ O_F^{-1}=\\operatorname{id}_{\\Omega_F}',
       'original', NULL, 'Definition 3.4.12 und Identitätsoperator.',
       'Invertierbarkeit bedeutet eindeutige Rekonstruierbarkeit des Ausgangszustands.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.14');

/* Lemma */
INSERT INTO lemmas
(lemma_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.5', @section_id, 'Abgeschlossenheit des funktionalen Operatorraums unter Komposition',
       'Die Komposition zweier funktionaler Operatoren derselben Zustandsmenge ist wiederum ein funktionaler Operator.',
       'O_F^{(1)},O_F^{(2)}\\in\\mathcal{O}_F(\\mathcal{S})\\Longrightarrow O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F(\\mathcal{S})',
       'O_F^{(1)},O_F^{(2)}\\in\\mathcal{O}_F(\\mathcal{S})\\Longrightarrow O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F(\\mathcal{S})',
       'original', NULL, 'Definitionen 3.4.11 und 3.4.12.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='3.4.5');

/* Sätze */
INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.5', @section_id, 'Kriterium der Invertierbarkeit funktionaler Operatoren',
       'Ein funktionaler Operator ist genau dann invertierbar, wenn er bijektiv ist.',
       'O_F\\text{ invertierbar}\\Longleftrightarrow O_F\\text{ bijektiv}',
       'O_F\\text{ invertierbar}\\Longleftrightarrow O_F\\text{ bijektiv}',
       'original', NULL, 'Definition 3.4.14 sowie Injektivität und Surjektivität aus Abschnitt 3.2.5.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.5');

INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.6', @section_id, 'Monoidstruktur des funktionalen Operatorraums',
       'Der funktionale Operatorraum bildet mit der Komposition und der Identität ein Monoid.',
       '\\left(\\mathcal{O}_F(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)\\text{ ist ein Monoid}',
       '\\left(\\mathcal{O}_F(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)\\text{ ist ein Monoid}',
       'original', NULL, 'Lemma 3.4.5, Assoziativität der Abbildungskomposition und Identitätsoperator.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.6');

SET @lemma_id := (SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.5' LIMIT 1);
SET @theorem_345_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.5' LIMIT 1);
SET @theorem_346_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.6' LIMIT 1);

/* Korollare */
INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex, word_latex,
 parent_theorem_id, parent_lemma_id, provenance, source_id, validation_status, created_revision_id)
SELECT '3.4.5', @section_id, 'Nichtinvertierbarkeit informationsverdichtender Operatoren',
       'Ein funktionaler Operator, der mindestens zwei unterschiedliche funktionale Zustände auf denselben Zielzustand abbildet, ist nicht invertierbar.',
       'z_F^{(i)}\\neq z_F^{(j)}\\land O_F(z_F^{(i)})=O_F(z_F^{(j)})\\Longrightarrow O_F\\text{ nicht invertierbar}',
       'z_F^{(i)}\\neq z_F^{(j)}\\land O_F(z_F^{(i)})=O_F(z_F^{(j)})\\Longrightarrow O_F\\text{ nicht invertierbar}',
       @theorem_345_id, NULL, 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.5');

INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex, word_latex,
 parent_theorem_id, parent_lemma_id, provenance, source_id, validation_status, created_revision_id)
SELECT '3.4.6', @section_id, 'Gruppe der invertierbaren funktionalen Operatoren',
       'Die invertierbaren Elemente des funktionalen Operatorraums bilden bezüglich der Komposition eine Gruppe.',
       '\\left(\\mathcal{O}_F^{\\times}(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)\\text{ ist eine Gruppe}',
       '\\left(\\mathcal{O}_F^{\\times}(\\mathcal{S}),\\circ,\\operatorname{id}_{\\Omega_F}\\right)\\text{ ist eine Gruppe}',
       @theorem_346_id, NULL, 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.6');

SET @corollary_345_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.5' LIMIT 1);
SET @corollary_346_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.6' LIMIT 1);

/* Beweise */
INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.5-L1', @section_id, NULL, @lemma_id, NULL,
       'Beweis zu Lemma 3.4.5',
       'Der erste Operator bildet jeden Zustand in die funktionale Zustandsmenge ab. Das Ergebnis liegt daher im Definitionsbereich des zweiten Operators, der es erneut eindeutig in die Zustandsmenge abbildet. Somit ist die Komposition wiederum ein funktionaler Operator.',
       'O_F^{(1)}(z_F)\\in\\Omega_F(\\mathcal{S})\\Longrightarrow O_F^{(2)}(O_F^{(1)}(z_F))\\in\\Omega_F(\\mathcal{S})',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.5-L1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.5-S1', @section_id, @theorem_345_id, NULL, NULL,
       'Beweis zu Satz 3.4.5',
       'Aus der Existenz eines beidseitigen inversen Operators folgen Injektivität und Surjektivität. Umgekehrt definiert eine bijektive Abbildung für jeden Zielzustand genau ein Urbild und damit einen eindeutigen inversen Operator.',
       'O_F\\text{ invertierbar}\\Longrightarrow O_F\\text{ bijektiv};\\qquad O_F\\text{ bijektiv}\\Longrightarrow\\exists O_F^{-1}',
       'equivalence', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.5-S1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.5-K1', @section_id, NULL, NULL, @corollary_345_id,
       'Begründung zu Korollar 3.4.5',
       'Werden zwei unterschiedliche Zustände auf dasselbe Bild abgebildet, ist der Operator nicht injektiv. Nach Satz 3.4.5 ist er daher nicht invertierbar.',
       'z_F^{(i)}\\neq z_F^{(j)}\\land O_F(z_F^{(i)})=O_F(z_F^{(j)})\\Longrightarrow O_F\\text{ nicht injektiv}',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.5-K1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.5-S2', @section_id, @theorem_346_id, NULL, NULL,
       'Beweis zu Satz 3.4.6',
       'Der Operatorraum ist nach Lemma 3.4.5 unter Komposition abgeschlossen. Die Abbildungskomposition ist assoziativ, und die Identität ist ein neutrales Element. Damit sind die Monoidaxiome erfüllt.',
       '\\operatorname{Abgeschlossenheit}\\land\\operatorname{Assoziativitaet}\\land\\operatorname{Identitaet}\\Longrightarrow\\operatorname{Monoid}',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.5-S2');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.5-K2', @section_id, NULL, NULL, @corollary_346_id,
       'Begründung zu Korollar 3.4.6',
       'Die Komposition bijektiver Operatoren ist bijektiv, die Identität ist bijektiv, und zu jedem invertierbaren Operator gehört eine inverse Abbildung. Zusammen mit der Assoziativität sind damit die Gruppenaxiome erfüllt.',
       'O_F^{(1)},O_F^{(2)}\\in\\mathcal{O}_F^{\\times}\\Longrightarrow O_F^{(2)}\\circ O_F^{(1)}\\in\\mathcal{O}_F^{\\times}',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.5-K2');

/* Zentrale Gleichungsreferenzen */
SET @eq_3730 := (SELECT equation_id FROM equations WHERE equation_number='3.730' LIMIT 1);
SET @eq_3732 := (SELECT equation_id FROM equations WHERE equation_number='3.732' LIMIT 1);
SET @eq_3736 := (SELECT equation_id FROM equations WHERE equation_number='3.736' LIMIT 1);
SET @eq_3752 := (SELECT equation_id FROM equations WHERE equation_number='3.752' LIMIT 1);
SET @eq_3769 := (SELECT equation_id FROM equations WHERE equation_number='3.769' LIMIT 1);

/* Gleichungssymbole */
INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3730, '\\mathcal{T}_F(\\mathcal{S})', 'Menge funktionaler Transformationen',
       'Menge aller internen Transformationen der funktionalen Organisation.', NULL,
       '\\mathcal{P}(\\Omega_F(\\mathcal{S})^{\\Omega_F(\\mathcal{S})})', 1
WHERE @eq_3730 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3730 AND symbol_latex='\\mathcal{T}_F(\\mathcal{S})');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3732, 'O_F', 'funktionaler Operator',
       'Wirkungsvorschrift auf funktionalen Zuständen.', NULL,
       '\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})', 1
WHERE @eq_3732 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3732 AND symbol_latex='O_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3736, '\\mathcal{O}_F(\\mathcal{S})', 'funktionaler Operatorraum',
       'Menge aller zulässigen funktionalen Operatoren.', NULL,
       '\\mathcal{P}(\\Omega_F(\\mathcal{S})^{\\Omega_F(\\mathcal{S})})', 1
WHERE @eq_3736 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3736 AND symbol_latex='\\mathcal{O}_F(\\mathcal{S})');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3752, 'O_F^{-1}', 'inverser funktionaler Operator',
       'Beidseitiger inverser Operator zu O_F.', NULL,
       '\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})', 1
WHERE @eq_3752 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3752 AND symbol_latex='O_F^{-1}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3769, '\\mathcal{O}_F^{\\times}(\\mathcal{S})', 'invertierbare funktionale Operatoren',
       'Teilmenge aller invertierbaren Elemente des Operatorraums.', NULL,
       '\\mathcal{O}_F(\\mathcal{S})', 1
WHERE @eq_3769 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3769 AND symbol_latex='\\mathcal{O}_F^{\\times}(\\mathcal{S})');

/* Symbolregister */
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT 'O_F', 'O_F', 'Funktionaler Operator',
       'Strukturierte Wirkungsvorschrift, die funktionale Zustände eindeutig in funktionale Zielzustände überführt.',
       'chapter', @section_id, @eq_3732, NULL,
       '\\Omega_F(\\mathcal{S})', '\\Omega_F(\\mathcal{S})',
       0, 0, 1, 'Formale Rekonstruktion in Abschnitt 3.4.5.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='O_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{O}_F(\\mathcal{S})', '\\mathcal{O}_F(\\mathcal{S})', 'Funktionaler Operatorraum',
       'Menge aller auf der funktionalen Zustandsmenge zulässigen Operatoren.',
       'chapter', @section_id, @eq_3736, NULL,
       '\\mathcal{S}', '\\mathcal{P}(\\Omega_F(\\mathcal{S})^{\\Omega_F(\\mathcal{S})})',
       0, 0, 0, 'Der Begriff Raum ist zunächst strukturell gemeint.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{O}_F(\\mathcal{S})');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT 'O_F^{-1}', 'O_F^{-1}', 'Inverser funktionaler Operator',
       'Operator, der die Wirkung von O_F eindeutig rückgängig macht.',
       'chapter', @section_id, @eq_3752, NULL,
       '\\Omega_F(\\mathcal{S})', '\\Omega_F(\\mathcal{S})',
       0, 0, 1, 'Existiert genau für bijektive funktionale Operatoren.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='O_F^{-1}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{O}_F^{\\times}(\\mathcal{S})', '\\mathcal{O}_F^{\\times}(\\mathcal{S})',
       'Gruppe invertierbarer funktionaler Operatoren',
       'Teilmenge aller invertierbaren funktionalen Operatoren.',
       'chapter', @section_id, @eq_3769, NULL,
       '\\mathcal{O}_F(\\mathcal{S})', '\\mathcal{O}_F(\\mathcal{S})',
       0, 0, 0, 'Bildet bezüglich der Komposition eine Gruppe.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{O}_F^{\\times}(\\mathcal{S})');

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id, @section_id, 'created', 'section', '3.4.5',
       'Abschnitt 3.4.5 Funktionale Operatoren wurde angelegt.', NULL, 'final'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_type='section' AND object_reference='3.4.5'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id, @section_id, 'equation_added', 'equation', '3.730-3.770',
       'Einundvierzig Gleichungen wurden registriert.', NULL, '3.730 bis 3.770'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_type='equation' AND object_reference='3.730-3.770'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id, @section_id, 'statement_added', 'statement', '3.4.5-3.4.6',
       'Vier Definitionen, ein Lemma, zwei Sätze, zwei Korollare und fünf Beweise wurden registriert.',
       NULL, 'vollständig'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_type='statement' AND object_reference='3.4.5-3.4.6'
);

/* Repository-Zähler */
INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_equation_number_chapter_3', '3.770')
ON DUPLICATE KEY UPDATE counter_value='3.770';

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_citation_number', '109')
ON DUPLICATE KEY UPDATE counter_value='109';

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_completed_section_chapter_3', '3.4.5')
ON DUPLICATE KEY UPDATE counter_value='3.4.5';

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_repository_revision', 'RKB-NEU-K3.4.5-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.4.5-V1';

COMMIT;

/* Kontrollabfragen */
SELECT revision_id, revision_code, scope_reference, version_label
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.4.5-V1';

SELECT section_id, section_code, title, status
FROM dissertation_sections
WHERE section_code='3.4.5';

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5' LIMIT 1)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5' LIMIT 1)
ORDER BY definition_number;

SELECT lemma_number AS object_number, title, 'lemma' AS object_type, validation_status
FROM lemmas
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5' LIMIT 1)
UNION ALL
SELECT theorem_number, title, 'theorem', validation_status
FROM theorems
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5' LIMIT 1)
UNION ALL
SELECT corollary_number, title, 'corollary', validation_status
FROM corollaries
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5' LIMIT 1);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.5' LIMIT 1)
ORDER BY proof_number;

SELECT counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
('last_equation_number_chapter_3','last_citation_number',
 'last_completed_section_chapter_3','last_repository_revision')
ORDER BY counter_key;
