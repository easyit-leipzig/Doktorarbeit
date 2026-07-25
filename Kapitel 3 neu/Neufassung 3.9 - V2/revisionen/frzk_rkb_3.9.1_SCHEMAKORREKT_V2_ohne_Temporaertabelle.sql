/* ============================================================================
   FRZK-Repository – Kapitel 3.9.1
   Von der funktionalen Beschreibung zur mathematischen Theorie

   Schema-Grundlage: frzk_rkb(3).sql
   Zielsystem: MariaDB 10.4.x / MySQL-kompatibel
   Eigenschaften:
   - ausschließlich tatsächlich vorhandene Tabellen und Spalten
   - idempotente Anlage
   - Gleichungen 3.432 bis 3.438
   - Literaturverknüpfungen nur mit bereits vorhandenen Quellen
   - keine CAST(... AS CHAR)-Konstruktionen
   - keine temporären Tabellen und keine MEMORY-Engine
   ============================================================================ */

START TRANSACTION;

/* ============================================================================
   1. Vorhandene Elternrevision bestimmen
   ============================================================================ */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = '3.9.0'
    LIMIT 1
);

/* ============================================================================
   2. Revision 3.9.1 anlegen
   ============================================================================ */

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
    '3.9.1',
    NOW(),
    'section',
    '3.9.1',
    'Kapitel 3.9.1',
    'Synthese des Übergangs von der funktionalen Beschreibung zur mathematischen Theorie des Funktionalen Raum-Zeit-Kohärenzsystems.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = '3.9.1'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = '3.9.1'
    LIMIT 1
);

/* ============================================================================
   3. Kapitelhierarchie sicherstellen
   ============================================================================ */

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
    '3.9',
    'Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    9.0000,
    'draft',
    1,
    'Abschließendes Synthesekapitel des theoretischen Hauptteils von Kapitel 3.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.9'
);

SET @chapter_39_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.9'
    LIMIT 1
);

/* ============================================================================
   4. Abschnitt 3.9.1 anlegen beziehungsweise aktualisieren
   ============================================================================ */

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
    @chapter_39_id,
    '3.9.1',
    'Von der funktionalen Beschreibung zur mathematischen Theorie',
    3,
    9.0100,
    'draft',
    1,
    'Rekonstruiert den Übergang von Unterscheidbarkeit, Relation und Transformation zu Organisation, Kohärenz, Raum und Zeit.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.9.1'
);

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_39_id,
    title = 'Von der funktionalen Beschreibung zur mathematischen Theorie',
    chapter_no = 3,
    section_order = 9.0100,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Rekonstruiert den Übergang von Unterscheidbarkeit, Relation und Transformation zu Organisation, Kohärenz, Raum und Zeit.'
WHERE section_code = '3.9.1';

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.9.1'
    LIMIT 1
);

/* ============================================================================
   5. Gleichungen 3.432 bis 3.438
   ============================================================================ */

/* Gleichung 3.432 – Allgemeine Zustandsentwicklung */
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
    '3.432',
    @section_id,
    'Allgemeine funktionale Zustandsentwicklung',
    'Z_{t+1}=\\mathcal{O}_t(Z_t)',
    'Z_{t+1}=\\mathcal{O}_t(Z_t)',
    'Der Folgezustand entsteht durch die Wirkung des zum jeweiligen Ordnungsindex gehörenden Operators auf den aktuellen Zustand.',
    'model',
    'original',
    NULL,
    'Die Beziehung fasst eine einzelne funktionale Transformation als Operatorwirkung zusammen.',
    'Der Index t bezeichnet zunächst eine Ordnungsfolge und setzt keine physikalische Zeit voraus.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.432'
);

SET @eq_3432 := (SELECT equation_id FROM equations WHERE equation_number = '3.432' LIMIT 1);

