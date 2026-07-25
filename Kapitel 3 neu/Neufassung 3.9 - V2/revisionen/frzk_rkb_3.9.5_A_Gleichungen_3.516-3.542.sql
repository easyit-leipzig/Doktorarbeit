/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9.5 – Simulation als mathematischer Prüfstein
   Grundlage: tatsächliches Schema aus frzk_rkb(3).sql
   MariaDB 10.4 kompatibel
   ============================================================ */

/* TEIL A: 3.516–3.542 */

START TRANSACTION;

INSERT INTO repository_revisions
(
    revision_code,revision_date,scope_type,scope_reference,
    version_label,summary,created_by,parent_revision_id
)
SELECT
    'RKB-2026-07-25-K3.9.5',
    NOW(),
    'section',
    '3.9.5',
    '1.0',
    'Repository-Update für Abschnitt 3.9.5: Simulation als mathematischer Prüfstein, Implementierungsverifikation, Parameter- und Sensitivitätsanalyse, Robustheit, Reproduzierbarkeit, empirische Validierung und Gültigkeitsgrenzen.',
    'Olaf Thiele / ChatGPT',
    NULL
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.5'
);

SET @revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.5'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id,section_code,title,chapter_no,
    section_order,status,is_original_contribution,notes
)
SELECT
    NULL,'3.9',
    'Gesamtsynthese des Funktionalen Raum-Zeit-Kohärenzsystems',
    3,3.9000,'draft',1,
    'Abschließende theoretische Synthese des Funktionalen Raum-Zeit-Kohärenzsystems.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.9'
);

SET @chapter_39_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.9' LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id,section_code,title,chapter_no,
    section_order,status,is_original_contribution,notes
)
SELECT
    @chapter_39_id,'3.9.5',
    'Simulation als mathematischer Prüfstein',
    3,3.9500,'draft',1,
    'Methodische Einordnung von Simulation, Verifikation, Validierung, Sensitivität, Robustheit und Reproduzierbarkeit im FRZK.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.9.5'
);

