/* ============================================================
   FRZK Repository-Update
   Kapitel 3.8.5 – Auswertungskriterien und Bewertungsmetriken
   Version 1.0

   Aufbauend auf:
   - RKB-K3.8.4-V1
   - Gleichungsstand nach Abschnitt 3.8.4: (3.1290)
   - Literaturstand nach Abschnitt 3.8.4: [115]

   Zuordnung Manuskript -> Repository:
   (3.503)–(3.519) -> (3.1291)–(3.1307)

   Das Skript ist idempotent.
   ============================================================ */

START TRANSACTION;

/* ============================================================
   1. Grundvariablen und Vorbedingungen
   ============================================================ */

SET @revision_code := 'RKB-K3.8.5-V1';

SET @parent_section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8'
    LIMIT 1
);

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code IN
    (
        'RKB-K3.8.4-V1',
        'RKB-K3.8.3-V1',
        'RKB-K3.8.2-V2',
        'RKB-K3.8.2-V1',
        'RKB-K3.8.1-V1',
        'RKB-K3.8-V1'
    )
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.4-V1' THEN 1
            WHEN 'RKB-K3.8.3-V1' THEN 2
            WHEN 'RKB-K3.8.2-V2' THEN 3
            WHEN 'RKB-K3.8.2-V1' THEN 4
            WHEN 'RKB-K3.8.1-V1' THEN 5
            WHEN 'RKB-K3.8-V1' THEN 6
            ELSE 7
        END
    LIMIT 1
);

SET @precheck_parent :=
(
    SELECT COUNT(*)
    FROM dissertation_sections
    WHERE section_code = '3.8'
);

/* ============================================================
   2. Repository-Revision
   ============================================================ */

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
    @revision_code,
    NOW(),
    'section',
    '3.8.5',
    '1.0',
    'Abschnitt 3.8.5 Auswertungskriterien und Bewertungsmetriken: Bewertungsvektor, Kohärenz, Konvergenz, Robustheit, Sensitivität, Validität, Emergenz, Gesamtindex und Klassifikation.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @precheck_parent = 1
  AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = @revision_code
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = @revision_code
    LIMIT 1
);

/* ============================================================
   3. Abschnitt 3.8.5
   ============================================================ */

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
    '3.8.5',
    'Auswertungskriterien und Bewertungsmetriken',
    3,
    3.8500,
    'draft',
    1,
    'Formales Bewertungssystem für Simulationen der Operatorenkaskade. Manuskriptgleichungen (3.503) bis (3.519) werden repositoryseitig als (3.1291) bis (3.1307) geführt.'
WHERE @parent_section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.5'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Auswertungskriterien und Bewertungsmetriken',
    chapter_no = 3,
    section_order = 3.8500,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Formales Bewertungssystem für Simulationen der Operatorenkaskade. Manuskriptgleichungen (3.503) bis (3.519) werden repositoryseitig als (3.1291) bis (3.1307) geführt.'
WHERE section_code = '3.8.5';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.5'
    LIMIT 1
);

/* ============================================================
   4. Literaturquellen [116] und [117]
   ============================================================ */

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
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
    116,
    'bankes_exploratory_modeling_1993',
    'journal_article',
    'Exploratory Modeling for Policy Analysis',
    NULL,
    1993,
    1993,
    'Operations Research',
    'INFORMS',
    NULL,
    '41',
    '3',
    '435-449',
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'journal_article',
    8,
    'bibliographic',
    '3.8.5',
    'Erstnennung im Zusammenhang mit explorativer Modellbewertung und der Interpretation mehrerer Simulationsszenarien.',
    'Bankes, Steven C. (1993): Exploratory Modeling for Policy Analysis. Operations Research, 41(3), 435-449.',
    'Bankes (1993) [116]',
    'Quelle wurde entsprechend der im Abschnitt verwendeten bibliografischen Angabe aufgenommen.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 116
       OR source_key = 'bankes_exploratory_modeling_1993'
);

INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    subtitle,
    year_original,
    year_edition,
    journal,
    publisher,
    place,
    volume,
    issue,
    pages,
    edition,
    doi,
    isbn,
    url,
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
    117,
    'helton_davis_sampling_uncertainty_2002',
    'journal_article',
    'Illustration of Sampling-Based Methods for Uncertainty and Sensitivity Analysis',
    NULL,
    2002,
    2002,
    'Risk Analysis',
    NULL,
    NULL,
    '22',
    '3',
    '591-622',
    NULL,
    NULL,
    NULL,
    NULL,
    'en',
    1,
    'journal_article',
    9,
    'bibliographic',
    '3.8.5',
    'Erstnennung im Zusammenhang mit Unsicherheits- und Sensitivitätsbewertung simulationsbasierter Modelle.',
    'Helton, Jon C.; Davis, Floyd J. (2002): Illustration of Sampling-Based Methods for Uncertainty and Sensitivity Analysis. Risk Analysis, 22(3), 591-622.',
    'Helton und Davis (2002) [117]',
    'Quelle wurde entsprechend der im Abschnitt verwendeten bibliografischen Angabe aufgenommen.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 117
       OR source_key = 'helton_davis_sampling_uncertainty_2002'
);

SET @source_116 := (SELECT source_id FROM sources WHERE citation_number = 116 LIMIT 1);
SET @source_117 := (SELECT source_id FROM sources WHERE citation_number = 117 LIMIT 1);

/* ============================================================
   5. Autoren und Quelle-Autor-Verknüpfungen
   ============================================================ */

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    orcid,
    birth_year,
    death_year,
    notes
)
SELECT
    'Bankes',
    'Steven C.',
    'Bankes, Steven C.',
    NULL,
    NULL,
    NULL,
    'Autor der Quelle [116].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Bankes, Steven C.'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    orcid,
    birth_year,
    death_year,
    notes
)
SELECT
    'Helton',
    'Jon C.',
    'Helton, Jon C.',
    NULL,
    NULL,
    NULL,
    'Erster Autor der Quelle [117].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Helton, Jon C.'
);

INSERT INTO authors
(
    family_name,
    given_names,
    normalized_name,
    orcid,
    birth_year,
    death_year,
    notes
)
SELECT
    'Davis',
    'Floyd J.',
    'Davis, Floyd J.',
    NULL,
    NULL,
    NULL,
    'Zweiter Autor der Quelle [117].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Davis, Floyd J.'
);

SET @author_bankes := (SELECT author_id FROM authors WHERE normalized_name = 'Bankes, Steven C.' LIMIT 1);
SET @author_helton := (SELECT author_id FROM authors WHERE normalized_name = 'Helton, Jon C.' LIMIT 1);
SET @author_davis  := (SELECT author_id FROM authors WHERE normalized_name = 'Davis, Floyd J.' LIMIT 1);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_116,@author_bankes,1,'author'
WHERE @source_116 IS NOT NULL
  AND @author_bankes IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id=@source_116 AND author_order=1 AND role='author'
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_117,@author_helton,1,'author'
WHERE @source_117 IS NOT NULL
  AND @author_helton IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id=@source_117 AND author_order=1 AND role='author'
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_117,@author_davis,2,'author'
WHERE @source_117 IS NOT NULL
  AND @author_davis IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id=@source_117 AND author_order=2 AND role='author'
);

/* ============================================================
   6. Quellenverwendungen
   ============================================================ */

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
    x.source_id,
    @section_id,
    x.usage_type,
    x.claim_summary,
    x.exact_location,
    1,
    1,
    x.notes,
    @revision_id
FROM
(
    SELECT
        @source_116 source_id,
        'first_citation' usage_type,
        'Explorative Modellierung unterstützt die vergleichende Beurteilung mehrerer plausibler Simulationsverläufe, ohne eine einzelne Parametrisierung vorschnell als endgültige Prognose zu behandeln.' claim_summary,
        '3.8.5, allgemeine Einordnung des Bewertungssystems' exact_location,
        'Erstverwendung der Quelle [116].' notes

    UNION ALL SELECT
        @source_117,
        'first_citation',
        'Sampling-basierte Unsicherheits- und Sensitivitätsanalysen bilden eine methodische Grundlage für die Bewertung parameterabhängiger Simulationsergebnisse.',
        '3.8.5, Robustheits- und Sensitivitätsbewertung',
        'Erstverwendung der Quelle [117].'
) x
WHERE x.source_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage su
    WHERE su.source_id = x.source_id
      AND su.section_id = @section_id
      AND su.usage_type = x.usage_type
      AND COALESCE(su.exact_location,'') = COALESCE(x.exact_location,'')
);

