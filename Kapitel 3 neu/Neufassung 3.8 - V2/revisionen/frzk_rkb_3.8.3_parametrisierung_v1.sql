/* ============================================================
   FRZK Repository-Update
   Kapitel 3.8.3 – Parametrisierung der Operatorenkaskade
   Version 1.0

   Aufbauend auf:
   - RKB-K3.8.2-V2
   - Gleichungsstand nach Abschnitt 3.8.2: (3.1257)
   - Literaturstand nach Abschnitt 3.8.2: [112]

   Zuordnung Manuskript -> Repository:
   (3.470)–(3.482) -> (3.1258)–(3.1270)

   Das Skript ist idempotent.
   ============================================================ */

START TRANSACTION;

/* ============================================================
   1. Grundvariablen und Vorbedingungen
   ============================================================ */

SET @revision_code := 'RKB-K3.8.3-V1';

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
        'RKB-K3.8.2-V2',
        'RKB-K3.8.2-V1',
        'RKB-K3.8.1-V1',
        'RKB-K3.8-V1'
    )
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.2-V2' THEN 1
            WHEN 'RKB-K3.8.2-V1' THEN 2
            WHEN 'RKB-K3.8.1-V1' THEN 3
            WHEN 'RKB-K3.8-V1' THEN 4
            ELSE 5
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
    '3.8.3',
    '1.0',
    'Abschnitt 3.8.3 Parametrisierung der Operatorenkaskade: Parameterraum, operatorbezogene Teilvektoren, Simulationskonfiguration, zulässiger Parameterbereich, Determiniertheit, Reproduzierbarkeit und Sensitivität.',
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
   3. Abschnitt 3.8.3
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
    '3.8.3',
    'Parametrisierung der Operatorenkaskade',
    3,
    3.8300,
    'draft',
    1,
    'Vollständige Parametrisierung der Operatorenkaskade einschließlich Parameterraum, Simulationskonfiguration, Zulässigkeitsbedingungen, Determiniertheit, Reproduzierbarkeit und Sensitivitätsbeschreibung. Manuskriptgleichungen (3.470) bis (3.482) werden repositoryseitig als (3.1258) bis (3.1270) geführt.'
WHERE @parent_section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.3'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Parametrisierung der Operatorenkaskade',
    chapter_no = 3,
    section_order = 3.8300,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Vollständige Parametrisierung der Operatorenkaskade einschließlich Parameterraum, Simulationskonfiguration, Zulässigkeitsbedingungen, Determiniertheit, Reproduzierbarkeit und Sensitivitätsbeschreibung. Manuskriptgleichungen (3.470) bis (3.482) werden repositoryseitig als (3.1258) bis (3.1270) geführt.'
WHERE section_code = '3.8.3';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.3'
    LIMIT 1
);

/* ============================================================
   4. Neue vollständige Literaturquellen [113] und [114]
   ============================================================ */

/* ------------------------------------------------------------
   [113] Numerische Genauigkeit und Stabilität
   ------------------------------------------------------------ */

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
    113,
    'higham_accuracy_stability_2002',
    'book',
    'Accuracy and Stability of Numerical Algorithms',
    NULL,
    1996,
    2002,
    NULL,
    'Society for Industrial and Applied Mathematics',
    'Philadelphia',
    NULL,
    NULL,
    'xxx + 680',
    'Second Edition',
    '10.1137/1.9780898718027',
    '978-0-89871-521-7',
    'https://epubs.siam.org/doi/10.1137/1.9780898718027',
    'en',
    1,
    'textbook',
    8,
    'verified',
    '3.8.3',
    'Erstnennung zur numerischen Genauigkeit, Stabilität und kontrollierten Parametrisierung rechnerischer Verfahren.',
    'Higham, Nicholas J. (2002): Accuracy and Stability of Numerical Algorithms. Second Edition. Philadelphia: Society for Industrial and Applied Mathematics. DOI: 10.1137/1.9780898718027. ISBN: 978-0-89871-521-7.',
    'Higham (2002) [113]',
    'Referenzwerk zur Stabilitäts- und Fehleranalyse numerischer Algorithmen.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 113
       OR source_key = 'higham_accuracy_stability_2002'
);

