/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.8

   Grenzen und offene mathematische Fragen

   Grundlage:
   - Kapitel 3.5.7 abgeschlossen
   - Gleichungen (3.1208)-(3.1212)
   - Literatur bereits vorhanden

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.8
   ============================================================ */

INSERT INTO repository_revisions
(
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    summary
)
SELECT
    'RKB-K3.5.8-V1',
    NOW(),
    'section',
    '3.5.8',
    '1.0',
    'Grenzen und offene mathematische Fragen der funktionalen Organisation'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.8-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.8-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.8
   ============================================================ */

SET @chapter35_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5'
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
    @chapter35_id,
    '3.5.8',
    'Grenzen und offene mathematische Fragen',
    3,
    5.8000,
    'final',
    1,
    'Untersuchung der Grenzen, Voraussetzungen und offenen Erweiterungen des funktionalen Organisationsmodells'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.8'
);



SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.8'
    LIMIT 1
);



/* ============================================================
   3. Gleichung 3.1208
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
    provenance
)
SELECT
    '3.1208',
    @section_id,
    'Modell und Realisierung',
    '\mathcal{M}_F\neq\mathcal{R}',
    '\mathcal{M}_F\neq\mathcal{R}',
    'Unterscheidung zwischen funktionalem Modell und konkreter Realisierung',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1208'
);



/* ============================================================
   4. Gleichung 3.1209
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
    provenance
)
SELECT
    '3.1209',
    @section_id,
    'Erweiterung funktionaler Strukturen',
    '\Delta_F\rightarrow\Gamma_F\rightarrow T_F\rightarrow K_F\rightarrow\mathcal{F}_O',
    '\Delta_F\rightarrow\Gamma_F\rightarrow T_F\rightarrow K_F\rightarrow\mathcal{F}_O',
    'Entwicklung von Differenzen zu integrierter funktionaler Organisation',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1209'
);



/* ============================================================
   5. Gleichung 3.1210
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
    provenance
)
SELECT
    '3.1210',
    @section_id,
    'Berechenbarkeit funktionaler Organisation',
    'A_F:\mathcal{F}_O\rightarrow\{0,1\}',
    'A_F:\mathcal{F}_O\rightarrow\{0,1\}',
    'Entscheidungsabbildung für analysierbare funktionale Organisationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1210'
);



/* ============================================================
   6. Gleichung 3.1211
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
    provenance
)
SELECT
    '3.1211',
    @section_id,
    'Empirische Zuordnung',
    '\Phi_E:\mathcal{R}\rightarrow\mathcal{F}_O',
    '\Phi_E:\mathcal{R}\rightarrow\mathcal{F}_O',
    'Abbildung realer Systeme auf funktionale Organisationsstrukturen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1211'
);



/* ============================================================
   7. Gleichung 3.1212
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
    provenance
)
SELECT
    '3.1212',
    @section_id,
    'Gesamtentwicklung funktionaler Organisation',
    '\text{Differenz}\rightarrow\text{Relation}\rightarrow\text{Organisation}\rightarrow\text{Netzwerk}\rightarrow\text{Hierarchie}\rightarrow\text{Information}\rightarrow\text{Dynamik}',
    '\text{Differenz}\rightarrow\text{Relation}\rightarrow\text{Organisation}\rightarrow\text{Netzwerk}\rightarrow\text{Hierarchie}\rightarrow\text{Information}\rightarrow\text{Dynamik}',
    'Zusammenfassung der Entwicklungslinie funktionaler Organisation',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1212'
);



/* ============================================================
   8. Änderungsprotokoll
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
    new_value
)
VALUES
(
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.5.8',
    'Abschnitt 3.5.8 Grenzen und offene mathematische Fragen abgeschlossen.',
    NULL,
    '3.5.8 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.8 Repository Update erfolgreich'
    AS status;