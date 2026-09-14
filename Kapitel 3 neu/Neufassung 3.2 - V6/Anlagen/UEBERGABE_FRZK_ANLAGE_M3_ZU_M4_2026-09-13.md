# ÜBERGABE FRZK – Anlage M3 → Anlage M4

**Stand:** 2026-09-13  
**Projekt:** FRZK / Dissertation / Neuaufbau Kapitel 3.2  
**Übergabe:** mathematische Anlage M3 → mathematische Anlage M4  
**Ziel dieses Dokuments:** vollständige Arbeitsgrundlage für einen neuen Chat, der ausschließlich Anlage M4 neu aufbaut.

---

## 1. Verbindlicher Startpunkt des neuen Chats

Der neue Chat beginnt **nicht mit einer Überarbeitung von M3**, sondern ausschließlich mit dem Neuaufbau von **M4 – Rang, Kern, Bild und lineare Gleichungssysteme**.

Vor dem ersten M4-Inhalt muss technisch nachgewiesen sein:

`RKB32-M3M4-FINAL-GATE = passed`

Das zugehörige Gate-Skript lautet:

`FRZK_3_2_GATE_M3_ZU_M4_2026-09-13.sql`

Das spätere M4.0-Repository-Skript muss dieses Gate als zwingendes Vorgängergate abfragen. Ist es nicht `passed`, darf M4.0 nichts schreiben.

Wichtig: Der mathematische und textliche M3-Bestand ist vollständig erarbeitet. Ein **Runtime-PASS** der Datenbank wird in diesem Übergabedokument jedoch nicht fingiert. Maßgeblich ist ausschließlich das tatsächliche Ergebnis des Gate-Skripts in MariaDB.

---

## 2. Verbindliches Arbeitsverfahren im neuen Chat

Für M4 gilt dasselbe Verfahren wie für M1–M3:

- Der Benutzer schreibt **`weiter`**:
  - der nächste M4-Abschnitt wird vollständig als wissenschaftlicher Fließtext **direkt im Chat** ausgegeben;
  - keine Schreibblöcke;
  - keine SQL-Ausgabe im Chat;
  - Gleichungen werden fortlaufend innerhalb von M4 nummeriert;
  - jede dargestellte Gleichung erhält unmittelbar anschließend ihre `Word-LaTeX:`-Zeile.

- Der Benutzer schreibt **`skript`**:
  - für den zuletzt vollständig geschriebenen Abschnitt wird ein kumulatives Repository-SQL-Skript erzeugt;
  - das SQL-Skript wird **nur als Downloadlink** ausgegeben;
  - vor Ausgabe ist es statisch gegen das aktuelle Repository-Schema zu prüfen;
  - Gate- und Kollationsregeln sind einzuhalten.

- M4 beginnt mit **M4.0**.
- Die Gleichungsnummerierung beginnt in M4 neu bei **(M4.1)**.
- M3 endet endgültig bei **(M3.1625)**.
- Es gibt keine Fortsetzung mit `(M3.1626)`.

---

## 3. Verbindliche Schreibregeln

Für sämtliche M4-Texte gelten:

- durchgängige **Ich-Form**;
- persönlicher wissenschaftlicher Stil;
- zusammenhängender Fließtext;
- keine Häufung kurzer alleinstehender Sätze;
- mathematische Resultate werden nachvollziehbar hergeleitet;
- keine bloße Formelsammlung;
- keine Praxisanwendungen aus Kapitel 6 in die Anlage ziehen;
- keine Rückverweise auf alte/überholte Fassungen;
- keine Formulierungen wie „in einer früheren Version“, „Quellfassung“, „ausgelagert“ oder ähnliche Legacy-Rückverweise;
- Übergabestellen werden ausdrücklich benannt;
- eigene Ordnungs-, Strukturierungs- oder Ableitungsleistungen werden ausdrücklich mit **„Originäre Eigenleistung dieser Arbeit.“** beziehungsweise einer vollständigen entsprechenden Formulierung gekennzeichnet.

M4 ist eine mathematische Anlage. Sie entwickelt mathematische Voraussetzungen. Sie darf keine späteren FRZK-Theorieentscheidungen aus dem noch nicht endgültig erarbeiteten Haupttext 3.2 voraussetzen.

---

## 4. Gleichungen und Word-LaTeX – zwingende Regeln

Für **jede** eigenständig dargestellte Gleichung gilt:

1. sichtbare Gleichung mit Nummer `(M4.x)`;
2. unmittelbar darunter:
   `Word-LaTeX: ...`
3. die `Word-LaTeX:`-Zeile übernimmt **exakt** die lineare Darstellung der Gleichung;
4. `formal_latex` und `word_latex` müssen im Repository bytegenau identisch sein;
5. in `word_latex` darf niemals `\tag{...}` stehen;
6. geschweifte Klammern und Backslashes bleiben exakt erhalten;
7. Variablen/Formeln im normalen Fließtext werden nur als lineares Word-LaTeX in runden Klammern geschrieben.

Beispiel:

\[
\ker(T)=\{v\in V\mid T(v)=0_W\}
\]

