# ==================================================================================================
# FRZK – VOLLSTÄNDIGES ÜBERGABEDOKUMENT KAPITEL 3.3 → KAPITEL 3.4
# Mathematische Rekonstruktion des Funktionalen Raum-Zeit-Kohärenzsystems
# ==================================================================================================

```yaml
handoff:
  format_name: frzk_chapter_continuation
  format_version: "6.0"
  generated_on: "2026-08-11"
  language: de
  status: verbindliche_arbeitsgrundlage
  supersedes:
    - "MD_Fortsetzung_naechstes_Kapitel_3_4_mit_Schema_V5.md"
    - "alle historischen 3.4-Zähler- und Axiomstände vor dem Abschluss von 3.3.75"
  binding_predecessor:
    chapter: "3.3"
    section: "3.3.75"
    revision: "RKB-NEU-K3.3.75-FINAL"
    repair_level: "REPAIR V2"
    sql_file: "FRZK_INSERT_3.3.75_FINAL_0-31_CHAPTER_3.3_CLOSURE_SCHEMA_LOCKED_REPAIR_V2.sql"
    sha256: "e20139a2e0412ddd16216660a1240189fdbfd0f7cab0484553f0b74cf5b94ec4"

project:
  type: dissertation
  short_name: FRZK
  title: "Funktionales Raum-Zeit-Kohärenzsystem"
  author: "Olaf Thiele"
  repository_database: "frzk_rkb"
  chapter_language: "Deutsch"

current_state:
  completed_chapter: "3.3"
  completed_chapter_status: "final"
  last_completed_section: "3.3.75"
  last_completed_section_status: "final"
  last_repository_revision: "RKB-NEU-K3.3.75-FINAL"
  parent_revision_for_first_3_4_script: "RKB-NEU-K3.3.75-FINAL"

  final_primary_axiom_core:
    cardinality: 4
    axioms:
      - code: "A_I"
        meaning: "funktionale Bestimmbarkeit / nichtleerer elementarer funktionaler Zustandsbereich"
        canonical_latex: "\\mathcal S_{\\mathrm{el}}\\neq\\emptyset"
      - code: "A_II"
        meaning: "funktionale Relationierbarkeit / Existenz mindestens eines funktionalen Relationsobjekts"
        canonical_latex: "\\mathfrak R_{\\mathrm f}\\neq\\emptyset"
      - code: "A_III"
        meaning: "funktionale Transformierbarkeit / Existenz mindestens einer funktionalen Transformation"
        canonical_latex: "\\mathfrak T_{\\mathrm f}\\neq\\emptyset"
      - code: "A_C"
        meaning: "funktionale Kohärenz"
        canonical_latex: "\\exists z\\in\\Omega_F\\;\\exists\\mathcal S_C\\subseteq\\mathcal S_F:R_F(\\mathcal S_C)=1\\land C_F(\\mathcal S_C;z)>0"

  axiom_audit:
    relative_consistency: passed
    joint_independence: passed
    minimality: passed
    nonredundancy: passed
    circularity_freedom: passed
    no_hidden_space_time_assumptions: passed
    relative_conservativity: passed
    audit_certificate: "(1,1,1,1,1,1,1)"
    open_primary_axiom_candidates: 0
    new_primary_axioms_in_3_3_75: 0

  last_numbering:
    equation: "3.19230"
    definition: "3.3.1235"
    theorem: "3.3.774"
    corollary: "3.3.502"
    expected_last_citation: 152

  next_numbering:
    text_start: "3.4.0"
    equation: "3.19231"
    definition: "3.4.1"
    theorem: "3.4.1"
    corollary: "3.4.1"
    expected_next_citation: 153
    citation_counter_must_be_revalidated: true

chapter_transition:
  from: >
    Vollständig abgeschlossene und auditierte Axiomatik des FRZK.
    Kapitel 3.3 fixiert vier Primäraxiome und trennt diese dauerhaft
    von Definitionen, Ableitungen, Modellannahmen, Operationalisierungen
    und optionalen Erweiterungsstrukturen.

  to: >
    Mathematische Rekonstruktion und Realisierung der durch die vier
    Primäraxiome eröffneten Strukturmöglichkeiten mit den in Kapitel 3.2
    bereitgestellten mathematischen Werkzeugen. Kapitel 3.4 darf den
    Primäraxiomkern nicht stillschweigend erweitern.

chapter_3_4:
  working_title: "Mathematische Rekonstruktion funktionaler Organisation"
  start_section: "3.4.0"
  character:
    - mathematische Eigenentwicklung
    - konservative Realisierung der Axiomatik
    - explizite Rückführbarkeit jeder neuen Konstruktion
    - keine neue Primäraxiomensuche
    - Raum und Zeit bleiben Rekonstruktionsgegenstände
  mandatory_axiom_to_construction_mapping:
    A_I: "StateConstruction"
    A_II: "RelationConstruction"
    A_III: "TransformationConstruction"
    A_C: "CoherenceConstruction"

writing_style:
  perspective: "Ich-Form"
  rules:
    - "Dissertationstext vollständig im Chat ausgeben."
    - "Fließende wissenschaftliche Sprache."
    - "Keine Lehrbuchsprache als dominanter Stil."
    - "Keine Ein-Satz-Absätze als Regelform."
    - "Mathematische Präzision vor sprachlicher Vereinfachung."
    - "Eigenleistung klar von etablierter Mathematik und Literatur trennen."
    - "Keine Bezüge auf einen alten oder ursprünglichen Text."
    - "Keine Formulierungen wie 'im Original', 'ursprünglich' oder 'frühere Fassung' im Dissertationstext."
    - "Jede nummerierte Gleichung erhält unmittelbar danach ihre Word-LaTeX-Zeile."
    - "Jeder vollständige Abschnitt endet mit ausführlichen Methodologischen Betrachtungen und Didaktischen Betrachtungen."

workflow:
  section_cycle:
    - "aktuellen Repository- und Manuskriptstand prüfen"
    - "Abschnitt vollständig im Chat entwickeln"
    - "mathematische und axiomatische Rückführbarkeit prüfen"
    - "Literatur und Fundstellen verifizieren"
    - "auf Nutzerbefehl 'skript' Repository-SQL erzeugen"
    - "SQL vollständig im Chat ausgeben"
    - "SQL zusätzlich als Datei und SHA-256 bereitstellen"
    - "Repository-Audit durchführen"
    - "erst danach mit 'weiter' zum nächsten Abschnitt"
  user_commands:
    weiter: "nächsten Dissertationsteil vollständig entwickeln"
    skript: "Repository-SQL für den unmittelbar zuvor abgeschlossenen Abschnitt erzeugen"

repository:
  schema_reference: "frzk_rkb_stand_ende_3.3.48.sql"
  immediate_predecessor: "FRZK_INSERT_3.3.75_FINAL_0-31_CHAPTER_3.3_CLOSURE_SCHEMA_LOCKED_REPAIR_V2.sql"
  database: "frzk_rkb"
  charset: "utf8mb4"
  collation: "utf8mb4_unicode_ci"
  equation_type_default: "other"
  sql_mode: "NO_AUTO_VALUE_ON_ZERO,NO_BACKSLASH_ESCAPES"
  stored_procedure_ddl_inside_transaction: "forbidden"
  validation_guard: "TEMPORARY TABLE NOT NULL guard"
  latex_normalization_for_exact_checks: "REPLACE(field,CHAR(92,92),CHAR(92))"

start_instruction: |
  Lies dieses Übergabedokument vollständig.
  Prüfe anschließend den realen Repository-Stand gegen das
  3.3.75-REPAIR-V2-Skript und gegen das tatsächliche Schema.
  Bestätige vor dem Schreiben:
    - Kapitel 3.3 = final
    - Abschnitt 3.3.75 = final
    - letzte Revision = RKB-NEU-K3.3.75-FINAL
    - Primäraxiomkern = {A_I, A_II, A_III, A_C}
    - nächste Gleichung = (3.19231)
    - erste Definition in 3.4 = 3.4.1
    - erster Satz in 3.4 = 3.4.1
    - erstes Korollar in 3.4 = 3.4.1
    - Literaturzähler durch reale DB-Abfrage verifiziert
  Entwickle danach Abschnitt 3.4.0 vollständig im verbindlichen
  FRZK-Schreibstil. Führe kein neues Primäraxiom ein.
```

