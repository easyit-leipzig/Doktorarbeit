-- =====================================================================
-- FRZK-RKB – Repository-Update für Abschnitt 3.2.3
-- Abbildungen, Operatoren und mathematische Transformationen
-- Ausgangsstand: frzk_rkb_stand_3.2.2.sql
-- Zielstand:
--   Abschnitt:          3.2.3
--   Definitionen:       3.2.11 bis 3.2.12
--   Gleichungen:        (3.59) bis (3.76)
--   letzte Literatur:   [83] (keine neue Quelle)
--   nächste Literatur:  [84]
--
-- Korrektur gegenüber dem vorläufigen Text:
--   Strang ist im Repository Quelle [74], nicht [10].
--   Reed/Simon ist im Repository Quelle [76], nicht [13].
--   Quelle [13] ist Kant und gehört nicht zu Abschnitt 3.2.3.
--
-- Zielsystem: MariaDB 10.4 / utf8mb4
-- =====================================================================

SET NAMES utf8mb4;
SET time_zone = '+02:00';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Vorbedingungen aus dem Abschlussstand 3.2.2
-- ---------------------------------------------------------------------

SET @parent_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference = '3.2.2'
    ORDER BY revision_id DESC
    LIMIT 1
);

SET @source_71 := (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1);
SET @source_74 := (SELECT source_id FROM sources WHERE citation_number = 74 LIMIT 1);
SET @source_76 := (SELECT source_id FROM sources WHERE citation_number = 76 LIMIT 1);
SET @source_80 := (SELECT source_id FROM sources WHERE citation_number = 80 LIMIT 1);
SET @source_82 := (SELECT source_id FROM sources WHERE citation_number = 82 LIMIT 1);

-- ---------------------------------------------------------------------
-- 2. Repository-Revision
-- ---------------------------------------------------------------------

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
    'RKB-NEU-K3.2.3-V1',
    NOW(),
    'section',
    '3.2.3',
    '3.2.3-v1',
    'Abschnitt 3.2.3 mit Abbildungen, linearen Operatoren, Operatorverkettung, Identität, Invertierbarkeit, Matrixdarstellung sowie einer vorbereitenden Einführung in Eigenwerte und Eigenvektoren. Verwendete Literatur: [71], [74], [76], [80] und [82]. Definitionen 3.2.11 bis 3.2.12; Gleichungen (3.59) bis (3.76).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.3-V1'
);

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.3-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Dissertationsteil 3.2.3
-- ---------------------------------------------------------------------

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
    @parent_section_id,
    '3.2.3',
    'Abbildungen, Operatoren und mathematische Transformationen',
    3,
    3.2300,
    'final',
    0,
    'Etablierte mathematische Grundlagen zu Abbildungen, linearen Operatoren, Komposition, Identität, Invertierbarkeit, Matrixdarstellung und Eigenwertbegriff. Quellen [71], [74], [76], [80] und [82]; Definitionen 3.2.11 bis 3.2.12; Gleichungen (3.59) bis (3.76).'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.2.3'
);

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.3'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Definitionen 3.2.11 bis 3.2.12
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number,
    section_id,
    title,
    definition_text,
    formal_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    notes,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.11',
    @section_id,
    'Mathematische Abbildung',
    'Seien X und Y Mengen. Eine Abbildung T von X nach Y ordnet jedem Element x aus X genau ein Element y aus Y zu.',
    'T:X\\rightarrow Y,\\qquad T(x)=y',
    'T:X\\rightarrow Y,\\qquad T(x)=y',
    'adapted',
    @source_80,
    'Die Mengen X und Y sowie der Begriff der eindeutigen Zuordnung sind definiert.',
    'Etablierter Abbildungsbegriff; die strukturerhaltenden Eigenschaften werden anschließend gesondert eingeführt.',
    'verified',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions WHERE definition_number = '3.2.11'
);

