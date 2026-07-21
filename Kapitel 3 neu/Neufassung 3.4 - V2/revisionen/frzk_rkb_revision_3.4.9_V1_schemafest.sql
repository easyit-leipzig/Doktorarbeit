
/* =====================================================================
   FRZK-RKB – Repository-Update Abschnitt 3.4.9
   Rekonstruktion funktionaler Zeitstrukturen
   Gleichungen (3.925)–(3.986)
   Definitionen 3.4.36–3.4.49; Lemma 3.4.14–3.4.16
   Satz 3.4.14–3.4.17; Korollar 3.4.12–3.4.13
   Beweise, Quellenverwendungen, Änderungsprotokoll und Audit
   Schemafest auf Grundlage der korrigierten Revision 3.4.8 V2
   ===================================================================== */

ROLLBACK;
START TRANSACTION;

SET @revision_code := 'RKB-REV-K3.4.9-V1';

SELECT section_id INTO @parent_section_id
FROM dissertation_sections
WHERE section_code='3.4'
LIMIT 1;

INSERT INTO dissertation_sections
(parent_section_id,section_code,title,chapter_no,section_order,status,is_original_contribution,notes)
SELECT
    @parent_section_id,
    '3.4.9',
    'Rekonstruktion funktionaler Zeitstrukturen',
    3,
    3.4900,
    'review',
    1,
    'Literaturgestützte Rekonstruktion funktionaler Nachfolge, Vorordnung, Zyklen, Zustandsinstanzen, Zeitdifferenzen, Zeitschnitte und Irreversibilität.'
WHERE NOT EXISTS (
    SELECT 1 FROM dissertation_sections WHERE section_code='3.4.9'
);

SELECT section_id INTO @section_id
FROM dissertation_sections
WHERE section_code='3.4.9'
LIMIT 1;

SELECT source_id INTO @source_dummit
FROM sources
WHERE citation_number=31
LIMIT 1;

SELECT source_id INTO @source_diestel
FROM sources
WHERE citation_number=47
LIMIT 1;

SELECT revision_id INTO @parent_revision_id
FROM repository_revisions
ORDER BY revision_id DESC
LIMIT 1;

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by,parent_revision_id)
SELECT
    @revision_code,
    NOW(),
    'section',
    '3.4.9',
    '1.0-complete',
    'Vollständige literaturgestützte Revision von 3.4.9: funktionale Nachfolge, zeitliche Vorordnung, Zyklen, Zustandsinstanzen, diskrete und gewichtete Zeit, Zeitschnitte und Irreversibilität.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM repository_revisions WHERE revision_code=@revision_code
);

SELECT revision_id INTO @revision_id
FROM repository_revisions
WHERE revision_code=@revision_code
LIMIT 1;

DROP PROCEDURE IF EXISTS frzk_assert_349;
DELIMITER $$
CREATE PROCEDURE frzk_assert_349()
BEGIN
    IF @parent_section_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Übergeordneter Abschnitt 3.4 fehlt.';
    END IF;
    IF @section_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Abschnitt 3.4.9 konnte nicht bestimmt werden.';
    END IF;
    IF @revision_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Repository-Revision 3.4.9 konnte nicht bestimmt werden.';
    END IF;
    IF @source_dummit IS NULL OR @source_diestel IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Bestandsquelle [31] oder [47] fehlt.';
    END IF;
END$$
DELIMITER ;

CALL frzk_assert_349();
DROP PROCEDURE frzk_assert_349;

UPDATE dissertation_sections
SET
    title='Rekonstruktion funktionaler Zeitstrukturen',
    status='review',
    is_original_contribution=1,
    notes='Vollständige literaturgestützte Revision: Nachfolge, Vorordnung, Zyklen, Zustandsinstanzen, Zeitdifferenzen, Zeitschnitte und Irreversibilität.'
WHERE section_id=@section_id;

UPDATE equations
SET section_id=@section_id,
    title='Kohärente Zustände der Zeitrekonstruktion',
    equation_latex='z_F^{(i)},z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)',
    word_latex='z_F^{(i)},z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)',
    plain_description='Ausgangs- und Folgezustand gehören zum kohärenten Zustandsraum.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.925';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.925',
    @section_id,
    'Kohärente Zustände der Zeitrekonstruktion',
    'z_F^{(i)},z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)',
    'z_F^{(i)},z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)',
    'Ausgangs- und Folgezustand gehören zum kohärenten Zustandsraum.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.925'
);

UPDATE equations
SET section_id=@section_id,
    title='Operatorische Erzeugung des Nachfolgezustands',
    equation_latex='z_F^{(j)}=O_F\\left(z_F^{(i)}\\right)',
    word_latex='z_F^{(j)}=O_F\\left(z_F^{(i)}\\right)',
    plain_description='Der Nachfolgezustand entsteht durch einen kohärenzerhaltenden Operator.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.926';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.926',
    @section_id,
    'Operatorische Erzeugung des Nachfolgezustands',
    'z_F^{(j)}=O_F\\left(z_F^{(i)}\\right)',
    'z_F^{(j)}=O_F\\left(z_F^{(i)}\\right)',
    'Der Nachfolgezustand entsteht durch einen kohärenzerhaltenden Operator.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.926'
);

UPDATE equations
SET section_id=@section_id,
    title='Nichtidentität des Nachfolgezustands',
    equation_latex='z_F^{(j)}\\neq z_F^{(i)}',
    word_latex='z_F^{(j)}\\neq z_F^{(i)}',
    plain_description='Die unmittelbare Nachfolge setzt eine tatsächliche Zustandsänderung voraus.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.927';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.927',
    @section_id,
    'Nichtidentität des Nachfolgezustands',
    'z_F^{(j)}\\neq z_F^{(i)}',
    'z_F^{(j)}\\neq z_F^{(i)}',
    'Die unmittelbare Nachfolge setzt eine tatsächliche Zustandsänderung voraus.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.927'
);

UPDATE equations
SET section_id=@section_id,
    title='Notation unmittelbarer funktionaler Nachfolge',
    equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    plain_description='Notation für unmittelbare funktionale Nachfolge.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.928';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.928',
    @section_id,
    'Notation unmittelbarer funktionaler Nachfolge',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Notation für unmittelbare funktionale Nachfolge.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.928'
);

UPDATE equations
SET section_id=@section_id,
    title='Vorgängerbeziehung',
    equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    plain_description='Der erste Zustand ist unmittelbarer funktionaler Vorgänger des zweiten.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.929';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.929',
    @section_id,
    'Vorgängerbeziehung',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Der erste Zustand ist unmittelbarer funktionaler Vorgänger des zweiten.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.929'
);

UPDATE equations
SET section_id=@section_id,
    title='Menge funktionaler Vorgänger',
    equation_latex='\\operatorname{Pred}_F\\left(z_F^{(j)}\\right)=\\left\\{z_F^{(i)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    word_latex='\\operatorname{Pred}_F\\left(z_F^{(j)}\\right)=\\left\\{z_F^{(i)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    plain_description='Menge aller unmittelbaren funktionalen Vorgänger.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.930';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.930',
    @section_id,
    'Menge funktionaler Vorgänger',
    '\\operatorname{Pred}_F\\left(z_F^{(j)}\\right)=\\left\\{z_F^{(i)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    '\\operatorname{Pred}_F\\left(z_F^{(j)}\\right)=\\left\\{z_F^{(i)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    'Menge aller unmittelbaren funktionalen Vorgänger.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.930'
);

UPDATE equations
SET section_id=@section_id,
    title='Menge funktionaler Nachfolger',
    equation_latex='\\operatorname{Succ}_F\\left(z_F^{(i)}\\right)=\\left\\{z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    word_latex='\\operatorname{Succ}_F\\left(z_F^{(i)}\\right)=\\left\\{z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    plain_description='Menge aller unmittelbaren funktionalen Nachfolger.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.931';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.931',
    @section_id,
    'Menge funktionaler Nachfolger',
    '\\operatorname{Succ}_F\\left(z_F^{(i)}\\right)=\\left\\{z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    '\\operatorname{Succ}_F\\left(z_F^{(i)}\\right)=\\left\\{z_F^{(j)}\\in\\Omega_F^{K}(\\mathcal S)\\middle|z_F^{(i)}\\prec_F z_F^{(j)}\\right\\}',
    'Menge aller unmittelbaren funktionalen Nachfolger.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.931'
);

UPDATE equations
SET section_id=@section_id,
    title='Gerichtete Nachfolge',
    equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    plain_description='Gerichtete unmittelbare Nachfolge vom Vorgänger zum Nachfolger.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.932';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.932',
    @section_id,
    'Gerichtete Nachfolge',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Gerichtete unmittelbare Nachfolge vom Vorgänger zum Nachfolger.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.932'
);

UPDATE equations
SET section_id=@section_id,
    title='Fehlende automatische Umkehrung',
    equation_latex='z_F^{(j)}\\prec_F z_F^{(i)}',
    word_latex='z_F^{(j)}\\prec_F z_F^{(i)}',
    plain_description='Die umgekehrte Nachfolge folgt nicht automatisch.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.933';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.933',
    @section_id,
    'Fehlende automatische Umkehrung',
    'z_F^{(j)}\\prec_F z_F^{(i)}',
    'z_F^{(j)}\\prec_F z_F^{(i)}',
    'Die umgekehrte Nachfolge folgt nicht automatisch.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.933'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionale Vorordnung',
    equation_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    plain_description='Notation für mittelbare funktionale Vorordnung.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.934';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.934',
    @section_id,
    'Funktionale Vorordnung',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'Notation für mittelbare funktionale Vorordnung.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.934'
);

UPDATE equations
SET section_id=@section_id,
    title='Transitive Hülle der Nachfolge',
    equation_latex='\\prec_F^{*}=\\left(\\prec_F\\right)^{+}',
    word_latex='\\prec_F^{*}=\\left(\\prec_F\\right)^{+}',
    plain_description='Die funktionale Vorordnung ist die transitive nichtreflexive Hülle.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.935';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.935',
    @section_id,
    'Transitive Hülle der Nachfolge',
    '\\prec_F^{*}=\\left(\\prec_F\\right)^{+}',
    '\\prec_F^{*}=\\left(\\prec_F\\right)^{+}',
    'Die funktionale Vorordnung ist die transitive nichtreflexive Hülle.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.935'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionales Früher',
    equation_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    plain_description='Der erste Zustand ist funktional früher als der zweite.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.936';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.936',
    @section_id,
    'Funktionales Früher',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'Der erste Zustand ist funktional früher als der zweite.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.936'
);