---

# 1. Zweck und Verbindlichkeit dieses Übergabedokuments

Dieses Dokument ist die verbindliche Arbeitsgrundlage für den Übergang von Kapitel 3.3 „Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems“ zu Kapitel 3.4 „Mathematische Rekonstruktion funktionaler Organisation“.

Es soll in einem neuen Arbeitschat zusammen mit dem letzten gültigen Repository-Skript von Kapitel 3.3 verwendet werden. Es bündelt den Stand, der für eine korrekte Fortsetzung benötigt wird, insbesondere:

- den endgültigen Primäraxiomkern,
- den Abschlussaudit der Axiomatik,
- die letzten und nächsten Nummern,
- die Kapitelwechselregeln,
- die Schreibstilregeln,
- die Literaturregeln,
- die Repository- und SQL-Regeln,
- die aus dem 3.3.74-Fehler abgeleiteten Transaktionsregeln,
- die methodische Funktion von Kapitel 3.4,
- die erlaubten und verbotenen theoretischen Schritte,
- die Rückführungsanforderungen jeder neuen mathematischen Konstruktion,
- eine Arbeitsarchitektur für Kapitel 3.4,
- sowie die Startanweisung für den nächsten Chat.

Das Dokument ersetzt weder das Manuskript von Kapitel 3.3 noch das Repository-SQL. Bei einem Widerspruch gilt folgende Priorität:

1. reales aktuelles Datenbankschema,
2. erfolgreich ausgeführter, validierter Repository-Endstand,
3. endgültiger Manuskriptstand von Kapitel 3.3,
4. dieses Übergabedokument,
5. ältere historische 3.4-Entwürfe oder Sicherungen.

Ältere 3.4-Dateien dürfen daher als Ideen- oder Strukturquelle gelesen werden, aber nicht als aktuelle Zähler-, Axiom- oder Repository-Referenz.

---

# 2. Verbindlicher Ausgangsstand von Kapitel 3.3

## 2.1 Kapitelstatus

Kapitel 3.3 ist inhaltlich und axiomatisch abgeschlossen.

Verbindlicher Status:

```text
Kapitel: 3.3
Status: final
Letzter Abschnitt: 3.3.75
Status letzter Abschnitt: final
Letzte Repository-Revision: RKB-NEU-K3.3.75-FINAL
```

Der Abschluss erfolgt durch das reparierte und transaktionssichere Skript:

```text
FRZK_INSERT_3.3.75_FINAL_0-31_CHAPTER_3.3_CLOSURE_SCHEMA_LOCKED_REPAIR_V2.sql
```

SHA-256:

```text
e20139a2e0412ddd16216660a1240189fdbfd0f7cab0484553f0b74cf5b94ec4
```

Dieses Skript ist der unmittelbare Parent für den ersten Repository-Stand von Kapitel 3.4.

## 2.2 Umfang des letzten Abschnitts

Abschnitt 3.3.75 umfasst:

```text
Text:          3.3.75.0–3.3.75.31
Gleichungen:   (3.19101)–(3.19230) = 130
Definitionen:  3.3.1222–3.3.1235   = 14
Sätze:         3.3.761–3.3.774      = 14
Korollare:     3.3.489–3.3.502      = 14
neue Axiome:   0
```

Der Abschnitt fixiert den Primäraxiomkern, erklärt Kapitel 3.3 für abgeschlossen und übergibt die Theorie an die mathematische Rekonstruktion.

---

# 3. Endgültiger Primäraxiomkern

Kapitel 3.4 darf ausschließlich mit dem in Kapitel 3.3 fixierten Vierer-Kern beginnen.

## 3.1 Primäraxiom I

Kanonische Minimalform:

```latex
A_{\mathrm I}:\mathcal S_{\mathrm{el}}\neq\emptyset
```

Bedeutung:

Es existiert ein nichtleerer elementarer funktionaler Zustandsbereich. Das Axiom fordert keine konkrete Algebra, Topologie, Metrik, Dimension oder physikalische Interpretation dieses Bereiches.

## 3.2 Primäraxiom II

Kanonische Minimalform:

```latex
A_{\mathrm{II}}:\mathfrak R_{\mathrm f}\neq\emptyset
```

Bedeutung:

Es existiert mindestens ein funktionales Relationsobjekt. Eigenschaften wie Reflexivität, Symmetrie, Antisymmetrie, Transitivität, Totalität, Gewichtung oder Metrizität folgen daraus nicht automatisch.

## 3.3 Primäraxiom III

Kanonische Minimalform:

```latex
A_{\mathrm{III}}:\mathfrak T_{\mathrm f}\neq\emptyset
```

Bedeutung:

Es existiert mindestens eine funktionale Transformation. Eine konkrete Operatoralgebra, Linearität, Stetigkeit, Invertierbarkeit, Differenzierbarkeit oder Zeitparametrisierung ist nicht Bestandteil des Primäraxioms.

## 3.4 Kohärenzprimäraxiom

Kanonische Endform:

```latex
A_C:\exists z\in\Omega_F\;\exists\mathcal S_C\subseteq\mathcal S_F:
R_F(\mathcal S_C)=1\land C_F(\mathcal S_C;z)>0
```

Bedeutung:

Mindestens eine funktional relevante Teilstruktur besitzt in mindestens einem zulässigen Zustand positive funktionale Kohärenz.

Auch dieses Axiom legt kein konkretes Kohärenzmaß, keinen konkreten Wertebereich, keine bestimmte Dynamik und keine Raum- oder Zeitstruktur fest.

## 3.5 Unveränderlichkeit innerhalb des normalen 3.4-Arbeitsgangs

Für Kapitel 3.4 gilt als Arbeitsbedingung:

```latex
\mathcal A_{\mathrm{FRZK}}^{3.4}=\mathcal A_{\mathrm{FRZK}}^\ast
```

und

```latex
\mathcal A_{3.4}^{\mathrm{new}}=\varnothing.
```

Eine neue mathematische Definition in 3.4 ist daher zunächst eine mathematische Realisierung, Definition, Ableitung oder Modellstruktur und kein neues Primäraxiom.

---

# 4. Abschlussaudit des Primäraxiomkerns

Abschnitt 3.3.74 hat den Vierer-Kern gemeinsam geprüft.

Verbindlicher Auditstatus:

```text
relative Konsistenz:                      bestanden
gemeinsame Unabhängigkeit:                bestanden
Minimalität:                              bestanden
Nichtredundanz:                           bestanden
Zirkularitätsfreiheit:                    bestanden
Freiheit verdeckter Raum-/Zeitannahmen:   bestanden
relative Konservativität:                 bestanden
```

Audit-Zertifikat:

```latex
\mathfrak Z_{\mathrm{ax}}=(1,1,1,1,1,1,1)
```

Wissenschaftlich ist dieses Ergebnis relativ zum in Kapitel 3.3 explizierten Sprach-, Definitions- und Brückenrahmen zu verstehen. Es ist kein absoluter metamathematischer Konsistenzbeweis für jede denkbare spätere Formalisierung.

Wenn Kapitel 3.4 eine zusätzliche Brückenannahme einführen würde, durch die ein bisher unabhängiges Primäraxiom aus anderen Aussagen ableitbar würde, wäre ein Re-Audit erforderlich.

---

# 5. Wissenschaftliche Statusklassen

Kapitel 3.3 hat Primäraxiome von anderen Aussagearten getrennt.

Für Kapitel 3.4 ist mindestens zwischen folgenden Statusklassen zu unterscheiden:

```text
PA   Primäraxiom
Def  Definition
Der  abgeleitete Aussage / mathematische Folgerung
Mod  Modellannahme
Op   Operationalisierung
Ext  optionale Erweiterungsstruktur
```

Eine häufig verwendete Struktur wird dadurch nicht zum Primäraxiom.

Eine mathematisch notwendige Hilfsstruktur für ein bestimmtes Modell wird dadurch ebenfalls nicht automatisch zum Primäraxiom.

Eine konkrete Metrik, Norm, Topologie, Operatoralgebra, Graphstruktur, Wahrscheinlichkeitsstruktur oder Mannigfaltigkeit ist nur dann Bestandteil einer konkreten Realisierung, wenn ihre Einführung begründet wird. Ihr mathematischer Nutzen allein verändert den axiomatischen Status nicht.

---

