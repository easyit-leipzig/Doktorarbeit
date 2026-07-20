/* =====================================================================
   FRZK-RKB – Repository-Update zu Abschnitt 3.4.6
   Abschnitt: Funktionale Übergänge und Operatorfolgen

   Voraussetzung:
   - erfolgreicher Import bis einschließlich Abschnitt 3.4.5
   - letzte Gleichung vor diesem Update: (3.770)
   - letzte Literaturquelle: [109]

   Registriert:
   - Gleichungen (3.771) bis (3.821)
   - Definitionen 3.4.15 bis 3.4.20
   - Lemmas 3.4.6 und 3.4.7
   - Sätze 3.4.7 und 3.4.8
   - Korollare 3.4.7 und 3.4.8
   - sechs Beweise beziehungsweise Begründungen
   - zentrale Gleichungssymbole und Symbolregister
   - Änderungsprotokoll und Repository-Zähler

   Keine neue Literaturquelle.
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-NEU-K3.4.6-V1';

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.4.5-V1'
    LIMIT 1
);

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    @revision_code, NOW(), 'section', '3.4.6', '1.0',
    'Rekonstruktion funktionaler Übergänge, Operatorfolgen, Zustandsfolgen, Entwicklungspfade und der pfadgebundenen funktionalen Übergangsordnung.',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code
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
    @chapter_34_id, '3.4.6',
    'Funktionale Übergänge und Operatorfolgen',
    3, 3.4060, 'final', 1,
    'Rekonstruktion elementarer Übergänge, endlicher Operator- und Zustandsfolgen, funktionaler Entwicklungspfade sowie einer strikten pfadbezogenen Übergangsordnung.'
WHERE NOT EXISTS
(
    SELECT 1 FROM dissertation_sections WHERE section_code='3.4.6'
);

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.6'
    LIMIT 1
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.771', @section_id, 'Funktionaler Zustand an Position k', 'z_F^{(k)}\\in\\Omega_F(\\mathcal{S})', 'z_F^{(k)}\\in\\Omega_F(\\mathcal{S})',
    'Funktionaler Zustand an einer geordneten Position.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.771'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.772', @section_id, 'Funktionaler Operator an Position k', 'O_F^{(k)}\\in\\mathcal{O}_F(\\mathcal{S})', 'O_F^{(k)}\\in\\mathcal{O}_F(\\mathcal{S})',
    'Auf den Zustand wirkender funktionaler Operator.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.772'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.773', @section_id, 'Elementarer Zustandsübergang', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
    'Bestimmung des nachfolgenden Zustands.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.773'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.774', @section_id, 'Funktionaler Übergang', '\\tau_F^{(k)}:=\\left(z_F^{(k)},O_F^{(k)},z_F^{(k+1)}\\right)', '\\tau_F^{(k)}:=\\left(z_F^{(k)},O_F^{(k)},z_F^{(k+1)}\\right)',
    'Geordnetes Tripel aus Ausgangszustand, Operator und Zielzustand.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.774'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.775', @section_id, 'Übergangsbedingung', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
    'Konsistenzbedingung eines funktionalen Übergangs.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.775'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.776', @section_id, 'Komponenten des Übergangs', '\\text{Ausgangszustand},\\qquad\\text{Wirkungsoperator},\\qquad\\text{Zielzustand}', '\\text{Ausgangszustand},\\qquad\\text{Wirkungsoperator},\\qquad\\text{Zielzustand}',
    'Strukturelle Bestandteile eines Übergangs.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.776'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.777', @section_id, 'Funktionale Übergangsmenge', '\\mathcal{U}_F(\\mathcal{S}):=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F^{\\prime}=O_F(z_F)\\right\\}', '\\mathcal{U}_F(\\mathcal{S}):=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F^{\\prime}=O_F(z_F)\\right\\}',
    'Menge aller zulässigen funktionalen Übergänge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.777'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.778', @section_id, 'Einbettung der Übergangsmenge', '\\mathcal{U}_F(\\mathcal{S})\\subseteq\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', '\\mathcal{U}_F(\\mathcal{S})\\subseteq\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})',
    'Produktraum der Übergangskomponenten.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.778'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.779', @section_id, 'Erster Übergang einer Folge', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
    'Erster Schritt zweier aufeinanderfolgender Übergänge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.779'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.780', @section_id, 'Zweiter Übergang einer Folge', 'z_F^{(k+2)}=O_F^{(k+1)}\\left(z_F^{(k+1)}\\right)', 'z_F^{(k+2)}=O_F^{(k+1)}\\left(z_F^{(k+1)}\\right)',
    'Zweiter Schritt zweier aufeinanderfolgender Übergänge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.780'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.781', @section_id, 'Eingesetzte Übergangsfolge', 'z_F^{(k+2)}=O_F^{(k+1)}\\left(O_F^{(k)}\\left(z_F^{(k)}\\right)\\right)', 'z_F^{(k+2)}=O_F^{(k+1)}\\left(O_F^{(k)}\\left(z_F^{(k)}\\right)\\right)',
    'Verschachtelte Wirkung zweier Operatoren.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.781'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.782', @section_id, 'Komponierte Übergangsfolge', 'z_F^{(k+2)}=\\left(O_F^{(k+1)}\\circ O_F^{(k)}\\right)\\left(z_F^{(k)}\\right)', 'z_F^{(k+2)}=\\left(O_F^{(k+1)}\\circ O_F^{(k)}\\right)\\left(z_F^{(k)}\\right)',
    'Darstellung durch Operatorkomposition.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.782'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.783', @section_id, 'Funktionale Operatorfolge', '\\mathbf{O}_F^{[n]}:=\\left(O_F^{(0)},O_F^{(1)},\\dots,O_F^{(n-1)}\\right)', '\\mathbf{O}_F^{[n]}:=\\left(O_F^{(0)},O_F^{(1)},\\dots,O_F^{(n-1)}\\right)',
    'Geordnetes Tupel funktionaler Operatoren.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.783'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.784', @section_id, 'Zulässigkeit der Operatorfolgenkomponenten', 'O_F^{(k)}\\in\\mathcal{O}_F(\\mathcal{S})\\qquad\\text{für}\\qquad k=0,\\dots,n-1', 'O_F^{(k)}\\in\\mathcal{O}_F(\\mathcal{S})\\qquad\\text{für}\\qquad k=0,\\dots,n-1',
    'Jedes Folgenelement gehört zum Operatorraum.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.784'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.785', @section_id, 'Gesamttransformation einer Operatorfolge', '\\Phi_F^{[n]}:=O_F^{(n-1)}\\circ O_F^{(n-2)}\\circ\\dots\\circ O_F^{(0)}', '\\Phi_F^{[n]}:=O_F^{(n-1)}\\circ O_F^{(n-2)}\\circ\\dots\\circ O_F^{(0)}',
    'Komposition aller Operatoren einer endlichen Folge.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.785'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.786', @section_id, 'Endzustand einer Operatorfolge', 'z_F^{(n)}=\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)', 'z_F^{(n)}=\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)',
    'Anwendung der Gesamttransformation auf den Anfangszustand.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.786'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.787', @section_id, 'Unterschiedliche Gesamttransformationen', '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}', '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}',
    'Verschiedene Operatorreihenfolgen können verschiedene Gesamttransformationen erzeugen.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.787'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.788', @section_id, 'Pfadabhängige Endzustände', '\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)\\neq\\widetilde{\\Phi}_F^{[n]}\\left(z_F^{(0)}\\right)', '\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)\\neq\\widetilde{\\Phi}_F^{[n]}\\left(z_F^{(0)}\\right)',
    'Unterschiedliche Operatorfolgen können aus demselben Anfangszustand verschiedene Endzustände erzeugen.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.788'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.789', @section_id, 'Operatorfolge im Lemma', '\\mathbf{O}_F^{[n]}=\\left(O_F^{(0)},\\dots,O_F^{(n-1)}\\right)', '\\mathbf{O}_F^{[n]}=\\left(O_F^{(0)},\\dots,O_F^{(n-1)}\\right)',
    'Voraussetzung von Lemma 3.4.6.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.789'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.790', @section_id, 'Von einer Operatorfolge erzeugte Transformation', '\\Phi_F^{[n]}\\in\\mathcal{T}_F(\\mathcal{S})', '\\Phi_F^{[n]}\\in\\mathcal{T}_F(\\mathcal{S})',
    'Aussage von Lemma 3.4.6.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.790'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.791', @section_id, 'Komposition der Operatorfolge', 'O_F^{(n-1)}\\circ\\dots\\circ O_F^{(0)}', 'O_F^{(n-1)}\\circ\\dots\\circ O_F^{(0)}',
    'Zusammengesetzter Operator im Beweis.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.791'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.792', @section_id, 'Funktionale Zustandsfolge', '\\mathbf{Z}_F^{[n]}:=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)', '\\mathbf{Z}_F^{[n]}:=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
    'Geordnetes Tupel aufeinanderfolgender Zustände.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.792'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.793', @section_id, 'Konsistenz einer Zustandsfolge', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
    'Jeder Folgezustand entsteht durch einen funktionalen Operator.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.793'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.794', @section_id, 'Funktionaler Entwicklungspfad', '\\Gamma_F^{[n]}:=\\left(z_F^{(0)},O_F^{(0)},z_F^{(1)},O_F^{(1)},\\dots,O_F^{(n-1)},z_F^{(n)}\\right)', '\\Gamma_F^{[n]}:=\\left(z_F^{(0)},O_F^{(0)},z_F^{(1)},O_F^{(1)},\\dots,O_F^{(n-1)},z_F^{(n)}\\right)',
    'Vollständige Folge aus Zuständen und Operatoren.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.794'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.795', @section_id, 'Pfadbedingung', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
    'Konsistenzbedingung eines funktionalen Entwicklungspfads.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.795'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.796', @section_id, 'Gleicher Anfang zweier Pfade', 'z_F^{(0)}=\\widetilde{z}_F^{(0)}', 'z_F^{(0)}=\\widetilde{z}_F^{(0)}',
    'Zwei Pfade beginnen im selben Zustand.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.796'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.797', @section_id, 'Gleiches Ende zweier Pfade', 'z_F^{(n)}=\\widetilde{z}_F^{(m)}', 'z_F^{(n)}=\\widetilde{z}_F^{(m)}',
    'Zwei Pfade enden im selben Zustand.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.797'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.798', @section_id, 'Verschiedene Entwicklungspfade', '\\Gamma_F^{[n]}\\neq\\widetilde{\\Gamma}_F^{[m]}', '\\Gamma_F^{[n]}\\neq\\widetilde{\\Gamma}_F^{[m]}',
    'Strukturell verschiedene Pfade können gleiche Randzustände besitzen.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.798'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.799', @section_id, 'Endzustandsabhängigkeit', 'z_F^{(n)}=\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)', 'z_F^{(n)}=\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)',
    'Der Endzustand hängt von Gesamttransformation und Anfangszustand ab.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.799'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.800', @section_id, 'Verschiedene Anfangszustände', 'z_F^{(0)}\\neq\\widetilde{z}_F^{(0)}', 'z_F^{(0)}\\neq\\widetilde{z}_F^{(0)}',
    'Unterschiedliche Ausgangslagen.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.800'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.801', @section_id, 'Anfangszustandsabhängige Ergebnisse', '\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)\\neq\\Phi_F^{[n]}\\left(\\widetilde{z}_F^{(0)}\\right)', '\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)\\neq\\Phi_F^{[n]}\\left(\\widetilde{z}_F^{(0)}\\right)',
    'Gleiche Gesamttransformation kann unterschiedliche Endzustände erzeugen.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.801'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.802', @section_id, 'Anfangszustand im Bestimmtheitssatz', 'z_F^{(0)}\\in\\Omega_F(\\mathcal{S})', 'z_F^{(0)}\\in\\Omega_F(\\mathcal{S})',
    'Voraussetzung von Satz 3.4.7.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.802'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.803', @section_id, 'Operatorfolge im Bestimmtheitssatz', '\\mathbf{O}_F^{[n]}=\\left(O_F^{(0)},\\dots,O_F^{(n-1)}\\right)', '\\mathbf{O}_F^{[n]}=\\left(O_F^{(0)},\\dots,O_F^{(n-1)}\\right)',
    'Zweite Voraussetzung von Satz 3.4.7.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.803'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.804', @section_id, 'Eindeutiger erster Folgezustand', 'z_F^{(1)}=O_F^{(0)}\\left(z_F^{(0)}\\right)', 'z_F^{(1)}=O_F^{(0)}\\left(z_F^{(0)}\\right)',
    'Induktionsanfang des Bestimmtheitsbeweises.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.804'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.805', @section_id, 'Eindeutiger nächster Folgezustand', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)', 'z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
    'Induktionsschritt des Bestimmtheitsbeweises.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.805'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.806', @section_id, 'Eindeutig bestimmte Zustände', 'z_F^{(1)},z_F^{(2)},\\dots,z_F^{(n)}', 'z_F^{(1)},z_F^{(2)},\\dots,z_F^{(n)}',
    'Ergebnis der vollständigen Induktion.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.806'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.807', @section_id, 'Verschiedene Gesamttransformationen im Korollar', '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}', '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}',
    'Unvollständige Operatorinformation erlaubt mehrere Entwicklungen.', 'corollary', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.807'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.808', @section_id, 'Verschiedene Endzustände im Korollar', '\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)\\neq\\widetilde{\\Phi}_F^{[n]}\\left(z_F^{(0)}\\right)', '\\Phi_F^{[n]}\\left(z_F^{(0)}\\right)\\neq\\widetilde{\\Phi}_F^{[n]}\\left(z_F^{(0)}\\right)',
    'Folgerung für denselben Anfangszustand.', 'corollary', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.808'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.809', @section_id, 'Funktionale Vorordnungsschreibweise', 'z_F^{(i)}\\prec_F z_F^{(j)}', 'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Formale Schreibweise einer funktionalen Vorher-Nachher-Beziehung.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.809'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.810', @section_id, 'Funktionale Übergangsordnung', 'z_F^{(i)}\\prec_F z_F^{(j)}', 'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Definition der pfadbezogenen Übergangsordnung.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.810'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.811', @section_id, 'Indexbedingung der Übergangsordnung', 'i<j', 'i<j',
    'Ordnungsbedingung für zwei Zustandspositionen.', 'definition', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.811'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.812', @section_id, 'Erste Indexrelation', 'i<j', 'i<j',
    'Erste Voraussetzung der Transitivität.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.812'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.813', @section_id, 'Zweite Indexrelation', 'j<k', 'j<k',
    'Zweite Voraussetzung der Transitivität.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.813'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.814', @section_id, 'Transitive Indexrelation', 'i<k', 'i<k',
    'Folgerung aus der Transitivität der natürlichen Ordnung.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.814'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.815', @section_id, 'Transitivität der Übergangsordnung', 'z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}', 'z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}',
    'Aussage von Lemma 3.4.7.', 'lemma', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.815'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.816', @section_id, 'Irreflexivität der Indexordnung', 'i\\nless i', 'i\\nless i',
    'Kein Index liegt strikt vor sich selbst.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.816'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.817', @section_id, 'Irreflexivität der Übergangsordnung', 'z_F^{(i)}\\not\\prec_F z_F^{(i)}', 'z_F^{(i)}\\not\\prec_F z_F^{(i)}',
    'Kein Zustand liegt im selben Pfad strikt vor sich selbst.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.817'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.818', @section_id, 'Asymmetrie der Übergangsordnung', 'z_F^{(i)}\\prec_F z_F^{(j)}\\Longrightarrow z_F^{(j)}\\not\\prec_F z_F^{(i)}', 'z_F^{(i)}\\prec_F z_F^{(j)}\\Longrightarrow z_F^{(j)}\\not\\prec_F z_F^{(i)}',
    'Gerichtete Ordnung entlang eines Pfads.', 'theorem', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.818'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.819', @section_id, 'Erste Unvergleichbarkeit', 'z_F\\not\\prec_F z_F^{\\prime}', 'z_F\\not\\prec_F z_F^{\\prime}',
    'Keine gerichtete Ordnung vom ersten zum zweiten Zustand.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.819'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.820', @section_id, 'Zweite Unvergleichbarkeit', 'z_F^{\\prime}\\not\\prec_F z_F', 'z_F^{\\prime}\\not\\prec_F z_F',
    'Keine gerichtete Ordnung vom zweiten zum ersten Zustand.', 'derived', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.820'
);

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
SELECT
    '3.821', @section_id, 'Ordnung ohne Dauer', 'z_F^{(i)}\\prec_F z_F^{(j)}', 'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Die Übergangsordnung bestimmt Reihenfolge, aber keine metrische Dauer.', 'corollary', 'original', NULL,
    'Eigene mathematische Rekonstruktion in Abschnitt 3.4.6.',
    'Die Zustands-, Transformations- und Operatorstrukturen der Abschnitte 3.4.1 bis 3.4.5 werden vorausgesetzt.',
    'checked', @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.821'
);


/* Definitionen 3.4.15 bis 3.4.20 */
INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.15', @section_id, 'Funktionaler Übergang',
       'Ein funktionaler Übergang ist ein geordnetes Tripel aus Ausgangszustand, wirkendem Operator und Zielzustand, wobei der Zielzustand das Bild des Ausgangszustands unter dem Operator ist.',
       '\\tau_F^{(k)}:=\\left(z_F^{(k)},O_F^{(k)},z_F^{(k+1)}\\right),\\qquad z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
       '\\tau_F^{(k)}:=\\left(z_F^{(k)},O_F^{(k)},z_F^{(k+1)}\\right),\\qquad z_F^{(k+1)}=O_F^{(k)}\\left(z_F^{(k)}\\right)',
       'original', NULL, 'Definitionen der funktionalen Zustände und Operatoren.',
       'Der Index bezeichnet zunächst nur eine Ordnungsposition und noch keine physikalische Zeit.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.15');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.16', @section_id, 'Funktionale Übergangsmenge',
       'Die Menge aller zulässigen funktionalen Übergänge einer Organisation heißt funktionale Übergangsmenge.',
       '\\mathcal{U}_F(\\mathcal{S}):=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F^{\\prime}=O_F(z_F)\\right\\}',
       '\\mathcal{U}_F(\\mathcal{S}):=\\left\\{\\left(z_F,O_F,z_F^{\\prime}\\right)\\middle|z_F^{\\prime}=O_F(z_F)\\right\\}',
       'original', NULL, 'Definition 3.4.15.',
       'Erfasst die elementaren Bausteine funktionaler Entwicklung.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.16');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.17', @section_id, 'Funktionale Operatorfolge',
       'Eine endliche funktionale Operatorfolge ist ein geordnetes Tupel zulässiger funktionaler Operatoren.',
       '\\mathbf{O}_F^{[n]}:=\\left(O_F^{(0)},O_F^{(1)},\\dots,O_F^{(n-1)}\\right)',
       '\\mathbf{O}_F^{[n]}:=\\left(O_F^{(0)},O_F^{(1)},\\dots,O_F^{(n-1)}\\right)',
       'original', NULL, 'Definition 3.4.12.',
       'Die Reihenfolge der Operatoren ist wegen möglicher Nichtkommutativität strukturell relevant.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.17');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.18', @section_id, 'Funktionale Zustandsfolge',
       'Eine funktionale Zustandsfolge ist ein geordnetes Tupel funktionaler Zustände, bei dem jeder nachfolgende Zustand durch einen zulässigen Operator aus seinem Vorgänger hervorgeht.',
       '\\mathbf{Z}_F^{[n]}:=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
       '\\mathbf{Z}_F^{[n]}:=\\left(z_F^{(0)},z_F^{(1)},\\dots,z_F^{(n)}\\right)',
       'original', NULL, 'Definitionen 3.4.15 und 3.4.17.',
       'Die Folge beschreibt geordnete funktionale Entwicklung.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.18');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.19', @section_id, 'Funktionaler Entwicklungspfad',
       'Ein funktionaler Entwicklungspfad ist eine alternierende Folge aus Zuständen und Operatoren, in der jeder Zielzustand durch den unmittelbar vorangehenden Operator aus dem vorangehenden Zustand hervorgeht.',
       '\\Gamma_F^{[n]}:=\\left(z_F^{(0)},O_F^{(0)},z_F^{(1)},\\dots,O_F^{(n-1)},z_F^{(n)}\\right)',
       '\\Gamma_F^{[n]}:=\\left(z_F^{(0)},O_F^{(0)},z_F^{(1)},\\dots,O_F^{(n-1)},z_F^{(n)}\\right)',
       'original', NULL, 'Definitionen 3.4.17 und 3.4.18.',
       'Der Entwicklungspfad enthält sowohl Zustände als auch die erzeugenden Operatoren.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.19');

