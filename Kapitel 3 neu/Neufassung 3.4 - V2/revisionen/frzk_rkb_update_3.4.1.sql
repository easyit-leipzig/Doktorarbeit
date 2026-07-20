/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.1
   Kapitel 3.4: Mathematische Rekonstruktion funktionaler Organisation
   Abschnitt 3.4.1: Funktionaler Zustand

   Voraussetzung:
   - Datenbankstand nach erfolgreichem Import von frzk_rkb_update_3.4.0.sql
   - letzte Gleichung: (3.643)
   - letzte Quelle: [109]

   Neu registriert:
   - Abschnitt 3.4.1
   - Gleichungen (3.644) bis (3.654)
   - Definitionen 3.4.1 und 3.4.2
   - Lemma 3.4.1
   - Satz 3.4.1
   - Korollar 3.4.1
   - zugehörige Beweise
   - Wiederverwendung der Quellen [6], [72] und [108]
   - Gleichungssymbole, Symbolregister, Quellenverwendungen,
     Änderungsprotokoll und Repository-Zähler

   Eigenschaften:
   - idempotent
   - schema-konform zu frzk_rkb_ende_3.3(4).sql
   - keine fest vergebenen Primärschlüssel
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.1-V1';
SET @revision_date := NOW();

/* ---------------------------------------------------------------------
   1. Vorgängerrevision und neue Revision
   --------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.4.0-V1'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    @revision_code,
    @revision_date,
    'section',
    '3.4.1',
    '1.0',
    'Rekonstruktion des funktionalen Zustands als kleinster vollständiger Einheit funktionaler Organisation. Registriert werden die Gleichungen (3.644) bis (3.654), zwei Definitionen, ein Lemma, ein Satz, ein Korollar, die zugehörigen Beweise sowie die Wiederverwendung der Quellen [6], [72] und [108].',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions WHERE revision_code = @revision_code
);

SET @revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code = @revision_code LIMIT 1
);

/* ---------------------------------------------------------------------
   2. Abschnitt 3.4.1 anlegen
   --------------------------------------------------------------------- */

SET @chapter_34_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code = '3.4' LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_34_id,
    '3.4.1',
    'Funktionaler Zustand',
    3,
    3.4010,
    'final',
    1,
    'Rekonstruktion des funktionalen Zustands aus funktionalen Gehalten, Relationen und Operationen; Herleitung der Zustandsmenge, Identitätsbedingung, Unterscheidbarkeit und Minimalität der Zustandsdarstellung.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code = '3.4.1'
);

SET @section_id :=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code = '3.4.1' LIMIT 1
);

/* ---------------------------------------------------------------------
   3. Wiederverwendete Quellen bestimmen
   --------------------------------------------------------------------- */

SET @source_halmos_id :=
(
    SELECT source_id FROM sources WHERE citation_number = 6 LIMIT 1
);
SET @source_bourbaki_id :=
(
    SELECT source_id FROM sources WHERE citation_number = 72 LIMIT 1
);
SET @source_maclane_id :=
(
    SELECT source_id FROM sources WHERE citation_number = 108 LIMIT 1
);

