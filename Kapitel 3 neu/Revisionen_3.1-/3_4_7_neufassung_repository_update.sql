USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.7
   Mathematische Rekonstruktion funktionaler Dynamik

   Definitionen:
   - Def. 3.4.13 Funktionale Dynamik
   - Def. 3.4.14 Funktionale Entwicklungsbahn

   Lemma:
   - Lemma 3.4.5 Kohärenzdifferenz auf Entwicklungsbahnen

   Satz:
   - Satz 3.4.7 Rekonstruktion funktionaler Entwicklung

   Gleichungen:
   - (3.94) Dynamikfunktion
   - (3.95) Funktionale Entwicklungsbahn
   - (3.96) Kohärenzdifferenz
   - (3.97) Rekonstruktion funktionaler Entwicklung

   Neue Quellen: keine

   Nächste Gleichung:  (3.98)
   Nächste Definition: Def. 3.4.15
   Nächstes Lemma:     Lemma 3.4.6
   Nächster Satz:      Satz 3.4.8

   WICHTIG:
   Es wird kein Axiom A6 verwendet. Die Rekonstruktion baut auf
   den bereits registrierten Axiomen A1 bis A5 sowie den
   Definitionen und Sätzen der Abschnitte 3.4.3 bis 3.4.6 auf.
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
    'RKB-2026-07-13-K3.4.7-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.7',
    '1.0',
    'Neufassung von Abschnitt 3.4.7 mit Def. 3.4.13, Def. 3.4.14, Lemma 3.4.5, Satz 3.4.7 sowie den Gleichungen (3.94) bis (3.97).',
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

