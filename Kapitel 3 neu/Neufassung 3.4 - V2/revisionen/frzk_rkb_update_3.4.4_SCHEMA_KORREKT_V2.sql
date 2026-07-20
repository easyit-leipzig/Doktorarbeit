/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.4
   Kapitel 3.4: Mathematische Rekonstruktion funktionaler Organisation
   Abschnitt 3.4.4: Funktionale Transformationen

   Verbindliche Schemagrundlage:
   - frzk_rkb_3.4.2.sql
   - korrigiertes Repository-Update zu Abschnitt 3.4.3

   Voraussetzung:
   - Abschnitt 3.4.3 wurde erfolgreich importiert
   - letzte Gleichung: (3.699)
   - letzte Literaturquelle: [109]

   Neu registriert:
   - Abschnitt 3.4.4
   - Gleichungen (3.700) bis (3.729)
   - Definitionen 3.4.8 bis 3.4.10
   - Lemma 3.4.4
   - Satz 3.4.4
   - Korollar 3.4.4
   - drei zugehörige Beweise beziehungsweise Begründungen
   - Gleichungssymbole und Symbolregister
   - Änderungsprotokoll und Repository-Zähler

   Keine neue Literaturquelle.
   Eigenschaften:
   - idempotent
   - keine fest vergebenen Primärschlüssel
   - statement_latex für Lemma/Satz/Korollar
   - proof_latex für Beweise
   - SQL-sichere Prime-Schreibweise z_F^{\prime}
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.4-V1';
SET @revision_date := NOW();

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.4.3-V1'
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
    '3.4.4',
    '1.0',
    'Mathematische Rekonstruktion funktionaler Transformationen, Transformationsrelationen, Fixpunkte, Komposition und Identität. Registriert werden die Gleichungen (3.700) bis (3.729), drei Definitionen, ein Lemma, ein Satz, ein Korollar sowie die zugehörigen Beweise.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code=@revision_code
);

SET @revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code=@revision_code
    LIMIT 1
);

