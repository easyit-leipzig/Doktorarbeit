/* FRZK-RKB Revision 3.4.11.1-3.4.11.2
   Dynamik funktionaler Raum-Zeit-Strukturen
   Gleichungen 3.1056-3.1071
*/

START TRANSACTION;

SET @revision_code='RKB-REV-K3.4.11.1-V1';

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
@revision_code,NOW(),'section','3.4.11.1-3.4.11.2','1.0-complete',
'Dynamik funktionaler Raum-Zeit-Strukturen: Operatorsequenzen und funktionale Trajektorien.',
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
('3.1056',@section_id,'Übergang Struktur zu Dynamik','\\text{funktionale Raum-Zeit-Struktur}\\rightarrow\\text{funktionale Dynamik}','\\text{funktionale Raum-Zeit-Struktur}\\rightarrow\\text{funktionale Dynamik}','Übergang von Struktur zu Dynamik','model','original',NULL,'checked',@revision_id),
('3.1057',@section_id,'Funktionaler Zustand','z_F^{(k)}\\in\\Omega_F(\\mathcal S)','z_F^{(k)}\\in\\Omega_F(\\mathcal S)','Zustand im funktionalen Zustandsraum','definition','original',NULL,'checked',@revision_id),
('3.1058',@section_id,'Operatorischer Zustandsübergang','z_F^{(k+1)}=O_{F,k+1}(z_F^{(k)})','z_F^{(k+1)}=O_{F,k+1}(z_F^{(k)})','Übergang durch Operatorwirkung','definition','original',NULL,'checked',@revision_id),
('3.1059',@section_id,'Funktionale Operatorsequenz','\\mathcal O_F^{(n)}=(O_{F,1},O_{F,2},...,O_{F,n})','\\mathcal O_F^{(n)}=(O_{F,1},O_{F,2},...,O_{F,n})','Geordnete Operatorfolge','definition','original',NULL,'checked',@revision_id),
('3.1061',@section_id,'Zustandsfolge','\\mathcal Z_F^{(n)}=(z_F^{(0)},...,z_F^{(n)})','\\mathcal Z_F^{(n)}=(z_F^{(0)},...,z_F^{(n)})','Entwicklungsfolge funktionaler Zustände','definition','original',NULL,'checked',@revision_id),
('3.1063',@section_id,'Hierarchie funktionaler Dynamik','\\Omega_F\\rightarrow\\mathcal O_F\\rightarrow\\mathcal Z_F\\rightarrow\\mathfrak{RZ}_F\\rightarrow\\mathcal D_F','\\Omega_F\\rightarrow\\mathcal O_F\\rightarrow\\mathcal Z_F\\rightarrow\\mathfrak{RZ}_F\\rightarrow\\mathcal D_F','Zusammenhang der Strukturebenen','model','original',NULL,'checked',@revision_id),
('3.1064',@section_id,'Funktionale Trajektorie','\\gamma_F^{(n)}=(z_F^{(0)},...,z_F^{(n)})','\\gamma_F^{(n)}=(z_F^{(0)},...,z_F^{(n)})','Geordnete Zustandsfolge','definition','original',NULL,'checked',@revision_id),
('3.1066',@section_id,'Ereignistrajektorie','\\Gamma_F^{(n)}=(\\varepsilon_F^{(0)},...,\\varepsilon_F^{(n)})','\\Gamma_F^{(n)}=(\\varepsilon_F^{(0)},...,\\varepsilon_F^{(n)})','Raum-Zeit-Abbildung der Trajektorie','definition','original',NULL,'checked',@revision_id),
('3.1071',@section_id,'Raum-Zeit-Nachbarschaft einer Trajektorie','\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}','\\varepsilon_F^{(k)}\\blacktriangleright_F\\varepsilon_F^{(k+1)}','Jede Trajektorie erzeugt einen Raum-Zeit-Pfad','theorem','original',NULL,'checked',@revision_id);

/* Definitionen */
INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,notes,validation_status,created_revision_id)
VALUES
('Definition 3.4.63',@section_id,'Funktionale Operatorsequenz',
'Eine funktionale Operatorsequenz ist eine geordnete Folge zulässiger funktionaler Operatoren.',
'\\mathcal O_F^{(n)}=(O_{F,1},...,O_{F,n})',
'\\mathcal O_F^{(n)}=(O_{F,1},...,O_{F,n})',
'original',NULL,'Zulässige Operatoren.','Grundlage funktionaler Dynamik.','checked',@revision_id),
('Definition 3.4.64',@section_id,'Funktionale Trajektorie',
'Eine funktionale Trajektorie ist eine geordnete Folge funktionaler Zustände.',
'\\gamma_F^{(n)}=(z_F^{(0)},...,z_F^{(n)})',
'\\gamma_F^{(n)}=(z_F^{(0)},...,z_F^{(n)})',
'original',NULL,'Operatorsequenz vorhanden.','Verbindung von Dynamik und Raum-Zeit.','checked',@revision_id);

/* Lemma */
INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.20',@section_id,'Jede funktionale Trajektorie erzeugt einen Raum-Zeit-Pfad',
'Für jede funktionale Trajektorie existiert eine zugehörige Ereignistrajektorie.',
'\\gamma_F^{(n)}\\Rightarrow\\Gamma_F^{(n)}',
'\\gamma_F^{(n)}\\Rightarrow\\Gamma_F^{(n)}',
'original',NULL,'Definitionen 3.4.50 und 3.4.64.','checked',@revision_id);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_repository_revision','RKB-REV-K3.4.11.1-V1'),
('next_equation_number','3.1072')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;
