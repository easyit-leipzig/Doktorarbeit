/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9.3 – Das FRZK als geschlossenes Axiomensystem
   Schema: frzk_rkb(3).sql
   MariaDB 10.4 kompatibel
   Keine temporären Tabellen, keine MEMORY-Engine, keine CAST-Ausdrücke
   ============================================================ */

START TRANSACTION;

/* ------------------------------------------------------------
   1. Revision
   ------------------------------------------------------------ */

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
    'RKB-2026-07-25-K3.9.3',
    NOW(),
    'section',
    '3.9.3',
    '1.0',
    'Repository-Update für Abschnitt 3.9.3: Darstellung des FRZK als geschlossenes Axiomensystem einschließlich Ableitungsstruktur, Konsistenzbedingungen, funktionaler Nullskalierung und Validierungsbezug.',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = 'RKB-2026-07-25-K3.9.3'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-2026-07-25-K3.9.3'
    LIMIT 1
);

/* ------------------------------------------------------------
   2. Kapitel 3.9 und Abschnitt 3.9.3
   ------------------------------------------------------------ */

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
    NULL,
    '3.9',
    'Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    3.9000,
    'draft',
    1,
    'Abschließende theoretische Synthese des Funktionalen Raum-Zeit-Kohärenzsystems.'
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
    '3.9.3',
    'Das FRZK als geschlossenes Axiomensystem',
    3,
    3.9300,
    'draft',
    1,
    'Synthese der axiomatischen, definitorischen und beweislogischen Ableitungsstruktur des FRZK.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.9.3'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.9.3'
    LIMIT 1
);

/* ------------------------------------------------------------
   3. Gleichungen 3.461 bis 3.482
   ------------------------------------------------------------ */

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.461',@section_id,'Menge der FRZK-Axiome',
'\\mathcal{A}=\\{A_1,A_2,\\ldots,A_m\\}',
'\\mathcal{A}=\\{A_1,A_2,\\ldots,A_m\\}',
'Gesamtheit der im FRZK gesetzten funktionalen Axiome.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.461');

INSERT INTO equations
SELECT NULL,'3.462',@section_id,'Axiomatische Abhängigkeitsordnung',
'\\mathcal{A}_{U}\\rightarrow\\mathcal{A}_{R}\\rightarrow\\mathcal{A}_{T}\\rightarrow\\mathcal{A}_{O}\\rightarrow\\mathcal{A}_{K}\\rightarrow\\mathcal{A}_{RZ}',
'\\mathcal{A}_{U}\\rightarrow\\mathcal{A}_{R}\\rightarrow\\mathcal{A}_{T}\\rightarrow\\mathcal{A}_{O}\\rightarrow\\mathcal{A}_{K}\\rightarrow\\mathcal{A}_{RZ}',
'Logische Ordnung von Unterscheidbarkeit, Relation, Transformation, Organisation, Kohärenz sowie Raum und Zeit.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.462');

INSERT INTO equations
SELECT NULL,'3.463',@section_id,'Menge der Definitionen',
'\\mathcal{D}=\\{D_1,D_2,\\ldots,D_p\\}',
'\\mathcal{D}=\\{D_1,D_2,\\ldots,D_p\\}',
'Gesamtheit der innerhalb des FRZK eingeführten Definitionen.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.463');

INSERT INTO equations
SELECT NULL,'3.464',@section_id,'Definitorische Abhängigkeit',
'D_j=\\operatorname{Def}\\bigl(\\mathcal{A}_j,D_1,\\ldots,D_{j-1}\\bigr)',
'D_j=\\operatorname{Def}\\bigl(\\mathcal{A}_j,D_1,\\ldots,D_{j-1}\\bigr)',
'Eine Definition wird aus einschlägigen Axiomen und bereits eingeführten Definitionen bestimmt.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.464');

INSERT INTO equations
SELECT NULL,'3.465',@section_id,'Menge der Lemmata',
'\\mathcal{L}=\\{L_1,L_2,\\ldots,L_q\\}',
'\\mathcal{L}=\\{L_1,L_2,\\ldots,L_q\\}',
'Gesamtheit der bewiesenen Hilfsaussagen des FRZK.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.465');

INSERT INTO equations
SELECT NULL,'3.466',@section_id,'Herleitbarkeit eines Lemmas',
'\\mathcal{A}\\cup\\mathcal{D}\\vdash L_i',
'\\mathcal{A}\\cup\\mathcal{D}\\vdash L_i',
'Ein Lemma ist aus Axiomen und Definitionen formal herleitbar.','lemma','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.466');