Word-LaTeX: `\ker(T)=\{v\in V\mid T(v)=0_W\}`

Das Repository-Gate muss für alle M4-Gleichungen prüfen:

- lückenlose Nummerierung;
- `formal_latex = word_latex` bytegenau;
- keine `\tag`-Sequenz in `word_latex`;
- jede `Word-LaTeX:`-Zeile kommt im kanonischen Volltext vor.

---

## 5. Datenbank- und Repository-Grundlage

### 5.1 Arbeitsdatenbank

Kanonische Arbeitsdatenbank:

`frzk_rkb_32_neu`

Technische Umgebung:

- MariaDB 10.4.x / konkret im Projekt 10.4.32;
- phpMyAdmin;
- Windows/XAMPP;
- Kollation verbindlich:

```sql
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection='utf8mb4_unicode_ci';
```

### 5.2 Wichtige Repository-Tabellen

#### `repository_revisions`

Relevante Felder:

- `revision_id`
- `revision_code`
- `revision_date`
- `scope_type`
- `scope_reference`
- `version_label`
- `summary`
- `created_by`
- `parent_revision_id`

#### `appendix_modules`

Relevante Felder:

- `appendix_module_id`
- `appendix_code`
- `title`
- `purpose`
- `sort_order`
- `status`
- `created_revision_id`

Aktueller kanonischer M4-Moduleintrag:

- `appendix_code = 'M4'`
- Titel: **Rang, Kern, Bild und lineare Gleichungssysteme**
- Zweck:
  **Rang, Bild, Kern, Rang-Nullität, lineare Injektivität und Surjektivität sowie Lösbarkeit und vollständige Lösung linearer Gleichungssysteme.**
- `sort_order = 4`
- vor Beginn von M4 muss `status = 'planned'` sein.

#### `appendix_sections`

Relevante Felder:

- `appendix_section_id`
- `appendix_module_id`
- `parent_appendix_section_id`
- `section_code`
- `title`
- `sort_order`
- `status`
- `notes`
- `created_revision_id`

#### `appendix_section_versions`

Relevante Felder:

- `appendix_section_version_id`
- `appendix_section_id`
- `revision_id`
- `version_kind`
- `body_markdown`
- `checksum_sha256`
- `notes`

#### `appendix_objects`

Relevante Felder:

- `appendix_object_id`
- `appendix_section_id`
- `object_anchor`
- `object_type`
- `display_number`
- `title`
- `content_text`
- `formal_latex`
- `word_latex`
- `importance_level`
- `equation_role`
- `provenance`
- `source_id`
- `assumptions`
- `validation_status`
- `created_revision_id`

Zulässige `importance_level`:

- `core`
- `supporting`
- `derivation`
- `example`

Zulässige `equation_role`:

- `canonical`
- `derived`
- `proof_step`
- `example`

Für Nicht-Gleichungsobjekte muss `equation_role = NULL` sein.

Zulässige `provenance`:

- `literature`
- `adapted`
- `original`
- `mixed`

#### `appendix_source_usage`

Relevante Felder:

- `appendix_usage_id`
- `appendix_section_id`
- `source_id`
- `usage_type`
- `claim_summary`
- `exact_location`
- `is_first_mention`
- `citation_checked`
- `notes`
- `created_revision_id`

#### `repository_validation_results`

Relevante Felder:

- `validation_result_id`
- `revision_id`
- `validation_code`
- `validation_status`
- `expected_value`
- `actual_value`
- `validation_message`
- `checked_at`

---

## 6. Datenbankfelder, die tatsächlich existieren – und solche, die nur konzeptionell geplant sind

Im aktuell geprüften Repository-Schema existieren in `appendix_objects` tatsächlich:

- `importance_level`
- `equation_role`
- `provenance`
- `source_id`
- `assumptions`
- `validation_status`

Die projektweit gewünschten Kennzeichnungen

- `document_location`
- `required_for_section`

sind im derzeit geprüften Dump **keine direkten Spalten von `appendix_objects`**.

Daher gilt für den neuen Chat:

**Keine nicht vorhandenen Datenbankspalten erfinden.**

Wenn `document_location` oder `required_for_section` später technisch eingeführt werden sollen, ist dafür eine explizite Schema-Migration erforderlich. Bis dahin können entsprechende semantische Informationen nur in vorhandenen Feldern/Objekten/Notizen dokumentiert werden.

---

## 7. Technische SQL-Regeln

Alle M4-Skripte müssen:

- MariaDB-10.4-kompatibel sein;
- `utf8mb4_unicode_ci` verwenden;
- Hashwerte kollationssicher vergleichen;
- keine Gate-Bedingung abschwächen, nur damit ein PASS entsteht;
- keine vorhandenen Constraints entfernen oder lockern;
- `TEMPORARY TABLE` mit `TEXT`/`BLOB` immer mit `ENGINE=InnoDB` anlegen;
- bei `SIGNAL` nie direkt `SET MESSAGE_TEXT=CONCAT(...)` verwenden.

Stattdessen:

```sql
DECLARE v_message TEXT;
SET v_message = CONCAT(...);
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=v_message;
```

### Kollationssicherer SHA256-Vergleich