UPDATE equations
SET section_id=@section_id,
    title='Reflexive funktionale Vorordnung',
    equation_latex='z_F^{(i)}\\preceq_F z_F^{(j)}\\Longleftrightarrow z_F^{(i)}=z_F^{(j)}\\lor z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    word_latex='z_F^{(i)}\\preceq_F z_F^{(j)}\\Longleftrightarrow z_F^{(i)}=z_F^{(j)}\\lor z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    plain_description='Reflexive Erweiterung der funktionalen Vorordnung.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.937';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.937',
    @section_id,
    'Reflexive funktionale Vorordnung',
    'z_F^{(i)}\\preceq_F z_F^{(j)}\\Longleftrightarrow z_F^{(i)}=z_F^{(j)}\\lor z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'z_F^{(i)}\\preceq_F z_F^{(j)}\\Longleftrightarrow z_F^{(i)}=z_F^{(j)}\\lor z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'Reflexive Erweiterung der funktionalen Vorordnung.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.937'
);

UPDATE equations
SET section_id=@section_id,
    title='Erste Voraussetzung der Transitivität',
    equation_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    plain_description='Erster Teilpfad der Transitivitätsaussage.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.938';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.938',
    @section_id,
    'Erste Voraussetzung der Transitivität',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'Erster Teilpfad der Transitivitätsaussage.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.938'
);

UPDATE equations
SET section_id=@section_id,
    title='Zweite Voraussetzung der Transitivität',
    equation_latex='z_F^{(j)}\\prec_F^{*} z_F^{(k)}',
    word_latex='z_F^{(j)}\\prec_F^{*} z_F^{(k)}',
    plain_description='Zweiter Teilpfad der Transitivitätsaussage.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.939';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.939',
    @section_id,
    'Zweite Voraussetzung der Transitivität',
    'z_F^{(j)}\\prec_F^{*} z_F^{(k)}',
    'z_F^{(j)}\\prec_F^{*} z_F^{(k)}',
    'Zweiter Teilpfad der Transitivitätsaussage.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.939'
);

UPDATE equations
SET section_id=@section_id,
    title='Transitive Schlussfolgerung',
    equation_latex='z_F^{(i)}\\prec_F^{*} z_F^{(k)}',
    word_latex='z_F^{(i)}\\prec_F^{*} z_F^{(k)}',
    plain_description='Verkettung der Teilpfade erzeugt eine funktionale Vorordnung.',
    equation_type='lemma',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.940';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.940',
    @section_id,
    'Transitive Schlussfolgerung',
    'z_F^{(i)}\\prec_F^{*} z_F^{(k)}',
    'z_F^{(i)}\\prec_F^{*} z_F^{(k)}',
    'Verkettung der Teilpfade erzeugt eine funktionale Vorordnung.',
    'lemma',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.940'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionaler Zyklus als Zustandsfolge',
    equation_latex='\\mathcal C_F=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
    word_latex='\\mathcal C_F=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
    plain_description='Endliche Zustandsfolge eines funktionalen Zyklus.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.941';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.941',
    @section_id,
    'Funktionaler Zyklus als Zustandsfolge',
    '\\mathcal C_F=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
    '\\mathcal C_F=\\left(z_F^{(0)},z_F^{(1)},\\ldots,z_F^{(n)}\\right)',
    'Endliche Zustandsfolge eines funktionalen Zyklus.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.941'
);

UPDATE equations
SET section_id=@section_id,
    title='Rückkehr zum Ausgangszustand',
    equation_latex='z_F^{(0)}=z_F^{(n)}',
    word_latex='z_F^{(0)}=z_F^{(n)}',
    plain_description='Ein funktionaler Zyklus endet im Ausgangszustand.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.942';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.942',
    @section_id,
    'Rückkehr zum Ausgangszustand',
    'z_F^{(0)}=z_F^{(n)}',
    'z_F^{(0)}=z_F^{(n)}',
    'Ein funktionaler Zyklus endet im Ausgangszustand.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.942'
);

UPDATE equations
SET section_id=@section_id,
    title='Nachfolge innerhalb eines Zyklus',
    equation_latex='z_F^{(k)}\\prec_F z_F^{(k+1)}',
    word_latex='z_F^{(k)}\\prec_F z_F^{(k+1)}',
    plain_description='Jeder Zyklusschritt ist eine unmittelbare nichtidentische Nachfolge.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.943';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.943',
    @section_id,
    'Nachfolge innerhalb eines Zyklus',
    'z_F^{(k)}\\prec_F z_F^{(k+1)}',
    'z_F^{(k)}\\prec_F z_F^{(k+1)}',
    'Jeder Zyklusschritt ist eine unmittelbare nichtidentische Nachfolge.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.943'
);

UPDATE equations
SET section_id=@section_id,
    title='Azyklischer funktionaler Bereich',
    equation_latex='\\Omega_F^{A}(\\mathcal S)\\subseteq\\Omega_F^{K}(\\mathcal S)',
    word_latex='\\Omega_F^{A}(\\mathcal S)\\subseteq\\Omega_F^{K}(\\mathcal S)',
    plain_description='Ein azyklischer Bereich ist Teilmenge des kohärenten Zustandsraums.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.944';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.944',
    @section_id,
    'Azyklischer funktionaler Bereich',
    '\\Omega_F^{A}(\\mathcal S)\\subseteq\\Omega_F^{K}(\\mathcal S)',
    '\\Omega_F^{A}(\\mathcal S)\\subseteq\\Omega_F^{K}(\\mathcal S)',
    'Ein azyklischer Bereich ist Teilmenge des kohärenten Zustandsraums.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.944'
);

UPDATE equations
SET section_id=@section_id,
    title='Ausschluss funktionaler Selbstvorordnung',
    equation_latex='z_F\\prec_F^{*} z_F',
    word_latex='z_F\\prec_F^{*} z_F',
    plain_description='Die Azyklizitätsbedingung schließt nichtleere Rückkehrpfade aus.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.945';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.945',
    @section_id,
    'Ausschluss funktionaler Selbstvorordnung',
    'z_F\\prec_F^{*} z_F',
    'z_F\\prec_F^{*} z_F',
    'Die Azyklizitätsbedingung schließt nichtleere Rückkehrpfade aus.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.945'
);

UPDATE equations
SET section_id=@section_id,
    title='Erste Ordnungsannahme',
    equation_latex='z_F^{(i)}\\preceq_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\preceq_F z_F^{(j)}',
    plain_description='Erste Annahme zur Antisymmetrie.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.946';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.946',
    @section_id,
    'Erste Ordnungsannahme',
    'z_F^{(i)}\\preceq_F z_F^{(j)}',
    'z_F^{(i)}\\preceq_F z_F^{(j)}',
    'Erste Annahme zur Antisymmetrie.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.946'
);

UPDATE equations
SET section_id=@section_id,
    title='Zweite Ordnungsannahme',
    equation_latex='z_F^{(j)}\\preceq_F z_F^{(i)}',
    word_latex='z_F^{(j)}\\preceq_F z_F^{(i)}',
    plain_description='Zweite Annahme zur Antisymmetrie.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.947';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.947',
    @section_id,
    'Zweite Ordnungsannahme',
    'z_F^{(j)}\\preceq_F z_F^{(i)}',
    'z_F^{(j)}\\preceq_F z_F^{(i)}',
    'Zweite Annahme zur Antisymmetrie.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.947'
);