INSERT INTO definitions
(definition_number, section_id, title, definition_text, formal_latex, word_latex,
 provenance, source_id, assumptions, notes, validation_status, created_revision_id)
SELECT '3.4.20', @section_id, 'Funktionale Übergangsordnung',
       'Innerhalb eines funktionalen Entwicklungspfads liegt ein Zustand funktional vor einem anderen, wenn seine Indexposition kleiner ist.',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\Longleftrightarrow i<j',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\Longleftrightarrow i<j',
       'original', NULL, 'Definition 3.4.19 und natürliche Ordnung der Indizes.',
       'Die Ordnung enthält noch keine metrische Dauer und keine physikalische Zeit.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM definitions WHERE definition_number='3.4.20');

/* Lemmas */
INSERT INTO lemmas
(lemma_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.6', @section_id, 'Jede endliche Operatorfolge erzeugt eine funktionale Transformation',
       'Jede endliche Folge funktionaler Operatoren bestimmt durch Komposition eine eindeutig bestimmte funktionale Transformation.',
       '\\mathbf{O}_F^{[n]}=\\left(O_F^{(0)},\\dots,O_F^{(n-1)}\\right)\\Longrightarrow\\Phi_F^{[n]}\\in\\mathcal{T}_F(\\mathcal{S})',
       '\\mathbf{O}_F^{[n]}=\\left(O_F^{(0)},\\dots,O_F^{(n-1)}\\right)\\Longrightarrow\\Phi_F^{[n]}\\in\\mathcal{T}_F(\\mathcal{S})',
       'original', NULL, 'Lemma 3.4.5 und Definition 3.4.17.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='3.4.6');

INSERT INTO lemmas
(lemma_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.7', @section_id, 'Transitivität der funktionalen Übergangsordnung',
       'Die funktionale Übergangsordnung ist innerhalb eines gegebenen Entwicklungspfads transitiv.',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\land z_F^{(j)}\\prec_F z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}',
       'original', NULL, 'Definition 3.4.20 und Transitivität der natürlichen Indexordnung.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM lemmas WHERE lemma_number='3.4.7');

/* Sätze */
INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.7', @section_id, 'Bestimmtheit eines funktionalen Entwicklungspfads',
       'Ein gegebener Anfangszustand und eine vollständige endliche Operatorfolge bestimmen die zugehörige funktionale Zustandsfolge eindeutig.',
       'z_F^{(0)}\\land\\mathbf{O}_F^{[n]}\\Longrightarrow\\exists!\\,\\mathbf{Z}_F^{[n]}',
       'z_F^{(0)}\\land\\mathbf{O}_F^{[n]}\\Longrightarrow\\exists!\\,\\mathbf{Z}_F^{[n]}',
       'original', NULL, 'Definitionen 3.4.17 bis 3.4.19 und Abbildungseigenschaft der Operatoren.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.7');

