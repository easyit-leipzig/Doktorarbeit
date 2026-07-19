/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.2
   Axiom A1 – Funktionale Unterscheidbarkeit

   Voraussetzung:
     - Repository-Stand nach erfolgreichem Update 3.3.1
     - Revision RKB-NEU-K3.3.1-V1 vorhanden
     - Gleichungen bis (3.361)
     - Literatur bis [105]

   Inhalt:
     - Abschnitt 3.3.2
     - Wiederverwendung Spencer-Brown [23]
     - neue Quelle Shannon [106]
     - Gleichungen (3.362) bis (3.373)
     - Axiom A1
     - Proposition 3.3.1
     - Quellenverwendungen, Objekt-Quellen-Verknüpfungen und Änderungsprotokoll

   Eigenschaften:
     - idempotent
     - schema-konform zum hochgeladenen Repository-Dump
     - Quellen-IDs werden über source_key aufgelöst
   ============================================================================ */

START TRANSACTION;

/* --------------------------------------------------------------------------
   1. Ausgangsrevision und neue Revision
   -------------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.1-V1'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.3.2-V1', NOW(), 'section', '3.3.2', '1.0',
    'Abschluss von Abschnitt 3.3.2: Axiom A1 der funktionalen Unterscheidbarkeit, Proposition 3.3.1, Gleichungen (3.362) bis (3.373), Wiederverwendung Spencer-Brown [23] und neue Quelle Shannon [106].',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.2-V1'
);

SET @revision_332 :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.3.2-V1'
    LIMIT 1
);

/* --------------------------------------------------------------------------
   2. Abschnitt 3.3.2
   -------------------------------------------------------------------------- */

SET @section_33_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code = '3.3' LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no, section_order,
    status, is_original_contribution, notes
)
SELECT
    @section_33_id,
    '3.3.2',
    'Axiom A1 – Funktionale Unterscheidbarkeit',
    3,
    3.3020,
    'final',
    1,
    'Formulierung der minimalen funktionalen Unterscheidbarkeit, einschließlich Kontextabhängigkeit, funktionaler Nichtunterscheidbarkeit und Proposition zur Notwendigkeit funktionaler Differenz.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.3.2'
);

SET @section_332_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code = '3.3.2' LIMIT 1
);

/* --------------------------------------------------------------------------
   3. Literatur: Spencer-Brown [23] wiederverwenden, Shannon [106] neu anlegen
   -------------------------------------------------------------------------- */

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT 'Shannon', 'Claude E.', 'Shannon, Claude E.', 1916, 2001,
       'Autor der Quelle [106].'
WHERE NOT EXISTS
(
    SELECT 1 FROM authors WHERE normalized_name = 'Shannon, Claude E.'
);

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
    106,
    'shannon_mathematical_theory_communication_1948',
    'journal_article',
    'A Mathematical Theory of Communication',
    NULL,
    1948,
    1948,
    'Bell System Technical Journal',
    'Bell Telephone Laboratories',
    'New York',
    '27',
    NULL,
    '379–423; 623–656',
    NULL,
    '10.1002/j.1538-7305.1948.tb01338.x',
    NULL,
    NULL,
    'en',
    1,
    'primary',
    9,
    'verified',
    '3.3.2',
    'Erstnennung zur informationstheoretischen Voraussetzung unterscheidbarer Nachrichten- und Zustandsmöglichkeiten.',
    'Shannon, Claude E. (1948): A Mathematical Theory of Communication. In: Bell System Technical Journal, Bd. 27, S. 379–423 und 623–656.',
    'Shannon (1948)',
    'Primärquelle zur mathematischen Informationstheorie.',
    @revision_332
WHERE NOT EXISTS
(
    SELECT 1 FROM sources
    WHERE citation_number = 106
       OR source_key = 'shannon_mathematical_theory_communication_1948'
);

SET @source_spencer :=
(
    SELECT source_id FROM sources
    WHERE source_key = 'spencer_brown_laws_form_1969'
    LIMIT 1
);

SET @source_shannon :=
(
    SELECT source_id FROM sources
    WHERE source_key = 'shannon_mathematical_theory_communication_1948'
    LIMIT 1
);

SET @author_shannon :=
(
    SELECT author_id FROM authors
    WHERE normalized_name = 'Shannon, Claude E.'
    LIMIT 1
);

INSERT INTO source_authors (source_id, author_id, author_order, role)
SELECT @source_shannon, @author_shannon, 1, 'author'
WHERE @source_shannon IS NOT NULL
  AND @author_shannon IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1 FROM source_authors
      WHERE source_id = @source_shannon
        AND author_id = @author_shannon
        AND role = 'author'
  );

