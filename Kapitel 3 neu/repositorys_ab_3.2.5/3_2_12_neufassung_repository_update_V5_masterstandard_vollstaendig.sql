USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.2.12 – Masterstandard V5, vollständig und idempotent
   Zusammenfassung der mathematischen Grundlagen und Identifikation der Forschungslücke
   Keine neuen Literaturquellen und keine neuen Gleichungen.
   Wiederverwendung zentraler Quellen aus 3.2.1–3.2.11.
*/

SET @parent_revision_id := (
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `revision_code`='RKB-2026-07-15-K3.2.11-NEUFASSUNG-V5'
    LIMIT 1
);

INSERT INTO `repository_revisions`
(`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`)
VALUES
('RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5',
 NOW(),
 'section',
 '3.2.12',
 '5.0',
 'Zusammenfassung der mathematischen Grundlagen und systematische Identifikation der Forschungslücke als Übergang zur FRZK-Axiomatik.',
 'Olaf Thiele / ChatGPT',
 @parent_revision_id)
ON DUPLICATE KEY UPDATE
 `revision_id`=LAST_INSERT_ID(`revision_id`),
 `revision_date`=VALUES(`revision_date`),
 `summary`=VALUES(`summary`),
 `parent_revision_id`=VALUES(`parent_revision_id`);

SET @revision_id:=LAST_INSERT_ID();