/* ---------------------------------------------------------------------
   4. Gleichungen (3.644) bis (3.654)
   --------------------------------------------------------------------- */

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.644', @section_id, 'Existenzbedingung eines funktionalen Zustands',
'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\exists z_F',
'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\exists z_F',
'Aus hinreichender funktionaler Kohärenz folgt nach Axiom A6 die Existenz mindestens eines funktionalen Zustands.',
'axiom','original',NULL,
'Übernahme und Rekonstruktionsauslegung der Zustandsbildungsforderung aus Axiom A6.',
'Axiom A6 und eine funktionale Organisation \mathcal{S}.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.644');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.645', @section_id, 'Elementare funktionale Konfiguration',
'\chi_F(\mathcal{S})=\left(\mathcal{F}_{\mathcal{S}},\mathcal{R}_{\mathcal{S}},\mathcal{O}_{\mathcal{S}}\right)',
'\chi_F(\mathcal{S})=\left(\mathcal{F}_{\mathcal{S}},\mathcal{R}_{\mathcal{S}},\mathcal{O}_{\mathcal{S}}\right)',
'Eine funktionale Konfiguration wird als geordnetes Tripel aus funktionalen Gehalten, Relationen und Operationen dargestellt.',
'definition','original',NULL,
'Eigene strukturelle Rekonstruktion aus den in Kapitel 3.3 axiomatisch bestimmten Komponenten.',
'Geltung der Axiome zu funktionalem Gehalt, Relation und Operation.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.645');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.646', @section_id, 'Zulässigkeitsfunktion funktionaler Konfigurationen',
'\Lambda_F:\chi_F\longrightarrow\{0,1\}',
'\Lambda_F:\chi_F\longrightarrow\{0,1\}',
'Die Zulässigkeitsfunktion bildet eine funktionale Konfiguration auf den Wahrheitswert ihrer axiomatischen Verträglichkeit ab.',
'definition','original',NULL,
'Eigene formale Prüffunktion zur Trennung zulässiger und unzulässiger Konfigurationen.',
'Eine formal darstellbare funktionale Konfiguration \chi_F.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.646');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.647', @section_id, 'Definition des funktionalen Zustands',
'z_F:=\chi_F(\mathcal{S})\quad\text{mit}\quad\Lambda_F\left(\chi_F(\mathcal{S})\right)=1',
'z_F:=\chi_F(\mathcal{S})\quad\text{mit}\quad\Lambda_F\left(\chi_F(\mathcal{S})\right)=1',
'Ein funktionaler Zustand ist eine bestimmte und axiomatisch zulässige funktionale Konfiguration.',
'definition','original',NULL,
'Eigene Definition auf Grundlage der Gleichungen (3.645) und (3.646).',
'Gegeben sind eine Organisation \mathcal{S}, ihre Konfiguration und die Zulässigkeitsfunktion.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.647');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.648', @section_id, 'Funktionale Zustandsmenge',
'\Omega_F(\mathcal{S})=\left\{\chi_F(\mathcal{S})\middle|\Lambda_F\left(\chi_F(\mathcal{S})\right)=1\right\}',
'\Omega_F(\mathcal{S})=\left\{\chi_F(\mathcal{S})\middle|\Lambda_F\left(\chi_F(\mathcal{S})\right)=1\right\}',
'Die Zustandsmenge enthält genau die axiomatisch zulässigen funktionalen Konfigurationen der Organisation.',
'definition','original',NULL,
'Eigene mengenbildende Rekonstruktion aus der Zulässigkeitsbedingung.',
'Zulässigkeitsfunktion gemäß Gleichung (3.646).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.648');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.649', @section_id, 'Zugehörigkeit eines Zustands zur Zustandsmenge',
'z_F\in\Omega_F(\mathcal{S})',
'z_F\in\Omega_F(\mathcal{S})',
'Jeder axiomatisch zulässige funktionale Zustand gehört zur funktionalen Zustandsmenge der Organisation.',
'derived','original',NULL,
'Unmittelbare Folge aus den Gleichungen (3.647) und (3.648).',
'Definition des funktionalen Zustands und der Zustandsmenge.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.649');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.650', @section_id, 'Kohärenzvoraussetzung des Lemmas',
'C_F(\mathcal{S})\geq C_{\mathrm{krit}}',
'C_F(\mathcal{S})\geq C_{\mathrm{krit}}',
'Voraussetzung für die Existenz mindestens eines funktionalen Zustands.',
'lemma','original',NULL,
'Wiederaufnahme der Bedingung aus Gleichung (3.644) als Voraussetzung des Lemmas 3.4.1.',
'Axiom A6.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.650');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.651', @section_id, 'Nichtleere funktionale Zustandsmenge',
'\Omega_F(\mathcal{S})\neq\varnothing',
'\Omega_F(\mathcal{S})\neq\varnothing',
'Eine hinreichend kohärente funktionale Organisation besitzt eine nichtleere Zustandsmenge.',
'lemma','original',NULL,
'Folgt aus Axiom A6, Definition 3.4.1 und Gleichung (3.649).',
'Kohärenzbedingung gemäß Gleichung (3.650).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.651');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.652', @section_id, 'Komponenten zweier funktionaler Zustände',
'z_F^{(i)}=\left(\mathcal{F}_{\mathcal{S}}^{(i)},\mathcal{R}_{\mathcal{S}}^{(i)},\mathcal{O}_{\mathcal{S}}^{(i)}\right)\quad\text{und}\quad z_F^{(j)}=\left(\mathcal{F}_{\mathcal{S}}^{(j)},\mathcal{R}_{\mathcal{S}}^{(j)},\mathcal{O}_{\mathcal{S}}^{(j)}\right)',
'z_F^{(i)}=\left(\mathcal{F}_{\mathcal{S}}^{(i)},\mathcal{R}_{\mathcal{S}}^{(i)},\mathcal{O}_{\mathcal{S}}^{(i)}\right)\quad\text{und}\quad z_F^{(j)}=\left(\mathcal{F}_{\mathcal{S}}^{(j)},\mathcal{R}_{\mathcal{S}}^{(j)},\mathcal{O}_{\mathcal{S}}^{(j)}\right)',
'Komponentendarstellung zweier funktionaler Zustände zur Bestimmung ihrer Identität.',
'definition','original',NULL,
'Konkretisierung der Zustandsdarstellung aus Gleichung (3.645).',
'Zwei zulässige Zustände derselben funktionalen Organisation.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.652');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.653', @section_id, 'Identität funktionaler Zustände',
'z_F^{(i)}=z_F^{(j)}\Longleftrightarrow\left(\mathcal{F}_{\mathcal{S}}^{(i)}=\mathcal{F}_{\mathcal{S}}^{(j)}\right)\land\left(\mathcal{R}_{\mathcal{S}}^{(i)}=\mathcal{R}_{\mathcal{S}}^{(j)}\right)\land\left(\mathcal{O}_{\mathcal{S}}^{(i)}=\mathcal{O}_{\mathcal{S}}^{(j)}\right)',
'z_F^{(i)}=z_F^{(j)}\Longleftrightarrow\left(\mathcal{F}_{\mathcal{S}}^{(i)}=\mathcal{F}_{\mathcal{S}}^{(j)}\right)\land\left(\mathcal{R}_{\mathcal{S}}^{(i)}=\mathcal{R}_{\mathcal{S}}^{(j)}\right)\land\left(\mathcal{O}_{\mathcal{S}}^{(i)}=\mathcal{O}_{\mathcal{S}}^{(j)}\right)',
'Zwei funktionale Zustände sind genau dann identisch, wenn alle drei Zustandskomponenten übereinstimmen.',
'definition','original',NULL,
'Eigene komponentenweise Identitätsbedingung für funktionale Zustände.',
'Komponentendarstellung gemäß Gleichung (3.652).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.653');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.654', @section_id, 'Unterscheidbarkeit funktionaler Zustände',
'z_F^{(i)}\neq z_F^{(j)}\Longleftrightarrow\left(\mathcal{F}_{\mathcal{S}}^{(i)}\neq\mathcal{F}_{\mathcal{S}}^{(j)}\right)\lor\left(\mathcal{R}_{\mathcal{S}}^{(i)}\neq\mathcal{R}_{\mathcal{S}}^{(j)}\right)\lor\left(\mathcal{O}_{\mathcal{S}}^{(i)}\neq\mathcal{O}_{\mathcal{S}}^{(j)}\right)',
'z_F^{(i)}\neq z_F^{(j)}\Longleftrightarrow\left(\mathcal{F}_{\mathcal{S}}^{(i)}\neq\mathcal{F}_{\mathcal{S}}^{(j)}\right)\lor\left(\mathcal{R}_{\mathcal{S}}^{(i)}\neq\mathcal{R}_{\mathcal{S}}^{(j)}\right)\lor\left(\mathcal{O}_{\mathcal{S}}^{(i)}\neq\mathcal{O}_{\mathcal{S}}^{(j)}\right)',
'Zwei funktionale Zustände sind genau dann verschieden, wenn sich mindestens eine ihrer Komponenten unterscheidet.',
'theorem','original',NULL,
'Logische Negation der Identitätsbedingung aus Gleichung (3.653) unter Anwendung der De-Morgan-Regeln.',
'Definition 3.4.2.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.654');