SET @chapter_34_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4'
    LIMIT 1
);

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_34_id,
    '3.4.4',
    'Funktionale Transformationen',
    3,
    3.4040,
    'final',
    1,
    'Rekonstruktion eindeutiger funktionaler Zustandszuordnungen, der induzierten Transformationsrelation, funktionaler Fixpunkte sowie der Komposition und Identität funktionaler Transformationen.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code='3.4.4'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.700', @section_id, 'Funktionale Zustandsmenge', '\\Omega_F(\\mathcal{S})', '\\Omega_F(\\mathcal{S})',
    'Zustandsmenge der betrachteten funktionalen Organisation.', 'definition', 'original', NULL,
    'Aus Abschnitt 3.4.1 übernommen.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.700'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.701', @section_id, 'Allgemeine funktionale Zustandszuordnung', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Abbildung der funktionalen Zustandsmenge in sich selbst.', 'definition', 'original', NULL,
    'Vorbereitung der Transformationsdefinition.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.701'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.702', @section_id, 'Funktionale Transformation', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Formale Definition einer funktionalen Transformation.', 'definition', 'original', NULL,
    'Definition 3.4.8.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.702'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.703', @section_id, 'Bild eines funktionalen Zustands', 'z_F^{\\prime}=T_F(z_F)', 'z_F^{\\prime}=T_F(z_F)',
    'Der Zielzustand ist das Bild des Ausgangszustands unter T_F.', 'definition', 'original', NULL,
    'Definition 3.4.8.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.703'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.704', @section_id, 'Funktionale Abgeschlossenheit', 'z_F\\in\\Omega_F(\\mathcal{S})\\Longrightarrow T_F(z_F)\\in\\Omega_F(\\mathcal{S})', 'z_F\\in\\Omega_F(\\mathcal{S})\\Longrightarrow T_F(z_F)\\in\\Omega_F(\\mathcal{S})',
    'Interne Transformationen verlassen die zulässige Zustandsmenge nicht.', 'derived', 'original', NULL,
    'Aus Definition 3.4.8.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.704'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.705', @section_id, 'Transformiertes Zustandspaar', '\\left(z_F,T_F(z_F)\\right)', '\\left(z_F,T_F(z_F)\\right)',
    'Geordnetes Paar aus Ausgangs- und Zielzustand.', 'definition', 'original', NULL,
    'Verbindung zwischen Transformation und Relation.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.705'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.706', @section_id, 'Transformationsrelation', 'R_{T_F}:=\\left\\{\\left(z_F,T_F(z_F)\\right)\\middle|z_F\\in\\Omega_F(\\mathcal{S})\\right\\}', 'R_{T_F}:=\\left\\{\\left(z_F,T_F(z_F)\\right)\\middle|z_F\\in\\Omega_F(\\mathcal{S})\\right\\}',
    'Von einer funktionalen Transformation induzierte Relation.', 'definition', 'original', NULL,
    'Definition 3.4.9.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.706'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.707', @section_id, 'Transformationsrelation als Teilmenge', 'R_{T_F}\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', 'R_{T_F}\\subseteq\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    'Die Transformationsrelation liegt im kartesischen Produkt der Zustandsmenge.', 'derived', 'original', NULL,
    'Aus Definition 3.4.9.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.707'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.708', @section_id, 'Eindeutigkeit der Transformation', 'T_F(z_F)=z_F^{\\prime}\\land T_F(z_F)=z_F^{\\prime\\prime}\\Longrightarrow z_F^{\\prime}=z_F^{\\prime\\prime}', 'T_F(z_F)=z_F^{\\prime}\\land T_F(z_F)=z_F^{\\prime\\prime}\\Longrightarrow z_F^{\\prime}=z_F^{\\prime\\prime}',
    'Ein Ausgangszustand besitzt unter T_F genau ein Bild.', 'definition', 'original', NULL,
    'Abbildungseigenschaft.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.708'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.709', @section_id, 'Transformation im Lemma', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Voraussetzung von Lemma 3.4.4.', 'lemma', 'original', NULL,
    'Funktionale Transformation.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.709'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.710', @section_id, 'Relationselement einer Transformation', '\\left(z_F,T_F(z_F)\\right)\\in\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', '\\left(z_F,T_F(z_F)\\right)\\in\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    'Jede Transformation erzeugt ein geordnetes Zustandspaar im Zustandsprodukt.', 'lemma', 'original', NULL,
    'Beweis zu Lemma 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.710'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.711', @section_id, 'Menge möglicher Zielzustände', 'R_F^{+}(z_F)=\\left\\{z_F^{\\prime}\\in\\Omega_F(\\mathcal{S})\\middle|\\left(z_F,z_F^{\\prime}\\right)\\in R_F\\right\\}', 'R_F^{+}(z_F)=\\left\\{z_F^{\\prime}\\in\\Omega_F(\\mathcal{S})\\middle|\\left(z_F,z_F^{\\prime}\\right)\\in R_F\\right\\}',
    'Menge der von einem Zustand aus relational möglichen Zielzustände.', 'definition', 'original', NULL,
    'Aus Abschnitt 3.4.3 weitergeführt.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.711'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.712', @section_id, 'Transformierbarkeit einer Relation', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Durch eine eindeutige Relation bestimmte Transformation.', 'theorem', 'original', NULL,
    'Satz 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.712'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.713', @section_id, 'Relationiertes Ausgangs-Ziel-Paar', '\\left(z_F,z_F^{\\prime}\\right)\\in R_F', '\\left(z_F,z_F^{\\prime}\\right)\\in R_F',
    'Ein Zielzustand steht mit dem Ausgangszustand in funktionaler Relation.', 'theorem', 'original', NULL,
    'Kriterium von Satz 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.713'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.714', @section_id, 'Eindeutigkeitskriterium', '\\forall z_F\\in\\Omega_F(\\mathcal{S}):\\left|R_F^{+}(z_F)\\right|=1', '\\forall z_F\\in\\Omega_F(\\mathcal{S}):\\left|R_F^{+}(z_F)\\right|=1',
    'Jeder Ausgangszustand besitzt genau einen relationalen Zielzustand.', 'theorem', 'original', NULL,
    'Äquivalentes Kriterium von Satz 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.714'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.715', @section_id, 'Einelementige Zielmenge', '\\left|R_F^{+}(z_F)\\right|=1', '\\left|R_F^{+}(z_F)\\right|=1',
    'Die ausgehende Relationsmenge enthält genau ein Element.', 'theorem', 'original', NULL,
    'Erste Beweisrichtung von Satz 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.715'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.716', @section_id, 'Existierendes Relationspaar', '\\left(z_F,z_F^{\\prime}\\right)\\in R_F', '\\left(z_F,z_F^{\\prime}\\right)\\in R_F',
    'Voraussetzung der umgekehrten Beweisrichtung.', 'theorem', 'original', NULL,
    'Zweite Beweisrichtung von Satz 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.716'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.717', @section_id, 'Aus Relation definierte Transformation', 'T_F(z_F):=z_F^{\\prime}', 'T_F(z_F):=z_F^{\\prime}',
    'Eindeutige Definition der Transformation aus der Relation.', 'theorem', 'original', NULL,
    'Konstruktion im Beweis von Satz 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.717'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.718', @section_id, 'Invarianzbedingung', 'T_F(z_F)=z_F', 'T_F(z_F)=z_F',
    'Ein Zustand bleibt unter der Transformation unverändert.', 'definition', 'original', NULL,
    'Vorbereitung der Fixpunktdefinition.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.718'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.719', @section_id, 'Funktionaler Fixpunkt als Zustand', 'z_F^{*}\\in\\Omega_F(\\mathcal{S})', 'z_F^{*}\\in\\Omega_F(\\mathcal{S})',
    'Ein Fixpunkt gehört zur funktionalen Zustandsmenge.', 'definition', 'original', NULL,
    'Definition 3.4.10.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.719'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.720', @section_id, 'Fixpunktgleichung', 'T_F\\left(z_F^{*}\\right)=z_F^{*}', 'T_F\\left(z_F^{*}\\right)=z_F^{*}',
    'Ein Fixpunkt wird durch die Transformation auf sich selbst abgebildet.', 'definition', 'original', NULL,
    'Definition 3.4.10.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.720'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.721', @section_id, 'Fixpunktmenge', '\\operatorname{Fix}(T_F):=\\left\\{z_F\\in\\Omega_F(\\mathcal{S})\\middle|T_F(z_F)=z_F\\right\\}', '\\operatorname{Fix}(T_F):=\\left\\{z_F\\in\\Omega_F(\\mathcal{S})\\middle|T_F(z_F)=z_F\\right\\}',
    'Menge aller funktionalen Fixpunkte der Transformation.', 'definition', 'original', NULL,
    'Definition 3.4.10.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.721'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.722', @section_id, 'Zwei funktionale Transformationen', 'T_F^{(1)},T_F^{(2)}:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'T_F^{(1)},T_F^{(2)}:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Zwei Transformationen derselben funktionalen Zustandsmenge.', 'definition', 'original', NULL,
    'Vorbereitung der Komposition.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.722'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.723', @section_id, 'Komposition funktionaler Transformationen', '\\left(T_F^{(2)}\\circ T_F^{(1)}\\right)(z_F)=T_F^{(2)}\\left(T_F^{(1)}(z_F)\\right)', '\\left(T_F^{(2)}\\circ T_F^{(1)}\\right)(z_F)=T_F^{(2)}\\left(T_F^{(1)}(z_F)\\right)',
    'Nacheinanderausführung zweier funktionaler Transformationen.', 'definition', 'original', NULL,
    'Kompositionsdefinition.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.723'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.724', @section_id, 'Abgeschlossenheit der Komposition', 'T_F^{(2)}\\circ T_F^{(1)}:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', 'T_F^{(2)}\\circ T_F^{(1)}:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Die Komposition bildet die Zustandsmenge erneut in sich selbst ab.', 'derived', 'original', NULL,
    'Korollar 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.724'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.725', @section_id, 'Bild unter erster Transformation', 'T_F^{(1)}(z_F)\\in\\Omega_F(\\mathcal{S})', 'T_F^{(1)}(z_F)\\in\\Omega_F(\\mathcal{S})',
    'Das Ergebnis der ersten Transformation liegt in der Zustandsmenge.', 'corollary', 'original', NULL,
    'Begründung zu Korollar 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.725'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.726', @section_id, 'Bild unter der Komposition', 'T_F^{(2)}\\left(T_F^{(1)}(z_F)\\right)\\in\\Omega_F(\\mathcal{S})', 'T_F^{(2)}\\left(T_F^{(1)}(z_F)\\right)\\in\\Omega_F(\\mathcal{S})',
    'Auch das Ergebnis der zweiten Transformation liegt in der Zustandsmenge.', 'corollary', 'original', NULL,
    'Begründung zu Korollar 3.4.4.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.726'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.727', @section_id, 'Identitätstransformation', '\\operatorname{id}_{\\Omega_F}:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})', '\\operatorname{id}_{\\Omega_F}:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S})',
    'Neutrale Transformation der funktionalen Zustandsmenge.', 'definition', 'original', NULL,
    'Einführung der Identitätsabbildung.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.727'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.728', @section_id, 'Wirkung der Identität', '\\operatorname{id}_{\\Omega_F}(z_F)=z_F', '\\operatorname{id}_{\\Omega_F}(z_F)=z_F',
    'Die Identität lässt jeden Zustand unverändert.', 'definition', 'original', NULL,
    'Definition der Identitätsabbildung.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.728'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.729', @section_id, 'Neutralität der Identität', 'T_F\\circ\\operatorname{id}_{\\Omega_F}=\\operatorname{id}_{\\Omega_F}\\circ T_F=T_F', 'T_F\\circ\\operatorname{id}_{\\Omega_F}=\\operatorname{id}_{\\Omega_F}\\circ T_F=T_F',
    'Die Identität ist neutrales Element der Transformationskomposition.', 'derived', 'original', NULL,
    'Aus der Identitätsdefinition.', 'Abschnitt 3.4.4 und vorausgehende Rekonstruktion.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.729'
);