INSERT INTO definitions
(
    definition_number,
    section_id,
    title,
    definition_text,
    formal_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    notes,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.12',
    @section_id,
    'Linearer Operator',
    'Eine lineare Abbildung T, deren Definitions- und Zielraum derselbe Vektorraum V ist, wird als linearer Operator bezeichnet.',
    'T:V\\rightarrow V',
    'T:V\\rightarrow V',
    'adapted',
    @source_82,
    'Der Vektorraum V sowie Additivität und Homogenität linearer Abbildungen sind definiert.',
    'Etablierter Begriff eines linearen Endomorphismus beziehungsweise Operators.',
    'verified',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions WHERE definition_number = '3.2.12'
);

-- ---------------------------------------------------------------------
-- 5. Gleichungen (3.59) bis (3.76)
-- ---------------------------------------------------------------------

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.59', @section_id, 'Abbildung von X nach Y',
       'T:X\\rightarrow Y', 'T:X\\rightarrow Y',
       'Die Abbildung T besitzt den Definitionsbereich X und den Zielbereich Y.',
       'definition', 'literature', @source_80,
       'Standardnotation für eine Abbildung zwischen zwei Mengen.',
       'X und Y sind Mengen.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.59');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.60', @section_id, 'Wert einer Abbildung',
       'T(x)=y', 'T(x)=y',
       'Dem Element x wird durch T das Element y zugeordnet.',
       'definition', 'literature', @source_80,
       'Auswertung der Abbildung T an der Stelle x.',
       'x liegt im Definitionsbereich von T.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.60');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.61', @section_id, 'Additivität einer linearen Abbildung',
       'T(x+y)=T(x)+T(y)', 'T(x+y)=T(x)+T(y)',
       'Eine lineare Abbildung erhält die Addition von Vektoren.',
       'definition', 'literature', @source_71,
       'Erste Bedingung der Linearität.',
       'x und y liegen in einem Vektorraum und T ist auf diesem Raum definiert.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.61');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.62', @section_id, 'Homogenität einer linearen Abbildung',
       'T(\\lambda x)=\\lambda T(x)', 'T(\\lambda x)=\\lambda T(x)',
       'Eine lineare Abbildung ist mit der Skalarmultiplikation verträglich.',
       'definition', 'literature', @source_71,
       'Zweite Bedingung der Linearität.',
       'lambda ist ein Skalar und x liegt im Definitionsbereich von T.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.62');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.63', @section_id, 'Linearer Operator auf V',
       'T:V\\rightarrow V', 'T:V\\rightarrow V',
       'Der Operator T bildet den Vektorraum V in sich selbst ab.',
       'definition', 'literature', @source_82,
       'Spezialisierung einer linearen Abbildung auf identische Definitions- und Zielräume.',
       'V ist ein Vektorraum und T ist linear.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.63');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.64', @section_id, 'Erster Operator der Verkettung',
       'A:V\\rightarrow V', 'A:V\\rightarrow V',
       'A ist ein Operator auf dem Vektorraum V.',
       'schema', 'literature', @source_82,
       'Ausgangsoperator für die nachfolgende Komposition.',
       'V ist ein Vektorraum.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.64');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.65', @section_id, 'Zweiter Operator der Verkettung',
       'B:V\\rightarrow V', 'B:V\\rightarrow V',
       'B ist ein Operator auf dem Vektorraum V.',
       'schema', 'literature', @source_82,
       'Zieloperator für die nachfolgende Komposition.',
       'V ist ein Vektorraum.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.65');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.66', @section_id, 'Verkettung zweier Operatoren',
       'B\\circ A', 'B\\circ A',
       'Die Komposition wendet zuerst A und anschließend B an.',
       'definition', 'literature', @source_82,
       'Komposition zweier auf demselben Vektorraum definierter Operatoren.',
       'Bildbereich von A und Definitionsbereich von B sind verträglich.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.66');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.67', @section_id, 'Wirkung einer Operatorverkettung',
       '(B\\circ A)(x)=B(A(x))', '(B\\circ A)(x)=B(A(x))',
       'Die verkettete Abbildung wirkt schrittweise auf den Vektor x.',
       'definition', 'literature', @source_82,
       'Auswertung der Komposition B nach A.',
       'x liegt im Definitionsbereich von A.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.67');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.68', @section_id, 'Nichtkommutativität von Operatoren',
       'B\\circ A\\neq A\\circ B', 'B\\circ A\\neq A\\circ B',
       'Die Reihenfolge zweier Operatoren kann unterschiedliche Ergebnisse erzeugen.',
       'other', 'literature', @source_76,
       'Allgemeine Aussage zur im Regelfall nichtkommutativen Operatorverkettung.',
       'Es wird keine besondere Vertauschungsrelation zwischen A und B vorausgesetzt.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.68');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.69', @section_id, 'Identitätsoperator',
       'I:V\\rightarrow V', 'I:V\\rightarrow V',
       'Der Identitätsoperator ist auf dem Vektorraum V definiert.',
       'definition', 'literature', @source_82,
       'Definition des neutralen Operators bezüglich der Komposition.',
       'V ist ein Vektorraum.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.69');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.70', @section_id, 'Wirkung des Identitätsoperators',
       'I(x)=x', 'I(x)=x',
       'Der Identitätsoperator lässt jeden Vektor unverändert.',
       'definition', 'literature', @source_82,
       'Punktweise Definition des Identitätsoperators.',
       'x liegt in V.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.70');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.71', @section_id, 'Neutralität des Identitätsoperators',
       'I\\circ T=T\\circ I=T', 'I\\circ T=T\\circ I=T',
       'Die Komposition eines Operators mit der Identität verändert den Operator nicht.',
       'derived', 'literature', @source_82,
       'Folgt unmittelbar aus der Definition des Identitätsoperators.',
       'T ist ein Operator auf V.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.71');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.72', @section_id, 'Inverser Operator',
       'T^{-1}', 'T^{-1}',
       'T hoch minus eins bezeichnet den inversen Operator zu T.',
       'definition', 'literature', @source_76,
       'Notation für die Umkehrabbildung eines invertierbaren Operators.',
       'T ist bijektiv beziehungsweise besitzt eine wohldefinierte Inverse.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.72');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.73', @section_id, 'Linksinverse',
       'T^{-1}\\circ T=I', 'T^{-1}\\circ T=I',
       'Die Anwendung der Inversen nach T ergibt die Identität.',
       'definition', 'literature', @source_76,
       'Erste Bedingung für eine beidseitige Inverse.',
       'T ist invertierbar.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.73');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.74', @section_id, 'Rechtsinverse',
       'T\\circ T^{-1}=I', 'T\\circ T^{-1}=I',
       'Die Anwendung von T nach seiner Inversen ergibt die Identität.',
       'definition', 'literature', @source_76,
       'Zweite Bedingung für eine beidseitige Inverse.',
       'T ist invertierbar.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.74');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.75', @section_id, 'Matrixwirkung auf einen Koordinatenvektor',
       'Ax=y', 'Ax=y',
       'Die Matrix A bildet den Koordinatenvektor x auf den Koordinatenvektor y ab.',
       'schema', 'literature', @source_74,
       'Matrixdarstellung eines linearen Operators bezüglich einer gewählten Basis.',
       'Der Vektorraum ist endlichdimensional und eine Basis wurde gewählt.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.75');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT '3.76', @section_id, 'Eigenwertgleichung',
       'Ax=\\lambda x', 'Ax=\\lambda x',
       'Ein von null verschiedener Eigenvektor x wird durch A lediglich mit dem Eigenwert lambda skaliert.',
       'definition', 'literature', @source_74,
       'Standardgleichung zur Definition von Eigenwert und Eigenvektor.',
       'x ist ungleich dem Nullvektor.', 'verified', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number = '3.76');

