-- =====================================================================
-- FRZK Research-Knowledge-Base
-- Repository-Update nach Abschluss von Abschnitt 3.2.6
-- Abschnitt: 3.2.6 Vektorräume als mathematische Beschreibung
--             linearer Zustandsräume
-- Grundlage: frzk_rkb_update_3.2.5.sql
--
-- Neue Quellen: [85]–[87]
-- Definitionen: 3.2.39–3.2.44
-- Sätze: 3.2.8–3.2.9
-- Beweise: 3.2.8-P, 3.2.9-P
-- Gleichungen: (3.247)–(3.265)
-- Nächste freie Literaturziffer: [88]
--
-- Idempotent für das Repository-Schema aus frzk_rkb(3).sql.
-- =====================================================================

SET NAMES utf8mb4;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

START TRANSACTION;

-- ---------------------------------------------------------------------
-- 1. Ausgangsstand
-- ---------------------------------------------------------------------

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.5-V1'
    LIMIT 1
);

SET @chapter_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2'
    LIMIT 1
);

SELECT CASE
    WHEN @parent_revision_id IS NULL
        THEN 'FEHLER: Revision RKB-NEU-K3.2.5-V1 fehlt.'
    WHEN @chapter_section_id IS NULL
        THEN 'FEHLER: Hauptabschnitt 3.2 fehlt.'
    ELSE 'OK: Ausgangsstand nach 3.2.5 vorhanden.'
END AS precondition_status;

-- ---------------------------------------------------------------------
-- 2. Revision
-- ---------------------------------------------------------------------

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    'RKB-NEU-K3.2.6-V1',
    NOW(),
    'section',
    '3.2.6',
    '1.0',
    'Abschluss von Abschnitt 3.2.6. Registriert werden die Quellen [85] bis [87], die Definitionen 3.2.39 bis 3.2.44, die Sätze 3.2.8 und 3.2.9 mit Beweisen sowie die Gleichungen (3.247) bis (3.265).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE @parent_revision_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM repository_revisions
      WHERE revision_code = 'RKB-NEU-K3.2.6-V1'
  );

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = 'RKB-NEU-K3.2.6-V1'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 3. Abschnitt
-- ---------------------------------------------------------------------

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @chapter_section_id,
    '3.2.6',
    'Vektorräume als mathematische Beschreibung linearer Zustandsräume',
    3,
    3.2600,
    'final',
    0,
    'Der Abschnitt führt Vektorräume über die Vektoraddition und Skalarmultiplikation ein. Behandelt werden die acht Vektorraumaxiome, Nullvektor und additives Inverses, Linearkombination, linearer Spann, lineare Unabhängigkeit, Basis und Dimension.'
WHERE @chapter_section_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dissertation_sections
      WHERE section_code = '3.2.6'
  );

UPDATE dissertation_sections
SET
    parent_section_id = @chapter_section_id,
    title = 'Vektorräume als mathematische Beschreibung linearer Zustandsräume',
    chapter_no = 3,
    section_order = 3.2600,
    status = 'final',
    is_original_contribution = 0,
    notes = 'Der Abschnitt führt Vektorräume über die Vektoraddition und Skalarmultiplikation ein. Behandelt werden die acht Vektorraumaxiome, Nullvektor und additives Inverses, Linearkombination, linearer Spann, lineare Unabhängigkeit, Basis und Dimension.'
WHERE section_code = '3.2.6';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.2.6'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 4. Autoren
-- ---------------------------------------------------------------------

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Grassmann', 'Hermann', 'Grassmann, Hermann',
    1809, 1877, 'Autor der Quelle [85].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Grassmann, Hermann'
);

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Peano', 'Giuseppe', 'Peano, Giuseppe',
    1858, 1932, 'Autor der Quelle [86].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Peano, Giuseppe'
);

INSERT INTO authors
(family_name, given_names, normalized_name, birth_year, death_year, notes)
SELECT
    'Bourbaki', 'Nicolas', 'Bourbaki, Nicolas',
    NULL, NULL, 'Kollektivpseudonym; Autor der Quelle [87].'
WHERE NOT EXISTS (
    SELECT 1 FROM authors
    WHERE normalized_name = 'Bourbaki, Nicolas'
);

SET @author_grassmann := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Grassmann, Hermann'
    LIMIT 1
);

SET @author_peano := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Peano, Giuseppe'
    LIMIT 1
);