/* Referenzierte Gleichungen */
SET @eq_3702 := (SELECT equation_id FROM equations WHERE equation_number='3.702' LIMIT 1);
SET @eq_3706 := (SELECT equation_id FROM equations WHERE equation_number='3.706' LIMIT 1);
SET @eq_3720 := (SELECT equation_id FROM equations WHERE equation_number='3.720' LIMIT 1);
SET @eq_3721 := (SELECT equation_id FROM equations WHERE equation_number='3.721' LIMIT 1);
SET @eq_3723 := (SELECT equation_id FROM equations WHERE equation_number='3.723' LIMIT 1);
SET @eq_3727 := (SELECT equation_id FROM equations WHERE equation_number='3.727' LIMIT 1);

/* Definition 3.4.8 */
INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
SELECT
    '3.4.8',
    @section_id,
    'Funktionale Transformation',
    'Eine funktionale Transformation T_F ist eine Abbildung der funktionalen Zustandsmenge in sich selbst, die jedem funktionalen Ausgangszustand genau einen funktionalen Zielzustand zuordnet.',
    'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S}),\\qquad z_F^{\\prime}=T_F(z_F)',
    'T_F:\\Omega_F(\\mathcal{S})\\longrightarrow\\Omega_F(\\mathcal{S}),\\qquad z_F^{\\prime}=T_F(z_F)',
    'original',
    NULL,
    'Die funktionale Zustandsmenge aus Abschnitt 3.4.1 ist bestimmt.',
    'Eigene funktionale Spezifikation einer eindeutigen internen Zustandszuordnung.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions WHERE definition_number='3.4.8'
);

