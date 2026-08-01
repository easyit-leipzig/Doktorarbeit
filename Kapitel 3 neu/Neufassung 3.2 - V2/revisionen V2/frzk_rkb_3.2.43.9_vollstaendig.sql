USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – vollständiges Update-Skript
   Abschnitt 3.2.43.9: Elektromagnetisches Feld als Tensorformulierung

   Definitionen : 3.2.683–3.2.687
   Sätze        : 3.2.161–3.2.163
   Gleichungen  : (3.3258)–(3.3270)
   Literatur    : [121]
   Voraussetzung: vollständiger Repository-Stand bis 3.2.43.8
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43.8'
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

DROP PROCEDURE IF EXISTS sp_frzk_check_32439_prerequisites$$
CREATE PROCEDURE sp_frzk_check_32439_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für 3.2.43.8 fehlt.';
    END IF;

    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
END$$

CALL sp_frzk_check_32439_prerequisites()$$
DROP PROCEDURE sp_frzk_check_32439_prerequisites$$

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
    'RKB-NEU-K3.2.43.9-V1',
    NOW(),
    'subsection',
    '3.2.43.9',
    '3.2.43.9-v1-vollstaendig',
    'Viererpotential, Vierergradient, elektromagnetischer Feldtensor, Antisymmetrie, Lorentz-Kovarianz und Feldinvariante.',
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
        'Ergänzt um 3.2.43.9: Elektromagnetisches Feld als Tensorformulierung.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.9:%';

-- ---------------------------------------------------------------------------
-- Literatur [121]
-- Provisorischer Eintrag; vollständige Bibliografie vor Endredaktion ergänzen.
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
    121,
    'elektromagnetischer_feldtensor_arbeitsquelle_121',
    'book',
    'Elektromagnetisches Feld und kovariante Tensorformulierung',
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
    '3.2.43.9',
    'Arbeitsquelle für Viererpotential, Feldtensor, Antisymmetrie, Lorentz-Kovarianz und elektromagnetische Feldinvarianten.',
    'Bibliografische Quelle [121] ist vor der Endredaktion festzulegen und vollständig nachzutragen.',
    'Elektromagnetischer Feldtensor [121]',
    'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=121
       OR source_key='elektromagnetischer_feldtensor_arbeitsquelle_121'
);

SET @src121 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=121
    LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.683–3.2.687
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32439;

CREATE TEMPORARY TABLE tmp_defs_32439
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

INSERT INTO tmp_defs_32439
VALUES
('3.2.683','Viererpotential','Das Viererpotential fasst das elektrische Skalarpotential und das magnetische Vektorpotential zu einem gemeinsamen Vierervektor zusammen.','A^\\mu=\\begin{pmatrix}\\frac{\\phi}{c}\\\\A_x\\\\A_y\\\\A_z\\ \\end{pmatrix}','A^\\mu=\\begin{pmatrix}\\frac{\\phi}{c}\\\\A_x\\\\A_y\\\\A_z\\ \\end{pmatrix}'),
('3.2.684','Vierergradient','Der Vierergradient ist der kovariante Differentialoperator der Minkowski-Raumzeit.','\\partial_\\mu=\\left(\\frac{1}{c}\\frac{\\partial}{\\partial t},\\frac{\\partial}{\\partial x},\\frac{\\partial}{\\partial y},\\frac{\\partial}{\\partial z}\\right)','\\partial_\\mu=\\left(\\frac{1}{c}\\frac{\\partial}{\\partial t},\\frac{\\partial}{\\partial x},\\frac{\\partial}{\\partial y},\\frac{\\partial}{\\partial z}\\right)'),
('3.2.685','Elektromagnetischer Feldtensor','Der elektromagnetische Feldtensor ist die antisymmetrische Ableitung des Viererpotentials.','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu'),
('3.2.686','Matrixdarstellung des Feldtensors','Der elektromagnetische Feldtensor fasst die drei elektrischen und drei magnetischen Feldkomponenten in einer antisymmetrischen Vier-mal-vier-Matrix zusammen.','F_{\\mu\\nu}=\\begin{pmatrix}0&-E_x/c&-E_y/c&-E_z/c\\\\E_x/c&0&-B_z&B_y\\\\E_y/c&B_z&0&-B_x\\\\E_z/c&-B_y&B_x&0\\ \\end{pmatrix}','F_{\\mu\\nu}=\\begin{pmatrix}0&-E_x/c&-E_y/c&-E_z/c\\\\E_x/c&0&-B_z&B_y\\\\E_y/c&B_z&0&-B_x\\\\E_z/c&-B_y&B_x&0\\ \\end{pmatrix}'),
('3.2.687','Lorentz-Invariante des elektromagnetischen Feldes','Die Kontraktion des elektromagnetischen Feldtensors mit seiner kontravarianten Form liefert eine Lorentz-Invariante.','F_{\\mu\\nu}F^{\\mu\\nu}=2\\left(B^2-\\frac{E^2}{c^2}\\right)','F_{\\mu\\nu}F^{\\mu\\nu}=2\\left(B^2-\\frac{E^2}{c^2}\\right)');

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
    @src121,
    'Minkowski-Raumzeit, konsistente Indexkonvention, SI-Einheiten und gewählte Metriksignatur.',
    'Definition aus Unterabschnitt 3.2.43.9.',
    'verified',
    @revision
