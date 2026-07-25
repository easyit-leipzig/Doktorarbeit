/* ============================================================
 FRZK Repository-Update
 Kapitel 3.8.10 – Parameterraum, Sensitivitätsanalyse
 und robuste Funktionsbereiche
 Version 2.0 – MariaDB-kompatible Neufassung

 Manuskriptgleichungen: (3.631)–(3.652)
 Repositorygleichungen: 3.1419–3.1440
 Neue Literatur: keine

 Kompatibilität:
 - MariaDB 10.4+
 - keine abgeleiteten Spaltenlisten hinter Tabellenaliasen
 - idempotente INSERT ... SELECT-Struktur
 ============================================================ */

START TRANSACTION;

SET @revision_code := 'RKB-K3.8.10-V2';

SET @parent_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8'
    LIMIT 1
);

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code IN ('RKB-K3.8.9-V1', 'RKB-K3.8.10-V1')
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.10-V1' THEN 1
            WHEN 'RKB-K3.8.9-V1' THEN 2
            ELSE 3
        END
    LIMIT 1
);

/* ============================================================
 1. Repository-Revision
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
    '3.8.10',
    '2.0',
    'MariaDB-kompatible Neufassung von Abschnitt 3.8.10 zu Parameterraum, Sensitivitätsanalyse, robusten und kritischen Funktionsbereichen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = @revision_code
);

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = @revision_code
    LIMIT 1
);

/* ============================================================
 2. Dissertation-Abschnitt
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
    '3.8.10',
    'Parameterraum, Sensitivitätsanalyse und robuste Funktionsbereiche',
    3,
    3.8100,
    'draft',
    1,
    'Manuskriptgleichungen (3.631) bis (3.652); Repositorygleichungen 3.1419 bis 3.1440.'
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.10'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Parameterraum, Sensitivitätsanalyse und robuste Funktionsbereiche',
    chapter_no = 3,
    section_order = 3.8100,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Manuskriptgleichungen (3.631) bis (3.652); Repositorygleichungen 3.1419 bis 3.1440.'
WHERE section_code = '3.8.10';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.10'
    LIMIT 1
);

/* ============================================================
 3. Definitionen
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
    'original',
    NULL,
    x.assumptions,
    x.notes,
    'draft',
    @revision_id
FROM
(
    SELECT
        '3.8.10.1' AS definition_number,
        'Parameterraum' AS title,
        'Der Parameterraum ist die Menge aller zulässigen Parametervektoren der Operatorenkaskade.' AS definition_text,
        '\\mathcal{P}=\\left\\{\\Theta\\right\\}\\subseteq\\mathbb{R}^{n}' AS formal_latex,
        '\\mathcal{P}=\\left\\{\\Theta\\right\\}\\subseteq\\mathbb{R}^{n}' AS word_latex,
        'Die Parameterkomponenten und ihre zulässigen Wertebereiche sind festgelegt.' AS assumptions,
        'Grundlage der systematischen Parametervariation.' AS notes

    UNION ALL

    SELECT
        '3.8.10.2',
        'Lokale Sensitivität',
        'Die lokale Sensitivität beschreibt die Änderung einer Trajektorie oder Bewertungsgröße gegenüber einer lokalen Änderung eines einzelnen Parameters.',
        'S_i=\\frac{\\partial Q}{\\partial\\theta_i}',
        'S_i=\\frac{\\partial Q}{\\partial\\theta_i}',
        'Die übrigen Parameter werden lokal konstant gehalten.',
        'Für numerische Berechnungen wird eine Differenzenapproximation verwendet.'

    UNION ALL

    SELECT
        '3.8.10.3',
        'Globale Sensitivität',
        'Die globale Sensitivität beschreibt den über den untersuchten Parameterbereich wirksamen Einfluss eines Parameters auf die Varianz der Bewertungsgröße.',
        'S_i^{\\mathrm{glob}}=\\operatorname{Var}\\left(Q\\mid\\theta_i\\right)',
        'S_i^{\\mathrm{glob}}=\\operatorname{Var}\\left(Q\\mid\\theta_i\\right)',
        'Der untersuchte Parameterbereich und das Stichprobendesign sind festgelegt.',
        'Nichtlineare und bereichsabhängige Einflüsse werden berücksichtigt.'

    UNION ALL

    SELECT
        '3.8.10.4',
        'Robuster Parameterbereich',
        'Ein robuster Parameterbereich enthält Parameterkonfigurationen, deren benachbarte Variationen nur geringe Trajektorienabweichungen erzeugen.',
        'R=\\left\\{\\Theta\\in\\mathcal{P}\\mid D_{\\Gamma}<\\varepsilon_R\\right\\}',
        'R=\\left\\{\\Theta\\in\\mathcal{P}\\mid D_{\\Gamma}<\\varepsilon_R\\right\\}',
        'Die Trajektoriendistanz und der Robustheitsschwellenwert sind definiert.',
        'Robustheit ist an die verwendete Distanzfunktion gebunden.'

    UNION ALL

    SELECT
        '3.8.10.5',
        'Kritischer Parameterbereich',
        'Der kritische Parameterbereich ist das Komplement des robusten Parameterbereichs innerhalb des untersuchten Parameterraums.',
        'C=\\mathcal{P}\\setminus R',
        'C=\\mathcal{P}\\setminus R',
        'Robuste und kritische Bereiche werden innerhalb desselben Parameterraums bestimmt.',
        'Kritische Bereiche können Übergänge und hohe Sensitivitäten enthalten.'

    UNION ALL

    SELECT
        '3.8.10.6',
        'Robustheitsindex',
        'Der Robustheitsindex normiert die Trajektorienabweichung auf das Intervall von null bis eins.',
        'I_R=1-\\frac{D_{\\Gamma}}{D_{\\max}}',
        'I_R=1-\\frac{D_{\\Gamma}}{D_{\\max}}',
        'Es gilt 0\\le D_{\\Gamma}\\le D_{\\max}.',
        'Hohe Werte kennzeichnen robuste Parameterkonfigurationen.'

    UNION ALL

    SELECT
        '3.8.10.7',
        'Kritikalitätsindex',
        'Der Kritikalitätsindex ist das Komplement des Robustheitsindex.',
        'I_C=1-I_R',
        'I_C=1-I_R',
        'Der Robustheitsindex liegt im Intervall von null bis eins.',
        'Hohe Werte kennzeichnen kritische Parameterkonfigurationen.'

    UNION ALL

    SELECT
        '3.8.10.8',
        'Stabilitätslandschaft',
        'Die Stabilitätslandschaft verbindet den Parameterraum mit einer darauf definierten Bewertungsabbildung.',
        'L=\\left(\\mathcal{P},M\\right)',
        'L=\\left(\\mathcal{P},M\\right)',
        'Die Bewertungsfunktion ist für jeden untersuchten Parameterpunkt definiert.',
        'Grundlage für die kartographische Darstellung stabiler und kritischer Regionen.'
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
 4. Gleichungen
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
    'original',
    NULL,
    'Herleitung gemäß Abschnitt 3.8.10.',
    'Die im Abschnitt festgelegten Parameter- und Sensitivitätsbedingungen gelten.',
    'draft',
    @revision_id
FROM
(
    SELECT '3.1419' AS equation_number,
           'Parametervektor' AS title,
           '\\Theta=\\left(\\theta_1,\\theta_2,\\ldots,\\theta_n\\right)' AS equation_latex,
           '\\Theta=\\left(\\theta_1,\\theta_2,\\ldots,\\theta_n\\right)' AS word_latex,
           'Vektor aller Modellparameter.' AS plain_description,
           'definition' AS equation_type

    UNION ALL SELECT '3.1420','Parameterraum',
        '\\mathcal{P}=\\left\\{\\Theta\\right\\}\\subseteq\\mathbb{R}^{n}',
        '\\mathcal{P}=\\left\\{\\Theta\\right\\}\\subseteq\\mathbb{R}^{n}',
        'Menge aller zulässigen Parametervektoren.','definition'

    UNION ALL SELECT '3.1421','Abbildung auf Trajektorien',
        '\\Theta\\longrightarrow\\Gamma(\\Theta)',
        '\\Theta\\longrightarrow\\Gamma(\\Theta)',
        'Zuordnung eines Parametervektors zu einer Simulationstrajektorie.','mapping'

    UNION ALL SELECT '3.1422','Parametervariation',
        '\\Delta\\Theta=\\Theta''-\\Theta',
        '\\Delta\\Theta=\\Theta''-\\Theta',
        'Änderung des Parametervektors.','definition'

    UNION ALL SELECT '3.1423','Trajektorienänderung',
        '\\Delta\\Gamma=\\Gamma(\\Theta'')-\\Gamma(\\Theta)',
        '\\Delta\\Gamma=\\Gamma(\\Theta'')-\\Gamma(\\Theta)',
        'Änderung der Trajektorie infolge einer Parametervariation.','definition'

    UNION ALL SELECT '3.1424','Lokale Trajektoriensensitivität',
        'S_i=\\frac{\\partial\\Gamma}{\\partial\\theta_i}',
        'S_i=\\frac{\\partial\\Gamma}{\\partial\\theta_i}',
        'Lokale Sensitivität der Trajektorie gegenüber einem Parameter.','metric'

    UNION ALL SELECT '3.1425','Lokale Ergebnissensitivität',
        'S_i=\\frac{\\partial Q}{\\partial\\theta_i}',
        'S_i=\\frac{\\partial Q}{\\partial\\theta_i}',
        'Lokale Sensitivität einer skalaren Bewertungsgröße.','metric'

    UNION ALL SELECT '3.1426','Numerische Sensitivitätsnäherung',
        'S_i\\approx\\frac{Q(\\theta_i+\\Delta\\theta_i)-Q(\\theta_i)}{\\Delta\\theta_i}',
        'S_i\\approx\\frac{Q(\\theta_i+\\Delta\\theta_i)-Q(\\theta_i)}{\\Delta\\theta_i}',
        'Numerische Näherung der lokalen Sensitivität.','approximation'

    UNION ALL SELECT '3.1427','Globale Sensitivität',
        'S_i^{\\mathrm{glob}}=\\operatorname{Var}\\left(Q\\mid\\theta_i\\right)',
        'S_i^{\\mathrm{glob}}=\\operatorname{Var}\\left(Q\\mid\\theta_i\\right)',
        'Varianzbasierter globaler Einfluss eines Parameters.','metric'

    UNION ALL SELECT '3.1428','Normierter Sensitivitätseinfluss',
        '\\widehat{S}_i=\\frac{S_i^{\\mathrm{glob}}}{\\sum_{j=1}^{n}S_j^{\\mathrm{glob}}}',
        '\\widehat{S}_i=\\frac{S_i^{\\mathrm{glob}}}{\\sum_{j=1}^{n}S_j^{\\mathrm{glob}}}',
        'Normierter globaler Sensitivitätsanteil.','metric'

    UNION ALL SELECT '3.1429','Normierung der Sensitivitätsanteile',
        '\\sum_{i=1}^{n}\\widehat{S}_i=1',
        '\\sum_{i=1}^{n}\\widehat{S}_i=1',
        'Summe aller normierten Sensitivitätsanteile.','constraint'

    UNION ALL SELECT '3.1430','Robuster Parameterbereich',
        'R=\\left\\{\\Theta\\in\\mathcal{P}\\mid D_{\\Gamma}<\\varepsilon_R\\right\\}',
        'R=\\left\\{\\Theta\\in\\mathcal{P}\\mid D_{\\Gamma}<\\varepsilon_R\\right\\}',
        'Menge robuster Parameterkonfigurationen.','definition'

    UNION ALL SELECT '3.1431','Robustheitsrelation',
        '\\left\\|\\Delta\\Gamma\\right\\|\\ll\\left\\|\\Delta\\Theta\\right\\|',
        '\\left\\|\\Delta\\Gamma\\right\\|\\ll\\left\\|\\Delta\\Theta\\right\\|',
        'Kleine Trajektorienänderung im Verhältnis zur Parametervariation.','criterion'

    UNION ALL SELECT '3.1432','Kritische Trajektorienänderung',
        '\\left\\|\\Delta\\Gamma\\right\\|>\\varepsilon_C',
        '\\left\\|\\Delta\\Gamma\\right\\|>\\varepsilon_C',
        'Schwellenwertbedingung einer kritischen Trajektorienänderung.','criterion'

    UNION ALL SELECT '3.1433','Kleine Parametervariation',
        '\\left\\|\\Delta\\Theta\\right\\|<\\varepsilon_{\\Theta}',
        '\\left\\|\\Delta\\Theta\\right\\|<\\varepsilon_{\\Theta}',
        'Bedingung einer kleinen Parametervariation.','criterion'

    UNION ALL SELECT '3.1434','Kritischer Parameterbereich',
        'C=\\mathcal{P}\\setminus R',
        'C=\\mathcal{P}\\setminus R',
        'Komplement des robusten Parameterbereichs.','definition'

    UNION ALL SELECT '3.1435','Parameterkarte',
        'M:\\mathcal{P}\\rightarrow\\mathbb{R}',
        'M:\\mathcal{P}\\rightarrow\\mathbb{R}',
        'Abbildung des Parameterraums auf eine skalare Bewertungsgröße.','mapping'

    UNION ALL SELECT '3.1436','Bewertungskarte',
        'M(\\Theta)=Q(\\Theta)',
        'M(\\Theta)=Q(\\Theta)',
        'Parameterkarte auf Grundlage der Bewertungsfunktion.','definition'

    UNION ALL SELECT '3.1437','Robustheitsindex',
        'I_R=1-\\frac{D_{\\Gamma}}{D_{\\max}}',
        'I_R=1-\\frac{D_{\\Gamma}}{D_{\\max}}',
        'Normierter Robustheitsindex.','metric'

    UNION ALL SELECT '3.1438','Wertebereich des Robustheitsindex',
        '0\\le I_R\\le1',
        '0\\le I_R\\le1',
        'Zulässiger Wertebereich des Robustheitsindex.','constraint'

    UNION ALL SELECT '3.1439','Kritikalitätsindex',
        'I_C=1-I_R',
        'I_C=1-I_R',
        'Komplementärer Kritikalitätsindex.','metric'

    UNION ALL SELECT '3.1440','Stabilitätslandschaft',
        'L=\\left(\\mathcal{P},M\\right)',
        'L=\\left(\\mathcal{P},M\\right)',
        'Paar aus Parameterraum und Bewertungsabbildung.','definition'
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
 5. Abschnittssymbole
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
    x.symbol_latex,
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
    'Abschnittssymbol 3.8.10.',
    'draft',
    @revision_id
FROM
(
    SELECT '\\Theta' AS symbol_latex,
           'Parametervektor' AS symbol_name,
           'Vektor aller Modellparameter.' AS definition_text,
           '3.1419' AS first_equation_number,
           '\\mathbb{R}^{n}' AS domain_text,
           NULL AS codomain_text,
           1 AS is_vector,
           0 AS is_matrix,
           0 AS is_operator

    UNION ALL SELECT '\\theta_i','Einzelparameter',
        'i-te Komponente des Parametervektors.','3.1419',
        '\\mathbb{R}',NULL,0,0,0

    UNION ALL SELECT '\\mathcal{P}','Parameterraum',
        'Menge aller zulässigen Parametervektoren.','3.1420',
        NULL,NULL,0,0,0

    UNION ALL SELECT '\\Gamma(\\Theta)','Parametrisierte Trajektorie',
        'Durch einen Parametervektor erzeugte Trajektorie.','3.1421',
        NULL,NULL,0,0,0

    UNION ALL SELECT '\\Delta\\Theta','Parametervariation',
        'Änderung des Parametervektors.','3.1422',
        '\\mathbb{R}^{n}',NULL,1,0,0

    UNION ALL SELECT '\\Delta\\Gamma','Trajektorienänderung',
        'Änderung einer Simulationstrajektorie.','3.1423',
        NULL,NULL,0,0,0

    UNION ALL SELECT 'S_i','Lokale Sensitivität',
        'Lokale Reaktion auf eine Änderung des Parameters theta_i.','3.1424',
        '\\mathbb{R}',NULL,0,0,0

    UNION ALL SELECT 'S_i^{\\mathrm{glob}}','Globale Sensitivität',
        'Globaler varianzbasierter Einfluss eines Parameters.','3.1427',
        '\\mathbb{R}_{\\ge0}',NULL,0,0,0

    UNION ALL SELECT '\\widehat{S}_i','Normierter Sensitivitätsanteil',
        'Normierter globaler Einfluss eines Parameters.','3.1428',
        '[0,1]',NULL,0,0,0

    UNION ALL SELECT 'R','Robuster Parameterbereich',
        'Menge robuster Parameterkonfigurationen.','3.1430',
        NULL,NULL,0,0,0

    UNION ALL SELECT 'C','Kritischer Parameterbereich',
        'Komplement des robusten Parameterbereichs.','3.1434',
        NULL,NULL,0,0,0

    UNION ALL SELECT 'M','Parameterkarte',
        'Abbildung des Parameterraums auf eine Bewertungsgröße.','3.1435',
        '\\mathcal{P}','\\mathbb{R}',0,0,1

    UNION ALL SELECT 'I_R','Robustheitsindex',
        'Normiertes Maß der Robustheit.','3.1437',
        '[0,1]',NULL,0,0,0

    UNION ALL SELECT 'I_C','Kritikalitätsindex',
        'Komplementäres Maß der Kritikalität.','3.1439',
        '[0,1]',NULL,0,0,0

    UNION ALL SELECT 'L','Stabilitätslandschaft',
        'Paar aus Parameterraum und Bewertungsabbildung.','3.1440',
        NULL,NULL,0,0,0
) x
WHERE @section_id IS NOT NULL
AND @revision_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols s
    WHERE s.symbol_latex = x.symbol_latex
      AND s.scope_type = 'section'
      AND s.first_section_id = @section_id
);

/* ============================================================
 6. Gleichung-Symbol-Verknüpfungen
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
    SELECT '3.1419' AS equation_number,
           '\\Theta' AS symbol_latex,
           'Parametervektor' AS symbol_name,
           'Vektor aller Modellparameter.' AS definition_text,
           '\\mathbb{R}^{n}' AS domain_text,
           1 AS symbol_order

    UNION ALL SELECT '3.1420','\\mathcal{P}','Parameterraum',
        'Menge aller zulässigen Parametervektoren.',NULL,1

    UNION ALL SELECT '3.1421','\\Gamma(\\Theta)','Parametrisierte Trajektorie',
        'Trajektorie für die Parametrisierung Theta.',NULL,1

    UNION ALL SELECT '3.1422','\\Delta\\Theta','Parametervariation',
        'Änderung des Parametervektors.','\\mathbb{R}^{n}',1

    UNION ALL SELECT '3.1423','\\Delta\\Gamma','Trajektorienänderung',
        'Änderung der Trajektorie.',NULL,1

    UNION ALL SELECT '3.1424','S_i','Lokale Sensitivität',
        'Lokale Sensitivität gegenüber theta_i.','\\mathbb{R}',1

    UNION ALL SELECT '3.1427','S_i^{\\mathrm{glob}}','Globale Sensitivität',
        'Varianzbasierter globaler Einfluss.','\\mathbb{R}_{\\ge0}',1

    UNION ALL SELECT '3.1428','\\widehat{S}_i','Normierter Sensitivitätsanteil',
        'Normierter globaler Einfluss.','[0,1]',1

    UNION ALL SELECT '3.1430','R','Robuster Bereich',
        'Menge robuster Parameterkonfigurationen.',NULL,1

    UNION ALL SELECT '3.1434','C','Kritischer Bereich',
        'Komplement des robusten Bereichs.',NULL,1

    UNION ALL SELECT '3.1435','M','Parameterkarte',
        'Bewertungsabbildung auf dem Parameterraum.',NULL,1

    UNION ALL SELECT '3.1437','I_R','Robustheitsindex',
        'Normierter Robustheitswert.','[0,1]',1

    UNION ALL SELECT '3.1439','I_C','Kritikalitätsindex',
        'Normierter Kritikalitätswert.','[0,1]',1

    UNION ALL SELECT '3.1440','L','Stabilitätslandschaft',
        'Parameterraum mit Bewertungsabbildung.',NULL,1
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
 7. Änderungsprotokoll
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
        'created' AS change_type,
        'section' AS object_type,
        '3.8.10' AS object_reference,
        'Abschnitt 3.8.10 wurde in MariaDB-kompatibler Form angelegt beziehungsweise aktualisiert.' AS change_summary,
        NULL AS previous_value,
        'draft' AS new_value

    UNION ALL

    SELECT
        'definition_added',
        'definitions',
        '3.8.10.1-3.8.10.8',
        'Acht Definitionen wurden registriert.',
        NULL,
        '8 definitions'

    UNION ALL

    SELECT
        'equation_added',
        'equations',
        '3.1419-3.1440',
        'Zweiundzwanzig Gleichungen wurden registriert.',
        'last_equation=3.1418',
        'last_equation=3.1440'

    UNION ALL

    SELECT
        'symbol_added',
        'symbols',
        '3.8.10',
        'Abschnittssymbole und Gleichungsverwendungen wurden registriert.',
        NULL,
        '15 section symbols'

    UNION ALL

    SELECT
        'corrected',
        'script',
        'RKB-K3.8.10-V2',
        'Nicht von MariaDB unterstützte abgeleitete Spaltenlisten hinter Tabellenaliasen wurden vollständig entfernt.',
        'AS x(column_list)',
        'MariaDB-kompatible Aliasdefinitionen im jeweils ersten SELECT'
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
 8. Abschlussaudit
 ============================================================ */

