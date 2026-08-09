-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.28
-- Informationstheorie, Entropie und funktionale Informationsmaße
-- Definitionen 3.2.353–3.2.394
-- Sätze 3.2.79–3.2.90
-- Gleichungen (3.2441)–(3.2594)
-- Literatur [99]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.28-V1',NOW(),'section','3.2.28','3.2.28-v1',
'Abschnitt 3.2.28 mit Definitionen 3.2.353–3.2.394, Sätzen 3.2.79–3.2.90, Gleichungen 3.2441–3.2594 und Literatur [99].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.28-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.28-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.28',
'Informationstheorie, Entropie und funktionale Informationsmaße',
3,3.2280,'final',0,
'Selbstinformation, Shannon-Entropie, bedingte Entropie, gegenseitige Information, Divergenzen, Kanäle, Fisher-Information sowie informationstheoretische FRZK-Anschlussmaße.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.28' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.28' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Cover','Thomas M.','Cover, Thomas M.','Erster Autor der Quelle [99].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Cover, Thomas M.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Thomas','Joy A.','Thomas, Joy A.','Zweiter Autor der Quelle [99].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Thomas, Joy A.' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
99,'cover_thomas_elements_information_theory_2006','book',
'Elements of Information Theory',
2006,2006,'Wiley-Interscience','Hoboken, New Jersey','2nd edition',NULL,'en',1,'monograph',10,'verified','3.2.28',
'Erstnennung für Selbstinformation, Shannon-Entropie, bedingte Entropie, gegenseitige Information, relative Entropie, Datenverarbeitungsungleichung, Entropieraten, Kanalkapazität und differentielle Entropie.',
'Cover, Thomas M.; Thomas, Joy A.: Elements of Information Theory. 2nd edition. Hoboken, New Jersey: Wiley-Interscience, 2006.',
'Cover und Thomas, Elements of Information Theory [99]',
'Zentrale Referenz für die informationstheoretischen Grundlagen des Abschnitts.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=99
 OR source_key COLLATE utf8mb4_unicode_ci='cover_thomas_elements_information_theory_2006' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_97 := (SELECT source_id FROM sources WHERE citation_number=97 LIMIT 1);
SET @src_98 := (SELECT source_id FROM sources WHERE citation_number=98 LIMIT 1);
SET @src_99 := (SELECT source_id FROM sources WHERE citation_number=99 LIMIT 1);

