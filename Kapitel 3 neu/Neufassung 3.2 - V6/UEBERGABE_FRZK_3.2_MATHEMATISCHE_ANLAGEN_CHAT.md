# Übergabe – FRZK Kapitel 3.2: separater Chat ausschließlich für mathematische Anlagen M1–M6

**Stand:** 30.08.2026  
**Projekt:** FRZK / Dissertation / Kapitel 3.2  
**Zweck dieser Datei:** Diese Datei ist die verbindliche Arbeits- und Übergabegrundlage für einen eigenen Chat, der ausschließlich die mathematischen Anlagen zu Kapitel 3.2 erstellt, pflegt, prüft und repository-konform fortschreibt.

> **Verbindliche Scope-Regel:** Dieser Chat schreibt **nicht** den Haupttext von Kapitel 3.2 und **nicht** Kapitel 3.3. Er bearbeitet ausschließlich mathematische Anlageninhalte, die gemäß Datenbankprofil `document_location='appendix'` zugeordnet sind. Er darf Haupttextobjekte nur als Kontext oder Referenz lesen, nicht in die Anlage verschieben, umnummerieren oder fachlich verändern, solange keine neue DB-Revision diese Klassifikation ausdrücklich ändert.

## 1. Startanweisung für den Anlagen-Chat

Der neue Chat soll diese Datei beim Start vollständig als verbindliche Projektanweisung behandeln. Zusätzlich ist die aktuelle SQL-Gesamtdatenbank hochzuladen. Falls die SQL-Datei fehlt oder ein anderer SHA-256 vorliegt, darf der Chat keine kanonischen Änderungen an den Anlagen vornehmen, sondern muss zunächst die Repository-Konsistenz feststellen.

### Verbindliche Arbeitsprinzipien

- Die mathematische und inhaltliche Substanz von Kapitel 3.2 darf durch die Auslagerung **nicht reduziert oder verändert** werden. Die Anlagen übernehmen Vertiefungen, Herleitungen, Beweisschritte, Beispiele und unterstützende Definitionen/Gleichungen.
- Die im Haupttext verbleibenden mathematischen Kernaussagen werden nicht in den Anlagen dupliziert. Anlagen dürfen auf sie verweisen und sie erläutern.
- Klassische Mathematik wird nicht als FRZK-Eigenleistung bezeichnet. Originäre FRZK-Eigenleistungen sind nur dort als solche zu kennzeichnen, wo tatsächlich neue FRZK-spezifische Setzungen entstehen; die mathematischen Anlagen M1–M6 dienen primär der etablierten mathematischen Grundlegung.
- Mathematische Fehler, Nummerierungsfehler oder Literaturkonflikte werden niemals stillschweigend korrigiert. Sie sind als `revision_issues` zu registrieren und erst in einer nachvollziehbaren Revision zu beheben.
- Fließtext der Anlagen wird vollständig im normalen Chat ausgegeben. SQL-/Repository-Skripte werden **nicht vollständig im Chat** ausgegeben, sondern ausschließlich als herunterladbare `.sql`-Datei.
- Schreibstil: wissenschaftliche Ich-Form, logisch verbundene Absätze, keine Häufung alleinstehender Sätze. Didaktische Erläuterungen dürfen ausführlich sein, aber nicht in einen lehrbuchhaften Fremdstil wechseln.
- Im Dissertationstext stehen keine Weblinks oder URLs. Technische URLs dürfen ausschließlich in der Repository-/Research-Schicht gespeichert werden.
- Literaturangaben im Fließtext folgen der aktuellen FRZK-Regel `([genaue bibliografische Quelle])`; die technische Literaturziffer `[n]` bleibt zusätzlich als Repository-Schlüssel erhalten.
- Jede gerenderte Formel/Gleichung erhält **unmittelbar in der nächsten Zeile** `Word-LaTeX: ...`. Im Fließtext werden Formelbestandteile nicht gerendert, sondern in runden Klammern als Word-LaTeX geschrieben.
- Beispiele und vollständige Herleitungen dürfen in den Anlagen ausführlich sein; Anwendungen des FRZK gehören weiterhin nicht hierher, sondern in Kapitel 6.
- Deep Research: Ein wörtlicher Quellenauszug wird nur gespeichert/verwendet, wenn der Originaltext tatsächlich überprüft wurde. Andernfalls werden exakte Fundstelle und verifizierte Paraphrase gespeichert; niemals ein erfundener `source_excerpt`.

## 2. Verbindliche Dateien und Identitätsprüfung

| Datei | Funktion | SHA-256 |
|---|---|---|
| `frzk_rkb_32_neu_konform_ende_3.1_mit_anlagenprofil.sql` | **führende Gesamtdatenbank** Ende 3.1 + 3.2-Staging + Deep Research + Anlagenprofil | `111e62c6022f2697e7c43dc980696893c19c2aa6d3747f8b0c7b756ebafdd896` |
| `frzk_rkb_stand_ende_3.1.sql` | historische Basisschicht Ende 3.1 | `b2942f291e2e136f312aa43849a046be23984a2883f2c8424382d91b8ee6b119` |
| `3.2 Mathematische Grundlagen_V2.docx` | Quellfassung 3.2, nur als Ausgangs-/Vergleichsbestand | `2eb3973c5cfe642020c033f00b9fdebff71bafdc67ef54d8576baadd2c6c983e` |
| `K32_Haupttext_Anlagen_DB_Profil.md` | Kurzprofil der bereits vorgenommenen Klassifikation | `93e1179af350d66eca16e561611b3b24e583364671af6f502e6c039bfa21de11` |

Die **führende** technische Quelle ist ausschließlich die erstgenannte Gesamtdatenbank. Frühere 3.2-SQL-Fassungen dürfen nicht als konkurrierende Baseline verwendet werden.

## 3. Repository- und Revisionsstand

Die Datenbank heißt `frzk_rkb_32_neu`. Der Repository-Stand Ende 3.1 bleibt vollständige Basisschicht; die 3.2-Entwicklung wird revisionsweise darauf aufgebaut.

| Revision | Code | Zweck |
|---:|---|---|
| 1 | `CH3.1-LIT-20260809` | Deduplizierte Literatur, korrigierte Erstnennungen, Source-Usage-Matrix und Abschnittsstruktur Kapitel 3.1. Gleichungen gemäß leerem equations-Bestand nicht erfunden. |
| 2 | `RKB32-NEW-BASELINE-2026-08-29` | Quellimport der aktuellen Fassung von Kapitel 3.2 als Staging-Bestand. Die kanonischen Register des 3.1-Repositories bleiben führend; noch nicht redaktionell freigegebene Definitionen, Satzkandidaten und Gleichungen werden getrennt als Kandidaten geführt. |
| 3 | `RKB32-DEEP-RESEARCH-SOURCES-2026-08-29` | Deep-Research-Prüfung der Literaturverwendungen von Kapitel 3.2 mit abschnittsspezifischen Fundstellen, Belegparaphrasen, selektiven verifizierten Kurzzitaten und Auflösung der provisorischen Ziffern [10] und [13]. |
| 4 | `RKB32-CONFORM-31-2026-08-29` | Konformitätsmigration: Der Repository-Stand Ende 3.1 bleibt vollständige Basisschicht. Kapitel 3.2 ergänzt die bestehenden Register, ohne Tabellen, IDs, Quellen oder Auditstrukturen aus 3.1 zu verwerfen. |
| 5 | `RKB32-MATH-APPENDIX-PROFILE-2026-08-30` | Einführung einer normalisierten Dokumentort-, Bedeutung- und Anforderungsstruktur für mathematische Objekte. Ziel: Kapitel 3.2 argumentativ straffen, ohne mathematische Inhalte zu verlieren; ausgelagerte Inhalte bleiben über Anlagenanker vollständig referenzierbar. |

Für die Anlagenklassifikation ist insbesondere Revision **5** (`RKB32-MATH-APPENDIX-PROFILE-2026-08-30`) maßgeblich. Neue Anlagenarbeit beginnt mit einer neuen Revision ab ID 6 beziehungsweise mit dem aktuellen `AUTO_INCREMENT`, wenn zwischenzeitlich weitere Revisionen hinzugekommen sind.

## 4. Aktueller mathematischer Objektbestand

- Mathematische Objekte insgesamt: **275**
- Haupttextobjekte: **131**
- Anlagenobjekte: **144**
- Bedeutung: `core` **93**, `supporting` **118**, `derivation` **44**, `example` **20**
- Gleichungsrollen: `canonical` **104**, `derived` **69**, `proof_step` **40**, `example` **20**
- Kandidatenregister: **33 Definitionen**, **9 Satz-/Ergebniskandidaten**, **233 Gleichungskandidaten**
- Deep-Research-Schicht: **17 recherchierte Quellenregister**, **52 Quellenverwendungen mit Evidenz**, **353 einzelne Zitationsvorkommen**

### Semantik der Klassifikationsfelder

#### `document_location`
- `main_text`: Objekt gehört in den argumentativen mathematischen Hauptpfad von Kapitel 3.2.
- `appendix`: Objekt bleibt mathematisch vollständig erhalten, wird aber in M1–M6 ausgearbeitet.

#### `importance_level`
- `core`: unverzichtbare kanonische Struktur für den Hauptpfad.
- `supporting`: fachlich notwendige Vertiefung oder ergänzende Definition.
- `derivation`: Herleitung/Beweis-/Ableitungsschritt.
- `example`: Rechen- oder Anschauungsbeispiel.

#### `equation_role` – nur für Gleichungen
- `canonical`: kanonische mathematische Aussage/Definition.
- `derived`: abgeleitete bzw. unterstützende Beziehung.
- `proof_step`: Bestandteil einer Herleitung/eines Beweises.
- `example`: Gleichung eines Beispiels.

#### `appendix_anchor`
Der `appendix_anchor` ist der **stabile technische Referenzanker** eines ausgelagerten Objekts, z. B. `M2-DEF-007` oder `M5-GL-137`. Er darf nicht ohne DB-Revision geändert werden. Eine spätere sichtbare Nummerierung im Dissertationstext ist von diesem technischen Anker zu trennen.

## 5. Anlagenmodule

| Modul | Titel | Zweck | Objekte |
|---|---|---|---:|
| **M1** | Mengentheoretische und funktionale Grundlagen | Vertiefungen zu Mengen, Relationen, Funktionen, Mengenoperationen, Funktionsklassen und Beispielen. | **26** |
| **M2** | Algebraische Grundlagen des Vektorraums | Vektorraumaxiome, Nullvektor, Untervektorräume, Herleitungen, Erzeugungssysteme und Rechenbeispiele. | **26** |
| **M3** | Matrizen, Basiswechsel und Invarianten | Matrixdarstellungen, Basiswechselkonstruktionen, Determinantenrechnungen und Darstellungsinvarianten. | **14** |
| **M4** | Rang, Kern, Bild und lineare Gleichungssysteme | Vertiefungen zu Rangbestimmung, Kern/Bild, Rang-Nullität und linearen Gleichungssystemen. | **6** |
| **M5** | Eigenwerte, Diagonalisierung und Spektralrechnung | Eigenwertrechnungen, Vielfachheiten, Diagonalisierungsbeispiele, Matrixfunktionen und Projektorzerlegungen. | **30** |
| **M6** | Skalarprodukt, Orthogonalität, Projektion und Hilbertraumstrukturen | Geometrische Vertiefungen, Cauchy-Schwarz, Winkel, Gram-Schmidt, Projektionen und Funktionenraum/Hilbertraum-Anschluss. | **42** |

### Inhaltliche Grenzen

**M1** enthält die ausgelagerten mengentheoretischen und funktionalen Vertiefungen. **M2** bündelt Vektorraumaxiome, Nullvektor, Untervektorräume, Abhängigkeit und Rechen-/Herleitungsdetails. **M3** übernimmt Matrixdarstellung, Basiswechsel, Determinantenrechnungen und Invarianten. **M4** behandelt die vertiefte Rang-/Kern-/Bild-Rechnung und lineare Gleichungssysteme. **M5** enthält Eigenwertrechnungen, Vielfachheiten, Diagonalisierungs- und Spektralrechnungen. **M6** trägt die geometrischen Vertiefungen zu Skalarprodukt, Norm, Winkel, Cauchy-Schwarz, Orthogonalität, Projektion, Gram-Schmidt und dem Funktionenraum-/Hilbertraum-Anschluss.

## 6. Verbindlicher Arbeitsablauf im Anlagen-Chat

