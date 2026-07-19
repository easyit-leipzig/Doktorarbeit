/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.0 und 3.3.1

   Grundlage:
     frzk_rkb_ende_3.2(2).sql
     letzter abgeschlossener Abschnitt: 3.2.13
     letzte Literaturzahl: [102]
     letzte Gleichungsnummer: (3.353)

   Inhalt:
     - Abschnitt 3.3 und Einleitung 3.3.0
     - Abschnitt 3.3.1 Prämathematische Grundbegriffe und formaler Ausgangspunkt
     - neue neue Quellen [103] und [104] sowie Wiederverwendung der Quelle [68] sowie Wiederverwendung der Quellen [68] und [63]
     - Gleichungen (3.354) bis (3.361)
     - zugehörige Definitionen, Symbole, Quellenverwendungen und Änderungsprotokolle

   Eigenschaften:
     - idempotent
     - schema-konform zum hochgeladenen Repository-Dump
     - keine festen Primärschlüssel für AUTO_INCREMENT-Tabellen
   ============================================================================ */

START TRANSACTION;

/* --------------------------------------------------------------------------
   1. Ausgangsrevision bestimmen
   -------------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.13-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   2. Revision für 3.3.0 anlegen
   -------------------------------------------------------------------------- */

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
    'RKB-NEU-K3.3.0-V1',
    NOW(),
    'section',
    '3.3.0',
    '1.0',
    'Neustart von Kapitel 3.3. Aufnahme der Kapitelüberschrift 3.3 und des Einleitungsabschnitts 3.3.0 einschließlich der erstmals verwendeten neue Quellen [103] und [104] sowie Wiederverwendung der Quelle [68].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.0-V1'
);

SET @revision_330 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.0-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   3. Revision für 3.3.1 anlegen
   -------------------------------------------------------------------------- */

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
    'RKB-NEU-K3.3.1-V1',
    NOW(),
    'section',
    '3.3.1',
    '1.0',
    'Abschluss von Abschnitt 3.3.1. Registriert werden die Wiederverwendung der Quelle [63], die neue Quelle [105], die prämathematischen Grundbegriffe sowie die Gleichungen (3.354) bis (3.361).',
    'Olaf Thiele / ChatGPT',
    @revision_330
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.1-V1'
);

SET @revision_331 :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.1-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   4. Kapitel- und Abschnittsstruktur
   -------------------------------------------------------------------------- */

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
    '3.3',
    'Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    3.3000,
    'draft',
    1,
    'Neu aufgebautes Kapitel zur qualitativen und formalen Grundlegung der FRZK-Axiomatik.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3'
);

SET @section_33_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.3'
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
    @section_33_id,
    '3.3.0',
    'Einleitung',
    3,
    3.3001,
    'final',
    1,
    'Methodischer Übergang von den mathematischen Grundlagen zur eigenständigen Axiomatik des FRZK.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3.0'
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
    @section_33_id,
    '3.3.1',
    'Prämathematische Grundbegriffe und formaler Ausgangspunkt',
    3,
    3.3010,
    'final',
    1,
    'Einführung des funktionalen Trägerbereichs, der qualitativen Unterscheidung, eines möglichen Differenzmaßes, der kontextabhängigen Wirksamkeit und der aktuell wirksamen Teilstruktur.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3.1'
);

SET @section_330_id :=
(
    SELECT section_id FROM dissertation_sections WHERE section_code = '3.3.0' LIMIT 1
);

SET @section_331_id :=
(
    SELECT section_id FROM dissertation_sections WHERE section_code = '3.3.1' LIMIT 1
);

/* --------------------------------------------------------------------------
   5. Autoren für neue neue Quellen [103] und [104] sowie Wiederverwendung der Quelle [68] sowie Wiederverwendung der Quellen [68] und [63]
   -------------------------------------------------------------------------- */

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Hilbert', 'David', 'Hilbert, David', 1862, 1943, 'Autor der Quelle [103].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name = 'Hilbert, David');

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Zermelo', 'Ernst', 'Zermelo, Ernst', 1871, 1953, 'Autor der Quelle [104].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name = 'Zermelo, Ernst');

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Weinberg', 'Steven', 'Weinberg, Steven', 1933, 2021, 'Autor der Quelle [105].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name = 'Weinberg, Steven');

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Shapiro', 'Stewart', 'Shapiro, Stewart', NULL, NULL, 'Autor der Quelle [106].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name = 'Shapiro, Stewart');

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Rovelli', 'Carlo', 'Rovelli, Carlo', 1956, NULL, 'Autor der neuen Quelle [105].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name = 'Rovelli, Carlo');