UPDATE equations
SET section_id=@section_id,
    title='Antisymmetrische Identität',
    equation_latex='z_F^{(i)}=z_F^{(j)}',
    word_latex='z_F^{(i)}=z_F^{(j)}',
    plain_description='In azyklischen Bereichen erzwingt wechselseitige Vorordnung Zustandsidentität.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.948';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.948',
    @section_id,
    'Antisymmetrische Identität',
    'z_F^{(i)}=z_F^{(j)}',
    'z_F^{(i)}=z_F^{(j)}',
    'In azyklischen Bereichen erzwingt wechselseitige Vorordnung Zustandsidentität.',
    'theorem',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.948'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionale Zustandsinstanz',
    equation_latex='\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)',
    word_latex='\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)',
    plain_description='Ein Zustand wird mit seiner Pfadposition zu einer Zustandsinstanz verbunden.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.949';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.949',
    @section_id,
    'Funktionale Zustandsinstanz',
    '\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)',
    '\\zeta_F^{(k)}=\\left(z_F^{(k)},k\\right)',
    'Ein Zustand wird mit seiner Pfadposition zu einer Zustandsinstanz verbunden.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.949'
);

UPDATE equations
SET section_id=@section_id,
    title='Wiederholung desselben Zustands',
    equation_latex='z_F^{(i)}=z_F^{(j)}',
    word_latex='z_F^{(i)}=z_F^{(j)}',
    plain_description='Ein funktionaler Zustand kann innerhalb eines Pfades wiederholt auftreten.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.950';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.950',
    @section_id,
    'Wiederholung desselben Zustands',
    'z_F^{(i)}=z_F^{(j)}',
    'z_F^{(i)}=z_F^{(j)}',
    'Ein funktionaler Zustand kann innerhalb eines Pfades wiederholt auftreten.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.950'
);

UPDATE equations
SET section_id=@section_id,
    title='Unterschiedliche Instanzen desselben Zustands',
    equation_latex='\\zeta_F^{(i)}\\neq\\zeta_F^{(j)},\\qquad i\\neq j',
    word_latex='\\zeta_F^{(i)}\\neq\\zeta_F^{(j)},\\qquad i\\neq j',
    plain_description='Gleiche Zustände an verschiedenen Pfadpositionen sind verschiedene Instanzen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.951';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.951',
    @section_id,
    'Unterschiedliche Instanzen desselben Zustands',
    '\\zeta_F^{(i)}\\neq\\zeta_F^{(j)},\\qquad i\\neq j',
    '\\zeta_F^{(i)}\\neq\\zeta_F^{(j)},\\qquad i\\neq j',
    'Gleiche Zustände an verschiedenen Pfadpositionen sind verschiedene Instanzen.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.951'
);

UPDATE equations
SET section_id=@section_id,
    title='Strikte instanzielle Vorordnung',
    equation_latex='\\zeta_F^{(i)}\\triangleleft_F\\zeta_F^{(j)}\\Longleftrightarrow i<j',
    word_latex='\\zeta_F^{(i)}\\triangleleft_F\\zeta_F^{(j)}\\Longleftrightarrow i<j',
    plain_description='Strikte Ordnung von Zustandsinstanzen anhand ihrer Position.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.952';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.952',
    @section_id,
    'Strikte instanzielle Vorordnung',
    '\\zeta_F^{(i)}\\triangleleft_F\\zeta_F^{(j)}\\Longleftrightarrow i<j',
    '\\zeta_F^{(i)}\\triangleleft_F\\zeta_F^{(j)}\\Longleftrightarrow i<j',
    'Strikte Ordnung von Zustandsinstanzen anhand ihrer Position.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.952'
);

UPDATE equations
SET section_id=@section_id,
    title='Reflexive instanzielle Vorordnung',
    equation_latex='\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    word_latex='\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    plain_description='Reflexive Ordnung von Zustandsinstanzen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.953';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.953',
    @section_id,
    'Reflexive instanzielle Vorordnung',
    '\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    '\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    'Reflexive Ordnung von Zustandsinstanzen.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.953'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionaler Entwicklungspfad',
    equation_latex='\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
    word_latex='\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
    plain_description='Entwicklungspfad als Grundlage der funktionalen Zeitstruktur.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.954';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.954',
    @section_id,
    'Funktionaler Entwicklungspfad',
    '\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
    '\\mathcal P_F^{(n)}=\\left(z_F^{(0)},O_{F,1},z_F^{(1)},\\ldots,O_{F,n},z_F^{(n)}\\right)',
    'Entwicklungspfad als Grundlage der funktionalen Zeitstruktur.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.954'
);

UPDATE equations
SET section_id=@section_id,
    title='Menge der Zustandsinstanzen',
    equation_latex='\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\zeta_F^{(0)},\\zeta_F^{(1)},\\ldots,\\zeta_F^{(n)}\\right\\}',
    word_latex='\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\zeta_F^{(0)},\\zeta_F^{(1)},\\ldots,\\zeta_F^{(n)}\\right\\}',
    plain_description='Menge aller Zustandsinstanzen eines Entwicklungspfades.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.955';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.955',
    @section_id,
    'Menge der Zustandsinstanzen',
    '\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\zeta_F^{(0)},\\zeta_F^{(1)},\\ldots,\\zeta_F^{(n)}\\right\\}',
    '\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)=\\left\\{\\zeta_F^{(0)},\\zeta_F^{(1)},\\ldots,\\zeta_F^{(n)}\\right\\}',
    'Menge aller Zustandsinstanzen eines Entwicklungspfades.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.955'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionale Zeitstruktur',
    equation_latex='\\mathfrak T_F\\left(\\mathcal P_F^{(n)}\\right)=\\left(\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right),\\unlhd_F\\right)',
    word_latex='\\mathfrak T_F\\left(\\mathcal P_F^{(n)}\\right)=\\left(\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right),\\unlhd_F\\right)',
    plain_description='Zeitstruktur als geordnete Menge der Zustandsinstanzen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.956';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.956',
    @section_id,
    'Funktionale Zeitstruktur',
    '\\mathfrak T_F\\left(\\mathcal P_F^{(n)}\\right)=\\left(\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right),\\unlhd_F\\right)',
    '\\mathfrak T_F\\left(\\mathcal P_F^{(n)}\\right)=\\left(\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right),\\unlhd_F\\right)',
    'Zeitstruktur als geordnete Menge der Zustandsinstanzen.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.956'
);

UPDATE equations
SET section_id=@section_id,
    title='Nichtidentischer funktionaler Übergang',
    equation_latex='z_F^{(0)}\\prec_F z_F^{(1)}',
    word_latex='z_F^{(0)}\\prec_F z_F^{(1)}',
    plain_description='Mindestens ein nichtidentischer Übergang begründet eine nichttriviale Zeitstruktur.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.957';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.957',
    @section_id,
    'Nichtidentischer funktionaler Übergang',
    'z_F^{(0)}\\prec_F z_F^{(1)}',
    'z_F^{(0)}\\prec_F z_F^{(1)}',
    'Mindestens ein nichtidentischer Übergang begründet eine nichttriviale Zeitstruktur.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.957'
);

UPDATE equations
SET section_id=@section_id,
    title='Erste Zustandsinstanz',
    equation_latex='\\zeta_F^{(0)}=\\left(z_F^{(0)},0\\right)',
    word_latex='\\zeta_F^{(0)}=\\left(z_F^{(0)},0\\right)',
    plain_description='Ausgangsinstanz des Übergangs.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.958';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.958',
    @section_id,
    'Erste Zustandsinstanz',
    '\\zeta_F^{(0)}=\\left(z_F^{(0)},0\\right)',
    '\\zeta_F^{(0)}=\\left(z_F^{(0)},0\\right)',
    'Ausgangsinstanz des Übergangs.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.958'
);

UPDATE equations
SET section_id=@section_id,
    title='Zweite Zustandsinstanz',
    equation_latex='\\zeta_F^{(1)}=\\left(z_F^{(1)},1\\right)',
    word_latex='\\zeta_F^{(1)}=\\left(z_F^{(1)},1\\right)',
    plain_description='Nachfolgeinstanz des Übergangs.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.959';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.959',
    @section_id,
    'Zweite Zustandsinstanz',
    '\\zeta_F^{(1)}=\\left(z_F^{(1)},1\\right)',
    '\\zeta_F^{(1)}=\\left(z_F^{(1)},1\\right)',
    'Nachfolgeinstanz des Übergangs.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.959'
);

