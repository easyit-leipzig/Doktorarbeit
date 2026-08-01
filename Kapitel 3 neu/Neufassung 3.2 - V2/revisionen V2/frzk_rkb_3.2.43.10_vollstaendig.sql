USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – vollständiges Update-Skript
   Abschnitt 3.2.43.10: Maxwell-Gleichungen in kovarianter Form

   Definitionen : 3.2.688–3.2.693
   Sätze        : 3.2.164–3.2.170
   Gleichungen  : (3.3271)–(3.3302)
   Literatur    : [122]
   Voraussetzung: vollständiger Repository-Stand bis 3.2.43.9
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43.9'
    ORDER BY revision_id DESC
    LIMIT 1
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.43'
    LIMIT 1
);

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_frzk_check_324310_prerequisites$$
CREATE PROCEDURE sp_frzk_check_324310_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für 3.2.43.9 fehlt.';
    END IF;

    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
END$$

CALL sp_frzk_check_324310_prerequisites()$$
DROP PROCEDURE sp_frzk_check_324310_prerequisites$$

DELIMITER ;

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
VALUES
(
    'RKB-NEU-K3.2.43.10-V1',
    NOW(),
    'subsection',
    '3.2.43.10',
    '3.2.43.10-v1-vollstaendig',
    'Viererstromdichte, inhomogene und homogene Maxwell-Gleichungen, dualer Feldtensor, Kontinuitätsgleichung und Lorentz-Kovarianz.',
    'Olaf Thiele / ChatGPT',
    @parent_revision
)
ON DUPLICATE KEY UPDATE
    revision_id=LAST_INSERT_ID(revision_id),
    revision_date=VALUES(revision_date),
    summary=VALUES(summary),
    parent_revision_id=VALUES(parent_revision_id);

SET @revision := LAST_INSERT_ID();

UPDATE dissertation_sections
SET
    status='in_progress',
    notes=CONCAT(
        COALESCE(notes,''),
        CASE WHEN COALESCE(notes,'')='' THEN '' ELSE ' ' END,
        'Ergänzt um 3.2.43.10: Maxwell-Gleichungen in kovarianter Form.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.10:%';

-- ---------------------------------------------------------------------------
-- Literatur [122]
-- ---------------------------------------------------------------------------

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
    122,
    'maxwell_kovariant_arbeitsquelle_122',
    'book',
    'Maxwell-Gleichungen in kovarianter Tensorform',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'de',
    2,
    'secondary_source',
    8,
    'pending',
    '3.2.43.10',
    'Arbeitsquelle für Viererstromdichte, kovariante Maxwell-Gleichungen, dualen Feldtensor, Kontinuitätsgleichung und Lorentz-Kovarianz.',
    'Bibliografische Quelle [122] ist vor der Endredaktion festzulegen und vollständig nachzutragen.',
    'Kovariante Maxwell-Gleichungen [122]',
    'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=122
       OR source_key='maxwell_kovariant_arbeitsquelle_122'
);

SET @src122 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=122
    LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.688–3.2.693
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_defs_324310;

