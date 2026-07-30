-- ###########################################################################
-- FRZK-Repository – vollständiges Weiter-Skript zu Abschnitt 3.2.16
-- Pseudoinverse, Ausgleichslösungen und Regularisierung
-- Definitionen 3.2.51–3.2.56
-- Satz 3.2.13
-- Gleichungen (3.504)–(3.573)
-- Literatur: [74], [84], [85], neu [86], [87]
-- Reales Schema ohne proof_text
-- Kollation temporärer Tabellen: utf8mb4_general_ci
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;
START TRANSACTION;

SET @parent_revision := (SELECT MAX(revision_id) FROM repository_revisions);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
    'RKB-NEU-K3.2.16-V1',
    NOW(),
    'section',
    '3.2.16',
    '3.2.16-v1',
    'Vollständige repositorygerechte Aufnahme von 3.2.16 einschließlich Literatur [74], [84], [85], [86], [87], Definitionen 3.2.51–3.2.56, Satz 3.2.13 und Gleichungen 3.504–3.573.',
    'Olaf Thiele / ChatGPT',
    @parent_revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.16-V1'
);

SET @revision :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.16-V1'
    LIMIT 1
);

SET @parent_section :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2'
    LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
    @parent_section,
    '3.2.16',
    'Pseudoinverse, Ausgleichslösungen und Regularisierung',
    3,
    3.2160,
    'final',
    0,
    'Moore-Penrose-Pseudoinverse, Ausgleichslösungen, Normalgleichungen, Mindestnormlösung, Projektionsoperatoren, Tikhonov-Regularisierung und abgeschnittene Singulärwertzerlegung; Definitionen 3.2.51–3.2.56; Satz 3.2.13; Gleichungen (3.504)–(3.573); Literatur [74], [84], [85], [86], [87].'
WHERE @parent_section IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.2.16'
);

SET @section :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.2.16'
    LIMIT 1
);

UPDATE dissertation_sections
SET
    title='Pseudoinverse, Ausgleichslösungen und Regularisierung',
    status='final',
    notes='Moore-Penrose-Pseudoinverse, Ausgleichslösungen, Normalgleichungen, Mindestnormlösung, Projektionsoperatoren, Tikhonov-Regularisierung und abgeschnittene Singulärwertzerlegung; Definitionen 3.2.51–3.2.56; Satz 3.2.13; Gleichungen (3.504)–(3.573); Literatur [74], [84], [85], [86], [87].'
WHERE section_id=@section;

-- ---------------------------------------------------------------------------
-- Neue Autoren und Quellen [86], [87]
-- ---------------------------------------------------------------------------

INSERT INTO authors
(family_name,given_names,normalized_name,notes)
SELECT
    'Ben-Israel',
    'Adi',
    'Ben-Israel, Adi',
    'Autor der Quelle [86].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name='Ben-Israel, Adi'
);

INSERT INTO authors
(family_name,given_names,normalized_name,notes)
SELECT
    'Greville',
    'Thomas N. E.',
    'Greville, Thomas N. E.',
    'Autor der Quelle [86].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name='Greville, Thomas N. E.'
);

INSERT INTO authors
(family_name,given_names,normalized_name,notes)
SELECT
    'Hansen',
    'Per Christian',
    'Hansen, Per Christian',
    'Autor der Quelle [87].'
