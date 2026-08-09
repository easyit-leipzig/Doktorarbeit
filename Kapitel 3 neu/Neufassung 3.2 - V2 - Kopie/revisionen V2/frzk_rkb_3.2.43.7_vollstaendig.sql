USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – vollständiges Skript
   Abschnitt 3.2.43.7: Viererimpuls und relativistische Energie

   Definitionen : 3.2.668–3.2.676
   Sätze        : 3.2.154–3.2.157
   Gleichungen  : (3.3176)–(3.3235)
   Literatur    : [118], [119]
   Voraussetzung: konsolidierter Stand bis 3.2.43.6
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id FROM repository_revisions
    WHERE scope_reference='3.2.43.6'
    ORDER BY revision_id DESC LIMIT 1
);
SET @section := (
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.2.43' LIMIT 1
);

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_frzk_check_32437_prerequisites$$
CREATE PROCEDURE sp_frzk_check_32437_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für 3.2.43.6 fehlt.';
    END IF;
    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
END$$

CALL sp_frzk_check_32437_prerequisites()$$
DROP PROCEDURE sp_frzk_check_32437_prerequisites$$

DELIMITER ;

INSERT INTO repository_revisions
(
    revision_code,revision_date,scope_type,scope_reference,
    version_label,summary,created_by,parent_revision_id
)
VALUES
(
    'RKB-NEU-K3.2.43.7-V2',
    NOW(),
    'subsection',
    '3.2.43.7',
    '3.2.43.7-v2-vollstaendig',
    'Vierergeschwindigkeit, Viererimpuls, relativistische Energie, Energie-Impuls-Beziehung und klassische Grenzfälle.',
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
SET status='in_progress',
    notes=CONCAT(
        COALESCE(notes,''),
        CASE WHEN COALESCE(notes,'')='' THEN '' ELSE ' ' END,
        'Ergänzt um 3.2.43.7: Viererimpuls und relativistische Energie.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.7:%';

-- Literatur [118] und [119]: bibliografische Arbeitsstände
INSERT INTO sources
(
 citation_number,source_key,source_type,title,year_original,year_edition,
 publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,
 verification_status,first_citation_section_code,first_citation_note,
 full_citation_text,short_citation_text,notes,created_revision_id
)
SELECT
 118,'relativistische_dynamik_arbeitsquelle_118','book',
 'Spezielle Relativitätstheorie und relativistische Dynamik',
 NULL,NULL,NULL,NULL,NULL,'de',2,'secondary_source',8,
 'pending','3.2.43.7',
 'Arbeitsquelle für Vierergeschwindigkeit, Viererimpuls und relativistische Energie.',
 'Bibliografische Quelle [118] ist vor der Endredaktion festzulegen und vollständig nachzutragen.',
 'Relativistische Dynamik [118]',
 'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
 @revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=118 OR source_key='relativistische_dynamik_arbeitsquelle_118'
);

INSERT INTO sources
(
 citation_number,source_key,source_type,title,year_original,year_edition,
 publisher,place,edition,language_code,priority,evidence_type,frzk_relevance,
 verification_status,first_citation_section_code,first_citation_note,
 full_citation_text,short_citation_text,notes,created_revision_id
)
SELECT
 119,'energie_impuls_beziehung_arbeitsquelle_119','book',
 'Energie-Impuls-Beziehung und klassische Grenzfälle',
 NULL,NULL,NULL,NULL,NULL,'de',2,'secondary_source',8,
 'pending','3.2.43.7',
 'Arbeitsquelle für Energie-Impuls-Beziehung, Ruheenergie und klassischen Grenzfall.',
 'Bibliografische Quelle [119] ist vor der Endredaktion festzulegen und vollständig nachzutragen.',
 'Energie und Impuls [119]',
 'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
 @revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=119 OR source_key='energie_impuls_beziehung_arbeitsquelle_119'
);

SET @src118 := (SELECT source_id FROM sources WHERE citation_number=118 LIMIT 1);
SET @src119 := (SELECT source_id FROM sources WHERE citation_number=119 LIMIT 1);

