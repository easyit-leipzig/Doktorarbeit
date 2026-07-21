/* =====================================================================
   FRZK-RKB – Revisionsupdate Abschnitt 3.4.5, Teil 1
   Neu gefasste Textteile:
   - 3.4.5.1 Motivation
   - 3.4.5.2 Der mathematische Operatorbegriff
   - 3.4.5.3 Übertragung auf die FRZK
   - Definition 3.4.11 Funktionaler Operator

   Revidierte Gleichungen:
   - (3.730) bis (3.733)

   Literatur:
   - Rudin [11]
   - Dummit/Foote [31]
   - Conway [35]

   WICHTIG:
   Die Werke sind bereits im Repository vorhanden. Sie werden daher nicht
   erneut als [110]–[112] angelegt. Die im ersten Textentwurf verwendete
   Nummerierung wird im fortgesetzten Text entsprechend korrigiert.

   Die noch nicht neu geschriebenen Objekte (3.734)–(3.770) werden nicht
   gelöscht. Sie werden vorläufig auf validation_status='draft' gesetzt,
   bis die Revision von 3.4.5 vollständig abgeschlossen ist.
   ===================================================================== */

START TRANSACTION;

SET @revision_code := 'RKB-REV-K3.4.5-P1-V2';

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code IN
    (
        'RKB-NEU-K3.4.5-V1',
        'RKB-NEU-K3.4.4-V1'
    )
    ORDER BY FIELD
    (
        revision_code,
        'RKB-NEU-K3.4.5-V1',
        'RKB-NEU-K3.4.4-V1'
    )
    LIMIT 1
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
    @revision_code,
    NOW(),
    'section',
    '3.4.5',
    '2.0-part-1-v2',
    'Literaturgestützte Neufassung von Motivation, mathematischem Operatorbegriff, FRZK-Übertragung und Definition 3.4.11.',
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

SET @section_id :=
(
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code='3.4.5'
    LIMIT 1
);

SET @source_rudin :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number=11
       OR source_key='rudin_functional_analysis_1991'
       OR (title='Functional Analysis' AND publication_year=1991)
    ORDER BY
        CASE
            WHEN citation_number=11 THEN 1
            WHEN source_key='rudin_functional_analysis_1991' THEN 2
            ELSE 3
        END
    LIMIT 1
);

SET @source_dummit :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number=31
       OR source_key='dummit_foote_abstract_algebra_2004'
       OR (title='Abstract Algebra' AND publication_year=2004)
    ORDER BY
        CASE
            WHEN citation_number=31 THEN 1
            WHEN source_key='dummit_foote_abstract_algebra_2004' THEN 2
            ELSE 3
        END
    LIMIT 1
);

SET @source_conway :=
(
    SELECT source_id
    FROM sources
    WHERE citation_number=35
       OR source_key='conway_functional_analysis_1990'
       OR (title='A Course in Functional Analysis' AND publication_year=1990)
    ORDER BY
        CASE
            WHEN citation_number=35 THEN 1
            WHEN source_key='conway_functional_analysis_1990' THEN 2
            ELSE 3
        END
    LIMIT 1
);

/* ------------------------------------------------------------
   Schema- und Literaturprüfung
   ------------------------------------------------------------ */

SET @missing_sources :=
(
    (@source_rudin IS NULL)
    + (@source_dummit IS NULL)
    + (@source_conway IS NULL)
);

SET @error_message :=
(
    CASE
        WHEN @section_id IS NULL
            THEN 'Abschnitt 3.4.5 fehlt in dissertation_sections.'
        WHEN @missing_sources > 0
            THEN 'Mindestens eine erforderliche Bestandsquelle konnte weder über Literatur­nummer noch über source_key oder Titel/Jahr ermittelt werden: Rudin [11], Dummit/Foote [31] oder Conway [35].'
        ELSE NULL
    END
);

DROP PROCEDURE IF EXISTS frzk_assert_345_p1;

DELIMITER $$

CREATE PROCEDURE frzk_assert_345_p1()
BEGIN
    IF @error_message IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT=@error_message;
    END IF;
END$$

DELIMITER ;

CALL frzk_assert_345_p1();
DROP PROCEDURE frzk_assert_345_p1;

/* ------------------------------------------------------------
   Abschnittsstatus
   ------------------------------------------------------------ */

UPDATE dissertation_sections
SET
    title='Funktionale Operatoren',
    status='review',
    is_original_contribution=1,
    notes=
    'Vollständige literaturgestützte Revision ab 3.4.5. Teil 1 umfasst Motivation, mathematischen Operatorbegriff, Übertragung auf die FRZK und Definition 3.4.11. Die Fortsetzung zu Operatorraum, Komposition, Identität, Invertierbarkeit und algebraischer Struktur folgt abschnittsweise.'
