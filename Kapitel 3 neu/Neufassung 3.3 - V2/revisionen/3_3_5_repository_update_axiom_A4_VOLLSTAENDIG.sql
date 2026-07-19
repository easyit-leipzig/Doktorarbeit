/* ============================================================================
   FRZK-RKB – Repository-Update Kapitel 3.3.5
   Axiom A4 – Funktionale Kompatibilität
   Idempotentes Vollskript
   Voraussetzung: RKB-NEU-K3.3.4-V1, Abschnitt 3.3, Gleichungen bis (3.397)
   ============================================================================ */
START TRANSACTION;

SET @parent_revision_id := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.3.4-V1' LIMIT 1);
SET @section_33_id := (SELECT section_id FROM dissertation_sections WHERE section_code='3.3' LIMIT 1);

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT 'RKB-NEU-K3.3.5-V1',NOW(),'section','3.3.5','1.0',
       'Abschnitt 3.3.5: Axiom A4 der funktionalen Kompatibilität, Proposition 3.3.4 und Gleichungen (3.398) bis (3.411).',
       'Olaf Thiele / ChatGPT',@parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM repository_revisions WHERE revision_code='RKB-NEU-K3.3.5-V1');

SET @revision_335 := (SELECT revision_id FROM repository_revisions WHERE revision_code='RKB-NEU-K3.3.5-V1' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT @section_33_id,'3.3.5','Axiom A4 – Funktionale Kompatibilität',3,3.3050,'final',1,
       'Kompatible Operationen, funktionale Rekonstruierbarkeit, Kompatibilitätsoperator und Kompatibilitätsgrad.'
WHERE @section_33_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM dissertation_sections WHERE section_code='3.3.5');

UPDATE dissertation_sections
SET parent_section_id=@section_33_id,
    title='Axiom A4 – Funktionale Kompatibilität',
    chapter_no=3,section_order=3.3050,status='final',is_original_contribution=1,
    notes='Kompatible Operationen, funktionale Rekonstruierbarkeit, Kompatibilitätsoperator und Kompatibilitätsgrad.'
WHERE section_code='3.3.5';

SET @section_335_id := (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5' LIMIT 1);

INSERT INTO axioms
(axiom_number,section_id,title,axiom_text,formal_latex,word_latex,motivation,independence_note,consistency_note,operationalization_note,source_assumption_id,status,created_revision_id)
SELECT 'A4',@section_335_id,'Funktionale Kompatibilität',
       'Eine Folge funktionaler Transformationen darf die funktionale Rekonstruierbarkeit der gemeinsamen Organisation nicht vollständig aufheben.',
       '\\exists\\Psi:\\mathcal{S}^{\\prime}\\rightarrow\\mathcal{S}\\quad\\text{mit}\\quad\\Psi\\circ O_F\\neq\\varnothing',
       '\\exists\\Psi:\\mathcal{S}^{\\prime}\\rightarrow\\mathcal{S}\\quad\\text{mit}\\quad\\Psi\\circ O_F\\neq\\varnothing',
       'Relationierbarkeit und Transformierbarkeit erklären noch nicht, weshalb eine Organisation über Veränderungen hinweg rekonstruierbar bleibt.',
       'Axiom A4 wird nicht aus Axiom A3 abgeleitet; A3 begründet nur die Möglichkeit von Transformationen.',
       'A4 ist mit A1 bis A3 vereinbar, weil weder Identität noch vollständige Invertierbarkeit gefordert werden.',
       'Operationalisierung über kompatible Operationen, Rekonstruktionsabbildungen, K_F und kappa_C.',
       NULL,'accepted',@revision_335
WHERE @section_335_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM axioms WHERE axiom_number='A4');