/* Gleichungs-IDs */
SET @eq_3644 := (SELECT equation_id FROM equations WHERE equation_number='3.644' LIMIT 1);
SET @eq_3645 := (SELECT equation_id FROM equations WHERE equation_number='3.645' LIMIT 1);
SET @eq_3646 := (SELECT equation_id FROM equations WHERE equation_number='3.646' LIMIT 1);
SET @eq_3647 := (SELECT equation_id FROM equations WHERE equation_number='3.647' LIMIT 1);
SET @eq_3648 := (SELECT equation_id FROM equations WHERE equation_number='3.648' LIMIT 1);
SET @eq_3649 := (SELECT equation_id FROM equations WHERE equation_number='3.649' LIMIT 1);
SET @eq_3650 := (SELECT equation_id FROM equations WHERE equation_number='3.650' LIMIT 1);
SET @eq_3651 := (SELECT equation_id FROM equations WHERE equation_number='3.651' LIMIT 1);
SET @eq_3652 := (SELECT equation_id FROM equations WHERE equation_number='3.652' LIMIT 1);
SET @eq_3653 := (SELECT equation_id FROM equations WHERE equation_number='3.653' LIMIT 1);
SET @eq_3654 := (SELECT equation_id FROM equations WHERE equation_number='3.654' LIMIT 1);

