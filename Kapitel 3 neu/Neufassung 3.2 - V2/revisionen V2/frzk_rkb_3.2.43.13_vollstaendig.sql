USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – vollständiges Update-Skript
   Abschnitt 3.2.43.13: Eichtransformation und Eichinvarianz

   Definitionen : 3.2.706–3.2.715
   Sätze        : 3.2.179–3.2.186
   Gleichungen  : (3.3357)–(3.3425)
   Literatur    : [125]
   Voraussetzung: vollständiger Repository-Stand bis 3.2.43.12
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id FROM repository_revisions
    WHERE scope_reference='3.2.43.12'
    ORDER BY revision_id DESC LIMIT 1
);

SET @section := (
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.2.43' LIMIT 1
);

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_frzk_check_324313_prerequisites$$
CREATE PROCEDURE sp_frzk_check_324313_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Revision für 3.2.43.12 fehlt.';
    END IF;
    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;
END$$

CALL sp_frzk_check_324313_prerequisites()$$
DROP PROCEDURE sp_frzk_check_324313_prerequisites$$

DELIMITER ;

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
VALUES
(
    'RKB-NEU-K3.2.43.13-V1', NOW(), 'subsection', '3.2.43.13',
    '3.2.43.13-v1-vollstaendig',
    'Eichtransformation, Eichäquivalenz, Eichklassen, Lorenz- und Coulomb-Eichung, Resteichfreiheit, Eichinvarianz der Wirkung und Ladungserhaltung.',
    'Olaf Thiele / ChatGPT', @parent_revision
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
        'Ergänzt um 3.2.43.13: Eichtransformation und Eichinvarianz.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.13:%';

-- Literatur [125]
INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    125,
    'eichtransformation_eichinvarianz_arbeitsquelle_125',
    'book',
    'Eichtransformation und Eichinvarianz in der klassischen Elektrodynamik',
    'de',
    2,
    'secondary_source',
    8,
    'pending',
    '3.2.43.13',
    'Arbeitsquelle zu Eichtransformation, Eichklassen, Lorenz-Eichung, Resteichfreiheit und Ladungserhaltung.',
    'Bibliografische Quelle [125] ist vor der Endredaktion vollständig festzulegen.',
    'Eichtransformation und Eichinvarianz [125]',
    'Provisorischer Repository-Eintrag; keine erfundene bibliografische Zuordnung.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number=125
       OR source_key='eichtransformation_eichinvarianz_arbeitsquelle_125'
);

SET @src125 := (
    SELECT source_id FROM sources
    WHERE citation_number=125 LIMIT 1
);

