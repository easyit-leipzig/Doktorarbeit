# FRZK – Vollständige Übergabe Anlage M4 → Anlage M5

**Stand:** 2026-09-14  
**Projekt:** FRZK / Kapitel 3.2 / mathematische Anlagen M1–M6  
**Abgebende Anlage:** M4 – *Rang, Kern, Bild und lineare Gleichungssysteme*  
**Übernehmende Anlage:** M5 – *Algebraische Eigenstruktur, Diagonalisierung und Spektralrechnung*  
**Zweck dieses Dokuments:** Verbindliche technische, mathematische und methodische Übergabe für einen neuen Arbeitschat zur Erarbeitung von M5. Dieses Dokument muss zusammen mit dem bestandenen Gate `RKB32-M4M5-FINAL-GATE` als Startzustand verwendet werden.

---

## 1. Verbindliche Arbeitsregel für den neuen M5-Chat

M5 darf **erst** begonnen werden, wenn folgende beiden Schritte erfolgreich ausgeführt wurden:

1. `FRZK_3_2_RESET_M4_12_FINAL_REPO_2026-09-14.sql`
2. `FRZK_3_2_GATE_M4_ZU_M5_FINAL_2026-09-14.sql`

Erwartete Freigaben:

- `RKB32-M412-FINAL-GATE = passed`, `failed_checks = 0`
- `RKB32-M4-FINAL-GATE = passed`
- `RKB32-M4M5-FINAL-GATE = passed`, `failed_checks = 0`

Erst danach darf M5.0 geschrieben werden.

Der neue Chat darf keine Resultate aus einem alten oder bereits vorhandenen M5-Hauptbestand übernehmen. M5 wird aus dem hier dokumentierten, abgeschlossenen mathematischen Bestand von M1–M4 neu entwickelt. Spektrale Begriffe werden in M5 selbst eingeführt und bewiesen; sie dürfen nicht rückwirkend zur Begründung von M3 oder M4 verwendet werden.

---

## 2. Technischer Repository-Stand am Ende von M4

### 2.1 Datenbank

Arbeitsdatenbank:

`frzk_rkb_32_neu`

MariaDB-Zielumgebung:

`MariaDB 10.4.x / Windows / XAMPP / phpMyAdmin`

Verbindliche Kollation zu Beginn jedes Repository-Skripts:

```sql
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection='utf8mb4_unicode_ci';
```

Repository-Tabellen, die für M4/M5 relevant sind:

- `repository_revisions`
- `appendix_modules`
- `appendix_sections`
- `appendix_section_versions`
- `appendix_objects`
- `appendix_source_usage`
- `repository_validation_results`

`appendix_objects.object_type` unterstützt insbesondere:

- `definition`
- `statement`
- `theorem`
- `lemma`
- `corollary`
- `proposition`
- `proof`
- `equation`
- `example`
- `symbol`
- `other`

Verbindliche Kennzeichnungen:

- `importance_level`: `core`, `supporting`, `derivation`, `example`
- `equation_role`: `canonical`, `derived`, `proof_step`, `example`
- `provenance`: `literature`, `adapted`, `original`, `mixed`

Für Nicht-Gleichungsobjekte muss `equation_role IS NULL` gelten.

Die Felder `document_location` und `required_for_section` sind **keine direkten Spalten von `appendix_objects`** und dürfen nicht erfunden werden.

Temporäre Tabellen mit `TEXT` oder `LONGTEXT` sind als `ENGINE=InnoDB` anzulegen.

SHA-Sollwerte werden in Skripten in der Form

```sql
_ascii'<sha256>' COLLATE ascii_bin
```

geführt und bytegenau mit `BINARY` verglichen.

### 2.2 phpMyAdmin-Regel

Repository- und Gate-Skripte müssen phpMyAdmin-sicher bleiben:

- keine Stored Procedures,
- kein `CALL`,
- kein `DELIMITER`-Block,
- kein `SIGNAL`,
- kein ausführbares Umschalten von `FOREIGN_KEY_CHECKS`.

