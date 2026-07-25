/* ============================================================
 FRZK Repository-Update
 Kapitel 3.8.7 – Verifikation und Validierung der Simulationsimplementierung
 Version 1.0
 Manuskript (3.531)–(3.555) -> Repository (3.1319)–(3.1343)
 Idempotentes MariaDB-Skript
 ============================================================ */

START TRANSACTION;

SET @revision_code := 'RKB-K3.8.7-V1';
SET @parent_section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.8' LIMIT 1
);
SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code IN ('RKB-K3.8.6-V1','RKB-K3.8.5-V1','RKB-K3.8.4-V1')
 ORDER BY CASE revision_code
   WHEN 'RKB-K3.8.6-V1' THEN 1
   WHEN 'RKB-K3.8.5-V1' THEN 2
   ELSE 3 END
 LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,
 summary,created_by,parent_revision_id)
SELECT
 @revision_code,NOW(),'section','3.8.7','1.0',
 'Verifikation und Validierung der Simulationsimplementierung: Operatorprüfung, Integration, Invarianten, Reproduzierbarkeit, Grenz- und Fehlerprüfung, Konvergenz, Modellvalidierung und Prüfstatus.',
 'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code
);

SET @revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code=@revision_code LIMIT 1
);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,
 is_original_contribution,notes)
SELECT
 @parent_section_id,'3.8.7',
 'Verifikation und Validierung der Simulationsimplementierung',
 3,3.8700,'draft',1,
 'Manuskriptgleichungen (3.531) bis (3.555); Repositorygleichungen (3.1319) bis (3.1343).'
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections WHERE section_code='3.8.7'
);

UPDATE dissertation_sections
SET parent_section_id=@parent_section_id,
    title='Verifikation und Validierung der Simulationsimplementierung',
    chapter_no=3,
    section_order=3.8700,
    status='draft',
    is_original_contribution=1,
    notes='Manuskriptgleichungen (3.531) bis (3.555); Repositorygleichungen (3.1319) bis (3.1343).'
WHERE section_code='3.8.7';

SET @section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.8.7' LIMIT 1
);


/* ============================================================
 Quellen [120] und [121]
 ============================================================ */

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,
 year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,
 url,language_code,priority,evidence_type,frzk_relevance,
 verification_status,first_citation_section_code,first_citation_note,
 full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
 120,'oberkampf_roy_verification_validation_2010','book',
 'Verification and Validation in Scientific Computing',NULL,
 2010,2010,NULL,'Cambridge University Press','Cambridge',
 NULL,NULL,NULL,'First Edition',NULL,'978-0-521-11360-1',NULL,
 'en',1,'textbook',10,'bibliographic','3.8.7',
 'Erstnennung zur Trennung von Verifikation und Validierung.',
 'Oberkampf, William L.; Roy, Christopher J. (2010): Verification and Validation in Scientific Computing. Cambridge: Cambridge University Press.',
 'Oberkampf und Roy (2010) [120]',
 'Grundlagenwerk zur Verifikation und Validierung wissenschaftlicher Rechenmodelle.',
 @revision_id
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=120 OR source_key='oberkampf_roy_verification_validation_2010'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,
 year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,
 url,language_code,priority,evidence_type,frzk_relevance,
 verification_status,first_citation_section_code,first_citation_note,
 full_citation_text,short_citation_text,notes,created_revision_id)
SELECT
 121,'sargent_verification_validation_simulation_2013','journal_article',
 'Verification and Validation of Simulation Models',NULL,
 2013,2013,'Journal of Simulation',NULL,NULL,'7','1','12-24',NULL,
 '10.1057/jos.2012.20',NULL,NULL,'en',1,'journal_article',10,
 'bibliographic','3.8.7',
 'Erstnennung zur mehrstufigen Prüfung von Simulationsmodellen.',
 'Sargent, Robert G. (2013): Verification and Validation of Simulation Models. Journal of Simulation, 7(1), 12-24. DOI: 10.1057/jos.2012.20.',
 'Sargent (2013) [121]',
 'Fachbeitrag zur Verifikation und Validierung von Simulationsmodellen.',
 @revision_id
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=121 OR source_key='sargent_verification_validation_simulation_2013'
);

SET @source_120 := (SELECT source_id FROM sources WHERE citation_number=120 LIMIT 1);
SET @source_121 := (SELECT source_id FROM sources WHERE citation_number=121 LIMIT 1);

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Oberkampf','William L.','Oberkampf, William L.',NULL,NULL,NULL,'Autor der Quelle [120].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors WHERE normalized_name='Oberkampf, William L.'
);

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Roy','Christopher J.','Roy, Christopher J.',NULL,NULL,NULL,'Autor der Quelle [120].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors WHERE normalized_name='Roy, Christopher J.'
);

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Sargent','Robert G.','Sargent, Robert G.',NULL,NULL,NULL,'Autor der Quelle [121].'
WHERE NOT EXISTS (
 SELECT 1 FROM authors WHERE normalized_name='Sargent, Robert G.'
);