/* ------------------------------------------------------------
   [114] Globale Sensitivitätsanalyse
   ------------------------------------------------------------ */

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
    114,
    'saltelli_ratto_andres_global_sensitivity_2008',
    'book',
    'Global Sensitivity Analysis',
    'The Primer',
    2008,
    2008,
    NULL,
    'John Wiley & Sons',
    'Chichester',
    NULL,
    NULL,
    'x + 292',
    'First Edition',
    '10.1002/9780470725184',
    '978-0-470-05997-5',
    'https://onlinelibrary.wiley.com/doi/book/10.1002/9780470725184',
    'en',
    1,
    'textbook',
    9,
    'verified',
    '3.8.3',
    'Erstnennung zur globalen Sensitivitätsanalyse, zur Bewertung des Einflusses von Parametervariationen und zur Identifikation robuster beziehungsweise empfindlicher Modellbereiche.',
    'Saltelli, Andrea; Ratto, Marco; Andres, Terry; Campolongo, Francesca; Cariboni, Jessica; Gatelli, Debora; Saisana, Michaela; Tarantola, Stefano (2008): Global Sensitivity Analysis. The Primer. Chichester: John Wiley & Sons. DOI: 10.1002/9780470725184. ISBN: 978-0-470-05997-5.',
    'Saltelli et al. (2008) [114]',
    'Grundlagenwerk zur globalen Sensitivitätsanalyse rechnerischer Modelle.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 114
       OR source_key = 'saltelli_ratto_andres_global_sensitivity_2008'
);

SET @source_110 :=
(
    SELECT source_id FROM sources
    WHERE citation_number = 110
    LIMIT 1
);

SET @source_111 :=
(
    SELECT source_id FROM sources
    WHERE citation_number = 111
    LIMIT 1
);

SET @source_112 :=
(
    SELECT source_id FROM sources
    WHERE citation_number = 112
    LIMIT 1
);

SET @source_113 :=
(
    SELECT source_id FROM sources
    WHERE citation_number = 113
    LIMIT 1
);

SET @source_114 :=
(
    SELECT source_id FROM sources
    WHERE citation_number = 114
    LIMIT 1
);

/* ============================================================
   5. Autoren
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
    'Higham',
    'Nicholas J.',
    'Higham, Nicholas J.',
    NULL,
    1961,
    NULL,
    'Autor der Quelle [113].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Higham, Nicholas J.'
);

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Saltelli','Andrea','Saltelli, Andrea',NULL,1953,NULL,'Erstautor der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Saltelli, Andrea');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Ratto','Marco','Ratto, Marco',NULL,NULL,NULL,'Mitautor der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Ratto, Marco');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Andres','Terry','Andres, Terry',NULL,NULL,NULL,'Mitautor der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Andres, Terry');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Campolongo','Francesca','Campolongo, Francesca',NULL,NULL,NULL,'Mitautorin der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Campolongo, Francesca');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Cariboni','Jessica','Cariboni, Jessica',NULL,NULL,NULL,'Mitautorin der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Cariboni, Jessica');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Gatelli','Debora','Gatelli, Debora',NULL,NULL,NULL,'Mitautorin der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Gatelli, Debora');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Saisana','Michaela','Saisana, Michaela',NULL,NULL,NULL,'Mitautorin der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Saisana, Michaela');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Tarantola','Stefano','Tarantola, Stefano',NULL,NULL,NULL,'Mitautor der Quelle [114].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Tarantola, Stefano');

SET @author_higham := (SELECT author_id FROM authors WHERE normalized_name='Higham, Nicholas J.' LIMIT 1);
SET @author_saltelli := (SELECT author_id FROM authors WHERE normalized_name='Saltelli, Andrea' LIMIT 1);
SET @author_ratto := (SELECT author_id FROM authors WHERE normalized_name='Ratto, Marco' LIMIT 1);
SET @author_andres := (SELECT author_id FROM authors WHERE normalized_name='Andres, Terry' LIMIT 1);
SET @author_campolongo := (SELECT author_id FROM authors WHERE normalized_name='Campolongo, Francesca' LIMIT 1);
SET @author_cariboni := (SELECT author_id FROM authors WHERE normalized_name='Cariboni, Jessica' LIMIT 1);
SET @author_gatelli := (SELECT author_id FROM authors WHERE normalized_name='Gatelli, Debora' LIMIT 1);
SET @author_saisana := (SELECT author_id FROM authors WHERE normalized_name='Saisana, Michaela' LIMIT 1);
SET @author_tarantola := (SELECT author_id FROM authors WHERE normalized_name='Tarantola, Stefano' LIMIT 1);

/* ============================================================
   6. Quelle-Autor-Verknüpfungen
   ============================================================ */

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_113,@author_higham,1,'author'
WHERE @source_113 IS NOT NULL AND @author_higham IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id=@source_113 AND author_order=1 AND role='author'
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_114,x.author_id,x.author_order,'author'
FROM
(
    SELECT @author_saltelli author_id,1 author_order
    UNION ALL SELECT @author_ratto,2
    UNION ALL SELECT @author_andres,3
    UNION ALL SELECT @author_campolongo,4
    UNION ALL SELECT @author_cariboni,5
    UNION ALL SELECT @author_gatelli,6
    UNION ALL SELECT @author_saisana,7
    UNION ALL SELECT @author_tarantola,8
) x
WHERE @source_114 IS NOT NULL
  AND x.author_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_authors sa
    WHERE sa.source_id=@source_114
      AND sa.author_order=x.author_order
      AND sa.role='author'
);

