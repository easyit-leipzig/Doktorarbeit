/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9.6 – Wissenschaftstheoretische und fachliche
                    Einordnung des FRZK
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
    'RKB-2026-07-25-K3.9.6',
    NOW(),
    'section',
    '3.9.6',
    '1.0',
    'Repository-Update für Abschnitt 3.9.6: mathematische, systemtheoretische, physikalische und erkenntnistheoretische Einordnung des FRZK, Verhältnis zu bestehenden Raum-Zeit-Konzepten, Eigenbeitrag und Geltungsgrenzen.',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.6'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.6'
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
    '3.9.6',
    'Wissenschaftstheoretische und fachliche Einordnung des FRZK',
    3,
    3.9600,
    'draft',
    1,
    'Einordnung des FRZK als funktionales, relationales, dynamisches und kohärenzbezogenes Modell.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.9.6'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.9.6'
    LIMIT 1
);


INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.571',
    @section_id,
    'Wissenschaftliche Position des FRZK',
    '\\mathcal{P}_{\\mathrm{FRZK}}=\\mathcal{P}_{\\mathrm{math}}\\cap\\mathcal{P}_{\\mathrm{sys}}\\cap\\mathcal{P}_{\\mathrm{phys}}\\cap\\mathcal{P}_{\\mathrm{epist}}',
    '\\mathcal{P}_{\\mathrm{FRZK}}=\\mathcal{P}_{\\mathrm{math}}\\cap\\mathcal{P}_{\\mathrm{sys}}\\cap\\mathcal{P}_{\\mathrm{phys}}\\cap\\mathcal{P}_{\\mathrm{epist}}',
    'Schnittmenge der mathematischen, systemtheoretischen, physikalischen und erkenntnistheoretischen Bezugsebenen.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.571'
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
    'Schnittmenge der mathematischen, systemtheoretischen, physikalischen und erkenntnistheoretischen Bezugsebenen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.571'
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
    '3.572',
    @section_id,
    'Grundform der Zustandsentwicklung',
    'Z_{t+1}=\\mathcal{E}(Z_t)',
    'Z_{t+1}=\\mathcal{E}(Z_t)',
    'Grundform eines diskreten dynamischen Systems.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.572'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{E}',
    'Grundform der Zustandsentwicklung',
    'Grundform eines diskreten dynamischen Systems.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.572'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{E}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.573',
    @section_id,
    'Erweiterter FRZK-Systemzustand',
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
    SELECT 1 FROM equations WHERE equation_number='3.573'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z_t',
    'Erweiterter FRZK-Systemzustand',
    'Systemzustand aus Zustandswerten, Relationsstruktur und Operatorenmenge.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.573'
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
    '3.574',
    @section_id,
    'Mathematische Einordnung des FRZK',
    '\\mathcal{M}_{\\mathrm{FRZK}}=\\mathcal{D}+\\mathcal{G}+\\mathcal{O}+\\mathcal{K}',
    '\\mathcal{M}_{\\mathrm{FRZK}}=\\mathcal{D}+\\mathcal{G}+\\mathcal{O}+\\mathcal{K}',
    'Verbindung dynamischer Systeme, Graphstrukturen, Operatoren und Kohärenzgrößen.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.574'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{M}_{\\mathrm{FRZK}}',
    'Mathematische Einordnung des FRZK',
    'Verbindung dynamischer Systeme, Graphstrukturen, Operatoren und Kohärenzgrößen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.574'
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
    '3.575',
    @section_id,
    'Menge funktionaler Einheiten',
    'F=\\{f_1,f_2,\\ldots,f_n\\}',
    'F=\\{f_1,f_2,\\ldots,f_n\\}',
    'Menge der funktionalen Einheiten eines Systems.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.575'
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
    'Menge der funktionalen Einheiten eines Systems.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.575'
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
    '3.576',
    @section_id,
    'Zeitabhängige Relationsmenge',
    'R_t\\subseteq F\\times F',
    'R_t\\subseteq F\\times F',
    'Relationsmenge als Teilmenge des kartesischen Produkts funktionaler Einheiten.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.576'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'R_t',
    'Zeitabhängige Relationsmenge',
    'Relationsmenge als Teilmenge des kartesischen Produkts funktionaler Einheiten.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.576'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='R_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.577',
    @section_id,
    'Zeitabhängige Adjazenzmatrix',
    'A_t=\\bigl(a_{ij}(t)\\bigr)_{n\\times n}',
    'A_t=\\bigl(a_{ij}(t)\\bigr)_{n\\times n}',
    'Matrixdarstellung der zeitabhängigen Relationsstruktur.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.577'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'A_t',
    'Zeitabhängige Adjazenzmatrix',
    'Matrixdarstellung der zeitabhängigen Relationsstruktur.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.577'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='A_t'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.578',
    @section_id,
    'Zustandsentwicklung in adaptiven Netzwerken',
    '\\mathbf{z}_{t+1}=\\mathcal{F}\\bigl(\\mathbf{z}_t,A_t\\bigr)',
    '\\mathbf{z}_{t+1}=\\mathcal{F}\\bigl(\\mathbf{z}_t,A_t\\bigr)',
    'Entwicklung der Zustandswerte in Abhängigkeit von der Relationsstruktur.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.578'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathbf{z}_{t+1}',
    'Zustandsentwicklung in adaptiven Netzwerken',
    'Entwicklung der Zustandswerte in Abhängigkeit von der Relationsstruktur.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.578'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathbf{z}_{t+1}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.579',
    @section_id,
    'Strukturentwicklung in adaptiven Netzwerken',
    'A_{t+1}=\\mathcal{G}\\bigl(A_t,\\mathbf{z}_{t+1}\\bigr)',
    'A_{t+1}=\\mathcal{G}\\bigl(A_t,\\mathbf{z}_{t+1}\\bigr)',
    'Entwicklung der Relationsstruktur in Abhängigkeit vom Folgezustand.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.579'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'A_{t+1}',
    'Strukturentwicklung in adaptiven Netzwerken',
    'Entwicklung der Relationsstruktur in Abhängigkeit vom Folgezustand.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.579'
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
    '3.580',
    @section_id,
    'Operatorenkaskade',
    '\\mathcal{E}_t=\\mathcal{O}_m\\circ\\mathcal{O}_{m-1}\\circ\\cdots\\circ\\mathcal{O}_1',
    '\\mathcal{E}_t=\\mathcal{O}_m\\circ\\mathcal{O}_{m-1}\\circ\\cdots\\circ\\mathcal{O}_1',
    'Komposition mehrerer Operatoren zu einem Evolutionsoperator.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.580'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{E}_t',
    'Operatorenkaskade',
    'Komposition mehrerer Operatoren zu einem Evolutionsoperator.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.580'
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
    '3.581',
    @section_id,
    'Nichtkommutativität der Operatoren',
    '\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i',
    '\\mathcal{O}_i\\circ\\mathcal{O}_j\\neq\\mathcal{O}_j\\circ\\mathcal{O}_i',
    'Die Reihenfolge operatorischer Transformationen kann die Entwicklung verändern.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.581'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{O}_i',
    'Nichtkommutativität der Operatoren',
    'Die Reihenfolge operatorischer Transformationen kann die Entwicklung verändern.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.581'
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
    '3.582',
    @section_id,
    'Reflexiver Metaoperator',
    '\\mathfrak{E}:\\bigl(Z_t,\\mathcal{E}_t\\bigr)\\mapsto\\bigl(Z_{t+1},\\mathcal{E}_{t+1}\\bigr)',
    '\\mathfrak{E}:\\bigl(Z_t,\\mathcal{E}_t\\bigr)\\mapsto\\bigl(Z_{t+1},\\mathcal{E}_{t+1}\\bigr)',
    'Metaoperator zur gemeinsamen Veränderung von Zustand und Entwicklungsregel.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.582'
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
    'Metaoperator zur gemeinsamen Veränderung von Zustand und Entwicklungsregel.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.582'
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
    '3.583',
    @section_id,
    'Nichtadditivität des Systems',
    'S\\neq\\sum_{i=1}^{n}f_i',
    'S\\neq\\sum_{i=1}^{n}f_i',
    'Ein System ist nicht mit der bloßen Summe seiner funktionalen Einheiten identisch.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.583'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'S',
    'Nichtadditivität des Systems',
    'Ein System ist nicht mit der bloßen Summe seiner funktionalen Einheiten identisch.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.583'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='S'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.584',
    @section_id,
    'Funktionale Systembeschreibung',
    'S=\\bigl(F,R,\\Omega,\\mathcal{W}\\bigr)',
    'S=\\bigl(F,R,\\Omega,\\mathcal{W}\\bigr)',
    'Systembeschreibung aus Einheiten, Relationen, Operatoren und Gesamtwirkung.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.584'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{W}',
    'Funktionale Systembeschreibung',
    'Systembeschreibung aus Einheiten, Relationen, Operatoren und Gesamtwirkung.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.584'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{W}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.585',
    @section_id,
    'Nichtadditivität der Gesamtwirkung',
    '\\mathcal{W}(S)\\neq\\sum_{i=1}^{n}\\mathcal{W}(f_i)',
    '\\mathcal{W}(S)\\neq\\sum_{i=1}^{n}\\mathcal{W}(f_i)',
    'Die Gesamtwirkung ist nicht notwendig die Summe isolierter Einzelwirkungen.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.585'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{W}(S)',
    'Nichtadditivität der Gesamtwirkung',
    'Die Gesamtwirkung ist nicht notwendig die Summe isolierter Einzelwirkungen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.585'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{W}(S)'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.586',
    @section_id,
    'Emergente globale Operatorenwirkung',
    '\\mathcal{O}_{\\mathrm{global}}=\\Phi\\bigl(\\mathcal{O}^{\\mathrm{lok}}_1,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\bigr)',
    '\\mathcal{O}_{\\mathrm{global}}=\\Phi\\bigl(\\mathcal{O}^{\\mathrm{lok}}_1,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\bigr)',
    'Globale Ordnung als Funktion gekoppelter lokaler Operatoren.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.586'
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
    'Globale Ordnung als Funktion gekoppelter lokaler Operatoren.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.586'
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
    '3.587',
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
    SELECT 1 FROM equations WHERE equation_number='3.587'
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
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.587'
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
    '3.588',
    @section_id,
    'Funktionale Zeit',
    '\\mathcal{T}_{\\mathrm{F}}=\\bigl(Z,\\prec\\bigr)',
    '\\mathcal{T}_{\\mathrm{F}}=\\bigl(Z,\\prec\\bigr)',
    'Funktionale Zeit als gerichtete Ordnung von Zuständen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.588'
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
    'Funktionale Zeit als gerichtete Ordnung von Zuständen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.588'
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
    '3.589',
    @section_id,
    'Physikalische Anschlussebenen',
    '\\mathcal{A}_{\\mathrm{phys}}=\\mathcal{A}_{\\mathrm{formal}}\\cup\\mathcal{A}_{\\mathrm{konzept}}\\cup\\mathcal{A}_{\\mathrm{emp}}',
    '\\mathcal{A}_{\\mathrm{phys}}=\\mathcal{A}_{\\mathrm{formal}}\\cup\\mathcal{A}_{\\mathrm{konzept}}\\cup\\mathcal{A}_{\\mathrm{emp}}',
    'Formale, begriffliche und empirische Anschlussfähigkeit an physikalische Theorien.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.589'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{A}_{\\mathrm{phys}}',
    'Physikalische Anschlussebenen',
    'Formale, begriffliche und empirische Anschlussfähigkeit an physikalische Theorien.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.589'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{A}_{\\mathrm{phys}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.590',
    @section_id,
    'Grenze formaler Modellähnlichkeit',
    '\\mathcal{M}_{\\mathrm{FRZK}}\\cong\\mathcal{M}_{\\mathrm{phys}}\\;\\not\\Rightarrow\\;\\mathcal{W}_{\\mathrm{FRZK}}=\\mathcal{W}_{\\mathrm{phys}}',
    '\\mathcal{M}_{\\mathrm{FRZK}}\\cong\\mathcal{M}_{\\mathrm{phys}}\\;\\not\\Rightarrow\\;\\mathcal{W}_{\\mathrm{FRZK}}=\\mathcal{W}_{\\mathrm{phys}}',
    'Formale Modellähnlichkeit begründet keine Identität der beschriebenen Wirklichkeitsbereiche.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.590'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\cong',
    'Grenze formaler Modellähnlichkeit',
    'Formale Modellähnlichkeit begründet keine Identität der beschriebenen Wirklichkeitsbereiche.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.590'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\cong'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.591',
    @section_id,
    'Physikalische Interpretationsabbildung',
    '\\Pi:\\mathcal{Z}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{Z}_{\\mathrm{phys}}',
    '\\Pi:\\mathcal{Z}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{Z}_{\\mathrm{phys}}',
    'Abbildung funktionaler Modellzustände auf physikalisch interpretierbare Zustände.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.591'
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
    'Abbildung funktionaler Modellzustände auf physikalisch interpretierbare Zustände.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.591'
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
    '3.592',
    @section_id,
    'Empirische Beobachtungsvorhersage',
    '\\widehat{Y}=\\mathcal{H}\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)',
    '\\widehat{Y}=\\mathcal{H}\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)',
    'Aus Anfangszustand und Parametrisierung erzeugte Beobachtungsvorhersage.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.592'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\widehat{Y}',
    'Empirische Beobachtungsvorhersage',
    'Aus Anfangszustand und Parametrisierung erzeugte Beobachtungsvorhersage.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.592'
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
    '3.593',
    @section_id,
    'Konstruktiv-realistisches Modellverständnis',
    '\\mathcal{M}=\\mathcal{C}\\bigl(\\mathcal{W},\\mathcal{B},\\mathcal{S}\\bigr)',
    '\\mathcal{M}=\\mathcal{C}\\bigl(\\mathcal{W},\\mathcal{B},\\mathcal{S}\\bigr)',
    'Modellkonstruktion aus Wirklichkeitsbereich, Beobachtungen und theoretischen Setzungen.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.593'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{C}',
    'Konstruktiv-realistisches Modellverständnis',
    'Modellkonstruktion aus Wirklichkeitsbereich, Beobachtungen und theoretischen Setzungen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.593'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{C}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.594',
    @section_id,
    'Bedingungen wissenschaftlicher Gültigkeit',
    '\\mathcal{G}_{\\mathrm{wiss}}=\\mathcal{K}_{\\mathrm{int}}\\cap\\mathcal{T}_{\\mathrm{trans}}\\cap\\mathcal{E}_{\\mathrm{prüf}}\\cap\\mathcal{R}_{\\mathrm{reprod}}',
    '\\mathcal{G}_{\\mathrm{wiss}}=\\mathcal{K}_{\\mathrm{int}}\\cap\\mathcal{T}_{\\mathrm{trans}}\\cap\\mathcal{E}_{\\mathrm{prüf}}\\cap\\mathcal{R}_{\\mathrm{reprod}}',
    'Schnittmenge interner Konsistenz, Transparenz, Prüfbarkeit und Reproduzierbarkeit.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.594'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{G}_{\\mathrm{wiss}}',
    'Bedingungen wissenschaftlicher Gültigkeit',
    'Schnittmenge interner Konsistenz, Transparenz, Prüfbarkeit und Reproduzierbarkeit.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.594'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{G}_{\\mathrm{wiss}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.595',
    @section_id,
    'Epistemische Statusklassen',
    '\\mathcal{E}_{\\mathrm{Status}}=\\{D,A,M,F,S,B\\}',
    '\\mathcal{E}_{\\mathrm{Status}}=\\{D,A,M,F,S,B\\}',
    'Menge epistemischer Statusklassen wissenschaftlicher Aussagen.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.595'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{E}_{\\mathrm{Status}}',
    'Epistemische Statusklassen',
    'Menge epistemischer Statusklassen wissenschaftlicher Aussagen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.595'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{E}_{\\mathrm{Status}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.596',
    @section_id,
    'Axiom und empirischer Befund',
    'A\\not\\Rightarrow B',
    'A\\not\\Rightarrow B',
    'Aus einem Axiom folgt keine unmittelbare empirische Wahrheit.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.596'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'A',
    'Axiom und empirischer Befund',
    'Aus einem Axiom folgt keine unmittelbare empirische Wahrheit.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.596'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='A'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.597',
    @section_id,
    'Simulation und formale Folgerung',
    'S\\not\\Rightarrow F',
    'S\\not\\Rightarrow F',
    'Aus einem Simulationsergebnis folgt kein allgemeiner mathematischer Satz.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.597'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'S',
    'Simulation und formale Folgerung',
    'Aus einem Simulationsergebnis folgt kein allgemeiner mathematischer Satz.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.597'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='S'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.598',
    @section_id,
    'Empirischer Befund und Modellannahme',
    'B\\not\\Rightarrow M',
    'B\\not\\Rightarrow M',
    'Aus einem empirischen Befund folgt keine eindeutige Modellannahme.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.598'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'B',
    'Empirischer Befund und Modellannahme',
    'Aus einem empirischen Befund folgt keine eindeutige Modellannahme.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.598'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='B'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.599',
    @section_id,
    'Funktionale Distanz',
    'd_{\\mathrm{F}}\\bigl(f_i,f_j\\bigr)=\\min_{\\pi_{ij}}\\sum_{(u,v)\\in\\pi_{ij}}c(u,v)',
    'd_{\\mathrm{F}}\\bigl(f_i,f_j\\bigr)=\\min_{\\pi_{ij}}\\sum_{(u,v)\\in\\pi_{ij}}c(u,v)',
    'Minimale funktionale Pfadkosten zwischen zwei funktionalen Einheiten.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.599'
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
    'Minimale funktionale Pfadkosten zwischen zwei funktionalen Einheiten.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.599'
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
    '3.600',
    @section_id,
    'Operatorische Zeitordnung',
    'Z_i\\prec Z_j\\quad\\Longleftrightarrow\\quad\\exists\\mathcal{K}_{ij}:Z_j=\\mathcal{K}_{ij}(Z_i)',
    'Z_i\\prec Z_j\\quad\\Longleftrightarrow\\quad\\exists\\mathcal{K}_{ij}:Z_j=\\mathcal{K}_{ij}(Z_i)',
    'Gerichtete Zustandsordnung durch eine zulässige Operatorenkaskade.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.600'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\prec',
    'Operatorische Zeitordnung',
    'Gerichtete Zustandsordnung durch eine zulässige Operatorenkaskade.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.600'
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
    '3.601',
    @section_id,
    'Funktionale Dauer',
    '\\tau_{\\mathrm{F}}\\bigl(Z_i,Z_j\\bigr)=\\min_{\\mathcal{K}_{ij}}C\\bigl(\\mathcal{K}_{ij}\\bigr)',
    '\\tau_{\\mathrm{F}}\\bigl(Z_i,Z_j\\bigr)=\\min_{\\mathcal{K}_{ij}}C\\bigl(\\mathcal{K}_{ij}\\bigr)',
    'Minimale Kosten einer Operatorenkaskade zwischen zwei Zuständen.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.601'
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
    'Minimale Kosten einer Operatorenkaskade zwischen zwei Zuständen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.601'
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
    '3.602',
    @section_id,
    'Projektion funktionalen Raums',
    '\\mathcal{R}_{\\mathrm{phys}}=\\Pi_{\\mathrm{R}}\\bigl(\\mathcal{R}_{\\mathrm{F}}\\bigr)',
    '\\mathcal{R}_{\\mathrm{phys}}=\\Pi_{\\mathrm{R}}\\bigl(\\mathcal{R}_{\\mathrm{F}}\\bigr)',
    'Hypothetische Projektion funktionaler Raumstruktur auf physikalischen Raum.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.602'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Pi_{\\mathrm{R}}',
    'Projektion funktionalen Raums',
    'Hypothetische Projektion funktionaler Raumstruktur auf physikalischen Raum.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.602'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Pi_{\\mathrm{R}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.603',
    @section_id,
    'Projektion funktionaler Zeit',
    '\\mathcal{T}_{\\mathrm{phys}}=\\Pi_{\\mathrm{T}}\\bigl(\\mathcal{T}_{\\mathrm{F}}\\bigr)',
    '\\mathcal{T}_{\\mathrm{phys}}=\\Pi_{\\mathrm{T}}\\bigl(\\mathcal{T}_{\\mathrm{F}}\\bigr)',
    'Hypothetische Projektion funktionaler Zeitordnung auf physikalische Zeit.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.603'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Pi_{\\mathrm{T}}',
    'Projektion funktionaler Zeit',
    'Hypothetische Projektion funktionaler Zeitordnung auf physikalische Zeit.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.603'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Pi_{\\mathrm{T}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.604',
    @section_id,
    'Funktionale Charakterisierung einer Einheit',
    'f_i=\\bigl(\\mathcal{R}_i,\\Omega_i,\\mathcal{W}_i\\bigr)',
    'f_i=\\bigl(\\mathcal{R}_i,\\Omega_i,\\mathcal{W}_i\\bigr)',
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
    SELECT 1 FROM equations WHERE equation_number='3.604'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'f_i',
    'Funktionale Charakterisierung einer Einheit',
    'Funktionale Einheit aus Relationen, verfügbaren Operatoren und Wirkungen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.604'
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
    '3.605',
    @section_id,
    'Rekonstruktion funktionalen Raums',
    '\\mathcal{R}_{\\mathrm{F}}=\\mathcal{R}\\bigl(F,R\\bigr)',
    '\\mathcal{R}_{\\mathrm{F}}=\\mathcal{R}\\bigl(F,R\\bigr)',
    'Rekonstruktion funktionalen Raums aus Einheiten und Relationen.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.605'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{R}_{\\mathrm{F}}',
    'Rekonstruktion funktionalen Raums',
    'Rekonstruktion funktionalen Raums aus Einheiten und Relationen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.605'
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
    '3.606',
    @section_id,
    'Rekonstruktion funktionaler Zeit',
    '\\mathcal{T}_{\\mathrm{F}}=\\mathcal{T}\\bigl(Z,\\Omega\\bigr)',
    '\\mathcal{T}_{\\mathrm{F}}=\\mathcal{T}\\bigl(Z,\\Omega\\bigr)',
    'Rekonstruktion funktionaler Zeit aus Zuständen und Operatoren.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.606'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{T}_{\\mathrm{F}}',
    'Rekonstruktion funktionaler Zeit',
    'Rekonstruktion funktionaler Zeit aus Zuständen und Operatoren.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.606'
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
    '3.607',
    @section_id,
    'Kohärenzfunktion',
    '\\kappa=\\mathcal{K}\\bigl(\\mathbf{z},A,\\Omega,\\mathcal{W}\\bigr)',
    '\\kappa=\\mathcal{K}\\bigl(\\mathbf{z},A,\\Omega,\\mathcal{W}\\bigr)',
    'Kohärenz als Funktion von Zustand, Relationsstruktur, Operatoren und Gesamtwirkung.',
    'metric',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.607'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\kappa',
    'Kohärenzfunktion',
    'Kohärenz als Funktion von Zustand, Relationsstruktur, Operatoren und Gesamtwirkung.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.607'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\kappa'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.608',
    @section_id,
    'Dynamisierung der Operatorenstruktur',
    '\\Omega_{t+1}=\\mathcal{O}^{(\\Omega)}\\bigl(\\Omega_t,Z_{t+1}\\bigr)',
    '\\Omega_{t+1}=\\mathcal{O}^{(\\Omega)}\\bigl(\\Omega_t,Z_{t+1}\\bigr)',
    'Veränderung der zukünftigen Entwicklungsmöglichkeiten des Systems.',
    'model',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.608'
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
    'Veränderung der zukünftigen Entwicklungsmöglichkeiten des Systems.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.608'
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
    '3.609',
    @section_id,
    'Theorie-Modell-Simulations-Empirie-Kette',
    '\\mathcal{T}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{M}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{S}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{E}_{\\mathrm{FRZK}}',
    '\\mathcal{T}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{M}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{S}_{\\mathrm{FRZK}}\\rightarrow\\mathcal{E}_{\\mathrm{FRZK}}',
    'Übergang von Theorie über mathematisches Modell und Simulation zur empirischen Prüfung.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.609'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{T}_{\\mathrm{FRZK}}',
    'Theorie-Modell-Simulations-Empirie-Kette',
    'Übergang von Theorie über mathematisches Modell und Simulation zur empirischen Prüfung.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.609'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{T}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.610',
    @section_id,
    'Eigenbeitrag des FRZK',
    '\\mathcal{C}_{\\mathrm{FRZK}}=\\mathcal{F}\\oplus\\mathcal{R}\\oplus\\mathcal{O}\\oplus\\mathcal{K}\\oplus\\mathcal{S}',
    '\\mathcal{C}_{\\mathrm{FRZK}}=\\mathcal{F}\\oplus\\mathcal{R}\\oplus\\mathcal{O}\\oplus\\mathcal{K}\\oplus\\mathcal{S}',
    'Verbindung von Funktionalität, relationalem Raum, Operatorik, Kohärenz und Simulation.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.610'
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
    'Verbindung von Funktionalität, relationalem Raum, Operatorik, Kohärenz und Simulation.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.610'
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
    '3.611',
    @section_id,
    'Geltungsstatus des FRZK',
    '\\mathcal{G}_{\\mathrm{FRZK}}=\\bigl(G_{\\mathrm{formal}},G_{\\mathrm{sim}},G_{\\mathrm{emp}}\\bigr)',
    '\\mathcal{G}_{\\mathrm{FRZK}}=\\bigl(G_{\\mathrm{formal}},G_{\\mathrm{sim}},G_{\\mathrm{emp}}\\bigr)',
    'Formaler, simulationsbezogener und empirischer Geltungsbereich.',
    'definition',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.611'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{G}_{\\mathrm{FRZK}}',
    'Geltungsstatus des FRZK',
    'Formaler, simulationsbezogener und empirischer Geltungsbereich.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.611'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{G}_{\\mathrm{FRZK}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.612',
    @section_id,
    'Trennung der Geltungsbereiche',
    'G_{\\mathrm{formal}}\\neq G_{\\mathrm{sim}}\\neq G_{\\mathrm{emp}}',
    'G_{\\mathrm{formal}}\\neq G_{\\mathrm{sim}}\\neq G_{\\mathrm{emp}}',
    'Formale, simulationsbezogene und empirische Geltung sind nicht gleichzusetzen.',
    'theorem',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.612'
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
    'Formale, simulationsbezogene und empirische Geltung sind nicht gleichzusetzen.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.612'
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
    '3.613',
    @section_id,
    'Richtungen der Weiterentwicklung',
    '\\mathcal{W}_{\\mathrm{weiter}}=\\mathcal{W}_{\\mathrm{formal}}\\cup\\mathcal{W}_{\\mathrm{sim}}\\cup\\mathcal{W}_{\\mathrm{emp}}',
    '\\mathcal{W}_{\\mathrm{weiter}}=\\mathcal{W}_{\\mathrm{formal}}\\cup\\mathcal{W}_{\\mathrm{sim}}\\cup\\mathcal{W}_{\\mathrm{emp}}',
    'Formale, simulationsbezogene und empirische Weiterentwicklung des FRZK.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.613'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{W}_{\\mathrm{weiter}}',
    'Richtungen der Weiterentwicklung',
    'Formale, simulationsbezogene und empirische Weiterentwicklung des FRZK.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.613'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{W}_{\\mathrm{weiter}}'
  );

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.614',
    @section_id,
    'Gesamteinordnung des FRZK',
    '\\boxed{\\mathrm{FRZK}=\\mathrm{funktionales}\\;\\mathrm{relationales}\\;\\mathrm{dynamisches}\\;\\mathrm{Kohärenzmodell}}',
    '\\boxed{\\mathrm{FRZK}=\\mathrm{funktionales}\\;\\mathrm{relationales}\\;\\mathrm{dynamisches}\\;\\mathrm{Kohärenzmodell}}',
    'Verdichtete wissenschaftliche Gesamteinordnung des Funktionalen Raum-Zeit-Kohärenzsystems.',
    'schema',
    'original',
    NULL,
    NULL,
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.614'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathrm{FRZK}',
    'Gesamteinordnung des FRZK',
    'Verdichtete wissenschaftliche Gesamteinordnung des Funktionalen Raum-Zeit-Kohärenzsystems.',
    NULL,
    'Abschnitt 3.9.6',
    1
FROM equations e
WHERE e.equation_number='3.614'
  AND NOT EXISTS
  (
      SELECT 1
      FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathrm{FRZK}'
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
    'Wissenschaftstheoretische Grundlagen der Modellbildung und der Trennung von Theorie und Wirklichkeit.',
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [1].',
    @revision_id
FROM sources s
WHERE s.citation_number=1
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Erkenntnistheoretische Grundlagen wissenschaftlicher Begriffs- und Modellkonstruktion.',
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [2].',
    @revision_id
FROM sources s
WHERE s.citation_number=2
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Historische und philosophische Einordnung relationaler Raum- und Zeitkonzepte.',
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [3].',
    @revision_id
FROM sources s
WHERE s.citation_number=3
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [4].',
    @revision_id
FROM sources s
WHERE s.citation_number=4
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Relationale Auffassung von Raum, Zeit und physikalischer Ordnung.',
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [5].',
    @revision_id
FROM sources s
WHERE s.citation_number=5
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [12].',
    @revision_id
FROM sources s
WHERE s.citation_number=12
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [14].',
    @revision_id
FROM sources s
WHERE s.citation_number=14
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [15].',
    @revision_id
FROM sources s
WHERE s.citation_number=15
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [37].',
    @revision_id
FROM sources s
WHERE s.citation_number=37
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [40].',
    @revision_id
FROM sources s
WHERE s.citation_number=40
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [43].',
    @revision_id
FROM sources s
WHERE s.citation_number=43
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [48].',
    @revision_id
FROM sources s
WHERE s.citation_number=48
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [49].',
    @revision_id
FROM sources s
WHERE s.citation_number=49
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [51].',
    @revision_id
FROM sources s
WHERE s.citation_number=51
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
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
    'Abschnitt 3.9.6',
    0,
    1,
    'Wiederverwendung der vorhandenen Masterquelle [52].',
    @revision_id
FROM sources s
WHERE s.citation_number=52
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.6'
  );

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.9.6',
    'Abschnitt 3.9.6 zur wissenschaftstheoretischen und fachlichen Einordnung des FRZK registriert.',
    NULL,
    'draft',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.9.6'
);

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,
    @section_id,
    'equation_added',
    'equations',
    '3.571-3.614',
    '44 Gleichungen zur mathematischen, systemtheoretischen, physikalischen und erkenntnistheoretischen Einordnung des FRZK registriert.',
    NULL,
    '44',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='3.571-3.614'
);

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,
    @section_id,
    'source_reused',
    'literature',
    'Masterquellen Abschnitt 3.9.6',
    'Vorhandene Quellen zu Wissenschaftstheorie, Raum-Zeit-Konzepten, Systemtheorie, Dynamik und Netzwerken wurden verknüpft.',
    NULL,
    CONCAT(
        '',
        (
            SELECT COUNT(*)
            FROM source_usage
            WHERE section_id=@section_id
              AND exact_location='Abschnitt 3.9.6'
        )
    ),
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_reused'
      AND object_reference='Masterquellen Abschnitt 3.9.6'
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
        '3.571','3.572','3.573','3.574','3.575','3.576','3.577','3.578',
        '3.579','3.580','3.581','3.582','3.583','3.584','3.585','3.586',
        '3.587','3.588','3.589','3.590','3.591','3.592','3.593','3.594',
        '3.595','3.596','3.597','3.598','3.599','3.600','3.601','3.602',
        '3.603','3.604','3.605','3.606','3.607','3.608','3.609','3.610',
        '3.611','3.612','3.613','3.614'
      )
);

SET @symbol_count :=
(
    SELECT COUNT(*)
    FROM equation_symbols es
    INNER JOIN equations e ON e.equation_id=es.equation_id
    WHERE e.section_id=@section_id
      AND e.equation_number IN
      (
        '3.571','3.572','3.573','3.574','3.575','3.576','3.577','3.578',
        '3.579','3.580','3.581','3.582','3.583','3.584','3.585','3.586',
        '3.587','3.588','3.589','3.590','3.591','3.592','3.593','3.594',
        '3.595','3.596','3.597','3.598','3.599','3.600','3.601','3.602',
        '3.603','3.604','3.605','3.606','3.607','3.608','3.609','3.610',
        '3.611','3.612','3.613','3.614'
      )
);

SET @missing_word_latex :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
        '3.571','3.572','3.573','3.574','3.575','3.576','3.577','3.578',
        '3.579','3.580','3.581','3.582','3.583','3.584','3.585','3.586',
        '3.587','3.588','3.589','3.590','3.591','3.592','3.593','3.594',
        '3.595','3.596','3.597','3.598','3.599','3.600','3.601','3.602',
        '3.603','3.604','3.605','3.606','3.607','3.608','3.609','3.610',
        '3.611','3.612','3.613','3.614'
      )
      AND (word_latex IS NULL OR word_latex='')
);

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id=@section_id
      AND exact_location='Abschnitt 3.9.6'
);