/* Definition 3.4.9 */
INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
SELECT
    '3.4.9',
    @section_id,
    'Transformationsrelation',
    'Die durch eine funktionale Transformation T_F erzeugte Menge aller geordneten Paare aus Ausgangszustand und eindeutig zugeordnetem Zielzustand heißt Transformationsrelation von T_F.',
    'R_{T_F}:=\\left\\{\\left(z_F,T_F(z_F)\\right)\\middle|z_F\\in\\Omega_F(\\mathcal{S})\\right\\}',
    'R_{T_F}:=\\left\\{\\left(z_F,T_F(z_F)\\right)\\middle|z_F\\in\\Omega_F(\\mathcal{S})\\right\\}',
    'original',
    NULL,
    'Definition 3.4.8 und die funktionale Relation aus Abschnitt 3.4.3.',
    'Eigene Verbindung zwischen funktionaler Abbildung und induzierter Relation.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions WHERE definition_number='3.4.9'
);

/* Definition 3.4.10 */
INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
SELECT
    '3.4.10',
    @section_id,
    'Funktionaler Fixpunkt',
    'Ein Zustand z_F^* heißt funktionaler Fixpunkt der Transformation T_F, wenn er durch T_F auf sich selbst abgebildet wird.',
    'z_F^{*}\\in\\Omega_F(\\mathcal{S}),\\qquad T_F\\left(z_F^{*}\\right)=z_F^{*}',
    'z_F^{*}\\in\\Omega_F(\\mathcal{S}),\\qquad T_F\\left(z_F^{*}\\right)=z_F^{*}',
    'original',
    NULL,
    'Definition 3.4.8.',
    'Die Fixpunktbedingung behauptet noch keine dynamische Stabilität.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM definitions WHERE definition_number='3.4.10'
);