WHERE NOT EXISTS
(
    SELECT 1
    FROM authors
    WHERE normalized_name='Hansen, Per Christian'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
    86,
    'ben_israel_greville_generalized_inverses_2003',
    'book',
    'Generalized Inverses: Theory and Applications',
    1974,
    2003,
    'Springer',
    'New York',
    '2nd edition',
    '978-0-387-00293-4',
    'en',
    1,
    'monograph',
    9,
    'verified',
    '3.2.16',
    'Erstnennung als zentrale Referenz für verallgemeinerte Inversen und die Moore-Penrose-Pseudoinverse.',
    'Ben-Israel, Adi; Greville, Thomas N. E.: Generalized Inverses: Theory and Applications. 2nd edition. New York: Springer, 2003.',
    'Ben-Israel/Greville, Generalized Inverses [86]',
    'Zentrale Referenz für Moore-Penrose-Pseudoinverse, Projektoren sowie Mindestnorm- und Ausgleichslösungen.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=86
       OR source_key='ben_israel_greville_generalized_inverses_2003'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,year_original,year_edition,publisher,place,edition,isbn,language_code,priority,evidence_type,frzk_relevance,verification_status,first_citation_section_code,first_citation_note,full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
    87,
    'hansen_rank_deficient_ill_posed_1998',
    'book',
    'Rank-Deficient and Discrete Ill-Posed Problems: Numerical Aspects of Linear Inversion',
    1998,
    1998,
    'Society for Industrial and Applied Mathematics',
    'Philadelphia',
    NULL,
    '978-0-89871-403-6',
    'en',
    1,
    'monograph',
    9,
    'verified',
    '3.2.16',
    'Erstnennung für Regularisierung, abgeschnittene Singulärwertzerlegung und Parameterwahl.',
    'Hansen, Per Christian: Rank-Deficient and Discrete Ill-Posed Problems: Numerical Aspects of Linear Inversion. Philadelphia: Society for Industrial and Applied Mathematics, 1998.',
    'Hansen, Rank-Deficient Problems [87]',
    'Zentrale Referenz für Tikhonov-Regularisierung, TSVD, Filterfaktoren und Parameterwahl.',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM sources
    WHERE citation_number=87
       OR source_key='hansen_rank_deficient_ill_posed_1998'
);

SET @src_74 := (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1);
SET @src_84 := (SELECT source_id FROM sources WHERE citation_number=84 LIMIT 1);
SET @src_85 := (SELECT source_id FROM sources WHERE citation_number=85 LIMIT 1);
SET @src_86 := (SELECT source_id FROM sources WHERE citation_number=86 LIMIT 1);
SET @src_87 := (SELECT source_id FROM sources WHERE citation_number=87 LIMIT 1);

SET @author_ben_israel :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name='Ben-Israel, Adi'
    LIMIT 1
);

SET @author_greville :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name='Greville, Thomas N. E.'
    LIMIT 1
);

SET @author_hansen :=
(
    SELECT author_id
    FROM authors
    WHERE normalized_name='Hansen, Per Christian'
    LIMIT 1
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_86,@author_ben_israel,1,'author'
WHERE @src_86 IS NOT NULL
  AND @author_ben_israel IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_authors
      WHERE source_id=@src_86
        AND author_id=@author_ben_israel
  );

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_86,@author_greville,2,'author'
WHERE @src_86 IS NOT NULL
  AND @author_greville IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_authors
      WHERE source_id=@src_86
        AND author_id=@author_greville
  );

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @src_87,@author_hansen,1,'author'
WHERE @src_87 IS NOT NULL
  AND @author_hansen IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM source_authors
      WHERE source_id=@src_87
        AND author_id=@author_hansen
  );

-- ---------------------------------------------------------------------------
-- Literaturverwendung
-- ---------------------------------------------------------------------------

DELETE FROM source_usage
WHERE section_id=@section
  AND source_id IN (@src_74,@src_84,@src_85,@src_86,@src_87);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
VALUES
(@src_74,@section,'background',
 'Geometrische Interpretation der Ausgleichsrechnung, der Normalgleichungen und orthogonaler Projektionen.',
 'Abschnitt 3.2.16: Ausgleichslösung und Normalgleichungen',
 0,1,'Wiederverwendung der Quelle [74].',@revision),

(@src_84,@section,'background',
 'Berechnung der Pseudoinversen über die Singulärwertzerlegung sowie numerische Verfahren für Ausgleichs- und Mindestnormlösungen.',
 'Abschnitt 3.2.16: Pseudoinverse, SVD und Ausgleichslösung',
 0,1,'Wiederverwendung der Quelle [84].',@revision),

(@src_85,@section,'background',
 'Fehlerverstärkung durch kleine Singulärwerte, Konditionsproblematik der Normalgleichungen und numerische Stabilität.',
 'Abschnitt 3.2.16: Fehlerverstärkung und Regularisierung',
 0,1,'Wiederverwendung der Quelle [85].',@revision),

(@src_86,@section,'first_citation',
 'Moore-Penrose-Bedingungen, Eindeutigkeit der Pseudoinversen, Projektionsoperatoren sowie Lösungen kleinster Norm.',
 'Abschnitt 3.2.16: Definitionen 3.2.51–3.2.53 und Projektionsoperatoren',
 1,1,'Erstnennung der Quelle [86].',@revision),