/* --------------------------------------------------------------------------
   4. Quellenverwendungen
   -------------------------------------------------------------------------- */

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_spencer, @section_332_id, 'background',
    'Wiederverwendung zur wissenschaftlichen Einordnung der Unterscheidung als elementarer Voraussetzung von Formbildung.',
    'Abschnitt 3.3.2, Begründung vor Axiom A1',
    0, 1,
    'Bereits vorhandene Quelle [23]; keine neue Literaturzahl.',
    @revision_332
WHERE @source_spencer IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_spencer
        AND section_id = @section_332_id
        AND exact_location = 'Abschnitt 3.3.2, Begründung vor Axiom A1'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_shannon, @section_332_id, 'first_citation',
    'Unterscheidbare Nachrichten- und Zustandsmöglichkeiten als Voraussetzung mathematisch bestimmbarer Information.',
    'Abschnitt 3.3.2, Begründung vor Axiom A1',
    1, 1,
    'Erstnennung als Quelle [106].',
    @revision_332
WHERE @source_shannon IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_shannon
        AND section_id = @section_332_id
        AND is_first_mention = 1
  );

/* --------------------------------------------------------------------------
   5. Axiom A1
   -------------------------------------------------------------------------- */

INSERT INTO axioms
(
    axiom_number, section_id, title, axiom_text,
    formal_latex, word_latex, motivation,
    independence_note, consistency_note, operationalization_note,
    status, created_revision_id
)
SELECT
    'A1',
    @section_332_id,
    'Funktionale Unterscheidbarkeit',
    'Innerhalb eines nichtleeren funktionalen Trägerbereichs existiert wenigstens ein Paar funktionaler Gehalte, das in mindestens einem funktionalen Kontext unterschiedliche Wirksamkeiten hervorbringt.',
    '\\mathcal{F}\\neq\\varnothing,\\qquad \\exists f_i,f_j\\in\\mathcal{F}\\;\\exists c\\in\\mathcal{C}:\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)',
    '\\mathcal{F}\\neq\\varnothing,\\qquad \\exists f_i,f_j\\in\\mathcal{F}\\;\\exists c\\in\\mathcal{C}:\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)',
    'Axiom A1 setzt die minimale Möglichkeit funktionaler Nichtidentität und schließt absolute funktionale Unterschiedslosigkeit als alleinigen Ausgangspunkt des FRZK aus.',
    'Axiom A1 wird als erste Grundsetzung nicht aus anderen FRZK-Axiomen abgeleitet.',
    'Die Setzung ist mit den in 3.3.1 eingeführten Träger-, Kontext- und Wirksamkeitsbegriffen vereinbar.',
    'Eine spätere Operationalisierung kann über kontextbezogene Differenzindikatoren oder Differenzmaße erfolgen.',
    'accepted',
    @revision_332
WHERE NOT EXISTS
(
    SELECT 1 FROM axioms WHERE axiom_number = 'A1'
);

SET @axiom_a1_id :=
(
    SELECT axiom_id FROM axioms WHERE axiom_number = 'A1' LIMIT 1
);

/* --------------------------------------------------------------------------
   6. Gleichungen (3.362) bis (3.373)
   -------------------------------------------------------------------------- */

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex, plain_description, equation_type, provenance, source_id, derivation, assumptions, validation_status, created_revision_id)
SELECT '3.362', @section_332_id, 'Nichtleerheit des funktionalen Trägerbereichs',
       '\\mathcal{F}\\neq\\varnothing', '\\mathcal{F}\\neq\\varnothing',
       'Der funktionale Trägerbereich ist nicht leer.', 'axiom', 'original', NULL,
       'Erster formaler Bestandteil von Axiom A1.', 'Der in 3.3.1 eingeführte Trägerbereich wird vorausgesetzt.', 'checked', @revision_332
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.362');

INSERT INTO equations SELECT NULL,'3.363',@section_332_id,'Kontextbezogene funktionale Nichtidentität','\\exists f_i,f_j\\in\\mathcal{F}\\;\\exists c\\in\\mathcal{C}:\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)','\\exists f_i,f_j\\in\\mathcal{F}\\;\\exists c\\in\\mathcal{C}:\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)','Mindestens zwei funktionale Gehalte wirken in wenigstens einem Kontext verschieden.','axiom','original',NULL,'Zweiter formaler Bestandteil von Axiom A1.','Funktionaler Trägerbereich, Kontextbereich und Wirksamkeitsabbildung sind eingeführt.','checked',@revision_332
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.363');