INSERT INTO equations
SELECT NULL,'3.467',@section_id,'Menge der Sätze',
'\\mathcal{S}=\\{S_1,S_2,\\ldots,S_r\\}',
'\\mathcal{S}=\\{S_1,S_2,\\ldots,S_r\\}',
'Gesamtheit der zentralen mathematischen Sätze des FRZK.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.467');

INSERT INTO equations
SELECT NULL,'3.468',@section_id,'Herleitbarkeit eines Satzes',
'\\mathcal{A}\\cup\\mathcal{D}\\cup\\mathcal{L}\\vdash S_k',
'\\mathcal{A}\\cup\\mathcal{D}\\cup\\mathcal{L}\\vdash S_k',
'Ein Satz folgt formal aus Axiomen, Definitionen und Lemmata.','theorem','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.468');

INSERT INTO equations
SELECT NULL,'3.469',@section_id,'Menge der Korollare',
'\\mathcal{C}=\\{C_1,C_2,\\ldots,C_s\\}',
'\\mathcal{C}=\\{C_1,C_2,\\ldots,C_s\\}',
'Gesamtheit der aus Sätzen abgeleiteten Korollare.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.469');

INSERT INTO equations
SELECT NULL,'3.470',@section_id,'Herleitbarkeit eines Korollars',
'S_k\\vdash C_l',
'S_k\\vdash C_l',
'Ein Korollar folgt aus einem bereits bewiesenen Satz.','derived','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.470');

INSERT INTO equations
SELECT NULL,'3.471',@section_id,'Formale Ableitungskette',
'\\mathcal{A}\\rightarrow\\mathcal{D}\\rightarrow\\mathcal{L}\\rightarrow\\mathcal{S}\\rightarrow\\mathcal{C}',
'\\mathcal{A}\\rightarrow\\mathcal{D}\\rightarrow\\mathcal{L}\\rightarrow\\mathcal{S}\\rightarrow\\mathcal{C}',
'Axiome tragen Definitionen, Lemmata, Sätze und Korollare.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.471');

INSERT INTO equations
SELECT NULL,'3.472',@section_id,'Begründungsgraph',
'G_{\\mathrm{B}}=\\bigl(V_{\\mathrm{B}},E_{\\mathrm{B}}\\bigr)',
'G_{\\mathrm{B}}=\\bigl(V_{\\mathrm{B}},E_{\\mathrm{B}}\\bigr)',
'Gerichteter Graph der formalen Begründungsbeziehungen.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.472');

INSERT INTO equations
SELECT NULL,'3.473',@section_id,'Knotenmenge des Begründungsgraphen',
'V_{\\mathrm{B}}=\\mathcal{A}\\cup\\mathcal{D}\\cup\\mathcal{L}\\cup\\mathcal{S}\\cup\\mathcal{C}',
'V_{\\mathrm{B}}=\\mathcal{A}\\cup\\mathcal{D}\\cup\\mathcal{L}\\cup\\mathcal{S}\\cup\\mathcal{C}',
'Knotenmenge aus sämtlichen formalen Objekten des Axiomensystems.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.473');

INSERT INTO equations
SELECT NULL,'3.474',@section_id,'Kante des Begründungsgraphen',
'(v_i,v_j)\\in E_{\\mathrm{B}}',
'(v_i,v_j)\\in E_{\\mathrm{B}}',
'Gerichtete Abhängigkeit eines formalen Objekts von einem anderen.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.474');

INSERT INTO equations
SELECT NULL,'3.475',@section_id,'Endlicher Begründungspfad',
'\\exists A_i\\in\\mathcal{A}:A_i\\leadsto v',
'\\exists A_i\\in\\mathcal{A}:A_i\\leadsto v',
'Jedes nichtaxiomatische Objekt besitzt einen Begründungspfad zu mindestens einem Axiom.','theorem','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.475');

INSERT INTO equations
SELECT NULL,'3.476',@section_id,'Widerspruchsfreiheitsbedingung',
'\\neg\\exists P:\\bigl(\\mathcal{A}\\vdash P\\bigr)\\land\\bigl(\\mathcal{A}\\vdash\\neg P\\bigr)',
'\\neg\\exists P:\\bigl(\\mathcal{A}\\vdash P\\bigr)\\land\\bigl(\\mathcal{A}\\vdash\\neg P\\bigr)',
'Eine Aussage und ihre Negation dürfen nicht zugleich aus dem Axiomensystem folgen.','axiom','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.476');

INSERT INTO equations
SELECT NULL,'3.477',@section_id,'Klassische Nullskalierung',
'0\\mathbf{v}=\\mathbf{0}',
'0\\mathbf{v}=\\mathbf{0}',
'Klassische Skalarmultiplikation eines Vektors mit null.','other','literature',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.477');

