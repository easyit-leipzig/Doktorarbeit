USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.6
   Mathematische Rekonstruktion funktionaler Raum-Zeit-Kohärenz

   Definitionen:
   - Def. 3.4.11 Funktionale Raum-Zeit-Kohärenz
   - Def. 3.4.12 Raum-Zeit-Kohärenzfunktion

   Lemma:
   - Lemma 3.4.4 Symmetrie der Raum-Zeit-Kohärenz

   Satz:
   - Satz 3.4.6 Existenz eines Funktionalen
     Raum-Zeit-Kohärenzsystems

   Gleichungen:
   - (3.90) Kohärenzrelation
   - (3.91) Raum-Zeit-Kohärenzfunktion
   - (3.92) Symmetrie der Raum-Zeit-Kohärenz
   - (3.93) Funktionales Raum-Zeit-Kohärenzsystem

   Neue Quellen: keine

   Nächste Gleichung:   (3.94)
   Nächste Definition:  Def. 3.4.13
   Nächstes Lemma:      Lemma 3.4.5
   Nächster Satz:       Satz 3.4.7
   ============================================================ */

/* 1. Parent-Revision separat ermitteln, um MySQL-Fehler #1093
      zu vermeiden. */
SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`)
    FROM `repository_revisions` r
);

/* 2. Revision idempotent anlegen oder wiederverwenden. */
INSERT INTO `repository_revisions` (
    `revision_code`,
    `revision_date`,
    `scope_type`,
    `scope_reference`,
    `version_label`,
    `summary`,
    `created_by`,
    `parent_revision_id`
)
VALUES (
    'RKB-2026-07-12-K3.4.6-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.6',
    '1.0',
    'Neufassung von Abschnitt 3.4.6 mit Def. 3.4.11, Def. 3.4.12, Lemma 3.4.4, Satz 3.4.6 sowie den Gleichungen (3.90) bis (3.93).',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `version_label` = VALUES(`version_label`),
    `summary` = VALUES(`summary`),
    `created_by` = VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

/* 3. Kapitel 3.4 und Abschnitt 3.4.6 ermitteln.
      Fehlenden Abschnitt bei Bedarf anlegen. */
SET @chapter_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4'
    LIMIT 1
);

INSERT INTO `dissertation_sections` (
    `parent_section_id`,
    `section_code`,
    `title`,
    `chapter_no`,
    `section_order`,
    `status`,
    `is_original_contribution`,
    `notes`
)
SELECT
    @chapter_id,
    '3.4.6',
    'Mathematische Rekonstruktion funktionaler Raum-Zeit-Kohärenz',
    3,
    3.5600,
    'review',
    1,
    'Rekonstruktion funktionaler Kohärenzrelationen zwischen Organisationsräumen und des Funktionalen Raum-Zeit-Kohärenzsystems.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections` ds
      WHERE ds.`section_code` = '3.4.6'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.6'
    LIMIT 1
);

/* 4. Abschnitts- und Kapitelmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Mathematische Rekonstruktion funktionaler Raum-Zeit-Kohärenz',
    `chapter_no` = 3,
    `section_order` = 3.5600,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 12.07.2026 vollständig neu gefasst. Enthält Def. 3.4.11, Def. 3.4.12, Lemma 3.4.4, Satz 3.4.6 und die Gleichungen (3.90) bis (3.93).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Kapitel 3.4 wird als mathematische Rekonstruktion funktionaler Organisation abschnittsweise neu entwickelt.'
WHERE `section_id` = @chapter_id;

/* 5. Abschnitt enthält bewusst keine Literaturverwendung. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 6. Benötigte Vorgängerobjekte ermitteln. */
SET @axiom_a5_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A5'
    LIMIT 1
);

SET @def_348_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.8'
    LIMIT 1
);

SET @def_349_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.9'
    LIMIT 1
);

SET @def_3410_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.10'
    LIMIT 1
);

SET @def_3411_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.11'
    LIMIT 1
);

SET @def_3412_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.12'
    LIMIT 1
);

SET @lemma_344_id := (
    SELECT l.`lemma_id`
    FROM `lemmas` l
    WHERE l.`lemma_number` = 'Lemma 3.4.4'
    LIMIT 1
);

SET @theorem_346_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.6'
    LIMIT 1
);

