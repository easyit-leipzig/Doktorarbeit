# Übergabe FRZK – Kapitel 3.6 → Kapitel 3.7

**Projekt:** Dissertation / Funktionales Raum-Zeit-Kohärenzsystem (FRZK)  
**Übergabestand:** wissenschaftlicher Abschluss von Kapitel 3.6 einschließlich 3.6.10  
**Ausgangskapitel:** 3.6 „Beobachtungs-, Operationalisierungs- und Identifizierbarkeitsarchitektur des Funktionalen Raum-Zeit-Kohärenzsystems“  
**Abschlussabschnitt:** 3.6.10 „Synthese der Beobachtungsarchitektur, Kernschutz und Übergang zur Anwendung“  
**Ziel:** verbindliche wissenschaftliche, stilistische, formale und repository-seitige Startgrundlage für Kapitel 3.7  
**Letzte Gleichung:** (3.3716)  
**Nächste Gleichung:** (3.3717)  
**Letzte Literaturzahl:** [105]  
**Nächste Literaturzahl:** [106]  
**Universeller Primärkern:** exakt {PA 3.3.1}  
**Neue Primäraxiome in Kapitel 3.6:** 0  
**Definitionen Kapitel 3.6:** 3.6.1–3.6.10 = 10  
**Propositionen Kapitel 3.6:** 3.6.1–3.6.9 = 9  
**Sätze Kapitel 3.6:** Satz 3.6.1  
**Beweise Kapitel 3.6:** 10  
**Nummerierte Gleichungen Kapitel 3.6:** (3.3481)–(3.3716) = 236  
**Verbindlicher Startzeiger nach erfolgreichem Übergabe-Gate:** `current_section = 3.7.0`

---

# 0. Status und wichtigste Korrektur dieser Übergabe

## 0.1 Wissenschaftlicher Status

Kapitel 3.6 ist inhaltlich abgeschlossen. Es entwickelt die allgemeine Architektur zwischen einer bereits zulässigen FRZK-Rekonstruktion und einer kontrollierten empirischen Aussage. Die Schichtenfolge umfasst Beobachtungskontext und Beobachtungsbrücke, Rückgewinnbarkeit, Beobachtungsäquivalenz, strukturelle Identifizierbarkeit, quantitativen Messkontext, Messunsicherheit, dynamische Beobachtbarkeit, statistische Inferenz und das FRZK-Beobachtungszertifikat.

Der universelle Primärkern wurde nicht erweitert. Auch am Ende von Kapitel 3.6 bleibt exakt ein accepted-Primäraxiom bestehen:

`PA 3.3.1`

**Wissenschaftlicher Übergabestatus: PASS.**

## 0.2 Technischer Status

Das Kapitelabschlussskript lautet:

`frzk_rkb_3.6.10_kapitelabschluss_v1.sql`

Die Abschlussrevision lautet:

`RKB-NEU-K3.6.10-KAPITELABSCHLUSS-V1`

Danach ist zwingend das separate Übergabe-Gate auszuführen:

`frzk_rkb_gate_3.6_zu_3.7_v1.sql`

Erwartete Gate-Revision:

`RKB-GATE-K3.6-ZU-K3.7-V1`

**WICHTIGE KORREKTUR:** Das vorhandene 3.6.10-Kapitelabschlussskript setzt `current_section = 4.0`. Dieser Zeiger ist für den jetzt ausdrücklich festgelegten Fortgang **3.6 → 3.7** falsch. Die etablierte Unterabschnittskonvention aus der Übergabe 3.5 → 3.6 verlangt für den Beginn des neuen Hauptabschnitts den ersten Unterabschnitt, daher:

`current_section = 3.7.0`

Das Übergabe-Gate akzeptiert den bekannten `4.0`-Zwischenstand und korrigiert ihn transaktional auf `3.7.0`.

**Repository-Übergabestatus: PENDING, bis 3.6.10 importiert, das Übergabe-Gate erfolgreich ausgeführt und ein neuer Enddump Ende 3.6 exportiert wurde.**

---

# 1. Verbindlicher technischer Übergabeablauf

Die technische Übergabe ist in genau dieser Reihenfolge auszuführen:

1. Sicherstellen, dass die kanonischen Repository-Skripte von 3.6 vollständig importiert wurden.
2. Für 3.6.3 ausschließlich `frzk_rkb_3.6.3_abschluss_v1_1_schemafix.sql` als verbindlichen Stand verwenden.
3. `frzk_rkb_3.6.10_kapitelabschluss_v1.sql` erfolgreich ausführen.
4. `frzk_rkb_gate_3.6_zu_3.7_v1.sql` ausführen.
5. Nur bei vollständigem Gate-PASS einen neuen vollständigen Datenbankdump exportieren.
6. Empfohlener Dateiname: `frzk_rkb_stand_ende_3.6.sql`.
7. SHA-256 des neuen Dumps dokumentieren.
8. Der neue Enddump wird ab diesem Zeitpunkt die **einzige verbindliche Schema- und Inhaltsreferenz** für alle SQL-Skripte von Kapitel 3.7.
9. Vor dem ersten 3.7-Skript muss die reale Schema-Signatur erneut gegen diesen neuen Dump geprüft werden.
10. Erst danach Gate 0 / Startmatrix für 3.7 durchführen.
11. Der erste zu schreibende Unterabschnitt ist nach erfolgreicher Freigabe `3.7.0`.

---

# 2. Kanonische Repository-Skriptkette von Kapitel 3.6

| Datei | SHA-256 |
|---|---|
| `frzk_rkb_3.6.0_abschluss_v1.sql` | `036061bdfdeee79116c90c38af4728c4afa1729b0250258daf7335a06afd6022` |
| `frzk_rkb_3.6.1_abschluss_v1.sql` | `732689c5d57b82b7e223b162348b90ba0c357c81ce305f9bfc51d267f78977a3` |
| `frzk_rkb_3.6.2_abschluss_v1.sql` | `07eff6db5f3b9ea4698bbf9c5fc22c473a0e2c968ff77249cec42b3afbf5f073` |
| `frzk_rkb_3.6.3_abschluss_v1_1_schemafix.sql` | `6df777599429ae8216be067576c325920d58467461c9a01173f181798b04295f` |
| `frzk_rkb_3.6.4_abschluss_v1.sql` | `5e2c427a429146dc4ac09bb50eb5b081b4fa14af75ca679c4cf65a7cde66df28` |
| `frzk_rkb_3.6.5_abschluss_v1.sql` | `24eae88c536efda94d77554b7fe04942666d4689bce77c995fb30d935fd6a842` |
| `frzk_rkb_3.6.6_abschluss_v1.sql` | `4d13059c433b00cfbfebf484707b74f1b43a08ebe11f0d5089a7f5b3de1bf51d` |
| `frzk_rkb_3.6.7_abschluss_v1.sql` | `587b0dcac5090f3991176ebfc773ab913d7d8b0f7dac4976009bd9d0132a9a3f` |
| `frzk_rkb_3.6.8_abschluss_v1.sql` | `ad048fc7a88b321e6f3e08e6c41ce8a38599b0b32688ee476c5ca03f383af123` |
| `frzk_rkb_3.6.9_abschluss_v1.sql` | `2905239d2cb4b3752a3eb3e97686a1ba0798c5593b59943c02a9883f769e1327` |
| `frzk_rkb_3.6.10_kapitelabschluss_v1.sql` | `0aa4ff5b2d7b0e2c3984cf1864aa98ac2307e58c99555c9dd9dd7a2f852ff90a` |

## 2.1 Nicht mehr verwenden

Die Datei

`frzk_rkb_3.6.3_abschluss_v1.sql`

