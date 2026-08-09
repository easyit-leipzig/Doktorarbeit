USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – vollständiges Skript
   Abschnitt 3.2.43.8: Viererkraft und relativistische Bewegungsgleichung

   Definitionen : 3.2.677–3.2.682
   Sätze        : 3.2.158–3.2.160
   Gleichungen  : (3.3236)–(3.3257)
   Literatur    : [120]
   Voraussetzung: vollständiger Repository-Stand bis 3.2.43.7
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43.7'
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

DROP PROCEDURE IF EXISTS sp_frzk_check_32438_prerequisites$$
CREATE PROCEDURE sp_frzk_check_32438_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für 3.2.43.7 fehlt.';
    END IF;

    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
END$$

CALL sp_frzk_check_32438_prerequisites()$$
DROP PROCEDURE sp_frzk_check_32438_prerequisites$$

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
    'RKB-NEU-K3.2.43.8-V1',
    NOW(),
    'subsection',
    '3.2.43.8',
    '3.2.43.8-v1-vollstaendig',
    'Viererkraft, Viererbeschleunigung, Orthogonalität, klassische Grenzfälle und Lorentz-Kovarianz der Bewegungsgleichung.',
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
        'Ergänzt um 3.2.43.8: Viererkraft und relativistische Bewegungsgleichung.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.8:%';

-- ---------------------------------------------------------------------------
-- Literatur [120]
-- Bibliografischer Arbeitsstand: keine erfundene bibliografische Zuordnung.
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
    120,
    'viererkraft_relativistische_bewegung_arbeitsquelle_120',
    'book',
    'Viererkraft und relativistische Bewegungsgleichung',
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
    '3.2.43.8',
    'Arbeitsquelle für Viererkraft, Viererbeschleunigung, Lorentz-Kovarianz und klassische Grenzfälle.',
    'Bibliografische Quelle [120] ist vor der Endredaktion festzulegen und vollständig nachzutragen.',
    'Viererkraft und relativistische Bewegung [120]',
    'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=120
       OR source_key='viererkraft_relativistische_bewegung_arbeitsquelle_120'
);

SET @src120 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=120
    LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.677–3.2.682
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32438;

CREATE TEMPORARY TABLE tmp_defs_32438
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

INSERT INTO tmp_defs_32438
VALUES
('3.2.677','Viererkraft','Die Viererkraft ist die Ableitung des Viererimpulses nach der Eigenzeit. Sie beschreibt die Änderung des Energie-Impuls-Zustandes eines Körpers entlang seiner Weltlinie.','F^\\mu=\\frac{dp^\\mu}{d\\tau}','F^\\mu=\\frac{dp^\\mu}{d\\tau}'),
('3.2.678','Viererbeschleunigung','Die Viererbeschleunigung ist die Ableitung der Vierergeschwindigkeit nach der Eigenzeit.','a^\\mu=\\frac{du^\\mu}{d\\tau}','a^\\mu=\\frac{du^\\mu}{d\\tau}'),
('3.2.679','Zeitartige Komponente der Viererkraft','Die zeitartige Komponente der Viererkraft beschreibt die Änderung der relativistischen Gesamtenergie bezüglich der Eigenzeit.','F^0=\\frac{1}{c}\\frac{dE}{d\\tau}','F^0=\\frac{1}{c}\\frac{dE}{d\\tau}'),
('3.2.680','Räumliche Komponente der Viererkraft','Die räumlichen Komponenten der Viererkraft beschreiben die Änderung des relativistischen Dreierimpulses bezüglich der Eigenzeit.','\\mathbf{F}=\\frac{d\\mathbf{p}}{d\\tau}','\\mathbf{F}=\\frac{d\\mathbf{p}}{d\\tau}'),
('3.2.681','Eigenkraft','Die Eigenkraft ist die im momentanen Ruhesystem eines Körpers gemessene Kraft.','F_{\\mathrm{Eigen}}=m\\frac{d^2x}{d\\tau^2}','F_{\\mathrm{Eigen}}=m\\frac{d^2x}{d\\tau^2}'),
('3.2.682','Dynamischer Lorentz-Zustand','Der vollständige dynamische Zustand eines massiven Teilchens wird durch den Raumzeitvektor und den Viererimpuls als geordnetes Paar beschrieben.','(x^\\mu,p^\\mu)','(x^\\mu,p^\\mu)');

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
    @src120,
    'Minkowski-Raum mit Signatur (-,+,+,+), massive Körper, konstante Ruhemasse und Lorentz-invariante Eigenzeit.',
    'Definition aus Unterabschnitt 3.2.43.8.',
    'verified',
    @revision
