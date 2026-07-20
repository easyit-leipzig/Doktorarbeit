/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.0
   Kapitel 3.4: Mathematische Rekonstruktion funktionaler Organisation
   Abschnitt 3.4.0: Einleitung

   Grundlage:
   - Datenbankstand: frzk_rkb_ende_3.3(4).sql
   - letzte vorhandene Quelle: [107]
   - letzte vorhandene Gleichung: (3.641)
   - letzte Repository-Revision: RKB-NEU-K3.3.10-V1

   Neu registriert:
   - Kapitel 3.4 und Abschnitt 3.4.0
   - Gleichungen (3.642) und (3.643)
   - Quellen [108] und [109]
   - Wiederverwendung der Quellen [72] und [103]
   - Autoren-, Quellenverwendungs-, Symbol- und Änderungsdaten

   Eigenschaften:
   - idempotent
   - schema-konform zum hochgeladenen Datenbankstand
   - keine festen Primärschlüssel für neue Datensätze
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.0-V1';
SET @revision_date := NOW();

/* ---------------------------------------------------------------------
   1. Vorgängerrevision bestimmen
   --------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.10-V1'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   2. Repository-Revision anlegen
   --------------------------------------------------------------------- */

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
    @revision_date,
    'section',
    '3.4.0',
    '1.0',
    'Neuanlage von Kapitel 3.4 und Abschluss von Abschnitt 3.4.0 Einleitung. Registriert werden die Rekonstruktionszielsetzung, die Gleichungen (3.642) und (3.643), die Wiederverwendung der Quellen [72] und [103] sowie die neuen Quellen [108] und [109].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
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

/* ---------------------------------------------------------------------
   3. Kapitel 3.4 anlegen
   --------------------------------------------------------------------- */

SET @chapter_3_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3'
    LIMIT 1
);

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
    @chapter_3_id,
    '3.4',
    'Mathematische Rekonstruktion funktionaler Organisation',
    3,
    3.4000,
    'draft',
    1,
    'Kapitel zur schrittweisen mathematischen Rekonstruktion der aus den Axiomen des FRZK ableitbaren Strukturen. Raum und Zeit werden nicht vorausgesetzt, sondern als Ergebnisse funktionaler Organisation hergeleitet.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.4'
);

SET @chapter_34_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.4'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   4. Abschnitt 3.4.0 anlegen
   --------------------------------------------------------------------- */

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
    @chapter_34_id,
    '3.4.0',
    'Einleitung',
    3,
    3.4001,
    'final',
    1,
    'Einleitung in die mathematische Rekonstruktion des FRZK. Der Abschnitt bestimmt die Ableitung einer mathematischen Struktur aus dem Axiomensystem als zentrale Aufgabe und legt den rekursiven Aufbau der Rekonstruktion fest.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.4.0'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.4.0'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   5. Vorhandene Quellen für Wiederverwendung bestimmen
      [72] Bourbaki: Theory of Sets
      [103] Hilbert: Grundlagen der Geometrie
   --------------------------------------------------------------------- */

SET @source_bourbaki_id :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number = 72
      AND source_key = 'bourbaki_theory_sets_2004'
    LIMIT 1
);

SET @source_hilbert_id :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number = 103
      AND source_key = 'hilbert_grundlagen_geometrie_1899'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   6. Autoren anlegen bzw. bestimmen
   --------------------------------------------------------------------- */

/* Saunders Mac Lane ist im Repository bereits vorhanden. */
SET @author_maclane_id :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Mac Lane, Saunders'
    LIMIT 1
);

/* Steve Awodey neu anlegen. */
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
    'Awodey',
    'Steve',
    'Awodey, Steve',
    NULL,
    1959,
    NULL,
    'Autor der Quelle [109]; für Abschnitt 3.4.0 registriert.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name = 'Awodey, Steve'
);

