/* ============================================================
   FRZK Repository Update
   Kapitel 3.6.3

   Abschnitt:
   Vergleich mit etablierten System- und Komplexitätsmodellen

   Neue Gleichungen:
   (3.1223) - (3.1225)

   Neue Quellen:
   bereits vorhanden:
   [68] Bertalanffy
   [71] Wiener
   [72] Haken
   [73] Newman

   ============================================================ */


USE frzk_rkb;

SET NAMES utf8mb4;

START TRANSACTION;


/* ============================================================
   Parent Revision
   ============================================================ */

SET @parent_revision_id =
(
    SELECT revision_id
    FROM repository_revisions
    ORDER BY revision_id DESC
    LIMIT 1
);



/* ============================================================
   Neue Revision
   ============================================================ */

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
VALUES
(
    'RKB-REV-K3.6.3-V1',
    NOW(),
    'section',
    '3.6.3',
    '1.0',
    'Kapitel 3.6.3: Vergleich des FRZK mit etablierten System- und Komplexitätsmodellen.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);


SET @revision_id = LAST_INSERT_ID();



/* ============================================================
   Abschnitt 3.6.3
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
    section_id,
    '3.6.3',
    'Vergleich mit etablierten System- und Komplexitätsmodellen',
    3,
    3.63,
    'completed',
    1,
    'Einordnung des FRZK gegenüber Systemtheorie, Kybernetik, dynamischen Systemen und Netzwerktheorie.'
FROM dissertation_sections
WHERE section_code='3.6'
LIMIT 1;


SET @section_id = LAST_INSERT_ID();



/* ============================================================
   Vorhandene Quellen verknüpfen
   ============================================================ */


INSERT INTO source_usage
(
    source_id,
    section_id,
    claim_summary,
    usage_type,
    exact_location,
    is_first_mention,
    citation_checked,
    created_at
)
SELECT
    source_id,
    @section_id,
    CASE citation_number

        WHEN 68 THEN
        'Allgemeine Systemtheorie: Systeme werden durch Beziehungen und Organisation ihrer Komponenten beschrieben.'

        WHEN 71 THEN
        'Kybernetik: Rückkopplung und Kommunikation als Grundlagen stabiler dynamischer Systeme.'

        WHEN 72 THEN
        'Synergetik: Entstehung makroskopischer Ordnung durch Wechselwirkungen.'

        WHEN 73 THEN
        'Netzwerktheorie: Analyse komplexer relationaler Strukturen.'

    END,

    'theoretical_comparison',

    'Kapitel 3.6.3',

    0,

    1,

    NOW()

FROM sources
WHERE citation_number IN (68,71,72,73);



/* ============================================================
   Gleichungen 3.1223 - 3.1225
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
    provenance,
    validation_status,
    created_revision_id
)
VALUES


(
    '3.1223',
    @section_id,
    'Kybernetischer Zustandsübergang',
    'x(t+1)=F(x(t),u(t))',
    'x(t+1)=F(x(t),u(t))',
    'Beschreibung eines Zustandsübergangs mit Eingangssignal in einem dynamischen Regelungssystem.',
    'model',
    'Literaturdarstellung Kybernetik',
    'checked',
    @revision_id
),


(
    '3.1224',
    @section_id,
    'Dynamisches System',
    'x_{t+1}=F(x_t)',
    'x_{t+1}=F(x_t)',
    'Abbildung eines Zustands auf den Folgezustand eines dynamischen Systems.',
    'model',
    'Literaturdarstellung dynamischer Systeme',
    'checked',
    @revision_id
),


(
    '3.1225',
    @section_id,
    'Graphendarstellung eines Netzwerks',
    'G=(V,E)',
    'G=(V,E)',
    'Darstellung eines Netzwerks durch Knotenmenge und Kantenmenge.',
    'definition',
    'Literaturdarstellung Netzwerktheorie',
    'checked',
    @revision_id
);



/* ============================================================
   Abschnittsänderung protokollieren
   ============================================================ */

INSERT INTO section_change_log
(
    section_id,
    revision_id,
    change_type,
    object_type,
    object_reference,
    changed_at
)
VALUES
(
    @section_id,
    @revision_id,
    'completed',
    'section',
    '3.6.3',
    NOW()
);



COMMIT;



/* ============================================================
   Audit
   ============================================================ */

SELECT
    'Kapitel 3.6.3 Update erfolgreich'
    AS status,
    @revision_id AS revision_id,
    @section_id AS section_id;