INSERT INTO theorems
(theorem_number, section_id, title, statement_text, statement_latex, word_latex,
 provenance, source_id, assumptions, validation_status, created_revision_id)
SELECT '3.4.8', @section_id, 'Strikte Ordnung funktionaler Zustände entlang eines Entwicklungspfads',
       'Die funktionale Übergangsordnung ist innerhalb eines gegebenen Entwicklungspfads irreflexiv, asymmetrisch und transitiv und bildet daher eine strikte Ordnung der Zustandspositionen.',
       '\\operatorname{Irreflexivitaet}(\\prec_F)\\land\\operatorname{Asymmetrie}(\\prec_F)\\land\\operatorname{Transitivitaet}(\\prec_F)',
       '\\operatorname{Irreflexivitaet}(\\prec_F)\\land\\operatorname{Asymmetrie}(\\prec_F)\\land\\operatorname{Transitivitaet}(\\prec_F)',
       'original', NULL, 'Definition 3.4.20 und Lemma 3.4.7.',
       'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM theorems WHERE theorem_number='3.4.8');

SET @lemma_346_id := (SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.6' LIMIT 1);
SET @lemma_347_id := (SELECT lemma_id FROM lemmas WHERE lemma_number='3.4.7' LIMIT 1);
SET @theorem_347_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.7' LIMIT 1);
SET @theorem_348_id := (SELECT theorem_id FROM theorems WHERE theorem_number='3.4.8' LIMIT 1);

/* Korollare */
INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex, word_latex,
 parent_theorem_id, parent_lemma_id, provenance, source_id, validation_status, created_revision_id)