1. **Repository lesen und Gate prüfen.** Vor jedem Schreibschritt werden `v_math_compression_gate`, offene `revision_issues` und das Inventar des gewünschten Moduls geprüft.
2. **Nur Anlagenobjekte laden.** Ausgangsliste ist `v_math_appendix_inventory WHERE appendix_code='Mx'`. Haupttextobjekte werden nur als Kontext gelesen.
3. **Quellpayload auflösen.** Über `repository_objects.source_table` und `source_pk` wird der jeweilige Datensatz aus `definition_candidates`, `statement_candidates` oder `equation_candidates` gelesen.
4. **Literaturbeleg zuordnen.** Aussagen mit Literaturbezug werden gegen `source_usage` → `source_research_evidence` sowie `citation_resolutions`/`citation_evidence_links` geprüft. Keine unbelegte Literaturformulierung.
5. **Anlagentext schreiben.** Der Inhalt darf ausführlicher und didaktischer sein als der Haupttext, darf aber keine neue fachliche Aussage einschleusen, die nicht entweder etabliert belegt oder als neue, ausdrücklich autorisierte FRZK-Eigenleistung gekennzeichnet ist.
6. **Formelregeln anwenden.** Jede gerenderte Formel erhält direkt darunter die Word-LaTeX-Zeile; im Fließtext nur Word-LaTeX in runden Klammern.
7. **SQL-Revisionsskript erzeugen.** Nach jedem freigegebenen Anlagenabschnitt entsteht ein SQL-Patch mit neuer `repository_revision`, Status-/Text-/Objektupdates, Literaturverknüpfungen und Post-Gates. Das Skript wird getestet, soweit eine rekonstruierbare DB-Laufzeit verfügbar ist.
8. **Keine voreilige Kanonisierung.** Kandidaten werden erst nach fachlicher Freigabe in die kanonischen Register übernommen. Bis dahin bleibt `object_scope='candidate'` beziehungsweise der Kandidatenstatus erhalten.
9. **Weiter-Skript-Verfahren.** Text und Repository-Schritt werden nacheinander abgeschlossen. Erst nach bestandenem Gate wird mit dem nächsten Anlagenabschnitt fortgefahren.

### Empfohlene SQL-Abfragen

```sql
SELECT * FROM v_math_compression_gate;

SELECT *
FROM v_math_appendix_inventory
WHERE appendix_code = 'M1'
ORDER BY appendix_anchor;

SELECT *
FROM revision_issues
WHERE issue_status IN ('open','in_progress')
ORDER BY FIELD(severity,'critical','high','medium','low','info'), issue_id;

SELECT sre.*, s.citation_number, s.full_citation_text
FROM source_research_evidence sre
JOIN sources s ON s.source_id = sre.canonical_source_id
ORDER BY sre.source_usage_id, sre.evidence_id;
```

## 7. DB-Modell – zentrale Anlagenlogik

Die nachfolgenden Tabellen sind bereits in der führenden Datenbank vorhanden und verbindlich.

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

## 8. DB-Modell – Kandidatenregister

Die Quellfassung von Kapitel 3.2 ist **Staging-Bestand**. Die mathematischen Objekte werden bis zur Freigabe in Kandidatentabellen geführt.

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

### Kandidatenregel

- `source_*` enthält den importierten Zustand aus der Quellfassung.
- `proposed_*` enthält die redaktionell vorgeschlagene Neufassung.
- `word_latex` muss für eine freizugebende Formel vorhanden sein.
- `provenance` darf nicht ohne Begründung auf `original` gesetzt werden.
- `candidate_status`/`classification_status` wird nur revisionsgesichert verändert.
- `source_integrity_status` bei Gleichungen bleibt sichtbar; ein beschädigtes Quellobjekt darf nicht durch stilles Überschreiben „verschwinden“.

## 9. DB-Modell – Literatur, Zitate und Deep Research

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

### Literaturregeln

- `source_research_registry` verifiziert die bibliografische Identität.
- `source_research_evidence` belegt die **konkrete Verwendung**. `support_fit='partial'` darf nicht als Vollbeleg dargestellt werden.
- `evidence_mode='direct_quote'` setzt einen tatsächlich geprüften Originaltext voraus.
- Bei `location_paraphrase` wird nicht so formuliert, als läge ein wörtliches Zitat vor.
- `citation_resolutions` bewahrt historische Ziffern und ihre kanonische Auflösung. Die bereits dokumentierten provisorischen Zuordnungen `[10]→[74]` und `[13]→[76]` dürfen nicht verloren gehen.
- Die bibliografische Konfliktmarkierung bei Kleene `[79]` bleibt bis zur verbindlichen Ausgabenentscheidung bestehen.

## 10. DB-Modell – kanonische mathematische Register und Abhängigkeiten

Nach Freigabe werden relevante Objekte in den aus Ende 3.1 übernommenen kanonischen Registern geführt. Diese Tabellen dürfen nicht durch neue parallele Ersatzregister verdrängt werden.

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

## 11. DB-Modell – Abschnitte, Versionen, Revisionen und Issues

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

## 12. Wichtiger noch offener DB-Punkt: Speicherung des eigentlichen Anlagentextes

Die aktuelle Revision 5 klassifiziert und verankert mathematische **Objekte**, besitzt jedoch noch **kein eigenes kanonisches Text-/Versionsregister für die vollständigen Anlagenabschnitte**. `appendix_modules` speichert nur Modulmetadaten. Deshalb darf der Anlagen-Chat den endgültigen Fließtext nicht lediglich außerhalb der DB entstehen lassen.

Vor der ersten kanonischen Anlagenfassung soll der Anlagen-Chat in einer eigenen Repository-Revision eine normalisierte Textstruktur ergänzen. Empfohlene Mindeststruktur:

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

Diese drei Tabellen sind in Revision 5 **noch nicht vorhanden**. Sie sind als verbindlicher erster Schemaausbau des Anlagen-Chats vorgesehen, sofern nicht vor Arbeitsbeginn bereits eine neuere DB-Fassung dieselbe Funktion äquivalent bereitstellt.

## 13. Views und Gates

### View `v_math_main_text_inventory`

```sql
CREATE OR REPLACE VIEW `v_math_main_text_inventory` AS
SELECT ro.repo_object_id, ds.section_code AS source_section_code, ro.object_type, ro.object_label, ro.object_title,
       mp.importance_level, mp.equation_role, mp.classification_status
FROM repository_objects ro
JOIN dissertation_sections ds ON ds.section_id=ro.section_id
JOIN mathematical_object_profiles mp ON mp.repo_object_id=ro.repo_object_id
WHERE mp.document_location='main_text';
```

### View `v_math_appendix_inventory`

```sql
CREATE OR REPLACE VIEW `v_math_appendix_inventory` AS
SELECT am.appendix_code, am.title AS appendix_title, mp.appendix_anchor,
       ds.section_code AS source_section_code, ro.object_type, ro.object_label, ro.object_title,
       mp.importance_level, mp.equation_role, mp.classification_status
FROM repository_objects ro
JOIN dissertation_sections ds ON ds.section_id=ro.section_id
JOIN mathematical_object_profiles mp ON mp.repo_object_id=ro.repo_object_id
JOIN appendix_modules am ON am.appendix_module_id=mp.appendix_module_id
WHERE mp.document_location='appendix';
```

### View `v_math_required_for_sections`

```sql
CREATE OR REPLACE VIEW `v_math_required_for_sections` AS
SELECT r.required_for_section_code, r.requirement_type, ro.repo_object_id,
       ds.section_code AS source_section_code, ro.object_type, ro.object_label, ro.object_title,
       mp.document_location, mp.importance_level, mp.equation_role
FROM object_section_requirements r
JOIN repository_objects ro ON ro.repo_object_id=r.repo_object_id
JOIN dissertation_sections ds ON ds.section_id=ro.section_id
JOIN mathematical_object_profiles mp ON mp.repo_object_id=ro.repo_object_id;
```

### View `v_math_compression_gate`

```sql
CREATE OR REPLACE VIEW `v_math_compression_gate` AS
SELECT 'PROFILE_COVERAGE' AS gate_code,
       CASE WHEN (SELECT COUNT(*) FROM repository_objects)=(SELECT COUNT(*) FROM mathematical_object_profiles) THEN 'PASS' ELSE 'FAIL' END AS gate_status,
       CAST((SELECT COUNT(*) FROM repository_objects) AS CHAR) AS expected_value,
       CAST((SELECT COUNT(*) FROM mathematical_object_profiles) AS CHAR) AS actual_value
UNION ALL
SELECT 'MAIN_NO_DERIVATION_EXAMPLE',
       CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
       '0', CAST(COUNT(*) AS CHAR)
FROM mathematical_object_profiles
WHERE document_location='main_text' AND (importance_level IN ('derivation','example') OR equation_role IN ('proof_step','example'))
UNION ALL
SELECT 'APPENDIX_FULLY_REFERENCED',
       CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
       '0', CAST(COUNT(*) AS CHAR)
FROM mathematical_object_profiles
WHERE document_location='appendix' AND (appendix_module_id IS NULL OR appendix_anchor IS NULL)
UNION ALL
SELECT 'MAIN_HAS_DOWNSTREAM_REQUIREMENT',
       CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
       '0', CAST(COUNT(*) AS CHAR)
FROM mathematical_object_profiles mp
LEFT JOIN object_section_requirements r ON r.repo_object_id=mp.repo_object_id
WHERE mp.document_location='main_text' AND r.requirement_id IS NULL
UNION ALL
SELECT 'EQUATION_ROLE_COMPLETE',
       CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
       '0', CAST(COUNT(*) AS CHAR)
FROM repository_objects ro
JOIN mathematical_object_profiles mp ON mp.repo_object_id=ro.repo_object_id
WHERE ro.object_type='equation' AND mp.equation_role IS NULL
UNION ALL
SELECT 'NON_EQUATION_ROLE_NULL',
       CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
       '0', CAST(COUNT(*) AS CHAR)
FROM repository_objects ro
JOIN mathematical_object_profiles mp ON mp.repo_object_id=ro.repo_object_id
WHERE ro.object_type<>'equation' AND mp.equation_role IS NOT NULL;
```

### Erwarteter Gate-Stand Revision 5

| Validation-Code | Status | Erwartet | Ist |
|---|---|---|---|
| `RKB32-MATH-PROFILE-COUNT` | **passed** | 275 | 275 |
| `RKB32-MAIN-NO-DERIVATION-EXAMPLE` | **passed** | 0 | 0 |
| `RKB32-APPENDIX-ANCHOR-COMPLETE` | **passed** | 0 | 0 |
| `RKB32-MAIN-REQUIREMENT-COMPLETE` | **passed** | 0 | 0 |
| `RKB32-EQUATION-ROLE-COMPLETE` | **passed** | 233 | 233 |
| `RKB32-NON-EQUATION-ROLE-NULL` | **passed** | 0 | 0 |
| `RKB32-REQUIREMENT-GRANULARITY` | **warning** | 3.3.x | 3.3 |

Der einzige bewusst verbleibende Warnpunkt ist die Granularität der downstream-Anforderungen: Haupttextobjekte sind aktuell auf `3.3` gemappt; die konkrete Auflösung auf `3.3.x` erfolgt erst mit der verbindlichen 3.3-Struktur. Das ist **kein Anlagenfehler** und darf vom Anlagen-Chat nicht durch erfundene Zielabschnitte aufgelöst werden.

## 14. Vollständiges technisches Inventar aller 144 Anlagenobjekte

Die folgende Liste ist die verbindliche Arbeitsmenge des Anlagen-Chats. Für jedes Objekt sind technischer Anker, Herkunft, Klassifikation und Quellpayload dokumentiert. Der Quellpayload ist **kein automatisch freigegebener Endtext**, sondern der importierte Ausgangsstand.

### M1 – Mengentheoretische und funktionale Grundlagen

