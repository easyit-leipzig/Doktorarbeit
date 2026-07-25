/* ============================================================
   FRZK-RKB – Repository-Update
   Kapitel 3.9.5 – Simulation als mathematischer Prüfstein
   Grundlage: tatsächliches Schema aus frzk_rkb(3).sql
   MariaDB 10.4 kompatibel
   ============================================================ */

/* TEIL B: 3.543–3.570, Quellen, Audit und Validierung */
START TRANSACTION;

SET @revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-2026-07-25-K3.9.5'
    LIMIT 1
);

SET @section_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.9.5'
    LIMIT 1
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.543',@section_id,'Stochastischer Zustandsübergang',
    'Z_{t+1}=\\mathcal{E}\\bigl(Z_t,\\boldsymbol{\\xi}_t;\\boldsymbol{\\theta}\\bigr)','Z_{t+1}=\\mathcal{E}\\bigl(Z_t,\\boldsymbol{\\xi}_t;\\boldsymbol{\\theta}\\bigr)',
    'Zustandsentwicklung unter zusätzlichem stochastischem Einfluss.','model','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.543'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.544',@section_id,'Menge stochastischer Trajektorien',
    '\\mathcal{G}_M=\\{\\Gamma_T^{(1)},\\Gamma_T^{(2)},\\ldots,\\Gamma_T^{(M)}\\}','\\mathcal{G}_M=\\{\\Gamma_T^{(1)},\\Gamma_T^{(2)},\\ldots,\\Gamma_T^{(M)}\\}',
    'Menge wiederholter stochastischer Simulationsläufe.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.544'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.545',@section_id,'Empirischer Ergebnismittelwert',
    '\\overline{Q}=\\frac{1}{M}\\sum_{m=1}^{M}Q^{(m)}','\\overline{Q}=\\frac{1}{M}\\sum_{m=1}^{M}Q^{(m)}',
    'Mittelwert einer Ergebnisgröße über M Wiederholungen.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.545'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.546',@section_id,'Empirische Ergebnisvarianz',
    's_Q^2=\\frac{1}{M-1}\\sum_{m=1}^{M}\\left(Q^{(m)}-\\overline{Q}\\right)^2','s_Q^2=\\frac{1}{M-1}\\sum_{m=1}^{M}\\left(Q^{(m)}-\\overline{Q}\\right)^2',
    'Empirische Varianz einer Ergebnisgröße über M Wiederholungen.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.546'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.547',@section_id,'Parameterumgebung',
    'U_{\\varepsilon}\\bigl(\\boldsymbol{\\theta}^{*}\\bigr)=\\left\\{\\boldsymbol{\\theta}\\in\\Theta\\;\\middle|\\;\\|\\boldsymbol{\\theta}-\\boldsymbol{\\theta}^{*}\\|<\\varepsilon\\right\\}','U_{\\varepsilon}\\bigl(\\boldsymbol{\\theta}^{*}\\bigr)=\\left\\{\\boldsymbol{\\theta}\\in\\Theta\\;\\middle|\\;\\|\\boldsymbol{\\theta}-\\boldsymbol{\\theta}^{*}\\|<\\varepsilon\\right\\}',
    'Offene Umgebung einer Referenzparametrisierung.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.547'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.548',@section_id,'Robustheitsbedingung',
    'R\\bigl(\\boldsymbol{\\theta}\\bigr)=R\\bigl(\\boldsymbol{\\theta}^{*}\\bigr)\\qquad\\text{für alle }\\boldsymbol{\\theta}\\in U_{\\varepsilon}\\bigl(\\boldsymbol{\\theta}^{*}\\bigr)','R\\bigl(\\boldsymbol{\\theta}\\bigr)=R\\bigl(\\boldsymbol{\\theta}^{*}\\bigr)\\qquad\\text{für alle }\\boldsymbol{\\theta}\\in U_{\\varepsilon}\\bigl(\\boldsymbol{\\theta}^{*}\\bigr)',
    'Konstanz eines qualitativen Ergebnisses in einer Parameterumgebung.','theorem','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.548'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.549',@section_id,'Suche nach einem Gegenbeispiel',
    '\\exists\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr):\\neg P\\left(\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)\\right)','\\exists\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr):\\neg P\\left(\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)\\right)',
    'Formale Suche nach einem Simulationsfall, der eine vermutete Eigenschaft verletzt.','model','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.549'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.550',@section_id,'Indexbereich geprüfter Läufe',
    'n=1,2,\\ldots,N','n=1,2,\\ldots,N',
    'Indexmenge einer endlichen Simulationsstudie.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.550'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.551',@section_id,'Beobachtete Eigenschaft eines Laufs',
    'P\\left(\\Gamma_T^{(n)}\\right)','P\\left(\\Gamma_T^{(n)}\\right)',
    'Eigenschaft P für die n-te simulierte Trajektorie.','other','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.551'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.552',@section_id,'Allgemeine Eigenschaftsbehauptung',
    '\\forall Z_0,\\boldsymbol{\\theta}:P\\left(\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)\\right)','\\forall Z_0,\\boldsymbol{\\theta}:P\\left(\\Gamma_T\\bigl(Z_0,\\boldsymbol{\\theta}\\bigr)\\right)',
    'Universelle Eigenschaftsbehauptung, die nicht allein durch endlich viele Simulationen bewiesen wird.','theorem','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.552'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.553',@section_id,'Makroskopisches Ordnungsmaß',
    'M_t=\\mathcal{M}(Z_t)','M_t=\\mathcal{M}(Z_t)',
    'Aus einem Systemzustand bestimmtes makroskopisches Ordnungsmaß.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.553'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.554',@section_id,'Vorübergangsbereich',
    'M_t<M_c\\quad\\text{für }t<t_c','M_t<M_c\\quad\\text{für }t<t_c',
    'Ordnungsmaß unterhalb eines Schwellenwertes vor dem Übergang.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.554'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.555',@section_id,'Nachübergangsbereich',
    'M_t\\geq M_c\\quad\\text{für }t\\geq t_c','M_t\\geq M_c\\quad\\text{für }t\\geq t_c',
    'Ordnungsmaß am oder oberhalb eines Schwellenwertes nach dem Übergang.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.555'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.556',@section_id,'Ergebnismaß des ersten Modells',
    'Q_1=\\mathcal{Q}\\bigl(\\Gamma_T^{\\mathcal{M}_1}\\bigr)','Q_1=\\mathcal{Q}\\bigl(\\Gamma_T^{\\mathcal{M}_1}\\bigr)',
    'Ergebnisgröße der ersten Modellvariante.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.556'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.557',@section_id,'Ergebnismaß des zweiten Modells',
    'Q_2=\\mathcal{Q}\\bigl(\\Gamma_T^{\\mathcal{M}_2}\\bigr)','Q_2=\\mathcal{Q}\\bigl(\\Gamma_T^{\\mathcal{M}_2}\\bigr)',
    'Ergebnisgröße der zweiten Modellvariante.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.557'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.558',@section_id,'Ergebnisdifferenz zweier Modelle',
    '\\Delta Q=Q_1-Q_2','\\Delta Q=Q_1-Q_2',
    'Differenz der Ergebnisgrößen zweier Modellvarianten.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.558'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.559',@section_id,'Verifikationsbeziehung',
    '\\text{Verifikation}:\\quad\\widehat{\\mathcal{E}}\\approx\\mathcal{E}','\\text{Verifikation}:\\quad\\widehat{\\mathcal{E}}\\approx\\mathcal{E}',
    'Vergleich der implementierten numerischen Entwicklung mit dem mathematischen Modell.','schema','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.559'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.560',@section_id,'Validierungsbeziehung',
    '\\text{Validierung}:\\quad\\mathcal{M}\\approx\\mathcal{W}','\\text{Validierung}:\\quad\\mathcal{M}\\approx\\mathcal{W}',
    'Vergleich der Modellergebnisse mit dem empirisch beobachteten Wirklichkeitsbereich.','schema','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.560'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.561',@section_id,'Empirische Beobachtungsreihe',
    'Y=\\{Y_0,Y_1,\\ldots,Y_T\\}','Y=\\{Y_0,Y_1,\\ldots,Y_T\\}',
    'Zeitlich geordnete empirische Beobachtungswerte.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.561'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.562',@section_id,'Simulierte Beobachtungsreihe',
    '\\widehat{Y}=\\{\\widehat{Y}_0,\\widehat{Y}_1,\\ldots,\\widehat{Y}_T\\}','\\widehat{Y}=\\{\\widehat{Y}_0,\\widehat{Y}_1,\\ldots,\\widehat{Y}_T\\}',
    'Aus der Simulation abgeleitete Vergleichsreihe.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.562'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.563',@section_id,'Mittlere empirische Abweichung',
    'E_T=\\frac{1}{T+1}\\sum_{t=0}^{T}d\\bigl(Y_t,\\widehat{Y}_t\\bigr)','E_T=\\frac{1}{T+1}\\sum_{t=0}^{T}d\\bigl(Y_t,\\widehat{Y}_t\\bigr)',
    'Mittlere Distanz zwischen empirischer und simulierter Reihe.','metric','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.563'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.564',@section_id,'Simulationsdokumentation',
    '\\mathcal{D}_{\\mathrm{sim}}=\\bigl(Z_0,\\boldsymbol{\\theta},\\mathcal{E},T,\\Delta t,\\mathcal{Q},\\mathcal{C}_{\\mathrm{num}},s\\bigr)','\\mathcal{D}_{\\mathrm{sim}}=\\bigl(Z_0,\\boldsymbol{\\theta},\\mathcal{E},T,\\Delta t,\\mathcal{Q},\\mathcal{C}_{\\mathrm{num}},s\\bigr)',
    'Vollständiger Dokumentationsvektor eines Simulationslaufs.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.564'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.565',@section_id,'Technische Zustandskodierung',
    '\\widehat{Z}_t=\\operatorname{Enc}(Z_t)','\\widehat{Z}_t=\\operatorname{Enc}(Z_t)',
    'Kodierung eines mathematischen Zustands in eine technische Repräsentation.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.565'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.566',@section_id,'Technische Zustandsdekodierung',
    'Z_t=\\operatorname{Dec}\\bigl(\\widehat{Z}_t\\bigr)','Z_t=\\operatorname{Dec}\\bigl(\\widehat{Z}_t\\bigr)',
    'Rückübersetzung einer technischen Repräsentation in den mathematischen Zustand.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.566'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.567',@section_id,'Verlustfreie Repräsentation',
    '\\operatorname{Dec}\\circ\\operatorname{Enc}(Z_t)=Z_t','\\operatorname{Dec}\\circ\\operatorname{Enc}(Z_t)=Z_t',
    'Bedingung einer verlustfreien technischen Zustandsdarstellung.','theorem','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.567'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.568',@section_id,'Funktionen der FRZK-Simulation',
    '\\mathcal{S}_{\\mathrm{FRZK}}=\\mathcal{V}_{\\mathrm{impl}}\\cup\\mathcal{E}_{\\mathrm{dyn}}\\cup\\mathcal{P}_{\\mathrm{emp}}','\\mathcal{S}_{\\mathrm{FRZK}}=\\mathcal{V}_{\\mathrm{impl}}\\cup\\mathcal{E}_{\\mathrm{dyn}}\\cup\\mathcal{P}_{\\mathrm{emp}}',
    'Vereinigung von Implementierungsprüfung, dynamischer Exploration und empirischer Prognose.','schema','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.568'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.569',@section_id,'Gültigkeitsbereich eines Simulationsbefunds',
    '\\mathcal{G}(R)=\\mathcal{Z}_0\\times\\Theta_{\\mathrm{test}}\\times[0,T]\\times\\mathcal{M}_{\\mathrm{impl}}','\\mathcal{G}(R)=\\mathcal{Z}_0\\times\\Theta_{\\mathrm{test}}\\times[0,T]\\times\\mathcal{M}_{\\mathrm{impl}}',
    'Gültigkeitsbereich eines Befunds aus Anfangszuständen, Parameterraum, Zeithorizont und Implementierung.','definition','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.569'
);