Erwarteter Hash:

```sql
SET @expected_hash := _ascii'<sha256>' COLLATE ascii_bin;
```

Vergleich:

```sql
BINARY @stored_hash = BINARY @expected_hash
```

Diagnoseausgabe:

```sql
CONVERT(@stored_hash USING utf8mb4) COLLATE utf8mb4_unicode_ci
```

---

## 8. M3 – vollständiger kanonischer Abschlussbestand

Anlage M3 trägt den Titel:

**Lineare Abbildungen, Matrixdarstellung, Basiswechsel und Determinante**

M3 umfasst exakt die Abschnitte M3.0 bis M3.11 und den Gleichungsbestand M3.1 bis M3.1625.

| Abschnitt | Titel | Gleichungsbereich | Anzahl |
|---|---|---:|---:|
| M3.0 | Gegenstand, Eingangsstelle und Aufbau | M3.1–M3.18 | 18 |
| M3.1 | Lineare Abbildungen und Linearitätsbedingungen | M3.19–M3.89 | 71 |
| M3.2 | Elementare Folgen der Linearität | M3.90–M3.198 | 109 |
| M3.3 | Identität, Komposition und inverse lineare Abbildungen | M3.199–M3.372 | 174 |
| M3.4 | Bestimmung linearer Abbildungen durch Basen | M3.373–M3.496 | 124 |
| M3.5 | Matrixdarstellung linearer Abbildungen | M3.497–M3.645 | 149 |
| M3.6 | Matrixoperationen und Komposition | M3.646–M3.839 | 194 |
| M3.7 | Basiswechsel und Koordinatentransformation | M3.840–M3.1013 | 174 |
| M3.8 | Endomorphismen, Darstellung in verschiedenen Basen und Ähnlichkeit | M3.1014–M3.1175 | 162 |
| M3.9 | Determinante | M3.1176–M3.1330 | 155 |
| M3.10 | Determinantenregeln und Invertierbarkeit | M3.1331–M3.1515 | 185 |
| M3.11 | Ergebnisbestand und Übergabe von M3 | M3.1516–M3.1625 | 110 |

Gesamt:

- 12 Abschnitte;
- 1625 Gleichungen;
- lückenlose Nummerierung M3.1–M3.1625.

---

## 9. Zentrale M3-Ergebnisse, die M4 übernehmen darf

M4 übernimmt diese Resultate **als bereits bewiesen**. Sie werden nicht neu hergeleitet, außer eine kurze Erinnerung ist für den Zusammenhang erforderlich.

### 9.1 Linearität

Für eine lineare Abbildung:

`T:V\rightarrow W`

gilt:

`T(\lambda u+\mu v)=\lambda T(u)+\mu T(v)`

Daraus stehen insbesondere Nullvektorverträglichkeit, additive Inversen und endliche Linearkombinationen zur Verfügung.

### 9.2 Bestimmung durch Basisbilder

Ist:

`\mathcal B=(b_1,\ldots,b_n)`

eine Basis von `(V)`, dann ist `(T)` durch:

`T(b_1),\ldots,T(b_n)`

eindeutig bestimmt.

### 9.3 Matrixdarstellung

Für Basen `(\mathcal B)` von `(V)` und `(\mathcal C)` von `(W)` steht:

`[T(v)]_{\mathcal C}=[T]_{\mathcal C\leftarrow\mathcal B}[v]_{\mathcal B}`

zur Verfügung.

Diese Beziehung wird in M4 entscheidend, weil Kern- und Bildfragen sowohl abstrakt für `(T)` als auch koordinatenbezogen für eine Matrix `(A)` formuliert werden können.

### 9.4 Komposition

Bei kompatiblen Basen gilt:

`[T\circ S]_{\mathcal C\leftarrow\mathcal A}=[T]_{\mathcal C\leftarrow\mathcal B}[S]_{\mathcal B\leftarrow\mathcal A}`

### 9.5 Invertierbarkeit

Invertierbarkeit wurde in M3 **vor** der Determinante definiert.

Für einen Automorphismus `(T)` existiert `(T^{-1})`.

Für eine invertierbare quadratische Matrix `(A)` existiert `(A^{-1})`.

### 9.6 Basiswechsel

Für zwei Basen desselben Vektorraums:

`[v]_{\mathcal B}=P_{\mathcal B\leftarrow\mathcal B'}[v]_{\mathcal B'}`

mit:

`P_{\mathcal B'\leftarrow\mathcal B}=P_{\mathcal B\leftarrow\mathcal B'}^{-1}`

### 9.7 Darstellungswechsel

Für eine lineare Abbildung:

`[T]_{\mathcal C'\leftarrow\mathcal B'}=P_{\mathcal C'\leftarrow\mathcal C}[T]_{\mathcal C\leftarrow\mathcal B}P_{\mathcal B\leftarrow\mathcal B'}`

### 9.8 Ähnlichkeit

Für Endomorphismen:

`A'=P^{-1}AP`

und:

`A\sim A'\Longleftrightarrow\exists P\in\operatorname{GL}_n(K):A'=P^{-1}AP`