INSERT INTO repository_validation_results
(
    revision_id,validation_code,validation_status,expected_value,
    actual_value,validation_message,checked_at
)
SELECT
    @revision_id,
    'K3_9_6_SECTION_EXISTS',
    CASE WHEN @section_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüft, ob Abschnitt 3.9.6 im Repository vorhanden ist.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_6_SECTION_EXISTS'
);

INSERT INTO repository_validation_results
(
    revision_id,validation_code,validation_status,expected_value,
    actual_value,validation_message,checked_at
)
SELECT
    @revision_id,
    'K3_9_6_EQUATION_COUNT',
    CASE WHEN @equation_count=44 THEN 'passed' ELSE 'failed' END,
    '44',
    CONCAT('',@equation_count),
    'Prüft die Gleichungen 3.571 bis 3.614.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_6_EQUATION_COUNT'
);

INSERT INTO repository_validation_results
(
    revision_id,validation_code,validation_status,expected_value,
    actual_value,validation_message,checked_at
)
SELECT
    @revision_id,
    'K3_9_6_SYMBOL_COUNT',
    CASE WHEN @symbol_count>=44 THEN 'passed' ELSE 'warning' END,
    'mindestens 44',
    CONCAT('',@symbol_count),
    'Prüft mindestens einen Hauptsymbolbezug je Gleichung.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_6_SYMBOL_COUNT'
);

