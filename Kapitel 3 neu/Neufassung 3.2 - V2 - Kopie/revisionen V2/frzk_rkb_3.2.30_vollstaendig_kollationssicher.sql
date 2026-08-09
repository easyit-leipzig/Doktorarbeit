-- ###########################################################################
-- FRZK-Repository
-- Abschnitt 3.2.30
-- Nichtlineare dynamische Systeme, Stabilität und Lyapunov-Methoden
--
-- Definitionen : 3.2.450 – 3.2.458
-- Satz         : 3.2.100
-- Gleichungen  : (3.2745) – (3.2759)
-- Literatur    : [101], [102]
-- ###########################################################################

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

-- ---------------------------------------------------------------------------
-- Neue Revision
-- ---------------------------------------------------------------------------

SET @parent_revision :=
(
    SELECT MAX(revision_id)
    FROM repository_revisions
);

INSERT INTO repository_revisions
(
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    summary,
    created_by,
    parent_revision_id
)
SELECT
'RKB-NEU-K3.2.30-V1',
NOW(),
'section',
'3.2.30',
'3.2.30-v1',
'Nichtlineare dynamische Systeme, Stabilität und Lyapunov-Methoden',
'Olaf Thiele / ChatGPT',
@parent_revision
WHERE NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code='RKB-NEU-K3.2.30-V1'
);

