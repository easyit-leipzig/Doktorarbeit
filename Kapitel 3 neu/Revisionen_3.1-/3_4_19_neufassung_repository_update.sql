USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.19
   Differenzierbare funktionale Mannigfaltigkeiten

   Definitionen:
   - Def. 3.4.36 Differenzierbare funktionale Karte
   - Def. 3.4.37 Differenzierbarer funktionaler Atlas

   Lemma:
   - Lemma 3.4.17 Eindeutigkeit der differenzierbaren Struktur

   Satz:
   - Satz 3.4.19 Differenzierbare funktionale Mannigfaltigkeit

   Gleichungen:
   - (3.148) Differenzierbarer Kartenübergang
   - (3.149) Differenzierbarer funktionaler Atlas
   - (3.150) Differenzierbare funktionale Mannigfaltigkeit

   Neue Quellen: keine

   Nächste Gleichung:   (3.151)
   Nächste Definition:  Def. 3.4.38
   Nächstes Lemma:      Lemma 3.4.18
   Nächster Satz:       Satz 3.4.20
   ============================================================ */

/* 1. Parent-Revision separat ermitteln, um MySQL #1093 zu vermeiden. */
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
    'RKB-2026-07-13-K3.4.19-NEUFASSUNG-V1',
    NOW(),
    'section',
    '3.4.19',
    '1.0',
    'Neufassung von Abschnitt 3.4.19 mit Def. 3.4.36, Def. 3.4.37, Lemma 3.4.17, Satz 3.4.19 und den Gleichungen (3.148) bis (3.150).',
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

/* 3. Kapitel und Abschnitt ermitteln; Abschnitt bei Bedarf anlegen. */
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
    '3.4.19',
    'Differenzierbare funktionale Mannigfaltigkeiten',
    3,
    3.6000,
    'review',
    1,
    'Rekonstruktion differenzierbarer Karten, Atlanten und funktionaler Mannigfaltigkeiten.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM `dissertation_sections`
      WHERE `section_code` = '3.4.19'
  );

