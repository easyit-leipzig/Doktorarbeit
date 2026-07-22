/* ============================================================
   FRZK Repository Update
   Kapitel 3.5.0

   Mathematische Erweiterung funktionaler Organisation
   und ihre Anwendung

   Grundlage:
   - Abschluss Kapitel 3.4
   - Literatur [55]-[59]
   - Gleichungen (3.1167)-(3.1169)

   Schema angepasst an frzk_rkb_3.4_final.sql

   idempotent
   ============================================================ */


/* ============================================================
   1. Revision Kapitel 3.5.0
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
    'RKB-K3.5.0-V1',
    NOW(),
    'section',
    '3.5.0',
    '1.0',
    'Beginn Kapitel 3.5: mathematische Erweiterung funktionaler Organisation'
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.0-V1'
);


SET @revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-K3.5.0-V1'
    LIMIT 1
);



/* ============================================================
   2. Kapitel 3.5
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
    NULL,
    '3.5',
    'Mathematische Erweiterung funktionaler Organisation und ihre Anwendung',
    3,
    5,
    'draft',
    1,
    'Erweiterung einzelner funktionaler Organisationen zu gekoppelten Strukturen'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5'
);


SET @chapter35_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5'
    LIMIT 1
);



/* ============================================================
   3. Abschnitt 3.5.0
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
    @chapter35_id,
    '3.5.0',
    'Einleitung',
    3,
    5.0000,
    'final',
    1,
    'Einführung der Erweiterung von funktionalen Organisationen auf gekoppelte Systeme'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.5.0'
);


SET @section_id =
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.5.0'
    LIMIT 1
);



/* ============================================================
   4. Gleichungen 3.1167 - 3.1169
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
    '3.1167',
    @section_id,
    'Menge funktionaler Organisationen',
    '\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n',
    '\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n',
    'Darstellung mehrerer eigenständiger funktionaler Organisationen',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1167'
);



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
    '3.1168',
    @section_id,
    'Übergeordnete funktionale Organisationsstruktur',
    '\mathcal{G}_F=\{\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n\}',
    '\mathcal{G}_F=\{\mathcal{S}_1,\mathcal{S}_2,\ldots,\mathcal{S}_n\}',
    'Gesamtheit mehrerer funktionaler Organisationen',
    'schema',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1168'
);



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
    '3.1169',
    @section_id,
    'Funktionale Kopplungsrelation',
    '\Gamma_F:\mathcal{S}_i\times\mathcal{S}_j\rightarrow\mathbb{R}_{\geq0}',
    '\Gamma_F:\mathcal{S}_i\times\mathcal{S}_j\rightarrow\mathbb{R}_{\geq0}',
    'Beschreibung der funktionalen Kopplungsstärke zwischen Organisationen',
    'definition',
    'original'
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations
    WHERE equation_number='3.1169'
);



/* ============================================================
   5. Änderungsprotokoll
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
    '3.5.0',
    'Kapitel 3.5.0 angelegt und mathematische Erweiterung funktionaler Organisation begonnen.',
    NULL,
    '3.5.0 final'
);



/* ============================================================
   Abschlussprüfung
   ============================================================ */

SELECT
    'Kapitel 3.5.0 Repository Update erfolgreich'
    AS status;