UPDATE equations
SET section_id=@section_id,
    title='Zeitliche Ordnung zweier Instanzen',
    equation_latex='\\zeta_F^{(0)}\\triangleleft_F\\zeta_F^{(1)}',
    word_latex='\\zeta_F^{(0)}\\triangleleft_F\\zeta_F^{(1)}',
    plain_description='Die Ausgangsinstanz liegt vor der Nachfolgeinstanz.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.960';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.960',
    @section_id,
    'Zeitliche Ordnung zweier Instanzen',
    '\\zeta_F^{(0)}\\triangleleft_F\\zeta_F^{(1)}',
    '\\zeta_F^{(0)}\\triangleleft_F\\zeta_F^{(1)}',
    'Die Ausgangsinstanz liegt vor der Nachfolgeinstanz.',
    'theorem',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.960'
);

UPDATE equations
SET section_id=@section_id,
    title='Reine Identitätsentwicklung',
    equation_latex='z_F^{(k+1)}=z_F^{(k)}\\qquad\\text{für alle }k',
    word_latex='z_F^{(k+1)}=z_F^{(k)}\\qquad\\text{für alle }k',
    plain_description='Ohne registrierte Zustandsunterscheidung entsteht keine unterscheidbare funktionale Zeit.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.961';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.961',
    @section_id,
    'Reine Identitätsentwicklung',
    'z_F^{(k+1)}=z_F^{(k)}\\qquad\\text{für alle }k',
    'z_F^{(k+1)}=z_F^{(k)}\\qquad\\text{für alle }k',
    'Ohne registrierte Zustandsunterscheidung entsteht keine unterscheidbare funktionale Zeit.',
    'derived',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.961'
);

UPDATE equations
SET section_id=@section_id,
    title='Diskrete funktionale Zeitdifferenz',
    equation_latex='\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=j-i',
    word_latex='\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=j-i',
    plain_description='Die funktionale Zeitdifferenz zählt Übergänge zwischen Zustandsinstanzen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.962';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.962',
    @section_id,
    'Diskrete funktionale Zeitdifferenz',
    '\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=j-i',
    '\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=j-i',
    'Die funktionale Zeitdifferenz zählt Übergänge zwischen Zustandsinstanzen.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.962'
);

UPDATE equations
SET section_id=@section_id,
    title='Einheitsdifferenz aufeinanderfolgender Instanzen',
    equation_latex='\\Delta\\tau_F\\left(\\zeta_F^{(k)},\\zeta_F^{(k+1)}\\right)=1',
    word_latex='\\Delta\\tau_F\\left(\\zeta_F^{(k)},\\zeta_F^{(k+1)}\\right)=1',
    plain_description='Aufeinanderfolgende Instanzen unterscheiden sich um einen Übergang.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.963';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.963',
    @section_id,
    'Einheitsdifferenz aufeinanderfolgender Instanzen',
    '\\Delta\\tau_F\\left(\\zeta_F^{(k)},\\zeta_F^{(k+1)}\\right)=1',
    '\\Delta\\tau_F\\left(\\zeta_F^{(k)},\\zeta_F^{(k+1)}\\right)=1',
    'Aufeinanderfolgende Instanzen unterscheiden sich um einen Übergang.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.963'
);

UPDATE equations
SET section_id=@section_id,
    title='Geordnete Indizes',
    equation_latex='i\\leq j\\leq k',
    word_latex='i\\leq j\\leq k',
    plain_description='Voraussetzung der Additivität diskreter Zeitdifferenzen.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.964';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.964',
    @section_id,
    'Geordnete Indizes',
    'i\\leq j\\leq k',
    'i\\leq j\\leq k',
    'Voraussetzung der Additivität diskreter Zeitdifferenzen.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.964'
);

UPDATE equations
SET section_id=@section_id,
    title='Additivität diskreter funktionaler Zeit',
    equation_latex='\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    word_latex='\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    plain_description='Diskrete funktionale Zeitdifferenzen sind additiv.',
    equation_type='lemma',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.965';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.965',
    @section_id,
    'Additivität diskreter funktionaler Zeit',
    '\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    '\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    'Diskrete funktionale Zeitdifferenzen sind additiv.',
    'lemma',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.965'
);

UPDATE equations
SET section_id=@section_id,
    title='Zeitdifferenz als Indexdifferenz',
    equation_latex='\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=k-i',
    word_latex='\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=k-i',
    plain_description='Definition der gesamten diskreten Zeitdifferenz.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.966';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.966',
    @section_id,
    'Zeitdifferenz als Indexdifferenz',
    '\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=k-i',
    '\\Delta\\tau_F\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=k-i',
    'Definition der gesamten diskreten Zeitdifferenz.',
    'derived',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.966'
);

UPDATE equations
SET section_id=@section_id,
    title='Zerlegung der Indexdifferenz',
    equation_latex='k-i=(j-i)+(k-j)',
    word_latex='k-i=(j-i)+(k-j)',
    plain_description='Algebraische Zerlegung der Indexdifferenz.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.967';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.967',
    @section_id,
    'Zerlegung der Indexdifferenz',
    'k-i=(j-i)+(k-j)',
    'k-i=(j-i)+(k-j)',
    'Algebraische Zerlegung der Indexdifferenz.',
    'derived',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.967'
);

UPDATE equations
SET section_id=@section_id,
    title='Endliche natürliche Ordnung',
    equation_latex='\\left(\\{0,1,\\ldots,n\\},\\leq\\right)',
    word_latex='\\left(\\{0,1,\\ldots,n\\},\\leq\\right)',
    plain_description='Referenzordnung für endliche funktionale Pfadzeiten.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.968';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.968',
    @section_id,
    'Endliche natürliche Ordnung',
    '\\left(\\{0,1,\\ldots,n\\},\\leq\\right)',
    '\\left(\\{0,1,\\ldots,n\\},\\leq\\right)',
    'Referenzordnung für endliche funktionale Pfadzeiten.',
    'theorem',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.968'
);

UPDATE equations
SET section_id=@section_id,
    title='Ordnungsisomorphismus',
    equation_latex='\\varphi_F:\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)\\to\\{0,1,\\ldots,n\\},\\qquad\\varphi_F\\left(\\zeta_F^{(k)}\\right)=k',
    word_latex='\\varphi_F:\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)\\to\\{0,1,\\ldots,n\\},\\qquad\\varphi_F\\left(\\zeta_F^{(k)}\\right)=k',
    plain_description='Bijektive Zuordnung von Zustandsinstanzen zu ihren Indizes.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.969';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.969',
    @section_id,
    'Ordnungsisomorphismus',
    '\\varphi_F:\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)\\to\\{0,1,\\ldots,n\\},\\qquad\\varphi_F\\left(\\zeta_F^{(k)}\\right)=k',
    '\\varphi_F:\\mathcal Z_F\\left(\\mathcal P_F^{(n)}\\right)\\to\\{0,1,\\ldots,n\\},\\qquad\\varphi_F\\left(\\zeta_F^{(k)}\\right)=k',
    'Bijektive Zuordnung von Zustandsinstanzen zu ihren Indizes.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.969'
);

UPDATE equations
SET section_id=@section_id,
    title='Ordnungserhaltung',
    equation_latex='\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    word_latex='\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    plain_description='Der Isomorphismus erhält die Ordnung.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.970';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.970',
    @section_id,
    'Ordnungserhaltung',
    '\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    '\\zeta_F^{(i)}\\unlhd_F\\zeta_F^{(j)}\\Longleftrightarrow i\\leq j',
    'Der Isomorphismus erhält die Ordnung.',
    'theorem',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.970'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionales Übergangsgewicht',
    equation_latex='w_F:\\mathcal O_F^{K}(\\mathcal S)\\times\\Omega_F^{K}(\\mathcal S)\\to\\mathbb R_{\\geq 0}',
    word_latex='w_F:\\mathcal O_F^{K}(\\mathcal S)\\times\\Omega_F^{K}(\\mathcal S)\\to\\mathbb R_{\\geq 0}',
    plain_description='Nichtnegative Gewichtsfunktion für ausgeführte Operatoren.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.971';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.971',
    @section_id,
    'Funktionales Übergangsgewicht',
    'w_F:\\mathcal O_F^{K}(\\mathcal S)\\times\\Omega_F^{K}(\\mathcal S)\\to\\mathbb R_{\\geq 0}',
    'w_F:\\mathcal O_F^{K}(\\mathcal S)\\times\\Omega_F^{K}(\\mathcal S)\\to\\mathbb R_{\\geq 0}',
    'Nichtnegative Gewichtsfunktion für ausgeführte Operatoren.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.971'
);

UPDATE equations
SET section_id=@section_id,
    title='Wert eines Übergangsgewichts',
    equation_latex='w_F\\left(O_F,z_F\\right)',
    word_latex='w_F\\left(O_F,z_F\\right)',
    plain_description='Gewicht eines Operators in einem Zustand.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.972';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.972',
    @section_id,
    'Wert eines Übergangsgewichts',
    'w_F\\left(O_F,z_F\\right)',
    'w_F\\left(O_F,z_F\\right)',
    'Gewicht eines Operators in einem Zustand.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.972'
);