SET @section_id := (
    SELECT ds.`section_id`
    FROM `dissertation_sections` ds
    WHERE ds.`section_code` = '3.4.19'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id` = @chapter_id,
    `title` = 'Differenzierbare funktionale Mannigfaltigkeiten',
    `chapter_no` = 3,
    `section_order` = 3.6000,
    `status` = 'review',
    `is_original_contribution` = 1,
    `notes` = 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.36, Def. 3.4.37, Lemma 3.4.17, Satz 3.4.19 und die Gleichungen (3.148) bis (3.150).'
WHERE `section_id` = @section_id;

DELETE FROM `source_usage`
WHERE `section_id` = @section_id;

/* 4. Vorgänger- und Zielobjekte ermitteln. */
SET @def_3434_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.34'
    LIMIT 1
);

SET @def_3435_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.35'
    LIMIT 1
);

SET @def_3436_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.36'
    LIMIT 1
);

SET @def_3437_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.37'
    LIMIT 1
);

SET @lemma_3417_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.17'
    LIMIT 1
);

SET @theorem_3419_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.19'
    LIMIT 1
);

/* 5. Def. 3.4.36 – Differenzierbare funktionale Karte. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Differenzierbare funktionale Karte',
    `definition_text` = 'Eine funktionale Karte heißt C^k-differenzierbar, wenn sämtliche Kartenübergänge zu überlappenden funktionalen Karten k-mal stetig differenzierbar sind.',
    `formal_latex` = '\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    `word_latex` = '\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.34 und Lemma 3.4.16 gelten.',
    `notes` = 'Für k=\\infty wird von glatten funktionalen Karten gesprochen.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3436_id;

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
    'Def. 3.4.36',
    @section_id,
    'Differenzierbare funktionale Karte',
    'Eine funktionale Karte heißt C^k-differenzierbar, wenn sämtliche Kartenübergänge zu überlappenden funktionalen Karten k-mal stetig differenzierbar sind.',
    '\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    '\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    'original',
    NULL,
    'Def. 3.4.34 und Lemma 3.4.16 gelten.',
    'Für k=\\infty wird von glatten funktionalen Karten gesprochen.',
    'checked',
    @revision_id
WHERE @def_3436_id IS NULL;

SET @def_3436_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.36'
    LIMIT 1
);

/* 6. Def. 3.4.37 – Differenzierbarer funktionaler Atlas. */
UPDATE `definitions`
SET
    `section_id` = @section_id,
    `title` = 'Differenzierbarer funktionaler Atlas',
    `definition_text` = 'Ein funktionaler Atlas heißt C^k-differenzierbar, wenn alle Kartenübergänge seiner überlappenden Karten k-mal stetig differenzierbar sind.',
    `formal_latex` = '\\forall i,j:\\;\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    `word_latex` = '\\forall i,j:\\;\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.34, Def. 3.4.36 und Satz 3.4.18 gelten.',
    `notes` = 'Der Atlas definiert die differenzierbare Struktur der funktionalen Mannigfaltigkeit.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `definition_id` = @def_3437_id;

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
    'Def. 3.4.37',
    @section_id,
    'Differenzierbarer funktionaler Atlas',
    'Ein funktionaler Atlas heißt C^k-differenzierbar, wenn alle Kartenübergänge seiner überlappenden Karten k-mal stetig differenzierbar sind.',
    '\\forall i,j:\\;\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    '\\forall i,j:\\;\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    'original',
    NULL,
    'Def. 3.4.34, Def. 3.4.36 und Satz 3.4.18 gelten.',
    'Der Atlas definiert die differenzierbare Struktur der funktionalen Mannigfaltigkeit.',
    'checked',
    @revision_id
WHERE @def_3437_id IS NULL;

SET @def_3437_id := (
    SELECT `definition_id`
    FROM `definitions`
    WHERE `definition_number` = 'Def. 3.4.37'
    LIMIT 1
);

/* 7. Lemma 3.4.17 – Eindeutigkeit der differenzierbaren Struktur. */
UPDATE `lemmas`
SET
    `section_id` = @section_id,
    `title` = 'Eindeutigkeit der differenzierbaren Struktur',
    `statement_text` = 'Sind zwei funktionale Atlanten miteinander C^k-kompatibel, dann erzeugt ihre Vereinigung einen C^k-differenzierbaren Atlas und beide bestimmen dieselbe maximale differenzierbare Struktur.',
    `statement_latex` = '\\mathcal{A}_{F,1}\\sim_{C^k}\\mathcal{A}_{F,2}\\Longrightarrow\\langle\\mathcal{A}_{F,1}\\rangle_{\\max}=\\langle\\mathcal{A}_{F,2}\\rangle_{\\max}',
    `word_latex` = '\\mathcal{A}_{F,1}\\sim_{C^k}\\mathcal{A}_{F,2}\\Longrightarrow\\langle\\mathcal{A}_{F,1}\\rangle_{\\max}=\\langle\\mathcal{A}_{F,2}\\rangle_{\\max}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.37 gilt; alle gemischten Kartenübergänge sind C^k.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `lemma_id` = @lemma_3417_id;

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
    'Lemma 3.4.17',
    @section_id,
    'Eindeutigkeit der differenzierbaren Struktur',
    'Sind zwei funktionale Atlanten miteinander C^k-kompatibel, dann erzeugt ihre Vereinigung einen C^k-differenzierbaren Atlas und beide bestimmen dieselbe maximale differenzierbare Struktur.',
    '\\mathcal{A}_{F,1}\\sim_{C^k}\\mathcal{A}_{F,2}\\Longrightarrow\\langle\\mathcal{A}_{F,1}\\rangle_{\\max}=\\langle\\mathcal{A}_{F,2}\\rangle_{\\max}',
    '\\mathcal{A}_{F,1}\\sim_{C^k}\\mathcal{A}_{F,2}\\Longrightarrow\\langle\\mathcal{A}_{F,1}\\rangle_{\\max}=\\langle\\mathcal{A}_{F,2}\\rangle_{\\max}',
    'original',
    NULL,
    'Def. 3.4.37 gilt; alle gemischten Kartenübergänge sind C^k.',
    'checked',
    @revision_id
WHERE @lemma_3417_id IS NULL;

SET @lemma_3417_id := (
    SELECT `lemma_id`
    FROM `lemmas`
    WHERE `lemma_number` = 'Lemma 3.4.17'
    LIMIT 1
);

/* 8. Satz 3.4.19 – Differenzierbare funktionale Mannigfaltigkeit. */
UPDATE `theorems`
SET
    `section_id` = @section_id,
    `title` = 'Differenzierbare funktionale Mannigfaltigkeit',
    `statement_text` = 'Besitzt eine funktionale Mannigfaltigkeit einen C^k-differenzierbaren funktionalen Atlas, dann ist sie eine C^k-differenzierbare funktionale Mannigfaltigkeit.',
    `statement_latex` = '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right),\\qquad\\mathcal{A}_F\\text{ ist }C^k\\text{-differenzierbar}',
    `word_latex` = '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right),\\qquad\\mathcal{A}_F\\text{ ist }C^k\\text{-differenzierbar}',
    `provenance` = 'original',
    `source_id` = NULL,
    `assumptions` = 'Def. 3.4.35 bis Def. 3.4.37 und Lemma 3.4.17 gelten.',
    `validation_status` = 'checked',
    `created_revision_id` = @revision_id
WHERE `theorem_id` = @theorem_3419_id;

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
    'Satz 3.4.19',
    @section_id,
    'Differenzierbare funktionale Mannigfaltigkeit',
    'Besitzt eine funktionale Mannigfaltigkeit einen C^k-differenzierbaren funktionalen Atlas, dann ist sie eine C^k-differenzierbare funktionale Mannigfaltigkeit.',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right),\\qquad\\mathcal{A}_F\\text{ ist }C^k\\text{-differenzierbar}',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right),\\qquad\\mathcal{A}_F\\text{ ist }C^k\\text{-differenzierbar}',
    'original',
    NULL,
    'Def. 3.4.35 bis Def. 3.4.37 und Lemma 3.4.17 gelten.',
    'checked',
    @revision_id
WHERE @theorem_3419_id IS NULL;

SET @theorem_3419_id := (
    SELECT `theorem_id`
    FROM `theorems`
    WHERE `theorem_number` = 'Satz 3.4.19'
    LIMIT 1
);

/* 9. Alte Gleichungen und abhängige Registereinträge entfernen. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='equation' AND `object_id_from` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.148','3.149','3.150')
    ))
    OR
    (`object_type_to`='equation' AND `object_id_to` IN (
        SELECT `equation_id`
        FROM `equations`
        WHERE `equation_number` IN ('3.148','3.149','3.150')
    ));

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`equation_id`
WHERE e.`equation_number` IN ('3.148','3.149','3.150');

DELETE ed
FROM `equation_dependencies` ed
INNER JOIN `equations` e
    ON e.`equation_id` = ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.148','3.149','3.150');

DELETE es
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.148','3.149','3.150');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.148','3.149','3.150');

/* 10. Gleichungen neu anlegen. */
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
    '3.148',
    @section_id,
    'Differenzierbarer Kartenübergang',
    '\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    '\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    'Der Kartenübergang zwischen zwei überlappenden funktionalen Karten ist k-mal stetig differenzierbar.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.36.',
    'Die Karten überlappen und sind homöomorph.',
    'checked',
    @revision_id
),
(
    '3.149',
    @section_id,
    'Differenzierbarer funktionaler Atlas',
    '\\forall i,j:\\;\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    '\\forall i,j:\\;\\varphi_j\\circ\\varphi_i^{-1}\\in C^k',
    'Alle Kartenübergänge des funktionalen Atlas sind k-mal stetig differenzierbar.',
    'definition',
    'original',
    NULL,
    'Formale Darstellung von Def. 3.4.37.',
    'Die Karten bilden einen funktionalen Atlas.',
    'checked',
    @revision_id
),
(
    '3.150',
    @section_id,
    'Differenzierbare funktionale Mannigfaltigkeit',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right),\\qquad\\mathcal{A}_F\\text{ ist }C^k\\text{-differenzierbar}',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right),\\qquad\\mathcal{A}_F\\text{ ist }C^k\\text{-differenzierbar}',
    'Eine funktionale Mannigfaltigkeit mit C^k-differenzierbarem Atlas ist eine differenzierbare funktionale Mannigfaltigkeit.',
    'theorem',
    'original',
    NULL,
    'Formale Darstellung von Satz 3.4.19.',
    'Def. 3.4.35 bis Def. 3.4.37 gelten.',
    'checked',
    @revision_id
);

SET @eq_3148 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` = '3.148'
    LIMIT 1
);

