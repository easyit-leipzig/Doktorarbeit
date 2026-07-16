# ==================================================================================================
# MD-FORTSETZUNG – NÄCHSTES KAPITEL 3.4
# ==================================================================================================

```yaml
handoff:
  format_name: frzk_chapter_continuation
  format_version: "2.0"
  generated_on: "2026-07-15"
  language: de
  status: verbindliche_arbeitsgrundlage
  next_chapter: "3.4"
  next_action: "Neuen Chat starten und diese MD-Datei als primäre Kontextquelle bereitstellen."

project:
  type: dissertation
  short_name: FRZK
  title: "Funktionales Raum-Zeit-Kohärenzsystem"
  author: "Olaf Thiele"
  working_language: de
  database_name: frzk_rkb
  chapter_3_purpose:
    - "Kapitel 3.1 entwickelt die begrifflichen Grundlagen."
    - "Kapitel 3.2 stellt die etablierten mathematischen Grundlagen und ihre systematische Grenze dar."
    - "Kapitel 3.3 formuliert die qualitativen axiomatischen Grundlagen."
    - "Kapitel 3.4 rekonstruiert daraus die mathematische Organisation."
  core_research_transition:
    from: "Beschreibung bereits vorausgesetzter mathematischer Strukturen"
    to: "Axiomatische Grundlegung der funktionalen Strukturgenese"
    research_gap: >
      Es fehlt ein formales System, das die Entstehung, Veränderung und Stabilisierung
      funktionaler Relationen sowie die daraus hervorgehende Rekonstruktion von Raum,
      Zeit und Kohärenz erklärt, ohne geometrischen Raum und externe Zeit als primitive
      Größen vorauszusetzen.

authoring_state:
  chapter_3_1:
    status: abgeschlossen
  chapter_3_2:
    status: abgeschlossen
    final_section: "3.2.12"
    last_source_number_used: 81
    last_equation_number_used: "3.274"
    next_source_number: 82
    next_equation_number: "3.275"
    last_repository_revision: "RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5"
    master_sql: "Kapitel_3_3_MASTER_FINAL.sql"
    master_sql_basis_dump: "frzk_rkb_backup_vor_korrektur_3.2.2.sql"
    control_dump: "frzk_rkb_nach_repository_update_3.2.2(2).sql"
    expected_repository_counters:
      next_citation_number: "82"
      next_equation_number: "3.275"
      last_edited_section: "3.2.12"
      last_repository_revision: "RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5"
    runtime_validation:
      status: "nicht_in_dieser_umgebung_ausgeführt"
      reason: "Kein laufender MySQL-/MariaDB-Server in der Erstellungsumgebung."
      requirement: >
        Vor Beginn von Kapitel 3.3 müssen die Audit-Abfragen am Ende von
        Kapitel_3_3_MASTER_FINAL.sql nach realem Import geprüft werden.
  chapter_3_3:
    status: abgeschlossen
    final_section: "3.3.9.10"
    last_source_number_used: 95
    last_equation_number_used: "3.339"
    next_source_number: 96
    next_equation_number: "3.340"
    last_repository_revision: "RKB-2026-07-16-K3.3-FINAL-V1"
    next_section_title: "Einleitung und Funktion der axiomatischen Grundlegung"
  chapter_3_4:
    status: noch_nicht_begonnen
    next_section: "3.4.1"
    next_section_title: "Motivation und mathematische Rekonstruktion funktionaler Zustände"

mandatory_workflow:
  section_processing:
    - step: 1
      action: "Aktuelle Abschnittsarchitektur und Übergang aus dem vorherigen Abschnitt prüfen."
    - step: 2
      action: "Literaturbedarf und bereits vorhandene Quellen prüfen."
    - step: 3
      action: "Abschnitt vollständig als Dissertationstext schreiben."
    - step: 4
      action: >
        Sobald der Abschnitt vollständig abgeschlossen ist, automatisch das vollständige
        Repository-Revisionsskript als echte .sql-Datei erzeugen.
    - step: 5
      action: "Skript strukturell prüfen und Downloadlink bereitstellen."
    - step: 6
      action: >
        Erst auf das nächste 'weiter' mit dem Text des folgenden Abschnitts beginnen.
  continue_keyword: "weiter"
  interpretation_of_continue:
    section_incomplete: "Nächsten Textteil desselben Abschnitts schreiben."
    section_complete_but_script_missing: "Automatisch zuerst das Repository-Skript erzeugen."
    section_and_script_complete: "Nächsten Abschnitt beginnen."
  prohibitions:
    - "Keinen neuen Abschnitt beginnen, wenn das Skript des vorherigen Abschnitts fehlt."
    - "Keine Datei ankündigen, die nicht tatsächlich erzeugt wurde."
    - "Keine Platzhalter-SQL-Dateien erzeugen."
    - "Keine gekürzten Skripte als vollständig bezeichnen."
    - "Keine Änderung von Nummerierungsständen ohne Datenbank- und Textabgleich."
    - "Keine nicht validierten Tabellen- oder Spaltennamen erfinden."

writing_style:
  perspective: "Ich-Form"
  voice:
    - persönlich_wissenschaftlich
    - argumentativ
    - präzise
    - dissertationsgeeignet
  prose_rules:
    - "Fließende, kohärente Absätze."
    - "Keine isolierten Ein-Satz-Absätze."
    - "Keine stichpunktartige Lehrbuchsprache im eigentlichen Dissertationstext."
    - "Jeder neue Abschnitt muss logisch aus dem vorherigen hervorgehen."
    - "Keine unnötigen Wiederholungen."
    - "Bestehende Mathematik und FRZK-Eigenleistung klar trennen."
    - "In Kapitel 3.3 qualitative Axiome formulieren; detaillierte mathematische Rekonstruktionen primär Kapitel 3.4 vorbehalten."
  scientific_boundary:
    chapter_3_2: "Etablierter mathematischer Forschungsstand und Forschungslücke."
    chapter_3_3: "Axiomatische FRZK-Grundannahmen, möglichst prämathematisch bzw. nur minimal formalisiert."
    chapter_3_4: "Mathematische Rekonstruktion aus den Axiomen."

literature_rules:
  numbering:
    type: global_continuous
    next_number: 82
    no_renumbering_existing_sources: true
  first_mention_format: "(vollständige bibliografische Quellenbeschreibung) **[Nr.]**"
  later_mention_format: "[Nr.]"
  source_reuse:
    preserve_existing_number: true
    create_new_number_only_if_source_not_yet_registered: true
  bibliography:
    chapter_master_bibliography: true
    output_timing: >
      Am Abschluss eines vollständigen Kapitels oder eines ausdrücklich als abgeschlossen
      bezeichneten Hauptabschnitts das aktualisierte Literaturverzeichnis ausgeben.
  source_quality:
    priorities:
      - Primärquelle
      - Originalpublikation
      - internationales Standardwerk
      - hochwertige Reviewliteratur
    verification:
      - bibliografische Angaben prüfen
      - DOI oder stabile Verlagsangaben nach Möglichkeit ergänzen
      - Quellenstatus in der Datenbank korrekt setzen
  database_start:
    next_citation_number: 82

equation_rules:
  numbering:
    type: global_continuous_in_chapter_3
    next_equation: "3.275"
    unique_globally_in_database: true
  display:
    - "Jede dargestellte oder geänderte Gleichung erhält unmittelbar darunter eine Word-LaTeX-Zeile."
    - "Präfix exakt: Word-LaTeX:"
  word_latex:
    must_not_be_empty: true
    matrices: "pmatrix"
    matrix_rows: "mit doppeltem Backslash; auch letzte Matrixzeile nach bisheriger Nutzerkonvention"
    determinants: "\\left|...\\right|"
    symbol_notation: "nur die mittlere mathematische Notation, keine alternativen Darstellungen"
  chapter_3_3_guidance:
    - "Axiome nicht unnötig mit umfangreicher Mathematik überladen."
    - "Formeln nur verwenden, wenn sie die axiomatische Aussage wirklich präzisieren."
    - "Herleitungen, Operatoren und rekonstruktive Gleichungssysteme in Kapitel 3.4 entwickeln."

repository_workflow:
  repository_name: frzk_rkb
  current_master_file: "Kapitel_3_3_MASTER_FINAL.sql"
  chapter_3_3_target:
    final_master_file: "Kapitel_3_3_MASTER_FINAL.sql"
    parent_revision: "RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5"
  every_section_script_must_include_when_applicable:
    - repository_revisions
    - dissertation_sections
    - section_change_log
    - authors
    - sources
    - source_authors
    - annotations
    - source_usage
    - definitions
    - equations
    - equation_symbols
    - symbols
    - figures
    - dissertation_tables
    - repository_counters
    - audit_queries
  sql_standard:
    dialect: "MariaDB/MySQL"
    database_selection: "USE `frzk_rkb`;"
    charset: "SET NAMES utf8mb4;"
    transaction_required: true
    idempotent_required: true
    preferred_upsert: "INSERT ... ON DUPLICATE KEY UPDATE"
    revision_parent_lookup: >
      Parent-Revision zuerst in Variable laden; niemals dieselbe Tabelle gleichzeitig
      als INSERT-Ziel und SELECT-Quelle verwenden.
    real_file_required: true
    no_placeholder_comments: true
    import_after_error: "Skript nach Fehlerkorrektur vollständig von Anfang an neu ausführen."
  validation_after_each_section:
    - "Revision existiert."
    - "Parent-Revision ist korrekt."
    - "Abschnitt ist vorhanden und Status gültig."
    - "Neue Quellen und Autoren sind vollständig verknüpft."
    - "source_usage ist vorhanden."
    - "Definitionen sind registriert."
    - "Gleichungsnummern sind global eindeutig."
    - "Word-LaTeX ist nicht leer."
    - "equation_symbols enthalten keine Dubletten."
    - "Abschnittssymbole sind korrekt registriert."
    - "section_change_log enthält die tatsächlichen Änderungen."
    - "repository_counters zeigen den nächsten freien Stand."
    - "Keine verwaisten Fremdschlüsselobjekte."
  chapter_completion:
    - "Einzelrevisionen zu einer Masterdatei zusammenführen."
    - "Kapitelweites Audit einfügen."
    - "Masterdatei gegen den verbindlichen Ausgangsdump testen."
    - "Auditbericht und Importreihenfolge dokumentieren."

known_errors_do_not_repeat:
  mysql_1093:
    description: "INSERT in repository_revisions mit gleichzeitigem SELECT aus repository_revisions."
    prevention: "Parent-ID vorab in @parent_revision_id speichern."
  mysql_1062_equation_number:
    description: "Doppelte globale equation_number."
    prevention: "Vor Einfügen Altartefakte kontrolliert bereinigen und Gleichungsnummern global prüfen."
  mysql_1062_equation_symbol:
    description: "Doppelter Schlüssel (equation_id, symbol_latex)."
    prevention: "equation_symbols immer mit ON DUPLICATE KEY UPDATE behandeln."
  mysql_1054_author_role:
    description: "Spalte author_role existiert nicht."
    prevention: "In source_authors ausschließlich Spalte role verwenden."
  invalid_enum_values:
    examples:
      - "dissertation_sections.status = complete ist ungültig."
      - "definitions.provenance = author_synthesis ist ungültig."
      - "source_usage.usage_type = synthesis ist ungültig."
      - "section_change_log.change_type = validated ist ungültig."
    prevention: "Nur die in der Schema-Signatur aufgeführten ENUM-Werte verwenden."
  virtual_file:
    description: "Downloadlink wurde genannt, obwohl Datei nicht erzeugt war."
    prevention: "Datei zuerst real erzeugen und Pfad prüfen; erst dann verlinken."
  incomplete_script:
    description: "Skript enthielt Kommentare als Platzhalter statt vollständiger Inserts."
    prevention: "Nur vollständig ausgearbeitete SQL-Dateien als final ausgeben."
  auto_increment_misinterpretation:
    description: "Hohe source_id wurde mit Literaturziffer verwechselt."
    prevention: "Interne IDs und citation_number strikt unterscheiden."

chapter_3_3_architecture:
  authority: >
    Vor Beginn anhand der aktuellsten Strukturdatei und des Gesamtchats prüfen.
    Die folgende Liste ist eine Übergabestruktur und darf nur nach Dokumentabgleich
    verändert werden.
  planned_sections:
    - code: "3.3.1"
      title: "Einleitung und Funktion der axiomatischen Grundlegung"
      purpose: >
        Übergang aus der Forschungslücke von 3.2; Begründung, weshalb eine eigene
        axiomatische Ebene benötigt wird und weshalb sie der mathematischen
        Rekonstruktion in 3.4 vorausgehen muss.
    - code: "3.3.2"
      title: "Axiom A1 – Existenz funktionaler Zustände"
      purpose: "Grundannahme unterscheidbarer funktionaler Zustände."
    - code: "3.3.3"
      title: "Axiom A2 – Funktionale Relationierbarkeit"
      purpose: "Grundannahme, dass funktionale Zustände relationierbar sind."
    - code: "3.3.4"
      title: "Axiom A3 – Dynamische Zustandsänderung"
      purpose: "Grundannahme gerichteter funktionaler Zustandsänderungen."
    - code: "3.3.5"
      title: "Axiom A4 – Funktionale Kohärenz"
      purpose: "Grundannahme kohärenzbildender und kohärenzerhaltender Organisation."
    - code: "3.3.6"
      title: "Axiom A5 – Emergenz funktionaler Organisation"
      purpose: "Grundannahme übergeordneter Organisationsformen aus Relationen."
    - code: "3.3.7"
      title: "Axiomatische Konsequenzen und Abgrenzungen"
      purpose: "Konsequenzen darstellen, ohne die vollständige Mathematik von 3.4 vorwegzunehmen."
    - code: "3.3.8"
      title: "Konsistenz, Minimalität und Unabhängigkeit"
      purpose: "Axiomatische Rollen, Abhängigkeiten und Nichtredundanz diskutieren."
    - code: "3.3.9"
      title: "Vergleich mit bestehenden axiomatischen und systemtheoretischen Ansätzen"
      purpose: "FRZK-Axiomatik wissenschaftlich einordnen und abgrenzen."
    - code: "3.3.10"
      title: "Übergang zur mathematischen Rekonstruktion"
      purpose: "Explizite Anschlussbedingungen für Kapitel 3.4 formulieren."
  critical_note: >
    Frühere Projektdateien können eine abweichende Feinstruktur enthalten.
    Vor dem Schreiben von 3.3.1 müssen insbesondere
    "Neue Struktur(4).docx",
    "3.4 Mathematische Rekonstruktion des Funktionalen Raum-Zeit-Kohärenzsystems.docx",
    "Kapitel 3 - Kapitel 3.1-34_Zwischenstand_12.07.26_ Architektur.md"
    und der exportierte Gesamtchat abgeglichen werden.

required_files_for_new_chat:
  primary:
    - "Gesamtchat als .md mit diesem Übergabeblock am Ende"
  strongly_recommended:
    - "Kapitel_3_3_MASTER_FINAL.sql"
    - "Kapitel_3_2_MASTER_FINAL_Audit.md"
    - "frzk_rkb_backup_vor_korrektur_3.2.2.sql"
    - "aktueller Datenbankdump nach erfolgreichem Import des Kapitel-3.2-Masters"
    - "3.4 Mathematische Rekonstruktion des Funktionalen Raum-Zeit-Kohärenzsystems.docx"
    - "Neue Struktur(4).docx"
    - "Kapitel 3 - Kapitel 3.1-34_Zwischenstand_12.07.26_ Architektur.md"
    - "Kapitel 3 - Kapitelstruktur Neuaufbau_Gesamtchat 3.1.md"
  preferred_database_file_for_3_3:
    description: >
      Nach erfolgreichem Import des Kapitel-3.2-Masters einen neuen vollständigen
      Dump erstellen und im nächsten Chat als alleinige aktuelle Zentraldatenbank verwenden.
    suggested_filename: "frzk_rkb_nach_Kapitel_3_3_MASTER_FINAL.sql"

start_instruction_for_new_chat: |
  Lies zuerst den MD-Fortsetzungsblock vollständig.

  Prüfe danach die hochgeladenen Architektur- und Kapiteldateien für Kapitel 3.3.
  Behandle den aktuellen Datenbankdump nach Kapitel 3.2 als zentrale Datenbankgrundlage.

  Bestätige vor dem Schreiben:
  - letzter Literaturverweis [81],
  - nächste Literaturquelle [82],
  - letzte Gleichung (3.274),
  - nächste Gleichung (3.275),
  - letzte Revision RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5,
  - nächster Abschnitt 3.3.1.

  Beginne anschließend unmittelbar mit dem vollständigen Text von 3.3.1.
  Nach vollständigem Abschluss von 3.3.1 erzeuge automatisch eine vollständige,
  reale und idempotente SQL-Datei nach der Schema-Signatur dieses Dokuments.
  Beginne erst nach dem nächsten "weiter" mit 3.3.2.
```

