/* ============================================================
 FRZK Repository-Update
 Kapitel 3.8.9 – Vergleich, Klassifikation und Interpretation
 von Simulationstrajektorien
 Version 1.0

 Manuskriptgleichungen: (3.582)–(3.630)
 Repositorygleichungen: (3.1370)–(3.1418)
 Literatur: [124]–[125]
 Idempotentes MariaDB-Skript
 ============================================================ */

START TRANSACTION;

SET @revision_code := 'RKB-K3.8.9-V1';
SET @parent_section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.8' LIMIT 1
);
SET @parent_revision_id := (
 SELECT revision_id FROM repository_revisions
 WHERE revision_code IN ('RKB-K3.8.8-V1','RKB-K3.8.7-V1','RKB-K3.8.6-V1')
 ORDER BY CASE revision_code
  WHEN 'RKB-K3.8.8-V1' THEN 1
  WHEN 'RKB-K3.8.7-V1' THEN 2
  ELSE 3 END
 LIMIT 1
);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,
 summary,created_by,parent_revision_id)
SELECT @revision_code,NOW(),'section','3.8.9','1.0',
 'Vergleich, Klassifikation, Phasensegmentierung, Clusterung, Ausreißeranalyse und Interpretation von Simulationstrajektorien.',
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
SELECT @parent_section_id,'3.8.9',
 'Vergleich, Klassifikation und Interpretation von Simulationstrajektorien',
 3,3.8900,'draft',1,
 'Manuskriptgleichungen (3.582) bis (3.630); Repositorygleichungen (3.1370) bis (3.1418).'
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM dissertation_sections WHERE section_code='3.8.9'
);

UPDATE dissertation_sections
SET parent_section_id=@parent_section_id,
 title='Vergleich, Klassifikation und Interpretation von Simulationstrajektorien',
 chapter_no=3,section_order=3.8900,status='draft',
 is_original_contribution=1,
 notes='Manuskriptgleichungen (3.582) bis (3.630); Repositorygleichungen (3.1370) bis (3.1418).'
WHERE section_code='3.8.9';

SET @section_id := (
 SELECT section_id FROM dissertation_sections
 WHERE section_code='3.8.9' LIMIT 1
);

/* Quellen [124]–[125] */

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,
 year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,
 url,language_code,priority,evidence_type,frzk_relevance,
 verification_status,first_citation_section_code,first_citation_note,
 full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 124,'berndt_clifford_dtw_1994','conference_paper',
 'Using Dynamic Time Warping to Find Patterns in Time Series',NULL,
 1994,1994,NULL,NULL,NULL,NULL,NULL,'359-370',NULL,NULL,NULL,NULL,
 'en',1,'conference_paper',10,'bibliographic','3.8.9',
 'Erstnennung zur zeitlichen Angleichung unterschiedlich verlaufender Zeitreihen.',
 'Berndt, Donald J.; Clifford, James (1994): Using Dynamic Time Warping to Find Patterns in Time Series. In: Proceedings of the 3rd International Conference on Knowledge Discovery and Data Mining, 359-370.',
 'Berndt und Clifford (1994) [124]',
 'Grundlage für zeitlich normierte und phasenverschobene Trajektorienvergleiche.',
 @revision_id
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=124 OR source_key='berndt_clifford_dtw_1994'
);

INSERT INTO sources
(citation_number,source_key,source_type,title,subtitle,year_original,
 year_edition,journal,publisher,place,volume,issue,pages,edition,doi,isbn,
 url,language_code,priority,evidence_type,frzk_relevance,
 verification_status,first_citation_section_code,first_citation_note,
 full_citation_text,short_citation_text,notes,created_revision_id)
SELECT 125,'kaufman_rousseeuw_cluster_1990','book',
 'Finding Groups in Data','An Introduction to Cluster Analysis',
 1990,1990,NULL,'Wiley','New York',NULL,NULL,NULL,NULL,NULL,
 '978-0-471-87876-6',NULL,'en',1,'textbook',10,'bibliographic','3.8.9',
 'Erstnennung zu Distanzmatrizen, Clusteranalyse, Medoiden und Ausreißererkennung.',
 'Kaufman, Leonard; Rousseeuw, Peter J. (1990): Finding Groups in Data: An Introduction to Cluster Analysis. New York: Wiley.',
 'Kaufman und Rousseeuw (1990) [125]',
 'Grundlage der Cluster-, Medoid- und Distanzanalyse.',
 @revision_id
WHERE NOT EXISTS (
 SELECT 1 FROM sources
 WHERE citation_number=125 OR source_key='kaufman_rousseeuw_cluster_1990'
);

SET @source_124 := (SELECT source_id FROM sources WHERE citation_number=124 LIMIT 1);
SET @source_125 := (SELECT source_id FROM sources WHERE citation_number=125 LIMIT 1);

/* Autoren */

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Berndt','Donald J.','Berndt, Donald J.',NULL,NULL,NULL,'Erster Autor der Quelle [124].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Berndt, Donald J.');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Clifford','James','Clifford, James',NULL,NULL,NULL,'Zweiter Autor der Quelle [124].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Clifford, James');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Kaufman','Leonard','Kaufman, Leonard',NULL,NULL,NULL,'Erster Autor der Quelle [125].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Kaufman, Leonard');

INSERT INTO authors
(family_name,given_names,normalized_name,orcid,birth_year,death_year,notes)
SELECT 'Rousseeuw','Peter J.','Rousseeuw, Peter J.',NULL,NULL,NULL,'Zweiter Autor der Quelle [125].'
WHERE NOT EXISTS (SELECT 1 FROM authors WHERE normalized_name='Rousseeuw, Peter J.');