(@src_87,@section,'first_citation',
 'Tikhonov-Regularisierung, abgeschnittene Singulärwertzerlegung, Filterfaktoren und Parameterwahl.',
 'Abschnitt 3.2.16: Definitionen 3.2.54–3.2.56',
 1,1,'Erstnennung der Quelle [87].',@revision);

-- ---------------------------------------------------------------------------
-- Definitionen 3.2.51–3.2.56
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_3216_definitions
(
    definition_number VARCHAR(50)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_general_ci
        PRIMARY KEY,
    title VARCHAR(500),
    definition_text LONGTEXT,
    formal_latex LONGTEXT,
    source_id BIGINT UNSIGNED
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

INSERT INTO tmp_3216_definitions VALUES
('3.2.51',
 'Moore-Penrose-Pseudoinverse',
 'Die Matrix A+ heißt Moore-Penrose-Pseudoinverse von A, wenn sie die vier Penrose-Bedingungen AA+A=A, A+AA+=A+, (AA+)^T=AA+ und (A+A)^T=A+A erfüllt.',
 'AA^{+}A=A,\qquad A^{+}AA^{+}=A^{+},\qquad\left(AA^{+}\right)^{\mathsf T}=AA^{+},\qquad\left(A^{+}A\right)^{\mathsf T}=A^{+}A',
 @src_86),

('3.2.52',
 'Ausgleichslösung',
 'Eine Ausgleichslösung minimiert die euklidische Norm des Residualvektors Ax-b.',
 'x_{\mathrm{LS}}\in\operatorname*{arg\,min}_{x\in\mathbb{R}^{n}}\|Ax-b\|_2',
 @src_74),

('3.2.53',
 'Lösung kleinster Norm',
 'Eine Lösung kleinster Norm erfüllt Ax=b und besitzt unter allen Lösungen die kleinste euklidische Norm.',
 '\|x_{\min}\|_2=\min\left\{\|x\|_2\mid Ax=b\right\}',
 @src_86),

('3.2.54',
 'Regularisiertes Ausgleichsproblem',
 'Ein regularisiertes Ausgleichsproblem ergänzt die Residualminimierung durch einen gewichteten Regularisierungsterm.',
 'x_{\lambda}\in\operatorname*{arg\,min}_{x}\left(\|Ax-b\|_2^2+\lambda\mathcal{R}(x)\right)',
 @src_87),

('3.2.55',
 'Tikhonov-Regularisierung',
 'Die Tikhonov-Regularisierung minimiert die Summe aus quadratischer Residualnorm und dem gewichteten quadratischen Regularisierungsterm.',
 'J_{\lambda}(x)=\|Ax-b\|_2^2+\lambda\|Lx\|_2^2',
 @src_87),

('3.2.56',
 'Abgeschnittene Singulärwertzerlegung',
 'Bei der abgeschnittenen Singulärwertzerlegung werden nur Singulärwerte oberhalb eines festgelegten Schwellenwertes invertiert.',
 'A_{\tau}^{+}=\sum_{\sigma_i>\tau}\frac{1}{\sigma_i}v_i u_i^{\mathsf T}',
 @src_87);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
SELECT
    t.definition_number,
    @section,
    t.title,
    t.definition_text,
    t.formal_latex,
    t.formal_latex,
    'adapted',
    t.source_id,
    'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.',
    'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.',
    'verified',
    @revision
FROM tmp_3216_definitions t
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number COLLATE utf8mb4_general_ci
        = t.definition_number COLLATE utf8mb4_general_ci
);

UPDATE definitions d
JOIN tmp_3216_definitions t
  ON d.definition_number COLLATE utf8mb4_general_ci
   = t.definition_number COLLATE utf8mb4_general_ci
SET
    d.section_id=@section,
    d.title=t.title,
    d.definition_text=t.definition_text,
    d.formal_latex=t.formal_latex,
    d.word_latex=t.formal_latex,
    d.provenance='adapted',
    d.source_id=t.source_id,
    d.assumptions='Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.',
    d.notes='Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.',
    d.validation_status='verified',
    d.created_revision_id=COALESCE(d.created_revision_id,@revision)
WHERE d.section_id=@section
   OR d.definition_number IN
      ('3.2.51','3.2.52','3.2.53','3.2.54','3.2.55','3.2.56');

