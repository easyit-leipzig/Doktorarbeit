/* KORREKTUR V2: SQL-sichere Prime-Schreibweise z_F^{\\prime}; neu erzeugte Datei. */
/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.2
   Kapitel 3.4: Mathematische Rekonstruktion funktionaler Organisation
   Abschnitt 3.4.2: Klassen funktionaler Zustände

   Voraussetzung:
   - Datenbankstand nach erfolgreichem Import von frzk_rkb_update_3.4.1.sql
   - letzte Gleichung: (3.654)
   - letzte Quelle: [109]

   Neu registriert:
   - Abschnitt 3.4.2
   - Gleichungen (3.655) bis (3.672)
   - Definitionen 3.4.3 und 3.4.4
   - Lemma 3.4.2
   - Satz 3.4.2
   - Korollar 3.4.2
   - zugehörige Beweise
   - Wiederverwendung der Quellen [6] und [72]
   - Gleichungssymbole, Symbolregister, Quellenverwendungen,
     Änderungsprotokoll und Repository-Zähler

   Eigenschaften:
   - idempotent
   - schema-konform zu frzk_rkb_ende_3.3(4).sql
   - keine fest vergebenen Primärschlüssel
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.2-V1';
SET @revision_date := NOW();

/* ---------------------------------------------------------------------
   1. Vorgängerrevision und neue Revision
   --------------------------------------------------------------------- */

SET @parent_revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.4.1-V1' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference,
 version_label, summary, created_by, parent_revision_id)
SELECT
    @revision_code, @revision_date, 'section', '3.4.2', '1.0',
    'Rekonstruktion funktionaler Zustandsklassen mittels einer merkmalsinduzierten Äquivalenzrelation. Registriert werden die Gleichungen (3.655) bis (3.672), zwei Definitionen, ein Lemma, ein Satz, ein Korollar, die zugehörigen Beweise sowie die Wiederverwendung der Quellen [6] und [72].',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SET @revision_id :=
(SELECT revision_id FROM repository_revisions WHERE revision_code=@revision_code LIMIT 1);

/* ---------------------------------------------------------------------
   2. Abschnitt 3.4.2 anlegen
   --------------------------------------------------------------------- */

SET @chapter_34_id :=
(SELECT section_id FROM dissertation_sections WHERE section_code='3.4' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no,
 section_order, status, is_original_contribution, notes)
SELECT
    @chapter_34_id, '3.4.2', 'Klassen funktionaler Zustände', 3,
    3.4020, 'final', 1,
    'Rekonstruktion funktionaler Äquivalenz, funktionaler Zustandsklassen und der Quotientenmenge; Nachweis der Äquivalenzeigenschaften, der Partition der Zustandsmenge und der eindeutigen Klassenzugehörigkeit.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.4.2');

SET @section_id :=
(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1);

/* ---------------------------------------------------------------------
   3. Wiederverwendete Quellen bestimmen
   --------------------------------------------------------------------- */

SET @source_halmos_id :=
(SELECT source_id FROM sources WHERE citation_number=6 LIMIT 1);
SET @source_bourbaki_id :=
(SELECT source_id FROM sources WHERE citation_number=72 LIMIT 1);

/* ---------------------------------------------------------------------
   4. Gleichungen (3.655) bis (3.672)
   --------------------------------------------------------------------- */
INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.655', @section_id, 'Funktionale Vergleichsrelation',
'z_F^{(i)}\sim_F z_F^{(j)}',
'z_F^{(i)}\sim_F z_F^{(j)}',
'Zwei funktionale Zustände stehen bezüglich eines festgelegten funktionalen Kriteriums in einer Vergleichsrelation.',
'definition','original',NULL,
'Einführung einer allgemeinen funktionalen Vergleichsrelation.',
'Zwei Zustände aus der funktionalen Zustandsmenge.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.655');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.656', @section_id, 'Funktionale Merkmalsabbildung',
'\kappa_F:\Omega_F(\mathcal{S})\longrightarrow K_F',
'\kappa_F:\Omega_F(\mathcal{S})\longrightarrow K_F',
'Die Merkmalsabbildung ordnet jedem funktionalen Zustand einen funktionalen Merkmalswert zu.',
'definition','original',NULL,
'Eigene Abbildung zur formalen Darstellung des Klassifikationskriteriums.',
'Funktionale Zustandsmenge und Merkmalswertemenge.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.656');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.657', @section_id, 'Merkmalsinduzierte funktionale Äquivalenz',
'z_F^{(i)}\sim_F z_F^{(j)}\Longleftrightarrow\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
'z_F^{(i)}\sim_F z_F^{(j)}\Longleftrightarrow\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
'Zwei Zustände sind funktional gleichartig, wenn ihre Werte unter dem gewählten funktionalen Kriterium übereinstimmen.',
'definition','original',NULL,
'Eigene Rekonstruktion einer durch eine Merkmalsabbildung induzierten Relation.',
'Gleichung (3.656).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.657');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.658', @section_id, 'Bedingung funktionaler Äquivalenz',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
'Formale Definitionsbedingung der funktionalen Äquivalenz.',
'definition','original',NULL,
'Konkretisierung von Gleichung (3.657) in Definition 3.4.3.',
'Festgelegtes funktionales Kriterium kappa_F.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.658');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.659', @section_id, 'Identische funktionale Zustände',
'z_F^{(i)}=z_F^{(j)}',
'z_F^{(i)}=z_F^{(j)}',
'Vollständige Identität zweier funktionaler Zustände.',
'derived','original',NULL,
'Wiederaufnahme der Zustandsidentität aus Abschnitt 3.4.1.',
'Definition 3.4.2.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.659');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.660', @section_id, 'Identität impliziert funktionale Äquivalenz',
'z_F^{(i)}\sim_F z_F^{(j)}',
'z_F^{(i)}\sim_F z_F^{(j)}',
'Identische funktionale Zustände sind bezüglich desselben Kriteriums funktional äquivalent.',
'derived','original',NULL,
'Folgerung aus Gleichheit der Zustände und Funktionswerten.',
'Gleichung (3.659) und gleiche Merkmalsabbildung.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.660');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.661', @section_id, 'Reflexivität der Merkmalsgleichheit',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(i)}\right)',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(i)}\right)',
'Jeder funktionale Zustand besitzt denselben Merkmalswert wie er selbst.',
'lemma','original',NULL,
'Nachweis der Reflexivität der funktionalen Äquivalenzrelation.',
'Gleichheit ist reflexiv.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.661');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.662', @section_id, 'Ausgangsgleichheit für Symmetrie',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
'Voraussetzung des Symmetrienachweises.',
'lemma','original',NULL,
'Übernahme der Äquivalenzbedingung.',
'z_i ist funktional äquivalent zu z_j.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.662');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.663', @section_id, 'Symmetrische Merkmalsgleichheit',
'\kappa_F\left(z_F^{(j)}\right)=\kappa_F\left(z_F^{(i)}\right)',
'\kappa_F\left(z_F^{(j)}\right)=\kappa_F\left(z_F^{(i)}\right)',
'Umkehrung der Merkmalsgleichheit aufgrund der Symmetrie der Gleichheit.',
'lemma','original',NULL,
'Nachweis der Symmetrie der funktionalen Äquivalenzrelation.',
'Gleichung (3.662).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.663');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.664', @section_id, 'Voraussetzungen der Transitivität',
'z_F^{(i)}\sim_F z_F^{(j)}\quad\text{und}\quad z_F^{(j)}\sim_F z_F^{(k)}',
'z_F^{(i)}\sim_F z_F^{(j)}\quad\text{und}\quad z_F^{(j)}\sim_F z_F^{(k)}',
'Zwei aufeinander bezogene funktionale Äquivalenzen bilden die Voraussetzung des Transitivitätsnachweises.',
'lemma','original',NULL,
'Formulierung der Transitivitätsvoraussetzung.',
'Drei Zustände aus der Zustandsmenge.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.664');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.665', @section_id, 'Transitive Merkmalsgleichheit',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)=\kappa_F\left(z_F^{(k)}\right)',
'\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)=\kappa_F\left(z_F^{(k)}\right)',
'Die Gleichheit der Merkmalswerte überträgt sich transitiv auf den ersten und dritten Zustand.',
'lemma','original',NULL,
'Nachweis der Transitivität der funktionalen Äquivalenzrelation.',
'Gleichung (3.664).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.665');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.666', @section_id, 'Funktionale Zustandsklasse',
'[z_F]_{\sim_F}=\left\{z_F^{\\prime}\in\Omega_F(\mathcal{S})\middle|z_F^{\\prime}\sim_F z_F\right\}',
'[z_F]_{\sim_F}=\left\{z_F^{\\prime}\in\Omega_F(\mathcal{S})\middle|z_F^{\\prime}\sim_F z_F\right\}',
'Die Zustandsklasse enthält alle funktionalen Zustände, die zum gegebenen Zustand funktional äquivalent sind.',
'definition','original',NULL,
'Eigene Definition der funktionalen Äquivalenzklasse.',
'Äquivalenzrelation aus Lemma 3.4.2.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.666');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.667', @section_id, 'Quotientenmenge funktionaler Zustände',
'\Omega_F(\mathcal{S})/{\sim_F}=\left\{[z_F]_{\sim_F}\middle|z_F\in\Omega_F(\mathcal{S})\right\}',
'\Omega_F(\mathcal{S})/{\sim_F}=\left\{[z_F]_{\sim_F}\middle|z_F\in\Omega_F(\mathcal{S})\right\}',
'Die Quotientenmenge enthält sämtliche funktionalen Zustandsklassen.',
'definition','original',NULL,
'Klassische Quotientenbildung, funktional rekonstruiert.',
'Funktionale Zustandsmenge und Äquivalenzrelation.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.667');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.668', @section_id, 'Überdeckung der Zustandsmenge',
'\bigcup_{z_F\in\Omega_F(\mathcal{S})}[z_F]_{\sim_F}=\Omega_F(\mathcal{S})',
'\bigcup_{z_F\in\Omega_F(\mathcal{S})}[z_F]_{\sim_F}=\Omega_F(\mathcal{S})',
'Die Vereinigung aller funktionalen Zustandsklassen überdeckt die gesamte Zustandsmenge.',
'theorem','original',NULL,
'Erster Teil des Partitionsnachweises.',
'Reflexivität der Äquivalenzrelation.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.668');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.669', @section_id, 'Gemeinsames Element zweier Zustandsklassen',
'z_F^{(k)}\sim_F z_F^{(i)}\quad\text{und}\quad z_F^{(k)}\sim_F z_F^{(j)}',
'z_F^{(k)}\sim_F z_F^{(i)}\quad\text{und}\quad z_F^{(k)}\sim_F z_F^{(j)}',
'Ein gemeinsames Element zweier Klassen ist zu beiden Repräsentanten funktional äquivalent.',
'theorem','original',NULL,
'Zwischenschritt des Partitionsnachweises.',
'Nichtleerer Schnitt zweier Zustandsklassen.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.669');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.670', @section_id, 'Äquivalenz der Klassenrepräsentanten',
'z_F^{(i)}\sim_F z_F^{(j)}',
'z_F^{(i)}\sim_F z_F^{(j)}',
'Aus einem gemeinsamen Klassenelement folgt die funktionale Äquivalenz der Repräsentanten.',
'theorem','original',NULL,
'Folgerung aus Symmetrie und Transitivität.',
'Gleichung (3.669).','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.670');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.671', @section_id, 'Disjunktheit verschiedener Zustandsklassen',
'[z_F^{(i)}]_{\sim_F}\cap[z_F^{(j)}]_{\sim_F}=\varnothing',
'[z_F^{(i)}]_{\sim_F}\cap[z_F^{(j)}]_{\sim_F}=\varnothing',
'Verschiedene funktionale Zustandsklassen besitzen kein gemeinsames Element.',
'theorem','original',NULL,
'Zweiter Teil des Partitionsnachweises.',
'Nichtäquivalente Klassenrepräsentanten.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.671');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.672', @section_id, 'Kriteriumsabhängige Zustandsklasse',
'[z_F]_{\kappa_F}=\left\{z_F^{\\prime}\in\Omega_F(\mathcal{S})\middle|\kappa_F(z_F^{\\prime})=\kappa_F(z_F)\right\}',
'[z_F]_{\kappa_F}=\left\{z_F^{\\prime}\in\Omega_F(\mathcal{S})\middle|\kappa_F(z_F^{\\prime})=\kappa_F(z_F)\right\}',
'Die Schreibweise macht die Abhängigkeit einer Zustandsklasse vom gewählten funktionalen Kriterium sichtbar.',
'definition','original',NULL,
'Explizite kriteriumsabhängige Form der Äquivalenzklasse.',
'Festgelegte Merkmalsabbildung kappa_F.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.672');

