USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* ###########################################################################
   FRZK-Repository – Ergänzung zu Abschnitt 3.2.43
   Unterabschnitt 3.2.43.5:
   Kausalstruktur und Klassifikation raumzeitlicher Intervalle

   Definitionen : 3.2.653–3.2.662
   Sätze        : 3.2.149–3.2.150
   Gleichungen  : (3.3116)–(3.3153)
   Literatur    : weiterhin [117]

   Voraussetzung:
   Das korrigierte Basisskript für 3.2.43 bis Gleichung (3.3115)
   wurde bereits importiert.
   ########################################################################### */

SET @parent_revision := (
    SELECT revision_id
    FROM repository_revisions
    WHERE scope_reference='3.2.43'
    ORDER BY revision_id DESC
    LIMIT 1
);

SET @section := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.43'
    LIMIT 1
);

SET @src117 := (
    SELECT source_id
    FROM sources
    WHERE citation_number=117
    LIMIT 1
);

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_frzk_check_32435_prerequisites$$
CREATE PROCEDURE sp_frzk_check_32435_prerequisites()
BEGIN
    IF @parent_revision IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Eine Revision für Abschnitt 3.2.43 fehlt.';
    END IF;

    IF @section IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Abschnitt 3.2.43 fehlt.';
    END IF;

    IF @src117 IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Abbruch: Literaturquelle [117] fehlt.';
    END IF;
END$$

CALL sp_frzk_check_32435_prerequisites()$$
DROP PROCEDURE sp_frzk_check_32435_prerequisites$$

DELIMITER ;

INSERT INTO repository_revisions
(
    revision_code,revision_date,scope_type,scope_reference,
    version_label,summary,created_by,parent_revision_id
)
VALUES
(
    'RKB-NEU-K3.2.43.5-V1',
    NOW(),
    'subsection',
    '3.2.43.5',
    '3.2.43.5-v1',
    'Kausalstruktur, Intervallklassen, Eigenzeit, Lichtkegel und Erhaltung der kausalen Ordnung.',
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
        'Ergänzt um 3.2.43.5: Kausalstruktur und Klassifikation raumzeitlicher Intervalle.'
    )