/* ---------------------------------------------------------------------
   5. Definitionen
   --------------------------------------------------------------------- */

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex,
 word_latex, provenance, source_id, assumptions, notes,
 validation_status, created_revision_id)
SELECT
    '3.4.1', @section_id, 'Funktionaler Zustand',
    'Ein funktionaler Zustand z_F einer funktionalen Organisation S ist eine bestimmte, axiomatisch zulässige Konfiguration ihrer funktionalen Gehalte, Relationen und Operationen.',
    'z_F:=\chi_F(\mathcal{S})\quad\text{mit}\quad\Lambda_F\left(\chi_F(\mathcal{S})\right)=1',
    'z_F:=\chi_F(\mathcal{S})\quad\text{mit}\quad\Lambda_F\left(\chi_F(\mathcal{S})\right)=1',
    'original', NULL,
    'Axiome zu funktionalem Gehalt, Relation, Operation und Zustandsbildung; Gleichungen (3.645) und (3.646).',
    'Zentrale eigene Definition des ersten mathematisch rekonstruierten Grundobjekts des FRZK.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.1');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex,
 word_latex, provenance, source_id, assumptions, notes,
 validation_status, created_revision_id)
SELECT
    '3.4.2', @section_id, 'Identität funktionaler Zustände',
    'Zwei funktionale Zustände sind genau dann identisch, wenn ihre funktionalen Gehalte, funktionalen Relationen und funktionalen Operationen jeweils übereinstimmen.',
    'z_F^{(i)}=z_F^{(j)}\Longleftrightarrow(\mathcal{F}_{\mathcal{S}}^{(i)}=\mathcal{F}_{\mathcal{S}}^{(j)})\land(\mathcal{R}_{\mathcal{S}}^{(i)}=\mathcal{R}_{\mathcal{S}}^{(j)})\land(\mathcal{O}_{\mathcal{S}}^{(i)}=\mathcal{O}_{\mathcal{S}}^{(j)})',
    'z_F^{(i)}=z_F^{(j)}\Longleftrightarrow(\mathcal{F}_{\mathcal{S}}^{(i)}=\mathcal{F}_{\mathcal{S}}^{(j)})\land(\mathcal{R}_{\mathcal{S}}^{(i)}=\mathcal{R}_{\mathcal{S}}^{(j)})\land(\mathcal{O}_{\mathcal{S}}^{(i)}=\mathcal{O}_{\mathcal{S}}^{(j)})',
    'original', NULL,
    'Definition 3.4.1 und Komponentendarstellung aus Gleichung (3.652).',
    'Komponentenweise Identitätsbedingung für funktionale Zustände.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.2');

/* ---------------------------------------------------------------------
   6. Lemma, Satz und Korollar
   --------------------------------------------------------------------- */

INSERT INTO lemmas
(lemma_number, section_id, title, statement_text, statement_latex,
 word_latex, provenance, source_id, assumptions, validation_status,
 created_revision_id)
SELECT
    '3.4.1', @section_id, 'Nichtleere Zustandsmenge',
    'Erfüllt eine funktionale Organisation S die Bedingung C_F(S) >= C_krit, dann ist ihre funktionale Zustandsmenge nicht leer.',
    'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\Omega_F(\mathcal{S})\neq\varnothing',
    'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Longrightarrow\Omega_F(\mathcal{S})\neq\varnothing',
    'original', NULL,
    'Axiom A6, Definition 3.4.1 und Gleichung (3.649).',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='3.4.1');

SET @lemma_id := (SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.1' LIMIT 1);

INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex,
 word_latex, provenance, source_id, assumptions, validation_status,
 created_revision_id)