SET @section_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.9.5' LIMIT 1
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.516',@section_id,'Wissenschaftliche Simulationskette',
    '\\text{Axiom}\\rightarrow\\text{Definition}\\rightarrow\\text{mathematisches Modell}\\rightarrow\\text{Implementierung}\\rightarrow\\text{Simulation}\\rightarrow\\text{Auswertung}','\\text{Axiom}\\rightarrow\\text{Definition}\\rightarrow\\text{mathematisches Modell}\\rightarrow\\text{Implementierung}\\rightarrow\\text{Simulation}\\rightarrow\\text{Auswertung}',
    'Abfolge von theoretischer Setzung, Modellbildung, technischer Umsetzung, Simulation und Auswertung.','schema','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.516'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.517',@section_id,'Initialer Modellzustand',
    'Z_0=\\bigl(\\mathbf{z}_0,A_0,\\Omega_0\\bigr)','Z_0=\\bigl(\\mathbf{z}_0,A_0,\\Omega_0\\bigr)',
    'Initialzustand aus Zustandsvektor, Relationsstruktur und Operatorenmenge.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.517'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.518',@section_id,'Parametervektor',
    '\\boldsymbol{\\theta}=\\begin{pmatrix}\\theta_1\\\\\\theta_2\\\\\\vdots\\\\\\theta_p\\end{pmatrix}','\\boldsymbol{\\theta}=\\begin{pmatrix}\\theta_1\\\\\\theta_2\\\\\\vdots\\\\\\theta_p\\end{pmatrix}',
    'Vektor sämtlicher Modellparameter.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.518'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.519',@section_id,'Parametrisierte Zustandsentwicklung',
    'Z_{t+1}=\\mathcal{E}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)','Z_{t+1}=\\mathcal{E}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)',
    'Zustandsentwicklung unter einem parametrisierten Evolutionsoperator.','model','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.519'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.520',@section_id,'Endliche Simulationstrajektorie',
    '\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)=\\{Z_0,Z_1,\\ldots,Z_T\\}','\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)=\\{Z_0,Z_1,\\ldots,Z_T\\}',
    'Endliche Folge der simulierten Systemzustände.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.520'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.521',@section_id,'Mathematisch erwarteter Folgezustand',
    'Z_{t+1}^{\\mathrm{math}}=\\mathcal{E}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)','Z_{t+1}^{\\mathrm{math}}=\\mathcal{E}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)',
    'Aus dem mathematischen Modell erwarteter Folgezustand.','model','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.521'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.522',@section_id,'Numerisch erzeugter Folgezustand',
    'Z_{t+1}^{\\mathrm{num}}=\\widehat{\\mathcal{E}}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)','Z_{t+1}^{\\mathrm{num}}=\\widehat{\\mathcal{E}}\\bigl(Z_t;\\boldsymbol{\\theta}\\bigr)',
    'Durch die Implementierung numerisch erzeugter Folgezustand.','model','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.522'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.523',@section_id,'Implementierungsabweichung',
    '\\varepsilon_{t+1}=d\\bigl(Z_{t+1}^{\\mathrm{math}},Z_{t+1}^{\\mathrm{num}}\\bigr)','\\varepsilon_{t+1}=d\\bigl(Z_{t+1}^{\\mathrm{math}},Z_{t+1}^{\\mathrm{num}}\\bigr)',
    'Distanz zwischen mathematisch erwartetem und numerisch erzeugtem Zustand.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.523'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.524',@section_id,'Numerische Toleranzbedingung',
    '\\varepsilon_t\\leq\\varepsilon_{\\max}','\\varepsilon_t\\leq\\varepsilon_{\\max}',
    'Zulässige obere Grenze der Implementierungsabweichung.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.524'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.525',@section_id,'Nichtkommutativität der Operatoren',
    '\\mathcal{O}_2\\circ\\mathcal{O}_1(Z)\\neq\\mathcal{O}_1\\circ\\mathcal{O}_2(Z)','\\mathcal{O}_2\\circ\\mathcal{O}_1(Z)\\neq\\mathcal{O}_1\\circ\\mathcal{O}_2(Z)',
    'Die Reihenfolge zweier Operatoren kann das Simulationsergebnis verändern.','theorem','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.525'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.526',@section_id,'Axiomatisch zulässiger Simulationszustand',
    'Z_t\\in\\mathcal{Z}_{\\mathcal{A}}\\qquad\\text{für alle }t','Z_t\\in\\mathcal{Z}_{\\mathcal{A}}\\qquad\\text{für alle }t',
    'Jeder simulierte Zustand muss im axiomatisch zulässigen Zustandsraum liegen.','axiom','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.526'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.527',@section_id,'Nebenbedingung',
    'g_j(Z_t)\\leq0','g_j(Z_t)\\leq0',
    'Allgemeine Nebenbedingung für einen simulierten Zustand.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.527'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.528',@section_id,'Globale Nebenbedingungsprüfung',
    '\\max_{t,j}g_j(Z_t)\\leq0','\\max_{t,j}g_j(Z_t)\\leq0',
    'Prüfung sämtlicher Nebenbedingungen über Zeit und Bedingungsindex.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.528'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.529',@section_id,'Parameterraum',
    '\\Theta=\\Theta_1\\times\\Theta_2\\times\\cdots\\times\\Theta_p','\\Theta=\\Theta_1\\times\\Theta_2\\times\\cdots\\times\\Theta_p',
    'Kartesisches Produkt der zulässigen Einzelparameterbereiche.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.529'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.530',@section_id,'Testmenge des Parameterraums',
    '\\Theta_{\\mathrm{test}}=\\{\\boldsymbol{\\theta}^{(1)},\\boldsymbol{\\theta}^{(2)},\\ldots,\\boldsymbol{\\theta}^{(N)}\\}\\subseteq\\Theta','\\Theta_{\\mathrm{test}}=\\{\\boldsymbol{\\theta}^{(1)},\\boldsymbol{\\theta}^{(2)},\\ldots,\\boldsymbol{\\theta}^{(N)}\\}\\subseteq\\Theta',
    'Endliche Menge der in einer Parameterstudie untersuchten Parametrisierungen.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.530'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.531',@section_id,'Trajektorie einer Parametrisierung',
    '\\Gamma_T^{(n)}=\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}^{(n)}\\bigr)','\\Gamma_T^{(n)}=\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}^{(n)}\\bigr)',
    'Simulationstrajektorie für die n-te Parametrisierung.','model','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.531'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.532',@section_id,'Ergebnisfunktion',
    'Q^{(n)}=\\mathcal{Q}\\bigl(\\Gamma_T^{(n)}\\bigr)','Q^{(n)}=\\mathcal{Q}\\bigl(\\Gamma_T^{(n)}\\bigr)',
    'Aus einer Trajektorie abgeleitete Ergebnisgröße.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.532'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.533',@section_id,'Zeitlich gemittelte Kohärenz',
    '\\overline{\\kappa}_T=\\frac{1}{T+1}\\sum_{t=0}^{T}\\kappa_t','\\overline{\\kappa}_T=\\frac{1}{T+1}\\sum_{t=0}^{T}\\kappa_t',
    'Mittelwert der Kohärenz über den gesamten Simulationszeitraum.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.533'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.534',@section_id,'Maximale Drift',
    '\\delta_{\\max}=\\max_{0\\leq t\\leq T}\\delta_t','\\delta_{\\max}=\\max_{0\\leq t\\leq T}\\delta_t',
    'Größte im Simulationszeitraum beobachtete Drift.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.534'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.535',@section_id,'Erreichungszeit einer Zielmenge',
    '\\tau_{\\mathcal{B}}=\\min\\{t\\mid Z_t\\in\\mathcal{B}\\}','\\tau_{\\mathcal{B}}=\\min\\{t\\mid Z_t\\in\\mathcal{B}\\}',
    'Frühester Zeitpunkt, zu dem eine Zielmenge erreicht wird.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.535'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.536',@section_id,'Lokale Parametersensitivität',
    'S_i=\\frac{\\partial Q}{\\partial\\theta_i}','S_i=\\frac{\\partial Q}{\\partial\\theta_i}',
    'Lokale Änderung einer Ergebnisgröße bezüglich eines Parameters.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.536'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.537',@section_id,'Numerische Sensitivitätsnäherung',
    'S_i\\approx\\frac{Q(\\theta_i+\\Delta\\theta_i)-Q(\\theta_i-\\Delta\\theta_i)}{2\\Delta\\theta_i}','S_i\\approx\\frac{Q(\\theta_i+\\Delta\\theta_i)-Q(\\theta_i-\\Delta\\theta_i)}{2\\Delta\\theta_i}',
    'Zentrale Differenzenapproximation der lokalen Parametersensitivität.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.537'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.538',@section_id,'Sensitivitätsvektor',
    '\\mathbf{S}=\\begin{pmatrix}S_1\\\\S_2\\\\\\vdots\\\\S_p\\end{pmatrix}','\\mathbf{S}=\\begin{pmatrix}S_1\\\\S_2\\\\\\vdots\\\\S_p\\end{pmatrix}',
    'Vektor der lokalen Sensitivitäten aller Modellparameter.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.538'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.539',@section_id,'Normierte Sensitivität',
    '\\widetilde{S}_i=\\frac{\\theta_i}{Q}\\frac{\\partial Q}{\\partial\\theta_i}','\\widetilde{S}_i=\\frac{\\theta_i}{Q}\\frac{\\partial Q}{\\partial\\theta_i}',
    'Dimensionslose lokale Sensitivität eines Ergebnisses.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.539'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.540',@section_id,'Nähe zweier Anfangszustände',
    'd(Z_0,Z''_0)<\\varepsilon_0','d(Z_0,Z''_0)<\\varepsilon_0',
    'Bedingung für zwei hinreichend nahe Ausgangszustände.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.540'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.541',@section_id,'Trajektorienabweichung',
    '\\Delta_t=d\\bigl(Z_t,Z''_t\\bigr)','\\Delta_t=d\\bigl(Z_t,Z''_t\\bigr)',
    'Distanz zweier Trajektorien zum Zeitpunkt t.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.541'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.542',@section_id,'Deterministische Reproduzierbarkeit',
    '\\Gamma_T^{(1)}\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)=\\Gamma_T^{(2)}\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)','\\Gamma_T^{(1)}\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)=\\Gamma_T^{(2)}\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)',
    'Identische deterministische Simulationen erzeugen dieselbe Trajektorie.','theorem','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.542'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{S}',
    'Wissenschaftliche Simulationskette',
    'Abfolge von theoretischer Setzung, Modellbildung, technischer Umsetzung, Simulation und Auswertung.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.516'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{S}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z_0',
    'Initialer Modellzustand',
    'Initialzustand aus Zustandsvektor, Relationsstruktur und Operatorenmenge.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.517'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Z_0'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\boldsymbol{\\theta}',
    'Parametervektor',
    'Vektor sämtlicher Modellparameter.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.518'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\boldsymbol{\\theta}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{E}',
    'Parametrisierte Zustandsentwicklung',
    'Zustandsentwicklung unter einem parametrisierten Evolutionsoperator.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.519'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{E}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Gamma_T',
    'Endliche Simulationstrajektorie',
    'Endliche Folge der simulierten Systemzustände.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.520'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Gamma_T'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z_{t+1}^{\\mathrm{math}}',
    'Mathematisch erwarteter Folgezustand',
    'Aus dem mathematischen Modell erwarteter Folgezustand.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.521'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Z_{t+1}^{\\mathrm{math}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Z_{t+1}^{\\mathrm{num}}',
    'Numerisch erzeugter Folgezustand',
    'Durch die Implementierung numerisch erzeugter Folgezustand.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.522'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Z_{t+1}^{\\mathrm{num}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\varepsilon_{t+1}',
    'Implementierungsabweichung',
    'Distanz zwischen mathematisch erwartetem und numerisch erzeugtem Zustand.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.523'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\varepsilon_{t+1}'
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
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.524'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\varepsilon_{\\max}'
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
    'Die Reihenfolge zweier Operatoren kann das Simulationsergebnis verändern.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.525'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{O}_i'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{Z}_{\\mathcal{A}}',
    'Axiomatisch zulässiger Simulationszustand',
    'Jeder simulierte Zustand muss im axiomatisch zulässigen Zustandsraum liegen.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.526'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{Z}_{\\mathcal{A}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'g_j',
    'Nebenbedingung',
    'Allgemeine Nebenbedingung für einen simulierten Zustand.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.527'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='g_j'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\max_{t,j}',
    'Globale Nebenbedingungsprüfung',
    'Prüfung sämtlicher Nebenbedingungen über Zeit und Bedingungsindex.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.528'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\max_{t,j}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Theta',
    'Parameterraum',
    'Kartesisches Produkt der zulässigen Einzelparameterbereiche.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.529'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Theta'
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
    'Endliche Menge der in einer Parameterstudie untersuchten Parametrisierungen.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.530'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Theta_{\\mathrm{test}}'
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
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.531'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Gamma_T^{(n)}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Q^{(n)}',
    'Ergebnisfunktion',
    'Aus einer Trajektorie abgeleitete Ergebnisgröße.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.532'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Q^{(n)}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\overline{\\kappa}_T',
    'Zeitlich gemittelte Kohärenz',
    'Mittelwert der Kohärenz über den gesamten Simulationszeitraum.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.533'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\overline{\\kappa}_T'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\delta_{\\max}',
    'Maximale Drift',
    'Größte im Simulationszeitraum beobachtete Drift.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.534'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\delta_{\\max}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\tau_{\\mathcal{B}}',
    'Erreichungszeit einer Zielmenge',
    'Frühester Zeitpunkt, zu dem eine Zielmenge erreicht wird.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.535'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\tau_{\\mathcal{B}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'S_i',
    'Lokale Parametersensitivität',
    'Lokale Änderung einer Ergebnisgröße bezüglich eines Parameters.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.536'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='S_i'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Delta\\theta_i',
    'Numerische Sensitivitätsnäherung',
    'Zentrale Differenzenapproximation der lokalen Parametersensitivität.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.537'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Delta\\theta_i'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathbf{S}',
    'Sensitivitätsvektor',
    'Vektor der lokalen Sensitivitäten aller Modellparameter.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.538'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathbf{S}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\widetilde{S}_i',
    'Normierte Sensitivität',
    'Dimensionslose lokale Sensitivität eines Ergebnisses.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.539'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\widetilde{S}_i'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\varepsilon_0',
    'Nähe zweier Anfangszustände',
    'Bedingung für zwei hinreichend nahe Ausgangszustände.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.540'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\varepsilon_0'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Delta_t',
    'Trajektorienabweichung',
    'Distanz zweier Trajektorien zum Zeitpunkt t.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.541'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Delta_t'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Gamma_T^{(1)}',
    'Deterministische Reproduzierbarkeit',
    'Identische deterministische Simulationen erzeugen dieselbe Trajektorie.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.542'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Gamma_T^{(1)}'
  );

COMMIT;

SELECT section_code,title,status
FROM dissertation_sections
WHERE section_code='3.9.5';

SELECT COUNT(*) AS equations_part_a
FROM equations
WHERE section_id=@section_id
  AND equation_number IN
  ('3.516','3.517','3.518','3.519','3.520','3.521','3.522','3.523','3.524',
   '3.525','3.526','3.527','3.528','3.529','3.530','3.531','3.532','3.533',
   '3.534','3.535','3.536','3.537','3.538','3.539','3.540','3.541','3.542');