ist **nicht kanonisch**. Sie enthält den bekannten Schemafehler, dass `proposition` als Typ in `object_dependencies` verwendet wurde. Das reale Schema erlaubt diesen Typ dort nicht.

Verbindlich ist ausschließlich:

`frzk_rkb_3.6.3_abschluss_v1_1_schemafix.sql`

Die Revision `RKB-NEU-K3.6.4-ABSCHLUSS-V1` muss auf `RKB-NEU-K3.6.3-ABSCHLUSS-V1.1` aufbauen.

---

# 3. Gate 3.6 → 3.7 – verbindliche Sollwerte

| Prüffeld | Soll |
|---|---:|
| Hauptabschnitt 3.6 | FINAL |
| Teilabschnitte 3.6.0–3.6.10 | 11 FINAL |
| Definitionen 3.6.1–3.6.10 | 10 VERIFIED |
| Propositionen 3.6.1–3.6.9 | 9 ACCEPTED |
| Satz 3.6.1 | 1 VERIFIED |
| Beweise | 10 VERIFIED |
| Gleichungen 3.3481–3.3716 | 236 VERIFIED |
| Gleichungen mit Word-LaTeX | 236 |
| neue Annahmen in 3.6 | 0 |
| neue Primäraxiome in 3.6 | 0 |
| neue Lemmata in 3.6 | 0 |
| neue Korollare in 3.6 | 0 |
| accepted Primäraxiome global | exakt 1 |
| accepted Primäraxiom | exakt PA 3.3.1 |
| neue Literatur 3.6 | [98]–[105] = 8 |
| letzte Literaturzahl | 105 |
| nächste Literaturzahl | 106 |
| `current_section` nach Gate | `3.7.0` |
| `last_completed_section` | `3.6.10` |
| `last_completed_chapter` | `3.6` |

---

# 4. Wissenschaftlicher Endbestand von Kapitel 3.6

## 4.1 Unterabschnitte

1. **3.6.0** Beobachtungsauftrag, Ebenengrenze und Ausgangsarchitektur  
2. **3.6.1** Beobachtungskontext und zulässige FRZK-Beobachtungsbrücke  
3. **3.6.2** Rückgewinnbarkeit und beobachtungsbedingter Strukturverlust  
4. **3.6.3** Beobachtungsäquivalenz, Invarianz und Diskriminanz  
5. **3.6.4** Identifizierbarkeit und beobachtungsrelative Unterbestimmtheit  
6. **3.6.5** Quantitative Messkontexte, Messmodelle und Datenbildung  
7. **3.6.6** Messunsicherheit und praktische Rückgewinnbarkeit  
8. **3.6.7** Beobachtbarkeit bedingter FRZK-Dynamiken  
9. **3.6.8** Statistische Inferenz, praktische Identifizierbarkeit und Modellvergleich  
10. **3.6.9** Empirische Verträglichkeit, Negativaussagen und FRZK-Beobachtungszertifikat  
11. **3.6.10** Synthese der Beobachtungsarchitektur, Kernschutz und Übergang zur Anwendung

## 4.2 Definitionen

| Nr. | Titel |
|---|---|
| Definition 3.6.1 | FRZK-Beobachtungskontext |
| Definition 3.6.2 | Zulässige FRZK-Beobachtungsbrücke |
| Definition 3.6.3 | Beobachtungsrelative Rückgewinnbarkeit |
| Definition 3.6.4 | FRZK-Beobachtungsäquivalenz |
| Definition 3.6.5 | Beobachtungsrelative FRZK-Identifizierbarkeit |
| Definition 3.6.6 | Quantitativer FRZK-Messkontext |
| Definition 3.6.7 | Bedingtes FRZK-Messunsicherheitsprofil |
| Definition 3.6.8 | Dynamische FRZK-Beobachtbarkeit |
| Definition 3.6.9 | Empirisches FRZK-Prüfprofil |
| Definition 3.6.10 | FRZK-Beobachtungszertifikat |

## 4.3 Propositionen

| Nr. | Titel |
|---|---|
| Proposition 3.6.1 | Faserkriterium der beobachtungsrelativen Rückgewinnbarkeit |
| Proposition 3.6.2 | Grenze beobachtungsinterner Diskriminanz |
| Proposition 3.6.3 | Beobachtungsäquivalenz inequivalenter Rekonstruktionen erzwingt strukturelle Nichtidentifizierbarkeit |
| Proposition 3.6.4 | Beobachtungsrelativ ungelöster FRZK-Unterbestimmtheitszeuge |
| Proposition 3.6.5 | Wiederholung derselben Beobachtungsbrücke beseitigt strukturelle Nichtidentifizierbarkeit nicht |
| Proposition 3.6.6 | Messunsicherheit kann praktische Identifizierbarkeit verschlechtern, erzeugt aber keine strukturelle Nichtidentifizierbarkeit |
| Proposition 3.6.7 | Dynamische Nichtbeobachtbarkeit durch identische Beobachtungsspuren |
| Proposition 3.6.8 | Statistische Auswahl beseitigt strukturelle Nichtidentifizierbarkeit nicht |
| Proposition 3.6.9 | Ein negativer empirischer Befund lokalisiert zunächst den geprüften Abhängigkeitsbestand |

## 4.4 Satz

**Satz 3.6.1 – Schichtensatz der empirischen FRZK-Prüfbarkeit**

Der Satz fasst die gesamte Schichtenlogik zusammen: Eine empirische Prüfaussage erbt sämtliche tatsächlich verwendeten Voraussetzungen ihrer Ableitungskette. Eine nachgelagerte deterministische Verarbeitung kann einen theoretischen Unterschied, der bereits in einer vorgelagerten Beobachtungsabbildung vollständig kollabiert wurde, nicht aus derselben Information wiederherstellen.

---

# 5. Verbindliche Schichtenlogik für Kapitel 3.7

Kapitel 3.7 darf die in 3.6 etablierte Richtung nicht umkehren oder vermischen. Die maximale empirische Kette lautet:

`theoretische Rekonstruktion -> Beobachtung -> Messung -> Unsicherheit -> Statistik -> Ergebnisstatus -> Beobachtungszertifikat`

Verbindliche Konsequenzen:

- Beobachtung erzeugt keine theoretische Rekonstruktion.
- Daten erzeugen ohne zusätzliche Inferenzstruktur keine FRZK-Rekonstruktion.
- Rückgewinnbarkeit einer einzelnen Zielgröße ist schwächer als vollständige Identifizierbarkeit.
- strukturelle Nichtidentifizierbarkeit wird nicht durch kleinere Messunsicherheit beseitigt.
- statistische Auswahl verändert keine Beobachtungsäquivalenzklasse.
- Messmodell und Beobachtungsbrücke bleiben verschiedene Objekte.
- Messunsicherheit verändert keine theoretische Äquivalenzklasse.
- eine dynamische Beobachtungsspur erzeugt kein Dynamikgesetz.
- statistische Modellpräferenz ist keine universelle Wahrheitsgarantie.
- positive und negative empirische Befunde sind auf den tatsächlich geprüften Abhängigkeitsbestand zu begrenzen.
- konkrete empirische Instanzen und Anwendungen gehören weiterhin in Kapitel 6.

---

# 6. Nicht-Redefinitionsprinzip für 3.7

Vor **jeder** neuen Definition in 3.7 ist zu prüfen, ob das benötigte Objekt bereits in 3.2–3.6 existiert.

Insbesondere dürfen ohne ausdrücklichen wissenschaftlichen Grund nicht erneut definiert werden:

- Rekonstruktionsnormalform,
- Rekonstruktionsfamilie,
- Schnittstellenprofil,
- Kompositionskompatibilität,
- Kopplungsbrücke,
- gekoppelte FRZK-Organisation,
- Brückenreduktionsordnung,
- minimal hinreichende Brücke,
- FRZK-Unterbestimmtheitszeuge,
- bedingtes Dynamikprofil,
- informationsstatistisches Profil,
- FRZK-Beobachtungskontext,
- zulässige FRZK-Beobachtungsbrücke,
- beobachtungsrelative Rückgewinnbarkeit,
- FRZK-Beobachtungsäquivalenz,
- beobachtungsrelative FRZK-Identifizierbarkeit,
- quantitativer FRZK-Messkontext,
- bedingtes FRZK-Messunsicherheitsprofil,
- dynamische FRZK-Beobachtbarkeit,
- empirisches FRZK-Prüfprofil,
- FRZK-Beobachtungszertifikat.

Die erste Frage vor jedem neuen Objekt lautet:

> Existiert dieser Begriff bereits und muss er lediglich auf den neuen Kontext von 3.7 angewandt, spezialisiert oder kombiniert werden?

---

# 7. Primäraxiom-Gate für 3.7

Kapitel 3.7 startet mit genau einem universellen Primäraxiom:

`PA 3.3.1`

Ein neues Primäraxiom darf nicht deshalb eingeführt werden, weil eine gewünschte Modell-, Beobachtungs-, Mess- oder Anwendungseigenschaft sonst nicht folgt.

Sollte in 3.7 eine vermeintlich universell notwendige neue Struktur auftreten, muss vor ihrer Übernahme erneut vollständig geprüft werden:

1. Ist sie bereits aus PA 3.3.1 und bestehenden Definitionen ableitbar?
2. Ist sie nur eine `def`-, `model`- oder `bridge`-Erweiterung?
3. Ist ihre behauptete Universalität wirklich erforderlich?
4. Entsteht sie nur aus einem bestimmten Anwendungsfall?
5. Verändert sie den bisherigen Ein-Axiom-Kern?
6. Liegt ein unabhängiger wissenschaftlicher Grund vor, den Primärkern neu zu öffnen?

Ohne vollständiges Gate bleibt der Kern geschlossen.

---

# 8. Erweiterungstypen – verbindliche Taxonomie

Definition 3.3.90 legt genau vier Erweiterungstypen fest:

- `def`
- `model`
- `bridge`
- `primary`

**Keine fünfte Erweiterungskategorie darf stillschweigend eingeführt werden.**

Interpretationen, empirische Ergebnisse, Analogien oder Anwendungen sind Aussage- beziehungsweise Verwendungsarten, aber keine zusätzlichen Werte der Erweiterungstyp-Taxonomie.

---

# 9. VERBINDLICH: persönlicher wissenschaftlicher Schreibstil und Ich-Form

Dieser Punkt ist für Kapitel 3.7 ausdrücklich hervorzuheben und **nicht optional**.

## 9.1 Autorenstimme

Der Dissertationstext wird in der **persönlichen wissenschaftlichen Stimme des Autors** geschrieben.

Wo eigene Setzungen, methodische Entscheidungen, Definitionen, Rekonstruktionsschritte, Abgrenzungen, Interpretationen oder originäre FRZK-Beiträge beschrieben werden, ist **überwiegend die Ich-Form** zu verwenden.

Geeignete Formulierungen sind beispielsweise:

- „Ich definiere …“
- „Ich unterscheide …“
- „Ich setze voraus …“
- „Ich verwende …“
- „Aus dieser Voraussetzung leite ich … ab.“
- „Ich beschränke den Begriff hier auf …“
- „Für das FRZK übernehme ich daraus nicht …, sondern …“
- „Mit dieser Definition trenne ich …“
- „Ich ordne diese Struktur dem Erweiterungstyp … zu.“

Die Autorenstimme darf nicht in einen anonymen Lehrbuchstil umgeschrieben werden.

## 9.2 Fließtext

**Alleinstehende kurze Sätze entsprechen grundsätzlich nicht dem persönlichen Schreibstil.**

Verbindlich sind:

- zusammenhängende, logisch entwickelte Absätze,
- mehrere sachlich verbundene Sätze pro Absatz,
- nachvollziehbare Übergänge,
- keine Häufung von Ein-Satz-Absätzen,
- keine künstliche Telegramm- oder Stichsatzsprache im Dissertationstext,
- einzelne hervorgehobene Sätze nur für tatsächlich zentrale Kernaussagen.

Die Ich-Form bedeutet dabei nicht, jeden Satz mit „Ich“ zu beginnen. Ziel ist eine erkennbare persönliche wissenschaftliche Stimme innerhalb kohärenter Absätze.

## 9.3 Eigenleistung

Jede originäre FRZK-Leistung muss ausdrücklich als

**„Eigenleistung dieser Arbeit.“**

gekennzeichnet werden. Dies gilt insbesondere für neue:

- Definitionen,
- Sätze,
- Propositionen,
- Klassifikationen,
- Rekonstruktionsschritte,
- Statusentscheidungen,
- Ableitungslogiken,
- methodische Kontrollstrukturen.

## 9.4 Methodologische und didaktische Betrachtungen

Vollständige wissenschaftliche Unterabschnitte sollen die methodische Funktion der eingeführten Struktur erläutern. Wo der Abschnitt wie in 3.6 eine abgeschlossene eigene Entwicklungseinheit bildet, sind **Methodologische Betrachtungen** und **Didaktische Betrachtungen** in der persönlichen wissenschaftlichen Stimme fortzuführen.

---

# 10. Formale Schreibregeln für Mathematik

## 10.1 Fließtext-Mathematik

Mathematische Variablen, Symbole und Formelbestandteile erscheinen im Fließtext **nicht gerendert**, sondern ausschließlich als geklammerte Word-LaTeX-Schreibweise, zum Beispiel:

`(\mathfrak B_{\mathrm{obs}}^{(\chi)})`

`(\rho(X_i))`

`(\mathcal K_{\mathrm{id}}^{(\chi)})`

## 10.2 Eigenständig dargestellte Gleichungen

Jede gerenderte beziehungsweise eigenständig dargestellte Formel oder Gleichung erhält **unmittelbar in der nächsten Zeile**:

`Word-LaTeX: ...`

Dazwischen darf kein Fließtext stehen.

Diese Regel gilt ausnahmslos auch für:

- unnummerierte Formeln,
- Formeln in Definitionen,
- Formeln in Beweisen,
- mehrzeilige Gleichungsfolgen.

## 10.3 Nummerierungsanschluss

Letzte Gleichung von Kapitel 3.6:

`(3.3716)`

Erste neue Gleichung von Kapitel 3.7:

`(3.3717)`

Die Gleichungsnummerierung wird nicht am Abschnittswechsel zurückgesetzt.

---

# 11. Literaturregeln für 3.7

## 11.1 Laufender Dissertationstext

Im Dissertationstext dürfen **keine Weblinks, URLs oder klickbaren Quellenlinks** erscheinen.

Literatur ist im Fließtext mit der **genauen bibliografischen Quelle in runden Klammern** anzugeben:

`([genaue bibliografische Quelle])`

Eine bloße Literaturzahl wie `[106]` ist im laufenden wissenschaftlichen Text nicht ausreichend, wenn die Quelle dort tatsächlich als Beleg verwendet wird.

DOIs dürfen als bibliografische Textinformation erscheinen, jedoch nicht als klickbarer Weblink.

## 11.2 Repository

Im Repository bleiben Literaturzahlen, DOI- und URL-Felder zulässig und erforderlich, sofern sie real verifiziert sind.

Verbindlich:

- letzte Literaturzahl nach 3.6 = `[105]`,
- nächste freie Literaturzahl = `[106]`,
- keine Doppelvergabe,
- `source_key` muss eindeutig bleiben,
- Autorenzuordnungen müssen über `source_authors` korrekt und geordnet erfolgen,
- Fundstellen dürfen nicht aus dem Dissertationstext abgeleitet werden,
- `source_usage.exact_location` bleibt leer, wenn keine reale Fundstelle verifiziert wurde.

---

# 12. Quellenbestand von Kapitel 3.6

Neu eingeführt wurden:

| Nr. | Quelle / Funktion |
|---:|---|
| [98] | JCGM VIM – metrologische Grundbegriffe |
| [99] | Engl / Hanke / Neubauer – inverse Probleme |
| [100] | Bellman / Åström – strukturelle Identifizierbarkeit |
| [101] | Raue et al. – strukturelle und praktische Identifizierbarkeit |
| [102] | JCGM GUM-6:2020 – Messmodelle |
| [103] | JCGM 100:2008(E) – Messunsicherheit |
| [104] | Hermann / Krener – dynamische Beobachtbarkeit |
| [105] | Akaike – statistische Modellidentifikation / AIC |

Zusätzlich wurden ältere Quellen aus 3.2–3.5 wiederverwendet, insbesondere [82] und [95].

---

# 13. Verbindliche Repository-Regeln für alle 3.7-Skripte

1. **Vor jedem neuen SQL-Skript den tatsächlichen Enddump Ende 3.6 lesen.**
2. Keine Tabellen- oder Spaltennamen aus Erinnerung verwenden.
3. Keine ENUM-Werte erfinden.
4. Keine Fremdschlüsselziele raten.
5. Vor INSERT/UPDATE die tatsächlich vorhandenen Unique Keys berücksichtigen.
6. Kollation grundsätzlich `utf8mb4_unicode_ci`.
7. Vergleiche mit Textwerten bei möglichen Mischkollationen ausdrücklich auf `utf8mb4_unicode_ci` ausrichten.
8. Skripte transaktional aufbauen.
9. `EXIT HANDLER FOR SQLEXCEPTION` mit `ROLLBACK` und `RESIGNAL` verwenden.
10. Pre-Gates vor Datenänderungen.
11. Post-Gates vor `COMMIT`.
12. Idempotenz berücksichtigen.
13. Revisionskette über `parent_revision_id` fortführen.
14. `repository_validation_results` für belastbare Gates verwenden.
15. `section_change_log` mit **tatsächlich erlaubtem** `change_type` beschreiben.
16. SQL-Skripte ausschließlich als Download-Datei ausgeben.
17. Nach Möglichkeit real gegen eine aus dem Enddump rekonstruierte MariaDB testen.
18. Wenn kein MariaDB-Server vorhanden ist, dies ausdrücklich sagen und statische Schema-/Spaltenprüfung durchführen.
19. Keine erfolgreich ausgeführte Datenbankprüfung behaupten, wenn nur statisch geprüft wurde.
20. Nach erfolgreichem Hauptabschnitt einen neuen vollständigen Enddump exportieren.

---

# 14. Kritische reale DB-Fallen – vor 3.7 zwingend beachten

## 14.1 `object_dependencies`

Die ENUM-Werte von `object_type_from` und `object_type_to` sind exakt:

`definition, theorem, lemma, corollary, proof, equation, assumption, axiom, figure, table`

**`proposition` ist dort NICHT zulässig.**

Propositionen dürfen daher nicht als `object_type_from='proposition'` oder `object_type_to='proposition'` in `object_dependencies` geschrieben werden.

## 14.2 `proofs`

Die Tabelle `proofs` besitzt:

- `theorem_id`
- `lemma_id`
- `corollary_id`

Sie besitzt **kein `proposition_id`**.

Ein Beweis zu einer Proposition kann daher nicht durch eine erfundene `proofs.proposition_id`-Spalte verknüpft werden.

## 14.3 `proposition_dependencies`

`proposition_dependencies` erlaubt Abhängigkeiten einer Proposition nur über:

- `axiom_id`
- `assumption_id`

Es existiert dort **kein `definition_id`**.

Definitionale oder sonstige logische Abhängigkeiten einer Proposition sind deshalb nicht durch erfundene Spalten in dieser Tabelle abzubilden.

## 14.4 `object_source_links`

Anders als `object_dependencies` unterstützt `object_source_links` den Objekttyp `proposition`.

Die beiden Tabellen dürfen nicht hinsichtlich ihrer ENUM-Werte verwechselt werden.

## 14.5 `equations`

`word_latex` ist `NOT NULL`.

Jede neue nummerierte Gleichung muss deshalb sowohl `equation_latex` als auch `word_latex` erhalten.

## 14.6 `repository_revisions.scope_type`

Erlaubt sind:

`repository, chapter, section, source, equation, definition, statement, figure, table, symbol, acronym, axiom, assumption, proof, proposition`

Ein frei erfundener Typ `gate` ist nicht zulässig. Gate-Revisionen sind z. B. als `chapter` oder `repository` zu speichern.

## 14.7 `section_change_log.change_type`

Nur die real im ENUM vorhandenen Werte verwenden. Keine freien Statusnamen als `change_type` erfinden.

## 14.8 Literatur-Fundstellen

`source_usage.exact_location` darf nur mit real verifizierten Fundstellen befüllt werden. Dissertationstext ist keine Quelle für eine Fundstelle.

---

# 15. DB-Schema-Signatur für 3.7 – warum sie in dieser Datei enthalten ist

Die folgenden DDL-Blöcke wurden direkt aus dem verbindlichen Enddump

`frzk_rkb_stand_ende_3.5(2).sql`

extrahiert.

Kapitel 3.6 enthält **keine DDL-Änderungen** (`CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`). Damit ist die Schema-Struktur am Ende von 3.6 bis zum Export des neuen Enddumps unverändert.

Nach erfolgreichem Übergabe-Gate ist trotzdem ein neuer Enddump Ende 3.6 zu exportieren. **Ab dann ist ausschließlich dieser neue Dump normativ.**

Die DDL-Signatur in dieser Übergabe dient dazu, in einer neuen Sitzung sofort die realen Tabellen, Spalten, ENUMs, Schlüssel und Fremdschlüssel zur Verfügung zu haben und typische Fehler wie #1052, #1267, #1452 oder #1644 nicht durch geratenes Schema zu erzeugen.

---

# 16. Vollständige Datenbankstruktur des verbindlichen Schemas

### Tabelle `acronyms`

```sql
CREATE TABLE `acronyms` (
  `acronym_id` bigint(20) UNSIGNED NOT NULL,
  `acronym` varchar(100) NOT NULL,
  `full_form` varchar(1000) NOT NULL,
  `explanation` longtext DEFAULT NULL,
  `first_section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `language_code` char(2) NOT NULL DEFAULT 'de',
  `category` varchar(255) DEFAULT NULL,
  `is_project_specific` tinyint(1) NOT NULL DEFAULT 0,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `acronyms`
  ADD PRIMARY KEY (`acronym_id`),
  ADD UNIQUE KEY `uq_acronym` (`acronym`),
  ADD KEY `fk_acronyms_section` (`first_section_id`),
  ADD KEY `fk_acronyms_revision` (`created_revision_id`);

ALTER TABLE `acronyms`
  MODIFY `acronym_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `acronyms`
  ADD CONSTRAINT `fk_acronyms_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_acronyms_section` FOREIGN KEY (`first_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL;