-- ---------------------------------------------------------------------
-- 6. Literaturverwendung in Abschnitt 3.2.3
-- Keine neue Literaturstelle; ausschließlich Wiederverwendungen.
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_71, @section_id, 'definition',
       'Lang stützt die Definition der Linearität durch Additivität und Homogenität sowie die algebraische Einordnung linearer Abbildungen.',
       'Abschnitt 3.2.3 – lineare Abbildungen und Gleichungen (3.61) bis (3.62)',
       0, 1, 'Wiederverwendung der Quelle [71].', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id = @source_71 AND section_id = @section_id
      AND exact_location = 'Abschnitt 3.2.3 – lineare Abbildungen und Gleichungen (3.61) bis (3.62)'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_74, @section_id, 'equation_source',
       'Strang stützt die Matrixdarstellung linearer Operatoren sowie die vorbereitende Einführung der Eigenwertgleichung.',
       'Abschnitt 3.2.3 – Matrixdarstellung und Eigenwerte; Gleichungen (3.75) bis (3.76)',
       0, 1, 'Wiederverwendung der Quelle [74]; ersetzt den sachlich falschen vorläufigen Verweis [10].', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id = @source_74 AND section_id = @section_id
      AND exact_location = 'Abschnitt 3.2.3 – Matrixdarstellung und Eigenwerte; Gleichungen (3.75) bis (3.76)'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_76, @section_id, 'background',
       'Reed und Simon stützen die operatorentheoretische Einordnung, die Nichtkommutativität im Allgemeinen sowie die Definition inverser Operatoren.',
       'Abschnitt 3.2.3 – Operatorverkettung und inverse Operatoren; Gleichungen (3.68) sowie (3.72) bis (3.74)',
       0, 1, 'Wiederverwendung der Quelle [76]; ersetzt den sachlich falschen vorläufigen Verweis [13].', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id = @source_76 AND section_id = @section_id
      AND exact_location = 'Abschnitt 3.2.3 – Operatorverkettung und inverse Operatoren; Gleichungen (3.68) sowie (3.72) bis (3.74)'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_80, @section_id, 'definition',
       'Enderton stützt den allgemeinen Abbildungsbegriff als eindeutige Zuordnung zwischen Mengen.',
       'Abschnitt 3.2.3 – Definition 3.2.11 und Gleichungen (3.59) bis (3.60)',
       0, 1, 'Wiederverwendung der Quelle [80].', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id = @source_80 AND section_id = @section_id
      AND exact_location = 'Abschnitt 3.2.3 – Definition 3.2.11 und Gleichungen (3.59) bis (3.60)'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT @source_82, @section_id, 'definition',
       'Halmos stützt die Begriffe der linearen Abbildung, des Operators, der Operatorverkettung und des Identitätsoperators.',
       'Abschnitt 3.2.3 – Definition 3.2.12 und Gleichungen (3.63) bis (3.71)',
       0, 1, 'Wiederverwendung der Quelle [82].', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id = @source_82 AND section_id = @section_id
      AND exact_location = 'Abschnitt 3.2.3 – Definition 3.2.12 und Gleichungen (3.63) bis (3.71)'
);