SET @a_berndt := (SELECT author_id FROM authors WHERE normalized_name='Berndt, Donald J.' LIMIT 1);
SET @a_clifford := (SELECT author_id FROM authors WHERE normalized_name='Clifford, James' LIMIT 1);
SET @a_kaufman := (SELECT author_id FROM authors WHERE normalized_name='Kaufman, Leonard' LIMIT 1);
SET @a_rousseeuw := (SELECT author_id FROM authors WHERE normalized_name='Rousseeuw, Peter J.' LIMIT 1);

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_124,@a_berndt,1,'author'
WHERE @source_124 IS NOT NULL AND @a_berndt IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_124 AND author_order=1 AND role='author');

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_124,@a_clifford,2,'author'
WHERE @source_124 IS NOT NULL AND @a_clifford IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_124 AND author_order=2 AND role='author');

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_125,@a_kaufman,1,'author'
WHERE @source_125 IS NOT NULL AND @a_kaufman IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_125 AND author_order=1 AND role='author');

INSERT INTO source_authors(source_id,author_id,author_order,role)
SELECT @source_125,@a_rousseeuw,2,'author'
WHERE @source_125 IS NOT NULL AND @a_rousseeuw IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM source_authors WHERE source_id=@source_125 AND author_order=2 AND role='author');

/* Quellenverwendungen */

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,
 is_first_mention,citation_checked,notes,created_revision_id)
SELECT x.source_id,@section_id,'first_citation',x.claim_summary,
 x.exact_location,1,1,x.notes,@revision_id
FROM (
 SELECT @source_124 source_id,
 'Zeitreihen unterschiedlicher Länge oder zeitlicher Lage können durch geeignete Angleichungsverfahren strukturell verglichen werden.' claim_summary,
 '3.8.9, Normierung und Trajektorienvergleich' exact_location,
 'Erstverwendung [124].' notes
 UNION ALL
 SELECT @source_125,
 'Distanzmatrizen, Clusterverfahren, Medoide und Ausreißeranalysen ermöglichen die strukturierte Gruppierung mehrdimensionaler Beobachtungen.',
 '3.8.9, Ähnlichkeitsmatrix, Clusterbildung und Ausreißererkennung',
 'Erstverwendung [125].'
) x
WHERE x.source_id IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM source_usage su
 WHERE su.source_id=x.source_id
   AND su.section_id=@section_id
   AND su.usage_type='first_citation'
   AND COALESCE(su.exact_location,'')=COALESCE(x.exact_location,'')
);

/* Definitionen */

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,
 word_latex,provenance,source_id,assumptions,notes,
 validation_status,created_revision_id)
SELECT x.definition_number,@section_id,x.title,x.definition_text,
 x.formal_latex,x.formal_latex,x.provenance,x.source_id,
 x.assumptions,x.notes,'draft',@revision_id
FROM (
 SELECT '3.8.9.1' definition_number,'Trajektorienvergleichsvektor' title,
 'Der Vergleichsvektor verbindet globale, lokale, endzustandsbezogene, operatorische, phasenbezogene und metrische Abweichungen.' definition_text,
 'C_{\Gamma}\left(\Gamma_a,\Gamma_b\right)=\left(D_{\mathrm{glob}},D_{\mathrm{lok}},D_{\mathrm{end}},D_{\mathrm{op}},D_{\mathrm{phase}},D_{\mathrm{metric}}\right)' formal_latex,
 'original' provenance,NULL source_id,
 'Alle Komponenten beziehen sich auf dasselbe Trajektorienpaar.' assumptions,
 'Zentrale Vergleichsstruktur.' notes
 UNION ALL SELECT '3.8.9.2','Normierte Trajektorie',
 'Eine normierte Trajektorie bildet einen Lauf auf das normierte Zeitintervall von null bis eins ab.',
 '\widetilde{\Gamma}=\left\{\widetilde{S}(\lambda)\mid0\le\lambda\le1\right\}',
 'adapted',@source_124,'Die Interpolation ist dokumentiert.','Vergleich unterschiedlich langer Läufe.'
 UNION ALL SELECT '3.8.9.3','Lokale Abweichungsfunktion',
 'Die lokale Abweichungsfunktion beschreibt die Zustandsdistanz zweier Trajektorien zu jedem normierten Zeitpunkt.',
 '\delta_{a,b}(\lambda)=d_S\left(\widetilde{S}_a(\lambda),\widetilde{S}_b(\lambda)\right)',
 'original',NULL,'Die Zustände sind vergleichbar skaliert.','Lokalisierung kritischer Abweichungsphasen.'
 UNION ALL SELECT '3.8.9.4','Phasenzerlegung',
 'Eine Trajektorie wird als geordnete Folge funktionaler Entwicklungsphasen beschrieben.',
 '\Phi(\Gamma)=\left(\phi_1,\phi_2,\ldots,\phi_q\right)',
 'original',NULL,'Phasengrenzen werden nach dokumentierten Kriterien bestimmt.','Grundlage des Phasenvergleichs.'
 UNION ALL SELECT '3.8.9.5','Trajektorienmerkmalsvektor',
 'Der Trajektorienmerkmalsvektor verbindet Laufdauer, Pfadlänge, Mittelwerte funktionaler Metriken, Phasenanzahl, kritische Übergänge und Gesamtbewertung.',
 'F_{\Gamma}=\left(T,D_{\mathrm{path}},K_{\mathrm{mean}},C_{\mathrm{mean}},R_{\mathrm{mean}},S_{\mathrm{mean}},N_{\phi},N_{\mathrm{crit}},Q\right)',
 'original',NULL,'Alle Merkmale wurden konsistent berechnet.','Grundlage der Klassifikation.'
 UNION ALL SELECT '3.8.9.6','Trajektorienklassen',
 'Trajektorien werden analytisch als stabil, konvergierend, oszillierend, divergierend, kritisch oder unbestimmt klassifiziert.',
 '\mathcal{K}_{\Gamma}=\left\{K_{\mathrm{stab}},K_{\mathrm{conv}},K_{\mathrm{osc}},K_{\mathrm{div}},K_{\mathrm{crit}},K_{\mathrm{ind}}\right\}',
 'original',NULL,'Klassenregeln und Schwellenwerte sind dokumentiert.','Keine ontologische Festlegung.'
 UNION ALL SELECT '3.8.9.7','Kritischer Übergangsindikator',
 'Der kritische Übergangsindikator kombiniert Zustandsänderung sowie Änderungen von Kohärenz, Kontinuität und Reproduzierbarkeit.',
 'J_t=w_1\left\|\Delta S_t\right\|+w_2\left|\Delta K_t\right|+w_3\left|\Delta C_t\right|+w_4\left|\Delta R_t\right|',
 'original',NULL,'Die Gewichte summieren sich zu eins.','Mehrkriterielle Übergangserkennung.'
 UNION ALL SELECT '3.8.9.8','Repräsentative Trajektorie',
 'Die repräsentative Trajektorie eines Clusters ist das Medoid mit minimaler Gesamtdistanz zu allen übrigen Clustermitgliedern.',
 '\Gamma_j^{\mathrm{rep}}=\operatorname*{arg\,min}_{\Gamma_a\in G_j}\sum_{\Gamma_b\in G_j}d_{\Gamma}\left(\Gamma_a,\Gamma_b\right)',
 'adapted',@source_125,'Das Cluster ist nicht leer.','Reale statt künstlich gemittelte Trajektorie.'
 UNION ALL SELECT '3.8.9.9','Interpretationsstatusvektor',
 'Der Interpretationsstatus dokumentiert Klassifikation, Clusterzuordnung, Phasenerkennung, Ursachenanalyse und wissenschaftliche Validierung.',
 'Z_{\mathrm{int}}=\left(z_{\mathrm{class}},z_{\mathrm{cluster}},z_{\mathrm{phase}},z_{\mathrm{cause}},z_{\mathrm{valid}}\right)',
 'original',NULL,'Jede Komponente ist eindeutig bewertet.','Trennt Interpretation und Validierung.'
) x
WHERE @section_id IS NOT NULL AND @revision_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM definitions d WHERE d.definition_number=x.definition_number
);