Ähnlichkeit beschreibt verschiedene Matrixdarstellungen derselben Endomorphismenstruktur.

### 9.9 Determinante

Die Determinante ist in M3 vollständig eingeführt.

Verfügbar sind insbesondere:

`det:K^{n\times n}\rightarrow K`

Leibniz-Formel, elementare Zeilen-/Spaltenregeln, Transpositionsinvarianz und:

`det(AB)=det(A)det(B)`

sowie:

`det(A^{-1})=det(A)^{-1}`

### 9.10 Determinantenkriterium

Für quadratische Matrizen gilt bereits:

`A\ \mathrm{invertierbar}\Longleftrightarrow\det(A)\neq0_K`

und:

`A\ \mathrm{singulär}\Longleftrightarrow\det(A)=0_K`

M4 darf diese Äquivalenz verwenden.

M4 darf sie jedoch **nicht** zur Definition des Rangs machen.

---

## 10. Zentrale Objekt-Darstellungs-Trennung aus M3

Diese Trennung bleibt in M4 verbindlich.

Abstraktes Objekt:

`T:V\rightarrow W`

Darstellung:

`A=[T]_{\mathcal C\leftarrow\mathcal B}`

Kern, Bild und Rang müssen zunächst als Eigenschaften der linearen Abbildung verstanden werden.

Erst danach werden die Matrixbezüge formuliert:

- Matrixkern / Nullraum als Koordinatendarstellung von `ker(T)`;
- Spaltenraum als Koordinatendarstellung von `im(T)`;
- Matrixrang als Rang der dargestellten linearen Abbildung.

Ein Basiswechsel darf den abstrakten Rang nicht ändern.

Die neue M4-Theorie soll deshalb ausdrücklich zwischen

- **Objekt**
- **Koordinatendarstellung**
- **Berechnungsverfahren**

unterscheiden.

---

## 11. Verbindliche Eingangsstelle M3 → M4

M3 übergibt an M4:

1. lineare Abbildungen;
2. Matrixdarstellungen;
3. Koordinatenvektoren;
4. Komposition;
5. inverse Abbildungen und inverse Matrizen;
6. Basiswechsel;
7. Ähnlichkeit;
8. Determinante;
9. Determinantenkriterium der Invertierbarkeit.

M4 beginnt dort, wo M3 bewusst aufgehört hat:

- Kern;
- Bild;
- Rang;
- Rang-Nullität;
- Injektivität über den Kern;
- Surjektivität über das Bild;
- Zeilen- und Spaltenrang;
- elementare Zeilenoperationen;
- Gauß-Verfahren;
- homogene und inhomogene lineare Gleichungssysteme;
- Lösbarkeitsbedingungen;
- vollständige Lösungsmenge.

Die Übergaberichtung lautet:

`M3 \longrightarrow M4`

Nicht zulässig ist:

`M3 \longleftarrow M4`

M4 darf M3 nicht rückwirkend umdefinieren.

---

## 12. Empfohlene verbindliche Architektur von M4

Der neue Chat soll M4 in dieser Reihenfolge aufbauen.

### M4.0 Gegenstand, Eingangsstelle, Grenzen und Aufbau

Ziele:

- Übernahme aus M3 explizit benennen;
- keine neue M3-Theorie;
- M4-Gegenstand definieren;
- Grenzen zu M5 und M6 festlegen;
- Übergabekette innerhalb M4 festlegen;
- erster Gleichungsblock beginnt bei `(M4.1)`.

M4.0 muss als Repository-Guard zwingend prüfen:

`RKB32-M3M4-FINAL-GATE = passed`

### M4.1 Kern einer linearen Abbildung

Aufbau:

- Definition:

  `\ker(T)=\{v\in V\mid T(v)=0_W\}`

- Beweis, dass `ker(T)` Unterraum von `(V)` ist;
- Nullabbildung / Identität als Randfälle;
- Matrixform:

  `Ax=0`

- noch keine vollständige Theorie homogener LGS; diese wird später systematisch entwickelt.

### M4.2 Bild einer linearen Abbildung

Aufbau:

- Definition:

  `\operatorname{im}(T)=\{T(v)\mid v\in V\}`

- Beweis, dass `im(T)` Unterraum von `(W)` ist;
- Erzeugung des Bildes durch Bilder einer Basis;
- Matrixbezug:
  Bild = Spannraum der Spalten der Darstellungsmatrix.

### M4.3 Injektivität, Surjektivität und Bijektivität über Kern und Bild

Zentrale Resultate:

`T\ \mathrm{injektiv}\Longleftrightarrow\ker(T)=\{0_V\}`

`T\ \mathrm{surjektiv}\Longleftrightarrow\operatorname{im}(T)=W`

und Verbindung mit Isomorphie bei geeigneten Dimensionen.

### M4.4 Rang einer linearen Abbildung und Rang einer Matrix

Definition:

`\operatorname{rank}(T)=\dim(\operatorname{im}(T))`

Matrixrang als Rang der dargestellten linearen Abbildung.

Zu zeigen:

- Rang ist basisunabhängig;
- Rang bleibt unter invertierbaren Basiswechseln erhalten;
- für Darstellungsmatrizen desselben Operators ergibt sich derselbe Rang.