SET @eq_3655 := (SELECT equation_id FROM equations WHERE equation_number='3.655' LIMIT 1);
SET @eq_3656 := (SELECT equation_id FROM equations WHERE equation_number='3.656' LIMIT 1);
SET @eq_3657 := (SELECT equation_id FROM equations WHERE equation_number='3.657' LIMIT 1);
SET @eq_3658 := (SELECT equation_id FROM equations WHERE equation_number='3.658' LIMIT 1);
SET @eq_3659 := (SELECT equation_id FROM equations WHERE equation_number='3.659' LIMIT 1);
SET @eq_3660 := (SELECT equation_id FROM equations WHERE equation_number='3.660' LIMIT 1);
SET @eq_3661 := (SELECT equation_id FROM equations WHERE equation_number='3.661' LIMIT 1);
SET @eq_3662 := (SELECT equation_id FROM equations WHERE equation_number='3.662' LIMIT 1);
SET @eq_3663 := (SELECT equation_id FROM equations WHERE equation_number='3.663' LIMIT 1);
SET @eq_3664 := (SELECT equation_id FROM equations WHERE equation_number='3.664' LIMIT 1);
SET @eq_3665 := (SELECT equation_id FROM equations WHERE equation_number='3.665' LIMIT 1);
SET @eq_3666 := (SELECT equation_id FROM equations WHERE equation_number='3.666' LIMIT 1);
SET @eq_3667 := (SELECT equation_id FROM equations WHERE equation_number='3.667' LIMIT 1);
SET @eq_3668 := (SELECT equation_id FROM equations WHERE equation_number='3.668' LIMIT 1);
SET @eq_3669 := (SELECT equation_id FROM equations WHERE equation_number='3.669' LIMIT 1);
SET @eq_3670 := (SELECT equation_id FROM equations WHERE equation_number='3.670' LIMIT 1);
SET @eq_3671 := (SELECT equation_id FROM equations WHERE equation_number='3.671' LIMIT 1);
SET @eq_3672 := (SELECT equation_id FROM equations WHERE equation_number='3.672' LIMIT 1);