INSERT INTO equations SELECT NULL,'3.364',@section_332_id,'Unterscheidbarkeit über die qualitative Unterscheidungsfunktion','\\exists f_i,f_j\\in\\mathcal{F}:\\delta_F(f_i,f_j)=1','\\exists f_i,f_j\\in\\mathcal{F}:\\delta_F(f_i,f_j)=1','Es existiert mindestens ein funktional unterscheidbares Paar.','axiom','original',NULL,'Äquivalente Kurzform von Gleichung (3.363).','Definition von delta_F aus 3.3.1.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.364');
INSERT INTO equations SELECT NULL,'3.365',@section_332_id,'Minimale Mächtigkeit des Trägerbereichs','\\left|\\mathcal{F}\\right|\\geq 2','\\left|\\mathcal{F}\\right|\\geq 2','Der Trägerbereich besitzt mindestens zwei unterscheidbare Repräsentanten.','derived','original',NULL,'Folgerung aus Axiom A1 bei elementweiser Repräsentation funktionaler Unterschiede.','Unterschiedliche Wirksamkeiten werden durch unterschiedliche Repräsentanten abgebildet.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.365');
INSERT INTO equations SELECT NULL,'3.366',@section_332_id,'Selbst-Nichtunterscheidung','\\delta_F(f_i,f_i)=0\\qquad\\forall f_i\\in\\mathcal{F}','\\delta_F(f_i,f_i)=0\\qquad\\forall f_i\\in\\mathcal{F}','Ein funktionaler Gehalt wird in derselben Repräsentation nicht von sich selbst unterschieden.','definition','original',NULL,'Konsistenzbedingung der qualitativen Unterscheidungsfunktion.','Dieselbe Repräsentation und derselbe Betrachtungsrahmen werden vorausgesetzt.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.366');
INSERT INTO equations SELECT NULL,'3.367',@section_332_id,'Nichtgeltung formaler Verschiedenheit als hinreichende Bedingung','f_i\\neq f_j\\;\\not\\Rightarrow\\;\\delta_F(f_i,f_j)=1','f_i\\neq f_j\\;\\not\\Rightarrow\\;\\delta_F(f_i,f_j)=1','Formal verschiedene Repräsentanten müssen nicht funktional unterscheidbar sein.','derived','original',NULL,'Abgrenzung formaler Verschiedenheit von funktionaler Verschiedenheit.','Kontextabhängige Wirksamkeit wird zugelassen.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.367');
INSERT INTO equations SELECT NULL,'3.368',@section_332_id,'Funktionale Nichtunterscheidbarkeit','f_i\\sim_F f_j\\quad\\Longleftrightarrow\\quad\\delta_F(f_i,f_j)=0','f_i\\sim_F f_j\\quad\\Longleftrightarrow\\quad\\delta_F(f_i,f_j)=0','Zwei Gehalte sind funktional nicht unterscheidbar, wenn delta_F den Wert null annimmt.','definition','original',NULL,'Einführung der vorläufigen Relation funktionaler Nichtunterscheidbarkeit.','Symmetrie und Transitivität werden noch nicht vorausgesetzt.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.368');
INSERT INTO equations SELECT NULL,'3.369',@section_332_id,'Kontextbezogene Unterscheidungsfunktion','\\delta_F^{(c)}:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}','\\delta_F^{(c)}:\\mathcal{F}\\times\\mathcal{F}\\rightarrow\\{0,1\\}','Die qualitative Unterscheidungsfunktion wird auf einen bestimmten Kontext bezogen.','definition','original',NULL,'Präzisierung der in 3.3.1 eingeführten Unterscheidungsfunktion.','Ein Kontext c aus dem Kontextbereich C ist gewählt.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.369');
INSERT INTO equations SELECT NULL,'3.370',@section_332_id,'Kontextbezogene Wirksamkeitsdifferenz','\\delta_F^{(c)}(f_i,f_j)=1\\quad\\Longleftrightarrow\\quad\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)','\\delta_F^{(c)}(f_i,f_j)=1\\quad\\Longleftrightarrow\\quad\\omega_F(f_i,c)\\neq\\omega_F(f_j,c)','Kontextbezogene Unterscheidbarkeit liegt genau bei verschiedener Wirksamkeit vor.','definition','original',NULL,'Verknüpfung von kontextbezogener Unterscheidung und Wirksamkeit.','delta_F^(c) und omega_F sind definiert.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.370');
INSERT INTO equations SELECT NULL,'3.371',@section_332_id,'Globale Unterscheidung aus Kontexten','\\delta_F(f_i,f_j)=\\max_{c\\in\\mathcal{C}}\\delta_F^{(c)}(f_i,f_j)','\\delta_F(f_i,f_j)=\\max_{c\\in\\mathcal{C}}\\delta_F^{(c)}(f_i,f_j)','Globale Unterscheidbarkeit liegt vor, sobald mindestens ein Kontext eine Differenz ausweist.','derived','original',NULL,'Aggregation der binären kontextbezogenen Unterscheidungswerte.','Für den betrachteten Kontextbereich ist ein Maximum definiert; andernfalls ist später ein Supremum zu verwenden.','draft',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.371');
INSERT INTO equations SELECT NULL,'3.372',@section_332_id,'Voraussetzung vollständiger funktionaler Homogenität','\\forall f_i,f_j\\in\\mathcal{F}\\;\\forall c\\in\\mathcal{C}:\\omega_F(f_i,c)=\\omega_F(f_j,c)','\\forall f_i,f_j\\in\\mathcal{F}\\;\\forall c\\in\\mathcal{C}:\\omega_F(f_i,c)=\\omega_F(f_j,c)','Alle funktionalen Gehalte wirken in allen Kontexten gleich.','schema','original',NULL,'Negativer Grenzfall für Proposition 3.3.1.','Trägerbereich, Kontextbereich und Wirksamkeitsabbildung sind definiert.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.372');
INSERT INTO equations SELECT NULL,'3.373',@section_332_id,'Folge vollständiger funktionaler Homogenität','\\forall f_i,f_j\\in\\mathcal{F}:\\delta_F(f_i,f_j)=0','\\forall f_i,f_j\\in\\mathcal{F}:\\delta_F(f_i,f_j)=0','Bei vollständiger Wirkungsgleichheit existiert keine intern bestimmbare Differenzstruktur.','derived','original',NULL,'Folgt aus Gleichung (3.372) und der Definition von delta_F.','Gleichung (3.372) gilt.','checked',@revision_332 WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.373');

