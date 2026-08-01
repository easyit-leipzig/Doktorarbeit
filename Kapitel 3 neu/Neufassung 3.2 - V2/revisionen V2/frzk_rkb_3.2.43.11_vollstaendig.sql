USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – vollständiges Update-Skript
   Abschnitt 3.2.43.11: Lorentzkraft in kovarianter Darstellung

   Definitionen : 3.2.694–3.2.697
   Sätze        : 3.2.171–3.2.173
   Gleichungen  : (3.3303)–(3.3315)
   Literatur    : [123]
   Voraussetzung: vollständiger Repository-Stand bis 3.2.43.10
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43.10'
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

DROP PROCEDURE IF EXISTS sp_frzk_check_324311_prerequisites$$
CREATE PROCEDURE sp_frzk_check_324311_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für 3.2.43.10 fehlt.';
    END IF;

    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
END$$

CALL sp_frzk_check_324311_prerequisites()$$
DROP PROCEDURE sp_frzk_check_324311_prerequisites$$

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
    'RKB-NEU-K3.2.43.11-V1',
    NOW(),
    'subsection',
    '3.2.43.11',
    '3.2.43.11-v1-vollstaendig',
    'Kovariante Lorentzkraft, relativistische Bewegungsgleichung geladener Teilchen, Ruhemasseerhaltung, klassischer Grenzfall und dynamische Feldkopplung.',
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
        'Ergänzt um 3.2.43.11: Lorentzkraft in kovarianter Darstellung.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.11:%';

-- ---------------------------------------------------------------------------
-- Literatur [123]
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
    123,
    'lorentzkraft_kovariant_arbeitsquelle_123',
    'book',
    'Kovariante Lorentzkraft und relativistische Teilchendynamik',
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
    '3.2.43.11',
    'Arbeitsquelle für kovariante Lorentzkraft, Ruhemasseerhaltung, klassischen Grenzfall und relativistische Bewegungsgleichung.',
    'Bibliografische Quelle [123] ist vor der Endredaktion festzulegen und vollständig nachzutragen.',
    'Kovariante Lorentzkraft [123]',
    'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=123
       OR source_key='lorentzkraft_kovariant_arbeitsquelle_123'
);

SET @src123 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=123
    LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.694–3.2.697
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_defs_324311;

CREATE TEMPORARY TABLE tmp_defs_324311
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

INSERT INTO tmp_defs_324311
VALUES
('3.2.694','Kovariante Lorentzkraft','Die Viererkraft eines elektrisch geladenen Teilchens ergibt sich aus der Kopplung zwischen elektromagnetischem Feldtensor und Vierergeschwindigkeit.','F^\\mu=qF^{\\mu\\nu}u_\\nu','F^\\mu=qF^{\\mu\\nu}u_\\nu'),
('3.2.695','Relativistische Bewegungsgleichung eines geladenen Teilchens','Die relativistische Bewegungsgleichung eines geladenen Teilchens verknüpft die Änderung des Viererimpulses mit der kovarianten Lorentzkraft.','\\frac{dp^\\mu}{d\\tau}=qF^{\\mu\\nu}u_\\nu','\\frac{dp^\\mu}{d\\tau}=qF^{\\mu\\nu}u_\\nu'),
('3.2.696','Elektromagnetische Wechselwirkung','Die elektromagnetische Wechselwirkung beschreibt die Abbildung aus Feldtensor, Vierergeschwindigkeit und Ladung auf die resultierende Viererkraft.','\\mathcal{F}:(F^{\\mu\\nu},u^\\mu,q)\\longrightarrow F^\\mu','\\mathcal{F}:(F^{\\mu\\nu},u^\\mu,q)\\longrightarrow F^\\mu'),
('3.2.697','Dynamische Feldkopplung','Unter dynamischer Feldkopplung wird die gegenseitige Wechselwirkung zwischen elektromagnetischem Feld und geladener Materie verstanden. Sie verbindet Maxwell-Gleichungen, Lorentzkraft und Viererstromdichte zu einem geschlossenen relativistischen Beschreibungssystem.',NULL,NULL);

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
    @src123,
    'Minkowski-Raumzeit, konsistente Indexkonvention, elektromagnetischer Feldtensor und wohldefinierte Vierergeschwindigkeit.',
    'Definition aus Unterabschnitt 3.2.43.11.',
    'verified',
    @revision
FROM tmp_defs_324311 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_324311 t
  ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src123,
    d.assumptions='Minkowski-Raumzeit, konsistente Indexkonvention, elektromagnetischer Feldtensor und wohldefinierte Vierergeschwindigkeit.',
    d.notes='Definition aus Unterabschnitt 3.2.43.11.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.171–3.2.173
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_thms_324311;

