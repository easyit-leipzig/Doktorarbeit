/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.3
   Kapitel 3.4: Mathematische Rekonstruktion funktionaler Organisation
   Abschnitt 3.4.3: Funktionale Relationen

   Voraussetzung:
   - erfolgreicher Import von frzk_rkb_update_3.4.2_KORRIGIERT_V2.sql
   - letzte Gleichung: (3.672)
   - letzte Quelle: [109]

   Neu registriert:
   - Abschnitt 3.4.3
   - Gleichungen (3.673) bis (3.699)
   - Definitionen 3.4.5 bis 3.4.7
   - Lemma 3.4.3
   - Satz 3.4.3
   - Korollar 3.4.3
   - drei zugehörige Beweise
   - Wiederverwendung der Quelle [108]
   - Gleichungssymbole, Symbolregister, Quellenverwendung,
     Änderungsprotokoll und Repository-Zähler

   Eigenschaften:
   - idempotent
   - schema-konform zum bereitgestellten Gesamtstand frzk_rkb_3.4.2.sql
   - SQL-sichere Prime-Schreibweise z_F^{\prime}
   - keine fest vergebenen Primärschlüssel
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.3-V1';
SET @revision_date := NOW();

SET @parent_revision_id :=
(
    SELECT revision_id FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.4.2-V1' LIMIT 1
);

INSERT INTO repository_revisions
(revision_code, revision_date, scope_type, scope_reference,
 version_label, summary, created_by, parent_revision_id)
SELECT
    @revision_code, @revision_date, 'section', '3.4.3', '1.0',
    'Rekonstruktion funktionaler Relationen und funktionaler Zustandsstrukturen. Registriert werden die Gleichungen (3.673) bis (3.699), drei Definitionen, ein Lemma, ein Satz, ein Korollar, die zugehörigen Beweise sowie die Wiederverwendung der Quelle [108].',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code);

SET @revision_id :=
(SELECT revision_id FROM repository_revisions WHERE revision_code=@revision_code LIMIT 1);

SET @chapter_34_id :=
(SELECT section_id FROM dissertation_sections WHERE section_code='3.4' LIMIT 1);

INSERT INTO dissertation_sections
(parent_section_id, section_code, title, chapter_no,
 section_order, status, is_original_contribution, notes)
SELECT
    @chapter_34_id, '3.4.3', 'Funktionale Relationen', 3,
    3.4030, 'final', 1,
    'Rekonstruktion funktionaler Relationen, gerichteter Zustandspaare, funktionaler Zustandsstrukturen, relationaler Einbindung und der Notwendigkeit nichtleerer Relationierung.'
WHERE NOT EXISTS
(SELECT 1 FROM dissertation_sections WHERE section_code='3.4.3');

SET @section_id :=
(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1);