Gates dürfen niemals abgeschwächt werden, nur damit sie bestehen.

---

## 3. Vollständiger M4-Abschnittsbestand

M4 besteht nach Abschluss aus exakt 13 Abschnitten:

| Abschnitt | Titel | Gleichungsbereich | Anzahl | kanonischer SHA256 |
|---|---|---:|---:|---|
| M4.0 | Gegenstand, Eingangsstelle, Grenzen und Aufbau | M4.1–M4.30 | 30 | `2340b6178cde9bfc3c8ad0e5dc50f9f702e61277a7e06cde56586d35953957ad` |
| M4.1 | Kern einer linearen Abbildung | M4.31–M4.142 | 112 | `f863477e776b260f247c5a88af2298141f73742ded01fad2b7a33e9db1c55a3b` |
| M4.2 | Bild einer linearen Abbildung | M4.143–M4.244 | 102 | `bf3930dc91520b1cc5e19db8f01c149dd6602ff206661c09b36edcbfa6d307dd` |
| M4.3 | Injektivität, Surjektivität und Bijektivität über Kern und Bild | M4.245–M4.370 | 126 | `7d9796f598acd3e9f2a9629ff1229798b6f7c824a80f3a971a6dc9470975eb16` |
| M4.4 | Rang einer linearen Abbildung und Rang einer Matrix | M4.371–M4.495 | 125 | `185e897093f4b77b05cbfab6f5035b0cb0d59d5982512ac2b17b0932e4877f31` |
| M4.5 | Nullität und Rang-Nullitätssatz | M4.496–M4.630 | 135 | `67a64aca1e2488135c9721466acb017035103e89fcde97b1aefc6a5b476d1e57` |
| M4.6 | Zeilenraum, Spaltenraum und Gleichheit von Zeilen- und Spaltenrang | M4.631–M4.750 | 120 | `74846810d430931408fcca1f3de0f16488eedf729d8c06d434e8a218f26fb9a5` |
| M4.7 | Elementare Zeilenoperationen und Zeilenstufenform | M4.751–M4.903 | 153 | `a5587e81d730563263dd501234b30a4a2ad00927c43a6baa9ca0d86fe07b332c` |
| M4.8 | Gauß-Algorithmus als systematische Äquivalenztransformation | M4.904–M4.1020 | 117 | `1fe4a39c8d294e80526a434866bdf6fd1ad1069224a65724d1cc4105e3bd7168` |
| M4.9 | Homogene lineare Gleichungssysteme | M4.1021–M4.1173 | 153 | `914ea834adabfa385d0a814c62fb0918109937a922d88ec102bd1b4aaeee2749` |
| M4.10 | Inhomogene lineare Gleichungssysteme und Lösbarkeit | M4.1174–M4.1329 | 156 | `ac7ca4d899bf34766f70da5972f03090c74def7d663e5e5efae700e370c27cee` |
| M4.11 | Vollständige Lösungsmenge und affine Struktur | M4.1330–M4.1483 | 154 | `acd0e6b90eab15c8927b3eb88527144a4086375d3af14e5a214e57db3a8228c6` |
| M4.12 | Ergebnisbestand und Übergabe von M4 | M4.1484–M4.1601 | 118 | `1ce29f2f17ff9e370613689afdcf4c184a501e8d6c1fbb3e09068a558af9f02c` |

Gesamtbestand M4:

- **1601 Gleichungen**
- lückenlose Nummerierung **M4.1 bis M4.1601**
- jede eigenständige Gleichung besitzt eine unmittelbar zugeordnete `Word-LaTeX:`-Zeile
- `formal_latex` und `word_latex` müssen byteidentisch sein
- keine `Word-LaTeX:`-Darstellung darf `\tag` enthalten

---

## 4. Besondere Gate-Kontrolle M4.4 und M4.5

Dieser Punkt ist für die Übergabe nach M5 besonders wichtig, weil spätere Eigenraum- und Vielfachheitsaussagen auf Rang und Nullität zurückgreifen.

### 4.1 M4.4 – Rang

M4.4 definiert den Rang **ausschließlich** durch das Bild:

`rank(T) = dim(im(T))`

Für Matrizen:

`rank(A) = dim(Col(A))`

Verbindliche logische Richtung:

`lineare Abbildung → Bild → Dimension des Bildes → Rang`

Der Rang wird **nicht** durch

- Determinanten,
- Pivotpositionen,
- Zeilenstufenformen,
- Gauß-Elimination

definiert.

M4.4 beweist insbesondere:

- `0 ≤ rank(T) ≤ min(dim(V), dim(W))`
- `T injektiv ⇔ rank(T) = dim(V)`
- `T surjektiv ⇔ rank(T) = dim(W)`
- `rank(A) = dim(Col(A))`
- Ranginvarianz unter invertierbarer linker/rechter Transformation
- für quadratische Matrizen nachträglich: `rank(A)=n ⇔ A invertierbar ⇔ det(A)≠0`

Die Determinante ist dabei nur ein **zusätzliches quadratisches Kriterium**, niemals die Rangdefinition.

M4.4 darf den Rang-Nullitätssatz aus M4.5 nicht zur eigenen Begründung benötigen. Genau diese Nichtzirkularität ist für M5 zu erhalten.

### 4.2 M4.5 – Nullität und Rang-Nullität

M4.5 definiert:

`nullity(T) = dim(ker(T))`

Der Rang-Nullitätssatz wird konstruktiv bewiesen, indem

1. eine Basis des Kerns gewählt wird,
2. diese Basis zu einer Basis von `V` ergänzt wird,
3. die Bilder der Ergänzungsvektoren als Basis des Bildes nachgewiesen werden.

Kanonisch:

`dim(V) = dim(ker(T)) + dim(im(T))`

beziehungsweise:

`nullity(T) + rank(T) = dim(V)`

und für `A ∈ K^(m×n)`:

`nullity(A) + rank(A) = n`.

Der Beweis verwendet **nicht**:

- Pivotzahl,
- freie Variablen,
- Zeilenstufenform,
- Gleichheit von Zeilen- und Spaltenrang,
- Gauß-Algorithmus.

Diese algorithmischen Interpretationen folgen erst M4.6–M4.9.

### 4.3 Bedeutung für M5

M5 darf deshalb später für eine quadratische Matrix `A` und einen Skalar `λ` mit der bereits bewiesenen M4-Struktur von

`A - λI`

arbeiten. Erst nachdem M5 Eigenwert und Eigenvektor definiert hat, darf dort aus M4 hergeleitet werden:

- der Eigenraum ist ein Kern von `A-λI`,
- seine Dimension ist eine Nullität,
- ein nichttrivialer Eigenraum entspricht einem nichttrivialen Kern,
- bei endlicher Dimension kann dies über Rangabfall beschrieben werden.

Diese Aussagen sind **Anschlussmöglichkeiten**, nicht bereits in M4 bewiesene spektrale Resultate.

---

## 5. Kanonischer mathematischer Bestand, den M5 übernehmen darf

### 5.1 Lineare Abbildungen und Matrixdarstellungen

Aus M3 und M4 stehen ohne erneuten Beweis zur Verfügung:

- lineare Abbildungen und Linearitätsregeln,
- Nullerhaltung und additive Inversen,
- Bilder von Linearkombinationen,
- Bestimmung einer linearen Abbildung durch Basisbilder,
- Matrixdarstellung bezüglich geordneter Basen,
- Komposition linearer Abbildungen,
- inverse Abbildungen und inverse Matrizen,
- Basiswechsel,
- Transformationsgesetz für Darstellungen,
- Ähnlichkeit quadratischer Matrizen,
- Determinante, Produktregel und Invertierbarkeitskriterium.

### 5.2 Kern

Kanonisch:

`ker(T) = {v ∈ V | T(v)=0}`

und für Matrizen:

`ker(A) = {x ∈ K^n | Ax=0}`.

Der Kern ist ein Untervektorraum.

Injektivität:

`T injektiv ⇔ ker(T)={0}`.

### 5.3 Bild

Kanonisch:

`im(T) = {T(v) | v∈V}`.

Bei einer Basis `(b_1,...,b_n)`:

`im(T)=span{T(b_1),...,T(b_n)}`.

Matrixebene:

`im(A)=Col(A)`.

Surjektivität:

`T surjektiv ⇔ im(T)=W`.

### 5.4 Rang

Kanonisch:

`rank(T)=dim(im(T))`.

Matrixebene:

`rank(A)=dim(Col(A))=dim(Row(A))`.

Rang ist darstellungsinvariant und unter invertierbarer linker/rechter Multiplikation invariant.

### 5.5 Nullität und Rang-Nullität

Kanonisch:

`nullity(T)=dim(ker(T))`.

`nullity(T)+rank(T)=dim(V)`.

Matrixform:

`nullity(A)+rank(A)=n`.

### 5.6 Zeilen-/Spaltenstruktur

Bewiesen:

`rowrank(A)=columnrank(A)=rank(A)`.

Außerdem:

`rank(A^T)=rank(A)`.

### 5.7 Zeilenoperationen und Gauß

Elementare Zeilenoperationen sind invertierbare linke Transformationen.

Sie erhalten:

- Zeilenraum,
- Rang,
- bei gleichzeitiger Transformation der rechten Seite die Lösungsmenge eines LGS.

Zeilenstufenform und reduzierte Zeilenstufenform stehen zur Verfügung.

Für eine Zeilenstufenform `R` gilt:

`rank(A)=#Pivot(R)`.

Diese Beziehung ist ein **Berechnungssatz**, keine Rangdefinition.

### 5.8 Homogene Systeme

`L_0(A)=ker(A)`.

`dim(L_0(A)) = n-rank(A)`.

Freie Variablen liefern eine Basis des Kerns; ihre Anzahl entspricht der Nullität.

### 5.9 Inhomogene Systeme

Lösbarkeit:

`Ax=b lösbar ⇔ b∈Col(A) ⇔ rank(A)=rank([A|b])`.

Existenz und Eindeutigkeit sind getrennte Fragen:

- Existenz ↔ Bildbedingung,
- Eindeutigkeit bei Existenz ↔ trivialer Kern.

### 5.10 Vollständige Lösungsmenge

Für jedes lösbare System und jede partikuläre Lösung `x_p`:

`L(A,b)=x_p+ker(A)`.

Der Kern ist der Richtungsraum der affinen Lösungsmenge.

Affine Dimension:

`dim(L(A,b))=nullity(A)=n-rank(A)`.

---

## 6. Was M5 ausdrücklich **nicht** aus M4 übernehmen darf

M4 hat keine spektrale Theorie entwickelt. Daher gelten die folgenden Begriffe beim Start von M5 **noch nicht als definiert oder bewiesen**:

- Eigenwert,
- Eigenvektor,
- Eigenraum,
- Spektrum,
- charakteristisches Polynom,
- algebraische Vielfachheit,
- geometrische Vielfachheit,
- Diagonalisierbarkeit,
- Eigenbasis,
- algebraische Spektralprojektoren,
- spektrale Zerlegung,
- Matrixfunktionen auf Grundlage einer Spektralzerlegung.

M5 muss diese Begriffe in einer logisch sauberen Reihenfolge selbst einführen.

Insbesondere darf M5 nicht rückwirkend behaupten, M4 habe den Kern bereits als Eigenraum oder Rangabfall bereits als Eigenwertkriterium verstanden. Diese Verknüpfungen entstehen erst nach der M5-Definition von Eigenwert/Eigenvektor.

---

## 7. Abgrenzung M5 zu M6

M5 trägt laut Repository den Titel:

**Algebraische Eigenstruktur, Diagonalisierung und Spektralrechnung**

Repository-Zweck:

> Eigenwerte, Eigenvektoren, Eigenräume, charakteristisches Polynom, algebraische und geometrische Vielfachheit, Diagonalisierbarkeit, algebraische Spektralprojektoren und Matrixfunktionen. Orthogonalität wird hier nicht vorausgesetzt.

Damit gilt verbindlich:

M5 darf **keine** Theorie voraussetzen oder entwickeln, die ein inneres Produkt benötigt.

Nach M6 gehören insbesondere:

- innere Produkte,
- Normen,
- Winkel,
- Orthogonalität,
- orthogonale Komplemente,
- Gram-Schmidt-Verfahren,
- orthogonale Projektionen,
- selbstadjungierte Operatoren,
- Hilbert-Strukturen,
- least-squares/kleinste Quadrate.

Besonders wichtig:

Ein **algebraischer Spektralprojektor** in M5 ist nicht automatisch eine **orthogonale Projektion**. Orthogonalität darf in M5 nicht definitorisch eingeschmuggelt werden.

---

## 8. Logische Anschlussstruktur für M5

Die spektrale Theorie kann auf folgenden bereits abgeschlossenen Brücken aufbauen.

### 8.1 Eigenraum als Kern – erst nach Definition in M5

Nach Einführung eines Eigenwertes `λ` und eines Eigenvektors kann M5 aus

`Av = λv`

umformen zu

`(A-λI)v=0`.

Dann darf der bereits abgeschlossene M4-Kernbegriff verwendet werden.

Erst an dieser Stelle entsteht die M5-Aussage:

`E_λ = ker(A-λI)`.

### 8.2 Geometrische Vielfachheit

Nachdem der Eigenraum definiert ist, kann M5 dessen Dimension mit M4 formulieren als

`dim(E_λ)=nullity(A-λI)`.

Dies liefert die mathematische Basis für die spätere geometrische Vielfachheit.

### 8.3 Rangabfall

Für eine quadratische `n×n`-Matrix folgt nach Definition des Eigenwertes in M5 aus M4:

`ker(A-λI) ≠ {0} ⇔ rank(A-λI)<n`.

Diese Relation darf erst **nach** der Eigenwertdefinition zum Eigenwertkriterium gemacht werden.

### 8.4 Determinantenbrücke aus M3

M3 liefert für quadratische Matrizen:

`B invertierbar ⇔ det(B)≠0`.

Mit `B=A-λI` kann M5 später entwickeln:

`λ Eigenwert ⇔ det(A-λI)=0`.

Auch diese Äquivalenz ist ein **M5-Resultat**, kein bereits in M3/M4 vorhandener spektraler Satz.

### 8.5 Diagonalisierung

M3 liefert Basiswechsel und Ähnlichkeit. M5 kann darauf aufbauend zeigen, dass eine Eigenbasis zu einer Diagonaldarstellung führt.

Die Richtung muss sauber bleiben:

Eigenvektoren → Eigenbasis → Basiswechsel → Diagonalmatrix.

Nicht umgekehrt definieren.

### 8.6 Spektralprojektoren und Matrixfunktionen

M5 darf algebraische Projektoren beziehungsweise Spektralzerlegungen nur aus den in M5 selbst bewiesenen Eigenraum-/Diagonalisierungsresultaten entwickeln.

Keine orthogonalen Projektoren und keine Selbstadjungiertheit voraussetzen; diese gehören nach M6.

---

## 9. M5-Zielmodul im Repository

Vor dem Übergangsgate muss M5 exakt einmal als geplantes und inhaltlich leeres Modul vorliegen.

Erwartete Metadaten:

- `appendix_code = 'M5'`
- Titel: `Algebraische Eigenstruktur, Diagonalisierung und Spektralrechnung`
- Zweck: `Eigenwerte, Eigenvektoren, Eigenräume, charakteristisches Polynom, algebraische und geometrische Vielfachheit, Diagonalisierbarkeit, algebraische Spektralprojektoren und Matrixfunktionen. Orthogonalität wird hier nicht vorausgesetzt.`
- `sort_order = 5`
- `status = 'planned'`
- vor Freigabe: keine M5-Abschnitte, keine M5-Versionen, keine M5-Objekte

Das Gate `RKB32-M4M5-TARGET-CLEAN` prüft genau diesen Zustand.

---

## 10. Empfohlener M5-Arbeitsplan für den neuen Chat