/* ============================================================
   7. Definitionen
   ============================================================ */

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
    x.definition_number,
    @section_id,
    x.title,
    x.definition_text,
    x.formal_latex,
    x.word_latex,
    x.provenance,
    x.source_id,
    x.assumptions,
    x.notes,
    'draft',
    @revision_id
FROM
(
    SELECT
        '3.8.5.1' definition_number,
        'Bewertungsvektor' title,
        'Der Bewertungsvektor fasst Kohärenz, Konvergenz, Robustheit, Sensitivität, Validität und Emergenz eines Simulationslaufs zusammen.' definition_text,
        '\\mathbf{B}=\\left(K,C,R,S,V,E\\right)' formal_latex,
        '\\mathbf{B}=\\left(K,C,R,S,V,E\\right)' word_latex,
        'original' provenance,
        NULL source_id,
        'Alle sechs Bewertungsgrößen sind definiert oder als nicht auswertbar gekennzeichnet.' assumptions,
        'Übergeordnete Zusammenfassung der Bewertungsmetriken.' notes

    UNION ALL SELECT
        '3.8.5.2',
        'Robustheitsmaß',
        'Das Robustheitsmaß bewertet die Unempfindlichkeit einer Trajektorie gegenüber einer festgelegten kleinen Änderung der Eingangsbedingungen.',
        'R=1-\\frac{d_\\Gamma(\\Gamma,\\Gamma^{(\\delta)})}{d_{\\max}}',
        'R=1-\\frac{d_\\Gamma(\\Gamma,\\Gamma^{(\\delta)})}{d_{\\max}}',
        'original',
        @source_117,
        'Der Trajektorienabstand ist normiert und d_max ist positiv.',
        'Hohe Werte kennzeichnen geringe Abweichung.'

    UNION ALL SELECT
        '3.8.5.3',
        'Sensitivitätsmaß',
        'Das Sensitivitätsmaß beschreibt die Trajektorienänderung pro Größe der zugrunde liegenden Parameteränderung.',
        'S=\\frac{d_\\Gamma(\\Gamma,\\Gamma+\\Delta\\Gamma)}{\\|\\Delta\\Theta\\|}',
        'S=\\frac{d_\\Gamma(\\Gamma,\\Gamma+\\Delta\\Gamma)}{\\|\\Delta\\Theta\\|}',
        'adapted',
        @source_117,
        'Die Parameteränderung ist von null verschieden.',
        'Große Werte kennzeichnen empfindliche Parameterbereiche.'

    UNION ALL SELECT
        '3.8.5.4',
        'Formale Validität',
        'Die formale Validität ist genau dann eins, wenn die Parametrisierung innerhalb des zulässigen Parameterraums liegt.',
        'V=\\begin{cases}1,&\\Theta\\in\\Omega_\\Theta\\\\0,&\\Theta\\notin\\Omega_\\Theta\\end{cases}',
        'V=\\begin{cases}1,&\\Theta\\in\\Omega_\\Theta\\\\0,&\\Theta\\notin\\Omega_\\Theta\\end{cases}',
        'original',
        NULL,
        'Omega_Theta ist vollständig festgelegt.',
        'Ungültige Simulationen werden nicht wissenschaftlich interpretiert.'

    UNION ALL SELECT
        '3.8.5.5',
        'Emergenzmaß',
        'Das Emergenzmaß beschreibt die zeitbezogene Veränderung des Organisationsgrades.',
        'E=\\frac{\\Delta O}{\\Delta t}',
        'E=\\frac{\\Delta O}{\\Delta t}',
        'original',
        NULL,
        'Der Organisationsgrad O und das Zeitintervall sind definiert.',
        'Eine Emergenzschwelle wird gesondert festgelegt.'

    UNION ALL SELECT
        '3.8.5.6',
        'Gesamtqualitätsindex',
        'Der Gesamtqualitätsindex ist die gewichtete Summe der sechs Bewertungsgrößen.',
        'Q=w_KK+w_CC+w_RR+w_SS+w_VV+w_EE',
        'Q=w_KK+w_CC+w_RR+w_SS+w_VV+w_EE',
        'original',
        @source_116,
        'Die Gewichtungen sind nichtnegativ, summieren sich zu eins und die Metriken sind vergleichbar skaliert.',
        'Die konkrete Gewichtung muss vor der Ergebnisinterpretation festgelegt werden.'
) x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number = x.definition_number
);