WHERE section_id=@section
  AND COALESCE(notes,'') NOT LIKE '%Ergänzt um 3.2.43.5:%';

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.653–3.2.662
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32435;
CREATE TEMPORARY TABLE tmp_defs_32435
(
    definition_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT NULL,
    word_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs_32435 VALUES
('3.2.653','Zeitartiges Intervall','Ein Raumzeitintervall heißt zeitartig, wenn sein Minkowski-Quadrat negativ ist.','\\Delta s^2<0','\\Delta s^2<0'),
('3.2.654','Raumartiges Intervall','Ein Raumzeitintervall heißt raumartig, wenn sein Minkowski-Quadrat positiv ist.','\\Delta s^2>0','\\Delta s^2>0'),
('3.2.655','Lichtartiges Intervall','Ein Raumzeitintervall heißt lichtartig oder nullartig, wenn sein Minkowski-Quadrat null ist.','\\Delta s^2=0','\\Delta s^2=0'),
('3.2.656','Räumlicher Abstand','Der räumliche Abstand zweier Ereignisse ist die euklidische Norm ihrer räumlichen Koordinatendifferenz.','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}'),
('3.2.657','Eigenzeit','Für zwei zeitartig getrennte Ereignisse ist die Eigenzeit durch das negative Minkowski-Quadrat des Intervalls definiert.','c^2\\Delta\\tau^2=-\\Delta s^2','c^2\\Delta\\tau^2=-\\Delta s^2'),
('3.2.658','Eigenzeit bei gleichförmiger Bewegung','Bei gleichförmiger Bewegung mit konstanter Geschwindigkeit v gilt Delta t = gamma Delta tau.','\\Delta t=\\gamma\\Delta\\tau','\\Delta t=\\gamma\\Delta\\tau'),
('3.2.659','Lichtkegel','Die Menge aller lichtartig vom Ursprung getrennten Ereignisse wird als Lichtkegel bezeichnet.','c^2t^2=x^2+y^2+z^2','c^2t^2=x^2+y^2+z^2'),
('3.2.660','Zukunftslichtkegel','Der Zukunftslichtkegel umfasst alle zeitartigen oder lichtartigen Ereignisse, die zeitlich nach dem Ausgangsereignis liegen.','t>0,\\qquad r\\leq ct','t>0,\\qquad r\\leq ct'),
('3.2.661','Vergangenheitslichtkegel','Der Vergangenheitslichtkegel umfasst alle zeitartigen oder lichtartigen Ereignisse, die zeitlich vor dem Ausgangsereignis liegen.','t<0,\\qquad r\\leq c|t|','t<0,\\qquad r\\leq c|t|'),
('3.2.662','Kausal nicht erreichbarer Bereich','Alle Ereignisse außerhalb des Lichtkegels sind vom Ursprung raumartig getrennt und kausal nicht erreichbar.','r>c|t|','r>c|t|');

INSERT INTO definitions
(
    definition_number,section_id,title,definition_text,
    formal_latex,word_latex,provenance,source_id,
    assumptions,notes,validation_status,created_revision_id
)
SELECT
    t.definition_number,@section,t.title,t.definition_text,
    t.formal_latex,t.word_latex,'literature',@src117,
    'Minkowski-Raum mit Signatur (-,+,+,+) und Lorentz-Invarianz gemäß Abschnitt 3.2.43.',
    'Definition aus Unterabschnitt 3.2.43.5.',
    'verified',@revision
FROM tmp_defs_32435 t
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions d
    WHERE d.definition_number=t.definition_number
);

UPDATE definitions d
JOIN tmp_defs_32435 t
    ON t.definition_number=d.definition_number
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.word_latex,
    d.provenance='literature',
    d.source_id=@src117,
    d.assumptions='Minkowski-Raum mit Signatur (-,+,+,+) und Lorentz-Invarianz gemäß Abschnitt 3.2.43.',
    d.notes='Definition aus Unterabschnitt 3.2.43.5.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Sätze 3.2.149–3.2.150
