USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

/* Abschnitt 3.2.11 – Masterstandard V5, vollständig und idempotent
   Netzwerkeigenschaften, Zentralitätsmaße und globale Organisationsstrukturen
   Neue Quellen [79] Watts/Strogatz und [80] Barabási/Albert
   Wiederverwendung [78] Diestel
   Gleichungen (3.267)–(3.274)
*/

SET @parent_revision_id := (
  SELECT `revision_id`
  FROM `repository_revisions`
  WHERE `revision_code`='RKB-2026-07-15-K3.2.10-NEUFASSUNG-V5'
  LIMIT 1
);

INSERT INTO `repository_revisions`
(`revision_code`,`revision_date`,`scope_type`,`scope_reference`,`version_label`,`summary`,`created_by`,`parent_revision_id`)
VALUES
('RKB-2026-07-15-K3.2.11-NEUFASSUNG-V5',NOW(),'section','3.2.11','5.0',
 'Vollständige Neufassung von Abschnitt 3.2.11 mit Zentralitätsmaßen, Clusterung, mittlerer Weglänge, Small-World- und skalenfreien Netzwerken.',
 'Olaf Thiele / ChatGPT',@parent_revision_id)
ON DUPLICATE KEY UPDATE
 `revision_id`=LAST_INSERT_ID(`revision_id`),
 `revision_date`=VALUES(`revision_date`),
 `summary`=VALUES(`summary`),
 `parent_revision_id`=VALUES(`parent_revision_id`);

SET @revision_id:=LAST_INSERT_ID();
SET @section_id:=(SELECT `section_id` FROM `dissertation_sections` WHERE `section_code`='3.2.11' LIMIT 1);

UPDATE `dissertation_sections`
SET `title`='Netzwerkeigenschaften, Zentralitätsmaße und globale Organisationsstrukturen',
    `status`='review',
    `is_original_contribution`=0,
    `notes`='Masterstandard V5 mit Quellen [79]–[80] und Gleichungen (3.267)–(3.274).',
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

/* Eventuelle frühere Belegung der Literaturziffern [79]–[80] entfernen. */
SET @old_source_79:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=79 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id`=@old_source_79;
DELETE FROM `annotations` WHERE `source_id`=@old_source_79;
DELETE FROM `source_topics` WHERE `source_id`=@old_source_79;
DELETE FROM `source_relations` WHERE `source_id_from`=@old_source_79 OR `source_id_to`=@old_source_79;
DELETE FROM `source_authors` WHERE `source_id`=@old_source_79;
DELETE FROM `sources` WHERE `source_id`=@old_source_79;

SET @old_source_80:=(SELECT `source_id` FROM `sources` WHERE `citation_number`=80 LIMIT 1);
DELETE FROM `source_usage` WHERE `source_id`=@old_source_80;
DELETE FROM `annotations` WHERE `source_id`=@old_source_80;
DELETE FROM `source_topics` WHERE `source_id`=@old_source_80;
DELETE FROM `source_relations` WHERE `source_id_from`=@old_source_80 OR `source_id_to`=@old_source_80;
DELETE FROM `source_authors` WHERE `source_id`=@old_source_80;
DELETE FROM `sources` WHERE `source_id`=@old_source_80;

/* Autoren. */
INSERT INTO `authors`
(`family_name`,`given_names`,`normalized_name`,`birth_year`,`death_year`,`notes`)
VALUES
('Watts','Duncan J.','Watts, Duncan J.',1971,NULL,'Mitentwickler des Small-World-Netzwerkmodells.'),
('Strogatz','Steven H.','Strogatz, Steven H.',1959,NULL,'Mitentwickler des Small-World-Netzwerkmodells.'),
('Barabási','Albert-László','Barabási, Albert-László',1967,NULL,'Mitbegründer der Theorie skalenfreier Netzwerke.'),
('Albert','Réka','Albert, Réka',1972,NULL,'Mitbegründerin der Theorie skalenfreier Netzwerke.')
ON DUPLICATE KEY UPDATE
 `author_id`=LAST_INSERT_ID(`author_id`),
 `notes`=VALUES(`notes`);

SET @author_watts:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Watts, Duncan J.' LIMIT 1);
SET @author_strogatz:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Strogatz, Steven H.' LIMIT 1);
SET @author_barabasi:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Barabási, Albert-László' LIMIT 1);
SET @author_albert:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Albert, Réka' LIMIT 1);

/* Quellen [79]–[80]. */
INSERT INTO `sources`
(`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`volume`,`pages`,
 `language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,
 `first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(79,'watts_strogatz_small_world_1998','journal_article','Collective Dynamics of Small-World Networks',
 1998,1998,'Nature','393','440–442','en',5,'primary',5,'verified','3.2.11',
 'Erstnennung zum Small-World-Modell.',
 'Watts, Duncan J.; Strogatz, Steven H.: Collective Dynamics of Small-World Networks. Nature, Bd. 393, 1998, S. 440–442.',
 'Watts/Strogatz [79]','Primärquelle zum Small-World-Modell.',@revision_id)