SET @a_oberkampf := (SELECT author_id FROM authors WHERE normalized_name='Oberkampf, William L.' LIMIT 1);
SET @a_roy := (SELECT author_id FROM authors WHERE normalized_name='Roy, Christopher J.' LIMIT 1);
SET @a_sargent := (SELECT author_id FROM authors WHERE normalized_name='Sargent, Robert G.' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_120,@a_oberkampf,1,'author'
WHERE @source_120 IS NOT NULL AND @a_oberkampf IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors WHERE source_id=@source_120 AND author_order=1 AND role='author'
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_120,@a_roy,2,'author'
WHERE @source_120 IS NOT NULL AND @a_roy IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors WHERE source_id=@source_120 AND author_order=2 AND role='author'
);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_121,@a_sargent,1,'author'
WHERE @source_121 IS NOT NULL AND @a_sargent IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_authors WHERE source_id=@source_121 AND author_order=1 AND role='author'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,
 is_first_mention,citation_checked,notes,created_revision_id)
SELECT x.source_id,@section_id,'first_citation',x.claim_summary,
 x.exact_location,1,1,x.notes,@revision_id
FROM (
 SELECT @source_120 source_id,
 'Verifikation prüft die korrekte Umsetzung, Validierung die wissenschaftliche Eignung des Modells.' claim_summary,
 '3.8.7, Motivation und Problemstellung' exact_location,
 'Erstverwendung [120].' notes
 UNION ALL
 SELECT @source_121,
 'Simulationsmodelle werden auf mehreren technischen und inhaltlichen Ebenen geprüft.',
 '3.8.7, Prüfstruktur und Modellvalidierung',
 'Erstverwendung [121].'
) x
WHERE x.source_id IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage su
 WHERE su.source_id=x.source_id
   AND su.section_id=@section_id
   AND su.usage_type='first_citation'
   AND COALESCE(su.exact_location,'')=COALESCE(x.exact_location,'')
);


/* ============================================================
 Definitionen
 ============================================================ */

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,
 word_latex,provenance,source_id,assumptions,notes,
 validation_status,created_revision_id)
SELECT x.definition_number,@section_id,x.title,x.definition_text,
 x.formal_latex,x.word_latex,x.provenance,x.source_id,
 x.assumptions,x.notes,'draft',@revision_id
FROM (
 SELECT '3.8.7.1' definition_number,'Prüfstruktur' title,
 'Die Prüfstruktur umfasst Einzeloperatorprüfung, Integrationsprüfung, Reproduzierbarkeitsprüfung, Grenz- und Fehlerprüfung, Modellvalidierung sowie externe Referenzprüfung.' definition_text,
 '\\mathcal{P}=\\left\\{P_U,P_I,P_R,P_G,P_M,P_E\\right\\}' formal_latex,
 '\\mathcal{P}=\\left\\{P_U,P_I,P_R,P_G,P_M,P_E\\right\\}' word_latex,
 'adapted' provenance,@source_121 source_id,
 'Alle Prüfbereiche werden getrennt dokumentiert.' assumptions,
 'Übergeordnete Prüfstruktur.' notes
 UNION ALL SELECT '3.8.7.2','Operator-Testfallmenge',
 'Menge aus Eingabezuständen und unabhängig bestimmten Referenzzuständen.',
 '\\mathcal{T}_i=\\left\\{\\left(S_{i,1}^{\\mathrm{in}},S_{i,1}^{\\mathrm{ref}}\\right),\\ldots,\\left(S_{i,n}^{\\mathrm{in}},S_{i,n}^{\\mathrm{ref}}\\right)\\right\\}',
 '\\mathcal{T}_i=\\left\\{\\left(S_{i,1}^{\\mathrm{in}},S_{i,1}^{\\mathrm{ref}}\\right),\\ldots,\\left(S_{i,n}^{\\mathrm{in}},S_{i,n}^{\\mathrm{ref}}\\right)\\right\\}',
 'original',@source_120,'Referenzzustände sind unabhängig bestimmt.','Grundlage der Einzeloperatorprüfung.'
 UNION ALL SELECT '3.8.7.3','Invariante',
 'Eine Invariante ist eine mathematisch begründete Eigenschaft, die bei einem festgelegten Übergang erhalten bleibt.',
 'I_k(S_{t+1})=I_k(S_t)','I_k(S_{t+1})=I_k(S_t)',
 'adapted',@source_120,'Die Erhaltung wurde mathematisch begründet.','Numerische Toleranzen sind möglich.'
 UNION ALL SELECT '3.8.7.4','Validierungsebenen',
 'Die Modellvalidierung wird in formale, interne und externe Validierung unterteilt.',
 '\\mathcal{V}=\\left\\{V_{\\mathrm{formal}},V_{\\mathrm{intern}},V_{\\mathrm{extern}}\\right\\}',
 '\\mathcal{V}=\\left\\{V_{\\mathrm{formal}},V_{\\mathrm{intern}},V_{\\mathrm{extern}}\\right\\}',
 'adapted',@source_121,'Die Ebenen werden nicht gleichgesetzt.','Methodische Trennung der Validierung.'
 UNION ALL SELECT '3.8.7.5','Prüfstatusvektor',
 'Der Prüfstatusvektor enthält die Ergebnisse der sechs Prüfbereiche.',
 'Z_P=\\left(z_U,z_I,z_R,z_G,z_M,z_E\\right)',
 'Z_P=\\left(z_U,z_I,z_R,z_G,z_M,z_E\\right)',
 'original',NULL,'Jeder Teilstatus ist eindeutig bestimmt.','Kompakte Dokumentation des Prüfstands.'
 UNION ALL SELECT '3.8.7.6','Dreistufiger Teilstatus',
 'Ein Teilstatus ist nicht bestanden, bestanden oder unbestimmt.',
 'z_i\\in\\left\\{0,1,u\\right\\}',
 'z_i\\in\\left\\{0,1,u\\right\\}',
 'original',NULL,'Die Bedeutungen von 0, 1 und u sind dokumentiert.','u ist nicht gleich bestanden.'
 UNION ALL SELECT '3.8.7.7','Vollständige technische Verifikation',
 'Die technische Verifikation ist vollständig, wenn Einzeloperator-, Integrations-, Reproduzierbarkeits- und Grenzprüfung bestanden sind.',
 'z_U=z_I=z_R=z_G=1','z_U=z_I=z_R=z_G=1',
 'original',@source_120,'Alle vier Prüfklassen wurden ausgeführt.','Externe Validierung bleibt getrennt.'
) x
WHERE @section_id IS NOT NULL AND @revision_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM definitions d WHERE d.definition_number=x.definition_number
);


