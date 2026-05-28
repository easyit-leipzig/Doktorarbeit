# Auswertungspunkt 2 – Zeitversetzte Resonanzvalidierung

## Methodischer Kern
Verglichen wird der Lehrkraftzustand L_t mit dem späteren Teilnehmerzustand T_{t+n}. n bezeichnet reale Folgesitzungen innerhalb derselben Gruppe und desselben Teilnehmers, nicht Kalendertage.

## Ergebnisübersicht
| Sicht | Lag | n | Kosinus Mittel | Distanz Mittel | Korrelation Mittel |
|---|---:|---:|---:|---:|---:|
| alle_lehrkraefte | 1 | 137 | 0.7759 | 0.5742 | -0.2171 |
| alle_lehrkraefte | 2 | 104 | 0.8583 | 0.5139 | -0.2283 |
| alle_lehrkraefte | 3 | 79 | 0.8716 | 0.4854 | -0.2247 |
| lehrkraft_1 | 1 | 122 | 0.7658 | 0.5794 | -0.2092 |
| lehrkraft_1 | 2 | 94 | 0.8625 | 0.5070 | -0.2058 |
| lehrkraft_1 | 3 | 69 | 0.8784 | 0.4727 | -0.1825 |
| ohne_lehrkraft_1 | 1 | 15 | 0.8561 | 0.5325 | -0.2792 |
| ohne_lehrkraft_1 | 2 | 10 | 0.8187 | 0.5789 | -0.4400 |
| ohne_lehrkraft_1 | 3 | 10 | 0.8242 | 0.5729 | -0.5160 |

## Automatische Interpretation
Die stärkste mittlere Richtungsresonanz liegt in `lehrkraft_1` bei Lag n=3 mit Kosinus=0.8784.

Die geringste mittlere euklidische Distanz liegt in `lehrkraft_1` bei Lag n=3 mit Distanz=0.4727.

Die stärkste dimensionsbezogene Korrelation liegt in `lehrkraft_1` bei Lag n=3 mit r=-0.1825.

Interpretativ ist besonders relevant, ob Lag n=1, n=2 oder n=3 systematisch höhere Kosinuswerte und niedrigere Distanzen aufweist. Dann würde nicht nur Gleichzeitigkeit, sondern zeitversetzte pädagogische Kopplung sichtbar.

## Erzeugte Dateien
- summary_by_lag.csv
- kosinus_by_lag.png
- distanz_by_lag.png
- korrelation_by_lag.png