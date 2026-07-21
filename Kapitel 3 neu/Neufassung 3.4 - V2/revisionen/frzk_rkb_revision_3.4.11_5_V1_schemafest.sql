/* ============================================================
   FRZK-RKB Repository Update
   Abschnitt 3.4.11.5
   Instabilität, Übergänge und funktionale Kipppunkte

   Gleichungen: 3.1106 - 3.1122
   Definitionen: 3.4.71 - 3.4.74
   Lemma: 3.4.23
   Satz: 3.4.24
   Korollar: 3.4.19
   ============================================================ */

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4.11.5-V1';

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
 '3.4.11.5',
 '1.0-complete',
 'Instabilität, Übergänge und funktionale Kipppunkte innerhalb funktionaler Dynamiken.',
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

('3.1106',@section_id,'Kohärenzklasse',
'[z_F]_{\\sim_F}',
'[z_F]_{\\sim_F}',
'Funktionale Äquivalenzklasse.',
'definition','original',NULL,'checked',@revision_id),

('3.1107',@section_id,'Stabile Entwicklung',
'\\mathcal D_F(z_F)\\in[z_F]_{\\sim_F}',
'\\mathcal D_F(z_F)\\in[z_F]_{\\sim_F}',
'Erhaltung der funktionalen Identität.',
'definition','original',NULL,'checked',@revision_id),

('3.1108',@section_id,'Instabile Entwicklung',
'\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}',
'\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}',
'Verlassen der bisherigen Kohärenzklasse.',
'definition','original',NULL,'checked',@revision_id),

('3.1109',@section_id,'Definition funktionaler Instabilität',
'z_F\\in[z_F]_{\\sim_F}\\land\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}',
'z_F\\in[z_F]_{\\sim_F}\\land\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}',
'Bedingung funktionaler Instabilität.',
'definition','original',NULL,'checked',@revision_id),

('3.1110',@section_id,'Stabilitätsdomäne',
'\\mathcal S_F^{stab}\\subset\\Omega_F(\\mathcal S)',
'\\mathcal S_F^{stab}\\subset\\Omega_F(\\mathcal S)',
'Stabiler Bereich funktionaler Zustände.',
'definition','original',NULL,'checked',@revision_id),

('3.1111',@section_id,'Invariante Stabilitätsdomäne',
'\\forall z_F\\in\\mathcal S_F^{stab}:\\mathcal D_F(z_F)\\in\\mathcal S_F^{stab}',
'\\forall z_F\\in\\mathcal S_F^{stab}:\\mathcal D_F(z_F)\\in\\mathcal S_F^{stab}',
'Erhaltung der Stabilitätsdomäne.',
'definition','original',NULL,'checked',@revision_id),

('3.1112',@section_id,'Übergangszustandsmenge',
'z_F\\in\\Omega_F^{trans}\\subset\\Omega_F(\\mathcal S)',
'z_F\\in\\Omega_F^{trans}\\subset\\Omega_F(\\mathcal S)',
'Funktionaler Übergangsbereich.',
'definition','original',NULL,'checked',@revision_id),

('3.1113',@section_id,'Mehrdeutige Attraktorentwicklung',
'\\exists\\mathcal A_F^{(1)},\\mathcal A_F^{(2)}:\\mathcal D_F^n(z_F)\\rightarrow\\mathcal A_F^{(1)}\\lor\\mathcal A_F^{(2)}',
'\\exists\\mathcal A_F^{(1)},\\mathcal A_F^{(2)}:\\mathcal D_F^n(z_F)\\rightarrow\\mathcal A_F^{(1)}\\lor\\mathcal A_F^{(2)}',
'Mögliche Entwicklung zu mehreren Attraktoren.',
'model','original',NULL,'checked',@revision_id),

('3.1116',@section_id,'Neue Kohärenzklasse',
'[z_F^{\\prime}]_{\\sim_F}',
'[z_F^{\\prime}]_{\\sim_F}',
'Alternative funktionale Organisationsklasse.',
'definition','original',NULL,'checked',@revision_id),

('3.1117',@section_id,'Kritischer Zustand',
'z_F^{crit}',
'z_F^{crit}',
'Zustand am funktionalen Kipppunkt.',
'definition','original',NULL,'checked',@revision_id),

('3.1118',@section_id,'Attraktoränderung durch Operatoränderung',
'\\Delta O_F\\rightarrow\\Delta\\mathcal A_F',
'\\Delta O_F\\rightarrow\\Delta\\mathcal A_F',
'Änderung des Attraktors durch veränderte Operatorbedingungen.',
'model','original',NULL,'checked',@revision_id),

('3.1119',@section_id,'Unterschiedliche Attraktoren',
'\\mathcal A_F^{(1)}\\neq\\mathcal A_F^{(2)}',
'\\mathcal A_F^{(1)}\\neq\\mathcal A_F^{(2)}',
'Nichtidentität funktionaler Attraktoren.',
'definition','original',NULL,'checked',@revision_id),