| Anker | Quelle | Typ | Objekt | Bedeutung | Gleichungsrolle | Status |
|---|---|---|---|---|---|---|
| `M1-GL-007` | 3.2.1 / `equation_candidates#7` | equation | (3.7): Teilmengen | supporting | derived | source_import |
| `M1-GL-008` | 3.2.1 / `equation_candidates#8` | equation | (3.8): Teilmengen | supporting | derived | source_import |
| `M1-GL-009` | 3.2.1 / `equation_candidates#9` | equation | (3.9): Gleichheit von Mengen | supporting | derived | source_import |
| `M1-GL-010` | 3.2.1 / `equation_candidates#10` | equation | (3.10): Die leere Menge | supporting | derived | source_import |
| `M1-GL-011` | 3.2.1 / `equation_candidates#11` | equation | (3.11): Die leere Menge | supporting | derived | source_import |
| `M1-GL-012` | 3.2.1 / `equation_candidates#12` | equation | (3.12): Mengenoperationen | supporting | derived | source_import |
| `M1-GL-013` | 3.2.1 / `equation_candidates#13` | equation | (3.13): Mengenoperationen | supporting | derived | source_import |
| `M1-GL-014` | 3.2.1 / `equation_candidates#14` | equation | (3.14): Mengenoperationen | supporting | derived | source_import |
| `M1-GL-015` | 3.2.1 / `equation_candidates#15` | equation | (3.15): Mengenoperationen | supporting | derived | source_import |
| `M1-GL-016` | 3.2.1 / `equation_candidates#16` | equation | (3.16): Potenzmenge | supporting | derived | source_import |
| `M1-GL-017` | 3.2.1 / `equation_candidates#17` | equation | (3.17): Potenzmenge | supporting | derived | source_import |
| `M1-GL-018` | 3.2.1 / `equation_candidates#18` | equation | (3.18): Potenzmenge | supporting | derived | source_import |
| `M1-GL-019` | 3.2.1 / `equation_candidates#19` | equation | (3.19): Geordnete Paare und kartesisches Produkt | supporting | derived | source_import |
| `M1-GL-020` | 3.2.1 / `equation_candidates#20` | equation | (3.20): Geordnete Paare und kartesisches Produkt | supporting | derived | source_import |
| `M1-GL-021` | 3.2.1 / `equation_candidates#21` | equation | (3.21): Geordnete Paare und kartesisches Produkt | supporting | derived | source_import |
| `M1-GL-026` | 3.2.2 / `equation_candidates#26` | equation | (3.26): Definitionsmenge, Zielmenge und Bildmenge | supporting | derived | source_import |
| `M1-GL-027` | 3.2.2 / `equation_candidates#27` | equation | (3.27): Definitionsmenge, Zielmenge und Bildmenge | supporting | derived | source_import |
| `M1-GL-028` | 3.2.2 / `equation_candidates#28` | equation | (3.28): Definitionsmenge, Zielmenge und Bildmenge | supporting | derived | source_import |
| `M1-GL-033` | 3.2.2 / `equation_candidates#33` | equation | (3.33): Identische Funktion | supporting | derived | source_import |
| `M1-GL-034` | 3.2.2 / `equation_candidates#34` | equation | (3.34): Verkettung von Funktionen | supporting | derived | source_import |
| `M1-GL-035` | 3.2.2 / `equation_candidates#35` | equation | (3.35): Verkettung von Funktionen | supporting | derived | source_import |
| `M1-GL-036` | 3.2.2 / `equation_candidates#36` | equation | (3.36): Verkettung von Funktionen | supporting | derived | source_import |
| `M1-GL-037` | 3.2.2 / `equation_candidates#37` | equation | (3.37): Funktionen mit mehreren Eingangsgrößen | supporting | derived | source_import |
| `M1-GL-038` | 3.2.2 / `equation_candidates#38` | equation | (3.38): Funktionen mit mehreren Eingangsgrößen | supporting | derived | source_import |
| `M1-GL-039` | 3.2.2 / `equation_candidates#39` | equation | (3.39): Funktionsfamilien und parametrisierte Funktionen | supporting | derived | source_import |
| `M1-GL-040` | 3.2.2 / `equation_candidates#40` | equation | (3.40): Partielle Funktionen | supporting | derived | source_import |

#### Quellpayloads

##### `M1-GL-007` — (3.7) — Teilmengen

- Herkunft: `equation_candidates#7`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \subseteq B \Longleftrightarrow \forall x\,(x \in A \Rightarrow x \in B)
```

##### `M1-GL-008` — (3.8) — Teilmengen

- Herkunft: `equation_candidates#8`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \subset B \Longleftrightarrow A \subseteq B \land A \neq B
```

##### `M1-GL-009` — (3.9) — Gleichheit von Mengen

- Herkunft: `equation_candidates#9`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A = B \Longleftrightarrow \forall x\,(x \in A \Leftrightarrow x \in B)
```

##### `M1-GL-010` — (3.10) — Die leere Menge

- Herkunft: `equation_candidates#10`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\varnothing = \text{\{}x|\ x \neq x\text{\}}
```

##### `M1-GL-011` — (3.11) — Die leere Menge

- Herkunft: `equation_candidates#11`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\varnothing \subseteq A
```

##### `M1-GL-012` — (3.12) — Mengenoperationen

- Herkunft: `equation_candidates#12`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \cup B = \text{\{}x|\ x \in A \vee x \in B\text{\}}
```

##### `M1-GL-013` — (3.13) — Mengenoperationen

- Herkunft: `equation_candidates#13`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \cap B = \text{\{}x|\ x \in A \land x \in B\text{\}}
```

##### `M1-GL-014` — (3.14) — Mengenoperationen

- Herkunft: `equation_candidates#14`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \smallsetminus B = \text{\{}x|\ x \in A \land x \notin B\text{\}}
```

##### `M1-GL-015` — (3.15) — Mengenoperationen

- Herkunft: `equation_candidates#15`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \cap B = \varnothing
```

##### `M1-GL-016` — (3.16) — Potenzmenge

- Herkunft: `equation_candidates#16`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\mathcal{P(}A) = \text{\{}B|\ B \subseteq A\text{\}}
```

##### `M1-GL-017` — (3.17) — Potenzmenge

- Herkunft: `equation_candidates#17`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\mathcal{P}(A) = \text{\{}\varnothing,\text{\{}a\text{\}},\text{\{}b\text{\}},\text{\{}a,b\text{\}\}}
```

##### `M1-GL-018` — (3.18) — Potenzmenge

- Herkunft: `equation_candidates#18`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
|A| = n \Rightarrow \left| \mathcal{P}A \right| = 2^{n}
```

##### `M1-GL-019` — (3.19) — Geordnete Paare und kartesisches Produkt

- Herkunft: `equation_candidates#19`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
(a,b) \neq (b,a)\quad\quad\text{für }a \neq b
```

##### `M1-GL-020` — (3.20) — Geordnete Paare und kartesisches Produkt

- Herkunft: `equation_candidates#20`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A \times B = \text{\{}(a,b)|\ a \in A \land b \in B\text{\}}
```

##### `M1-GL-021` — (3.21) — Geordnete Paare und kartesisches Produkt

- Herkunft: `equation_candidates#21`, Abschnitt `3.2.1`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
|A \times B| = |A| \cdot |B|
```

##### `M1-GL-026` — (3.26) — Definitionsmenge, Zielmenge und Bildmenge

- Herkunft: `equation_candidates#26`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
f(A) = \text{\{}f(a) \mid a \in A\text{\}} \subseteq B
```

##### `M1-GL-027` — (3.27) — Definitionsmenge, Zielmenge und Bildmenge

- Herkunft: `equation_candidates#27`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
f(C) = \text{\{}f(c) \mid c \in C\text{\}}
```

##### `M1-GL-028` — (3.28) — Definitionsmenge, Zielmenge und Bildmenge

- Herkunft: `equation_candidates#28`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
f^{- 1}(D) = \text{\{}a \in A \mid f(a) \in D\text{\}}
```

##### `M1-GL-033` — (3.33) — Identische Funktion

- Herkunft: `equation_candidates#33`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
id_{A}:A \rightarrow A,\quad\quad id_{A}(a) = a\quad\forall a \in A
```

##### `M1-GL-034` — (3.34) — Verkettung von Funktionen

- Herkunft: `equation_candidates#34`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
g \circ f:A \rightarrow C,\quad\quad(g \circ f)(a) = g\left( f(a) \right)
```

##### `M1-GL-035` — (3.35) — Verkettung von Funktionen

- Herkunft: `equation_candidates#35`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
g \circ f \neq f \circ g
```

##### `M1-GL-036` — (3.36) — Verkettung von Funktionen

- Herkunft: `equation_candidates#36`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
h \circ (g \circ f) = (h \circ g) \circ f
```

##### `M1-GL-037` — (3.37) — Funktionen mit mehreren Eingangsgrößen

- Herkunft: `equation_candidates#37`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
f:A \times B \rightarrow C,\quad\quad f(a,b) = c \in C,\quad a \in A,\ b \in B
```

##### `M1-GL-038` — (3.38) — Funktionen mit mehreren Eingangsgrößen

- Herkunft: `equation_candidates#38`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\begin{matrix}
f:A_{1} \times A_{2} \times \cdots \times A_{n} \rightarrow B, \\
\left( a_{1},a_{2},\ldots,a_{n} \right) \in A_{1} \times A_{2} \times \cdots \times A_{n}, \\
f\left( a_{1},a_{2},\ldots,a_{n} \right) \in B.
\end{matrix}
```

##### `M1-GL-039` — (3.39) — Funktionsfamilien und parametrisierte Funktionen

- Herkunft: `equation_candidates#39`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\text{\{}f_{\theta} \mid \theta \in \Theta\text{\}},\quad\quad f_{\theta}:A \rightarrow B\quad\forall\theta \in
```

##### `M1-GL-040` — (3.40) — Partielle Funktionen

- Herkunft: `equation_candidates#40`, Abschnitt `3.2.2`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
f:D \rightarrow B,\quad\quad D \subseteq A
```

### M2 – Algebraische Grundlagen des Vektorraums

| Anker | Quelle | Typ | Objekt | Bedeutung | Gleichungsrolle | Status |
|---|---|---|---|---|---|---|
| `M2-DEF-007` | 3.2.4 / `definition_candidates#7` | definition | Definition 3.2.7: Nullvektor | supporting |  | source_import |
| `M2-DEF-008` | 3.2.4 / `definition_candidates#8` | definition | Definition 3.2.8: Untervektorraum | supporting |  | source_import |
| `M2-DEF-012` | 3.2.6 / `definition_candidates#12` | definition | Definition 3.2.12: Lineare Abhängigkeit | supporting |  | source_import |
| `M2-GL-053` | 3.2.4 / `equation_candidates#53` | equation | (3.53): Axiome der Vektoraddition | supporting | derived | source_import |
| `M2-GL-054` | 3.2.4 / `equation_candidates#54` | equation | (3.54): Axiome der Vektoraddition | supporting | derived | source_import |
| `M2-GL-055` | 3.2.4 / `equation_candidates#55` | equation | (3.55): Axiome der Vektoraddition | supporting | derived | source_import |
| `M2-GL-056` | 3.2.4 / `equation_candidates#56` | equation | (3.56): Definition 3.2.7: Nullvektor | supporting | canonical | source_import |
| `M2-GL-057` | 3.2.4 / `equation_candidates#57` | equation | (3.57): Definition 3.2.7: Nullvektor | supporting | canonical | source_import |
| `M2-GL-058` | 3.2.4 / `equation_candidates#58` | equation | (3.58): Additives Inverses | supporting | derived | source_import |
| `M2-GL-059` | 3.2.4 / `equation_candidates#59` | equation | (3.59): Additives Inverses | supporting | derived | source_import |
| `M2-GL-060` | 3.2.4 / `equation_candidates#60` | equation | (3.60): Axiome der Skalarmultiplikation | supporting | derived | source_import |
| `M2-GL-061` | 3.2.4 / `equation_candidates#61` | equation | (3.61): Axiome der Skalarmultiplikation | supporting | derived | source_import |
| `M2-GL-062` | 3.2.4 / `equation_candidates#62` | equation | (3.62): Axiome der Skalarmultiplikation | supporting | derived | source_import |
| `M2-GL-063` | 3.2.4 / `equation_candidates#63` | equation | (3.63): Axiome der Skalarmultiplikation | supporting | derived | source_import |
| `M2-GL-064` | 3.2.4 / `equation_candidates#64` | equation | (3.64): Axiome der Skalarmultiplikation | supporting | derived | source_import |
| `M2-GL-065` | 3.2.4 / `equation_candidates#65` | equation | (3.65): Multiplikation eines Vektors mit null | derivation | proof_step | source_import |
| `M2-GL-066` | 3.2.4 / `equation_candidates#66` | equation | (3.66): Multiplikation des Nullvektors mit einem Skalar | derivation | proof_step | source_import |
| `M2-GL-067` | 3.2.4 / `equation_candidates#67` | equation | (3.67): Definition 3.2.8: Untervektorraum | supporting | canonical | source_import |
| `M2-GL-068` | 3.2.4 / `equation_candidates#68` | equation | (3.68): Beispiele für Vektorräume | example | example | source_import |
| `M2-GL-069` | 3.2.4 / `equation_candidates#69` | equation | (3.69): Beispiele für Vektorräume | example | example | source_import |
| `M2-GL-074` | 3.2.6 / `equation_candidates#74` | equation | (3.75): Definition 3.2.12: Lineare Abhängigkeit | supporting | canonical | source_import |
| `M2-GL-075` | 3.2.6 / `equation_candidates#75` | equation | (3.76): Definition 3.2.12: Lineare Abhängigkeit | supporting | canonical | source_import |
| `M2-GL-076` | 3.2.6 / `equation_candidates#76` | equation | (3.77): Beispiel für lineare Abhängigkeit | example | example | source_import |
| `M2-GL-077` | 3.2.6 / `equation_candidates#77` | equation | (3.78): Beispiel für lineare Unabhängigkeit | example | example | source_import |
| `M2-GL-080` | 3.2.6 / `equation_candidates#80` | equation | (3.81): Standardbasis des reellen Koordinatenraums | example | example | source_import |
| `M2-GL-081` | 3.2.6 / `equation_candidates#81` | equation | (3.82): Standardbasis des reellen Koordinatenraums | example | example | source_import |

#### Quellpayloads

##### `M2-DEF-007` — Definition 3.2.7 — Nullvektor