/* ============================================================
 Gleichungen (3.1319) bis (3.1343)
 ============================================================ */

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,
 plain_description,equation_type,provenance,source_id,derivation,
 assumptions,validation_status,created_revision_id)
SELECT x.equation_number,@section_id,x.title,x.equation_latex,
 x.word_latex,x.plain_description,x.equation_type,x.provenance,
 x.source_id,x.derivation,x.assumptions,'draft',@revision_id
FROM (
SELECT '3.1319' equation_number,'Prüfstruktur' title,'\mathcal{P}=\left\{P_U,P_I,P_R,P_G,P_M,P_E\right\}' equation_latex,'\mathcal{P}=\left\{P_U,P_I,P_R,P_G,P_M,P_E\right\}' word_latex,'Menge der sechs Prüfbereiche.' plain_description,'definition' equation_type,'adapted' provenance,@source_121 source_id,'Formale Zusammenfassung der Prüfstruktur.' derivation,'Prüfbereiche sind getrennt.' assumptions
UNION ALL
SELECT '3.1320' equation_number,'Operator-Testfallmenge' title,'\mathcal{T}_i=\left\{\left(S_{i,1}^{\mathrm{in}},S_{i,1}^{\mathrm{ref}}\right),\ldots,\left(S_{i,n}^{\mathrm{in}},S_{i,n}^{\mathrm{ref}}\right)\right\}' equation_latex,'\mathcal{T}_i=\left\{\left(S_{i,1}^{\mathrm{in}},S_{i,1}^{\mathrm{ref}}\right),\ldots,\left(S_{i,n}^{\mathrm{in}},S_{i,n}^{\mathrm{ref}}\right)\right\}' word_latex,'Testfälle aus Eingabe- und Referenzzuständen.' plain_description,'definition' equation_type,'adapted' provenance,@source_120 source_id,'Paarbildung von Testeingaben und Referenzergebnissen.' derivation,'Referenzen sind unabhängig bestimmt.' assumptions
UNION ALL
SELECT '3.1321' equation_number,'Toleranzprüfung eines Operators' title,'d\left(O_i\left(S_{i,j}^{\mathrm{in}}\right),S_{i,j}^{\mathrm{ref}}\right)\le\varepsilon_i' equation_latex,'d\left(O_i\left(S_{i,j}^{\mathrm{in}}\right),S_{i,j}^{\mathrm{ref}}\right)\le\varepsilon_i' word_latex,'Numerische Operatorprüfung.' plain_description,'validation' equation_type,'adapted' provenance,@source_120 source_id,'Vergleich von Implementierung und Referenz.' derivation,'Distanz und Toleranz sind festgelegt.' assumptions
UNION ALL
SELECT '3.1322' equation_number,'Exakte Operatorprüfung' title,'O_i\left(S_{i,j}^{\mathrm{in}}\right)=S_{i,j}^{\mathrm{ref}}' equation_latex,'O_i\left(S_{i,j}^{\mathrm{in}}\right)=S_{i,j}^{\mathrm{ref}}' word_latex,'Exakte Übereinstimmung.' plain_description,'validation' equation_type,'original' provenance,NULL source_id,'Spezialfall ohne Toleranz.' derivation,'Operator ist exakt berechenbar.' assumptions
UNION ALL
SELECT '3.1323' equation_number,'Zusammengesetzte Operatorenkaskade' title,'\mathcal{O}=O_n\circ O_{n-1}\circ\cdots\circ O_1' equation_latex,'\mathcal{O}=O_n\circ O_{n-1}\circ\cdots\circ O_1' word_latex,'Komposition der Operatoren.' plain_description,'model' equation_type,'original' provenance,NULL source_id,'Verkettung in Ausführungsreihenfolge.' derivation,'Reihenfolge ist eindeutig.' assumptions
UNION ALL
SELECT '3.1324' equation_number,'Integrationsprüfung' title,'d\left(\mathcal{O}_{\mathrm{impl}}(S_0),\mathcal{O}_{\mathrm{ref}}(S_0)\right)\le\varepsilon_{\mathcal{O}}' equation_latex,'d\left(\mathcal{O}_{\mathrm{impl}}(S_0),\mathcal{O}_{\mathrm{ref}}(S_0)\right)\le\varepsilon_{\mathcal{O}}' word_latex,'Vergleich von Implementierungs- und Referenzkaskade.' plain_description,'validation' equation_type,'adapted' provenance,@source_120 source_id,'Distanzvergleich der Gesamtergebnisse.' derivation,'Referenz und Toleranz sind festgelegt.' assumptions
UNION ALL
SELECT '3.1325' equation_number,'Exakte Invariantenbedingung' title,'I_k(S_{t+1})=I_k(S_t)' equation_latex,'I_k(S_{t+1})=I_k(S_t)' word_latex,'Exakte Erhaltung einer Invariante.' plain_description,'invariant' equation_type,'adapted' provenance,@source_120 source_id,'Vergleich vor und nach dem Übergang.' derivation,'I_k ist invariant.' assumptions
UNION ALL
SELECT '3.1326' equation_number,'Numerische Invariantenbedingung' title,'\left|I_k(S_{t+1})-I_k(S_t)\right|\le\varepsilon_{I_k}' equation_latex,'\left|I_k(S_{t+1})-I_k(S_t)\right|\le\varepsilon_{I_k}' word_latex,'Tolerierte Invariantenabweichung.' plain_description,'validation' equation_type,'adapted' provenance,@source_120 source_id,'Numerische Toleranzprüfung.' derivation,'Toleranz ist begründet.' assumptions
UNION ALL
SELECT '3.1327' equation_number,'Deterministische Wiederholbarkeit' title,'\Gamma^{(1)}=\Gamma^{(2)}=\cdots=\Gamma^{(m)}' equation_latex,'\Gamma^{(1)}=\Gamma^{(2)}=\cdots=\Gamma^{(m)}' word_latex,'Identische Trajektorien wiederholter Läufe.' plain_description,'criterion' equation_type,'adapted' provenance,@source_120 source_id,'Vergleich mehrerer Wiederholungen.' derivation,'Laufbedingungen sind identisch.' assumptions
UNION ALL
SELECT '3.1328' equation_number,'Numerische Reproduzierbarkeit' title,'\max_{a,b}d_\Gamma\left(\Gamma^{(a)},\Gamma^{(b)}\right)\le\varepsilon_{\mathrm{rep}}' equation_latex,'\max_{a,b}d_\Gamma\left(\Gamma^{(a)},\Gamma^{(b)}\right)\le\varepsilon_{\mathrm{rep}}' word_latex,'Maximale paarweise Trajektorienabweichung.' plain_description,'validation' equation_type,'adapted' provenance,@source_120 source_id,'Maximierung über alle Laufpaare.' derivation,'Toleranz ist festgelegt.' assumptions
UNION ALL
SELECT '3.1329' equation_number,'Reproduzierbarkeit stochastischer Läufe' title,'\Sigma_{z,1}=\Sigma_{z,2}\Rightarrow\Gamma_{z,1}=\Gamma_{z,2}' equation_latex,'\Sigma_{z,1}=\Sigma_{z,2}\Rightarrow\Gamma_{z,1}=\Gamma_{z,2}' word_latex,'Reproduzierbarkeit bei gleichem Zufallsstartwert.' plain_description,'criterion' equation_type,'adapted' provenance,@source_120 source_id,'Erweiterung um Zufallsinitialisierung.' derivation,'Generator ist deterministisch initialisiert.' assumptions
UNION ALL
SELECT '3.1330' equation_number,'Parametergrenzwerte' title,'\theta_i\in\left\{\inf I_i,\sup I_i\right\}' equation_latex,'\theta_i\in\left\{\inf I_i,\sup I_i\right\}' word_latex,'Prüfung beider Intervallgrenzen.' plain_description,'test_case' equation_type,'original' provenance,NULL source_id,'Auswahl der unteren und oberen Grenze.' derivation,'Intervall ist definiert.' assumptions
UNION ALL
SELECT '3.1331' equation_number,'Unzulässige Randüberschreitung' title,'\theta_i^{-}<\inf I_i\qquad\mathrm{oder}\qquad\theta_i^{+}>\sup I_i' equation_latex,'\theta_i^{-}<\inf I_i\qquad\mathrm{oder}\qquad\theta_i^{+}>\sup I_i' word_latex,'Testwerte außerhalb des zulässigen Bereichs.' plain_description,'test_case' equation_type,'original' provenance,NULL source_id,'Gezielte Grenzverletzung.' derivation,'Abweichung ist eindeutig.' assumptions
UNION ALL
SELECT '3.1332' equation_number,'Abbruch bei unzulässiger Parametrisierung' title,'\Theta\notin\Omega_\Theta\Rightarrow V(S_0,\Theta)=0' equation_latex,'\Theta\notin\Omega_\Theta\Rightarrow V(S_0,\Theta)=0' word_latex,'Negativer Validierungsstatus für unzulässige Parameter.' plain_description,'validation' equation_type,'original' provenance,NULL source_id,'Anwendung der Validierungsfunktion.' derivation,'Parameterraum ist definiert.' assumptions
UNION ALL
SELECT '3.1333' equation_number,'Zustandsänderung' title,'\Delta_t=\left\|S_t-S_{t-1}\right\|' equation_latex,'\Delta_t=\left\|S_t-S_{t-1}\right\|' word_latex,'Normdifferenz aufeinanderfolgender Zustände.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Differenzbildung und Norm.' derivation,'Zustände liegen im selben Raum.' assumptions
UNION ALL
SELECT '3.1334' equation_number,'Konvergenzbedingung' title,'\Delta_t\le\varepsilon' equation_latex,'\Delta_t\le\varepsilon' word_latex,'Schwellenbedingung der Konvergenz.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Vergleich mit Konvergenztoleranz.' derivation,'Epsilon ist positiv.' assumptions
UNION ALL
SELECT '3.1335' equation_number,'Erster Konvergenzzeitpunkt' title,'t^{\ast}=\min\left\{t\in\mathbb{N}\mid\Delta_t\le\varepsilon\right\}' equation_latex,'t^{\ast}=\min\left\{t\in\mathbb{N}\mid\Delta_t\le\varepsilon\right\}' word_latex,'Frühester konvergenter Iterationszeitpunkt.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Minimum der konvergenten Zeitpunkte.' derivation,'Menge ist nicht leer.' assumptions
UNION ALL
SELECT '3.1336' equation_number,'Tatsächlicher Endzeitpunkt' title,'T=\min\left(t^{\ast},T_{\max}\right)' equation_latex,'T=\min\left(t^{\ast},T_{\max}\right)' word_latex,'Ende bei Konvergenz oder Iterationsgrenze.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Minimum aus Konvergenz und Sicherheitsgrenze.' derivation,'T_max ist positiv.' assumptions
UNION ALL
SELECT '3.1337' equation_number,'Validierungsebenen' title,'\mathcal{V}=\left\{V_{\mathrm{formal}},V_{\mathrm{intern}},V_{\mathrm{extern}}\right\}' equation_latex,'\mathcal{V}=\left\{V_{\mathrm{formal}},V_{\mathrm{intern}},V_{\mathrm{extern}}\right\}' word_latex,'Formale, interne und externe Validierung.' plain_description,'definition' equation_type,'adapted' provenance,@source_121 source_id,'Trennung der Validierungsebenen.' derivation,'Keine Ebene ersetzt eine andere.' assumptions
UNION ALL
SELECT '3.1338' equation_number,'Externe Abweichung' title,'D_{\mathrm{ext}}=d\left(\mathbf{Y}_{\mathrm{sim}},\mathbf{Y}_{\mathrm{ref}}\right)' equation_latex,'D_{\mathrm{ext}}=d\left(\mathbf{Y}_{\mathrm{sim}},\mathbf{Y}_{\mathrm{ref}}\right)' word_latex,'Distanz zwischen Simulation und Referenz.' plain_description,'metric' equation_type,'adapted' provenance,@source_121 source_id,'Anwendung einer Distanzfunktion.' derivation,'Größen sind vergleichbar.' assumptions
UNION ALL
SELECT '3.1339' equation_number,'Externe Übereinstimmung' title,'D_{\mathrm{ext}}\le\varepsilon_{\mathrm{ext}}' equation_latex,'D_{\mathrm{ext}}\le\varepsilon_{\mathrm{ext}}' word_latex,'Übereinstimmung innerhalb externer Toleranz.' plain_description,'validation' equation_type,'adapted' provenance,@source_121 source_id,'Vergleich mit festgelegter Toleranz.' derivation,'Toleranz wurde vorab bestimmt.' assumptions
UNION ALL
SELECT '3.1340' equation_number,'Prüfstatusvektor' title,'Z_P=\left(z_U,z_I,z_R,z_G,z_M,z_E\right)' equation_latex,'Z_P=\left(z_U,z_I,z_R,z_G,z_M,z_E\right)' word_latex,'Vektor der sechs Teilprüfstände.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Zusammenfassung der Prüfstatuswerte.' derivation,'Komponenten sind eindeutig.' assumptions
UNION ALL
SELECT '3.1341' equation_number,'Wertebereich des Teilstatus' title,'z_i\in\left\{0,1,u\right\}' equation_latex,'z_i\in\left\{0,1,u\right\}' word_latex,'Nicht bestanden, bestanden oder unbestimmt.' plain_description,'classification' equation_type,'original' provenance,NULL source_id,'Diskrete Kodierung.' derivation,'Statusbedeutung ist dokumentiert.' assumptions
UNION ALL
SELECT '3.1342' equation_number,'Vollständige technische Verifikation' title,'z_U=z_I=z_R=z_G=1' equation_latex,'z_U=z_I=z_R=z_G=1' word_latex,'Alle technischen Prüfungen sind bestanden.' plain_description,'criterion' equation_type,'adapted' provenance,@source_120 source_id,'Konjunktive Zusammenfassung.' derivation,'Alle Prüfungen wurden ausgeführt.' assumptions
UNION ALL
SELECT '3.1343' equation_number,'Hierarchie der Aussagekraft' title,'\mathrm{Implementierung}\longrightarrow\mathrm{Verifikation}\longrightarrow\mathrm{interne\ Validierung}\longrightarrow\mathrm{externe\ Validierung}' equation_latex,'\mathrm{Implementierung}\longrightarrow\mathrm{Verifikation}\longrightarrow\mathrm{interne\ Validierung}\longrightarrow\mathrm{externe\ Validierung}' word_latex,'Methodische Reihenfolge der Prüfstufen.' plain_description,'process' equation_type,'adapted' provenance,@source_120 source_id,'Ordnung der Prüfschritte.' derivation,'Jede Stufe setzt die vorige voraus.' assumptions
) x
WHERE @section_id IS NOT NULL AND @revision_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM equations e WHERE e.equation_number=x.equation_number
);


