# UEBERGABE FRZK – Kapitel 3.2 → Kapitel 3.3

**Projekt:** Dissertation FRZK – Funktionales Raum-Zeit-Kohärenzsystem  
**Übergabepunkt:** Ende Kapitel 3.2 „Mathematische Grundlagen“ → Start Kapitel 3.3 „Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems“  
**Arbeitsstand:** 2026-09-04  
**Zweck:** Vollständige inhaltliche, mathematische, repositoryseitige und prozessuale Übergabe für einen neuen Chat, der ausschließlich Kapitel 3.3 bearbeitet.  
**Wichtig:** Diese Datei ist so aufgebaut, dass ein neuer 3.3-Chat ohne Rückgriff auf den vorherigen 3.2-Chat arbeitsfähig sein soll.

---

# 0. Harte Startanweisung für den neuen 3.3-Chat

Arbeite ausschließlich an **Kapitel 3.3 – Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems**.

Kapitel 3.2 ist inhaltlich vollständig neu montiert. Sein mathematischer Haupttext besteht aus den Abschnitten **3.2.0 bis 3.2.7**; die mathematische Vertiefung liegt in den finalen Anlagen **M1 bis M6**. Kapitel 3.3 darf diese Mathematik nicht noch einmal als Grundlagenkapitel wiederholen. Es übernimmt die mathematischen Strukturen aus 3.2 ausschließlich als **verfügbare formale Werkzeuge mit expliziten Voraussetzungen**.

Die zentrale Übergangsregel lautet:

> **Kapitel 3.2 stellt mathematische Möglichkeiten bereit. Kapitel 3.3 entscheidet axiomatisch, welche davon für das FRZK gesetzt, definiert, abgeleitet, modellbedingt eingeschränkt oder über Brückenstrukturen ergänzt werden dürfen.**

Dabei ist strikt zu unterscheiden zwischen:

1. etablierter Mathematik aus 3.2,
2. definitorischen beziehungsweise kanonischen Konstruktionen in 3.3,
3. mathematischen Folgerungen,
4. universellen Primärsetzungen,
5. Modellbedingungen,
6. Brückenstrukturen,
7. Interpretationen,
8. metatheoretischer Kontrolle.

Diese Ebenen dürfen im Fließtext, in Formeln, im Repository oder in der Argumentation **niemals unmarkiert ineinander übergehen**.

---

# 1. Priorität der Quellen und Dateien

Für Kapitel 3.3 gilt folgende Prioritätsordnung:

1. **Neuester tatsächlich erzeugter und verifizierter Enddump Ende 3.2**  
   Dieser Dump ist die kanonische technische Startbasis für 3.3.

2. **Dieses Übergabe-MD**  
   Es beschreibt die verbindlichen Regeln, den mathematischen Endstand und die Startbedingungen.

3. **Aktuelle 3.3-Quell-/Arbeitsfassung**  
   `3.3 Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems_V2.docx`  
   Diese Fassung ist **Quell- und Referenzmaterial**, aber nicht automatisch kanonisch. Sie muss gegen den neuen 3.2-Endstand und das Repository neu geprüft werden.

4. **Aktuelle wissenschaftliche Stilvorgaben**  
   insbesondere `Olaf_Schreibstil_Wissenschaft...` sowie die im Projekt verbindlich gewordenen Regeln.

5. **Ältere 3.3-Skripte, ältere Dumps und ältere Übergaben**  
   nur als Provenienz und Vergleich, niemals als führender Endstand.

## 1.1 Derzeit maßgeblicher Ist-Dump

Der zuletzt hochgeladene reale Dump lautet:

`frzk_rkb_32_neu.sql`

Er wurde laut Dumpkopf am **04.09.2026 um 16:47 Uhr** aus MariaDB 10.4.32 erzeugt.

Dieser Dump ist **noch kein verifizierter Enddump Ende 3.2**, weil er den Zustand nach dem ersten, nicht vollständig erfolgreichen Final-Gate enthält. Er darf deshalb im neuen 3.3-Chat nur als **Vor-Finalisierungs-Iststand** verwendet werden.

## 1.2 Korrigiertes Übergangsgate

Für den realen 16:47-Dump wurde anschließend erstellt:

`FRZK_3_2_GATE_3_2_ZU_3_3_V2_2026-09-04.sql`

Revisionscode des V2-Gates:

`RKB32-FINAL-GATE-3.2-TO-3.3-2026-09-04-V2`

Das V2-Gate ist die technische Freigabeinstanz. Kapitel 3.3 darf erst als neuer kanonischer Arbeitsstand begonnen werden, wenn die Ausführung dieses Gates am Ende liefert:

`FINAL_3.2_TO_3.3_PASS`

und danach ein neuer Enddump erzeugt und verifiziert wurde.

---

# 2. Status des Übergangs: inhaltlich abgeschlossen, technisch erst nach V2-PASS eingefroren

## 2.1 Inhaltlicher Stand

Kapitel 3.2 ist **inhaltlich abgeschlossen**.

Vollständige Zielgliederung:

| Abschnitt | Titel |
|---|---|
| 3.2.0 | Mathematische Grundlegung und Abgrenzung |
| 3.2.1 | Mengen, Relationen und Funktionen |
| 3.2.2 | Vektorräume und lineare Strukturen |
| 3.2.3 | Lineare Abbildungen und ihre Darstellung |
| 3.2.4 | Struktur linearer Operatoren |
| 3.2.5 | Eigenstruktur und Spektraldarstellung |
| 3.2.6 | Skalarprodukt-, Projektions- und Hilbertraumstrukturen |
| 3.2.7 | Mathematische Anschlussstruktur für das FRZK |

Die Quellstruktur 3.2.0–3.2.12 bleibt als **Provenienz-/Stagingstruktur** erhalten. Die neue Zielstruktur ist die oben genannte komprimierte Fassung 3.2.0–3.2.7.

## 2.2 Technischer Stand im realen Dump von 16:47

Im realen Dump ist bereits die erste Abschlussrevision vorhanden:

`RKB32-FINAL-GATE-3.2-TO-3.3-2026-09-04`

Diese erste Abschlussrevision hat die neue Placement- und Lineage-Schicht erzeugt, den Übergang aber **nicht freigegeben**.

Im 16:47-Dump gilt deshalb noch:

- Kapitel `3.2`: noch nicht `final`,
- Zielabschnitte `3.2.0–3.2.7`: noch nicht vollständig `final`,
- finale Abschnittsversionen unter der ersten Gate-Revision: `0`,
- sichtbare Definitionen: 27 vorhanden, aber noch `rewrite`,
- sichtbare Gleichungen: 80 vorhanden, aber noch `rewrite`,
- Haupttextplatzierungen: 112 bereits `accepted`,
- mathematische Anlagen: M1–M6 final,
- zwei Nicht-PASS-Zeilen im globalen `v_math_compression_gate`,
- drei historische Critical-Issues noch offen.

## 2.3 Exakt identifizierte Restursachen des ersten Gate-Fails

Das V2-Gate korrigiert ausschließlich die real nachgewiesenen Restursachen:

### A. Legacy-Profil `repo_object_id = 48`

Dieses Objekt ist historisch als

- `document_location = main_text`,
- `importance_level = example`,
- `equation_role = example`

klassifiziert, obwohl seine neue Haupttextplatzierung bereits `superseded` ist.

Das alte globale Compression-Gate berücksichtigt jedoch noch das Profil und erzeugt deshalb einen False Positive.

V2 normalisiert nur das Profil auf:

- `importance_level = supporting`,
- `equation_role = derived`,

während Quellpayload und `superseded`-Placement erhalten bleiben.

### B. Fehlende downstream requirements für `repo_object_id 276–282`

Sieben revisionsgebundene Gleichungen aus dem neuen 3.2.1 besitzen bereits akzeptierte Haupttextplatzierungen, aber noch keine `object_section_requirements`.

V2 ergänzt für diese Objekte zunächst die Kapitelanforderung:

`required_for_section_code = '3.3'`

Die spätere **Feinauflösung auf konkrete 3.3.x-Abschnitte ist ausdrücklich Aufgabe der 3.3-Integration**.

### C. Historische Critical-Issues 1, 2 und 4

Sie werden von V2 nur dann geschlossen, wenn die Korrektur in der Datenbank tatsächlich nachweisbar ist:

- Issue 1: alte source equation `3.49` → aktuelle Haupttextgleichung `(3.38)` mit Word-LaTeX und akzeptierter Platzierung,
- Issue 2: alte source equation `3.50` → finale Anlagengleichung `M3.5`,
- Issue 4: beschädigte alte source equation `3.173` → finale korrigierte Anlagengleichung `M5.25`.

---

# 3. Harte Gate-Bedingung vor Beginn der kanonischen 3.3-Arbeit