SET @definition_count := (
    SELECT COUNT(*)
    FROM definitions
    WHERE section_id = @section_id
      AND definition_number IN
      (
          '3.8.10.1',
          '3.8.10.2',
          '3.8.10.3',
          '3.8.10.4',
          '3.8.10.5',
          '3.8.10.6',
          '3.8.10.7',
          '3.8.10.8'
      )
);

SET @equation_count := (
    SELECT COUNT(*)
    FROM equations
    WHERE section_id = @section_id
      AND equation_number IN
      (
          '3.1419','3.1420','3.1421','3.1422','3.1423','3.1424',
          '3.1425','3.1426','3.1427','3.1428','3.1429','3.1430',
          '3.1431','3.1432','3.1433','3.1434','3.1435','3.1436',
          '3.1437','3.1438','3.1439','3.1440'
      )
);

SET @symbol_count := (
    SELECT COUNT(*)
    FROM symbols
    WHERE first_section_id = @section_id
      AND scope_type = 'section'
);

SET @equation_symbol_count := (
    SELECT COUNT(*)
    FROM equation_symbols es
    INNER JOIN equations e
        ON e.equation_id = es.equation_id
    WHERE e.section_id = @section_id
);

SET @audit_ok := (
       @parent_section_id IS NOT NULL
   AND @revision_id IS NOT NULL
   AND @section_id IS NOT NULL
   AND @definition_count = 8
   AND @equation_count = 22
   AND @symbol_count >= 15
   AND @equation_symbol_count >= 14
);

COMMIT;

SELECT
    @audit_ok AS audit_ok,
    @revision_id AS revision_id,
    @section_id AS section_id,
    @definition_count AS definition_count,
    @equation_count AS equation_count,
    @symbol_count AS symbol_count,
    @equation_symbol_count AS equation_symbol_count,
    CASE
        WHEN @audit_ok = 1
        THEN 'Kapitel 3.8.10 wurde vollständig und MariaDB-kompatibel importiert.'
        ELSE 'FEHLER: Abschnitt 3.8.10 ist unvollständig. Auditwerte prüfen.'
    END AS audit_message;

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