# 6. Wissenschaftliche Funktion von Kapitel 3.4

Kapitel 3.4 ist keine zweite Axiomatik.

Seine Aufgabe besteht darin, die von Kapitel 3.3 geöffneten funktionalen Mindestbedingungen mathematisch zu realisieren.

Die Grundrichtung lautet:

```text
Axiomatische Mindestbedingung
        ↓
mathematische Trägerstruktur
        ↓
Definition
        ↓
Eigenschaften
        ↓
Lemma / Satz / Korollar
        ↓
Beweis
        ↓
FRZK-spezifische Einordnung
        ↓
nächste notwendige Rekonstruktionsstufe
```

Der entscheidende Unterschied zwischen Kapitel 3.3 und 3.4 lautet:

```text
3.3: Was muss als funktionale Mindestvoraussetzung gesetzt werden?
3.4: Wie kann diese Mindestvoraussetzung mathematisch realisiert werden?
```

---

# 7. Verbindliche Axiom-zu-Konstruktions-Zuordnung

Kapitel 3.3 hat die erste Übergabematrix bereits festgelegt.

## 7.1 Axiom I

```text
A_I → StateConstruction
```

Ziel:

- nichtleeren funktionalen Trägerbereich mathematisch realisieren,
- zulässige Zustandsobjekte definieren,
- keine unnötigen Zusatzstrukturen voraussetzen.

## 7.2 Axiom II

```text
A_II → RelationConstruction
```

Ziel:

- funktionale Relationsobjekte mathematisch realisieren,
- Relationstypen und Relationseigenschaften nur soweit nötig einführen,
- keine metrischen, kausalen oder geometrischen Eigenschaften stillschweigend voraussetzen.

## 7.3 Axiom III

```text
A_III → TransformationConstruction
```

Ziel:

- funktionale Transformationen mathematisch realisieren,
- Definitions- und Wertebereiche festlegen,
- Komposition, Identität, Invertierbarkeit, Linearität oder Stetigkeit nur nach Begründung einführen.

## 7.4 Axiom C

```text
A_C → CoherenceConstruction
```

Ziel:

- Relevanzdomäne,
- Kohärenzdomäne,
- Kohärenzwert beziehungsweise Kohärenzrelation,
- Positivitätsbedingung

mathematisch realisieren, ohne ein bestimmtes Kohärenzmaß als einzig mögliche Realisierung auszugeben.

---

# 8. Kanonische Ableitungs- und Eingangsbasis

Die Eingangsbasis von Kapitel 3.4 besteht aus drei Bereichen.

## 8.1 Axiomatische Basis aus Kapitel 3.3

```text
A_I
A_II
A_III
A_C
```

## 8.2 Definitorische und abgeleitete Basis aus Kapitel 3.3

Kapitel 3.4 darf auf die in 3.3 definierten funktionalen Begriffe, Statusentscheidungen, Sätze und Korollare zurückgreifen.

Dabei ist stets zu unterscheiden:

- Was ist Primäraxiom?
- Was ist Definition?
- Was wurde bewiesen?
- Was ist optionale Erweiterung?
- Was ist lediglich Modellannahme oder Operationalisierung?

## 8.3 Mathematischer Werkzeugraum aus Kapitel 3.2

Kapitel 3.2 stellt etablierte mathematische Werkzeuge bereit, unter anderem:

- Mengen und Mengenoperationen,
- Relationen,
- Abbildungen und Funktionen,
- algebraische Strukturen,
- Vektoren und Vektorräume,
- Matrizen und lineare Abbildungen,
- Determinanten, Rang und Invertierbarkeit,
- Eigenwerte und Eigenvektoren,
- Operatoren,
- Normen und Metriken,
- topologische Begriffe,
- Graphen und Netzwerke,
- dynamische Systeme,
- Differential- und Integralstrukturen,
- Wahrscheinlichkeits- und Informationsstrukturen,
- Spektralmethoden,
- geometrische und raumzeitliche Werkzeuge.

Diese Werkzeuge sind ein mathematischer Sprachraum. Sie sind keine automatisch gültigen Eigenschaften des FRZK.

---

# 9. Rückführungsprinzip für jede neue Konstruktion

Jede wesentliche mathematische Konstruktion `X` in Kapitel 3.4 muss eine explizite Rückführung besitzen.

Mindestens zu dokumentieren sind:

```text
1. Ausgangsaxiom oder Ausgangsdefinition
2. mathematisches Werkzeug aus Kapitel 3.2
3. zusätzliche Definitionen
4. zusätzliche Modellannahmen, falls vorhanden
5. hergeleitete Eigenschaften
6. Status der Konstruktion
7. Geltungsbereich
8. nicht behauptete Eigenschaften
```

Das Ziel ist eine nachvollziehbare Kette:

```text
Axiom / Definition aus 3.3
        +
mathematisches Werkzeug aus 3.2
        ↓
Konstruktion in 3.4
        ↓
Beweis / Ableitung
```

Eine bloße Plausibilität oder Nützlichkeit genügt nicht als Ableitung.

---

# 10. Unterscheidung zwischen direkter Ableitung und zulässiger Realisierung

Für Kapitel 3.4 ist eine besonders wichtige sprachliche Trennung verbindlich.

## 10.1 Direkte Ableitung

Die Formulierung

> „Aus A folgt X.“

darf nur verwendet werden, wenn X tatsächlich logisch beziehungsweise mathematisch aus den angegebenen Voraussetzungen folgt.

## 10.2 Zulässige Realisierung

Wenn mehrere mathematische Strukturen ein Axiom erfüllen können, ist zu formulieren:

> „Eine zulässige mathematische Realisierung von A ist …“

oder:

> „Ich wähle für die weitere Konstruktion folgende Realisierung …“

Dann ist X nicht als einzig mögliche Konsequenz auszugeben.

## 10.3 Modellwahl

Wenn eine zusätzliche Eigenschaft nur für eine bestimmte Modellklasse benötigt wird, ist sie ausdrücklich als Modellannahme zu kennzeichnen.

Beispiel:

```text
A_II fordert die Existenz funktionaler Relationen.
A_II fordert nicht automatisch eine symmetrische Relation.
Symmetrie darf daher nur als abgeleitete Eigenschaft oder als explizite Modellannahme auftreten.
```

---

# 11. Verbindlicher Nummerierungsstand am Kapitelwechsel

## 11.1 Gleichungen

Die Gleichungsnummerierung läuft innerhalb des gesamten Kapitels 3 fort.

Letzte Gleichung aus Kapitel 3.3:

```text
(3.19230)
```

Nächste Gleichung:

```text
(3.19231)
```

Diese Nummer darf nicht auf `(3.1)`, `(3.4.1)` oder eine historische 3.4-Gleichungsnummer zurückgesetzt werden.

## 11.2 Definitionen

Kapitel 3.3 endet bei:

```text
Definition 3.3.1235
```

Kapitel 3.4 beginnt neu mit:

```text
Definition 3.4.1
```

## 11.3 Sätze

Kapitel 3.3 endet bei:

```text
Satz 3.3.774
```

Kapitel 3.4 beginnt mit:

```text
Satz 3.4.1
```

## 11.4 Korollare

Kapitel 3.3 endet bei:

```text
Korollar 3.3.502
```

Kapitel 3.4 beginnt mit:

```text
Korollar 3.4.1
```

## 11.5 Lemmata, Propositionen, Beweise, Abbildungen und Tabellen

Für alle zusätzlich verwendeten Objektarten ist vor der ersten Neuanlage in 3.4 der reale Repository-Stand zu prüfen.

Falls die Nummerierung kapitelbezogen geführt wird, beginnt sie mit dem Präfix `3.4`.

Es ist verboten, aus historischen 3.4-Sicherungen alte Nummern ungeprüft wiederzuverwenden.

---

# 12. Literaturstand und Literaturregeln

## 12.1 Erwarteter Übergabezähler

Der konsolidierte Endstand von Kapitel 3.2 endet bei:

```text
letzte Literaturstelle: [152]
nächste Literaturstelle: [153]
```

Die geprüften Startskripte von Kapitel 3.3 verwenden vorhandene Quellen und verändern diesen Zähler nicht.

Da der letzte 3.3.75-Finalizer selbst keinen Literaturzähler aktualisiert, gilt für Kapitel 3.4:

```text
erwarteter letzter Zähler: 152
erwartete nächste Nummer: 153
```