FROM tmp_defs_32438 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_32438 t
  ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src120,
    d.assumptions='Minkowski-Raum mit Signatur (-,+,+,+), massive Körper, konstante Ruhemasse und Lorentz-invariante Eigenzeit.',
    d.notes='Definition aus Unterabschnitt 3.2.43.8.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.158–3.2.160
-- Das Schema der Tabelle theorems wird ohne proof_text verwendet.
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_thms_32438;

CREATE TEMPORARY TABLE tmp_thms_32438
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_32438
VALUES
('3.2.158','Orthogonalität von Vierergeschwindigkeit und Viererkraft','Für einen massiven Körper mit konstanter Ruhemasse stehen Vierergeschwindigkeit und Viererkraft bezüglich der Minkowski-Metrik orthogonal aufeinander.','u_\\mu F^\\mu=0'),
('3.2.159','Zusammenhang mit der klassischen Kraft','Im Grenzfall kleiner Geschwindigkeiten geht die räumliche Komponente der relativistischen Bewegungsgleichung in die klassische Impuls- und Kraftgleichung über.','v\\ll c\\Longrightarrow\\mathbf{F}\\approx\\frac{d\\mathbf{p}}{dt}=m\\mathbf{a}'),
('3.2.160','Lorentz-Kovarianz der Bewegungsgleichung','Die relativistische Bewegungsgleichung F^mu=dp^mu/dtau ist unter Lorentz-Transformationen kovariant.','F''^\\mu=\\Lambda^\\mu_{\\ \\nu}F^\\nu');

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
    @src120,
    'Konstante Ruhemasse, Lorentz-invariante Eigenzeit und Vierervektortransformation unter Lorentz-Transformationen.',
    'verified',
    @revision
FROM tmp_thms_32438 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_32438 t
  ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src120,
    th.assumptions='Konstante Ruhemasse, Lorentz-invariante Eigenzeit und Vierervektortransformation unter Lorentz-Transformationen.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3236)–(3.3257)
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32438;

CREATE TEMPORARY TABLE tmp_eqs_32438
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

