/* ============================================================
   FRZK Repository Update
   Kapitel 3.6.2

   Abschnitt:
   Funktionale Kohärenz als Messgröße komplexer Systeme

   Neue Gleichungen:
   (3.1218) - (3.1222)

   Neue Quellen:
   [71] Wiener
   [72] Haken
   [73] Newman

   ============================================================ */


USE frzk_rkb;

SET NAMES utf8mb4;

START TRANSACTION;


/* ============================================================
   Letzte Revision bestimmen
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
    'RKB-REV-K3.6.2-V1',
    NOW(),
    'section',
    '3.6.2',
    '1.0',
    'Kapitel 3.6.2: Funktionale Kohärenz als Messgröße komplexer Systeme.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);


SET @revision_id = LAST_INSERT_ID();



/* ============================================================
   Abschnitt 3.6.2
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
    '3.6.2',
    'Funktionale Kohärenz als Messgröße komplexer Systeme',
    3,
    3.62,
    'completed',
    1,
    'Operationalisierung funktionaler Kohärenz innerhalb beobachtbarer komplexer Systeme.'
FROM dissertation_sections
WHERE section_code='3.6'
LIMIT 1;


SET @section_id = LAST_INSERT_ID();



/* ============================================================
   Quellen [71]-[73]
   ============================================================ */


INSERT INTO sources
(
    citation_number,
    source_key,
    source_type,
    title,
    year_original,
    publisher,
    place,
    created_at,
    updated_at
)
VALUES
(
    71,
    'wiener_cybernetics',
    'book',
    'Cybernetics: Or Control and Communication in the Animal and the Machine',
    1948,
    'MIT Press',
    'Cambridge',
    NOW(),
    NOW()
),
(
    72,
    'haken_synergetics',
    'book',
    'Synergetics: An Introduction',
    1983,
    'Springer',
    'Berlin',
    NOW(),
    NOW()
),
(
    73,
    'newman_networks_introduction',
    'book',
    'Networks: An Introduction',
    2010,
    'Oxford University Press',
    'Oxford',
    NOW(),
    NOW()
);



/* ============================================================
   Source Usage
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
        WHEN 71 THEN 'Rückkopplung und Stabilisierung dynamischer Systeme in der Kybernetik.'
        WHEN 72 THEN 'Selbstorganisation und Entstehung makroskopischer Ordnung aus Wechselwirkungen.'
        WHEN 73 THEN 'Netzwerkstrukturen und Analyse komplexer relationaler Systeme.'
    END,
    'theoretical_background',
    'Kapitel 3.6.2',
    1,
    1,
    NOW()
FROM sources
WHERE citation_number IN (71,72,73);



/* ============================================================
   Gleichungen 3.1218 - 3.1222
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
    '3.1218',
    @section_id,
    'Menge funktionaler Zustände',
    '\\mathcal{V}_F=\\{v_1,v_2,\\ldots,v_n\\}',
    '\\mathcal{V}_F=\\{v_1,v_2,\\ldots,v_n\\}',
    'Darstellung der Menge beobachtbarer funktionaler Zustände.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1219',
    @section_id,
    'Funktionale Relationsstruktur',
    '\\Gamma_F\\subseteq\\mathcal{V}_F\\times\\mathcal{V}_F',
    '\\Gamma_F\\subseteq\\mathcal{V}_F\\times\\mathcal{V}_F',
    'Relation zwischen funktional gekoppelten Zuständen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1220',
    @section_id,
    'Funktionale Organisationsstruktur',
    '\\mathcal{O}_F=(\\mathcal{V}_F,\\Gamma_F)',
    '\\mathcal{O}_F=(\\mathcal{V}_F,\\Gamma_F)',
    'Zusammenführung von Zustandsmenge und funktionalen Relationen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1221',
    @section_id,
    'Funktionale Kohärenz',
    'K_F=\\frac{\\Omega_{stabil}}{\\Omega_{gesamt}}',
    'K_F=\\frac{\\Omega_{stabil}}{\\Omega_{gesamt}}',
    'Verhältnis stabilisierender zu gesamten funktionalen Beziehungen.',
    'definition',
    'FRZK Eigenentwicklung',
    'checked',
    @revision_id
),
(
    '3.1222',
    @section_id,
    'Abhängigkeit funktionaler Kohärenz',
    'K_F=f(\\mathcal{V}_F,\\Gamma_F,T_F)',
    'K_F=f(\\mathcal{V}_F,\\Gamma_F,T_F)',
    'Funktionale Kohärenz als Funktion von Zuständen, Relationen und Transformationen.',
    'model',
    'FRZK Eigenentwicklung',
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
    '3.6.2',
    NOW()
);



COMMIT;


/* ============================================================
   Audit
   ============================================================ */

SELECT
    'Kapitel 3.6.2 Update erfolgreich'
    AS status,
    @revision_id AS revision_id,
    @section_id AS section_id;