/* Gleichung 3.433 – Operatorenkaskade */
INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.433',
    @section_id,
    'Rekursive Operatorenkaskade',
    'Z_n=\\left(\\mathcal{O}_{n-1}\\circ\\mathcal{O}_{n-2}\\circ\\cdots\\circ\\mathcal{O}_0\\right)(Z_0)',
    'Z_n=\\left(\\mathcal{O}_{n-1}\\circ\\mathcal{O}_{n-2}\\circ\\cdots\\circ\\mathcal{O}_0\\right)(Z_0)',
    'Der Zustand Z_n ergibt sich aus der geordneten Komposition aller vorausgehenden Operatoren, angewendet auf den Anfangszustand Z_0.',
    'derived',
    'original',
    NULL,
    'Wiederholte Anwendung der allgemeinen Zustandsentwicklung aus Gleichung 3.432.',
    'Die Reihenfolge der Operatoren ist funktional relevant und im Allgemeinen nicht vertauschbar.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.433'
);

SET @eq_3433 := (SELECT equation_id FROM equations WHERE equation_number = '3.433' LIMIT 1);

/* Gleichung 3.434 – Funktionale Elementmenge */
INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.434',
    @section_id,
    'Menge funktionaler Elemente',
    'F=\\{f_1,f_2,\\ldots,f_n\\}',
    'F=\\{f_1,f_2,\\ldots,f_n\\}',
    'F bezeichnet die endliche Menge der innerhalb einer betrachteten Organisation unterscheidbaren funktionalen Elemente.',
    'definition',
    'original',
    NULL,
    'Formale Zusammenfassung der funktional unterscheidbaren Elemente.',
    'Die Elemente werden über ihre funktionale Rolle und nicht über eine vorausgesetzte Objektontologie bestimmt.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.434'
);

SET @eq_3434 := (SELECT equation_id FROM equations WHERE equation_number = '3.434' LIMIT 1);

/* Gleichung 3.435 – Relationsstruktur */
INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.435',
    @section_id,
    'Funktionale Relationsstruktur',
    'R\\subseteq F\\times F',
    'R\\subseteq F\\times F',
    'Die Relationsstruktur R enthält die innerhalb der funktionalen Elementmenge wirksamen Beziehungen.',
    'definition',
    'original',
    NULL,
    'Relationen werden als Teilmenge des kartesischen Produkts der funktionalen Elementmenge dargestellt.',
    'Die formale Darstellung setzt unterscheidbare funktionale Elemente voraus.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.435'
);

SET @eq_3435 := (SELECT equation_id FROM equations WHERE equation_number = '3.435' LIMIT 1);

/* Gleichung 3.436 – Funktionale Organisation */
INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.436',
    @section_id,
    'Allgemeine Struktur funktionaler Organisation',
    '\\mathcal{G}=(F,R,\\mathcal{O})',
    '\\mathcal{G}=(F,R,\\mathcal{O})',
    'Eine funktionale Organisation wird durch ihre Elemente, ihre wirksamen Relationen und die auf ihnen operierenden Transformationen bestimmt.',
    'definition',
    'original',
    NULL,
    'Zusammenführung der Elementmenge F, der Relationsstruktur R und der Operatorstruktur O.',
    'Die drei Komponenten müssen innerhalb desselben funktionalen Bezugsrahmens bestimmt sein.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.436'
);

SET @eq_3436 := (SELECT equation_id FROM equations WHERE equation_number = '3.436' LIMIT 1);

/* Gleichung 3.437 – Funktionale Wirksamkeit eines Unterschieds */
INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.437',
    @section_id,
    'Bedingung funktionaler Wirksamkeit',
    '\\Delta Z\\neq 0\\quad\\land\\quad\\Delta\\mathcal{G}\\neq 0',
    '\\Delta Z\\neq 0\\quad\\land\\quad\\Delta\\mathcal{G}\\neq 0',
    'Ein Zustandsunterschied ist funktional wirksam, wenn er zugleich eine Veränderung der Organisationsstruktur hervorruft.',
    'definition',
    'original',
    NULL,
    'Verknüpfung eines feststellbaren Zustandsunterschieds mit seiner systemischen Wirkung.',
    'Die Änderung der Organisation kann Relationen, Operatoren oder Kohärenzbedingungen betreffen.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.437'
);

SET @eq_3437 := (SELECT equation_id FROM equations WHERE equation_number = '3.437' LIMIT 1);