/* 3. Kapitel 3.4 und Abschnitt 3.4.7 ermitteln.
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
    '3.4.7',
    'Mathematische Rekonstruktion funktionaler Dynamik',
    3,
    3.5700,
    'review',
    1,
    'Rekonstruktion funktionaler Dynamik aus Kohärenzänderungen entlang rekursiver Entwicklungsbahnen.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections` ds
      WHERE ds.`section_code` = '3.4.7'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.7'
    LIMIT 1
);

/* 4. Abschnitts- und Kapitelmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Mathematische Rekonstruktion funktionaler Dynamik',
    `chapter_no` = 3,
    `section_order` = 3.5700,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.13, Def. 3.4.14, Lemma 3.4.5, Satz 3.4.7 und die Gleichungen (3.94) bis (3.97).'
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
SET @axiom_a3_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A3'
    LIMIT 1
);

SET @axiom_a4_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A4'
    LIMIT 1
);

SET @def_346_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.6'
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

SET @def_3413_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.13'
    LIMIT 1
);

SET @def_3414_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.14'
    LIMIT 1
);

SET @lemma_345_id := (
    SELECT l.`lemma_id`
    FROM `lemmas` l
    WHERE l.`lemma_number` = 'Lemma 3.4.5'
    LIMIT 1
);

SET @theorem_347_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.7'
    LIMIT 1
);

/* 7. Def. 3.4.13 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Dynamik',
    `definition_text` = 'Funktionale Dynamik ist die Veränderung der funktionalen Kohärenz eines Organisationsraums entlang zulässiger rekursiver Transformationen.',
    `formal_latex` = '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    `word_latex` = '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.9, Def. 3.4.10 und Satz 3.4.6 gelten.',
    `notes` = 'Positive Werte bezeichnen Kohärenzzunahme, negative Werte Kohärenzverlust und der Wert 0 einen stationären Kohärenzzustand.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3413_id;

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
    'Def. 3.4.13',
    @section_id,
    'Funktionale Dynamik',
    'Funktionale Dynamik ist die Veränderung der funktionalen Kohärenz eines Organisationsraums entlang zulässiger rekursiver Transformationen.',
    '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    'original',
    NULL,
    'Def. 3.4.9, Def. 3.4.10 und Satz 3.4.6 gelten.',
    'Positive Werte bezeichnen Kohärenzzunahme, negative Werte Kohärenzverlust und der Wert 0 einen stationären Kohärenzzustand.',
    'checked',
    @revision_id
WHERE @def_3413_id IS NULL;

SET @def_3413_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.13'
    LIMIT 1
);

/* 8. Def. 3.4.14 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionale Entwicklungsbahn',
    `definition_text` = 'Eine funktionale Entwicklungsbahn ist eine geordnete endliche Folge funktionaler Organisationsräume, in der jeder Folgezustand aus seinem Vorgänger durch eine zulässige funktionale Transformation hervorgeht.',
    `formal_latex` = '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)',
    `word_latex` = '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.6 und Def. 3.4.8 gelten.',
    `notes` = 'Der Index ordnet die Transformationsschritte; er setzt noch keine physikalische Zeitmetrik voraus.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3414_id;

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
    'Def. 3.4.14',
    @section_id,
    'Funktionale Entwicklungsbahn',
    'Eine funktionale Entwicklungsbahn ist eine geordnete endliche Folge funktionaler Organisationsräume, in der jeder Folgezustand aus seinem Vorgänger durch eine zulässige funktionale Transformation hervorgeht.',
    '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)',
    '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)',
    'original',
    NULL,
    'Def. 3.4.6 und Def. 3.4.8 gelten.',
    'Der Index ordnet die Transformationsschritte; er setzt noch keine physikalische Zeitmetrik voraus.',
    'checked',
    @revision_id
WHERE @def_3414_id IS NULL;

SET @def_3414_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.14'
    LIMIT 1
);

/* 9. Lemma 3.4.5 aktualisieren oder anlegen. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Kohärenzdifferenz auf Entwicklungsbahnen',
    `statement_text` = 'Für zwei aufeinanderfolgende Organisationsräume einer funktionalen Entwicklungsbahn ist die funktionale Dynamik durch die Differenz ihrer Kohärenzwerte bestimmt.',
    `statement_latex` = '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)',
    `word_latex` = '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.9, Def. 3.4.13 und Def. 3.4.14 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_345_id;

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
    'Lemma 3.4.5',
    @section_id,
    'Kohärenzdifferenz auf Entwicklungsbahnen',
    'Für zwei aufeinanderfolgende Organisationsräume einer funktionalen Entwicklungsbahn ist die funktionale Dynamik durch die Differenz ihrer Kohärenzwerte bestimmt.',
    '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)',
    '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)',
    'original',
    NULL,
    'Def. 3.4.9, Def. 3.4.13 und Def. 3.4.14 gelten.',
    'checked',
    @revision_id
WHERE @lemma_345_id IS NULL;

SET @lemma_345_id := (
    SELECT l.`lemma_id`
    FROM `lemmas` l
    WHERE l.`lemma_number` = 'Lemma 3.4.5'
    LIMIT 1
);

/* 10. Satz 3.4.7 aktualisieren oder anlegen. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Rekonstruktion funktionaler Entwicklung',
    `statement_text` = 'Jede wohldefinierte endliche rekursive Transformationsfolge auf funktionalen Organisationsräumen erzeugt eine eindeutig bestimmte funktionale Entwicklungsbahn.',
    `statement_latex` = '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F',
    `word_latex` = '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten; die verwendete Transformation ist wohldefiniert.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_347_id;

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
    'Satz 3.4.7',
    @section_id,
    'Rekonstruktion funktionaler Entwicklung',
    'Jede wohldefinierte endliche rekursive Transformationsfolge auf funktionalen Organisationsräumen erzeugt eine eindeutig bestimmte funktionale Entwicklungsbahn.',
    '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F',
    '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F',
    'original',
    NULL,
    'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten; die verwendete Transformation ist wohldefiniert.',
    'checked',
    @revision_id
WHERE @theorem_347_id IS NULL;

SET @theorem_347_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.7'
    LIMIT 1
);

/* 11. Alte Belegungen der Gleichungsnummern (3.94) bis (3.97)
       einschließlich abhängiger Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.94','3.95','3.96','3.97');

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
    '3.94',
    @section_id,
    'Funktionale Dynamikfunktion',
    '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    'Die Dynamikfunktion ordnet einem funktionalen Raum-Zeit-Kohärenzsystem eine reelle Kohärenzänderung zu.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.13.',
    'Def. 3.4.9 und Satz 3.4.6 gelten.',
    'checked',
    @revision_id
),
(
    '3.95',
    @section_id,
    'Funktionale Entwicklungsbahn',
    '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)',
    '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)',
    'Eine funktionale Entwicklungsbahn ist eine geordnete Folge funktionaler Organisationsräume.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.14.',
    'Def. 3.4.6 und Def. 3.4.8 gelten.',
    'checked',
    @revision_id
),
(
    '3.96',
    @section_id,
    'Kohärenzdifferenz auf Entwicklungsbahnen',
    '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)',
    '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)',
    'Die funktionale Dynamik zwischen zwei aufeinanderfolgenden Organisationsräumen wird als Differenz ihrer Kohärenzwerte definiert.',
    'lemma',
    'original',
    NULL,
    'Formale Darstellung von Lemma 3.4.5.',
    'Def. 3.4.9, Def. 3.4.13 und Def. 3.4.14 gelten.',
    'checked',
    @revision_id
),
(
    '3.97',
    @section_id,
    'Rekonstruktion funktionaler Entwicklung',
    '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F',
    '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F',
    'Eine wohldefinierte endliche rekursive Transformationsfolge erzeugt eine funktionale Entwicklungsbahn.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.7.',
    'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten.',
    'checked',
    @revision_id
);

SET @eq_394 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.94'
    LIMIT 1
);

SET @eq_395 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.95'
    LIMIT 1
);

SET @eq_396 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.96'
    LIMIT 1
);

SET @eq_397 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.97'
    LIMIT 1
);

SET @eq_380 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.80'
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

SET @eq_393 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.93'
    LIMIT 1
);

/* 13. Symbolregister anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_394,@eq_395,@eq_396,@eq_397);

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
    @eq_394,
    '\\Delta_{\\kappa}',
    'funktionale Dynamik',
    'Reelle Änderung der funktionalen Kohärenz.',
    NULL,
    '\\mathfrak{FRZK}\\rightarrow\\mathbb{R}',
    1
),
(
    @eq_394,
    '\\mathfrak{FRZK}',
    'Funktionales Raum-Zeit-Kohärenzsystem',
    'In Satz 3.4.6 definierte Gesamtsystemstruktur.',
    NULL,
    'FRZK-Systemstruktur',
    2
),
(
    @eq_395,
    '\\Gamma_F',
    'funktionale Entwicklungsbahn',
    'Geordnete Folge funktionaler Organisationsräume.',
    NULL,
    'endliche Folge',
    1
),
(
    @eq_395,
    '\\mathfrak{O}_i',
    'i-ter Organisationsraum',
    'Funktionaler Organisationsraum an der i-ten Stelle der Entwicklungsbahn.',
    NULL,
    'funktionaler Organisationsraum',
    2
),
(
    @eq_395,
    'n',
    'Anzahl der Transformationsschritte',
    'Endlicher Index der Entwicklungsbahn.',
    NULL,
    '\\mathbb{N}',
    3
),
(
    @eq_396,
    '\\Delta_{\\kappa}',
    'Kohärenzdifferenz',
    'Differenz zwischen zwei aufeinanderfolgenden Kohärenzwerten.',
    NULL,
    '\\mathbb{R}',
    1
),
(
    @eq_396,
    '\\kappa(\\mathfrak{O}_{i+1})',
    'nachfolgender Kohärenzwert',
    'Kohärenzwert des nachfolgenden Organisationsraums.',
    NULL,
    '[0,1]',
    2
),
(
    @eq_396,
    '\\kappa(\\mathfrak{O}_i)',
    'vorhergehender Kohärenzwert',
    'Kohärenzwert des vorhergehenden Organisationsraums.',
    NULL,
    '[0,1]',
    3
),
(
    @eq_397,
    '\\mathcal{T}_F^{\\,n}',
    'rekursive Transformationsfolge',
    'n-fache wohldefinierte Anwendung der funktionalen Transformation.',
    NULL,
    'Abbildungsfolge',
    1
),
(
    @eq_397,
    '\\Gamma_F',
    'resultierende Entwicklungsbahn',
    'Durch die rekursive Transformationsfolge erzeugte geordnete Folge.',
    NULL,
    'funktionale Entwicklungsbahn',
    2
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
        AND `object_id_from` IN (@def_3413_id,@def_3414_id)
    )
    OR
    (
        `object_type_from` = 'lemma'
        AND `object_id_from` = @lemma_345_id
    )
    OR
    (
        `object_type_from` = 'theorem'
        AND `object_id_from` = @theorem_347_id
    )
    OR
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (@eq_394,@eq_395,@eq_396,@eq_397)
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
    @def_3413_id,
    'axiom',
    @axiom_a3_id,
    'derives_from',
    'Funktionale Dynamik baut auf der durch A3 eröffneten rekursiven Transformation auf.'
),
(
    'definition',
    @def_3413_id,
    'axiom',
    @axiom_a4_id,
    'derives_from',
    'Die Kohärenzänderung setzt stabile funktionale Organisation voraus.'
),
(
    'definition',
    @def_3413_id,
    'definition',
    @def_349_id,
    'depends_on',
    'Die funktionale Dynamik verwendet die Kohärenzfunktion.'
),
(
    'definition',
    @def_3414_id,
    'definition',
    @def_346_id,
    'depends_on',
    'Die Entwicklungsbahn wird durch rekursive Transformationen erzeugt.'
),
(
    'definition',
    @def_3414_id,
    'definition',
    @def_348_id,
    'depends_on',
    'Die Elemente der Entwicklungsbahn sind funktionale Organisationsräume.'
),
(
    'lemma',
    @lemma_345_id,
    'definition',
    @def_3413_id,
    'depends_on',
    'Das Lemma verwendet die Definition funktionaler Dynamik.'
),
(
    'lemma',
    @lemma_345_id,
    'definition',
    @def_3414_id,
    'depends_on',
    'Die Kohärenzdifferenz wird auf einer funktionalen Entwicklungsbahn gebildet.'
),
(
    'theorem',
    @theorem_347_id,
    'definition',
    @def_346_id,
    'depends_on',
    'Der Satz setzt rekursive Transformationen voraus.'
),
(
    'theorem',
    @theorem_347_id,
    'definition',
    @def_3414_id,
    'derives_from',
    'Die resultierende Folge wird als funktionale Entwicklungsbahn definiert.'
),
(
    'equation',
    @eq_394,
    'definition',
    @def_3413_id,
    'derives_from',
    'Gleichung (3.94) formalisiert Def. 3.4.13.'
),
(
    'equation',
    @eq_395,
    'definition',
    @def_3414_id,
    'derives_from',
    'Gleichung (3.95) formalisiert Def. 3.4.14.'
),
(
    'equation',
    @eq_396,
    'lemma',
    @lemma_345_id,
    'derives_from',
    'Gleichung (3.96) formalisiert Lemma 3.4.5.'
),
(
    'equation',
    @eq_397,
    'theorem',
    @theorem_347_id,
    'derives_from',
    'Gleichung (3.97) formalisiert Satz 3.4.7.'
);

/* 15. Gleichungsabhängigkeiten neu registrieren. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_394,@eq_395,@eq_396,@eq_397);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_394,
    @eq_393,
    'uses',
    'Die Dynamikfunktion wird auf dem in Gleichung (3.93) definierten FRZK-System aufgebaut.'
),
(
    @eq_394,
    @eq_386,
    'uses',
    'Die Dynamikfunktion verwendet die in Gleichung (3.86) eingeführte Kohärenzfunktion.'
),
(
    @eq_395,
    @eq_384,
    'uses',
    'Die Entwicklungsbahn besteht aus funktionalen Organisationsräumen nach Gleichung (3.84).'
),
(
    @eq_395,
    @eq_380,
    'uses',
    'Die Reihenfolge der Entwicklungsbahn wird durch rekursive Transformationen nach Gleichung (3.80) erzeugt.'
),
(
    @eq_396,
    @eq_395,
    'uses',
    'Die Kohärenzdifferenz wird zwischen aufeinanderfolgenden Elementen der Entwicklungsbahn gebildet.'
),
(
    @eq_396,
    @eq_386,
    'uses',
    'Die Differenz verwendet die Kohärenzwerte aus Gleichung (3.86).'
),
(
    @eq_397,
    @eq_380,
    'uses',
    'Der Satz verwendet die rekursive Transformationsfolge aus Gleichung (3.80).'
),
(
    @eq_397,
    @eq_395,
    'derived_from',
    'Die resultierende Folge wird als Entwicklungsbahn nach Gleichung (3.95) dargestellt.'
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
    '3.4.7',
    'Abschnitt 3.4.7 wurde vollständig als mathematische Rekonstruktion funktionaler Dynamik neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.7.',
    'Neufassung mit Def. 3.4.13, Def. 3.4.14, Lemma 3.4.5, Satz 3.4.7 und den Gleichungen (3.94) bis (3.97).'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.13–Def. 3.4.14',
    'Funktionale Dynamik und funktionale Entwicklungsbahn wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'lemma',
    'Lemma 3.4.5',
    'Das Lemma zur Kohärenzdifferenz auf Entwicklungsbahnen wurde registriert.',
    NULL,
    'Kohärenzdifferenz auf Entwicklungsbahnen'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'theorem',
    'Satz 3.4.7',
    'Der Satz zur Rekonstruktion funktionaler Entwicklung wurde registriert.',
    NULL,
    'Rekonstruktion funktionaler Entwicklung'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.94)–(3.97)',
    'Dynamikfunktion, Entwicklungsbahn, Kohärenzdifferenz und Rekonstruktionssatz wurden formal registriert.',
    NULL,
    '4 Gleichungen'
);

/* 17. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.98'),
    ('next_definition_number', 'Def. 3.4.15'),
    ('next_lemma_number', 'Lemma 3.4.6'),
    ('next_theorem_number', 'Satz 3.4.8'),
    ('last_edited_section', '3.4.7'),
    ('last_repository_revision', 'RKB-2026-07-13-K3.4.7-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.4.7: review
   - Def. 3.4.13 und Def. 3.4.14
   - Lemma 3.4.5
   - Satz 3.4.7
   - Gleichungen (3.94) bis (3.97)
   - Quellenverwendungen: 0
   - next_equation_number = 3.98
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.7')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.13','Def. 3.4.14')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number` = 'Lemma 3.4.5';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.7';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97')
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
WHERE e.`equation_number` IN ('3.94','3.95','3.96','3.97')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    COUNT(*) AS `source_usages_in_3_4_7`
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