UPDATE axioms
SET section_id=@section_335_id,
    title='Funktionale Kompatibilität',
    axiom_text='Eine Folge funktionaler Transformationen darf die funktionale Rekonstruierbarkeit der gemeinsamen Organisation nicht vollständig aufheben.',
    formal_latex='\\exists\\Psi:\\mathcal{S}^{\\prime}\\rightarrow\\mathcal{S}\\quad\\text{mit}\\quad\\Psi\\circ O_F\\neq\\varnothing',
    word_latex='\\exists\\Psi:\\mathcal{S}^{\\prime}\\rightarrow\\mathcal{S}\\quad\\text{mit}\\quad\\Psi\\circ O_F\\neq\\varnothing',
    motivation='Relationierbarkeit und Transformierbarkeit erklären noch nicht, weshalb eine Organisation über Veränderungen hinweg rekonstruierbar bleibt.',
    independence_note='Axiom A4 wird nicht aus Axiom A3 abgeleitet; A3 begründet nur die Möglichkeit von Transformationen.',
    consistency_note='A4 ist mit A1 bis A3 vereinbar, weil weder Identität noch vollständige Invertierbarkeit gefordert werden.',
    operationalization_note='Operationalisierung über kompatible Operationen, Rekonstruktionsabbildungen, K_F und kappa_C.',
    status='accepted',created_revision_id=@revision_335
WHERE axiom_number='A4' AND @section_335_id IS NOT NULL;

SET @axiom_a1_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A1' LIMIT 1);
SET @axiom_a2_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A2' LIMIT 1);
SET @axiom_a3_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A3' LIMIT 1);
SET @axiom_a4_id := (SELECT axiom_id FROM axioms WHERE axiom_number='A4' LIMIT 1);

INSERT INTO axiom_dependencies(axiom_id,depends_on_axiom_id,dependency_type,note)
SELECT @axiom_a4_id,@axiom_a3_id,'extends','Axiom A4 erweitert A3 um funktionale Rekonstruierbarkeit.'
WHERE @axiom_a4_id IS NOT NULL AND @axiom_a3_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM axiom_dependencies WHERE axiom_id=@axiom_a4_id AND depends_on_axiom_id=@axiom_a3_id AND dependency_type='extends');