/* Gleichung 3.438 – Leitkette der Gesamtrekonstruktion */
INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.438',
    @section_id,
    'Leitkette der funktionalen Gesamtrekonstruktion',
    '\\emptyset\\rightarrow\\text{Unterscheidbarkeit}\\rightarrow\\text{Relation}\\rightarrow\\text{Transformation}\\rightarrow\\text{Organisation}\\rightarrow\\text{Kohärenz}\\rightarrow\\text{Raum}\\rightarrow\\text{Zeit}',
    '\\emptyset\\rightarrow\\text{Unterscheidbarkeit}\\rightarrow\\text{Relation}\\rightarrow\\text{Transformation}\\rightarrow\\text{Organisation}\\rightarrow\\text{Kohärenz}\\rightarrow\\text{Raum}\\rightarrow\\text{Zeit}',
    'Die Gleichung verdichtet die logische Rekonstruktionsfolge des Funktionalen Raum-Zeit-Kohärenzsystems.',
    'schema',
    'original',
    NULL,
    'Synthese der in den Kapiteln 3.1 bis 3.8 entwickelten theoretischen Übergänge.',
    'Die Pfeile bezeichnen eine logische Rekonstruktionsfolge und keine bereits vorausgesetzte physikalische Zeitfolge.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number = '3.438'
);

SET @eq_3438 := (SELECT equation_id FROM equations WHERE equation_number = '3.438' LIMIT 1);

/* ============================================================================
   6. Gleichungssymbole
   ============================================================================ */

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3432, 'Z_t', 'Aktueller Zustand',
       'Funktionaler Zustand am Ordnungsindex t.', NULL,
       'Z_t innerhalb des jeweils definierten funktionalen Zustandsraums', 1
WHERE @eq_3432 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3432 AND symbol_latex='Z_t');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3432, 'Z_{t+1}', 'Folgezustand',
       'Durch den Operator O_t aus Z_t hervorgehender funktionaler Zustand.', NULL,
       'Z_{t+1} innerhalb des jeweils definierten funktionalen Zustandsraums', 2
WHERE @eq_3432 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3432 AND symbol_latex='Z_{t+1}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3432, '\\mathcal{O}_t', 'Zustandsoperator',
       'Operator, der am Ordnungsindex t auf den aktuellen Zustand wirkt.', NULL,
       'Geeignete Abbildung auf dem funktionalen Zustandsraum', 3
WHERE @eq_3432 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3432 AND symbol_latex='\\mathcal{O}_t');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3433, 'Z_0', 'Anfangszustand',
       'Ausgangszustand der betrachteten Operatorenkaskade.', NULL,
       'Funktionaler Zustandsraum', 1
WHERE @eq_3433 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3433 AND symbol_latex='Z_0');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3433, 'Z_n', 'Resultierender Zustand',
       'Nach n geordneten Operatorwirkungen erreichter Zustand.', NULL,
       'Funktionaler Zustandsraum', 2
WHERE @eq_3433 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3433 AND symbol_latex='Z_n');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3433, '\\circ', 'Operatorkomposition',
       'Geordnete Hintereinanderausführung zweier Operatoren.', NULL,
       'Komposition kompatibler Abbildungen', 3
WHERE @eq_3433 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3433 AND symbol_latex='\\circ');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3434, 'F', 'Funktionale Elementmenge',
       'Menge der innerhalb einer Organisation unterscheidbaren funktionalen Elemente.', NULL,
       'Endliche oder abzählbare Menge funktionaler Elemente', 1
WHERE @eq_3434 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3434 AND symbol_latex='F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3434, 'f_i', 'Funktionales Element',
       'Ein über seine unterscheidbare funktionale Rolle bestimmtes Element.', NULL,
       'f_i in F', 2
WHERE @eq_3434 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3434 AND symbol_latex='f_i');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3435, 'R', 'Relationsstruktur',
       'Menge der innerhalb F wirksamen funktionalen Beziehungen.', NULL,
       'Teilmenge von F mal F', 1
WHERE @eq_3435 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3435 AND symbol_latex='R');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3435, 'F\\times F', 'Kartesisches Produkt',
       'Menge aller geordneten Paare funktionaler Elemente aus F.', NULL,
       'Kartesisches Produkt der Menge F mit sich selbst', 2
WHERE @eq_3435 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3435 AND symbol_latex='F\\times F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3436, '\\mathcal{G}', 'Funktionale Organisation',
       'Geordnete Gesamtstruktur aus Elementen, Relationen und Operatoren.', NULL,
       'Tripel aus F, R und O', 1