-- ---------------------------------------------------------------------------
-- Satz 3.2.13
-- Reales Tabellenschema: kein Feld proof_text
-- ---------------------------------------------------------------------------

INSERT INTO theorems
(
    theorem_number,
    section_id,
    title,
    statement_text,
    statement_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.2.13',
    @section,
    'Normalgleichungen der Ausgleichsrechnung',
    'Jede Ausgleichslösung eines linearen Ausgleichsproblems erfüllt die Normalgleichungen A^T A x = A^T b. Der Residualvektor ist orthogonal zum Spaltenraum von A.',
    'A^{\mathsf T}Ax=A^{\mathsf T}b',
    'A^{\mathsf T}Ax=A^{\mathsf T}b',
    'literature',
    @src_74,
    'A ist eine reelle Matrix und die Residualfunktion ||Ax-b||_2^2 ist differenzierbar. Begründung: Aus der notwendigen Optimalitätsbedingung für f(x)=||Ax-b||_2^2 folgt 2A^T A x-2A^T b=0 und damit die Normalgleichung.',
    'verified',
    @revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM theorems
    WHERE theorem_number='3.2.13'
);

UPDATE theorems
SET
    section_id=@section,
    title='Normalgleichungen der Ausgleichsrechnung',
    statement_text='Jede Ausgleichslösung eines linearen Ausgleichsproblems erfüllt die Normalgleichungen A^T A x = A^T b. Der Residualvektor ist orthogonal zum Spaltenraum von A.',
    statement_latex='A^{\mathsf T}Ax=A^{\mathsf T}b',
    word_latex='A^{\mathsf T}Ax=A^{\mathsf T}b',
    provenance='literature',
    source_id=@src_74,
    assumptions='A ist eine reelle Matrix und die Residualfunktion ||Ax-b||_2^2 ist differenzierbar. Begründung: Aus der notwendigen Optimalitätsbedingung für f(x)=||Ax-b||_2^2 folgt 2A^T A x-2A^T b=0 und damit die Normalgleichung.',
    validation_status='verified',
    created_revision_id=COALESCE(created_revision_id,@revision)
WHERE theorem_number='3.2.13';

-- ---------------------------------------------------------------------------
-- Gleichungen (3.504)–(3.573)
-- ---------------------------------------------------------------------------

