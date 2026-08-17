# FRZK – vollständiges Übergabedokument Kapitel 3.2 → Kapitel 3.3

**Projekt:** Neuaufsatz Kapitel 3 / Funktionales Raum-Zeit-Kohärenzsystem (FRZK)  
**Übergang:** Kapitel 3.2 „Mathematische Grundlagen“ → Kapitel 3.3 „Entwicklung der axiomatischen Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems“  
**Stand:** Abschluss 3.2.31  
**Verbindliches Leitprinzip für Kapitel 3.3:** **Universalität**  
**Nächster inhaltlicher Abschnitt:** **3.3.0 Axiomatischer Ausgangspunkt und Abgrenzung von Definition, Primäraxiom und Ableitung**  
**Danach:** **3.3.1 Wissenschaftliche Lückenanalyse und Anforderungen an eine universelle FRZK-Axiomatik**

---

## 0. Zweck dieses Übergabedokuments

Dieses Dokument ist die vollständige Arbeits- und Übergabegrundlage für einen neuen Chat, der Kapitel 3.3 neu entwickelt. Es soll verhindern, dass beim Übergang aus dem abgeschlossenen mathematischen Kapitel 3.2 Begriffe, Nummerierungsstände, Literaturregeln, Repository-Zustände, methodische Schranken oder bereits geklärte Unterscheidungen verloren gehen.

Kapitel 3.3 darf **nicht** als Fortsetzung einer konkreten Anwendung oder eines einzelnen geometrischen Spezialfalls formuliert werden. Es entwickelt eine **universelle FRZK-Axiomatik**, deren Grundobjekte, Primäraxiome und Ableitungsregeln unabhängig von einer einzelnen Versuchsanordnung, einer bestimmten Objektzahl, einer besonderen Geometrie oder einer einzelnen späteren Anwendung gültig sein müssen.

Das gleichseitige Dreieck, eine mögliche Informationsdimension oder die Position eines zusätzlichen Objektes sind deshalb **nur einzelne Prüf- und Anwendungsfälle unter vielen**. Sie dürfen die Axiomatik nicht vorstrukturieren. Ein universeller FRZK-Kern muss ebenso auf Systeme mit zwei, drei, vier oder beliebig vielen Komponenten, kontinuierliche Felder, Netzwerke, geometrische und nichtgeometrische Zustandsräume, deterministische und stochastische Dynamiken sowie symmetrische und asymmetrische Situationen anwendbar beziehungsweise sauber abgrenzbar sein.

---

# 1. Verbindliche Leitidee für Kapitel 3.3: Universalität

## 1.1 Universeller statt anwendungsspezifischer Axiomkern

Die Primäraxiomatik von Kapitel 3.3 darf insbesondere **nicht** auf folgende Spezialfälle zugeschnitten werden:

- ein gleichseitiges Dreieck,
- genau drei Knoten oder drei Komponenten,
- eine Lampe oder einen bestimmten zusätzlichen Punkt,
- eine konkrete Patent- oder Versuchsanordnung,
- euklidische Geometrie als stillschweigende Voraussetzung,
- eine bestimmte Dimension des Zustands- oder Raumzeitraums,
- eine konkrete Informationsgröße,
- eine bestimmte Kopplungsmatrix,
- einen speziellen Markov-Prozess,
- eine spezielle Symmetriegruppe,
- eine bestimmte physikalische Skala.

Solche Strukturen dürfen erst als **Spezialfall, Modellrealisierung, Korollar, Anwendung oder Falsifikationstest** auftreten, nachdem der universelle Kern formuliert wurde.

## 1.2 Universality Gates für jedes Primäraxiom

Bevor eine Aussage in 3.3 als Primäraxiom akzeptiert wird, ist sie gegen mindestens folgende Kriterien zu prüfen:

1. **Objektzahl-Unabhängigkeit:** Ist die Aussage nicht unnötig auf \(N=3\) oder eine andere feste Komponentenanzahl beschränkt?
2. **Anwendungsneutralität:** Enthält sie keine Begriffe einer konkreten technischen Anwendung, sofern diese nicht selbst fundamental sind?
3. **Darstellungsneutralität:** Hängt sie nicht von einer bestimmten Matrix-, Graph-, Koordinaten- oder Bilddarstellung ab?
4. **Koordinaten-/Isomorphieprinzip:** Bleibt der physikalische Inhalt unter zulässigen Umbenennungen, Koordinatenwechseln oder strukturerhaltenden Abbildungen erhalten?
5. **Geometrieneutralität:** Wird euklidische, riemannsche, lorentzsche oder andere Geometrie nur dort vorausgesetzt, wo sie ausdrücklich zum Theorieinhalt gehört?
6. **Dimensionsneutralität:** Wird die Dimension nicht aus Anzahl von Variablen, Komponenten, Knoten, Matrixzeilen oder Observablen erschlichen?
7. **Skalenneutralität:** Ist klar, ob die Aussage fundamental, effektiv oder nur in einem bestimmten Regime gültig sein soll?
8. **Nichtzirkularität:** Enthält das Axiom nicht bereits das Resultat, das später als FRZK-Folge bewiesen werden soll?
9. **Ableitungsminimalität:** Kann die Aussage aus allgemeineren Axiomen folgen? Falls ja, darf sie nicht zusätzlich Primäraxiom werden.
10. **Operationalisierbarkeit:** Ist zumindest prinzipiell klar, wie die Aussage mathematisch oder empirisch überprüft werden könnte?
11. **Grenzfallrobustheit:** Sind \(N=1\), \(N=2\), große \(N\), gekoppelte/entkoppelte und symmetrische/asymmetrische Fälle berücksichtigt?
12. **Modelltrennung:** Ist erkennbar, was reine Mathematik, was FRZK-Eigenannahme und was physikalische Interpretation ist?

**Verbindlicher Grundsatz:** Ein Spezialfall darf die universelle Theorie testen, aber nicht rückwirkend deren Axiome diktieren.

---

# 2. Ausgangspunkt aus Kapitel 3.1

Der Repository-Stand vor dem Neuaufbau von 3.2 ist:

`frzk_rkb_stand_ende_3.1.sql`

Dieser Dump ist die verbindliche technische Schema-Referenz für den Neuaufbau 3.2 und den Start von 3.3. Sämtliche 3.2-Skripte wurden gegen dieses reale Schema erzeugt.

Im Dump ist als übergeordnete Forschungslücke aus 3.1.7 dokumentiert:

> Fehlende Rekonstruktion einer minimalen funktionalen Organisation, aus der Zustände, Relationen, Transformationen und geordnete Strukturen hervorgehen können.

Diese Forschungslücke ist für 3.3 zentral. Kapitel 3.3 darf sie nicht durch eine Sammlung beliebiger Spezialaxiome ersetzen. Ziel ist eine **minimale, universelle funktionale Organisation**, aus der möglichst viele Strukturen abgeleitet werden können.

---

# 3. Verbindliche Manuskript- und Schreibregeln

## 3.1 Stil

- Dissertationstext grundsätzlich in **Ich-Form**.
- Zusammenhängende, logisch verbundene Absätze.
- Keine Häufung alleinstehender kurzer Sätze.
- Einzelne isolierte Sätze nur für wirklich zentrale Merksätze oder methodische Kernaussagen.
- Wissenschaftlich präzise, aber nicht unnötig bürokratisch.
- Keine Metaformulierungen über alte Fassungen.
- Verboten sind insbesondere Formulierungen wie:
  - „im Original“,
  - „in der alten Fassung“,
  - „der bisherige Abschnitt“,
  - „gegenüber der vorherigen Version“.
- Jeder neu geschriebene Abschnitt wird formuliert, als existiere kein früherer Text.

## 3.2 Ausgabe

- Jeder vollständige Abschnitt erscheint **vollständig direkt im Chat**.
- Dateien dürfen nur zusätzlich bereitgestellt werden und ersetzen niemals die vollständige Chat-Ausgabe.
- Gleichungen müssen im Chat sichtbar gerendert sein.

## 3.3 Formeln und Word-LaTeX

Aktiver Arbeitsstandard:

1. gerenderte Formel,
2. **unmittelbar danach** die Zeile `Word-LaTeX: ...`,
3. erst danach weiterer Fließtext.

Zwischen Formel und Word-LaTeX darf kein erklärender Text stehen. Diese Regel gilt für nummerierte und unnummerierte Displayformeln.

Für reine Größenbestandteile sollen nicht unnötig eigene nummerierte Gleichungen erzeugt werden. Nummeriert wird die mathematisch relevante Aussage.

## 3.4 Links

- Im Dissertationstext dürfen **keine Weblinks** erscheinen.
- Webrecherche dient der Verifikation.
- URLs können als Repository-Metadaten in `sources.url` gespeichert werden.
- Im wissenschaftlichen Fließtext werden ausschließlich Literaturziffern verwendet.

---

# 4. Literaturregeln

## 4.1 Zitationsprinzip

- Jede Quelle besitzt genau eine eindeutige Literaturzahl `[n]`.
- Bei der **ersten Nennung** einer neuen Quelle im Dissertationstext:
  - vollständige bibliografische Erstnennung,
  - unmittelbar mit `[n]`.
- Danach nur noch `[n]`.
- Bereits vorhandene Quelle: keine erneute bibliografische Vollnennung.

## 4.2 Fundstellen

- Fundstellen dürfen **niemals aus dem Dissertationstext abgeleitet oder geraten** werden.
- `exact_location` darf nur gesetzt werden, wenn die reale Literaturquelle beziehungsweise eine belastbare Primär-/Verlagsquelle die Fundstelle bestätigt.
- Ist keine belastbare Fundstelle verifiziert, bleibt `exact_location = NULL`.
- Neue Quellen müssen vor Aufnahme recherchiert und bibliografisch verifiziert werden.