SELECT
    '3.4.1', @section_id, 'Unterscheidbarkeit funktionaler Zustände',
    'Für zwei zulässige funktionale Zustände gilt: Sie sind genau dann verschieden, wenn sich mindestens eine der drei Komponenten funktionaler Gehalt, funktionale Relation oder funktionale Operation unterscheidet.',
    'z_F^{(i)}\neq z_F^{(j)}\Longleftrightarrow(\mathcal{F}_{\mathcal{S}}^{(i)}\neq\mathcal{F}_{\mathcal{S}}^{(j)})\lor(\mathcal{R}_{\mathcal{S}}^{(i)}\neq\mathcal{R}_{\mathcal{S}}^{(j)})\lor(\mathcal{O}_{\mathcal{S}}^{(i)}\neq\mathcal{O}_{\mathcal{S}}^{(j)})',
    'z_F^{(i)}\neq z_F^{(j)}\Longleftrightarrow(\mathcal{F}_{\mathcal{S}}^{(i)}\neq\mathcal{F}_{\mathcal{S}}^{(j)})\lor(\mathcal{R}_{\mathcal{S}}^{(i)}\neq\mathcal{R}_{\mathcal{S}}^{(j)})\lor(\mathcal{O}_{\mathcal{S}}^{(i)}\neq\mathcal{O}_{\mathcal{S}}^{(j)})',
    'original', NULL,
    'Definition 3.4.2 und klassische De-Morgan-Regeln.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.1');

SET @theorem_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.1' LIMIT 1);

INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex,
 word_latex, parent_theorem_id, parent_lemma_id, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    '3.4.1', @section_id, 'Minimalität der Zustandsdarstellung',
    'Eine Darstellung, die eine der Komponenten funktionaler Gehalt, funktionale Relation oder funktionale Operation nicht berücksichtigt, ist im Allgemeinen nicht hinreichend, um sämtliche funktionalen Zustände eindeutig zu unterscheiden.',
    NULL, NULL,
    @theorem_id, NULL,
    'original', NULL,
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.1');

SET @corollary_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.1' LIMIT 1);

/* ---------------------------------------------------------------------
   7. Beweise
   --------------------------------------------------------------------- */

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    'B-3.4.1-L1', @section_id, NULL, @lemma_id, NULL,
    'Beweis zu Lemma 3.4.1',
    'Nach Axiom A6 folgt aus der Kohärenzbedingung die Existenz mindestens eines funktionalen Zustands z_F. Nach Definition 3.4.1 ist jeder funktionale Zustand eine zulässige Konfiguration und gehört daher zur Menge Omega_F(S). Diese Menge enthält folglich mindestens ein Element und ist nicht leer.',
    'C_F(\mathcal{S})\geq C_{\mathrm{krit}}\Rightarrow\exists z_F\in\Omega_F(\mathcal{S})\Rightarrow\Omega_F(\mathcal{S})\neq\varnothing',
    'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.1-L1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    'B-3.4.1-S1', @section_id, @theorem_id, NULL, NULL,
    'Beweis zu Satz 3.4.1',
    'Nach Definition 3.4.2 sind zwei funktionale Zustände genau dann identisch, wenn alle drei Komponenten paarweise übereinstimmen. Die Negation dieser Konjunktion ist nach den De-Morgan-Regeln genau dann erfüllt, wenn mindestens eine der drei Komponenten nicht übereinstimmt. Damit folgt die behauptete Äquivalenz.',
    '\neg(A\land B\land C)\Longleftrightarrow(\neg A\lor\neg B\lor\neg C)',
    'equivalence','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.1-S1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    'B-3.4.1-K1', @section_id, NULL, NULL, @corollary_id,
    'Begründung zu Korollar 3.4.1',
    'Nach Satz 3.4.1 genügt bereits die Abweichung einer einzigen Zustandskomponente, damit zwei Zustände verschieden sind. Wird eine Komponente aus der Darstellung entfernt, kann eine Abweichung in genau dieser Komponente nicht mehr erkannt werden. Die reduzierte Darstellung ist daher im Allgemeinen nicht injektiv bezüglich der Menge funktionaler Zustände.',
    NULL,
    'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.1-K1');