/* Lemma 3.4.4 */
INSERT INTO lemmas
(
    lemma_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.4.4',
    @section_id,
    'Jede funktionale Transformation induziert eine funktionale Relation',
    'Für jede funktionale Transformation existiert eine durch sie eindeutig bestimmte Transformationsrelation.',
    'T_F:\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})\\Longrightarrow\\exists!\\,R_{T_F}=\\left\\{\\left(z_F,T_F(z_F)\\right)\\middle|z_F\\in\\Omega_F(\\mathcal{S})\\right\\}',
    'T_F:\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})\\Longrightarrow\\exists!\\,R_{T_F}=\\left\\{\\left(z_F,T_F(z_F)\\right)\\middle|z_F\\in\\Omega_F(\\mathcal{S})\\right\\}',
    'original',
    NULL,
    'Definitionen 3.4.8 und 3.4.9.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM lemmas WHERE lemma_number='3.4.4'
);

/* Satz 3.4.4 */
INSERT INTO theorems
(
    theorem_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
SELECT
    '3.4.4',
    @section_id,
    'Kriterium der Transformierbarkeit einer funktionalen Relation',
    'Eine funktionale Relation bestimmt genau dann eine funktionale Transformation, wenn jedem Ausgangszustand genau ein relationaler Zielzustand zugeordnet ist.',
    'R_F\\text{ bestimmt }T_F\\Longleftrightarrow\\forall z_F\\in\\Omega_F(\\mathcal{S}):\\left|R_F^{+}(z_F)\\right|=1',
    'R_F\\text{ bestimmt }T_F\\Longleftrightarrow\\forall z_F\\in\\Omega_F(\\mathcal{S}):\\left|R_F^{+}(z_F)\\right|=1',
    'original',
    NULL,
    'Definition 3.4.8 und die ausgehende Relationsmenge aus Abschnitt 3.4.3.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM theorems WHERE theorem_number='3.4.4'
);

SET @lemma_id :=
(
    SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.4' LIMIT 1
);

SET @theorem_id :=
(
    SELECT theorem_id FROM theorems WHERE theorem_number='3.4.4' LIMIT 1
);