-- Definitionen
DROP TEMPORARY TABLE IF EXISTS tmp_defs_32437;
CREATE TEMPORARY TABLE tmp_defs_32437
(
 definition_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 definition_text LONGTEXT NOT NULL,
 formal_latex LONGTEXT NULL,
 word_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_32437 VALUES
('3.2.668','Weltlinie eines materiellen Körpers','Die Weltlinie eines materiellen Körpers ist die durch die Eigenzeit parametrisierte Kurve seiner aufeinanderfolgenden Ereignisse in der Raumzeit. Für einen massiven Körper ist sie zeitartig.','x^\\mu=x^\\mu(\\tau)','x^\\mu=x^\\mu(\\tau)'),
('3.2.669','Vierergeschwindigkeit','Die Vierergeschwindigkeit ist die Ableitung des Raumzeitvektors nach der Eigenzeit.','u^\\mu=\\frac{dx^\\mu}{d\\tau}','u^\\mu=\\frac{dx^\\mu}{d\\tau}'),
('3.2.670','Ruhemasse','Die Ruhemasse m eines Körpers ist eine Lorentz-invariante skalare Größe.','m''=m','m''=m'),
('3.2.671','Viererimpuls','Der Viererimpuls eines Körpers ist das Produkt seiner Ruhemasse mit seiner Vierergeschwindigkeit.','p^\\mu=mu^\\mu','p^\\mu=mu^\\mu'),
('3.2.672','Relativistischer Dreierimpuls','Der räumliche Anteil des Viererimpulses wird als relativistischer Dreierimpuls bezeichnet.','\\mathbf{p}=\\gamma m\\mathbf{v}','\\mathbf{p}=\\gamma m\\mathbf{v}'),
('3.2.673','Relativistische Gesamtenergie','Die zeitartige Komponente des Viererimpulses wird durch die relativistische Gesamtenergie E dargestellt.','p^0=\\frac{E}{c}','p^0=\\frac{E}{c}'),
('3.2.674','Ruheenergie','Die Energie eines Körpers in seinem Ruhesystem wird als Ruheenergie bezeichnet.','E_0=mc^2','E_0=mc^2'),
('3.2.675','Kinetische Energie','Die relativistische kinetische Energie ist die Differenz zwischen Gesamtenergie und Ruheenergie.','E_{\\mathrm{kin}}=E-E_0','E_{\\mathrm{kin}}=E-E_0'),
('3.2.676','Masseloser Energie-Impuls-Zustand','Ein masseloser Energie-Impuls-Zustand erfüllt m=0 und damit für positive Energie die Beziehung E=pc.','m=0,\\qquad E=pc','m=0,\\qquad E=pc');

INSERT INTO definitions
(
 definition_number,section_id,title,definition_text,formal_latex,word_latex,
 provenance,source_id,assumptions,notes,validation_status,created_revision_id
)
SELECT
 t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.word_latex,
 'literature',
 CASE WHEN CAST(SUBSTRING_INDEX(t.definition_number,'.',-1) AS UNSIGNED)<=672
      THEN @src118 ELSE @src119 END,
 'Minkowski-Raum mit Signatur (-,+,+,+), zeitartige Weltlinie und Lorentz-Invarianz.',
 'Definition aus Unterabschnitt 3.2.43.7.',
 'verified',@revision
FROM tmp_defs_32437 t
WHERE NOT EXISTS (
 SELECT 1 FROM definitions d WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_32437 t ON t.definition_number=d.definition_number
SET d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=CASE
      WHEN CAST(SUBSTRING_INDEX(t.definition_number,'.',-1) AS UNSIGNED)<=672
      THEN @src118 ELSE @src119 END,
    d.assumptions='Minkowski-Raum mit Signatur (-,+,+,+), zeitartige Weltlinie und Lorentz-Invarianz.',
    d.notes='Definition aus Unterabschnitt 3.2.43.7.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- Sätze: echtes Schema ohne proof_text
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32437;
CREATE TEMPORARY TABLE tmp_thms_32437
(
 theorem_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 statement_text LONGTEXT NOT NULL,
 statement_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_32437 VALUES
('3.2.154','Minkowski-Norm der Vierergeschwindigkeit','Die Minkowski-Norm der Vierergeschwindigkeit eines massiven Körpers ist invariant und besitzt bei der Signatur (-,+,+,+) den Wert -c^2.','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2'),
('3.2.155','Energie-Impuls-Beziehung','Für einen massiven Körper gilt die relativistische Energie-Impuls-Beziehung.','E^2=p^2c^2+m^2c^4'),
('3.2.156','Ruheenergie als Spezialfall','Für einen Körper im Ruhesystem geht die Energie-Impuls-Beziehung in die Ruheenergie E=mc^2 über.','\\mathbf{p}=\\mathbf{0}\\Longrightarrow E=mc^2'),
('3.2.157','Klassischer Grenzfall der kinetischen Energie','Für Geschwindigkeiten, die klein gegenüber der Lichtgeschwindigkeit sind, geht die relativistische kinetische Energie in die klassische kinetische Energie über.','v\\ll c\\Longrightarrow E_{\\mathrm{kin}}\\approx\\frac{1}{2}mv^2');

INSERT INTO theorems
(
 theorem_number,section_id,title,statement_text,statement_latex,word_latex,
 provenance,source_id,assumptions,validation_status,created_revision_id
)
SELECT
 t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.statement_latex,
 'literature',
 CASE WHEN t.theorem_number='3.2.154' THEN @src118 ELSE @src119 END,
 'Lorentz-Invarianz, Vierergeschwindigkeit, Viererimpuls und positive Energie.',
 'verified',@revision
FROM tmp_thms_32437 t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_32437 t ON t.theorem_number=th.theorem_number
SET th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=CASE WHEN t.theorem_number='3.2.154' THEN @src118 ELSE @src119 END,
    th.assumptions='Lorentz-Invarianz, Vierergeschwindigkeit, Viererimpuls und positive Energie.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- Gleichungen
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32437;
CREATE TEMPORARY TABLE tmp_eqs_32437
(
 equation_number VARCHAR(50) PRIMARY KEY,
 title VARCHAR(500) NOT NULL,
 equation_latex TEXT NOT NULL,
 word_latex TEXT NOT NULL,
 plain_description TEXT NOT NULL,
 equation_type ENUM(
  'definition','axiom','theorem','lemma','derived',
  'schema','model','metric','other'
 ) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_32437 VALUES
('3.3176','Parametrisierte Weltlinie','x^\\mu=x^\\mu(\\tau)','x^\\mu=x^\\mu(\\tau)','Formale Gleichung aus Abschnitt 3.2.43.7: Parametrisierte Weltlinie.','definition'),
('3.3177','Definition der Vierergeschwindigkeit','u^\\mu=\\frac{dx^\\mu}{d\\tau}','u^\\mu=\\frac{dx^\\mu}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.7: Definition der Vierergeschwindigkeit.','definition'),
('3.3178','Raumzeitvektor in Komponenten','x^\\mu=\\begin{pmatrix}ct\\\\x\\\\y\\\\z\\end{pmatrix}','x^\\mu=\\begin{pmatrix}ct\\x\\y\\z\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Raumzeitvektor in Komponenten.','definition'),
('3.3179','Vierergeschwindigkeit in Ableitungskomponenten','u^\\mu=\\begin{pmatrix}c\\frac{dt}{d\\tau}\\\\\\frac{dx}{d\\tau}\\\\\\frac{dy}{d\\tau}\\\\\\frac{dz}{d\\tau}\\end{pmatrix}','u^\\mu=\\begin{pmatrix}c\\frac{dt}{d\\tau}\\\\frac{dx}{d\\tau}\\\\frac{dy}{d\\tau}\\\\frac{dz}{d\\tau}\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Vierergeschwindigkeit in Ableitungskomponenten.','derived'),
('3.3180','Differentiale Zeitdilatation','dt=\\gamma d\\tau','dt=\\gamma d\\tau','Formale Gleichung aus Abschnitt 3.2.43.7: Differentiale Zeitdilatation.','derived'),
('3.3181','Verhältnis von Koordinatenzeit und Eigenzeit','\\frac{dt}{d\\tau}=\\gamma','\\frac{dt}{d\\tau}=\\gamma','Formale Gleichung aus Abschnitt 3.2.43.7: Verhältnis von Koordinatenzeit und Eigenzeit.','derived'),
('3.3182','Kettenregel für die räumliche Bewegung','\\frac{d\\mathbf{x}}{d\\tau}=\\frac{d\\mathbf{x}}{dt}\\frac{dt}{d\\tau}','\\frac{d\\mathbf{x}}{d\\tau}=\\frac{d\\mathbf{x}}{dt}\\frac{dt}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.7: Kettenregel für die räumliche Bewegung.','derived'),
('3.3183','Definition der Dreiergeschwindigkeit','\\mathbf{v}=\\frac{d\\mathbf{x}}{dt}','\\mathbf{v}=\\frac{d\\mathbf{x}}{dt}','Formale Gleichung aus Abschnitt 3.2.43.7: Definition der Dreiergeschwindigkeit.','definition'),
('3.3184','Eigenzeitableitung des Ortsvektors','\\frac{d\\mathbf{x}}{d\\tau}=\\gamma\\mathbf{v}','\\frac{d\\mathbf{x}}{d\\tau}=\\gamma\\mathbf{v}','Formale Gleichung aus Abschnitt 3.2.43.7: Eigenzeitableitung des Ortsvektors.','derived'),
('3.3185','Vierergeschwindigkeit in Komponenten','u^\\mu=\\begin{pmatrix}\\gamma c\\\\\\gamma v_x\\\\\\gamma v_y\\\\\\gamma v_z\\end{pmatrix}','u^\\mu=\\begin{pmatrix}\\gamma c\\\\gamma v_x\\\\gamma v_y\\\\gamma v_z\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Vierergeschwindigkeit in Komponenten.','derived'),
('3.3186','Kompakte Vierergeschwindigkeit','u^\\mu=\\gamma\\begin{pmatrix}c\\\\\\mathbf{v}\\end{pmatrix}','u^\\mu=\\gamma\\begin{pmatrix}c\\\\mathbf{v}\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Kompakte Vierergeschwindigkeit.','derived'),
('3.3187','Invariante Minkowski-Norm der Vierergeschwindigkeit','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Invariante Minkowski-Norm der Vierergeschwindigkeit.','theorem'),
('3.3188','Norm aus der Definition der Vierergeschwindigkeit','\\eta_{\\mu\\nu}u^\\mu u^\\nu=\\eta_{\\mu\\nu}\\frac{dx^\\mu}{d\\tau}\\frac{dx^\\nu}{d\\tau}','\\eta_{\\mu\\nu}u^\\mu u^\\nu=\\eta_{\\mu\\nu}\\frac{dx^\\mu}{d\\tau}\\frac{dx^\\nu}{d\\tau}','Formale Gleichung aus Abschnitt 3.2.43.7: Norm aus der Definition der Vierergeschwindigkeit.','derived'),
('3.3189','Norm als Quotient des Raumzeitintervalls','\\eta_{\\mu\\nu}u^\\mu u^\\nu=\\frac{ds^2}{d\\tau^2}','\\eta_{\\mu\\nu}u^\\mu u^\\nu=\\frac{ds^2}{d\\tau^2}','Formale Gleichung aus Abschnitt 3.2.43.7: Norm als Quotient des Raumzeitintervalls.','derived'),
('3.3190','Eigenzeitdefinition für zeitartige Weltlinien','ds^2=-c^2d\\tau^2','ds^2=-c^2d\\tau^2','Formale Gleichung aus Abschnitt 3.2.43.7: Eigenzeitdefinition für zeitartige Weltlinien.','definition'),
('3.3191','Quotient des Eigenzeitintervalls','\\frac{ds^2}{d\\tau^2}=-c^2','\\frac{ds^2}{d\\tau^2}=-c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Quotient des Eigenzeitintervalls.','derived'),
('3.3192','Abschluss der Normherleitung','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Abschluss der Normherleitung.','theorem'),
('3.3193','Lorentz-Invarianz der Ruhemasse','m''=m','m''=m','Formale Gleichung aus Abschnitt 3.2.43.7: Lorentz-Invarianz der Ruhemasse.','definition'),
('3.3194','Definition des Viererimpulses','p^\\mu=mu^\\mu','p^\\mu=mu^\\mu','Formale Gleichung aus Abschnitt 3.2.43.7: Definition des Viererimpulses.','definition'),
('3.3195','Viererimpuls aus Vierergeschwindigkeit','p^\\mu=m\\gamma\\begin{pmatrix}c\\\\\\mathbf{v}\\end{pmatrix}','p^\\mu=m\\gamma\\begin{pmatrix}c\\\\mathbf{v}\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Viererimpuls aus Vierergeschwindigkeit.','derived'),
('3.3196','Viererimpuls in Komponenten','p^\\mu=\\begin{pmatrix}\\gamma mc\\\\\\gamma mv_x\\\\\\gamma mv_y\\\\\\gamma mv_z\\end{pmatrix}','p^\\mu=\\begin{pmatrix}\\gamma mc\\\\gamma mv_x\\\\gamma mv_y\\\\gamma mv_z\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Viererimpuls in Komponenten.','derived'),
('3.3197','Relativistischer Dreierimpuls','\\mathbf{p}=\\gamma m\\mathbf{v}','\\mathbf{p}=\\gamma m\\mathbf{v}','Formale Gleichung aus Abschnitt 3.2.43.7: Relativistischer Dreierimpuls.','definition'),
('3.3198','Bedingung des klassischen Geschwindigkeitsbereichs','v\\ll c','v\\ll c','Formale Gleichung aus Abschnitt 3.2.43.7: Bedingung des klassischen Geschwindigkeitsbereichs.','definition'),
('3.3199','Näherung des Lorentz-Faktors','\\gamma\\approx1','\\gamma\\approx1','Formale Gleichung aus Abschnitt 3.2.43.7: Näherung des Lorentz-Faktors.','derived'),
('3.3200','Klassischer Grenzfall des Impulses','\\mathbf{p}\\approx m\\mathbf{v}','\\mathbf{p}\\approx m\\mathbf{v}','Formale Gleichung aus Abschnitt 3.2.43.7: Klassischer Grenzfall des Impulses.','derived'),
('3.3201','Energie als zeitartige Impulskomponente','p^0=\\frac{E}{c}','p^0=\\frac{E}{c}','Formale Gleichung aus Abschnitt 3.2.43.7: Energie als zeitartige Impulskomponente.','definition'),
('3.3202','Zeitartige Komponente des Viererimpulses','p^0=\\gamma mc','p^0=\\gamma mc','Formale Gleichung aus Abschnitt 3.2.43.7: Zeitartige Komponente des Viererimpulses.','derived'),
('3.3203','Gleichsetzung der zeitartigen Komponenten','\\frac{E}{c}=\\gamma mc','\\frac{E}{c}=\\gamma mc','Formale Gleichung aus Abschnitt 3.2.43.7: Gleichsetzung der zeitartigen Komponenten.','derived'),
('3.3204','Relativistische Gesamtenergie','E=\\gamma mc^2','E=\\gamma mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Relativistische Gesamtenergie.','definition'),
('3.3205','Viererimpuls in Energie-Impuls-Form','p^\\mu=\\begin{pmatrix}\\frac{E}{c}\\\\\\mathbf{p}\\end{pmatrix}','p^\\mu=\\begin{pmatrix}\\frac{E}{c}\\\\mathbf{p}\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Viererimpuls in Energie-Impuls-Form.','derived'),
('3.3206','Ruhebedingung des Körpers','\\mathbf{v}=\\mathbf{0}','\\mathbf{v}=\\mathbf{0}','Formale Gleichung aus Abschnitt 3.2.43.7: Ruhebedingung des Körpers.','definition'),
('3.3207','Lorentz-Faktor im Ruhesystem','\\gamma=1','\\gamma=1','Formale Gleichung aus Abschnitt 3.2.43.7: Lorentz-Faktor im Ruhesystem.','derived'),
('3.3208','Ruheenergie','E_0=mc^2','E_0=mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Ruheenergie.','definition'),
('3.3209','Energie-Impuls-Beziehung','E^2=p^2c^2+m^2c^4','E^2=p^2c^2+m^2c^4','Formale Gleichung aus Abschnitt 3.2.43.7: Energie-Impuls-Beziehung.','theorem'),
('3.3210','Quadrat des räumlichen Impulses','p^2=\\mathbf{p}\\cdot\\mathbf{p}','p^2=\\mathbf{p}\\cdot\\mathbf{p}','Formale Gleichung aus Abschnitt 3.2.43.7: Quadrat des räumlichen Impulses.','definition'),
('3.3211','Norm des Viererimpulses aus der Vierergeschwindigkeit','\\eta_{\\mu\\nu}p^\\mu p^\\nu=m^2\\eta_{\\mu\\nu}u^\\mu u^\\nu','\\eta_{\\mu\\nu}p^\\mu p^\\nu=m^2\\eta_{\\mu\\nu}u^\\mu u^\\nu','Formale Gleichung aus Abschnitt 3.2.43.7: Norm des Viererimpulses aus der Vierergeschwindigkeit.','derived'),
('3.3212','Eingesetzte Norm der Vierergeschwindigkeit','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2','\\eta_{\\mu\\nu}u^\\mu u^\\nu=-c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Eingesetzte Norm der Vierergeschwindigkeit.','derived'),
('3.3213','Invariante Norm des Viererimpulses','\\eta_{\\mu\\nu}p^\\mu p^\\nu=-m^2c^2','\\eta_{\\mu\\nu}p^\\mu p^\\nu=-m^2c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Invariante Norm des Viererimpulses.','theorem'),
('3.3214','Viererimpuls für die Normberechnung','p^\\mu=\\begin{pmatrix}\\frac{E}{c}\\\\\\mathbf{p}\\end{pmatrix}','p^\\mu=\\begin{pmatrix}\\frac{E}{c}\\\\mathbf{p}\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.7: Viererimpuls für die Normberechnung.','derived'),
('3.3215','Ausgeschriebene Minkowski-Norm des Viererimpulses','-\\frac{E^2}{c^2}+p^2=-m^2c^2','-\\frac{E^2}{c^2}+p^2=-m^2c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Ausgeschriebene Minkowski-Norm des Viererimpulses.','derived'),
('3.3216','Mit c Quadrat multiplizierte Normgleichung','-E^2+p^2c^2=-m^2c^4','-E^2+p^2c^2=-m^2c^4','Formale Gleichung aus Abschnitt 3.2.43.7: Mit c Quadrat multiplizierte Normgleichung.','derived'),
('3.3217','Hergeleitete Energie-Impuls-Beziehung','E^2=p^2c^2+m^2c^4','E^2=p^2c^2+m^2c^4','Formale Gleichung aus Abschnitt 3.2.43.7: Hergeleitete Energie-Impuls-Beziehung.','theorem'),
('3.3218','Impuls im Ruhesystem','\\mathbf{p}=\\mathbf{0}','\\mathbf{p}=\\mathbf{0}','Formale Gleichung aus Abschnitt 3.2.43.7: Impuls im Ruhesystem.','definition'),
('3.3219','Energiequadrat im Ruhesystem','E^2=m^2c^4','E^2=m^2c^4','Formale Gleichung aus Abschnitt 3.2.43.7: Energiequadrat im Ruhesystem.','derived'),
('3.3220','Positive Ruheenergie','E=mc^2','E=mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Positive Ruheenergie.','theorem'),
('3.3221','Definition der kinetischen Energie','E_{\\mathrm{kin}}=E-E_0','E_{\\mathrm{kin}}=E-E_0','Formale Gleichung aus Abschnitt 3.2.43.7: Definition der kinetischen Energie.','definition'),
('3.3222','Gesamtenergie für die kinetische Energie','E=\\gamma mc^2','E=\\gamma mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Gesamtenergie für die kinetische Energie.','derived'),
('3.3223','Ruheenergie für die kinetische Energie','E_0=mc^2','E_0=mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Ruheenergie für die kinetische Energie.','derived'),
('3.3224','Relativistische kinetische Energie','E_{\\mathrm{kin}}=(\\gamma-1)mc^2','E_{\\mathrm{kin}}=(\\gamma-1)mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Relativistische kinetische Energie.','definition'),
('3.3225','Klassischer Grenzfall der kinetischen Energie','E_{\\mathrm{kin}}\\approx\\frac{1}{2}mv^2','E_{\\mathrm{kin}}\\approx\\frac{1}{2}mv^2','Formale Gleichung aus Abschnitt 3.2.43.7: Klassischer Grenzfall der kinetischen Energie.','theorem'),
('3.3226','Kleinheitsbedingung der Reihenentwicklung','\\frac{v^2}{c^2}\\ll1','\\frac{v^2}{c^2}\\ll1','Formale Gleichung aus Abschnitt 3.2.43.7: Kleinheitsbedingung der Reihenentwicklung.','definition'),
('3.3227','Lorentz-Faktor als Potenz','\\gamma=\\left(1-\\frac{v^2}{c^2}\\right)^{-\\frac{1}{2}}','\\gamma=\\left(1-\\frac{v^2}{c^2}\\right)^{-\\frac{1}{2}}','Formale Gleichung aus Abschnitt 3.2.43.7: Lorentz-Faktor als Potenz.','derived'),
('3.3228','Reihenentwicklung des Lorentz-Faktors','\\gamma\\approx1+\\frac{1}{2}\\frac{v^2}{c^2}','\\gamma\\approx1+\\frac{1}{2}\\frac{v^2}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.7: Reihenentwicklung des Lorentz-Faktors.','derived'),
('3.3229','Näherung für Gamma minus eins','\\gamma-1\\approx\\frac{1}{2}\\frac{v^2}{c^2}','\\gamma-1\\approx\\frac{1}{2}\\frac{v^2}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.7: Näherung für Gamma minus eins.','derived'),
('3.3230','Eingesetzte Näherung der kinetischen Energie','E_{\\mathrm{kin}}\\approx\\frac{1}{2}\\frac{v^2}{c^2}mc^2','E_{\\mathrm{kin}}\\approx\\frac{1}{2}\\frac{v^2}{c^2}mc^2','Formale Gleichung aus Abschnitt 3.2.43.7: Eingesetzte Näherung der kinetischen Energie.','derived'),
('3.3231','Klassische kinetische Energie','E_{\\mathrm{kin}}\\approx\\frac{1}{2}mv^2','E_{\\mathrm{kin}}\\approx\\frac{1}{2}mv^2','Formale Gleichung aus Abschnitt 3.2.43.7: Klassische kinetische Energie.','theorem'),
('3.3232','Masselose Bedingung','m=0','m=0','Formale Gleichung aus Abschnitt 3.2.43.7: Masselose Bedingung.','definition'),
('3.3233','Energie-Impuls-Beziehung für masselose Zustände','E^2=p^2c^2','E^2=p^2c^2','Formale Gleichung aus Abschnitt 3.2.43.7: Energie-Impuls-Beziehung für masselose Zustände.','derived'),
('3.3234','Positive Energie eines masselosen Zustands','E=pc','E=pc','Formale Gleichung aus Abschnitt 3.2.43.7: Positive Energie eines masselosen Zustands.','theorem'),
('3.3235','Didaktische Zusammenfassung der Energie-Impuls-Beziehung','E^2=p^2c^2+m^2c^4','E^2=p^2c^2+m^2c^4','Formale Gleichung aus Abschnitt 3.2.43.7: Didaktische Zusammenfassung der Energie-Impuls-Beziehung.','theorem');

INSERT INTO equations
(
 equation_number,section_id,title,equation_latex,word_latex,
 plain_description,equation_type,provenance,source_id,
 derivation,assumptions,validation_status,created_revision_id
)
SELECT
 t.equation_number,@section,t.title,t.equation_latex,t.word_latex,
 t.plain_description,t.equation_type,'literature',
 CASE WHEN CAST(SUBSTRING_INDEX(t.equation_number,'.',-1) AS UNSIGNED)<=3200
      THEN @src118 ELSE @src119 END,
 'Im Unterabschnitt 3.2.43.7 eingeführt oder aus den vorangehenden Gleichungen hergeleitet.',
 'Minkowski-Raum, Lorentz-Invarianz, Ruhemasse m und |v|<c; für masselose Zustände m=0.',
 'verified',@revision
FROM tmp_eqs_32437 t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_32437 t ON t.equation_number=e.equation_number
SET e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=CASE
      WHEN CAST(SUBSTRING_INDEX(t.equation_number,'.',-1) AS UNSIGNED)<=3200
      THEN @src118 ELSE @src119 END,
    e.derivation='Im Unterabschnitt 3.2.43.7 eingeführt oder aus den vorangehenden Gleichungen hergeleitet.',
    e.assumptions='Minkowski-Raum, Lorentz-Invarianz, Ruhemasse m und |v|<c; für masselose Zustände m=0.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

-- Literaturverwendung
INSERT INTO source_usage
(
 source_id,section_id,usage_type,claim_summary,exact_location,
 is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
 @src118,@section,'first_citation',
 'Weltlinie, Vierergeschwindigkeit, Viererimpuls und relativistischer Dreierimpuls.',
 'Abschnitt 3.2.43.7 – erster Teil',
 1,0,
 'Bibliografische Identität der Arbeitsquelle [118] vor Endredaktion festlegen.',
 @revision
WHERE @src118 IS NOT NULL AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@src118 AND section_id=@section
   AND exact_location='Abschnitt 3.2.43.7 – erster Teil'
);

INSERT INTO source_usage
(
 source_id,section_id,usage_type,claim_summary,exact_location,
 is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
 @src119,@section,'first_citation',
 'Relativistische Gesamtenergie, Ruheenergie, Energie-Impuls-Beziehung, kinetische Energie und klassische Grenzfälle.',
 'Abschnitt 3.2.43.7 – zweiter Teil',
 1,0,
 'Bibliografische Identität der Arbeitsquelle [119] vor Endredaktion festlegen.',
 @revision
WHERE @src119 IS NOT NULL AND NOT EXISTS (
 SELECT 1 FROM source_usage
 WHERE source_id=@src119 AND section_id=@section
   AND exact_location='Abschnitt 3.2.43.7 – zweiter Teil'
);

-- Änderungsprotokoll
INSERT INTO section_change_log
(
 revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value
)
SELECT
 @revision,@section,'updated','subsection','3.2.43.7',
 'Unterabschnitt 3.2.43.7 vollständig in das Repository aufgenommen.',
 'Stand bis Definition 3.2.667, Satz 3.2.153 und Gleichung (3.3175).',
 '9 Definitionen, 4 Sätze und 60 Gleichungen bis (3.3235).'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
   AND object_reference='3.2.43.7'
);

-- Zähler
INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.43.7'),
('current_section','3.2.43.8'),
('last_definition_number','3.2.676'),
('next_definition_number','3.2.677'),
('last_theorem_number','3.2.157'),
('next_theorem_number','3.2.158'),
('last_equation_number','3.3235'),
('next_equation_number','3.3236'),
('last_citation_number','119'),
('next_citation_number','120')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32437;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32437;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32437;

COMMIT;

-- Abschlussprüfungen
SELECT COUNT(*) AS definitionen_3_2_43_7
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 668 AND 676;

SELECT COUNT(*) AS saetze_3_2_43_7
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 154 AND 157;

SELECT COUNT(*) AS gleichungen_3_2_43_7
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3176 AND 3235;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_7
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3176 AND 3235
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT
 (SELECT COUNT(*) FROM definitions
  WHERE section_id=@section
    AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
        BETWEEN 638 AND 676) AS definitionen_gesamt_3_2_43,
 (SELECT COUNT(*) FROM theorems
  WHERE section_id=@section
    AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
        BETWEEN 145 AND 157) AS saetze_gesamt_3_2_43,
 (SELECT COUNT(*) FROM equations
  WHERE section_id=@section
    AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
        BETWEEN 3066 AND 3235) AS gleichungen_gesamt_3_2_43;

SELECT citation_number,source_key,title,verification_status
FROM sources
WHERE citation_number IN (118,119)
ORDER BY citation_number;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN
(
 'last_completed_section','current_section',
 'last_definition_number','next_definition_number',
 'last_theorem_number','next_theorem_number',
 'last_equation_number','next_equation_number',
 'last_citation_number','next_citation_number'
)
ORDER BY counter_key;