INSERT INTO equations
(
    equation_number,section_id,title,equation_latex,word_latex,
    plain_description,equation_type,provenance,source_id,
    derivation,assumptions,validation_status,created_revision_id
)
SELECT
    '3.570',@section_id,'Zyklischer wissenschaftlicher Prüfprozess',
    '\\text{Theorie}\\rightarrow\\text{Modell}\\rightarrow\\text{Simulation}\\rightarrow\\text{Auswertung}\\rightarrow\\text{Kritik}\\rightarrow\\text{Theorie}','\\text{Theorie}\\rightarrow\\text{Modell}\\rightarrow\\text{Simulation}\\rightarrow\\text{Auswertung}\\rightarrow\\text{Kritik}\\rightarrow\\text{Theorie}',
    'Rückgekoppelter Prozess von Theorie, Modellbildung, Simulation, Auswertung und Kritik.','schema','original',NULL,
    NULL,NULL,'checked',@revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.570'
);

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\boldsymbol{\\xi}_t',
    'Stochastischer Zustandsübergang',
    'Zustandsentwicklung unter zusätzlichem stochastischem Einfluss.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.543'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\boldsymbol{\\xi}_t'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{G}_M',
    'Menge stochastischer Trajektorien',
    'Menge wiederholter stochastischer Simulationsläufe.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.544'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{G}_M'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\overline{Q}',
    'Empirischer Ergebnismittelwert',
    'Mittelwert einer Ergebnisgröße über M Wiederholungen.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.545'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\overline{Q}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    's_Q^2',
    'Empirische Ergebnisvarianz',
    'Empirische Varianz einer Ergebnisgröße über M Wiederholungen.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.546'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='s_Q^2'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'U_{\\varepsilon}',
    'Parameterumgebung',
    'Offene Umgebung einer Referenzparametrisierung.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.547'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='U_{\\varepsilon}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'R',
    'Robustheitsbedingung',
    'Konstanz eines qualitativen Ergebnisses in einer Parameterumgebung.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.548'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='R'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'P',
    'Suche nach einem Gegenbeispiel',
    'Formale Suche nach einem Simulationsfall, der eine vermutete Eigenschaft verletzt.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.549'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='P'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'N',
    'Indexbereich geprüfter Läufe',
    'Indexmenge einer endlichen Simulationsstudie.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.550'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='N'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'P',
    'Beobachtete Eigenschaft eines Laufs',
    'Eigenschaft P für die n-te simulierte Trajektorie.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.551'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='P'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\forall',
    'Allgemeine Eigenschaftsbehauptung',
    'Universelle Eigenschaftsbehauptung, die nicht allein durch endlich viele Simulationen bewiesen wird.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.552'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\forall'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'M_t',
    'Makroskopisches Ordnungsmaß',
    'Aus einem Systemzustand bestimmtes makroskopisches Ordnungsmaß.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.553'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='M_t'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'M_c',
    'Vorübergangsbereich',
    'Ordnungsmaß unterhalb eines Schwellenwertes vor dem Übergang.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.554'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='M_c'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    't_c',
    'Nachübergangsbereich',
    'Ordnungsmaß am oder oberhalb eines Schwellenwertes nach dem Übergang.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.555'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='t_c'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Q_1',
    'Ergebnismaß des ersten Modells',
    'Ergebnisgröße der ersten Modellvariante.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.556'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Q_1'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    'Q_2',
    'Ergebnismaß des zweiten Modells',
    'Ergebnisgröße der zweiten Modellvariante.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.557'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Q_2'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\Delta Q',
    'Ergebnisdifferenz zweier Modelle',
    'Differenz der Ergebnisgrößen zweier Modellvarianten.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.558'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\Delta Q'
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
    'Vergleich der implementierten numerischen Entwicklung mit dem mathematischen Modell.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.559'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\widehat{\\mathcal{E}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{W}',
    'Validierungsbeziehung',
    'Vergleich der Modellergebnisse mit dem empirisch beobachteten Wirklichkeitsbereich.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.560'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{W}'
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
    'Zeitlich geordnete empirische Beobachtungswerte.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.561'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='Y'
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
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.562'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\widehat{Y}'
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
    'Mittlere Distanz zwischen empirischer und simulierter Reihe.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.563'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='E_T'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{D}_{\\mathrm{sim}}',
    'Simulationsdokumentation',
    'Vollständiger Dokumentationsvektor eines Simulationslaufs.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.564'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{D}_{\\mathrm{sim}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\operatorname{Enc}',
    'Technische Zustandskodierung',
    'Kodierung eines mathematischen Zustands in eine technische Repräsentation.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.565'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\operatorname{Enc}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\operatorname{Dec}',
    'Technische Zustandsdekodierung',
    'Rückübersetzung einer technischen Repräsentation in den mathematischen Zustand.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.566'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\operatorname{Dec}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\operatorname{Dec}\\circ\\operatorname{Enc}',
    'Verlustfreie Repräsentation',
    'Bedingung einer verlustfreien technischen Zustandsdarstellung.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.567'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\operatorname{Dec}\\circ\\operatorname{Enc}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{S}_{\\mathrm{FRZK}}',
    'Funktionen der FRZK-Simulation',
    'Vereinigung von Implementierungsprüfung, dynamischer Exploration und empirischer Prognose.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.568'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{S}_{\\mathrm{FRZK}}'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{G}(R)',
    'Gültigkeitsbereich eines Simulationsbefunds',
    'Gültigkeitsbereich eines Befunds aus Anfangszuständen, Parameterraum, Zeithorizont und Implementierung.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.569'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{G}(R)'
  );

INSERT INTO equation_symbols
(
    equation_id,symbol_latex,symbol_name,definition_text,
    unit_text,domain_text,symbol_order
)
SELECT
    e.equation_id,
    '\\mathcal{T}',
    'Zyklischer wissenschaftlicher Prüfprozess',
    'Rückgekoppelter Prozess von Theorie, Modellbildung, Simulation, Auswertung und Kritik.',
    NULL,
    'Abschnitt 3.9.5',
    1
FROM equations e
WHERE e.equation_number='3.570'
  AND NOT EXISTS
  (
      SELECT 1 FROM equation_symbols es
      WHERE es.equation_id=e.equation_id
        AND es.symbol_latex='\\mathcal{T}'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Selbstorganisation und emergente Ordnungsbildung als Grundlage simulierter Systementwicklung.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [12].',
    @revision_id
FROM sources s
WHERE s.citation_number=12
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Komplexe adaptive Systeme und die Untersuchung emergenter Dynamiken.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [14].',
    @revision_id
FROM sources s
WHERE s.citation_number=14
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Netzwerkdynamik und strukturelle Kopplung in komplexen Systemen.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [15].',
    @revision_id
FROM sources s
WHERE s.citation_number=15
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'method','Nichtlineare Dynamik, Attraktoren, Bifurkationen und Stabilitätsanalyse.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [37].',
    @revision_id
FROM sources s
WHERE s.citation_number=37
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'method','Zustandsabhängige Regelung und externe Eingriffe in dynamische Systeme.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [38].',
    @revision_id
FROM sources s
WHERE s.citation_number=38
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'method','Mathematische Stabilitätsprüfung nichtlinearer Systeme.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [39].',
    @revision_id
FROM sources s
WHERE s.citation_number=39
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'method','Numerische und qualitative Untersuchung dynamischer Systeme.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [40].',
    @revision_id
FROM sources s
WHERE s.citation_number=40
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Trajektorien, Attraktoren und qualitative Dynamik.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [43].',
    @revision_id
FROM sources s
WHERE s.citation_number=43
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Sensitivität gegenüber Anfangsbedingungen und chaotische Entwicklung.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [44].',
    @revision_id
FROM sources s
WHERE s.citation_number=44
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Kopplungsstruktur und Dynamik in Netzwerken.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [48].',
    @revision_id
FROM sources s
WHERE s.citation_number=48
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'method','Metrische Grundlagen für Zustands- und Ergebnisvergleiche.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [49].',
    @revision_id
FROM sources s
WHERE s.citation_number=49
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Selbstorganisation aus lokalen Interaktionen.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [51].',
    @revision_id
FROM sources s
WHERE s.citation_number=51
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO source_usage
(
    source_id,section_id,usage_type,claim_summary,exact_location,
    is_first_mention,citation_checked,notes,created_revision_id
)
SELECT
    s.source_id,@section_id,'background','Emergenz und Komplexität als systemische Entwicklungsformen.',
    'Abschnitt 3.9.5',0,1,
    'Wiederverwendung der vorhandenen Masterquelle [52].',
    @revision_id
FROM sources s
WHERE s.citation_number=52
  AND NOT EXISTS
  (
      SELECT 1 FROM source_usage su
      WHERE su.source_id=s.source_id
        AND su.section_id=@section_id
        AND su.exact_location='Abschnitt 3.9.5'
  );

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,@section_id,'created','section','3.9.5',
    'Abschnitt 3.9.5 als methodische Einordnung der Simulation im FRZK registriert.',
    NULL,'draft',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.9.5'
);

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,@section_id,'equation_added','equations','3.516-3.570',
    '55 Gleichungen zu Simulation, Verifikation, Validierung, Sensitivität, Robustheit, Reproduzierbarkeit und Gültigkeitsgrenzen registriert.',
    NULL,'55',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='3.516-3.570'
);