SET @section_id:=(
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code`='3.2.12'
    LIMIT 1
);

UPDATE `dissertation_sections`
SET
 `title`='Zusammenfassung der mathematischen Grundlagen und Identifikation der Forschungslücke',
 `status`='complete',
 `is_original_contribution`=0,
 `notes`='Abschluss von Kapitel 3.2 im Masterstandard V5; keine neuen Gleichungen oder Literaturquellen.',
 `updated_at`=NOW()
WHERE `section_id`=@section_id;

/* Abschnittsartefakte kontrolliert bereinigen. */
DELETE es
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id;

DELETE FROM `equations` WHERE `section_id`=@section_id;
DELETE FROM `definitions` WHERE `section_id`=@section_id;
DELETE FROM `source_usage` WHERE `section_id`=@section_id;
DELETE FROM `symbols` WHERE `first_section_id`=@section_id AND `scope_type`='section';
DELETE FROM `section_change_log` WHERE `section_id`=@section_id AND `revision_id`=@revision_id;

/* Zentrale Bestandsquellen wiederverwenden. */
SET @source_23_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=23 LIMIT 1);
SET @source_24_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=24 LIMIT 1);
SET @source_29_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=29 LIMIT 1);
SET @source_38_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=38 LIMIT 1);
SET @source_40_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=40 LIMIT 1);
SET @source_75_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=75 LIMIT 1);
SET @source_78_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=78 LIMIT 1);
SET @source_79_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=79 LIMIT 1);
SET @source_80_id:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=80 LIMIT 1);

INSERT INTO `source_usage`
(`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`)
VALUES
(@source_23_id,@section_id,'synthesis','Mengenlehre als grundlegende mathematische Sprache, die ihre Objekte voraussetzt.','Zusammenfassung der elementaren Grundlagen',0,1,'Bestehende Quelle [23].',@revision_id),
(@source_24_id,@section_id,'synthesis','Axiomatische Begrenzung zulässiger mengentheoretischer Konstruktionen.','Zusammenfassung der elementaren Grundlagen',0,1,'Bestehende Quelle [24].',@revision_id),
(@source_29_id,@section_id,'synthesis','Funktionen als eindeutige gerichtete Zuordnungen.','Zusammenfassung der Transformationsgrundlagen',0,1,'Bestehende Quelle [29].',@revision_id),
(@source_38_id,@section_id,'synthesis','Zustandsraumdarstellung und Systembeschreibung.','Zusammenfassung dynamischer Systeme',0,1,'Bestehende Quelle [38].',@revision_id),
(@source_40_id,@section_id,'synthesis','Dynamische Systeme, Trajektorien und qualitative Organisationsformen.','Zusammenfassung dynamischer Systeme',0,1,'Bestehende Quelle [40].',@revision_id),
(@source_75_id,@section_id,'synthesis','Probabilistische Quantifizierung von Information und Entropie.','Zusammenfassung der Informationstheorie',0,1,'Bestehende Quelle [75].',@revision_id),
(@source_78_id,@section_id,'synthesis','Graphen als explizit vorgegebene relationale Strukturen.','Zusammenfassung der Graphentheorie',0,1,'Bestehende Quelle [78].',@revision_id),
(@source_79_id,@section_id,'synthesis','Globale Small-World-Organisation aus lokaler Vernetzung.','Zusammenfassung komplexer Netzwerke',0,1,'Bestehende Quelle [79].',@revision_id),
(@source_80_id,@section_id,'synthesis','Emergente Gradverteilungen in wachsenden Netzwerken.','Zusammenfassung komplexer Netzwerke',0,1,'Bestehende Quelle [80].',@revision_id);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES
('Def. 3.2.12.1',@section_id,'Systematische Forschungslücke',
 'Die systematische Forschungslücke bezeichnet das Fehlen eines formalen Systems, das die Entstehung, Veränderung und Stabilisierung funktionaler Relationen sowie die daraus hervorgehende Rekonstruktion von Raum und Zeit erklärt.',
 NULL,NULL,'author_synthesis',NULL,
 'Die etablierten mathematischen Theorien beschreiben bereits definierte Träger, Relationen, Zustandsräume oder Wahrscheinlichkeitsräume.',
 'Zusammenfassende Eigenanalyse des Forschungsstandes ohne neue mathematische Gleichung.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 `section_id`=VALUES(`section_id`),
 `title`=VALUES(`title`),
 `definition_text`=VALUES(`definition_text`),
 `formal_latex`=VALUES(`formal_latex`),
 `word_latex`=VALUES(`word_latex`),
 `provenance`=VALUES(`provenance`),
 `source_id`=VALUES(`source_id`),
 `assumptions`=VALUES(`assumptions`),
 `notes`=VALUES(`notes`),
 `validation_status`='checked',
 `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES
('Def. 3.2.12.2',@section_id,'Anforderung funktionaler Strukturgenese',
 'Ein gesuchtes formales System muss funktionale Relationen nicht nur als gegeben behandeln, sondern Regeln ihrer Entstehung, Veränderung, Stabilisierung und übergeordneten Organisation bereitstellen.',
 NULL,NULL,'author_synthesis',NULL,
 'Raum und Zeit sollen nicht als primitive externe Strukturen vorausgesetzt werden.',
 'Methodische Anforderung für die Axiomatik in Kapitel 3.3.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 `section_id`=VALUES(`section_id`),
 `title`=VALUES(`title`),
 `definition_text`=VALUES(`definition_text`),
 `formal_latex`=VALUES(`formal_latex`),
 `word_latex`=VALUES(`word_latex`),
 `provenance`=VALUES(`provenance`),
 `source_id`=VALUES(`source_id`),
 `assumptions`=VALUES(`assumptions`),
 `notes`=VALUES(`notes`),
 `validation_status`='checked',
 `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`assumptions`,`notes`,`validation_status`,`created_revision_id`)
VALUES
('Def. 3.2.12.3',@section_id,'Axiomatische Anschlussanforderung',
 'Die axiomatische Anschlussanforderung verlangt, dass alle späteren mathematischen Rekonstruktionen aus einer kleinen Menge expliziter und voneinander abgegrenzter Grundannahmen ableitbar sind.',
 NULL,NULL,'author_synthesis',NULL,
 'Kapitel 3.3 formuliert qualitative Grundannahmen; Kapitel 3.4 rekonstruiert daraus mathematische Strukturen.',
 'Übergangsdefinition zwischen Kapitel 3.2 und Kapitel 3.3.',
 'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 `section_id`=VALUES(`section_id`),
 `title`=VALUES(`title`),
 `definition_text`=VALUES(`definition_text`),
 `formal_latex`=VALUES(`formal_latex`),
 `word_latex`=VALUES(`word_latex`),
 `provenance`=VALUES(`provenance`),
 `source_id`=VALUES(`source_id`),
 `assumptions`=VALUES(`assumptions`),
 `notes`=VALUES(`notes`),
 `validation_status`='checked',
 `created_revision_id`=VALUES(`created_revision_id`);

INSERT INTO `section_change_log`
(`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`)
VALUES
(@revision_id,@section_id,'rewritten','section','3.2.12',
 'Abschnitt 3.2.12 vollständig im Masterstandard V5 neu gefasst.',
 NULL,
 'Zusammenfassung der mathematischen Grundlagen, systematische Forschungslücke und Übergang zur Axiomatik.'),
(@revision_id,@section_id,'source_reused','sources','[23],[24],[29],[38],[40],[75],[78]–[80]',
 'Neun zentrale Bestandsquellen synthetisch wiederverwendet.',
 NULL,
 'Keine neue Literaturnummer vergeben.'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.2.12.1–Def. 3.2.12.3',
 'Drei zusammenfassende Definitionen registriert.',
 NULL,
 'Forschungslücke, funktionale Strukturgenese und axiomatische Anschlussanforderung.'),
(@revision_id,@section_id,'validated','chapter','3.2',
 'Kapitel 3.2 fachlich und repositorytechnisch abgeschlossen.',
 NULL,
 'Letzte Gleichung (3.274), nächste Gleichung (3.275), nächste Quelle [82].');

INSERT INTO `repository_counters`
(`counter_key`,`counter_value`)
VALUES
('next_citation_number','82'),
('next_equation_number','3.275'),
('last_edited_section','3.2.12'),
('last_repository_revision','RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5')
ON DUPLICATE KEY UPDATE
 `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Abschlussaudit 3.2.12 */
SELECT `revision_id`,`revision_code`,`parent_revision_id`,`scope_reference`,`version_label`
FROM `repository_revisions`
WHERE `revision_code`='RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5';

SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes`
FROM `dissertation_sections`
WHERE `section_code`='3.2.12';

SELECT COUNT(*) AS `source_usage_count`,
       SUM(`citation_checked`) AS `checked_usages`
FROM `source_usage`
WHERE `section_id`=@section_id;

SELECT COUNT(*) AS `definition_count`
FROM `definitions`
WHERE `section_id`=@section_id;

SELECT COUNT(*) AS `equation_count`
FROM `equations`
WHERE `section_id`=@section_id;

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
('next_citation_number','next_equation_number','last_edited_section','last_repository_revision')
ORDER BY `counter_key`;