Dieser Plan ist ein **Arbeitsvorschlag für die Neuerschließung von M5** und wird erst durch die tatsächlichen Repository-Skripte kanonisch. Er darf bei Bedarf vor M5.0 angepasst werden, solange die Modulgrenzen erhalten bleiben.

1. **M5.0 – Gegenstand, Eingangsstelle, Grenzen und Aufbau**  
   Explizite Übernahme aus M3/M4; klare Abgrenzung zu M6 und zum späteren 3.2-Haupttext.

2. **M5.1 – Eigenwerte und Eigenvektoren**  
   Definitionen; Nullvektor ausdrücklich kein Eigenvektor; Endomorphismus-/Quadratmatrixbedingung sauber behandeln.

3. **M5.2 – Eigenräume als Kerne von `A-λI`**  
   Anwendung des M4-Kernbegriffs; Unterraumbeweis; Rang-/Nullitätsbezug.

4. **M5.3 – Charakteristisches Polynom und Eigenwertkriterium**  
   Determinantenbrücke aus M3; `det(A-λI)=0`; Grad und Körperabhängigkeit.

5. **M5.4 – Algebraische und geometrische Vielfachheit**  
   Algebraische Vielfachheit aus dem charakteristischen Polynom; geometrische Vielfachheit aus `dim ker(A-λI)`.

6. **M5.5 – Lineare Unabhängigkeit von Eigenvektoren zu verschiedenen Eigenwerten**  
   Zentral für die spätere Diagonalisierung.

7. **M5.6 – Diagonalisierbarkeit und Eigenbasen**  
   Zusammenhang mit Basiswechsel und Ähnlichkeit aus M3; Kriterien über Vielfachheiten.

8. **M5.7 – Algebraische spektrale Zerlegung und Projektoren**  
   Ausschließlich algebraisch; keine Orthogonalität voraussetzen.

9. **M5.8 – Matrixfunktionen im diagonalisierbaren/spektral zerlegten Fall**  
   Entwicklung aus bereits bewiesener algebraischer Spektralstruktur.

10. **M5.9 – Ergebnisbestand und Übergabe von M5**  
    Konsolidierung und Übergabe an M6 ohne Vorwegnahme der metrisch-orthogonalen Theorie.

Falls während der Erarbeitung ein zusätzlicher Beweisabschnitt nötig wird, ist die Abschnittsstruktur vor dem ersten entsprechenden Repository-Skript anzupassen; keine nachträgliche versteckte Umnummerierung.

---

## 11. Gleichungs- und Word-LaTeX-Regeln für M5

M5 beginnt mit einer eigenen Nummerierung:

`(M5.1)`

und nummeriert danach lückenlos fortlaufend.

Für **jede** eigenständig dargestellte Gleichung gilt:

1. sichtbare Gleichungsnummer `(M5.x)`,
2. unmittelbar anschließend eine Zeile `Word-LaTeX:`,
3. `Word-LaTeX` muss Zeichen für Zeichen der linearen Form entsprechen,
4. kein `\tag{...}` in der Word-LaTeX-Zeile,
5. literale Mengenklammern mit Backslashes, z. B. `\{0\}`,
6. Repository-Felder `formal_latex` und `word_latex` byteidentisch.

Variablen und Formeln im Fließtext werden in runden Klammern als Word-LaTeX geschrieben.

---

## 12. Literaturregeln für M5

In M4 wurden kanonisch verwendet:

- `[[71]]` – Serge Lang, *Algebra*. Revised Third Edition. New York: Springer, 2002.  
  Repository: `source_id = 50`, `source_key = lang_algebra_rev3_2002`
- `[[72]]` – Gilbert Strang, *Introduction to Linear Algebra*. Fifth Edition. Wellesley, MA: Wellesley-Cambridge Press, 2016.  
  Repository: `source_id = 51`, `source_key = strang_introduction_linear_algebra_5_2016`

Diese Quellen können in M5 nur entsprechend der Repository-Regeln verwendet werden.

Für M5 gilt wieder:

- erste Nennung einer Quelle innerhalb der Anlage in der vollständigen kanonischen Anlagenform,
- danach nur `[[Nr.]]`,
- keine Weblinks im Dissertationstext,
- keine neuen Literaturziffern erfinden,
- neue Literatur nur mit kanonischer Repository-Ziffer und geprüfter Quelle aufnehmen.

Falls M5 zusätzliche Literatur für Spektralprojektoren oder Matrixfunktionen benötigt, muss diese **vor Verwendung** im Repository eindeutig verifiziert werden.

---

## 13. Stil- und Textregeln für M5

Verbindlich:

- wissenschaftlicher persönlicher Stil,
- durchgängig Ich-Form, soweit methodische Entscheidungen beschrieben werden,
- zusammenhängender Fließtext,
- keine Häufung isolierter Einzelsätze,
- Übergabe-/Übernahmestellen ausdrücklich benennen,
- originäre methodische Eigenleistungen ausdrücklich mit `Originäre Eigenleistung dieser Arbeit.` kennzeichnen,
- keine Rückverweise auf alte Fassungen, ältere Nummerierungen oder frühere Dokumentstände,
- keine FRZK-Anwendung in der Anlage; Anwendungen gehören in den späteren Haupttext beziehungsweise Kapitel 6.

---

## 14. Nichtzirkularitätsregeln für M5

M5 muss die folgende Richtung einhalten:

`Definition Eigenwert/Eigenvektor → Eigenraum → charakteristisches Polynom → Vielfachheiten → Unabhängigkeit → Diagonalisierbarkeit → spektrale Zerlegung/Projektoren → Matrixfunktionen`

Nicht zulässig sind insbesondere:

- Eigenwertdefinition über das charakteristische Polynom, bevor die grundlegende Eigenvektorgleichung sauber eingeführt wurde, wenn dadurch die Objektbedeutung verdeckt wird,
- geometrische Vielfachheit verwenden, bevor der Eigenraum definiert und seine Dimension begründet ist,
- Diagonalisierbarkeit voraussetzen, um die lineare Unabhängigkeit benötigter Eigenvektoren zu begründen,
- Spektralprojektoren zur Begründung der Diagonalisierbarkeit verwenden, wenn diese Projektoren selbst erst aus der Diagonalisierung gewonnen werden,
- Orthogonalität oder Selbstadjungiertheit in algebraische M5-Grundbegriffe verstecken.

---

## 15. Spezifische M4→M5-Brücken

M5 darf folgende technische Werkzeuge direkt verwenden:

### 15.1 Kern-/Rangprüfung

Für jede in M5 definierte quadratische Matrix `B`:

- `ker(B)` ist definiert,
- `nullity(B)=dim ker(B)`,
- `rank(B)+nullity(B)=n`,
- `ker(B)≠{0} ⇔ rank(B)<n`,
- `ker(B)={0} ⇔ rank(B)=n`.

### 15.2 Invertierbarkeit

Für quadratische `B`:

- `rank(B)=n ⇔ B invertierbar`,
- `B invertierbar ⇔ det(B)≠0`.

Damit kann M5 nach Einführung von `B=A-λI` spektrale Kriterien entwickeln.

### 15.3 Basiswechsel und Ähnlichkeit

M3 liefert die Darstellungsänderung. M5 darf diese Struktur für Diagonalisierung verwenden, muss aber die Existenz einer Eigenbasis eigenständig beweisen beziehungsweise als Diagonalisierbarkeitskriterium formulieren.

### 15.4 Homogene Gleichungssysteme

Gleichungen vom Typ

`(A-λI)v=0`

können mit dem vollständigen M4-Apparat behandelt werden, **nachdem** M5 die spektrale Bedeutung dieser Gleichung eingeführt hat.

---

## 16. Gate M4 → M5 – Einzelprüfungen

Das technische Gate führt mindestens folgende Prüfgruppen aus:

### `RKB32-M4M5-PREDECESSOR`

- Gate-Revision vorhanden,
- alle 13 Abschnittsgates M4.0–M4.12 `passed`,
- `RKB32-M412-FINAL-GATE = passed`.

