/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.4

   Hierarchische funktionale Systeme

   Grundlage:
   - Kapitel 3.5.3 abgeschlossen
   - Gleichungen (3.1183)-(3.1188)
   - Literatur [55], [63] bereits vorhanden

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.4
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
    'RKB-K3.5.4-V1',
    NOW(),
    'section',
    '3.5.4',
    '1.0',
    'Hierarchische funktionale Systeme und Ebenenbeziehungen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.4-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.4-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.4
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
    '3.5.4',
    'Hierarchische funktionale Systeme',
    3,
    5.4000,
    'final',
    1,
    'Mathematische Beschreibung hierarchischer Beziehungen funktionaler Organisationsebenen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.4'
);



SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.4'
    LIMIT 1
);



/* ============================================================
   3. Gleichung 3.1183
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
    '3.1183',
    @section_id,
    'Funktionale Hierarchie',
    '\mathcal{H}_F=\{\mathcal{L}_0,\mathcal{L}_1,\ldots,\mathcal{L}_m\}',
    '\mathcal{H}_F=\{\mathcal{L}_0,\mathcal{L}_1,\ldots,\mathcal{L}_m\}',
    'Geordnete Folge funktionaler Organisationsebenen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1183'
);



/* ============================================================
   4. Gleichung 3.1184
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
    '3.1184',
    @section_id,
    'Transformation zwischen Organisationsebenen',
    '\Phi_F^{(m)}:\mathcal{L}_m\rightarrow\mathcal{L}_{m+1}',
    '\Phi_F^{(m)}:\mathcal{L}_m\rightarrow\mathcal{L}_{m+1}',
    'Übergang einer funktionalen Organisationsebene zur nächsthöheren Ebene',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1184'
);



/* ============================================================
   5. Gleichung 3.1185
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
    '3.1185',
    @section_id,
    'Bildung höherer Organisationsebenen',
    '\mathcal{L}_{m+1}=\Psi_F(\mathcal{L}_m,\Gamma_m)',
    '\mathcal{L}_{m+1}=\Psi_F(\mathcal{L}_m,\Gamma_m)',
    'Bildung einer höheren Ebene aus bestehender Struktur und Relationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1185'
);



/* ============================================================
   6. Gleichung 3.1186
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
    '3.1186',
    @section_id,
    'Hierarchische Erweiterung durch Relationen',
    '\Gamma_m\Rightarrow\mathcal{L}_{m+1}',
    '\Gamma_m\Rightarrow\mathcal{L}_{m+1}',
    'Relationen einer Ebene ermöglichen die Bildung höherer Organisation',
    'lemma',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1186'
);



/* ============================================================
   7. Gleichung 3.1187
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
    '3.1187',
    @section_id,
    'Entwicklung funktionaler Organisation',
    '\text{Unterscheidbarkeit}\Longrightarrow\text{Relation}\Longrightarrow\text{Transformation}\Longrightarrow\text{Organisation}\Longrightarrow\text{Hierarchie}',
    '\text{Unterscheidbarkeit}\Longrightarrow\text{Relation}\Longrightarrow\text{Transformation}\Longrightarrow\text{Organisation}\Longrightarrow\text{Hierarchie}',
    'Erweiterte Entwicklungslinie funktionaler Organisation',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1187'
);



/* ============================================================
   8. Gleichung 3.1188
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
    '3.1188',
    @section_id,
    'Rückkopplung zwischen Organisationsebenen',
    'R_F:\mathcal{L}_{m+1}\times\mathcal{L}_m\rightarrow\mathbb{R}_{\geq0}',
    'R_F:\mathcal{L}_{m+1}\times\mathcal{L}_m\rightarrow\mathbb{R}_{\geq0}',
    'Beschreibung der Rückwirkung höherer Ebenen auf niedrigere Ebenen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1188'
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
    new_value
)
VALUES
(
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.5.4',
    'Abschnitt 3.5.4 Hierarchische funktionale Systeme abgeschlossen.',
    NULL,
    '3.5.4 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.4 Repository Update erfolgreich'
    AS status;