SET @eq_3149 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` = '3.149'
    LIMIT 1
);

SET @eq_3150 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` = '3.150'
    LIMIT 1
);

SET @eq_3145 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` = '3.145'
    LIMIT 1
);

SET @eq_3146 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` = '3.146'
    LIMIT 1
);

SET @eq_3147 := (
    SELECT `equation_id`
    FROM `equations`
    WHERE `equation_number` = '3.147'
    LIMIT 1
);

/* 11. Symbolregister. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3148,@eq_3149,@eq_3150);

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
(@eq_3148,'C^k','Differenzierbarkeitsklasse','Klasse k-mal stetig differenzierbarer Abbildungen.',NULL,'Funktionsklasse',1),
(@eq_3148,'\\varphi_j\\circ\\varphi_i^{-1}','Kartenübergang','Übergangsabbildung zwischen zwei funktionalen Karten.',NULL,'Abbildung',2),
(@eq_3149,'\\mathcal{A}_F','funktionaler Atlas','Familie funktionaler Karten mit kompatiblen Kartenübergängen.',NULL,'Atlas',1),
(@eq_3149,'i,j','Kartenindizes','Indizes zweier Karten des funktionalen Atlas.',NULL,'Indexmenge',2),
(@eq_3150,'\\mathcal{M}_F','differenzierbare funktionale Mannigfaltigkeit','Funktionale Mannigfaltigkeit mit differenzierbarem Atlas.',NULL,'Mannigfaltigkeit',1),
(@eq_3150,'\\mathfrak{Q}_F','funktionale Quotientenstruktur','Grundmenge der funktionalen Mannigfaltigkeit.',NULL,'Quotientenmenge',2)
ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 12. Objektabhängigkeiten. */
DELETE FROM `object_dependencies`
WHERE
    (`object_type_from`='definition' AND `object_id_from` IN (@def_3436_id,@def_3437_id))
    OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3417_id)
    OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3419_id)
    OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3148,@eq_3149,@eq_3150));