/* ---------------------------------------------------------------------
   8. Gleichungssymbole – zentrale Erst- und Wiederverwendungen
   --------------------------------------------------------------------- */

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3644,'C_F(\mathcal{S})','funktionale Kohärenz der Organisation','Kohärenzwert der betrachteten funktionalen Organisation.',NULL,'reeller oder normierter Kohärenzwert',1
WHERE @eq_3644 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3644 AND symbol_latex='C_F(\mathcal{S})');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3644,'C_{\mathrm{krit}}','kritischer Kohärenzwert','Schwellenwert, ab dem nach Axiom A6 Zustandsbildung möglich ist.',NULL,'Kohärenzwertebereich',2
WHERE @eq_3644 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3644 AND symbol_latex='C_{\mathrm{krit}}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3644,'z_F','funktionaler Zustand','Bestimmte axiomatisch zulässige funktionale Konfiguration.',NULL,'\Omega_F(\mathcal{S})',3
WHERE @eq_3644 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3644 AND symbol_latex='z_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3645,'\chi_F(\mathcal{S})','funktionale Konfiguration','Geordnetes Tripel der funktionalen Gehalte, Relationen und Operationen einer Organisation.',NULL,'Menge formal darstellbarer Konfigurationen',1
WHERE @eq_3645 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3645 AND symbol_latex='\chi_F(\mathcal{S})');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3645,'\mathcal{F}_{\mathcal{S}}','funktionale Gehalte','In der Organisation wirksame funktionale Gehalte.',NULL,'funktionale Gehaltsmenge',2
WHERE @eq_3645 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3645 AND symbol_latex='\mathcal{F}_{\mathcal{S}}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3645,'\mathcal{R}_{\mathcal{S}}','funktionale Relationen','Zwischen den funktionalen Gehalten bestehende Relationen.',NULL,'Relationsmenge',3
WHERE @eq_3645 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3645 AND symbol_latex='\mathcal{R}_{\mathcal{S}}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3645,'\mathcal{O}_{\mathcal{S}}','funktionale Operationen','In der Konfiguration wirksame oder verfügbare funktionale Operationen.',NULL,'Operationsmenge',4
WHERE @eq_3645 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3645 AND symbol_latex='\mathcal{O}_{\mathcal{S}}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3646,'\Lambda_F','Zulässigkeitsfunktion','Prüffunktion für die axiomatische Verträglichkeit einer funktionalen Konfiguration.',NULL,'Konfigurationen nach {0,1}',1
WHERE @eq_3646 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3646 AND symbol_latex='\Lambda_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3648,'\Omega_F(\mathcal{S})','funktionale Zustandsmenge','Menge aller axiomatisch zulässigen funktionalen Konfigurationen der Organisation.',NULL,'Potenz- oder Konfigurationsmenge',1
WHERE @eq_3648 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3648 AND symbol_latex='\Omega_F(\mathcal{S})');

/* ---------------------------------------------------------------------
   9. Symbolregister
   --------------------------------------------------------------------- */

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\chi_F','\chi_F','Funktionale Konfiguration',
'Geordnetes Tripel aus funktionalen Gehalten, Relationen und Operationen einer funktionalen Organisation.',
'chapter',@section_id,@eq_3645,NULL,'funktionale Organisationen','funktionale Konfigurationen',0,0,0,
'Erstmalige formale Definition in Abschnitt 3.4.1.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\chi_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\Lambda_F','\Lambda_F','Funktionale Zulässigkeitsfunktion',
'Abbildung, welche die axiomatische Zulässigkeit einer funktionalen Konfiguration durch 0 oder 1 kennzeichnet.',
'chapter',@section_id,@eq_3646,NULL,'funktionale Konfigurationen','{0,1}',0,0,1,
'Erstmalige Definition in Abschnitt 3.4.1.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\Lambda_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\Omega_F(\mathcal{S})','\Omega_F(\mathcal{S})','Funktionale Zustandsmenge',
'Menge aller axiomatisch zulässigen funktionalen Zustände einer Organisation.',
'chapter',@section_id,@eq_3648,NULL,'funktionale Organisationen','Mengen funktionaler Zustände',0,0,0,
'Erstmalige rekonstruierte Zustandsmenge in Abschnitt 3.4.1.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\Omega_F(\mathcal{S})');