SET @source_maclane_id :=
(SELECT source_id FROM sources WHERE citation_number=108 LIMIT 1);

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.673', @section_id, 'Allgemeine binäre Relation', 'R\\subseteq X\\times Y', 'R\\subseteq X\\times Y',
       'Eine binäre Relation ist eine Teilmenge eines kartesischen Produkts.', 'definition', 'original', NULL,
       'Klassische mengentheoretische Ausgangsform.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.673');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.674', @section_id, 'Relationale Prüffunktion', '\\rho_F:\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\longrightarrow\\{0,1\\}', '\\rho_F:\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\longrightarrow\\{0,1\\}',
       'Die Prüffunktion bewertet geordnete Zustandspaare auf funktionale Zulässigkeit.', 'definition', 'original', NULL,
       'Eigene funktionale Prüffunktion.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.674');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.675', @section_id, 'Positive relationale Prüfung', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
       'Zwischen zwei Zuständen besteht eine funktional zulässige Beziehung.', 'definition', 'original', NULL,
       'Auswertung der relationalen Prüffunktion.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.675');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.676', @section_id, 'Funktionale Relation', 'R_F:=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\middle|\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\right\\}', 'R_F:=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\middle|\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\right\\}',
       'Menge aller funktional zulässigen geordneten Zustandspaare.', 'definition', 'original', NULL,
       'Eigene Definition der funktionalen Relation.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.676');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.677', @section_id, 'Teilmenge des Zustandsprodukts', 'R_F\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', 'R_F\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
       'Die funktionale Relation ist eine Teilmenge des kartesischen Produkts der Zustandsmenge.', 'derived', 'original', NULL,
       'Unmittelbare Folgerung aus Definition 3.4.5.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.677');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.678', @section_id, 'Geordnetes Zustandspaar', '\\left(z_F^{(i)},z_F^{(j)}\\right)', '\\left(z_F^{(i)},z_F^{(j)}\\right)',
       'Gerichtetes Paar zweier funktionaler Zustände.', 'definition', 'original', NULL,
       'Darstellung eines Relationselements.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.678');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.679', @section_id, 'Umgekehrtes Zustandspaar', '\\left(z_F^{(j)},z_F^{(i)}\\right)', '\\left(z_F^{(j)},z_F^{(i)}\\right)',
       'Umkehrung der Reihenfolge eines geordneten Zustandspaares.', 'definition', 'original', NULL,
       'Darstellung der möglichen relationalen Asymmetrie.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.679');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.680', @section_id, 'Zugehörigkeitsbedingung', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F\\Longleftrightarrow\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F\\Longleftrightarrow\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
       'Äquivalenz zwischen Relationszugehörigkeit und positiver Prüffunktion.', 'derived', 'original', NULL,
       'Aus Definition 3.4.5.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.680');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.681', @section_id, 'Relationierte Zustandsstruktur', '\\left(\\Omega_F(\\mathcal{S}),R_F\\right)', '\\left(\\Omega_F(\\mathcal{S}),R_F\\right)',
       'Paar aus Zustandsmenge und funktionaler Relation.', 'definition', 'original', NULL,
       'Strukturelle Zusammenfassung.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.681');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.682', @section_id, 'Funktionale Zustandsstruktur', '\\mathfrak{Z}_F(\\mathcal{S}):=\\left(\\Omega_F(\\mathcal{S}),R_F\\right)', '\\mathfrak{Z}_F(\\mathcal{S}):=\\left(\\Omega_F(\\mathcal{S}),R_F\\right)',
       'Definition der funktionalen Zustandsstruktur.', 'definition', 'original', NULL,
       'Eigene Strukturdefinition.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.682');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.683', @section_id, 'Erfüllung relationaler Bedingungen', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\Longleftrightarrow\\left(z_F^{(i)},z_F^{(j)}\\right)\\models\\mathcal{C}_R', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\Longleftrightarrow\\left(z_F^{(i)},z_F^{(j)}\\right)\\models\\mathcal{C}_R',
       'Positive Prüffunktion genau bei Erfüllung der relationalen Zulässigkeitsbedingungen.', 'definition', 'original', NULL,
       'Spezifikation über die Bedingungsmenge C_R.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.683');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.684', @section_id, 'Reflexivitätsbedingung', '\\forall z_F\\in\\Omega_F(\\mathcal{S}):\\left(z_F,z_F\\right)\\in R_F', '\\forall z_F\\in\\Omega_F(\\mathcal{S}):\\left(z_F,z_F\\right)\\in R_F',
       'Formale Bedingung der Reflexivität.', 'lemma', 'original', NULL,
       'Im Allgemeinen nicht notwendig erfüllt.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.684');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.685', @section_id, 'Symmetriebedingung', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F\\Longrightarrow\\left(z_F^{(j)},z_F^{(i)}\\right)\\in R_F', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F\\Longrightarrow\\left(z_F^{(j)},z_F^{(i)}\\right)\\in R_F',
       'Formale Bedingung der Symmetrie.', 'lemma', 'original', NULL,
       'Im Allgemeinen nicht notwendig erfüllt.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.685');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.686', @section_id, 'Transitivitätsbedingung', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F\\land\\left(z_F^{(j)},z_F^{(k)}\\right)\\in R_F\\Longrightarrow\\left(z_F^{(i)},z_F^{(k)}\\right)\\in R_F', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F\\land\\left(z_F^{(j)},z_F^{(k)}\\right)\\in R_F\\Longrightarrow\\left(z_F^{(i)},z_F^{(k)}\\right)\\in R_F',
       'Formale Bedingung der Transitivität.', 'lemma', 'original', NULL,
       'Im Allgemeinen nicht notwendig erfüllt.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.686');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.687', @section_id, 'Gegebene funktionale Relation', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1',
       'Ausgangsbedingung im Beweis von Lemma 3.4.3.', 'lemma', 'original', NULL,
       'Positive relationale Prüfung.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.687');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.688', @section_id, 'Nicht erzwungene Selbstrelation', '\\rho_F\\left(z_F^{(i)},z_F^{(i)}\\right)=1', '\\rho_F\\left(z_F^{(i)},z_F^{(i)}\\right)=1',
       'Reflexivität folgt nicht aus einer einzelnen positiven Relation.', 'lemma', 'original', NULL,
       'Gegenstand des Nichtnotwendigkeitsnachweises.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.688');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.689', @section_id, 'Nicht erzwungene Umkehrrelation', '\\rho_F\\left(z_F^{(j)},z_F^{(i)}\\right)=1', '\\rho_F\\left(z_F^{(j)},z_F^{(i)}\\right)=1',
       'Symmetrie folgt nicht aus einer einzelnen positiven Relation.', 'lemma', 'original', NULL,
       'Gegenstand des Nichtnotwendigkeitsnachweises.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.689');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.690', @section_id, 'Zwei aufeinanderfolgende Relationen', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\quad\\text{und}\\quad\\rho_F\\left(z_F^{(j)},z_F^{(k)}\\right)=1', '\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\quad\\text{und}\\quad\\rho_F\\left(z_F^{(j)},z_F^{(k)}\\right)=1',
       'Voraussetzung einer möglichen Transitivität.', 'lemma', 'original', NULL,
       'Zwei positive relationale Prüfungen.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.690');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.691', @section_id, 'Nicht erzwungene transitive Relation', '\\rho_F\\left(z_F^{(i)},z_F^{(k)}\\right)=1', '\\rho_F\\left(z_F^{(i)},z_F^{(k)}\\right)=1',
       'Transitivität folgt nicht ohne Zusatzbedingungen.', 'lemma', 'original', NULL,
       'Gegenstand des Nichtnotwendigkeitsnachweises.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.691');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.692', @section_id, 'Ausgehende Relationsmenge', 'R_F^{+}(z_F)=\\left\\{z_F^{\\prime}\\in\\Omega_F(\\mathcal{S})\\middle|\\left(z_F,z_F^{\\prime}\\right)\\in R_F\\right\\}', 'R_F^{+}(z_F)=\\left\\{z_F^{\\prime}\\in\\Omega_F(\\mathcal{S})\\middle|\\left(z_F,z_F^{\\prime}\\right)\\in R_F\\right\\}',
       'Menge aller vom Zustand aus funktional erreichbaren Zustände.', 'definition', 'original', NULL,
       'Eigene Definition der ausgehenden Relationsmenge.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.692');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.693', @section_id, 'Eingehende Relationsmenge', 'R_F^{-}(z_F)=\\left\\{z_F^{\\prime}\\in\\Omega_F(\\mathcal{S})\\middle|\\left(z_F^{\\prime},z_F\\right)\\in R_F\\right\\}', 'R_F^{-}(z_F)=\\left\\{z_F^{\\prime}\\in\\Omega_F(\\mathcal{S})\\middle|\\left(z_F^{\\prime},z_F\\right)\\in R_F\\right\\}',
       'Menge aller funktionalen Vorgängerzustände.', 'definition', 'original', NULL,
       'Eigene Definition der eingehenden Relationsmenge.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.693');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.694', @section_id, 'Relationale Einbindung', 'R_F^{+}(z_F)\\cup R_F^{-}(z_F)\\neq\\varnothing', 'R_F^{+}(z_F)\\cup R_F^{-}(z_F)\\neq\\varnothing',
       'Ein Zustand ist relational eingebunden, wenn mindestens eine ein- oder ausgehende Relation existiert.', 'definition', 'original', NULL,
       'Definition 3.4.7.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.694');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.695', @section_id, 'Relationale Isolation', 'R_F^{+}(z_F)=R_F^{-}(z_F)=\\varnothing', 'R_F^{+}(z_F)=R_F^{-}(z_F)=\\varnothing',
       'Ein Zustand besitzt weder ein- noch ausgehende funktionale Relationen.', 'definition', 'original', NULL,
       'Kennzeichnung relationaler Isolation.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.695');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.696', @section_id, 'Nichtleere funktionale Relation', 'R_F\\neq\\varnothing', 'R_F\\neq\\varnothing',
       'Notwendige Bedingung einer nichttrivialen funktionalen Zustandsstruktur.', 'theorem', 'original', NULL,
       'Kernaussage von Satz 3.4.3.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.696');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.697', @section_id, 'Mindestens zwei Zustände', '\\left|\\Omega_F(\\mathcal{S})\\right|\\geq 2', '\\left|\\Omega_F(\\mathcal{S})\\right|\\geq 2',
       'Voraussetzung des Satzes über nichttriviale Relationierung.', 'theorem', 'original', NULL,
       'Mindestens zwei Elemente in der Zustandsmenge.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.697');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.698', @section_id, 'Unrelationierte Zustandsstruktur', '\\mathfrak{Z}_F(\\mathcal{S})=\\left(\\Omega_F(\\mathcal{S}),\\varnothing\\right)', '\\mathfrak{Z}_F(\\mathcal{S})=\\left(\\Omega_F(\\mathcal{S}),\\varnothing\\right)',
       'Struktur mit mehreren Zuständen, aber ohne funktionale Relation.', 'theorem', 'original', NULL,
       'Fall R_F gleich leer.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.698');