INSERT INTO `object_dependencies` (
    `object_type_from`,
    `object_id_from`,
    `object_type_to`,
    `object_id_to`,
    `dependency_type`,
    `note`
)
VALUES
('definition',@def_3436_id,'definition',@def_3434_id,'depends_on','Die differenzierbare Karte setzt die funktionale Karte voraus.'),
('definition',@def_3437_id,'definition',@def_3436_id,'depends_on','Der differenzierbare Atlas wird über differenzierbare Kartenübergänge definiert.'),
('definition',@def_3437_id,'definition',@def_3435_id,'depends_on','Der Atlas gehört zur funktionalen Mannigfaltigkeit.'),
('lemma',@lemma_3417_id,'definition',@def_3437_id,'depends_on','Die maximale differenzierbare Struktur wird durch kompatible Atlanten bestimmt.'),
('theorem',@theorem_3419_id,'definition',@def_3435_id,'depends_on','Der Satz setzt eine funktionale Mannigfaltigkeit voraus.'),
('theorem',@theorem_3419_id,'definition',@def_3437_id,'depends_on','Der Satz setzt einen differenzierbaren funktionalen Atlas voraus.'),
('theorem',@theorem_3419_id,'lemma',@lemma_3417_id,'depends_on','Die differenzierbare Struktur ist atlasunabhängig wohldefiniert.'),
('equation',@eq_3148,'definition',@def_3436_id,'derives_from','Gleichung (3.148) formalisiert Def. 3.4.36.'),
('equation',@eq_3149,'definition',@def_3437_id,'derives_from','Gleichung (3.149) formalisiert Def. 3.4.37.'),
('equation',@eq_3150,'theorem',@theorem_3419_id,'derives_from','Gleichung (3.150) formalisiert Satz 3.4.19.');

/* 13. Gleichungsabhängigkeiten. */
DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3148,@eq_3149,@eq_3150);