- Herkunft: `definition_candidates#7`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
In jedem Vektorraum existiert ein eindeutig bestimmtes neutrales Element bezüglich der Addition. Ich bezeichne dieses Element als Nullvektor $0_{V}$. Seine Zugehörigkeit zum Raum und seine neutrale Wirkung fasse ich zusammen:

$$0_{V} \in V,\quad\quad x + 0_{V} = 0_{V} + x = x\quad\forall x \in V\ (3.56)$$

Der Index $V$ verdeutlicht, dass der Nullvektor ein Element des jeweiligen Vektorraums ist. Ich darf ihn deshalb nicht ohne weitere Begründung mit dem skalaren Nullelement des Körpers gleichsetzen \[71, 82\].

In Koordinatenräumen wird der Nullvektor durch einen Koordinatenvektor dargestellt, dessen sämtliche Komponenten gleich null sind. Für den zweidimensionalen reellen Koordinatenraum gilt beispielsweise

$$0_{R^{\mathbb{2}}} = \begin{pmatrix}
\begin{matrix}
0 \\
0
\end{matrix}
\end{pmatrix}\ (3.57)$$

Der Nullvektor besitzt bezüglich der Addition eine neutrale Wirkung. Lineare Abbildungen bilden den Nullvektor des Definitionsraums auf den Nullvektor des Zielraums ab \[71, 74, 82\].
```

##### `M2-DEF-008` — Definition 3.2.8 — Untervektorraum

- Herkunft: `definition_candidates#8`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
Eine Teilmenge $U \subseteq V$ heißt Untervektorraum von $V$, wenn sie mit den aus $V$ übernommenen Operationen selbst einen Vektorraum bildet \[71, 74, 82\].

Für eine nichtleere Teilmenge genügt es zu prüfen, ob sie unter Vektoraddition und Skalarmultiplikation abgeschlossen ist. Ich fasse diese Bedingungen zusammen:

$$\begin{matrix}
x,y \in U \Rightarrow x + y \in U, \\
\lambda \in K,\ x \in U \Rightarrow \lambda x \in U.
\end{matrix}\ (3.67)$$

Dabei gilt:

-   $U$ ist die betrachtete Teilmenge,

-   $V$ ist der übergeordnete Vektorraum,

-   $x,y$ sind Vektoren aus $U$,

-   $\lambda$ ist ein Skalar aus $K$.

Aus diesen Bedingungen folgt insbesondere, dass jeder Untervektorraum den Nullvektor des übergeordneten Vektorraums enthält \[71, 74, 82\]. Im Original wurden Teilmengenbedingung, Additionsabschluss und Abschluss unter Skalarmultiplikation auf drei einzelne Gleichungsnummern verteilt; mathematisch bilden sie hier eine gemeinsame Untervektorraumbedingung.
```

##### `M2-DEF-012` — Definition 3.2.12 — Lineare Abhängigkeit

- Herkunft: `definition_candidates#12`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
Eine Vektormenge $v_{1},\ldots,v_{n}$ heißt linear abhängig, wenn Skalare existieren, die nicht sämtlich null sind und dennoch den Nullvektor erzeugen:

$$\exists\,\lambda_{1},\ldots,\lambda_{n} \in K:\quad\quad\left( \sum_{i = 1}^{n}{\lambda_{i}v_{i}} = 0_{V} \right) \land \left( \exists j:\lambda_{j} \neq 0_{K} \right)(3.75)$$

Die lineare Abhängigkeit ist damit genau das Gegenstück zur linearen Unabhängigkeit \[71, 74, 82\].

Ist beispielsweise $\lambda_{j} \neq 0_{K}$, kann ich Gleichung (3.75) nach $v_{j}$ auflösen:

$$v_{j} = - \frac{1}{\lambda_{j}}\sum_{i = 1\backslash\backslash i \neq j}^{n}{\lambda_{i}v_{i}}\ (3.76)$$

Damit wird unmittelbar sichtbar, was lineare Abhängigkeit bedeutet: Mindestens ein Vektor kann vollständig als Linearkombination der übrigen dargestellt werden. Dieser Vektor erweitert den erzeugten Spannraum nicht.
```

##### `M2-GL-053` — (3.53) — Axiome der Vektoraddition

- Herkunft: `equation_candidates#53`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
x + y \in V
```

##### `M2-GL-054` — (3.54) — Axiome der Vektoraddition

- Herkunft: `equation_candidates#54`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
(x + y) + z = x + (y + z)
```

##### `M2-GL-055` — (3.55) — Axiome der Vektoraddition

- Herkunft: `equation_candidates#55`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
x + y = y + x
```

##### `M2-GL-056` — (3.56) — Definition 3.2.7: Nullvektor

- Herkunft: `equation_candidates#56`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
0_{V} \in V,\quad\quad x + 0_{V} = 0_{V} + x = x\quad\forall x \in V
```

##### `M2-GL-057` — (3.57) — Definition 3.2.7: Nullvektor

- Herkunft: `equation_candidates#57`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
0_{R^{\mathbb{2}}} = \begin{pmatrix}
\begin{matrix}
0 \\
0
\end{matrix}
\end{pmatrix}
```

##### `M2-GL-058` — (3.58) — Additives Inverses

- Herkunft: `equation_candidates#58`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
x + ( - x) = ( - x) + x = 0_{V}
```

##### `M2-GL-059` — (3.59) — Additives Inverses

- Herkunft: `equation_candidates#59`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
x - y ≔ x + ( - y)
```

##### `M2-GL-060` — (3.60) — Axiome der Skalarmultiplikation

- Herkunft: `equation_candidates#60`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\lambda x \in V
```

##### `M2-GL-061` — (3.61) — Axiome der Skalarmultiplikation

- Herkunft: `equation_candidates#61`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
(\lambda\mu)x = \lambda(\mu x)
```

##### `M2-GL-062` — (3.62) — Axiome der Skalarmultiplikation

- Herkunft: `equation_candidates#62`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
1_{K}x = x
```

##### `M2-GL-063` — (3.63) — Axiome der Skalarmultiplikation

- Herkunft: `equation_candidates#63`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\lambda(x + y) = \lambda x + \lambda y
```

##### `M2-GL-064` — (3.64) — Axiome der Skalarmultiplikation

- Herkunft: `equation_candidates#64`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
(\lambda + \mu)x = \lambda x + \mu x
```

##### `M2-GL-065` — (3.65) — Multiplikation eines Vektors mit null

- Herkunft: `equation_candidates#65`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
0_{K}x = 0_{V}\quad\forall x \in V
```

##### `M2-GL-066` — (3.66) — Multiplikation des Nullvektors mit einem Skalar

- Herkunft: `equation_candidates#66`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\lambda 0_{V} = 0_{V}
```

##### `M2-GL-067` — (3.67) — Definition 3.2.8: Untervektorraum

- Herkunft: `equation_candidates#67`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
\begin{matrix}
x,y \in U \Rightarrow x + y \in U, \\
\lambda \in K,\ x \in U \Rightarrow \lambda x \in U.
\end{matrix}
```

##### `M2-GL-068` — (3.68) — Beispiele für Vektorräume

- Herkunft: `equation_candidates#68`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\mathbb{R}^{n} = \left\{ \begin{pmatrix}
x_{1} \\
 \vdots \\
x_{n}
\end{pmatrix} \middle| x_{1},\ldots,x_{n} \in \mathbb{R} \right\}
```

##### `M2-GL-069` — (3.69) — Beispiele für Vektorräume

- Herkunft: `equation_candidates#69`, Abschnitt `3.2.4`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\mathbb{R}^{m \times n}
```

##### `M2-GL-074` — (3.75) — Definition 3.2.12: Lineare Abhängigkeit

- Herkunft: `equation_candidates#74`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
\exists\,\lambda_{1},\ldots,\lambda_{n} \in K:\quad\quad\left( \sum_{i = 1}^{n}{\lambda_{i}v_{i}} = 0_{V} \right) \land \left( \exists j:\lambda_{j} \neq 0_{K} \right)
```

##### `M2-GL-075` — (3.76) — Definition 3.2.12: Lineare Abhängigkeit

- Herkunft: `equation_candidates#75`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
v_{j} = - \frac{1}{\lambda_{j}}\sum_{i = 1\backslash\backslash i \neq j}^{n}{\lambda_{i}v_{i}}
```

##### `M2-GL-076` — (3.77) — Beispiel für lineare Abhängigkeit

- Herkunft: `equation_candidates#76`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
v_{2} = 2v_{1}\quad\quad \Longleftrightarrow \quad\quad 2v_{1} - v_{2} = 0_{R^{\mathbb{2}}}
```

##### `M2-GL-077` — (3.78) — Beispiel für lineare Unabhängigkeit

- Herkunft: `equation_candidates#77`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\lambda_{1}\begin{pmatrix}
1 \\
0
\end{pmatrix} + \lambda_{2}\begin{pmatrix}
0 \\
1
\end{pmatrix} = \begin{pmatrix}
0 \\
0
\end{pmatrix}\quad \Longrightarrow \quad\lambda_{1} = \lambda_{2} = 0
```

##### `M2-GL-080` — (3.81) — Standardbasis des reellen Koordinatenraums

- Herkunft: `equation_candidates#80`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
E_{n} = \left( e_{1},\ldots,e_{n} \right),\quad\quad e_{i} = \begin{pmatrix}
0 \\
 \vdots \\
1 \\
 \vdots \\
0
\end{pmatrix}
```

##### `M2-GL-081` — (3.82) — Standardbasis des reellen Koordinatenraums

- Herkunft: `equation_candidates#81`, Abschnitt `3.2.6`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
v = v_{1}e_{1} + \cdots + v_{n}e_{n} = \sum_{i = 1}^{n}v_{i}e_{i}
```

### M3 – Matrizen, Basiswechsel und Invarianten

| Anker | Quelle | Typ | Objekt | Bedeutung | Gleichungsrolle | Status |
|---|---|---|---|---|---|---|
| `M3-GL-044` | 3.2.3 / `equation_candidates#44` | equation | (3.44): Verkettung von Operatoren | supporting | derived | source_import |
| `M3-GL-045` | 3.2.3 / `equation_candidates#45` | equation | (3.45): Verkettung von Operatoren | supporting | derived | source_import |
| `M3-GL-046` | 3.2.3 / `equation_candidates#46` | equation | (3.46): Identitätsoperator | supporting | derived | source_import |
| `M3-GL-047` | 3.2.3 / `equation_candidates#47` | equation | (3.47): Identitätsoperator | supporting | derived | source_import |
| `M3-GL-050` | 3.2.3 / `equation_candidates#50` | equation | (3.50): Eigenwerte und Eigenvektoren | supporting | derived | source_import |
| `M3-GL-090` | 3.2.7 / `equation_candidates#90` | equation | (3.91): Konstruktion einer Basiswechselmatrix | derivation | proof_step | source_import |
| `M3-GL-091` | 3.2.7 / `equation_candidates#91` | equation | (3.92): Beispiel eines Basiswechsels | example | example | source_import |
| `M3-GL-092` | 3.2.7 / `equation_candidates#92` | equation | (3.93): Beispiel eines Basiswechsels | example | example | source_import |
| `M3-GL-097` | 3.2.8 / `equation_candidates#97` | equation | (3.98): Determinante einer $\mathbf{2}\mathbf{\times}\mathbf{2}$-Matrix | supporting | derived | source_import |
| `M3-GL-098` | 3.2.8 / `equation_candidates#98` | equation | (3.99): Determinante einer $\mathbf{2}\mathbf{\times}\mathbf{2}$-Matrix | supporting | derived | source_import |
| `M3-GL-099` | 3.2.8 / `equation_candidates#99` | equation | (3.100): Determinante einer $\mathbf{3}\mathbf{\times}\mathbf{3}$-Matrix | supporting | derived | source_import |
| `M3-GL-102` | 3.2.8 / `equation_candidates#102` | equation | (3.103): Orientierung | supporting | derived | source_import |
| `M3-GL-103` | 3.2.8 / `equation_candidates#103` | equation | (3.104): Orientierung | supporting | derived | source_import |
| `M3-GL-105` | 3.2.8 / `equation_candidates#105` | equation | (3.106): Beispiel einer singulären Transformation | example | example | source_import |

#### Quellpayloads

##### `M3-GL-044` — (3.44) — Verkettung von Operatoren