/* ============================================================
   8. Gleichungen (3.1291) bis (3.1307)
   ============================================================ */

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
    x.equation_number,
    @section_id,
    x.title,
    x.equation_latex,
    x.word_latex,
    x.plain_description,
    x.equation_type,
    x.provenance,
    x.source_id,
    x.derivation,
    x.assumptions,
    'draft',
    @revision_id
FROM
(
    SELECT
        '3.1291' equation_number,
        'Bewertungsvektor' title,
        '\\mathbf{B}=\\left(K,C,R,S,V,E\\right)' equation_latex,
        '\\mathbf{B}=\\left(K,C,R,S,V,E\\right)' word_latex,
        'Zusammenfassung der sechs Bewertungsgrößen.' plain_description,
        'definition' equation_type,
        'original' provenance,
        NULL source_id,
        'Zusammenführung der Einzelmetriken.' derivation,
        'Alle Komponenten sind definiert.' assumptions

    UNION ALL SELECT
        '3.1292','Kohärenzbewertung',
        'K=K(S_T)','K=K(S_T)',
        'Bewertung der Kohärenz des Endzustands.',
        'metric','original',NULL,
        'Anwendung der Kohärenzfunktion auf den letzten Zustand.',
        'S_T ist auswertbar.'

    UNION ALL SELECT
        '3.1293','Normierter Kohärenzbereich',
        '0\\le K\\le1','0\\le K\\le1',
        'Normierungsbereich der Kohärenz.',
        'constraint','original',NULL,
        'Festlegung eines dimensionslosen Vergleichsbereichs.',
        'Die Kohärenzfunktion ist entsprechend normiert.'

    UNION ALL SELECT
        '3.1294','Konvergenzmaß',
        'C=1-\\frac{\\|S_T-S_{T-1}\\|}{\\|S_1-S_0\\|}',
        'C=1-\\frac{\\|S_T-S_{T-1}\\|}{\\|S_1-S_0\\|}',
        'Relative Verminderung der Zustandsänderung gegenüber dem ersten Übergang.',
        'metric','original',NULL,
        'Normierung der letzten Zustandsänderung durch die anfängliche Zustandsänderung.',
        'Der Nenner ist von null verschieden.'

    UNION ALL SELECT
        '3.1295','Konvergenzkriterium',
        'C\\approx1','C\\approx1',
        'Näherungsweise vollständige Konvergenz.',
        'criterion','original',NULL,
        'Bewertung eines hohen Konvergenzwerts.',
        'Die verwendete Näherungstoleranz ist dokumentiert.'

    UNION ALL SELECT
        '3.1296','Robustheitsmaß',
        'R=1-\\frac{d_\\Gamma(\\Gamma,\\Gamma^{(\\delta)})}{d_{\\max}}',
        'R=1-\\frac{d_\\Gamma(\\Gamma,\\Gamma^{(\\delta)})}{d_{\\max}}',
        'Normierter Abstand zwischen Referenz- und Störungstrajektorie.',
        'metric','adapted',@source_117,
        'Transformation eines normierten Abstands in ein Robustheitsmaß.',
        'd_max ist positiv und begrenzt den betrachteten Abstand.'

    UNION ALL SELECT
        '3.1297','Normierter Robustheitsbereich',
        '0\\le R\\le1','0\\le R\\le1',
        'Normierungsbereich der Robustheit.',
        'constraint','original',NULL,
        'Festlegung des Wertebereichs.',
        'Der Trajektorienabstand überschreitet d_max nicht.'

    UNION ALL SELECT
        '3.1298','Sensitivitätsmaß',
        'S=\\frac{d_\\Gamma(\\Gamma,\\Gamma+\\Delta\\Gamma)}{\\|\\Delta\\Theta\\|}',
        'S=\\frac{d_\\Gamma(\\Gamma,\\Gamma+\\Delta\\Gamma)}{\\|\\Delta\\Theta\\|}',
        'Trajektorienänderung pro Norm der Parameteränderung.',
        'metric','adapted',@source_117,
        'Quotient aus Ergebnisänderung und Eingangsänderung.',
        'Die Parameteränderung ist ungleich null.'

    UNION ALL SELECT
        '3.1299','Binäre Validitätsfunktion',
        'V=\\begin{cases}1,&\\Theta\\in\\Omega_\\Theta\\\\0,&\\Theta\\notin\\Omega_\\Theta\\end{cases}',
        'V=\\begin{cases}1,&\\Theta\\in\\Omega_\\Theta\\\\0,&\\Theta\\notin\\Omega_\\Theta\\end{cases}',
        'Binäre Kennzeichnung einer zulässigen oder unzulässigen Parametrisierung.',
        'definition','original',NULL,
        'Indikatorfunktion des zulässigen Parameterraums.',
        'Omega_Theta ist vollständig definiert.'

    UNION ALL SELECT
        '3.1300','Ungültigkeitsbedingung',
        'V=0','V=0',
        'Kennzeichnung eines nicht interpretierbaren Simulationslaufs.',
        'criterion','original',NULL,
        'Spezialfall der binären Validitätsfunktion.',
        'Die Validitätsprüfung wurde durchgeführt.'

    UNION ALL SELECT
        '3.1301','Emergenzmaß',
        'E=\\frac{\\Delta O}{\\Delta t}',
        'E=\\frac{\\Delta O}{\\Delta t}',
        'Zeitbezogene Änderung des Organisationsgrades.',
        'metric','original',NULL,
        'Differenzenquotient des Organisationsgrades.',
        'Delta t ist positiv.'

    UNION ALL SELECT
        '3.1302','Emergenzkriterium',
        'E>E_{\\min}','E>E_{\\min}',
        'Eine relevante Emergenz wird oberhalb der festgelegten Schwelle angenommen.',
        'criterion','original',NULL,
        'Schwellenvergleich des Emergenzmaßes.',
        'E_min ist vor der Auswertung festgelegt.'

    UNION ALL SELECT
        '3.1303','Gesamtqualitätsindex',
        'Q=w_KK+w_CC+w_RR+w_SS+w_VV+w_EE',
        'Q=w_KK+w_CC+w_RR+w_SS+w_VV+w_EE',
        'Gewichtete Gesamtbewertung der Simulation.',
        'metric','adapted',@source_116,
        'Lineare Aggregation der Bewertungsgrößen.',
        'Metriken und Gewichtungen sind vergleichbar skaliert.'

    UNION ALL SELECT
        '3.1304','Normierung der Gewichtungen',
        '\\sum_i w_i=1',
        '\\sum_i w_i=1',
        'Die Summe aller Gewichtungsfaktoren beträgt eins.',
        'constraint','original',NULL,
        'Normierung der Gesamtbewertung.',
        'Alle Gewichtungen sind nichtnegativ.'

    UNION ALL SELECT
        '3.1305','Klassifikation A',
        'Q\\ge Q_A\\Rightarrow\\mathrm{Klasse\\ A}',
        'Q\\ge Q_A\\Rightarrow\\mathrm{Klasse\\ A}',
        'Ein Qualitätsindex oberhalb der oberen Schwelle wird Klasse A zugeordnet.',
        'classification','original',NULL,
        'Schwellenbasierte Klassifikation.',
        'Q_A ist kalibriert.'

    UNION ALL SELECT
        '3.1306','Klassifikation B',
        'Q_B\\le Q<Q_A\\Rightarrow\\mathrm{Klasse\\ B}',
        'Q_B\\le Q<Q_A\\Rightarrow\\mathrm{Klasse\\ B}',
        'Ein Qualitätsindex zwischen unterer und oberer Schwelle wird Klasse B zugeordnet.',
        'classification','original',NULL,
        'Schwellenbasierte Klassifikation.',
        'Q_B ist kleiner als Q_A.'

    UNION ALL SELECT
        '3.1307','Klassifikation C',
        'Q<Q_B\\Rightarrow\\mathrm{Klasse\\ C}',
        'Q<Q_B\\Rightarrow\\mathrm{Klasse\\ C}',
        'Ein Qualitätsindex unterhalb der unteren Schwelle wird Klasse C zugeordnet.',
        'classification','original',NULL,
        'Schwellenbasierte Klassifikation.',
        'Q_B ist kalibriert.'
) x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number = x.equation_number
);

