-- ---------------------------------------------------------------------
-- FRZK-REPOSITORY-UPDATE
-- Kapitel 3.2.5: Linearkombinationen, Spannräume und Erzeugendensysteme
-- Grundlage: realer Repository-Stand nach Abschnitt 3.2.4
-- MariaDB 10.4 / MySQL-kompatibel
-- ---------------------------------------------------------------------

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Vorbedingungen und Vorgängerstand
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
    WHERE revision_code = 'RKB-NEU-K3.2.4-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 2. Revision für Abschnitt 3.2.5
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
    'RKB-NEU-K3.2.5-V1',
    NOW(),
    'section',
    '3.2.5',
    '3.2.5-v1',
    'Aufnahme von Abschnitt 3.2.5 mit den Definitionen 3.2.16 und 3.2.17, den Gleichungen (3.113) bis (3.120) sowie der Wiederverwendung der Literaturstellen [71], [74] und [82].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_section_id IS NOT NULL
  AND @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.5-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.5-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Abschnitt 3.2.5
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
    '3.2.5',
    'Linearkombinationen, Spannräume und Erzeugendensysteme',
    3,
    3.2500,
    'final',
    0,
    'Etablierte Grundlagen zu Linearkombinationen, Spannräumen und Erzeugendensystemen. Quellen [71], [74] und [82]; Definitionen 3.2.16 bis 3.2.17; Gleichungen (3.113) bis (3.120).'
WHERE NOT EXISTS (
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.2.5'
);

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.5'
    LIMIT 1
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Linearkombinationen, Spannräume und Erzeugendensysteme',
    chapter_no = 3,
    section_order = 3.2500,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Etablierte Grundlagen zu Linearkombinationen, Spannräumen und Erzeugendensystemen. Quellen [71], [74] und [82]; Definitionen 3.2.16 bis 3.2.17; Gleichungen (3.113) bis (3.120).'
WHERE section_id = @section_id;

-- ---------------------------------------------------------------------
-- 4. Definitionen 3.2.16 und 3.2.17
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
    '3.2.16',
    @section_id,
    'Linearkombination',
    'Seien v_1 bis v_n Vektoren eines Vektorraums V und lambda_1 bis lambda_n Skalare des zugrunde liegenden Körpers. Dann heißt die Summe lambda_1 v_1 plus lambda_2 v_2 bis plus lambda_n v_n eine Linearkombination der Vektoren v_1 bis v_n.',
    '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n',
    '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n',
    'adapted',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Der Vektorraum V sowie Vektoraddition und Skalarmultiplikation sind definiert.',
    'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM definitions
    WHERE definition_number = '3.2.16'
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
    '3.2.17',
    @section_id,
    'Spannraum',
    'Der Spannraum einer endlichen Vektormenge ist die Menge aller Linearkombinationen dieser Vektoren. Er ist der kleinste Untervektorraum, der sämtliche betrachteten Vektoren enthält.',
    '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}',
    '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}',
    'adapted',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Linearkombinationen und Untervektorräume sind definiert.',
    'Etablierte Definition des linearen Spannraums.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1
    FROM definitions
    WHERE definition_number = '3.2.17'
);

-- ---------------------------------------------------------------------
-- 5. Gleichungen (3.113) bis (3.120)
-- ---------------------------------------------------------------------

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.113',
    @section_id,
    'Vektoren einer Linearkombination',
    'v_1,v_2,\\ldots,v_n\\in V',
    'v_1,v_2,\\ldots,v_n\\in V',
    'Die Vektoren v_1 bis v_n sind Elemente des Vektorraums V.',
    'definition',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.113'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.114',
    @section_id,
    'Skalare einer Linearkombination',
    '\\lambda_1,\\lambda_2,\\ldots,\\lambda_n\\in\\mathbb{R}',
    '\\lambda_1,\\lambda_2,\\ldots,\\lambda_n\\in\\mathbb{R}',
    'Die Koeffizienten einer reellen Linearkombination sind reelle Skalare.',
    'definition',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.114'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.115',
    @section_id,
    'Allgemeine Linearkombination',
    '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n',
    '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n',
    'Allgemeine Linearkombination der Vektoren v_1 bis v_n.',
    'definition',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.115'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.116',
    @section_id,
    'Beispielvektoren einer Linearkombination',
    'u=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v=\\begin{pmatrix}3\\\\1 \\end{pmatrix}',
    'u=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v=\\begin{pmatrix}3\\\\1 \\end{pmatrix}',
    'Zwei Beispielvektoren im zweidimensionalen reellen Koordinatenraum.',
    'example',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 74 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.116'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.117',
    @section_id,
    'Beispiel einer Linearkombination',
    '2u-v=\\begin{pmatrix}-1\\\\3 \\end{pmatrix}',
    '2u-v=\\begin{pmatrix}-1\\\\3 \\end{pmatrix}',
    'Berechnete Linearkombination der in Gleichung (3.116) definierten Vektoren.',
    'example',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 74 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.117'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.118',
    @section_id,
    'Notation des Spannraums',
    '\\operatorname{span}(v_1,\\ldots,v_n)',
    '\\operatorname{span}(v_1,\\ldots,v_n)',
    'Notation für den von den Vektoren v_1 bis v_n erzeugten Spannraum.',
    'definition',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.118'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.119',
    @section_id,
    'Mengendarstellung des Spannraums',
    '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}',
    '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}',
    'Der Spannraum als Menge sämtlicher reeller Linearkombinationen der gegebenen Vektoren.',
    'definition',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.119'
);

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
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.120',
    @section_id,
    'Erzeugendensystem eines Vektorraums',
    'V=\\operatorname{span}(v_1,\\ldots,v_n)',
    'V=\\operatorname{span}(v_1,\\ldots,v_n)',
    'Die Vektoren v_1 bis v_n erzeugen den gesamten Vektorraum V.',
    'definition',
    'literature',
    (SELECT source_id FROM sources WHERE citation_number = 71 LIMIT 1),
    'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.',
    'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number = '3.120'
);