UPDATE equations
SET section_id=@section_id,
    title='Gewichtete funktionale Zeitdifferenz',
    equation_latex='\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=\\sum_{k=i}^{j-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)',
    word_latex='\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=\\sum_{k=i}^{j-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)',
    plain_description='Summe der Übergangsgewichte zwischen zwei Zustandsinstanzen.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.973';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.973',
    @section_id,
    'Gewichtete funktionale Zeitdifferenz',
    '\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=\\sum_{k=i}^{j-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)',
    '\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)=\\sum_{k=i}^{j-1}w_F\\left(O_{F,k+1},z_F^{(k)}\\right)',
    'Summe der Übergangsgewichte zwischen zwei Zustandsinstanzen.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.973'
);

UPDATE equations
SET section_id=@section_id,
    title='Einheitliche Übergangsgewichtung',
    equation_latex='w_F\\left(O_F,z_F\\right)=1',
    word_latex='w_F\\left(O_F,z_F\\right)=1',
    plain_description='Einheitsgewichtung aller funktionalen Übergänge.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.974';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.974',
    @section_id,
    'Einheitliche Übergangsgewichtung',
    'w_F\\left(O_F,z_F\\right)=1',
    'w_F\\left(O_F,z_F\\right)=1',
    'Einheitsgewichtung aller funktionalen Übergänge.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.974'
);

UPDATE equations
SET section_id=@section_id,
    title='Übergang zur diskreten Zeitdifferenz',
    equation_latex='\\Delta\\tau_F^{w}=\\Delta\\tau_F',
    word_latex='\\Delta\\tau_F^{w}=\\Delta\\tau_F',
    plain_description='Bei Einheitsgewichtung stimmen gewichtete und diskrete Zeit überein.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.975';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.975',
    @section_id,
    'Übergang zur diskreten Zeitdifferenz',
    '\\Delta\\tau_F^{w}=\\Delta\\tau_F',
    '\\Delta\\tau_F^{w}=\\Delta\\tau_F',
    'Bei Einheitsgewichtung stimmen gewichtete und diskrete Zeit überein.',
    'derived',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.975'
);

UPDATE equations
SET section_id=@section_id,
    title='Additivität gewichteter funktionaler Zeit',
    equation_latex='\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F^{w}\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    word_latex='\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F^{w}\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    plain_description='Gewichtete funktionale Zeit ist entlang eines Pfades additiv.',
    equation_type='derived',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.976';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.976',
    @section_id,
    'Additivität gewichteter funktionaler Zeit',
    '\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F^{w}\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    '\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(k)}\\right)=\\Delta\\tau_F^{w}\\left(\\zeta_F^{(i)},\\zeta_F^{(j)}\\right)+\\Delta\\tau_F^{w}\\left(\\zeta_F^{(j)},\\zeta_F^{(k)}\\right)',
    'Gewichtete funktionale Zeit ist entlang eines Pfades additiv.',
    'derived',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.976'
);

UPDATE equations
SET section_id=@section_id,
    title='Erste Vergleichsrichtung',
    equation_latex='z_F^{(i)}\\preceq_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\preceq_F z_F^{(j)}',
    plain_description='Erste mögliche funktionale Vergleichsrichtung.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.977';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.977',
    @section_id,
    'Erste Vergleichsrichtung',
    'z_F^{(i)}\\preceq_F z_F^{(j)}',
    'z_F^{(i)}\\preceq_F z_F^{(j)}',
    'Erste mögliche funktionale Vergleichsrichtung.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.977'
);

UPDATE equations
SET section_id=@section_id,
    title='Zweite Vergleichsrichtung',
    equation_latex='z_F^{(j)}\\preceq_F z_F^{(i)}',
    word_latex='z_F^{(j)}\\preceq_F z_F^{(i)}',
    plain_description='Zweite mögliche funktionale Vergleichsrichtung.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.978';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.978',
    @section_id,
    'Zweite Vergleichsrichtung',
    'z_F^{(j)}\\preceq_F z_F^{(i)}',
    'z_F^{(j)}\\preceq_F z_F^{(i)}',
    'Zweite mögliche funktionale Vergleichsrichtung.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.978'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionale Unvergleichbarkeit',
    equation_latex='z_F^{(i)}\\parallel_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\parallel_F z_F^{(j)}',
    plain_description='Notation für funktional unvergleichbare Zustände.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.979';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.979',
    @section_id,
    'Funktionale Unvergleichbarkeit',
    'z_F^{(i)}\\parallel_F z_F^{(j)}',
    'z_F^{(i)}\\parallel_F z_F^{(j)}',
    'Notation für funktional unvergleichbare Zustände.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.979'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionaler Zeitschnitt',
    equation_latex='\\Sigma_F\\subseteq\\Omega_F^{K}(\\mathcal S)',
    word_latex='\\Sigma_F\\subseteq\\Omega_F^{K}(\\mathcal S)',
    plain_description='Ein Zeitschnitt ist eine Teilmenge des kohärenten Zustandsraums.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.980';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.980',
    @section_id,
    'Funktionaler Zeitschnitt',
    '\\Sigma_F\\subseteq\\Omega_F^{K}(\\mathcal S)',
    '\\Sigma_F\\subseteq\\Omega_F^{K}(\\mathcal S)',
    'Ein Zeitschnitt ist eine Teilmenge des kohärenten Zustandsraums.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.980'
);

UPDATE equations
SET section_id=@section_id,
    title='Paarweise Unvergleichbarkeit im Zeitschnitt',
    equation_latex='\\forall z_F^{(i)},z_F^{(j)}\\in\\Sigma_F,\\quad i\\neq j:\\quad z_F^{(i)}\\parallel_F z_F^{(j)}',
    word_latex='\\forall z_F^{(i)},z_F^{(j)}\\in\\Sigma_F,\\quad i\\neq j:\\quad z_F^{(i)}\\parallel_F z_F^{(j)}',
    plain_description='Alle verschiedenen Zustände eines Zeitschnitts sind unvergleichbar.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.981';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.981',
    @section_id,
    'Paarweise Unvergleichbarkeit im Zeitschnitt',
    '\\forall z_F^{(i)},z_F^{(j)}\\in\\Sigma_F,\\quad i\\neq j:\\quad z_F^{(i)}\\parallel_F z_F^{(j)}',
    '\\forall z_F^{(i)},z_F^{(j)}\\in\\Sigma_F,\\quad i\\neq j:\\quad z_F^{(i)}\\parallel_F z_F^{(j)}',
    'Alle verschiedenen Zustände eines Zeitschnitts sind unvergleichbar.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.981'
);

UPDATE equations
SET section_id=@section_id,
    title='Funktionale Zeitrichtung',
    equation_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F z_F^{(j)}',
    plain_description='Zeitliche Orientierung vom funktionalen Vorgänger zum Nachfolger.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.982';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.982',
    @section_id,
    'Funktionale Zeitrichtung',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'z_F^{(i)}\\prec_F z_F^{(j)}',
    'Zeitliche Orientierung vom funktionalen Vorgänger zum Nachfolger.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.982'
);

UPDATE equations
SET section_id=@section_id,
    title='Rückoperator',
    equation_latex='O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    word_latex='O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    plain_description='Ein Rückoperator führt den Folgezustand zum Ausgangszustand zurück.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.983';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.983',
    @section_id,
    'Rückoperator',
    'O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    'O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    'Ein Rückoperator führt den Folgezustand zum Ausgangszustand zurück.',
    'definition',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.983'
);

UPDATE equations
SET section_id=@section_id,
    title='Nichtableitbarkeit eines Rückoperators',
    equation_latex='\\exists O_F:O_F\\left(z_F^{(i)}\\right)=z_F^{(j)}\\nRightarrow\\exists O_F^{-}:O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    word_latex='\\exists O_F:O_F\\left(z_F^{(i)}\\right)=z_F^{(j)}\\nRightarrow\\exists O_F^{-}:O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    plain_description='Aus einem Hinoperator folgt nicht automatisch ein Rückoperator.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.984';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.984',
    @section_id,
    'Nichtableitbarkeit eines Rückoperators',
    '\\exists O_F:O_F\\left(z_F^{(i)}\\right)=z_F^{(j)}\\nRightarrow\\exists O_F^{-}:O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    '\\exists O_F:O_F\\left(z_F^{(i)}\\right)=z_F^{(j)}\\nRightarrow\\exists O_F^{-}:O_F^{-}\\left(z_F^{(j)}\\right)=z_F^{(i)}',
    'Aus einem Hinoperator folgt nicht automatisch ein Rückoperator.',
    'theorem',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.984'
);

UPDATE equations
SET section_id=@section_id,
    title='Gerichtete funktionale Vorordnung',
    equation_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    word_latex='z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    plain_description='Der Folgezustand ist über einen funktionalen Pfad erreichbar.',
    equation_type='other',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.985';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.985',
    @section_id,
    'Gerichtete funktionale Vorordnung',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'z_F^{(i)}\\prec_F^{*} z_F^{(j)}',
    'Der Folgezustand ist über einen funktionalen Pfad erreichbar.',
    'other',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.985'
);

