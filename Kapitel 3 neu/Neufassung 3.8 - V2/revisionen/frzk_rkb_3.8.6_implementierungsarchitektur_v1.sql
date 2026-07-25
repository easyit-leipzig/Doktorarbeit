/* ============================================================
   FRZK Repository-Update
   Kapitel 3.8.6 – Implementierungsarchitektur der Operatorenkaskade
   Version 1.0

   Aufbauend auf:
   - RKB-K3.8.5-V1
   - Gleichungsstand nach Abschnitt 3.8.5: (3.1307)
   - Literaturstand nach Abschnitt 3.8.5: [117]

   Zuordnung Manuskript -> Repository:
   (3.520)–(3.530) -> (3.1308)–(3.1318)

   Das Skript ist idempotent.
   ============================================================ */

START TRANSACTION;

SET @revision_code := 'RKB-K3.8.6-V1';

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
        'RKB-K3.8.5-V1',
        'RKB-K3.8.4-V1',
        'RKB-K3.8.3-V1',
        'RKB-K3.8.2-V2',
        'RKB-K3.8.2-V1',
        'RKB-K3.8.1-V1',
        'RKB-K3.8-V1'
    )
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.5-V1' THEN 1
            WHEN 'RKB-K3.8.4-V1' THEN 2
            WHEN 'RKB-K3.8.3-V1' THEN 3
            WHEN 'RKB-K3.8.2-V2' THEN 4
            WHEN 'RKB-K3.8.2-V1' THEN 5
            WHEN 'RKB-K3.8.1-V1' THEN 6
            WHEN 'RKB-K3.8-V1' THEN 7
            ELSE 8
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
    '3.8.6',
    '1.0',
    'Abschnitt 3.8.6 Implementierungsarchitektur der Operatorenkaskade: Modularisierung, Datenfluss, Zustandsverwaltung, Operatorausführung, Protokollierung, Validierung, Fehlerbehandlung, Reproduzierbarkeit und Erweiterbarkeit.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_section_id IS NOT NULL
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
   2. Abschnitt 3.8.6
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
    '3.8.6',
    'Implementierungsarchitektur der Operatorenkaskade',
    3,
    3.8600,
    'draft',
    1,
    'Modulare und reproduzierbare Implementierungsarchitektur. Manuskriptgleichungen (3.520) bis (3.530) werden repositoryseitig als (3.1308) bis (3.1318) geführt.'
WHERE @parent_section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.6'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Implementierungsarchitektur der Operatorenkaskade',
    chapter_no = 3,
    section_order = 3.8600,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Modulare und reproduzierbare Implementierungsarchitektur. Manuskriptgleichungen (3.520) bis (3.530) werden repositoryseitig als (3.1308) bis (3.1318) geführt.'
WHERE section_code = '3.8.6';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.6'
    LIMIT 1
);

/* ============================================================
   3. Literaturquellen [118] und [119]
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
    118,
    'gamma_design_patterns_1994',
    'book',
    'Design Patterns',
    'Elements of Reusable Object-Oriented Software',
    1994,
    1994,
    NULL,
    'Addison-Wesley',
    'Reading, Massachusetts',
    NULL,
    NULL,
    NULL,
    'First Edition',
    NULL,
    '978-0-201-63361-0',
    NULL,
    'en',
    1,
    'textbook',
    8,
    'bibliographic',
    '3.8.6',
    'Erstnennung zur modularen, erweiterbaren und wiederverwendbaren Softwarearchitektur.',
    'Gamma, Erich; Helm, Richard; Johnson, Ralph; Vlissides, John (1994): Design Patterns – Elements of Reusable Object-Oriented Software. Reading, Massachusetts: Addison-Wesley.',
    'Gamma et al. (1994) [118]',
    'Grundlagenwerk zu modularen Entwurfsmustern.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 118
       OR source_key = 'gamma_design_patterns_1994'
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
    119,
    'sommerville_software_engineering_2015',
    'book',
    'Software Engineering',
    NULL,
    1982,
    2015,
    NULL,
    'Pearson',
    'Boston',
    NULL,
    NULL,
    NULL,
    '10th Edition',
    NULL,
    '978-1-292-09613-1',
    NULL,
    'en',
    1,
    'textbook',
    8,
    'bibliographic',
    '3.8.6',
    'Erstnennung zu Modularisierung, Validierung, Fehlerbehandlung und Reproduzierbarkeit wissenschaftlicher Software.',
    'Sommerville, Ian (2015): Software Engineering. 10th Edition. Boston: Pearson.',
    'Sommerville (2015) [119]',
    'Grundlagenwerk des Software Engineerings.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 119
       OR source_key = 'sommerville_software_engineering_2015'
);

SET @source_118 := (SELECT source_id FROM sources WHERE citation_number = 118 LIMIT 1);
SET @source_119 := (SELECT source_id FROM sources WHERE citation_number = 119 LIMIT 1);

/* ============================================================
   4. Autoren und source_authors
   ============================================================ */