SELECT '3.4.7', @section_id, 'Nichtbestimmtheit ohne vollständige Operatorfolge',
       'Ist nur der Anfangszustand bekannt, nicht aber die vollständige Operatorfolge, so ist ein späterer Zustand im Allgemeinen nicht eindeutig bestimmt.',
       '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}\\Longrightarrow\\Phi_F^{[n]}(z_F^{(0)})\\neq\\widetilde{\\Phi}_F^{[n]}(z_F^{(0)})',
       '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}\\Longrightarrow\\Phi_F^{[n]}(z_F^{(0)})\\neq\\widetilde{\\Phi}_F^{[n]}(z_F^{(0)})',
       @theorem_347_id, NULL, 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.7');

INSERT INTO corollaries
(corollary_number, section_id, title, statement_text, statement_latex, word_latex,
 parent_theorem_id, parent_lemma_id, provenance, source_id, validation_status, created_revision_id)
SELECT '3.4.8', @section_id, 'Übergangsordnung erzeugt noch keine vollständige Zeitstruktur',
       'Die funktionale Übergangsordnung bestimmt innerhalb eines Entwicklungspfads ein Vorher und Nachher, aber noch keine Dauer, Geschwindigkeit oder physikalische Zeit.',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\Longrightarrow\\operatorname{Reihenfolge},\\quad\\text{nicht notwendig Dauer}',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\Longrightarrow\\operatorname{Reihenfolge},\\quad\\text{nicht notwendig Dauer}',
       @theorem_348_id, NULL, 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM corollaries WHERE corollary_number='3.4.8');

