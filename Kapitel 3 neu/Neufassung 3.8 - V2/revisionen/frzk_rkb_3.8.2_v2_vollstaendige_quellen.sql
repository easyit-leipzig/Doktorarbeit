/* ============================================================
   FRZK Repository-Update
   Kapitel 3.8.2 – Simulationsmodell und mathematische Formulierung
   V2 – mit vollständigen Literaturquellen [110]–[112]

   Schema geprüft gegen:
   frzk_rkb_stand_start_3.8.sql

   WICHTIG ZUR NUMMERIERUNG:
   Die Gleichungsnummern (3.455) bis (3.469) sind im Repository
   bereits durch Kapitel 3.3 belegt. Der höchste vorhandene
   Gleichungsstand vor Kapitel 3.8 beträgt (3.1242).
   Deshalb werden die Gleichungen dieses Abschnitts im Repository
   fortlaufend als (3.1243) bis (3.1257) registriert.
   ============================================================ */

START TRANSACTION;

/* ============================================================
   1. Grundvariablen und Vorbedingungen
   ============================================================ */

SET @revision_code := 'RKB-K3.8.2-V2';

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
        'RKB-K3.8.1-V1',
        'RKB-K3.8-V1'
    )
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.1-V1' THEN 1
            WHEN 'RKB-K3.8-V1' THEN 2
            ELSE 3
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
    '3.8.2',
    '2.0',
    'Abschnitt 3.8.2 Simulationsmodell und mathematische Formulierung einschließlich vollständiger Quellen [110] bis [112], Quellenverwendungen und Gleichungen (3.1243) bis (3.1257).',
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
   3. Abschnitt 3.8.2
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
    '3.8.2',
    'Simulationsmodell und mathematische Formulierung',
    3,
    3.8200,
    'draft',
    1,
    'Formale Überführung der Operatorenkaskade in ein rekursives Simulationsmodell. Die ursprünglich im Manuskript vorgesehenen Gleichungsnummern (3.455) bis (3.469) sind im Repository bereits vergeben. Repositoryseitig wird deshalb mit (3.1243) bis (3.1257) fortgesetzt.'
WHERE @parent_section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.2'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.2'
    LIMIT 1
);

/* Bereits vorhandenen Abschnitt auf den aktuellen Stand bringen */
UPDATE dissertation_sections
SET
    title = 'Simulationsmodell und mathematische Formulierung',
    parent_section_id = @parent_section_id,
    chapter_no = 3,
    section_order = 3.8200,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Formale Überführung der Operatorenkaskade in ein rekursives Simulationsmodell. Die ursprünglich im Manuskript vorgesehenen Gleichungsnummern (3.455) bis (3.469) sind im Repository bereits vergeben. Repositoryseitig wird deshalb mit (3.1243) bis (3.1257) fortgesetzt.'
WHERE section_code = '3.8.2';

/* ============================================================
   4. Vollständige Literaturquellen [110]–[112]
   ============================================================ */

