# Konzept für Anlage M5 – Algebraische Eigenstruktur, Diagonalisierung und Spektralrechnung

## 1. Gesamturteil

Die analysierten Unterlagen ergeben eine sehr klare mathematische Übergabestelle. Anlage M5 soll weder eine Wiederholung von M3/M4 noch eine Vorwegnahme von M6 werden. Ihr eigenständiger Gegenstand ist die algebraische Eigenstruktur eines endlichdimensionalen Endomorphismus über einem ausdrücklich festgelegten Skalarkörper.

Die tragende Begründungsrichtung sollte lauten:

Endomorphismus → Eigenwert/Eigenvektor → Eigenraum als Kern → spektrales Kriterium über Kern/Rang/Invertierbarkeit → charakteristisches Polynom → algebraische und geometrische Vielfachheit → direkte Summe der Eigenräume → Eigenbasis/Diagonalisierbarkeit → algebraische Spektralprojektoren → spektrale Zerlegung → Matrixfunktionen im diagonalisierbaren Fall.

Diese Richtung setzt die in M1–M4 konsequent verwendete Trennung fort:

abstraktes mathematisches Objekt → basisabhängige Darstellung → Berechnungs- bzw. Auswertungsverfahren.

Zwei Ergänzungen gegenüber dem bisherigen M4→M5-Arbeitsvorschlag sind für eine wirklich geschlossene M5-Struktur notwendig:

1. Vor der Verwendung des charakteristischen Polynoms müssen die minimal benötigten polynomialen Begriffe explizit gesichert werden: Polynom über K, Nullstelle, Faktor und Vielfachheit einer Nullstelle. M3 hat Polynomausdrücke p(A) bereits vorbereitet, aber noch keine vollständige Polynomtheorie für algebraische Vielfachheiten aufgebaut.
2. „Matrixfunktionen“ sollten in M5 ausdrücklich auf den diagonalisierbaren beziehungsweise algebraisch spektral zerlegbaren Fall begrenzt werden. Eine allgemeine Matrixfunktion für nicht diagonalisierbare Matrizen führt zu Jordanstruktur, Ableitungsbedingungen oder allgemeinerem Funktionalkalkül und würde den vorgesehenen Umfang deutlich erweitern.

## 2. Ergebnis der Dateianalyse

### M1

M1 liefert den allgemeinen Funktionsbegriff, Bild und Urbild, Injektivität, Surjektivität, Bijektivität, Identität und Komposition. Für M5 ist M1 kein unmittelbarer mathematischer Hauptlieferant, aber methodisch wichtig: Begriffe werden erst nach ihren Voraussetzungen eingeführt und dürfen nicht rückwirkend umgedeutet werden.

### M2

M2 ist für M5 fundamentaler, als der bisherige Arbeitsplan erkennen lässt. Der Skalarkörper K ist Teil der Vektorraumstruktur. M2 hält ausdrücklich fest, dass Eigenwert- und Spektralaussagen vom verwendeten Körper abhängen können. Daraus folgt für M5:

- Spektrum immer als Spektrum über K kennzeichnen.
- Keine stillschweigende Komplexifizierung.
- Reelle und komplexe Fälle nicht definitorisch gleichsetzen.
- Bei Aussagen über vollständige Faktorisierung des charakteristischen Polynoms eine Zerfällungsannahme oder eine ausdrücklich genannte zusätzliche Aussage verwenden.

### M3

M3 liefert den eigentlichen darstellungsbezogenen Unterbau von M5:

- Endomorphismen;
- quadratische Darstellungsmatrizen;
- Basiswechsel und Ähnlichkeit;
- Invertierbarkeit;
- Determinante;
- Determinantenkriterium;
- Potenzen und Polynomausdrücke p(A);
- Invarianz polynomialer Ausdrücke unter Ähnlichkeit.

Besonders wichtig ist M3.8.11. Dort ist bereits vorbereitet, dass bei ähnlichen Matrizen A und A' auch p(A) und p(A') durch dieselbe Ähnlichkeit verbunden sind. Genau dies ist später für charakteristische Struktur, Spektralprojektoren und Matrixfunktionen nutzbar.

### M4

M4 liefert die zweite Hauptsäule:

- Kern und Bild;
- Rang und Nullität;
- Rang-Nullität;
- Injektivitäts-/Surjektivitätskriterien;
- vollständige Theorie homogener Gleichungssysteme;
- Invertierbarkeits- und Rangkriterien für quadratische Matrizen.

Damit kann M5 nach seiner eigenen Eigenwertdefinition die Beziehung

(T - λI)v = 0