## 4.3 Literaturstand nach 3.2.31

- `last_citation_number = 87`
- `next_citation_number = 88`
- Die **nächste neue Literaturquelle in Kapitel 3.3 erhält [88]**.

### In Kapitel 3.2 verwendete beziehungsweise wiederverwendete Literatur

**[6]** Halmos, Paul R. (1974): *Naive Set Theory*. New York: Springer-Verlag, insbesondere S. 1–12.  
Source key: `halmos_naive_set_theory_1974`

**[59]** Tarski, Alfred: *The Concept of Truth in Formalized Languages*. In: *Logic, Semantics, Metamathematics*. Oxford: Clarendon Press, 1956, S. 152–278.  
Source key: `tarski_truth_formalized_languages_1933_1956`

**[60]** Mac Lane, Saunders: *Mathematics: Form and Function*. New York: Springer, 1986.  
Source key: `mac_lane_mathematics_form_function_1986`

**[67]** Resnik, Michael D.: *Mathematics as a Science of Patterns*. Oxford: Clarendon Press, 1997.  
Source key: `resnik_mathematics_patterns_1997`

**[68]** Shapiro, Stewart: *Philosophy of Mathematics. Structure and Ontology*. New York: Oxford University Press, 1997.  
Source key: `shapiro_structure_ontology_1997`

**[71]** Enderton, Herbert B.: *Elements of Set Theory*. New York, San Francisco und London: Academic Press, 1977. ISBN 0-12-238440-7.  
Source key: `enderton_elements_set_theory_1977`  
Verifizierte Bereiche: Kap. 2 S. 17–34; Kap. 3 S. 35–64; Relation S. 40; Äquivalenzrelation S. 56; Partial Orderings Kap. 7 S. 167–170.

**[72]** Strang, Gilbert: *Introduction to Linear Algebra*. Fifth Edition. Wellesley, Massachusetts: Wellesley-Cambridge Press, 2016. ISBN 978-0-9802327-7-6.  
Source key: `strang_introduction_linear_algebra_5e_2016`  
Verifiziert: u. a. §1.1 ab S. 2; §3.1 S. 123–134; §3.4 ab S. 164; §9.1 ab S. 431.

**[73]** Conway, John B.: *A Course in Functional Analysis*. Second Edition. Graduate Texts in Mathematics 96. New York: Springer-Verlag, 1990. ISBN 978-0-387-97245-9.  
Source key: `conway_course_functional_analysis_2e_1990`  
Verifiziert: „Hilbert Spaces“, S. 1–25; „Banach Spaces“, S. 63–98; „Unbounded Operators“, S. 303–346.

**[74]** Munkres, James R.: *Topology*. Second Edition. Upper Saddle River, New Jersey: Prentice Hall, 2000. ISBN 0-13-181629-2.  
Source key: `munkres_topology_2e_2000`  
Verifiziert für 3.2: §§12, 13, 17, 18, 20, 21; keine ungesicherten Seitenzahlen.

**[75]** Rudin, Walter: *Principles of Mathematical Analysis*. Third Edition. New York: McGraw-Hill, 1976. ISBN 0-07-054235-X.  
Source key: `rudin_principles_mathematical_analysis_3e_1976`  
Verifiziert: Kapitel 5 „Differentiation“; Kapitel 9 „Functions of Several Variables“, insbesondere „Linear Transformations“, „Differentiation“, „Derivatives of Higher Order“.

**[76]** Teschl, Gerald: *Ordinary Differential Equations and Dynamical Systems*. Graduate Studies in Mathematics 140. Providence, Rhode Island: American Mathematical Society, 2012. ISBN 978-0-8218-8328-0.  
Source key: `teschl_ordinary_differential_equations_dynamical_systems_2012`

**[77]** Evans, Lawrence C.: *Partial Differential Equations*. Second Edition. Graduate Studies in Mathematics 19. Providence, Rhode Island: American Mathematical Society, 2010. ISBN 978-0-8218-4974-3.  
Source key: `evans_partial_differential_equations_2e_2010`  
Verifiziert: offizielles AMS-Kapitel 8 „The calculus of variations“.

**[78]** Lee, John M.: *Introduction to Smooth Manifolds*. Second Edition. Graduate Texts in Mathematics 218. New York: Springer, 2012. ISBN 978-1-4419-9981-8. DOI 10.1007/978-1-4419-9982-5.  
Source key: `lee_introduction_smooth_manifolds_2e_2012`  
Verifiziert: „Smooth Manifolds“ S. 1–31; „Smooth Maps“ S. 32–49; „Tangent Vectors“ S. 50–76; „Vector Bundles“ S. 249–271; „Riemannian Metrics“ S. 327–348.

**[79]** O’Neill, Barrett: *Semi-Riemannian Geometry With Applications to Relativity*. Pure and Applied Mathematics 103. Academic Press, 1983. ISBN 978-0-12-526740-3.  
Source key: `oneill_semi_riemannian_geometry_relativity_1983`  
Verifiziert: Chapter 3 S. 54–96; Chapter 5 S. 126–157; Chapter 10 „Calculus of Variations“ S. 263–299; Chapter 14 „Causality“ S. 401–440.

**[80]** Arnold, V. I.: *Mathematical Methods of Classical Mechanics*. Second Edition. Graduate Texts in Mathematics 60. New York: Springer-Verlag, 1989. DOI 10.1007/978-1-4757-2063-1. ISBN 978-0-387-96890-2.  
Source key: `arnold_mathematical_methods_classical_mechanics_2e_1989`  
Verifiziert: Lagrangian mechanics on manifolds S. 75–97; Differential forms S. 163–200; Symplectic manifolds S. 201–232; Canonical formalism S. 233–270.

**[81]** Noether, Emmy: „Invariante Variationsprobleme“. *Nachrichten von der Königlichen Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse*, 1918, S. 235–257.  
Source key: `noether_invariante_variationsprobleme_1918`  
Verifiziert: vollständiger Originalseitenbereich; §1 enthält die Formulierung der beiden Noether-Sätze.

**[82]** Shiryaev, Albert N.: *Probability-1*. Third Edition. Graduate Texts in Mathematics 95. New York: Springer, 2016. DOI 10.1007/978-0-387-72206-1. ISBN 978-0-387-72205-4.  
Source key: `shiryaev_probability_1_3e_2016`  
Verifiziert: „Mathematical Foundations of Probability Theory“, S. 159–371. Bei späteren Verwendungen dürfen engere Fundstellen nur eingetragen werden, wenn sie zusätzlich verifiziert wurden.

**[83]** Shannon, Claude E.: „A Mathematical Theory of Communication“. *The Bell System Technical Journal* 27 (1948), 27(3), S. 379–423; 27(4), S. 623–656.  
Source key: `shannon_mathematical_theory_communication_1948`  
Primärquelle.

**[84]** Cover, Thomas M.; Thomas, Joy A.: *Elements of Information Theory*. Second Edition. Hoboken, NJ: John Wiley & Sons, 2006. DOI 10.1002/047174882X. ISBN 978-0-471-24195-9.  
Source key: `cover_thomas_elements_information_theory_2e_2006`  
Verifiziert: Chapter 2 S. 13–55; Chapter 8 S. 243–259.

**[85]** Pollard, David: *A User’s Guide to Measure Theoretic Probability*. Cambridge Series in Statistical and Probabilistic Mathematics 8. Cambridge: Cambridge University Press, 2002. DOI 10.1017/CBO9780511811555. ISBN 978-0-521-00289-9.  
Source key: `pollard_users_guide_measure_theoretic_probability_2002`  
Verifiziert: Chapter 10 „Representations and Couplings“, S. 237–260.

**[86]** Norris, J. R.: *Markov Chains*. Cambridge Series in Statistical and Probabilistic Mathematics 2. Cambridge: Cambridge University Press, 1997. DOI 10.1017/CBO9780511810633. ISBN 978-0-521-63396-3.  
Source key: `norris_markov_chains_1997`  
Verifiziert: Chapter 1 S. 1–59; Chapter 2 S. 60–107; Chapter 3 S. 108–127.

**[87]** Diestel, Reinhard: *Graph Theory*. Fifth Edition. Graduate Texts in Mathematics 173. Berlin, Heidelberg: Springer, 2017. DOI 10.1007/978-3-662-53622-3. eBook ISBN 978-3-662-53622-3.  
Source key: `diestel_graph_theory_5e_2017`  
Verifiziert: Chapter 1 „The Basics“, S. 1–34.

---

# 5. Vollständiger Abschlussstand von Kapitel 3.2

Kapitel 3.2 ist im letzten Repository-Skript auf `final` gesetzt.

Gesamtstand:

- **3.2.0–3.2.31 vollständig**
- **306 Definitionen:** 3.2.1–3.2.306
- **163 Sätze:** 3.2.1–3.2.163
- **2112 nummerierte Gleichungen/Aussagen:** (3.1)–(3.2112)
- nächster mathematischer Gleichungszähler bei fortlaufender Kapitel-3-Nummerierung: **(3.2113)**
- Kapitel 3.2 abgeschlossen
- nächster Kapitelbereich: **3.3**