WHERE section_id=@section_id;

/* ------------------------------------------------------------
   Quellenverwendungen
   Keine neuen Quellen: vorhandene Nummern [11], [31], [35]
   ------------------------------------------------------------ */

INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    @source_rudin,
    @section_id,
    'background',
    'Funktionalanalytische Einordnung des allgemeinen Operatorbegriffs und von Operatoren auf mathematischen Räumen.',
    '3.4.5.1–3.4.5.2',
    0,
    1,
    'Wiederverwendung der bereits als [11] registrierten Quelle.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@source_rudin
      AND section_id=@section_id
      AND exact_location='3.4.5.1–3.4.5.2'
);

INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    @source_conway,
    @section_id,
    'comparison',
    'Ergänzende Referenz zur Funktionalanalysis und zur Wirkung von Operatoren auf Zustands- beziehungsweise Funktionenräumen.',
    '3.4.5.1',
    0,
    1,
    'Wiederverwendung der bereits als [35] registrierten Quelle.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@source_conway
      AND section_id=@section_id
      AND exact_location='3.4.5.1'
);

INSERT INTO source_usage
(
    source_id,
    section_id,
    usage_type,
    claim_summary,
    exact_location,
    is_first_mention,
    citation_checked,
    notes,
    created_revision_id
)
SELECT
    @source_dummit,
    @section_id,
    'definition',
    'Algebraische Einordnung der Abgeschlossenheit einer Struktur unter einer inneren Operation.',
    '3.4.5.2',
    0,
    1,
    'Wiederverwendung der bereits als [31] registrierten Quelle.',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM source_usage
    WHERE source_id=@source_dummit
      AND section_id=@section_id
      AND exact_location='3.4.5.2'
);

/* ------------------------------------------------------------
   Gleichung (3.730)
   ------------------------------------------------------------ */

UPDATE equations
SET
    section_id=@section_id,
    title='Allgemeiner Operator',
    equation_latex='O:X\\rightarrow Y',
    word_latex='O:X\\rightarrow Y',
    plain_description='Allgemeine Darstellung eines Operators als wohldefinierte Abbildung vom Definitionsbereich X in den Zielbereich Y.',
    equation_type='definition',
    provenance='literature',
    source_id=@source_rudin,
    derivation='Übernahme des allgemeinen Abbildungs- und Operatorbegriffs als mathematische Grundlage der FRZK-spezifischen Rekonstruktion.',
    assumptions='X und Y sind wohldefinierte mathematische Bereiche.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.730';

INSERT INTO equations
(
    equation_number,
    section_id,
    title,
    equation_latex,
    word_latex,
    plain_description,
    equation_type,
    provenance,
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.730',
    @section_id,
    'Allgemeiner Operator',
    'O:X\\rightarrow Y',
    'O:X\\rightarrow Y',
    'Allgemeine Darstellung eines Operators als wohldefinierte Abbildung vom Definitionsbereich X in den Zielbereich Y.',
    'definition',
    'literature',
    @source_rudin,
    'Übernahme des allgemeinen Abbildungs- und Operatorbegriffs als mathematische Grundlage der FRZK-spezifischen Rekonstruktion.',
    'X und Y sind wohldefinierte mathematische Bereiche.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.730'
);

/* ------------------------------------------------------------
   Gleichung (3.731)
   ------------------------------------------------------------ */

UPDATE equations
SET
    section_id=@section_id,
    title='Operator innerhalb desselben Raumes',
    equation_latex='X=Y',
    word_latex='X=Y',
    plain_description='Definitions- und Zielbereich stimmen überein, sodass der Operator innerhalb desselben mathematischen Raumes wirkt.',
    equation_type='definition',
    provenance='literature',
    source_id=@source_rudin,
    derivation='Spezialisierung eines allgemeinen Operators auf eine Selbstabbildung.',
    assumptions='Definitions- und Zielbereich besitzen dieselbe zugrunde gelegte Struktur.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.731';

INSERT INTO equations
(
    equation_number,
    section_id,
    title,
    equation_latex,
    word_latex,
    plain_description,
    equation_type,
    provenance,
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.731',
    @section_id,
    'Operator innerhalb desselben Raumes',
    'X=Y',
    'X=Y',
    'Definitions- und Zielbereich stimmen überein, sodass der Operator innerhalb desselben mathematischen Raumes wirkt.',
    'definition',
    'literature',
    @source_rudin,
    'Spezialisierung eines allgemeinen Operators auf eine Selbstabbildung.',
    'Definitions- und Zielbereich besitzen dieselbe zugrunde gelegte Struktur.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.731'
);

/* ------------------------------------------------------------
   Gleichung (3.732)
   ------------------------------------------------------------ */