SET @author_bourbaki := (
    SELECT author_id FROM authors
    WHERE normalized_name = 'Bourbaki, Nicolas'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 5. Quellen [85]–[87]
-- ---------------------------------------------------------------------

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    85,
    'grassmann_lineale_ausdehnungslehre_1844',
    'book',
    'Die lineale Ausdehnungslehre',
    'Ein neuer Zweig der Mathematik',
    1844,
    1844,
    NULL,
    'Otto Wigand',
    'Leipzig',
    NULL,
    NULL,
    NULL,
    'Erstausgabe',
    NULL,
    NULL,
    NULL,
    'de',
    1,
    'historical',
    9,
    'verified',
    '3.2.6',
    'Erstnennung zur historischen Entwicklung einer allgemeinen Algebra gerichteter Größen.',
    'Grassmann, Hermann (1844): Die lineale Ausdehnungslehre. Ein neuer Zweig der Mathematik. Leipzig: Otto Wigand.',
    'Grassmann (1844)',
    'Historische Primärquelle zur Entwicklung des abstrakten Vektorbegriffs.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 85
       OR source_key = 'grassmann_lineale_ausdehnungslehre_1844'
);

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    86,
    'peano_calcolo_geometrico_1888',
    'book',
    'Calcolo geometrico',
    'Secondo l''Ausdehnungslehre di H. Grassmann preceduto dalle operazioni della logica deduttiva',
    1888,
    1888,
    NULL,
    'Fratelli Bocca',
    'Turin',
    NULL,
    NULL,
    NULL,
    'Erstausgabe',
    NULL,
    NULL,
    NULL,
    'it',
    1,
    'historical',
    9,
    'verified',
    '3.2.6',
    'Erstnennung zur axiomatischen und symbolischen Formulierung linearer Räume.',
    'Peano, Giuseppe (1888): Calcolo geometrico secondo l''Ausdehnungslehre di H. Grassmann preceduto dalle operazioni della logica deduttiva. Turin: Fratelli Bocca.',
    'Peano (1888)',
    'Historische Primärquelle zur Axiomatisierung geometrischer und linearer Strukturen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 86
       OR source_key = 'peano_calcolo_geometrico_1888'
);

INSERT INTO sources
(
    citation_number, source_key, source_type, title, subtitle,
    year_original, year_edition, journal, publisher, place,
    volume, issue, pages, edition, doi, isbn, url,
    language_code, priority, evidence_type, frzk_relevance,
    verification_status, first_citation_section_code,
    first_citation_note, full_citation_text, short_citation_text,
    notes, created_revision_id
)
SELECT
    87,
    'bourbaki_algebre_1947',
    'book',
    'Algèbre',
    NULL,
    1947,
    1947,
    NULL,
    'Hermann',
    'Paris',
    NULL,
    NULL,
    NULL,
    'Erstausgabe',
    NULL,
    NULL,
    NULL,
    'fr',
    1,
    'foundational',
    10,
    'verified',
    '3.2.6',
    'Erstnennung als moderne systematische Darstellung algebraischer und linearer Strukturen.',
    'Bourbaki, Nicolas (1947): Algèbre. Paris: Hermann.',
    'Bourbaki (1947)',
    'Grundlagenquelle für die moderne abstrakte Definition von Vektorräumen.',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM sources
    WHERE citation_number = 87
       OR source_key = 'bourbaki_algebre_1947'
);

SET @source_85 := (
    SELECT source_id FROM sources
    WHERE source_key = 'grassmann_lineale_ausdehnungslehre_1844'
       OR citation_number = 85
    ORDER BY (source_key = 'grassmann_lineale_ausdehnungslehre_1844') DESC
    LIMIT 1
);

SET @source_86 := (
    SELECT source_id FROM sources
    WHERE source_key = 'peano_calcolo_geometrico_1888'
       OR citation_number = 86
    ORDER BY (source_key = 'peano_calcolo_geometrico_1888') DESC
    LIMIT 1
);

SET @source_87 := (
    SELECT source_id FROM sources
    WHERE source_key = 'bourbaki_algebre_1947'
       OR citation_number = 87
    ORDER BY (source_key = 'bourbaki_algebre_1947') DESC
    LIMIT 1
);

INSERT IGNORE INTO source_authors
(source_id, author_id, author_order, role)
VALUES
(@source_85, @author_grassmann, 1, 'author'),
(@source_86, @author_peano, 1, 'author'),
(@source_87, @author_bourbaki, 1, 'author');

-- ---------------------------------------------------------------------
-- 6. Quellenverwendung
-- ---------------------------------------------------------------------

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_85, @section_id, 'first_citation',
    'Historische Einführung einer allgemeinen Algebra gerichteter Größen.',
    'Abschnitt 3.2.6, historische Einführung',
    1, 1, 'Erstnennung als Quelle [85].', @revision_id
WHERE @source_85 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_85
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_86, @section_id, 'first_citation',
    'Historische Einordnung der axiomatischen Formulierung linearer Räume.',
    'Abschnitt 3.2.6, historische Einführung',
    1, 1, 'Erstnennung als Quelle [86].', @revision_id
