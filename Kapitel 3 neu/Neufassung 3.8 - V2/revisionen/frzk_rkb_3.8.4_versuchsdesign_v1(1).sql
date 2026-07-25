/* ============================================================
   FRZK Repository-Update
   Kapitel 3.8.4 – Versuchsdesign und Simulationsszenarien
   Version 1.0

   Aufbauend auf:
   - RKB-K3.8.3-V1
   - Gleichungsstand nach Abschnitt 3.8.3: (3.1270)
   - Literaturstand nach Abschnitt 3.8.3: [114]

   Zuordnung Manuskript -> Repository:
   (3.483)–(3.502) -> (3.1271)–(3.1290)

   Das Skript ist idempotent.
   ============================================================ */

START TRANSACTION;

/* ============================================================
   1. Grundvariablen und Vorbedingungen
   ============================================================ */

SET @revision_code := 'RKB-K3.8.4-V1';

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
        'RKB-K3.8.3-V1',
        'RKB-K3.8.2-V2',
        'RKB-K3.8.2-V1',
        'RKB-K3.8.1-V1',
        'RKB-K3.8-V1'
    )
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.3-V1' THEN 1
            WHEN 'RKB-K3.8.2-V2' THEN 2
            WHEN 'RKB-K3.8.2-V1' THEN 3
            WHEN 'RKB-K3.8.1-V1' THEN 4
            WHEN 'RKB-K3.8-V1' THEN 5
            ELSE 6
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
    '3.8.4',
    '1.0',
    'Abschnitt 3.8.4 Versuchsdesign und Simulationsszenarien: Zielgrößen, Baseline, Einzel- und Mehrparametervariationen, Grenz- und Fehlerszenarien, Anfangswertrobustheit, Wiederholungen, Versuchsmenge und Auswertungsmatrix.',
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
   3. Abschnitt 3.8.4
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
    '3.8.4',
    'Versuchsdesign und Simulationsszenarien',
    3,
    3.8400,
    'draft',
    1,
    'Systematisches Versuchsdesign für die Operatorenkaskade mit Zielgrößen, Baseline-Szenario, Einzel- und Mehrparametervariationen, Grenz- und Fehlerszenarien, Anfangswertrobustheit, Wiederholungsprüfung und Auswertungsmatrix. Manuskriptgleichungen (3.483) bis (3.502) werden repositoryseitig als (3.1271) bis (3.1290) geführt.'
WHERE @parent_section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.4'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Versuchsdesign und Simulationsszenarien',
    chapter_no = 3,
    section_order = 3.8400,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Systematisches Versuchsdesign für die Operatorenkaskade mit Zielgrößen, Baseline-Szenario, Einzel- und Mehrparametervariationen, Grenz- und Fehlerszenarien, Anfangswertrobustheit, Wiederholungsprüfung und Auswertungsmatrix. Manuskriptgleichungen (3.483) bis (3.502) werden repositoryseitig als (3.1271) bis (3.1290) geführt.'
WHERE section_code = '3.8.4';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.4'
    LIMIT 1
);