| Abschnitt | Titel | Definitionen | Sätze | Gleichungen | kanonisches SQL | SHA-256 |
|---|---|---|---|---|---|---|
| 3.2.0 | Einleitung | – | – | – | `frzk_3.2.0_repository_V4.sql` | `76e2a957dcc4596e280b22afa43b631dafb6bdd8b19e8c55239f68e36e8d4cff` |
| 3.2.1 | Mengen, Elemente und Relationen | 3.2.1–3.2.5 | – | 3.1–3.13 | `frzk_3.2.1_repository.sql` | `fb24e19a889a8b7b8c7b84fe186a922ccb3519d983b7a8eb0c7d91e6f2987796` |
| 3.2.2 | Funktionen und eindeutige Zuordnungen | 3.2.6–3.2.12 | – | 3.14–3.25 | `frzk_3.2.2_repository.sql` | `0c4b06d4b2992f8d9c50c55ee78f534c5d6c4609b2eeb6225a65e335251a08e1` |
| 3.2.3 | Vektorräume und mathematische Zustandsräume | 3.2.13–3.2.15 | – | 3.26–3.32 | `frzk_3.2.3_repository.sql` | `a456fcda385d1965f3ebae8bf9fa01ed97183777c125d2fb31a1aea744a188fe` |
| 3.2.4 | Linearkombinationen, Spannräume und Erzeugung | 3.2.16–3.2.19 | – | 3.33–3.44 | `frzk_3.2.4_repository.sql` | `8d473a2b55ecfeb381dbc924f9f68495af6ee46b2414e6800aa00705092d9aa8` |
| 3.2.5 | Lineare Unabhängigkeit, Basis und Dimension | 3.2.20–3.2.22 | 3.2.1 | 3.45–3.57 | `frzk_3.2.5_repository.sql` | `037402bf945229f757ee3a3b604bd517d9915bd5aefe9829d8ebb84ede0f6fcf` |
| 3.2.6 | Lineare Abbildungen und Operatoren | 3.2.23–3.2.27 | 3.2.2–3.2.3 | 3.58–3.80 | `frzk_3.2.6_repository.sql` | `bec7e62b467741ca395213e0469d5eb00b9151f2cff8c8f72e8e8c7787e9163e` |
| 3.2.7 | Normen, Abstände und Skalarprodukte | 3.2.28–3.2.34 | 3.2.4–3.2.6 | 3.81–3.97 | `frzk_3.2.7_repository.sql` | `fb367e776e132dd7b052e0ca0fa59b29c104d4a4808a52edee520b1a32724f2c` |
| 3.2.8 | Topologische Räume, Umgebungen und Stetigkeit | 3.2.35–3.2.43 | 3.2.7 | 3.98–3.119 | `frzk_3.2.8_repository.sql` | `5f372f861e51d40dbdbec1228fb04c2cae74cfcb079223b6899f4ff9c40800a4` |
| 3.2.9 | Zusammenhang und Kompaktheit topologischer Zustandsräume | 3.2.44–3.2.52 | 3.2.8–3.2.12 | 3.120–3.139 | `frzk_3.2.9_repository.sql` | `af0603ebb48d27d3d9062d6196d4d0910091581b4a5f4e8c945ec4629bf2b26f` |
| 3.2.10 | Folgen, Konvergenz und Vollständigkeit | 3.2.53–3.2.59 | 3.2.13–3.2.18 | 3.140–3.166 | `frzk_3.2.10_repository.sql` | `3799e4330bddcbe911a48eb89f7322be95e5f0f4463f7addf273fcd405d82f88` |
| 3.2.11 | Funktionenräume als mathematische Zustandsräume | 3.2.60–3.2.68 | 3.2.19–3.2.25 | 3.167–3.202 | `frzk_3.2.11_repository.sql` | `bd42d619a5832f0edec3ecc5579039351ec71dd98631a1f9449f6571cb3cae51` |
| 3.2.12 | Lineare Funktionale, Dualräume und beschränkte Operatoren | 3.2.69–3.2.75 | 3.2.26–3.2.32 | 3.203–3.245 | `frzk_3.2.12_repository.sql` | `17a111d45f92ab79b638296e392030e177b1a8dfef11167b2efcf6e52d516bd6` |
| 3.2.13 | Eigenwerte, Eigenvektoren und Spektralbegriffe von Operatoren | 3.2.76–3.2.85 | 3.2.33–3.2.39 | 3.246–3.280 | `frzk_3.2.13_repository.sql` | `f450e078b1308f603cf94d16a6ebcf7aa35fa76abc6a69be4a423b9e51a9d7f8` |
| 3.2.14 | Projektionen, orthogonale Zerlegungen und invariante Teilräume | 3.2.86–3.2.90 | 3.2.40–3.2.47 | 3.281–3.334 | `frzk_3.2.14_repository.sql` | `def535ccfd453664b86794d71bab50f174e66840ea6173dec4eefa4dbf927c30` |
| 3.2.15 | Differenzierbarkeit, Ableitungen und Differentialoperatoren | 3.2.91–3.2.98 | 3.2.48–3.2.54 | 3.335–3.382 | `frzk_3.2.15_repository.sql` | `e250994d9484571cb42b3e323d6d228c92f980b9a76d8a387c814b15b6a0cb5d` |
| 3.2.16 | Gewöhnliche und partielle Differentialgleichungen als Zustandsrelationen | 3.2.99–3.2.109 | 3.2.55–3.2.58 | 3.383–3.441 | `frzk_3.2.16_repository.sql` | `04441ad315ca9c85d0f2e39107d0598ac477356d447369477035bbdab7aadcc4` |
| 3.2.17 | Dynamische Systeme, Flüsse und mathematische Zustandsentwicklung | 3.2.110–3.2.120 | 3.2.59–3.2.65 | 3.442–3.510 | `frzk_3.2.17_repository.sql` | `802c1ba44c0340a412c175b59e36f0c0a686988fe4597d7d740e7c859b33c83e` |
| 3.2.18 | Stabilität, Störungen und Lyapunov-Begriffe dynamischer Systeme | 3.2.121–3.2.130 | 3.2.66–3.2.72 | 3.511–3.580 | `frzk_3.2.18_repository.sql` | `813d3ac1a0540a015100b50b1350a115182ca1ad2b8ba4001800f8a413b747f1` |
| 3.2.19 | Grenzmengen, Attraktoren und asymptotisches Verhalten dynamischer Systeme | 3.2.131–3.2.140 | 3.2.73–3.2.76 | 3.581–3.630 | `frzk_3.2.19_repository.sql` | `54fc8bd7faef0fecb85d731e759c91090c5e67551cbcca808dc90d8a1e5cd522` |
| 3.2.20 | Differenzierbare Mannigfaltigkeiten, lokale Koordinaten und Tangentialräume | 3.2.141–3.2.151 | 3.2.77–3.2.83 | 3.631–3.685 | `frzk_3.2.20_repository.sql` | `a642112c9d2db1aa50df0dbc9333adfe3ca9f181a0d676557fe7794908ccd250` |
| 3.2.21 | Riemannsche und pseudo-riemannsche Metriken auf Mannigfaltigkeiten | 3.2.152–3.2.163 | 3.2.84–3.2.86 | 3.686–3.765 | `frzk_3.2.21_repository.sql` | `f1747f103f2b0afdbd2d51ea62522883cf1edd88b9667478022aca7b7520a235` |
| 3.2.22 | Zusammenhang, kovariante Ableitung und Paralleltransport auf Mannigfaltigkeiten | 3.2.164–3.2.172 | 3.2.87–3.2.92 | 3.766–3.845 | `frzk_3.2.22_repository.sql` | `3872730a3261146e3596c357c4bbd75f8955a77d593c2d82b53bd6aeec4f4a6f` |
| 3.2.23 | Geodäten, Exponentialabbildung und Krümmung von Mannigfaltigkeiten | 3.2.173–3.2.184 | 3.2.93–3.2.99 | 3.846–3.925 | `frzk_3.2.23_repository.sql` | `104d04899d6039748f5eeb4294f32f0bb19b1d0c59849c1551b639a5cf1527a3` |
| 3.2.24 | Zeitorientierung, kausale Kurven und Kausalstruktur lorentzscher Mannigfaltigkeiten | 3.2.185–3.2.198 | 3.2.100–3.2.104 | 3.926–3.995 | `frzk_3.2.24_repository.sql` | `711b283ead768865e197a3bbe35710241b93db9aab44dcd364bc2d21506f6fd5` |
| 3.2.25 | Variationsprinzipien, Wirkungsfunktionale und Euler-Lagrange-Strukturen | 3.2.199–3.2.208 | 3.2.105–3.2.111 | 3.996–3.1096 | `frzk_3.2.25_repository.sql` | `b94fa8d0fc3dd83c6158afdfa0c460b22d146adbe59b56cbf58374d49a9037bd` |
| 3.2.26 | Legendre-Transformation, Hamilton-Funktion und Phasenraumstruktur | 3.2.209–3.2.220 | 3.2.112–3.2.119 | 3.1097–3.1247 | `frzk_3.2.26_repository.sql` | `a10af9664a3c477cec450186fbd2c8487bcaec69d75526f5e06af1685c45f49b` |
| 3.2.27 | Symmetrien, Invarianz und Noether-Strukturen | 3.2.221–3.2.233 | 3.2.120–3.2.126 | 3.1248–3.1370 | `frzk_3.2.27_repository.sql` | `4a9d793015a13af35fccd8fed5688409bfc4744c6e6e6debcf0928265b396bbf` |
| 3.2.28 | Maßräume, Wahrscheinlichkeitsmaße, Entropie und mathematische Information | 3.2.234–3.2.252 | 3.2.127–3.2.136 | 3.1371–3.1523 | `frzk_3.2.28_repository.sql` | `de546cf8546c114c0d4f624f35b0fba4ea54b300e0025e43dbfd882e9ea64470` |
| 3.2.29 | Produktstrukturen, Kopplungen, Korrelation und gemeinsame Zustandsräume | 3.2.253–3.2.272 | 3.2.137–3.2.147 | 3.1524–3.1729 | `frzk_3.2.29_repository.sql` | `b5e76d2abdabbc264dfa56ae345cab68a0cf6ac99b2b20225fe7f92cfdab969a` |
| 3.2.30 | Stochastische Prozesse, Markov-Eigenschaft und zeitabhängige Wahrscheinlichkeitsstrukturen | 3.2.273–3.2.286 | 3.2.148–3.2.153 | 3.1730–3.1893 | `frzk_3.2.30_repository.sql` | `2477dbd6d3836430d0d616a27d584afed576f8b753b1b47c36ce9db5526ccc88` |
| 3.2.31 | Graphen, Netzwerke, Symmetrien und geometrische Einbettungen relationaler Strukturen | 3.2.287–3.2.306 | 3.2.154–3.2.163 | 3.1894–3.2112 | `frzk_3.2.31_repository.sql` | `b948215d76b934a2105b2befe92d4131e7fb5375052967a1dc1886c97c67a97e` |

