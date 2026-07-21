/* ============================================================
   FRZK-RKB Repository Update
   Abschnitt 3.4.11.3
   Der funktionale Dynamikoperator

   Gleichungen: 3.1072 - 3.1089
   Definitionen: 3.4.65 - 3.4.67
   Lemma: 3.4.21
   Satz: 3.4.22
   Korollar: 3.4.17
   ============================================================ */

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4.11.3-V1';

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO repository_revisions
(
 revision_code,
 revision_date,
 scope_type,
 scope_reference,
 version_label,
 summary,
 created_by,
 parent_revision_id
)
SELECT
 @revision_code,
 NOW(),
 'section',
 '3.4.11.3',
 '1.0-complete',
 'Einführung des funktionalen Dynamikoperators und Erweiterung zur dynamischen Raum-Zeit-Struktur.',
 'Olaf Thiele / ChatGPT',
 NULL
WHERE NOT EXISTS
(
 SELECT 1 FROM repository_revisions
 WHERE revision_code=@revision_code
);

SELECT revision_id INTO @revision_id
FROM repository_revisions
WHERE revision_code=@revision_code
LIMIT 1;


/* ============================================================
   Gleichungen
   ============================================================ */

INSERT INTO equations
(
equation_number,
section_id,
title,
equation_latex,
word_latex,
plain_description,
equation_type,
provenance,
source_id,
validation_status,
created_revision_id
)
VALUES

('3.1072',@section_id,'Elementarer funktionaler Operator',
'O_F:z_F\\rightarrow z_F''',
'O_F:z_F\\rightarrow z_F''',
'Einzelner funktionaler Zustandsübergang.',
'definition','original',NULL,'checked',@revision_id),

('3.1073',@section_id,'Funktionaler Dynamikoperator',
'\\mathcal D_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'\\mathcal D_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'Abbildung des funktionalen Zustandsraums auf sich selbst.',
'definition','original',NULL,'checked',@revision_id),

('3.1074',@section_id,'Definition Dynamikoperator',
'\\mathcal D_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'\\mathcal D_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'Funktionaler Dynamikoperator.',
'definition','original',NULL,'checked',@revision_id),

('3.1075',@section_id,'Zustandsbereich Dynamikoperator',
'z_F^{(k)}\\in\\Omega_F(\\mathcal S)',
'z_F^{(k)}\\in\\Omega_F(\\mathcal S)',
'Zulässiger Zustand.',
'definition','original',NULL,'checked',@revision_id),

('3.1076',@section_id,'Dynamische Zustandsentwicklung',
'z_F^{(k+1)}=\\mathcal D_F(z_F^{(k)})',
'z_F^{(k+1)}=\\mathcal D_F(z_F^{(k)})',
'Entwicklung durch den Dynamikoperator.',
'definition','original',NULL,'checked',@revision_id),

('3.1077',@section_id,'Komposition der Operatorsequenz',
'\\mathcal D_F=O_{F,n}\\circ O_{F,n-1}\\circ...\\circ O_{F,1}',
'\\mathcal D_F=O_{F,n}\\circ O_{F,n-1}\\circ...\\circ O_{F,1}',
'Zusammenfassung einer Operatorsequenz.',
'model','original',NULL,'checked',@revision_id),

('3.1078',@section_id,'Kohärenzerhaltender Dynamikoperator',
'z_F\\in\\Omega_F^K(\\mathcal S)\\Rightarrow\\mathcal D_F(z_F)\\in\\Omega_F^K(\\mathcal S)',
'z_F\\in\\Omega_F^K(\\mathcal S)\\Rightarrow\\mathcal D_F(z_F)\\in\\Omega_F^K(\\mathcal S)',
'Erhaltung kohärenter Zustände.',
'definition','original',NULL,'checked',@revision_id),

('3.1079',@section_id,'Verkettung kohärenzerhaltender Operatoren',
'O_{F,i}\\in\\mathcal O_F^K\\forall i\\Rightarrow\\mathcal D_F\\in\\mathcal O_F^K',
'O_{F,i}\\in\\mathcal O_F^K\\forall i\\Rightarrow\\mathcal D_F\\in\\mathcal O_F^K',
'Kohärenzerhaltung der Operatorverkettung.',
'theorem','original',NULL,'checked',@revision_id),

('3.1082',@section_id,'Erhaltung durch Dynamikoperator',
'\\mathcal D_F(z_F^{(0)})\\in\\Omega_F^K(\\mathcal S)',
'\\mathcal D_F(z_F^{(0)})\\in\\Omega_F^K(\\mathcal S)',
'Resultat der Kohärenzerhaltung.',
'theorem','original',NULL,'checked',@revision_id),

('3.1084',@section_id,'Dynamische Raum-Zeit-Struktur',
'\\mathfrak{RZ}_F^{dyn}=(\\mathfrak{RZ}_F,\\mathcal D_F)',
'\\mathfrak{RZ}_F^{dyn}=(\\mathfrak{RZ}_F,\\mathcal D_F)',
'Erweiterung der Raum-Zeit-Struktur um Dynamik.',
'model','original',NULL,'checked',@revision_id),

('3.1086',@section_id,'Kohärenter Dynamikoperator',
'\\mathcal D_F:\\Omega_F^K\\rightarrow\\Omega_F^K',
'\\mathcal D_F:\\Omega_F^K\\rightarrow\\Omega_F^K',
'Kohärenzerhaltende Entwicklung.',
'definition','original',NULL,'checked',@revision_id),