/* Gleichungen (3.398)–(3.411) */
INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.398',@section_335_id,'Menge kompatibler funktionaler Operationen','\\mathcal{O}_F^{\\ast}\\subseteq\\mathcal{O}_F','\\mathcal{O}_F^{\\ast}\\subseteq\\mathcal{O}_F','Kompatible Operationen bilden eine Teilmenge aller funktionalen Operationen.','definition','original',NULL,'Einführung der kompatiblen Operationsklasse.','O_F ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.398');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.399',@section_335_id,'Funktionale Organisation','\\mathcal{S}=(\\mathcal{F},\\mathcal{R}_F)','\\mathcal{S}=(\\mathcal{F},\\mathcal{R}_F)','Funktionale Organisation als Paar aus Trägerbereich und Relationsmenge.','definition','original',NULL,'Zusammenfassung der funktionalen Struktur.','A1 und A2.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.399');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.400',@section_335_id,'Transformierte funktionale Organisation','O_F(\\mathcal{S})=\\mathcal{S}^{\\prime}','O_F(\\mathcal{S})=\\mathcal{S}^{\\prime}','Eine Operation überführt S in S Strich.','model','original',NULL,'Anwendung von O_F auf die Organisation.','A3.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.400');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.401',@section_335_id,'Rekonstruktionsabbildung','\\Psi:\\mathcal{S}^{\\prime}\\rightarrow\\mathcal{S}','\\Psi:\\mathcal{S}^{\\prime}\\rightarrow\\mathcal{S}','Rekonstruktionsabbildung von der transformierten zur Ausgangsorganisation.','definition','original',NULL,'Einführung funktionaler Rekonstruierbarkeit.','S Strich ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.401');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.402',@section_335_id,'Existenz funktionaler Rekonstruktion','\\Psi\\circ O_F\\neq\\varnothing','\\Psi\\circ O_F\\neq\\varnothing','Transformation und Rekonstruktion besitzen eine nichtleere Komposition.','axiom','original',NULL,'Kernbedingung von A4.','A4.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.402');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.403',@section_335_id,'Kompatible Transformationsfolge','O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal{O}_F^{\\ast}','O_{F,n}\\circ\\cdots\\circ O_{F,1}\\in\\mathcal{O}_F^{\\ast}','Eine Transformationsfolge gehört zur kompatiblen Operationsklasse.','definition','original',NULL,'Erweiterung auf zusammengesetzte Operationen.','Komposition ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.403');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.404',@section_335_id,'Funktionaler Kompatibilitätsoperator','K_F:\\mathcal{O}_F\\rightarrow\\{0,1\\}','K_F:\\mathcal{O}_F\\rightarrow\\{0,1\\}','Binärer Operator zur Kennzeichnung funktionaler Kompatibilität.','definition','original',NULL,'Einführung einer Entscheidungsfunktion.','O_F ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.404');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.405',@section_335_id,'Fallunterscheidung des Kompatibilitätsoperators','K_F(O_F)=\\begin{cases}1,&O_F\\in\\mathcal{O}_F^{\\ast},\\\\0,&\\text{sonst}.\\end{cases}','K_F(O_F)=\\begin{cases}1,&O_F\\in\\mathcal{O}_F^{\\ast},\\\\0,&\\text{sonst}.\\end{cases}','Eins kennzeichnet kompatible, null nicht kompatible Operationen.','definition','original',NULL,'Explizite Definition von K_F.','O_F* ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.405');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.406',@section_335_id,'Funktionaler Kompatibilitätsgrad','\\kappa_C:\\mathcal{O}_F\\rightarrow[0,1]','\\kappa_C:\\mathcal{O}_F\\rightarrow[0,1]','Quantitatives Kompatibilitätsmaß zwischen null und eins.','definition','original',NULL,'Quantitative Erweiterung von K_F.','O_F ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.406');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.407',@section_335_id,'Vollständige funktionale Kompatibilität','\\kappa_C(O_F)=1','\\kappa_C(O_F)=1','Eins bezeichnet vollständige funktionale Kompatibilität.','definition','original',NULL,'Oberer Grenzfall.','kappa_C ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.407');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.408',@section_335_id,'Vollständiger Verlust der Rekonstruierbarkeit','\\kappa_C(O_F)=0','\\kappa_C(O_F)=0','Null bezeichnet den vollständigen Verlust funktionaler Rekonstruierbarkeit.','definition','original',NULL,'Unterer Grenzfall.','kappa_C ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.408');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.409',@section_335_id,'Folge funktionaler Organisationen','\\mathcal{S}_0,\\mathcal{S}_1,\\dots,\\mathcal{S}_n','\\mathcal{S}_0,\\mathcal{S}_1,\\dots,\\mathcal{S}_n','Geordnete Folge funktionaler Organisationen.','definition','original',NULL,'Ausgangspunkt der Proposition 3.3.4.','S ist definiert.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.409');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.410',@section_335_id,'Transformation aufeinanderfolgender Organisationen','\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)','\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)','Jede Folgeorganisation entsteht durch eine Operation auf der vorherigen.','model','original',NULL,'Rekursive Konstruktion eines Organisationspfades.','A3.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.410');