INSERT INTO section_change_log
(
    revision_id,section_id,change_type,object_type,object_reference,
    change_summary,previous_value,new_value,changed_at
)
SELECT
    @revision_id,@section_id,'source_reused','literature',
    '[12], [14], [15], [37]-[40], [43], [44], [48], [49], [51], [52]',
    'Vorhandene Masterquellen wurden mit Abschnitt 3.9.5 verknüpft.',
    NULL,
    CONCAT('',(
        SELECT COUNT(*) FROM source_usage
        WHERE section_id=@section_id
          AND exact_location='Abschnitt 3.9.5'
    )),
    NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_reused'
      AND object_reference='[12], [14], [15], [37]-[40], [43], [44], [48], [49], [51], [52]'
);

SET @equation_count :=
(
    SELECT COUNT(*) FROM equations
    WHERE section_id=@section_id
      AND equation_number IN
      (
       '3.516','3.517','3.518','3.519','3.520','3.521','3.522','3.523','3.524',
       '3.525','3.526','3.527','3.528','3.529','3.530','3.531','3.532','3.533',
       '3.534','3.535','3.536','3.537','3.538','3.539','3.540','3.541','3.542',
       '3.543','3.544','3.545','3.546','3.547','3.548','3.549','3.550','3.551',
       '3.552','3.553','3.554','3.555','3.556','3.557','3.558','3.559','3.560',
       '3.561','3.562','3.563','3.564','3.565','3.566','3.567','3.568','3.569',
       '3.570'
      )
);