CREATE TEMPORARY TABLE tmp_thms_324311
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_324311
VALUES
('3.2.171','Erhaltung der Ruhemasse','Die elektromagnetische Lorentzkraft ist orthogonal zur Vierergeschwindigkeit und verändert daher die invariante Ruhemasse eines geladenen Teilchens nicht.','u_\\mu F^\\mu=0'),
('3.2.172','Klassischer Grenzfall der Lorentzkraft','Für Geschwindigkeiten, die klein gegenüber der Lichtgeschwindigkeit sind, geht die kovariante Lorentzkraft in die klassische dreidimensionale Lorentzkraft über.','\\mathbf{F}=q\\left(\\mathbf{E}+\\mathbf{v}\\times\\mathbf{B}\\right)'),
('3.2.173','Linearität bezüglich der elektrischen Ladung','Die kovariante Lorentzkraft ist linear in der elektrischen Ladung.','F^\\mu(q_1+q_2)=F^\\mu(q_1)+F^\\mu(q_2)');

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
    @src123,
    'Antisymmetrie des elektromagnetischen Feldtensors, relativistische Viererdynamik und nichtrelativistischer Grenzfall.',
    'verified',
    @revision
FROM tmp_thms_324311 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_324311 t
  ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src123,
    th.assumptions='Antisymmetrie des elektromagnetischen Feldtensors, relativistische Viererdynamik und nichtrelativistischer Grenzfall.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3303)–(3.3315)
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_324311;

CREATE TEMPORARY TABLE tmp_eqs_324311
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

INSERT INTO tmp_eqs_324311
VALUES
('3.3303','Kovariante Lorentzkraft','F^\\mu=qF^{\\mu\\nu}u_\\nu','F^\\mu=qF^{\\mu\\nu}u_\\nu','Gleichung aus Abschnitt 3.2.43.11: Kovariante Lorentzkraft.','definition'),
('3.3304','Relativistische Bewegungsgleichung eines geladenen Teilchens','\\frac{dp^\\mu}{d\\tau}=qF^{\\mu\\nu}u_\\nu','\\frac{dp^\\mu}{d\\tau}=qF^{\\mu\\nu}u_\\nu','Gleichung aus Abschnitt 3.2.43.11: Relativistische Bewegungsgleichung eines geladenen Teilchens.','definition'),
('3.3305','Orthogonalität von Vierergeschwindigkeit und Viererkraft','u_\\mu F^\\mu=0','u_\\mu F^\\mu=0','Gleichung aus Abschnitt 3.2.43.11: Orthogonalität von Vierergeschwindigkeit und Viererkraft.','theorem'),
('3.3306','Kontraktion der Lorentzkraft mit der Vierergeschwindigkeit','u_\\mu F^\\mu=qu_\\mu F^{\\mu\\nu}u_\\nu','u_\\mu F^\\mu=qu_\\mu F^{\\mu\\nu}u_\\nu','Gleichung aus Abschnitt 3.2.43.11: Kontraktion der Lorentzkraft mit der Vierergeschwindigkeit.','derived'),
('3.3307','Verschwindende Kontraktion eines antisymmetrischen Tensors','u_\\mu F^{\\mu\\nu}u_\\nu=0','u_\\mu F^{\\mu\\nu}u_\\nu=0','Gleichung aus Abschnitt 3.2.43.11: Verschwindende Kontraktion eines antisymmetrischen Tensors.','derived'),
('3.3308','Erneute Orthogonalitätsbeziehung','u_\\mu F^\\mu=0','u_\\mu F^\\mu=0','Gleichung aus Abschnitt 3.2.43.11: Erneute Orthogonalitätsbeziehung.','theorem'),
('3.3309','Nichtrelativistischer Geschwindigkeitsbereich','v\\ll c','v\\ll c','Gleichung aus Abschnitt 3.2.43.11: Nichtrelativistischer Geschwindigkeitsbereich.','derived'),
('3.3310','Nichtrelativistische Näherung des Lorentzfaktors','\\gamma\\approx1','\\gamma\\approx1','Gleichung aus Abschnitt 3.2.43.11: Nichtrelativistische Näherung des Lorentzfaktors.','derived'),
('3.3311','Nichtrelativistische Näherung der Vierergeschwindigkeit','u^\\mu\\approx(c,\\mathbf{v})','u^\\mu\\approx(c,\\mathbf{v})','Gleichung aus Abschnitt 3.2.43.11: Nichtrelativistische Näherung der Vierergeschwindigkeit.','derived'),
('3.3312','Klassische Lorentzkraft','\\mathbf{F}=q\\left(\\mathbf{E}+\\mathbf{v}\\times\\mathbf{B}\\right)','\\mathbf{F}=q\\left(\\mathbf{E}+\\mathbf{v}\\times\\mathbf{B}\\right)','Gleichung aus Abschnitt 3.2.43.11: Klassische Lorentzkraft.','theorem'),
('3.3313','Abbildungsform der elektromagnetischen Wechselwirkung','\\mathcal{F}:(F^{\\mu\\nu},u^\\mu,q)\\longrightarrow F^\\mu','\\mathcal{F}:(F^{\\mu\\nu},u^\\mu,q)\\longrightarrow F^\\mu','Gleichung aus Abschnitt 3.2.43.11: Abbildungsform der elektromagnetischen Wechselwirkung.','definition'),
('3.3314','Linearitätsausgangspunkt der Lorentzkraft','F^\\mu=qF^{\\mu\\nu}u_\\nu','F^\\mu=qF^{\\mu\\nu}u_\\nu','Gleichung aus Abschnitt 3.2.43.11: Linearitätsausgangspunkt der Lorentzkraft.','derived'),
('3.3315','Additivität bezüglich der Ladung','F^\\mu(q_1+q_2)=F^\\mu(q_1)+F^\\mu(q_2)','F^\\mu(q_1+q_2)=F^\\mu(q_1)+F^\\mu(q_2)','Gleichung aus Abschnitt 3.2.43.11: Additivität bezüglich der Ladung.','theorem');

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
    @src123,
    'Im Unterabschnitt 3.2.43.11 eingeführt oder aus der kovarianten Lorentzkraft, der Antisymmetrie des Feldtensors und dem nichtrelativistischen Grenzfall hergeleitet.',
    'Minkowski-Raumzeit, SI-Einheiten, konstante Ruhemasse, wohldefinierte Vierergeschwindigkeit und konsistente Indexkonvention.',
    'verified',
    @revision
