USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* ============================================================
   Abschnitt 3.4.18
   Funktionale Mannigfaltigkeiten und lokale Koordinaten

   Definitionen:
   - Def. 3.4.34 Funktionale Karte
   - Def. 3.4.35 Funktionale Mannigfaltigkeit

   Lemma:
   - Lemma 3.4.16 Kompatibilität funktionaler Karten

   Satz:
   - Satz 3.4.18 Existenz eines funktionalen Atlas

   Gleichungen:
   - (3.143) Funktionale Karte
   - (3.144) Lokale funktionale Koordinaten
   - (3.145) Kartenübergang
   - (3.146) Funktionaler Atlas
   - (3.147) Funktionale Mannigfaltigkeit

   Neue Quellen: keine

   Nächste Gleichung:   (3.148)
   Nächste Definition:  Def. 3.4.36
   Nächstes Lemma:      Lemma 3.4.17
   Nächster Satz:       Satz 3.4.19
   ============================================================ */

SET @parent_revision_id := (
    SELECT MAX(r.`revision_id`) FROM `repository_revisions` r
);

INSERT INTO `repository_revisions` (
    `revision_code`,`revision_date`,`scope_type`,`scope_reference`,
    `version_label`,`summary`,`created_by`,`parent_revision_id`
)
VALUES (
    'RKB-2026-07-13-K3.4.18-NEUFASSUNG-V1',
    NOW(),'section','3.4.18','1.0',
    'Neufassung von Abschnitt 3.4.18 mit Def. 3.4.34, Def. 3.4.35, Lemma 3.4.16, Satz 3.4.18 und den Gleichungen (3.143) bis (3.147).',
    'Olaf Thiele / ChatGPT',@parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id`=LAST_INSERT_ID(`revision_id`),
    `revision_date`=VALUES(`revision_date`),
    `version_label`=VALUES(`version_label`),
    `summary`=VALUES(`summary`),
    `created_by`=VALUES(`created_by`);

SET @revision_id := LAST_INSERT_ID();

SET @chapter_id := (
    SELECT `section_id` FROM `dissertation_sections`
    WHERE `section_code`='3.4' LIMIT 1
);

INSERT INTO `dissertation_sections` (
    `parent_section_id`,`section_code`,`title`,`chapter_no`,
    `section_order`,`status`,`is_original_contribution`,`notes`
)
SELECT
    @chapter_id,'3.4.18',
    'Funktionale Mannigfaltigkeiten und lokale Koordinaten',
    3,3.5990,'review',1,
    'Rekonstruktion lokaler Karten, kompatibler Kartenübergänge und funktionaler Mannigfaltigkeiten.'
WHERE @chapter_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM `dissertation_sections`
      WHERE `section_code`='3.4.18'
  );

SET @section_id := (
    SELECT `section_id` FROM `dissertation_sections`
    WHERE `section_code`='3.4.18' LIMIT 1
);

UPDATE `dissertation_sections`
SET
    `parent_section_id`=@chapter_id,
    `title`='Funktionale Mannigfaltigkeiten und lokale Koordinaten',
    `chapter_no`=3,
    `section_order`=3.5990,
    `status`='review',
    `is_original_contribution`=1,
    `notes`='Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.34, Def. 3.4.35, Lemma 3.4.16, Satz 3.4.18 und die Gleichungen (3.143) bis (3.147).'
WHERE `section_id`=@section_id;

DELETE FROM `source_usage`
WHERE `section_id`=@section_id;

SET @def_3429_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.29' LIMIT 1
);
SET @def_3434_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.34' LIMIT 1
);
SET @def_3435_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.35' LIMIT 1
);
SET @lemma_3416_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.16' LIMIT 1
);
SET @theorem_3418_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.18' LIMIT 1
);

/* Def. 3.4.34 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Karte',
    `definition_text`='Eine funktionale Karte ist ein Homöomorphismus von einer offenen Teilmenge der funktionalen Quotientenstruktur auf eine offene Teilmenge des euklidischen Raumes.',
    `formal_latex`='\\varphi:U\\subseteq\\mathfrak{Q}_F\\rightarrow V\\subseteq\\mathbb{R}^n',
    `word_latex`='\\varphi:U\\subseteq\\mathfrak{Q}_F\\rightarrow V\\subseteq\\mathbb{R}^n',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.29 und Satz 3.4.15 gelten; U und V sind offen.',
    `notes`='Die Karte stellt funktionale Organisationsklassen lokal durch reelle Koordinaten dar.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3434_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.34',@section_id,'Funktionale Karte',
    'Eine funktionale Karte ist ein Homöomorphismus von einer offenen Teilmenge der funktionalen Quotientenstruktur auf eine offene Teilmenge des euklidischen Raumes.',
    '\\varphi:U\\subseteq\\mathfrak{Q}_F\\rightarrow V\\subseteq\\mathbb{R}^n',
    '\\varphi:U\\subseteq\\mathfrak{Q}_F\\rightarrow V\\subseteq\\mathbb{R}^n',
    'original',NULL,
    'Def. 3.4.29 und Satz 3.4.15 gelten; U und V sind offen.',
    'Die Karte stellt funktionale Organisationsklassen lokal durch reelle Koordinaten dar.',
    'checked',@revision_id
WHERE @def_3434_id IS NULL;

SET @def_3434_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.34' LIMIT 1
);

/* Def. 3.4.35 */
UPDATE `definitions`
SET
    `section_id`=@section_id,
    `title`='Funktionale Mannigfaltigkeit',
    `definition_text`='Eine funktionale Mannigfaltigkeit ist eine hausdorffsche, zweitabzählbare topologische Struktur, die lokal durch funktionale Karten mit offenen Teilmengen des euklidischen Raumes homöomorph ist.',
    `formal_latex`='\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right)',
    `word_latex`='\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.34 gilt; die Karten des Atlas sind paarweise kompatibel.',
    `notes`='Die Mannigfaltigkeitsstruktur ist lokal euklidisch, aber funktional aus der Quotientenstruktur rekonstruiert.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `definition_id`=@def_3435_id;

INSERT INTO `definitions` (
    `definition_number`,`section_id`,`title`,`definition_text`,
    `formal_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`notes`,`validation_status`,`created_revision_id`
)
SELECT
    'Def. 3.4.35',@section_id,'Funktionale Mannigfaltigkeit',
    'Eine funktionale Mannigfaltigkeit ist eine hausdorffsche, zweitabzählbare topologische Struktur, die lokal durch funktionale Karten mit offenen Teilmengen des euklidischen Raumes homöomorph ist.',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right)',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right)',
    'original',NULL,
    'Def. 3.4.34 gilt; die Karten des Atlas sind paarweise kompatibel.',
    'Die Mannigfaltigkeitsstruktur ist lokal euklidisch, aber funktional aus der Quotientenstruktur rekonstruiert.',
    'checked',@revision_id
