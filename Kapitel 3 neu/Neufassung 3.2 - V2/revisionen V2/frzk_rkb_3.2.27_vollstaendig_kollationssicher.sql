-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.27
-- Stochastische Prozesse, Zufallsfelder und Unsicherheitsfortpflanzung
-- Definitionen 3.2.289–3.2.352
-- Sätze 3.2.68–3.2.78
-- Gleichungen (3.2245)–(3.2440)
-- Literatur [98]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.27-V1',NOW(),'section','3.2.27','3.2.27-v1',
'Abschnitt 3.2.27 mit Definitionen 3.2.289–3.2.352, Sätzen 3.2.68–3.2.78, Gleichungen 3.2245–3.2440 und Literatur [98].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.27-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.27-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.27',
'Stochastische Prozesse, Zufallsfelder und Unsicherheitsfortpflanzung',
3,3.2270,'final',0,
'Wahrscheinlichkeitsräume, Zufallsvariablen, Prozesse, Wiener-Prozess, Itô-Kalkül, stochastische Differentialgleichungen, Zufallsfelder, Monte-Carlo-Verfahren, Sensitivität und stochastische FRZK-Zustände.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.27' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.27' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Øksendal','Bernt','Øksendal, Bernt','Autor der Quelle [98].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Øksendal, Bernt' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
98,'oksendal_stochastic_differential_equations_2003','book',
'Stochastic Differential Equations: An Introduction with Applications',
2003,2003,'Springer','Berlin, Heidelberg','6th edition',NULL,'en',1,'monograph',10,'verified','3.2.27',
'Erstnennung für Wahrscheinlichkeitsräume, stochastische Prozesse, Wiener-Prozess, Itô-Integral, Itô-Formel und stochastische Differentialgleichungen.',
'Øksendal, Bernt: Stochastic Differential Equations: An Introduction with Applications. 6th edition. Berlin, Heidelberg: Springer, 2003.',
'Øksendal, Stochastic Differential Equations [98]',
'Zentrale Referenz für stochastische Prozesse und stochastische Differentialgleichungen.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=98
 OR source_key COLLATE utf8mb4_unicode_ci='oksendal_stochastic_differential_equations_2003' COLLATE utf8mb4_unicode_ci
);

SET @src_91 := (SELECT source_id FROM sources WHERE citation_number=91 LIMIT 1);
SET @src_95 := (SELECT source_id FROM sources WHERE citation_number=95 LIMIT 1);
SET @src_97 := (SELECT source_id FROM sources WHERE citation_number=97 LIMIT 1);
SET @src_98 := (SELECT source_id FROM sources WHERE citation_number=98 LIMIT 1);