### `RKB32-M4M5-SECTIONS`

- exakt 13 M4-Abschnitte,
- exakt M4.0–M4.12,
- alle Status `review` oder `final`.

### `RKB32-M4M5-EQUATIONS`

- exakt 1601 Gleichungen,
- lückenlos M4.1–M4.1601,
- korrekte Abschnittsbereiche.

### `RKB32-M4M5-WORDLATEX-HASH`

- 1601 byteidentische `formal_latex`-/`word_latex`-Paare,
- keine `\tag`-Sequenzen,
- alle Word-LaTeX-Zeilen im jeweiligen kanonischen Body,
- alle 13 kanonischen Abschnittshashes stimmen,
- keine unzulässigen Gleichungsrollen.

### `RKB32-M4M5-HANDOFF-SOURCES`

- explizite M5-, M6- und Haupttextgrenze,
- methodische Eigenleistung,
- expliziter M4-Abschluss,
- explizite Übergabe M4→M5,
- geprüfte Literaturverwendung `[[71]]` und `[[72]]`.

### `RKB32-M4M5-TARGET-CLEAN`

M5 muss vor der Freigabe:

- exakt einmal existieren,
- die erwarteten Metadaten tragen,
- `planned` sein,
- keine Abschnitte besitzen,
- keine Abschnittsversionen besitzen,
- keine Objekte besitzen.

### Gesamtgates

- `RKB32-M4-FINAL-GATE`
- `RKB32-M4M5-FINAL-GATE`

Nur bei `failed_checks = 0` ist M5 freigegeben.

---

## 17. Startauftrag für den neuen M5-Chat

Nach bestandenem `RKB32-M4M5-FINAL-GATE` lautet der Arbeitsauftrag:

> Erarbeite Anlage M5 – *Algebraische Eigenstruktur, Diagonalisierung und Spektralrechnung* vollständig neu auf Grundlage der abgeschlossenen Anlagen M1–M4. Übernimm ausschließlich die im Übergabedokument als bewiesen ausgewiesenen algebraischen Resultate. Beginne mit M5.0 und führe spektrale Begriffe nicht rückwirkend in M3 oder M4 ein. Orthogonalität, innere Produkte, selbstadjungierte Operatoren und orthogonale Projektionen sind vollständig M6 vorbehalten. Jeder Abschnitt wird zunächst vollständig im Chat im persönlichen wissenschaftlichen Fließtext und in Ich-Form erarbeitet; das zugehörige Repository-Skript folgt erst auf den ausdrücklichen Befehl `skript`. Gleichungen erhalten eine lückenlose M5-Nummerierung ab M5.1 und jeweils eine exakt identische Word-LaTeX-Zeile.

---

## 18. Verbindliche Reihenfolge im neuen Chat

1. Gate-Ausgabe `RKB32-M4M5-FINAL-GATE = passed` als Ausgangspunkt akzeptieren.
2. Dieses Übergabe-MD als kanonische Startinformation lesen.
3. M5-Zielmodul unverändert `planned` und leer übernehmen.
4. M5.0 vollständig im Chat schreiben.
5. Erst auf `skript` das kumulative M5.0-Repository-Skript erzeugen.
6. Danach Abschnitt für Abschnitt fortfahren.
7. Keine M6-Theorie vorziehen.
8. Nach Abschluss von M5 wiederum Abschlussabschnitt, M5-Gesamtgate und Übergabe M5→M6 erzeugen.

---

## 19. Abschlussstatus dieser Übergabe

M4 endet kanonisch mit Gleichung:

`M4.1601`

und mit der expliziten Übergabe an M5.

M5 beginnt erst nach bestandenem Übergangsgate mit:

`M5.0`

und seine erste eigenständige Gleichung erhält die Nummer:

`M5.1`.

**Kein spektrales Resultat ist Bestandteil des abgeschlossenen M4-Bestands. M5 erhält ausschließlich den vollständigen linearen Strukturapparat, auf dessen Grundlage die spektrale Theorie neu und nichtzirkulär aufgebaut wird.**