### M4.5 Nullität und Rang-Nullitätssatz

Definition:

`\operatorname{nullity}(T)=\dim(\ker(T))`

Zentrales Resultat für endlichdimensionales `(V)`:

`\dim(V)=\dim(\ker(T))+\dim(\operatorname{im}(T))`

beziehungsweise:

`\operatorname{nullity}(T)+\operatorname{rank}(T)=\dim(V)`

Dieser Satz ist einer der Hauptübergabepunkte innerhalb M4.

### M4.6 Zeilenraum, Spaltenraum und Gleichheit von Zeilen- und Spaltenrang

Systematisch unterscheiden:

- Spaltenraum;
- Zeilenraum;
- Pivotstruktur;
- Spaltenrang;
- Zeilenrang.

Zu zeigen beziehungsweise sauber herzuleiten:

`rowrank(A)=columnrank(A)=rank(A)`

Dabei darf der Beweis nicht lediglich als bekannte Behauptung stehen bleiben.

### M4.7 Elementare Zeilenoperationen und Zeilenstufenform

Einführen:

- Zeilentausch;
- Skalierung einer Zeile mit nichtverschwindendem Skalar;
- Addition eines Vielfachen einer Zeile zu einer anderen;
- Zeilenäquivalenz;
- Zeilenstufenform;
- reduzierte Zeilenstufenform, sofern für die spätere vollständige Lösung benötigt.

Wichtige Abgrenzung:

**Zeilenoperationen** transformieren ein Gleichungssystem äquivalent.

**Spaltenoperationen** dürfen bei `(Ax=b)` nicht unreflektiert wie Zeilenoperationen verwendet werden, weil sie die Unbekanntenstruktur verändern.

### M4.8 Gauß-Algorithmus als systematische Äquivalenztransformation

Der Gauß-Algorithmus soll nicht nur als Rechenrezept präsentiert werden.

Er ist als Folge invertierbarer elementarer Zeilenoperationen zu begründen.

Zu behandeln:

- Pivotwahl;
- Eliminationsschritte;
- Stufenform;
- Rückwärtseinsetzen;
- freie Variablen;
- Zusammenhang mit Rang.

### M4.9 Homogene lineare Gleichungssysteme

Grundform:

`Ax=0`

Zentrale Identifikation:

`\mathcal L_0=\ker(A)`

beziehungsweise als lineare Abbildung `(T_A)`:

`\mathcal L_0=\ker(T_A)`

Folgen:

- Lösungsmenge ist Unterraum;
- Dimension der Lösungsmenge entspricht der Nullität;
- nur triviale Lösung genau dann, wenn der Kern trivial ist;
- bei quadratischer Matrix Verbindung zu Invertierbarkeit und Determinante.

### M4.10 Inhomogene lineare Gleichungssysteme und Lösbarkeit

Grundform:

`Ax=b`

Einführen:

- erweiterte Matrix `[A\mid b]`;
- Konsistenz;
- Widerspruchszeilen;
- Rangbedingung.

Zentrales Kriterium:

`Ax=b\ \mathrm{lösbar}\Longleftrightarrow\operatorname{rank}(A)=\operatorname{rank}([A\mid b])`

Die Bezeichnung des Satzes kann als Rang-/Lösbarkeitskriterium beziehungsweise Rouché-Capelli/Kronecker-Capelli eingeordnet werden, sofern die verwendete Literaturstelle dies sauber unterstützt.

### M4.11 Vollständige Lösungsmenge und affine Struktur

Ist `(x_p)` eine spezielle Lösung von `(Ax=b)`, dann:

`\mathcal L=x_p+\ker(A)`

Zu zeigen:

- Differenz zweier Lösungen liegt im Kern;
- jede spezielle Lösung plus homogene Lösung ist wieder Lösung;
- eindeutige Lösung genau dann, wenn `ker(A)=\{0\}`;
- Freiheitsgrade = Nullität.

Für quadratische Matrizen kann anschließend die Verbindung aus M3 verwendet werden:

`rank(A)=n`
` \Longleftrightarrow `
`ker(A)=\{0\}`
` \Longleftrightarrow `
`A` invertierbar
` \Longleftrightarrow `
`det(A)\neq0_K`

Diese Kette wird erst hier vollständig aus M3 und M4 zusammengesetzt.

### M4.12 Ergebnisbestand und Übergabe von M4

M4.12 führt keine neue Theorie mehr ein.

Es konsolidiert:

- Kern;
- Bild;
- Injektivität;
- Surjektivität;
- Rang;
- Nullität;
- Rang-Nullität;
- Zeilen-/Spaltenrang;
- Gauß-Verfahren;
- homogene Systeme;
- inhomogene Systeme;
- Rang-Lösbarkeitskriterium;
- vollständige Lösung.

Explizite Übergaben:

- an M5:
  Kern/Rang von `(A-\lambda I)` als Voraussetzung für Eigenräume und geometrische Vielfachheit;
- an M6:
  Unterräume, Bild/Kern und lineare Projektionsstrukturen als algebraische Voraussetzung;