SET @symbol_count :=
(
    SELECT COUNT(*)
    FROM equation_symbols es
    INNER JOIN equations e ON e.equation_id=es.equation_id
    WHERE e.section_id=@section_id
      AND e.equation_number>='3.516'
      AND e.equation_number<='3.570'
);

SET @missing_word_latex :=
(
    SELECT COUNT(*) FROM equations
    WHERE section_id=@section_id
      AND equation_number>='3.516'
      AND equation_number<='3.570'
      AND (word_latex IS NULL OR word_latex='')
);

SET @source_usage_count :=
(
    SELECT COUNT(*) FROM source_usage
    WHERE section_id=@section_id
      AND exact_location='Abschnitt 3.9.5'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_5_SECTION_EXISTS',
    CASE WHEN @section_id IS NOT NULL THEN 'passed' ELSE 'failed' END,
    '1',CASE WHEN @section_id IS NOT NULL THEN '1' ELSE '0' END,
    'Prüft, ob Abschnitt 3.9.5 vorhanden ist.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_5_SECTION_EXISTS'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_5_EQUATION_COUNT',
    CASE WHEN @equation_count=55 THEN 'passed' ELSE 'failed' END,
    '55',CONCAT('',@equation_count),
    'Prüft die Gleichungen 3.516 bis 3.570.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_5_EQUATION_COUNT'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_5_SYMBOL_COUNT',
    CASE WHEN @symbol_count>=55 THEN 'passed' ELSE 'warning' END,
    'mindestens 55',CONCAT('',@symbol_count),
    'Prüft mindestens einen registrierten Hauptsymbolbezug je Gleichung.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_5_SYMBOL_COUNT'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_5_WORD_LATEX',
    CASE WHEN @missing_word_latex=0 THEN 'passed' ELSE 'failed' END,
    '0',CONCAT('',@missing_word_latex),
    'Prüft fehlende Word-LaTeX-Einträge.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_5_WORD_LATEX'
);

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message,checked_at)
SELECT
    @revision_id,'K3_9_5_SOURCE_USAGE',
    CASE WHEN @source_usage_count>=1 THEN 'passed' ELSE 'warning' END,
    'mindestens 1',CONCAT('',@source_usage_count),
    'Prüft die Literaturverknüpfungen des Abschnitts.',NOW()
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_validation_results
    WHERE revision_id=@revision_id AND validation_code='K3_9_5_SOURCE_USAGE'
);

COMMIT;

SELECT section_code,title,status,is_original_contribution
FROM dissertation_sections
WHERE section_code='3.9.5';

SELECT @equation_count AS equation_count_3_9_5,
       @symbol_count AS symbol_count_3_9_5,
       @source_usage_count AS source_usage_count_3_9_5,
       @missing_word_latex AS missing_word_latex_3_9_5;

SELECT validation_code,validation_status,expected_value,actual_value
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_result_id;