INSERT INTO equations
(equation_number, section_id, title, equation_latex, word_latex,
 plain_description, equation_type, provenance, source_id, derivation,
 assumptions, validation_status, created_revision_id)
SELECT '3.699', @section_id, 'Existierendes Relationselement', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F', '\\left(z_F^{(i)},z_F^{(j)}\\right)\\in R_F',
       'Existenz mindestens eines funktional relationierten Zustandspaares.', 'theorem', 'original', NULL,
       'Folgerung aus R_F ungleich leer.', 'Abschnitt 3.4.3 und vorausgehende Rekonstruktion.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM equations WHERE equation_number='3.699');


SET @eq_3674 := (SELECT equation_id FROM equations WHERE equation_number='3.674' LIMIT 1);
SET @eq_3676 := (SELECT equation_id FROM equations WHERE equation_number='3.676' LIMIT 1);
SET @eq_3682 := (SELECT equation_id FROM equations WHERE equation_number='3.682' LIMIT 1);
SET @eq_3683 := (SELECT equation_id FROM equations WHERE equation_number='3.683' LIMIT 1);
SET @eq_3692 := (SELECT equation_id FROM equations WHERE equation_number='3.692' LIMIT 1);
SET @eq_3693 := (SELECT equation_id FROM equations WHERE equation_number='3.693' LIMIT 1);