WHERE @source_86 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_86
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

INSERT INTO source_usage
(
    source_id, section_id, usage_type, claim_summary, exact_location,
    is_first_mention, citation_checked, notes, created_revision_id
)
SELECT
    @source_87, @section_id, 'first_citation',
    'Moderne systematische Definition von Vektorräumen, Basen und Dimensionen.',
    'Abschnitt 3.2.6, Definitionen 3.2.39 bis 3.2.44',
    1, 1, 'Erstnennung als Quelle [87].', @revision_id
WHERE @source_87 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM source_usage
      WHERE source_id = @source_87
        AND section_id = @section_id
        AND usage_type = 'first_citation'
  );

-- ---------------------------------------------------------------------
-- 7. Definitionen 3.2.39–3.2.44
-- ---------------------------------------------------------------------

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
VALUES
(
    '3.2.39', @section_id, 'Vektorraum',
    'Ein Vektorraum über einem Körper K ist eine Menge V mit einer Vektoraddition und einer Skalarmultiplikation, welche die acht Vektorraumaxiome erfüllen.',
    '+:V\times V\rightarrow V,\qquad\cdot:K\times V\rightarrow V',
    '+:V\times V\rightarrow V,\qquad\cdot:K\times V\rightarrow V',
    'adapted', @source_87,
    'K ist ein Körper; V ist eine nichtleere Menge.',
    'Die Definition umfasst Abgeschlossenheit, Assoziativität und Kommutativität der Addition, Nullvektor, additive Inverse, beide Distributivgesetze, Verträglichkeit der Skalarmultiplikation und Einheitswirkung.',
    'checked', @revision_id
),
(
    '3.2.40', @section_id, 'Linearkombination',
    'Eine Linearkombination der Vektoren v_1 bis v_n ist eine endliche Summe skalarer Vielfacher dieser Vektoren.',
    '\sum_{i=1}^{n}\lambda_i v_i',
    '\sum_{i=1}^{n}\lambda_i v_i',
    'adapted', @source_87,
    'v_i∈V und λ_i∈K.',
    'Linearkombinationen verbinden Vektoraddition und Skalarmultiplikation.',
    'checked', @revision_id
),
(
    '3.2.41', @section_id, 'Linearer Spann',
    'Der lineare Spann einer Teilmenge M eines Vektorraums ist die Menge aller endlichen Linearkombinationen von Elementen aus M.',
    '\operatorname{span}(M)=\left\{\sum_{i=1}^{n}\lambda_i v_i\mid v_i\in M\right\}',
    '\operatorname{span}(M)=\left\{\sum_{i=1}^{n}\lambda_i v_i\mid v_i\in M\right\}',
    'adapted', @source_87,
    'M⊆V.',
    'Der Spann ist der kleinste Untervektorraum, der M enthält.',
    'checked', @revision_id
),
(
    '3.2.42', @section_id, 'Lineare Unabhängigkeit',
    'Vektoren v_1 bis v_n heißen linear unabhängig, wenn nur die triviale Linearkombination den Nullvektor ergibt.',
    '\sum_{i=1}^{n}\lambda_i v_i=0\Longrightarrow\lambda_i=0\quad(i=1,\ldots,n)',
    '\sum_{i=1}^{n}\lambda_i v_i=0\Longrightarrow\lambda_i=0\quad(i=1,\ldots,n)',
    'adapted', @source_87,
    'v_i∈V und λ_i∈K.',
    'Keiner der Vektoren kann als Linearkombination der übrigen dargestellt werden.',
    'checked', @revision_id
),
(
    '3.2.43', @section_id, 'Basis',
    'Eine Basis eines Vektorraums ist eine linear unabhängige Menge, deren linearer Spann den gesamten Vektorraum erzeugt.',
    'V=\operatorname{span}\{e_1,\ldots,e_n\}',
    'V=\operatorname{span}\{e_1,\ldots,e_n\}',
    'adapted', @source_87,
    'V ist endlichdimensional, sofern eine endliche Basis betrachtet wird.',
    'Jeder Vektor besitzt bezüglich einer Basis eine eindeutige Koordinatendarstellung.',
    'checked', @revision_id
),
(
    '3.2.44', @section_id, 'Dimension',
    'Die Dimension eines endlichdimensionalen Vektorraums ist die Anzahl der Elemente einer Basis.',
    '\dim(V)=n',
    '\dim(V)=n',
    'adapted', @source_87,
    'V besitzt eine endliche Basis.',
    'Alle Basen eines endlichdimensionalen Vektorraums besitzen dieselbe Anzahl von Elementen.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    definition_text = VALUES(definition_text),
    formal_latex = VALUES(formal_latex),
    word_latex = VALUES(word_latex),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    assumptions = VALUES(assumptions),
    notes = VALUES(notes),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

-- ---------------------------------------------------------------------
-- 8. Sätze 3.2.8–3.2.9
-- ---------------------------------------------------------------------

INSERT INTO theorems
(
    theorem_number, section_id, title, statement_text,
    statement_latex, word_latex, provenance, source_id,
    assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.2.8',
    @section_id,
    'Eindeutigkeit des Nullvektors',
    'In jedem Vektorraum existiert genau ein additives neutrales Element.',
    '\exists!\,0\in V\;\forall v\in V:v+0=v',
    '\exists!\,0\in V\;\forall v\in V:v+0=v',
    'literature',
    @source_87,
    'V ist ein Vektorraum.',
    'checked',
    @revision_id
),
(
    '3.2.9',
    @section_id,
    'Eindeutigkeit des inversen Vektors',
    'Zu jedem Vektor eines Vektorraums existiert genau ein additives Inverses.',
    '\forall v\in V\;\exists!\,(-v)\in V:v+(-v)=0',
    '\forall v\in V\;\exists!\,(-v)\in V:v+(-v)=0',
    'literature',
    @source_87,
    'V ist ein Vektorraum.',
    'checked',
    @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    statement_text = VALUES(statement_text),
    statement_latex = VALUES(statement_latex),
    word_latex = VALUES(word_latex),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    assumptions = VALUES(assumptions),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

SET @theorem_328 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.8'
    LIMIT 1
);

SET @theorem_329 := (
    SELECT theorem_id FROM theorems
    WHERE theorem_number = '3.2.9'
    LIMIT 1
);

-- ---------------------------------------------------------------------
-- 9. Beweise
-- ---------------------------------------------------------------------

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.8-P',
    @section_id,
    @theorem_328,
    'Beweis der Eindeutigkeit des Nullvektors',
    'Seien 0_1 und 0_2 zwei additive neutrale Elemente. Wegen der Neutralität von 0_2 gilt 0_1=0_1+0_2. Wegen der Neutralität von 0_1 gilt zugleich 0_1+0_2=0_2. Daher ist 0_1=0_2.',
    '0_1=0_1+0_2=0_2',
    'direct',
    'adapted',
    @source_87,
    'checked',
    @revision_id
WHERE @theorem_328 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.8-P'
  );

