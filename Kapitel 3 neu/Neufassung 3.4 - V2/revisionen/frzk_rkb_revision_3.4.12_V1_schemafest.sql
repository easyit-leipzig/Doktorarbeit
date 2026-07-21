/* ============================================================
   FRZK-RKB Repository Update
   Kapitel 3.4.12
   Zusammenführung: Funktionale Raum-Zeit als dynamisches Organisationsprinzip

   Gleichungen: 3.1154 - 3.1166
   Definition: 3.4.81
   Lemma: 3.4.26
   Satz: 3.4.27
   Korollar: 3.4.22
   ============================================================ */

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4.12-V1';

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
 '3.4.12',
 '1.0-complete',
 'Zusammenführung der funktionalen Raum-Zeit-Struktur als dynamisches Organisationsprinzip.',
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
   Definition
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
(
 'Definition 3.4.81',
 @section_id,
 'Vollständige funktionale Raum-Zeit-Struktur',
 'Eine vollständige funktionale Raum-Zeit-Struktur verbindet Zustandsraum, Ereignisse, Relationen, Dynamik und Kopplungsstruktur.',
 '\\mathfrak{FRZ}_F=(\\Omega_F,\\mathcal E_F,\\mathcal R_F,\\mathcal D_F,\\mathcal C_F)',
 '\\mathfrak{FRZ}_F=(\\Omega_F,\\mathcal E_F,\\mathcal R_F,\\mathcal D_F,\\mathcal C_F)',
 'original',
 NULL,
 'Funktionaler Zustandsraum, Relationen und Dynamikoperator vorhanden.',
 'Abschlussdefinition Kapitel 3.4.',
 'checked',
 @revision_id
);


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
(
 'Lemma 3.4.26',
 @section_id,
 'Rekonstruierbarkeit funktionaler Raum-Zeit',
 'Aus funktionalem Zustandsraum, Relationsstruktur und Dynamikoperator kann eine dynamische funktionale Raum-Zeit-Struktur rekonstruiert werden.',
 '\\left(\\Omega_F,\\mathcal R_F,\\mathcal D_F\\right)\\Rightarrow\\mathfrak{RZ}_F^{dyn}',
 '\\left(\\Omega_F,\\mathcal R_F,\\mathcal D_F\\right)\\Rightarrow\\mathfrak{RZ}_F^{dyn}',
 'original',
 NULL,
 'Definition funktionaler Relationen.',
 'checked',
 @revision_id
);


/* ============================================================
   Satz
   ============================================================ */

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
VALUES
(
 'Satz 3.4.27',
 @section_id,
 'Funktionale Raum-Zeit als Organisationsprinzip',
 'Eine funktionale Raum-Zeit-Struktur mit kohärenzerhaltendem Dynamikoperator bildet ein geschlossenes Organisationssystem.',
 '\\mathfrak{FRZ}_F+\\mathcal D_F\\Rightarrow\\mathcal O_F^{global}',
 '\\mathfrak{FRZ}_F+\\mathcal D_F\\Rightarrow\\mathcal O_F^{global}',
 'original',
 NULL,
 'Dynamikoperator und funktionale Raum-Zeit-Struktur vorhanden.',
 'checked',
 @revision_id
);


/* ============================================================
   Korollar
   ============================================================ */

INSERT INTO corollaries
(
 corollary_number,
 section_id,
 title,
 statement_text,
 statement_latex,
 word_latex,
 parent_theorem_id,
 provenance,
 source_id,
 validation_status,
 created_revision_id
)
VALUES
(
 'Korollar 3.4.22',
 @section_id,
 'Organisation ist primär relational',
 'Die funktionale Organisation eines Systems ergibt sich aus der Struktur seiner Beziehungen.',
 '\\mathcal O_F=f(\\mathcal R_F)',
 '\\mathcal O_F=f(\\mathcal R_F)',
 NULL,
 'original',
 NULL,
 'checked',
 @revision_id
);


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

('3.1154',@section_id,'Funktionaler Zustandsraum',
'\\Omega_F(\\mathcal S)',
'\\Omega_F(\\mathcal S)',
'Funktionaler Zustandsraum.',
'definition','original',NULL,'checked',@revision_id),