# ==================================================================================================
# REPOSITORY-SCHEMA-SIGNATUR
# Verbindliche Referenz aus frzk_rkb_backup_vor_korrektur_3.2.2.sql
# ==================================================================================================

```yaml
repository_schema_signature:
  source_dump: "frzk_rkb_backup_vor_korrektur_3.2.2.sql"
  database: frzk_rkb
  id_policy:
    internal_primary_keys: "AUTO_INCREMENT; Werte dürfen Lücken besitzen."
    literature_identity: "citation_number und source_key, nicht source_id"
    equation_identity: "equation_number ist global eindeutig"
    section_identity: "section_code ist eindeutig"
    revision_identity: "revision_code ist eindeutig"

  tables:

    repository_revisions:
      primary_key: revision_id
      unique_keys:
        - revision_code
      columns:
        revision_id: "bigint unsigned, AUTO_INCREMENT"
        revision_code: "varchar(100), NOT NULL"
        revision_date: "datetime, NOT NULL"
        scope_type:
          type: enum
          allowed:
            - repository
            - chapter
            - section
            - source
            - equation
            - definition
            - statement
            - figure
            - table
            - symbol
            - acronym
            - axiom
            - assumption
            - proof
            - proposition
        scope_reference: "varchar(255), NULL"
        version_label: "varchar(100), NOT NULL"
        summary: "text, NOT NULL"
        created_by: "varchar(255), default Olaf Thiele / ChatGPT"
        parent_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        parent_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL
          on_update: CASCADE
      critical_rule: "Parent-ID vor dem INSERT in eine Variable laden, um MySQL #1093 zu vermeiden."

    dissertation_sections:
      primary_key: section_id
      unique_keys:
        - section_code
      columns:
        section_id: "bigint unsigned, AUTO_INCREMENT"
        parent_section_id: "bigint unsigned, NULL"
        section_code: "varchar(50), NOT NULL"
        title: "varchar(500), NOT NULL"
        chapter_no: "int, NOT NULL"
        section_order: "decimal(10,4), NOT NULL"
        status:
          type: enum
          allowed:
            - planned
            - draft
            - review
            - final
        is_original_contribution: "tinyint(1), default 0"
        notes: "text, NULL"
        created_at: "timestamp"
        updated_at: "timestamp, auto update"
      foreign_keys:
        parent_section_id:
          references: "dissertation_sections.section_id"
          on_delete: SET_NULL
          on_update: CASCADE
      forbidden_status_values:
        - complete
        - completed
        - approved

    section_change_log:
      primary_key: change_id
      columns:
        change_id: "bigint unsigned, AUTO_INCREMENT"
        revision_id: "bigint unsigned, NOT NULL"
        section_id: "bigint unsigned, NOT NULL"
        change_type:
          type: enum
          allowed:
            - created
            - rewritten
            - edited
            - renumbered
            - source_added
            - source_reused
            - equation_added
            - equation_changed
            - definition_added
            - statement_added
            - proof_added
            - assumption_added
            - axiom_added
            - proposition_added
            - figure_added
            - table_added
            - symbol_added
            - acronym_added
            - status_changed
            - other
        object_type: "varchar(100), NULL"
        object_reference: "varchar(255), NULL"
        change_summary: "text, NOT NULL"
        previous_value: "longtext, NULL"
        new_value: "longtext, NULL"
        changed_at: "timestamp"
      foreign_keys:
        revision_id:
          references: "repository_revisions.revision_id"
          on_delete: CASCADE
          on_update: CASCADE
        section_id:
          references: "dissertation_sections.section_id"
          on_delete: CASCADE
          on_update: CASCADE
      forbidden_change_types:
        - validated
        - completed
        - source_updated

    sources:
      primary_key: source_id
      unique_keys:
        - source_key
        - citation_number
      columns:
        source_id: "bigint unsigned, AUTO_INCREMENT"
        citation_number: "int unsigned, NULL, global eindeutig"
        source_key: "varchar(150), NOT NULL, eindeutig"
        source_type:
          type: enum
          allowed:
            - journal_article
            - book
            - book_chapter
            - conference_paper
            - thesis
            - report
            - standard
            - website
            - historical_work
            - edited_volume
            - other
        title: "varchar(1000), NOT NULL"
        subtitle: "varchar(1000), NULL"
        year_original: "smallint, NULL"
        year_edition: "smallint, NULL"
        journal: "varchar(500), NULL"
        publisher: "varchar(500), NULL"
        place: "varchar(255), NULL"
        volume: "varchar(100), NULL"
        issue: "varchar(100), NULL"
        pages: "varchar(100), NULL"
        edition: "varchar(100), NULL"
        doi: "varchar(255), NULL"
        isbn: "varchar(100), NULL"
        url: "varchar(1500), NULL"
        language_code: "char(2), default de"
        priority: "tinyint unsigned, default 3"
        evidence_type:
          type: enum
          allowed:
            - primary
            - secondary
            - review
            - textbook
            - historical
            - reference
        frzk_relevance: "tinyint unsigned, default 0"
        verification_status:
          type: enum
          allowed:
            - imported
            - partially_verified
            - verified
            - needs_review
        first_citation_section_code: "varchar(50), NULL"
        first_citation_note: "text, NULL"
        full_citation_text: "text, NOT NULL"
        short_citation_text: "varchar(500), NULL"
        notes: "text, NULL"
        created_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        created_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL
          on_update: CASCADE
      critical_rules:
        - "citation_number niemals aus source_id ableiten."
        - "Vor Neuanlage prüfen, ob source_key oder citation_number bereits existiert."
        - "Neue Quelle in Kapitel 3.4 beginnt bei [96]."

    authors:
      primary_key: author_id
      unique_keys:
        - normalized_name
      columns:
        author_id: "bigint unsigned, AUTO_INCREMENT"
        family_name: "varchar(255), NOT NULL"
        given_names: "varchar(255), NULL"
        normalized_name: "varchar(500), NOT NULL, eindeutig"
        orcid: "varchar(50), NULL"
        birth_year: "smallint, NULL"
        death_year: "smallint, NULL"
        notes: "text, NULL"

    source_authors:
      primary_key:
        - source_id
        - author_id
        - role
      unique_keys:
        - "source_id + role + author_order"
      columns:
        source_id: "bigint unsigned, NOT NULL"
        author_id: "bigint unsigned, NOT NULL"
        author_order: "smallint unsigned, NOT NULL"
        role:
          type: enum
          allowed:
            - author
            - editor
            - translator
      foreign_keys:
        source_id:
          references: "sources.source_id"
          on_delete: CASCADE
          on_update: CASCADE
        author_id:
          references: "authors.author_id"
          on_update: CASCADE
      critical_rule: "Spaltenname ist role, niemals author_role."

    annotations:
      primary_key: annotation_id
      unique_keys:
        - source_id
      columns:
        annotation_id: "bigint unsigned, AUTO_INCREMENT"
        source_id: "bigint unsigned, NOT NULL"
        contribution: "text, NULL"
        significance_for_dissertation: "text, NULL"
        citation_reason: "text, NULL"
        adopted_claims: "text, NULL"
        limitations: "text, NULL"
        scientific_discussion: "text, NULL"
        annotation_status:
          type: enum
          allowed:
            - draft
            - reviewed
            - approved
        reviewed_at: "datetime, NULL"
      foreign_keys:
        source_id:
          references: "sources.source_id"
          on_delete: CASCADE
          on_update: CASCADE

    source_usage:
      primary_key: usage_id
      columns:
        usage_id: "bigint unsigned, AUTO_INCREMENT"
        source_id: "bigint unsigned, NOT NULL"
        section_id: "bigint unsigned, NOT NULL"
        usage_type:
          type: enum
          allowed:
            - first_citation
            - background
            - definition
            - theorem
            - method
            - historical_context
            - state_of_research
            - critique
            - research_gap
            - comparison
            - equation_source
            - figure_source
            - table_source
            - other
        claim_summary: "text, NOT NULL"
        exact_location: "varchar(255), NULL"
        is_first_mention: "tinyint(1), default 0"
        citation_checked: "tinyint(1), default 0"
        notes: "text, NULL"
        created_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        source_id:
          references: "sources.source_id"
          on_delete: CASCADE
          on_update: CASCADE
        section_id:
          references: "dissertation_sections.section_id"
          on_delete: CASCADE
          on_update: CASCADE
        created_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL
          on_update: CASCADE
      forbidden_usage_types:
        - synthesis
        - citation
        - axiom_source

    definitions:
      primary_key: definition_id
      unique_keys:
        - definition_number
      columns:
        definition_id: "bigint unsigned, AUTO_INCREMENT"
        definition_number: "varchar(50), NOT NULL, global eindeutig"
        section_id: "bigint unsigned, NOT NULL"
        title: "varchar(500), NOT NULL"
        definition_text: "longtext, NOT NULL"
        formal_latex: "longtext, NULL"
        word_latex: "longtext, NULL"
        provenance:
          type: enum
          allowed:
            - original
            - adapted
            - literature
        source_id: "bigint unsigned, NULL"
        assumptions: "text, NULL"
        notes: "text, NULL"
        validation_status:
          type: enum
          allowed:
            - draft
            - checked
            - verified
        created_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        section_id:
          references: "dissertation_sections.section_id"
        source_id:
          references: "sources.source_id"
          on_delete: SET_NULL
        created_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL
      forbidden_provenance:
        - author_synthesis
        - frzk
        - own

    equations:
      primary_key: equation_id
      unique_keys:
        - equation_number
      columns:
        equation_id: "bigint unsigned, AUTO_INCREMENT"
        equation_number: "varchar(50), NOT NULL, global eindeutig"
        section_id: "bigint unsigned, NOT NULL"
        title: "varchar(500), NULL"
        equation_latex: "text, NOT NULL"
        word_latex: "text, NOT NULL"
        plain_description: "text, NOT NULL"
        equation_type:
          type: enum
          allowed:
            - definition
            - axiom
            - theorem
            - lemma
            - derived
            - schema
            - model
            - metric
            - other
        provenance:
          type: enum
          allowed:
            - original
            - adapted
            - literature
        source_id: "bigint unsigned, NULL"
        derivation: "text, NULL"
        assumptions: "text, NULL"
        validation_status:
          type: enum
          allowed:
            - draft
            - checked
            - verified
        created_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        section_id:
          references: "dissertation_sections.section_id"
          on_update: CASCADE
        source_id:
          references: "sources.source_id"
          on_delete: SET_NULL
          on_update: CASCADE
        created_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL
          on_update: CASCADE
      critical_rules:
        - "Nächste Gleichung in Kapitel 3.4: 3.340."
        - "word_latex darf niemals leer sein."
        - "Vor Einfügen global nach equation_number prüfen."
        - "Bei Wiederholung equation_id mit LAST_INSERT_ID(equation_id) sichern."

    equation_symbols:
      primary_key: equation_symbol_id
      unique_keys:
        - "equation_id + symbol_latex"
      columns:
        equation_symbol_id: "bigint unsigned, AUTO_INCREMENT"
        equation_id: "bigint unsigned, NOT NULL"
        symbol_latex: "varchar(255), NOT NULL"
        symbol_name: "varchar(255), NOT NULL"
        definition_text: "text, NOT NULL"
        unit_text: "varchar(255), NULL"
        domain_text: "varchar(500), NULL"
        symbol_order: "smallint unsigned, default 1"
      foreign_keys:
        equation_id:
          references: "equations.equation_id"
          on_delete: CASCADE
          on_update: CASCADE
      mandatory_upsert: |
        ON DUPLICATE KEY UPDATE
          symbol_name = VALUES(symbol_name),
          definition_text = VALUES(definition_text),
          unit_text = VALUES(unit_text),
          domain_text = VALUES(domain_text),
          symbol_order = VALUES(symbol_order)

    symbols:
      primary_key: symbol_id
      unique_keys:
        - "symbol_latex + scope_type + first_section_id"
      columns:
        symbol_id: "bigint unsigned, AUTO_INCREMENT"
        symbol_latex: "varchar(255), NOT NULL"
        symbol_word_latex: "varchar(255), NOT NULL"
        symbol_name: "varchar(255), NOT NULL"
        definition_text: "longtext, NOT NULL"
        scope_type:
          type: enum
          allowed:
            - global
            - chapter
            - section
            - equation
        first_section_id: "bigint unsigned, NULL"
        first_equation_id: "bigint unsigned, NULL"
        unit_text: "varchar(255), NULL"
        domain_text: "varchar(1000), NULL"
        codomain_text: "varchar(1000), NULL"
        is_vector: "tinyint(1), default 0"
        is_matrix: "tinyint(1), default 0"
        is_operator: "tinyint(1), default 0"
        notes: "text, NULL"
        validation_status:
          type: enum
          allowed:
            - draft
            - checked
            - verified
        created_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        first_section_id:
          references: "dissertation_sections.section_id"
          on_delete: SET_NULL
          on_update: CASCADE
        first_equation_id:
          references: "equations.equation_id"
          on_delete: SET_NULL
          on_update: CASCADE
        created_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL
          on_update: CASCADE

    figures:
      primary_key: figure_id
      unique_keys:
        - figure_number
      columns:
        figure_id: "bigint unsigned, AUTO_INCREMENT"
        figure_number: "varchar(50), NOT NULL"
        section_id: "bigint unsigned, NOT NULL"
        title: "varchar(500), NOT NULL"
        caption: "longtext, NOT NULL"
        file_name: "varchar(500), NULL"
        file_path: "varchar(1500), NULL"
        alt_text: "longtext, NULL"
        figure_type:
          type: enum
          allowed:
            - diagram
            - plot
            - photograph
            - schema
            - flowchart
            - network
            - other
        provenance:
          type: enum
          allowed:
            - original
            - adapted
            - literature
        source_id: "bigint unsigned, NULL"
        generation_method: "text, NULL"
        data_reference: "text, NULL"
        validation_status:
          type: enum
          allowed:
            - draft
            - checked
            - verified
        created_revision_id: "bigint unsigned, NULL"
      foreign_keys:
        section_id:
          references: "dissertation_sections.section_id"
        source_id:
          references: "sources.source_id"
          on_delete: SET_NULL
        created_revision_id:
          references: "repository_revisions.revision_id"
          on_delete: SET_NULL

    dissertation_tables:
      note: "Die tatsächliche Tabelle heißt dissertation_tables, nicht tables."
      primary_key: table_id
      unique_keys:
        - table_number
      required_foreign_keys:
        section_id: "dissertation_sections.section_id"
        source_id: "sources.source_id, ON DELETE SET NULL"
        created_revision_id: "repository_revisions.revision_id, ON DELETE SET NULL"
      critical_rule: "In Skripten nie INSERT INTO tables verwenden."

    repository_counters:
      primary_key: counter_key
      columns:
        counter_key: "varchar(100), NOT NULL"
        counter_value: "varchar(100), NOT NULL"
        updated_at: "timestamp, auto update"
      chapter_3_2_final_values:
        next_citation_number: "82"
        next_equation_number: "3.275"
        last_edited_section: "3.2.12"
        last_repository_revision: "RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5"
      required_after_each_section:
        - next_citation_number
        - next_equation_number
        - last_edited_section
        - last_repository_revision
```