SET @corollary_347_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.7' LIMIT 1);
SET @corollary_348_id := (SELECT corollary_id FROM corollaries WHERE corollary_number='3.4.8' LIMIT 1);

/* Beweise und Begründungen */
INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.6-L1', @section_id, NULL, @lemma_346_id, NULL,
       'Beweis zu Lemma 3.4.6',
       'Jeder funktionale Operator bildet die Zustandsmenge in sich selbst ab. Da der Operatorraum unter Komposition abgeschlossen ist, ist auch die endliche Komposition aller Folgenelemente ein funktionaler Operator und erzeugt eine eindeutig bestimmte funktionale Transformation.',
       'O_F^{(n-1)}\\circ\\dots\\circ O_F^{(0)}\\in\\mathcal{O}_F(\\mathcal{S})\\Longrightarrow\\Phi_F^{[n]}\\in\\mathcal{T}_F(\\mathcal{S})',
       'induction', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.6-L1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.6-S1', @section_id, @theorem_347_id, NULL, NULL,
       'Beweis zu Satz 3.4.7',
       'Der erste Folgezustand ist durch den ersten Operator eindeutig bestimmt. Ist ein Zustand der Folge eindeutig bestimmt, erzeugt der nächste Operator wiederum genau einen Nachfolgezustand. Durch vollständige Induktion ist die gesamte Zustandsfolge eindeutig bestimmt.',
       'z_F^{(1)}=O_F^{(0)}(z_F^{(0)}),\\qquad z_F^{(k+1)}=O_F^{(k)}(z_F^{(k)})',
       'induction', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.6-S1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.6-K1', @section_id, NULL, NULL, @corollary_347_id,
       'Begründung zu Korollar 3.4.7',
       'Unterschiedliche zulässige Operatorfolgen können unterschiedliche Gesamttransformationen und damit für denselben Anfangszustand verschiedene Endzustände erzeugen. Ohne vollständige Operatorfolge ist die Entwicklung daher im Allgemeinen nicht eindeutig.',
       '\\Phi_F^{[n]}\\neq\\widetilde{\\Phi}_F^{[n]}\\Longrightarrow\\Phi_F^{[n]}(z_F^{(0)})\\neq\\widetilde{\\Phi}_F^{[n]}(z_F^{(0)})',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.6-K1');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.6-L2', @section_id, NULL, @lemma_347_id, NULL,
       'Beweis zu Lemma 3.4.7',
       'Die funktionale Übergangsordnung wird durch die natürliche Ordnung der Indizes definiert. Aus i kleiner j und j kleiner k folgt wegen der Transitivität der natürlichen Ordnung i kleiner k. Daher ist auch die funktionale Übergangsordnung transitiv.',
       'i<j\\land j<k\\Longrightarrow i<k\\Longrightarrow z_F^{(i)}\\prec_F z_F^{(k)}',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.6-L2');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.6-S2', @section_id, @theorem_348_id, NULL, NULL,
       'Beweis zu Satz 3.4.8',
       'Irreflexivität folgt daraus, dass kein Index kleiner als er selbst ist. Asymmetrie folgt daraus, dass aus i kleiner j nicht zugleich j kleiner i gelten kann. Die Transitivität wurde in Lemma 3.4.7 gezeigt. Damit liegt eine strikte Ordnung vor.',
       'i\\nless i,\\qquad i<j\\Longrightarrow j\\nless i,\\qquad i<j\\land j<k\\Longrightarrow i<k',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.6-S2');

