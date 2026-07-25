/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9.4 – Dynamik funktionaler Organisation
   Grundlage: tatsächliches Schema aus frzk_rkb(3).sql
   MariaDB 10.4 kompatibel
   Keine temporären Tabellen, keine MEMORY-Engine, keine CAST-Ausdrücke
   ============================================================ */

START TRANSACTION;

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-2026-07-25-K3.9.4',
    NOW(),
    'section',
    '3.9.4',
    '1.0',
    'Repository-Update für Abschnitt 3.9.4: gekoppelte Dynamik funktionaler Zustände, Relationen und Operatoren, Trajektorien, Attraktoren, Stabilität, Kohärenzentwicklung, Kipppunkte sowie funktionale Rekonstruktion von Raum und Zeit.',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.4'
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.4'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
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
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_39_id,
    '3.9.4',
    'Dynamik funktionaler Organisation',
    3,
    3.9400,
    'draft',
    1,
    'Synthese der gekoppelten Zustands-, Relations- und Operatorendynamik des FRZK.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.9.4'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.9.4'
    LIMIT 1
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.483', @section_id, 'Erweiterter Systemzustand',
    'Z_t=\\bigl(\\mathbf{z}_t,A_t,\\Omega_t\\bigr)',
    'Z_t=\\bigl(\\mathbf{z}_t,A_t,\\Omega_t\\bigr)',
    'Systemzustand aus Zustandsvektor, Relationsstruktur und verfügbarer Operatorenmenge.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.483'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.484', @section_id, 'Evolutionsoperator',
    '\\mathcal{E}_t:\\mathcal{Z}\\rightarrow\\mathcal{Z}',
    '\\mathcal{E}_t:\\mathcal{Z}\\rightarrow\\mathcal{Z}',
    'Abbildung des zulässigen Zustandsraums auf sich selbst.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.484'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.485', @section_id, 'Allgemeine Zustandsentwicklung',
    'Z_{t+1}=\\mathcal{E}_t(Z_t)',
    'Z_{t+1}=\\mathcal{E}_t(Z_t)',
    'Entwicklung eines Systemzustands durch den zeitabhängigen Evolutionsoperator.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.485'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.486', @section_id, 'Zerlegung des Evolutionsoperators',
    '\\mathcal{E}_t=\\mathcal{O}^{(\\Omega)}_t\\circ\\mathcal{O}^{(A)}_t\\circ\\mathcal{O}^{(z)}_t',
    '\\mathcal{E}_t=\\mathcal{O}^{(\\Omega)}_t\\circ\\mathcal{O}^{(A)}_t\\circ\\mathcal{O}^{(z)}_t',
    'Komposition der Operatoren für Zustand, Relationsstruktur und Operatorenmenge.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.486'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.487', @section_id, 'Entwicklung des Zustandsvektors',
    '\\mathbf{z}_{t+1}=\\mathcal{O}^{(z)}_t\\bigl(\\mathbf{z}_t,A_t,\\Omega_t\\bigr)',
    '\\mathbf{z}_{t+1}=\\mathcal{O}^{(z)}_t\\bigl(\\mathbf{z}_t,A_t,\\Omega_t\\bigr)',
    'Gekoppelte Entwicklung der Zustandswerte.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.487'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.488', @section_id, 'Entwicklung der Relationsstruktur',
    'A_{t+1}=\\mathcal{O}^{(A)}_t\\bigl(A_t,\\mathbf{z}_{t+1},\\Omega_t\\bigr)',
    'A_{t+1}=\\mathcal{O}^{(A)}_t\\bigl(A_t,\\mathbf{z}_{t+1},\\Omega_t\\bigr)',
    'Gekoppelte Entwicklung der Relationsstruktur.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.488'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.489', @section_id, 'Entwicklung der Operatorenmenge',
    '\\Omega_{t+1}=\\mathcal{O}^{(\\Omega)}_t\\bigl(\\Omega_t,\\mathbf{z}_{t+1},A_{t+1}\\bigr)',
    '\\Omega_{t+1}=\\mathcal{O}^{(\\Omega)}_t\\bigl(\\Omega_t,\\mathbf{z}_{t+1},A_{t+1}\\bigr)',
    'Gekoppelte Entwicklung der verfügbaren Operatoren.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.489'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.490', @section_id, 'Rekursive Mehrschrittentwicklung',
    'Z_{t+n}=\\left(\\mathcal{E}_{t+n-1}\\circ\\cdots\\circ\\mathcal{E}_{t+1}\\circ\\mathcal{E}_t\\right)(Z_t)',
    'Z_{t+n}=\\left(\\mathcal{E}_{t+n-1}\\circ\\cdots\\circ\\mathcal{E}_{t+1}\\circ\\mathcal{E}_t\\right)(Z_t)',
    'Rekursive Entwicklung über mehrere Evolutionsschritte.',
    'derived', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.490'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.491', @section_id, 'Trajektorie funktionaler Organisation',
    '\\Gamma(Z_0)=\\{Z_0,Z_1,Z_2,\\ldots\\}',
    '\\Gamma(Z_0)=\\{Z_0,Z_1,Z_2,\\ldots\\}',
    'Folge sämtlicher aus einem Ausgangszustand hervorgehender Systemzustände.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.491'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.492', @section_id, 'Lokaler Operator',
    '\\mathcal{O}^{\\mathrm{lok}}_i:Z|_{F_i}\\rightarrow Z|_{F_i}',
    '\\mathcal{O}^{\\mathrm{lok}}_i:Z|_{F_i}\\rightarrow Z|_{F_i}',
    'Operator auf einer begrenzten funktionalen Teilstruktur.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.492'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.493', @section_id, 'Globaler Operator',
    '\\mathcal{O}^{\\mathrm{glob}}:Z\\rightarrow Z',
    '\\mathcal{O}^{\\mathrm{glob}}:Z\\rightarrow Z',
    'Operator auf dem vollständigen Systemzustand.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.493'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.494', @section_id, 'Menge lokaler Operatoren',
    '\\Omega_{\\mathrm{lok}}=\\{\\mathcal{O}^{\\mathrm{lok}}_1,\\mathcal{O}^{\\mathrm{lok}}_2,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\}',
    '\\Omega_{\\mathrm{lok}}=\\{\\mathcal{O}^{\\mathrm{lok}}_1,\\mathcal{O}^{\\mathrm{lok}}_2,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\}',
    'Gesamtheit der lokal wirksamen Operatoren.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.494'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.495', @section_id, 'Emergente globale Wirkung',
    '\\mathcal{O}^{\\mathrm{em}}=\\Phi\\bigl(\\mathcal{O}^{\\mathrm{lok}}_1,\\mathcal{O}^{\\mathrm{lok}}_2,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\bigr)',
    '\\mathcal{O}^{\\mathrm{em}}=\\Phi\\bigl(\\mathcal{O}^{\\mathrm{lok}}_1,\\mathcal{O}^{\\mathrm{lok}}_2,\\ldots,\\mathcal{O}^{\\mathrm{lok}}_m\\bigr)',
    'Globale Organisationswirkung aus gekoppelten lokalen Operatoren.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.495'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.496', @section_id, 'Fixpunktbedingung',
    '\\mathcal{E}(Z^{*})=Z^{*}',
    '\\mathcal{E}(Z^{*})=Z^{*}',
    'Bedingung eines unter dem Evolutionsoperator unveränderten Zustands.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.496'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.497', @section_id, 'Periodizitätsbedingung',
    '\\mathcal{E}^{p}(Z)=Z',
    '\\mathcal{E}^{p}(Z)=Z',
    'Rückkehr eines Zustands nach p Evolutionsschritten.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.497'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.498', @section_id, 'Minimale Periode',
    '\\mathcal{E}^{k}(Z)\\neq Z\\qquad\\text{für }0<k<p',
    '\\mathcal{E}^{k}(Z)\\neq Z\\qquad\\text{für }0<k<p',
    'Ausschluss einer kleineren Periode als p.',
    'derived', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.498'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.499', @section_id, 'Attraktorbedingung',
    '\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{B}\\bigr)=0',
    '\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{B}\\bigr)=0',
    'Annäherung einer Trajektorie an eine Attraktormenge.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.499'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.500', @section_id, 'Einzugsgebiet eines Attraktors',
    '\\mathcal{B}_{\\mathrm{ein}}=\\left\\{Z_0\\in\\mathcal{Z}\\;\\middle|\\;\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{B}\\bigr)=0\\right\\}',
    '\\mathcal{B}_{\\mathrm{ein}}=\\left\\{Z_0\\in\\mathcal{Z}\\;\\middle|\\;\\lim_{t\\rightarrow\\infty}d\\bigl(Z_t,\\mathcal{B}\\bigr)=0\\right\\}',
    'Menge der Ausgangszustände, deren Trajektorien sich einem Attraktor annähern.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.500'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.501', @section_id, 'Lokale Störung eines Fixpunktes',
    'Z_t=Z^{*}+\\delta Z_t',
    'Z_t=Z^{*}+\\delta Z_t',
    'Darstellung einer lokalen Abweichung vom Fixpunkt.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.501'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.502', @section_id, 'Asymptotische Stabilität',
    '\\lim_{t\\rightarrow\\infty}\\|\\delta Z_t\\|=0',
    '\\lim_{t\\rightarrow\\infty}\\|\\delta Z_t\\|=0',
    'Rückgang einer lokalen Störung im Grenzübergang.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.502'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.503', @section_id, 'Sensitive Zustandsdivergenz',
    'd\\bigl(Z_t,Z''_t\\bigr)\\approx d\\bigl(Z_0,Z''_0\\bigr)e^{\\lambda t}',
    'd\\bigl(Z_t,Z''_t\\bigr)\\approx d\\bigl(Z_0,Z''_0\\bigr)e^{\\lambda t}',
    'Exponentielle Trennung benachbarter Trajektorien bei positivem Exponenten.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.503'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.504', @section_id, 'Kohärenzänderung',
    '\\Delta\\kappa_t=\\kappa_{t+1}-\\kappa_t',
    '\\Delta\\kappa_t=\\kappa_{t+1}-\\kappa_t',
    'Differenz der Kohärenzwerte zweier aufeinanderfolgender Zustände.',
    'metric', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.504'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.505', @section_id, 'Funktionale Kohärenzentwicklung',
    '\\Delta\\kappa_t=\\Psi\\bigl(\\mathbf{z}_t,A_t,\\Omega_t,\\mathbf{z}_{t+1},A_{t+1}\\bigr)',
    '\\Delta\\kappa_t=\\Psi\\bigl(\\mathbf{z}_t,A_t,\\Omega_t,\\mathbf{z}_{t+1},A_{t+1}\\bigr)',
    'Modellabhängige Kohärenzänderung aus Zustand, Struktur und Operatorenwirkung.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.505'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.506', @section_id, 'Zulässiger Kohärenzbereich',
    '\\kappa_{\\min}\\leq\\kappa_t\\leq\\kappa_{\\max}',
    '\\kappa_{\\min}\\leq\\kappa_t\\leq\\kappa_{\\max}',
    'Bereich zwischen minimal und maximal funktional tragfähiger Kohärenz.',
    'metric', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.506'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.507', @section_id, 'Unterkritischer Attraktorbereich',
    '\\mu<\\mu_c\\quad\\Rightarrow\\quad\\mathcal{B}_1',
    '\\mu<\\mu_c\\quad\\Rightarrow\\quad\\mathcal{B}_1',
    'Zuordnung eines unterkritischen Parameterbereichs zum Attraktor B1.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.507'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.508', @section_id, 'Überkritischer Attraktorbereich',
    '\\mu>\\mu_c\\quad\\Rightarrow\\quad\\mathcal{B}_2',
    '\\mu>\\mu_c\\quad\\Rightarrow\\quad\\mathcal{B}_2',
    'Zuordnung eines überkritischen Parameterbereichs zum Attraktor B2.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.508'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.509', @section_id, 'Frühwarnvektor',
    '\\mathbf{w}_t=\\begin{pmatrix}\\sigma_t^2\\\\\\rho_t\\\\\\Delta\\kappa_t\\\\\\tau_t\\\\\\delta_t\\end{pmatrix}',
    '\\mathbf{w}_t=\\begin{pmatrix}\\sigma_t^2\\\\\\rho_t\\\\\\Delta\\kappa_t\\\\\\tau_t\\\\\\delta_t\\end{pmatrix}',
    'Vektor möglicher Frühwarnindikatoren vor einem funktionalen Kipppunkt.',
    'metric', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.509'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.510', @section_id, 'Externer Eingriff',
    'Z_{t+1}=\\mathcal{I}_t\\circ\\mathcal{E}_t(Z_t)',
    'Z_{t+1}=\\mathcal{I}_t\\circ\\mathcal{E}_t(Z_t)',
    'Überlagerung der internen Entwicklung durch einen externen Eingriffsoperator.',
    'model', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.510'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.511', @section_id, 'Zustandsabhängigkeit eines Eingriffs',
    '\\mathcal{I}(Z_{t_1})\\neq\\mathcal{I}(Z_{t_2})',
    '\\mathcal{I}(Z_{t_1})\\neq\\mathcal{I}(Z_{t_2})',
    'Unterschiedliche Wirkung desselben Eingriffs in verschiedenen Entwicklungszuständen.',
    'derived', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.511'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.512', @section_id, 'Funktionale Distanz',
    'd_{\\mathrm{F}}(f_i,f_j)=\\min_{\\pi_{ij}}\\sum_{(u,v)\\in\\pi_{ij}}c(u,v)',
    'd_{\\mathrm{F}}(f_i,f_j)=\\min_{\\pi_{ij}}\\sum_{(u,v)\\in\\pi_{ij}}c(u,v)',
    'Minimale funktionale Pfadkosten zwischen zwei funktionalen Einheiten.',
    'metric', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.512'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.513', @section_id, 'Funktionale Zeitordnung',
    'Z_i\\prec Z_j',
    'Z_i\\prec Z_j',
    'Gerichtete Ordnung zweier funktionaler Zustände.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.513'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.514', @section_id, 'Operatorische Zeitordnung',
    'Z_i\\prec Z_j\\quad\\Longleftrightarrow\\quad\\exists\\mathcal{K}_{ij}:Z_j=\\mathcal{K}_{ij}(Z_i)',
    'Z_i\\prec Z_j\\quad\\Longleftrightarrow\\quad\\exists\\mathcal{K}_{ij}:Z_j=\\mathcal{K}_{ij}(Z_i)',
    'Zeitordnung durch die Existenz einer zulässigen Operatorenkaskade.',
    'definition', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.514'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.515', @section_id, 'Dynamische Rekonstruktionskette',
    '\\text{Operator}\\rightarrow\\text{Zustand}\\rightarrow\\text{Trajektorie}\\rightarrow\\text{Attraktor}\\rightarrow\\text{Kohärenz}\\rightarrow\\text{Raum}\\rightarrow\\text{Zeit}',
    '\\text{Operator}\\rightarrow\\text{Zustand}\\rightarrow\\text{Trajektorie}\\rightarrow\\text{Attraktor}\\rightarrow\\text{Kohärenz}\\rightarrow\\text{Raum}\\rightarrow\\text{Zeit}',
    'Verdichtete Entwicklungskette der dynamischen FRZK-Rekonstruktion.',
    'schema', 'original', NULL, NULL, NULL, 'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.515'
);

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Selbstorganisation durch rekursive Wechselwirkungen und makroskopische Ordnungsbildung.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [12].',
    @revision_id