/* ============================================================
 Abschnittssymbole
 ============================================================ */

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,
 scope_type,first_section_id,first_equation_id,unit_text,domain_text,
 codomain_text,is_vector,is_matrix,is_operator,notes,
 validation_status,created_revision_id)
SELECT x.symbol_latex,x.symbol_latex,x.symbol_name,x.definition_text,
 'section',@section_id,
 (SELECT equation_id FROM equations WHERE equation_number=x.first_eq LIMIT 1),
 NULL,x.domain_text,NULL,x.is_vector,0,x.is_operator,
 'Abschnittssymbol 3.8.7.','draft',@revision_id
FROM (
 SELECT '\\mathcal{P}' symbol_latex,'Prüfstruktur' symbol_name,'Menge aller Prüfbereiche.' definition_text,'3.1319' first_eq,NULL domain_text,0 is_vector,0 is_operator
 UNION ALL SELECT '\\mathcal{T}_i','Operator-Testfallmenge','Testfälle eines Operators.','3.1320',NULL,0,0
 UNION ALL SELECT '\\varepsilon_i','Operatortoleranz','Zulässige Operatorabweichung.','3.1321','R_{ge_0}',0,0
 UNION ALL SELECT '\\mathcal{O}','Operatorenkaskade','Komposition der Operatoren.','3.1323',NULL,0,1
 UNION ALL SELECT '\\varepsilon_{\\mathcal{O}}','Kaskadentoleranz','Zulässige Gesamtabweichung.','3.1324','R_{ge_0}',0,0
 UNION ALL SELECT 'I_k','Invariante','Erhaltene Eigenschaft.','3.1325',NULL,0,0
 UNION ALL SELECT '\\varepsilon_{I_k}','Invariantentoleranz','Zulässige Abweichung einer Invariante.','3.1326','R_{ge_0}',0,0
 UNION ALL SELECT '\\varepsilon_{\\mathrm{rep}}','Reproduktionstoleranz','Zulässige Trajektorienabweichung.','3.1328','R_{ge_0}',0,0
 UNION ALL SELECT '\\Sigma_z','Stochastische Konfiguration','Konfiguration einschließlich Zufallsstartwert.','3.1329',NULL,0,0
 UNION ALL SELECT '\\theta_i','Prüfparameter','Parameter der Grenzwertprüfung.','3.1330','I_i',0,0
 UNION ALL SELECT '\\Omega_\\Theta','Zulässiger Parameterraum','Menge zulässiger Parametrisierungen.','3.1332',NULL,0,0
 UNION ALL SELECT '\\Delta_t','Zustandsänderung','Normdifferenz aufeinanderfolgender Zustände.','3.1333','R_{ge_0}',0,0
 UNION ALL SELECT 't^{\\ast}','Erster Konvergenzzeitpunkt','Frühester konvergenter Zeitpunkt.','3.1335','N',0,0
 UNION ALL SELECT 'T_{\\max}','Maximale Iterationszahl','Sicherheitsgrenze.','3.1336','N',0,0
 UNION ALL SELECT '\\mathcal{V}','Validierungsebenen','Formale, interne und externe Validierung.','3.1337',NULL,0,0
 UNION ALL SELECT 'D_{\\mathrm{ext}}','Externe Abweichung','Distanz zu Referenzdaten.','3.1338','R_{ge_0}',0,0
 UNION ALL SELECT '\\varepsilon_{\\mathrm{ext}}','Externe Toleranz','Zulässige Referenzabweichung.','3.1339','R_{ge_0}',0,0
 UNION ALL SELECT 'Z_P','Prüfstatusvektor','Vektor der Teilprüfstände.','3.1340','{0,1,u}^6',1,0
 UNION ALL SELECT 'z_i','Teilstatus','Status einer Einzelprüfung.','3.1341','{0,1,u}',0,0
) x
WHERE @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM symbols s
 WHERE s.symbol_latex=x.symbol_latex
   AND s.scope_type='section'
   AND s.first_section_id=@section_id
);