CREATE TEMPORARY TABLE tmp_3216_equations
(
    equation_number VARCHAR(50)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_general_ci
        PRIMARY KEY,
    title VARCHAR(500),
    latex TEXT,
    equation_type VARCHAR(20),
    source_id BIGINT UNSIGNED
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;

INSERT INTO tmp_3216_equations VALUES
('3.504','Allgemeine reelle Matrix','A\\in\\mathbb{R}^{m\\times n}','definition',@src_86),
('3.505','Dimension der Pseudoinversen','A^{+}\\in\\mathbb{R}^{n\\times m}','definition',@src_86),
('3.506','Erste Penrose-Bedingung','AA^{+}A=A','definition',@src_86),
('3.507','Zweite Penrose-Bedingung','A^{+}AA^{+}=A^{+}','definition',@src_86),
('3.508','Dritte Penrose-Bedingung','\\left(AA^{+}\\right)^{\\mathsf T}=AA^{+}','definition',@src_86),
('3.509','Vierte Penrose-Bedingung','\\left(A^{+}A\\right)^{\\mathsf T}=A^{+}A','definition',@src_86),
('3.510','Übereinstimmung mit gewöhnlicher Inversen','A^{+}=A^{-1}','theorem',@src_86),
('3.511','Singulärwertzerlegung der Ausgangsmatrix','A=U\\Sigma V^{\\mathsf T}','definition',@src_84),
('3.512','Pseudoinverse über die Singulärwertzerlegung','A^{+}=V\\Sigma^{+}U^{\\mathsf T}','theorem',@src_84),
('3.513','Invertierung positiver Singulärwerte','\\sigma_i\\longmapsto\\frac{1}{\\sigma_i}','definition',@src_84),
('3.514','Behandlung verschwindender Singulärwerte','0\\longmapsto 0','definition',@src_84),
('3.515','Reduzierte Darstellung der Pseudoinversen','A^{+}=\\sum_{i=1}^{r}\\frac{1}{\\sigma_i}v_i u_i^{\\mathsf T}','theorem',@src_84),
('3.516','Verstärkungsfaktor kleiner Singulärwerte','\\frac{1}{\\sigma_i}','metric',@src_85),
('3.517','Lineares Gleichungssystem','Ax=b','other',@src_74),
('3.518','Dimensionen des Ausgleichsproblems','A\\in\\mathbb{R}^{m\\times n}\\qquad\\text{und}\\qquad b\\in\\mathbb{R}^{m}','definition',@src_74),
('3.519','Definition der Ausgleichslösung','x_{\\mathrm{LS}}\\in\\operatorname*{arg\\,min}_{x\\in\\mathbb{R}^{n}}\\|Ax-b\\|_2','definition',@src_74),
('3.520','Residualvektor','r=b-Ax_{\\mathrm{LS}}','definition',@src_74),
('3.521','Überbestimmte Näherungsgleichung','Ax\\approx b','other',@src_74),
('3.522','Normalgleichungen','A^{\\mathsf T}Ax=A^{\\mathsf T}b','theorem',@src_74),
('3.523','Quadratische Residualfunktion','f(x)=\\|Ax-b\\|_2^2','definition',@src_74),
('3.524','Residualfunktion als Skalarprodukt','\\|Ax-b\\|_2^2=(Ax-b)^{\\mathsf T}(Ax-b)','derived',@src_74),
('3.525','Ausmultiplizierte Residualfunktion','f(x)=x^{\\mathsf T}A^{\\mathsf T}Ax-2x^{\\mathsf T}A^{\\mathsf T}b+b^{\\mathsf T}b','derived',@src_74),
('3.526','Notwendige Optimalitätsbedingung','\\nabla f(x)=0','derived',@src_74),
('3.527','Gradientengleichung','2A^{\\mathsf T}Ax-2A^{\\mathsf T}b=0','derived',@src_74),
('3.528','Herleitung der Normalgleichung','A^{\\mathsf T}Ax=A^{\\mathsf T}b','theorem',@src_74),
('3.529','Orthogonalität des Residuals','A^{\\mathsf T}r=0','theorem',@src_74),
('3.530','Residual orthogonal zum Bildraum','r\\perp\\operatorname{Bild}(A)','theorem',@src_74),
('3.531','Gram-Matrix des Ausgleichsproblems','A^{\\mathsf T}A','other',@src_84),
('3.532','Eindeutige Ausgleichslösung bei vollem Spaltenrang','x_{\\mathrm{LS}}=\\left(A^{\\mathsf T}A\\right)^{-1}A^{\\mathsf T}b','theorem',@src_84),
('3.533','Pseudoinverse bei vollem Spaltenrang','A^{+}=\\left(A^{\\mathsf T}A\\right)^{-1}A^{\\mathsf T}','theorem',@src_84),
('3.534','Ausgleichslösung über Pseudoinverse','x_{\\mathrm{LS}}=A^{+}b','theorem',@src_86),
('3.535','Unterbestimmtes oder nicht eindeutiges Gleichungssystem','Ax=b','other',@src_86),
('3.536','Exaktheitsbedingung der Mindestnormlösung','Ax_{\\min}=b','definition',@src_86),
('3.537','Minimalitätsbedingung der Lösungsnorm','\\|x_{\\min}\\|_2=\\min\\left\\{\\|x\\|_2\\mid Ax=b\\right\\}','definition',@src_86),
('3.538','Mindestnormlösung über Pseudoinverse','x_{\\min}=A^{+}b','theorem',@src_86),
('3.539','Projektionsoperator auf den Spaltenraum','P_A=AA^{+}','definition',@src_86),
('3.540','Abbildung auf den Spaltenraum','P_A:\\mathbb{R}^{m}\\rightarrow\\operatorname{Bild}(A)','definition',@src_86),
('3.541','Projektion des Datenvektors','AA^{+}b','derived',@src_86),
('3.542','Projektionsoperator auf den Zeilenraum','P_{A^{\\mathsf T}}=A^{+}A','definition',@src_86),
('3.543','Zeilenraum der Matrix','\\operatorname{Bild}(A^{\\mathsf T})','definition',@src_86),
('3.544','Residual über den Projektionsoperator','r=\\left(I-AA^{+}\\right)b','derived',@src_86),
('3.545','Orthogonale Zerlegung des Datenvektors','b=AA^{+}b+\\left(I-AA^{+}\\right)b','theorem',@src_86),
('3.546','Allgemeines regularisiertes Ausgleichsproblem','x_{\\lambda}\\in\\operatorname*{arg\\,min}_{x}\\left(\\|Ax-b\\|_2^2+\\lambda\\,\\mathcal{R}(x)\\right)','definition',@src_87),
('3.547','Regularisierungsterm','\\mathcal{R}(x)','definition',@src_87),
('3.548','Nichtnegativer Regularisierungsparameter','\\lambda\\geq 0','definition',@src_87),
('3.549','Tikhonov-Funktional','J_{\\lambda}(x)=\\|Ax-b\\|_2^2+\\lambda\\|Lx\\|_2^2','definition',@src_87),
('3.550','Dimension des Regularisierungsoperators','L\\in\\mathbb{R}^{p\\times n}','definition',@src_87),
('3.551','Standardregularisierung mit Identität','L=I','definition',@src_87),
('3.552','Standardform des Tikhonov-Funktionals','J_{\\lambda}(x)=\\|Ax-b\\|_2^2+\\lambda\\|x\\|_2^2','definition',@src_87),
('3.553','Normalgleichung der allgemeinen Tikhonov-Regularisierung','\\left(A^{\\mathsf T}A+\\lambda L^{\\mathsf T}L\\right)x_{\\lambda}=A^{\\mathsf T}b','theorem',@src_87),
('3.554','Normalgleichung der Standardregularisierung','\\left(A^{\\mathsf T}A+\\lambda I\\right)x_{\\lambda}=A^{\\mathsf T}b','theorem',@src_87),
('3.555','Explizite Standard-Tikhonov-Lösung','x_{\\lambda}=\\left(A^{\\mathsf T}A+\\lambda I\\right)^{-1}A^{\\mathsf T}b','theorem',@src_87),
('3.556','Singulärwertzerlegung für Tikhonov','A=U\\Sigma V^{\\mathsf T}','definition',@src_87),
('3.557','Spektrale Tikhonov-Lösung','x_{\\lambda}=\\sum_{i=1}^{r}\\frac{\\sigma_i}{\\sigma_i^2+\\lambda}\\left(u_i^{\\mathsf T}b\\right)v_i','theorem',@src_87),
('3.558','Tikhonov-Filterfaktor','\\phi_i(\\lambda)=\\frac{\\sigma_i^2}{\\sigma_i^2+\\lambda}','definition',@src_87),
('3.559','Filterfaktor bei großem Singulärwert','\\phi_i(\\lambda)\\approx 1','derived',@src_87),
('3.560','Filterfaktor bei kleinem Singulärwert','\\phi_i(\\lambda)\\approx 0','derived',@src_87),
('3.561','Positiver Abschneideschwellenwert','\\tau>0','definition',@src_87),
('3.562','Regularisierte Pseudoinverse durch TSVD','A_{\\tau}^{+}=\\sum_{\\sigma_i>\\tau}\\frac{1}{\\sigma_i}v_i u_i^{\\mathsf T}','definition',@src_87),
('3.563','TSVD-Lösung','x_{\\tau}=A_{\\tau}^{+}b','definition',@src_87),
('3.564','Verworfene Singulärwerte','\\sigma_i\\leq\\tau','definition',@src_87),
('3.565','Grenzübergang für kleine Regularisierung','\\lambda\\rightarrow 0\\quad\\Longrightarrow\\quad x_{\\lambda}\\rightarrow A^{+}b','theorem',@src_87),
('3.566','Grenzübergang für starke Regularisierung','\\lambda\\rightarrow\\infty\\quad\\Longrightarrow\\quad x_{\\lambda}\\rightarrow 0','theorem',@src_87),
('3.567','Datenanpassung','\\text{Datenanpassung}','other',@src_87),
('3.568','Lösungsstabilität','\\text{Lösungsstabilität}','other',@src_87),
('3.569','Geringe Verzerrung und hohe Varianz','\\text{kleine Verzerrung}\\quad+\\quad\\text{hohe Varianz}','other',@src_87),
('3.570','Größere Verzerrung und geringere Varianz','\\text{größere Verzerrung}\\quad+\\quad\\text{geringere Varianz}','other',@src_87),
('3.571','Typisch überbestimmtes System','m>n\\quad\\Longrightarrow\\quad\\text{typischerweise überbestimmt}','other',@src_74),
('3.572','Typisch unterbestimmtes System','m<n\\quad\\Longrightarrow\\quad\\text{typischerweise unterbestimmt}','other',@src_74),
('3.573','Didaktische Auswahlfrage','\\text{Nach welchem Kriterium ist die Lösung die beste?}','other',@src_74);

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    t.equation_number,
    @section,
    t.title,
    t.latex,
    t.latex,
    CONCAT('Formale Gleichung ',t.equation_number,' aus Abschnitt 3.2.16.'),
    t.equation_type,
    'adapted',
    t.source_id,
    'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.',
    'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.',
    'verified',
    @revision
FROM tmp_3216_equations t
WHERE NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number COLLATE utf8mb4_general_ci
        = t.equation_number COLLATE utf8mb4_general_ci
);