WHERE @def_3435_id IS NULL;

SET @def_3435_id := (
    SELECT `definition_id` FROM `definitions`
    WHERE `definition_number`='Def. 3.4.35' LIMIT 1
);

/* Lemma 3.4.16 */
UPDATE `lemmas`
SET
    `section_id`=@section_id,
    `title`='Kompatibilität funktionaler Karten',
    `statement_text`='Überlappen sich zwei funktionale Karten, dann ist ihr Kartenübergang auf dem Überlappungsbereich ein Homöomorphismus.',
    `statement_latex`='\\varphi_j\\circ\\varphi_i^{-1}:\\varphi_i(U_i\\cap U_j)\\rightarrow\\varphi_j(U_i\\cap U_j)',
    `word_latex`='\\varphi_j\\circ\\varphi_i^{-1}:\\varphi_i(U_i\\cap U_j)\\rightarrow\\varphi_j(U_i\\cap U_j)',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.34 gilt; U_i und U_j überlappen.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `lemma_id`=@lemma_3416_id;

INSERT INTO `lemmas` (
    `lemma_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Lemma 3.4.16',@section_id,'Kompatibilität funktionaler Karten',
    'Überlappen sich zwei funktionale Karten, dann ist ihr Kartenübergang auf dem Überlappungsbereich ein Homöomorphismus.',
    '\\varphi_j\\circ\\varphi_i^{-1}:\\varphi_i(U_i\\cap U_j)\\rightarrow\\varphi_j(U_i\\cap U_j)',
    '\\varphi_j\\circ\\varphi_i^{-1}:\\varphi_i(U_i\\cap U_j)\\rightarrow\\varphi_j(U_i\\cap U_j)',
    'original',NULL,
    'Def. 3.4.34 gilt; U_i und U_j überlappen.',
    'checked',@revision_id
WHERE @lemma_3416_id IS NULL;

SET @lemma_3416_id := (
    SELECT `lemma_id` FROM `lemmas`
    WHERE `lemma_number`='Lemma 3.4.16' LIMIT 1
);

/* Satz 3.4.18 */
UPDATE `theorems`
SET
    `section_id`=@section_id,
    `title`='Existenz eines funktionalen Atlas',
    `statement_text`='Überdeckt eine Familie paarweise kompatibler funktionaler Karten die funktionale Quotientenstruktur, dann bildet diese Familie einen funktionalen Atlas und definiert eine funktionale Mannigfaltigkeit.',
    `statement_latex`='\\mathcal{A}_F=\\left\\{(U_i,\\varphi_i)\\right\\}_{i\\in I},\\qquad\\bigcup_{i\\in I}U_i=\\mathfrak{Q}_F',
    `word_latex`='\\mathcal{A}_F=\\left\\{(U_i,\\varphi_i)\\right\\}_{i\\in I},\\qquad\\bigcup_{i\\in I}U_i=\\mathfrak{Q}_F',
    `provenance`='original',
    `source_id`=NULL,
    `assumptions`='Def. 3.4.34, Def. 3.4.35 und Lemma 3.4.16 gelten.',
    `validation_status`='checked',
    `created_revision_id`=@revision_id
WHERE `theorem_id`=@theorem_3418_id;

INSERT INTO `theorems` (
    `theorem_number`,`section_id`,`title`,`statement_text`,
    `statement_latex`,`word_latex`,`provenance`,`source_id`,
    `assumptions`,`validation_status`,`created_revision_id`
)
SELECT
    'Satz 3.4.18',@section_id,'Existenz eines funktionalen Atlas',
    'Überdeckt eine Familie paarweise kompatibler funktionaler Karten die funktionale Quotientenstruktur, dann bildet diese Familie einen funktionalen Atlas und definiert eine funktionale Mannigfaltigkeit.',
    '\\mathcal{A}_F=\\left\\{(U_i,\\varphi_i)\\right\\}_{i\\in I},\\qquad\\bigcup_{i\\in I}U_i=\\mathfrak{Q}_F',
    '\\mathcal{A}_F=\\left\\{(U_i,\\varphi_i)\\right\\}_{i\\in I},\\qquad\\bigcup_{i\\in I}U_i=\\mathfrak{Q}_F',
    'original',NULL,
    'Def. 3.4.34, Def. 3.4.35 und Lemma 3.4.16 gelten.',
    'checked',@revision_id
WHERE @theorem_3418_id IS NULL;

SET @theorem_3418_id := (
    SELECT `theorem_id` FROM `theorems`
    WHERE `theorem_number`='Satz 3.4.18' LIMIT 1
);

/* Alte Gleichungen bereinigen. */
DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='equation' AND `object_id_from` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.143','3.144','3.145','3.146','3.147')
 ))
 OR
 (`object_type_to`='equation' AND `object_id_to` IN (
    SELECT `equation_id` FROM `equations`
    WHERE `equation_number` IN ('3.143','3.144','3.145','3.146','3.147')
 ));

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`equation_id`
WHERE e.`equation_number` IN ('3.143','3.144','3.145','3.146','3.147');

DELETE ed FROM `equation_dependencies` ed
JOIN `equations` e ON e.`equation_id`=ed.`depends_on_equation_id`
WHERE e.`equation_number` IN ('3.143','3.144','3.145','3.146','3.147');

DELETE es FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`equation_number` IN ('3.143','3.144','3.145','3.146','3.147');

DELETE FROM `equations`
WHERE `equation_number` IN ('3.143','3.144','3.145','3.146','3.147');

INSERT INTO `equations` (
    `equation_number`,`section_id`,`title`,`equation_latex`,
    `word_latex`,`plain_description`,`equation_type`,
    `provenance`,`source_id`,`derivation`,`assumptions`,
    `validation_status`,`created_revision_id`
)
VALUES
(
    '3.143',@section_id,'Funktionale Karte',
    '\\varphi:U\\subseteq\\mathfrak{Q}_F\\rightarrow V\\subseteq\\mathbb{R}^n',
    '\\varphi:U\\subseteq\\mathfrak{Q}_F\\rightarrow V\\subseteq\\mathbb{R}^n',
    'Eine funktionale Karte bildet eine offene Teilmenge der Quotientenstruktur homöomorph auf eine offene Teilmenge des euklidischen Raumes ab.',
    'definition','original',NULL,'Formale Darstellung von Def. 3.4.34.',
    'U und V sind offen.','checked',@revision_id
),
(
    '3.144',@section_id,'Lokale funktionale Koordinaten',
    '\\varphi(A)=\\left(x^1(A),\\ldots,x^n(A)\\right)',
    '\\varphi(A)=\\left(x^1(A),\\ldots,x^n(A)\\right)',
    'Die Karte ordnet jeder funktionalen Organisationsklasse lokale reelle Koordinaten zu.',
    'definition','original',NULL,'Koordinatendarstellung innerhalb einer funktionalen Karte.',
    'A\\in U.','checked',@revision_id
),
(
    '3.145',@section_id,'Kartenübergang',
    '\\varphi_j\\circ\\varphi_i^{-1}:\\varphi_i(U_i\\cap U_j)\\rightarrow\\varphi_j(U_i\\cap U_j)',
    '\\varphi_j\\circ\\varphi_i^{-1}:\\varphi_i(U_i\\cap U_j)\\rightarrow\\varphi_j(U_i\\cap U_j)',
    'Der Kartenübergang verbindet lokale Koordinatendarstellungen auf überlappenden Karten.',
    'lemma','original',NULL,'Formale Darstellung von Lemma 3.4.16.',
    'U_i\\cap U_j\\neq\\varnothing.','checked',@revision_id
),
(
    '3.146',@section_id,'Funktionaler Atlas',
    '\\mathcal{A}_F=\\left\\{(U_i,\\varphi_i)\\right\\}_{i\\in I},\\qquad\\bigcup_{i\\in I}U_i=\\mathfrak{Q}_F',
    '\\mathcal{A}_F=\\left\\{(U_i,\\varphi_i)\\right\\}_{i\\in I},\\qquad\\bigcup_{i\\in I}U_i=\\mathfrak{Q}_F',
    'Ein funktionaler Atlas ist eine überdeckende Familie kompatibler funktionaler Karten.',
    'theorem','original',NULL,'Formale Darstellung von Satz 3.4.18.',
    'Die Karten sind paarweise kompatibel.','checked',@revision_id
),
(
    '3.147',@section_id,'Funktionale Mannigfaltigkeit',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right)',
    '\\mathcal{M}_F=\\left(\\mathfrak{Q}_F,\\mathcal{A}_F\\right)',
    'Die funktionale Quotientenstruktur bildet zusammen mit einem kompatiblen Atlas eine funktionale Mannigfaltigkeit.',
    'theorem','original',NULL,'Formale Kurzbezeichnung der funktionalen Mannigfaltigkeit.',
    'Def. 3.4.35 gilt.','checked',@revision_id
);

SET @eq_3143 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.143' LIMIT 1);
SET @eq_3144 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.144' LIMIT 1);
SET @eq_3145 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.145' LIMIT 1);
SET @eq_3146 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.146' LIMIT 1);
SET @eq_3147 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.147' LIMIT 1);
SET @eq_3133 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.133' LIMIT 1);
SET @eq_3142 := (SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.142' LIMIT 1);

DELETE FROM `equation_symbols`
WHERE `equation_id` IN (@eq_3143,@eq_3144,@eq_3145,@eq_3146,@eq_3147);

INSERT INTO `equation_symbols` (
    `equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,
    `unit_text`,`domain_text`,`symbol_order`
)
VALUES
(@eq_3143,'\\varphi','funktionale Karte','Homöomorphismus zwischen funktionalem und euklidischem lokalem Raum.',NULL,'Abbildung',1),
(@eq_3143,'U','funktionales Kartengebiet','Offene Teilmenge der funktionalen Quotientenstruktur.',NULL,'U\\subseteq\\mathfrak{Q}_F',2),
(@eq_3143,'V','Koordinatengebiet','Offene Teilmenge des euklidischen Raumes.',NULL,'V\\subseteq\\mathbb{R}^n',3),
(@eq_3144,'x^k','lokale funktionale Koordinate','k-te reelle Koordinate einer funktionalen Organisationsklasse.',NULL,'\\mathbb{R}',1),
(@eq_3145,'\\varphi_j\\circ\\varphi_i^{-1}','Kartenübergang','Übergangsabbildung zwischen zwei lokalen Koordinatensystemen.',NULL,'Homöomorphismus',1),
(@eq_3146,'\\mathcal{A}_F','funktionaler Atlas','Überdeckende Familie kompatibler funktionaler Karten.',NULL,'Kartenfamilie',1),
(@eq_3147,'\\mathcal{M}_F','funktionale Mannigfaltigkeit','Funktionale Quotientenstruktur mit kompatiblem Atlas.',NULL,'Mannigfaltigkeit',1)
ON DUPLICATE KEY UPDATE
    `symbol_name`=VALUES(`symbol_name`),
    `definition_text`=VALUES(`definition_text`),
    `unit_text`=VALUES(`unit_text`),
    `domain_text`=VALUES(`domain_text`),
    `symbol_order`=VALUES(`symbol_order`);