UPDATE equations
SET
    section_id=@section_id,
    title='Funktionaler Zustandsraum',
    equation_latex='\\Omega_F(\\mathcal{S})',
    word_latex='\\Omega_F(\\mathcal{S})',
    plain_description='Bezeichnung des bereits eingeführten Raumes aller zulässigen funktionalen Zustände der Organisation S.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='Wiederaufnahme des in Abschnitt 3.4.2 rekonstruierten funktionalen Zustandsraumes.',
    assumptions='Die Definition des funktionalen Zustandsraumes aus Abschnitt 3.4.2 wird vorausgesetzt.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.732';

INSERT INTO equations
(
    equation_number,
    section_id,
    title,
    equation_latex,
    word_latex,
    plain_description,
    equation_type,
    provenance,
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.732',
    @section_id,
    'Funktionaler Zustandsraum',
    '\\Omega_F(\\mathcal{S})',
    '\\Omega_F(\\mathcal{S})',
    'Bezeichnung des bereits eingeführten Raumes aller zulässigen funktionalen Zustände der Organisation S.',
    'definition',
    'original',
    NULL,
    'Wiederaufnahme des in Abschnitt 3.4.2 rekonstruierten funktionalen Zustandsraumes.',
    'Die Definition des funktionalen Zustandsraumes aus Abschnitt 3.4.2 wird vorausgesetzt.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.732'
);

/* ------------------------------------------------------------
   Gleichung (3.733)
   ------------------------------------------------------------ */

UPDATE equations
SET
    section_id=@section_id,
    title='Funktionaler Operator',
    equation_latex='O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    word_latex='O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    plain_description='Ein funktionaler Operator ordnet jedem zulässigen funktionalen Zustand genau einen funktionalen Folgezustand innerhalb desselben Zustandsraumes zu.',
    equation_type='definition',
    provenance='original',
    source_id=NULL,
    derivation='FRZK-spezifische Übertragung des allgemeinen Operatorbegriffs auf den funktionalen Zustandsraum.',
    assumptions='Der funktionale Zustandsraum ist wohldefiniert und unter zulässigen Operatorwirkungen abgeschlossen.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE equation_number='3.733';

INSERT INTO equations
(
    equation_number,
    section_id,
    title,
    equation_latex,
    word_latex,
    plain_description,
    equation_type,
    provenance,
    source_id,
    derivation,
    assumptions,
    validation_status,
    created_revision_id
)
SELECT
    '3.733',
    @section_id,
    'Funktionaler Operator',
    'O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    'O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    'Ein funktionaler Operator ordnet jedem zulässigen funktionalen Zustand genau einen funktionalen Folgezustand innerhalb desselben Zustandsraumes zu.',
    'definition',
    'original',
    NULL,
    'FRZK-spezifische Übertragung des allgemeinen Operatorbegriffs auf den funktionalen Zustandsraum.',
    'Der funktionale Zustandsraum ist wohldefiniert und unter zulässigen Operatorwirkungen abgeschlossen.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1 FROM equations WHERE equation_number='3.733'
);

/* ------------------------------------------------------------
   Definition 3.4.11
   ------------------------------------------------------------ */

UPDATE definitions
SET
    section_id=@section_id,
    title='Funktionaler Operator',
    definition_text=
    'Ein funktionaler Operator ist eine wohldefinierte Abbildung des funktionalen Zustandsraumes in sich selbst, die jedem funktionalen Zustand genau einen funktionalen Folgezustand zuordnet.',
    formal_latex=
    'O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    word_latex=
    'O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    provenance='original',
    source_id=NULL,
    assumptions=
    'Der funktionale Zustandsraum aus Abschnitt 3.4.2 ist wohldefiniert. Jede zulässige Operatorwirkung führt erneut zu einem Zustand dieses Raumes.',
    notes=
    'Originäre FRZK-spezifische Übertragung des allgemeinen mathematischen Operatorbegriffs. Der allgemeine Operatorbegriff wird durch Rudin [11] und Conway [35] eingeordnet.',
    validation_status='checked',
    created_revision_id=@revision_id
WHERE definition_number='3.4.11';

INSERT INTO definitions
(
    definition_number,
    section_id,
    title,
    definition_text,
    formal_latex,
    word_latex,
    provenance,
    source_id,
    assumptions,
    notes,
    validation_status,
    created_revision_id
)
SELECT
    '3.4.11',
    @section_id,
    'Funktionaler Operator',
    'Ein funktionaler Operator ist eine wohldefinierte Abbildung des funktionalen Zustandsraumes in sich selbst, die jedem funktionalen Zustand genau einen funktionalen Folgezustand zuordnet.',
    'O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    'O_F:\\Omega_F(\\mathcal{S})\\rightarrow\\Omega_F(\\mathcal{S})',
    'original',
    NULL,
    'Der funktionale Zustandsraum aus Abschnitt 3.4.2 ist wohldefiniert. Jede zulässige Operatorwirkung führt erneut zu einem Zustand dieses Raumes.',
    'Originäre FRZK-spezifische Übertragung des allgemeinen mathematischen Operatorbegriffs. Der allgemeine Operatorbegriff wird durch Rudin [11] und Conway [35] eingeordnet.',
    'checked',
    @revision_id