WHERE @eq_3436 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3436 AND symbol_latex='\\mathcal{G}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3436, '\\mathcal{O}', 'Operatorstruktur',
       'Menge oder geordnete Struktur der innerhalb der Organisation wirksamen Operatoren.', NULL,
       'Geeignete Menge funktionaler Transformationen', 2
WHERE @eq_3436 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3436 AND symbol_latex='\\mathcal{O}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3437, '\\Delta Z', 'Zustandsänderung',
       'Feststellbarer Unterschied zwischen zwei funktionalen Zuständen.', NULL,
       'Differenz oder Veränderungsmaß des Zustands', 1
WHERE @eq_3437 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3437 AND symbol_latex='\\Delta Z');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3437, '\\Delta\\mathcal{G}', 'Organisationsänderung',
       'Durch eine Zustandsänderung hervorgerufene Veränderung der funktionalen Organisation.', NULL,
       'Veränderung mindestens einer Komponente von G', 2
WHERE @eq_3437 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3437 AND symbol_latex='\\Delta\\mathcal{G}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3438, '\\emptyset', 'Strukturell unbestimmter Ausgangspunkt',
       'Ausgangspunkt der Rekonstruktion, an dem noch keine bestimmte funktionale Struktur vorausgesetzt wird.', NULL,
       'Logischer Ausgangsbegriff, nicht physikalischer Leerraum', 1
WHERE @eq_3438 IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3438 AND symbol_latex='\\emptyset');

