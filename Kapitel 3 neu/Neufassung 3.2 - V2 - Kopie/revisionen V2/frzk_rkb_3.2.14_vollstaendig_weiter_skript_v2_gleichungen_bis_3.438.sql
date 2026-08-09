-- ###########################################################################
-- FRZK-Repository – vollständiges Weiter-Skript zu Abschnitt 3.2.14
-- Allgemeine Matrixzerlegungen
-- Definitionen 3.2.40–3.2.43
-- Satz 3.2.11
-- Gleichungen (3.382)–(3.438)
-- Literatur: [74], [76], [82], neu [84]
-- Kollation temporärer Tabellen: utf8mb4_general_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.2.14-V2',NOW(),'section','3.2.14','3.2.14-v2',
       'Vollständige repositorygerechte Aufnahme von 3.2.14 einschließlich Literatur [74], [76], [82], [84], Definitionen 3.2.40–3.2.43, Satz 3.2.11 und Gleichungen 3.382–3.438.',
       'Olaf Thiele / ChatGPT',@parent_revision
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.14-V2');
SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.14-V2' LIMIT 1);

SET @parent_section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2' LIMIT 1);
INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @parent_section,'3.2.14','Allgemeine Matrixzerlegungen',3,3.2140,'final',0,
       'LU-, QR-, Cholesky- und Singulärwertzerlegung; Definitionen 3.2.40–3.2.43; Satz 3.2.11; Gleichungen (3.382)–(3.438); Literatur [74], [76], [82], [84].'
WHERE @parent_section IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.2.14');
SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.14' LIMIT 1);
UPDATE dissertation_sections SET title='Allgemeine Matrixzerlegungen',status='final',
 notes='LU-, QR-, Cholesky- und Singulärwertzerlegung; Definitionen 3.2.40–3.2.43; Satz 3.2.11; Gleichungen (3.382)–(3.438); Literatur [74], [76], [82], [84].'
WHERE section_id=@section;

-- Neue Quelle [84]
INSERT INTO authors (family_name,given_names,normalized_name,notes)
SELECT 'Golub','Gene H.','Golub, Gene H.','Autor der Quelle [84].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Golub, Gene H.');
INSERT INTO authors (family_name,given_names,normalized_name,notes)
SELECT 'Van Loan','Charles F.','Van Loan, Charles F.','Autor der Quelle [84].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Van Loan, Charles F.');

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 84,'golub_van_loan_matrix_computations_2013','book','Matrix Computations',1983,2013,
       'Johns Hopkins University Press','Baltimore','4th edition','978-1-4214-0794-4','en',1,'textbook',9,'verified','3.2.14',
       'Erstnennung als zentrale Referenz für numerische Matrixzerlegungen, Pivotisierung, QR-, Cholesky- und Singulärwertzerlegung.',
       'Golub, Gene H.; Van Loan, Charles F.: Matrix Computations. 4th edition. Baltimore: Johns Hopkins University Press, 2013.',
       'Golub/Van Loan, Matrix Computations [84]',
       'Zentrale Referenz für numerische lineare Algebra und Matrixzerlegungen.',@revision
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=84 OR source_key='golub_van_loan_matrix_computations_2013');

SET @src_71 := (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1);
SET @src_74 := (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1);
SET @src_76 := (SELECT source_id FROM sources WHERE citation_number=76 LIMIT 1);
SET @src_82 := (SELECT source_id FROM sources WHERE citation_number=82 LIMIT 1);
SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @author_golub := (SELECT author_id FROM authors WHERE normalized_name='Golub, Gene H.' LIMIT 1);
SET @author_vanloan := (SELECT author_id FROM authors WHERE normalized_name='Van Loan, Charles F.' LIMIT 1);
INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_84,@author_golub,1,'author' WHERE @src_84 IS NOT NULL AND @author_golub IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_84 AND author_id=@author_golub)
UNION ALL
SELECT @src_84,@author_vanloan,2,'author' WHERE @src_84 IS NOT NULL AND @author_vanloan IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@src_84 AND author_id=@author_vanloan);