```

### Tabelle `annotations`

```sql
CREATE TABLE `annotations` (
  `annotation_id` bigint(20) UNSIGNED NOT NULL,
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `contribution` text DEFAULT NULL,
  `significance_for_dissertation` text DEFAULT NULL,
  `citation_reason` text DEFAULT NULL,
  `adopted_claims` text DEFAULT NULL,
  `limitations` text DEFAULT NULL,
  `scientific_discussion` text DEFAULT NULL,
  `annotation_status` enum('draft','reviewed','approved') NOT NULL DEFAULT 'draft',
  `reviewed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `annotations`
  ADD PRIMARY KEY (`annotation_id`),
  ADD UNIQUE KEY `uq_annotation_source` (`source_id`);

ALTER TABLE `annotations`
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `annotations`
  ADD CONSTRAINT `fk_annotations_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

```

### Tabelle `assumptions`

```sql
CREATE TABLE `assumptions` (
  `assumption_id` bigint(20) UNSIGNED NOT NULL,
  `assumption_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `assumption_text` longtext NOT NULL,
  `formal_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `derivation_from_research_gap` longtext DEFAULT NULL,
  `status` enum('proposed','accepted','rejected','superseded') NOT NULL DEFAULT 'proposed',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `assumptions`
  ADD PRIMARY KEY (`assumption_id`),
  ADD UNIQUE KEY `uq_assumption_number` (`assumption_number`),
  ADD KEY `fk_assumptions_section` (`section_id`),
  ADD KEY `fk_assumptions_revision` (`created_revision_id`);

ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `assumptions`
  ADD CONSTRAINT `fk_assumptions_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_assumptions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`);

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

ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`),
  ADD UNIQUE KEY `uq_authors_normalized_name` (`normalized_name`);

ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

```

### Tabelle `axioms`

```sql
CREATE TABLE `axioms` (
  `axiom_id` bigint(20) UNSIGNED NOT NULL,
  `axiom_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `axiom_text` longtext NOT NULL,
  `formal_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `motivation` longtext DEFAULT NULL,
  `independence_note` longtext DEFAULT NULL,
  `consistency_note` longtext DEFAULT NULL,
  `operationalization_note` longtext DEFAULT NULL,
  `source_assumption_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('draft','review','accepted','revised','rejected') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `axioms`
  ADD PRIMARY KEY (`axiom_id`),
  ADD UNIQUE KEY `uq_axiom_number` (`axiom_number`),
  ADD KEY `fk_axioms_section` (`section_id`),
  ADD KEY `fk_axioms_assumption` (`source_assumption_id`),
  ADD KEY `fk_axioms_revision` (`created_revision_id`);

ALTER TABLE `axioms`
  MODIFY `axiom_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `axioms`
  ADD CONSTRAINT `fk_axioms_assumption` FOREIGN KEY (`source_assumption_id`) REFERENCES `assumptions` (`assumption_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_axioms_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_axioms_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`);

```

### Tabelle `axiom_dependencies`

```sql
CREATE TABLE `axiom_dependencies` (
  `axiom_dependency_id` bigint(20) UNSIGNED NOT NULL,
  `axiom_id` bigint(20) UNSIGNED NOT NULL,
  `depends_on_axiom_id` bigint(20) UNSIGNED NOT NULL,
  `dependency_type` enum('depends_on','extends','specializes','contrasts','independent_of') NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `axiom_dependencies`
  ADD PRIMARY KEY (`axiom_dependency_id`),
  ADD UNIQUE KEY `uq_axiom_dependency` (`axiom_id`,`depends_on_axiom_id`,`dependency_type`),
  ADD KEY `fk_axiom_dependencies_parent` (`depends_on_axiom_id`);

ALTER TABLE `axiom_dependencies`
  MODIFY `axiom_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `axiom_dependencies`
  ADD CONSTRAINT `fk_axiom_dependencies_axiom` FOREIGN KEY (`axiom_id`) REFERENCES `axioms` (`axiom_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_axiom_dependencies_parent` FOREIGN KEY (`depends_on_axiom_id`) REFERENCES `axioms` (`axiom_id`) ON DELETE CASCADE;

```

### Tabelle `citation_corrections`

```sql
CREATE TABLE `citation_corrections` (
  `correction_id` bigint(20) UNSIGNED NOT NULL,
  `old_citation_label` varchar(50) NOT NULL,
  `corrected_citation_label` varchar(50) NOT NULL,
  `section_code` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `revision_id` bigint(20) UNSIGNED DEFAULT NULL,
  `corrected_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `citation_corrections`
  ADD PRIMARY KEY (`correction_id`),
  ADD UNIQUE KEY `uq_citation_correction` (`old_citation_label`,`section_code`),
  ADD KEY `fk_citation_correction_revision` (`revision_id`);

ALTER TABLE `citation_corrections`
  MODIFY `correction_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `citation_corrections`
  ADD CONSTRAINT `fk_citation_correction_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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

ALTER TABLE `corollaries`
  ADD PRIMARY KEY (`corollary_id`),
  ADD UNIQUE KEY `uq_corollary_number` (`corollary_number`),
  ADD KEY `fk_corollaries_section` (`section_id`),
  ADD KEY `fk_corollaries_theorem` (`parent_theorem_id`),
  ADD KEY `fk_corollaries_lemma` (`parent_lemma_id`),
  ADD KEY `fk_corollaries_source` (`source_id`),
  ADD KEY `fk_corollaries_revision` (`created_revision_id`);

ALTER TABLE `corollaries`
  MODIFY `corollary_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `corollaries`
  ADD CONSTRAINT `fk_corollaries_lemma` FOREIGN KEY (`parent_lemma_id`) REFERENCES `lemmas` (`lemma_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_corollaries_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_corollaries_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_corollaries_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_corollaries_theorem` FOREIGN KEY (`parent_theorem_id`) REFERENCES `theorems` (`theorem_id`) ON DELETE SET NULL;

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

ALTER TABLE `definitions`
  ADD PRIMARY KEY (`definition_id`),
  ADD UNIQUE KEY `uq_definition_number` (`definition_number`),
  ADD KEY `fk_definitions_section` (`section_id`),
  ADD KEY `fk_definitions_source` (`source_id`),
  ADD KEY `fk_definitions_revision` (`created_revision_id`),
  ADD KEY `idx_definitions_section` (`section_id`);

ALTER TABLE `definitions`
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=466;

ALTER TABLE `definitions`
  ADD CONSTRAINT `fk_definitions_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_definitions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_definitions_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

```

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

ALTER TABLE `dissertation_sections`
  ADD PRIMARY KEY (`section_id`),
  ADD UNIQUE KEY `uq_section_code` (`section_code`),
  ADD KEY `fk_sections_parent` (`parent_section_id`);

ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

ALTER TABLE `dissertation_sections`
  ADD CONSTRAINT `fk_sections_parent` FOREIGN KEY (`parent_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL ON UPDATE CASCADE;

```

### Tabelle `dissertation_tables`

```sql
CREATE TABLE `dissertation_tables` (
  `table_id` bigint(20) UNSIGNED NOT NULL,
  `table_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `caption` longtext DEFAULT NULL,
  `table_schema_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`table_schema_json`)),
  `table_data_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`table_data_json`)),
  `file_name` varchar(500) DEFAULT NULL,
  `file_path` varchar(1500) DEFAULT NULL,
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'original',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generation_method` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `dissertation_tables`
  ADD PRIMARY KEY (`table_id`),
  ADD UNIQUE KEY `uq_table_number` (`table_number`),
  ADD KEY `fk_tables_section` (`section_id`),
  ADD KEY `fk_tables_source` (`source_id`),
  ADD KEY `fk_tables_revision` (`created_revision_id`);

ALTER TABLE `dissertation_tables`
  MODIFY `table_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

ALTER TABLE `dissertation_tables`
  ADD CONSTRAINT `fk_tables_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tables_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_tables_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

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

ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD UNIQUE KEY `uq_documents_file_version` (`file_name`,`version_label`);

ALTER TABLE `documents`
  MODIFY `document_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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

ALTER TABLE `equations`
  ADD PRIMARY KEY (`equation_id`),
  ADD UNIQUE KEY `uq_equation_number` (`equation_number`),
  ADD KEY `fk_equations_section` (`section_id`),
  ADD KEY `fk_equations_source` (`source_id`),
  ADD KEY `idx_equations_revision` (`created_revision_id`),
  ADD KEY `idx_equations_section_number` (`section_id`,`equation_number`);

ALTER TABLE `equations`
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3519;

ALTER TABLE `equations`
  ADD CONSTRAINT `fk_equations_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equations_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equations_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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

ALTER TABLE `equation_dependencies`
  ADD PRIMARY KEY (`dependency_id`),
  ADD UNIQUE KEY `uq_equation_dependency` (`equation_id`,`depends_on_equation_id`,`dependency_type`),
  ADD KEY `fk_equation_dependencies_parent` (`depends_on_equation_id`);

ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `equation_dependencies`
  ADD CONSTRAINT `fk_equation_dependencies_equation` FOREIGN KEY (`equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equation_dependencies_parent` FOREIGN KEY (`depends_on_equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

ALTER TABLE `equation_symbols`
  ADD PRIMARY KEY (`equation_symbol_id`),
  ADD UNIQUE KEY `uq_equation_symbol` (`equation_id`,`symbol_latex`);

ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `equation_symbols`
  ADD CONSTRAINT `fk_equation_symbols_equation` FOREIGN KEY (`equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE CASCADE ON UPDATE CASCADE;

```

### Tabelle `figures`

```sql
CREATE TABLE `figures` (
  `figure_id` bigint(20) UNSIGNED NOT NULL,
  `figure_number` varchar(50) NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `caption` longtext NOT NULL,
  `file_name` varchar(500) DEFAULT NULL,
  `file_path` varchar(1500) DEFAULT NULL,
  `alt_text` longtext DEFAULT NULL,
  `figure_type` enum('diagram','plot','photograph','schema','flowchart','network','other') NOT NULL DEFAULT 'other',
  `provenance` enum('original','adapted','literature') NOT NULL DEFAULT 'original',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generation_method` text DEFAULT NULL,
  `data_reference` text DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `figures`
  ADD PRIMARY KEY (`figure_id`),
  ADD UNIQUE KEY `uq_figure_number` (`figure_number`),
  ADD KEY `fk_figures_section` (`section_id`),
  ADD KEY `fk_figures_source` (`source_id`),
  ADD KEY `fk_figures_revision` (`created_revision_id`);

ALTER TABLE `figures`
  MODIFY `figure_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `figures`
  ADD CONSTRAINT `fk_figures_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_figures_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_figures_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

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

ALTER TABLE `lemmas`
  ADD PRIMARY KEY (`lemma_id`),
  ADD UNIQUE KEY `uq_lemma_number` (`lemma_number`),
  ADD KEY `fk_lemmas_section` (`section_id`),
  ADD KEY `fk_lemmas_source` (`source_id`),
  ADD KEY `fk_lemmas_revision` (`created_revision_id`);

ALTER TABLE `lemmas`
  MODIFY `lemma_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `lemmas`
  ADD CONSTRAINT `fk_lemmas_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_lemmas_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_lemmas_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

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

ALTER TABLE `object_dependencies`
  ADD PRIMARY KEY (`object_dependency_id`),
  ADD UNIQUE KEY `uq_object_dependency` (`object_type_from`,`object_id_from`,`object_type_to`,`object_id_to`,`dependency_type`);

ALTER TABLE `object_dependencies`
  MODIFY `object_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1057;

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

ALTER TABLE `object_source_links`
  ADD PRIMARY KEY (`object_source_link_id`),
  ADD UNIQUE KEY `uq_object_source` (`object_type`,`object_id`,`source_id`,`usage_type`),
  ADD KEY `fk_object_source_source` (`source_id`);

ALTER TABLE `object_source_links`
  MODIFY `object_source_link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2639;

ALTER TABLE `object_source_links`
  ADD CONSTRAINT `fk_object_source_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE;

```

### Tabelle `pending_sources`

```sql
CREATE TABLE `pending_sources` (
  `pending_source_id` bigint(20) UNSIGNED NOT NULL,
  `proposed_source_key` varchar(150) DEFAULT NULL,
  `title` varchar(1000) NOT NULL,
  `authors_text` varchar(1000) DEFAULT NULL,
  `year_text` varchar(50) DEFAULT NULL,
  `publication_text` varchar(1000) DEFAULT NULL,
  `doi_or_url` varchar(1500) DEFAULT NULL,
  `proposed_section_code` varchar(50) DEFAULT NULL,
  `discovery_context` text NOT NULL,
  `proposed_claim` text DEFAULT NULL,
  `priority` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `review_status` enum('open','in_review','accepted','rejected','merged') NOT NULL DEFAULT 'open',
  `merged_source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `discovered_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` datetime DEFAULT NULL,
  `review_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `pending_sources`
  ADD PRIMARY KEY (`pending_source_id`),
  ADD KEY `fk_pending_merged_source` (`merged_source_id`);

ALTER TABLE `pending_sources`
  MODIFY `pending_source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pending_sources`
  ADD CONSTRAINT `fk_pending_merged_source` FOREIGN KEY (`merged_source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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

ALTER TABLE `proofs`
  ADD PRIMARY KEY (`proof_id`),
  ADD KEY `fk_proofs_section` (`section_id`),
  ADD KEY `fk_proofs_theorem` (`theorem_id`),
  ADD KEY `fk_proofs_lemma` (`lemma_id`),
  ADD KEY `fk_proofs_corollary` (`corollary_id`),
  ADD KEY `fk_proofs_source` (`source_id`),
  ADD KEY `fk_proofs_revision` (`created_revision_id`),
  ADD KEY `idx_proofs_section_status` (`section_id`,`validation_status`);

ALTER TABLE `proofs`
  MODIFY `proof_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

ALTER TABLE `proofs`
  ADD CONSTRAINT `fk_proofs_corollary` FOREIGN KEY (`corollary_id`) REFERENCES `corollaries` (`corollary_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_proofs_lemma` FOREIGN KEY (`lemma_id`) REFERENCES `lemmas` (`lemma_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_proofs_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_proofs_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_proofs_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_proofs_theorem` FOREIGN KEY (`theorem_id`) REFERENCES `theorems` (`theorem_id`) ON DELETE CASCADE;

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

ALTER TABLE `propositions`
  ADD PRIMARY KEY (`proposition_id`),
  ADD UNIQUE KEY `uq_proposition_number` (`proposition_number`),
  ADD KEY `fk_propositions_section` (`section_id`),
  ADD KEY `fk_propositions_revision` (`created_revision_id`);

ALTER TABLE `propositions`
  MODIFY `proposition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

ALTER TABLE `propositions`
  ADD CONSTRAINT `fk_propositions_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_propositions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`);

```

### Tabelle `proposition_dependencies`

```sql
CREATE TABLE `proposition_dependencies` (
  `proposition_dependency_id` bigint(20) UNSIGNED NOT NULL,
  `proposition_id` bigint(20) UNSIGNED NOT NULL,
  `axiom_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assumption_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dependency_type` enum('derived_from','uses','motivated_by','contrasts') NOT NULL DEFAULT 'derived_from',
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `proposition_dependencies`
  ADD PRIMARY KEY (`proposition_dependency_id`),
  ADD UNIQUE KEY `uq_prop_dependency` (`proposition_id`,`axiom_id`,`assumption_id`,`dependency_type`),
  ADD KEY `fk_prop_dep_axiom` (`axiom_id`),
  ADD KEY `fk_prop_dep_assumption` (`assumption_id`);

ALTER TABLE `proposition_dependencies`
  MODIFY `proposition_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

ALTER TABLE `proposition_dependencies`
  ADD CONSTRAINT `fk_prop_dep_assumption` FOREIGN KEY (`assumption_id`) REFERENCES `assumptions` (`assumption_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_prop_dep_axiom` FOREIGN KEY (`axiom_id`) REFERENCES `axioms` (`axiom_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prop_dep_proposition` FOREIGN KEY (`proposition_id`) REFERENCES `propositions` (`proposition_id`) ON DELETE CASCADE;

```

### Tabelle `repository_counters`

```sql
CREATE TABLE `repository_counters` (
  `counter_key` varchar(100) NOT NULL,
  `counter_value` varchar(100) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `repository_counters`
  ADD PRIMARY KEY (`counter_key`);

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

ALTER TABLE `repository_revisions`
  ADD PRIMARY KEY (`revision_id`),
  ADD UNIQUE KEY `uq_revision_code` (`revision_code`),
  ADD KEY `fk_revision_parent` (`parent_revision_id`);

ALTER TABLE `repository_revisions`
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

ALTER TABLE `repository_revisions`
  ADD CONSTRAINT `fk_revision_parent` FOREIGN KEY (`parent_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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

ALTER TABLE `repository_validation_results`
  ADD PRIMARY KEY (`validation_result_id`),
  ADD UNIQUE KEY `uq_validation_revision_code` (`revision_id`,`validation_code`),
  ADD KEY `idx_validation_revision` (`revision_id`);

ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=882;

ALTER TABLE `repository_validation_results`
  ADD CONSTRAINT `fk_validation_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE CASCADE ON UPDATE CASCADE;

```

### Tabelle `section_change_log`

```sql
CREATE TABLE `section_change_log` (
  `change_id` bigint(20) UNSIGNED NOT NULL,
  `revision_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `change_type` enum('created','rewritten','edited','renumbered','source_added','source_reused','equation_added','equation_changed','definition_added','statement_added','proof_added','assumption_added','axiom_added','proposition_added','figure_added','table_added','symbol_added','acronym_added','status_changed','other') NOT NULL,
  `object_type` varchar(100) DEFAULT NULL,
  `object_reference` varchar(255) DEFAULT NULL,
  `change_summary` text NOT NULL,
  `previous_value` longtext DEFAULT NULL,
  `new_value` longtext DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `section_change_log`
  ADD PRIMARY KEY (`change_id`),
  ADD KEY `idx_change_revision` (`revision_id`),
  ADD KEY `idx_change_section` (`section_id`);

ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=681;

ALTER TABLE `section_change_log`
  ADD CONSTRAINT `fk_change_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_change_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

ALTER TABLE `sources`
  ADD PRIMARY KEY (`source_id`),
  ADD UNIQUE KEY `uq_sources_source_key` (`source_key`),
  ADD UNIQUE KEY `uq_sources_citation_number` (`citation_number`),
  ADD KEY `idx_sources_title` (`title`(191)),
  ADD KEY `idx_sources_year` (`year_original`),
  ADD KEY `idx_sources_priority` (`priority`),
  ADD KEY `idx_sources_frzk_relevance` (`frzk_relevance`),
  ADD KEY `idx_sources_revision` (`created_revision_id`);

ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

ALTER TABLE `sources`
  ADD CONSTRAINT `fk_sources_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE;

```

### Tabelle `source_authors`

```sql
CREATE TABLE `source_authors` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `author_order` smallint(5) UNSIGNED NOT NULL,
  `role` enum('author','editor','translator') NOT NULL DEFAULT 'author'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `source_authors`
  ADD PRIMARY KEY (`source_id`,`author_id`,`role`),
  ADD UNIQUE KEY `uq_source_author_order` (`source_id`,`role`,`author_order`),
  ADD KEY `fk_source_authors_author` (`author_id`);

ALTER TABLE `source_authors`
  ADD CONSTRAINT `fk_source_authors_author` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_authors_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

```

### Tabelle `source_relations`

```sql
CREATE TABLE `source_relations` (
  `relation_id` bigint(20) UNSIGNED NOT NULL,
  `source_id_from` bigint(20) UNSIGNED NOT NULL,
  `source_id_to` bigint(20) UNSIGNED NOT NULL,
  `relation_type` enum('extends','criticizes','formalizes','applies','reviews','historical_predecessor','alternative_to','supports','contradicts','related') NOT NULL,
  `relation_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `source_relations`
  ADD PRIMARY KEY (`relation_id`),
  ADD UNIQUE KEY `uq_source_relation` (`source_id_from`,`source_id_to`,`relation_type`),
  ADD KEY `fk_source_relations_to` (`source_id_to`);

ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `source_relations`
  ADD CONSTRAINT `fk_source_relations_from` FOREIGN KEY (`source_id_from`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_relations_to` FOREIGN KEY (`source_id_to`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

```

### Tabelle `source_topics`

```sql
CREATE TABLE `source_topics` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED NOT NULL,
  `relevance` tinyint(3) UNSIGNED NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `source_topics`
  ADD PRIMARY KEY (`source_id`,`topic_id`),
  ADD KEY `fk_source_topics_topic` (`topic_id`);

ALTER TABLE `source_topics`
  ADD CONSTRAINT `fk_source_topics_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_topics_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

ALTER TABLE `source_usage`
  ADD PRIMARY KEY (`usage_id`),
  ADD KEY `idx_usage_section` (`section_id`),
  ADD KEY `idx_usage_source` (`source_id`),
  ADD KEY `idx_source_usage_revision` (`created_revision_id`),
  ADD KEY `idx_source_usage_section_source` (`section_id`,`source_id`);

ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=278;

ALTER TABLE `source_usage`
  ADD CONSTRAINT `fk_source_usage_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_usage_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_usage_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

ALTER TABLE `symbols`
  ADD PRIMARY KEY (`symbol_id`),
  ADD UNIQUE KEY `uq_symbol_scope` (`symbol_latex`,`scope_type`,`first_section_id`),
  ADD KEY `fk_symbols_section` (`first_section_id`),
  ADD KEY `fk_symbols_equation` (`first_equation_id`),
  ADD KEY `fk_symbols_revision` (`created_revision_id`);

ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `symbols`
  ADD CONSTRAINT `fk_symbols_equation` FOREIGN KEY (`first_equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_symbols_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_symbols_section` FOREIGN KEY (`first_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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

ALTER TABLE `theorems`
  ADD PRIMARY KEY (`theorem_id`),
  ADD UNIQUE KEY `uq_theorem_number` (`theorem_number`),
  ADD KEY `fk_theorems_section` (`section_id`),
  ADD KEY `fk_theorems_source` (`source_id`),
  ADD KEY `fk_theorems_revision` (`created_revision_id`);

ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

ALTER TABLE `theorems`
  ADD CONSTRAINT `fk_theorems_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_theorems_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_theorems_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

```

### Tabelle `topics`

```sql
CREATE TABLE `topics` (
  `topic_id` bigint(20) UNSIGNED NOT NULL,
  `parent_topic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `topic_code` varchar(100) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `topics`
  ADD PRIMARY KEY (`topic_id`),
  ADD UNIQUE KEY `uq_topic_code` (`topic_code`),
  ADD KEY `fk_topics_parent` (`parent_topic_id`);

ALTER TABLE `topics`
  MODIFY `topic_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `topics`
  ADD CONSTRAINT `fk_topics_parent` FOREIGN KEY (`parent_topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;

```


---

# 17. Start-Gate für Kapitel 3.7

Vor dem Schreiben von 3.7.0 sind mindestens folgende Punkte abzuarbeiten:

| Gate | Prüffrage | Status vor Start |
|---|---|---|
| G0.1 | Übergabe-Gate 3.6→3.7 erfolgreich? | PENDING |
| G0.2 | neuer Enddump Ende 3.6 vorhanden? | PENDING |
| G0.3 | SHA-256 des Enddumps dokumentiert? | PENDING |
| G0.4 | reales Schema aus Enddump Ende 3.6 geprüft? | PENDING |
| G0.5 | wissenschaftliche Funktion von 3.7 bestimmt? | PENDING |
| G0.6 | offizieller Titel von 3.7 bestimmt? | PENDING |
| G0.7 | Nicht-Redefinitionsprüfung gegen 3.2–3.6 abgeschlossen? | PENDING |
| G0.8 | Abgrenzung zu Kapitel 6 geklärt? | PENDING |
| G0.9 | Literaturbedarf geprüft und verifiziert? | PENDING |
| G0.10 | Primäraxiomrisiko geprüft? | PENDING |
| G0.11 | persönliche Ich-Form und Schreibstil als verbindlich übernommen? | PENDING |
| G0.12 | Startmatrix 3.7 vollständig? | PENDING |
| G0.13 | Startfreigabe 3.7.0 | PENDING |

**Der Titel und die genaue wissenschaftliche Funktion von Kapitel 3.7 werden in dieser Übergabe bewusst nicht erfunden.** Sie sind durch Analyse des tatsächlichen Gesamtstands 3.1–3.6 und der Dissertationsarchitektur zu bestimmen.

---

# 18. Empfohlene Startmatrix für 3.7

Für jedes geplante Objekt von 3.7 sind vor dem Schreiben mindestens folgende Felder zu prüfen:

| Feld | Verpflichtende Frage |
|---|---|
| Objekt / Arbeitstitel | Was soll neu eingeführt oder abgeleitet werden? |
| Ausgangsobjekt | Auf welcher Definition / Proposition / welchem Satz aus 3.2–3.6 baut es auf? |
| Nicht-Redefinitionsprüfung | Existiert der Begriff bereits? |
| Aussageart | Definition, Proposition, Satz, Korollar, Modellannahme, Interpretation, Analogie, empirischer Befund? |
| Erweiterungstyp | `def`, `model`, `bridge` oder `primary`? |
| Geltungsrang | Welcher Rang wird geerbt? |
| Abhängigkeiten | Welche Definitionen/Modelle/Brücken werden tatsächlich verwendet? |
| Universalität | Ist die Aussage wirklich universell? |
| Unterbestimmtheit | Gibt es alternative zulässige Rekonstruktionen? |
| Identifizierbarkeit | Ist die relevante Struktur beobachtungs- oder modellrelativ eindeutig? |
| Beobachtungsbedarf | Wird eine Struktur aus 3.6 benötigt? |
| Messbedarf | Wird ein Messkontext benötigt? |
| Unsicherheitsbedarf | Ist Messunsicherheit relevant? |
| Dynamikbedarf | Wird Definition 3.5.13 / 3.6.8 benötigt? |
| Statistikbedarf | Wird Definition 3.6.9 benötigt? |
| Zertifikatsbedarf | Muss ein Beobachtungszertifikat entstehen? |
| Literaturbedarf | Welche externe Aussage muss real belegt werden? |
| Primäraxiomrisiko | Droht eine unzulässige Erweiterung des Kerns? |
| Anwendungsrisiko | Gehört der Inhalt eigentlich nach Kapitel 6? |
| Eigenleistung | Welche originäre Leistung dieser Arbeit liegt vor? |
| Repository-Ziel | Welche realen Tabellen/Spalten werden benötigt? |
| Entscheidung | neu / wiederverwenden / spezialisieren / verschieben / verwerfen |

---

# 19. Verbindliche Arbeitsweise in der nächsten Sitzung

Für eine neue 3.7-Sitzung gilt folgende Reihenfolge:

1. Diese Übergabe vollständig lesen.
2. Neuen Enddump Ende 3.6 als reale DB-Referenz prüfen.
3. Schreibstil-Dateien lesen.
4. Kapitel 3.1–3.6 und vorhandene Architektur analysieren.
5. Wissenschaftliche Funktion und Titel von 3.7 bestimmen.
6. Startmatrix 3.7 ausfüllen.
7. Primäraxiom- und Nicht-Redefinitionsgate durchführen.
8. Erst dann 3.7.0 schreiben.
9. Vollständigen Text direkt im normalen Chat ausgeben.
10. Nach abgeschlossenem Abschnitt das Repository-/SQL-Skript als Download-Datei erstellen.
11. SQL vor Ausgabe gegen das reale Schema prüfen.
12. Erst danach mit dem nächsten Unterabschnitt fortfahren.

---

# 20. Kompakter Startprompt für Kapitel 3.7

> Prüfe zuerst das technische Gate 3.6→3.7 und den tatsächlichen neuen Enddump Ende 3.6. Verwende die Übergabe 3.6→3.7 als verbindliche wissenschaftliche, stilistische und repository-seitige Grundlage. Analysiere anschließend die finalen Kapitel 3.1–3.6 und bestimme die wissenschaftlich notwendige Funktion sowie den offiziellen Titel von Kapitel 3.7, ohne Inhalte oder Begriffe zu erfinden, die aus dem vorhandenen Stand nicht folgen. Führe vor jeder neuen Definition eine Nicht-Redefinitionsprüfung gegen 3.2–3.6 durch und schütze den universellen Ein-Axiom-Kern {PA 3.3.1}. Konkrete Anwendungen bleiben Kapitel 6 vorbehalten. Schreibe Dissertationstext überwiegend in meiner persönlichen wissenschaftlichen Ich-Form, in zusammenhängenden logisch entwickelten Absätzen und ohne Häufung alleinstehender kurzer Sätze. Jede originäre FRZK-Leistung ist ausdrücklich als „Eigenleistung dieser Arbeit.“ zu kennzeichnen. Mathematische Bestandteile im Fließtext erscheinen ausschließlich geklammert als Word-LaTeX; jede eigenständig gesetzte Formel erhält unmittelbar darunter eine Word-LaTeX-Zeile. Im Dissertationstext dürfen keine Weblinks erscheinen; verwendete Literatur ist als genaue bibliografische Quelle in runden Klammern anzugeben. Repository-Skripte dürfen nur auf dem tatsächlichen Enddump-Schema beruhen, müssen utf8mb4_unicode_ci, reale ENUM-Werte, Transaktionen, Rollback-Handler, Pre-/Post-Gates und Validierungen beachten und werden ausschließlich als Download-Datei ausgegeben. Beginne 3.7.0 erst nach vollständig bestandenem Gate und ausgefüllter Startmatrix.

---

# 21. Übergabe-Freigabe

Die Übergabe von 3.6 nach 3.7 ist wissenschaftlich vorbereitet. Technisch wird sie erst freigegeben, wenn:

- `frzk_rkb_3.6.10_kapitelabschluss_v1.sql` erfolgreich importiert wurde,
- `frzk_rkb_gate_3.6_zu_3.7_v1.sql` vollständig PASS liefert,
- die Counter auf `3.7.0 / 3.6.10 / 3.6 / 105 / 106` stehen,
- ein neuer vollständiger Enddump Ende 3.6 exportiert wurde,
- dessen SHA-256 dokumentiert wurde,
- dieser neue Enddump als verbindliche Schema- und Inhaltsreferenz für 3.7 übernommen wurde.

Erst dann lautet der technische Übergabestatus:

**PASS – Kapitel 3.7.0 darf begonnen werden.**