/* ============================================================================
   7. Literaturverwendungen

   Keine temporäre Tabelle:
   Jede Quellenverwendung wird direkt über citation_number mit sources verknüpft.
   ============================================================================ */


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
    s.source_id,
    @section_id,
    'historical_context',
    'Newton steht für den absoluten Raum- und Zeitbegriff der klassischen Mechanik.',
    'Abschnitt 3.9.1 – klassische Raum- und Zeitbegriffe',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 2
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – klassische Raum- und Zeitbegriffe'
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
    s.source_id,
    @section_id,
    'historical_context',
    'Einstein begründet die relativistische Neuordnung von Raum und Zeit.',
    'Abschnitt 3.9.1 – relativistische Neuordnung',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 4
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – relativistische Neuordnung'
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
    s.source_id,
    @section_id,
    'historical_context',
    'Die allgemeine Relativitätstheorie beschreibt Raumzeit als dynamische geometrische Struktur.',
    'Abschnitt 3.9.1 – relativistische Neuordnung',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 5
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – relativistische Neuordnung'
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
    s.source_id,
    @section_id,
    'historical_context',
    'Minkowski formuliert die geometrische Vereinigung von Raum und Zeit.',
    'Abschnitt 3.9.1 – relativistische Neuordnung',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 6
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – relativistische Neuordnung'
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
    s.source_id,
    @section_id,
    'background',
    'Bourbaki repräsentiert die strukturelle Systematisierung moderner mathematischer Räume.',
    'Abschnitt 3.9.1 – mathematische Strukturbegriffe',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 9
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – mathematische Strukturbegriffe'
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
    s.source_id,
    @section_id,
    'background',
    'Die Funktionalanalysis stellt den formalen Rahmen für lineare Räume und Operatoren bereit.',
    'Abschnitt 3.9.1 – Operatorbegriff',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 11
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Operatorbegriff'
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
    s.source_id,
    @section_id,
    'comparison',
    'Hakens Synergetik bildet einen Bezugspunkt für selbstorganisierte makroskopische Ordnungsbildung.',
    'Abschnitt 3.9.1 – Organisation und Selbstorganisation',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 12
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Organisation und Selbstorganisation'
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
    s.source_id,
    @section_id,
    'comparison',
    'Prigogines dissipative Strukturen dienen der Einordnung nichtgleichgewichtiger Selbstorganisation.',
    'Abschnitt 3.9.1 – Organisation und Selbstorganisation',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 13
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Organisation und Selbstorganisation'
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
    s.source_id,
    @section_id,
    'comparison',
    'Komplexe adaptive Systeme zeigen die Entstehung emergenter Ordnung aus lokalen Regeln.',
    'Abschnitt 3.9.1 – Emergenz',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 14
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Emergenz'
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
    s.source_id,
    @section_id,
    'background',
    'Barabási liefert den netzwerkwissenschaftlichen Bezug für Knoten, Verbindungen und skalenfreie Strukturen.',
    'Abschnitt 3.9.1 – Netzwerktheorie',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 15
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Netzwerktheorie'
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
    s.source_id,
    @section_id,
    'historical_context',
    'Cantor bildet einen historischen Bezugspunkt für den allgemeinen Mengenbegriff.',
    'Abschnitt 3.9.1 – Mengenlehre',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 23
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Mengenlehre'
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
    s.source_id,
    @section_id,
    'historical_context',
    'Zermelo bildet einen Bezugspunkt für die axiomatische Fundierung der Mengenlehre.',
    'Abschnitt 3.9.1 – Mengenlehre',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 24
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Mengenlehre'
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
    s.source_id,
    @section_id,
    'background',
    'Operatoren auf Banach- und Hilberträumen stützen die formale Einordnung funktionaler Transformationen.',
    'Abschnitt 3.9.1 – Operatorbegriff',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 35
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Operatorbegriff'
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
    s.source_id,
    @section_id,
    'background',
    'Strogatz dient als Referenz für nichtlineare Dynamik, Bifurkationen und Attraktoren.',
    'Abschnitt 3.9.1 – dynamische Systeme',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 37
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – dynamische Systeme'
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
    s.source_id,
    @section_id,
    'background',
    'Differentialgleichungen, Phasenräume und Chaos stützen die Einordnung von Trajektorien.',
    'Abschnitt 3.9.1 – dynamische Systeme',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 40
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – dynamische Systeme'
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
    s.source_id,
    @section_id,
    'background',
    'Funktionalanalysis und mathematische Physik bilden einen weiteren Bezug für Operatorstrukturen.',
    'Abschnitt 3.9.1 – Operatorbegriff',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 41
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Operatorbegriff'
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
    s.source_id,
    @section_id,
    'background',
    'Operatorhalbgruppen stützen die mathematische Beschreibung geordneter Zustandsentwicklungen.',
    'Abschnitt 3.9.1 – Operatorenkaskade',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 42
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Operatorenkaskade'
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
    s.source_id,
    @section_id,
    'background',
    'Die moderne Theorie dynamischer Systeme bildet den Referenzrahmen für Zustandsräume und Trajektorien.',
    'Abschnitt 3.9.1 – dynamische Systeme',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 43
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – dynamische Systeme'
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
    s.source_id,
    @section_id,
    'background',
    'Chaos, Attraktoren und Lyapunov-Exponenten dienen der Einordnung stabiler und instabiler Zustandsentwicklungen.',
    'Abschnitt 3.9.1 – dynamische Systeme',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 44
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – dynamische Systeme'
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
    s.source_id,
    @section_id,
    'background',
    'Die moderne Informationstheorie bildet den mathematischen Rahmen für Unsicherheit und statistische Abhängigkeit.',
    'Abschnitt 3.9.1 – Information',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 45
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Information'
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
    s.source_id,
    @section_id,
    'definition',
    'Shannon begründet den mathematischen Informationsbegriff und seine Abgrenzung von semantischer Bedeutung.',
    'Abschnitt 3.9.1 – Information',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 46
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Information'
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
    s.source_id,
    @section_id,
    'background',
    'Diestel dient als graphentheoretische Referenz für Knoten, Kanten, Pfade und Relationsstrukturen.',
    'Abschnitt 3.9.1 – Graphentheorie',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 47
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Graphentheorie'
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
    s.source_id,
    @section_id,
    'background',
    'Komplexe Netzwerke liefern den formalen Vergleichsrahmen für größere Zusammenhangsstrukturen.',
    'Abschnitt 3.9.1 – Netzwerktheorie',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 48
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Netzwerktheorie'
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
    s.source_id,
    @section_id,
    'background',
    'Die metrische Geometrie stellt Werkzeuge zur formalen Beschreibung von Nähe und Distanz bereit.',
    'Abschnitt 3.9.1 – funktionaler Raum',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 49
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – funktionaler Raum'
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
    s.source_id,
    @section_id,
    'comparison',
    'Biologische Selbstorganisation dient als Vergleich für die Entstehung geordneter Funktionszusammenhänge.',
    'Abschnitt 3.9.1 – Organisation und Selbstorganisation',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 51
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Organisation und Selbstorganisation'
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
    s.source_id,
    @section_id,
    'comparison',
    'Komplexität, Emergenz und adaptive Systeme bilden einen Vergleichsrahmen für globale Muster aus lokalen Wechselwirkungen.',
    'Abschnitt 3.9.1 – Emergenz',
    0,
    1,
    'Bereits vorhandene Masterquelle erneut verwendet.',
    @revision_id