/* Definitionen */
INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.5', @section_id, 'Funktionale Relation',
       'Eine funktionale Relation R_F auf der Zustandsmenge ist die Menge aller geordneten Zustandspaare, für die die relationale Prüffunktion den Wert 1 annimmt.',
       'R_F:=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\middle|\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\right\\}',
       'R_F:=\\left\\{\\left(z_F^{(i)},z_F^{(j)}\\right)\\in\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})\\middle|\\rho_F\\left(z_F^{(i)},z_F^{(j)}\\right)=1\\right\\}',
       'original', NULL, 'Definition funktionaler Zustände und relationale Prüffunktion.',
       'Eigene funktionale Spezifikation einer binären Relation.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.5');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.6', @section_id, 'Funktionale Zustandsstruktur',
       'Die geordnete Struktur aus funktionaler Zustandsmenge und funktionaler Relation heißt funktionale Zustandsstruktur der Organisation.',
       '\\mathfrak{Z}_F(\\mathcal{S}):=\\left(\\Omega_F(\\mathcal{S}),R_F\\right)',
       '\\mathfrak{Z}_F(\\mathcal{S}):=\\left(\\Omega_F(\\mathcal{S}),R_F\\right)',
       'original', NULL, 'Definition 3.4.5.',
       'Eigene strukturelle Zusammenführung von Zustandsmenge und Relation.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.6');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.7', @section_id, 'Relational eingebundener Zustand',
       'Ein funktionaler Zustand heißt relational eingebunden, wenn mindestens eine ein- oder ausgehende funktionale Relation existiert.',
       'R_F^{+}(z_F)\\cup R_F^{-}(z_F)\\neq\\varnothing',
       'R_F^{+}(z_F)\\cup R_F^{-}(z_F)\\neq\\varnothing',
       'original', NULL, 'Definitionen 3.4.5 und 3.4.6.',
       'Eigene funktionale Spezifikation relationaler Einbindung.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.7');