INSERT INTO authors (family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Gamma','Erich','Gamma, Erich',NULL,NULL,NULL,'Autor der Quelle [118].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Gamma, Erich');

INSERT INTO authors (family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Helm','Richard','Helm, Richard',NULL,NULL,NULL,'Autor der Quelle [118].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Helm, Richard');

INSERT INTO authors (family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Johnson','Ralph','Johnson, Ralph',NULL,NULL,NULL,'Autor der Quelle [118].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Johnson, Ralph');

INSERT INTO authors (family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Vlissides','John','Vlissides, John',NULL,NULL,NULL,'Autor der Quelle [118].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Vlissides, John');

INSERT INTO authors (family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Sommerville','Ian','Sommerville, Ian',NULL,NULL,NULL,'Autor der Quelle [119].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Sommerville, Ian');

SET @a_gamma := (SELECT author_id FROM authors WHERE normalized_name='Gamma, Erich' LIMIT 1);
SET @a_helm := (SELECT author_id FROM authors WHERE normalized_name='Helm, Richard' LIMIT 1);
SET @a_johnson := (SELECT author_id FROM authors WHERE normalized_name='Johnson, Ralph' LIMIT 1);
SET @a_vlissides := (SELECT author_id FROM authors WHERE normalized_name='Vlissides, John' LIMIT 1);
SET @a_sommerville := (SELECT author_id FROM authors WHERE normalized_name='Sommerville, Ian' LIMIT 1);

INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @source_118,@a_gamma,1,'author'
WHERE @source_118 IS NOT NULL AND @a_gamma IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_118 AND author_order=1 AND role='author');

INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @source_118,@a_helm,2,'author'
WHERE @source_118 IS NOT NULL AND @a_helm IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_118 AND author_order=2 AND role='author');

INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @source_118,@a_johnson,3,'author'
WHERE @source_118 IS NOT NULL AND @a_johnson IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_118 AND author_order=3 AND role='author');

INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @source_118,@a_vlissides,4,'author'
WHERE @source_118 IS NOT NULL AND @a_vlissides IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_118 AND author_order=4 AND role='author');

INSERT INTO source_authors (source_id,author_id,author_order,role)
SELECT @source_119,@a_sommerville,1,'author'
WHERE @source_119 IS NOT NULL AND @a_sommerville IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_119 AND author_order=1 AND role='author');

