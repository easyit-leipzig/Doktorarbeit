/* ============================================================
   FRZK-RKB Repository Update
   Abschnitt 3.4.11.4
   Stabilität funktionaler Dynamiken

   Gleichungen: 3.1090 - 3.1105
   Definitionen: 3.4.68 - 3.4.70
   Lemma: 3.4.22
   Satz: 3.4.23
   Korollar: 3.4.18
   ============================================================ */

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4.11.4-V1';

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
@revision_code,NOW(),'section','3.4.11.4','1.0-complete',
'Stabilität funktionaler Dynamiken: stabile Bereiche, Attraktoren und kohärenzerhaltende Entwicklung.',
'Olaf Thiele / ChatGPT',NULL
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SELECT revision_id INTO @revision_id
FROM repository_revisions
WHERE revision_code=@revision_code
LIMIT 1;


/* Gleichungen */

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,validation_status,created_revision_id)
VALUES

('3.1090',@section_id,'Veränderter funktionaler Zustand',
'z_F^{(k)}\\neq z_F^{(k+1)}',
'z_F^{(k)}\\neq z_F^{(k+1)}',
'Zustandsänderung ohne notwendigen Kohärenzverlust.',
'definition','original',NULL,'checked',@revision_id),

('3.1091',@section_id,'Kohärenzerhaltender Übergang',
'O_{F,k+1}(z_F^{(k)})\\in\\Omega_F^K(\\mathcal S)',
'O_{F,k+1}(z_F^{(k)})\\in\\Omega_F^K(\\mathcal S)',
'Zulässiger kohärenter Übergang.',
'definition','original',NULL,'checked',@revision_id),

('3.1092',@section_id,'Funktionale Stabilitätsbedingung',
'z_F^{(k)}\\in[z_F]_{\\sim_F}\\Rightarrow z_F^{(k+n)}\\in[z_F]_{\\sim_F}',
'z_F^{(k)}\\in[z_F]_{\\sim_F}\\Rightarrow z_F^{(k+n)}\\in[z_F]_{\\sim_F}',
'Erhaltung funktionaler Identität.',
'definition','original',NULL,'checked',@revision_id),

('3.1093',@section_id,'Kohärenzstabiler Dynamikbereich',
'\\mathcal B_F\\subset\\Omega_F(\\mathcal S)',
'\\mathcal B_F\\subset\\Omega_F(\\mathcal S)',
'Teilmenge des funktionalen Zustandsraums.',
'definition','original',NULL,'checked',@revision_id),

('3.1094',@section_id,'Invarianz des Dynamikbereiches',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'Der Dynamikbereich bleibt erhalten.',
'definition','original',NULL,'checked',@revision_id),

('3.1096',@section_id,'Invarianzbedingung',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'Grundlage der Stabilität.',
'theorem','original',NULL,'checked',@revision_id),

('3.1099',@section_id,'Funktionaler Attraktor',
'\\mathcal A_F\\subset\\Omega_F(\\mathcal S)',
'\\mathcal A_F\\subset\\Omega_F(\\mathcal S)',
'Stabile funktionale Zustandsmenge.',
'definition','original',NULL,'checked',@revision_id),

('3.1100',@section_id,'Einzugsbereich Attraktor',
'\\mathcal U_F\\subset\\Omega_F(\\mathcal S)',
'\\mathcal U_F\\subset\\Omega_F(\\mathcal S)',
'Bereich möglicher Anfangszustände.',
'definition','original',NULL,'checked',@revision_id),

('3.1101',@section_id,'Attraktorbedingung',
'\\lim_{n\\rightarrow\\infty}\\mathcal D_F^n(z_F)\\in\\mathcal A_F',
'\\lim_{n\\rightarrow\\infty}\\mathcal D_F^n(z_F)\\in\\mathcal A_F',
'Langfristige Annäherung an Attraktor.',
'theorem','original',NULL,'checked',@revision_id),