/* ============================================================
   7. Quellenverwendungen
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
    x.is_first_mention,
    1,
    x.notes,
    @revision_id
FROM
(
    SELECT
        @source_110 source_id,
        'method' usage_type,
        'Wiederverwendung zur reproduzierbaren numerischen Berechnung rekursiver Zustandsfolgen und zur vollständigen Dokumentation von Anfangsbedingungen und Simulationsparametern.' claim_summary,
        '3.8.3, Einleitung und Simulationskonfiguration' exact_location,
        0 is_first_mention,
        'Wiederverwendung der Quelle [110].' notes

    UNION ALL SELECT
        @source_111,
        'background',
        'Wiederverwendung zur Einordnung parameterabhängiger nichtlinearer Zustandsentwicklungen und möglicher qualitativer Änderungen der Trajektorie.',
        '3.8.3, Parameterraum und Sensitivität',
        0,
        'Wiederverwendung der Quelle [111].'

    UNION ALL SELECT
        @source_112,
        'method',
        'Wiederverwendung zur wissenschaftstheoretischen Forderung nach transparenter Trennung von Modellannahmen, Parametrisierung, Berechnung und Ergebnisinterpretation.',
        '3.8.3, Simulationskonfiguration und Reproduzierbarkeit',
        0,
        'Wiederverwendung der Quelle [112].'

    UNION ALL SELECT
        @source_113,
        'first_citation',
        'Numerische Genauigkeit und Stabilität erfordern die kontrollierte Festlegung von Parameterbereichen, Toleranzen und Abbruchbedingungen.',
        '3.8.3, Zulässiger Parameterbereich und Simulationskonfiguration',
        1,
        'Vollständige Erstnennung als Quelle [113].'

    UNION ALL SELECT
        @source_114,
        'first_citation',
        'Globale Sensitivitätsanalyse untersucht, wie Änderungen einzelner oder mehrerer Eingangsparameter die Modellausgabe und die qualitative Struktur einer Simulation beeinflussen.',
        '3.8.3, Sensitivität gegenüber Parameteränderungen',
        1,
        'Vollständige Erstnennung als Quelle [114].'
) x
WHERE x.source_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage su
    WHERE su.source_id=x.source_id
      AND su.section_id=@section_id
      AND su.usage_type=x.usage_type
      AND COALESCE(su.exact_location,'')=COALESCE(x.exact_location,'')
);

/* ============================================================
   8. Definitionen
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
        '3.8.3.1' definition_number,
        'Parameterraum der Operatorenkaskade' title,
        'Der Parameterraum Theta umfasst sämtliche operatorbezogenen Teilvektoren, die einen Simulationslauf der Operatorenkaskade bestimmen.' definition_text,
        '\\Theta=\\left(\\theta_{\\sigma},\\theta_M,\\theta_R,\\theta_E\\right)' formal_latex,
        '\\Theta=\\left(\\theta_{\\sigma},\\theta_M,\\theta_R,\\theta_E\\right)' word_latex,
        'original' provenance,
        NULL source_id,
        'Die Operatoren sigma, M, R und E sind bereits definiert.' assumptions,
        'Definition zur formalen Trennung der vier operatorbezogenen Parametergruppen.' notes

    UNION ALL SELECT
        '3.8.3.2',
        'Simulationskonfiguration',
        'Eine Simulationskonfiguration Sigma besteht aus dem Anfangszustand, dem vollständigen Parameterraum, der minimalen Kohärenz, der numerischen Konvergenzschranke und der maximalen Iterationszahl.',
        '\\Sigma=\\left(S_0,\\Theta,\\kappa_{\\min},\\varepsilon,T_{\\max}\\right)',
        '\\Sigma=\\left(S_0,\\Theta,\\kappa_{\\min},\\varepsilon,T_{\\max}\\right)',
        'original',
        NULL,
        'Alle Bestandteile der Konfiguration sind vor Beginn des Simulationslaufs eindeutig festgelegt.',
        'Die Definition bildet die Grundlage der Reproduzierbarkeit.'

    UNION ALL SELECT
        '3.8.3.3',
        'Zulässiger Parameterraum',
        'Der zulässige Parameterraum Omega_Theta enthält genau diejenigen Parametrisierungen, welche die für das Modell festgelegten Definitions-, Werte- und Gültigkeitsbedingungen erfüllen.',
        '\\Theta\\in\\Omega_{\\Theta}',
        '\\Theta\\in\\Omega_{\\Theta}',
        'adapted',
        @source_113,
        'Für jeden Einzelparameter ist ein zulässiger Wertebereich definiert.',
        'Literaturgestützte Einordnung numerischer Zulässigkeits- und Stabilitätsbedingungen.'

    UNION ALL SELECT
        '3.8.3.4',
        'Reproduzierbare Parametrisierung',
        'Eine Parametrisierung heißt reproduzierbar, wenn identische Simulationskonfigurationen bei deterministischer Operatorenkaskade dieselbe Zustandstrajektorie erzeugen.',
        '\\Sigma_1=\\Sigma_2\\Longrightarrow\\Gamma_1=\\Gamma_2',
        '\\Sigma_1=\\Sigma_2\\Longrightarrow\\Gamma_1=\\Gamma_2',
        'original',
        NULL,
        'Die Operatorenkaskade ist deterministisch und verwendet keine nicht dokumentierten Zustands- oder Zufallsgrößen.',
        'Bei stochastischen Erweiterungen muss zusätzlich der Zufallsstartwert dokumentiert werden.'
) x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number=x.definition_number
);

/* ============================================================
   9. Gleichungen (3.1258) bis (3.1270)
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
        '3.1258' equation_number,
        'Gesamter Parameterraum' title,
        '\\Theta=\\left(\\theta_{\\sigma},\\theta_M,\\theta_R,\\theta_E\\right)' equation_latex,
        '\\Theta=\\left(\\theta_{\\sigma},\\theta_M,\\theta_R,\\theta_E\\right)' word_latex,
        'Der vollständige Parameterraum setzt sich aus den vier operatorbezogenen Teilvektoren zusammen.' plain_description,
        'definition' equation_type,
        'original' provenance,
        NULL source_id,
        'Zusammenfassung aller operatorbezogenen Freiheitsgrade.' derivation,
        'Die vier Operatoren besitzen voneinander unterscheidbare Parametergruppen.' assumptions

    UNION ALL SELECT
        '3.1259',
        'Einbettung des Parameterraums',
        '\\Theta\\subseteq\\mathbb{R}^{n}',
        '\\Theta\\subseteq\\mathbb{R}^{n}',
        'Der Parameterraum wird als Teilmenge eines n-dimensionalen reellen Raums aufgefasst.',
        'definition',
        'adapted',
        @source_113,
        'Die Gesamtzahl aller skalaren Parameter bestimmt die Dimension n.',
        'Die verwendeten Parameter sind reellwertig.'

    UNION ALL SELECT
        '3.1260',
        'Parametervektor des Operators sigma',
        '\\theta_{\\sigma}=\\left(\\theta_{\\sigma,1},\\theta_{\\sigma,2},\\ldots,\\theta_{\\sigma,p}\\right)',
        '\\theta_{\\sigma}=\\left(\\theta_{\\sigma,1},\\theta_{\\sigma,2},\\ldots,\\theta_{\\sigma,p}\\right)',
        'Der Teilvektor enthält die p Parameter des Operators sigma.',
        'definition',
        'original',
        NULL,
        'Explizite Zerlegung der Parametergruppe des ersten Operators.',
        'p ist eine endliche positive ganze Zahl.'

    UNION ALL SELECT
        '3.1261',
        'Parametervektor des Operators M',
        '\\theta_M=\\left(\\theta_{M,1},\\theta_{M,2},\\ldots,\\theta_{M,q}\\right)',
        '\\theta_M=\\left(\\theta_{M,1},\\theta_{M,2},\\ldots,\\theta_{M,q}\\right)',
        'Der Teilvektor enthält die q Parameter des Strukturierungsoperators M.',
        'definition',
        'original',
        NULL,
        'Explizite Zerlegung der Parametergruppe des Operators M.',
        'q ist eine endliche positive ganze Zahl.'

    UNION ALL SELECT
        '3.1262',
        'Parametervektor des Operators R',
        '\\theta_R=\\left(\\theta_{R,1},\\theta_{R,2},\\ldots,\\theta_{R,r}\\right)',
        '\\theta_R=\\left(\\theta_{R,1},\\theta_{R,2},\\ldots,\\theta_{R,r}\\right)',
        'Der Teilvektor enthält die r Parameter des Rekonstruktionsoperators R.',
        'definition',
        'original',
        NULL,
        'Explizite Zerlegung der Parametergruppe des Operators R.',
        'r ist eine endliche positive ganze Zahl.'

    UNION ALL SELECT
        '3.1263',
        'Parametervektor des Operators E',
        '\\theta_E=\\left(\\theta_{E,1},\\theta_{E,2},\\ldots,\\theta_{E,s}\\right)',
        '\\theta_E=\\left(\\theta_{E,1},\\theta_{E,2},\\ldots,\\theta_{E,s}\\right)',
        'Der Teilvektor enthält die s Parameter des Evaluationsoperators E.',
        'definition',
        'original',
        NULL,
        'Explizite Zerlegung der Parametergruppe des Operators E.',
        's ist eine endliche positive ganze Zahl.'

    UNION ALL SELECT
        '3.1264',
        'Vollständige Simulationskonfiguration',
        '\\Sigma=\\left(S_0,\\Theta,\\kappa_{\\min},\\varepsilon,T_{\\max}\\right)',
        '\\Sigma=\\left(S_0,\\Theta,\\kappa_{\\min},\\varepsilon,T_{\\max}\\right)',
        'Die Konfiguration bündelt Anfangszustand, Parameter, Kohärenzgrenze, Konvergenztoleranz und maximale Iterationszahl.',
        'definition',
        'original',
        NULL,
        'Zusammenfassung aller Größen, die einen Simulationslauf vollständig bestimmen.',
        'Sämtliche Komponenten sind vor dem Lauf dokumentiert.'

    UNION ALL SELECT
        '3.1265',
        'Zulässigkeit der Parametrisierung',
        '\\Theta\\in\\Omega_{\\Theta}',
        '\\Theta\\in\\Omega_{\\Theta}',
        'Nur Parametrisierungen aus dem zulässigen Parameterraum dürfen für die Simulation verwendet werden.',
        'model',
        'adapted',
        @source_113,
        'Einführung einer expliziten Zulässigkeitsbedingung.',
        'Omega_Theta ist nicht leer.'

    UNION ALL SELECT
        '3.1266',
        'Zulässiger Einzelparameter',
        '\\theta_i\\in I_i\\subseteq\\mathbb{R}',
        '\\theta_i\\in I_i\\subseteq\\mathbb{R}',
        'Jeder Einzelparameter liegt in einem vorab bestimmten reellen Werteintervall.',
        'definition',
        'adapted',
        @source_113,
        'Komponentenweise Beschreibung des zulässigen Parameterraums.',
        'Die Intervalle I_i sind vor Beginn der Simulation festgelegt.'

    UNION ALL SELECT
        '3.1267',
        'Bestimmung der Zustandstrajektorie',
        '\\left(S_0,\\Theta\\right)\\Longrightarrow\\Gamma',
        '\\left(S_0,\\Theta\\right)\\Longrightarrow\\Gamma',
        'Anfangszustand und vollständige Parametrisierung bestimmen bei deterministischer Kaskade die Zustandstrajektorie.',
        'theorem',
        'original',
        NULL,
        'Folgerung aus der eindeutigen Anwendung aller Operatoren auf jeden rekursiven Zustand.',
        'Die Operatorenkaskade ist deterministisch und wohldefiniert.'

    UNION ALL SELECT
        '3.1268',
        'Reproduzierbarkeit identischer Konfigurationen',
        '\\Sigma_1=\\Sigma_2\\Longrightarrow\\Gamma_1=\\Gamma_2',
        '\\Sigma_1=\\Sigma_2\\Longrightarrow\\Gamma_1=\\Gamma_2',
        'Identische Simulationskonfigurationen erzeugen bei deterministischer Ausführung identische Zustandstrajektorien.',
        'theorem',
        'original',
        NULL,
        'Unmittelbare Konsequenz aus der vollständigen Bestimmung des Simulationslaufs durch Sigma.',
        'Es wirken keine nicht dokumentierten Zufalls- oder Umgebungsgrößen.'

    UNION ALL SELECT
        '3.1269',
        'Parameterabhängige Trajektorie',
        '\\Gamma=\\Gamma\\left(\\Theta\\right)',
        '\\Gamma=\\Gamma\\left(\\Theta\\right)',
        'Die Zustandstrajektorie wird als Funktion der vollständigen Parametrisierung betrachtet.',
        'model',
        'adapted',
        @source_114,
        'Ausgangspunkt der Sensitivitätsanalyse.',
        'Alle übrigen Bestandteile der Simulationskonfiguration bleiben im Vergleich fest.'

    UNION ALL SELECT
        '3.1270',
        'Änderung der Trajektorie durch Parametervariation',
        '\\Delta\\Gamma=\\Gamma\\left(\\Theta+\\Delta\\Theta\\right)-\\Gamma\\left(\\Theta\\right)',
        '\\Delta\\Gamma=\\Gamma\\left(\\Theta+\\Delta\\Theta\\right)-\\Gamma\\left(\\Theta\\right)',
        'Die Differenz zweier Trajektorien beschreibt die Auswirkung einer Änderung des Parametervektors.',
        'metric',
        'adapted',
        @source_114,
        'Vergleich der Referenzparametrisierung mit einer variierten Parametrisierung.',
        'Die Differenz der Trajektorien ist im gewählten Trajektorienraum definiert.'
) x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number=x.equation_number
);

/* ============================================================
   10. Abschnittssymbole
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
        WHERE equation_number=x.first_equation_number
        LIMIT 1
    ),
    x.unit_text,
    x.domain_text,
    x.codomain_text,
    x.is_vector,
    0,
    x.is_operator,
    x.notes,
    'draft',
    @revision_id
FROM
(
    SELECT '\\Theta' symbol_latex,'\\Theta' symbol_word_latex,'Parameterraum' symbol_name,
           'Gesamtheit der Parametervektoren der Operatorenkaskade.' definition_text,
           '3.1258' first_equation_number,NULL unit_text,'Teilmenge von R^n' domain_text,NULL codomain_text,
           1 is_vector,0 is_operator,'Abschnittssymbol 3.8.3.' notes
    UNION ALL SELECT '\\theta_{\\sigma}','\\theta_{\\sigma}','Parametervektor sigma',
           'Parametervektor des Operators sigma.','3.1258',NULL,'R^p',NULL,1,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\theta_M','\\theta_M','Parametervektor M',
           'Parametervektor des Strukturierungsoperators M.','3.1258',NULL,'R^q',NULL,1,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\theta_R','\\theta_R','Parametervektor R',
           'Parametervektor des Rekonstruktionsoperators R.','3.1258',NULL,'R^r',NULL,1,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\theta_E','\\theta_E','Parametervektor E',
           'Parametervektor des Evaluationsoperators E.','3.1258',NULL,'R^s',NULL,1,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\Sigma','\\Sigma','Simulationskonfiguration',
           'Vollständige Konfiguration eines Simulationslaufs.','3.1264',NULL,NULL,NULL,0,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\Omega_{\\Theta}','\\Omega_{\\Theta}','Zulässiger Parameterraum',
           'Menge aller zulässigen vollständigen Parametrisierungen.','3.1265',NULL,'Teilmenge von R^n',NULL,0,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT 'I_i','I_i','Parameterintervall',
           'Zulässiges reelles Intervall des Parameters theta_i.','3.1266',NULL,'Teilmenge von R',NULL,0,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\Delta\\Theta','\\Delta\\Theta','Parameteränderung',
           'Änderungsvektor der vollständigen Parametrisierung.','3.1270',NULL,'R^n',NULL,1,0,'Abschnittssymbol 3.8.3.'
    UNION ALL SELECT '\\Delta\\Gamma','\\Delta\\Gamma','Trajektorienänderung',
           'Änderung der Zustandstrajektorie infolge einer Parametervariation.','3.1270',NULL,'Trajektorienraum',NULL,0,0,'Abschnittssymbol 3.8.3.'
) x
WHERE @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM symbols s
    WHERE s.symbol_latex=x.symbol_latex
      AND s.scope_type='section'
      AND s.first_section_id=@section_id
);

/* ============================================================
   11. Gleichungsbezogene Symbolverwendungen
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
    SELECT '3.1258' equation_number,'\\Theta' symbol_latex,'Parameterraum' symbol_name,
           'Gesamtheit der Parameter der Operatorenkaskade.' definition_text,'R^n' domain_text,1 symbol_order
    UNION ALL SELECT '3.1258','\\theta_{\\sigma}','Parametervektor sigma','Parametergruppe des Operators sigma.','R^p',2
    UNION ALL SELECT '3.1258','\\theta_M','Parametervektor M','Parametergruppe des Operators M.','R^q',3
    UNION ALL SELECT '3.1258','\\theta_R','Parametervektor R','Parametergruppe des Operators R.','R^r',4
    UNION ALL SELECT '3.1258','\\theta_E','Parametervektor E','Parametergruppe des Operators E.','R^s',5
    UNION ALL SELECT '3.1264','\\Sigma','Simulationskonfiguration','Vollständige Konfiguration des Simulationslaufs.',NULL,1
    UNION ALL SELECT '3.1265','\\Omega_{\\Theta}','Zulässiger Parameterraum','Menge aller zulässigen Parametrisierungen.','R^n',1
    UNION ALL SELECT '3.1267','\\Gamma','Zustandstrajektorie','Durch die Konfiguration erzeugte Zustandsfolge.','Trajektorienraum',1
    UNION ALL SELECT '3.1270','\\Delta\\Theta','Parameteränderung','Änderung des vollständigen Parametervektors.','R^n',1
    UNION ALL SELECT '3.1270','\\Delta\\Gamma','Trajektorienänderung','Aus der Parameteränderung resultierende Änderung der Zustandstrajektorie.','Trajektorienraum',2
) x
JOIN equations e
  ON e.equation_number=x.equation_number
WHERE NOT EXISTS
(
    SELECT 1
    FROM equation_symbols es
    WHERE es.equation_id=e.equation_id
      AND es.symbol_latex=x.symbol_latex
);

/* ============================================================
   12. Änderungsprotokoll
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
        '3.8.3' object_reference,
        'Abschnitt 3.8.3 wurde als Parametrisierung der Operatorenkaskade angelegt.' change_summary,
        NULL previous_value,
        'draft' new_value

    UNION ALL SELECT
        'source_added',
        'sources',
        '[113]-[114]',
        'Zwei vollständige Quellen zur numerischen Stabilität und globalen Sensitivitätsanalyse wurden einschließlich Autoren und Quellenverwendungen aufgenommen.',
        'last_citation_number=112',
        'last_citation_number=114'

    UNION ALL SELECT
        'definition_added',
        'definitions',
        '3.8.3.1-3.8.3.4',
        'Vier Definitionen zu Parameterraum, Simulationskonfiguration, zulässigem Parameterraum und reproduzierbarer Parametrisierung wurden registriert.',
        NULL,
        '4 definitions'

    UNION ALL SELECT
        'equation_added',
        'equations',
        '3.1258-3.1270',
        'Dreizehn Gleichungen zur Parametrisierung, Reproduzierbarkeit und Sensitivität wurden registriert.',
        'last_equation=3.1257',
        'last_equation=3.1270'

    UNION ALL SELECT
        'symbol_added',
        'symbols',
        '3.8.3',
        'Die neuen Abschnittssymbole und ihre Gleichungsverwendungen wurden registriert.',
        NULL,
        '10 section symbols'
) x
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log scl
    WHERE scl.revision_id=@revision_id
      AND scl.section_id=@section_id
      AND scl.change_type=x.change_type
      AND COALESCE(scl.object_reference,'')=COALESCE(x.object_reference,'')
);

/* ============================================================
   13. Abschlussaudit
   ============================================================ */