FROM sources s
WHERE s.citation_number=12
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Komplexe adaptive Systeme und emergente Entwicklung aus lokalen Wechselwirkungen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [14].',
    @revision_id
FROM sources s
WHERE s.citation_number=14
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Netzwerkdynamik und strukturelle Kopplung komplexer Systeme.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [15].',
    @revision_id
FROM sources s
WHERE s.citation_number=15
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Nichtlineare Dynamik, Fixpunkte, Periodizität, Attraktoren und Bifurkationen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [37].',
    @revision_id
FROM sources s
WHERE s.citation_number=37
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'method',
    'Zustandsabhängige Regelung und Eingriffe in dynamische Systeme.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [38].',
    @revision_id
FROM sources s
WHERE s.citation_number=38
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'method',
    'Stabilitätsanalyse nichtlinearer Systeme.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [39].',
    @revision_id
FROM sources s
WHERE s.citation_number=39
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Dynamische Systeme, Trajektorien, Stabilität und Chaos.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [40].',
    @revision_id
FROM sources s
WHERE s.citation_number=40
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Moderne Theorie dynamischer Systeme und Attraktorstrukturen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [43].',
    @revision_id
FROM sources s
WHERE s.citation_number=43
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Chaotische Dynamik und Sensitivität gegenüber Anfangsbedingungen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [44].',
    @revision_id