CREATE TEMPORARY TABLE tmp_defs_324310
(
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_324310
VALUES
('3.2.688','Viererstromdichte','Die Viererstromdichte fasst die elektrische Ladungsdichte und die räumliche Stromdichte zu einem Vierervektor zusammen.','J^\\mu=\\begin{pmatrix}c\\rho\\\\j_x\\\\j_y\\\\j_z\\ \\end{pmatrix}','J^\\mu=\\begin{pmatrix}c\\rho\\\\j_x\\\\j_y\\\\j_z\\ \\end{pmatrix}'),
('3.2.689','Inhomogene Maxwell-Gleichung','Die inhomogenen Maxwell-Gleichungen werden durch die Viererdivergenz des elektromagnetischen Feldtensors und die Viererstromdichte beschrieben.','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu'),
('3.2.690','Dualer elektromagnetischer Feldtensor','Der duale elektromagnetische Feldtensor wird mithilfe des vollständig antisymmetrischen Levi-Civita-Tensors gebildet.','\\widetilde{F}^{\\mu\\nu}=\\frac{1}{2}\\varepsilon^{\\mu\\nu\\rho\\sigma}F_{\\rho\\sigma}','\\widetilde{F}^{\\mu\\nu}=\\frac{1}{2}\\varepsilon^{\\mu\\nu\\rho\\sigma}F_{\\rho\\sigma}'),
('3.2.691','Homogene Maxwell-Gleichung','Die homogenen Maxwell-Gleichungen werden durch die verschwindende Viererdivergenz des dualen elektromagnetischen Feldtensors beschrieben.','\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0','\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0'),
('3.2.692','Antisymmetrische Ableitungsidentität','Die homogenen Maxwell-Gleichungen können äquivalent als vollständig antisymmetrisierte Ableitung des elektromagnetischen Feldtensors geschrieben werden.','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}=0','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}=0'),
('3.2.693','Kovariante Maxwell-Struktur','Die kovariante Maxwell-Struktur besteht aus der inhomogenen Feldgleichung und der homogenen Gleichung des dualen Feldtensors.','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu,\\quad\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu,\\quad\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0');

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
    'literature',
    @src122,
    'Minkowski-Raumzeit, SI-Einheiten, konsistente Indexkonvention und hinreichende Differenzierbarkeit der Felder.',
    'Definition aus Unterabschnitt 3.2.43.10.',
    'verified',
    @revision
FROM tmp_defs_324310 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_324310 t
  ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src122,
    d.assumptions='Minkowski-Raumzeit, SI-Einheiten, konsistente Indexkonvention und hinreichende Differenzierbarkeit der Felder.',
    d.notes='Definition aus Unterabschnitt 3.2.43.10.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.164–3.2.170
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_thms_324310;

CREATE TEMPORARY TABLE tmp_thms_324310
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_324310
VALUES
('3.2.164','Gaußsches Gesetz als zeitartige Komponente','Für den zeitartigen Indexwert der inhomogenen Maxwell-Gleichung ergibt sich das gaußsche Gesetz des elektrischen Feldes.','\\nabla\\cdot\\mathbf{E}=\\frac{\\rho}{\\varepsilon_0}'),
('3.2.165','Ampère-Maxwell-Gesetz als räumliche Komponente','Für die räumlichen Indexwerte der inhomogenen Maxwell-Gleichung ergibt sich das Ampère-Maxwell-Gesetz.','\\nabla\\times\\mathbf{B}=\\mu_0\\mathbf{j}+\\mu_0\\varepsilon_0\\frac{\\partial\\mathbf{E}}{\\partial t}'),
('3.2.166','Gaußsches Gesetz des Magnetfeldes','Die zeitartige Komponente der homogenen Maxwell-Gleichung ergibt die Quellenfreiheit des Magnetfeldes.','\\nabla\\cdot\\mathbf{B}=0'),
('3.2.167','Faradaysches Induktionsgesetz','Die räumlichen Komponenten der homogenen Maxwell-Gleichung ergeben das Faradaysche Induktionsgesetz.','\\nabla\\times\\mathbf{E}=-\\frac{\\partial\\mathbf{B}}{\\partial t}'),
('3.2.168','Zusammenhang zwischen Feldtensor und homogener Maxwell-Gleichung','Ist der elektromagnetische Feldtensor durch ein hinreichend differenzierbares Viererpotential gegeben, sind die homogenen Maxwell-Gleichungen identisch erfüllt.','\\partial_{[\\lambda}F_{\\mu\\nu]}=0'),
('3.2.169','Kontinuitätsgleichung der elektrischen Ladung','Aus der inhomogenen Maxwell-Gleichung folgt aufgrund der Antisymmetrie des Feldtensors die lokale Erhaltung der elektrischen Ladung.','\\partial_\\nu J^\\nu=0'),
('3.2.170','Lorentz-Kovarianz der Maxwell-Gleichungen','Die kovarianten Maxwell-Gleichungen besitzen in allen durch Lorentz-Transformationen verbundenen Inertialsystemen dieselbe tensorielle Form.','\\partial''_\\mu F''^{\\mu\\nu}=\\mu_0J''^\\nu,\\quad\\partial''_\\mu\\widetilde{F}''^{\\mu\\nu}=0');

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
    t.statement_latex,
    'literature',
    @src122,
    'Vierdimensionale Minkowski-Raumzeit, Lorentz-Transformationen, Antisymmetrie des Feldtensors und vertauschbare partielle Ableitungen.',
    'verified',
    @revision
FROM tmp_thms_324310 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_324310 t
  ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src122,
    th.assumptions='Vierdimensionale Minkowski-Raumzeit, Lorentz-Transformationen, Antisymmetrie des Feldtensors und vertauschbare partielle Ableitungen.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3271)–(3.3302)
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_324310;

CREATE TEMPORARY TABLE tmp_eqs_324310
(
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM
    (
        'definition',
        'axiom',
        'theorem',
        'lemma',
        'derived',
        'schema',
        'model',
        'metric',
        'other'
    ) NOT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_324310
VALUES
('3.3271','Viererstromdichte in Spaltendarstellung','J^\\mu=\\begin{pmatrix}c\\rho\\\\j_x\\\\j_y\\\\j_z\\ \\end{pmatrix}','J^\\mu=\\begin{pmatrix}c\\rho\\\\j_x\\\\j_y\\\\j_z\\ \\end{pmatrix}','Gleichung aus Abschnitt 3.2.43.10: Viererstromdichte in Spaltendarstellung.','definition'),
('3.3272','Viererstromdichte in verkürzter Darstellung','J^\\mu=\\left(c\\rho,\\mathbf{j}\\right)','J^\\mu=\\left(c\\rho,\\mathbf{j}\\right)','Gleichung aus Abschnitt 3.2.43.10: Viererstromdichte in verkürzter Darstellung.','definition'),
('3.3273','Inhomogene Maxwell-Gleichung','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.10: Inhomogene Maxwell-Gleichung.','definition'),
('3.3274','Zeitartige Komponente der inhomogenen Maxwell-Gleichung','\\partial_\\mu F^{\\mu0}=\\mu_0J^0','\\partial_\\mu F^{\\mu0}=\\mu_0J^0','Gleichung aus Abschnitt 3.2.43.10: Zeitartige Komponente der inhomogenen Maxwell-Gleichung.','derived'),
('3.3275','Zeitartige Komponente der Viererstromdichte','J^0=c\\rho','J^0=c\\rho','Gleichung aus Abschnitt 3.2.43.10: Zeitartige Komponente der Viererstromdichte.','derived'),
('3.3276','Zusammenhang der elektromagnetischen Konstanten','\\mu_0\\varepsilon_0c^2=1','\\mu_0\\varepsilon_0c^2=1','Gleichung aus Abschnitt 3.2.43.10: Zusammenhang der elektromagnetischen Konstanten.','derived'),
('3.3277','Gaußsches Gesetz des elektrischen Feldes','\\nabla\\cdot\\mathbf{E}=\\frac{\\rho}{\\varepsilon_0}','\\nabla\\cdot\\mathbf{E}=\\frac{\\rho}{\\varepsilon_0}','Gleichung aus Abschnitt 3.2.43.10: Gaußsches Gesetz des elektrischen Feldes.','theorem'),
('3.3278','Räumliche Indexwerte','\\nu=1,2,3','\\nu=1,2,3','Gleichung aus Abschnitt 3.2.43.10: Räumliche Indexwerte.','derived'),
('3.3279','Räumliche Form der inhomogenen Maxwell-Gleichung','\\nabla\\times\\mathbf{B}-\\frac{1}{c^2}\\frac{\\partial\\mathbf{E}}{\\partial t}=\\mu_0\\mathbf{j}','\\nabla\\times\\mathbf{B}-\\frac{1}{c^2}\\frac{\\partial\\mathbf{E}}{\\partial t}=\\mu_0\\mathbf{j}','Gleichung aus Abschnitt 3.2.43.10: Räumliche Form der inhomogenen Maxwell-Gleichung.','derived'),
('3.3280','Kehrwert der quadratischen Lichtgeschwindigkeit','\\frac{1}{c^2}=\\mu_0\\varepsilon_0','\\frac{1}{c^2}=\\mu_0\\varepsilon_0','Gleichung aus Abschnitt 3.2.43.10: Kehrwert der quadratischen Lichtgeschwindigkeit.','derived'),
('3.3281','Ampère-Maxwell-Gesetz','\\nabla\\times\\mathbf{B}=\\mu_0\\mathbf{j}+\\mu_0\\varepsilon_0\\frac{\\partial\\mathbf{E}}{\\partial t}','\\nabla\\times\\mathbf{B}=\\mu_0\\mathbf{j}+\\mu_0\\varepsilon_0\\frac{\\partial\\mathbf{E}}{\\partial t}','Gleichung aus Abschnitt 3.2.43.10: Ampère-Maxwell-Gesetz.','theorem'),
('3.3282','Dualer elektromagnetischer Feldtensor','\\widetilde{F}^{\\mu\\nu}=\\frac{1}{2}\\varepsilon^{\\mu\\nu\\rho\\sigma}F_{\\rho\\sigma}','\\widetilde{F}^{\\mu\\nu}=\\frac{1}{2}\\varepsilon^{\\mu\\nu\\rho\\sigma}F_{\\rho\\sigma}','Gleichung aus Abschnitt 3.2.43.10: Dualer elektromagnetischer Feldtensor.','definition'),
('3.3283','Homogene Maxwell-Gleichung','\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0','\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0','Gleichung aus Abschnitt 3.2.43.10: Homogene Maxwell-Gleichung.','definition'),
('3.3284','Gaußsches Gesetz des Magnetfeldes','\\nabla\\cdot\\mathbf{B}=0','\\nabla\\cdot\\mathbf{B}=0','Gleichung aus Abschnitt 3.2.43.10: Gaußsches Gesetz des Magnetfeldes.','theorem'),
('3.3285','Faradaysches Induktionsgesetz in Summenform','\\nabla\\times\\mathbf{E}+\\frac{\\partial\\mathbf{B}}{\\partial t}=0','\\nabla\\times\\mathbf{E}+\\frac{\\partial\\mathbf{B}}{\\partial t}=0','Gleichung aus Abschnitt 3.2.43.10: Faradaysches Induktionsgesetz in Summenform.','theorem'),
('3.3286','Faradaysches Induktionsgesetz in Auflösungsform','\\nabla\\times\\mathbf{E}=-\\frac{\\partial\\mathbf{B}}{\\partial t}','\\nabla\\times\\mathbf{E}=-\\frac{\\partial\\mathbf{B}}{\\partial t}','Gleichung aus Abschnitt 3.2.43.10: Faradaysches Induktionsgesetz in Auflösungsform.','theorem'),
('3.3287','Antisymmetrische Ableitungsidentität','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}=0','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}=0','Gleichung aus Abschnitt 3.2.43.10: Antisymmetrische Ableitungsidentität.','definition'),
('3.3288','Verkürzte antisymmetrische Indexnotation','\\partial_{[\\lambda}F_{\\mu\\nu]}=0','\\partial_{[\\lambda}F_{\\mu\\nu]}=0','Gleichung aus Abschnitt 3.2.43.10: Verkürzte antisymmetrische Indexnotation.','definition'),
('3.3289','Feldtensor aus dem Viererpotential','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','Gleichung aus Abschnitt 3.2.43.10: Feldtensor aus dem Viererpotential.','derived'),
('3.3290','Antisymmetrisierte Ableitung des Feldtensors','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}','Gleichung aus Abschnitt 3.2.43.10: Antisymmetrisierte Ableitung des Feldtensors.','derived'),
('3.3291','Vertauschbarkeit gemischter zweiter Ableitungen','\\partial_\\mu\\partial_\\nu A_\\lambda=\\partial_\\nu\\partial_\\mu A_\\lambda','\\partial_\\mu\\partial_\\nu A_\\lambda=\\partial_\\nu\\partial_\\mu A_\\lambda','Gleichung aus Abschnitt 3.2.43.10: Vertauschbarkeit gemischter zweiter Ableitungen.','derived'),
('3.3292','Identische Erfüllung der homogenen Maxwell-Gleichung','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}=0','\\partial_\\lambda F_{\\mu\\nu}+\\partial_\\mu F_{\\nu\\lambda}+\\partial_\\nu F_{\\lambda\\mu}=0','Gleichung aus Abschnitt 3.2.43.10: Identische Erfüllung der homogenen Maxwell-Gleichung.','theorem'),
('3.3293','Kovariante Kontinuitätsgleichung','\\partial_\\nu J^\\nu=0','\\partial_\\nu J^\\nu=0','Gleichung aus Abschnitt 3.2.43.10: Kovariante Kontinuitätsgleichung.','theorem'),
('3.3294','Ausgangspunkt der Kontinuitätsherleitung','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.10: Ausgangspunkt der Kontinuitätsherleitung.','derived'),
('3.3295','Viererdivergenz der inhomogenen Maxwell-Gleichung','\\partial_\\nu\\partial_\\mu F^{\\mu\\nu}=\\mu_0\\partial_\\nu J^\\nu','\\partial_\\nu\\partial_\\mu F^{\\mu\\nu}=\\mu_0\\partial_\\nu J^\\nu','Gleichung aus Abschnitt 3.2.43.10: Viererdivergenz der inhomogenen Maxwell-Gleichung.','derived'),
('3.3296','Verschwinden der doppelten Divergenz','\\partial_\\nu\\partial_\\mu F^{\\mu\\nu}=0','\\partial_\\nu\\partial_\\mu F^{\\mu\\nu}=0','Gleichung aus Abschnitt 3.2.43.10: Verschwinden der doppelten Divergenz.','derived'),
('3.3297','Lokale Erhaltung der Viererstromdichte','\\partial_\\nu J^\\nu=0','\\partial_\\nu J^\\nu=0','Gleichung aus Abschnitt 3.2.43.10: Lokale Erhaltung der Viererstromdichte.','theorem'),
('3.3298','Dreidimensionale Kontinuitätsgleichung','\\frac{\\partial\\rho}{\\partial t}+\\nabla\\cdot\\mathbf{j}=0','\\frac{\\partial\\rho}{\\partial t}+\\nabla\\cdot\\mathbf{j}=0','Gleichung aus Abschnitt 3.2.43.10: Dreidimensionale Kontinuitätsgleichung.','theorem'),
('3.3299','Erste Gleichung der kovarianten Maxwell-Struktur','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.10: Erste Gleichung der kovarianten Maxwell-Struktur.','definition'),
('3.3300','Zweite Gleichung der kovarianten Maxwell-Struktur','\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0','\\partial_\\mu\\widetilde{F}^{\\mu\\nu}=0','Gleichung aus Abschnitt 3.2.43.10: Zweite Gleichung der kovarianten Maxwell-Struktur.','definition'),
('3.3301','Lorentz-transformierte inhomogene Maxwell-Gleichung','\\partial''_\\mu F''^{\\mu\\nu}=\\mu_0J''^\\nu','\\partial''_\\mu F''^{\\mu\\nu}=\\mu_0J''^\\nu','Gleichung aus Abschnitt 3.2.43.10: Lorentz-transformierte inhomogene Maxwell-Gleichung.','theorem'),
('3.3302','Lorentz-transformierte homogene Maxwell-Gleichung','\\partial''_\\mu\\widetilde{F}''^{\\mu\\nu}=0','\\partial''_\\mu\\widetilde{F}''^{\\mu\\nu}=0','Gleichung aus Abschnitt 3.2.43.10: Lorentz-transformierte homogene Maxwell-Gleichung.','theorem');

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
    'literature',
    @src122,
    'Im Unterabschnitt 3.2.43.10 eingeführt oder aus der Komponentenzerlegung der kovarianten Maxwell-Gleichungen, der Antisymmetrie des Feldtensors und der Potentialdarstellung hergeleitet.',
    'Minkowski-Raumzeit, SI-Einheiten, hinreichend differenzierbare Felder und konsistente Index- sowie Vorzeichenkonventionen.',
    'verified',
    @revision
FROM tmp_eqs_324310 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_324310 t
  ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src122,
    e.derivation='Im Unterabschnitt 3.2.43.10 eingeführt oder aus der Komponentenzerlegung der kovarianten Maxwell-Gleichungen, der Antisymmetrie des Feldtensors und der Potentialdarstellung hergeleitet.',
    e.assumptions='Minkowski-Raumzeit, SI-Einheiten, hinreichend differenzierbare Felder und konsistente Index- sowie Vorzeichenkonventionen.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Literaturverwendung
-- ---------------------------------------------------------------------------

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
    @src122,
    @section,
    'first_citation',
    'Viererstromdichte, kovariante Maxwell-Gleichungen, dualer Feldtensor, Kontinuitätsgleichung und Lorentz-Kovarianz.',
    'Abschnitt 3.2.43.10',
    1,
    0,
    'Bibliografische Identität der Arbeitsquelle [122] vor der Endredaktion festlegen.',
    @revision
WHERE @src122 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@src122
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.10'
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
    previous_value,
    new_value
)
SELECT
    @revision,
    @section,
    'updated',
    'subsection',
    '3.2.43.10',
    'Unterabschnitt 3.2.43.10 vollständig in das Repository aufgenommen.',
    'Stand bis Definition 3.2.687, Satz 3.2.163 und Gleichung (3.3270).',
    '6 Definitionen, 7 Sätze und 32 Gleichungen bis (3.3302).'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.10'
);

-- ---------------------------------------------------------------------------
-- Fortführungszähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
    ('last_completed_section','3.2.43.10'),
    ('current_section','3.2.43.11'),
    ('last_definition_number','3.2.693'),
    ('next_definition_number','3.2.694'),
    ('last_theorem_number','3.2.170'),
    ('next_theorem_number','3.2.171'),
    ('last_equation_number','3.3302'),
    ('next_equation_number','3.3303'),
    ('last_citation_number','122'),
    ('next_citation_number','123')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_324310;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_324310;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_324310;

COMMIT;

-- ###########################################################################
-- Abschlussprüfungen
-- Erwartete Werte:
--   Definitionen: 6
--   Sätze:        7
--   Gleichungen: 32
--   Word-LaTeX:   0 fehlende Einträge
-- ###########################################################################

SELECT COUNT(*) AS definitionen_3_2_43_10
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 688 AND 693;

SELECT COUNT(*) AS saetze_3_2_43_10
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 164 AND 170;

SELECT COUNT(*) AS gleichungen_3_2_43_10
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3271 AND 3302;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_10
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3271 AND 3302
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT
    citation_number,
    source_key,
    title,
    verification_status
FROM sources
WHERE citation_number=122
ORDER BY citation_number;

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