FROM tmp_defs_32439 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_32439 t
  ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src121,
    d.assumptions='Minkowski-Raumzeit, konsistente Indexkonvention, SI-Einheiten und gewählte Metriksignatur.',
    d.notes='Definition aus Unterabschnitt 3.2.43.9.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.161–3.2.163
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_thms_32439;

CREATE TEMPORARY TABLE tmp_thms_32439
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_32439
VALUES
('3.2.161','Anzahl unabhängiger Feldkomponenten','Ein antisymmetrischer Tensor zweiter Stufe im vierdimensionalen Raum besitzt sechs unabhängige Komponenten.','\\frac{4\\cdot3}{2}=6'),
('3.2.162','Lorentz-Kovarianz des Feldtensors','Der elektromagnetische Feldtensor transformiert unter Lorentz-Transformationen tensoriell.','F''=\\Lambda F\\Lambda^T'),
('3.2.163','Einheitliche Beschreibung elektrischer und magnetischer Felder','Elektrische und magnetische Felder sind Komponenten eines gemeinsamen elektromagnetischen Feldtensors und bilden daher ein einheitliches geometrisches Objekt.','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu');

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
    @src121,
    'Vierdimensionale Minkowski-Raumzeit und Lorentz-Transformationen.',
    'verified',
    @revision
FROM tmp_thms_32439 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_32439 t
  ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src121,
    th.assumptions='Vierdimensionale Minkowski-Raumzeit und Lorentz-Transformationen.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3258)–(3.3270)
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32439;

CREATE TEMPORARY TABLE tmp_eqs_32439
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

INSERT INTO tmp_eqs_32439
VALUES
('3.3258','Viererpotential','A^\\mu=\\begin{pmatrix}\\frac{\\phi}{c}\\\\A_x\\\\A_y\\\\A_z\\ \\end{pmatrix}','A^\\mu=\\begin{pmatrix}\\frac{\\phi}{c}\\\\A_x\\\\A_y\\\\A_z\\ \\end{pmatrix}','Gleichung aus Abschnitt 3.2.43.9: Viererpotential.','definition'),
('3.3259','Vierergradient','\\partial_\\mu=\\left(\\frac{1}{c}\\frac{\\partial}{\\partial t},\\frac{\\partial}{\\partial x},\\frac{\\partial}{\\partial y},\\frac{\\partial}{\\partial z}\\right)','\\partial_\\mu=\\left(\\frac{1}{c}\\frac{\\partial}{\\partial t},\\frac{\\partial}{\\partial x},\\frac{\\partial}{\\partial y},\\frac{\\partial}{\\partial z}\\right)','Gleichung aus Abschnitt 3.2.43.9: Vierergradient.','definition'),
('3.3260','Definition des elektromagnetischen Feldtensors','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','Gleichung aus Abschnitt 3.2.43.9: Definition des elektromagnetischen Feldtensors.','definition'),
('3.3261','Antisymmetrie des Feldtensors','F_{\\mu\\nu}=-F_{\\nu\\mu}','F_{\\mu\\nu}=-F_{\\nu\\mu}','Gleichung aus Abschnitt 3.2.43.9: Antisymmetrie des Feldtensors.','derived'),
('3.3262','Komponentenzahl eines allgemeinen Vier-mal-vier-Tensors','4^2=16','4^2=16','Gleichung aus Abschnitt 3.2.43.9: Komponentenzahl eines allgemeinen Vier-mal-vier-Tensors.','derived'),
('3.3263','Verschwinden der Diagonalkomponenten','F_{\\mu\\mu}=0','F_{\\mu\\mu}=0','Gleichung aus Abschnitt 3.2.43.9: Verschwinden der Diagonalkomponenten.','derived'),
('3.3264','Paarweise Antisymmetrie','F_{\\mu\\nu}=-F_{\\nu\\mu}','F_{\\mu\\nu}=-F_{\\nu\\mu}','Gleichung aus Abschnitt 3.2.43.9: Paarweise Antisymmetrie.','derived'),
('3.3265','Anzahl unabhängiger Komponenten','\\frac{4\\cdot3}{2}=6','\\frac{4\\cdot3}{2}=6','Gleichung aus Abschnitt 3.2.43.9: Anzahl unabhängiger Komponenten.','theorem'),
('3.3266','Matrixdarstellung des elektromagnetischen Feldtensors','F_{\\mu\\nu}=\\begin{pmatrix}0&-E_x/c&-E_y/c&-E_z/c\\\\E_x/c&0&-B_z&B_y\\\\E_y/c&B_z&0&-B_x\\\\E_z/c&-B_y&B_x&0\\ \\end{pmatrix}','F_{\\mu\\nu}=\\begin{pmatrix}0&-E_x/c&-E_y/c&-E_z/c\\\\E_x/c&0&-B_z&B_y\\\\E_y/c&B_z&0&-B_x\\\\E_z/c&-B_y&B_x&0\\ \\end{pmatrix}','Gleichung aus Abschnitt 3.2.43.9: Matrixdarstellung des elektromagnetischen Feldtensors.','definition'),
('3.3267','Tensorielle Lorentz-Transformation','F''=\\Lambda F\\Lambda^T','F''=\\Lambda F\\Lambda^T','Gleichung aus Abschnitt 3.2.43.9: Tensorielle Lorentz-Transformation.','theorem'),
('3.3268','Feldtensor als antisymmetrische Potentialableitung','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','F_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu','Gleichung aus Abschnitt 3.2.43.9: Feldtensor als antisymmetrische Potentialableitung.','derived'),
('3.3269','Kovarianz des Feldtensors','F''=\\Lambda F\\Lambda^T','F''=\\Lambda F\\Lambda^T','Gleichung aus Abschnitt 3.2.43.9: Kovarianz des Feldtensors.','theorem'),
('3.3270','Lorentz-Invariante des elektromagnetischen Feldes','F_{\\mu\\nu}F^{\\mu\\nu}=2\\left(B^2-\\frac{E^2}{c^2}\\right)','F_{\\mu\\nu}F^{\\mu\\nu}=2\\left(B^2-\\frac{E^2}{c^2}\\right)','Gleichung aus Abschnitt 3.2.43.9: Lorentz-Invariante des elektromagnetischen Feldes.','definition');

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
    @src121,
    'Im Unterabschnitt 3.2.43.9 eingeführt oder aus der Antisymmetrie des Feldtensors und der Lorentz-Transformation hergeleitet.',
    'Minkowski-Raumzeit, SI-Einheiten und konsistente kovariante beziehungsweise kontravariante Indexführung.',
    'verified',
    @revision