-- ---------------------------------------------------------------------
-- 7. Änderungsprotokoll
-- ---------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT @revision_id, @section_id, 'created', 'section', '3.2.3',
       'Abschnitt 3.2.3 wurde schemagerecht angelegt und als final markiert.',
       NULL,
       'Quellen [71], [74], [76], [80] und [82]; Definitionen 3.2.11 bis 3.2.12; Gleichungen (3.59) bis (3.76).'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id AND object_reference = '3.2.3'
      AND change_type = 'created'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT @revision_id, @section_id, 'definition_added', 'definition', '3.2.11–3.2.12',
       'Die Definitionen der mathematischen Abbildung und des linearen Operators wurden aufgenommen.',
       'Letzte Definition nach 3.2.2: 3.2.10.',
       'Definitionen 3.2.11 und 3.2.12 registriert.'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id AND object_reference = '3.2.11–3.2.12'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT @revision_id, @section_id, 'equation_added', 'equation', '(3.59)–(3.76)',
       'Achtzehn fortlaufend nummerierte Gleichungen wurden aufgenommen.',
       'Letzte Gleichung nach 3.2.2: (3.58).',
       'Gleichungen (3.59) bis (3.76) registriert.'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id AND object_reference = '(3.59)–(3.76)'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value
)
SELECT @revision_id, @section_id, 'source_reused', 'source', '[71], [74], [76], [80], [82]',
       'Die bereits vorhandenen mathematischen Quellen wurden mit Abschnitt 3.2.3 verknüpft; es wurde keine neue Literaturstelle vergeben.',
       'Vorläufige Textverweise [10] und [13] waren nicht mit dem Repository-Literaturstand vereinbar.',
       'Strang wird als [74] und Reed/Simon als [76] geführt; letzte Literaturstelle bleibt [83].'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id = @revision_id AND object_reference = '[71], [74], [76], [80], [82]'
);