INSERT INTO equations(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT '3.411',@section_335_id,'Kompatibilitätsbedingung eines Organisationspfades','K_F(O_{F,i})=1\\qquad\\forall i','K_F(O_{F,i})=1\\qquad\\forall i','Alle Operationen des Organisationspfades sind kompatibel.','theorem','original',NULL,'Formale Bedingung der Proposition 3.3.4.','A4 und K_F.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equations WHERE equation_number='3.411');

SET @eq_3398 := (SELECT equation_id FROM equations WHERE equation_number='3.398' LIMIT 1);
SET @eq_3399 := (SELECT equation_id FROM equations WHERE equation_number='3.399' LIMIT 1);
SET @eq_3401 := (SELECT equation_id FROM equations WHERE equation_number='3.401' LIMIT 1);
SET @eq_3404 := (SELECT equation_id FROM equations WHERE equation_number='3.404' LIMIT 1);
SET @eq_3406 := (SELECT equation_id FROM equations WHERE equation_number='3.406' LIMIT 1);
SET @eq_3410 := (SELECT equation_id FROM equations WHERE equation_number='3.410' LIMIT 1);
SET @eq_3411 := (SELECT equation_id FROM equations WHERE equation_number='3.411' LIMIT 1);

INSERT INTO propositions
(proposition_number,section_id,title,statement_text,statement_latex,word_latex,logical_derivation,based_on_axioms,status,created_revision_id)
SELECT '3.3.4',@section_335_id,'Kompatibilität erzeugt rekonstruierbare Organisationspfade',
       'Sei S_0 bis S_n eine Folge funktionaler Organisationen. Sind alle beteiligten Operationen kompatibel, existiert für jede Organisation eine rekonstruierbare funktionale Verbindung zur Ausgangsorganisation.',
       '\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land K_F(O_{F,i})=1\\;\\forall i\\;\\Longrightarrow\\;\\mathcal{S}_n\\text{ bleibt funktional auf }\\mathcal{S}_0\\text{ rekonstruierbar}',
       '\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land K_F(O_{F,i})=1\\;\\forall i\\;\\Longrightarrow\\;\\mathcal{S}_n\\text{ bleibt funktional auf }\\mathcal{S}_0\\text{ rekonstruierbar}',
       'Nach Axiom A4 lässt jede kompatible Operation eine funktionale Rekonstruktionsbeziehung zu. Diese Eigenschaft kann entlang der Transformationsfolge fortgesetzt werden.',
       'A1,A2,A3,A4','accepted',@revision_335
WHERE @section_335_id IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM propositions WHERE proposition_number='3.3.4');

UPDATE propositions
SET section_id=@section_335_id,title='Kompatibilität erzeugt rekonstruierbare Organisationspfade',
    statement_text='Sei S_0 bis S_n eine Folge funktionaler Organisationen. Sind alle beteiligten Operationen kompatibel, existiert für jede Organisation eine rekonstruierbare funktionale Verbindung zur Ausgangsorganisation.',
    statement_latex='\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land K_F(O_{F,i})=1\\;\\forall i\\;\\Longrightarrow\\;\\mathcal{S}_n\\text{ bleibt funktional auf }\\mathcal{S}_0\\text{ rekonstruierbar}',
    word_latex='\\mathcal{S}_{i+1}=O_{F,i}(\\mathcal{S}_i)\\land K_F(O_{F,i})=1\\;\\forall i\\;\\Longrightarrow\\;\\mathcal{S}_n\\text{ bleibt funktional auf }\\mathcal{S}_0\\text{ rekonstruierbar}',
    logical_derivation='Nach Axiom A4 lässt jede kompatible Operation eine funktionale Rekonstruktionsbeziehung zu. Diese Eigenschaft kann entlang der Transformationsfolge fortgesetzt werden.',
    based_on_axioms='A1,A2,A3,A4',status='accepted',created_revision_id=@revision_335
WHERE proposition_number='3.3.4' AND @section_335_id IS NOT NULL;

SET @prop_334_id := (SELECT proposition_id FROM propositions WHERE proposition_number='3.3.4' LIMIT 1);