('3.1105',@section_id,'Emergente funktionale Organisation',
'z_F^{(i)},z_F^{(j)}\\in\\mathcal U_F\\Rightarrow\\mathcal D_F^n(z_F^{(i)}),\\mathcal D_F^n(z_F^{(j)})\\rightarrow\\mathcal A_F',
'z_F^{(i)},z_F^{(j)}\\in\\mathcal U_F\\Rightarrow\\mathcal D_F^n(z_F^{(i)}),\\mathcal D_F^n(z_F^{(j)})\\rightarrow\\mathcal A_F',
'Gemeinsame Attraktorentwicklung.',
'model','original',NULL,'checked',@revision_id);


/* Definitionen */

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES

('Definition 3.4.68',@section_id,
'Funktionale Stabilität',
'Ein funktionaler Zustand bleibt stabil, wenn seine Entwicklung innerhalb derselben funktionalen Kohärenzklasse verbleibt.',
'z_F^{(k)}\\in[z_F]_{\\sim_F}\\Rightarrow z_F^{(k+n)}\\in[z_F]_{\\sim_F}',
'z_F^{(k)}\\in[z_F]_{\\sim_F}\\Rightarrow z_F^{(k+n)}\\in[z_F]_{\\sim_F}',
'original',NULL,
'Funktionale Äquivalenzrelation.',
'Stabilität als Strukturerhaltung.',
'checked',@revision_id),

('Definition 3.4.69',@section_id,
'Kohärenzstabiler Dynamikbereich',
'Ein Bereich heißt kohärenzstabil, wenn er durch den Dynamikoperator invariant bleibt.',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'original',NULL,
'Dynamikoperator definiert.',
'Invarianter Entwicklungsbereich.',
'checked',@revision_id),

('Definition 3.4.70',@section_id,
'Funktionaler Attraktor',
'Eine funktionale Zustandsmenge ist Attraktor, wenn Entwicklungen aus einem Einzugsbereich langfristig in diese Menge führen.',
'\\lim_{n\\rightarrow\\infty}\\mathcal D_F^n(z_F)\\in\\mathcal A_F',
'\\lim_{n\\rightarrow\\infty}\\mathcal D_F^n(z_F)\\in\\mathcal A_F',
'original',NULL,
'Dynamikoperator vorhanden.',
'Erweiterung klassischer Attraktorkonzepte.',
'checked',@revision_id);


/* Lemma */

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES

('Lemma 3.4.22',@section_id,
'Invarianz kohärenzstabiler Bereiche',
'Ist ein Bereich unter dem Dynamikoperator invariant, verbleibt jede dort gestartete Trajektorie innerhalb dieses Bereiches.',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'\\mathcal D_F(\\mathcal B_F)\\subseteq\\mathcal B_F',
'original',NULL,
'Definition 3.4.69.',
'checked',@revision_id);


/* Satz */

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES

('Satz 3.4.23',@section_id,
'Stabilität durch funktionale Attraktoren',
'Besitzt eine funktionale Dynamik einen Attraktor, können unterschiedliche Anfangszustände dieselbe funktionale Organisation erreichen.',
'\\mathcal D_F^n(z_F)\\rightarrow\\mathcal A_F',
'\\mathcal D_F^n(z_F)\\rightarrow\\mathcal A_F',
'original',NULL,
'Definition 3.4.70.',
'checked',@revision_id);


/* Korollar */

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,provenance,source_id,validation_status,created_revision_id)
VALUES

('Korollar 3.4.18',@section_id,
'Emergenz stabiler funktionaler Organisation',
'Unterschiedliche Anfangszustände können durch dieselbe Attraktorstruktur verbunden werden.',
'\\mathcal D_F^n(z_F^{(i)}),\\mathcal D_F^n(z_F^{(j)})\\rightarrow\\mathcal A_F',
'\\mathcal D_F^n(z_F^{(i)}),\\mathcal D_F^n(z_F^{(j)})\\rightarrow\\mathcal A_F',
NULL,'original',NULL,'checked',@revision_id);


INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_repository_revision','RKB-REV-K3.4.11.4-V1'),
('next_equation_number','3.1106')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