als Kernfrage lesen und anschließend die gesamte M4-Struktur benutzen. Entscheidend bleibt: M4 hat keine spektralen Begriffe definiert. Der Übergang zu Eigenräumen entsteht erst in M5.

### Kapitel 3.1

Kapitel 3.1 stützt den methodischen Aufbau von M5 deutlich:

- Vorrang strukturerhaltender Transformationen;
- funktionale Anschlussfähigkeit von Definitionen;
- keine rückwirkende Begriffsentwicklung;
- Trennung von Formalismus und Interpretation;
- Modularität und Abhängigkeitskontrolle.

Für M5 bedeutet dies insbesondere: Eigenwerte, Eigenräume und Spektralprojektoren bleiben zunächst rein mathematische Strukturen. Eine physikalische oder FRZK-spezifische Deutung gehört nicht in die Anlage.

Auffällig ist eine Benennungskollision: Kapitel 3.1 verwendet bereits „Methodologischer Grundsatz M5“. Dieser Bezeichner ist nicht mit „Anlage M5“ identisch. In der weiteren Arbeit sollte deshalb nie isoliert auf „M5“ verwiesen werden, wenn der methodologische Grundsatz gemeint ist.

### Übergabe M4→M5

Die Übergabe definiert den geplanten Gegenstand sachgerecht: Eigenwerte, Eigenvektoren, Eigenräume, charakteristisches Polynom, algebraische und geometrische Vielfachheit, Diagonalisierbarkeit, algebraische Spektralprojektoren und Matrixfunktionen; Orthogonalität wird ausdrücklich nicht vorausgesetzt.

Der dort vorgeschlagene Zehn-Abschnitts-Plan ist grundsätzlich tragfähig, sollte aber inhaltlich präzisiert werden, damit Polynomvoraussetzungen, Körperabhängigkeit und die Begrenzung der Matrixfunktionen nicht als versteckte Voraussetzungen auftreten.

### SQL-/Repository-Stand

Der hochgeladene SQL-Dump widerspricht dem textlichen Übergabestatus. Das Zielmodul M5 ist korrekt als `planned` und leer vorhanden. Das Gate `RKB32-M4M5-TARGET-CLEAN` ist bestanden.

Das Gesamtgate ist jedoch nicht bestanden. Im Dump stehen unter anderem:

- `RKB32-M4M5-PREDECESSOR = failed`
- `RKB32-M4M5-SECTIONS = failed`
- `RKB32-M4M5-EQUATIONS = failed`
- `RKB32-M4M5-WORDLATEX-HASH = failed`
- `RKB32-M4M5-HANDOFF-SOURCES = failed`
- `RKB32-M4-FINAL-GATE = failed`
- `RKB32-M4M5-FINAL-GATE = failed`

Der Dump sieht nur drei M4-Abschnitte und 244 M4-Gleichungen, während das M4-Dokument und das Übergabe-MD 13 Abschnitte und 1601 Gleichungen ausweisen.

Folgerung: Das M5-Konzept kann vollständig festgelegt werden, die kanonische Erstellung von M5.0 darf aber erst nach Reparatur beziehungsweise Synchronisierung des Repository-Stands und erneut bestandenem M4→M5-Gate beginnen.

## 3. Empfohlene fachliche Grenzen von M5

M5 ist eine endlichdimensionale algebraische Spektraltheorie. Sie setzt keinen metrischen Raum voraus.

In M5 gehören:

- Eigenwerte und Eigenvektoren;
- Spektrum über dem gewählten Skalarkörper;
- Eigenräume;
- charakteristisches Polynom;
- algebraische und geometrische Vielfachheit;
- lineare Unabhängigkeit zu verschiedenen Eigenwerten;
- direkte Summen von Eigenräumen;
- Eigenbasis;
- Diagonalisierbarkeit;
- Ähnlichkeit zu Diagonalmatrizen;
- algebraische Spektralprojektoren;
- algebraische spektrale Zerlegung;
- Matrixfunktionen im diagonalisierbaren Fall.

Nicht in M5 gehören:

- Skalarprodukt und induzierte Norm;
- Winkel und Orthogonalität;
- orthonormale Basen;
- orthogonale Projektoren;
- Adjungierte;
- selbstadjungierte oder normale Operatoren;
- unitäre/orthogonale Diagonalisierung;
- der innereproduktspezifische Spektralsatz;
- SVD;
- Least Squares.

Ebenfalls nicht in den Kernumfang von M5 aufnehmen würde ich ohne konkrete spätere Notwendigkeit:

- verallgemeinerte Eigenvektoren;
- Jordansche Normalform;
- Minimalpolynom;
- allgemeine Matrixfunktionen für nicht diagonalisierbare Matrizen;
- analytischen oder holomorphen Funktionalkalkül.