- Herkunft: `equation_candidates#44`, Abschnitt `3.2.3`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\begin{matrix}
A\&:V \rightarrow V, \\
V \rightarrow V, \\
\begin{matrix}
A\&:V \rightarrow V, \\
x\& = B(A(x))
\end{matrix}
\end{matrix}
```

##### `M3-GL-045` — (3.45) — Verkettung von Operatoren

- Herkunft: `equation_candidates#45`, Abschnitt `3.2.3`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
B \circ A \neq A \circ B
```

##### `M3-GL-046` — (3.46) — Identitätsoperator

- Herkunft: `equation_candidates#46`, Abschnitt `3.2.3`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
I:V \rightarrow V,\quad\quad I(x) = x\quad\forall x \in V
```

##### `M3-GL-047` — (3.47) — Identitätsoperator

- Herkunft: `equation_candidates#47`, Abschnitt `3.2.3`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
I \circ T = T \circ I = T
```

##### `M3-GL-050` — (3.50) — Eigenwerte und Eigenvektoren

- Herkunft: `equation_candidates#50`, Abschnitt `3.2.3`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `number_missing`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
Ax = \lambda x,\quad\quad x \neq 0
```

##### `M3-GL-090` — (3.91) — Konstruktion einer Basiswechselmatrix

- Herkunft: `equation_candidates#90`, Abschnitt `3.2.7`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{C \rightarrow B} = \begin{pmatrix}
\left\lbrack c_{1} \right\rbrack_{B} & \left\lbrack c_{2} \right\rbrack_{B} & \cdots & \left\lbrack c_{n} \right\rbrack_{B}
\end{pmatrix}
```

##### `M3-GL-091` — (3.92) — Beispiel eines Basiswechsels

- Herkunft: `equation_candidates#91`, Abschnitt `3.2.7`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
P_{C \rightarrow B} = \begin{pmatrix}
1 & 1 \\
1 & - 1
\end{pmatrix}
```

##### `M3-GL-092` — (3.93) — Beispiel eines Basiswechsels

- Herkunft: `equation_candidates#92`, Abschnitt `3.2.7`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
P_{B \rightarrow C} = P_{C \rightarrow B}^{- 1} = \frac{1}{2}\begin{pmatrix}
1 & 1 \\
1 & - 1
\end{pmatrix}
```

##### `M3-GL-097` — (3.98) — Determinante einer $\mathbf{2}\mathbf{\times}\mathbf{2}$-Matrix

- Herkunft: `equation_candidates#97`, Abschnitt `3.2.8`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\det(A) = ad - bc
```

##### `M3-GL-098` — (3.99) — Determinante einer $\mathbf{2}\mathbf{\times}\mathbf{2}$-Matrix

- Herkunft: `equation_candidates#98`, Abschnitt `3.2.8`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\det(A) = 2 \cdot 3 - 0 \cdot 0 = 6
```

##### `M3-GL-099` — (3.100) — Determinante einer $\mathbf{3}\mathbf{\times}\mathbf{3}$-Matrix

- Herkunft: `equation_candidates#99`, Abschnitt `3.2.8`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\det(A) = a_{11}\left| \begin{matrix}
a_{22} & a_{23} \\
a_{32} & a_{33}
\end{matrix} \right| - a_{12}\left| \begin{matrix}
a_{21} & a_{2311} \\
a_{31} & a_{33}
\end{matrix} \right| + a_{13}\left| \begin{matrix}
a_{1121} & a_{22} \\
a_{31} & a_{32}
\end{matrix} \right|
```

##### `M3-GL-102` — (3.103) — Orientierung

- Herkunft: `equation_candidates#102`, Abschnitt `3.2.8`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\left\{ \begin{aligned}
det(A) > 0 & \Rightarrow Orientierung\ bleibt\ erhalten \\
det(A) < 0 & \Rightarrow "\{ Orientierung\ wird\ umgekehrt.
\end{aligned} \right.
```

##### `M3-GL-103` — (3.104) — Orientierung

- Herkunft: `equation_candidates#103`, Abschnitt `3.2.8`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\det(S) = - 1
```

##### `M3-GL-105` — (3.106) — Beispiel einer singulären Transformation

- Herkunft: `equation_candidates#105`, Abschnitt `3.2.8`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\det(A) = 1 \cdot 4 - 2 \cdot 2 = 0
```

### M4 – Rang, Kern, Bild und lineare Gleichungssysteme

| Anker | Quelle | Typ | Objekt | Bedeutung | Gleichungsrolle | Status |
|---|---|---|---|---|---|---|
| `M4-GL-113` | 3.2.9 / `equation_candidates#113` | equation | (3.114): Rang einer Matrix | supporting | derived | source_import |
| `M4-GL-114` | 3.2.9 / `equation_candidates#114` | equation | (3.115): Beispiel | example | example | source_import |
| `M4-GL-118` | 3.2.9 / `equation_candidates#118` | equation | (3.119): Beispiel zum Rang-Nullitätssatz | example | example | source_import |
| `M4-GL-121` | 3.2.9 / `equation_candidates#121` | equation | (3.122): Zusammenhang mit linearen Gleichungssystemen | supporting | derived | source_import |
| `M4-GL-122` | 3.2.9 / `equation_candidates#122` | equation | (3.123): Zusammenhang mit linearen Gleichungssystemen | supporting | derived | source_import |
| `M4-GL-123` | 3.2.9 / `equation_candidates#123` | equation | (3.124): Zusammenhang mit linearen Gleichungssystemen | supporting | derived | source_import |

#### Quellpayloads

##### `M4-GL-113` — (3.114) — Rang einer Matrix

- Herkunft: `equation_candidates#113`, Abschnitt `3.2.9`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\text{rang}(A) = \dim\left( \text{Spaltenraum}(A) \right) = \dim\left( \text{Zeilenraum}(A) \right)
```

##### `M4-GL-114` — (3.115) — Beispiel

- Herkunft: `equation_candidates#114`, Abschnitt `3.2.9`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\text{rang}(A) = 1
```

##### `M4-GL-118` — (3.119) — Beispiel zum Rang-Nullitätssatz

- Herkunft: `equation_candidates#118`, Abschnitt `3.2.9`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
2 = \dim\left( \ker(A) \right) + 1\quad \Longrightarrow \quad\dim\left( \ker(A) \right) = 1
```

##### `M4-GL-121` — (3.122) — Zusammenhang mit linearen Gleichungssystemen

- Herkunft: `equation_candidates#121`, Abschnitt `3.2.9`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
Ax = b\,\text{ist lösbar}\quad \Longleftrightarrow \quad b \in \text{Bild}(A)
```

##### `M4-GL-122` — (3.123) — Zusammenhang mit linearen Gleichungssystemen

- Herkunft: `equation_candidates#122`, Abschnitt `3.2.9`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
Ax = b\,\text{ist lösbar}\quad \Longleftrightarrow \quad\text{rang}(A) = \text{rang}\left( A \middle| b \right)
```

##### `M4-GL-123` — (3.124) — Zusammenhang mit linearen Gleichungssystemen

- Herkunft: `equation_candidates#123`, Abschnitt `3.2.9`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
x = x_{0} + z,\quad\quad z \in \ker(A)
```

### M5 – Eigenwerte, Diagonalisierung und Spektralrechnung

| Anker | Quelle | Typ | Objekt | Bedeutung | Gleichungsrolle | Status |
|---|---|---|---|---|---|---|
| `M5-GL-131` | 3.2.10 / `equation_candidates#131` | equation | (3.132): Beispiel einer Diagonalmatrix | example | example | source_import |
| `M5-GL-132` | 3.2.10 / `equation_candidates#132` | equation | (3.133): Beispiel einer Diagonalmatrix | example | example | source_import |
| `M5-GL-135` | 3.2.10 / `equation_candidates#135` | equation | (3.136): Algebraische und geometrische Vielfachheit | derivation | proof_step | source_import |
| `M5-GL-136` | 3.2.10 / `equation_candidates#136` | equation | (3.137): Algebraische und geometrische Vielfachheit | derivation | proof_step | source_import |
| `M5-GL-137` | 3.2.10 / `equation_candidates#137` | equation | (3.138): Beispiel eines mehrfachen Eigenwerts | example | example | source_import |
| `M5-GL-138` | 3.2.10 / `equation_candidates#138` | equation | (3.139): Beispiel eines mehrfachen Eigenwerts | example | example | source_import |
| `M5-GL-139` | 3.2.10 / `equation_candidates#139` | equation | (3.140): Spur und Determinante | derivation | proof_step | source_import |
| `M5-GL-140` | 3.2.10 / `equation_candidates#140` | equation | (3.141): Spur und Determinante | derivation | proof_step | source_import |
| `M5-GL-145` | 3.2.10 / `equation_candidates#145` | equation | (3.146): Methodologische Betrachtungen | supporting | derived | source_import |
| `M5-GL-153` | 3.2.11 / `equation_candidates#153` | equation | (3.154): Algebraische und geometrische Vielfachheit | derivation | proof_step | source_import |
| `M5-GL-154` | 3.2.11 / `equation_candidates#154` | equation | (3.155): Beispiel einer diagonalisierbaren Matrix | example | example | source_import |
| `M5-GL-155` | 3.2.11 / `equation_candidates#155` | equation | (3.156): Beispiel eines nichtdiagonalen Operators | example | example | source_import |
| `M5-GL-156` | 3.2.11 / `equation_candidates#156` | equation | (3.157): Beispiel eines nichtdiagonalen Operators | example | example | source_import |
| `M5-GL-157` | 3.2.11 / `equation_candidates#157` | equation | (3.158): Beispiel eines nichtdiagonalen Operators | example | example | source_import |
| `M5-GL-158` | 3.2.11 / `equation_candidates#158` | equation | (3.159): Beispiel eines nichtdiagonalen Operators | example | example | source_import |
| `M5-GL-159` | 3.2.11 / `equation_candidates#159` | equation | (3.160): Nicht diagonalisierbare Matrix | supporting | derived | source_import |
| `M5-GL-160` | 3.2.11 / `equation_candidates#160` | equation | (3.161): Potenzen einer diagonalisierbaren Matrix | derivation | proof_step | source_import |
| `M5-GL-161` | 3.2.11 / `equation_candidates#161` | equation | (3.162): Potenzen einer diagonalisierbaren Matrix | derivation | proof_step | source_import |
| `M5-GL-162` | 3.2.11 / `equation_candidates#162` | equation | (3.163): Matrixfunktionen | derivation | proof_step | source_import |
| `M5-GL-163` | 3.2.11 / `equation_candidates#163` | equation | (3.164): Matrixfunktionen | derivation | proof_step | source_import |
| `M5-GL-168` | 3.2.11 / `equation_candidates#168` | equation | (3.169): Zerlegung in Eigenprojektoren | derivation | proof_step | source_import |
| `M5-GL-169` | 3.2.11 / `equation_candidates#169` | equation | (3.170): Zerlegung in Eigenprojektoren | derivation | proof_step | source_import |
| `M5-GL-170` | 3.2.11 / `equation_candidates#170` | equation | (3.171): Vollständigkeitsrelation | derivation | proof_step | source_import |
| `M5-GL-171` | 3.2.11 / `equation_candidates#171` | equation | (3.172): Vollständigkeitsrelation | derivation | proof_step | source_import |
| `M5-GL-172` | 3.2.11 / `equation_candidates#172` | equation | (3.173): Vollständigkeitsrelation | derivation | proof_step | source_import |
| `M5-GL-173` | 3.2.11 / `equation_candidates#173` | equation | (3.174): Vollständigkeitsrelation | derivation | proof_step | source_import |
| `M5-GL-174` | 3.2.11 / `equation_candidates#174` | equation | (3.175): Wirkung auf einen beliebigen Vektor | derivation | proof_step | source_import |
| `M5-GL-175` | 3.2.11 / `equation_candidates#175` | equation | (3.176): Wirkung auf einen beliebigen Vektor | derivation | proof_step | source_import |
| `M5-GL-176` | 3.2.11 / `equation_candidates#176` | equation | (3.177): Matrixfunktionen in Spektraldarstellung | derivation | proof_step | source_import |
| `M5-GL-177` | 3.2.11 / `equation_candidates#177` | equation | (3.178): Matrixfunktionen in Spektraldarstellung | derivation | proof_step | source_import |

#### Quellpayloads

##### `M5-GL-131` — (3.132) — Beispiel einer Diagonalmatrix

- Herkunft: `equation_candidates#131`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
p_{A}(\lambda) = \ det\begin{pmatrix}
2 - \lambda & 0 \\
0 & 3 - \lambda
\end{pmatrix} = (2 - \lambda)(3 - \lambda).
```

##### `M5-GL-132` — (3.133) — Beispiel einer Diagonalmatrix

- Herkunft: `equation_candidates#132`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\lambda_{1} = 2,\quad\quad\lambda_{2} = 3
```

##### `M5-GL-135` — (3.136) — Algebraische und geometrische Vielfachheit

- Herkunft: `equation_candidates#135`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
m_{g}(\lambda) = \dim\left( E_{\lambda} \right)
```

##### `M5-GL-136` — (3.137) — Algebraische und geometrische Vielfachheit

- Herkunft: `equation_candidates#136`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
1 \leq m_{g}(\lambda) \leq m_{a}(\lambda)
```

##### `M5-GL-137` — (3.138) — Beispiel eines mehrfachen Eigenwerts

- Herkunft: `equation_candidates#137`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
p_{A}(\lambda) = (2 - \lambda)^{2}
```

##### `M5-GL-138` — (3.139) — Beispiel eines mehrfachen Eigenwerts

- Herkunft: `equation_candidates#138`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
E_{2} = \text{span}\left\{ \begin{pmatrix}
1 \\
0
\end{pmatrix} \right\}
```

##### `M5-GL-139` — (3.140) — Spur und Determinante

- Herkunft: `equation_candidates#139`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\det(A) = \prod_{i = 1}^{n}\lambda_{i}
```

##### `M5-GL-140` — (3.141) — Spur und Determinante

- Herkunft: `equation_candidates#140`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\text{tr}(A) = \sum_{i = 1}^{n}\lambda_{i}
```

##### `M5-GL-145` — (3.146) — Methodologische Betrachtungen

- Herkunft: `equation_candidates#145`, Abschnitt `3.2.10`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Wiederholende methodische/didaktische Formalisierung; in Anlage dokumentiert statt im Hauptfluss wiederholt.
- Importierter Quellpayload:

```text
A^{k}v = \lambda^{k}v
```

##### `M5-GL-153` — (3.154) — Algebraische und geometrische Vielfachheit

- Herkunft: `equation_candidates#153`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
A\,\text{diagonalisierbar}\quad \Longleftrightarrow \quad\sum_{\lambda \in \sigma(A)}^{}{\dim\left( E_{\lambda} \right)} = n
```

##### `M5-GL-154` — (3.155) — Beispiel einer diagonalisierbaren Matrix

- Herkunft: `equation_candidates#154`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
P^{- 1}AP = A = D
```

##### `M5-GL-155` — (3.156) — Beispiel eines nichtdiagonalen Operators

- Herkunft: `equation_candidates#155`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
p_{A}(\lambda) = \det\begin{pmatrix}
4 - \lambda & 1 \\
2 & 3 - \lambda
\end{pmatrix} = (4 - \lambda)(3 - \lambda) - 2 = \lambda^{2} - 7\lambda + 10.
```

##### `M5-GL-156` — (3.157) — Beispiel eines nichtdiagonalen Operators

- Herkunft: `equation_candidates#156`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
\lambda_{1} = 5,\quad\quad\lambda_{2} = 2
```

##### `M5-GL-157` — (3.158) — Beispiel eines nichtdiagonalen Operators

- Herkunft: `equation_candidates#157`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
P = \begin{pmatrix}
1 & 1 \\
1 & - 2
\end{pmatrix},\quad\quad D = \begin{pmatrix}
5 & 0 \\
0 & 2
\end{pmatrix}
```

##### `M5-GL-158` — (3.159) — Beispiel eines nichtdiagonalen Operators

- Herkunft: `equation_candidates#158`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=example`, `equation_role=example`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Konkretes Rechen- oder Anschauungsbeispiel; vollständig in der Anlage erhalten.
- Importierter Quellpayload:

```text
P^{- 1}AP = D
```

##### `M5-GL-159` — (3.160) — Nicht diagonalisierbare Matrix

- Herkunft: `equation_candidates#159`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
A\,\text{ist nicht diagonalisierbar}
```

##### `M5-GL-160` — (3.161) — Potenzen einer diagonalisierbaren Matrix

- Herkunft: `equation_candidates#160`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
A^{k} = PD^{k}P^{- 1}
```

##### `M5-GL-161` — (3.162) — Potenzen einer diagonalisierbaren Matrix

- Herkunft: `equation_candidates#161`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
D^{k} = \begin{pmatrix}
\lambda_{1}^{k} & 0 & \cdots & 0 \\
0 & \lambda_{2}^{k} & \cdots & 0 \\
 \vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \lambda_{n}^{k}
\end{pmatrix}
```

##### `M5-GL-162` — (3.163) — Matrixfunktionen

- Herkunft: `equation_candidates#162`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
f(A) = P\, f(D)\, P^{- 1}
```

##### `M5-GL-163` — (3.164) — Matrixfunktionen

- Herkunft: `equation_candidates#163`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
f(D) = \begin{pmatrix}
f\left( \lambda_{1} \right) & 0 & \cdots & 0 \\
0 & f\left( \lambda_{2} \right) & \cdots & 0 \\
 \vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & f\left( \lambda_{n} \right)
\end{pmatrix}
```

##### `M5-GL-168` — (3.169) — Zerlegung in Eigenprojektoren

- Herkunft: `equation_candidates#168`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
A = \sum_{i = 1}^{n}{\lambda_{i}q_{i}q_{i}^{T}}
```

##### `M5-GL-169` — (3.170) — Zerlegung in Eigenprojektoren

- Herkunft: `equation_candidates#169`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
A = \sum_{\lambda \in \sigma(A)}^{}{\lambda P_{\lambda}}
```

##### `M5-GL-170` — (3.171) — Vollständigkeitsrelation

- Herkunft: `equation_candidates#170`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\sum_{i = 1}^{n}q_{i}q_{i}^{T} = I
```

##### `M5-GL-171` — (3.172) — Vollständigkeitsrelation

- Herkunft: `equation_candidates#171`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\sum_{\lambda \in \sigma(A)}^{}P_{\lambda} = I
```

##### `M5-GL-172` — (3.173) — Vollständigkeitsrelation

- Herkunft: `equation_candidates#172`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `formula_broken`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{\lambda}P_{\mu} = 0\quad\quad\text{für }\lambda \neq
```

##### `M5-GL-173` — (3.174) — Vollständigkeitsrelation

- Herkunft: `equation_candidates#173`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{\lambda}^{2} = P_{\lambda}
```

##### `M5-GL-174` — (3.175) — Wirkung auf einen beliebigen Vektor

- Herkunft: `equation_candidates#174`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
x = \sum_{i = 1}^{n}\left( q_{i}^{T}x \right)\, q_{i}
```

##### `M5-GL-175` — (3.176) — Wirkung auf einen beliebigen Vektor

- Herkunft: `equation_candidates#175`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
Ax = \sum_{i = 1}^{n}{\lambda_{i}\left( q_{i}^{T}x \right)}\, q_{i}
```

##### `M5-GL-176` — (3.177) — Matrixfunktionen in Spektraldarstellung

- Herkunft: `equation_candidates#176`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
f(A) = \sum_{i = 1}^{n}{f\left( \lambda_{i} \right)}\, q_{i}q_{i}^{T}
```

##### `M5-GL-177` — (3.178) — Matrixfunktionen in Spektraldarstellung

- Herkunft: `equation_candidates#177`, Abschnitt `3.2.11`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
f(A) = \sum_{\lambda \in \sigma(A)}^{}{f(\lambda)P_{\lambda}}
```

### M6 – Skalarprodukt, Orthogonalität, Projektion und Hilbertraumstrukturen

| Anker | Quelle | Typ | Objekt | Bedeutung | Gleichungsrolle | Status |
|---|---|---|---|---|---|---|
| `M6-DEF-027` | 3.2.12 / `definition_candidates#27` | definition | Definition 3.2.27: Abstand | supporting |  | source_import |
| `M6-DEF-028` | 3.2.12 / `definition_candidates#28` | definition | Definition 3.2.28: Winkel zwischen zwei Vektoren | supporting |  | source_import |
| `M6-DEF-030` | 3.2.12 / `definition_candidates#30` | definition | Definition 3.2.30: Normierter Vektor | supporting |  | source_import |
| `M6-DEF-032` | 3.2.12 / `definition_candidates#32` | definition | Definition 3.2.32: Orthogonales Komplement | supporting |  | source_import |
| `M6-GL-189` | 3.2.12 / `equation_candidates#189` | equation | (3.190): Definition 3.2.27: Abstand | supporting | canonical | source_import |
| `M6-GL-190` | 3.2.12 / `equation_candidates#190` | equation | (3.191): Definition 3.2.27: Abstand | supporting | canonical | source_import |
| `M6-GL-191` | 3.2.12 / `equation_candidates#191` | equation | (3.192): Cauchy-Schwarz-Ungleichung | derivation | proof_step | source_import |
| `M6-GL-192` | 3.2.12 / `equation_candidates#192` | equation | (3.193): Cauchy-Schwarz-Ungleichung | derivation | proof_step | source_import |
| `M6-GL-193` | 3.2.12 / `equation_candidates#193` | equation | (3.194): Definition 3.2.28: Winkel zwischen zwei Vektoren | supporting | canonical | source_import |
| `M6-GL-194` | 3.2.12 / `equation_candidates#194` | equation | (3.195): Definition 3.2.28: Winkel zwischen zwei Vektoren | supporting | canonical | source_import |
| `M6-GL-196` | 3.2.12 / `equation_candidates#196` | equation | (3.197): Satz des Pythagoras im Skalarproduktraum | derivation | proof_step | source_import |
| `M6-GL-197` | 3.2.12 / `equation_candidates#197` | equation | (3.198): Satz des Pythagoras im Skalarproduktraum | derivation | proof_step | source_import |
| `M6-GL-198` | 3.2.12 / `equation_candidates#198` | equation | (3.199): Definition 3.2.30: Normierter Vektor | supporting | canonical | source_import |
| `M6-GL-199` | 3.2.12 / `equation_candidates#199` | equation | (3.200): Definition 3.2.30: Normierter Vektor | supporting | canonical | source_import |
| `M6-GL-206` | 3.2.12 / `equation_candidates#206` | equation | (3.207): Definition 3.2.32: Orthogonales Komplement | supporting | canonical | source_import |
| `M6-GL-207` | 3.2.12 / `equation_candidates#207` | equation | (3.208): Definition 3.2.32: Orthogonales Komplement | supporting | canonical | source_import |
| `M6-GL-208` | 3.2.12 / `equation_candidates#208` | equation | (3.209): Definition 3.2.32: Orthogonales Komplement | supporting | canonical | source_import |
| `M6-GL-211` | 3.2.12 / `equation_candidates#211` | equation | (3.212): Projektion auf einen Unterraum | derivation | proof_step | source_import |
| `M6-GL-212` | 3.2.12 / `equation_candidates#212` | equation | (3.213): Projektion auf einen Unterraum | derivation | proof_step | source_import |
| `M6-GL-213` | 3.2.12 / `equation_candidates#213` | equation | (3.214): Projektion auf einen Unterraum | derivation | proof_step | source_import |
| `M6-GL-214` | 3.2.12 / `equation_candidates#214` | equation | (3.215): Projektion auf einen Unterraum | derivation | proof_step | source_import |
| `M6-GL-215` | 3.2.12 / `equation_candidates#215` | equation | (3.216): Projektion auf einen Unterraum | derivation | proof_step | source_import |
| `M6-GL-216` | 3.2.12 / `equation_candidates#216` | equation | (3.217): Orthogonale Zerlegung eines Vektors | derivation | proof_step | source_import |
| `M6-GL-217` | 3.2.12 / `equation_candidates#217` | equation | (3.218): Orthogonale Zerlegung eines Vektors | derivation | proof_step | source_import |
| `M6-GL-218` | 3.2.12 / `equation_candidates#218` | equation | (3.219): Gram-Schmidt-Orthogonalisierung | derivation | proof_step | source_import |
| `M6-GL-219` | 3.2.12 / `equation_candidates#219` | equation | (3.220): Gram-Schmidt-Orthogonalisierung | derivation | proof_step | source_import |
| `M6-GL-220` | 3.2.12 / `equation_candidates#220` | equation | (3.221): Gram-Schmidt-Orthogonalisierung | derivation | proof_step | source_import |
| `M6-GL-221` | 3.2.12 / `equation_candidates#221` | equation | (3.222): Gram-Schmidt-Orthogonalisierung | derivation | proof_step | source_import |
| `M6-GL-222` | 3.2.12 / `equation_candidates#222` | equation | (3.223): Gram-Schmidt-Orthogonalisierung | derivation | proof_step | source_import |
| `M6-GL-223` | 3.2.12 / `equation_candidates#223` | equation | (3.224): Zusammenhang mit der Spektralzerlegung | derivation | proof_step | source_import |
| `M6-GL-224` | 3.2.12 / `equation_candidates#224` | equation | (3.225): Zusammenhang mit der Spektralzerlegung | derivation | proof_step | source_import |
| `M6-GL-225` | 3.2.12 / `equation_candidates#225` | equation | (3.226): \\langle x,y\\rangle | supporting | derived | source_import |
| `M6-GL-226` | 3.2.12 / `equation_candidates#226` | equation | (3.227): \\langle x,y\\rangle | supporting | derived | source_import |
| `M6-GL-227` | 3.2.12 / `equation_candidates#227` | equation | (3.228): \\langle x,y\\rangle | supporting | derived | source_import |
| `M6-GL-228` | 3.2.12 / `equation_candidates#228` | equation | (3.229): \\langle x,y\\rangle | supporting | derived | source_import |
| `M6-GL-229` | 3.2.12 / `equation_candidates#229` | equation | (3.230): \\langle x,y\\rangle | supporting | derived | source_import |
| `M6-GL-232` | 3.2.12 / `equation_candidates#232` | equation | (3.233): Methodologische Betrachtungen | supporting | derived | source_import |
| `M6-GL-233` | 3.2.12 / `equation_candidates#233` | equation | (3.234): Didaktische Betrachtungen | supporting | derived | source_import |
| `M6-SATZ-006` | 3.2.12 / `statement_candidates#6` | statement | Cauchy-Schwarz-Ungleichung: Cauchy-Schwarz-Ungleichung | derivation |  | proposed |
| `M6-SATZ-007` | 3.2.12 / `statement_candidates#7` | statement | Satz des Pythagoras im Skalarproduktraum: Satz des Pythagoras im Skalarproduktraum | derivation |  | proposed |
| `M6-SATZ-008` | 3.2.12 / `statement_candidates#8` | statement | Orthogonale Matrizen: Orthogonale Matrizen | derivation |  | proposed |
| `M6-SATZ-009` | 3.2.12 / `statement_candidates#9` | statement | Gram-Schmidt-Orthogonalisierung: Gram-Schmidt-Orthogonalisierung | derivation |  | proposed |