UPDATE equations e
JOIN tmp_3216_equations t
  ON e.equation_number COLLATE utf8mb4_general_ci
   = t.equation_number COLLATE utf8mb4_general_ci
SET
    e.section_id=@section,
    e.title=t.title,
    e.equation_latex=t.latex,
    e.word_latex=t.latex,
    e.plain_description=CONCAT('Formale Gleichung ',e.equation_number,' aus Abschnitt 3.2.16.'),
    e.equation_type=t.equation_type,
    e.provenance='adapted',
    e.source_id=t.source_id,
    e.derivation='Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.',
    e.assumptions='Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.',
    e.validation_status='verified',
    e.created_revision_id=COALESCE(e.created_revision_id,@revision)
WHERE e.section_id=@section
   OR CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 504 AND 573;

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(revision_id,section_id,change_type,change_summary)
SELECT
    @revision,
    @section,
    'inserted',
    'Abschnitt 3.2.16 vollständig mit fünf Literaturverwendungen, sechs Definitionen, Satz 3.2.13 und Gleichungen 3.504–3.573 eingetragen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision
      AND section_id=@section
);

-- ---------------------------------------------------------------------------
-- Repository-Zähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('current_section','3.2.17'),
('last_completed_section','3.2.16'),
('last_definition_number','3.2.56'),
('next_definition_number','3.2.57'),
('last_theorem_number','3.2.13'),
('next_theorem_number','3.2.14'),
('last_equation_number','3.573'),
('next_equation_number','3.574'),
('last_citation_number','87'),
('next_citation_number','88')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