INSERT INTO proposition_dependencies(proposition_id,axiom_id,assumption_id,dependency_type,note)
SELECT @prop_334_id,@axiom_a1_id,NULL,'uses','Unterscheidbare funktionale Gehalte sind vorausgesetzt.'
WHERE @prop_334_id IS NOT NULL AND @axiom_a1_id IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM proposition_dependencies WHERE proposition_id=@prop_334_id AND axiom_id=@axiom_a1_id AND dependency_type='uses');
INSERT INTO proposition_dependencies(proposition_id,axiom_id,assumption_id,dependency_type,note)
SELECT @prop_334_id,@axiom_a2_id,NULL,'uses','Die Organisation enthält funktionale Relationen.'
WHERE @prop_334_id IS NOT NULL AND @axiom_a2_id IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM proposition_dependencies WHERE proposition_id=@prop_334_id AND axiom_id=@axiom_a2_id AND dependency_type='uses');
INSERT INTO proposition_dependencies(proposition_id,axiom_id,assumption_id,dependency_type,note)
SELECT @prop_334_id,@axiom_a3_id,NULL,'uses','Der Organisationspfad entsteht durch Transformationen.'
WHERE @prop_334_id IS NOT NULL AND @axiom_a3_id IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM proposition_dependencies WHERE proposition_id=@prop_334_id AND axiom_id=@axiom_a3_id AND dependency_type='uses');
INSERT INTO proposition_dependencies(proposition_id,axiom_id,assumption_id,dependency_type,note)
SELECT @prop_334_id,@axiom_a4_id,NULL,'derived_from','Rekonstruierbarkeit folgt aus Axiom A4.'
WHERE @prop_334_id IS NOT NULL AND @axiom_a4_id IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM proposition_dependencies WHERE proposition_id=@prop_334_id AND axiom_id=@axiom_a4_id AND dependency_type='derived_from');

/* Symbolregister */
INSERT INTO symbols(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
SELECT '\\mathcal{O}_F^{\\ast}','\\mathcal{O}_F^{\\ast}','Menge kompatibler funktionaler Operationen','Teilmenge aller funktionalen Operationen mit erhaltener Rekonstruierbarkeit.','chapter',@section_335_id,@eq_3398,NULL,NULL,NULL,0,0,0,'Erstdefinition in (3.398).','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{O}_F^{\\ast}');
INSERT INTO symbols(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
SELECT '\\mathcal{S}','\\mathcal{S}','funktionale Organisation','Paar aus funktionalem Trägerbereich und Relationsmenge.','chapter',@section_335_id,@eq_3399,NULL,NULL,NULL,0,0,0,'Organisation nach 3.3.5.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{S}' AND symbol_name='funktionale Organisation');
INSERT INTO symbols(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
SELECT '\\Psi','\\Psi','funktionale Rekonstruktionsabbildung','Abbildung von der transformierten zur rekonstruierbaren Ausgangsorganisation.','chapter',@section_335_id,@eq_3401,NULL,'\\mathcal{S}^{\\prime}','\\mathcal{S}',0,0,1,'Nicht notwendig vollständig invertierend.','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM symbols WHERE symbol_latex='\\Psi' AND symbol_name='funktionale Rekonstruktionsabbildung');
INSERT INTO symbols(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
SELECT 'K_F','K_F','funktionaler Kompatibilitätsoperator','Binärer Operator für kompatible und nicht kompatible Operationen.','chapter',@section_335_id,@eq_3404,NULL,'\\mathcal{O}_F','\\{0,1\\}',0,0,1,'Erstdefinition in (3.404).','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM symbols WHERE symbol_latex='K_F' AND symbol_name='funktionaler Kompatibilitätsoperator');
INSERT INTO symbols(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,first_section_id,first_equation_id,unit_text,domain_text,codomain_text,is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
SELECT '\\kappa_C','\\kappa_C','funktionaler Kompatibilitätsgrad','Quantitatives Maß im Intervall [0,1].','chapter',@section_335_id,@eq_3406,NULL,'\\mathcal{O}_F','[0,1]',0,0,1,'Erstdefinition in (3.406).','checked',@revision_335
WHERE @section_335_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM symbols WHERE symbol_latex='\\kappa_C');

/* Gleichungssymbole */
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3398,'\\mathcal{O}_F^{\\ast}','Menge kompatibler funktionaler Operationen','Kompatible Teilmenge von O_F.',NULL,NULL,1
WHERE @eq_3398 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3398 AND symbol_latex='\\mathcal{O}_F^{\\ast}');
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3399,'\\mathcal{S}','funktionale Organisation','Paar aus F und R_F.',NULL,NULL,1
WHERE @eq_3399 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3399 AND symbol_latex='\\mathcal{S}');
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3401,'\\Psi','funktionale Rekonstruktionsabbildung','Rekonstruktionsabbildung von S Strich nach S.',NULL,'\\mathcal{S}^{\\prime}',1
WHERE @eq_3401 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3401 AND symbol_latex='\\Psi');
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3404,'K_F','funktionaler Kompatibilitätsoperator','Binärer Operator auf O_F.',NULL,'\\mathcal{O}_F',1
WHERE @eq_3404 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3404 AND symbol_latex='K_F');
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3406,'\\kappa_C','funktionaler Kompatibilitätsgrad','Kompatibilitätsmaß zwischen null und eins.',NULL,'\\mathcal{O}_F',1
WHERE @eq_3406 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3406 AND symbol_latex='\\kappa_C');
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3410,'\\mathcal{S}_i','i-te funktionale Organisation','Glied des Organisationspfades.',NULL,NULL,1
WHERE @eq_3410 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3410 AND symbol_latex='\\mathcal{S}_i');
INSERT INTO equation_symbols(equation_id,symbol_latex,symbol_name,definition_text,unit_text,domain_text,symbol_order)
SELECT @eq_3411,'O_{F,i}','i-te funktionale Operation','Operation zwischen S_i und S_i+1.',NULL,'\\mathcal{O}_F',1
WHERE @eq_3411 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3411 AND symbol_latex='O_{F,i}');