/* ============================================================
   5. Quellenverwendungen
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
    'first_citation',
    x.claim_summary,
    x.exact_location,
    1,
    1,
    x.notes,
    @revision_id
FROM
(
    SELECT
        @source_118 source_id,
        'Modulare Entwurfsmuster unterstützen die Trennung von Verantwortlichkeiten, die Wiederverwendbarkeit und die spätere Erweiterung einzelner Komponenten.' claim_summary,
        '3.8.6, Architekturprinzip und Erweiterbarkeit' exact_location,
        'Erstverwendung der Quelle [118].' notes
    UNION ALL SELECT
        @source_119,
        'Softwarearchitektur, Validierung, Fehlerbehandlung, Protokollierung und Reproduzierbarkeit bilden zentrale Voraussetzungen für überprüfbare technische Systeme.',
        '3.8.6, Einleitung, Validierung, Fehlerbehandlung und Reproduzierbarkeit',
        'Erstverwendung der Quelle [119].'
) x
WHERE x.source_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM source_usage su
    WHERE su.source_id=x.source_id
      AND su.section_id=@section_id
      AND su.usage_type='first_citation'
      AND COALESCE(su.exact_location,'')=COALESCE(x.exact_location,'')
);

/* ============================================================
   6. Definitionen
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
        '3.8.6.1' definition_number,
        'Modulmenge' title,
        'Die Modulmenge enthält Parametrisierung, Operatorenkaskade, Zustandsverwaltung, Kohärenzbewertung, Validierung und Auswertung.' definition_text,
        '\\mathcal{M}=\\left\\{M_\\Sigma,M_O,M_S,M_K,M_V,M_A\\right\\}' formal_latex,
        '\\mathcal{M}=\\left\\{M_\\Sigma,M_O,M_S,M_K,M_V,M_A\\right\\}' word_latex,
        'adapted' provenance,
        @source_118 source_id,
        'Jedes Modul besitzt klar definierte Ein- und Ausgaben.' assumptions,
        'Grundlage der modularen Implementierungsarchitektur.' notes

    UNION ALL SELECT
        '3.8.6.2',
        'Zustandsverlauf',
        'Der Zustandsverlauf ist die geordnete Folge sämtlicher während einer Simulation erzeugten Zustände.',
        '\\mathcal{S}=\\left(S_0,S_1,\\ldots,S_T\\right)',
        '\\mathcal{S}=\\left(S_0,S_1,\\ldots,S_T\\right)',
        'original',
        NULL,
        'Zwischenzustände werden nicht verworfen.',
        'Ermöglicht vollständige Rekonstruktion.'

    UNION ALL SELECT
        '3.8.6.3',
        'Operatorprotokoll',
        'Ein Operatorprotokoll enthält Iterationsindex, Operator, Eingabezustand und Ausgabezustand.',
        'L_i=\\left(t,O_i,S_t,S_{t+1}\\right)',
        'L_i=\\left(t,O_i,S_t,S_{t+1}\\right)',
        'original',
        @source_119,
        'Jeder Operatoraufruf erhält einen eindeutigen Protokolleintrag.',
        'Dient der Nachvollziehbarkeit einzelner Rechenschritte.'

    UNION ALL SELECT
        '3.8.6.4',
        'Simulationsprotokoll',
        'Das Simulationsprotokoll ist die geordnete Folge aller Operatorprotokolle eines Simulationslaufs.',
        '\\mathcal{L}=\\left(L_1,L_2,\\ldots,L_n\\right)',
        '\\mathcal{L}=\\left(L_1,L_2,\\ldots,L_n\\right)',
        'original',
        @source_119,
        'Alle Operatoraufrufe werden protokolliert.',
        'Wissenschaftliche Rekonstruktionsgrundlage.'

    UNION ALL SELECT
        '3.8.6.5',
        'Fehlerklassen',
        'Fehler werden in Parameterfehler, Validierungsfehler, Operatorfehler und Rechenfehler unterteilt.',
        'F=\\left\\{F_P,F_V,F_O,F_R\\right\\}',
        'F=\\left\\{F_P,F_V,F_O,F_R\\right\\}',
        'adapted',
        @source_119,
        'Jeder Fehler ist mindestens einer Klasse zuordenbar.',
        'Grundlage kontrollierter Fehlerbehandlung.'

    UNION ALL SELECT
        '3.8.6.6',
        'Erweiterungsabbildung',
        'Die Modulmenge kann durch ein neues Modul erweitert werden, ohne die bestehende Kernarchitektur zu verändern.',
        '\\mathcal{M}^{\\prime}=\\mathcal{M}\\cup\\left\\{M_{\\mathrm{neu}}\\right\\}',
        '\\mathcal{M}^{\\prime}=\\mathcal{M}\\cup\\left\\{M_{\\mathrm{neu}}\\right\\}',
        'adapted',
        @source_118,
        'Das neue Modul erfüllt die festgelegten Schnittstellenbedingungen.',
        'Formale Darstellung der Erweiterbarkeit.'
) x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM definitions d
    WHERE d.definition_number=x.definition_number
);

/* ============================================================
   7. Gleichungen (3.1308) bis (3.1318)
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
        '3.1308' equation_number,
        'Modulmenge der Implementierungsarchitektur' title,
        '\\mathcal{M}=\\left\\{M_\\Sigma,M_O,M_S,M_K,M_V,M_A\\right\\}' equation_latex,
        '\\mathcal{M}=\\left\\{M_\\Sigma,M_O,M_S,M_K,M_V,M_A\\right\\}' word_latex,
        'Menge der sechs funktional getrennten Implementierungsmodule.' plain_description,
        'definition' equation_type,
        'adapted' provenance,
        @source_118 source_id,
        'Formale Zusammenfassung der modularen Architektur.' derivation,
        'Die Verantwortlichkeiten der Module sind getrennt.' assumptions

    UNION ALL SELECT
        '3.1309','Datenfluss der Simulation',
        '\\Sigma\\longrightarrow O\\longrightarrow S\\longrightarrow K\\longrightarrow A',
        '\\Sigma\\longrightarrow O\\longrightarrow S\\longrightarrow K\\longrightarrow A',
        'Sequenzieller Datenfluss von der Parametrisierung bis zur Auswertung.',
        'process','original',NULL,
        'Abstraktion der Verarbeitungsschritte.',
        'Jede Stufe stellt der Folgestufe definierte Daten bereit.'

    UNION ALL SELECT
        '3.1310','Zustandsverlauf',
        '\\mathcal{S}=\\left(S_0,S_1,\\ldots,S_T\\right)',
        '\\mathcal{S}=\\left(S_0,S_1,\\ldots,S_T\\right)',
        'Geordnete Folge sämtlicher Simulationszustände.',
        'definition','original',NULL,
        'Zusammenfassung der gespeicherten Zustände.',
        'Kein Zwischenzustand wird verworfen.'

    UNION ALL SELECT
        '3.1311','Elementarer Operatoraufruf',
        'S_{t+1}=O_i(S_t)',
        'S_{t+1}=O_i(S_t)',
        'Ein Operator erzeugt aus dem aktuellen Zustand den Folgezustand.',
        'model','original',NULL,
        'Elementarer Schritt der Operatorenkaskade.',
        'O_i ist für S_t definiert.'

    UNION ALL SELECT
        '3.1312','Operatorprotokoll',
        'L_i=\\left(t,O_i,S_t,S_{t+1}\\right)',
        'L_i=\\left(t,O_i,S_t,S_{t+1}\\right)',
        'Protokolleintrag eines einzelnen Operatoraufrufs.',
        'definition','adapted',@source_119,
        'Zusammenführung von Zeitindex, Operator, Eingabe- und Ausgabezustand.',
        'Der Operatoraufruf ist eindeutig identifizierbar.'

    UNION ALL SELECT
        '3.1313','Simulationsprotokoll',
        '\\mathcal{L}=\\left(L_1,L_2,\\ldots,L_n\\right)',
        '\\mathcal{L}=\\left(L_1,L_2,\\ldots,L_n\\right)',
        'Geordnete Folge aller Operatorprotokolle.',
        'definition','adapted',@source_119,
        'Konkatenation sämtlicher Protokolleinträge.',
        'Alle Operatoraufrufe wurden aufgezeichnet.'

    UNION ALL SELECT
        '3.1314','Positive Validierungsbedingung',
        'V(S_t,\\Theta)=1',
        'V(S_t,\\Theta)=1',
        'Die Berechnung darf nur bei formal gültigem Zustand und gültiger Parametrisierung fortgesetzt werden.',
        'validation','original',NULL,
        'Anwendung des Validierungsmoduls vor der Operatorausführung.',
        'Die Validierungsfunktion ist vollständig definiert.'

    UNION ALL SELECT
        '3.1315','Negative Validierungsbedingung',
        'V(S_t,\\Theta)=0',
        'V(S_t,\\Theta)=0',
        'Die Simulation wird bei formal ungültigem Zustand oder ungültiger Parametrisierung kontrolliert beendet.',
        'validation','original',NULL,
        'Negativer Fall der Validierungsfunktion.',
        'Die Fehlerursache wird protokolliert.'

    UNION ALL SELECT
        '3.1316','Fehlerklassen',
        'F=\\left\\{F_P,F_V,F_O,F_R\\right\\}',
        'F=\\left\\{F_P,F_V,F_O,F_R\\right\\}',
        'Menge der Parameter-, Validierungs-, Operator- und Rechenfehler.',
        'classification','adapted',@source_119,
        'Klassifikation technischer Fehlerarten.',
        'Jeder Fehler wird mindestens einer Klasse zugeordnet.'

    UNION ALL SELECT
        '3.1317','Reproduzierbarkeitsbedingung',
        '\\Sigma_1=\\Sigma_2\\Rightarrow\\Gamma_1=\\Gamma_2',
        '\\Sigma_1=\\Sigma_2\\Rightarrow\\Gamma_1=\\Gamma_2',
        'Identische deterministische Eingaben müssen identische Trajektorien erzeugen.',
        'criterion','adapted',@source_119,
        'Formale Forderung deterministischer Reproduzierbarkeit.',
        'Softwareversion, numerische Umgebung und Zufallsstartwerte sind identisch.'

    UNION ALL SELECT
        '3.1318','Modulare Erweiterung',
        '\\mathcal{M}^{\\prime}=\\mathcal{M}\\cup\\left\\{M_{\\mathrm{neu}}\\right\\}',
        '\\mathcal{M}^{\\prime}=\\mathcal{M}\\cup\\left\\{M_{\\mathrm{neu}}\\right\\}',
        'Erweiterung der bestehenden Architektur um ein zusätzliches Modul.',
        'model','adapted',@source_118,
        'Mengentheoretische Ergänzung der Modulmenge.',
        'Das neue Modul erfüllt die festgelegten Schnittstellen.'
) x
WHERE @section_id IS NOT NULL
  AND @revision_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM equations e
    WHERE e.equation_number=x.equation_number
);

/* ============================================================
   8. Abschnittssymbole
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
    (SELECT equation_id FROM equations WHERE equation_number=x.first_equation_number LIMIT 1),
    NULL,
    x.domain_text,
    x.codomain_text,
    x.is_vector,
    x.is_matrix,
    x.is_operator,
    'Abschnittssymbol 3.8.6.',
    'draft',
    @revision_id
FROM
(
    SELECT '\\mathcal{M}' symbol_latex,'\\mathcal{M}' symbol_word_latex,'Modulmenge' symbol_name,'Menge aller Architekturmodule.' definition_text,'3.1308' first_equation_number,NULL domain_text,NULL codomain_text,0 is_vector,0 is_matrix,0 is_operator
    UNION ALL SELECT 'M_\\Sigma','M_\\Sigma','Parametrisierungsmodul','Modul zur Verwaltung der Simulationsparameter.','3.1308',NULL,NULL,0,0,0
    UNION ALL SELECT 'M_O','M_O','Operatormodul','Modul zur Ausführung der Operatorenkaskade.','3.1308',NULL,NULL,0,0,0
    UNION ALL SELECT 'M_S','M_S','Zustandsmodul','Modul zur Verwaltung der Zustände.','3.1308',NULL,NULL,0,0,0
    UNION ALL SELECT 'M_K','M_K','Kohärenzmodul','Modul zur Kohärenzbewertung.','3.1308',NULL,NULL,0,0,0
    UNION ALL SELECT 'M_V','M_V','Validierungsmodul','Modul zur formalen Validierung.','3.1308',NULL,NULL,0,0,0
    UNION ALL SELECT 'M_A','M_A','Auswertungsmodul','Modul zur Ergebnisbewertung.','3.1308',NULL,NULL,0,0,0
    UNION ALL SELECT '\\mathcal{S}','\\mathcal{S}','Zustandsverlauf','Geordnete Folge aller Simulationszustände.','3.1310','Zustandsfolgenraum',NULL,0,0,0
    UNION ALL SELECT 'L_i','L_i','Operatorprotokoll','Protokolleintrag eines Operatoraufrufs.','3.1312',NULL,NULL,0,0,0
    UNION ALL SELECT '\\mathcal{L}','\\mathcal{L}','Simulationsprotokoll','Geordnete Folge aller Operatorprotokolle.','3.1313',NULL,NULL,0,0,0
    UNION ALL SELECT 'F','F','Fehlermenge','Menge klassifizierter Fehlerarten.','3.1316',NULL,NULL,0,0,0
    UNION ALL SELECT 'F_P','F_P','Parameterfehler','Fehlerhafte oder unzulässige Parametrisierung.','3.1316',NULL,NULL,0,0,0
    UNION ALL SELECT 'F_V','F_V','Validierungsfehler','Fehler bei der formalen Zustands- oder Parameterprüfung.','3.1316',NULL,NULL,0,0,0
    UNION ALL SELECT 'F_O','F_O','Operatorfehler','Fehler während einer Operatorausführung.','3.1316',NULL,NULL,0,0,0
    UNION ALL SELECT 'F_R','F_R','Rechenfehler','Numerischer oder arithmetischer Fehler.','3.1316',NULL,NULL,0,0,0
    UNION ALL SELECT 'M_{\\mathrm{neu}}','M_{\\mathrm{neu}}','Neues Modul','Zusätzliches Modul einer erweiterten Architektur.','3.1318',NULL,NULL,0,0,0
) x
WHERE @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM symbols s
    WHERE s.symbol_latex=x.symbol_latex
      AND s.scope_type='section'
      AND s.first_section_id=@section_id
);

/* ============================================================
   9. Gleichungssymbole
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
    SELECT '3.1308' equation_number,'\\mathcal{M}' symbol_latex,'Modulmenge' symbol_name,'Menge aller Architekturmodule.' definition_text,NULL domain_text,1 symbol_order
    UNION ALL SELECT '3.1308','M_\\Sigma','Parametrisierungsmodul','Verwaltung der Simulationsparameter.',NULL,2
    UNION ALL SELECT '3.1308','M_O','Operatormodul','Ausführung der Operatorenkaskade.',NULL,3
    UNION ALL SELECT '3.1308','M_S','Zustandsmodul','Verwaltung der Zustände.',NULL,4
    UNION ALL SELECT '3.1308','M_K','Kohärenzmodul','Kohärenzbewertung.',NULL,5
    UNION ALL SELECT '3.1308','M_V','Validierungsmodul','Formale Validierung.',NULL,6
    UNION ALL SELECT '3.1308','M_A','Auswertungsmodul','Ergebnisbewertung.',NULL,7
    UNION ALL SELECT '3.1310','\\mathcal{S}','Zustandsverlauf','Folge aller Zustände.','Zustandsfolgenraum',1
    UNION ALL SELECT '3.1312','L_i','Operatorprotokoll','Protokolleintrag eines Operatoraufrufs.',NULL,1
    UNION ALL SELECT '3.1313','\\mathcal{L}','Simulationsprotokoll','Folge aller Operatorprotokolle.',NULL,1
    UNION ALL SELECT '3.1316','F','Fehlermenge','Menge der klassifizierten Fehlerarten.',NULL,1
    UNION ALL SELECT '3.1317','\\Sigma_1','Erste Simulationskonfiguration','Erste Eingabekonfiguration.',NULL,1
    UNION ALL SELECT '3.1317','\\Sigma_2','Zweite Simulationskonfiguration','Zweite Eingabekonfiguration.',NULL,2
    UNION ALL SELECT '3.1317','\\Gamma_1','Erste Trajektorie','Trajektorie der ersten Konfiguration.',NULL,3
    UNION ALL SELECT '3.1317','\\Gamma_2','Zweite Trajektorie','Trajektorie der zweiten Konfiguration.',NULL,4
    UNION ALL SELECT '3.1318','M_{\\mathrm{neu}}','Neues Modul','Zusätzliches Architekturmodul.',NULL,1
) x
JOIN equations e ON e.equation_number=x.equation_number
WHERE NOT EXISTS
(
    SELECT 1 FROM equation_symbols es
    WHERE es.equation_id=e.equation_id
      AND es.symbol_latex=x.symbol_latex
);

/* ============================================================
   10. Änderungsprotokoll
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
        '3.8.6' object_reference,
        'Abschnitt 3.8.6 wurde als Implementierungsarchitektur der Operatorenkaskade angelegt.' change_summary,
        NULL previous_value,
        'draft' new_value

    UNION ALL SELECT
        'source_added',
        'sources',
        '[118]-[119]',
        'Zwei Quellen zu Entwurfsmustern und Software Engineering wurden aufgenommen.',
        'last_citation_number=117',
        'last_citation_number=119'

    UNION ALL SELECT
        'definition_added',
        'definitions',
        '3.8.6.1-3.8.6.6',
        'Sechs Definitionen zu Modulmenge, Zustandsverlauf, Protokollierung, Fehlerklassen und Erweiterbarkeit wurden registriert.',
        NULL,
        '6 definitions'

    UNION ALL SELECT
        'equation_added',
        'equations',
        '3.1308-3.1318',
        'Elf Gleichungen zur Implementierungsarchitektur wurden registriert.',
        'last_equation=3.1307',
        'last_equation=3.1318'

    UNION ALL SELECT
        'symbol_added',
        'symbols',
        '3.8.6',
        'Abschnittssymbole und Gleichungsverwendungen wurden registriert.',
        NULL,
        '16 section symbols'
) x
WHERE @revision_id IS NOT NULL
  AND @section_id IS NOT NULL
  AND NOT EXISTS
(
    SELECT 1 FROM section_change_log scl
    WHERE scl.revision_id=@revision_id
      AND scl.section_id=@section_id
      AND scl.change_type=x.change_type
      AND COALESCE(scl.object_reference,'')=COALESCE(x.object_reference,'')
);

/* ============================================================
   11. Abschlussaudit
   ============================================================ */