FROM tmp_eqs_32439 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_32439 t
  ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src121,
    e.derivation='Im Unterabschnitt 3.2.43.9 eingeführt oder aus der Antisymmetrie des Feldtensors und der Lorentz-Transformation hergeleitet.',
    e.assumptions='Minkowski-Raumzeit, SI-Einheiten und konsistente kovariante beziehungsweise kontravariante Indexführung.',
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
    @src121,
    @section,
    'first_citation',
    'Viererpotential, Vierergradient, Feldtensor, Antisymmetrie, Lorentz-Kovarianz und Feldinvariante.',
    'Abschnitt 3.2.43.9',
    1,
    0,
    'Bibliografische Identität der Arbeitsquelle [121] vor der Endredaktion festlegen.',
    @revision
WHERE @src121 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@src121
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.9'
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
    '3.2.43.9',
    'Unterabschnitt 3.2.43.9 vollständig in das Repository aufgenommen.',
    'Stand bis Definition 3.2.682, Satz 3.2.160 und Gleichung (3.3257).',
    '5 Definitionen, 3 Sätze und 13 Gleichungen bis (3.3270).'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.9'
);

-- ---------------------------------------------------------------------------
-- Fortführungszähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
    ('last_completed_section','3.2.43.9'),
    ('current_section','3.2.43.10'),
    ('last_definition_number','3.2.687'),
    ('next_definition_number','3.2.688'),
    ('last_theorem_number','3.2.163'),
    ('next_theorem_number','3.2.164'),
    ('last_equation_number','3.3270'),
    ('next_equation_number','3.3271'),
    ('last_citation_number','121'),
    ('next_citation_number','122')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32439;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32439;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32439;

COMMIT;

-- ###########################################################################
-- Abschlussprüfungen
-- Erwartete Werte:
--   Definitionen: 5
--   Sätze:        3
--   Gleichungen: 13
--   Word-LaTeX:   0 fehlende Einträge
-- ###########################################################################

SELECT COUNT(*) AS definitionen_3_2_43_9
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 683 AND 687;

SELECT COUNT(*) AS saetze_3_2_43_9
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 161 AND 163;

SELECT COUNT(*) AS gleichungen_3_2_43_9
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3258 AND 3270;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_9
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3258 AND 3270
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT
    citation_number,
    source_key,
    title,
    verification_status
FROM sources
WHERE citation_number=121
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