INSERT INTO proofs
(
    proof_number, section_id, theorem_id, title, proof_text,
    proof_latex, proof_method, provenance, source_id,
    validation_status, created_revision_id
)
SELECT
    '3.2.9-P',
    @section_id,
    @theorem_329,
    'Beweis der Eindeutigkeit des inversen Vektors',
    'Seien x und y zwei additive Inverse desselben Vektors v. Dann folgt x=x+0=x+(v+y)=(x+v)+y=0+y=y. Somit stimmen beide inversen Vektoren überein.',
    'x=x+0=x+(v+y)=(x+v)+y=0+y=y',
    'direct',
    'adapted',
    @source_87,
    'checked',
    @revision_id
WHERE @theorem_329 IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM proofs
      WHERE proof_number = '3.2.9-P'
  );

-- ---------------------------------------------------------------------
-- 10. Gleichungen (3.247)–(3.265)
-- ---------------------------------------------------------------------

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex, word_latex,
    plain_description, equation_type, provenance, source_id,
    derivation, assumptions, validation_status, created_revision_id
)
VALUES
(
    '3.247', @section_id, 'Vektoraddition',
    '+:V\times V\rightarrow V',
    '+:V\times V\rightarrow V',
    'Die Vektoraddition ordnet zwei Vektoren einen Vektor desselben Raumes zu.',
    'definition', 'adapted', @source_87, NULL,
    'V ist die Trägermenge des Vektorraums.',
    'checked', @revision_id
),
(
    '3.248', @section_id, 'Skalarmultiplikation',
    '\cdot:K\times V\rightarrow V',
    '\cdot:K\times V\rightarrow V',
    'Die Skalarmultiplikation ordnet einem Skalar und einem Vektor einen Vektor zu.',
    'definition', 'adapted', @source_87, NULL,
    'K ist ein Körper und V ein Vektorraum über K.',
    'checked', @revision_id
),
(
    '3.249', @section_id, 'Assoziativität der Vektoraddition',
    '(u+v)+w=u+(v+w)',
    '(u+v)+w=u+(v+w)',
    'Die Klammerung dreier Vektoradditionen verändert das Ergebnis nicht.',
    'axiom', 'adapted', @source_87, NULL,
    'u,v,w∈V.',
    'checked', @revision_id
),
(
    '3.250', @section_id, 'Kommutativität der Vektoraddition',
    'u+v=v+u',
    'u+v=v+u',
    'Die Reihenfolge der Summanden verändert die Vektorsumme nicht.',
    'axiom', 'adapted', @source_87, NULL,
    'u,v∈V.',
    'checked', @revision_id
),
(
    '3.251', @section_id, 'Neutrales Element der Vektoraddition',
    'v+0=v',
    'v+0=v',
    'Die Addition des Nullvektors lässt einen Vektor unverändert.',
    'axiom', 'adapted', @source_87, NULL,
    'v∈V und 0 ist der Nullvektor.',
    'checked', @revision_id
),
(
    '3.252', @section_id, 'Additives Inverses',
    'v+(-v)=0',
    'v+(-v)=0',
    'Ein Vektor und sein additives Inverses ergeben den Nullvektor.',
    'axiom', 'adapted', @source_87, NULL,
    'v∈V.',
    'checked', @revision_id
),
(
    '3.253', @section_id, 'Distributivität über der Vektoraddition',
    '\lambda(u+v)=\lambda u+\lambda v',
    '\lambda(u+v)=\lambda u+\lambda v',
    'Die Skalarmultiplikation verteilt sich über die Vektoraddition.',
    'axiom', 'adapted', @source_87, NULL,
    'λ∈K und u,v∈V.',
    'checked', @revision_id
),
(
    '3.254', @section_id, 'Distributivität über der Skalaraddition',
    '(\lambda+\mu)v=\lambda v+\mu v',
    '(\lambda+\mu)v=\lambda v+\mu v',
    'Die Multiplikation einer Skalarsumme mit einem Vektor verteilt sich auf die Summanden.',
    'axiom', 'adapted', @source_87, NULL,
    'λ,μ∈K und v∈V.',
    'checked', @revision_id
),
(
    '3.255', @section_id, 'Verträglichkeit der Skalarmultiplikation',
    '(\lambda\mu)v=\lambda(\mu v)',
    '(\lambda\mu)v=\lambda(\mu v)',
    'Die skalare Multiplikation ist mit der Körpermultiplikation verträglich.',
    'axiom', 'adapted', @source_87, NULL,
    'λ,μ∈K und v∈V.',
    'checked', @revision_id
),
(
    '3.256', @section_id, 'Einheitswirkung',
    '1v=v',
    '1v=v',
    'Das multiplikative Einselement des Körpers lässt jeden Vektor unverändert.',
    'axiom', 'adapted', @source_87, NULL,
    '1 ist das Einselement von K und v∈V.',
    'checked', @revision_id
),
(
    '3.257', @section_id, 'Eindeutigkeit des Nullvektors',
    '0_1=0_1+0_2=0_2',
    '0_1=0_1+0_2=0_2',
    'Zwei angenommene neutrale Elemente müssen identisch sein.',
    'proof_step', 'adapted', @source_87,
    'Verwendung der Neutralität von 0_1 und 0_2.',
    '0_1 und 0_2 sind additive neutrale Elemente.',
    'checked', @revision_id
),
(
    '3.258', @section_id, 'Eindeutigkeit des additiven Inversen',
    'x=x+0=x+(v+y)=(x+v)+y=0+y=y',
    'x=x+0=x+(v+y)=(x+v)+y=0+y=y',
    'Zwei additive Inverse desselben Vektors sind identisch.',
    'proof_step', 'adapted', @source_87,
    'Verwendung von Neutralität, Assoziativität und der Inverseneigenschaft.',
    'x und y sind additive Inverse von v.',
    'checked', @revision_id
),
(
    '3.259', @section_id, 'Multiplikation eines Vektors mit dem Nullskalar',
    '0v=0',
    '0v=0',
    'Die Multiplikation eines Vektors mit dem Nullskalar ergibt den Nullvektor.',
    'derived_property', 'adapted', @source_87,
    'Aus 0v=(0+0)v=0v+0v folgt durch Addition des inversen Vektors 0v=0.',
    'v∈V.',
    'checked', @revision_id
),
(
    '3.260', @section_id, 'Multiplikation mit minus eins',
    '(-1)v=-v',
    '(-1)v=-v',
    'Die Multiplikation mit minus eins ergibt das additive Inverse.',
    'derived_property', 'adapted', @source_87,
    'Aus v+(-1)v=(1+(-1))v=0v=0 folgt die Behauptung.',
    'v∈V.',
    'checked', @revision_id
),
(
    '3.261', @section_id, 'Allgemeine Linearkombination',
    '\sum_{i=1}^{n}\lambda_i v_i',
    '\sum_{i=1}^{n}\lambda_i v_i',
    'Eine endliche Summe skalarer Vielfacher von Vektoren.',
    'definition', 'adapted', @source_87, NULL,
    'λ_i∈K und v_i∈V.',
    'checked', @revision_id
),
(
    '3.262', @section_id, 'Linearer Spann',
    '\operatorname{span}(M)=\left\{\sum_{i=1}^{n}\lambda_i v_i\mid v_i\in M\right\}',
    '\operatorname{span}(M)=\left\{\sum_{i=1}^{n}\lambda_i v_i\mid v_i\in M\right\}',
    'Der Spann enthält alle endlichen Linearkombinationen von Vektoren aus M.',
    'definition', 'adapted', @source_87, NULL,
    'M⊆V.',
    'checked', @revision_id
),
(
    '3.263', @section_id, 'Kriterium linearer Unabhängigkeit',
    '\sum_{i=1}^{n}\lambda_i v_i=0\Longrightarrow\lambda_i=0\quad(i=1,\ldots,n)',
    '\sum_{i=1}^{n}\lambda_i v_i=0\Longrightarrow\lambda_i=0\quad(i=1,\ldots,n)',
    'Nur die triviale Koeffizientenwahl erzeugt den Nullvektor.',
    'definition', 'adapted', @source_87, NULL,
    'v_1,…,v_n∈V.',
    'checked', @revision_id
),
(
    '3.264', @section_id, 'Basisdarstellung eines Vektors',
    'v=\sum_{i=1}^{n}\lambda_i e_i',
    'v=\sum_{i=1}^{n}\lambda_i e_i',
    'Jeder Vektor besitzt bezüglich einer Basis eine eindeutige Koordinatendarstellung.',
    'definition', 'adapted', @source_87, NULL,
    'e_1,…,e_n bilden eine Basis von V.',
    'checked', @revision_id
),
(
    '3.265', @section_id, 'Dimension eines Vektorraums',
    '\dim(V)=n',
    '\dim(V)=n',
    'Die Dimension entspricht der Anzahl der Elemente einer endlichen Basis.',
    'definition', 'adapted', @source_87, NULL,
    'V ist endlichdimensional.',
    'checked', @revision_id
)
ON DUPLICATE KEY UPDATE
    section_id = VALUES(section_id),
    title = VALUES(title),
    equation_latex = VALUES(equation_latex),
    word_latex = VALUES(word_latex),
    plain_description = VALUES(plain_description),
    equation_type = VALUES(equation_type),
    provenance = VALUES(provenance),
    source_id = VALUES(source_id),
    derivation = VALUES(derivation),
    assumptions = VALUES(assumptions),
    validation_status = VALUES(validation_status),
    created_revision_id = VALUES(created_revision_id);