('3.1087',@section_id,'Dynamische Erweiterung',
'\\mathfrak{RZ}_F^{dyn}',
'\\mathfrak{RZ}_F^{dyn}',
'Dynamische funktionale Raum-Zeit-Struktur.',
'model','original',NULL,'checked',@revision_id),

('3.1088',@section_id,'Entwicklungspfad',
'z_F^{(0)}\\rightarrow z_F^{(1)}\\rightarrow z_F^{(2)}\\rightarrow...',
'z_F^{(0)}\\rightarrow z_F^{(1)}\\rightarrow z_F^{(2)}\\rightarrow...',
'Fortgesetzte Zustandsentwicklung.',
'model','original',NULL,'checked',@revision_id),

('3.1089',@section_id,'Dynamik als Struktur-Erweiterung',
'\\mathfrak{RZ}_F+\\mathcal D_F=\\mathfrak{RZ}_F^{dyn}',
'\\mathfrak{RZ}_F+\\mathcal D_F=\\mathfrak{RZ}_F^{dyn}',
'Verbindung von Struktur und Dynamik.',
'model','original',NULL,'checked',@revision_id);


/* ============================================================
   Definitionen
   ============================================================ */

INSERT INTO definitions
(
definition_number,
section_id,
title,
definition_text,
formal_latex,
word_latex,
provenance,
source_id,
assumptions,
notes,
validation_status,
created_revision_id
)
VALUES

('Definition 3.4.65',@section_id,
'Funktionaler Dynamikoperator',
'Der funktionale Dynamikoperator ist eine Abbildung des funktionalen Zustandsraums auf sich selbst.',
'\\mathcal D_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'\\mathcal D_F:\\Omega_F(\\mathcal S)\\rightarrow\\Omega_F(\\mathcal S)',
'original',NULL,
'Funktionaler Zustandsraum vorhanden.',
'Grundlage der dynamischen Erweiterung.',
'checked',@revision_id),

('Definition 3.4.66',@section_id,
'Kohärenzerhaltender Dynamikoperator',
'Ein Dynamikoperator heißt kohärenzerhaltend, wenn kohärente Zustände in kohärente Zustände überführt werden.',
'z_F\\in\\Omega_F^K\\Rightarrow\\mathcal D_F(z_F)\\in\\Omega_F^K',
'z_F\\in\\Omega_F^K\\Rightarrow\\mathcal D_F(z_F)\\in\\Omega_F^K',
'original',NULL,
'Kohärenter Zustandsraum.',
'Erweiterung der Operator-Kohärenz.',
'checked',@revision_id),

('Definition 3.4.67',@section_id,
'Dynamische funktionale Raum-Zeit-Struktur',
'Eine funktionale Raum-Zeit-Struktur mit Dynamikoperator wird als dynamische funktionale Raum-Zeit-Struktur bezeichnet.',
'\\mathfrak{RZ}_F^{dyn}=(\\mathfrak{RZ}_F,\\mathcal D_F)',
'\\mathfrak{RZ}_F^{dyn}=(\\mathfrak{RZ}_F,\\mathcal D_F)',
'original',NULL,
'Existenz einer funktionalen Raum-Zeit-Struktur.',
'Verbindung von Struktur und Entwicklung.',
'checked',@revision_id);


/* ============================================================
   Lemma
   ============================================================ */

INSERT INTO lemmas
(
lemma_number,
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
VALUES

('Lemma 3.4.21',@section_id,
'Verkettung kohärenzerhaltender Operatoren',
'Sind alle Operatoren einer Sequenz kohärenzerhaltend, dann ist auch der Dynamikoperator kohärenzerhaltend.',
'O_{F,i}\\in\\mathcal O_F^K\\Rightarrow\\mathcal D_F\\in\\mathcal O_F^K',
'O_{F,i}\\in\\mathcal O_F^K\\Rightarrow\\mathcal D_F\\in\\mathcal O_F^K',
'original',NULL,
'Definition 3.4.66.',
'checked',@revision_id);


/* Satz und Korollar */

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES

('Satz 3.4.22',@section_id,
'Existenz einer dynamischen Raum-Zeit-Struktur',
'Existiert ein kohärenzerhaltender Dynamikoperator, dann existiert eine dynamische Erweiterung der funktionalen Raum-Zeit-Struktur.',
'\\mathfrak{RZ}_F\\Rightarrow\\mathfrak{RZ}_F^{dyn}',
'\\mathfrak{RZ}_F\\Rightarrow\\mathfrak{RZ}_F^{dyn}',
'original',NULL,
'Definition 3.4.67.',
'checked',@revision_id);


INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,provenance,source_id,validation_status,created_revision_id)
VALUES

('Korollar 3.4.17',@section_id,
'Dynamik als Erweiterung der Struktur',
'Die Dynamik ergänzt die funktionale Raum-Zeit-Struktur um eine Entwicklungsregel.',
'\\mathfrak{RZ}_F+\\mathcal D_F=\\mathfrak{RZ}_F^{dyn}',
'\\mathfrak{RZ}_F+\\mathcal D_F=\\mathfrak{RZ}_F^{dyn}',
NULL,'original',NULL,'checked',@revision_id);


/* Literatur */
INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 48,
 'strogatz_nonlinear_dynamics',
 'Nonlinear Dynamics and Chaos'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);

INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 49,
 'hirsch_smale_devaney_dynamical_systems',
 'Differential Equations, Dynamical Systems, and an Introduction to Chaos'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);


INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_repository_revision','RKB-REV-K3.4.11.3-V1'),
('next_equation_number','3.1090')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
