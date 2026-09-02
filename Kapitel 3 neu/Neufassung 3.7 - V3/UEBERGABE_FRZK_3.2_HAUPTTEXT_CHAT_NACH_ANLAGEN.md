# Übergabe – FRZK Kapitel 3.2: separater Chat ausschließlich für den komprimierten Haupttext

> **Zweck dieser Datei:** Diese Übergabe ist für einen eigenen Chat bestimmt, der ausschließlich den inhaltlichen Haupttext von Kapitel 3.2 neu formuliert, **nachdem die mathematischen Anlagen M1–M6 vollständig realisiert, repositoryseitig gespeichert und durch ihre Gates freigegeben worden sind**. Der Chat erstellt oder erweitert die Anlagen nicht. Er nutzt sie als bereits vorhandene, zitier- und referenzierbare mathematische Vertiefungsschicht.

## 1. Startanweisung für den Haupttext-Chat

Arbeite ausschließlich am Haupttext von Kapitel 3.2 „Mathematische Grundlagen“. Verwende die **neueste nach Abschluss der Anlagen erzeugte FRZK-Repository-Datenbank** als führende technische Quelle. Diese Übergabedatei beschreibt den Mindeststand und die Regeln; wenn die spätere DB nach Realisierung von M1–M6 zusätzliche Tabellen, Revisionen, finalisierte Anlagenanker oder präzisere Zuordnungen enthält, hat dieser neuere Repository-Stand Vorrang.

Der Haupttext soll mathematisch und inhaltlich **denselben oder einen höheren fachlichen Stand** wie die Quellfassung besitzen, aber deutlich kürzer werden. Kürzung erfolgt ausschließlich durch Verdichtung, Vermeidung von Wiederholungen und Verlagerung von supporting-/derivation-/example-Material in die bereits realisierten Anlagen. Kein mathematisch erforderlicher Inhalt darf ersatzlos verschwinden.

### Verbindliche Arbeitsprinzipien

- Kapitel 3.2 ist der mathematische Hauptpfad zwischen 3.1 und der Axiomatik in 3.3.
- Der Haupttext enthält nur `document_location = main_text`; Anlagenobjekte werden nicht erneut vollständig ausgeschrieben.
- `core`-Objekte sind grundsätzlich im Haupttext zu erhalten; `supporting`-Objekte nur in der für den Argumentationsfluss erforderlichen Kürze.
- Reine Herleitungen, Beweisschritte und Beispiele verbleiben in M1–M6 und werden höchstens gezielt referenziert.
- Jede kanonische Definition, jeder Satz und jede Gleichung erhält eine stabile Repository-Identität; sichtbare Nummern dürfen erst nach der neuen Gliederung endgültig vergeben werden.
- Die Herkunft aus der alten 3.2.0–3.2.12-Fassung darf bei der Neugliederung nicht überschrieben werden.
- Literatur darf nur verwendet werden, wenn die konkrete Aussage durch `source_research_evidence` beziehungsweise eine mindestens gleichwertige spätere Evidenzstruktur gestützt ist.
- Wörtliche Zitate dürfen nur aus tatsächlich eingesehenem Originaltext stammen; sonst ist eine eindeutig als Paraphrase geführte Belegbeschreibung zu verwenden.
- Der Haupttext führt keine konkreten FRZK-Anwendungen aus Kapitel 6 vorweg.
- FRZK-spezifische Eigenleistungen dürfen in 3.2 nur dort erscheinen, wo sie für die methodische Abgrenzung oder den Anschluss erforderlich sind; originäre Setzungen gehören grundsätzlich in 3.3 und müssen dort ausdrücklich als Eigenleistung gekennzeichnet werden.
- Ausgaben vollständiger 3.2-Abschnitte erscheinen direkt im normalen Chat; SQL-/Repository-Skripte werden ausschließlich als herunterladbare Datei bereitgestellt.
- Der Schreibstil bleibt wissenschaftlich, in Ich-Form, mit logisch verbundenen Absätzen; keine Häufung alleinstehender Sätze.
- Im Fließtext erscheinen keine Weblinks oder URLs. Literatur wird im festgelegten Dissertationsformat angegeben.
- Formelbestandteile im Fließtext werden in runden Klammern als Word-LaTeX geschrieben. Jede eigenständig gerenderte Formel/Gleichung erhält unmittelbar in der nächsten Zeile eine `Word-LaTeX: …`-Zeile.

## 2. Harte Startvoraussetzung: Die Anlagen müssen abgeschlossen sein

Der Haupttext-Chat darf die eigentliche Neufassung von 3.2 erst beginnen, wenn die **aktuellste DB** mindestens Folgendes bestätigt:
- Alle sechs Module `M1` bis `M6` existieren und besitzen einen abgeschlossenen Status (`final` oder ein äquivalenter späterer Freigabestatus).
- Die Anlagenabschnitte und ihre Versionen sind in `appendix_sections` und `appendix_section_versions` oder einer äquivalenten späteren Struktur gespeichert.
- Alle ausgelagerten Repository-Objekte sind über `appendix_object_placements` oder eine äquivalente Struktur tatsächlich in den Anlagen platziert.
- Jeder endgültig ausgelagerte Gegenstand besitzt einen stabilen, auflösbaren Anlagenanker.
- Alle Anlagen-Gates stehen auf PASS; offene `blocker`- oder `critical`-Issues für M1–M6 sind nicht zulässig.
- Die Deep-Research-Evidenz für die in den Anlagen und im Haupttext verwendete Literatur ist gespeichert.
- Die neueste DB enthält die nach der Anlagenrealisierung entstandene Repository-Revision; Revision 5 der hier beschriebenen Ausgangslage darf dann nicht mehr als Endstand behandelt werden.

### Empfohlene Startprüfung

```sql
SELECT appendix_code, title, status
FROM appendix_modules
ORDER BY sort_order;

SELECT COUNT(*) AS appendix_sections
FROM appendix_sections;

SELECT COUNT(*) AS final_appendix_versions
FROM appendix_section_versions
WHERE version_kind = 'final';

SELECT COUNT(*) AS placed_appendix_objects
FROM appendix_object_placements;

SELECT *
FROM v_math_compression_gate
ORDER BY gate_code;
```

Wenn diese Tabellen in der neuesten DB anders heißen, ist ihre semantisch äquivalente Struktur zu verwenden. Die Übergabe verlangt die Funktion, nicht zwingend den alten Tabellennamen.

## 3. Identitäts- und Ausgangsdateien

- `frzk_rkb_32_neu_konform_ende_3.1_mit_anlagenprofil.sql` — SHA-256 `111e62c6022f2697e7c43dc980696893c19c2aa6d3747f8b0c7b756ebafdd896`
- `UEBERGABE_FRZK_3.2_MATHEMATISCHE_ANLAGEN_CHAT.md` — SHA-256 `2e3fb13ddb2c4efab8a7a84108130f76f16a0adf13091db6b9a4e34f72391190`
- `K32_Haupttext_Anlagen_DB_Profil.md` — SHA-256 `93e1179af350d66eca16e561611b3b24e583364671af6f502e6c039bfa21de11`
- `K32_Literaturbelege_Deep_Research.md` — SHA-256 `1cc335b3d4f50aa7bedcb6dd57957289fb4d0c69b76a45e36f7fed9e2d4181a8`
- `3.2 Mathematische Grundlagen_V2.docx` — SHA-256 `2eb3973c5cfe642020c033f00b9fdebff71bafdc67ef54d8576baadd2c6c983e`

**Wichtig:** Nach Abschluss der Anlagen muss zusätzlich die dann neueste SQL-Gesamtdatenbank in den Haupttext-Chat geladen werden. Diese spätere DB ist führend; die oben genannte Revision-5-Datenbank dient nur als nachvollziehbare Ausgangsbasis.

## 4. Repository-Ausgangsstand vor Anlagenrealisierung

- Repository-Objekte insgesamt: **275**
- als Haupttext klassifiziert: **131**
- als Anlage klassifiziert: **144**
- Haupttext-Definitionen: **26**
- Haupttext-Satzkandidaten: **5**
- Haupttext-Gleichungskandidaten: **100**
- Die Quellfassung enthält die Abschnitte 3.2.0–3.2.12; 3.2.13 ist nur angekündigt und noch nicht als vollständiger Quellabschnitt vorhanden.
- Die Haupttextklassifikation wurde in Revision 5 als **Vorschlag** (`classification_status = proposed`) erzeugt. Nach Realisierung der Anlagen ist gegen die finale DB zu prüfen, welche Profile bestätigt oder geändert wurden.

### Verteilung der 131 Haupttextobjekte nach Quellabschnitt

| Quellabschnitt | Haupttextobjekte |
|---|---:|
| 3.2.1 | 10 |
| 3.2.2 | 7 |
| 3.2.3 | 7 |
| 3.2.4 | 3 |
| 3.2.5 | 5 |
| 3.2.6 | 9 |
| 3.2.7 | 8 |
| 3.2.8 | 9 |
| 3.2.9 | 14 |
| 3.2.10 | 17 |
| 3.2.11 | 15 |
| 3.2.12 | 27 |

## 5. Zielgliederung des komprimierten Haupttextes

Diese Gliederung ist die derzeit vorgesehene Verdichtungsstruktur. Sie darf nach Sichtung der final realisierten Anlagen feinjustiert werden, **ohne den mathematischen Stand zu vermindern**.

| Neuer Abschnitt | Titel | Funktion | Quellbereiche |
|---|---|---|---|
| **3.2.0** | Mathematische Grundlegung und Abgrenzung | Zweck von Kapitel 3.2; Trennung zwischen etablierter Mathematik und FRZK-Eigenleistung; verbindliche Rolle der Anlagen; mathematischer Hauptpfad zu Kapitel 3.3. | 3.2.0 |
| **3.2.1** | Mengen, Relationen und Funktionen | Kanonischer Grundbestand zu Menge, Relation, Funktion, Bild/Urbild sowie Injektivität, Surjektivität und Bijektivität; Detailmaterial verweist auf M1. | 3.2.1, 3.2.2 |
| **3.2.2** | Vektorräume und lineare Strukturen | Vektorraum, Linearkombination, Spannraum, lineare Unabhängigkeit, Basis und Dimension; Axiome, Herleitungen und Beispiele in M2. | 3.2.4, 3.2.5, 3.2.6 |
| **3.2.3** | Lineare Abbildungen und ihre Darstellung | Lineare Abbildung, Operator, Matrixdarstellung, Koordinaten und Basiswechsel; Detailrechnungen und Invarianten in M3. | 3.2.3, 3.2.7 |
| **3.2.4** | Struktur linearer Operatoren | Determinante, Kern, Bild, Rang, Invertierbarkeit und Rang-Nullität; Rechnungen und LGS-Vertiefungen in M3/M4. | 3.2.8, 3.2.9 |
| **3.2.5** | Eigenstruktur und Spektraldarstellung | Eigenwert, Eigenvektor, Eigenraum, Diagonalisierbarkeit und Spektralzerlegung; Rechen- und Projektorvertiefungen in M5. | 3.2.10, 3.2.11 |
| **3.2.6** | Skalarprodukt-, Projektions- und Hilbertraumstrukturen | Skalarprodukt, Norm, Orthogonalität, Projektion und der für die weitere Arbeit benötigte Hilbertraumanschluss; Vertiefungen in M6. | 3.2.12, 3.2.13 |
| **3.2.7** | Mathematische Anschlussstruktur für das FRZK | Verdichtete Synthese: Welche mathematischen Strukturen stehen Kapitel 3.3 zur Verfügung, welche Voraussetzungen tragen sie und welche Aussagen folgen gerade noch nicht aus der Mathematik. | neu zu synthetisieren |

### Grundregel der Neugliederung

Die alte Abschnittsstruktur ist eine **Quellstruktur**, keine unveränderliche Zielstruktur. Die 131 Haupttextobjekte werden im neuen Haupttext logisch neu angeordnet. Ihre Herkunft muss trotzdem über `repository_objects`, Kandidatenregister, Source-Line/Source-Number und gegebenenfalls eine spätere Placement-/Lineage-Struktur erhalten bleiben.

## 6. Erforderliche DB-Platzierungsschicht für den neuen Haupttext

Die bestehende Spalte `repository_objects.section_id` bezeichnet in Revision 5 die Herkunft aus der Quellfassung. Sie darf bei der Kompression **nicht einfach auf den neuen Zielabschnitt umgeschrieben werden**, weil dadurch Provenienz verloren ginge. Nach den Anlagen soll die neueste DB deshalb eine explizite Haupttext-Platzierungsschicht besitzen. Falls sie noch nicht existiert, ist vor dem ersten kanonischen 3.2-Abschnitt eine Repository-Revision mit mindestens folgender Funktion einzuführen:

```sql
CREATE TABLE main_text_object_placements (
  placement_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  repo_object_id BIGINT UNSIGNED NOT NULL,
  target_section_id BIGINT UNSIGNED NOT NULL,
  placement_order DECIMAL(12,4) NOT NULL,
  placement_role ENUM('primary','supporting','reference') NOT NULL,
  source_section_code VARCHAR(50) NULL,
  placement_status ENUM('proposed','accepted','superseded') NOT NULL DEFAULT 'proposed',
  rationale LONGTEXT NULL,
  created_revision_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (placement_id),
  UNIQUE KEY uq_main_object_target (repo_object_id, target_section_id),
  FOREIGN KEY (repo_object_id) REFERENCES repository_objects(repo_object_id),
  FOREIGN KEY (target_section_id) REFERENCES dissertation_sections(section_id),
  FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE section_lineage (
  section_lineage_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  source_section_id BIGINT UNSIGNED NOT NULL,
  target_section_id BIGINT UNSIGNED NOT NULL,
  lineage_type ENUM('retained','merged_into','split_into','superseded_by','synthesized_from') NOT NULL,
  note LONGTEXT NULL,
  created_revision_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (section_lineage_id),
  UNIQUE KEY uq_section_lineage (source_section_id, target_section_id, lineage_type),
  FOREIGN KEY (source_section_id) REFERENCES dissertation_sections(section_id),
  FOREIGN KEY (target_section_id) REFERENCES dissertation_sections(section_id),
  FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

Wenn die nach den Anlagen erzeugte DB diese Funktion bereits anders implementiert, darf **keine zweite Parallelstruktur** angelegt werden. Dann ist die bestehende aktuelle Struktur zu verwenden.

## 7. Kanonischer Arbeitsablauf je Haupttextabschnitt

1. Neueste DB laden und Revision/Gates prüfen.
2. Für den Zielabschnitt alle `main_text`-Objekte bestimmen und über ihre Herkunft, Profilklassifikation und downstream requirements prüfen.
3. Finale Anlagenanker ermitteln, die für ausgelagerte Vertiefungen benötigt werden.
4. Literaturverwendungen des Zielabschnitts aus `source_usage`, `source_research_evidence` und den finalen Evidenzlinks ableiten.
5. Abschnitt neu formulieren; nicht bloß Quelltext kürzen.
6. Nur Definitionen/Sätze/Gleichungen in den Haupttext übernehmen, die für den mathematischen Hauptpfad erforderlich sind.
7. Ausgelagerte Details nur mit präzisem Anlagenverweis erwähnen, nicht erneut vollständig entwickeln.
8. Jede sichtbare mathematische Definition/Gleichung/Satzaussage mit dem Repository abgleichen; neue Nummern erst innerhalb der neuen Gliederung vergeben.
9. Bei einer kanonischen Formel unmittelbar darunter `Word-LaTeX: …` ausgeben.
10. Neue oder geänderte kanonische Objekte in `definitions`, `equations`, `theorems`/`lemmas`/`corollaries`/`propositions` sowie Abhängigkeitstabellen schreiben.
11. Den vollständigen Abschnitt in `section_versions` mit Checksumme und Revision speichern.
12. Placement-, Source-, Citation-, Dependency- und Requirement-Relationen aktualisieren.
13. SQL gegen eine aus dem maßgeblichen Dump rekonstruierte Testdatenbank beziehungsweise ein äquivalentes Testschema ausführen, einschließlich Procedure-Aufrufen, Transaktion, Post-Gates und Validierungsabfragen.
14. Erst bei PASS den Abschnitt als freigegeben behandeln und mit dem nächsten Abschnitt fortfahren.

## 8. Semantik der Haupttextklassifikation

### `document_location`

- `main_text`: Gegenstand gehört in den komprimierten Argumentationspfad von Kapitel 3.2.
- `appendix`: Gegenstand bleibt mathematisch vollständig in M1–M6 und wird im Haupttext höchstens referenziert.

### `importance_level`

- `core`: unverzichtbar für Begriffs- oder Ableitungsstruktur und grundsätzlich im Haupttext zu erhalten.
- `supporting`: unterstützt den Hauptpfad; nur so ausführlich wie nötig.
- `derivation`: Herleitung/Beweisschritt; gehört in die Anlagen.
- `example`: Beispiel/Rechnung; gehört in die Anlagen.

### `equation_role`

- `canonical`: eigenständige Hauptgleichung, die später referenziert werden kann.
- `derived`: mathematisch abgeleitet; regelmäßig Anlagenmaterial, außer eine spätere Abhängigkeit verlangt sie ausdrücklich.
- `proof_step`: ausschließlich Herleitung/Beweisschritt.
- `example`: ausschließlich Beispielrechnung.

### `required_for_section_code`

Revision 5 enthält für Haupttextobjekte zunächst nur die grobe Zielbeziehung `3.3`. Nach Vorliegen der endgültigen 3.3-Struktur soll diese Relation auf konkrete Unterabschnitte (`3.3.x`) präzisiert werden. Es dürfen keine fiktiven 3.3.x-Ziele erfunden werden.

## 9. Literatur- und Zitierlogik

Für den Haupttext gilt dieselbe strenge Evidenzlogik wie für die Anlagen. Eine Literaturangabe darf nur dann verwendet werden, wenn die konkrete Aussage durch eine gespeicherte Evidenz gedeckt ist. Der Haupttext darf den Claim einer Quelle **nicht erweitern**, nur weil das Werk thematisch passt.

Die ursprünglichen provisorischen Ziffern `[10]` und `[13]` werden nicht als neue kanonische Quellen fortgeführt. Die aufgelöste Migrationslogik lautet `[10] → [74] Strang` und `[13] → [76] Reed/Simon`; die historische Herkunft bleibt in der Resolution-/Alias-Schicht nachvollziehbar.

Bei `[79] Kleene` besteht in der Ausgangslage ein bibliografischer Konflikt zur Verlagsangabe. Der Haupttext darf diese Quelle erst mit der in der neuesten DB tatsächlich freigegebenen bibliografischen Fassung verwenden.

## 10. Formel-, Gleichungs- und Word-LaTeX-Regeln

- Nur mathematisch selbstständige Aussagen erhalten eine Gleichungsnummer.
- Bloße Variablendeklarationen, Voraussetzungen und alternative Schreibweisen werden nicht künstlich nummeriert.
- Jede gerenderte Gleichung erhält unmittelbar in der nächsten Zeile `Word-LaTeX: …`.
- Mathematische Symbole und Variablen im normalen Fließtext erscheinen in runden Klammern als Word-LaTeX und nicht als gerenderte Inline-Formel.
- Die neue Gleichungszählung wird aus der neuen komprimierten Gliederung erzeugt; alte Quellnummern bleiben als Provenienzfelder erhalten und werden nicht stillschweigend zur neuen Nummer.
- Anlagen-Gleichungen behalten ihre Anlagenanker/Anlagennummern und werden nicht in die Haupttext-Gleichungszählung eingezogen.
- Die bekannten Quellfehler der importierten Fassung – u. a. fehlende/unklare Nummerierung bei (3.49)/(3.50), Sprung bei (3.73), beschädigte (3.173) sowie fast vollständig fehlende `Word-LaTeX:`-Zeilen – dürfen nicht ungeprüft übernommen werden.

## 11. Schreib- und Inhaltsregeln für Kapitel 3.2

- Ich-Form und wissenschaftlicher Fließtext.
- Zusammenhängende Absätze; alleinstehende Sätze nur sparsam für echte Kernhinweise.
- Keine Chat-, Bearbeitungs- oder Fortsetzungsreste im Dissertationstext.
- Keine Aussagen wie „im Originalabschnitt“, „in der früheren Fassung“ oder Hinweise auf das Überarbeitungsverfahren.
- Keine redundante Wiederholung derselben methodischen Warnung bei jedem mathematischen Begriff.
- Die zentrale methodische Trennung – mathematische Struktur ist nicht automatisch physikalische/FRZK-spezifische Interpretation – wird in 3.2.0 verbindlich etabliert und in 3.2.7 systematisch zusammengeführt.
- Beispiele, vollständige Standardherleitungen, Übungsrechnungen und didaktische Vertiefungen stehen in den Anlagen.
- Im Haupttext verbleiben Definitionen und Sätze, die Kapitel 3.3 tatsächlich voraussetzt.
- Keine konkrete FRZK-Praxisanwendung; diese gehört in Kapitel 6.
- Literaturquellen im Fließtext ohne Weblinks; Erstnennung/weitere Nennung gemäß dem verbindlichen Dissertationszitationssystem.

## 12. DB-Modell – vollständige relevante Tabellenfelder der Ausgangsbasis

> Die folgenden Schemata stammen aus der Revision-5-Ausgangsdatenbank. Nach den Anlagen ist jeweils die neueste DB zu prüfen. Spätere Schemaerweiterungen haben Vorrang.

### Tabelle `dissertation_sections`

```sql
CREATE TABLE `dissertation_sections` (
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `parent_section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `section_code` varchar(50) NOT NULL,
  `title` varchar(500) NOT NULL,
  `chapter_no` int(11) NOT NULL,
  `section_order` decimal(10,4) NOT NULL,
  `status` enum('planned','draft','review','final') NOT NULL DEFAULT 'planned',
  `is_original_contribution` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `section_versions`

```sql
CREATE TABLE `section_versions` (
  `section_version_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` bigint(20) unsigned NOT NULL,
  `revision_id` bigint(20) unsigned NOT NULL,
  `version_kind` enum('source_import','rewrite','review','final') NOT NULL,
  `body_markdown` longtext NOT NULL,
  `checksum_sha256` char(64) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`section_version_id`),
  UNIQUE KEY `uq_section_version` (`section_id`,`revision_id`,`version_kind`),
  CONSTRAINT `fk_section_versions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_section_versions_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `documents`

```sql
CREATE TABLE `documents` (
  `document_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `file_name` varchar(500) DEFAULT NULL,
  `document_type` enum('dissertation','chapter','article','book','dataset','appendix','other') NOT NULL DEFAULT 'other',
  `version_label` varchar(100) DEFAULT NULL,
  `file_path` varchar(1000) DEFAULT NULL,
  `checksum_sha256` char(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `repository_revisions`

```sql
CREATE TABLE `repository_revisions` (
  `revision_id` bigint(20) UNSIGNED NOT NULL,
  `revision_code` varchar(100) NOT NULL,
  `revision_date` datetime NOT NULL,
  `scope_type` enum('repository','chapter','section','source','equation','definition','statement','figure','table','symbol','acronym','axiom','assumption','proof','proposition') NOT NULL,
  `scope_reference` varchar(255) DEFAULT NULL,
  `version_label` varchar(100) NOT NULL,
  `summary` text NOT NULL,
  `created_by` varchar(255) DEFAULT 'Olaf Thiele / ChatGPT',
  `parent_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `repository_validation_results`

```sql
CREATE TABLE `repository_validation_results` (
  `validation_result_id` bigint(20) UNSIGNED NOT NULL,
  `revision_id` bigint(20) UNSIGNED NOT NULL,
  `validation_code` varchar(100) NOT NULL,
  `validation_status` enum('passed','warning','failed') NOT NULL,
  `expected_value` varchar(255) DEFAULT NULL,
  `actual_value` varchar(255) DEFAULT NULL,
  `validation_message` text NOT NULL,
  `checked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `revision_issues`

```sql
CREATE TABLE `revision_issues` (
  `issue_id` bigint(20) unsigned NOT NULL,
  `severity` enum('info','low','medium','high','critical') NOT NULL,
  `issue_category` varchar(100) NOT NULL,
  `object_reference` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `required_action` longtext NOT NULL,
  `issue_status` enum('open','in_progress','resolved','accepted') NOT NULL DEFAULT 'open',
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `idx_issue_status` (`issue_status`,`severity`),
  CONSTRAINT `fk_revision_issue_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `appendix_modules`

```sql
CREATE TABLE `appendix_modules` (
  `appendix_module_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `appendix_code` varchar(20) NOT NULL,
  `title` varchar(500) NOT NULL,
  `purpose` longtext NOT NULL,
  `sort_order` int(11) NOT NULL,
  `status` enum('planned','draft','review','final') NOT NULL DEFAULT 'planned',
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`appendix_module_id`),
  UNIQUE KEY `uq_appendix_code` (`appendix_code`),
  CONSTRAINT `fk_appendix_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `repository_objects`

```sql
CREATE TABLE `repository_objects` (
  `repo_object_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_scope` enum('candidate','canonical') NOT NULL,
  `object_type` enum('definition','statement','equation','theorem','lemma','corollary','proposition','proof','axiom','assumption','figure','table','symbol','other') NOT NULL,
  `source_table` varchar(64) NOT NULL,
  `source_pk` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `object_label` varchar(255) NOT NULL,
  `object_title` varchar(500) DEFAULT NULL,
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`repo_object_id`),
  UNIQUE KEY `uq_repository_object_source` (`source_table`,`source_pk`),
  KEY `idx_repository_object_section` (`section_id`,`object_type`),
  CONSTRAINT `fk_repo_object_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_repo_object_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `mathematical_object_profiles`

```sql
CREATE TABLE `mathematical_object_profiles` (
  `repo_object_id` bigint(20) unsigned NOT NULL,
  `document_location` enum('main_text','appendix') NOT NULL,
  `importance_level` enum('core','supporting','derivation','example') NOT NULL,
  `equation_role` enum('canonical','derived','proof_step','example') DEFAULT NULL,
  `appendix_module_id` bigint(20) unsigned DEFAULT NULL,
  `appendix_anchor` varchar(100) DEFAULT NULL,
  `classification_reason` longtext NOT NULL,
  `classification_status` enum('proposed','reviewed','approved') NOT NULL DEFAULT 'proposed',
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`repo_object_id`),
  UNIQUE KEY `uq_appendix_anchor` (`appendix_anchor`),
  KEY `idx_math_profile_location` (`document_location`,`importance_level`),
  KEY `idx_math_profile_module` (`appendix_module_id`),
  CONSTRAINT `fk_math_profile_object` FOREIGN KEY (`repo_object_id`) REFERENCES `repository_objects` (`repo_object_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_math_profile_appendix` FOREIGN KEY (`appendix_module_id`) REFERENCES `appendix_modules` (`appendix_module_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_math_profile_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_math_profile_location` CHECK ((`document_location`='main_text' AND `appendix_module_id` IS NULL AND `appendix_anchor` IS NULL) OR (`document_location`='appendix' AND `appendix_module_id` IS NOT NULL AND `appendix_anchor` IS NOT NULL)),
  CONSTRAINT `chk_math_profile_main_importance` CHECK (NOT (`document_location`='main_text' AND `importance_level` IN ('derivation','example'))),
  CONSTRAINT `chk_math_profile_main_equation_role` CHECK (NOT (`document_location`='main_text' AND `equation_role` IN ('proof_step','example')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `object_section_requirements`

```sql
CREATE TABLE `object_section_requirements` (
  `requirement_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `repo_object_id` bigint(20) unsigned NOT NULL,
  `required_for_section_code` varchar(50) NOT NULL,
  `required_for_section_id` bigint(20) unsigned DEFAULT NULL,
  `requirement_type` enum('required','supporting','methodological','notation') NOT NULL DEFAULT 'required',
  `rationale` longtext NOT NULL,
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`requirement_id`),
  UNIQUE KEY `uq_object_requirement` (`repo_object_id`,`required_for_section_code`,`requirement_type`),
  KEY `idx_requirement_target` (`required_for_section_code`,`requirement_type`),
  CONSTRAINT `fk_requirement_object` FOREIGN KEY (`repo_object_id`) REFERENCES `repository_objects` (`repo_object_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_requirement_section` FOREIGN KEY (`required_for_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_requirement_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `definition_candidates`

```sql
CREATE TABLE `definition_candidates` (
  `definition_candidate_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `source_definition_number` varchar(50) NOT NULL,
  `proposed_definition_number` varchar(50) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `source_text` longtext NOT NULL,
  `proposed_text` longtext DEFAULT NULL,
  `formal_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `provenance` enum('literature','adapted','original','mixed','needs_review') NOT NULL DEFAULT 'needs_review',
  `candidate_status` enum('source_import','rewrite','accepted','rejected','superseded') NOT NULL DEFAULT 'source_import',
  `notes` longtext DEFAULT NULL,
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`definition_candidate_id`),
  UNIQUE KEY `uq_def_candidate_source_no` (`source_definition_number`),
  CONSTRAINT `fk_def_candidate_document` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_def_candidate_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_def_candidate_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `statement_candidates`

```sql
CREATE TABLE `statement_candidates` (
  `statement_candidate_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `statement_kind` enum('theorem','lemma','corollary','proposition','criterion','inequality','theorem_reference','procedure_theorem','other') NOT NULL,
  `source_heading` varchar(500) NOT NULL,
  `proposed_statement_number` varchar(50) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `source_text` longtext NOT NULL,
  `proposed_text` longtext DEFAULT NULL,
  `formal_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `provenance` enum('literature','adapted','original','mixed','needs_review') NOT NULL DEFAULT 'needs_review',
  `classification_status` enum('candidate','accepted','rejected','superseded') NOT NULL DEFAULT 'candidate',
  `notes` longtext DEFAULT NULL,
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`statement_candidate_id`),
  CONSTRAINT `fk_stmt_candidate_document` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stmt_candidate_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stmt_candidate_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `equation_candidates`

```sql
CREATE TABLE `equation_candidates` (
  `equation_candidate_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `source_equation_number` varchar(50) NOT NULL,
  `proposed_equation_number` varchar(50) DEFAULT NULL,
  `source_line_no` int(10) unsigned DEFAULT NULL,
  `number_origin` enum('explicit','source_context','context_inferred') NOT NULL DEFAULT 'explicit',
  `source_latex` longtext NOT NULL,
  `source_word_latex` longtext DEFAULT NULL,
  `proposed_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `plain_description` longtext DEFAULT NULL,
  `equation_type` varchar(50) NOT NULL DEFAULT 'needs_review',
  `provenance` enum('literature','adapted','original','mixed','needs_review') NOT NULL DEFAULT 'needs_review',
  `source_integrity_status` enum('ok','number_missing','formula_broken','needs_review') NOT NULL DEFAULT 'ok',
  `candidate_status` enum('source_import','rewrite','accepted','rejected','superseded') NOT NULL DEFAULT 'source_import',
  `notes` longtext DEFAULT NULL,
  `created_revision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`equation_candidate_id`),
  UNIQUE KEY `uq_eq_candidate_source_no` (`source_equation_number`),
  CONSTRAINT `fk_eq_candidate_document` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_eq_candidate_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_eq_candidate_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `definitions`

```sql
CREATE TABLE `definitions` (
  `definition_id` bigint(20) UNSIGNED NOT NULL,
  `definition_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `definition_text` longtext NOT NULL,
  `formal_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'original',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assumptions` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `equations`

```sql
CREATE TABLE `equations` (
  `equation_id` bigint(20) UNSIGNED NOT NULL,
  `equation_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `equation_latex` text NOT NULL,
  `word_latex` text NOT NULL,
  `plain_description` text NOT NULL,
  `equation_type` enum('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL DEFAULT 'other',
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'original',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `derivation` text DEFAULT NULL,
  `assumptions` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `theorems`

```sql
CREATE TABLE `theorems` (
  `theorem_id` bigint(20) UNSIGNED NOT NULL,
  `theorem_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `statement_text` longtext NOT NULL,
  `statement_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'literature',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assumptions` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `lemmas`

```sql
CREATE TABLE `lemmas` (
  `lemma_id` bigint(20) UNSIGNED NOT NULL,
  `lemma_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `statement_text` longtext NOT NULL,
  `statement_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'literature',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assumptions` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `corollaries`

```sql
CREATE TABLE `corollaries` (
  `corollary_id` bigint(20) UNSIGNED NOT NULL,
  `corollary_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `statement_text` longtext NOT NULL,
  `statement_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `parent_theorem_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_lemma_id` bigint(20) UNSIGNED DEFAULT NULL,
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'literature',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `propositions`

```sql
CREATE TABLE `propositions` (
  `proposition_id` bigint(20) UNSIGNED NOT NULL,
  `proposition_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `statement_text` longtext NOT NULL,
  `statement_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `logical_derivation` longtext NOT NULL,
  `based_on_axioms` varchar(255) DEFAULT NULL,
  `status` enum('draft','review','accepted','revised','rejected') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `proofs`

```sql
CREATE TABLE `proofs` (
  `proof_id` bigint(20) UNSIGNED NOT NULL,
  `proof_number` varchar(50) DEFAULT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `theorem_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lemma_id` bigint(20) UNSIGNED DEFAULT NULL,
  `corollary_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `proof_text` longtext NOT NULL,
  `proof_latex` longtext DEFAULT NULL,
  `proof_method` enum('direct','contradiction','induction','construction','equivalence','existence','uniqueness','computational','other') NOT NULL DEFAULT 'direct',
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'original',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `symbols`

```sql
CREATE TABLE `symbols` (
  `symbol_id` bigint(20) UNSIGNED NOT NULL,
  `symbol_latex` varchar(255) NOT NULL,
  `symbol_word_latex` varchar(255) NOT NULL,
  `symbol_name` varchar(255) NOT NULL,
  `definition_text` longtext NOT NULL,
  `scope_type` enum('global','chapter','section','equation') NOT NULL DEFAULT 'global',
  `first_section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `first_equation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_text` varchar(255) DEFAULT NULL,
  `domain_text` varchar(1000) DEFAULT NULL,
  `codomain_text` varchar(1000) DEFAULT NULL,
  `is_vector` tinyint(1) NOT NULL DEFAULT 0,
  `is_matrix` tinyint(1) NOT NULL DEFAULT 0,
  `is_operator` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `equation_dependencies`

```sql
CREATE TABLE `equation_dependencies` (
  `dependency_id` bigint(20) UNSIGNED NOT NULL,
  `equation_id` bigint(20) UNSIGNED NOT NULL,
  `depends_on_equation_id` bigint(20) UNSIGNED NOT NULL,
  `dependency_type` enum('derived_from','uses','special_case_of','generalizes','validates','contrasts') NOT NULL,
  `dependency_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `equation_symbols`

```sql
CREATE TABLE `equation_symbols` (
  `equation_symbol_id` bigint(20) UNSIGNED NOT NULL,
  `equation_id` bigint(20) UNSIGNED NOT NULL,
  `symbol_latex` varchar(255) NOT NULL,
  `symbol_name` varchar(255) NOT NULL,
  `definition_text` text NOT NULL,
  `unit_text` varchar(255) DEFAULT NULL,
  `domain_text` varchar(500) DEFAULT NULL,
  `symbol_order` smallint(5) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `object_dependencies`

```sql
CREATE TABLE `object_dependencies` (
  `object_dependency_id` bigint(20) UNSIGNED NOT NULL,
  `object_type_from` enum('definition','theorem','lemma','corollary','proof','equation','assumption','axiom','figure','table') NOT NULL,
  `object_id_from` bigint(20) UNSIGNED NOT NULL,
  `object_type_to` enum('definition','theorem','lemma','corollary','proof','equation','assumption','axiom','figure','table') NOT NULL,
  `object_id_to` bigint(20) UNSIGNED NOT NULL,
  `dependency_type` enum('depends_on','derives_from','supports','contrasts','generalizes','specializes','validates') NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `object_source_links`

```sql
CREATE TABLE `object_source_links` (
  `object_source_link_id` bigint(20) UNSIGNED NOT NULL,
  `object_type` enum('definition','theorem','lemma','corollary','proof','proposition','equation','figure','table','symbol','acronym','assumption','axiom') NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `usage_type` enum('primary_source','supporting_source','adapted_from','contrasts','historical_context','verification') NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `authors`

```sql
CREATE TABLE `authors` (
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `family_name` varchar(255) NOT NULL,
  `given_names` varchar(255) DEFAULT NULL,
  `normalized_name` varchar(500) NOT NULL,
  `orcid` varchar(50) DEFAULT NULL,
  `birth_year` smallint(6) DEFAULT NULL,
  `death_year` smallint(6) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `sources`

```sql
CREATE TABLE `sources` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `citation_number` int(10) UNSIGNED DEFAULT NULL,
  `source_key` varchar(150) NOT NULL,
  `source_type` enum('journal_article','book','book_chapter','conference_paper','thesis','report','standard','website','historical_work','edited_volume','other') NOT NULL,
  `title` varchar(1000) NOT NULL,
  `subtitle` varchar(1000) DEFAULT NULL,
  `year_original` smallint(6) DEFAULT NULL,
  `year_edition` smallint(6) DEFAULT NULL,
  `journal` varchar(500) DEFAULT NULL,
  `publisher` varchar(500) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `volume` varchar(100) DEFAULT NULL,
  `issue` varchar(100) DEFAULT NULL,
  `pages` varchar(100) DEFAULT NULL,
  `edition` varchar(100) DEFAULT NULL,
  `doi` varchar(255) DEFAULT NULL,
  `isbn` varchar(100) DEFAULT NULL,
  `url` varchar(1500) DEFAULT NULL,
  `language_code` char(2) DEFAULT 'de',
  `priority` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `evidence_type` enum('primary','secondary','review','textbook','historical','reference') NOT NULL DEFAULT 'secondary',
  `frzk_relevance` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `verification_status` enum('imported','partially_verified','verified','needs_review') NOT NULL DEFAULT 'imported',
  `first_citation_section_code` varchar(50) DEFAULT NULL,
  `first_citation_note` text DEFAULT NULL,
  `full_citation_text` text NOT NULL,
  `short_citation_text` varchar(500) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `source_authors`

```sql
CREATE TABLE `source_authors` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `author_order` smallint(5) UNSIGNED NOT NULL,
  `role` enum('author','editor','translator') NOT NULL DEFAULT 'author'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `source_usage`

```sql
CREATE TABLE `source_usage` (
  `usage_id` bigint(20) UNSIGNED NOT NULL,
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `usage_type` enum('first_citation','background','definition','theorem','method','historical_context','state_of_research','critique','research_gap','comparison','equation_source','figure_source','table_source','other') NOT NULL,
  `claim_summary` text NOT NULL,
  `exact_location` varchar(255) DEFAULT NULL,
  `source_excerpt` longtext DEFAULT NULL,
  `source_excerpt_language` char(2) DEFAULT NULL,
  `source_excerpt_translation` longtext DEFAULT NULL,
  `is_first_mention` tinyint(1) NOT NULL DEFAULT 0,
  `citation_checked` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `source_usage_audit`

```sql
CREATE TABLE `source_usage_audit` (
  `usage_id` bigint(20) unsigned NOT NULL,
  `original_citation_number` int(10) unsigned NOT NULL,
  `occurrence_count` int(10) unsigned NOT NULL DEFAULT 0,
  `original_usage_type` varchar(50) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`usage_id`),
  KEY `idx_usage_audit_citation` (`original_citation_number`),
  CONSTRAINT `fk_usage_audit_usage` FOREIGN KEY (`usage_id`) REFERENCES `source_usage` (`usage_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `source_research_registry`

```sql
CREATE TABLE `source_research_registry` (
  `source_id` bigint(20) unsigned NOT NULL,
  `citation_number` int(10) unsigned NOT NULL,
  `verified_citation_text` longtext NOT NULL,
  `metadata_status` enum('verified','partial','conflict','needs_review') NOT NULL,
  `primary_url` varchar(2048) NOT NULL,
  `secondary_url` varchar(2048) DEFAULT NULL,
  `accessed_on` date NOT NULL,
  `research_notes` longtext DEFAULT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE KEY `uq_research_registry_citation` (`citation_number`),
  CONSTRAINT `fk_research_registry_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `source_research_evidence`

```sql
CREATE TABLE `source_research_evidence` (
  `evidence_id` bigint(20) unsigned NOT NULL,
  `source_usage_id` bigint(20) unsigned NOT NULL,
  `canonical_source_id` bigint(20) unsigned NOT NULL,
  `canonical_citation_number` int(10) unsigned NOT NULL,
  `evidence_mode` enum('direct_quote','location_paraphrase','replacement_location') NOT NULL,
  `support_fit` enum('direct','supporting','partial','replacement') NOT NULL,
  `claim_supported` longtext NOT NULL,
  `exact_location` varchar(1200) NOT NULL,
  `text_anchor` varchar(1200) NOT NULL,
  `paraphrased_evidence` longtext NOT NULL,
  `verbatim_excerpt` varchar(1000) DEFAULT NULL,
  `source_url` varchar(2048) NOT NULL,
  `verification_url` varchar(2048) DEFAULT NULL,
  `source_class` varchar(100) NOT NULL,
  `verification_status` enum('verified','partial','needs_review') NOT NULL,
  `copyright_status` enum('location_only','short_quote_verified','no_quote') NOT NULL,
  `accessed_on` date NOT NULL,
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`evidence_id`),
  KEY `idx_research_evidence_usage` (`source_usage_id`),
  KEY `idx_research_evidence_source` (`canonical_source_id`),
  CONSTRAINT `fk_research_evidence_usage` FOREIGN KEY (`source_usage_id`) REFERENCES `source_usage` (`usage_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_research_evidence_source` FOREIGN KEY (`canonical_source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `citation_occurrences`

```sql
CREATE TABLE `citation_occurrences` (
  `citation_occurrence_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `source_citation_number` int(10) unsigned NOT NULL,
  `citation_group_text` varchar(255) NOT NULL,
  `source_line_no` int(10) unsigned DEFAULT NULL,
  `context_text` longtext NOT NULL,
  `validation_status` enum('resolved','unresolved','needs_review') NOT NULL DEFAULT 'needs_review',
  PRIMARY KEY (`citation_occurrence_id`),
  KEY `idx_citation_occ_section` (`section_id`),
  KEY `idx_citation_occ_source` (`source_id`),
  CONSTRAINT `fk_citation_occ_document` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_citation_occ_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_citation_occ_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `citation_resolutions`

```sql
CREATE TABLE `citation_resolutions` (
  `citation_occurrence_id` bigint(20) unsigned NOT NULL,
  `original_citation_number` int(10) unsigned NOT NULL,
  `canonical_source_id` bigint(20) unsigned DEFAULT NULL,
  `canonical_citation_number` int(10) unsigned DEFAULT NULL,
  `resolution_type` enum('same','replaced','unresolved') NOT NULL,
  `resolution_reason` longtext DEFAULT NULL,
  `verification_status` enum('verified','needs_review') NOT NULL DEFAULT 'verified',
  PRIMARY KEY (`citation_occurrence_id`),
  KEY `idx_citation_resolution_source` (`canonical_source_id`),
  CONSTRAINT `fk_citation_resolution_occ` FOREIGN KEY (`citation_occurrence_id`) REFERENCES `citation_occurrences` (`citation_occurrence_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_citation_resolution_source` FOREIGN KEY (`canonical_source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `citation_evidence_links`

```sql
CREATE TABLE `citation_evidence_links` (
  `citation_occurrence_id` bigint(20) unsigned NOT NULL,
  `evidence_id` bigint(20) unsigned NOT NULL,
  `link_status` enum('section_source_match','replacement_match','partial_support') NOT NULL,
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`citation_occurrence_id`,`evidence_id`),
  CONSTRAINT `fk_citation_evidence_occ` FOREIGN KEY (`citation_occurrence_id`) REFERENCES `citation_occurrences` (`citation_occurrence_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_citation_evidence_evidence` FOREIGN KEY (`evidence_id`) REFERENCES `source_research_evidence` (`evidence_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `quotations`

```sql
CREATE TABLE `quotations` (
  `quotation_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `quotation_text` longtext NOT NULL,
  `exact_location` varchar(1000) NOT NULL,
  `quotation_language` char(2) DEFAULT NULL,
  `verification_status` enum('unverified','checked','verified') NOT NULL DEFAULT 'unverified',
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`quotation_id`),
  CONSTRAINT `fk_quotation_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_quotation_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Tabelle `citation_aliases`

```sql
CREATE TABLE `citation_aliases` (
  `citation_alias_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_citation_number` int(10) unsigned NOT NULL,
  `source_id` bigint(20) unsigned DEFAULT NULL,
  `status` enum('resolved','unresolved','superseded') NOT NULL DEFAULT 'unresolved',
  `resolution_note` longtext DEFAULT NULL,
  PRIMARY KEY (`citation_alias_id`),
  UNIQUE KEY `uq_citation_alias_number` (`source_citation_number`),
  KEY `idx_citation_alias_source` (`source_id`),
  CONSTRAINT `fk_citation_alias_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## 13. Erwartete Anlagen-Textstruktur nach ihrer Realisierung

Der Haupttext-Chat setzt voraus, dass die Anlagen mindestens semantisch folgende drei Tabellen besitzen. Wenn der Anlagen-Chat diese Struktur äquivalent anders umgesetzt hat, gilt die tatsächliche neueste DB.

```sql
CREATE TABLE appendix_sections (
  appendix_section_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  appendix_module_id BIGINT UNSIGNED NOT NULL,
  parent_appendix_section_id BIGINT UNSIGNED NULL,
  section_code VARCHAR(50) NOT NULL,
  title VARCHAR(500) NOT NULL,
  sort_order DECIMAL(12,4) NOT NULL,
  status ENUM('planned','draft','review','final') NOT NULL DEFAULT 'planned',
  notes LONGTEXT NULL,
  created_revision_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (appendix_section_id),
  UNIQUE KEY uq_appendix_section_code (section_code),
  FOREIGN KEY (appendix_module_id) REFERENCES appendix_modules(appendix_module_id),
  FOREIGN KEY (parent_appendix_section_id) REFERENCES appendix_sections(appendix_section_id),
  FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE appendix_section_versions (
  appendix_section_version_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  appendix_section_id BIGINT UNSIGNED NOT NULL,
  revision_id BIGINT UNSIGNED NOT NULL,
  version_kind ENUM('draft','review','final','superseded') NOT NULL,
  body_markdown LONGTEXT NOT NULL,
  checksum_sha256 CHAR(64) NOT NULL,
  notes LONGTEXT NULL,
  PRIMARY KEY (appendix_section_version_id),
  UNIQUE KEY uq_appendix_section_revision (appendix_section_id, revision_id),
  FOREIGN KEY (appendix_section_id) REFERENCES appendix_sections(appendix_section_id),
  FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE appendix_object_placements (
  placement_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  appendix_section_id BIGINT UNSIGNED NOT NULL,
  repo_object_id BIGINT UNSIGNED NOT NULL,
  placement_order DECIMAL(12,4) NOT NULL,
  placement_role ENUM('primary','supporting','derivation','example','reference') NOT NULL,
  created_revision_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (placement_id),
  UNIQUE KEY uq_appendix_object_placement (appendix_section_id, repo_object_id),
  FOREIGN KEY (appendix_section_id) REFERENCES appendix_sections(appendix_section_id),
  FOREIGN KEY (repo_object_id) REFERENCES repository_objects(repo_object_id),
  FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## 14. Erforderliche Views und Gates

Mindestens folgende bereits vorgesehene oder semantisch äquivalente Views sind beim Schreiben zu verwenden:

- `v_math_main_text_inventory`
- `v_math_appendix_inventory`
- `v_math_required_for_sections`
- `v_math_compression_gate`
- `v_chapter_bibliography`
- `v_citation_audit`
- `v_definition_register`
- `v_equation_register`
- `v_statement_register`
- `v_section_inventory`

### Mindest-Gates für den Haupttext

- `PROFILE_COVERAGE`: jedes mathematische Repository-Objekt besitzt genau ein Profil.
- `MAIN_NO_DERIVATION_EXAMPLE`: kein reines Herleitungs-/Beispielobjekt liegt im Haupttext.
- `APPENDIX_FULLY_REFERENCED`: jedes ausgelagerte Objekt ist in einer finalen Anlage auflösbar.
- `MAIN_HAS_DOWNSTREAM_REQUIREMENT`: jeder im Haupttext verbliebene mathematische Gegenstand besitzt einen dokumentierten späteren Zweck.
- `EQUATION_ROLE_COMPLETE`: jede Gleichung besitzt eine Rolle.
- `NON_EQUATION_ROLE_NULL`: nur Gleichungen tragen `equation_role`.
- Keine ungeprüfte Literaturzitation im finalen Abschnitt.
- Keine kanonische Gleichung ohne `word_latex`.
- Keine finale Definition/Satzaussage ohne Provenienz-/Quellenentscheidung.
- Keine Zielabschnitt-Platzierung ohne erhaltene Quellprovenienz.
- Keine offene `blocker`-/`critical`-Issue für den gerade freizugebenden Abschnitt.

## 15. Haupttextobjekte – vollständiges technisches Inventar der Revision-5-Ausgangslage

Die folgenden **131 Objekte** sind in Revision 5 als `main_text` klassifiziert. Nach Abschluss der Anlagen muss jedes Objekt gegen die neueste DB geprüft werden; die Liste ist Ausgangs- und Revisionsnachweis, nicht die Erlaubnis, veraltete Kandidatentexte unverändert zu übernehmen.

### 3.2.0 – Mathematische Grundlegung und Abgrenzung

Zweck von Kapitel 3.2; Trennung zwischen etablierter Mathematik und FRZK-Eigenleistung; verbindliche Rolle der Anlagen; mathematischer Hauptpfad zu Kapitel 3.3.

Die Einleitung besitzt in der Revision-5-Objektklassifikation keine eigenen mathematischen Repository-Objekte; ihr Quelltext liegt in `section_versions` und wird vollständig neu verdichtet.

### 3.2.1 – Mengen, Relationen und Funktionen

**Zweck:** Kanonischer Grundbestand zu Menge, Relation, Funktion, Bild/Urbild sowie Injektivität, Surjektivität und Bijektivität; Detailmaterial verweist auf M1.

**Ausgangsobjekte:** 17

| repo_object_id | Typ | Herkunft | Quelllabel | Titel | importance | equation_role | downstream |
|---:|---|---|---|---|---|---|---|
| 1 | definition | 3.2.1 | Definition 3.2.1 | Menge und Element | core |  | 3.3 |
| 2 | definition | 3.2.1 | Definition 3.2.2 | Binäre Relation | core |  | 3.3 |
| 3 | definition | 3.2.2 | Definition 3.2.3 | Funktion | core |  | 3.3 |
| 43 | equation | 3.2.1 | (3.1) | Definition 3.2.1: Menge und Element | core | canonical | 3.3 |
| 44 | equation | 3.2.1 | (3.2) | Definition 3.2.1: Menge und Element | core | canonical | 3.3 |
| 45 | equation | 3.2.1 | (3.3) | Definition 3.2.1: Menge und Element | core | canonical | 3.3 |
| 46 | equation | 3.2.1 | (3.4) | Definition 3.2.1: Menge und Element | core | canonical | 3.3 |
| 47 | equation | 3.2.1 | (3.5) | Definition 3.2.1: Menge und Element | core | canonical | 3.3 |
| 48 | equation | 3.2.1 | (3.6) | Definition 3.2.1: Menge und Element | core | canonical | 3.3 |
| 64 | equation | 3.2.1 | (3.22) | Definition 3.2.2: Binäre Relation | core | canonical | 3.3 |
| 65 | equation | 3.2.1 | (3.23) | Definition 3.2.2: Binäre Relation | core | canonical | 3.3 |
| 66 | equation | 3.2.2 | (3.24) | Definition 3.2.3: Funktion | core | canonical | 3.3 |
| 67 | equation | 3.2.2 | (3.25) | Definition 3.2.3: Funktion | core | canonical | 3.3 |
| 71 | equation | 3.2.2 | (3.29) | Injektive Funktionen | supporting | canonical | 3.3 |
| 72 | equation | 3.2.2 | (3.30) | Surjektive Funktionen | supporting | canonical | 3.3 |
| 73 | equation | 3.2.2 | (3.31) | Bijektive Funktionen | supporting | canonical | 3.3 |
| 74 | equation | 3.2.2 | (3.32) | Bijektive Funktionen | supporting | canonical | 3.3 |

#### Quellpayloads

##### repo_object_id `1` — `Definition 3.2.1` — Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.1`

**Quelltext:**

Unter einer Menge $M$ verstehe ich zunächst eine formal bestimmte Zusammenfassung unterscheidbarer Objekte. Die zu $M$ gehörenden Objekte bezeichne ich als Elemente der Menge.

Die Zugehörigkeit eines Objekts $x$ zu einer Menge $M$ schreibe ich als

$x \\in \\, M$ (3.1)

Dabei ist $x$ das betrachtete Objekt und die Menge $M$, hinsichtlich derer ich die Zugehörigkeit prüfe.

Die Nichtzugehörigkeit schreibe ich entsprechend als

$x \\notin M$ (3.2)

Die Aussagen (3.1) und (3.2) legen ausschließlich fest, ob ein Objekt innerhalb der betrachteten Menge geführt wird. Sie bestimmen weder seine Eigenschaften noch seine Beziehungen zu anderen Elementen. Diese Unterscheidung ist für meine weitere Entwicklung wesentlich. Die Aufnahme eines Zustands in eine Zustandsmenge bedeutet noch nicht, dass seine innere Struktur, seine Ursache oder seine funktionale Bedeutung bereits erklärt wäre.

Eine endliche Menge kann ich durch die Aufzählung ihrer Elemente angeben. Für drei Elemente $a$, $b$ und $c$ schreibe ich beispielsweise

$M = \\text{\\{}a,b,c\\text{\\}}$ (3.3)

Dabei bezeichnet $M$ die betrachtete Menge; $a$, $b$ und $c$ sind ihre Elemente.

Die Reihenfolge der Elemente ist für eine Menge nicht von Bedeutung. Ebenso verändert eine wiederholte Nennung eines Elements die Menge nicht. Es gilt daher

$\\text{\\{}a,b,c\\text{\\}} = \\text{\\{}c,a,b\\text{\\}} = \\text{\\{}a,a,b,c\\text{\\}}$ (3.4)

An dieser Stelle wird bereits eine erste Grenze der Mengenbeschreibung sichtbar. Die Menge (3.3) enthält zwar die Elemente $a$, $b$ und $c$, sie enthält jedoch keine Information darüber, ob eines dieser Elemente zuerst oder zuletzt auftritt, ob ein Element gegenüber einem anderen hervorgehoben ist oder ob zwischen den Elementen eine bestimmte Wirkungsrichtung besteht. Eine Menge stellt damit zunächst eine Zusammenfassung bereit, aber noch keine Ordnung, Gewichtung oder Dynamik.

Neben der Aufzählung kann ich eine Menge durch eine Eigenschaft ihrer Elemente bestimmen. Die allgemeine Form lautet

$$M = \\text{\\{}x \\in U \\mid P(x)\\text{\\}}\\ (3.5)$$

Dabei ist $U$ die Grundmenge, aus der ich die Elemente auswähle. $P(x)$ bezeichnet eine Bedingung, die für jedes $x \\in U$ eindeutig erfüllt oder nicht erfüllt sein muss. Die Menge $M$ enthält genau diejenigen Elemente aus $U$, für die $P(x)$ gilt.

Ich halte die Grundmenge $U$ in (3.5) ausdrücklich fest, weil eine Auswahlbedingung niemals unabhängig von einem zugelassenen Ausgangsbereich wirkt. Wenn ich beispielsweise die Menge der geraden natürlichen Zahlen bestimme, muss zunächst feststehen, dass natürliche Zahlen betrachtet werden:

$$G = \\text{\\{}n \\in \\mathbb{N} \\mid \\exists k \\in \\mathbb{N}:n = 2k\\text{\\}}\\ (3.6)$$

Dabei bezeichnet $G$ die Menge der geraden natürlichen Zahlen, $n$ das jeweils betrachtete Element und $k$ eine natürliche Zahl, durch die die Geradheit von $n$ ausgedrückt wird.

Die Bedingung entscheidet innerhalb des Zahlenbereichs $\\mathbb{N}$, welche Elemente zu $G$ gehören. Würde ich einen anderen Grundbereich wählen, könnte dieselbe sprachliche Bedingung eine andere Menge bestimmen. Für meine weitere Modellbildung folgt daraus, dass die Festlegung eines zulässigen Objekt- oder Zustandsbereichs keine beiläufige Entscheidung ist. Sie bestimmt, welche Gegenstände innerhalb des Modells überhaupt auftreten können.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `2` — `Definition 3.2.2` — Binäre Relation

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.2`

**Quelltext:**

Eine binäre Relation $R$ zwischen den Mengen $A$ und $B$ ist eine Teilmenge ihres kartesischen Produkts:

$$R \\subseteq A \\times B\\ (3.22)$$

Dabei bezeichnet $R$ die Relation und $A \\times B$ die Menge aller formal möglichen geordneten Paare zwischen den beiden betrachteten Mengen.

Gilt $(a,b) \\in R$, schreibe ich auch

$$aRb \\Longleftrightarrow (a,b) \\in R\\ (3.23)$$

Dabei bedeutet $aRb$, dass das Element $a$ bezüglich der Relation $R$ zum Element $b$ in Beziehung steht.

Damit wird erstmals eine ausgewählte Verbindung zwischen Elementen formal beschrieben. Das kartesische Produkt enthält alle möglichen Paarungen; die Relation bestimmt, welche dieser Paarungen innerhalb der jeweiligen mathematischen Struktur tatsächlich berücksichtigt werden.

Die formale Untersuchung von Relationen besitzt bereits in den logischen und mathematischen Arbeiten von Gottlob Frege und Alfred Tarski grundlegende Bedeutung. Ich nutze diese Arbeiten hier ausschließlich für den etablierten formallogischen Hintergrund der Relationsbeschreibung. Saunders Mac Lane hebt darüber hinaus hervor, dass mathematische Strukturen nicht nur durch ihre Objekte, sondern wesentlich auch durch die zwischen ihnen bestehenden Abbildungen und Beziehungen verständlich werden \\[78\\]. Die bereits im ursprünglichen Abschnitt enthaltenen Verweise auf Frege und Tarski werden beim zugehörigen Repository-Skript gegen den realen Quellenbestand geprüft und dort mit den tatsächlich gültigen Zitationsnummern synchronisiert.

Für meine Untersuchung ist dies ein entscheidender Übergang. Eine Menge erfasst, welche Elemente betrachtet werden. Eine Relation erfasst zusätzlich, welche Elemente innerhalb einer gewählten Beschreibung miteinander verbunden sind.

Ich übernehme für das FRZK jedoch nicht jede beliebige mengentheoretisch mögliche Relation. Gleichung (3.22) beschreibt zunächst nur die formale Grundstruktur. Ob eine Relation symmetrisch, gerichtet, transitiv, reflexiv, funktional oder empirisch begründet ist, muss jeweils zusätzlich bestimmt werden. Ebenso folgt aus dem bloßen Bestehen einer Relation noch keine physikalische Wechselwirkung und keine kausale Verbindung.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `3` — `Definition 3.2.3` — Funktion

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.3`

**Quelltext:**

Eine Funktion $f$ von einer Menge $A$ in eine Menge $B$ ist eine Relation, die jedem Element $a \\in A$ genau ein Element $b \\in B$ zuordnet. Ich fasse die Abbildung und ihre Eindeutigkeitsbedingung deshalb gemeinsam zusammen:

$$f:A \\rightarrow B,\\quad\\quad\\forall a \\in A\\ \\exists!\\, b \\in B:\\ f(a) = b(3.24)$$

Dabei gilt:

-   $f$ ist die Funktion,

-   $A$ ist ihre Definitionsmenge beziehungsweise ihr Definitionsbereich,

-   $B$ ist ihre Zielmenge,

-   $a$ ist ein Element des Definitionsbereichs,

-   $b = fa$ ist der $a$ eindeutig zugeordnete Funktionswert,

-   $\\exists!$ bezeichnet die eindeutige Existenz.

Damit fasse ich die im ursprünglichen Text noch getrennt nummerierten Ausdrücke für die Funktionsschreibweise, den Funktionswert und die Eindeutigkeit bewusst zu **einer** mathematischen Aussage zusammen. Die einzelnen darin auftretenden Größen erhalten keine eigenen Gleichungsnummern.

Gleichung (3.24) enthält zwei Anforderungen. Erstens muss zu jedem Element $a \\in A$ mindestens ein zugeordnetes Element $b \\in B$ existieren. Zweitens darf es für dasselbe Element $a$ nicht mehrere verschiedene Funktionswerte geben.

Diese Bedingung ist für den Funktionsbegriff wesentlich. Eine Relation, die einem Element mehrere verschiedene Werte zuordnet, ist keine Funktion im hier verwendeten Sinn. Ebenso ist eine Zuordnung keine Funktion auf ganz $A$, wenn für einzelne Elemente aus $A$ kein Funktionswert bestimmt ist.

Mengentheoretisch kann ich eine Funktion als Teilmenge des kartesischen Produkts auffassen. Dabei müssen sowohl die Eindeutigkeit als auch die vollständige Erfassung des Definitionsbereichs gleichzeitig gelten:

$$\\ (a,b\\_ 1) \\in \\begin{matrix}
f \\subseteq A \\times B, \\\\
f \\land (a,b_{2}) \\in f\\& \\Rightarrow b_{1} = b_{2}, \\\\
\\forall a \\in A\\ \\&\\exists b \\in B:\\ (a,b) \\in f.
\\end{matrix}(3.25)$$

Dabei sind $b_{1}$ und $b_{2}$ zwei mögliche Werte, die demselben Element $a$ zugeordnet sein könnten. Die zweite Zeile schließt aus, dass diese Werte verschieden sind. Die dritte Zeile stellt sicher, dass jedes Element des Definitionsbereichs tatsächlich in einem geordneten Paar der Funktion auftritt.

Erst die Verbindung dieser Bedingungen ergibt eine Funktion auf der gesamten Definitionsmenge $A$.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `43` — `(3.1)` — Definition 3.2.1: Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.1`
- Source line: `75`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
x \\in \\, M
```

##### repo_object_id `44` — `(3.2)` — Definition 3.2.1: Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.2`
- Source line: `81`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
x \\notin M
```

##### repo_object_id `45` — `(3.3)` — Definition 3.2.1: Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.3`
- Source line: `87`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
M = \\text{\\{}a,b,c\\text{\\}}
```

##### repo_object_id `46` — `(3.4)` — Definition 3.2.1: Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.4`
- Source line: `93`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{\\{}a,b,c\\text{\\}} = \\text{\\{}c,a,b\\text{\\}} = \\text{\\{}a,a,b,c\\text{\\}}
```

##### repo_object_id `47` — `(3.5)` — Definition 3.2.1: Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.5`
- Source line: `99`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
M = \\text{\\{}x \\in U \\mid P(x)\\text{\\}}
```

##### repo_object_id `48` — `(3.6)` — Definition 3.2.1: Menge und Element

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.6`
- Source line: `105`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
G = \\text{\\{}n \\in \\mathbb{N} \\mid \\exists k \\in \\mathbb{N}:n = 2k\\text{\\}}
```

##### repo_object_id `64` — `(3.22)` — Definition 3.2.2: Binäre Relation

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.22`
- Source line: `223`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
R \\subseteq A \\times B
```

##### repo_object_id `65` — `(3.23)` — Definition 3.2.2: Binäre Relation

- Herkunft: `3.2.1` — Mengen, Elemente und elementare Relationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.23`
- Source line: `229`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
aRb \\Longleftrightarrow (a,b) \\in R
```

##### repo_object_id `66` — `(3.24)` — Definition 3.2.3: Funktion

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.24`
- Source line: `293`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
f:A \\rightarrow B,\\quad\\quad\\forall a \\in A\\ \\exists!\\, b \\in B:\\ f(a) = b
```

##### repo_object_id `67` — `(3.25)` — Definition 3.2.3: Funktion

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.25`
- Source line: `317`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\ (a,b\\_ 1) \\in \\begin{matrix}
f \\subseteq A \\times B, \\\\
f \\land (a,b_{2}) \\in f\\& \\Rightarrow b_{1} = b_{2}, \\\\
\\forall a \\in A\\ \\&\\exists b \\in B:\\ (a,b) \\in f.
\\end{matrix}
```

##### repo_object_id `71` — `(3.29)` — Injektive Funktionen

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.29`
- Source line: `355`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\forall a_{1},a_{2} \\in A:\\quad f\\left( a_{1} \\right) = f\\left( a_{2} \\right) \\Rightarrow a_{1} = a_{2}\\quad \\Longleftrightarrow \\quad a_{1} \\neq a_{2} \\Rightarrow f\\left( a_{1} \\right) \\neq f\\left( a_{2} \\right)
```

##### repo_object_id `72` — `(3.30)` — Surjektive Funktionen

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.30`
- Source line: `367`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\forall b \\in B\\ \\exists a \\in A:\\ f(a) = b\\quad\\quad \\Longleftrightarrow \\quad\\quad f(A) = B
```

##### repo_object_id `73` — `(3.31)` — Bijektive Funktionen

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.31`
- Source line: `377`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
f\\text{ bijektiv}\\quad \\Longleftrightarrow \\quad f\\text{ injektiv} \\land f\\text{ surjektiv}
```

##### repo_object_id `74` — `(3.32)` — Bijektive Funktionen

- Herkunft: `3.2.2` — Funktionen und eindeutige Zuordnungen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.32`
- Source line: `383`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
f^{- 1}:B \\rightarrow A, \\\\
f^{- 1}(f(a)) = a,\\forall a \\in A,\\  \\\\
{f(f}^{- 1}b = b,\\ \\forall b \\in B.
\\end{matrix}
```

### 3.2.2 – Vektorräume und lineare Strukturen

**Zweck:** Vektorraum, Linearkombination, Spannraum, lineare Unabhängigkeit, Basis und Dimension; Axiome, Herleitungen und Beispiele in M2.

**Ausgangsobjekte:** 17

| repo_object_id | Typ | Herkunft | Quelllabel | Titel | importance | equation_role | downstream |
|---:|---|---|---|---|---|---|---|
| 6 | definition | 3.2.4 | Definition 3.2.6 | Vektorraum | core |  | 3.3 |
| 9 | definition | 3.2.5 | Definition 3.2.9 | Linearkombination | core |  | 3.3 |
| 10 | definition | 3.2.5 | Definition 3.2.10 | Spannraum | core |  | 3.3 |
| 11 | definition | 3.2.6 | Definition 3.2.11 | Lineare Unabhängigkeit | core |  | 3.3 |
| 13 | definition | 3.2.6 | Definition 3.2.13 | Basis | core |  | 3.3 |
| 14 | definition | 3.2.6 | Definition 3.2.14 | Dimension | core |  | 3.3 |
| 93 | equation | 3.2.4 | (3.51) | Definition 3.2.6: Vektorraum | core | canonical | 3.3 |
| 94 | equation | 3.2.4 | (3.52) | Reelle Vektorräume | supporting | canonical | 3.3 |
| 112 | equation | 3.2.5 | (3.70) | Definition 3.2.9: Linearkombination | core | canonical | 3.3 |
| 113 | equation | 3.2.5 | (3.71) | Definition 3.2.10: Spannraum | core | canonical | 3.3 |
| 114 | equation | 3.2.5 | (3.72) | Erzeugendensysteme | core | canonical | 3.3 |
| 115 | equation | 3.2.6 | (3.74) | Definition 3.2.11: Lineare Unabhängigkeit | core | canonical | 3.3 |
| 120 | equation | 3.2.6 | (3.79) | Definition 3.2.13: Basis | core | canonical | 3.3 |
| 121 | equation | 3.2.6 | (3.80) | Eindeutige Darstellung bezüglich einer Basis | core | canonical | 3.3 |
| 124 | equation | 3.2.6 | (3.83) | Vektor und Koordinatendarstellung | core | canonical | 3.3 |
| 125 | equation | 3.2.6 | (3.84) | Definition 3.2.14: Dimension | core | canonical | 3.3 |
| 126 | equation | 3.2.6 | (3.85) | Definition 3.2.14: Dimension | core | canonical | 3.3 |

#### Quellpayloads

##### repo_object_id `6` — `Definition 3.2.6` — Vektorraum

- Herkunft: `3.2.4` — Vektorräume als mathematische Zustandsräume
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.6`

**Quelltext:**

Sei $K$ ein Körper. Unter einem Vektorraum $V$ über $K$ verstehe ich eine nichtleere Menge, auf der eine Vektoraddition und eine Skalarmultiplikation definiert sind, die gemeinsam die Vektorraumaxiome erfüllen \\[71, 82\\].

Die beiden grundlegenden Operationen fasse ich gemeinsam zusammen:

$$\\begin{matrix}
 + :V \\times V \\rightarrow V,\\ (x,y) \\mapsto x + y, \\\\
 \\cdot K \\times V \\rightarrow V,(\\lambda,x) \\mapsto \\lambda x.
\\end{matrix}\\ (3.51)$$

Dabei gilt:

-   $V$ ist der Vektorraum,

-   $K$ ist der zugrunde liegende Körper,

-   $x,y \\in V$ sind Vektoren,

-   $\\lambda \\in K$ ist ein Skalar,

-   $+$bezeichnet die Vektoraddition,

-   $\\cdot$ bezeichnet die Skalarmultiplikation.

Die beiden Operationen sind abgeschlossen. Die Summe zweier Vektoren und das Produkt eines zulässigen Skalars mit einem Vektor müssen daher wieder Elemente desselben Vektorraums sein \\[71, 74, 82\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `9` — `Definition 3.2.9` — Linearkombination

- Herkunft: `3.2.5` — Linearkombinationen, Spannräume und Erzeugendensysteme
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.9`

**Quelltext:**

Seien $v_{1},v_{2},\\ldots,v_{n} \\in V\\ $Vektoren eines Vektorraums $V$ und $\\lambda_{1},\\lambda_{2},\\ldots,\\lambda_{n} \\in K$ Skalare des zugrunde liegenden Körpers $K$.

Dann heißt der Ausdruck

$$v = \\lambda_{1}v_{1} + \\lambda_{2}v_{2} + \\cdots + \\lambda_{n}v_{n} = \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}}\\ (3.70)$$

eine Linearkombination der Vektoren $v_{1},\\ldots,v_{n}$.

Dabei gilt:

-   $v_{1},\\ldots,v_{n}$ sind die Vektoren, aus denen die Kombination gebildet wird,

-   $\\lambda_{1},\\ldots,\\lambda_{n}$ sind die zugehörigen Skalare,

-   $K$ ist der Skalarkörper,

-   $v$ ist der durch die Linearkombination erzeugte Vektor.

Jede solche Linearkombination ist aufgrund der Vektorraumaxiome wiederum ein Element desselben Vektorraums \\[71, 82\\]. Die ältere Repository-Fassung beschreibt die Linearkombination entsprechend als Summe $\\lambda_{1}v_{1} + \\cdots + \\lambda_{n}v_{n}$.

Die Skalare bestimmen den jeweiligen Beitrag der einzelnen Vektoren zur resultierenden Linearkombination. Verändere ich einen oder mehrere dieser Skalare, erhalte ich im Allgemeinen einen anderen Vektor \\[71, 74\\].

Dabei ist wichtig, dass eine Linearkombination keine neue mathematische Operation neben Addition und Skalarmultiplikation einführt. Sie setzt ausschließlich die beiden bereits definierten Vektorraumoperationen miteinander zusammen. Gerade dadurch zeigt sich, wie aus den elementaren Axiomen des Vektorraums weiterführende Strukturen entstehen.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `10` — `Definition 3.2.10` — Spannraum

- Herkunft: `3.2.5` — Linearkombinationen, Spannräume und Erzeugendensysteme
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.10`

**Quelltext:**

Die Gesamtheit aller Linearkombinationen einer gegebenen Vektormenge bezeichnet deren Spannraum \\[71, 82\\].

Für $v_{1},\\ldots,v_{n} \\in V$ definiere ich

$$\\text{span}\\left( v_{1},\\ldots,v_{n} \\right) = \\left\\{ \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} \\middle| \\lambda_{1},\\ldots,\\lambda_{n} \\in K \\right\\}\\ (3.71)$$

Dabei bezeichnet $\\text{span}\\left( v_{1},\\ldots,v_{n} \\right)$ die Menge aller Vektoren, die ich aus $v_{1},\\ldots,v_{n}$ durch Linearkombinationen erzeugen kann.

Im älteren Repository ist derselbe Begriff als Menge aller Summen $\\sum_{i = 1}^{n}{\\lambda_{i}v_{i}}$ erfasst.

Im Originalabschnitt wurden zunächst eine kürzere Spannschreibweise und anschließend deren Mengendarstellung getrennt nummeriert. Beide Ausdrücke bezeichnen jedoch **denselben mathematischen Gegenstand**. Ich führe sie deshalb hier in Gleichung (3.71) zu einer einzigen Definition zusammen.

Der Spannraum ist nicht lediglich eine beliebige Teilmenge des Vektorraums. Er ist selbst ein Untervektorraum von $V$ und zugleich der kleinste Untervektorraum, der alle betrachteten Vektoren $v_{1},\\ldots,v_{n}$ enthält \\[71, 82\\].

Das Wort *kleinste* ist dabei wesentlich. Jeder Untervektorraum, der sämtliche Vektoren $v_{1},\\ldots,v_{n}$ enthält, muss aufgrund seiner Abgeschlossenheit auch sämtliche Linearkombinationen dieser Vektoren enthalten. Damit muss er auch den gesamten Spannraum enthalten.

Der Spannraum beschreibt somit genau denjenigen Teil des Vektorraums, den ich mit den vorgegebenen Vektoren erreichen kann.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `11` — `Definition 3.2.11` — Lineare Unabhängigkeit

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.11`

**Quelltext:**

Seien $v_{1},\\ldots,v_{n} \\in V$ Vektoren eines Vektorraums $V$ über einem Körper $K$.

Die Vektoren $v_{1},\\ldots,v_{n}$ heißen linear unabhängig, wenn die Gleichung

$$\\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} = 0_{V}\\quad \\Longrightarrow \\quad\\lambda_{1} = \\lambda_{2} = \\cdots = \\lambda_{n} = 0_{K}\\ (3.74)$$

für $\\lambda_{1},\\ldots,\\lambda_{n} \\in K$ gilt.

Dabei bezeichnet

-   $v_{1},\\ldots,v_{n}$ die untersuchten Vektoren,

-   $\\lambda_{1},\\ldots,\\lambda_{n}$ die zugehörigen Skalare,

-   $0_{V}$ den Nullvektor des Vektorraums,

-   $0_{K}$ das additive Nullelement des Skalarkörpers.

Die Aussage bedeutet, dass ausschließlich die triviale Linearkombination den Nullvektor erzeugt. Es gibt also keine nichttriviale Kombination der betrachteten Vektoren, deren Ergebnis $0_{V}$ ist \\[71, 74, 82\\].

Damit besitzt keiner der Vektoren eine Erzeugungsinformation, die bereits vollständig in den übrigen Vektoren enthalten wäre.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `13` — `Definition 3.2.13` — Basis

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.13`

**Quelltext:**

Eine geordnete Vektormenge\\
$$B = \\left( b_{1},\\ldots,b_{n} \\right)$$

bezeichne ich als Basis eines Vektorraums $V$, wenn zwei Bedingungen gleichzeitig erfüllt sind:

$$\\begin{matrix}
V = \\text{span}\\left( b_{1},\\ldots,b_{n} \\right), \\\\
\\text{∑}_{i = 1}^{n}\\lambda_{i}b_{i} = 0_{V} \\Longrightarrow \\lambda_{1} = \\cdots = \\lambda_{n} = 0_{K}.
\\end{matrix}\\ (3.79)$$

Die erste Bedingung verlangt, dass die Basis den gesamten Vektorraum erzeugt. Die zweite Bedingung verlangt lineare Unabhängigkeit.

Eine Basis ist damit ein vollständiges, aber nicht redundantes Erzeugungssystem \\[71, 74, 82\\].

Gerade die Verbindung dieser beiden Eigenschaften ist entscheidend. Ein lediglich linear unabhängiges System muss nicht den gesamten Raum erzeugen. Ein Erzeugendensystem kann dagegen redundante Vektoren enthalten. Erst die Basis erfüllt beide Anforderungen gleichzeitig.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `14` — `Definition 3.2.14` — Dimension

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.14`

**Quelltext:**

Besitzt ein Vektorraum $V$ eine endliche Basis mit $n$ Elementen, dann bezeichne ich $V$ als endlichdimensional und definiere

$$\\dim(V) = n\\ (3.84)$$

Alle Basen desselben endlichdimensionalen Vektorraums besitzen dieselbe Anzahl von Elementen. Dadurch ist die Dimension unabhängig davon, welche konkrete Basis ich zur Darstellung verwende \\[71, 74, 82\\].

Für den reellen Koordinatenraum folgt

$$\\dim\\left( \\mathbb{R}^{n} \\right) = n\\ (3.85)$$

Damit gilt insbesondere\\
$$\\dim\\left( \\mathbb{R}^{2} \\right) = 2,\\quad\\quad\\dim\\left( \\mathbb{R}^{3} \\right) = 3.$$

Diese beiden Aussagen sind unmittelbare Spezialfälle von Gleichung (3.85). Die Dimension beschreibt damit die Anzahl unabhängiger Basisrichtungen, die erforderlich ist, um den gesamten Vektorraum zu erzeugen.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `93` — `(3.51)` — Definition 3.2.6: Vektorraum

- Herkunft: `3.2.4` — Vektorräume als mathematische Zustandsräume
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.51`
- Source line: `734`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
 + :V \\times V \\rightarrow V,\\ (x,y) \\mapsto x + y, \\\\
 \\cdot K \\times V \\rightarrow V,(\\lambda,x) \\mapsto \\lambda x.
\\end{matrix}
```

##### repo_object_id `94` — `(3.52)` — Reelle Vektorräume

- Herkunft: `3.2.4` — Vektorräume als mathematische Zustandsräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.52`
- Source line: `761`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
K = R
```

##### repo_object_id `112` — `(3.70)` — Definition 3.2.9: Linearkombination

- Herkunft: `3.2.5` — Linearkombinationen, Spannräume und Erzeugendensysteme
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.70`
- Source line: `984`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
v = \\lambda_{1}v_{1} + \\lambda_{2}v_{2} + \\cdots + \\lambda_{n}v_{n} = \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}}
```

##### repo_object_id `113` — `(3.71)` — Definition 3.2.10: Spannraum

- Herkunft: `3.2.5` — Linearkombinationen, Spannräume und Erzeugendensysteme
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.71`
- Source line: `1038`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{span}\\left( v_{1},\\ldots,v_{n} \\right) = \\left\\{ \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} \\middle| \\lambda_{1},\\ldots,\\lambda_{n} \\in K \\right\\}
```

##### repo_object_id `114` — `(3.72)` — Erzeugendensysteme

- Herkunft: `3.2.5` — Linearkombinationen, Spannräume und Erzeugendensysteme
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.72`
- Source line: `1058`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
V = \\text{span}\\left( v_{1},\\ldots,v_{n} \\right)
```

##### repo_object_id `115` — `(3.74)` — Definition 3.2.11: Lineare Unabhängigkeit

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.74`
- Source line: `1173`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} = 0_{V}\\quad \\Longrightarrow \\quad\\lambda_{1} = \\lambda_{2} = \\cdots = \\lambda_{n} = 0_{K}
```

##### repo_object_id `120` — `(3.79)` — Definition 3.2.13: Basis

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.79`
- Source line: `1258`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
V = \\text{span}\\left( b_{1},\\ldots,b_{n} \\right), \\\\
\\text{∑}_{i = 1}^{n}\\lambda_{i}b_{i} = 0_{V} \\Longrightarrow \\lambda_{1} = \\cdots = \\lambda_{n} = 0_{K}.
\\end{matrix}
```

##### repo_object_id `121` — `(3.80)` — Eindeutige Darstellung bezüglich einer Basis

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.80`
- Source line: `1273`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
v = \\sum_{i = 1}^{n}{\\lambda_{i}b_{i}}
```

##### repo_object_id `124` — `(3.83)` — Vektor und Koordinatendarstellung

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.83`
- Source line: `1340`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\lbrack v\\rbrack_{B} = \\begin{pmatrix}
\\lambda_{1} \\\\
\\lambda_{2} \\\\
 \\vdots \\\\
\\lambda_{n}
\\end{pmatrix}
```

##### repo_object_id `125` — `(3.84)` — Definition 3.2.14: Dimension

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.84`
- Source line: `1355`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\dim(V) = n
```

##### repo_object_id `126` — `(3.85)` — Definition 3.2.14: Dimension

- Herkunft: `3.2.6` — Lineare Unabhängigkeit, Basis und Dimension
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.85`
- Source line: `1361`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\dim\\left( \\mathbb{R}^{n} \\right) = n
```

### 3.2.3 – Lineare Abbildungen und ihre Darstellung

**Zweck:** Lineare Abbildung, Operator, Matrixdarstellung, Koordinaten und Basiswechsel; Detailrechnungen und Invarianten in M3.

**Ausgangsobjekte:** 15

| repo_object_id | Typ | Herkunft | Quelllabel | Titel | importance | equation_role | downstream |
|---:|---|---|---|---|---|---|---|
| 4 | definition | 3.2.3 | Definition 3.2.4 | Mathematische Abbildung | core |  | 3.3 |
| 5 | definition | 3.2.3 | Definition 3.2.5 | Linearer Operator | core |  | 3.3 |
| 83 | equation | 3.2.3 | (3.41) | Definition 3.2.4: Mathematische Abbildung | core | canonical | 3.3 |
| 84 | equation | 3.2.3 | (3.42) | Strukturerhaltende Abbildungen | core | canonical | 3.3 |
| 85 | equation | 3.2.3 | (3.43) | Definition 3.2.5: Linearer Operator | core | canonical | 3.3 |
| 90 | equation | 3.2.3 | (3.48) | Inverse Operatoren | supporting | canonical | 3.3 |
| 91 | equation | 3.2.3 | (3.49) | Matrixdarstellung linearer Operatoren | core | canonical | 3.3 |
| 127 | equation | 3.2.7 | (3.86) | Darstellung eines Vektors bezüglich einer Basis | supporting | canonical | 3.3 |
| 128 | equation | 3.2.7 | (3.87) | Darstellung eines Vektors bezüglich einer Basis | supporting | canonical | 3.3 |
| 129 | equation | 3.2.7 | (3.88) | Zwei verschiedene Basen | supporting | canonical | 3.3 |
| 130 | equation | 3.2.7 | (3.89) | Basiswechselmatrix | core | canonical | 3.3 |
| 131 | equation | 3.2.7 | (3.90) | Basiswechselmatrix | core | canonical | 3.3 |
| 135 | equation | 3.2.7 | (3.94) | Darstellung linearer Operatoren | core | canonical | 3.3 |
| 136 | equation | 3.2.7 | (3.95) | Invariante Eigenschaften | supporting | derived | 3.3 |
| 137 | equation | 3.2.7 | (3.96) | Invariante Eigenschaften | supporting | derived | 3.3 |

#### Quellpayloads

##### repo_object_id `4` — `Definition 3.2.4` — Mathematische Abbildung

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.4`

**Quelltext:**

Seien $X$ und $Y$ Mengen. Eine Abbildung $T$ ordnet jedem Element $x \\in X$ genau ein Element $y \\in Y$ zu. Ich fasse die Abbildungsvorschrift und ihre Wirkung deshalb unmittelbar zusammen:

$$T:X \\rightarrow Y,\\quad\\quad T(x) = y,\\quad x \\in X,\\ y \\in Y\\ (3.41)$$

Dabei gilt:

-   $T$ bezeichnet die Abbildung,

-   $X$ ist der Definitionsbereich,

-   $Y$ ist der Zielbereich,

-   $x$ ist ein Element aus $X$,

-   $y = T(x)$ ist das $x$ zugeordnete Element aus $Y$.

Damit besitzt eine Abbildung dieselbe grundlegende Eindeutigkeitsforderung wie eine Funktion. In der mathematischen Literatur werden beide Begriffe häufig synonym verwendet, wobei der Begriff *Abbildung* insbesondere dann verwendet wird, wenn die Wirkung auf mathematische Strukturen untersucht wird \\[71, 80, 82\\].

Die Abbildung selbst enthält zunächst keine Aussage darüber, ob geometrische, algebraische oder analytische Eigenschaften erhalten bleiben. Solche Eigenschaften ergeben sich erst aus zusätzlichen Bedingungen an die Abbildung \\[71, 82\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `5` — `Definition 3.2.5` — Linearer Operator

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.5`

**Quelltext:**

Sind Definitions- und Zielraum identisch, spreche ich von einem linearen Operator. Formal schreibe ich

$$T:V \\rightarrow V\\ (3.43)$$

Dabei bezeichnet $V$ den Vektorraum, auf dessen Elementen der Operator $T$ wirkt.

Ein Operator wirkt somit innerhalb desselben Vektorraums. Er erzeugt keinen neuen mathematischen Raum, sondern verändert ausschließlich Elemente eines bereits festgelegten Zustandsraums. Diese Definition wird in der linearen Algebra ebenso verwendet wie in der Funktionalanalysis \\[82, 13\\].

Die Bezeichnung *Operator* beschreibt dabei keine besondere Rechenvorschrift. Sie charakterisiert zunächst die Tatsache, dass Definitions- und Zielraum identisch sind \\[82, 13\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `83` — `(3.41)` — Definition 3.2.4: Mathematische Abbildung

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.41`
- Source line: `542`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
T:X \\rightarrow Y,\\quad\\quad T(x) = y,\\quad x \\in X,\\ y \\in Y
```

##### repo_object_id `84` — `(3.42)` — Strukturerhaltende Abbildungen

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.42`
- Source line: `566`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
\\begin{matrix}
T(x + y) = T(x) + T(y), \\\\
T(\\lambda x)\\& = \\lambda T(x),
\\end{matrix} & x,y \\in V,\\ \\lambda \\in K
\\end{matrix}
```

##### repo_object_id `85` — `(3.43)` — Definition 3.2.5: Linearer Operator

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.43`
- Source line: `589`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
T:V \\rightarrow V
```

##### repo_object_id `90` — `(3.48)` — Inverse Operatoren

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.48`
- Source line: `636`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
T^{- 1}:V \\rightarrow V, \\\\
\\begin{matrix}
T^{- 1} \\circ T = I \\\\
T \\circ T^{- 1} = I
\\end{matrix}
\\end{matrix}
```

##### repo_object_id `91` — `(3.49)` — Matrixdarstellung linearer Operatoren

- Herkunft: `3.2.3` — Abbildungen, Operatoren und mathematische Transformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.49`
- Source line: `654`
- Nummernursprung: `context_inferred`
- Integritätsstatus: `number_missing`
- vorhandenes Quell-Word-LaTeX: `Ax=y`

**Quell-LaTeX:**

```text
Ax = y
```

**Kandidatennotiz:** Nummer (3.49) ist im Quelltext nicht am Formelsatz sichtbar; Zuordnung wird durch den unmittelbar folgenden Erläuterungstext bestätigt.

##### repo_object_id `127` — `(3.86)` — Darstellung eines Vektors bezüglich einer Basis

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.86`
- Source line: `1451`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
v = \\sum_{i = 1}^{n}{\\lambda_{i}b_{i}}
```

##### repo_object_id `128` — `(3.87)` — Darstellung eines Vektors bezüglich einer Basis

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.87`
- Source line: `1467`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\lbrack v\\rbrack_{B} = \\begin{pmatrix}
\\lambda_{1} \\\\
\\lambda_{2} \\\\
 \\vdots \\\\
\\lambda_{n}
\\end{pmatrix}
```

##### repo_object_id `129` — `(3.88)` — Zwei verschiedene Basen

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.88`
- Source line: `1487`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\lbrack v\\rbrack_{B} = \\begin{pmatrix}
\\lambda_{1} \\\\
 \\vdots \\\\
\\lambda_{n}
\\end{pmatrix},\\quad\\quad\\lbrack v\\rbrack_{C} = \\begin{pmatrix}
\\mu_{1} \\\\
 \\vdots \\\\
\\mu_{n}
\\end{pmatrix}
```

##### repo_object_id `130` — `(3.89)` — Basiswechselmatrix

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.89`
- Source line: `1509`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\lbrack v\\rbrack_{C} = P_{B \\rightarrow C}\\lbrack v\\rbrack_{B}
```

##### repo_object_id `131` — `(3.90)` — Basiswechselmatrix

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.90`
- Source line: `1523`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
P_{C \\rightarrow B} = P_{B \\rightarrow C}^{- 1} \\\\
\\lbrack v\\rbrack_{B} = P_{C \\rightarrow B}\\lbrack v\\rbrack_{C}.
\\end{matrix}
```

##### repo_object_id `135` — `(3.94)` — Darstellung linearer Operatoren

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.94`
- Source line: `1597`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
A_{C} = P_{B \\rightarrow C}A_{B}P_{C \\rightarrow B}
```

##### repo_object_id `136` — `(3.95)` — Invariante Eigenschaften

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.95`
- Source line: `1621`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det\\left( A_{C} \\right) = \\det\\left( A_{B} \\right)
```

##### repo_object_id `137` — `(3.96)` — Invariante Eigenschaften

- Herkunft: `3.2.7` — Basiswechsel und Koordinatentransformationen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.96`
- Source line: `1635`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\sigma\\left( A_{B} \\right) = \\sigma\\left( A_{C} \\right)
```

### 3.2.4 – Struktur linearer Operatoren

**Zweck:** Determinante, Kern, Bild, Rang, Invertierbarkeit und Rang-Nullität; Rechnungen und LGS-Vertiefungen in M3/M4.

**Ausgangsobjekte:** 23

| repo_object_id | Typ | Herkunft | Quelllabel | Titel | importance | equation_role | downstream |
|---:|---|---|---|---|---|---|---|
| 15 | definition | 3.2.8 | Definition 3.2.15 | Determinante einer quadratischen Matrix | core |  | 3.3 |
| 16 | definition | 3.2.9 | Definition 3.2.16 | Bild einer linearen Abbildung | core |  | 3.3 |
| 17 | definition | 3.2.9 | Definition 3.2.17 | Kern einer linearen Abbildung | core |  | 3.3 |
| 18 | definition | 3.2.9 | Definition 3.2.18 | Rang einer linearen Abbildung | core |  | 3.3 |
| 34 | statement | 3.2.9 | Rang-Nullitätssatz | Rang-Nullitätssatz | core |  | 3.3 |
| 35 | statement | 3.2.9 | Zusammenhang mit Injektivität und Surjektivität | Zusammenhang mit Injektivität und Surjektivität | core |  | 3.3 |
| 138 | equation | 3.2.8 | (3.97) | Definition 3.2.15: Determinante einer quadratischen Matrix | core | canonical | 3.3 |
| 142 | equation | 3.2.8 | (3.101) | Geometrische Bedeutung | supporting | canonical | 3.3 |
| 143 | equation | 3.2.8 | (3.102) | Geometrische Bedeutung | supporting | canonical | 3.3 |
| 146 | equation | 3.2.8 | (3.105) | Singuläre und reguläre Matrizen | core | canonical | 3.3 |
| 148 | equation | 3.2.8 | (3.107) | Zusammenhang mit linearer Unabhängigkeit | core | canonical | 3.3 |
| 149 | equation | 3.2.8 | (3.108) | Multiplikativität der Determinante | supporting | canonical | 3.3 |
| 150 | equation | 3.2.8 | (3.109) | Determinante der inversen Matrix | supporting | canonical | 3.3 |
| 151 | equation | 3.2.8 | (3.110) | Determinante und Basiswechsel | supporting | canonical | 3.3 |
| 152 | equation | 3.2.9 | (3.111) | Definition 3.2.16: Bild einer linearen Abbildung | core | canonical | 3.3 |
| 153 | equation | 3.2.9 | (3.112) | Definition 3.2.17: Kern einer linearen Abbildung | core | canonical | 3.3 |
| 154 | equation | 3.2.9 | (3.113) | Definition 3.2.18: Rang einer linearen Abbildung | core | canonical | 3.3 |
| 157 | equation | 3.2.9 | (3.116) | Voller Rang | core | canonical | 3.3 |
| 158 | equation | 3.2.9 | (3.117) | Voller Rang | core | canonical | 3.3 |
| 159 | equation | 3.2.9 | (3.118) | Rang-Nullitätssatz | core | canonical | 3.3 |
| 161 | equation | 3.2.9 | (3.120) | Zusammenhang mit Injektivität und Surjektivität | core | canonical | 3.3 |
| 162 | equation | 3.2.9 | (3.121) | Zusammenhang mit Injektivität und Surjektivität | core | canonical | 3.3 |
| 166 | equation | 3.2.9 | (3.125) | Zusammenhang mit der Determinante | supporting | derived | 3.3 |

#### Quellpayloads

##### repo_object_id `15` — `Definition 3.2.15` — Determinante einer quadratischen Matrix

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.15`

**Quelltext:**

Für eine quadratische reelle Matrix $A \\in \\mathbb{R}^{n \\times n}$ bezeichne ich die Determinante mit $\\det(A)$ beziehungsweise $|A|$. Formal fasse ich sie als Abbildung

$$\\det:\\mathbb{R}^{n \\times n} \\longrightarrow \\mathbb{R},\\quad\\quad A \\longmapsto \\det(A)\\ (3.97)$$

Dabei gilt:

-   $A$ ist eine quadratische $n \\times n$-Matrix,

-   $\\mathbb{R}^{n \\times n}$ ist der Raum der reellen quadratischen Matrizen der Ordnung $n$,

-   $\\det(A)$ ist der der Matrix eindeutig zugeordnete reelle Skalar,

-   $n$ bezeichnet die Dimension des zugrunde liegenden endlichdimensionalen Raumes.

Die Determinante ist ausschließlich für quadratische Matrizen definiert. Für nichtquadratische Matrizen kann ich deshalb nicht in derselben Weise von einer Determinante sprechen \\[71, 74, 82\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `16` — `Definition 3.2.16` — Bild einer linearen Abbildung

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.16`

**Quelltext:**

Seien $V$ und $W$ Vektorräume und $T:V \\rightarrow W$ eine lineare Abbildung.

Diese Angabe legt Definitions- und Zielraum sowie die verwendete Abbildung fest. Sie ist eine Voraussetzung der folgenden Definition und erhält deshalb keine eigene Gleichungsnummer.

Das Bild von $T$ definiere ich durch

$$\\text{Bild}(T) = \\left\\{ T(v) \\in W \\middle| v \\in V \\right\\}\\ (3.111)$$

Dabei bezeichnet

-   $T$ die lineare Abbildung,

-   $V$ ihren Definitionsraum,

-   $W$ ihren Zielraum,

-   $v$ einen Vektor aus $V$,

-   $T(v)$ den zugehörigen Bildvektor.

Das Bild enthält damit genau diejenigen Vektoren des Zielraums, die durch Anwendung von $T$ auf mindestens einen Vektor des Definitionsraums tatsächlich entstehen können \\[71, 74, 82\\].

Im Allgemeinen muss das Bild nicht mit dem gesamten Zielraum übereinstimmen. Es gilt lediglich$\\ \\text{Bild}(T) \\subseteq W.\\ $Diese Inklusion ist eine unmittelbare Eigenschaft der Definition und erhält keine eigene Gleichungsnummer.

Da $T$ linear ist, bildet $\\text{Bild}T$ selbst einen Untervektorraum von $W$. Sind zwei Vektoren $w_{1},w_{2} \\in \\text{Bild}T$, so existieren $v_{1},v_{2} \\in V$ mit $T\\left( v_{1} \\right) = w_{1}$ und $T\\left( v_{2} \\right) = w_{2}$. Für Skalare $\\lambda,\\mu$ folgt aus der Linearität

$$\\lambda w_{1} + \\mu w_{2} = T\\left( \\lambda v_{1} + \\mu v_{2} \\right) \\in \\text{Bild}(T).$$

Dieser Ausdruck gehört zur Begründung der Untervektorraumeigenschaft und wird nicht als zusätzliche Gleichung nummeriert.

Das Bild beschreibt damit den tatsächlich erreichbaren Teil des Zielraums.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `17` — `Definition 3.2.17` — Kern einer linearen Abbildung

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.17`

**Quelltext:**

Der Kern derselben linearen Abbildung $T:V \\rightarrow W$ besteht aus allen Vektoren des Definitionsraums, die auf den Nullvektor des Zielraums abgebildet werden:

$$\\ker(T) = \\left\\{ v \\in V \\middle| T(v) = 0_{W} \\right\\}\\ (3.112)$$

Dabei ist $0_{W}$ der Nullvektor des Zielraums $W$.

Der Kern beantwortet damit eine andere Frage als das Bild. Beim Bild frage ich, welche Ausgangszustände erreichbar sind. Beim Kern frage ich, welche Eingangsvektoren durch die Abbildung vollständig auf denselben Nullvektor zusammengeführt werden \\[71, 74, 82\\].

Auch der Kern ist ein Untervektorraum, diesmal des Definitionsraums $V$. Für $v_{1},v_{2} \\in \\ker(T)$ und Skalare (\\\\lambda,\\\\mu) gilt nämlich\\
$$\\mathbf{T}\\left( \\mathbf{\\lambda}\\mathbf{v}_{\\mathbf{1}}\\mathbf{+}\\mathbf{\\mu}\\mathbf{v}_{\\mathbf{2}} \\right)\\mathbf{=}\\mathbf{\\lambda}\\mathbf{T}\\left( \\mathbf{v}_{\\mathbf{1}} \\right)\\mathbf{+}\\mathbf{\\mu}\\mathbf{T}\\left( \\mathbf{v}_{\\mathbf{2}} \\right)\\mathbf{0}_{\\mathbf{W}}\\mathbf{.}$$

Damit ist auch jede Linearkombination zweier Kernvektoren wieder ein Element des Kerns. Diese Herleitung erhält keine eigene Gleichungsnummer.

Der Nullvektor $0_{V}$ gehört immer zum Kern, weil jede lineare Abbildung den Nullvektor auf den Nullvektor abbildet.

Besitzt eine lineare Abbildung nur den trivialen Kern $\\ker(T) = 0_{V},$ so werden keine zwei verschiedenen Vektoren allein aufgrund einer nichttrivialen Kernrichtung miteinander identifiziert. Für lineare Abbildungen entspricht dies der Injektivität.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `18` — `Definition 3.2.18` — Rang einer linearen Abbildung

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.18`

**Quelltext:**

Den Rang einer linearen Abbildung definiere ich als Dimension ihres Bildes:

$$\\text{rang}(T) = \\dim\\left( \\text{Bild}(T) \\right)\\ (3.113)$$

Der Rang gibt damit die Anzahl linear unabhängiger Richtungen an, die im Bildraum tatsächlich vorhanden sind \\[71, 74, 82\\].

Ist $A$ eine Darstellungsmatrix der linearen Abbildung, schreibe ich entsprechend $\\text{rang}A$. Diese Schreibweise bezeichnet denselben strukturellen Begriff auf der Ebene der Matrixdarstellung und benötigt keine zusätzliche Gleichungsnummer.

Der Rang darf dabei nicht mit der Anzahl der Spalten oder Zeilen einer Matrix verwechselt werden. Entscheidend ist nicht, wie viele Vektoren formal vorhanden sind, sondern wie viele davon linear unabhängig sind.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `34` — `Rang-Nullitätssatz` — Rang-Nullitätssatz

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `statement`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet einen strukturellen Übergang in die Axiomatik; konkrete Zieluntersektion wird später präzisiert.

**Quelltext:**

Zwischen Bild und Kern besteht ein grundlegender Dimensionszusammenhang.

Sei $T:V \\rightarrow W$ eine lineare Abbildung mit endlichdimensionalem Definitionsraum $V$.

Dann gilt

$$\\dim(V) = \\dim\\left( \\ker(T) \\right) + \\text{rang}(T)\\ (3.118)$$

Diese Beziehung wird als **Dimensionssatz** oder **Rang-Nullitätssatz** bezeichnet \\[71, 74, 82\\].

Die Größe $dim!\\left( \\ker(T) \\right)$ wird auch als Nullität der linearen Abbildung bezeichnet.

Gleichung (3.118) zeigt, dass sich die Dimension des Definitionsraums in zwei Teile zerlegen lässt:

-   Richtungen, die im Kern liegen,

-   Richtungen, die unabhängig zum Bild beitragen.

Dabei muss ich die Formulierung „Richtungen gehen verloren" methodisch vorsichtig verwenden. Mathematisch bedeutet eine Kernrichtung zunächst nur, dass sie von $T$ auf (0_W) abgebildet wird. Ob dies in einer wissenschaftlichen Anwendung tatsächlich als Informationsverlust oder physikalischer Verlust zu deuten ist, hängt von der Interpretation des Modells ab.

**Kandidatennotiz:** Als Satz-/Ergebniskandidat aus der Quellfassung registriert; sichtbare Satznummer erst nach wissenschaftlicher Klassifikation.

##### repo_object_id `35` — `Zusammenhang mit Injektivität und Surjektivität` — Zusammenhang mit Injektivität und Surjektivität

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `statement`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet einen strukturellen Übergang in die Axiomatik; konkrete Zieluntersektion wird später präzisiert.

**Quelltext:**

Kern und Bild ermöglichen mir außerdem eine präzise Charakterisierung von Injektivität und Surjektivität.

Eine lineare Abbildung $T:V \\rightarrow W$ ist genau dann injektiv, wenn ihr Kern trivial ist:

$$T\\,\\text{injektiv}\\quad \\Longleftrightarrow \\quad\\ker(T) = \\text{\\{}0_{V}\\text{\\}}\\ (3.120)$$

Denn liegen zwei Vektoren $v_{1},v_{2}$ auf demselben Bildvektor, so gilt\\
$$T\\left( v_{1} \\right) = T\\left( v_{2} \\right)\\quad \\Longrightarrow \\backslash quadT\\left( v_{1} - v_{2} \\right) = 0_{W}.$$

Ist der Kern trivial, folgt daraus $v_{1} - v_{2} = 0_{V}$ und damit $v_{1} = v_{2}$.

Surjektivität wird dagegen durch das Bild charakterisiert:

$$T\\,\\text{surjektiv}\\quad \\Longleftrightarrow \\quad\\text{Bild}(T) = W\\ (3.121)$$

Damit sind Injektivität und Surjektivität unmittelbar mit Kern und Bild verbunden.

Für einen linearen Operator auf einem endlichdimensionalen Vektorraum gleicher Dimension fallen bei vollem Rang schließlich Injektivität, Surjektivität und Invertierbarkeit zusammen.

**Kandidatennotiz:** Als Satz-/Ergebniskandidat aus der Quellfassung registriert; sichtbare Satznummer erst nach wissenschaftlicher Klassifikation.

##### repo_object_id `138` — `(3.97)` — Definition 3.2.15: Determinante einer quadratischen Matrix

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.97`
- Source line: `1723`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det:\\mathbb{R}^{n \\times n} \\longrightarrow \\mathbb{R},\\quad\\quad A \\longmapsto \\det(A)
```

##### repo_object_id `142` — `(3.101)` — Geometrische Bedeutung

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.101`
- Source line: `1800`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
vol(T_{A}(M)) = |\\ det(A)|\\, vol(M)
```

##### repo_object_id `143` — `(3.102)` — Geometrische Bedeutung

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.102`
- Source line: `1816`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\{ \\begin{matrix}
|\\ det(A)| > 1 \\Rightarrow Vergrößerung \\\\
0 < |\\ det(A)| < 1 \\Rightarrow Verkleinerung \\\\
|\\ det(A)| = 1 \\Rightarrow Volumenerhaltung.
\\end{matrix} \\right.
```

##### repo_object_id `146` — `(3.105)` — Singuläre und reguläre Matrizen

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.105`
- Source line: `1855`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det(A) = 0\\quad \\Longleftrightarrow \\quad A\\,\\text{ist singulär}\\quad \\Longleftrightarrow \\quad A^{- 1}\\,\\text{existiert nicht}
```

##### repo_object_id `148` — `(3.107)` — Zusammenhang mit linearer Unabhängigkeit

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.107`
- Source line: `1895`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad a_{1},\\ldots,a_{n}\\,\\text{sind linear unabhängig}\\quad \\Longleftrightarrow \\quad\\text{rank}(A) = n\\quad \\Longleftrightarrow \\quad A^{- 1}\\,\\text{existiert}
```

##### repo_object_id `149` — `(3.108)` — Multiplikativität der Determinante

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.108`
- Source line: `1913`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det(AB) = \\det(A)\\det(B)
```

##### repo_object_id `150` — `(3.109)` — Determinante der inversen Matrix

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.109`
- Source line: `1928`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det\\left( A^{- 1} \\right) = \\frac{1}{\\det(A)}
```

##### repo_object_id `151` — `(3.110)` — Determinante und Basiswechsel

- Herkunft: `3.2.8` — Determinanten, Orientierung und Volumenänderung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.110`
- Source line: `1945`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\begin{matrix}
det(A_{C})\\& = \\ det(P_{B \\rightarrow C}^{- 1}) \\\\
 = det(P_{B \\rightarrow C})\\ det(A_{B})\\ det(P_{B \\rightarrow C}^{- 1}) \\\\
 = det(A_{B})
\\end{matrix}
```

##### repo_object_id `152` — `(3.111)` — Definition 3.2.16: Bild einer linearen Abbildung

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.111`
- Source line: `2059`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{Bild}(T) = \\left\\{ T(v) \\in W \\middle| v \\in V \\right\\}
```

##### repo_object_id `153` — `(3.112)` — Definition 3.2.17: Kern einer linearen Abbildung

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.112`
- Source line: `2089`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\ker(T) = \\left\\{ v \\in V \\middle| T(v) = 0_{W} \\right\\}
```

##### repo_object_id `154` — `(3.113)` — Definition 3.2.18: Rang einer linearen Abbildung

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.113`
- Source line: `2108`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{rang}(T) = \\dim\\left( \\text{Bild}(T) \\right)
```

##### repo_object_id `157` — `(3.116)` — Voller Rang

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.116`
- Source line: `2169`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{rang}(A) = \\min(m,n)
```

##### repo_object_id `158` — `(3.117)` — Voller Rang

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.117`
- Source line: `2179`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{rang}(A) = n\\quad \\Longleftrightarrow \\quad\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad A^{- 1}\\,\\text{existiert}
```

##### repo_object_id `159` — `(3.118)` — Rang-Nullitätssatz

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.118`
- Source line: `2191`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\dim(V) = \\dim\\left( \\ker(T) \\right) + \\text{rang}(T)
```

##### repo_object_id `161` — `(3.120)` — Zusammenhang mit Injektivität und Surjektivität

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.120`
- Source line: `2243`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
T\\,\\text{injektiv}\\quad \\Longleftrightarrow \\quad\\ker(T) = \\text{\\{}0_{V}\\text{\\}}
```

##### repo_object_id `162` — `(3.121)` — Zusammenhang mit Injektivität und Surjektivität

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.121`
- Source line: `2252`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
T\\,\\text{surjektiv}\\quad \\Longleftrightarrow \\quad\\text{Bild}(T) = W
```

##### repo_object_id `166` — `(3.125)` — Zusammenhang mit der Determinante

- Herkunft: `3.2.9` — Rang, Kern und Bild linearer Abbildungen
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.125`
- Source line: `2282`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad\\text{rang}(A) = n\\quad \\Longleftrightarrow \\quad\\ker(A) = \\text{\\{}0\\text{\\}}\\quad \\Longleftrightarrow \\quad A\\,\\text{ist invertierbar}
```

### 3.2.5 – Eigenstruktur und Spektraldarstellung

**Zweck:** Eigenwert, Eigenvektor, Eigenraum, Diagonalisierbarkeit und Spektralzerlegung; Rechen- und Projektorvertiefungen in M5.

**Ausgangsobjekte:** 32

| repo_object_id | Typ | Herkunft | Quelllabel | Titel | importance | equation_role | downstream |
|---:|---|---|---|---|---|---|---|
| 19 | definition | 3.2.10 | Definition 3.2.19 | Eigenwert und Eigenvektor | core |  | 3.3 |
| 20 | definition | 3.2.10 | Definition 3.2.20 | Charakteristisches Polynom | supporting |  | 3.3 |
| 21 | definition | 3.2.10 | Definition 3.2.21 | Eigenraum | core |  | 3.3 |
| 22 | definition | 3.2.10 | Definition 3.2.22 | Spektrum | supporting |  | 3.3 |
| 23 | definition | 3.2.11 | Definition 3.2.23 | Diagonalisierbarkeit | core |  | 3.3 |
| 24 | definition | 3.2.11 | Definition 3.2.24 | Orthogonale Diagonalisierung | supporting |  | 3.3 |
| 36 | statement | 3.2.10 | Eigenvektoren zu verschiedenen Eigenwerten | Eigenvektoren zu verschiedenen Eigenwerten | supporting |  | 3.3 |
| 37 | statement | 3.2.11 | Voraussetzung der Diagonalisierbarkeit | Voraussetzung der Diagonalisierbarkeit | core |  | 3.3 |
| 38 | statement | 3.2.11 | Spektralzerlegung | Spektralzerlegung | core |  | 3.3 |
| 167 | equation | 3.2.10 | (3.126) | Definition 3.2.19: Eigenwert und Eigenvektor | core | canonical | 3.3 |
| 168 | equation | 3.2.10 | (3.127) | Umformung der Eigenwertgleichung | supporting | derived | 3.3 |
| 169 | equation | 3.2.10 | (3.128) | Umformung der Eigenwertgleichung | supporting | derived | 3.3 |
| 170 | equation | 3.2.10 | (3.129) | Charakteristische Gleichung | core | canonical | 3.3 |
| 171 | equation | 3.2.10 | (3.130) | Definition 3.2.20: Charakteristisches Polynom | supporting | canonical | 3.3 |
| 172 | equation | 3.2.10 | (3.131) | Definition 3.2.20: Charakteristisches Polynom | supporting | canonical | 3.3 |
| 175 | equation | 3.2.10 | (3.134) | Definition 3.2.21: Eigenraum | core | canonical | 3.3 |
| 176 | equation | 3.2.10 | (3.135) | Definition 3.2.21: Eigenraum | core | canonical | 3.3 |
| 183 | equation | 3.2.10 | (3.142) | Eigenwert null und Kern | supporting | derived | 3.3 |
| 184 | equation | 3.2.10 | (3.143) | Eigenwert null und Kern | supporting | derived | 3.3 |
| 185 | equation | 3.2.10 | (3.144) | Eigenwerte unter einem Basiswechsel | supporting | derived | 3.3 |
| 186 | equation | 3.2.10 | (3.145) | Definition 3.2.22: Spektrum | supporting | canonical | 3.3 |
| 188 | equation | 3.2.11 | (3.147) | Definition 3.2.23: Diagonalisierbarkeit | core | canonical | 3.3 |
| 189 | equation | 3.2.11 | (3.148) | Definition 3.2.23: Diagonalisierbarkeit | core | canonical | 3.3 |
| 190 | equation | 3.2.11 | (3.149) | Definition 3.2.23: Diagonalisierbarkeit | core | canonical | 3.3 |
| 191 | equation | 3.2.11 | (3.150) | Zusammenhang zwischen Eigenvektoren und Diagonalmatrix | supporting | derived | 3.3 |
| 192 | equation | 3.2.11 | (3.151) | Zusammenhang zwischen Eigenvektoren und Diagonalmatrix | supporting | derived | 3.3 |
| 193 | equation | 3.2.11 | (3.152) | Voraussetzung der Diagonalisierbarkeit | core | canonical | 3.3 |
| 194 | equation | 3.2.11 | (3.153) | Voraussetzung der Diagonalisierbarkeit | core | canonical | 3.3 |
| 206 | equation | 3.2.11 | (3.165) | Spektralzerlegung | core | canonical | 3.3 |
| 207 | equation | 3.2.11 | (3.166) | Spektralzerlegung | core | canonical | 3.3 |
| 208 | equation | 3.2.11 | (3.167) | Definition 3.2.24: Orthogonale Diagonalisierung | core | canonical | 3.3 |
| 209 | equation | 3.2.11 | (3.168) | Definition 3.2.24: Orthogonale Diagonalisierung | core | canonical | 3.3 |

#### Quellpayloads

##### repo_object_id `19` — `Definition 3.2.19` — Eigenwert und Eigenvektor

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.19`

**Quelltext:**

Sei $A \\in \\mathbb{R}^{n \\times n}$ eine quadratische Matrix.

Ein von null verschiedener Vektor $v \\in \\mathbb{R}^{n}$ heißt Eigenvektor von $A$, wenn ein Skalar $\\lambda \\in \\mathbb{R}$ existiert, sodass

$$Av = \\lambda v,\\quad\\quad v \\neq 0\\ (3.126)$$

Dabei bezeichnet

-   $A$ die betrachtete quadratische Matrix,

-   $v$ den Eigenvektor,

-   $\\lambda$ den zugehörigen Eigenwert.

Die Gleichung sagt aus, dass die Transformation $A$ den Eigenvektor nicht in eine neue unabhängige Richtung dreht. Sie verändert lediglich seine Länge und gegebenenfalls seine Orientierung \\[71, 74, 82\\].

Für $\\lambda > 0$ bleibt die Orientierung der Eigenrichtung erhalten. Für $\\lambda < 0$ wird sie umgekehrt. Für $\\lambda = 0$ wird der Eigenvektor auf den Nullvektor abgebildet.

Der Nullvektor selbst wird ausdrücklich nicht als Eigenvektor zugelassen, weil $A0 = 0$ für jede lineare Transformation gilt und damit keine ausgezeichnete Richtung charakterisieren würde.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `20` — `Definition 3.2.20` — Charakteristisches Polynom

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `definition`
- `importance_level`: `supporting`
- downstream: `3.3` / `supporting` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.20`

**Quelltext:**

Das charakteristische Polynom einer Matrix $A \\in \\mathbb{R}^{n \\times n}$ definiere ich durch

$$p_{A}(\\lambda) = \\det(A - \\lambda I)\\ (3.130)$$

Die Eigenwerte von $A$ sind genau die Nullstellen dieses Polynoms:

$$p_{A}(\\lambda) = 0\\ (3.131)$$

Da $p_{A}$ ein Polynom vom Grad $n$ ist, besitzt eine $n \\times n$-Matrix über den komplexen Zahlen unter Berücksichtigung algebraischer Vielfachheiten genau $n$ Eigenwerte. Über den reellen Zahlen müssen dagegen nicht alle Nullstellen reell sein.

Damit ist wichtig: Eine reelle Matrix besitzt nicht notwendigerweise ausschließlich reelle Eigenwerte.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `21` — `Definition 3.2.21` — Eigenraum

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.21`

**Quelltext:**

Zu einem Eigenwert $\\lambda$ definiere ich den Eigenraum durch

$$E_{\\lambda} = \\ker(A - \\lambda I)\\ (3.134)$$

Der Eigenraum enthält damit den Nullvektor und sämtliche Eigenvektoren, die zum Eigenwert $\\lambda$ gehören \\[71, 74, 82\\].

Die Eigenvektoren eines Eigenwerts bilden also zusammen mit dem Nullvektor einen Untervektorraum.

Für das vorherige Beispiel gilt beispielsweise

$$E_{2} = \\text{span}\\left\\{ \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} \\right\\},\\quad\\quad E_{3} = \\text{span}\\left\\{ \\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} \\right\\}\\ (3.135)$$

Jeder von null verschiedene Vektor aus $E_{2}$ bleibt unter $A$ auf derselben Geraden und wird mit $2$ skaliert. Entsprechend werden die Vektoren aus $E_{3}$ mit $3$ skaliert.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `22` — `Definition 3.2.22` — Spektrum

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `definition`
- `importance_level`: `supporting`
- downstream: `3.3` / `supporting` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.22`

**Quelltext:**

Für eine quadratische Matrix $A$ definiere ich

$$\\sigma(A) = \\left\\{ \\lambda \\middle| \\det(A - \\lambda I) = 0 \\right\\}\\ (3.145)$$

Das Spektrum enthält damit sämtliche Eigenwerte der Matrix.

Im endlichdimensionalen Fall ist diese Beschreibung unmittelbar mit dem charakteristischen Polynom verbunden. In allgemeineren funktionalanalytischen Räumen wird der Spektralbegriff umfassender und kann auch Werte enthalten, die nicht zu gewöhnlichen Eigenvektoren gehören. Diese Erweiterung benötige ich an dieser Stelle noch nicht.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `23` — `Definition 3.2.23` — Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.23`

**Quelltext:**

Eine quadratische Matrix\\
$$A \\in \\mathbb{R}^{n \\times n}$$

heißt diagonalisierbar, wenn eine invertierbare Matrix $P$ und eine Diagonalmatrix $D$ existieren, sodass

$$A = PDP^{- 1}\\ (3.147)$$

Dabei gilt:

-   $A$ ist die ursprüngliche Matrixdarstellung,

-   $P$ ist die Basiswechselmatrix,

-   $D$ ist die Diagonalmatrix,

-   $P^{- 1}$ ist die inverse Basiswechselmatrix.

Die Spalten von $P$ werden dabei aus linear unabhängigen Eigenvektoren von $A$ gebildet. Die zugehörigen Eigenwerte stehen in derselben Reihenfolge auf der Hauptdiagonale von $D$ \\[74\\].

Schreibe ich die Eigenvektoren als $v_{1},\\ldots,v_{n}$, dann hat $P$ die Form

$$P = \\begin{pmatrix}
v_{1} & v_{2} & \\cdots & v_{n}
\\end{pmatrix}\\ (3.148)$$

Die zugehörige Diagonalmatrix lautet

$$D = \\begin{pmatrix}
\\lambda_{1} & 0 & \\cdots & 0 \\\\
0 & \\lambda_{2} & \\cdots & 0 \\\\
 \\vdots & \\vdots & \\ddots & \\vdots \\\\
0 & 0 & \\cdots & \\lambda_{n}
\\end{pmatrix}\\ (3.149)$$

Dabei gehört $\\lambda_{i}$ jeweils zum Eigenvektor $v_{i}$.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `24` — `Definition 3.2.24` — Orthogonale Diagonalisierung

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `definition`
- `importance_level`: `supporting`
- downstream: `3.3` / `supporting` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.24`

**Quelltext:**

Eine reelle Matrix $A$ heißt orthogonal diagonalisierbar, wenn eine orthogonale Matrix $Q$ und eine Diagonalmatrix $\\Lambda$ existieren, sodass

$$Q^{T}AQ = \\Lambda\\ (3.167)$$

Für reelle Matrizen gilt der grundlegende Zusammenhang

$$A\\,\\text{orthogonal diagonalisierbar}\\quad \\Longleftrightarrow \\quad A = A^{T}\\ (3.168)$$

Damit besitzt jede reelle symmetrische Matrix eine orthonormale Eigenvektorbasis und ausschließlich reelle Eigenwerte \\[74\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `36` — `Eigenvektoren zu verschiedenen Eigenwerten` — Eigenvektoren zu verschiedenen Eigenwerten

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `statement`
- `importance_level`: `supporting`
- downstream: `3.3` / `supporting` — Begründet einen strukturellen Übergang in die Axiomatik; konkrete Zieluntersektion wird später präzisiert.

**Quelltext:**

Ein grundlegendes Ergebnis lautet: Eigenvektoren zu paarweise verschiedenen Eigenwerten sind linear unabhängig \\[71, 74, 82\\].

Sind $\\lambda_{1},\\ldots,\\lambda_{k}$ paarweise verschiedene Eigenwerte und $v_{1},\\ldots,v_{k}$ zugehörige Eigenvektoren, dann sind $v_{1},\\ldots,v_{k}$ linear unabhängig.

Diese Aussage ist strukturell wichtig, weil sie eine direkte Verbindung zwischen der Anzahl verschiedener Eigenwerte und der Möglichkeit einer Eigenvektorbasis herstellt.

Insbesondere besitzt eine $n \\times n$-Matrix mit $n$ paarweise verschiedenen Eigenwerten automatisch $n$ linear unabhängige Eigenvektoren.

**Kandidatennotiz:** Als Satz-/Ergebniskandidat aus der Quellfassung registriert; sichtbare Satznummer erst nach wissenschaftlicher Klassifikation.

##### repo_object_id `37` — `Voraussetzung der Diagonalisierbarkeit` — Voraussetzung der Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `statement`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet einen strukturellen Übergang in die Axiomatik; konkrete Zieluntersektion wird später präzisiert.

**Quelltext:**

Eine $n \\times n$-Matrix ist genau dann diagonalisierbar, wenn sie $n$ linear unabhängige Eigenvektoren besitzt \\[74\\]. Das offizielle MIT-Material formuliert die Diagonalisierung entsprechend über eine Matrix aus unabhängigen Eigenvektoren.

Damit gilt

$$A\\,\\text{diagonalisierbar}\\quad \\Longleftrightarrow \\quad A\\,\\text{besitzt }n\\text{ linear unabhängige Eigenvektoren}\\ (3.152)$$

Die Anzahl der Eigenwerte allein genügt dafür nicht. Entscheidend ist die Anzahl der **linear unabhängigen Eigenvektoren**.

Besitzt eine $n \\times n$-Matrix $n$ paarweise verschiedene Eigenwerte, so besitzt sie automatisch $n$ linear unabhängige Eigenvektoren und ist damit diagonalisierbar \\[74\\].

Daraus folgt die hinreichende Bedingung

$$\\lambda_{1},\\ldots,\\lambda_{n}\\,\\text{paarweise verschieden}\\quad \\Longrightarrow \\quad A\\,\\text{diagonalisierbar}\\ (3.153)$$

Die Umkehrung gilt jedoch nicht. Eine Matrix kann auch bei mehrfachen Eigenwerten diagonalisierbar sein, sofern die zugehörigen Eigenräume zusammen genügend unabhängige Eigenvektoren liefern.

**Kandidatennotiz:** Als Satz-/Ergebniskandidat aus der Quellfassung registriert; sichtbare Satznummer erst nach wissenschaftlicher Klassifikation.

##### repo_object_id `38` — `Spektralzerlegung` — Spektralzerlegung

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `statement`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet einen strukturellen Übergang in die Axiomatik; konkrete Zieluntersektion wird später präzisiert.

**Quelltext:**

Eine besonders starke Form der Diagonalisierung tritt bei reellen symmetrischen Matrizen auf. Strang behandelt symmetrische Matrizen unmittelbar in §6.4 und verweist dort ausdrücklich auf den Spektralsatz. Die offiziellen Lösungen bestätigen, dass die Eigenvektoren symmetrischer Matrizen orthogonal gewählt werden können. \\[74\\]

Für eine reelle symmetrische Matrix\\
$$A = A^{T}$$

existiert eine orthogonale Matrix $Q$, deren Spalten aus orthonormalen Eigenvektoren bestehen, sodass

$$A = Q\\Lambda Q^{T}\\ (3.165)$$

Dabei gilt:

-   $Q$ enthält orthonormale Eigenvektoren,

-   $Q^{T} = Q^{- 1}$,

-   $\\Lambda$ ist die Diagonalmatrix der reellen Eigenwerte.

Diese Aussage ist die endlichdimensionale Form des **Spektralsatzes für reelle symmetrische Matrizen** \\[74\\].

Die Orthogonalität bedeutet

$$Q^{T}Q = QQ^{T} = I\\ (3.166)$$

Damit ist die inverse Eigenvektormatrix besonders einfach:\\
$$Q^{- 1} = Q^{T}.$$

Diese Beziehung ist bereits Bestandteil von Gleichung (3.166) und wird deshalb nicht erneut nummeriert.

**Kandidatennotiz:** Als Satz-/Ergebniskandidat aus der Quellfassung registriert; sichtbare Satznummer erst nach wissenschaftlicher Klassifikation.

##### repo_object_id `167` — `(3.126)` — Definition 3.2.19: Eigenwert und Eigenvektor

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.126`
- Source line: `2377`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
Av = \\lambda v,\\quad\\quad v \\neq 0
```

##### repo_object_id `168` — `(3.127)` — Umformung der Eigenwertgleichung

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.127`
- Source line: `2399`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
(A - \\lambda I)v = 0
```

##### repo_object_id `169` — `(3.128)` — Umformung der Eigenwertgleichung

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.128`
- Source line: `2407`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
v \\in \\ker(A - \\lambda I),\\quad\\quad v \\neq 0
```

##### repo_object_id `170` — `(3.129)` — Charakteristische Gleichung

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.129`
- Source line: `2417`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\det(A - \\lambda I) = 0
```

##### repo_object_id `171` — `(3.130)` — Definition 3.2.20: Charakteristisches Polynom

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.130`
- Source line: `2427`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
p_{A}(\\lambda) = \\det(A - \\lambda I)
```

##### repo_object_id `172` — `(3.131)` — Definition 3.2.20: Charakteristisches Polynom

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.131`
- Source line: `2431`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
p_{A}(\\lambda) = 0
```

##### repo_object_id `175` — `(3.134)` — Definition 3.2.21: Eigenraum

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.134`
- Source line: `2485`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
E_{\\lambda} = \\ker(A - \\lambda I)
```

##### repo_object_id `176` — `(3.135)` — Definition 3.2.21: Eigenraum

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.135`
- Source line: `2493`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
E_{2} = \\text{span}\\left\\{ \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} \\right\\},\\quad\\quad E_{3} = \\text{span}\\left\\{ \\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} \\right\\}
```

##### repo_object_id `183` — `(3.142)` — Eigenwert null und Kern

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.142`
- Source line: `2589`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
0\\,\\text{ist Eigenwert von }A\\quad \\Longleftrightarrow \\quad\\ker(A) \\neq \\text{\\{}0\\text{\\}}
```

##### repo_object_id `184` — `(3.143)` — Eigenwert null und Kern

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.143`
- Source line: `2593`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
0\\,\\text{ist Eigenwert}\\quad \\Longleftrightarrow \\quad\\det(A) = 0\\quad \\Longleftrightarrow \\quad A\\,\\text{ist nicht invertierbar}
```

##### repo_object_id `185` — `(3.144)` — Eigenwerte unter einem Basiswechsel

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.144`
- Source line: `2606`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
p_{A_{C}}(\\lambda) = p_{A_{B}}(\\lambda)
```

##### repo_object_id `186` — `(3.145)` — Definition 3.2.22: Spektrum

- Herkunft: `3.2.10` — Eigenwerte, Eigenvektoren und Eigenräume
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.145`
- Source line: `2622`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\sigma(A) = \\left\\{ \\lambda \\middle| \\det(A - \\lambda I) = 0 \\right\\}
```

##### repo_object_id `188` — `(3.147)` — Definition 3.2.23: Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.147`
- Source line: `2747`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
A = PDP^{- 1}
```

##### repo_object_id `189` — `(3.148)` — Definition 3.2.23: Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.148`
- Source line: `2763`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
P = \\begin{pmatrix}
v_{1} & v_{2} & \\cdots & v_{n}
\\end{pmatrix}
```

##### repo_object_id `190` — `(3.149)` — Definition 3.2.23: Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.149`
- Source line: `2769`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
D = \\begin{pmatrix}
\\lambda_{1} & 0 & \\cdots & 0 \\\\
0 & \\lambda_{2} & \\cdots & 0 \\\\
 \\vdots & \\vdots & \\ddots & \\vdots \\\\
0 & 0 & \\cdots & \\lambda_{n}
\\end{pmatrix}
```

##### repo_object_id `191` — `(3.150)` — Zusammenhang zwischen Eigenvektoren und Diagonalmatrix

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.150`
- Source line: `2785`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
AP = PD
```

##### repo_object_id `192` — `(3.151)` — Zusammenhang zwischen Eigenvektoren und Diagonalmatrix

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `derived`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.151`
- Source line: `2801`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
D = P^{- 1}AP
```

##### repo_object_id `193` — `(3.152)` — Voraussetzung der Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.152`
- Source line: `2811`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
A\\,\\text{diagonalisierbar}\\quad \\Longleftrightarrow \\quad A\\,\\text{besitzt }n\\text{ linear unabhängige Eigenvektoren}
```

##### repo_object_id `194` — `(3.153)` — Voraussetzung der Diagonalisierbarkeit

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.153`
- Source line: `2819`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\lambda_{1},\\ldots,\\lambda_{n}\\,\\text{paarweise verschieden}\\quad \\Longrightarrow \\quad A\\,\\text{diagonalisierbar}
```

##### repo_object_id `206` — `(3.165)` — Spektralzerlegung

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.165`
- Source line: `3016`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
A = Q\\Lambda Q^{T}
```

##### repo_object_id `207` — `(3.166)` — Spektralzerlegung

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.166`
- Source line: `3030`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
Q^{T}Q = QQ^{T} = I
```

##### repo_object_id `208` — `(3.167)` — Definition 3.2.24: Orthogonale Diagonalisierung

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.167`
- Source line: `3041`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
Q^{T}AQ = \\Lambda
```

##### repo_object_id `209` — `(3.168)` — Definition 3.2.24: Orthogonale Diagonalisierung

- Herkunft: `3.2.11` — Diagonalisierung und Spektralzerlegung
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.168`
- Source line: `3045`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
A\\,\\text{orthogonal diagonalisierbar}\\quad \\Longleftrightarrow \\quad A = A^{T}
```

### 3.2.6 – Skalarprodukt-, Projektions- und Hilbertraumstrukturen

**Zweck:** Skalarprodukt, Norm, Orthogonalität, Projektion und der für die weitere Arbeit benötigte Hilbertraumanschluss; Vertiefungen in M6.

**Ausgangsobjekte:** 27

| repo_object_id | Typ | Herkunft | Quelllabel | Titel | importance | equation_role | downstream |
|---:|---|---|---|---|---|---|---|
| 25 | definition | 3.2.12 | Definition 3.2.25 | Skalarprodukt | core |  | 3.3 |
| 26 | definition | 3.2.12 | Definition 3.2.26 | Norm | core |  | 3.3 |
| 29 | definition | 3.2.12 | Definition 3.2.29 | Orthogonalität | core |  | 3.3 |
| 31 | definition | 3.2.12 | Definition 3.2.31 | Orthonormale Vektoren | supporting |  | 3.3 |
| 33 | definition | 3.2.12 | Definition 3.2.33 | Orthogonale Projektion auf einen Vektor | core |  | 3.3 |
| 220 | equation | 3.2.12 | (3.179) | Definition 3.2.25: Skalarprodukt | core | canonical | 3.3 |
| 221 | equation | 3.2.12 | (3.180) | Definition 3.2.25: Skalarprodukt | core | canonical | 3.3 |
| 222 | equation | 3.2.12 | (3.181) | Definition 3.2.25: Skalarprodukt | core | canonical | 3.3 |
| 223 | equation | 3.2.12 | (3.182) | Definition 3.2.25: Skalarprodukt | core | canonical | 3.3 |
| 224 | equation | 3.2.12 | (3.183) | Das euklidische Skalarprodukt | core | canonical | 3.3 |
| 225 | equation | 3.2.12 | (3.184) | Das euklidische Skalarprodukt | core | canonical | 3.3 |
| 226 | equation | 3.2.12 | (3.185) | Definition 3.2.26: Norm | core | canonical | 3.3 |
| 227 | equation | 3.2.12 | (3.186) | Definition 3.2.26: Norm | core | canonical | 3.3 |
| 228 | equation | 3.2.12 | (3.187) | Definition 3.2.26: Norm | core | canonical | 3.3 |
| 229 | equation | 3.2.12 | (3.188) | Definition 3.2.26: Norm | core | canonical | 3.3 |
| 230 | equation | 3.2.12 | (3.189) | Definition 3.2.26: Norm | core | canonical | 3.3 |
| 237 | equation | 3.2.12 | (3.196) | Definition 3.2.29: Orthogonalität | core | canonical | 3.3 |
| 242 | equation | 3.2.12 | (3.201) | Definition 3.2.31: Orthonormale Vektoren | supporting | canonical | 3.3 |
| 243 | equation | 3.2.12 | (3.202) | Definition 3.2.31: Orthonormale Vektoren | supporting | canonical | 3.3 |
| 244 | equation | 3.2.12 | (3.203) | Orthogonale Matrizen | supporting | canonical | 3.3 |
| 245 | equation | 3.2.12 | (3.204) | Orthogonale Matrizen | supporting | canonical | 3.3 |
| 246 | equation | 3.2.12 | (3.205) | Orthogonale Matrizen | supporting | canonical | 3.3 |
| 247 | equation | 3.2.12 | (3.206) | Orthogonale Matrizen | supporting | canonical | 3.3 |
| 251 | equation | 3.2.12 | (3.210) | Definition 3.2.33: Orthogonale Projektion auf einen Vektor | core | canonical | 3.3 |
| 252 | equation | 3.2.12 | (3.211) | Definition 3.2.33: Orthogonale Projektion auf einen Vektor | core | canonical | 3.3 |
| 272 | equation | 3.2.12 | (3.231) | Ein allgemeineres Skalarprodukt | core | canonical | 3.3 |
| 273 | equation | 3.2.12 | (3.232) | Ein allgemeineres Skalarprodukt | core | canonical | 3.3 |

#### Quellpayloads

##### repo_object_id `25` — `Definition 3.2.25` — Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.25`

**Quelltext:**

Sei (V) ein reeller Vektorraum. Ein Skalarprodukt ist eine Abbildung

$$\\left\\langle \\cdot , \\cdot \\right\\rangle:V \\times V\\mathbb{\\longrightarrow R,\\quad\\quad}(x,y) \\longmapsto \\left\\langle x,y \\right\\rangle.\\ (3.179)$$

Dabei sind

-   \\(V\\) der betrachtete reelle Vektorraum,

-   (x,y\\\\in V) zwei Vektoren,

-   (\\\\langle x,y\\\\rangle) der durch das Skalarprodukt erzeugte reelle Skalar.

Damit eine solche Abbildung ein Skalarprodukt ist, muss sie bestimmte Eigenschaften erfüllen. Für alle (x,y,z\\\\in V) und alle (\\\\alpha,\\\\beta\\\\inℝ) fordere ich zunächst Linearität:

$$\\langle\\alpha x + \\beta y,z\\rangle = \\alpha\\langle x,z\\rangle + \\beta\\langle y,z\\rangle\\ (3.180)$$

Außerdem fordere ich Symmetrie:

$$\\langle x,y\\rangle = \\langle y,x\\rangle\\ (3.181)$$

Schließlich muss das Skalarprodukt positiv definit sein:

$$\\left\\langle x,x \\right\\rangle \\geq 0,\\quad\\quad\\left\\langle x,x \\right\\rangle = 0 \\Longleftrightarrow x = 0\\ (3.182)$$

Diese Eigenschaften bilden gemeinsam die mathematische Grundlage dafür, aus dem Skalarprodukt geometrische Größen abzuleiten \\[84\\]. Kapitel 6.1 von Friedberg, Insel und Spence ist ausdrücklich den „Inner Products and Norms" gewidmet.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `26` — `Definition 3.2.26` — Norm

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.26`

**Quelltext:**

Aus einem Skalarprodukt kann ich unmittelbar die Länge eines Vektors ableiten. Die vom Skalarprodukt induzierte Norm definiere ich durch

$$\\text{|}x\\text{|} = \\sqrt{\\left\\langle x,x \\right\\rangle}\\ (3.185)$$

Dabei bezeichnet

-   \\(x\\) den betrachteten Vektor,

-   (\\\\langle x,x\\\\rangle) sein Skalarprodukt mit sich selbst,

-   (\\|x\\|) seine durch das Skalarprodukt induzierte Norm.

Für das euklidische Skalarprodukt folgt daraus

$$\\text{|}x\\text{|} = \\sqrt{x_{1}^{2} + x_{2}^{2} + \\cdots + x_{n}^{2}}\\ (3.186)$$

Damit verallgemeinere ich unmittelbar den Satz des Pythagoras auf den (n)-dimensionalen euklidischen Raum. Diese Definition der Norm aus dem Skalarprodukt ist Standardbestandteil der Theorie der Skalarprodukträume \\[84\\].

Eine Norm erfüllt insbesondere

**Word-LaTeX:**

$$\\text{|}x\\text{|} \\geq 0,\\quad\\quad\\text{|}x\\text{|} = 0 \\Longleftrightarrow x = 0\\ (3.187)$$

Für die Multiplikation eines Vektors mit einem Skalar gilt

$$\\text{|}\\alpha x\\text{|} = |\\alpha|\\,\\text{|}x\\text{|}\\ (3.188)$$

Außerdem gilt die Dreiecksungleichung

$$\\text{|}x + y\\text{|} \\leq \\text{|}x\\text{|} + \\text{|}y\\text{|}\\ (3.189)$$

Damit besitzt die Norm genau diejenigen Eigenschaften, die ich von einem mathematischen Längenbegriff erwarte.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `29` — `Definition 3.2.29` — Orthogonalität

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.29`

**Quelltext:**

Zwei Vektoren (x,y\\\\in V) heißen orthogonal, wenn ihr Skalarprodukt null ist:

$$x\\bot y\\quad \\Longleftrightarrow \\quad\\left\\langle x,y \\right\\rangle = 0\\ (3.196)$$

Für zwei von null verschiedene Vektoren bedeutet dies nach Gleichung (3.194), dass\\
$$\\cos\\theta = 0,$$

also ein rechter Winkel vorliegt.

Strang entwickelt Orthogonalität, Projektionen und orthogonale Basen zusammenhängend in Kapitel 4 \\[74\\]. Friedberg, Insel und Spence behandeln dieselbe Struktur in Kapitel 6 über Skalarprodukträume und orthogonale Komplemente \\[84\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `31` — `Definition 3.2.31` — Orthonormale Vektoren

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `definition`
- `importance_level`: `supporting`
- downstream: `3.3` / `supporting` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.31`

**Quelltext:**

Eine Menge von Vektoren

$$q_{1},\\ldots,q_{m}$$

heißt orthonormal, wenn die Vektoren paarweise orthogonal und jeweils normiert sind. Beides kann ich kompakt durch

$$\\left\\langle q_{i},q_{j} \\right\\rangle = \\delta_{ij}\\ (3.201)$$

ausdrücken.

Dabei ist (δ\\_{ij}) das Kronecker-Delta mit den beiden Fällen

-   (δ\\_{ij}=1) für (i=j),

-   (δ\\_{ij}=0) für (i\\\\neq j).

Die beiden Werte sind lediglich die Definition der in Gleichung (3.201) verwendeten Größe (δ\\_{ij}) und werden deshalb nicht als eigenständige nummerierte Gleichungen geführt.

Für eine orthonormale Basis (q_1,\\\\ldots,q_n) kann ich jeden Vektor (x\\\\in V) eindeutig darstellen als

$$x = \\sum_{i = 1}^{n}{\\left\\langle q_{i},x \\right\\rangle q_{i}}\\ (3.202)$$

Die Koordinate des Vektors entlang der Basisrichtung (q_i) ist damit unmittelbar sein Skalarprodukt mit (q_i).

Diese Eigenschaft erklärt rückwirkend die in Abschnitt 3.2.11 verwendete Darstellung eines Vektors in einer orthonormalen Eigenbasis.

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `33` — `Definition 3.2.33` — Orthogonale Projektion auf einen Vektor

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `definition`
- `importance_level`: `core`
- downstream: `3.3` / `required` — Begründet den mathematischen Hauptpfad als Voraussetzung für die FRZK-Axiomatik; Feingranulare 3.3.x-Zuordnung erfolgt nach Vorliegen der verbindlichen 3.3-Struktur.
- Quellnummer: `3.2.33`

**Quelltext:**

Sei (u\\\\neq0). Die orthogonale Projektion eines Vektors (x) auf die von (u) aufgespannte Richtung ist

$$proj_{u}(x) = \\frac{\\left\\langle x,u \\right\\rangle}{\\left\\langle u,u \\right\\rangle}u\\ (3.210)$$

Dabei sind

-   \\(x\\) der zu projizierende Vektor,

-   (u\\\\neq0) die Projektionsrichtung,

-   (\\\\langle x,u\\\\rangle/\\\\langle u,u\\\\rangle) der skalare Projektionsfaktor,

-   (\\\\text{proj}\\_{u}(x)) der auf (u) liegende Anteil von (x).

Ist (u) bereits normiert, also (\\|u\\|=1), vereinfacht sich die Projektion zu

$$\\text{proj}_{u}(x) = \\left\\langle x,u \\right\\rangle u\\ (3.211)$$

Strang behandelt Projektionen ausdrücklich in §4.2 \\[74\\].

**Kandidatennotiz:** Quellbestand; sichtbare Nummer wird erst nach redaktioneller Freigabe als definition_number übernommen.

##### repo_object_id `220` — `(3.179)` — Definition 3.2.25: Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.179`
- Source line: `3222`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\langle \\cdot , \\cdot \\right\\rangle:V \\times V\\mathbb{\\longrightarrow R,\\quad\\quad}(x,y) \\longmapsto \\left\\langle x,y \\right\\rangle.
```

##### repo_object_id `221` — `(3.180)` — Definition 3.2.25: Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.180`
- Source line: `3234`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\langle\\alpha x + \\beta y,z\\rangle = \\alpha\\langle x,z\\rangle + \\beta\\langle y,z\\rangle
```

##### repo_object_id `222` — `(3.181)` — Definition 3.2.25: Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.181`
- Source line: `3238`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\langle x,y\\rangle = \\langle y,x\\rangle
```

##### repo_object_id `223` — `(3.182)` — Definition 3.2.25: Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.182`
- Source line: `3242`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\langle x,x \\right\\rangle \\geq 0,\\quad\\quad\\left\\langle x,x \\right\\rangle = 0 \\Longleftrightarrow x = 0
```

##### repo_object_id `224` — `(3.183)` — Das euklidische Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.183`
- Source line: `3261`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\langle x,y \\right\\rangle = x^{T}y = \\sum_{i = 1}^{n}{x_{i}y_{i}}
```

##### repo_object_id `225` — `(3.184)` — Das euklidische Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.184`
- Source line: `3275`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\langle x,y \\right\\rangle = x_{1}y_{1} + x_{2}y_{2}
```

##### repo_object_id `226` — `(3.185)` — Definition 3.2.26: Norm

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.185`
- Source line: `3283`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}x\\text{|} = \\sqrt{\\left\\langle x,x \\right\\rangle}
```

##### repo_object_id `227` — `(3.186)` — Definition 3.2.26: Norm

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.186`
- Source line: `3295`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}x\\text{|} = \\sqrt{x_{1}^{2} + x_{2}^{2} + \\cdots + x_{n}^{2}}
```

##### repo_object_id `228` — `(3.187)` — Definition 3.2.26: Norm

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.187`
- Source line: `3303`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}x\\text{|} \\geq 0,\\quad\\quad\\text{|}x\\text{|} = 0 \\Longleftrightarrow x = 0
```

##### repo_object_id `229` — `(3.188)` — Definition 3.2.26: Norm

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.188`
- Source line: `3307`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}\\alpha x\\text{|} = |\\alpha|\\,\\text{|}x\\text{|}
```

##### repo_object_id `230` — `(3.189)` — Definition 3.2.26: Norm

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.189`
- Source line: `3311`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}x + y\\text{|} \\leq \\text{|}x\\text{|} + \\text{|}y\\text{|}
```

##### repo_object_id `237` — `(3.196)` — Definition 3.2.29: Orthogonalität

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.196`
- Source line: `3377`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
x\\bot y\\quad \\Longleftrightarrow \\quad\\left\\langle x,y \\right\\rangle = 0
```

##### repo_object_id `242` — `(3.201)` — Definition 3.2.31: Orthonormale Vektoren

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.201`
- Source line: `3432`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\langle q_{i},q_{j} \\right\\rangle = \\delta_{ij}
```

##### repo_object_id `243` — `(3.202)` — Definition 3.2.31: Orthonormale Vektoren

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.202`
- Source line: `3446`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
x = \\sum_{i = 1}^{n}{\\left\\langle q_{i},x \\right\\rangle q_{i}}
```

##### repo_object_id `244` — `(3.203)` — Orthogonale Matrizen

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.203`
- Source line: `3456`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
Q^{T}Q = I
```

##### repo_object_id `245` — `(3.204)` — Orthogonale Matrizen

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.204`
- Source line: `3460`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
Q^{- 1} = Q^{T}
```

##### repo_object_id `246` — `(3.205)` — Orthogonale Matrizen

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.205`
- Source line: `3466`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\langle Qx,Qy\\rangle = \\langle x,y\\rangle
```

##### repo_object_id `247` — `(3.206)` — Orthogonale Matrizen

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `supporting`
- `equation_role`: `canonical`
- downstream: `3.3` / `supporting` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.206`
- Source line: `3470`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}Qx\\text{|} = \\text{|}x\\text{|}
```

##### repo_object_id `251` — `(3.210)` — Definition 3.2.33: Orthogonale Projektion auf einen Vektor

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.210`
- Source line: `3506`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
proj_{u}(x) = \\frac{\\left\\langle x,u \\right\\rangle}{\\left\\langle u,u \\right\\rangle}u
```

##### repo_object_id `252` — `(3.211)` — Definition 3.2.33: Orthogonale Projektion auf einen Vektor

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.211`
- Source line: `3520`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{proj}_{u}(x) = \\left\\langle x,u \\right\\rangle u
```

##### repo_object_id `272` — `(3.231)` — Ein allgemeineres Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.231`
- Source line: `3673`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\left\\langle x,y \\right\\rangle_{G} = x^{T}Gy
```

##### repo_object_id `273` — `(3.232)` — Ein allgemeineres Skalarprodukt

- Herkunft: `3.2.12` — Skalarprodukt, Norm und Orthogonalität
- Typ: `equation`
- `importance_level`: `core`
- `equation_role`: `canonical`
- downstream: `3.3` / `required` — Formaler Bestandteil des mathematischen Hauptpfads; konkrete 3.3.x-Abhängigkeit wird bei der 3.3-Neufassung aufgelöst.
- Quellnummer: `3.232`
- Source line: `3685`
- Nummernursprung: `explicit`
- Integritätsstatus: `ok`

**Quell-LaTeX:**

```text
\\text{|}x\\text{|}_{G} = \\sqrt{x^{T}Gx}
```

### 3.2.7 – Mathematische Anschlussstruktur für das FRZK

Verdichtete Synthese: Welche mathematischen Strukturen stehen Kapitel 3.3 zur Verfügung, welche Voraussetzungen tragen sie und welche Aussagen folgen gerade noch nicht aus der Mathematik.

Dieser Abschnitt ist eine neue Syntheseebene und darf keine neuen Primäraxiome oder FRZK-spezifischen mathematischen Setzungen einführen.

## 16. Finaler Anlagenbezug im Haupttext

Nach Realisierung der Anlagen darf der Haupttext **keinen vorläufigen Anlagenanker aus Revision 5 ungeprüft übernehmen**. Der tatsächliche finale Verweis wird aus der neuesten DB aufgelöst. Empfohlene Abfrage:

```sql
SELECT
    am.appendix_code,
    aps.section_code AS appendix_section_code,
    aps.title AS appendix_section_title,
    mop.appendix_anchor,
    ro.repo_object_id,
    ro.object_label,
    ro.object_title,
    aop.placement_role,
    aop.placement_order
FROM repository_objects ro
JOIN mathematical_object_profiles mop
  ON mop.repo_object_id = ro.repo_object_id
JOIN appendix_modules am
  ON am.appendix_module_id = mop.appendix_module_id
JOIN appendix_object_placements aop
  ON aop.repo_object_id = ro.repo_object_id
JOIN appendix_sections aps
  ON aps.appendix_section_id = aop.appendix_section_id
WHERE mop.document_location = 'appendix'
ORDER BY am.sort_order, aps.sort_order, aop.placement_order;
```

Ein Anlagenverweis im Haupttext soll fachlich zielgerichtet sein: nicht „siehe Anlage M5“ pauschal, sondern möglichst auf den tatsächlich einschlägigen Anlagenabschnitt beziehungsweise stabilen Objektanker.

## 17. Deep-Research-Quellenregister

Die folgenden Quellen bilden die aktuell recherchierte Evidenzschicht für Kapitel 3.2. URLs sind technische Recherchemetadaten und gehören **nicht** in den Dissertationstext.

| [Nr.] | Verifizierte bibliografische Angabe | Metadatenstatus | Primärnachweis |
|---:|---|---|---|
| [6] | Halmos, Paul R.: Naive Set Theory. Springer New York, 1974 (für die Deep-Research-Fundstellen verwendete Springer-Ausgabe). | `verified` | https://link.springer.com/book/10.1007/978-1-4757-1645-0 |
| [67] | Resnik, Michael D.: Mathematics as a Science of Patterns. Oxford: Clarendon Press, 1997. | `verified` | https://books.google.com/books/about/Mathematics_as_a_Science_of_Patterns.html?id=SN_nCwAAQBAJ |
| [68] | Shapiro, Stewart: Philosophy of Mathematics: Structure and Ontology. New York: Oxford University Press, 1997. | `verified` | https://academic.oup.com/book/32743/chapter-abstract/272846529 |
| [71] | Lang, Serge: Algebra. Revised Third Edition. New York: Springer, 2002. | `verified` | https://link.springer.com/book/10.1007/978-1-4613-0041-0 |
| [72] | Rudin, Walter: Principles of Mathematical Analysis. Third Edition. New York: McGraw-Hill, 1976. | `verified` | https://www.mheducation.me/principles-of-mathematical-analysis-int-l-ed-9780070856134-mea |
| [73] | Munkres, James R.: Topology. Second Edition. Upper Saddle River, NJ: Prentice Hall, 2000. | `verified` | https://www.pearson.com/en-us/subject-catalog/p/Munkres-Topology-Classic-Version-2nd-Edition/P200000006299 |
| [74] | Strang, Gilbert: Introduction to Linear Algebra. Fifth Edition. Wellesley, MA: Wellesley-Cambridge Press, 2016. | `verified` | https://math.mit.edu/~gs/linearalgebra/ila5/index.html |
| [75] | Kreyszig, Erwin: Introductory Functional Analysis with Applications. New York: John Wiley & Sons, 1978. | `verified` | https://books.google.com/books?id=Va8rAAAAYAAJ |
| [76] | Reed, Michael; Simon, Barry: Methods of Modern Mathematical Physics. Volume I: Functional Analysis. Revised Edition. Academic Press, 1980. | `verified` | https://books.google.com/books?id=bvuRuwuFBWwC |
| [77] | Diestel, Reinhard: Graph Theory. Fifth Edition. Berlin/Heidelberg: Springer, 2017. | `verified` | https://link.springer.com/book/10.1007/978-3-662-53622-3 |
| [78] | Mac Lane, Saunders: Categories for the Working Mathematician. Second Edition. New York: Springer, 1998. | `verified` | https://link.springer.com/book/10.1007/978-1-4757-4721-8 |
| [79] | Kleene, Stephen C.: Introduction to Metamathematics. 1952. | `conflict` | https://books.google.com/books/about/Introduction_to_Metamathematics.html?id=gFgPAQAAMAAJ |
| [80] | Enderton, Herbert B.: Elements of Set Theory. New York/San Francisco/London: Academic Press, 1977. | `verified` | https://shop.elsevier.com/books/elements-of-set-theory/enderton/978-0-08-057042-6 |
| [81] | Jech, Thomas: Set Theory. The Third Millennium Edition, Revised and Expanded. Berlin/Heidelberg: Springer, 2003. | `verified` | https://link.springer.com/book/10.1007/3-540-44761-X |
| [82] | Halmos, Paul R.: Finite-Dimensional Vector Spaces. New York: Springer, 1974. | `verified` | https://link.springer.com/book/10.1007/978-1-4612-6387-6 |
| [83] | Bartle, Robert G.; Sherbert, Donald R.: Introduction to Real Analysis. Fourth Edition. Hoboken, NJ: John Wiley & Sons, 2011. | `verified` | https://www.wiley-vch.de/en/areas-interest/mathematics-statistics/introduction-to-real-analysis-978-0-471-43331-6 |
| [84] | Friedberg, Stephen H.; Insel, Arnold J.; Spence, Lawrence E.: Linear Algebra. Fifth Edition. Pearson, 2018. | `verified` | https://www.pearson.com/en-us/subject-catalog/p/Friedberg-Linear-Algebra-Subscription-5th-Edition/P200000006185/9780137515424 |

## 18. Vollständige Deep-Research-Evidenzmatrix

Jede Belegverwendung muss aus dieser Schicht oder aus einer späteren, revisionsgesichert ergänzten Evidenz stammen.

### Evidence 1 – [6] Naive Set Theory

- Verwendung: `source_usage_id=83`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [6] stützt die Einordnung der Mengenlehre als grundlegenden mathematischen Werkzeugbestand und die Abfolge von Mengenoperationen über Relationen zu Funktionen.
- Exakte Fundstelle: The Axiom of Extension, S. 1–3; Unions and Intersections, S. 12–16; Ordered Pairs, S. 22–25; Relations, S. 26–29; Functions, S. 30–33.
- Textanker: Relations; Functions; Inverses and Composites
- Verifizierte Paraphrase: Die Springer-Gliederung zeigt, dass Halmos genau die in 3.2.0 angekündigten mengentheoretischen Grundobjekte und Abbildungsbegriffe systematisch aufbaut.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4757-1645-0

### Evidence 2 – [71] Algebra

- Verwendung: `source_usage_id=84`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt die Einordnung von Gruppen, Ringen, Moduln sowie Matrizen und linearen Abbildungen als algebraische Grundstrukturen.
- Exakte Fundstelle: Groups, S. 3–82; Rings, S. 83–116; Modules, S. 117–172; Matrices and Linear Maps, S. 503–552.
- Textanker: Groups; Rings; Modules; Matrices and Linear Maps
- Verifizierte Paraphrase: Langs Inhaltsstruktur deckt die im Absatz genannten algebraischen Strukturen und die spätere lineare Abbildungstheorie unmittelbar ab.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 3 – [72] Principles of Mathematical Analysis

- Verwendung: `source_usage_id=85`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [72] stützt die Einordnung von Konvergenz, Stetigkeit, Differentiation und Integration in der Analysis.
- Exakte Fundstelle: Kap. 3 Numerical Sequences and Series; Kap. 4 Continuity; Kap. 5 Differentiation; Kap. 6 The Riemann-Stieltjes Integral; Kap. 7 Sequences and Series of Functions.
- Textanker: Continuity; Differentiation; The Riemann-Stieltjes Integral
- Verifizierte Paraphrase: Die offizielle McGraw-Hill-Gliederung weist die im Dissertationstext genannten Kernbereiche der Analysis als eigene Kapitel aus.
- Quelle URL: https://www.mheducation.me/principles-of-mathematical-analysis-int-l-ed-9780070856134-mea

### Evidence 4 – [73] Topology

- Verwendung: `source_usage_id=86`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [73] stützt topologische Räume, Stetigkeit, Zusammenhang, Kompaktheit und Trennungsaxiome; die Topologie wird vor metrischen Spezialstrukturen entwickelt.
- Exakte Fundstelle: 2. Aufl.: §§12–17 Topologies/Closed Sets; §§18–19 Continuous Functions; §§20–21 Metric Topologies; §§23–29 Connectedness/Compactness; §§30–32 Countability/Separation Axioms.
- Textanker: Topological Spaces and Continuous Functions; Connectedness and Compactness
- Verifizierte Paraphrase: Pearson und die von Munkres selbst gelehrte MIT-Leseliste bestätigen die Reihenfolge und die genannten Themen.
- Quelle URL: https://ocw.mit.edu/courses/18-901-introduction-to-topology-fall-2004/pages/readings/
- Verifikation URL: https://www.pearson.com/en-us/subject-catalog/p/Munkres-Topology-Classic-Version-2nd-Edition/P200000006299

### Evidence 5 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=87`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Vektorräume, Matrizen, Basis/Dimension, Determinanten, Eigenwerte und lineare Transformationen.
- Exakte Fundstelle: Kap. 3, S. 123 ff.; Kap. 5, S. 247 ff.; Kap. 6, S. 288 ff.; Kap. 8, S. 401 ff.
- Textanker: Vector Spaces and Subspaces; Determinants; Eigenvalues and Eigenvectors; Linear Transformations
- Verifizierte Paraphrase: Das offizielle Inhaltsverzeichnis der 5. Auflage deckt genau die in 3.2.0 als lineare Algebra angekündigten Werkzeuge ab.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 6 – [75] Introductory Functional Analysis with Applications

- Verwendung: `source_usage_id=88`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [75] stützt normierte Räume, Banach- und Hilberträume, lineare Operatoren/Funktionale und Spektraltheorie.
- Exakte Fundstelle: Normed Spaces/Banach Spaces ab S. 49; Linear Operators ab S. 82; Linear Functionals ab S. 103; Inner Product/Hilbert Spaces ab S. 127; Spectral Theory of Bounded Self-Adjoint Linear Operators ab S. 459.
- Textanker: Normed Spaces; Banach Spaces; Inner Product Spaces; Hilbert Spaces; Spectral Theory
- Verifizierte Paraphrase: Die Inhaltsübersichten der Ausgabe 1978 und der Wiley-Neuauflage stimmen in diesen Kernbereichen überein.
- Quelle URL: https://books.google.com/books?id=Va8rAAAAYAAJ
- Verifikation URL: https://www.wiley-vch.de/de/fachgebiete/mathematik-und-statistik/introductory-functional-analysis-with-applications-978-0-471-50459-7

### Evidence 7 – [76] Methods of Modern Mathematical Physics

- Verwendung: `source_usage_id=89`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [76] stützt Hilberträume, normierte lineare Räume, Operatoren, Spektrum und Spektralsatz.
- Exakte Fundstelle: Kap. II Hilbert Spaces, S. 36 ff.; Kap. III Banach Spaces, S. 67 ff.; Kap. VI Bounded Operators, S. 182 ff.; Kap. VII The Spectral Theorem, S. 221 ff.
- Textanker: Hilbert Spaces; Bounded Operators; The Spectral Theorem
- Verifizierte Paraphrase: Reed/Simon behandeln die im Absatz genannten funktionalanalytischen Strukturen ausdrücklich in eigenen Kapiteln.
- Quelle URL: https://books.google.com/books?id=bvuRuwuFBWwC
- Verifikation URL: https://shop.elsevier.com/books/methods-of-modern-mathematical-physics/reed/978-0-12-585001-8

### Evidence 8 – [77] Graph Theory

- Verwendung: `source_usage_id=90`, Abschnitt `3.2.0`
- Modus: `direct_quote`; Passung: `direct`; Status: `verified`; Copyright: `short_excerpt`
- Gestützte Aussage: [77] stützt die Grundidee diskreter Strukturen aus Knoten/Vertices und Kanten/Edges.
- Exakte Fundstelle: Kap. 1 The Basics, §1.1 Graphs, gedruckte S. 2 (PDF-Seite 21).
- Textanker: §1.1 Graphs
- Verifizierte Paraphrase: Diestel definiert einen Graphen als Paar aus Knotenmenge und Kantenmenge und erläutert anschließend Vertices und Edges.
- Verifizierter Kurzauszug: “A graph is a pair G = (V,E) of sets.”
- Quelle URL: https://link.springer.com/book/10.1007/978-3-662-53622-3
- Verifikation URL: https://daiwz.net/course/disc_math/2023/Diestel_Graph_Theory.pdf

### Evidence 9 – [78] Categories for the Working Mathematician

- Verwendung: `source_usage_id=91`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [78] stützt die kategorientheoretische Beschreibung mathematischer Strukturen über Objekte, Morphismen/Funktoren und strukturerhaltende Beziehungen.
- Exakte Fundstelle: Kap. Categories, Functors, and Natural Transformations, S. 7–30; Constructions on Categories, S. 31–53.
- Textanker: Categories, Functors, and Natural Transformations
- Verifizierte Paraphrase: Die Kapitelstruktur belegt den Übergang von Einzelobjekten zu morphismen- und funktororientierter Strukturbetrachtung.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4757-4721-8

### Evidence 10 – [79] Introduction to Metamathematics

- Verwendung: `source_usage_id=92`, Abschnitt `3.2.0`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `partial`; Copyright: `location_only`
- Gestützte Aussage: [79] stützt die Unterscheidung formaler Symbole, Formationsregeln, Transformationsregeln, Postulate/Axiome und formale Theoreme.
- Exakte Fundstelle: Kap. IV A Formal System, S. 69–85; §§16–19, insbesondere §19 Transformation Rules, S. 81 ff.
- Textanker: A Formal System; Transformation Rules
- Verifizierte Paraphrase: Die recherchierte Gliederung und Textnachweise zeigen den Aufbau eines formalen Systems aus Syntax, Bildungsregeln, Postulaten und Schlussregeln.
- Quelle URL: https://books.google.com/books/about/Introduction_to_Metamathematics.html?id=gFgPAQAAMAAJ
- Hinweise: Die genaue 1952-Ausgabe ist bibliographisch zu klären; Fundstelle ist editionsabhängig vor Endfassung erneut abzugleichen.

### Evidence 11 – [6] Naive Set Theory

- Verwendung: `source_usage_id=93`, Abschnitt `3.2.1`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [6] stützt Mengen, Teilmengen/Mengenoperationen, Potenzmengen, geordnete Paare, Relationen und Funktionen.
- Exakte Fundstelle: Extension S. 1–3; Specification S. 4–7; Unordered Pairs S. 8–11; Unions/Intersections S. 12–16; Complements/Powers S. 17–21; Ordered Pairs S. 22–25; Relations S. 26–29.
- Textanker: Unions and Intersections; Complements and Powers; Ordered Pairs; Relations
- Verifizierte Paraphrase: Die Fundstellen entsprechen unmittelbar dem Aufbau von 3.2.1.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4757-1645-0

### Evidence 12 – [67] Mathematics as a Science of Patterns

- Verwendung: `source_usage_id=94`, Abschnitt `3.2.1`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [67] stützt die strukturorientierte Sicht, nach der mathematische Objekte wesentlich als Positionen in Mustern/Strukturen betrachtet werden.
- Exakte Fundstelle: Kap. 10 Mathematical Objects as Positions in Patterns, S. 201–223; §2 Patterns and their Relationships, S. 202–208; §3 Patterns and Positions: Entity and Identity, S. 209–212.
- Textanker: Mathematical Objects as Positions in Patterns
- Verifizierte Paraphrase: Resnik entwickelt die Identität mathematischer Objekte über ihre Position in Mustern und die Relationen innerhalb dieser Muster.
- Quelle URL: https://books.google.com/books/about/Mathematics_as_a_Science_of_Patterns.html?id=SN_nCwAAQBAJ
- Verifikation URL: https://academic.oup.com/book/32824/chapter-abstract/275104225

### Evidence 13 – [68] Philosophy of Mathematics. Structure and Ontology

- Verwendung: `source_usage_id=95`, Abschnitt `3.2.1`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [68] stützt strukturalistische Auffassungen mathematischer Objekte als Plätze innerhalb von Strukturen.
- Exakte Fundstelle: Kap. 3 Structure, S. 71–108.
- Textanker: Structure
- Verifizierte Paraphrase: Shapiros Kapitel behandelt den Status von Strukturen und ausdrücklich den Status mathematischer Objekte als Plätze innerhalb solcher Strukturen.
- Quelle URL: https://academic.oup.com/book/32743/chapter-abstract/272846529

### Evidence 14 – [78] Categories for the Working Mathematician

- Verwendung: `source_usage_id=96`, Abschnitt `3.2.1`
- Modus: `location_paraphrase`; Passung: `partial`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [78] stützt den strukturellen Fokus auf Objekte und Morphismen; die im Text zusätzlich verwendete allgemeine Relationssprache stammt nicht spezifisch aus der Kategorientheorie.
- Exakte Fundstelle: Categories, Functors, and Natural Transformations, S. 7–30.
- Textanker: Categories, Functors, and Natural Transformations
- Verifizierte Paraphrase: Mac Lane liefert belastbare Stützung für Objekte und strukturierte Abbildungen/Morphismen, aber nicht als Primärquelle für die allgemeine binäre Relationsdefinition.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4757-4721-8

### Evidence 15 – [80] Elements of Set Theory

- Verwendung: `source_usage_id=97`, Abschnitt `3.2.1`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [80] stützt axiomatische Mengenoperationen, geordnete Paare, Relationen, Funktionen und kartesische Produkte.
- Exakte Fundstelle: Kap. 2 Axioms and Operations; Kap. 3 Relations and Functions: Ordered Pairs, Relations, n-Ary Relations, Functions, Infinite Cartesian Products.
- Textanker: Axioms and Operations; Relations and Functions
- Verifizierte Paraphrase: Endertons Kapitelstruktur entspricht unmittelbar den in 3.2.1 eingeführten mengentheoretischen Operationen und Relationsbegriffen.
- Quelle URL: https://shop.elsevier.com/books/elements-of-set-theory/enderton/978-0-08-057042-6

### Evidence 16 – [81] Set Theory

- Verwendung: `source_usage_id=98`, Abschnitt `3.2.1`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [81] stützt die axiomatische Einordnung der Mengenlehre sowie Ordinal-/Kardinalzahlen und Auswahlprinzipien.
- Exakte Fundstelle: Basic Set Theory: Axioms of Set Theory S. 3–15; Ordinal Numbers S. 17–26; Cardinal Numbers S. 27–35; Axiom of Choice and Cardinal Arithmetic S. 47–61.
- Textanker: Axioms of Set Theory; Ordinal Numbers; Cardinal Numbers
- Verifizierte Paraphrase: Jechs offizielles Inhaltsverzeichnis belegt genau die im Text genannten weiterführenden Bereiche.
- Quelle URL: https://link.springer.com/book/10.1007/3-540-44761-X

### Evidence 17 – [71] Algebra

- Verwendung: `source_usage_id=99`, Abschnitt `3.2.2`
- Modus: `location_paraphrase`; Passung: `supporting`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Abbildungen/lineare Abbildungen im algebraischen Kontext; für die mengentheoretische Funktionsdefinition ist Enderton die direktere Quelle.
- Exakte Fundstelle: Matrices and Linear Maps, S. 503–552.
- Textanker: Matrices and Linear Maps
- Verifizierte Paraphrase: Lang zeigt die strukturelle Verwendung von Abbildungen und linearen Maps in der Algebra.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 18 – [72] Principles of Mathematical Analysis

- Verwendung: `source_usage_id=100`, Abschnitt `3.2.2`
- Modus: `location_paraphrase`; Passung: `supporting`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [72] stützt Funktionen als zentralen Gegenstand der Analysis sowie Grenzwerte, Stetigkeit und Differentiation.
- Exakte Fundstelle: Kap. 4 Continuity; Kap. 5 Differentiation; Kap. 9 Functions of Several Variables.
- Textanker: Continuity; Differentiation; Functions of Several Variables
- Verifizierte Paraphrase: Rudin entwickelt analytische Eigenschaften von Funktionen; die reine mengentheoretische Funktionsdefinition wird besser durch Enderton gestützt.
- Quelle URL: https://www.mheducation.me/principles-of-mathematical-analysis-int-l-ed-9780070856134-mea

### Evidence 19 – [80] Elements of Set Theory

- Verwendung: `source_usage_id=101`, Abschnitt `3.2.2`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [80] stützt die Definition von Funktionen aus dem Relationsbegriff sowie geordnete Paare und kartesische Produkte.
- Exakte Fundstelle: Kap. 3 Relations and Functions, insbesondere Ordered Pairs, Relations, Functions.
- Textanker: Relations and Functions
- Verifizierte Paraphrase: Enderton ist für die in 3.2.2 verwendete mengentheoretische Funktionsdefinition die direkt passende Quelle.
- Quelle URL: https://shop.elsevier.com/books/elements-of-set-theory/enderton/978-0-08-057042-6

### Evidence 20 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=102`, Abschnitt `3.2.2`
- Modus: `location_paraphrase`; Passung: `supporting`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt lineare Abbildungen und Operatoren als weiterführende Form von Abbildungen auf Vektorräumen.
- Exakte Fundstelle: Transformations, S. 55–117.
- Textanker: Transformations
- Verifizierte Paraphrase: Halmos behandelt Abbildungen in der speziell linearen, endlichdimensionalen Struktur; für allgemeine Funktionen ist die Quelle ergänzend.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4612-6387-6

### Evidence 21 – [83] Introduction to Real Analysis

- Verwendung: `source_usage_id=103`, Abschnitt `3.2.2`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [83] stützt Mengen/Funktionen als analytische Grundlage und die Weiterführung zu Grenzwerten, Stetigkeit und Differentiation.
- Exakte Fundstelle: Kap. 1 Preliminaries, Abschnitt Sets and Functions; Kap. 4 Limits; Kap. 5 Continuous Functions; Kap. 6 Differentiation.
- Textanker: Preliminaries; Sets and Functions
- Verifizierte Paraphrase: Die 4. Auflage führt Funktionen explizit im Grundlagenkapitel und anschließend als Gegenstand der reellen Analysis.
- Quelle URL: https://books.google.com/books/about/Introduction_to_Real_Analysis.html?id=YawbAAAAQBAJ
- Verifikation URL: https://www.wiley-vch.de/en/areas-interest/mathematics-statistics/introduction-to-real-analysis-978-0-471-43331-6

### Evidence 22 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=104`, Abschnitt `3.2.3`
- Modus: `replacement_location`; Passung: `replacement`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: Der bisherige Verweis [10] in 3.2.3 wird sachlich durch Strang [74] ersetzt: lineare Transformationen, Matrixdarstellung und Eigenwerte.
- Exakte Fundstelle: §8.1 The Idea of a Linear Transformation, S. 401; §8.2 The Matrix of a Linear Transformation, S. 411; §6.1 Introduction to Eigenvalues, S. 288.
- Textanker: Linear Transformations; Introduction to Eigenvalues
- Verifizierte Paraphrase: Die Fundstellen decken genau die mit [10] belegten Aussagen zur Matrixdarstellung linearer Operatoren und zur Eigenwertgleichung ab.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf
- Hinweise: Kanonische Ersatzquelle gemäß früherem FRZK-Repository; Originalziffer [10] bleibt nur als Importhistorie erhalten.

### Evidence 23 – [76] Methods of Modern Mathematical Physics

- Verwendung: `source_usage_id=105`, Abschnitt `3.2.3`
- Modus: `replacement_location`; Passung: `replacement`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: Der bisherige Verweis [13] in 3.2.3 wird sachlich durch Reed/Simon [76] ersetzt: Operatoren, Adjunkte, Spektrum und inverse/operatorentheoretische Strukturen.
- Exakte Fundstelle: Kap. VI Bounded Operators, S. 182 ff.; §VI.2 Adjoints, S. 185; §VI.3 The Spectrum, S. 188; Kap. VII The Spectral Theorem, S. 221 ff.
- Textanker: Bounded Operators; The Spectrum; The Spectral Theorem
- Verifizierte Paraphrase: Reed/Simon liefern die operatorentheoretische Quelle für die Stellen, die im aktuellen DOCX vorläufig mit [13] belegt sind.
- Quelle URL: https://books.google.com/books?id=bvuRuwuFBWwC
- Verifikation URL: https://shop.elsevier.com/books/methods-of-modern-mathematical-physics/reed/978-0-12-585001-8
- Hinweise: Kanonische Ersatzquelle gemäß früherem FRZK-Repository; Originalziffer [13] bleibt nur als Importhistorie erhalten.

### Evidence 24 – [71] Algebra

- Verwendung: `source_usage_id=106`, Abschnitt `3.2.3`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt lineare Abbildungen, Matrixdarstellungen und die Darstellung eines Endomorphismus.
- Exakte Fundstelle: Matrices and Linear Maps, S. 503–552; Representation of One Endomorphism, S. 553–570.
- Textanker: Matrices and Linear Maps; Representation of One Endomorphism
- Verifizierte Paraphrase: Die beiden Kapitel decken die lineare Abbildung, Matrixdarstellung und Eigenstruktur des Abschnitts ab.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 25 – [80] Elements of Set Theory

- Verwendung: `source_usage_id=107`, Abschnitt `3.2.3`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [80] stützt die allgemeine Abbildung/Funktion als eindeutige Zuordnung auf Mengenebene.
- Exakte Fundstelle: Kap. 3 Relations and Functions: Ordered Pairs, Relations, Functions.
- Textanker: Relations and Functions
- Verifizierte Paraphrase: Diese Quelle stützt den allgemeinen Abbildungsbegriff, bevor 3.2.3 zur Linearität übergeht.
- Quelle URL: https://shop.elsevier.com/books/elements-of-set-theory/enderton/978-0-08-057042-6

### Evidence 26 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=108`, Abschnitt `3.2.3`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt lineare Transformationen, Operatoren, Basiswechsel, Range/Nullspace sowie Determinanten- und Spektralterminologie.
- Exakte Fundstelle: Transformations, S. 55–117; Change of basis, S. 63; Range and null space, S. 69; Determinants and the spectral terminology, S. 77.
- Textanker: Transformations; Change of basis; Range and null space
- Verifizierte Paraphrase: Halmos behandelt die für 3.2.3 benötigte Operator- und Darstellungsstruktur direkt.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC
- Verifikation URL: https://link.springer.com/book/10.1007/978-1-4612-6387-6

### Evidence 27 – [71] Algebra

- Verwendung: `source_usage_id=109`, Abschnitt `3.2.4`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Vektor-/Modulstrukturen und lineare Abbildungen; Vektorräume sind der Spezialfall von Moduln über einem Körper.
- Exakte Fundstelle: Modules, S. 117–172; Matrices and Linear Maps, S. 503–552.
- Textanker: Modules; Matrices and Linear Maps
- Verifizierte Paraphrase: Die Fundstellen tragen die algebraische Einordnung der Vektorraumaxiome und linearen Operationen.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 28 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=110`, Abschnitt `3.2.4`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Vektorräume, Unterräume, Nullräume, Basis und Dimension.
- Exakte Fundstelle: Kap. 3 Vector Spaces and Subspaces, S. 123–193; §3.1 S. 123; §3.2 S. 135; §3.4 S. 164.
- Textanker: Vector Spaces and Subspaces
- Verifizierte Paraphrase: Die 5. Auflage behandelt die in 3.2.4 benötigte Vektorraumstruktur direkt.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 29 – [76] Methods of Modern Mathematical Physics

- Verwendung: `source_usage_id=111`, Abschnitt `3.2.4`
- Modus: `location_paraphrase`; Passung: `supporting`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [76] stützt die Einordnung endlichdimensionaler und normierter Vektorräume im funktionalanalytischen Rahmen.
- Exakte Fundstelle: Kap. I Preliminaries (metric and normed linear spaces); Kap. II Hilbert Spaces, S. 36 ff.; Kap. III Banach Spaces, S. 67 ff.
- Textanker: Hilbert Spaces; Banach Spaces
- Verifizierte Paraphrase: Reed/Simon sind hier eine ergänzende funktionalanalytische Quelle; die konkreten Vektorraumaxiome werden direkter durch Lang/Strang/Halmos gestützt.
- Quelle URL: https://books.google.com/books?id=bvuRuwuFBWwC

### Evidence 30 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=112`, Abschnitt `3.2.4`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `cross_checked`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt die Definition des Vektorraums, Basiskonstruktion und lineare Räume.
- Exakte Fundstelle: Spaces, S. 1–54; Definition of vector space, S. 1; Definition and construction of bases, S. 8.
- Textanker: Spaces; Definition of vector space
- Verifizierte Paraphrase: Halmos beginnt ausdrücklich mit der Vektorraumdefinition und entwickelt daraus die endlichdimensionale lineare Struktur.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC
- Verifikation URL: https://link.springer.com/book/10.1007/978-1-4612-6387-6

### Evidence 31 – [71] Algebra

- Verwendung: `source_usage_id=113`, Abschnitt `3.2.5`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Linearkombinationen, Erzeugung und lineare Struktur im Modul-/Vektorraumkontext.
- Exakte Fundstelle: Modules, S. 117–172; Matrices and Linear Maps, S. 503–552.
- Textanker: Modules; Matrices and Linear Maps
- Verifizierte Paraphrase: Die Abschnitte liefern den algebraischen Rahmen für Skalarmultiplikation, Addition und Erzeugung linearer Unterräume.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 32 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=114`, Abschnitt `3.2.5`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Linearkombinationen und daraus aufgebaute Vektorräume/Unterräume.
- Exakte Fundstelle: §1.1 Vectors and Linear Combinations, S. 2; §3.1 Spaces of Vectors, S. 123.
- Textanker: Vectors and Linear Combinations
- Verifizierte Paraphrase: Strang führt Linearkombinationen bereits als elementaren Aufbau von Vektoren und später von Räumen ein.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 33 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=115`, Abschnitt `3.2.5`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt Erzeugung, Basiskonstruktion und lineare Mannigfaltigkeiten/Unterräume.
- Exakte Fundstelle: Spaces, S. 1–54; Definition and construction of bases, S. 8; Linear manifolds, S. 14.
- Textanker: Definition and construction of bases; Linear manifolds
- Verifizierte Paraphrase: Die Fundstellen liegen im Raum-Kapitel und stützen Spann-/Erzeugungsargumente.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC

### Evidence 34 – [71] Algebra

- Verwendung: `source_usage_id=116`, Abschnitt `3.2.6`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt lineare Unabhängigkeit, Basen und Dimension innerhalb linearer algebraischer Strukturen.
- Exakte Fundstelle: Modules, S. 117–172; Matrices and Linear Maps, S. 503–552.
- Textanker: Modules; Matrices and Linear Maps
- Verifizierte Paraphrase: Langs linear-algebraischer Aufbau trägt die Basis-/Dimensionsargumentation; für die didaktische Explikation sind Strang/Halmos direkter.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 35 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=117`, Abschnitt `3.2.6`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt ausdrücklich lineare Unabhängigkeit, Basis und Dimension.
- Exakte Fundstelle: §3.4 Independence, Basis and Dimension, S. 164; §3.5 Dimensions of the Four Subspaces, S. 181.
- Textanker: Independence, Basis and Dimension
- Verifizierte Paraphrase: Diese Fundstelle ist die direkte Referenz für den Kern von 3.2.6.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 36 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=118`, Abschnitt `3.2.6`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt Definition/Konstruktion von Basen und die endlichdimensionale Raumstruktur.
- Exakte Fundstelle: Spaces, S. 1–54; Definition and construction of bases, S. 8.
- Textanker: Definition and construction of bases
- Verifizierte Paraphrase: Halmos liefert eine klassische Quelle für Basen als vollständige, nichtredundante lineare Beschreibung.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC

### Evidence 37 – [71] Algebra

- Verwendung: `source_usage_id=119`, Abschnitt `3.2.7`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Matrixdarstellung linearer Abbildungen und damit die Basisabhängigkeit von Koordinatenrepräsentationen.
- Exakte Fundstelle: Matrices and Linear Maps, S. 503–552.
- Textanker: Matrices and Linear Maps
- Verifizierte Paraphrase: Die Darstellung linearer Maps durch Matrizen liefert den algebraischen Rahmen für Koordinaten- und Basiswechsel.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 38 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=120`, Abschnitt `3.2.7`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt die Matrix eines linearen Operators und die Wahl bzw. Suche einer geeigneten Basis.
- Exakte Fundstelle: §8.2 The Matrix of a Linear Transformation, S. 411; §8.3 The Search for a Good Basis, S. 421.
- Textanker: The Matrix of a Linear Transformation; The Search for a Good Basis
- Verifizierte Paraphrase: Strang trennt lineare Transformation und Matrixdarstellung und behandelt die Basiswahl explizit.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 39 – [76] Methods of Modern Mathematical Physics

- Verwendung: `source_usage_id=121`, Abschnitt `3.2.7`
- Modus: `location_paraphrase`; Passung: `partial`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [76] stützt den abstrakten Spektralbegriff eines Operators, nicht jedoch als primäre Quelle die elementare Basiswechselmatrix.
- Exakte Fundstelle: Kap. VI Bounded Operators, §3 The Spectrum, S. 188 ff.; Kap. VII The Spectral Theorem, S. 221 ff.
- Textanker: The Spectrum; The Spectral Theorem
- Verifizierte Paraphrase: Reed/Simon stützen die operatorische/spektrale Invarianzebene; die konkrete Ähnlichkeitstransformation sollte primär mit Strang/Lang/Halmos belegt werden.
- Quelle URL: https://books.google.com/books?id=bvuRuwuFBWwC

### Evidence 40 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=122`, Abschnitt `3.2.7`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt den Basiswechsel und dessen Einfluss auf Matrixdarstellungen.
- Exakte Fundstelle: Change of basis, S. 63; Transformations, S. 55–117.
- Textanker: Change of basis
- Verifizierte Paraphrase: Halmos besitzt einen ausdrücklich ausgewiesenen Abschnitt zum Basiswechsel.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC

### Evidence 41 – [71] Algebra

- Verwendung: `source_usage_id=123`, Abschnitt `3.2.8`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Determinanten im Kontext von Matrizen und linearen Abbildungen.
- Exakte Fundstelle: Matrices and Linear Maps, S. 503–552; darin Abschnitt Determinants (ab etwa S. 511 gemäß Inhaltsgliederung).
- Textanker: Matrices and Linear Maps; Determinants
- Verifizierte Paraphrase: Lang behandelt Determinanten innerhalb des linearen Abbildungs- und Matrixkapitels.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 42 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=124`, Abschnitt `3.2.8`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Determinanteneigenschaften, Kofaktorentwicklung, Inversen und Volumenskalierung.
- Exakte Fundstelle: Kap. 5 Determinants, S. 247 ff.; §5.1 S. 247; §5.2 S. 258; §5.3 Cramer’s Rule, Inverses, and Volumes, S. 273.
- Textanker: Determinants; Inverses, and Volumes
- Verifizierte Paraphrase: Die Kapitelstruktur deckt die in 3.2.8 behandelten algebraischen und geometrischen Bedeutungen der Determinante direkt ab.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 43 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=125`, Abschnitt `3.2.8`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt Determinanten und deren Verbindung zur Spektralterminologie.
- Exakte Fundstelle: Determinants and the spectral terminology, S. 77; Transformations, S. 55–117.
- Textanker: Determinants and the spectral terminology
- Verifizierte Paraphrase: Halmos verknüpft Determinanten mit der Struktur linearer Transformationen.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC

### Evidence 44 – [71] Algebra

- Verwendung: `source_usage_id=126`, Abschnitt `3.2.9`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Rang, Matrixdarstellungen und lineare Abbildungen.
- Exakte Fundstelle: Matrices and Linear Maps, S. 503–552; Rangabschnitt im Anfang dieses Kapitels.
- Textanker: Matrices and Linear Maps
- Verifizierte Paraphrase: Lang behandelt Rang und lineare Abbildungen in demselben Kapitel und stützt damit Rang-/Bildargumente.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 45 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=127`, Abschnitt `3.2.9`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Nullraum, Lösbarkeit, Rang und Dimension der fundamentalen Unterräume.
- Exakte Fundstelle: §3.2 The Nullspace of A, S. 135; §3.3 The Complete Solution to Ax=b, S. 150; §3.5 Dimensions of the Four Subspaces, S. 181.
- Textanker: The Nullspace of A; Dimensions of the Four Subspaces
- Verifizierte Paraphrase: Diese Fundstellen stützen Kern/Nullraum, Rang, Bild-/Spaltenraum und lineare Gleichungssysteme.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 46 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=128`, Abschnitt `3.2.9`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt Range und Null Space einer linearen Transformation.
- Exakte Fundstelle: Range and null space of a linear transformation, S. 69.
- Textanker: Range and null space
- Verifizierte Paraphrase: Halmos besitzt eine direkte Fundstelle zu Bild/Range und Kern/Nullspace.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC

### Evidence 47 – [71] Algebra

- Verwendung: `source_usage_id=129`, Abschnitt `3.2.10`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [71] stützt Eigenwerte/Eigenvektoren, charakteristisches Polynom und die Darstellung eines Endomorphismus.
- Exakte Fundstelle: Representation of One Endomorphism, S. 553–570; charakteristisches Polynom innerhalb dieses Kapitels.
- Textanker: Representation of One Endomorphism
- Verifizierte Paraphrase: Das Kapitel behandelt die spektralen Eigenschaften eines einzelnen linearen Endomorphismus.
- Quelle URL: https://link.springer.com/book/10.1007/978-1-4613-0041-0

### Evidence 48 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=130`, Abschnitt `3.2.10`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Eigenwerte, Eigenvektoren und den Übergang zur Diagonalisierung.
- Exakte Fundstelle: §6.1 Introduction to Eigenvalues, S. 288; §6.2 Diagonalizing a Matrix, S. 304.
- Textanker: Introduction to Eigenvalues
- Verifizierte Paraphrase: Die Fundstellen sind die direkte Referenz für Eigenwertgleichung, Eigenrichtungen und Diagonalisierbarkeitsfragen.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 49 – [82] Finite-Dimensional Vector Spaces

- Verwendung: `source_usage_id=131`, Abschnitt `3.2.10`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [82] stützt spektrale Terminologie und die Eigenstruktur linearer Transformationen.
- Exakte Fundstelle: Determinants and the spectral terminology, S. 77; Transformations, S. 55–117.
- Textanker: Determinants and the spectral terminology
- Verifizierte Paraphrase: Halmos verknüpft Determinanten und spektrale Terminologie innerhalb der Theorie linearer Transformationen.
- Quelle URL: https://books.google.com/books/about/Finite_Dimensional_Vector_Spaces.html?id=sWZMZi1LtMUC

### Evidence 50 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=132`, Abschnitt `3.2.11`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Diagonalisierung, symmetrische Matrizen und die orthogonale Eigenvektorzerlegung.
- Exakte Fundstelle: §6.2 Diagonalizing a Matrix, S. 304; §6.4 Symmetric Matrices, S. 338.
- Textanker: Diagonalizing a Matrix; Symmetric Matrices
- Verifizierte Paraphrase: Die beiden Abschnitte tragen die Diagonalisierbarkeit und den endlichdimensionalen Spektralsatz für reelle symmetrische Matrizen.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 51 – [74] Introduction to Linear Algebra

- Verwendung: `source_usage_id=133`, Abschnitt `3.2.12`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [74] stützt Skalarprodukt/Dot Product, Norm/Länge, Orthogonalität, Projektionen und Gram-Schmidt.
- Exakte Fundstelle: §1.2 Lengths and Dot Products, S. 11; §4.1 Orthogonality, S. 194; §4.2 Projections, S. 206; §4.4 Orthonormal Bases and Gram-Schmidt, S. 233.
- Textanker: Lengths and Dot Products; Projections; Orthonormal Bases and Gram-Schmidt
- Verifizierte Paraphrase: Die Fundstellen entsprechen unmittelbar den Definitionen und Verfahren von 3.2.12.
- Quelle URL: https://math.mit.edu/~gs/linearalgebra/ila5/index.html
- Verifikation URL: https://math.mit.edu/~gs/linearalgebra/ila5/linearalgebra5_TOC.pdf

### Evidence 52 – [84] Linear Algebra

- Verwendung: `source_usage_id=134`, Abschnitt `3.2.12`
- Modus: `location_paraphrase`; Passung: `direct`; Status: `verified`; Copyright: `location_only`
- Gestützte Aussage: [84] stützt Skalarprodukte/Normen, Gram-Schmidt, orthogonale Komplemente, orthogonale Operatoren, Projektionen und Spektralsatz.
- Exakte Fundstelle: Kap. 6 Inner Product Spaces: §6.1 Inner Products and Norms; §6.2 Gram-Schmidt Orthogonalization Process and Orthogonal Complements; §6.5 Unitary and Orthogonal Operators; §6.6 Orthogonal Projections and the Spectral Theorem.
- Textanker: Inner Product Spaces
- Verifizierte Paraphrase: Pearsons Inhaltsverzeichnis deckt die gesamte in 3.2.12 benötigte Struktur direkt ab.
- Quelle URL: https://www.pearson.com/en-us/subject-catalog/p/Friedberg-Linear-Algebra-Subscription-5th-Edition/P200000006185/9780137515424

## 19. Vollständige Quelltext-Snapshots der importierten 3.2-Fassung

Diese Snapshots stammen aus `section_versions.version_kind = source_import` der Revision-2-Quellaufnahme. Sie dienen ausschließlich als Provenienz- und Inhaltskontrolle. Der spätere Haupttext-Chat darf sie **nicht bloß kürzen oder redaktionell glätten**, sondern muss die neue 3.2-Struktur aus Haupttextprofil, final realisierten Anlagen, Literatur-Evidenz und Anschlussanforderungen neu formulieren.

### Quellabschnitt 3.2.0 – Einleitung

- `section_id`: `22`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `100349ce9c258031ae1df43f242fc748dd73e3595f0cf3cbd0b937916e76c8b9`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
## 3.2.0 Einleitung

Mit dem Abschluss von Kapitel 3.1 habe ich die erkenntnistheoretischen, wissenschaftstheoretischen und methodologischen Voraussetzungen geschaffen, auf denen ich die weitere Entwicklung des Funktionalen Raum-Zeit-Kohärenzsystems (FRZK) aufbaue. Dabei wurde deutlich, dass jede wissenschaftliche Theorie auf expliziten Voraussetzungen beruht und dass weder Begriffe noch mathematische Strukturen unabhängig von ihren jeweiligen Definitionsbedingungen verstanden werden können. Daraus ergibt sich für mich die Notwendigkeit, vor der Einführung eines eigenen mathematischen Formalismus zunächst diejenigen mathematischen Werkzeuge systematisch darzustellen, die in den Naturwissenschaften und in der Mathematik zur Beschreibung komplexer Strukturen verwendet werden. Damit bildet Kapitel 3.2 bewusst die mathematische Brücke zwischen der wissenschaftstheoretischen Grundlegung aus Kapitel 3.1 und der späteren FRZK-Axiomatik in Kapitel 3.3.

Die mathematischen Disziplinen, die ich im Folgenden behandle, stellen keinen beliebigen Ausschnitt der Mathematik dar. Ich wähle sie aufgrund ihrer grundlegenden Bedeutung für die Beschreibung von Mengen, Relationen, Funktionen, Transformationen und strukturellen Zusammenhängen aus. Dabei unterscheide ich bewusst zwischen etablierter mathematischer Theorie und der späteren Eigenleistung dieser Arbeit. Kapitel 3.2 verfolgt daher nicht das Ziel, neue mathematische Aussagen zu entwickeln. Vielmehr möchte ich die Voraussetzungen, die Leistungsfähigkeit und ebenso die Grenzen derjenigen mathematischen Konzepte offenlegen, auf denen moderne wissenschaftliche Modellbildungen beruhen. Erst auf dieser Grundlage kann ich in Kapitel 3.3 eine eigenständige Axiomatik des FRZK entwickeln.

Den Ausgangspunkt bildet die Mengenlehre, die eine gemeinsame Grundsprache für große Teile der modernen Mathematik bereitstellt. Paul R. Halmos stellt in *Naive Set Theory* die Begriffe Menge, Element, Teilmenge, Relation und Abbildung als grundlegende Bausteine der weiterführenden Mathematik dar \\[6\\]. Seine Darstellung ist für meinen Aufbau besonders geeignet, weil sie die elementaren Strukturen schrittweise entwickelt, ohne bereits eine bestimmte physikalische Interpretation vorauszusetzen.

An die Mengenlehre schließen sich die algebraischen Grundlagen an. Serge Lang: *Algebra*. Revised Third Edition. New York: Springer, 2002 \\[71\\]. Lang systematisiert Gruppen, Ringe, Körper, Moduln und lineare Abbildungen als allgemeine Strukturen mathematischer Verknüpfungen. Diese Strukturen benötige ich später, wenn ich funktionale Transformationen nicht nur sprachlich, sondern mathematisch präzise beschreiben will.

Für die Analysis verwende ich Walter Rudin: *Principles of Mathematical Analysis*. Third Edition. New York: McGraw-Hill, 1976 \\[72\\]. Rudin entwickelt die Begriffe Konvergenz, Stetigkeit, Differenzierbarkeit und Integration auf der Grundlage bereits definierter Zahlen- und Funktionenräume. Für meinen Aufbau ist dabei nicht nur wichtig, was die Analysis leisten kann. Ebenso wichtig ist mir die Grenze ihrer Aussagekraft: Die Analysis untersucht Eigenschaften und Veränderungen innerhalb bereits mathematisch bestimmter Strukturen. Sie begründet nicht selbst, warum gerade diese Strukturen als Ausgangspunkt gewählt wurden.

Die topologischen Grundlagen stütze ich auf James R. Munkres: *Topology*. Second Edition. Upper Saddle River, New Jersey: Prentice Hall, 2000 \\[73\\]. Munkres entwickelt topologische Räume, Zusammenhang, Kompaktheit und Trennungsaxiome unabhängig von der Notwendigkeit einer bereits vorgegebenen metrischen Geometrie. Für meine weitere Untersuchung ist insbesondere bedeutsam, dass ich damit mathematische Begriffe von Nähe, Zusammenhang und Stetigkeit untersuchen kann, ohne diese bereits mit einem bestimmten physikalischen Raum gleichsetzen zu müssen.

Für die lineare Algebra verwende ich Gilbert Strang: *Introduction to Linear Algebra*. Fifth Edition. Wellesley, Massachusetts: Wellesley-Cambridge Press, 2016 \\[74\\]. Vektorräume, Matrizen, lineare Transformationen, Basen, Dimensionen sowie Eigenwerte und Eigenvektoren bilden später wesentliche mathematische Werkzeuge meiner Untersuchung. Auch hier halte ich die methodische Trennung ausdrücklich aufrecht. Ein mathematischer Vektorraum ist zunächst eine algebraische Struktur. Allein aus seiner mathematischen Definition folgt noch keine physikalische Interpretation als räumliche oder raumzeitliche Struktur.

Darauf aufbauend verwende ich funktionalanalytische Konzepte. Erwin Kreyszig: *Introductory Functional Analysis with Applications*. New York: John Wiley & Sons, 1978 \\[75\\]. Michael Reed und Barry Simon: *Methods of Modern Mathematical Physics. Volume I: Functional Analysis*. Revised and Enlarged Edition. San Diego: Academic Press, 1980 \\[76\\]. Beide Werke behandeln normierte Räume, Hilberträume, lineare Funktionale, Operatoren und Spektren. Damit stellen sie mathematische Werkzeuge bereit, die ich später für die Beschreibung von Zustands- und Operatorräumen benötige. Auch aus diesen mathematischen Strukturen leite ich an dieser Stelle noch keine FRZK-spezifische physikalische Interpretation ab.

Für diskrete relationale Strukturen verwende ich Reinhard Diestel: *Graph Theory*. Fifth Edition. Berlin und Heidelberg: Springer, 2017 \\[77\\]. Die Graphentheorie ermöglicht es mir, Elemente und ihre Verbindungen als diskrete mathematische Strukturen zu untersuchen. Gerade im Hinblick auf spätere relationale Beschreibungen ist dabei wesentlich, zwischen dem Vorhandensein einzelner Objekte und den zwischen ihnen definierten Verbindungen zu unterscheiden.

Eine noch abstraktere Beschreibung mathematischer Strukturen und ihrer Beziehungen erhalte ich durch die Kategorientheorie. Saunders Mac Lane: *Categories for the Working Mathematician*. Second Edition. New York: Springer, 1998 \\[78\\]. Kategorien und Morphismen ermöglichen es, mathematische Strukturen nicht ausschließlich anhand ihrer einzelnen Elemente, sondern auch anhand der zwischen ihnen bestehenden strukturerhaltenden Beziehungen zu untersuchen.

Die formalen Grundlagen metamathematischer Aussagen ergänze ich durch Stephen C. Kleene: *Introduction to Metamathematics*. Amsterdam: North-Holland Publishing Company, 1952 \\[79\\]. Die mathematische Logik und die Untersuchung formaler Systeme sind für meinen weiteren Aufbau deshalb relevant, weil ich in Kapitel 3.3 von der Darstellung etablierter mathematischer Werkzeuge zur Formulierung eines eigenen Axiomensystems übergehe. Dafür muss eindeutig unterscheidbar bleiben, welche Aussagen Definitionen, welche Axiome, welche daraus abgeleiteten Aussagen und welche lediglich Interpretationen darstellen.

Alle diese Quellen verwende ich ausschließlich als Referenzen für etablierte mathematische Strukturen. Ich setze ihre Aussagen nicht mit den späteren FRZK-Setzungen gleich. Gerade diese Unterscheidung ist für den wissenschaftlichen Aufbau meiner Arbeit entscheidend. Wenn ich beispielsweise später einen Vektorraum, einen Operator, eine Relation oder eine topologische Struktur innerhalb des FRZK verwende, ist der mathematische Begriff selbst noch keine Eigenleistung des FRZK. Die Eigenleistung kann erst dort beginnen, wo ich begründet festlege, welche dieser mathematischen Werkzeuge ich innerhalb des FRZK verwende, wie ich sie miteinander verknüpfe und welche zusätzlichen Axiome ich dafür einführe.

Damit erfüllt Kapitel 3.2 für mich eine doppelte wissenschaftliche Funktion. Einerseits entwickle ich systematisch diejenigen mathematischen Werkzeuge, die ich für die späteren Herleitungen benötige. Andererseits untersuche ich zugleich deren Voraussetzungen und Grenzen. Gerade diese explizite Trennung zwischen etablierter Mathematik und eigener theoretischer Entwicklung bildet die Voraussetzung dafür, dass ich die in Kapitel 3.3 folgende FRZK-Axiomatik eindeutig als wissenschaftliche Eigenleistung kennzeichnen und von bereits vorhandener Mathematik unterscheiden kann.

## Methodologische Betrachtungen

Methodologisch bildet Abschnitt 3.2.0 für mich die Grenze zwischen zwei unterschiedlichen Arbeitsschritten. In Kapitel 3.1 habe ich untersucht, unter welchen erkenntnistheoretischen und wissenschaftstheoretischen Voraussetzungen eine eigenständige theoretische Konstruktion überhaupt formuliert werden kann. In Kapitel 3.2 beginne ich dagegen noch nicht mit dieser Konstruktion. Ich rekonstruiere zunächst die mathematischen Werkzeuge, die ich später dafür benötige.

Diese Reihenfolge ist für meine Vorgehensweise wesentlich. Würde ich bereits in den mathematischen Grundlagen FRZK-spezifische Eigenschaften in etablierte Begriffe hineinlegen, wäre später nicht mehr eindeutig erkennbar, welche Aussagen aus vorhandener Mathematik stammen und welche Aussagen ich selbst als zusätzliche theoretische Setzungen einführe. Ich behandle deshalb Mengen, Funktionen, Vektorräume, Operatoren, topologische Räume und alle weiteren mathematischen Strukturen zunächst in ihrer etablierten Bedeutung.

Gleichzeitig bedeutet diese Trennung nicht, dass ich die mathematischen Werkzeuge unkritisch übernehme. Für meine Untersuchung interessiert mich bei jedem Werkzeug nicht nur seine mathematische Leistungsfähigkeit, sondern ebenso die Frage, welche Voraussetzungen es benötigt und welche Aussagen sich aus ihm gerade nicht ableiten lassen. Ein Vektorraum beispielsweise stellt eine algebraische Struktur bereit, erklärt aber noch nicht, warum ein physikalischer Zustandsraum diese Struktur besitzen soll. Eine Relation beschreibt mathematisch eine Verbindung, begründet aber noch keine physikalische Wechselwirkung. Ein Operator beschreibt eine Abbildung, erklärt aber allein noch keinen realen Prozess.

Genau an diesen Grenzen entsteht später der Übergang zur FRZK-Axiomatik. Kapitel 3.2 soll deshalb nicht nachträglich eine Begründung des FRZK liefern. Es stellt vielmehr den mathematischen Werkzeugbestand bereit, anhand dessen ich in Kapitel 3.3 präzise angeben kann, welche zusätzlichen Voraussetzungen ich für das FRZK tatsächlich setzen muss.

## Didaktische Betrachtungen

Didaktisch beginne ich bewusst mit den elementaren mathematischen Strukturen und entwickle daraus schrittweise komplexere Begriffe. Diese Vorgehensweise entspricht meiner grundsätzlichen Art, mathematische und physikalische Zusammenhänge zu erschließen: Ich beginne mit dem einfachsten möglichen Ausgangspunkt und erweitere ihn erst dann, wenn die vorhandene Struktur für den nächsten Erklärungsschritt nicht mehr ausreicht.

Dadurch entsteht eine nachvollziehbare Entwicklung. Aus Mengen werden Beziehungen zwischen Elementen beschreibbar. Aus Relationen können eindeutige Abbildungen hervorgehen. Auf strukturierten Räumen lassen sich Transformationen und Operatoren definieren. Darauf können wiederum analytische, topologische und funktionalanalytische Strukturen aufgebaut werden. Ich möchte damit vermeiden, mathematische Begriffe lediglich als fertige Formeln oder Definitionen einzuführen, deren Zusammenhang untereinander verborgen bleibt.

Für die spätere Entwicklung des FRZK ist dieser Aufbau besonders wichtig. Wenn ich in Kapitel 3.3 eigene Axiome formuliere, soll nachvollziehbar sein, welche mathematischen Werkzeuge bereits vorhanden sind und an welcher Stelle tatsächlich eine neue Setzung beginnt. Der Leser soll deshalb nicht nur erkennen können, **welches** mathematische Werkzeug ich verwende, sondern auch **warum** ich es benötige, welche Voraussetzungen es besitzt und wo seine Aussagekraft endet.

## Ergebnis und Übergang

Mit Abschnitt 3.2.0 habe ich den methodischen Rahmen für die mathematischen Grundlagen festgelegt. Die verwendeten mathematischen Disziplinen behandle ich nicht als Bestandteile einer bereits vorausgesetzten FRZK-Theorie, sondern rekonstruiere sie zunächst als etablierte Werkzeuge. Ihre FRZK-spezifische Auswahl, Verbindung und Interpretation erfolgt erst auf der Grundlage der späteren Axiome.

Der erste konkrete Schritt besteht deshalb darin, festzulegen, welche mathematischen Objekte gemeinsam betrachtet werden können und wie sich Beziehungen zwischen ihnen formal beschreiben lassen. Damit beginne ich in Abschnitt **3.2.1 mit Mengen, Elementen und elementaren Relationen**.
```

### Quellabschnitt 3.2.1 – Mengen, Elemente und elementare Relationen

- `section_id`: `23`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `b43f687880deca0d1e0097244d123483b93022d78311bffd4060a514dfc28177`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.1 Mengen, Elemente und elementare Relationen

Nachdem ich in Abschnitt 3.2.0 die Aufgabe dieses Kapitels bestimmt und die verwendeten mathematischen Gebiete eingeordnet habe, beginne ich nun mit dem elementarsten formalen Schritt jeder mathematischen Modellbildung. Bevor ich Zustände, Beziehungen, Funktionen oder Transformationen beschreiben kann, muss ich zunächst festlegen, welche Objekte innerhalb einer Untersuchung überhaupt berücksichtigt werden sollen. Diese Festlegung erfolgt mit dem Begriff der Menge. Der ursprüngliche Abschnitt entwickelt diesen Aufbau von der elementaren Zugehörigkeit über Mengenoperationen bis zur binären Relation.

Die Mengenlehre verwende ich als gemeinsame Grundsprache für die weitere mathematische Entwicklung. Zahlenbereiche, Vektorräume, Funktionenräume, topologische Räume und viele weitere Strukturen lassen sich mengentheoretisch beschreiben. Daraus darf ich jedoch nicht schließen, dass eine Menge bereits eine physikalische oder ontologische Wirklichkeit abbildet. Eine Menge ist zunächst eine formal bestimmte Zusammenfassung unterscheidbarer Elemente. Erst durch zusätzliche Definitionen und Interpretationen lege ich fest, welche wissenschaftliche Bedeutung diese Elemente innerhalb eines konkreten Modells besitzen.

Paul R. Halmos führt Mengen, Elemente, Teilmengen, Vereinigungen, Schnittmengen, geordnete Paare und Abbildungen als elementare Bausteine einer systematischen mathematischen Sprache ein \\[6\\]. Seine Darstellung ist für meinen Aufbau besonders geeignet, weil sie die grundlegenden Operationen schrittweise entwickelt, ohne bereits eine bestimmte physikalische Interpretation vorauszusetzen. Zugleich macht Halmos deutlich, dass die naive Mengenlehre keine vollständige axiomatische Fundierung der Mengenlehre ersetzt. Für meine grundlegende Einführung mathematischer Modellstrukturen ist sie dennoch geeignet, solange ich ihre Voraussetzungen und Grenzen ausdrücklich benenne.

Für die systematischere mengentheoretische Einordnung ergänze ich diese Grundlage durch Herbert B. Enderton: *Elements of Set Theory*. New York, San Francisco und London: Academic Press, 1977 \\[80\\]. Enderton entwickelt die elementare Mengenlehre aus formalen Voraussetzungen und behandelt unter anderem Relationen, Funktionen, natürliche Zahlen, Kardinalzahlen und Auswahlprinzipien.

Für die weiterführende axiomatische Einordnung verwende ich außerdem Thomas Jech: *Set Theory. The Third Millennium Edition, Revised and Expanded*. Berlin und Heidelberg: Springer, 2003 \\[81\\]. Jech führt von den Axiomen der Mengenlehre über Ordinal- und Kardinalzahlen bis zu weiterführenden Ergebnissen der modernen Mengenlehre. Beide Werke erfüllen in meiner Untersuchung unterschiedliche Funktionen: Enderton nutze ich vor allem für die schrittweise begriffliche Grundlegung, während Jech die Einordnung in die axiomatische Mengenlehre und ihre weiterführenden Konsequenzen ermöglicht.

Ich übernehme aus diesen Darstellungen nicht die Annahme, dass jede wissenschaftlich relevante Struktur vollständig auf Mengen reduziert werden müsse. Michael D. Resnik diskutiert mathematische Strukturen unabhängig von einer unmittelbaren Identifikation mit bestimmten Einzelobjekten \\[67\\]. Stewart Shapiro entwickelt diesen strukturorientierten Zugang weiter und betont, dass mathematische Gegenstände wesentlich durch ihre Stellung innerhalb von Strukturen bestimmt werden können \\[68\\]. Für das FRZK ist diese Einschränkung bedeutsam. Ich verwende die Mengenlehre als formale Ausgangssprache, behaupte damit aber noch nicht, dass Mengen die letzte ontologische Grundlage von Raum, Zeit oder physikalischer Wirklichkeit darstellen.

## Definition 3.2.1: Menge und Element

Unter einer Menge $M$ verstehe ich zunächst eine formal bestimmte Zusammenfassung unterscheidbarer Objekte. Die zu $M$ gehörenden Objekte bezeichne ich als Elemente der Menge.

Die Zugehörigkeit eines Objekts $x$ zu einer Menge $M$ schreibe ich als

$x \\in \\, M$ (3.1)

Dabei ist $x$ das betrachtete Objekt und die Menge $M$, hinsichtlich derer ich die Zugehörigkeit prüfe.

Die Nichtzugehörigkeit schreibe ich entsprechend als

$x \\notin M$ (3.2)

Die Aussagen (3.1) und (3.2) legen ausschließlich fest, ob ein Objekt innerhalb der betrachteten Menge geführt wird. Sie bestimmen weder seine Eigenschaften noch seine Beziehungen zu anderen Elementen. Diese Unterscheidung ist für meine weitere Entwicklung wesentlich. Die Aufnahme eines Zustands in eine Zustandsmenge bedeutet noch nicht, dass seine innere Struktur, seine Ursache oder seine funktionale Bedeutung bereits erklärt wäre.

Eine endliche Menge kann ich durch die Aufzählung ihrer Elemente angeben. Für drei Elemente $a$, $b$ und $c$ schreibe ich beispielsweise

$M = \\text{\\{}a,b,c\\text{\\}}$ (3.3)

Dabei bezeichnet $M$ die betrachtete Menge; $a$, $b$ und $c$ sind ihre Elemente.

Die Reihenfolge der Elemente ist für eine Menge nicht von Bedeutung. Ebenso verändert eine wiederholte Nennung eines Elements die Menge nicht. Es gilt daher

$\\text{\\{}a,b,c\\text{\\}} = \\text{\\{}c,a,b\\text{\\}} = \\text{\\{}a,a,b,c\\text{\\}}$ (3.4)

An dieser Stelle wird bereits eine erste Grenze der Mengenbeschreibung sichtbar. Die Menge (3.3) enthält zwar die Elemente $a$, $b$ und $c$, sie enthält jedoch keine Information darüber, ob eines dieser Elemente zuerst oder zuletzt auftritt, ob ein Element gegenüber einem anderen hervorgehoben ist oder ob zwischen den Elementen eine bestimmte Wirkungsrichtung besteht. Eine Menge stellt damit zunächst eine Zusammenfassung bereit, aber noch keine Ordnung, Gewichtung oder Dynamik.

Neben der Aufzählung kann ich eine Menge durch eine Eigenschaft ihrer Elemente bestimmen. Die allgemeine Form lautet

$$M = \\text{\\{}x \\in U \\mid P(x)\\text{\\}}\\ (3.5)$$

Dabei ist $U$ die Grundmenge, aus der ich die Elemente auswähle. $P(x)$ bezeichnet eine Bedingung, die für jedes $x \\in U$ eindeutig erfüllt oder nicht erfüllt sein muss. Die Menge $M$ enthält genau diejenigen Elemente aus $U$, für die $P(x)$ gilt.

Ich halte die Grundmenge $U$ in (3.5) ausdrücklich fest, weil eine Auswahlbedingung niemals unabhängig von einem zugelassenen Ausgangsbereich wirkt. Wenn ich beispielsweise die Menge der geraden natürlichen Zahlen bestimme, muss zunächst feststehen, dass natürliche Zahlen betrachtet werden:

$$G = \\text{\\{}n \\in \\mathbb{N} \\mid \\exists k \\in \\mathbb{N}:n = 2k\\text{\\}}\\ (3.6)$$

Dabei bezeichnet $G$ die Menge der geraden natürlichen Zahlen, $n$ das jeweils betrachtete Element und $k$ eine natürliche Zahl, durch die die Geradheit von $n$ ausgedrückt wird.

Die Bedingung entscheidet innerhalb des Zahlenbereichs $\\mathbb{N}$, welche Elemente zu $G$ gehören. Würde ich einen anderen Grundbereich wählen, könnte dieselbe sprachliche Bedingung eine andere Menge bestimmen. Für meine weitere Modellbildung folgt daraus, dass die Festlegung eines zulässigen Objekt- oder Zustandsbereichs keine beiläufige Entscheidung ist. Sie bestimmt, welche Gegenstände innerhalb des Modells überhaupt auftreten können.

## Teilmengen

Eine Menge $A$ heißt Teilmenge einer Menge $B$, wenn jedes Element von $A$ zugleich Element von $B$ ist:

$$A \\subseteq B \\Longleftrightarrow \\forall x\\,(x \\in A \\Rightarrow x \\in B)\\ (3.7)$$

Dabei sind $A$ und $B$ Mengen und $x$ ein beliebiges betrachtetes Element.

Ich muss dabei zwischen der Elementrelation und der Teilmengenrelation unterscheiden. Die Aussage $x \\in A$ verknüpft ein Objekt mit einer Menge. Die Aussage $A \\subseteq B$ verknüpft dagegen zwei Mengen. Diese formale Unterscheidung erscheint zunächst einfach, wird jedoch später wesentlich, wenn verschiedene Ebenen mathematischer Objekte gleichzeitig betrachtet werden.

Eine echte Teilmenge liegt vor, wenn $A$ zwar Teilmenge von $B$, aber nicht mit $B$ identisch ist:

$$A \\subset B \\Longleftrightarrow A \\subseteq B \\land A \\neq B\\ (3.8)$$

Ich verwende deshalb $A \\subseteq B$, wenn Gleichheit zugelassen ist, und $A \\subset B$, wenn Gleichheit ausdrücklich ausgeschlossen werden soll. Diese Unterscheidung behalte ich im weiteren Gleichungsapparat konsequent bei.

## Gleichheit von Mengen

Zwei Mengen sind gleich, wenn sie genau dieselben Elemente enthalten:

$$A = B \\Longleftrightarrow \\forall x\\,(x \\in A \\Leftrightarrow x \\in B)\\ (3.9)$$

Diese Festlegung entspricht dem Extensionalitätsprinzip. Eine Menge wird demnach durch ihre Elemente bestimmt. Unterschiedliche Bezeichnungen oder unterschiedliche sprachliche Beschreibungen können dieselbe Menge erfassen, wenn sie zu genau demselben Elementbestand führen \\[80, 81\\].

Für meine Untersuchung ist dabei wichtig, zwischen formaler Gleichheit und inhaltlicher Interpretation zu unterscheiden. Zwei Mengen können formal denselben Elementbestand besitzen und dennoch innerhalb unterschiedlicher wissenschaftlicher Modelle verschieden interpretiert werden. Gleichung (3.9) entscheidet ausschließlich über ihre mengentheoretische Gleichheit. Sie entscheidet nicht darüber, ob zwei Beschreibungen dieselbe Erklärung, denselben Messvorgang oder dieselbe physikalische Bedeutung besitzen.

## Die leere Menge

Die leere Menge enthält kein Element. Ich bezeichne sie mit $\\varnothing$ und definiere sie durch

$$\\varnothing = \\text{\\{}x|\\ x \\neq x\\text{\\}}\\ (3.10)$$

Dabei bezeichnet $\\varnothing$ die leere Menge. Die Bedingung $x \\neq x$ kann für kein Objekt $x$ erfüllt sein und charakterisiert damit eine Menge ohne Elemente.

Bereits in Abschnitt 3.1.1 habe ich die leere Menge vom absoluten Nichts unterschieden. Diese Unterscheidung bleibt hier verbindlich. Die leere Menge ist ein definiertes mathematisches Objekt innerhalb einer bereits vorausgesetzten Sprache und Struktur \\[6\\]. Sie ist deshalb nicht die Abwesenheit jeder Voraussetzung, sondern eine Menge, für die festgelegt wurde, dass sie kein Element enthält.

Die leere Menge ist Teilmenge jeder Menge:

$$\\varnothing \\subseteq A\\ (3.11)$$

Dabei bezeichnet $A$ eine beliebige Menge.

Diese Aussage folgt daraus, dass kein Element der leeren Menge existiert, das die Teilmengenbedingung verletzen könnte. Für die spätere Modellbildung bedeutet eine leere Menge zulässiger Zustände deshalb nicht, dass keine mathematische Struktur vorhanden wäre. Sie bedeutet lediglich, dass unter den festgelegten Bedingungen kein Element die verlangten Kriterien erfüllt.

## Mengenoperationen

Aus bestehenden Mengen kann ich durch festgelegte Operationen weitere Mengen bilden. Die Vereinigung zweier Mengen $A$ und $B$ enthält alle Elemente, die mindestens einer der beiden Mengen angehören:

$$A \\cup B = \\text{\\{}x|\\ x \\in A \\vee x \\in B\\text{\\}}\\ (3.12)$$

Dabei sind $A$ und $B$ die Ausgangsmengen und $x$ ein Element, das mindestens einer von beiden angehört.

Die Schnittmenge enthält alle Elemente, die beiden Mengen gleichzeitig angehören:

$$A \\cap B = \\text{\\{}x|\\ x \\in A \\land x \\in B\\text{\\}}\\ (3.13)$$

Die Differenzmenge enthält alle Elemente von $A$, die nicht in $B$ enthalten sind:

$$A \\smallsetminus B = \\text{\\{}x|\\ x \\in A \\land x \\notin B\\text{\\}}\\ (3.14)$$

Diese Operationen verändern nicht die betrachteten Elemente selbst. Sie verändern die Bedingung, nach der Elemente zu einer neuen Menge zusammengefasst werden. Ich werde diese Unterscheidung später erneut benötigen: Eine veränderte Auswahl von Zuständen ist nicht dasselbe wie eine Transformation der Zustände. Mengenoperationen bestimmen zunächst nur, welche Elemente gemeinsam betrachtet werden.

Zwei Mengen heißen disjunkt, wenn sie kein gemeinsames Element besitzen:

$$A \\cap B = \\varnothing\\ (3.15)$$

Aus der Disjunktheit folgt jedoch nicht, dass zwischen Elementen aus $A$ und Elementen aus $B$ keine Beziehungen bestehen können. Sie besagt ausschließlich, dass kein Element gleichzeitig beiden Mengen angehört. Damit zeigt sich erneut, dass Mengenzugehörigkeit und Beziehung nicht gleichgesetzt werden dürfen.

## Potenzmenge

Die Potenzmenge einer Menge $A$ enthält sämtliche Teilmengen von $A$:

$$\\mathcal{P(}A) = \\text{\\{}B|\\ B \\subseteq A\\text{\\}}\\ (3.16)$$

Dabei bezeichnet 𝒫$(A)$ die Potenzmenge von $A$ und $B$ eine beliebige Teilmenge von $A$.

Für $A = a,b$ ergibt sich beispielsweise

$$\\mathcal{P}(A) = \\text{\\{}\\varnothing,\\text{\\{}a\\text{\\}},\\text{\\{}b\\text{\\}},\\text{\\{}a,b\\text{\\}\\}}\\ (3.17)$$

Besitzt eine endliche Menge $A$ genau $n$ Elemente, enthält ihre Potenzmenge $2^{n}$ Elemente:

$$|A| = n \\Rightarrow \\left| \\mathcal{P}A \\right| = 2^{n}\\ (3.18)$$

Dabei bezeichnet $|A|$ die Anzahl der Elemente von $A$, $n$ deren Anzahl und $\\left| \\mathcal{P(}A) \\right|$ die Anzahl der Teilmengen.

Die Potenzmenge ist für meinen weiteren Aufbau wichtig, weil sie nicht einzelne Elemente, sondern alle möglichen Zusammenstellungen von Elementen erfasst. Bereits eine begrenzte Anzahl unterscheidbarer Zustände erzeugt damit eine wesentlich größere Anzahl möglicher Zustandsgruppen. Ich übernehme daraus noch keine Aussage über physikalische Realisierbarkeit. Die Potenzmenge beschreibt zunächst ausschließlich die formal möglichen Teilmengen.

## Geordnete Paare und kartesisches Produkt

Eine Menge allein enthält keine Reihenfolge ihrer Elemente. Für die Beschreibung gerichteter Beziehungen benötige ich deshalb geordnete Paare. Bei einem geordneten Paar ist die Stellung der Komponenten wesentlich. Im Allgemeinen gilt

$$(a,b) \\neq (b,a)\\quad\\quad\\text{für }a \\neq b\\ \\ (3.19)$$

Dabei bezeichnen $a$ und $b$ die beiden Komponenten des geordneten Paares.

Aus zwei Mengen $A$ und $B$ bilde ich das kartesische Produkt:

$$A \\times B = \\text{\\{}(a,b)|\\ a \\in A \\land b \\in B\\text{\\}}\\ \\ (3.20)$$

Dabei ist $A \\times B$ die Menge aller geordneten Paare, deren erste Komponente aus $A$ und deren zweite Komponente aus $B$ stammt.

Das kartesische Produkt enthält sämtliche formal möglichen geordneten Paarungen eines Elements aus $A$ mit einem Element aus $B$. Für endliche Mengen gilt

$$|A \\times B| = |A| \\cdot |B|\\ (3.21)$$

Gleichung (3.20) erzeugt noch keine inhaltlich bestimmte Beziehung. Sie stellt lediglich die Gesamtheit aller möglichen Paarungen bereit. Welche dieser Paarungen innerhalb einer konkreten mathematischen Struktur tatsächlich als Beziehung zugelassen werden, wird erst durch eine Relation bestimmt.

## Definition 3.2.2: Binäre Relation

Eine binäre Relation $R$ zwischen den Mengen $A$ und $B$ ist eine Teilmenge ihres kartesischen Produkts:

$$R \\subseteq A \\times B\\ (3.22)$$

Dabei bezeichnet $R$ die Relation und $A \\times B$ die Menge aller formal möglichen geordneten Paare zwischen den beiden betrachteten Mengen.

Gilt $(a,b) \\in R$, schreibe ich auch

$$aRb \\Longleftrightarrow (a,b) \\in R\\ (3.23)$$

Dabei bedeutet $aRb$, dass das Element $a$ bezüglich der Relation $R$ zum Element $b$ in Beziehung steht.

Damit wird erstmals eine ausgewählte Verbindung zwischen Elementen formal beschrieben. Das kartesische Produkt enthält alle möglichen Paarungen; die Relation bestimmt, welche dieser Paarungen innerhalb der jeweiligen mathematischen Struktur tatsächlich berücksichtigt werden.

Die formale Untersuchung von Relationen besitzt bereits in den logischen und mathematischen Arbeiten von Gottlob Frege und Alfred Tarski grundlegende Bedeutung. Ich nutze diese Arbeiten hier ausschließlich für den etablierten formallogischen Hintergrund der Relationsbeschreibung. Saunders Mac Lane hebt darüber hinaus hervor, dass mathematische Strukturen nicht nur durch ihre Objekte, sondern wesentlich auch durch die zwischen ihnen bestehenden Abbildungen und Beziehungen verständlich werden \\[78\\]. Die bereits im ursprünglichen Abschnitt enthaltenen Verweise auf Frege und Tarski werden beim zugehörigen Repository-Skript gegen den realen Quellenbestand geprüft und dort mit den tatsächlich gültigen Zitationsnummern synchronisiert.

Für meine Untersuchung ist dies ein entscheidender Übergang. Eine Menge erfasst, welche Elemente betrachtet werden. Eine Relation erfasst zusätzlich, welche Elemente innerhalb einer gewählten Beschreibung miteinander verbunden sind.

Ich übernehme für das FRZK jedoch nicht jede beliebige mengentheoretisch mögliche Relation. Gleichung (3.22) beschreibt zunächst nur die formale Grundstruktur. Ob eine Relation symmetrisch, gerichtet, transitiv, reflexiv, funktional oder empirisch begründet ist, muss jeweils zusätzlich bestimmt werden. Ebenso folgt aus dem bloßen Bestehen einer Relation noch keine physikalische Wechselwirkung und keine kausale Verbindung.

## Wissenschaftliche Einordnung

Mit den bisherigen Festlegungen habe ich die erste formale Ebene der mathematischen Modellbildung bestimmt. Eine Menge legt fest, welche Elemente gemeinsam betrachtet werden. Eine Teilmenge schränkt diesen Bereich ein. Mengenoperationen erzeugen neue Auswahlbereiche. Das kartesische Produkt stellt mögliche geordnete Paarungen bereit. Eine Relation wählt daraus bestimmte Verbindungen aus.

Diese Schritte sind formal, aber nicht voraussetzungslos. Ich muss in jedem Modell entscheiden, welche Objekte als voneinander unterscheidbar gelten, welche Grundmenge zugelassen wird, nach welchen Bedingungen Teilmengen gebildet werden, welche Paarungen als Beziehungen gelten und welche inhaltliche Interpretation diese Beziehungen erhalten.

Gerade darin liegt für mich die Bedeutung der Mengenlehre. Sie liefert keine fertige Theorie von Raum und Zeit. Sie zwingt mich jedoch dazu, die zugelassenen Objekte und die zwischen ihnen möglichen Beziehungen ausdrücklich festzulegen. Damit verhindere ich, dass Zustände, Beziehungen oder Strukturen unbemerkt als bereits vorhanden vorausgesetzt werden.

Für das FRZK werde ich deshalb später zwischen der formalen Existenz eines Elements, seiner Zugehörigkeit zu einem Zustandsbereich, seinen Beziehungen zu anderen Elementen und seiner funktionalen Wirksamkeit unterscheiden müssen. Diese Unterscheidungen bereite ich in Kapitel 3.2 mathematisch vor. Ihre FRZK-spezifische Festlegung erfolgt erst in Kapitel 3.3.

## Methodologische Betrachtungen

Methodologisch ist die Mengenlehre für meinen weiteren Aufbau deshalb bedeutsam, weil sie mich zwingt, bereits auf der elementarsten Ebene zwischen dem betrachteten Objektbereich und den über diesen Objektbereich getroffenen Aussagen zu unterscheiden. Die Wahl einer Grundmenge ist keine inhaltsneutrale Formalität. Sie entscheidet darüber, welche Objekte innerhalb eines Modells überhaupt vorkommen können.

Dasselbe gilt für Relationen. Aus der mathematischen Möglichkeit, zwei Elemente durch eine Relation miteinander zu verbinden, folgt noch nicht, dass zwischen diesen Elementen eine physikalische Wechselwirkung, eine zeitliche Abfolge oder eine kausale Beziehung besteht. Eine Relation beschreibt zunächst nur eine formal zugelassene Verbindung.

Für die spätere FRZK-Konstruktion ergibt sich daraus eine klare methodische Grenze. Wenn ich dort Zustände, Beziehungen oder funktionale Kopplungen einführe, muss ich jeweils gesondert bestimmen, welche Menge den zulässigen Zustandsbereich bildet, welche Relationen definiert werden und welche zusätzliche wissenschaftliche Bedeutung diese Relationen besitzen. Die Mengenlehre stellt hierfür die formale Sprache bereit; sie liefert nicht die FRZK-spezifische Interpretation.

Die Unterscheidung zwischen Element und Teilmenge, zwischen kartesischem Produkt und Relation sowie zwischen formaler Beziehung und physikalischer Interpretation behalte ich deshalb im weiteren Aufbau ausdrücklich bei.

## Didaktische Betrachtungen

Didaktisch ist dieser Abschnitt für mich ein gutes Beispiel dafür, weshalb ich mit möglichst einfachen mathematischen Strukturen beginne. Der Begriff der Menge erscheint zunächst elementar. Gerade deshalb lässt sich an ihm sehr deutlich zeigen, wie viele zusätzliche Festlegungen erforderlich werden, sobald aus einer bloßen Zusammenfassung von Objekten eine strukturierte Beschreibung entstehen soll.

Zunächst entscheide ich nur, ob ein Objekt zu einer Menge gehört oder nicht. Danach kann ich Teilmengen bilden und verschiedene Auswahlbedingungen miteinander verknüpfen. Erst mit geordneten Paaren entsteht eine Reihenfolge zwischen zwei Komponenten. Das kartesische Produkt stellt daraufhin alle formal möglichen Paarungen bereit, während eine Relation aus diesen Möglichkeiten bestimmte Verbindungen auswählt.

Dieser schrittweise Aufbau macht sichtbar, dass mathematische Struktur nicht in einem einzigen Schritt entsteht. Jede zusätzliche Aussageebene benötigt eine zusätzliche Definition. Genau dieses Vorgehen möchte ich später beim FRZK beibehalten: Ich möchte nicht mehrere Bedeutungen gleichzeitig in einen Begriff hineinlegen, sondern jede neue Struktur erst dann einführen, wenn deutlich geworden ist, weshalb die bisherige Struktur dafür nicht ausreicht.

Auch die neue Gleichungsregel unterstützt diesen didaktischen Aufbau. Einzelne Größen, die lediglich Bestandteile einer Gleichung sind, führe ich nicht als scheinbar eigenständige Gleichungen. Stattdessen erläutere ich sie unmittelbar bei derjenigen mathematischen Aussage, zu der sie tatsächlich gehören. Dadurch bleibt die Gleichungsnummerierung auf mathematisch selbstständige Aussagen beschränkt.

## Ergebnis und Übergang

Mit Abschnitt 3.2.1 habe ich die elementare mengentheoretische Grundlage für die weitere mathematische Entwicklung geschaffen. Ich habe festgelegt, wie Objekte zu Mengen gehören, wie Teilmengen und Mengenoperationen gebildet werden, wie geordnete Paare entstehen und wie aus dem kartesischen Produkt durch Auswahl bestimmter Paare eine binäre Relation hervorgeht.

Eine Relation nach Gleichung (3.22) kann einem Element mehrere Elemente, genau ein Element oder auch kein Element zuordnen. Für die weitere Entwicklung muss ich deshalb als Nächstes bestimmen, unter welchen Bedingungen eine Relation zu einer eindeutigen Abbildung beziehungsweise Funktion wird. Dies ist Gegenstand von Abschnitt **3.2.2 Funktionen und eindeutige Zuordnungen**.
```

### Quellabschnitt 3.2.2 – Funktionen und eindeutige Zuordnungen

- `section_id`: `24`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `fbd65a437c36e4d343c9a2ae8468b4586bf5c6fce7e8eb4eb2a95360021d83d4`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.2 Funktionen und eindeutige Zuordnungen

Im vorhergehenden Abschnitt habe ich Mengen, kartesische Produkte und binäre Relationen eingeführt. Damit ist zunächst nur festgelegt, welche Elemente betrachtet werden und welche geordneten Paare zwischen zwei Mengen zugelassen sind. Eine allgemeine Relation kann einem Element mehrere andere Elemente zuordnen, genau ein Element oder auch kein Element. Für viele mathematische Beschreibungen reicht diese Offenheit nicht aus. Sobald ich einen Zustand, einen Wert oder ein Objekt eindeutig einem anderen Objekt zuordnen möchte, benötige ich den Begriff der Funktion.

Die Funktion stellt für meine weitere Arbeit deshalb einen entscheidenden Schritt dar. Sie verbindet nicht nur Elemente miteinander, sondern legt eine eindeutige Zuordnungsvorschrift fest. Dabei muss ich sorgfältig zwischen der formalen Funktion, ihrer mathematischen Darstellung und ihrer späteren wissenschaftlichen Interpretation unterscheiden. Eine Funktion beschreibt zunächst, welches Element einem anderen Element zugeordnet wird. Sie erklärt noch nicht, warum diese Zuordnung besteht, ob sie kausal ist oder ob sie einen physikalischen Prozess beschreibt.

Serge Lang behandelt Abbildungen als grundlegende Bestandteile algebraischer Strukturen und zeigt, dass viele mathematische Operationen als Abbildungen zwischen Mengen oder strukturierten Räumen verstanden werden können \\[71\\]. Walter Rudin verwendet Funktionen als zentrale Grundlage der Analysis und untersucht insbesondere deren Grenzverhalten, Stetigkeit und Differenzierbarkeit \\[72\\]. Herbert B. Enderton entwickelt Funktionen aus dem Relationsbegriff und beschreibt sie als besondere Relationen, die jedem Element ihres Definitionsbereichs genau ein Element des Zielbereichs zuordnen \\[80\\]. Diese drei Perspektiven ergänzen sich für meinen Aufbau: Enderton liefert mir die mengentheoretische Grundlage, Lang die strukturelle Einordnung und Rudin die analytische Weiterführung.

Für die präzisere Untersuchung von Abbildungen zwischen algebraischen Strukturen verwende ich außerdem Paul R. Halmos: *Finite-Dimensional Vector Spaces*. New York: Springer, 1974 \\[82\\]. Halmos behandelt lineare Abbildungen, Operatoren und Vektorräume in einer Form, die ich später für die Entwicklung der linearen Algebra und der Operatorenräume benötige. Für die grundlegende Funktionentheorie ergänze ich diese Literatur durch Robert G. Bartle und Donald R. Sherbert: *Introduction to Real Analysis*. Fourth Edition. Hoboken, New Jersey: John Wiley & Sons, 2011 \\[83\\]. Bartle und Sherbert entwickeln Funktionen reeller Variablen, Grenzwerte, Stetigkeit und Ableitungen schrittweise aus den Grundlagen der reellen Zahlen und der Mengenlehre.

Ich übernehme aus dieser Literatur zunächst ausschließlich den etablierten mathematischen Funktionsbegriff. Die spätere FRZK-spezifische Frage, ob eine Funktion einen Zustand, eine Wirkung, eine Transformation oder eine funktionale Abhängigkeit beschreibt, entscheide ich an dieser Stelle noch nicht.

## Definition 3.2.3: Funktion

Eine Funktion $f$ von einer Menge $A$ in eine Menge $B$ ist eine Relation, die jedem Element $a \\in A$ genau ein Element $b \\in B$ zuordnet. Ich fasse die Abbildung und ihre Eindeutigkeitsbedingung deshalb gemeinsam zusammen:

$$f:A \\rightarrow B,\\quad\\quad\\forall a \\in A\\ \\exists!\\, b \\in B:\\ f(a) = b(3.24)$$

Dabei gilt:

-   $f$ ist die Funktion,

-   $A$ ist ihre Definitionsmenge beziehungsweise ihr Definitionsbereich,

-   $B$ ist ihre Zielmenge,

-   $a$ ist ein Element des Definitionsbereichs,

-   $b = fa$ ist der $a$ eindeutig zugeordnete Funktionswert,

-   $\\exists!$ bezeichnet die eindeutige Existenz.

Damit fasse ich die im ursprünglichen Text noch getrennt nummerierten Ausdrücke für die Funktionsschreibweise, den Funktionswert und die Eindeutigkeit bewusst zu **einer** mathematischen Aussage zusammen. Die einzelnen darin auftretenden Größen erhalten keine eigenen Gleichungsnummern.

Gleichung (3.24) enthält zwei Anforderungen. Erstens muss zu jedem Element $a \\in A$ mindestens ein zugeordnetes Element $b \\in B$ existieren. Zweitens darf es für dasselbe Element $a$ nicht mehrere verschiedene Funktionswerte geben.

Diese Bedingung ist für den Funktionsbegriff wesentlich. Eine Relation, die einem Element mehrere verschiedene Werte zuordnet, ist keine Funktion im hier verwendeten Sinn. Ebenso ist eine Zuordnung keine Funktion auf ganz $A$, wenn für einzelne Elemente aus $A$ kein Funktionswert bestimmt ist.

Mengentheoretisch kann ich eine Funktion als Teilmenge des kartesischen Produkts auffassen. Dabei müssen sowohl die Eindeutigkeit als auch die vollständige Erfassung des Definitionsbereichs gleichzeitig gelten:

$$\\ (a,b\\_ 1) \\in \\begin{matrix}
f \\subseteq A \\times B, \\\\
f \\land (a,b_{2}) \\in f\\& \\Rightarrow b_{1} = b_{2}, \\\\
\\forall a \\in A\\ \\&\\exists b \\in B:\\ (a,b) \\in f.
\\end{matrix}(3.25)$$

Dabei sind $b_{1}$ und $b_{2}$ zwei mögliche Werte, die demselben Element $a$ zugeordnet sein könnten. Die zweite Zeile schließt aus, dass diese Werte verschieden sind. Die dritte Zeile stellt sicher, dass jedes Element des Definitionsbereichs tatsächlich in einem geordneten Paar der Funktion auftritt.

Erst die Verbindung dieser Bedingungen ergibt eine Funktion auf der gesamten Definitionsmenge $A$.

## Definitionsmenge, Zielmenge und Bildmenge

Die Zielmenge $B$ darf ich nicht mit der Bildmenge der Funktion verwechseln. Die Bildmenge enthält nur diejenigen Elemente aus $B$, die tatsächlich als Funktionswerte auftreten.

Ich definiere das Bild von $A$ unter $f$ durch

$$f(A) = \\text{\\{}f(a) \\mid a \\in A\\text{\\}} \\subseteq B\\ (3.26)$$

Dabei ist $f(A)$ die Bildmenge der Funktion. Die Zielmenge $B$ kann also Elemente enthalten, die durch die betrachtete Funktion nicht erreicht werden.

Diese Unterscheidung ist für meine weitere Modellbildung wesentlich. Ein mathematischer Zielraum kann mehr mögliche Werte enthalten, als ein bestimmter Zustand oder eine bestimmte Transformation tatsächlich erzeugt.

Für eine Teilmenge $C \\subseteq A$ definiere ich entsprechend

$$f(C) = \\text{\\{}f(c) \\mid c \\in C\\text{\\}}\\ (3.27)$$

Dabei ist $C$ ein eingeschränkter Teilbereich des Definitionsraums. Mit $f(C)$ kann ich untersuchen, welche Funktionswerte gerade aus diesem Teilbereich hervorgehen.

Für eine Teilmenge $D \\subseteq B$ definiere ich das Urbild durch

$$f^{- 1}(D) = \\text{\\{}a \\in A \\mid f(a) \\in D\\text{\\}}\\ (3.28)$$

Dabei bezeichnet $f^{- 1}D$ zunächst ausschließlich das Urbild der Menge $D$. Diese Schreibweise setzt **nicht** voraus, dass eine Umkehrfunktion existiert. Das Urbild einer Teilmenge ist für jede Funktion definiert, während eine Umkehrfunktion nur unter zusätzlichen Bedingungen existiert.

## Injektive Funktionen

Eine Funktion $f:A \\rightarrow B$ heißt injektiv, wenn verschiedene Elemente aus $A$ verschiedene Funktionswerte besitzen. Formal kann ich dies in zwei äquivalenten Formen schreiben:

$$\\forall a_{1},a_{2} \\in A:\\quad f\\left( a_{1} \\right) = f\\left( a_{2} \\right) \\Rightarrow a_{1} = a_{2}\\quad \\Longleftrightarrow \\quad a_{1} \\neq a_{2} \\Rightarrow f\\left( a_{1} \\right) \\neq f\\left( a_{2} \\right)\\ (3.29)$$

Dabei sind $a_{1}$ und $a_{2}$ beliebige Elemente des Definitionsbereichs.

Bei einer injektiven Funktion bleibt die Unterscheidbarkeit der Elemente des Definitionsbereichs in ihren Funktionswerten erhalten. Zwei verschiedene Eingangselemente werden nicht auf denselben Ausgangswert abgebildet.

Für meine spätere Modellbildung ist dies von Bedeutung, weil eine nicht injektive Funktion Informationen zusammenführen kann. Wenn mehrere unterschiedliche Zustände denselben Funktionswert erhalten, kann ich aus dem Funktionswert allein nicht mehr eindeutig auf den ursprünglichen Zustand schließen.

## Surjektive Funktionen

Eine Funktion $f:A \\rightarrow B$ heißt surjektiv, wenn jedes Element der Zielmenge durch mindestens ein Element der Definitionsmenge erreicht wird:

$$\\forall b \\in B\\ \\exists a \\in A:\\ f(a) = b\\quad\\quad \\Longleftrightarrow \\quad\\quad f(A) = B\\ (3.30)$$

Dabei ist $b$ ein beliebiges Element der Zielmenge und $a$ mindestens ein Element des Definitionsbereichs, das auf $b$ abgebildet wird.

Surjektivität bezieht sich ausdrücklich auf die gewählte Zielmenge. Dieselbe Zuordnung kann bezüglich einer kleineren Zielmenge surjektiv und bezüglich einer größeren Zielmenge nicht surjektiv sein. Damit zeigt sich erneut, dass die Eigenschaften einer Funktion nicht allein von ihrer Zuordnungsvorschrift, sondern auch von der Festlegung ihrer Definitions- und Zielmenge abhängen.

## Bijektive Funktionen

Eine Funktion heißt bijektiv, wenn sie zugleich injektiv und surjektiv ist:

$$f\\text{ bijektiv}\\quad \\Longleftrightarrow \\quad f\\text{ injektiv} \\land f\\text{ surjektiv}\\ (3.31)$$

Bei einer bijektiven Funktion ist jedem Element aus $A$ genau ein Element aus $B$ zugeordnet und jedes Element aus $B$ wird genau einmal erreicht. Dadurch besteht eine eindeutige Zuordnung in beiden Richtungen.

Für eine bijektive Funktion existiert eine Umkehrfunktion, deren Abbildung und beide Umkehreigenschaften zusammengehören:

$$\\begin{matrix}
f^{- 1}:B \\rightarrow A, \\\\
f^{- 1}(f(a)) = a,\\forall a \\in A,\\  \\\\
{f(f}^{- 1}b = b,\\ \\forall b \\in B.
\\end{matrix}\\ (3.32)$$

Dabei ist $f^{- 1}$ die Umkehrfunktion von f.

Die Umkehrbarkeit einer Funktion ist für wissenschaftliche Modelle nicht selbstverständlich. Sobald eine Abbildung mehrere Zustände zusammenfasst oder bestimmte Informationen nicht erhält, kann sie nicht eindeutig zurückgeführt werden. Dies wird später bei Projektionen, Messvorgängen, Aggregationen und Operatoren eine wichtige Rolle spielen.

## Identische Funktion

Für eine Menge $A$ definiere ich die identische Funktion einschließlich ihrer Wirkung durch

$$id_{A}:A \\rightarrow A,\\quad\\quad id_{A}(a) = a\\quad\\forall a \\in A\\ (3.33)$$

Dabei ist $id_{A}$ die identische Funktion auf $A$.

Die identische Funktion verändert kein Element. Sie ist dennoch eine mathematisch bestimmte Abbildung. Dies ist später deshalb bedeutsam, weil auch das Ausbleiben einer Veränderung innerhalb eines Operatoren- oder Transformationssystems formal dargestellt werden muss.

## Verkettung von Funktionen

Seien $f:A \\rightarrow B$ und $g:B \\rightarrow C$. Diese beiden Abbildungen sind die Voraussetzungen für ihre Verkettung und benötigen deshalb **keine eigenen Gleichungsnummern**.

Die Verkettung von $f$ und $g$ definiere ich gemeinsam mit ihrer Wirkung durch

$$g \\circ f:A \\rightarrow C,\\quad\\quad(g \\circ f)(a) = g\\left( f(a) \\right)\\ (3.34)$$

Dabei wird zuerst $f$ auf $a$ angewendet. Anschließend wird $g$ auf den dadurch erhaltenen Wert $f(a)$ angewendet.

Die Reihenfolge der Funktionen ist wesentlich. Im Allgemeinen gilt

$$g \\circ f \\neq f \\circ g\\ (3.35)$$

Die Verkettung ist jedoch assoziativ. Für eine weitere Funktion $h:C \\rightarrow D$ gilt

$$h \\circ (g \\circ f) = (h \\circ g) \\circ f\\ (3.36)$$

Dabei ist $h$ eine weitere mit $g$ verkettbare Funktion.

Diese Eigenschaft erlaubt es mir, längere Abbildungsfolgen eindeutig zusammenzufassen. Für das spätere FRZK ist dies besonders wichtig, weil funktionale Entwicklungen nicht durch eine einzelne Abbildung, sondern durch aufeinanderfolgende Operatoren beschrieben werden können. Daraus folgt jedoch noch keine Aussage darüber, ob eine mathematische Verkettung zugleich einer zeitlichen, kausalen oder physikalischen Reihenfolge entspricht.

## Funktionen mit mehreren Eingangsgrößen

Eine Funktion kann nicht nur ein einzelnes Element, sondern auch ein geordnetes Tupel als Argument besitzen. Für zwei Mengen $A$ und $B$ kann ich eine solche Funktion einschließlich ihres Funktionswertes durch

$$f:A \\times B \\rightarrow C,\\quad\\quad f(a,b) = c \\in C,\\quad a \\in A,\\ b \\in B\\ (3.37)$$

Dabei sind $a$ und $b$ die beiden Eingangsgrößen und $c$ der daraus eindeutig bestimmte Funktionswert.

Damit kann ein Funktionswert von mehreren Eingangsgrößen abhängen. Die mathematische Funktion legt lediglich fest, wie das geordnete Eingangspaar einem Ausgangswert zugeordnet wird. Sie entscheidet noch nicht, ob beide Eingangsgrößen unabhängig sind, ob eine von ihnen die andere beeinflusst oder ob beide aus einem gemeinsamen Zusammenhang hervorgehen.

Allgemein beschreibe ich eine Funktion von $n$ Eingangsgrößen einschließlich ihres Arguments und ihres Funktionswertes durch

$$\\begin{matrix}
f:A_{1} \\times A_{2} \\times \\cdots \\times A_{n} \\rightarrow B, \\\\
\\left( a_{1},a_{2},\\ldots,a_{n} \\right) \\in A_{1} \\times A_{2} \\times \\cdots \\times A_{n}, \\\\
f\\left( a_{1},a_{2},\\ldots,a_{n} \\right) \\in B.
\\end{matrix}\\ (3.38)$$

Dabei sind $A_{1},\\ldots,A_{n}$ die jeweiligen Eingangsbereiche und $B$ die Zielmenge.

Diese Mehrstellenfunktionen bilden später die Grundlage dafür, Zustände nicht nur durch eine einzelne Größe, sondern durch mehrere gleichzeitig berücksichtigte Komponenten zu beschreiben.

## Funktionsfamilien und parametrisierte Funktionen

Neben einzelnen Funktionen kann ich ganze Familien von Funktionen betrachten. Sei $\\Theta$ eine Parametermenge. Dann kann ich eine parametrisierte Funktionsfamilie einschließlich ihrer einzelnen Mitglieder durch

$$\\text{\\{}f_{\\theta} \\mid \\theta \\in \\Theta\\text{\\}},\\quad\\quad f_{\\theta}:A \\rightarrow B\\quad\\forall\\theta \\in \\ (3.39)$$

Dabei bezeichnet $\\theta$ einen Parameter aus der Parametermenge $\\Theta$, während $f_{\\theta}$ die zu diesem Parameter gehörende konkrete Funktion bezeichnet.

Der Parameter $\\theta$ kann beispielsweise unterschiedliche Modellannahmen, Anfangsbedingungen oder Verfahrensvarianten kennzeichnen. Eine solche Parametrisierung verändert nicht automatisch die Definitions- und Zielmenge, wohl aber die Zuordnungsvorschrift.

Ich verwende den Parameterbegriff hier zunächst rein mathematisch. Erst später muss ich jeweils bestimmen, ob ein Parameter gemessen, geschätzt, frei gewählt oder aus anderen Größen hergeleitet wird.

## Partielle Funktionen

In manchen Anwendungen ist eine Zuordnung nicht für jedes Element einer vorausgesetzten Grundmenge definiert. Dann liegt keine totale Funktion auf dieser gesamten Menge vor. Stattdessen kann eine Teilmenge $D \\subseteq A$ als tatsächlicher Definitionsbereich verwendet werden:

$$f:D \\rightarrow B,\\quad\\quad D \\subseteq A\\ (3.40)$$

Dabei ist $A$ der größere betrachtete Grundbereich und $D$ der tatsächliche Definitionsbereich der Funktion.

Eine solche Funktion bezeichne ich im Verhältnis zur größeren Menge $A$ als partielle Funktion. Die Unterscheidung zwischen totalen und partiellen Funktionen ist später wichtig, wenn ein mathematischer Operator nur für bestimmte Zustände oder Parameterwerte definiert ist.

Ich werde deshalb bei jeder späteren Funktion ausdrücklich angeben müssen, ob sie auf dem gesamten vorgesehenen Zustandsraum oder nur auf einem zulässigen Teilbereich definiert ist.

## Wissenschaftliche Einordnung

Mit dem Funktionsbegriff erweitere ich die bloße Beziehung zwischen Elementen um eine Eindeutigkeitsbedingung. Eine Funktion legt fest, welchem Wert oder Zustand ein gegebenes Eingangselement zugeordnet wird. Ihre mathematische Aussagekraft hängt jedoch von mehreren Entscheidungen ab:

1.  der Wahl der Definitionsmenge,

2.  der Wahl der Zielmenge,

3.  der Zuordnungsvorschrift,

4.  der Frage nach Injektivität und Surjektivität,

5.  der möglichen Umkehrbarkeit,

6.  und dem Bereich, in dem die Funktion tatsächlich definiert ist.

Diese Festlegungen darf ich nicht nachträglich als bloße Schreibkonventionen behandeln. Sie bestimmen, welche Informationen erhalten bleiben, welche Zustände erreichbar sind und ob eine Zuordnung rückgängig gemacht werden kann.

Für das FRZK ist besonders wichtig, dass ich eine mathematische Funktion nicht automatisch mit einer physikalischen Ursache gleichsetze. Als einfachstes Beispiel kann ich schreiben $y = fx.
$

Dabei ist $x$ das Argument und $y$ der ihm zugeordnete Funktionswert. Die Schreibweise besagt zunächst nur, dass $y$ durch die Funktion $f$ dem Wert $x$ zugeordnet wird. Sie besagt nicht, dass $x$ die physikalische Ursache von $y$ ist.

Ebenso folgt aus der Existenz einer Funktion noch keine zeitliche Reihenfolge. Eine Abhängigkeit, eine Zuordnung, eine Transformation und eine Kausalrelation muss ich begrifflich voneinander trennen.

Diese Unterscheidung ist für meine spätere Konstruktion grundlegend. Ich benötige Funktionen, um Zustände und Größen eindeutig zuzuordnen. Für die Beschreibung von Veränderungen reicht eine statische Zuordnung jedoch noch nicht aus. Im nächsten Abschnitt muss ich deshalb untersuchen, unter welchen Bedingungen Funktionen als Transformationen wirken und wie mathematische Operationen auf strukturierten Räumen dargestellt werden können.

## Methodologische Betrachtungen

Methodologisch stellt der Übergang von der Relation zur Funktion für mich einen wesentlichen Präzisierungsschritt dar. Eine Relation legt zunächst nur fest, welche geordneten Paare zu einer betrachteten Struktur gehören. Eine Funktion fügt dieser allgemeinen Beziehung die Forderungen der Existenz und Eindeutigkeit hinzu. Damit kann ich erstmals eindeutig bestimmen, welcher Ausgangswert welchem Zielwert zugeordnet wird.

Gerade diese Eindeutigkeit darf ich jedoch nicht mit einer physikalischen Determination gleichsetzen. Aus der mathematischen Aussage $y = f(x)$ folgt nicht, dass $x$ die Ursache von $y$ ist. Ebenso folgt aus einer mathematischen Verkettung $g \\circ f$ nicht ohne zusätzliche Festlegung, dass $f$ zeitlich vor $g$ wirkt. Die Funktion beschrei

bt eine Zuordnungsstruktur. Kausalität, Zeitrichtung und physikalische Wirkung benötigen zusätzliche theoretische Voraussetzungen.

Von besonderer methodischer Bedeutung sind für mich außerdem Injektivität, Surjektivität und Bijektivität. Diese Eigenschaften bestimmen, welche Information durch eine Funktion erhalten bleibt und welche Zielzustände erreichbar sind. Eine nicht injektive Funktion kann verschiedene Ausgangszustände in einem gemeinsamen Funktionswert zusammenführen. Eine nicht surjektive Funktion erreicht dagegen nicht den gesamten vorgegebenen Zielraum. Eine bijektive Funktion ermöglicht schließlich eine eindeutige Umkehrung.

Für die spätere FRZK-Konstruktion muss ich deshalb bei jeder verwendeten Funktion nicht nur ihre Zuordnungsvorschrift angeben, sondern auch ihren Definitionsbereich, ihre Zielmenge, ihre Bildmenge und gegebenenfalls ihre Umkehrbarkeit bestimmen. Erst dadurch wird eindeutig, welche mathematischen Informationen eine Abbildung erhält, zusammenführt oder ausschließt.

## Didaktische Betrachtungen

Didaktisch entwickelt sich der Funktionsbegriff für mich unmittelbar aus der Grenze des Relationsbegriffs. Nachdem eine Relation zunächst beliebige Verbindungen zwischen Elementen zulässt, stelle ich nun die zusätzliche Frage, was geschieht, wenn ich jedem Eingang eindeutig genau einen Ausgang zuordnen möchte. Dadurch entsteht die Funktion nicht als isolierter neuer Begriff, sondern als nachvollziehbare Einschränkung einer bereits bekannten Struktur.

Besonders wichtig ist mir dabei die getrennte Betrachtung von Definitionsmenge, Zielmenge und Bildmenge. Diese drei Begriffe werden leicht miteinander verwechselt. Ich unterscheide deshalb bewusst zwischen den Werten, die als Eingaben zugelassen sind, den Werten, die grundsätzlich als Ausgaben zugelassen wären, und den Werten, die durch die konkrete Funktion tatsächlich erreicht werden.

Dasselbe schrittweise Vorgehen verwende ich bei Injektivität, Surjektivität und Bijektivität. Zuerst frage ich, ob unterschiedliche Eingänge unterscheidbar bleiben. Danach untersuche ich, ob der gesamte Zielbereich erreicht wird. Erst aus beiden Bedingungen gemeinsam entsteht die Bijektivität und damit die Möglichkeit einer eindeutigen Umkehrfunktion.

Auch bei der Gleichungsdarstellung halte ich jetzt die funktional zusammengehörenden Aussagen zusammen. Die Definition einer Funktion, die Eindeutigkeitsbedingung und die Erläuterung ihrer Größen bilden beispielsweise eine gemeinsame mathematische Einheit. Ebenso werden die Signatur einer Umkehrfunktion und ihre beiden Umkehreigenschaften nicht künstlich auf drei verschiedene Gleichungsnummern verteilt.

Dadurch reduziert sich die Gleichungsnummerierung dieses Abschnitts gegenüber dem Original deutlich: Aus den bisherigen Nummern **(3.24) bis (3.58)** werden nach der Bereinigung die echten, eigenständigen Gleichungen **(3.24) bis (3.40)**. Der fachliche Inhalt bleibt dabei vollständig erhalten; entfernt werden ausschließlich künstliche Nummern für mathematisch zusammengehörende Bestandteile und ein bloßes Demonstrationsbeispiel.

## Ergebnis und Übergang

Mit Abschnitt 3.2.2 habe ich den allgemeinen Relationsbegriff um die Eindeutigkeitsforderung erweitert und damit den mathematischen Funktionsbegriff eingeführt. Ich habe Definitionsmenge, Zielmenge und Bildmenge voneinander unterschieden und Injektivität, Surjektivität, Bijektivität, Umkehrbarkeit, Identität, Verkettung, Mehrstellenfunktionen, parametrisierte Funktionsfamilien und partielle Funktionen eingeordnet.

Damit steht nun fest, wie ich Elemente eindeutig auf andere Elemente abbilden kann. Noch ist jedoch nicht bestimmt, welche zusätzlichen Strukturen eine solche Abbildung erhalten soll und wie ich Transformationen innerhalb strukturierter mathematischer Räume beschreiben kann.

Genau dieser Übergang führt zu Abschnitt **3.2.3 Abbildungen, Operatoren und mathematische Transformationen**.
```

### Quellabschnitt 3.2.3 – Abbildungen, Operatoren und mathematische Transformationen

- `section_id`: `25`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `18bf8340f3e847adb7fc9aca89add27504c42f2b8bc189b5ba36bacf2cc7d727`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.3 Abbildungen, Operatoren und mathematische Transformationen

Im vorhergehenden Abschnitt habe ich Funktionen als eindeutige Zuordnungen zwischen Mengen eingeführt. Damit ist festgelegt, wie Elemente mathematisch miteinander verknüpft werden können. Für die weitere Entwicklung der linearen Algebra genügt diese Beschreibung jedoch nicht. Sobald ich untersuchen möchte, wie sich Zustände innerhalb eines mathematischen Raumes verändern, muss ich Abbildungen betrachten, die zusätzlich die algebraische Struktur des jeweiligen Raumes berücksichtigen. Die lineare Algebra bezeichnet solche strukturerhaltenden Abbildungen als lineare Abbildungen oder -- bei gleichem Definitions- und Zielraum -- als Operatoren \\[71, 82\\]. Der Originalabschnitt entwickelt genau diesen Übergang vom allgemeinen Abbildungsbegriff über Linearität und Operatorverkettung bis zu Matrixdarstellung und Eigenwertproblem.

Diese begriffliche Erweiterung ist für den weiteren Aufbau meiner Arbeit notwendig. Der allgemeine Funktionsbegriff beschreibt zunächst lediglich eine eindeutige Zuordnung. Erst zusätzliche mathematische Eigenschaften legen fest, welche Strukturen unter einer Abbildung erhalten bleiben und welche verändert werden dürfen. Dadurch entsteht die Grundlage für lineare Transformationen, Matrizen und später auch für Operatorräume \\[71, 82, 13\\].

Ich verwende in diesem Abschnitt ausschließlich die in der mathematischen Literatur etablierten Begriffe. Aussagen darüber, welche Operatoren später innerhalb des Funktionalen Raum-Zeit-Kohärenzsystems verwendet werden, treffe ich bewusst noch nicht. Diese Modellentscheidungen erfolgen erst im Rahmen der axiomatischen Entwicklung in Kapitel 3.3.

## Definition 3.2.4: Mathematische Abbildung

Seien $X$ und $Y$ Mengen. Eine Abbildung $T$ ordnet jedem Element $x \\in X$ genau ein Element $y \\in Y$ zu. Ich fasse die Abbildungsvorschrift und ihre Wirkung deshalb unmittelbar zusammen:

$$T:X \\rightarrow Y,\\quad\\quad T(x) = y,\\quad x \\in X,\\ y \\in Y\\ (3.41)$$

Dabei gilt:

-   $T$ bezeichnet die Abbildung,

-   $X$ ist der Definitionsbereich,

-   $Y$ ist der Zielbereich,

-   $x$ ist ein Element aus $X$,

-   $y = T(x)$ ist das $x$ zugeordnete Element aus $Y$.

Damit besitzt eine Abbildung dieselbe grundlegende Eindeutigkeitsforderung wie eine Funktion. In der mathematischen Literatur werden beide Begriffe häufig synonym verwendet, wobei der Begriff *Abbildung* insbesondere dann verwendet wird, wenn die Wirkung auf mathematische Strukturen untersucht wird \\[71, 80, 82\\].

Die Abbildung selbst enthält zunächst keine Aussage darüber, ob geometrische, algebraische oder analytische Eigenschaften erhalten bleiben. Solche Eigenschaften ergeben sich erst aus zusätzlichen Bedingungen an die Abbildung \\[71, 82\\].

## Strukturerhaltende Abbildungen

Besitzen Definitions- und Zielmenge zusätzliche algebraische Strukturen, kann ich untersuchen, ob diese unter der Abbildung erhalten bleiben. Für Vektorräume betrifft dies insbesondere die Addition von Vektoren und die Multiplikation mit Skalaren. Abbildungen, welche diese Operationen respektieren, bilden den Gegenstand der linearen Algebra \\[71, 82, 10\\].

Eine lineare Abbildung muss sowohl die Addition als auch die Skalarmultiplikation erhalten. Anstatt diese beiden Bestandteile künstlich als voneinander unabhängige Gleichungen zu nummerieren, fasse ich die beiden zusammengehörenden Linearitätsbedingungen gemeinsam

$$\\begin{matrix}
\\begin{matrix}
T(x + y) = T(x) + T(y), \\\\
T(\\lambda x)\\& = \\lambda T(x),
\\end{matrix} & x,y \\in V,\\ \\lambda \\in K
\\end{matrix}\\ (3.42)$$

Dabei gilt:

-   $x$ und $y$ sind Vektoren,

-   $\\lambda$ ist ein Skalar aus dem zugrunde liegenden Körper $K$,

-   die erste Zeile beschreibt die Additivität,

-   die zweite Zeile beschreibt die Homogenität.

Erst wenn beide Bedingungen erfüllt sind, handelt es sich um eine lineare Abbildung. Beide Bedingungen bilden gemeinsam die mathematische Definition der Linearität \\[71, 82, 10\\]. Im Original wurden Additivität und Homogenität getrennt als Gleichungen (3.61) und (3.62) geführt; fachlich gehören sie jedoch unmittelbar zusammen.

## Definition 3.2.5: Linearer Operator

Sind Definitions- und Zielraum identisch, spreche ich von einem linearen Operator. Formal schreibe ich

$$T:V \\rightarrow V\\ (3.43)$$

Dabei bezeichnet $V$ den Vektorraum, auf dessen Elementen der Operator $T$ wirkt.

Ein Operator wirkt somit innerhalb desselben Vektorraums. Er erzeugt keinen neuen mathematischen Raum, sondern verändert ausschließlich Elemente eines bereits festgelegten Zustandsraums. Diese Definition wird in der linearen Algebra ebenso verwendet wie in der Funktionalanalysis \\[82, 13\\].

Die Bezeichnung *Operator* beschreibt dabei keine besondere Rechenvorschrift. Sie charakterisiert zunächst die Tatsache, dass Definitions- und Zielraum identisch sind \\[82, 13\\].

## Verkettung von Operatoren

Operatoren können nacheinander ausgeführt werden. Seien $A$ und $B$ zwei Operatoren auf demselben Vektorraum $V$. Ihre Voraussetzungen, ihre Verkettung und deren Wirkung gehören zu einer gemeinsamen mathematischen Struktur und werden deshalb nicht mehr auf mehrere Gleichungsnummern verteilt:

$$\\begin{matrix}
A\\&:V \\rightarrow V, \\\\
V \\rightarrow V, \\\\
\\begin{matrix}
A\\&:V \\rightarrow V, \\\\
x\\& = B(A(x))
\\end{matrix}
\\end{matrix}\\ (3.44)$$

Dabei wird zuerst $A$ auf den Vektor $x$ angewendet und anschließend $B$ auf das Ergebnis $A(x)$.

Die Reihenfolge der Anwendung besitzt im Allgemeinen Bedeutung. Deshalb gilt

$$B \\circ A \\neq A \\circ B\\ (3.45)$$

Operatoren bilden somit im Allgemeinen keine kommutative Struktur. Ihre Verkettung ist dagegen assoziativ, sodass ich längere Operatorfolgen eindeutig zusammenfassen kann \\[71, 82, 13\\]. Der ursprüngliche Abschnitt führte die beiden Operatorsignaturen, die Verkettung und deren Wirkung noch als vier eigenständige Gleichungen (3.64)--(3.67); diese künstliche Aufspaltung wird hier beseitigt.

## Identitätsoperator

Jeder Vektorraum besitzt einen Identitätsoperator. Seine Abbildungsvorschrift und seine Wirkung gehören unmittelbar zusammen:

$$I:V \\rightarrow V,\\quad\\quad I(x) = x\\quad\\forall x \\in V\\ (3.46)$$

Dabei ist $I$ der Identitätsoperator auf $V$.

Der Identitätsoperator verändert keinen Vektor und bildet das neutrale Element bezüglich der Operatorverkettung \\[82, 13\\]. Deshalb gilt für jeden passenden Operator $T$

$$I \\circ T = T \\circ I = T\\ (3.47)$$

Diese Eigenschaft entspricht der Rolle eines neutralen Elements in algebraischen Strukturen \\[71, 82\\].

## Inverse Operatoren

Ein Operator $T$ heißt invertierbar, wenn ein inverser Operator $T^{- 1}$ existiert. Die Existenz des inversen Operators und seine beiden charakteristischen Beziehungen stellen eine einzige mathematische Bedingungsstruktur dar:

$$\\begin{matrix}
T^{- 1}:V \\rightarrow V, \\\\
\\begin{matrix}
T^{- 1} \\circ T = I \\\\
T \\circ T^{- 1} = I
\\end{matrix}
\\end{matrix}\\ (3.48)$$

Dabei bezeichnet $T^{- 1}$ den inversen Operator und $I$ den Identitätsoperator auf $V$.

Invertierbare Operatoren ermöglichen eine eindeutige Rückführung transformierter Zustände auf ihren Ausgangszustand. Existiert eine solche Umkehrung nicht, können verschiedene Zustände auf denselben Zielzustand abgebildet werden beziehungsweise bei der Transformation Informationen für eine eindeutige Rekonstruktion verloren gehen \\[82, 13\\]. Im Original wurden $T^{- 1}$ und die beiden Inversenbedingungen getrennt als Gleichungen (3.72)--(3.74) geführt; dies wird hier als zusammengehörende mathematische Aussage behandelt.

## Matrixdarstellung linearer Operatoren

Für endlichdimensionale Vektorräume kann jeder lineare Operator bezüglich einer gewählten Basis durch eine Matrix dargestellt werden. Die Matrix beschreibt dabei nicht den Operator selbst, sondern dessen Darstellung relativ zu einer konkreten Basis. Ändert sich die Basis, so ändert sich im Allgemeinen auch die Matrixdarstellung, während der zugrunde liegende Operator unverändert bleibt \\[10, 82\\].

Ist $A$ die Matrixdarstellung eines Operators und $x$ der Koordinatenvektor eines Zustands, so gilt

$Ax = y$

Dabei gilt:

-   $A$ ist die Matrixdarstellung des Operators,

-   $x$ ist der Koordinatenvektor des Ausgangszustands,

-   $y$ ist der Koordinatenvektor des transformierten Zustands.

Die Größen $A$, $x$ und $y$ erhalten ausdrücklich **keine eigenen Gleichungsnummern**, weil sie Bestandteile der Gleichung (3.49) sind.

Die Matrixmultiplikation beschreibt damit die Wirkung des Operators auf den dargestellten Vektor. Die geometrische oder physikalische Interpretation dieser Wirkung hängt jedoch vom jeweiligen Anwendungsgebiet ab und folgt nicht aus der Matrixdarstellung selbst \\[10, 82\\].

## Eigenwerte und Eigenvektoren

Ein Eigenvektor eines Operators ist ein von Null verschiedener Vektor, dessen Richtungslinie unter der Wirkung des Operators erhalten bleibt. Der Operator verändert ihn lediglich durch Multiplikation mit einem Skalar, dem zugehörigen Eigenwert \\[10, 82\\].

Formal gilt

$$Ax = \\lambda x,\\quad\\quad x \\neq 0$$

Dabei gilt:

-   $A$ ist die Matrixdarstellung beziehungsweise der betrachtete lineare Operator,

-   $x$ ist ein von Null verschiedener Eigenvektor,

-   $\\lambda$ ist der zu $x$ gehörende Eigenwert.

Auch hier werden $A$, $x$ und $\\lambda$ nicht als einzelne Gleichungen geführt. Sie besitzen ihre Bedeutung ausschließlich innerhalb der Eigenwertgleichung.

Eigenwerte und Eigenvektoren bilden einen zentralen Bestandteil der linearen Algebra, weil sie wesentliche Eigenschaften eines Operators unmittelbar beschreiben und zahlreiche Berechnungen vereinfachen. Sie spielen unter anderem bei Stabilitätsuntersuchungen, Spektralzerlegungen und Differentialgleichungen eine grundlegende Rolle \\[10, 82, 13\\]. Der Originalabschnitt endet mit genau dieser Einführung des Eigenwertproblems.

## Wissenschaftliche Einordnung

Mit den in diesem Abschnitt eingeführten Begriffen erweitere ich den mathematischen Apparat gegenüber dem allgemeinen Funktionsbegriff wesentlich. Funktionen beschreiben eindeutige Zuordnungen zwischen Mengen. Lineare Abbildungen erhalten zusätzlich algebraische Strukturen. Operatoren wirken innerhalb eines gemeinsamen Vektorraums, und Matrizen stellen diese Operatoren bezüglich einer gewählten Basis dar. Eigenwerte und Eigenvektoren charakterisieren schließlich besondere Wirkungsrichtungen eines Operators \\[10, 71, 82, 13\\].

Die in diesem Abschnitt verwendeten Begriffe entsprechen vollständig der etablierten mathematischen Literatur. Die Übertragung dieser mathematischen Konzepte auf funktionale Zustandsräume des FRZK erfolgt bewusst erst nach der mathematischen Grundlegung und stellt eine eigenständige Modellentscheidung meiner Arbeit dar.

## Methodologische Betrachtungen

Methodologisch ist für mich in diesem Abschnitt vor allem die Trennung zwischen einer mathematischen Abbildung und ihrer Interpretation entscheidend. Aus der Tatsache, dass ein Operator einen Vektor in einen anderen Vektor überführt, folgt noch nicht, dass damit bereits ein physikalischer Prozess beschrieben wird. Ebenso ist eine Matrix zunächst nur die Darstellung eines Operators bezüglich einer gewählten Basis. Die physikalische oder FRZK-spezifische Bedeutung muss zusätzlich begründet werden.

Besonders wichtig ist für mich außerdem die Unterscheidung zwischen dem Operator und seiner Matrixdarstellung. Ein Wechsel der Basis kann die Matrix verändern, ohne dass sich der zugrunde liegende Operator verändert. Damit muss ich auch in der späteren FRZK-Konstruktion darauf achten, mathematische Strukturen nicht mit ihrer jeweiligen Darstellung gleichzusetzen.

Dasselbe gilt für Eigenwerte und Eigenvektoren. Sie sind zunächst etablierte mathematische Eigenschaften linearer Operatoren. Eine spätere Interpretation als ausgezeichnete funktionale Zustandsrichtungen oder als besondere dynamische Eigenschaften des FRZK wäre eine zusätzliche theoretische Setzung und folgt nicht aus der linearen Algebra selbst.

## Didaktische Betrachtungen

Didaktisch entwickle ich den Operatorbegriff bewusst aus dem bereits eingeführten Funktionsbegriff. Zunächst kenne ich eine eindeutige Zuordnung zwischen zwei Mengen. Anschließend fordere ich, dass diese Zuordnung bestimmte algebraische Strukturen erhält. Erst danach beschränke ich Definitions- und Zielraum auf denselben Vektorraum und gelange so zum Operator.

Auf diese Weise entsteht der Begriff nicht isoliert. Ich kann schrittweise nachvollziehen, welche zusätzliche Bedingung jeweils hinzukommt: Eindeutigkeit bei der Funktion, Strukturerhaltung bei der linearen Abbildung und gleicher Definitions- und Zielraum beim Operator.

Die Bereinigung der Gleichungsnummerierung unterstützt genau diese Darstellung. Im ursprünglichen Abschnitt wurden die Gleichungen **(3.59) bis (3.76)** geführt. Darunter befanden sich mehrere Ausdrücke, die lediglich Voraussetzungen oder Bestandteile derselben mathematischen Aussage darstellten, beispielsweise die getrennten Operatorsignaturen $A:V \\rightarrow V$ und $B:V \\rightarrow V$, das isolierte Symbol $T^{- 1}$ oder die getrennte Angabe des Identitätsoperators und seiner Wirkung.

Nach der verbindlichen Gleichungsregel bleiben deshalb in diesem Abschnitt die **zehn eigenständigen mathematischen Aussagen (3.41) bis (3.50)**. Der fachliche Inhalt des Originals bleibt vollständig erhalten; lediglich seine mathematisch zusammengehörenden Bestandteile werden nicht mehr künstlich auf mehrere Gleichungsnummern verteilt.

## Ergebnis und Übergang

Mit Abschnitt 3.2.3 habe ich den allgemeinen Funktionsbegriff um strukturerhaltende Abbildungen erweitert. Ich habe die Linearität über Additivität und Homogenität bestimmt, den linearen Operator als Abbildung eines Vektorraums in sich selbst eingeführt und anschließend Verkettung, Identität, Invertierbarkeit, Matrixdarstellung sowie die grundlegende Eigenwertgleichung beschrieben.

Damit ist nun bestimmt, **wie** mathematische Transformationen auf Elementen eines strukturierten Raums wirken können. Noch fehlt jedoch die genaue Bestimmung des Raums selbst, auf dessen Elementen diese Operatoren wirken.

Im folgenden Abschnitt untersuche ich deshalb den Vektorraum als mathematische Struktur für Zustände. Damit führt der Aufbau weiter zu **3.2.4 Vektorräume als mathematische Zustandsräume**.
```

### Quellabschnitt 3.2.4 – Vektorräume als mathematische Zustandsräume

- `section_id`: `26`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `67c942eb037a318d4ca603bdcaffb77a7a0c0e41c0c95aa08330a9077390a40f`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.4 Vektorräume als mathematische Zustandsräume

Nachdem ich im vorhergehenden Abschnitt lineare Abbildungen und Operatoren eingeführt habe, muss ich nun den mathematischen Raum genauer bestimmen, auf dessen Elementen solche Operatoren wirken. Die lineare Algebra beschreibt einen solchen Raum durch den Begriff des Vektorraums. Dabei wird eine Menge von Elementen mit einer inneren Addition und einer äußeren Skalarmultiplikation verbunden \\[71, 74, 82\\]. Der ursprüngliche Abschnitt entwickelt hierzu die Vektorraumdefinition, die Vektorraumaxiome, Nullvektor und additives Inverses, die Eigenschaften der Skalarmultiplikation, Untervektorräume sowie elementare Beispiele.

Der Vektorraumbegriff löst die mathematische Beschreibung von einer ausschließlich geometrischen Vorstellung des Vektors. Vektoren können gerichtete Größen im zwei- oder dreidimensionalen Raum darstellen. Sie können jedoch ebenso Funktionen, Zahlenfolgen, Matrizen oder andere mathematische Objekte sein, sofern die Vektorraumaxiome erfüllt sind \\[71, 82\\].

Für den Aufbau des Funktionalen Raum-Zeit-Kohärenzsystems übernehme ich zunächst ausschließlich diese etablierte algebraische Struktur. Die spätere Interpretation der Elemente eines solchen Raumes als funktionale Zustände ist eine eigene Modellentscheidung meiner Arbeit. Sie folgt nicht bereits aus der klassischen Definition eines Vektorraums.

## Definition 3.2.6: Vektorraum

Sei $K$ ein Körper. Unter einem Vektorraum $V$ über $K$ verstehe ich eine nichtleere Menge, auf der eine Vektoraddition und eine Skalarmultiplikation definiert sind, die gemeinsam die Vektorraumaxiome erfüllen \\[71, 82\\].

Die beiden grundlegenden Operationen fasse ich gemeinsam zusammen:

$$\\begin{matrix}
 + :V \\times V \\rightarrow V,\\ (x,y) \\mapsto x + y, \\\\
 \\cdot K \\times V \\rightarrow V,(\\lambda,x) \\mapsto \\lambda x.
\\end{matrix}\\ (3.51)$$

Dabei gilt:

-   $V$ ist der Vektorraum,

-   $K$ ist der zugrunde liegende Körper,

-   $x,y \\in V$ sind Vektoren,

-   $\\lambda \\in K$ ist ein Skalar,

-   $+$bezeichnet die Vektoraddition,

-   $\\cdot$ bezeichnet die Skalarmultiplikation.

Die beiden Operationen sind abgeschlossen. Die Summe zweier Vektoren und das Produkt eines zulässigen Skalars mit einem Vektor müssen daher wieder Elemente desselben Vektorraums sein \\[71, 74, 82\\].

## Reelle Vektorräume

Der Körper $K$ bestimmt, welche Skalare für die Skalarmultiplikation zulässig sind. In der linearen Algebra werden insbesondere Vektorräume über den reellen und den komplexen Zahlen untersucht \\[71, 82\\].

Für die weitere mathematische Entwicklung meiner Arbeit beschränke ich mich zunächst auf reelle Vektorräume und setze daher

$$K = R\\ (3.52)$$

Damit stammen die zunächst verwendeten Skalare aus den reellen Zahlen. Diese Festlegung ist keine allgemeine Eigenschaft eines Vektorraums, sondern eine methodische Entscheidung meiner Arbeit. Ich treffe sie, weil die zunächst betrachteten Zustandsgrößen reellwertig beschrieben werden sollen.

## Axiome der Vektoraddition

Für alle $x,y,z \\in V$ muss die Vektoraddition abgeschlossen sein:

$$x + y \\in V\\ (3.53)$$

Die Abgeschlossenheit stellt sicher, dass die Addition den betrachteten Vektorraum nicht verlässt \\[71, 82\\].

Die Vektoraddition ist assoziativ:

$$(x + y) + z = x + (y + z)\\ (3.54)$$

Dadurch kann ich Summen mehrerer Vektoren unabhängig von ihrer Klammerung auswerten \\[71, 74, 82\\].

Die Vektoraddition ist außerdem kommutativ:

$$x + y = y + x\\ (3.55)$$

Damit hängt die Summe zweier Vektoren nicht von ihrer Reihenfolge ab \\[71, 82\\].

## Definition 3.2.7: Nullvektor

In jedem Vektorraum existiert ein eindeutig bestimmtes neutrales Element bezüglich der Addition. Ich bezeichne dieses Element als Nullvektor $0_{V}$. Seine Zugehörigkeit zum Raum und seine neutrale Wirkung fasse ich zusammen:

$$0_{V} \\in V,\\quad\\quad x + 0_{V} = 0_{V} + x = x\\quad\\forall x \\in V\\ (3.56)$$

Der Index $V$ verdeutlicht, dass der Nullvektor ein Element des jeweiligen Vektorraums ist. Ich darf ihn deshalb nicht ohne weitere Begründung mit dem skalaren Nullelement des Körpers gleichsetzen \\[71, 82\\].

In Koordinatenräumen wird der Nullvektor durch einen Koordinatenvektor dargestellt, dessen sämtliche Komponenten gleich null sind. Für den zweidimensionalen reellen Koordinatenraum gilt beispielsweise

$$0_{R^{\\mathbb{2}}} = \\begin{pmatrix}
\\begin{matrix}
0 \\\\
0
\\end{matrix}
\\end{pmatrix}\\ (3.57)$$

Der Nullvektor besitzt bezüglich der Addition eine neutrale Wirkung. Lineare Abbildungen bilden den Nullvektor des Definitionsraums auf den Nullvektor des Zielraums ab \\[71, 74, 82\\].

## Additives Inverses

Zu jedem Vektor $x \\in V$ existiert ein additives Inverses $- x \\in V$, sodass

$$x + ( - x) = ( - x) + x = 0_{V}\\ (3.58)$$

Das additive Inverse ermöglicht mir, die Vektorsubtraktion auf die bereits definierte Addition zurückzuführen \\[71, 74\\]:

$$x - y ≔ x + ( - y)\\ (3.59)$$

Damit benötige ich für die Subtraktion keine eigenständige neue Vektorraumoperation.

## Axiome der Skalarmultiplikation

Für $\\lambda,\\mu \\in K$ und $x,y \\in V$ muss zunächst die Abgeschlossenheit gelten:

$$\\lambda x \\in V\\ (3.60)$$

Die Multiplikation eines Vektors mit einem zulässigen Skalar erzeugt damit erneut einen Vektor desselben Raumes \\[71, 82\\].

Die Skalarmultiplikation ist mit der Multiplikation im Körper verträglich:

$$(\\lambda\\mu)x = \\lambda(\\mu x)\\ (3.61)$$

Dadurch kann ich mehrere aufeinanderfolgende Skalierungen zusammenfassen \\[71, 74, 82\\].

Das multiplikative Einselement des Körpers wirkt neutral:

$$1_{K}x = x\\ (3.62)$$

Die Multiplikation mit dem skalaren Einselement verändert den Vektor somit nicht \\[71, 82\\].

Die Skalarmultiplikation ist distributiv bezüglich der Vektoraddition:

$$\\lambda(x + y) = \\lambda x + \\lambda y\\ (3.63)$$

Sie ist ebenfalls distributiv bezüglich der Addition im Skalarkörper:

$$(\\lambda + \\mu)x = \\lambda x + \\mu x\\ (3.64)$$

Diese beiden Distributivgesetze verbinden die innere Addition des Vektorraums mit den Operationen des zugrunde liegenden Körpers \\[71, 74, 82\\]. Der Originalabschnitt führt genau diese Vektorraumaxiome einzeln aus.

## Multiplikation eines Vektors mit null

Aus den Vektorraumaxiomen folgt, dass die Multiplikation eines Vektors mit dem skalaren Nullelement stets den Nullvektor ergibt \\[71, 82\\]:

$$0_{K}x = 0_{V}\\quad\\forall x \\in V\\ (3.65)$$

Diese Aussage ist keine zusätzliche Vektorraumdefinition, sondern lässt sich aus den bereits eingeführten Axiomen herleiten. Ich beginne mit\\
$${0_{K}x\\& = (0_{K} + 0_{K})x
}{= 0_{K}x + 0_{K}x,}$$

und addiere anschließend das additive Inverse von $0_{K}x$ auf beiden Seiten. Daraus folgt unmittelbar Gleichung (3.65). Die einzelnen Zwischenstufen dieser Herleitung erhalten bewusst **keine zusätzlichen Gleichungsnummern**, weil sie Bestandteile derselben Herleitung sind. Im Original waren diese Rechenschritte noch auf mehrere Gleichungen verteilt.

Das algebraische Ergebnis ist damit eindeutig bestimmt. Der Nullvektor enthält innerhalb der klassischen Vektorraumstruktur jedoch keine Information darüber, aus welcher Richtung oder von welchem ursprünglichen Vektor er durch Multiplikation mit null hervorgegangen ist \\[71, 74, 82\\].

Für das FRZK ist diese Grenze später von besonderer Bedeutung. Sollte ich dort zusätzlich zum algebraischen Resultat eine Richtungs- oder Herkunftsinformation erhalten wollen, wäre dies **keine Eigenschaft des klassischen Vektorraums**, sondern eine eigenständige Erweiterung des FRZK.

## Multiplikation des Nullvektors mit einem Skalar

Ebenso folgt aus den Vektorraumaxiomen für jeden Skalar $\\lambda \\in K$

$$\\lambda 0_{V} = 0_{V}\\ (3.66)$$

Auch diese Aussage lässt sich aus der Distributivität herleiten. Da $0_{V} = 0_{V} + 0_{V},\\ $gilt\\
$\\lambda 0_{V}\\lambda\\left( 0_{V} + 0_{V} \\right) = \\lambda 0_{V} + \\lambda_{V}.$

Nach Addition des additiven Inversen folgt Gleichung (3.66). Auch hier werden die einzelnen Herleitungsschritte nicht künstlich als eigenständige Gleichungen nummeriert. Der ursprüngliche Abschnitt führte diese Schritte noch getrennt.

Der Nullvektor bleibt damit unter jeder Skalarmultiplikation invariant \\[71, 82\\].

## Definition 3.2.8: Untervektorraum

Eine Teilmenge $U \\subseteq V$ heißt Untervektorraum von $V$, wenn sie mit den aus $V$ übernommenen Operationen selbst einen Vektorraum bildet \\[71, 74, 82\\].

Für eine nichtleere Teilmenge genügt es zu prüfen, ob sie unter Vektoraddition und Skalarmultiplikation abgeschlossen ist. Ich fasse diese Bedingungen zusammen:

$$\\begin{matrix}
x,y \\in U \\Rightarrow x + y \\in U, \\\\
\\lambda \\in K,\\ x \\in U \\Rightarrow \\lambda x \\in U.
\\end{matrix}\\ (3.67)$$

Dabei gilt:

-   $U$ ist die betrachtete Teilmenge,

-   $V$ ist der übergeordnete Vektorraum,

-   $x,y$ sind Vektoren aus $U$,

-   $\\lambda$ ist ein Skalar aus $K$.

Aus diesen Bedingungen folgt insbesondere, dass jeder Untervektorraum den Nullvektor des übergeordneten Vektorraums enthält \\[71, 74, 82\\]. Im Original wurden Teilmengenbedingung, Additionsabschluss und Abschluss unter Skalarmultiplikation auf drei einzelne Gleichungsnummern verteilt; mathematisch bilden sie hier eine gemeinsame Untervektorraumbedingung.

## Beispiele für Vektorräume

Ein grundlegendes Beispiel bildet der reelle Koordinatenraum

$$\\mathbb{R}^{n} = \\left\\{ \\begin{pmatrix}
x_{1} \\\\
 \\vdots \\\\
x_{n}
\\end{pmatrix} \\middle| x_{1},\\ldots,x_{n} \\in \\mathbb{R} \\right\\}\\ (3.68)$$

Mit komponentenweiser Addition und reeller Skalarmultiplikation bildet $\\mathbb{R}^{n}$ einen Vektorraum über $\\mathbb{R}$ \\[71, 74, 82\\].

Für $n = 2$ besitzt ein Vektor beispielsweise die Form $x = \\begin{pmatrix}
x_{1\\backslash}x_{2}
\\end{pmatrix}^{T},$ und für (n=3) $x = \\begin{pmatrix}
x_{1\\backslash}x_{2\\backslash}x_{3}
\\end{pmatrix}^{T}.$

Die Komponenten eines Koordinatenvektors hängen von der gewählten Basis ab. Der mathematische Vektor als Element des Vektorraums ist deshalb von seiner konkreten Koordinatendarstellung zu unterscheiden \\[71, 74, 82\\].

Auch die Menge aller reellen $m \\times n$-Matrizen

$$\\mathbb{R}^{m \\times n}\\ (3.69)$$

bildet mit der gewöhnlichen Matrizenaddition und der Skalarmultiplikation einen reellen Vektorraum \\[71, 74\\].

Ebenso können geeignete Mengen reellwertiger Funktionen als Vektorräume aufgefasst werden, sofern Addition und Skalarmultiplikation punktweise definiert sind und die jeweilige Funktionenklasse unter diesen Operationen abgeschlossen bleibt \\[71, 76, 82\\].

Damit zeigt sich, dass der Vektorraumbegriff nicht an geometrische Pfeile oder an einen dreidimensionalen Anschauungsraum gebunden ist. Entscheidend sind ausschließlich die algebraischen Operationen und die Erfüllung der Vektorraumaxiome.

## Wissenschaftliche Einordnung

Der Vektorraum stellt für mich eine abstrakte algebraische Struktur dar, durch die sehr unterschiedliche mathematische Objekte einheitlich behandelt werden können. Entscheidend ist nicht die konkrete Gestalt seiner Elemente, sondern die Erfüllung der Vektorraumaxiome \\[71, 82\\].

Durch die Einführung des Vektorraums kann ich anschließend lineare Kombinationen, Spannräume, lineare Unabhängigkeit, Basen und Dimensionen präzise definieren. Diese Begriffe benötige ich wiederum, um Zustände durch Koordinaten darzustellen und lineare Operatoren durch Matrizen zu beschreiben \\[71, 74, 82\\].

Für das FRZK bildet ein Vektorraum zunächst lediglich den mathematischen Rahmen eines möglichen Zustandsraums. Die klassische Vektorraumdefinition entscheidet nicht darüber, welche Komponenten ein funktionaler Zustand besitzt, wie ich diese Komponenten physikalisch oder funktional interpretiere oder ob zusätzliche Informationen über Richtung, Herkunft oder Kohärenz erhalten bleiben.

Diese Festlegungen muss ich als eigenständige Konstruktionen des FRZK ausdrücklich von der übernommenen linearen Algebra trennen.

## Methodologische Betrachtungen

Methodologisch ist für mich besonders wichtig, dass der Begriff des Vektorraums keine konkrete physikalische Interpretation seiner Elemente voraussetzt. Dieselben Vektorraumaxiome können für Koordinatenvektoren, Matrizen, Funktionen oder andere mathematische Objekte gelten \\[71, 74, 82\\].

Damit darf ich aus der Tatsache, dass ein späterer FRZK-Zustandsraum als Vektorraum modelliert wird, noch nicht ableiten, dass seine Elemente räumliche Vektoren im geometrischen Sinn sein müssen. Die Vektorraumstruktur legt lediglich fest, welche algebraischen Operationen möglich sind und welche Axiome diese Operationen erfüllen.

Besonders deutlich wird diese methodische Grenze an der Multiplikation mit dem skalaren Nullelement. Die klassische lineare Algebra liefert eindeutig $0_{K}x = 0_{V}.$

Damit ist das algebraische Resultat vollständig bestimmt. Informationen darüber, aus welchem Vektor $x$ dieses Resultat hervorgegangen ist oder welche Richtung $x$ zuvor besaß, gehören nicht mehr zur Information des Nullvektors. Wenn ich im FRZK eine solche Information zusätzlich erhalten möchte, muss ich sie durch eine zusätzliche Struktur oder ein eigenes Axiom einführen. Ich darf sie nicht nachträglich der klassischen Vektorraumstruktur zuschreiben.

Dasselbe gilt für die Wahl von $\\mathbb{R}$ als Skalarkörper. Sie ist eine methodische Festlegung meiner Arbeit und keine mathematische Notwendigkeit. Ein Vektorraum könnte ebenso über einem anderen geeigneten Körper definiert werden.

## Didaktische Betrachtungen

Didaktisch entwickle ich den Vektorraum aus zwei bereits bekannten Operationstypen. Zunächst kenne ich aus den vorhergehenden Abschnitten Funktionen und Abbildungen. Nun betrachte ich zwei spezielle Abbildungen: die Addition zweier Vektoren und die Multiplikation eines Vektors mit einem Skalar. Erst die gemeinsam geltenden Axiome machen aus der zugrunde liegenden Menge einen Vektorraum.

Diese Reihenfolge macht für mich sichtbar, dass ein Vektorraum nicht einfach „eine Menge von Vektoren" ist. Entscheidend ist vielmehr die Struktur, die durch die beiden Operationen und ihre Axiome entsteht.

Auch die Unterscheidung zwischen der skalaren Null $0_{K}$ und dem Nullvektor $0_{V}$ ist didaktisch bedeutsam. Beide können in konkreten Koordinatendarstellungen ähnlich aussehen, besitzen jedoch unterschiedliche mathematische Rollen. Die skalare Null ist ein Element des Körpers, während der Nullvektor ein Element des Vektorraums ist.

Die neue Gleichungsregel reduziert auch in diesem Abschnitt die künstliche Nummerierung erheblich. Der ursprüngliche Text führte die Gleichungen **(3.77) bis (3.112)** und nummerierte dabei unter anderem einzelne Mengenangaben, Variablenvoraussetzungen und mehrere Zwischenschritte derselben Herleitung separat.

Nach der Bereinigung bleiben die eigenständigen mathematischen Aussagen **(3.51) bis (3.69)**. Der fachliche Inhalt bleibt vollständig erhalten; lediglich mathematisch zusammengehörende Voraussetzungen, Größen und Herleitungsschritte werden nicht mehr als eigenständige Gleichungen behandelt.

## Ergebnis und Übergang

Mit Abschnitt 3.2.4 habe ich den Vektorraum als abstrakte algebraische Struktur eingeführt. Ich habe die Vektoraddition und Skalarmultiplikation, ihre Axiome, den Nullvektor, additive Inverse, die Wirkung der skalaren Null, Untervektorräume sowie grundlegende Beispiele beschrieben.

Damit ist nun der mathematische Raum bestimmt, in dem lineare Operationen ausgeführt werden können. Noch ist jedoch nicht geklärt, wie sich aus gegebenen Vektoren weitere Vektoren erzeugen lassen und welche Teile eines Vektorraums durch eine Menge von Vektoren aufgespannt werden.

Im nächsten Abschnitt untersuche ich deshalb **3.2.5 Linearkombinationen, Spannräume und Erzeugendensysteme**.
```

### Quellabschnitt 3.2.5 – Linearkombinationen, Spannräume und Erzeugendensysteme

- `section_id`: `27`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `1c2f7225b3636f943f2efc3afa3b9cca8675bb6d7dbafd3dd4bac3a515278a89`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.5 Linearkombinationen, Spannräume und Erzeugendensysteme

Mit der Definition des Vektorraums habe ich die beiden grundlegenden Operationen der linearen Algebra eingeführt. Daraus ergibt sich unmittelbar die Frage, welche Vektoren ich aus bereits bekannten Vektoren konstruieren kann. Die lineare Algebra beantwortet diese Frage mit dem Begriff der Linearkombination. Er beschreibt, wie durch Skalarmultiplikation und anschließende Addition aus vorhandenen Vektoren weitere Vektoren entstehen \\[71, 74, 82\\]. Genau auf diesem Aufbau basiert auch der ursprüngliche Abschnitt 3.2.5.

Die Linearkombination besitzt eine zentrale Bedeutung, weil nahezu alle unmittelbar folgenden Begriffe der linearen Algebra auf ihr aufbauen. Dazu gehören insbesondere Spannräume, Erzeugendensysteme, lineare Unabhängigkeit, Basen und Dimensionen. Ohne den Begriff der Linearkombination kann ich weder bestimmen, welche Vektoren sich aus einer gegebenen Vektormenge erzeugen lassen, noch welche Vektoren für die vollständige Beschreibung eines Vektorraums tatsächlich erforderlich sind \\[71, 74, 82\\].

Für den weiteren Aufbau des Funktionalen Raum-Zeit-Kohärenzsystems übernehme ich zunächst ausschließlich die klassische mathematische Definition. Eine funktionale Interpretation der Kombination einzelner Zustandskomponenten erfolgt erst nach Abschluss dieser mathematischen Grundlegung. Damit bleibt auch in diesem Abschnitt die Trennung zwischen etablierter linearer Algebra und späterer FRZK-Eigenleistung erhalten.

## Definition 3.2.9: Linearkombination

Seien $v_{1},v_{2},\\ldots,v_{n} \\in V\\ $Vektoren eines Vektorraums $V$ und $\\lambda_{1},\\lambda_{2},\\ldots,\\lambda_{n} \\in K$ Skalare des zugrunde liegenden Körpers $K$.

Dann heißt der Ausdruck

$$v = \\lambda_{1}v_{1} + \\lambda_{2}v_{2} + \\cdots + \\lambda_{n}v_{n} = \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}}\\ (3.70)$$

eine Linearkombination der Vektoren $v_{1},\\ldots,v_{n}$.

Dabei gilt:

-   $v_{1},\\ldots,v_{n}$ sind die Vektoren, aus denen die Kombination gebildet wird,

-   $\\lambda_{1},\\ldots,\\lambda_{n}$ sind die zugehörigen Skalare,

-   $K$ ist der Skalarkörper,

-   $v$ ist der durch die Linearkombination erzeugte Vektor.

Jede solche Linearkombination ist aufgrund der Vektorraumaxiome wiederum ein Element desselben Vektorraums \\[71, 82\\]. Die ältere Repository-Fassung beschreibt die Linearkombination entsprechend als Summe $\\lambda_{1}v_{1} + \\cdots + \\lambda_{n}v_{n}$.

Die Skalare bestimmen den jeweiligen Beitrag der einzelnen Vektoren zur resultierenden Linearkombination. Verändere ich einen oder mehrere dieser Skalare, erhalte ich im Allgemeinen einen anderen Vektor \\[71, 74\\].

Dabei ist wichtig, dass eine Linearkombination keine neue mathematische Operation neben Addition und Skalarmultiplikation einführt. Sie setzt ausschließlich die beiden bereits definierten Vektorraumoperationen miteinander zusammen. Gerade dadurch zeigt sich, wie aus den elementaren Axiomen des Vektorraums weiterführende Strukturen entstehen.

## Beispiel

Zur Veranschaulichung betrachte ich im $\\mathbb{R}^{2}$ die beiden Vektoren

$$v_{1} = \\begin{pmatrix}
1\\backslash 0
\\end{pmatrix},\\quad\\quad v_{2} = \\begin{pmatrix}
0\\backslash 1
\\end{pmatrix}.
$$

Wähle ich beispielsweise die Skalare $2$ und $3$, ergibt sich

$$2v_{1} + 3v_{2} = 2\\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} + 3\\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} = \\begin{pmatrix}
2 \\\\
3
\\end{pmatrix}$$

Dieses Beispiel zeigt, wie aus gegebenen Vektoren durch geeignete Wahl der Skalare ein weiterer Vektor desselben Vektorraums entsteht. Der resultierende Vektor muss im Allgemeinen mit keinem der Ausgangsvektoren übereinstimmen \\[74, 82\\]. Der Originalabschnitt enthält genau diesen didaktischen Schritt von zwei gegebenen Vektoren zu einer konkreten Linearkombination.

Die entscheidende Frage lautet nun nicht mehr nur, **einen** Vektor durch eine Linearkombination zu erzeugen. Ich kann vielmehr untersuchen, welche Gesamtheit von Vektoren entsteht, wenn sämtliche zulässigen Skalare berücksichtigt werden.

## Definition 3.2.10: Spannraum

Die Gesamtheit aller Linearkombinationen einer gegebenen Vektormenge bezeichnet deren Spannraum \\[71, 82\\].

Für $v_{1},\\ldots,v_{n} \\in V$ definiere ich

$$\\text{span}\\left( v_{1},\\ldots,v_{n} \\right) = \\left\\{ \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} \\middle| \\lambda_{1},\\ldots,\\lambda_{n} \\in K \\right\\}\\ (3.71)$$

Dabei bezeichnet $\\text{span}\\left( v_{1},\\ldots,v_{n} \\right)$ die Menge aller Vektoren, die ich aus $v_{1},\\ldots,v_{n}$ durch Linearkombinationen erzeugen kann.

Im älteren Repository ist derselbe Begriff als Menge aller Summen $\\sum_{i = 1}^{n}{\\lambda_{i}v_{i}}$ erfasst.

Im Originalabschnitt wurden zunächst eine kürzere Spannschreibweise und anschließend deren Mengendarstellung getrennt nummeriert. Beide Ausdrücke bezeichnen jedoch **denselben mathematischen Gegenstand**. Ich führe sie deshalb hier in Gleichung (3.71) zu einer einzigen Definition zusammen.

Der Spannraum ist nicht lediglich eine beliebige Teilmenge des Vektorraums. Er ist selbst ein Untervektorraum von $V$ und zugleich der kleinste Untervektorraum, der alle betrachteten Vektoren $v_{1},\\ldots,v_{n}$ enthält \\[71, 82\\].

Das Wort *kleinste* ist dabei wesentlich. Jeder Untervektorraum, der sämtliche Vektoren $v_{1},\\ldots,v_{n}$ enthält, muss aufgrund seiner Abgeschlossenheit auch sämtliche Linearkombinationen dieser Vektoren enthalten. Damit muss er auch den gesamten Spannraum enthalten.

Der Spannraum beschreibt somit genau denjenigen Teil des Vektorraums, den ich mit den vorgegebenen Vektoren erreichen kann.

## Erzeugendensysteme

Eine Menge von Vektoren heißt Erzeugendensystem eines Vektorraums $V$, wenn ihr Spannraum den gesamten Vektorraum ergibt \\[71, 74, 82\\].

Für die Vektoren $v_{1},\\ldots,v_{n}$ gilt daher

$$V = \\text{span}\\left( v_{1},\\ldots,v_{n} \\right)\\ (3.72)$$

Dann kann ich jeden Vektor $v \\in V$ als Linearkombination der Vektoren des Erzeugendensystems schreiben \\[71, 82\\]. Der ursprüngliche Abschnitt verwendet genau diese Bedingung zur Definition eines Erzeugendensystems.

Das bedeutet nicht, dass die Darstellung eines Vektors durch ein Erzeugendensystem eindeutig sein muss. Enthält das Erzeugendensystem mehr Vektoren als für die Erzeugung des Raums erforderlich sind, kann derselbe Vektor durch unterschiedliche Linearkombinationen dargestellt werden \\[71, 74\\].

Ebenso ist ein Erzeugendensystem selbst nicht eindeutig. Unterschiedliche Mengen von Vektoren können denselben Vektorraum aufspannen. Entscheidend ist ausschließlich, dass aus den jeweiligen Vektoren durch Linearkombination sämtliche Elemente des betrachteten Raums erzeugt werden können.

## Minimale Erzeugendensysteme

Enthält ein Erzeugendensystem einen Vektor, der bereits als Linearkombination der übrigen Vektoren dargestellt werden kann, trägt dieser Vektor nichts zusätzlich zum Spannraum bei. Ich kann ihn entfernen, ohne den erzeugten Raum zu verändern \\[71, 74, 82\\].

Damit kann ich ein Erzeugendensystem schrittweise verkleinern, solange redundante Vektoren vorhanden sind. Ein minimales Erzeugendensystem besitzt keine solchen entbehrlichen Vektoren mehr.

An diesem Punkt entsteht unmittelbar die nächste mathematische Frage: Woran erkenne ich formal, ob ein Vektor durch die übrigen Vektoren erzeugt werden kann?

Die Antwort darauf liefert der Begriff der **linearen Unabhängigkeit**. Ein minimales Erzeugendensystem führt damit unmittelbar zum Basisbegriff, der im folgenden Abschnitt systematisch entwickelt wird. Genau diesen Übergang stellt auch der ursprüngliche Abschnitt her.

## Wissenschaftliche Einordnung

Die Linearkombination bildet eine der grundlegenden Konstruktionen innerhalb eines Vektorraums. Aus ihr entstehen Spannräume, Erzeugendensysteme, Basen und schließlich Koordinatendarstellungen. Damit bildet sie den Ausgangspunkt für einen großen Teil der strukturellen Untersuchungen der linearen Algebra \\[71, 74, 82\\].

Für meine weitere Arbeit ist besonders wichtig, dass eine Linearkombination zwischen den bereits vorhandenen Vektoren und dem durch ihre Kombination entstehenden Vektor unterscheidet. Der erzeugte Vektor ist zwar vollständig durch die verwendeten Ausgangsvektoren und Skalare bestimmt, er stellt jedoch ein eigenes Element des Vektorraums dar.

Der Spannraum erweitert diese Betrachtung von einem einzelnen erzeugten Vektor auf die Gesamtheit aller erzeugbaren Vektoren. Damit kann ich mathematisch präzise beantworten, welcher Bereich eines Zustandsraums durch eine gegebene Menge von Ausgangselementen erreichbar ist.

Für das Funktionale Raum-Zeit-Kohärenzsystem besitzt dieser Begriff eine besondere Bedeutung. Funktionale Zustände sollen später nicht ausschließlich isoliert betrachtet werden, sondern können aus mehreren Zustandskomponenten aufgebaut werden. Die mathematische Grundlage dafür stellt zunächst ausschließlich die klassische Theorie der Linearkombinationen bereit. Welche funktionale Bedeutung einzelne Komponenten, ihre Skalierung und ihre Kombination im FRZK besitzen, folgt daraus jedoch noch nicht. Der Originaltext trennt diese spätere funktionale Interpretation ebenfalls ausdrücklich von der klassischen linearen Algebra.

## Methodologische Betrachtungen

Methodologisch zeigt sich in diesem Abschnitt besonders deutlich die Grenze zwischen mathematischer Erzeugbarkeit und wissenschaftlicher Interpretation.

Wenn

$$v = \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}}$$

gilt, ist damit mathematisch eindeutig beschrieben, wie der Vektor $v$ aus den Vektoren $v_{i}$ konstruiert wird. Daraus folgt jedoch noch nicht, welche physikalische oder funktionale Bedeutung die einzelnen Beiträge besitzen.

Insbesondere darf ich die Koeffizienten $\\lambda_{i}$ nicht ohne zusätzliche Begründung als physikalische Gewichte, Wahrscheinlichkeiten, Intensitäten oder Wirkungsstärken interpretieren. In der linearen Algebra sind sie zunächst ausschließlich Skalare des zugrunde liegenden Körpers.

Ebenso beschreibt der Spannraum mathematisch, welche Vektoren aus einer Vektormenge erzeugt werden können. Daraus folgt nicht automatisch, dass alle diese Vektoren innerhalb eines physikalischen Modells tatsächlich realisiert werden können. Mathematische Erzeugbarkeit und physikalische Realisierbarkeit sind unterschiedliche Aussagen.

Für das FRZK muss ich später deshalb ausdrücklich festlegen, welche Zustandskomponenten miteinander kombiniert werden dürfen, welche Koeffizienten zulässig sind und ob zusätzliche Bedingungen die mathematisch mögliche Menge der Linearkombinationen einschränken.

Diese Einschränkungen wären dann FRZK-spezifische Modellbedingungen. Sie gehören nicht zur klassischen Definition des Spannraums.

## Didaktische Betrachtungen

Didaktisch entwickelt sich dieser Abschnitt unmittelbar aus den Vektorraumaxiomen.

Zunächst habe ich zwei Operationen zur Verfügung:

-   Vektoren können addiert werden,

-   Vektoren können mit Skalaren multipliziert werden.

Die Linearkombination verbindet genau diese beiden Operationen. Dadurch kann ich aus mehreren vorhandenen Vektoren einen weiteren Vektor erzeugen.

Anschließend erweitere ich die Frage:

Nicht mehr nur

**„Welchen Vektor erhalte ich aus einer bestimmten Wahl der Skalare?"**

sondern

**„Welche Vektoren kann ich überhaupt aus diesen Ausgangsvektoren erzeugen?"**

Die Antwort ist der Spannraum.

Danach folgt die nächste Erweiterung:

**„Erzeugt dieser Spannraum bereits den gesamten Vektorraum?"**

Ist dies der Fall, bilden die Ausgangsvektoren ein Erzeugendensystem.

Damit entsteht eine klare begriffliche Kette:\\
$$\\text{Vektoren} \\longrightarrow \\text{Linearkombinationen} \\longrightarrow \\text{Spannraum} \\longrightarrow \\text{Erzeugendensystem}.$$

Diese Darstellung dient nur der didaktischen Zusammenfassung. Die Gleichungsbereinigung ist in diesem Abschnitt besonders deutlich. Im Original wurden die mathematischen Angaben als Gleichungen **(3.113) bis (3.120)** geführt. Dazu gehörten jedoch auch reine Voraussetzungen wie die Zugehörigkeit der $v_{i}$ zum Vektorraum und der $\\lambda_{i}$ zum Skalarkörper sowie eine zweite Schreibweise desselben Spannraums.

Nach der verbindlichen Regel bleiben deshalb nur vier eigenständige mathematische Aussagen:

-   **(3.69)** Linearkombination,

-   **(3.70)** konkretes Beispiel,

-   **(3.71)** Spannraum,

-   **(3.72)** Erzeugendensystem.

Der vollständige fachliche Inhalt bleibt erhalten. Lediglich mathematisch unselbstständige Voraussetzungen und alternative Schreibweisen werden nicht mehr künstlich als eigene Gleichungen gezählt.

## Ergebnis und Übergang

Mit Abschnitt 3.2.5 habe ich beschrieben, wie ich aus vorhandenen Vektoren durch Addition und Skalarmultiplikation weitere Vektoren erzeugen kann. Die Linearkombination bildet dabei die elementare Konstruktion. Der Spannraum erfasst die Gesamtheit aller auf diese Weise erzeugbaren Vektoren, und ein Erzeugendensystem liegt vor, wenn dieser Spannraum den gesamten Vektorraum umfasst.

Damit ist jedoch noch nicht geklärt, ob alle Vektoren eines Erzeugendensystems tatsächlich erforderlich sind. Ein Erzeugendensystem kann redundante Vektoren enthalten, die bereits aus den übrigen Vektoren hervorgehen.

Im nächsten Abschnitt untersuche ich daher, wann Vektoren voneinander unabhängig sind und unter welchen Bedingungen ein Erzeugendensystem zugleich eine Basis bildet. Damit führt der Aufbau unmittelbar zu **3.2.6 Lineare Unabhängigkeit, Basis und Dimension**.
```

### Quellabschnitt 3.2.6 – Lineare Unabhängigkeit, Basis und Dimension

- `section_id`: `28`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `4f582f4a4df5b2caa711144499b68ad4476644161f7491d87fdc50a922a7dae0`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.6 Lineare Unabhängigkeit, Basis und Dimension

Mit dem Spannraum kann ich bestimmen, welche Vektoren sich aus einer gegebenen Vektormenge durch Linearkombinationen erzeugen lassen. Damit ist jedoch noch nicht geklärt, ob alle verwendeten Vektoren tatsächlich erforderlich sind. Enthält eine Vektormenge einen Vektor, der bereits durch die übrigen Vektoren erzeugt werden kann, ist dieser für die Erzeugung des Spannraums redundant. Die lineare Algebra erfasst diesen Unterschied durch die Begriffe der linearen Unabhängigkeit und linearen Abhängigkeit \\[71, 74, 82\\].

Diese Unterscheidung führt unmittelbar zum Basisbegriff. Eine Basis soll einerseits den gesamten Vektorraum erzeugen, andererseits aber keine überflüssigen Vektoren enthalten. Sie ist deshalb ein linear unabhängiges Erzeugendensystem. Die Anzahl der Vektoren einer Basis bestimmt bei endlichdimensionalen Vektorräumen schließlich deren Dimension \\[71, 74, 82\\].

Für meine weitere Entwicklung ist diese Struktur besonders wichtig. Sobald ich einen mathematischen Zustandsraum durch Komponenten beschreiben möchte, muss ich wissen, ob diese Komponenten voneinander unabhängig sind, ob sie den gesamten Raum erfassen und wie viele unabhängige Richtungen für seine Beschreibung erforderlich sind. Die mathematischen Begriffe liefern hierfür zunächst ausschließlich die formale Grundlage. Die Auswahl und Interpretation funktionaler Basisrichtungen innerhalb des FRZK erfolgt erst auf dieser Grundlage.

## Definition 3.2.11: Lineare Unabhängigkeit

Seien $v_{1},\\ldots,v_{n} \\in V$ Vektoren eines Vektorraums $V$ über einem Körper $K$.

Die Vektoren $v_{1},\\ldots,v_{n}$ heißen linear unabhängig, wenn die Gleichung

$$\\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} = 0_{V}\\quad \\Longrightarrow \\quad\\lambda_{1} = \\lambda_{2} = \\cdots = \\lambda_{n} = 0_{K}\\ (3.74)$$

für $\\lambda_{1},\\ldots,\\lambda_{n} \\in K$ gilt.

Dabei bezeichnet

-   $v_{1},\\ldots,v_{n}$ die untersuchten Vektoren,

-   $\\lambda_{1},\\ldots,\\lambda_{n}$ die zugehörigen Skalare,

-   $0_{V}$ den Nullvektor des Vektorraums,

-   $0_{K}$ das additive Nullelement des Skalarkörpers.

Die Aussage bedeutet, dass ausschließlich die triviale Linearkombination den Nullvektor erzeugt. Es gibt also keine nichttriviale Kombination der betrachteten Vektoren, deren Ergebnis $0_{V}$ ist \\[71, 74, 82\\].

Damit besitzt keiner der Vektoren eine Erzeugungsinformation, die bereits vollständig in den übrigen Vektoren enthalten wäre.

## Definition 3.2.12: Lineare Abhängigkeit

Eine Vektormenge $v_{1},\\ldots,v_{n}$ heißt linear abhängig, wenn Skalare existieren, die nicht sämtlich null sind und dennoch den Nullvektor erzeugen:

$$\\exists\\,\\lambda_{1},\\ldots,\\lambda_{n} \\in K:\\quad\\quad\\left( \\sum_{i = 1}^{n}{\\lambda_{i}v_{i}} = 0_{V} \\right) \\land \\left( \\exists j:\\lambda_{j} \\neq 0_{K} \\right)(3.75)$$

Die lineare Abhängigkeit ist damit genau das Gegenstück zur linearen Unabhängigkeit \\[71, 74, 82\\].

Ist beispielsweise $\\lambda_{j} \\neq 0_{K}$, kann ich Gleichung (3.75) nach $v_{j}$ auflösen:

$$v_{j} = - \\frac{1}{\\lambda_{j}}\\sum_{i = 1\\backslash\\backslash i \\neq j}^{n}{\\lambda_{i}v_{i}}\\ (3.76)$$

Damit wird unmittelbar sichtbar, was lineare Abhängigkeit bedeutet: Mindestens ein Vektor kann vollständig als Linearkombination der übrigen dargestellt werden. Dieser Vektor erweitert den erzeugten Spannraum nicht.

## Beispiel für lineare Abhängigkeit

Ich betrachte im zweidimensionalen reellen Vektorraum

$$v_{1} = \\begin{pmatrix}
1 \\\\
2
\\end{pmatrix},\\quad\\quad v_{2} = \\begin{pmatrix}
2 \\\\
4
\\end{pmatrix}.
$$Diese Vektoren erfüllen\\
$$v_{2} = 2v_{1}\\quad\\quad \\Longleftrightarrow \\quad\\quad 2v_{1} - v_{2} = 0_{R^{\\mathbb{2}}}\\ (3.77)$$

Die Koeffizienten $2$ und $- 1$ sind nicht beide null. Deshalb bilden $v_{1}$ und $v_{2}$ eine linear abhängige Vektormenge.

Geometrisch liegen beide Vektoren auf derselben Ursprungsgeraden. Der zweite Vektor eröffnet deshalb keine zusätzliche unabhängige Richtung.

## Beispiel für lineare Unabhängigkeit

Nun betrachte ich\\
$$v_{1} = \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix},\\quad\\quad v_{2} = \\begin{pmatrix}
0 \\\\
1
\\end{pmatrix}.$$

Aus

$$\\lambda_{1}\\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} + \\lambda_{2}\\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} = \\begin{pmatrix}
0 \\\\
0
\\end{pmatrix}\\quad \\Longrightarrow \\quad\\lambda_{1} = \\lambda_{2} = 0\\ (3.78)$$

folgt unmittelbar, dass die beiden Vektoren linear unabhängig sind \\[71, 74\\].

Keiner der beiden Vektoren lässt sich aus dem anderen erzeugen. Beide liefern deshalb jeweils eine eigenständige Richtung des zweidimensionalen Vektorraums.

## Definition 3.2.13: Basis

Eine geordnete Vektormenge\\
$$B = \\left( b_{1},\\ldots,b_{n} \\right)$$

bezeichne ich als Basis eines Vektorraums $V$, wenn zwei Bedingungen gleichzeitig erfüllt sind:

$$\\begin{matrix}
V = \\text{span}\\left( b_{1},\\ldots,b_{n} \\right), \\\\
\\text{∑}_{i = 1}^{n}\\lambda_{i}b_{i} = 0_{V} \\Longrightarrow \\lambda_{1} = \\cdots = \\lambda_{n} = 0_{K}.
\\end{matrix}\\ (3.79)$$

Die erste Bedingung verlangt, dass die Basis den gesamten Vektorraum erzeugt. Die zweite Bedingung verlangt lineare Unabhängigkeit.

Eine Basis ist damit ein vollständiges, aber nicht redundantes Erzeugungssystem \\[71, 74, 82\\].

Gerade die Verbindung dieser beiden Eigenschaften ist entscheidend. Ein lediglich linear unabhängiges System muss nicht den gesamten Raum erzeugen. Ein Erzeugendensystem kann dagegen redundante Vektoren enthalten. Erst die Basis erfüllt beide Anforderungen gleichzeitig.

## Eindeutige Darstellung bezüglich einer Basis

Ist $B = \\left( b_{1},\\ldots,b_{n} \\right)$ eine Basis von $V$, dann besitzt jeder Vektor $v \\in V$ eine eindeutig bestimmte Darstellung

$$v = \\sum_{i = 1}^{n}{\\lambda_{i}b_{i}}\\ (3.80)$$

Die Koeffizienten $\\lambda_{1},\\ldots,\\lambda_{n}$ heißen die Koordinaten des Vektors $v$ bezüglich der Basis $B$ \\[71, 74, 82\\].

Die Eindeutigkeit folgt unmittelbar aus der linearen Unabhängigkeit der Basisvektoren. Angenommen, für denselben Vektor existierten zwei unterschiedliche Darstellungen,

$$v\\sum_{i = 1}^{n}{\\lambda_{i}b_{i\\sum_{i = 1}^{n}{\\mu_{i}b_{i}}}}.
$$

Dann folgt nach Subtraktion\\
$$\\sum_{i = 1}^{n}{\\left( \\lambda_{i} - \\mu_{i} \\right)b_{i}}0_{V}.$$

Da die Basisvektoren linear unabhängig sind, muss für jedes $i$\\
$$\\lambda_{i} - \\mu_{i} = 0$$

gelten. Also ist $\\lambda_{i} = \\mu_{i}$ für alle $i$.

Diese Zwischenstufen gehören zu einer gemeinsamen Herleitung und erhalten deshalb keine zusätzlichen Gleichungsnummern.

## Standardbasis des reellen Koordinatenraums

Für den reellen Koordinatenraum $\\mathbb{R}^{n}$ verwende ich die Standardbasis

$$E_{n} = \\left( e_{1},\\ldots,e_{n} \\right),\\quad\\quad e_{i} = \\begin{pmatrix}
0 \\\\
 \\vdots \\\\
1 \\\\
 \\vdots \\\\
0
\\end{pmatrix}\\ (3.81)$$

wobei beim Vektor $e_{i}$ genau die $i$-te Komponente den Wert $1$ besitzt und alle übrigen Komponenten gleich $0$ sind \\[71, 74\\].

Für $\\mathbb{R}^{2}$ ergibt sich damit unmittelbar

$$e_{1} = \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix},\\quad\\quad e_{2} = \\begin{pmatrix}
0 \\\\
1
\\end{pmatrix}.
$$Diese konkrete Ausprägung ist ein Beispiel der allgemeinen Definition (3.81). Jeder Vektor\\
$$v = \\begin{pmatrix}
v_{1} \\\\
 \\vdots \\\\
v_{n}
\\end{pmatrix}$$

besitzt bezüglich dieser Basis die Darstellung

$$v = v_{1}e_{1} + \\cdots + v_{n}e_{n} = \\sum_{i = 1}^{n}v_{i}e_{i}\\ (3.82)$$

Die Komponenten $v_{1},\\ldots,v_{n}$ sind damit genau die Koordinaten des Vektors bezüglich der Standardbasis.

## Vektor und Koordinatendarstellung

Ich muss den mathematischen Vektor von seiner Koordinatendarstellung unterscheiden. Der Vektor ist ein Element des Vektorraums. Ein Koordinatenvektor beschreibt dieses Element dagegen bezüglich einer konkret gewählten Basis \\[71, 74, 82\\].

Für eine Basis\\
$$B = \\left( b_{1},\\ldots,b_{n} \\right)$$

und\\
$$v = \\sum_{i = 1}^{n}{\\lambda_{i}b_{i}}$$

definiere ich den zugehörigen Koordinatenvektor durch

$$\\lbrack v\\rbrack_{B} = \\begin{pmatrix}
\\lambda_{1} \\\\
\\lambda_{2} \\\\
 \\vdots \\\\
\\lambda_{n}
\\end{pmatrix}\\ (3.83)$$

Dabei bezeichnet $\\lbrack v\\rbrack_{B}$ die Koordinatendarstellung des Vektors $v$ bezüglich der Basis $B$.

Ändere ich die Basis, ändern sich im Allgemeinen die Koordinaten. Der Vektor selbst bleibt jedoch unverändert. Diese Unterscheidung ist für die weitere Arbeit wesentlich, weil mathematische Eigenschaften eines Zustands nicht mit den Zahlen verwechselt werden dürfen, durch die dieser Zustand in einer bestimmten Darstellung beschrieben wird.

## Definition 3.2.14: Dimension

Besitzt ein Vektorraum $V$ eine endliche Basis mit $n$ Elementen, dann bezeichne ich $V$ als endlichdimensional und definiere

$$\\dim(V) = n\\ (3.84)$$

Alle Basen desselben endlichdimensionalen Vektorraums besitzen dieselbe Anzahl von Elementen. Dadurch ist die Dimension unabhängig davon, welche konkrete Basis ich zur Darstellung verwende \\[71, 74, 82\\].

Für den reellen Koordinatenraum folgt

$$\\dim\\left( \\mathbb{R}^{n} \\right) = n\\ (3.85)$$

Damit gilt insbesondere\\
$$\\dim\\left( \\mathbb{R}^{2} \\right) = 2,\\quad\\quad\\dim\\left( \\mathbb{R}^{3} \\right) = 3.$$

Diese beiden Aussagen sind unmittelbare Spezialfälle von Gleichung (3.85). Die Dimension beschreibt damit die Anzahl unabhängiger Basisrichtungen, die erforderlich ist, um den gesamten Vektorraum zu erzeugen.

## Basiserweiterung und Basisreduktion

Eine linear unabhängige Menge in einem endlichdimensionalen Vektorraum kann zu einer Basis ergänzt werden. Fehlen noch Richtungen zur Erzeugung des gesamten Raumes, können geeignete weitere Vektoren hinzugefügt werden, bis der gesamte Raum aufgespannt wird \\[71, 74, 82\\].

Umgekehrt kann ich aus einem endlichen Erzeugendensystem eine Basis gewinnen, indem ich schrittweise redundante Vektoren entferne. Sobald ein Vektor bereits als Linearkombination der übrigen Vektoren darstellbar ist, kann ich ihn entfernen, ohne den Spannraum zu verändern.

Dadurch ergeben sich zwei grundlegende Grenzen:

Ein Erzeugendensystem eines $n$-dimensionalen Vektorraums, das mehr als $n$ Vektoren enthält, ist notwendigerweise linear abhängig. Umgekehrt kann eine linear unabhängige Vektormenge in diesem Raum höchstens $n$ Elemente enthalten \\[71, 74, 82\\].

Basis und Dimension verbinden damit drei zunächst getrennte Fragen:

-   Welche Vektoren kann ich erzeugen?

-   Welche Vektoren sind dafür wirklich erforderlich?

-   Wie viele unabhängige Richtungen besitzt der betrachtete Raum?

## Wissenschaftliche Einordnung

Die lineare Unabhängigkeit ermöglicht mir, Redundanz innerhalb einer mathematischen Zustandsbeschreibung eindeutig zu erkennen. Zwei formal verschiedene Vektoren liefern nicht zwangsläufig zwei unabhängige Informationen. Ist einer aus dem anderen oder aus mehreren anderen Vektoren erzeugbar, erweitert er den Spannraum nicht.

Eine Basis liefert deshalb eine minimale und zugleich vollständige Beschreibung eines endlichdimensionalen Vektorraums. Ihre Vektoren reichen aus, um jedes Element des Raums darzustellen, ohne dass einer dieser Vektoren für die Erzeugung des Raums entbehrlich wäre.

Die Dimension abstrahiert noch einen Schritt weiter. Sie hängt nicht von der konkreten Wahl der Basis ab, sondern beschreibt eine Eigenschaft des Vektorraums selbst. Unterschiedliche Basen können aus völlig verschiedenen Vektoren bestehen und dennoch dieselbe Anzahl von Elementen besitzen.

Für das FRZK ist diese Trennung wesentlich. Wenn ich später funktionale Zustände durch mehrere Komponenten beschreibe, kann ich nicht allein aus der Anzahl verwendeter Größen auf die tatsächliche Dimension des Zustandsraums schließen. Zunächst muss gezeigt werden, dass die verwendeten Richtungen tatsächlich linear unabhängig sind und gemeinsam den vorgesehenen Raum erzeugen.

## Methodologische Betrachtungen

Methodologisch liefert mir der Basisbegriff ein wichtiges Kriterium gegen unnötige Modellkomplexität. Eine zusätzliche mathematische Größe erhöht die Dimension eines Modells nicht automatisch. Wenn sie aus bereits vorhandenen Größen linear erzeugt werden kann, ist sie innerhalb der betrachteten linearen Struktur redundant.

Umgekehrt darf ich eine geringe Anzahl von Modellgrößen nicht allein deshalb als ausreichend betrachten, weil sich mit ihnen viele Zustände formulieren lassen. Entscheidend ist, ob ihr Spannraum tatsächlich den vollständigen vorgesehenen Zustandsraum erfasst.

Damit muss ich bei jeder späteren Wahl funktionaler Basisgrößen zwei voneinander unabhängige Nachweise führen:

1.  Die Größen müssen den benötigten Zustandsraum erzeugen.

2.  Sie müssen untereinander linear unabhängig sein.

Erst dann kann ich sie mathematisch als Basis auffassen.

Auch die Dimension darf nicht nachträglich aus einer gewünschten Anzahl von Modellvariablen festgelegt werden. Sie ergibt sich aus der Struktur des tatsächlich definierten Vektorraums. Wenn das FRZK später eine bestimmte Dimension erhält, muss diese aus der Konstruktion des Zustandsraums hervorgehen und darf nicht lediglich als bequeme Zahl vorausgesetzt werden.

## Didaktische Betrachtungen

Für mich lässt sich der Zusammenhang besonders einfach durch die Frage nach überflüssigen Richtungen verstehen.

Beginne ich mit einem Erzeugendensystem, kann ich nacheinander prüfen, ob einzelne Vektoren durch die übrigen Vektoren dargestellt werden können. Ist dies möglich, entferne ich den betreffenden Vektor. Der Spannraum bleibt dabei unverändert.

Ich wiederhole diesen Vorgang so lange, bis kein Vektor mehr entfernt werden kann, ohne den erzeugten Raum zu verkleinern. Das verbleibende System ist linear unabhängig und erzeugt weiterhin den gesamten Raum. Damit habe ich eine Basis erhalten.

Der Zusammenhang lässt sich daher als begriffliche Entwicklung zusammenfassen:\\
$$\\text{Linearkombination} \\longrightarrow \\text{Spannraum} \\longrightarrow \\text{Erzeugendensystem} \\longrightarrow \\text{lineare Unabhängigkeit} \\longrightarrow \\text{Basis} \\longrightarrow \\text{Dimension}.$$

Diese Darstellung dient der Übersicht und wird nicht als eigenständige Gleichung nummeriert.

Ebenso wichtig ist für mich die Trennung zwischen Vektor und Koordinatenvektor. Ein Wechsel der Basis verändert die Zahlen, mit denen ein Vektor beschrieben wird, nicht aber den Vektor selbst. Dadurch entsteht unmittelbar die nächste Frage: Wie lassen sich die Koordinaten desselben Vektors systematisch von einer Basis in eine andere überführen?

## Ergebnis und Übergang

Mit linearer Unabhängigkeit, Basis und Dimension kann ich nun bestimmen, welche Vektoren innerhalb eines Erzeugungssystems redundant sind, welche minimale Vektormenge den gesamten Raum beschreibt und wie viele unabhängige Richtungen dieser Raum besitzt.

Jeder Vektor eines endlichdimensionalen Vektorraums kann bezüglich einer Basis eindeutig durch Koordinaten dargestellt werden. Diese Koordinaten sind jedoch von der gewählten Basis abhängig.

Damit ist die Grundlage für den nächsten Schritt gelegt. In **3.2.7 Basiswechsel und Koordinatentransformationen** untersuche ich, wie sich die Koordinaten eines unveränderten Vektors beim Wechsel der Basis verändern und wie die zugehörigen Transformationsmatrizen konstruiert werden.

Du meinst im unmittelbaren Fortgang **3.2.7**. Ich gebe den Abschnitt jetzt vollständig direkt im Chat aus. Die Regel ist gespeichert: Abschnittsausgaben erfolgen grundsätzlich vollständig im Chat.
```

### Quellabschnitt 3.2.7 – Basiswechsel und Koordinatentransformationen

- `section_id`: `29`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `871fe5ed6019807ce8286589b7ec1aac3b880e9c669244a761f0e10b14a3cc1a`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.7 Basiswechsel und Koordinatentransformationen

Mit einer Basis kann ich jeden Vektor eines endlichdimensionalen Vektorraums eindeutig durch Koordinaten beschreiben. Diese Koordinaten gehören jedoch nicht zum Vektor selbst. Sie entstehen erst dadurch, dass ich eine bestimmte Basis für seine Darstellung auswähle. Wähle ich eine andere Basis desselben Vektorraums, können sich sämtliche Koordinaten ändern, obwohl der mathematische Vektor unverändert bleibt \\[71, 74, 82\\].

Diese Unterscheidung zwischen einem mathematischen Objekt und seiner Darstellung ist für meine weitere Entwicklung grundlegend. Der Vektorraum und seine Elemente existieren innerhalb der mathematischen Struktur unabhängig davon, mit welchen Koordinaten ich sie beschreibe. Eine Basis stellt deshalb zunächst ein Bezugssystem für die Darstellung bereit. Ein Basiswechsel verändert dieses Bezugssystem, nicht aber den dargestellten Vektor.

Dasselbe gilt für lineare Operatoren. Ein Operator ist als Abbildung zwischen Vektoren definiert. Seine Matrixdarstellung hängt dagegen von der verwendeten Basis ab. Damit muss ich bei jeder späteren mathematischen Beschreibung sorgfältig zwischen einer Struktur und ihrer konkreten Darstellung unterscheiden \\[71, 74, 82\\].

Für das Funktionale Raum-Zeit-Kohärenzsystem ist diese Trennung besonders wichtig. Wenn ich funktionale Zustände später als abstrakte mathematische Objekte beschreibe, dürfen ihre grundlegenden Eigenschaften nicht davon abhängen, welche Koordinatendarstellung ich für eine Berechnung wähle. Die Basis soll die mathematische Beschreibung ermöglichen, aber nicht den beschriebenen Zustand selbst erzeugen.

## Darstellung eines Vektors bezüglich einer Basis

Sei $B = \\left( b_{1},\\ldots,b_{n} \\right)$ eine Basis eines endlichdimensionalen Vektorraums $V$. Für jeden Vektor $v \\in V$ existieren eindeutig bestimmte Skalare $\\lambda_{1},\\ldots,\\lambda_{n}$, sodass

$$v = \\sum_{i = 1}^{n}{\\lambda_{i}b_{i}}\\ (3.86)$$

Dabei gilt:

-   $B$ ist die gewählte Basis,

-   $b_{1},\\ldots,b_{n}$ sind ihre Basisvektoren,

-   $v$ ist der dargestellte Vektor,

-   $\\lambda_{1},\\ldots,\\lambda_{n}$ sind seine Koordinaten bezüglich $B$.

Die Eindeutigkeit dieser Skalare folgt aus der linearen Unabhängigkeit der Basisvektoren \\[71, 74, 82\\].

Die Koordinaten fasse ich zum Koordinatenvektor zusammen:

$$\\lbrack v\\rbrack_{B} = \\begin{pmatrix}
\\lambda_{1} \\\\
\\lambda_{2} \\\\
 \\vdots \\\\
\\lambda_{n}
\\end{pmatrix}\\ (3.87)$$

Der Ausdruck $\\lbrack v\\rbrack_{B}$ bezeichnet damit ausdrücklich nicht den Vektor $v$ selbst, sondern seine Darstellung bezüglich der Basis $B$.

Diese Unterscheidung ist mathematisch wesentlich. Derselbe abstrakte Vektor kann durch unterschiedliche Zahlenfolgen beschrieben werden, wenn ich unterschiedliche Basen verwende.

## Zwei verschiedene Basen

Ich betrachte nun zwei Basen desselben $n$-dimensionalen Vektorraums,\\
$$B = \\left( b_{1},\\ldots,b_{n} \\right)\\quad\\quad\\text{und}\\quad\\quad C = \\left( c_{1},\\ldots,c_{n} \\right).$$

Diese Angaben legen lediglich die beiden verwendeten Basen fest und erhalten deshalb keine eigenen Gleichungsnummern.

Derselbe Vektor $v \\in V$ besitzt bezüglich dieser Basen zwei Koordinatendarstellungen. Ich fasse sie gemeinsam zusammen:

$$\\lbrack v\\rbrack_{B} = \\begin{pmatrix}
\\lambda_{1} \\\\
 \\vdots \\\\
\\lambda_{n}
\\end{pmatrix},\\quad\\quad\\lbrack v\\rbrack_{C} = \\begin{pmatrix}
\\mu_{1} \\\\
 \\vdots \\\\
\\mu_{n}
\\end{pmatrix}\\ (3.88)$$

Die Zahlen $\\lambda_{i}$ und $\\mu_{i}$ können voneinander verschieden sein. Trotzdem beschreiben beide Koordinatenvektoren denselben Vektor $v$ \\[71, 82\\].

Ich muss deshalb unterscheiden zwischen einer Veränderung des mathematischen Vektors und einer Veränderung seiner Koordinatendarstellung. Ein Basiswechsel bewirkt ausschließlich den zweiten Fall.

## Basiswechselmatrix

Zwischen den Koordinaten bezüglich zweier Basen existiert eine eindeutig bestimmte invertierbare lineare Transformation \\[71, 74, 82\\].

Ich bezeichne mit $P_{B \\rightarrow C}$ die Matrix, welche Koordinaten bezüglich $B$ in Koordinaten bezüglich $C$ überführt. Das Symbol selbst stellt lediglich die Bezeichnung dieser Matrix dar und erhält keine eigene Gleichungsnummer.

Die eigentliche Koordinatentransformation lautet

$$\\lbrack v\\rbrack_{C} = P_{B \\rightarrow C}\\lbrack v\\rbrack_{B}\\ (3.89)$$

Dabei gilt:

-   $\\lbrack v\\rbrack_{B}$ ist die Koordinatendarstellung vor dem Basiswechsel,

-   $\\lbrack v\\rbrack_{C}$ ist die Koordinatendarstellung nach dem Basiswechsel,

-   $P_{B \\rightarrow C}$ ist die zugehörige Basiswechselmatrix.

Die Matrix $P_{B \\rightarrow C}$ wirkt also auf den Koordinatenvektor und nicht auf den abstrakten Vektor $v$ selbst.

Da sowohl $B$ als auch $C$ Basen desselben Vektorraums sind, ist die Basiswechselmatrix invertierbar. Hin- und Rücktransformation fasse ich deshalb gemeinsam zusammen:

$$\\begin{matrix}
P_{C \\rightarrow B} = P_{B \\rightarrow C}^{- 1} \\\\
\\lbrack v\\rbrack_{B} = P_{C \\rightarrow B}\\lbrack v\\rbrack_{C}.
\\end{matrix}\\ (3.90)$$

Damit kann ich jede Koordinatentransformation eindeutig rückgängig machen \\[71, 74, 82\\].

Der Basiswechsel enthält deshalb keinen Informationsverlust. Ich ändere lediglich die Darstellung desselben mathematischen Objekts.

## Konstruktion einer Basiswechselmatrix

Die Basiswechselmatrix kann aus den Koordinaten der Basisvektoren konstruiert werden.

Will ich beispielsweise Koordinaten bezüglich einer Basis $C$ in Koordinaten bezüglich einer Basis $B$ überführen, stelle ich jeden Basisvektor von $C$ bezüglich $B$ dar:\\
$$\\mathbf{c}_{\\mathbf{j}\\sum_{\\mathbf{i = 1}}^{\\mathbf{n}}\\mathbf{p}_{\\mathbf{ij}}}\\mathbf{b}_{\\mathbf{i}}\\mathbf{.}$$

Diese Beziehung dient hier der Konstruktion und benötigt keine zusätzliche Gleichungsnummer.

Die zugehörigen Koordinatenvektoren $\\left\\lbrack c_{j} \\right\\rbrack_{B}$ bilden die Spalten der Basiswechselmatrix. Damit gilt

$$P_{C \\rightarrow B} = \\begin{pmatrix}
\\left\\lbrack c_{1} \\right\\rbrack_{B} & \\left\\lbrack c_{2} \\right\\rbrack_{B} & \\cdots & \\left\\lbrack c_{n} \\right\\rbrack_{B}
\\end{pmatrix}\\ (3.91)$$

Damit besitzt jede Spalte der Matrix eine unmittelbar nachvollziehbare Bedeutung: Sie beschreibt einen Basisvektor der Basis $C$ in den Koordinaten der Basis $B$ \\[71, 74, 82\\].

## Beispiel eines Basiswechsels

Ich betrachte den zweidimensionalen Raum $\\mathbb{R}^{2}$. Als erste Basis verwende ich die Standardbasis\\
$$B = \\left( \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix},\\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} \\right).$$

Als zweite Basis wähle ich\\
$$C = \\left( \\begin{pmatrix}
1 \\\\
1
\\end{pmatrix},\\begin{pmatrix}
1 \\\\
 - 1
\\end{pmatrix} \\right).$$

Beide Angaben legen lediglich die für das Beispiel verwendeten Basen fest. Da $B$ die Standardbasis ist, entsprechen die Koordinaten der beiden $C$-Basisvektoren bezüglich $B$ unmittelbar ihren Komponenten. Die Basiswechselmatrix von $C$ nach $B$ ist somit

$$P_{C \\rightarrow B} = \\begin{pmatrix}
1 & 1 \\\\
1 & - 1
\\end{pmatrix}\\ (3.92)$$

Die beiden Spalten sind genau die Koordinatendarstellungen der beiden $C$-Basisvektoren bezüglich der Basis $B$.

Die inverse Matrix liefert die Koordinatentransformation in Gegenrichtung:

$$P_{B \\rightarrow C} = P_{C \\rightarrow B}^{- 1} = \\frac{1}{2}\\begin{pmatrix}
1 & 1 \\\\
1 & - 1
\\end{pmatrix}\\ (3.93)$$

Damit kann ich einen beliebigen Koordinatenvektor eindeutig zwischen beiden Basen umrechnen.

## Darstellung linearer Operatoren

Die Basisabhängigkeit betrifft nicht nur Vektorkoordinaten, sondern auch die Matrixdarstellung linearer Operatoren.

Sei $T:V \\rightarrow V$ ein linearer Operator. Ich bezeichne seine Matrixdarstellung bezüglich der Basis $B$ mit $A_{B}$ und bezüglich der Basis $C$ mit $A_{C}$.

Die Bezeichnungen $T:V \\rightarrow V$, $A_{B}$ und $A_{C}$ sind Voraussetzungen beziehungsweise verwendete Größen und erhalten deshalb keine eigenen Gleichungsnummern.

Zwischen beiden Matrixdarstellungen gilt

$$A_{C} = P_{B \\rightarrow C}A_{B}P_{C \\rightarrow B}\\ (3.94)$$

Mit\\
$$P_{C \\rightarrow B} = P_{B \\rightarrow C}^{- 1}$$

kann ich dieselbe Beziehung auch schreiben als\\
$$A_{C} = P_{B \\rightarrow C}A_{B}P_{B \\rightarrow C}^{- 1}.$$

Diese zweite Darstellung ist keine neue mathematische Aussage und erhält deshalb keine eigene Gleichungsnummer.

Gleichung (3.94) ist eine Ähnlichkeitstransformation. Die Matrizen $A_{B}$ und $A_{C}$ können unterschiedliche Einträge besitzen, stellen aber denselben linearen Operator bezüglich unterschiedlicher Basen dar \\[71, 74, 82\\].

Damit wird die Unterscheidung zwischen Operator und Matrixdarstellung besonders deutlich. Der Operator beschreibt die mathematische Wirkung. Die Matrix beschreibt diese Wirkung bezüglich einer bestimmten Basis.

## Invariante Eigenschaften

Wenn zwei Matrizen denselben linearen Operator in unterschiedlichen Basen darstellen, ändern sich zwar ihre einzelnen Matrixelemente, bestimmte strukturelle Eigenschaften bleiben jedoch erhalten.

Zu diesen unter Ähnlichkeit erhaltenen Eigenschaften gehören insbesondere Rang, Determinante, Spur, charakteristisches Polynom, Eigenwerte und Spektrum \\[71, 74, 82\\].

Die Dimension gehört dagegen unmittelbar zum zugrunde liegenden Vektorraum und ist daher unabhängig von der Basiswahl.

Für die Determinante gilt beispielsweise

$$\\det\\left( A_{C} \\right) = \\det\\left( A_{B} \\right)\\ (3.95)$$

Die Gleichheit folgt aus der Multiplikativität der Determinante und der Invertierbarkeit der Basiswechselmatrix.

Aus Gleichung (3.94) folgt\\
$$\\det\\left( A_{C} \\right) = \\det\\left( P_{B \\rightarrow C} \\right)\\det\\left( A_{B} \\right)\\det\\left( P_{B \\rightarrow C}^{- 1} \\right).$$

Da

$$\\mathbf{de}\\mathbf{t}{\\left( \\mathbf{P}_{\\mathbf{B \\rightarrow C}}^{\\mathbf{- 1}} \\right)\\mathbf{=}}\\frac{\\mathbf{1}}{\\mathbf{de}\\mathbf{t}\\left( \\mathbf{P}_{\\mathbf{B \\rightarrow C}} \\right)}\\mathbf{,}
$$heben sich die beiden Faktoren gegenseitig auf. Diese Rechenschritte bilden eine Herleitung von Gleichung (3.95) und erhalten deshalb keine eigenen Gleichungsnummern.

Ebenso bleibt das Spektrum erhalten:

$$\\sigma\\left( A_{B} \\right) = \\sigma\\left( A_{C} \\right)\\ (3.96)$$

Dabei bezeichnet $\\sigma(A)$ das Spektrum der Matrix beziehungsweise des dargestellten Operators \\[71, 76, 82\\].

Damit kann eine Größe basisabhängig dargestellt sein, während bestimmte Eigenschaften der durch sie beschriebenen mathematischen Struktur basisunabhängig bleiben.

## Darstellung und mathematisches Objekt

Der Basiswechsel macht für mich einen grundlegenden Unterschied sichtbar: Ein mathematisches Objekt ist nicht mit seinen Koordinaten identisch.

Ein Vektor $v$ bleibt derselbe Vektor, wenn ich von $\\lbrack v\\rbrack_{B}$ zu $\\lbrack v\\rbrack_{C}$ wechsle. Ebenso bleibt ein Operator $T$ derselbe Operator, obwohl seine Matrixdarstellung von $A_{B}$ zu $A_{C}$ wechseln kann.

Damit hängt eine mathematische Aussage über ein abstraktes Objekt nicht von einer bestimmten Koordinatenwahl ab, sofern die Aussage tatsächlich eine intrinsische Eigenschaft dieses Objekts beschreibt \\[71, 74, 82\\].

Eine einzelne Matrixkomponente besitzt dagegen im Allgemeinen keine solche Invarianz. Sie kann sich bereits durch die Wahl einer anderen Basis verändern.

Ich muss deshalb unterscheiden zwischen Eigenschaften des Zustands, Eigenschaften seiner Koordinatendarstellung, Eigenschaften eines Operators und Eigenschaften seiner Matrixdarstellung. Diese Ebenen dürfen nicht miteinander verwechselt werden.

## Wissenschaftliche Einordnung

Der Basiswechsel ermöglicht es mir, verschiedene mathematische Darstellungen desselben Zustands miteinander zu verbinden. Die Koordinatentransformation verändert weder den Vektorraum noch den Vektor. Sie verändert ausschließlich die Zahlen, durch die ich diesen Vektor bezüglich einer Basis beschreibe.

Dasselbe Prinzip gilt für lineare Operatoren. Ihre Matrixdarstellung kann sich bei einem Basiswechsel erheblich verändern. Dennoch bleiben mathematisch invariante Eigenschaften des Operators erhalten.

Diese Unterscheidung ist für die weitere Konstruktion des FRZK wesentlich. Wenn ein funktionaler Zustand später durch einen Vektor beschrieben wird, darf ich seine mathematische Existenz nicht mit einer bestimmten Koordinatenliste identifizieren. Eine konkrete Koordinatendarstellung ist eine Beschreibung dieses Zustands unter einer gewählten Basis.

Damit kann ich unterschiedliche Darstellungen desselben funktionalen Zustands zulassen, ohne dadurch verschiedene Zustände postulieren zu müssen.

Gleichzeitig entsteht ein wichtiges Prüfkriterium: Eigenschaften, die als grundlegende Eigenschaften eines funktionalen Zustands verstanden werden sollen, müssen daraufhin untersucht werden, ob sie bei zulässigen Darstellungswechseln erhalten bleiben. Eine Größe, die sich ausschließlich durch einen Basiswechsel verändert, beschreibt zunächst eine Eigenschaft der Darstellung und nicht ohne Weiteres eine intrinsische Eigenschaft des Zustands.

## Methodologische Betrachtungen

Methodologisch zwingt mich der Basiswechsel zu einer konsequenten Trennung zwischen Struktur und Darstellung.

Wenn ich einen Vektor durch $\\lbrack v\\rbrack_{B}$ darstelle, habe ich bereits eine Basis gewählt. Die daraus entstehenden Koordinaten sind deshalb nicht voraussetzungslos. Sie hängen von meiner Darstellungsentscheidung ab.

Das bedeutet auch, dass die numerischen Werte einzelner Komponenten nicht ohne Angabe ihrer Basis vollständig interpretiert werden können. Derselbe mathematische Zustand kann in einer anderen Basis andere Komponenten besitzen.

Für das FRZK folgt daraus, dass eine spätere funktionale Zustandsgröße nicht allein deshalb fundamental sein kann, weil sie als einzelne Koordinate in einer bestimmten Darstellung auftritt. Ich muss unterscheiden, ob die betreffende Größe tatsächlich eine basisunabhängige Eigenschaft beschreibt oder lediglich Bestandteil einer gewählten Koordinatendarstellung ist.

Gleichzeitig darf ich Basisunabhängigkeit nicht mit vollständiger Unabhängigkeit von mathematischen Voraussetzungen gleichsetzen. Auch ein abstrakter Vektor ist innerhalb eines definierten Vektorraums bestimmt. Der Basiswechsel beseitigt also nicht die zugrunde liegende mathematische Struktur. Er zeigt lediglich, welche Teile der Beschreibung von der gewählten Darstellung abhängen.

## Didaktische Betrachtungen

Für mich lässt sich ein Basiswechsel am einfachsten verstehen, wenn ich Vektor und Koordinaten zunächst bewusst voneinander trenne.

Ich beginne mit einem festen Vektor $v$. Danach wähle ich eine Basis $B$ und bestimme $\\lbrack v\\rbrack_{B}$. Anschließend wähle ich eine zweite Basis $C$ und bestimme $\\lbrack v\\rbrack_{C}$.

Damit habe ich nicht zwei Vektoren erzeugt. Ich habe einen Vektor auf zwei verschiedene Arten beschrieben.

Die Basiswechselmatrix beantwortet anschließend genau die Frage, wie ich die Koordinaten umrechnen muss, damit beide Darstellungen weiterhin denselben Vektor beschreiben.

Der Zusammenhang lässt sich übersichtlich schreiben als\\
$$\\lbrack v\\rbrack_{B}; \\longleftrightarrow ;v; \\longleftrightarrow ;\\lbrack v\\rbrack_{C}.$$

Diese Darstellung dient ausschließlich der begrifflichen Veranschaulichung und erhält keine Gleichungsnummer.

Dasselbe Bild kann ich auf Operatoren übertragen:\\
$$A_{B}; \\longleftrightarrow ;T; \\longleftrightarrow ;A_{C}.$$

Auch hier stehen links und rechts unterschiedliche Darstellungen, während in der Mitte dasselbe mathematische Objekt steht.

Dadurch wird verständlich, warum die Matrixelemente basisabhängig sein können, während beispielsweise Eigenwerte oder Determinante unter einer Ähnlichkeitstransformation erhalten bleiben.

## Ergebnis und Übergang

Mit dem Basiswechsel kann ich Koordinaten desselben Vektors zwischen unterschiedlichen Basen transformieren. Die Basiswechselmatrix ist invertierbar und ermöglicht deshalb eine eindeutige Hin- und Rücktransformation.

Für lineare Operatoren führt derselbe Zusammenhang zur Ähnlichkeitstransformation ihrer Matrixdarstellungen. Dabei ändern sich die konkreten Matrixelemente, während wesentliche strukturelle Eigenschaften erhalten bleiben.

Damit habe ich die mathematische Trennung zwischen abstraktem Objekt und konkreter Darstellung weiter präzisiert. Im nächsten Schritt untersuche ich eine dieser invarianten Größen genauer. Die Determinante liefert eine skalare Kennzahl dafür, wie eine lineare Transformation Orientierung und Volumen verändert und ob die Transformation invertierbar sein kann.

Der folgende Abschnitt behandelt deshalb **3.2.8 Determinanten, Orientierung und Volumenänderung**.

**Fortsetzungsstand:** Die letzte Gleichung ist **(3.96)**. Abschnitt **3.2.8 beginnt mit (3.97)**.
```

### Quellabschnitt 3.2.8 – Determinanten, Orientierung und Volumenänderung

- `section_id`: `30`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `c086ae2917eb97361058b9cb6d676897d90b1e57a6514e29b6974d3beab1dedb`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.8 Determinanten, Orientierung und Volumenänderung

Nachdem ich lineare Operatoren durch Matrizen beschrieben und die Abhängigkeit ihrer Matrixdarstellung von der gewählten Basis untersucht habe, benötige ich nun eine Größe, mit der ich die geometrische Wirkung einer linearen Transformation quantitativ erfassen kann. Für quadratische Matrizen übernimmt die Determinante diese Funktion. Sie beschreibt gleichzeitig, ob eine lineare Transformation Flächen beziehungsweise Volumina vergrößert oder verkleinert, ob sie die Orientierung erhält oder umkehrt und ob durch die Transformation eine Dimension verloren geht \\[71, 74, 82\\].

Die Determinante ist damit nicht lediglich eine Rechenvorschrift für Matrixelemente. Sie ordnet einer quadratischen Matrix einen einzelnen Skalar zu, in dem mehrere strukturelle Eigenschaften der dargestellten linearen Transformation zusammenlaufen. Da ähnliche Matrizen dieselbe Determinante besitzen, hängt diese Kennzahl nicht von der konkreten Basisdarstellung des Operators ab \\[71, 74, 82\\].

Für das Funktionale Raum-Zeit-Kohärenzsystem verwende ich die Determinante zunächst ausschließlich in dieser etablierten mathematischen Bedeutung. Eine spätere Interpretation als Maß einer funktionalen Zustandsraumveränderung oder einer Kohärenzänderung würde zusätzliche Modellannahmen voraussetzen. Eine solche Interpretation darf deshalb nicht aus der mathematischen Determinante selbst abgeleitet werden.

## Definition 3.2.15: Determinante einer quadratischen Matrix

Für eine quadratische reelle Matrix $A \\in \\mathbb{R}^{n \\times n}$ bezeichne ich die Determinante mit $\\det(A)$ beziehungsweise $|A|$. Formal fasse ich sie als Abbildung

$$\\det:\\mathbb{R}^{n \\times n} \\longrightarrow \\mathbb{R},\\quad\\quad A \\longmapsto \\det(A)\\ (3.97)$$

Dabei gilt:

-   $A$ ist eine quadratische $n \\times n$-Matrix,

-   $\\mathbb{R}^{n \\times n}$ ist der Raum der reellen quadratischen Matrizen der Ordnung $n$,

-   $\\det(A)$ ist der der Matrix eindeutig zugeordnete reelle Skalar,

-   $n$ bezeichnet die Dimension des zugrunde liegenden endlichdimensionalen Raumes.

Die Determinante ist ausschließlich für quadratische Matrizen definiert. Für nichtquadratische Matrizen kann ich deshalb nicht in derselben Weise von einer Determinante sprechen \\[71, 74, 82\\].

## Determinante einer $\\mathbf{2}\\mathbf{\\times}\\mathbf{2}$-Matrix

Für\\
$$A = \\begin{pmatrix}
a & b \\\\
c & d
\\end{pmatrix}$$

gilt

$$\\det(A) = ad - bc\\ (3.98)$$

Die Determinante ergibt sich hier aus der Differenz des Produkts der Hauptdiagonale und des Produkts der Nebendiagonale \\[71, 74\\].

Die Elemente $a,b,c,d$ sind lediglich die Komponenten der Matrix $A$ und werden deshalb nicht als eigene Gleichungen geführt.

Betrachte ich beispielsweise\\
$$A = \\begin{pmatrix}
2 & 0 \\\\
0 & 3
\\end{pmatrix},$$

so ergibt sich unmittelbar

$$\\det(A) = 2 \\cdot 3 - 0 \\cdot 0 = 6\\ (3.99)$$

Die durch diese Matrix dargestellte lineare Transformation vergrößert Flächeninhalte damit um den Faktor $6$ \\[74, 82\\]. Das entspricht unmittelbar der anschaulichen Wirkung der Matrix: Eine Richtung wird mit dem Faktor $2$, die andere mit dem Faktor $3$ skaliert. Der resultierende Flächenfaktor ist das Produkt beider Skalierungen.

## Determinante einer $\\mathbf{3}\\mathbf{\\times}\\mathbf{3}$-Matrix

Für\\
$$A = \\begin{pmatrix}
a_{11} & a_{11} & a_{11} \\\\
a_{21} & a_{22} & a_{23} \\\\
a_{31} & a_{32} & a_{33}
\\end{pmatrix}$$

kann ich die Determinante beispielsweise nach der ersten Zeile entwickeln:

$$\\det(A) = a_{11}\\left| \\begin{matrix}
a_{22} & a_{23} \\\\
a_{32} & a_{33}
\\end{matrix} \\right| - a_{12}\\left| \\begin{matrix}
a_{21} & a_{2311} \\\\
a_{31} & a_{33}
\\end{matrix} \\right| + a_{13}\\left| \\begin{matrix}
a_{1121} & a_{22} \\\\
a_{31} & a_{32}
\\end{matrix} \\right|\\ (3.100)$$

Diese Form entspricht der Laplace-Entwicklung nach der ersten Zeile. Grundsätzlich kann die Entwicklung nach jeder beliebigen Zeile oder Spalte erfolgen \\[71, 74, 82\\].

Die einzelnen Minoren sind Bestandteile der Determinantenberechnung und erhalten keine eigenen Gleichungsnummern.

## Geometrische Bedeutung

Die Determinante beschreibt den orientierten Skalierungsfaktor einer linearen Transformation. Ihr Betrag gibt an, wie stark Flächen oder Volumina durch die Transformation skaliert werden \\[71, 74, 82\\].

Sei $A \\in \\mathbb{R}^{n \\times n}$ und\\
$$T_{A}:\\mathbb{R}^{n} \\rightarrow \\mathbb{R}^{n},\\quad\\quad x \\mapsto Ax$$

die durch $A$ dargestellte lineare Transformation. Für eine geeignete messbare Teilmenge $M \\subseteq \\mathbb{R}^{n}$ gilt

$$vol(T_{A}(M)) = |\\ det(A)|\\, vol(M)\\ (3.101)$$

Dabei bezeichnet

-   $M$ die betrachtete Teilmenge,

-   $T_{A}(M)$ deren Bild unter der Transformation,

-   $\\text{vol}\\text{(}M)$ das $n$-dimensionale Volumen,

-   $\\left| \\det(A) \\right|$ den Volumenskalierungsfaktor.

Im zweidimensionalen Raum entspricht dieses Volumen dem Flächeninhalt. Im dreidimensionalen Raum entspricht es dem gewöhnlichen Volumen.

Daraus ergeben sich unmittelbar drei Fälle:

$$\\left\\{ \\begin{matrix}
|\\ det(A)| > 1 \\Rightarrow Vergrößerung \\\\
0 < |\\ det(A)| < 1 \\Rightarrow Verkleinerung \\\\
|\\ det(A)| = 1 \\Rightarrow Volumenerhaltung.
\\end{matrix} \\right.\\ \\ (3.102)$$

Diese drei Aussagen gehören sachlich zusammen und werden deshalb in einer einzigen Gleichung zusammengefasst.

## Orientierung

Der Betrag der Determinante beschreibt die Größenänderung. Das Vorzeichen enthält eine zusätzliche Information: Es zeigt an, ob die Orientierung einer linearen Transformation erhalten bleibt oder umgekehrt wird \\[71, 74, 82\\].

Dabei gilt

$$\\left\\{ \\begin{aligned}
det(A) > 0 & \\Rightarrow Orientierung\\ bleibt\\ erhalten \\\\
det(A) < 0 & \\Rightarrow "\\{ Orientierung\\ wird\\ umgekehrt.
\\end{aligned} \\right.\\ \\ (3.103)$$

Eine typische orientierungsumkehrende Transformation ist eine Spiegelung.

Für die Spiegelung an der $y$-Achse kann ich beispielsweise die Matrix\\
$$S = \\begin{pmatrix}
 - 1 & 0 \\\\
0 & 1
\\end{pmatrix}$$

verwenden. Für sie gilt

$$\\det(S) = - 1\\ (3.104)$$

Der Betrag der Determinante ist $1$. Flächeninhalte bleiben somit erhalten. Das negative Vorzeichen zeigt jedoch, dass die Orientierung umgekehrt wird \\[74, 82\\].

Damit muss ich Betrag und Vorzeichen der Determinante auseinanderhalten. Zwei Transformationen können denselben Flächenskalierungsfaktor besitzen und sich dennoch hinsichtlich ihrer Orientierung unterscheiden.

## Singuläre und reguläre Matrizen

Besonders wichtig ist der Fall einer verschwindenden Determinante. Für eine quadratische Matrix gilt die grundlegende Äquivalenz

$$\\det(A) = 0\\quad \\Longleftrightarrow \\quad A\\,\\text{ist singulär}\\quad \\Longleftrightarrow \\quad A^{- 1}\\,\\text{existiert nicht}\\ (3.105)$$

Entsprechend gilt bei einer regulären beziehungsweise invertierbaren Matrix\\
$$\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad A\\,\\text{ist invertierbar}.$$

Diese zweite Formulierung ist die Negation beziehungsweise Umkehrung derselben strukturellen Aussage und erhält deshalb keine weitere Gleichungsnummer.

Eine Determinante von null besitzt zugleich eine geometrische Bedeutung. Der $n$-dimensionale Raum wird durch die Transformation auf eine Struktur geringerer Dimension abgebildet. Im zweidimensionalen Fall kann eine Fläche beispielsweise auf eine Gerade zusammenfallen. Im dreidimensionalen Fall kann ein Volumen auf eine Ebene oder sogar eine Gerade reduziert werden \\[71, 74, 82\\].

Damit verschwindet das $n$-dimensionale Volumen vollständig.

## Beispiel einer singulären Transformation

Ich betrachte\\
$$A = \\begin{pmatrix}
1 & 2 \\\\
2 & 4
\\end{pmatrix}.$$

Die zweite Spalte ist das Doppelte der ersten Spalte. Die beiden Spalten sind also linear abhängig.

Für die Determinante ergibt sich

$$\\det(A) = 1 \\cdot 4 - 2 \\cdot 2 = 0\\ (3.106)$$

Die Transformation kann deshalb keine zweidimensionale Fläche auf eine andere zweidimensionale Fläche mit positivem Flächeninhalt abbilden. Sämtliche Bildvektoren liegen auf einer einzigen Geraden.

Hier treffen mehrere zuvor eingeführte Begriffe unmittelbar zusammen: lineare Abhängigkeit, fehlende Invertierbarkeit und verschwindende Determinante beschreiben unterschiedliche Aspekte derselben strukturellen Eigenschaft.

## Zusammenhang mit linearer Unabhängigkeit

Für eine quadratische Matrix\\
$$A = \\begin{pmatrix}
| & | & | \\\\
a_{1} & \\cdots & a_{n} \\\\
| & | & |
\\end{pmatrix}$$

mit Spaltenvektoren $a_{1},\\ldots,a_{n}$ sind mehrere Aussagen äquivalent:

$$\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad a_{1},\\ldots,a_{n}\\,\\text{sind linear unabhängig}\\quad \\Longleftrightarrow \\quad\\text{rank}(A) = n\\quad \\Longleftrightarrow \\quad A^{- 1}\\,\\text{existiert}\\ (3.107)$$

Diese Äquivalenz verbindet mehrere Betrachtungsebenen \\[71, 74, 82\\]:

-   geometrisch verschwindet kein $n$-dimensionales Volumen,

-   algebraisch bleiben die Spaltenvektoren unabhängig,

-   die Matrix besitzt vollen Rang,

-   die zugehörige Transformation ist invertierbar.

Damit ist die Determinante nicht nur eine geometrische Kennzahl, sondern zugleich ein Kriterium für die algebraische Regularität einer quadratischen Matrix. Die entsprechende Verbindung von Determinante, linearer Unabhängigkeit und Invertierbarkeit wird in der zugrunde liegenden mathematischen Darstellung ausdrücklich hervorgehoben.

## Multiplikativität der Determinante

Für zwei quadratische Matrizen $A,B \\in \\mathbb{R}^{n \\times n}$ gilt

$$\\det(AB) = \\det(A)\\det(B)\\ (3.108)$$

Damit multiplizieren sich auch die orientierten Volumenskalierungsfaktoren aufeinanderfolgender linearer Transformationen \\[71, 74, 82\\].

Wenn eine erste Transformation ein Volumen beispielsweise um den Faktor $2$ und eine zweite um den Faktor $3$ verändert, verändert ihre Verkettung das Volumen um den Faktor $6$.

Das Vorzeichen wird dabei ebenfalls multipliziert. Zwei orientierungsumkehrende Transformationen führen deshalb gemeinsam wieder zu einer orientierungserhaltenden Transformation.

## Determinante der inversen Matrix

Ist $A$ invertierbar, gilt\\
$$AA^{- 1} = I.$$

Da für die Einheitsmatrix $\\det(I) = 1$ gilt, folgt mit der Multiplikativität

$$\\det\\left( A^{- 1} \\right) = \\frac{1}{\\det(A)}\\ (3.109)$$

Die inverse Transformation hebt damit die Volumenskalierung der ursprünglichen Transformation exakt wieder auf \\[71, 74\\].

Hat eine Transformation beispielsweise den Skalierungsfaktor $4$, besitzt ihre inverse Transformation den Skalierungsfaktor $1\\text{/}4$.

Auch hier werden die Voraussetzungen und Zwischenschritte der Herleitung nicht als eigene Gleichungen nummeriert.

## Determinante und Basiswechsel

Die Matrixdarstellung eines linearen Operators hängt von der verwendeten Basis ab. Sei\\
$$\\mathbf{A}_{\\mathbf{C}}{\\mathbf{=}\\mathbf{P}}_{\\mathbf{B} \\rightarrow \\mathbf{C}}\\mathbf{A}_{\\mathbf{B}}\\mathbf{P}_{\\mathbf{B} \\rightarrow \\mathbf{C}}^{- \\mathbf{1}}$$

die Darstellung desselben Operators in zwei verschiedenen Basen.

Unter Anwendung der Multiplikativität der Determinante erhalte ich

$$\\begin{matrix}
det(A_{C})\\& = \\ det(P_{B \\rightarrow C}^{- 1}) \\\\
 = det(P_{B \\rightarrow C})\\ det(A_{B})\\ det(P_{B \\rightarrow C}^{- 1}) \\\\
 = det(A_{B})
\\end{matrix}\\ (3.110)$$

Der letzte Schritt folgt daraus, dass\\
$$det{\\left( P_{B \\rightarrow C}^{- 1} \\right) =}\\frac{1}{det\\left( P_{B \\rightarrow C} \\right)}.$$

Diese Beziehung ist Bestandteil der Herleitung von Gleichung (3.110) und erhält keine eigene Nummer.

Damit ist die Determinante zwar formal an einer Matrix berechenbar, ihr Wert ist bei Matrixdarstellungen desselben Operators unter einem Basiswechsel invariant \\[71, 74, 82\\].

Ich kann deshalb die Determinante als Eigenschaft des zugrunde liegenden linearen Operators auffassen und nicht lediglich als Eigenschaft einer zufällig gewählten Matrixdarstellung.

## Wissenschaftliche Einordnung

Die Determinante verbindet mehrere grundlegende Strukturen der linearen Algebra miteinander. Sie enthält eine geometrische, eine algebraische und eine operatorentheoretische Aussage zugleich.

Geometrisch beschreibt ihr Betrag die Skalierung von Flächen und Volumina. Ihr Vorzeichen erfasst die Orientierung. Algebraisch entscheidet eine verschwindende beziehungsweise nicht verschwindende Determinante über lineare Unabhängigkeit, vollen Rang und Invertierbarkeit. Über die Multiplikativität verbindet sie außerdem die Wirkung aufeinanderfolgender Transformationen.

Gerade diese Verbindung macht die Determinante für meine weitere mathematische Entwicklung wichtig. Ein einzelner Skalar enthält Informationen darüber, ob eine Transformation Raumdimension erhält, ob sie eine Umkehrung erlaubt und wie sie das Volumenelement verändert.

Dabei muss ich jedoch beachten, dass die Determinante ausschließlich für quadratische Matrizen definiert ist. Sie stellt deshalb kein allgemeines Maß für beliebige lineare Abbildungen zwischen Vektorräumen unterschiedlicher Dimension dar. Sobald Definitions- und Zielraum unterschiedliche Dimensionen besitzen, benötige ich allgemeinere Strukturbegriffe.

Für das FRZK bedeutet dies, dass ich die Determinante später nur dort verwenden darf, wo tatsächlich ein geeigneter endlichdimensionaler Operator eines Raumes in sich vorliegt. Eine funktionale Interpretation ihrer Größe oder ihres Vorzeichens müsste darüber hinaus eigens definiert und begründet werden.

## Methodologische Betrachtungen

Methodologisch zeigt die Determinante besonders deutlich, dass ein und dieselbe mathematische Größe verschiedene Interpretationsschichten besitzen kann.

Die algebraische Definition bestimmt zunächst einen Skalar. Aus den Eigenschaften dieses Skalars folgen anschließend geometrische Aussagen über Volumenskalierung und Orientierung sowie strukturelle Aussagen über Invertierbarkeit und lineare Unabhängigkeit.

Diese Ebenen darf ich nicht umkehren. Insbesondere darf ich nicht aus einer später gewünschten physikalischen Bedeutung eine veränderte mathematische Definition der Determinante ableiten.

Für meine weitere Modellbildung bedeutet das außerdem, dass eine Determinante von null nicht allgemein mit „keiner Wirkung" gleichgesetzt werden darf. Eine singuläre Transformation kann sehr wohl eine mathematische Wirkung besitzen. Sie verliert jedoch mindestens eine unabhängige Richtung und ist deshalb nicht vollständig invertierbar.

Ebenso bedeutet $|\\ det(A)| = 1$ nicht, dass die Transformation identisch ist. Eine Rotation, Spiegelung oder andere volumenbewahrende Transformation kann den Zustand erheblich verändern und dennoch denselben Volumenbetrag erhalten.

Ich muss daher drei Aussagen voneinander trennen:

-   Volumenerhaltung,

-   Orientierungserhaltung,

-   Identität der Transformation.

Sie sind mathematisch nicht gleichbedeutend.

Gerade diese Trennung ist für ein späteres funktionales Modell wichtig. Ein Operator kann eine globale Größe erhalten und gleichzeitig den Zustand innerhalb des Zustandsraums verändern.

## Didaktische Betrachtungen

Didaktisch lässt sich die Determinante für mich am anschaulichsten aus der Wirkung auf Basisvektoren verstehen.

Im zweidimensionalen Raum spannen zwei unabhängige Basisvektoren ein Parallelogramm auf. Der Betrag der Determinante beschreibt, wie sich dessen Fläche durch eine lineare Transformation verändert.

Ist\\
$$|\\ det(A)| = 2,$$

so besitzt das transformierte Parallelogramm die doppelte Fläche.

Ist\\
$$|\\ det(A)| = \\frac{1}{2},$$

so besitzt es die halbe Fläche.

Ist\\
$$\\det(A) = 0,$$

so besitzt das transformierte Parallelogramm überhaupt keinen zweidimensionalen Flächeninhalt mehr. Seine beiden Spannrichtungen sind linear abhängig geworden, sodass die Fläche auf eine Gerade zusammenfällt.

Diese Ausdrücke dienen hier lediglich der Veranschaulichung der drei Fälle und erhalten keine eigenen Gleichungsnummern.

Das Vorzeichen ergänzt diese geometrische Betrachtung. Ein negatives Vorzeichen bedeutet nicht, dass ein „negatives Volumen" im gewöhnlichen geometrischen Sinn entsteht. Es kennzeichnet vielmehr eine Umkehrung der Orientierung.

Damit kann ich mir die Determinante als Kombination zweier Informationen vorstellen:\\
$$\\det(A)\\quad \\longleftrightarrow \\quad\\text{Orientierung} + \\text{Volumenskalierung}..$$

Auch diese Darstellung dient ausschließlich der begrifflichen Übersicht und ist keine nummerierte Gleichung.

Besonders hilfreich ist für mich außerdem der Zusammenhang\\
$$\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad\\text{keine unabhängige Richtung geht vollständig verloren}.$$

Damit wird unmittelbar verständlich, warum eine nicht verschwindende Determinante mit Invertierbarkeit verbunden ist. Wenn keine Dimension verloren geht, kann die Transformation im endlichdimensionalen quadratischen Fall eindeutig zurückgeführt werden.

## Ergebnis und Übergang

Mit der Determinante kann ich nun die Wirkung einer quadratischen linearen Transformation in einem einzigen Skalar charakterisieren. Ihr Betrag beschreibt die Veränderung von Flächen beziehungsweise Volumina, ihr Vorzeichen die Orientierung und ihr Verschwinden den Verlust mindestens einer unabhängigen Raumrichtung.

Darüber hinaus verbindet die Determinante lineare Unabhängigkeit, vollen Rang und Invertierbarkeit. Ihre Multiplikativität beschreibt die Skalierungswirkung zusammengesetzter Transformationen, und ihre Invarianz unter Ähnlichkeit zeigt, dass sie nicht von einer speziellen Basisdarstellung des Operators abhängt. Diese Zusammenhänge bilden den Kern des Determinantenabschnitts.

Die Determinante besitzt jedoch eine wesentliche Einschränkung: Sie ist nur für quadratische Matrizen definiert. Für eine allgemeine lineare Abbildung benötige ich deshalb Begriffe, mit denen ich unabhängig von der Gleichheit der Dimensionen von Definitions- und Zielraum bestimmen kann, welche Zustände erreicht werden, welche Richtungen vollständig verschwinden und wie viele unabhängige Richtungen tatsächlich übertragen werden.

Der folgende Abschnitt behandelt daher **3.2.9 Rang, Kern und Bild linearer Abbildungen**.

**Fortsetzungsstand:** Abschnitt 3.2.8 endet mit Gleichung **(3.110)**. Abschnitt **3.2.9 beginnt mit (3.111)**.
```

### Quellabschnitt 3.2.9 – Rang, Kern und Bild linearer Abbildungen

- `section_id`: `31`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `d1ab99f8b90ac42b1439008160241b1b869aca04fedd7ab10517a026b6208c14`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.9 Rang, Kern und Bild linearer Abbildungen

Die Determinante liefert mir für quadratische Matrizen ein Kriterium dafür, ob eine lineare Transformation invertierbar ist. Lineare Abbildungen müssen jedoch weder durch quadratische Matrizen dargestellt werden noch zwischen Vektorräumen gleicher Dimension wirken. Für diese allgemeinere Situation benötige ich Begriffe, die unabhängig von der Quadratform einer Matrix beschreiben, welche Richtungen durch eine Abbildung erreicht werden, welche vollständig verschwinden und wie viele unabhängige Richtungen tatsächlich übertragen werden. Genau diese Aufgaben übernehmen Bild, Kern und Rang \\[71, 74, 82\\].

Der Rang gibt an, wie viele linear unabhängige Richtungen im Bild einer linearen Abbildung vorhanden sind. Der Kern enthält dagegen diejenigen Vektoren des Definitionsraums, die auf den Nullvektor des Zielraums abgebildet werden. Das Bild umfasst sämtliche Vektoren, die durch die Abbildung tatsächlich erreicht werden können. Zusammen ermöglichen mir diese drei Begriffe eine strukturelle Beschreibung linearer Abbildungen, die über die bloße Betrachtung einzelner Matrixelemente hinausgeht \\[71, 74, 82\\].

Für das Funktionale Raum-Zeit-Kohärenzsystem verwende ich diese Begriffe zunächst ausschließlich in ihrer etablierten mathematischen Bedeutung. Insbesondere darf ich einen nichttrivialen Kern noch nicht mit einem physikalischen oder funktionalen Informationsverlust gleichsetzen. Eine solche Interpretation setzt voraus, dass der betreffende Zustandsraum und die Bedeutung seiner Richtungen zuvor ausdrücklich definiert wurden.

## Definition 3.2.16: Bild einer linearen Abbildung

Seien $V$ und $W$ Vektorräume und $T:V \\rightarrow W$ eine lineare Abbildung.

Diese Angabe legt Definitions- und Zielraum sowie die verwendete Abbildung fest. Sie ist eine Voraussetzung der folgenden Definition und erhält deshalb keine eigene Gleichungsnummer.

Das Bild von $T$ definiere ich durch

$$\\text{Bild}(T) = \\left\\{ T(v) \\in W \\middle| v \\in V \\right\\}\\ (3.111)$$

Dabei bezeichnet

-   $T$ die lineare Abbildung,

-   $V$ ihren Definitionsraum,

-   $W$ ihren Zielraum,

-   $v$ einen Vektor aus $V$,

-   $T(v)$ den zugehörigen Bildvektor.

Das Bild enthält damit genau diejenigen Vektoren des Zielraums, die durch Anwendung von $T$ auf mindestens einen Vektor des Definitionsraums tatsächlich entstehen können \\[71, 74, 82\\].

Im Allgemeinen muss das Bild nicht mit dem gesamten Zielraum übereinstimmen. Es gilt lediglich$\\ \\text{Bild}(T) \\subseteq W.\\ $Diese Inklusion ist eine unmittelbare Eigenschaft der Definition und erhält keine eigene Gleichungsnummer.

Da $T$ linear ist, bildet $\\text{Bild}T$ selbst einen Untervektorraum von $W$. Sind zwei Vektoren $w_{1},w_{2} \\in \\text{Bild}T$, so existieren $v_{1},v_{2} \\in V$ mit $T\\left( v_{1} \\right) = w_{1}$ und $T\\left( v_{2} \\right) = w_{2}$. Für Skalare $\\lambda,\\mu$ folgt aus der Linearität

$$\\lambda w_{1} + \\mu w_{2} = T\\left( \\lambda v_{1} + \\mu v_{2} \\right) \\in \\text{Bild}(T).$$

Dieser Ausdruck gehört zur Begründung der Untervektorraumeigenschaft und wird nicht als zusätzliche Gleichung nummeriert.

Das Bild beschreibt damit den tatsächlich erreichbaren Teil des Zielraums.

## Definition 3.2.17: Kern einer linearen Abbildung

Der Kern derselben linearen Abbildung $T:V \\rightarrow W$ besteht aus allen Vektoren des Definitionsraums, die auf den Nullvektor des Zielraums abgebildet werden:

$$\\ker(T) = \\left\\{ v \\in V \\middle| T(v) = 0_{W} \\right\\}\\ (3.112)$$

Dabei ist $0_{W}$ der Nullvektor des Zielraums $W$.

Der Kern beantwortet damit eine andere Frage als das Bild. Beim Bild frage ich, welche Ausgangszustände erreichbar sind. Beim Kern frage ich, welche Eingangsvektoren durch die Abbildung vollständig auf denselben Nullvektor zusammengeführt werden \\[71, 74, 82\\].

Auch der Kern ist ein Untervektorraum, diesmal des Definitionsraums $V$. Für $v_{1},v_{2} \\in \\ker(T)$ und Skalare (\\\\lambda,\\\\mu) gilt nämlich\\
$$\\mathbf{T}\\left( \\mathbf{\\lambda}\\mathbf{v}_{\\mathbf{1}}\\mathbf{+}\\mathbf{\\mu}\\mathbf{v}_{\\mathbf{2}} \\right)\\mathbf{=}\\mathbf{\\lambda}\\mathbf{T}\\left( \\mathbf{v}_{\\mathbf{1}} \\right)\\mathbf{+}\\mathbf{\\mu}\\mathbf{T}\\left( \\mathbf{v}_{\\mathbf{2}} \\right)\\mathbf{0}_{\\mathbf{W}}\\mathbf{.}$$

Damit ist auch jede Linearkombination zweier Kernvektoren wieder ein Element des Kerns. Diese Herleitung erhält keine eigene Gleichungsnummer.

Der Nullvektor $0_{V}$ gehört immer zum Kern, weil jede lineare Abbildung den Nullvektor auf den Nullvektor abbildet.

Besitzt eine lineare Abbildung nur den trivialen Kern $\\ker(T) = 0_{V},$ so werden keine zwei verschiedenen Vektoren allein aufgrund einer nichttrivialen Kernrichtung miteinander identifiziert. Für lineare Abbildungen entspricht dies der Injektivität.

## Definition 3.2.18: Rang einer linearen Abbildung

Den Rang einer linearen Abbildung definiere ich als Dimension ihres Bildes:

$$\\text{rang}(T) = \\dim\\left( \\text{Bild}(T) \\right)\\ (3.113)$$

Der Rang gibt damit die Anzahl linear unabhängiger Richtungen an, die im Bildraum tatsächlich vorhanden sind \\[71, 74, 82\\].

Ist $A$ eine Darstellungsmatrix der linearen Abbildung, schreibe ich entsprechend $\\text{rang}A$. Diese Schreibweise bezeichnet denselben strukturellen Begriff auf der Ebene der Matrixdarstellung und benötigt keine zusätzliche Gleichungsnummer.

Der Rang darf dabei nicht mit der Anzahl der Spalten oder Zeilen einer Matrix verwechselt werden. Entscheidend ist nicht, wie viele Vektoren formal vorhanden sind, sondern wie viele davon linear unabhängig sind.

## Rang einer Matrix

Für eine Matrix $A \\in \\mathbb{R}^{m \\times n}$ spannen die Spaltenvektoren einen Unterraum von $\\mathbb{R}^{m}$ auf. Die Dimension dieses Spaltenraums ist der Rang der Matrix.

Ebenso kann ich den von den Zeilenvektoren aufgespannten Raum betrachten. Ein grundlegendes Ergebnis der linearen Algebra besagt, dass Zeilenrang und Spaltenrang übereinstimmen \\[71, 74\\].

Daher gilt

$$\\text{rang}(A) = \\dim\\left( \\text{Spaltenraum}(A) \\right) = \\dim\\left( \\text{Zeilenraum}(A) \\right)\\ (3.114)$$

Damit ist der Rang unabhängig davon, ob ich ihn über die linear unabhängigen Spalten oder über die linear unabhängigen Zeilen bestimme.

Für eine $m \\times n$-Matrix gilt allgemein\\
$$0 \\leq \\text{rang}(A) \\leq \\min(m,n).$$

Diese Abschätzung folgt unmittelbar aus den Dimensionen von Zeilen- und Spaltenraum und erhält keine eigene Gleichungsnummer.

## Beispiel

Ich betrachte die Matrix\\
$$A = \\begin{pmatrix}
1 & 2 \\\\
2 & 4
\\end{pmatrix}.$$

Die Matrixangabe selbst legt lediglich das Beispiel fest und erhält keine eigene Gleichungsnummer.

Die zweite Spalte ist das Doppelte der ersten:

$$\\begin{pmatrix}
2 \\\\
4
\\end{pmatrix} = 2\\begin{pmatrix}
1 \\\\
2
\\end{pmatrix}$$

Auch dieser Rechenschritt dient nur dem Nachweis der linearen Abhängigkeit und benötigt keine eigene Gleichungsnummer.

Damit existiert nur eine unabhängige Spaltenrichtung. Folglich gilt

$$\\text{rang}(A) = 1\\ (3.115)$$

Obwohl die Matrix zwei Spalten besitzt, enthält ihr Bild also nur eine linear unabhängige Richtung \\[74, 82\\].

Geometrisch bedeutet dies, dass die durch $A$ beschriebene Abbildung den zweidimensionalen Definitionsraum nicht auf einen zweidimensionalen Bildraum abbildet. Das Bild liegt vielmehr auf einer eindimensionalen Geraden.

## Voller Rang

Für eine Matrix $A \\in \\mathbb{R}^{m \\times n}$ ist der größtmögliche Rang durch $\\min(m,n)$ bestimmt.

Ich bezeichne eine Matrix als Matrix vollen Ranges, wenn

$$\\text{rang}(A) = \\min(m,n)\\ (3.116)$$

Für eine quadratische Matrix $A \\in \\mathbb{R}^{n \\times n}$ vereinfacht sich diese Bedingung zu $\\text{rang}(A) = n.$

Diese Form ist ein Spezialfall von Gleichung (3.116) und erhält keine eigene Nummer.

Für quadratische Matrizen ist voller Rang äquivalent zu einer nicht verschwindenden Determinante und damit zur Invertierbarkeit \\[71, 74, 82\\].

Es gilt also

$$\\text{rang}(A) = n\\quad \\Longleftrightarrow \\quad\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad A^{- 1}\\,\\text{existiert}\\ (3.117)$$

Damit beschreiben Rang, Determinante und Invertierbarkeit dieselbe Regularität einer quadratischen Matrix aus unterschiedlichen mathematischen Perspektiven.

## Rang-Nullitätssatz

Zwischen Bild und Kern besteht ein grundlegender Dimensionszusammenhang.

Sei $T:V \\rightarrow W$ eine lineare Abbildung mit endlichdimensionalem Definitionsraum $V$.

Dann gilt

$$\\dim(V) = \\dim\\left( \\ker(T) \\right) + \\text{rang}(T)\\ (3.118)$$

Diese Beziehung wird als **Dimensionssatz** oder **Rang-Nullitätssatz** bezeichnet \\[71, 74, 82\\].

Die Größe $dim!\\left( \\ker(T) \\right)$ wird auch als Nullität der linearen Abbildung bezeichnet.

Gleichung (3.118) zeigt, dass sich die Dimension des Definitionsraums in zwei Teile zerlegen lässt:

-   Richtungen, die im Kern liegen,

-   Richtungen, die unabhängig zum Bild beitragen.

Dabei muss ich die Formulierung „Richtungen gehen verloren" methodisch vorsichtig verwenden. Mathematisch bedeutet eine Kernrichtung zunächst nur, dass sie von $T$ auf (0_W) abgebildet wird. Ob dies in einer wissenschaftlichen Anwendung tatsächlich als Informationsverlust oder physikalischer Verlust zu deuten ist, hängt von der Interpretation des Modells ab.

## Beispiel zum Rang-Nullitätssatz

Für die bereits betrachtete lineare Abbildung mit

$$A = \\begin{pmatrix}
1 & 2 \\\\
2 & 4
\\end{pmatrix}.$$

gilt nach Gleichung (3.115) $\\text{rang}(A) = 1.$ Der Definitionsraum ist $\\mathbb{R}^{2}$ und besitzt daher Dimension $2$.

Setze ich diese Werte in den Rang-Nullitätssatz ein, erhalte ich

$$2 = \\dim\\left( \\ker(A) \\right) + 1\\quad \\Longrightarrow \\quad\\dim\\left( \\ker(A) \\right) = 1\\ (3.119)$$

Eine der beiden unabhängigen Richtungen des Definitionsraums trägt somit zum Bild bei, während eine unabhängige Richtung im Kern liegt \\[74, 82\\].

Für die konkrete Matrix kann ich den Kern auch direkt bestimmen. Aus

$$A\\begin{pmatrix}
x_{1} \\\\
x_{2}
\\end{pmatrix} = \\begin{pmatrix}
0 \\\\
0
\\end{pmatrix}$$

folgt die Bedingung\\
$$x_{1} + 2x_{2} = 0.$$

Damit kann ich beispielsweise $x_{2} = t$ setzen und erhalte $x_{1} = - 2t$. Der Kern wird somit von einem einzigen Vektor aufgespannt. Auch diese Rechnung bestätigt die Kerndimension $1$.

## Zusammenhang mit Injektivität und Surjektivität

Kern und Bild ermöglichen mir außerdem eine präzise Charakterisierung von Injektivität und Surjektivität.

Eine lineare Abbildung $T:V \\rightarrow W$ ist genau dann injektiv, wenn ihr Kern trivial ist:

$$T\\,\\text{injektiv}\\quad \\Longleftrightarrow \\quad\\ker(T) = \\text{\\{}0_{V}\\text{\\}}\\ (3.120)$$

Denn liegen zwei Vektoren $v_{1},v_{2}$ auf demselben Bildvektor, so gilt\\
$$T\\left( v_{1} \\right) = T\\left( v_{2} \\right)\\quad \\Longrightarrow \\backslash quadT\\left( v_{1} - v_{2} \\right) = 0_{W}.$$

Ist der Kern trivial, folgt daraus $v_{1} - v_{2} = 0_{V}$ und damit $v_{1} = v_{2}$.

Surjektivität wird dagegen durch das Bild charakterisiert:

$$T\\,\\text{surjektiv}\\quad \\Longleftrightarrow \\quad\\text{Bild}(T) = W\\ (3.121)$$

Damit sind Injektivität und Surjektivität unmittelbar mit Kern und Bild verbunden.

Für einen linearen Operator auf einem endlichdimensionalen Vektorraum gleicher Dimension fallen bei vollem Rang schließlich Injektivität, Surjektivität und Invertierbarkeit zusammen.

## Zusammenhang mit linearen Gleichungssystemen

Auch die Lösbarkeit linearer Gleichungssysteme kann ich mit Rang und Bild beschreiben.

Für $Ax = b$ existiert genau dann mindestens eine Lösung, wenn $b$ im Bild der durch $A$ dargestellten linearen Abbildung liegt:

$$Ax = b\\,\\text{ist lösbar}\\quad \\Longleftrightarrow \\quad b \\in \\text{Bild}(A)\\ (3.122)$$

Für die praktische Rangprüfung kann diese Bedingung mit der erweiterten Matrix $\\left( A \\middle| b \\right)$ formuliert werden:

$$Ax = b\\,\\text{ist lösbar}\\quad \\Longleftrightarrow \\quad\\text{rang}(A) = \\text{rang}\\left( A \\middle| b \\right)\\ (3.123)$$

Ist das System lösbar und besitzt $A$ vollen Spaltenrang, ist die Lösung eindeutig. Besitzt der Kern dagegen positive Dimension, können zu einer vorhandenen Lösung weitere Lösungen durch Addition von Kernvektoren erzeugt werden \\[71, 74\\]. Die Bedeutung des Rangs für lineare Gleichungssysteme ist damit unmittelbar mit Kern und Bild verknüpft.

Ist $x_{0}$ eine konkrete Lösung von $Ax = b$, dann besitzen sämtliche Lösungen die Form

$$x = x_{0} + z,\\quad\\quad z \\in \\ker(A)\\ (3.124)$$

Der Kern beschreibt damit genau die Freiheit, die nach Festlegung eines bestimmten Bildvektors $b$ innerhalb der Lösungsmenge verbleibt.

## Zusammenhang mit der Determinante

Für quadratische Matrizen kann ich die Beziehungen aus Rang, Kern und Determinante zu einer gemeinsamen Äquivalenz zusammenführen:

$$\\det(A) \\neq 0\\quad \\Longleftrightarrow \\quad\\text{rang}(A) = n\\quad \\Longleftrightarrow \\quad\\ker(A) = \\text{\\{}0\\text{\\}}\\quad \\Longleftrightarrow \\quad A\\,\\text{ist invertierbar}\\ (3.125)$$

Damit beschreiben vier Begriffe dieselbe strukturelle Eigenschaft aus unterschiedlichen Blickwinkeln \\[71, 74, 82\\].

Die Determinante liefert ein skalares Kriterium.

Der Rang beschreibt die Dimension des Bildes.

Der Kern zeigt, ob nichttriviale Richtungen auf null abgebildet werden.

Die Invertierbarkeit beschreibt, ob die Transformation eindeutig rückgängig gemacht werden kann.

Gerade diese Verbindung zeigt, warum Rang, Kern und Bild die Determinante nicht ersetzen, sondern deren Aussage auf allgemeinere lineare Abbildungen erweitern.

## Wissenschaftliche Einordnung

Mit Bild, Kern und Rang kann ich lineare Abbildungen unabhängig davon untersuchen, ob ihre Darstellungsmatrix quadratisch ist. Damit erhalte ich eine allgemeinere Beschreibung als mit der Determinante allein. Das Bild bestimmt den tatsächlich erreichbaren Teil des Zielraums, der Kern die auf den Nullvektor abgebildeten Richtungen und der Rang die Dimension des erreichbaren Unterraums \\[71, 74, 82\\].

Der Rang ist deshalb keine bloße Eigenschaft der Größe einer Matrix. Eine große Matrix kann einen sehr kleinen Rang besitzen, wenn ihre Zeilen oder Spalten stark voneinander abhängig sind. Umgekehrt kann eine kleinere Matrix ihren maximal möglichen Rang vollständig erreichen.

Für das FRZK ist diese Unterscheidung später von besonderer Bedeutung. Ein funktionaler Operator könnte formal auf einem hochdimensionalen Zustandsraum wirken und dennoch nur einen wesentlich kleineren effektiven Bildraum erzeugen. Ebenso könnten bestimmte Zustandsrichtungen im Kern liegen und damit unter dem betrachteten Operator denselben Nullzustand erzeugen.

Aus dieser mathematischen Möglichkeit folgt jedoch noch keine physikalische Aussage darüber, dass Information „vernichtet" wird. Ein nichttrivialer Kern ist zunächst eine Eigenschaft der Abbildung. Erst die spätere Interpretation der Vektoren und Operatoren entscheidet, welche wissenschaftliche Bedeutung diese Eigenschaft besitzt.

## Methodologische Betrachtungen

Methodologisch muss ich bei Rang, Kern und Bild besonders sorgfältig zwischen mathematischer Struktur und interpretativer Sprache unterscheiden.

Der Begriff des Bildes beschreibt mathematisch die Menge der erreichbaren Vektoren. Daraus darf ich nicht ohne zusätzliche Annahmen schließen, dass diese Vektoren physikalisch realisierbare Zustände darstellen. Der mathematische Zielraum und der physikalisch zulässige Zustandsraum müssen nicht identisch sein.

Ebenso bedeutet ein nichttrivialer Kern zunächst nur, dass verschiedene Vektoren unter derselben linearen Abbildung denselben Nullvektor erzeugen können. Daraus folgt mathematisch, dass die Abbildung nicht injektiv ist. Ob dies als Informationsverlust, Zustandsverlust oder Nichtbeobachtbarkeit interpretiert werden darf, muss für das jeweilige Modell gesondert begründet werden.

Auch der Rang verlangt eine präzise Interpretation. Ein Rang von $r$ bedeutet, dass das Bild $r$-dimensional ist. Er sagt nicht automatisch, dass genau $r$ physikalische Freiheitsgrade vorhanden sind. Dazu müsste zunächst gezeigt werden, dass die mathematischen Basisrichtungen tatsächlich unabhängigen physikalischen Freiheitsgraden entsprechen.

Für die spätere FRZK-Konstruktion ergibt sich damit ein klares methodisches Prüfschema: Bei jedem funktionalen Operator muss ich zunächst mathematisch bestimmen, welcher Definitionsraum vorausgesetzt wird, welcher Zielraum verwendet wird, wie sein Kern aussieht, welchen Bildraum er erzeugt und welchen Rang er besitzt. Erst anschließend darf eine funktionale Interpretation dieser Eigenschaften erfolgen.

## Didaktische Betrachtungen

Für mich lässt sich der Zusammenhang von Kern, Bild und Rang besonders einfach verstehen, wenn ich eine lineare Abbildung als Filter zwischen zwei Vektorräumen auffasse.

Am Eingang steht der Definitionsraum $V$.

Ein Teil seiner Richtungen kann durch die Abbildung so verändert werden, dass im Zielraum unabhängige Richtungen entstehen. Diese Richtungen bilden das Bild.

Andere Richtungen können auf den Nullvektor abgebildet werden. Diese liegen im Kern.

Der Rang zählt die unabhängigen Richtungen, die im Bild vorhanden sind.

Der Rang-Nullitätssatz verbindet beide Seiten:\\
$$\\underset{\\text{Ausgangsrichtungen}}{\\overset{\\mathbf{di}\\mathbf{m}\\left( \\mathbf{V} \\right)}{︸}}\\mathbf{=}\\underset{\\mathbf{Kernrichtungen}}{\\overset{\\mathbf{di}\\mathbf{m}\\left( \\mathbf{ke}\\mathbf{r}\\mathbf{T} \\right)}{︸}}\\mathbf{+}\\underset{\\text{Bildrichtungen}}{\\overset{\\mathbf{rang}\\left( \\mathbf{T} \\right)}{︸}}\\mathbf{.}$$

Diese Darstellung dient der didaktischen Veranschaulichung von Gleichung (3.118) und erhält keine zusätzliche Gleichungsnummer.

Für eine zweidimensionale Abbildung mit Rang $1$ kann ich mir die Situation daher so vorstellen: Von zwei unabhängigen Ausgangsrichtungen trägt eine unabhängige Richtung zum Bild bei, während eine unabhängige Richtung im Kern liegt.

Der Zusammenhang lässt sich ebenso als begriffliche Kette darstellen:\\
$$Definitionsraum \\longrightarrow \\left\\{ \\begin{array}{r}
Kern \\\\
Bild
\\end{array} \\right.\\  \\longrightarrow Rang.$$

Auch diese Übersicht ist keine eigenständige mathematische Gleichung.

Besonders wichtig ist für mich die folgende Unterscheidung:

**Die Anzahl der Matrixspalten ist nicht der Rang.**

Der Rang zählt nicht vorhandene Spalten, sondern unabhängige Richtungen. Genau dadurch wird er zu einer strukturellen Kennzahl.

## Ergebnis und Übergang

Mit Bild, Kern und Rang kann ich nun allgemeine lineare Abbildungen danach untersuchen, welche Teile des Zielraums sie tatsächlich erreichen, welche Richtungen des Definitionsraums auf den Nullvektor abgebildet werden und wie viele unabhängige Richtungen im Bild verbleiben.

Der Rang-Nullitätssatz verbindet diese Größen unmittelbar mit der Dimension des Definitionsraums. Für quadratische Matrizen fügt sich diese Beschreibung nahtlos in die bereits eingeführten Kriterien der Determinante und Invertierbarkeit ein. Für nichtquadratische Matrizen bleiben Rang, Kern und Bild dagegen auch dann definiert, wenn eine Determinante nicht zur Verfügung steht. Genau darin liegt ihre allgemeinere Bedeutung. Der fachliche Umfang von Bild, Kern, Rang, vollem Rang, Dimensionssatz, linearen Gleichungssystemen und Determinantenbezug entspricht dem für 3.2.9 vorgesehenen Aufbau.

Mit dem Rang weiß ich nun, wie viele unabhängige Richtungen eine lineare Abbildung tatsächlich erzeugt. Damit ist jedoch noch nicht beschrieben, ob einzelne Richtungen unter einem linearen Operator lediglich skaliert werden, ohne ihre Richtung zu verändern. Diese Frage führt unmittelbar zu Eigenwerten und Eigenvektoren.

Der folgende Abschnitt behandelt deshalb **3.2.10 Eigenwerte, Eigenvektoren und Eigenräume**.

**Fortsetzungsstand:** Abschnitt 3.2.9 endet mit Gleichung **(3.125)**. Abschnitt **3.2.10 beginnt mit (3.126)**.
```

### Quellabschnitt 3.2.10 – Eigenwerte, Eigenvektoren und Eigenräume

- `section_id`: `32`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `aece817ccd17b2e42495906556a3772a891c2ebe49023ff099525baad879f88b`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.10 Eigenwerte, Eigenvektoren und Eigenräume

Nachdem ich lineare Abbildungen über Bild, Kern und Rang danach beschrieben habe, welche Richtungen erhalten, erreicht oder vollständig auf den Nullvektor abgebildet werden, interessiert mich nun eine andere strukturelle Eigenschaft linearer Operatoren: Gibt es Richtungen, deren Orientierung unter der Transformation erhalten bleibt und die lediglich skaliert werden?

Genau diese Richtungen werden durch Eigenvektoren beschrieben. Der zugehörige Skalierungsfaktor ist der Eigenwert. Beide Begriffe gehören zu den zentralen Werkzeugen der linearen Algebra, weil sie komplexe lineare Transformationen auf besonders einfache Wirkungen entlang bestimmter Richtungen zurückführen \\[71, 74, 82\\].

Für das Funktionale Raum-Zeit-Kohärenzsystem ist diese Struktur später deshalb interessant, weil Eigenrichtungen mathematisch ausgezeichnete Richtungen eines Operators darstellen. Daraus darf ich allerdings noch keine physikalische Bedeutung ableiten. Ob eine Eigenrichtung beispielsweise einen bevorzugten funktionalen Zustand, einen stabilen Modus oder eine beobachtbare Struktur beschreibt, muss erst aus dem später definierten Modell folgen.

## Definition 3.2.19: Eigenwert und Eigenvektor

Sei $A \\in \\mathbb{R}^{n \\times n}$ eine quadratische Matrix.

Ein von null verschiedener Vektor $v \\in \\mathbb{R}^{n}$ heißt Eigenvektor von $A$, wenn ein Skalar $\\lambda \\in \\mathbb{R}$ existiert, sodass

$$Av = \\lambda v,\\quad\\quad v \\neq 0\\ (3.126)$$

Dabei bezeichnet

-   $A$ die betrachtete quadratische Matrix,

-   $v$ den Eigenvektor,

-   $\\lambda$ den zugehörigen Eigenwert.

Die Gleichung sagt aus, dass die Transformation $A$ den Eigenvektor nicht in eine neue unabhängige Richtung dreht. Sie verändert lediglich seine Länge und gegebenenfalls seine Orientierung \\[71, 74, 82\\].

Für $\\lambda > 0$ bleibt die Orientierung der Eigenrichtung erhalten. Für $\\lambda < 0$ wird sie umgekehrt. Für $\\lambda = 0$ wird der Eigenvektor auf den Nullvektor abgebildet.

Der Nullvektor selbst wird ausdrücklich nicht als Eigenvektor zugelassen, weil $A0 = 0$ für jede lineare Transformation gilt und damit keine ausgezeichnete Richtung charakterisieren würde.

## Umformung der Eigenwertgleichung

Aus Gleichung (3.126) folgt $Av - \\lambda v = 0.$

Da $\\lambda v = \\lambda Iv$ gilt, kann ich die Eigenwertgleichung schreiben als

$$(A - \\lambda I)v = 0\\ (3.127)$$

Dabei bezeichnet $I$ die Einheitsmatrix der Ordnung $n$.

Diese Darstellung zeigt unmittelbar, dass ein Eigenvektor ein nichttriviales Element des Kerns von $A - \\lambda I$ sein muss.

Es gilt also

$$v \\in \\ker(A - \\lambda I),\\quad\\quad v \\neq 0\\ (3.128)$$

Damit verbinde ich den Eigenwertbegriff unmittelbar mit dem zuvor eingeführten Kern einer linearen Abbildung.

## Charakteristische Gleichung

Damit Gleichung (3.127) eine nichttriviale Lösung besitzt, darf die Matrix $A - \\lambda I$ nicht invertierbar sein.

Für quadratische Matrizen ist dies äquivalent zu einer verschwindenden Determinante:

$$\\det(A - \\lambda I) = 0\\ (3.129)$$

Diese Gleichung heißt charakteristische Gleichung der Matrix $A$ \\[71, 74, 82\\].

Damit kann ich Eigenwerte bestimmen, ohne zunächst einen Eigenvektor zu kennen. Ich suche diejenigen Werte von $\\lambda$, für die $A - \\lambda I$ singulär wird.

## Definition 3.2.20: Charakteristisches Polynom

Das charakteristische Polynom einer Matrix $A \\in \\mathbb{R}^{n \\times n}$ definiere ich durch

$$p_{A}(\\lambda) = \\det(A - \\lambda I)\\ (3.130)$$

Die Eigenwerte von $A$ sind genau die Nullstellen dieses Polynoms:

$$p_{A}(\\lambda) = 0\\ (3.131)$$

Da $p_{A}$ ein Polynom vom Grad $n$ ist, besitzt eine $n \\times n$-Matrix über den komplexen Zahlen unter Berücksichtigung algebraischer Vielfachheiten genau $n$ Eigenwerte. Über den reellen Zahlen müssen dagegen nicht alle Nullstellen reell sein.

Damit ist wichtig: Eine reelle Matrix besitzt nicht notwendigerweise ausschließlich reelle Eigenwerte.

## Beispiel einer Diagonalmatrix

Ich betrachte\\
$$A = \\begin{pmatrix}
2 & 0 \\\\
0 & 3
\\end{pmatrix}.$$

Für das charakteristische Polynom ergibt sich

$$p_{A}(\\lambda) = \\ det\\begin{pmatrix}
2 - \\lambda & 0 \\\\
0 & 3 - \\lambda
\\end{pmatrix} = (2 - \\lambda)(3 - \\lambda).\\ (3.132)$$

Die Nullstellen sind

$$\\lambda_{1} = 2,\\quad\\quad\\lambda_{2} = 3\\ (3.133)$$

Damit besitzt die Matrix zwei verschiedene Eigenwerte.

Für $\\lambda_{1} = 2$ gilt\\
$$\\mathbf{A}\\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} = 2\\begin{pmatrix}
1 \\\\
0
\\end{pmatrix},$$

und für $\\lambda_{2} = 3$

$$\\mathbf{A}\\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} = 3\\begin{pmatrix}
0 \\\\
1
\\end{pmatrix},$$

Diese beiden Rechnungen bestätigen die Eigenvektoren der Standardbasis, erhalten aber keine zusätzlichen Gleichungsnummern, weil sie lediglich die Aussage von Gleichung (3.126) für das konkrete Beispiel prüfen.

Geometrisch bedeutet dies, dass die $x$-Richtung mit dem Faktor $2$ und die $y$-Richtung mit dem Faktor $3$ skaliert wird.

## Definition 3.2.21: Eigenraum

Zu einem Eigenwert $\\lambda$ definiere ich den Eigenraum durch

$$E_{\\lambda} = \\ker(A - \\lambda I)\\ (3.134)$$

Der Eigenraum enthält damit den Nullvektor und sämtliche Eigenvektoren, die zum Eigenwert $\\lambda$ gehören \\[71, 74, 82\\].

Die Eigenvektoren eines Eigenwerts bilden also zusammen mit dem Nullvektor einen Untervektorraum.

Für das vorherige Beispiel gilt beispielsweise

$$E_{2} = \\text{span}\\left\\{ \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} \\right\\},\\quad\\quad E_{3} = \\text{span}\\left\\{ \\begin{pmatrix}
0 \\\\
1
\\end{pmatrix} \\right\\}\\ (3.135)$$

Jeder von null verschiedene Vektor aus $E_{2}$ bleibt unter $A$ auf derselben Geraden und wird mit $2$ skaliert. Entsprechend werden die Vektoren aus $E_{3}$ mit $3$ skaliert.

## Algebraische und geometrische Vielfachheit

Besitzt ein Eigenwert $\\lambda$ im charakteristischen Polynom die Vielfachheit $m$, bezeichne ich diese als algebraische Vielfachheit.

Die Dimension des zugehörigen Eigenraums bezeichne ich als geometrische Vielfachheit:

$$m_{g}(\\lambda) = \\dim\\left( E_{\\lambda} \\right)\\ (3.136)$$

Zwischen geometrischer und algebraischer Vielfachheit gilt

$$1 \\leq m_{g}(\\lambda) \\leq m_{a}(\\lambda)\\ (3.137)$$

Dabei bezeichnet $m_{a}(\\lambda)$ die algebraische Vielfachheit des Eigenwerts.

Diese Unterscheidung ist wesentlich, weil ein mehrfacher Eigenwert nicht automatisch genügend viele linear unabhängige Eigenvektoren besitzt.

## Beispiel eines mehrfachen Eigenwerts

Ich betrachte\\
$$A = \\begin{pmatrix}
2 & 1 \\\\
0 & 2
\\end{pmatrix}.$$

Das charakteristische Polynom lautet

$$p_{A}(\\lambda) = (2 - \\lambda)^{2}\\ (3.138)$$

Damit besitzt die Matrix nur den Eigenwert $\\lambda = 2$, allerdings mit algebraischer Vielfachheit $2$.

Für den Eigenraum löse ich $(A - 2I)v = 0.\\ $Es ergibt sich\\
A-2I=$\\begin{pmatrix}
0 & 1 \\\\
0 & 0
\\end{pmatrix}.$ Daraus folgt $v_{2} = 0$, während $v_{1}$ frei gewählt werden kann.

Der Eigenraum ist somit eindimensional:

$$E_{2} = \\text{span}\\left\\{ \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} \\right\\}\\ (3.139)$$

Damit gilt in diesem Beispiel\\
$$m_{a}(2) = 2,\\quad\\quad m_{g}(2) = 1.$$

Diese Werte erläutern Gleichungen (3.136) und (3.137) und werden deshalb nicht separat nummeriert.

Die Matrix besitzt also nicht genügend unabhängige Eigenvektoren, um eine Basis des gesamten zweidimensionalen Raums zu bilden.

## Eigenvektoren zu verschiedenen Eigenwerten

Ein grundlegendes Ergebnis lautet: Eigenvektoren zu paarweise verschiedenen Eigenwerten sind linear unabhängig \\[71, 74, 82\\].

Sind $\\lambda_{1},\\ldots,\\lambda_{k}$ paarweise verschiedene Eigenwerte und $v_{1},\\ldots,v_{k}$ zugehörige Eigenvektoren, dann sind $v_{1},\\ldots,v_{k}$ linear unabhängig.

Diese Aussage ist strukturell wichtig, weil sie eine direkte Verbindung zwischen der Anzahl verschiedener Eigenwerte und der Möglichkeit einer Eigenvektorbasis herstellt.

Insbesondere besitzt eine $n \\times n$-Matrix mit $n$ paarweise verschiedenen Eigenwerten automatisch $n$ linear unabhängige Eigenvektoren.

## Spur und Determinante

Die Eigenwerte einer Matrix stehen in engem Zusammenhang mit Determinante und Spur.

Für eine $n \\times n$-Matrix mit Eigenwerten $\\lambda_{1},\\ldots,\\lambda_{n}$, gezählt mit ihren algebraischen Vielfachheiten, gilt

$$\\det(A) = \\prod_{i = 1}^{n}\\lambda_{i}\\ (3.140)$$

Die Determinante ist damit das Produkt aller Eigenwerte \\[71, 74, 82\\].

Ebenso gilt für die Spur

$$\\text{tr}(A) = \\sum_{i = 1}^{n}\\lambda_{i}\\ (3.141)$$

Die Spur ist die Summe der Diagonalelemente einer Matrix. Gleichung (3.141) zeigt, dass sie gleichzeitig der Summe der Eigenwerte entspricht.

Daraus folgt unmittelbar: Besitzt eine Matrix einen Eigenwert $\\lambda = 0$, so verschwindet ihr Determinantenprodukt und die Matrix ist singulär.

Damit verbinden sich Eigenwertstruktur, Determinante und Invertierbarkeit erneut zu derselben algebraischen Struktur.

## Eigenwert null und Kern

Für $\\lambda = 0$ wird die Eigenwertgleichung $Av = 0.$ Damit ist ein von null verschiedener Vektor genau dann Eigenvektor zum Eigenwert $0$, wenn er im Kern von $A$ liegt.

Es gilt deshalb

$$0\\,\\text{ist Eigenwert von }A\\quad \\Longleftrightarrow \\quad\\ker(A) \\neq \\text{\\{}0\\text{\\}}\\ (3.142)$$

Für quadratische Matrizen folgt daraus außerdem

$$0\\,\\text{ist Eigenwert}\\quad \\Longleftrightarrow \\quad\\det(A) = 0\\quad \\Longleftrightarrow \\quad A\\,\\text{ist nicht invertierbar}\\ (3.143)$$

Damit treffen Eigenwerttheorie, Kern, Determinante und Invertierbarkeit unmittelbar zusammen.

## Eigenwerte unter einem Basiswechsel

Die Matrixdarstellung eines linearen Operators hängt von der gewählten Basis ab. Seine Eigenwerte dagegen bleiben unter einem Basiswechsel erhalten.

Sind\\
$$A_{C} = P^{- 1}A_{B}P$$

zwei ähnliche Matrixdarstellungen desselben Operators, dann besitzen sie dasselbe charakteristische Polynom:

$$p_{A_{C}}(\\lambda) = p_{A_{B}}(\\lambda)\\ (3.144)$$

Damit besitzen beide Matrizen dieselben Eigenwerte.

Die konkrete Koordinatendarstellung der Eigenvektoren ändert sich dagegen mit der Basis. Der zugrunde liegende Eigenvektor als Element des Vektorraums bleibt derselbe mathematische Vektor.

Diese Unterscheidung entspricht genau der bereits eingeführten Trennung zwischen mathematischem Objekt und Koordinatendarstellung.

## Spektrum einer Matrix

Die Gesamtheit aller Eigenwerte einer endlichdimensionalen Matrix fasse ich im Spektrum zusammen.

## Definition 3.2.22: Spektrum

Für eine quadratische Matrix $A$ definiere ich

$$\\sigma(A) = \\left\\{ \\lambda \\middle| \\det(A - \\lambda I) = 0 \\right\\}\\ (3.145)$$

Das Spektrum enthält damit sämtliche Eigenwerte der Matrix.

Im endlichdimensionalen Fall ist diese Beschreibung unmittelbar mit dem charakteristischen Polynom verbunden. In allgemeineren funktionalanalytischen Räumen wird der Spektralbegriff umfassender und kann auch Werte enthalten, die nicht zu gewöhnlichen Eigenvektoren gehören. Diese Erweiterung benötige ich an dieser Stelle noch nicht.

## Wissenschaftliche Einordnung

Eigenwerte und Eigenvektoren ermöglichen mir eine strukturelle Analyse linearer Operatoren, die über Rang, Kern und Determinante hinausgeht.

Der Rang sagt mir, wie viele unabhängige Richtungen im Bild verbleiben. Der Kern zeigt, welche Richtungen auf den Nullvektor abgebildet werden. Die Eigenwertanalyse identifiziert dagegen diejenigen Richtungen, die unter dem Operator ihre Richtung beibehalten und lediglich skaliert werden.

Ein Eigenvektor ist deshalb keine beliebige Koordinatenrichtung. Er ist durch den Operator selbst ausgezeichnet.

Der zugehörige Eigenwert beschreibt die Wirkung des Operators entlang dieser Richtung:

-   $|\\lambda| > 1$ bedeutet Verstärkung,

-   $0 < |\\lambda| < 1$ bedeutet Abschwächung,

-   $\\lambda = 1$ bedeutet unveränderte Skalierung,

-   $\\lambda = - 1$ bedeutet betragsmäßige Erhaltung bei Richtungsumkehr,

-   $\\lambda = 0$ bedeutet Abbildung auf den Nullvektor.

Diese Aussagen sind zunächst ausschließlich linear-algebraisch zu verstehen.

Für das FRZK kann die Eigenwertanalyse später eine wichtige Rolle spielen, wenn funktionale Operatoren untersucht werden. Eine Eigenrichtung könnte dann beispielsweise mathematisch eine Richtung darstellen, in der sich ein Zustand unter einer Transformation ausschließlich skaliert. Ob dies jedoch als stabiler Modus, bevorzugte Struktur oder physikalisch ausgezeichnete Zustandsrichtung interpretiert werden darf, muss aus den späteren Axiomen und Definitionen folgen.

## Methodologische Betrachtungen

Methodologisch ist besonders wichtig, Eigenwert und Eigenvektor nicht unabhängig voneinander zu interpretieren.

Ein Eigenwert besitzt seine Bedeutung immer bezüglich eines Operators und eines zugehörigen Eigenraums. Die Zahl $\\lambda$ allein beschreibt noch keinen Zustand. Sie beschreibt die Wirkung des Operators auf bestimmte Richtungen.

Ebenso darf ich einen großen Eigenwert nicht automatisch als „wichtiger" interpretieren als einen kleinen Eigenwert. Mathematisch bedeutet ein größerer Betrag lediglich eine stärkere Skalierung bei einmaliger Anwendung des Operators.

Erst bei wiederholter Anwendung entsteht ein dynamischer Zusammenhang. Für einen Eigenvektor $v$ gilt beispielsweise

$$A^{k}v = \\lambda^{k}v\\ (3.146)$$

Damit wird sichtbar, warum der Betrag des Eigenwerts bei iterierten linearen Prozessen eine besondere Bedeutung erhält:

-   $|\\lambda| < 1$ führt entlang der Eigenrichtung gegen null,

-   $|\\lambda| > 1$ führt zu wachsendem Betrag,

-   $|\\lambda| = 1$ erhält den Betrag entlang der Eigenrichtung.

Diese dynamische Interpretation setzt allerdings voraus, dass tatsächlich wiederholte Anwendungen desselben Operators betrachtet werden.

Für das FRZK darf ich deshalb Eigenwerte erst dann dynamisch interpretieren, wenn ein entsprechender Evolutions- oder Übergangsoperator definiert wurde. Ohne einen solchen Operator wäre eine Aussage über Wachstum, Zerfall oder Stabilität methodisch unbegründet.

## Didaktische Betrachtungen

Für mich lässt sich der Eigenwertbegriff besonders anschaulich verstehen, wenn ich mir zunächst eine allgemeine lineare Transformation in der Ebene vorstelle.

Ein beliebiger Vektor kann durch die Transformation gleichzeitig gedreht, gestreckt und in seiner Orientierung verändert werden.

Ein Eigenvektor ist dagegen eine besondere Richtung, bei der die Transformation wesentlich einfacher wirkt: $v \\longmapsto \\lambda v.$ Diese Darstellung dient nur der begrifflichen Veranschaulichung.

Der Vektor bleibt auf derselben Ursprungsgeraden. Nur sein Betrag und gegebenenfalls seine Richtung auf dieser Geraden verändern sich.

Damit kann ich Eigenwerte geometrisch lesen:

-   $\\lambda = 2$: doppelte Länge,

-   $\\lambda = \\frac{1}{2}$: halbe Länge,

-   $\\lambda = - 1$: gleiche Länge, entgegengesetzte Richtung,

-   $\\lambda = 0$: Zusammenfallen im Nullvektor.

Auch diese Beispiele sind Erläuterungen der Eigenwertgleichung und keine zusätzlichen Gleichungen.

Besonders hilfreich ist für mich außerdem die folgende Kette:

$$Av = \\lambda v\\quad \\Longrightarrow \\quad(A - \\lambda I)v = 0\\quad \\Longrightarrow \\quad\\det(A - \\lambda I) = 0.$$

Sie beschreibt den Weg von der geometrischen Eigenvektoridee zur rechnerischen Bestimmung der Eigenwerte. Da sie lediglich die bereits nummerierten Gleichungen (3.126), (3.127) und (3.129) zusammenfasst, erhält sie keine weitere Nummer.

Damit lässt sich der praktische Ablauf klar strukturieren:

1.  Ich bilde $A - \\lambda I$.

2.  Ich bestimme $\\det(A - \\lambda I)$.

3.  Ich löse die charakteristische Gleichung.

4.  Für jeden Eigenwert bestimme ich den Kern von $A - \\lambda I$.

5.  Dieser Kern liefert den zugehörigen Eigenraum.

So werden Eigenwerte und Eigenvektoren nicht zu isolierten Rechenverfahren, sondern ergeben sich unmittelbar aus Determinante und Kern.

## Ergebnis und Übergang

Mit Eigenwerten, Eigenvektoren und Eigenräumen kann ich nun diejenigen Richtungen eines linearen Operators identifizieren, die unter seiner Wirkung erhalten bleiben und lediglich skaliert werden.

Das charakteristische Polynom liefert die Eigenwerte, während die Kerne der Matrizen $A - \\lambda I$ die zugehörigen Eigenräume bestimmen. Algebraische und geometrische Vielfachheit zeigen, ob zu mehrfach auftretenden Eigenwerten genügend unabhängige Eigenvektoren vorhanden sind.

Eigenwerte verbinden sich außerdem unmittelbar mit Determinante, Spur, Kern und Invertierbarkeit. Ihr Produkt ergibt die Determinante, ihre Summe die Spur und der Eigenwert null kennzeichnet im quadratischen endlichdimensionalen Fall eine singuläre Matrix.

Damit entsteht die nächste zentrale Frage: Unter welchen Bedingungen kann ich eine Basis ausschließlich aus Eigenvektoren bilden und dadurch die Matrixdarstellung eines Operators auf eine Diagonalmatrix vereinfachen?

Der folgende Abschnitt behandelt deshalb **3.2.11 Diagonalisierung und Spektralzerlegung**.

**Fortsetzungsstand:** Abschnitt 3.2.10 endet mit Gleichung **(3.146)**. Abschnitt **3.2.11 beginnt mit (3.147)**.
```

### Quellabschnitt 3.2.11 – Diagonalisierung und Spektralzerlegung

- `section_id`: `33`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `2d6f60e4489f21fffd98ca5ba52927fcbed4993a21351843b77f4a3c04e7f9f5`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.11 Diagonalisierung und Spektralzerlegung

Mit Eigenwerten und Eigenvektoren kann ich diejenigen Richtungen eines linearen Operators bestimmen, die unter seiner Wirkung lediglich skaliert werden. Der nächste Schritt besteht darin zu prüfen, ob sich aus diesen ausgezeichneten Richtungen eine vollständige Basis des betrachteten Vektorraums bilden lässt. Ist das möglich, kann ich die Matrixdarstellung des Operators durch einen geeigneten Basiswechsel auf eine Diagonalmatrix zurückführen. Genau darin liegt die Idee der Diagonalisierung \\[74\\]. Strang behandelt diesen Zusammenhang ausdrücklich in Kapitel 6, insbesondere in §6.2 „Diagonalizing a Matrix".

Die Bedeutung dieser Umformung liegt für mich nicht darin, dass ein anderer Operator entsteht. Wie beim allgemeinen Basiswechsel bleibt der lineare Operator selbst unverändert. Lediglich seine Matrixdarstellung wird in einer besonders geeigneten Basis wesentlich einfacher. Wenn diese Basis aus Eigenvektoren besteht, wirkt der Operator entlang jeder Basisrichtung nur noch durch Multiplikation mit dem zugehörigen Eigenwert \\[74\\].

Für das Funktionale Raum-Zeit-Kohärenzsystem ist diese Struktur später deshalb interessant, weil sie komplexe lineare Kopplungen in voneinander getrennte Eigenrichtungen zerlegen kann. Eine solche Zerlegung darf jedoch zunächst nur mathematisch verstanden werden. Ob einzelne Eigenrichtungen später eigenständige funktionale Modi oder physikalisch interpretierbare Zustandsanteile darstellen, muss aus dem Modell selbst begründet werden.

## Definition 3.2.23: Diagonalisierbarkeit

Eine quadratische Matrix\\
$$A \\in \\mathbb{R}^{n \\times n}$$

heißt diagonalisierbar, wenn eine invertierbare Matrix $P$ und eine Diagonalmatrix $D$ existieren, sodass

$$A = PDP^{- 1}\\ (3.147)$$

Dabei gilt:

-   $A$ ist die ursprüngliche Matrixdarstellung,

-   $P$ ist die Basiswechselmatrix,

-   $D$ ist die Diagonalmatrix,

-   $P^{- 1}$ ist die inverse Basiswechselmatrix.

Die Spalten von $P$ werden dabei aus linear unabhängigen Eigenvektoren von $A$ gebildet. Die zugehörigen Eigenwerte stehen in derselben Reihenfolge auf der Hauptdiagonale von $D$ \\[74\\].

Schreibe ich die Eigenvektoren als $v_{1},\\ldots,v_{n}$, dann hat $P$ die Form

$$P = \\begin{pmatrix}
v_{1} & v_{2} & \\cdots & v_{n}
\\end{pmatrix}\\ (3.148)$$

Die zugehörige Diagonalmatrix lautet

$$D = \\begin{pmatrix}
\\lambda_{1} & 0 & \\cdots & 0 \\\\
0 & \\lambda_{2} & \\cdots & 0 \\\\
 \\vdots & \\vdots & \\ddots & \\vdots \\\\
0 & 0 & \\cdots & \\lambda_{n}
\\end{pmatrix}\\ (3.149)$$

Dabei gehört $\\lambda_{i}$ jeweils zum Eigenvektor $v_{i}$.

## Zusammenhang zwischen Eigenvektoren und Diagonalmatrix

Für jeden Eigenvektor gilt\\
$$Av_{i} = \\lambda_{i}v_{i}.$$

Fasse ich alle Eigenvektoren spaltenweise in $P$ zusammen, kann ich diese einzelnen Beziehungen gleichzeitig schreiben als

$$AP = PD\\ (3.150)$$

Diese Gleichung enthält spaltenweise genau die einzelnen Eigenwertgleichungen

$$Av_{i} = \\lambda_{i}v_{i}.
$$

Diese Einzelbeziehungen sind Bestandteile von Gleichung (3.150) und erhalten deshalb keine zusätzlichen Gleichungsnummern.

Da $P$ invertierbar ist, folgt aus Gleichung (3.150)$
$$$A = PDP^{- 1}.$$

Damit erhalte ich wieder Gleichung (3.147).

Alternativ kann ich nach $D$ auflösen:

$$D = P^{- 1}AP\\ (3.151)$$

Gleichung (3.151) zeigt besonders deutlich, dass die Diagonalisierung ein spezieller Basiswechsel ist. Die Matrix $D$ beschreibt denselben linearen Operator in einer Basis aus Eigenvektoren.

## Voraussetzung der Diagonalisierbarkeit

Eine $n \\times n$-Matrix ist genau dann diagonalisierbar, wenn sie $n$ linear unabhängige Eigenvektoren besitzt \\[74\\]. Das offizielle MIT-Material formuliert die Diagonalisierung entsprechend über eine Matrix aus unabhängigen Eigenvektoren.

Damit gilt

$$A\\,\\text{diagonalisierbar}\\quad \\Longleftrightarrow \\quad A\\,\\text{besitzt }n\\text{ linear unabhängige Eigenvektoren}\\ (3.152)$$

Die Anzahl der Eigenwerte allein genügt dafür nicht. Entscheidend ist die Anzahl der **linear unabhängigen Eigenvektoren**.

Besitzt eine $n \\times n$-Matrix $n$ paarweise verschiedene Eigenwerte, so besitzt sie automatisch $n$ linear unabhängige Eigenvektoren und ist damit diagonalisierbar \\[74\\].

Daraus folgt die hinreichende Bedingung

$$\\lambda_{1},\\ldots,\\lambda_{n}\\,\\text{paarweise verschieden}\\quad \\Longrightarrow \\quad A\\,\\text{diagonalisierbar}\\ (3.153)$$

Die Umkehrung gilt jedoch nicht. Eine Matrix kann auch bei mehrfachen Eigenwerten diagonalisierbar sein, sofern die zugehörigen Eigenräume zusammen genügend unabhängige Eigenvektoren liefern.

## Algebraische und geometrische Vielfachheit

Für einen Eigenwert $\\lambda$ hatte ich bereits zwischen algebraischer und geometrischer Vielfachheit unterschieden.

Für die Diagonalisierbarkeit muss für jeden Eigenwert gelten, dass seine geometrische Vielfachheit seiner algebraischen Vielfachheit entspricht und die Summe der Eigenraumdimensionen $n$ ergibt.

Damit kann ich die Bedingung schreiben als

$$A\\,\\text{diagonalisierbar}\\quad \\Longleftrightarrow \\quad\\sum_{\\lambda \\in \\sigma(A)}^{}{\\dim\\left( E_{\\lambda} \\right)} = n\\ (3.154)$$

Dabei bezeichnet

-   $\\sigma(A)$ das Spektrum von $A$,

-   $E_{\\lambda}$ den Eigenraum zum Eigenwert $\\lambda$,

-   $\\dim\\left( E_{\\lambda} \\right)$ dessen Dimension.

Damit wird die Diagonalisierbarkeit zu einer Aussage darüber, ob die Eigenräume zusammen den gesamten Vektorraum aufspannen.

## Beispiel einer diagonalisierbaren Matrix

Ich betrachte erneut\\
$$A = \\begin{pmatrix}
2 & 0 \\\\
0 & 3
\\end{pmatrix}.$$

Diese Matrix ist bereits diagonal. Ihre Eigenvektoren können als Standardbasisvektoren gewählt werden.

Damit gilt

$$P = \\begin{pmatrix}
1 & 0 \\\\
0 & 1
\\end{pmatrix},\\quad\\quad D = \\begin{pmatrix}
2 & 0 \\\\
0 & 3
\\end{pmatrix}.
$$Diese beiden Matrixangaben dienen nur der Beschreibung des Beispiels und erhalten keine eigenen Gleichungsnummern.

Mit (P=I) folgt unmittelbar

$$P^{- 1}AP = A = D\\ (3.155)$$

Dieses triviale Beispiel zeigt, dass eine Diagonalmatrix bereits bezüglich der Standardbasis in einer Eigenvektorbasis dargestellt ist.

Interessanter wird die Diagonalisierung, wenn die ursprüngliche Matrix nicht diagonal ist.

## Beispiel eines nichtdiagonalen Operators

Ich betrachte

$$A = \\begin{pmatrix}
4 & 1 \\\\
2 & 3
\\end{pmatrix}.
$$Das charakteristische Polynom ergibt

$$p_{A}(\\lambda) = \\det\\begin{pmatrix}
4 - \\lambda & 1 \\\\
2 & 3 - \\lambda
\\end{pmatrix} = (4 - \\lambda)(3 - \\lambda) - 2 = \\lambda^{2} - 7\\lambda + 10.\\ (3.156)$$

Damit gilt

$$p_{A}(\\lambda) = (\\lambda - 5)(\\lambda - 2),$$

woraus die Eigenwerte

$$\\lambda_{1} = 5,\\quad\\quad\\lambda_{2} = 2\\ (3.157)$$

Da beide Eigenwerte verschieden sind, existieren zwei linear unabhängige Eigenvektoren.

Für $\\lambda_{1} = 5$ kann ich beispielsweise

$$v_{1} = \\begin{pmatrix}
1 \\\\
1
\\end{pmatrix}
$$wählen.

Für $\\lambda_{2} = 2$ kann ich beispielsweise\\
$$v_{2} = \\begin{pmatrix}
1 \\\\
\\text{-}2
\\end{pmatrix}$$

wählen.

Die einzelnen Vektorangaben sind Bestandteile der Konstruktion und erhalten keine eigenen Gleichungsnummern.

Damit bilde ich

$$P = \\begin{pmatrix}
1 & 1 \\\\
1 & - 2
\\end{pmatrix},\\quad\\quad D = \\begin{pmatrix}
5 & 0 \\\\
0 & 2
\\end{pmatrix}\\ (3.158)$$

Die Diagonalisierungsbeziehung lautet dann

$$P^{- 1}AP = D\\ (3.159)$$

Damit wird die ursprünglich gekoppelte Matrixdarstellung in der Eigenvektorbasis auf zwei voneinander unabhängige Skalierungen reduziert.

## Nicht diagonalisierbare Matrix

Nicht jede Matrix besitzt genügend unabhängige Eigenvektoren.

Ich betrachte\\
$$A = \\begin{pmatrix}
2 & 1 \\\\
0 & 2
\\end{pmatrix}.$$

Für diese Matrix hatte ich bereits festgestellt, dass\\
$$p_{A}(\\lambda) = (2 - \\lambda)^{2}.$$

Der einzige Eigenwert ist daher $\\lambda = 2$ mit algebraischer Vielfachheit $2$.

Der zugehörige Eigenraum ist jedoch nur eindimensional:

$$E_{2} = span\\left\\{ \\begin{pmatrix}
1 \\\\
0
\\end{pmatrix} \\right\\}.$$

Damit existiert nur ein linear unabhängiger Eigenvektor. Die Bedingung aus Gleichung (3.152) ist nicht erfüllt.

Folglich gilt

$$A\\,\\text{ist nicht diagonalisierbar}\\ (3.160)$$

Dieses Beispiel zeigt, warum die algebraische Vielfachheit eines Eigenwerts allein nicht genügt. Entscheidend ist, ob sein Eigenraum genügend unabhängige Richtungen bereitstellt.

## Potenzen einer diagonalisierbaren Matrix

Eine wesentliche praktische Stärke der Diagonalisierung zeigt sich bei Matrixpotenzen.

Ist\\
$$A = PDP^{- 1},$$

so gilt\\
$$A^{2} = PDP^{- 1}PDP^{- 1}.$$

Da $P^{- 1}P = I$, bleiben nur $P$, $D^{2}$ und $P^{- 1}$ übrig.

Allgemein folgt

$$A^{k} = PD^{k}P^{- 1}\\ (3.161)$$

Die Potenz einer Diagonalmatrix ist besonders einfach:

$$D^{k} = \\begin{pmatrix}
\\lambda_{1}^{k} & 0 & \\cdots & 0 \\\\
0 & \\lambda_{2}^{k} & \\cdots & 0 \\\\
 \\vdots & \\vdots & \\ddots & \\vdots \\\\
0 & 0 & \\cdots & \\lambda_{n}^{k}
\\end{pmatrix}\\ (3.162)$$

Damit reduziert sich die wiederholte Anwendung eines linearen Operators auf die Potenzierung seiner Eigenwerte. Dieser Zusammenhang ist ein zentraler Grund dafür, warum Diagonalisierung bei iterierten linearen Prozessen so nützlich ist \\[74\\].

## Matrixfunktionen

Die gleiche Struktur lässt sich auf Funktionen einer diagonalisierbaren Matrix übertragen.

Ist eine Funktion $f$ für die Eigenwerte von $A$ definiert, kann ich schreiben

$$f(A) = P\\, f(D)\\, P^{- 1}\\ (3.163)$$

Dabei gilt

$$f(D) = \\begin{pmatrix}
f\\left( \\lambda_{1} \\right) & 0 & \\cdots & 0 \\\\
0 & f\\left( \\lambda_{2} \\right) & \\cdots & 0 \\\\
 \\vdots & \\vdots & \\ddots & \\vdots \\\\
0 & 0 & \\cdots & f\\left( \\lambda_{n} \\right)
\\end{pmatrix}\\ (3.164)$$

Damit kann ich beispielsweise Matrixpotenzen, Matrixexponentialfunktionen oder andere geeignete Funktionen auf die einzelnen Eigenwerte zurückführen.

## Spektralzerlegung

Eine besonders starke Form der Diagonalisierung tritt bei reellen symmetrischen Matrizen auf. Strang behandelt symmetrische Matrizen unmittelbar in §6.4 und verweist dort ausdrücklich auf den Spektralsatz. Die offiziellen Lösungen bestätigen, dass die Eigenvektoren symmetrischer Matrizen orthogonal gewählt werden können. \\[74\\]

Für eine reelle symmetrische Matrix\\
$$A = A^{T}$$

existiert eine orthogonale Matrix $Q$, deren Spalten aus orthonormalen Eigenvektoren bestehen, sodass

$$A = Q\\Lambda Q^{T}\\ (3.165)$$

Dabei gilt:

-   $Q$ enthält orthonormale Eigenvektoren,

-   $Q^{T} = Q^{- 1}$,

-   $\\Lambda$ ist die Diagonalmatrix der reellen Eigenwerte.

Diese Aussage ist die endlichdimensionale Form des **Spektralsatzes für reelle symmetrische Matrizen** \\[74\\].

Die Orthogonalität bedeutet

$$Q^{T}Q = QQ^{T} = I\\ (3.166)$$

Damit ist die inverse Eigenvektormatrix besonders einfach:\\
$$Q^{- 1} = Q^{T}.$$

Diese Beziehung ist bereits Bestandteil von Gleichung (3.166) und wird deshalb nicht erneut nummeriert.

## Definition 3.2.24: Orthogonale Diagonalisierung

Eine reelle Matrix $A$ heißt orthogonal diagonalisierbar, wenn eine orthogonale Matrix $Q$ und eine Diagonalmatrix $\\Lambda$ existieren, sodass

$$Q^{T}AQ = \\Lambda\\ (3.167)$$

Für reelle Matrizen gilt der grundlegende Zusammenhang

$$A\\,\\text{orthogonal diagonalisierbar}\\quad \\Longleftrightarrow \\quad A = A^{T}\\ (3.168)$$

Damit besitzt jede reelle symmetrische Matrix eine orthonormale Eigenvektorbasis und ausschließlich reelle Eigenwerte \\[74\\].

## Zerlegung in Eigenprojektoren

Sind $q_{1},\\ldots,q_{n}$ orthonormale Eigenvektoren einer reellen symmetrischen Matrix mit Eigenwerten $\\lambda_{1},\\ldots,\\lambda_{n}$, kann ich Gleichung (3.165) als Summe schreiben:

$$A = \\sum_{i = 1}^{n}{\\lambda_{i}q_{i}q_{i}^{T}}\\ (3.169)$$

Der Ausdruck\\
$$q_{i}q_{i}^{T}$$

ist die orthogonale Projektion auf die eindimensionale Eigenrichtung von $q_{i}$.

Damit kann ich den Operator in einzelne spektrale Beiträge zerlegen. Jeder Beitrag besteht aus einer Projektion auf einen Eigenraum und der anschließenden Skalierung mit dem entsprechenden Eigenwert.

Besitzt ein Eigenwert einen mehrdimensionalen Eigenraum, kann ich die zu diesem Eigenwert gehörenden Projektoren zusammenfassen. Dann erhält die Spektralzerlegung allgemein die Form

$$A = \\sum_{\\lambda \\in \\sigma(A)}^{}{\\lambda P_{\\lambda}}\\ (3.170)$$

Dabei bezeichnet $P_{\\lambda}$ den orthogonalen Projektor auf den Eigenraum $E_{\\lambda}$.

Diese Form zeigt für mich besonders klar, was eine Spektralzerlegung mathematisch leistet: Der Operator wird in voneinander unabhängige Beiträge seiner Eigenräume zerlegt.

## Vollständigkeitsrelation

Da die orthonormalen Eigenvektoren einer symmetrischen Matrix eine Basis des gesamten Vektorraums bilden, gilt für die zugehörigen eindimensionalen Projektoren

$$\\sum_{i = 1}^{n}q_{i}q_{i}^{T} = I\\ (3.171)$$

In der zusammengefassten Eigenraumdarstellung entspricht dies

$$\\sum_{\\lambda \\in \\sigma(A)}^{}P_{\\lambda} = I\\ (3.172)$$

Damit zerlegen die Eigenräume den gesamten Vektorraum vollständig.

Für unterschiedliche Eigenwerte sind die zugehörigen Projektoren orthogonal:

$$P_{\\lambda}P_{\\mu} = 0\\quad\\quad\\text{für }\\lambda \\neq$$

Für denselben Eigenraum gilt dagegen die Projektoreigenschaft

$$P_{\\lambda}^{2} = P_{\\lambda}\\ (3.174)$$

Damit sind die einzelnen spektralen Teilräume gegenseitig getrennt und gemeinsam vollständig.

## Wirkung auf einen beliebigen Vektor

Sei $x \\in \\mathbb{R}^{n}$. Bezüglich einer orthonormalen Eigenbasis kann ich $x$ zerlegen als

$$x = \\sum_{i = 1}^{n}\\left( q_{i}^{T}x \\right)\\, q_{i}\\ (3.175)$$

Dabei ist $q_{i}^{T}x$ die Koordinate von $x$ entlang der Eigenrichtung $q_{i}$.

Wende ich $A$ auf diesen Vektor an, erhalte ich

$$Ax = \\sum_{i = 1}^{n}{\\lambda_{i}\\left( q_{i}^{T}x \\right)}\\, q_{i}\\ (3.176)$$

Damit wirkt der Operator auf jede Eigenkomponente unabhängig. Es entstehen keine Kopplungsterme zwischen unterschiedlichen Eigenrichtungen.

Gerade diese Entkopplung macht die Spektralzerlegung mathematisch so leistungsfähig.

## Matrixfunktionen in Spektraldarstellung

Für eine reelle symmetrische Matrix kann ich eine geeignete Funktion $f(A)$ unmittelbar spektral schreiben:

$$f(A) = \\sum_{i = 1}^{n}{f\\left( \\lambda_{i} \\right)}\\, q_{i}q_{i}^{T}\\ (3.177)$$

In der Eigenraumdarstellung gilt entsprechend

$$f(A) = \\sum_{\\lambda \\in \\sigma(A)}^{}{f(\\lambda)P_{\\lambda}}\\ (3.178)$$

Damit kann ich die Wirkung komplexerer Matrixfunktionen vollständig auf die Eigenwerte und Eigenprojektoren zurückführen.

## Wissenschaftliche Einordnung

Die Diagonalisierung zeigt mir, dass eine kompliziert erscheinende Matrixdarstellung nicht notwendigerweise einer komplizierten intrinsischen Struktur des Operators entspricht. Ein großer Teil der sichtbaren Kopplung zwischen Matrixkomponenten kann lediglich daraus entstehen, dass ich keine an den Operator angepasste Basis verwende.

Existiert eine vollständige Eigenvektorbasis, kann ich den Operator in dieser Basis diagonal darstellen. Dann wirkt er auf jede Eigenrichtung unabhängig durch Multiplikation mit einem einzigen Eigenwert \\[74\\].

Für symmetrische Matrizen ist die Situation noch stärker strukturiert. Ihre Eigenvektoren können orthonormal gewählt werden und ihre Eigenwerte sind reell. Dadurch entsteht eine orthogonale Spektralzerlegung des gesamten Raums \\[74\\].

Für das FRZK eröffnet dies später die Möglichkeit, einen linearen funktionalen Operator gegebenenfalls in voneinander unabhängige Eigenmoden zu zerlegen. Eine solche Zerlegung wäre mathematisch besonders transparent, weil jede Eigenkomponente separat untersucht werden könnte.

Dabei darf ich jedoch nicht voraussetzen, dass ein späterer FRZK-Operator tatsächlich symmetrisch, selbstadjungiert oder überhaupt diagonalisierbar ist. Diese Eigenschaften müssten aus seinen Definitionen oder Axiomen folgen.

## Methodologische Betrachtungen

Methodologisch ist die Diagonalisierung ein besonders gutes Beispiel dafür, warum ich Darstellung und Struktur auseinanderhalten muss.

Eine nichtdiagonale Matrix kann erhebliche Kopplungen zwischen ihren Komponenten zeigen. Nach einem Basiswechsel kann derselbe Operator jedoch diagonal erscheinen. Daraus folgt, dass einzelne Nebendiagonalelemente im Allgemeinen keine basisunabhängigen Eigenschaften des Operators darstellen.

Eine Diagonalmatrix besitzt daher nicht notwendigerweise einen „einfacheren Operator". Sie besitzt lediglich eine Darstellung, in der die intrinsischen Eigenrichtungen direkt als Koordinatenachsen gewählt wurden.

Für das FRZK folgt daraus, dass eine später auftretende Kopplungsmatrix nicht allein aufgrund ihrer sichtbaren Matrixelemente interpretiert werden darf. Zunächst muss ich untersuchen, ob sich diese Kopplungen durch einen Basiswechsel entfernen lassen.

Sind sie durch Diagonalisierung vollständig eliminierbar, dann beschreiben die Nebendiagonalelemente primär die gewählte Darstellung.

Sind sie dagegen aufgrund fehlender Diagonalisierbarkeit nicht vollständig eliminierbar, besitzt die mathematische Struktur eine andere Qualität.

Auch die Spektralzerlegung darf ich nicht automatisch auf jeden Operator übertragen. Die besonders einfache orthogonale Zerlegung\\
$$A = \\sum_{\\lambda}^{}{\\lambda P_{\\lambda}}$$

setzt im hier behandelten reellen endlichdimensionalen Fall insbesondere eine symmetrische Matrix voraus. Für allgemeinere Operatoren gelten andere Voraussetzungen und gegebenenfalls komplexere Spektralstrukturen.

## Didaktische Betrachtungen

Für mich lässt sich die Diagonalisierung am einfachsten als Suche nach einem besseren Koordinatensystem verstehen.

In einer beliebigen Basis kann eine Matrix beispielsweise so aussehen:\\
$$A = \\begin{pmatrix}
a & b \\\\
c & d
\\end{pmatrix}.$$

Die Nebendiagonalelemente $b$ und $c$ zeigen, dass die beiden gewählten Koordinatenrichtungen miteinander gekoppelt sind.

Finde ich jedoch zwei unabhängige Eigenvektoren, kann ich diese als neue Achsen wählen. In dieser Basis lautet die Darstellung\\
$$D = \\begin{pmatrix}
\\lambda_{1} & 0 \\\\
0 & \\lambda_{2}
\\end{pmatrix}.$$

Beide Matrixangaben dienen hier nur der Veranschaulichung und erhalten keine Gleichungsnummern.

Damit habe ich den Operator nicht verändert. Ich habe lediglich Achsen gewählt, die bereits an seine natürliche Wirkung angepasst sind.

Für mich entspricht das geometrisch der Frage:

**Welche Richtungen werden durch die Transformation nicht miteinander vermischt?**

Die Antwort liefern die Eigenvektoren.

Die zugehörigen Eigenwerte beantworten anschließend die Frage:

**Wie stark wirkt die Transformation entlang jeder dieser Richtungen?**

Damit lässt sich der gesamte Zusammenhang in einer begrifflichen Kette darstellen:\\
$$\\text{Operator} \\longrightarrow \\text{Eigenwerte und Eigenvektoren} \\longrightarrow \\text{Eigenbasis} \\longrightarrow \\text{Diagonalmatrix}.$$

Diese Darstellung dient ausschließlich der Übersicht und erhält keine Gleichungsnummer.

Bei einer symmetrischen Matrix kommt eine weitere Eigenschaft hinzu: Die Eigenrichtungen können senkrecht zueinander gewählt werden. Dadurch entsteht eine orthonormale Eigenbasis.

Das macht die Spektralzerlegung besonders anschaulich. Jeder Vektor wird zunächst in seine Eigenkomponenten zerlegt, jede dieser Komponenten wird mit ihrem Eigenwert skaliert und anschließend werden die Ergebnisse wieder zusammengesetzt.

## Ergebnis und Übergang

Mit der Diagonalisierung kann ich einen linearen Operator dann auf eine Diagonalmatrix zurückführen, wenn genügend linear unabhängige Eigenvektoren vorhanden sind. Die Spalten der Basiswechselmatrix bestehen aus diesen Eigenvektoren, während die zugehörigen Eigenwerte die Diagonaleinträge bilden.

Dadurch werden Matrixpotenzen und geeignete Matrixfunktionen erheblich vereinfacht. Statt die vollständige Matrix wiederholt zu multiplizieren, kann ich die entsprechenden Operationen auf die einzelnen Eigenwerte anwenden.

Für reelle symmetrische Matrizen liefert der Spektralsatz eine noch stärkere Struktur: Es existiert eine orthonormale Eigenbasis, sodass der Operator orthogonal diagonalisiert und als Summe seiner Eigenprojektoren dargestellt werden kann \\[74\\].

Damit habe ich eine mathematische Zerlegung erhalten, bei der voneinander unabhängige Richtungen separat behandelt werden können. Im nächsten Schritt muss ich jedoch untersuchen, wie sich geometrische Begriffe wie Länge, Winkel, Orthogonalität und Projektion formal definieren lassen. Diese Strukturen sind insbesondere notwendig, um die Orthogonalität der Eigenvektoren und die Projektoren der Spektralzerlegung mathematisch vollständig einzuordnen.

Der folgende Abschnitt behandelt deshalb **3.2.12 Skalarprodukt, Norm und Orthogonalität**.

**Fortsetzungsstand:** Abschnitt 3.2.11 endet mit Gleichung **(3.178)**. Abschnitt **3.2.12 beginnt mit (3.179)**.
```

### Quellabschnitt 3.2.12 – Skalarprodukt, Norm und Orthogonalität

- `section_id`: `34`
- `revision_id`: `2`
- `version_kind`: `source_import`
- `checksum_sha256`: `f7abce15dbeac24328ad7c46813ee8e9160c88d42ba22a6a121b66d3b06e4d88`
- Notiz: Unveränderter Markdown-Extrakt der Quellfassung; redaktionelle Artefakte bleiben hier bewusst erhalten.

```markdown
# 3.2.12 Skalarprodukt, Norm und Orthogonalität

Mit der Diagonalisierung und der Spektralzerlegung habe ich im vorhergehenden Abschnitt gesehen, dass bestimmte Richtungen eines Vektorraums gegenüber einem linearen Operator ausgezeichnet sein können. Bei reellen symmetrischen Matrizen kann ich diese Eigenrichtungen sogar orthogonal beziehungsweise orthonormal wählen. Damit tauchen jedoch Begriffe auf, die sich aus der reinen Vektorraumstruktur noch nicht ergeben: Länge, Abstand, Winkel und Orthogonalität.

Ein Vektorraum legt zunächst nur fest, wie ich Vektoren addiere und mit Skalaren multipliziere. Daraus folgt noch nicht, wie lang ein Vektor ist oder ob zwei Vektoren senkrecht aufeinander stehen. Für diese zusätzliche geometrische Struktur benötige ich ein Skalarprodukt.

Als zentrale Literaturgrundlage verwende ich hierfür **Gilbert Strang: *Introduction to Linear Algebra*. 5th Edition. Wellesley, Massachusetts: Wellesley-Cambridge Press, 2016 \\[74\\]**. Strang behandelt Längen und Skalarprodukte bereits in §1.2 und führt die darauf aufbauenden Begriffe der Orthogonalität, Projektion und orthonormalen Basen systematisch in Kapitel 4 weiter.

Ergänzend ziehe ich **Stephen H. Friedberg, Arnold J. Insel und Lawrence E. Spence: *Linear Algebra*. 5th Edition. Pearson, 2018 \\[84\\]** heran. Dort bilden Skalarprodukte und Normen den Ausgangspunkt von Kapitel 6 „Inner Product Spaces"; anschließend folgen Gram-Schmidt, orthogonale Komplemente, orthogonale Projektionen und der Spektralsatz.

Für das Funktionale Raum-Zeit-Kohärenzsystem ist diese Unterscheidung später wesentlich. Wenn ich einen Zustand durch einen Vektor beschreibe, folgt daraus allein noch nicht, dass zwischen zwei Zuständen ein geometrisch oder physikalisch interpretierbarer Abstand oder Winkel existiert. Eine solche Interpretation benötigt eine zusätzliche mathematische Struktur. Ich werde deshalb die geometrischen Begriffe zunächst ausschließlich mathematisch entwickeln und ihnen an dieser Stelle noch keine FRZK-spezifische physikalische Bedeutung zuschreiben.

## Definition 3.2.25: Skalarprodukt

Sei (V) ein reeller Vektorraum. Ein Skalarprodukt ist eine Abbildung

$$\\left\\langle \\cdot , \\cdot \\right\\rangle:V \\times V\\mathbb{\\longrightarrow R,\\quad\\quad}(x,y) \\longmapsto \\left\\langle x,y \\right\\rangle.\\ (3.179)$$

Dabei sind

-   \\(V\\) der betrachtete reelle Vektorraum,

-   (x,y\\\\in V) zwei Vektoren,

-   (\\\\langle x,y\\\\rangle) der durch das Skalarprodukt erzeugte reelle Skalar.

Damit eine solche Abbildung ein Skalarprodukt ist, muss sie bestimmte Eigenschaften erfüllen. Für alle (x,y,z\\\\in V) und alle (\\\\alpha,\\\\beta\\\\inℝ) fordere ich zunächst Linearität:

$$\\langle\\alpha x + \\beta y,z\\rangle = \\alpha\\langle x,z\\rangle + \\beta\\langle y,z\\rangle\\ (3.180)$$

Außerdem fordere ich Symmetrie:

$$\\langle x,y\\rangle = \\langle y,x\\rangle\\ (3.181)$$

Schließlich muss das Skalarprodukt positiv definit sein:

$$\\left\\langle x,x \\right\\rangle \\geq 0,\\quad\\quad\\left\\langle x,x \\right\\rangle = 0 \\Longleftrightarrow x = 0\\ (3.182)$$

Diese Eigenschaften bilden gemeinsam die mathematische Grundlage dafür, aus dem Skalarprodukt geometrische Größen abzuleiten \\[84\\]. Kapitel 6.1 von Friedberg, Insel und Spence ist ausdrücklich den „Inner Products and Norms" gewidmet.

## Das euklidische Skalarprodukt

Im Raum (ℝ\\^{n}) ist das Standardbeispiel das euklidische Skalarprodukt. Für\\
$$x = \\begin{pmatrix}
x_{1} \\\\
\\text{⋮} \\\\
x_{n}
\\end{pmatrix},\\quad\\quad y = \\begin{pmatrix}
y_{1} \\\\
\\text{⋮} \\\\
y_{n}
\\end{pmatrix}$$

definiere ich

$$\\left\\langle x,y \\right\\rangle = x^{T}y = \\sum_{i = 1}^{n}{x_{i}y_{i}}\\ (3.183)$$

Die vorangestellten Darstellungen von (x) und (y) sind lediglich die Definition der in Gleichung (3.183) verwendeten Größen. Sie erhalten deshalb bewusst **keine eigenen Gleichungsnummern**.

Für zwei Vektoren des (ℝ\\^{2}),\\
$$x = \\begin{pmatrix}
x_{1} \\\\
x_{2}
\\end{pmatrix},\\quad\\quad y = \\begin{pmatrix}
y_{1} \\\\
y_{2}
\\end{pmatrix},
$$wird Gleichung (3.183) zu

$$\\left\\langle x,y \\right\\rangle = x_{1}y_{1} + x_{2}y_{2}\\ (3.184)$$

Strang behandelt genau diesen Zusammenhang zwischen Vektorlänge und Skalarprodukt bereits in §1.2 „Lengths and Dot Products" \\[74\\].

## Definition 3.2.26: Norm

Aus einem Skalarprodukt kann ich unmittelbar die Länge eines Vektors ableiten. Die vom Skalarprodukt induzierte Norm definiere ich durch

$$\\text{|}x\\text{|} = \\sqrt{\\left\\langle x,x \\right\\rangle}\\ (3.185)$$

Dabei bezeichnet

-   \\(x\\) den betrachteten Vektor,

-   (\\\\langle x,x\\\\rangle) sein Skalarprodukt mit sich selbst,

-   (\\|x\\|) seine durch das Skalarprodukt induzierte Norm.

Für das euklidische Skalarprodukt folgt daraus

$$\\text{|}x\\text{|} = \\sqrt{x_{1}^{2} + x_{2}^{2} + \\cdots + x_{n}^{2}}\\ (3.186)$$

Damit verallgemeinere ich unmittelbar den Satz des Pythagoras auf den (n)-dimensionalen euklidischen Raum. Diese Definition der Norm aus dem Skalarprodukt ist Standardbestandteil der Theorie der Skalarprodukträume \\[84\\].

Eine Norm erfüllt insbesondere

**Word-LaTeX:**

$$\\text{|}x\\text{|} \\geq 0,\\quad\\quad\\text{|}x\\text{|} = 0 \\Longleftrightarrow x = 0\\ (3.187)$$

Für die Multiplikation eines Vektors mit einem Skalar gilt

$$\\text{|}\\alpha x\\text{|} = |\\alpha|\\,\\text{|}x\\text{|}\\ (3.188)$$

Außerdem gilt die Dreiecksungleichung

$$\\text{|}x + y\\text{|} \\leq \\text{|}x\\text{|} + \\text{|}y\\text{|}\\ (3.189)$$

Damit besitzt die Norm genau diejenigen Eigenschaften, die ich von einem mathematischen Längenbegriff erwarte.

## Definition 3.2.27: Abstand

Sobald eine Norm gegeben ist, kann ich auch einen Abstand zwischen zwei Vektoren definieren:

$$d(x,y) = \\text{|}x - y\\text{|}\\ (3.190)$$

Dabei sind

-   \\(x\\) und (y) die beiden betrachteten Vektoren,

-   (x-y) ihr Differenzvektor,

-   (d(x,y)) der durch die Norm bestimmte Abstand.

Diese Definition macht eine für die spätere Verwendung wichtige Trennung sichtbar:

**Vektorraum, Skalarprodukt, Norm und Abstand sind nicht dasselbe.**

Vielmehr entsteht eine strukturelle Kette:

$$\\text{Skalarprodukt} \\longrightarrow \\text{Norm} \\longrightarrow \\text{Abstand}\\ (3.191)$$

Diese Abhängigkeit ist für meine weitere Argumentation wichtig. Einen Abstand darf ich später nicht allein deshalb voraussetzen, weil ich Zustände als Vektoren darstelle.

## Cauchy-Schwarz-Ungleichung

Zwischen Skalarprodukt und Norm besteht ein grundlegender Zusammenhang. Für alle (x,y\\\\in V) gilt

$$\\left| \\left\\langle x,y \\right\\rangle \\right| \\leq \\text{|}x\\text{|}\\,\\text{|}y\\text{|}\\ (3.192)$$

Diese Cauchy-Schwarz-Ungleichung begrenzt den Betrag des Skalarprodukts durch das Produkt der beiden Vektorlängen. Sie ist insbesondere notwendig, um aus einem Skalarprodukt einen Winkelbegriff konsistent abzuleiten.

Für (x\\\\neq0) und (y\\\\neq0) folgt nämlich

$$- 1 \\leq \\frac{\\left\\langle x,y \\right\\rangle}{\\text{|}x\\text{|}\\,\\text{|}y\\text{|}} \\leq 1\\ (3.193)$$

Damit liegt der Quotient im Definitionsbereich der inversen Kosinusfunktion.

## Definition 3.2.28: Winkel zwischen zwei Vektoren

Für zwei von null verschiedene Vektoren (x) und (y) definiere ich den Winkel (\\\\theta) durch

$$\\cos\\theta = \\frac{\\left\\langle x,y \\right\\rangle}{\\text{|}x\\text{|}\\,\\text{|}y\\text{|}}\\ (3.194)$$

Dabei gilt

-   (x,y\\\\neq0),

-   (\\\\theta) ist der Winkel zwischen beiden Vektoren,

-   (\\\\langle x,y\\\\rangle) beschreibt ihre skalare Beziehung,

-   (\\|x\\|) und (\\|y\\|) normieren diese Beziehung auf die Längen der beiden Vektoren.

Für normierte Vektoren mit $|x| = |y| = 1$ vereinfacht sich Gleichung (3.194) zu

$$cos\\theta = \\langle x,y\\rangle\\ (3.195)$$

## Definition 3.2.29: Orthogonalität

Zwei Vektoren (x,y\\\\in V) heißen orthogonal, wenn ihr Skalarprodukt null ist:

$$x\\bot y\\quad \\Longleftrightarrow \\quad\\left\\langle x,y \\right\\rangle = 0\\ (3.196)$$

Für zwei von null verschiedene Vektoren bedeutet dies nach Gleichung (3.194), dass\\
$$\\cos\\theta = 0,$$

also ein rechter Winkel vorliegt.

Strang entwickelt Orthogonalität, Projektionen und orthogonale Basen zusammenhängend in Kapitel 4 \\[74\\]. Friedberg, Insel und Spence behandeln dieselbe Struktur in Kapitel 6 über Skalarprodukträume und orthogonale Komplemente \\[84\\].

## Satz des Pythagoras im Skalarproduktraum

Sind (x) und (y) orthogonal, gilt

$$\\text{|}x + y\\text{|}^{2} = \\text{|}x\\text{|}^{2} + \\text{|}y\\text{|}^{2}\\ (3.197)$$

Das kann ich unmittelbar aus dem Skalarprodukt herleiten:

$$\\begin{matrix}
\\text{|}x + y\\text{|}^{2} = \\langle x + y,x + y\\rangle \\\\
 = \\langle x,x\\rangle + 2\\langle x,y\\rangle + \\langle y,y\\rangle \\\\
 = \\text{|}x\\text{|}^{2} + \\text{|}y\\text{|}^{2}.
\\end{matrix}\\ (3.198)$$

Im letzten Schritt verwende ich (\\\\langle x,y\\\\rangle=0).

Damit ist der Satz des Pythagoras keine isolierte geometrische Besonderheit des zweidimensionalen Raums, sondern eine unmittelbare Folge der Orthogonalität in einem Skalarproduktraum.

## Definition 3.2.30: Normierter Vektor

Ein Vektor (x) heißt normiert, wenn

$$\\text{|}x\\text{|} = 1\\ (3.199)$$

Für jeden Vektor (x\\\\neq0) kann ich durch Division durch seine Norm einen normierten Vektor erzeugen:

$$\\widehat{x} = \\frac{x}{\\text{|}x\\text{|}}\\ (3.200)$$

Dabei bezeichnet

-   \\(x\\) den ursprünglichen Vektor,

-   (\\|x\\|) seine Norm,

-   (\\\\hat{x}) den normierten Vektor mit derselben Richtung.

Die Normierung verändert also die Richtung nicht. Sie entfernt lediglich die ursprüngliche Länge des Vektors.

## Definition 3.2.31: Orthonormale Vektoren

Eine Menge von Vektoren

$$q_{1},\\ldots,q_{m}$$

heißt orthonormal, wenn die Vektoren paarweise orthogonal und jeweils normiert sind. Beides kann ich kompakt durch

$$\\left\\langle q_{i},q_{j} \\right\\rangle = \\delta_{ij}\\ (3.201)$$

ausdrücken.

Dabei ist (δ\\_{ij}) das Kronecker-Delta mit den beiden Fällen

-   (δ\\_{ij}=1) für (i=j),

-   (δ\\_{ij}=0) für (i\\\\neq j).

Die beiden Werte sind lediglich die Definition der in Gleichung (3.201) verwendeten Größe (δ\\_{ij}) und werden deshalb nicht als eigenständige nummerierte Gleichungen geführt.

Für eine orthonormale Basis (q_1,\\\\ldots,q_n) kann ich jeden Vektor (x\\\\in V) eindeutig darstellen als

$$x = \\sum_{i = 1}^{n}{\\left\\langle q_{i},x \\right\\rangle q_{i}}\\ (3.202)$$

Die Koordinate des Vektors entlang der Basisrichtung (q_i) ist damit unmittelbar sein Skalarprodukt mit (q_i).

Diese Eigenschaft erklärt rückwirkend die in Abschnitt 3.2.11 verwendete Darstellung eines Vektors in einer orthonormalen Eigenbasis.

## Orthogonale Matrizen

Fasse ich eine orthonormale Basis spaltenweise in einer Matrix (Q) zusammen, dann gilt

$$Q^{T}Q = I\\ (3.203)$$

Damit folgt

$$Q^{- 1} = Q^{T}\\ (3.204)$$

Eine solche Matrix heißt orthogonal.

Orthogonale Transformationen erhalten das euklidische Skalarprodukt:

$$\\langle Qx,Qy\\rangle = \\langle x,y\\rangle\\ (3.205)$$

Daraus folgt unmittelbar die Erhaltung der Norm:

$$\\text{|}Qx\\text{|} = \\text{|}x\\text{|}\\ (3.206)$$

Damit erhalten orthogonale Transformationen Längen und Winkel. Sie verändern also die Koordinatendarstellung, nicht jedoch die durch das euklidische Skalarprodukt bestimmte Geometrie.

Diese Eigenschaft ist der Grund dafür, warum die orthogonale Diagonalisierung aus Abschnitt 3.2.11 mathematisch stärker ist als ein beliebiger Basiswechsel.

## Definition 3.2.32: Orthogonales Komplement

Sei (U\\\\subseteq V) ein Unterraum. Das orthogonale Komplement von (U) definiere ich als

$$U^{\\bot} = \\left\\{ x \\in V\\mid\\left\\langle x,u \\right\\rangle = 0\\text{ für alle }u \\in U \\right\\}\\ (3.207)$$

Dabei bezeichnet

-   \\(U\\) den ursprünglichen Unterraum,

-   (U\\^\\\\perp) sein orthogonales Komplement,

-   \\(u\\) einen beliebigen Vektor aus (U),

-   \\(x\\) einen Vektor, der zu jedem Vektor aus (U) orthogonal ist.

Im endlichdimensionalen reellen Skalarproduktraum kann ich den gesamten Raum in den Unterraum und sein orthogonales Komplement zerlegen:

$$V = U \\oplus U^{\\bot}\\ (3.208)$$

Damit besitzt jeder Vektor (x\\\\in V) eine eindeutige Zerlegung

$$x = u + u_{\\bot},\\quad\\quad u \\in U,\\quad u_{\\bot} \\in U^{\\bot}\\ (3.209)$$

Die Zerlegung in einen Anteil innerhalb eines Unterraums und einen dazu orthogonalen Anteil bildet die Grundlage der orthogonalen Projektion. Friedberg, Insel und Spence führen orthogonale Komplemente und den Gram-Schmidt-Prozess gemeinsam in §6.2 sowie orthogonale Projektionen in §6.6 \\[84\\].

## Definition 3.2.33: Orthogonale Projektion auf einen Vektor

Sei (u\\\\neq0). Die orthogonale Projektion eines Vektors (x) auf die von (u) aufgespannte Richtung ist

$$proj_{u}(x) = \\frac{\\left\\langle x,u \\right\\rangle}{\\left\\langle u,u \\right\\rangle}u\\ (3.210)$$

Dabei sind

-   \\(x\\) der zu projizierende Vektor,

-   (u\\\\neq0) die Projektionsrichtung,

-   (\\\\langle x,u\\\\rangle/\\\\langle u,u\\\\rangle) der skalare Projektionsfaktor,

-   (\\\\text{proj}\\_{u}(x)) der auf (u) liegende Anteil von (x).

Ist (u) bereits normiert, also (\\|u\\|=1), vereinfacht sich die Projektion zu

$$\\text{proj}_{u}(x) = \\left\\langle x,u \\right\\rangle u\\ (3.211)$$

Strang behandelt Projektionen ausdrücklich in §4.2 \\[74\\].

## Projektion auf einen Unterraum

Besitzt ein Unterraum (U) eine orthonormale Basis $q_{1},\\ldots,q_{m},$ dann kann ich die orthogonale Projektion eines Vektors (x) auf (U) als Summe seiner Projektionen auf die einzelnen Basisrichtungen schreiben:

$$P_{U}x = \\sum_{i = 1}^{m}{\\left\\langle q_{i},x \\right\\rangle q_{i}}\\ (3.212)$$

Dabei bezeichnet (P_U) den orthogonalen Projektionsoperator auf (U).

Schreibe ich die orthonormalen Basisvektoren als Spalten einer Matrix (Q), dann gilt

$$P_{U} = QQ^{T}\\ (3.213)$$

Damit kann ich die Projektion eines Vektors auch schreiben als

$$P_{U}x = QQ^{T}x\\ (3.214)$$

Der Projektionsoperator besitzt zwei charakteristische Eigenschaften:

$$P_{U}^{2} = P_{U}\\ (3.215)$$

und

$$P_{U}^{T} = P_{U}\\ (3.216)$$

Die erste Eigenschaft bedeutet, dass eine erneute Projektion eines bereits projizierten Vektors nichts mehr verändert. Die zweite Eigenschaft zeigt, dass der orthogonale Projektor im reellen euklidischen Raum symmetrisch ist.

## Orthogonale Zerlegung eines Vektors

Mit dem Projektionsoperator kann ich Gleichung (3.209) präzisieren:

$$x = P_{U}x + \\left( I - P_{U} \\right)x\\ (3.217)$$

Dabei gilt

-   (P_Ux\\\\in U),

-   ((I-P_U)x\\\\in U\\^\\\\perp).

Diese beiden Angaben beschreiben die Bestandteile von Gleichung (3.217) und werden nicht als zusätzliche Gleichungen nummeriert.

Außerdem sind beide Komponenten orthogonal:

$$\\left\\langle P_{U}x,\\left( I - P_{U} \\right)x \\right\\rangle = 0\\ (3.218)$$

Damit zerlege ich einen beliebigen Vektor eindeutig in einen Anteil innerhalb des Unterraums und einen dazu senkrechten Rest.

## Gram-Schmidt-Orthogonalisierung

Eine beliebige linear unabhängige Basis ist im Allgemeinen nicht orthogonal. Ich kann sie jedoch systematisch in eine orthonormale Basis desselben Unterraums überführen. Dieses Verfahren ist die Gram-Schmidt-Orthogonalisierung \\[74, 84\\]. Strang behandelt sie ausdrücklich in §4.4, Friedberg, Insel und Spence in §6.2.

Seien $v_{1},\\ldots,v_{m}$ linear unabhängige Vektoren.

Ich beginne mit

$$u_{1} = v_{1}\\ (3.219)$$

Für den zweiten Vektor entferne ich aus (v_2) den Anteil in Richtung von (u_1):

$$u_{2} = v_{2} - \\frac{\\left\\langle v_{2},u_{1} \\right\\rangle}{\\left\\langle u_{1},u_{1} \\right\\rangle}u_{1}\\ (3.220)$$

Allgemein erhalte ich

$$u_{k} = v_{k} - \\sum_{j = 1}^{k - 1}{\\frac{\\left\\langle v_{k},u_{j} \\right\\rangle}{\\left\\langle u_{j},u_{j} \\right\\rangle}u_{j}}\\ (3.221)$$

Die so erzeugten Vektoren (u_1,\\\\ldots,u_m) sind paarweise orthogonal.

Durch anschließende Normierung

$$q_{k} = \\frac{u_{k}}{\\text{|}u_{k}\\text{|}}\\ (3.222)$$

erhalte ich eine orthonormale Basis (q_1,\\\\ldots,q_m).

Dabei bleibt der aufgespannte Unterraum erhalten:

$$\\text{span}\\text{\\{}v_{1},\\ldots,v_{m}\\text{\\}} = \\text{span}\\text{\\{}q_{1},\\ldots,q_{m}\\text{\\}}\\ (3.223)$$

Das Verfahren verändert damit nicht den betrachteten Unterraum. Es ersetzt lediglich eine beliebige linear unabhängige Basis durch eine geometrisch günstigere orthonormale Basis.

## Zusammenhang mit der Spektralzerlegung

Damit kann ich nun die in Abschnitt 3.2.11 verwendete Spektralzerlegung mathematisch genauer verstehen.

Besitzt eine reelle symmetrische Matrix (A) eine orthonormale Eigenbasis (q_1,\\\\ldots,q_n), dann gilt für jeden Vektor (x)

$$x = \\sum_{i = 1}^{n}{\\left\\langle q_{i},x \\right\\rangle q_{i}}\\ (3.224)$$

Wegen der Eigenwertbeziehung (Aq_i=\\\\lambda_iq_i) folgt

$$Ax = \\sum_{i = 1}^{n}{\\lambda_{i}\\left\\langle q_{i},x \\right\\rangle q_{i}}\\ (3.225)$$

Damit wird sichtbar, dass die Spektralzerlegung auf drei mathematischen Strukturen beruht:

-   der Zerlegung eines Vektors in orthogonale Komponenten,

-   der Projektion auf die Eigenrichtungen,

-   der Skalierung jeder Komponente mit ihrem Eigenwert.

Die in Abschnitt 3.2.11 verwendeten Projektoren (q_iq_i\\^T) erhalten damit ebenfalls eine unmittelbare geometrische Bedeutung: Sie projizieren einen Vektor auf die jeweilige eindimensionale Eigenrichtung.

## Beispiel im (ℝ\\^{2})

Ich betrachte die beiden Vektoren\\
$$x = \\begin{pmatrix}
3 \\\\
4
\\end{pmatrix},\\quad\\quad y = \\begin{pmatrix}
 - 4 \\\\
3
\\end{pmatrix}.$$

Diese Angaben definieren lediglich die im Beispiel verwendeten Vektoren und erhalten keine eigenen Gleichungsnummern.

Das Skalarprodukt ergibt

# \\\\langle x,y\\\\rangle

$$\\left\\langle x,y \\right\\rangle = 3( - 4) + 4(3) = 0\\ (3.226)$$

Damit gilt

$$x\\bot y\\ (3.227)$$

Die Norm von (x) ist

$$\\text{|}x\\text{|} = \\sqrt{3^{2} + 4^{2}} = 5\\ (3.228)$$

Für (y) erhalte ich ebenfalls

$$\\text{|}y\\text{|} = \\sqrt{( - 4)^{2} + 3^{2}} = 5\\ (3.229)$$

Die normierten Vektoren lauten damit gemeinsam

$$\\widehat{x} = \\begin{pmatrix}
3\\text{/}5 \\\\
4\\text{/}5
\\end{pmatrix},\\quad\\quad\\widehat{y} = \\begin{pmatrix}
 - 4\\text{/}5 \\\\
3\\text{/}5
\\end{pmatrix}\\ (3.230)$$

Damit bilden (\\\\hat{x}) und (\\\\hat{y}) eine orthonormale Basis des (ℝ\\^{2}).

## Ein allgemeineres Skalarprodukt

Die euklidische Form (x\\^Ty) ist nicht die einzige Möglichkeit, auf (ℝ\\^{n}) ein Skalarprodukt einzuführen.

Sei (G) eine reelle symmetrische positiv definite Matrix. Dann kann ich definieren

$$\\left\\langle x,y \\right\\rangle_{G} = x^{T}Gy\\ (3.231)$$

Dabei sind

-   \\(G\\) die Matrix, die das Skalarprodukt bestimmt,

-   \\(x\\) und (y) die betrachteten Vektoren,

-   (\\\\langle x,y\\\\rangle_G) das durch (G) definierte Skalarprodukt.

Die zugehörige Norm lautet

$$\\text{|}x\\text{|}_{G} = \\sqrt{x^{T}Gx}\\ (3.232)$$

Damit wird ein für die spätere Theorie entscheidender Punkt sichtbar:

**Die geometrische Struktur hängt von der Wahl des Skalarprodukts ab.**

Zwei Vektoren können bezüglich eines Skalarprodukts orthogonal sein und bezüglich eines anderen nicht. Ebenso können sich ihre Normen ändern.

Genau deshalb darf ich in einer späteren FRZK-Struktur das euklidische Skalarprodukt nicht stillschweigend voraussetzen. Sollte das FRZK eine eigene geometrische oder funktionale Struktur benötigen, muss die entsprechende bilineare Form beziehungsweise Metrik ausdrücklich definiert oder aus den Axiomen hergeleitet werden.

## Methodologische Betrachtungen

Methodologisch ist für mich die Trennung zwischen algebraischer und geometrischer Struktur in diesem Abschnitt besonders wichtig.

Ein Vektorraum allein besitzt keine natürliche Länge. Er besitzt auch keinen natürlichen Winkel und keine natürliche Orthogonalität. Diese Begriffe entstehen erst, wenn ich zusätzliche Struktur einführe.

Damit ergibt sich eine Hierarchie:

$$\\text{Vektorraum} \\longrightarrow \\text{Skalarproduktraum} \\longrightarrow \\text{Norm} \\longrightarrow \\text{Abstand und Winkel}\\ (3.233)$$

Diese Hierarchie verhindert einen später problematischen Schluss: Aus einer Vektordarstellung darf ich nicht automatisch auf eine physikalische Geometrie schließen.

Dasselbe gilt für Orthogonalität. Die Aussage $\\left\\langle x,y \\right\\rangle = 0$ ist immer relativ zu dem verwendeten Skalarprodukt zu verstehen. Ändere ich das Skalarprodukt, kann sich auch ändern, welche Vektoren orthogonal sind.

Für das FRZK bedeutet dies, dass eine später verwendete Aussage wie „zwei Zustände sind orthogonal" nur dann mathematisch vollständig ist, wenn zuvor geklärt wurde, bezüglich welcher inneren Struktur diese Orthogonalität gilt.

Ebenso muss ich zwischen Norm und physikalischer Größe unterscheiden. Eine mathematische Norm ist zunächst lediglich eine Abbildung, die bestimmte Axiome erfüllt. Ob sie später beispielsweise einen räumlichen Abstand, eine Zustandsabweichung, eine Kohärenzdifferenz oder eine andere physikalische Größe beschreibt, kann nicht aus dem Begriff „Norm" selbst abgeleitet werden.

Diese methodologische Zurückhaltung ist für den Aufbau des FRZK notwendig. Ich möchte mathematische Werkzeuge bereitstellen, ohne ihnen vorzeitig eine physikalische Bedeutung zuzuschreiben.

## Didaktische Betrachtungen

Für mich lässt sich das Skalarprodukt zunächst sehr anschaulich über zwei Fragen verstehen:

**Wie lang ist ein Vektor?** und **Wie stark zeigen zwei Vektoren in dieselbe Richtung?**

Die erste Frage führt zur Norm. Die zweite führt zum Skalarprodukt.

Sind zwei Vektoren gleichgerichtet, ist ihr normiertes Skalarprodukt positiv. Sind sie entgegengesetzt gerichtet, ist es negativ. Stehen sie senkrecht aufeinander, verschwindet das Skalarprodukt.

Dadurch kann ich mir $\\left\\langle x,y \\right\\rangle = 0$ zunächst als algebraischen Test für einen rechten Winkel vorstellen.

Noch wichtiger ist für mich die Projektion. Wenn ich einen Vektor (x) auf eine Richtung (u) projiziere, frage ich:

**Welcher Anteil von (x) liegt tatsächlich in Richtung (u)?**

Das Skalarprodukt liefert genau den dafür benötigten skalaren Anteil.

Bei einer orthonormalen Basis wird diese Vorstellung besonders einfach. Jeder Vektor lässt sich in voneinander unabhängige senkrechte Komponenten zerlegen. Das Skalarprodukt mit einem Basisvektor liefert unmittelbar die zugehörige Koordinate.

Damit ergibt sich für mich die anschauliche Kette

$$\\text{Skalarprodukt} \\longrightarrow \\text{Länge und Winkel} \\longrightarrow \\text{Orthogonalität} \\longrightarrow \\text{Projektion} \\longrightarrow \\text{orthonormale Zerlegung}\\ (3.234)$$

Die Gram-Schmidt-Orthogonalisierung zeigt schließlich, dass ich eine ungünstige, schiefwinklige Basis nicht einfach hinnehmen muss. Solange die Ausgangsvektoren linear unabhängig sind, kann ich aus ihnen schrittweise eine orthonormale Basis desselben Unterraums konstruieren \\[74, 84\\].

Für mich ist das auch geometrisch verständlich: Von jedem neuen Basisvektor ziehe ich diejenigen Anteile ab, die bereits in den zuvor erzeugten Richtungen enthalten sind. Übrig bleibt genau der neue, zu allen vorherigen Richtungen orthogonale Anteil. Anschließend normiere ich ihn.

## Ergebnis und Übergang

Mit dem Skalarprodukt habe ich den bisher rein algebraisch behandelten Vektorräumen eine zusätzliche geometrische Struktur gegeben. Aus dem Skalarprodukt konnte ich Norm, Abstand und Winkel ableiten. Orthogonalität lässt sich durch das Verschwinden des Skalarprodukts charakterisieren, und orthonormale Basen ermöglichen eine besonders einfache Zerlegung von Vektoren \\[74, 84\\].

Mit orthogonalen Projektionen kann ich einen Vektor eindeutig in einen Anteil innerhalb eines Unterraums und einen dazu orthogonalen Anteil zerlegen. Die Gram-Schmidt-Orthogonalisierung erlaubt mir wiederum, aus jeder linear unabhängigen endlichen Vektormenge eine orthonormale Basis ihres aufgespannten Unterraums zu erzeugen \\[74, 84\\].

Damit ist zugleich die geometrische Grundlage der zuvor behandelten orthogonalen Spektralzerlegung präzisiert. Die dort auftretenden Eigenprojektoren sind keine bloßen formalen Matrixprodukte, sondern orthogonale Projektionsoperatoren auf die entsprechenden Eigenrichtungen beziehungsweise Eigenräume.

Für die weitere mathematische Grundlage reicht es jedoch nicht aus, nur endlichdimensionale euklidische Räume zu betrachten. Für funktionale Beschreibungen muss ich den Begriff des Skalarproduktraums auf Räume von Funktionen übertragen. Dadurch gelange ich zu Hilberträumen und damit zu einer Struktur, in der Funktionen selbst als Vektoren behandelt, normiert, auf Orthogonalität untersucht und bezüglich geeigneter Basissysteme zerlegt werden können.

Der folgende Abschnitt behandelt deshalb **3.2.13 Funktionenräume, (L\\^2)-Strukturen und Hilberträume**.

**Fortsetzungsstand:** Abschnitt **3.2.12 endet mit Gleichung (3.234)**. Abschnitt **3.2.13 beginnt mit Gleichung (3.235)**.

Für das folgende Repository-Skript sind damit **\\[74\\]** und die neue Literaturstelle **\\[84\\]** zu erfassen. Für \\[74\\] sind insbesondere §1.2, §4.2 und §4.4 als verifizierte source_usage-Bereiche verfügbar; für \\[84\\] sind §6.1, §6.2 und §6.6 durch das reale Inhaltsverzeichnis verifiziert. Wo der konkrete Quellentext nicht zugänglich verifiziert wurde, darf im SQL **kein erfundener source_excerpt** eingetragen werden.

#
```


## 20. Literaturverwendung im neuen Haupttext

Die Deep-Research-Matrix oben bezieht sich auf die Quellfassung und deren Verwendungskontexte. Bei der Neufassung muss jede Literaturverwendung erneut dem **neuen Claim und neuen Zielabschnitt** zugeordnet werden. Ein alter Evidence-Eintrag darf wiederverwendet werden, wenn der neue Claim inhaltlich nicht weiter reicht als die belegte Aussage. Andernfalls ist neue Deep Research erforderlich.

Empfohlen wird, neue Haupttextverwendungen über `source_usage` und eine versionierte Zuordnung zum finalen `section_version` zu speichern. Falls `source_usage` nach den Anlagen noch ausschließlich `section_id` kennt, soll die neueste DB um eine eindeutige Versionszuordnung erweitert werden, damit Quellfassung und Neufassung nicht in denselben Usage-Datensätzen vermischt werden.

## 21. Abschnittsversionierung und Freigabe

Für jeden neuen 3.2.x-Abschnitt gilt:

1. vollständiger Text direkt im Chat;
2. Repository-SQL separat als Datei;
3. neuer `repository_revisions`-Eintrag;
4. vollständiger Abschnitt in `section_versions.body_markdown`;
5. SHA-256 in `section_versions.checksum_sha256`;
6. kanonische Register aktualisieren;
7. Literatur-/Evidence-Links aktualisieren;
8. Main-Text-Placement und Section-Lineage aktualisieren;
9. Gates ausführen;
10. erst bei PASS mit dem nächsten Abschnitt fortfahren.

## 22. Gate 3.2 → 3.3

Kapitel 3.2 ist erst abgeschlossen, wenn mindestens folgende Bedingungen erfüllt sind:
- Alle vorgesehenen Haupttextabschnitte 3.2.0–3.2.7 besitzen eine finale Version.
- Alle im Haupttext verwendeten Definitionen/Sätze/Gleichungen sind kanonisch registriert und validiert.
- Alle Gleichungen besitzen Word-LaTeX.
- Keine reine Herleitung oder Beispielrechnung ist versehentlich in den Haupttext zurückgewandert.
- Jeder Anlagenverweis löst auf eine finale reale Anlagenstelle auf.
- Jede Literaturverwendung ist evidenzgedeckt.
- Alle Haupttextobjekte besitzen eine nachvollziehbare Placement-/Lineage-Beziehung.
- Alle für 3.3 benötigten Objekte besitzen eine konkrete `required_for_section_code`-Zuordnung; soweit die finale 3.3-Struktur bekannt ist, ist `3.3` auf `3.3.x` zu präzisieren.
- Keine offene kritische Revision-Issue.
- Repository-SQL wurde tatsächlich gegen die maßgebliche rekonstruierte Testdatenbank beziehungsweise ein äquivalentes Testschema ausgeführt und die Post-Gates sind PASS.
- Ein neuer Enddump Ende 3.2 wurde erzeugt und als Übergabebasis zu 3.3 verifiziert.

## 23. Was der Haupttext-Chat ausdrücklich nicht tun darf

- die Anlagen M1–M6 neu schreiben oder deren finalen Inhalt ohne Not duplizieren;
- Beispiele oder lange Standardherleitungen zurück in den Haupttext ziehen;
- Quellnummern und neue kanonische Nummern gleichsetzen;
- vorläufige Revision-5-Anlagenanker als final behaupten;
- Literaturbelege aus bloßer thematischer Nähe erfinden;
- Direktzitate erzeugen, wenn kein Originaltext verifiziert wurde;
- FRZK-Axiome in Kapitel 3.2 vorwegnehmen;
- alte Chat-/Arbeitsreste oder Hinweise auf den Überarbeitungsprozess in die Dissertation übernehmen;
- SQL nur statisch prüfen und als getestet ausgeben;
- ein Gate als PASS deklarieren, wenn die Testausführung nicht tatsächlich erfolgt ist.

## 24. Startpunkt des späteren Haupttext-Chats

Nach erfolgreicher Prüfung der realisierten Anlagen beginnt der Chat mit **3.2.0**. Der erste Arbeitsschritt ist nicht das Schreiben eines langen Mathematiküberblicks, sondern die verbindliche Festlegung des komprimierten mathematischen Hauptpfads, der Abgrenzung zu M1–M6 und des Übergangs von Kapitel 3.1 zur späteren Axiomatik in Kapitel 3.3.

Danach gilt das Weiter-Skript-Verfahren Abschnitt für Abschnitt.