/* Gleichungen */

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,
 plain_description,equation_type,provenance,source_id,derivation,
 assumptions,validation_status,created_revision_id)
SELECT x.equation_number,@section_id,x.title,x.equation_latex,
 x.word_latex,x.plain_description,x.equation_type,x.provenance,
 x.source_id,x.derivation,x.assumptions,'draft',@revision_id
FROM (
SELECT '3.1370' equation_number,'Trajektorienvergleichsvektor' title,'C_{\Gamma}\left(\Gamma_a,\Gamma_b\right)=\left(D_{\mathrm{glob}},D_{\mathrm{lok}},D_{\mathrm{end}},D_{\mathrm{op}},D_{\mathrm{phase}},D_{\mathrm{metric}}\right)' equation_latex,'C_{\Gamma}\left(\Gamma_a,\Gamma_b\right)=\left(D_{\mathrm{glob}},D_{\mathrm{lok}},D_{\mathrm{end}},D_{\mathrm{op}},D_{\mathrm{phase}},D_{\mathrm{metric}}\right)' word_latex,'Vergleichsvektor zweier Trajektorien.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1371' equation_number,'Normierte Zeitvariable' title,'\lambda=\frac{t}{T}\qquad\text{mit}\qquad0\le\lambda\le1' equation_latex,'\lambda=\frac{t}{T}\qquad\text{mit}\qquad0\le\lambda\le1' word_latex,'Normierte Zeitkoordinate.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1372' equation_number,'Normierte Trajektorie' title,'\widetilde{\Gamma}=\left\{\widetilde{S}(\lambda)\mid0\le\lambda\le1\right\}' equation_latex,'\widetilde{\Gamma}=\left\{\widetilde{S}(\lambda)\mid0\le\lambda\le1\right\}' word_latex,'Auf das Einheitsintervall abgebildete Trajektorie.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1373' equation_number,'Interpolierter Zustand' title,'\widetilde{S}(\lambda)=J\left(\Gamma,\lambda\right)' equation_latex,'\widetilde{S}(\lambda)=J\left(\Gamma,\lambda\right)' word_latex,'Interpolierter Zustand einer normierten Trajektorie.' plain_description,'definition' equation_type,'adapted' provenance,@source_124 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1374' equation_number,'Globale Trajektoriendistanz kontinuierlich' title,'D_{\mathrm{glob}}\left(\Gamma_a,\Gamma_b\right)=\int_{0}^{1}d_S\left(\widetilde{S}_a(\lambda),\widetilde{S}_b(\lambda)\right)\,d\lambda' equation_latex,'D_{\mathrm{glob}}\left(\Gamma_a,\Gamma_b\right)=\int_{0}^{1}d_S\left(\widetilde{S}_a(\lambda),\widetilde{S}_b(\lambda)\right)\,d\lambda' word_latex,'Integrierte Distanz zweier normierter Trajektorien.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1375' equation_number,'Globale Trajektoriendistanz diskret' title,'D_{\mathrm{glob}}\left(\Gamma_a,\Gamma_b\right)=\frac{1}{m}\sum_{k=1}^{m}d_S\left(\widetilde{S}_a(\lambda_k),\widetilde{S}_b(\lambda_k)\right)' equation_latex,'D_{\mathrm{glob}}\left(\Gamma_a,\Gamma_b\right)=\frac{1}{m}\sum_{k=1}^{m}d_S\left(\widetilde{S}_a(\lambda_k),\widetilde{S}_b(\lambda_k)\right)' word_latex,'Diskrete Näherung der globalen Trajektoriendistanz.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1376' equation_number,'Lokale Abweichungsfunktion' title,'\delta_{a,b}(\lambda)=d_S\left(\widetilde{S}_a(\lambda),\widetilde{S}_b(\lambda)\right)' equation_latex,'\delta_{a,b}(\lambda)=d_S\left(\widetilde{S}_a(\lambda),\widetilde{S}_b(\lambda)\right)' word_latex,'Lokale Distanzfunktion zweier Trajektorien.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1377' equation_number,'Zeitpunkt maximaler Abweichung' title,'\lambda_{\max}=\operatorname*{arg\,max}_{\lambda\in[0,1]}\delta_{a,b}(\lambda)' equation_latex,'\lambda_{\max}=\operatorname*{arg\,max}_{\lambda\in[0,1]}\delta_{a,b}(\lambda)' word_latex,'Normierter Zeitpunkt maximaler lokaler Abweichung.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1378' equation_number,'Maximale lokale Distanz' title,'D_{\mathrm{lok}}^{\max}=\delta_{a,b}\left(\lambda_{\max}\right)' equation_latex,'D_{\mathrm{lok}}^{\max}=\delta_{a,b}\left(\lambda_{\max}\right)' word_latex,'Maximale lokale Trajektoriendifferenz.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1379' equation_number,'Endzustandsdistanz' title,'D_{\mathrm{end}}\left(\Gamma_a,\Gamma_b\right)=d_S\left(S_{T_a}^{(a)},S_{T_b}^{(b)}\right)' equation_latex,'D_{\mathrm{end}}\left(\Gamma_a,\Gamma_b\right)=d_S\left(S_{T_a}^{(a)},S_{T_b}^{(b)}\right)' word_latex,'Distanz der Endzustände zweier Läufe.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1380' equation_number,'Endzustandsäquivalenz' title,'D_{\mathrm{end}}\le\varepsilon_{\mathrm{end}}' equation_latex,'D_{\mathrm{end}}\le\varepsilon_{\mathrm{end}}' word_latex,'Kriterium ähnlicher Endzustände.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1381' equation_number,'Keine Implikation der Trajektorienäquivalenz' title,'D_{\mathrm{end}}\le\varepsilon_{\mathrm{end}}\centernot\Rightarrow D_{\mathrm{glob}}\le\varepsilon_{\mathrm{glob}}' equation_latex,'D_{\mathrm{end}}\le\varepsilon_{\mathrm{end}}\centernot\Rightarrow D_{\mathrm{glob}}\le\varepsilon_{\mathrm{glob}}' word_latex,'Ähnliche Endzustände implizieren keine ähnlichen Entwicklungspfade.' plain_description,'theoretical' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1382' equation_number,'Operatorischer Übergangsvektor' title,'\Delta S_{i,t}=S_{t+1}-S_t' equation_latex,'\Delta S_{i,t}=S_{t+1}-S_t' word_latex,'Zustandsänderung eines Operatoraufrufs.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1383' equation_number,'Distanz der Operatorwirkungen' title,'D_{\mathrm{op},i,t}=d_{\Delta S}\left(\Delta S_{i,t}^{(a)},\Delta S_{i,t}^{(b)}\right)' equation_latex,'D_{\mathrm{op},i,t}=d_{\Delta S}\left(\Delta S_{i,t}^{(a)},\Delta S_{i,t}^{(b)}\right)' word_latex,'Distanz zweier Operatorwirkungen.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1384' equation_number,'Mittlere Operatorabweichung' title,'\overline{D}_{\mathrm{op},i}=\frac{1}{N_i}\sum_{t=1}^{N_i}D_{\mathrm{op},i,t}' equation_latex,'\overline{D}_{\mathrm{op},i}=\frac{1}{N_i}\sum_{t=1}^{N_i}D_{\mathrm{op},i,t}' word_latex,'Mittlere Abweichung eines Operators über den Lauf.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1385' equation_number,'Phasenzerlegung' title,'\Phi(\Gamma)=\left(\phi_1,\phi_2,\ldots,\phi_q\right)' equation_latex,'\Phi(\Gamma)=\left(\phi_1,\phi_2,\ldots,\phi_q\right)' word_latex,'Geordnete Phasen einer Trajektorie.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1386' equation_number,'Phasenintervall' title,'\phi_r=\left[\lambda_r^{\mathrm{start}},\lambda_r^{\mathrm{end}}\right]' equation_latex,'\phi_r=\left[\lambda_r^{\mathrm{start}},\lambda_r^{\mathrm{end}}\right]' word_latex,'Normiertes Zeitintervall einer Phase.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1387' equation_number,'Anschluss benachbarter Phasen' title,'\lambda_r^{\mathrm{end}}=\lambda_{r+1}^{\mathrm{start}}' equation_latex,'\lambda_r^{\mathrm{end}}=\lambda_{r+1}^{\mathrm{start}}' word_latex,'Nahtloser Übergang benachbarter Phasen.' plain_description,'constraint' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1388' equation_number,'Phasenwechselbedingung' title,'\chi(\lambda)>\varepsilon_{\phi}\Rightarrow\lambda=\lambda_r^{\mathrm{end}}' equation_latex,'\chi(\lambda)>\varepsilon_{\phi}\Rightarrow\lambda=\lambda_r^{\mathrm{end}}' word_latex,'Schwellenwertbedingung eines Phasenwechsels.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1389' equation_number,'Phasenmerkmalsvektor' title,'F_{\phi_r}=\left(\overline{K}_r,\overline{C}_r,\overline{R}_r,\overline{S}_r,\Delta_r,L_r\right)' equation_latex,'F_{\phi_r}=\left(\overline{K}_r,\overline{C}_r,\overline{R}_r,\overline{S}_r,\Delta_r,L_r\right)' word_latex,'Merkmalsvektor einer Trajektorienphase.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1390' equation_number,'Phasendistanz' title,'D_{\phi}\left(\phi_r^{(a)},\phi_s^{(b)}\right)=d_F\left(F_{\phi_r}^{(a)},F_{\phi_s}^{(b)}\right)' equation_latex,'D_{\phi}\left(\phi_r^{(a)},\phi_s^{(b)}\right)=d_F\left(F_{\phi_r}^{(a)},F_{\phi_s}^{(b)}\right)' word_latex,'Distanz zweier Phasenmerkmalsvektoren.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1391' equation_number,'Phasenähnlichkeit' title,'D_{\phi}\le\varepsilon_{\phi,\mathrm{sim}}' equation_latex,'D_{\phi}\le\varepsilon_{\phi,\mathrm{sim}}' word_latex,'Kriterium funktional ähnlicher Phasen.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1392' equation_number,'Trajektorienmerkmalsvektor' title,'F_{\Gamma}=\left(T,D_{\mathrm{path}},K_{\mathrm{mean}},C_{\mathrm{mean}},R_{\mathrm{mean}},S_{\mathrm{mean}},N_{\phi},N_{\mathrm{crit}},Q\right)' equation_latex,'F_{\Gamma}=\left(T,D_{\mathrm{path}},K_{\mathrm{mean}},C_{\mathrm{mean}},R_{\mathrm{mean}},S_{\mathrm{mean}},N_{\phi},N_{\mathrm{crit}},Q\right)' word_latex,'Merkmalsvektor einer Trajektorie.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1393' equation_number,'Pfadlänge' title,'D_{\mathrm{path}}=\sum_{t=0}^{T-1}d_S\left(S_t,S_{t+1}\right)' equation_latex,'D_{\mathrm{path}}=\sum_{t=0}^{T-1}d_S\left(S_t,S_{t+1}\right)' word_latex,'Gesamte Zustandsbewegung einer Trajektorie.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1394' equation_number,'Trajektoriendistanzmatrix' title,'M_{\Gamma}=\left(D_{ab}\right)_{N\times N}' equation_latex,'M_{\Gamma}=\left(D_{ab}\right)_{N\times N}' word_latex,'Symmetrische Distanzmatrix der Trajektorien.' plain_description,'definition' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1395' equation_number,'Paarweise Trajektoriendistanz' title,'D_{ab}=d_{\Gamma}\left(\Gamma_a,\Gamma_b\right)' equation_latex,'D_{ab}=d_{\Gamma}\left(\Gamma_a,\Gamma_b\right)' word_latex,'Paarweise Distanz zweier Trajektorien.' plain_description,'metric' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1396' equation_number,'Null-Diagonale' title,'D_{aa}=0' equation_latex,'D_{aa}=0' word_latex,'Selbstdistanz jeder Trajektorie ist null.' plain_description,'constraint' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1397' equation_number,'Symmetrie der Distanzmatrix' title,'D_{ab}=D_{ba}' equation_latex,'D_{ab}=D_{ba}' word_latex,'Symmetrie der paarweisen Distanz.' plain_description,'constraint' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1398' equation_number,'Klassifikationsabbildung' title,'\kappa:F_{\Gamma}\longrightarrow\mathcal{K}_{\Gamma}' equation_latex,'\kappa:F_{\Gamma}\longrightarrow\mathcal{K}_{\Gamma}' word_latex,'Abbildung von Trajektorienmerkmalen auf Klassen.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1399' equation_number,'Trajektorienklassen' title,'\mathcal{K}_{\Gamma}=\left\{K_{\mathrm{stab}},K_{\mathrm{conv}},K_{\mathrm{osc}},K_{\mathrm{div}},K_{\mathrm{crit}},K_{\mathrm{ind}}\right\}' equation_latex,'\mathcal{K}_{\Gamma}=\left\{K_{\mathrm{stab}},K_{\mathrm{conv}},K_{\mathrm{osc}},K_{\mathrm{div}},K_{\mathrm{crit}},K_{\mathrm{ind}}\right\}' word_latex,'Menge der definierten Trajektorienklassen.' plain_description,'classification' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1400' equation_number,'Konvergenzklassifikation' title,'\Delta_T\le\varepsilon\qquad\land\qquad T<T_{\max}' equation_latex,'\Delta_T\le\varepsilon\qquad\land\qquad T<T_{\max}' word_latex,'Regel für konvergierende Trajektorien.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1401' equation_number,'Divergenzklassifikation' title,'\frac{d}{dt}d_S\left(S_t,S_0\right)>0' equation_latex,'\frac{d}{dt}d_S\left(S_t,S_0\right)>0' word_latex,'Regel für überwiegend divergierende Trajektorien.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1402' equation_number,'Oszillationsindikator' title,'\operatorname{sgn}\left(\Delta S_t\cdot\Delta S_{t-1}\right)<0' equation_latex,'\operatorname{sgn}\left(\Delta S_t\cdot\Delta S_{t-1}\right)<0' word_latex,'Richtungsumkehr aufeinanderfolgender Zustandsänderungen.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1403' equation_number,'Kritischer Übergangsindikator' title,'J_t=w_1\left\|\Delta S_t\right\|+w_2\left|\Delta K_t\right|+w_3\left|\Delta C_t\right|+w_4\left|\Delta R_t\right|' equation_latex,'J_t=w_1\left\|\Delta S_t\right\|+w_2\left|\Delta K_t\right|+w_3\left|\Delta C_t\right|+w_4\left|\Delta R_t\right|' word_latex,'Gewichteter Indikator kritischer Übergänge.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1404' equation_number,'Normierung der Übergangsgewichte' title,'\sum_{i=1}^{4}w_i=1' equation_latex,'\sum_{i=1}^{4}w_i=1' word_latex,'Normierte Gewichte des Übergangsindikators.' plain_description,'constraint' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1405' equation_number,'Kritische Übergangsbedingung' title,'J_t\ge J_{\mathrm{crit}}' equation_latex,'J_t\ge J_{\mathrm{crit}}' word_latex,'Schwellenwert eines kritischen Übergangs.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1406' equation_number,'Clustermenge' title,'\mathcal{G}=\left\{G_1,G_2,\ldots,G_r\right\}' equation_latex,'\mathcal{G}=\left\{G_1,G_2,\ldots,G_r\right\}' word_latex,'Menge aller Trajektoriencluster.' plain_description,'definition' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1407' equation_number,'Eindeutige harte Clusterzuordnung' title,'\Gamma_i\in G_j\Rightarrow\Gamma_i\notin G_k\qquad\text{für}\qquad j\neq k' equation_latex,'\Gamma_i\in G_j\Rightarrow\Gamma_i\notin G_k\qquad\text{für}\qquad j\neq k' word_latex,'Ausschließliche Clusterzuordnung bei harter Klassifikation.' plain_description,'constraint' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1408' equation_number,'Unscharfer Zugehörigkeitsgrad' title,'\mu_{ij}\in\left[0,1\right]' equation_latex,'\mu_{ij}\in\left[0,1\right]' word_latex,'Zugehörigkeitsgrad einer Trajektorie zu einem Cluster.' plain_description,'definition' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1409' equation_number,'Normierung unscharfer Zugehörigkeiten' title,'\sum_{j=1}^{r}\mu_{ij}=1' equation_latex,'\sum_{j=1}^{r}\mu_{ij}=1' word_latex,'Summe der Clusterzugehörigkeiten einer Trajektorie.' plain_description,'constraint' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1410' equation_number,'Repräsentatives Clustermedoid' title,'\Gamma_j^{\mathrm{rep}}=\operatorname*{arg\,min}_{\Gamma_a\in G_j}\sum_{\Gamma_b\in G_j}d_{\Gamma}\left(\Gamma_a,\Gamma_b\right)' equation_latex,'\Gamma_j^{\mathrm{rep}}=\operatorname*{arg\,min}_{\Gamma_a\in G_j}\sum_{\Gamma_b\in G_j}d_{\Gamma}\left(\Gamma_a,\Gamma_b\right)' word_latex,'Reale Trajektorie mit minimaler Gesamtdistanz im Cluster.' plain_description,'definition' equation_type,'adapted' provenance,@source_125 source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1411' equation_number,'Mittlere Ausreißerdistanz' title,'A_i=\frac{1}{N-1}\sum_{\substack{j=1\\j\neq i}}^{N}D_{ij}' equation_latex,'A_i=\frac{1}{N-1}\sum_{\substack{j=1\\j\neq i}}^{N}D_{ij}' word_latex,'Mittlere Distanz einer Trajektorie zu allen übrigen.' plain_description,'metric' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1412' equation_number,'Ausreißerbedingung' title,'A_i>A_{\mathrm{crit}}' equation_latex,'A_i>A_{\mathrm{crit}}' word_latex,'Schwellenwertbedingung eines möglichen Ausreißers.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1413' equation_number,'Zerlegung der Trajektorienabweichung' title,'D_{\Gamma}=D_{\Theta}+D_{S_0}+D_{\mathcal{O}}+D_{\mathrm{env}}+D_{\mathrm{num}}+D_{\mathrm{res}}' equation_latex,'D_{\Gamma}=D_{\Theta}+D_{S_0}+D_{\mathcal{O}}+D_{\mathrm{env}}+D_{\mathrm{num}}+D_{\mathrm{res}}' word_latex,'Analytische Zerlegung der Gesamtabweichung.' plain_description,'model' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1414' equation_number,'Interpretationsstatusvektor' title,'Z_{\mathrm{int}}=\left(z_{\mathrm{class}},z_{\mathrm{cluster}},z_{\mathrm{phase}},z_{\mathrm{cause}},z_{\mathrm{valid}}\right)' equation_latex,'Z_{\mathrm{int}}=\left(z_{\mathrm{class}},z_{\mathrm{cluster}},z_{\mathrm{phase}},z_{\mathrm{cause}},z_{\mathrm{valid}}\right)' word_latex,'Statusvektor der Trajektorieninterpretation.' plain_description,'definition' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1415' equation_number,'Wertebereich des Interpretationsstatus' title,'z_i\in\left\{0,1,u\right\}' equation_latex,'z_i\in\left\{0,1,u\right\}' word_latex,'Dreistufiger Statuswert der Interpretation.' plain_description,'classification' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1416' equation_number,'Vollständige Interpretation' title,'z_{\mathrm{class}}=z_{\mathrm{cluster}}=z_{\mathrm{phase}}=z_{\mathrm{cause}}=1' equation_latex,'z_{\mathrm{class}}=z_{\mathrm{cluster}}=z_{\mathrm{phase}}=z_{\mathrm{cause}}=1' word_latex,'Bedingung vollständig abgeschlossener Interpretation.' plain_description,'criterion' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1417' equation_number,'Methodische Reihenfolge' title,'\text{Normierung}\longrightarrow\text{Distanzanalyse}\longrightarrow\text{Phasenerkennung}\longrightarrow\text{Merkmalsextraktion}\longrightarrow\text{Klassifikation}\longrightarrow\text{Interpretation}' equation_latex,'\text{Normierung}\longrightarrow\text{Distanzanalyse}\longrightarrow\text{Phasenerkennung}\longrightarrow\text{Merkmalsextraktion}\longrightarrow\text{Klassifikation}\longrightarrow\text{Interpretation}' word_latex,'Ablauf der Trajektorienanalyse.' plain_description,'process' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
UNION ALL
SELECT '3.1418' equation_number,'Beobachtete und ontologische Klasse' title,'K_{\Gamma}^{\mathrm{obs}}\neq K_{\Gamma}^{\mathrm{ont}}' equation_latex,'K_{\Gamma}^{\mathrm{obs}}\neq K_{\Gamma}^{\mathrm{ont}}' word_latex,'Methodenabhängige Klassifikation ist keine ontologische Festlegung.' plain_description,'theoretical' equation_type,'original' provenance,NULL source_id,'Herleitung gemäß Abschnitt 3.8.9.' derivation,'Die im Abschnitt definierten Vergleichs- und Klassifikationsbedingungen gelten.' assumptions
) x
WHERE @section_id IS NOT NULL AND @revision_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM equations e WHERE e.equation_number=x.equation_number
);

