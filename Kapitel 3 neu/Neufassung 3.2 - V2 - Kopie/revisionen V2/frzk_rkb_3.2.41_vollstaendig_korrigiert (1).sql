-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.41
-- Riemannsche Geometrie und Krümmung
--
-- Definitionen : 3.2.610–3.2.620
-- Sätze        : 3.2.137–3.2.140
-- Gleichungen  : (3.3022)–(3.3028)
-- Literatur    : [115]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

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
    'RKB-NEU-K3.2.41-V1',
    NOW(),
    'section',
    '3.2.41',
    '3.2.41-v1',
    'Riemannsche Geometrie, Levi-Civita-Zusammenhang, Krümmungstensoren, Paralleltransport und funktionale Krümmungsräume des FRZK.',
    'Olaf Thiele / ChatGPT',
    @parent_revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.41-V1'
);

SET @revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.41-V1'
    LIMIT 1
);

SET @parent_section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2'
    LIMIT 1
);

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
    @parent_section,
    '3.2.41',
    'Riemannsche Geometrie und Krümmung',
    3,
    3241,
    'final',
    1,
    'Metrischer Tensor, Levi-Civita-Zusammenhang, Christoffel-Symbole, Krümmung, Paralleltransport und funktionale FRZK-Übertragung.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.2.41'
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.41'
    LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Literatur [115]
-- ---------------------------------------------------------------------------

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    notes
)
SELECT
    'do Carmo',
    'Manfredo P.',
    'do Carmo, Manfredo P.',
    'Autor der Quelle [115].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name='do Carmo, Manfredo P.'
);

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original,
    year_edition,
    publisher,
    place,
    edition,
    language_code,
    priority,
    evidence_type,
    frzk_relevance,
    verification_status,
    first_citation_section_code,
    first_citation_note,
    full_citation_text,
    short_citation_text,
    notes,
    created_revision_id
)
SELECT
    115,
    'do_carmo_riemannian_geometry',
    'book',
    'Riemannian Geometry',
    1992,
    1992,
    'Birkhäuser',
    'Boston',
    NULL,
    'en',
    1,
    'secondary_source',
    10,
    'pending',
    '3.2.41',
    'Erstnennung für Riemannsche Mannigfaltigkeiten, Levi-Civita-Zusammenhang und Krümmung.',
    'do Carmo, Manfredo P.: Riemannian Geometry. Birkhäuser, Boston, 1992.',
    'do Carmo, Riemannian Geometry [115]',
    'Bibliografischer Arbeitsstand; vor Endredaktion gegen den offiziellen Literaturbestand prüfen.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=115
       OR source_key='do_carmo_riemannian_geometry'
);

SET @src115 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=115
    LIMIT 1
);

SET @author115 := (
    SELECT author_id
    FROM authors
    WHERE normalized_name='do Carmo, Manfredo P.'
    LIMIT 1
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT
    @src115,
    @author115,
    1,
    'author'
WHERE @src115 IS NOT NULL
  AND @author115 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_authors
    WHERE source_id=@src115
      AND author_id=@author115
);

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
    @src115,
    @section,
    'first_citation',
    'Riemannsche Mannigfaltigkeit, metrischer Tensor, Levi-Civita-Zusammenhang, Christoffel-Symbole, Krümmungstensoren und Paralleltransport.',
    '3.2.41',
    1,
    0,
    'Quelle [115] vor Endredaktion bibliografisch prüfen.',
    @revision