('3.1120',@section_id,'Neue Attraktorentwicklung',
'\\mathcal D_F^n(z_F)\\rightarrow\\mathcal A_F^{(2)}',
'\\mathcal D_F^n(z_F)\\rightarrow\\mathcal A_F^{(2)}',
'Übergang zu neuer Organisationsform.',
'model','original',NULL,'checked',@revision_id),

('3.1121',@section_id,'Strukturänderung durch Organisationänderung',
'\\Delta\\mathcal O_F\\Rightarrow\\Delta\\mathfrak{RZ}_F',
'\\Delta\\mathcal O_F\\Rightarrow\\Delta\\mathfrak{RZ}_F',
'Veränderung der Raum-Zeit-Struktur.',
'model','original',NULL,'checked',@revision_id),

('3.1122',@section_id,'Entwicklungszyklus funktionaler Organisation',
'\\text{Stabilität}\\rightarrow\\text{Instabilität}\\rightarrow\\text{Übergang}\\rightarrow\\text{neue Stabilität}',
'\\text{Stabilität}\\rightarrow\\text{Instabilität}\\rightarrow\\text{Übergang}\\rightarrow\\text{neue Stabilität}',
'Zyklus funktionaler Entwicklung.',
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

('Definition 3.4.71',@section_id,
'Funktionale Instabilität',
'Ein Zustand ist funktional instabil, wenn seine Entwicklung seine bisherige Kohärenzklasse verlässt.',
'z_F\\in[z_F]_{\\sim_F}\\land\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}',
'z_F\\in[z_F]_{\\sim_F}\\land\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}',
'original',NULL,
'Kohärenzklasse definiert.',
'Grundlage funktionaler Übergänge.',
'checked',@revision_id),

('Definition 3.4.72',@section_id,
'Funktionale Stabilitätsdomäne',
'Eine Stabilitätsdomäne ist ein unter dem Dynamikoperator invariantes Zustandsgebiet.',
'\\mathcal D_F(\\mathcal S_F^{stab})\\subseteq\\mathcal S_F^{stab}',
'\\mathcal D_F(\\mathcal S_F^{stab})\\subseteq\\mathcal S_F^{stab}',
'original',NULL,
'Dynamikoperator vorhanden.',
'Stabilitätsbereich.',
'checked',@revision_id),

('Definition 3.4.73',@section_id,
'Funktionaler Übergangszustand',
'Ein Übergangszustand ermöglicht mehrere zukünftige funktionale Organisationsformen.',
'\\Omega_F^{trans}',
'\\Omega_F^{trans}',
'original',NULL,
'Mehrere Attraktoren möglich.',
'Übergangsbereich.',
'checked',@revision_id),

('Definition 3.4.74',@section_id,
'Funktionaler Kipppunkt',
'Ein Kipppunkt ist ein Zustand, bei dem kleine Änderungen der Operatorbedingungen zu unterschiedlichen langfristigen Attraktoren führen.',
'z_F^{crit}',
'z_F^{crit}',
'original',NULL,
'Dynamische Entwicklung vorhanden.',
'Grenze verschiedener Entwicklungsregime.',
'checked',@revision_id);


/* ============================================================
   Lemma, Satz, Korollar
   ============================================================ */

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES

('Lemma 3.4.23',@section_id,
'Instabilität ermöglicht Strukturwechsel',
'Das Verlassen einer Kohärenzklasse ermöglicht den Übergang in eine neue stabile Organisationsform.',
'\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}\\Rightarrow[z_F^{\\prime}]_{\\sim_F}',
'\\mathcal D_F(z_F)\\notin[z_F]_{\\sim_F}\\Rightarrow[z_F^{\\prime}]_{\\sim_F}',
'original',NULL,
'Definition 3.4.71.',
'checked',@revision_id);


INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES

('Satz 3.4.24',@section_id,
'Übergang zwischen funktionalen Attraktoren',
'Nach Überschreiten eines Kipppunktes kann eine Dynamik von einem Attraktor zu einem anderen übergehen.',
'\\mathcal A_F^{(1)}\\rightarrow\\mathcal A_F^{(2)}',
'\\mathcal A_F^{(1)}\\rightarrow\\mathcal A_F^{(2)}',
'original',NULL,
'Definition 3.4.74.',
'checked',@revision_id);


INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,provenance,source_id,validation_status,created_revision_id)
VALUES

('Korollar 3.4.19',@section_id,
'Entwicklung durch Instabilität',
'Grundlegende funktionale Veränderungen erfordern das Verlassen einer bisherigen Stabilitätsdomäne.',
'\\Delta\\mathcal O_F\\Rightarrow\\Delta\\mathfrak{RZ}_F',
'\\Delta\\mathcal O_F\\Rightarrow\\Delta\\mathfrak{RZ}_F',
NULL,'original',NULL,'checked',@revision_id);


INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_repository_revision','RKB-REV-K3.4.11.5-V1'),
('next_equation_number','3.1123')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