FROM sources s
WHERE s.citation_number=44
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Netzwerkstruktur und gekoppelte Dynamik.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [48].',
    @revision_id
FROM sources s
WHERE s.citation_number=48
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'method',
    'Metrische Grundlagen zur Bestimmung funktionaler Distanzen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [49].',
    @revision_id
FROM sources s
WHERE s.citation_number=49
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Selbstorganisation aus lokalen Interaktionen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [51].',
    @revision_id
FROM sources s
WHERE s.citation_number=51
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    s.source_id,
    @section_id,
    'background',
    'Emergenz und Komplexität als systemische Entwicklungsformen.',
    'Abschnitt 3.9.4',
    0,
    1,
    'Wiederverwendung der bereits nummerierten Masterquelle [52].',
    @revision_id
FROM sources s
WHERE s.citation_number=52
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.4'
  );

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value, changed_at
)
SELECT
    @revision_id,
    @section_id,
    'created',
    'section',
    '3.9.4',
    'Abschnitt 3.9.4 zur Dynamik funktionaler Organisation registriert.',
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
      AND object_reference='3.9.4'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value, changed_at
)
SELECT
    @revision_id,
    @section_id,
    'equation_added',
    'equations',
    '3.483-3.515',
    '33 Gleichungen zur gekoppelten Systemdynamik, zu Trajektorien, Attraktoren, Stabilität, Kohärenz, Kipppunkten sowie funktionaler Raum- und Zeitordnung registriert.',
    NULL,
    '33',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='3.483-3.515'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type, object_reference,
    change_summary, previous_value, new_value, changed_at
)
SELECT
    @revision_id,
    @section_id,
    'source_reused',
    'literature',
    '[12], [14], [15], [37]-[40], [43], [44], [48], [49], [51], [52]',
    'Dreizehn vorhandene Masterquellen wurden als wissenschaftliche Grundlage des Abschnitts 3.9.4 verknüpft.',
    NULL,
    CONCAT(
        '',
        (
            SELECT COUNT(*)
            FROM source_usage
            WHERE section_id=@section_id
              AND exact_location='Abschnitt 3.9.4'
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
      AND object_reference='[12], [14], [15], [37]-[40], [43], [44], [48], [49], [51], [52]'
);

SET @equation_count :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
        '3.483','3.484','3.485','3.486','3.487','3.488','3.489','3.490',
        '3.491','3.492','3.493','3.494','3.495','3.496','3.497','3.498',
        '3.499','3.500','3.501','3.502','3.503','3.504','3.505','3.506',
        '3.507','3.508','3.509','3.510','3.511','3.512','3.513','3.514',
        '3.515'
      )
);