/* Abschnittssymbole */

INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,
 scope_type,first_section_id,first_equation_id,unit_text,domain_text,
 codomain_text,is_vector,is_matrix,is_operator,notes,
 validation_status,created_revision_id)
SELECT x.symbol_latex,x.symbol_latex,x.symbol_name,x.definition_text,
 'section',@section_id,
 (SELECT equation_id FROM equations WHERE equation_number=x.first_eq LIMIT 1),
 NULL,x.domain_text,NULL,x.is_vector,x.is_matrix,x.is_operator,
 'Abschnittssymbol 3.8.9.','draft',@revision_id
FROM (
 SELECT 'C_{\Gamma}' symbol_latex,'Trajektorienvergleichsvektor' symbol_name,'Vergleichsstruktur zweier Trajektorien.' definition_text,'3.1370' first_eq,NULL domain_text,1 is_vector,0 is_matrix,0 is_operator
 UNION ALL SELECT '\lambda','Normierte Zeit','Normierte Zeitvariable.','3.1371','[0,1]',0,0,0
 UNION ALL SELECT '\widetilde{\Gamma}','Normierte Trajektorie','Zeitnormierte Trajektorie.','3.1372',NULL,0,0,0
 UNION ALL SELECT 'J','Interpolationsfunktion','Abbildung diskreter Zustände auf normierte Zeit.','3.1373',NULL,0,0,1
 UNION ALL SELECT 'D_{\mathrm{glob}}','Globale Trajektoriendistanz','Aggregierte Gesamtabweichung.','3.1374','R_{ge_0}',0,0,0
 UNION ALL SELECT '\delta_{a,b}','Lokale Abweichungsfunktion','Lokale Distanz zweier Trajektorien.','3.1376','R_{ge_0}',0,0,0
 UNION ALL SELECT 'D_{\mathrm{end}}','Endzustandsdistanz','Distanz der Endzustände.','3.1379','R_{ge_0}',0,0,0
 UNION ALL SELECT '\Delta S_{i,t}','Operatorischer Übergangsvektor','Zustandsänderung eines Operatoraufrufs.','3.1382',NULL,1,0,0
 UNION ALL SELECT '\Phi(\Gamma)','Phasenzerlegung','Geordnete Phasen einer Trajektorie.','3.1385',NULL,0,0,0
 UNION ALL SELECT 'F_{\phi_r}','Phasenmerkmalsvektor','Merkmale einer Entwicklungsphase.','3.1389',NULL,1,0,0
 UNION ALL SELECT 'F_{\Gamma}','Trajektorienmerkmalsvektor','Merkmale eines vollständigen Laufs.','3.1392',NULL,1,0,0
 UNION ALL SELECT 'M_{\Gamma}','Trajektoriendistanzmatrix','Paarweise Distanzmatrix.','3.1394',NULL,0,1,0
 UNION ALL SELECT '\kappa','Klassifikationsabbildung','Abbildung von Merkmalen auf Klassen.','3.1398',NULL,0,0,1
 UNION ALL SELECT '\mathcal{K}_{\Gamma}','Trajektorienklassen','Menge der Trajektorienklassen.','3.1399',NULL,0,0,0
 UNION ALL SELECT 'J_t','Übergangsindikator','Mehrkriterieller Indikator kritischer Übergänge.','3.1403','R_{ge_0}',0,0,0
 UNION ALL SELECT '\mathcal{G}','Clustermenge','Menge aller Trajektoriencluster.','3.1406',NULL,0,0,0
 UNION ALL SELECT '\mu_{ij}','Clusterzugehörigkeitsgrad','Unscharfer Zugehörigkeitsgrad.','3.1408','[0,1]',0,0,0
 UNION ALL SELECT '\Gamma_j^{\mathrm{rep}}','Repräsentative Trajektorie','Medoid eines Clusters.','3.1410',NULL,0,0,0
 UNION ALL SELECT 'A_i','Mittlere Ausreißerdistanz','Mittlere Distanz zu allen anderen Läufen.','3.1411','R_{ge_0}',0,0,0
 UNION ALL SELECT 'Z_{\mathrm{int}}','Interpretationsstatusvektor','Status der Trajektorieninterpretation.','3.1414','{0,1,u}^5',1,0,0
) x
WHERE @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM symbols s
 WHERE s.symbol_latex=x.symbol_latex
   AND s.scope_type='section'
   AND s.first_section_id=@section_id
);