/* --------------------------------------------------------------------------
   7. Proposition 3.3.1
   -------------------------------------------------------------------------- */

INSERT INTO propositions
(
    proposition_number, section_id, title, statement_text,
    statement_latex, word_latex, logical_derivation,
    based_on_axioms, status, created_revision_id
)
SELECT
    '3.3.1',
    @section_332_id,
    'Notwendigkeit funktionaler Differenz',
    'Eine funktionale Organisation, die ausschließlich aus in allen Kontexten wirkungsgleichen Gehalten besteht, kann innerhalb des FRZK keine intern bestimmbare Differenzstruktur hervorbringen.',
    '\\bigl[\\forall f_i,f_j\\in\\mathcal{F}\\;\\forall c\\in\\mathcal{C}:\\omega_F(f_i,c)=\\omega_F(f_j,c)\\bigr]\\Rightarrow\\bigl[\\forall f_i,f_j\\in\\mathcal{F}:\\delta_F(f_i,f_j)=0\\bigr]',
    '\\bigl[\\forall f_i,f_j\\in\\mathcal{F}\\;\\forall c\\in\\mathcal{C}:\\omega_F(f_i,c)=\\omega_F(f_j,c)\\bigr]\\Rightarrow\\bigl[\\forall f_i,f_j\\in\\mathcal{F}:\\delta_F(f_i,f_j)=0\\bigr]',
    'Aus der Definition der funktionalen Unterscheidungsfunktion folgt unmittelbar: Sind alle Wirksamkeiten in allen Kontexten gleich, existiert kein Kontext, in dem eine funktionale Differenz festgestellt werden kann. Dies widerspricht Axiom A1, sofern vollständige Unterschiedslosigkeit als alleinige Struktur angenommen wird.',
    'A1',
    'accepted',
    @revision_332
WHERE NOT EXISTS
(
    SELECT 1 FROM propositions WHERE proposition_number = '3.3.1'
);

SET @proposition_331_id :=
(
    SELECT proposition_id FROM propositions
    WHERE proposition_number = '3.3.1' LIMIT 1
);

INSERT INTO proposition_dependencies
(proposition_id, axiom_id, assumption_id, dependency_type, note)
SELECT @proposition_331_id, @axiom_a1_id, NULL, 'derived_from',
       'Proposition 3.3.1 folgt aus Axiom A1 und der Definition der Unterscheidungsfunktion.'