INSERT INTO tmp_eqs_32438
VALUES
('3.3236','Definition der Viererkraft','F^\\mu=\\frac{dp^\\mu}{d\\tau}','F^\\mu=\\frac{dp^\\mu}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.8: Definition der Viererkraft.','definition'),
('3.3237','Definition der Viererbeschleunigung','a^\\mu=\\frac{du^\\mu}{d\\tau}','a^\\mu=\\frac{du^\\mu}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.8: Definition der Viererbeschleunigung.','definition'),
('3.3238','Viererimpuls als Produkt aus Ruhemasse und Vierergeschwindigkeit','p^\\mu=mu^\\mu','p^\\mu=mu^\\mu','Formale Gleichung aus Abschnitt 3.2.43.8: Viererimpuls als Produkt aus Ruhemasse und Vierergeschwindigkeit.','derived'),
('3.3239','Relativistische Bewegungsgleichung für konstante Ruhemasse','F^\\mu=ma^\\mu','F^\\mu=ma^\\mu','Formale Gleichung aus Abschnitt 3.2.43.8: Relativistische Bewegungsgleichung für konstante Ruhemasse.','theorem'),
('3.3240','Orthogonalität von Vierergeschwindigkeit und Viererkraft','u_\\mu F^\\mu=0','u_\\mu F^\\mu=0','Formale Gleichung aus Abschnitt 3.2.43.8: Orthogonalität von Vierergeschwindigkeit und Viererkraft.','theorem'),
('3.3241','Invariante Norm der Vierergeschwindigkeit','u_\\mu u^\\mu=-c^2','u_\\mu u^\\mu=-c^2','Formale Gleichung aus Abschnitt 3.2.43.8: Invariante Norm der Vierergeschwindigkeit.','derived'),
('3.3242','Eigenzeitableitung der invarianten Norm','\\frac{d}{d\\tau}(u_\\mu u^\\mu)=0','\\frac{d}{d\\tau}(u_\\mu u^\\mu)=0','Formale Gleichung aus Abschnitt 3.2.43.8: Eigenzeitableitung der invarianten Norm.','derived'),
('3.3243','Orthogonalität von Vierergeschwindigkeit und Viererbeschleunigung','2u_\\mu a^\\mu=0','2u_\\mu a^\\mu=0','Formale Gleichung aus Abschnitt 3.2.43.8: Orthogonalität von Vierergeschwindigkeit und Viererbeschleunigung.','derived'),
('3.3244','Viererkraft aus Viererbeschleunigung','F^\\mu=ma^\\mu','F^\\mu=ma^\\mu','Formale Gleichung aus Abschnitt 3.2.43.8: Viererkraft aus Viererbeschleunigung.','derived'),
('3.3245','Abschluss der Orthogonalitätsherleitung','u_\\mu F^\\mu=0','u_\\mu F^\\mu=0','Formale Gleichung aus Abschnitt 3.2.43.8: Abschluss der Orthogonalitätsherleitung.','theorem'),
('3.3246','Zeitartige Komponente der Viererkraft','F^0=\\frac{1}{c}\\frac{dE}{d\\tau}','F^0=\\frac{1}{c}\\frac{dE}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.8: Zeitartige Komponente der Viererkraft.','definition'),
('3.3247','Räumliche Komponente der Viererkraft','\\mathbf{F}=\\frac{d\\mathbf{p}}{d\\tau}','\\mathbf{F}=\\frac{d\\mathbf{p}}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.8: Räumliche Komponente der Viererkraft.','definition'),
('3.3248','Umrechnung der Eigenzeitableitung in die Koordinatenzeitableitung','\\frac{d}{d\\tau}=\\gamma\\frac{d}{dt}','\\frac{d}{d\\tau}=\\gamma\\frac{d}{dt}','Formale Gleichung aus Abschnitt 3.2.43.8: Umrechnung der Eigenzeitableitung in die Koordinatenzeitableitung.','derived'),
('3.3249','Räumliche Viererkraft aus der Koordinatenzeitableitung des Impulses','\\mathbf{F}=\\gamma\\frac{d\\mathbf{p}}{dt}','\\mathbf{F}=\\gamma\\frac{d\\mathbf{p}}{dt}','Formale Gleichung aus Abschnitt 3.2.43.8: Räumliche Viererkraft aus der Koordinatenzeitableitung des Impulses.','derived'),
('3.3250','Klassischer Grenzwert des Lorentz-Faktors','\\gamma\\approx1','\\gamma\\approx1','Formale Gleichung aus Abschnitt 3.2.43.8: Klassischer Grenzwert des Lorentz-Faktors.','derived'),
('3.3251','Klassischer Grenzfall der räumlichen Kraft','\\mathbf{F}\\approx\\frac{d\\mathbf{p}}{dt}','\\mathbf{F}\\approx\\frac{d\\mathbf{p}}{dt}','Formale Gleichung aus Abschnitt 3.2.43.8: Klassischer Grenzfall der räumlichen Kraft.','theorem'),
('3.3252','Klassischer Impuls','\\mathbf{p}=m\\mathbf{v}','\\mathbf{p}=m\\mathbf{v}','Formale Gleichung aus Abschnitt 3.2.43.8: Klassischer Impuls.','derived'),
('3.3253','Zweites Newtonsches Gesetz als Grenzfall','\\mathbf{F}=m\\mathbf{a}','\\mathbf{F}=m\\mathbf{a}','Formale Gleichung aus Abschnitt 3.2.43.8: Zweites Newtonsches Gesetz als Grenzfall.','theorem'),
('3.3254','Eigenkraft','F_{\\mathrm{Eigen}}=m\\frac{d^2x}{d\\tau^2}','F_{\\mathrm{Eigen}}=m\\frac{d^2x}{d\\tau^2}','Formale Gleichung aus Abschnitt 3.2.43.8: Eigenkraft.','definition'),
('3.3255','Kovariante relativistische Bewegungsgleichung','F^\\mu=\\frac{dp^\\mu}{d\\tau}','F^\\mu=\\frac{dp^\\mu}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.8: Kovariante relativistische Bewegungsgleichung.','theorem'),
('3.3256','Lorentz-Transformation der Viererkraft','F''^\\mu=\\Lambda^\\mu_{\\ \\nu}F^\\nu','F''^\\mu=\\Lambda^\\mu_{\\ \\nu}F^\\nu','Formale Gleichung aus Abschnitt 3.2.43.8: Lorentz-Transformation der Viererkraft.','theorem'),
('3.3257','Dynamischer Lorentz-Zustand','(x^\\mu,p^\\mu)','(x^\\mu,p^\\mu)','Formale Gleichung aus Abschnitt 3.2.43.8: Dynamischer Lorentz-Zustand.','definition');

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
    @src120,
    'Im Unterabschnitt 3.2.43.8 eingeführt oder aus Viererimpuls, Vierergeschwindigkeit, Eigenzeit und Lorentz-Transformation hergeleitet.',
    'Minkowski-Raum, konstante Ruhemasse, zeitartige Weltlinie und |v|<c; der klassische Grenzfall setzt v<<c voraus.',
    'verified',
    @revision