/* ---------------------------------------------------------------------
   5. Definitionen
   --------------------------------------------------------------------- */

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex,
 word_latex, provenance, source_id, assumptions, notes,
 validation_status, created_revision_id)
SELECT
    '3.4.3', @section_id, 'Funktionale Äquivalenz',
    'Zwei funktionale Zustände heißen bezüglich eines festgelegten funktionalen Kriteriums kappa_F funktional äquivalent, wenn ihre durch kappa_F bestimmten Merkmalswerte übereinstimmen.',
    '\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
    '\kappa_F\left(z_F^{(i)}\right)=\kappa_F\left(z_F^{(j)}\right)',
    'original', NULL,
    'Funktionale Zustandsmenge aus Abschnitt 3.4.1 und Merkmalsabbildung aus Gleichung (3.656).',
    'Eigene Definition einer kriteriumsabhängigen funktionalen Äquivalenz.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.3');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex,
 word_latex, provenance, source_id, assumptions, notes,
 validation_status, created_revision_id)
SELECT
    '3.4.4', @section_id, 'Funktionale Zustandsklasse',
    'Die funktionale Zustandsklasse eines Zustands z_F bezüglich der Relation sim_F ist die Menge aller Zustände der funktionalen Zustandsmenge, die zu z_F funktional äquivalent sind.',
    '[z_F]_{\sim_F}=\left\{z_F^{\\prime}\in\Omega_F(\mathcal{S})\middle|z_F^{\\prime}\sim_F z_F\right\}',
    '[z_F]_{\sim_F}=\left\{z_F^{\\prime}\in\Omega_F(\mathcal{S})\middle|z_F^{\\prime}\sim_F z_F\right\}',
    'original', NULL,
    'Definition 3.4.3 und Lemma 3.4.2.',
    'Eigene funktionale Spezifikation der Äquivalenzklasse innerhalb der rekonstruierten Zustandsmenge.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.4');