/* Gleichungssymbole */

INSERT INTO equation_symbols
(equation_id,symbol_latex,symbol_name,definition_text,
 unit_text,domain_text,symbol_order)
SELECT e.equation_id,x.symbol_latex,x.symbol_name,x.definition_text,
 NULL,x.domain_text,x.symbol_order
FROM (
 SELECT '3.1370' eq,'C_{\Gamma}' symbol_latex,'Vergleichsvektor' symbol_name,'Vergleichsstruktur zweier Trajektorien.' definition_text,NULL domain_text,1 symbol_order
 UNION ALL SELECT '3.1371','\lambda','Normierte Zeit','Normierte Zeitkoordinate.','[0,1]',1
 UNION ALL SELECT '3.1372','\widetilde{\Gamma}','Normierte Trajektorie','Zeitnormierte Trajektorie.',NULL,1
 UNION ALL SELECT '3.1373','J','Interpolationsfunktion','Interpolation eines Zustands.',NULL,1
 UNION ALL SELECT '3.1374','D_{\mathrm{glob}}','Globale Distanz','Gesamtabweichung zweier Trajektorien.','R_{ge_0}',1
 UNION ALL SELECT '3.1376','\delta_{a,b}','Lokale Abweichung','Lokale Distanzfunktion.','R_{ge_0}',1
 UNION ALL SELECT '3.1379','D_{\mathrm{end}}','Endzustandsdistanz','Distanz der Endzustände.','R_{ge_0}',1
 UNION ALL SELECT '3.1382','\Delta S_{i,t}','Operatorübergang','Zustandsänderung eines Operators.',NULL,1
 UNION ALL SELECT '3.1385','\Phi(\Gamma)','Phasenzerlegung','Geordnete Trajektorienphasen.',NULL,1
 UNION ALL SELECT '3.1389','F_{\phi_r}','Phasenmerkmalsvektor','Merkmale einer Phase.',NULL,1
 UNION ALL SELECT '3.1392','F_{\Gamma}','Trajektorienmerkmalsvektor','Merkmale eines Laufs.',NULL,1
 UNION ALL SELECT '3.1394','M_{\Gamma}','Distanzmatrix','Paarweise Trajektoriendistanzen.',NULL,1
 UNION ALL SELECT '3.1398','\kappa','Klassifikationsabbildung','Zuordnung zu Trajektorienklassen.',NULL,1
 UNION ALL SELECT '3.1399','\mathcal{K}_{\Gamma}','Trajektorienklassen','Menge der Klassen.',NULL,1
 UNION ALL SELECT '3.1403','J_t','Übergangsindikator','Indikator kritischer Übergänge.','R_{ge_0}',1
 UNION ALL SELECT '3.1406','\mathcal{G}','Clustermenge','Menge der Trajektoriencluster.',NULL,1
 UNION ALL SELECT '3.1408','\mu_{ij}','Zugehörigkeitsgrad','Unscharfe Clusterzugehörigkeit.','[0,1]',1
 UNION ALL SELECT '3.1410','\Gamma_j^{\mathrm{rep}}','Clustermedoid','Repräsentative reale Trajektorie.',NULL,1
 UNION ALL SELECT '3.1411','A_i','Ausreißerdistanz','Mittlere Distanz zu anderen Läufen.','R_{ge_0}',1
 UNION ALL SELECT '3.1414','Z_{\mathrm{int}}','Interpretationsstatus','Status der Interpretation.','{0,1,u}^5',1
) x
JOIN equations e ON e.equation_number=x.eq
WHERE NOT EXISTS (
 SELECT 1 FROM equation_symbols es
 WHERE es.equation_id=e.equation_id
   AND es.symbol_latex=x.symbol_latex
);