INSERT INTO proofs
(proof_number, section_id, theorem_id, lemma_id, corollary_id, title,
 proof_text, proof_latex, proof_method, provenance, source_id, validation_status, created_revision_id)
SELECT 'B-3.4.6-K2', @section_id, NULL, NULL, @corollary_348_id,
       'Begründung zu Korollar 3.4.8',
       'Die Übergangsordnung wird ausschließlich aus der Reihenfolge diskreter Indexpositionen gebildet. Sie enthält weder eine Abbildung in eine metrische Zeitmenge noch ein Maß für die Dauer zwischen Zuständen.',
       'z_F^{(i)}\\prec_F z_F^{(j)}\\Longrightarrow i<j,\\qquad\\text{keine metrische Dauer bestimmt}',
       'direct', 'original', NULL, 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE proof_number='B-3.4.6-K2');

/* Zentrale Gleichungsreferenzen */
SET @eq_3774 := (SELECT equation_id FROM equations WHERE equation_number='3.774' LIMIT 1);
SET @eq_3777 := (SELECT equation_id FROM equations WHERE equation_number='3.777' LIMIT 1);
SET @eq_3783 := (SELECT equation_id FROM equations WHERE equation_number='3.783' LIMIT 1);
SET @eq_3785 := (SELECT equation_id FROM equations WHERE equation_number='3.785' LIMIT 1);
SET @eq_3792 := (SELECT equation_id FROM equations WHERE equation_number='3.792' LIMIT 1);
SET @eq_3794 := (SELECT equation_id FROM equations WHERE equation_number='3.794' LIMIT 1);
SET @eq_3810 := (SELECT equation_id FROM equations WHERE equation_number='3.810' LIMIT 1);