INSERT INTO repository_validation_results
(
    revision_id,validation_code,validation_status,expected_value,
    actual_value,validation_message,checked_at
)
SELECT
    @revision_id,
    'K3_9_6_WORD_LATEX',
    CASE WHEN @missing_word_latex=0 THEN 'passed' ELSE 'failed' END,
    '0',
    CONCAT('',@missing_word_latex),
    'Prüft fehlende Word-LaTeX-Einträge.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_6_WORD_LATEX'
);

INSERT INTO repository_validation_results
(
    revision_id,validation_code,validation_status,expected_value,
    actual_value,validation_message,checked_at
)
SELECT
    @revision_id,
    'K3_9_6_SOURCE_USAGE',
    CASE WHEN @source_usage_count>=1 THEN 'passed' ELSE 'warning' END,
    'mindestens 1',
    CONCAT('',@source_usage_count),
    'Prüft die Literaturverknüpfungen des Abschnitts 3.9.6.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_6_SOURCE_USAGE'
);

COMMIT;

SELECT
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code='3.9.6';

SELECT
    @equation_count AS equation_count_3_9_6,
    @symbol_count AS symbol_count_3_9_6,
    @source_usage_count AS source_usage_count_3_9_6,
    @missing_word_latex AS missing_word_latex_3_9_6;

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_result_id;
