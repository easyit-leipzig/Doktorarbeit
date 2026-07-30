-- FRZK-Repository – vollständige Korrektur Abschnitt 3.2.13
-- Diagonalisierbarkeit und Spektralzerlegung
-- Grundlage: frzk_rkb_stand_ende_3.2.13.sql
-- Korrigiert Literatur, Definitionen, Sätze und Gleichungen (3.319)–(3.381).
-- V3: Kollationen der temporären Gleichungstabelle und des JOIN-Vergleichs vereinheitlicht.
START TRANSACTION;

SET @section := (SELECT section_id FROM dissertation_sections WHERE section_code='3.2.13' LIMIT 1);
SET @src_lang := (SELECT source_id FROM sources WHERE citation_number=71 LIMIT 1);
SET @src_strang := (SELECT source_id FROM sources WHERE citation_number=74 LIMIT 1);
SET @src_reed := (SELECT source_id FROM sources WHERE citation_number=76 LIMIT 1);
SET @src_halmos := (SELECT source_id FROM sources WHERE citation_number=82 LIMIT 1);

INSERT INTO repository_revisions (revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-KORR-K3.2.13-V2',NOW(),'section','3.2.13','3.2.13-korr-v2','Vollständige Korrektur von Abschnitt 3.2.13 einschließlich Literaturverwendungen, Definitionstexten, Satztexten und Gleichungsdaten.','Olaf Thiele / ChatGPT',(SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.2.13-V1' LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-KORR-K3.2.13-V2');
SET @revision := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-KORR-K3.2.13-V2' LIMIT 1);

UPDATE dissertation_sections SET title='Diagonalisierbarkeit und Spektralzerlegung', status='final', notes='Diagonalisierbarkeit, algebraische und geometrische Vielfachheit, Matrixpotenzen, Matrixfunktionen, Spektralsatz und Spektralzerlegung. Literatur: [71], [74], [76], [82].', updated_at=NOW() WHERE section_id=@section;

UPDATE definitions SET title='Diagonalisierbare Matrix', definition_text='Eine quadratische Matrix A heißt diagonalisierbar, wenn eine invertierbare Matrix P und eine Diagonalmatrix D existieren, sodass P^{-1}AP=D gilt.', formal_latex='P^{-1}AP=D', word_latex='P^{-1}AP=D', provenance='adapted', source_id=@src_lang, assumptions='Grundbegriffe der linearen Algebra, Eigenwerte, Eigenvektoren und charakteristisches Polynom sind definiert.', notes='Literaturgrundlagen: [71], [74] und [82].', validation_status='verified', created_revision_id=COALESCE(created_revision_id,@revision) WHERE section_id=@section AND definition_number='3.2.37';
UPDATE definitions SET title='Algebraische Vielfachheit', definition_text='Die algebraische Vielfachheit eines Eigenwertes ist seine Vielfachheit als Nullstelle des charakteristischen Polynoms.', formal_latex='p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)', word_latex='p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)', provenance='adapted', source_id=@src_lang, assumptions='Grundbegriffe der linearen Algebra, Eigenwerte, Eigenvektoren und charakteristisches Polynom sind definiert.', notes='Literaturgrundlagen: [71], [74] und [82].', validation_status='verified', created_revision_id=COALESCE(created_revision_id,@revision) WHERE section_id=@section AND definition_number='3.2.38';
UPDATE definitions SET title='Geometrische Vielfachheit', definition_text='Die geometrische Vielfachheit eines Eigenwertes ist die Dimension seines Eigenraumes.', formal_latex='m_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)', word_latex='m_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)', provenance='adapted', source_id=@src_lang, assumptions='Grundbegriffe der linearen Algebra, Eigenwerte, Eigenvektoren und charakteristisches Polynom sind definiert.', notes='Literaturgrundlagen: [71], [74] und [82].', validation_status='verified', created_revision_id=COALESCE(created_revision_id,@revision) WHERE section_id=@section AND definition_number='3.2.39';

UPDATE theorems SET title='Kriterium der Diagonalisierbarkeit', statement_text='Eine Matrix A ist genau dann diagonalisierbar, wenn der zugrunde liegende Vektorraum eine Basis aus Eigenvektoren von A besitzt.', statement_latex='A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A', word_latex='A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A', provenance='literature', source_id=@src_lang, assumptions='Endlichdimensionaler reeller Vektorraum; beim vollständigen Kriterium zerfällt das charakteristische Polynom vollständig.', validation_status='verified', created_revision_id=COALESCE(created_revision_id,@revision) WHERE section_id=@section AND theorem_number='3.2.8';
UPDATE theorems SET title='Vollständiges Diagonalisierungskriterium', statement_text='Eine Matrix, deren charakteristisches Polynom vollständig zerfällt, ist genau dann diagonalisierbar, wenn für jeden Eigenwert algebraische und geometrische Vielfachheit übereinstimmen.', statement_latex='m_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)', word_latex='m_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)', provenance='literature', source_id=@src_lang, assumptions='Endlichdimensionaler reeller Vektorraum; beim vollständigen Kriterium zerfällt das charakteristische Polynom vollständig.', validation_status='verified', created_revision_id=COALESCE(created_revision_id,@revision) WHERE section_id=@section AND theorem_number='3.2.9';
UPDATE theorems SET title='Spektralzerlegung', statement_text='Jede reelle symmetrische Matrix besitzt reelle Eigenwerte und eine Orthonormalbasis aus Eigenvektoren. Sie ist daher durch eine orthogonale Matrix diagonalisierbar.', statement_latex='A=QDQ^{\\mathsf T}', word_latex='A=QDQ^{\\mathsf T}', provenance='literature', source_id=@src_reed, assumptions='Endlichdimensionaler reeller Vektorraum; beim vollständigen Kriterium zerfällt das charakteristische Polynom vollständig.', validation_status='verified', created_revision_id=COALESCE(created_revision_id,@revision) WHERE section_id=@section AND theorem_number='3.2.10';

DROP TEMPORARY TABLE IF EXISTS tmp_3213_equations;
CREATE TEMPORARY TABLE tmp_3213_equations (
    equation_number VARCHAR(50)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_general_ci NOT NULL,
    latex TEXT
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_general_ci NOT NULL,
    source_id BIGINT UNSIGNED NULL,
    equation_type VARCHAR(20)
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_general_ci NOT NULL,
    PRIMARY KEY (equation_number)
) ENGINE=InnoDB
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
INSERT INTO tmp_3213_equations VALUES
('3.319','A\\in\\mathbb{R}^{n\\times n}',@src_lang,'definition'),
('3.320','P\\in\\mathbb{R}^{n\\times n}',@src_lang,'definition'),
('3.321','D\\in\\mathbb{R}^{n\\times n}',@src_lang,'definition'),
('3.322','P^{-1}AP=D',@src_lang,'definition'),
('3.323','A=PDP^{-1}',@src_lang,'definition'),
('3.324','v_1,\\ldots,v_n',@src_lang,'definition'),
('3.325','P=\\begin{pmatrix}|&|&&|\\\\v_1&v_2&\\cdots&v_n\\\\|&|&&| \\end{pmatrix}',@src_lang,'definition'),
('3.326','D=\\begin{pmatrix}\\lambda_1&0&\\cdots&0\\\\0&\\lambda_2&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n \\end{pmatrix}',@src_lang,'definition'),
('3.327','Av_i=\\lambda_i v_i',@src_lang,'definition'),
('3.328','AP=PD',@src_lang,'definition'),
('3.329','P^{-1}AP=D',@src_lang,'derived'),
('3.330','A\\in\\mathbb{R}^{n\\times n}',@src_lang,'theorem'),
('3.331','A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A',@src_lang,'theorem'),
('3.332','E_\\lambda=\\ker(A-\\lambda I)',@src_lang,'derived'),
('3.333','\\lambda_1,\\ldots,\\lambda_k',@src_lang,'derived'),
('3.334','\\dim(E_{\\lambda_1})+\\cdots+\\dim(E_{\\lambda_k})=n',@src_lang,'derived'),
('3.335','A\\text{ besitzt }n\\text{ paarweise verschiedene Eigenwerte}\\Longrightarrow A\\text{ ist diagonalisierbar}',@src_lang,'derived'),
('3.336','p_A(\\lambda)=\\det(A-\\lambda I)',@src_lang,'definition'),
('3.337','p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)',@src_lang,'definition'),
('3.338','q(\\lambda_0)\\neq0',@src_lang,'definition'),
('3.339','m_{\\mathrm{alg}}(\\lambda_0)=m',@src_lang,'definition'),
('3.340','\\sum_{\\lambda\\in\\sigma(A)}m_{\\mathrm{alg}}(\\lambda)=n',@src_lang,'definition'),
('3.341','m_{\\mathrm{geo}}(\\lambda)=\\dim(E_\\lambda)',@src_lang,'definition'),
('3.342','E_\\lambda=\\ker(A-\\lambda I)',@src_lang,'definition'),
('3.343','m_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)',@src_lang,'definition'),
('3.344','1\\le m_{\\mathrm{geo}}(\\lambda)\\le m_{\\mathrm{alg}}(\\lambda)',@src_lang,'definition'),
('3.345','m_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)',@src_lang,'theorem'),
('3.346','\\sum_{\\lambda\\in\\sigma(A)}m_{\\mathrm{geo}}(\\lambda)=n',@src_lang,'theorem'),
('3.347','m_{\\mathrm{geo}}(\\lambda)<m_{\\mathrm{alg}}(\\lambda)',@src_lang,'theorem'),
('3.348','A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}',@src_lang,'derived'),
('3.349','\\lambda_1=2,\\qquad\\lambda_2=3',@src_lang,'derived'),
('3.350','v_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}',@src_lang,'derived'),
('3.351','P=\\begin{pmatrix}1&0\\\\0&1 \\end{pmatrix}=I',@src_lang,'derived'),
('3.352','P^{-1}AP=A',@src_lang,'derived'),
('3.353','A=\\begin{pmatrix}1&1\\\\0&1 \\end{pmatrix}',@src_lang,'derived'),
('3.354','p_A(\\lambda)=\\det\\begin{matrix}1-\\lambda&1\\\\0&1-\\lambda \\end{matrix}=(1-\\lambda)^2',@src_lang,'derived'),
('3.355','\\lambda=1',@src_lang,'derived'),
('3.356','m_{\\mathrm{alg}}(1)=2',@src_lang,'derived'),
('3.357','A-I=\\begin{pmatrix}0&1\\\\0&0 \\end{pmatrix}',@src_lang,'derived'),
('3.358','(A-I)v=0',@src_lang,'derived'),
('3.359','v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}',@src_lang,'derived'),
('3.360','v_2=0',@src_lang,'derived'),
('3.361','E_1=\\operatorname{span}\\left\\{\\begin{pmatrix}1\\\\0 \\end{pmatrix}\\right\\}',@src_lang,'derived'),
('3.362','m_{\\mathrm{geo}}(1)=1',@src_lang,'derived'),
('3.363','m_{\\mathrm{geo}}(1)=1<2=m_{\\mathrm{alg}}(1)',@src_lang,'derived'),
('3.364','A=PDP^{-1}',@src_lang,'derived'),
('3.365','A^2=(PDP^{-1})(PDP^{-1})',@src_lang,'derived'),
('3.366','P^{-1}P=I',@src_lang,'derived'),
('3.367','A^2=PD^2P^{-1}',@src_lang,'derived'),
('3.368','A^k=PD^kP^{-1}',@src_reed,'derived'),
('3.369','D=\\begin{pmatrix}\\lambda_1&0&\\cdots&0\\\\0&\\lambda_2&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n \\end{pmatrix}',@src_reed,'derived'),
('3.370','D^k=\\begin{pmatrix}\\lambda_1^k&0&\\cdots&0\\\\0&\\lambda_2^k&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n^k \\end{pmatrix}',@src_reed,'derived'),
('3.371','A=PDP^{-1}',@src_reed,'derived'),
('3.372','f(A)=Pf(D)P^{-1}',@src_reed,'derived'),
('3.373','f(D)=\\begin{pmatrix}f(\\lambda_1)&0&\\cdots&0\\\\0&f(\\lambda_2)&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&f(\\lambda_n) \\end{pmatrix}',@src_reed,'derived'),
('3.374','e^A=\\sum_{k=0}^{\\infty}\\frac{A^k}{k!}',@src_reed,'derived'),
('3.375','e^A=Pe^DP^{-1}',@src_reed,'derived'),
('3.376','e^D=\\begin{pmatrix}e^{\\lambda_1}&0&\\cdots&0\\\\0&e^{\\lambda_2}&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&e^{\\lambda_n} \\end{pmatrix}',@src_reed,'derived'),
('3.377','A\\in\\mathbb{R}^{n\\times n}',@src_reed,'theorem'),
('3.378','A^{\\mathsf T}=A',@src_reed,'theorem'),
('3.379','Q^{-1}=Q^{\\mathsf T}',@src_reed,'theorem'),
('3.380','Q^{\\mathsf T}AQ=D',@src_reed,'theorem'),
('3.381','A=QDQ^{\\mathsf T}',@src_reed,'theorem');
UPDATE equations AS e
JOIN tmp_3213_equations AS t
  ON t.equation_number COLLATE utf8mb4_general_ci
   = e.equation_number COLLATE utf8mb4_general_ci
SET e.equation_latex=t.latex,e.word_latex=t.latex,e.plain_description=CASE WHEN NULLIF(e.plain_description,'') IS NULL THEN CONCAT('Formale Gleichung ',e.equation_number,' aus Abschnitt 3.2.13.') ELSE e.plain_description END,e.equation_type=t.equation_type,e.provenance='adapted',e.source_id=t.source_id,e.derivation='Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.',e.assumptions='Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.',e.validation_status='verified',e.created_revision_id=COALESCE(e.created_revision_id,@revision) WHERE e.section_id=@section;

DELETE FROM source_usage WHERE section_id=@section AND source_id IN (@src_lang,@src_strang,@src_reed,@src_halmos);
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id) SELECT @src_lang,@section,'definition','Lang stützt die algebraischen Definitionen der Diagonalisierbarkeit sowie der algebraischen und geometrischen Vielfachheit und die zugehörigen Kriterien über Eigenräume und Eigenvektoren.','Definitionen 3.2.37–3.2.39; Sätze 3.2.8–3.2.9; Gleichungen (3.319)–(3.347)',0,1,'[71] wiederverwendet.',@revision WHERE @section IS NOT NULL AND @src_lang IS NOT NULL;
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id) SELECT @src_strang,@section,'background','Strang stützt die rechnerische und geometrische Einordnung der Diagonalisierung, die Beispiele, Matrixpotenzen und die orthogonale Diagonalisierung symmetrischer Matrizen.','Abschnitt 3.2.13; Gleichungen (3.319)–(3.381)',0,1,'[74] wiederverwendet.',@revision WHERE @section IS NOT NULL AND @src_strang IS NOT NULL;
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id) SELECT @src_reed,@section,'theorem','Reed und Simon stützen die operatorentheoretische Einordnung von Spektrum, Matrixfunktionen, Exponentialfunktion, Spektralsatz und Spektralzerlegung.','Matrixfunktionen und Satz 3.2.10; Gleichungen (3.368)–(3.381)',0,1,'[76] wiederverwendet.',@revision WHERE @section IS NOT NULL AND @src_reed IS NOT NULL;
INSERT INTO source_usage (source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id) SELECT @src_halmos,@section,'background','Halmos stützt die basisunabhängige Einordnung linearer Operatoren, Eigenräume, Eigenvektorbasen und den Spektralsatz im endlichdimensionalen Raum.','Definitionen 3.2.37–3.2.39; Sätze 3.2.8–3.2.10',0,1,'[82] wiederverwendet.',@revision WHERE @section IS NOT NULL AND @src_halmos IS NOT NULL;