FROM sources s
WHERE s.citation_number = 52
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id = s.source_id
        AND su.section_id = @section_id
        AND su.exact_location = 'Abschnitt 3.9.1 – Emergenz'
  );


/* ============================================================================
   8. Änderungsprotokoll
   ============================================================================ */

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
    '3.9.1',
    'Abschnitt 3.9.1 wurde als Synthese des Übergangs von der funktionalen Beschreibung zur mathematischen Theorie angelegt.',
    NULL,
    'draft',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'created'
      AND object_reference = '3.9.1'
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
    'equation_set',
    '3.432-3.438',
    'Sieben Gleichungen zur Zustandsentwicklung, Operatorenkaskade, funktionalen Organisation, Wirksamkeitsbedingung und Gesamtrekonstruktionskette wurden dokumentiert.',
    NULL,
    CONCAT('', (SELECT COUNT(*) FROM equations WHERE section_id = @section_id AND equation_number IN ('3.432','3.433','3.434','3.435','3.436','3.437','3.438'))),
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'equation_added'
      AND object_reference = '3.432-3.438'
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
    'source_reused',
    'source_usage',
    '3.9.1-literature',
    'Die im Abschnitt verwendeten wissenschaftlichen Grundlagen wurden mit den bereits vorhandenen Masterquellen des Repositorys verknüpft.',
    NULL,
    CONCAT('', (SELECT COUNT(*) FROM source_usage WHERE section_id = @section_id)),
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id = @revision_id
      AND section_id = @section_id
      AND change_type = 'source_reused'
      AND object_reference = '3.9.1-literature'
);

/* ============================================================================
   9. Abschluss
   ============================================================================ */

COMMIT;

/* ============================================================================
   10. Importkontrolle
   ============================================================================ */

SELECT
    r.revision_id,
    r.revision_code,
    r.scope_type,
    r.scope_reference,
    r.version_label
FROM repository_revisions r
WHERE r.revision_code = '3.9.1';

SELECT
    ds.section_id,
    ds.parent_section_id,
    ds.section_code,
    ds.title,
    ds.section_order,
    ds.status,
    ds.is_original_contribution
FROM dissertation_sections ds
WHERE ds.section_code IN ('3.9','3.9.1')
ORDER BY ds.section_order;

SELECT
    e.equation_number,
    e.title,
    e.equation_type,
    e.provenance,
    e.validation_status
FROM equations e
WHERE e.section_id = @section_id
  AND e.equation_number IN ('3.432','3.433','3.434','3.435','3.436','3.437','3.438')
ORDER BY e.equation_number;

SELECT
    COUNT(*) AS equation_count
FROM equations
WHERE section_id = @section_id
  AND equation_number IN ('3.432','3.433','3.434','3.435','3.436','3.437','3.438');

SELECT
    COUNT(*) AS equation_symbol_count
FROM equation_symbols es
INNER JOIN equations e ON e.equation_id = es.equation_id
WHERE e.section_id = @section_id
  AND e.equation_number IN ('3.432','3.433','3.434','3.435','3.436','3.437','3.438');

SELECT
    s.citation_number,
    s.short_citation_text,
    su.usage_type,
    su.exact_location,
    su.citation_checked
FROM source_usage su
INNER JOIN sources s ON s.source_id = su.source_id
WHERE su.section_id = @section_id
ORDER BY s.citation_number;

SELECT
    COUNT(*) AS source_usage_count
FROM source_usage
WHERE section_id = @section_id;

SELECT
    change_type,
    object_type,
    object_reference,
    change_summary,
    new_value,
    changed_at
FROM section_change_log
WHERE revision_id = @revision_id
  AND section_id = @section_id
ORDER BY change_id;