/* --------------------------------------------------------------------------
   6. Neue Quellen [103]–[105] und Wiederverwendung der Quellen [68] und [63]
   -------------------------------------------------------------------------- */

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    103,
    'hilbert_grundlagen_geometrie_1899',
    'book',
    'Grundlagen der Geometrie',
    NULL,
    1899,
    1899,
    NULL,
    'B. G. Teubner',
    'Leipzig',
    NULL, NULL, NULL, '1', NULL, NULL, NULL,
    'de', 1, 'primary', 7,
    'verified', '3.3.0',
    'Erstnennung als Beispiel einer axiomatischen mathematischen Grundlegung.',
    'Hilbert, David (1899): Grundlagen der Geometrie. Leipzig: B. G. Teubner.',
    'Hilbert (1899)',
    'Historische Primärquelle zur axiomatischen Grundlegung der Geometrie.',
    @revision_330
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number = 103 OR source_key = 'hilbert_grundlagen_geometrie_1899');

/* Quelle Zermelo wird als bereits vorhandene Quelle [68] wiederverwendet. */

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, publisher, place, volume, edition, isbn,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    104,
    'weinberg_quantum_theory_fields_vol1_1995',
    'book',
    'The Quantum Theory of Fields',
    'Volume I: Foundations',
    1995, 1995,
    'Cambridge University Press',
    'Cambridge',
    '1', '1', '978-0-521-55001-7',
    'en', 2, 'textbook', 5,
    'partially_verified', '3.3.0',
    'Erstnennung als Beispiel für die prinzipiengeleitete Grundlegung einer physikalischen Theorie.',
    'Weinberg, Steven (1995): The Quantum Theory of Fields. Volume I: Foundations. Cambridge: Cambridge University Press.',
    'Weinberg (1995)',
    'Wissenschaftlicher Anschluss zur methodischen Rolle grundlegender Prinzipien in der Physik.',
    @revision_330
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number = 104 OR source_key = 'weinberg_quantum_theory_fields_vol1_1995');

/* Quelle Shapiro wird als bereits vorhandene Quelle [63] wiederverwendet. */

INSERT INTO sources
(
    citation_number, source_key, source_type, title,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, doi,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code, first_citation_note,
    full_citation_text, short_citation_text, notes, created_revision_id
)
SELECT
    105,
    'rovelli_relational_quantum_mechanics_1996',
    'journal_article',
    'Relational Quantum Mechanics',
    1996, 1996,
    'International Journal of Theoretical Physics',
    'Springer',
    NULL,
    '35', '8', '1637–1678', '10.1007/BF02302261',
    'en', 1, 'primary', 9,
    'verified', '3.3.1',
    'Erstnennung zum relationalen Verständnis physikalischer Eigenschaften.',
    'Rovelli, Carlo (1996): Relational Quantum Mechanics. In: International Journal of Theoretical Physics, Bd. 35, Nr. 8, S. 1637–1678. DOI: 10.1007/BF02302261.',
    'Rovelli (1996)',
    'Primärquelle zur relationalen Quantenmechanik.',
    @revision_331
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number = 105 OR source_key = 'rovelli_relational_quantum_mechanics_1996');

/* Quellen-IDs ausschließlich über stabile source_key-Werte bestimmen */
SET @source_103 := (SELECT source_id FROM sources WHERE source_key = 'hilbert_grundlagen_geometrie_1899' LIMIT 1);
SET @source_68  := (SELECT source_id FROM sources WHERE source_key = 'zermelo_grundlagen_mengenlehre_1908' LIMIT 1);
SET @source_104 := (SELECT source_id FROM sources WHERE source_key = 'weinberg_quantum_theory_fields_vol1_1995' LIMIT 1);
SET @source_63  := (SELECT source_id FROM sources WHERE source_key = 'shapiro_philosophy_mathematics_structure_ontology_1997' LIMIT 1);
SET @source_105 := (SELECT source_id FROM sources WHERE source_key = 'rovelli_relational_quantum_mechanics_1996' LIMIT 1);