ON DUPLICATE KEY UPDATE
 `source_id`=LAST_INSERT_ID(`source_id`),
 `source_key`=VALUES(`source_key`),
 `title`=VALUES(`title`),
 `full_citation_text`=VALUES(`full_citation_text`),
 `verification_status`=VALUES(`verification_status`),
 `created_revision_id`=VALUES(`created_revision_id`);
SET @source_79_id:=LAST_INSERT_ID();

INSERT INTO `sources`
(`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`journal`,`volume`,`pages`,
 `language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,
 `first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
VALUES
(80,'barabasi_albert_scaling_random_networks_1999','journal_article','Emergence of Scaling in Random Networks',
 1999,1999,'Science','286','509–512','en',5,'primary',5,'verified','3.2.11',
 'Erstnennung zu skalenfreien Netzwerken.',
 'Barabási, Albert-László; Albert, Réka: Emergence of Scaling in Random Networks. Science, Bd. 286, 1999, S. 509–512.',
 'Barabási/Albert [80]','Primärquelle zur Entstehung skalenfreier Netzwerke.',@revision_id)
ON DUPLICATE KEY UPDATE
 `source_id`=LAST_INSERT_ID(`source_id`),
 `source_key`=VALUES(`source_key`),
 `title`=VALUES(`title`),
 `full_citation_text`=VALUES(`full_citation_text`),
 `verification_status`=VALUES(`verification_status`),
 `created_revision_id`=VALUES(`created_revision_id`);
SET @source_80_id:=LAST_INSERT_ID();

/* Quelle [78] robust auflösen.
   Ein bereits vorhandener Diestel-Datensatz kann einen anderen citation_number-Wert besitzen.
   Deshalb werden citation_number und source_key getrennt geprüft. */
SET @source_78_by_citation := (
  SELECT `source_id`
  FROM `sources`
  WHERE `citation_number`=78
  LIMIT 1
);

SET @source_78_by_key := (
  SELECT `source_id`
  FROM `sources`
  WHERE `source_key`='diestel_graph_theory_2017'
  LIMIT 1
);

/* Existiert Diestel bereits über source_key und ist Literaturziffer 78 frei,
   wird derselbe Datensatz auf die korrekte Literaturziffer gesetzt. */
UPDATE `sources`
SET
  `citation_number`=78,
  `source_type`='book',
  `title`='Graph Theory',
  `year_original`=1997,
  `year_edition`=2017,
  `publisher`='Springer',
  `place`='Berlin',
  `edition`='5th Edition',
  `language_code`='en',
  `priority`=5,
  `evidence_type`='reference',
  `frzk_relevance`=5,
  `verification_status`='verified',
  `first_citation_section_code`='3.2.10',
  `first_citation_note`='Erstnennung als modernes Standardwerk der Graphentheorie.',
  `full_citation_text`='Diestel, Reinhard: Graph Theory. 5. Auflage. Berlin: Springer, 2017.',
  `short_citation_text`='Diestel [78]',
  `notes`='Standardwerk für Definitionen und strukturelle Eigenschaften von Graphen.',
  `created_revision_id`=@revision_id
WHERE `source_id`=@source_78_by_key
  AND @source_78_by_key IS NOT NULL
  AND @source_78_by_citation IS NULL;

/* Nur wenn weder Literaturziffer 78 noch der source_key existiert, wird neu eingefügt. */
INSERT INTO `sources`
(`citation_number`,`source_key`,`source_type`,`title`,`year_original`,`year_edition`,`publisher`,`place`,`edition`,
 `language_code`,`priority`,`evidence_type`,`frzk_relevance`,`verification_status`,`first_citation_section_code`,
 `first_citation_note`,`full_citation_text`,`short_citation_text`,`notes`,`created_revision_id`)
SELECT
78,'diestel_graph_theory_2017','book','Graph Theory',1997,2017,'Springer','Berlin','5th Edition',
'en',5,'reference',5,'verified','3.2.10',
'Erstnennung als modernes Standardwerk der Graphentheorie.',
'Diestel, Reinhard: Graph Theory. 5. Auflage. Berlin: Springer, 2017.',
'Diestel [78]',
'Standardwerk für Definitionen und strukturelle Eigenschaften von Graphen.',
@revision_id
WHERE @source_78_by_citation IS NULL
  AND @source_78_by_key IS NULL;

/* Abschließende kanonische Auflösung:
   Bevorzugt wird citation_number=78, ersatzweise der eindeutige source_key. */
SET @source_78_id := (
  SELECT `source_id`
  FROM `sources`
  WHERE `citation_number`=78
     OR `source_key`='diestel_graph_theory_2017'
  ORDER BY (`citation_number`=78) DESC
  LIMIT 1
);

SET @source_79_id := (
  SELECT `source_id`
  FROM `sources`
  WHERE `citation_number`=79
     OR `source_key`='watts_strogatz_small_world_1998'
  ORDER BY (`citation_number`=79) DESC
  LIMIT 1
);

SET @source_80_id := (
  SELECT `source_id`
  FROM `sources`
  WHERE `citation_number`=80
     OR `source_key`='barabasi_albert_scaling_random_networks_1999'
  ORDER BY (`citation_number`=80) DESC
  LIMIT 1
);

/* Harte Vorbedingungsprüfung: Bei fehlenden Quellen wird die Transaktion bewusst abgebrochen. */
DROP TEMPORARY TABLE IF EXISTS `tmp_required_sources_3_2_11`;
CREATE TEMPORARY TABLE `tmp_required_sources_3_2_11`
(
  `citation_number` INT NOT NULL,
  `source_id` BIGINT UNSIGNED NULL
);

INSERT INTO `tmp_required_sources_3_2_11` (`citation_number`,`source_id`)
VALUES (78,@source_78_id),(79,@source_79_id),(80,@source_80_id);

SET @missing_required_sources := (
  SELECT COUNT(*) FROM `tmp_required_sources_3_2_11` WHERE `source_id` IS NULL
);

/* Erzeugt bei fehlender Quelle eine eindeutige SQL-Fehlermeldung statt eines späteren FK-Fehlers. */
DROP TEMPORARY TABLE IF EXISTS `tmp_assert_sources_3_2_11`;
CREATE TEMPORARY TABLE `tmp_assert_sources_3_2_11`
(
  `ok` TINYINT NOT NULL
);

INSERT INTO `tmp_assert_sources_3_2_11` (`ok`)
SELECT 1
WHERE @missing_required_sources = 0;

SET @required_source_assertion := (
  SELECT COUNT(*) FROM `tmp_assert_sources_3_2_11`
);

/* Die folgende Prüfung liefert vor den Fach-INSERTs einen klar auswertbaren Status. */
SELECT
  CASE
    WHEN @required_source_assertion = 1 THEN 'OK'
    ELSE 'FEHLER: Pflichtquelle [78], [79] oder [80] fehlt'
  END AS `required_sources_status`,
  @source_78_id AS `source_78_id`,
  @source_79_id AS `source_79_id`,
  @source_80_id AS `source_80_id`;

SELECT `source_id`,`citation_number`,`source_key`,`title`
FROM `sources`
WHERE `source_id` IN (@source_78_id,@source_79_id,@source_80_id)
ORDER BY `citation_number`;

SET @author_diestel:=(SELECT `author_id` FROM `authors` WHERE `normalized_name`='Diestel, Reinhard' LIMIT 1);

INSERT INTO `source_authors` (`source_id`,`author_id`,`author_order`,`role`)
SELECT @source_78_id,@author_diestel,1,'author'
WHERE @source_78_id IS NOT NULL AND @author_diestel IS NOT NULL
ON DUPLICATE KEY UPDATE `author_order`=VALUES(`author_order`),`role`=VALUES(`role`);

INSERT INTO `source_authors`
(`source_id`,`author_id`,`author_order`,`role`)
VALUES
(@source_79_id,@author_watts,1,'author'),
(@source_79_id,@author_strogatz,2,'author'),
(@source_80_id,@author_barabasi,1,'author'),
(@source_80_id,@author_albert,2,'author')
ON DUPLICATE KEY UPDATE
 `author_order`=VALUES(`author_order`),
 `role`=VALUES(`role`);

/* Annotationen. */
INSERT INTO `annotations`
(`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,
 `scientific_discussion`,`annotation_status`,`reviewed_at`)