/* ------------------------------------------------------------
   Quelle [110]
   Numerische Integration und reproduzierbare Iterationsverfahren
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
    110,
    'hairer_norsett_wanner_ode_i_1993',
    'book',
    'Solving Ordinary Differential Equations I',
    'Nonstiff Problems',
    1987,
    1993,
    NULL,
    'Springer-Verlag',
    'Berlin, Heidelberg',
    NULL,
    NULL,
    NULL,
    'Second Revised Edition',
    '10.1007/978-3-540-78862-1',
    '978-3-540-56670-0',
    'https://link.springer.com/book/10.1007/978-3-540-78862-1',
    'en',
    1,
    'textbook',
    8,
    'verified',
    '3.8.2',
    'Erstnennung zur numerischen Behandlung rekursiver Zustandsentwicklungen, zu Iterationsverfahren sowie zu Anforderungen an stabile und reproduzierbare numerische Berechnungen.',
    'Hairer, Ernst; Nørsett, Syvert P.; Wanner, Gerhard (1993): Solving Ordinary Differential Equations I. Nonstiff Problems. Second Revised Edition. Berlin, Heidelberg: Springer-Verlag. DOI: 10.1007/978-3-540-78862-1. ISBN: 978-3-540-56670-0.',
    'Hairer, Nørsett und Wanner (1993) [110]',
    'Grundlegendes Referenzwerk zu numerischen Verfahren für dynamische Zustandsentwicklungen und zur kontrollierten Berechnung von Zustandstrajektorien.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 110
       OR source_key = 'hairer_norsett_wanner_ode_i_1993'
);

/* ------------------------------------------------------------
   Quelle [111]
   Nichtlineare Dynamik, Stabilität, Attraktoren und Sensitivität
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
    111,
    'strogatz_nonlinear_dynamics_chaos_2015',
    'book',
    'Nonlinear Dynamics and Chaos',
    'With Applications to Physics, Biology, Chemistry, and Engineering',
    1994,
    2015,
    NULL,
    'Westview Press',
    'Boulder, Colorado',
    NULL,
    NULL,
    NULL,
    'Second Edition',
    NULL,
    '978-0-8133-4910-7',
    NULL,
    'en',
    1,
    'textbook',
    9,
    'verified',
    '3.8.2',
    'Erstnennung zur Analyse nichtlinearer Zustandsfolgen, zur Stabilität, zu Attraktoren, zu Bifurkationen und zur Sensitivität dynamischer Systeme.',
    'Strogatz, Steven H. (2015): Nonlinear Dynamics and Chaos. With Applications to Physics, Biology, Chemistry, and Engineering. Second Edition. Boulder, Colorado: Westview Press. ISBN: 978-0-8133-4910-7.',
    'Strogatz (2015) [111]',
    'International etabliertes Grundlagenwerk zur qualitativen und mathematischen Analyse nichtlinearer dynamischer Systeme.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 111
       OR source_key = 'strogatz_nonlinear_dynamics_chaos_2015'
);

/* ------------------------------------------------------------
   Quelle [112]
   Wissenschaftstheorie und methodische Funktion der Simulation
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
    112,
    'winsberg_science_computer_simulation_2010',
    'book',
    'Science in the Age of Computer Simulation',
    NULL,
    2010,
    2010,
    NULL,
    'The University of Chicago Press',
    'Chicago, London',
    NULL,
    NULL,
    NULL,
    'First Edition',
    NULL,
    '978-0-226-90204-3',
    'https://press.uchicago.edu/ucp/books/book/chicago/S/bo9003670.html',
    'en',
    1,
    'secondary',
    8,
    'verified',
    '3.8.2',
    'Erstnennung zur wissenschaftstheoretischen Funktion von Computersimulationen als Bindeglied zwischen Theorie, Modell, Berechnung und Interpretation.',
    'Winsberg, Eric (2010): Science in the Age of Computer Simulation. Chicago, London: The University of Chicago Press. ISBN: 978-0-226-90204-3.',
    'Winsberg (2010) [112]',
    'Wissenschaftstheoretische Referenz zur Erkenntnisfunktion, Reichweite und methodischen Einordnung von Computersimulationen.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 112
       OR source_key = 'winsberg_science_computer_simulation_2010'
);

SET @source_110 :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number = 110
    LIMIT 1
);

SET @source_111 :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number = 111
    LIMIT 1
);

SET @source_112 :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number = 112
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
    'Hairer',
    'Ernst',
    'Hairer, Ernst',
    NULL,
    1949,
    NULL,
    'Mitautor der Quelle [110].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Hairer, Ernst'
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
    'Nørsett',
    'Syvert P.',
    'Nørsett, Syvert P.',
    NULL,
    1944,
    NULL,
    'Mitautor der Quelle [110].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Nørsett, Syvert P.'
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
    'Wanner',
    'Gerhard',
    'Wanner, Gerhard',
    NULL,
    1942,
    NULL,
    'Mitautor der Quelle [110].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Wanner, Gerhard'
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
    'Strogatz',
    'Steven H.',
    'Strogatz, Steven H.',
    NULL,
    1959,
    NULL,
    'Autor der Quelle [111].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Strogatz, Steven H.'
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
    'Winsberg',
    'Eric',
    'Winsberg, Eric',
    NULL,
    NULL,
    NULL,
    'Autor der Quelle [112].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors
    WHERE normalized_name = 'Winsberg, Eric'
);

SET @author_hairer :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Hairer, Ernst'
    LIMIT 1
);

SET @author_norsett :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Nørsett, Syvert P.'
    LIMIT 1
);

SET @author_wanner :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Wanner, Gerhard'
    LIMIT 1
);

SET @author_strogatz :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Strogatz, Steven H.'
    LIMIT 1
);

SET @author_winsberg :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Winsberg, Eric'
    LIMIT 1
);

/* ============================================================
   6. Quelle-Autor-Verknüpfungen
   ============================================================ */

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_110, @author_hairer, 1, 'author'
WHERE @source_110 IS NOT NULL
  AND @author_hairer IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_110
      AND author_order = 1
      AND role = 'author'
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_110, @author_norsett, 2, 'author'
WHERE @source_110 IS NOT NULL
  AND @author_norsett IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_110
      AND author_order = 2
      AND role = 'author'
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_110, @author_wanner, 3, 'author'
WHERE @source_110 IS NOT NULL
  AND @author_wanner IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_110
      AND author_order = 3
      AND role = 'author'
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_111, @author_strogatz, 1, 'author'
WHERE @source_111 IS NOT NULL
  AND @author_strogatz IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_111
      AND author_order = 1
      AND role = 'author'
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT @source_112, @author_winsberg, 1, 'author'
WHERE @source_112 IS NOT NULL
  AND @author_winsberg IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_authors
    WHERE source_id = @source_112
      AND author_order = 1
      AND role = 'author'
);