SET @author_98 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Øksendal, Bernt' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_98,@author_98,1,'author'
WHERE @src_98 IS NOT NULL AND @author_98 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_98 AND author_id=@author_98
);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_91,@src_95,@src_97,@src_98);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_91,@section,'background','Verbindung von Zustandsdichten, Diffusionsprozessen und partiellen Differentialgleichungen.','3.2.27',0,1,'Wiederverwendung [91].',@revision),
(@src_95,@section,'background','Distributionelle Interpretation idealisierten weißen Rauschens.','3.2.27',0,1,'Wiederverwendung [95].',@revision),
(@src_97,@section,'background','Verbindung von Zustandsunsicherheit, Beobachtungsfehlern und regularisierter Rekonstruktion.','3.2.27',0,1,'Wiederverwendung [97].',@revision),
(@src_98,@section,'first_citation','Wahrscheinlichkeitsräume, stochastische Prozesse, Wiener-Prozesse, Itô-Integrale, Itô-Formel und stochastische Differentialgleichungen.','3.2.27',1,1,'Erstnennung [98].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.289','Wahrscheinlichkeitsraum','Tripel aus Ergebnismenge, Sigma-Algebra und Wahrscheinlichkeitsmaß.','(\\Omega,\\mathcal{A},\\mathbb{P})',@src_98),
('3.2.290','Ereignis','Messbare Teilmenge des Ergebnisraums.','A\\in\\mathcal{A}',@src_98),
('3.2.291','Reelle Zufallsvariable','Messbare Abbildung vom Ergebnisraum in die reellen Zahlen.','X:\\Omega\\rightarrow\\mathbb{R}',@src_98),
('3.2.292','Zufallsvektor','Messbare Abbildung vom Ergebnisraum in einen endlichdimensionalen reellen Vektorraum.','X:\\Omega\\rightarrow\\mathbb{R}^{n}',@src_98),
('3.2.293','Verteilungsfunktion','Wahrscheinlichkeit, dass eine Zufallsvariable einen gegebenen Wert nicht überschreitet.','F_X(x)=\\mathbb{P}(X\\leq x)',@src_98),
('3.2.294','Wahrscheinlichkeitsdichte','Nichtnegative Dichtefunktion einer absolut stetigen Verteilung.','F_X(x)=\\int_{-\\infty}^{x}p_X(\\xi)\\,\\mathrm{d}\\xi',@src_98),
('3.2.295','Erwartungswert','Wahrscheinlichkeitsgewichteter Mittelwert einer integrierbaren Zufallsvariable.','\\mathbb{E}[X]=\\int_{\\Omega}X(\\omega)\\,\\mathrm{d}\\mathbb{P}(\\omega)',@src_98),
('3.2.296','Varianz','Mittlere quadratische Abweichung einer Zufallsvariable von ihrem Erwartungswert.','\\operatorname{Var}(X)=\\mathbb{E}[(X-\\mathbb{E}[X])^2]',@src_98),
('3.2.297','Standardabweichung','Positive Quadratwurzel der Varianz.','\\sigma_X=\\sqrt{\\operatorname{Var}(X)}',@src_98),
('3.2.298','Kovarianz','Gemeinsame mittlere Abweichung zweier Zufallsvariablen von ihren Erwartungswerten.','\\operatorname{Cov}(X,Y)=\\mathbb{E}[(X-\\mathbb{E}[X])(Y-\\mathbb{E}[Y])]',@src_98),
('3.2.299','Korrelationskoeffizient','Normierte Kovarianz zweier Zufallsvariablen.','\\rho_{X,Y}=\\frac{\\operatorname{Cov}(X,Y)}{\\sigma_X\\sigma_Y}',@src_98),
('3.2.300','Kovarianzmatrix','Matrix aller paarweisen Kovarianzen eines Zufallsvektors.','C_X=\\mathbb{E}[(X-\\mathbb{E}[X])(X-\\mathbb{E}[X])^{\\mathsf{T}}]',@src_98),
('3.2.301','Bedingte Wahrscheinlichkeit','Wahrscheinlichkeit eines Ereignisses unter der Voraussetzung eines anderen Ereignisses.','\\mathbb{P}(A\\mid B)=\\frac{\\mathbb{P}(A\\cap B)}{\\mathbb{P}(B)}',@src_98),
('3.2.302','Bedingter Erwartungswert','Erwartungswert einer Zufallsvariable relativ zu einer Unter-Sigma-Algebra.','\\mathbb{E}[X\\mid\\mathcal{G}]',@src_98),
('3.2.303','Stochastischer Prozess','Familie von Zufallsvariablen auf einem gemeinsamen Wahrscheinlichkeitsraum.','\\{X_t\\}_{t\\in T}',@src_98),
('3.2.304','Realisierung eines stochastischen Prozesses','Für ein festes Ergebnis entstehender Pfad des Prozesses.','t\\longmapsto X_t(\\omega)',@src_98),
('3.2.305','Mittelwertfunktion','Zeitabhängiger Erwartungswert eines stochastischen Prozesses.','m_X(t)=\\mathbb{E}[X_t]',@src_98),
('3.2.306','Kovarianzfunktion','Kovarianz eines stochastischen Prozesses zwischen zwei Zeitpunkten.','C_X(s,t)=\\operatorname{Cov}(X_s,X_t)',@src_98),
('3.2.307','Autokorrelationsfunktion','Erwartungswert des Produkts zweier Prozesswerte.','R_X(s,t)=\\mathbb{E}[X_sX_t]',@src_98),
('3.2.308','Strenge Stationarität','Invarianz aller endlichdimensionalen Verteilungen gegenüber Zeitverschiebungen.','(X_{t_1},\\ldots,X_{t_n})\\overset{d}{=}(X_{t_1+h},\\ldots,X_{t_n+h})',@src_98),
('3.2.309','Schwache Stationarität','Konstanter Mittelwert und nur von der Zeitdifferenz abhängige Kovarianz.','m_X(t)=\\mu,\\quad C_X(s,t)=C_X(t-s)',@src_98),
('3.2.310','Inkrement eines Prozesses','Differenz zweier Prozesswerte zu verschiedenen Zeitpunkten.','\\Delta X_{s,t}=X_t-X_s',@src_98),
('3.2.311','Stationäre Inkremente','Inkremente, deren Verteilung nur von der Zeitdifferenz abhängt.','X_{t+h}-X_t\\ \\text{hängt in Verteilung nur von }h\\text{ ab}',@src_98),
('3.2.312','Unabhängige Inkremente','Unabhängigkeit von Prozesszuwächsen auf disjunkten Zeitintervallen.','X_{t_1}-X_{t_0},\\ldots,X_{t_n}-X_{t_{n-1}}\\ \\text{unabhängig}',@src_98),
('3.2.313','Markov-Prozess','Prozess, dessen zukünftige bedingte Verteilung bei bekanntem Gegenwartszustand nicht von der vollständigen Vergangenheit abhängt.','\\mathbb{P}(X_t\\in A\\mid\\mathcal{F}_s)=\\mathbb{P}(X_t\\in A\\mid X_s)',@src_98),
('3.2.314','Filtration','Wachsende Familie von Sigma-Algebren zur Darstellung verfügbarer Information.','\\mathcal{F}_s\\subseteq\\mathcal{F}_t\\quad\\text{für }s\\leq t',@src_98),
('3.2.315','Adaptierter Prozess','Prozess, dessen Wert zu jedem Zeitpunkt bezüglich der bis dahin verfügbaren Information messbar ist.','X_t\\ \\text{ist }\\mathcal{F}_t\\text{-messbar}',@src_98),
('3.2.316','Martingal','Adaptierter integrierbarer Prozess mit unverändertem bedingtem Erwartungswert.','\\mathbb{E}[M_t\\mid\\mathcal{F}_s]=M_s',@src_98),
('3.2.317','Standard-Wiener-Prozess','Stetiger Prozess mit Startwert null sowie unabhängigen normalverteilten stationären Inkrementen.','W_t-W_s\\sim\\mathcal{N}(0,t-s)',@src_98),
('3.2.318','Ideales weißes Rauschen','Mittelwertfreier verallgemeinerter Prozess mit deltaförmiger Kovarianz.','C_{\\xi}(t,s)=q\\delta(t-s)',@src_98),
('3.2.319','Itô-Integral','Stochastisches Integral als Grenzwert linksseitig ausgewerteter Zufallssummen.','\\int_0^T H_t\\,\\mathrm{d}W_t',@src_98),
('3.2.320','Itô-stochastische Differentialgleichung','Stochastische Entwicklungsgleichung mit Drift- und Diffusionsterm.','\\mathrm{d}X_t=a(X_t,t)\\,\\mathrm{d}t+b(X_t,t)\\,\\mathrm{d}W_t',@src_98),
('3.2.321','Driftkoeffizient','Deterministischer mittlerer Änderungsanteil einer stochastischen Differentialgleichung.','a:S\\times T\\rightarrow S',@src_98),
('3.2.322','Diffusionskoeffizient','Zustands- und zeitabhängige Stärke der stochastischen Anregung.','b:S\\times T\\rightarrow\\mathbb{R}^{n\\times m}',@src_98),
('3.2.323','Ornstein-Uhlenbeck-Prozess','Linear rückgekoppelter gaußscher Prozess mit additivem Wiener-Rauschen.','\\mathrm{d}X_t=\\theta(\\mu-X_t)\\,\\mathrm{d}t+\\sigma\\,\\mathrm{d}W_t',@src_98),
('3.2.324','Fokker-Planck-Gleichung','Partielle Differentialgleichung für die zeitliche Entwicklung der Wahrscheinlichkeitsdichte eines Diffusionsprozesses.','\\frac{\\partial p}{\\partial t}=-\\frac{\\partial}{\\partial x}(ap)+\\frac12\\frac{\\partial^2}{\\partial x^2}(b^2p)',@src_98),
('3.2.325','Zufallsfeld','Orts- oder raumzeitabhängige Familie von Zufallsvariablen.','X:D\\times\\Omega\\rightarrow\\mathbb{R}',@src_98),
('3.2.326','Mittelwertfeld','Ortsabhängiger Erwartungswert eines Zufallsfeldes.','m_X(x)=\\mathbb{E}[X(x)]',@src_98),
('3.2.327','Kovarianzkern','Kovarianz eines Zufallsfeldes zwischen zwei Positionen.','C_X(x,y)=\\operatorname{Cov}(X(x),X(y))',@src_98),
('3.2.328','Gaußsches Zufallsfeld','Zufallsfeld mit multivariat normalverteilten endlichdimensionalen Randverteilungen.','(X(x_1),\\ldots,X(x_n))^{\\mathsf{T}}\\ \\text{ist normalverteilt}',@src_98),
('3.2.329','Parametrische Unsicherheit','Unsicherheit, bei der Modellparameter als Zufallsgrößen beschrieben werden.','\\Theta\\sim p_{\\Theta}',@src_98),
('3.2.330','Zustandsunsicherheit','Unsicherheit, bei der der Modellzustand selbst eine Zufallsgröße ist.','U:\\Omega\\rightarrow X',@src_98),
('3.2.331','Unsicherheitsfortpflanzung','Bestimmung der Verteilung oder statistischen Eigenschaften einer Modellantwort aus unsicheren Eingängen.','Y=\\mathcal{M}(X)',@src_98),
('3.2.332','Monte-Carlo-Stichprobe','Unabhängige Stichproben aus einer Eingangsverteilung mit zugehörigen Modellausgaben.','Y^{(i)}=\\mathcal{M}(X^{(i)})',@src_98),
('3.2.333','Monte-Carlo-Schätzer des Erwartungswertes','Arithmetischer Mittelwert der simulierten Modellausgaben.','\\widehat{\\mu}_Y=\\frac1N\\sum_{i=1}^{N}Y^{(i)}',@src_98),
('3.2.334','Monte-Carlo-Schätzer der Varianz','Unverzerrte Stichprobenvarianz der simulierten Modellausgaben.','\\widehat{\\sigma}_Y^2=\\frac1{N-1}\\sum_{i=1}^{N}(Y^{(i)}-\\widehat{\\mu}_Y)^2',@src_98),
('3.2.335','Statistischer Stichprobenfehler','Näherungswert für den Standardfehler eines Monte-Carlo-Mittelwertes.','E_{\\mathrm{MC}}=\\frac{\\widehat{\\sigma}_Y}{\\sqrt{N}}',@src_98),
('3.2.336','Quantil','Schwellenwert einer Verteilung mit vorgegebener kumulierter Wahrscheinlichkeit.','F_X(q_p)=p',@src_98),
('3.2.337','Überschreitungswahrscheinlichkeit','Wahrscheinlichkeit, dass eine Zufallsvariable einen Schwellenwert überschreitet.','P_{\\mathrm{exc}}(c)=\\mathbb{P}(X>c)',@src_98),
('3.2.338','Lokale Sensitivität','Partielle Ableitung einer Modellantwort nach einem Eingangsparameter.','S_i=\\frac{\\partial f}{\\partial\\theta_i}',@src_98),
('3.2.339','Varianzbasierter Sensitivitätsindex erster Ordnung','Anteil der Ausgangsvarianz, der allein durch einen Eingang erklärt wird.','S_i=\\frac{\\operatorname{Var}(\\mathbb{E}[Y\\mid X_i])}{\\operatorname{Var}(Y)}',@src_98),
('3.2.340','Totaler Sensitivitätsindex','Gesamteinfluss eines Eingangs einschließlich aller Interaktionen.','S_{T_i}=1-\\frac{\\operatorname{Var}(\\mathbb{E}[Y\\mid X_{\\sim i}])}{\\operatorname{Var}(Y)}',@src_98),
('3.2.341','Aleatorische Unsicherheit','Im Modell als zufällig behandelte Variabilität.','X\\sim p_X',@src_98),
('3.2.342','Epistemische Unsicherheit','Unsicherheit infolge unvollständiger Kenntnis über Modell, Parameter oder Randbedingungen.','\\mathfrak{M}=\\{\\mathcal{M}_1,\\ldots,\\mathcal{M}_k\\}',@src_98),
('3.2.343','Gesamtunsicherheitsmodell','Gemeinsame Verteilung aller zufällig modellierten Eingangsgrößen.','p(X,\\Theta,\\mathcal{B},\\mathcal{N})',@src_98),
('3.2.344','Stochastischer FRZK-Zustand','FRZK-Zustand als wertiger stochastischer Prozess.','U=\\{U_t\\}_{t\\in T}',@src_98),
('3.2.345','Stochastische FRZK-Entwicklungsgleichung','Abstrakte FRZK-Zustandsentwicklung mit deterministischem und stochastischem Operatoranteil.','\\mathrm{d}U_t=\\mathcal{A}_{\\theta}(U_t,t)\\,\\mathrm{d}t+\\mathcal{B}_{\\eta}(U_t,t)\\,\\mathrm{d}W_t',@src_98),
('3.2.346','Erwartete FRZK-Kohärenz','Erwartungswert einer auf den stochastischen FRZK-Zustand angewendeten Kohärenzfunktion.','\\overline{K}(t)=\\mathbb{E}[K(U_t)]',@src_98),
('3.2.347','Kohärenzvarianz','Varianz einer auf den stochastischen FRZK-Zustand angewendeten Kohärenzfunktion.','V_K(t)=\\operatorname{Var}(K(U_t))',@src_98),
('3.2.348','Kohärenzunterschreitungswahrscheinlichkeit','Wahrscheinlichkeit einer Unterschreitung eines vorgegebenen Kohärenzschwellenwertes.','P_{\\mathrm{K},-}(t)=\\mathbb{P}(K(U_t)<K_{\\min})',@src_98),
('3.2.349','Stochastisches FRZK-Beobachtungsmodell','Beobachtungsmodell aus FRZK-Zustandsabbildung und Beobachtungsfehler.','Y_t=\\mathcal{H}_{\\phi}(U_t)+\\varepsilon_t',@src_98),
('3.2.350','Bedingte Zustandsprognose','Bedingter Erwartungswert eines zukünftigen Zustands bei aktueller Informationslage.','\\widehat{U}_{t+h\\mid t}=\\mathbb{E}[U_{t+h}\\mid\\mathcal{F}_t]',@src_98),
('3.2.351','Stochastische Zustandsfilterung','Fortlaufende Bestimmung der bedingten Zustandsverteilung aus Prozessmodell und Beobachtungen.','p(U_t\\mid Y_{0:t})',@src_98),
('3.2.352','FRZK-Gesamtunsicherheit','Strukturierte Zusammenführung von Zustands-, Parameter-, Operator- und Beobachtungsunsicherheit.','\\mathcal{U}_{\\mathrm{ges}}=\\mathcal{U}_{\\mathrm{Zustand}}\\oplus\\mathcal{U}_{\\mathrm{Parameter}}\\oplus\\mathcal{U}_{\\mathrm{Operator}}\\oplus\\mathcal{U}_{\\mathrm{Beobachtung}}',@src_98);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.27.',
'Etablierte Definition oder FRZK-Anschlussdefinition.','verified',@revision
FROM tmp_defs t
WHERE NOT EXISTS (
 SELECT 1 FROM definitions d
 WHERE d.definition_number COLLATE utf8mb4_unicode_ci=t.definition_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_thms(
 theorem_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 statement_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 statement_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 assumptions LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_thms VALUES
('3.2.68','Linearität des Erwartungswertes','Der Erwartungswert ist linear.','\\mathbb{E}[\\alpha X+\\beta Y]=\\alpha\\mathbb{E}[X]+\\beta\\mathbb{E}[Y]','X und Y integrierbar.',@src_98),
('3.2.69','Unabhängigkeit impliziert Unkorreliertheit','Unabhängige quadratisch integrierbare Zufallsvariablen besitzen Kovarianz null.','X\\perp Y\\Longrightarrow\\operatorname{Cov}(X,Y)=0','X und Y unabhängig und quadratisch integrierbar.',@src_98),
('3.2.70','Positive Semidefinitheit der Kovarianzmatrix','Jede Kovarianzmatrix ist symmetrisch und positiv semidefinit.','a^{\\mathsf{T}}C_Xa\\geq0','X besitzt endliche zweite Momente.',@src_98),
('3.2.71','Satz von Bayes','Bedingte Wahrscheinlichkeiten können über Likelihood, Prior und Evidenz umgeschrieben werden.','\\mathbb{P}(A\\mid B)=\\frac{\\mathbb{P}(B\\mid A)\\mathbb{P}(A)}{\\mathbb{P}(B)}','\\mathbb{P}(A)>0 und \\mathbb{P}(B)>0.',@src_98),
('3.2.72','Momente des Wiener-Prozesses','Der Standard-Wiener-Prozess besitzt Erwartungswert null, Varianz t und Kovarianz min(s,t).','\\mathbb{E}[W_t]=0,\\quad\\operatorname{Var}(W_t)=t,\\quad\\mathbb{E}[W_sW_t]=\\min(s,t)','W ist Standard-Wiener-Prozess.',@src_98),
('3.2.73','Itô-Isometrie','Das zweite Moment des Itô-Integrals entspricht dem Erwartungswert des Zeitintegrals des quadrierten Integranden.','\\mathbb{E}\\left[\\left(\\int_0^T H_t\\,\\mathrm{d}W_t\\right)^2\\right]=\\mathbb{E}\\left[\\int_0^T H_t^2\\,\\mathrm{d}t\\right]','H adaptiert und quadratisch integrierbar.',@src_98),
('3.2.74','Itô-Formel','Die stochastische Kettenregel enthält zusätzlich einen Term zweiter Ordnung.','\\mathrm{d}f(X_t,t)=\\left[f_t+a_tf_x+\\frac12b_t^2f_{xx}\\right]\\mathrm{d}t+b_tf_x\\,\\mathrm{d}W_t','f hinreichend glatt, X Itô-Prozess.',@src_98),
('3.2.75','Karhunen-Loève-Darstellung','Ein quadratisch integrierbares Zufallsfeld besitzt unter geeigneten Voraussetzungen eine orthogonale Eigenfunktionsdarstellung.','X(x,\\omega)=m_X(x)+\\sum_{k=1}^{\\infty}\\sqrt{\\lambda_k}\\xi_k(\\omega)\\phi_k(x)','Quadratische Integrierbarkeit sowie geeignete Kompaktheits- und Regularitätsvoraussetzungen.',@src_98),
('3.2.76','Kovarianzfortpflanzung durch eine lineare Abbildung','Die Kovarianz eines linear transformierten Zufallsvektors ist A C_X A transponiert.','C_Y=AC_XA^{\\mathsf{T}}','Y=AX+b und X besitzt endliche zweite Momente.',@src_98),
('3.2.77','Starkes Gesetz der großen Zahlen','Das Stichprobenmittel unabhängiger identisch verteilter Zufallsvariablen konvergiert fast sicher gegen den Erwartungswert.','\\frac1N\\sum_{i=1}^{N}Y^{(i)}\\rightarrow\\mathbb{E}[Y]\\quad\\text{fast sicher}','Unabhängig und identisch verteilt, endlicher Erwartungswert.',@src_98),
('3.2.78','Zentraler Grenzwertsatz','Das normierte Stichprobenmittel konvergiert in Verteilung gegen die Standardnormalverteilung.','\\sqrt{N}\\frac{\\widehat{\\mu}_Y-\\mu}{\\sigma}\\overset{d}{\\longrightarrow}\\mathcal{N}(0,1)','Unabhängig und identisch verteilt, endliche positive Varianz.',@src_98);

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT
t.theorem_number,@section,t.title,t.statement_text,t.statement_latex,t.statement_latex,
'literature',t.source_id,t.assumptions,'verified',@revision
FROM tmp_thms t
WHERE NOT EXISTS (
 SELECT 1 FROM theorems th
 WHERE th.theorem_number COLLATE utf8mb4_unicode_ci=t.theorem_number COLLATE utf8mb4_unicode_ci
);

CREATE TEMPORARY TABLE tmp_numbers(
 n INT PRIMARY KEY
) ENGINE=InnoDB;

INSERT INTO tmp_numbers(n)
WITH RECURSIVE seq(n) AS (
 SELECT 2245
 UNION ALL
 SELECT n+1 FROM seq WHERE n<2440
)
SELECT n FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.27}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.27}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.27.'),
'other','adapted',@src_98,
'Im Abschnitt 3.2.27 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.27.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.27 mit Definitionen 3.2.289–3.2.352, Sätzen 3.2.68–3.2.78, Gleichungen 3.2245–3.2440 und Literatur [98] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.28'),
('last_completed_section','3.2.27'),
('last_definition_number','3.2.352'),
('next_definition_number','3.2.353'),
('last_theorem_number','3.2.78'),
('next_theorem_number','3.2.79'),
('last_equation_number','3.2440'),
('next_equation_number','3.2441'),
('last_citation_number','98'),
('next_citation_number','99')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.27' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_27
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_27
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_27
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 2245 AND 2440;

SELECT COUNT(*) AS literaturverwendungen_3_2_27
FROM source_usage
WHERE section_id=@section;