---

# 6. Kanonischer Repository-Aufbau und Wiederherstellungsreihenfolge

Verbindliche Ausgangsdatei:

`frzk_rkb_stand_ende_3.1.sql`

Danach sind für den Neuaufbau des aktuellen 3.2-Standes in Reihenfolge auszuführen:

1. `frzk_3.2.0_repository_V4.sql`
2. `frzk_3.2.1_repository.sql`
3. `frzk_3.2.2_repository.sql`
4. …
5. `frzk_3.2.31_repository.sql`

Für 3.2.0 existieren ältere Varianten (`repository.sql`, `CORRECTED`, `V3`). **Kanonisch für den Übergang ist V4.**

Nach `frzk_3.2.31_repository.sql` müssen die Repository-Counter lauten:

- `current_section = 3.3`
- `last_completed_section = 3.2.31`
- `last_completed_chapter = 3.2`
- `last_citation_number = 87`
- `next_citation_number = 88`

---

# 7. Repository-/SQL-Regeln für Kapitel 3.3

## 7.1 Vor jedem Skript

Vor **jedem** neuen Repository-Skript muss das reale Schema des Dumps beziehungsweise des aktuellen Datenbankstands erneut geprüft werden. Tabellen- und Spaltennamen, ENUM-Werte, Fremdschlüssel, Kollationen und Unique Constraints dürfen nicht aus Erinnerung geraten werden.

Immer setzen:

```sql
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET collation_connection = 'utf8mb4_unicode_ci';
```

## 7.2 Keine harten Abbruch-Gates

- Keine `SIGNAL SQLSTATE`-Validierungen.
- Validierungen werden nicht blockierend in `repository_validation_results` dokumentiert.
- Ein fehlender Vorgänger darf nicht unnötig zum Abbruch führen.
- `parent_revision_id` kann, sofern schema- und logikgerecht, `NULL` beziehungsweise aus dem real vorhandenen Vorgänger bestimmt werden.

## 7.3 Vollständigkeit eines Skripts

Ein Skript für einen 3.3-Abschnitt muss je nach Inhalt berücksichtigen:

- `dissertation_sections`
- `repository_revisions`
- `repository_counters`
- `section_change_log`
- `sources`
- `authors`
- `source_authors`
- `source_usage`
- `object_source_links`
- `equations`
- `definitions`
- `assumptions`
- `axioms`
- `lemmas`
- `theorems`
- `corollaries`
- `proofs`
- `propositions`
- gegebenenfalls Figuren, Tabellen, Symbole, Akronyme, Crossrefs/Notizen, soweit tatsächlich verwendet.

## 7.4 Für 3.3 besonders relevante reale Tabellenfelder

### `axioms`

- `axiom_id`
- `axiom_number`
- `section_id`
- `title`
- `axiom_text`
- `formal_latex`
- `word_latex`
- `motivation`
- `independence_note`
- `consistency_note`
- `operationalization_note`
- `source_assumption_id`
- `status` = `draft|review|accepted|revised|rejected`
- `created_revision_id`

### `assumptions`

- `assumption_id`
- `assumption_number`
- `section_id`
- `title`
- `assumption_text`
- `formal_latex`
- `word_latex`
- `derivation_from_research_gap`
- `status` = `proposed|accepted|rejected|superseded`
- `created_revision_id`

### `proofs`

- `proof_id`
- `proof_number`
- `section_id`
- `theorem_id`
- `lemma_id`
- `corollary_id`
- `title`
- `proof_text`
- `proof_latex`
- `proof_method` = `direct|contradiction|induction|construction|equivalence|existence|uniqueness|computational|other`
- `provenance` = `original|adapted|literature`
- `source_id`
- `validation_status` = `draft|checked|verified`
- `created_revision_id`

### `lemmas`

- `lemma_id`
- `lemma_number`
- `section_id`
- `title`
- `statement_text`
- `statement_latex`
- `word_latex`
- `provenance`
- `source_id`
- `assumptions`
- `validation_status`
- `created_revision_id`

### `corollaries`

- `corollary_id`
- `corollary_number`
- `section_id`
- `title`
- `statement_text`
- `statement_latex`
- `word_latex`
- `parent_theorem_id`
- `parent_lemma_id`
- `provenance`
- `source_id`
- `validation_status`
- `created_revision_id`

### `propositions`

- `proposition_id`
- `proposition_number`
- `section_id`
- `title`
- `statement_text`
- `statement_latex`
- `word_latex`
- `logical_derivation`
- `based_on_axioms`
- `status` = `draft|review|accepted|revised|rejected`
- `created_revision_id`

Diese Tabellen sind vor dem ersten 3.3-Skript nochmals direkt gegen den aktuellen Dump zu verifizieren.

## 7.5 MariaDB-LaTeX-Escaping

Im SQL-Dateistring müssen Backslashes so escaped werden, dass der gespeicherte Datenbanktext genau die gewünschte LaTeX-Zeichenfolge enthält. Keine ungeprüfte einfache Übernahme aus Chat-LaTeX.

## 7.6 Ausgabeformat bei „skript“

Wenn der Nutzer `skript`, `script` oder eine offensichtliche Variante schreibt:

1. Schema erneut prüfen.
2. Vollständiges SQL erzeugen.
3. SQL vollständig im Chat ausgeben.
4. Zusätzlich `.sql` als Download erzeugen.
5. Zusätzlich `.sha256` erzeugen.
6. SHA-256 im Chat nennen.
7. Keine SQL-Datei darf die Chat-Ausgabe ersetzen.

---

# 8. Methodologische Kernunterscheidungen aus Kapitel 3.2

Die folgenden Aussagen sind für 3.3 verbindliche Schranken. Eine neue Axiomatik darf sie nur dann überwinden, wenn sie **explizit zusätzliche FRZK-Struktur** einführt und die Konsequenz daraus beweist.

## 8.1 Struktur und Dimension

- Vektorraumdimension ≠ Anzahl von Variablen.
- Anzahl von Komponenten ≠ physikalische Dimension.
- Matrixdimension ≠ Raumdimension.
- Anzahl von Knoten ≠ Raumdimension.
- Funktionsraumdimension ≠ physikalische Raumdimension.
- Tangentialbündel-Dimension \(2n\) verdoppelt nicht die Mannigfaltigkeitsdimension.
- Phasenraumdimension \(2n\) ist keine Raumzeitdimension.
- Zusätzliche Zustandsvariable ≠ zusätzliche Raumzeitdimension.
- Informationsobservable ≠ Informationsdimension.
- Informationsknoten ≠ Raumzeitdimension.

## 8.2 Metrik und Geometrie

- Norm ≠ physikalische Länge ohne Interpretation.
- Graphenabstand ≠ euklidischer Abstand.
- Kantengewicht ≠ Abstand.
- Kopplungskoeffizient ≠ Abstand.
- Korrelation ≠ Abstand.
- gegenseitige Information ≠ Abstand.
- skalare Kohärenz ≠ Abstand.
- Topologie ≠ Metrik.
- topologischer Rand ≠ physikalischer Rand.
- Graphzeichnung ≠ geometrische Eigenschaft des abstrakten Graphen.
- relationale Struktur ≠ geometrische Realisierung.
- Graphsymmetrie ≠ geometrische Symmetrie.
- eine geometrische Form bestimmt keine absolute Lage.

## 8.3 Dynamik

- Operator ≠ physikalische Evolution.
- Differentialgleichung ≠ physikalisches Gesetz ohne Interpretation.
- mathematische Eindeutigkeit ≠ physikalischer Determinismus.
- invertierbarer Fluss ≠ thermodynamische Reversibilität.
- dynamisches System ≠ automatisch physikalisches System.
- Lyapunov-Stabilität ≠ Konvergenz.
- Stabilität ≠ Attraktion.
- Attraktor ≠ kausale Kraft.
- Attraktor ≠ teleologisches Ziel.
- Zustandserweiterung ist eine Modellkonstruktion.

## 8.4 Mannigfaltigkeiten und Raumzeit

- Mannigfaltigkeitspunkt ≠ Koordinatentupel.
- lokale Koordinate ≠ bevorzugte physikalische Koordinate.
- pseudo-riemannsche Metrik erzeugt im Allgemeinen keine positive Distanzfunktion.
- Nullvektoren können von null verschieden sein.
- Zusammenhang/Connection ≠ Dynamik.
- Christoffelsymbole sind keine Tensoren.
- Paralleltransport ≠ dynamischer Fluss.
- Paralleltransport ≠ globale Isometrie.
- Geodäte ≠ global kürzeste Kurve im Allgemeinen.
- affiner Parameter ≠ automatisch physikalische Zeit.
- Krümmung ≠ Materie/Energie ohne Feldgleichung.
- kausale Kurve ≠ Geodäte.
- Kausalität ≠ Korrelation.
- Kausalität ≠ Kohärenz.
- Zeitorientierung ≠ thermodynamischer Zeitpfeil.