/* 7. Def. 3.4.11 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Raum-Zeit-Kohärenz',
    `definition_text` = 'Zwei funktionale Organisationsräume besitzen funktionale Raum-Zeit-Kohärenz, wenn ihre funktionalen Organisationsstrukturen durch eine wohldefinierte funktionale Kohärenzrelation gekoppelt sind.',
    `formal_latex` = '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F',
    `word_latex` = '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.8 und Axiom A5 gelten.',
    `notes` = 'Die Relation enthält noch keine geometrische Distanz und keinen vorausgesetzten Zeitparameter.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3411_id;

INSERT INTO `definitions` (
    `definition_number`,
    `section_id`,
    `title`,
    `definition_text`,
    `formal_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
SELECT
    'Def. 3.4.11',
    @section_id,
    'Funktionale Raum-Zeit-Kohärenz',
    'Zwei funktionale Organisationsräume besitzen funktionale Raum-Zeit-Kohärenz, wenn ihre funktionalen Organisationsstrukturen durch eine wohldefinierte funktionale Kohärenzrelation gekoppelt sind.',
    '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F',
    '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F',
    'original',
    NULL,
    'Def. 3.4.8 und Axiom A5 gelten.',
    'Die Relation enthält noch keine geometrische Distanz und keinen vorausgesetzten Zeitparameter.',
    'checked',
    @revision_id
WHERE @def_3411_id IS NULL;

SET @def_3411_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.11'
    LIMIT 1
);

/* 8. Def. 3.4.12 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Raum-Zeit-Kohärenzfunktion',
    `definition_text` = 'Die Raum-Zeit-Kohärenzfunktion ordnet jedem geordneten Paar funktionaler Organisationsräume einen normierten Wert ihrer funktionalen Kopplung zu.',
    `formal_latex` = '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    `word_latex` = '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.11 gilt.',
    `notes` = 'Der Wert 1 bezeichnet maximale funktionale Kopplung, der Wert 0 vollständige funktionale Entkopplung.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3412_id;

INSERT INTO `definitions` (
    `definition_number`,
    `section_id`,
    `title`,
    `definition_text`,
    `formal_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `notes`,
    `validation_status`,
    `created_revision_id`
)
SELECT
    'Def. 3.4.12',
    @section_id,
    'Raum-Zeit-Kohärenzfunktion',
    'Die Raum-Zeit-Kohärenzfunktion ordnet jedem geordneten Paar funktionaler Organisationsräume einen normierten Wert ihrer funktionalen Kopplung zu.',
    '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    'original',
    NULL,
    'Def. 3.4.11 gilt.',
    'Der Wert 1 bezeichnet maximale funktionale Kopplung, der Wert 0 vollständige funktionale Entkopplung.',
    'checked',
    @revision_id
WHERE @def_3412_id IS NULL;

SET @def_3412_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.12'
    LIMIT 1
);

/* 9. Lemma 3.4.4 aktualisieren oder anlegen. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Symmetrie der Raum-Zeit-Kohärenz',
    `statement_text` = 'Ist die funktionale Kopplung zwischen zwei Organisationsräumen wechselseitig definiert, dann ist die Raum-Zeit-Kohärenzfunktion symmetrisch.',
    `statement_latex` = '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)',
    `word_latex` = '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.12 gilt und die Kopplung ist wechselseitig definiert.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_344_id;

INSERT INTO `lemmas` (
    `lemma_number`,
    `section_id`,
    `title`,
    `statement_text`,
    `statement_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
SELECT
    'Lemma 3.4.4',
    @section_id,
    'Symmetrie der Raum-Zeit-Kohärenz',
    'Ist die funktionale Kopplung zwischen zwei Organisationsräumen wechselseitig definiert, dann ist die Raum-Zeit-Kohärenzfunktion symmetrisch.',
    '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)',
    '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)',
    'original',
    NULL,
    'Def. 3.4.12 gilt und die Kopplung ist wechselseitig definiert.',
    'checked',
    @revision_id
WHERE @lemma_344_id IS NULL;

SET @lemma_344_id := (
    SELECT l.`lemma_id`
    FROM `lemmas` l
    WHERE l.`lemma_number` = 'Lemma 3.4.4'
    LIMIT 1
);

/* 10. Satz 3.4.6 aktualisieren oder anlegen. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Existenz eines Funktionalen Raum-Zeit-Kohärenzsystems',
    `statement_text` = 'Existieren funktionale Organisationsräume, eine auf ihnen definierte Kohärenzrelation und eine zugehörige Raum-Zeit-Kohärenzfunktion, dann existiert ein Funktionales Raum-Zeit-Kohärenzsystem.',
    `statement_latex` = '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)',
    `word_latex` = '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.8, Def. 3.4.11 und Def. 3.4.12 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_346_id;

INSERT INTO `theorems` (
    `theorem_number`,
    `section_id`,
    `title`,
    `statement_text`,
    `statement_latex`,
    `word_latex`,
    `provenance`,
    `source_id`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
SELECT
    'Satz 3.4.6',
    @section_id,
    'Existenz eines Funktionalen Raum-Zeit-Kohärenzsystems',
    'Existieren funktionale Organisationsräume, eine auf ihnen definierte Kohärenzrelation und eine zugehörige Raum-Zeit-Kohärenzfunktion, dann existiert ein Funktionales Raum-Zeit-Kohärenzsystem.',
    '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)',
    '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)',
    'original',
    NULL,
    'Def. 3.4.8, Def. 3.4.11 und Def. 3.4.12 gelten.',
    'checked',
    @revision_id
WHERE @theorem_346_id IS NULL;

SET @theorem_346_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.6'
    LIMIT 1
);

/* 11. Alte Belegungen der Gleichungsnummern (3.90) bis (3.93)
       und alle abhängigen Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.90','3.91','3.92','3.93');

/* 12. Gleichungen einfügen. */
INSERT INTO `equations` (
    `equation_number`,
    `section_id`,
    `title`,
    `equation_latex`,
    `word_latex`,
    `plain_description`,
    `equation_type`,
    `provenance`,
    `source_id`,
    `derivation`,
    `assumptions`,
    `validation_status`,
    `created_revision_id`
)
VALUES
(
    '3.90',
    @section_id,
    'Funktionale Raum-Zeit-Kohärenzrelation',
    '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F',
    '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F',
    'Die funktionale Raum-Zeit-Kohärenzrelation koppelt geordnete Paare funktionaler Organisationsräume.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.11.',
    'Def. 3.4.8 gilt.',
    'checked',
    @revision_id
),
(
    '3.91',
    @section_id,
    'Raum-Zeit-Kohärenzfunktion',
    '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    'Die Raum-Zeit-Kohärenzfunktion ordnet jedem Paar funktionaler Organisationsräume einen normierten Kopplungswert zu.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.12.',
    'Def. 3.4.11 gilt.',
    'checked',
    @revision_id
),
(
    '3.92',
    @section_id,
    'Symmetrie der Raum-Zeit-Kohärenz',
    '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)',
    '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)',
    'Bei wechselseitig definierter Kopplung ist die Raum-Zeit-Kohärenzfunktion symmetrisch.',
    'lemma',
    'original',
    NULL,
    'Formale Darstellung von Lemma 3.4.4.',
    'Def. 3.4.12 gilt und die Kopplung ist wechselseitig.',
    'checked',
    @revision_id
),
(
    '3.93',
    @section_id,
    'Funktionales Raum-Zeit-Kohärenzsystem',
    '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)',
    '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)',
    'Das Funktionale Raum-Zeit-Kohärenzsystem besteht aus funktionalen Organisationsräumen, ihrer Kohärenzrelation und der quantifizierenden Raum-Zeit-Kohärenzfunktion.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.6.',
    'Def. 3.4.8, Def. 3.4.11 und Def. 3.4.12 gelten.',
    'checked',
    @revision_id
);