/* ============================================================
 Gleichungssymbole
 ============================================================ */

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,
 unit_text,domain_text,symbol_order)
SELECT e.equation_id,x.symbol_latex,x.symbol_name,x.definition_text,
 NULL,x.domain_text,x.symbol_order
FROM (
 SELECT '3.1319' eq,'\\mathcal{P}' symbol_latex,'Prüfstruktur' symbol_name,'Menge aller Prüfbereiche.' definition_text,NULL domain_text,1 symbol_order
 UNION ALL SELECT '3.1320','\\mathcal{T}_i','Operator-Testfallmenge','Testfälle eines Operators.',NULL,1
 UNION ALL SELECT '3.1321','\\varepsilon_i','Operatortoleranz','Zulässige Operatorabweichung.','R_{ge_0}',1
 UNION ALL SELECT '3.1323','\\mathcal{O}','Operatorenkaskade','Komposition aller Operatoren.',NULL,1
 UNION ALL SELECT '3.1324','\\varepsilon_{\\mathcal{O}}','Kaskadentoleranz','Zulässige Gesamtabweichung.','R_{ge_0}',1
 UNION ALL SELECT '3.1325','I_k','Invariante','Erhaltene Eigenschaft.',NULL,1
 UNION ALL SELECT '3.1326','\\varepsilon_{I_k}','Invariantentoleranz','Zulässige Invariantenabweichung.','R_{ge_0}',1
 UNION ALL SELECT '3.1328','\\varepsilon_{\\mathrm{rep}}','Reproduktionstoleranz','Zulässige Trajektorienabweichung.','R_{ge_0}',1
 UNION ALL SELECT '3.1329','\\Sigma_z','Stochastische Konfiguration','Konfiguration mit Zufallsstartwert.',NULL,1
 UNION ALL SELECT '3.1330','\\theta_i','Prüfparameter','Parameter der Grenzwertprüfung.','I_i',1
 UNION ALL SELECT '3.1332','\\Omega_\\Theta','Zulässiger Parameterraum','Menge zulässiger Parametrisierungen.',NULL,1
 UNION ALL SELECT '3.1333','\\Delta_t','Zustandsänderung','Normdifferenz.','R_{ge_0}',1
 UNION ALL SELECT '3.1335','t^{\\ast}','Konvergenzzeitpunkt','Erster konvergenter Zeitpunkt.','N',1
 UNION ALL SELECT '3.1336','T_{\\max}','Maximale Iterationszahl','Sicherheitsgrenze.','N',1
 UNION ALL SELECT '3.1337','\\mathcal{V}','Validierungsebenen','Menge der Validierungsebenen.',NULL,1
 UNION ALL SELECT '3.1338','D_{\\mathrm{ext}}','Externe Abweichung','Distanz zu Referenzdaten.','R_{ge_0}',1
 UNION ALL SELECT '3.1339','\\varepsilon_{\\mathrm{ext}}','Externe Toleranz','Zulässige Referenzabweichung.','R_{ge_0}',1
 UNION ALL SELECT '3.1340','Z_P','Prüfstatusvektor','Vektor der Teilprüfstände.','{0,1,u}^6',1
 UNION ALL SELECT '3.1341','z_i','Teilstatus','Status einer Einzelprüfung.','{0,1,u}',1
) x
JOIN equations e ON e.equation_number=x.eq
WHERE NOT EXISTS (
 SELECT 1 FROM equation_symbols es
 WHERE es.equation_id=e.equation_id
   AND es.symbol_latex=x.symbol_latex
);