/* ============================================================
   9. Abschnittssymbole
   ============================================================ */

INSERT INTO symbols
(
    symbol_latex,
    symbol_word_latex,
    symbol_name,
    definition_text,
    scope_type,
    first_section_id,
    first_equation_id,
    unit_text,
    domain_text,
    codomain_text,
    is_vector,
    is_matrix,
    is_operator,
    notes,
    validation_status,
    created_revision_id
)
SELECT
    x.symbol_latex,
    x.symbol_word_latex,
    x.symbol_name,
    x.definition_text,
    'section',
    @section_id,
    (
        SELECT equation_id
        FROM equations
        WHERE equation_number = x.first_equation_number
        LIMIT 1
    ),
    NULL,
    x.domain_text,
    x.codomain_text,
    x.is_vector,
    x.is_matrix,
    x.is_operator,
    'Abschnittssymbol 3.8.5.',
    'draft',
    @revision_id
FROM
(
    SELECT '\\mathbf{B}' symbol_latex,'\\mathbf{B}' symbol_word_latex,'Bewertungsvektor' symbol_name,'Vektor der sechs Bewertungsgrößen.' definition_text,'3.1291' first_equation_number,'R^6' domain_text,NULL codomain_text,1 is_vector,0 is_matrix,0 is_operator
    UNION ALL SELECT 'K','K','Kohärenzbewertung','Normierte Kohärenz des Endzustands.','3.1291','[0,1]',NULL,0,0,0
    UNION ALL SELECT 'C','C','Konvergenzbewertung','Normiertes Maß der Annäherung aufeinanderfolgender Zustände.','3.1291','R',NULL,0,0,0
    UNION ALL SELECT 'R','R','Robustheitsbewertung','Normierte Unempfindlichkeit gegenüber kleinen Störungen.','3.1291','[0,1]',NULL,0,0,0
    UNION ALL SELECT 'S','S','Sensitivitätsbewertung','Änderung der Trajektorie pro Parameteränderung.','3.1291','R_{ge_0}',NULL,0,0,0
    UNION ALL SELECT 'V','V','Validitätsbewertung','Binäre formale Gültigkeit des Simulationslaufs.','3.1291','{0,1}',NULL,0,0,0
    UNION ALL SELECT 'E','E','Emergenzbewertung','Zeitbezogene Änderung des Organisationsgrades.','3.1291','R',NULL,0,0,0
    UNION ALL SELECT 'd_{\\max}','d_{\\max}','Maximaler Trajektorienabstand','Normierungsgröße des Robustheitsmaßes.','3.1296','R_{>0}',NULL,0,0,0
    UNION ALL SELECT '\\Delta\\Theta','\\Delta\\Theta','Parameteränderung','Änderungsvektor der Parametrisierung.','3.1298','R^n',NULL,1,0,0
    UNION ALL SELECT 'O','O','Organisationsgrad','Maß des funktionalen Organisationsgrades.','3.1301','R',NULL,0,0,0
    UNION ALL SELECT 'E_{\\min}','E_{\\min}','Emergenzschwelle','Mindestwert einer als relevant bewerteten Emergenz.','3.1302','R',NULL,0,0,0
    UNION ALL SELECT 'Q','Q','Gesamtqualitätsindex','Gewichtete Gesamtbewertung eines Simulationslaufs.','3.1303','R',NULL,0,0,0
    UNION ALL SELECT 'w_i','w_i','Gewichtungsfaktor','Gewichtung einer einzelnen Bewertungsgröße.','3.1304','[0,1]',NULL,0,0,0
    UNION ALL SELECT 'Q_A','Q_A','Obere Klassifikationsschwelle','Grenzwert zwischen Klasse A und Klasse B.','3.1305','R',NULL,0,0,0
    UNION ALL SELECT 'Q_B','Q_B','Untere Klassifikationsschwelle','Grenzwert zwischen Klasse B und Klasse C.','3.1306','R',NULL,0,0,0
) x
WHERE @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols s
    WHERE s.symbol_latex = x.symbol_latex
      AND s.scope_type = 'section'
      AND s.first_section_id = @section_id
);