SET @author_awodey_id :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name = 'Awodey, Steve'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   7. Neue Quellen [108] und [109] anlegen
   --------------------------------------------------------------------- */

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
    108,
    'mac_lane_categories_working_mathematician_1998',
    'book',
    'Categories for the Working Mathematician',
    NULL,
    1971,
    1998,
    NULL,
    'Springer',
    'New York',
    NULL,
    NULL,
    NULL,
    '2nd Edition',
    NULL,
    '978-0-387-98403-2',
    NULL,
    'en',
    1,
    'textbook',
    9,
    'verified',
    '3.4.0',
    'Erstnennung zur strukturellen Charakterisierung mathematischer Objekte durch Relationen, Abbildungen und Kompositionen.',
    'Mac Lane, Saunders (1998): Categories for the Working Mathematician. 2nd Edition. New York: Springer.',
    'Mac Lane (1998)',
    'Grundlagenwerk der Kategorientheorie; zweite Auflage der erstmals 1971 erschienenen Monografie.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 108
       OR source_key = 'mac_lane_categories_working_mathematician_1998'
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
    109,
    'awodey_category_theory_2010',
    'book',
    'Category Theory',
    NULL,
    2006,
    2010,
    NULL,
    'Oxford University Press',
    'Oxford',
    NULL,
    NULL,
    NULL,
    '2nd Edition',
    NULL,
    '978-0-19-923718-0',
    NULL,
    'en',
    2,
    'textbook',
    8,
    'verified',
    '3.4.0',
    'Erstnennung zur modernen Einführung struktureller und kategorialer mathematischer Beschreibung.',
    'Awodey, Steve (2010): Category Theory. 2nd Edition. Oxford: Oxford University Press.',
    'Awodey (2010)',
    'Moderne systematische Einführung in die Kategorientheorie.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number = 109
       OR source_key = 'awodey_category_theory_2010'
);

SET @source_maclane_id :=
(
    SELECT source_id
    FROM sources
    WHERE source_key = 'mac_lane_categories_working_mathematician_1998'
    LIMIT 1
);

SET @source_awodey_id :=
(
    SELECT source_id
    FROM sources
    WHERE source_key = 'awodey_category_theory_2010'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   8. Quellen-Autoren-Zuordnungen
   --------------------------------------------------------------------- */

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT
    @source_maclane_id,
    @author_maclane_id,
    1,
    'author'
WHERE @source_maclane_id IS NOT NULL
  AND @author_maclane_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_authors
      WHERE source_id = @source_maclane_id
        AND author_id = @author_maclane_id
        AND role = 'author'
  );

INSERT INTO source_authors
(
    source_id,
    author_id,
    author_order,
    role
)
SELECT
    @source_awodey_id,
    @author_awodey_id,
    1,
    'author'
WHERE @source_awodey_id IS NOT NULL
  AND @author_awodey_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_authors
      WHERE source_id = @source_awodey_id
        AND author_id = @author_awodey_id
        AND role = 'author'
  );

/* ---------------------------------------------------------------------
   9. Gleichung (3.642): Rekonstruktionsziel
   --------------------------------------------------------------------- */

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
    '3.642',
    @section_id,
    'Ableitung der mathematischen FRZK-Struktur aus dem Axiomensystem',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\vdash\\mathcal{M}_{\\mathrm{FRZK}}',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\vdash\\mathcal{M}_{\\mathrm{FRZK}}',
    'Die mathematische Struktur des FRZK soll formal aus der in Kapitel 3.3 entwickelten Axiomenmenge ableitbar sein.',
    'schema',
    'original',
    NULL,
    'Eigene formale Verdichtung der Zielsetzung von Abschnitt 3.4.0 auf Grundlage der in Kapitel 3.3 abgeschlossenen Axiomatik.',
    'Vorausgesetzt werden die Axiome A1 bis A7 sowie die metatheoretische Freigabe zur mathematischen Rekonstruktion aus Abschnitt 3.3.10.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.642'
);