/* Änderungsprotokoll */

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,
 change_summary,previous_value,new_value,changed_at)
SELECT @revision_id,@section_id,x.change_type,x.object_type,
 x.object_reference,x.change_summary,x.previous_value,x.new_value,NOW()
FROM (
 SELECT 'created' change_type,'section' object_type,'3.8.9' object_reference,
 'Abschnitt 3.8.9 wurde angelegt.' change_summary,NULL previous_value,'draft' new_value
 UNION ALL SELECT 'source_added','sources','[124]-[125]',
 'Zwei Quellen zu Zeitreihenvergleich und Clusteranalyse wurden aufgenommen.',
 'last_citation_number=123','last_citation_number=125'
 UNION ALL SELECT 'definition_added','definitions','3.8.9.1-3.8.9.9',
 'Neun Definitionen wurden registriert.',NULL,'9 definitions'
 UNION ALL SELECT 'equation_added','equations','3.1370-3.1418',
 'Neunundvierzig Gleichungen wurden registriert.',
 'last_equation=3.1369','last_equation=3.1418'
 UNION ALL SELECT 'symbol_added','symbols','3.8.9',
 'Abschnittssymbole und Gleichungsverwendungen wurden registriert.',
 NULL,'20 section symbols'
) x
WHERE @revision_id IS NOT NULL AND @section_id IS NOT NULL
AND NOT EXISTS (
 SELECT 1 FROM section_change_log scl
 WHERE scl.revision_id=@revision_id
   AND scl.section_id=@section_id
   AND scl.change_type=x.change_type
   AND COALESCE(scl.object_reference,'')=COALESCE(x.object_reference,'')
);