UPDATE equations
SET section_id=@section_id,
    title='Fehlende Rückerreichbarkeit',
    equation_latex='z_F^{(j)}\\not\\leadsto_F z_F^{(i)}',
    word_latex='z_F^{(j)}\\not\\leadsto_F z_F^{(i)}',
    plain_description='Irreversibilität liegt vor, wenn kein kohärenzerhaltender Rückpfad existiert.',
    equation_type='theorem',
    provenance='original',
    source_id=NULL,
    derivation='Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    assumptions='Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.986';

INSERT INTO equations
(equation_number,section_id,title,equation_latex,word_latex,plain_description,equation_type,provenance,source_id,derivation,assumptions,validation_status,created_revision_id)
SELECT
    '3.986',
    @section_id,
    'Fehlende Rückerreichbarkeit',
    'z_F^{(j)}\\not\\leadsto_F z_F^{(i)}',
    'z_F^{(j)}\\not\\leadsto_F z_F^{(i)}',
    'Irreversibilität liegt vor, wenn kein kohärenzerhaltender Rückpfad existiert.',
    'theorem',
    'original',
    NULL,
    'Literaturgestützte Rekonstruktion in Abschnitt 3.4.9.',
    'Die funktionalen Zustands-, Kohärenz-, Raum- und Operatorstrukturen der Abschnitte 3.4.6 bis 3.4.8 werden vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM equations WHERE equation_number='3.986'
);


DELETE FROM definitions
WHERE definition_number IN (
'Definition 3.4.36','Definition 3.4.37','Definition 3.4.38','Definition 3.4.39',
'Definition 3.4.40','Definition 3.4.41','Definition 3.4.42','Definition 3.4.43',
'Definition 3.4.44','Definition 3.4.45','Definition 3.4.46','Definition 3.4.47',
'Definition 3.4.48','Definition 3.4.49'
);