/* Autoren-IDs bestimmen */
SET @author_hilbert  := (SELECT author_id FROM authors WHERE normalized_name = 'Hilbert, David' LIMIT 1);
SET @author_zermelo  := (SELECT author_id FROM authors WHERE normalized_name = 'Zermelo, Ernst' LIMIT 1);
SET @author_weinberg := (SELECT author_id FROM authors WHERE normalized_name = 'Weinberg, Steven' LIMIT 1);
SET @author_shapiro  := (SELECT author_id FROM authors WHERE normalized_name = 'Shapiro, Stewart' LIMIT 1);
SET @author_rovelli  := (SELECT author_id FROM authors WHERE normalized_name = 'Rovelli, Carlo' LIMIT 1);

/* Diagnose der aufgelösten Quellen-IDs */
SELECT
    @source_103 AS source_hilbert_103,
    @source_68  AS source_zermelo_68,
    @source_104 AS source_weinberg_104,
    @source_63  AS source_shapiro_63,
    @source_105 AS source_rovelli_105;


INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT @source_103, @author_hilbert, 1, 'author'
WHERE NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_103 AND author_id=@author_hilbert AND role='author');

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT @source_68, @author_zermelo, 1, 'author'
WHERE NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_68 AND author_id=@author_zermelo AND role='author');

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT @source_104, @author_weinberg, 1, 'author'
WHERE NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_104 AND author_id=@author_weinberg AND role='author');

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT @source_63, @author_shapiro, 1, 'author'
WHERE NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_63 AND author_id=@author_shapiro AND role='author');

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT @source_105, @author_rovelli, 1, 'author'
WHERE NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_105 AND author_id=@author_rovelli AND role='author');

/* --------------------------------------------------------------------------
   7. Quellenverwendungen
   -------------------------------------------------------------------------- */

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location, is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_103, @section_330_id, 'first_citation',
       'Beispiel einer axiomatischen mathematischen Grundlegung anhand der Geometrie.',
       '3.3.0, methodischer Forschungsanschluss', 1, 1,
       'Erstnennung als Quelle [103].', @revision_330
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_103 AND section_id=@section_330_id AND is_first_mention=1);

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location, is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_68, @section_330_id, 'supporting',
       'Wiederverwendung der bereits eingeführten Quelle [68] zur axiomatischen Grundlegung der Mengenlehre.',
       '3.3.0, methodischer Forschungsanschluss', 0, 1,
       'Wiederverwendung der bereits in Kapitel 3.2 eingeführten Quelle [68].', @revision_330
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_68 AND section_id=@section_330_id);

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location, is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_104, @section_330_id, 'first_citation',
       'Wissenschaftlicher Anschluss zur prinzipiengeleiteten Grundlegung physikalischer Theorien.',
       '3.3.0, methodischer Forschungsanschluss', 1, 0,
       'Erstnennung als Quelle [104]. Bibliografische Detailprüfung empfohlen.', @revision_330
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_104 AND section_id=@section_330_id AND is_first_mention=1);

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location, is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_63, @section_331_id, 'supporting',
       'Strukturalistische Einordnung, nach der mathematische Gegenstände wesentlich durch ihre Stellung innerhalb einer Struktur bestimmt werden.',
       '3.3.1, Absatz zum strukturalistischen Forschungsanschluss', 0, 1,
       'Wiederverwendung der bereits in Kapitel 3.1 eingeführten Quelle [63].', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_63 AND section_id=@section_331_id);

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location, is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_105, @section_331_id, 'first_citation',
       'Relationaler physikalischer Anschluss für die kontext- und relationsabhängige Bestimmung von Eigenschaften.',
       '3.3.1, Absatz zum relationalen Forschungsanschluss', 1, 1,
       'Erstnennung als Quelle [105].', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM source_usage WHERE source_id=@source_105 AND section_id=@section_331_id AND is_first_mention=1);

