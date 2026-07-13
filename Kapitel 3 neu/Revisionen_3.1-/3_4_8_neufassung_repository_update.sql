USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.8
   Mathematische Rekonstruktion funktionaler Attraktoren

   Definitionen:
   - Def. 3.4.15 Funktionaler Attraktor
   - Def. 3.4.16 Attraktorenmenge

   Lemma:
   - Lemma 3.4.6 Kohärenzerhaltung funktionaler Attraktoren

   Satz:
   - Satz 3.4.8 Existenz stabiler funktionaler Attraktoren

   Gleichungen:
   - (3.98)  Funktionaler Attraktor
   - (3.99)  Attraktorenmenge
   - (3.100) Kohärenzerhaltung
   - (3.101) Existenz funktionaler Attraktoren

   Neue Quellen: keine

   Nächste Gleichung:   (3.102)
   Nächste Definition:  Def. 3.4.17
   Nächstes Lemma:      Lemma 3.4.7
   Nächster Satz:       Satz 3.4.9
   ============================================================ */

/* 1. Parent-Revision separat ermitteln, damit MySQL-Fehler #1093
      vermieden wird. */
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
    'RKB-2026-07-13-K3.4.8-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.8',
    '1.0',
    'Neufassung von Abschnitt 3.4.8 mit Def. 3.4.15, Def. 3.4.16, Lemma 3.4.6, Satz 3.4.8 sowie den Gleichungen (3.98) bis (3.101).',
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

/* 3. Kapitel 3.4 und Abschnitt 3.4.8 ermitteln.
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
    '3.4.8',
    'Mathematische Rekonstruktion funktionaler Attraktoren',
    3,
    3.5800,
    'review',
    1,
    'Rekonstruktion funktionaler Attraktoren aus rekursiver Transformation und Kohärenzerhaltung.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections` ds
      WHERE ds.`section_code` = '3.4.8'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.8'
    LIMIT 1
);

/* 4. Abschnitts- und Kapitelmetadaten aktualisieren. */
UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Mathematische Rekonstruktion funktionaler Attraktoren',
    `chapter_no` = 3,
    `section_order` = 3.5800,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.15, Def. 3.4.16, Lemma 3.4.6, Satz 3.4.8 und die Gleichungen (3.98) bis (3.101).'
WHERE `section_id` = @section_id;

UPDATE `dissertation_sections`
SET
    `status` = 'review',
    `is_original_contribution` = 1
WHERE `section_id` = @chapter_id;

/* 5. Abschnitt enthält bewusst keine Literaturverwendung. */
DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 6. Vorgängerobjekte und Zielobjekte ermitteln. */
SET @axiom_a4_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A4'
    LIMIT 1
);

SET @axiom_a5_id := (
    SELECT a.`axiom_id`
    FROM `axioms` a
    WHERE a.`axiom_number` = 'A5'
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

SET @def_3414_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.14'
    LIMIT 1
);

SET @def_3415_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.15'
    LIMIT 1
);

SET @def_3416_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.16'
    LIMIT 1
);

SET @lemma_346_id := (
    SELECT l.`lemma_id`
    FROM `lemmas` l
    WHERE l.`lemma_number` = 'Lemma 3.4.6'
    LIMIT 1
);

SET @theorem_348_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.8'
    LIMIT 1
);

