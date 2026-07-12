-- ============================================================
-- FRZK-RKB: Anpassung an die vollständige Neufassung von 3.3
-- Grundlage: aktueller Dump frzk_rkb.sql vom 12.07.2026
--
-- Neuer Nummerierungsstand:
--   Literatur: unverändert [1] bis [52]
--   nächste freie Literaturnummer: [53]
--   Gleichungen 3.3: (3.87) bis (3.99), insgesamt 13
--   nächste freie Gleichungsnummer: (3.100)
--
-- Alte Gleichungen (3.87) bis (3.115) werden vollständig ersetzt.
-- ============================================================

USE frzk_rkb;
SET NAMES utf8mb4;

START TRANSACTION;

-- ------------------------------------------------------------
-- 1. Neue Repository-Revision
-- ------------------------------------------------------------
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
VALUES
('RKB-2026-07-12-K3.3-NEUFASSUNG',NOW(),'chapter','3.3','2.0',
 'Vollständige Neufassung von Kapitel 3.3 als prämathematisches Axiomenkapitel; Anpassung von Gliederung, Axiomen, Propositionen, Gleichungen, Symbolen und Literaturverwendungen.',
 'Olaf Thiele / ChatGPT',
 (SELECT MAX(r.revision_id) FROM repository_revisions r2))
ON DUPLICATE KEY UPDATE
 revision_date=VALUES(revision_date),
 version_label=VALUES(version_label),
 summary=VALUES(summary);

SET @revision_id = (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-2026-07-12-K3.3-NEUFASSUNG'
);

-- ------------------------------------------------------------
-- 2. Kapitel- und Abschnittsstruktur aktualisieren
-- ------------------------------------------------------------
UPDATE dissertation_sections
SET title='Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems',
    status='review',
    is_original_contribution=1,
    section_order=3.4000
WHERE section_code='3.3';

SET @section_33 = (
    SELECT section_id FROM dissertation_sections WHERE section_code='3.3'
);

-- Bestehende Abschnittsdatensätze 3.3.0 bis 3.3.6 werden weiterverwendet.
UPDATE dissertation_sections
SET title='Einleitung',
    section_order=3.4001,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.0';

UPDATE dissertation_sections
SET title='Primitive Begriffe und axiomatische Ausgangspunkte',
    section_order=3.4100,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.1';

UPDATE dissertation_sections
SET title='Wissenschaftstheoretische Begründung der primitiven Begriffe',
    section_order=3.4200,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.2';

UPDATE dissertation_sections
SET title='Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit',
    section_order=3.4300,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.3';

UPDATE dissertation_sections
SET title='Axiom A2 – Prinzip der funktionalen Relationierbarkeit',
    section_order=3.4400,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.4';

UPDATE dissertation_sections
SET title='Axiom A3 – Prinzip der rekursiven Transformation',
    section_order=3.4500,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.5';

UPDATE dissertation_sections
SET title='Axiom A4 – Prinzip stabiler funktionaler Organisation',
    section_order=3.4600,
    status='review',
    is_original_contribution=1
WHERE section_code='3.3.6';

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
VALUES
(@section_33,'3.3.7','Axiom A5 – Prinzip reproduzierbarer Organisationsmuster',3,3.4700,'review',1,NULL),
(@section_33,'3.3.8','Zusammenfassung der axiomatischen Grundlagen',3,3.4800,'review',1,NULL),
(@section_33,'3.3.9','Logische Konsequenzen des Axiomensystems',3,3.4900,'review',1,NULL)
ON DUPLICATE KEY UPDATE
 parent_section_id=VALUES(parent_section_id),
 title=VALUES(title),
 section_order=VALUES(section_order),
 status='review',
 is_original_contribution=1;

SET @sec_330 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.0');
SET @sec_331 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.1');
SET @sec_332 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.2');
SET @sec_333 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.3');
SET @sec_334 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.4');
SET @sec_335 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.5');
SET @sec_336 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.6');
SET @sec_337 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.7');
SET @sec_338 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.8');
SET @sec_339 = (SELECT section_id FROM dissertation_sections WHERE section_code='3.3.9');