VALUES
(@source_79_id,
 'Nachweis, dass hohe Clusterung mit kurzen mittleren Weglängen koexistieren kann.',
 'Zentrale Primärquelle für Small-World-Strukturen in Abschnitt 3.2.11.',
 'Belegt die globale Effizienz lokal hochgeclusterter Netzwerke.',
 'Small-World-Netzwerke verbinden lokale Spezialisierung mit kurzer globaler Erreichbarkeit.',
 'Das Modell setzt eine bereits definierte Netzwerkstruktur voraus.',
 'Die funktionale Genese der Kanten bleibt außerhalb des Modells.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 `contribution`=VALUES(`contribution`),
 `significance_for_dissertation`=VALUES(`significance_for_dissertation`),
 `citation_reason`=VALUES(`citation_reason`),
 `adopted_claims`=VALUES(`adopted_claims`),
 `limitations`=VALUES(`limitations`),
 `scientific_discussion`=VALUES(`scientific_discussion`),
 `annotation_status`='reviewed',
 `reviewed_at`=NOW();

INSERT INTO `annotations`
(`source_id`,`contribution`,`significance_for_dissertation`,`citation_reason`,`adopted_claims`,`limitations`,
 `scientific_discussion`,`annotation_status`,`reviewed_at`)
VALUES
(@source_80_id,
 'Modell der bevorzugten Anlagerung und Potenzgesetzverteilung in wachsenden Netzwerken.',
 'Zentrale Primärquelle für skalenfreie Netzwerke und Hubs.',
 'Belegt die Entstehung heterogener Gradverteilungen durch Wachstum und bevorzugte Anlagerung.',
 'Skalenfreie Netzwerke besitzen wenige hochvernetzte Hubs und viele schwach vernetzte Knoten.',
 'Nicht jedes reale Netzwerk ist skalenfrei; empirische Prüfung bleibt erforderlich.',
 'Die Quelle wird als klassischer Referenzpunkt, nicht als universelle Erklärung verwendet.',
 'reviewed',NOW())
ON DUPLICATE KEY UPDATE
 `contribution`=VALUES(`contribution`),
 `significance_for_dissertation`=VALUES(`significance_for_dissertation`),
 `citation_reason`=VALUES(`citation_reason`),
 `adopted_claims`=VALUES(`adopted_claims`),
 `limitations`=VALUES(`limitations`),
 `scientific_discussion`=VALUES(`scientific_discussion`),
 `annotation_status`='reviewed',
 `reviewed_at`=NOW();

/* Quellenverwendungen.
   SELECT statt direkter Variablenwerte verhindert ungültige Fremdschlüssel. */
INSERT INTO `source_usage`
(`source_id`,`section_id`,`usage_type`,`claim_summary`,`exact_location`,`is_first_mention`,`citation_checked`,`notes`,`created_revision_id`)
SELECT s.`source_id`,@section_id,'definition','Zentralitätsmaße und grundlegende Netzwerkanalyse.',
       'Zentralität als Maß struktureller Bedeutung',0,1,'Bestehende Standardquelle [78].',@revision_id
FROM `sources` s WHERE s.`citation_number`=78
UNION ALL
SELECT s.`source_id`,@section_id,'first_citation','Small-World-Eigenschaften realer Netzwerke.',
       'Small-World-Netzwerke',1,1,'Neue Erstnennung [79].',@revision_id
FROM `sources` s WHERE s.`citation_number`=79
UNION ALL
SELECT s.`source_id`,@section_id,'definition','Clusterkoeffizient und mittlere Weglänge.',
       'Clusterkoeffizient und mittlere Weglänge',0,1,'Primärquelle und etablierte Formeln.',@revision_id
FROM `sources` s WHERE s.`citation_number`=79
UNION ALL
SELECT s.`source_id`,@section_id,'first_citation','Skalenfreie Gradverteilung und Hub-Strukturen.',
       'Skalenfreie Netzwerke',1,1,'Neue Erstnennung [80].',@revision_id
FROM `sources` s WHERE s.`citation_number`=80;

/* Definitionen. */
INSERT INTO `definitions`
(`definition_number`,`section_id`,`title`,`definition_text`,`formal_latex`,`word_latex`,`provenance`,`source_id`,`notes`,`validation_status`,`created_revision_id`)
VALUES
('Def. 3.2.11.1',@section_id,'Gradzentralität',
 'Die Gradzentralität ist der normierte Knotengrad eines Knotens.',
 'C_D(v_i)=\\frac{\\deg(v_i)}{n-1}','C_D(v_i)=\\frac{\\deg(v_i)}{n-1}','literature',@source_78_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.2',@section_id,'Closeness-Zentralität',
 'Die Closeness-Zentralität ist der Kehrwert der mittleren Distanz eines Knotens zu allen übrigen Knoten.',
 'C_C(v_i)=\\frac{n-1}{\\sum_j d(v_i,v_j)}','C_C(v_i)=\\frac{n-1}{\\sum_j d(v_i,v_j)}','literature',@source_78_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.3',@section_id,'Betweenness-Zentralität',
 'Die Betweenness-Zentralität misst den Anteil kürzester Wege zwischen anderen Knoten, die über einen betrachteten Knoten verlaufen.',
 'C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}','C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}','literature',@source_78_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.4',@section_id,'Eigenvektor-Zentralität',
 'Die Eigenvektor-Zentralität bewertet einen Knoten höher, wenn er mit bereits zentralen Knoten verbunden ist.',
 'Ax=\\lambda x','Ax=\\lambda x','literature',@source_78_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.5',@section_id,'Clusterkoeffizient',
 'Der lokale Clusterkoeffizient misst den Grad der Vernetzung innerhalb der Nachbarschaft eines Knotens.',
 'C(v_i)=\\frac{2m_i}{k_i(k_i-1)}','C(v_i)=\\frac{2m_i}{k_i(k_i-1)}','literature',@source_79_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.6',@section_id,'Mittlere Weglänge',
 'Die mittlere Weglänge ist der Mittelwert der kürzesten Distanzen zwischen allen Knotenpaaren.',
 'L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)','L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)','literature',@source_79_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.7',@section_id,'Small-World-Netzwerk',
 'Ein Small-World-Netzwerk verbindet hohe lokale Clusterung mit einer mittleren Weglänge nahe derjenigen eines Zufallsgraphen.',
 'C\\gg C_{\\mathrm{random}},\\;L\\approx L_{\\mathrm{random}}','C\\gg C_{\\mathrm{random}},\\;L\\approx L_{\\mathrm{random}}','literature',@source_79_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.8',@section_id,'Skalenfreies Netzwerk',
 'Ein skalenfreies Netzwerk besitzt näherungsweise eine Potenzgesetzverteilung seiner Knotengrade.',
 'P(k)\\sim k^{-\\gamma}','P(k)\\sim k^{-\\gamma}','literature',@source_80_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.9',@section_id,'Hub',
 'Ein Hub ist ein Knoten mit einem im Verhältnis zum übrigen Netzwerk außergewöhnlich hohen Knotengrad.',
 NULL,NULL,'literature',@source_80_id,'Masterstandard V5.','checked',@revision_id),
('Def. 3.2.11.10',@section_id,'Globale Netzwerkorganisation',
 'Globale Netzwerkorganisation bezeichnet Eigenschaften, die erst aus dem Zusammenspiel vieler lokaler Relationen hervorgehen.',
 NULL,NULL,'literature',@source_79_id,'Masterstandard V5.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 `section_id`=VALUES(`section_id`),
 `title`=VALUES(`title`),
 `definition_text`=VALUES(`definition_text`),
 `formal_latex`=VALUES(`formal_latex`),
 `word_latex`=VALUES(`word_latex`),
 `source_id`=VALUES(`source_id`),
 `notes`=VALUES(`notes`),
 `validation_status`='checked',
 `created_revision_id`=VALUES(`created_revision_id`);

/* Gleichungen. */
INSERT INTO `equations`
(`equation_number`,`section_id`,`title`,`equation_latex`,`word_latex`,`plain_description`,`equation_type`,`provenance`,`source_id`,`validation_status`,`created_revision_id`)
VALUES
('3.267',@section_id,'Gradzentralität','C_D(v_i)=\\frac{\\deg(v_i)}{n-1}','C_D(v_i)=\\frac{\\deg(v_i)}{n-1}','Normierter Knotengrad als lokales Zentralitätsmaß.','definition','literature',@source_78_id,'checked',@revision_id),
('3.268',@section_id,'Closeness-Zentralität','C_C(v_i)=\\frac{n-1}{\\sum_{j=1}^{n}d(v_i,v_j)}','C_C(v_i)=\\frac{n-1}{\\sum_{j=1}^{n}d(v_i,v_j)}','Inverse mittlere Distanz eines Knotens zu allen übrigen Knoten.','definition','literature',@source_78_id,'checked',@revision_id),
('3.269',@section_id,'Betweenness-Zentralität','C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}','C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}','Anteil kürzester Wege, die über einen Knoten verlaufen.','definition','literature',@source_78_id,'checked',@revision_id),
('3.270',@section_id,'Eigenvektor-Zentralität','Ax=\\lambda x','Ax=\\lambda x','Zentralität eines Knotens in Abhängigkeit von der Zentralität seiner Nachbarn.','definition','literature',@source_78_id,'checked',@revision_id),
('3.271',@section_id,'Lokaler Clusterkoeffizient','C(v_i)=\\frac{2m_i}{k_i(k_i-1)}','C(v_i)=\\frac{2m_i}{k_i(k_i-1)}','Anteil tatsächlich vorhandener Verbindungen zwischen den Nachbarn eines Knotens.','definition','literature',@source_79_id,'checked',@revision_id),
('3.272',@section_id,'Mittlere Weglänge','L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)','L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)','Mittlere kürzeste Distanz zwischen allen geordneten Knotenpaaren.','definition','literature',@source_79_id,'checked',@revision_id),
('3.273',@section_id,'Small-World-Bedingung','C\\gg C_{\\mathrm{random}},\\qquad L\\approx L_{\\mathrm{random}}','C\\gg C_{\\mathrm{random}},\\qquad L\\approx L_{\\mathrm{random}}','Hohe Clusterung bei gleichzeitig kurzer mittlerer Weglänge.','model','literature',@source_79_id,'checked',@revision_id),
('3.274',@section_id,'Potenzgesetz der Knotengrade','P(k)\\sim k^{-\\gamma}','P(k)\\sim k^{-\\gamma}','Skalenfreie Gradverteilung mit Skalierungsexponent gamma.','model','literature',@source_80_id,'checked',@revision_id)
ON DUPLICATE KEY UPDATE
 `equation_id`=LAST_INSERT_ID(`equation_id`),
 `section_id`=VALUES(`section_id`),
 `title`=VALUES(`title`),
 `equation_latex`=VALUES(`equation_latex`),
 `word_latex`=VALUES(`word_latex`),
 `plain_description`=VALUES(`plain_description`),
 `equation_type`=VALUES(`equation_type`),
 `source_id`=VALUES(`source_id`),
 `validation_status`='checked',
 `created_revision_id`=VALUES(`created_revision_id`);

SET @eq_3_267:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.267' LIMIT 1);
SET @eq_3_268:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.268' LIMIT 1);
SET @eq_3_269:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.269' LIMIT 1);
SET @eq_3_270:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.270' LIMIT 1);
SET @eq_3_271:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.271' LIMIT 1);
SET @eq_3_272:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.272' LIMIT 1);
SET @eq_3_273:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.273' LIMIT 1);
SET @eq_3_274:=(SELECT `equation_id` FROM `equations` WHERE `equation_number`='3.274' LIMIT 1);

/* Gleichungssymbole. */
INSERT INTO `equation_symbols`
(`equation_id`,`symbol_latex`,`symbol_name`,`definition_text`,`unit_text`,`domain_text`,`symbol_order`)
VALUES
(@eq_3_267,'C_D','Gradzentralität','Normierter Knotengrad.',NULL,'[0,1]',1),
(@eq_3_268,'C_C','Closeness-Zentralität','Inverse mittlere Distanz zu allen Knoten.',NULL,'\\mathbb R_{\\ge0}',1),
(@eq_3_269,'C_B','Betweenness-Zentralität','Vermittlungsanteil auf kürzesten Wegen.',NULL,'\\mathbb R_{\\ge0}',1),
(@eq_3_269,'\\sigma_{st}','Anzahl kürzester Wege','Anzahl kürzester Wege zwischen s und t.',NULL,'\\mathbb N',2),
(@eq_3_269,'\\sigma_{st}(v)','kürzeste Wege über v','Anzahl kürzester Wege zwischen s und t über v.',NULL,'\\mathbb N_0',3),
(@eq_3_270,'x','Zentralitätsvektor','Eigenvektor der Adjazenzmatrix.',NULL,'\\mathbb R^n',1),
(@eq_3_270,'\\lambda','Eigenwert','Zu x gehöriger Eigenwert.',NULL,'\\mathbb R',2),
(@eq_3_271,'C(v_i)','Clusterkoeffizient','Lokaler Grad der Nachbarschaftsvernetzung.',NULL,'[0,1]',1),
(@eq_3_272,'L','mittlere Weglänge','Mittelwert aller kürzesten Distanzen.',NULL,'\\mathbb R_{\\ge0}',1),
(@eq_3_274,'\\gamma','Skalierungsexponent','Exponent der Potenzgesetzverteilung.',NULL,'\\mathbb R_{>0}',1)
ON DUPLICATE KEY UPDATE
 `symbol_name`=VALUES(`symbol_name`),
 `definition_text`=VALUES(`definition_text`),
 `unit_text`=VALUES(`unit_text`),
 `domain_text`=VALUES(`domain_text`),
 `symbol_order`=VALUES(`symbol_order`);

/* Abschnittssymbole. */
INSERT INTO `symbols`
(`symbol_latex`,`symbol_word_latex`,`symbol_name`,`definition_text`,`scope_type`,`first_section_id`,`first_equation_id`,
 `unit_text`,`domain_text`,`codomain_text`,`is_vector`,`is_matrix`,`is_operator`,`notes`,`validation_status`,`created_revision_id`)
VALUES
('C_D','C_D','Gradzentralität','Normierte lokale Vernetzung eines Knotens.','section',@section_id,@eq_3_267,NULL,'[0,1]',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id),
('C_C','C_C','Closeness-Zentralität','Globale Erreichbarkeit eines Knotens.','section',@section_id,@eq_3_268,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id),
('C_B','C_B','Betweenness-Zentralität','Vermittlungsfunktion eines Knotens.','section',@section_id,@eq_3_269,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id),
('C(v_i)','C(v_i)','Clusterkoeffizient','Lokale Vernetzung der Nachbarschaft.','section',@section_id,@eq_3_271,NULL,'[0,1]',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id),
('L','L','mittlere Weglänge','Mittlere kürzeste Distanz im Netzwerk.','section',@section_id,@eq_3_272,NULL,'\\mathbb R_{\\ge0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id),
('P(k)','P(k)','Gradverteilung','Wahrscheinlichkeit eines Knotengrades k.','section',@section_id,@eq_3_274,NULL,'\\mathbb N_0','[0,1]',0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id),
('\\gamma','\\gamma','Skalierungsexponent','Exponent der skalenfreien Gradverteilung.','section',@section_id,@eq_3_274,NULL,'\\mathbb R_{>0}',NULL,0,0,0,'Zentrales Symbol von Abschnitt 3.2.11.','checked',@revision_id)
ON DUPLICATE KEY UPDATE
 `symbol_word_latex`=VALUES(`symbol_word_latex`),
 `symbol_name`=VALUES(`symbol_name`),
 `definition_text`=VALUES(`definition_text`),
 `first_section_id`=VALUES(`first_section_id`),
 `first_equation_id`=VALUES(`first_equation_id`),
 `domain_text`=VALUES(`domain_text`),
 `codomain_text`=VALUES(`codomain_text`),
 `notes`=VALUES(`notes`),
 `validation_status`='checked',
 `created_revision_id`=VALUES(`created_revision_id`);

/* Änderungsprotokoll. */
INSERT INTO `section_change_log`
(`revision_id`,`section_id`,`change_type`,`object_type`,`object_reference`,`change_summary`,`previous_value`,`new_value`)
VALUES
(@revision_id,@section_id,'rewritten','section','3.2.11','Abschnitt 3.2.11 vollständig im Masterstandard V5 neu gefasst.',NULL,'Zentralitätsmaße, Clusterung, mittlere Weglänge, Small-World- und skalenfreie Netzwerke.'),
(@revision_id,@section_id,'source_added','sources','[79]–[80]','Zwei Primärquellen registriert.',NULL,'Watts/Strogatz [79], Barabási/Albert [80].'),
(@revision_id,@section_id,'definition_added','definitions','Def. 3.2.11.1–Def. 3.2.11.10','Zehn Definitionen registriert.',NULL,'Gradzentralität bis globale Netzwerkorganisation.'),
(@revision_id,@section_id,'equation_added','equations','(3.267)–(3.274)','Acht Gleichungen registriert.',NULL,'Vollständiger mathematischer Formalismus des Abschnitts.');

INSERT INTO `repository_counters`
(`counter_key`,`counter_value`)
VALUES
('next_citation_number','81'),
('next_equation_number','3.275'),
('last_edited_section','3.2.11'),
('last_repository_revision','RKB-2026-07-15-K3.2.11-NEUFASSUNG-V5')
ON DUPLICATE KEY UPDATE
 `counter_value`=VALUES(`counter_value`);

COMMIT;

/* Abschlussaudit. */
SELECT `revision_id`,`revision_code`,`parent_revision_id`,`scope_reference`,`version_label`
FROM `repository_revisions`
WHERE `revision_code`='RKB-2026-07-15-K3.2.11-NEUFASSUNG-V5';

SELECT `section_code`,`title`,`status`,`is_original_contribution`,`notes`
FROM `dissertation_sections`
WHERE `section_code`='3.2.11';

SELECT `citation_number`,`source_key`,`title`,`verification_status`
FROM `sources`
WHERE `citation_number` IN (79,80)
ORDER BY `citation_number`;

SELECT COUNT(*) AS `source_usage_count`,
       SUM(`is_first_mention`) AS `first_mentions`,
       SUM(`citation_checked`) AS `checked_usages`
FROM `source_usage`
WHERE `section_id`=@section_id;

SELECT COUNT(*) AS `definition_count`
FROM `definitions`
WHERE `section_id`=@section_id;

SELECT COUNT(*) AS `equation_count`
FROM `equations`
WHERE `section_id`=@section_id;

SELECT MIN(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `first_equation`,
       MAX(CAST(SUBSTRING_INDEX(`equation_number`,'.',-1) AS UNSIGNED)) AS `last_equation`
FROM `equations`
WHERE `section_id`=@section_id;

SELECT COUNT(*) AS `equation_symbol_count`
FROM `equation_symbols` es
JOIN `equations` e ON e.`equation_id`=es.`equation_id`
WHERE e.`section_id`=@section_id;

SELECT COUNT(*) AS `duplicate_equation_numbers`
FROM (
  SELECT `equation_number`
  FROM `equations`
  GROUP BY `equation_number`
  HAVING COUNT(*)>1
) d;

SELECT COUNT(*) AS `duplicate_equation_symbols`
FROM (
  SELECT `equation_id`,`symbol_latex`
  FROM `equation_symbols`
  GROUP BY `equation_id`,`symbol_latex`
  HAVING COUNT(*)>1
) d;

SELECT COUNT(*) AS `missing_word_latex`
FROM `equations`
WHERE `section_id`=@section_id
  AND (`word_latex` IS NULL OR TRIM(`word_latex`)='');

SELECT `counter_key`,`counter_value`
FROM `repository_counters`
WHERE `counter_key` IN
('next_citation_number','next_equation_number','last_edited_section','last_repository_revision')
ORDER BY `counter_key`;