- an den späteren Haupttext 3.2:
  nur der tatsächlich benötigte geprüfte Ergebnisbestand.

---

## 13. Wichtige mathematische Grenzen von M4

M4 darf **nicht** systematisch entwickeln:

### Nicht M4 → M5

- Eigenwerte;
- Eigenvektoren;
- Eigenräume als Spektraltheorie;
- charakteristisches Polynom als Eigenwertinstrument;
- algebraische/geometrische Vielfachheit;
- Diagonalisierung;
- Spektralprojektoren;
- Matrixfunktionen.

Hinweis: M4 darf allgemein Kern und Rang von linearen Abbildungen entwickeln. Erst M5 setzt später speziell `(A-\lambda I)` ein.

### Nicht M4 → M6

- Skalarprodukte;
- induzierte Normen;
- Winkel;
- Orthogonalität;
- Gram-Schmidt;
- orthogonale Komplemente;
- orthogonale Projektion;
- selbstadjungierte Operatoren;
- Hilbertraumtheorie;
- Least-Squares als orthogonales Projektionsproblem.

### Nicht M4 → Haupttext 3.2

Keine FRZK-Anwendung und keine Theorieentscheidung des späteren Haupttexts vorwegnehmen.

---

## 14. Besonders wichtige mathematische Unterscheidungen für M4

### 14.1 Kern vs. Nullität

`ker(T)` ist ein Unterraum.

`nullity(T)` ist dessen Dimension.

Nicht gleichsetzen.

### 14.2 Bild vs. Rang

`im(T)` ist ein Unterraum.

`rank(T)` ist dessen Dimension.

Nicht gleichsetzen.

### 14.3 Matrixrang vs. konkrete Matrixeinträge

Der Rang ist eine Eigenschaft der dargestellten linearen Struktur und bleibt unter invertierbaren Basiswechseln invariant.

### 14.4 Homogen vs. inhomogen

Homogen:

`Ax=0`

Lösungsmenge ist ein Unterraum.

Inhomogen:

`Ax=b`

Lösungsmenge ist bei Lösbarkeit im Allgemeinen **kein Unterraum**, sondern eine affine Verschiebung des homogenen Lösungsraums.

### 14.5 Zeilenoperationen vs. Spaltenoperationen

Zeilenoperationen am erweiterten System liefern äquivalente Gleichungssysteme.

Spaltenoperationen verändern im Allgemeinen die Zuordnung der Unbekannten und dürfen nicht als gleichartige Systemoperation behandelt werden.

### 14.6 Rang und Determinante

Determinante ist nur für quadratische Matrizen definiert.

Rang gilt auch für rechteckige Matrizen.

Daher darf Rang **nicht** über die Determinante definiert werden.

Die Determinante aus M3 liefert lediglich für quadratische Matrizen ein zusätzliches Kriterium.

---

## 15. Literaturregeln für M4

Die Literaturzählung ist repositoryweit kanonisch, aber die **Erstnennung gilt innerhalb jeder einzelnen Anlage neu**.

Deshalb:

- Lang hat kanonische Literaturziffer `[[71]]`, `source_id = 50`, `source_key = 'lang_algebra_rev3_2002'`.
- Strang hat kanonische Literaturziffer `[[72]]`, `source_id = 51`, `source_key = 'strang_introduction_linear_algebra_5_2016'`.

Da M4 eine neue Anlage ist, dürfen Lang und Strang **bei ihrer ersten Verwendung in M4 nicht nur als `[[71]]` bzw. `[[72]]` erscheinen**.

Erste Nennung innerhalb M4:

`{[Author, Verlag, Jahr, Textstelle, Sonstiges]}[[Nr.]]`

Die Platzhalterklammern werden durch echte bibliografische Angaben ersetzt.

Weitere Nennungen innerhalb M4:

`[[71]]`

beziehungsweise:

`[[72]]`

Keine Weblinks im Fließtext.

Die bereits im Repository verifizierten Quellen lauten:

- Lang, Serge: *Algebra*. Revised Third Edition. New York: Springer, 2002. `[[71]]`
- Strang, Gilbert: *Introduction to Linear Algebra*. Fifth Edition. Wellesley, MA: Wellesley-Cambridge Press, 2016. `[[72]]`

Für M4 muss die tatsächlich verwendete Textstelle zu Kern/Bild/Rang/Gauß/LGS in `appendix_source_usage.exact_location` sachgerecht angegeben werden. Keine Textstelle erfinden; falls die vorhandenen Repository-Metadaten nicht ausreichen, zuerst Quelle prüfen oder eine andere bereits verifizierte Quelle wählen.

---

## 16. Repository-Klassifikation für M4

Empfohlene Zuordnung:

### Definition

Beispiel Kern:

- `object_type = 'definition'`
- `importance_level = 'core'`
- `equation_role = NULL`
- `provenance = 'adapted'` oder `literature`
- `source_id = 50/51` bei Literaturbezug

### Kanonische Gleichung

Beispiel Rang-Nullität:

- `object_type = 'equation'`
- `importance_level = 'core'`
- `equation_role = 'canonical'`
- `provenance = 'adapted'`

### Beweisschritt