-- Literaturverwendung
DELETE FROM source_usage WHERE section_id=@section AND source_id IN (@src_74,@src_76,@src_82,@src_84);
INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_74,@section,'background','Grundlagen und Anwendungen der LU-, QR- und Cholesky-Zerlegung sowie lineare Gleichungssysteme und Ausgleichsprobleme.','Abschnitt 3.2.14: LU-, QR- und Cholesky-Zerlegung',0,1,'Wiederverwendung der Quelle [74].',@revision),
(@src_76,@section,'background','Operatorentheoretische Einordnung orthogonaler Transformationen, Spektralstrukturen und der Singulärwertzerlegung.','Abschnitt 3.2.14: Einordnung der Zerlegungen und SVD',0,1,'Wiederverwendung der Quelle [76].',@revision),
(@src_82,@section,'background','Basisunabhängige Einordnung linearer Operatoren und ihrer Darstellungen durch Matrizenprodukte.','Abschnitt 3.2.14: allgemeine Matrixzerlegungen',0,1,'Wiederverwendung der Quelle [82].',@revision),
(@src_84,@section,'first_citation','Numerische Matrixzerlegungen, Pivotisierung, orthogonale Transformationen, Singulärwertzerlegung und Niedrigrangstrukturen.','Abschnitt 3.2.14 vollständig',1,1,'Erstnennung der Quelle [84].',@revision);