Der neue 3.3-Chat muss zuerst den neuesten Enddump prüfen.

Die kanonische Arbeit an 3.3 darf erst starten, wenn mindestens Folgendes erfüllt ist:

```sql
SELECT section_code, title, status
FROM dissertation_sections
WHERE section_code IN
('3.2','3.2.0','3.2.1','3.2.2','3.2.3','3.2.4','3.2.5','3.2.6','3.2.7')
ORDER BY section_order;
```

Erwartung:

- Kapitel `3.2` = `final`,
- alle acht Zielabschnitte `3.2.0–3.2.7` = `final`.

Zusätzlich:

```sql
SELECT revision_id, revision_code, scope_type, scope_reference, version_label
FROM repository_revisions
WHERE revision_code='RKB32-FINAL-GATE-3.2-TO-3.3-2026-09-04-V2';
```

Erwartung: genau eine V2-Abschlussrevision.

Dann:

```sql
SELECT COUNT(*) AS final_versions
FROM section_versions sv
JOIN repository_revisions rr
  ON rr.revision_id=sv.revision_id
WHERE rr.revision_code='RKB32-FINAL-GATE-3.2-TO-3.3-2026-09-04-V2'
  AND sv.version_kind='final';
```

Erwartung:

`8`

Dann:

```sql
SELECT *
FROM v_math_compression_gate
ORDER BY gate_code;
```

Erwartung:

**jede Zeile PASS**

Parser-/Collation-sicher:

```sql
SELECT COUNT(*) AS non_pass
FROM v_math_compression_gate
WHERE HEX(gate_status) <> '50415353';
```

Erwartung:

`0`

Außerdem:

```sql
SELECT COUNT(*) AS accepted_definitions
FROM definition_candidates
WHERE proposed_definition_number LIKE '3.2.%'
  AND candidate_status='accepted';

SELECT COUNT(*) AS accepted_equations
FROM equation_candidates
WHERE proposed_equation_number LIKE '3.%'
  AND candidate_status='accepted';
```

Erwartung:

- Definitionen: `27`,
- Gleichungen: `80`.

Und:

```sql
SELECT COUNT(*) AS accepted_main_placements
FROM main_text_object_placements p
JOIN dissertation_sections ds
  ON ds.section_id=p.target_section_id
WHERE p.placement_status='accepted'
  AND ds.section_code IN
  ('3.2.0','3.2.1','3.2.2','3.2.3','3.2.4','3.2.5','3.2.6','3.2.7');
```

Erwartung:

`112`

Wenn eine dieser Bedingungen nicht erfüllt ist, darf der neue Chat **nicht** so tun, als wäre 3.2 technisch final.

---

# 4. Mathematischer Endbestand des neuen Haupttexts 3.2

## 4.1 Sichtbare Definitionen

Kapitel 3.2 enthält nach der Neumontage genau **27 Definitionen**.

| Abschnitt | Definitionsnummern | Anzahl |
|---|---:|---:|
| 3.2.0 | keine | 0 |
| 3.2.1 | Definition 3.2.1–3.2.3 | 3 |
| 3.2.2 | Definition 3.2.4–3.2.9 | 6 |
| 3.2.3 | Definition 3.2.10–3.2.11 | 2 |
| 3.2.4 | Definition 3.2.12–3.2.15 | 4 |
| 3.2.5 | Definition 3.2.16–3.2.21 | 6 |
| 3.2.6 | Definition 3.2.22–3.2.27 | 6 |
| 3.2.7 | keine neue mathematische Definition | 0 |
| **Summe** | **3.2.1–3.2.27** | **27** |

### Definitionen nach Inhalt

#### 3.2.1
- 3.2.1 Menge und Element
- 3.2.2 Binäre Relation
- 3.2.3 Funktion

#### 3.2.2
- 3.2.4 Vektorraum
- 3.2.5 Linearkombination
- 3.2.6 Spannraum
- 3.2.7 Lineare Unabhängigkeit
- 3.2.8 Basis
- 3.2.9 Dimension

#### 3.2.3
- 3.2.10 Lineare Abbildung
- 3.2.11 Linearer Operator

#### 3.2.4
- 3.2.12 Determinante einer quadratischen Matrix
- 3.2.13 Bild einer linearen Abbildung
- 3.2.14 Kern einer linearen Abbildung
- 3.2.15 Rang einer linearen Abbildung

#### 3.2.5
- 3.2.16 Eigenwert und Eigenvektor
- 3.2.17 Eigenraum
- 3.2.18 Charakteristisches Polynom
- 3.2.19 Algebraische und geometrische Vielfachheit
- 3.2.20 Spektrum eines Operators
- 3.2.21 Diagonalisierbarkeit

#### 3.2.6
- 3.2.22 Skalarprodukt
- 3.2.23 Vom Skalarprodukt induzierte Norm
- 3.2.24 Orthogonalität
- 3.2.25 Orthonormales Vektorsystem
- 3.2.26 Orthogonale Projektion auf eine Richtung
- 3.2.27 Hilbertraum

## 4.2 Sichtbare Gleichungen

Kapitel 3.2 endet mit **Gleichung (3.80)**.

Die Nummerierung ist vollständig und lückenlos:

| Abschnitt | Gleichungsbereich | Anzahl |
|---|---:|---:|
| 3.2.0 | keine | 0 |
| 3.2.1 | (3.1)–(3.20) | 20 |
| 3.2.2 | (3.21)–(3.31) | 11 |
| 3.2.3 | (3.32)–(3.42) | 11 |
| 3.2.4 | (3.43)–(3.53) | 11 |
| 3.2.5 | (3.54)–(3.65) | 12 |
| 3.2.6 | (3.66)–(3.80) | 15 |
| 3.2.7 | keine neue Gleichung | 0 |
| **Summe** | **(3.1)–(3.80)** | **80** |

Für die globale fortlaufende Gleichungsnummerierung folgt daraus:

> **Die erste neu sichtbare Gleichung in der kanonischen Neufassung von Kapitel 3.3 muss grundsätzlich mit (3.81) beginnen**, sofern kein ausdrücklich beschlossenes neues Nummerierungssystem eingeführt wird.

Alte 3.3-Quellgleichungsnummern wie `(3.2858)`, `(3.2931)` usw. sind bei einer Neufassung **nur Provenienznummern** und dürfen nicht ungeprüft als neue sichtbare Gleichungsnummern übernommen werden.

## 4.3 Fünf kanonische Satz-/Kriteriumsobjekte im Hauptpfad

Der verdichtete Haupttext enthält fünf akzeptierte Satz-/Kriteriumsobjekte:

### 3.2.4
1. **Rang-Nullitätssatz**
2. **Zusammenhang mit Injektivität und Surjektivität**

### 3.2.5
3. **Eigenvektoren zu verschiedenen Eigenwerten**
4. **Voraussetzung der Diagonalisierbarkeit**
5. **Spektraldarstellung**

Diese Satzobjekte besitzen keine zusätzliche sichtbare Satznummer, wenn ihre Kernaussage bereits durch die sichtbaren Gleichungen des Abschnitts repräsentiert wird. Ihre Repository-Identität bleibt dennoch erhalten.

---

# 5. Mathematische Anlagen M1–M6 – finaler Vertiefungsbestand

Die Anlagen sind **kein optionales Zusatzmaterial**, sondern die ausgelagerte mathematische Beweis-, Rechen-, Vertiefungs- und Beispielebene von Kapitel 3.2.

## 5.1 Finaler Bestand

| Anlage | Titel | finale Gleichungen | ausgelagerte Repository-Objekte |
|---|---|---:|---:|
| M1 | Mengentheoretische und funktionale Grundlagen | 26 | 26 |
| M2 | Algebraische Grundlagen des Vektorraums | 23 | 26 |
| M3 | Matrizen, Basiswechsel und Invarianten | 14 | 14 |
| M4 | Rang, Kern, Bild und lineare Gleichungssysteme | 6 | 6 |
| M5 | Eigenwerte, Diagonalisierung und Spektralrechnung | 30 | 30 |
| M6 | Skalarprodukt, Orthogonalität, Projektion und Hilbertraumstrukturen | 34 | 42 |
| **Summe** |  | **133** | **144** |

Alle sechs Module müssen `status = final` behalten.

## 5.2 Funktion der Anlagen für Kapitel 3.3

Kapitel 3.3 darf bei Bedarf auf M1–M6 zurückgreifen, aber es darf:

- Herleitungen nicht erneut ausbreiten, wenn sie in den Anlagen bereits final dokumentiert sind,
- Beispiele aus den Anlagen nicht als neue FRZK-Eigenleistung darstellen,
- mathematische Resultate aus M1–M6 nicht in physikalische Aussagen umdeuten, ohne eine explizite neue theoretische Setzung oder Brücke einzuführen.

