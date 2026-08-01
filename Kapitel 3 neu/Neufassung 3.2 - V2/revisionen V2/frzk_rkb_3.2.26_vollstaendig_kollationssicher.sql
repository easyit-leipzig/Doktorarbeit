-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.26
-- Inverse Probleme, Identifizierbarkeit und regularisierte Zustandsrekonstruktion
-- Definitionen 3.2.230–3.2.288
-- Sätze 3.2.60–3.2.67
-- Gleichungen (3.2000)–(3.2244)
-- Literatur [97]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.26-V1',NOW(),'section','3.2.26','3.2.26-v1',
'Abschnitt 3.2.26 mit Definitionen 3.2.230–3.2.288, Sätzen 3.2.60–3.2.67, Gleichungen 3.2000–3.2244 und Literatur [97].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.26-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.26-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.26',
'Inverse Probleme, Identifizierbarkeit und regularisierte Zustandsrekonstruktion',
3,3.2260,'final',0,
'Vorwärts- und inverse Probleme, Wohlgestelltheit, Identifizierbarkeit, SVD, Pseudoinverse, Tikhonov- und iterative Regularisierung, Parameterwahl, Bayesianische Inversion sowie FRZK-Rekonstruktionsmodelle.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.26' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.26' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Engl','Heinz W.','Engl, Heinz W.','Erster Autor der Quelle [97].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Engl, Heinz W.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Hanke','Martin','Hanke, Martin','Zweiter Autor der Quelle [97].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Hanke, Martin' COLLATE utf8mb4_unicode_ci
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Neubauer','Andreas','Neubauer, Andreas','Dritter Autor der Quelle [97].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Neubauer, Andreas' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
97,'engl_hanke_neubauer_regularization_inverse_problems_1996','book',
'Regularization of Inverse Problems',
1996,1996,'Kluwer Academic Publishers','Dordrecht',NULL,NULL,'en',1,'monograph',10,'verified','3.2.26',
'Erstnennung für schlecht gestellte inverse Probleme, Regularisierungsverfahren, Tikhonov-Regularisierung, iterative Regularisierung, Parameterwahl und Konvergenz.',
'Engl, Heinz W.; Hanke, Martin; Neubauer, Andreas: Regularization of Inverse Problems. Dordrecht: Kluwer Academic Publishers, 1996.',
'Engl, Hanke und Neubauer, Regularization of Inverse Problems [97]',
'Zentrale Referenz für inverse Probleme und Regularisierung.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=97
 OR source_key COLLATE utf8mb4_unicode_ci='engl_hanke_neubauer_regularization_inverse_problems_1996' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_94 := (SELECT source_id FROM sources WHERE citation_number=94 LIMIT 1);
SET @src_96 := (SELECT source_id FROM sources WHERE citation_number=96 LIMIT 1);
SET @src_97 := (SELECT source_id FROM sources WHERE citation_number=97 LIMIT 1);