## 8.5 Variations- und Hamilton-Strukturen

- Wirkungsfunktional ≠ zusätzliche Dimension.
- stationäre Wirkung ≠ Minimum.
- stationäre Wirkung ≠ Zeitpfeil.
- stationäre Wirkung ≠ Lorentzsignatur.
- stationäre Wirkung ≠ maximale Kohärenz.
- kanonischer Impuls ≠ mechanischer Impuls ohne Modell.
- Legendre-Transformation ≠ Erzeugung einer Dimension.
- \(T^\*Q\) ≠ Raumzeit.
- symplektische Struktur ≠ Metrik.
- symplektische Struktur ≠ Kausalstruktur.
- Hamilton-Funktion ≠ automatisch physikalische Gesamtenergie.
- Hamilton-Funktion ≠ Kohärenzfunktion.
- Liouville-Volumenerhaltung ≠ automatisch Informations- oder Entropieerhaltung.
- Poisson-Klammer ≠ Quantenkommutator.
- Phasenraumtrajektorie ≠ Raumzeitweltlinie.

## 8.6 Symmetrien und Noether

- Koordinatenwechsel ≠ physikalische Symmetrie.
- Symmetrie benötigt Gruppe/Wirkung und ein ausdrücklich invariantes Objekt.
- Wirkungssymmetrie ≠ Gleichungssymmetrie ≠ Symmetrie einer einzelnen Lösung.
- Noether I benötigt kontinuierliche Variationssymmetrie unter den passenden Voraussetzungen.
- diskrete Symmetrie liefert nicht auf dieselbe Weise eine infinitesimale Noether-Erhaltungsgröße.
- Noether-Erhaltungsgröße ≠ zusätzliche Koordinate.
- Anzahl von Erhaltungsgrößen ≠ geometrische Dimension.
- Erhaltungsgröße ≠ Kausalgesetz.
- Symmetriegenerator ≠ physikalische Kraft.
- Dimension einer Lie-Gruppe ≠ Raumzeitdimension.
- Symmetrieparameter ≠ physikalische Zeit.
- Gauge-Symmetrie ≠ automatisch unabhängige physikalische Zustände.
- erhaltene Kohärenz ≠ maximale Kohärenz.
- Symmetrie ≠ Stabilität.
- Symmetrie ≠ Attraktor.
- mathematische Invarianz ≠ empirische Gültigkeit.

## 8.7 Wahrscheinlichkeit, Information und Stochastik

- gemeinsame Verteilung ≠ physikalische Wechselwirkung.
- probabilistische Kopplung ≠ dynamische Kopplung.
- Korrelation ≠ Kausalität.
- gegenseitige Information ≠ Kausalität.
- Markov-Eigenschaft ≠ physikalische Kausalität.
- Markov-Eigenschaft ≠ Determinismus.
- Übergangsmatrix ≠ Bewegungsgesetz.
- Markov-Semigruppe ≠ deterministischer Fluss.
- Generator einer Markov-Kette ≠ Übergangsmatrix.
- Mastergleichung einer Verteilung ≠ Einzelzustands-Bewegungsgleichung.
- stationäre Verteilung ≠ thermodynamisches Gleichgewicht.
- Markov-Struktur ≠ monotone Shannon-Entropie.
- Prozessindex ≠ automatisch physikalische Zeit.
- Filtration ≠ Nachweis physikalischer Informationsübertragung.
- zeitliche Korrelation ≠ gerichtete Ursache.
- Shannon-Entropie ≠ thermodynamische Entropie ohne zusätzliche Modellbeziehung.
- Differentialentropie ist koordinaten-/skalierungsabhängig und darf nicht naiv geometrisiert werden.
- Informationsgröße ≠ Raumzeitdimension.
- Zustandsraumerweiterung um Information ≠ geometrische Raumzeiterweiterung.

## 8.8 Graphen und Netzwerke

- Kante ≠ physikalische Wechselwirkung.
- Adjazenz ≠ räumliche Nachbarschaft.
- Graphenzusammenhang ≠ physikalische Kausalverbindung.
- \(K_3\) ≠ gleichseitiges Dreieck.
- gleiche Graphenabstände ≠ gleiche euklidische Abstände.
- Adjazenzmatrix ≠ Koordinatenmatrix.
- Graph-Laplacian ≠ Laplace-Beltrami-Operator.
- Graphautomorphismus ≠ euklidische Isometrie.
- gleiches Kantengewicht ≠ gleiche geometrische Länge.
- gerichtete Kante ≠ physikalische Ursache.
- abstrakter Graph bestimmt keine eindeutige Einbettung.
- metrische Daten bestimmen ohne Bezugssystem keine absolute Lage.

---

# 9. Universelle Entscheidungsmatrix: mathematisches Werkzeug → wissenschaftliche Lücke → Definition oder Primäraxiom?

Diese Matrix ist **Arbeitsgrundlage**, nicht in voller Länge für den Dissertationstext bestimmt. Im Dissertationstext wird sie in 3.3.0 stark verdichtet.

## A. Ontologische und mathematische Grundobjekte

| Nr. | Werkzeug | wissenschaftliche Lücke | Status in 3.3 |
|---|---|---|---|
| 1 | Mengen/Elemente | Was sind die elementaren FRZK-Objekte? | Definition |
| 2 | Relationen | Was bedeutet eine FRZK-Beziehung? | Definition |
| 3 | Funktionen | Wie werden Größen Zuständen/Objekten zugeordnet? | Definition |
| 4 | Zustandsraum | Was ist ein vollständiger FRZK-Zustand? | Definition |
| 5 | Zustandsvektor | Wie wird ein Zustand dargestellt? | Definition |
| 6 | Parameterraum | Welche internen/externen Parameter existieren? | Definition |
| 7 | Observable | Welche Größen werden aus Zuständen berechnet? | Definition |
| 8 | Funktionsraum | In welchem Raum liegen Felder/Zustandsfunktionen? | Definition |

## B. Kohärenz

| Nr. | Werkzeug | wissenschaftliche Lücke | Status |
|---|---|---|---|
| 9 | skalarwertige Funktion | Was ist FRZK-Kohärenz mathematisch? | Definition |
| 10 | Paarfunktion | Gibt es paarweise Kohärenz? | Definition |
| 11 | Wertebereich | Welche Skala/Ordnung besitzt Kohärenz? | Definition/Konvention |
| 12 | Symmetrie | Gilt \(\mathcal K_{ij}=\mathcal K_{ji}\)? | Primäraxiom oder Satz |
| 13 | Positivität/Normierung | Ist Kohärenz positiv/beschränkt/normiert? | Primäraxiom oder Satz |
| 14 | globales Funktional | Wie entsteht Systemkohärenz aus Teilstrukturen? | Definition oder Primäraxiom, abhängig vom Anspruch |

## C. Relationen, Graphen, Netzwerke

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 15 | Graph | Welche Komponenten stehen in Relation? | Definition |
| 16 | Vollständigkeit | Wann ist jede Komponente mit jeder anderen verbunden? | Primäraxiom oder Satz |
| 17 | Graphautomorphismus | Wann sind Komponenten strukturell gleichberechtigt? | Primäraxiom oder Satz |
| 18 | Kantengewicht | Welche quantitative Bedeutung hat eine Relation? | Definition |
| 19 | Gleichheit von Gewichten | Wann besitzen Beziehungen gleiche Stärke? | Primäraxiom oder Satz |
| 20 | Graphenabstand | Welche Rolle spielt kombinatorischer Abstand? | Definition; nicht mit physikalischem Abstand gleichsetzen |

## D. Metrik und Geometrie

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 21 | Metrik | Besitzt FRZK eine fundamentale Abstandsfunktion? | Primäraxiom oder Satz |
| 22 | Kohärenz–Metrik-Brücke | Besteht \(d_{ij}=f(\mathcal K_{ij})\) oder eine allgemeinere Relation? | Primäraxiom oder Satz |
| 23 | Eigenschaften von \(f\) | Wann sind Umkehrschlüsse möglich? | Definition/Satz |
| 24 | geometrische Realisierung | Wie wird abstrakte Struktur räumlich realisiert? | Primäraxiom oder Satz |
| 25 | euklidische Geometrie | In welchem Regime ist Euklidizität gerechtfertigt? | Modellannahme/Satz |
| 26 | lorentzsche Geometrie | Wie wird Raumzeitgeometrie angeschlossen? | Primäraxiom/Anschlussbedingung |

## E. Symmetrie

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 27 | Gruppenwirkung | Welche Transformationen gelten als FRZK-Symmetrien? | Definition |
| 28 | Permutations-/Äquivalenzsymmetrie | Sind äquivalente Komponenten gleichberechtigt? | Primäraxiom oder Satz |
| 29 | Invarianz von Kohärenz | Bleibt \(\mathcal K\) unter zulässigen Transformationen invariant? | Primäraxiom oder Satz |
| 30 | geometrische Symmetrierealisierung | Werden abstrakte Symmetrien räumlich durch Isometrien realisiert? | Primäraxiom oder Satz |
| 31 | Fixpunktstruktur | Können ausgezeichnete Zustände/Positionen aus Symmetrie folgen? | Satz, sobald Wirkung festliegt |