SET @source_count :=
(
    SELECT COUNT(*) FROM sources WHERE citation_number IN (118,119)
);

SET @author_link_count :=
(
    SELECT COUNT(*) FROM source_authors WHERE source_id IN (@source_118,@source_119)
);

SET @usage_count :=
(
    SELECT COUNT(*) FROM source_usage
    WHERE section_id=@section_id
      AND source_id IN (@source_118,@source_119)
);

SET @definition_count :=
(
    SELECT COUNT(*) FROM definitions
    WHERE section_id=@section_id
      AND definition_number IN
      (
        '3.8.6.1','3.8.6.2','3.8.6.3',
        '3.8.6.4','3.8.6.5','3.8.6.6'
      )
);

SET @equation_count :=
(
    SELECT COUNT(*) FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
        '3.1308','3.1309','3.1310','3.1311','3.1312',
        '3.1313','3.1314','3.1315','3.1316','3.1317','3.1318'
      )
);

SET @symbol_count :=
(
    SELECT COUNT(*) FROM symbols
    WHERE first_section_id=@section_id
      AND scope_type='section'
);

SET @audit_ok :=
(
    @parent_section_id IS NOT NULL
    AND @revision_id IS NOT NULL
    AND @section_id IS NOT NULL
    AND @source_count=2
    AND @author_link_count=5
    AND @usage_count=2
    AND @definition_count=6
    AND @equation_count=11
    AND @symbol_count>=16
);

COMMIT;

/* ============================================================
   12. Abschlussausgabe
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
        WHEN @audit_ok=1
        THEN 'Kapitel 3.8.6 wurde vollständig und schema-konform importiert.'
        ELSE 'FEHLER: Abschnitt 3.8.6 ist unvollständig. Auditwerte prüfen.'
    END AS audit_message;

SELECT
    citation_number,
    full_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (118,119)
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