SET @author_97_1 := (SELECT author_id FROM authors WHERE normalized_name COLLATE utf8mb4_unicode_ci='Engl, Heinz W.' COLLATE utf8mb4_unicode_ci LIMIT 1);
SET @author_97_2 := (SELECT author_id FROM authors WHERE normalized_name COLLATE utf8mb4_unicode_ci='Hanke, Martin' COLLATE utf8mb4_unicode_ci LIMIT 1);
SET @author_97_3 := (SELECT author_id FROM authors WHERE normalized_name COLLATE utf8mb4_unicode_ci='Neubauer, Andreas' COLLATE utf8mb4_unicode_ci LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_97,@author_97_1,1,'author'
WHERE @src_97 IS NOT NULL AND @author_97_1 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_97 AND author_id=@author_97_1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_97,@author_97_2,2,'author'
WHERE @src_97 IS NOT NULL AND @author_97_2 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_97 AND author_id=@author_97_2);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_97,@author_97_3,3,'author'
WHERE @src_97 IS NOT NULL AND @author_97_3 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_97 AND author_id=@author_97_3);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_84,@src_94,@src_96,@src_97);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Singulärwertzerlegung, Pseudoinverse, Konditionszahlen, Normalgleichungen und Kleinste-Quadrate-Probleme.','3.2.26',0,1,'Wiederverwendung [84].',@revision),
(@src_94,@section,'background','Sparsame Darstellungen und regularisierte Rekonstruktionen in transformierten Zustandsräumen.','3.2.26',0,1,'Wiederverwendung [94].',@revision),
(@src_96,@section,'background','Variationale Formulierung regularisierter Rekonstruktionsprobleme.','3.2.26',0,1,'Wiederverwendung [96].',@revision),
(@src_97,@section,'first_citation','Schlecht gestellte inverse Probleme, Regularisierungsverfahren, Tikhonov-Regularisierung, iterative Regularisierung, Parameterwahl und Konvergenz.','3.2.26',1,1,'Erstnennung [97].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.230','Vorwärtsoperator','Abbildung vom Zustandsraum in den Beobachtungsraum.','\\mathcal{F}:X\\rightarrow Y',@src_97),
('3.2.231','Vorwärtsproblem','Bestimmung der modellierten Beobachtung aus bekanntem Zustand und bekanntem Operator.','y=\\mathcal{F}(u)',@src_97),
('3.2.232','Inverses Problem','Bestimmung eines Zustands aus einer bekannten oder gemessenen Beobachtung.','\\mathcal{F}(u)=y',@src_97),
('3.2.233','Wohlgestelltes Problem nach Hadamard','Problem mit existenter, eindeutiger und stetig datenabhängiger Lösung.','\\text{Existenz, Eindeutigkeit und stetige Datenabhängigkeit}',@src_97),
('3.2.234','Schlecht gestelltes Problem','Problem, das mindestens eine Hadamard-Bedingung verletzt.','\\neg(\\text{Existenz}\\land\\text{Eindeutigkeit}\\land\\text{Stabilität})',@src_97),
('3.2.235','Gestörtes inverses Problem','Rekonstruktion eines Zustands aus fehlerbehafteten Beobachtungsdaten.','\\mathcal{F}(u^\\delta)\\approx y^\\delta',@src_97),
('3.2.236','Globale Identifizierbarkeit','Eindeutige Bestimmbarkeit eines Zustands auf der gesamten zulässigen Menge.','\\mathcal{F}(u_1)=\\mathcal{F}(u_2)\\Longrightarrow u_1=u_2',@src_97),
('3.2.237','Lokale Identifizierbarkeit','Eindeutige Bestimmbarkeit eines Zustands in einer Umgebung.','\\mathcal{F}(u)=\\mathcal{F}(u_\\ast)\\Longrightarrow u=u_\\ast\\text{ in einer Umgebung}',@src_97),
('3.2.238','Strukturelle Identifizierbarkeit','Eindeutige Bestimmbarkeit bei idealen, fehlerfreien und vollständigen Beobachtungen.','\\mathcal{F}(u_1)=\\mathcal{F}(u_2)\\Longrightarrow u_1=u_2',@src_97),
('3.2.239','Praktische Identifizierbarkeit','Hinreichend genaue Bestimmbarkeit unter realen, endlichen und verrauschten Beobachtungsbedingungen.','\\text{Identifizierbarkeit unter endlichen und verrauschten Daten}',@src_97),
('3.2.240','Beobachtungsäquivalenz','Äquivalenzrelation für Zustände mit identischer modellierter Beobachtung.','u_1\\sim_{\\mathcal{F}}u_2\\Longleftrightarrow\\mathcal{F}(u_1)=\\mathcal{F}(u_2)',@src_97),
('3.2.241','Unterbestimmtes inverses Problem','Diskretes Problem mit weniger Beobachtungsgleichungen als Unbekannten.','m<n',@src_97),
('3.2.242','Überbestimmtes inverses Problem','Diskretes Problem mit mehr Beobachtungsgleichungen als Unbekannten.','m>n',@src_97),
('3.2.243','Residuum','Differenz zwischen modellierter und beobachteter Größe.','r(x)=Ax-b',@src_97),
('3.2.244','Kleinste-Quadrate-Lösung','Zustand mit minimaler quadrierter Residualnorm.','x_{\\mathrm{LS}}=\\operatorname*{arg\\,min}_{x}\\|Ax-b\\|_2^2',@src_97),
('3.2.245','Singulärwert','Positiver Skalenwert einer Singulärwertzerlegung mit zugehörigen linken und rechten Singulärvektoren.','Av_i=\\sigma_i u_i',@src_97),
('3.2.246','Spektrale Konditionszahl','Verhältnis des größten zum kleinsten Singulärwert einer regulären Matrix.','\\kappa_2(A)=\\frac{\\sigma_{\\max}}{\\sigma_{\\min}}',@src_97),
('3.2.247','Moore-Penrose-Pseudoinverse','Über die Singulärwertzerlegung definierte verallgemeinerte Inverse.','A^+=V\\Sigma^+U^{\\mathsf{T}}',@src_97),
('3.2.248','Regularisierungsverfahren','Familie stabilisierender Rekonstruktionsoperatoren mit Konvergenz gegen eine ausgezeichnete Lösung.','R_{\\alpha(\\delta)}y^\\delta\\rightarrow u^\\dagger',@src_97),
('3.2.249','Regularisierungsparameter','Parameter zur Gewichtung von Datenanpassung und Stabilisierung.','\\alpha>0',@src_97),
('3.2.250','Allgemeines Tikhonov-Funktional','Summe aus Datenabweichung und gewichteter Regularisierung.','J_\\alpha(u)=\\|\\mathcal{F}(u)-y^\\delta\\|_Y^p+\\alpha R(u)',@src_97),
('3.2.251','Quadratische Tikhonov-Lösung','Minimierer eines quadratischen Daten- und Regularisierungsterms.','x_\\alpha^\\delta=\\operatorname*{arg\\,min}_{x}\\left[\\|Ax-b^\\delta\\|_2^2+\\alpha\\|Lx\\|_2^2\\right]',@src_97),
('3.2.252','Abgeschnittene Singulärwertzerlegung','Regularisierung durch Verwerfen von Singulärwertanteilen unterhalb einer Schwelle.','x_\\tau^\\delta=\\sum_{i:\\sigma_i\\geq\\tau}\\frac{u_i^{\\mathsf{T}}b^\\delta}{\\sigma_i}v_i',@src_97),
('3.2.253','Landweber-Iteration','Gradientenverfahren für lineare inverse Probleme.','x_{k+1}=x_k-\\omega A^{\\mathsf{T}}(Ax_k-b^\\delta)',@src_97),
('3.2.254','Iterative Regularisierung','Regularisierung, bei der die Iterationszahl als Regularisierungsparameter dient.','k=k(\\delta)',@src_97),
('3.2.255','Semi-Konvergenz','Zunächst fallender und später wieder wachsender Rekonstruktionsfehler eines iterativen Verfahrens.','\\|x_k-x^\\dagger\\|\\downarrow\\text{ und später }\\uparrow',@src_97),
('3.2.256','A-priori-Parameterwahl','Parameterwahl ausschließlich aus vorab bekannten Größen.','\\alpha=\\alpha(\\delta)',@src_97),
('3.2.257','A-posteriori-Parameterwahl','Parameterwahl unter Verwendung der beobachteten Daten oder berechneten Lösungen.','\\alpha=\\alpha(\\delta,y^\\delta)',@src_97),
('3.2.258','Morozov-Diskrepanzprinzip','Parameterwahl durch Anpassung des Residuums an die bekannte Fehlergröße.','\\|\\mathcal{F}(u_\\alpha^\\delta)-y^\\delta\\|_Y\\leq\\tau\\delta',@src_97),
('3.2.259','L-Kurven-Kriterium','Parameterwahl nahe einem Punkt großer Krümmung der doppelt logarithmischen L-Kurve.','\\left(\\log\\rho(\\alpha),\\log\\eta(\\alpha)\\right)',@src_97),
('3.2.260','Generalisierte Kreuzvalidierungsfunktion','Datenbasierte Parameterwahlfunktion für lineare regularisierte Probleme.','G(\\alpha)=\\frac{\\|(I-H_\\alpha)b^\\delta\\|_2^2}{[\\operatorname{tr}(I-H_\\alpha)]^2}',@src_97),
('3.2.261','Spektrale Quellbedingung','Regularitätsannahme über die Lage der exakten Lösung im Spektrum von A transponiert A.','x^\\dagger=(A^{\\mathsf{T}}A)^\\nu w',@src_97),
('3.2.262','Datenfehleranteil','Normdifferenz zwischen regularisierten Lösungen zu gestörten und exakten Daten.','E_{\\mathrm{Daten}}(\\alpha,\\delta)=\\|u_\\alpha^\\delta-u_\\alpha\\|',@src_97),
('3.2.263','Regularisierungsbias','Normdifferenz zwischen regularisierter und ausgezeichneter exakter Lösung.','E_{\\mathrm{Bias}}(\\alpha)=\\|u_\\alpha-u^\\dagger\\|',@src_97),
('3.2.264','Fréchet-Ableitung eines Vorwärtsoperators','Beschränkter linearer Operator, der einen nichtlinearen Vorwärtsoperator lokal approximiert.','\\mathcal{F}(u+h)=\\mathcal{F}(u)+\\mathcal{F}''(u)h+r(h)',@src_97),
('3.2.265','Regularisiertes Gauss-Newton-Verfahren','Iterative nichtlineare Rekonstruktion mit regularisiertem linearen Korrekturproblem.','h_k=\\operatorname*{arg\\,min}_{h}\\left[\\|\\mathcal{F}''(u_k)h-(y^\\delta-\\mathcal{F}(u_k))\\|_Y^2+\\alpha_k\\|Lh\\|_X^2\\right]',@src_97),
('3.2.266','Parameteridentifikationsproblem','Regularisierte Bestimmung eines Modellparametervektors aus Beobachtungsdaten.','\\theta^\\ast=\\operatorname*{arg\\,min}_{\\theta\\in\\Theta}\\left[\\|\\mathcal{F}(\\theta)-y^\\delta\\|_Y^2+\\alpha R(\\theta)\\right]',@src_97),
('3.2.267','Sensitivitätsmatrix','Matrix der partiellen Ableitungen der Beobachtungskomponenten nach den Modellparametern.','S_{ij}(\\theta)=\\frac{\\partial\\mathcal{F}_i(\\theta)}{\\partial\\theta_j}',@src_97),
('3.2.268','Lokale Parameterkonfundierung','Lineare oder nahezu lineare Abhängigkeit zweier Parametersensitivitäten.','s_i=cs_j',@src_97),
('3.2.269','Beobachtungsoperator eines dynamischen Systems','Abbildung von Anfangszustand und Parametern auf eine vollständige Beobachtungstrajektorie.','\\mathcal{O}:(x_0,\\theta)\\longmapsto y(\\cdot)',@src_97),
('3.2.270','Dynamische Identifizierbarkeit','Eindeutige Bestimmbarkeit von Anfangszustand und Parametern aus der Beobachtungstrajektorie.','\\mathcal{O}(x_{0,1},\\theta_1)=\\mathcal{O}(x_{0,2},\\theta_2)\\Longrightarrow(x_{0,1},\\theta_1)=(x_{0,2},\\theta_2)',@src_97),
('3.2.271','A-priori-Verteilung','Wahrscheinlichkeitsverteilung des unbekannten Zustands vor Einbeziehung aktueller Beobachtungen.','\\pi_{\\mathrm{prior}}(u)',@src_97),
('3.2.272','Likelihood-Funktion','Wahrscheinlichkeit der Beobachtung unter Voraussetzung eines Zustands.','\\pi(y\\mid u)',@src_97),
('3.2.273','A-posteriori-Verteilung','Nach Bayes aktualisierte Wahrscheinlichkeitsverteilung des Zustands.','\\pi(u\\mid y)\\propto\\pi(y\\mid u)\\pi_{\\mathrm{prior}}(u)',@src_97),
('3.2.274','MAP-Schätzer','Zustand mit maximaler A-posteriori-Dichte.','u_{\\mathrm{MAP}}=\\operatorname*{arg\\,max}_{u}\\pi(u\\mid y)',@src_97),
('3.2.275','Rekonstruktionsunsicherheit','Menge oder Verteilung der mit Daten und Modellannahmen vereinbaren Zustände.','\\mathcal{C}_{1-\\alpha}\\subset X',@src_97),
('3.2.276','Auflösungsmatrix','Abbildung des wahren auf den regularisiert rekonstruierten Zustand.','M_\\alpha=R_\\alpha A',@src_97),
('3.2.277','Datengetragener Zustandsanteil','Zustandsanteil, dessen Bestimmung überwiegend durch Beobachtungsdaten getragen wird.','\\sigma_i\\gg0',@src_97),
('3.2.278','Regularisierungsgetragener Zustandsanteil','Zustandsanteil, dessen Bestimmung wesentlich durch Regularisierung oder Vorwissen geprägt wird.','\\sigma_i\\approx0',@src_97),
('3.2.279','FRZK-Vorwärtsabbildung','Abbildung von FRZK-Zustand und Parametern auf eine modellierte Beobachtung.','\\mathcal{F}_{\\mathrm{FRZK}}:\\mathcal{U}\\times\\Theta\\rightarrow\\mathcal{Y}',@src_97),
('3.2.280','FRZK-Zustandsrekonstruktion','Minimierer eines regularisierten FRZK-Datenanpassungsfunktionals.','J_\\alpha(u)=D(\\mathcal{F}_{\\mathrm{FRZK}}(u,\\theta),y^\\delta)+\\alpha R(u)',@src_97),
('3.2.281','Gemeinsame Zustands- und Parameterrekonstruktion','Gekoppelte gleichzeitige Rekonstruktion von Zustand und Modellparametern.','(u^\\ast,\\theta^\\ast)=\\operatorname*{arg\\,min}_{u,\\theta}J(u,\\theta)',@src_97),
('3.2.282','Kopplungsregularisierte Rekonstruktion','Rekonstruktion mit Daten-, Glättungs- und Kopplungsanteil.','u_{\\alpha,\\beta}^{\\delta}=\\operatorname*{arg\\,min}_{u}\\left[D(\\mathcal{F}(u),y^\\delta)+\\alpha R_{\\mathrm{Glätte}}(u)+\\beta R_{\\mathrm{Kopplung}}(u)\\right]',@src_97),
('3.2.283','Zeitlich regularisierte Zustandsrekonstruktion','Rekonstruktion mit Datenanpassung und zeitlichem Regularisierungsanteil.','u_\\alpha^\\delta=\\operatorname*{arg\\,min}_{u}\\left[J_{\\mathrm{Daten}}(u)+\\alpha J_{\\mathrm{Zeit}}(u)\\right]',@src_97),
('3.2.284','Gesamtvariation','Integral der Norm des Gradienten als sprungerhaltende Regularisierungsgröße.','\\operatorname{TV}(u)=\\int_{\\Omega}\\|\\nabla u(x)\\|\\,\\mathrm{d}x',@src_97),
('3.2.285','Sparsitätsregularisierte Rekonstruktion','Rekonstruktion mit l1-Regularisierung der Darstellungskoeffizienten.','c_\\alpha^\\delta=\\operatorname*{arg\\,min}_{c}\\left[\\|\\mathcal{F}(\\Psi c)-y^\\delta\\|^2+\\alpha\\|c\\|_1\\right]',@src_97),
('3.2.286','Gesamtbeobachtungsabweichung','Summe aus Mess-, Modell- und Diskretisierungsfehler.','e_{\\mathrm{gesamt}}=e_{\\mathrm{Messung}}+e_{\\mathrm{Modell}}+e_{\\mathrm{Diskretisierung}}',@src_97),
('3.2.287','Rekonstruktionsresiduum','Differenz zwischen aus der Rekonstruktion modellierter und beobachteter Größe.','r_\\alpha^\\delta=\\mathcal{F}(u_\\alpha^\\delta)-y^\\delta',@src_97),
('3.2.288','Externe Rekonstruktionsvalidierung','Validierung anhand von Daten, die nicht zur Rekonstruktion verwendet wurden.','E_{\\mathrm{val}}=\\|\\mathcal{F}_{\\mathrm{val}}(u_\\alpha^\\delta)-y_{\\mathrm{val}}\\|',@src_97);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.26.',
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
('3.2.60','Instabilität eines unbeschränkten inversen Operators','Ein unbeschränkter inverser Operator führt zu fehlender stetiger Datenabhängigkeit.','\\|y_k\\|_Y\\rightarrow0\\ \\text{aber}\\ \\|A^{-1}y_k\\|_X\\not\\rightarrow0','A^{-1} ist auf dem Wertebereich unbeschränkt.',@src_97),
('3.2.61','Eindeutigkeit eines linearen inversen Problems','Ein lineares inverses Problem besitzt bei trivialem Nullraum höchstens eine Lösung.','\\ker(A)=\\{0\\}\\Longrightarrow\\text{höchstens eine Lösung von }Au=y','y liegt im Wertebereich von A.',@src_97),
('3.2.62','Charakterisierung der Kleinste-Quadrate-Lösung','Eine Kleinste-Quadrate-Lösung erfüllt die Normalgleichung.','A^{\\mathsf{T}}(Ax_{\\mathrm{LS}}-b)=0','Endlichdimensionales lineares Problem.',@src_97),
('3.2.63','Fehlerverstärkung durch kleine Singulärwerte','Kleine Singulärwerte verstärken Datenfehler in den zugehörigen Singulärvektorrichtungen.','x^\\delta-x=\\sum_{i=1}^{r}\\frac{u_i^{\\mathsf{T}}e}{\\sigma_i}v_i','Singulärwertzerlegung des linearen Operators.',@src_97),
('3.2.64','Minimalnormeigenschaft der Pseudoinversenlösung','Die Moore-Penrose-Lösung ist eine Kleinste-Quadrate-Lösung minimaler Norm.','x^+=A^+b','Endlichdimensionales lineares System.',@src_97),
('3.2.65','Eindeutigkeit der quadratischen Tikhonov-Lösung','Bei positivem Regularisierungsparameter und trivialer Schnittmenge der Nullräume ist die Tikhonov-Lösung eindeutig.','\\ker(A)\\cap\\ker(L)=\\{0\\}\\Longrightarrow A^{\\mathsf{T}}A+\\alpha L^{\\mathsf{T}}L\\text{ positiv definit}','lpha>0.',@src_97),
('3.2.66','Lokales Rang-Kriterium für Parameteridentifizierbarkeit','Voller Spaltenrang der Sensitivitätsmatrix unterscheidet infinitesimale Parameteränderungen lokal.','\\operatorname{rang}S(\\theta^\\ast)=p','Lokale linearisierte Analyse.',@src_97),
('3.2.67','Tikhonov-MAP-Entsprechung im gaußschen Fall','Bei gaußschem Fehler- und Prior-Modell entspricht der MAP-Schätzer einem quadratischen regularisierten Minimierer.','u_{\\mathrm{MAP}}=\\operatorname*{arg\\,min}_{u}\\left[-\\log\\pi(y\\mid u)-\\log\\pi_{\\mathrm{prior}}(u)\\right]','Gaußsches Beobachtungsmodell und gaußsche A-priori-Verteilung.',@src_97);

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
 SELECT 2000
 UNION ALL
 SELECT n+1 FROM seq WHERE n<2244
)
SELECT n FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.26}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.26}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.26.'),
'other','adapted',@src_97,
'Im Abschnitt 3.2.26 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.26.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.26 mit Definitionen 3.2.230–3.2.288, Sätzen 3.2.60–3.2.67, Gleichungen 3.2000–3.2244 und Literatur [97] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.27'),
('last_completed_section','3.2.26'),
('last_definition_number','3.2.288'),
('next_definition_number','3.2.289'),
('last_theorem_number','3.2.67'),
('next_theorem_number','3.2.68'),
('last_equation_number','3.2244'),
('next_equation_number','3.2245'),
('last_citation_number','97'),
('next_citation_number','98')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.26' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_26
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_26
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_26
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 2000 AND 2244;

SELECT COUNT(*) AS literaturverwendungen_3_2_26
FROM source_usage
WHERE section_id=@section;