WHERE NOT EXISTS
(
    SELECT 1
    FROM definitions
    WHERE definition_number='3.4.11'
);

/* ------------------------------------------------------------
   Noch nicht revidierte Folgeobjekte kenntlich machen
   ------------------------------------------------------------ */

UPDATE equations
SET validation_status='draft'
WHERE section_id=@section_id
  AND CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 734 AND 770;

/* ------------------------------------------------------------
   Änderungsprotokoll
   ------------------------------------------------------------ */

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'revised',
    'section',
    '3.4.5-P1',
    'Literaturgestützte Neufassung der ersten drei Unterabschnitte und der Definition 3.4.11.',
    'Erstfassung ohne ausreichende Literaturabgrenzung.',
    'Revidierte Fassung mit Trennung zwischen Standardmathematik und originärer FRZK-Übertragung.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='section'
      AND object_reference='3.4.5-P1'
);

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'revised',
    'equation',
    '3.730-3.733',
    'Die Gleichungen 3.730 bis 3.733 wurden an die neue literaturgestützte Textfassung angepasst.',
    'Frühere Operatorfassung.',
    'Allgemeiner Operator, Selbstabbildung, funktionaler Zustandsraum und funktionaler Operator.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='equation'
      AND object_reference='3.730-3.733'
);

INSERT INTO section_change_log
(
    revision_id,
    section_id,
    change_type,
    object_type,
    object_reference,
    change_summary,
    previous_value,
    new_value
)
SELECT
    @revision_id,
    @section_id,
    'revised',
    'definition',
    '3.4.11',
    'Definition 3.4.11 wurde als originäre FRZK-spezifische Übertragung des allgemeinen Operatorbegriffs präzisiert.',
    'Frühere Definition.',
    'Literaturgestützt abgegrenzte Definition des funktionalen Operators.'
WHERE NOT EXISTS
(
    SELECT 1
    FROM section_change_log
    WHERE revision_id=@revision_id
      AND object_type='definition'
      AND object_reference='3.4.11'
);

/* ------------------------------------------------------------
   Repository-Zähler
   Der Literaturzähler bleibt bei [109], weil keine neue Quelle
   angelegt wurde. Der Gleichungszähler wird nicht zurückgesetzt.
   ------------------------------------------------------------ */

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('last_repository_revision', 'RKB-REV-K3.4.5-P1-V2')
ON DUPLICATE KEY UPDATE
counter_value='RKB-REV-K3.4.5-P1-V2';

INSERT INTO repository_counters
(counter_key, counter_value)
VALUES
('last_revised_section_chapter_3', '3.4.5-P1')
ON DUPLICATE KEY UPDATE
counter_value='3.4.5-P1';

COMMIT;

/* =====================================================================
   Kontrollabfragen
   ===================================================================== */

SELECT
    revision_id,
    revision_code,
    scope_reference,
    version_label,
    summary
FROM repository_revisions
WHERE revision_code='RKB-REV-K3.4.5-P1-V2';

SELECT
    section_code,
    title,
    status,
    notes
FROM dissertation_sections
WHERE section_code='3.4.5';

SELECT
    e.equation_number,
    e.title,
    e.equation_latex,
    e.provenance,
    s.citation_number AS source_number,
    e.validation_status
FROM equations e
LEFT JOIN sources s ON s.source_id=e.source_id
WHERE e.section_id=@section_id
  AND CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED)
      BETWEEN 730 AND 770
ORDER BY CAST(SUBSTRING_INDEX(e.equation_number,'.',-1) AS UNSIGNED);

SELECT
    definition_number,
    title,
    formal_latex,
    provenance,
    validation_status
FROM definitions
WHERE definition_number='3.4.11';

SELECT
    s.citation_number,
    s.source_key,
    s.full_citation_text,
    su.usage_type,
    su.exact_location,
    su.citation_checked
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
WHERE su.section_id=@section_id
  AND s.source_id IN (@source_rudin, @source_dummit, @source_conway)
ORDER BY s.citation_number;

SELECT
    counter_key,
    counter_value
FROM repository_counters
WHERE counter_key IN
(
    'last_repository_revision',
    'last_revised_section_chapter_3'
)
ORDER BY counter_key;