-- ------------------------------------------------------------
-- 3. Alte Gleichungen und zugehörige Kapitel-3.3-Symbole entfernen
-- ------------------------------------------------------------
DELETE FROM symbols
WHERE first_section_id IN (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code LIKE '3.3%'
);

DELETE FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 87 AND 115;

-- ------------------------------------------------------------
-- 4. Neue Gleichungen (3.87) bis (3.99)
-- ------------------------------------------------------------
INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,
 equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
VALUES
('3.87',@sec_330,'Konzeptionelle Entwicklungsrichtung',
 '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}',
 '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}',
 'Konzeptionelle Reihenfolge der grundlegenden Organisationsprinzipien des FRZK.',
 'schema','original',NULL,NULL,NULL,'checked',@revision_id),

('3.88',@sec_331,'Primitive begriffliche Entwicklungsfolge',
 '\\text{funktional}\\Longrightarrow\\text{Unterschied}\\Longrightarrow\\text{Relation}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}',
 '\\text{funktional}\\Longrightarrow\\text{Unterschied}\\Longrightarrow\\text{Relation}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}',
 'Qualitative Beziehung der sechs primitiven Begriffe.',
 'schema','original',NULL,NULL,NULL,'checked',@revision_id),

('3.89',@sec_333,'Axiom A1 – Funktionale Unterscheidbarkeit',
 '\\exists\\,\\Delta_F',
 '\\exists\\,\\Delta_F',
 'Logische Kennzeichnung der Möglichkeit funktionaler Unterscheidbarkeit.',
 'axiom','original',NULL,NULL,NULL,'checked',@revision_id),

('3.90',@sec_334,'Axiom A2 – Funktionale Relationierbarkeit',
 '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F',
 '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F',
 'Funktionale Unterscheidbarkeit eröffnet die Möglichkeit funktionaler Relationierung.',
 'axiom','original',NULL,NULL,NULL,'checked',@revision_id),

('3.91',@sec_335,'Axiom A3 – Rekursive Transformation',
 '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F',
 '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F',
 'Funktionale Relationierbarkeit eröffnet die Möglichkeit rekursiver Transformation.',
 'axiom','original',NULL,NULL,NULL,'checked',@revision_id),

('3.92',@sec_336,'Axiom A4 – Stabile funktionale Organisation',
 '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
 '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
 'Rekursive Transformation eröffnet die Möglichkeit stabiler funktionaler Organisation.',
 'axiom','original',NULL,NULL,NULL,'checked',@revision_id),

('3.93',@sec_337,'Axiom A5 – Reproduzierbare Organisationsmuster',
 '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
 '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
 'Stabile funktionale Organisation eröffnet die Möglichkeit reproduzierbarer Organisationsmuster.',
 'axiom','original',NULL,NULL,NULL,'checked',@revision_id),

('3.94',@sec_338,'Zusammenfassende axiomatische Entwicklungsfolge',
 '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Reproduzierbarkeit}',
 '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Reproduzierbarkeit}',
 'Zusammenfassung der konzeptionellen Reihenfolge der fünf gleichrangigen Axiome.',
 'schema','original',NULL,NULL,NULL,'checked',@revision_id),

('3.95',@sec_339,'Proposition 3.1 – Möglichkeit funktionaler Organisation',
 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}',
 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}',
 'Gemeinsame Gültigkeit der fünf Axiome eröffnet einen theoretischen Rahmen funktionaler Organisation.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id),