/* --------------------------------------------------------------------------
   8. Definitionen aus Abschnitt 3.3.1
   -------------------------------------------------------------------------- */

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex, provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT
    '3.3.1', @section_331_id, 'Funktionaler Gehalt',
    'Ein funktionaler Gehalt bezeichnet dasjenige, was innerhalb des Modells in einer für andere Gehalte oder für eine entstehende Organisation relevanten Weise wirksam werden kann. Er ist weder als physikalisches Teilchen noch als geometrischer Punkt vorausgesetzt.',
    'f_i in mathcal{F}', 'f_i\in\mathcal{F}',
    'original', NULL,
    'Es wird lediglich die Möglichkeit funktionaler Wirksamkeit vorausgesetzt.',
    'Prämathematischer Grundbegriff; keine ontologische Behauptung über abgeschlossene Objekte.',
    'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.3.1');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex, provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT
    '3.3.2', @section_331_id, 'Qualitative funktionale Unterscheidung',
    'Die qualitative funktionale Unterscheidung hält fest, ob zwei funktionale Gehalte innerhalb des Modells funktional unterschieden werden oder nicht.',
    'delta_F:mathcal{F}timesmathcal{F}rightarrow{0,1}', '\delta_F:\mathcal{F}\times\mathcal{F}\rightarrow\{0,1\}',
    'original', NULL,
    'Es wird kein metrischer Abstand vorausgesetzt.',
    'Die binäre Form bildet ausschließlich die minimale qualitative Unterscheidung ab.',
    'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.3.2');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex, provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT
    '3.3.3', @section_331_id, 'Funktionales Differenzmaß',
    'Ein funktionales Differenzmaß ordnet zwei funktionalen Gehalten einen nichtnegativen Wert als möglichen Grad ihrer funktionalen Verschiedenheit zu, ohne an dieser Stelle bereits sämtliche Metrikeigenschaften zu fordern.',
    'd_F:mathcal{F}timesmathcal{F}rightarrowmathbb{R}_{geq 0}', 'd_F:\mathcal{F}\times\mathcal{F}\rightarrow\mathbb{R}_{\geq 0}',
    'original', NULL,
    'Symmetrie, Dreiecksungleichung und positive Definitheit werden nicht vorausgesetzt.',
    'Vorstruktur für die mathematische Rekonstruktion in Kapitel 3.4.',
    'draft', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.3.3');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex, provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT
    '3.3.4', @section_331_id, 'Funktionale Wirksamkeit',
    'Die funktionale Wirksamkeit beschreibt, wie ein funktionaler Gehalt innerhalb eines funktionalen Kontextes wirksam wird.',
    'omega_F:mathcal{F}timesmathcal{C}rightarrowmathcal{W}', '\omega_F:\mathcal{F}\times\mathcal{C}\rightarrow\mathcal{W}',
    'original', NULL,
    'Der Kontextbereich und der Wirkungsbereich werden zunächst formal offen gehalten.',
    'Bereitet eine relationale und kontextabhängige Rekonstruktion funktionaler Identität vor.',
    'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.3.4');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex, provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT
    '3.3.5', @section_331_id, 'Aktuell wirksame Teilstruktur',
    'Die aktuell wirksame Teilstruktur umfasst diejenigen funktionalen Gehalte des möglichen Trägerbereichs, die innerhalb des betrachteten funktionalen Zusammenhangs tatsächlich wirksam sind.',
    'mathcal{F}_A subseteq mathcal{F}', '\mathcal{F}_A\subseteq\mathcal{F}',
    'original', NULL,
    'Zwischen formaler Möglichkeit und aktueller Realisierung wird unterschieden.',
    'Verhindert die Gleichsetzung aller formal möglichen mit tatsächlich realisierten Strukturen.',
    'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.3.5');