-- ---------------------------------------------------------------------
-- 11. Gleichungssymbole
-- ---------------------------------------------------------------------

SET @eq_247 := (SELECT equation_id FROM equations WHERE equation_number='3.247' LIMIT 1);
SET @eq_248 := (SELECT equation_id FROM equations WHERE equation_number='3.248' LIMIT 1);
SET @eq_249 := (SELECT equation_id FROM equations WHERE equation_number='3.249' LIMIT 1);
SET @eq_251 := (SELECT equation_id FROM equations WHERE equation_number='3.251' LIMIT 1);
SET @eq_253 := (SELECT equation_id FROM equations WHERE equation_number='3.253' LIMIT 1);
SET @eq_259 := (SELECT equation_id FROM equations WHERE equation_number='3.259' LIMIT 1);
SET @eq_261 := (SELECT equation_id FROM equations WHERE equation_number='3.261' LIMIT 1);
SET @eq_262 := (SELECT equation_id FROM equations WHERE equation_number='3.262' LIMIT 1);
SET @eq_263 := (SELECT equation_id FROM equations WHERE equation_number='3.263' LIMIT 1);
SET @eq_264 := (SELECT equation_id FROM equations WHERE equation_number='3.264' LIMIT 1);
SET @eq_265 := (SELECT equation_id FROM equations WHERE equation_number='3.265' LIMIT 1);

