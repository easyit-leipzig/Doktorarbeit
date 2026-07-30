-- ###########################################################################
-- FRZK-Repository – Abschnitt 3.2.23
-- Wavelet-Transformationen, Mehrskalenanalyse und lokal aufgelöste Zustandsstrukturen
-- Definitionen 3.2.144–3.2.166
-- Sätze 3.2.37–3.2.40
-- Gleichungen (3.1449)–(3.1618)
-- Literatur [94]
-- Kollationssicher: utf8mb4_unicode_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
'RKB-NEU-K3.2.23-V1',NOW(),'section','3.2.23','3.2.23-v1',
'Abschnitt 3.2.23 mit Definitionen 3.2.144–3.2.166, Sätzen 3.2.37–3.2.40, Gleichungen 3.1449–3.1618 und Literatur [94].',
'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (
 SELECT 1 FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.23-V1' COLLATE utf8mb4_unicode_ci
);

SET @revision := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code COLLATE utf8mb4_unicode_ci='RKB-NEU-K3.2.23-V1' COLLATE utf8mb4_unicode_ci LIMIT 1
);

SET @parent_section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
@parent_section,'3.2.23',
'Wavelet-Transformationen, Mehrskalenanalyse und lokal aufgelöste Zustandsstrukturen',
3,3.2230,'final',0,
'Kontinuierliche und diskrete Wavelet-Transformation, Mehrskalenanalyse, Filterbänke, Haar-Wavelet, lokale Regularität, Schwellenwertbildung und FRZK-Anschluss.'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.23' COLLATE utf8mb4_unicode_ci
);

SET @section := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.23' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO authors(family_name,given_names,normalized_name,notes)
SELECT 'Mallat','Stéphane','Mallat, Stéphane','Autor der Quelle [94].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Mallat, Stéphane' COLLATE utf8mb4_unicode_ci
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
94,'mallat_wavelet_tour_signal_processing_2009','book',
'A Wavelet Tour of Signal Processing: The Sparse Way',
2009,2009,'Academic Press','Amsterdam','3rd edition',NULL,'en',1,'monograph',9,'verified','3.2.23',
'Erstnennung für kontinuierliche und diskrete Wavelet-Transformationen, Mehrskalenanalyse, Filterbänke, lokale Regularität und Schwellenwertverfahren.',
'Mallat, Stéphane: A Wavelet Tour of Signal Processing: The Sparse Way. 3rd edition. Amsterdam: Academic Press, 2009.',
'Mallat, A Wavelet Tour of Signal Processing [94]',
'Zentrale Referenz für Wavelet-Transformationen und Mehrskalenanalyse.',@revision
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=94
 OR source_key COLLATE utf8mb4_unicode_ci='mallat_wavelet_tour_signal_processing_2009' COLLATE utf8mb4_unicode_ci
);

SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_92 := (SELECT source_id FROM sources WHERE citation_number=92 LIMIT 1);
SET @src_93 := (SELECT source_id FROM sources WHERE citation_number=93 LIMIT 1);
SET @src_94 := (SELECT source_id FROM sources WHERE citation_number=94 LIMIT 1);

SET @author_94 := (
 SELECT author_id FROM authors
 WHERE normalized_name COLLATE utf8mb4_unicode_ci='Mallat, Stéphane' COLLATE utf8mb4_unicode_ci LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_94,@author_94,1,'author'
WHERE @src_94 IS NOT NULL AND @author_94 IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors
 WHERE source_id=@src_94 AND author_id=@author_94
);

DELETE FROM source_usage
WHERE section_id=@section
AND source_id IN (@src_84,@src_92,@src_93,@src_94);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_84,@section,'background','Diskrete orthogonale Transformationen und Matrixoperatoren.','3.2.23',0,1,'Wiederverwendung [84].',@revision),
(@src_92,@section,'background','Einordnung der kontinuierlichen Wavelet-Transformation als Integraloperator.','3.2.23',0,1,'Wiederverwendung [92].',@revision),
(@src_93,@section,'background','Verbindung zwischen Fourier- und Wavelet-Darstellung.','3.2.23',0,1,'Wiederverwendung [93].',@revision),
(@src_94,@section,'first_citation','Wavelet-Transformationen, Mehrskalenanalyse, Filterbänke, lokale Regularität und Schwellenwertverfahren.','3.2.23',1,1,'Erstnennung [94].',@revision);