/* --------------------------------------------------------------------------
   9. Gleichungen (3.354) bis (3.361)
   -------------------------------------------------------------------------- */

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.354', @section_331_id, 'Funktionaler Trägerbereich',
       '\\mathcal{F}=\\{f_i\\mid i\\in I\\}',
       '\\mathcal{F}=\\{f_i\\mid i\\in I\\}',
       'Der funktionale Trägerbereich enthält die durch eine Indexmenge bezeichneten funktionalen Gehalte.',
       'definition', 'original', NULL,
       'Formaler Ausgangspunkt für die weitere Axiomatik.',
       'Die Schreibweise behauptet keine ontologisch abgeschlossenen Objekte.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.354');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.355', @section_331_id, 'Qualitative Unterscheidungsabbildung',
       '\\delta_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}',
       '\\delta_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}',
       'Die Abbildung ordnet einem Paar funktionaler Gehalte den Wert null oder eins für Nichtunterscheidbarkeit beziehungsweise Unterscheidbarkeit zu.',
       'definition', 'original', NULL,
       'Minimalform einer qualitativen funktionalen Unterscheidung.',
       'Es wird kein Distanzmaß vorausgesetzt.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.355');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.356', @section_331_id, 'Fallunterscheidung der qualitativen Differenz',
       '\\delta_F(f_i,f_j)=\\begin{cases}0,&\\text{wenn }f_i\\text{ und }f_j\\text{ funktional nicht unterschieden werden},\\\\1,&\\text{wenn }f_i\\text{ und }f_j\\text{ funktional unterschieden werden}\\end{cases}',
       '\\delta_F(f_i,f_j)=\\begin{cases}0,&\\text{wenn }f_i\\text{ und }f_j\\text{ funktional nicht unterschieden werden},\\\\1,&\\text{wenn }f_i\\text{ und }f_j\\text{ funktional unterschieden werden}\\end{cases}',
       'Explizite Fallunterscheidung für die qualitative funktionale Unterscheidung.',
       'definition', 'original', NULL,
       'Aus Gleichung (3.355) konkretisierte Wertzuordnung.',
       'Die Unterscheidung bleibt binär und qualitativ.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.356');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.357', @section_331_id, 'Allgemeines funktionales Differenzmaß',
       'd_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\mathbb{R}_{\\geq 0}',
       'd_F:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\mathbb{R}_{\\geq 0}',
       'Mögliche quantitative Zuordnung eines nichtnegativen funktionalen Differenzwertes.',
       'metric', 'original', NULL,
       'Verallgemeinerung der qualitativen Unterscheidung für eine spätere quantitative Rekonstruktion.',
       'Metrikeigenschaften werden noch nicht gefordert.',
       'draft', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.357');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.358', @section_331_id, 'Kontextabhängige funktionale Wirksamkeit',
       '\\omega_F:\\mathcal{F}\\times\\mathcal{C}\\rightarrow\\mathcal{W}',
       '\\omega_F:\\mathcal{F}\\times\\mathcal{C}\\rightarrow\\mathcal{W}',
       'Die Wirksamkeitsabbildung ordnet einem funktionalen Gehalt in einem Kontext einen Wirkungswert zu.',
       'definition', 'original', NULL,
       'Formale Verbindung eines funktionalen Gehalts mit Kontext und Wirkung.',
       'Die Bereiche C und W bleiben zunächst abstrakt.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.358');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.359', @section_331_id, 'Kontextabhängige Wirkungsdifferenz',
       '\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)',
       '\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)',
       'Zwei funktionale Gehalte entfalten innerhalb desselben Kontextes unterschiedliche Wirkungen.',
       'model', 'original', NULL,
       'Konkretisierung der funktionalen Nichtidentität über die Wirksamkeitsabbildung.',
       'Beide Gehalte werden im selben Kontext betrachtet.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.359');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.360', @section_331_id, 'Unterscheidbarkeit durch Wirkungsdifferenz',
       '\\delta_F(f_i,f_j)=1\\quad\\Longleftrightarrow\\quad\\exists c\\in\\mathcal{C}:\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)',
       '\\delta_F(f_i,f_j)=1\\quad\\Longleftrightarrow\\quad\\exists c\\in\\mathcal{C}:\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)',
       'Funktionale Gehalte gelten genau dann als unterscheidbar, wenn wenigstens ein Kontext existiert, in dem ihre Wirkungen voneinander abweichen.',
       'model', 'original', NULL,
       'Verknüpft die qualitative Unterscheidungsabbildung mit der kontextabhängigen Wirksamkeit.',
       'Der Kontextbereich ist eine formale Vorstruktur und wird später rekonstruiert.',
       'draft', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.360');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.361', @section_331_id, 'Aktuell wirksame Teilstruktur',
       '\\mathcal{F}_A\\subseteq\\mathcal{F}',
       '\\mathcal{F}_A\\subseteq\\mathcal{F}',
       'Die aktuell wirksamen funktionalen Gehalte bilden eine Teilmenge des möglichen funktionalen Trägerbereichs.',
       'definition', 'original', NULL,
       'Formale Trennung zwischen möglicher und aktuell realisierter funktionaler Struktur.',
       'Nicht jeder formal mögliche Gehalt muss aktuell wirksam sein.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.361');