INSERT INTO equations
SELECT NULL,'3.478',@section_id,'Funktionales Vektorobjekt',
'\\mathbf{v}_{\\mathrm{F}}=\\bigl(\\rho,\\hat{\\mathbf{d}}\\bigr)',
'\\mathbf{v}_{\\mathrm{F}}=\\bigl(\\rho,\\hat{\\mathbf{d}}\\bigr)',
'Erweitertes Zustandsobjekt aus Wirkungsbetrag und gespeicherter funktionaler Richtung.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.478');

INSERT INTO equations
SELECT NULL,'3.479',@section_id,'Funktionale Nullskalierung',
'0\\odot\\mathbf{v}_{\\mathrm{F}}=\\bigl(0,\\hat{\\mathbf{d}}\\bigr)',
'0\\odot\\mathbf{v}_{\\mathrm{F}}=\\bigl(0,\\hat{\\mathbf{d}}\\bigr)',
'Nullsetzung des Wirkungsbetrags bei Erhaltung der gespeicherten funktionalen Richtung.','axiom','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.479');

INSERT INTO equations
SELECT NULL,'3.480',@section_id,'Explizite Nullungsoperation',
'\\mathcal{N}\\bigl(0,\\hat{\\mathbf{d}}\\bigr)=\\bigl(0,\\varnothing\\bigr)',
'\\mathcal{N}\\bigl(0,\\hat{\\mathbf{d}}\\bigr)=\\bigl(0,\\varnothing\\bigr)',
'Gesonderte Operation zur Löschung der gespeicherten Richtungsinformation.','definition','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.480');

INSERT INTO equations
SELECT NULL,'3.481',@section_id,'Axiomatisch zulässiger Simulationsraum',
'\\mathcal{Z}_{\\mathrm{sim}}\\subseteq\\mathcal{Z}_{\\mathcal{A}}',
'\\mathcal{Z}_{\\mathrm{sim}}\\subseteq\\mathcal{Z}_{\\mathcal{A}}',
'Der Simulationsraum ist auf axiomatisch zulässige Zustände beschränkt.','model','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.481');

INSERT INTO equations
SELECT NULL,'3.482',@section_id,'Erweiterte methodische Ableitungskette',
'\\mathcal{A}\\rightarrow\\mathcal{D}\\rightarrow\\mathcal{L}\\rightarrow\\mathcal{S}\\rightarrow\\mathcal{C}\\rightarrow\\mathcal{M}\\rightarrow\\mathcal{V}',
'\\mathcal{A}\\rightarrow\\mathcal{D}\\rightarrow\\mathcal{L}\\rightarrow\\mathcal{S}\\rightarrow\\mathcal{C}\\rightarrow\\mathcal{M}\\rightarrow\\mathcal{V}',
'Erweiterung der formalen Ableitung um Modellbildung und Validierung.','schema','original',NULL,NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.482');

/* ------------------------------------------------------------
   4. Literaturverwendungen
   Verwendete Masterquellen: [7], [8], [9], [10], [23], [24]
   ------------------------------------------------------------ */

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'historical_context',
'Historische Entwicklung der axiomatischen Methode von der euklidischen Systematisierung bis zur formalen Axiomatik.',
'Abschnitt 3.9.3',0,1,'Wiederverwendung der vorhandenen Masterquelle [7].',@revision_id
FROM sources
WHERE citation_number=7
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id=sources.source_id
        AND section_id=@section_id
        AND exact_location='Abschnitt 3.9.3'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'historical_context',
'Formale Axiomatik und explizite Grundannahmen als methodische Grundlage mathematischer Theorien.',
'Abschnitt 3.9.3',0,1,'Wiederverwendung der vorhandenen Masterquelle [8].',@revision_id
FROM sources
WHERE citation_number=8
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id=sources.source_id
        AND section_id=@section_id
        AND exact_location='Abschnitt 3.9.3'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'background',
'Strukturelle Mathematik und axiomatische Organisation mathematischer Gegenstandsbereiche.',
'Abschnitt 3.9.3',0,1,'Wiederverwendung der vorhandenen Masterquelle [9].',@revision_id
FROM sources
WHERE citation_number=9
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id=sources.source_id
        AND section_id=@section_id
        AND exact_location='Abschnitt 3.9.3'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'background',
'Mathematische Strukturierung vorausgesetzter Räume und formaler Abbildungen.',
'Abschnitt 3.9.3',0,1,'Wiederverwendung der vorhandenen Masterquelle [10].',@revision_id
FROM sources
WHERE citation_number=10
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id=sources.source_id
        AND section_id=@section_id
        AND exact_location='Abschnitt 3.9.3'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'historical_context',