DELETE FROM `object_dependencies`
WHERE
 (`object_type_from`='definition' AND `object_id_from` IN (@def_3434_id,@def_3435_id))
 OR (`object_type_from`='lemma' AND `object_id_from`=@lemma_3416_id)
 OR (`object_type_from`='theorem' AND `object_id_from`=@theorem_3418_id)
 OR (`object_type_from`='equation' AND `object_id_from` IN (@eq_3143,@eq_3144,@eq_3145,@eq_3146,@eq_3147));

INSERT INTO `object_dependencies` (
    `object_type_from`,`object_id_from`,`object_type_to`,
    `object_id_to`,`dependency_type`,`note`
)
VALUES
('definition',@def_3434_id,'definition',@def_3429_id,'depends_on','Funktionale Karten werden auf offenen Teilmengen der funktionalen Topologie definiert.'),
('definition',@def_3435_id,'definition',@def_3434_id,'depends_on','Die funktionale Mannigfaltigkeit setzt funktionale Karten voraus.'),
('lemma',@lemma_3416_id,'definition',@def_3434_id,'depends_on','Das Kompatibilitätslemma verwendet überlappende funktionale Karten.'),
('theorem',@theorem_3418_id,'definition',@def_3435_id,'depends_on','Der funktionale Atlas definiert die Mannigfaltigkeitsstruktur.'),
('theorem',@theorem_3418_id,'lemma',@lemma_3416_id,'depends_on','Die Karten des Atlas müssen kompatibel sein.'),
('equation',@eq_3143,'definition',@def_3434_id,'derives_from','Gleichung (3.143) formalisiert Def. 3.4.34.'),
('equation',@eq_3145,'lemma',@lemma_3416_id,'derives_from','Gleichung (3.145) formalisiert Lemma 3.4.16.'),
('equation',@eq_3146,'theorem',@theorem_3418_id,'derives_from','Gleichung (3.146) formalisiert Satz 3.4.18.'),
('equation',@eq_3147,'definition',@def_3435_id,'derives_from','Gleichung (3.147) formalisiert Def. 3.4.35.');