/* ---------------------------------------------------------------------
   6. Lemma, Satz und Korollar
   --------------------------------------------------------------------- */

INSERT INTO lemmas
(lemma_number, section_id, title, statement_text, statement_latex,
 word_latex, provenance, source_id, assumptions, validation_status,
 created_revision_id)
SELECT
    '3.4.2', @section_id, 'Äquivalenzeigenschaften',
    'Die durch die Gleichheit der Merkmalswerte einer Abbildung kappa_F definierte Relation sim_F ist reflexiv, symmetrisch und transitiv und damit eine Äquivalenzrelation auf Omega_F(S).',
    '\sim_F\text{ ist reflexiv, symmetrisch und transitiv auf }\Omega_F(\mathcal{S})',
    '\sim_F\text{ ist reflexiv, symmetrisch und transitiv auf }\Omega_F(\mathcal{S})',
    'original', NULL,
    'Definition 3.4.3 und die Eigenschaften der Gleichheitsrelation auf K_F.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='3.4.2');

SET @lemma_id := (SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.2' LIMIT 1);

INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex,
 word_latex, provenance, source_id, assumptions, validation_status,
 created_revision_id)
SELECT
    '3.4.2', @section_id, 'Partition der Zustandsmenge',
    'Die Menge der durch sim_F erzeugten funktionalen Zustandsklassen bildet eine Partition der funktionalen Zustandsmenge Omega_F(S).',
    '\Omega_F(\mathcal{S})=\biguplus_{[z_F]_{\sim_F}\in\Omega_F(\mathcal{S})/{\sim_F}}[z_F]_{\sim_F}',
    '\Omega_F(\mathcal{S})=\biguplus_{[z_F]_{\sim_F}\in\Omega_F(\mathcal{S})/{\sim_F}}[z_F]_{\sim_F}',
    'original', NULL,
    'Lemma 3.4.2 und klassische Eigenschaften von Äquivalenzklassen.',
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.2');

SET @theorem_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.2' LIMIT 1);

INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex,
 word_latex, parent_theorem_id, parent_lemma_id, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    '3.4.2', @section_id, 'Eindeutige Klassenzugehörigkeit',
    'Für jedes z_F aus Omega_F(S) existiert bezüglich eines festgelegten Kriteriums kappa_F genau eine funktionale Zustandsklasse [z_F]_{kappa_F}.',
    '\forall z_F\in\Omega_F(\mathcal{S})\;\exists!\,[z_F]_{\kappa_F}',
    '\forall z_F\in\Omega_F(\mathcal{S})\;\exists!\,[z_F]_{\kappa_F}',
    @theorem_id, NULL,
    'original', NULL,
    'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.2');

SET @corollary_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.2' LIMIT 1);

/* ---------------------------------------------------------------------
   7. Beweise
   --------------------------------------------------------------------- */

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    'B-3.4.2-L1', @section_id, NULL, @lemma_id, NULL,
    'Beweis zu Lemma 3.4.2',
    'Für jeden Zustand ist der Merkmalswert mit sich selbst identisch; daher ist die Relation reflexiv. Aus der Symmetrie der Gleichheit folgt, dass aus kappa_F(z_i)=kappa_F(z_j) auch kappa_F(z_j)=kappa_F(z_i) folgt; daher ist die Relation symmetrisch. Aus kappa_F(z_i)=kappa_F(z_j) und kappa_F(z_j)=kappa_F(z_k) folgt durch Transitivität der Gleichheit kappa_F(z_i)=kappa_F(z_k); daher ist die Relation transitiv. Somit ist sim_F eine Äquivalenzrelation.',
    '\text{Reflexivität}\land\text{Symmetrie}\land\text{Transitivität}\Rightarrow\sim_F\text{ ist Äquivalenzrelation}',
    'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.2-L1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    'B-3.4.2-S1', @section_id, @theorem_id, NULL, NULL,
    'Beweis zu Satz 3.4.2',
    'Aufgrund der Reflexivität gehört jeder Zustand zu seiner eigenen Äquivalenzklasse, sodass die Vereinigung aller Klassen die gesamte Zustandsmenge überdeckt. Besitzen zwei Klassen ein gemeinsames Element, ist dieses Element zu beiden Repräsentanten äquivalent. Aus Symmetrie und Transitivität folgt die Äquivalenz der Repräsentanten und damit die Identität beider Klassen. Verschiedene Klassen sind folglich disjunkt. Überdeckung und paarweise Disjunktheit zeigen, dass die Klassen eine Partition bilden.',
    '\bigcup[z_F]_{\sim_F}=\Omega_F(\mathcal{S})\land\left([z_i]_{\sim_F}\neq[z_j]_{\sim_F}\Rightarrow[z_i]_{\sim_F}\cap[z_j]_{\sim_F}=\varnothing\right)',
    'partition','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.2-S1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT
    'B-3.4.2-K1', @section_id, NULL, NULL, @corollary_id,
    'Begründung zu Korollar 3.4.2',
    'Nach Satz 3.4.2 bilden die funktionalen Äquivalenzklassen eine Partition der Zustandsmenge. Eine Partition überdeckt die Grundmenge vollständig und ihre Teilmengen sind paarweise disjunkt. Daher gehört jeder funktionale Zustand bezüglich des festgelegten Kriteriums genau einer funktionalen Zustandsklasse an.',
    '\forall z_F\in\Omega_F(\mathcal{S})\;\exists!\,[z_F]_{\kappa_F}',
    'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.2-K1');