/* ============================================================
 Änderungsprotokoll
 ============================================================ */

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value,changed_at)
SELECT @revision_id,@section_id,x.change_type,x.object_type,
 x.object_reference,x.change_summary,x.previous_value,x.new_value,NOW()
FROM (
 SELECT 'created' change_type,'section' object_type,'3.8.7' object_reference,
 'Abschnitt 3.8.7 wurde angelegt.' change_summary,
 NULL previous_value,'draft' new_value
 UNION ALL SELECT 'source_added','sources','[120]-[121]',
 'Zwei Quellen zur Verifikation und Validierung wurden aufgenommen.',
 'last_citation_number=119','last_citation_number=121'
 UNION ALL SELECT 'definition_added','definitions','3.8.7.1-3.8.7.7',
 'Sieben Definitionen wurden registriert.',NULL,'7 definitions'
 UNION ALL SELECT 'equation_added','equations','3.1319-3.1343',
 'Fünfundzwanzig Gleichungen wurden registriert.',
 'last_equation=3.1318','last_equation=3.1343'
 UNION ALL SELECT 'symbol_added','symbols','3.8.7',
 'Abschnittssymbole und Gleichungsverwendungen wurden registriert.',
 NULL,'19 section symbols'
) x
WHERE @revision_id IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log scl
 WHERE scl.revision_id=@revision_id
   AND scl.section_id=@section_id
   AND scl.change_type=x.change_type
   AND COALESCE(scl.object_reference,'')=COALESCE(x.object_reference,'')
);