/* Lemma, Satz, Korollar */
INSERT INTO lemmas
(lemma_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.3', @section_id, 'Nichtnotwendigkeit klassischer Relationseigenschaften',
       'Aus der Definition einer funktionalen Relation folgen Reflexivität, Symmetrie und Transitivität nicht notwendig.',
       '\\neg(\\mathrm{reflexiv}\\land\\mathrm{symmetrisch}\\land\\mathrm{transitiv})\\text{ ohne Zusatzbedingungen}',
       '\\neg(\\mathrm{reflexiv}\\land\\mathrm{symmetrisch}\\land\\mathrm{transitiv})\\text{ ohne Zusatzbedingungen}',
       'original', NULL, 'Definition 3.4.5.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='3.4.3');

INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.3', @section_id, 'Notwendigkeit funktionaler Relationierung',
       'Eine funktionale Zustandsmenge mit mindestens zwei Elementen bildet nur dann eine nichttriviale funktionale Zustandsstruktur, wenn die funktionale Relation nicht leer ist.',
       '\\left|\\Omega_F(\\mathcal{S})\\right|\\geq 2\\Longrightarrow\\left(\\mathfrak{Z}_F\\text{ nichttrivial}\\Rightarrow R_F\\neq\\varnothing\\right)',
       '\\left|\\Omega_F(\\mathcal{S})\\right|\\geq 2\\Longrightarrow\\left(\\mathfrak{Z}_F\\text{ nichttrivial}\\Rightarrow R_F\\neq\\varnothing\\right)',
       'original', NULL, 'Definitionen 3.4.5 und 3.4.6.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.3');

INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex, word_latex,
 parent_theorem_id, parent_lemma_id, provenance, source_id, validation_status, created_revision_id)
SELECT '3.4.3', @section_id, 'Unzureichendheit der bloßen Zustandsmenge',
       'Für eine Zustandsmenge mit mindestens zwei Elementen ist die Zustandsmenge allein nicht hinreichend, um funktionale Organisation eindeutig zu beschreiben.',
       '\\left|\\Omega_F(\\mathcal{S})\\right|\\geq 2\\Longrightarrow\\Omega_F(\\mathcal{S})\\text{ allein ist nicht hinreichend}',
       '\\left|\\Omega_F(\\mathcal{S})\\right|\\geq 2\\Longrightarrow\\Omega_F(\\mathcal{S})\\text{ allein ist nicht hinreichend}',
       (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.3' LIMIT 1), NULL,
       'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.3');

SET @lemma_id := (SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.3' LIMIT 1);
SET @theorem_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.3' LIMIT 1);
SET @corollary_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.3' LIMIT 1);

/* Beweise */
INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT 'B-3.4.3-L1', @section_id, NULL, @lemma_id, NULL,
       'Beweis zu Lemma 3.4.3',
       'Die Zugehörigkeit eines geordneten Zustandspaares zu R_F wird ausschließlich durch den Wert der Prüffunktion rho_F bestimmt. Aus einer einzelnen positiven Prüfung folgen weder die Selbstrelation, noch die umgekehrte Relation, noch bei zwei aufeinanderfolgenden Relationen die direkte Relation zwischen erstem und drittem Zustand. Reflexivität, Symmetrie und Transitivität erfordern daher zusätzliche Bedingungen.',
       '\\rho_F(i,j)=1\\not\\Rightarrow\\rho_F(i,i)=1,\\rho_F(j,i)=1;\\quad\\rho_F(i,j)=\\rho_F(j,k)=1\\not\\Rightarrow\\rho_F(i,k)=1',
       'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.3-L1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT 'B-3.4.3-S1', @section_id, @theorem_id, NULL, NULL,
       'Beweis zu Satz 3.4.3',
       'Ist R_F leer, enthält die Zustandsstruktur trotz mindestens zweier Zustände kein funktional relationiertes Paar und beschreibt nur eine unverbundene Menge zulässiger Konfigurationen. Ist R_F nicht leer, existiert mindestens ein geordnetes funktional relationiertes Zustandspaar. Erst dadurch besitzt die Zustandsmenge eine nichtleere relationale Struktur.',
       'R_F=\\varnothing\\Rightarrow\\mathfrak{Z}_F=(\\Omega_F,\\varnothing);\\quad R_F\\neq\\varnothing\\Rightarrow\\exists(z_i,z_j)\\in R_F',
       'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.3-S1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id,
 validation_status, created_revision_id)