## 5.3 Inhaltliche Zuständigkeit

- **M1:** Mengen, Teilmengen, Mengenoperationen, kartesische Produkte, Bild/Urbild, Verkettung, mehrstellige/parametrisierte/partielle Funktionen.
- **M2:** Vektorraumaxiome, Nullbeziehungen, Untervektorräume, lineare Abhängigkeit, Standardbasis und Beispiele.
- **M3:** Operatorverkettung, Identität, Matrixdarstellung, Basiswechsel, Determinantenrechnungen, Orientierung, singuläre Beispiele.
- **M4:** Rang, Kern, Bild, Rang-Nullität, Lösbarkeit linearer Gleichungssysteme.
- **M5:** Eigenwerte, Vielfachheiten, Diagonalisierung, Nichtdiagonalisierbarkeit, Matrixfunktionen, Eigenprojektoren und Spektralrechnungen.
- **M6:** Norm/Abstand, Cauchy-Schwarz, Winkel, Orthogonalität, Pythagoras, Normierung, orthogonale Komplemente, Projektoren, Gram-Schmidt und Hilbertraum-/Funktionenraumanschluss.

---

# 6. Inhaltliche Grenzlinie, die 3.3 zwingend übernehmen muss

Der wichtigste inhaltliche Übergabepunkt aus 3.2.7 lautet:

> Ein mathematischer Objektbereich ist noch kein physikalischer Zustandsraum.  
> Eine Funktion ist noch kein Entwicklungsprozess.  
> Ein Vektorraum ist noch kein physikalischer Raum.  
> Ein linearer Operator ist noch kein Naturgesetz.  
> Ein Eigenwert besitzt noch keine physikalische Bedeutung.  
> Ein Skalarprodukt ist noch keine physikalische Metrik.  
> Orthogonalität ist noch keine physikalische Unabhängigkeit.  
> Ein Hilbertraum ist noch nicht automatisch der Zustandsraum einer FRZK-Theorie.

Kapitel 3.3 muss daher bei jeder neuen Verwendung einer mathematischen Struktur beantworten:

1. **Welche mathematische Voraussetzung aus 3.2 wird verwendet?**
2. **Ist diese Struktur nur definitorisch übernommen oder wird sie als FRZK-Struktur gesetzt?**
3. **Folgt die Aussage mathematisch oder benötigt sie ein neues Axiom?**
4. **Gilt sie universell oder nur in einer Modellklasse?**
5. **Benötigt sie eine Brücke?**
6. **Ist die anschließende physikalische Bedeutung lediglich Interpretation?**
7. **Welche Geltungsstufe besitzt die Aussage?**

---

# 7. Hierarchie der aus 3.2 verfügbaren mathematischen Voraussetzungen

Kapitel 3.3 muss die Voraussetzungen in folgender logischer Richtung respektieren:

```text
Menge / Objektbereich
    ↓
Relation
    ↓
Funktion
    ↓
Vektorraumstruktur
    ↓
lineare Abbildung / Operator
    ↓
Matrixdarstellung relativ zu Basen
    ↓
Kern / Bild / Rang / Invertierbarkeit
    ↓
Eigenstruktur / Spektrum
    ↓
Skalarprodukt
    ↓
Norm / Orthogonalität / Projektion
    ↓
Vollständigkeit
    ↓
Hilbertraum
```

Diese Darstellung bedeutet **keine automatische FRZK-Konstruktionskette**. Sie ist nur eine mathematische Abhängigkeitsordnung.

Insbesondere:

- Ein Vektorraum setzt keinen ausgezeichneten geometrischen Raum voraus.
- Eine Matrix ist keine basisfreie Struktur.
- Ein Eigenwert trägt keine vorgegebene physikalische Semantik.
- Eine Norm folgt bei der hier verwendeten Konstruktion aus dem Skalarprodukt, aber nicht jede Norm stammt aus einem Skalarprodukt.
- Orthogonalität setzt ein bestimmtes Skalarprodukt voraus.
- Ein Skalarproduktraum ist nicht automatisch vollständig.
- Hilbertraum-Operatorentheorie ist nicht einfach identisch mit endlichdimensionaler Matrixrechnung.

---

# 8. Was Kapitel 3.2 ausdrücklich NICHT festgelegt hat

Kapitel 3.3 darf folgende Aussagen nicht stillschweigend als Ergebnis von 3.2 voraussetzen:

- welche Entitäten FRZK-Grundobjekte sind,
- welche Objekte zusammen einen FRZK-Zustandsraum bilden,
- ob dieser Zustandsraum ein Vektorraum ist,
- ob der Zustandsraum endlich- oder unendlichdimensional ist,
- welcher Skalarkörper FRZK-seitig ausgezeichnet ist,
- ob reale oder komplexe Skalare notwendig sind,
- welche Funktionen einen realen Entwicklungsprozess beschreiben,
- ob solche Abbildungen linear sind,
- ob sie invertierbar sind,
- ob bestimmte Operatoren ausgezeichnet sind,
- ob Eigenwerte eine physikalische Bedeutung besitzen,
- ob ein bestimmtes Skalarprodukt physikalisch bevorzugt ist,
- ob Orthogonalität physikalische Unabhängigkeit bedeutet,
- ob eine bestimmte positiv definite Matrix eine physikalische Metrik definiert,
- ob ein FRZK-Zustandsraum ein Hilbertraum ist,
- ob eine Spektralzerlegung universell vorausgesetzt werden darf,
- ob eine mathematische Rekonstruktion bereits eine physikalische Interpretation liefert.

**Jede dieser Aussagen wäre eine zusätzliche theoretische Entscheidung und muss in 3.3 entsprechend klassifiziert werden.**

---

# 9. Repository-Grundprinzip: Herkunft und Zielplatzierung sind getrennt

## 9.1 `repository_objects.section_id`

Für ursprüngliche 3.2-Objekte bezeichnet:

`repository_objects.section_id`

die **Quellprovenienz**.

Diese Spalte darf bei der 3.3-Arbeit nicht als bloßes Zielplatzierungsfeld behandelt werden.

## 9.2 `main_text_object_placements`

Die neue Haupttext-Zielplatzierung von 3.2 ist separat gespeichert.

Kernfelder:

```text
placement_id
repo_object_id
target_section_id
placement_order
placement_role
source_section_code
placement_status
rationale
created_revision_id
```

Wichtige Werte:

### `placement_role`
- `primary`
- `supporting`
- `reference`

### `placement_status`
- `proposed`
- `accepted`
- `superseded`

Für die kanonische 3.2-Endfassung werden **112 akzeptierte Haupttextplatzierungen** erwartet.

## 9.3 `section_lineage`

Die Neugliederung wird über eine eigene Lineage-Schicht dokumentiert.

Kernfelder:

```text
section_lineage_id
source_section_id
target_section_id
lineage_type
note
created_revision_id
```

`lineage_type`:

- `retained`
- `merged_into`
- `split_into`
- `superseded_by`
- `synthesized_from`

Der 3.3-Chat darf **keine neue Parallelstruktur** erfinden, wenn `main_text_object_placements` und `section_lineage` bereits existieren.

---

# 10. Zentrale Repository-Tabellen, die 3.3 verwenden muss

## 10.1 Abschnitts- und Versionsstruktur

### `dissertation_sections`

Relevante Felder:

```text
section_id
parent_section_id
section_code
title
chapter_number
section_order
status
is_original_contribution
notes
created_at
updated_at
```

### `section_versions`

Relevante Felder:

```text
section_version_id
section_id
revision_id
version_kind
body_markdown
checksum_sha256
notes
```

Für 3.2 müssen nach erfolgreichem V2-Gate acht `final`-Versionen existieren.

Für 3.3 ist bei jedem Abschnitt wieder die Trennung zwischen:

- `draft`,
- `rewrite`,
- `review`,
- `final`,
- beziehungsweise dem tatsächlich im Schema vorhandenen `version_kind`

zu beachten.

## 10.2 Revisionsstruktur

### `repository_revisions`

Relevante Felder:

```text
revision_id
revision_code
revision_date
scope_type
scope_reference
version_label
summary
created_by
parent_revision_id
```

Jede 3.3-Migration muss einen stabilen Revisionsanker besitzen und auf dem **verifizierten Ende-3.2-Revisionsstand** aufbauen.

## 10.3 Definitionskandidaten

### `definition_candidates`

Relevante Felder:

```text
definition_candidate_id
document_id
section_id
source_definition_number
proposed_definition_number
title
source_text
proposed_text
formal_latex
word_latex
provenance
candidate_status
notes
created_revision_id
```

Wichtig:

- `source_definition_number` bleibt Provenienz.
- `proposed_definition_number` ist die neue sichtbare Nummer.
- `source_text` darf nicht zerstört werden.
- neue Eigenleistungen müssen in `provenance` und im Text eindeutig als solche kenntlich sein.

## 10.4 Gleichungskandidaten

### `equation_candidates`

Relevante Felder:

```text
equation_candidate_id
document_id
section_id
source_equation_number
proposed_equation_number
source_line_no
number_origin
source_latex
source_word_latex
proposed_latex
word_latex
plain_description
equation_type
provenance
source_integrity_status
candidate_status
notes
created_revision_id
```

Besonders wichtig:

- `source_equation_number` niemals überschreiben,
- `source_latex` niemals als neue Formulierung missbrauchen,
- Korrekturen nur in `proposed_latex`,
- jede sichtbare neue Gleichung benötigt `word_latex`,
- beschädigte Quellen müssen über `source_integrity_status` und Revisionsnotiz nachvollziehbar bleiben.

## 10.5 Satzkandidaten

### `statement_candidates`

Relevante Felder:

```text
statement_candidate_id
document_id
section_id
statement_kind
source_heading
proposed_statement_number
title
source_text
proposed_text
formal_latex
word_latex
provenance
classification_status
notes
created_revision_id
```

`statement_kind` kann u. a. enthalten:

- theorem
- lemma
- corollary
- proposition
- criterion
- inequality
- theorem_reference
- procedure_theorem
- other

## 10.6 Mathematische Objektprofile

### `mathematical_object_profiles`

Die in Kapitel 3.2 eingeführten kanonischen Klassifikationsfelder bleiben auch für 3.3 bindend.

### `document_location`
- `main_text`
- `appendix`

### `importance_level`
- `core`
- `supporting`
- `derivation`
- `example`

### `equation_role`
- `canonical`
- `derived`
- `proof_step`
- `example`

Zusätzliche relevante Felder:

```text
appendix_module_id
appendix_anchor
classification_reason
classification_status
created_revision_id
```

Harte Regel:

> Ein Objekt darf nicht nur deshalb im Haupttext bleiben, weil es mathematisch interessant ist. Es muss für den argumentativen oder downstream benötigten Theoriepfad tatsächlich erforderlich sein.

## 10.7 Downstream-Abhängigkeiten

### `object_section_requirements`

Relevante Felder:

```text
requirement_id
repo_object_id
required_for_section_code
required_for_section_id
requirement_type
rationale
created_revision_id
```

Für viele 3.2-Objekte ist derzeit noch grob:

`required_for_section_code = '3.3'`

eingetragen.

**Diese grobe Zuordnung muss während der 3.3-Neufassung auf konkrete 3.3.x-Ziele verfeinert werden, sobald die endgültige 3.3-Struktur feststeht.**

Dies ist kein optionales Nice-to-have, sondern eine ausdrücklich aus 3.2 weitergereichte Repository-Aufgabe.

---

# 11. Weitere Repository-Tabellen, die nicht ignoriert werden dürfen

Je nach Inhalt des 3.3-Abschnitts sind insbesondere zu prüfen:

```text
sources
source_authors
source_usage
source_usage_audit
source_research_evidence
source_research_registry
source_relations
source_topics
repository_objects
repository_validation_results
section_change_log
revision_issues
repository_counters
symbols
equations
definitions
axioms
theorems
lemmas
propositions
model_assumptions
bridges
interpretations
```

Falls die aktuellste Ende-3.2-Datenbank zusätzliche, spezifisch für 3.3 angelegte Tabellen enthält, hat das aktuelle Schema Vorrang.

**Niemals Spalten oder Tabellen aus früheren Chats erraten. Vor jedem SQL-Skript reale DDL prüfen.**

---

# 12. Literatur- und Evidenzregeln für 3.3

## 12.1 Keine Weblinks im Dissertationsfließtext

Im Fließtext dürfen keine URLs oder Weblinks erscheinen.

## 12.2 Literaturformat im Haupttext

Im Haupttext wird eine Quelle bei wissenschaftlicher Verwendung als genaue bibliografische Quelle in Klammern angegeben, z. B. sinngemäß:

`([Autor, Verlag, Jahr, genaue Textstelle, Werk/Edition])`

Die konkrete Repository-Literaturziffer bleibt technisch in der DB erhalten.

## 12.3 Keine bloße Literaturnummer als Beleg

Nicht ausreichend:

`[74]`

wenn im Fließtext die genaue bibliografische Quellenangabe verlangt ist.

## 12.4 Repository-Evidenz

Eine Quelle darf nur dann als wissenschaftliche Stütze verwendet werden, wenn sie in der aktuellen Repository-/Evidenzstruktur nachvollziehbar ist.

Insbesondere prüfen:

```text
sources
source_usage
source_research_evidence
source_research_registry
```

Bei Deep-Research-Belegen müssen:

- Quelle,
- verwendete Aussage,
- genaue Textstelle,
- Belegart,
- Grenzen der Übernahme

nachvollziehbar sein.

## 12.5 Eigenleistung versus Literatur

Literatur belegt etablierte Mathematik, Logik, Modelltheorie oder wissenschaftlichen Kontext.

FRZK-spezifische Definitionen, Axiome, Klassifikationen, Schlussketten oder Architekturentscheidungen dürfen **nicht nachträglich wie Literaturwissen erscheinen**, wenn sie originäre Eigenleistung sind.

---

# 13. Schreibstil – verbindlich für den gesamten 3.3-Chat

## 13.1 Grundstil

- wissenschaftlich,
- persönlich geführt,
- Ich-Form,
- logisch zusammenhängende Absätze,
- keine Kette kurzer Einzelsätze,
- keine unnötige Selbstinszenierung,
- keine rhetorische Überhöhung,
- keine bloße Stichpunktprosa im Dissertationstext.

Der Text soll den Denkweg sichtbar machen:

```text
Problem
→ benötigte Struktur
→ mathematische/formale Festlegung
→ daraus zulässige Folgerung
→ Grenze der Folgerung
→ nächster notwendiger Schritt
```

## 13.2 Ich-Form

Die Ich-Form ist ausdrücklich erwünscht, z. B.:

- „Ich unterscheide …“
- „Ich führe … ein …“
- „Für den folgenden Schritt benötige ich …“
- „Aus dieser Definition folgt …“
- „Damit ist jedoch noch nicht bestimmt …“

Nicht erwünscht ist eine künstlich unpersönliche Dauerpassivform.

## 13.3 Eigenleistung

Originäre FRZK-Beiträge sind im Text eindeutig zu markieren, z. B.:

**Originäre Eigenleistung dieser Arbeit.**

Aber nicht jeder Satz darf damit beginnen. Die Kennzeichnung muss gezielt dort stehen, wo tatsächlich eine neue FRZK-spezifische Setzung, Definition, Klassifikation oder Schlussarchitektur eingeführt wird.

---

# 14. Formel- und Word-LaTeX-Regeln

## 14.1 Formeln im Fließtext

Mathematische Symbole und Formelbestandteile im Fließtext werden **nicht gerendert**, sondern in runden Klammern als Word-LaTeX ausgegeben.

Beispiele:

`(\mathbb T:\mathbb V\rightarrow\mathbb W)`

`(\ker(\mathbb T))`

`(\sigma(\mathbb T))`

`(\mathcal A_{\mathrm U})`

## 14.2 Eigenständige Gleichungen

Jede sichtbare Gleichung wird gerendert und erhält unmittelbar danach:

`Word-LaTeX: ...`

Beispiel:

```text
[gerenderte Gleichung]
(3.81)

Word-LaTeX: ...
```

## 14.3 Keine verlorene Synchronität

Bei jeder Änderung einer Formel müssen gleichzeitig geprüft beziehungsweise aktualisiert werden:

- sichtbare Formel,
- `proposed_latex`,
- `word_latex`,
- Beschreibung,
- Gleichungsnummer,
- Repository-Objekt,
- Abhängigkeiten,
- Literatur-/Eigenleistungsstatus.

---

# 15. SQL- und Repository-Regeln – zwingend für alle 3.3-Skripte

## 15.1 Ausgabeform

Vollständige Kapitel-/Abschnittstexte erscheinen **direkt im Chat**.

SQL-/Repository-Skripte erscheinen **nicht vollständig im Chat**, sondern ausschließlich als Download-Datei.

## 15.2 Collation

Verbindlich:

`utf8mb4_unicode_ci`

## 15.3 Verbotenes Gate-Muster

Nicht verwenden:

```sql
WHERE gate_status COLLATE utf8mb4_unicode_ci
      <> _utf8mb4'PASS' COLLATE utf8mb4_unicode_ci
```

Stattdessen parser-/collation-sicher:

```sql
WHERE HEX(gate_status) <> '50415353'
```

## 15.4 Keine Duplicate-Key-Assertions

Es dürfen keine absichtlich erzeugten `#1062`-Fehler als Gate-Technik benutzt werden.

Gates sollen lesbar Ergebnisse wie:

```text
PASS
FAIL
expected
actual
message
```

liefern.

## 15.5 Keine problematischen `UNION ALL`-Sammelinserts

Für Validierungen, Quellenverwendungen und Change-Logs keine großen `UNION ALL`-Ketten verwenden.

MariaDB hat im Projekt bereits mit:

`#1271 Unerlaubte Mischung von Sortierreihenfolgen für Operation 'UNION'`

reagiert.

Deshalb bevorzugt:

```sql
INSERT ... SELECT ...;
INSERT ... SELECT ...;
INSERT ... SELECT ...;
```

## 15.6 MEMORY + TEXT/BLOB verboten

Temporäre Tabellen mit `TEXT` oder `BLOB` müssen `ENGINE=InnoDB` verwenden.

Nicht:

```sql
ENGINE=MEMORY
```

wenn eine `TEXT`-/`BLOB`-Spalte vorhanden ist.

## 15.7 Keine erfundenen Spalten

Vor jedem Skript DDL des aktuellen Enddumps prüfen.

Bekannter früherer Fehler:

`appendix_object_placements` besitzt **kein** `appendix_module_id`.

Der Modulbezug läuft über:

```text
appendix_object_placements
→ appendix_sections
→ appendix_modules
```

## 15.8 Keine falschen Live-Ausführungsbehauptungen

Wenn kein MariaDB-Server tatsächlich verbunden ist, darf nicht behauptet werden, ein Skript sei „gegen die DB ausgeführt“ worden.

Zulässig ist:

- statische DDL-/DML-Prüfung,
- Parserprüfung,
- Abgleich gegen Dump,
- Generierung eines Testskripts.

Eine echte PASS-Aussage setzt reale Ausführung voraus.

---

# 16. Revisionskette des neuen 3.2-Haupttexts

Die folgenden Revisionsanker gehören zum Neuaufbau und müssen in der aktuellen DB vorhanden beziehungsweise nachvollziehbar sein:

```text
RKB32-REWRITE-3.2.0-2026-09-02
RKB32-REWRITE-3.2.1-2026-09-02
RKB32-REWRITE-3.2.2-2026-09-02
RKB32-REWRITE-3.2.3-2026-09-02
RKB32-REWRITE-3.2.4-2026-09-04
RKB32-REWRITE-3.2.5-2026-09-04
RKB32-REWRITE-3.2.6-2026-09-04
RKB32-REWRITE-3.2.7-2026-09-04
```

Erste technische Abschlussrevision:

```text
RKB32-FINAL-GATE-3.2-TO-3.3-2026-09-04
```

Diese erste Gate-Revision ist **kein erfolgreicher Abschlussnachweis**, weil der reale 16:47-Dump noch Post-Gate-Fails enthält.

Korrigierte Abschlussrevision:

```text
RKB32-FINAL-GATE-3.2-TO-3.3-2026-09-04-V2
```

Diese V2-Revision ist der vorgesehene Freigabeanker.

---

# 17. Enddump-Prozess Ende 3.2

Nach erfolgreichem V2-Gate muss ein neuer Dump erzeugt werden.

Zielname:

`frzk_rkb_stand_ende_3.2.sql`

Empfohlene Reihenfolge:

1. V2-Gate ausführen.
2. Letzte Result-Zeile prüfen:
   `FINAL_3.2_TO_3.3_PASS`
3. Dump erzeugen.
4. SHA-256 erzeugen.
5. Dump in eine Testdatenbank reimportieren.
6. Enddump-Verifikationsskript gegen den Reimport ausführen.
7. Ergebnis muss lauten:
   `ENDDUMP_3.2_VERIFIED`
8. Erst dieser verifizierte Dump wird als **kanonische Start-DB für Kapitel 3.3** verwendet.

Der 3.3-Chat muss den SHA-256 des tatsächlich verwendeten Enddumps in seiner eigenen Übergabe beziehungsweise Startmatrix dokumentieren.

---

# 18. Konkrete Übergabestelle aus 3.2.7 nach 3.3

Der argumentative Abschluss von 3.2 lautet sinngemäß:

> Die etablierten mathematischen Strukturen stehen bereit, ihre Voraussetzungen und Aussagegrenzen sind bestimmt. Was noch fehlt, ist die axiomatische Entscheidung darüber, welche dieser Strukturen das Funktionale Raum-Zeit-Kohärenzsystem tatsächlich tragen sollen.

Die explizite Übergabestelle lautet:

**Übergabestelle 3.2.7 → 3.3 – Von der verfügbaren Mathematik zur axiomatischen Auswahl des FRZK**

Kapitel 3.3 darf deshalb nicht mit einer neuen allgemeinen Mathematikeinführung beginnen.

Der Start von 3.3 muss stattdessen unmittelbar klären:

- Welche wissenschaftliche Lücke soll geschlossen werden?
- Welche primitiven FRZK-Begriffe sind erforderlich?
- Welche mathematischen Strukturen aus 3.2 werden lediglich verwendet?
- Welche Aussagen sind definitorisch?
- Welche sind mathematisch abgeleitet?
- Wo ist eine originäre Primärsetzung unvermeidbar?
- Welche stärkeren Aussagen gehören nur in Modellklassen?
- Welche Aussagen benötigen Brückenstrukturen?
- Welche Aussagen sind Interpretation?

---

# 19. Der bestehende 3.3-Bestand ist Quellmaterial, kein unkritisch zu übernehmender Endstand

Es existiert bereits eine umfangreiche historische beziehungsweise zuvor erarbeitete 3.3-Fassung.

Sie enthält unter anderem:

- sechs Forschungsbereiche F1–F6,
- eine ausgearbeitete universelle FRZK-Axiomatik,
- Primäraxiom `PA 3.3.1`,
- eine Erweiterungstaxonomie,
- Modellbedingungen,
- Brückenstrukturen,
- Interpretationsebenen,
- metatheoretische Kontrollstrukturen,
- einen formalen Abschlussapparat.

Diese Fassung darf als **inhaltliche Quelle und Provenienz** verwendet werden.

Sie darf aber nicht ungeprüft in die neue 3.3-Fassung kopiert werden, weil:

1. Kapitel 3.2 inzwischen vollständig neu nummeriert und strukturiert ist.
2. downstream requirements aus 3.2 neu auf konkrete 3.3.x-Ziele aufgelöst werden müssen.
3. ältere 3.3-Gleichungsnummern nicht zur neuen globalen Gleichungsnummerierung passen.
4. bekannte logische/klassifikatorische Konflikte aus früheren 3.3-Arbeiten berücksichtigt werden müssen.
5. die neue 3.3-Fassung wieder vollständig gegen den tatsächlichen Ende-3.2-Dump aufgebaut werden soll.

---

# 20. Bekannte inhaltliche Struktur der bisherigen 3.3-Fassung – als Startreferenz

## 20.1 Sechs Forschungsbereiche

Die bisherige 3.3-Architektur unterscheidet:

| Forschungsbereich | Kernfrage / Funktion |
|---|---|
| F1 | funktionale Unterscheidbarkeit |
| F2 | Relationierbarkeit |
| F3 | Transformation und Entwicklung |
| F4 | Organisation und Kohärenz |
| F5 | Raum, Zeit und physikalische Rekonstruktion |
| F6 | Geltungsbereich und wissenschaftliche Kontrolle |

Im bisherigen Abschlussmodell lautet der Status sinngemäß:

- F1: durch genau `PA 3.3.1` geschlossen,
- F2: direkt rekonstruiert,
- F3: universelle Grundstruktur + Modellbedingungen,
- F4: universelle Grundstruktur + Modellbedingungen,
- F5: mathematische Vorstrukturen + Brücken,
- F6: metatheoretisch geschlossen.

Diese Struktur ist eine **wichtige Referenz**, muss aber in der neuen 3.3-Neufassung erneut gegen die Forschungsfragen und die neue mathematische Basis geprüft werden.

## 20.2 Primärkern

Der bisherige 3.3-Endstand vertritt:

`PA 3.3.1`

als einziges universelles Primäraxiom des Primärkerns.

Die bisherige Abschlussdarstellung fasst dies später als:

`\mathcal A_{\mathrm U}=\{\mathrm{PA}_1\}`

zusammen.

Für die neue 3.3-Fassung gilt:

> **Kein zusätzliches Primäraxiom darf allein deshalb eingeführt werden, weil eine gewünschte Struktur bequem wäre.**

Jede Primärsetzung benötigt eine nachgewiesene universelle Axiomenlücke.