SET @equation_3642_id :=
(
    SELECT equation_id
    FROM equations
    WHERE equation_number = '3.642'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   10. Gleichung (3.643): Rekursiver Rekonstruktionsschritt
   --------------------------------------------------------------------- */

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
    '3.643',
    @section_id,
    'Rekursiver Aufbau der mathematischen Rekonstruktion',
    '\\mathcal{M}_{n+1}=\\mathcal{R}\\left(\\mathcal{M}_{n},\\mathcal{A}_{\\mathrm{FRZK}}\\right)',
    '\\mathcal{M}_{n+1}=\\mathcal{R}\\left(\\mathcal{M}_{n},\\mathcal{A}_{\\mathrm{FRZK}}\\right)',
    'Jede nachfolgende Rekonstruktionsstufe entsteht durch Anwendung des Rekonstruktionsoperators auf die bereits entwickelte Struktur und das FRZK-Axiomensystem.',
    'schema',
    'original',
    NULL,
    'Eigene rekursive Formalisierung des schrittweisen Rekonstruktionsverfahrens in Abschnitt 3.4.0.',
    'Es werden keine zusätzlichen physikalischen Grundannahmen eingeführt; jede Rekonstruktionsstufe muss aus dem Axiomensystem und den bereits hergeleiteten Strukturen folgen.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number = '3.643'
);

SET @equation_3643_id :=
(
    SELECT equation_id
    FROM equations
    WHERE equation_number = '3.643'
    LIMIT 1
);

/* ---------------------------------------------------------------------
   11. Gleichungssymbole
   --------------------------------------------------------------------- */

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
    @equation_3642_id,
    '\\mathcal{A}_{\\mathrm{FRZK}}',
    'FRZK-Axiomensystem',
    'Menge der in Kapitel 3.3 formulierten Axiome A1 bis A7.',
    NULL,
    'Axiomenmenge',
    1
WHERE @equation_3642_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols
      WHERE equation_id = @equation_3642_id
        AND symbol_latex = '\\mathcal{A}_{\\mathrm{FRZK}}'
  );

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
    @equation_3642_id,
    '\\vdash',
    'formale Ableitbarkeit',
    'Metalogisches Symbol dafür, dass die rechts stehende Struktur aus dem links stehenden formalen System ableitbar ist.',
    NULL,
    'metalogische Relation',
    2
WHERE @equation_3642_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols
      WHERE equation_id = @equation_3642_id
        AND symbol_latex = '\\vdash'
  );

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
    @equation_3642_id,
    '\\mathcal{M}_{\\mathrm{FRZK}}',
    'mathematische FRZK-Struktur',
    'Gesamtheit der aus dem FRZK-Axiomensystem rekonstruierten mathematischen Strukturen.',
    NULL,
    'rekonstruierte mathematische Struktur',
    3
WHERE @equation_3642_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols
      WHERE equation_id = @equation_3642_id
        AND symbol_latex = '\\mathcal{M}_{\\mathrm{FRZK}}'
  );

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
    @equation_3643_id,
    '\\mathcal{M}_{n}',
    'n-te Rekonstruktionsstufe',
    'Bis zum Rekonstruktionsschritt n entwickelte mathematische Teilstruktur.',
    NULL,
    'Folge rekonstruierter Teilstrukturen',
    1
WHERE @equation_3643_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols
      WHERE equation_id = @equation_3643_id
        AND symbol_latex = '\\mathcal{M}_{n}'
  );

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
    @equation_3643_id,
    '\\mathcal{M}_{n+1}',
    'nachfolgende Rekonstruktionsstufe',
    'Aus dem vorherigen Stand und dem Axiomensystem hervorgehende mathematische Teilstruktur.',
    NULL,
    'Folge rekonstruierter Teilstrukturen',
    2
WHERE @equation_3643_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols
      WHERE equation_id = @equation_3643_id
        AND symbol_latex = '\\mathcal{M}_{n+1}'
  );

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
    @equation_3643_id,
    '\\mathcal{R}',
    'Rekonstruktionsoperator',
    'Operator, der aus dem bisherigen mathematischen Entwicklungsstand und dem FRZK-Axiomensystem die nächste zulässige Rekonstruktionsstufe bestimmt.',
    NULL,
    'Operator auf Rekonstruktionsstufen und Axiomensystem',
    3
WHERE @equation_3643_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols
      WHERE equation_id = @equation_3643_id
        AND symbol_latex = '\\mathcal{R}'
  );