-- Definitionen
CREATE TEMPORARY TABLE tmp_3214_definitions (
 definition_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,
 title VARCHAR(500), definition_text LONGTEXT, formal_latex LONGTEXT, source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_3214_definitions VALUES
('3.2.40','Matrixzerlegung','Eine Matrixzerlegung ist eine Darstellung einer Matrix als Produkt oder Summe strukturell einfacherer Matrizen, die besondere Eigenschaften wie Dreiecksform, Orthogonalität, Diagonalform oder positive Definitheit besitzen.','A=A_1A_2\\cdots A_k\\quad\\text{oder}\\quad A=A_1+A_2+\\cdots+A_k',@src_84),
('3.2.41','LU-Zerlegung','Eine Darstellung A=LU heißt LU-Zerlegung, wenn L eine untere und U eine obere Dreiecksmatrix ist. Mit Pivotisierung wird allgemeiner PA=LU verwendet.','A=LU\\quad\\text{bzw.}\\quad PA=LU',@src_84),
('3.2.42','QR-Zerlegung','Eine Darstellung A=QR heißt QR-Zerlegung, wenn die Spalten von Q orthonormal sind und R eine obere Dreiecksmatrix ist.','A=QR,\\qquad Q^{\\mathsf T}Q=I_n',@src_84),
('3.2.43','Cholesky-Zerlegung','Ist A reell, symmetrisch und positiv definit, so heißt die eindeutige Darstellung A=LL^T mit unterer Dreiecksmatrix L und positiven Diagonalelementen Cholesky-Zerlegung.','A=LL^{\\mathsf T}',@src_84);
INSERT INTO definitions(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT t.definition_number,@section,t.title,t.definition_text,t.formal_latex,t.formal_latex,'adapted',t.source_id,
       'Reelle Matrizen mit den jeweils im Abschnitt angegebenen Strukturvoraussetzungen.',
       'Etablierte Definition der linearen beziehungsweise numerischen Algebra.','verified',@revision
FROM tmp_3214_definitions t
WHERE NOT EXISTS (SELECT 1 FROM definitions d WHERE d.definition_number COLLATE utf8mb4_general_ci=t.definition_number COLLATE utf8mb4_general_ci);
UPDATE definitions d JOIN tmp_3214_definitions t
 ON d.definition_number COLLATE utf8mb4_general_ci=t.definition_number COLLATE utf8mb4_general_ci
SET d.section_id=@section,d.title=t.title,d.definition_text=t.definition_text,d.formal_latex=t.formal_latex,d.word_latex=t.formal_latex,
 d.provenance='adapted',d.source_id=t.source_id,d.assumptions='Reelle Matrizen mit den jeweils im Abschnitt angegebenen Strukturvoraussetzungen.',
 d.notes='Etablierte Definition der linearen beziehungsweise numerischen Algebra.',d.validation_status='verified',d.created_revision_id=COALESCE(d.created_revision_id,@revision);

-- Satz 3.2.11
INSERT INTO theorems(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
SELECT '3.2.11',@section,'Existenz der Singulärwertzerlegung',
       'Für jede reelle Matrix A aus R^(m×n) existieren orthogonale Matrizen U und V sowie eine rechteckige Diagonalmatrix Sigma, sodass A=U Sigma V^T gilt.',
       'A=U\\Sigma V^{\\mathsf T}','A=U\\Sigma V^{\\mathsf T}','literature',@src_84,
       'A ist eine beliebige reelle m-mal-n-Matrix.','verified',@revision
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.2.11');
UPDATE theorems SET section_id=@section,title='Existenz der Singulärwertzerlegung',
 statement_text='Für jede reelle Matrix A aus R^(m×n) existieren orthogonale Matrizen U und V sowie eine rechteckige Diagonalmatrix Sigma, sodass A=U Sigma V^T gilt.',
 statement_latex='A=U\\Sigma V^{\\mathsf T}',word_latex='A=U\\Sigma V^{\\mathsf T}',provenance='literature',source_id=@src_84,
 assumptions='A ist eine beliebige reelle m-mal-n-Matrix.',validation_status='verified',created_revision_id=COALESCE(created_revision_id,@revision)
WHERE theorem_number='3.2.11';

-- Gleichungen
CREATE TEMPORARY TABLE tmp_3214_equations (
 equation_number VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci PRIMARY KEY,
 title VARCHAR(500), latex TEXT, equation_type VARCHAR(20), source_id BIGINT UNSIGNED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
INSERT INTO tmp_3214_equations VALUES
('3.382','Ausgangsmatrix','A\\in\\mathbb{R}^{m\\times n}','definition',@src_84),
('3.383','Produktzerlegung','A=A_1A_2\\cdots A_k','definition',@src_84),
('3.384','Summenzerlegung','A=A_1+A_2+\\cdots+A_k','definition',@src_84),
('3.385','Struktureigenschaften','\\text{Dreiecksform},\\qquad\\text{Orthogonalität},\\qquad\\text{Diagonalform}','other',@src_84),
('3.386','Positive Definitheit','\\text{positive Definitheit}','other',@src_84),
('3.387','Quadratische Matrix','A\\in\\mathbb{R}^{n\\times n}','definition',@src_84),
('3.388','LU-Zerlegung','A=LU','definition',@src_84),
('3.389','Untere Dreiecksmatrix','L=\\begin{pmatrix}l_{11}&0&\\cdots&0\\\\l_{21}&l_{22}&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\l_{n1}&l_{n2}&\\cdots&l_{nn} \\end{pmatrix}','definition',@src_84),
('3.390','Obere Dreiecksmatrix','U=\\begin{pmatrix}u_{11}&u_{12}&\\cdots&u_{1n}\\\\0&u_{22}&\\cdots&u_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&u_{nn} \\end{pmatrix}','definition',@src_84),
('3.391','Doolittle-Normierung','l_{ii}=1\\qquad(i=1,\\ldots,n)','definition',@src_84),
('3.392','LU-Zerlegung mit Permutation','PA=LU','definition',@src_84),
('3.393','Rücktransformation der LU-Zerlegung','A=P^{-1}LU','derived',@src_84),
('3.394','Inverse einer Permutationsmatrix','P^{-1}=P^{\\mathsf T}','theorem',@src_84),
('3.395','LU-Zerlegung mit transponierter Permutation','A=P^{\\mathsf T}LU','derived',@src_84),
('3.396','Lineares Gleichungssystem','Ax=b','other',@src_74),
('3.397','Eingesetzte LU-Zerlegung','A=LU','other',@src_84),
('3.398','Zerlegtes Gleichungssystem','LUx=b','derived',@src_84),
('3.399','Hilfsvariable','y=Ux','definition',@src_84),
('3.400','Unteres Dreieckssystem','Ly=b','derived',@src_84),
('3.401','Oberes Dreieckssystem','Ux=y','derived',@src_84),
('3.402','Mehrere rechte Seiten','Ax^{(j)}=b^{(j)}','other',@src_84),
('3.403','Rechteckige Ausgangsmatrix der QR-Zerlegung','A\\in\\mathbb{R}^{m\\times n}\\qquad\\text{mit}\\qquad m\\ge n','definition',@src_84),
('3.404','QR-Zerlegung','A=QR','definition',@src_84),
('3.405','Orthogonaler Faktor','Q\\in\\mathbb{R}^{m\\times n}','definition',@src_84),
('3.406','Oberer Dreiecksfaktor','R\\in\\mathbb{R}^{n\\times n}','definition',@src_84),
('3.407','Spaltenorthogonalität','Q^{\\mathsf T}Q=I_n','definition',@src_84),
('3.408','Vollständige Orthogonalität','QQ^{\\mathsf T}=I_n','derived',@src_84),
('3.409','Inverse der orthogonalen Matrix','Q^{-1}=Q^{\\mathsf T}','theorem',@src_84),
('3.410','Überbestimmtes Gleichungssystem','Ax\\approx b','other',@src_84),
('3.411','Euklidische Fehlernorm','\\|Ax-b\\|_2','metric',@src_84),
('3.412','QR-Zerlegung im Ausgleichsproblem','A=QR','other',@src_84),
('3.413','Fehlernorm nach Einsetzen','\\|Ax-b\\|_2=\\|QRx-b\\|_2','derived',@src_84),
('3.414','Norminvarianz unter orthogonaler Transformation','\\|QRx-b\\|_2=\\|Rx-Q^{\\mathsf T}b\\|_2','derived',@src_84),
('3.415','Quadratische Matrix der Cholesky-Zerlegung','A\\in\\mathbb{R}^{n\\times n}','definition',@src_84),
('3.416','Symmetriebedingung','A^{\\mathsf T}=A','definition',@src_84),
('3.417','Positive Definitheit','x^{\\mathsf T}Ax>0\\qquad\\text{für alle }x\\in\\mathbb{R}^n\\setminus\\{0\\}','definition',@src_84),
('3.418','Cholesky-Zerlegung','A=LL^{\\mathsf T}','definition',@src_84),
('3.419','Obere Cholesky-Form','A=R^{\\mathsf T}R','definition',@src_84),
('3.420','Beziehung der Dreiecksfaktoren','R=L^{\\mathsf T}','derived',@src_84),
('3.421','Beliebige reelle Matrix','A\\in\\mathbb{R}^{m\\times n}','theorem',@src_84),
('3.422','Linke orthogonale Matrix','U\\in\\mathbb{R}^{m\\times m}','theorem',@src_84),
('3.423','Rechte orthogonale Matrix','V\\in\\mathbb{R}^{n\\times n}','theorem',@src_84),
('3.424','Singulärwertmatrix','\\Sigma\\in\\mathbb{R}^{m\\times n}','theorem',@src_84),
('3.425','Singulärwertzerlegung','A=U\\Sigma V^{\\mathsf T}','theorem',@src_84),
('3.426','Orthogonalität von U','U^{\\mathsf T}U=I_m','theorem',@src_84),
('3.427','Orthogonalität von V','V^{\\mathsf T}V=I_n','theorem',@src_84),
('3.428','Geordnete Singulärwerte','\\sigma_1\\ge\\sigma_2\\ge\\cdots\\ge\\sigma_r>0','theorem',@src_84),
('3.429','Rang der Matrix','r=\\operatorname{rang}(A)','theorem',@src_84),
('3.430','Singulärwerte als Quadratwurzeln','\\sigma_i=\\sqrt{\\lambda_i\\left(A^{\\mathsf T}A\\right)}','theorem',@src_84),
('3.431','Reduzierte Singulärwertzerlegung','A=U_r\\Sigma_rV_r^{\\mathsf T}','theorem',@src_84),
('3.432','Rang-eins-Darstellung der Matrix','A=\\sum_{i=1}^{r}\\sigma_i u_i v_i^{\\mathsf T}','theorem',@src_84),
('3.433','Rang als Anzahl positiver Singulärwerte','\\operatorname{rang}(A)=\\#\\{i\\mid\\sigma_i>0\\}','theorem',@src_84),
('3.434','Bedingung für vollen Spaltenrang','\\sigma_n>0','theorem',@src_84),
('3.435','Bedingung der Rangreduktion','k<r','definition',@src_84),
('3.436','Rang-k-Approximation','A_k=\\sum_{i=1}^{k}\\sigma_i u_i v_i^{\\mathsf T}','definition',@src_84),
('3.437','Fehler der Rang-k-Approximation in Spektralnorm','\\|A-A_k\\|_2=\\sigma_{k+1}','theorem',@src_84),
('3.438','Fehler der Rang-k-Approximation in Frobeniusnorm','\\|A-A_k\\|_{\\mathrm F}=\\sqrt{\\sum_{i=k+1}^{r}\\sigma_i^2}','theorem',@src_84);
INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT t.equation_number,@section,t.title,t.latex,t.latex,CONCAT('Formale Gleichung ',t.equation_number,' aus Abschnitt 3.2.14.'),t.equation_type,'adapted',t.source_id,
       'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.',
       'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.','verified',@revision
FROM tmp_3214_equations t
WHERE NOT EXISTS (SELECT 1 FROM equations e WHERE e.equation_number COLLATE utf8mb4_general_ci=t.equation_number COLLATE utf8mb4_general_ci);
UPDATE equations e JOIN tmp_3214_equations t
 ON e.equation_number COLLATE utf8mb4_general_ci=t.equation_number COLLATE utf8mb4_general_ci
SET e.section_id=@section,e.title=t.title,e.equation_latex=t.latex,e.word_latex=t.latex,
 e.plain_description=CONCAT('Formale Gleichung ',e.equation_number,' aus Abschnitt 3.2.14.'),e.equation_type=t.equation_type,e.provenance='adapted',e.source_id=t.source_id,
 e.derivation='Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.',
 e.assumptions='Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.',e.validation_status='verified',e.created_revision_id=COALESCE(e.created_revision_id,@revision)
WHERE e.section_id=@section OR CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED) BETWEEN 382 AND 438;

-- Änderungsprotokoll
INSERT INTO section_change_log(revision_id,section_id,change_type,change_summary)
SELECT @revision,@section,'edited','Abschnitt 3.2.14 vollständig mit Literatur, vier Definitionen, Satz 3.2.11 und Gleichungen 3.382–3.438 eingetragen beziehungsweise korrigiert.'
WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section);

-- Zähler: Upsert statt vorausgesetzter Schlüssel
INSERT INTO repository_counters(counter_key,counter_value) VALUES
('current_section','3.2.15'),('last_completed_section','3.2.14'),('last_definition_number','3.2.43'),('next_definition_number','3.2.44'),
('last_theorem_number','3.2.11'),('next_theorem_number','3.2.12'),('last_equation_number','3.438'),('next_equation_number','3.439'),
('last_citation_number','84'),('next_citation_number','85')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_3214_definitions;
DROP TEMPORARY TABLE IF EXISTS tmp_3214_equations;
COMMIT;

-- Abschlusskontrolle
SELECT section_id,section_code,title,status,notes FROM dissertation_sections WHERE section_code='3.2.14';
SELECT COUNT(*) AS definitionen_3_2_14 FROM definitions WHERE section_id=@section AND definition_number IN ('3.2.40','3.2.41','3.2.42','3.2.43');
SELECT COUNT(*) AS saetze_3_2_14 FROM theorems WHERE section_id=@section AND theorem_number='3.2.11';
SELECT COUNT(*) AS gleichungen_3_2_14 FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 382 AND 438;
SELECT COUNT(*) AS literaturverwendungen_3_2_14 FROM source_usage WHERE section_id=@section AND citation_checked=1;
SELECT citation_number,short_citation_text,verification_status FROM sources WHERE citation_number IN (74,76,82,84) ORDER BY citation_number;
SELECT counter_key,counter_value FROM repository_counters WHERE counter_key IN
('current_section','last_completed_section','last_definition_number','next_definition_number','last_theorem_number','next_theorem_number','last_equation_number','next_equation_number','last_citation_number','next_citation_number') ORDER BY counter_key;
