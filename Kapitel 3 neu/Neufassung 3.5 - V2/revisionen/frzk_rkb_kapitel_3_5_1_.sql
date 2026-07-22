/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.1

   Kopplung funktionaler Raum-Zeit-Strukturen

   Grundlage:
   - Kapitel 3.5.0 abgeschlossen
   - Gleichungen (3.1170)-(3.1173)
   - Literatur aus 3.5.0 [55]-[57]

   Schema:
   frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.1
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
    'RKB-K3.5.1-V1',
    NOW(),
    'section',
    '3.5.1',
    '1.0',
    'Kopplung funktionaler Raum-Zeit-Strukturen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.1-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.1-V1'
    LIMIT 1
);



/* ============================================================
   2. Abschnitt 3.5.1
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
    '3.5.1',
    'Kopplung funktionaler Raum-Zeit-Strukturen',
    3,
    5.1000,
    'final',
    1,
    'Mathematische Beschreibung der Kopplung eigenständiger funktionaler Organisationen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.1'
);



SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.1'
    LIMIT 1
);



/* ============================================================
   3. Gleichung 3.1170
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
    '3.1170',
    @section_id,
    'Funktionale Organisationsstruktur',
    '\mathcal{S}_i=(\Omega_i,\Delta_i,\Gamma_i,T_i)',
    '\mathcal{S}_i=(\Omega_i,\Delta_i,\Gamma_i,T_i)',
    'Beschreibung einer funktionalen Organisation durch Zustände, Differenzen, Relationen und Transformationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1170'
);



/* ============================================================
   4. Gleichung 3.1171
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
    '3.1171',
    @section_id,
    'Funktionale Kopplungsabbildung',
    'K_F:\mathcal{S}_i\times\mathcal{S}_j\rightarrow\mathcal{C}_F',
    'K_F:\mathcal{S}_i\times\mathcal{S}_j\rightarrow\mathcal{C}_F',
    'Abbildung zur Beschreibung der Kopplung zwischen funktionalen Organisationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1171'
);



/* ============================================================
   5. Gleichung 3.1172
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
    '3.1172',
    @section_id,
    'Erhaltung funktionaler Identität',
    '\Delta_i''\approx\Delta_i\land\Gamma_i''\approx\Gamma_i',
    '\Delta_i''\approx\Delta_i\land\Gamma_i''\approx\Gamma_i',
    'Erhaltung interner Differenz- und Relationsstrukturen unter Kopplung',
    'lemma',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1172'
);



/* ============================================================
   6. Gleichung 3.1173
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
    '3.1173',
    @section_id,
    'Erweiterte funktionale Organisationsstruktur',
    '\mathcal{G}_F^{+}=(\{\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n\},K_F)',
    '\mathcal{G}_F^{+}=(\{\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n\},K_F)',
    'Gesamtstruktur aus funktionalen Organisationen und ihren Kopplungen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1173'
);



/* ============================================================
   7. Änderungsprotokoll
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
    '3.5.1',
    'Abschnitt 3.5.1 Kopplung funktionaler Raum-Zeit-Strukturen abgeschlossen.',
    NULL,
    '3.5.1 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.1 Repository Update erfolgreich'
    AS status;