SET @eq_390 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.90'
    LIMIT 1
);

SET @eq_391 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.91'
    LIMIT 1
);

SET @eq_392 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.92'
    LIMIT 1
);

SET @eq_393 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.93'
    LIMIT 1
);

SET @eq_384 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.84'
    LIMIT 1
);

SET @eq_386 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.86'
    LIMIT 1
);

/* 13. Symbolregister vollständig anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_390,@eq_391,@eq_392,@eq_393);

INSERT INTO `equation_symbols` (
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(
    @eq_390,
    '\\mathcal{K}',
    'Raum-Zeit-Kohärenzrelation',
    'Relation funktionaler Kopplung zwischen Organisationsräumen.',
    NULL,
    'Teilmenge von \\mathfrak{O}_F\\times\\mathfrak{O}_F',
    1
),
(
    @eq_390,
    '\\mathfrak{O}_F',
    'funktionaler Organisationsraum',
    'In Definition 3.4.8 konstruierter Organisationsraum.',
    NULL,
    'Organisationsraum',
    2
),
(
    @eq_391,
    '\\chi',
    'Raum-Zeit-Kohärenzfunktion',
    'Normierte Funktion zur Quantifizierung der Kopplung zweier Organisationsräume.',
    NULL,
    '\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]',
    1
),
(
    @eq_391,
    '[0,1]',
    'normierter Wertebereich',
    'Wertebereich von vollständiger Entkopplung bis maximaler funktionaler Kopplung.',
    NULL,
    'reelles Intervall',
    2
),
(
    @eq_392,
    '\\mathfrak{O}_1',
    'erster Organisationsraum',
    'Erster funktionaler Organisationsraum der Kohärenzbewertung.',
    NULL,
    'funktionaler Organisationsraum',
    1
),
(
    @eq_392,
    '\\mathfrak{O}_2',
    'zweiter Organisationsraum',
    'Zweiter funktionaler Organisationsraum der Kohärenzbewertung.',
    NULL,
    'funktionaler Organisationsraum',
    2
),
(
    @eq_392,
    '\\chi',
    'symmetrische Kohärenzfunktion',
    'Im betrachteten Spezialfall wechselseitig definierte Raum-Zeit-Kohärenzfunktion.',
    NULL,
    '[0,1]',
    3
),
(
    @eq_393,
    '\\mathfrak{FRZK}',
    'Funktionales Raum-Zeit-Kohärenzsystem',
    'Gesamtstruktur aus Organisationsräumen, Kohärenzrelation und Kohärenzfunktion.',
    NULL,
    'FRZK-Systemstruktur',
    1
),
(
    @eq_393,
    '\\mathfrak{O}_F',
    'System der funktionalen Organisationsräume',
    'Gesamtheit der im FRZK berücksichtigten funktionalen Organisationsräume.',
    NULL,
    'Organisationsraumstruktur',
    2
),
(
    @eq_393,
    '\\mathcal{K}',
    'funktionale Kohärenzrelation',
    'Relation zwischen den funktionalen Organisationsräumen.',
    NULL,
    'Relation',
    3
),
(
    @eq_393,
    '\\chi',
    'Raum-Zeit-Kohärenzfunktion',
    'Quantitative Bewertung der funktionalen Kopplung.',
    NULL,
    '[0,1]',
    4
)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 14. Objektabhängigkeiten bereinigen und neu registrieren. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'definition'
        AND `object_id_from` IN (@def_3411_id,@def_3412_id)
    )
    OR
    (
        `object_type_from` = 'lemma'
        AND `object_id_from` = @lemma_344_id
    )
    OR
    (
        `object_type_from` = 'theorem'
        AND `object_id_from` = @theorem_346_id
    )
    OR
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (@eq_390,@eq_391,@eq_392,@eq_393)
    );

INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
(
    'definition',
    @def_3411_id,
    'axiom',
    @axiom_a5_id,
    'derives_from',
    'Def. 3.4.11 konkretisiert die durch Axiom A5 eröffnete Reproduzierbarkeit und Vergleichbarkeit funktionaler Organisationsmuster.'
),
(
    'definition',
    @def_3411_id,
    'definition',
    @def_348_id,
    'depends_on',
    'Die Raum-Zeit-Kohärenzrelation wird zwischen funktionalen Organisationsräumen definiert.'
),
(
    'definition',
    @def_3412_id,
    'definition',
    @def_3411_id,
    'depends_on',
    'Die Raum-Zeit-Kohärenzfunktion quantifiziert die zuvor definierte Kohärenzrelation.'
),
(
    'definition',
    @def_3412_id,
    'definition',
    @def_349_id,
    'uses',
    'Die Raum-Zeit-Kohärenzfunktion erweitert den zuvor eingeführten Kohärenzbegriff auf Paare von Organisationsräumen.'
),
(
    'lemma',
    @lemma_344_id,
    'definition',
    @def_3412_id,
    'derives_from',
    'Das Symmetrielemma bezieht sich auf die Raum-Zeit-Kohärenzfunktion.'
),
(
    'theorem',
    @theorem_346_id,
    'definition',
    @def_348_id,
    'depends_on',
    'Das FRZK setzt funktionale Organisationsräume voraus.'
),
(
    'theorem',
    @theorem_346_id,
    'definition',
    @def_3411_id,
    'depends_on',
    'Das FRZK setzt die funktionale Kohärenzrelation voraus.'
),
(
    'theorem',
    @theorem_346_id,
    'definition',
    @def_3412_id,
    'depends_on',
    'Das FRZK setzt die quantifizierende Raum-Zeit-Kohärenzfunktion voraus.'
),
(
    'equation',
    @eq_390,
    'definition',
    @def_3411_id,
    'derives_from',
    'Gleichung (3.90) formalisiert Def. 3.4.11.'
),
(
    'equation',
    @eq_391,
    'definition',
    @def_3412_id,
    'derives_from',
    'Gleichung (3.91) formalisiert Def. 3.4.12.'
),
(
    'equation',
    @eq_392,
    'lemma',
    @lemma_344_id,
    'derives_from',
    'Gleichung (3.92) formalisiert Lemma 3.4.4.'
),
(
    'equation',
    @eq_393,
    'theorem',
    @theorem_346_id,
    'derives_from',
    'Gleichung (3.93) formalisiert Satz 3.4.6.'
);

/* 15. Gleichungsabhängigkeiten neu registrieren. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_390,@eq_391,@eq_392,@eq_393);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_390,
    @eq_384,
    'uses',
    'Die Kohärenzrelation wird zwischen den in Gleichung (3.84) definierten funktionalen Organisationsräumen aufgebaut.'
),
(
    @eq_391,
    @eq_390,
    'uses',
    'Die Raum-Zeit-Kohärenzfunktion quantifiziert die in Gleichung (3.90) definierte Kohärenzrelation.'
),
(
    @eq_391,
    @eq_386,
    'generalizes',
    'Die Raum-Zeit-Kohärenzfunktion erweitert die Kohärenzfunktion aus Gleichung (3.86) auf Paare von Organisationsräumen.'
),
(
    @eq_392,
    @eq_391,
    'derived_from',
    'Die Symmetrieaussage bezieht sich auf die in Gleichung (3.91) definierte Raum-Zeit-Kohärenzfunktion.'
),
(
    @eq_393,
    @eq_390,
    'uses',
    'Das FRZK enthält die funktionale Kohärenzrelation.'
),
(
    @eq_393,
    @eq_391,
    'uses',
    'Das FRZK enthält die Raum-Zeit-Kohärenzfunktion.'
),
(
    @eq_393,
    @eq_384,
    'uses',
    'Das FRZK enthält funktionale Organisationsräume.'
);

/* 16. Änderungsprotokoll idempotent aktualisieren. */
DELETE FROM `section_change_log`
WHERE `revision_id` = @revision_id
  AND `section_id` = @section_id;