/* ============================================================
   7. Quellenverwendungen in Abschnitt 3.8.2
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
    @source_110,
    @section_id,
    'first_citation',
    'Numerische Simulationen und iterative Berechnungsverfahren ermöglichen die reproduzierbare Untersuchung rekursiver Zustandsentwicklungen; Anfangsbedingungen, Parameter und numerische Verfahren müssen dazu eindeutig dokumentiert werden.',
    '3.8.2, Einleitung und Initialisierung des Zustandsraums',
    1,
    1,
    'Vollständige Erstnennung als Quelle [110].',
    @revision_id
WHERE @source_110 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id = @source_110
      AND section_id = @section_id
      AND is_first_mention = 1
);

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
    @source_111,
    @section_id,
    'first_citation',
    'Nichtlineare rekursive Systeme können stabile Zustände, Attraktoren, Bifurkationen und empfindliche Abhängigkeiten von Parametern oder Anfangsbedingungen hervorbringen.',
    '3.8.2, Parametrisierung und rekursive Zustandsentwicklung',
    1,
    1,
    'Vollständige Erstnennung als Quelle [111].',
    @revision_id
WHERE @source_111 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id = @source_111
      AND section_id = @section_id
      AND is_first_mention = 1
);

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
    @source_112,
    @section_id,
    'first_citation',
    'Computersimulationen bilden ein methodisches Bindeglied zwischen theoretischem Modell, rechnerischer Ausführung und wissenschaftlicher Interpretation; ihre Ergebnisse sind von Modellannahmen und Implementierungsentscheidungen zu trennen.',
    '3.8.2, Bewertung des rekonstruierten Zustands und methodische Einordnung',
    1,
    1,
    'Vollständige Erstnennung als Quelle [112].',
    @revision_id
WHERE @source_112 IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id = @source_112
      AND section_id = @section_id
      AND is_first_mention = 1
);

/* ============================================================
   8. Gleichungen (3.1243) bis (3.1257)
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
        '3.1243' AS equation_number,
        'Initialzustand der Simulation' AS title,
        'S_0=\\emptyset' AS equation_latex,
        'S_0=\\emptyset' AS word_latex,
        'Der Simulationslauf beginnt mit einem formal leeren Ausgangszustand ohne bereits ausgebildete funktionale Organisation.' AS plain_description,
        'model' AS equation_type,
        'original' AS provenance,
        NULL AS source_id,
        'Festlegung des mathematischen Anfangszustands.' AS derivation,
        'Die leere Menge bezeichnet einen formalen Simulationsstart und keine ontologische Aussage über ein absolutes Nichts.' AS assumptions

    UNION ALL SELECT
        '3.1244',
        'Zustandsraum der Simulation',
        '\\mathcal{S}=\\left\\{S_i\\mid i\\in\\mathbb{N}_0\\right\\}',
        '\\mathcal{S}=\\left\\{S_i\\mid i\\in\\mathbb{N}_0\\right\\}',
        'Der Zustandsraum enthält sämtliche innerhalb des Modells erreichbaren Simulationszustände.',
        'definition',
        'adapted',
        @source_110,
        'Mengendarstellung einer diskreten Zustandsfolge.',
        'Jeder Simulationszustand besitzt eine im Modell zulässige Repräsentation.'

    UNION ALL SELECT
        '3.1245',
        'Erster parametrisierter Transformationsschritt',
        'S_t^{\\prime}=\\sigma\\left(S_t,\\theta_\\sigma\\right)',
        'S_t^{\\prime}=\\sigma\\left(S_t,\\theta_\\sigma\\right)',
        'Der Operator sigma erzeugt aus dem aktuellen Zustand und seinem Parametersatz einen ersten Zwischenzustand.',
        'model',
        'original',
        NULL,
        'Überführung des ersten Operators der Kaskade in die Simulationsnotation.',
        'Der Operator sigma ist für den gegebenen Zustand und Parametersatz definiert.'

    UNION ALL SELECT
        '3.1246',
        'Parametervektor des Operators sigma',
        '\\theta_\\sigma=\\left(\\theta_{\\sigma,1},\\theta_{\\sigma,2},\\ldots,\\theta_{\\sigma,n}\\right)',
        '\\theta_\\sigma=\\left(\\theta_{\\sigma,1},\\theta_{\\sigma,2},\\ldots,\\theta_{\\sigma,n}\\right)',
        'Der Parametervektor bündelt die Freiheitsgrade des ersten Operators.',
        'definition',
        'adapted',
        @source_111,
        'Explizite Trennung von Operatorstruktur und Parametrisierung.',
        'Die zulässigen Wertebereiche werden im Versuchsdesign festgelegt.'

    UNION ALL SELECT
        '3.1247',
        'Strukturierung des ersten Zwischenzustands',
        'S_t^{\\prime\\prime}=M\\left(S_t^{\\prime}\\right)',
        'S_t^{\\prime\\prime}=M\\left(S_t^{\\prime}\\right)',
        'Der Operator M überführt den ersten Zwischenzustand in eine strukturierte und auswertbare Organisationsform.',
        'model',
        'original',
        NULL,
        'Zweiter Schritt der Operatorenkaskade.',
        'Die Parametrisierung von M wird in der Kurzform implizit mitgeführt.'

    UNION ALL SELECT
        '3.1248',
        'Parametrisierte strukturierende Abbildung',
        'S_t^{\\prime\\prime}=M\\left(S_t^{\\prime},\\theta_M\\right)',
        'S_t^{\\prime\\prime}=M\\left(S_t^{\\prime},\\theta_M\\right)',
        'Die allgemeine Form des Operators M berücksichtigt einen eigenen Parametersatz.',
        'model',
        'original',
        NULL,
        'Erweiterung der Kurzform um die explizite Parametrisierung.',
        'Der Parametervektor theta_M ist während eines Simulationslaufs eindeutig bestimmt.'

    UNION ALL SELECT
        '3.1249',
        'Rekonstruktion des Folgezustands',
        'S_{t+1}=R\\left(S_t^{\\prime\\prime}\\right)',
        'S_{t+1}=R\\left(S_t^{\\prime\\prime}\\right)',
        'Der Rekonstruktionsoperator erzeugt aus dem strukturierten Zwischenzustand den vollständigen Folgezustand.',
        'model',
        'original',
        NULL,
        'Dritter Schritt der Operatorenkaskade.',
        'Die Parametrisierung von R wird in der Kurzform implizit mitgeführt.'

    UNION ALL SELECT
        '3.1250',
        'Parametrisierte Rekonstruktion',
        'S_{t+1}=R\\left(S_t^{\\prime\\prime},\\theta_R\\right)',
        'S_{t+1}=R\\left(S_t^{\\prime\\prime},\\theta_R\\right)',
        'Die allgemeine Rekonstruktion berücksichtigt den Parametersatz des Operators R.',
        'model',
        'original',
        NULL,
        'Erweiterung der Rekonstruktionsgleichung um die explizite Parametrisierung.',
        'Der Parametervektor theta_R ist für den Simulationslauf festgelegt.'

    UNION ALL SELECT
        '3.1251',
        'Evaluation des rekonstruierten Zustands',
        'S_{t+1}^{(E)}=E\\left(S_{t+1}\\right)',
        'S_{t+1}^{(E)}=E\\left(S_{t+1}\\right)',
        'Der Evaluationsoperator berechnet aus dem Folgezustand die für die Analyse benötigten Bewertungsgrößen.',
        'model',
        'adapted',
        @source_112,
        'Trennung von Zustandsbildung und Zustandsbewertung.',
        'Die Evaluation verändert den rekonstruierten Zustand nicht.'

    UNION ALL SELECT
        '3.1252',
        'Allgemeiner Bewertungsvektor',
        '\\mathbf{e}=\\left(K,V,D,C\\right)',
        '\\mathbf{e}=\\left(K,V,D,C\\right)',
        'Der Bewertungsvektor umfasst Kohärenz, Validität, Distanz und Konvergenz.',
        'definition',
        'original',
        NULL,
        'Zusammenfassung der im Simulationsmodell verwendeten Bewertungsgrößen.',
        'Die konkrete Operationalisierung der Komponenten erfolgt im Versuchsdesign.'

    UNION ALL SELECT
        '3.1253',
        'Kohärenz- und Validitätsbedingung',
        'K\\left(S_{t+1}\\right)\\geq\\kappa_{\\min},\\qquad V\\left(S_{t+1}\\right)=1',
        'K\\left(S_{t+1}\\right)\\geq\\kappa_{\\min},\\qquad V\\left(S_{t+1}\\right)=1',
        'Ein Folgezustand wird nur fortgeführt, wenn er die Mindestkohärenz erreicht und formal gültig ist.',
        'metric',
        'original',
        NULL,
        'Gemeinsame Zulässigkeitsbedingung des Simulationsmodells.',
        'K und V prüfen voneinander verschiedene Eigenschaften des Zustands.'

    UNION ALL SELECT
        '3.1254',
        'Binäre Validitätsfunktion',
        'V(S)=\\begin{cases}1,&S\\text{ erfüllt sämtliche Modellbedingungen},\\\\0,&\\text{sonst}.\\end{cases}',
        'V(S)=\\begin{cases}1,&S\\text{ erfüllt sämtliche Modellbedingungen},\\\\0,&\\text{sonst}.\\end{cases}',
        'Die Validitätsfunktion ordnet einem Zustand den Wert eins bei vollständiger Modellgültigkeit und sonst den Wert null zu.',
        'definition',
        'original',
        NULL,
        'Explizite Definition der binären Zustandsprüfung.',
        'Die Menge der Modellbedingungen ist vor dem Simulationslauf vollständig festzulegen.'

    UNION ALL SELECT
        '3.1255',
        'Komposition der Operatorenkaskade',
        '\\mathcal{F}=R\\circ M\\circ\\sigma',
        '\\mathcal{F}=R\\circ M\\circ\\sigma',
        'Der Kaskadenoperator fasst Transformation, Strukturierung und Rekonstruktion zu einer geordneten Komposition zusammen.',
        'definition',
        'adapted',
        @source_111,
        'Komposition der drei zustandsbildenden Operatoren.',
        'Die Operatoren werden von rechts nach links angewendet.'

    UNION ALL SELECT
        '3.1256',
        'Parametrisierte rekursive Zustandsentwicklung',
        'S_{t+1}=\\mathcal{F}\\left(S_t;\\theta_\\sigma,\\theta_M,\\theta_R\\right)',
        'S_{t+1}=\\mathcal{F}\\left(S_t;\\theta_\\sigma,\\theta_M,\\theta_R\\right)',
        'Der Folgezustand entsteht durch Anwendung des parametrisierten Kaskadenoperators auf den aktuellen Zustand.',
        'model',
        'adapted',
        @source_111,
        'Kompakte Zusammenfassung der vollständigen Zustandsrekursion.',
        'Die Parameter sind entweder konstant oder werden nach einer ausdrücklich definierten Regel verändert.'

    UNION ALL SELECT
        '3.1257',
        'Zustandstrajektorie des Simulationslaufs',
        '\\Gamma=\\left(S_0,S_1,\\ldots,S_T\\right)',
        '\\Gamma=\\left(S_0,S_1,\\ldots,S_T\\right)',
        'Die Trajektorie enthält den vollständigen Entwicklungsweg vom Anfangszustand bis zum letzten ausgewerteten Zustand.',
        'definition',
        'adapted',
        @source_110,
        'Zusammenfassung der rekursiv berechneten Zustandsfolge.',
        'Der letzte Index T bezeichnet den letzten ausgeführten oder gültigen Simulationsschritt.'
) AS x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number = x.equation_number
);

/* ============================================================
   9. Änderungsprotokoll
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
    'created',
    'section',
    '3.8.2',
    'Abschnitt 3.8.2 wurde mit vollständiger Literaturdokumentation und mathematischem Simulationsmodell angelegt.',
    NULL,
    'draft',
    NOW()
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'created'
      AND object_reference = '3.8.2'
);

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
    'source_added',
    'sources',
    '[110]-[112]',
    'Drei vollständige Quellen zur numerischen Simulation, nichtlinearen Dynamik und wissenschaftstheoretischen Einordnung von Computersimulationen wurden einschließlich Autoren und Quellenverwendungen aufgenommen.',
    'next_citation_number=110',
    'next_citation_number=113',
    NOW()
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'source_added'
      AND object_reference = '[110]-[112]'
);

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
    'equation_added',
    'equations',
    '3.1243-3.1257',
    'Fünfzehn Gleichungen zum Simulationsmodell, zur Parametrisierung, Bewertung und Zustandstrajektorie wurden registriert.',
    'last_equation=3.1242',
    'last_equation=3.1257',
    NOW()
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'equation_added'
      AND object_reference = '3.1243-3.1257'
);

/* ============================================================
   10. Abschlussprüfung
   ============================================================ */