INSERT IGNORE INTO equation_symbols
(equation_id, symbol_latex, symbol_name, definition_text, unit_text, domain_text, symbol_order)
VALUES
(@eq_247, 'V', 'Vektorraum', 'Trägermenge der Vektoren.', NULL, 'Menge', 1),
(@eq_247, '+', 'Vektoraddition', 'Innere zweistellige Verknüpfung auf V.', NULL, 'V×V→V', 2),

(@eq_248, 'K', 'Skalarkörper', 'Körper, über dem der Vektorraum definiert ist.', NULL, 'Körper', 1),
(@eq_248, '\cdot', 'Skalarmultiplikation', 'Äußere Verknüpfung zwischen Skalaren und Vektoren.', NULL, 'K×V→V', 2),

(@eq_249, 'u', 'Erster Vektor', 'Beliebiger Vektor des Vektorraums.', NULL, 'Element von V', 1),
(@eq_249, 'v', 'Zweiter Vektor', 'Beliebiger Vektor des Vektorraums.', NULL, 'Element von V', 2),
(@eq_249, 'w', 'Dritter Vektor', 'Beliebiger Vektor des Vektorraums.', NULL, 'Element von V', 3),

(@eq_251, '0', 'Nullvektor', 'Additives neutrales Element des Vektorraums.', NULL, 'Element von V', 1),