-- Schemahinweis: Die Tabelle `theorems` besitzt kein Feld `proof_text`.
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_thms_32435;
CREATE TEMPORARY TABLE tmp_thms_32435
(
    theorem_number VARCHAR(50) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms_32435 VALUES
('3.2.149','Lorentz-Invarianz der Intervallklasse','Die Einordnung eines Raumzeitintervalls als zeitartig, raumartig oder lichtartig bleibt unter jeder Lorentz-Transformation erhalten.','\\Delta s''^2=\\Delta s^2'),
('3.2.150','Erhaltung der kausalen Ordnung zeitartig getrennter Ereignisse','Die zeitliche Reihenfolge zweier zeitartig getrennter Ereignisse bleibt unter eigentlichen, orthochronen Lorentz-Transformationen erhalten.','\\operatorname{sgn}(\\Delta t'')=\\operatorname{sgn}(\\Delta t)');

INSERT INTO theorems
(
    theorem_number,section_id,title,statement_text,
    statement_latex,word_latex,provenance,source_id,
    assumptions,validation_status,created_revision_id
)
SELECT
    t.theorem_number,@section,t.title,t.statement_text,
    t.statement_latex,t.statement_latex,'literature',@src117,
    'Lorentz-Invarianz des Minkowski-Intervalls; für Satz 3.2.150 zusätzlich eigentliche orthochrone Lorentz-Transformation.',
    'verified',@revision
FROM tmp_thms_32435 t
WHERE NOT EXISTS
(
    SELECT 1 FROM theorems th
    WHERE th.theorem_number=t.theorem_number
);

UPDATE theorems th
JOIN tmp_thms_32435 t
    ON t.theorem_number=th.theorem_number
SET
    th.section_id=@section,
    th.title=t.title,
    th.statement_text=t.statement_text,
    th.statement_latex=t.statement_latex,
    th.word_latex=t.statement_latex,
    th.provenance='literature',
    th.source_id=@src117,
    th.assumptions='Lorentz-Invarianz des Minkowski-Intervalls; für Satz 3.2.150 zusätzlich eigentliche orthochrone Lorentz-Transformation.',
    th.validation_status='verified',
    th.created_revision_id=COALESCE(th.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Gleichungen (3.3116)–(3.3153)
-- ---------------------------------------------------------------------------

DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32435;
CREATE TEMPORARY TABLE tmp_eqs_32435
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

INSERT INTO tmp_eqs_32435 VALUES
('3.3116','Differenzvektor zweier Ereignisse','\\Delta x^\\mu=x_Q^\\mu-x_P^\\mu','\\Delta x^\\mu=x_Q^\\mu-x_P^\\mu','Formale Gleichung aus Abschnitt 3.2.43.5: Differenzvektor zweier Ereignisse.','definition'),
('3.3117','Komponenten des Differenzvektors','\\Delta x^\\mu=\\begin{pmatrix}c\\Delta t\\\\\\Delta x\\\\\\Delta y\\\\\\Delta z\\end{pmatrix}','\\Delta x^\\mu=\\begin{pmatrix}c\\Delta t\\Delta x\\Delta y\\Delta z\\ \\end{pmatrix}','Formale Gleichung aus Abschnitt 3.2.43.5: Komponenten des Differenzvektors.','definition'),
('3.3118','Minkowski-Quadrat des Differenzvektors','\\Delta s^2=-c^2\\Delta t^2+\\Delta x^2+\\Delta y^2+\\Delta z^2','\\Delta s^2=-c^2\\Delta t^2+\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Minkowski-Quadrat des Differenzvektors.','metric'),
('3.3119','Minkowski-Signatur','\\eta=\\operatorname{diag}(-1,1,1,1)','\\eta=\\operatorname{diag}(-1,1,1,1)','Formale Gleichung aus Abschnitt 3.2.43.5: Minkowski-Signatur.','definition'),
('3.3120','Bedingung für ein zeitartiges Intervall','\\Delta s^2<0','\\Delta s^2<0','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung für ein zeitartiges Intervall.','definition'),
('3.3121','Äquivalente Zeitartigkeitsbedingung','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Äquivalente Zeitartigkeitsbedingung.','derived'),
('3.3122','Bedingung für ein raumartiges Intervall','\\Delta s^2>0','\\Delta s^2>0','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung für ein raumartiges Intervall.','definition'),
('3.3123','Äquivalente Raumartigkeitsbedingung','\\Delta x^2+\\Delta y^2+\\Delta z^2>c^2\\Delta t^2','\\Delta x^2+\\Delta y^2+\\Delta z^2>c^2\\Delta t^2','Formale Gleichung aus Abschnitt 3.2.43.5: Äquivalente Raumartigkeitsbedingung.','derived'),
('3.3124','Bedingung für ein lichtartiges Intervall','\\Delta s^2=0','\\Delta s^2=0','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung für ein lichtartiges Intervall.','definition'),
('3.3125','Äquivalente Lichtartigkeitsbedingung','c^2\\Delta t^2=\\Delta x^2+\\Delta y^2+\\Delta z^2','c^2\\Delta t^2=\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Äquivalente Lichtartigkeitsbedingung.','derived'),
('3.3126','Räumlicher Abstand','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}','\\Delta r=\\sqrt{\\Delta x^2+\\Delta y^2+\\Delta z^2}','Formale Gleichung aus Abschnitt 3.2.43.5: Räumlicher Abstand.','definition'),
('3.3127','Kompakte Intervallform','\\Delta s^2=\\Delta r^2-c^2\\Delta t^2','\\Delta s^2=\\Delta r^2-c^2\\Delta t^2','Formale Gleichung aus Abschnitt 3.2.43.5: Kompakte Intervallform.','metric'),
('3.3128','Invarianz des Differenzintervalls','\\Delta s''^2=\\Delta s^2','\\Delta s''^2=\\Delta s^2','Formale Gleichung aus Abschnitt 3.2.43.5: Invarianz des Differenzintervalls.','theorem'),
('3.3129','Zeitartigkeit im Ausgangssystem','\\Delta s^2<0','\\Delta s^2<0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitartigkeit im Ausgangssystem.','derived'),
('3.3130','Zeitartigkeit im transformierten System','\\Delta s''^2<0','\\Delta s''^2<0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitartigkeit im transformierten System.','derived'),
('3.3131','Erhaltung der Raumartigkeit','\\Delta s^2>0\\Longrightarrow\\Delta s''^2>0','\\Delta s^2>0\\Longrightarrow\\Delta s''^2>0','Formale Gleichung aus Abschnitt 3.2.43.5: Erhaltung der Raumartigkeit.','theorem'),
('3.3132','Erhaltung der Lichtartigkeit','\\Delta s^2=0\\Longrightarrow\\Delta s''^2=0','\\Delta s^2=0\\Longrightarrow\\Delta s''^2=0','Formale Gleichung aus Abschnitt 3.2.43.5: Erhaltung der Lichtartigkeit.','theorem'),
('3.3133','Definition der Eigenzeit','c^2\\Delta\\tau^2=-\\Delta s^2','c^2\\Delta\\tau^2=-\\Delta s^2','Formale Gleichung aus Abschnitt 3.2.43.5: Definition der Eigenzeit.','definition'),
('3.3134','Eigenzeit in Koordinatendifferenzen','c^2\\Delta\\tau^2=c^2\\Delta t^2-\\Delta x^2-\\Delta y^2-\\Delta z^2','c^2\\Delta\\tau^2=c^2\\Delta t^2-\\Delta x^2-\\Delta y^2-\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Eigenzeit in Koordinatendifferenzen.','derived'),
('3.3135','Quadrat der Eigenzeit','\\Delta\\tau^2=\\Delta t^2-\\frac{\\Delta x^2+\\Delta y^2+\\Delta z^2}{c^2}','\\Delta\\tau^2=\\Delta t^2-\\frac{\\Delta x^2+\\Delta y^2+\\Delta z^2}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.5: Quadrat der Eigenzeit.','derived'),
('3.3136','Räumliche Wegdifferenz bei gleichförmiger Bewegung','\\Delta r=v\\Delta t','\\Delta r=v\\Delta t','Formale Gleichung aus Abschnitt 3.2.43.5: Räumliche Wegdifferenz bei gleichförmiger Bewegung.','definition'),
('3.3137','Einsetzen der gleichförmigen Bewegung','\\Delta\\tau^2=\\Delta t^2-\\frac{v^2\\Delta t^2}{c^2}','\\Delta\\tau^2=\\Delta t^2-\\frac{v^2\\Delta t^2}{c^2}','Formale Gleichung aus Abschnitt 3.2.43.5: Einsetzen der gleichförmigen Bewegung.','derived'),
('3.3138','Ausgeklammerte Eigenzeitbeziehung','\\Delta\\tau^2=\\Delta t^2\\left(1-\\frac{v^2}{c^2}\\right)','\\Delta\\tau^2=\\Delta t^2\\left(1-\\frac{v^2}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43.5: Ausgeklammerte Eigenzeitbeziehung.','derived'),
('3.3139','Eigenzeit-Zeit-Beziehung','\\Delta\\tau=\\Delta t\\sqrt{1-\\frac{v^2}{c^2}}','\\Delta\\tau=\\Delta t\\sqrt{1-\\frac{v^2}{c^2}}','Formale Gleichung aus Abschnitt 3.2.43.5: Eigenzeit-Zeit-Beziehung.','derived'),
('3.3140','Zeitdilatationsform','\\Delta t=\\gamma\\Delta\\tau','\\Delta t=\\gamma\\Delta\\tau','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitdilatationsform.','theorem'),
('3.3141','Gleichung des Lichtkegels','c^2t^2=x^2+y^2+z^2','c^2t^2=x^2+y^2+z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Gleichung des Lichtkegels.','definition'),
('3.3142','Radiale Lichtkegelgleichung','r=c|t|','r=c|t|','Formale Gleichung aus Abschnitt 3.2.43.5: Radiale Lichtkegelgleichung.','derived'),
('3.3143','Zeitbedingung des Zukunftslichtkegels','t>0','t>0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitbedingung des Zukunftslichtkegels.','definition'),
('3.3144','Räumliche Bedingung des Zukunftslichtkegels','r\\leq ct','r\\leq ct','Formale Gleichung aus Abschnitt 3.2.43.5: Räumliche Bedingung des Zukunftslichtkegels.','definition'),
('3.3145','Zeitbedingung des Vergangenheitslichtkegels','t<0','t<0','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitbedingung des Vergangenheitslichtkegels.','definition'),
('3.3146','Räumliche Bedingung des Vergangenheitslichtkegels','r\\leq c|t|','r\\leq c|t|','Formale Gleichung aus Abschnitt 3.2.43.5: Räumliche Bedingung des Vergangenheitslichtkegels.','definition'),
('3.3147','Bedingung des kausal nicht erreichbaren Bereichs','r>c|t|','r>c|t|','Formale Gleichung aus Abschnitt 3.2.43.5: Bedingung des kausal nicht erreichbaren Bereichs.','definition'),
('3.3148','Zeitartigkeitsbedingung im Ordnungsbeweis','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','c^2\\Delta t^2>\\Delta x^2+\\Delta y^2+\\Delta z^2','Formale Gleichung aus Abschnitt 3.2.43.5: Zeitartigkeitsbedingung im Ordnungsbeweis.','derived'),
('3.3149','Abschätzung der longitudinalen Trennung','c|\\Delta t|>|\\Delta x|','c|\\Delta t|>|\\Delta x|','Formale Gleichung aus Abschnitt 3.2.43.5: Abschätzung der longitudinalen Trennung.','derived'),
('3.3150','Transformierte Zeitdifferenz','\\Delta t''=\\gamma\\left(\\Delta t-\\frac{v\\Delta x}{c^2}\\right)','\\Delta t''=\\gamma\\left(\\Delta t-\\frac{v\\Delta x}{c^2}\\right)','Formale Gleichung aus Abschnitt 3.2.43.5: Transformierte Zeitdifferenz.','derived'),
('3.3151','Abschätzung des Korrekturterms','\\left|\\frac{v\\Delta x}{c^2}\\right|<\\frac{|\\Delta x|}{c}','\\left|\\frac{v\\Delta x}{c^2}\\right|<\\frac{|\\Delta x|}{c}','Formale Gleichung aus Abschnitt 3.2.43.5: Abschätzung des Korrekturterms.','derived'),
('3.3152','Vergleich mit der Zeitdifferenz','\\frac{|\\Delta x|}{c}<|\\Delta t|','\\frac{|\\Delta x|}{c}<|\\Delta t|','Formale Gleichung aus Abschnitt 3.2.43.5: Vergleich mit der Zeitdifferenz.','derived'),
('3.3153','Positivität des Lorentz-Faktors','\\gamma>0','\\gamma>0','Formale Gleichung aus Abschnitt 3.2.43.5: Positivität des Lorentz-Faktors.','derived');

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    t.equation_number,@section,t.title,t.equation_latex,t.word_latex,
    t.plain_description,t.equation_type,'literature',@src117,
    'Im Unterabschnitt 3.2.43.5 eingeführt oder hergeleitet.',
    'Minkowski-Raum mit Signatur (-,+,+,+), Lorentz-Invarianz und |v|<c.',
    'verified',@revision
FROM tmp_eqs_32435 t
WHERE NOT EXISTS
(
    SELECT 1 FROM equations e
    WHERE e.equation_number=t.equation_number
);

UPDATE equations e
JOIN tmp_eqs_32435 t
    ON t.equation_number=e.equation_number
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.equation_latex,
    e.word_latex=t.word_latex,
    e.plain_description=t.plain_description,
    e.equation_type=t.equation_type,
    e.provenance='literature',
    e.source_id=@src117,
    e.derivation='Im Unterabschnitt 3.2.43.5 eingeführt oder hergeleitet.',
    e.assumptions='Minkowski-Raum mit Signatur (-,+,+,+), Lorentz-Invarianz und |v|<c.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision);

-- ---------------------------------------------------------------------------
-- Literaturverwendung
-- ---------------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    @src117,@section,'supporting_citation',
    'Intervallklassen, Eigenzeit, Lichtkegel und kausale Ordnung unter Lorentz-Transformationen.',
    'Abschnitt 3.2.43.5',
    0,0,
    'Quelle [117] bleibt die verwendete Primärquelle; genaue Seitenangabe vor Endredaktion prüfen.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1 FROM source_usage
    WHERE source_id=@src117
      AND section_id=@section
      AND exact_location='Abschnitt 3.2.43.5'
);

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll und Zähler
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,
    object_reference,change_summary,previous_value,new_value
)
SELECT
    @revision,@section,'updated','subsection','3.2.43.5',
    'Unterabschnitt 3.2.43.5 in das Repository aufgenommen.',
    'Stand bis Gleichung (3.3115).',
    'Zusätzlich 10 Definitionen, 2 Sätze und 38 Gleichungen bis (3.3153).'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
      AND object_reference='3.2.43.5'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.43.5'),