SELECT 'B-3.4.3-K1', @section_id, NULL, NULL, @corollary_id,
       'Begründung zu Korollar 3.4.3',
       'Dieselbe Zustandsmenge kann mit einer leeren oder einer nichtleeren funktionalen Relation verbunden werden. Da dadurch verschiedene funktionale Zustandsstrukturen entstehen, bestimmt die Zustandsmenge allein die Organisation nicht eindeutig.',
       '(\\Omega_F,R_F^{(1)})\\neq(\\Omega_F,R_F^{(2)})\\text{ für }R_F^{(1)}\\neq R_F^{(2)}',
       'direct','original',NULL,'checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.3-K1');

/* Gleichungssymbole */
INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3674,'\rho_F','relationale Prüffunktion',
       'Bewertet geordnete Paare funktionaler Zustände auf relationale Zulässigkeit.',
       NULL,'\Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})\to\{0,1\}',1
WHERE @eq_3674 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3674 AND symbol_latex='\rho_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3676,'R_F','funktionale Relation',
       'Menge aller funktional zulässigen geordneten Zustandspaare.',
       NULL,'Teilmenge von \Omega_F(\mathcal{S})\times\Omega_F(\mathcal{S})',1
WHERE @eq_3676 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3676 AND symbol_latex='R_F');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3682,'\mathfrak{Z}_F(\mathcal{S})','funktionale Zustandsstruktur',
       'Geordnetes Paar aus funktionaler Zustandsmenge und funktionaler Relation.',
       NULL,'Struktur',1
WHERE @eq_3682 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3682 AND symbol_latex='\mathfrak{Z}_F(\mathcal{S})');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3683,'\mathcal{C}_R','relationale Zulässigkeitsbedingungen',
       'Menge der Bedingungen, die ein geordnetes Zustandspaar erfüllen muss.',
       NULL,'Bedingungsmenge',1
WHERE @eq_3683 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3683 AND symbol_latex='\mathcal{C}_R');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3692,'R_F^{+}(z_F)','ausgehende Relationsmenge',
       'Menge der von einem funktionalen Zustand aus relationierten Zustände.',
       NULL,'Teilmenge von \Omega_F(\mathcal{S})',1
WHERE @eq_3692 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3692 AND symbol_latex='R_F^{+}(z_F)');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3693,'R_F^{-}(z_F)','eingehende Relationsmenge',
       'Menge der auf einen funktionalen Zustand gerichteten Zustände.',
       NULL,'Teilmenge von \Omega_F(\mathcal{S})',1
WHERE @eq_3693 IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3693 AND symbol_latex='R_F^{-}(z_F)');

/* Symbolregister */
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\rho_F','\rho_F','Relationale Prüffunktion',
       'Abbildung zur Prüfung, ob ein geordnetes Paar funktionaler Zustände eine zulässige funktionale Relation bildet.',
       'chapter',@section_id,@eq_3674,NULL,
       '\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})','\\{0,1\\}',0,0,1,
       'Erstmalige formale Definition in Abschnitt 3.4.3.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\rho_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT 'R_F','R_F','Funktionale Relation',
       'Menge funktional zulässiger geordneter Zustandspaare.',
       'chapter',@section_id,@eq_3676,NULL,
       '\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})','Wahrheitswert der Zugehörigkeit',0,0,0,
       'Erstmalige Definition in Abschnitt 3.4.3.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='R_F');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\mathfrak{Z}_F(\mathcal{S})','\mathfrak{Z}_F(\mathcal{S})','Funktionale Zustandsstruktur',
       'Geordnete Struktur aus funktionaler Zustandsmenge und funktionaler Relation.',
       'chapter',@section_id,@eq_3682,NULL,'Struktur','Struktur',0,0,0,
       'Erstmalige Definition in Abschnitt 3.4.3.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\mathfrak{Z}_F(\mathcal{S})');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\mathcal{C}_R','\mathcal{C}_R','Relationale Zulässigkeitsbedingungen',
       'Menge der Bedingungen, welche funktional relationierte Zustandspaare erfüllen müssen.',
       'chapter',@section_id,@eq_3683,NULL,'Bedingungen','Wahrheitswerte',0,0,0,
       'Erstmalige Definition in Abschnitt 3.4.3.','checked',@revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\mathcal{C}_R');