INSERT INTO definitions
(definition_number,section_id,title,definition_text,formal_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Definition 3.4.36',@section_id,'Unmittelbare funktionale Nachfolge','Ein kohärenter Zustand ist unmittelbarer funktionaler Nachfolger eines anderen, wenn er durch einen kohärenzerhaltenden Operator erzeugt wird und vom Ausgangszustand verschieden ist.','z_F^{(i)}\\prec_F z_F^{(j)}','z_F^{(i)}\\prec_F z_F^{(j)}','original',NULL,'Kohärenter Zustandsraum und kohärenzerhaltende Operatoren.','checked',@revision_id),
('Definition 3.4.37',@section_id,'Funktionale Vorgängerrelation','Ein Zustand ist funktionaler Vorgänger eines anderen, wenn zwischen beiden die unmittelbare Nachfolgerrelation besteht.','\\operatorname{Pred}_F(z_F),\\operatorname{Succ}_F(z_F)','\\operatorname{Pred}_F(z_F),\\operatorname{Succ}_F(z_F)','original',NULL,'Kohärenter Zustandsraum und kohärenzerhaltende Operatoren.','checked',@revision_id),
('Definition 3.4.38',@section_id,'Funktionale Vorordnung','Ein Zustand ist funktional früher als ein anderer, wenn eine endliche Folge nichtidentischer kohärenzerhaltender Übergänge zwischen ihnen existiert.','z_F^{(i)}\\prec_F^{*}z_F^{(j)}','z_F^{(i)}\\prec_F^{*}z_F^{(j)}','original',NULL,'Unmittelbare funktionale Nachfolge.','checked',@revision_id),
('Definition 3.4.39',@section_id,'Funktionaler Zyklus','Ein funktionaler Zyklus ist eine endliche Folge nichtidentischer Nachfolgeübergänge, die erneut den Ausgangszustand erreicht.','\\mathcal C_F=(z_F^{(0)},\\ldots,z_F^{(n)}),\\;z_F^{(0)}=z_F^{(n)}','\\mathcal C_F=(z_F^{(0)},\\ldots,z_F^{(n)}),\\;z_F^{(0)}=z_F^{(n)}','original',NULL,'Funktionale Vorordnung und kohärenzerhaltende Übergänge.','checked',@revision_id),
('Definition 3.4.40',@section_id,'Azyklischer funktionaler Bereich','Ein kohärenter Zustandsbereich ist azyklisch, wenn kein Zustand über einen nichtleeren funktionalen Pfad zu sich selbst zurückkehrt.','\\Omega_F^{A}(\\mathcal S)\\subseteq\\Omega_F^{K}(\\mathcal S)','\\Omega_F^{A}(\\mathcal S)\\subseteq\\Omega_F^{K}(\\mathcal S)','original',NULL,'Funktionale Vorordnung.','checked',@revision_id),
('Definition 3.4.41',@section_id,'Funktionale Zustandsinstanz','Eine funktionale Zustandsinstanz verbindet einen Zustand mit seiner Position innerhalb eines bestimmten Entwicklungspfads.','\\zeta_F^{(k)}=(z_F^{(k)},k)','\\zeta_F^{(k)}=(z_F^{(k)},k)','original',NULL,'Geordneter funktionaler Entwicklungspfad.','checked',@revision_id),
('Definition 3.4.42',@section_id,'Instanzielle funktionale Vorordnung','Zustandsinstanzen desselben Entwicklungspfads werden entsprechend ihrer Positionsindizes streng oder reflexiv geordnet.','\\zeta_F^{(i)}\\triangleleft_F\\zeta_F^{(j)}\\Longleftrightarrow i<j','\\zeta_F^{(i)}\\triangleleft_F\\zeta_F^{(j)}\\Longleftrightarrow i<j','original',NULL,'Funktionale Zustandsinstanzen.','checked',@revision_id),
('Definition 3.4.43',@section_id,'Funktionale Zeitstruktur eines Entwicklungspfads','Die funktionale Zeitstruktur ist die geordnete Menge der Zustandsinstanzen eines Entwicklungspfads.','\\mathfrak T_F(\\mathcal P_F^{(n)})=(\\mathcal Z_F(\\mathcal P_F^{(n)}),\\unlhd_F)','\\mathfrak T_F(\\mathcal P_F^{(n)})=(\\mathcal Z_F(\\mathcal P_F^{(n)}),\\unlhd_F)','original',NULL,'Funktionale Zustandsinstanzen und instanzielle Vorordnung.','checked',@revision_id),
('Definition 3.4.44',@section_id,'Diskrete funktionale Zeitdifferenz','Die diskrete funktionale Zeitdifferenz ist die Anzahl der Übergangsschritte zwischen zwei geordneten Zustandsinstanzen desselben Pfades.','\\Delta\\tau_F(\\zeta_F^{(i)},\\zeta_F^{(j)})=j-i','\\Delta\\tau_F(\\zeta_F^{(i)},\\zeta_F^{(j)})=j-i','original',NULL,'Funktionale Zeitstruktur eines Entwicklungspfads.','checked',@revision_id),
('Definition 3.4.45',@section_id,'Funktionales Übergangsgewicht','Ein funktionales Übergangsgewicht ordnet einer ausgeführten Operatorwirkung in einem Zustand einen nichtnegativen Wert zu.','w_F:\\mathcal O_F^{K}(\\mathcal S)\\times\\Omega_F^{K}(\\mathcal S)\\to\\mathbb R_{\\geq0}','w_F:\\mathcal O_F^{K}(\\mathcal S)\\times\\Omega_F^{K}(\\mathcal S)\\to\\mathbb R_{\\geq0}','original',NULL,'Kohärenzerhaltende Operatoren und funktionale Zustände.','checked',@revision_id),
('Definition 3.4.46',@section_id,'Gewichtete funktionale Zeitdifferenz','Die gewichtete funktionale Zeitdifferenz ist die Summe der Übergangsgewichte zwischen zwei Zustandsinstanzen.','\\Delta\\tau_F^{w}=\\sum w_F(O_F,z_F)','\\Delta\\tau_F^{w}=\\sum w_F(O_F,z_F)','original',NULL,'Funktionales Übergangsgewicht und geordneter Entwicklungspfad.','checked',@revision_id),
('Definition 3.4.47',@section_id,'Funktionale Unvergleichbarkeit','Zwei Zustände sind funktional unvergleichbar, wenn in keiner Richtung eine funktionale Vorordnung besteht.','z_F^{(i)}\\parallel_F z_F^{(j)}','z_F^{(i)}\\parallel_F z_F^{(j)}','original',NULL,'Partielle funktionale Vorordnung.','checked',@revision_id),
('Definition 3.4.48',@section_id,'Funktionaler Zeitschnitt','Ein funktionaler Zeitschnitt ist eine Menge paarweise funktional unvergleichbarer Zustände.','\\Sigma_F\\subseteq\\Omega_F^{K}(\\mathcal S)','\\Sigma_F\\subseteq\\Omega_F^{K}(\\mathcal S)','original',NULL,'Funktionale Unvergleichbarkeit und partielle Ordnung.','checked',@revision_id),
('Definition 3.4.49',@section_id,'Funktionale Zeitrichtung','Die funktionale Zeitrichtung ist die gerichtete Ordnung vom funktionalen Vorgänger zum funktionalen Nachfolger.','z_F^{(i)}\\prec_F z_F^{(j)}','z_F^{(i)}\\prec_F z_F^{(j)}','original',NULL,'Funktionale Nachfolge und Vorordnung.','checked',@revision_id);

DELETE FROM lemmas
WHERE lemma_number IN ('Lemma 3.4.14','Lemma 3.4.15','Lemma 3.4.16');

INSERT INTO lemmas
(lemma_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Lemma 3.4.14',@section_id,'Transitivität der funktionalen Vorordnung','Die Verkettung zweier endlicher nichtidentischer Nachfolgepfade erzeugt erneut einen endlichen Nachfolgepfad.','z_F^{(i)}\\prec_F^{*}z_F^{(j)}\\land z_F^{(j)}\\prec_F^{*}z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F^{*}z_F^{(k)}','z_F^{(i)}\\prec_F^{*}z_F^{(j)}\\land z_F^{(j)}\\prec_F^{*}z_F^{(k)}\\Longrightarrow z_F^{(i)}\\prec_F^{*}z_F^{(k)}','original',NULL,'Definition 3.4.38.','checked',@revision_id),
('Lemma 3.4.15',@section_id,'Lineare Ordnung der Zustandsinstanzen eines Pfades','Die reflexive instanzielle Vorordnung bildet auf den Zustandsinstanzen eines endlichen Entwicklungspfads eine lineare Ordnung.','(\\mathcal Z_F(\\mathcal P_F^{(n)}),\\unlhd_F)','(\\mathcal Z_F(\\mathcal P_F^{(n)}),\\unlhd_F)','adapted',@source_dummit,'Definitionen 3.4.41 und 3.4.42.','checked',@revision_id),
('Lemma 3.4.16',@section_id,'Additivität der diskreten funktionalen Zeitdifferenz','Diskrete Zeitdifferenzen addieren sich entlang geordneter Zwischeninstanzen.','\\Delta\\tau_F(\\zeta_i,\\zeta_k)=\\Delta\\tau_F(\\zeta_i,\\zeta_j)+\\Delta\\tau_F(\\zeta_j,\\zeta_k)','\\Delta\\tau_F(\\zeta_i,\\zeta_k)=\\Delta\\tau_F(\\zeta_i,\\zeta_j)+\\Delta\\tau_F(\\zeta_j,\\zeta_k)','original',NULL,'Definition 3.4.44 und i\\leq j\\leq k.','checked',@revision_id);

DELETE FROM theorems
WHERE theorem_number IN ('Satz 3.4.14','Satz 3.4.15','Satz 3.4.16','Satz 3.4.17');

INSERT INTO theorems
(theorem_number,section_id,title,statement_text,statement_latex,word_latex,provenance,source_id,assumptions,validation_status,created_revision_id)
VALUES
('Satz 3.4.14',@section_id,'Partielle Ordnung in azyklischen Bereichen','Auf einem azyklischen funktionalen Bereich bildet die reflexive funktionale Vorordnung eine partielle Ordnung.','(\\Omega_F^{A}(\\mathcal S),\\preceq_F)','(\\Omega_F^{A}(\\mathcal S),\\preceq_F)','adapted',@source_dummit,'Definition 3.4.40 und Lemma 3.4.14.','checked',@revision_id),
('Satz 3.4.15',@section_id,'Existenz funktionaler Zeit aus nichtidentischer Veränderung','Jeder nichtidentische kohärenzerhaltende Übergang erzeugt mindestens zwei geordnete Zustandsinstanzen und damit eine nichttriviale funktionale Zeitstruktur.','z_F^{(0)}\\prec_F z_F^{(1)}\\Longrightarrow\\mathfrak T_F\\text{ nichttrivial}','z_F^{(0)}\\prec_F z_F^{(1)}\\Longrightarrow\\mathfrak T_F\\text{ nichttrivial}','original',NULL,'Definitionen 3.4.41 bis 3.4.43.','checked',@revision_id),
('Satz 3.4.16',@section_id,'Isomorphie endlicher Pfadzeiten mit diskreten Ordnungen','Die Zustandsinstanzen eines Pfades mit n Übergängen sind ordnungsisomorph zur natürlichen Ordnung von 0 bis n.','(\\mathcal Z_F(\\mathcal P_F^{(n)}),\\unlhd_F)\\cong(\\{0,\\ldots,n\\},\\leq)','(\\mathcal Z_F(\\mathcal P_F^{(n)}),\\unlhd_F)\\cong(\\{0,\\ldots,n\\},\\leq)','adapted',@source_dummit,'Definitionen 3.4.41 bis 3.4.44.','checked',@revision_id),
('Satz 3.4.17',@section_id,'Irreversibilität als fehlende Rückerreichbarkeit','Ein funktionaler Übergang ist irreversibel, wenn ein gerichteter Hinpfad, aber kein kohärenzerhaltender Rückpfad existiert.','z_F^{(i)}\\prec_F^{*}z_F^{(j)}\\land z_F^{(j)}\\not\\leadsto_F z_F^{(i)}','z_F^{(i)}\\prec_F^{*}z_F^{(j)}\\land z_F^{(j)}\\not\\leadsto_F z_F^{(i)}','original',NULL,'Funktionale Vorordnung und Erreichbarkeit.','checked',@revision_id);

SELECT lemma_id INTO @lemma_3414 FROM lemmas WHERE lemma_number='Lemma 3.4.14' LIMIT 1;
SELECT lemma_id INTO @lemma_3415 FROM lemmas WHERE lemma_number='Lemma 3.4.15' LIMIT 1;
SELECT lemma_id INTO @lemma_3416 FROM lemmas WHERE lemma_number='Lemma 3.4.16' LIMIT 1;

SELECT theorem_id INTO @satz_3414 FROM theorems WHERE theorem_number='Satz 3.4.14' LIMIT 1;
SELECT theorem_id INTO @satz_3415 FROM theorems WHERE theorem_number='Satz 3.4.15' LIMIT 1;
SELECT theorem_id INTO @satz_3416 FROM theorems WHERE theorem_number='Satz 3.4.16' LIMIT 1;
SELECT theorem_id INTO @satz_3417 FROM theorems WHERE theorem_number='Satz 3.4.17' LIMIT 1;

DELETE FROM corollaries
WHERE corollary_number IN ('Korollar 3.4.12','Korollar 3.4.13');

INSERT INTO corollaries
(corollary_number,section_id,title,statement_text,statement_latex,word_latex,parent_theorem_id,parent_lemma_id,provenance,source_id,validation_status,created_revision_id)
VALUES
('Korollar 3.4.12',@section_id,'Keine funktionale Zeit ohne Zustandsunterscheidung','Ohne registrierte nichtidentische Zustandsänderung kann innerhalb der betrachteten Organisation keine unterscheidbare funktionale Zeitordnung rekonstruiert werden.','z_F^{(k+1)}=z_F^{(k)}\\;\\forall k\\Longrightarrow\\text{keine unterscheidbare funktionale Zeit}','z_F^{(k+1)}=z_F^{(k)}\\;\\forall k\\Longrightarrow\\text{keine unterscheidbare funktionale Zeit}',@satz_3415,NULL,'original',NULL,'checked',@revision_id),
('Korollar 3.4.13',@section_id,'Additivität gewichteter funktionaler Zeit','Die gewichtete funktionale Zeitdifferenz ist entlang eines geordneten Entwicklungspfades additiv.','\\Delta\\tau_F^{w}(\\zeta_i,\\zeta_k)=\\Delta\\tau_F^{w}(\\zeta_i,\\zeta_j)+\\Delta\\tau_F^{w}(\\zeta_j,\\zeta_k)','\\Delta\\tau_F^{w}(\\zeta_i,\\zeta_k)=\\Delta\\tau_F^{w}(\\zeta_i,\\zeta_j)+\\Delta\\tau_F^{w}(\\zeta_j,\\zeta_k)',NULL,@lemma_3416,'original',NULL,'checked',@revision_id);

SELECT corollary_id INTO @kor_3412 FROM corollaries WHERE corollary_number='Korollar 3.4.12' LIMIT 1;
SELECT corollary_id INTO @kor_3413 FROM corollaries WHERE corollary_number='Korollar 3.4.13' LIMIT 1;

DELETE FROM proofs
WHERE proof_number LIKE 'Bew. 3.4.9-R%';

INSERT INTO proofs
(proof_number,section_id,theorem_id,lemma_id,corollary_id,title,proof_text,proof_latex,proof_method,provenance,source_id,validation_status,created_revision_id)
VALUES
('Bew. 3.4.9-R1',@section_id,NULL,@lemma_3414,NULL,'Beweis zu Lemma 3.4.14','Zwei endliche Nachfolgepfade können an ihrem gemeinsamen Zwischenzustand verkettet werden. Die verkettete Folge ist erneut endlich und besteht aus nichtidentischen Übergängen.','z_i\\prec_F^{*}z_j\\land z_j\\prec_F^{*}z_k\\Longrightarrow z_i\\prec_F^{*}z_k','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.9-R2',@section_id,@satz_3414,NULL,NULL,'Beweis zu Satz 3.4.14','Reflexivität und Transitivität folgen aus der reflexiven Hülle und Lemma 3.4.14. Wechselseitige Vorordnung verschiedener Zustände würde einen Zyklus erzeugen und widerspricht daher der Azyklizität.','z_i\\preceq_F z_j\\land z_j\\preceq_F z_i\\Longrightarrow z_i=z_j','direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.9-R3',@section_id,NULL,@lemma_3415,NULL,'Beweis zu Lemma 3.4.15','Die Positionsindizes der Zustandsinstanzen liegen in einer endlichen Teilmenge der natürlichen Zahlen. Deren Ordnung ist reflexiv, antisymmetrisch, transitiv und total.','i\\leq j','direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.9-R4',@section_id,@satz_3415,NULL,NULL,'Beweis zu Satz 3.4.15','Ein nichtidentischer Übergang erzeugt zwei verschiedene Zustandsinstanzen mit den Indizes null und eins. Daher besteht eine nichttriviale strikte Ordnung.','\\zeta_F^{(0)}\\triangleleft_F\\zeta_F^{(1)}','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.9-R5',@section_id,NULL,@lemma_3416,NULL,'Beweis zu Lemma 3.4.16','Die Additivität folgt aus der elementaren Zerlegung k-i=(j-i)+(k-j).','k-i=(j-i)+(k-j)','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.9-R6',@section_id,@satz_3416,NULL,NULL,'Beweis zu Satz 3.4.16','Die Abbildung jeder Zustandsinstanz auf ihren Positionsindex ist bijektiv und erhält die Ordnung in beide Richtungen.','\\varphi_F(\\zeta_F^{(k)})=k','direct','adapted',@source_dummit,'checked',@revision_id),
('Bew. 3.4.9-R7',@section_id,NULL,NULL,@kor_3412,'Begründung zu Korollar 3.4.12','Fehlt jede registrierte nichtidentische Zustandsänderung, kann aus der internen Organisation keine unterscheidbare Reihenfolge verschiedener Zustandsrealisierungen gewonnen werden.','z_F^{(k+1)}=z_F^{(k)}','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.9-R8',@section_id,NULL,NULL,@kor_3413,'Begründung zu Korollar 3.4.13','Die Summe der Übergangsgewichte kann an jeder Zwischeninstanz in zwei Teilsummen zerlegt werden.','\\sum_{k=i}^{l-1}w_k=\\sum_{k=i}^{j-1}w_k+\\sum_{k=j}^{l-1}w_k','direct','original',NULL,'checked',@revision_id),
('Bew. 3.4.9-R9',@section_id,@satz_3417,NULL,NULL,'Beweis zu Satz 3.4.17','Ein Hinpfad belegt die gerichtete Entwicklung zum Folgezustand. Das Fehlen jedes Rückpfades schließt die Wiederherstellung des Ausgangszustands innerhalb der zulässigen Operatorstruktur aus.','z_i\\prec_F^{*}z_j\\land z_j\\not\\leadsto_F z_i','direct','original',NULL,'checked',@revision_id);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT
    @source_dummit,
    @section_id,
    'background',
    'Ordnungsrelationen, partielle und lineare Ordnungen, Isomorphismen und Antiketten als algebraische Grundlage der funktionalen Zeitrekonstruktion.',
    '3.4.9.3 bis 3.4.9.9',
    0,
    1,
    'Bestandsquelle [31].',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id=@source_dummit
      AND section_id=@section_id
      AND exact_location='3.4.9.3 bis 3.4.9.9'
);

INSERT INTO source_usage
(source_id,section_id,usage_type,claim_summary,exact_location,is_first_mention,citation_checked,notes,created_revision_id)
SELECT
    @source_diestel,
    @section_id,
    'background',
    'Gerichtete Pfade, transitive Hüllen, Zyklen, Erreichbarkeit und Antiketten als graphentheoretische Grundlage.',
    '3.4.9.1 bis 3.4.9.11',
    0,
    1,
    'Bestandsquelle [47].',
    @revision_id
WHERE NOT EXISTS (
    SELECT 1 FROM source_usage
    WHERE source_id=@source_diestel
      AND section_id=@section_id
      AND exact_location='3.4.9.1 bis 3.4.9.11'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT
    @revision_id,@section_id,'rewritten','section','3.4.9',
    'Abschnitt 3.4.9 vollständig literaturgestützt neu gefasst.',
    'Frühere oder fehlende Fassung',
    'Revision mit Nachfolge, Vorordnung, Zyklen, Zustandsinstanzen, Zeitdifferenzen, Zeitschnitten und Irreversibilität'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_reference='3.4.9'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT
    @revision_id,@section_id,'equation_changed','equations','3.925–3.986',
    '62 Gleichungen aktualisiert beziehungsweise ergänzt.',
    NULL,'checked'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_reference='3.925–3.986'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT
    @revision_id,@section_id,'definition_added','definitions','3.4.36–3.4.49',
    'Vierzehn Definitionen registriert.',
    NULL,'checked'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_reference='3.4.36–3.4.49'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT
    @revision_id,@section_id,'statement_added','statements','Lemma/Satz/Korollar 3.4.9',
    'Drei Lemmata, vier Sätze und zwei Korollare registriert.',
    NULL,'checked'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_reference='Lemma/Satz/Korollar 3.4.9'
);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary,previous_value,new_value)
SELECT
    @revision_id,@section_id,'proof_added','proofs','Bew. 3.4.9-R1–R9',
    'Neun Beweis- und Begründungsdatensätze registriert.',
    NULL,'checked'