/* ============================================================
   10. Gleichungsbezogene Symbolverwendungen
   ============================================================ */

INSERT INTO equation_symbols
(
    equation_id,
    symbol_latex,
    symbol_name,
    definition_text,
    unit_text,
    domain_text,
    symbol_order
)
SELECT
    e.equation_id,
    x.symbol_latex,
    x.symbol_name,
    x.definition_text,
    NULL,
    x.domain_text,
    x.symbol_order
FROM
(
    SELECT '3.1291' equation_number,'\\mathbf{B}' symbol_latex,'Bewertungsvektor' symbol_name,'Vektor aller Bewertungsgrößen.' definition_text,'R^6' domain_text,1 symbol_order
    UNION ALL SELECT '3.1291','K','Kohärenz','Kohärenzbewertung.','[0,1]',2
    UNION ALL SELECT '3.1291','C','Konvergenz','Konvergenzbewertung.','R',3
    UNION ALL SELECT '3.1291','R','Robustheit','Robustheitsbewertung.','[0,1]',4
    UNION ALL SELECT '3.1291','S','Sensitivität','Sensitivitätsbewertung.','R_ge_0',5
    UNION ALL SELECT '3.1291','V','Validität','Binäre Validitätsbewertung.','{0,1}',6
    UNION ALL SELECT '3.1291','E','Emergenz','Emergenzbewertung.','R',7
    UNION ALL SELECT '3.1296','d_{\\max}','Maximaler Trajektorienabstand','Normierungsdistanz.','R_{>0}',1
    UNION ALL SELECT '3.1298','\\Delta\\Theta','Parameteränderung','Änderung der Parametrisierung.','R^n',1
    UNION ALL SELECT '3.1299','\\Omega_\\Theta','Zulässiger Parameterraum','Menge zulässiger Parametrisierungen.',NULL,1
    UNION ALL SELECT '3.1301','O','Organisationsgrad','Bewerteter Organisationsgrad.','R',1
    UNION ALL SELECT '3.1302','E_{\\min}','Emergenzschwelle','Mindestwert für relevante Emergenz.','R',1
    UNION ALL SELECT '3.1303','Q','Gesamtqualitätsindex','Gewichtete Gesamtbewertung.','R',1
    UNION ALL SELECT '3.1304','w_i','Gewichtungsfaktor','Normierter Gewichtungsfaktor.','[0,1]',1
    UNION ALL SELECT '3.1305','Q_A','Obere Klassifikationsschwelle','Grenze der Klasse A.','R',1
    UNION ALL SELECT '3.1306','Q_B','Untere Klassifikationsschwelle','Grenze zwischen Klasse B und C.','R',1
) x
JOIN equations e
  ON e.equation_number = x.equation_number