# ==================================================================================================
# MINIMALER SQL-ABSCHNITTSSTANDARD FÜR KAPITEL 3.3
# ==================================================================================================

```sql
USE `frzk_rkb`;
SET NAMES utf8mb4;
START TRANSACTION;

SET @parent_revision_id := (
    SELECT `revision_id`
    FROM `repository_revisions`
    WHERE `revision_code` = '<REVISION_DES_VORHERIGEN_ABSCHNITTS>'
    LIMIT 1
);

INSERT INTO `repository_revisions`
(
    `revision_code`,
    `revision_date`,
    `scope_type`,
    `scope_reference`,
    `version_label`,
    `summary`,
    `created_by`,
    `parent_revision_id`
)
VALUES
(
    '<NEUER_REVISION_CODE>',
    NOW(),
    'section',
    '<ABSCHNITTSNUMMER>',
    '<VERSION>',
    '<ZUSAMMENFASSUNG>',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
)
ON DUPLICATE KEY UPDATE
    `revision_id` = LAST_INSERT_ID(`revision_id`),
    `revision_date` = VALUES(`revision_date`),
    `summary` = VALUES(`summary`),
    `parent_revision_id` = VALUES(`parent_revision_id`);

SET @revision_id := LAST_INSERT_ID();

SET @section_id := (
    SELECT `section_id`
    FROM `dissertation_sections`
    WHERE `section_code` = '<ABSCHNITTSNUMMER>'
    LIMIT 1
);

/* Abschnitt aktualisieren, Altartefakte kontrolliert bereinigen,
   Quellen/Autoren/Annotationen/source_usage/Definitionen/Gleichungen/
   equation_symbols/symbols/Änderungsprotokoll vollständig anlegen. */

INSERT INTO `repository_counters`
(`counter_key`,`counter_value`)
VALUES
('next_citation_number','<NÄCHSTE_QUELLE>'),
('next_equation_number','<NÄCHSTE_GLEICHUNG>'),
('last_edited_section','<ABSCHNITTSNUMMER>'),
('last_repository_revision','<NEUER_REVISION_CODE>')
ON DUPLICATE KEY UPDATE
    `counter_value` = VALUES(`counter_value`);

COMMIT;

/* Abschnittsaudit:
   Revision, Abschnitt, Quellen, source_usage, Definitionen, Gleichungen,
   Word-LaTeX, equation_symbols, Symbole, Dubletten und Counter prüfen. */
```

# ==================================================================================================
# ENDE DES MASCHINENLESBAREN FORTSETZUNGSBLOCKS
# ==================================================================================================


# HINWEIS
Dieses Dokument basiert auf dem Abschlussstand von Kapitel 3.3 (FINAL-V1). Kapitel 3.4 beginnt mit Literaturquelle [96] und Gleichung (3.340). Die in 3.3 eingeführten Konzepte 'latente funktionale Orientierung', 'funktionale Persistenz' und 'funktionales Gedächtnis' sind verbindliche Grundlage der mathematischen Rekonstruktion.