-- ---------------------------------------------------------------------
-- 8. Repository-Zähler fortschreiben
-- ---------------------------------------------------------------------

INSERT INTO repository_counters (counter_key, counter_value)
VALUES
    ('current_section', '3.2.4'),
    ('last_completed_section', '3.2.3'),
    ('last_definition_number', '3.2.12'),
    ('next_definition_number', '3.2.13'),
    ('last_equation_number', '3.76'),
    ('next_equation_number', '3.77'),
    ('last_citation_number', '83'),
    ('next_citation_number', '84')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value),
    updated_at = CURRENT_TIMESTAMP;

COMMIT;

-- =====================================================================
-- 9. Abschlussaudit
-- =====================================================================

SELECT
    section_id,
    section_code,
    title,
    status,
    section_order
FROM dissertation_sections
WHERE section_code = '3.2.3';

SELECT
    definition_number,
    title,
    validation_status,
    source_id
FROM definitions
WHERE section_id = @section_id
ORDER BY definition_number;

SELECT
    equation_number,
    title,
    equation_latex,
    word_latex,
    validation_status
FROM equations
WHERE section_id = @section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED);

SELECT
    s.citation_number,
    s.short_citation_text,
    su.usage_type,
    su.exact_location,
    su.citation_checked
FROM source_usage su
JOIN sources s ON s.source_id = su.source_id
WHERE su.section_id = @section_id
ORDER BY s.citation_number;

SELECT
    counter_key,
    counter_value
FROM repository_counters
WHERE counter_key IN
(
    'current_section',
    'last_completed_section',
    'last_definition_number',
    'next_definition_number',
    'last_equation_number',
    'next_equation_number',
    'last_citation_number',
    'next_citation_number'
)
ORDER BY counter_key;

SELECT
    CASE WHEN COUNT(*) = 2 THEN 'OK' ELSE 'FEHLER' END AS definition_audit,
    COUNT(*) AS definition_count
FROM definitions
WHERE section_id = @section_id
  AND definition_number IN ('3.2.11', '3.2.12');

SELECT
    CASE WHEN COUNT(*) = 18 THEN 'OK' ELSE 'FEHLER' END AS equation_audit,
    COUNT(*) AS equation_count,
    MIN(CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)) AS first_equation,
    MAX(CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED)) AS last_equation
FROM equations
WHERE section_id = @section_id
  AND CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED) BETWEEN 59 AND 76;

-- Erwarteter Abschlussstand:
-- current_section          = 3.2.4
-- last_completed_section   = 3.2.3
-- last_definition_number   = 3.2.12
-- next_definition_number   = 3.2.13
-- last_equation_number     = 3.76
-- next_equation_number     = 3.77
-- last_citation_number     = 83
-- next_citation_number     = 84
-- =====================================================================