WHERE NOT EXISTS
(
    SELECT 1
    FROM equation_symbols es
    WHERE es.equation_id = e.equation_id
      AND es.symbol_latex = x.symbol_latex
);

/* ============================================================
   11. Änderungsprotokoll
   ============================================================ */

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value,
    changed_at
)
SELECT
    @revision_id,
    @section_id,
    x.change_type,
    x.object_type,
    x.object_reference,
    x.change_summary,
    x.previous_value,
    x.new_value,
    NOW()
FROM
(
    SELECT
        'created' change_type,
        'section' object_type,
        '3.8.5' object_reference,
        'Abschnitt 3.8.5 wurde als Auswertungskriterien und Bewertungsmetriken angelegt.' change_summary,
        NULL previous_value,
        'draft' new_value

    UNION ALL SELECT
        'source_added',
        'sources',
        '[116]-[117]',
        'Zwei Quellen zur explorativen Modellierung sowie Unsicherheits- und Sensitivitätsanalyse wurden aufgenommen.',
        'last_citation_number=115',
        'last_citation_number=117'

    UNION ALL SELECT
        'definition_added',
        'definitions',
        '3.8.5.1-3.8.5.6',
        'Sechs Definitionen zu Bewertungsvektor, Robustheit, Sensitivität, Validität, Emergenz und Gesamtqualitätsindex wurden registriert.',
        NULL,
        '6 definitions'

    UNION ALL SELECT
        'equation_added',
        'equations',
        '3.1291-3.1307',
        'Siebzehn Gleichungen zu den Bewertungsmetriken und der Klassifikation wurden registriert.',
        'last_equation=3.1290',
        'last_equation=3.1307'

    UNION ALL SELECT
        'symbol_added',
        'symbols',
        '3.8.5',
        'Die Abschnittssymbole und Gleichungsverwendungen für 3.8.5 wurden registriert.',
        NULL,
        '15 section symbols'
) x
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log scl
    WHERE scl.revision_id = @revision_id
      AND scl.section_id = @section_id
      AND scl.change_type = x.change_type
      AND COALESCE(scl.object_reference,'') = COALESCE(x.object_reference,'')
);

