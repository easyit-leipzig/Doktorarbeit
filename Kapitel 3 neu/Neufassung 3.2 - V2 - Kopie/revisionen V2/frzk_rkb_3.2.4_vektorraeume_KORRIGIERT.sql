-- ---------------------------------------------------------------------
-- KORRIGIERTES FRZK-REPOSITORY-UPDATE
-- Kapitel 3.2.4: Vektorräume als mathematische Zustandsräume
-- Grundlage: frzk_rkb_stand_3.2.3.sql
-- Ersetzt die fehlerhafte Fassung mit der nicht vorhandenen Spalte revision_tag.
-- MariaDB 10.4 / MySQL-kompatibel
-- ---------------------------------------------------------------------

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Vorbedingungen
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
    WHERE revision_code = 'RKB-NEU-K3.2.3-V1'
    LIMIT 1
);

-- Abbruch durch Pflichtfeldverletzung, falls der notwendige Vorgänger fehlt.
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
    'RKB-NEU-K3.2.4-V1',
    NOW(),
    'section',
    '3.2.4',
    '3.2.4-v1',
    'Repositorygerechte Aufnahme von Abschnitt 3.2.4 mit den Definitionen 3.2.13 bis 3.2.15, den Gleichungen (3.77) bis (3.112) und der Wiederverwendung der Quellen [71], [74], [76] und [82].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_section_id IS NOT NULL
  AND @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.4-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.4-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 2. Abschnitt 3.2.4
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
    '3.2.4',
    'Vektorräume als mathematische Zustandsräume',
    3,
    3.2400,
    'final',
    0,
    'Etablierte Grundlagen reeller Vektorräume, Vektorraumaxiome, Nullvektor, Skalarmultiplikation mit null, Untervektorräume und Beispiele. Quellen [71], [74], [76] und [82]; Definitionen 3.2.13 bis 3.2.15; Gleichungen (3.77) bis (3.112).'
WHERE NOT EXISTS (
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.2.4'
);

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.4'
    LIMIT 1
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Vektorräume als mathematische Zustandsräume',
    chapter_no = 3,
    section_order = 3.2400,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Etablierte Grundlagen reeller Vektorräume, Vektorraumaxiome, Nullvektor, Skalarmultiplikation mit null, Untervektorräume und Beispiele. Quellen [71], [74], [76] und [82]; Definitionen 3.2.13 bis 3.2.15; Gleichungen (3.77) bis (3.112).'
WHERE section_id = @section_id;

-- ---------------------------------------------------------------------
-- 3. Definitionen 3.2.13 bis 3.2.15
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
    '3.2.13',
    @section_id,
    'Vektorraum',
    'Sei K ein Körper. Ein Vektorraum V über K ist eine nichtleere Menge mit einer Vektoraddition und einer Skalarmultiplikation, welche die Vektorraumaxiome erfüllen.',
    '+:V\\times V\\rightarrow V;\\qquad \\cdot:K\\times V\\rightarrow V',
    '+:V\\times V\\rightarrow V;\\qquad \\cdot:K\\times V\\rightarrow V',
    'adapted',
    (SELECT source_id FROM sources WHERE citation_number = 71),
    'Der Körper K sowie innere und äußere Verknüpfungen sind definiert.',
    'Etablierte Definition eines Vektorraums; keine FRZK-spezifische Eigenleistung.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number = '3.2.13'
);

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text, formal_latex,
    word_latex, provenance, source_id, assumptions, notes,
    validation_status, created_revision_id
)
SELECT
    '3.2.14',
    @section_id,
    'Nullvektor',
    'Der Nullvektor ist das eindeutig bestimmte neutrale Element der Vektoraddition. Für jeden Vektor v aus V gilt v plus 0_V gleich v.',
    '0_V\\in V;\\qquad v+0_V=v',
    '0_V\\in V;\\qquad v+0_V=v',
    'adapted',
    (SELECT source_id FROM sources WHERE citation_number = 71),
    'Der Vektorraum V und seine Addition sind definiert.',
    'Etablierter Begriff des additiven neutralen Elements.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number = '3.2.14'
);

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text, formal_latex,
    word_latex, provenance, source_id, assumptions, notes,
    validation_status, created_revision_id
)
SELECT
    '3.2.15',
    @section_id,
    'Untervektorraum',
    'Eine Teilmenge U eines Vektorraums V heißt Untervektorraum, wenn U mit den aus V übernommenen Operationen selbst einen Vektorraum bildet.',
    'U\\leq V',
    'U\\leq V',
    'adapted',
    (SELECT source_id FROM sources WHERE citation_number = 71),
    'Der Vektorraum V sowie seine Addition und Skalarmultiplikation sind definiert.',
    'Etablierte Untervektorraumdefinition.',
    'verified',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM definitions WHERE definition_number = '3.2.15'
);