/* Gleichungs-IDs bestimmen */
SET @eq_354 := (SELECT equation_id FROM equations WHERE equation_number='3.354' LIMIT 1);
SET @eq_355 := (SELECT equation_id FROM equations WHERE equation_number='3.355' LIMIT 1);
SET @eq_356 := (SELECT equation_id FROM equations WHERE equation_number='3.356' LIMIT 1);
SET @eq_357 := (SELECT equation_id FROM equations WHERE equation_number='3.357' LIMIT 1);
SET @eq_358 := (SELECT equation_id FROM equations WHERE equation_number='3.358' LIMIT 1);
SET @eq_359 := (SELECT equation_id FROM equations WHERE equation_number='3.359' LIMIT 1);
SET @eq_360 := (SELECT equation_id FROM equations WHERE equation_number='3.360' LIMIT 1);
SET @eq_361 := (SELECT equation_id FROM equations WHERE equation_number='3.361' LIMIT 1);

/* --------------------------------------------------------------------------
   10. Zentrale globale/abschnittsbezogene Symbole
   -------------------------------------------------------------------------- */

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{F}', '\\mathcal{F}', 'Funktionaler Trägerbereich',
       'Gesamtheit der im Modell berücksichtigten möglichen funktionalen Gehalte.',
       'chapter', @section_331_id, @eq_354, 'Funktionale Gehalte', NULL, 0, 0, 0,
       'Keine ontologische Gleichsetzung mit einer Menge abgeschlossener physikalischer Objekte.',
       'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{F}' AND scope_type='chapter' AND first_section_id=@section_331_id);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\delta_F', '\\delta_F', 'Qualitative funktionale Unterscheidung',
       'Binäre Abbildung zur qualitativen Unterscheidung zweier funktionaler Gehalte.',
       'chapter', @section_331_id, @eq_355, '\\mathcal{F}\\times\\mathcal{F}', '\\{0,1\\}', 0, 0, 1,
       'Kein metrisches Differenzmaß.', 'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\delta_F' AND scope_type='chapter' AND first_section_id=@section_331_id);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT 'd_F', 'd_F', 'Funktionales Differenzmaß',
       'Mögliche quantitative Beschreibung des Grades funktionaler Verschiedenheit.',
       'chapter', @section_331_id, @eq_357, '\\mathcal{F}\\times\\mathcal{F}', '\\mathbb{R}_{\\geq 0}', 0, 0, 1,
       'Metrikeigenschaften sind noch nicht festgelegt.', 'draft', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='d_F' AND scope_type='chapter' AND first_section_id=@section_331_id);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\omega_F', '\\omega_F', 'Funktionale Wirksamkeitsabbildung',
       'Ordnet einem funktionalen Gehalt in einem funktionalen Kontext einen Wirkungswert zu.',
       'chapter', @section_331_id, @eq_358, '\\mathcal{F}\\times\\mathcal{C}', '\\mathcal{W}', 0, 0, 1,
       'Kontext- und Wirkungsbereich werden später präzisiert.', 'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\omega_F' AND scope_type='chapter' AND first_section_id=@section_331_id);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{C}', '\\mathcal{C}', 'Funktionaler Kontextbereich',
       'Vorläufiger Bereich funktionaler Kontexte, innerhalb derer Wirksamkeiten bestimmt werden.',
       'chapter', @section_331_id, @eq_358, 'Funktionale Kontexte', NULL, 0, 0, 0,
       'Wird in späteren Abschnitten aus Relationen und Organisationen präzisiert.', 'draft', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{C}' AND scope_type='chapter' AND first_section_id=@section_331_id);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{W}', '\\mathcal{W}', 'Funktionaler Wirkungsbereich',
       'Bereich möglicher Wirkungswerte der funktionalen Wirksamkeitsabbildung.',
       'chapter', @section_331_id, @eq_358, 'Wirkungswerte', NULL, 0, 0, 0,
       'Die konkrete mathematische Struktur wird später festgelegt.', 'draft', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{W}' AND scope_type='chapter' AND first_section_id=@section_331_id);

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type, first_section_id, first_equation_id, domain_text, codomain_text, is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{F}_A', '\\mathcal{F}_A', 'Aktuell wirksame Teilstruktur',
       'Teilstruktur der innerhalb eines betrachteten Zusammenhangs aktuell wirksamen funktionalen Gehalte.',
       'chapter', @section_331_id, @eq_361, '\\mathcal{F}_A\\subseteq\\mathcal{F}', NULL, 0, 0, 0,
       'Trennt formale Möglichkeit von aktueller Realisierung.', 'checked', @revision_331
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{F}_A' AND scope_type='chapter' AND first_section_id=@section_331_id);