/* ---------------------------------------------------------------------
   10. Quellenverwendungen
   --------------------------------------------------------------------- */

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_bourbaki_id,@section_id,'background',
'Mengentheoretische Strukturen werden durch Trägermengen, Relationen, Abbildungen und Operationen bestimmt.',
'Abschnitt 3.4.1, strukturelle Einordnung vor Gleichung (3.645)',0,1,
'Wiederverwendung der Quelle [72].',@revision_id
WHERE @source_bourbaki_id IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM source_usage WHERE source_id=@source_bourbaki_id AND section_id=@section_id AND exact_location='Abschnitt 3.4.1, strukturelle Einordnung vor Gleichung (3.645)');

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_maclane_id,@section_id,'comparison',
'Strukturelle Charakterisierung mathematischer Objekte durch Relationen und Abbildungen als Vergleichshintergrund.',
'Abschnitt 3.4.1, strukturelle Einordnung vor Gleichung (3.645)',0,1,
'Wiederverwendung der Quelle [108].',@revision_id
WHERE @source_maclane_id IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM source_usage WHERE source_id=@source_maclane_id AND section_id=@section_id AND exact_location='Abschnitt 3.4.1, strukturelle Einordnung vor Gleichung (3.645)');

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_halmos_id,@section_id,'background',
'Mengen werden über die Bestimmbarkeit beziehungsweise Zugehörigkeit ihrer Elemente charakterisiert.',
'Abschnitt 3.4.1, Erläuterung nach Gleichung (3.648)',0,1,
'Wiederverwendung der Quelle [6].',@revision_id
WHERE @source_halmos_id IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM source_usage WHERE source_id=@source_halmos_id AND section_id=@section_id AND exact_location='Abschnitt 3.4.1, Erläuterung nach Gleichung (3.648)');

/* ---------------------------------------------------------------------
   11. Änderungsprotokoll
   --------------------------------------------------------------------- */

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'created','section','3.4.1',
'Abschnitt 3.4.1 Funktionaler Zustand wurde neu angelegt.',NULL,'final'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='section' AND object_reference='3.4.1');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'equation_added','equation','3.644-3.654',
'Elf Gleichungen zur Rekonstruktion, Existenz, Identität und Unterscheidbarkeit funktionaler Zustände wurden registriert.',NULL,'3.644 bis 3.654'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='equation' AND object_reference='3.644-3.654');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'definition_added','definition','3.4.1-3.4.2',
'Die Definitionen Funktionaler Zustand und Identität funktionaler Zustände wurden registriert.',NULL,'Definitionen 3.4.1 und 3.4.2'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='definition' AND object_reference='3.4.1-3.4.2');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'statement_added','statement','3.4.1',
'Lemma 3.4.1, Satz 3.4.1 und Korollar 3.4.1 wurden registriert.',NULL,'Lemma, Satz und Korollar'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='statement' AND object_reference='3.4.1');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'proof_added','proof','B-3.4.1-*',
'Drei Beweise beziehungsweise Begründungen wurden registriert.',NULL,'B-3.4.1-L1, B-3.4.1-S1, B-3.4.1-K1'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='proof' AND object_reference='B-3.4.1-*');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'source_reused','source','6,72,108',
'Die vorhandenen Quellen [6], [72] und [108] wurden in Abschnitt 3.4.1 wiederverwendet.',NULL,'Halmos; Bourbaki; Mac Lane'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='source' AND object_reference='6,72,108');

/* ---------------------------------------------------------------------
   12. Repository-Zähler aktualisieren
   --------------------------------------------------------------------- */

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_equation_number_chapter_3','3.654')
ON DUPLICATE KEY UPDATE counter_value='3.654';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_citation_number','109')
ON DUPLICATE KEY UPDATE counter_value='109';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section_chapter_3','3.4.1')
ON DUPLICATE KEY UPDATE counter_value='3.4.1';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-NEU-K3.4.1-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.4.1-V1';

COMMIT;

/* =====================================================================
   13. Kontrollabfragen
   ===================================================================== */

SELECT revision_id, revision_code, scope_reference, version_label, summary
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.4.1-V1';

SELECT section_id, section_code, title, status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.4.1';

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1)
ORDER BY definition_number;

SELECT lemma_number AS object_number, title, 'lemma' AS object_type, validation_status
FROM lemmas WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1)
UNION ALL
SELECT theorem_number, title, 'theorem', validation_status
FROM theorems WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1)
UNION ALL
SELECT corollary_number, title, 'corollary', validation_status
FROM corollaries WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1)
ORDER BY proof_number;

SELECT s.citation_number, s.short_citation_text, su.usage_type, su.exact_location
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.1' LIMIT 1)
ORDER BY s.citation_number;

SELECT counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
('last_equation_number_chapter_3','last_citation_number','last_completed_section_chapter_3','last_repository_revision')
ORDER BY counter_key;