/* 7. Def. 3.4.15 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Funktionaler Attraktor',
    `definition_text` = 'Ein funktionaler Organisationsraum heißt funktionaler Attraktor, wenn er nach einer endlichen Anzahl zulässiger rekursiver Transformationen wieder erreicht wird.',
    `formal_latex` = '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A',
    `word_latex` = '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten; n ist eine positive endliche Iterationszahl.',
    `notes` = 'Die Definition beschreibt einen periodischen funktionalen Attraktor. Der Spezialfall n=1 ist ein funktionaler Fixpunkt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3415_id;

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
    'Def. 3.4.15',
    @section_id,
    'Funktionaler Attraktor',
    'Ein funktionaler Organisationsraum heißt funktionaler Attraktor, wenn er nach einer endlichen Anzahl zulässiger rekursiver Transformationen wieder erreicht wird.',
    '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A',
    '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A',
    'original',
    NULL,
    'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten; n ist eine positive endliche Iterationszahl.',
    'Die Definition beschreibt einen periodischen funktionalen Attraktor. Der Spezialfall n=1 ist ein funktionaler Fixpunkt.',
    'checked',
    @revision_id
WHERE @def_3415_id IS NULL;

SET @def_3415_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.15'
    LIMIT 1
);

/* 8. Def. 3.4.16 aktualisieren oder anlegen. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Attraktorenmenge',
    `definition_text` = 'Die Attraktorenmenge ist die Menge aller funktionalen Organisationsräume, die nach einer endlichen rekursiven Transformationsfolge wieder erreicht werden.',
    `formal_latex` = '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}',
    `word_latex` = '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.15 gilt.',
    `notes` = 'Die Attraktorenmenge kann leer sein, sofern kein funktionaler Organisationsraum die Wiederkehrbedingung erfüllt.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3416_id;

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
    'Def. 3.4.16',
    @section_id,
    'Attraktorenmenge',
    'Die Attraktorenmenge ist die Menge aller funktionalen Organisationsräume, die nach einer endlichen rekursiven Transformationsfolge wieder erreicht werden.',
    '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}',
    '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}',
    'original',
    NULL,
    'Def. 3.4.15 gilt.',
    'Die Attraktorenmenge kann leer sein, sofern kein funktionaler Organisationsraum die Wiederkehrbedingung erfüllt.',
    'checked',
    @revision_id
WHERE @def_3416_id IS NULL;

SET @def_3416_id := (
    SELECT d.`definition_id`
    FROM `definitions` d
    WHERE d.`definition_number` = 'Def. 3.4.16'
    LIMIT 1
);

/* 9. Lemma 3.4.6 aktualisieren oder anlegen. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Kohärenzerhaltung funktionaler Attraktoren',
    `statement_text` = 'Für einen funktionalen Attraktor stimmt der Kohärenzwert des Ausgangsraums mit dem Kohärenzwert des nach n Transformationen wieder erreichten Organisationsraums überein.',
    `statement_latex` = '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)',
    `word_latex` = '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.9 und Def. 3.4.15 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_346_id;

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
    'Lemma 3.4.6',
    @section_id,
    'Kohärenzerhaltung funktionaler Attraktoren',
    'Für einen funktionalen Attraktor stimmt der Kohärenzwert des Ausgangsraums mit dem Kohärenzwert des nach n Transformationen wieder erreichten Organisationsraums überein.',
    '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)',
    '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)',
    'original',
    NULL,
    'Def. 3.4.9 und Def. 3.4.15 gelten.',
    'checked',
    @revision_id
WHERE @lemma_346_id IS NULL;

SET @lemma_346_id := (
    SELECT l.`lemma_id`
    FROM `lemmas` l
    WHERE l.`lemma_number` = 'Lemma 3.4.6'
    LIMIT 1
);

/* 10. Satz 3.4.8 aktualisieren oder anlegen.
       Die Aussage wird logisch präzisiert: Eine bloß endliche Folge
       mit konstantem Kohärenzwert garantiert noch keine Wiederkehr.
       Erforderlich ist zusätzlich eine endliche, deterministische
       Entwicklungsbahn in einer endlichen Menge von Organisationsräumen. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Existenz stabiler funktionaler Attraktoren',
    `statement_text` = 'Verläuft eine unendliche deterministische Entwicklungsbahn in einer endlichen Menge funktionaler Organisationsräume, dann wird mindestens ein Organisationsraum wiederholt erreicht und gehört damit zur Attraktorenmenge.',
    `statement_latex` = '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F',
    `word_latex` = '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.14 bis Def. 3.4.16 gelten; die Entwicklungsbahn ist deterministisch, unendlich fortsetzbar und nimmt Werte in einer endlichen Menge funktionaler Organisationsräume an.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_348_id;

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
    'Satz 3.4.8',
    @section_id,
    'Existenz stabiler funktionaler Attraktoren',
    'Verläuft eine unendliche deterministische Entwicklungsbahn in einer endlichen Menge funktionaler Organisationsräume, dann wird mindestens ein Organisationsraum wiederholt erreicht und gehört damit zur Attraktorenmenge.',
    '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F',
    '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F',
    'original',
    NULL,
    'Def. 3.4.14 bis Def. 3.4.16 gelten; die Entwicklungsbahn ist deterministisch, unendlich fortsetzbar und nimmt Werte in einer endlichen Menge funktionaler Organisationsräume an.',
    'checked',
    @revision_id
WHERE @theorem_348_id IS NULL;

SET @theorem_348_id := (
    SELECT t.`theorem_id`
    FROM `theorems` t
    WHERE t.`theorem_number` = 'Satz 3.4.8'
    LIMIT 1
);

/* 11. Alte Belegungen der Gleichungen (3.98) bis (3.101)
       einschließlich abhängiger Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101')
        )
    )
    OR
    (
        `object_type_to` = 'equation'
        AND `object_id_to` IN (
            SELECT e.`equation_id`
            FROM `equations` e
            WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101')
        )
    );

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.98','3.99','3.100','3.101');

/* 12. Gleichungen neu einfügen. */
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
    '3.98',
    @section_id,
    'Funktionaler Attraktor',
    '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A',
    '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A',
    'Ein funktionaler Organisationsraum wird nach n rekursiven Transformationen wieder erreicht.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.15.',
    'Def. 3.4.6 und Def. 3.4.8 gelten; n ist positiv und endlich.',
    'checked',
    @revision_id
),
(
    '3.99',
    @section_id,
    'Attraktorenmenge',
    '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}',
    '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}',
    'Die Attraktorenmenge enthält alle funktionalen Organisationsräume, welche die Wiederkehrbedingung erfüllen.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.16.',
    'Def. 3.4.15 gilt.',
    'checked',
    @revision_id
),
(
    '3.100',
    @section_id,
    'Kohärenzerhaltung funktionaler Attraktoren',
    '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)',
    '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)',
    'Die Wiederkehr desselben funktionalen Organisationsraums erhält dessen Kohärenzwert.',
    'lemma',
    'original',
    NULL,
    'Formale Darstellung von Lemma 3.4.6.',
    'Def. 3.4.9 und Def. 3.4.15 gelten.',
    'checked',
    @revision_id
),
(
    '3.101',
    @section_id,
    'Existenz funktionaler Attraktoren',
    '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F',
    '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F',
    'Eine unendliche deterministische Entwicklungsbahn in einer endlichen Menge funktionaler Organisationsräume enthält mindestens einen wiederkehrenden Organisationsraum.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.8 auf Grundlage des Schubfachprinzips.',
    'Die Entwicklungsbahn ist deterministisch, unendlich fortsetzbar und nimmt Werte in einer endlichen Menge funktionaler Organisationsräume an.',
    'checked',
    @revision_id
);