## F. Dynamik

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 32 | dynamisches System | Besitzt FRZK eine Evolutionsregel? | Primäraxiom |
| 33 | Fluss/Halbfluss | Besitzt Evolution Kompositionsstruktur? | Primäraxiom oder Satz |
| 34 | Differentialgleichung | Welche lokale Evolutionsgleichung gilt? | Bewegungsgesetz/Primäraxiom |
| 35 | Eindeutigkeit | Ist die Evolution deterministisch? | Satz |
| 36 | Reversibilität | Ist Evolution umkehrbar? | Primäraxiom oder Satz |
| 37 | Attraktor | Gibt es bevorzugte asymptotische Zustände? | Satz oder Axiom, falls wirklich fundamental |

## G. Variationsprinzip

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 38 | Funktional | Kann ein globales FRZK-Funktional definiert werden? | Definition |
| 39 | Variation | Welche Variationen sind zulässig? | Definition |
| 40 | Stationarität | Realisieren physische Zustände stationäre Werte? | Primäraxiom |
| 41 | Maximum/Minimum | Ist ein bestimmter Extremaltyp fundamental? | Primäraxiom oder Satz |
| 42 | Euler-Lagrange-Struktur | Welche Feld-/Bewegungsgleichungen folgen? | Satz |
| 43 | Stabilität des Extremums | Ist der Extremalzustand dynamisch stabil? | Satz |

## H. Hamiltonsche/symplektische Struktur

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 44 | Phasenraum | Benötigt FRZK kanonische Zustandsvariablen? | Definition/Modellwahl |
| 45 | Hamilton-Funktion | Ist eine Hamiltonsche Darstellung fundamental? | Primäraxiom oder abgeleitete Darstellung |
| 46 | Poisson-Struktur | Welche Größen erzeugen Transformationen? | Definition, falls Struktur vorhanden |
| 47 | Erhaltungsgröße | Welche Größen sind erhalten? | Satz oder Axiom |
| 48 | \(\{\mathcal K,H\}=0\) | Ist Kohärenz ein Integral der Bewegung? | Satz oder Axiom |

## I. Zeit und Kausalität

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 49 | Entwicklungsparameter | Welcher Parameter ordnet Evolution? | Definition |
| 50 | physikalische Zeit | Wann ist der Parameter physikalische Zeit? | Primäraxiom/Interpretationspostulat |
| 51 | Kausalstruktur | Wie wird physikalische Erreichbarkeit festgelegt? | Primäraxiom/Anschlussbedingung |
| 52 | Kohärenz und Kausalität | Begrenzt oder erzeugt Kohärenz Kausalbeziehungen? | Primäraxiom oder Satz |
| 53 | Zeitrichtung | Gibt es eine bevorzugte Entwicklungsrichtung? | Primäraxiom oder Satz |

## J. Wahrscheinlichkeit und stochastische Erweiterung

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 54 | Wahrscheinlichkeitsmaß | Ist FRZK fundamental probabilistisch? | Primäraxiom/Modellannahme |
| 55 | stochastischer Prozess | Sind Zustände fundamental zufällig? | Primäraxiom/Erweiterung |
| 56 | Markov-Eigenschaft | Genügt der Gegenwartszustand probabilistisch? | Primäraxiom oder Satz |
| 57 | Übergangswahrscheinlichkeit | Wie werden probabilistische Übergänge bestimmt? | Definition + Dynamikgesetz |
| 58 | stationäre Verteilung | Existiert statistischer Gleichgewichtszustand? | Satz |

Stochastik soll nur in den **universellen Kern**, wenn sie wirklich fundamental ist. Andernfalls bleibt sie eine abgeleitete/statistische Erweiterung.

## K. Information

| Nr. | Werkzeug | Lücke | Status |
|---|---|---|---|
| 59 | Informationsobservable | Was bedeutet Information im FRZK? | Definition |
| 60 | Shannon-Information | Ist FRZK-Information Shannon-Information? | Definition oder explizite Abgrenzung |
| 61 | Zustandsvariable \(I\) | Gehört Information zum vollständigen Zustand? | Primäraxiom oder Satz |
| 62 | Produktzustandsraum | Hat der Zustand die Form \(S\times\mathcal I\)? | Definition nach inhaltlicher Begründung |
| 63 | geometrische Koordinate | Ist Information eine geometrische Koordinate? | Primäraxiom oder Satz; niemals nur Definition |
| 64 | metrische Rolle | Geht Information in eine Metrik/ein Intervall ein? | Primäraxiom oder Satz |
| 65 | Transformationsverhalten | Wie transformiert Information geometrisch? | Primäraxiom oder Satz |
| 66 | kausale Rolle | Verändert Information Kausalstruktur/Lichtkegel? | Primäraxiom oder Satz |

---

# 10. Was im Dissertationstext von 3.3.0 erscheinen soll

Die vollständige 66-Punkte-Matrix ist eine **Arbeits- und Kontrollmatrix**. Im Dissertationstext soll sie **nicht vollständig** erscheinen. Dort genügt eine verdichtete Tabelle mit ungefähr folgenden Ebenen:

| mathematische Ebene | im FRZK zu klärende Frage | methodischer Status |
|---|---|---|
| Mengen, Zustände, Relationen, Funktionen | Welche Objekte bilden das FRZK? | Definition |
| Kohärenzgröße | Was bedeutet Kohärenz mathematisch? | Definition |
| Symmetrie/Gleichbehandlung | Welche Gleichwertigkeiten sind fundamental? | Primäraxiom oder Satz |
| Graph-/Netzwerkstruktur | Welche Relationen bestehen? | Definition; konkrete Struktur Satz/Axiom |
| Metrik | Wie entsteht Abstand? | Primäraxiom oder Satz |
| Geometrische Realisierung | Wie wird abstrakte Struktur räumlich? | Primäraxiom oder Satz |
| Dynamik/Variationsprinzip | Welches allgemeine Entwicklungs-/Auswahlgesetz gilt? | Primäraxiom |
| Kausalstruktur | Wie entsteht physikalische Kausalität? | Primäraxiom/Anschluss |
| Information | Welche mathematische Rolle besitzt Information? | zunächst Definition |
| Information als geometrische Dimension | Besitzt Information eigenständige metrische/geometrische Rolle? | nur Axiom oder abgeleiteter Satz |

3.3.0 muss explizit erklären:

- Definition legt Bedeutung fest.
- Primäraxiom ist irreduzible FRZK-Grundannahme.
- Lemma/Satz/Korollar folgt aus Definitionen und Axiomen.
- Was später als Folge beansprucht wird, darf nicht vorher in Definition oder Axiom versteckt werden.
- Axiome werden minimal und universell formuliert.

---

# 11. Universelle Axiomgruppen – vorläufiger Kandidatenraum

Die folgende Liste ist **noch keine endgültige Axiomliste**. Sie ist der Kandidatenraum, der in 3.3.1 gegen Forschungslücke, Universalität, Unabhängigkeit, Konsistenz und Ableitungsbedarf geprüft werden muss.

1. **Fundamentale relationale/funktionale Organisationsstruktur**
2. **Kohärenzzuordnung**
3. **Äquivalenz-/Symmetrieprinzip für strukturell gleichartige Komponenten**
4. **allgemeine Beziehung zwischen Kohärenz/Relation und metrischer oder geometrischer Struktur**, falls Geometrie wirklich aus FRZK hervorgehen soll
5. **allgemeines Dynamik- oder Variationsprinzip**, falls FRZK Entwicklung oder Auswahl bevorzugter Zustände erklären soll
6. **Kausal-/Zeit-Anschlussprinzip**, falls „Raum-Zeit“ nicht nur metaphorisch gemeint ist
7. **Informationsprinzip**, falls Information fundamental und nicht nur Observable ist
8. **geometrisches Informationsprinzip**, nur falls eine Informationskoordinate tatsächlich als Raumzeitdimension beansprucht wird
9. **stochastisches Prinzip**, nur falls Zufälligkeit fundamental ist
10. **Operationalisierungs-/Messbezug**, falls der theoretische Kern empirisch unterscheidbare Aussagen liefern soll

Die Zahl der Primäraxiome ist zu minimieren. Ein allgemeineres Axiom ist einem Bündel anwendungsspezifischer Einzelaxiome vorzuziehen, sofern es wissenschaftlich begründet, unabhängig und konsistent ist.

---

# 12. Anwendungstests der Universalität

Konkrete Fälle sind **Tests**, nicht Konstruktionsziel der Axiomatik.

## 12.1 Generische Testklassen

Kapitel 3.3 sollte seine universellen Aussagen später mindestens gegen folgende Klassen prüfen:

- einzelnes Objekt \(N=1\),
- Zweikomponentensystem \(N=2\),
- Dreikomponentensystem \(N=3\),
- allgemeines endliches \(N\),
- kontinuierliche Felder,
- vollständig gekoppelte Systeme,
- nur teilweise gekoppelte Systeme,
- entkoppelte Systeme,
- symmetrische und asymmetrische Kopplungen,
- gerichtete und ungerichtete Relationen,
- gewichtete und ungewichtete Netzwerke,
- metrische und zunächst nichtmetrische Modelle,
- euklidische und nicht-euklidische Realisierungen,
- zeitunabhängige und dynamische Systeme,
- deterministische und stochastische Modelle,
- lokale und globale Kohärenzgrößen,
- diskrete und kontinuierliche Zustandsräume,
- Information als Observable,
- Information als Zustandsvariable,
- Information als hypothetische geometrische Koordinate,
- Systeme mit Rand-/Nebenbedingungen,
- Systeme mit Symmetriebruch,
- Störungen und Stabilität,
- Grenz- und asymptotische Fälle.

## 12.2 Gleichseitiges Dreieck – **nur ein möglicher Geometrietest**