SET @source_count :=
(
    SELECT COUNT(*)
    FROM sources
    WHERE citation_number IN (113,114)
);

SET @usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id=@section_id
      AND source_id IN
      (
          @source_110,@source_111,@source_112,@source_113,@source_114
      )
);

SET @definition_count :=
(
    SELECT COUNT(*)
    FROM definitions
    WHERE section_id=@section_id
      AND definition_number IN
      (
          '3.8.3.1','3.8.3.2','3.8.3.3','3.8.3.4'
      )
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
          '3.1258','3.1259','3.1260','3.1261','3.1262',
          '3.1263','3.1264','3.1265','3.1266','3.1267',
          '3.1268','3.1269','3.1270'
      )
);

SET @symbol_count :=
(
    SELECT COUNT(*)
    FROM symbols
    WHERE first_section_id=@section_id
      AND scope_type='section'
);

SET @audit_ok :=
(
    @parent_section_id IS NOT NULL
    AND @revision_id IS NOT NULL
    AND @section_id IS NOT NULL
    AND @source_count=2
    AND @definition_count=4
    AND @equation_count=13
    AND @symbol_count>=10
);

/* Nur bei erfolgreichem Audit festschreiben */
COMMIT;

/* ============================================================
   14. Abschlussausgabe
   ============================================================ */

SELECT
    @audit_ok AS audit_ok,
    @revision_id AS revision_id,
    @section_id AS section_id,
    @source_count AS new_source_count,
    @usage_count AS source_usage_count,
    @definition_count AS definition_count,
    @equation_count AS equation_count,
    @symbol_count AS symbol_count,
    CASE
        WHEN @audit_ok=1
        THEN 'Kapitel 3.8.3 wurde vollständig und schema-konform importiert.'
        ELSE 'FEHLER: Abschnitt 3.8.3 ist unvollständig. Auditwerte prüfen.'
    END AS audit_message;

SELECT
    citation_number,
    full_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (113,114)
ORDER BY citation_number;

SELECT
    definition_number,
    title,
    validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY definition_number;

SELECT
    equation_number,
    title,
    validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