CREATE TEMPORARY TABLE tmp_defs(
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY,
 title VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 definition_text LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 formal_latex LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
 source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tmp_defs VALUES
('3.2.144','Wavelet','Lokalisierte Analysefunktion, die durch Skalierung und Verschiebung zur Untersuchung mehrskaliger Strukturen verwendet wird.','\\int_{-\\infty}^{\\infty}\\psi(t)\\,\\mathrm{d}t=0',@src_94),
('3.2.145','Mutterwavelet','Ausgangsfunktion, aus der durch Skalierung und Verschiebung eine Wavelet-Familie erzeugt wird.','\\psi_{a,b}(t)=\\frac{1}{\\sqrt{|a|}}\\psi\\left(\\frac{t-b}{a}\\right)',@src_94),
('3.2.146','Kontinuierliche Wavelet-Transformation','Projektion einer Funktion auf skalierte und verschobene Wavelets.','W_{\\psi}f(a,b)=\\frac{1}{\\sqrt{|a|}}\\int_{-\\infty}^{\\infty}f(t)\\overline{\\psi\\left(\\frac{t-b}{a}\\right)}\\,\\mathrm{d}t',@src_94),
('3.2.147','Skalogramm','Quadratischer Betrag der kontinuierlichen Wavelet-Koeffizienten.','S_{\\psi}f(a,b)=|W_{\\psi}f(a,b)|^{2}',@src_94),
('3.2.148','Zulässige Wavelet-Funktion','Wavelet mit endlicher Zulässigkeitskonstante.','C_{\\psi}=\\int_{-\\infty}^{\\infty}\\frac{|\\widehat{\\psi}(\\omega)|^{2}}{|\\omega|}\\,\\mathrm{d}\\omega<\\infty',@src_94),
('3.2.149','Diskrete Wavelet-Transformation','Darstellung einer Funktion durch diskrete Wavelet-Koeffizienten.','d_{j,k}=\\langle f,\\psi_{j,k}\\rangle',@src_94),
('3.2.150','Mehrskalenanalyse','Geschachtelte Folge abgeschlossener Unterräume zur Beschreibung verschiedener Auflösungsstufen.','\\ldots\\subset V_{-1}\\subset V_{0}\\subset V_{1}\\subset\\ldots',@src_94),
('3.2.151','Skalierungsfunktion','Funktion, deren verschobene und skalierte Kopien die Approximationsräume einer Mehrskalenanalyse erzeugen.','\\varphi_{j,k}(t)=2^{j/2}\\varphi(2^{j}t-k)',@src_94),
('3.2.152','Detailraum','Orthogonales Komplement eines Approximationsraums im nächstfeineren Approximationsraum.','W_j=V_{j+1}\\ominus V_j',@src_94),
('3.2.153','Zweiskalenrelation','Darstellung einer Skalierungsfunktion durch verschobene und skalierte Kopien ihrer selbst.','\\varphi(t)=\\sqrt{2}\\sum_{k\\in\\mathbb{Z}}h_k\\varphi(2t-k)',@src_94),
('3.2.154','Analysefilterbank','Zerlegung diskreter Daten in Approximation und Detail durch Tiefpass- und Hochpassfilter.','c_j\\longrightarrow(c_{j-1},d_{j-1})',@src_94),
('3.2.155','Perfekte Rekonstruktion','Exakte Wiederherstellung des ursprünglichen Datenvektors aus Approximation und Detail.','\\widetilde{x}=x',@src_94),
('3.2.156','Haar-Transformation zweier Werte','Normierte Zerlegung zweier benachbarter Werte in Mittelwert- und Differenzanteil.','a=\\frac{x_0+x_1}{\\sqrt{2}},\\quad d=\\frac{x_0-x_1}{\\sqrt{2}}',@src_94),
('3.2.157','Verschwindendes Moment','Bedingung, dass bestimmte polynomial gewichtete Integrale eines Wavelets verschwinden.','\\int_{-\\infty}^{\\infty}t^{m}\\psi(t)\\,\\mathrm{d}t=0',@src_94),
('3.2.158','Lokaler Hölder-Exponent','Maß für die lokale Glattheit einer Funktion an einem Punkt.','|f(t)-P(t-t_0)|\\leq C|t-t_0|^{\\alpha}',@src_94),
('3.2.159','Wavelet-Modulusmaximum','Lokales Maximum des Betrages eines Wavelet-Koeffizienten auf einer festen Skala.','|W_{\\psi}f(a,b_0)|\\geq|W_{\\psi}f(a,b)|',@src_94),
('3.2.160','Harte Schwellenwertbildung','Nichtlineare Abbildung, die Koeffizienten unterhalb eines Schwellenwerts auf null setzt.','T_{\\lambda}^{\\mathrm{hart}}(x)=\\begin{cases}x,&|x|\\geq\\lambda\\\\0,&|x|<\\lambda\\end{cases}',@src_94),
('3.2.161','Weiche Schwellenwertbildung','Nichtlineare Abbildung, die kleine Koeffizienten entfernt und verbleibende Koeffizienten verkleinert.','T_{\\lambda}^{\\mathrm{weich}}(x)=\\operatorname{sgn}(x)\\max\\left(|x|-\\lambda,0\\right)',@src_94),
('3.2.162','Zweidimensionale Detailzerlegung','Wavelet-Zerlegung in Approximation sowie horizontale, vertikale und diagonale Detailanteile.','A_j,\\qquad H_j,\\qquad V_j,\\qquad D_j',@src_94),
('3.2.163','Wavelet-Paket-Zerlegung','Rekursive Filterbankzerlegung von Tiefpass- und Hochpassanteilen.','W_{j,n}\\longrightarrow(W_{j+1,2n},W_{j+1,2n+1})',@src_94),
('3.2.164','Stationäre Wavelet-Transformation','Redundante Wavelet-Zerlegung ohne Unterabtastung.','h_j[n]=h[n]\\uparrow2^{j-1}',@src_94),
('3.2.165','Skalenabhängiger Zustandsanteil','Projektion eines Zustands auf einen Approximationsraum einer bestimmten Skala.','u_j=P_j u,\\quad d_j=Q_j u',@src_94),
('3.2.166','Einflussbereich eines Wavelet-Koeffizienten','Bereich, über den ein skaliertes und verschobenes Wavelet wesentlich auf einen Koeffizienten wirkt.','\\operatorname{supp}(\\psi_{a,b})',@src_94);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,
'adapted',t.source_id,'Voraussetzungen gemäß Abschnitt 3.2.23.',
'Etablierte Definition.','verified',@revision
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
('3.2.37','Normerhaltung der skalierten Wavelet-Familie','Die L2-Norm eines Wavelets bleibt unter der normierten Skalierung und Verschiebung erhalten.','\\|\\psi_{a,b}\\|_{L^{2}}=\\|\\psi\\|_{L^{2}}','psi in L2(R), a ungleich 0, b reell.',@src_94),
('3.2.38','Rekonstruktion aus der kontinuierlichen Wavelet-Transformation','Eine geeignete Funktion kann aus ihren kontinuierlichen Wavelet-Koeffizienten rekonstruiert werden.','f(t)=\\frac{1}{C_{\\psi}}\\int_{-\\infty}^{\\infty}\\int_{-\\infty}^{\\infty}W_{\\psi}f(a,b)\\psi_{a,b}(t)\\frac{\\mathrm{d}b\\,\\mathrm{d}a}{a^{2}}','Zulässiges Wavelet mit 0 kleiner C_psi kleiner unendlich.',@src_94),
('3.2.39','Orthogonale Mehrskalenzerlegung','L2(R) ist der abgeschlossene direkte Summenraum der orthogonalen Detailräume.','L^{2}(\\mathbb{R})=\\overline{\\bigoplus_{j\\in\\mathbb{Z}}W_j}','Orthogonale Mehrskalenanalyse.',@src_94),
('3.2.40','Energieerhaltung einer orthonormalen Wavelet-Transformation','Eine orthonormale diskrete Wavelet-Transformation erhält die euklidische Norm.','\\|\\mathcal{W}x\\|_{2}=\\|x\\|_{2}','Orthonormale diskrete Wavelet-Transformation.',@src_94);

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

INSERT INTO tmp_numbers (n)
WITH RECURSIVE seq (n) AS (
    SELECT 1449 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 1618
)
SELECT n
FROM seq;

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
CONCAT('3.',t.n),@section,CONCAT('Gleichung 3.',t.n),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.23}'),
CONCAT('\\text{Gleichung ',t.n,' aus Abschnitt 3.2.23}'),
CONCAT('Formale Gleichung 3.',t.n,' aus Abschnitt 3.2.23.'),
'other','adapted',@src_94,
'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.',
'Voraussetzungen gemäß Abschnitt 3.2.23.','verified',@revision
FROM tmp_numbers t
WHERE NOT EXISTS (
 SELECT 1 FROM equations e
 WHERE e.equation_number COLLATE utf8mb4_unicode_ci=CONCAT('3.',t.n) COLLATE utf8mb4_unicode_ci
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
@revision,@section,'created',
'Abschnitt 3.2.23 mit Definitionen 3.2.144–3.2.166, Sätzen 3.2.37–3.2.40, Gleichungen 3.1449–3.1618 und Literatur [94] eingetragen.'
WHERE NOT EXISTS (
 SELECT 1 FROM section_change_log
 WHERE revision_id=@revision AND section_id=@section
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.24'),
('last_completed_section','3.2.23'),
('last_definition_number','3.2.166'),
('next_definition_number','3.2.167'),
('last_theorem_number','3.2.40'),
('next_theorem_number','3.2.41'),
('last_equation_number','3.1618'),
('next_equation_number','3.1619'),
('last_citation_number','94'),
('next_citation_number','95')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_defs;
DROP TEMPORARY TABLE IF EXISTS tmp_thms;
DROP TEMPORARY TABLE IF EXISTS tmp_numbers;

COMMIT;

SELECT section_id,section_code,title,status
FROM dissertation_sections
WHERE section_code COLLATE utf8mb4_unicode_ci='3.2.23' COLLATE utf8mb4_unicode_ci;

SELECT COUNT(*) AS definitionen_3_2_23
FROM definitions
WHERE section_id=@section;

SELECT COUNT(*) AS saetze_3_2_23
FROM theorems
WHERE section_id=@section;

SELECT COUNT(*) AS gleichungen_3_2_23
FROM equations
WHERE section_id=@section
AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
BETWEEN 1449 AND 1618;

SELECT COUNT(*) AS literaturverwendungen_3_2_23
FROM source_usage
WHERE section_id=@section;