Die in 3.2 gewonnene Schranke lautet:

\[
K_3\not\Longrightarrow\text{gleichseitiges Dreieck}.
\]

Eine echte Ableitung müsste beispielsweise die allgemeine Form besitzen:

\[
\text{universelle FRZK-Axiome}
\Rightarrow
\text{bestimmte relationale Struktur}
\Rightarrow
\text{metrische Beziehung}
\Rightarrow
\text{gleiche Abstände}
\Rightarrow
\text{gleichseitige Realisierung}.
\]

Das Dreieck darf weder Primäraxiom noch versteckte Voraussetzung sein.

## 12.3 Information als zusätzliche Dimension – **nur ein möglicher Strukturtest**

Die Schranke lautet:

\[
I:S\to\mathbb R
\not\Longrightarrow
\text{zusätzliche Raumzeitdimension}.
\]

Auch

\[
\widetilde S=S\times\mathcal I
\]

erzeugt zunächst nur einen erweiterten Zustandsraum. Für eine geometrische Dimension wären zusätzlich geometrische, metrische und Transformationsstrukturen erforderlich.

Die universelle Frage lautet daher nicht „Wie beweise ich Information als vierte Dimension?“, sondern:

> Welche mathematische Rolle besitzt Information im universellen FRZK, und unter welchen allgemeinen Bedingungen kann daraus überhaupt eine eigenständige geometrische Dimension folgen?

## 12.4 Zusätzliche Position – **nur ein möglicher Eindeutigkeitstest**

Eine geometrische Grundkonfiguration bestimmt nicht automatisch einen weiteren Punkt. Allgemein ist zu untersuchen:

- Welche universelle Bedingung selektiert ausgezeichnete Zustände oder Positionen?
- Symmetrie?
- Extremalprinzip?
- Randbedingung?
- Dynamik?
- Stabilität?
- Fixpunktprinzip?
- Nebenbedingung?

Für drei nichtkollineare Referenzpunkte zeigt 3.2 nur beispielhaft: Gleichabstand bestimmt in einer Ebene einen Mittelpunkt, in \(\mathbb R^3\) dagegen ohne Zusatzbedingung eine Lösungsgerade. Das ist ein Eindeutigkeitstest, kein Fundament des FRZK.

## 12.5 Weitere gleichberechtigte Testfälle

Ein neuer Chat darf nicht bei den drei oben genannten Fällen stehen bleiben. Ebenso wichtig sind beispielsweise:

- Kann FRZK asymmetrische Beziehungen beschreiben?
- Was passiert bei verschwindender Kohärenz?
- Was passiert bei maximaler/gleicher Kohärenz?
- Ist ein entkoppeltes System zulässig?
- Entsteht bei großer Komponentenanzahl eine sinnvolle Grenzstruktur?
- Ist die Theorie unabhängig von Knotenbezeichnungen?
- Sind Koordinatenwechsel reine Darstellung oder physische Transformation?
- Welche Strukturen sind invariant?
- Welche Aussagen sind lokal, welche global?
- Gibt es nichtgeometrische FRZK-Realisierungen?
- Ist Stochastik fundamental oder emergent?
- Ist Information fundamental, abgeleitet oder rein beobachterbezogen?
- Welche Größen sind messbar?
- Welche Grenzfälle reproduzieren bekannte Mathematik/Physik?
- Welche Beobachtung könnte ein Primäraxiom falsifizieren?

---

# 13. Anti-Zirkularitätsregel

Der wichtigste methodische Satz für 3.3 lautet:

> **Was später als FRZK-Folge beansprucht wird, darf vorher weder durch Definition noch durch Primäraxiom in äquivalenter Form vorausgesetzt werden.**

Beispiele:

- Soll eine spezielle Geometrie folgen, darf sie nicht als Geometrieaxiom für genau diesen Fall vorausgesetzt werden.
- Soll eine Position folgen, darf diese Position nicht als spezielle Randbedingung nur für die Anwendung eingesetzt werden.
- Soll Information geometrische Dimension sein, darf „Information ist eine Dimension“ nicht bloß als Definition deklariert werden.
- Soll eine Erhaltungsgröße aus Symmetrie folgen, darf ihre Erhaltung nicht unabhängig zusätzlich axiomatisiert werden.
- Soll Stabilität aus einem Variationsprinzip folgen, darf Stabilität nicht parallel als Grundannahme vorausgesetzt werden.

---

# 14. Empfohlener Start von Kapitel 3.3

## 3.3.0 Axiomatischer Ausgangspunkt und Abgrenzung von Definition, Primäraxiom und Ableitung

Dieser Abschnitt soll im Dissertationstext:

1. den Abschluss der mathematischen Werkzeuge aus 3.2 inhaltlich aufnehmen,
2. erklären, warum Mathematik allein keine FRZK-Theorie erzeugt,
3. Definition, Annahme, Primäraxiom, Lemma, Satz, Korollar und Modellrealisierung sauber trennen,
4. das Minimalitätsprinzip für Primäraxiome formulieren,
5. das Universalitätsprinzip formulieren,
6. eine **verdichtete** Werkzeug-Lücken-Status-Tabelle enthalten,
7. die Anti-Zirkularitätsregel formulieren,
8. auf 3.3.1 überleiten.

**3.3.0 soll noch keine konkrete Spezialgeometrie privilegieren und möglichst noch keine endgültige Primäraxiomliste festschreiben.**

## 3.3.1 Wissenschaftliche Lückenanalyse und Anforderungen an eine universelle FRZK-Axiomatik

Hier ist die Forschungslücke aus 3.1.7 gegen das Instrumentarium aus 3.2 zu prüfen.

Für jede behauptete FRZK-Neuerung sind mindestens folgende Fragen zu beantworten:

- Ist sie bereits reine Mathematik?
- Ist sie etablierte Physik?
- Ist sie Definition?
- Ist sie zusätzliche Modellannahme?
- Ist sie wirklich irreduzible FRZK-Eigenannahme?
- Kann sie aus einem allgemeineren Prinzip hergeleitet werden?
- Ist sie unabhängig von konkreten Anwendungen?
- Ist sie operationalisierbar?
- Welche Konsequenzen müssen daraus folgen?
- Welche Gegenbeispiele oder Randfälle muss sie überstehen?

Erst nach dieser Analyse sollen die eigentlichen Primäraxiome endgültig formuliert werden.

---

# 15. Nummerierungsstart für Kapitel 3.3

Verbindlicher letzter Stand aus 3.2:

- letzte Definition: **Definition 3.2.306**
- letzter Satz: **Satz 3.2.163**
- letzte Gleichung: **(3.2112)**
- nächste neue Literatur: **[88]**

Für Kapitel 3.3 sollen neue Objektfamilien **kapitelbezogen** beginnen, z. B.:

- Definition 3.3.1 …
- Annahme 3.3.1 oder eine eindeutig getrennte Annahmenummerierung,
- Primäraxiom mit eigener eindeutiger Axiomnummerierung,
- Lemma 3.3.1 …
- Satz 3.3.1 …
- Korollar 3.3.1 …

Die konkrete Axiomnummerierung ist **vor dem ersten Axiom festzulegen** und danach nicht mehr spontan zu ändern.

Für Gleichungen kann die in Kapitel 3 verwendete fortlaufende Gleichungsnummerierung mit **(3.2113)** fortgesetzt werden, sofern dieser Nummerierungsmodus für Kapitel 3.3 beibehalten wird.

---

# 16. Empfohlene Repository-Logik für Primäraxiome

Kapitel 3.3 sollte die vorhandene Trennung der Datenbank nutzen:

1. Forschungslücke/Begründung bestimmen.
2. Falls nötig eine `assumption` anlegen:
   - `derivation_from_research_gap` ausfüllen.
3. Nur wirklich fundamentale angenommene Aussagen in `axioms` übernehmen.
4. `source_assumption_id` nutzen, wenn das Axiom aus einer dokumentierten Annahme hervorgeht.
5. Für jedes Axiom:
   - `motivation`
   - `independence_note`
   - `consistency_note`
   - `operationalization_note`
   fachlich ausfüllen.
6. Aus Axiomen folgende Aussagen in:
   - `propositions`,
   - `lemmas`,
   - `theorems`,
   - `corollaries`
   speichern.
7. Beweise in `proofs` ablegen.
8. Abhängigkeiten zwischen Axiomen/Sätzen nur mit tatsächlich vorhandenen Tabellen und Spalten abbilden.
9. Keine redundanten Axiome aufnehmen, wenn eine Aussage bereits beweisbar ist.

---

# 17. Literaturstrategie für 3.3

3.3 ist der originäre axiomatische Kern. Daraus folgt eine besondere Zitierdisziplin:

- **Definitionen etablierter Mathematik** dürfen auf 3.2 zurückverweisen oder dort vorausgesetzt werden; sie müssen nicht in 3.3 erneut lehrbuchartig entwickelt werden.
- **Forschungsstand und Forschungslücke** benötigen belastbare Literatur.
- **Originäre FRZK-Definitionen** sind Eigenleistung und brauchen nicht künstlich eine Literaturquelle.
- **Primäraxiome** sind als FRZK-Eigenannahmen transparent zu kennzeichnen; Literatur kann Motivation oder Abgrenzung liefern, darf aber nicht so dargestellt werden, als belege sie das neue Axiom.
- **Ableitungen** müssen eindeutig auf Definitionen/Axiome zurückführbar sein.
- **Vergleiche mit etablierter Physik** benötigen Primär- oder Standardquellen.
- Neue Quelle ab **[88]**.
- Keine Quelle nur deshalb einführen, um eine originäre Aussage „abzusichern“.