WHERE @proposition_331_id IS NOT NULL
  AND @axiom_a1_id IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1 FROM proposition_dependencies
      WHERE proposition_id = @proposition_331_id
        AND axiom_id = @axiom_a1_id
        AND dependency_type = 'derived_from'
  );

/* --------------------------------------------------------------------------
   8. Objekt-Quellen-Verknüpfungen
   -------------------------------------------------------------------------- */

INSERT INTO object_source_links
(object_type, object_id, source_id, usage_type, note)
SELECT 'axiom', @axiom_a1_id, @source_spencer, 'historical_context',
       'Spencer-Brown dient als wissenschaftshistorischer Anschluss zur elementaren Rolle der Unterscheidung; Axiom A1 ist eine eigenständige FRZK-Setzung.'
WHERE @axiom_a1_id IS NOT NULL AND @source_spencer IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1 FROM object_source_links
      WHERE object_type='axiom' AND object_id=@axiom_a1_id AND source_id=@source_spencer
  );

INSERT INTO object_source_links
(object_type, object_id, source_id, usage_type, note)
SELECT 'axiom', @axiom_a1_id, @source_shannon, 'supporting_source',
       'Shannon stützt die wissenschaftliche Einordnung unterscheidbarer Möglichkeiten als Voraussetzung formaler Information; Axiom A1 bleibt originäre FRZK-Setzung.'
WHERE @axiom_a1_id IS NOT NULL AND @source_shannon IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1 FROM object_source_links
      WHERE object_type='axiom' AND object_id=@axiom_a1_id AND source_id=@source_shannon
  );

/* --------------------------------------------------------------------------
   9. Änderungsprotokoll
   -------------------------------------------------------------------------- */

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_332, @section_332_id, 'created', 'section', '3.3.2',
       'Abschnitt 3.3.2 vollständig neu angelegt und abgeschlossen.', NULL,
       'Axiom A1 – Funktionale Unterscheidbarkeit'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_332 AND section_id=@section_332_id
      AND change_type='created' AND object_reference='3.3.2'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_332, @section_332_id, 'source_reused', 'source', '[23]',
       'Spencer-Brown wurde mit bestehender Literaturzahl wiederverwendet.', NULL,
       'Spencer-Brown, Laws of Form [23]'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_332 AND object_reference='[23]'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_332, @section_332_id, 'source_added', 'source', '[106]',
       'Claude E. Shannon als neue Quelle aufgenommen.', NULL,
       'A Mathematical Theory of Communication [106]'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_332 AND object_reference='[106]'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_332, @section_332_id, 'axiom_added', 'axiom', 'A1',
       'Axiom A1 der funktionalen Unterscheidbarkeit aufgenommen.', NULL,
       'A1 – Funktionale Unterscheidbarkeit'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_332 AND object_reference='A1'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_332, @section_332_id, 'proposition_added', 'proposition', '3.3.1',
       'Proposition 3.3.1 zur Notwendigkeit funktionaler Differenz aufgenommen.', NULL,
       'Notwendigkeit funktionaler Differenz'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_332 AND object_reference='3.3.1'
      AND object_type='proposition'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference, change_summary, previous_value, new_value)
SELECT @revision_332, @section_332_id, 'equation_added', 'equation', '(3.362)–(3.373)',
       'Zwölf Gleichungen zu Axiom A1 und Proposition 3.3.1 aufgenommen.', NULL,
       'Gleichungen (3.362) bis (3.373)'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_332 AND object_reference='(3.362)–(3.373)'
);

/* --------------------------------------------------------------------------
   10. Validierung
   -------------------------------------------------------------------------- */

SELECT
    rr.revision_code,
    ds.section_code,
    ds.title,
    ds.status,
    (SELECT COUNT(*) FROM equations e WHERE e.section_id=ds.section_id) AS equation_count,
    (SELECT COUNT(*) FROM axioms a WHERE a.section_id=ds.section_id) AS axiom_count,
    (SELECT COUNT(*) FROM propositions p WHERE p.section_id=ds.section_id) AS proposition_count
FROM repository_revisions rr
JOIN dissertation_sections ds ON ds.section_code = rr.scope_reference
WHERE rr.revision_code = 'RKB-NEU-K3.3.2-V1';

SELECT citation_number, source_key, title
FROM sources
WHERE source_key IN
(
    'spencer_brown_laws_form_1969',
    'shannon_mathematical_theory_communication_1948'
)
ORDER BY citation_number;

SELECT equation_number, title, validation_status
FROM equations
WHERE section_id=@section_332_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

COMMIT;