/* ============================================================
   4. Vollständige Literaturquelle [115]
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
    115,
    'kleijnen_design_analysis_simulation_2015',
    'book',
    'Design and Analysis of Simulation Experiments',
    NULL,
    2008,
    2015,
    NULL,
    'Springer International Publishing',
    'Cham',
    NULL,
    NULL,
    'xviii + 322',
    'Second Edition',
    '10.1007/978-3-319-18087-8',
    '978-3-319-18086-1',
    'https://link.springer.com/book/10.1007/978-3-319-18087-8',
    'en',
    1,
    'textbook',
    9,
    'verified',
    '3.8.4',
    'Erstnennung zum Entwurf, zur Durchführung und zur Auswertung kontrollierter Simulationsexperimente sowie zur Auswahl geeigneter Versuchspläne.',
    'Kleijnen, Jack P. C. (2015): Design and Analysis of Simulation Experiments. Second Edition. Cham: Springer International Publishing. DOI: 10.1007/978-3-319-18087-8. ISBN: 978-3-319-18086-1.',
    'Kleijnen (2015) [115]',
    'Grundlagenwerk zum statistischen und methodischen Entwurf von Simulationsexperimenten.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 115
       OR source_key = 'kleijnen_design_analysis_simulation_2015'
);

SET @source_111 := (SELECT source_id FROM sources WHERE citation_number = 111 LIMIT 1);
SET @source_112 := (SELECT source_id FROM sources WHERE citation_number = 112 LIMIT 1);
SET @source_114 := (SELECT source_id FROM sources WHERE citation_number = 114 LIMIT 1);
SET @source_115 := (SELECT source_id FROM sources WHERE citation_number = 115 LIMIT 1);

/* ============================================================
   5. Autor und Quelle-Autor-Verknüpfung
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
    'Kleijnen',
    'Jack P. C.',
    'Kleijnen, Jack P. C.',
    NULL,
    1941,
    NULL,
    'Autor der Quelle [115].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name = 'Kleijnen, Jack P. C.'
);

SET @author_kleijnen :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Kleijnen, Jack P. C.'
    LIMIT 1
);

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT
    @source_115,
    @author_kleijnen,
    1,
    'author'
WHERE @source_115 IS NOT NULL
  AND @author_kleijnen IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM source_authors
    WHERE source_id = @source_115
      AND author_order = 1
      AND role = 'author'
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
    x.is_first_mention,
    1,
    x.notes,
    @revision_id
FROM
(
    SELECT
        @source_112 source_id,
        'method' usage_type,
        'Computersimulationen sind als methodisches Bindeglied zwischen mathematischem Modell, numerischer Umsetzung und wissenschaftlicher Interpretation zu behandeln; die Entscheidungen des Versuchsdesigns müssen deshalb transparent dokumentiert werden.' claim_summary,
        '3.8.4, Einleitung und methodische Begrenzung' exact_location,
        0 is_first_mention,
        'Wiederverwendung der Quelle [112].' notes

    UNION ALL SELECT
        @source_114,
        'method',
        'Einzelfaktoranalysen reichen bei nichtlinearen Modellen nicht aus, weil Wechselwirkungen und gemeinsame Parametereffekte unberücksichtigt bleiben können.',
        '3.8.4, Einzel- und Mehrparametervariationen',
        0,
        'Wiederverwendung der Quelle [114].'

    UNION ALL SELECT
        @source_111,
        'background',
        'Nichtlineare rekursive Systeme können in der Nähe kritischer Parameterwerte qualitative Zustandsänderungen, Bifurkationen oder eine hohe Anfangswertsensitivität zeigen.',
        '3.8.4, Grenzszenarien und Robustheit gegenüber Anfangsbedingungen',
        0,
        'Wiederverwendung der Quelle [111].'

    UNION ALL SELECT
        @source_115,
        'first_citation',
        'Die Wahl eines Simulationsversuchsplans richtet sich danach, ob Haupteffekte, Wechselwirkungen, Unsicherheiten, Robustheit oder Optimierungsbereiche untersucht werden sollen.',
        '3.8.4, Gemeinsame Variation mehrerer Parameter und Versuchsplan',
        1,
        'Vollständige Erstnennung als Quelle [115].'
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
        '3.8.4.1' definition_number,
        'Zielgrößenvektor' title,
        'Der Zielgrößenvektor fasst die zur Bewertung eines Simulationslaufs verwendeten Endgrößen Kohärenz, Referenzabweichung, Konvergenz, Iterationszahl und Validität zusammen.' definition_text,
        '\\mathbf{Y}(\\Sigma)=\\left(K_T,D_T,C_T,N_T,V_T\\right)' formal_latex,
        '\\mathbf{Y}(\\Sigma)=\\left(K_T,D_T,C_T,N_T,V_T\\right)' word_latex,
        'original' provenance,
        NULL source_id,
        'Die fünf Zielgrößen sind für jeden ausgewerteten Simulationslauf definiert.' assumptions,
        'Grundlage des vergleichenden Versuchsdesigns.' notes

    UNION ALL SELECT
        '3.8.4.2',
        'Baseline-Szenario',
        'Das Baseline-Szenario ist eine methodisch festgelegte Referenzkonfiguration, gegenüber der sämtliche kontrollierten Varianten verglichen werden.',
        '\\Sigma^{(0)}=\\left(S_0,\\Theta^{(0)},\\kappa_{\\min}^{(0)},\\varepsilon^{(0)},T_{\\max}^{(0)}\\right)',
        '\\Sigma^{(0)}=\\left(S_0,\\Theta^{(0)},\\kappa_{\\min}^{(0)},\\varepsilon^{(0)},T_{\\max}^{(0)}\\right)',
        'original',
        NULL,
        'Die Referenzwerte aller Komponenten sind vollständig dokumentiert.',
        'Das Baseline-Szenario ist kein empirisch bestätigter Normalzustand.'

    UNION ALL SELECT
        '3.8.4.3',
        'Grenzszenario',
        'Ein Grenzszenario liegt vor, wenn mindestens ein Parameter einen unteren oder oberen Rand seines zulässigen Intervalls annimmt.',
        '\\theta_i\\in\\left\\{\\inf I_i,\\sup I_i\\right\\}',
        '\\theta_i\\in\\left\\{\\inf I_i,\\sup I_i\\right\\}',
        'adapted',
        @source_115,
        'Das zulässige Intervall I_i ist bestimmt und nicht leer.',
        'Dient der Prüfung des Modellverhaltens an Randwerten.'

    UNION ALL SELECT
        '3.8.4.4',
        'Fehlerszenario',
        'Ein Fehlerszenario liegt vor, wenn die vollständige Parametrisierung den zulässigen Parameterraum verlässt.',
        '\\Theta\\notin\\Omega_{\\Theta}',
        '\\Theta\\notin\\Omega_{\\Theta}',
        'original',
        NULL,
        'Der zulässige Parameterraum Omega_Theta wurde zuvor definiert.',
        'Ein Fehlerszenario darf nicht als regulärer Modelllauf interpretiert werden.'

    UNION ALL SELECT
        '3.8.4.5',
        'Versuchsmenge',
        'Die Versuchsmenge enthält die Baseline-Konfiguration sowie alle Einzelparameter-, Mehrparameter-, Grenz-, Fehler- und Anfangswertszenarien.',
        '\\mathcal{E}=\\left\\{\\Sigma^{(0)},\\Sigma_i^{(\\delta)},\\Sigma_{ij}^{(\\delta_i,\\delta_j)},\\Sigma^{(\\mathrm{G})},\\Sigma^{(\\mathrm{F})},\\Sigma^{(\\mathrm{A})}\\right\\}',
        '\\mathcal{E}=\\left\\{\\Sigma^{(0)},\\Sigma_i^{(\\delta)},\\Sigma_{ij}^{(\\delta_i,\\delta_j)},\\Sigma^{(\\mathrm{G})},\\Sigma^{(\\mathrm{F})},\\Sigma^{(\\mathrm{A})}\\right\\}',
        'original',
        NULL,
        'Jede Konfiguration der Versuchsmenge besitzt eine eindeutige Kennung und vollständige Dokumentation.',
        'Zusammenfassung des vollständigen experimentellen Designs.'
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
   8. Gleichungen (3.1271) bis (3.1290)
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
        '3.1271' equation_number,
        'Zielgrößenvektor' title,
        '\\mathbf{Y}(\\Sigma)=\\left(K_T,D_T,C_T,N_T,V_T\\right)' equation_latex,
        '\\mathbf{Y}(\\Sigma)=\\left(K_T,D_T,C_T,N_T,V_T\\right)' word_latex,
        'Der Vektor fasst die zentralen Ergebnisgrößen eines Simulationslaufs zusammen.' plain_description,
        'definition' equation_type,
        'original' provenance,
        NULL source_id,
        'Zusammenstellung der für den Vergleich verwendeten Endgrößen.' derivation,
        'Alle Komponenten sind für den betrachteten Lauf definiert.' assumptions

    UNION ALL SELECT
        '3.1272',
        'Endkohärenz',
        'K_T=K(S_T)',
        'K_T=K(S_T)',
        'Die Endkohärenz ist der Kohärenzwert des letzten ausgewerteten Zustands.',
        'metric',
        'original',
        NULL,
        'Anwendung des Kohärenzmaßes auf den Endzustand.',
        'S_T ist formal gültig oder als Abbruchzustand gekennzeichnet.'

    UNION ALL SELECT
        '3.1273',
        'Endabweichung vom Referenzzustand',
        'D_T=d(S_T,S_{\\mathrm{ref}})',
        'D_T=d(S_T,S_{\\mathrm{ref}})',
        'Die Endabweichung misst den Abstand des letzten Zustands zu einem festgelegten Referenzzustand.',
        'metric',
        'original',
        NULL,
        'Anwendung der Distanzfunktion auf End- und Referenzzustand.',
        'Die Distanzfunktion d und der Referenzzustand sind für die Simulationsreihe festgelegt.'

    UNION ALL SELECT
        '3.1274',
        'Baseline-Konfiguration',
        '\\Sigma^{(0)}=\\left(S_0,\\Theta^{(0)},\\kappa_{\\min}^{(0)},\\varepsilon^{(0)},T_{\\max}^{(0)}\\right)',
        '\\Sigma^{(0)}=\\left(S_0,\\Theta^{(0)},\\kappa_{\\min}^{(0)},\\varepsilon^{(0)},T_{\\max}^{(0)}\\right)',
        'Die Baseline bündelt die Referenzwerte aller für den Simulationslauf maßgeblichen Größen.',
        'definition',
        'original',
        NULL,
        'Spezialisierung der allgemeinen Simulationskonfiguration.',
        'Alle Referenzwerte sind vollständig dokumentiert.'

    UNION ALL SELECT
        '3.1275',
        'Referenztrajektorie',
        '\\Gamma^{(0)}=\\Gamma\\left(\\Sigma^{(0)}\\right)',
        '\\Gamma^{(0)}=\\Gamma\\left(\\Sigma^{(0)}\\right)',
        'Die Baseline-Konfiguration erzeugt die Referenztrajektorie.',
        'model',
        'original',
        NULL,
        'Anwendung der Trajektorienabbildung auf die Baseline.',
        'Die Operatorenkaskade ist für Sigma^(0) wohldefiniert.'

    UNION ALL SELECT
        '3.1276',
        'Einzelparametervariation',
        '\\Sigma_i^{(\\delta)}=\\left(S_0,\\Theta^{(0)}+\\delta\\mathbf{e}_i,\\kappa_{\\min}^{(0)},\\varepsilon^{(0)},T_{\\max}^{(0)}\\right)',
        '\\Sigma_i^{(\\delta)}=\\left(S_0,\\Theta^{(0)}+\\delta\\mathbf{e}_i,\\kappa_{\\min}^{(0)},\\varepsilon^{(0)},T_{\\max}^{(0)}\\right)',
        'Genau eine Parameterkomponente wird gegenüber der Baseline um delta verändert.',
        'model',
        'adapted',
        @source_114,
        'Lokale Einzelfaktoranalyse.',
        'Die variierte Parametrisierung bleibt im zulässigen Parameterraum.'

    UNION ALL SELECT
        '3.1277',
        'Änderung einer Zielgröße',
        '\\Delta Y_{j,i}^{(\\delta)}=Y_j\\left(\\Sigma_i^{(\\delta)}\\right)-Y_j\\left(\\Sigma^{(0)}\\right)',
        '\\Delta Y_{j,i}^{(\\delta)}=Y_j\\left(\\Sigma_i^{(\\delta)}\\right)-Y_j\\left(\\Sigma^{(0)}\\right)',
        'Die Veränderung einer Zielgröße wird gegenüber der Baseline bestimmt.',
        'metric',
        'adapted',
        @source_114,
        'Differenz zwischen variierter und referenzierter Zielgröße.',
        'Beide Zielgrößen sind gleich skaliert.'

    UNION ALL SELECT
        '3.1278',
        'Gemeinsame Variation zweier Parameter',
        '\\Theta_{ij}^{(\\delta_i,\\delta_j)}=\\Theta^{(0)}+\\delta_i\\mathbf{e}_i+\\delta_j\\mathbf{e}_j',
        '\\Theta_{ij}^{(\\delta_i,\\delta_j)}=\\Theta^{(0)}+\\delta_i\\mathbf{e}_i+\\delta_j\\mathbf{e}_j',
        'Zwei Parameterkomponenten werden gleichzeitig gegenüber der Baseline verändert.',
        'model',
        'adapted',
        @source_114,
        'Erweiterung der Einzelfaktoranalyse auf eine Zweifaktorkombination.',
        'Die gemeinsame Parametrisierung liegt im zulässigen Parameterraum.'

    UNION ALL SELECT
        '3.1279',
        'Nichtadditive Parameterwechselwirkung',
        'I_{ij}=\\Delta\\mathbf{Y}_{ij}-\\Delta\\mathbf{Y}_i-\\Delta\\mathbf{Y}_j',
        'I_{ij}=\\Delta\\mathbf{Y}_{ij}-\\Delta\\mathbf{Y}_i-\\Delta\\mathbf{Y}_j',
        'Die Abweichung der gemeinsamen Wirkung von der Summe der Einzelwirkungen beschreibt die nichtadditive Wechselwirkung.',
        'metric',
        'adapted',
        @source_114,
        'Vergleich gemeinsamer und separater Parametereffekte.',
        'Die Zielgrößenvektoren sind komponentenweise vergleichbar.'

    UNION ALL SELECT
        '3.1280',
        'Randwert eines Parameters',
        '\\theta_i\\in\\left\\{\\inf I_i,\\sup I_i\\right\\}',
        '\\theta_i\\in\\left\\{\\inf I_i,\\sup I_i\\right\\}',
        'Ein Parameter nimmt einen unteren oder oberen Randwert seines zulässigen Intervalls an.',
        'model',
        'adapted',
        @source_115,
        'Definition eines Grenzszenarios.',
        'Die Intervallgrenzen existieren.'

    UNION ALL SELECT
        '3.1281',
        'Unzulässige Parametrisierung',
        '\\Theta\\notin\\Omega_{\\Theta}',
        '\\Theta\\notin\\Omega_{\\Theta}',
        'Die Parametrisierung liegt außerhalb des zulässigen Parameterraums.',
        'constraint',
        'original',
        NULL,
        'Formale Kennzeichnung eines Fehlerszenarios.',
        'Omega_Theta ist zuvor definiert.'

    UNION ALL SELECT
        '3.1282',
        'Kohärenz nahe der Gültigkeitsgrenze',
        'K(S_t)=\\kappa_{\\min}\\pm\\eta',
        'K(S_t)=\\kappa_{\\min}\\pm\\eta',
        'Der Kohärenzwert wird in unmittelbarer Nähe der Mindestkohärenz untersucht.',
        'metric',
        'adapted',
        @source_111,
        'Randbetrachtung eines potenziellen Übergangsbereichs.',
        'Eta ist eine kleine positive Größe.'

    UNION ALL SELECT
        '3.1283',
        'Lineare Anfangszustandsstörung',
        'S_0^{(\\delta)}=S_0+\\delta S',
        'S_0^{(\\delta)}=S_0+\\delta S',
        'Der Anfangszustand wird durch eine additive Störung verändert.',
        'model',
        'adapted',
        @source_111,
        'Spezialfall einer Anfangswertvariation in einem linearen Zustandsraum.',
        'Der Zustandsraum erlaubt die verwendete Addition.'

    UNION ALL SELECT
        '3.1284',
        'Trajektorie des gestörten Anfangszustands',
        '\\Gamma^{(\\delta)}=\\Gamma\\left(S_0^{(\\delta)},\\Theta^{(0)}\\right)',
        '\\Gamma^{(\\delta)}=\\Gamma\\left(S_0^{(\\delta)},\\Theta^{(0)}\\right)',
        'Die veränderte Anfangskonfiguration erzeugt eine eigene Trajektorie.',
        'model',
        'original',
        NULL,
        'Anwendung der Trajektorienabbildung auf den gestörten Anfangszustand.',
        'Die Referenzparametrisierung bleibt unverändert.'

    UNION ALL SELECT
        '3.1285',
        'Allgemeine Anfangszustandsstörung',
        'S_0^{(\\delta)}=P_{\\delta}(S_0)',
        'S_0^{(\\delta)}=P_{\\delta}(S_0)',
        'Eine allgemeine Störungsabbildung ersetzt die additive Schreibweise, wenn keine lineare Struktur vorausgesetzt werden darf.',
        'model',
        'original',
        NULL,
        'Verallgemeinerung der Anfangswertvariation.',
        'P_delta bildet zulässige Anfangszustände auf zulässige Anfangszustände ab.'

    UNION ALL SELECT
        '3.1286',
        'Abstand gestörter Trajektorien',
        'D_{\\Gamma}(\\delta)=d_{\\Gamma}\\left(\\Gamma^{(\\delta)},\\Gamma^{(0)}\\right)',
        'D_{\\Gamma}(\\delta)=d_{\\Gamma}\\left(\\Gamma^{(\\delta)},\\Gamma^{(0)}\\right)',
        'Die Anfangswertsensitivität wird durch den Abstand zwischen gestörter und referenzierter Trajektorie bewertet.',
        'metric',
        'adapted',
        @source_111,
        'Vergleich zweier vollständiger Zustandstrajektorien.',
        'Die Trajektoriendistanz d_Gamma ist definiert.'

    UNION ALL SELECT
        '3.1287',
        'Deterministische Wiederholungsbedingung',
        '\\Gamma_1=\\Gamma_2=\\cdots=\\Gamma_m',
        '\\Gamma_1=\\Gamma_2=\\cdots=\\Gamma_m',
        'Identische deterministische Wiederholungen müssen dieselbe Trajektorie erzeugen.',
        'validation',
        'original',
        NULL,
        'Technische Reproduzierbarkeitsprüfung der Implementierung.',
        'Alle Wiederholungen verwenden identische Konfigurationen.'

    UNION ALL SELECT
        '3.1288',
        'Stochastisch erweiterte Simulationskonfiguration',
        '\\Sigma_z=\\left(\\Sigma,z\\right)',
        '\\Sigma_z=\\left(\\Sigma,z\\right)',
        'Eine stochastische Erweiterung ergänzt die Simulationskonfiguration um den Startwert des Zufallszahlengenerators.',
        'definition',
        'adapted',
        @source_115,
        'Erweiterung der deterministischen Konfiguration.',
        'Der Zufallszahlengenerator ist vollständig spezifiziert.'

    UNION ALL SELECT
        '3.1289',
        'Versuchsmenge',
        '\\mathcal{E}=\\left\\{\\Sigma^{(0)},\\Sigma_i^{(\\delta)},\\Sigma_{ij}^{(\\delta_i,\\delta_j)},\\Sigma^{(\\mathrm{G})},\\Sigma^{(\\mathrm{F})},\\Sigma^{(\\mathrm{A})}\\right\\}',
        '\\mathcal{E}=\\left\\{\\Sigma^{(0)},\\Sigma_i^{(\\delta)},\\Sigma_{ij}^{(\\delta_i,\\delta_j)},\\Sigma^{(\\mathrm{G})},\\Sigma^{(\\mathrm{F})},\\Sigma^{(\\mathrm{A})}\\right\\}',
        'Die Versuchsmenge umfasst sämtliche vorgesehenen Szenarioklassen.',
        'definition',
        'original',
        NULL,
        'Zusammenfassung des vollständigen Versuchsplans.',
        'Jede enthaltene Konfiguration ist eindeutig identifizierbar.'

    UNION ALL SELECT
        '3.1290',
        'Auswertungsmatrix',
        '\\mathbf{A}=\\begin{pmatrix}Y_1(\\Sigma_1)&Y_2(\\Sigma_1)&\\cdots&Y_m(\\Sigma_1)\\\\Y_1(\\Sigma_2)&Y_2(\\Sigma_2)&\\cdots&Y_m(\\Sigma_2)\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\Y_1(\\Sigma_n)&Y_2(\\Sigma_n)&\\cdots&Y_m(\\Sigma_n)\\end{pmatrix}',
        '\\mathbf{A}=\\begin{pmatrix}Y_1(\\Sigma_1)&Y_2(\\Sigma_1)&\\cdots&Y_m(\\Sigma_1)\\\\Y_1(\\Sigma_2)&Y_2(\\Sigma_2)&\\cdots&Y_m(\\Sigma_2)\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\Y_1(\\Sigma_n)&Y_2(\\Sigma_n)&\\cdots&Y_m(\\Sigma_n)\\end{pmatrix}',
        'Jede Zeile der Matrix beschreibt einen Simulationslauf und jede Spalte eine Zielgröße.',
        'matrix',
        'adapted',
        @source_115,
        'Tabellarische Zusammenführung der Versuchsergebnisse.',
        'Alle Zielgrößen sind für jeden regulär ausgewerteten Lauf definiert.'
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
    x.notes,
    'draft',
    @revision_id
FROM
(
    SELECT '\\mathbf{Y}' symbol_latex,'\\mathbf{Y}' symbol_word_latex,'Zielgrößenvektor' symbol_name,
           'Vektor der bewerteten Ergebnisgrößen eines Simulationslaufs.' definition_text,
           '3.1271' first_equation_number,'R^5' domain_text,NULL codomain_text,1 is_vector,0 is_matrix,0 is_operator,'Abschnittssymbol 3.8.4.' notes
    UNION ALL SELECT 'K_T','K_T','Endkohärenz','Kohärenz des letzten ausgewerteten Zustands.','3.1271','R',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'D_T','D_T','Endabweichung','Distanz des Endzustands zum Referenzzustand.','3.1271','R_ge_0',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'C_T','C_T','Endkonvergenz','Konvergenzmaß des letzten ausgewerteten Zustands.','3.1271','R',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'N_T','N_T','Iterationszahl','Tatsächlich ausgeführte Anzahl von Iterationen.','3.1271','N_0',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'V_T','V_T','Endvalidität','Formale Validität des letzten Zustands.','3.1271','{0,1}',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT '\\Sigma^{(0)}','\\Sigma^{(0)}','Baseline-Konfiguration','Referenzkonfiguration des Versuchsdesigns.','3.1274',NULL,NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT '\\Gamma^{(0)}','\\Gamma^{(0)}','Referenztrajektorie','Durch die Baseline erzeugte Zustandstrajektorie.','3.1275','Trajektorienraum',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT '\\mathbf{e}_i','\\mathbf{e}_i','Einheitsvektor','Einheitsvektor der i-ten Parameterkomponente.','3.1276','R^n',NULL,1,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'I_{ij}','I_{ij}','Parameterwechselwirkung','Nichtadditiver gemeinsamer Effekt der Parameter i und j.','3.1279','R^m',NULL,1,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT '\\eta','\\eta','Randstörung','Kleine positive Abweichung von der Mindestkohärenz.','3.1282','R_{>0}',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'P_{\\delta}','P_{\\delta}','Störungsabbildung','Allgemeine Abbildung zur Variation des Anfangszustands.','3.1285','Zustandsraum','Zustandsraum',0,0,1,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'D_{\\Gamma}','D_{\\Gamma}','Trajektorienabstand','Abstand zwischen gestörter und referenzierter Trajektorie.','3.1286','R_{ge_0}',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT 'z','z','Zufallsstartwert','Startwert des Zufallszahlengenerators.','3.1288','N_0',NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT '\\mathcal{E}','\\mathcal{E}','Versuchsmenge','Menge aller untersuchten Simulationskonfigurationen.','3.1289',NULL,NULL,0,0,0,'Abschnittssymbol 3.8.4.'
    UNION ALL SELECT '\\mathbf{A}','\\mathbf{A}','Auswertungsmatrix','Matrix der Zielgrößen aller Simulationsläufe.','3.1290','R^{n\\times m}',NULL,0,1,0,'Abschnittssymbol 3.8.4.'
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
    SELECT '3.1271' equation_number,'\\mathbf{Y}' symbol_latex,'Zielgrößenvektor' symbol_name,'Vektor aller Auswertungsgrößen.' definition_text,'R^5' domain_text,1 symbol_order
    UNION ALL SELECT '3.1271','K_T','Endkohärenz','Kohärenz des Endzustands.','R',2
    UNION ALL SELECT '3.1271','D_T','Endabweichung','Distanz zum Referenzzustand.','R_ge_0',3
    UNION ALL SELECT '3.1271','C_T','Endkonvergenz','Konvergenzmaß des Endzustands.','R',4
    UNION ALL SELECT '3.1271','N_T','Iterationszahl','Anzahl ausgeführter Iterationen.','N_0',5
    UNION ALL SELECT '3.1271','V_T','Endvalidität','Formale Validität des Endzustands.','{0,1}',6
    UNION ALL SELECT '3.1276','\\mathbf{e}_i','Einheitsvektor','Einheitsvektor der variierten Parameterkomponente.','R^n',1
    UNION ALL SELECT '3.1279','I_{ij}','Parameterwechselwirkung','Nichtadditiver gemeinsamer Effekt zweier Parameter.','R^m',1
    UNION ALL SELECT '3.1282','\\eta','Randstörung','Kleine positive Abweichung von der Mindestkohärenz.','R_{>0}',1
    UNION ALL SELECT '3.1285','P_{\\delta}','Störungsabbildung','Allgemeine Variation des Anfangszustands.','Zustandsraum -> Zustandsraum',1
    UNION ALL SELECT '3.1286','D_{\\Gamma}','Trajektorienabstand','Abstand zwischen zwei vollständigen Trajektorien.','R_ge_0',1
    UNION ALL SELECT '3.1288','z','Zufallsstartwert','Startwert des Zufallszahlengenerators.','N_0',1
    UNION ALL SELECT '3.1289','\\mathcal{E}','Versuchsmenge','Menge aller untersuchten Konfigurationen.',NULL,1
    UNION ALL SELECT '3.1290','\\mathbf{A}','Auswertungsmatrix','Matrix der Zielgrößen aller Simulationsläufe.','R^{n x m}',1
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
        '3.8.4' object_reference,
        'Abschnitt 3.8.4 wurde als Versuchsdesign und Simulationsszenarien angelegt.' change_summary,
        NULL previous_value,
        'draft' new_value

    UNION ALL SELECT
        'source_added',
        'sources',
        '[115]',
        'Die vollständige Quelle zum Entwurf und zur Analyse von Simulationsexperimenten wurde einschließlich Autor und Quellenverwendung aufgenommen.',
        'last_citation_number=114',
        'last_citation_number=115'

    UNION ALL SELECT
        'definition_added',
        'definitions',
        '3.8.4.1-3.8.4.5',
        'Fünf Definitionen zu Zielgrößenvektor, Baseline, Grenz- und Fehlerszenario sowie Versuchsmenge wurden registriert.',
        NULL,
        '5 definitions'

    UNION ALL SELECT
        'equation_added',
        'equations',
        '3.1271-3.1290',
        'Zwanzig Gleichungen zum Versuchsdesign, zu Szenariovariationen, Robustheit, Wiederholungen und Auswertung wurden registriert.',
        'last_equation=3.1270',
        'last_equation=3.1290'

    UNION ALL SELECT
        'symbol_added',
        'symbols',
        '3.8.4',
        'Die neuen Abschnittssymbole und ihre Gleichungsverwendungen wurden registriert.',
        NULL,
        '16 section symbols'
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
    WHERE citation_number = 115
);

SET @usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id = @section_id
      AND source_id IN (@source_111,@source_112,@source_114,@source_115)
);

SET @definition_count :=
(
    SELECT COUNT(*)
    FROM definitions
    WHERE section_id = @section_id
      AND definition_number IN
      (
          '3.8.4.1','3.8.4.2','3.8.4.3','3.8.4.4','3.8.4.5'
      )
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id = @section_id
      AND equation_number IN
      (
          '3.1271','3.1272','3.1273','3.1274','3.1275',
          '3.1276','3.1277','3.1278','3.1279','3.1280',
          '3.1281','3.1282','3.1283','3.1284','3.1285',
          '3.1286','3.1287','3.1288','3.1289','3.1290'
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
    AND @source_count = 1
    AND @usage_count = 4
    AND @definition_count = 5
    AND @equation_count = 20
    AND @symbol_count >= 16
);

COMMIT;

/* ============================================================
   13. Abschlussausgabe
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
        WHEN @audit_ok = 1
        THEN 'Kapitel 3.8.4 wurde vollständig und schema-konform importiert.'
        ELSE 'FEHLER: Abschnitt 3.8.4 ist unvollständig. Auditwerte prüfen.'
    END AS audit_message;

SELECT
    citation_number,
    full_citation_text,
    verification_status
FROM sources
WHERE citation_number = 115;

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
