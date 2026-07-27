/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9.7 – Abschließende Synthese des Funktionalen
                    Raum-Zeit-Kohärenzsystems
   Grundlage: tatsächliches Schema aus frzk_rkb(3).sql
   MariaDB 10.4 kompatibel
   Idempotent und erneut importierbar
   ============================================================ */

START TRANSACTION;

INSERT INTO repository_revisions
(
    revision_code,revision_date,scope_type,scope_reference,
    version_label,summary,created_by,parent_revision_id
)
SELECT
    'RKB-2026-07-25-K3.9.7',
    NOW(),
    'section',
    '3.9.7',
    '1.0',
    'Repository-Update für Abschnitt 3.9.7: abschließende Synthese von Funktion, Relation, Raum, Zeit, Operatorik, Wirkung, Kohärenz, Dynamik, Axiomatik, Simulation und wissenschaftlicher Prüfung.',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.7'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.7'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id,section_code,title,chapter_no,
    section_order,status,is_original_contribution,notes
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
    SELECT 1 FROM dissertation_sections WHERE section_code='3.9'
);

SET @chapter_39_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.9'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id,section_code,title,chapter_no,
    section_order,status,is_original_contribution,notes
)
SELECT
    @chapter_39_id,
    '3.9.7',
    'Abschließende Synthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,
    3.9700,
    'completed',
    1,
    'Abschließende Zusammenführung der begrifflichen, mathematischen, axiomatischen, dynamischen, simulationsbezogenen und wissenschaftstheoretischen Grundlagen des FRZK.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.9.7'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.9.7'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.615',
    @section_id,
    'Gesamtstruktur des FRZK',
    '\\mathcal{F}_{\\mathrm{FRZK}}=\\bigl(F,R,Z,\\Omega,\\mathcal{W},\\kappa\\bigr)',
    '\\mathcal{F}_{\\mathrm{FRZK}}=\\bigl(F,R,Z,\\Omega,\\mathcal{W},\\kappa\\bigr)',
    'Gesamtkonstruktion aus funktionalen Einheiten, Relationen, Zuständen, Operatoren, Wirkungen und Kohärenz.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.615'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{F}_{\\mathrm{FRZK}}',
    'Gesamtstruktur des FRZK',
    'Gesamtkonstruktion aus funktionalen Einheiten, Relationen, Zuständen, Operatoren, Wirkungen und Kohärenz.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.615'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{F}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.616',
    @section_id,
    'Wechselseitige Abhängigkeit der Systemgrößen',
    'R\\leftrightarrow Z\\leftrightarrow\\Omega\\leftrightarrow\\mathcal{W}\\leftrightarrow\\kappa',
    'R\\leftrightarrow Z\\leftrightarrow\\Omega\\leftrightarrow\\mathcal{W}\\leftrightarrow\\kappa',
    'Wechselseitige Kopplung von Relation, Zustand, Operatoren, Wirkung und Kohärenz.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.616'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\leftrightarrow',
    'Wechselseitige Abhängigkeit der Systemgrößen',
    'Wechselseitige Kopplung von Relation, Zustand, Operatoren, Wirkung und Kohärenz.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.616'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\leftrightarrow'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.617',
    @section_id,
    'Funktionaler Raum',
    '\\mathcal{R}_{\\mathrm{F}}=\\bigl(F,R,d_{\\mathrm{F}}\\bigr)',
    '\\mathcal{R}_{\\mathrm{F}}=\\bigl(F,R,d_{\\mathrm{F}}\\bigr)',
    'Funktionaler Raum aus Einheiten, Relationen und funktionaler Distanz.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.617'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{R}_{\\mathrm{F}}',
    'Funktionaler Raum',
    'Funktionaler Raum aus Einheiten, Relationen und funktionaler Distanz.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.617'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{R}_{\\mathrm{F}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.618',
    @section_id,
    'Funktionale Zeit',
    '\\mathcal{T}_{\\mathrm{F}}=\\bigl(Z,\\prec,\\tau_{\\mathrm{F}}\\bigr)',
    '\\mathcal{T}_{\\mathrm{F}}=\\bigl(Z,\\prec,\\tau_{\\mathrm{F}}\\bigr)',
    'Funktionale Zeit aus Zuständen, gerichteter Ordnung und funktionaler Dauer.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.618'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{T}_{\\mathrm{F}}',
    'Funktionale Zeit',
    'Funktionale Zeit aus Zuständen, gerichteter Ordnung und funktionaler Dauer.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.618'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{T}_{\\mathrm{F}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.619',
    @section_id,
    'Rekonstruktion funktionalen Raums',
    '\\mathcal{R}_{\\mathrm{F}}=\\mathcal{R}(F,R)',
    '\\mathcal{R}_{\\mathrm{F}}=\\mathcal{R}(F,R)',
    'Funktionaler Raum als Ergebnis der relationalen Ordnung funktionaler Einheiten.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.619'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{R}',
    'Rekonstruktion funktionalen Raums',
    'Funktionaler Raum als Ergebnis der relationalen Ordnung funktionaler Einheiten.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.619'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{R}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.620',
    @section_id,
    'Rekonstruktion funktionaler Zeit',
    '\\mathcal{T}_{\\mathrm{F}}=\\mathcal{T}(Z,\\Omega)',
    '\\mathcal{T}_{\\mathrm{F}}=\\mathcal{T}(Z,\\Omega)',
    'Funktionale Zeit als Ergebnis operatorisch erzeugter Zustandsordnung.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.620'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{T}',
    'Rekonstruktion funktionaler Zeit',
    'Funktionale Zeit als Ergebnis operatorisch erzeugter Zustandsordnung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.620'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{T}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.621',
    @section_id,
    'Funktionale Einheit',
    'f_i=\\bigl(R_i,\\Omega_i,\\mathcal{W}_i\\bigr)',
    'f_i=\\bigl(R_i,\\Omega_i,\\mathcal{W}_i\\bigr)',
    'Funktionale Einheit aus Relationen, verfügbaren Operatoren und Wirkungen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.621'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'f_i',
    'Funktionale Einheit',
    'Funktionale Einheit aus Relationen, verfügbaren Operatoren und Wirkungen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.621'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='f_i'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.622',
    @section_id,
    'Grenze intrinsischer Gleichheit',
    'x_i=x_j\\;\\not\\Rightarrow\\;f_i=f_j',
    'x_i=x_j\\;\\not\\Rightarrow\\;f_i=f_j',
    'Gleiche Einzelmerkmale begründen keine identische Systemfunktion.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.622'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'x_i',
    'Grenze intrinsischer Gleichheit',
    'Gleiche Einzelmerkmale begründen keine identische Systemfunktion.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.622'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='x_i'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.623',
    @section_id,
    'Funktionale Äquivalenz',
    'f_i\\sim_{\\mathrm{F}}f_j',
    'f_i\\sim_{\\mathrm{F}}f_j',
    'Funktionale Äquivalenz zweier Einheiten unter relevanten Bedingungen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.623'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\sim_{\\mathrm{F}}',
    'Funktionale Äquivalenz',
    'Funktionale Äquivalenz zweier Einheiten unter relevanten Bedingungen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.623'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\sim_{\\mathrm{F}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.624',
    @section_id,
    'Menge funktionaler Einheiten',
    'F=\\{f_1,f_2,\\ldots,f_n\\}',
    'F=\\{f_1,f_2,\\ldots,f_n\\}',
    'Grundmenge funktionaler Einheiten.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.624'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'F',
    'Menge funktionaler Einheiten',
    'Grundmenge funktionaler Einheiten.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.624'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='F'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.625',
    @section_id,
    'Relationsmenge',
    'R\\subseteq F\\times F',
    'R\\subseteq F\\times F',
    'Relationen als Teilmenge des kartesischen Produkts funktionaler Einheiten.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.625'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'R',
    'Relationsmenge',
    'Relationen als Teilmenge des kartesischen Produkts funktionaler Einheiten.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.625'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='R'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.626',
    @section_id,
    'Relationsgewichtung',
    'w:R\\rightarrow\\mathbb{R}',
    'w:R\\rightarrow\\mathbb{R}',
    'Gewichtsfunktion für funktionale Relationen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.626'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'w',
    'Relationsgewichtung',
    'Gewichtsfunktion für funktionale Relationen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.626'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='w'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.627',
    @section_id,
    'Funktionale Distanz',
    'd_{\\mathrm{F}}\\bigl(f_i,f_j\\bigr)=\\min_{\\pi_{ij}}\\sum_{(u,v)\\in\\pi_{ij}}c(u,v)',
    'd_{\\mathrm{F}}\\bigl(f_i,f_j\\bigr)=\\min_{\\pi_{ij}}\\sum_{(u,v)\\in\\pi_{ij}}c(u,v)',
    'Minimale gewichtete Pfadkosten zwischen zwei funktionalen Einheiten.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.627'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'd_{\\mathrm{F}}',
    'Funktionale Distanz',
    'Minimale gewichtete Pfadkosten zwischen zwei funktionalen Einheiten.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.627'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='d_{\\mathrm{F}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.628',
    @section_id,
    'Erweiterter Systemzustand',
    'Z_t=\\bigl(\\mathbf{z}_t,A_t,\\Omega_t\\bigr)',
    'Z_t=\\bigl(\\mathbf{z}_t,A_t,\\Omega_t\\bigr)',
    'Systemzustand aus Zustandswerten, Relationsstruktur und Operatorenmenge.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.628'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z_t',
    'Erweiterter Systemzustand',
    'Systemzustand aus Zustandswerten, Relationsstruktur und Operatorenmenge.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.628'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Z_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.629',
    @section_id,
    'Zustandsentwicklung',
    'Z_{t+1}=\\mathcal{E}_t(Z_t)',
    'Z_{t+1}=\\mathcal{E}_t(Z_t)',
    'Entwicklung des Systemzustands durch einen zeitabhängigen Evolutionsoperator.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.629'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{E}_t',
    'Zustandsentwicklung',
    'Entwicklung des Systemzustands durch einen zeitabhängigen Evolutionsoperator.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.629'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{E}_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.630',
    @section_id,
    'Gerichtete Zeitordnung',
    'Z_i\\prec Z_j\\quad\\Longleftrightarrow\\quad\\exists\\mathcal{K}_{ij}:Z_j=\\mathcal{K}_{ij}(Z_i)',
    'Z_i\\prec Z_j\\quad\\Longleftrightarrow\\quad\\exists\\mathcal{K}_{ij}:Z_j=\\mathcal{K}_{ij}(Z_i)',
    'Zeitordnung durch operatorisch vermittelte Erreichbarkeit.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.630'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\prec',
    'Gerichtete Zeitordnung',
    'Zeitordnung durch operatorisch vermittelte Erreichbarkeit.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.630'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\prec'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.631',
    @section_id,
    'Funktionale Dauer',
    '\\tau_{\\mathrm{F}}\\bigl(Z_i,Z_j\\bigr)=\\min_{\\mathcal{K}_{ij}}C\\bigl(\\mathcal{K}_{ij}\\bigr)',
    '\\tau_{\\mathrm{F}}\\bigl(Z_i,Z_j\\bigr)=\\min_{\\mathcal{K}_{ij}}C\\bigl(\\mathcal{K}_{ij}\\bigr)',
    'Minimale Kosten einer zulässigen Operatorenkaskade.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.631'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\tau_{\\mathrm{F}}',
    'Funktionale Dauer',
    'Minimale Kosten einer zulässigen Operatorenkaskade.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.631'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\tau_{\\mathrm{F}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.632',
    @section_id,
    'Operator auf dem Zustandsraum',
    '\\mathcal{O}:\\mathcal{Z}\\rightarrow\\mathcal{Z}',
    '\\mathcal{O}:\\mathcal{Z}\\rightarrow\\mathcal{Z}',
    'Operatorische Abbildung des Zustandsraums in sich selbst.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.632'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{O}',
    'Operator auf dem Zustandsraum',
    'Operatorische Abbildung des Zustandsraums in sich selbst.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.632'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{O}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.633',
    @section_id,
    'Operatorenkaskade',
    '\\mathcal{K}=\\mathcal{O}_m\\circ\\mathcal{O}_{m-1}\\circ\\cdots\\circ\\mathcal{O}_1',
    '\\mathcal{K}=\\mathcal{O}_m\\circ\\mathcal{O}_{m-1}\\circ\\cdots\\circ\\mathcal{O}_1',
    'Komposition mehrerer Operatoren zu einer gerichteten Transformation.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.633'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{K}',
    'Operatorenkaskade',
    'Komposition mehrerer Operatoren zu einer gerichteten Transformation.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.633'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{K}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.634',
    @section_id,
    'Nichtkommutativität',
    '\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i',
    '\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i',
    'Operatorenreihenfolgen sind im Allgemeinen nicht austauschbar.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.634'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{O}_i',
    'Nichtkommutativität',
    'Operatorenreihenfolgen sind im Allgemeinen nicht austauschbar.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.634'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{O}_i'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.635',
    @section_id,
    'Dynamisierung der Relationsstruktur',
    'A_{t+1}=\\mathcal{O}^{(A)}\\bigl(A_t,Z_t\\bigr)',
    'A_{t+1}=\\mathcal{O}^{(A)}\\bigl(A_t,Z_t\\bigr)',
    'Veränderung der Relationsstruktur in Abhängigkeit vom Systemzustand.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.635'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'A_{t+1}',
    'Dynamisierung der Relationsstruktur',
    'Veränderung der Relationsstruktur in Abhängigkeit vom Systemzustand.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.635'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='A_{t+1}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.636',
    @section_id,
    'Dynamisierung der Operatorenstruktur',
    '\\Omega_{t+1}=\\mathcal{O}^{(\\Omega)}\\bigl(\\Omega_t,Z_{t+1}\\bigr)',
    '\\Omega_{t+1}=\\mathcal{O}^{(\\Omega)}\\bigl(\\Omega_t,Z_{t+1}\\bigr)',
    'Veränderung der verfügbaren Operatoren in Abhängigkeit vom Folgezustand.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.636'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Omega_{t+1}',
    'Dynamisierung der Operatorenstruktur',
    'Veränderung der verfügbaren Operatoren in Abhängigkeit vom Folgezustand.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.636'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Omega_{t+1}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.637',
    @section_id,
    'Reflexiver Metaoperator',
    '\\mathfrak{E}:\\bigl(Z_t,\\mathcal{E}_t\\bigr)\\mapsto\\bigl(Z_{t+1},\\mathcal{E}_{t+1}\\bigr)',
    '\\mathfrak{E}:\\bigl(Z_t,\\mathcal{E}_t\\bigr)\\mapsto\\bigl(Z_{t+1},\\mathcal{E}_{t+1}\\bigr)',
    'Gemeinsame Veränderung von Zustand und weiterer Entwicklungsregel.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.637'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathfrak{E}',
    'Reflexiver Metaoperator',
    'Gemeinsame Veränderung von Zustand und weiterer Entwicklungsregel.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.637'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathfrak{E}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.638',
    @section_id,
    'Kohärenzfunktion',
    '\\kappa_t=\\mathcal{K}\\bigl(\\mathbf{z}_t,A_t,\\Omega_t,\\mathcal{W}_t\\bigr)',
    '\\kappa_t=\\mathcal{K}\\bigl(\\mathbf{z}_t,A_t,\\Omega_t,\\mathcal{W}_t\\bigr)',
    'Kohärenz als Funktion von Zustand, Relation, Operatoren und Wirkung.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.638'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\kappa_t',
    'Kohärenzfunktion',
    'Kohärenz als Funktion von Zustand, Relation, Operatoren und Wirkung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.638'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\kappa_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.639',
    @section_id,
    'Kopplungsstärke und Kohärenz',
    '\\text{Kopplungsstärke}\\not\\equiv\\text{Kohärenz}',
    '\\text{Kopplungsstärke}\\not\\equiv\\text{Kohärenz}',
    'Starke Kopplung ist nicht mit funktionaler Kohärenz identisch.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.639'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\not\\equiv',
    'Kopplungsstärke und Kohärenz',
    'Starke Kopplung ist nicht mit funktionaler Kohärenz identisch.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.639'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\not\\equiv'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.640',
    @section_id,
    'Homogenität und Kohärenz',
    '\\text{Homogenität}\\not\\equiv\\text{Kohärenz}',
    '\\text{Homogenität}\\not\\equiv\\text{Kohärenz}',
    'Homogenität ist nicht mit funktionaler Kohärenz identisch.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.640'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\not\\equiv',
    'Homogenität und Kohärenz',
    'Homogenität ist nicht mit funktionaler Kohärenz identisch.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.640'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\not\\equiv'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.641',
    @section_id,
    'Kohärenz des Folgezustands',
    '\\kappa_{t+1}=\\mathcal{K}\\bigl(Z_{t+1}\\bigr)',
    '\\kappa_{t+1}=\\mathcal{K}\\bigl(Z_{t+1}\\bigr)',
    'Kohärenzbewertung des jeweils folgenden Systemzustands.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.641'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\kappa_{t+1}',
    'Kohärenz des Folgezustands',
    'Kohärenzbewertung des jeweils folgenden Systemzustands.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.641'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\kappa_{t+1}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.642',
    @section_id,
    'Kohärenzdifferenz',
    '\\Delta\\kappa_t=\\kappa_{t+1}-\\kappa_t',
    '\\Delta\\kappa_t=\\kappa_{t+1}-\\kappa_t',
    'Änderung der Kohärenz zwischen zwei aufeinanderfolgenden Zuständen.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.642'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Delta\\kappa_t',
    'Kohärenzdifferenz',
    'Änderung der Kohärenz zwischen zwei aufeinanderfolgenden Zuständen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.642'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Delta\\kappa_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.643',
    @section_id,
    'Kohärenzzunahme',
    '\\Delta\\kappa_t>0',
    '\\Delta\\kappa_t>0',
    'Positive Kohärenzdifferenz kennzeichnet eine Zunahme.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.643'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Delta\\kappa_t',
    'Kohärenzzunahme',
    'Positive Kohärenzdifferenz kennzeichnet eine Zunahme.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.643'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Delta\\kappa_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.644',
    @section_id,
    'Kohärenzabnahme',
    '\\Delta\\kappa_t<0',
    '\\Delta\\kappa_t<0',
    'Negative Kohärenzdifferenz kennzeichnet eine Abnahme.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.644'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Delta\\kappa_t',
    'Kohärenzabnahme',
    'Negative Kohärenzdifferenz kennzeichnet eine Abnahme.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.644'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Delta\\kappa_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.645',
    @section_id,
    'Fixpunktbedingung',
    '\\mathcal{E}(Z^{*})=Z^{*}',
    '\\mathcal{E}(Z^{*})=Z^{*}',
    'Fixpunkt eines Evolutionsoperators.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.645'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z^{*}',
    'Fixpunktbedingung',
    'Fixpunkt eines Evolutionsoperators.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.645'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Z^{*}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.646',
    @section_id,
    'Periodische Trajektorie',
    '\\mathcal{E}^{p}(Z)=Z',
    '\\mathcal{E}^{p}(Z)=Z',
    'Zustand einer periodischen Trajektorie mit Periode p.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.646'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'p',
    'Periodische Trajektorie',
    'Zustand einer periodischen Trajektorie mit Periode p.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.646'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='p'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.647',
    @section_id,
    'Attraktorbedingung',
    '\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{A}\\bigr)=0',
    '\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{A}\\bigr)=0',
    'Asymptotische Annäherung einer Trajektorie an einen Attraktor.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.647'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{A}',
    'Attraktorbedingung',
    'Asymptotische Annäherung einer Trajektorie an einen Attraktor.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.647'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{A}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.648',
    @section_id,
    'Einzugsgebiet eines Attraktors',
    '\\mathcal{B}(\\mathcal{A})=\\left\\{Z_0\\in\\mathcal{Z}\\;\\middle|\\;\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{A}\\bigr)=0\\right\\}',
    '\\mathcal{B}(\\mathcal{A})=\\left\\{Z_0\\in\\mathcal{Z}\\;\\middle|\\;\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{A}\\bigr)=0\\right\\}',
    'Menge aller Anfangszustände, deren Trajektorien zum Attraktor konvergieren.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.648'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{B}(\\mathcal{A})',
    'Einzugsgebiet eines Attraktors',
    'Menge aller Anfangszustände, deren Trajektorien zum Attraktor konvergieren.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.648'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{B}(\\mathcal{A})'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.649',
    @section_id,
    'Zustandsdrift',
    '\\delta_t=d\\bigl(Z_t,Z_{\\mathrm{ref}}\\bigr)',
    '\\delta_t=d\\bigl(Z_t,Z_{\\mathrm{ref}}\\bigr)',
    'Abstand eines Zustands von einem Referenzzustand.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.649'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\delta_t',
    'Zustandsdrift',
    'Abstand eines Zustands von einem Referenzzustand.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.649'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\delta_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.650',
    @section_id,
    'Emergente globale Operatorenwirkung',
    '\\mathcal{O}_{\\mathrm{global}}=\\Phi\\bigl(\\mathcal{O}^{\\mathrm{lok}}_1,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\bigr)',
    '\\mathcal{O}_{\\mathrm{global}}=\\Phi\\bigl(\\mathcal{O}^{\\mathrm{lok}}_1,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\bigr)',
    'Globale Wirkung als Ergebnis gekoppelter lokaler Operatoren.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.650'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{O}_{\\mathrm{global}}',
    'Emergente globale Operatorenwirkung',
    'Globale Wirkung als Ergebnis gekoppelter lokaler Operatoren.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.650'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{O}_{\\mathrm{global}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.651',
    @section_id,
    'Nichtidentität globaler und lokaler Operatoren',
    '\\mathcal{O}_{\\mathrm{global}}\\neq\\mathcal{O}^{\\mathrm{lok}}_i',
    '\\mathcal{O}_{\\mathrm{global}}\\neq\\mathcal{O}^{\\mathrm{lok}}_i',
    'Die globale Ordnung ist nicht mit einer einzelnen lokalen Wirkung identisch.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.651'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{O}^{\\mathrm{lok}}_i',
    'Nichtidentität globaler und lokaler Operatoren',
    'Die globale Ordnung ist nicht mit einer einzelnen lokalen Wirkung identisch.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.651'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{O}^{\\mathrm{lok}}_i'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.652',
    @section_id,
    'Selbstorganisierte Strukturentwicklung',
    'A_{t+1}=\\mathcal{G}\\bigl(A_t,\\mathbf{z}_t,\\Omega_t\\bigr)',
    'A_{t+1}=\\mathcal{G}\\bigl(A_t,\\mathbf{z}_t,\\Omega_t\\bigr)',
    'Entstehung globaler Struktur aus interner Dynamik.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.652'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{G}',
    'Selbstorganisierte Strukturentwicklung',
    'Entstehung globaler Struktur aus interner Dynamik.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.652'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{G}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.653',
    @section_id,
    'Bifurkationsbedingung',
    '\\mathcal{A}(\\mu<\\mu_c)\\neq\\mathcal{A}(\\mu>\\mu_c)',
    '\\mathcal{A}(\\mu<\\mu_c)\\neq\\mathcal{A}(\\mu>\\mu_c)',
    'Qualitative Änderung der Attraktorstruktur an einem kritischen Parameterwert.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.653'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mu_c',
    'Bifurkationsbedingung',
    'Qualitative Änderung der Attraktorstruktur an einem kritischen Parameterwert.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.653'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mu_c'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.654',
    @section_id,
    'Frühwarnvektor',
    '\\mathbf{E}_t=\\begin{pmatrix}\\delta_t\\\\\\sigma_t^2\\\\1-\\kappa_t\\\\\\rho_t\\\\\\chi_t\\end{pmatrix}',
    '\\mathbf{E}_t=\\begin{pmatrix}\\delta_t\\\\\\sigma_t^2\\\\1-\\kappa_t\\\\\\rho_t\\\\\\chi_t\\end{pmatrix}',
    'Vektor aus Drift, Varianz, Kohärenzverlust, Autokorrelation und Wechselhäufigkeit.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.654'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathbf{E}_t',
    'Frühwarnvektor',
    'Vektor aus Drift, Varianz, Kohärenzverlust, Autokorrelation und Wechselhäufigkeit.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.654'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathbf{E}_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.655',
    @section_id,
    'Kritischer Frühwarnbereich',
    '\\|\\mathbf{E}_t\\|\\geq\\eta_{\\mathrm{krit}}',
    '\\|\\mathbf{E}_t\\|\\geq\\eta_{\\mathrm{krit}}',
    'Schwellenwertbedingung für erhöhte Instabilitätswahrscheinlichkeit.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.655'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\eta_{\\mathrm{krit}}',
    'Kritischer Frühwarnbereich',
    'Schwellenwertbedingung für erhöhte Instabilitätswahrscheinlichkeit.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.655'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\eta_{\\mathrm{krit}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.656',
    @section_id,
    'Klassische Multiplikation mit null',
    '0\\mathbf{v}=\\mathbf{0}',
    '0\\mathbf{v}=\\mathbf{0}',
    'Klassische Skalarmultiplikation eines Vektors mit null.',
    'axiom',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.656'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathbf{0}',
    'Klassische Multiplikation mit null',
    'Klassische Skalarmultiplikation eines Vektors mit null.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.656'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathbf{0}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.657',
    @section_id,
    'Erweiterter gerichteter funktionaler Zustand',
    '\\widetilde{\\mathbf{v}}=\\bigl(r,\\widehat{\\mathbf{v}},a\\bigr)',
    '\\widetilde{\\mathbf{v}}=\\bigl(r,\\widehat{\\mathbf{v}},a\\bigr)',
    'Gerichteter funktionaler Zustand aus Betrag, Richtungsinformation und Aktivitätsstatus.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.657'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\widetilde{\\mathbf{v}}',
    'Erweiterter gerichteter funktionaler Zustand',
    'Gerichteter funktionaler Zustand aus Betrag, Richtungsinformation und Aktivitätsstatus.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.657'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\widetilde{\\mathbf{v}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.658',
    @section_id,
    'Funktionale Multiplikation mit null',
    '0\\odot\\widetilde{\\mathbf{v}}=\\bigl(0,\\widehat{\\mathbf{v}},0\\bigr)',
    '0\\odot\\widetilde{\\mathbf{v}}=\\bigl(0,\\widehat{\\mathbf{v}},0\\bigr)',
    'Nullsetzung der aktuellen Wirkung bei Erhalt der Richtungsinformation.',
    'axiom',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.658'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\odot',
    'Funktionale Multiplikation mit null',
    'Nullsetzung der aktuellen Wirkung bei Erhalt der Richtungsinformation.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.658'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\odot'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.659',
    @section_id,
    'Expliziter Nullungsoperator',
    '\\mathcal{N}\\bigl(0,\\widehat{\\mathbf{v}},0\\bigr)=\\bigl(0,\\varnothing,0\\bigr)',
    '\\mathcal{N}\\bigl(0,\\widehat{\\mathbf{v}},0\\bigr)=\\bigl(0,\\varnothing,0\\bigr)',
    'Vollständige Löschung der gespeicherten Richtungsinformation.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.659'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{N}',
    'Expliziter Nullungsoperator',
    'Vollständige Löschung der gespeicherten Richtungsinformation.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.659'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{N}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.660',
    @section_id,
    'Axiomatische Basis',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\{A_1,A_2,\\ldots,A_n\\}',
    '\\mathcal{A}_{\\mathrm{FRZK}}=\\{A_1,A_2,\\ldots,A_n\\}',
    'Menge der Grundaxiome des FRZK.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.660'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{A}_{\\mathrm{FRZK}}',
    'Axiomatische Basis',
    'Menge der Grundaxiome des FRZK.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.660'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{A}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.661',
    @section_id,
    'Deduktiver Abschluss',
    '\\mathcal{T}_{\\mathrm{FRZK}}=\\operatorname{Cn}\\bigl(\\mathcal{A}_{\\mathrm{FRZK}}\\cup\\mathcal{D}_{\\mathrm{FRZK}}\\bigr)',
    '\\mathcal{T}_{\\mathrm{FRZK}}=\\operatorname{Cn}\\bigl(\\mathcal{A}_{\\mathrm{FRZK}}\\cup\\mathcal{D}_{\\mathrm{FRZK}}\\bigr)',
    'Theorie als deduktiver Abschluss von Axiomen und Definitionen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.661'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\operatorname{Cn}',
    'Deduktiver Abschluss',
    'Theorie als deduktiver Abschluss von Axiomen und Definitionen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.661'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\operatorname{Cn}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.662',
    @section_id,
    'Konsistente axiomatische Erweiterung',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\cup\\mathcal{A}^{+}\\not\\vdash\\bot',
    '\\mathcal{A}_{\\mathrm{FRZK}}\\cup\\mathcal{A}^{+}\\not\\vdash\\bot',
    'Zulässige Erweiterung erzeugt keinen Widerspruch.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.662'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\bot',
    'Konsistente axiomatische Erweiterung',
    'Zulässige Erweiterung erzeugt keinen Widerspruch.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.662'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\bot'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.663',
    @section_id,
    'Vollständiger rekonstruierter Systemzustand',
    'Z_t=\\bigl(\\mathbf{z}_t,A_t,\\Omega_t,\\kappa_t\\bigr)',
    'Z_t=\\bigl(\\mathbf{z}_t,A_t,\\Omega_t,\\kappa_t\\bigr)',
    'Systemzustand einschließlich Kohärenzgröße.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.663'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z_t',
    'Vollständiger rekonstruierter Systemzustand',
    'Systemzustand einschließlich Kohärenzgröße.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.663'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Z_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.664',
    @section_id,
    'Parametrisierte Entwicklung',
    'Z_{t+1}=\\mathcal{E}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)',
    'Z_{t+1}=\\mathcal{E}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)',
    'Zustandsentwicklung unter einer festgelegten Parametrisierung.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.664'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\boldsymbol{\\theta}',
    'Parametrisierte Entwicklung',
    'Zustandsentwicklung unter einer festgelegten Parametrisierung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.664'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\boldsymbol{\\theta}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.665',
    @section_id,
    'Simulationstrajektorie',
    '\\Gamma_T=\\{Z_0,Z_1,\\ldots,Z_T\\}',
    '\\Gamma_T=\\{Z_0,Z_1,\\ldots,Z_T\\}',
    'Endliche Folge simulierter Systemzustände.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.665'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Gamma_T',
    'Simulationstrajektorie',
    'Endliche Folge simulierter Systemzustände.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.665'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Gamma_T'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.666',
    @section_id,
    'Wissenschaftliche Entwicklungskette',
    '\\text{Axiom}\\rightarrow\\text{Definition}\\rightarrow\\text{Modell}\\rightarrow\\text{Implementierung}\\rightarrow\\text{Simulation}\\rightarrow\\text{Auswertung}',
    '\\text{Axiom}\\rightarrow\\text{Definition}\\rightarrow\\text{Modell}\\rightarrow\\text{Implementierung}\\rightarrow\\text{Simulation}\\rightarrow\\text{Auswertung}',
    'Abfolge von theoretischer Setzung bis wissenschaftlicher Auswertung.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.666'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\text{Axiom}',
    'Wissenschaftliche Entwicklungskette',
    'Abfolge von theoretischer Setzung bis wissenschaftlicher Auswertung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.666'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\text{Axiom}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.667',
    @section_id,
    'Implementierungsabweichung',
    '\\varepsilon_t=d\\bigl(Z_t^{\\mathrm{math}},Z_t^{\\mathrm{num}}\\bigr)',
    '\\varepsilon_t=d\\bigl(Z_t^{\\mathrm{math}},Z_t^{\\mathrm{num}}\\bigr)',
    'Distanz zwischen mathematisch erwartetem und numerisch erzeugtem Zustand.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.667'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\varepsilon_t',
    'Implementierungsabweichung',
    'Distanz zwischen mathematisch erwartetem und numerisch erzeugtem Zustand.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.667'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\varepsilon_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.668',
    @section_id,
    'Numerische Toleranzbedingung',
    '\\varepsilon_t\\leq\\varepsilon_{\\max}',
    '\\varepsilon_t\\leq\\varepsilon_{\\max}',
    'Zulässige obere Grenze der Implementierungsabweichung.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.668'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\varepsilon_{\\max}',
    'Numerische Toleranzbedingung',
    'Zulässige obere Grenze der Implementierungsabweichung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.668'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\varepsilon_{\\max}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.669',
    @section_id,
    'Testmenge des Parameterraums',
    '\\Theta_{\\mathrm{test}}=\\{\\boldsymbol{\\theta}^{(1)},\\ldots,\\boldsymbol{\\theta}^{(N)}\\}',
    '\\Theta_{\\mathrm{test}}=\\{\\boldsymbol{\\theta}^{(1)},\\ldots,\\boldsymbol{\\theta}^{(N)}\\}',
    'Endliche Menge untersuchter Parametrisierungen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.669'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Theta_{\\mathrm{test}}',
    'Testmenge des Parameterraums',
    'Endliche Menge untersuchter Parametrisierungen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.669'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Theta_{\\mathrm{test}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.670',
    @section_id,
    'Trajektorie einer Parametrisierung',
    '\\Gamma_T^{(n)}=\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}^{(n)}\\bigr)',
    '\\Gamma_T^{(n)}=\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}^{(n)}\\bigr)',
    'Simulationstrajektorie für die n-te Parametrisierung.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.670'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Gamma_T^{(n)}',
    'Trajektorie einer Parametrisierung',
    'Simulationstrajektorie für die n-te Parametrisierung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.670'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Gamma_T^{(n)}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.671',
    @section_id,
    'Verifikationsbeziehung',
    '\\widehat{\\mathcal{E}}\\approx\\mathcal{E}',
    '\\widehat{\\mathcal{E}}\\approx\\mathcal{E}',
    'Vergleich der implementierten mit der mathematisch definierten Entwicklung.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.671'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\widehat{\\mathcal{E}}',
    'Verifikationsbeziehung',
    'Vergleich der implementierten mit der mathematisch definierten Entwicklung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.671'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\widehat{\\mathcal{E}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.672',
    @section_id,
    'Validierungsbeziehung',
    '\\mathcal{M}_{\\mathrm{FRZK}}\\approx\\mathcal{W}',
    '\\mathcal{M}_{\\mathrm{FRZK}}\\approx\\mathcal{W}',
    'Vergleich des Modells mit dem betrachteten Wirklichkeitsbereich.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.672'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{M}_{\\mathrm{FRZK}}',
    'Validierungsbeziehung',
    'Vergleich des Modells mit dem betrachteten Wirklichkeitsbereich.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.672'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{M}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.673',
    @section_id,
    'Empirische Beobachtungsreihe',
    'Y=\\{Y_0,Y_1,\\ldots,Y_T\\}',
    'Y=\\{Y_0,Y_1,\\ldots,Y_T\\}',
    'Zeitlich geordnete empirische Beobachtungen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.673'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Y',
    'Empirische Beobachtungsreihe',
    'Zeitlich geordnete empirische Beobachtungen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.673'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Y'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.674',
    @section_id,
    'Simulierte Beobachtungsreihe',
    '\\widehat{Y}=\\{\\widehat{Y}_0,\\widehat{Y}_1,\\ldots,\\widehat{Y}_T\\}',
    '\\widehat{Y}=\\{\\widehat{Y}_0,\\widehat{Y}_1,\\ldots,\\widehat{Y}_T\\}',
    'Aus der Simulation abgeleitete Vergleichsreihe.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.674'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\widehat{Y}',
    'Simulierte Beobachtungsreihe',
    'Aus der Simulation abgeleitete Vergleichsreihe.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.674'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\widehat{Y}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.675',
    @section_id,
    'Mittlere empirische Abweichung',
    'E_T=\\frac{1}{T+1}\\sum_{t=0}^{T}d\\bigl(Y_t,\\widehat{Y}_t\\bigr)',
    'E_T=\\frac{1}{T+1}\\sum_{t=0}^{T}d\\bigl(Y_t,\\widehat{Y}_t\\bigr)',
    'Mittlere Distanz zwischen empirischen und simulierten Werten.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.675'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'E_T',
    'Mittlere empirische Abweichung',
    'Mittlere Distanz zwischen empirischen und simulierten Werten.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.675'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='E_T'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.676',
    @section_id,
    'Wissenschaftliche Position des FRZK',
    '\\mathcal{P}_{\\mathrm{FRZK}}=\\mathcal{P}_{\\mathrm{math}}\\cap\\mathcal{P}_{\\mathrm{sys}}\\cap\\mathcal{P}_{\\mathrm{phys}}\\cap\\mathcal{P}_{\\mathrm{epist}}',
    '\\mathcal{P}_{\\mathrm{FRZK}}=\\mathcal{P}_{\\mathrm{math}}\\cap\\mathcal{P}_{\\mathrm{sys}}\\cap\\mathcal{P}_{\\mathrm{phys}}\\cap\\mathcal{P}_{\\mathrm{epist}}',
    'Schnittmenge mathematischer, systemtheoretischer, physikalischer und erkenntnistheoretischer Bezugsebenen.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.676'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{P}_{\\mathrm{FRZK}}',
    'Wissenschaftliche Position des FRZK',
    'Schnittmenge mathematischer, systemtheoretischer, physikalischer und erkenntnistheoretischer Bezugsebenen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.676'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{P}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.677',
    @section_id,
    'Trennung der Geltungsbereiche',
    'G_{\\mathrm{formal}}\\neq G_{\\mathrm{sim}}\\neq G_{\\mathrm{emp}}',
    'G_{\\mathrm{formal}}\\neq G_{\\mathrm{sim}}\\neq G_{\\mathrm{emp}}',
    'Formale, simulationsbezogene und empirische Geltung sind nicht identisch.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.677'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'G_{\\mathrm{formal}}',
    'Trennung der Geltungsbereiche',
    'Formale, simulationsbezogene und empirische Geltung sind nicht identisch.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.677'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='G_{\\mathrm{formal}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.678',
    @section_id,
    'Eigenbeitrag des FRZK',
    '\\mathcal{C}_{\\mathrm{FRZK}}=\\mathcal{F}\\oplus\\mathcal{R}\\oplus\\mathcal{O}\\oplus\\mathcal{K}\\oplus\\mathcal{S}',
    '\\mathcal{C}_{\\mathrm{FRZK}}=\\mathcal{F}\\oplus\\mathcal{R}\\oplus\\mathcal{O}\\oplus\\mathcal{K}\\oplus\\mathcal{S}',
    'Verbindung funktionaler, relationaler, operatorischer, kohärenzbezogener und simulationsbezogener Ebenen.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.678'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{C}_{\\mathrm{FRZK}}',
    'Eigenbeitrag des FRZK',
    'Verbindung funktionaler, relationaler, operatorischer, kohärenzbezogener und simulationsbezogener Ebenen.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.678'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{C}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.679',
    @section_id,
    'Funktionale Beschreibung',
    '\\mathcal{F}=\\text{funktionale Beschreibung}',
    '\\mathcal{F}=\\text{funktionale Beschreibung}',
    'Bezeichnung der funktionalen Beschreibungsebene.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.679'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{F}',
    'Funktionale Beschreibung',
    'Bezeichnung der funktionalen Beschreibungsebene.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.679'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{F}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.680',
    @section_id,
    'Relationale Raumrekonstruktion',
    '\\mathcal{R}=\\text{relationale Raumrekonstruktion}',
    '\\mathcal{R}=\\text{relationale Raumrekonstruktion}',
    'Bezeichnung der relationalen Raumebene.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.680'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{R}',
    'Relationale Raumrekonstruktion',
    'Bezeichnung der relationalen Raumebene.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.680'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{R}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.681',
    @section_id,
    'Operatorische Zeit- und Zustandsentwicklung',
    '\\mathcal{O}=\\text{operatorische Zeit- und Zustandsentwicklung}',
    '\\mathcal{O}=\\text{operatorische Zeit- und Zustandsentwicklung}',
    'Bezeichnung der operatorischen Entwicklungsebene.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.681'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{O}',
    'Operatorische Zeit- und Zustandsentwicklung',
    'Bezeichnung der operatorischen Entwicklungsebene.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.681'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{O}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.682',
    @section_id,
    'Kohärenz funktionaler Organisation',
    '\\mathcal{K}=\\text{Kohärenz funktionaler Organisation}',
    '\\mathcal{K}=\\text{Kohärenz funktionaler Organisation}',
    'Bezeichnung der kohärenzbezogenen Ebene.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.682'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{K}',
    'Kohärenz funktionaler Organisation',
    'Bezeichnung der kohärenzbezogenen Ebene.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.682'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{K}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.683',
    @section_id,
    'Simulation und wissenschaftliche Prüfung',
    '\\mathcal{S}=\\text{Simulation und wissenschaftliche Prüfung}',
    '\\mathcal{S}=\\text{Simulation und wissenschaftliche Prüfung}',
    'Bezeichnung der simulations- und prüfbezogenen Ebene.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.683'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{S}',
    'Simulation und wissenschaftliche Prüfung',
    'Bezeichnung der simulations- und prüfbezogenen Ebene.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.683'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{S}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.684',
    @section_id,
    'Gültigkeitsbereich eines Ergebnisses',
    '\\mathcal{G}(R)=\\mathcal{A}\\times\\mathcal{M}\\times\\Theta\\times\\mathcal{Z}_0\\times[0,T]',
    '\\mathcal{G}(R)=\\mathcal{A}\\times\\mathcal{M}\\times\\Theta\\times\\mathcal{Z}_0\\times[0,T]',
    'Gültigkeitsbereich aus Axiomen, Modell, Parameterraum, Anfangszuständen und Zeithorizont.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.684'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{G}(R)',
    'Gültigkeitsbereich eines Ergebnisses',
    'Gültigkeitsbereich aus Axiomen, Modell, Parameterraum, Anfangszuständen und Zeithorizont.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.684'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{G}(R)'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.685',
    @section_id,
    'Physikalische Interpretationsabbildung',
    '\\Pi:\\mathcal{Z}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{Z}_{\\mathrm{phys}}',
    '\\Pi:\\mathcal{Z}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{Z}_{\\mathrm{phys}}',
    'Abbildung funktionaler Zustände auf physikalisch interpretierbare Zustände.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.685'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Pi',
    'Physikalische Interpretationsabbildung',
    'Abbildung funktionaler Zustände auf physikalisch interpretierbare Zustände.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.685'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Pi'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.686',
    @section_id,
    'Richtungen der Weiterentwicklung',
    '\\mathcal{W}_{\\mathrm{FRZK}}=\\mathcal{W}_{\\mathrm{formal}}\\cup\\mathcal{W}_{\\mathrm{sim}}\\cup\\mathcal{W}_{\\mathrm{emp}}',
    '\\mathcal{W}_{\\mathrm{FRZK}}=\\mathcal{W}_{\\mathrm{formal}}\\cup\\mathcal{W}_{\\mathrm{sim}}\\cup\\mathcal{W}_{\\mathrm{emp}}',
    'Formale, simulationsbezogene und empirische Weiterentwicklung.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.686'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{W}_{\\mathrm{FRZK}}',
    'Richtungen der Weiterentwicklung',
    'Formale, simulationsbezogene und empirische Weiterentwicklung.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.686'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{W}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.687',
    @section_id,
    'Zyklischer Forschungsprozess',
    '\\text{Theorie}\\rightarrow\\text{Modell}\\rightarrow\\text{Simulation}\\rightarrow\\text{Empirie}\\rightarrow\\text{Kritik}\\rightarrow\\text{Theorie}',
    '\\text{Theorie}\\rightarrow\\text{Modell}\\rightarrow\\text{Simulation}\\rightarrow\\text{Empirie}\\rightarrow\\text{Kritik}\\rightarrow\\text{Theorie}',
    'Rückgekoppelter wissenschaftlicher Entwicklungsprozess.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.687'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\text{Theorie}',
    'Zyklischer Forschungsprozess',
    'Rückgekoppelter wissenschaftlicher Entwicklungsprozess.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.687'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\text{Theorie}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.688',
    @section_id,
    'Theoretischer Kern des FRZK',
    '\\boxed{\\begin{aligned}\\text{Raum}&=\\text{Ordnung funktionaler Relationen},\\\\\\text{Zeit}&=\\text{Ordnung gerichteter Transformationen},\\\\\\text{Kohärenz}&=\\text{Tragfähigkeit funktionaler Organisation}.\\end{aligned}}',
    '\\boxed{\\begin{aligned}\\text{Raum}&=\\text{Ordnung funktionaler Relationen},\\\\\\text{Zeit}&=\\text{Ordnung gerichteter Transformationen},\\\\\\text{Kohärenz}&=\\text{Tragfähigkeit funktionaler Organisation}.\\end{aligned}}',
    'Verdichtung der Grundbegriffe Raum, Zeit und Kohärenz.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.688'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\text{Raum}',
    'Theoretischer Kern des FRZK',
    'Verdichtung der Grundbegriffe Raum, Zeit und Kohärenz.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.688'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\text{Raum}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.689',
    @section_id,
    'Vollständige Grundstruktur des FRZK',
    '\\boxed{\\mathrm{FRZK}=\\bigl(\\mathrm{Funktion},\\mathrm{Relation},\\mathrm{Transformation},\\mathrm{Wirkung},\\mathrm{Kohärenz}\\bigr)}',
    '\\boxed{\\mathrm{FRZK}=\\bigl(\\mathrm{Funktion},\\mathrm{Relation},\\mathrm{Transformation},\\mathrm{Wirkung},\\mathrm{Kohärenz}\\bigr)}',
    'Abschließende begriffliche Grundstruktur des FRZK.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.689'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathrm{FRZK}',
    'Vollständige Grundstruktur des FRZK',
    'Abschließende begriffliche Grundstruktur des FRZK.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.689'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathrm{FRZK}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.690',
    @section_id,
    'Begriffliche Entwicklungsfolge',
    '\\boxed{\\text{Funktion}\\rightarrow\\text{Relation}\\rightarrow\\text{Raum}\\rightarrow\\text{Transformation}\\rightarrow\\text{Zeit}\\rightarrow\\text{Wirkung}\\rightarrow\\text{Kohärenz}}',
    '\\boxed{\\text{Funktion}\\rightarrow\\text{Relation}\\rightarrow\\text{Raum}\\rightarrow\\text{Transformation}\\rightarrow\\text{Zeit}\\rightarrow\\text{Wirkung}\\rightarrow\\text{Kohärenz}}',
    'Begriffliche Rekonstruktionsfolge des FRZK.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.690'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\text{Funktion}',
    'Begriffliche Entwicklungsfolge',
    'Begriffliche Rekonstruktionsfolge des FRZK.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.690'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\text{Funktion}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.691',
    @section_id,
    'Dynamische Gesamtdarstellung',
    '\\boxed{\\bigl(F_t,R_t,Z_t,\\Omega_t,\\mathcal{W}_t,\\kappa_t\\bigr)\\xrightarrow{\\mathfrak{E}}\\bigl(F_{t+1},R_{t+1},Z_{t+1},\\Omega_{t+1},\\mathcal{W}_{t+1},\\kappa_{t+1}\\bigr)}',
    '\\boxed{\\bigl(F_t,R_t,Z_t,\\Omega_t,\\mathcal{W}_t,\\kappa_t\\bigr)\\xrightarrow{\\mathfrak{E}}\\bigl(F_{t+1},R_{t+1},Z_{t+1},\\Omega_{t+1},\\mathcal{W}_{t+1},\\kappa_{t+1}\\bigr)}',
    'Abschließende dynamische Darstellung des Funktionalen Raum-Zeit-Kohärenzsystems.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.691'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathfrak{E}',
    'Dynamische Gesamtdarstellung',
    'Abschließende dynamische Darstellung des Funktionalen Raum-Zeit-Kohärenzsystems.',
    NULL,
    'Abschnitt 3.9.7',
    1
FROM equations e
WHERE e.equation_number='3.691'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathfrak{E}'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Wissenschaftstheoretische Grundlagen der Modellbildung und Geltungsabgrenzung.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [1].',
    @revision_id
FROM sources s
WHERE s.citation_number=1
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Erkenntnistheoretische Grundlagen wissenschaftlicher Begriffsbildung.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [2].',
    @revision_id
FROM sources s
WHERE s.citation_number=2
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Historische und philosophische Grundlagen relationaler Raum- und Zeitkonzepte.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [3].',
    @revision_id
FROM sources s
WHERE s.citation_number=3
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Physikalische Grundlagen moderner Raum-Zeit-Theorien.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [4].',
    @revision_id
FROM sources s
WHERE s.citation_number=4
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Relationale Auffassung physikalischer Ordnung.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [5].',
    @revision_id
FROM sources s
WHERE s.citation_number=5
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Selbstorganisation und makroskopische Ordnung aus lokalen Wechselwirkungen.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [12].',
    @revision_id
FROM sources s
WHERE s.citation_number=12
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Komplexe adaptive Systeme und emergente Dynamik.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [14].',
    @revision_id
FROM sources s
WHERE s.citation_number=14
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Netzwerkstruktur und gekoppelte Zustandsentwicklung.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [15].',
    @revision_id
FROM sources s
WHERE s.citation_number=15
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'method',
    'Dynamische Systeme, Stabilität, Attraktoren und Bifurkationen.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [37].',
    @revision_id
FROM sources s
WHERE s.citation_number=37
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'method',
    'Qualitative Analyse dynamischer Systeme.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [40].',
    @revision_id
FROM sources s
WHERE s.citation_number=40
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Trajektorien, Attraktoren und nichtlineare Entwicklung.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [43].',
    @revision_id
FROM sources s
WHERE s.citation_number=43
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Sensitivität gegenüber Anfangsbedingungen.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [44].',
    @revision_id
FROM sources s
WHERE s.citation_number=44
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Netzwerkdynamik und adaptive Relationsstrukturen.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [48].',
    @revision_id
FROM sources s
WHERE s.citation_number=48
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'method',
    'Metrische und graphentheoretische Grundlagen funktionaler Distanz.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [49].',
    @revision_id
FROM sources s
WHERE s.citation_number=49
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Selbstorganisation aus lokalen Interaktionen.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [51].',
    @revision_id
FROM sources s
WHERE s.citation_number=51
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Emergenz und Komplexität als systemische Organisationsformen.',
    'Abschnitt 3.9.7',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [52].',
    @revision_id
FROM sources s
WHERE s.citation_number=52
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.7'
  );

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,@section_id,'created','section','3.9.7',
    'Abschnitt 3.9.7 als abschließende Synthese des Funktionalen Raum-Zeit-Kohärenzsystems registriert.',
    NULL,'completed',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.9.7'
);

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,@section_id,'equation_added','equations','3.615-3.691',
    '77 Gleichungen der abschließenden FRZK-Synthese registriert.',
    NULL,'77',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='3.615-3.691'
);

UPDATE dissertation_sections
SET status='completed'
WHERE section_code='3.9.7';

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN ('3.615','3.616','3.617','3.618','3.619','3.620','3.621','3.622','3.623','3.624','3.625','3.626','3.627','3.628','3.629','3.630','3.631','3.632','3.633','3.634','3.635','3.636','3.637','3.638','3.639','3.640','3.641','3.642','3.643','3.644','3.645','3.646','3.647','3.648','3.649','3.650','3.651','3.652','3.653','3.654','3.655','3.656','3.657','3.658','3.659','3.660','3.661','3.662','3.663','3.664','3.665','3.666','3.667','3.668','3.669','3.670','3.671','3.672','3.673','3.674','3.675','3.676','3.677','3.678','3.679','3.680','3.681','3.682','3.683','3.684','3.685','3.686','3.687','3.688','3.689','3.690','3.691')
);

SET @symbol_count :=
(
    SELECT COUNT(*)
    FROM equation_symbols es
    INNER JOIN equations e ON e.equation_id=es.equation_id
    WHERE e.section_id=@section_id
      AND e.equation_number IN ('3.615','3.616','3.617','3.618','3.619','3.620','3.621','3.622','3.623','3.624','3.625','3.626','3.627','3.628','3.629','3.630','3.631','3.632','3.633','3.634','3.635','3.636','3.637','3.638','3.639','3.640','3.641','3.642','3.643','3.644','3.645','3.646','3.647','3.648','3.649','3.650','3.651','3.652','3.653','3.654','3.655','3.656','3.657','3.658','3.659','3.660','3.661','3.662','3.663','3.664','3.665','3.666','3.667','3.668','3.669','3.670','3.671','3.672','3.673','3.674','3.675','3.676','3.677','3.678','3.679','3.680','3.681','3.682','3.683','3.684','3.685','3.686','3.687','3.688','3.689','3.690','3.691')
);

SET @missing_word_latex :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN ('3.615','3.616','3.617','3.618','3.619','3.620','3.621','3.622','3.623','3.624','3.625','3.626','3.627','3.628','3.629','3.630','3.631','3.632','3.633','3.634','3.635','3.636','3.637','3.638','3.639','3.640','3.641','3.642','3.643','3.644','3.645','3.646','3.647','3.648','3.649','3.650','3.651','3.652','3.653','3.654','3.655','3.656','3.657','3.658','3.659','3.660','3.661','3.662','3.663','3.664','3.665','3.666','3.667','3.668','3.669','3.670','3.671','3.672','3.673','3.674','3.675','3.676','3.677','3.678','3.679','3.680','3.681','3.682','3.683','3.684','3.685','3.686','3.687','3.688','3.689','3.690','3.691')
      AND (word_latex IS NULL OR word_latex='')
);

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id=@section_id
      AND exact_location='Abschnitt 3.9.7'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_7_SECTION_EXISTS',
    CASE WHEN @section_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',CASE WHEN @section_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüft, ob Abschnitt 3.9.7 vorhanden ist.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_7_SECTION_EXISTS'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_7_EQUATION_COUNT',
    CASE WHEN @equation_count=77 THEN 'passed' ELSE 'failed' END,
    '77',CONCAT('',@equation_count),
    'Prüft die Gleichungen 3.615 bis 3.691.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_7_EQUATION_COUNT'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_7_SYMBOL_COUNT',
    CASE WHEN @symbol_count>=77 THEN 'passed' ELSE 'warning' END,
    'mindestens 77',CONCAT('',@symbol_count),
    'Prüft mindestens einen Hauptsymbolbezug je Gleichung.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_7_SYMBOL_COUNT'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_7_WORD_LATEX',
    CASE WHEN @missing_word_latex=0 THEN 'passed' ELSE 'failed' END,
    '0',CONCAT('',@missing_word_latex),
    'Prüft fehlende Word-LaTeX-Einträge.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_7_WORD_LATEX'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_7_SOURCE_USAGE',
    CASE WHEN @source_usage_count>=1 THEN 'passed' ELSE 'warning' END,
    'mindestens 1',CONCAT('',@source_usage_count),
    'Prüft die Literaturverknüpfungen des Abschnitts 3.9.7.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_7_SOURCE_USAGE'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_7_SECTION_COMPLETED',
    CASE
      WHEN (SELECT status FROM dissertation_sections WHERE section_id=@section_id)='completed'
      THEN 'passed' ELSE 'failed'
    END,
    'completed',
    (SELECT status FROM dissertation_sections WHERE section_id=@section_id),
    'Prüft den Abschlussstatus von Abschnitt 3.9.7.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_7_SECTION_COMPLETED'
);

COMMIT;

SELECT section_code,title,status,is_original_contribution
FROM dissertation_sections
WHERE section_code='3.9.7';

SELECT
    @equation_count AS equation_count_3_9_7,
    @symbol_count AS symbol_count_3_9_7,
    @source_usage_count AS source_usage_count_3_9_7,
    @missing_word_latex AS missing_word_latex_3_9_7;

SELECT validation_code,validation_status,expected_value,actual_value
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_result_id;