SET @source_usage_count :=
(
    SELECT COUNT(*)
    FROM source_usage
    WHERE section_id=@section_id
      AND exact_location='Abschnitt 3.9.4'
);

SET @missing_word_latex :=
(
    SELECT COUNT(*)
    FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
        '3.483','3.484','3.485','3.486','3.487','3.488','3.489','3.490',
        '3.491','3.492','3.493','3.494','3.495','3.496','3.497','3.498',
        '3.499','3.500','3.501','3.502','3.503','3.504','3.505','3.506',
        '3.507','3.508','3.509','3.510','3.511','3.512','3.513','3.514',
        '3.515'
      )
      AND (word_latex IS NULL OR word_latex='')
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status, expected_value,
    actual_value, validation_message, checked_at
)
SELECT
    @revision_id,
    'K3_9_4_SECTION_EXISTS',
    CASE WHEN @section_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',
    CASE WHEN @section_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüft, ob Abschnitt 3.9.4 im Repository vorhanden ist.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_4_SECTION_EXISTS'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status, expected_value,
    actual_value, validation_message, checked_at
)
SELECT
    @revision_id,
    'K3_9_4_EQUATION_COUNT',
    CASE WHEN @equation_count=33 THEN 'passed' ELSE 'failed' END,
    '33',
    CONCAT('',@equation_count),
    'Prüft die Gleichungen 3.483 bis 3.515 für Abschnitt 3.9.4.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_4_EQUATION_COUNT'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status, expected_value,
    actual_value, validation_message, checked_at
)
SELECT
    @revision_id,
    'K3_9_4_SOURCE_USAGE_COUNT',
    CASE WHEN @source_usage_count=13 THEN 'passed' ELSE 'warning' END,
    '13',
    CONCAT('',@source_usage_count),
    'Prüft die vorgesehenen Literaturverknüpfungen für Abschnitt 3.9.4.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_4_SOURCE_USAGE_COUNT'
);

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status, expected_value,
    actual_value, validation_message, checked_at
)
SELECT
    @revision_id,
    'K3_9_4_WORD_LATEX',
    CASE WHEN @missing_word_latex=0 THEN 'passed' ELSE 'failed' END,
    '0',
    CONCAT('',@missing_word_latex),
    'Prüft, ob alle Gleichungen des Abschnitts einen Word-LaTeX-Eintrag besitzen.',
    NOW()
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_validation_results
    WHERE revision_id=@revision_id
      AND validation_code='K3_9_4_WORD_LATEX'
);

COMMIT;

SELECT
    section_code,
    title,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code='3.9.4';

SELECT COUNT(*) AS equation_count_3_9_4
FROM equations
WHERE section_id=@section_id
  AND equation_number IN
  (
    '3.483','3.484','3.485','3.486','3.487','3.488','3.489','3.490',
    '3.491','3.492','3.493','3.494','3.495','3.496','3.497','3.498',
    '3.499','3.500','3.501','3.502','3.503','3.504','3.505','3.506',
    '3.507','3.508','3.509','3.510','3.511','3.512','3.513','3.514',
    '3.515'
  );

SELECT COUNT(*) AS source_usage_count_3_9_4
FROM source_usage
WHERE section_id=@section_id
  AND exact_location='Abschnitt 3.9.4';

SELECT
    validation_code,
    validation_status,
    expected_value,
    actual_value
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_result_id;