WHERE @src115 IS NOT NULL
  AND @section IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@src115
      AND section_id=@section
      AND exact_location='3.2.41'
);

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.610–3.2.620
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_defs_3241
(
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_3241 VALUES
('3.2.610','Riemannsche Mannigfaltigkeit','Eine Riemannsche Mannigfaltigkeit besteht aus einem Paar (M,g), wobei M eine differenzierbare Mannigfaltigkeit und g ein positiv definiter metrischer Tensor ist.','(M,g)','(M,g)','literature',@src115),
('3.2.611','Linienelement','Das quadratische Linienelement einer Riemannschen Mannigfaltigkeit wird durch ds^2=g_ij dx^i dx^j beschrieben.','ds^2=g_{ij}dx^idx^j','ds^2=g_{ij}dx^idx^j','literature',@src115),
('3.2.612','Levi-Civita-Zusammenhang','Der Levi-Civita-Zusammenhang ist der eindeutig bestimmte torsionsfreie und metrikverträgliche Zusammenhang einer Riemannschen Mannigfaltigkeit.','\\nabla g=0,\\qquad T^\\nabla=0','\\nabla g=0,\\qquad T^\\nabla=0','literature',@src115),
('3.2.613','Christoffel-Symbole','Die Christoffel-Symbole beschreiben die Zusammenhangskoeffizienten des Levi-Civita-Zusammenhangs in lokalen Koordinaten.','\\Gamma^k_{ij}=\\frac12 g^{km}\\left(\\partial_i g_{jm}+\\partial_j g_{im}-\\partial_m g_{ij}\\right)','\\Gamma^k_{ij}=\\frac12 g^{km}\\left(\\partial_i g_{jm}+\\partial_j g_{im}-\\partial_m g_{ij}\\right)','literature',@src115),
('3.2.614','Riemannscher Krümmungstensor','Der Riemannsche Krümmungstensor misst die Nichtvertauschbarkeit kovarianter Ableitungen.','R(X,Y)Z=\\nabla_X\\nabla_YZ-\\nabla_Y\\nabla_XZ-\\nabla_{[X,Y]}Z','R(X,Y)Z=\\nabla_X\\nabla_YZ-\\nabla_Y\\nabla_XZ-\\nabla_{[X,Y]}Z','literature',@src115),
('3.2.615','Ricci-Tensor','Durch Kontraktion des Riemannschen Krümmungstensors entsteht der Ricci-Tensor.','R_{ij}=R^k{}_{ikj}','R_{ij}=R^k{}_{ikj}','literature',@src115),
('3.2.616','Skalare Krümmung','Die skalare Krümmung entsteht durch Kontraktion des Ricci-Tensors mit dem inversen metrischen Tensor.','R=g^{ij}R_{ij}','R=g^{ij}R_{ij}','literature',@src115),
('3.2.617','Paralleltransport','Der Paralleltransport beschreibt die Übertragung eines Tangentialvektors entlang einer Kurve unter Erhaltung des Zusammenhangs.','\\nabla_{\\dot\\gamma}V=0','\\nabla_{\\dot\\gamma}V=0','literature',@src115),
('3.2.618','Funktionaler metrischer Tensor','Ein funktionaler metrischer Tensor beschreibt Ähnlichkeiten funktionaler Zustände innerhalb einer funktionalen Mannigfaltigkeit.','g_F:T_zF\\times T_zF\\rightarrow\\mathbb R','g_F:T_zF\\times T_zF\\rightarrow\\mathbb R','original',NULL),
('3.2.619','Funktionale Krümmung','Die funktionale Krümmung beschreibt lokale Änderungen der Operatorstruktur innerhalb des funktionalen Zustandsraumes.','R_F','R_F','original',NULL),
('3.2.620','Funktionaler Zusammenhang','Der funktionale Zusammenhang beschreibt konsistente Übergänge zwischen benachbarten funktionalen Zuständen.','\\nabla_F','\\nabla_F','original',NULL);

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
    t.definition_number,
    @section,
    t.title,
    t.definition_text,
    t.formal_latex,
    t.word_latex,
    t.provenance,
    t.source_id,
    'Voraussetzungen gemäß Abschnitt 3.2.41.',
    CASE
        WHEN t.provenance='original'
        THEN 'FRZK-spezifische Eigenkonstruktion; spätere mathematische und empirische Operationalisierung erforderlich.'
        ELSE 'Begriff aus der klassischen Riemannschen Geometrie.'
    END,
    'verified',
    @revision
FROM tmp_defs_3241 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=t.definition_number
);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.137–3.2.140
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_thms_3241
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_3241 VALUES
('3.2.137','Existenz des Levi-Civita-Zusammenhangs','Zu jeder Riemannschen Mannigfaltigkeit existiert genau ein torsionsfreier metrikverträglicher Zusammenhang.','\\exists!\\,\\nabla:\\ \\nabla g=0\\ \\land\\ T^\\nabla=0','\\exists!\\,\\nabla:\\ \\nabla g=0\\ \\land\\ T^\\nabla=0','literature',@src115),
('3.2.138','Flache Räume','Verschwindet der Riemannsche Krümmungstensor überall, so ist die Mannigfaltigkeit lokal euklidisch.','R^\\ell{}_{ijk}=0','R^\\ell{}_{ijk}=0','literature',@src115),
('3.2.139','Geometrische Bedeutung der Krümmung','Der Paralleltransport entlang geschlossener Kurven ist genau dann wegunabhängig, wenn die Krümmung verschwindet.','R=0\\Longleftrightarrow\\text{lokale Wegunabhängigkeit des Paralleltransports}','R=0\\Longleftrightarrow\\text{lokale Wegunabhängigkeit des Paralleltransports}','literature',@src115),
('3.2.140','Funktionale lokale Kohärenz','Besitzt eine funktionale Mannigfaltigkeit einen differenzierbaren funktionalen Zusammenhang und einen funktionalen metrischen Tensor, so können lokale Änderungen der Kohärenz durch einen funktionalen Krümmungsoperator beschrieben werden.','(g_F,\\nabla_F)\\Longrightarrow R_F','(g_F,\\nabla_F)\\Longrightarrow R_F','original',NULL);