- `importance_level = 'derivation'`
- `equation_role = 'proof_step'`

### Abgeleitete Beziehung

- `importance_level = 'supporting'`
- `equation_role = 'derived'`

### Rechenbeispiel

- `importance_level = 'example'`
- `equation_role = 'example'`
- bei selbst konstruiertem Beispiel:
  `provenance = 'original'`

### Methodische Eigenleistung / Übergabe / Grenze

- `object_type = 'statement'`
- `equation_role = NULL`
- `provenance = 'original'`

---

## 17. Verbindliche M4.0-Repository-Anforderungen

Das spätere M4.0-Skript muss mindestens prüfen:

1. `appendix_modules.appendix_code='M4'` existiert genau einmal;
2. M4 steht vor dem ersten Schreiben auf `planned`;
3. `RKB32-GATE-M3-M4-2026-09-13` existiert;
4. dazu:
   `RKB32-M3M4-FINAL-GATE = passed`;
5. M4.0 existiert noch nicht oder gehört exakt zur idempotent wiederholbaren gleichen Revision;
6. keine spätere M4-Sektion existiert bereits;
7. M3.11 und M3-Gesamtgate bleiben `passed`;
8. M4-Gleichungen beginnen mit `M4.1`;
9. M4.0 enthält explizit:
   - Eingang aus M3;
   - Grenze zu M5;
   - Grenze zu M6;
   - Übergabe an M4.1.

Erst nach bestandenem M4.0-Final-Gate darf M4.1 beginnen.

---

## 18. Gate-Struktur für alle M4-Abschnitte

Jeder Abschnitt M4.x benötigt ein eigenes Final-Gate.

Das folgende Schema ist verbindlich:

- Vorgänger-Final-Gate muss `passed` sein;
- Folgeabschnitt darf noch nicht existieren;
- Abschnitt genau einmal;
- genau eine kanonische `draft`-Version für die Revision;
- Body-SHA256 exakt;
- Gleichungsanzahl und Nummernbereich exakt;
- `formal_latex = word_latex` bytegenau;
- kein `\tag` in `word_latex`;
- jede Word-LaTeX-Zeile im Volltext;
- Literaturverwendungen geprüft;
- Struktur-/Definition-/Satz-/Übergabeobjekte vollständig;
- `equation_role`-Constraints eingehalten;
- Eigenleistungsmarker vorhanden, wenn im Text vorgesehen;
- Grenzmarker vorhanden;
- explizite Übergabe an Folgeabschnitt vorhanden;
- Final-Gate erst aus allen Einzelvalidierungen berechnen.

---

## 19. Bekannte technische Reparaturen aus M3 – für M4 unbedingt vermeiden

### 19.1 M3.9 Content-Gate

Bei M3.9 schlug ein Gate fehl, weil nach einer nicht exakt im Volltext vorhandenen Formulierung gesucht wurde.

Lehre für M4:

**Content-Gates immer gegen tatsächlich gespeicherte eindeutige Fließtextmarker bauen.**

Keine Suche nach einer nur sinngemäß erwarteten Formulierung.

Keine fehleranfällige Suche nach maskiertem Word-LaTeX, wenn ein eindeutiger Fließtextmarker vorhanden ist.

Reparaturdatei:

`FRZK_3_2_REPAIR2_M3_9_CONTENT_GATE_2026-09-12.sql`

### 19.2 M3.10 Revalidierung

Vor M3.11 musste M3.10 vollständig neu validiert werden.

Revalidierungsdatei:

`FRZK_3_2_REPAIR_M3_10_FULL_REVALIDATE_2026-09-12.sql`

Lehre für M4:

Jedes Final-Gate soll vor dem Assert die vollständige Validierungstabelle ausgeben, damit bei einem Fehler der konkrete Einzeltest sichtbar ist.

### 19.3 Kein erzwungenes PASS

Ein Gate darf niemals dadurch „repariert“ werden, dass die Anforderung abgeschwächt wird.

Zuerst ist zu klären:

- Ist der mathematische Inhalt falsch?
- Ist der gespeicherte Inhalt falsch?
- Oder prüft lediglich der Gate-Marker gegen eine nicht vorhandene Zeichenfolge?

Nur im dritten Fall wird ausschließlich die Gate-Logik korrigiert.

---

## 20. Aktuell relevante Dateien aus dem M3-Abschluss

In der Reihenfolge der Fehlerbehebung/Finalisierung:

1. `FRZK_3_2_REPAIR2_M3_9_CONTENT_GATE_2026-09-12.sql`
2. `FRZK_3_2_REPAIR_M3_10_FULL_REVALIDATE_2026-09-12.sql`
3. `FRZK_3_2_RESET_M3_11_FINAL_REPO_2026-09-12.sql`
4. `FRZK_3_2_GATE_M3_ZU_M4_2026-09-13.sql`

Kanonische Volltexte der letzten Abschnitte:

- `M3_10_CANONICAL_BODY_2026-09-12.md`
- `M3_11_CANONICAL_BODY_2026-09-12.md`

Bekannte Body-Hashes:

- M3.9:
  `305ced65afee3c08e901a654745c7c7b48dbb9de2854ca2636f762e67ca845b7`