(@eq_253, '\lambda', 'Skalar', 'Beliebiges Element des Skalarkörpers.', NULL, 'Element von K', 1),

(@eq_259, '0', 'Nullskalar oder Nullvektor', 'Links bezeichnet 0 den Nullskalar, rechts den Nullvektor; die Bedeutung folgt aus dem Kontext.', NULL, 'K beziehungsweise V', 1),

(@eq_261, '\lambda_i', 'Koeffizient', 'Skalarer Koeffizient der Linearkombination.', NULL, 'Element von K', 1),
(@eq_261, 'v_i', 'Vektor der Linearkombination', 'Vektor, der skalar gewichtet wird.', NULL, 'Element von V', 2),

(@eq_262, 'M', 'Erzeugermenge', 'Teilmenge des Vektorraums, deren Linearkombinationen betrachtet werden.', NULL, 'Teilmenge von V', 1),
(@eq_262, '\operatorname{span}(M)', 'Linearer Spann', 'Kleinster Untervektorraum, der M enthält.', NULL, 'Untervektorraum von V', 2),

(@eq_263, '\lambda_i=0', 'Triviale Koeffizientenwahl', 'Alle Koeffizienten der Linearkombination sind Null.', NULL, 'Elemente von K', 1),

(@eq_264, 'e_i', 'Basisvektor', 'Element einer Basis von V.', NULL, 'Element von V', 1),

(@eq_265, '\dim(V)', 'Dimension', 'Anzahl der Elemente einer Basis eines endlichdimensionalen Vektorraums.', NULL, 'Natürliche Zahl', 1),
(@eq_265, 'n', 'Dimensionszahl', 'Endliche Anzahl der Basisvektoren.', NULL, 'Natürliche Zahl', 2);

-- ---------------------------------------------------------------------
-- 12. Repository-Zähler
-- ---------------------------------------------------------------------

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES ('next_citation_number', '88')
ON DUPLICATE KEY UPDATE
    counter_value = CASE
        WHEN CAST(counter_value AS UNSIGNED) < 88 THEN '88'
        ELSE counter_value
    END;

-- ---------------------------------------------------------------------
-- 13. Änderungsprotokoll
-- ---------------------------------------------------------------------

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'created', 'section', '3.2.6',
    'Abschnitt 3.2.6 wurde vollständig angelegt und repositoryseitig abgeschlossen.',
    NULL, 'status=final'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='created'
      AND object_reference='3.2.6'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'source_added', 'sources', '[85]-[87]',
    'Drei Quellen zur historischen und modernen Entwicklung des Vektorraumbegriffs wurden aufgenommen.',
    'next_citation_number=85', 'next_citation_number=88'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='source_added'
      AND object_reference='[85]-[87]'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'definition_added', 'definitions',
    '3.2.39-3.2.44',
    'Sechs Definitionen zu Vektorraum, Linearkombination, Spann, linearer Unabhängigkeit, Basis und Dimension wurden registriert.',
    NULL, '6 Definitionen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='definition_added'
      AND object_reference='3.2.39-3.2.44'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'statement_added', 'theorems',
    '3.2.8-3.2.9',
    'Zwei Sätze zur Eindeutigkeit des Nullvektors und des additiven Inversen wurden registriert.',
    NULL, '2 Sätze'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='statement_added'
      AND object_reference='3.2.8-3.2.9'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'proof_added', 'proofs',
    '3.2.8-P;3.2.9-P',
    'Zu beiden Sätzen wurden direkte Beweise aufgenommen.',
    NULL, '2 Beweise'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='proof_added'
      AND object_reference='3.2.8-P;3.2.9-P'
);

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value, new_value
)
SELECT
    @revision_id, @section_id, 'equation_added', 'equations',
    '(3.247)-(3.265)',
    'Neunzehn Gleichungen einschließlich Word-LaTeX wurden aufgenommen.',
    NULL, '19 Gleichungen'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id
      AND section_id=@section_id
      AND change_type='equation_added'
      AND object_reference='(3.247)-(3.265)'
);