#### Quellpayloads

##### `M6-DEF-027` — Definition 3.2.27 — Abstand

- Herkunft: `definition_candidates#27`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
Sobald eine Norm gegeben ist, kann ich auch einen Abstand zwischen zwei Vektoren definieren:

$$d(x,y) = \text{|}x - y\text{|}\ (3.190)$$

Dabei sind

-   \(x\) und (y) die beiden betrachteten Vektoren,

-   (x-y) ihr Differenzvektor,

-   (d(x,y)) der durch die Norm bestimmte Abstand.

Diese Definition macht eine für die spätere Verwendung wichtige Trennung sichtbar:

**Vektorraum, Skalarprodukt, Norm und Abstand sind nicht dasselbe.**

Vielmehr entsteht eine strukturelle Kette:

$$\text{Skalarprodukt} \longrightarrow \text{Norm} \longrightarrow \text{Abstand}\ (3.191)$$

Diese Abhängigkeit ist für meine weitere Argumentation wichtig. Einen Abstand darf ich später nicht allein deshalb voraussetzen, weil ich Zustände als Vektoren darstelle.
```

##### `M6-DEF-028` — Definition 3.2.28 — Winkel zwischen zwei Vektoren

- Herkunft: `definition_candidates#28`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
Für zwei von null verschiedene Vektoren (x) und (y) definiere ich den Winkel (\\theta) durch

$$\cos\theta = \frac{\left\langle x,y \right\rangle}{\text{|}x\text{|}\,\text{|}y\text{|}}\ (3.194)$$

Dabei gilt

-   (x,y\\neq0),

-   (\\theta) ist der Winkel zwischen beiden Vektoren,

-   (\\langle x,y\\rangle) beschreibt ihre skalare Beziehung,

-   (\|x\|) und (\|y\|) normieren diese Beziehung auf die Längen der beiden Vektoren.

Für normierte Vektoren mit $|x| = |y| = 1$ vereinfacht sich Gleichung (3.194) zu

$$cos\theta = \langle x,y\rangle\ (3.195)$$
```

##### `M6-DEF-030` — Definition 3.2.30 — Normierter Vektor

- Herkunft: `definition_candidates#30`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
Ein Vektor (x) heißt normiert, wenn

$$\text{|}x\text{|} = 1\ (3.199)$$

Für jeden Vektor (x\\neq0) kann ich durch Division durch seine Norm einen normierten Vektor erzeugen:

$$\widehat{x} = \frac{x}{\text{|}x\text{|}}\ (3.200)$$

Dabei bezeichnet

-   \(x\) den ursprünglichen Vektor,

-   (\|x\|) seine Norm,

-   (\\hat{x}) den normierten Vektor mit derselben Richtung.

Die Normierung verändert also die Richtung nicht. Sie entfernt lediglich die ursprüngliche Länge des Vektors.
```

##### `M6-DEF-032` — Definition 3.2.32 — Orthogonales Komplement

- Herkunft: `definition_candidates#32`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Mathematisch vollständig zu erhalten, für den Hauptargumentationsgang jedoch als Vertiefung in die Anlage ausgelagert.
- Importierter Quellpayload:

```text
Sei (U\\subseteq V) ein Unterraum. Das orthogonale Komplement von (U) definiere ich als

$$U^{\bot} = \left\{ x \in V\mid\left\langle x,u \right\rangle = 0\text{ für alle }u \in U \right\}\ (3.207)$$

Dabei bezeichnet

-   \(U\) den ursprünglichen Unterraum,

-   (U\^\\perp) sein orthogonales Komplement,

-   \(u\) einen beliebigen Vektor aus (U),

-   \(x\) einen Vektor, der zu jedem Vektor aus (U) orthogonal ist.

Im endlichdimensionalen reellen Skalarproduktraum kann ich den gesamten Raum in den Unterraum und sein orthogonales Komplement zerlegen:

$$V = U \oplus U^{\bot}\ (3.208)$$

Damit besitzt jeder Vektor (x\\in V) eine eindeutige Zerlegung

$$x = u + u_{\bot},\quad\quad u \in U,\quad u_{\bot} \in U^{\bot}\ (3.209)$$

Die Zerlegung in einen Anteil innerhalb eines Unterraums und einen dazu orthogonalen Anteil bildet die Grundlage der orthogonalen Projektion. Friedberg, Insel und Spence führen orthogonale Komplemente und den Gram-Schmidt-Prozess gemeinsam in §6.2 sowie orthogonale Projektionen in §6.6 \[84\].
```

##### `M6-GL-189` — (3.190) — Definition 3.2.27: Abstand

- Herkunft: `equation_candidates#189`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
d(x,y) = \text{|}x - y\text{|}
```

##### `M6-GL-190` — (3.191) — Definition 3.2.27: Abstand

- Herkunft: `equation_candidates#190`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
\text{Skalarprodukt} \longrightarrow \text{Norm} \longrightarrow \text{Abstand}
```

##### `M6-GL-191` — (3.192) — Cauchy-Schwarz-Ungleichung

- Herkunft: `equation_candidates#191`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\left| \left\langle x,y \right\rangle \right| \leq \text{|}x\text{|}\,\text{|}y\text{|}
```

##### `M6-GL-192` — (3.193) — Cauchy-Schwarz-Ungleichung

- Herkunft: `equation_candidates#192`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
- 1 \leq \frac{\left\langle x,y \right\rangle}{\text{|}x\text{|}\,\text{|}y\text{|}} \leq 1
```

##### `M6-GL-193` — (3.194) — Definition 3.2.28: Winkel zwischen zwei Vektoren

- Herkunft: `equation_candidates#193`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
\cos\theta = \frac{\left\langle x,y \right\rangle}{\text{|}x\text{|}\,\text{|}y\text{|}}
```

##### `M6-GL-194` — (3.195) — Definition 3.2.28: Winkel zwischen zwei Vektoren

- Herkunft: `equation_candidates#194`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
cos\theta = \langle x,y\rangle
```

##### `M6-GL-196` — (3.197) — Satz des Pythagoras im Skalarproduktraum

- Herkunft: `equation_candidates#196`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\text{|}x + y\text{|}^{2} = \text{|}x\text{|}^{2} + \text{|}y\text{|}^{2}
```

##### `M6-GL-197` — (3.198) — Satz des Pythagoras im Skalarproduktraum

- Herkunft: `equation_candidates#197`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\begin{matrix}
\text{|}x + y\text{|}^{2} = \langle x + y,x + y\rangle \\
 = \langle x,x\rangle + 2\langle x,y\rangle + \langle y,y\rangle \\
 = \text{|}x\text{|}^{2} + \text{|}y\text{|}^{2}.
\end{matrix}
```

##### `M6-GL-198` — (3.199) — Definition 3.2.30: Normierter Vektor

- Herkunft: `equation_candidates#198`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
\text{|}x\text{|} = 1
```

##### `M6-GL-199` — (3.200) — Definition 3.2.30: Normierter Vektor

- Herkunft: `equation_candidates#199`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
\widehat{x} = \frac{x}{\text{|}x\text{|}}
```

##### `M6-GL-206` — (3.207) — Definition 3.2.32: Orthogonales Komplement

- Herkunft: `equation_candidates#206`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
U^{\bot} = \left\{ x \in V\mid\left\langle x,u \right\rangle = 0\text{ für alle }u \in U \right\}
```

##### `M6-GL-207` — (3.208) — Definition 3.2.32: Orthogonales Komplement

- Herkunft: `equation_candidates#207`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
V = U \oplus U^{\bot}
```

##### `M6-GL-208` — (3.209) — Definition 3.2.32: Orthogonales Komplement

- Herkunft: `equation_candidates#208`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=canonical`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Definition bzw. formale Vertiefung bleibt vollständig in der Anlage, ist aber nicht Teil des kompakten Hauptpfads.
- Importierter Quellpayload:

```text
x = u + u_{\bot},\quad\quad u \in U,\quad u_{\bot} \in U^{\bot}
```

##### `M6-GL-211` — (3.212) — Projektion auf einen Unterraum

- Herkunft: `equation_candidates#211`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{U}x = \sum_{i = 1}^{m}{\left\langle q_{i},x \right\rangle q_{i}}
```

##### `M6-GL-212` — (3.213) — Projektion auf einen Unterraum

- Herkunft: `equation_candidates#212`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{U} = QQ^{T}
```

##### `M6-GL-213` — (3.214) — Projektion auf einen Unterraum

- Herkunft: `equation_candidates#213`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{U}x = QQ^{T}x
```

##### `M6-GL-214` — (3.215) — Projektion auf einen Unterraum

- Herkunft: `equation_candidates#214`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{U}^{2} = P_{U}
```

##### `M6-GL-215` — (3.216) — Projektion auf einen Unterraum

- Herkunft: `equation_candidates#215`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
P_{U}^{T} = P_{U}
```

##### `M6-GL-216` — (3.217) — Orthogonale Zerlegung eines Vektors

- Herkunft: `equation_candidates#216`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
x = P_{U}x + \left( I - P_{U} \right)x
```

##### `M6-GL-217` — (3.218) — Orthogonale Zerlegung eines Vektors

- Herkunft: `equation_candidates#217`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\left\langle P_{U}x,\left( I - P_{U} \right)x \right\rangle = 0
```

##### `M6-GL-218` — (3.219) — Gram-Schmidt-Orthogonalisierung

- Herkunft: `equation_candidates#218`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
u_{1} = v_{1}
```

##### `M6-GL-219` — (3.220) — Gram-Schmidt-Orthogonalisierung

- Herkunft: `equation_candidates#219`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
u_{2} = v_{2} - \frac{\left\langle v_{2},u_{1} \right\rangle}{\left\langle u_{1},u_{1} \right\rangle}u_{1}
```

##### `M6-GL-220` — (3.221) — Gram-Schmidt-Orthogonalisierung

- Herkunft: `equation_candidates#220`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
u_{k} = v_{k} - \sum_{j = 1}^{k - 1}{\frac{\left\langle v_{k},u_{j} \right\rangle}{\left\langle u_{j},u_{j} \right\rangle}u_{j}}
```

##### `M6-GL-221` — (3.222) — Gram-Schmidt-Orthogonalisierung

- Herkunft: `equation_candidates#221`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
q_{k} = \frac{u_{k}}{\text{|}u_{k}\text{|}}
```

##### `M6-GL-222` — (3.223) — Gram-Schmidt-Orthogonalisierung

- Herkunft: `equation_candidates#222`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
\text{span}\text{\{}v_{1},\ldots,v_{m}\text{\}} = \text{span}\text{\{}q_{1},\ldots,q_{m}\text{\}}
```

##### `M6-GL-223` — (3.224) — Zusammenhang mit der Spektralzerlegung

- Herkunft: `equation_candidates#223`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
x = \sum_{i = 1}^{n}{\left\langle q_{i},x \right\rangle q_{i}}
```

##### `M6-GL-224` — (3.225) — Zusammenhang mit der Spektralzerlegung

- Herkunft: `equation_candidates#224`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=proof_step`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Herleitungs- oder Rechenschritt; wird aus dem Haupttext ausgelagert, bleibt aber vollständig referenzierbar.
- Importierter Quellpayload:

```text
Ax = \sum_{i = 1}^{n}{\lambda_{i}\left\langle q_{i},x \right\rangle q_{i}}
```

##### `M6-GL-225` — (3.226) — \\langle x,y\\rangle

- Herkunft: `equation_candidates#225`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\left\langle x,y \right\rangle = 3( - 4) + 4(3) = 0
```

##### `M6-GL-226` — (3.227) — \\langle x,y\\rangle

- Herkunft: `equation_candidates#226`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
x\bot y
```

##### `M6-GL-227` — (3.228) — \\langle x,y\\rangle

- Herkunft: `equation_candidates#227`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\text{|}x\text{|} = \sqrt{3^{2} + 4^{2}} = 5
```

##### `M6-GL-228` — (3.229) — \\langle x,y\\rangle

- Herkunft: `equation_candidates#228`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\text{|}y\text{|} = \sqrt{( - 4)^{2} + 3^{2}} = 5
```

##### `M6-GL-229` — (3.230) — \\langle x,y\\rangle

- Herkunft: `equation_candidates#229`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Mathematisches Detail bleibt vollständig erhalten, wird aber zur Straffung des Haupttextes in die thematisch passende Anlage ausgelagert.
- Importierter Quellpayload:

```text
\widehat{x} = \begin{pmatrix}
3\text{/}5 \\
4\text{/}5
\end{pmatrix},\quad\quad\widehat{y} = \begin{pmatrix}
 - 4\text{/}5 \\
3\text{/}5
\end{pmatrix}
```

##### `M6-GL-232` — (3.233) — Methodologische Betrachtungen

- Herkunft: `equation_candidates#232`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Wiederholende methodische/didaktische Formalisierung; in Anlage dokumentiert statt im Hauptfluss wiederholt.
- Importierter Quellpayload:

```text
\text{Vektorraum} \longrightarrow \text{Skalarproduktraum} \longrightarrow \text{Norm} \longrightarrow \text{Abstand und Winkel}
```

##### `M6-GL-233` — (3.234) — Didaktische Betrachtungen

- Herkunft: `equation_candidates#233`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=supporting`, `equation_role=derived`
- Klassifikationsstatus: `proposed`
- Quellintegrität: `ok`
- Klassifikationsgrund: Wiederholende methodische/didaktische Formalisierung; in Anlage dokumentiert statt im Hauptfluss wiederholt.
- Importierter Quellpayload:

```text
\text{Skalarprodukt} \longrightarrow \text{Länge und Winkel} \longrightarrow \text{Orthogonalität} \longrightarrow \text{Projektion} \longrightarrow \text{orthonormale Zerlegung}
```

##### `M6-SATZ-006` — Cauchy-Schwarz-Ungleichung — Cauchy-Schwarz-Ungleichung

- Herkunft: `statement_candidates#6`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Herleitung, Hilfssatz oder Verfahren bleibt vollständig in der mathematischen Anlage dokumentiert.
- Importierter Quellpayload:

```text
Zwischen Skalarprodukt und Norm besteht ein grundlegender Zusammenhang. Für alle (x,y\\in V) gilt

$$\left| \left\langle x,y \right\rangle \right| \leq \text{|}x\text{|}\,\text{|}y\text{|}\ (3.192)$$

Diese Cauchy-Schwarz-Ungleichung begrenzt den Betrag des Skalarprodukts durch das Produkt der beiden Vektorlängen. Sie ist insbesondere notwendig, um aus einem Skalarprodukt einen Winkelbegriff konsistent abzuleiten.

Für (x\\neq0) und (y\\neq0) folgt nämlich

$$- 1 \leq \frac{\left\langle x,y \right\rangle}{\text{|}x\text{|}\,\text{|}y\text{|}} \leq 1\ (3.193)$$

Damit liegt der Quotient im Definitionsbereich der inversen Kosinusfunktion.
```

##### `M6-SATZ-007` — Satz des Pythagoras im Skalarproduktraum — Satz des Pythagoras im Skalarproduktraum

- Herkunft: `statement_candidates#7`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Herleitung, Hilfssatz oder Verfahren bleibt vollständig in der mathematischen Anlage dokumentiert.
- Importierter Quellpayload:

```text
Sind (x) und (y) orthogonal, gilt

$$\text{|}x + y\text{|}^{2} = \text{|}x\text{|}^{2} + \text{|}y\text{|}^{2}\ (3.197)$$

Das kann ich unmittelbar aus dem Skalarprodukt herleiten:

$$\begin{matrix}
\text{|}x + y\text{|}^{2} = \langle x + y,x + y\rangle \\
 = \langle x,x\rangle + 2\langle x,y\rangle + \langle y,y\rangle \\
 = \text{|}x\text{|}^{2} + \text{|}y\text{|}^{2}.
\end{matrix}\ (3.198)$$

Im letzten Schritt verwende ich (\\langle x,y\\rangle=0).

Damit ist der Satz des Pythagoras keine isolierte geometrische Besonderheit des zweidimensionalen Raums, sondern eine unmittelbare Folge der Orthogonalität in einem Skalarproduktraum.
```

##### `M6-SATZ-008` — Orthogonale Matrizen — Orthogonale Matrizen

- Herkunft: `statement_candidates#8`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Herleitung, Hilfssatz oder Verfahren bleibt vollständig in der mathematischen Anlage dokumentiert.
- Importierter Quellpayload:

```text
Fasse ich eine orthonormale Basis spaltenweise in einer Matrix (Q) zusammen, dann gilt

$$Q^{T}Q = I\ (3.203)$$

Damit folgt

$$Q^{- 1} = Q^{T}\ (3.204)$$

Eine solche Matrix heißt orthogonal.

Orthogonale Transformationen erhalten das euklidische Skalarprodukt:

$$\langle Qx,Qy\rangle = \langle x,y\rangle\ (3.205)$$

Daraus folgt unmittelbar die Erhaltung der Norm:

$$\text{|}Qx\text{|} = \text{|}x\text{|}\ (3.206)$$

Damit erhalten orthogonale Transformationen Längen und Winkel. Sie verändern also die Koordinatendarstellung, nicht jedoch die durch das euklidische Skalarprodukt bestimmte Geometrie.

Diese Eigenschaft ist der Grund dafür, warum die orthogonale Diagonalisierung aus Abschnitt 3.2.11 mathematisch stärker ist als ein beliebiger Basiswechsel.
```

##### `M6-SATZ-009` — Gram-Schmidt-Orthogonalisierung — Gram-Schmidt-Orthogonalisierung

- Herkunft: `statement_candidates#9`, Abschnitt `3.2.12`
- Profil: `document_location=appendix`, `importance_level=derivation`, `equation_role=NULL`
- Klassifikationsstatus: `proposed`
- Klassifikationsgrund: Herleitung, Hilfssatz oder Verfahren bleibt vollständig in der mathematischen Anlage dokumentiert.
- Importierter Quellpayload:

```text
Eine beliebige linear unabhängige Basis ist im Allgemeinen nicht orthogonal. Ich kann sie jedoch systematisch in eine orthonormale Basis desselben Unterraums überführen. Dieses Verfahren ist die Gram-Schmidt-Orthogonalisierung \[74, 84\]. Strang behandelt sie ausdrücklich in §4.4, Friedberg, Insel und Spence in §6.2.

Seien $v_{1},\ldots,v_{m}$ linear unabhängige Vektoren.

Ich beginne mit

$$u_{1} = v_{1}\ (3.219)$$

Für den zweiten Vektor entferne ich aus (v_2) den Anteil in Richtung von (u_1):

$$u_{2} = v_{2} - \frac{\left\langle v_{2},u_{1} \right\rangle}{\left\langle u_{1},u_{1} \right\rangle}u_{1}\ (3.220)$$

Allgemein erhalte ich

$$u_{k} = v_{k} - \sum_{j = 1}^{k - 1}{\frac{\left\langle v_{k},u_{j} \right\rangle}{\left\langle u_{j},u_{j} \right\rangle}u_{j}}\ (3.221)$$

Die so erzeugten Vektoren (u_1,\\ldots,u_m) sind paarweise orthogonal.

Durch anschließende Normierung

$$q_{k} = \frac{u_{k}}{\text{|}u_{k}\text{|}}\ (3.222)$$

erhalte ich eine orthonormale Basis (q_1,\\ldots,q_m).

Dabei bleibt der aufgespannte Unterraum erhalten:

$$\text{span}\text{\{}v_{1},\ldots,v_{m}\text{\}} = \text{span}\text{\{}q_{1},\ldots,q_{m}\text{\}}\ (3.223)$$

Das Verfahren verändert damit nicht den betrachteten Unterraum. Es ersetzt lediglich eine beliebige linear unabhängige Basis durch eine geometrisch günstigere orthonormale Basis.
```

## 15. Deep-Research-Quellenregister

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

## 16. Vollständige Deep-Research-Evidenzmatrix

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

## 17. Schreib- und Nummerierungsregeln für die Anlagen

1. Der technische `appendix_anchor` ist unveränderlich und muss in DB und Arbeitsnotizen erhalten bleiben.
2. Die sichtbare Dissertation-Nummerierung der Anlagen wird **nicht** aus den alten 3.2-Gleichungsnummern abgeleitet. Alte Nummern wie `(3.98)` sind Herkunftsmarker.
3. Solange keine kanonische sichtbare Anlagenzählung beschlossen und in der DB gespeichert ist, darf der Chat keine vermeintlich endgültigen Nummern wie `(M3.17)` erfinden. Im Arbeitsprozess wird der `appendix_anchor` verwendet.
4. Bei späterer sichtbarer Anlagenzählung muss eine eigene Mapping-/Nummerierungsschicht revisionsgesichert eingeführt werden; der technische Anker bleibt bestehen.
5. Definitionen, Sätze und Gleichungen werden in den Anlagen nur dann eigenständig neu nummeriert, wenn dies im Repository ausdrücklich registriert ist.
6. Verweise aus dem Haupttext auf Anlagen müssen technisch auf den stabilen Anker auflösbar sein.

## 18. Qualitäts- und Konsistenzregeln

- Keine mathematische Aussage darf durch die Auslagerung verlorengehen.
- Kein `appendix`-Objekt darf ohne `appendix_module_id` und `appendix_anchor` existieren.
- Keine reine Herleitung und kein Beispiel darf ohne neue Klassifikationsrevision zurück in den Haupttext wandern.
- Jede Gleichung benötigt eine `equation_role`.
- Ein Objekt mit `proof_step` oder `example` ist grundsätzlich Anlagenmaterial.
- Literaturbelege müssen behauptungsbezogen sein. Allgemeine Buchmetadaten ersetzen keinen Beleg der konkreten Aussage.
- `support_fit='partial'` verlangt entweder vorsichtigere Formulierung oder zusätzliche Evidenz.
- Beschädigte Quellformeln (`source_integrity_status != 'ok'`) müssen als Issue behandelt werden.
- Word-LaTeX muss vor Freigabe geprüft sein.
- UTF-8 / Kollation: `utf8mb4_unicode_ci`; vor Repository-Skripten `SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci; SET collation_connection='utf8mb4_unicode_ci';`.
- Repository-Skripte sollen nach Möglichkeit gegen eine aus dem tatsächlichen Dump rekonstruierte Testdatenbank ausgeführt werden, einschließlich Transaktion, Procedure-Aufrufen soweit vorhanden, Post-Gates und Validierungsabfragen.

## 19. Arbeitsmodus je Modul

Der Anlagen-Chat arbeitet **modulweise** und innerhalb des Moduls abschnittsweise nach dem Weiter-Skript-Verfahren. Empfohlene Reihenfolge: `M1 → M2 → M3 → M4 → M5 → M6`, sofern der Nutzer keine andere Reihenfolge vorgibt. Für jeden Teilabschnitt gilt:

1. relevante Objektanker bestimmen;
2. mathematische Reihenfolge und Abhängigkeiten prüfen;
3. Literaturbelege laden;
4. vollständigen Anlagentext im Chat schreiben;
5. Formeln + Word-LaTeX prüfen;
6. SQL-Revision erzeugen und als Datei bereitstellen;
7. Gates prüfen;
8. erst danach zum nächsten Teilabschnitt.

## 20. Was der Anlagen-Chat ausdrücklich nicht tun darf

- den Haupttext 3.2 neu schreiben oder kürzen;
- die 3.3-Axiomatik verändern;
- Anwendungen aus Kapitel 6 in die Anlagen ziehen;
- etablierte Mathematik als eigene FRZK-Theorie ausgeben;
- Quellen, Seitenzahlen oder Zitate erfinden;
- alte Quellenziffern ungeprüft neu vergeben;
- die historische 3.1-Basisschicht löschen oder durch eine vereinfachte DB ersetzen;
- SQL nur statisch schreiben und ungeprüft als erfolgreich getestet bezeichnen;
- beschädigte Ausgangsformeln still korrigieren;
- sichtbare Anlagen-/Gleichungsnummern ohne Repository-Mapping erfinden.

## 21. Abschlusskriterium eines Anlagenmoduls

Ein Modul darf erst auf `status='final'` gesetzt werden, wenn alle ihm zugeordneten `appendix`-Objekte in einer freigegebenen Anlagenfassung enthalten oder begründet supersediert sind, sämtliche Literaturverwendungen Evidenz besitzen, alle Formeln Word-LaTeX enthalten, alle relevanten Issues gelöst bzw. bewusst akzeptiert sind, die Repository-Gates bestehen und der vollständige Anlagen-Fließtext revisionsgesichert in der DB gespeichert ist.

---

**Kurzform für den neuen Chat:** Arbeite ausschließlich an M1–M6. Bewahre den mathematischen Bestand vollständig, verlagere nur gemäß DB-Profil, nutze `appendix_anchor` als stabilen technischen Schlüssel, belege Literatur über die Deep-Research-Evidenz, gib Anlagentext vollständig im Chat aus und SQL ausschließlich als Datei. Keine stillen Korrekturen, keine erfundenen Quellen, keine unregistrierte Nummerierung und keine Änderungen am Haupttext oder an 3.3.