/* --------------------------------------------------------------------------
   11. Gleichungssymbole
   -------------------------------------------------------------------------- */

INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_354, '\\mathcal{F}', 'Funktionaler Trägerbereich', 'Gesamtheit der möglichen funktionalen Gehalte.', 'Funktionaler Trägerbereich', 1
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_354 AND symbol_latex='\\mathcal{F}');
INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_354, 'f_i', 'Funktionaler Gehalt', 'Durch den Index i bezeichneter funktionaler Gehalt.', '\\mathcal{F}', 2
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_354 AND symbol_latex='f_i');
INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_354, 'I', 'Indexmenge', 'Indexbereich zur Bezeichnung funktionaler Gehalte.', 'Indexmenge', 3
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_354 AND symbol_latex='I');

INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_355, '\\delta_F', 'Unterscheidungsabbildung', 'Qualitative Abbildung funktionaler Unterscheidbarkeit.', '\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}', 1
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_355 AND symbol_latex='\\delta_F');

INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_357, 'd_F', 'Funktionales Differenzmaß', 'Nichtnegative quantitative Differenzzuordnung.', '\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\mathbb{R}_{\\geq0}', 1
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_357 AND symbol_latex='d_F');

INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_358, '\\omega_F', 'Wirksamkeitsabbildung', 'Ordnet Gehalt und Kontext einen Wirkungswert zu.', '\\mathcal{F}\\times\\mathcal{C}\\rightarrow\\mathcal{W}', 1
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_358 AND symbol_latex='\\omega_F');
INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_358, '\\mathcal{C}', 'Kontextbereich', 'Bereich funktionaler Kontexte.', 'Kontextbereich', 2
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_358 AND symbol_latex='\\mathcal{C}');
INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_358, '\\mathcal{W}', 'Wirkungsbereich', 'Bereich möglicher Wirkungswerte.', 'Wirkungsbereich', 3
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_358 AND symbol_latex='\\mathcal{W}');

INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_360, 'c', 'Funktionaler Kontext', 'Ein Kontext, in dem die Wirkungen zweier Gehalte verglichen werden.', '\\mathcal{C}', 1
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_360 AND symbol_latex='c');

INSERT INTO equation_symbols (equation_id, symbol_latex, symbol_name, definition_text, domain_text, symbol_order)
SELECT @eq_361, '\\mathcal{F}_A', 'Aktuell wirksame Teilstruktur', 'Aktuell realisierte funktionale Gehalte.', 'Teilmenge von \\mathcal{F}', 1
WHERE NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_361 AND symbol_latex='\\mathcal{F}_A');