-- ---------------------------------------------------------------------
-- 4. Gleichungen (3.77) bis (3.112)
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
VALUES
('3.77', @section_id, 'Vektoraddition als innere Verknüpfung', '+:V\\times V\\rightarrow V', '+:V\\times V\\rightarrow V', 'Die Vektoraddition ordnet zwei Vektoren aus V wieder einem Vektor aus V zu.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.78', @section_id, 'Skalarmultiplikation als äußere Verknüpfung', '\\cdot:K\\times V\\rightarrow V', '\\cdot:K\\times V\\rightarrow V', 'Die Skalarmultiplikation ordnet einem Skalar und einem Vektor wieder einen Vektor aus V zu.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.79', @section_id, 'Reeller Vektorraum', 'V\\text{ über }\\mathbb{R}', 'V\\text{ über }\\mathbb{R}', 'V wird als Vektorraum über dem Körper der reellen Zahlen betrachtet.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.80', @section_id, 'Reelle Skalare', '\\lambda\\in\\mathbb{R}', '\\lambda\\in\\mathbb{R}', 'Der verwendete Skalar ist eine reelle Zahl.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.81', @section_id, 'Vektoren des Raumes', 'u,v,w\\in V', 'u,v,w\\in V', 'Die Vektoren u, v und w sind Elemente des Vektorraums V.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.82', @section_id, 'Abgeschlossenheit der Addition', 'u+v\\in V', 'u+v\\in V', 'Die Summe zweier Vektoren aus V ist wieder ein Vektor aus V.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.83', @section_id, 'Assoziativität der Vektoraddition', '(u+v)+w=u+(v+w)', '(u+v)+w=u+(v+w)', 'Die Vektoraddition ist assoziativ.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.84', @section_id, 'Kommutativität der Vektoraddition', 'u+v=v+u', 'u+v=v+u', 'Die Vektoraddition ist kommutativ.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.85', @section_id, 'Nullvektor als Raumelement', '0_V\\in V', '0_V\\in V', 'Der Nullvektor ist ein Element des Vektorraums V.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.86', @section_id, 'Neutrale Wirkung des Nullvektors', 'v+0_V=v', 'v+0_V=v', 'Der Nullvektor ist das neutrale Element der Vektoraddition.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.87', @section_id, 'Nullvektor im zweidimensionalen Raum', '0_{\\mathbb{R}^2}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}', '0_{\\mathbb{R}^2}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}', 'Koordinatendarstellung des Nullvektors im zweidimensionalen reellen Vektorraum.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=74), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.88', @section_id, 'Additives Inverses', 'v+(-v)=0_V', 'v+(-v)=0_V', 'Die Summe eines Vektors und seines additiven Inversen ergibt den Nullvektor.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.89', @section_id, 'Vektorsubtraktion', 'u-v', 'u-v', 'Notation der Subtraktion zweier Vektoren.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.90', @section_id, 'Subtraktion als Addition des Inversen', 'u-v=u+(-v)', 'u-v=u+(-v)', 'Vektorsubtraktion wird als Addition des additiven Inversen definiert.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.91', @section_id, 'Skalare des Körpers', '\\lambda,\\mu\\in K', '\\lambda,\\mu\\in K', 'Die Skalare lambda und mu sind Elemente des Skalarkörpers K.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.92', @section_id, 'Abgeschlossenheit der Skalarmultiplikation', '\\lambda v\\in V', '\\lambda v\\in V', 'Das Produkt eines Skalars mit einem Vektor ist wieder ein Vektor aus V.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.93', @section_id, 'Verträglichkeit der Skalarmultiplikation', '(\\lambda\\mu)v=\\lambda(\\mu v)', '(\\lambda\\mu)v=\\lambda(\\mu v)', 'Die Skalarmultiplikation ist mit der Multiplikation im Körper verträglich.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.94', @section_id, 'Neutrales Skalarelement', '1_Kv=v', '1_Kv=v', 'Das multiplikative Einselement des Körpers wirkt neutral auf Vektoren.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.95', @section_id, 'Distributivität über der Vektoraddition', '\\lambda(u+v)=\\lambda u+\\lambda v', '\\lambda(u+v)=\\lambda u+\\lambda v', 'Die Skalarmultiplikation ist distributiv bezüglich der Vektoraddition.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.96', @section_id, 'Distributivität über der Skalaraddition', '(\\lambda+\\mu)v=\\lambda v+\\mu v', '(\\lambda+\\mu)v=\\lambda v+\\mu v', 'Die Skalarmultiplikation ist distributiv bezüglich der Addition im Skalarkörper.', 'axiom', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.97', @section_id, 'Multiplikation eines Vektors mit null', '0_Kv=0_V', '0_Kv=0_V', 'Die Multiplikation eines Vektors mit dem skalaren Nullelement ergibt den Nullvektor.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.98', @section_id, 'Ausgangspunkt der Nullskalarderivation', '0_Kv=(0_K+0_K)v', '0_Kv=(0_K+0_K)v', 'Das skalare Nullelement wird als Summe zweier Nullelemente dargestellt.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.99', @section_id, 'Distributiver Schritt der Nullskalarderivation', '0_Kv=0_Kv+0_Kv', '0_Kv=0_Kv+0_Kv', 'Anwendung der Distributivität auf die Multiplikation mit dem skalaren Nullelement.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.100', @section_id, 'Ergebnis der Nullskalarderivation', '0_V=0_Kv', '0_V=0_Kv', 'Nach Addition des inversen Vektors ergibt sich der Nullvektor.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.101', @section_id, 'Skalarmultiplikation des Nullvektors', '\\lambda 0_V=0_V', '\\lambda 0_V=0_V', 'Jeder Skalar bildet den Nullvektor wieder auf den Nullvektor ab.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.102', @section_id, 'Additive Zerlegung des Nullvektors', '0_V=0_V+0_V', '0_V=0_V+0_V', 'Der Nullvektor wird als Summe zweier Nullvektoren dargestellt.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.103', @section_id, 'Skalierung der Nullvektorzerlegung', '\\lambda 0_V=\\lambda(0_V+0_V)', '\\lambda 0_V=\\lambda(0_V+0_V)', 'Die additive Zerlegung des Nullvektors wird mit einem Skalar multipliziert.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.104', @section_id, 'Distributiver Schritt für den Nullvektor', '\\lambda 0_V=\\lambda 0_V+\\lambda 0_V', '\\lambda 0_V=\\lambda 0_V+\\lambda 0_V', 'Anwendung des Distributivgesetzes auf den skalierten Nullvektor.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.105', @section_id, 'Invarianz des Nullvektors', '\\lambda 0_V=0_V', '\\lambda 0_V=0_V', 'Der Nullvektor bleibt unter jeder Skalarmultiplikation invariant.', 'derived', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.106', @section_id, 'Untervektorraumrelation', 'U\\leq V', 'U\\leq V', 'U ist ein Untervektorraum von V.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.107', @section_id, 'Abgeschlossenheit eines Untervektorraums unter Addition', 'u+v\\in U', 'u+v\\in U', 'Die Summe zweier Vektoren aus U liegt wieder in U.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.108', @section_id, 'Abgeschlossenheit eines Untervektorraums unter Skalarmultiplikation', '\\lambda u\\in U', '\\lambda u\\in U', 'Das skalare Vielfache eines Vektors aus U liegt wieder in U.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=71), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.109', @section_id, 'Reeller Koordinatenraum', '\\mathbb{R}^n', '\\mathbb{R}^n', 'Der n-dimensionale reelle Koordinatenraum.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=74), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.110', @section_id, 'Vektor im zweidimensionalen reellen Raum', 'v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}\\in\\mathbb{R}^2', 'v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}\\in\\mathbb{R}^2', 'Darstellung eines Vektors im zweidimensionalen reellen Koordinatenraum.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=74), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.111', @section_id, 'Vektor im dreidimensionalen reellen Raum', 'v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3', 'v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3', 'Darstellung eines Vektors im dreidimensionalen reellen Koordinatenraum.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=74), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id),
('3.112', @section_id, 'Matrizenraum', '\\mathbb{R}^{m\\times n}', '\\mathbb{R}^{m\\times n}', 'Der Raum aller reellen m-mal-n-Matrizen bildet einen reellen Vektorraum.', 'definition', 'literature', (SELECT source_id FROM sources WHERE citation_number=74), 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', @revision_id);

-- ---------------------------------------------------------------------
-- 5. Literaturverwendungen
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
    'definition',
    CASE s.citation_number
        WHEN 71 THEN 'Lang stützt die Definition des Vektorraums, die Vektorraumaxiome, den Nullvektor, additive Inverse und Untervektorräume.'
        WHEN 74 THEN 'Strang stützt Koordinatendarstellungen, Beispiele reeller Vektorräume und die anschauliche Einordnung linearer Strukturen.'
        WHEN 76 THEN 'Reed und Simon stützen die Einordnung von Funktionenräumen und abstrakten Vektorräumen in der Funktionalanalysis.'
        WHEN 82 THEN 'Halmos stützt die abstrakte lineare Algebra, Vektorraumaxiome und die Trennung zwischen Vektor und Koordinatendarstellung.'
    END,
    'Abschnitt 3.2.4',
    0,
    1,
    CONCAT('Wiederverwendung der vorhandenen Literaturstelle [', s.citation_number, '].'),
    @revision_id
FROM sources s
WHERE s.citation_number IN (71,74,76,82)
  AND NOT EXISTS (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
  );

-- ---------------------------------------------------------------------
-- 6. Änderungsprotokoll
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
    '3.2.4',
    'Abschnitt 3.2.4 wurde schemagerecht angelegt und als final markiert.',
    NULL,
    'Quellen [71], [74], [76] und [82]; Definitionen 3.2.13 bis 3.2.15; Gleichungen (3.77) bis (3.112).'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    '3.2.13–3.2.15',
    'Die Definitionen des Vektorraums, des Nullvektors und des Untervektorraums wurden aufgenommen.',
    'Letzte Definition nach 3.2.3: 3.2.12.',
    'Definitionen 3.2.13 bis 3.2.15 registriert.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.77)–(3.112)',
    'Sechsunddreißig fortlaufend nummerierte Gleichungen wurden aufgenommen.',
    'Letzte Gleichung nach 3.2.3: (3.76).',
    'Gleichungen (3.77) bis (3.112) registriert.'
),
(
    @revision_id,
    @section_id,
    'source_reused',
    'source',
    '[71], [74], [76], [82]',
    'Die bereits vorhandenen mathematischen Quellen wurden mit Abschnitt 3.2.4 verknüpft; es wurde keine neue Literaturstelle vergeben.',
    'Letzte Literaturstelle nach 3.2.3: [83].',
    'Letzte Literaturstelle bleibt [83].'
);

-- ---------------------------------------------------------------------
-- 7. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters (counter_key, counter_value)
VALUES
('current_section', '3.2.5'),
('last_completed_section', '3.2.4'),
('last_definition_number', '3.2.15'),
('next_definition_number', '3.2.16'),
('last_equation_number', '3.112'),
('next_equation_number', '3.113'),
('last_citation_number', '83'),
('next_citation_number', '84')
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value);

COMMIT;

-- ---------------------------------------------------------------------
-- 8. Abschlussaudit
-- ---------------------------------------------------------------------

SELECT
    @revision_id AS revision_id,
    @section_id AS section_id,
    (SELECT section_code FROM dissertation_sections WHERE section_id=@section_id) AS section_code,
    (SELECT COUNT(*) FROM definitions WHERE section_id=@section_id) AS definitions_count,
    (SELECT MIN(definition_number) FROM definitions WHERE section_id=@section_id) AS first_definition,
    (SELECT MAX(definition_number) FROM definitions WHERE section_id=@section_id) AS last_definition,
    (SELECT COUNT(*) FROM equations WHERE section_id=@section_id) AS equations_count,
    (SELECT MIN(CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)) FROM equations WHERE section_id=@section_id) AS first_equation_suffix,
    (SELECT MAX(CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)) FROM equations WHERE section_id=@section_id) AS last_equation_suffix,
    (SELECT COUNT(*) FROM source_usage WHERE section_id=@section_id) AS source_usage_count;