/* ---------------------------------------------------------------------
   12. Globale bzw. kapitelbezogene Symbolregistrierung
   --------------------------------------------------------------------- */

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
    '\\mathcal{M}_{\\mathrm{FRZK}}',
    '\\mathcal{M}_{\\mathrm{FRZK}}',
    'Mathematische Struktur des FRZK',
    'Gesamtheit der aus dem Axiomensystem des FRZK zulässig rekonstruierten mathematischen Strukturen.',
    'chapter',
    @section_id,
    @equation_3642_id,
    NULL,
    'FRZK-Axiomensystem und daraus ableitbare Teilstrukturen',
    'mathematische FRZK-Struktur',
    0,
    0,
    0,
    'Erstmalige kapitelbezogene Verwendung in Abschnitt 3.4.0.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\mathcal{M}_{\\mathrm{FRZK}}'
);

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
    '\\mathcal{R}',
    '\\mathcal{R}',
    'Rekonstruktionsoperator',
    'Operator zur schrittweisen Ableitung der nächsten mathematischen Rekonstruktionsstufe aus dem bisherigen Strukturstand und dem FRZK-Axiomensystem.',
    'chapter',
    @section_id,
    @equation_3643_id,
    NULL,
    'Paar aus bisheriger Rekonstruktionsstufe und FRZK-Axiomensystem',
    'nachfolgende Rekonstruktionsstufe',
    0,
    0,
    1,
    'Der Operator erzeugt keine unabhängige physikalische Annahme, sondern formalisiert den schrittweisen Ableitungsprozess.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM symbols
    WHERE symbol_latex = '\\mathcal{R}'
      AND symbol_name = 'Rekonstruktionsoperator'
);

/* ---------------------------------------------------------------------
   13. Quellenverwendungen in Abschnitt 3.4.0
   --------------------------------------------------------------------- */

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
    @source_bourbaki_id,
    @section_id,
    'background',
    'Wiederverwendung zur Einordnung des axiomatischen und strukturellen Aufbaus mathematischer Theorien.',
    'Abschnitt 3.4.0, Absatz 1',
    0,
    1,
    'Bereits als Quelle [72] erstmals in Abschnitt 3.2.1 zitiert.',
    @revision_id
WHERE @source_bourbaki_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_bourbaki_id
        AND section_id = @section_id
        AND usage_type = 'background'
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
    @source_hilbert_id,
    @section_id,
    'historical_context',
    'Wiederverwendung als historisches Beispiel einer axiomatischen mathematischen Grundlegung.',
    'Abschnitt 3.4.0, Absatz 1',
    0,
    1,
    'Bereits als Quelle [103] erstmals in Abschnitt 3.3.0 zitiert.',
    @revision_id
WHERE @source_hilbert_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_hilbert_id
        AND section_id = @section_id
        AND usage_type = 'historical_context'
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
    @source_maclane_id,
    @section_id,
    'first_citation',
    'Strukturelle Charakterisierung mathematischer Objekte über Relationen, Abbildungen und Kompositionen.',
    'Abschnitt 3.4.0, Absatz 3',
    1,
    1,
    'Erstnennung als Quelle [108].',
    @revision_id
WHERE @source_maclane_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_maclane_id
        AND section_id = @section_id
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
    @source_awodey_id,
    @section_id,
    'first_citation',
    'Moderne kategoriale Einordnung struktureller mathematischer Beschreibung.',
    'Abschnitt 3.4.0, Absatz 3',
    1,
    1,
    'Erstnennung als Quelle [109].',
    @revision_id
WHERE @source_awodey_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage
      WHERE source_id = @source_awodey_id
        AND section_id = @section_id
  );