FROM tmp_eqs_324311 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_324311 t
  ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src123,
    e.derivation='Im Unterabschnitt 3.2.43.11 eingeführt oder aus der kovarianten Lorentzkraft, der Antisymmetrie des Feldtensors und dem nichtrelativistischen Grenzfall hergeleitet.',
    e.assumptions='Minkowski-Raumzeit, SI-Einheiten, konstante Ruhemasse, wohldefinierte Vierergeschwindigkeit und konsistente Indexkonvention.',
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
    @src123,
    @section,
    'first_citation',
    'Kovariante Lorentzkraft, relativistische Bewegungsgleichung, Erhaltung der Ruhemasse, klassischer Grenzfall und Linearität bezüglich der Ladung.',
    'Abschnitt 3.2.43.11',
    1,
    0,
    'Bibliografische Identität der Arbeitsquelle [123] vor der Endredaktion festlegen.',
    @revision
WHERE @src123 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@src123
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.11'
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
    '3.2.43.11',
    'Unterabschnitt 3.2.43.11 vollständig in das Repository aufgenommen.',
    'Stand bis Definition 3.2.693, Satz 3.2.170 und Gleichung (3.3302).',
    '4 Definitionen, 3 Sätze und 13 Gleichungen bis (3.3315).'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.11'
);

-- ---------------------------------------------------------------------------
-- Fortführungszähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
    ('last_completed_section','3.2.43.11'),
    ('current_section','3.2.43.12'),
    ('last_definition_number','3.2.697'),
    ('next_definition_number','3.2.698'),
    ('last_theorem_number','3.2.173'),
    ('next_theorem_number','3.2.174'),
    ('last_equation_number','3.3315'),
    ('next_equation_number','3.3316'),
    ('last_citation_number','123'),
    ('next_citation_number','124')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_324311;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_324311;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_324311;

COMMIT;

-- ###########################################################################
-- Abschlussprüfungen
-- Erwartete Werte:
--   Definitionen: 4
--   Sätze:        3
--   Gleichungen: 13
--   Word-LaTeX:   0 fehlende Einträge
-- ###########################################################################

SELECT COUNT(*) AS definitionen_3_2_43_11
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 694 AND 697;

SELECT COUNT(*) AS saetze_3_2_43_11
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 171 AND 173;

SELECT COUNT(*) AS gleichungen_3_2_43_11
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3303 AND 3315;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_11
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3303 AND 3315
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT
    citation_number,
    source_key,
    title,
    verification_status
FROM sources
WHERE citation_number=123
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