INSERT INTO `section_change_log` (
    `revision_id`,
    `section_id`,
    `change_type`,
    `object_type`,
    `object_reference`,
    `change_summary`,
    `previous_value`,
    `new_value`
)
VALUES
(
    @revision_id,
    @section_id,
    'rewritten',
    'section',
    '3.4.6',
    'Abschnitt 3.4.6 wurde vollständig als mathematische Rekonstruktion funktionaler Raum-Zeit-Kohärenz neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.6.',
    'Neufassung mit Def. 3.4.11, Def. 3.4.12, Lemma 3.4.4, Satz 3.4.6 und den Gleichungen (3.90) bis (3.93).'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.11–Def. 3.4.12',
    'Funktionale Raum-Zeit-Kohärenz und Raum-Zeit-Kohärenzfunktion wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'lemma',
    'Lemma 3.4.4',
    'Das Lemma zur Symmetrie der Raum-Zeit-Kohärenz wurde registriert.',
    NULL,
    'Symmetrie im wechselseitig definierten Spezialfall'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'theorem',
    'Satz 3.4.6',
    'Der Existenzsatz des Funktionalen Raum-Zeit-Kohärenzsystems wurde registriert.',
    NULL,
    'Existenz des Tripels aus Organisationsräumen, Kohärenzrelation und Kohärenzfunktion'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.90)–(3.93)',
    'Die Kohärenzrelation, Kohärenzfunktion, Symmetriebedingung und FRZK-Systemstruktur wurden formal registriert.',
    NULL,
    '4 Gleichungen'
);

/* 17. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.94'),
    ('next_definition_number', 'Def. 3.4.13'),
    ('next_lemma_number', 'Lemma 3.4.5'),
    ('next_theorem_number', 'Satz 3.4.7'),
    ('last_edited_section', '3.4.6'),
    ('last_repository_revision', 'RKB-2026-07-12-K3.4.6-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.4.6: review
   - Def. 3.4.11 und Def. 3.4.12
   - Lemma 3.4.4
   - Satz 3.4.6
   - Gleichungen (3.90) bis (3.93)
   - Quellenverwendungen: 0
   - next_equation_number = 3.94
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.6')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.11','Def. 3.4.12')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number` = 'Lemma 3.4.4';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.6';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93')
ORDER BY CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED);

SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.90','3.91','3.92','3.93')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    COUNT(*) AS `source_usages_in_3_4_6`
FROM `source_usage`
WHERE `section_id` = @section_id;

SELECT
    rc.`counter_key`,
    rc.`counter_value`
FROM `repository_counters` rc
WHERE rc.`counter_key` IN (
    'next_equation_number',
    'next_definition_number',
    'next_lemma_number',
    'next_theorem_number',
    'last_edited_section',
    'last_repository_revision'
)
ORDER BY rc.`counter_key`;