/* --------------------------------------------------------------------------
   12. Änderungsprotokoll
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_330, @section_33_id, 'created', 'section', '3.3',
       'Kapitelüberschrift 3.3 neu angelegt.', NULL,
       'Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_330 AND section_id=@section_33_id AND change_type='created' AND object_reference='3.3');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_330, @section_330_id, 'created', 'section', '3.3.0',
       'Einleitung zu Kapitel 3.3 neu erstellt.', NULL,
       'Methodische Begründung und Abgrenzung der FRZK-Axiomatik.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_330 AND section_id=@section_330_id AND change_type='created' AND object_reference='3.3.0');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_330, @section_330_id, 'source_added', 'source', '[103]–[105]',
       'Drei Grundlagenquellen zur axiomatischen Methode aufgenommen.', NULL,
       'Hilbert (1899), Zermelo (1908), Weinberg (1995)'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_330 AND section_id=@section_330_id AND change_type='source_added' AND object_reference='[103]–[105]');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_331, @section_331_id, 'created', 'section', '3.3.1',
       'Abschnitt 3.3.1 vollständig neu erstellt.', NULL,
       'Prämathematische Grundbegriffe und formaler Ausgangspunkt.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_331 AND section_id=@section_331_id AND change_type='created' AND object_reference='3.3.1');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_331, @section_331_id, 'source_added', 'source', '[106]–[107]',
       'Zwei Quellen zum strukturalistischen und relationalen Forschungsanschluss aufgenommen.', NULL,
       'Shapiro (1997), Rovelli (1996)'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_331 AND section_id=@section_331_id AND change_type='source_added' AND object_reference='[106]–[107]');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_331, @section_331_id, 'definition_added', 'definition', '3.3.1–3.3.5',
       'Fünf prämathematische und formale Grundbegriffe registriert.', NULL,
       'Funktionaler Gehalt, qualitative Unterscheidung, Differenzmaß, Wirksamkeit und aktuell wirksame Teilstruktur.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_331 AND section_id=@section_331_id AND change_type='definition_added' AND object_reference='3.3.1–3.3.5');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_331, @section_331_id, 'equation_added', 'equation', '(3.354)–(3.361)',
       'Acht Gleichungen des formalen Ausgangspunkts registriert.', NULL,
       'Trägerbereich, Unterscheidungsabbildung, Differenzmaß, Wirksamkeit und aktive Teilstruktur.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_331 AND section_id=@section_331_id AND change_type='equation_added' AND object_reference='(3.354)–(3.361)');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_331, @section_331_id, 'symbol_added', 'symbol', '\\mathcal{F}, \\delta_F, d_F, \\omega_F, \\mathcal{C}, \\mathcal{W}, \\mathcal{F}_A',
       'Zentrale Symbole des formalen Ausgangspunkts registriert.', NULL,
       'Symbolregister für Abschnitt 3.3.1 ergänzt.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision_331 AND section_id=@section_331_id AND change_type='symbol_added' AND object_reference='\\mathcal{F}, \\delta_F, d_F, \\omega_F, \\mathcal{C}, \\mathcal{W}, \\mathcal{F}_A');

/* --------------------------------------------------------------------------
   13. Abschlusskontrolle
   -------------------------------------------------------------------------- */

SELECT
    'REVISIONEN' AS pruefbereich,
    revision_code AS objekt,
    scope_reference AS details
FROM repository_revisions
WHERE revision_code IN ('RKB-NEU-K3.3.0-V1','RKB-NEU-K3.3.1-V1')

UNION ALL

SELECT
    'ABSCHNITTE',
    section_code,
    CONCAT(title, ' | ', status)
FROM dissertation_sections
WHERE section_code IN ('3.3','3.3.0','3.3.1')

UNION ALL

SELECT
    'QUELLEN',
    CONCAT('[', citation_number, ']'),
    short_citation_text
FROM sources
WHERE citation_number BETWEEN 103 AND 107

UNION ALL

SELECT
    'GLEICHUNGEN',
    CONCAT('(', equation_number, ')'),
    title
FROM equations
WHERE equation_number IN ('3.354','3.355','3.356','3.357','3.358','3.359','3.360','3.361')

ORDER BY pruefbereich, objekt;

COMMIT;