aber vor der ersten Neuanlage einer Quelle zwingend:

```sql
SELECT MAX(citation_number) FROM sources;

SELECT counter_key,counter_value
FROM repository_counters
WHERE counter_key IN ('last_citation_number','next_citation_number');
```

Erst wenn beide Ebenen konsistent sind, darf eine neue Nummer vergeben werden.

## 12.2 Erstnennung

Bei der ersten tatsächlichen Verwendung einer neuen Quelle im Dissertationstext muss die Quelle vollständig genannt werden.

Erst danach darf im Text mit der festen Zitationsnummer gearbeitet werden.

## 12.3 Wiederverwendung

Bereits vorhandene Quellen erhalten keine neue Nummer.

Stattdessen:

- vorhandene `source_id` ermitteln,
- `source_usage` für den neuen Abschnitt anlegen,
- `is_first_mention = 0`,
- Nutzungszweck konkret formulieren.

## 12.4 Fundstellen

Fundstellen und Belegstellen dürfen niemals aus dem Dissertationstext geraten werden.

Sie müssen aus der tatsächlichen Literaturquelle verifiziert werden.

Wenn keine belastbare Fundstelle ermittelt werden kann:

```text
exact_location / Belegfeld leer lassen
```

und nicht mit einer erfundenen Seitenzahl füllen.

## 12.5 Deduplizierung

Vor jeder Neuanlage prüfen:

- `citation_number`,
- `source_key`,
- Autor,
- Titel,
- DOI,
- ISBN,
- Edition.

---

# 13. Schreibstil für Kapitel 3.4

## 13.1 Ich-Form

Die Ich-Form ist verbindlich, wenn ich:

- eine mathematische Realisierung auswähle,
- eine Definition für das FRZK setze,
- eine zusätzliche Modellklasse eingrenze,
- eine methodische Entscheidung begründe,
- eine Ableitungsroute auswähle,
- eine Geltungsgrenze festlege.

Beispiele:

> Ich wähle zunächst die schwächste mathematische Struktur, welche die durch Primäraxiom II verlangte Relationierbarkeit realisiert.

> Ich fordere an dieser Stelle ausdrücklich noch keine Metrik.

> Für die folgende Ableitung beschränke ich mich auf …

## 13.2 Etablierte Mathematik

Etablierte mathematische Aussagen werden neutral beschrieben und mit Literatur belegt, wenn ein Beleg notwendig ist.

Die Mathematik selbst wird nicht als FRZK-Eigenleistung ausgegeben.

## 13.3 Eigenleistung

Die Eigenleistung liegt insbesondere in:

- der Auswahl der minimalen Realisierungsstruktur,
- der Begründung ihrer Notwendigkeit,
- der Rückführung auf die Axiomatik,
- der systematischen Kombination etablierter mathematischer Werkzeuge,
- den neu abgeleiteten FRZK-Sätzen,
- der Rekonstruktionskette bis zu raum- und zeitähnlichen Strukturen.

---

# 14. Verbotene redaktionelle Rückbezüge

Ab dem neuen Kapitel 3.4 dürfen keine Formulierungen verwendet werden, die auf eine ältere Textfassung verweisen.

Verboten sind insbesondere:

```text
im Original
im ursprünglichen Abschnitt
in der alten Fassung
früher war
zuvor war anders nummeriert
im älteren Repository
```

Der neue Text wird so geschrieben, als sei ausschließlich der gegenwärtige wissenschaftliche Stand relevant.

Historische Dateien werden nur intern zur Kontrolle verwendet.

---

# 15. Formeln und Word-LaTeX

Jede nummerierte Gleichung im Dissertationstext erhält unmittelbar danach eine Word-LaTeX-Zeile.

Beispiel:

```latex
T_F:\mathcal S_F\rightarrow\mathcal S_F
```

Word-LaTeX:

```text
T_F:\mathcal S_F\rightarrow\mathcal S_F
```

Zwischen gerenderter Gleichung und Word-LaTeX darf kein erläuternder Absatz stehen.

Das Repository-Feld `word_latex` muss denselben mathematischen Inhalt enthalten.

---

# 16. Welche Ausdrücke eine Gleichungsnummer erhalten

Nicht jedes Symbol und nicht jede Teilgröße erhält eine eigene Gleichungsnummer.

Nummeriert werden insbesondere:

- zentrale Definitionen,
- zentrale Relations- oder Abbildungsgleichungen,
- Satzbehauptungen, wenn sie formal fixiert werden,
- Ableitungen, auf die später verwiesen wird,
- Übergangs- und Invarianzbedingungen,
- Kohärenzbedingungen,
- mathematisch relevante Identitäten.

Nicht separat nummeriert werden sollen bloße Erläuterungsgrößen, die nur Bestandteil einer bereits nummerierten Gleichung sind.

---

# 17. Definition, Lemma, Satz, Korollar und Beweis

## 17.1 Definition

Eine Definition legt einen Begriff fest und ist kein Beweis seiner Existenz.

## 17.2 Lemma

Ein Lemma ist eine Hilfsaussage, die für einen späteren Satz benötigt wird.

## 17.3 Satz

Ein Satz benötigt:

- explizite Voraussetzungen,
- eine klar abgegrenzte Behauptung,
- einen Beweis oder eine eindeutig referenzierte Herleitung.

## 17.4 Korollar

Ein Korollar muss unmittelbar aus einem vorhandenen Satz oder einer klar benannten Kombination von Aussagen folgen.

Im Repository muss `parent_theorem_id` beziehungsweise `parent_lemma_id` korrekt gesetzt werden.

## 17.5 Beweis

Ein Beweis darf keine stillen Voraussetzungen einführen.

Wenn eine zusätzliche Eigenschaft benötigt wird, muss vor ihrer Verwendung geklärt werden, ob sie Definition, bereits bewiesene Aussage, Standardtheorem oder Modellannahme ist.

---

# 18. Methodologische und didaktische Abschlussblöcke

Jeder vollständige Abschnitt von Kapitel 3.4 endet mit:

```text
Methodologische Betrachtungen
Didaktische Betrachtungen
```

Die methodologischen Betrachtungen sollen insbesondere beantworten:

- Welche Struktur wurde tatsächlich hergeleitet?
- Welche mathematischen Werkzeuge wurden verwendet?
- Welche Zusatzannahmen wurden vermieden?
- Welche Aussagen sind nur modellabhängig?
- Welche Eigenschaften folgen ausdrücklich nicht?
- Bleibt der Primäraxiomkern unverändert?

Die didaktischen Betrachtungen sollen insbesondere beantworten:

- Was wurde in diesem Abschnitt neu mathematisch möglich?
- Was darf noch nicht interpretiert werden?
- Wie unterscheidet sich die neue Struktur von ähnlich klingenden etablierten Begriffen?
- Welcher nächste Schritt wird dadurch notwendig?

---

# 19. Raum und Zeit bleiben Rekonstruktionsgegenstände

Kapitel 3.4 darf Raum und Zeit nicht stillschweigend als Ausgangsparameter einführen.

Insbesondere sind ohne vorherige Herleitung nicht automatisch zulässig:

```text
x als räumliche Koordinate
t als physikalische Zeit
g_{\mu\nu} als Raumzeitmetrik
M als Mannigfaltigkeit
kausale Lichtkegel
Lorentz-Signatur
dreidimensionaler physikalischer Raum
kontinuierliche Zeitachse
```

Diese Werkzeuge dürfen später verwendet werden, wenn ihre Einführung aus der Rekonstruktionskette begründet wird oder wenn ausdrücklich eine Vergleichs-/Modellrealisierung untersucht wird.

Kapitel 3.3 hat festgelegt:

```text
Space ∉ Prem(A_core)
Time  ∉ Prem(A_core)
```

Diese methodische Trennung bleibt verbindlich.

---

# 20. Information ist nicht automatisch eine zusätzliche primitive Dimension

Falls in Kapitel 3.4 informationsbezogene Strukturen konstruiert werden, ist zwischen folgenden Ebenen zu unterscheiden:

- Information als mathematische Größe,
- Information als funktionale Zustandsunterscheidung,
- Information als zusätzlicher Modellparameter,
- Information als geometrische oder dimensionale Koordinate.

Aus der bloßen Verwendbarkeit von Information folgt keine primitive „vierte Dimension“.