('3.96',@sec_339,'Proposition 3.2 – Nichtredundanz der Axiome',
 '\\forall i\\neq j:A_i\\not\\equiv A_j',
 '\\forall i\\neq j:A_i\\not\\equiv A_j',
 'Die fünf Axiome besitzen unterschiedliche theoretische Inhalte.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id),

('3.97',@sec_339,'Proposition 3.3 – Keine Vorwegnahme mathematischer Strukturen',
 '\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}',
 '\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}',
 'Mengen, mathematische Relationen, Funktionen und Zustandsräume werden nicht als primitive Voraussetzungen eingeführt.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id),

('3.98',@sec_339,'Proposition 3.4 – Konstruktive Reihenfolge',
 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5',
 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5',
 'Das Symbol prec kennzeichnet ausschließlich die Reihenfolge der mathematischen Konstruktion in Kapitel 3.4.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id),

('3.99',@sec_339,'Proposition 3.5 – Offenheit der mathematischen Modellierung',
 '\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n',
 '\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n',
 'Die Axiome lassen grundsätzlich mehrere mathematische Realisierungen funktionaler Organisation zu.',
 'theorem','original',NULL,NULL,NULL,'checked',@revision_id);

-- ------------------------------------------------------------
-- 5. Axiome vollständig aktualisieren
-- ------------------------------------------------------------
UPDATE axioms
SET section_id=@sec_333,
    title='Prinzip der funktionalen Unterscheidbarkeit',
    axiom_text='Es existiert die Möglichkeit funktionaler Unterscheidbarkeit.',
    formal_latex='\\exists\\,\\Delta_F',
    word_latex='\\exists\\,\\Delta_F',
    motivation='Minimal notwendige Voraussetzung jeder späteren funktionalen Organisation.',
    independence_note='Keine modelltheoretische Unabhängigkeit behauptet; nur begrifflich eigenständiger Inhalt.',
    consistency_note='Das Axiom führt weder Mengen noch Funktionen, Räume oder Metriken ein.',
    operationalization_note='Mathematische Konstruktion der Differenzstruktur erfolgt erst in Kapitel 3.4.',
    status='review',
    created_revision_id=@revision_id
WHERE axiom_number='A1';

UPDATE axioms
SET section_id=@sec_334,
    title='Prinzip der funktionalen Relationierbarkeit',
    axiom_text='Funktional unterscheidbare Konfigurationen besitzen grundsätzlich die Möglichkeit, funktional miteinander in Beziehung zu treten.',
    formal_latex='\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F',
    word_latex='\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F',
    motivation='Funktionale Organisation erfordert neben Unterscheidbarkeit die Möglichkeit struktureller Zusammenhangsbildung.',
    independence_note='Keine mengentheoretische Relation wird vorausgesetzt.',
    consistency_note='Relationierbarkeit wird ausschließlich als qualitative Möglichkeit eingeführt.',
    operationalization_note='Formale Relationsstrukturen werden erst in Kapitel 3.4 konstruiert.',
    status='review',
    created_revision_id=@revision_id
WHERE axiom_number='A2';

UPDATE axioms
SET section_id=@sec_335,
    title='Prinzip der rekursiven Transformation',
    axiom_text='Funktionale Relationen besitzen grundsätzlich die Möglichkeit, rekursiv transformiert zu werden.',
    formal_latex='\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F',
    word_latex='\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F',
    motivation='Wiederholbarkeit funktionaler Transformationen ist Voraussetzung stabiler Organisationsbildung.',
    independence_note='Keine Folge, Iteration, Zeitordnung oder Operatoralgebra wird vorausgesetzt.',
    consistency_note='Transformation wird vor jeder zeitlichen Interpretation verwendet.',
    operationalization_note='Operatoren und Rekursion werden erst in Kapitel 3.4 formalisiert.',
    status='review',
    created_revision_id=@revision_id
WHERE axiom_number='A3';

UPDATE axioms
SET section_id=@sec_336,
    title='Prinzip stabiler funktionaler Organisation',
    axiom_text='Rekursive funktionale Transformationen besitzen grundsätzlich das Potenzial, stabile Organisationsstrukturen hervorzubringen.',
    formal_latex='\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    word_latex='\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F',
    motivation='Rekursive Transformation allein garantiert noch keine Organisation; deren Möglichkeit muss gesondert angenommen werden.',
    independence_note='Kein Zustandsraum, Attraktor oder Stabilitätsmaß wird vorausgesetzt.',
    consistency_note='Organisation bleibt ein qualitativer primitiver Begriff.',
    operationalization_note='Mathematische Organisationsstrukturen werden erst in Kapitel 3.4 konstruiert.',
    status='review',
    created_revision_id=@revision_id
WHERE axiom_number='A4';

UPDATE axioms
SET section_id=@sec_337,
    title='Prinzip reproduzierbarer Organisationsmuster',
    axiom_text='Stabile funktionale Organisationsstrukturen besitzen grundsätzlich das Potenzial, reproduzierbare Organisationsmuster auszubilden.',
    formal_latex='\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    word_latex='\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F',
    motivation='Allgemeine wissenschaftliche Gesetzmäßigkeiten setzen prinzipiell reproduzierbare Organisationsmuster voraus.',
    independence_note='Kohärenz, Konvergenz und metrische Stabilität werden noch nicht vorausgesetzt.',
    consistency_note='Reproduzierbarkeit bedeutet nicht notwendigerweise Identität.',
    operationalization_note='Funktionale Äquivalenz und Kohärenz werden erst in Kapitel 3.4 formal definiert.',
    status='review',
    created_revision_id=@revision_id
WHERE axiom_number='A5';

-- ------------------------------------------------------------
-- 6. Propositionen vollständig aktualisieren
-- ------------------------------------------------------------
UPDATE propositions
SET section_id=@sec_339,
    title='Möglichkeit funktionaler Organisation',
    statement_text='Unter der gemeinsamen Annahme der Axiome A1 bis A5 existiert ein theoretischer Rahmen, innerhalb dessen funktionale Organisation beschrieben werden kann.',
    statement_latex='A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}',
    word_latex='A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}',
    logical_derivation='Erst die gemeinsame Gültigkeit aller fünf qualitativen Organisationsprinzipien eröffnet den vollständigen theoretischen Möglichkeitsrahmen.',
    based_on_axioms='A1,A2,A3,A4,A5',
    status='review',
    created_revision_id=@revision_id
WHERE proposition_number='Prop. 3.1';

UPDATE propositions
SET section_id=@sec_339,
    title='Nichtredundanz der Axiome',
    statement_text='Die fünf Axiome beschreiben unterschiedliche theoretische Eigenschaften funktionaler Organisation.',
    statement_latex='\\forall i\\neq j:A_i\\not\\equiv A_j',
    word_latex='\\forall i\\neq j:A_i\\not\\equiv A_j',
    logical_derivation='Die Proposition behauptet keine modelltheoretische Unabhängigkeit, sondern lediglich begriffliche Nichtgleichheit.',
    based_on_axioms='A1,A2,A3,A4,A5',
    status='review',
    created_revision_id=@revision_id
WHERE proposition_number='Prop. 3.2';

UPDATE propositions
SET section_id=@sec_339,
    title='Keine Vorwegnahme mathematischer Strukturen',
    statement_text='Die fünf Axiome setzen weder Mengen, mathematische Relationen, Funktionen noch Zustandsräume als primitive mathematische Objekte voraus.',
    statement_latex='\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}',
    word_latex='\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}',
    logical_derivation='Die Axiome formulieren ausschließlich qualitative Organisationsprinzipien.',
    based_on_axioms='A1,A2,A3,A4,A5',
    status='review',
    created_revision_id=@revision_id
WHERE proposition_number='Prop. 3.3';

UPDATE propositions
SET section_id=@sec_339,
    title='Konstruktive Reihenfolge',
    statement_text='Die Axiome bestimmen die Reihenfolge, in der die mathematische Konstruktion in Kapitel 3.4 vorgenommen wird.',
    statement_latex='A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5',
    word_latex='A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5',
    logical_derivation='Das Relationszeichen prec kennzeichnet keine axiomatische Ableitung, sondern ausschließlich eine methodische Konstruktionsfolge.',
    based_on_axioms='A1,A2,A3,A4,A5',
    status='review',
    created_revision_id=@revision_id
WHERE proposition_number='Prop. 3.4';

UPDATE propositions
SET section_id=@sec_339,
    title='Offenheit der mathematischen Modellierung',
    statement_text='Aus den Axiomen folgt zunächst keine eindeutig festgelegte mathematische Repräsentation.',
    statement_latex='\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n',
    word_latex='\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n',
    logical_derivation='Mehrere mathematische Modelle können grundsätzlich dieselben qualitativen Organisationsprinzipien realisieren.',
    based_on_axioms='A1,A2,A3,A4,A5',
    status='review',
    created_revision_id=@revision_id
WHERE proposition_number='Prop. 3.5';

-- Proposition-Abhängigkeiten entsprechend neu aufbauen
DELETE FROM proposition_dependencies
WHERE proposition_id IN (
    SELECT proposition_id
    FROM propositions
    WHERE proposition_number LIKE 'Prop. 3.%'
);

INSERT INTO proposition_dependencies
(proposition_id,axiom_id,assumption_id,dependency_type,note)
SELECT p.proposition_id,a.axiom_id,NULL,'uses',
       CONCAT(p.proposition_number,' verwendet ',a.axiom_number,'.')
FROM propositions p
JOIN axioms a ON a.axiom_number IN ('A1','A2','A3','A4','A5')
WHERE p.proposition_number IN ('Prop. 3.1','Prop. 3.2','Prop. 3.3','Prop. 3.4','Prop. 3.5');

-- ------------------------------------------------------------
-- 7. Symbolverzeichnis für die Neufassung von 3.3
-- ------------------------------------------------------------
INSERT INTO symbols
(symbol_latex,symbol_word_latex,symbol_name,definition_text,scope_type,
 first_section_id,first_equation_id,unit_text,domain_text,codomain_text,
 is_vector,is_matrix,is_operator,notes,validation_status,created_revision_id)
VALUES
('\\Delta_F','\\Delta_F','funktionale Unterscheidbarkeit',
 'Prämathematisches Symbol für die Möglichkeit funktionaler Unterscheidbarkeit.',
 'chapter',@sec_333,(SELECT equation_id FROM equations WHERE equation_number='3.89'),
 NULL,NULL,NULL,0,0,0,
 'Noch keine mathematische Funktion; Formalisierung erst in Kapitel 3.4.',
 'checked',@revision_id),

('\\mathcal{R}_F','\\mathcal{R}_F','funktionale Relationierbarkeit',
 'Prämathematisches Symbol für die Möglichkeit funktionaler Zusammenhangsbildung.',
 'chapter',@sec_334,(SELECT equation_id FROM equations WHERE equation_number='3.90'),
 NULL,NULL,NULL,0,0,0,
 'Noch keine mengentheoretische Relation.',
 'checked',@revision_id),

('\\mathcal{T}_F','\\mathcal{T}_F','rekursive funktionale Transformation',
 'Prämathematisches Symbol für die Möglichkeit rekursiver Transformation.',
 'chapter',@sec_335,(SELECT equation_id FROM equations WHERE equation_number='3.91'),
 NULL,NULL,NULL,0,0,0,
 'Noch kein mathematischer Transformationsoperator.',
 'checked',@revision_id),

('\\mathcal{O}_F','\\mathcal{O}_F','stabile funktionale Organisation',
 'Prämathematisches Symbol für die Möglichkeit stabiler funktionaler Organisation.',
 'chapter',@sec_336,(SELECT equation_id FROM equations WHERE equation_number='3.92'),
 NULL,NULL,NULL,0,0,0,
 'In Kapitel 3.3 ausdrücklich kein Operator.',
 'checked',@revision_id),

('\\mathcal{P}_F','\\mathcal{P}_F','reproduzierbare Organisationsmuster',
 'Prämathematisches Symbol für die Möglichkeit reproduzierbarer Organisationsmuster.',
 'chapter',@sec_337,(SELECT equation_id FROM equations WHERE equation_number='3.93'),
 NULL,NULL,NULL,0,0,0,
 'Mathematische Äquivalenz und Kohärenz werden erst in Kapitel 3.4 definiert.',
 'checked',@revision_id),

('\\mathcal{F}','\\mathcal{F}','funktionale Organisation',
 'Konzeptionelle Bezeichnung des durch alle fünf Axiome eröffneten theoretischen Rahmens.',
 'chapter',@sec_339,(SELECT equation_id FROM equations WHERE equation_number='3.95'),
 NULL,NULL,NULL,0,0,0,
 'Noch keine festgelegte mathematische Struktur.',
 'checked',@revision_id),

('\\Diamond','\\Diamond','Möglichkeitsoperator',
 'Modallogischer Operator zur Kennzeichnung prinzipieller Möglichkeit.',
 'chapter',@sec_334,(SELECT equation_id FROM equations WHERE equation_number='3.90'),
 NULL,NULL,NULL,0,0,1,
 'Wird in den Axiomen A2 bis A5 verwendet.',
 'checked',@revision_id),

('\\prec','\\prec','methodische Konstruktionsfolge',
 'Kennzeichnet ausschließlich die Reihenfolge der Konstruktion in Kapitel 3.4.',
 'chapter',@sec_339,(SELECT equation_id FROM equations WHERE equation_number='3.98'),
 NULL,NULL,NULL,0,0,0,
 'Keine mathematische Ordnungsrelation.',
 'checked',@revision_id);

-- ------------------------------------------------------------
-- 8. Literaturverwendungen neu zuordnen
-- Keine neue Literatur; Nummern [1] bis [52] bleiben unverändert.
-- ------------------------------------------------------------
DELETE su
FROM source_usage su
JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE ds.section_code LIKE '3.3%';

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
SELECT source_id,@sec_330,'historical_context',
       'Axiomatische Methode und Abgrenzung gegenüber klassischen geometrischen und mengentheoretischen Ausgangsstrukturen.',
       '3.3.0',FALSE,FALSE,
       'Wiederverwendung einer bereits nummerierten Masterquelle.'
FROM sources
WHERE citation_number IN (7,8,24);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
SELECT source_id,@sec_331,'background',
       'Einordnung primitiver Begriffe innerhalb klassischer axiomatischer Methodik.',
       '3.3.1',FALSE,FALSE,
       'Wiederverwendung einer bereits nummerierten Masterquelle.'
FROM sources
WHERE citation_number IN (7,8,24);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes)
SELECT source_id,@sec_332,'background',
       'Wissenschaftstheoretische Begründung minimaler primitiver Begriffe.',
       '3.3.2',FALSE,FALSE,
       'Wiederverwendung einer bereits nummerierten Masterquelle.'
FROM sources
WHERE citation_number IN (8,18,24);

-- ------------------------------------------------------------
-- 9. Repository-Zähler und Validierung
-- ------------------------------------------------------------
INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('next_citation_number','53'),
('next_equation_number','3.100'),
('last_completed_section','3.3'),
('last_repository_revision','RKB-2026-07-12-K3.3-NEUFASSUNG')
ON DUPLICATE KEY UPDATE
 counter_value=VALUES(counter_value),
 updated_at=NOW();

DELETE FROM repository_validation_results
WHERE revision_id=@revision_id;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_NEW_EQUATION_COUNT',
       IF(COUNT(*)=13,'passed','failed'),
       '13',CAST(COUNT(*) AS CHAR),
       'Anzahl der Gleichungen (3.87) bis (3.99).'
FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 87 AND 99;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_OBSOLETE_EQUATIONS',
       IF(COUNT(*)=0,'passed','failed'),
       '0',CAST(COUNT(*) AS CHAR),
       'Alte Gleichungen (3.100) bis (3.115) dürfen nach der Neufassung nicht mehr vorhanden sein.'
FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 100 AND 115;

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_AXIOM_COUNT',
       IF(COUNT(*)=5,'passed','failed'),
       '5',CAST(COUNT(*) AS CHAR),
       'Anzahl der aktualisierten Axiome A1 bis A5.'
FROM axioms
WHERE axiom_number IN ('A1','A2','A3','A4','A5');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_PROPOSITION_COUNT',
       IF(COUNT(*)=5,'passed','failed'),
       '5',CAST(COUNT(*) AS CHAR),
       'Anzahl der aktualisierten Propositionen.'
FROM propositions
WHERE proposition_number IN ('Prop. 3.1','Prop. 3.2','Prop. 3.3','Prop. 3.4','Prop. 3.5');

INSERT INTO repository_validation_results
(revision_id,validation_code,validation_status,expected_value,actual_value,validation_message)
SELECT @revision_id,'K3_3_NEW_SOURCE_COUNT',
       IF(COUNT(*)=0,'passed','warning'),
       '0',CAST(COUNT(*) AS CHAR),
       'Die Neufassung von Kapitel 3.3 führt keine neue Literaturquelle ein.'
FROM sources
WHERE first_citation_section_code LIKE '3.3%';

-- ------------------------------------------------------------
-- 10. Änderungsprotokoll
-- ------------------------------------------------------------
DELETE FROM section_change_log
WHERE revision_id=@revision_id;

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
VALUES
(@revision_id,@section_33,'rewritten','chapter','3.3',
 'Kapitel 3.3 vollständig als prämathematisches Axiomenkapitel neu strukturiert.',
 'Mathematische Axiome mit vorweggenommenen Mengen-, Operator-, Zustandsraum- und Kohärenzstrukturen.',
 'Axiomatische Grundlagen mit primitiven Begriffen und qualitativen Organisationsprinzipien.'),

(@revision_id,@section_33,'renumbered','equations','(3.87)–(3.99)',
 'Alte 29 Gleichungen durch 13 neue Gleichungen ersetzt; nächste freie Gleichung ist (3.100).',
 '(3.87)–(3.115)',
 '(3.87)–(3.99)'),

(@revision_id,@section_33,'axiom_added','axioms','A1–A5',
 'Fünf Axiome in ihrer abgeschwächten, nichtzirkulären Neufassung registriert.',
 NULL,NULL),

(@revision_id,@sec_339,'proposition_added','propositions','Prop. 3.1–Prop. 3.5',
 'Fünf logische Propositionen an die Neufassung angepasst.',
 NULL,NULL),

(@revision_id,@section_33,'source_reused','literature','[7], [8], [18], [24]',
 'Bestehende Literatur wird wiederverwendet; keine neue Literaturnummer erforderlich.',
 NULL,NULL),

(@revision_id,@section_33,'symbol_added','symbols','Symbolverzeichnis 3.3',
 'Prämathematische Symbole und ihre explizite Statusabgrenzung registriert.',
 NULL,NULL),

(@revision_id,@section_33,'status_changed','section','3.3',
 'Kapitel 3.3 verbleibt bis zur Endprüfung auf Status review.',
 NULL,'review');

COMMIT;

-- ------------------------------------------------------------
-- 11. Kontrollausgaben
-- ------------------------------------------------------------
SELECT section_code,title,status
FROM dissertation_sections
WHERE section_code LIKE '3.3%'
ORDER BY section_order;

SELECT equation_number,title,section_id,word_latex
FROM equations
WHERE equation_number LIKE '3.%'
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 87 AND 115
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT axiom_number,title,formal_latex,status
FROM axioms
WHERE axiom_number IN ('A1','A2','A3','A4','A5')
ORDER BY axiom_number;

SELECT proposition_number,title,statement_latex,status
FROM propositions
WHERE proposition_number LIKE 'Prop. 3.%'
ORDER BY proposition_number;

SELECT counter_key,counter_value
FROM repository_counters
ORDER BY counter_key;

SELECT validation_code,validation_status,expected_value,actual_value,validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