/* Gleichungssymbole */
INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3774, '\\tau_F^{(k)}', 'funktionaler Übergang',
       'Tripel aus Ausgangszustand, Operator und Zielzustand.', NULL,
       '\\Omega_F(\\mathcal{S})\\times\\mathcal{O}_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', 1
WHERE @eq_3774 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3774 AND symbol_latex='\\tau_F^{(k)}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3777, '\\mathcal{U}_F(\\mathcal{S})', 'funktionale Übergangsmenge',
       'Menge aller zulässigen funktionalen Übergänge.', NULL,
       '\\mathcal{P}(\\Omega_F\\times\\mathcal{O}_F\\times\\Omega_F)', 1
WHERE @eq_3777 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3777 AND symbol_latex='\\mathcal{U}_F(\\mathcal{S})');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3783, '\\mathbf{O}_F^{[n]}', 'funktionale Operatorfolge',
       'Geordnetes Tupel funktionaler Operatoren.', NULL,
       '\\mathcal{O}_F(\\mathcal{S})^n', 1
WHERE @eq_3783 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3783 AND symbol_latex='\\mathbf{O}_F^{[n]}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3785, '\\Phi_F^{[n]}', 'Gesamttransformation',
       'Komposition einer endlichen funktionalen Operatorfolge.', NULL,
       '\\Omega_F(\\mathcal{S})\\to\\Omega_F(\\mathcal{S})', 1
WHERE @eq_3785 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3785 AND symbol_latex='\\Phi_F^{[n]}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3792, '\\mathbf{Z}_F^{[n]}', 'funktionale Zustandsfolge',
       'Geordnetes Tupel der durch eine Operatorfolge erzeugten Zustände.', NULL,
       '\\Omega_F(\\mathcal{S})^{n+1}', 1
WHERE @eq_3792 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3792 AND symbol_latex='\\mathbf{Z}_F^{[n]}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3794, '\\Gamma_F^{[n]}', 'funktionaler Entwicklungspfad',
       'Alternierende Folge aus funktionalen Zuständen und Operatoren.', NULL,
       '\\Omega_F\\times(\\mathcal{O}_F\\times\\Omega_F)^n', 1
WHERE @eq_3794 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3794 AND symbol_latex='\\Gamma_F^{[n]}');

INSERT INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
SELECT @eq_3810, '\\prec_F', 'funktionale Übergangsordnung',
       'Strikte pfadbezogene Vorher-Nachher-Relation funktionaler Zustände.', NULL,
       '\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', 1
WHERE @eq_3810 IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM equation_symbols WHERE equation_id=@eq_3810 AND symbol_latex='\\prec_F');

/* Symbolregister */
INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\tau_F^{(k)}', '\\tau_F^{(k)}', 'Funktionaler Übergang',
       'Geordnetes Tripel aus Ausgangszustand, funktionalem Operator und Zielzustand.',
       'chapter', @section_id, @eq_3774, NULL,
       '\\Omega_F\\times\\mathcal{O}_F\\times\\Omega_F', '\\mathcal{U}_F(\\mathcal{S})',
       0, 0, 0, 'Elementarer Baustein funktionaler Entwicklung.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\tau_F^{(k)}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathcal{U}_F(\\mathcal{S})', '\\mathcal{U}_F(\\mathcal{S})', 'Funktionale Übergangsmenge',
       'Menge aller zulässigen funktionalen Übergänge einer Organisation.',
       'chapter', @section_id, @eq_3777, NULL,
       '\\mathcal{S}', '\\mathcal{P}(\\Omega_F\\times\\mathcal{O}_F\\times\\Omega_F)',
       0, 0, 0, 'Erstmalige Definition in Abschnitt 3.4.6.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathcal{U}_F(\\mathcal{S})');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathbf{O}_F^{[n]}', '\\mathbf{O}_F^{[n]}', 'Funktionale Operatorfolge',
       'Geordnetes Tupel von n funktionalen Operatoren.',
       'chapter', @section_id, @eq_3783, NULL,
       '\\mathbb{N}\\times\\mathcal{O}_F(\\mathcal{S})', '\\mathcal{O}_F(\\mathcal{S})^n',
       0, 0, 0, 'Reihenfolge ist im Allgemeinen wirkungsrelevant.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathbf{O}_F^{[n]}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\Phi_F^{[n]}', '\\Phi_F^{[n]}', 'Gesamttransformation einer Operatorfolge',
       'Durch Komposition einer endlichen funktionalen Operatorfolge erzeugte Transformation.',
       'chapter', @section_id, @eq_3785, NULL,
       '\\Omega_F(\\mathcal{S})', '\\Omega_F(\\mathcal{S})',
       0, 0, 1, 'Fasst eine endliche Operatorfolge zu einer Wirkung zusammen.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\Phi_F^{[n]}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\mathbf{Z}_F^{[n]}', '\\mathbf{Z}_F^{[n]}', 'Funktionale Zustandsfolge',
       'Geordnetes Tupel funktionaler Zustände eines Entwicklungspfads.',
       'chapter', @section_id, @eq_3792, NULL,
       '\\mathbb{N}', '\\Omega_F(\\mathcal{S})^{n+1}',
       0, 0, 0, 'Wird aus Anfangszustand und Operatorfolge erzeugt.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\mathbf{Z}_F^{[n]}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\Gamma_F^{[n]}', '\\Gamma_F^{[n]}', 'Funktionaler Entwicklungspfad',
       'Vollständige alternierende Folge aus Zuständen und erzeugenden Operatoren.',
       'chapter', @section_id, @eq_3794, NULL,
       '\\mathbb{N}', '\\Omega_F\\times(\\mathcal{O}_F\\times\\Omega_F)^n',
       0, 0, 0, 'Träger der funktionalen Übergangsordnung.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\Gamma_F^{[n]}');