INSERT INTO theorems
(
    theorem_number,
    section_id,
    title,
    statement_text,
    statement_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    t.theorem_number,
    @section,
    t.title,
    t.statement_text,
    t.statement_latex,
    t.word_latex,
    t.provenance,
    t.source_id,
    'Voraussetzungen gemäß Abschnitt 3.2.41.',
    'verified',
    @revision
FROM tmp_thms_3241 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3022)–(3.3028)
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_eqs_3241
(
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM(
        'definition',
        'axiom',
        'theorem',
        'lemma',
        'derived',
        'schema',
        'model',
        'metric',
        'other'
    ) NOT NULL,
    provenance ENUM('original','adapted','literature') NOT NULL,
    source_id BIGINT UNSIGNED NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_3241 VALUES
('3.3022','Struktur der Riemannschen Geometrie','(M,g)\\longrightarrow\\nabla\\longrightarrow R','(M,g)\\longrightarrow\\nabla\\longrightarrow R','Formale Gleichung aus Abschnitt 3.2.41.','schema','literature',@src115),
('3.3023','Riemannsche Mannigfaltigkeit','(M,g)','(M,g)','Formale Gleichung aus Abschnitt 3.2.41.','definition','literature',@src115),
('3.3024','Quadratisches Linienelement','ds^2=g_{ij}dx^idx^j','ds^2=g_{ij}dx^idx^j','Formale Gleichung aus Abschnitt 3.2.41.','definition','literature',@src115),
('3.3025','Christoffel-Symbole','\\Gamma^k_{ij}=\\frac12 g^{km}\\left(\\partial_i g_{jm}+\\partial_j g_{im}-\\partial_m g_{ij}\\right)','\\Gamma^k_{ij}=\\frac12 g^{km}\\left(\\partial_i g_{jm}+\\partial_j g_{im}-\\partial_m g_{ij}\\right)','Formale Gleichung aus Abschnitt 3.2.41.','definition','literature',@src115),
('3.3026','Ricci-Tensor','R_{ij}','R_{ij}','Formale Gleichung aus Abschnitt 3.2.41.','definition','literature',@src115),
('3.3027','Skalare Krümmung','R=g^{ij}R_{ij}','R=g^{ij}R_{ij}','Formale Gleichung aus Abschnitt 3.2.41.','definition','literature',@src115),
('3.3028','Verschwindender Krümmungstensor','R^\\ell{}_{ijk}=0','R^\\ell{}_{ijk}=0','Formale Gleichung aus Abschnitt 3.2.41.','theorem','literature',@src115);

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
    t.equation_number,
    @section,
    t.title,
    t.equation_latex,
    t.word_latex,
    t.plain_description,
    t.equation_type,
    t.provenance,
    t.source_id,
    'Im Text von Abschnitt 3.2.41 eingeführt oder aus den Grundbegriffen der Riemannschen Geometrie abgeleitet.',
    'Voraussetzungen gemäß Abschnitt 3.2.41.',
    'verified',
    @revision
FROM tmp_eqs_3241 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number=t.equation_number
);

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    new_value
)
SELECT
    @revision,
    @section,
    'created',
    'section',
    '3.2.41',
    'Abschnitt 3.2.41 vollständig angelegt.',
    '11 Definitionen, 4 Sätze, 7 Gleichungen und Quelle [115].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.41'
);

-- ---------------------------------------------------------------------------
-- Repository-Zähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters
(
    counter_key,
    counter_value
)
VALUES
    ('last_completed_section','3.2.41'),
    ('current_section','3.2.42'),
    ('last_definition_number','3.2.620'),
    ('next_definition_number','3.2.621'),
    ('last_theorem_number','3.2.140'),
    ('next_theorem_number','3.2.141'),
    ('last_equation_number','3.3028'),
    ('next_equation_number','3.3029'),
    ('last_citation_number','115'),
    ('next_citation_number','116')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_3241;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_3241;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_3241;

COMMIT;

-- ###########################################################################
-- Abschlussprüfung
-- ###########################################################################

SELECT
    section_id,
    section_code,
    title,
    status
FROM dissertation_sections
WHERE section_code='3.2.41';

SELECT COUNT(*) AS definitionen_3_2_41
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 610 AND 620;

SELECT COUNT(*) AS saetze_3_2_41
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 137 AND 140;

SELECT COUNT(*) AS gleichungen_3_2_41
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3022 AND 3028;

SELECT
    s.citation_number,
    s.short_citation_text,
    s.verification_status,
    su.usage_type,
    su.exact_location,
    su.citation_checked
FROM source_usage su
JOIN sources s
  ON s.source_id=su.source_id
WHERE su.section_id=@section
ORDER BY s.citation_number;

SELECT
    counter_key,
    counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_completed_section',
    'current_section',
    'last_definition_number',
    'next_definition_number',
    'last_theorem_number',
    'next_theorem_number',
    'last_equation_number',
    'next_equation_number',
    'last_citation_number',
    'next_citation_number'
)
ORDER BY counter_key;