SET @source_count :=
(
    SELECT COUNT(*)
    FROM sources
    WHERE citation_number BETWEEN 110 AND 112
);

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id = @section_id
      AND source_id IN (@source_110, @source_111, @source_112)
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id = @section_id
      AND equation_number IN
      (
          '3.1243','3.1244','3.1245','3.1246','3.1247',
          '3.1248','3.1249','3.1250','3.1251','3.1252',
          '3.1253','3.1254','3.1255','3.1256','3.1257'
      )
);

SET @audit_ok :=
(
    @parent_section_id IS NOT NULL
    AND @revision_id IS NOT NULL
    AND @section_id IS NOT NULL
    AND @source_count = 3
    AND @source_usage_count = 3
    AND @equation_count = 15
);

COMMIT;

/* ============================================================
   11. Abschlussausgabe
   ============================================================ */

SELECT
    @audit_ok AS audit_ok,
    @revision_id AS revision_id,
    @section_id AS section_id,
    @source_count AS source_count,
    @source_usage_count AS source_usage_count,
    @equation_count AS equation_count,
    CASE
        WHEN @audit_ok = 1
        THEN 'Kapitel 3.8.2 wurde vollständig und schema-konform importiert.'
        ELSE 'FEHLER: Abschnitt, Quellen, Quellenverwendungen oder Gleichungen sind unvollständig.'
    END AS audit_message;

SELECT
    citation_number,
    full_citation_text,
    verification_status
FROM sources
WHERE citation_number BETWEEN 110 AND 112
ORDER BY citation_number;

SELECT
    equation_number,
    title,
    validation_status
FROM equations
WHERE section_id = @section_id
  AND equation_number BETWEEN '3.1243' AND '3.1257'
ORDER BY CAST(SUBSTRING_INDEX(equation_number, '.', -1) AS UNSIGNED);