INSERT INTO symbols
(symbol_latex, symbol_word_latex, symbol_name, definition_text, scope_type,
 first_section_id, first_equation_id, unit_text, domain_text, codomain_text,
 is_vector, is_matrix, is_operator, notes, validation_status, created_revision_id)
SELECT '\\prec_F', '\\prec_F', 'Funktionale Übergangsordnung',
       'Strikte, pfadgebundene Vorher-Nachher-Relation funktionaler Zustände.',
       'chapter', @section_id, @eq_3810, NULL,
       '\\Omega_F(\\mathcal{S})\\times\\Omega_F(\\mathcal{S})', '\\{0,1\\}',
       0, 0, 0, 'Begründet noch keine metrische oder physikalische Zeit.', 'checked', @revision_id
WHERE NOT EXISTS (SELECT 1 FROM symbols WHERE symbol_latex='\\prec_F');

/* Änderungsprotokoll */
INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id, @section_id, 'created', 'section', '3.4.6',
       'Abschnitt 3.4.6 Funktionale Übergänge und Operatorfolgen wurde angelegt.',
       NULL, 'final'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_type='section' AND object_reference='3.4.6'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id, @section_id, 'equation_added', 'equation', '3.771-3.821',
       'Einundfünfzig Gleichungen wurden registriert.',
       NULL, '3.771 bis 3.821'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_type='equation' AND object_reference='3.771-3.821'
);

INSERT INTO section_change_log
(revision_id, section_id, change_type, object_type, object_reference,
 change_summary, previous_value, new_value)
SELECT @revision_id, @section_id, 'statement_added', 'statement', '3.4.15-3.4.20',
       'Sechs Definitionen, zwei Lemmas, zwei Sätze, zwei Korollare und sechs Beweise beziehungsweise Begründungen wurden registriert.',
       NULL, 'vollständig'
WHERE NOT EXISTS
(
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_type='statement' AND object_reference='3.4.15-3.4.20'
);

/* Repository-Zähler */
INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_equation_number_chapter_3', '3.821')
ON DUPLICATE KEY UPDATE counter_value='3.821';

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_citation_number', '109')
ON DUPLICATE KEY UPDATE counter_value='109';

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_completed_section_chapter_3', '3.4.6')
ON DUPLICATE KEY UPDATE counter_value='3.4.6';

INSERT INTO repository_counters (counter_key, counter_value)
VALUES ('last_repository_revision', 'RKB-NEU-K3.4.6-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-NEU-K3.4.6-V1';

COMMIT;

/* Kontrollabfragen */
SELECT revision_id, revision_code, scope_reference, version_label, summary
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.4.6-V1';

SELECT section_id, section_code, title, status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.4.6';

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.4.6' LIMIT 1
)
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.4.6' LIMIT 1
)
ORDER BY definition_number;

SELECT lemma_number AS object_number, title, 'lemma' AS object_type, validation_status
FROM lemmas
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.6' LIMIT 1)
UNION ALL
SELECT theorem_number, title, 'theorem', validation_status
FROM theorems
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.6' LIMIT 1)
UNION ALL
SELECT corollary_number, title, 'corollary', validation_status
FROM corollaries
WHERE section_id=(SELECT section_id FROM dissertation_sections WHERE section_code='3.4.6' LIMIT 1);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.4.6' LIMIT 1
)
ORDER BY proof_number;

SELECT symbol_latex, symbol_name, scope_type, validation_status
FROM symbols
WHERE first_section_id=
(
    SELECT section_id FROM dissertation_sections
    WHERE section_code='3.4.6' LIMIT 1
)
ORDER BY symbol_id;

SELECT counter_key, counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_equation_number_chapter_3',
    'last_citation_number',
    'last_completed_section_chapter_3',
    'last_repository_revision'
)
ORDER BY counter_key;