/* ---------------------------------------------------------------------
   14. Änderungsprotokoll
   --------------------------------------------------------------------- */

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
    @revision_id,
    @chapter_34_id,
    'created',
    'section',
    '3.4',
    'Kapitel 3.4 Mathematische Rekonstruktion funktionaler Organisation wurde angelegt.',
    NULL,
    'Status draft; Originalbeitrag; Beginn der mathematischen Rekonstruktion.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @chapter_34_id
      AND change_type = 'created'
      AND object_reference = '3.4'
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
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.4.0',
    'Abschnitt 3.4.0 Einleitung wurde vollständig angelegt und als final registriert.',
    NULL,
    'Rekonstruktionsziel, methodische Abgrenzung, Literaturbezüge und Übergang zu Abschnitt 3.4.1.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'created'
      AND object_reference = '3.4.0'
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
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '3.642-3.643',
    'Die Gleichungen (3.642) und (3.643) zur formalen Zielsetzung und zum rekursiven Aufbau der Rekonstruktion wurden registriert.',
    NULL,
    '2 neue Gleichungen einschließlich Word-LaTeX und Symbolzuordnungen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'equation_added'
      AND object_reference = '3.642-3.643'
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
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'source_added',
    'source',
    '[108]-[109]',
    'Die Quellen Mac Lane [108] und Awodey [109] wurden neu aufgenommen; Bourbaki [72] und Hilbert [103] wurden wiederverwendet.',
    NULL,
    '2 neue Quellen und 2 wiederverwendete Quellen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'source_added'
      AND object_reference = '[108]-[109]'
);

/* ---------------------------------------------------------------------
   15. Repository-Zähler aktualisieren
   --------------------------------------------------------------------- */

INSERT INTO repository_counters
(
    counter_key,
    counter_value,
    updated_at
)
VALUES
    ('last_completed_section', '3.4.0', NOW()),
    ('last_repository_revision', @revision_code, NOW()),
    ('next_citation_number', '110', NOW()),
    ('next_equation_number', '3.644', NOW())
ON DUPLICATE KEY UPDATE
    counter_value = VALUES(counter_value),
    updated_at = VALUES(updated_at);

/* ---------------------------------------------------------------------
   16. Validierungsergebnisse registrieren
   --------------------------------------------------------------------- */

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
SELECT
    @revision_id,
    'K3.4.0_SECTION_EXISTS',
    CASE WHEN @section_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CAST((SELECT COUNT(*) FROM dissertation_sections WHERE section_code = '3.4.0') AS CHAR),
    'Prüfung, ob Abschnitt 3.4.0 genau einmal vorhanden ist.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_id
      AND validation_code = 'K3.4.0_SECTION_EXISTS'
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
SELECT
    @revision_id,
    'K3.4.0_EQUATION_COUNT',
    CASE
        WHEN (SELECT COUNT(*) FROM equations WHERE section_id = @section_id AND equation_number IN ('3.642','3.643')) = 2
        THEN 'passed'
        ELSE 'failed'
    END,
    '2',
    CAST((SELECT COUNT(*) FROM equations WHERE section_id = @section_id AND equation_number IN ('3.642','3.643')) AS CHAR),
    'Prüfung der beiden für Abschnitt 3.4.0 vorgesehenen Gleichungen.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_id
      AND validation_code = 'K3.4.0_EQUATION_COUNT'
);

INSERT INTO repository_validation_results
(
    revision_id,
    validation_code,
    validation_status,
    expected_value,
    actual_value,
    validation_message,
    checked_at
)
SELECT
    @revision_id,
    'K3.4.0_NEW_SOURCE_COUNT',
    CASE
        WHEN (SELECT COUNT(*) FROM sources WHERE citation_number IN (108,109)) = 2
        THEN 'passed'
        ELSE 'failed'
    END,
    '2',
    CAST((SELECT COUNT(*) FROM sources WHERE citation_number IN (108,109)) AS CHAR),
    'Prüfung der neu registrierten Quellen [108] und [109].',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id = @revision_id
      AND validation_code = 'K3.4.0_NEW_SOURCE_COUNT'
);

COMMIT;

/* =====================================================================
   Kontrollabfragen nach erfolgreichem Import
   ===================================================================== */

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    summary
FROM repository_revisions
WHERE revision_code = @revision_code;

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code IN ('3.4', '3.4.0')
ORDER BY section_order;

SELECT
    equation_id,
    equation_number,
    title,
    equation_latex,
    word_latex,
    validation_status
FROM equations
WHERE equation_number IN ('3.642', '3.643')
ORDER BY equation_number;

SELECT
    citation_number,
    source_key,
    title,
    year_edition,
    verification_status
FROM sources
WHERE citation_number IN (72, 103, 108, 109)
ORDER BY citation_number;

SELECT
    counter_key,
    counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_completed_section',
    'last_repository_revision',
    'next_citation_number',
    'next_equation_number'
)
ORDER BY counter_key;