-- ---------------------------------------------------------------------
-- 6. Literaturverwendungen
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    CASE s.citation_number
        WHEN 71 THEN 'definition'
        WHEN 74 THEN 'example'
        WHEN 82 THEN 'discussion'
    END,
    CASE s.citation_number
        WHEN 71 THEN 'Lang stützt die Definitionen der Linearkombination, des Spannraums und des Erzeugendensystems.'
        WHEN 74 THEN 'Strang stützt die koordinatenbezogenen Beispiele und die anschauliche Einordnung von Linearkombinationen und Erzeugendensystemen.'
        WHEN 82 THEN 'Halmos stützt die abstrakte algebraische Einordnung von Spannräumen, Erzeugendensystemen und minimalen Erzeugendensystemen.'
    END,
    'Abschnitt 3.2.5',
    0,
    1,
    CONCAT('Wiederverwendung der vorhandenen Literaturstelle [', s.citation_number, '].'),
    @revision_id
FROM sources s
WHERE s.citation_number IN (71, 74, 82)
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
  );

-- ---------------------------------------------------------------------
-- 7. Änderungsprotokoll
-- ---------------------------------------------------------------------

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
    '3.2.5',
    'Abschnitt 3.2.5 wurde schemagerecht angelegt und als final markiert.',
    NULL,
    'Quellen [71], [74] und [82]; Definitionen 3.2.16 bis 3.2.17; Gleichungen (3.113) bis (3.120).'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    '3.2.16–3.2.17',
    'Die Definitionen der Linearkombination und des Spannraums wurden aufgenommen.',
    'Letzte Definition nach 3.2.4: 3.2.15.',
    'Definitionen 3.2.16 bis 3.2.17 registriert.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.113)–(3.120)',
    'Acht fortlaufend nummerierte Gleichungen wurden aufgenommen.',
    'Letzte Gleichung nach 3.2.4: (3.112).',
    'Gleichungen (3.113) bis (3.120) registriert.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source',
    '[71], [74], [82]',
    'Die vorhandenen mathematischen Quellen wurden mit Abschnitt 3.2.5 verknüpft; es wurde keine neue Literaturstelle vergeben.',
    'Letzte Literaturstelle nach 3.2.4: [83].',
    'Letzte Literaturstelle bleibt [83].'
);

-- ---------------------------------------------------------------------
-- 8. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters (counter_key, counter_value)
VALUES
('current_section', '3.2.6'),
('last_completed_section', '3.2.5'),
('last_definition_number', '3.2.17'),
('next_definition_number', '3.2.18'),
('last_equation_number', '3.120'),
('next_equation_number', '3.121'),
('last_citation_number', '83'),
('next_citation_number', '84')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value);

COMMIT;

-- ---------------------------------------------------------------------
-- 9. Abschlussaudit
-- ---------------------------------------------------------------------

SELECT
    @revision_id AS revision_id,
    @section_id AS section_id,
    (SELECT section_code
       FROM dissertation_sections
      WHERE section_id = @section_id) AS section_code,
    (SELECT COUNT(*)
       FROM definitions
      WHERE section_id = @section_id) AS definitions_count,
    (SELECT MIN(definition_number)
       FROM definitions
      WHERE section_id = @section_id) AS first_definition,
    (SELECT MAX(definition_number)
       FROM definitions
      WHERE section_id = @section_id) AS last_definition,
    (SELECT COUNT(*)
       FROM equations
      WHERE section_id = @section_id) AS equations_count,
    (SELECT MIN(CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED))
       FROM equations
      WHERE section_id = @section_id) AS first_equation_suffix,
    (SELECT MAX(CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED))
       FROM equations
      WHERE section_id = @section_id) AS last_equation_suffix,
    (SELECT COUNT(*)
       FROM source_usage
      WHERE section_id = @section_id) AS source_usage_count,
    (SELECT counter_value
       FROM repository_counters
      WHERE counter_key = 'next_definition_number') AS next_definition_number,
    (SELECT counter_value
       FROM repository_counters
      WHERE counter_key = 'next_equation_number') AS next_equation_number;