/* ============================================================
   12. Abschlussaudit
   ============================================================ */

SET @source_count :=
(
    SELECT COUNT(*)
    FROM sources
    WHERE citation_number IN (116,117)
);

SET @author_link_count :=
(
    SELECT COUNT(*)
    FROM source_authors
    WHERE source_id IN (@source_116,@source_117)
);

SET @usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id = @section_id
      AND source_id IN (@source_116,@source_117)
);

SET @definition_count :=
(
    SELECT COUNT(*)
    FROM definitions
    WHERE section_id = @section_id
      AND definition_number IN
      (
          '3.8.5.1','3.8.5.2','3.8.5.3',
          '3.8.5.4','3.8.5.5','3.8.5.6'
      )
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id = @section_id
      AND equation_number IN
      (
          '3.1291','3.1292','3.1293','3.1294','3.1295',
          '3.1296','3.1297','3.1298','3.1299','3.1300',
          '3.1301','3.1302','3.1303','3.1304','3.1305',
          '3.1306','3.1307'
      )
);

SET @symbol_count :=
(
    SELECT COUNT(*)
    FROM symbols
    WHERE first_section_id = @section_id
      AND scope_type = 'section'
);

SET @audit_ok :=
(
    @parent_section_id IS NOT NULL
    AND @revision_id IS NOT NULL
    AND @section_id IS NOT NULL
    AND @source_count = 2
    AND @author_link_count = 3
    AND @usage_count = 2
    AND @definition_count = 6
    AND @equation_count = 17
    AND @symbol_count >= 15
);

COMMIT;

/* ============================================================
   13. Abschlussausgabe
   ============================================================ */

SELECT
    @audit_ok AS audit_ok,
    @revision_id AS revision_id,
    @section_id AS section_id,
    @source_count AS source_count,
    @author_link_count AS author_link_count,
    @usage_count AS source_usage_count,
    @definition_count AS definition_count,
    @equation_count AS equation_count,
    @symbol_count AS symbol_count,
    CASE
        WHEN @audit_ok = 1
        THEN 'Kapitel 3.8.5 wurde vollständig und schema-konform importiert.'
        ELSE 'FEHLER: Abschnitt 3.8.5 ist unvollständig. Auditwerte prüfen.'
    END AS audit_message;

SELECT
    citation_number,
    full_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (116,117)
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    validation_status
FROM definitions
WHERE section_id = @section_id
ORDER BY definition_number;

SELECT
    equation_number,
    title,
    validation_status
FROM equations
WHERE section_id = @section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