DELETE FROM `equation_dependencies`
WHERE `equation_id` IN (@eq_3143,@eq_3144,@eq_3145,@eq_3146,@eq_3147);

INSERT INTO `equation_dependencies` (
    `equation_id`,`depends_on_equation_id`,
    `dependency_type`,`dependency_note`
)
VALUES
(@eq_3143,@eq_3133,'depends_on','Die funktionale Karte wird auf offenen Mengen der funktionalen Topologie definiert.'),
(@eq_3144,@eq_3143,'derives_from','Die lokalen Koordinaten ergeben sich aus der funktionalen Karte.'),
(@eq_3145,@eq_3143,'depends_on','Der Kartenübergang setzt zwei funktionale Karten voraus.'),
(@eq_3146,@eq_3143,'depends_on','Der Atlas besteht aus funktionalen Karten.'),
(@eq_3146,@eq_3145,'depends_on','Die Atlasstruktur setzt kompatible Kartenübergänge voraus.'),
(@eq_3147,@eq_3146,'derives_from','Die funktionale Mannigfaltigkeit wird durch den funktionalen Atlas bestimmt.'),
(@eq_3147,@eq_3142,'depends_on','Die vorherige Kompaktheitsstruktur liefert globale Kontrollbedingungen, ist aber keine notwendige Mannigfaltigkeitsvoraussetzung.');