-- Definitionen
DROP TEMPORARY TABLE IF EXISTS tmp_defs_324313;
CREATE TEMPORARY TABLE tmp_defs_324313
(
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_324313 VALUES
('3.2.706','Elektromagnetische Eichtransformation','Eine elektromagnetische Eichtransformation verändert das Viererpotential um den Vierergradienten einer hinreichend differenzierbaren skalaren Eichfunktion, ohne den elektromagnetischen Feldtensor zu verändern.','A_\\mu\\longmapsto A''_\\mu=A_\\mu+\\partial_\\mu\\chi','A_\\mu\\longmapsto A''_\\mu=A_\\mu+\\partial_\\mu\\chi'),
('3.2.707','Dreidimensionale Eichtransformation','In dreidimensionaler Darstellung verändern sich das magnetische Vektorpotential und das elektrische Skalarpotential durch den Gradienten beziehungsweise die Zeitableitung derselben Eichfunktion.','\\mathbf{A}''=\\mathbf{A}+\\nabla\\chi,\\qquad\\phi''=\\phi-\\frac{\\partial\\chi}{\\partial t}','\\mathbf{A}''=\\mathbf{A}+\\nabla\\chi,\\qquad\\phi''=\\phi-\\frac{\\partial\\chi}{\\partial t}'),
('3.2.708','Eichäquivalenz','Zwei Viererpotentiale heißen eichäquivalent, wenn sie sich um den Vierergradienten einer zulässigen skalaren Eichfunktion unterscheiden.','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','A''_\\mu=A_\\mu+\\partial_\\mu\\chi'),
('3.2.709','Eichklasse','Die Eichklasse eines Viererpotentials ist die Menge aller durch zulässige Eichtransformationen erreichbaren, physikalisch gleichwertigen Potentialdarstellungen.','[A_\\mu]=\\left\\{A_\\mu+\\partial_\\mu\\chi\\;\\middle|\\;\\chi\\in C^2\\right\\}','[A_\\mu]=\\left\\{A_\\mu+\\partial_\\mu\\chi\\;\\middle|\\;\\chi\\in C^2\\right\\}'),
('3.2.710','Eichinvariante Größe','Eine vom Viererpotential abhängige Größe heißt eichinvariant, wenn ihr Wert unter jeder zulässigen Eichtransformation unverändert bleibt.','Q[A+\\partial\\chi]=Q[A]','Q[A+\\partial\\chi]=Q[A]'),
('3.2.711','Eichfixierung','Unter einer Eichfixierung wird die Auswahl eines bestimmten Repräsentanten aus einer Eichklasse durch eine zusätzliche Bedingung an das Viererpotential verstanden.','G[A]=0','G[A]=0'),
('3.2.712','Lorenz-Eichung','Die Lorenz-Eichung ist die kovariante Eichbedingung, nach der die Viererdivergenz des Viererpotentials verschwindet.','\\partial_\\mu A^\\mu=0','\\partial_\\mu A^\\mu=0'),
('3.2.713','Resteichfreiheit','Nach Festlegung der Lorenz-Eichung verbleibt eine Eichfreiheit durch Eichfunktionen, welche die homogene Wellengleichung erfüllen.','\\Box\\chi=0','\\Box\\chi=0'),
('3.2.714','Coulomb-Eichung','Die Coulomb-Eichung ist durch das Verschwinden der räumlichen Divergenz des magnetischen Vektorpotentials definiert.','\\nabla\\cdot\\mathbf{A}=0','\\nabla\\cdot\\mathbf{A}=0'),
('3.2.715','Physikalischer Konfigurationsraum des elektromagnetischen Potentials','Der physikalische Konfigurationsraum des elektromagnetischen Potentials ist der Quotientenraum der zulässigen Potentiale nach der Gruppe der zulässigen Eichtransformationen.','\\mathcal{C}_{\\mathrm{phys}}=\\mathcal{A}/\\mathcal{G}','\\mathcal{C}_{\\mathrm{phys}}=\\mathcal{A}/\\mathcal{G}');

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
SELECT
    t.definition_number, @section, t.title, t.definition_text,
    t.formal_latex, t.word_latex, 'literature', @src125,
    'Hinreichend differenzierbare Felder, kommutierende partielle Ableitungen, konsistente Metrik- und Indexkonvention sowie geeignete Randbedingungen.',
    'Definition aus Unterabschnitt 3.2.43.13.',
    'verified', @revision
FROM tmp_defs_324313 t
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_324313 t ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src125,
    d.assumptions='Hinreichend differenzierbare Felder, kommutierende partielle Ableitungen, konsistente Metrik- und Indexkonvention sowie geeignete Randbedingungen.',
    d.notes='Definition aus Unterabschnitt 3.2.43.13.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- Sätze
DROP TEMPORARY TABLE IF EXISTS tmp_thms_324313;
CREATE TEMPORARY TABLE tmp_thms_324313
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_324313 VALUES
('3.2.179','Eichinvarianz des elektromagnetischen Feldtensors','Der elektromagnetische Feldtensor bleibt unter einer Eichtransformation des Viererpotentials unverändert.','F''_{\\mu\\nu}=F_{\\mu\\nu}'),
('3.2.180','Eichinvarianz der elektrischen und magnetischen Felder','Die aus den Potentialen gebildeten elektrischen und magnetischen Felder bleiben unter einer elektromagnetischen Eichtransformation unverändert.','\\mathbf{E}''=\\mathbf{E},\\qquad\\mathbf{B}''=\\mathbf{B}'),
('3.2.181','Eichäquivalenz als Äquivalenzrelation','Die Eichäquivalenz ist auf der Menge der zulässigen Viererpotentiale reflexiv, symmetrisch und transitiv und damit eine Äquivalenzrelation.','A_\\mu\\sim A''_\\mu'),
('3.2.182','Erreichbarkeit der Lorenz-Eichung','Zu einem hinreichend differenzierbaren Viererpotential kann lokal eine Eichfunktion gewählt werden, sodass das transformierte Potential die Lorenz-Eichung erfüllt, sofern die zugehörige inhomogene Wellengleichung lösbar ist.','\\Box\\chi=-\\partial_\\mu A^\\mu'),
('3.2.183','Wellengleichung des Viererpotentials in Lorenz-Eichung','In Lorenz-Eichung reduziert sich die inhomogene Maxwell-Gleichung auf eine Wellengleichung für jede Komponente des Viererpotentials.','\\Box A^\\nu=\\mu_0J^\\nu'),
('3.2.184','Eichinvarianz der freien elektromagnetischen Feldwirkung','Die freie elektromagnetische Feldwirkung bleibt unter Eichtransformationen des Viererpotentials unverändert.','S''_{\\mathrm{Feld}}=S_{\\mathrm{Feld}}'),
('3.2.185','Eichvariation der Wechselwirkungswirkung','Die Wechselwirkungswirkung ist unter einer Eichtransformation invariant, wenn der Randterm verschwindet und die Viererstromdichte die Kontinuitätsgleichung erfüllt.','\\Delta S_{\\mathrm{WW}}=0'),
('3.2.186','Zusammenhang zwischen Eichinvarianz und Ladungserhaltung','Die Eichinvarianz der elektromagnetischen Wirkung mit äußerer Viererstromdichte ist strukturell mit der lokalen Erhaltung der elektrischen Ladung verbunden.','\\partial_\\mu J^\\mu=0');

INSERT INTO theorems
(
    theorem_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
SELECT
    t.theorem_number, @section, t.title, t.statement_text,
    t.statement_latex, t.statement_latex, 'literature', @src125,
    'Hinreichende Differenzierbarkeit, verschwindende oder kontrollierte Randterme, lokale Lösbarkeit der Wellengleichung und Erfüllung der Kontinuitätsgleichung, soweit erforderlich.',
    'verified', @revision
FROM tmp_thms_324313 t
WHERE NOT EXISTS
(
    SELECT 1 FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_324313 t ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src125,
    th.assumptions='Hinreichende Differenzierbarkeit, verschwindende oder kontrollierte Randterme, lokale Lösbarkeit der Wellengleichung und Erfüllung der Kontinuitätsgleichung, soweit erforderlich.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- Gleichungen
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_324313;
CREATE TEMPORARY TABLE tmp_eqs_324313
(
    equation_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    equation_latex TEXT NOT NULL,
    word_latex TEXT NOT NULL,
    plain_description TEXT NOT NULL,
    equation_type ENUM
    (
        'definition','axiom','theorem','lemma','derived',
        'schema','model','metric','other'
    ) NOT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_eqs_324313 VALUES
('3.3357','Elektromagnetische Eichtransformation','A_\\mu\\longmapsto A''_\\mu=A_\\mu+\\partial_\\mu\\chi','A_\\mu\\longmapsto A''_\\mu=A_\\mu+\\partial_\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Elektromagnetische Eichtransformation.','definition'),
('3.3358','Eichfunktion','\\chi=\\chi(x^\\mu)','\\chi=\\chi(x^\\mu)','Gleichung aus Abschnitt 3.2.43.13: Eichfunktion.','definition'),
('3.3359','Kontravariante Eichtransformation','A^\\mu\\longmapsto A''^\\mu=A^\\mu+\\partial^\\mu\\chi','A^\\mu\\longmapsto A''^\\mu=A^\\mu+\\partial^\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Kontravariante Eichtransformation.','definition'),
('3.3360','Transformation des Vektorpotentials','\\mathbf{A}''=\\mathbf{A}+\\nabla\\chi','\\mathbf{A}''=\\mathbf{A}+\\nabla\\chi','Gleichung aus Abschnitt 3.2.43.13: Transformation des Vektorpotentials.','definition'),
('3.3361','Transformation des Skalarpotentials','\\phi''=\\phi-\\frac{\\partial\\chi}{\\partial t}','\\phi''=\\phi-\\frac{\\partial\\chi}{\\partial t}','Gleichung aus Abschnitt 3.2.43.13: Transformation des Skalarpotentials.','definition'),
('3.3362','Konvention des Viererpotentials','A^\\mu=\\left(\\frac{\\phi}{c},\\mathbf{A}\\right)','A^\\mu=\\left(\\frac{\\phi}{c},\\mathbf{A}\\right)','Gleichung aus Abschnitt 3.2.43.13: Konvention des Viererpotentials.','definition'),
('3.3363','Eichinvarianz des Feldtensors','F''_{\\mu\\nu}=F_{\\mu\\nu}','F''_{\\mu\\nu}=F_{\\mu\\nu}','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianz des Feldtensors.','theorem'),
('3.3364','Definition des transformierten Feldtensors','F''_{\\mu\\nu}=\\partial_\\mu A''_\\nu-\\partial_\\nu A''_\\mu','F''_{\\mu\\nu}=\\partial_\\mu A''_\\nu-\\partial_\\nu A''_\\mu','Gleichung aus Abschnitt 3.2.43.13: Definition des transformierten Feldtensors.','derived'),
('3.3365','Einzusetzende Eichtransformation','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Einzusetzende Eichtransformation.','derived'),
('3.3366','Einsetzung in den Feldtensor','F''_{\\mu\\nu}=\\partial_\\mu\\left(A_\\nu+\\partial_\\nu\\chi\\right)-\\partial_\\nu\\left(A_\\mu+\\partial_\\mu\\chi\\right)','F''_{\\mu\\nu}=\\partial_\\mu\\left(A_\\nu+\\partial_\\nu\\chi\\right)-\\partial_\\nu\\left(A_\\mu+\\partial_\\mu\\chi\\right)','Gleichung aus Abschnitt 3.2.43.13: Einsetzung in den Feldtensor.','derived'),
('3.3367','Ausmultiplizierter transformierter Feldtensor','F''_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu+\\partial_\\mu\\partial_\\nu\\chi-\\partial_\\nu\\partial_\\mu\\chi','F''_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu+\\partial_\\mu\\partial_\\nu\\chi-\\partial_\\nu\\partial_\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Ausmultiplizierter transformierter Feldtensor.','derived'),
('3.3368','Vertauschbarkeit gemischter Ableitungen','\\partial_\\mu\\partial_\\nu\\chi=\\partial_\\nu\\partial_\\mu\\chi','\\partial_\\mu\\partial_\\nu\\chi=\\partial_\\nu\\partial_\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Vertauschbarkeit gemischter Ableitungen.','derived'),
('3.3369','Rückführung auf den ursprünglichen Feldtensor','F''_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu=F_{\\mu\\nu}','F''_{\\mu\\nu}=\\partial_\\mu A_\\nu-\\partial_\\nu A_\\mu=F_{\\mu\\nu}','Gleichung aus Abschnitt 3.2.43.13: Rückführung auf den ursprünglichen Feldtensor.','theorem'),
('3.3370','Eichinvarianz des elektrischen Feldes','\\mathbf{E}''=\\mathbf{E}','\\mathbf{E}''=\\mathbf{E}','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianz des elektrischen Feldes.','theorem'),
('3.3371','Eichinvarianz des magnetischen Feldes','\\mathbf{B}''=\\mathbf{B}','\\mathbf{B}''=\\mathbf{B}','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianz des magnetischen Feldes.','theorem'),
('3.3372','Elektrisches Feld aus Potentialen','\\mathbf{E}=-\\nabla\\phi-\\frac{\\partial\\mathbf{A}}{\\partial t}','\\mathbf{E}=-\\nabla\\phi-\\frac{\\partial\\mathbf{A}}{\\partial t}','Gleichung aus Abschnitt 3.2.43.13: Elektrisches Feld aus Potentialen.','definition'),
('3.3373','Transformiertes elektrisches Feld','\\mathbf{E}''=-\\nabla\\phi''-\\frac{\\partial\\mathbf{A}''}{\\partial t}','\\mathbf{E}''=-\\nabla\\phi''-\\frac{\\partial\\mathbf{A}''}{\\partial t}','Gleichung aus Abschnitt 3.2.43.13: Transformiertes elektrisches Feld.','derived'),
('3.3374','Einsetzung der transformierten Potentiale','\\mathbf{E}''=-\\nabla\\left(\\phi-\\frac{\\partial\\chi}{\\partial t}\\right)-\\frac{\\partial}{\\partial t}\\left(\\mathbf{A}+\\nabla\\chi\\right)','\\mathbf{E}''=-\\nabla\\left(\\phi-\\frac{\\partial\\chi}{\\partial t}\\right)-\\frac{\\partial}{\\partial t}\\left(\\mathbf{A}+\\nabla\\chi\\right)','Gleichung aus Abschnitt 3.2.43.13: Einsetzung der transformierten Potentiale.','derived'),
('3.3375','Ausmultiplizierte elektrische Feldtransformation','\\mathbf{E}''=-\\nabla\\phi+\\nabla\\frac{\\partial\\chi}{\\partial t}-\\frac{\\partial\\mathbf{A}}{\\partial t}-\\frac{\\partial}{\\partial t}\\nabla\\chi','\\mathbf{E}''=-\\nabla\\phi+\\nabla\\frac{\\partial\\chi}{\\partial t}-\\frac{\\partial\\mathbf{A}}{\\partial t}-\\frac{\\partial}{\\partial t}\\nabla\\chi','Gleichung aus Abschnitt 3.2.43.13: Ausmultiplizierte elektrische Feldtransformation.','derived'),
('3.3376','Rückführung des elektrischen Feldes','\\mathbf{E}''=-\\nabla\\phi-\\frac{\\partial\\mathbf{A}}{\\partial t}=\\mathbf{E}','\\mathbf{E}''=-\\nabla\\phi-\\frac{\\partial\\mathbf{A}}{\\partial t}=\\mathbf{E}','Gleichung aus Abschnitt 3.2.43.13: Rückführung des elektrischen Feldes.','theorem'),
('3.3377','Magnetisches Feld aus dem Vektorpotential','\\mathbf{B}=\\nabla\\times\\mathbf{A}','\\mathbf{B}=\\nabla\\times\\mathbf{A}','Gleichung aus Abschnitt 3.2.43.13: Magnetisches Feld aus dem Vektorpotential.','definition'),
('3.3378','Transformiertes magnetisches Feld','\\mathbf{B}''=\\nabla\\times\\mathbf{A}''=\\nabla\\times\\left(\\mathbf{A}+\\nabla\\chi\\right)','\\mathbf{B}''=\\nabla\\times\\mathbf{A}''=\\nabla\\times\\left(\\mathbf{A}+\\nabla\\chi\\right)','Gleichung aus Abschnitt 3.2.43.13: Transformiertes magnetisches Feld.','derived'),
('3.3379','Rotation eines Gradienten','\\nabla\\times\\nabla\\chi=\\mathbf{0}','\\nabla\\times\\nabla\\chi=\\mathbf{0}','Gleichung aus Abschnitt 3.2.43.13: Rotation eines Gradienten.','derived'),
('3.3380','Rückführung des magnetischen Feldes','\\mathbf{B}''=\\nabla\\times\\mathbf{A}=\\mathbf{B}','\\mathbf{B}''=\\nabla\\times\\mathbf{A}=\\mathbf{B}','Gleichung aus Abschnitt 3.2.43.13: Rückführung des magnetischen Feldes.','theorem'),
('3.3381','Bedingung der Eichäquivalenz','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Bedingung der Eichäquivalenz.','definition'),
('3.3382','Notation der Eichäquivalenz','A_\\mu\\sim A''_\\mu','A_\\mu\\sim A''_\\mu','Gleichung aus Abschnitt 3.2.43.13: Notation der Eichäquivalenz.','definition'),
('3.3383','Äquivalenzrelation der Potentiale','A_\\mu\\sim A''_\\mu','A_\\mu\\sim A''_\\mu','Gleichung aus Abschnitt 3.2.43.13: Äquivalenzrelation der Potentiale.','theorem'),
('3.3384','Null-Eichfunktion','\\chi=0','\\chi=0','Gleichung aus Abschnitt 3.2.43.13: Null-Eichfunktion.','derived'),
('3.3385','Reflexivität der Eichäquivalenz','A_\\mu=A_\\mu+\\partial_\\mu0','A_\\mu=A_\\mu+\\partial_\\mu0','Gleichung aus Abschnitt 3.2.43.13: Reflexivität der Eichäquivalenz.','derived'),
('3.3386','Ausgangsrelation der Symmetrie','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','A''_\\mu=A_\\mu+\\partial_\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Ausgangsrelation der Symmetrie.','derived'),
('3.3387','Umkehrung der Eichtransformation','A_\\mu=A''_\\mu+\\partial_\\mu(-\\chi)','A_\\mu=A''_\\mu+\\partial_\\mu(-\\chi)','Gleichung aus Abschnitt 3.2.43.13: Umkehrung der Eichtransformation.','derived'),
('3.3388','Erste Transformation der Transitivität','A''_\\mu=A_\\mu+\\partial_\\mu\\chi_1','A''_\\mu=A_\\mu+\\partial_\\mu\\chi_1','Gleichung aus Abschnitt 3.2.43.13: Erste Transformation der Transitivität.','derived'),
('3.3389','Zweite Transformation der Transitivität','A''''_\\mu=A''_\\mu+\\partial_\\mu\\chi_2','A''''_\\mu=A''_\\mu+\\partial_\\mu\\chi_2','Gleichung aus Abschnitt 3.2.43.13: Zweite Transformation der Transitivität.','derived'),
('3.3390','Komposition zweier Eichtransformationen','A''''_\\mu=A_\\mu+\\partial_\\mu\\left(\\chi_1+\\chi_2\\right)','A''''_\\mu=A_\\mu+\\partial_\\mu\\left(\\chi_1+\\chi_2\\right)','Gleichung aus Abschnitt 3.2.43.13: Komposition zweier Eichtransformationen.','theorem'),
('3.3391','Eichklasse eines Viererpotentials','[A_\\mu]=\\left\\{A_\\mu+\\partial_\\mu\\chi\\;\\middle|\\;\\chi\\in C^2\\right\\}','[A_\\mu]=\\left\\{A_\\mu+\\partial_\\mu\\chi\\;\\middle|\\;\\chi\\in C^2\\right\\}','Gleichung aus Abschnitt 3.2.43.13: Eichklasse eines Viererpotentials.','definition'),
('3.3392','Allgemeine Eichinvarianzbedingung','Q[A+\\partial\\chi]=Q[A]','Q[A+\\partial\\chi]=Q[A]','Gleichung aus Abschnitt 3.2.43.13: Allgemeine Eichinvarianzbedingung.','definition'),
('3.3393','Eichinvarianz des Feldtensors als Funktional','F_{\\mu\\nu}[A+\\partial\\chi]=F_{\\mu\\nu}[A]','F_{\\mu\\nu}[A+\\partial\\chi]=F_{\\mu\\nu}[A]','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianz des Feldtensors als Funktional.','theorem'),
('3.3394','Allgemeine Eichbedingung','G[A]=0','G[A]=0','Gleichung aus Abschnitt 3.2.43.13: Allgemeine Eichbedingung.','definition'),
('3.3395','Lorenz-Eichung','\\partial_\\mu A^\\mu=0','\\partial_\\mu A^\\mu=0','Gleichung aus Abschnitt 3.2.43.13: Lorenz-Eichung.','definition'),
('3.3396','Dreidimensionale Lorenz-Eichung','\\nabla\\cdot\\mathbf{A}+\\frac{1}{c^2}\\frac{\\partial\\phi}{\\partial t}=0','\\nabla\\cdot\\mathbf{A}+\\frac{1}{c^2}\\frac{\\partial\\phi}{\\partial t}=0','Gleichung aus Abschnitt 3.2.43.13: Dreidimensionale Lorenz-Eichung.','definition'),
('3.3397','Transformiertes Potential für Lorenz-Eichung','A''^\\mu=A^\\mu+\\partial^\\mu\\chi','A''^\\mu=A^\\mu+\\partial^\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Transformiertes Potential für Lorenz-Eichung.','derived'),
('3.3398','Divergenz des transformierten Potentials','\\partial_\\mu A''^\\mu=\\partial_\\mu A^\\mu+\\partial_\\mu\\partial^\\mu\\chi','\\partial_\\mu A''^\\mu=\\partial_\\mu A^\\mu+\\partial_\\mu\\partial^\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Divergenz des transformierten Potentials.','derived'),
('3.3399','D’Alembert-Operator','\\Box=\\partial_\\mu\\partial^\\mu','\\Box=\\partial_\\mu\\partial^\\mu','Gleichung aus Abschnitt 3.2.43.13: D’Alembert-Operator.','definition'),
('3.3400','Divergenz mit D’Alembert-Operator','\\partial_\\mu A''^\\mu=\\partial_\\mu A^\\mu+\\Box\\chi','\\partial_\\mu A''^\\mu=\\partial_\\mu A^\\mu+\\Box\\chi','Gleichung aus Abschnitt 3.2.43.13: Divergenz mit D’Alembert-Operator.','derived'),
('3.3401','Bestimmungsgleichung der Eichfunktion','\\Box\\chi=-\\partial_\\mu A^\\mu','\\Box\\chi=-\\partial_\\mu A^\\mu','Gleichung aus Abschnitt 3.2.43.13: Bestimmungsgleichung der Eichfunktion.','theorem'),
('3.3402','Erreichte Lorenz-Eichung','\\partial_\\mu A''^\\mu=0','\\partial_\\mu A''^\\mu=0','Gleichung aus Abschnitt 3.2.43.13: Erreichte Lorenz-Eichung.','theorem'),
('3.3403','Wellengleichung des Viererpotentials','\\Box A^\\nu=\\mu_0J^\\nu','\\Box A^\\nu=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.13: Wellengleichung des Viererpotentials.','theorem'),
('3.3404','Feldtensor aus dem Viererpotential','F^{\\mu\\nu}=\\partial^\\mu A^\\nu-\\partial^\\nu A^\\mu','F^{\\mu\\nu}=\\partial^\\mu A^\\nu-\\partial^\\nu A^\\mu','Gleichung aus Abschnitt 3.2.43.13: Feldtensor aus dem Viererpotential.','definition'),
('3.3405','Inhomogene Maxwell-Gleichung','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','\\partial_\\mu F^{\\mu\\nu}=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.13: Inhomogene Maxwell-Gleichung.','theorem'),
('3.3406','Einsetzung des Feldtensors','\\partial_\\mu\\left(\\partial^\\mu A^\\nu-\\partial^\\nu A^\\mu\\right)=\\mu_0J^\\nu','\\partial_\\mu\\left(\\partial^\\mu A^\\nu-\\partial^\\nu A^\\mu\\right)=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.13: Einsetzung des Feldtensors.','derived'),
('3.3407','Potentialgleichung vor Eichfixierung','\\Box A^\\nu-\\partial^\\nu\\left(\\partial_\\mu A^\\mu\\right)=\\mu_0J^\\nu','\\Box A^\\nu-\\partial^\\nu\\left(\\partial_\\mu A^\\mu\\right)=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.13: Potentialgleichung vor Eichfixierung.','derived'),
('3.3408','Lorenz-Bedingung im Beweis','\\partial_\\mu A^\\mu=0','\\partial_\\mu A^\\mu=0','Gleichung aus Abschnitt 3.2.43.13: Lorenz-Bedingung im Beweis.','derived'),
('3.3409','Entkoppelte Potentialgleichung','\\Box A^\\nu=\\mu_0J^\\nu','\\Box A^\\nu=\\mu_0J^\\nu','Gleichung aus Abschnitt 3.2.43.13: Entkoppelte Potentialgleichung.','theorem'),
('3.3410','Resteichtransformation','A''^\\mu=A^\\mu+\\partial^\\mu\\chi','A''^\\mu=A^\\mu+\\partial^\\mu\\chi','Gleichung aus Abschnitt 3.2.43.13: Resteichtransformation.','definition'),
('3.3411','Bedingung der Resteichfreiheit','\\Box\\chi=0','\\Box\\chi=0','Gleichung aus Abschnitt 3.2.43.13: Bedingung der Resteichfreiheit.','definition'),
('3.3412','Coulomb-Eichung','\\nabla\\cdot\\mathbf{A}=0','\\nabla\\cdot\\mathbf{A}=0','Gleichung aus Abschnitt 3.2.43.13: Coulomb-Eichung.','definition'),
('3.3413','Freie elektromagnetische Feldwirkung','S_{\\mathrm{Feld}}=-\\frac{1}{4\\mu_0}\\int F_{\\mu\\nu}F^{\\mu\\nu}\\,d^4x','S_{\\mathrm{Feld}}=-\\frac{1}{4\\mu_0}\\int F_{\\mu\\nu}F^{\\mu\\nu}\\,d^4x','Gleichung aus Abschnitt 3.2.43.13: Freie elektromagnetische Feldwirkung.','theorem'),
('3.3414','Eichinvarianz des Feldtensors in der Wirkung','F''_{\\mu\\nu}=F_{\\mu\\nu}','F''_{\\mu\\nu}=F_{\\mu\\nu}','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianz des Feldtensors in der Wirkung.','derived'),
('3.3415','Eichinvarianz der Feldwirkung','S''_{\\mathrm{Feld}}=S_{\\mathrm{Feld}}','S''_{\\mathrm{Feld}}=S_{\\mathrm{Feld}}','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianz der Feldwirkung.','theorem'),
('3.3416','Elektromagnetische Wechselwirkungswirkung','S_{\\mathrm{WW}}=-\\int J^\\mu A_\\mu\\,d^4x','S_{\\mathrm{WW}}=-\\int J^\\mu A_\\mu\\,d^4x','Gleichung aus Abschnitt 3.2.43.13: Elektromagnetische Wechselwirkungswirkung.','definition'),
('3.3417','Variation der Wechselwirkungswirkung','\\Delta S_{\\mathrm{WW}}=-\\int J^\\mu\\partial_\\mu\\chi\\,d^4x','\\Delta S_{\\mathrm{WW}}=-\\int J^\\mu\\partial_\\mu\\chi\\,d^4x','Gleichung aus Abschnitt 3.2.43.13: Variation der Wechselwirkungswirkung.','derived'),
('3.3418','Partielle Integration der Wirkungsvariation','\\Delta S_{\\mathrm{WW}}=-\\int\\partial_\\mu\\left(J^\\mu\\chi\\right)\\,d^4x+\\int\\chi\\,\\partial_\\mu J^\\mu\\,d^4x','\\Delta S_{\\mathrm{WW}}=-\\int\\partial_\\mu\\left(J^\\mu\\chi\\right)\\,d^4x+\\int\\chi\\,\\partial_\\mu J^\\mu\\,d^4x','Gleichung aus Abschnitt 3.2.43.13: Partielle Integration der Wirkungsvariation.','derived'),
('3.3419','Kontinuitätsgleichung','\\partial_\\mu J^\\mu=0','\\partial_\\mu J^\\mu=0','Gleichung aus Abschnitt 3.2.43.13: Kontinuitätsgleichung.','theorem'),
('3.3420','Verschwindende Wirkungsvariation','\\Delta S_{\\mathrm{WW}}=0','\\Delta S_{\\mathrm{WW}}=0','Gleichung aus Abschnitt 3.2.43.13: Verschwindende Wirkungsvariation.','theorem'),
('3.3421','Lokale Eichvariation der Wirkung','\\delta_\\chi S=\\int\\chi\\,\\partial_\\mu J^\\mu\\,d^4x','\\delta_\\chi S=\\int\\chi\\,\\partial_\\mu J^\\mu\\,d^4x','Gleichung aus Abschnitt 3.2.43.13: Lokale Eichvariation der Wirkung.','derived'),
('3.3422','Eichinvarianzbedingung der Wirkung','\\delta_\\chi S=0','\\delta_\\chi S=0','Gleichung aus Abschnitt 3.2.43.13: Eichinvarianzbedingung der Wirkung.','theorem'),
('3.3423','Lokale Ladungserhaltung','\\partial_\\mu J^\\mu=0','\\partial_\\mu J^\\mu=0','Gleichung aus Abschnitt 3.2.43.13: Lokale Ladungserhaltung.','theorem'),
('3.3424','Physikalischer Konfigurationsraum','\\mathcal{C}_{\\mathrm{phys}}=\\mathcal{A}/\\mathcal{G}','\\mathcal{C}_{\\mathrm{phys}}=\\mathcal{A}/\\mathcal{G}','Gleichung aus Abschnitt 3.2.43.13: Physikalischer Konfigurationsraum.','definition'),
('3.3425','Potentialdarstellung der Felder','\\mathbf{E}=-\\nabla\\phi-\\frac{\\partial\\mathbf{A}}{\\partial t},\\qquad\\mathbf{B}=\\nabla\\times\\mathbf{A}','\\mathbf{E}=-\\nabla\\phi-\\frac{\\partial\\mathbf{A}}{\\partial t},\\qquad\\mathbf{B}=\\nabla\\times\\mathbf{A}','Gleichung aus Abschnitt 3.2.43.13: Potentialdarstellung der Felder.','definition');

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex,
    word_latex, plain_description, equation_type,
    provenance, source_id, derivation, assumptions,
    validation_status, created_revision_id
)
SELECT
    t.equation_number, @section, t.title, t.equation_latex,
    t.word_latex, t.plain_description, t.equation_type,
    'literature', @src125,
    'Im Unterabschnitt 3.2.43.13 eingeführt oder aus Eichtransformation, Potentialdarstellung, Vertauschbarkeit partieller Ableitungen, Variationsprinzip und Kontinuitätsgleichung hergeleitet.',
    'Hinreichend differenzierbare Eichfunktion, konsistente Raum-Zeit-Konvention, geeignete Randbedingungen und lokale Lösbarkeit der jeweiligen Differentialgleichungen.',
    'verified', @revision
FROM tmp_eqs_324313 t
WHERE NOT EXISTS
(
    SELECT 1 FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_324313 t ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src125,
    e.derivation='Im Unterabschnitt 3.2.43.13 eingeführt oder aus Eichtransformation, Potentialdarstellung, Vertauschbarkeit partieller Ableitungen, Variationsprinzip und Kontinuitätsgleichung hergeleitet.',
    e.assumptions='Hinreichend differenzierbare Eichfunktion, konsistente Raum-Zeit-Konvention, geeignete Randbedingungen und lokale Lösbarkeit der jeweiligen Differentialgleichungen.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

-- Literaturverwendung
INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary,
    exact_location, is_first_mention, citation_checked,
    notes, created_revision_id
)
SELECT
    @src125, @section, 'first_citation',
    'Eichtransformation, Eichinvarianz des Feldtensors und der Felder, Eichäquivalenz, Lorenz- und Coulomb-Eichung, Resteichfreiheit, Eichinvarianz der Feld- und Wechselwirkungswirkung sowie Ladungserhaltung.',
    'Abschnitt 3.2.43.13', 1, 0,
    'Bibliografische Identität der Arbeitsquelle [125] vor der Endredaktion festlegen.',
    @revision
WHERE @src125 IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id=@src125
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.13'
);

-- Änderungsprotokoll
INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision, @section, 'updated', 'subsection',
    '3.2.43.13',
    'Unterabschnitt 3.2.43.13 vollständig in das Repository aufgenommen.',
    'Stand bis Definition 3.2.705, Satz 3.2.178 und Gleichung (3.3356).',
    '10 Definitionen, 8 Sätze und 69 Gleichungen bis (3.3425).'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.13'
);

-- Fortführungszähler
INSERT INTO repository_counters(counter_key,counter_value)
VALUES
    ('last_completed_section','3.2.43.13'),
    ('current_section','3.2.43.14'),
    ('last_definition_number','3.2.715'),
    ('next_definition_number','3.2.716'),
    ('last_theorem_number','3.2.186'),
    ('next_theorem_number','3.2.187'),
    ('last_equation_number','3.3425'),
    ('next_equation_number','3.3426'),
    ('last_citation_number','125'),
    ('next_citation_number','126')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_324313;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_324313;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_324313;

COMMIT;

-- Abschlussprüfungen
SELECT COUNT(*) AS definitionen_3_2_43_13
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 706 AND 715;

SELECT COUNT(*) AS saetze_3_2_43_13
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 179 AND 186;

SELECT COUNT(*) AS gleichungen_3_2_43_13
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3357 AND 3425;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_13
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3357 AND 3425
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT citation_number, source_key, title, verification_status
FROM sources
WHERE citation_number=125;

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