/* ---------------------------------------------------------------------
   8. Gleichungssymbole – zentrale Erst- und Wiederverwendungen
   --------------------------------------------------------------------- */

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3655,'\sim_F','funktionale Äquivalenzrelation','Relation funktionaler Gleichartigkeit bezüglich eines festgelegten Kriteriums.',NULL,'\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})',1
WHERE @eq_3655 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3655 AND symbol_latex='\sim_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3656,'\kappa_F','funktionale Merkmalsabbildung','Ordnet jedem funktionalen Zustand den für die Klassifikation maßgeblichen Merkmalswert zu.',NULL,'\Omega_F(\mathcal{S})\to K_F',1
WHERE @eq_3656 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3656 AND symbol_latex='\kappa_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3656,'K_F','funktionale Merkmalswertemenge','Menge aller möglichen Werte des gewählten funktionalen Klassifikationskriteriums.',NULL,'Menge',2
WHERE @eq_3656 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3656 AND symbol_latex='K_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3666,'[z_F]_{\sim_F}','funktionale Zustandsklasse','Äquivalenzklasse eines funktionalen Zustands bezüglich sim_F.',NULL,'Teilmenge von \Omega_F(\mathcal{S})',1
WHERE @eq_3666 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3666 AND symbol_latex='[z_F]_{\sim_F}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3667,'\Omega_F(\mathcal{S})/{\sim_F}','funktionale Quotientenmenge','Menge aller funktionalen Zustandsklassen bezüglich sim_F.',NULL,'Quotientenmenge',1
WHERE @eq_3667 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3667 AND symbol_latex='\Omega_F(\mathcal{S})/{\sim_F}');

/* ---------------------------------------------------------------------
   9. Symbolregister
   --------------------------------------------------------------------- */

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\sim_F','\sim_F','Funktionale Äquivalenzrelation',
'Relation, die zwei funktionale Zustände genau dann verbindet, wenn ihre Werte unter einem festgelegten funktionalen Kriterium übereinstimmen.',
'chapter',@section_id,@eq_3655,NULL,'\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})','{wahr,falsch}',0,0,0,
'Erstmalige formale Definition in Abschnitt 3.4.2.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\sim_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\kappa_F','\kappa_F','Funktionale Merkmalsabbildung',
'Abbildung, die funktionale Zustände anhand eines festgelegten Kriteriums auf funktionale Merkmalswerte abbildet.',
'chapter',@section_id,@eq_3656,NULL,'\Omega_F(\mathcal{S})','K_F',0,0,1,
'Erstmalige Definition in Abschnitt 3.4.2.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\kappa_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT 'K_F','K_F','Funktionale Merkmalswertemenge',
'Menge der möglichen Werte eines funktionalen Klassifikationskriteriums.',
'chapter',@section_id,@eq_3656,NULL,'funktionale Kriterien','Merkmalswerte',0,0,0,
'Erstmalige Definition in Abschnitt 3.4.2.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='K_F');