INSERT INTO `equation_dependencies` (
    `equation_id`,
    `depends_on_equation_id`,
    `dependency_type`,
    `dependency_note`
)
VALUES
(@eq_3148,@eq_3145,'depends_on','Die Differenzierbarkeit wird auf dem Kartenübergang aus Gleichung (3.145) formuliert.'),
(@eq_3149,@eq_3148,'derives_from','Ein differenzierbarer Atlas verlangt differenzierbare Kartenübergänge.'),
(@eq_3149,@eq_3146,'depends_on','Der zugrunde liegende funktionale Atlas ist in Gleichung (3.146) definiert.'),
(@eq_3150,@eq_3147,'depends_on','Die differenzierbare Mannigfaltigkeit baut auf der funktionalen Mannigfaltigkeit auf.'),
(@eq_3150,@eq_3149,'derives_from','Die Differenzierbarkeit der Mannigfaltigkeit folgt aus dem differenzierbaren Atlas.');

/* 14. Änderungsprotokoll. */
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
    @revision_id,@section_id,'rewritten','section','3.4.19',
    'Abschnitt 3.4.19 wurde vollständig als Rekonstruktion differenzierbarer funktionaler Mannigfaltigkeiten neu gefasst.',
    'Bisheriger Repository-Stand von Abschnitt 3.4.19.',
    'Def. 3.4.36, Def. 3.4.37, Lemma 3.4.17, Satz 3.4.19 und Gleichungen (3.148) bis (3.150).'
),
(
    @revision_id,@section_id,'definition_added','definition','Def. 3.4.36–Def. 3.4.37',
    'Differenzierbare funktionale Karte und differenzierbarer funktionaler Atlas wurden registriert.',
    NULL,
    '2 Definitionen'
),
(
    @revision_id,@section_id,'statement_added','lemma','Lemma 3.4.17',
    'Die Eindeutigkeit der differenzierbaren Struktur wurde registriert.',
    NULL,
    'Maximale differenzierbare Struktur'
),
(
    @revision_id,@section_id,'statement_added','theorem','Satz 3.4.19',
    'Die differenzierbare funktionale Mannigfaltigkeit wurde registriert.',
    NULL,
    'Funktionale Mannigfaltigkeit mit C^k-Atlas'
),
(
    @revision_id,@section_id,'equation_added','equation','(3.148)–(3.150)',
    'Differenzierbarer Kartenübergang, differenzierbarer Atlas und differenzierbare funktionale Mannigfaltigkeit wurden formal registriert.',
    NULL,
    '3 Gleichungen'
);

/* 15. Repository-Zähler. */
INSERT INTO `repository_counters` (
    `counter_key`,
    `counter_value`
)
VALUES
('next_equation_number','3.151'),
('next_definition_number','Def. 3.4.38'),
('next_lemma_number','Lemma 3.4.18'),
('next_theorem_number','Satz 3.4.20'),
('last_edited_section','3.4.19'),
('last_repository_revision','RKB-2026-07-13-K3.4.19-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* ============================================================
   KONTROLLABFRAGEN
   ============================================================ */

SELECT
    ds.`section_code`,
    ds.`title`,
    ds.`status`,
    ds.`is_original_contribution`
FROM `dissertation_sections` ds
WHERE ds.`section_code` IN ('3.4','3.4.19')
ORDER BY ds.`section_code`;

SELECT
    d.`definition_number`,
    d.`title`,
    d.`formal_latex`,
    d.`validation_status`
FROM `definitions` d
WHERE d.`definition_number` IN ('Def. 3.4.36','Def. 3.4.37')
ORDER BY d.`definition_number`;

SELECT
    l.`lemma_number`,
    l.`title`,
    l.`statement_latex`,
    l.`validation_status`
FROM `lemmas` l
WHERE l.`lemma_number` = 'Lemma 3.4.17';

SELECT
    t.`theorem_number`,
    t.`title`,
    t.`statement_latex`,
    t.`validation_status`
FROM `theorems` t
WHERE t.`theorem_number` = 'Satz 3.4.19';

SELECT
    e.`equation_number`,
    e.`title`,
    e.`equation_latex`,
    e.`word_latex`,
    e.`validation_status`
FROM `equations` e
WHERE e.`equation_number` IN ('3.148','3.149','3.150')
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
WHERE e.`equation_number` IN ('3.148','3.149','3.150')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`,'.',-1) AS UNSIGNED),
    es.`symbol_order`;

SELECT COUNT(*) AS `source_usages_in_3_4_19`
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