('current_section','3.2.43.6'),
('last_definition_number','3.2.662'),
('next_definition_number','3.2.663'),
('last_theorem_number','3.2.150'),
('next_theorem_number','3.2.151'),
('last_equation_number','3.3153'),
('next_equation_number','3.3154'),
('last_citation_number','117'),
('next_citation_number','118')
ON DUPLICATE KEY UPDATE
    counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs_32435;
DROP TEMPORARY TABLE IF EXISTS tmp_thms_32435;
DROP TEMPORARY TABLE IF EXISTS tmp_eqs_32435;

COMMIT;

-- ---------------------------------------------------------------------------
-- Abschlussprüfung
-- Erwartet für 3.2.43.5:
-- 10 Definitionen, 2 Sätze, 38 Gleichungen, keine leeren Word-LaTeX-Felder.
-- Gesamtstand 3.2.43:
-- 25 Definitionen, 6 Sätze, 88 Gleichungen.
-- ---------------------------------------------------------------------------

SELECT COUNT(*) AS definitionen_3_2_43_5
FROM definitions
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
      BETWEEN 653 AND 662;

SELECT COUNT(*) AS saetze_3_2_43_5
FROM theorems
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
      BETWEEN 149 AND 150;

SELECT COUNT(*) AS gleichungen_3_2_43_5
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3116 AND 3153;

SELECT COUNT(*) AS fehlende_word_latex_3_2_43_5
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 3116 AND 3153
  AND (word_latex IS NULL OR TRIM(word_latex)='');

SELECT
    (SELECT COUNT(*) FROM definitions
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED)
           BETWEEN 638 AND 662) AS definitionen_gesamt_3_2_43,
    (SELECT COUNT(*) FROM theorems
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED)
           BETWEEN 145 AND 150) AS saetze_gesamt_3_2_43,
    (SELECT COUNT(*) FROM equations
     WHERE section_id=@section
       AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
           BETWEEN 3066 AND 3153) AS gleichungen_gesamt_3_2_43;

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