Eine solche Aussage müsste separat und streng aus der Rekonstruktionsstruktur abgeleitet werden.

---

# 21. Mathematische Minimalität

Kapitel 3.4 soll jeweils die schwächste Struktur einführen, die für den nächsten notwendigen Schritt genügt.

Beispiel:

Wenn Axiom II nur die Existenz einer funktionalen Relation verlangt, darf nicht ohne Begründung sofort angenommen werden, dass die Relation symmetrisch, transitiv, total, metrisch, gewichtet, gerichtet oder kausal ist.

Diese Eigenschaften sind einzeln zu prüfen.

Dasselbe gilt für Transformationen. Linearität, Invertierbarkeit, Stetigkeit, Differenzierbarkeit, Isometrie oder Unitarität dürfen nicht automatisch vorausgesetzt werden.

---

# 22. Modellklasse statt Einzelmodell

Der Vierer-Kern legt nicht notwendig genau eine mathematische Realisierung fest.

Kapitel 3.4 darf daher mehrere Realisierungsfamilien unterscheiden.

Mögliche Struktur:

```text
minimale allgemeine Realisierung
        ↓
zusätzliche Eigenschaft
        ↓
spezialisierte Modellklasse
```

Wenn eine Spezialisierung eingeführt wird, muss deutlich sein, dass sie den allgemeinen FRZK-Kern nicht ersetzt.

---

# 23. Empfohlene Arbeitsarchitektur von Kapitel 3.4

Die folgende Architektur ist eine **Arbeitsarchitektur**, kein bereits fixierter Manuskriptindex. Sie darf nach fachlicher Prüfung erweitert oder feiner untergliedert werden. Sie darf jedoch nicht so verändert werden, dass die axiomatische Rekonstruktionsreihenfolge verloren geht.

## 3.4.0 Einleitung und Rekonstruktionsregeln

Ziele:

- Übergang aus 3.3 präzisieren,
- Vierer-Kern als Eingang festhalten,
- Statusklassen festlegen,
- Rückführungsprinzip definieren,
- keine neue Axiomensuche eröffnen.

## 3.4.1 Mathematische Realisierung des elementaren funktionalen Zustandsbereichs

Ausgang: `A_I`.

Zu klären:

- minimale Trägermenge,
- elementarer funktionaler Zustand,
- Unterscheidbarkeit,
- Identität,
- keine unnötige Metrik oder Geometrie.

## 3.4.2 Funktionale Zustandsklassifikation und Äquivalenzstrukturen

Nur falls für die weitere Theorie notwendig:

- Äquivalenzrelationen,
- Klassen,
- Quotientenstrukturen,
- funktionale Typen.

Nicht voraussetzen, dass jede sinnvolle Klassifikation kanonisch ist.

## 3.4.3 Mathematische Realisierung funktionaler Relationen

Ausgang: `A_II`.

Zu klären:

- Relationsmenge,
- gerichtete und ungerichtete Varianten,
- Relationseigenschaften,
- relationale Nachbarschaft,
- keine automatische Kausalität.

## 3.4.4 Relationale Organisationsstrukturen

Mögliche Werkzeuge:

- Graphen,
- Hypergraphen,
- Kategorien,
- relationale Matrizen.

Nur verwenden, wenn die jeweilige Struktur gegenüber der Minimalrelation begründet wird.

## 3.4.5 Mathematische Realisierung funktionaler Transformationen

Ausgang: `A_III`.

Zu klären:

- Transformationsmenge,
- Definitions- und Wertebereich,
- Komposition,
- Identität,
- Fixpunkte,
- Invertierbarkeit nur als Zusatzfall.

## 3.4.6 Transformationsfamilien und Operatorstrukturen

Mögliche Themen:

- Monoide,
- Halbgruppen,
- Gruppen,
- Operatorfamilien,
- lineare Spezialisierungen,
- Spektralstrukturen.

Keine Operatoralgebra als Primärvoraussetzung.

## 3.4.7 Mathematische Realisierung funktionaler Relevanz

Vor der Quantifizierung von Kohärenz muss präzisiert werden, welche Teilstrukturen als funktional relevant gelten.

Relevanz darf nicht zirkulär allein durch Kohärenz definiert werden.

## 3.4.8 Mathematische Realisierung funktionaler Kohärenz

Ausgang: `A_C`.

Zu klären:

- Domäne,
- Wertebereich,
- Positivitätsbedingung,
- lokale und globale Kohärenz,
- mögliche Maßklassen,
- keine eindeutige Maßfunktion ohne Beweis.

## 3.4.9 Integrierte funktionale Grundstruktur

Zusammenführung:

```text
Zustände + Relationen + Transformationen + Kohärenz
```

Ziel ist eine minimale mathematische Gesamtstruktur des FRZK.

## 3.4.10 Graph- und Netzwerkrealisierungen

Erst nach der integrierten Grundstruktur prüfen:

- Knoten-/Kantenrepräsentationen,
- gewichtete Relationen,
- Pfade,
- Zusammenhang,
- Hubs,
- Zentralität.

Diese Begriffe sind mathematische Realisierungen, keine Primäraxiome.

## 3.4.11 Dynamische Folgen und Trajektorien ohne primitive Zeitannahme

Transformationen können geordnet iteriert werden.

Eine Iterationsindizierung ist zunächst nicht automatisch physikalische Zeit.

Zu unterscheiden:

```text
Iterationsordnung
Sequenzindex
Ereignisordnung
physikalische Zeit
```

## 3.4.12 Stabilität, Fixpunkte und Attraktoren

Nur nach Konstruktion geeigneter Dynamik- und Näherungsbegriffe.

Stabilität erfordert je nach Definition zusätzliche Topologie, Norm oder Metrik; diese Voraussetzungen müssen offen gelegt werden.

## 3.4.13 Metrische und topologische Spezialisierungen

Prüfen:

- unter welchen Zusatzbedingungen eine Metrik sinnvoll ist,
- welche Topologie daraus entsteht,
- welche Aussagen metrikspezifisch sind.

Eine Metrik darf nicht rückwirkend als Bestandteil der vier Primäraxiome interpretiert werden.

## 3.4.14 Funktionale Geometrie und raumähnliche Strukturen

Erst wenn Relation, Transformation, Nähe/Topologie und Kohärenz ausreichend konstruiert sind, kann untersucht werden, ob eine raumähnliche Organisation ableitbar ist.

## 3.4.15 Funktionale Entwicklungsordnung und zeitähnliche Strukturen

Erst wenn gerichtete Veränderung, Komposition und Ordnungsrelationen konstruiert sind, kann eine zeitähnliche Struktur untersucht werden.

## 3.4.16 Informationsbezogene Rekonstruktionen

Optional, sofern aus Zustandsunterscheidung und Relations-/Transformationsstruktur ableitbar.

Keine primitive Informationsdimension voraussetzen.

## 3.4.17 Äquivalenz und Vergleich mathematischer FRZK-Realisierungen

Mögliche Fragen:

- Isomorphie,
- Homomorphie,
- strukturelle Äquivalenz,
- Invarianten,
- Modellklassen.

## 3.4.18 Konsistenz- und Rückführbarkeitsaudit der mathematischen Rekonstruktion

Prüfen:

- jede Konstruktion rückführbar,
- keine versteckten Primäraxiome,
- keine unbemerkte Raum-/Zeitvoraussetzung,
- keine Zirkularität,
- keine Statusverschiebung.

## 3.4.19 Gesamtsynthese und Übergang

Kapitel 3.4 soll am Ende die mathematische Theorieebene bündeln und den nächsten wissenschaftlichen Schritt vorbereiten.

Die tatsächliche Zahl der Unterabschnitte wird erst durch die mathematische Notwendigkeit festgelegt.

---

# 24. Verhältnis zu historischen 3.4-Dokumenten

Es existieren ältere 3.4-Manuskript- und Repository-Stände.

Sie enthalten fachlich brauchbare Ideen wie:

- funktionale Zustände,
- Differenzstrukturen,
- Relationen,
- Transformationen,
- Zustandsräume,
- Kohärenz,
- Attraktoren,
- Raum- und Zeitrekonstruktion.

Diese historischen Dateien sind jedoch **nicht verbindlich**, weil sie auf einem älteren Stand von Kapitel 3.3 beruhen.

Insbesondere sind nicht zu übernehmen:

- alte Gleichungsnummern,
- alte Definitionsnummern,
- alte Satznummern,
- alte Literaturzähler,
- frühere Axiomlisten,
- ein früheres „Zusatzaxiom Vektor*0“,
- frühere Metatheorie-/Propositionsnummern als automatische Eingangsvoraussetzungen.

Historische 3.4-Inhalte dürfen nur als fachliche Prüfliste dienen.

Jeder Inhalt muss neu gegen den finalen Vierer-Kern geprüft werden.

---

# 25. Besonderer Hinweis „Vektor · 0“

Eine frühere Entwicklung behandelte die Frage, ob bei Multiplikation eines Vektors mit null zusätzliche Richtungsinformation erhalten bleiben müsse.

Für Kapitel 3.4 gilt mathematisch standardmäßig:

```latex
0\mathbf v=\mathbf 0
```

Aus dem Nullvektor allein ist die ursprüngliche Richtung von `\mathbf v` nicht rekonstruierbar.

Daraus folgt **kein zusätzliches FRZK-Primäraxiom**.

Falls eine spätere mathematische Realisierung Herkunfts-, Richtungs- oder Provenienzinformation erhalten soll, muss dafür eine erweiterte Zustandsstruktur konstruiert werden.

Diese Erweiterung ist Definition, Modellstruktur oder optionale Erweiterung und nicht automatisch ein fünftes Primäraxiom.

---

# 26. Verbindliche Repository-Schema-Referenz

Bis ein neuer vollständig verifizierter Dump vorliegt, ist die verbindliche Schema-Referenz:

```text
frzk_rkb_stand_ende_3.3.48.sql
```

Vor jedem neuen 3.4-Skript muss das tatsächliche Schema geprüft werden.

Es ist verboten, Spaltennamen aus Erinnerung oder alten fehlerhaften Skripten zu übernehmen.

---

# 27. Bestätigte zentrale Tabellen und Spalten

## 27.1 dissertation_sections

```text
parent_section_id
section_code
title
chapter_no
section_order
status
is_original_contribution
notes
```

## 27.2 repository_revisions

```text
revision_code
revision_date
scope_type
scope_reference
version_label
summary
created_by
parent_revision_id
```

## 27.3 definitions

```text
definition_number
section_id
title
definition_text
formal_latex
word_latex
provenance
source_id
assumptions
notes
validation_status
created_revision_id
```

## 27.4 theorems

```text
theorem_number
section_id
title
statement_text
statement_latex
word_latex
provenance
source_id
assumptions
validation_status
created_revision_id
```

## 27.5 corollaries

```text
corollary_number
section_id
title
statement_text
statement_latex
word_latex
parent_theorem_id
parent_lemma_id
provenance
source_id
validation_status
created_revision_id
```

Wichtig:

```text
corollaries besitzt kein assumptions-Feld
```

## 27.6 equations

```text
equation_number
section_id
title
equation_latex
word_latex
plain_description
equation_type
provenance
validation_status
created_revision_id
```

Kompatibler Standardtyp:

```text
other
```

## 27.7 axioms

Bestätigt verwendet:

```text
axiom_number
section_id
title
axiom_text
formal_latex
word_latex
motivation
independence_note
consistency_note
operationalization_note
source_assumption_id
status
created_revision_id
```

In Kapitel 3.4 sollen im normalen Arbeitsgang keine neuen Primäraxiomzeilen angelegt werden.

## 27.8 repository_counters

```text
counter_key
counter_value
updated_at
```

---

# 28. Weitere Repository-Objekte

Vor Verwendung Schema prüfen, insbesondere für:

```text
sources
authors
source_authors
source_usage
lemmas
proofs
propositions
assumptions
symbols
equation_symbols
object_source_links
figures
dissertation_tables
section_change_log
repository_validation_results
```

Keines dieser Felder oder Tabellen darf allein aufgrund einer historischen Datei als unverändert angenommen werden.

---

# 29. Verbindlicher SQL-Startblock

Neue Repository-Skripte sollen mit der bestätigten Verbindungs- und SQL-Mode-Konfiguration beginnen:

```sql
USE `frzk_rkb`;

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';
SET SESSION SQL_MODE='NO_AUTO_VALUE_ON_ZERO,NO_BACKSLASH_ESCAPES';

START TRANSACTION;
```

Der `parent_revision_id` des ersten 3.4-Skripts muss auf:

```text
RKB-NEU-K3.3.75-FINAL
```

zeigen.

---

# 30. Lehre aus dem defekten 3.3.74-Finalizer

Der frühere 3.3.74-Finalizer enthielt Stored-Procedure-DDL innerhalb einer laufenden Transaktion.

Das ist für die weitere Arbeit verboten.

## 30.1 Verboten

Innerhalb von `START TRANSACTION` nicht als Validierungsmechanismus verwenden:

```sql
CREATE PROCEDURE ...
DROP PROCEDURE ...
CALL ...
```

Der Grund ist, dass Stored-Routine-DDL in MariaDB implizite Commits verursachen kann.

## 30.2 Erlaubter Guard

Verbindliches Muster:

```sql
DROP TEMPORARY TABLE IF EXISTS tmp_guard;
CREATE TEMPORARY TABLE tmp_guard
(
    ok TINYINT NOT NULL
) ENGINE=InnoDB;

INSERT INTO tmp_guard(ok)
VALUES (NULLIF(@validation_ok,0));

DROP TEMPORARY TABLE IF EXISTS tmp_guard;
```

Wenn `@validation_ok = 0`, erzeugt `NULLIF(0,0)` den Wert `NULL`, der an `NOT NULL` scheitert und die Ausführung vor dem vorgesehenen `COMMIT` stoppt.

## 30.3 Diagnose vor dem Guard

Unmittelbar vor dem harten Guard muss eine Diagnoseausgabe stehen.

Sie soll alle Teilprüfungen einzeln zeigen.

Damit ist im Fehlerfall sichtbar, welche Teilbedingung gescheitert ist.

---

# 31. Historische Backslash-Problematik

Durch ältere Skripte können LaTeX-Felder physisch mit doppelten Backslashes gespeichert sein.

Bei exakten Stringvalidierungen ist deshalb die kanonische Normalisierung zu verwenden:

```sql
REPLACE(equation_latex,CHAR(92,92),CHAR(92))
```

beziehungsweise entsprechend für `formal_latex`, `word_latex` oder andere LaTeX-Felder.

Eine mathematisch korrekte Gleichung darf nicht allein wegen historisch unterschiedlicher physischer Backslash-Speicherung als falsch bewertet werden.

---

# 32. Idempotenz

Jedes 3.4-Skript soll möglichst erneut ausführbar sein.

Zu verwenden sind unter anderem:

```text
INSERT ... SELECT ... WHERE NOT EXISTS
ON DUPLICATE KEY UPDATE
sichere SELECTs zur ID-Auflösung
temporäre Staging-Tabellen
bereichsbezogene Validierungen
```

Keine festen AUTO_INCREMENT-IDs raten.

Keine fremden Datensätze anhand historischer IDs löschen.

Objekte immer über stabile fachliche Schlüssel wie `section_code`, `revision_code`, `definition_number`, `theorem_number`, `corollary_number`, `equation_number`, `citation_number` und `source_key` ermitteln.

---

# 33. Repository-Zähler nach erfolgreichem 3.3.75-Abschluss

Erwarteter Übergabestand:

```text
last_completed_chapter   = 3.3
last_completed_section   = 3.3.75
current_chapter          = 3.4
current_section          = 3.4.0

last_definition_number   = 3.3.1235
next_definition_number   = 3.4.1

last_theorem_number      = 3.3.774
next_theorem_number      = 3.4.1

last_corollary_number    = 3.3.502
next_corollary_number    = 3.4.1

last_equation_number     = 3.19230
next_equation_number     = 3.19231

last_repository_revision = RKB-NEU-K3.3.75-FINAL
```

Literatur zusätzlich separat gegen reale Daten prüfen:

```text
expected last_citation_number = 152
expected next_citation_number = 153
```

---

# 34. Validierungen vor dem ersten Abschnitt 3.4.0

Vor Beginn des Schreibens beziehungsweise spätestens vor dem ersten 3.4-SQL sind folgende Punkte zu prüfen:

1. `3.3` existiert genau einmal.
2. `3.3.status = final`.
3. `3.3.75` existiert genau einmal.
4. `3.3.75.status = final`.
5. Revision `RKB-NEU-K3.3.75-FINAL` existiert.
6. Die vier Primäraxiome I–III und A_C sind auffindbar.
7. Primäraxiom I besitzt die kanonische Minimalform.
8. Primäraxiom II besitzt die kanonische Minimalform.
9. Primäraxiom III besitzt die kanonische Minimalform.
10. Die endgültige Form von A_C ist vorhanden.
11. Gleichung `(3.19230)` existiert.
12. `next_equation_number = 3.19231`.
13. `next_definition_number = 3.4.1`.
14. `next_theorem_number = 3.4.1`.
15. `next_corollary_number = 3.4.1`.
16. `MAX(citation_number)` und Literaturzähler stimmen überein.
17. Keine offene 3.3.76-Struktur wird als nächster Abschnitt geführt.
18. Parent-Revision für 3.4 ist `RKB-NEU-K3.3.75-FINAL`.

---

# 35. Validierungen nach jedem neuen 3.4-Abschnitt

Mindestens prüfen:

1. Abschnitt existiert genau einmal.
2. Parent-Section ist korrekt.
3. Revision existiert genau einmal.
4. Parent-Revision ist korrekt.
5. Statuswert ist gültig.
6. Definitionen sind eindeutig.
7. Sätze sind eindeutig.
8. Korollare besitzen gültige Parent-IDs.
9. Gleichungen sind eindeutig und lückenlos.
10. Word-LaTeX fehlt bei keiner nummerierten Gleichung.
11. neue Literaturstellen sind eindeutig.
12. Wiederverwendete Quellen wurden nicht dupliziert.
13. Literatur-Fundstellen sind geprüft oder leer.
14. keine verwaisten Fremdschlüssel.
15. keine neuen Primäraxiome wurden unbemerkt angelegt.
16. Primäraxiomkern bleibt vierteilig.
17. neue mathematische Konstruktionen besitzen eine Rückführung.
18. Raum und Zeit wurden nicht unbemerkt vorausgesetzt.
19. Repository-Counter entsprechen dem tatsächlichen Endstand.
20. `validation_ok = 1` vor `COMMIT`.

---

# 36. Repository-Inhalt eines vollständigen 3.4-Abschnittsskripts

Je nach Inhalt soll ein Abschnittsskript mindestens folgende Blöcke besitzen:

```text
0. Schema-/Voraussetzungsprüfung
1. Abschnitt auflösen/anlegen
2. Parent-Revision auflösen
3. neue Revision anlegen
4. Literatur auflösen/anlegen
5. Autoren/Quellenverknüpfungen
6. source_usage
7. Definitionen
8. Lemmata/Propositionen/Sätze
9. Beweise
10. Korollare
11. Gleichungen
12. Symbole/Objektverknüpfungen, falls benötigt
13. Abschnitt finalisieren
14. Repository-Counter
15. Diagnose
16. transaktionssicherer Guard
17. COMMIT
18. Kontrollausgaben
```

Nicht benötigte Objektarten werden weggelassen. Es werden keine künstlichen Daten angelegt, nur um eine Tabelle zu füllen.

---

# 37. Keine erfundenen Beweise

Eine mathematische Behauptung darf nicht allein deshalb als „Satz“ gespeichert werden, weil sie plausibel klingt.

Wenn eine Behauptung von einer zusätzlichen Voraussetzung abhängt, muss diese offen genannt werden.

Wenn nur eine Konstruktionsmöglichkeit gezeigt wurde, darf daraus keine Eindeutigkeit behauptet werden.

Wenn eine Aussage modellabhängig ist, muss sie als modellabhängig markiert werden.

---

# 38. Keine unzulässige Ontologisierung

Kapitel 3.4 ist mathematische Rekonstruktion.

Daher gilt:

```text
mathematische Struktur ≠ automatisch ontologische Struktur
```

Ein Graph ist zunächst ein Graph.

Ein Vektorraum ist zunächst ein Vektorraum.

Eine Metrik ist zunächst eine Metrik.

Eine Mannigfaltigkeit ist zunächst eine Mannigfaltigkeit.

Eine mathematische Ähnlichkeit mit physikalischem Raum oder physikalischer Zeit ist noch kein Nachweis ihrer physikalischen Identität.

---

# 39. Keine Konkurrenzbehauptung gegenüber etablierter Physik

Das FRZK wird nicht als bloßer Ersatz für Allgemeine Relativitätstheorie, Quantenmechanik oder bestehende Quantengravitationsansätze formuliert.

Kapitel 3.4 entwickelt eine mathematische Beschreibungsebene des FRZK.

Vergleiche mit etablierter Physik sind zulässig, wenn klar zwischen FRZK-Struktur, mathematischer Analogie, etablierter physikalischer Theorie und empirischer Interpretation unterschieden wird.

---

# 40. Qualitätsanforderungen an Beispiele

Wenn Beispiele verwendet werden, müssen sie:

- alle verwendeten Größen definieren,
- den Rechenweg nachvollziehbar zeigen,
- mathematische Aussage und FRZK-Interpretation trennen,
- klar markieren, ob es sich um ein allgemeines Beispiel oder nur um eine Modellinstanz handelt.

Beispiele dürfen keine zusätzliche Axiomannahme verstecken.

---

# 41. Umgang mit optionalen Erweiterungsstrukturen aus Kapitel 3.3

Kapitel 3.3 hat zahlreiche Strukturen als optional oder modellabhängig eingeordnet.

Kapitel 3.4 darf solche Strukturen verwenden, wenn sie für eine konkrete Realisierung nützlich sind.

Dabei muss gelten:

```text
optional in 3.3
→ bleibt optional in 3.4,
solange kein neuer Axiomaudit eine Statusänderung begründet.
```

Eine konsolidierte Gesamtarchitektur macht eine optionale Struktur nicht automatisch primär.

---

# 42. Re-Audit-Auslöser

Ein erneuter Axiomaudit ist zwingend, wenn in Kapitel 3.4:

- ein fünftes Primäraxiom beansprucht wird,
- eines der vier Primäraxiome entfernt wird,
- ein Primäraxiom ersetzt wird,
- eine neue Brückenannahme eingeführt wird, die Unabhängigkeit verändern kann,
- eine mathematische Realisierungsbedingung rückwirkend als Primärvoraussetzung behandelt werden soll.

Dann gilt:

```text
3.4-Arbeit stoppen
→ Axiomstatus prüfen
→ Re-Audit
→ erst danach fortfahren
```

---

# 43. Rekonstruktionsmatrix für die ersten vier Kernbereiche

| Primäraxiom | Mindestforderung | Erste mathematische Aufgabe | Nicht automatisch enthalten |
|---|---|---|---|
| A_I | nichtleerer funktionaler Zustandsbereich | Träger-/Zustandsstruktur | Vektorraum, Metrik, Dimension, Geometrie |
| A_II | mindestens ein funktionales Relationsobjekt | Relationsstruktur | Symmetrie, Transitivität, Kausalität, Metrik |
| A_III | mindestens eine funktionale Transformation | Transformationsstruktur | Linearität, Invertierbarkeit, Zeitparameter |
| A_C | positive Kohärenz für mindestens eine relevante Teilstruktur | Kohärenzstruktur | eindeutiges Maß, konkrete Dynamik, physikalische Interpretation |

Diese Tabelle ist als permanente Prüfliste für Kapitel 3.4 zu behandeln.

---

# 44. Mindestfragen für jede neue mathematische Definition

Vor jeder neuen FRZK-Definition in Kapitel 3.4 sind intern folgende Fragen zu beantworten:

1. Welches konkrete Problem der Rekonstruktion löst die Definition?
2. Auf welches Axiom oder welche bereits abgeleitete Struktur geht sie zurück?
3. Welches mathematische Werkzeug aus Kapitel 3.2 wird verwendet?
4. Ist die Definition minimal?
5. Werden stärkere Eigenschaften eingeführt als benötigt?
6. Ist die Struktur eindeutig oder nur eine mögliche Realisierung?
7. Welche Aussagen folgen ausdrücklich nicht?
8. Ist Raum, Zeit, Kausalität oder Information unbemerkt vorausgesetzt?
9. Muss Literatur zitiert werden?
10. Welche Repository-Objekte müssen angelegt werden?

---