/* ============================================================
 Abschlussaudit
 ============================================================ */

SET @source_count := (
 SELECT COUNT(*) FROM sources WHERE citation_number IN (120,121)
);
SET @author_link_count := (
 SELECT COUNT(*) FROM source_authors WHERE source_id IN (@source_120,@source_121)
);
SET @usage_count := (
 SELECT COUNT(*) FROM source_usage
 WHERE section_id=@section_id AND source_id IN (@source_120,@source_121)
);
SET @definition_count := (
 SELECT COUNT(*) FROM definitions
 WHERE section_id=@section_id
   AND definition_number IN
   ('3.8.7.1','3.8.7.2','3.8.7.3','3.8.7.4','3.8.7.5','3.8.7.6','3.8.7.7')
);
SET @equation_count := (
 SELECT COUNT(*) FROM equations
 WHERE section_id=@section_id
   AND equation_number IN
   ('3.1319','3.1320','3.1321','3.1322','3.1323',
    '3.1324','3.1325','3.1326','3.1327','3.1328',
    '3.1329','3.1330','3.1331','3.1332','3.1333',
    '3.1334','3.1335','3.1336','3.1337','3.1338',
    '3.1339','3.1340','3.1341','3.1342','3.1343')
);
SET @symbol_count := (
 SELECT COUNT(*) FROM symbols
 WHERE first_section_id=@section_id AND scope_type='section'
);

SET @audit_ok := (
 @parent_section_id IS NOT NULL
 AND @revision_id IS NOT NULL
 AND @section_id IS NOT NULL
 AND @source_count=2
 AND @author_link_count=3
 AND @usage_count=2
 AND @definition_count=7
 AND @equation_count=25
 AND @symbol_count>=19
);

COMMIT;

SELECT
 @audit_ok AS audit_ok,
 @revision_id AS revision_id,
 @section_id AS section_id,
 @source_count AS source_count,
 @author_link_count AS author_link_count,
 @usage_count AS source_usage_count,
 @definition_count AS definition_count,
 @equation_count AS equation_count,
 @symbol_count AS symbol_count,
 CASE WHEN @audit_ok=1
 THEN 'Kapitel 3.8.7 wurde vollständig und schema-konform importiert.'
 ELSE 'FEHLER: Abschnitt 3.8.7 ist unvollständig. Auditwerte prüfen.'
 END AS audit_message;

SELECT citation_number,full_citation_text,verification_status
FROM sources
WHERE citation_number IN (120,121)
ORDER BY citation_number;

SELECT definition_number,title,validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY definition_number;

SELECT equation_number,title,validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