/* Korollar 3.4.4 */
INSERT INTO corollaries
(
    corollary_number, section_id, title, statement_text,
    statement_latex, word_latex, parent_theorem_id, parent_lemma_id,
    provenance, source_id, validation_status, created_revision_id
)
SELECT
    '3.4.4',
    @section_id,
    'Abgeschlossenheit funktionaler Transformationen unter Komposition',
    'Die Komposition zweier funktionaler Transformationen derselben Zustandsmenge ist wiederum eine funktionale Transformation.',
    'T_F^{(1)},T_F^{(2)}:\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})\\Longrightarrow T_F^{(2)}\\circ T_F^{(1)}:\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})',
    'T_F^{(1)},T_F^{(2)}:\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})\\Longrightarrow T_F^{(2)}\\circ T_F^{(1)}:\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})',
    @theorem_id,
    NULL,
    'original',
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM corollaries WHERE corollary_number='3.4.4'
);

SET @corollary_id :=
(
    SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.4' LIMIT 1
);

/* Beweis zu Lemma 3.4.4 */
INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method,
    provenance, source_id, validation_status, created_revision_id
)
SELECT
    'B-3.4.4-L1',
    @section_id,
    NULL,
    @lemma_id,
    NULL,
    'Beweis zu Lemma 3.4.4',
    'Jeder funktionale Zustand besitzt unter T_F genau ein Bild innerhalb derselben Zustandsmenge. Deshalb ist für jeden Ausgangszustand genau ein geordnetes Paar aus Ausgangs- und Zielzustand bestimmt. Die Menge aller dieser Paare ist die eindeutig durch T_F festgelegte Transformationsrelation.',
    '\\forall z_F\\in\\Omega_F(\\mathcal{S})\\;\\exists!\\,T_F(z_F)\\in\\Omega_F(\\mathcal{S})\\Longrightarrow\\exists!\\,R_{T_F}',
    'direct',
    'original',
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM proofs WHERE proof_number='B-3.4.4-L1'
);

/* Beweis zu Satz 3.4.4 */
INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method,
    provenance, source_id, validation_status, created_revision_id
)
SELECT
    'B-3.4.4-S1',
    @section_id,
    @theorem_id,
    NULL,
    NULL,
    'Beweis zu Satz 3.4.4',
    'Ist R_F die Transformationsrelation einer funktionalen Transformation, enthält R_F^{+}(z_F) für jeden Ausgangszustand genau das eine Bild T_F(z_F). Gilt umgekehrt für jeden Zustand, dass R_F^{+}(z_F) genau ein Element enthält, kann dieses eindeutige Element als T_F(z_F) definiert werden. Dadurch entsteht eine eindeutige Abbildung der Zustandsmenge in sich selbst.',
    'R_F=R_{T_F}\\Longrightarrow\\forall z_F:\\left|R_F^{+}(z_F)\\right|=1;\\qquad\\forall z_F:\\left|R_F^{+}(z_F)\\right|=1\\Longrightarrow T_F(z_F):=z_F^{\\prime}',
    'equivalence',
    'original',
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM proofs WHERE proof_number='B-3.4.4-S1'
);

/* Begründung zu Korollar 3.4.4 */
INSERT INTO proofs
(
    proof_number, section_id, theorem_id, lemma_id, corollary_id,
    title, proof_text, proof_latex, proof_method,
    provenance, source_id, validation_status, created_revision_id
)
SELECT
    'B-3.4.4-K1',
    @section_id,
    NULL,
    NULL,
    @corollary_id,
    'Begründung zu Korollar 3.4.4',
    'Die erste Transformation bildet jeden Zustand in die funktionale Zustandsmenge ab. Deshalb kann die zweite Transformation auf das Ergebnis angewendet werden und liefert erneut genau einen Zustand derselben Zustandsmenge. Die Komposition erfüllt damit die Definition einer funktionalen Transformation.',
    'T_F^{(1)}(z_F)\\in\\Omega_F(\\mathcal{S})\\Longrightarrow T_F^{(2)}\\left(T_F^{(1)}(z_F)\\right)\\in\\Omega_F(\\mathcal{S})',
    'direct',
    'original',
    NULL,
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM proofs WHERE proof_number='B-3.4.4-K1'
);