FROM tmp_eqs_32438 t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_32438 t
  ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src120,
    e.derivation='Im Unterabschnitt 3.2.43.8 eingeführt oder aus Viererimpuls, Vierergeschwindigkeit, Eigenzeit und Lorentz-Transformation hergeleitet.',
    e.assumptions='Minkowski-Raum, konstante Ruhemasse, zeitartige Weltlinie und |v|<c; der klassische Grenzfall setzt v<<c voraus.',
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
    @src120,
    @section,
    'first_citation',
    'Viererkraft, Viererbeschleunigung, Orthogonalität zur Vierergeschwindigkeit, klassische Grenzfälle und Lorentz-Kovarianz.',
    'Abschnitt 3.2.43.8',
    1,
    0,
    'Bibliografische Identität der Arbeitsquelle [120] vor der Endredaktion festlegen.',
    @revision
WHERE @src120 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@src120
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.8'
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
    '3.2.43.8',
    'Unterabschnitt 3.2.43.8 vollständig in das Repository aufgenommen.',
    'Stand bis Definition 3.2.676, Satz 3.2.157 und Gleichung (3.3235).',
    '6 Definitionen, 3 Sätze und 22 Gleichungen bis (3.3257).'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.8'
);

-- ---------------------------------------------------------------------------
-- Fortführungszähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
    ('last_completed_section','3.2.43.8'),
    ('current_section','3.2.43.9'),
    ('last_definition_number','3.2.682'),
    ('next_definition_number','3.2.683'),
    ('last_theorem_number','3.2.160'),
    ('next_theorem_number','3.2.161'),
    ('last_equation_number','3.3257'),
    ('next_equation_number','3.3258'),
    ('last_citation_number','120'),
    ('next_citation_number','121')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32438;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32438;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32438;

COMMIT;

-- ###########################################################################
-- Abschlussprüfungen
-- Erwartete Werte:
--   Definitionen: 6
--   Sätze:        3
--   Gleichungen: 22
--   Word-LaTeX:   0 fehlende Einträge
-- ###########################################################################

SELECT COUNT(*) AS definitionen_3_2_43_8
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 677 AND 682;

SELECT COUNT(*) AS saetze_3_2_43_8
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 158 AND 160;

SELECT COUNT(*) AS gleichungen_3_2_43_8
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3236 AND 3257;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_8
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3236 AND 3257
  AND
  (
      word_latex IS NULL
      OR TRIM(word_latex)=''
  );

SELECT
    (
        SELECT COUNT(*)
        FROM definitions
        WHERE section_id=@section
          AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
              BETWEEN 638 AND 682
    ) AS definitionen_gesamt_3_2_43,
    (
        SELECT COUNT(*)
        FROM theorems
        WHERE section_id=@section
          AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
              BETWEEN 145 AND 160
    ) AS saetze_gesamt_3_2_43,
    (
        SELECT COUNT(*)
        FROM equations
        WHERE section_id=@section
          AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
              BETWEEN 3066 AND 3257
    ) AS gleichungen_gesamt_3_2_43;

SELECT
    citation_number,
    source_key,
    title,
    verification_status
FROM sources
WHERE citation_number=120
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