---

# 18. Was 3.3 ausdrücklich nicht tun darf

- Kapitel 3.2 erneut als Lehrbuch wiederholen.
- Axiome durch Definitionen verstecken.
- Definitionen als Naturgesetze behandeln.
- mathematische Möglichkeit mit physikalischer Realität gleichsetzen.
- eine spezielle Anwendung zur allgemeinen Theorie erklären.
- aus drei Komponenten drei Raumdimensionen folgern.
- aus vier Variablen eine vierdimensionale Raumzeit folgern.
- aus Information eine Dimension machen, ohne geometrische Struktur.
- aus Kopplung einen Abstand machen, ohne Brückenrelation.
- aus Symmetrie Stabilität folgern, ohne Satz.
- aus Korrelation Kausalität folgern.
- aus Markov-Pfeilen Raumzeitkausalität folgern.
- aus Noether-Erhaltung eine neue Dimension folgern.
- aus Graphsymmetrie eine spezielle räumliche Form folgern.
- aus relativer Geometrie eine absolute Position folgern.
- anwendungsspezifische Konstanten oder Objektzahlen in den universellen Axiomkern aufnehmen, sofern sie nicht als fundamental begründet werden.
- ein gewünschtes Resultat durch ein äquivalentes Axiom vorwegnehmen.

---

# 19. Arbeitsmodus im neuen Chat

## Wenn der Nutzer `weiter` schreibt

- keine Rückfrage,
- den nächsten geplanten Dissertationsteil vollständig im Chat schreiben,
- wissenschaftliche Qualität,
- Ich-Form,
- Quellenregeln beachten,
- Formeln + unmittelbar folgende Word-LaTeX-Zeile,
- keine Weblinks im Fließtext,
- am Abschnittsende:
  - Methodologische Betrachtungen,
  - Didaktische Betrachtungen,
  - Ergebnis und Übergang.

**Direkter nächster Inhalt nach diesem Übergabedokument:** `3.3.0`.

## Wenn der Nutzer `skript` schreibt

- bezieht sich auf den zuletzt vollständig geschriebenen Abschnitt,
- Repository-Schema erneut prüfen,
- vollständiges SQL im Chat,
- zusätzliche `.sql`,
- zusätzliche `.sha256`,
- keine `SIGNAL`-Gates,
- vollständige Quellen-/Objekt-/Revision-/Validierungsdaten.

---

# 20. Verbindliche Manuskriptdateien und lokaler Arbeitsstand

Im aktuellen Arbeitsverzeichnis vorhanden:

- `3.2 Mathematische Grundlagen_V2(1).docx`
- `3.2 Mathematische Grundlagen_V4.docx`
- `frzk_rkb_stand_ende_3.1.sql`
- sämtliche Repository-Skripte 3.2.0–3.2.31 inklusive SHA-Dateien.

Für den Neuaufbau war `3.2 Mathematische Grundlagen_V2(1).docx` als Manuskriptgrundlage festgelegt. Die später erzeugten Chatabschnitte und Repository-Skripte bilden jedoch den fortgeschriebenen Neuaufsatz bis 3.2.31. Ein neuer Chat darf deshalb keinen älteren DOCX-Stand gegen den neueren fortgeschriebenen Chat-/Repository-Stand ausspielen; bei Widersprüchen muss der tatsächlich zuletzt festgelegte Neuaufsatzstand maßgeblich behandelt und gegebenenfalls ausdrücklich abgeglichen werden.

---

# 21. Fachliche Hauptfunktion der Mathematik aus 3.2 für 3.3

Kapitel 3.2 liefert **Werkzeuge**, keine FRZK-Axiome.

Die Werkzeuge umfassen:

- Mengen und Relationen,
- Funktionen,
- lineare Räume,
- Basis/Dimension,
- lineare Operatoren,
- Norm/Skalarprodukt/Metrik,
- Topologie,
- Konvergenz/Vollständigkeit,
- Funktionenräume,
- Funktionale/Dualräume,
- Spektralstruktur,
- Projektionen,
- Differentiation,
- ODE/PDE,
- dynamische Systeme,
- Stabilität,
- Attraktoren,
- Mannigfaltigkeiten,
- riemannsche/pseudo-riemannsche Geometrie,
- Zusammenhang/Paralleltransport,
- Geodäten/Krümmung,
- lorentzsche Kausalität,
- Variationsprinzip,
- Hamilton-/Phasenraumstruktur,
- Symmetrie/Noether,
- Maß/Wahrscheinlichkeit,
- Entropie/Information,
- Produkt-/Kopplungsstrukturen,
- Korrelation,
- stochastische Prozesse/Markov-Strukturen,
- Graphen/Netzwerke/geometrische Einbettungen.

Kapitel 3.3 muss daraus nicht alles verwenden. **Universalität bedeutet nicht maximale mathematische Komplexität.** Universalität bedeutet, dass die minimal benötigten Strukturen so allgemein formuliert werden, dass sie nicht an einen einzelnen Spezialfall gebunden sind.

---

# 22. Leitfrage für jedes neue Objekt in 3.3

Vor jeder Definition, Annahme, jedem Axiom und jedem Satz ist intern zu prüfen:

1. Was genau ist das Objekt?
2. Ist es reine Mathematik oder FRZK-Eigenstruktur?
3. Warum wird es benötigt?
4. Welche Forschungslücke schließt es?
5. Ist es Definition, Annahme, Primäraxiom oder Ableitung?
6. Ist es universell?
7. Ist es unabhängig von einer konkreten Anwendung?
8. Ist es unabhängig von einer festen Objektzahl?
9. Wird eine Geometrie stillschweigend vorausgesetzt?
10. Wird eine Dimension stillschweigend vorausgesetzt?
11. Ist eine Aussage bereits aus vorherigen Objekten beweisbar?
12. Welche neuen Sätze müssen daraus folgen?
13. Welche Grenz-/Gegenfälle gibt es?
14. Wie ist sie operationalisierbar?
15. Welche Literatur motiviert oder grenzt sie ab?
16. Ist die Aussage mit den in 3.2 geklärten Nichtimplikationen konsistent?

---

# 23. Zielzustand des Übergangs

Nach diesem Übergabedokument gilt:

- Kapitel 3.2 ist abgeschlossen.
- Die Mathematik wird nicht weiter enzyklopädisch erweitert, solange 3.3 keinen konkreten Bedarf zeigt.
- Kapitel 3.3 beginnt methodisch, nicht mit einem vorschnellen Axiom.
- Erst 3.3.0 trennt Definition/Axiom/Ableitung und formuliert Universalität.
- 3.3.1 bestimmt die tatsächlichen wissenschaftlichen Lücken.
- Erst danach wird die minimale Primäraxiomatik endgültig festgelegt.
- Spezialfälle werden aus dem universellen Kern abgeleitet oder als Nichtableitbarkeit kenntlich gemacht.
- Das gleichseitige Dreieck ist **ein** Geometrietest unter vielen.
- Information als Dimension ist **ein** Strukturtest unter vielen.
- eine konkrete zusätzliche Position ist **ein** Eindeutigkeits-/Auswahltest unter vielen.
- Kein Spezialfall besitzt Vorrang bei der Konstruktion des Axiomkerns.

---

# 24. Startanweisung für einen neuen Chat

**Verbindliche Anweisung:**

> Verwende dieses MD-Dokument als vollständigen Übergabestand vom abgeschlossenen Kapitel 3.2 zu Kapitel 3.3. Behandle Universalität als oberstes Konstruktionsprinzip der FRZK-Axiomatik. Formuliere den Axiomkern nicht für ein Dreieck, eine Lampe, drei Knoten, eine Patentkonfiguration oder eine andere Einzelanwendung. Solche Fälle sind ausschließlich spätere Prüfungen universeller Aussagen. Beginne bei `weiter` mit Abschnitt **3.3.0 Axiomatischer Ausgangspunkt und Abgrenzung von Definition, Primäraxiom und Ableitung**. Danach folgt **3.3.1 Wissenschaftliche Lückenanalyse und Anforderungen an eine universelle FRZK-Axiomatik**. Leite erst anschließend die minimale Menge irreduzibler Primäraxiome ab. Prüfe vor jedem Repository-Skript das reale Datenbankschema und halte sämtliche Schreib-, Literatur-, Formel- und SQL-Regeln dieses Dokuments ein.

---

# 25. Kompakte Übergabeparameter

```text
Projekt: FRZK / Dissertation Kapitel 3
Abgeschlossen: 3.2.0–3.2.31
Kapitelstatus 3.2: final
Nächster Abschnitt: 3.3.0
Danach: 3.3.1
Letzte Definition 3.2: 3.2.306
Letzter Satz 3.2: 3.2.163
Letzte Gleichung: (3.2112)
Nächste Gleichung bei fortlaufender Kapitelzählung: (3.2113)
Letzte Literaturzahl: [87]
Nächste neue Literaturzahl: [88]
current_section: 3.3
last_completed_section: 3.2.31
last_completed_chapter: 3.2
Repository-Basis: frzk_rkb_stand_ende_3.1.sql
Kanonisches 3.2.0-Skript: frzk_3.2.0_repository_V4.sql
Letztes 3.2-Skript: frzk_3.2.31_repository.sql
Leitprinzip 3.3: UNIVERSALITÄT
Dreieck: nur ein möglicher Anwendungstest
Information als Dimension: nur ein möglicher Strukturtest
konkrete Position: nur ein möglicher Eindeutigkeits-/Auswahltest
Axiomkern: minimal, nichtzirkulär, anwendungsneutral, objektzahlneutral,
           darstellungsneutral und soweit möglich geometrieneutral
```