SET @author_99_1 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Cover, Thomas M.' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @author_99_2 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Thomas, Joy A.' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_99,@author_99_1,1,'author'
WHERE @src_99 IS NOT NULL AND @author_99_1 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_99 AND author_id=@author_99_1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_99,@author_99_2,2,'author'
WHERE @src_99 IS NOT NULL AND @author_99_2 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_99 AND author_id=@author_99_2
);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_84,@src_97,@src_98,@src_99);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Kovarianzmatrizen, Determinanten und lineare Transformationen mehrdimensionaler Verteilungen.','3.2.28',0,1,'Wiederverwendung [84].',@revision),
(@src_97,@section,'background','Zusammenhang zwischen Beobachtungsinformation, Zustandsrekonstruktion und regularisierten inversen Problemen.','3.2.28',0,1,'Wiederverwendung [97].',@revision),
(@src_98,@section,'background','Zufallsvariablen, stochastische Prozesse und bedingte Zustandsentwicklungen.','3.2.28',0,1,'Wiederverwendung [98].',@revision),
(@src_99,@section,'first_citation','Selbstinformation, Entropie, gegenseitige Information, Divergenzen, Datenverarbeitung, Kodierung, Kanäle und differentielle Entropie.','3.2.28',1,1,'Erstnennung [99].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.353','Diskrete Informationsquelle','Diskrete Zufallsvariable mit endlichem oder abzählbarem Alphabet.','X:\\Omega\\rightarrow\\mathcal{X}',@src_99),
('3.2.354','Selbstinformation','Negativer Logarithmus der Wahrscheinlichkeit eines Ereignisses.','I(x)=-\\log_b p(x)',@src_99),
('3.2.355','Shannon-Entropie','Erwartungswert der Selbstinformation einer diskreten Zufallsvariable.','H(X)=-\\sum_{x\\in\\mathcal{X}}p(x)\\log_b p(x)',@src_99),
('3.2.356','Gemeinsame Entropie','Entropie der gemeinsamen Verteilung mehrerer Zufallsvariablen.','H(X,Y)=-\\sum_{x,y}p(x,y)\\log_b p(x,y)',@src_99),
('3.2.357','Bedingte Entropie','Verbleibende Unsicherheit einer Zufallsvariable unter Kenntnis einer anderen.','H(X\\mid Y)=-\\sum_{x,y}p(x,y)\\log_b p(x\\mid y)',@src_99),
('3.2.358','Gegenseitige Information','Reduktion der Unsicherheit einer Zufallsvariable durch Kenntnis einer anderen.','I(X;Y)=\\sum_{x,y}p(x,y)\\log_b\\frac{p(x,y)}{p(x)p(y)}',@src_99),
('3.2.359','Kullback-Leibler-Divergenz','Asymmetrisches informationsbezogenes Abweichungsmaß zweier Verteilungen.','D_{\\mathrm{KL}}(p\\|q)=\\sum_x p(x)\\log_b\\frac{p(x)}{q(x)}',@src_99),
('3.2.360','Kreuzentropie','Erwarteter negativer Logarithmus einer Modellverteilung unter einer Referenzverteilung.','H(p,q)=-\\sum_x p(x)\\log_b q(x)',@src_99),
('3.2.361','Jensen-Shannon-Divergenz','Symmetrische Divergenz auf Grundlage zweier Kullback-Leibler-Divergenzen zur Mischverteilung.','D_{\\mathrm{JS}}(p,q)=\\frac12D_{\\mathrm{KL}}(p\\|m)+\\frac12D_{\\mathrm{KL}}(q\\|m)',@src_99),
('3.2.362','Bedingte gegenseitige Information','Gegenseitige Information zweier Zufallsvariablen unter Kenntnis einer dritten.','I(X;Y\\mid Z)=H(X\\mid Z)-H(X\\mid Y,Z)',@src_99),
('3.2.363','Entropierate','Asymptotische Entropie pro Symbol eines stochastischen Prozesses.','\\overline{H}(X)=\\lim_{n\\rightarrow\\infty}\\frac1nH(X_1,\\ldots,X_n)',@src_99),
('3.2.364','Informationstheoretische Redundanz','Differenz zwischen maximal möglicher und tatsächlicher Entropie einer Quelle.','R_{\\mathrm{abs}}=\\log_b n-H(X)',@src_99),
('3.2.365','Präfixcode','Code, bei dem kein Codewort Präfix eines anderen Codewortes ist.','\\sum_{i=1}^{n}2^{-l_i}\\leq1',@src_99),
('3.2.366','Mittlere Codewortlänge','Wahrscheinlichkeitsgewichteter Mittelwert der Codewortlängen.','L=\\sum_{i=1}^{n}p_i l_i',@src_99),
('3.2.367','Diskreter gedächtnisloser Kanal','Informationskanal mit festen Übergangswahrscheinlichkeiten ohne Gedächtnis zwischen Kanalnutzungen.','p(x,y)=p(x)p(y\\mid x)',@src_99),
('3.2.368','Kanalkapazität','Maximal erreichbare gegenseitige Information eines Kanals über alle Eingangsverteilungen.','C=\\max_{p(x)}I(X;Y)',@src_99),
('3.2.369','Differentielle Entropie','Entropieähnliches Maß einer stetigen Zufallsvariable auf Grundlage ihrer Dichte.','h(X)=-\\int_{\\mathbb{R}}p_X(x)\\log_b p_X(x)\\,\\mathrm{d}x',@src_99),
('3.2.370','Differentielle gemeinsame Entropie','Differentielle Entropie einer gemeinsamen stetigen Verteilung.','h(X,Y)=-\\int\\int p(x,y)\\log_b p(x,y)\\,\\mathrm{d}x\\,\\mathrm{d}y',@src_99),
('3.2.371','Gegenseitige Information stetiger Zufallsvariablen','Integralbasierte gegenseitige Information stetiger Zufallsvariablen.','I(X;Y)=\\int\\int p(x,y)\\log_b\\frac{p(x,y)}{p_X(x)p_Y(y)}\\,\\mathrm{d}x\\,\\mathrm{d}y',@src_99),
('3.2.372','Beobachtungsinformationsgewinn','Gegenseitige Information zwischen unbekanntem Zustand und Beobachtung.','G(U;Y)=I(U;Y)',@src_99),
('3.2.373','Inkrementeller Informationsgewinn','Zusätzliche Zustandsinformation einer neuen Beobachtung unter Kenntnis früherer Beobachtungen.','\\Delta I_k=I(U;Y_k\\mid Y_{1:k-1})',@src_99),
('3.2.374','Redundante Beobachtungsinformation','Überschneidung der von zwei Beobachtungen getragenen Zustandsinformation.','R_U(Y_1,Y_2)=I(U;Y_1)+I(U;Y_2)-I(U;Y_1,Y_2)',@src_99),
('3.2.375','Informationsverlust einer Verarbeitung','Differenz der Zustandsinformation vor und nach einer Verarbeitung.','L_U(Y\\rightarrow Z)=I(U;Y)-I(U;Z)',@src_99),
('3.2.376','Information-Bottleneck-Funktional','Zielfunktion zum Ausgleich zwischen Kompression und relevanter Information.','\\mathcal{L}_{\\mathrm{IB}}=I(X;Z)-\\beta I(Z;Y)',@src_99),
('3.2.377','Lokale Informationsänderung','Quadratische lokale Näherung der Kullback-Leibler-Divergenz in einem Parameterraum.','D_{\\mathrm{KL}}(p_\\theta\\|p_{\\theta+\\mathrm{d}\\theta})\\approx\\frac12\\mathrm{d}\\theta^{\\mathsf{T}}\\mathcal{I}(\\theta)\\mathrm{d}\\theta',@src_99),
('3.2.378','Fisher-Informationsmatrix','Erwartetes äußeres Produkt der Ableitungen der Log-Likelihood nach den Modellparametern.','\\mathcal{I}_{ij}(\\theta)=\\mathbb{E}_{\\theta}\\left[\\frac{\\partial\\log p(X\\mid\\theta)}{\\partial\\theta_i}\\frac{\\partial\\log p(X\\mid\\theta)}{\\partial\\theta_j}\\right]',@src_99),
('3.2.379','FRZK-Zustandsentropie','Shannon-Entropie einer diskreten FRZK-Zustandsverteilung.','H_{\\mathrm{FRZK}}(U)=-\\sum_{u\\in\\mathcal{U}}p(u)\\log_b p(u)',@src_99),
('3.2.380','FRZK-Beobachtungsentropie','Shannon-Entropie der Verteilung einer FRZK-Beobachtung.','H_{\\mathrm{obs}}(Y)=-\\sum_y p(y)\\log_b p(y)',@src_99),
('3.2.381','FRZK-Zustandsinformation','Reduktion der FRZK-Zustandsentropie durch eine Beobachtung.','I_{\\mathrm{FRZK}}(U;Y)=H_{\\mathrm{FRZK}}(U)-H_{\\mathrm{FRZK}}(U\\mid Y)',@src_99),
('3.2.382','Paarweise informationelle Kopplung','Gegenseitige Information zweier FRZK-Zustandskomponenten.','K_{ij}^{I}=I(U_i;U_j)',@src_99),
('3.2.383','Normierte informationelle Kopplung','Normierte gegenseitige Information zweier Zustandskomponenten.','\\widetilde{K}_{ij}^{I}=\\frac{I(U_i;U_j)}{\\sqrt{H(U_i)H(U_j)}}',@src_99),
('3.2.384','Informationelle Kopplungsmatrix','Matrix der paarweisen gegenseitigen Informationen eines Zustandsvektors.','K^{I}=(I(U_i;U_j))_{i,j=1}^{n}',@src_99),
('3.2.385','Zeitversetzte gegenseitige Information','Gegenseitige Information zweier Prozesse bei einer vorgegebenen Zeitverschiebung.','I_{\\tau}(X;Y)=I(X_t;Y_{t+\\tau})',@src_99),
('3.2.386','Transferentropie','Bedingte zeitversetzte gegenseitige Information zur Beschreibung gerichteter statistischer Abhängigkeit.','T_{X\\rightarrow Y}=I(X_t;Y_{t+1}\\mid Y_t)',@src_99),
('3.2.387','FRZK-Informationstransfer','Bedingte zeitversetzte gegenseitige Information zwischen zwei FRZK-Zustandskomponenten.','T_{i\\rightarrow j}^{\\mathrm{FRZK}}=I(U_i(t);U_j(t+\\Delta t)\\mid U_j(t))',@src_99),
('3.2.388','Informationsretention eines Operators','Anteil der Zustandsentropie, der in der Operatorausgabe erhalten bleibt.','R_I(\\mathcal{O};U)=\\frac{I(U;\\mathcal{O}(U))}{H(U)}',@src_99),
('3.2.389','Informationsverlust eines FRZK-Operators','Differenz zwischen Zustandsentropie und in der Operatorausgabe erhaltener Zustandsinformation.','L_I(\\mathcal{O};U)=H(U)-I(U;\\mathcal{O}(U))',@src_99),
('3.2.390','Informationelle Rekonstruktionsgüte','Normierte gegenseitige Information zwischen wahrem und rekonstruiertem Zustand.','Q_I=\\frac{I(U;\\widehat{U})}{H(U)}',@src_99),
('3.2.391','Entropiebasierte Zustandskonzentration','Normierte Ergänzung der Zustandsentropie relativ zur maximalen Entropie.','C_H(U)=1-\\frac{H(U)}{\\log_b n}',@src_99),
('3.2.392','Informationsoptimale Beobachtung','Beobachtungsoperator mit maximaler gegenseitiger Information über den unbekannten Zustand.','\\mathcal{H}^{\\ast}=\\operatorname*{arg\\,max}_{\\mathcal{H}\\in\\mathfrak{H}}I(U;Y_{\\mathcal{H}})',@src_99),
('3.2.393','Erwarteter Informationsgewinn','Erwartete Kullback-Leibler-Divergenz zwischen posteriorer und priorer Zustandsverteilung.','\\operatorname{EIG}=\\mathbb{E}_{Y}\\left[D_{\\mathrm{KL}}(p(U\\mid Y)\\|p(U))\\right]',@src_99),
('3.2.394','Informationelle Modellabweichung','Divergenz zwischen empirischer Beobachtungsverteilung und Modellverteilung.','E_{\\mathrm{info}}=D_{\\mathrm{KL}}(p_{\\mathrm{obs}}\\|p_{\\mathrm{mod}})',@src_99);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.28.',
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
('3.2.79','Additivität der Selbstinformation unabhängiger Ereignisse','Die Selbstinformation unabhängiger gemeinsamer Ereignisse ist additiv.','I(x,y)=I(x)+I(y)','Die Ereignisse sind unabhängig.',@src_99),
('3.2.80','Nichtnegativität der Shannon-Entropie','Die Shannon-Entropie einer diskreten Zufallsvariable ist nichtnegativ.','H(X)\\geq0','Diskrete Zufallsvariable.',@src_99),
('3.2.81','Maximale Entropie einer endlichen diskreten Verteilung','Bei festem endlichem Alphabet wird die maximale Entropie durch die Gleichverteilung erreicht.','H(X)\\leq\\log_b n','Endliches Alphabet mit n Symbolen.',@src_99),
('3.2.82','Kettenregel der Entropie','Die gemeinsame Entropie zerfällt in marginale und bedingte Entropie.','H(X,Y)=H(Y)+H(X\\mid Y)','Diskrete Zufallsvariablen.',@src_99),
('3.2.83','Information kann Unsicherheit nicht erhöhen','Bedingte Entropie ist nicht größer als unbedingte Entropie.','H(X\\mid Y)\\leq H(X)','Diskrete Zufallsvariablen.',@src_99),
('3.2.84','Nichtnegativität der gegenseitigen Information','Die gegenseitige Information zweier Zufallsvariablen ist nichtnegativ.','I(X;Y)\\geq0','Gemeinsame Verteilung ist definiert.',@src_99),
('3.2.85','Gibbs-Ungleichung','Die Kullback-Leibler-Divergenz ist nichtnegativ.','D_{\\mathrm{KL}}(p\\|q)\\geq0','p ist absolut stetig bezüglich q.',@src_99),
('3.2.86','Datenverarbeitungsungleichung','Eine nachgelagerte Verarbeitung kann die gegenseitige Information über den Ausgangszustand nicht erhöhen.','X\\rightarrow Y\\rightarrow Z\\Longrightarrow I(X;Z)\\leq I(X;Y)','X, Y und Z bilden eine Markov-Kette.',@src_99),
('3.2.87','Untere Schranke der mittleren Codewortlänge','Die mittlere Codewortlänge eines eindeutig decodierbaren binären Codes ist mindestens so groß wie die Entropie.','L\\geq H(X)','Eindeutig decodierbarer binärer Code.',@src_99),
('3.2.88','Differentielle Entropie einer eindimensionalen Normalverteilung','Die differentielle Entropie einer Normalverteilung hängt nur von ihrer Varianz ab.','h(X)=\\frac12\\log(2\\pi e\\sigma^2)','X ist normalverteilt und der natürliche Logarithmus wird verwendet.',@src_99),
('3.2.89','Maximale differentielle Entropie bei gegebener Varianz','Unter allen stetigen Verteilungen mit festem Mittelwert und fester Varianz maximiert die Normalverteilung die differentielle Entropie.','h(X)\\leq\\frac12\\log(2\\pi e\\sigma^2)','Fester Erwartungswert und feste endliche Varianz.',@src_99),
('3.2.90','Cramér-Rao-Schranke','Die Varianz eines unverzerrten Schätzers ist nach unten durch den Kehrwert der Fisher-Information beschränkt.','\\operatorname{Var}(\\widehat{\\theta})\\geq\\frac{1}{\\mathcal{I}(\\theta)}','Unverzerrter Schätzer und geeignete Regularitätsbedingungen.',@src_99);

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
 SELECT 2441
 UNION ALL
 SELECT n+1 FROM seq WHERE n<2594
)
SELECT n FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.28}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.28}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.28.'),
'other','adapted',@src_99,
'Im Abschnitt 3.2.28 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.28.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.28 mit Definitionen 3.2.353–3.2.394, Sätzen 3.2.79–3.2.90, Gleichungen 3.2441–3.2594 und Literatur [99] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.29'),
('last_completed_section','3.2.28'),
('last_definition_number','3.2.394'),
('next_definition_number','3.2.395'),
('last_theorem_number','3.2.90'),
('next_theorem_number','3.2.91'),
('last_equation_number','3.2594'),
('next_equation_number','3.2595'),
('last_citation_number','99'),
('next_citation_number','100')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.28' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_28
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_28
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_28
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 2441 AND 2594;

SELECT COUNT(*) AS literaturverwendungen_3_2_28
FROM source_usage
WHERE section_id=@section;