DELETE FROM `section_change_log`
WHERE `revision_id`=@revision_id AND `section_id`=@section_id;

INSERT INTO `section_change_log` (
    `revision_id`,`section_id`,`change_type`,`object_type`,
    `object_reference`,`change_summary`,`previous_value`,`new_value`
)
VALUES
(@revision_id,@section_id,'rewritten','section','3.4.18',
 'Abschnitt 3.4.18 wurde vollständig als Rekonstruktion funktionaler Mannigfaltigkeiten und lokaler Koordinaten neu gefasst.',
 'Bisheriger Repository-Stand von Abschnitt 3.4.18.',
 'Def. 3.4.34, Def. 3.4.35, Lemma 3.4.16, Satz 3.4.18 und Gleichungen (3.143) bis (3.147).'),
(@revision_id,@section_id,'definition_added','definition','Def. 3.4.34–Def. 3.4.35',
 'Funktionale Karte und funktionale Mannigfaltigkeit wurden registriert.',NULL,'2 Definitionen'),
(@revision_id,@section_id,'statement_added','lemma','Lemma 3.4.16',
 'Die Kompatibilität funktionaler Karten wurde registriert.',NULL,'Kompatible Kartenübergänge'),
(@revision_id,@section_id,'statement_added','theorem','Satz 3.4.18',
 'Die Existenz eines funktionalen Atlas wurde registriert.',NULL,'Funktionaler Atlas'),