/* Änderungsprotokoll */
INSERT INTO section_change_log(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_335,@section_335_id,'created','section','3.3.5','Abschnitt 3.3.5 vollständig angelegt.',NULL,'Axiom A4 – Funktionale Kompatibilität'
WHERE @revision_335 IS NOT NULL AND @section_335_id IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM section_change_log WHERE revision_id=@revision_335 AND object_reference='3.3.5' AND change_type='created');
INSERT INTO section_change_log(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_335,@section_335_id,'axiom_added','axiom','A4','Axiom A4 registriert.',NULL,'A4 – Funktionale Kompatibilität'
WHERE @revision_335 IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM section_change_log WHERE revision_id=@revision_335 AND object_reference='A4' AND object_type='axiom');
INSERT INTO section_change_log(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_335,@section_335_id,'proposition_added','proposition','3.3.4','Proposition 3.3.4 registriert.',NULL,'Kompatibilität erzeugt rekonstruierbare Organisationspfade'
WHERE @revision_335 IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM section_change_log WHERE revision_id=@revision_335 AND object_reference='3.3.4' AND object_type='proposition');
INSERT INTO section_change_log(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT @revision_335,@section_335_id,'equation_added','equation','(3.398)–(3.411)','Vierzehn Gleichungen aufgenommen.',NULL,'Gleichungen (3.398) bis (3.411)'
WHERE @revision_335 IS NOT NULL
  AND NOT EXISTS(SELECT 1 FROM section_change_log WHERE revision_id=@revision_335 AND object_reference='(3.398)–(3.411)');

/* Validierungen */
INSERT INTO repository_validation_results(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_335,'K3.3.5.SECTION',CASE WHEN @section_335_id IS NOT NULL THEN 'passed' ELSE 'failed' END,'1',CASE WHEN @section_335_id IS NOT NULL THEN '1' ELSE '0' END,'Abschnitt 3.3.5 vorhanden.'
WHERE @revision_335 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_335 AND validation_code='K3.3.5.SECTION');
INSERT INTO repository_validation_results(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_335,'K3.3.5.EQUATIONS',CASE WHEN (SELECT COUNT(*) FROM equations WHERE equation_number IN ('3.398','3.399','3.400','3.401','3.402','3.403','3.404','3.405','3.406','3.407','3.408','3.409','3.410','3.411'))=14 THEN 'passed' ELSE 'failed' END,'14',CAST((SELECT COUNT(*) FROM equations WHERE equation_number IN ('3.398','3.399','3.400','3.401','3.402','3.403','3.404','3.405','3.406','3.407','3.408','3.409','3.410','3.411')) AS CHAR),'Gleichungen (3.398) bis (3.411) vorhanden.'
WHERE @revision_335 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_335 AND validation_code='K3.3.5.EQUATIONS');
INSERT INTO repository_validation_results(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_335,'K3.3.5.AXIOM_A4',CASE WHEN @axiom_a4_id IS NOT NULL THEN 'passed' ELSE 'failed' END,'1',CASE WHEN @axiom_a4_id IS NOT NULL THEN '1' ELSE '0' END,'Axiom A4 vorhanden.'
WHERE @revision_335 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_335 AND validation_code='K3.3.5.AXIOM_A4');
INSERT INTO repository_validation_results(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_335,'K3.3.5.PROPOSITION',CASE WHEN @prop_334_id IS NOT NULL THEN 'passed' ELSE 'failed' END,'1',CASE WHEN @prop_334_id IS NOT NULL THEN '1' ELSE '0' END,'Proposition 3.3.4 vorhanden.'
WHERE @revision_335 IS NOT NULL AND NOT EXISTS(SELECT 1 FROM repository_validation_results WHERE revision_id=@revision_335 AND validation_code='K3.3.5.PROPOSITION');

SELECT CASE
 WHEN @parent_revision_id IS NULL THEN 'FEHLER: Vorgängerrevision RKB-NEU-K3.3.4-V1 fehlt.'
 WHEN @section_33_id IS NULL THEN 'FEHLER: Hauptabschnitt 3.3 fehlt.'
 WHEN @revision_335 IS NULL THEN 'FEHLER: Revision 3.3.5 fehlt.'
 WHEN @section_335_id IS NULL THEN 'FEHLER: Abschnitt 3.3.5 fehlt.'
 WHEN @axiom_a4_id IS NULL THEN 'FEHLER: Axiom A4 fehlt.'
 WHEN @prop_334_id IS NULL THEN 'FEHLER: Proposition 3.3.4 fehlt.'
 ELSE 'OK: Repository-Update 3.3.5 vollständig ausgeführt.' END AS import_status;

SELECT rr.revision_code,rr.parent_revision_id,ds.section_code,ds.title,ds.status,
       (SELECT COUNT(*) FROM equations WHERE equation_number IN ('3.398','3.399','3.400','3.401','3.402','3.403','3.404','3.405','3.406','3.407','3.408','3.409','3.410','3.411')) AS equation_count,
       (SELECT COUNT(*) FROM axioms WHERE axiom_number='A4' AND section_id=ds.section_id) AS axiom_count,
       (SELECT COUNT(*) FROM propositions WHERE proposition_number='3.3.4' AND section_id=ds.section_id) AS proposition_count
FROM repository_revisions rr JOIN dissertation_sections ds ON ds.section_code=rr.scope_reference
WHERE rr.revision_code='RKB-NEU-K3.3.5-V1';

SELECT equation_number,title,validation_status FROM equations
WHERE equation_number IN ('3.398','3.399','3.400','3.401','3.402','3.403','3.404','3.405','3.406','3.407','3.408','3.409','3.410','3.411')
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
SELECT axiom_number,section_id,title,status,created_revision_id FROM axioms WHERE axiom_number='A4';
SELECT proposition_number,section_id,title,based_on_axioms,status FROM propositions WHERE proposition_number='3.3.4';
SELECT validation_code,validation_status,expected_value,actual_value,validation_message FROM repository_validation_results WHERE revision_id=@revision_335 ORDER BY validation_code;

COMMIT;