Diese Themen sind mathematisch legitim, würden M5 aber zu einer wesentlich größeren Theorie machen. Für die im Repository genannte Zielsetzung sind sie nicht notwendig.

## 4. Empfohlene Abschnittsarchitektur

### M5.0 – Gegenstand, Eingangsstelle, Grenzen und Aufbau

Aufgaben:

- vollständige Übernahme aus M2, M3 und M4 benennen;
- Endomorphismus als eigentlichen Objekttyp festlegen;
- allgemeinen Skalarkörper K beibehalten;
- Körperabhängigkeit des Spektrums ankündigen;
- klare Grenze zu M6;
- klare Grenze zum späteren 3.2-Haupttext;
- Objekt–Darstellung–Verfahren-Trennung fortschreiben;
- gesamte Abhängigkeitskette von M5 als Zielstruktur markieren, ohne spätere Sätze vorwegzunehmen.

### M5.1 – Eigenwerte, Eigenvektoren und algebraisches Spektrum

Ausgangspunkt ist ein endlichdimensionaler Vektorraum V über K und ein Endomorphismus T:V→V.

Reihenfolge:

1. Gleichung T(v)=λv als Ausgangsfrage;
2. Ausschluss v=0 bei der Eigenvektordefinition;
3. Definition Eigenwert;
4. Definition Eigenvektor;
5. Definition des Spektrums σ_K(T) als Menge aller Eigenwerte in K;
6. Darstellungsebene Av=λv erst danach;
7. Körperabhängigkeit ausdrücklich behandeln.

Zentrale Grenzaussage:

Der Nullvektor ist kein Eigenvektor, weil sonst T(0)=λ0 für jedes λ gelten und der Eigenwertbegriff seine Unterscheidungskraft verlieren würde.

### M5.2 – Eigenräume als Kerne und dimensionsbezogene Spektralstruktur

Nach M5.1 wird umgeformt:

T(v)=λv ⇔ (T-λI)v=0.

Dann:

E_λ(T)=ker(T-λI).

Jetzt darf M4 vollständig verwendet werden.

Zu entwickeln:

- Eigenraum als Untervektorraum;
- Eigenvektoren zum Eigenwert λ sind genau die von Null verschiedenen Elemente von E_λ(T);
- λ ist Eigenwert genau dann, wenn E_λ(T) nicht trivial ist;
- λ ist Eigenwert genau dann, wenn T-λI nicht injektiv ist;
- im endlichdimensionalen Endomorphismusfall äquivalent zu Nichtinvertierbarkeit;
- Matrixkriterium über Rangabfall;
- lineare Unabhängigkeit von Eigenvektoren zu paarweise verschiedenen Eigenwerten;
- direkte Summe verschiedener Eigenräume;
- Verhalten von Eigenräumen unter Basiswechsel/Ähnlichkeit.

Dieser Abschnitt bildet die wichtigste Brücke M4→M5.

### M5.3 – Polynomiale Voraussetzung, charakteristisches Polynom und Eigenwertkriterium

Vor der algebraischen Vielfachheit muss M5 die minimal benötigten polynomialen Begriffe sichern:

- Polynom über K;
- Grad;
- Nullstelle;
- Faktor t-λ;
- Vielfachheit einer Nullstelle;
- Zerfallen eines Polynoms über K.

Danach erst:

- Definition des charakteristischen Polynoms einer Matrix;
- eindeutige Vorzeichenkonvention festlegen und nicht wechseln;
- Eigenwertkriterium über det(A-λI)=0;
- Basisinvarianz des charakteristischen Polynoms unter Ähnlichkeit;
- daraus charakteristisches Polynom eines Endomorphismus als basisunabhängige Struktur;
- Spektrum als Nullstellenmenge des charakteristischen Polynoms im Körper K;
- Körperabhängigkeit: Das Polynom kann über K nicht vollständig zerfallen.

Wichtig: Der Eigenwert darf nicht erst durch die Nullstelle des charakteristischen Polynoms definiert werden. Die Nullstellenbedingung ist ein nachträglich bewiesenes äquivalentes Kriterium.

### M5.4 – Algebraische und geometrische Vielfachheit

Definitionen:

- algebraische Vielfachheit = Vielfachheit von λ als Nullstelle des charakteristischen Polynoms;
- geometrische Vielfachheit = dim E_λ(T) = nullity(T-λI).

Zu beweisen:

1 ≤ geometrische Vielfachheit ≤ algebraische Vielfachheit.

Für über K zerfallendes charakteristisches Polynom:

Summe der algebraischen Vielfachheiten = dim V.

Die Körperbedingung muss ausdrücklich an der Aussage stehen.

### M5.5 – Eigenbasen und Diagonalisierbarkeit

Definition nicht über eine fertige Diagonalmatrix beginnen, sondern über die Existenz einer Eigenbasis.

Danach Äquivalenzen entwickeln:

- T ist diagonalisierbar;
- V besitzt eine Basis aus Eigenvektoren;
- V ist direkte Summe seiner Eigenräume;
- Summe der Dimensionen der Eigenräume ist dim V;
- es existiert eine Basis, bezüglich der T durch eine Diagonalmatrix dargestellt wird;
- eine Matrixdarstellung A ist ähnlich zu einer Diagonalmatrix.

Bei zerfallendem charakteristischem Polynom kann zusätzlich formuliert werden:

T ist genau dann diagonalisierbar, wenn für jeden Eigenwert geometrische und algebraische Vielfachheit übereinstimmen.

Als einfaches hinreichendes Kriterium:

dim V paarweise verschiedene Eigenwerte ⇒ diagonalisierbar.

### M5.6 – Algebraische Spektralprojektoren

Aus der direkten Summe

V = E_{λ1} ⊕ ... ⊕ E_{λr}

wird für jedes i zunächst abstrakt der Projektor P_i auf E_{λi} entlang der Summe der übrigen Eigenräume definiert.

Zu beweisen:

- P_i ist linear;
- P_i²=P_i;
- im(P_i)=E_{λi};
- ker(P_i)=⊕_{j≠i}E_{λj};
- P_iP_j=0 für i≠j;
- Summe P_i=I.

Erst danach die polynomiale Darstellung:

P_i = ∏_{j≠i}(T-λ_j I)/(λ_i-λ_j).

Dies baut direkt auf M3.8.11 auf.

Ausdrücklich festhalten:

Diese Projektoren sind algebraische Projektoren. Ohne Skalarprodukt ist keine Aussage über Orthogonalität zulässig.

### M5.7 – Algebraische spektrale Zerlegung

Aus den Projektoren folgt:

T = Σ λ_i P_i.

Ebenso:

T^m = Σ λ_i^m P_i

für natürliche Potenzen.

Dieser Abschnitt ist die eigentliche algebraische Spektralzerlegung von M5. Er ist basisfrei formuliert und wird erst anschließend in einer Eigenbasis zur Diagonaldarstellung.

### M5.8 – Matrixfunktionen im diagonalisierbaren Fall

Die Theorie sollte bewusst nicht als allgemeine Theorie von Matrixfunktionen formuliert werden.

Für eine Funktion f:σ_K(T)→K kann im diagonalisierbaren Fall definiert werden:

f(T)=Σ f(λ_i)P_i.

Zu zeigen:

- Unabhängigkeit von der gewählten Eigenbasis;
- Verträglichkeit mit polynomialen Ausdrücken aus M3;
- in einer Eigenbasis wird f(T) diagonal durch f(λ_i);
- bei A=SDS^{-1} gilt f(A)=Sf(D)S^{-1};
- bei Polynomen stimmt diese Definition mit p(T) überein;
- keine komponentenweise Anwendung von f auf die Matrixeinträge.

Mögliche Beispiele nur unter klarer Zusatzvoraussetzung:

- Potenzen;
- inverse Abbildung, falls 0 nicht im Spektrum liegt;
- Polynomfunktionen.

Exponential-, Logarithmus- oder Wurzelfunktionen sollten nur aufgenommen werden, wenn K und die jeweilige Funktion ausdrücklich ausreichend strukturiert sind.

### M5.9 – Ergebnisbestand und Übergabe von M5

Keine neue Theorie mehr.

Kanonisch konsolidieren:

- Eigenwert/Eigenvektor;
- Spektrum;
- Eigenraum als Kern;
- Rang-/Determinantenkriterium;
- charakteristisches Polynom;
- algebraische/geometrische Vielfachheit;
- Diagonalisierbarkeit;
- direkte Eigenraumzerlegung;
- algebraische Spektralprojektoren;
- spektrale Zerlegung;
- Matrixfunktionen im diagonalisierbaren Fall.

Übergabe:

M5 → M6: lineare Eigenstruktur, Eigenraumzerlegung, algebraische Projektoren und algebraische Spektraldarstellung.

M6 ergänzt erst anschließend Skalarprodukt, Orthogonalität, Adjungierte und den metrisch-orthogonalen Spektralsatz.

## 5. Zentrale Nichtzirkularitätsregeln

Verbindliche Begründungsrichtung:

Eigenwertdefinition → Kernbeziehung → Rang/Invertierbarkeit → Determinantenkriterium → charakteristisches Polynom → Vielfachheiten → direkte Eigenraumsumme → Diagonalisierbarkeit → Projektoren → Spektralzerlegung → Matrixfunktionen.

Nicht zulässig:

- Eigenwert über det(A-λI)=0 definieren und anschließend T(v)=λv nur als Folgerung behandeln;
- Eigenraum über Gauß-Verfahren definieren;
- algebraische Vielfachheit verwenden, bevor Nullstellenvielfachheit definiert ist;
- Diagonalisierbarkeit voraussetzen, um die Unabhängigkeit von Eigenvektoren verschiedener Eigenwerte zu beweisen;
- Spektralprojektoren zur Begründung der Diagonalisierbarkeit einsetzen, wenn sie erst aus der direkten Eigenraumzerlegung konstruiert werden;
- orthogonale Eigenschaften in algebraische Projektoren hineinlesen;
- spätere M6-Sätze rückwirkend zur Begründung von M5 verwenden.

## 6. Empfohlene kanonische Kernrelationen

Die spätere M5-Fassung sollte mindestens folgende mathematische Knoten explizit enthalten:

- T(v)=λv, v≠0;
- (T-λI)v=0;
- E_λ(T)=ker(T-λI);
- λ∈σ_K(T) ⇔ ker(T-λI)≠{0};
- λ∈σ_K(T) ⇔ rank(T-λI)<dim V;
- λ∈σ_K(T) ⇔ T-λI nicht invertierbar;
- λ∈σ_K(T) ⇔ det(A-λI)=0;
- geometrische Vielfachheit = dim E_λ(T);
- direkte Summe der Eigenräume bei Diagonalisierbarkeit;
- A=SDS^{-1};
- P_i²=P_i;
- P_iP_j=0 für i≠j;
- ΣP_i=I;
- T=Σλ_iP_i;
- f(T)=Σf(λ_i)P_i.

## 7. Literaturkonzept

Die bereits kanonischen Quellen Lang [[71]] und Strang [[72]] reichen für Eigenwerte, Eigenräume, charakteristisches Polynom, Vielfachheiten und Diagonalisierung grundsätzlich aus.

Für die methodische Prüfung des Konzepts ist zusätzlich Sheldon Axler, Linear Algebra Done Right, 4. Auflage, besonders hilfreich. Seine Struktur bestätigt die Trennung von algebraischer Diagonalisierung und der erst später auf Inner-Product-Spaces beruhenden Spektraltheorie.

Für den Matrixfunktionsabschnitt ist Nicholas J. Higham die wesentlich passendere Spezialquelle. Higham zeigt zugleich, warum eine uneingeschränkte Theorie allgemeiner Matrixfunktionen ohne Jordan-/Interpolations-/Cauchy-Struktur deutlich über den vorgesehenen M5-Rahmen hinausgeht.

Wichtig für das Repository: Für Axler oder Higham keine Literaturziffer erfinden. Eine Verwendung im Dissertationstext darf erst nach Aufnahme und Verifikation als kanonische Repository-Quelle erfolgen.

## 8. Technischer Startzustand

Vor M5.0 muss zuerst der Repository-Widerspruch behoben werden.

Sollzustand:

- M4.0–M4.12 vollständig im Repository;
- 1601 M4-Gleichungen;
- alle M4-Abschnittsgates passed;
- M4.12-Final-Gate passed;
- M4-Gesamtgate passed;
- M4→M5-Final-Gate passed;
- M5 exakt einmal vorhanden;
- M5 status=planned;
- keine M5-Abschnitte, -Versionen oder -Objekte.

Erst danach M5.0 schreiben.

## 9. Schlussfolgerung

Das vorhandene M4→M5-Konzept ist in seiner Grundrichtung richtig, aber noch nicht vollständig gegen versteckte Voraussetzungen abgesichert. Die wichtigste Verbesserung besteht darin, drei Punkte explizit zu machen:

1. Die Körperabhängigkeit des Spektrums stammt bereits aus M2 und muss durch ganz M5 hindurch sichtbar bleiben.
2. Das charakteristische Polynom benötigt eine kleine, ausdrücklich ausgewiesene polynomiale Vorstruktur.
3. Spektralprojektoren und Matrixfunktionen sollten bewusst auf den diagonalisierbaren, algebraisch spektral zerlegten Fall beschränkt werden, solange M5 keine Jordan-/Minimalpolynomtheorie entwickelt.

Damit bleibt M5 kompakt, vollständig, nichtzirkulär und sauber von M6 getrennt.