/* Abschlussaudit */

SET @source_count := (
 SELECT COUNT(*) FROM sources WHERE citation_number IN (124,125)
);
SET @author_link_count := (
 SELECT COUNT(*) FROM source_authors WHERE source_id IN (@source_124,@source_125)
);
SET @usage_count := (
 SELECT COUNT(*) FROM source_usage
 WHERE section_id=@section_id AND source_id IN (@source_124,@source_125)
);
SET @definition_count := (
 SELECT COUNT(*) FROM definitions
 WHERE section_id=@section_id
   AND definition_number IN
   ('3.8.9.1','3.8.9.2','3.8.9.3','3.8.9.4','3.8.9.5',
    '3.8.9.6','3.8.9.7','3.8.9.8','3.8.9.9')
);
SET @equation_count := (
 SELECT COUNT(*) FROM equations
 WHERE section_id=@section_id
   AND equation_number BETWEEN '3.1370' AND '3.1418'
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
 AND @author_link_count=4
 AND @usage_count=2
 AND @definition_count=9
 AND @equation_count=49
 AND @symbol_count>=20
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
 THEN 'Kapitel 3.8.9 wurde vollständig und schema-konform importiert.'
 ELSE 'FEHLER: Abschnitt 3.8.9 ist unvollständig. Auditwerte prüfen.'
 END AS audit_message;

SELECT citation_number,full_citation_text,verification_status
FROM sources
WHERE citation_number IN (124,125)
ORDER BY citation_number;

SELECT definition_number,title,validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY definition_number;

SELECT equation_number,title,validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