SET @eq_398 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.98'
    LIMIT 1
);

SET @eq_399 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.99'
    LIMIT 1
);

SET @eq_3100 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.100'
    LIMIT 1
);

SET @eq_3101 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.101'
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

SET @eq_395 := (
    SELECT e.`equation_id`
    FROM `equations` e
    WHERE e.`equation_number` = '3.95'
    LIMIT 1
);

/* 13. Symbolregister vollständig anlegen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_398,@eq_399,@eq_3100,@eq_3101);

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
    @eq_398,
    '\\mathcal{T}_F^{\\,n}',
    'n-fache funktionale Transformation',
    'n-fache Komposition der funktionalen Transformation.',
    NULL,
    'Abbildung auf funktionalen Organisationsräumen',
    1
),
(
    @eq_398,
    '\\mathfrak{O}_A',
    'funktionaler Attraktor',
    'Funktionaler Organisationsraum, der nach n Transformationen wieder erreicht wird.',
    NULL,
    'funktionaler Organisationsraum',
    2
),
(
    @eq_398,
    'n',
    'Periodenlänge',
    'Positive endliche Anzahl der Transformationen bis zur Wiederkehr.',
    NULL,
    '\\mathbb{N}_{>0}',
    3
),
(
    @eq_399,
    '\\mathcal{A}_F',
    'Attraktorenmenge',
    'Menge aller funktionalen Organisationsräume mit endlicher Wiederkehr.',
    NULL,
    'Menge funktionaler Organisationsräume',
    1
),
(
    @eq_399,
    '\\mathfrak{O}_A',
    'Element der Attraktorenmenge',
    'Ein die Wiederkehrbedingung erfüllender funktionaler Organisationsraum.',
    NULL,
    '\\mathfrak{O}_A\\in\\mathcal{A}_F',
    2
),
(
    @eq_3100,
    '\\kappa',
    'Kohärenzfunktion',
    'Normiertes Maß funktionaler Kohärenz.',
    NULL,
    'Organisationsraum nach [0,1]',
    1
),
(
    @eq_3100,
    '\\mathfrak{O}_A',
    'funktionaler Attraktor',
    'Wiederkehrender funktionaler Organisationsraum.',
    NULL,
    'funktionaler Organisationsraum',
    2
),
(
    @eq_3101,
    '\\left|\\{\\mathfrak{O}_i\\}\\right|',
    'Anzahl erreichbarer Organisationsräume',
    'Kardinalität der von der Entwicklungsbahn besuchten Organisationsraummenge.',
    NULL,
    '\\mathbb{N}',
    1
),
(
    @eq_3101,
    '\\exists',
    'Existenzquantor',
    'Kennzeichnet die Existenz mindestens eines funktionalen Attraktors.',
    NULL,
    'Logik',
    2
),
(
    @eq_3101,
    '\\mathcal{A}_F',
    'Attraktorenmenge',
    'Menge der funktionalen Attraktoren.',
    NULL,
    'Menge',
    3
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
        AND `object_id_from` IN (@def_3415_id,@def_3416_id)
    )
    OR
    (
        `object_type_from` = 'lemma'
        AND `object_id_from` = @lemma_346_id
    )
    OR
    (
        `object_type_from` = 'theorem'
        AND `object_id_from` = @theorem_348_id
    )
    OR
    (
        `object_type_from` = 'equation'
        AND `object_id_from` IN (@eq_398,@eq_399,@eq_3100,@eq_3101)
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
    @def_3415_id,
    'axiom',
    @axiom_a4_id,
    'derives_from',
    'Der funktionale Attraktor konkretisiert stabile funktionale Organisation nach Axiom A4.'
),
(
    'definition',
    @def_3415_id,
    'definition',
    @def_346_id,
    'depends_on',
    'Die Attraktordefinition verwendet rekursive Transformationen.'
),
(
    'definition',
    @def_3415_id,
    'definition',
    @def_348_id,
    'depends_on',
    'Ein funktionaler Attraktor ist ein besonderer funktionaler Organisationsraum.'
),
(
    'definition',
    @def_3416_id,
    'definition',
    @def_3415_id,
    'depends_on',
    'Die Attraktorenmenge setzt die Definition des funktionalen Attraktors voraus.'
),
(
    'lemma',
    @lemma_346_id,
    'definition',
    @def_3415_id,
    'depends_on',
    'Das Kohärenzlemma setzt die Attraktordefinition voraus.'
),
(
    'lemma',
    @lemma_346_id,
    'definition',
    @def_349_id,
    'depends_on',
    'Das Kohärenzlemma verwendet die Kohärenzfunktion.'
),
(
    'theorem',
    @theorem_348_id,
    'definition',
    @def_3414_id,
    'depends_on',
    'Der Existenzsatz verwendet funktionale Entwicklungsbahnen.'
),
(
    'theorem',
    @theorem_348_id,
    'definition',
    @def_3416_id,
    'derives_from',
    'Wiederkehrende Organisationsräume gehören nach Def. 3.4.16 zur Attraktorenmenge.'
),
(
    'equation',
    @eq_398,
    'definition',
    @def_3415_id,
    'derives_from',
    'Gleichung (3.98) formalisiert Def. 3.4.15.'
),
(
    'equation',
    @eq_399,
    'definition',
    @def_3416_id,
    'derives_from',
    'Gleichung (3.99) formalisiert Def. 3.4.16.'
),
(
    'equation',
    @eq_3100,
    'lemma',
    @lemma_346_id,
    'derives_from',
    'Gleichung (3.100) formalisiert Lemma 3.4.6.'
),
(
    'equation',
    @eq_3101,
    'theorem',
    @theorem_348_id,
    'derives_from',
    'Gleichung (3.101) formalisiert Satz 3.4.8.'
);

/* 15. Gleichungsabhängigkeiten neu registrieren.
       Zulässige dependency_type-Werte des Schemas werden verwendet. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_398,@eq_399,@eq_3100,@eq_3101);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(
    @eq_398,
    @eq_380,
    'depends_on',
    'Die Attraktorbedingung verwendet die rekursive Transformation aus Gleichung (3.80).'
),
(
    @eq_398,
    @eq_384,
    'depends_on',
    'Der Attraktor ist ein funktionaler Organisationsraum nach Gleichung (3.84).'
),
(
    @eq_399,
    @eq_398,
    'derives_from',
    'Die Attraktorenmenge wird aus der Attraktorbedingung gebildet.'
),
(
    @eq_3100,
    @eq_398,
    'derives_from',
    'Die Kohärenzerhaltung folgt aus der Wiederkehr desselben Organisationsraums.'
),
(
    @eq_3100,
    @eq_386,
    'depends_on',
    'Die Aussage verwendet die Kohärenzfunktion aus Gleichung (3.86).'
),
(
    @eq_3101,
    @eq_395,
    'depends_on',
    'Der Existenzsatz verwendet die funktionale Entwicklungsbahn aus Gleichung (3.95).'
),
(
    @eq_3101,
    @eq_399,
    'derives_from',
    'Ein wiederkehrender Organisationsraum gehört zur Attraktorenmenge.'
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
    '3.4.8',
    'Abschnitt 3.4.8 wurde vollständig als mathematische Rekonstruktion funktionaler Attraktoren neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.8.',
    'Neufassung mit Def. 3.4.15, Def. 3.4.16, Lemma 3.4.6, Satz 3.4.8 und den Gleichungen (3.98) bis (3.101).'
),
(
    @revision_id,
    @section_id,
    'definition_added',
    'definition',
    'Def. 3.4.15–Def. 3.4.16',
    'Funktionaler Attraktor und Attraktorenmenge wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'lemma',
    'Lemma 3.4.6',
    'Die Kohärenzerhaltung funktionaler Attraktoren wurde registriert.',
    NULL,
    'Kohärenzerhaltung funktionaler Attraktoren'
),
(
    @revision_id,
    @section_id,
    'statement_added',
    'theorem',
    'Satz 3.4.8',
    'Der Existenzsatz funktionaler Attraktoren wurde logisch präzisiert und registriert.',
    'Endliche Folge mit invariantem Kohärenzwert ohne hinreichende Wiederkehrbedingung.',
    'Deterministische, unendlich fortsetzbare Entwicklungsbahn in einer endlichen Organisationsraummenge.'
),
(
    @revision_id,
    @section_id,
    'equation_added',
    'equation',
    '(3.98)–(3.101)',
    'Attraktorbedingung, Attraktorenmenge, Kohärenzerhaltung und Existenzsatz wurden formal registriert.',
    NULL,
    '4 Gleichungen'
);

/* 17. Repository-Zähler aktualisieren. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
    ('next_equation_number', '3.102'),
    ('next_definition_number', 'Def. 3.4.17'),
    ('next_lemma_number', 'Lemma 3.4.7'),
    ('next_theorem_number', 'Satz 3.4.9'),
    ('last_edited_section', '3.4.8'),
    ('last_repository_revision', 'RKB-2026-07-13-K3.4.8-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN

   Erwartet:
   - Abschnitt 3.4.8: review
   - Def. 3.4.15 und Def. 3.4.16
   - Lemma 3.4.6
   - Satz 3.4.8
   - Gleichungen (3.98) bis (3.101)
   - Quellenverwendungen: 0
   - next_equation_number = 3.102
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.8')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.15','Def. 3.4.16')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number` = 'Lemma 3.4.6';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`assumptions`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.8';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101')
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
WHERE e.`equation_number` IN ('3.98','3.99','3.100','3.101')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT
    COUNT(*) AS `source_usages_in_3_4_8`
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