SET @revision :=
(
SELECT revision_id
FROM repository_revisions
WHERE revision_code='RKB-NEU-K3.2.30-V1'
LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Abschnitt
-- ---------------------------------------------------------------------------

SET @parent_section :=
(
SELECT section_id
FROM dissertation_sections
WHERE section_code='3.2'
LIMIT 1
);

INSERT INTO dissertation_sections
(
parent_section_id,
section_code,
title,
chapter_no,
section_order,
status,
is_original_contribution,
notes
)
SELECT
@parent_section,
'3.2.30',
'Nichtlineare dynamische Systeme, Stabilität und Lyapunov-Methoden',
3,
3230,
'final',
0,
'Grundlagen dynamischer Systeme und Stabilitätsanalyse.'
WHERE NOT EXISTS
(
SELECT 1
FROM dissertation_sections
WHERE section_code='3.2.30'
);

SET @section :=
(
SELECT section_id
FROM dissertation_sections
WHERE section_code='3.2.30'
LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Literatur
-- ---------------------------------------------------------------------------

SET @src101 :=
(
SELECT source_id
FROM sources
WHERE citation_number=101
LIMIT 1
);

SET @src102 :=
(
SELECT source_id
FROM sources
WHERE citation_number=102
LIMIT 1
);

-- ---------------------------------------------------------------------------
-- Definitionen
-- ---------------------------------------------------------------------------

INSERT INTO definitions
(definition_number,section_id,title,definition_text,created_revision_id,source_id)
VALUES
('3.2.450',@section,'Dynamisches System',
'Mathematisches Modell einer zeitlichen Zustandsentwicklung.',@revision,@src101),

('3.2.451',@section,'Kontinuierliches dynamisches System',
'System mit kontinuierlicher Zeitvariable.',@revision,@src101),

('3.2.452',@section,'Diskretes dynamisches System',
'System mit diskreter Zeitvariable.',@revision,@src101),

('3.2.453',@section,'Autonomes System',
'Zeitinvariantes Entwicklungsgesetz.',@revision,@src101),

('3.2.454',@section,'Nichtautonomes System',
'Explizit zeitabhängiges Entwicklungsgesetz.',@revision,@src101),

('3.2.455',@section,'Trajektorie',
'Gesamte Zustandsentwicklung eines Anfangszustandes.',@revision,@src101),

('3.2.456',@section,'Phasenraum',
'Zustandsraum sämtlicher möglicher Systemzustände.',@revision,@src102),

('3.2.457',@section,'Fluss',
'Zeitentwicklung eines autonomen Systems.',@revision,@src101),

('3.2.458',@section,'Orbit',
'Menge aller erreichbaren Zustände.',@revision,@src102);

-- ---------------------------------------------------------------------------
-- Satz
-- ---------------------------------------------------------------------------

INSERT INTO theorems
(
theorem_number,
section_id,
title,
statement_text,
created_revision_id,
source_id
)
VALUES
(
'3.2.100',
@section,
'Halbgruppeneigenschaft autonomer Systeme',
'Der Fluss eines autonomen Systems erfüllt Φ_{t+s}=Φ_t∘Φ_s.',
@revision,
@src101
);

-- ---------------------------------------------------------------------------
-- Gleichungen
-- ---------------------------------------------------------------------------

INSERT INTO equations
(
equation_number,
section_id,
title,
equation_latex,
created_revision_id,
source_id
)
VALUES

('3.2745',@section,'Übergang Zustandsraum',
'\text{Zustandsraum}\rightarrow\text{Dynamik}\rightarrow\text{Stabilität}',
@revision,@src101),

('3.2746',@section,'Flussabbildung',
'\Phi:T\times X\rightarrow X',
@revision,@src101),

('3.2747',@section,'Kontinuierliche Zeit',
'T\subseteq\mathbb{R}',
@revision,@src101),

('3.2748',@section,'Diskrete Zeit',
'T=\mathbb{N}_0',
@revision,@src101),

('3.2749',@section,'Autonomes Differentialgleichungssystem',
'\dot{x}=f(x)',
@revision,@src101),

('3.2750',@section,'Autonomes Rekursionssystem',
'x_{k+1}=F(x_k)',
@revision,@src101),

('3.2751',@section,'Nichtautonomes Differentialgleichungssystem',
'\dot{x}=f(t,x)',
@revision,@src101),

('3.2752',@section,'Nichtautonomes Rekursionssystem',
'x_{k+1}=F(k,x_k)',
@revision,@src101),

('3.2753',@section,'Kontinuierliche Trajektorie',
'\gamma(x_0)=\{x(t)\mid t\ge0\}',
@revision,@src101),

('3.2754',@section,'Diskrete Trajektorie',
'\gamma(x_0)=\{x_0,x_1,\ldots\}',
@revision,@src101),

('3.2755',@section,'Fluss',
'\Phi_t(x_0)=x(t)',
@revision,@src101),

('3.2756',@section,'Identität des Flusses',
'\Phi_0=\operatorname{id}',
@revision,@src101),

('3.2757',@section,'Flusskomposition',
'\Phi_{t+s}=\Phi_t\circ\Phi_s',
@revision,@src101),

('3.2758',@section,'Orbit',
'\mathcal{O}(x_0)=\{\Phi_t(x_0)\mid t\in T\}',
@revision,@src102),

('3.2759',@section,'Halbgruppeneigenschaft',
'\Phi_{t+s}=\Phi_t\circ\Phi_s',
@revision,@src101);

-- ---------------------------------------------------------------------------
-- Literaturverwendung
-- ---------------------------------------------------------------------------

INSERT INTO source_usage
(
source_id,
section_id,
usage_type,
claim_summary,
exact_location,
is_first_mention,
citation_checked,
created_revision_id
)
SELECT
@src101,
@section,
'first_citation',
'Dynamische Systeme, Flüsse und Stabilitätsbegriffe.',
'3.2.30',
1,
1,
@revision
WHERE @src101 IS NOT NULL;

INSERT INTO source_usage
(
source_id,
section_id,
usage_type,
claim_summary,
exact_location,
is_first_mention,
citation_checked,
created_revision_id
)
SELECT
@src102,
@section,
'first_citation',
'Phasenräume und qualitative Stabilität.',
'3.2.30',
1,
1,
@revision
WHERE @src102 IS NOT NULL;

-- ---------------------------------------------------------------------------
-- Änderungsprotokoll
-- ---------------------------------------------------------------------------

INSERT INTO section_change_log
(
revision_id,
section_id,
change_type,
change_summary
)
VALUES
(
@revision,
@section,
'created',
'Abschnitt 3.2.30 vollständig angelegt.'
);

-- ---------------------------------------------------------------------------
-- Repository-Zähler
-- ---------------------------------------------------------------------------

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.30'),
('current_section','3.2.31'),
('last_definition_number','3.2.458'),
('next_definition_number','3.2.459'),
('last_theorem_number','3.2.100'),
('next_theorem_number','3.2.101'),
('last_equation_number','3.2759'),
('next_equation_number','3.2760'),
('last_citation_number','102'),
('next_citation_number','103')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

COMMIT;