/* Quellenverwendung */
INSERT INTO source_usage
(source_id, section_id, usage_type, claim_summary, exact_location,
 is_first_mention, citation_checked, notes, created_revision_id)
SELECT @source_maclane_id,@section_id,'background',
       'Strukturelle Einordnung mathematischer Objekte durch die zwischen ihnen bestehenden Beziehungen.',
       'Abschnitt 3.4.3, Einordnung nach Definition 3.4.6',0,1,
       'Wiederverwendung der Quelle [108].',@revision_id
WHERE @source_maclane_id IS NOT NULL AND NOT EXISTS
(SELECT 1 FROM source_usage WHERE source_id=@source_maclane_id AND section_id=@section_id
 AND exact_location='Abschnitt 3.4.3, Einordnung nach Definition 3.4.6');

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'created','section','3.4.3',
       'Abschnitt 3.4.3 Funktionale Relationen wurde neu angelegt.',NULL,'final'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='section' AND object_reference='3.4.3');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'equation_added','equation','3.673-3.699',
       'Siebenundzwanzig Gleichungen zu funktionalen Relationen und Zustandsstrukturen wurden registriert.',NULL,'3.673 bis 3.699'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='equation' AND object_reference='3.673-3.699');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'definition_added','definition','3.4.5-3.4.7',
       'Drei Definitionen wurden registriert.',NULL,'Definitionen 3.4.5 bis 3.4.7'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='definition' AND object_reference='3.4.5-3.4.7');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'statement_added','statement','3.4.3',
       'Lemma 3.4.3, Satz 3.4.3 und Korollar 3.4.3 wurden registriert.',NULL,'Lemma, Satz und Korollar'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='statement' AND object_reference='3.4.3');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'proof_added','proof','B-3.4.3-*',
       'Drei Beweise beziehungsweise Begründungen wurden registriert.',NULL,'B-3.4.3-L1, B-3.4.3-S1, B-3.4.3-K1'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='proof' AND object_reference='B-3.4.3-*');

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id,@section_id,'source_reused','source','108',
       'Die vorhandene Quelle [108] wurde wiederverwendet.',NULL,'Mac Lane'
WHERE NOT EXISTS
(SELECT 1 FROM section_change_log WHERE revision_id=@revision_id AND object_type='source' AND object_reference='108');

/* Repository-Zähler */
INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_equation_number_chapter_3','3.699')
ON DUPLICATE KEY UPDATE counter_value='3.699';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_citation_number','109')
ON DUPLICATE KEY UPDATE counter_value='109';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section_chapter_3','3.4.3')
ON DUPLICATE KEY UPDATE counter_value='3.4.3';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-NEU-K3.4.3-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.4.3-V1';

COMMIT;

/* Kontrollabfragen */
SELECT revision_id, revision_code, scope_reference, version_label, summary
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.4.3-V1';

SELECT section_id, section_code, title, status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.4.3';

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1)
ORDER BY definition_number;

SELECT lemma_number AS object_number, title, 'lemma' AS object_type, validation_status
FROM lemmas WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1)
UNION ALL
SELECT theorem_number, title, 'theorem', validation_status
FROM theorems WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1)
UNION ALL
SELECT corollary_number, title, 'corollary', validation_status
FROM corollaries WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1)
ORDER BY proof_number;

SELECT s.citation_number, s.short_citation_text, su.usage_type, su.exact_location
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.3' LIMIT 1)
ORDER BY s.citation_number;

SELECT counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
('last_equation_number_chapter_3','last_citation_number','last_completed_section_chapter_3','last_repository_revision')
ORDER BY counter_key;