DROP TEMPORARY TABLE IF EXISTS tmp_3216_definitions;
DROP TEMPORARY TABLE IF EXISTS tmp_3216_equations;

COMMIT;

-- ---------------------------------------------------------------------------
-- Abschlusskontrolle
-- Erwartet:
-- 1 Abschnitt
-- 6 Definitionen
-- 1 Satz
-- 70 Gleichungen
-- 5 geprüfte Literaturverwendungen
-- ---------------------------------------------------------------------------

SELECT
    section_id,
    section_code,
    title,
    status,
    notes
FROM dissertation_sections
WHERE section_code='3.2.16';

SELECT
    COUNT(*) AS definitionen_3_2_16
FROM definitions
WHERE section_id=@section
  AND definition_number IN
      ('3.2.51','3.2.52','3.2.53','3.2.54','3.2.55','3.2.56');

SELECT
    COUNT(*) AS saetze_3_2_16
FROM theorems
WHERE section_id=@section
  AND theorem_number='3.2.13';

SELECT
    COUNT(*) AS gleichungen_3_2_16
FROM equations
WHERE section_id=@section
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 504 AND 573;

SELECT
    COUNT(*) AS literaturverwendungen_3_2_16
FROM source_usage
WHERE section_id=@section
  AND citation_checked=1;

SELECT
    citation_number,
    short_citation_text,
    verification_status
FROM sources
WHERE citation_number IN (74,84,85,86,87)
ORDER BY citation_number;

SELECT
    counter_key,
    counter_value
FROM repository_counters
WHERE counter_key IN
(
    'current_section',
    'last_completed_section',
    'last_definition_number',
    'next_definition_number',
    'last_theorem_number',
    'next_theorem_number',
    'last_equation_number',
    'next_equation_number',
    'last_citation_number',
    'next_citation_number'
)
ORDER BY counter_key;