(@revision_id,@section_id,'equation_added','equation','(3.143)–(3.147)',
 'Funktionale Karte, lokale Koordinaten, Kartenübergang, Atlas und Mannigfaltigkeit wurden formal registriert.',NULL,'5 Gleichungen');

INSERT INTO `repository_counters` (`counter_key`,`counter_value`)
VALUES
('next_equation_number','3.148'),
('next_definition_number','Def. 3.4.36'),
('next_lemma_number','Lemma 3.4.17'),
('next_theorem_number','Satz 3.4.19'),
('last_edited_section','3.4.18'),
('last_repository_revision','RKB-2026-07-13-K3.4.18-NEUFASSUNG-V1')
ON DUPLICATE KEY UPDATE `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Kontrollabfragen */
SELECT `section_code`,`title`,`status`,`is_original_contribution`
FROM `dissertation_sections`
WHERE `section_code` IN ('3.4','3.4.18')
ORDER BY `section_code`;

SELECT `definition_number`,`title`,`formal_latex`,`validation_status`
FROM `definitions`
WHERE `definition_number` IN ('Def. 3.4.34','Def. 3.4.35')
ORDER BY `definition_number`;

SELECT `lemma_number`,`title`,`statement_latex`,`validation_status`
FROM `lemmas`
WHERE `lemma_number`='Lemma 3.4.16';

SELECT `theorem_number`,`title`,`statement_latex`,`validation_status`
FROM `theorems`
WHERE `theorem_number`='Satz 3.4.18';

SELECT `equation_number`,`title`,`equation_latex`,`word_latex`,`validation_status`
FROM `equations`
WHERE `equation_number` IN ('3.143','3.144','3.145','3.146','3.147')
ORDER BY CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED);

SELECT COUNT(*) AS `source_usages_in_3_4_18`
FROM `source_usage`
WHERE `section_id`=@section_id;

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN (
    'next_equation_number','next_definition_number',
    'next_lemma_number','next_theorem_number',
    'last_edited_section','last_repository_revision'
)
ORDER BY `counter_key`;