-- ---------------------------------------------------------------------
-- 14. Validierungen
-- ---------------------------------------------------------------------

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-SECTION',
    IF(COUNT(*)=1,'passed','failed'),
    '1',
    CAST(COUNT(*) AS CHAR),
    'Abschnitt 3.2.6 muss genau einmal vorhanden sein.'
FROM dissertation_sections
WHERE section_code='3.2.6'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-NEW-SOURCES',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [85], [86] und [87] müssen vollständig vorhanden sein.'
FROM sources
WHERE citation_number IN (85,86,87)
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-SOURCE-USAGE',
    IF(COUNT(*)=3,'passed','failed'),
    '3',
    CAST(COUNT(*) AS CHAR),
    'Die Quellen [85] bis [87] müssen mit Abschnitt 3.2.6 verknüpft sein.'
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (85,86,87)
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-DEFINITIONS',
    IF(COUNT(*)=6,'passed','failed'),
    '6',
    CAST(COUNT(*) AS CHAR),
    'Die Definitionen 3.2.39 bis 3.2.44 müssen vollständig registriert sein.'
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN
      ('3.2.39','3.2.40','3.2.41',
       '3.2.42','3.2.43','3.2.44')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-THEOREMS',
    IF(COUNT(*)=2,'passed','failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Die Sätze 3.2.8 und 3.2.9 müssen vollständig registriert sein.'
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN ('3.2.8','3.2.9')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-PROOFS',
    IF(COUNT(*)=2,'passed','failed'),
    '2',
    CAST(COUNT(*) AS CHAR),
    'Zu den Sätzen müssen zwei Beweise vorhanden sein.'
FROM proofs
WHERE section_id=@section_id
  AND proof_number IN ('3.2.8-P','3.2.9-P')
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-EQUATIONS',
    IF(COUNT(*)=19,'passed','failed'),
    '19',
    CAST(COUNT(*) AS CHAR),
    'Die Gleichungen (3.247) bis (3.265) müssen vollständig registriert sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 247 AND 265
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-WORD-LATEX',
    IF(COUNT(*)=19,'passed','failed'),
    '19',
    CAST(COUNT(*) AS CHAR),
    'Für alle Gleichungen muss Word-LaTeX vorhanden sein.'
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 247 AND 265
  AND word_latex IS NOT NULL
  AND TRIM(word_latex)<>''
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-PARENT-REVISION',
    IF(parent_revision_id=@parent_revision_id,'passed','failed'),
    CAST(@parent_revision_id AS CHAR),
    CAST(parent_revision_id AS CHAR),
    'Die Revision 3.2.6 muss unmittelbar auf der Revision 3.2.5 aufbauen.'
FROM repository_revisions
WHERE revision_id=@revision_id
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

INSERT INTO repository_validation_results
(
    revision_id, validation_code, validation_status,
    expected_value, actual_value, validation_message
)
SELECT
    @revision_id,
    'K3.2.6-NEXT-CITATION',
    IF(CAST(counter_value AS UNSIGNED)>=88,'passed','failed'),
    '>=88',
    counter_value,
    'Nach Quelle [87] muss die nächste freie Literaturziffer mindestens [88] sein.'
FROM repository_counters
WHERE counter_key='next_citation_number'
ON DUPLICATE KEY UPDATE
    validation_status=VALUES(validation_status),
    expected_value=VALUES(expected_value),
    actual_value=VALUES(actual_value),
    validation_message=VALUES(validation_message),
    checked_at=CURRENT_TIMESTAMP;

COMMIT;

-- ---------------------------------------------------------------------
-- 15. Audit-Ausgabe
-- ---------------------------------------------------------------------

SELECT revision_id, revision_code, scope_reference, version_label,
       parent_revision_id, revision_date
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.6-V1';

SELECT section_id, parent_section_id, section_code, title,
       status, is_original_contribution
FROM dissertation_sections
WHERE section_code='3.2.6';

SELECT citation_number, source_key, short_citation_text,
       verification_status
FROM sources
WHERE citation_number IN (85,86,87)
ORDER BY citation_number;

SELECT definition_number, title, validation_status
FROM definitions
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(definition_number,'.',-1) AS UNSIGNED);

SELECT theorem_number, title, validation_status
FROM theorems
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(theorem_number,'.',-1) AS UNSIGNED);

SELECT proof_number, title, proof_method, validation_status
FROM proofs
WHERE section_id=@section_id
ORDER BY proof_number;

SELECT equation_number, title, equation_type, validation_status
FROM equations
WHERE section_id=@section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT validation_code, validation_status, expected_value,
       actual_value, validation_message
FROM repository_validation_results
WHERE revision_id=@revision_id
ORDER BY validation_code;