- M3.10:
  `a42e90356afb42de59bcfe06ce0710489efecc5d091ad8564411a886cf41f1fb`
- M3.11:
  `0e2b0c34e75b4872e0c15ca21264760024ebdc11243520fa9de5a4867f2e24fa`

---

## 21. Das neue Übergangsgate M3 → M4

Das Gate:

`FRZK_3_2_GATE_M3_ZU_M4_2026-09-13.sql`

prüft insbesondere:

### Vorgänger

- alle zwölf exakten Abschnitts-Final-Gates M3.0–M3.11;
- `RKB32-M311-FINAL-GATE`;
- `RKB32-M3-FINAL-GATE`;
- M3-Modulstatus `review` oder `final`.

### Abschnittsstruktur

- exakt M3.0–M3.11;
- alle zwölf Abschnitte `review` oder `final`.

### Gleichungen

- 1625 Gleichungen;
- 1625 verschiedene `display_number`;
- Minimum 1;
- Maximum 1625;
- alle zwölf Abschnittsbereiche exakt.

### Word-LaTeX

- 1625-mal `formal_latex = word_latex` bytegenau;
- keine `\tag`-Sequenz;
- gültige `equation_role`.

### Übergabe

- exakter M3.11-Body-Hash;
- Übergabeobjekt M3.0 → M4 vorhanden;
- Abschlussobjekte in M3.11 vorhanden;
- Nichtzirkularitätsmarker vorhanden.

### Literatur

- Lang `[[71]]` verifiziert;
- Strang `[[72]]` verifiziert;
- M3.11-Folgezitationen geprüft.

### Ziel M4

- M4-Modul existiert genau einmal;
- Titel/Zweck stimmen;
- Status `planned`;
- keine M4-Abschnitte;
- keine M4-Versionen;
- keine M4-Objekte.

### Final

Nur wenn alles bestanden ist:

`RKB32-M3M4-FINAL-GATE = passed`

Das Gate setzt M4 bewusst **nicht** auf `draft`. Dies geschieht erst mit dem M4.0-Skript.

---

## 22. Erwartete erste Aktion im neuen Chat

Nach erfolgreichem Gate lautet die erste inhaltliche Benutzeranweisung:

`weiter`

Daraufhin ist **M4.0 Gegenstand, Eingangsstelle, Grenzen und Aufbau** vollständig direkt im Chat zu schreiben.

M4.0 muss:

- die Übernahme aus M3 ausdrücklich benennen;
- Kern/Bild/Rang/LGS als neuen Gegenstand abgrenzen;
- M5 und M6 explizit abgrenzen;
- keine systematische M4-Theorie schon vollständig vorwegnehmen;
- die Übergabe an M4.1 benennen;
- die Gleichungsnummerierung bei `(M4.1)` beginnen.

Nach anschließendem:

`skript`

wird das M4.0-Repository-Skript erzeugt, das zwingend das Gate

`RKB32-M3M4-FINAL-GATE`

prüft.

---

## 23. Fertiger Startprompt für einen neuen Chat

Der folgende Text kann als erste Arbeitsanweisung im neuen Chat verwendet werden:

> Wir setzen den Neuaufbau der mathematischen Anlagen für Kapitel 3.2 fort. M1, M2 und M3 sind inhaltlich abgeschlossen. Die technische Übergabe von M3 nach M4 wird ausschließlich durch `RKB32-M3M4-FINAL-GATE` freigegeben. Verwende dieses Übergabedokument als verbindliche Grundlage. Beginne nach bestätigtem PASS mit M4.0 „Gegenstand, Eingangsstelle, Grenzen und Aufbau“. Alle vollständigen Abschnittstexte erscheinen als zusammenhängender wissenschaftlicher Fließtext direkt im Chat. SQL-/Repository-Skripte ausschließlich als Download. Gleichungen in M4 beginnen bei (M4.1); jede dargestellte Gleichung erhält unmittelbar die exakt identische Word-LaTeX-Zeile. M4 entwickelt Kern, Bild, Rang, Rang-Nullität und lineare Gleichungssysteme systematisch; Eigenstruktur gehört nach M5, Skalarprodukt/Norm/Orthogonalität nach M6. M3 darf nicht rückwirkend verändert werden. Arbeitsverfahren: `weiter` = nächster vollständiger Abschnitt; `skript` = Repository-Skript für den gerade abgeschlossenen Abschnitt.

---

## 24. Abschluss der Übergabe

Der mathematische Übergabepunkt ist:

`M3: lineare Abbildung → Matrixdarstellung → Basiswechsel → Ähnlichkeit → Determinante → Invertierbarkeit`

und daraus beginnt M4 mit:

`M4: Kern → Bild → Injektivität/Surjektivität → Rang → Nullität → Rang-Nullität → Zeilen-/Spaltenrang → Gauß → homogene LGS → inhomogene LGS → vollständige Lösungsmenge`

Die zentrale Übergaberichtung bleibt:

`M3 \longrightarrow M4`

M4 führt diese Struktur weiter, ohne M3 neu zu definieren und ohne M5/M6 vorwegzunehmen.