/* Gleichungssymbole */
INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    @eq_3702,
    'T_F',
    'funktionale Transformation',
    'Eindeutige Abbildung der funktionalen Zustandsmenge in sich selbst.',
    NULL,
    '\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})',
    1
WHERE @eq_3702 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3702 AND symbol_latex='T_F'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    @eq_3706,
    'R_{T_F}',
    'Transformationsrelation',
    'Durch T_F induzierte Menge geordneter Ausgangs-Ziel-Paare.',
    NULL,
    '\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    1
WHERE @eq_3706 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3706 AND symbol_latex='R_{T_F}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    @eq_3720,
    'z_F^{*}',
    'funktionaler Fixpunkt',
    'Funktionaler Zustand, der unter T_F unverändert bleibt.',
    NULL,
    '\\Omega_F(\\mathcal{S})',
    1
WHERE @eq_3720 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3720 AND symbol_latex='z_F^{*}'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    @eq_3721,
    '\\operatorname{Fix}(T_F)',
    'Fixpunktmenge',
    'Menge aller Fixpunkte der funktionalen Transformation T_F.',
    NULL,
    '\\mathcal{P}(\\Omega_F(\\mathcal{S}))',
    1
WHERE @eq_3721 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3721 AND symbol_latex='\\operatorname{Fix}(T_F)'
);

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    @eq_3727,
    '\\operatorname{id}_{\\Omega_F}',
    'Identitätstransformation',
    'Neutrale funktionale Transformation, die jeden Zustand auf sich selbst abbildet.',
    NULL,
    '\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})',
    1
WHERE @eq_3727 IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM equation_symbols
    WHERE equation_id=@eq_3727 AND symbol_latex='\\operatorname{id}_{\\Omega_F}'
);

/* Symbolregister */
INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    'T_F',
    'T_F',
    'Funktionale Transformation',
    'Eindeutige interne Abbildung funktionaler Zustände auf funktionale Zielzustände.',
    'chapter',
    @section_id,
    @eq_3702,
    NULL,
    '\\Omega_F(\\mathcal{S})',
    '\\Omega_F(\\mathcal{S})',
    0,
    0,
    1,
    'Erstmalige formale Definition in Abschnitt 3.4.4.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='T_F'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    'R_{T_F}',
    'R_{T_F}',
    'Transformationsrelation',
    'Von einer funktionalen Transformation erzeugte Relation aus Ausgangs- und Zielzuständen.',
    'chapter',
    @section_id,
    @eq_3706,
    NULL,
    '\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    '\\{0,1\\}',
    0,
    0,
    0,
    'Erstmalige formale Definition in Abschnitt 3.4.4.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='R_{T_F}'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    'z_F^{*}',
    'z_F^{*}',
    'Funktionaler Fixpunkt',
    'Funktionaler Zustand, der von einer bestimmten Transformation auf sich selbst abgebildet wird.',
    'chapter',
    @section_id,
    @eq_3720,
    NULL,
    '\\Omega_F(\\mathcal{S})',
    '\\Omega_F(\\mathcal{S})',
    0,
    0,
    0,
    'Fixpunkt bedeutet noch nicht notwendig Stabilität.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='z_F^{*}'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{Fix}(T_F)',
    '\\operatorname{Fix}(T_F)',
    'Fixpunktmenge',
    'Menge aller funktionalen Fixpunkte einer Transformation.',
    'chapter',
    @section_id,
    @eq_3721,
    NULL,
    '\\mathcal{T}_F',
    '\\mathcal{P}(\\Omega_F(\\mathcal{S}))',
    0,
    0,
    1,
    'Erstmalige formale Definition in Abschnitt 3.4.4.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='\\operatorname{Fix}(T_F)'
);

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    '\\operatorname{id}_{\\Omega_F}',
    '\\operatorname{id}_{\\Omega_F}',
    'Identitätstransformation',
    'Neutrale Transformation der funktionalen Zustandsmenge.',
    'chapter',
    @section_id,
    @eq_3727,
    NULL,
    '\\Omega_F(\\mathcal{S})',
    '\\Omega_F(\\mathcal{S})',
    0,
    0,
    1,
    'Neutrales Element bezüglich der Komposition.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM symbols WHERE symbol_latex='\\operatorname{id}_{\\Omega_F}'
);