'Historische Grundlage der Mengenbildung und formalen mathematischen Objektkonstruktion.',
'Abschnitt 3.9.3',0,1,'Wiederverwendung der vorhandenen Masterquelle [23].',@revision_id
FROM sources
WHERE citation_number=23
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id=sources.source_id
        AND section_id=@section_id
        AND exact_location='Abschnitt 3.9.3'
  );

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT source_id,@section_id,'historical_context',
'Axiomatische Fundierung der modernen Mengenlehre.',
'Abschnitt 3.9.3',0,1,'Wiederverwendung der vorhandenen Masterquelle [24].',@revision_id
FROM sources
WHERE citation_number=24
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage
      WHERE source_id=sources.source_id
        AND section_id=@section_id
        AND exact_location='Abschnitt 3.9.3'
  );

/* ------------------------------------------------------------
   5. Änderungsprotokoll
   ------------------------------------------------------------ */

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value,changed_at)
SELECT
    @revision_id,@section_id,'created','section','3.9.3',
    'Abschnitt 3.9.3 als Synthese des FRZK-Axiomensystems registriert.',
    NULL,'draft',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.9.3'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value,changed_at)
SELECT
    @revision_id,@section_id,'equation_added','equations','3.461–3.482',
    '22 Gleichungen zur axiomatischen Ableitungsstruktur, Konsistenz, funktionalen Nullskalierung und Validierung registriert.',
    NULL,'22',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='3.461–3.482'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value,changed_at)
SELECT
    @revision_id,@section_id,'source_reused','literature','[7], [8], [9], [10], [23], [24]',
    'Sechs bereits nummerierte Masterquellen wurden mit Abschnitt 3.9.3 verknüpft.',
    NULL,
    CONCAT(
        '',
        (
            SELECT COUNT(*)
            FROM source_usage
            WHERE section_id=@section_id
              AND exact_location='Abschnitt 3.9.3'
        )
    ),
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_reused'
      AND object_reference='[7], [8], [9], [10], [23], [24]'
);

/* ------------------------------------------------------------
   6. Validierungen
   ------------------------------------------------------------ */

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number BETWEEN '3.461' AND '3.482'
);

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id=@section_id
      AND exact_location='Abschnitt 3.9.3'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,
    'K3_9_3_SECTION_EXISTS',
    CASE WHEN @section_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüft, ob Abschnitt 3.9.3 im Repository vorhanden ist.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_3_SECTION_EXISTS'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,
    'K3_9_3_EQUATION_COUNT',
    CASE WHEN @equation_count=22 THEN 'passed' ELSE 'failed' END,
    '22',
    CONCAT('',@equation_count),
    'Prüft die Gleichungen 3.461 bis 3.482 für Abschnitt 3.9.3.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_3_EQUATION_COUNT'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,
    'K3_9_3_SOURCE_USAGE_COUNT',
    CASE WHEN @source_usage_count=6 THEN 'passed' ELSE 'warning' END,
    '6',
    CONCAT('',@source_usage_count),
    'Prüft die sechs vorgesehenen Literaturverknüpfungen für Abschnitt 3.9.3.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_3_SOURCE_USAGE_COUNT'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,
    'K3_9_3_WORD_LATEX',
    CASE
        WHEN
        (
            SELECT COUNT(*)
            FROM equations
            WHERE section_id=@section_id
              AND equation_number BETWEEN '3.461' AND '3.482'
              AND (word_latex IS NULL OR word_latex='')
        )=0
        THEN 'passed'
        ELSE 'failed'
    END,
    '0 fehlende Word-LaTeX-Einträge',
    CONCAT(
        '',
        (
            SELECT COUNT(*)
            FROM equations
            WHERE section_id=@section_id
              AND equation_number BETWEEN '3.461' AND '3.482'
              AND (word_latex IS NULL OR word_latex='')
        )
    ),
    'Prüft die Vollständigkeit der Word-LaTeX-Felder.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_3_WORD_LATEX'
);

COMMIT;

/* ------------------------------------------------------------
   7. Importkontrolle
   ------------------------------------------------------------ */

SELECT
    ds.section_code,
    ds.title,
    ds.status,
    ds.is_original_contribution
FROM dissertation_sections ds
WHERE ds.section_code='3.9.3';

SELECT
    COUNT(*) AS equation_count_3_9_3
FROM equations
WHERE section_id=@section_id
  AND equation_number BETWEEN '3.461' AND '3.482';

SELECT
    COUNT(*) AS source_usage_count_3_9_3
FROM source_usage
WHERE section_id=@section_id
  AND exact_location='Abschnitt 3.9.3';

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_result_id;