('3.1155',@section_id,'Entwicklungsmodell funktionaler Organisation',
'\\text{Zustand}\\rightarrow\\text{Relation}\\rightarrow\\text{Raum-Zeit-Struktur}\\rightarrow\\text{Dynamik}\\rightarrow\\text{Emergenz}',
'\\text{Zustand}\\rightarrow\\text{Relation}\\rightarrow\\text{Raum-Zeit-Struktur}\\rightarrow\\text{Dynamik}\\rightarrow\\text{Emergenz}',
'Zusammenhang der Entwicklungsebenen.',
'model','original',NULL,'checked',@revision_id),

('3.1156',@section_id,'Funktionale Raum-Zeit-Struktur',
'\\mathfrak{RZ}_F=(\\mathcal E_F,\\blacktriangleright_F)',
'\\mathfrak{RZ}_F=(\\mathcal E_F,\\blacktriangleright_F)',
'Relationsstruktur der funktionalen Raum-Zeit.',
'definition','original',NULL,'checked',@revision_id),

('3.1157',@section_id,'Dynamische Raum-Zeit-Struktur',
'\\mathfrak{RZ}_F^{dyn}=(\\Omega_F,\\mathcal E_F,\\blacktriangleright_F,\\mathcal D_F)',
'\\mathfrak{RZ}_F^{dyn}=(\\Omega_F,\\mathcal E_F,\\blacktriangleright_F,\\mathcal D_F)',
'Erweiterte dynamische Struktur.',
'model','original',NULL,'checked',@revision_id),

('3.1158',@section_id,'Vollständige funktionale Struktur',
'\\mathfrak{FRZ}_F=(\\Omega_F,\\mathcal E_F,\\mathcal R_F,\\mathcal D_F,\\mathcal C_F)',
'\\mathfrak{FRZ}_F=(\\Omega_F,\\mathcal E_F,\\mathcal R_F,\\mathcal D_F,\\mathcal C_F)',
'Vollständiges Organisationsmodell.',
'model','original',NULL,'checked',@revision_id),

('3.1159',@section_id,'Rekonstruktionsfolge',
'\\mathcal R_F\\rightarrow\\Omega_F\\rightarrow\\mathcal E_F\\rightarrow\\mathfrak{RZ}_F^{dyn}',
'\\mathcal R_F\\rightarrow\\Omega_F\\rightarrow\\mathcal E_F\\rightarrow\\mathfrak{RZ}_F^{dyn}',
'Rekonstruktion funktionaler Raum-Zeit.',
'model','original',NULL,'checked',@revision_id),

('3.1163',@section_id,'Raum Zeit Operator Organisation',
'\\text{Raum}+\\text{Zeit}+\\text{Operator}=\\text{funktionale Organisation}',
'\\text{Raum}+\\text{Zeit}+\\text{Operator}=\\text{funktionale Organisation}',
'Strukturelle Beziehung.',
'model','original',NULL,'checked',@revision_id),

('3.1164',@section_id,'Globale Organisation',
'\\mathfrak{FRZ}_F+\\mathcal D_F\\Rightarrow\\mathcal O_F^{global}',
'\\mathfrak{FRZ}_F+\\mathcal D_F\\Rightarrow\\mathcal O_F^{global}',
'Globale funktionale Organisation.',
'theorem','original',NULL,'checked',@revision_id),

('3.1165',@section_id,'Relationale Organisation',
'\\mathcal O_F=f(\\mathcal R_F)',
'\\mathcal O_F=f(\\mathcal R_F)',
'Organisation aus Relationen.',
'model','original',NULL,'checked',@revision_id),

('3.1166',@section_id,'Gesamtentwicklung FRZK',
'\\Omega_F\\rightarrow\\mathcal R_F\\rightarrow\\mathfrak{RZ}_F\\rightarrow\\mathcal D_F\\rightarrow\\mathcal E_F\\rightarrow\\mathcal{SO}_F',
'\\Omega_F\\rightarrow\\mathcal R_F\\rightarrow\\mathfrak{RZ}_F\\rightarrow\\mathcal D_F\\rightarrow\\mathcal E_F\\rightarrow\\mathcal{SO}_F',
'Gesamtentwicklung funktionaler Organisation.',
'model','original',NULL,'checked',@revision_id);


INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_repository_revision','RKB-REV-K3.4.12-V1'),
('next_equation_number','3.1167')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