/* Änderungsprotokoll */
INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'created', 'section',
    '3.4.4',
    'Abschnitt 3.4.4 Funktionale Transformationen wurde neu angelegt.',
    NULL, 'final'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='section'
      AND object_reference='3.4.4'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equation',
    '3.700-3.729',
    'Dreißig Gleichungen zu funktionalen Transformationen wurden registriert.',
    NULL, '3.700 bis 3.729'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='equation'
      AND object_reference='3.700-3.729'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definition',
    '3.4.8-3.4.10',
    'Drei Definitionen wurden registriert.',
    NULL, 'Definitionen 3.4.8 bis 3.4.10'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='definition'
      AND object_reference='3.4.8-3.4.10'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'statement',
    '3.4.4',
    'Lemma 3.4.4, Satz 3.4.4 und Korollar 3.4.4 wurden registriert.',
    NULL, 'Lemma, Satz und Korollar'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='statement'
      AND object_reference='3.4.4'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'proof_added', 'proof',
    'B-3.4.4-*',
    'Drei Beweise beziehungsweise Begründungen wurden registriert.',
    NULL, 'B-3.4.4-L1, B-3.4.4-S1, B-3.4.4-K1'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='proof'
      AND object_reference='B-3.4.4-*'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'symbol_added', 'symbol',
    'T_F,R_{T_F},z_F^{*},Fix(T_F),id_{Omega_F}',
    'Neue Transformations-, Fixpunkt- und Identitätssymbole wurden registriert.',
    NULL, 'Symbolregister Abschnitt 3.4.4'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='symbol'
      AND object_reference='T_F,R_{T_F},z_F^{*},Fix(T_F),id_{Omega_F}'
);

/* Repository-Zähler */
INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('last_equation_number_chapter_3', '3.729')
ON DUPLICATE KEY UPDATE counter_value='3.729';

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('last_citation_number', '109')
ON DUPLICATE KEY UPDATE counter_value='109';

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('last_completed_section_chapter_3', '3.4.4')
ON DUPLICATE KEY UPDATE counter_value='3.4.4';

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('last_repository_revision', 'RKB-NEU-K3.4.4-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.4.4-V1';

COMMIT;

/* =====================================================================
   Kontrollabfragen
   ===================================================================== */

SELECT
    revision_id, revision_code, scope_reference, version_label, summary
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.4.4-V1';

SELECT
    section_id, section_code, title, status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.4.4';

SELECT
    equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT
    definition_number, title, validation_status
FROM definitions
WHERE section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
)
ORDER BY definition_number;

SELECT
    lemma_number AS object_number,
    title,
    'lemma' AS object_type,
    validation_status
FROM lemmas
WHERE section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
)

UNION ALL

SELECT
    theorem_number,
    title,
    'theorem',
    validation_status
FROM theorems
WHERE section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
)

UNION ALL

SELECT
    corollary_number,
    title,
    'corollary',
    validation_status
FROM corollaries
WHERE section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
);

SELECT
    proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
)
ORDER BY proof_number;

SELECT
    symbol_latex, symbol_name, scope_type, validation_status
FROM symbols
WHERE first_section_id=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.4'
    LIMIT 1
)
ORDER BY symbol_id;

SELECT
    counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_equation_number_chapter_3',
    'last_citation_number',
    'last_completed_section_chapter_3',
    'last_repository_revision'
)
ORDER BY counter_key;