/* ---------------------------------------------------------------------
   10. Quellenverwendungen
   --------------------------------------------------------------------- */

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_bourbaki_id,@section_id,'background',
'Äquivalenzrelationen und Quotientenmengen fassen mathematische Objekte anhand invariant gehaltener Eigenschaften zu Klassen zusammen.',
'Abschnitt 3.4.2, Einordnung nach Gleichung (3.657)',0,1,
'Wiederverwendung der Quelle [72].',@revision_id
WHERE @source_bourbaki_id IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM source_usage WHERE source_id=@source_bourbaki_id AND section_id=@section_id AND exact_location='Abschnitt 3.4.2, Einordnung nach Gleichung (3.657)');

INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_halmos_id,@section_id,'background',
'Mengentheoretischer Hintergrund zu Äquivalenzrelationen, Äquivalenzklassen und Partitionen.',
'Abschnitt 3.4.2, Einordnung nach Gleichung (3.657)',0,1,
'Wiederverwendung der Quelle [6].',@revision_id
WHERE @source_halmos_id IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM source_usage WHERE source_id=@source_halmos_id AND section_id=@section_id AND exact_location='Abschnitt 3.4.2, Einordnung nach Gleichung (3.657)');

/* ---------------------------------------------------------------------
   11. Änderungsprotokoll
   --------------------------------------------------------------------- */

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'created','section','3.4.2',
'Abschnitt 3.4.2 Klassen funktionaler Zustände wurde neu angelegt.',NULL,'final'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='section' AND object_reference='3.4.2');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'equation_added','equation','3.655-3.672',
'Achtzehn Gleichungen zu funktionaler Äquivalenz, Zustandsklassen, Quotientenmenge und Partition wurden registriert.',NULL,'3.655 bis 3.672'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='equation' AND object_reference='3.655-3.672');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'definition_added','definition','3.4.3-3.4.4',
'Die Definitionen Funktionale Äquivalenz und Funktionale Zustandsklasse wurden registriert.',NULL,'Definitionen 3.4.3 und 3.4.4'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='definition' AND object_reference='3.4.3-3.4.4');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'statement_added','statement','3.4.2',
'Lemma 3.4.2, Satz 3.4.2 und Korollar 3.4.2 wurden registriert.',NULL,'Lemma, Satz und Korollar'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='statement' AND object_reference='3.4.2');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'proof_added','proof','B-3.4.2-*',
'Drei Beweise beziehungsweise Begründungen wurden registriert.',NULL,'B-3.4.2-L1, B-3.4.2-S1, B-3.4.2-K1'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='proof' AND object_reference='B-3.4.2-*');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'source_reused','source','6,72',
'Die vorhandenen Quellen [6] und [72] wurden in Abschnitt 3.4.2 wiederverwendet.',NULL,'Halmos; Bourbaki'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='source' AND object_reference='6,72');

/* ---------------------------------------------------------------------
   12. Repository-Zähler aktualisieren
   --------------------------------------------------------------------- */

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_equation_number_chapter_3','3.672')
ON DUPLICATE KEY UPDATE counter_value='3.672';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_citation_number','109')
ON DUPLICATE KEY UPDATE counter_value='109';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section_chapter_3','3.4.2')
ON DUPLICATE KEY UPDATE counter_value='3.4.2';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-NEU-K3.4.2-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.4.2-V1';

COMMIT;

/* =====================================================================
   13. Kontrollabfragen
   ===================================================================== */

SELECT revision_id, revision_code, scope_reference, version_label, summary
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.4.2-V1';

SELECT section_id, section_code, title, status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.4.2';

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1)
ORDER BY definition_number;

SELECT lemma_number AS object_number, title, 'lemma' AS object_type, validation_status
FROM lemmas WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1)
UNION ALL
SELECT theorem_number, title, 'theorem', validation_status
FROM theorems WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1)
UNION ALL
SELECT corollary_number, title, 'corollary', validation_status
FROM corollaries WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1)
ORDER BY proof_number;

SELECT s.citation_number, s.short_citation_text, su.usage_type, su.exact_location
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.2' LIMIT 1)
ORDER BY s.citation_number;

SELECT counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
('last_equation_number_chapter_3','last_citation_number','last_completed_section_chapter_3','last_repository_revision')
ORDER BY counter_key;