# 45. Mindestfragen für jeden neuen Satz

1. Welche Voraussetzungen besitzt der Satz?
2. Sind alle Voraussetzungen bereits definiert oder bewiesen?
3. Ist der Satz allgemein oder modellabhängig?
4. Ist die Aussage wirklich ableitbar?
5. Ist ein Gegenbeispiel möglich?
6. Ist ein zusätzlicher Parameter nötig?
7. Ist der Beweis vollständig?
8. Kann das Ergebnis stärker formuliert werden, ohne unbegründete Annahmen?
9. Kann es schwächer und allgemeiner formuliert werden?
10. Welches Korollar folgt tatsächlich unmittelbar?

---

# 46. Arbeitsprinzip „weiter“

Wenn im neuen Chat der Nutzer schreibt:

```text
weiter
```

dann ist der nächste inhaltliche Dissertationsteil vollständig im Chat zu entwickeln.

Dabei:

- keine bloße Gliederung ausgeben,
- keine Zusammenfassung statt Text,
- gerenderte Formeln im Chat,
- Word-LaTeX unmittelbar nach jeder nummerierten Gleichung,
- Nummern lückenlos fortführen,
- Literaturregeln einhalten,
- Methodologische Betrachtungen ergänzen,
- Didaktische Betrachtungen ergänzen,
- am Ende exakten Endstand nennen.

---

# 47. Arbeitsprinzip „skript“

Wenn der Nutzer schreibt:

```text
skript
```

dann ist für den unmittelbar zuvor abgeschlossenen Abschnitt:

1. das tatsächliche Schema zu prüfen,
2. der unmittelbare Parent-Stand zu prüfen,
3. das vollständige SQL zu erzeugen,
4. das vollständige SQL im Chat auszugeben,
5. zusätzlich eine `.sql`-Datei zu erzeugen,
6. zusätzlich SHA-256 zu erzeugen,
7. die Sollwerte der Validierung zu nennen.

Ein Download ersetzt niemals die vollständige Ausgabe im Chat.

---

# 48. Erster neuer Repository-Revisionscode

Für Abschnitt 3.4.0 wird als Arbeitskonvention empfohlen:

```text
RKB-NEU-K3.4.0-V1
```

oder bei unmittelbarem Finalabschluss:

```text
RKB-NEU-K3.4.0-FINAL
```

Der Parent muss lauten:

```text
RKB-NEU-K3.3.75-FINAL
```

Die tatsächliche Namenskonvention ist vor dem ersten Skript gegen den jüngsten Repository-Stil zu prüfen.

---

# 49. Start von Abschnitt 3.4.0

Abschnitt 3.4.0 soll noch keine große mathematische Spezialstruktur vorwegnehmen.

Seine Aufgabe ist:

- den Wechsel von Axiomatik zu mathematischer Rekonstruktion erklären,
- den Vierer-Kern als unveränderten Input nennen,
- das Rückführungsprinzip festlegen,
- den mathematischen Werkzeugraum aus 3.2 einordnen,
- die Statusklassen wiederholen, soweit für 3.4 erforderlich,
- die Konstruktionsreihenfolge begründen,
- den ersten tatsächlichen Rekonstruktionsschritt vorbereiten.

Die erste Gleichung von 3.4 ist:

```text
(3.19231)
```

wenn 3.4.0 eine nummerierte Gleichung benötigt.

Die erste Definition von 3.4 ist:

```text
Definition 3.4.1
```

Sie muss nicht künstlich in 3.4.0 eingeführt werden, wenn der Abschnitt keine Definition benötigt. Die Nummer wird erst beim ersten tatsächlichen Definitionsobjekt vergeben.

Dasselbe gilt für Satz 3.4.1 und Korollar 3.4.1.

---

# 50. Verbindlicher Startauftrag für einen neuen Chat

Der neue Chat soll mit folgender Anweisung arbeiten:

```text
Lies das vollständige Übergabedokument 3.3 → 3.4 und den letzten verbindlichen
Repository-Endstand RKB-NEU-K3.3.75-FINAL / REPAIR V2.

Prüfe zuerst den realen Datenbank- und Zählerstand. Bestätige insbesondere:

1. Kapitel 3.3 = final.
2. Abschnitt 3.3.75 = final.
3. Letzte Revision = RKB-NEU-K3.3.75-FINAL.
4. Der Primäraxiomkern besteht exakt aus A_I, A_II, A_III und A_C.
5. A_I = \mathcal S_{\mathrm{el}}\neq\emptyset.
6. A_II = \mathfrak R_{\mathrm f}\neq\emptyset.
7. A_III = \mathfrak T_{\mathrm f}\neq\emptyset.
8. A_C liegt in der endgültigen Kohärenzform vor.
9. Nächste Gleichung = (3.19231).
10. Nächste Definition = 3.4.1.
11. Nächster Satz = 3.4.1.
12. Nächstes Korollar = 3.4.1.
13. Literaturzähler durch MAX(citation_number) und repository_counters verifiziert.
14. Parent-Revision für 3.4 = RKB-NEU-K3.3.75-FINAL.

Entwickle anschließend Abschnitt 3.4.0 vollständig im persönlichen
wissenschaftlichen Schreibstil in Ich-Form.

Kapitel 3.4 führt keine neuen Primäraxiome ein.
Jede mathematische Konstruktion muss auf Kapitel 3.3 und die mathematischen
Werkzeuge aus Kapitel 3.2 zurückführbar sein.
Raum und Zeit dürfen nicht als primitive Voraussetzungen eingeführt werden.
Jede nummerierte Gleichung erhält unmittelbar danach Word-LaTeX.
Jeder vollständige Abschnitt endet mit ausführlichen Methodologischen
Betrachtungen und Didaktischen Betrachtungen.

Nach dem Abschnitt warte auf den Befehl „skript“.
Beim Befehl „skript“ wird das vollständige Repository-SQL im Chat und
zusätzlich als Datei mit SHA-256 ausgegeben.
```

---

# 51. Kurzfassung für die sofortige Orientierung

```text
FRZK – Übergabe 3.3 → 3.4

Kapitel 3.3: FINAL
Letzter Abschnitt: 3.3.75
Letzte Revision: RKB-NEU-K3.3.75-FINAL
Verbindliches SQL: ...3.3.75...REPAIR_V2.sql

Primäraxiomkern:
A_I   : S_el != ∅
A_II  : R_f != ∅
A_III : T_f != ∅
A_C   : mindestens eine funktional relevante Teilstruktur mit C_F > 0

Audit: bestanden
Neue Axiome in 3.4: verboten, sofern kein Re-Audit ausgelöst wird

Letzte Gleichung: (3.19230)
Nächste Gleichung: (3.19231)

Letzte Definition: 3.3.1235
Nächste Definition: 3.4.1

Letzter Satz: 3.3.774
Nächster Satz: 3.4.1

Letztes Korollar: 3.3.502
Nächstes Korollar: 3.4.1

Erwartete letzte Literatur: [152]
Erwartete nächste Literatur: [153]
Vor Neuanlage zwingend real prüfen.

Nächster Textstart: 3.4.0
Ziel: mathematische Rekonstruktion funktionaler Organisation
```

---

# 52. Verbindlicher Schlusspunkt der Übergabe

Mit diesem Übergabestand ist die Axiomensuche von Kapitel 3.3 beendet.

Kapitel 3.4 beginnt nicht mit der Frage, welche weiteren Grundannahmen benötigt werden, sondern mit der Frage, welche mathematischen Strukturen die bereits fixierten funktionalen Mindestbedingungen realisieren können.

Der methodische Kern der Fortsetzung lautet:

```text
keine neuen Primäraxiome
+
minimale mathematische Realisierung
+
vollständige Rückführbarkeit
+
klare Trennung von Axiom, Definition, Ableitung und Modellannahme
+
keine versteckten Raum-/Zeitvoraussetzungen
+
repositoryseitige Reproduzierbarkeit
```

Der verbindliche nächste Arbeitsstart ist:

```text
3.4.0
```

mit der nächsten freien Gleichungsnummer:

```text
(3.19231)
```

und den ersten kapitelbezogenen Objektzählern:

```text
Definition 3.4.1
Satz 3.4.1
Korollar 3.4.1
```

# ENDE DES VERBINDLICHEN ÜBERGABEDOKUMENTS 3.3 → 3.4
