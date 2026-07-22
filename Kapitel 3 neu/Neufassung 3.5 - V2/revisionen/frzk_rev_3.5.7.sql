/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.7

   Mathematische Zusammenführung

   Grundlage:
   - Kapitel 3.5.6 abgeschlossen
   - Gleichungen (3.1201)-(3.1207)
   - Literatur bereits vorhanden

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.7
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
    'RKB-K3.5.7-V1',
    NOW(),
    'section',
    '3.5.7',
    '1.0',
    'Mathematische Zusammenführung funktionaler Organisation'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.7-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.7-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.7
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
    '3.5.7',
    'Mathematische Zusammenführung',
    3,
    5.7000,
    'final',
    1,
    'Zusammenführung von Struktur, Kopplung, Information und Dynamik'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.7'
);



SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.7'
    LIMIT 1
);



/* ============================================================
   3. Gleichung 3.1201
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
    '3.1201',
    @section_id,
    'Integriertes funktionales Organisationsmodell',
    '\mathcal{F}_O=(\Omega_F,\Delta_F,\Gamma_F,T_F,K_F,\mathcal{I}_F)',
    '\mathcal{F}_O=(\Omega_F,\Delta_F,\Gamma_F,T_F,K_F,\mathcal{I}_F)',
    'Zusammenführung struktureller, relationaler, dynamischer und informationeller Eigenschaften',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1201'
);



/* ============================================================
   4. Gleichung 3.1202
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
    '3.1202',
    @section_id,
    'Abhängigkeit funktionaler Strukturen',
    '\Delta_F\rightarrow\Gamma_F\rightarrow T_F\rightarrow\mathcal{I}_F\rightarrow\mathcal{F}_O',
    '\Delta_F\rightarrow\Gamma_F\rightarrow T_F\rightarrow\mathcal{I}_F\rightarrow\mathcal{F}_O',
    'Logische Abhängigkeit der Organisationsstrukturen',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1202'
);



/* ============================================================
   5. Gleichung 3.1203
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
    '3.1203',
    @section_id,
    'Transformation des Organisationsmodells',
    'T_F:\mathcal{F}_O\rightarrow\mathcal{F}_O',
    'T_F:\mathcal{F}_O\rightarrow\mathcal{F}_O',
    'Transformation innerhalb der funktionalen Organisationsstruktur',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1203'
);



/* ============================================================
   6. Gleichung 3.1204
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
    '3.1204',
    @section_id,
    'Erhaltung funktionaler Invarianten',
    '\mathcal{F}_O''\cong\mathcal{F}_O\quad\text{unter Erhaltung funktionaler Invarianten}',
    '\mathcal{F}_O''\cong\mathcal{F}_O\quad\text{unter Erhaltung funktionaler Invarianten}',
    'Erhaltung der funktionalen Identität unter Transformation',
    'theorem',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1204'
);



/* ============================================================
   7. Gleichung 3.1205
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
    '3.1205',
    @section_id,
    'Funktionale Kohärenz des Gesamtsystems',
    'C_F=\frac{|\Gamma_F^{erhalten}|}{|\Gamma_F^{gesamt}|}',
    'C_F=\frac{|\Gamma_F^{erhalten}|}{|\Gamma_F^{gesamt}|}',
    'Verhältnis erhaltener zu gesamter funktionaler Relationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1205'
);



/* ============================================================
   8. Gleichung 3.1206
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
    '3.1206',
    @section_id,
    'Rekursive funktionale Organisation',
    '\mathcal{F}_{O}^{(n)}\subset\mathcal{F}_{O}^{(n+1)}',
    '\mathcal{F}_{O}^{(n)}\subset\mathcal{F}_{O}^{(n+1)}',
    'Einordnung einer Organisation in eine höhere Organisationsebene',
    'corollary',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1206'
);



/* ============================================================
   9. Gleichung 3.1207
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
    '3.1207',
    @section_id,
    'Gesamte Entwicklung funktionaler Organisation',
    '\Delta_F\Rightarrow\Gamma_F\Rightarrow T_F\Rightarrow K_F\Rightarrow\mathcal{N}_F\Rightarrow\mathcal{H}_F\Rightarrow\mathcal{I}_F\Rightarrow\mathcal{D}_F\Rightarrow\mathcal{F}_O',
    '\Delta_F\Rightarrow\Gamma_F\Rightarrow T_F\Rightarrow K_F\Rightarrow\mathcal{N}_F\Rightarrow\mathcal{H}_F\Rightarrow\mathcal{I}_F\Rightarrow\mathcal{D}_F\Rightarrow\mathcal{F}_O',
    'Zusammenführung aller Entwicklungsschritte funktionaler Organisation',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1207'
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
    new_value
)
VALUES
(
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.5.7',
    'Abschnitt 3.5.7 Mathematische Zusammenführung abgeschlossen.',
    NULL,
    '3.5.7 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.7 Repository Update erfolgreich'
    AS status;