WHERE NOT EXISTS (
    SELECT 1 FROM section_change_log
    WHERE revision_id=@revision_id AND object_reference='Bew. 3.4.9-R1–R9'
);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_completed_section','3.4.9')
ON DUPLICATE KEY UPDATE counter_value='3.4.9';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-REV-K3.4.9-V1')
ON DUPLICATE KEY UPDATE counter_value='RKB-REV-K3.4.9-V1';

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('next_equation_number','3.987')
ON DUPLICATE KEY UPDATE counter_value='3.987';

COMMIT;

/* =====================================================================
   Audit
   ===================================================================== */

SELECT revision_id,revision_code,scope_reference,version_label
FROM repository_revisions
WHERE revision_code=@revision_code;

SELECT section_id,section_code,title,status,is_original_contribution
FROM dissertation_sections
WHERE section_code='3.4.9';

SELECT COUNT(*) AS equations_3_925_to_3_986
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 925 AND 986;

SELECT equation_number,title,equation_type,validation_status
FROM equations
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED) BETWEEN 925 AND 986
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);

SELECT definition_number,title,validation_status
FROM definitions
WHERE section_id=@section_id
  AND definition_number IN (
  'Definition 3.4.36','Definition 3.4.37','Definition 3.4.38','Definition 3.4.39',
  'Definition 3.4.40','Definition 3.4.41','Definition 3.4.42','Definition 3.4.43',
  'Definition 3.4.44','Definition 3.4.45','Definition 3.4.46','Definition 3.4.47',
  'Definition 3.4.48','Definition 3.4.49'
  )
ORDER BY definition_number;

SELECT lemma_number,title,validation_status
FROM lemmas
WHERE section_id=@section_id
  AND lemma_number IN ('Lemma 3.4.14','Lemma 3.4.15','Lemma 3.4.16')
ORDER BY lemma_number;

SELECT theorem_number,title,validation_status
FROM theorems
WHERE section_id=@section_id
  AND theorem_number IN ('Satz 3.4.14','Satz 3.4.15','Satz 3.4.16','Satz 3.4.17')
ORDER BY theorem_number;

SELECT corollary_number,title,validation_status
FROM corollaries
WHERE section_id=@section_id
  AND corollary_number IN ('Korollar 3.4.12','Korollar 3.4.13')
ORDER BY corollary_number;

SELECT proof_number,title,validation_status
FROM proofs
WHERE section_id=@section_id
  AND proof_number LIKE 'Bew. 3.4.9-R%'
ORDER BY proof_number;

SELECT s.citation_number,s.title,su.exact_location,su.citation_checked
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.citation_number IN (31,47)
ORDER BY s.citation_number;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN ('last_completed_section','last_repository_revision','next_equation_number')
ORDER BY counter_key;