INSERT INTO section_change_log (revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value) SELECT @revision,@section,'edited','section','3.2.13','Abschnitt 3.2.13 vollständig korrigiert und mit Literaturverwendungen versehen.','Leere Definitionstexte, Satztexte und Formelspalten; unvollständige Quellenverwendungen.','Definitionen 3.2.37–3.2.39, Sätze 3.2.8–3.2.10 und Gleichungen (3.319)–(3.381) vollständig befüllt; Quellen [71], [74], [76], [82] geprüft verknüpft.' WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section AND object_reference='3.2.13');
INSERT INTO section_change_log (revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value) SELECT @revision,@section,'source_reused','sources','[71], [74], [76], [82]','Vier bestehende Literaturstellen wurden dem korrigierten Abschnitt 3.2.13 vollständig zugeordnet.','Unvollständige oder leere source_usage-Zuordnungen.','Vier geprüfte source_usage-Datensätze.' WHERE NOT EXISTS (SELECT 1 FROM section_change_log WHERE revision_id=@revision AND section_id=@section AND change_type='source_reused');

UPDATE repository_counters SET counter_value='3.2.14' WHERE counter_key='current_section';
UPDATE repository_counters SET counter_value='3.2.13' WHERE counter_key='last_completed_section';
UPDATE repository_counters SET counter_value='3.2.39' WHERE counter_key='last_definition_number';
UPDATE repository_counters SET counter_value='3.2.40' WHERE counter_key='next_definition_number';
UPDATE repository_counters SET counter_value='3.2.10' WHERE counter_key='last_theorem_number';
UPDATE repository_counters SET counter_value='3.2.11' WHERE counter_key='next_theorem_number';
UPDATE repository_counters SET counter_value='3.381' WHERE counter_key='last_equation_number';
UPDATE repository_counters SET counter_value='3.382' WHERE counter_key='next_equation_number';
UPDATE repository_counters SET counter_value='83' WHERE counter_key='last_citation_number';
UPDATE repository_counters SET counter_value='84' WHERE counter_key='next_citation_number';

COMMIT;

SELECT section_code,title,status,notes FROM dissertation_sections WHERE section_id=@section;
SELECT COUNT(*) AS definitions_complete FROM definitions WHERE section_id=@section AND definition_number IN ('3.2.37','3.2.38','3.2.39') AND definition_text<>'' AND word_latex IS NOT NULL AND source_id IS NOT NULL AND validation_status='verified';
SELECT COUNT(*) AS theorems_complete FROM theorems WHERE section_id=@section AND theorem_number IN ('3.2.8','3.2.9','3.2.10') AND statement_text<>'' AND word_latex IS NOT NULL AND source_id IS NOT NULL AND validation_status='verified';
SELECT COUNT(*) AS equations_complete FROM equations WHERE section_id=@section AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 319 AND 381 AND equation_latex<>'' AND word_latex<>'' AND source_id IS NOT NULL AND validation_status='verified';
SELECT src.citation_number,su.usage_type,su.citation_checked,su.claim_summary FROM source_usage su JOIN sources src ON src.source_id=su.source_id WHERE su.section_id=@section ORDER BY src.citation_number;