---

# 21. Bekannte 3.3-Klassifikationsregeln, die bei der Neufassung erhalten beziehungsweise geprüft werden müssen

## 21.1 Vier elementare Erweiterungstypen

Die bestehende Definition 3.3.90 unterscheidet für einen **elementaren** Erweiterungsschritt genau vier Typen:

```text
def
model
bridge
primary
```

Bedeutung:

### `def`
definitorische beziehungsweise kanonisch konstruktive Erweiterung; kein zusätzlicher nichtdefinitorischer universeller Geltungsanspruch.

### `model`
zusätzliche Modellbedingung / Modellrestriktion; schränkt die Modellklasse ein, verändert aber den universellen Primärkern nicht.

### `bridge`
zusätzliche strukturvermittelnde Brücke; nicht Bestandteil des universellen Primärkerns.

### `primary`
neue, nicht ableitbare Aussage mit universellem Primäranspruch; verändert die Axiomatik.

## 21.2 Interpretation ist KEIN fünfter Erweiterungstyp

Interpretationen gehören nicht in die Liste:

```text
def / model / bridge / primary
```

Eine Interpretation ordnet einer vorhandenen formalen Struktur eine physikalische, semantische oder sonstige Bedeutung zu.

Sie darf den formalen Status einer Aussage nicht rückwirkend verändern.

## 21.3 Elementare Erweiterung versus Statusprofil

Hier ist eine wichtige logische Unterscheidung beizubehalten:

- **Ein elementarer Erweiterungsschritt** besitzt genau **einen** Erweiterungstyp.
- **Ein Forschungsbereich oder komplexer Abschlussgegenstand** kann mehrere Statuskomponenten besitzen.

Diese beiden Aussagen widersprechen sich nicht, wenn komplexe Erweiterungsvorgänge in elementare Schritte zerlegt werden.

---

# 22. Bekannter Abschlussbegriff aus der bestehenden 3.3-Fassung

Die bisherige Definition 3.3.102 behandelt den **axiomatischen FRZK-Abschluss** über nichtleere Statusprofile.

Der aktuellere historische Stand verwendet sinngemäß die Komponenten:

```text
axiom
derived
conditional
bridge
metatheoretical
```

Dabei ist zu beachten:

- `axiom` ist nicht dasselbe Register wie der Erweiterungstyp `primary`, obwohl beide eng zusammenhängen.
- `derived` bezeichnet ableitbaren beziehungsweise kanonisch rekonstruierbaren Gehalt.
- `conditional` bezeichnet stärkere modellbedingte Aussagen.
- `bridge` bezeichnet brückenabhängigen Gehalt.
- `metatheoretical` bezeichnet übergeordnete Theorie-/Geltungskontrolle.
- Interpretation bleibt separat.

Die neue 3.3-Fassung muss diese Begriffe konsistent halten und darf die frühere Inkonsistenz zwischen „genau einem Status“ und „mehreren Statuskomponenten“ nicht wieder einführen.

---

# 23. Harte logische Kontrollfragen für jeden neuen 3.3-Abschnitt

Vor Freigabe eines Abschnitts muss geprüft werden:

## 23.1 Mathematik
- Ist jede verwendete mathematische Struktur bereits in 3.2 vorhanden?
- Wenn nein: warum wird sie in 3.3 neu eingeführt?
- Ist sie etablierte Mathematik oder FRZK-Eigenleistung?

## 23.2 Axiomatik
- Ist eine neue Aussage wirklich nicht definitorisch/ableitbar?
- Wird Universalität behauptet?
- Ist dafür tatsächlich ein Primäraxiom nötig?
- Gibt es ein Gegenmodell ohne diese Aussage?

## 23.3 Modellbedingungen
- Könnte die gewünschte stärkere Aussage stattdessen als Modellbedingung formuliert werden?
- Wird die Modellklasse dadurch sichtbar eingeschränkt?

## 23.4 Brücken
- Wird von einer formalen Struktur zu Raum, Zeit, Physik, Messung oder Bedeutung übergegangen?
- Wenn ja: ist eine explizite Brücke registriert?

## 23.5 Interpretation
- Wird nur Bedeutung zugeordnet?
- Wenn ja: darf diese Interpretation nicht wie ein mathematischer Satz formuliert werden.

## 23.6 Geltungsanspruch
- universal?
- modellbedingt?
- brückenabhängig?
- interpretativ?
- metatheoretisch?

---

# 24. Start der Gleichungs- und Definitionsnummerierung in 3.3

## 24.1 Gleichungen

3.2 endet bei:

`(3.80)`

Daher beginnt die kanonische Neufassung von 3.3 grundsätzlich mit:

`(3.81)`

Alte 3.3-Quellnummern bleiben in:

`source_equation_number`

oder einer äquivalenten Provenienzspalte erhalten.

## 24.2 Definitionen

3.3 besitzt einen eigenen Definitionsnummernraum.

Bei vollständiger Neufassung:

`Definition 3.3.1`

als erste sichtbare 3.3-Definition, sofern die final beschlossene Gliederung keine andere Nummerierungsregel festlegt.

## 24.3 Primäraxiome

Primäraxiome besitzen ihre eigene sichtbare Kennzeichnung, z. B.:

`PA 3.3.1`

Diese Nummerierung darf nicht mit Definitionen oder Gleichungen verwechselt werden.

---

# 25. Anforderungen an die 3.3-Startmatrix

Bevor Abschnitt 3.3.0 beziehungsweise 3.3.1 geschrieben wird, soll der neue Chat eine vollständige Startmatrix erzeugen.

Mindestens folgende Felder:

| Feld | Bedeutung |
|---|---|
| Zielabschnitt | konkrete 3.3.x-Position |
| Forschungsbereich | F1–F6 |
| wissenschaftliche Lücke | exakt zu schließende Frage |
| Ausgangsobjekt 3.2 | verwendete mathematische Voraussetzung |
| repo_object_id | kanonische Repository-ID |
| Placement | akzeptierte Haupttextplatzierung aus 3.2 |
| Requirement | bisherige downstream-Anforderung |
| neue 3.3.x-Zuordnung | konkrete Auflösung des Requirements |
| geplantes Objekt | Definition / Axiom / Proposition / Modellbedingung / Brücke / Interpretation / Metastruktur |
| Erweiterungstyp | def / model / bridge / primary |
| Statuskomponente | axiom / derived / conditional / bridge / metatheoretical |
| Geltungsrang | universal / modellbedingt / bridge / Interpretation |
| Eigenleistung | ja/nein + Begründung |
| Literaturbedarf | Quelle + genaue Belegstelle |
| Mathematikreferenz | 3.2-Definition/Gleichung/Anlage |
| geplante Gleichungsnummer | ab 3.81 fortlaufend |
| Provenienz | alte 3.3-Quelle / neu / adapted |
| Gate-Kriterium | maschinell oder inhaltlich prüfbare Abschlussbedingung |

---

# 26. Auflösung der groben `required_for_section_code='3.3'`-Einträge

Dies ist eine der wichtigsten technischen Aufgaben beim Start von 3.3.

Vorgehen:

1. Alle 3.2-Haupttextobjekte mit Requirement `3.3` abfragen.
2. Die finale 3.3-Zielgliederung festlegen.
3. Für jedes tatsächlich benötigte Objekt ein konkretes 3.3.x-Ziel bestimmen.
4. `required_for_section_id` setzen, sobald der Zielabschnitt existiert.
5. `required_for_section_code` auf konkrete Zielangabe bringen.
6. Nicht benötigte grobe Requirements nicht einfach löschen; mit Begründung supersedieren beziehungsweise revisionsgesichert anpassen.
7. Change Log schreiben.
8. Gate einführen:

```text
kein aktives 3.2-Haupttextobjekt mit ausschließlich unspezifischem 3.3-Requirement,
sofern sein konkreter Verbrauchspunkt in 3.3 bereits bekannt ist.
```

Issue 15 wurde für den Übergang 3.2 → 3.3 bewusst akzeptiert, weil diese Feinauflösung erst in der neuen 3.3-Struktur korrekt möglich ist.

---

# 27. Empfohlener Arbeitsmodus für Kapitel 3.3

Verbindliches „weiter / skript“-Verfahren:

## Benutzer sagt `weiter`

Dann:

- nächster vollständiger 3.3-Abschnitt,
- vollständig im normalen Chat,
- Fließtext,
- Ich-Form,
- alle Formeln korrekt,
- jede eigenständige Formel mit Word-LaTeX,
- Literatur im verlangten Format,
- Eigenleistung gekennzeichnet,
- Übergabestellen benannt.

## Benutzer sagt `skript`

Dann:

- passendes Repository-/SQL-Skript,
- ausschließlich als Download-Datei,
- gegen aktuellen Enddump/DDL prüfen,
- wenn möglich real testen; sonst Testgrenze transparent nennen,
- keine Skriptvollausgabe im Chat.

---

# 28. Übergabestellen müssen in 3.3 immer ausdrücklich benannt sein

Aus Kapitel 3.2 wurde als verbindliche Arbeitsregel bestätigt:

> **Übergabestellen müssen immer benannt sein.**

Das gilt auch für 3.3.

Beispiele:

```text
Übergabestelle 3.2.7 → 3.3.0 – Von der verfügbaren Mathematik zur axiomatischen Problemstellung
```

oder innerhalb 3.3:

```text
Übergabestelle 3.3.x → 3.3.y – Von ... zu ...
```

Bei Übergängen zwischen Ebenen zusätzlich explizit:

```text
Übergabestelle universeller Kern → Modellbedingung
Übergabestelle Modellstruktur → Brückenstruktur
Übergabestelle Brücke → Interpretation
```

---

# 29. Was der neue 3.3-Chat NICHT tun darf

- Kapitel 3.2 neu schreiben.
- M1–M6 neu aufbauen, sofern keine echte Integritätskorrektur erforderlich ist.
- mathematische Grundlagen erneut breit erklären.
- alte 3.3-Gleichungsnummern ungeprüft weiterverwenden.
- `repository_objects.section_id` erneut als Zielplatzierung missbrauchen.
- Quellpayload überschreiben.
- source numbers löschen.
- eine Modellbedingung als universelles Axiom deklarieren, nur weil sie benötigt wird.
- eine Brücke als mathematische Folgerung ausgeben.
- Interpretation als fünften Erweiterungstyp führen.
- aus Orthogonalität physikalische Unabhängigkeit folgern.
- aus Eigenwerten unmittelbar Energie/Frequenz/Stabilität ableiten.
- aus Vektorraumdimension physikalische Raumdimension ableiten.
- aus mathematischer Invertierbarkeit physikalische Zeitumkehrbarkeit ableiten.
- aus Hilbertraumstruktur ohne Setzung einen FRZK-Zustandsraum machen.
- neue Mathematik ohne Literatur und ohne klare FRZK-Eigenleistungsabgrenzung einführen.
- im Fließtext Weblinks ausgeben.
- SQL im Chat vollständig abdrucken.
- behaupten, ein Skript sei live getestet, wenn keine MariaDB-Ausführung stattgefunden hat.

---

# 30. Bekannte technische Anti-Patterns aus Kapitel 3.2

Diese Fehler dürfen in 3.3 nicht wiederholt werden:

## 30.1 `#1163`
MEMORY-Tabelle mit TEXT/BLOB.

**Lösung:** `ENGINE=InnoDB`.

## 30.2 `#1271`
gemischte Collations in `UNION ALL`.

**Lösung:** separate Inserts.

## 30.3 `#1267`
Collation-Mix in Vergleichen.

**Lösung:** keine unnötigen `COLLATE`-Konstruktionen; Gate-Status mit `HEX()` prüfen.

## 30.4 `#1062`
absichtlich erzeugter Duplicate-Key-Fehler als Assertion.

**Lösung:** lesbare Gate-Tabelle mit PASS/FAIL.

## 30.5 erfundene Spalten
z. B. falsches `appendix_module_id` in `appendix_object_placements`.

**Lösung:** DDL vor jedem Skript prüfen.

## 30.6 Verlust der Provenienz
Umschreiben von `repository_objects.section_id` auf den neuen Zielabschnitt.

**Lösung:** Herkunft in `section_id`, Zielplatzierung in `main_text_object_placements`.

---

# 31. Verbindliche Abschlussbedingungen für jeden 3.3-Abschnitt

Ein Abschnitt darf nicht als fertig gelten, solange nicht geprüft wurde:

- Text vollständig,
- wissenschaftlicher Stil,
- Ich-Form,
- Eigenleistungen markiert,
- Literatur vollständig und korrekt,
- alle Formeln mit Word-LaTeX,
- sichtbare Nummerierung korrekt,
- Provenienz erhalten,
- Requirements aktualisiert,
- Repository-Objekte registriert,
- Geltungsrang klassifiziert,
- keine Ebenenvermischung,
- lokale Gates PASS,
- Change Log vollständig,
- keine offenen critical issues aus diesem Abschnitt.

---

# 32. Mindest-Gate für den Start von 3.3.0 / 3.3.1

Vor dem ersten Inhaltsskript von 3.3 sollte ein Startgate mindestens prüfen:

```text
ENDDUMP Ende 3.2 verifiziert
Kapitel 3.2 final
3.2.0–3.2.7 final
M1–M6 final
27 Definitionen accepted
80 Gleichungen accepted
5 Satzobjekte accepted
112 Haupttextplatzierungen accepted
v_math_compression_gate vollständig PASS
keine offenen critical/high Issues aus Kapitel 3.2
section_lineage vorhanden
main_text_object_placements vorhanden
source_usage geprüft
alle verwendeten 3.2-Objekte mit Repository-ID auflösbar
```

Zusätzlich für 3.3:

```text
3.3-Zielgliederung festgelegt
F1–F6-Zuordnung geprüft
3.2→3.3 requirement map erzeugt
neue Gleichungszählung ab (3.81) reserviert
Eigenleistungs-/Geltungsregister vorbereitet
```

---

# 33. Empfohlene initiale SQL-Abfragen für den neuen 3.3-Chat

## 33.1 Aktuellen Endstand prüfen

```sql
SELECT *
FROM repository_counters
ORDER BY counter_key;
```

Gesucht werden nach erfolgreichem V2 insbesondere Werte sinngemäß:

```text
chapter_3_2_status = final
chapter_3_2_gate = PASS
last_completed_section = 3.2.7
current_section = 3.3
```

## 33.2 3.2-Haupttextobjekte nach Zielabschnitt

```sql
SELECT
    ds.section_code,
    p.placement_order,
    p.placement_role,
    ro.repo_object_id,
    ro.object_type,
    ro.object_label,
    ro.object_title,
    p.source_section_code
FROM main_text_object_placements p
JOIN repository_objects ro
  ON ro.repo_object_id=p.repo_object_id
JOIN dissertation_sections ds
  ON ds.section_id=p.target_section_id
WHERE p.placement_status='accepted'
  AND ds.section_code IN
  ('3.2.0','3.2.1','3.2.2','3.2.3','3.2.4','3.2.5','3.2.6','3.2.7')
ORDER BY ds.section_order,p.placement_order;
```

## 33.3 Grobe 3.3-Requirements

```sql
SELECT
    r.requirement_id,
    r.repo_object_id,
    ro.object_type,
    ro.object_label,
    ro.object_title,
    r.required_for_section_code,
    r.required_for_section_id,
    r.requirement_type,
    r.rationale
FROM object_section_requirements r
JOIN repository_objects ro
  ON ro.repo_object_id=r.repo_object_id
WHERE r.required_for_section_code LIKE '3.3%'
ORDER BY r.repo_object_id,r.requirement_id;
```

Diese Liste ist die technische Ausgangsmatrix für die 3.3.x-Zuordnung.

## 33.4 Literatur aus 3.2, die in 3.3 erneut benötigt werden könnte

```sql
SELECT
    ds.section_code,
    s.citation_number,
    s.title,
    su.usage_type,
    su.claim_summary,
    su.exact_location,
    su.citation_checked
FROM source_usage su
JOIN dissertation_sections ds
  ON ds.section_id=su.section_id
JOIN sources s
  ON s.source_id=su.source_id
WHERE ds.section_code LIKE '3.2%'
ORDER BY ds.section_order,s.citation_number;
```

Nicht automatisch in 3.3 übernehmen; nur bei konkreter Aussage erneut registrieren.

---

# 34. Kernliteratur aus dem neuen 3.2-Stand

Für die mathematischen Grundlagen wurden insbesondere verwendet:

- Serge Lang – Algebra
- Gilbert Strang – Introduction to Linear Algebra
- Paul R. Halmos – Finite-Dimensional Vector Spaces
- Paul R. Halmos – Naive Set Theory
- Herbert B. Enderton – Elements of Set Theory
- Michael Reed / Barry Simon – Methods of Modern Mathematical Physics, Vol. I
- Erwin Kreyszig – Introductory Functional Analysis with Applications
- Stephen H. Friedberg / Arnold J. Insel / Lawrence E. Spence – Linear Algebra
- weitere im Repository registrierte Grundlagenquellen

Kapitel 3.3 darf diese Quellen für etablierte Mathematik erneut verwenden, wenn eine konkrete Aussage dies benötigt.

Für Axiomatik, Modelltheorie, formale Semantik, Theorieerweiterungen und wissenschaftstheoretische Abgrenzungen muss der 3.3-Chat zusätzlich seine spezifische Literaturbasis prüfen.

---

# 35. Selbständige Startanweisung, die in einen neuen 3.3-Chat kopiert werden kann

> **Arbeite ausschließlich an Kapitel 3.3 „Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems“. Lade zuerst den neuesten verifizierten Enddump Ende 3.2 und prüfe das Gate 3.2→3.3. Kapitel 3.2 ist mathematisch vollständig: 3.2.0–3.2.7, 27 Definitionen, 80 Gleichungen (3.1)–(3.80), fünf kanonische Satz-/Kriteriumsobjekte sowie die finalen Anlagen M1–M6 mit 144 ausgelagerten Objekten und 133 Anlagengleichungen. Die erste neue 3.3-Gleichung beginnt grundsätzlich bei (3.81). Verwende `repository_objects.section_id` als Quellprovenienz und `main_text_object_placements` für Zielplatzierungen. Löse die aus 3.2 übernommenen `required_for_section_code='3.3'`-Einträge während der 3.3-Neufassung auf konkrete 3.3.x-Ziele auf.**
>
> **Schreibe wissenschaftlich, in persönlicher Ich-Form und in zusammenhängenden Absätzen. Vollständige Abschnittstexte erscheinen direkt im Chat; SQL-Skripte ausschließlich als Download. Mathematische Symbole im Fließtext stehen als Word-LaTeX in runden Klammern. Jede eigenständige Gleichung erhält unmittelbar danach eine `Word-LaTeX:`-Zeile. Keine Weblinks im Fließtext. Literatur mit genauer bibliografischer Angabe; Eigenleistung ausdrücklich kennzeichnen.**
>
> **Trenne strikt: etablierte Mathematik / Definition / Ableitung / Primäraxiom / Modellbedingung / Brücke / Interpretation / Metatheorie. Übernimm aus 3.2 keine physikalische Semantik. Ein Vektorraum ist noch kein physikalischer Raum, ein Operator noch kein Naturgesetz, ein Eigenwert noch keine physikalische Größe, ein Skalarprodukt noch keine physikalische Metrik und ein Hilbertraum noch kein FRZK-Zustandsraum.**
>
> **Nutze die bestehende 3.3-Fassung nur als Quell- und Provenienzmaterial. Prüfe insbesondere die sechs Forschungsbereiche F1–F6, den Status von PA 3.3.1 als einzigem bisherigen universellen Primäraxiom, die vier elementaren Erweiterungstypen `def/model/bridge/primary`, die separate Interpretationsebene sowie die Abschlussstatus `axiom/derived/conditional/bridge/metatheoretical`. Ein elementarer Erweiterungsschritt besitzt genau einen Erweiterungstyp; ein Forschungsbereich kann dagegen ein mehrkomponentiges Statusprofil besitzen.**
>
> **Arbeite nach dem `weiter`/`skript`-Verfahren und benenne jede Übergabestelle ausdrücklich.**

---

# 36. Entscheidungspunkt für den ersten neuen 3.3-Schritt

Nach erfolgreichem Ende-3.2-Gate soll **nicht sofort blind 3.3.1 neu geschrieben werden**.

Der erste Schritt im neuen 3.3-Chat ist:

1. finalen Ende-3.2-Dump laden,
2. DDL und Revisionsstatus prüfen,
3. alte 3.3-Quellfassung laden,
4. sechs Forschungsbereiche und deren Zielstruktur prüfen,
5. 3.2→3.3-Requirement-Matrix erzeugen,
6. bestehende 3.3-Objekte nach `source/proposed` und Eigenleistungsstatus inventarisieren,
7. Gleichungsnummern ab (3.81) reservieren,
8. vollständige 3.3-Startmatrix erzeugen,
9. Gate 0 für den neuen 3.3-Aufbau durchführen,
10. erst danach mit dem ersten vollständigen Abschnitt beginnen.

---

# 37. Was am Ende des neuen 3.3-Kapitels wieder als Übergabe vorhanden sein muss

Kapitel 3.3 soll seinerseits erst abgeschlossen werden, wenn eine vollständige Übergabe 3.3 → 3.4 existiert mit:

- kanonischem Enddump Ende 3.3,
- vollständigem Revisionspfad,
- finaler Abschnittsgliederung,
- vollständigem Definition-/Axiom-/Satz-/Gleichungsinventar,
- Primärkern,
- Modellbedingungen,
- Brückenregister,
- Interpretationsregister,
- Geltungs-/Statusregister,
- Abhängigkeitsgraph,
- Forschungsbereichsabschluss F1–F6,
- offenen Rekonstruktionsräumen,
- konkreten downstream requirements für 3.4,
- allen PASS-Gates,
- SHA-256 des Enddumps.

---

# 38. Kurzfassung der unverhandelbaren Übergaberegeln

1. **3.2 ist Mathematik; 3.3 ist axiomatische Auswahl und Konstruktion.**
2. **Keine physikalische Bedeutung aus Mathematik hineinlesen.**
3. **3.2 endet bei Gleichung (3.80); neue 3.3-Gleichungen ab (3.81).**
4. **27 Definitionen, 80 Gleichungen, 5 Satzobjekte, 112 aktive Haupttextplatzierungen.**
5. **M1–M6 final: 144 ausgelagerte Objekte, 133 Gleichungen.**
6. **Quellprovenienz und Zielplatzierung getrennt halten.**
7. **Grobe 3.3-Requirements in 3.3 auf konkrete 3.3.x-Ziele auflösen.**
8. **PA 3.3.1 nicht durch weitere Primäraxiome erweitern, solange keine echte universelle Axiomenlücke nachgewiesen ist.**
9. **`def/model/bridge/primary` sind Erweiterungstypen; Interpretation ist separat.**
10. **Forschungsbereiche können mehrkomponentige Statusprofile besitzen.**
11. **Fließtext im Chat, SQL als Datei.**
12. **Ich-Form, zusammenhängende Absätze, Eigenleistung markieren.**
13. **Jede sichtbare Gleichung mit Word-LaTeX.**
14. **Keine Links im Dissertationsfließtext.**
15. **Keine SQL-Behauptung ohne reale Ausführung.**
16. **Keine erfundenen DB-Spalten.**
17. **Kein `UNION ALL`-Collation-Risiko, keine Duplicate-Key-Assertions, kein MEMORY+TEXT.**
18. **Kapitel 3.3 startet kanonisch erst nach `FINAL_3.2_TO_3.3_PASS` und verifiziertem Enddump.**

---

# 39. Dateiliste für die Übergabe an den neuen 3.3-Chat

Mindestens laden:

1. `frzk_rkb_stand_ende_3.2.sql`  
   **erst nach erfolgreichem V2-Gate erzeugen; dieser Dump ist führend**

2. `UEBERGABE_FRZK_Kapitel_3.2_zu_3.3_2026-09-04.md`  
   **diese Datei**

3. `3.3 Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems_V2.docx`

4. `Olaf_Schreibstil_Wissenschaft...md`

Empfohlen zusätzlich:

5. `3.2 Mathematische Grundlagen_V2.docx`  
   nur als ursprüngliche Quellprovenienz, nicht als neue Endfassung

6. finale Anlagen M1–M6, sofern Detailprüfung nötig ist

7. V2-Gate-Skript:
   `FRZK_3_2_GATE_3_2_ZU_3_3_V2_2026-09-04.sql`

8. Enddump-Verifikationsskript

---

# 40. Abschlussvermerk dieser Übergabe

Kapitel 3.2 hat seine Aufgabe erfüllt, wenn der V2-Gate-Lauf und der Enddump dies technisch bestätigen:

- Die mathematischen Werkzeuge sind definiert.
- Die Rechen- und Vertiefungsdetails sind in M1–M6 vollständig erhalten.
- Die Voraussetzungen der Strukturen sind kenntlich.
- Die Grenzen der mathematischen Aussagen sind benannt.
- Es wurde ausdrücklich **keine** FRZK-spezifische Physik aus der Mathematik erzwungen.
- Der nächste wissenschaftliche Schritt ist daher nicht mehr mathematische Grundlegung, sondern die **kontrollierte axiomatische Konstruktion**.

Die Übergabe von 3.2 zu 3.3 ist damit fachlich:

> **von der verfügbaren Mathematik zur axiomatischen Verantwortung der Theorie.**

Technisch ist sie erst dann vollständig eingefroren, wenn:

`FINAL_3.2_TO_3.3_PASS`

und anschließend:

`ENDDUMP_3.2_VERIFIED`

vorliegen.

Ab diesem Punkt ist der verifizierte Ende-3.2-Dump die einzige kanonische technische Basis für die Neufassung von Kapitel 3.3.
