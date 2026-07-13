-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Jul 2026 um 13:27
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `frzk_rkb`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `acronyms`
--

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

--
-- Daten für Tabelle `acronyms`
--

INSERT INTO `acronyms` (`acronym_id`, `acronym`, `full_form`, `explanation`, `first_section_id`, `language_code`, `category`, `is_project_specific`, `validation_status`, `created_revision_id`) VALUES
(1, 'FRZK', 'Funktionales Raum-Zeit-Kohärenzsystem', 'Zentrale, in dieser Dissertation entwickelte Theorie zur funktionalen Herleitung von Raum, Zeit und Kohärenz.', 1, 'de', 'Theorie', 1, 'checked', 3),
(2, 'ZFC', 'Zermelo-Fraenkel-Mengenlehre mit Auswahlaxiom', 'Axiomatische Grundlage großer Teile der modernen Mathematik.', 9, 'de', 'Mathematik', 0, 'checked', 6),
(3, 'KL', 'Kullback-Leibler', 'Bezeichnung der Kullback-Leibler-Divergenz.', 17, 'de', 'Informationstheorie', 0, 'checked', 6),
(4, 'ODE', 'Ordinary Differential Equation', 'Gewöhnliche Differentialgleichung.', 14, 'en', 'Mathematik', 0, 'checked', 6),
(5, 'PDE', 'Partial Differential Equation', 'Partielle Differentialgleichung.', 15, 'en', 'Mathematik', 0, 'checked', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `annotations`
--

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

--
-- Daten für Tabelle `annotations`
--

INSERT INTO `annotations` (`annotation_id`, `source_id`, `contribution`, `significance_for_dissertation`, `citation_reason`, `adopted_claims`, `limitations`, `scientific_discussion`, `annotation_status`, `reviewed_at`) VALUES
(1, 1, 'Grundlegende Analyse von Ort und Zeit als Ordnung körperlicher Gegenstände bzw. Maß der Veränderung.', 'Historischer Ausgangspunkt des Raum- und Zeitbegriffs in 3.1.', 'Belegt die frühe relationale und bewegungsbezogene Bestimmung von Raum und Zeit.', 'Raum als Ort; Zeit als Maß von Bewegung hinsichtlich Früher und Später.', 'Historische Quelle; keine moderne mathematische Formalisierung.', 'Wird Newtons absolutem Raum-Zeit-Konzept gegenübergestellt.', 'reviewed', NULL),
(2, 2, 'Formuliert den absoluten Raum und die absolute Zeit als unabhängigen Bezugsrahmen der klassischen Mechanik.', 'Dient in 3.1 als Gegenposition zu relationalen Raum-Zeit-Konzepten.', 'Belegt die klassische Setzung von Raum und Zeit als primitive Größen.', 'Absoluter Raum; absolute Zeit; unabhängiger Rahmen physikalischer Prozesse.', 'Historische Physik; durch Relativitätstheorie in ihrem universellen Anspruch begrenzt.', 'Wird mit Mach, Einstein und Minkowski kontrastiert.', 'reviewed', NULL),
(3, 3, 'Kritisiert unbeobachtbare absolute Größen und betont Relationen zwischen physikalischen Systemen.', 'Unterstützt den Übergang vom absoluten zum relationalen Raum-Zeit-Verständnis.', 'Belegt die wissenschaftshistorische Kritik an Newtons absoluten Größen.', 'Empirische Bedeutung relationaler Größen; Kritik an absolutem Raum und absoluter Zeit.', 'Noch keine vollständige relativistische Raumzeit-Theorie.', 'Historischer Vorläufer der Relativitätstheorie.', 'reviewed', NULL),
(4, 4, 'Begründet die Spezielle Relativitätstheorie und hebt die Trennung absoluter Raum- und Zeitgrößen auf.', 'Zentrale Referenz für die wissenschaftliche Entwicklung zur gemeinsamen Raumzeit.', 'Belegt die Relativierung räumlicher und zeitlicher Messgrößen.', 'Relativität von Gleichzeitigkeit, Raum und Zeit; Konstanz der Lichtgeschwindigkeit.', 'Behandelt keine Gravitation und keine Genese der Raumzeit.', 'Wird durch Einstein 1916 und Minkowski geometrisch erweitert.', 'reviewed', NULL),
(5, 5, 'Formuliert die Allgemeine Relativitätstheorie und verbindet Raumzeitgeometrie mit Materie und Energie.', 'Belegt die Dynamisierung der Geometrie, ohne die Raumzeit selbst aus tieferen Prinzipien herzuleiten.', 'Dient als maßgeblicher Stand physikalischer Raumzeitbeschreibung.', 'Raumzeitkrümmung; Gravitation als geometrische Eigenschaft.', 'Setzt eine differenzierbare Raumzeitmannigfaltigkeit voraus.', 'Zentraler Vergleichspunkt für die FRZK-Abgrenzung.', 'reviewed', NULL),
(6, 6, 'Vereinigt Raum und Zeit mathematisch in einer vierdimensionalen Raumzeitstruktur.', 'Liefert den geometrischen Formalismus für die relativistische Raumzeitdarstellung.', 'Belegt den Übergang von getrennten Größen zu einer gemeinsamen mathematischen Struktur.', 'Vierdimensionale Raumzeit; geometrische Vereinheitlichung.', 'Setzt die Raumzeitstruktur voraus und erklärt nicht ihre Genese.', 'Erweitert die Spezielle Relativitätstheorie geometrisch.', 'reviewed', NULL),
(7, 7, 'Begründet die klassische axiomatische Geometrie aus primitiven Begriffen und Postulaten.', 'Dient als historischer Ausgangspunkt der axiomatischen Raumkonstruktion.', 'Belegt, dass Geometrien mit vorausgesetzten Punkten, Geraden und Ebenen beginnen.', 'Axiomatische Ableitung geometrischer Aussagen.', 'Primitive Begriffe werden nicht genetisch hergeleitet.', 'Wird durch Hilberts formale Axiomatik präzisiert.', 'reviewed', NULL),
(8, 8, 'Formuliert eine streng axiomatische Geometrie und präzisiert die Rolle primitiver Begriffe.', 'Grundlage für die Diskussion von Konsistenz, Unabhängigkeit und Minimalität der FRZK-Axiomatik.', 'Belegt die Notwendigkeit klarer Grundannahmen und die Grenzen definitorischer Rückführung.', 'Axiomatische Methode; primitive Begriffe; Konsistenz und Unabhängigkeit.', 'Die Geometrie setzt ihre Grundobjekte weiterhin voraus.', 'Verbindet 3.1 mit der Axiomatik in 3.3.', 'reviewed', NULL),
(9, 9, 'Systematisiert topologische Räume und deren strukturelle Eigenschaften.', 'Belegt, dass moderne Topologie Mengen und Nachbarschaftsstrukturen voraussetzt.', 'Dient als Referenz für die mathematische Reichweite und Voraussetzung topologischer Modelle.', 'Topologische Räume; Nachbarschaften; Stetigkeit.', 'Keine Herleitung der zugrunde liegenden Menge oder Topologie.', 'Wird in 3.2 und 3.4 erneut relevant.', 'reviewed', NULL),
(10, 10, 'Stellt die mathematischen Grundlagen differenzierbarer und riemannscher Mannigfaltigkeiten dar.', 'Belegt die strukturellen Voraussetzungen moderner Raumtheorien.', 'Referenz für die Aussage, dass Differentialgeometrie bereits differenzierbare Räume voraussetzt.', 'Mannigfaltigkeiten; Tangentialräume; riemannsche Strukturen.', 'Keine Genese des zugrunde liegenden Raumes.', 'Relevant für die Abgrenzung des FRZK von klassischer Raumgeometrie.', 'reviewed', NULL),
(11, 11, 'Standardwerk zu Banach- und Hilberträumen sowie linearen Operatoren.', 'Mathematische Grundlage für 3.2 zu Zustandsräumen, Funktionalanalysis und Operatoren.', 'Belegt, dass Operatoren auf bereits definierten Funktionen- und Zustandsräumen wirken.', 'Normierte Räume; Vollständigkeit; Operatoren; Dualität.', 'Setzt den Raum und seine Struktur voraus.', 'Wird in 3.2 mehrfach wiederverwendet.', 'reviewed', NULL),
(12, 12, 'Entwickelt die Synergetik als Theorie selbstorganisierter makroskopischer Ordnungsbildung.', 'Direkte Grundlage für Emergenz, Selbstorganisation und Attraktoren in 3.2 und 3.4.', 'Belegt, dass globale Ordnung aus lokalen Wechselwirkungen und Ordnungsparametern entstehen kann.', 'Ordnungsparameter; Versklavungsprinzip; Selbstorganisation.', 'Arbeitet in vorausgesetzten Zustandsräumen und Dynamiken.', 'Verbindet Komplexitätstheorie mit der späteren FRZK-Strukturbildung.', 'reviewed', NULL),
(13, 13, 'Stellt dissipative Strukturen und nichtgleichgewichtige Selbstorganisation dar.', 'Unterstützt die Argumentation zur Entstehung stabiler Strukturen aus Dynamik.', 'Belegt die produktive Rolle von Nichtgleichgewicht und Rekursion.', 'Dissipative Strukturen; Irreversibilität; Ordnung aus Fluktuation.', 'Populärwissenschaftlicher als die Primärarbeiten Prigogines; später durch Originalquellen zu ergänzen.', 'Verwandt mit Haken und komplexen adaptiven Systemen.', 'reviewed', NULL),
(14, 14, 'Beschreibt komplexe adaptive Systeme und emergente Ordnung aus lokalen Regeln.', 'Dient als Brücke zwischen mathematischer Dynamik, Adaptation und emergenter Systemstruktur.', 'Belegt die Entstehung globaler Muster durch rekursive lokale Interaktionen.', 'Adaptive Agenten; Rückkopplung; emergente Ordnung.', 'Nicht als axiomatische Mathematik formuliert.', 'Ergänzt Haken, Prigogine und Netzwerkforschung.', 'reviewed', NULL),
(15, 15, 'Systematisiert moderne Netzwerkwissenschaft, Wachstumsmodelle und skalenfreie Strukturen.', 'Grundlage für Graphen- und Netzwerktheorie in 3.2 sowie relationale FRZK-Strukturen in 3.4.', 'Belegt, dass einfache Wachstumsregeln komplexe globale Netzwerke erzeugen.', 'Netzwerkwachstum; Gradverteilungen; Zentralität; Robustheit.', 'Setzt Knoten und Kanten als primitive Strukturen voraus.', 'Wird mit klassischer Graphentheorie und dynamischen Netzwerken ergänzt.', 'reviewed', NULL),
(16, 16, 'Formuliert klassische Mechanik in geometrischer und dynamischer Systemsprache.', 'Referenz für Zustandsräume, Phasenräume und zeitabhängige Entwicklungen in 3.2.', 'Belegt, dass dynamische Systeme vorgegebene Zustandsräume und Entwicklungsgesetze voraussetzen.', 'Hamiltonsche Dynamik; Phasenraum; Flüsse.', 'Beschreibt Entwicklung im Raum, nicht die Genese des Raumes.', 'Zentrale Standardquelle für 3.2.8.', 'reviewed', NULL),
(17, 17, 'Beweist die Unvollständigkeit hinreichend mächtiger formaler Systeme.', 'Begrenzt den Vollständigkeitsanspruch der späteren FRZK-Axiomatik.', 'Belegt, dass formale Systeme prinzipielle interne Grenzen besitzen.', 'Unvollständigkeit; Unentscheidbarkeit; Grenzen formaler Systeme.', 'Keine Aussage gegen die praktische Tragfähigkeit konsistenter Axiomensysteme.', 'Wird in 3.3 zur methodischen Einordnung genutzt.', 'reviewed', NULL),
(18, 18, 'Versucht, große Teile der Mathematik aus wenigen logischen Grundannahmen abzuleiten.', 'Referenz für axiomatische Sparsamkeit und logische Fundierung.', 'Belegt den historischen Anspruch minimaler primitiver Begriffe.', 'Logizismus; formale Ableitung; axiomatische Reduktion.', 'Das Programm wird durch Gödels Resultate prinzipiell begrenzt.', 'Historischer Bezug zwischen Axiomatik und formaler Logik.', 'reviewed', NULL),
(19, 19, 'Stellt die Loop-Quantengravitation und diskrete geometrische Größen dar.', 'Dient zur Einordnung emergenter bzw. nichtklassischer Raumzeitkonzepte.', 'Belegt, dass moderne Physik die Fundamentalität kontinuierlicher Raumzeit hinterfragt.', 'Quantisierte Fläche und Volumen; spin-netzartige Strukturen.', 'Setzt mathematische Netzwerk- und Zustandsstrukturen voraus.', 'Wird mit Stringtheorie und Informationsansätzen verglichen.', 'reviewed', NULL),
(20, 20, 'Systematisiert die mathematischen Grundlagen der Superstringtheorie.', 'Referenz für höherdimensionale Raumzeitmodelle im Forschungsstand.', 'Belegt alternative mikroskopische Strukturen der Raumzeit.', 'Strings; zusätzliche Dimensionen; konsistente Quantisierung.', 'Setzt hochentwickelte mathematische Räume und Strukturen voraus.', 'Kontrastiert mit Loop-Quantengravitation und FRZK-Zielsetzung.', 'reviewed', NULL),
(21, 21, 'Formuliert das Programm „It from Bit“, nach dem physikalische Wirklichkeit aus Information hervorgehen könnte.', 'Zentrale Brücke zwischen Physik, Information und funktionaler Genese.', 'Belegt die Forschungslinie, Information als fundamentalen Ausgangspunkt zu behandeln.', 'It from Bit; informationelle Grundlage physikalischer Realität.', 'Keine vollständige mathematische Herleitung von Raum, Zeit und Kohärenz.', 'Wird mit Shannon, Floridi und FRZK verglichen.', 'reviewed', NULL),
(22, 22, 'Entwickelt eine systematische Philosophie informationeller Strukturen.', 'Unterstützt die erkenntnistheoretische Einordnung von Information in Kapitel 3.', 'Belegt die Interpretation von Information als grundlegendes Organisationsprinzip.', 'Informationelle Strukturen; Informationsontologie; epistemische Rollen.', 'Keine axiomatische mathematische Genese von Raum und Zeit.', 'Ergänzt Wheeler und spätere Informationstheorie.', 'reviewed', NULL),
(23, 23, 'Begründet die transfinite Mengenlehre und etabliert den allgemeinen Mengenbegriff.', 'Primärquelle für Abschnitt 3.2.1 und die historische Herleitung der Mengenlehre.', 'Belegt die Einführung von Mengen als allgemeine mathematische Objektstruktur.', 'Allgemeiner Mengenbegriff; transfinite Mächtigkeiten; Abstraktion mathematischer Objekte.', 'Noch keine vollständig axiomatisierte Mengenlehre.', 'Wird durch Zermelo [24], Jech [25] und Halmos [26] formalisiert beziehungsweise systematisiert.', 'reviewed', '2026-07-12 08:10:56'),
(24, 24, 'Formuliert eines der ersten axiomatischen Systeme der Mengenlehre.', 'Belegt die axiomatische Fundierung der Mengenlehre in 3.2.1.', 'Dient zur Einordnung von Extensionalität, Aussonderung und kontrollierter Mengenbildung.', 'Axiomatisierung der Mengenlehre; Begrenzung uneingeschränkter Mengenbildung.', 'Spätere Ergänzungen durch Fraenkel, Skolem und das Auswahlaxiom erforderlich.', 'Historische Grundlage der heutigen ZFC-Formulierung.', 'reviewed', '2026-07-12 08:10:56'),
(25, 25, 'Internationales Referenzwerk zur modernen axiomatischen Mengenlehre.', 'Standardreferenz für Definitionen und Axiome in 3.2.1.', 'Absicherung der modernen ZFC-Darstellung.', 'ZFC, Ordinalzahlen, Kardinalzahlen und Modelle der Mengenlehre.', 'Sekundärquelle; historische Erstleistungen liegen bei Cantor und Zermelo.', 'Systematisiert die durch [23] und [24] begründete Theorie.', 'reviewed', '2026-07-12 08:10:56'),
(26, 26, 'Kompakte Standarddarstellung elementarer mengentheoretischer Strukturen.', 'Ergänzende Referenz für Mengen, Teilmengen, Abbildungen und kartesische Produkte.', 'Unterstützt die verständliche Formalisierung elementarer Begriffe.', 'Elementrelation, Teilmenge, kartesisches Produkt und Abbildungen.', 'Bewusst keine vollständige axiomatische Grundlagenmonographie.', 'Ergänzt Jech [25] auf elementarer Darstellungsebene.', 'reviewed', '2026-07-12 08:10:56'),
(27, 27, 'Systematische Darstellung von Mengen, Relationen und Funktionen.', 'Grundlage für die formale Einführung binärer Relationen in 3.2.2.', 'Belegt die Definition von Relationen als Teilmengen kartesischer Produkte.', 'Relationen, Äquivalenzklassen und Ordnungsstrukturen.', 'Sekundärquelle ohne originären Anspruch.', 'Verbindet Mengenlehre mit Relationentheorie.', 'reviewed', '2026-07-12 08:10:56'),
(28, 28, 'Standardwerk zu Ordnungsrelationen, Verbänden und strukturellen Hierarchien.', 'Referenz für Halbordnungen und geordnete Strukturen in 3.2.2.', 'Belegt die mathematische Bedeutung von Reflexivität, Antisymmetrie und Transitivität.', 'Halbordnungen, Verbände und Ordnungstheorie.', 'Spezialisiert auf Ordnungsstrukturen.', 'Erweitert die allgemeine Relationentheorie aus [27].', 'reviewed', '2026-07-12 08:10:56'),
(29, 29, 'Systematisiert den Funktionsbegriff und die Grundlagen der Analysis.', 'Referenz für gerichtete Abbildungen und Funktionsklassen in 3.2.3.', 'Belegt die Verwendung von Funktionen als zentrale Transformationsstruktur.', 'Definitions- und Zielmenge, Bild, Injektivität, Surjektivität und Komposition.', 'Lehrbuchartige Sekundärdarstellung.', 'Ergänzt Rudin [30].', 'reviewed', '2026-07-12 08:10:56'),
(30, 30, 'Internationales Standardwerk der reellen und komplexen Analysis.', 'Mathematische Absicherung des Funktions- und Abbildungsbegriffs.', 'Belegt zentrale Definitionen und Eigenschaften von Funktionen.', 'Abbildungen, Folgen, Grenzwerte und Stetigkeit.', 'Konzentriert sich auf Analysis, nicht auf funktionale Genese.', 'Wird später durch Funktionalanalysis erweitert.', 'reviewed', '2026-07-12 08:10:56'),
(31, 31, 'Umfassendes Standardwerk zu Gruppen, Ringen, Körpern und Modulen.', 'Hauptreferenz für algebraische Strukturen in 3.2.4.', 'Belegt die axiomatische Definition algebraischer Verknüpfungen.', 'Gruppen, Ringe, Körper, Homomorphismen und Vektorräume.', 'Sekundärwerk; historische Originalarbeiten werden nicht vollständig diskutiert.', 'Ergänzt Lang [32] und Artin [34].', 'reviewed', '2026-07-12 08:10:56'),
(32, 32, 'Internationales Referenzwerk der abstrakten Algebra.', 'Ergänzende Quelle für Gruppen, Körper und lineare Strukturen.', 'Absicherung algebraischer Definitionen und Strukturprinzipien.', 'Algebraische Strukturen und Verknüpfungsgesetze.', 'Hoher Abstraktionsgrad.', 'Vertieft die Darstellung aus [31].', 'reviewed', '2026-07-12 08:10:56'),
(33, 33, 'Stellt kontinuierliche Gruppen und ihre Darstellungen dar.', 'Belegt die Bedeutung algebraischer Symmetrien für mathematische Physik.', 'Dient zur Einordnung von Gruppen als Transformationsstrukturen.', 'Lie-Gruppen, Lie-Algebren und Darstellungen.', 'Spezialisierte Erweiterung der allgemeinen Algebra.', 'Verbindet Algebra und Operatorentheorie.', 'reviewed', '2026-07-12 08:10:56'),
(34, 34, 'Verbindet abstrakte Algebra mit linearer Algebra und Geometrie.', 'Referenz für Körper und Vektorräume.', 'Belegt die strukturelle Rolle algebraischer Operationen.', 'Gruppen, Ringe, Körper und lineare Abbildungen.', 'Sekundärdarstellung.', 'Ergänzt [31] und [32].', 'reviewed', '2026-07-12 08:10:56'),
(35, 35, 'Standardwerk zu Operatoren auf Banach- und Hilberträumen.', 'Hauptreferenz für die Operatorentheorie in 3.2.5.', 'Belegt Operatorbegriff, Komposition und lineare Operatoren.', 'Lineare Operatoren, Spektraltheorie und Funktionenräume.', 'Setzt mathematische Räume bereits voraus.', 'Wird durch [36], [41] und [42] ergänzt.', 'reviewed', '2026-07-12 08:10:56'),
(36, 36, 'Anwendungsorientierte Darstellung von Normen, Räumen und Operatoren.', 'Ergänzende Referenz für Linearität und Operatoranwendungen.', 'Dient zur verständlichen Absicherung funktionalanalytischer Grundbegriffe.', 'Normierte Räume, Banachräume, Hilberträume und Operatoren.', 'Lehrbuchcharakter.', 'Ergänzt Conway [35].', 'reviewed', '2026-07-12 08:10:56'),
(37, 37, 'Standardwerk zu nichtlinearer Dynamik, Bifurkationen und Chaos.', 'Belegt die Rolle nichtlinearer Operatoren und rekursiver Systeme.', 'Dient zur Einordnung von Nichtlinearität und Iteration.', 'Fixpunkte, Bifurkationen, Attraktoren und Chaos.', 'Arbeitet in vorgegebenen Zustandsräumen.', 'Wird in 3.2.8 erneut verwendet.', 'reviewed', '2026-07-12 08:10:56'),
(38, 38, 'Systematisiert Zustandsraummodelle und Kontrollsysteme.', 'Hauptreferenz für Zustandsvektoren und Zustandsentwicklung.', 'Belegt die mathematische Formulierung deterministischer Zustandsräume.', 'Zustandsraum, Systemdynamik und Kontrollierbarkeit.', 'Beschränkt auf vorgegebene endlichdimensionale Systeme.', 'Wird durch nichtlineare und unendlichdimensionale Ansätze ergänzt.', 'reviewed', '2026-07-12 08:10:56'),
(39, 39, 'Standardwerk zur Stabilität nichtlinearer Systeme.', 'Referenz für nichtlineare Zustandsraummodelle.', 'Belegt die Erweiterung linearer Zustandsmodelle.', 'Nichtlineare Systeme, Stabilität und Lyapunov-Methoden.', 'Setzt Zustandsraum und Dynamik voraus.', 'Ergänzt Sontag [38].', 'reviewed', '2026-07-12 08:10:56'),
(40, 40, 'Verbindet Differentialgleichungen, Phasenräume und Chaos.', 'Referenz für geometrische Zustandsraumdarstellungen.', 'Belegt Trajektorien, Fixpunkte und Attraktoren im Phasenraum.', 'Dynamische Systeme und qualitative Analyse.', 'Beschreibt Dynamik in vorgegebenen Räumen.', 'Bereitet 3.2.8 vor.', 'reviewed', '2026-07-12 08:10:56'),
(41, 41, 'Referenzwerk zur Funktionalanalysis und mathematischen Physik.', 'Hauptquelle für Hilberträume und Operatoren in 3.2.7.', 'Belegt unendlichdimensionale Zustandsräume der mathematischen Physik.', 'Hilberträume, Operatoren und Spektraltheorie.', 'Setzt Funktionenräume und deren Struktur voraus.', 'Ergänzt Conway [35] und Yosida [42].', 'reviewed', '2026-07-12 08:10:56'),
(42, 42, 'Klassisches Referenzwerk zur Funktionalanalysis und Operatorhalbgruppen.', 'Ergänzende Quelle für Banach- und Hilberträume.', 'Belegt Vollständigkeit, Operatoren und Funktionenräume.', 'Funktionalanalysis und lineare Operatoren.', 'Hoher Abstraktionsgrad.', 'Ergänzt [35], [36] und [41].', 'reviewed', '2026-07-12 08:10:56'),
(43, 43, 'Umfassendes Referenzwerk der modernen Dynamik.', 'Hauptquelle für Flüsse, Iterationen und langfristiges Verhalten.', 'Belegt den mathematischen Rahmen dynamischer Systeme.', 'Diskrete und kontinuierliche Dynamik, Ergodentheorie und Hyperbolizität.', 'Setzt Raum und Dynamik voraus.', 'Ergänzt Strogatz [37] und Ott [44].', 'reviewed', '2026-07-12 08:10:57'),
(44, 44, 'Referenzwerk zu Chaos, Attraktoren und Lyapunov-Exponenten.', 'Belegt empfindliche Anfangswertabhängigkeit in 3.2.8.', 'Dient zur Definition chaotischer Divergenz.', 'Chaotische Attraktoren und Lyapunov-Exponenten.', 'Beschreibt keine Genese des Zustandsraums.', 'Ergänzt [37] und [43].', 'reviewed', '2026-07-12 08:10:57'),
(45, 45, 'Internationales Standardwerk der Informationstheorie.', 'Referenz für Entropie, gegenseitige Information und Divergenzen.', 'Belegt die mathematische Quantifizierung von Unsicherheit.', 'Entropie, gemeinsame Entropie, gegenseitige Information und Codierung.', 'Semantische und funktionale Bedeutung bleiben außerhalb des Formalismus.', 'Systematisiert Shannons Primärarbeit [46].', 'reviewed', '2026-07-12 08:10:57'),
(46, 46, 'Begründet die mathematische Informationstheorie.', 'Primärquelle für Informationsgehalt und Shannon-Entropie.', 'Belegt die statistische Quantifizierung von Information.', 'Informationsgehalt, Entropie, Kanal und Kapazität.', 'Abstrahiert bewusst von semantischer Bedeutung.', 'Wird durch Cover und Thomas [45] systematisiert.', 'reviewed', '2026-07-12 08:10:57'),
(47, 47, 'Internationales Standardwerk der Graphentheorie.', 'Hauptreferenz für Graphen, Knoten, Kanten und Pfade.', 'Belegt die formale Graphdefinition.', 'Graphen, Pfade, Zusammenhang und strukturelle Eigenschaften.', 'Statische Grundstruktur; dynamische Genese nicht behandelt.', 'Wird durch Newman [48] und Barabási [15] ergänzt.', 'reviewed', '2026-07-12 08:10:57'),
(48, 48, 'Umfassendes Referenzwerk zu komplexen Netzwerken.', 'Referenz für Zentralitäten und Netzwerkanalyse.', 'Belegt Gradzentralität und strukturelle Netzwerkeigenschaften.', 'Zentralität, Gemeinschaften und Netzwerkmodelle.', 'Setzt Knoten und Kanten voraus.', 'Ergänzt Diestel [47] und Barabási [15].', 'reviewed', '2026-07-12 08:10:57'),
(49, 49, 'Standardwerk der metrischen Geometrie.', 'Hauptquelle für Metrikaxiome und Minkowski-Distanzen.', 'Belegt die formale Definition metrischer Räume.', 'Metriken, geodätische Räume und metrische Geometrie.', 'Beschreibt Abstände, nicht deren funktionale Genese.', 'Grundlage für 3.2.11.', 'reviewed', '2026-07-12 08:10:57'),
(50, 50, 'Standardwerk zu Vektorraummodellen und Kosinusähnlichkeit.', 'Referenz für semantische Ähnlichkeitsmaße.', 'Belegt die Verwendung der Kosinusähnlichkeit im Information Retrieval.', 'Vektorraummodell, Kosinusähnlichkeit und Retrieval.', 'Anwendungsbezogene Sekundärquelle.', 'Verbindet Metrik mit semantischen Vektorräumen.', 'reviewed', '2026-07-12 08:10:57'),
(51, 51, 'Systematisiert Selbstorganisation in biologischen Systemen.', 'Hauptreferenz für lokale Interaktionen und globale Ordnungsbildung.', 'Belegt Selbstorganisation ohne zentrale Steuerung.', 'Lokale Regeln, Rückkopplung und Musterbildung.', 'Setzt Agenten und Wechselwirkungsregeln voraus.', 'Ergänzt Haken [12] und Holland [14].', 'reviewed', '2026-07-12 08:10:57'),
(52, 52, 'Überblick über Komplexität, Emergenz und adaptive Systeme.', 'Ergänzende Quelle für den Emergenzbegriff.', 'Belegt das Auftreten globaler Eigenschaften aus lokalen Regeln.', 'Komplexität, Emergenz und Berechnung.', 'Übersichtswerk, keine mathematische Primärquelle.', 'Ergänzt [12], [14] und [51].', 'reviewed', '2026-07-12 08:10:57');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `assumptions`
--

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

--
-- Daten für Tabelle `assumptions`
--

INSERT INTO `assumptions` (`assumption_id`, `assumption_number`, `section_id`, `title`, `assumption_text`, `formal_latex`, `word_latex`, `derivation_from_research_gap`, `status`, `created_revision_id`) VALUES
(1, 'A-3.2-1', 21, 'Entstehung funktionaler Zustände', 'Eine weiterführende Theorie muss die Entstehung funktionaler Zustände beschreiben, ohne diese als primitive Objekte vorauszusetzen.', NULL, NULL, 'Abgeleitet aus den Grenzen von Mengenlehre, Zustandsraumtheorie und Funktionalanalysis.', 'accepted', 6),
(2, 'A-3.2-2', 21, 'Entstehung funktionaler Relationen', 'Eine weiterführende Theorie muss erklären, wie Relationen aus funktionalen Wechselwirkungen entstehen.', NULL, NULL, 'Abgeleitet aus der statischen Voraussetzung von Relationen und Graphen.', 'accepted', 6),
(3, 'A-3.2-3', 21, 'Rekursive Operatorbildung', 'Eine weiterführende Theorie muss die rekursive Bildung und Veränderung von Operatoren ermöglichen.', NULL, NULL, 'Abgeleitet aus der klassischen Voraussetzung fest vorgegebener Operatoren.', 'accepted', 6),
(4, 'A-3.2-4', 21, 'Dynamische Zustandsraumentstehung', 'Eine weiterführende Theorie muss die Entwicklung und Erweiterung des Zustandsraumes selbst beschreiben.', NULL, NULL, 'Abgeleitet aus der Voraussetzung fester Zustandsräume in klassischen dynamischen Systemen.', 'accepted', 6),
(5, 'A-3.2-5', 21, 'Kohärenz als emergente Eigenschaft', 'Eine weiterführende Theorie muss Kohärenz als emergente Folge rekursiver funktionaler Prozesse formulieren.', NULL, NULL, 'Abgeleitet aus den Grenzen statischer Metriken, Korrelationen und klassischer Emergenzmodelle.', 'accepted', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `authors`
--

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

--
-- Daten für Tabelle `authors`
--

INSERT INTO `authors` (`author_id`, `family_name`, `given_names`, `normalized_name`, `orcid`, `birth_year`, `death_year`, `notes`) VALUES
(1, 'Aristoteles', NULL, 'Aristoteles', NULL, NULL, NULL, NULL),
(2, 'Newton', 'Isaac', 'Newton, Isaac', NULL, NULL, NULL, NULL),
(3, 'Mach', 'Ernst', 'Mach, Ernst', NULL, NULL, NULL, NULL),
(4, 'Einstein', 'Albert', 'Einstein, Albert', NULL, NULL, NULL, NULL),
(5, 'Minkowski', 'Hermann', 'Minkowski, Hermann', NULL, NULL, NULL, NULL),
(6, 'Euklid', NULL, 'Euklid', NULL, NULL, NULL, NULL),
(7, 'Hilbert', 'David', 'Hilbert, David', NULL, NULL, NULL, NULL),
(8, 'Bourbaki', 'Nicolas', 'Bourbaki, Nicolas', NULL, NULL, NULL, NULL),
(9, 'Lang', 'Serge', 'Lang, Serge', NULL, NULL, NULL, NULL),
(10, 'Rudin', 'Walter', 'Rudin, Walter', NULL, NULL, NULL, NULL),
(11, 'Haken', 'Hermann', 'Haken, Hermann', NULL, NULL, NULL, NULL),
(12, 'Prigogine', 'Ilya', 'Prigogine, Ilya', NULL, NULL, NULL, NULL),
(13, 'Stengers', 'Isabelle', 'Stengers, Isabelle', NULL, NULL, NULL, NULL),
(14, 'Holland', 'John H.', 'Holland, John H.', NULL, NULL, NULL, NULL),
(15, 'Barabási', 'Albert-László', 'Barabási, Albert-László', NULL, NULL, NULL, NULL),
(16, 'Arnold', 'Vladimir I.', 'Arnold, Vladimir I.', NULL, NULL, NULL, NULL),
(17, 'Gödel', 'Kurt', 'Gödel, Kurt', NULL, NULL, NULL, NULL),
(18, 'Whitehead', 'Alfred North', 'Whitehead, Alfred North', NULL, NULL, NULL, NULL),
(19, 'Russell', 'Bertrand', 'Russell, Bertrand', NULL, NULL, NULL, NULL),
(20, 'Rovelli', 'Carlo', 'Rovelli, Carlo', NULL, NULL, NULL, NULL),
(21, 'Green', 'Michael B.', 'Green, Michael B.', NULL, NULL, NULL, NULL),
(22, 'Schwarz', 'John H.', 'Schwarz, John H.', NULL, NULL, NULL, NULL),
(23, 'Witten', 'Edward', 'Witten, Edward', NULL, NULL, NULL, NULL),
(24, 'Wheeler', 'John Archibald', 'Wheeler, John Archibald', NULL, NULL, NULL, NULL),
(25, 'Floridi', 'Luciano', 'Floridi, Luciano', NULL, NULL, NULL, NULL),
(34, 'Thiemann', 'Thomas', 'Thiemann, Thomas', NULL, NULL, NULL, NULL),
(35, 'Bombelli', 'Luca', 'Bombelli, Luca', NULL, NULL, NULL, NULL),
(36, 'Lee', 'Joohan', 'Lee, Joohan', NULL, NULL, NULL, NULL),
(37, 'Meyer', 'David', 'Meyer, David', NULL, NULL, NULL, NULL),
(38, 'Sorkin', 'Rafael D.', 'Sorkin, Rafael D.', NULL, NULL, NULL, NULL),
(39, 'Van Raamsdonk', 'Mark', 'Van Raamsdonk, Mark', NULL, NULL, NULL, NULL),
(40, 'Swingle', 'Brian', 'Swingle, Brian', NULL, NULL, NULL, NULL),
(41, 'Verlinde', 'Erik', 'Verlinde, Erik', NULL, NULL, NULL, NULL),
(42, 'Fraenkel', 'Abraham A.', 'Fraenkel, Abraham A.', NULL, NULL, NULL, 'Mitautor von Foundations of Set Theory.'),
(43, 'Bar-Hillel', 'Yehoshua', 'Bar-Hillel, Yehoshua', NULL, NULL, NULL, 'Mitautor von Foundations of Set Theory.'),
(44, 'Levy', 'Azriel', 'Levy, Azriel', NULL, NULL, NULL, 'Mitautor von Foundations of Set Theory.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `axioms`
--

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

--
-- Daten für Tabelle `axioms`
--

INSERT INTO `axioms` (`axiom_id`, `axiom_number`, `section_id`, `title`, `axiom_text`, `formal_latex`, `word_latex`, `motivation`, `independence_note`, `consistency_note`, `operationalization_note`, `source_assumption_id`, `status`, `created_revision_id`) VALUES
(1, 'A1', 52, 'Prinzip der funktionalen Unterscheidbarkeit', 'Es existiert die Möglichkeit funktionaler Unterscheidbarkeit.', '\\exists\\,a,b:\\;a\\not\\equiv_F b', '\\exists\\,a,b:\\;a\\not\\equiv_F b', 'Funktionale Unterscheidbarkeit ist die minimal notwendige Voraussetzung jeder späteren Relationierung, Transformation, Organisation und Informationsbildung.', 'A1 setzt weder eine Menge noch eine mathematische Relation, einen Zustand, einen Raum oder eine Zeitordnung voraus.', 'Das Axiom fordert ausschließlich die prinzipielle Möglichkeit funktionaler Nichtidentität und führt keine weitergehende mathematische Struktur ein.', 'Die mathematische Konstruktion von Differenzklassen und funktionaler Äquivalenz erfolgt erst in Kapitel 3.4.', 1, 'review', 35),
(2, 'A2', 53, 'Prinzip der funktionalen Relationierbarkeit', 'Funktional unterscheidbare Konfigurationen besitzen grundsätzlich die Möglichkeit, funktional miteinander in Beziehung zu treten.', '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)', '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)', 'Unterscheidbarkeit allein erzeugt noch keine Organisation. Erst die prinzipielle Möglichkeit funktionaler Relationierung eröffnet die Bildung strukturierter Zusammenhänge.', 'A2 setzt A1 voraus, führt jedoch weder eine fertige mathematische Relation noch eine Menge geordneter Paare ein. Es behauptet ausschließlich die Möglichkeit funktionaler Bezugnahme.', 'A2 widerspricht A1 nicht, sondern erweitert dessen funktionale Nichtidentität um die Möglichkeit einer nicht notwendig realisierten Beziehung.', 'Die mathematische Konstruktion funktionaler Relationen und Relationsklassen erfolgt erst in Kapitel 3.4.', 2, 'review', 36),
(3, 'A3', 54, 'Prinzip der rekursiven Transformation', 'Jede funktionale Relation besitzt grundsätzlich die Möglichkeit, neue funktionale Konfigurationen hervorzubringen, die wiederum funktional relationierbar sind.', '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)', '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)', 'Funktionale Unterscheidbarkeit und Relationierbarkeit erzeugen noch keine Entwicklung. A3 eröffnet die Möglichkeit, dass funktionale Wechselwirkung neue Konfigurationen hervorbringt, die erneut funktional wirksam werden können.', 'A3 setzt A1 und A2 voraus, führt jedoch weder eine fertige Folge, einen Zeitparameter noch einen mathematischen Transformationsoperator ein.', 'A3 erweitert A1 und A2 widerspruchsfrei um die Möglichkeit rekursiver Hervorbringung. Determiniertheit und Stabilität werden nicht behauptet.', 'Die mathematische Rekonstruktion von Transformation, Iteration, Operator und Zustandsfolge erfolgt erst in Kapitel 3.4.', 3, 'review', 37),
(4, 'A4', 55, 'Prinzip stabiler funktionaler Organisation', 'Rekursive funktionale Transformationen besitzen grundsätzlich das Potenzial, stabile funktionale Organisationsstrukturen hervorzubringen.', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', 'Rekursive Transformation allein erzeugt noch keine Organisation. A4 eröffnet die Möglichkeit, dass sich aus fortgesetzter funktionaler Transformation stabile oder metastabile Organisationsformen herausbilden.', 'A4 setzt A1 bis A3 voraus, führt jedoch weder Zustandsraum, Attraktor, Metrik noch zeitliche Dauer als primitive Struktur ein.', 'Stabilität bedeutet nicht Unveränderlichkeit, sondern die mögliche Erhaltung einer funktionalen Organisationsform trotz weiterer Transformation.', 'Funktionale Organisationsräume, Stabilitätsbegriffe und Attraktorstrukturen werden erst in Kapitel 3.4 mathematisch konstruiert.', 4, 'review', 38),
(5, 'A5', 56, 'Prinzip reproduzierbarer Organisationsmuster', 'Stabile funktionale Organisationsstrukturen besitzen grundsätzlich die Möglichkeit reproduzierbarer Organisationsmuster.', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', 'Stabilität allein genügt nicht für wissenschaftliche Vergleichbarkeit. A5 eröffnet die Möglichkeit, dass funktional äquivalente Organisationsmuster unter vergleichbaren Bedingungen erneut hervorgebracht werden.', 'A5 setzt A1 bis A4 voraus, führt jedoch weder mathematische Äquivalenzklassen, Wahrscheinlichkeiten noch empirische Wiederholungsraten als primitive Strukturen ein.', 'Reproduzierbarkeit bedeutet funktionale Vergleichbarkeit und nicht vollständige Identität aller lokalen Eigenschaften.', 'Äquivalenzklassen, Kohärenzmaße und Kriterien empirischer Reproduzierbarkeit werden erst in Kapitel 3.4 und den Anwendungskapiteln mathematisch operationalisiert.', 5, 'review', 40);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `axiom_dependencies`
--

CREATE TABLE `axiom_dependencies` (
  `axiom_dependency_id` bigint(20) UNSIGNED NOT NULL,
  `axiom_id` bigint(20) UNSIGNED NOT NULL,
  `depends_on_axiom_id` bigint(20) UNSIGNED NOT NULL,
  `dependency_type` enum('depends_on','extends','specializes','contrasts','independent_of') NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `axiom_dependencies`
--

INSERT INTO `axiom_dependencies` (`axiom_dependency_id`, `axiom_id`, `depends_on_axiom_id`, `dependency_type`, `note`) VALUES
(1, 2, 1, 'depends_on', 'A2 setzt die durch A1 eröffnete funktionale Unterscheidbarkeit voraus.'),
(2, 3, 1, 'depends_on', 'A3 setzt funktionale Unterscheidbarkeit nach A1 voraus.'),
(3, 3, 2, 'depends_on', 'A3 setzt funktionale Relationierbarkeit nach A2 voraus.'),
(7, 4, 1, 'depends_on', 'A4 setzt funktionale Unterscheidbarkeit nach A1 voraus.'),
(8, 4, 2, 'depends_on', 'A4 setzt funktionale Relationierbarkeit nach A2 voraus.'),
(9, 4, 3, 'depends_on', 'A4 setzt rekursive funktionale Transformation nach A3 voraus.'),
(10, 5, 1, 'depends_on', 'A5 setzt funktionale Unterscheidbarkeit nach A1 voraus.'),
(11, 5, 2, 'depends_on', 'A5 setzt funktionale Relationierbarkeit nach A2 voraus.'),
(12, 5, 3, 'depends_on', 'A5 setzt rekursive funktionale Transformation nach A3 voraus.'),
(13, 5, 4, 'depends_on', 'A5 setzt stabile funktionale Organisation nach A4 voraus.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `citation_corrections`
--

CREATE TABLE `citation_corrections` (
  `correction_id` bigint(20) UNSIGNED NOT NULL,
  `old_citation_label` varchar(50) NOT NULL,
  `corrected_citation_label` varchar(50) NOT NULL,
  `section_code` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `revision_id` bigint(20) UNSIGNED DEFAULT NULL,
  `corrected_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `citation_corrections`
--

INSERT INTO `citation_corrections` (`correction_id`, `old_citation_label`, `corrected_citation_label`, `section_code`, `reason`, `revision_id`, `corrected_at`) VALUES
(1, '[49]', '[15]', '3.2.10', 'Barabási wurde bereits in 3.1 unter [15] erfasst und darf nicht erneut als [49] geführt werden.', 6, '2026-07-12 06:10:57'),
(2, '[50]', '[49]', '3.2.11', 'Burago et al. verschieben sich nach der Dublettenbereinigung auf [49].', 6, '2026-07-12 06:10:57'),
(3, '[51]', '[50]', '3.2.11', 'Manning et al. verschieben sich nach der Dublettenbereinigung auf [50].', 6, '2026-07-12 06:10:57'),
(4, '[52]', '[51]', '3.2.12', 'Camazine et al. verschieben sich nach der Dublettenbereinigung auf [51].', 6, '2026-07-12 06:10:57'),
(5, '[53]', '[52]', '3.2.12', 'Mitchell verschiebt sich nach der Dublettenbereinigung auf [52].', 6, '2026-07-12 06:10:57'),
(6, '[54]', '[12]', '3.2.12', 'Haken wurde bereits in 3.1 unter [12] erfasst.', 6, '2026-07-12 06:10:57'),
(7, '[55]', '[14]', '3.2.12', 'Holland wurde bereits in 3.1 unter [14] erfasst.', 6, '2026-07-12 06:10:57');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `corollaries`
--

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

--
-- Daten für Tabelle `corollaries`
--

INSERT INTO `corollaries` (`corollary_id`, `corollary_number`, `section_id`, `title`, `statement_text`, `statement_latex`, `word_latex`, `parent_theorem_id`, `parent_lemma_id`, `provenance`, `source_id`, `validation_status`, `created_revision_id`) VALUES
(8, 'Korollar 3.4.1', 62, 'Übergang zur Relationsstruktur', 'Jede funktionale Differenzstruktur besitzt eine zugehörige funktionale Relationsstruktur.', '(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)', '(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)', 10, NULL, 'original', NULL, 'checked', 11),
(9, 'Korollar 3.4.2', 63, 'Übergang zum Transformationsraum', 'Jede funktionale Relationsstruktur besitzt eine zugehörige Transformationsstruktur.', '(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)', '(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)', 11, NULL, 'original', NULL, 'checked', 11),
(10, 'Korollar 3.4.3', 64, 'Rekursive Abgeschlossenheit', 'Jeder funktionale Organisationsraum ist unter rekursiven Transformationen abgeschlossen.', '\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', '\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', 12, NULL, 'original', NULL, 'checked', 11),
(11, 'Korollar 3.4.4', 65, 'Interne Transformationsstruktur', 'Jede rekursive Transformation induziert eine Abbildung auf dem funktionalen Zustandsraum.', '\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F', '\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F', 13, NULL, 'original', NULL, 'checked', 11),
(12, 'Korollar 3.4.5', 66, 'Einbettung der Kohärenzstruktur', 'Jede funktionale Kohärenzstruktur ist Bestandteil eines funktionalen Zustandsraums.', '\\mathcal{K}_F\\subseteq\\mathcal{X}_F', '\\mathcal{K}_F\\subseteq\\mathcal{X}_F', 14, NULL, 'original', NULL, 'checked', 11),
(13, 'Korollar 3.4.6', 67, 'Koordinatenfreie Raumstruktur', 'Der rekonstruierte Raumbegriff ist durch Zustände und Erreichbarkeit bestimmt.', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', 15, NULL, 'original', NULL, 'checked', 11),
(14, 'Korollar 3.4.7', 68, 'Transformationsbestimmte Zeitstruktur', 'Die funktionale Zeitstruktur ist vollständig durch die Transformationsordnung bestimmt.', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', 16, NULL, 'original', NULL, 'checked', 11);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `definitions`
--

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

--
-- Daten für Tabelle `definitions`
--

INSERT INTO `definitions` (`definition_id`, `definition_number`, `section_id`, `title`, `definition_text`, `formal_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `notes`, `validation_status`, `created_revision_id`) VALUES
(1, 'Def. 3.1.1', 4, 'Funktionale Theorie von Raum und Zeit', 'Eine funktionale Theorie von Raum und Zeit führt Raum und Zeit nicht als primitive Begriffe ein, sondern verlangt ihre Herleitung aus allgemeineren funktionalen Prinzipien.', NULL, NULL, 'original', NULL, NULL, NULL, 'checked', 3),
(2, 'Def. 3.2.1', 9, 'Menge', 'Eine Menge ist eine wohldefinierte Zusammenfassung unterscheidbarer mathematischer Objekte.', 'M=\\{x\\mid P(x)\\}', 'M=\\{x\\mid P(x)\\}', 'literature', 23, NULL, NULL, 'checked', 6),
(3, 'Def. 3.2.2', 9, 'Teilmenge', 'A ist Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.', 'A\\subseteq B', 'A\\subseteq B', 'literature', 25, NULL, NULL, 'checked', 6),
(4, 'Def. 3.2.3', 10, 'Relation', 'Eine Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts A×B.', 'R\\subseteq A\\times B', 'R\\subseteq A\\times B', 'literature', 27, NULL, NULL, 'checked', 6),
(5, 'Def. 3.2.4', 10, 'Äquivalenzrelation', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', NULL, NULL, 'literature', 27, NULL, NULL, 'checked', 6),
(6, 'Def. 3.2.5', 11, 'Funktion', 'Eine Funktion ordnet jedem Element der Definitionsmenge genau ein Element der Zielmenge zu.', 'f:A\\rightarrow B', 'f:A\\rightarrow B', 'literature', 29, NULL, NULL, 'checked', 6),
(7, 'Def. 3.2.6', 11, 'Bijektion', 'Eine Funktion ist bijektiv, wenn sie injektiv und surjektiv ist.', NULL, NULL, 'literature', 30, NULL, NULL, 'checked', 6),
(8, 'Def. 3.2.7', 12, 'Innere Verknüpfung', 'Eine innere Verknüpfung bildet zwei Elemente einer Menge wieder in diese Menge ab.', '\\ast:A\\times A\\rightarrow A', '\\ast:A\\times A\\rightarrow A', 'literature', 31, NULL, NULL, 'checked', 6),
(9, 'Def. 3.2.8', 12, 'Monoid', 'Ein Monoid ist eine Menge mit assoziativer innerer Verknüpfung und neutralem Element.', NULL, NULL, 'literature', 31, NULL, NULL, 'checked', 6),
(10, 'Def. 3.2.9', 12, 'Gruppe', 'Eine Gruppe ist ein Monoid, in dem jedes Element ein inverses Element besitzt.', NULL, NULL, 'literature', 31, NULL, NULL, 'checked', 6),
(11, 'Def. 3.2.10', 12, 'Vektorraum', 'Ein Vektorraum ist eine Menge von Vektoren mit Vektoraddition und Skalarmultiplikation über einem Körper.', NULL, NULL, 'literature', 34, NULL, NULL, 'checked', 6),
(12, 'Def. 3.2.11', 13, 'Operator', 'Ein Operator ist eine Abbildung zwischen mathematischen Räumen, deren Elemente selbst strukturierte mathematische Objekte sein können.', 'T:X\\rightarrow Y', 'T:X\\rightarrow Y', 'literature', 35, NULL, NULL, 'checked', 6),
(13, 'Def. 3.2.12', 13, 'Linearer Operator', 'Ein Operator ist linear, wenn er Addition und Skalarmultiplikation erhält.', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'literature', 35, NULL, NULL, 'checked', 6),
(14, 'Def. 3.2.13', 14, 'Zustandsraum', 'Ein Zustandsraum ist die Menge aller zulässigen vollständigen Zustände eines Systems.', '\\mathcal{X}=\\{X\\mid X\\text{ zulässig}\\}', '\\mathcal{X}=\\{X\\mid X\\text{ zulässig}\\}', 'literature', 38, NULL, NULL, 'checked', 6),
(15, 'Def. 3.2.14', 15, 'Norm', 'Eine Norm ordnet jedem Element eines Vektorraums eine nichtnegative Größe zu und erfüllt Definitheit, Homogenität und Dreiecksungleichung.', NULL, NULL, 'literature', 42, NULL, NULL, 'checked', 6),
(16, 'Def. 3.2.15', 15, 'Banachraum', 'Ein Banachraum ist ein vollständiger normierter Vektorraum.', NULL, NULL, 'literature', 42, NULL, NULL, 'checked', 6),
(17, 'Def. 3.2.16', 15, 'Hilbertraum', 'Ein Hilbertraum ist ein vollständiger Skalarproduktraum.', NULL, NULL, 'literature', 41, NULL, NULL, 'checked', 6),
(18, 'Def. 3.2.17', 16, 'Dynamisches System', 'Ein dynamisches System beschreibt die Entwicklung eines Zustands unter einer kontinuierlichen oder diskreten Dynamik.', NULL, NULL, 'literature', 43, NULL, NULL, 'checked', 6),
(19, 'Def. 3.2.18', 16, 'Fixpunkt', 'Ein Fixpunkt ist ein Zustand, der durch die Dynamik unverändert bleibt.', 'F(X^\\ast)=X^\\ast', 'F(X^\\ast)=X^\\ast', 'literature', 43, NULL, NULL, 'checked', 6),
(20, 'Def. 3.2.19', 16, 'Attraktor', 'Ein Attraktor ist eine invariante Zustandsmenge, der sich benachbarte Trajektorien langfristig annähern.', NULL, NULL, 'literature', 44, NULL, NULL, 'checked', 6),
(21, 'Def. 3.2.20', 17, 'Shannon-Entropie', 'Die Shannon-Entropie ist der Erwartungswert des Informationsgehalts einer diskreten Zufallsvariablen.', 'H(X)=-\\sum_i p_i\\log_2 p_i', 'H(X)=-\\sum_i p_i\\log_2 p_i', 'literature', 46, NULL, NULL, 'checked', 6),
(22, 'Def. 3.2.21', 17, 'Gegenseitige Information', 'Die gegenseitige Information misst die Verringerung der Unsicherheit einer Zufallsvariablen durch Kenntnis einer zweiten.', NULL, NULL, 'literature', 45, NULL, NULL, 'checked', 6),
(23, 'Def. 3.2.22', 18, 'Graph', 'Ein Graph ist ein geordnetes Paar aus einer Knotenmenge und einer Kantenmenge.', 'G=(V,E)', 'G=(V,E)', 'literature', 47, NULL, NULL, 'checked', 6),
(24, 'Def. 3.2.23', 19, 'Metrik', 'Eine Metrik ist eine Abstandsfunktion, die Nichtnegativität, Identität, Symmetrie und Dreiecksungleichung erfüllt.', 'd:X\\times X\\rightarrow\\mathbb{R}', 'd:X\\times X\\rightarrow\\mathbb{R}', 'literature', 49, NULL, NULL, 'checked', 6),
(25, 'Def. 3.2.24', 20, 'Selbstorganisation', 'Selbstorganisation bezeichnet die Entstehung makroskopischer Ordnung aus lokalen Wechselwirkungen ohne zentrale Steuerung.', NULL, NULL, 'literature', 51, NULL, NULL, 'checked', 6),
(26, 'Def. 3.2.25', 20, 'Emergenz', 'Emergenz bezeichnet das Auftreten neuer Systemeigenschaften auf einer höheren Organisationsebene.', NULL, NULL, 'literature', 52, NULL, NULL, 'checked', 6),
(44, 'Def. 3.4.1', 61, 'Funktionaler Zustand', 'Ein funktionaler Zustand ist die mathematische Repräsentation einer stabilen funktionalen Organisation im Sinne von Axiom A4.', 'x:=\\mathcal{O}_F', 'x:=\\mathcal{O}_F', 'original', NULL, 'Axiom A4 gilt. Eine stabile funktionale Organisation kann als mathematisch unterscheidbare Repräsentation behandelt werden.', 'Der funktionale Zustand besitzt zunächst weder Koordinaten noch Metrik, Dimension, räumliche Position oder Zeitparameter.', 'checked', 45),
(45, 'Def. 3.4.2', 61, 'Klasse funktionaler Zustände', 'Die Klasse funktionaler Zustände umfasst alle im betrachteten Modell mathematisch repräsentierten funktionalen Zustände.', 'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', 'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', 'original', NULL, 'Def. 3.4.1 gilt. Mehrere funktionale Zustände können innerhalb desselben Modells unterschieden werden.', 'X ist in diesem Abschnitt noch kein vollständiger Zustandsraum, sondern zunächst nur die Klasse der definierten funktionalen Zustände.', 'checked', 45),
(46, 'Def. 3.4.3', 62, 'Funktionale Relation', 'Eine funktionale Relation ist eine wohldefinierte Zuordnung zwischen zwei funktionalen Zuständen, durch die die funktionale Relevanz eines Zustands für einen anderen dargestellt wird.', '\\mathcal{R}_F\\subseteq X\\times X', '\\mathcal{R}_F\\subseteq X\\times X', 'original', NULL, 'Axiom A2 sowie Def. 3.4.1 und Def. 3.4.2 gelten.', 'Die Relation besitzt zunächst weder Symmetrie noch Transitivität oder metrische Bedeutung.', 'checked', 46),
(47, 'Def. 3.4.4', 62, 'Funktionale Relationsstruktur', 'Die funktionale Relationsstruktur ist das geordnete Paar aus der Klasse funktionaler Zustände und der auf ihr definierten funktionalen Relation.', '\\mathfrak{G}_F=(X,\\mathcal{R}_F)', '\\mathfrak{G}_F=(X,\\mathcal{R}_F)', 'original', NULL, 'Def. 3.4.2 und Def. 3.4.3 gelten.', 'Die Relationsstruktur ist noch kein metrischer, topologischer oder dynamischer Raum.', 'checked', 46),
(48, 'Def. 3.4.5', 63, 'Funktionale Transformation', 'Eine funktionale Transformation ist eine wohldefinierte Abbildung, die jedem funktionalen Zustand genau einen funktionalen Folgezustand innerhalb derselben Zustandsklasse zuordnet.', '\\mathcal{T}_F:X\\rightarrow X', '\\mathcal{T}_F:X\\rightarrow X', 'original', NULL, 'Axiom A3 sowie Def. 3.4.2 bis Def. 3.4.4 gelten.', 'Die Transformation setzt noch keine physikalische Zeit, Linearität, Stetigkeit oder Invertierbarkeit voraus.', 'checked', 47),
(49, 'Def. 3.4.6', 63, 'Rekursive Transformation', 'Eine funktionale Transformation heißt rekursiv, wenn jede endliche wiederholte Anwendung derselben Transformation wieder eine wohldefinierte Abbildung der Zustandsklasse in sich selbst ergibt.', '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}', '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}', 'original', NULL, 'Def. 3.4.5 gilt und die endliche Komposition von T_F ist wohldefiniert.', 'Der Exponent n bezeichnet die n-fache Komposition und keine algebraische Potenz.', 'checked', 47),
(50, 'Def. 3.4.7', 64, 'Organisationserzeugende Transformation', 'Eine rekursive funktionale Transformation heißt organisationserzeugend, wenn eine nichtleere Teilmenge der Zustandsklasse unter ihr invariant bleibt.', '\\exists\\,\\mathcal{O}_F\\subseteq X,\\;\\mathcal{O}_F\\neq\\varnothing:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F', '\\exists\\,\\mathcal{O}_F\\subseteq X,\\;\\mathcal{O}_F\\neq\\varnothing:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F', 'original', NULL, 'Axiom A4 sowie Def. 3.4.5 und Def. 3.4.6 gelten.', 'Invarianz bezeichnet die Erhaltung der Organisationsmenge als Ganzes; einzelne Zustände dürfen innerhalb der Menge wechseln.', 'checked', 48),
(51, 'Def. 3.4.8', 64, 'Funktionaler Organisationsraum', 'Ein funktionaler Organisationsraum ist das geordnete Paar aus einer nichtleeren invarianten Organisationsmenge und der auf ihr wirkenden organisationserzeugenden Transformation.', '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)', '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)', 'original', NULL, 'Def. 3.4.7 gilt.', 'Der Organisationsraum ist noch kein metrischer oder topologischer Raum. Er beschreibt die invariante funktionale Organisation unter rekursiver Transformation.', 'checked', 48),
(52, 'Def. 3.4.9', 65, 'Funktionale Kohärenz', 'Die funktionale Kohärenz eines funktionalen Organisationsraums ist ein normiertes Maß seiner strukturellen Erhaltung unter rekursiven funktionalen Transformationen.', '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]', '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]', 'original', NULL, 'Def. 3.4.8 gilt.', 'Der Wert 1 bezeichnet maximale funktionale Kohärenz; der Wert 0 bezeichnet vollständigen Verlust funktionaler Organisation. Die konkrete Operationalisierung wird später festgelegt.', 'checked', 49),
(53, 'Def. 3.4.10', 65, 'Kohärenzerhaltende Transformation', 'Eine funktionale Transformation heißt kohärenzerhaltend, wenn sie den Kohärenzwert eines funktionalen Organisationsraums unverändert lässt.', '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', 'original', NULL, 'Def. 3.4.8 und Def. 3.4.9 gelten.', 'Einzelne Zustände oder Relationen dürfen sich verändern; erhalten bleibt der globale Kohärenzwert.', 'checked', 49),
(54, 'Def. 3.4.11', 66, 'Funktionale Raum-Zeit-Kohärenz', 'Zwei funktionale Organisationsräume besitzen funktionale Raum-Zeit-Kohärenz, wenn ihre funktionalen Organisationsstrukturen durch eine wohldefinierte funktionale Kohärenzrelation gekoppelt sind.', '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F', '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F', 'original', NULL, 'Def. 3.4.8 und Axiom A5 gelten.', 'Die Relation enthält noch keine geometrische Distanz und keinen vorausgesetzten Zeitparameter.', 'checked', 50),
(55, 'Def. 3.4.12', 66, 'Raum-Zeit-Kohärenzfunktion', 'Die Raum-Zeit-Kohärenzfunktion ordnet jedem geordneten Paar funktionaler Organisationsräume einen normierten Wert ihrer funktionalen Kopplung zu.', '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]', '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]', 'original', NULL, 'Def. 3.4.11 gilt.', 'Der Wert 1 bezeichnet maximale funktionale Kopplung, der Wert 0 vollständige funktionale Entkopplung.', 'checked', 50),
(56, 'Def. 3.4.13', 67, 'Funktionale Dynamik', 'Funktionale Dynamik ist die Veränderung der funktionalen Kohärenz eines Organisationsraums entlang zulässiger rekursiver Transformationen.', '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}', '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}', 'original', NULL, 'Def. 3.4.9, Def. 3.4.10 und Satz 3.4.6 gelten.', 'Positive Werte bezeichnen Kohärenzzunahme, negative Werte Kohärenzverlust und der Wert 0 einen stationären Kohärenzzustand.', 'checked', 51),
(57, 'Def. 3.4.14', 67, 'Funktionale Entwicklungsbahn', 'Eine funktionale Entwicklungsbahn ist eine geordnete endliche Folge funktionaler Organisationsräume, in der jeder Folgezustand aus seinem Vorgänger durch eine zulässige funktionale Transformation hervorgeht.', '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)', '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)', 'original', NULL, 'Def. 3.4.6 und Def. 3.4.8 gelten.', 'Der Index ordnet die Transformationsschritte; er setzt noch keine physikalische Zeitmetrik voraus.', 'checked', 51),
(58, 'Def. 3.4.15', 68, 'Funktionaler Attraktor', 'Ein funktionaler Organisationsraum heißt funktionaler Attraktor, wenn er nach einer endlichen Anzahl zulässiger rekursiver Transformationen wieder erreicht wird.', '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A', '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A', 'original', NULL, 'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten; n ist eine positive endliche Iterationszahl.', 'Die Definition beschreibt einen periodischen funktionalen Attraktor. Der Spezialfall n=1 ist ein funktionaler Fixpunkt.', 'checked', 52),
(59, 'Def. 3.4.16', 68, 'Attraktorenmenge', 'Die Attraktorenmenge ist die Menge aller funktionalen Organisationsräume, die nach einer endlichen rekursiven Transformationsfolge wieder erreicht werden.', '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}', '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}', 'original', NULL, 'Def. 3.4.15 gilt.', 'Die Attraktorenmenge kann leer sein, sofern kein funktionaler Organisationsraum die Wiederkehrbedingung erfüllt.', 'checked', 52),
(60, 'Def. 3.4.17', 68, 'Funktionale Zeitstruktur', 'Die funktionale Zeitstruktur ist das Paar aus funktionaler Raumstruktur und Transformationsordnung.', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', 'original', NULL, NULL, NULL, 'checked', 11);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dissertation_sections`
--

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

--
-- Daten für Tabelle `dissertation_sections`
--

INSERT INTO `dissertation_sections` (`section_id`, `parent_section_id`, `section_code`, `title`, `chapter_no`, `section_order`, `status`, `is_original_contribution`, `notes`, `created_at`, `updated_at`) VALUES
(1, NULL, '3.1', 'Grundlagen der funktionalen Beschreibung von Raum und Zeit', 3, 3.1000, 'review', 0, 'Kapitel 3.1 wurde vollständig neu gefasst. Gemeinsame Endredaktion, Literaturprüfung und Statuswechsel auf final stehen noch aus.', '2026-07-12 11:14:28', '2026-07-12 12:37:46'),
(2, 1, '3.1.1', 'Problemstellung und wissenschaftlicher Ausgangspunkt', 3, 3.1100, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt enthält keine nummerierte Gleichung und verwendet die bestehenden Quellen [1] bis [15].', '2026-07-12 11:14:28', '2026-07-12 12:15:00'),
(3, 1, '3.1.2', 'Wissenschaftstheoretische Entwicklung des Raum- und Zeitbegriffs', 3, 3.1200, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt enthält keine nummerierte Gleichung. Verwendet werden die bestehenden Quellen [1] bis [11] und [16].', '2026-07-12 11:14:28', '2026-07-12 12:18:38'),
(4, 1, '3.1.3', 'Anforderungen an eine funktionale Theorie von Raum und Zeit', 3, 3.1300, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt formuliert die methodischen Anforderungen an die spätere FRZK-Axiomatik. Er enthält keine nummerierte Gleichung. Verwendet werden die bestehenden Quellen [8], [12] bis [15], [17] und [18].', '2026-07-12 11:14:28', '2026-07-12 12:22:37'),
(5, 1, '3.1.4', 'Der Forschungsstand zur Emergenz von Raum und Zeit', 3, 3.1400, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Forschungsstand zu Schleifenquantengravitation, Causal-Set-Theorie, Holographie, Tensornetzwerken, emergenter Gravitation und informationeller Physik. Keine nummerierte Gleichung.', '2026-07-12 11:14:28', '2026-07-12 12:37:33'),
(6, 1, '3.1.5', 'Einordnung des Funktionalen Raum-Zeit-Kohärenzsystems', 3, 3.1500, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Wissenschaftliche Einordnung des FRZK, Abgrenzung von physikalischen Konkurrenztheorien und Übergang zu Kapitel 3.2. Enthält die aktualisierten Gleichungen (3.1) und (3.2).', '2026-07-12 11:14:28', '2026-07-12 12:37:46'),
(7, NULL, '3.2', 'Mathematische Grundlagen', 3, 3.2000, 'review', 0, 'Kapitel 3.2 wird vollständig neu gefasst und bleibt bis zur Endredaktion im Status review.', '2026-07-12 11:14:28', '2026-07-12 13:10:08'),
(8, 7, '3.2.0', 'Einleitung', 3, 3.2001, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Die Einleitung ordnet Kapitel 3.2 als mathematischen Forschungsstand ein und grenzt es von der Eigenleistung ab Kapitel 3.3 ab. Keine nummerierte Gleichung.', '2026-07-12 11:14:28', '2026-07-12 12:53:42'),
(9, 7, '3.2.1', 'Mengen als Grundlage mathematischer Modellbildung', 3, 3.2100, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt behandelt Mengen als etablierten mathematischen Forschungsstand, verwendet die Quellen [23] und [58] und enthält ausschließlich die aktualisierte Gleichung (3.3).', '2026-07-12 11:14:28', '2026-07-12 12:53:53'),
(10, 7, '3.2.2', 'Relationen als mathematische Beschreibung struktureller Zusammenhänge', 3, 3.2200, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt verwendet die bestehenden Quellen [27] und [28] und enthält die Gleichungen (3.4) bis (3.9).', '2026-07-12 11:14:28', '2026-07-12 13:10:08'),
(11, 7, '3.2.3', 'Funktionen als mathematische Grundlage gerichteter Transformationen', 3, 3.2300, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [29] und [30] und enthält die Gleichungen (3.10) bis (3.13).', '2026-07-12 11:14:28', '2026-07-12 13:25:46'),
(12, 7, '3.2.4', 'Algebraische Strukturen als Grundlage mathematischer Verknüpfungen', 3, 3.2400, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [31] bis [34] und enthält die Gleichungen (3.14) bis (3.18).', '2026-07-12 11:14:28', '2026-07-12 13:26:39'),
(13, 7, '3.2.5', 'Operatorentheorie als mathematische Grundlage funktionaler Transformationen', 3, 3.2500, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [35] bis [37] und enthält die Gleichungen (3.19) bis (3.24).', '2026-07-12 11:14:28', '2026-07-12 13:49:53'),
(14, 7, '3.2.6', 'Zustandsräume als mathematische Grundlage funktionaler Entwicklungen', 3, 3.2600, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(15, 7, '3.2.7', 'Funktionalanalysis als mathematischer Rahmen unendlichdimensionaler Zustandsräume', 3, 3.2700, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [35], [36], [41] und [42] und enthält die Gleichungen (3.29) bis (3.34).', '2026-07-12 11:14:28', '2026-07-12 14:20:07'),
(16, 7, '3.2.8', 'Dynamische Systeme als mathematische Grundlage funktionaler Entwicklung', 3, 3.2800, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [37], [39], [40], [43] und [44] und enthält die Gleichungen (3.35) bis (3.40).', '2026-07-12 11:14:28', '2026-07-12 14:29:55'),
(17, 7, '3.2.9', 'Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse', 3, 3.2900, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [45] und [46] und enthält die Gleichungen (3.41) bis (3.45).', '2026-07-12 11:14:28', '2026-07-12 14:37:17'),
(18, 7, '3.2.10', 'Graphen- und Netzwerktheorie als mathematische Beschreibung komplexer Beziehungsstrukturen', 3, 3.3000, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [15], [47] und [48] und enthält die Gleichungen (3.46) bis (3.51).', '2026-07-12 11:14:28', '2026-07-12 14:43:17'),
(19, 7, '3.2.11', 'Metriken und Ähnlichkeitsmaße als Grundlage funktionaler Distanz', 3, 3.3100, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die bestehenden Quellen [49] und [50] und enthält die Gleichungen (3.52) bis (3.57).', '2026-07-12 11:14:28', '2026-07-12 14:51:53'),
(20, 7, '3.2.12', 'Emergenz und Selbstorganisation als mathematische Grundlagen funktionaler Strukturbildung', 3, 3.3200, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Verwendet die Quellen [12], [14], [51] und [52] und enthält die Gleichungen (3.58) bis (3.63).', '2026-07-12 11:14:28', '2026-07-12 15:00:31'),
(21, 7, '3.2.13', 'Grenzen bestehender mathematischer Modelle und Herleitung der Forschungslücke', 3, 3.3300, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(22, NULL, '3.3', 'Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems', 3, 3.4000, 'review', 1, 'Kapitel 3.3 ist inhaltlich vollständig entwickelt. Es umfasst die wissenschaftstheoretische Begründung, die fünf Grundaxiome A1 bis A5, deren Zusammenfassung, Proposition Prop. 3.1 und den Übergang zur mathematischen Rekonstruktion. Die abschließende Endredaktion steht noch aus.', '2026-07-12 11:14:28', '2026-07-12 16:17:33'),
(23, NULL, '3.4', 'Mathematische Rekonstruktion funktionaler Organisation', 3, 3.5000, 'review', 1, 'Kapitel 3.4 wird als mathematische Rekonstruktion funktionaler Organisation abschnittsweise neu entwickelt.', '2026-07-12 11:14:28', '2026-07-12 16:43:58'),
(49, 22, '3.3.0', 'Einleitung', 3, 3.4001, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(50, 22, '3.3.1', 'Motivation einer axiomatischen Rekonstruktion', 3, 3.4100, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt begründet den Übergang vom mathematischen Forschungsstand zur eigenständigen FRZK-Axiomatik. Er enthält keine neue Literaturquelle und keine nummerierte Gleichung.', '2026-07-12 11:14:28', '2026-07-12 15:06:50'),
(51, 22, '3.3.2', 'Wissenschaftstheoretische Begründung der primitiven Begriffe', 3, 3.4200, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt begründet die Auswahl der primitiven Begriffe des FRZK und grenzt sie von bereits mathematisch strukturierten Begriffen ab. Verwendet werden [8], [18] und [24]. Keine nummerierte Gleichung und noch kein Axiom.', '2026-07-12 11:14:28', '2026-07-12 15:11:18'),
(52, 22, '3.3.3', 'Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit', 3, 3.4300, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A1 und die formale Darstellung (3.64). Keine neue Literaturquelle.', '2026-07-12 11:14:28', '2026-07-12 15:16:07'),
(53, 22, '3.3.4', 'Axiom A2 – Prinzip der funktionalen Relationierbarkeit', 3, 3.4400, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A2 und die formale Darstellung (3.65). Keine neue Literaturquelle.', '2026-07-12 11:14:28', '2026-07-12 15:19:50'),
(54, 22, '3.3.5', 'Axiom A3 – Prinzip der rekursiven Transformation', 3, 3.4500, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A3 sowie die Gleichungen (3.66) und (3.67). Keine neue Literaturquelle.', '2026-07-12 11:14:28', '2026-07-12 15:29:01'),
(55, 22, '3.3.6', 'Axiom A4 – Prinzip stabiler funktionaler Organisation', 3, 3.4600, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A4 sowie die Gleichungen (3.68) und (3.69). Keine neue Literaturquelle.', '2026-07-12 11:14:28', '2026-07-12 15:44:28'),
(56, 22, '3.3.7', 'Axiom A5 – Prinzip reproduzierbarer Organisationsmuster', 3, 3.4700, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Axiom A5 sowie die Gleichungen (3.70) und (3.71). Keine neue Literaturquelle. Mit A5 sind die fünf Grundaxiome abgeschlossen.', '2026-07-12 11:14:28', '2026-07-12 15:50:39'),
(57, 22, '3.3.8', 'Zusammenfassung der axiomatischen Grundlagen', 3, 3.4800, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Fasst A1 bis A5 als gemeinsam vorausgesetztes, nicht als linear ableitbares Axiomensystem zusammen. Enthält Gleichung (3.72).', '2026-07-12 11:14:28', '2026-07-12 15:54:48'),
(58, 22, '3.3.9', 'Erste Proposition des Funktionalen Raum-Zeit-Kohärenzsystems', 3, 3.4900, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Proposition Prop. 3.1 sowie Gleichung (3.73). Keine neue Literaturquelle.', '2026-07-12 11:14:28', '2026-07-12 16:06:45'),
(60, 23, '3.4.0', 'Einleitung', 3, 3.5001, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(61, 23, '3.4.1', 'Konstruktion funktionaler Zustände', 3, 3.5100, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt rekonstruiert aus stabiler funktionaler Organisation den funktionalen Zustand und die Klasse funktionaler Zustände. Enthält Def. 3.4.1, Def. 3.4.2 sowie die Gleichungen (3.74) und (3.75).', '2026-07-12 11:14:28', '2026-07-12 16:43:58'),
(62, 23, '3.4.2', 'Konstruktion funktionaler Relationen', 3, 3.5200, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt konstruiert funktionale Relationen zwischen den in 3.4.1 definierten Zuständen und fasst sie zu einer funktionalen Relationsstruktur zusammen.', '2026-07-12 11:14:28', '2026-07-12 16:50:15'),
(63, 23, '3.4.3', 'Konstruktion funktionaler Transformationen', 3, 3.5300, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt konstruiert funktionale und rekursive Transformationen auf der Klasse funktionaler Zustände und weist ihre Abgeschlossenheit nach.', '2026-07-12 11:14:28', '2026-07-12 16:50:30'),
(64, 23, '3.4.4', 'Konstruktion funktionaler Organisationsräume', 3, 3.5400, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt rekonstruiert aus rekursiven funktionalen Transformationen invariante Organisationsmengen und daraus funktionale Organisationsräume.', '2026-07-12 11:14:28', '2026-07-12 17:12:40'),
(65, 23, '3.4.5', 'Mathematische Rekonstruktion funktionaler Kohärenz', 3, 3.5500, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Def. 3.4.9, Def. 3.4.10, Lemma 3.4.3, Satz 3.4.5 und die Gleichungen (3.86) bis (3.89).', '2026-07-12 11:14:28', '2026-07-13 09:15:16'),
(66, 23, '3.4.6', 'Mathematische Rekonstruktion funktionaler Raum-Zeit-Kohärenz', 3, 3.5600, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Enthält Def. 3.4.11, Def. 3.4.12, Lemma 3.4.4, Satz 3.4.6 und die Gleichungen (3.90) bis (3.93).', '2026-07-12 11:14:28', '2026-07-13 09:43:31'),
(67, 23, '3.4.7', 'Mathematische Rekonstruktion funktionaler Dynamik', 3, 3.5700, 'review', 1, 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.13, Def. 3.4.14, Lemma 3.4.5, Satz 3.4.7 und die Gleichungen (3.94) bis (3.97).', '2026-07-12 11:14:28', '2026-07-13 10:11:31'),
(68, 23, '3.4.8', 'Mathematische Rekonstruktion funktionaler Attraktoren', 3, 3.5800, 'review', 1, 'Am 13.07.2026 vollständig neu gefasst. Enthält Def. 3.4.15, Def. 3.4.16, Lemma 3.4.6, Satz 3.4.8 und die Gleichungen (3.98) bis (3.101).', '2026-07-12 11:14:28', '2026-07-13 11:00:23'),
(69, 23, '3.4.9', 'Zusammenfassung der mathematischen Rekonstruktion', 3, 3.5900, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(70, 23, '3.4.10', 'Wissenschaftliche Konsequenzen der mathematischen Rekonstruktion', 3, 3.6000, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(83, 22, '3.3.10', 'Übergang zur mathematischen Rekonstruktion', 3, 3.4910, 'review', 1, 'Am 12.07.2026 vollständig neu gefasst. Der Abschnitt schließt die qualitative Axiomatik ab und begründet die methodische Reihenfolge der mathematischen Rekonstruktion in Kapitel 3.4. Keine neue Literaturquelle, kein neues Axiom, keine neue Proposition und keine neue Gleichung.', '2026-07-12 16:17:33', '2026-07-12 16:17:33');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dissertation_tables`
--

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

--
-- Daten für Tabelle `dissertation_tables`
--

INSERT INTO `dissertation_tables` (`table_id`, `table_number`, `section_id`, `title`, `caption`, `table_schema_json`, `table_data_json`, `file_name`, `file_path`, `provenance`, `source_id`, `generation_method`, `validation_status`, `created_revision_id`) VALUES
(1, 'Tab. 3.P1', 23, 'Geplantes Gleichungskataster Kapitel 3', 'Geplante Zusammenstellung aller Gleichungen aus Kapitel 3 mit Textstelle, Nummer, Word-LaTeX und Herkunft.', '{\"columns\": [\"Textstelle\", \"Gleichungsnummer\", \"Word-LaTeX\", \"Herkunft\"]}', '[]', NULL, NULL, 'original', NULL, NULL, 'draft', 3),
(2, 'Tab. 3.1', 21, 'Mathematische Grundbegriffe', 'Vergleich der mathematischen Grundstrukturen.', '{\"columns\": [\"Formalismus\", \"Leistung\", \"Voraussetzung\", \"Grenze\"]}', '[]', NULL, NULL, 'original', NULL, NULL, 'draft', 6),
(3, 'Tab. 3.2', 13, 'Operatoren', 'Systematik linearer, nichtlinearer und rekursiver Operatoren.', '{\"columns\": [\"Operatortyp\", \"Definition\", \"Eigenschaften\", \"FRZK-Relevanz\"]}', '[]', NULL, NULL, 'original', NULL, NULL, 'draft', 6),
(4, 'Tab. 3.3', 19, 'Metriken und Ähnlichkeitsmaße', 'Vergleich ausgewählter Distanz- und Ähnlichkeitsmaße.', '{\"columns\": [\"Maß\", \"Formel\", \"Eigenschaften\", \"Grenzen\"]}', '[]', NULL, NULL, 'original', NULL, NULL, 'draft', 6),
(5, 'Tab. 3.4', 21, 'Vergleich mathematischer Modelle', 'Vergleich der Reichweite bestehender Formalismen.', '{\"columns\": [\"Theorie\", \"Beschreibt\", \"Setzt voraus\", \"Erklärt nicht\"]}', '[]', NULL, NULL, 'original', NULL, NULL, 'draft', 6),
(6, 'Tab. 3.5', 21, 'Forschungslücken und Anforderungen', 'Aus Kapitel 3.2 abgeleitete Anforderungen an Kapitel 3.3.', '{\"columns\": [\"Anforderung\", \"Begründung\", \"Weiterführung in 3.3\"]}', '[]', NULL, NULL, 'original', NULL, NULL, 'draft', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `documents`
--

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

--
-- Daten für Tabelle `documents`
--

INSERT INTO `documents` (`document_id`, `title`, `file_name`, `document_type`, `version_label`, `file_path`, `checksum_sha256`, `created_at`, `updated_at`) VALUES
(1, 'Kapitel 3.1 – Grundlagen der funktionalen Beschreibung von Raum und Zeit', '3.1 Grundlagen der funktionalen Beschreibung von Raum und Zeit(1).docx', 'chapter', '11.07.2026', '/mnt/data/3.1 Grundlagen der funktionalen Beschreibung von Raum und Zeit(1).docx', NULL, '2026-07-12 06:09:35', '2026-07-12 06:09:35');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `equations`
--

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

--
-- Daten für Tabelle `equations`
--

INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1, '3.1', 6, 'Klassische theoretische Entwicklungsrichtung', '\\text{primitive Strukturen}\\longrightarrow\\text{mathematische Räume}\\longrightarrow\\text{Dynamik in diesen Räumen}', '\\text{primitive Strukturen}\\longrightarrow\\text{mathematische Räume}\\longrightarrow\\text{Dynamik in diesen Räumen}', 'Schematische Darstellung klassischer Theorien: Primitive Strukturen und mathematische Räume werden vorausgesetzt, bevor Dynamik innerhalb dieser Räume beschrieben wird.', 'schema', 'original', NULL, NULL, NULL, 'checked', 19),
(2, '3.2', 6, 'Funktionale Entwicklungsrichtung des FRZK', '\\text{funktionale Grundprinzipien}\\longrightarrow\\text{Relationierung}\\longrightarrow\\text{rekursive Transformation}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum- und Zeitstrukturen}', '\\text{funktionale Grundprinzipien}\\longrightarrow\\text{Relationierung}\\longrightarrow\\text{rekursive Transformation}\\longrightarrow\\text{Kohärenz}\\longrightarrow\\text{Raum- und Zeitstrukturen}', 'Schematische Darstellung des FRZK: Raum- und Zeitstrukturen werden erst nach Relationierung, rekursiver Transformation und Kohärenz rekonstruiert.', 'schema', 'original', NULL, NULL, NULL, 'checked', 19),
(3, '3.3', 9, 'Endliche Mengendarstellung', 'M=\\{x_1,x_2,\\ldots,x_n\\}', 'M=\\{x_1,x_2,\\ldots,x_n\\}', 'Darstellung einer endlichen Menge M durch die Aufzählung ihrer Elemente.', 'definition', 'literature', 23, NULL, 'Die Elemente x_1 bis x_n sind unterscheidbar und gehören zur Menge M.', 'checked', 21),
(9, '3.9', 10, 'Transitivität einer Relation', '\\forall a,b,c\\in A:\\;(aRb\\land bRc)\\Longrightarrow aRc', '\\forall a,b,c\\in A:\\;(aRb\\land bRc)\\Longrightarrow aRc', 'Eine Relation R auf A ist transitiv, wenn aus aRb und bRc stets aRc folgt.', '', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 22),
(25, '3.25', 12, 'Abbildungsregel der Verknüpfung', '(a,b)\\longmapsto a\\ast b', '(a,b)\\longmapsto a\\ast b', 'Zuordnung eines Paares zum Verknüpfungsergebnis.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(26, '3.26', 12, 'Assoziativität', '(a\\ast b)\\ast c=a\\ast(b\\ast c)', '(a\\ast b)\\ast c=a\\ast(b\\ast c)', 'Assoziativgesetz.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(27, '3.27', 12, 'Neutrales Element', 'a\\ast e=e\\ast a=a', 'a\\ast e=e\\ast a=a', 'Definition eines neutralen Elements.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(28, '3.28', 12, 'Inverses Element', 'a\\ast a^{-1}=a^{-1}\\ast a=e', 'a\\ast a^{-1}=a^{-1}\\ast a=e', 'Definition eines inversen Elements.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(180, '3.102', 61, 'Nichtnegativität', '\\Delta_F(\\omega_i,\\omega_j)\\ge0', '\\Delta_F(\\omega_i,\\omega_j)\\ge0', 'Nichtnegativität der funktionalen Differenzabbildung.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(181, '3.103', 61, 'Reflexivität funktionaler Identität', '\\Delta_F(\\omega,\\omega)=0', '\\Delta_F(\\omega,\\omega)=0', 'Eine Konfiguration unterscheidet sich funktional nicht von sich selbst.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(182, '3.104', 61, 'Funktionale Differenzstruktur', '\\left(\\Omega_F,\\Delta_F\\right)', '\\left(\\Omega_F,\\Delta_F\\right)', 'Geordnetes Paar aus Trägermenge und Differenzabbildung.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(183, '3.105', 62, 'Funktionale Relation', '\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F', '\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F', 'Relation auf der Trägermenge funktionaler Konfigurationen.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(184, '3.106', 62, 'Aktive funktionale Relation', '\\Delta_F(\\omega_i,\\omega_j)>0', '\\Delta_F(\\omega_i,\\omega_j)>0', 'Aktive Relation bei positiver funktionaler Differenz.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(185, '3.107', 62, 'Triviale Relation', '(\\omega,\\omega)\\in\\mathcal{R}_F', '(\\omega,\\omega)\\in\\mathcal{R}_F', 'Identitätsrelation einer funktionalen Konfiguration.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(186, '3.108', 62, 'Nichttriviale Relation', '\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F', '\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F', 'Positive Differenz induziert eine aktive Relation.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(187, '3.109', 62, 'Funktionale Relationsstruktur', '\\left(\\Omega_F,\\mathcal{R}_F\\right)', '\\left(\\Omega_F,\\mathcal{R}_F\\right)', 'Struktur aus Konfigurationen und funktionalen Relationen.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(188, '3.110', 62, 'Übergang zur Relationsstruktur', '(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)', '(\\Omega_F,\\Delta_F)\\Longrightarrow(\\Omega_F,\\mathcal{R}_F)', 'Übergang von Differenz- zu Relationsstruktur.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(189, '3.111', 63, 'Funktionaler Transformationsoperator', '\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F', '\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F', 'Operator auf funktionalen Relationen.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(190, '3.112', 63, 'Rekursive Transformation', '\\mathcal{T}_F^{\\,n}=\\underbrace{\\mathcal{T}_F\\circ\\mathcal{T}_F\\circ\\cdots\\circ\\mathcal{T}_F}_{n\\text{-mal}}', '\\mathcal{T}_F^{\\,n}=\\underbrace{\\mathcal{T}_F\\circ\\mathcal{T}_F\\circ\\cdots\\circ\\mathcal{T}_F}_{n\\text{-mal}}', 'n-fache Komposition des Transformationsoperators.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(191, '3.113', 63, 'Abgeschlossenheit unter Transformation', '\\mathcal{T}_F(r)\\in\\mathcal{R}_F', '\\mathcal{T}_F(r)\\in\\mathcal{R}_F', 'Transformierte Relationen verbleiben in der Relationsstruktur.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(192, '3.114', 63, 'Rekursive Abgeschlossenheit', '\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F', '\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F', 'Abgeschlossenheit unter beliebig endlicher Iteration.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(193, '3.115', 63, 'Funktionaler Transformationsraum', '\\left(\\mathcal{R}_F,\\mathcal{T}_F\\right)', '\\left(\\mathcal{R}_F,\\mathcal{T}_F\\right)', 'Struktur aus Relationsraum und Transformationsoperator.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(194, '3.116', 63, 'Übergang zum Transformationsraum', '(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)', '(\\Omega_F,\\mathcal{R}_F)\\Longrightarrow(\\mathcal{R}_F,\\mathcal{T}_F)', 'Übergang von Relations- zu Transformationsstruktur.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(195, '3.117', 64, 'Organisationserzeugende Transformation', '\\exists\\,\\mathcal{O}\\subseteq\\mathcal{R}_F:\\quad\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}', '\\exists\\,\\mathcal{O}\\subseteq\\mathcal{R}_F:\\quad\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}', 'Existenz einer invarianten Relationsstruktur.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(196, '3.118', 64, 'Funktionaler Organisationsraum', '\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)', '\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)', 'Geordnetes Paar aus Organisationsstruktur und Transformation.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(197, '3.119', 64, 'Strukturerhaltung', '\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', '\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', 'Invarianz der Organisation unter rekursiver Transformation.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(198, '3.120', 64, 'Abgeschlossenheit des Organisationsraums', '\\mathcal{T}_F(r)\\in\\mathcal{O}', '\\mathcal{T}_F(r)\\in\\mathcal{O}', 'Transformation einer Relation innerhalb der Organisation.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(199, '3.121', 64, 'Existenz funktionaler Organisationsräume', '\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F', '\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F', 'Organisationserzeugende Transformationen begründen Organisationsräume.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(200, '3.122', 64, 'Rekursive Abgeschlossenheit der Organisation', '\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', '\\mathfrak{O}_F\\Longrightarrow\\forall n\\in\\mathbb{N}:\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', 'Korollar zur rekursiven Invarianz.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(201, '3.123', 65, 'Funktionaler Zustand', 'x\\in\\mathcal{X}_F', 'x\\in\\mathcal{X}_F', 'Zugehörigkeit eines funktionalen Zustands zum Zustandsbestand.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(202, '3.124', 65, 'Funktionaler Zustandsraum', '\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)', '\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)', 'Tripel aus Zuständen, Organisation und Transformation.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(203, '3.125', 65, 'Abgeschlossenheit des Zustandsraums', '\\mathcal{T}_F(x)\\in\\mathcal{X}_F', '\\mathcal{T}_F(x)\\in\\mathcal{X}_F', 'Transformierte Zustände verbleiben im Zustandsraum.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(204, '3.126', 65, 'Erreichbarkeit funktionaler Zustände', 'x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'Erreichbarkeit eines Zustands durch endliche Transformation.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(205, '3.127', 65, 'Existenz funktionaler Zustandsräume', '\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F', '\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F', 'Organisationsräume begründen zugehörige Zustandsräume.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(206, '3.128', 65, 'Interne Transformationsstruktur', '\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F', '\\mathcal{T}_F:\\mathcal{X}_F\\longrightarrow\\mathcal{X}_F', 'Transformationsoperator auf dem Zustandsraum.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(207, '3.129', 66, 'Funktionale Kohärenz', '\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}', '\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}', 'Invarianz einer kohärenten Zustandsmenge.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(208, '3.130', 66, 'Kohärenzoperator', '\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F', '\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F', 'Zuordnung von Zuständen zu kohärenten Organisationsstrukturen.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(209, '3.131', 66, 'Erhaltung der Kohärenz', '\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}', '\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}', 'Rekursive Invarianz kohärenter Zustandsmengen.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(210, '3.132', 66, 'Existenz kohärenter Teilräume', '\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F', '\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F', 'Existenz mindestens einer kohärenten Teilstruktur.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(211, '3.133', 66, 'Existenz funktionaler Kohärenz', '\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F', '\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F', 'Zustandsräume besitzen mindestens eine Kohärenzstruktur.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(212, '3.134', 66, 'Einbettung der Kohärenzstruktur', '\\mathcal{K}_F\\subseteq\\mathcal{X}_F', '\\mathcal{K}_F\\subseteq\\mathcal{X}_F', 'Kohärenzstrukturen sind Teil des Zustandsraums.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(213, '3.135', 67, 'Funktionale Erreichbarkeit', 'x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'Erreichbarkeitsrelation zwischen funktionalen Zuständen.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(214, '3.136', 67, 'Reflexivität der Erreichbarkeit', 'x\\leadsto x', 'x\\leadsto x', 'Jeder funktionale Zustand ist von sich selbst erreichbar.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(215, '3.137', 67, 'Transitivität der Erreichbarkeit', 'x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k', 'x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k', 'Transitivität der funktionalen Erreichbarkeitsrelation.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(216, '3.138', 67, 'Funktionale Raumstruktur', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', 'Raumstruktur aus Zuständen und Erreichbarkeitsrelation.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(217, '3.139', 67, 'Rekonstruktion des Raumbegriffs', '\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F', '\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F', 'Zustandsräume induzieren funktionale Raumstrukturen.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(218, '3.140', 67, 'Koordinatenfreie Raumstruktur', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', 'Raum ist vollständig durch funktionale Erreichbarkeit bestimmt.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(219, '3.141', 68, 'Transformationsordnung', 'x_i\\prec_T x_j\\Longleftrightarrow\\exists\\,n>0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'x_i\\prec_T x_j\\Longleftrightarrow\\exists\\,n>0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'Strikte Ordnung funktionaler Zustände durch positive Transformationsanzahl.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(220, '3.142', 68, 'Funktionale Zeitstruktur', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', 'Zeitstruktur aus Raumstruktur und Transformationsordnung.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(221, '3.143', 68, 'Irreflexivität der Transformationsordnung', 'x\\not\\prec_T x', 'x\\not\\prec_T x', 'Kein Zustand liegt in der Transformationsordnung vor sich selbst.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(222, '3.144', 68, 'Transitivität der Transformationsordnung', 'x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k', 'x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k', 'Transitivität der funktionalen Transformationsordnung.', 'lemma', 'original', NULL, NULL, NULL, 'checked', 11),
(223, '3.145', 68, 'Rekonstruktion der Zeitstruktur', '\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F', '\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F', 'Funktionale Raumstrukturen induzieren Zeitstrukturen.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 11),
(224, '3.146', 68, 'Transformationsbestimmte Zeitstruktur', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', 'Zeit wird durch die Ordnung rekursiver Transformationen bestimmt.', 'derived', 'original', NULL, NULL, NULL, 'checked', 11),
(225, '3.147', 69, 'Leitgleichung der Rekonstruktion', '\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F', '\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F', 'Vollständige mathematische Rekonstruktionskette des FRZK.', 'schema', 'original', NULL, NULL, NULL, 'checked', 11),
(226, '3.148', 70, 'Zusammenfassender Hauptsatz des Kapitels', '\\boxed{\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F}', '\\boxed{\\Delta_F\\Longrightarrow\\mathcal{R}_F\\Longrightarrow\\mathcal{T}_F\\Longrightarrow\\mathfrak{O}_F\\Longrightarrow\\mathfrak{X}_F\\Longrightarrow\\mathcal{K}_F\\Longrightarrow\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F}', 'Gerahmte Zusammenfassung der vollständigen FRZK-Rekonstruktion.', 'schema', 'original', NULL, NULL, NULL, 'checked', 11),
(227, '3.4', 10, 'Relation zwischen zwei Mengen', 'R\\subseteq A\\times B', 'R\\subseteq A\\times B', 'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge ihres kartesischen Produkts.', 'definition', 'literature', 27, NULL, 'A und B sind Mengen; A\\times B ist ihr kartesisches Produkt.', 'checked', 22),
(228, '3.5', 10, 'Relation auf einer Menge', 'R\\subseteq A\\times A', 'R\\subseteq A\\times A', 'Eine binäre Relation auf A ist eine Teilmenge des kartesischen Produkts A mal A.', 'definition', 'literature', 27, NULL, 'A ist eine Menge.', 'checked', 22),
(229, '3.6', 10, 'Relationsnotation', 'aRb\\Longleftrightarrow(a,b)\\in R', 'aRb\\Longleftrightarrow(a,b)\\in R', 'Die Schreibweise aRb ist äquivalent dazu, dass das geordnete Paar (a,b) Element der Relation R ist.', 'definition', 'literature', 27, NULL, 'a und b gehören zu den für R zulässigen Grundmengen.', 'checked', 22),
(230, '3.7', 10, 'Reflexivität einer Relation', '\\forall a\\in A:\\;aRa', '\\forall a\\in A:\\;aRa', 'Eine Relation R auf A ist reflexiv, wenn jedes Element von A zu sich selbst in Relation steht.', '', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 22),
(231, '3.8', 10, 'Symmetrie einer Relation', '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa', '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa', 'Eine Relation R auf A ist symmetrisch, wenn aus aRb stets bRa folgt.', '', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 22),
(232, '3.10', 11, 'Funktion zwischen zwei Mengen', 'f:A\\rightarrow B', 'f:A\\rightarrow B', 'Die Funktion f bildet Elemente der Definitionsmenge A in die Zielmenge B ab.', 'definition', 'literature', 29, NULL, 'A und B sind Mengen; f ist eine eindeutige Abbildung.', 'checked', 23),
(233, '3.11', 11, 'Eindeutige Zuordnung', '\\forall x\\in A\\;\\exists!\\;y\\in B:\\;f(x)=y', '\\forall x\\in A\\;\\exists!\\;y\\in B:\\;f(x)=y', 'Jedem Element x der Definitionsmenge A wird genau ein Element y der Zielmenge B zugeordnet.', 'definition', 'literature', 29, NULL, 'f ist eine Funktion von A nach B.', 'checked', 23),
(234, '3.12', 11, 'Komposition zweier Funktionen', '(g\\circ f)(x)=g(f(x))', '(g\\circ f)(x)=g(f(x))', 'Die Komposition führt zunächst f und anschließend g aus.', 'definition', 'literature', 30, NULL, 'f:A\\rightarrow B und g:B\\rightarrow C.', 'checked', 23),
(235, '3.13', 11, 'Iterative Entwicklung', 'x_{n+1}=f(x_n)', 'x_{n+1}=f(x_n)', 'Ein Folgezustand entsteht durch erneute Anwendung derselben Funktion auf den vorhergehenden Zustand.', 'model', 'literature', 30, NULL, 'x_n gehört zum Definitionsbereich von f.', 'checked', 23),
(236, '3.14', 12, 'Innere Verknüpfung', '\\circ:A\\times A\\rightarrow A', '\\circ:A\\times A\\rightarrow A', 'Eine innere Verknüpfung ordnet jedem Paar aus A mal A wieder ein Element aus A zu.', 'definition', 'literature', 31, NULL, 'A ist eine Menge und die Verknüpfung ist auf A definiert.', 'checked', 24),
(237, '3.15', 12, 'Abgeschlossenheit', '\\forall a,b\\in A:\\;a\\circ b\\in A', '\\forall a,b\\in A:\\;a\\circ b\\in A', 'Die Verknüpfung zweier Elemente aus A liefert erneut ein Element aus A.', 'definition', 'literature', 31, NULL, 'Die Verknüpfung ist eine innere Verknüpfung auf A.', 'checked', 24),
(238, '3.16', 12, 'Assoziativität', '(a\\circ b)\\circ c=a\\circ(b\\circ c)', '(a\\circ b)\\circ c=a\\circ(b\\circ c)', 'Die Klammerung dreier verknüpfter Elemente verändert das Ergebnis nicht.', 'definition', 'literature', 31, NULL, 'a, b und c gehören zu A.', 'checked', 24),
(239, '3.17', 12, 'Neutrales Element', 'e\\circ a=a\\circ e=a', 'e\\circ a=a\\circ e=a', 'Das neutrale Element e verändert ein Element a bei der Verknüpfung nicht.', 'definition', 'literature', 32, NULL, 'e und a gehören zu A.', 'checked', 24),
(240, '3.18', 12, 'Inverses Element', 'a\\circ a^{-1}=a^{-1}\\circ a=e', 'a\\circ a^{-1}=a^{-1}\\circ a=e', 'Die Verknüpfung eines Elements mit seinem inversen Element ergibt das neutrale Element.', 'definition', 'literature', 32, NULL, 'A besitzt ein neutrales Element e und zu a existiert ein inverses Element.', 'checked', 24),
(241, '3.19', 13, 'Allgemeiner Operator', 'T:X\\rightarrow Y', 'T:X\\rightarrow Y', 'Ein Operator T bildet Elemente eines mathematischen Raumes X in einen mathematischen Raum Y ab.', 'definition', 'literature', 35, NULL, 'X und Y sind geeignete mathematische Räume.', 'checked', 25),
(242, '3.20', 13, 'Wirkung eines Operators', 'y=T(x)', 'y=T(x)', 'Das Element x wird durch den Operator T auf das Element y abgebildet.', 'definition', 'literature', 35, NULL, 'x gehört zum Definitionsbereich von T.', 'checked', 25),
(243, '3.21', 13, 'Linearität eines Operators', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'Ein linearer Operator erhält Linearkombinationen.', 'definition', 'literature', 35, NULL, 'X und Y sind Vektorräume über demselben Körper; x,y\\in X und \\alpha,\\beta sind Skalare.', 'checked', 25),
(244, '3.22', 13, 'Nichtlinearität eines Operators', 'T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)', 'Ein nichtlinearer Operator erfüllt die Linearitätsbedingung im Allgemeinen nicht.', 'definition', 'literature', 37, NULL, 'Es existieren x,y,\\alpha,\\beta, für die die Linearitätsgleichung nicht gilt.', 'checked', 25),
(245, '3.23', 13, 'Komposition zweier Operatoren', '(T\\circ S)(x)=T(S(x))', '(T\\circ S)(x)=T(S(x))', 'Die Operatorkomposition führt zunächst S und anschließend T aus.', 'definition', 'literature', 35, NULL, 'S:X\\rightarrow Y und T:Y\\rightarrow Z.', 'checked', 25),
(246, '3.24', 13, 'Iteration eines Operators', 'x_{n+1}=T(x_n)', 'x_{n+1}=T(x_n)', 'Durch wiederholte Anwendung desselben Operators entsteht eine rekursive Zustandsfolge.', 'model', 'literature', 37, NULL, 'T bildet den betrachteten Zustandsbereich in sich selbst ab.', 'checked', 25),
(251, '3.29', 15, 'Funktionenraum', '\\mathcal{F}(\\Omega,V)=\\{f\\mid f:\\Omega\\rightarrow V\\}', '\\mathcal{F}(\\Omega,V)=\\{f\\mid f:\\Omega\\rightarrow V\\}', 'Der Funktionenraum enthält alle Funktionen von der Grundmenge Omega in den Wertebereich V.', 'definition', 'literature', 42, NULL, 'Omega ist eine nichtleere Grundmenge und V ein Vektorraum.', 'checked', 27),
(252, '3.30', 15, 'Punktweise Addition von Funktionen', '(f+g)(x)=f(x)+g(x)', '(f+g)(x)=f(x)+g(x)', 'Die Addition zweier Funktionen wird punktweise über ihre Funktionswerte definiert.', 'definition', 'literature', 41, NULL, 'f und g gehören zu demselben Funktionenraum mit vektoriellem Wertebereich.', 'checked', 27),
(253, '3.31', 15, 'Punktweise Skalarmultiplikation', '(\\alpha f)(x)=\\alpha f(x)', '(\\alpha f)(x)=\\alpha f(x)', 'Die Multiplikation einer Funktion mit einem Skalar wird punktweise definiert.', 'definition', 'literature', 41, NULL, 'alpha ist ein Skalar und f gehört zu einem Funktionenraum über demselben Skalarkörper.', 'checked', 27),
(254, '3.32', 15, 'Normaxiome', '\\|f\\|\\ge0,\\quad \\|f\\|=0\\Longleftrightarrow f=0,\\quad \\|\\alpha f\\|=|\\alpha|\\,\\|f\\|,\\quad \\|f+g\\|\\le\\|f\\|+\\|g\\|', '\\|f\\|\\ge0,\\quad \\|f\\|=0\\Longleftrightarrow f=0,\\quad \\|\\alpha f\\|=|\\alpha|\\,\\|f\\|,\\quad \\|f+g\\|\\le\\|f\\|+\\|g\\|', 'Eine Norm erfüllt Nichtnegativität, Definitheit, absolute Homogenität und Dreiecksungleichung.', 'definition', 'literature', 42, NULL, 'f und g gehören zu einem Vektorraum; alpha ist ein Skalar.', 'checked', 27),
(255, '3.33', 15, 'Cauchy-Bedingung', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow\\|f_n-f_m\\|<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb{N}:\\;m,n\\ge N\\Longrightarrow\\|f_n-f_m\\|<\\varepsilon', 'Eine Folge ist eine Cauchy-Folge, wenn ihre Folgenglieder ab einem Index beliebig nahe beieinander liegen.', 'definition', 'literature', 42, NULL, 'Die Folge liegt in einem normierten Vektorraum.', 'checked', 27),
(256, '3.34', 15, 'Durch das Skalarprodukt induzierte Norm', '\\|f\\|=\\sqrt{\\langle f,f\\rangle}', '\\|f\\|=\\sqrt{\\langle f,f\\rangle}', 'In einem Skalarproduktraum wird die Norm durch das Skalarprodukt eines Elements mit sich selbst induziert.', 'derived', 'literature', 41, NULL, 'Es ist ein positives definites Skalarprodukt definiert.', 'checked', 27),
(257, '3.35', 16, 'Kontinuierliches dynamisches System', '\\dot{x}(t)=F(x(t))', '\\dot{x}(t)=F(x(t))', 'Die zeitlich oder parametrisch kontinuierliche Zustandsänderung wird durch das Vektorfeld F bestimmt.', 'model', 'literature', 40, NULL, 'x(t) ist differenzierbar und F ist auf dem Zustandsraum definiert.', 'checked', 28),
(258, '3.36', 16, 'Diskretes dynamisches System', 'x_{n+1}=F(x_n)', 'x_{n+1}=F(x_n)', 'Der Folgezustand eines diskreten dynamischen Systems entsteht durch Anwendung der Abbildung F.', 'model', 'literature', 43, NULL, 'F bildet den betrachteten Zustandsraum in sich selbst ab.', 'checked', 28),
(259, '3.37', 16, 'Fixpunkt', 'F(x^{\\ast})=x^{\\ast}', 'F(x^{\\ast})=x^{\\ast}', 'Ein Fixpunkt bleibt unter der Dynamik unverändert.', 'definition', 'literature', 37, NULL, 'x^{\\ast} liegt im Definitionsbereich von F.', 'checked', 28),
(260, '3.38', 16, 'Jacobi-Matrix', 'J_F(x)=\\left(\\frac{\\partial F_i}{\\partial x_j}(x)\\right)_{i,j}', 'J_F(x)=\\left(\\frac{\\partial F_i}{\\partial x_j}(x)\\right)_{i,j}', 'Die Jacobi-Matrix enthält die partiellen Ableitungen der Komponenten des Vektorfeldes F.', 'definition', 'literature', 39, NULL, 'F ist in einer Umgebung von x differenzierbar.', 'checked', 28),
(261, '3.39', 16, 'Attraktorbedingung', '\\operatorname{dist}(F^{n}(x_0),A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)', '\\operatorname{dist}(F^{n}(x_0),A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)', 'Die iterierten Zustände eines Anfangswertes nähern sich der invarianten Menge A an.', 'definition', 'literature', 43, NULL, 'A ist invariant und x_0 liegt in ihrem Einzugsgebiet.', 'checked', 28),
(262, '3.40', 16, 'Lyapunov-Entwicklung benachbarter Trajektorien', '\\|\\delta x(t)\\|\\approx\\|\\delta x(0)\\|e^{\\lambda t}', '\\|\\delta x(t)\\|\\approx\\|\\delta x(0)\\|e^{\\lambda t}', 'Die lokale Trennung benachbarter Trajektorien wird näherungsweise durch den Lyapunov-Exponenten lambda beschrieben.', 'model', 'literature', 44, NULL, 'Die linearisierte lokale Entwicklung ist im betrachteten Bereich anwendbar.', 'checked', 28),
(263, '3.41', 17, 'Informationsgehalt eines Ereignisses', 'I(x)=-\\log_{2}p(x)', 'I(x)=-\\log_{2}p(x)', 'Der Informationsgehalt eines Ereignisses steigt mit abnehmender Eintrittswahrscheinlichkeit.', 'definition', 'literature', 46, NULL, '0<p(x)\\le1.', 'checked', 29),
(264, '3.42', 17, 'Shannon-Entropie', 'H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i', 'H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i', 'Die Shannon-Entropie beschreibt die mittlere Unsicherheit einer diskreten Zufallsvariablen.', 'definition', 'literature', 46, NULL, 'p_i\\ge0 und \\sum_{i=1}^{n}p_i=1.', 'checked', 29),
(265, '3.43', 17, 'Gemeinsame Entropie', 'H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)', 'H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)', 'Die gemeinsame Entropie beschreibt die Unsicherheit zweier gemeinsam verteilter Zufallsvariablen.', 'definition', 'literature', 45, NULL, 'p(x_i,y_j) ist eine gemeinsame Wahrscheinlichkeitsverteilung.', 'checked', 29),
(266, '3.44', 17, 'Gegenseitige Information', 'I(X;Y)=H(X)+H(Y)-H(X,Y)', 'I(X;Y)=H(X)+H(Y)-H(X,Y)', 'Die gegenseitige Information misst die statistische Abhängigkeit zweier Zufallsvariablen.', 'metric', 'literature', 45, NULL, 'X und Y besitzen definierte Rand- und gemeinsame Verteilungen.', 'checked', 29),
(267, '3.45', 17, 'Kullback-Leibler-Divergenz', 'D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}', 'D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}', 'Die Kullback-Leibler-Divergenz quantifiziert die Abweichung einer Wahrscheinlichkeitsverteilung P von einer Referenzverteilung Q.', 'metric', 'literature', 45, NULL, 'P(i)\\ge0, Q(i)>0 für alle i mit P(i)>0 und \\sum_iP(i)=\\sum_iQ(i)=1.', 'checked', 29),
(268, '3.46', 18, 'Graph', 'G=(V,E)', 'G=(V,E)', 'Ein Graph G besteht aus einer Knotenmenge V und einer Kantenmenge E.', 'definition', 'literature', 47, NULL, 'V ist eine Menge von Knoten und E eine Menge zulässiger Kanten.', 'checked', 30),
(269, '3.47', 18, 'Adjazenzmatrix', 'A_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}', 'A_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}', 'Die Adjazenzmatrix codiert, ob zwischen zwei Knoten eine Kante besteht.', 'definition', 'literature', 47, NULL, 'G ist ein einfacher ungewichteter Graph.', 'checked', 30),
(270, '3.48', 18, 'Knotengrad', 'k_i=\\sum_{j=1}^{n}A_{ij}', 'k_i=\\sum_{j=1}^{n}A_{ij}', 'Der Grad eines Knotens entspricht der Anzahl seiner adjazenten Knoten.', 'metric', 'literature', 48, NULL, 'A ist die Adjazenzmatrix eines einfachen Graphen mit n Knoten.', 'checked', 30),
(271, '3.49', 18, 'Pfad', 'P=(v_0,v_1,\\ldots,v_m),\\qquad (v_{r-1},v_r)\\in E\\;\\text{für}\\;r=1,\\ldots,m', 'P=(v_0,v_1,\\ldots,v_m),\\qquad (v_{r-1},v_r)\\in E\\;\\text{für}\\;r=1,\\ldots,m', 'Ein Pfad ist eine geordnete Knotenfolge, deren aufeinanderfolgende Knoten durch Kanten verbunden sind.', 'definition', 'literature', 47, NULL, 'Alle v_r gehören zur Knotenmenge V.', 'checked', 30),
(272, '3.50', 18, 'Netzwerkdichte', '\\rho=\\frac{2|E|}{|V|(|V|-1)}', '\\rho=\\frac{2|E|}{|V|(|V|-1)}', 'Die Dichte eines einfachen ungerichteten Graphen ist das Verhältnis vorhandener zu maximal möglichen Kanten.', 'metric', 'literature', 48, NULL, 'Der Graph ist einfach, ungerichtet und besitzt mindestens zwei Knoten.', 'checked', 30),
(273, '3.51', 18, 'Lokaler Clusterkoeffizient', 'C_i=\\frac{2e_i}{k_i(k_i-1)}', 'C_i=\\frac{2e_i}{k_i(k_i-1)}', 'Der lokale Clusterkoeffizient misst den Anteil realisierter Verbindungen zwischen den Nachbarn eines Knotens.', 'metric', 'literature', 48, NULL, 'k_i\\ge2 und e_i ist die Zahl der Kanten zwischen den Nachbarn von v_i.', 'checked', 30),
(274, '3.52', 19, 'Metrik', 'd:X\\times X\\rightarrow\\mathbb{R}_{\\ge0}', 'd:X\\times X\\rightarrow\\mathbb{R}_{\\ge0}', 'Eine Metrik ordnet jedem geordneten Paar von Zuständen eine nichtnegative reelle Distanz zu.', 'definition', 'literature', 49, NULL, 'X ist eine nichtleere Menge.', 'checked', 31),
(275, '3.53', 19, 'Nichtnegativität und Definitheit', 'd(x,y)\\ge0,\\qquad d(x,y)=0\\Longleftrightarrow x=y', 'd(x,y)\\ge0,\\qquad d(x,y)=0\\Longleftrightarrow x=y', 'Eine Metrik ist nichtnegativ und verschwindet genau für identische Elemente.', 'definition', 'literature', 49, NULL, 'x,y\\in X und d ist eine Metrik auf X.', 'checked', 31),
(276, '3.54', 19, 'Symmetrie einer Metrik', 'd(x,y)=d(y,x)', 'd(x,y)=d(y,x)', 'Der Abstand zweier Elemente ist unabhängig von der Reihenfolge seiner Argumente.', 'definition', 'literature', 49, NULL, 'x,y\\in X und d ist eine Metrik auf X.', 'checked', 31),
(277, '3.55', 19, 'Dreiecksungleichung', 'd(x,z)\\le d(x,y)+d(y,z)', 'd(x,z)\\le d(x,y)+d(y,z)', 'Der direkte Abstand zweier Elemente ist nicht größer als der Weg über ein drittes Element.', 'definition', 'literature', 49, NULL, 'x,y,z\\in X und d ist eine Metrik auf X.', 'checked', 31),
(278, '3.56', 19, 'Euklidische Distanz', 'd_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}', 'd_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}', 'Die euklidische Distanz misst den geometrischen Abstand zweier Vektoren im n-dimensionalen Raum.', 'metric', 'literature', 49, NULL, 'x,y\\in\\mathbb{R}^{n}.', 'checked', 31),
(279, '3.57', 19, 'Kosinusähnlichkeit', '\\operatorname{cos}(x,y)=\\frac{x^{\\top}y}{\\|x\\|\\,\\|y\\|}', '\\operatorname{cos}(x,y)=\\frac{x^{\\top}y}{\\|x\\|\\,\\|y\\|}', 'Die Kosinusähnlichkeit misst die Richtungsähnlichkeit zweier von Null verschiedener Vektoren.', 'metric', 'literature', 50, NULL, 'x,y\\in\\mathbb{R}^{n}\\setminus\\{0\\}.', 'checked', 31),
(280, '3.58', 20, 'Lokale Zustandsaktualisierung', 'x_i^{(n+1)}=F_i\\!\\left(x_i^{(n)},\\mathcal{N}_i^{(n)}\\right)', 'x_i^{(n+1)}=F_i\\!\\left(x_i^{(n)},\\mathcal{N}_i^{(n)}\\right)', 'Der Folgezustand einer lokalen Einheit entsteht aus ihrem aktuellen Zustand und ihrer funktionalen Nachbarschaft.', 'model', 'literature', 51, NULL, 'Die lokale Aktualisierungsregel F_i und die Nachbarschaft N_i sind definiert.', 'checked', 32),
(281, '3.59', 20, 'Gekoppelte Systemdynamik', '\\frac{dX}{dt}=F(X)+C(X)', '\\frac{dX}{dt}=F(X)+C(X)', 'Die Gesamtdynamik setzt sich aus intrinsischer Entwicklung und Kopplung zwischen Systembestandteilen zusammen.', 'model', 'literature', 51, NULL, 'X ist ein Systemzustand; F und C sind auf dem Zustandsraum definiert.', 'checked', 32),
(282, '3.60', 20, 'Rekursive Selbstorganisation', 'X_{n+1}=F\\!\\left(X_n,X_n^{\\mathrm{Umgebung}}\\right)', 'X_{n+1}=F\\!\\left(X_n,X_n^{\\mathrm{Umgebung}}\\right)', 'Der nächste Gesamtzustand entsteht aus dem aktuellen Systemzustand und seiner Umgebung.', 'model', 'literature', 51, NULL, 'Die System-Umwelt-Kopplung ist in F enthalten.', 'checked', 32),
(283, '3.61', 20, 'Ordnungsparameter', '\\eta=\\Phi(X)', '\\eta=\\Phi(X)', 'Ein makroskopischer Ordnungsparameter wird aus dem mikroskopischen Gesamtzustand abgeleitet.', 'definition', 'literature', 12, NULL, 'Phi ist eine geeignete Reduktionsabbildung auf eine makroskopische Größe.', 'checked', 32),
(284, '3.62', 20, 'Rückkopplung zwischen Ordnung und Mikrodynamik', 'X_{n+1}=F\\!\\left(X_n,\\eta_n\\right),\\qquad \\eta_n=\\Phi(X_n)', 'X_{n+1}=F\\!\\left(X_n,\\eta_n\\right),\\qquad \\eta_n=\\Phi(X_n)', 'Der Ordnungsparameter wird aus dem Gesamtzustand gebildet und beeinflusst anschließend die weitere Zustandsentwicklung.', 'model', 'literature', 12, NULL, 'Die Abbildungen F und Phi sind definiert und kompatibel.', 'checked', 32),
(285, '3.63', 20, 'Attraktordynamik emergenter Organisation', '\\operatorname{dist}(X_n,A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)', '\\operatorname{dist}(X_n,A)\\longrightarrow0\\quad(n\\longrightarrow\\infty)', 'Die rekursive Dynamik nähert sich einer stabilen oder metastabilen Organisationsmenge A an.', 'model', 'literature', 52, NULL, 'A ist invariant oder hinreichend stabil und X_0 liegt in ihrem Einzugsgebiet.', 'checked', 32),
(286, '3.64', 52, 'Formale Darstellung von Axiom A1', '\\exists\\,a,b:\\;a\\not\\equiv_F b', '\\exists\\,a,b:\\;a\\not\\equiv_F b', 'Es existieren mindestens zwei funktional nicht äquivalente Konfigurationen beziehungsweise die prinzipielle Möglichkeit funktionaler Nichtidentität.', 'axiom', 'original', NULL, 'Formale Repräsentation des qualitativen Axioms A1.', 'Die Symbole a und b dienen ausschließlich als formale Platzhalter; es wird noch keine Menge von Konfigurationen vorausgesetzt.', 'checked', 35),
(287, '3.65', 53, 'Formale Darstellung von Axiom A2', '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)', '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)', 'Funktionale Nichtäquivalenz eröffnet die Möglichkeit einer funktionalen Relation zwischen den unterschiedenen Konfigurationen.', 'axiom', 'original', NULL, 'Formale Repräsentation des qualitativen Axioms A2 auf Grundlage von A1.', 'A1 gilt. Das Modalzeichen kennzeichnet ausschließlich eine Möglichkeit; eine mathematische Relation wird noch nicht vorausgesetzt.', 'checked', 36),
(288, '3.66', 54, 'Formale Darstellung von Axiom A3', '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)', '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)', 'Eine funktionale Relation kann eine neue funktionale Konfiguration hervorbringen, die ihrerseits erneut funktional relationierbar ist.', 'axiom', 'original', NULL, 'Formale Repräsentation des qualitativen Axioms A3.', 'A1 und A2 gelten. Das Modalzeichen beschreibt nur Möglichkeit; eine Folge, ein Operator und Zeit werden nicht vorausgesetzt.', 'checked', 37),
(289, '3.67', 54, 'Strukturelle Voraussetzung von Axiom A3', 'A1,\\;A2\\Longrightarrow\\text{Voraussetzung für }A3', 'A1,\\;A2\\Longrightarrow\\text{Voraussetzung für }A3', 'Axiom A3 setzt funktionale Unterscheidbarkeit und funktionale Relationierbarkeit strukturell voraus, ohne logisch aus A1 und A2 ableitbar zu sein.', 'schema', 'original', NULL, 'Schematische Darstellung der axiomatischen Abhängigkeitsstruktur.', 'A1 und A2 sind bereits registriert.', 'checked', 37),
(292, '3.68', 55, 'Formale Darstellung von Axiom A4', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', 'Rekursive funktionale Transformation eröffnet die Möglichkeit stabiler funktionaler Organisation.', 'axiom', 'original', NULL, 'Formale Repräsentation des qualitativen Axioms A4.', 'A1 bis A3 gelten. Organisation und Stabilität werden noch nicht als metrische oder topologische Strukturen vorausgesetzt.', 'checked', 38),
(293, '3.69', 55, 'Strukturelle Voraussetzung von Axiom A4', 'A1,\\;A2,\\;A3\\Longrightarrow\\text{Voraussetzung für }A4', 'A1,\\;A2,\\;A3\\Longrightarrow\\text{Voraussetzung für }A4', 'Axiom A4 setzt funktionale Unterscheidbarkeit, Relationierbarkeit und rekursive Transformation strukturell voraus, ohne aus ihnen logisch zwingend ableitbar zu sein.', 'schema', 'original', NULL, 'Schematische Darstellung der axiomatischen Abhängigkeitsstruktur.', 'A1, A2 und A3 sind bereits registriert.', 'checked', 38),
(294, '3.70', 56, 'Formale Darstellung von Axiom A5', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', 'Stabile funktionale Organisation eröffnet die Möglichkeit reproduzierbarer funktionaler Organisationsmuster.', 'axiom', 'original', NULL, 'Formale Repräsentation des qualitativen Axioms A5.', 'A1 bis A4 gelten. Reproduzierbarkeit wird qualitativ verstanden; Äquivalenzklasse, Häufigkeit und Wahrscheinlichkeit werden noch nicht vorausgesetzt.', 'checked', 40),
(295, '3.71', 56, 'Strukturelle Voraussetzung von Axiom A5', 'A1,\\;A2,\\;A3,\\;A4\\Longrightarrow\\text{Voraussetzung für }A5', 'A1,\\;A2,\\;A3,\\;A4\\Longrightarrow\\text{Voraussetzung für }A5', 'Axiom A5 setzt funktionale Unterscheidbarkeit, Relationierbarkeit, rekursive Transformation und stabile Organisation strukturell voraus, ohne logisch aus ihnen ableitbar zu sein.', 'schema', 'original', NULL, 'Schematische Darstellung der axiomatischen Abhängigkeitsstruktur.', 'A1 bis A4 sind bereits registriert.', 'checked', 40),
(296, '3.72', 57, 'Gemeinsamer axiomatischer Ausgangspunkt des FRZK', 'A1\\land A2\\land A3\\land A4\\land A5\\Longrightarrow\\Diamond\\,\\mathcal{E}_F', 'A1\\land A2\\land A3\\land A4\\land A5\\Longrightarrow\\Diamond\\,\\mathcal{E}_F', 'Die fünf gemeinsam angenommenen Grundaxiome eröffnen die Möglichkeit einer funktionalen Entwicklungsstruktur. Die Gleichung behauptet keine logische Ableitung der Axiome auseinander.', 'schema', 'original', NULL, 'Zusammenfassende Darstellung des gemeinsam vorausgesetzten Axiomensystems.', 'A1 bis A5 werden gemeinsam angenommen. Die Möglichkeit einer funktionalen Entwicklungsstruktur wird erst in Abschnitt 3.3.9 propositionell präzisiert und in Kapitel 3.4 mathematisch konstruiert.', 'checked', 41),
(297, '3.73', 58, 'Formale Darstellung von Proposition Prop. 3.1', '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F', '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F', 'Die gemeinsame Annahme der fünf Grundaxiome eröffnet die Möglichkeit funktionaler Entwicklungsprozesse.', '', 'original', NULL, 'Formale Darstellung von Proposition Prop. 3.1.', 'A1 bis A5 gelten gemeinsam. Die Proposition behauptet Möglichkeit, nicht notwendige Realisierung.', 'checked', 42),
(298, '3.74', 61, 'Definition des funktionalen Zustands', 'x:=\\mathcal{O}_F', 'x:=\\mathcal{O}_F', 'Der funktionale Zustand x wird als mathematische Repräsentation einer stabilen funktionalen Organisation definiert.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.1 auf Grundlage von Axiom A4.', 'Axiom A4 gilt. Das Symbol x bezeichnet noch keinen Punkt eines metrischen oder topologischen Raumes.', 'checked', 45),
(299, '3.75', 61, 'Klasse funktionaler Zustände', 'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', 'X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', 'Die Klasse X enthält die im betrachteten Modell definierten funktionalen Zustände.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.2 auf Grundlage von Def. 3.4.1 und Axiom A5.', 'Die Zustände x_i sind nach Def. 3.4.1 definiert. X ist noch kein vollständig strukturierter Zustandsraum.', 'checked', 45),
(300, '3.76', 62, 'Funktionale Relation', '\\mathcal{R}_F\\subseteq X\\times X', '\\mathcal{R}_F\\subseteq X\\times X', 'Die funktionale Relation ist eine Teilmenge des kartesischen Produkts der Klasse funktionaler Zustände mit sich selbst.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.3.', 'Def. 3.4.2 gilt.', 'checked', 46),
(301, '3.77', 62, 'Indikator funktionaler Relation', 'x_i\\,\\mathcal{R}_F\\,x_j\\Longleftrightarrow\\rho_F(x_i,x_j)=1', 'x_i\\,\\mathcal{R}_F\\,x_j\\Longleftrightarrow\\rho_F(x_i,x_j)=1', 'Die Indikatorfunktion rho_F kennzeichnet, ob zwischen zwei funktionalen Zuständen eine funktionale Relation besteht.', 'definition', 'original', NULL, 'Binäre Darstellung der Zugehörigkeit eines geordneten Zustandspaares zur funktionalen Relation.', 'x_i,x_j\\in X und \\rho_F:X\\times X\\rightarrow\\{0,1\\}.', 'checked', 46),
(302, '3.78', 62, 'Funktionale Relationsstruktur', '\\mathfrak{G}_F=(X,\\mathcal{R}_F)', '\\mathfrak{G}_F=(X,\\mathcal{R}_F)', 'Die Klasse funktionaler Zustände und die funktionale Relation bilden gemeinsam eine funktionale Relationsstruktur.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.4.', 'Def. 3.4.2 und Def. 3.4.3 gelten.', 'checked', 46),
(303, '3.79', 63, 'Funktionale Transformation', '\\mathcal{T}_F:X\\rightarrow X', '\\mathcal{T}_F:X\\rightarrow X', 'Die funktionale Transformation bildet die Klasse funktionaler Zustände in sich selbst ab.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.5.', 'Def. 3.4.2 gilt.', 'checked', 47),
(304, '3.80', 63, 'Rekursive funktionale Transformation', '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}', '\\mathcal{T}_F^{\\,n}:X\\rightarrow X,\\qquad n\\in\\mathbb{N}', 'Jede endliche Iteration der funktionalen Transformation bildet die Zustandsklasse wieder in sich selbst ab.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.6.', 'Def. 3.4.5 gilt und die endliche Komposition ist wohldefiniert.', 'checked', 47),
(305, '3.81', 63, 'Abgeschlossenheit funktionaler Transformationen', '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X', '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X', 'Jeder transformierte funktionale Zustand verbleibt innerhalb der Zustandsklasse.', 'theorem', 'original', NULL, 'Formale Darstellung von Satz 3.4.3; folgt unmittelbar aus der Abbildungsdefinition T_F:X->X.', 'Def. 3.4.2 und Def. 3.4.5 gelten.', 'checked', 47),
(306, '3.82', 64, 'Existenz einer funktionalen Organisationsmenge', '\\exists\\,\\mathcal{O}_F\\subseteq X,\\qquad\\mathcal{O}_F\\neq\\varnothing', '\\exists\\,\\mathcal{O}_F\\subseteq X,\\qquad\\mathcal{O}_F\\neq\\varnothing', 'Es existiert eine nichtleere Teilmenge der Zustandsklasse, die als Kandidat einer stabilen funktionalen Organisation dient.', 'definition', 'original', NULL, 'Erster Bestandteil von Def. 3.4.7.', 'Die Zustandsklasse X ist definiert.', 'checked', 48),
(307, '3.83', 64, 'Invarianz der funktionalen Organisationsmenge', '\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F', '\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F', 'Die Organisationsmenge bleibt unter der funktionalen Transformation als Menge invariant.', 'definition', 'original', NULL, 'Zweiter Bestandteil von Def. 3.4.7.', 'Def. 3.4.5 und Def. 3.4.7 gelten.', 'checked', 48),
(308, '3.84', 64, 'Funktionaler Organisationsraum', '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)', '\\mathfrak{O}_F=(\\mathcal{O}_F,\\mathcal{T}_F)', 'Die invariante Organisationsmenge und die auf ihr wirkende Transformation bilden gemeinsam einen funktionalen Organisationsraum.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.8.', 'Def. 3.4.7 gilt.', 'checked', 48),
(309, '3.85', 64, 'Rekursive Abgeschlossenheit des Organisationsraums', '\\forall n\\in\\mathbb{N}:\\;\\mathcal{T}_F^{\\,n}(\\mathcal{O}_F)=\\mathcal{O}_F', '\\forall n\\in\\mathbb{N}:\\;\\mathcal{T}_F^{\\,n}(\\mathcal{O}_F)=\\mathcal{O}_F', 'Die Organisationsmenge bleibt unter jeder endlichen Iteration der organisationserzeugenden Transformation invariant.', 'theorem', 'original', NULL, 'Folgt aus der Invarianzbedingung durch vollständige Induktion.', 'Def. 3.4.6 und Gleichung (3.83) gelten.', 'checked', 48),
(310, '3.86', 65, 'Funktionale Kohärenzfunktion', '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]', '\\kappa:\\mathfrak{O}_F\\rightarrow[0,1]', 'Die Kohärenzfunktion ordnet jedem funktionalen Organisationsraum einen normierten Kohärenzwert zu.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.9.', 'Def. 3.4.8 gilt.', 'checked', 49),
(311, '3.87', 65, 'Kohärenzerhaltende Transformation', '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', '\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', 'Eine kohärenzerhaltende Transformation lässt den Kohärenzwert des Organisationsraums invariant.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.10.', 'Def. 3.4.9 gilt.', 'checked', 49),
(312, '3.88', 65, 'Rekursive Kohärenzerhaltung', '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', 'Der Kohärenzwert bleibt unter jeder endlichen Iteration einer kohärenzerhaltenden Transformation unverändert.', 'lemma', 'original', NULL, 'Formale Darstellung von Lemma 3.4.3.', 'Def. 3.4.10 gilt.', 'checked', 49),
(313, '3.89', 65, 'Existenz kohärenter Organisationsräume', '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)', '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)', 'Eine kohärenzerhaltende Transformation begründet einen wohldefinierten Kohärenzwert des Organisationsraums.', 'theorem', 'original', NULL, 'Formale Darstellung von Satz 3.4.5.', 'Def. 3.4.9 und Def. 3.4.10 gelten.', 'checked', 49),
(314, '3.90', 66, 'Funktionale Raum-Zeit-Kohärenzrelation', '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F', '\\mathcal{K}\\subseteq\\mathfrak{O}_F\\times\\mathfrak{O}_F', 'Die funktionale Raum-Zeit-Kohärenzrelation koppelt geordnete Paare funktionaler Organisationsräume.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.11.', 'Def. 3.4.8 gilt.', 'checked', 50),
(315, '3.91', 66, 'Raum-Zeit-Kohärenzfunktion', '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]', '\\chi:\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]', 'Die Raum-Zeit-Kohärenzfunktion ordnet jedem Paar funktionaler Organisationsräume einen normierten Kopplungswert zu.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.12.', 'Def. 3.4.11 gilt.', 'checked', 50),
(316, '3.92', 66, 'Symmetrie der Raum-Zeit-Kohärenz', '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)', '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)', 'Bei wechselseitig definierter Kopplung ist die Raum-Zeit-Kohärenzfunktion symmetrisch.', 'lemma', 'original', NULL, 'Formale Darstellung von Lemma 3.4.4.', 'Def. 3.4.12 gilt und die Kopplung ist wechselseitig.', 'checked', 50),
(317, '3.93', 66, 'Funktionales Raum-Zeit-Kohärenzsystem', '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)', '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)', 'Das Funktionale Raum-Zeit-Kohärenzsystem besteht aus funktionalen Organisationsräumen, ihrer Kohärenzrelation und der quantifizierenden Raum-Zeit-Kohärenzfunktion.', 'theorem', 'original', NULL, 'Formale Darstellung von Satz 3.4.6.', 'Def. 3.4.8, Def. 3.4.11 und Def. 3.4.12 gelten.', 'checked', 50),
(318, '3.94', 67, 'Funktionale Dynamikfunktion', '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}', '\\Delta_{\\kappa}:\\mathfrak{FRZK}\\rightarrow\\mathbb{R}', 'Die Dynamikfunktion ordnet einem funktionalen Raum-Zeit-Kohärenzsystem eine reelle Kohärenzänderung zu.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.13.', 'Def. 3.4.9 und Satz 3.4.6 gelten.', 'checked', 51),
(319, '3.95', 67, 'Funktionale Entwicklungsbahn', '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)', '\\Gamma_F=\\left(\\mathfrak{O}_0,\\mathfrak{O}_1,\\ldots,\\mathfrak{O}_n\\right)', 'Eine funktionale Entwicklungsbahn ist eine geordnete Folge funktionaler Organisationsräume.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.14.', 'Def. 3.4.6 und Def. 3.4.8 gelten.', 'checked', 51);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(320, '3.96', 67, 'Kohärenzdifferenz auf Entwicklungsbahnen', '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)', '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)', 'Die funktionale Dynamik zwischen zwei aufeinanderfolgenden Organisationsräumen wird als Differenz ihrer Kohärenzwerte definiert.', 'lemma', 'original', NULL, 'Formale Darstellung von Lemma 3.4.5.', 'Def. 3.4.9, Def. 3.4.13 und Def. 3.4.14 gelten.', 'checked', 51),
(321, '3.97', 67, 'Rekonstruktion funktionaler Entwicklung', '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F', '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F', 'Eine wohldefinierte endliche rekursive Transformationsfolge erzeugt eine funktionale Entwicklungsbahn.', 'theorem', 'original', NULL, 'Formale Darstellung von Satz 3.4.7.', 'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten.', 'checked', 51),
(322, '3.98', 68, 'Funktionaler Attraktor', '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A', '\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A', 'Ein funktionaler Organisationsraum wird nach n rekursiven Transformationen wieder erreicht.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.15.', 'Def. 3.4.6 und Def. 3.4.8 gelten; n ist positiv und endlich.', 'checked', 52),
(323, '3.99', 68, 'Attraktorenmenge', '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}', '\\mathcal{A}_F=\\left\\{\\mathfrak{O}_A\\mid\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)=\\mathfrak{O}_A\\right\\}', 'Die Attraktorenmenge enthält alle funktionalen Organisationsräume, welche die Wiederkehrbedingung erfüllen.', 'definition', 'original', NULL, 'Formale Darstellung von Def. 3.4.16.', 'Def. 3.4.15 gilt.', 'checked', 52),
(324, '3.100', 68, 'Kohärenzerhaltung funktionaler Attraktoren', '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)', '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)', 'Die Wiederkehr desselben funktionalen Organisationsraums erhält dessen Kohärenzwert.', 'lemma', 'original', NULL, 'Formale Darstellung von Lemma 3.4.6.', 'Def. 3.4.9 und Def. 3.4.15 gelten.', 'checked', 52),
(325, '3.101', 68, 'Existenz funktionaler Attraktoren', '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F', '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F', 'Eine unendliche deterministische Entwicklungsbahn in einer endlichen Menge funktionaler Organisationsräume enthält mindestens einen wiederkehrenden Organisationsraum.', 'theorem', 'original', NULL, 'Formale Darstellung von Satz 3.4.8 auf Grundlage des Schubfachprinzips.', 'Die Entwicklungsbahn ist deterministisch, unendlich fortsetzbar und nimmt Werte in einer endlichen Menge funktionaler Organisationsräume an.', 'checked', 52);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `equation_dependencies`
--

CREATE TABLE `equation_dependencies` (
  `dependency_id` bigint(20) UNSIGNED NOT NULL,
  `equation_id` bigint(20) UNSIGNED NOT NULL,
  `depends_on_equation_id` bigint(20) UNSIGNED NOT NULL,
  `dependency_type` enum('derived_from','uses','special_case_of','generalizes','validates','contrasts') NOT NULL,
  `dependency_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `equation_dependencies`
--

INSERT INTO `equation_dependencies` (`dependency_id`, `equation_id`, `depends_on_equation_id`, `dependency_type`, `dependency_note`) VALUES
(1, 2, 1, 'contrasts', 'Die FRZK-Entwicklungsrichtung wird der klassischen Entwicklungsrichtung gegenübergestellt.'),
(2, 237, 236, 'uses', 'Die Abgeschlossenheit konkretisiert die innere Verknüpfung aus Gleichung (3.14).'),
(3, 238, 236, 'uses', 'Die Assoziativität setzt die innere Verknüpfung aus Gleichung (3.14) voraus.'),
(4, 239, 236, 'uses', 'Das neutrale Element wird bezüglich der inneren Verknüpfung definiert.'),
(5, 240, 239, 'uses', 'Die Definition des inversen Elements setzt die Existenz des neutralen Elements voraus.'),
(6, 242, 241, 'uses', 'Die Operatorwirkung konkretisiert die allgemeine Operatordefinition.'),
(7, 243, 241, 'special_case_of', 'Lineare Operatoren bilden eine spezielle Klasse allgemeiner Operatoren.'),
(8, 244, 243, 'contrasts', 'Die Nichtlinearität wird durch die Verletzung der Linearitätsbedingung abgegrenzt.'),
(9, 245, 241, 'uses', 'Die Komposition setzt kompatible Operatoren voraus.'),
(10, 246, 242, 'uses', 'Die Iteration beruht auf der wiederholten Operatorwirkung.'),
(11, 246, 245, 'special_case_of', 'Die Iteration ist eine wiederholte Komposition desselben Operators.'),
(12, 252, 251, 'uses', 'Die punktweise Addition setzt den Funktionenraum voraus.'),
(13, 253, 251, 'uses', 'Die Skalarmultiplikation setzt den Funktionenraum voraus.'),
(14, 254, 252, 'uses', 'Die Dreiecksungleichung verwendet die Addition des Funktionenraums.'),
(15, 255, 254, 'uses', 'Die Cauchy-Bedingung setzt eine Norm voraus.'),
(16, 256, 254, 'special_case_of', 'Die durch das Skalarprodukt induzierte Norm ist eine spezielle Normkonstruktion.'),
(17, 258, 257, 'contrasts', 'Die diskrete Dynamik wird der kontinuierlichen Dynamik gegenübergestellt.'),
(18, 259, 258, 'uses', 'Der Fixpunkt ist eine spezielle Invarianzbedingung der diskreten Dynamik.'),
(19, 260, 257, 'uses', 'Die Jacobi-Matrix linearisiert das kontinuierliche Vektorfeld lokal.'),
(20, 261, 258, 'uses', 'Die Attraktorbedingung beruht auf wiederholter Anwendung der diskreten Dynamik.'),
(21, 262, 260, 'derived_from', 'Die lokale Lyapunov-Entwicklung wird aus der linearisierten Dynamik motiviert.'),
(22, 264, 263, 'derived_from', 'Die Shannon-Entropie ist der Erwartungswert des Informationsgehalts einzelner Ereignisse.'),
(23, 265, 264, 'generalizes', 'Die gemeinsame Entropie erweitert den Entropiebegriff auf gemeinsam verteilte Zufallsvariablen.'),
(24, 266, 265, 'uses', 'Die gegenseitige Information verwendet die gemeinsame Entropie.'),
(25, 266, 264, 'uses', 'Die gegenseitige Information verwendet die Randentropien.'),
(26, 267, 263, 'uses', 'Die Kullback-Leibler-Divergenz beruht auf logarithmischen Informationsverhältnissen.'),
(27, 269, 268, 'uses', 'Die Adjazenzmatrix codiert die Kantenstruktur des Graphen.'),
(28, 270, 269, 'derived_from', 'Der Knotengrad ergibt sich aus der Zeilensumme der Adjazenzmatrix.'),
(29, 271, 268, 'uses', 'Die Pfaddefinition setzt Knoten- und Kantenmenge voraus.'),
(30, 272, 268, 'derived_from', 'Die Netzwerkdichte wird aus der Zahl der Knoten und Kanten berechnet.'),
(31, 273, 270, 'uses', 'Der lokale Clusterkoeffizient verwendet den Knotengrad.'),
(32, 275, 274, 'uses', 'Nichtnegativität und Definitheit konkretisieren die allgemeine Metrikdefinition.'),
(33, 276, 274, 'uses', 'Die Symmetrie ist eines der definierenden Axiome einer Metrik.'),
(34, 277, 274, 'uses', 'Die Dreiecksungleichung ist eines der definierenden Axiome einer Metrik.'),
(35, 278, 274, 'special_case_of', 'Die euklidische Distanz ist eine konkrete Metrik auf dem reellen Vektorraum.'),
(36, 279, 278, 'contrasts', 'Die Kosinusähnlichkeit misst Richtungsähnlichkeit statt absoluten euklidischen Abstand.'),
(37, 281, 280, 'generalizes', 'Die gekoppelte Gesamtdynamik verallgemeinert lokale Aktualisierungsregeln.'),
(38, 282, 281, '', 'Die rekursive Selbstorganisation ist eine diskrete Darstellung gekoppelter Systemdynamik.'),
(39, 283, 282, 'derived_from', 'Der Ordnungsparameter wird aus dem rekursiv entwickelten Gesamtzustand bestimmt.'),
(40, 284, 283, 'uses', 'Die Rückkopplung verwendet den aus dem Zustand abgeleiteten Ordnungsparameter.'),
(41, 285, 282, 'uses', 'Die Attraktordynamik beschreibt das langfristige Verhalten der rekursiven Zustandsfolge.'),
(42, 287, 286, 'uses', 'Die formale Darstellung von A2 verwendet die in Gleichung (3.64) eingeführte funktionale Nichtäquivalenz.'),
(43, 288, 287, 'uses', 'Die formale Darstellung von A3 verwendet die in (3.65) eingeführte funktionale Relationierbarkeit.'),
(44, 289, 286, 'uses', 'Die strukturelle Voraussetzung von A3 umfasst Axiom A1 beziehungsweise Gleichung (3.64).'),
(45, 289, 287, 'uses', 'Die strukturelle Voraussetzung von A3 umfasst Axiom A2 beziehungsweise Gleichung (3.65).'),
(50, 292, 288, 'uses', 'Die formale Darstellung von A4 verwendet die in (3.66) eröffnete rekursive Transformation.'),
(51, 293, 286, 'uses', 'Die strukturelle Voraussetzung von A4 umfasst Axiom A1 beziehungsweise Gleichung (3.64).'),
(52, 293, 287, 'uses', 'Die strukturelle Voraussetzung von A4 umfasst Axiom A2 beziehungsweise Gleichung (3.65).'),
(53, 293, 288, 'uses', 'Die strukturelle Voraussetzung von A4 umfasst Axiom A3 beziehungsweise Gleichung (3.66).'),
(54, 294, 292, 'uses', 'Die formale Darstellung von A5 verwendet die in Gleichung (3.68) eingeführte stabile funktionale Organisation.'),
(55, 295, 286, 'uses', 'Die strukturelle Voraussetzung von A5 umfasst Axiom A1 beziehungsweise Gleichung (3.64).'),
(56, 295, 287, 'uses', 'Die strukturelle Voraussetzung von A5 umfasst Axiom A2 beziehungsweise Gleichung (3.65).'),
(57, 295, 288, 'uses', 'Die strukturelle Voraussetzung von A5 umfasst Axiom A3 beziehungsweise Gleichung (3.66).'),
(58, 295, 292, 'uses', 'Die strukturelle Voraussetzung von A5 umfasst Axiom A4 beziehungsweise Gleichung (3.68).'),
(59, 296, 286, 'uses', 'Die Systemzusammenfassung umfasst Axiom A1 beziehungsweise Gleichung (3.64).'),
(60, 296, 287, 'uses', 'Die Systemzusammenfassung umfasst Axiom A2 beziehungsweise Gleichung (3.65).'),
(61, 296, 288, 'uses', 'Die Systemzusammenfassung umfasst Axiom A3 beziehungsweise Gleichung (3.66).'),
(62, 296, 292, 'uses', 'Die Systemzusammenfassung umfasst Axiom A4 beziehungsweise Gleichung (3.68).'),
(63, 296, 294, 'uses', 'Die Systemzusammenfassung umfasst Axiom A5 beziehungsweise Gleichung (3.70).'),
(64, 297, 286, 'uses', 'Prop. 3.1 verwendet A1 beziehungsweise Gleichung (3.64).'),
(65, 297, 287, 'uses', 'Prop. 3.1 verwendet A2 beziehungsweise Gleichung (3.65).'),
(66, 297, 288, 'uses', 'Prop. 3.1 verwendet A3 beziehungsweise Gleichung (3.66).'),
(67, 297, 292, 'uses', 'Prop. 3.1 verwendet A4 beziehungsweise Gleichung (3.68).'),
(68, 297, 294, 'uses', 'Prop. 3.1 verwendet A5 beziehungsweise Gleichung (3.70).'),
(69, 299, 298, 'uses', 'Die Klasse funktionaler Zustände setzt die Definition des einzelnen funktionalen Zustands aus Gleichung (3.74) voraus.'),
(70, 300, 299, 'uses', 'Die funktionale Relation wird auf der in Gleichung (3.75) definierten Zustandsklasse aufgebaut.'),
(71, 301, 300, 'uses', 'Der Relationsindikator konkretisiert die in Gleichung (3.76) definierte Relation.'),
(72, 302, 300, 'uses', 'Die Relationsstruktur enthält die funktionale Relation aus Gleichung (3.76).'),
(73, 302, 299, 'uses', 'Die Relationsstruktur enthält die Zustandsklasse aus Gleichung (3.75).'),
(74, 303, 299, 'uses', 'Die funktionale Transformation wird auf der in Gleichung (3.75) definierten Zustandsklasse aufgebaut.'),
(75, 303, 302, 'uses', 'Die funktionale Transformation setzt die in Gleichung (3.78) zusammengefasste Relationsstruktur voraus.'),
(76, 304, 303, 'uses', 'Die rekursive Transformation ist die endliche Iteration der in Gleichung (3.79) definierten Transformation.'),
(77, 305, 303, 'derived_from', 'Die Abgeschlossenheitsaussage folgt unmittelbar aus der Abbildung T_F:X->X.'),
(78, 306, 299, 'uses', 'Die Organisationsmenge ist eine Teilmenge der in Gleichung (3.75) definierten Zustandsklasse.'),
(79, 307, 303, 'uses', 'Die Invarianzbedingung verwendet die in Gleichung (3.79) definierte Transformation.'),
(80, 307, 306, 'uses', 'Die Invarianzbedingung wirkt auf die in Gleichung (3.82) eingeführte Organisationsmenge.'),
(81, 308, 306, 'uses', 'Der Organisationsraum enthält die Organisationsmenge.'),
(82, 308, 307, 'uses', 'Der Organisationsraum setzt die Invarianzbedingung voraus.'),
(83, 309, 304, 'uses', 'Die rekursive Abgeschlossenheit verwendet die in Gleichung (3.80) definierte Iteration.'),
(84, 309, 307, 'derived_from', 'Die rekursive Invarianz folgt aus der einfachen Invarianzbedingung.'),
(85, 310, 308, 'uses', 'Die Kohärenzfunktion wird auf dem in Gleichung (3.84) definierten Organisationsraum aufgebaut.'),
(86, 311, 310, 'uses', 'Die Kohärenzerhaltung verwendet die in Gleichung (3.86) definierte Kohärenzfunktion.'),
(87, 312, 311, 'derived_from', 'Die rekursive Kohärenzerhaltung folgt durch Iteration aus Gleichung (3.87).'),
(88, 312, 309, 'uses', 'Die Aussage verwendet die rekursive Transformation aus Gleichung (3.85).'),
(89, 313, 311, 'uses', 'Der Existenzsatz setzt eine kohärenzerhaltende Transformation voraus.'),
(90, 313, 310, 'uses', 'Der Existenzsatz verwendet die Kohärenzfunktion.'),
(91, 314, 308, 'uses', 'Die Kohärenzrelation wird zwischen den in Gleichung (3.84) definierten funktionalen Organisationsräumen aufgebaut.'),
(92, 315, 314, 'uses', 'Die Raum-Zeit-Kohärenzfunktion quantifiziert die in Gleichung (3.90) definierte Kohärenzrelation.'),
(93, 315, 310, 'generalizes', 'Die Raum-Zeit-Kohärenzfunktion erweitert die Kohärenzfunktion aus Gleichung (3.86) auf Paare von Organisationsräumen.'),
(94, 316, 315, 'derived_from', 'Die Symmetrieaussage bezieht sich auf die in Gleichung (3.91) definierte Raum-Zeit-Kohärenzfunktion.'),
(95, 317, 314, 'uses', 'Das FRZK enthält die funktionale Kohärenzrelation.'),
(96, 317, 315, 'uses', 'Das FRZK enthält die Raum-Zeit-Kohärenzfunktion.'),
(97, 317, 308, 'uses', 'Das FRZK enthält funktionale Organisationsräume.'),
(98, 318, 317, 'uses', 'Die Dynamikfunktion wird auf dem in Gleichung (3.93) definierten FRZK-System aufgebaut.'),
(99, 318, 310, 'uses', 'Die Dynamikfunktion verwendet die in Gleichung (3.86) eingeführte Kohärenzfunktion.'),
(100, 319, 308, 'uses', 'Die Entwicklungsbahn besteht aus funktionalen Organisationsräumen nach Gleichung (3.84).'),
(101, 319, 304, 'uses', 'Die Reihenfolge der Entwicklungsbahn wird durch rekursive Transformationen nach Gleichung (3.80) erzeugt.'),
(102, 320, 319, 'uses', 'Die Kohärenzdifferenz wird zwischen aufeinanderfolgenden Elementen der Entwicklungsbahn gebildet.'),
(103, 320, 310, 'uses', 'Die Differenz verwendet die Kohärenzwerte aus Gleichung (3.86).'),
(104, 321, 304, 'uses', 'Der Satz verwendet die rekursive Transformationsfolge aus Gleichung (3.80).'),
(105, 321, 319, 'derived_from', 'Die resultierende Folge wird als Entwicklungsbahn nach Gleichung (3.95) dargestellt.'),
(106, 322, 304, '', 'Die Attraktorbedingung verwendet die rekursive Transformation aus Gleichung (3.80).'),
(107, 322, 308, '', 'Der Attraktor ist ein funktionaler Organisationsraum nach Gleichung (3.84).'),
(108, 323, 322, '', 'Die Attraktorenmenge wird aus der Attraktorbedingung gebildet.'),
(109, 324, 322, '', 'Die Kohärenzerhaltung folgt aus der Wiederkehr desselben Organisationsraums.'),
(110, 324, 310, '', 'Die Aussage verwendet die Kohärenzfunktion aus Gleichung (3.86).'),
(111, 325, 319, '', 'Der Existenzsatz verwendet die funktionale Entwicklungsbahn aus Gleichung (3.95).'),
(112, 325, 323, '', 'Ein wiederkehrender Organisationsraum gehört zur Attraktorenmenge.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `equation_symbols`
--

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

--
-- Daten für Tabelle `equation_symbols`
--

INSERT INTO `equation_symbols` (`equation_symbol_id`, `equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`) VALUES
(1, 3, 'M', 'Menge', 'Endliche Menge der betrachteten Elemente.', NULL, 'Menge', 1),
(2, 3, 'x_i', 'Mengenelement', 'i-tes unterscheidbares Element der Menge M.', NULL, 'x_i\\in M', 2),
(3, 3, 'n', 'Elementanzahl', 'Endliche Anzahl der in der Darstellung aufgeführten Elemente.', NULL, 'n\\in\\mathbb{N}', 3),
(4, 227, 'R', 'Relation', 'Binäre Relation zwischen den Mengen A und B.', NULL, 'R\\subseteq A\\times B', 1),
(5, 227, 'A', 'Ausgangsmenge', 'Erste Grundmenge der Relation.', NULL, 'Menge', 2),
(6, 227, 'B', 'Zielmenge', 'Zweite Grundmenge der Relation.', NULL, 'Menge', 3),
(7, 228, 'R', 'Relation', 'Binäre Relation auf der Menge A.', NULL, 'R\\subseteq A\\times A', 1),
(8, 228, 'A', 'Grundmenge', 'Grundmenge der Relation.', NULL, 'Menge', 2),
(9, 229, 'a', 'erstes Element', 'Erstes Element des geordneten Paares.', NULL, 'a\\in A', 1),
(10, 229, 'b', 'zweites Element', 'Zweites Element des geordneten Paares.', NULL, 'b\\in B', 2),
(11, 229, 'R', 'Relation', 'Relation, der das geordnete Paar angehört.', NULL, 'Relation', 3),
(12, 230, 'R', 'reflexive Relation', 'Relation, in der jedes Element zu sich selbst in Beziehung steht.', NULL, 'R\\subseteq A\\times A', 1),
(13, 230, 'A', 'Grundmenge', 'Grundmenge der reflexiven Relation.', NULL, 'Menge', 2),
(14, 231, 'R', 'symmetrische Relation', 'Relation, deren Beziehungen in beide Richtungen gelten.', NULL, 'R\\subseteq A\\times A', 1),
(15, 231, 'A', 'Grundmenge', 'Grundmenge der symmetrischen Relation.', NULL, 'Menge', 2),
(16, 9, 'R', 'transitive Relation', 'Relation, deren verkettete Beziehungen transitiv abgeschlossen sind.', NULL, 'R\\subseteq A\\times A', 1),
(17, 9, 'A', 'Grundmenge', 'Grundmenge der transitiven Relation.', NULL, 'Menge', 2),
(18, 232, 'f', 'Funktion', 'Eindeutige Abbildung von A nach B.', NULL, 'f:A\\rightarrow B', 1),
(19, 232, 'A', 'Definitionsmenge', 'Menge der zulässigen Ausgangselemente.', NULL, 'Menge', 2),
(20, 232, 'B', 'Zielmenge', 'Menge der möglichen Zielwerte.', NULL, 'Menge', 3),
(21, 233, 'x', 'Ausgangselement', 'Beliebiges Element der Definitionsmenge A.', NULL, 'x\\in A', 1),
(22, 233, 'y', 'Bildelement', 'Eindeutig zugeordnetes Element der Zielmenge B.', NULL, 'y\\in B', 2),
(23, 233, '\\exists!', 'eindeutige Existenz', 'Es existiert genau ein Element mit der angegebenen Eigenschaft.', NULL, 'logischer Quantor', 3),
(24, 234, 'f', 'erste Funktion', 'Zuerst angewandte Funktion von A nach B.', NULL, 'f:A\\rightarrow B', 1),
(25, 234, 'g', 'zweite Funktion', 'Anschließend angewandte Funktion von B nach C.', NULL, 'g:B\\rightarrow C', 2),
(26, 234, '\\circ', 'Komposition', 'Hintereinanderausführung der Funktionen f und g.', NULL, 'Funktionsverknüpfung', 3),
(27, 235, 'x_n', 'aktueller Zustand', 'Zustand im Iterationsschritt n.', NULL, 'Zustandsmenge', 1),
(28, 235, 'x_{n+1}', 'Folgezustand', 'Zustand nach erneuter Anwendung von f.', NULL, 'Zustandsmenge', 2),
(29, 235, 'f', 'Iterationsfunktion', 'Funktion, die den Folgezustand erzeugt.', NULL, 'f:X\\rightarrow X', 3),
(30, 236, '\\circ', 'innere Verknüpfung', 'Binäre Verknüpfung auf der Menge A.', NULL, '\\circ:A\\times A\\rightarrow A', 1),
(31, 236, 'A', 'Trägermenge', 'Menge, auf der die Verknüpfung definiert ist.', NULL, 'Menge', 2),
(32, 237, 'a', 'erstes Element', 'Erstes Element der Verknüpfung.', NULL, 'a\\in A', 1),
(33, 237, 'b', 'zweites Element', 'Zweites Element der Verknüpfung.', NULL, 'b\\in A', 2),
(34, 237, '\\circ', 'Verknüpfung', 'Innere Verknüpfung auf A.', NULL, 'A\\times A\\rightarrow A', 3),
(35, 238, 'a', 'erstes Element', 'Erstes Element der assoziativen Verknüpfung.', NULL, 'a\\in A', 1),
(36, 238, 'b', 'zweites Element', 'Zweites Element der assoziativen Verknüpfung.', NULL, 'b\\in A', 2),
(37, 238, 'c', 'drittes Element', 'Drittes Element der assoziativen Verknüpfung.', NULL, 'c\\in A', 3),
(38, 239, 'e', 'neutrales Element', 'Element, das andere Elemente bei der Verknüpfung unverändert lässt.', NULL, 'e\\in A', 1),
(39, 239, 'a', 'beliebiges Element', 'Beliebiges Element der Trägermenge A.', NULL, 'a\\in A', 2),
(40, 240, 'a^{-1}', 'inverses Element', 'Zu a inverses Element bezüglich der Verknüpfung.', NULL, 'a^{-1}\\in A', 1),
(41, 240, 'a', 'Ausgangselement', 'Element, zu dem das inverse Element gehört.', NULL, 'a\\in A', 2),
(42, 240, 'e', 'neutrales Element', 'Ergebnis der Verknüpfung eines Elements mit seinem Inversen.', NULL, 'e\\in A', 3),
(43, 241, 'T', 'Operator', 'Abbildung zwischen den mathematischen Räumen X und Y.', NULL, 'T:X\\rightarrow Y', 1),
(44, 241, 'X', 'Definitionsraum', 'Raum der zulässigen Eingabeelemente.', NULL, 'mathematischer Raum', 2),
(45, 241, 'Y', 'Zielraum', 'Raum der möglichen Ausgabeelemente.', NULL, 'mathematischer Raum', 3),
(46, 242, 'x', 'Eingabeelement', 'Element aus dem Definitionsbereich des Operators.', NULL, 'x\\in X', 1),
(47, 242, 'y', 'Ausgabeelement', 'Bild von x unter dem Operator T.', NULL, 'y\\in Y', 2),
(48, 242, 'T', 'Operator', 'Transformation des Eingabeelements x.', NULL, 'T:X\\rightarrow Y', 3),
(49, 243, '\\alpha', 'erster Skalar', 'Skalarer Koeffizient der Linearkombination.', NULL, 'Skalarkörper', 1),
(50, 243, '\\beta', 'zweiter Skalar', 'Skalarer Koeffizient der Linearkombination.', NULL, 'Skalarkörper', 2),
(51, 243, 'T', 'linearer Operator', 'Operator, der Linearkombinationen erhält.', NULL, 'linearer Operator', 3),
(52, 244, 'T', 'nichtlinearer Operator', 'Operator, der die Linearitätsbedingung im Allgemeinen nicht erfüllt.', NULL, 'Operator', 1),
(53, 244, '\\neq', 'Ungleichheit', 'Kennzeichnet die Verletzung der Linearitätsbedingung.', NULL, 'Relation', 2),
(54, 245, 'S', 'erster Operator', 'Zuerst angewandter Operator.', NULL, 'S:X\\rightarrow Y', 1),
(55, 245, 'T', 'zweiter Operator', 'Anschließend angewandter Operator.', NULL, 'T:Y\\rightarrow Z', 2),
(56, 245, '\\circ', 'Operatorkomposition', 'Hintereinanderausführung der Operatoren S und T.', NULL, 'Operatorverknüpfung', 3),
(57, 246, 'x_n', 'aktueller Zustand', 'Zustand im Iterationsschritt n.', NULL, 'Zustandsbereich', 1),
(58, 246, 'x_{n+1}', 'Folgezustand', 'Zustand nach erneuter Anwendung von T.', NULL, 'Zustandsbereich', 2),
(59, 246, 'T', 'Iterationsoperator', 'Operator, der die rekursive Folge erzeugt.', NULL, 'T:X\\rightarrow X', 3),
(71, 25, 'X', 'Zustand', 'Ein zulässiger Zustand des betrachteten Systems.', NULL, 'x\\in X', 2),
(72, 26, 'x(t)', 'Zustandsfunktion', 'Vom Entwicklungsparameter t abhängiger Zustand.', NULL, 'x(t)\\in X', 1),
(73, 26, 't', 'Entwicklungsparameter', 'Parameter zur Ordnung der Zustandsdarstellung.', NULL, 'Parameterbereich', 2),
(74, 26, 'X', 'Zustandsraum', 'Menge aller zulässigen Zustände.', NULL, 'Menge', 3),
(75, 27, '\\dot{x}', 'Zustandsänderung', 'Ableitung des Zustands nach dem Entwicklungsparameter.', NULL, 'Tangentialraum bzw. Änderungsraum', 1),
(76, 27, 'F', 'Entwicklungsoperator', 'Operator oder Vektorfeld, das die kontinuierliche Zustandsänderung bestimmt.', NULL, 'F:X\\rightarrow TX', 2),
(77, 27, 'x', 'aktueller Zustand', 'Aktueller Zustand des Systems.', NULL, 'x\\in X', 3),
(78, 28, 'x_k', 'aktueller Zustand', 'Zustand im diskreten Entwicklungsschritt k.', NULL, 'x_k\\in X', 1),
(79, 28, 'x_{k+1}', 'Folgezustand', 'Zustand im nachfolgenden Entwicklungsschritt.', NULL, 'x_{k+1}\\in X', 2),
(80, 28, 'F', 'diskrete Transformationsregel', 'Abbildung zur Erzeugung des Folgezustands.', NULL, 'F:X\\rightarrow X', 3),
(82, 251, '\\mathcal{F}(\\Omega,V)', 'Funktionenraum', 'Gesamtheit der Funktionen von Omega nach V.', NULL, 'Funktionenmenge', 1),
(83, 251, '\\Omega', 'Grundmenge', 'Definitionsbereich der Funktionen.', NULL, 'Menge', 2),
(84, 251, 'V', 'Wertebereich', 'Vektorraum der Funktionswerte.', NULL, 'Vektorraum', 3),
(85, 252, 'f', 'erste Funktion', 'Erste Funktion der punktweisen Addition.', NULL, 'f\\in\\mathcal{F}(\\Omega,V)', 1),
(86, 252, 'g', 'zweite Funktion', 'Zweite Funktion der punktweisen Addition.', NULL, 'g\\in\\mathcal{F}(\\Omega,V)', 2),
(87, 252, 'x', 'Argument', 'Element der Grundmenge Omega.', NULL, 'x\\in\\Omega', 3),
(88, 253, '\\alpha', 'Skalar', 'Skalarer Multiplikator.', NULL, 'Skalarkörper', 1),
(89, 253, 'f', 'Funktion', 'Mit dem Skalar multiplizierte Funktion.', NULL, 'f\\in\\mathcal{F}(\\Omega,V)', 2),
(90, 254, '\\|f\\|', 'Norm von f', 'Nichtnegative Größe des Elements f.', NULL, '\\mathbb{R}_{\\ge0}', 1),
(91, 254, '\\alpha', 'Skalar', 'Skalar zur Prüfung der absoluten Homogenität.', NULL, 'Skalarkörper', 2),
(92, 254, 'g', 'zweites Element', 'Zweites Element für die Dreiecksungleichung.', NULL, 'Vektorraum', 3),
(93, 255, '\\varepsilon', 'Toleranz', 'Beliebige positive Schranke für den Abstand der Folgenglieder.', NULL, '\\mathbb{R}_{>0}', 1),
(94, 255, 'N', 'Schwellenindex', 'Index, ab dem alle betrachteten Folgenglieder näher als epsilon liegen.', NULL, '\\mathbb{N}', 2),
(95, 255, 'f_n', 'Folgenglied', 'n-tes Element der betrachteten Folge.', NULL, 'normierter Raum', 3),
(96, 256, '\\langle f,f\\rangle', 'Selbstskalarprodukt', 'Skalarprodukt des Elements f mit sich selbst.', NULL, 'Skalarkörper', 1),
(97, 256, '\\|f\\|', 'induzierte Norm', 'Durch das Skalarprodukt erzeugte Norm.', NULL, '\\mathbb{R}_{\\ge0}', 2),
(98, 257, 'x(t)', 'Zustandstrajektorie', 'Vom Entwicklungsparameter abhängiger Zustand.', NULL, 'x(t)\\in X', 1),
(99, 257, '\\dot{x}(t)', 'Zustandsänderung', 'Ableitung der Zustandstrajektorie nach dem Entwicklungsparameter.', NULL, 'Tangentialraum', 2),
(100, 257, 'F', 'Vektorfeld', 'Regel der kontinuierlichen Zustandsentwicklung.', NULL, 'F:X\\rightarrow TX', 3),
(101, 258, 'x_n', 'aktueller Zustand', 'Zustand im diskreten Entwicklungsschritt n.', NULL, 'x_n\\in X', 1),
(102, 258, 'x_{n+1}', 'Folgezustand', 'Zustand im nachfolgenden Entwicklungsschritt.', NULL, 'x_{n+1}\\in X', 2),
(103, 258, 'F', 'diskrete Dynamik', 'Abbildung zur Erzeugung des Folgezustands.', NULL, 'F:X\\rightarrow X', 3),
(104, 259, 'x^{\\ast}', 'Fixpunkt', 'Zustand, der unter der Abbildung F unverändert bleibt.', NULL, 'x^{\\ast}\\in X', 1),
(105, 259, 'F', 'Dynamik', 'Abbildung des dynamischen Systems.', NULL, 'F:X\\rightarrow X', 2),
(106, 260, 'J_F(x)', 'Jacobi-Matrix', 'Matrix der ersten partiellen Ableitungen von F am Punkt x.', NULL, 'Matrix', 1),
(107, 260, 'F_i', 'Komponente des Vektorfeldes', 'i-te Komponente der Abbildung F.', NULL, 'Komponentenfunktion', 2),
(108, 260, 'x_j', 'Zustandskomponente', 'j-te Koordinate des Zustandes x.', NULL, 'Koordinate', 3),
(109, 261, 'A', 'Attraktor', 'Invariante Menge, der sich Trajektorien aus ihrem Einzugsgebiet annähern.', NULL, 'A\\subseteq X', 1),
(110, 261, 'F^{n}', 'n-fache Iteration', 'n-malige Anwendung der Dynamik F.', NULL, 'Iteration', 2),
(111, 261, '\\operatorname{dist}', 'Abstand', 'Abstand eines Zustandes von der Menge A.', NULL, '\\mathbb{R}_{\\ge0}', 3),
(112, 262, '\\delta x(t)', 'Trajektoriendifferenz', 'Lokale Differenz zweier benachbarter Trajektorien zum Parameterwert t.', NULL, 'Tangentialraum', 1),
(113, 262, '\\lambda', 'Lyapunov-Exponent', 'Mittlere exponentielle Wachstums- oder Zerfallsrate lokaler Störungen.', NULL, '\\mathbb{R}', 2),
(114, 262, 't', 'Entwicklungsparameter', 'Parameter der kontinuierlichen Entwicklung.', NULL, 'Parameterbereich', 3),
(115, 263, 'I(x)', 'Informationsgehalt', 'Informationswert des Ereignisses x.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(116, 263, 'p(x)', 'Ereigniswahrscheinlichkeit', 'Wahrscheinlichkeit des Ereignisses x.', NULL, '(0,1]', 2),
(117, 264, 'H(X)', 'Shannon-Entropie', 'Mittlere Unsicherheit der Zufallsvariablen X.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(118, 264, 'p_i', 'Ereigniswahrscheinlichkeit', 'Wahrscheinlichkeit des i-ten möglichen Ereignisses.', NULL, '[0,1]', 2),
(119, 265, 'H(X,Y)', 'gemeinsame Entropie', 'Gemeinsame Unsicherheit der Zufallsvariablen X und Y.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(120, 265, 'p(x_i,y_j)', 'gemeinsame Wahrscheinlichkeit', 'Gemeinsame Wahrscheinlichkeit der Ereignisse x_i und y_j.', NULL, '[0,1]', 2),
(121, 266, 'I(X;Y)', 'gegenseitige Information', 'Gemeinsam getragene Information der Zufallsvariablen X und Y.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(122, 266, 'H(X)', 'Entropie von X', 'Mittlere Unsicherheit der Zufallsvariablen X.', 'bit', '\\mathbb{R}_{\\ge0}', 2),
(123, 266, 'H(Y)', 'Entropie von Y', 'Mittlere Unsicherheit der Zufallsvariablen Y.', 'bit', '\\mathbb{R}_{\\ge0}', 3),
(124, 266, 'H(X,Y)', 'gemeinsame Entropie', 'Gemeinsame Unsicherheit von X und Y.', 'bit', '\\mathbb{R}_{\\ge0}', 4),
(125, 267, 'D_{KL}(P\\parallel Q)', 'Kullback-Leibler-Divergenz', 'Divergenz der Verteilung P relativ zur Verteilung Q.', 'bit', '\\mathbb{R}_{\\ge0}', 1),
(126, 267, 'P(i)', 'Zielverteilung', 'Wahrscheinlichkeit des i-ten Ereignisses unter P.', NULL, '[0,1]', 2),
(127, 267, 'Q(i)', 'Referenzverteilung', 'Wahrscheinlichkeit des i-ten Ereignisses unter Q.', NULL, '(0,1]', 3),
(128, 268, 'G', 'Graph', 'Geordnetes Paar aus Knotenmenge und Kantenmenge.', NULL, 'Graph', 1),
(129, 268, 'V', 'Knotenmenge', 'Menge aller Knoten des Graphen.', NULL, 'Menge', 2),
(130, 268, 'E', 'Kantenmenge', 'Menge aller Kanten des Graphen.', NULL, 'Menge', 3),
(131, 269, 'A_{ij}', 'Adjazenzeintrag', 'Eintrag der Adjazenzmatrix für die Knoten v_i und v_j.', NULL, '\\{0,1\\}', 1),
(132, 269, 'v_i', 'erster Knoten', 'i-ter Knoten des Graphen.', NULL, 'v_i\\in V', 2),
(133, 269, 'v_j', 'zweiter Knoten', 'j-ter Knoten des Graphen.', NULL, 'v_j\\in V', 3),
(134, 270, 'k_i', 'Knotengrad', 'Anzahl der an v_i angrenzenden Knoten.', NULL, '\\mathbb{N}_0', 1),
(135, 270, 'A_{ij}', 'Adjazenzeintrag', 'Binärer Eintrag für die Verbindung zwischen v_i und v_j.', NULL, '\\{0,1\\}', 2),
(136, 270, 'n', 'Knotenzahl', 'Anzahl aller Knoten des Graphen.', NULL, '\\mathbb{N}', 3),
(137, 271, 'P', 'Pfad', 'Geordnete Folge paarweise benachbarter Knoten.', NULL, 'Knotenfolge', 1),
(138, 271, 'v_r', 'Pfadknoten', 'r-ter Knoten des Pfades.', NULL, 'v_r\\in V', 2),
(139, 271, 'm', 'Pfadlänge', 'Anzahl der Kanten des Pfades.', NULL, '\\mathbb{N}_0', 3),
(140, 272, '\\rho', 'Netzwerkdichte', 'Anteil der vorhandenen an den maximal möglichen Kanten.', NULL, '[0,1]', 1),
(141, 272, '|E|', 'Kantenzahl', 'Anzahl der Kanten des Graphen.', NULL, '\\mathbb{N}_0', 2),
(142, 272, '|V|', 'Knotenzahl', 'Anzahl der Knoten des Graphen.', NULL, '\\mathbb{N}', 3),
(143, 273, 'C_i', 'lokaler Clusterkoeffizient', 'Anteil realisierter Nachbarschaftsverbindungen am Knoten v_i.', NULL, '[0,1]', 1),
(144, 273, 'e_i', 'Nachbarschaftskanten', 'Zahl der Kanten zwischen den Nachbarn von v_i.', NULL, '\\mathbb{N}_0', 2),
(145, 273, 'k_i', 'Knotengrad', 'Anzahl der Nachbarn des Knotens v_i.', NULL, '\\mathbb{N}', 3),
(146, 274, 'd', 'Metrik', 'Distanzfunktion auf dem Raum X.', NULL, 'd:X\\times X\\rightarrow\\mathbb{R}_{\\ge0}', 1),
(147, 274, 'X', 'Grundmenge', 'Menge der Elemente, zwischen denen Distanzen bestimmt werden.', NULL, 'Menge', 2),
(148, 275, 'x', 'erstes Element', 'Erstes Element der Distanzbestimmung.', NULL, 'x\\in X', 1),
(149, 275, 'y', 'zweites Element', 'Zweites Element der Distanzbestimmung.', NULL, 'y\\in X', 2),
(150, 275, 'd(x,y)', 'Distanz', 'Nichtnegative Distanz zwischen x und y.', NULL, '\\mathbb{R}_{\\ge0}', 3),
(151, 276, 'd(x,y)', 'Distanz von x nach y', 'Distanz des geordneten Paares x und y.', NULL, '\\mathbb{R}_{\\ge0}', 1),
(152, 276, 'd(y,x)', 'Distanz von y nach x', 'Umgekehrte Reihenfolge derselben Distanzbestimmung.', NULL, '\\mathbb{R}_{\\ge0}', 2),
(153, 277, 'z', 'Zwischenelement', 'Drittes Element zur Formulierung der Dreiecksungleichung.', NULL, 'z\\in X', 1),
(154, 277, 'd(x,z)', 'direkte Distanz', 'Direkter Abstand zwischen x und z.', NULL, '\\mathbb{R}_{\\ge0}', 2),
(155, 277, 'd(x,y)+d(y,z)', 'indirekte Distanz', 'Summe der Distanzen über das Zwischenelement y.', NULL, '\\mathbb{R}_{\\ge0}', 3),
(156, 278, 'd_E(x,y)', 'euklidische Distanz', 'Euklidischer Abstand zwischen den Vektoren x und y.', NULL, '\\mathbb{R}_{\\ge0}', 1),
(157, 278, 'x_i', 'i-te Komponente von x', 'i-te Koordinate des Vektors x.', NULL, '\\mathbb{R}', 2),
(158, 278, 'y_i', 'i-te Komponente von y', 'i-te Koordinate des Vektors y.', NULL, '\\mathbb{R}', 3),
(159, 278, 'n', 'Dimension', 'Anzahl der Komponenten der betrachteten Vektoren.', NULL, '\\mathbb{N}', 4),
(160, 279, '\\operatorname{cos}(x,y)', 'Kosinusähnlichkeit', 'Normiertes Skalarprodukt der Vektoren x und y.', NULL, '[-1,1]', 1),
(161, 279, 'x^{\\top}y', 'Skalarprodukt', 'Inneres Produkt der Vektoren x und y.', NULL, '\\mathbb{R}', 2),
(162, 279, '\\|x\\|', 'Norm von x', 'Euklidische Norm des Vektors x.', NULL, '\\mathbb{R}_{>0}', 3),
(163, 279, '\\|y\\|', 'Norm von y', 'Euklidische Norm des Vektors y.', NULL, '\\mathbb{R}_{>0}', 4),
(164, 280, 'x_i^{(n)}', 'lokaler Zustand', 'Zustand der i-ten Einheit im Entwicklungsschritt n.', NULL, 'lokaler Zustandsraum', 1),
(165, 280, 'F_i', 'lokale Aktualisierungsregel', 'Regel zur Aktualisierung der i-ten Einheit.', NULL, 'Abbildung', 2),
(166, 280, '\\mathcal{N}_i^{(n)}', 'funktionale Nachbarschaft', 'Für die Aktualisierung relevante Umgebung der i-ten Einheit.', NULL, 'Nachbarschaftsstruktur', 3),
(167, 281, 'X', 'Gesamtzustand', 'Gesamtzustand des gekoppelten Systems.', NULL, 'Zustandsraum', 1),
(168, 281, 'F(X)', 'intrinsische Dynamik', 'Systeminterne Entwicklung ohne zusätzlichen Kopplungsterm.', NULL, 'Änderungsraum', 2),
(169, 281, 'C(X)', 'Kopplungsterm', 'Beitrag der Wechselwirkungen zwischen Systembestandteilen.', NULL, 'Änderungsraum', 3),
(170, 282, 'X_n', 'aktueller Gesamtzustand', 'Gesamtzustand im Entwicklungsschritt n.', NULL, 'Zustandsraum', 1),
(171, 282, 'X_n^{\\mathrm{Umgebung}}', 'Umgebungszustand', 'Für die weitere Entwicklung relevante Umgebung des Systems.', NULL, 'Umgebungsraum', 2),
(172, 282, 'F', 'System-Umwelt-Transformation', 'Abbildung zur Erzeugung des Folgezustands.', NULL, 'Abbildung', 3),
(173, 283, '\\eta', 'Ordnungsparameter', 'Makroskopische Größe zur Beschreibung globaler Organisation.', NULL, 'Ordnungsparameterraum', 1),
(174, 283, '\\Phi', 'Reduktionsabbildung', 'Abbildung des Gesamtzustands auf den Ordnungsparameter.', NULL, 'Abbildung', 2),
(175, 283, 'X', 'mikroskopischer Gesamtzustand', 'Gesamtheit der mikroskopischen Freiheitsgrade.', NULL, 'Zustandsraum', 3),
(176, 284, '\\eta_n', 'aktueller Ordnungsparameter', 'Makroskopischer Ordnungsparameter im Entwicklungsschritt n.', NULL, 'Ordnungsparameterraum', 1),
(177, 284, 'X_{n+1}', 'Folgezustand', 'Durch Zustand und Ordnungsparameter beeinflusster Folgezustand.', NULL, 'Zustandsraum', 2),
(178, 284, '\\Phi', 'Makroabbildung', 'Abbildung des Mikrozustands auf die makroskopische Ordnung.', NULL, 'Abbildung', 3),
(179, 285, 'A', 'Organisationsattraktor', 'Stabile oder metastabile Menge organisierter Zustände.', NULL, 'A\\subseteq X', 1),
(180, 285, '\\operatorname{dist}', 'Abstand', 'Abstand des Gesamtzustands von der Organisationsmenge A.', NULL, '\\mathbb{R}_{\\ge0}', 2),
(181, 285, 'X_n', 'Systemzustand', 'Gesamtzustand im Entwicklungsschritt n.', NULL, 'Zustandsraum', 3),
(182, 286, 'a', 'erste funktionale Konfiguration', 'Formaler Platzhalter für eine funktionale Konfiguration; noch kein Element einer vorausgesetzten Menge.', NULL, 'prämathematischer Platzhalter', 1),
(183, 286, 'b', 'zweite funktionale Konfiguration', 'Formaler Platzhalter für eine funktionale Konfiguration; noch kein Element einer vorausgesetzten Menge.', NULL, 'prämathematischer Platzhalter', 2),
(184, 286, '\\equiv_F', 'funktionale Äquivalenz', 'Qualitative Gleichwertigkeit hinsichtlich funktionaler Wirksamkeit; die mathematische Äquivalenzrelation wird erst in Kapitel 3.4 konstruiert.', NULL, 'prämathematisches Vergleichssymbol', 3),
(185, 286, '\\not\\equiv_F', 'funktionale Nichtäquivalenz', 'Ausdruck der prinzipiellen funktionalen Unterscheidbarkeit.', NULL, 'prämathematisches Vergleichssymbol', 4),
(186, 287, 'a', 'erste funktionale Konfiguration', 'Erster prämathematischer Platzhalter für eine funktional unterscheidbare Konfiguration.', NULL, 'prämathematischer Platzhalter', 1),
(187, 287, 'b', 'zweite funktionale Konfiguration', 'Zweiter prämathematischer Platzhalter für eine funktional unterscheidbare Konfiguration.', NULL, 'prämathematischer Platzhalter', 2),
(188, 287, '\\not\\equiv_F', 'funktionale Nichtäquivalenz', 'Aus Axiom A1 übernommener Ausdruck funktionaler Unterscheidbarkeit.', NULL, 'prämathematisches Vergleichssymbol', 3),
(189, 287, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet, dass funktionale Relationierung möglich, aber noch nicht notwendig realisiert ist.', NULL, 'modal-logischer Operator', 4),
(190, 287, '\\mathcal{R}_F', 'funktionale Relationierbarkeit', 'Qualitative Möglichkeit einer funktionalen Bezugnahme; noch keine mengentheoretisch definierte Relation.', NULL, 'prämathematisches Relationssymbol', 5),
(191, 288, 'a', 'erste funktionale Konfiguration', 'Erster prämathematischer Platzhalter einer funktionalen Relation.', NULL, 'prämathematischer Platzhalter', 1),
(192, 288, 'b', 'zweite funktionale Konfiguration', 'Zweiter prämathematischer Platzhalter einer funktionalen Relation.', NULL, 'prämathematischer Platzhalter', 2),
(193, 288, '\\mathcal{R}_F', 'funktionaler Zusammenhang', 'Qualitative funktionale Relationierbarkeit, noch keine mengentheoretische Relation.', NULL, 'prämathematisches Relationssymbol', 3),
(194, 288, 'c', 'neu hervorgebrachte funktionale Konfiguration', 'Durch funktionale Wechselwirkung potenziell entstehende neue Konfiguration.', NULL, 'prämathematischer Platzhalter', 4),
(195, 288, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet die Möglichkeit rekursiver Hervorbringung.', NULL, 'modal-logischer Operator', 5),
(196, 288, '(\\cdot)', 'offene Bezugsmöglichkeit', 'Nicht näher bestimmter zukünftiger funktionaler Bezugspunkt.', NULL, 'prämathematischer Platzhalter', 6),
(197, 289, 'A1', 'Axiom der funktionalen Unterscheidbarkeit', 'Erste strukturelle Voraussetzung für A3.', NULL, 'Axiom', 1),
(198, 289, 'A2', 'Axiom der funktionalen Relationierbarkeit', 'Zweite strukturelle Voraussetzung für A3.', NULL, 'Axiom', 2),
(199, 289, 'A3', 'Axiom der rekursiven Transformation', 'Axiom, dessen strukturelle Voraussetzungen dargestellt werden.', NULL, 'Axiom', 3),
(207, 292, '\\mathcal{T}_F', 'rekursive funktionale Transformation', 'Qualitative Möglichkeit fortgesetzter funktionaler Transformation gemäß Axiom A3.', NULL, 'prämathematisches Transformationssymbol', 1),
(208, 292, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet, dass stabile Organisation möglich, aber nicht notwendig realisiert ist.', NULL, 'modal-logischer Operator', 2),
(209, 292, '\\mathcal{O}_F', 'stabile funktionale Organisation', 'Qualitative funktionale Organisationsform, die trotz weiterer Transformation in relevanten Eigenschaften erhalten bleiben kann.', NULL, 'prämathematisches Organisationssymbol', 3),
(210, 293, 'A1', 'Axiom der funktionalen Unterscheidbarkeit', 'Erste strukturelle Voraussetzung für A4.', NULL, 'Axiom', 1),
(211, 293, 'A2', 'Axiom der funktionalen Relationierbarkeit', 'Zweite strukturelle Voraussetzung für A4.', NULL, 'Axiom', 2),
(212, 293, 'A3', 'Axiom der rekursiven Transformation', 'Dritte strukturelle Voraussetzung für A4.', NULL, 'Axiom', 3),
(213, 293, 'A4', 'Axiom stabiler funktionaler Organisation', 'Axiom, dessen strukturelle Voraussetzungen dargestellt werden.', NULL, 'Axiom', 4),
(214, 294, '\\mathcal{O}_F', 'stabile funktionale Organisation', 'Qualitative, über Transformationen hinweg hinreichend erhaltene funktionale Organisationsform gemäß Axiom A4.', NULL, 'prämathematisches Organisationssymbol', 1),
(215, 294, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet, dass reproduzierbare Muster möglich, aber nicht notwendig realisiert sind.', NULL, 'modal-logischer Operator', 2),
(216, 294, '\\mathcal{P}_F', 'reproduzierbares Organisationsmuster', 'Funktional vergleichbare Organisationsform, die unter vergleichbaren Bedingungen erneut hervorgebracht werden kann.', NULL, 'prämathematisches Mustersymbol', 3),
(217, 295, 'A1', 'Axiom der funktionalen Unterscheidbarkeit', 'Erste strukturelle Voraussetzung für A5.', NULL, 'Axiom', 1),
(218, 295, 'A2', 'Axiom der funktionalen Relationierbarkeit', 'Zweite strukturelle Voraussetzung für A5.', NULL, 'Axiom', 2),
(219, 295, 'A3', 'Axiom der rekursiven Transformation', 'Dritte strukturelle Voraussetzung für A5.', NULL, 'Axiom', 3),
(220, 295, 'A4', 'Axiom stabiler funktionaler Organisation', 'Vierte strukturelle Voraussetzung für A5.', NULL, 'Axiom', 4),
(221, 295, 'A5', 'Axiom reproduzierbarer Organisationsmuster', 'Axiom, dessen strukturelle Voraussetzungen dargestellt werden.', NULL, 'Axiom', 5),
(222, 296, 'A1', 'Axiom der funktionalen Unterscheidbarkeit', 'Erstes gleichrangig angenommenes Grundaxiom des FRZK.', NULL, 'Axiom', 1),
(223, 296, 'A2', 'Axiom der funktionalen Relationierbarkeit', 'Zweites gleichrangig angenommenes Grundaxiom des FRZK.', NULL, 'Axiom', 2),
(224, 296, 'A3', 'Axiom der rekursiven Transformation', 'Drittes gleichrangig angenommenes Grundaxiom des FRZK.', NULL, 'Axiom', 3),
(225, 296, 'A4', 'Axiom stabiler funktionaler Organisation', 'Viertes gleichrangig angenommenes Grundaxiom des FRZK.', NULL, 'Axiom', 4),
(226, 296, 'A5', 'Axiom reproduzierbarer Organisationsmuster', 'Fünftes gleichrangig angenommenes Grundaxiom des FRZK.', NULL, 'Axiom', 5),
(227, 296, '\\land', 'logische Konjunktion', 'Kennzeichnet, dass A1 bis A5 gemeinsam angenommen werden.', NULL, 'logischer Operator', 6),
(228, 296, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet, dass das Axiomensystem die Möglichkeit einer funktionalen Entwicklungsstruktur eröffnet.', NULL, 'modal-logischer Operator', 7),
(229, 296, '\\mathcal{E}_F', 'funktionale Entwicklungsstruktur', 'Noch nicht mathematisch konstruierte Gesamtstruktur aus Unterscheidbarkeit, Relationierbarkeit, Transformation, Organisation und Reproduzierbarkeit.', NULL, 'prämathematisches Struktursymbol', 8),
(230, 297, 'A1', 'Axiom A1', 'Prinzip der funktionalen Unterscheidbarkeit.', NULL, 'Axiom', 1),
(231, 297, 'A2', 'Axiom A2', 'Prinzip der funktionalen Relationierbarkeit.', NULL, 'Axiom', 2),
(232, 297, 'A3', 'Axiom A3', 'Prinzip der rekursiven Transformation.', NULL, 'Axiom', 3),
(233, 297, 'A4', 'Axiom A4', 'Prinzip stabiler funktionaler Organisation.', NULL, 'Axiom', 4),
(234, 297, 'A5', 'Axiom A5', 'Prinzip reproduzierbarer Organisationsmuster.', NULL, 'Axiom', 5),
(235, 297, '\\Diamond', 'Möglichkeitsoperator', 'Kennzeichnet die grundsätzliche Möglichkeit eines funktionalen Entwicklungsprozesses.', NULL, 'modal-logischer Operator', 6),
(236, 297, '\\mathcal{D}_F', 'funktionaler Entwicklungsprozess', 'Qualitative, noch nicht mathematisch konstruierte funktionale Entwicklung.', NULL, 'prämathematisches Prozesssymbol', 7),
(237, 298, 'x', 'funktionaler Zustand', 'Mathematische Repräsentation einer stabilen funktionalen Organisation.', NULL, 'funktionale Zustandsrepräsentation', 1),
(238, 298, ':=', 'Definitionszeichen', 'Kennzeichnet die definitorische Festlegung des funktionalen Zustands.', NULL, 'logisch-mathematischer Operator', 2),
(239, 298, '\\mathcal{O}_F', 'stabile funktionale Organisation', 'Nach Axiom A4 mögliche funktionale Organisationsform, deren relevante Struktur trotz weiterer Transformation erhalten bleibt.', NULL, 'funktionale Organisationsstruktur', 3),
(240, 299, 'X', 'Klasse funktionaler Zustände', 'Gesamtheit der im betrachteten Modell mathematisch repräsentierten funktionalen Zustände.', NULL, 'Zustandsklasse', 1),
(241, 299, 'x_i', 'i-ter funktionaler Zustand', 'Ein nach Def. 3.4.1 definierter funktionaler Zustand.', NULL, 'x_i\\in X', 2),
(242, 299, 'n', 'Anzahl betrachteter Zustände', 'Endliche Anzahl der im dargestellten Modell berücksichtigten funktionalen Zustände.', NULL, '\\mathbb{N}', 3),
(243, 300, '\\mathcal{R}_F', 'funktionale Relation', 'Menge funktional relevanter geordneter Zustandspaare.', NULL, 'Teilmenge von X\\times X', 1),
(244, 300, 'X', 'Klasse funktionaler Zustände', 'In Abschnitt 3.4.1 definierte Zustandsklasse.', NULL, 'Menge beziehungsweise Zustandsklasse', 2),
(245, 301, 'x_i', 'erster funktionaler Zustand', 'Erstes Argument der funktionalen Relation.', NULL, 'x_i\\in X', 1),
(246, 301, 'x_j', 'zweiter funktionaler Zustand', 'Zweites Argument der funktionalen Relation.', NULL, 'x_j\\in X', 2),
(247, 301, '\\rho_F', 'Relationsindikator', 'Binäre Funktion zur Kennzeichnung einer funktionalen Relation.', NULL, 'X\\times X\\rightarrow\\{0,1\\}', 3),
(248, 302, '\\mathfrak{G}_F', 'funktionale Relationsstruktur', 'Geordnetes Paar aus Zustandsklasse und funktionaler Relation.', NULL, 'strukturtragendes Paar', 1),
(249, 302, 'X', 'Klasse funktionaler Zustände', 'Trägermenge der Relationsstruktur.', NULL, 'Zustandsklasse', 2),
(250, 302, '\\mathcal{R}_F', 'funktionale Relation', 'Relationsmenge der Struktur.', NULL, 'Relation auf X', 3),
(251, 303, '\\mathcal{T}_F', 'funktionale Transformation', 'Wohldefinierte Abbildung eines funktionalen Zustands auf einen funktionalen Folgezustand.', NULL, 'X\\rightarrow X', 1),
(252, 303, 'X', 'Klasse funktionaler Zustände', 'In Abschnitt 3.4.1 definierte Klasse funktionaler Zustände.', NULL, 'Zustandsklasse', 2),
(253, 304, '\\mathcal{T}_F^{\\,n}', 'n-fache funktionale Transformation', 'n-fache Komposition der funktionalen Transformation mit sich selbst.', NULL, 'X\\rightarrow X', 1),
(254, 304, 'n', 'Iterationszahl', 'Anzahl der endlichen Anwendungen der funktionalen Transformation.', NULL, '\\mathbb{N}', 2),
(255, 304, 'X', 'Klasse funktionaler Zustände', 'Definitions- und Zielklasse der rekursiven Transformation.', NULL, 'Zustandsklasse', 3),
(256, 305, 'x', 'Klasse funktionaler Zustände', 'Abgeschlossene Zustandsklasse der funktionalen Transformation.', NULL, 'Zustandsklasse', 3),
(257, 305, '\\mathcal{T}_F(x)', 'transformierter Zustand', 'Durch die funktionale Transformation erzeugter Folgezustand.', NULL, 'Element von X', 2),
(259, 306, '\\mathcal{O}_F', 'funktionale Organisationsmenge', 'Nichtleere Teilmenge funktionaler Zustände, die unter T_F invariant sein kann.', NULL, '\\mathcal{O}_F\\subseteq X', 1),
(260, 306, 'X', 'Klasse funktionaler Zustände', 'In Abschnitt 3.4.1 definierte Zustandsklasse.', NULL, 'Zustandsklasse', 2),
(261, 307, '\\mathcal{T}_F', 'funktionale Transformation', 'Auf der Zustandsklasse wirkende funktionale Transformation.', NULL, 'X\\rightarrow X', 1),
(262, 307, '\\mathcal{O}_F', 'invariante Organisationsmenge', 'Unter T_F als Ganzes erhaltene Teilmenge der Zustandsklasse.', NULL, '\\mathcal{O}_F\\subseteq X', 2),
(263, 308, '\\mathfrak{O}_F', 'funktionaler Organisationsraum', 'Geordnetes Paar aus Organisationsmenge und organisationserzeugender Transformation.', NULL, 'Organisationsstruktur', 1),
(264, 308, '\\mathcal{O}_F', 'funktionale Organisationsmenge', 'Trägermenge des Organisationsraums.', NULL, 'Teilmenge von X', 2),
(265, 308, '\\mathcal{T}_F', 'organisationserzeugende Transformation', 'Transformation, unter der O_F invariant ist.', NULL, 'Abbildung', 3),
(266, 309, 'n', 'Iterationszahl', 'Anzahl der endlichen Anwendungen von T_F.', NULL, '\\mathbb{N}', 1),
(267, 309, '\\mathcal{T}_F^{\\,n}', 'n-fache Transformation', 'n-fache Komposition der funktionalen Transformation.', NULL, 'X\\rightarrow X', 2),
(268, 309, '\\mathcal{O}_F', 'rekursiv invariante Organisationsmenge', 'Unter jeder endlichen Iteration von T_F erhaltene Organisationsmenge.', NULL, 'Teilmenge von X', 3),
(269, 310, '\\kappa', 'Kohärenzfunktion', 'Normiertes Maß der funktionalen Geschlossenheit eines Organisationsraums.', NULL, '\\mathfrak{O}_F\\rightarrow[0,1]', 1),
(270, 310, '\\mathfrak{O}_F', 'funktionaler Organisationsraum', 'In Def. 3.4.8 definierter Organisationsraum.', NULL, 'Organisationsraum', 2),
(271, 311, '\\mathcal{T}_F', 'kohärenzerhaltende Transformation', 'Transformation, die den Kohärenzwert invariant lässt.', NULL, 'Abbildung', 1),
(272, 311, '\\kappa(\\mathfrak{O}_F)', 'Kohärenzwert', 'Kohärenzwert des funktionalen Organisationsraums.', NULL, '[0,1]', 2),
(273, 312, 'n', 'Iterationszahl', 'Anzahl endlicher Anwendungen der Transformation.', NULL, '\\mathbb{N}', 1),
(274, 312, '\\mathcal{T}_F^{\\,n}', 'n-fache Transformation', 'n-fache Komposition der kohärenzerhaltenden Transformation.', NULL, 'Abbildung', 2),
(275, 313, '\\exists', 'Existenzquantor', 'Kennzeichnet die Existenz einer kohärenzerhaltenden Transformation beziehungsweise eines Kohärenzwerts.', NULL, 'Logik', 1),
(276, 313, '\\kappa(\\mathfrak{O}_F)', 'wohldefinierter Kohärenzwert', 'Dem Organisationsraum eindeutig zugeordneter Kohärenzwert.', NULL, '[0,1]', 2),
(277, 314, '\\mathcal{K}', 'Raum-Zeit-Kohärenzrelation', 'Relation funktionaler Kopplung zwischen Organisationsräumen.', NULL, 'Teilmenge von \\mathfrak{O}_F\\times\\mathfrak{O}_F', 1),
(278, 314, '\\mathfrak{O}_F', 'funktionaler Organisationsraum', 'In Definition 3.4.8 konstruierter Organisationsraum.', NULL, 'Organisationsraum', 2),
(279, 315, '\\chi', 'Raum-Zeit-Kohärenzfunktion', 'Normierte Funktion zur Quantifizierung der Kopplung zweier Organisationsräume.', NULL, '\\mathfrak{O}_F\\times\\mathfrak{O}_F\\rightarrow[0,1]', 1),
(280, 315, '[0,1]', 'normierter Wertebereich', 'Wertebereich von vollständiger Entkopplung bis maximaler funktionaler Kopplung.', NULL, 'reelles Intervall', 2),
(281, 316, '\\mathfrak{O}_1', 'erster Organisationsraum', 'Erster funktionaler Organisationsraum der Kohärenzbewertung.', NULL, 'funktionaler Organisationsraum', 1),
(282, 316, '\\mathfrak{O}_2', 'zweiter Organisationsraum', 'Zweiter funktionaler Organisationsraum der Kohärenzbewertung.', NULL, 'funktionaler Organisationsraum', 2),
(283, 316, '\\chi', 'symmetrische Kohärenzfunktion', 'Im betrachteten Spezialfall wechselseitig definierte Raum-Zeit-Kohärenzfunktion.', NULL, '[0,1]', 3),
(284, 317, '\\mathfrak{FRZK}', 'Funktionales Raum-Zeit-Kohärenzsystem', 'Gesamtstruktur aus Organisationsräumen, Kohärenzrelation und Kohärenzfunktion.', NULL, 'FRZK-Systemstruktur', 1),
(285, 317, '\\mathfrak{O}_F', 'System der funktionalen Organisationsräume', 'Gesamtheit der im FRZK berücksichtigten funktionalen Organisationsräume.', NULL, 'Organisationsraumstruktur', 2),
(286, 317, '\\mathcal{K}', 'funktionale Kohärenzrelation', 'Relation zwischen den funktionalen Organisationsräumen.', NULL, 'Relation', 3),
(287, 317, '\\chi', 'Raum-Zeit-Kohärenzfunktion', 'Quantitative Bewertung der funktionalen Kopplung.', NULL, '[0,1]', 4),
(288, 318, '\\Delta_{\\kappa}', 'funktionale Dynamik', 'Reelle Änderung der funktionalen Kohärenz.', NULL, '\\mathfrak{FRZK}\\rightarrow\\mathbb{R}', 1),
(289, 318, '\\mathfrak{FRZK}', 'Funktionales Raum-Zeit-Kohärenzsystem', 'In Satz 3.4.6 definierte Gesamtsystemstruktur.', NULL, 'FRZK-Systemstruktur', 2),
(290, 319, '\\Gamma_F', 'funktionale Entwicklungsbahn', 'Geordnete Folge funktionaler Organisationsräume.', NULL, 'endliche Folge', 1),
(291, 319, '\\mathfrak{O}_i', 'i-ter Organisationsraum', 'Funktionaler Organisationsraum an der i-ten Stelle der Entwicklungsbahn.', NULL, 'funktionaler Organisationsraum', 2),
(292, 319, 'n', 'Anzahl der Transformationsschritte', 'Endlicher Index der Entwicklungsbahn.', NULL, '\\mathbb{N}', 3),
(293, 320, '\\Delta_{\\kappa}', 'Kohärenzdifferenz', 'Differenz zwischen zwei aufeinanderfolgenden Kohärenzwerten.', NULL, '\\mathbb{R}', 1),
(294, 320, '\\kappa(\\mathfrak{O}_{i+1})', 'nachfolgender Kohärenzwert', 'Kohärenzwert des nachfolgenden Organisationsraums.', NULL, '[0,1]', 2),
(295, 320, '\\kappa(\\mathfrak{O}_i)', 'vorhergehender Kohärenzwert', 'Kohärenzwert des vorhergehenden Organisationsraums.', NULL, '[0,1]', 3),
(296, 321, '\\mathcal{T}_F^{\\,n}', 'rekursive Transformationsfolge', 'n-fache wohldefinierte Anwendung der funktionalen Transformation.', NULL, 'Abbildungsfolge', 1),
(297, 321, '\\Gamma_F', 'resultierende Entwicklungsbahn', 'Durch die rekursive Transformationsfolge erzeugte geordnete Folge.', NULL, 'funktionale Entwicklungsbahn', 2),
(298, 322, '\\mathcal{T}_F^{\\,n}', 'n-fache funktionale Transformation', 'n-fache Komposition der funktionalen Transformation.', NULL, 'Abbildung auf funktionalen Organisationsräumen', 1),
(299, 322, '\\mathfrak{O}_A', 'funktionaler Attraktor', 'Funktionaler Organisationsraum, der nach n Transformationen wieder erreicht wird.', NULL, 'funktionaler Organisationsraum', 2),
(300, 322, 'n', 'Periodenlänge', 'Positive endliche Anzahl der Transformationen bis zur Wiederkehr.', NULL, '\\mathbb{N}_{>0}', 3),
(301, 323, '\\mathcal{A}_F', 'Attraktorenmenge', 'Menge aller funktionalen Organisationsräume mit endlicher Wiederkehr.', NULL, 'Menge funktionaler Organisationsräume', 1),
(302, 323, '\\mathfrak{O}_A', 'Element der Attraktorenmenge', 'Ein die Wiederkehrbedingung erfüllender funktionaler Organisationsraum.', NULL, '\\mathfrak{O}_A\\in\\mathcal{A}_F', 2),
(303, 324, '\\kappa', 'Kohärenzfunktion', 'Normiertes Maß funktionaler Kohärenz.', NULL, 'Organisationsraum nach [0,1]', 1),
(304, 324, '\\mathfrak{O}_A', 'funktionaler Attraktor', 'Wiederkehrender funktionaler Organisationsraum.', NULL, 'funktionaler Organisationsraum', 2),
(305, 325, '\\left|\\{\\mathfrak{O}_i\\}\\right|', 'Anzahl erreichbarer Organisationsräume', 'Kardinalität der von der Entwicklungsbahn besuchten Organisationsraummenge.', NULL, '\\mathbb{N}', 1),
(306, 325, '\\exists', 'Existenzquantor', 'Kennzeichnet die Existenz mindestens eines funktionalen Attraktors.', NULL, 'Logik', 2),
(307, 325, '\\mathcal{A}_F', 'Attraktorenmenge', 'Menge der funktionalen Attraktoren.', NULL, 'Menge', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `figures`
--

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

--
-- Daten für Tabelle `figures`
--

INSERT INTO `figures` (`figure_id`, `figure_number`, `section_id`, `title`, `caption`, `file_name`, `file_path`, `alt_text`, `figure_type`, `provenance`, `source_id`, `generation_method`, `data_reference`, `validation_status`, `created_revision_id`) VALUES
(1, 'Abb. 3.P1', 23, 'Geplante Übersicht der funktionalen Entwicklungsfolge', 'Geplante schematische Darstellung der Entwicklung von funktionalen Axiomen über Rekursion und Kohärenz zu Raum und Zeit.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 3),
(2, 'Abb. 3.1', 9, 'Mengenhierarchie', 'Schematische Darstellung von Element, Menge und Teilmenge.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 6),
(3, 'Abb. 3.2', 10, 'Relationen', 'Schematische Darstellung binärer Relationen.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 6),
(4, 'Abb. 3.3', 11, 'Funktionen', 'Schematische Darstellung von Definitionsmenge, Zielmenge und eindeutiger Zuordnung.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 6),
(5, 'Abb. 3.4', 13, 'Operatoren', 'Schematische Darstellung einer rekursiven Operatoranwendung.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 6),
(6, 'Abb. 3.5', 14, 'Zustandsraum', 'Schematische Darstellung eines Zustandsraumes mit Trajektorie.', NULL, NULL, NULL, 'plot', 'original', NULL, NULL, NULL, 'draft', 6),
(7, 'Abb. 3.6', 16, 'Dynamische Systeme', 'Schematische Darstellung von Fixpunkt, Attraktor und Bifurkation.', NULL, NULL, NULL, 'plot', 'original', NULL, NULL, NULL, 'draft', 6),
(8, 'Abb. 3.7', 18, 'Netzwerkstruktur', 'Schematische Darstellung von Knoten, Kanten und Hubs.', NULL, NULL, NULL, 'network', 'original', NULL, NULL, NULL, 'draft', 6),
(9, 'Abb. 3.8', 20, 'Emergente Ordnungsbildung', 'Schematische Darstellung lokaler Wechselwirkungen und globaler Ordnung.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lemmas`
--

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

--
-- Daten für Tabelle `lemmas`
--

INSERT INTO `lemmas` (`lemma_id`, `lemma_number`, `section_id`, `title`, `statement_text`, `statement_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(17, 'Lemma 3.4.1', 61, 'Nichtnegativität', 'Für alle funktionalen Konfigurationen ist die funktionale Differenz nichtnegativ.', '\\Delta_F(\\omega_i,\\omega_j)\\ge0', '\\Delta_F(\\omega_i,\\omega_j)\\ge0', 'original', NULL, NULL, 'checked', 11),
(18, 'Lemma 3.4.2', 61, 'Reflexivität der funktionalen Identität', 'Jede funktionale Konfiguration besitzt zu sich selbst die Differenz null.', '\\Delta_F(\\omega,\\omega)=0', '\\Delta_F(\\omega,\\omega)=0', 'original', NULL, NULL, 'checked', 11),
(19, 'Lemma 3.4.3', 65, 'Rekursive Kohärenzerhaltung', 'Ist eine funktionale Transformation kohärenzerhaltend, dann bleibt der Kohärenzwert unter jeder endlichen Iteration dieser Transformation erhalten.', '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', '\\forall n\\in\\mathbb{N}:\\;\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)', 'original', NULL, 'Def. 3.4.10 gilt.', 'checked', 49),
(20, 'Lemma 3.4.4', 66, 'Symmetrie der Raum-Zeit-Kohärenz', 'Ist die funktionale Kopplung zwischen zwei Organisationsräumen wechselseitig definiert, dann ist die Raum-Zeit-Kohärenzfunktion symmetrisch.', '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)', '\\chi(\\mathfrak{O}_1,\\mathfrak{O}_2)=\\chi(\\mathfrak{O}_2,\\mathfrak{O}_1)', 'original', NULL, 'Def. 3.4.12 gilt und die Kopplung ist wechselseitig definiert.', 'checked', 50),
(21, 'Lemma 3.4.5', 67, 'Kohärenzdifferenz auf Entwicklungsbahnen', 'Für zwei aufeinanderfolgende Organisationsräume einer funktionalen Entwicklungsbahn ist die funktionale Dynamik durch die Differenz ihrer Kohärenzwerte bestimmt.', '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)', '\\Delta_{\\kappa}=\\kappa(\\mathfrak{O}_{i+1})-\\kappa(\\mathfrak{O}_i)', 'original', NULL, 'Def. 3.4.9, Def. 3.4.13 und Def. 3.4.14 gelten.', 'checked', 51),
(22, 'Lemma 3.4.6', 68, 'Kohärenzerhaltung funktionaler Attraktoren', 'Für einen funktionalen Attraktor stimmt der Kohärenzwert des Ausgangsraums mit dem Kohärenzwert des nach n Transformationen wieder erreichten Organisationsraums überein.', '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)', '\\kappa(\\mathfrak{O}_A)=\\kappa\\!\\left(\\mathcal{T}_F^{\\,n}(\\mathfrak{O}_A)\\right)', 'original', NULL, 'Def. 3.4.9 und Def. 3.4.15 gelten.', 'checked', 52),
(23, 'Lemma 3.4.7', 64, 'Strukturerhaltung', 'Eine invariante Organisationsstruktur bleibt unter jeder endlichen Iteration erhalten.', '\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', '\\mathcal{T}_F^{\\,n}(\\mathcal{O})=\\mathcal{O}', 'original', NULL, NULL, 'checked', 11),
(24, 'Lemma 3.4.8', 64, 'Abgeschlossenheit des Organisationsraums', 'Die Transformation einer Relation der Organisation verbleibt in der Organisation.', '\\mathcal{T}_F(r)\\in\\mathcal{O}', '\\mathcal{T}_F(r)\\in\\mathcal{O}', 'original', NULL, NULL, 'checked', 11),
(25, 'Lemma 3.4.9', 65, 'Abgeschlossenheit des Zustandsraums', 'Transformierte funktionale Zustände verbleiben im Zustandsraum.', '\\mathcal{T}_F(x)\\in\\mathcal{X}_F', '\\mathcal{T}_F(x)\\in\\mathcal{X}_F', 'original', NULL, NULL, 'checked', 11),
(26, 'Lemma 3.4.10', 65, 'Erreichbarkeit funktionaler Zustände', 'Ein funktionaler Zustand kann durch eine endliche Transformationsfolge aus einem anderen hervorgehen.', 'x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'original', NULL, NULL, 'checked', 11),
(27, 'Lemma 3.4.11', 66, 'Erhaltung der Kohärenz', 'Kohärente Zustandsmengen bleiben unter jeder endlichen Iteration invariant.', '\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}', '\\mathcal{T}_F^{\\,n}(\\mathcal{K})=\\mathcal{K}', 'original', NULL, NULL, 'checked', 11),
(28, 'Lemma 3.4.12', 66, 'Existenz kohärenter Teilräume', 'Ein funktionaler Organisationsraum besitzt mindestens eine kohärente Teilstruktur.', '\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F', '\\exists\\,\\mathcal{K}\\subseteq\\mathcal{X}_F', 'original', NULL, NULL, 'checked', 11),
(29, 'Lemma 3.4.13', 67, 'Reflexivität der Erreichbarkeit', 'Jeder funktionale Zustand ist von sich selbst erreichbar.', 'x\\leadsto x', 'x\\leadsto x', 'original', NULL, NULL, 'checked', 11),
(30, 'Lemma 3.4.14', 67, 'Transitivität der Erreichbarkeit', 'Die funktionale Erreichbarkeitsrelation ist transitiv.', 'x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k', 'x_i\\leadsto x_j\\land x_j\\leadsto x_k\\Longrightarrow x_i\\leadsto x_k', 'original', NULL, NULL, 'checked', 11),
(31, 'Lemma 3.4.15', 68, 'Irreflexivität der Transformationsordnung', 'Kein Zustand liegt in der strikten Transformationsordnung vor sich selbst.', 'x\\not\\prec_T x', 'x\\not\\prec_T x', 'original', NULL, NULL, 'checked', 11),
(32, 'Lemma 3.4.16', 68, 'Transitivität der Transformationsordnung', 'Die funktionale Transformationsordnung ist transitiv.', 'x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k', 'x_i\\prec_T x_j\\land x_j\\prec_T x_k\\Longrightarrow x_i\\prec_T x_k', 'original', NULL, NULL, 'checked', 11);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `object_dependencies`
--

CREATE TABLE `object_dependencies` (
  `object_dependency_id` bigint(20) UNSIGNED NOT NULL,
  `object_type_from` enum('definition','theorem','lemma','corollary','proof','equation','assumption','axiom','figure','table') NOT NULL,
  `object_id_from` bigint(20) UNSIGNED NOT NULL,
  `object_type_to` enum('definition','theorem','lemma','corollary','proof','equation','assumption','axiom','figure','table') NOT NULL,
  `object_id_to` bigint(20) UNSIGNED NOT NULL,
  `dependency_type` enum('depends_on','derives_from','supports','contrasts','generalizes','specializes','validates') NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `object_dependencies`
--

INSERT INTO `object_dependencies` (`object_dependency_id`, `object_type_from`, `object_id_from`, `object_type_to`, `object_id_to`, `dependency_type`, `note`) VALUES
(1, 'equation', 286, 'axiom', 1, 'derives_from', 'Gleichung (3.64) ist die formale Darstellung von Axiom A1.'),
(2, 'equation', 287, 'axiom', 2, 'derives_from', 'Gleichung (3.65) ist die formale Darstellung von Axiom A2.'),
(3, 'equation', 288, 'axiom', 3, 'derives_from', 'Gleichung (3.66) ist die formale Darstellung von Axiom A3.'),
(5, 'equation', 292, 'axiom', 4, 'derives_from', 'Gleichung (3.68) ist die formale Darstellung von Axiom A4.'),
(6, 'equation', 294, 'axiom', 5, 'derives_from', 'Gleichung (3.70) ist die formale Darstellung von Axiom A5.'),
(7, 'equation', 296, 'axiom', 1, '', 'Gleichung (3.72) fasst Axiom A1 als Teil des gemeinsamen Axiomensystems zusammen.'),
(8, 'equation', 296, 'axiom', 2, '', 'Gleichung (3.72) fasst Axiom A2 als Teil des gemeinsamen Axiomensystems zusammen.'),
(9, 'equation', 296, 'axiom', 3, '', 'Gleichung (3.72) fasst Axiom A3 als Teil des gemeinsamen Axiomensystems zusammen.'),
(10, 'equation', 296, 'axiom', 4, '', 'Gleichung (3.72) fasst Axiom A4 als Teil des gemeinsamen Axiomensystems zusammen.'),
(11, 'equation', 296, 'axiom', 5, '', 'Gleichung (3.72) fasst Axiom A5 als Teil des gemeinsamen Axiomensystems zusammen.'),
(12, 'definition', 44, 'axiom', 4, 'derives_from', 'Def. 3.4.1 rekonstruiert den funktionalen Zustand aus stabiler funktionaler Organisation gemäß Axiom A4.'),
(13, 'definition', 45, 'definition', 44, 'depends_on', 'Def. 3.4.2 setzt die Definition des funktionalen Zustands voraus.'),
(14, 'definition', 45, 'axiom', 5, 'derives_from', 'Die Vergleichbarkeit und mögliche Wiedererkennbarkeit mehrerer funktionaler Zustände wird durch Axiom A5 vorbereitet.'),
(15, 'equation', 298, 'definition', 44, 'derives_from', 'Gleichung (3.74) ist die formale Darstellung von Def. 3.4.1.'),
(16, 'equation', 299, 'definition', 45, 'derives_from', 'Gleichung (3.75) ist die formale Darstellung von Def. 3.4.2.'),
(17, 'definition', 46, 'axiom', 2, 'derives_from', 'Def. 3.4.3 formalisiert die durch A2 eröffnete Relationierbarkeit.'),
(18, 'definition', 46, 'definition', 45, 'depends_on', 'Funktionale Relationen werden auf der Klasse funktionaler Zustände definiert.'),
(19, 'definition', 47, 'definition', 46, 'depends_on', 'Die Relationsstruktur setzt die funktionale Relation voraus.'),
(20, 'definition', 47, 'definition', 45, 'depends_on', 'Die Relationsstruktur setzt die Zustandsklasse voraus.'),
(21, 'equation', 300, 'definition', 46, 'derives_from', 'Gleichung (3.76) formalisiert Def. 3.4.3.'),
(22, 'equation', 301, 'definition', 46, 'derives_from', 'Gleichung (3.77) konkretisiert Def. 3.4.3 durch einen binären Indikator.'),
(23, 'equation', 302, 'definition', 47, 'derives_from', 'Gleichung (3.78) formalisiert Def. 3.4.4.'),
(24, 'definition', 48, 'axiom', 3, 'derives_from', 'Def. 3.4.5 formalisiert die durch Axiom A3 eröffnete funktionale Transformation.'),
(25, 'definition', 48, 'definition', 45, 'depends_on', 'Die funktionale Transformation wird auf der Klasse funktionaler Zustände definiert.'),
(26, 'definition', 48, 'definition', 47, 'depends_on', 'Die Transformation baut auf der funktionalen Relationsstruktur auf.'),
(27, 'definition', 49, 'definition', 48, 'depends_on', 'Die rekursive Transformation setzt die funktionale Transformation voraus.'),
(28, 'theorem', 11, 'definition', 48, 'derives_from', 'Die Abgeschlossenheit folgt unmittelbar aus der Abbildung T_F:X->X.'),
(29, 'theorem', 11, 'definition', 45, 'depends_on', 'Der Satz verwendet die Klasse funktionaler Zustände.'),
(30, 'equation', 303, 'definition', 48, 'derives_from', 'Gleichung (3.79) ist die formale Darstellung von Def. 3.4.5.'),
(31, 'equation', 304, 'definition', 49, 'derives_from', 'Gleichung (3.80) ist die formale Darstellung von Def. 3.4.6.'),
(32, 'equation', 305, 'theorem', 11, 'derives_from', 'Gleichung (3.81) ist die formale Darstellung von Satz 3.4.3.'),
(33, 'definition', 50, 'axiom', 4, 'derives_from', 'Def. 3.4.7 formalisiert die durch Axiom A4 eröffnete stabile funktionale Organisation.'),
(34, 'definition', 50, 'definition', 48, 'depends_on', 'Eine organisationserzeugende Transformation setzt eine funktionale Transformation voraus.'),
(35, 'definition', 50, 'definition', 49, 'depends_on', 'Die Invarianz wird für rekursive Transformationen formuliert.'),
(36, 'definition', 51, 'definition', 50, 'depends_on', 'Der funktionale Organisationsraum setzt eine organisationserzeugende Transformation voraus.'),
(37, 'theorem', 12, 'definition', 50, 'depends_on', 'Der Existenzsatz verwendet die organisationserzeugende Transformation.'),
(38, 'theorem', 12, 'definition', 51, 'derives_from', 'Der Organisationsraum entsteht nach Def. 3.4.8 aus O_F und T_F.'),
(39, 'equation', 306, 'definition', 50, 'derives_from', 'Gleichung (3.82) ist Teil der formalen Darstellung von Def. 3.4.7.'),
(40, 'equation', 307, 'definition', 50, 'derives_from', 'Gleichung (3.83) ist die Invarianzbedingung von Def. 3.4.7.'),
(41, 'equation', 308, 'definition', 51, 'derives_from', 'Gleichung (3.84) ist die formale Darstellung von Def. 3.4.8.'),
(42, 'equation', 309, 'theorem', 12, 'derives_from', 'Gleichung (3.85) beschreibt die rekursive Abgeschlossenheit des Organisationsraums.'),
(43, 'definition', 52, 'axiom', 4, 'derives_from', 'Funktionale Kohärenz konkretisiert stabile funktionale Organisation aus A4.'),
(44, 'definition', 52, 'definition', 51, 'depends_on', 'Die Kohärenzfunktion wird auf funktionalen Organisationsräumen definiert.'),
(45, 'definition', 53, 'definition', 52, 'depends_on', 'Kohärenzerhaltung setzt die Kohärenzfunktion voraus.'),
(46, 'lemma', 19, 'definition', 53, 'derives_from', 'Die rekursive Kohärenzerhaltung folgt aus der schrittweisen Kohärenzerhaltung.'),
(47, 'theorem', 13, 'definition', 52, 'depends_on', 'Der Satz setzt eine definierte Kohärenzfunktion voraus.'),
(48, 'theorem', 13, 'definition', 53, 'depends_on', 'Der Satz setzt eine kohärenzerhaltende Transformation voraus.'),
(49, 'equation', 310, 'definition', 52, 'derives_from', 'Gleichung (3.86) formalisiert Def. 3.4.9.'),
(50, 'equation', 311, 'definition', 53, 'derives_from', 'Gleichung (3.87) formalisiert Def. 3.4.10.'),
(51, 'equation', 312, 'lemma', 19, 'derives_from', 'Gleichung (3.88) formalisiert Lemma 3.4.3.'),
(52, 'equation', 313, 'theorem', 13, 'derives_from', 'Gleichung (3.89) formalisiert Satz 3.4.5.'),
(53, 'definition', 54, 'axiom', 5, 'derives_from', 'Def. 3.4.11 konkretisiert die durch Axiom A5 eröffnete Reproduzierbarkeit und Vergleichbarkeit funktionaler Organisationsmuster.'),
(54, 'definition', 54, 'definition', 51, 'depends_on', 'Die Raum-Zeit-Kohärenzrelation wird zwischen funktionalen Organisationsräumen definiert.'),
(55, 'definition', 55, 'definition', 54, 'depends_on', 'Die Raum-Zeit-Kohärenzfunktion quantifiziert die zuvor definierte Kohärenzrelation.'),
(56, 'definition', 55, 'definition', 52, '', 'Die Raum-Zeit-Kohärenzfunktion erweitert den zuvor eingeführten Kohärenzbegriff auf Paare von Organisationsräumen.'),
(57, 'lemma', 20, 'definition', 55, 'derives_from', 'Das Symmetrielemma bezieht sich auf die Raum-Zeit-Kohärenzfunktion.'),
(58, 'theorem', 14, 'definition', 51, 'depends_on', 'Das FRZK setzt funktionale Organisationsräume voraus.'),
(59, 'theorem', 14, 'definition', 54, 'depends_on', 'Das FRZK setzt die funktionale Kohärenzrelation voraus.'),
(60, 'theorem', 14, 'definition', 55, 'depends_on', 'Das FRZK setzt die quantifizierende Raum-Zeit-Kohärenzfunktion voraus.'),
(61, 'equation', 314, 'definition', 54, 'derives_from', 'Gleichung (3.90) formalisiert Def. 3.4.11.'),
(62, 'equation', 315, 'definition', 55, 'derives_from', 'Gleichung (3.91) formalisiert Def. 3.4.12.'),
(63, 'equation', 316, 'lemma', 20, 'derives_from', 'Gleichung (3.92) formalisiert Lemma 3.4.4.'),
(64, 'equation', 317, 'theorem', 14, 'derives_from', 'Gleichung (3.93) formalisiert Satz 3.4.6.'),
(65, 'definition', 56, 'axiom', 3, 'derives_from', 'Funktionale Dynamik baut auf der durch A3 eröffneten rekursiven Transformation auf.'),
(66, 'definition', 56, 'axiom', 4, 'derives_from', 'Die Kohärenzänderung setzt stabile funktionale Organisation voraus.'),
(67, 'definition', 56, 'definition', 52, 'depends_on', 'Die funktionale Dynamik verwendet die Kohärenzfunktion.'),
(68, 'definition', 57, 'definition', 49, 'depends_on', 'Die Entwicklungsbahn wird durch rekursive Transformationen erzeugt.'),
(69, 'definition', 57, 'definition', 51, 'depends_on', 'Die Elemente der Entwicklungsbahn sind funktionale Organisationsräume.'),
(70, 'lemma', 21, 'definition', 56, 'depends_on', 'Das Lemma verwendet die Definition funktionaler Dynamik.'),
(71, 'lemma', 21, 'definition', 57, 'depends_on', 'Die Kohärenzdifferenz wird auf einer funktionalen Entwicklungsbahn gebildet.'),
(72, 'theorem', 15, 'definition', 49, 'depends_on', 'Der Satz setzt rekursive Transformationen voraus.'),
(73, 'theorem', 15, 'definition', 57, 'derives_from', 'Die resultierende Folge wird als funktionale Entwicklungsbahn definiert.'),
(74, 'equation', 318, 'definition', 56, 'derives_from', 'Gleichung (3.94) formalisiert Def. 3.4.13.'),
(75, 'equation', 319, 'definition', 57, 'derives_from', 'Gleichung (3.95) formalisiert Def. 3.4.14.'),
(76, 'equation', 320, 'lemma', 21, 'derives_from', 'Gleichung (3.96) formalisiert Lemma 3.4.5.'),
(77, 'equation', 321, 'theorem', 15, 'derives_from', 'Gleichung (3.97) formalisiert Satz 3.4.7.'),
(78, 'definition', 58, 'axiom', 4, 'derives_from', 'Der funktionale Attraktor konkretisiert stabile funktionale Organisation nach Axiom A4.'),
(79, 'definition', 58, 'definition', 49, 'depends_on', 'Die Attraktordefinition verwendet rekursive Transformationen.'),
(80, 'definition', 58, 'definition', 51, 'depends_on', 'Ein funktionaler Attraktor ist ein besonderer funktionaler Organisationsraum.'),
(81, 'definition', 59, 'definition', 58, 'depends_on', 'Die Attraktorenmenge setzt die Definition des funktionalen Attraktors voraus.'),
(82, 'lemma', 22, 'definition', 58, 'depends_on', 'Das Kohärenzlemma setzt die Attraktordefinition voraus.'),
(83, 'lemma', 22, 'definition', 52, 'depends_on', 'Das Kohärenzlemma verwendet die Kohärenzfunktion.'),
(84, 'theorem', 16, 'definition', 57, 'depends_on', 'Der Existenzsatz verwendet funktionale Entwicklungsbahnen.'),
(85, 'theorem', 16, 'definition', 59, 'derives_from', 'Wiederkehrende Organisationsräume gehören nach Def. 3.4.16 zur Attraktorenmenge.'),
(86, 'equation', 322, 'definition', 58, 'derives_from', 'Gleichung (3.98) formalisiert Def. 3.4.15.'),
(87, 'equation', 323, 'definition', 59, 'derives_from', 'Gleichung (3.99) formalisiert Def. 3.4.16.'),
(88, 'equation', 324, 'lemma', 22, 'derives_from', 'Gleichung (3.100) formalisiert Lemma 3.4.6.'),
(89, 'equation', 325, 'theorem', 16, 'derives_from', 'Gleichung (3.101) formalisiert Satz 3.4.8.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `object_source_links`
--

CREATE TABLE `object_source_links` (
  `object_source_link_id` bigint(20) UNSIGNED NOT NULL,
  `object_type` enum('definition','theorem','lemma','corollary','proof','proposition','equation','figure','table','symbol','acronym','assumption','axiom') NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL,
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `usage_type` enum('primary_source','supporting_source','adapted_from','contrasts','historical_context','verification') NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pending_sources`
--

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

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `proofs`
--

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

--
-- Daten für Tabelle `proofs`
--

INSERT INTO `proofs` (`proof_id`, `proof_number`, `section_id`, `theorem_id`, `lemma_id`, `corollary_id`, `title`, `proof_text`, `proof_latex`, `proof_method`, `provenance`, `source_id`, `validation_status`, `created_revision_id`) VALUES
(32, 'Bew. 3.4.1', 61, NULL, 17, NULL, 'Beweis zu Lemma 3.4.1', 'Beweisentwurf zu Lemma 3.4.1: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.1.', NULL, 'direct', 'original', NULL, 'draft', 11),
(33, 'Bew. 3.4.2', 61, NULL, 18, NULL, 'Beweis zu Lemma 3.4.2', 'Beweisentwurf zu Lemma 3.4.2: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.1.', NULL, 'direct', 'original', NULL, 'draft', 11),
(34, 'Bew. 3.4.3', 62, NULL, 19, NULL, 'Beweis zu Lemma 3.4.3', 'Beweisentwurf zu Lemma 3.4.3: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.2.', NULL, 'direct', 'original', NULL, 'draft', 11),
(35, 'Bew. 3.4.4', 62, NULL, 20, NULL, 'Beweis zu Lemma 3.4.4', 'Beweisentwurf zu Lemma 3.4.4: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.2.', NULL, 'direct', 'original', NULL, 'draft', 11),
(36, 'Bew. 3.4.5', 63, NULL, 21, NULL, 'Beweis zu Lemma 3.4.5', 'Beweisentwurf zu Lemma 3.4.5: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.3.', NULL, 'direct', 'original', NULL, 'draft', 11),
(37, 'Bew. 3.4.6', 63, NULL, 22, NULL, 'Beweis zu Lemma 3.4.6', 'Beweisentwurf zu Lemma 3.4.6: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.3.', NULL, 'direct', 'original', NULL, 'draft', 11),
(38, 'Bew. 3.4.7', 64, NULL, 23, NULL, 'Beweis zu Lemma 3.4.7', 'Beweisentwurf zu Lemma 3.4.7: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.4.', NULL, 'direct', 'original', NULL, 'draft', 11),
(39, 'Bew. 3.4.8', 64, NULL, 24, NULL, 'Beweis zu Lemma 3.4.8', 'Beweisentwurf zu Lemma 3.4.8: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.4.', NULL, 'direct', 'original', NULL, 'draft', 11),
(40, 'Bew. 3.4.9', 65, NULL, 25, NULL, 'Beweis zu Lemma 3.4.9', 'Beweisentwurf zu Lemma 3.4.9: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.5.', NULL, 'direct', 'original', NULL, 'draft', 11),
(41, 'Bew. 3.4.10', 65, NULL, 26, NULL, 'Beweis zu Lemma 3.4.10', 'Beweisentwurf zu Lemma 3.4.10: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.5.', NULL, 'direct', 'original', NULL, 'draft', 11),
(42, 'Bew. 3.4.11', 66, NULL, 27, NULL, 'Beweis zu Lemma 3.4.11', 'Beweisentwurf zu Lemma 3.4.11: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.6.', NULL, 'direct', 'original', NULL, 'draft', 11),
(43, 'Bew. 3.4.12', 66, NULL, 28, NULL, 'Beweis zu Lemma 3.4.12', 'Beweisentwurf zu Lemma 3.4.12: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.6.', NULL, 'direct', 'original', NULL, 'draft', 11),
(44, 'Bew. 3.4.13', 67, NULL, 29, NULL, 'Beweis zu Lemma 3.4.13', 'Beweisentwurf zu Lemma 3.4.13: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.7.', NULL, 'direct', 'original', NULL, 'draft', 11),
(45, 'Bew. 3.4.14', 67, NULL, 30, NULL, 'Beweis zu Lemma 3.4.14', 'Beweisentwurf zu Lemma 3.4.14: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.7.', NULL, 'direct', 'original', NULL, 'draft', 11),
(46, 'Bew. 3.4.15', 68, NULL, 31, NULL, 'Beweis zu Lemma 3.4.15', 'Beweisentwurf zu Lemma 3.4.15: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.8.', NULL, 'direct', 'original', NULL, 'draft', 11),
(47, 'Bew. 3.4.16', 68, NULL, 32, NULL, 'Beweis zu Lemma 3.4.16', 'Beweisentwurf zu Lemma 3.4.16: Die Aussage wird aus den unmittelbar vorhergehenden Definitionen und der jeweils angegebenen Abgeschlossenheits-, Invarianz- oder Ordnungsbedingung hergeleitet. Der ausformulierte Beweis steht im Dissertationstext von Abschnitt 3.4.8.', NULL, 'direct', 'original', NULL, 'draft', 11),
(48, 'Bew. 3.4.17', 61, 9, NULL, NULL, 'Beweis zu Satz 3.4.1', 'Beweisentwurf zu Satz 3.4.1: Der Satz folgt aus den in Abschnitt 3.4.1 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(49, 'Bew. 3.4.18', 62, 10, NULL, NULL, 'Beweis zu Satz 3.4.2', 'Beweisentwurf zu Satz 3.4.2: Der Satz folgt aus den in Abschnitt 3.4.2 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(50, 'Bew. 3.4.19', 63, 11, NULL, NULL, 'Beweis zu Satz 3.4.3', 'Beweisentwurf zu Satz 3.4.3: Der Satz folgt aus den in Abschnitt 3.4.3 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(51, 'Bew. 3.4.20', 64, 12, NULL, NULL, 'Beweis zu Satz 3.4.4', 'Beweisentwurf zu Satz 3.4.4: Der Satz folgt aus den in Abschnitt 3.4.4 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(52, 'Bew. 3.4.21', 65, 13, NULL, NULL, 'Beweis zu Satz 3.4.5', 'Beweisentwurf zu Satz 3.4.5: Der Satz folgt aus den in Abschnitt 3.4.5 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(53, 'Bew. 3.4.22', 66, 14, NULL, NULL, 'Beweis zu Satz 3.4.6', 'Beweisentwurf zu Satz 3.4.6: Der Satz folgt aus den in Abschnitt 3.4.6 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(54, 'Bew. 3.4.23', 67, 15, NULL, NULL, 'Beweis zu Satz 3.4.7', 'Beweisentwurf zu Satz 3.4.7: Der Satz folgt aus den in Abschnitt 3.4.7 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(55, 'Bew. 3.4.24', 68, 16, NULL, NULL, 'Beweis zu Satz 3.4.8', 'Beweisentwurf zu Satz 3.4.8: Der Satz folgt aus den in Abschnitt 3.4.8 eingeführten Definitionen und den unmittelbar vorangestellten Lemmata. Der vollständige argumentative Beweis ist im Dissertationstext enthalten und wird vor der Finalisierung formal geprüft.', NULL, 'direct', 'original', NULL, 'draft', 11),
(56, 'Bew. 3.4.25', 62, NULL, NULL, 8, 'Beweis zu Korollar 3.4.1', 'Beweisentwurf zu Korollar 3.4.1: Das Korollar folgt unmittelbar aus Satz 3.4.2 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11),
(57, 'Bew. 3.4.26', 63, NULL, NULL, 9, 'Beweis zu Korollar 3.4.2', 'Beweisentwurf zu Korollar 3.4.2: Das Korollar folgt unmittelbar aus Satz 3.4.3 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11),
(58, 'Bew. 3.4.27', 64, NULL, NULL, 10, 'Beweis zu Korollar 3.4.3', 'Beweisentwurf zu Korollar 3.4.3: Das Korollar folgt unmittelbar aus Satz 3.4.4 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11),
(59, 'Bew. 3.4.28', 65, NULL, NULL, 11, 'Beweis zu Korollar 3.4.4', 'Beweisentwurf zu Korollar 3.4.4: Das Korollar folgt unmittelbar aus Satz 3.4.5 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11),
(60, 'Bew. 3.4.29', 66, NULL, NULL, 12, 'Beweis zu Korollar 3.4.5', 'Beweisentwurf zu Korollar 3.4.5: Das Korollar folgt unmittelbar aus Satz 3.4.6 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11),
(61, 'Bew. 3.4.30', 67, NULL, NULL, 13, 'Beweis zu Korollar 3.4.6', 'Beweisentwurf zu Korollar 3.4.6: Das Korollar folgt unmittelbar aus Satz 3.4.7 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11),
(62, 'Bew. 3.4.31', 68, NULL, NULL, 14, 'Beweis zu Korollar 3.4.7', 'Beweisentwurf zu Korollar 3.4.7: Das Korollar folgt unmittelbar aus Satz 3.4.8 und den zugehörigen Definitionen.', NULL, 'direct', 'original', NULL, 'draft', 11);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `propositions`
--

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

--
-- Daten für Tabelle `propositions`
--

INSERT INTO `propositions` (`proposition_id`, `proposition_number`, `section_id`, `title`, `statement_text`, `statement_latex`, `word_latex`, `logical_derivation`, `based_on_axioms`, `status`, `created_revision_id`) VALUES
(16, 'Prop. 3.1', 58, 'Möglichkeit funktionaler Entwicklungsprozesse', 'Aus der gemeinsamen Annahme der fünf Grundaxiome folgt, dass funktionale Entwicklungsprozesse grundsätzlich möglich sind.', '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F', '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F', 'A1 eröffnet funktionale Unterscheidbarkeit, A2 funktionale Relationierbarkeit, A3 rekursive Transformation, A4 stabile Organisation und A5 reproduzierbare Organisationsmuster. Gemeinsam eröffnen sie die Möglichkeit eines funktionalen Entwicklungsprozesses.', 'A1,A2,A3,A4,A5', 'review', 42);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `proposition_dependencies`
--

CREATE TABLE `proposition_dependencies` (
  `proposition_dependency_id` bigint(20) UNSIGNED NOT NULL,
  `proposition_id` bigint(20) UNSIGNED NOT NULL,
  `axiom_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assumption_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dependency_type` enum('derived_from','uses','motivated_by','contrasts') NOT NULL DEFAULT 'derived_from',
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `proposition_dependencies`
--

INSERT INTO `proposition_dependencies` (`proposition_dependency_id`, `proposition_id`, `axiom_id`, `assumption_id`, `dependency_type`, `note`) VALUES
(42, 16, 1, NULL, 'derived_from', 'Prop. 3.1 verwendet A1.'),
(43, 16, 2, NULL, 'derived_from', 'Prop. 3.1 verwendet A2.'),
(44, 16, 3, NULL, 'derived_from', 'Prop. 3.1 verwendet A3.'),
(45, 16, 4, NULL, 'derived_from', 'Prop. 3.1 verwendet A4.'),
(46, 16, 5, NULL, 'derived_from', 'Prop. 3.1 verwendet A5.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `repository_counters`
--

CREATE TABLE `repository_counters` (
  `counter_key` varchar(100) NOT NULL,
  `counter_value` varchar(100) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `repository_counters`
--

INSERT INTO `repository_counters` (`counter_key`, `counter_value`, `updated_at`) VALUES
('axiom_system_status', 'A1-A5 complete', '2026-07-12 16:17:33'),
('chapter_3_3_status', 'content_complete_review_pending', '2026-07-12 16:17:33'),
('last_completed_section', '3.4', '2026-07-12 11:14:28'),
('last_edited_section', '3.4.8', '2026-07-13 11:00:23'),
('last_repository_revision', 'RKB-2026-07-13-K3.4.8-NEUFASSUNG-V1', '2026-07-13 11:00:23'),
('next_axiom_number', 'COMPLETE', '2026-07-12 15:50:40'),
('next_citation_number', '59', '2026-07-12 12:53:53'),
('next_definition_number', 'Def. 3.4.17', '2026-07-13 11:00:23'),
('next_equation_number', '3.102', '2026-07-13 11:00:23'),
('next_lemma_number', 'Lemma 3.4.7', '2026-07-13 11:00:23'),
('next_proposition_number', 'Prop. 3.2', '2026-07-12 16:06:46'),
('next_section', '3.4.1', '2026-07-12 16:17:33'),
('next_theorem_number', 'Satz 3.4.9', '2026-07-13 11:00:23');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `repository_revisions`
--

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

--
-- Daten für Tabelle `repository_revisions`
--

INSERT INTO `repository_revisions` (`revision_id`, `revision_code`, `revision_date`, `scope_type`, `scope_reference`, `version_label`, `summary`, `created_by`, `parent_revision_id`) VALUES
(1, 'RKB-V4-INITIAL', '2026-07-12 08:08:34', 'repository', 'frzk_rkb', '4.0', 'Initialisierung der stabilen FRZK-RKB-V4-Datenbankbasis.', 'Olaf Thiele / ChatGPT', NULL),
(2, 'RKB-V4-MIGRATION', '2026-07-12 08:09:01', 'repository', 'frzk_rkb', '4.0', 'Migration der bestehenden FRZK-RKB auf die stabile V4-Schemafassung.', 'Olaf Thiele / ChatGPT', NULL),
(3, 'RKB-2026-07-11-V2', '2026-07-11 16:00:00', 'repository', 'frzk_rkb', '2.0', 'Erweiterung der FRZK-RKB zu einem vollständigen Dissertations-Repository.', 'Olaf Thiele / ChatGPT', NULL),
(4, 'RKB-2026-07-12-K3.2-V3', '2026-07-12 12:00:00', 'chapter', '3.2', '3.0', 'Erweiterung um Beweise, Annahmen und Axiome; Vorbereitung des Übergangs von Kapitel 3.2 zu Kapitel 3.3.', 'Olaf Thiele / ChatGPT', NULL),
(6, 'RKB-2026-07-12-K3.2-COMPLETE', '2026-07-12 12:00:00', 'chapter', '3.2', '1.0', 'Vollständiger Abschlussimport für Kapitel 3.2: Literatur, Annotationen, Verwendungen, Gleichungen, Definitionen, Symbole, Anforderungen, Verzeichnisse, Korrekturen und Validierungen.', 'Olaf Thiele / ChatGPT', NULL),
(9, 'RKB-2026-07-12-K3.3-COMPLETE', '2026-07-12 13:00:00', 'chapter', '3.3', '1.0', 'Vollständiger Abschlussimport für Kapitel 3.3: Axiome, Propositionen, Gleichungen, Symbole, Quellenverwendungen und Änderungsprotokoll.', 'Olaf Thiele / ChatGPT', NULL),
(10, 'RKB-2026-07-12-K3.3-NEUFASSUNG', '2026-07-12 08:36:43', 'chapter', '3.3', '2.0', 'Vollständige Neufassung von Kapitel 3.3 als prämathematisches Axiomenkapitel; Anpassung von Gliederung, Axiomen, Propositionen, Gleichungen, Symbolen und Literaturverwendungen.', 'Olaf Thiele / ChatGPT', 9),
(11, 'RKB-2026-07-12-K3.4-COMPLETE', '2026-07-12 10:40:13', 'chapter', '3.4', '1.0', 'Vollständiger Abschlussimport für Kapitel 3.4: Abschnittsstruktur, Gleichungen, Definitionen, Lemmata, Sätze, Korollare, Beweise, Symbole, Zähler und Validierungen.', 'Olaf Thiele / ChatGPT', 10),
(13, 'RKB-2026-07-12-AUDIT-K3.4', '2026-07-12 11:14:28', 'repository', 'frzk_rkb', '4.1', 'Vollständiger Schema-, Daten- und Konsistenzaudit bis einschließlich Kapitel 3.4.', 'Olaf Thiele / ChatGPT', 11),
(14, 'RKB-2026-07-12-K3.1.1-NEUFASSUNG-V1', '2026-07-12 14:15:00', 'section', '3.1.1', '1.0', 'Neufassung von Abschnitt 3.1.1 einschließlich vollständiger Registrierung der wiederverwendeten Quellen [1] bis [15].', 'Olaf Thiele / ChatGPT', 13),
(15, 'RKB-2026-07-12-K3.1.2-NEUFASSUNG-V1', '2026-07-12 14:18:38', 'section', '3.1.2', '1.0', 'Neufassung von Abschnitt 3.1.2 einschließlich Neuordnung der Quellenverwendungen [1] bis [11] sowie Erstverwendung von Quelle [16].', 'Olaf Thiele / ChatGPT', 14),
(16, 'RKB-2026-07-12-K3.1.3-NEUFASSUNG-V1', '2026-07-12 14:22:37', 'section', '3.1.3', '1.0', 'Neufassung von Abschnitt 3.1.3 mit den methodischen Anforderungen an eine funktionale Theorie von Raum und Zeit; Wiederverwendung bestehender Quellen [8] und [12] bis [15] sowie Erstverwendung der Quellen [17] und [18].', 'Olaf Thiele / ChatGPT', 15),
(18, 'RKB-2026-07-12-K3.1.4-NEUFASSUNG-V1', '2026-07-12 14:37:33', 'section', '3.1.4', '1.0', 'Neufassung von Abschnitt 3.1.4; Registrierung des Forschungsstands zur Emergenz von Raum und Zeit mit zwei wiederverwendeten und fünf neuen Quellen.', 'Olaf Thiele / ChatGPT', 16),
(19, 'RKB-2026-07-12-K3.1.5-NEUFASSUNG-V1', '2026-07-12 14:37:46', 'section', '3.1.5', '1.0', 'Neufassung von Abschnitt 3.1.5 als wissenschaftliche Einordnung des FRZK; Aktualisierung der Gleichungen (3.1) und (3.2) sowie Abschluss von Kapitel 3.1.', 'Olaf Thiele / ChatGPT', 18),
(20, 'RKB-2026-07-12-K3.2.0-NEUFASSUNG-V1', '2026-07-12 14:53:42', 'section', '3.2.0', '1.0', 'Neufassung der Einleitung zu Kapitel 3.2; mathematische Grundlagen als Forschungsstand und Übergang zur FRZK-Axiomatik.', 'Olaf Thiele / ChatGPT', 19),
(21, 'RKB-2026-07-12-K3.2.1-NEUFASSUNG-V1', '2026-07-12 14:53:53', 'section', '3.2.1', '1.0', 'Neufassung von Abschnitt 3.2.1: Mengen als Grundlage mathematischer Modellbildung; Bereinigung der bisherigen Literaturverwendungen und Gleichungen.', 'Olaf Thiele / ChatGPT', 20),
(22, 'RKB-2026-07-12-K3.2.2-NEUFASSUNG-V1', '2026-07-12 15:10:08', 'section', '3.2.2', '1.0', 'Neufassung von Abschnitt 3.2.2: Relationen als mathematische Beschreibung struktureller Zusammenhänge; Aktualisierung der Gleichungen (3.4) bis (3.9).', 'Olaf Thiele / ChatGPT', 21),
(23, 'RKB-2026-07-12-K3.2.3-NEUFASSUNG-V1', '2026-07-12 15:25:46', 'section', '3.2.3', '1.0', 'Neufassung von Abschnitt 3.2.3 mit den Gleichungen (3.10) bis (3.13) und den bestehenden Quellen [29] und [30].', 'Olaf Thiele / ChatGPT', 22),
(24, 'RKB-2026-07-12-K3.2.4-NEUFASSUNG-V1', '2026-07-12 15:26:39', 'section', '3.2.4', '1.0', 'Neufassung von Abschnitt 3.2.4 mit den Gleichungen (3.14) bis (3.18) und den bestehenden Quellen [31] bis [34].', 'Olaf Thiele / ChatGPT', 23),
(25, 'RKB-2026-07-12-K3.2.5-NEUFASSUNG-V1', '2026-07-12 15:49:53', 'section', '3.2.5', '1.0', 'Neufassung von Abschnitt 3.2.5 mit den Quellen [35] bis [37] und den Gleichungen (3.19) bis (3.24).', 'Olaf Thiele / ChatGPT', 24),
(27, 'RKB-2026-07-12-K3.2.7-NEUFASSUNG-V1', '2026-07-12 16:20:07', 'section', '3.2.7', '1.0', 'Neufassung von Abschnitt 3.2.7 mit den Quellen [35], [36], [41] und [42] sowie den Gleichungen (3.29) bis (3.34).', 'Olaf Thiele / ChatGPT', 25),
(28, 'RKB-2026-07-12-K3.2.8-NEUFASSUNG-V1', '2026-07-12 16:29:55', 'section', '3.2.8', '1.0', 'Neufassung von Abschnitt 3.2.8 mit den Quellen [37], [39], [40], [43] und [44] sowie den Gleichungen (3.35) bis (3.40).', 'Olaf Thiele / ChatGPT', 27),
(29, 'RKB-2026-07-12-K3.2.9-NEUFASSUNG-V1', '2026-07-12 16:37:17', 'section', '3.2.9', '1.0', 'Neufassung von Abschnitt 3.2.9 mit den Quellen [45] und [46] sowie den Gleichungen (3.41) bis (3.45).', 'Olaf Thiele / ChatGPT', 28),
(30, 'RKB-2026-07-12-K3.2.10-NEUFASSUNG-V1', '2026-07-12 16:43:17', 'section', '3.2.10', '1.0', 'Neufassung von Abschnitt 3.2.10 mit den Quellen [15], [47] und [48] sowie den Gleichungen (3.46) bis (3.51).', 'Olaf Thiele / ChatGPT', 29),
(31, 'RKB-2026-07-12-K3.2.11-NEUFASSUNG-V1', '2026-07-12 16:51:53', 'section', '3.2.11', '1.0', 'Neufassung von Abschnitt 3.2.11 mit den Quellen [49] und [50] sowie den Gleichungen (3.52) bis (3.57).', 'Olaf Thiele / ChatGPT', 30),
(32, 'RKB-2026-07-12-K3.2.12-NEUFASSUNG-V1', '2026-07-12 17:00:31', 'section', '3.2.12', '1.0', 'Neufassung von Abschnitt 3.2.12 mit den Quellen [12], [14], [51] und [52] sowie den Gleichungen (3.58) bis (3.63).', 'Olaf Thiele / ChatGPT', 31),
(33, 'RKB-2026-07-12-K3.3.1-NEUFASSUNG-V1', '2026-07-12 17:06:50', 'section', '3.3.1', '1.0', 'Neufassung von Abschnitt 3.3.1 als Motivation der axiomatischen Rekonstruktion; keine neuen Quellen und keine neuen Gleichungen.', 'Olaf Thiele / ChatGPT', 32),
(34, 'RKB-2026-07-12-K3.3.2-NEUFASSUNG-V1', '2026-07-12 17:11:18', 'section', '3.3.2', '1.0', 'Neufassung von Abschnitt 3.3.2 zur wissenschaftstheoretischen Begründung der primitiven Begriffe; Wiederverwendung der Quellen [8], [18] und [24]; keine neuen Gleichungen oder Axiome.', 'Olaf Thiele / ChatGPT', 33),
(35, 'RKB-2026-07-12-K3.3.3-NEUFASSUNG-V1', '2026-07-12 17:16:06', 'section', '3.3.3', '1.0', 'Neufassung von Abschnitt 3.3.3; Aktualisierung von Axiom A1, Registrierung der formalen Gleichung (3.64) und explizite Verknüpfung zwischen Axiom und Gleichung.', 'Olaf Thiele / ChatGPT', 34),
(36, 'RKB-2026-07-12-K3.3.4-NEUFASSUNG-V1', '2026-07-12 17:19:50', 'section', '3.3.4', '1.0', 'Neufassung von Abschnitt 3.3.4; Aktualisierung von Axiom A2, Registrierung der formalen Gleichung (3.65) sowie der Abhängigkeit A2 von A1.', 'Olaf Thiele / ChatGPT', 35),
(37, 'RKB-2026-07-12-K3.3.5-NEUFASSUNG-V1', '2026-07-12 17:29:01', 'section', '3.3.5', '1.0', 'Neufassung von Abschnitt 3.3.5; Aktualisierung von Axiom A3, Registrierung der Gleichungen (3.66) und (3.67) sowie der Abhängigkeiten von A1 und A2.', 'Olaf Thiele / ChatGPT', 36),
(38, 'RKB-2026-07-12-K3.3.6-NEUFASSUNG-V1', '2026-07-12 17:50:14', 'section', '3.3.6', '1.0', 'Neufassung von Abschnitt 3.3.6; Aktualisierung von Axiom A4, Registrierung der Gleichungen (3.68) und (3.69) sowie der Abhängigkeiten von A1 bis A3.', 'Olaf Thiele / ChatGPT', 37),
(40, 'RKB-2026-07-12-K3.3.7-NEUFASSUNG-V1', '2026-07-12 17:50:39', 'section', '3.3.7', '1.0', 'Neufassung von Abschnitt 3.3.7; Aktualisierung von Axiom A5, Registrierung der Gleichungen (3.70) und (3.71) sowie der Abhängigkeiten von A1 bis A4.', 'Olaf Thiele / ChatGPT', 38),
(41, 'RKB-2026-07-12-K3.3.8-NEUFASSUNG-V1', '2026-07-12 17:54:48', 'section', '3.3.8', '1.0', 'Neufassung von Abschnitt 3.3.8 als Zusammenfassung der fünf gleichrangig angenommenen FRZK-Grundaxiome; Registrierung der Systemgleichung (3.72).', 'Olaf Thiele / ChatGPT', 40),
(42, 'RKB-2026-07-12-K3.3.9-NEUFASSUNG-V1', '2026-07-12 18:06:45', 'section', '3.3.9', '1.0', 'Neufassung von Abschnitt 3.3.9 mit Proposition Prop. 3.1 und Gleichung (3.73).', 'Olaf Thiele / ChatGPT', 41),
(44, 'RKB-2026-07-12-K3.3.10-NEUFASSUNG-V2', '2026-07-12 18:17:33', 'section', '3.3.10', '2.0', 'Korrigierte Neufassung von Abschnitt 3.3.10; der fehlende Abschnitt wird vor allen abhängigen Einträgen angelegt.', 'Olaf Thiele / ChatGPT', 42),
(45, 'RKB-2026-07-12-K3.4.1-NEUFASSUNG-V1', '2026-07-12 18:43:58', 'section', '3.4.1', '1.0', 'Neufassung von Abschnitt 3.4.1 als Konstruktion funktionaler Zustände mit Def. 3.4.1, Def. 3.4.2 sowie den Gleichungen (3.74) und (3.75).', 'Olaf Thiele / ChatGPT', 44),
(46, 'RKB-2026-07-12-K3.4.2-NEUFASSUNG-V2', '2026-07-12 18:50:15', 'section', '3.4.2', '2.0', 'Korrigierte Neufassung von Abschnitt 3.4.2 als Konstruktion funktionaler Relationen mit Def. 3.4.3, Def. 3.4.4 und den Gleichungen (3.76) bis (3.78).', 'Olaf Thiele / ChatGPT', 45),
(47, 'RKB-2026-07-12-K3.4.3-NEUFASSUNG-V1', '2026-07-12 18:50:30', 'section', '3.4.3', '1.0', 'Neufassung von Abschnitt 3.4.3 mit Def. 3.4.5, Def. 3.4.6, Satz 3.4.3 sowie den Gleichungen (3.79) bis (3.81).', 'Olaf Thiele / ChatGPT', 46),
(48, 'RKB-2026-07-12-K3.4.4-NEUFASSUNG-V1', '2026-07-12 19:12:40', 'section', '3.4.4', '1.0', 'Neufassung von Abschnitt 3.4.4 mit Def. 3.4.7, Def. 3.4.8, Satz 3.4.4 sowie den Gleichungen (3.82) bis (3.85).', 'Olaf Thiele / ChatGPT', 47),
(49, 'RKB-2026-07-12-K3.4.5-NEUFASSUNG-V1', '2026-07-13 11:15:16', 'section', '3.4.5', '1.0', 'Neufassung von Abschnitt 3.4.5 mit Def. 3.4.9, Def. 3.4.10, Lemma 3.4.3, Satz 3.4.5 sowie den Gleichungen (3.86) bis (3.89).', 'Olaf Thiele / ChatGPT', 48),
(50, 'RKB-2026-07-12-K3.4.6-NEUFASSUNG-V1', '2026-07-13 11:43:31', 'section', '3.4.6', '1.0', 'Neufassung von Abschnitt 3.4.6 mit Def. 3.4.11, Def. 3.4.12, Lemma 3.4.4, Satz 3.4.6 sowie den Gleichungen (3.90) bis (3.93).', 'Olaf Thiele / ChatGPT', 49),
(51, 'RKB-2026-07-13-K3.4.7-NEUFASSUNG-V1', '2026-07-13 12:11:31', 'section', '3.4.7', '1.0', 'Neufassung von Abschnitt 3.4.7 mit Def. 3.4.13, Def. 3.4.14, Lemma 3.4.5, Satz 3.4.7 sowie den Gleichungen (3.94) bis (3.97).', 'Olaf Thiele / ChatGPT', 50),
(52, 'RKB-2026-07-13-K3.4.8-NEUFASSUNG-V1', '2026-07-13 13:00:23', 'section', '3.4.8', '1.0', 'Neufassung von Abschnitt 3.4.8 mit Def. 3.4.15, Def. 3.4.16, Lemma 3.4.6, Satz 3.4.8 sowie den Gleichungen (3.98) bis (3.101).', 'Olaf Thiele / ChatGPT', 51);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `repository_validation_results`
--

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

--
-- Daten für Tabelle `repository_validation_results`
--

INSERT INTO `repository_validation_results` (`validation_result_id`, `revision_id`, `validation_code`, `validation_status`, `expected_value`, `actual_value`, `validation_message`, `checked_at`) VALUES
(1, 6, 'K3_2_EQUATION_COUNT', 'passed', '84', '84', 'Anzahl der Gleichungen im Bereich (3.3) bis (3.86).', '2026-07-12 06:10:58'),
(2, 6, 'K3_2_NEW_SOURCE_COUNT', 'passed', '30', '30', 'Anzahl der neuen deduplizierten Quellen [23] bis [52].', '2026-07-12 06:10:58'),
(3, 6, 'K3_2_DEFINITION_COUNT', 'passed', '25', '25', 'Anzahl der registrierten Definitionen für Kapitel 3.2.', '2026-07-12 06:10:58'),
(4, 6, 'K3_2_ASSUMPTION_COUNT', 'passed', '5', '5', 'Anzahl der aus 3.2.13 abgeleiteten Anforderungen.', '2026-07-12 06:10:58'),
(5, 6, 'K3_2_MISSING_ANNOTATIONS', 'passed', '0', '0', 'Neue Quellen ohne Annotation.', '2026-07-12 06:10:58'),
(6, 6, 'GLOBAL_DUPLICATE_CITATION_NUMBERS', 'passed', '0', '0', 'Doppelte feste Literaturnummern im Repository.', '2026-07-12 06:10:58'),
(7, 9, 'K3_3_EQUATION_COUNT', 'passed', '29', '29', 'Anzahl der Gleichungen (3.87) bis (3.115).', '2026-07-12 06:12:55'),
(8, 9, 'K3_3_AXIOM_COUNT', 'passed', '5', '5', 'Anzahl der FRZK-Axiome A1 bis A5.', '2026-07-12 06:12:55'),
(9, 9, 'K3_3_PROPOSITION_COUNT', 'passed', '5', '5', 'Anzahl der logischen Propositionen in 3.3.6.', '2026-07-12 06:12:55'),
(10, 9, 'K3_3_NEW_SOURCE_COUNT', 'passed', '0', '0', 'Kapitel 3.3 soll keine neue Literaturnummer anlegen.', '2026-07-12 06:12:55'),
(11, 9, 'K3_3_AXIOM_ASSUMPTION_LINKS', 'passed', '5', '5', 'Jedes Axiom muss mit genau einer Anforderung aus 3.2.13 verknüpft sein.', '2026-07-12 06:12:55'),
(12, 10, 'K3_3_NEW_EQUATION_COUNT', 'passed', '13', '13', 'Anzahl der Gleichungen (3.87) bis (3.99).', '2026-07-12 08:36:48'),
(13, 10, 'K3_3_OBSOLETE_EQUATIONS', 'passed', '0', '0', 'Alte Gleichungen (3.100) bis (3.115) dürfen nach der Neufassung nicht mehr vorhanden sein.', '2026-07-12 08:36:48'),
(14, 10, 'K3_3_AXIOM_COUNT', 'passed', '5', '5', 'Anzahl der aktualisierten Axiome A1 bis A5.', '2026-07-12 08:36:48'),
(15, 10, 'K3_3_PROPOSITION_COUNT', 'passed', '5', '5', 'Anzahl der aktualisierten Propositionen.', '2026-07-12 08:36:48'),
(16, 10, 'K3_3_NEW_SOURCE_COUNT', 'passed', '0', '0', 'Die Neufassung von Kapitel 3.3 führt keine neue Literaturquelle ein.', '2026-07-12 08:36:48'),
(24, 11, 'K3_4_EQUATION_COUNT', 'passed', '49', '49', 'Anzahl der Gleichungen (3.100) bis (3.148).', '2026-07-12 08:40:27'),
(25, 11, 'K3_4_DEFINITION_COUNT', 'passed', '17', '17', 'Anzahl der Definitionen in Kapitel 3.4.', '2026-07-12 08:40:27'),
(26, 11, 'K3_4_LEMMA_COUNT', 'passed', '16', '16', 'Anzahl der Lemmata in Kapitel 3.4.', '2026-07-12 08:40:27'),
(27, 11, 'K3_4_THEOREM_COUNT', 'passed', '8', '8', 'Anzahl der Sätze in Kapitel 3.4.', '2026-07-12 08:40:27'),
(28, 11, 'K3_4_COROLLARY_COUNT', 'passed', '7', '7', 'Anzahl der Korollare in Kapitel 3.4.', '2026-07-12 08:40:27'),
(29, 11, 'K3_4_PROOF_COUNT', 'passed', '31', '31', 'Anzahl der Beweisdatensätze in Kapitel 3.4.', '2026-07-12 08:40:27'),
(30, 11, 'K3_4_NEW_SOURCE_COUNT', 'passed', '0', '0', 'Kapitel 3.4 führt in der aktuellen Fassung keine neue Literaturquelle ein.', '2026-07-12 08:40:27'),
(31, 13, 'SOURCE_NUMBER_RANGE', 'passed', '52 eindeutige Nummern [1] bis [52]', 'Anzahl=52; eindeutig=52; min=1; max=52', 'Prüft Vollständigkeit, Eindeutigkeit und Lückenfreiheit der Literaturnummern.', '2026-07-12 11:14:28'),
(32, 13, 'SOURCE_ANNOTATION_COUNT', 'passed', '52 Annotationen', '52', 'Jede der 52 Quellen muss genau eine Annotation besitzen.', '2026-07-12 11:14:28'),
(33, 13, 'EQUATION_NUMBER_RANGE', 'passed', '148 eindeutige Gleichungen (3.1) bis (3.148)', 'Anzahl=148; eindeutig=148; min=1; max=148', 'Prüft den vollständigen Gleichungsnummernbereich bis Kapitel 3.4.', '2026-07-12 11:14:28'),
(34, 13, 'EQUATION_WORD_LATEX', 'passed', '0 fehlende Word-LaTeX-Einträge', '0', 'Jede Gleichung muss eine Word-kompatible LaTeX-Darstellung besitzen.', '2026-07-12 11:14:28'),
(35, 13, 'EQUATION_REVISION_LINKS', 'passed', '0 Gleichungen ohne gültige Revision', '0', 'Prüft die Revisionsverknüpfung aller Gleichungen.', '2026-07-12 11:14:28'),
(36, 13, 'K3_4_SECTION_COUNT', 'passed', '12 Datensätze: 3.4 sowie 3.4.0 bis 3.4.10', '12', 'Prüft die vollständige Abschnittsstruktur von Kapitel 3.4.', '2026-07-12 11:14:28'),
(37, 13, 'K3_4_DEFINITION_COUNT', 'passed', '17 Definitionen', '17', 'Prüft die registrierten Definitionen von Kapitel 3.4.', '2026-07-12 11:14:28'),
(38, 13, 'K3_4_LEMMA_COUNT', 'passed', '16 Lemmata', '16', 'Prüft die registrierten Lemmata von Kapitel 3.4.', '2026-07-12 11:14:28'),
(39, 13, 'K3_4_THEOREM_COUNT', 'passed', '8 Sätze', '8', 'Prüft die registrierten Sätze von Kapitel 3.4.', '2026-07-12 11:14:28'),
(40, 13, 'K3_4_COROLLARY_COUNT', 'passed', '7 Korollare', '7', 'Prüft die registrierten Korollare von Kapitel 3.4.', '2026-07-12 11:14:28'),
(41, 13, 'K3_4_PROOF_COUNT', 'passed', '31 Beweisdatensätze', '31', 'Prüft die Anzahl der registrierten Beweisdatensätze.', '2026-07-12 11:14:28'),
(42, 13, 'K3_4_PROOF_STATUS', 'passed', 'Alle 31 Beweise im Status draft bis zur mathematischen Endprüfung', 'gesamt=31; draft=31', 'Der Status draft ist beabsichtigt; die formale mathematische Prüfung steht noch aus.', '2026-07-12 11:14:28'),
(43, 13, 'ORPHAN_SOURCE_USAGE', 'passed', '0 verwaiste Quellenverwendungen', '0', 'Prüft, ob jede Quellenverwendung eine vorhandene Quelle und einen vorhandenen Abschnitt besitzt.', '2026-07-12 11:14:28'),
(44, 13, 'ORPHAN_EQUATION_SECTION', 'passed', '0 Gleichungen ohne Abschnitt', '0', 'Prüft die Abschnittszuordnung aller Gleichungen.', '2026-07-12 11:14:28'),
(45, 13, 'SOURCE_AUTHOR_COVERAGE', 'warning', 'Alle Quellen besitzen strukturierte Autorenzuordnungen', '22 von 52 Quellen', 'Fehlende strukturierte Autorenzuordnungen beeinträchtigen nicht die feste Literaturzählung, sollten aber später ergänzt werden.', '2026-07-12 11:14:28');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `section_change_log`
--

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

--
-- Daten für Tabelle `section_change_log`
--

INSERT INTO `section_change_log` (`change_id`, `revision_id`, `section_id`, `change_type`, `object_type`, `object_reference`, `change_summary`, `previous_value`, `new_value`, `changed_at`) VALUES
(1, 3, 1, 'acronym_added', 'acronym', 'FRZK', 'FRZK in das globale Abkürzungsverzeichnis aufgenommen.', NULL, NULL, '2026-07-12 06:09:36'),
(2, 3, 4, 'definition_added', 'definition', 'Def. 3.1.1', 'Erste repositoryweite Definition registriert.', NULL, NULL, '2026-07-12 06:09:36'),
(3, 3, 6, 'symbol_added', 'symbol', '\\longrightarrow', 'Gerichteten Entwicklungspfeil in das Symbolverzeichnis aufgenommen.', NULL, NULL, '2026-07-12 06:09:36'),
(4, 6, 7, 'source_added', 'sources', '[23]–[52]', '30 neue, deduplizierte Literaturquellen und drei Wiederverwendungen aufgenommen.', NULL, NULL, '2026-07-12 06:10:58'),
(5, 6, 7, 'equation_added', 'equations', '(3.3)–(3.86)', '84 Gleichungen einschließlich Word-LaTeX und Quellenzuordnung registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(6, 6, 7, 'definition_added', 'definitions', 'Def. 3.2.1–Def. 3.2.25', '25 mathematische Definitionen registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(7, 6, 21, 'assumption_added', 'assumptions', 'A-3.2-1–A-3.2-5', 'Fünf Anforderungen aus der Forschungslücke abgeleitet.', NULL, NULL, '2026-07-12 06:10:58'),
(8, 6, 7, 'symbol_added', 'symbols', 'Symbolverzeichnis 3.2', 'Zentrale mathematische Symbole aus Kapitel 3.2 registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(9, 6, 7, 'figure_added', 'figures', 'Abb. 3.1–Abb. 3.8', 'Acht geplante Abbildungen registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(10, 6, 7, 'table_added', 'tables', 'Tab. 3.1–Tab. 3.5', 'Fünf geplante Tabellen registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(11, 6, 7, 'renumbered', 'citations', 'Dublettenbereinigung', 'Barabási, Haken und Holland werden mit [15], [12] und [14] wiederverwendet; die nachfolgenden neuen Quellen wurden auf [49]–[52] korrigiert.', NULL, NULL, '2026-07-12 06:10:58'),
(12, 6, 7, 'status_changed', 'section', '3.2', 'Kapitel 3.2 auf Status review gesetzt.', NULL, NULL, '2026-07-12 06:10:58'),
(13, 9, 22, 'axiom_added', 'axioms', 'A1–A5', 'Fünf FRZK-Axiome auf Status review registriert.', NULL, NULL, '2026-07-12 06:12:55'),
(14, 9, 22, 'equation_added', 'equations', '(3.87)–(3.115)', '29 Gleichungen einschließlich Word-LaTeX registriert.', NULL, NULL, '2026-07-12 06:12:55'),
(15, 9, 55, 'statement_added', 'propositions', 'Prop. 3.1–Prop. 3.5', 'Fünf logische Propositionen anstelle vorgezogener mathematischer Sätze registriert.', NULL, NULL, '2026-07-12 06:12:55'),
(16, 9, 22, 'source_reused', 'sources', 'bestehende Literatur', 'Kapitel 3.3 verwendet ausschließlich bereits nummerierte Literaturquellen.', NULL, NULL, '2026-07-12 06:12:55'),
(17, 9, 22, 'symbol_added', 'symbols', 'Symbolverzeichnis 3.3', 'Zentrale FRZK-Symbole registriert.', NULL, NULL, '2026-07-12 06:12:55'),
(18, 9, 22, 'status_changed', 'section', '3.3', 'Kapitel 3.3 auf Status review gesetzt.', NULL, NULL, '2026-07-12 06:12:55'),
(19, 10, 22, 'rewritten', 'chapter', '3.3', 'Kapitel 3.3 vollständig als prämathematisches Axiomenkapitel neu strukturiert.', 'Mathematische Axiome mit vorweggenommenen Mengen-, Operator-, Zustandsraum- und Kohärenzstrukturen.', 'Axiomatische Grundlagen mit primitiven Begriffen und qualitativen Organisationsprinzipien.', '2026-07-12 08:36:48'),
(20, 10, 22, 'renumbered', 'equations', '(3.87)–(3.99)', 'Alte 29 Gleichungen durch 13 neue Gleichungen ersetzt; nächste freie Gleichung ist (3.100).', '(3.87)–(3.115)', '(3.87)–(3.99)', '2026-07-12 08:36:48'),
(21, 10, 22, 'axiom_added', 'axioms', 'A1–A5', 'Fünf Axiome in ihrer abgeschwächten, nichtzirkulären Neufassung registriert.', NULL, NULL, '2026-07-12 08:36:48'),
(22, 10, 58, 'proposition_added', 'propositions', 'Prop. 3.1–Prop. 3.5', 'Fünf logische Propositionen an die Neufassung angepasst.', NULL, NULL, '2026-07-12 08:36:48'),
(23, 10, 22, 'source_reused', 'literature', '[7], [8], [18], [24]', 'Bestehende Literatur wird wiederverwendet; keine neue Literaturnummer erforderlich.', NULL, NULL, '2026-07-12 08:36:48'),
(24, 10, 22, 'symbol_added', 'symbols', 'Symbolverzeichnis 3.3', 'Prämathematische Symbole und ihre explizite Statusabgrenzung registriert.', NULL, NULL, '2026-07-12 08:36:48'),
(25, 10, 22, 'status_changed', 'section', '3.3', 'Kapitel 3.3 verbleibt bis zur Endprüfung auf Status review.', NULL, 'review', '2026-07-12 08:36:48'),
(36, 11, 23, 'created', 'chapter', '3.4', 'Kapitel 3.4 als vollständige mathematische Rekonstruktion funktionaler Organisation registriert.', NULL, '3.4.0 bis 3.4.10', '2026-07-12 08:40:27'),
(37, 11, 23, 'equation_added', 'equations', '(3.100)–(3.148)', '49 fortlaufend nummerierte Gleichungen registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(38, 11, 23, 'definition_added', 'definitions', 'Def. 3.4.1–Def. 3.4.17', '17 originäre Definitionen registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(39, 11, 23, 'statement_added', 'lemmas', 'Lemma 3.4.1–Lemma 3.4.16', '16 Lemmata registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(40, 11, 23, 'statement_added', 'theorems', 'Satz 3.4.1–Satz 3.4.8', '8 Sätze registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(41, 11, 23, 'statement_added', 'corollaries', 'Korollar 3.4.1–Korollar 3.4.7', '7 Korollare registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(42, 11, 23, 'proof_added', 'proofs', 'Bew. 3.4.1–Bew. 3.4.31', '31 Beweisdatensätze im Status draft registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(43, 11, 23, 'symbol_added', 'symbols', 'Symbolverzeichnis 3.4', '16 zentrale Symbole der mathematischen Rekonstruktion registriert.', NULL, NULL, '2026-07-12 08:40:27'),
(44, 11, 23, 'source_reused', 'literature', 'keine neue Quelle', 'Die nächste freie Literaturnummer bleibt [53].', NULL, '[53]', '2026-07-12 08:40:27'),
(45, 11, 23, 'status_changed', 'section', '3.4', 'Kapitel 3.4 auf Status review gesetzt.', NULL, 'review', '2026-07-12 08:40:27'),
(46, 13, 23, 'other', 'repository', 'Audit bis Kapitel 3.4', 'Schema-, Fremdschlüssel-, Nummerierungs- und Vollständigkeitsprüfung durchgeführt.', NULL, 'Repository-Version 4.1', '2026-07-12 11:14:28'),
(47, 14, 2, 'rewritten', 'section', '3.1.1', 'Abschnitt 3.1.1 wurde vollständig neu gefasst und auf die Forschungsfrage der funktionalen Genese von Raum und Zeit ausgerichtet.', 'Bisheriger Repository-Stand von Abschnitt 3.1.1.', 'Neufassung mit fortlaufenden Literaturangaben [1] bis [15]; keine neue Gleichung.', '2026-07-12 12:15:00'),
(48, 14, 2, 'source_reused', 'source_usage', '[1]-[15]', 'Die bestehenden Masterquellen [1] bis [15] wurden für Abschnitt 3.1.1 neu und vollständig registriert.', NULL, '15 Quellenverwendungen in source_usage.', '2026-07-12 12:15:00'),
(49, 14, 2, 'status_changed', 'section', '3.1.1', 'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.', 'final', 'review', '2026-07-12 12:15:00'),
(50, 15, 3, 'rewritten', 'section', '3.1.2', 'Abschnitt 3.1.2 wurde vollständig neu gefasst und als wissenschaftstheoretische Rekonstruktion der Entwicklung des Raum- und Zeitbegriffs ausgerichtet.', 'Bisheriger Repository-Stand von Abschnitt 3.1.2.', 'Neufassung mit wiederverwendeten Quellen [1] bis [11], Erstverwendung von [16] und ohne neue Gleichung.', '2026-07-12 12:18:38'),
(51, 15, 3, 'source_reused', 'source_usage', '[1]-[11]', 'Die bereits in Abschnitt 3.1.1 vollständig eingeführten Quellen [1] bis [11] wurden für die wissenschaftstheoretische Vergleichsanalyse erneut registriert.', NULL, '11 Wiederverwendungen in source_usage.', '2026-07-12 12:18:38'),
(52, 15, 3, 'source_added', 'source_usage', '[16]', 'Quelle [16] wurde erstmals in Abschnitt 3.1.2 verwendet.', NULL, '1 Erstverwendung in source_usage.', '2026-07-12 12:18:38'),
(53, 15, 3, 'status_changed', 'section', '3.1.2', 'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.', 'final', 'review', '2026-07-12 12:18:38'),
(54, 16, 4, 'rewritten', 'section', '3.1.3', 'Abschnitt 3.1.3 wurde vollständig neu gefasst und formuliert nun die methodischen Anforderungen an eine funktionale Theorie von Raum und Zeit.', 'Bisheriger Repository-Stand von Abschnitt 3.1.3.', 'Neufassung mit sieben registrierten Quellenverwendungen und ohne nummerierte Gleichung.', '2026-07-12 12:22:37'),
(55, 16, 4, 'source_reused', 'source_usage', '[8], [12]-[15]', 'Die bereits eingeführten Quellen wurden zur Begründung axiomatischer Minimalität und emergenter Strukturbildung erneut registriert.', NULL, '5 Wiederverwendungen in source_usage.', '2026-07-12 12:22:37'),
(56, 16, 4, 'source_added', 'source_usage', '[17]-[18]', 'Die Quellen [17] und [18] wurden erstmals in Abschnitt 3.1.3 verwendet.', NULL, '2 Erstverwendungen in source_usage.', '2026-07-12 12:22:37'),
(57, 16, 4, 'status_changed', 'section', '3.1.3', 'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.', 'final', 'review', '2026-07-12 12:22:37'),
(58, 18, 5, 'rewritten', 'section', '3.1.4', 'Abschnitt 3.1.4 wurde vollständig als Forschungsstand zur Emergenz von Raum und Zeit neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.1.4.', 'Neufassung mit sieben Quellenverwendungen und ohne nummerierte Gleichung.', '2026-07-12 12:37:33'),
(59, 18, 5, 'source_added', 'sources', '[53]–[57]', 'Fünf neue Quellen zur Schleifenquantengravitation, Causal-Set-Theorie, Verschränkungsgeometrie, Tensornetzwerken und emergenter Gravitation wurden ergänzt.', NULL, '5 neue Quellen', '2026-07-12 12:37:33'),
(60, 18, 5, 'source_reused', 'sources', '[19], [21]', 'Rovelli und Wheeler wurden mit ihren vorhandenen Repositorynummern wiederverwendet.', NULL, '2 wiederverwendete Quellen', '2026-07-12 12:37:33'),
(61, 18, 5, 'status_changed', 'section', '3.1.4', 'Abschnitt 3.1.4 wurde für die Endredaktion auf review gesetzt.', 'final', 'review', '2026-07-12 12:37:33'),
(62, 19, 6, 'rewritten', 'section', '3.1.5', 'Abschnitt 3.1.5 wurde als wissenschaftliche Einordnung und Abgrenzung des FRZK vollständig neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.1.5.', 'Neufassung mit dreizehn Quellenverwendungen und zwei aktualisierten Gleichungen.', '2026-07-12 12:37:46'),
(63, 19, 6, '', 'equation', '(3.1)', 'Die klassische Entwicklungsrichtung wurde präzisiert.', 'Axiome → Raum → Zeit → physikalische Dynamik', 'primitive Strukturen → mathematische Räume → Dynamik in diesen Räumen', '2026-07-12 12:37:46'),
(64, 19, 6, '', 'equation', '(3.2)', 'Die funktionale Entwicklungsrichtung des FRZK wurde präzisiert.', 'funktionale Axiome → rekursive Entwicklung → Kohärenz → Raum → Zeit', 'funktionale Grundprinzipien → Relationierung → rekursive Transformation → Kohärenz → Raum- und Zeitstrukturen', '2026-07-12 12:37:46'),
(65, 19, 6, 'status_changed', 'section', '3.1.5', 'Der Abschnitt wurde für die gemeinsame Endredaktion auf review gesetzt.', 'final', 'review', '2026-07-12 12:37:46'),
(66, 20, 8, 'rewritten', 'section', '3.2.0', 'Die Einleitung zu Kapitel 3.2 wurde vollständig neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.2.0.', 'Neufassung mit acht wiederverwendeten Quellen und ohne nummerierte Gleichung.', '2026-07-12 12:53:42'),
(67, 21, 9, 'rewritten', 'section', '3.2.1', 'Abschnitt 3.2.1 wurde vollständig neu gefasst.', 'Bisherige Fassung mit vier Quellen [23]–[26] und sechs Gleichungen (3.3)–(3.8).', 'Neufassung mit den Quellen [23] und [58] sowie ausschließlich Gleichung (3.3).', '2026-07-12 12:53:53'),
(68, 21, 9, 'source_added', 'source', '[58]', 'Fraenkel, Bar-Hillel und Levy wurden als neue Quelle zur axiomatischen Mengenlehre aufgenommen.', NULL, 'Foundations of Set Theory, 1973.', '2026-07-12 12:53:53'),
(69, 21, 9, 'source_reused', 'source', '[23]', 'Cantors Primärarbeit wird mit ihrer bestehenden Literaturnummer wiederverwendet.', NULL, 'Cantor [23].', '2026-07-12 12:53:53'),
(70, 21, 9, 'equation_changed', 'equation', '(3.3)', 'Gleichung (3.3) wurde an die Neufassung angepasst.', 'M=\\{x\\mid x\\ \\text{erfüllt Eigenschaft}\\ P\\}', 'M=\\{x_1,x_2,\\ldots,x_n\\}', '2026-07-12 12:53:53'),
(71, 21, 9, 'other', 'equations', '(3.4)–(3.8)', 'Die in der Neufassung nicht mehr verwendeten Gleichungen wurden einschließlich ihrer Symbol- und Abhängigkeitszuordnungen entfernt.', '(3.4)–(3.8) waren dem Abschnitt 3.2.1 zugeordnet.', 'Keine entsprechenden Gleichungen mehr in Abschnitt 3.2.1.', '2026-07-12 12:53:53'),
(72, 21, 9, 'status_changed', 'section', '3.2.1', 'Der Abschnitt verbleibt bis zur Endredaktion im Status review.', 'review', 'review', '2026-07-12 12:53:53'),
(73, 22, 10, 'rewritten', 'section', '3.2.2', 'Abschnitt 3.2.2 wurde vollständig neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.2.2.', 'Neufassung mit zwei Quellenverwendungen und sechs Gleichungen.', '2026-07-12 13:10:09'),
(74, 22, 10, 'source_reused', 'sources', '[27], [28]', 'Die bestehenden Quellen Enderton sowie Davey und Priestley wurden erneut verwendet.', NULL, '2 Quellenverwendungen', '2026-07-12 13:10:09'),
(75, 22, 10, 'equation_changed', 'equations', '(3.4)–(3.9)', 'Die Relationsdefinitionen und Relationseigenschaften wurden neu geordnet und inhaltlich aktualisiert.', 'Bisherige Gleichungsfassungen des Repository.', 'Relation, Relation auf einer Menge, Relationsnotation, Reflexivität, Symmetrie und Transitivität.', '2026-07-12 13:10:09'),
(76, 23, 11, 'rewritten', 'section', '3.2.3', 'Abschnitt 3.2.3 wurde vollständig neu gefasst.', 'Bisherige Fassung mit älterer Gleichungsnummerierung.', 'Neufassung mit den bestehenden Quellen [29] und [30] sowie den Gleichungen (3.10) bis (3.13).', '2026-07-12 13:25:46'),
(77, 23, 11, 'source_reused', 'sources', '[29], [30]', 'Die vorhandenen Quellen von Lang und Rudin wurden wiederverwendet.', NULL, '2 Quellenverwendungen', '2026-07-12 13:25:46'),
(78, 23, 11, 'equation_changed', 'equations', '(3.10)–(3.13)', 'Die Gleichungsnummern wurden bereinigt und mit den Funktionsdefinitionen der Neufassung neu belegt.', 'Ältere Relations- und Funktionsgleichungen unter denselben Nummern.', 'Funktion, eindeutige Zuordnung, Komposition und iterative Entwicklung.', '2026-07-12 13:25:46'),
(79, 24, 12, 'rewritten', 'section', '3.2.4', 'Abschnitt 3.2.4 wurde vollständig neu gefasst.', 'Bisherige Fassung mit älterer Gleichungsnummerierung.', 'Neufassung mit den Quellen [31] bis [34] und den Gleichungen (3.14) bis (3.18).', '2026-07-12 13:26:40'),
(80, 24, 12, 'source_reused', 'sources', '[31]–[34]', 'Die bereits vorhandenen algebraischen Standardwerke wurden wiederverwendet.', NULL, '4 Quellenverwendungen', '2026-07-12 13:26:40'),
(81, 24, 12, 'equation_changed', 'equations', '(3.14)–(3.18)', 'Die Gleichungsnummern wurden bereinigt und mit den algebraischen Definitionen der Neufassung neu belegt.', 'Ältere Relations- und Funktionsgleichungen unter denselben Nummern.', 'Innere Verknüpfung, Abgeschlossenheit, Assoziativität, neutrales Element und inverses Element.', '2026-07-12 13:26:40'),
(82, 25, 13, 'rewritten', 'section', '3.2.5', 'Abschnitt 3.2.5 wurde vollständig neu gefasst.', 'Bisherige Fassung mit den Gleichungen (3.31) bis (3.36).', 'Neufassung mit den Quellen [35] bis [37] und den Gleichungen (3.19) bis (3.24).', '2026-07-12 13:49:54'),
(83, 25, 13, 'source_reused', 'sources', '[35]–[37]', 'Die bestehenden Quellen Conway, Kreyszig und Strogatz wurden in ihrer ersten Textnennung registriert.', NULL, '3 Quellenverwendungen', '2026-07-12 13:49:54'),
(84, 25, 13, 'equation_changed', 'equations', '(3.19)–(3.24)', 'Die Operatorgleichungen wurden neu nummeriert und inhaltlich an die Neufassung angepasst.', 'Ältere Gleichungsbelegungen und die bisherige Nummerierung (3.31) bis (3.36).', 'Operator, Operatorwirkung, Linearität, Nichtlinearität, Komposition und Iteration.', '2026-07-12 13:49:54'),
(85, 27, 15, 'rewritten', 'section', '3.2.7', 'Abschnitt 3.2.7 wurde vollständig neu gefasst.', 'Bisherige Fassung mit den Gleichungen (3.44) bis (3.50).', 'Neufassung mit den Quellen [35], [36], [41], [42] und den Gleichungen (3.29) bis (3.34).', '2026-07-12 14:20:07'),
(86, 27, 15, 'source_reused', 'sources', '[35], [36], [41], [42]', 'Die vorhandenen funktionalanalytischen Quellen wurden registriert.', NULL, '4 Quellenverwendungen', '2026-07-12 14:20:07'),
(87, 27, 15, 'equation_changed', 'equations', '(3.29)–(3.34)', 'Die Gleichungen der Funktionalanalysis wurden neu nummeriert und inhaltlich verdichtet.', 'Bisherige Gleichungen (3.44) bis (3.50).', 'Funktionenraum, punktweise Operationen, Norm, Cauchy-Bedingung und induzierte Norm.', '2026-07-12 14:20:07'),
(88, 28, 16, 'rewritten', 'section', '3.2.8', 'Abschnitt 3.2.8 wurde vollständig neu gefasst.', 'Bisherige Fassung mit älterer Gleichungsnummerierung.', 'Neufassung mit den Quellen [37], [39], [40], [43], [44] und den Gleichungen (3.35) bis (3.40).', '2026-07-12 14:29:55'),
(89, 28, 16, 'source_reused', 'sources', '[37], [39], [40], [43], [44]', 'Die vorhandenen Quellen zur Dynamik, Stabilität und Chaostheorie wurden registriert.', NULL, '5 Quellenverwendungen', '2026-07-12 14:29:55'),
(90, 28, 16, 'equation_changed', 'equations', '(3.35)–(3.40)', 'Die Gleichungen dynamischer Systeme wurden neu nummeriert und inhaltlich präzisiert.', 'Ältere Gleichungsbelegungen.', 'Kontinuierliche und diskrete Dynamik, Fixpunkt, Jacobi-Matrix, Attraktor und Lyapunov-Entwicklung.', '2026-07-12 14:29:55'),
(91, 29, 17, 'rewritten', 'section', '3.2.9', 'Abschnitt 3.2.9 wurde als informationstheoretischer Grundlagenabschnitt vollständig neu gefasst.', 'Bisherige Fassung mit den Gleichungen (3.58) bis (3.62).', 'Neufassung mit den Quellen [45] und [46] und den Gleichungen (3.41) bis (3.45).', '2026-07-12 14:37:17'),
(92, 29, 17, 'source_reused', 'sources', '[45], [46]', 'Die bestehenden Quellen Cover/Thomas und Shannon wurden als Erstnennungen des Abschnitts registriert.', NULL, '2 Quellenverwendungen', '2026-07-12 14:37:17'),
(93, 29, 17, 'equation_changed', 'equations', '(3.41)–(3.45)', 'Die informationstheoretischen Gleichungen wurden neu nummeriert und an die Neufassung angepasst.', 'Bisherige Gleichungen (3.58) bis (3.62).', 'Informationsgehalt, Shannon-Entropie, gemeinsame Entropie, gegenseitige Information und Kullback-Leibler-Divergenz.', '2026-07-12 14:37:17'),
(94, 30, 18, 'rewritten', 'section', '3.2.10', 'Abschnitt 3.2.10 wurde vollständig neu gefasst.', 'Bisherige Fassung mit älterer Gleichungsnummerierung.', 'Neufassung mit den Quellen [15], [47], [48] und den Gleichungen (3.46) bis (3.51).', '2026-07-12 14:43:18'),
(95, 30, 18, 'source_reused', 'sources', '[15], [47], [48]', 'Die vorhandenen Quellen zur Graphen- und Netzwerktheorie wurden registriert.', NULL, '3 Quellenverwendungen', '2026-07-12 14:43:18'),
(96, 30, 18, 'equation_changed', 'equations', '(3.46)–(3.51)', 'Die graphen- und netzwerktheoretischen Gleichungen wurden neu nummeriert und inhaltlich präzisiert.', 'Ältere Gleichungsbelegungen.', 'Graph, Adjazenzmatrix, Knotengrad, Pfad, Netzwerkdichte und Clusterkoeffizient.', '2026-07-12 14:43:18'),
(97, 31, 19, 'rewritten', 'section', '3.2.11', 'Abschnitt 3.2.11 wurde vollständig neu gefasst.', 'Bisherige Fassung mit älterer Gleichungsnummerierung.', 'Neufassung mit den Quellen [49] und [50] und den Gleichungen (3.52) bis (3.57).', '2026-07-12 14:51:53'),
(98, 31, 19, 'source_reused', 'sources', '[49], [50]', 'Die vorhandenen Quellen zur metrischen Geometrie und zur Kosinusähnlichkeit wurden als Erstnennungen registriert.', NULL, '2 Quellenverwendungen', '2026-07-12 14:51:53'),
(99, 31, 19, 'equation_changed', 'equations', '(3.52)–(3.57)', 'Die Gleichungen zu Metriken und Ähnlichkeitsmaßen wurden neu nummeriert und inhaltlich präzisiert.', 'Ältere Gleichungsbelegungen.', 'Metrik, Metrikaxiome, euklidische Distanz und Kosinusähnlichkeit.', '2026-07-12 14:51:53'),
(100, 32, 20, 'rewritten', 'section', '3.2.12', 'Abschnitt 3.2.12 wurde vollständig neu gefasst.', 'Bisherige Fassung mit den Gleichungen (3.79) bis (3.82).', 'Neufassung mit den Quellen [12], [14], [51], [52] und den Gleichungen (3.58) bis (3.63).', '2026-07-12 15:00:31'),
(101, 32, 20, 'source_reused', 'sources', '[12], [14], [51], [52]', 'Die vorhandenen Quellen zu Emergenz, Selbstorganisation und Komplexität wurden registriert.', NULL, '4 Quellenverwendungen', '2026-07-12 15:00:31'),
(102, 32, 20, 'equation_changed', 'equations', '(3.58)–(3.63)', 'Die Gleichungen zur Selbstorganisation wurden neu nummeriert und inhaltlich erweitert.', 'Bisherige Gleichungen (3.79) bis (3.82).', 'Lokale Aktualisierung, Kopplung, Rekursion, Ordnungsparameter, Rückkopplung und Attraktordynamik.', '2026-07-12 15:00:31'),
(103, 33, 50, 'rewritten', 'section', '3.3.1', 'Abschnitt 3.3.1 wurde vollständig als Motivation einer axiomatischen Rekonstruktion neu gefasst.', 'Primitive Begriffe und axiomatische Ausgangspunkte; ältere Quellenverwendungen und gegebenenfalls ältere Gleichungszuordnungen.', 'Motivation einer axiomatischen Rekonstruktion; keine Quellenverwendung und keine nummerierte Gleichung.', '2026-07-12 15:06:50'),
(104, 33, 50, 'status_changed', 'section', '3.3.1', 'Der Abschnitt wurde für die laufende Endredaktion auf den Status review gesetzt.', 'review', 'review', '2026-07-12 15:06:50'),
(105, 33, 50, 'other', 'repository', 'Quellen- und Gleichungsbereinigung 3.3.1', 'Nicht mehr zur Neufassung gehörende Quellenverwendungen und Gleichungszuordnungen wurden entfernt.', 'Ältere Repository-Zuordnungen zu Abschnitt 3.3.1.', '0 Quellenverwendungen und 0 Gleichungen in Abschnitt 3.3.1.', '2026-07-12 15:06:50'),
(106, 34, 51, 'rewritten', 'section', '3.3.2', 'Abschnitt 3.3.2 wurde vollständig als wissenschaftstheoretische Begründung der primitiven Begriffe neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.2.', 'Neufassung mit den Quellen [8], [18] und [24], ohne nummerierte Gleichung und ohne Axiom.', '2026-07-12 15:11:18'),
(107, 34, 51, 'source_reused', 'sources', '[8], [18], [24]', 'Drei vorhandene Grundlagenquellen wurden für die methodische Begründung der primitiven Begriffe registriert.', NULL, '3 Quellenverwendungen', '2026-07-12 15:11:18'),
(108, 34, 51, 'other', 'repository', 'Bereinigung 3.3.2', 'Nicht mehr zur Neufassung gehörende Gleichungen und Axiome wurden aus Abschnitt 3.3.2 entfernt.', 'Mögliche ältere Zuordnungen.', '0 Gleichungen und 0 Axiome in Abschnitt 3.3.2.', '2026-07-12 15:11:18'),
(109, 35, 52, 'rewritten', 'section', '3.3.3', 'Abschnitt 3.3.3 wurde vollständig als Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.3.', 'Neufassung mit Axiom A1 und Gleichung (3.64).', '2026-07-12 15:16:07'),
(110, 35, 52, 'axiom_added', 'axiom', 'A1', 'Axiom A1 wurde in seiner neuen, nichtzirkulären Fassung aktualisiert.', '\\exists\\,\\Delta_F', '\\exists\\,a,b:\\;a\\not\\equiv_F b', '2026-07-12 15:16:07'),
(111, 35, 52, 'equation_added', 'equation', '(3.64)', 'Die formale Darstellung von Axiom A1 wurde unter der fortlaufenden Gleichungsnummer (3.64) registriert.', 'Frühere graphentheoretische Belegung von (3.64).', '\\exists\\,a,b:\\;a\\not\\equiv_F b', '2026-07-12 15:16:07'),
(112, 35, 52, 'other', 'object_dependency', 'A1 ↔ (3.64)', 'Axiom A1 und Gleichung (3.64) wurden über object_dependencies explizit miteinander verknüpft.', NULL, 'equation derives_from axiom', '2026-07-12 15:16:07'),
(113, 36, 53, 'rewritten', 'section', '3.3.4', 'Abschnitt 3.3.4 wurde vollständig als Axiom A2 – Prinzip der funktionalen Relationierbarkeit neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.4.', 'Neufassung mit Axiom A2 und Gleichung (3.65).', '2026-07-12 15:19:51'),
(114, 36, 53, 'axiom_added', 'axiom', 'A2', 'Axiom A2 wurde in einer prämathematischen, nichtmengentheoretischen Fassung aktualisiert.', '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F', '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)', '2026-07-12 15:19:51'),
(115, 36, 53, 'equation_added', 'equation', '(3.65)', 'Die formale Darstellung von Axiom A2 wurde unter der fortlaufenden Gleichungsnummer (3.65) registriert.', 'Frühere Belegung der Gleichungsnummer (3.65).', '(a\\not\\equiv_F b)\\Longrightarrow\\Diamond\\!\\left(a\\,\\mathcal{R}_F\\,b\\right)', '2026-07-12 15:19:51'),
(116, 36, 53, '', 'axiom_dependency', 'A2 -> A1', 'Die logische Abhängigkeit von Axiom A2 von Axiom A1 wurde explizit registriert.', NULL, 'A2 depends_on A1', '2026-07-12 15:19:51'),
(117, 37, 54, 'rewritten', 'section', '3.3.5', 'Abschnitt 3.3.5 wurde vollständig als Axiom A3 – Prinzip der rekursiven Transformation neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.5.', 'Neufassung mit Axiom A3 sowie den Gleichungen (3.66) und (3.67).', '2026-07-12 15:29:02'),
(118, 37, 54, 'axiom_added', 'axiom', 'A3', 'Axiom A3 wurde als Prinzip rekursiver funktionaler Hervorbringung aktualisiert.', '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F', '\\left(a\\,\\mathcal{R}_F\\,b\\right)\\Longrightarrow\\Diamond\\!\\left(c\\right),\\qquad c\\,\\mathcal{R}_F\\,(\\cdot)', '2026-07-12 15:29:02'),
(119, 37, 54, 'equation_added', 'equation', '(3.66), (3.67)', 'Die formale Axiomdarstellung und die strukturelle Axiomabhängigkeit wurden registriert.', 'Frühere Belegungen der Gleichungsnummern.', 'Rekursive Hervorbringung und A1/A2 als Voraussetzungen von A3.', '2026-07-12 15:29:02'),
(120, 37, 54, '', 'axiom_dependency', 'A3 -> A1, A2', 'Die strukturellen Abhängigkeiten von A3 von A1 und A2 wurden explizit registriert.', NULL, 'A3 depends_on A1; A3 depends_on A2', '2026-07-12 15:29:02'),
(125, 38, 55, 'rewritten', 'section', '3.3.6', 'Abschnitt 3.3.6 wurde vollständig als Axiom A4 – Prinzip stabiler funktionaler Organisation neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.6.', 'Neufassung mit Axiom A4 sowie den Gleichungen (3.68) und (3.69).', '2026-07-12 15:50:14'),
(126, 38, 55, 'axiom_added', 'axiom', 'A4', 'Axiom A4 wurde als Prinzip stabiler funktionaler Organisation aktualisiert.', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', '2026-07-12 15:50:14'),
(127, 38, 55, 'equation_added', 'equation', '(3.68), (3.69)', 'Die formale Axiomdarstellung und die strukturelle Axiomabhängigkeit wurden registriert.', 'Frühere Belegungen der Gleichungsnummern.', 'Stabile funktionale Organisation und A1 bis A3 als Voraussetzungen von A4.', '2026-07-12 15:50:14'),
(128, 38, 55, '', 'axiom_dependency', 'A4 -> A1, A2, A3', 'Die strukturellen Abhängigkeiten von A4 von A1 bis A3 wurden explizit registriert.', NULL, 'A4 depends_on A1; A4 depends_on A2; A4 depends_on A3', '2026-07-12 15:50:14'),
(129, 40, 56, 'rewritten', 'section', '3.3.7', 'Abschnitt 3.3.7 wurde vollständig als Axiom A5 – Prinzip reproduzierbarer Organisationsmuster neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.7.', 'Neufassung mit Axiom A5 sowie den Gleichungen (3.70) und (3.71).', '2026-07-12 15:50:40'),
(130, 40, 56, 'axiom_added', 'axiom', 'A5', 'Axiom A5 wurde als Prinzip reproduzierbarer funktionaler Organisationsmuster aktualisiert.', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', '2026-07-12 15:50:40'),
(131, 40, 56, 'equation_added', 'equation', '(3.70), (3.71)', 'Die formale Axiomdarstellung und die strukturelle Axiomabhängigkeit wurden registriert.', 'Frühere Belegungen der Gleichungsnummern.', 'Reproduzierbare Organisationsmuster und A1 bis A4 als Voraussetzungen von A5.', '2026-07-12 15:50:40'),
(132, 40, 56, '', 'axiom_dependency', 'A5 -> A1, A2, A3, A4', 'Die strukturellen Abhängigkeiten von A5 von A1 bis A4 wurden explizit registriert.', NULL, 'A5 depends_on A1; A5 depends_on A2; A5 depends_on A3; A5 depends_on A4', '2026-07-12 15:50:40'),
(133, 40, 56, 'other', 'axiom_system', 'A1–A5', 'Mit Axiom A5 ist das System der fünf FRZK-Grundaxiome vollständig formuliert.', 'A1 bis A4 vollständig; A5 noch nicht endredigiert.', 'Grundaxiome A1 bis A5 vollständig im Status review.', '2026-07-12 15:50:40'),
(134, 41, 57, 'rewritten', 'section', '3.3.8', 'Abschnitt 3.3.8 wurde vollständig als Zusammenfassung der axiomatischen Grundlagen neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.3.8.', 'Zusammenfassung von A1 bis A5 als gemeinsam vorausgesetztes Axiomensystem mit Gleichung (3.72).', '2026-07-12 15:54:49'),
(135, 41, 57, 'equation_added', 'equation', '(3.72)', 'Die gemeinsame Systemdarstellung der fünf Grundaxiome wurde registriert.', 'Mögliche ältere lineare Axiomkette.', 'A1\\land A2\\land A3\\land A4\\land A5\\Longrightarrow\\Diamond\\,\\mathcal{E}_F', '2026-07-12 15:54:49'),
(136, 41, 57, '', 'equation_dependency', '(3.72) -> (3.64), (3.65), (3.66), (3.68), (3.70)', 'Die Systemgleichung wurde mit sämtlichen formalen Axiomdarstellungen verknüpft.', NULL, '5 Gleichungsabhängigkeiten', '2026-07-12 15:54:49'),
(137, 41, 57, 'other', 'axiom_system', 'A1–A5', 'Die Axiome werden ausdrücklich als gleichrangige Grundannahmen und nicht als logisch auseinander ableitbare Kette dargestellt.', 'Lineare oder missverständliche Folgekette.', 'Gemeinsam vorausgesetzte Konjunktion der fünf Axiome.', '2026-07-12 15:54:49'),
(138, 42, 58, 'rewritten', 'section', '3.3.9', 'Abschnitt 3.3.9 wurde vollständig neu gefasst.', 'Frühere Fassung mit fünf Propositionen.', 'Neufassung mit ausschließlich Prop. 3.1 und Gleichung (3.73).', '2026-07-12 16:06:46'),
(139, 42, 58, 'other', 'proposition', 'Prop. 3.1', 'Proposition Prop. 3.1 wurde als Möglichkeit funktionaler Entwicklungsprozesse aktualisiert.', 'Möglichkeit funktionaler Organisation.', 'Möglichkeit funktionaler Entwicklungsprozesse.', '2026-07-12 16:06:46'),
(140, 42, 58, 'equation_added', 'equation', '(3.73)', 'Die formale Darstellung von Prop. 3.1 wurde registriert.', NULL, '(A1\\land A2\\land A3\\land A4\\land A5)\\Longrightarrow\\Diamond\\,\\mathcal{D}_F', '2026-07-12 16:06:46'),
(145, 44, 83, 'rewritten', 'section', '3.3.10', 'Abschnitt 3.3.10 wurde vollständig als Übergang zur mathematischen Rekonstruktion neu gefasst.', 'Der Abschnitt fehlte im Repository beziehungsweise war noch nicht als eigener Datensatz registriert.', 'Methodischer Abschluss der Axiomatik und Vorbereitung der mathematischen Rekonstruktion in Kapitel 3.4.', '2026-07-12 16:17:33'),
(146, 44, 83, 'status_changed', 'chapter', '3.3', 'Kapitel 3.3 wurde als inhaltlich vollständig entwickelt und weiterhin im Status review gekennzeichnet.', 'Kapitel 3.3 in laufender Bearbeitung.', 'Kapitel 3.3 inhaltlich vollständig; Endredaktion ausstehend.', '2026-07-12 16:17:33'),
(147, 44, 83, 'other', 'transition', '3.3 -> 3.4', 'Der Übergang von der qualitativen Axiomatik zur mathematischen Rekonstruktion wurde im Repository dokumentiert.', 'Kein eigener Übergangsabschnitt im Repository.', 'Abschnitt 3.3.10 als Übergang zu Kapitel 3.4 angelegt.', '2026-07-12 16:17:33'),
(148, 44, 83, 'other', 'repository', 'Fachobjekte 3.3.10', 'Es wurden bewusst keine Quellen, Axiome, Propositionen oder Gleichungen angelegt.', NULL, 'Metadatenrevision ohne neue fachliche Objekte.', '2026-07-12 16:17:33'),
(149, 45, 61, 'rewritten', 'section', '3.4.1', 'Abschnitt 3.4.1 wurde vollständig als Konstruktion funktionaler Zustände neu gefasst.', 'Konstruktion funktionaler Differenzstrukturen.', 'Konstruktion funktionaler Zustände.', '2026-07-12 16:43:59'),
(150, 45, 61, 'definition_added', 'definition', 'Def. 3.4.1', 'Die bestehende Definition wurde als funktionaler Zustand aktualisiert.', 'Funktionale Konfiguration.', 'Funktionaler Zustand.', '2026-07-12 16:43:59'),
(151, 45, 61, 'definition_added', 'definition', 'Def. 3.4.2', 'Die bestehende Definition wurde als Klasse funktionaler Zustände aktualisiert.', 'Funktionale Differenzabbildung.', 'Klasse funktionaler Zustände.', '2026-07-12 16:43:59'),
(152, 45, 61, 'equation_added', 'equation', '(3.74), (3.75)', 'Die Gleichungen zur Definition des funktionalen Zustands und seiner Zustandsklasse wurden registriert.', 'Frühere Belegungen der Gleichungsnummern.', 'x:=\\mathcal{O}_F; X=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', '2026-07-12 16:43:59'),
(153, 45, 61, '', 'object_dependency', 'Def. 3.4.1 / Def. 3.4.2', 'Die Definitionen wurden mit Axiom A4, Axiom A5 und ihren Gleichungsdarstellungen verknüpft.', NULL, '5 Objektabhängigkeiten und 1 Gleichungsabhängigkeit.', '2026-07-12 16:43:59'),
(154, 46, 62, 'rewritten', 'section', '3.4.2', 'Abschnitt 3.4.2 wurde vollständig als Konstruktion funktionaler Relationen neu gefasst.', 'Bisheriger Repository-Stand von 3.4.2.', 'Def. 3.4.3, Def. 3.4.4 und Gleichungen (3.76) bis (3.78).', '2026-07-12 16:50:15'),
(155, 46, 62, 'definition_added', 'definition', 'Def. 3.4.3–Def. 3.4.4', 'Die funktionale Relation und die funktionale Relationsstruktur wurden registriert.', NULL, '2 Definitionen', '2026-07-12 16:50:15'),
(156, 46, 62, 'equation_added', 'equation', '(3.76)–(3.78)', 'Die formalen Darstellungen der funktionalen Relation, ihres Indikators und der Relationsstruktur wurden registriert.', NULL, '3 Gleichungen', '2026-07-12 16:50:15'),
(157, 47, 63, 'rewritten', 'section', '3.4.3', 'Abschnitt 3.4.3 wurde vollständig als Konstruktion funktionaler Transformationen neu gefasst.', 'Konstruktion rekursiver Transformationen auf Relationsstrukturen.', 'Konstruktion funktionaler und rekursiver Transformationen auf der Klasse funktionaler Zustände.', '2026-07-12 16:50:30'),
(158, 47, 63, 'definition_added', 'definition', 'Def. 3.4.5–Def. 3.4.6', 'Die Definitionen der funktionalen und rekursiven Transformation wurden aktualisiert.', 'Aktive Relation und funktionaler Transformationsoperator auf Relationen.', 'Funktionale Transformation und rekursive Transformation auf X.', '2026-07-12 16:50:30'),
(159, 47, 63, 'statement_added', 'theorem', 'Satz 3.4.3', 'Der Satz zur Abgeschlossenheit funktionaler Transformationen wurde aktualisiert.', 'Existenz rekursiver Transformationsräume.', 'Abgeschlossenheit funktionaler Transformationen.', '2026-07-12 16:50:30'),
(160, 47, 63, 'equation_added', 'equation', '(3.79)–(3.81)', 'Die Gleichungen der funktionalen Transformation, Rekursion und Abgeschlossenheit wurden registriert.', 'Frühere Belegungen der Gleichungsnummern.', 'T_F:X->X; T_F^n:X->X; forall x in X: T_F(x) in X.', '2026-07-12 16:50:30'),
(161, 48, 64, 'rewritten', 'section', '3.4.4', 'Abschnitt 3.4.4 wurde vollständig als Konstruktion funktionaler Organisationsräume neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.4.4.', 'Neufassung mit Def. 3.4.7, Def. 3.4.8, Satz 3.4.4 und den Gleichungen (3.82) bis (3.85).', '2026-07-12 17:12:40'),
(162, 48, 64, 'definition_added', 'definition', 'Def. 3.4.7–Def. 3.4.8', 'Organisationserzeugende Transformation und funktionaler Organisationsraum wurden registriert.', NULL, '2 Definitionen', '2026-07-12 17:12:40'),
(163, 48, 64, 'statement_added', 'theorem', 'Satz 3.4.4', 'Der Existenzsatz für funktionale Organisationsräume wurde registriert.', NULL, 'Existenz funktionaler Organisationsräume', '2026-07-12 17:12:40'),
(164, 48, 64, 'equation_added', 'equation', '(3.82)–(3.85)', 'Die Organisationsmenge, ihre Invarianz, der Organisationsraum und seine rekursive Abgeschlossenheit wurden formal registriert.', NULL, '4 Gleichungen', '2026-07-12 17:12:40'),
(165, 49, 65, 'rewritten', 'section', '3.4.5', 'Abschnitt 3.4.5 wurde vollständig als mathematische Rekonstruktion funktionaler Kohärenz neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.4.5.', 'Def. 3.4.9, Def. 3.4.10, Lemma 3.4.3, Satz 3.4.5 und Gleichungen (3.86) bis (3.89).', '2026-07-13 09:15:16'),
(166, 49, 65, 'definition_added', 'definition', 'Def. 3.4.9–Def. 3.4.10', 'Funktionale Kohärenz und kohärenzerhaltende Transformation wurden registriert.', NULL, '2 Definitionen', '2026-07-13 09:15:16'),
(167, 49, 65, 'statement_added', 'lemma', 'Lemma 3.4.3', 'Die rekursive Kohärenzerhaltung wurde registriert.', NULL, 'Rekursive Kohärenzerhaltung', '2026-07-13 09:15:16'),
(168, 49, 65, 'statement_added', 'theorem', 'Satz 3.4.5', 'Der Existenzsatz kohärenter Organisationsräume wurde registriert.', NULL, 'Existenz kohärenter Organisationsräume', '2026-07-13 09:15:16'),
(169, 49, 65, 'equation_added', 'equation', '(3.86)–(3.89)', 'Die Kohärenzfunktion und ihre Erhaltung wurden formal registriert.', NULL, '4 Gleichungen', '2026-07-13 09:15:16'),
(170, 50, 66, 'rewritten', 'section', '3.4.6', 'Abschnitt 3.4.6 wurde vollständig als mathematische Rekonstruktion funktionaler Raum-Zeit-Kohärenz neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.4.6.', 'Neufassung mit Def. 3.4.11, Def. 3.4.12, Lemma 3.4.4, Satz 3.4.6 und den Gleichungen (3.90) bis (3.93).', '2026-07-13 09:43:31'),
(171, 50, 66, 'definition_added', 'definition', 'Def. 3.4.11–Def. 3.4.12', 'Funktionale Raum-Zeit-Kohärenz und Raum-Zeit-Kohärenzfunktion wurden registriert.', NULL, '2 Definitionen', '2026-07-13 09:43:31'),
(172, 50, 66, 'statement_added', 'lemma', 'Lemma 3.4.4', 'Das Lemma zur Symmetrie der Raum-Zeit-Kohärenz wurde registriert.', NULL, 'Symmetrie im wechselseitig definierten Spezialfall', '2026-07-13 09:43:31'),
(173, 50, 66, 'statement_added', 'theorem', 'Satz 3.4.6', 'Der Existenzsatz des Funktionalen Raum-Zeit-Kohärenzsystems wurde registriert.', NULL, 'Existenz des Tripels aus Organisationsräumen, Kohärenzrelation und Kohärenzfunktion', '2026-07-13 09:43:31'),
(174, 50, 66, 'equation_added', 'equation', '(3.90)–(3.93)', 'Die Kohärenzrelation, Kohärenzfunktion, Symmetriebedingung und FRZK-Systemstruktur wurden formal registriert.', NULL, '4 Gleichungen', '2026-07-13 09:43:31'),
(175, 51, 67, 'rewritten', 'section', '3.4.7', 'Abschnitt 3.4.7 wurde vollständig als mathematische Rekonstruktion funktionaler Dynamik neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.4.7.', 'Neufassung mit Def. 3.4.13, Def. 3.4.14, Lemma 3.4.5, Satz 3.4.7 und den Gleichungen (3.94) bis (3.97).', '2026-07-13 10:11:32'),
(176, 51, 67, 'definition_added', 'definition', 'Def. 3.4.13–Def. 3.4.14', 'Funktionale Dynamik und funktionale Entwicklungsbahn wurden registriert.', NULL, '2 Definitionen', '2026-07-13 10:11:32'),
(177, 51, 67, 'statement_added', 'lemma', 'Lemma 3.4.5', 'Das Lemma zur Kohärenzdifferenz auf Entwicklungsbahnen wurde registriert.', NULL, 'Kohärenzdifferenz auf Entwicklungsbahnen', '2026-07-13 10:11:32'),
(178, 51, 67, 'statement_added', 'theorem', 'Satz 3.4.7', 'Der Satz zur Rekonstruktion funktionaler Entwicklung wurde registriert.', NULL, 'Rekonstruktion funktionaler Entwicklung', '2026-07-13 10:11:32'),
(179, 51, 67, 'equation_added', 'equation', '(3.94)–(3.97)', 'Dynamikfunktion, Entwicklungsbahn, Kohärenzdifferenz und Rekonstruktionssatz wurden formal registriert.', NULL, '4 Gleichungen', '2026-07-13 10:11:32'),
(180, 52, 68, 'rewritten', 'section', '3.4.8', 'Abschnitt 3.4.8 wurde vollständig als mathematische Rekonstruktion funktionaler Attraktoren neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.4.8.', 'Neufassung mit Def. 3.4.15, Def. 3.4.16, Lemma 3.4.6, Satz 3.4.8 und den Gleichungen (3.98) bis (3.101).', '2026-07-13 11:00:23'),
(181, 52, 68, 'definition_added', 'definition', 'Def. 3.4.15–Def. 3.4.16', 'Funktionaler Attraktor und Attraktorenmenge wurden registriert.', NULL, '2 Definitionen', '2026-07-13 11:00:23'),
(182, 52, 68, 'statement_added', 'lemma', 'Lemma 3.4.6', 'Die Kohärenzerhaltung funktionaler Attraktoren wurde registriert.', NULL, 'Kohärenzerhaltung funktionaler Attraktoren', '2026-07-13 11:00:23'),
(183, 52, 68, 'statement_added', 'theorem', 'Satz 3.4.8', 'Der Existenzsatz funktionaler Attraktoren wurde logisch präzisiert und registriert.', 'Endliche Folge mit invariantem Kohärenzwert ohne hinreichende Wiederkehrbedingung.', 'Deterministische, unendlich fortsetzbare Entwicklungsbahn in einer endlichen Organisationsraummenge.', '2026-07-13 11:00:23'),
(184, 52, 68, 'equation_added', 'equation', '(3.98)–(3.101)', 'Attraktorbedingung, Attraktorenmenge, Kohärenzerhaltung und Existenzsatz wurden formal registriert.', NULL, '4 Gleichungen', '2026-07-13 11:00:23');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sources`
--

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

--
-- Daten für Tabelle `sources`
--

INSERT INTO `sources` (`source_id`, `citation_number`, `source_key`, `source_type`, `title`, `subtitle`, `year_original`, `year_edition`, `journal`, `publisher`, `place`, `volume`, `issue`, `pages`, `edition`, `doi`, `isbn`, `url`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`, `verification_status`, `first_citation_section_code`, `first_citation_note`, `full_citation_text`, `short_citation_text`, `notes`, `created_revision_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'aristoteles_physik', 'historical_work', 'Physik', NULL, -350, 1987, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'historical', 2, 'imported', '3.1.1', NULL, 'Aristoteles: Physik. Übersetzt von Hans Günter Zekl. Hamburg: Felix Meiner Verlag, 1987.', 'Aristoteles [1]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(2, 2, 'newton_principia_1687', 'historical_work', 'Philosophiae Naturalis Principia Mathematica', NULL, 1687, 1687, NULL, NULL, 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'la', 5, 'primary', 3, 'imported', '3.1.1', NULL, 'Newton, Isaac: Philosophiae Naturalis Principia Mathematica. London, 1687.', 'Newton [2]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(3, 3, 'mach_mechanik_1883', 'book', 'Die Mechanik in ihrer Entwicklung', NULL, 1883, 1883, NULL, 'F. A. Brockhaus', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'primary', 3, 'imported', '3.1.1', NULL, 'Mach, Ernst: Die Mechanik in ihrer Entwicklung. Leipzig: F. A. Brockhaus, 1883.', 'Mach [3]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(4, 4, 'einstein_srt_1905', 'journal_article', 'Zur Elektrodynamik bewegter Körper', NULL, 1905, 1905, 'Annalen der Physik', NULL, NULL, '17', NULL, '891–921', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'imported', '3.1.1', NULL, 'Einstein, Albert: Zur Elektrodynamik bewegter Körper. Annalen der Physik, 17, 1905, S. 891–921.', 'Einstein [4]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(5, 5, 'einstein_art_1916', 'journal_article', 'Die Grundlage der allgemeinen Relativitätstheorie', NULL, 1916, 1916, 'Annalen der Physik', NULL, NULL, '49', NULL, '769–822', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'imported', '3.1.1', NULL, 'Einstein, Albert: Die Grundlage der allgemeinen Relativitätstheorie. Annalen der Physik, 49, 1916, S. 769–822.', 'Einstein [5]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(6, 6, 'minkowski_raum_zeit_1909', 'historical_work', 'Raum und Zeit', NULL, 1909, 1909, NULL, 'B. G. Teubner', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'imported', '3.1.1', NULL, 'Minkowski, Hermann: Raum und Zeit. Leipzig: B. G. Teubner, 1909.', 'Minkowski [6]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(7, 7, 'euklid_elemente', 'historical_work', 'Die Elemente', NULL, -300, 1908, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'historical', 2, 'imported', '3.1.1', NULL, 'Euklid: Die Elemente. Übersetzung von Thomas L. Heath. Cambridge: Cambridge University Press, 1908.', 'Euklid [7]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(8, 8, 'hilbert_grundlagen_geometrie_1899', 'book', 'Grundlagen der Geometrie', NULL, 1899, 1899, NULL, 'B. G. Teubner', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'imported', '3.1.1', NULL, 'Hilbert, David: Grundlagen der Geometrie. Leipzig: B. G. Teubner, 1899.', 'Hilbert [8]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(9, 9, 'bourbaki_general_topology_1989', 'book', 'General Topology', NULL, 1966, 1989, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'reference', 3, 'imported', '3.1.1', NULL, 'Bourbaki, Nicolas: General Topology. Berlin: Springer, 1989.', 'Bourbaki [9]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(10, 10, 'lang_diff_riemannian_1995', 'book', 'Differential and Riemannian Manifolds', NULL, 1995, 1995, NULL, 'Springer', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'reference', 3, 'imported', '3.1.1', NULL, 'Lang, Serge: Differential and Riemannian Manifolds. New York: Springer, 1995.', 'Lang [10]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(11, 11, 'rudin_functional_analysis_1991', 'book', 'Functional Analysis', NULL, 1973, 1991, NULL, 'McGraw-Hill', 'New York', NULL, NULL, NULL, '2nd ed.', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'imported', '3.1.1', NULL, 'Rudin, Walter: Functional Analysis. Second Edition. New York: McGraw-Hill, 1991.', 'Rudin [11]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(12, 12, 'haken_synergetics_1983', 'book', 'Synergetics – An Introduction', NULL, 1977, 1983, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '3rd ed.', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'imported', '3.1.1', NULL, 'Haken, Hermann: Synergetics – An Introduction. Third Edition. Berlin: Springer, 1983.', 'Haken [12]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(13, 13, 'prigogine_stengers_order_1984', 'book', 'Order out of Chaos', NULL, 1984, 1984, NULL, 'Bantam Books', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'secondary', 4, 'imported', '3.1.1', NULL, 'Prigogine, Ilya; Stengers, Isabelle: Order out of Chaos. New York: Bantam Books, 1984.', 'Prigogine und Stengers [13]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(14, 14, 'holland_hidden_order_1995', 'book', 'Hidden Order', NULL, 1995, 1995, NULL, 'Addison-Wesley', 'Reading, MA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'secondary', 3, 'imported', '3.1.1', NULL, 'Holland, John H.: Hidden Order. Reading, MA: Addison-Wesley, 1995.', 'Holland [14]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(15, 15, 'barabasi_network_science_2016', 'book', 'Network Science', NULL, 2016, 2016, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 4, 'imported', '3.1.1', NULL, 'Barabási, Albert-László: Network Science. Cambridge: Cambridge University Press, 2016.', 'Barabási [15]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(16, 16, 'arnold_classical_mechanics_1989', 'book', 'Mathematical Methods of Classical Mechanics', NULL, 1978, 1989, NULL, 'Springer', 'New York', NULL, NULL, NULL, '2nd ed.', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'imported', '3.1.2', NULL, 'Arnold, Vladimir I.: Mathematical Methods of Classical Mechanics. Second Edition. New York: Springer, 1989.', 'Arnold [16]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(17, 17, 'goedel_unentscheidbar_1931', 'journal_article', 'Über formal unentscheidbare Sätze der Principia Mathematica und verwandter Systeme I', NULL, 1931, 1931, 'Monatshefte für Mathematik und Physik', NULL, NULL, '38', NULL, '173–198', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 3, 'imported', '3.1.3', NULL, 'Gödel, Kurt: Über formal unentscheidbare Sätze der Principia Mathematica und verwandter Systeme I. Monatshefte für Mathematik und Physik, 38, 1931, S. 173–198.', 'Gödel [17]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(18, 18, 'whitehead_russell_principia_1910', 'book', 'Principia Mathematica', NULL, 1910, 1913, NULL, 'Cambridge University Press', 'Cambridge', 'I–III', NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'primary', 3, 'imported', '3.1.3', NULL, 'Whitehead, Alfred North; Russell, Bertrand: Principia Mathematica. Cambridge: Cambridge University Press, Vol. I–III, 1910–1913.', 'Whitehead und Russell [18]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(19, 19, 'rovelli_quantum_gravity_2004', 'book', 'Quantum Gravity', NULL, 2004, 2004, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 3, 'imported', '3.1.4', NULL, 'Rovelli, Carlo: Quantum Gravity. Cambridge: Cambridge University Press, 2004.', 'Rovelli [19]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(20, 20, 'green_schwarz_witten_superstring_1987', 'book', 'Superstring Theory', NULL, 1987, 1987, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 3, 'imported', '3.1.4', NULL, 'Green, Michael B.; Schwarz, John H.; Witten, Edward: Superstring Theory. Cambridge: Cambridge University Press, 1987.', 'Green, Schwarz und Witten [20]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(21, 21, 'wheeler_it_from_bit_1990', 'book_chapter', 'Information, Physics, Quantum: The Search for Links', NULL, 1990, 1990, NULL, 'Addison-Wesley', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'primary', 4, 'imported', '3.1.4', NULL, 'Wheeler, John Archibald: Information, Physics, Quantum: The Search for Links. In: Zurek, W. H. (Hrsg.): Complexity, Entropy and the Physics of Information. Addison-Wesley, 1990.', 'Wheeler [21]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(22, 22, 'floridi_philosophy_information_2011', 'book', 'The Philosophy of Information', NULL, 2011, 2011, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'reference', 3, 'imported', '3.1.4', NULL, 'Floridi, Luciano: The Philosophy of Information. Oxford: Oxford University Press, 2011.', 'Floridi [22]', NULL, 1, '2026-07-12 06:09:36', '2026-07-12 11:14:28'),
(23, 23, 'cantor_beitraege_1895_1897', 'journal_article', 'Beiträge zur Begründung der transfiniten Mengenlehre', NULL, 1895, 1897, 'Mathematische Annalen', NULL, NULL, '46/49', NULL, '481–512; 207–246', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'needs_review', '3.2.1', NULL, 'Cantor, Georg: Beiträge zur Begründung der transfiniten Mengenlehre. Mathematische Annalen, 46, 1895, S. 481–512; 49, 1897, S. 207–246.', 'Cantor [23]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(24, 24, 'zermelo_grundlagen_1908', 'journal_article', 'Untersuchungen über die Grundlagen der Mengenlehre I', NULL, 1908, 1908, 'Mathematische Annalen', NULL, NULL, '65', NULL, '261–281', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'needs_review', '3.2.1', NULL, 'Zermelo, Ernst: Untersuchungen über die Grundlagen der Mengenlehre I. Mathematische Annalen, 65, 1908, S. 261–281.', 'Zermelo [24]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(25, 25, 'jech_set_theory_2003', 'book', 'Set Theory', NULL, 1978, 2003, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '3rd Millennium Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.1', NULL, 'Jech, Thomas: Set Theory. 3rd Millennium Edition. Berlin: Springer, 2003.', 'Jech [25]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(26, 26, 'halmos_naive_set_theory_1960', 'book', 'Naive Set Theory', NULL, 1960, 1960, NULL, 'D. Van Nostrand Company', 'Princeton', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'reference', 3, 'needs_review', '3.2.1', NULL, 'Halmos, Paul R.: Naive Set Theory. Princeton: D. Van Nostrand Company, 1960.', 'Halmos [26]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(27, 27, 'enderton_elements_set_theory_1977', 'book', 'Elements of Set Theory', NULL, 1977, 1977, NULL, 'Academic Press', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'reference', 3, 'needs_review', '3.2.2', NULL, 'Enderton, Herbert B.: Elements of Set Theory. New York: Academic Press, 1977.', 'Enderton [27]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(28, 28, 'davey_priestley_lattices_order_2002', 'book', 'Introduction to Lattices and Order', NULL, 1990, 2002, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 4, 'reference', 3, 'needs_review', '3.2.2', NULL, 'Davey, Brian A.; Priestley, Hilary A.: Introduction to Lattices and Order. 2nd Edition. Cambridge: Cambridge University Press, 2002.', 'Davey und Priestley [28]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(29, 29, 'lang_undergraduate_analysis_1997', 'book', 'Undergraduate Analysis', NULL, 1983, 1997, NULL, 'Springer', 'New York', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 4, 'textbook', 3, 'needs_review', '3.2.3', NULL, 'Lang, Serge: Undergraduate Analysis. 2nd Edition. New York: Springer, 1997.', 'Lang [29]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(30, 30, 'rudin_principles_analysis_1976', 'book', 'Principles of Mathematical Analysis', NULL, 1953, 1976, NULL, 'McGraw-Hill', 'New York', NULL, NULL, NULL, '3rd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 3, 'needs_review', '3.2.3', NULL, 'Rudin, Walter: Principles of Mathematical Analysis. 3rd Edition. New York: McGraw-Hill, 1976.', 'Rudin [30]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(31, 31, 'dummit_foote_abstract_algebra_2004', 'book', 'Abstract Algebra', NULL, 1991, 2004, NULL, 'John Wiley & Sons', 'Hoboken', NULL, NULL, NULL, '3rd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 3, 'needs_review', '3.2.4', NULL, 'Dummit, David S.; Foote, Richard M.: Abstract Algebra. 3rd Edition. Hoboken: John Wiley & Sons, 2004.', 'Dummit und Foote [31]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(32, 32, 'lang_algebra_2002', 'book', 'Algebra', NULL, 1965, 2002, NULL, 'Springer', 'New York', NULL, NULL, NULL, 'Revised 3rd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 3, 'needs_review', '3.2.4', NULL, 'Lang, Serge: Algebra. Revised 3rd Edition. New York: Springer, 2002.', 'Lang [32]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(33, 33, 'hall_lie_groups_2015', 'book', 'Lie Groups, Lie Algebras, and Representations: An Elementary Introduction', NULL, 2003, 2015, NULL, 'Springer', 'Cham', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 4, 'reference', 3, 'needs_review', '3.2.4', NULL, 'Hall, Brian C.: Lie Groups, Lie Algebras, and Representations: An Elementary Introduction. 2nd Edition. Cham: Springer, 2015.', 'Hall [33]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(34, 34, 'artin_algebra_2011', 'book', 'Algebra', NULL, 1991, 2011, NULL, 'Pearson', 'Boston', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 4, 'reference', 3, 'needs_review', '3.2.4', NULL, 'Artin, Michael: Algebra. 2nd Edition. Boston: Pearson, 2011.', 'Artin [34]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(35, 35, 'conway_functional_analysis_1990', 'book', 'A Course in Functional Analysis', NULL, 1985, 1990, NULL, 'Springer', 'New York', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.5', NULL, 'Conway, John B.: A Course in Functional Analysis. 2nd Edition. New York: Springer, 1990.', 'Conway [35]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(36, 36, 'kreyszig_functional_analysis_1978', 'book', 'Introductory Functional Analysis with Applications', NULL, 1978, 1978, NULL, 'John Wiley & Sons', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'textbook', 3, 'needs_review', '3.2.5', NULL, 'Kreyszig, Erwin: Introductory Functional Analysis with Applications. New York: John Wiley & Sons, 1978.', 'Kreyszig [36]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(37, 37, 'strogatz_nonlinear_dynamics_2015', 'book', 'Nonlinear Dynamics and Chaos', NULL, 1994, 2015, NULL, 'Westview Press', 'Boulder', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.5', NULL, 'Strogatz, Steven H.: Nonlinear Dynamics and Chaos. 2nd Edition. Boulder: Westview Press, 2015.', 'Strogatz [37]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(38, 38, 'sontag_control_theory_1998', 'book', 'Mathematical Control Theory: Deterministic Finite Dimensional Systems', NULL, 1990, 1998, NULL, 'Springer', 'New York', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.6', NULL, 'Sontag, Eduardo D.: Mathematical Control Theory: Deterministic Finite Dimensional Systems. 2nd Edition. New York: Springer, 1998.', 'Sontag [38]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(39, 39, 'khalil_nonlinear_systems_2002', 'book', 'Nonlinear Systems', NULL, 1992, 2002, NULL, 'Prentice Hall', 'Upper Saddle River', NULL, NULL, NULL, '3rd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.6', NULL, 'Khalil, Hassan K.: Nonlinear Systems. 3rd Edition. Upper Saddle River: Prentice Hall, 2002.', 'Khalil [39]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(40, 40, 'hirsch_smale_devaney_2013', 'book', 'Differential Equations, Dynamical Systems, and an Introduction to Chaos', NULL, 1974, 2013, NULL, 'Academic Press', 'Amsterdam', NULL, NULL, NULL, '3rd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.6', NULL, 'Hirsch, Morris W.; Smale, Stephen; Devaney, Robert L.: Differential Equations, Dynamical Systems, and an Introduction to Chaos. 3rd Edition. Amsterdam: Academic Press, 2013.', 'Hirsch, Smale und Devaney [40]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(41, 41, 'reed_simon_functional_analysis_1980', 'book', 'Methods of Modern Mathematical Physics. Vol. I: Functional Analysis', NULL, 1972, 1980, NULL, 'Academic Press', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.7', NULL, 'Reed, Michael; Simon, Barry: Methods of Modern Mathematical Physics. Vol. I: Functional Analysis. New York: Academic Press, 1980.', 'Reed und Simon [41]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(42, 42, 'yosida_functional_analysis_1980', 'book', 'Functional Analysis', NULL, 1965, 1980, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '6th Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.7', NULL, 'Yosida, Kôsaku: Functional Analysis. 6th Edition. Berlin: Springer, 1980.', 'Yosida [42]', NULL, 6, '2026-07-12 06:10:56', '2026-07-12 11:14:28'),
(43, 43, 'katok_hasselblatt_dynamical_1995', 'book', 'Introduction to the Modern Theory of Dynamical Systems', NULL, 1995, 1995, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.8', NULL, 'Katok, Anatole; Hasselblatt, Boris: Introduction to the Modern Theory of Dynamical Systems. Cambridge: Cambridge University Press, 1995.', 'Katok und Hasselblatt [43]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(44, 44, 'ott_chaos_2002', 'book', 'Chaos in Dynamical Systems', NULL, 1993, 2002, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.8', NULL, 'Ott, Edward: Chaos in Dynamical Systems. 2nd Edition. Cambridge: Cambridge University Press, 2002.', 'Ott [44]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(45, 45, 'cover_thomas_information_2006', 'book', 'Elements of Information Theory', NULL, 1991, 2006, NULL, 'John Wiley & Sons', 'Hoboken', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.9', NULL, 'Cover, Thomas M.; Thomas, Joy A.: Elements of Information Theory. 2nd Edition. Hoboken: John Wiley & Sons, 2006.', 'Cover und Thomas [45]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(46, 46, 'shannon_communication_1948', 'journal_article', 'A Mathematical Theory of Communication', NULL, 1948, 1948, 'Bell System Technical Journal', NULL, NULL, '27', NULL, '379–423; 623–656', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'needs_review', '3.2.9', NULL, 'Shannon, Claude E.: A Mathematical Theory of Communication. Bell System Technical Journal, 27, 1948, S. 379–423 und 623–656.', 'Shannon [46]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(47, 47, 'diestel_graph_theory_2017', 'book', 'Graph Theory', NULL, 1997, 2017, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '5th Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.10', NULL, 'Diestel, Reinhard: Graph Theory. 5th Edition. Berlin: Springer, 2017.', 'Diestel [47]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(48, 48, 'newman_networks_2018', 'book', 'Networks', NULL, 2010, 2018, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, '2nd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.10', NULL, 'Newman, Mark: Networks. 2nd Edition. Oxford: Oxford University Press, 2018.', 'Newman [48]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(49, 49, 'burago_metric_geometry_2001', 'book', 'A Course in Metric Geometry', NULL, 2001, 2001, NULL, 'American Mathematical Society', 'Providence', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.11', NULL, 'Burago, Dmitri; Burago, Yuri; Ivanov, Sergei: A Course in Metric Geometry. Providence: American Mathematical Society, 2001.', 'Burago, Burago und Ivanov [49]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(50, 50, 'manning_raghavan_schuetze_2008', 'book', 'Introduction to Information Retrieval', NULL, 2008, 2008, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'reference', 3, 'needs_review', '3.2.11', NULL, 'Manning, Christopher D.; Raghavan, Prabhakar; Schütze, Hinrich: Introduction to Information Retrieval. Cambridge: Cambridge University Press, 2008.', 'Manning, Raghavan und Schütze [50]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(51, 51, 'camazine_self_organization_2001', 'book', 'Self-Organization in Biological Systems', NULL, 2001, 2001, NULL, 'Princeton University Press', 'Princeton', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.12', NULL, 'Camazine, Scott; Deneubourg, Jean-Louis; Franks, Nigel R.; Sneyd, James; Theraulaz, Guy; Bonabeau, Eric: Self-Organization in Biological Systems. Princeton: Princeton University Press, 2001.', 'Camazine et al. [51]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(52, 52, 'mitchell_complexity_2009', 'book', 'Complexity: A Guided Tour', NULL, 2009, 2009, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'secondary', 3, 'needs_review', '3.2.12', NULL, 'Mitchell, Melanie: Complexity: A Guided Tour. Oxford: Oxford University Press, 2009.', 'Mitchell [52]', NULL, 6, '2026-07-12 06:10:57', '2026-07-12 11:14:28'),
(58, 53, 'thiemann_modern_canonical_qgr_2007', 'book', 'Modern Canonical Quantum General Relativity', NULL, 2007, 2007, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 4, 'partially_verified', '3.1.4', NULL, 'Thiemann, Thomas: Modern Canonical Quantum General Relativity. Cambridge: Cambridge University Press, 2007.', 'Thiemann [53]', 'Grundlagenwerk zur kanonischen Schleifenquantengravitation.', 18, '2026-07-12 12:37:33', '2026-07-12 12:37:33'),
(59, 54, 'bombelli_lee_meyer_sorkin_causal_set_1987', 'journal_article', 'Space-Time as a Causal Set', NULL, 1987, 1987, 'Physical Review Letters', NULL, NULL, '59', NULL, '521–524', NULL, '10.1103/PhysRevLett.59.521', NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.1.4', NULL, 'Bombelli, Luca; Lee, Joohan; Meyer, David; Sorkin, Rafael D.: Space-Time as a Causal Set. Physical Review Letters, 59, 1987, S. 521–524.', 'Bombelli et al. [54]', 'Originäre Arbeit zur Causal-Set-Theorie.', 18, '2026-07-12 12:37:33', '2026-07-12 12:37:33'),
(60, 55, 'van_raamsdonk_building_spacetime_2010', 'journal_article', 'Building up Spacetime with Quantum Entanglement', NULL, 2010, 2010, 'General Relativity and Gravitation', NULL, NULL, '42', NULL, '2323–2329', NULL, '10.1007/s10714-010-1034-0', NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.1.4', NULL, 'Van Raamsdonk, Mark: Building up Spacetime with Quantum Entanglement. General Relativity and Gravitation, 42, 2010, S. 2323–2329.', 'Van Raamsdonk [55]', 'Grundlegende Arbeit zur Rekonstruktion von Raumzeit aus Quantenverschränkung.', 18, '2026-07-12 12:37:33', '2026-07-12 12:37:33'),
(61, 56, 'swingle_entanglement_renormalization_2012', 'journal_article', 'Entanglement Renormalization and Holography', NULL, 2012, 2012, 'Physical Review D', NULL, NULL, '86', '6', NULL, NULL, '10.1103/PhysRevD.86.065007', NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.1.4', NULL, 'Swingle, Brian: Entanglement Renormalization and Holography. Physical Review D, 86(6), 2012, 065007.', 'Swingle [56]', 'Originäre Arbeit zur Verbindung von Tensornetzwerken und holographischer Geometrie.', 18, '2026-07-12 12:37:33', '2026-07-12 12:37:33'),
(62, 57, 'verlinde_origin_gravity_2011', 'journal_article', 'On the Origin of Gravity and the Laws of Newton', NULL, 2011, 2011, 'Journal of High Energy Physics', NULL, NULL, '2011', NULL, NULL, NULL, '10.1007/JHEP04(2011)029', NULL, NULL, 'en', 5, 'primary', 4, 'verified', '3.1.4', NULL, 'Verlinde, Erik: On the Origin of Gravity and the Laws of Newton. Journal of High Energy Physics, 2011(4), Artikel 29.', 'Verlinde [57]', 'Arbeit zur Interpretation der Gravitation als emergentes bzw. entropisches Phänomen.', 18, '2026-07-12 12:37:33', '2026-07-12 12:37:33'),
(63, 58, 'fraenkel_bar_hillel_levy_foundations_set_theory_1973', 'book', 'Foundations of Set Theory', NULL, 1958, 1973, NULL, 'North-Holland', 'Amsterdam', NULL, NULL, NULL, 'Second Revised Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.1', 'Erstnennung in der Neufassung von Abschnitt 3.2.1.', 'Fraenkel, Abraham A.; Bar-Hillel, Yehoshua; Levy, Azriel: Foundations of Set Theory. Second Revised Edition. Amsterdam: North-Holland, 1973.', 'Fraenkel, Bar-Hillel und Levy [58]', 'Referenzwerk zur axiomatischen Mengenlehre und zu den Grundlagen von ZFC.', 21, '2026-07-12 12:53:53', '2026-07-12 12:53:53');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `source_authors`
--

CREATE TABLE `source_authors` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `author_order` smallint(5) UNSIGNED NOT NULL,
  `role` enum('author','editor','translator') NOT NULL DEFAULT 'author'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `source_authors`
--

INSERT INTO `source_authors` (`source_id`, `author_id`, `author_order`, `role`) VALUES
(1, 1, 1, 'author'),
(2, 2, 1, 'author'),
(3, 3, 1, 'author'),
(4, 4, 1, 'author'),
(5, 4, 1, 'author'),
(6, 5, 1, 'author'),
(7, 6, 1, 'author'),
(8, 7, 1, 'author'),
(9, 8, 1, 'author'),
(10, 9, 1, 'author'),
(11, 10, 1, 'author'),
(12, 11, 1, 'author'),
(13, 12, 1, 'author'),
(13, 13, 2, 'author'),
(14, 14, 1, 'author'),
(15, 15, 1, 'author'),
(16, 16, 1, 'author'),
(17, 17, 1, 'author'),
(18, 18, 1, 'author'),
(18, 19, 2, 'author'),
(19, 20, 1, 'author'),
(20, 21, 1, 'author'),
(20, 22, 2, 'author'),
(20, 23, 3, 'author'),
(21, 24, 1, 'author'),
(22, 25, 1, 'author'),
(58, 34, 1, 'author'),
(59, 35, 1, 'author'),
(59, 36, 2, 'author'),
(59, 37, 3, 'author'),
(59, 38, 4, 'author'),
(60, 39, 1, 'author'),
(61, 40, 1, 'author'),
(62, 41, 1, 'author'),
(63, 42, 1, 'author'),
(63, 43, 2, 'author'),
(63, 44, 3, 'author');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `source_relations`
--

CREATE TABLE `source_relations` (
  `relation_id` bigint(20) UNSIGNED NOT NULL,
  `source_id_from` bigint(20) UNSIGNED NOT NULL,
  `source_id_to` bigint(20) UNSIGNED NOT NULL,
  `relation_type` enum('extends','criticizes','formalizes','applies','reviews','historical_predecessor','alternative_to','supports','contradicts','related') NOT NULL,
  `relation_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `source_relations`
--

INSERT INTO `source_relations` (`relation_id`, `source_id_from`, `source_id_to`, `relation_type`, `relation_note`) VALUES
(1, 3, 2, 'criticizes', 'Mach kritisiert Newtons absolute Raum- und Zeitgrößen.'),
(2, 4, 2, 'alternative_to', 'Die Spezielle Relativitätstheorie ersetzt absolute Raum- und Zeitmessungen.'),
(3, 6, 4, 'formalizes', 'Minkowski formuliert die Spezielle Relativitätstheorie geometrisch als Raumzeit.'),
(4, 5, 4, 'extends', 'Die Allgemeine Relativitätstheorie erweitert die Spezielle Relativitätstheorie um Gravitation.'),
(5, 17, 18, 'criticizes', 'Gödels Unvollständigkeitssätze begrenzen das logizistische Vollständigkeitsprogramm.'),
(6, 21, 22, 'historical_predecessor', 'Wheelers informationeller Physikansatz ist ein wichtiger Vorläufer philosophischer Informationsontologien.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `source_topics`
--

CREATE TABLE `source_topics` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED NOT NULL,
  `relevance` tinyint(3) UNSIGNED NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `source_topics`
--

INSERT INTO `source_topics` (`source_id`, `topic_id`, `relevance`) VALUES
(1, 1, 5),
(2, 1, 5),
(3, 1, 5),
(3, 2, 5),
(4, 2, 5),
(5, 2, 5),
(6, 2, 5),
(7, 3, 5),
(8, 3, 5),
(9, 4, 5),
(10, 5, 5),
(11, 6, 5),
(12, 8, 5),
(13, 8, 5),
(14, 8, 5),
(15, 9, 5),
(16, 7, 5),
(17, 3, 5),
(18, 3, 5),
(19, 10, 5),
(20, 10, 5),
(21, 11, 5),
(21, 12, 5),
(22, 11, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `source_usage`
--

CREATE TABLE `source_usage` (
  `usage_id` bigint(20) UNSIGNED NOT NULL,
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `usage_type` enum('first_citation','background','definition','theorem','method','historical_context','state_of_research','critique','research_gap','comparison','equation_source','figure_source','table_source','other') NOT NULL,
  `claim_summary` text NOT NULL,
  `exact_location` varchar(255) DEFAULT NULL,
  `is_first_mention` tinyint(1) NOT NULL DEFAULT 0,
  `citation_checked` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `source_usage`
--

INSERT INTO `source_usage` (`usage_id`, `source_id`, `section_id`, `usage_type`, `claim_summary`, `exact_location`, `is_first_mention`, `citation_checked`, `notes`, `created_revision_id`) VALUES
(50, 38, 14, 'first_citation', 'Verwendung von Quelle [38] im Abschnitt 3.2.6.', 'Abschnitt 3.2.6', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(51, 39, 14, 'first_citation', 'Verwendung von Quelle [39] im Abschnitt 3.2.6.', 'Abschnitt 3.2.6', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(52, 40, 14, 'first_citation', 'Verwendung von Quelle [40] im Abschnitt 3.2.6.', 'Abschnitt 3.2.6', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(71, 23, 21, 'research_gap', 'Verwendung von Quelle [23] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(72, 24, 21, 'research_gap', 'Verwendung von Quelle [24] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(73, 27, 21, 'research_gap', 'Verwendung von Quelle [27] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(74, 29, 21, 'research_gap', 'Verwendung von Quelle [29] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(75, 31, 21, 'research_gap', 'Verwendung von Quelle [31] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(76, 35, 21, 'research_gap', 'Verwendung von Quelle [35] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(77, 38, 21, 'research_gap', 'Verwendung von Quelle [38] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(78, 41, 21, 'research_gap', 'Verwendung von Quelle [41] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(79, 43, 21, 'research_gap', 'Verwendung von Quelle [43] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(80, 45, 21, 'research_gap', 'Verwendung von Quelle [45] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(81, 47, 21, 'research_gap', 'Verwendung von Quelle [47] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(82, 49, 21, 'research_gap', 'Verwendung von Quelle [49] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(83, 51, 21, 'research_gap', 'Verwendung von Quelle [51] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(84, 12, 21, 'research_gap', 'Verwendung von Quelle [12] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(85, 14, 21, 'research_gap', 'Verwendung von Quelle [14] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(86, 15, 21, 'research_gap', 'Verwendung von Quelle [15] im Abschnitt 3.2.13.', 'Abschnitt 3.2.13', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(129, 7, 49, 'historical_context', 'Axiomatische Methode und Abgrenzung gegenüber klassischen geometrischen und mengentheoretischen Ausgangsstrukturen.', '3.3.0', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(130, 8, 49, 'historical_context', 'Axiomatische Methode und Abgrenzung gegenüber klassischen geometrischen und mengentheoretischen Ausgangsstrukturen.', '3.3.0', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(131, 24, 49, 'historical_context', 'Axiomatische Methode und Abgrenzung gegenüber klassischen geometrischen und mengentheoretischen Ausgangsstrukturen.', '3.3.0', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(138, 1, 2, 'historical_context', 'Aristoteles dient als historischer Ausgangspunkt für die relationale und bewegungsbezogene Bestimmung von Raum und Zeit.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(139, 2, 2, 'historical_context', 'Newton belegt die klassische Setzung von absolutem Raum und absoluter Zeit als primitive physikalische Bezugsgrößen.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(140, 3, 2, 'critique', 'Mach belegt die Kritik an unbeobachtbaren absoluten Größen und den Übergang zu relationalen Beschreibungen.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(141, 4, 2, 'state_of_research', 'Einsteins Spezielle Relativitätstheorie belegt die Relativierung räumlicher und zeitlicher Messgrößen.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(142, 5, 2, 'state_of_research', 'Einsteins Allgemeine Relativitätstheorie belegt die Dynamisierung der Raumzeitgeometrie durch Materie und Energie.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(143, 6, 2, 'state_of_research', 'Minkowski belegt die mathematische Vereinigung von Raum und Zeit in einer vierdimensionalen Raumzeitstruktur.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(144, 7, 2, 'historical_context', 'Euklid belegt den Beginn axiomatischer Geometrie mit primitiven räumlichen Grundbegriffen.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(145, 8, 2, 'historical_context', 'Hilbert belegt die formale Rolle primitiver Begriffe und Axiome in mathematischen Theorien.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(146, 9, 2, 'comparison', 'Bourbaki belegt, dass die Topologie bereits eine Grundmenge und eine Topologie voraussetzt.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(147, 10, 2, 'comparison', 'Lang belegt, dass Differentialgeometrie bereits differenzierbare Mannigfaltigkeiten voraussetzt.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(148, 11, 2, 'comparison', 'Rudin belegt, dass Funktionalanalysis bereits normierte, Banach- oder Hilberträume voraussetzt.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(149, 12, 2, 'state_of_research', 'Haken belegt die Entstehung makroskopischer Ordnung aus lokalen Wechselwirkungen und Ordnungsparametern.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(150, 13, 2, 'state_of_research', 'Prigogine und Stengers belegen die Entstehung dissipativer Strukturen fern vom Gleichgewicht.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(151, 14, 2, 'state_of_research', 'Holland belegt emergente Ordnung in komplexen adaptiven Systemen aus rekursiven lokalen Regeln.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(152, 15, 2, 'state_of_research', 'Barabási belegt die Entstehung komplexer Netzwerkstrukturen aus lokalen Verknüpfungs- und Wachstumsmechanismen.', 'Abschnitt 3.1.1', 1, 0, 'Vollständige Erstnennung im Fließtext; Wiederverwendung der bestehenden Masterquelle.', 14),
(153, 1, 3, 'historical_context', 'Aristoteles belegt die frühe relationale und bewegungsbezogene Bestimmung von Raum und Zeit.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(154, 2, 3, 'comparison', 'Newton belegt die Trennung von beobachtbaren Prozessen und absoluten Raum- und Zeitstrukturen.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(155, 3, 3, 'critique', 'Mach belegt die wissenschaftstheoretische Kritik an unbeobachtbaren absoluten Bezugsgrößen.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(156, 4, 3, 'state_of_research', 'Die Spezielle Relativitätstheorie belegt die Abhängigkeit räumlicher und zeitlicher Messgrößen vom Bezugssystem.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(157, 5, 3, 'state_of_research', 'Die Allgemeine Relativitätstheorie belegt die physikalische Dynamisierung der Raumzeitgeometrie.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(158, 6, 3, 'state_of_research', 'Minkowski belegt die mathematische Vereinigung räumlicher und zeitlicher Koordinaten in einer Raumzeitstruktur.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(159, 7, 3, 'historical_context', 'Euklid belegt die axiomatische Verwendung primitiver räumlicher Grundbegriffe.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(160, 8, 3, 'critique', 'Hilbert belegt die methodische Notwendigkeit primitiver Begriffe und zugleich deren Abhängigkeit vom gewählten Axiomensystem.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(161, 9, 3, 'comparison', 'Bourbaki belegt, dass moderne Topologie eine Grundmenge und eine darauf definierte Struktur voraussetzt.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(162, 10, 3, 'comparison', 'Lang belegt, dass Differentialgeometrie bereits differenzierbare Mannigfaltigkeiten voraussetzt.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(163, 11, 3, 'comparison', 'Rudin belegt, dass funktionalanalytische Modelle bereits definierte normierte Räume voraussetzen.', 'Abschnitt 3.1.2', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 15),
(164, 16, 3, 'first_citation', 'Arnold belegt, dass auch die moderne Theorie dynamischer Systeme Entwicklungen innerhalb eines vorgegebenen Phasenraums beschreibt.', 'Abschnitt 3.1.2', 1, 0, 'Vollständige Erstnennung im Fließtext von Abschnitt 3.1.2.', 15),
(168, 8, 4, 'method', 'Hilberts axiomatische Methode begründet die notwendige Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten Aussagen.', 'Abschnitt 3.1.3', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 16),
(169, 12, 4, 'state_of_research', 'Die Synergetik belegt, dass makroskopische Ordnungsstrukturen aus lokalen Wechselwirkungen hervorgehen können.', 'Abschnitt 3.1.3', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 16),
(170, 13, 4, 'state_of_research', 'Die Theorie dissipativer Strukturen belegt die Entstehung stabiler Organisation fern vom thermodynamischen Gleichgewicht.', 'Abschnitt 3.1.3', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 16),
(171, 14, 4, 'state_of_research', 'Die Theorie komplexer adaptiver Systeme belegt, dass globale Ordnung aus lokalen Regeln und Rückkopplungen entstehen kann.', 'Abschnitt 3.1.3', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 16),
(172, 15, 4, 'state_of_research', 'Die Netzwerkwissenschaft belegt die Entstehung globaler Struktur aus lokalen Verknüpfungs- und Wachstumsmechanismen.', 'Abschnitt 3.1.3', 0, 0, 'Wiederverwendung nach vollständiger Erstnennung in Abschnitt 3.1.1.', 16),
(173, 17, 4, 'first_citation', 'Gödels Unvollständigkeitssätze begrenzen den Anspruch formaler Systeme, sämtliche für sie relevanten Wahrheiten aus sich selbst heraus abzuleiten.', 'Abschnitt 3.1.3', 1, 0, 'Vollständige Erstnennung im Fließtext von Abschnitt 3.1.3.', 16),
(174, 18, 4, 'first_citation', 'Whitehead und Russell stehen für den Versuch, mathematische Aussagen auf eine kleine Menge logisch formulierter Grundannahmen zurückzuführen.', 'Abschnitt 3.1.3', 1, 0, 'Vollständige Erstnennung im Fließtext von Abschnitt 3.1.3.', 16),
(175, 19, 5, 'state_of_research', 'Schleifenquantengravitation als Ansatz diskreter und quantisierter Geometrie.', 'Abschnitt 3.1.4', 0, 1, 'Quelle war bereits im Repository vorhanden.', 18),
(176, 58, 5, 'first_citation', 'Kanonische und mathematische Grundlagen der Schleifenquantengravitation.', 'Abschnitt 3.1.4', 1, 1, 'Neue Quelle des Abschnitts.', 18),
(177, 59, 5, 'first_citation', 'Causal-Set-Theorie: Raumzeit als diskrete kausale Ordnungsstruktur.', 'Abschnitt 3.1.4', 1, 1, 'Neue Quelle des Abschnitts.', 18),
(178, 60, 5, 'first_citation', 'Rekonstruktion von Raumzeitgeometrie aus Quantenverschränkung.', 'Abschnitt 3.1.4', 1, 1, 'Neue Quelle des Abschnitts.', 18),
(179, 61, 5, 'first_citation', 'Tensornetzwerke und Entanglement-Renormalisierung als holographische Geometriestruktur.', 'Abschnitt 3.1.4', 1, 1, 'Neue Quelle des Abschnitts.', 18),
(180, 62, 5, 'first_citation', 'Gravitation als emergentes beziehungsweise entropisches Phänomen.', 'Abschnitt 3.1.4', 1, 1, 'Neue Quelle des Abschnitts.', 18),
(181, 21, 5, 'state_of_research', 'Information als möglicher Ausgangspunkt physikalischer Realität im It-from-Bit-Ansatz.', 'Abschnitt 3.1.4', 0, 1, 'Wheeler ist bereits als Quelle [21] im Repository vorhanden.', 18),
(182, 8, 6, 'method', 'Hilberts axiomatische Methode begründet die Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten Strukturen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.1.', 19),
(183, 12, 6, 'comparison', 'Die Synergetik dient als Referenz für emergente makroskopische Ordnung aus lokalen Wechselwirkungen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.1.', 19),
(184, 13, 6, 'comparison', 'Dissipative Strukturen dienen als Referenz für dynamisch erhaltene Organisation.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.1.', 19),
(185, 14, 6, 'comparison', 'Komplexe adaptive Systeme dienen als Referenz für rekursive Organisationsbildung.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.1.', 19),
(186, 15, 6, 'comparison', 'Netzwerkwissenschaft dient als Referenz für globale Struktur aus lokalen Verknüpfungsmechanismen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.1.', 19),
(187, 17, 6, 'method', 'Gödels Resultate begrenzen einen universalen Vollständigkeitsanspruch des Axiomensystems.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.3.', 19),
(188, 19, 6, 'comparison', 'Schleifenquantengravitation dient zur Abgrenzung des FRZK von physikalischen Quantengravitationsprogrammen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(189, 21, 6, 'comparison', 'Wheelers informationeller Ansatz dient zur Abgrenzung des FRZK von einer Ontologie physikalischer Information.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(190, 58, 6, 'comparison', 'Thiemanns kanonische Quantengravitation dient zur Abgrenzung des FRZK von physikalischen Raumzeitmodellen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(191, 59, 6, 'comparison', 'Die Causal-Set-Theorie dient zur Abgrenzung des FRZK von Theorien mit vorausgesetzten Ereignissen und Kausalrelationen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(192, 60, 6, 'comparison', 'Verschränkungsbasierte Raumzeitrekonstruktion dient zur Abgrenzung des FRZK von Hilbertraum-basierten Ansätzen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(193, 61, 6, 'comparison', 'Tensornetzwerke dienen zur Abgrenzung des FRZK von bereits mathematisch strukturierten Netzwerkmodellen.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(194, 62, 6, 'comparison', 'Emergente Gravitation dient zur Abgrenzung des FRZK von thermodynamisch-informationellen Gravitationstheorien.', 'Abschnitt 3.1.5', 0, 1, 'Wiederverwendung nach Erstnennung in 3.1.4.', 19),
(197, 8, 8, 'method', 'Hilberts axiomatische Methode begründet die Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten mathematischen Strukturen.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(198, 9, 8, 'background', 'Die Topologie steht beispielhaft für mathematische Theorien, die auf bereits definierten Grundmengen und Strukturen aufbauen.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(199, 11, 8, 'background', 'Die Funktionalanalysis steht beispielhaft für Operatoren auf vorausgesetzten Banach- und Hilberträumen.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(200, 12, 8, 'state_of_research', 'Die Synergetik dient als Referenz für mathematische Modelle emergenter Ordnungsbildung.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(201, 13, 8, 'state_of_research', 'Dissipative Strukturen dienen als Referenz für dynamisch erhaltene Organisation.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(202, 14, 8, 'state_of_research', 'Komplexe adaptive Systeme dienen als Referenz für rekursive Organisationsbildung.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(203, 15, 8, 'state_of_research', 'Die Netzwerkwissenschaft dient als Referenz für mathematische Beziehungsstrukturen komplexer Systeme.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 20),
(204, 16, 8, 'background', 'Die Theorie dynamischer Systeme steht für zeitliche Entwicklungen in vorausgesetzten Zustands- und Phasenräumen.', 'Abschnitt 3.2.0', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.2.', 20),
(205, 23, 9, 'state_of_research', 'Cantors Arbeiten begründen die systematische Theorie unendlicher Mengen und die allgemeine mengentheoretische Abstraktion.', 'Abschnitt 3.2.1', 0, 1, 'Die Quelle wurde bereits im bisherigen Repository als [23] erstgenannt und wird in der Neufassung wiederverwendet.', 21),
(206, 63, 9, 'first_citation', 'Das Werk systematisiert die axiomatischen Grundlagen der Mengenlehre und die für ZFC charakteristischen Existenz- und Bildungsbedingungen.', 'Abschnitt 3.2.1', 1, 0, 'Neue Quelle der Neufassung; bibliografische Detailprüfung bleibt im Repository als needs_review markiert.', 21),
(207, 27, 10, 'state_of_research', 'Enderton dient als Referenz für den mengentheoretischen Relationsbegriff und seine formale Einbettung in kartesische Produkte.', 'Abschnitt 3.2.2', 0, 1, 'Wiederverwendung einer bereits im Repository vorhandenen Quelle.', 22),
(208, 28, 10, 'state_of_research', 'Davey und Priestley dienen als Referenz für Ordnungsrelationen, Äquivalenzrelationen und strukturierte relationale Systeme.', 'Abschnitt 3.2.2', 0, 1, 'Wiederverwendung einer bereits im Repository vorhandenen Quelle.', 22),
(209, 29, 11, 'state_of_research', 'Lang dient als Referenz für den allgemeinen Funktionsbegriff, Definitions- und Zielmengen sowie die eindeutige Zuordnung.', 'Abschnitt 3.2.3', 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [29].', 23),
(210, 30, 11, 'state_of_research', 'Rudin dient als Referenz für Funktionen, Kompositionen und iterative mathematische Entwicklungen in der Analysis.', 'Abschnitt 3.2.3', 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [30].', 23),
(211, 31, 12, 'state_of_research', 'Dummit und Foote dienen als Hauptreferenz für Halbgruppen, Monoide, Gruppen, Ringe und Körper.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [31].', 24),
(212, 32, 12, 'state_of_research', 'Lang dient als Referenz für abstrakte algebraische Verknüpfungen und Gruppenstrukturen.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [32].', 24),
(213, 33, 12, 'state_of_research', 'Hall dient als Referenz für Lie-Gruppen und deren Bedeutung für kontinuierliche Transformationen und Symmetrien.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [33].', 24),
(214, 34, 12, 'state_of_research', 'Artin dient als ergänzende Referenz für Gruppen, Vektorräume und algebraische Strukturbegriffe.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [34].', 24),
(215, 35, 13, 'first_citation', 'Conway dient als Hauptreferenz für Operatoren auf Banach- und Hilberträumen, Linearität und Operatorkomposition.', 'Abschnitt 3.2.5', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [35].', 25),
(216, 36, 13, 'first_citation', 'Kreyszig dient als ergänzende Referenz für normierte Räume, lineare Operatoren und Anwendungen der Funktionalanalysis.', 'Abschnitt 3.2.5', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [36].', 25),
(217, 37, 13, 'first_citation', 'Strogatz dient als Referenz für nichtlineare Transformationen, Iteration, Fixpunkte und dynamische Konsequenzen rekursiver Operatoranwendung.', 'Abschnitt 3.2.5', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [37].', 25),
(221, 41, 15, 'first_citation', 'Reed und Simon dienen als Hauptreferenz für Hilberträume, Operatoren und spektrale Strukturen in der mathematischen Physik.', 'Abschnitt 3.2.7', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [41].', 27),
(222, 42, 15, 'first_citation', 'Yosida dient als Hauptreferenz für normierte Räume, Banachräume, Vollständigkeit und lineare Funktionalanalysis.', 'Abschnitt 3.2.7', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [42].', 27),
(223, 35, 15, 'background', 'Conway wird als ergänzende Referenz für Operatoren und Hilbertraumstrukturen wiederverwendet.', 'Abschnitt 3.2.7', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.2.5.', 27),
(224, 36, 15, 'background', 'Kreyszig wird als ergänzende Referenz für normierte Räume, Banachräume und Anwendungen der Funktionalanalysis wiederverwendet.', 'Abschnitt 3.2.7', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.2.5.', 27),
(225, 37, 16, 'state_of_research', 'Strogatz dient als Referenz für Fixpunkte, Bifurkationen, Attraktoren und nichtlineare Dynamik.', 'Abschnitt 3.2.8', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.2.5.', 28),
(226, 39, 16, 'state_of_research', 'Khalil dient als Referenz für lokale Stabilität, Linearisierung und Lyapunov-Methoden nichtlinearer Systeme.', 'Abschnitt 3.2.8', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.2.6.', 28),
(227, 40, 16, 'state_of_research', 'Hirsch, Smale und Devaney dienen als Referenz für Phasenräume, Trajektorien und qualitative Dynamik.', 'Abschnitt 3.2.8', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.2.6.', 28),
(228, 43, 16, 'first_citation', 'Katok und Hasselblatt dienen als Hauptreferenz für die moderne Theorie dynamischer Systeme, Invarianz und langfristige Zustandsentwicklung.', 'Abschnitt 3.2.8', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [43].', 28),
(229, 44, 16, 'first_citation', 'Ott dient als Referenz für Chaos, sensitive Abhängigkeit von Anfangsbedingungen und Lyapunov-Exponenten.', 'Abschnitt 3.2.8', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [44].', 28),
(230, 45, 17, 'first_citation', 'Cover und Thomas dienen als Referenz für Entropie, gemeinsame Entropie, gegenseitige Information und Divergenzmaße.', 'Abschnitt 3.2.9', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [45].', 29),
(231, 46, 17, 'first_citation', 'Shannon dient als Primärquelle für Informationsgehalt, Entropie, Kanal und statistische Quantifizierung von Unsicherheit.', 'Abschnitt 3.2.9', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [46].', 29),
(232, 47, 18, 'first_citation', 'Diestel dient als Hauptreferenz für Graphen, Knoten, Kanten, Wege und grundlegende graphentheoretische Strukturen.', 'Abschnitt 3.2.10', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [47].', 30),
(233, 48, 18, 'first_citation', 'Newman dient als Hauptreferenz für Netzwerkmaße, Gradverteilungen, Dichte, Clusterbildung und komplexe Netzwerke.', 'Abschnitt 3.2.10', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [48].', 30),
(234, 15, 18, 'state_of_research', 'Barabási wird als Referenz für emergente Netzwerkstrukturen, Wachstum und skalenfreie Organisation wiederverwendet.', 'Abschnitt 3.2.10', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 30),
(235, 49, 19, 'first_citation', 'Burago, Burago und Ivanov dienen als Hauptreferenz für metrische Räume, Metrikaxiome und geometrische Distanzstrukturen.', 'Abschnitt 3.2.11', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [49].', 31),
(236, 50, 19, 'first_citation', 'Manning, Raghavan und Schütze dienen als Referenz für Vektorraummodelle und Kosinusähnlichkeit im Information Retrieval.', 'Abschnitt 3.2.11', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [50].', 31),
(237, 51, 20, 'first_citation', 'Camazine et al. dienen als Hauptreferenz für Selbstorganisation in biologischen Systemen, lokale Interaktion und stigmergische Strukturbildung.', 'Abschnitt 3.2.12', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [51].', 32),
(238, 52, 20, 'first_citation', 'Mitchell dient als Referenz für Komplexität, emergente Muster und die Grenzen rein reduktionistischer Beschreibungen.', 'Abschnitt 3.2.12', 1, 1, 'Erstnennung der bereits im Repository vorhandenen Quelle [52].', 32),
(239, 12, 20, 'state_of_research', 'Haken wird als Referenz für Ordnungsparameter, Versklavungsprinzip und makroskopische Musterbildung wiederverwendet.', 'Abschnitt 3.2.12', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 32),
(240, 14, 20, 'state_of_research', 'Holland wird als Referenz für adaptive Systeme, lokale Regeln und globale Organisationsbildung wiederverwendet.', 'Abschnitt 3.2.12', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 32),
(241, 8, 51, 'method', 'Hilberts axiomatische Methode dient als Referenz für die Trennung zwischen primitiven Begriffen, Axiomen und abgeleiteten Aussagen.', 'Abschnitt 3.3.2', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.1.', 34),
(242, 18, 51, 'comparison', 'Whitehead und Russell dienen als Referenz für die systematische Reduktion komplexer mathematischer Strukturen auf explizite logische Ausgangsannahmen.', 'Abschnitt 3.3.2', 0, 1, 'Wiederverwendung nach Erstnennung in Abschnitt 3.1.3.', 34),
(243, 24, 51, 'comparison', 'Zermelos axiomatische Mengenlehre dient zur Abgrenzung des FRZK von Theorien, die Mengen und Elemente bereits als primitive mathematische Objekte voraussetzen.', 'Abschnitt 3.3.2', 0, 1, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 34);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `symbols`
--

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

--
-- Daten für Tabelle `symbols`
--

INSERT INTO `symbols` (`symbol_id`, `symbol_latex`, `symbol_word_latex`, `symbol_name`, `definition_text`, `scope_type`, `first_section_id`, `first_equation_id`, `unit_text`, `domain_text`, `codomain_text`, `is_vector`, `is_matrix`, `is_operator`, `notes`, `validation_status`, `created_revision_id`) VALUES
(1, '\\longrightarrow', '\\longrightarrow', 'gerichteter Entwicklungspfeil', 'Kennzeichnet in den schematischen Gleichungen eine logisch oder funktional gerichtete Entwicklungsfolge.', 'global', 6, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 3),
(2, 'M', 'M', 'Menge', 'Allgemeine Menge mathematischer Objekte.', 'global', 9, 3, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(3, 'A', 'A', 'Grundmenge oder Matrix', 'Kontextabhängig eine Menge oder Systemmatrix.', 'chapter', 9, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, 'checked', 6),
(4, 'B', 'B', 'Ziel- oder Vergleichsmenge', 'Kontextabhängig eine mathematische Menge.', 'chapter', 9, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(5, 'R', 'R', 'Relation', 'Binäre Relation zwischen mathematischen Elementen.', 'global', 10, 9, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(6, 'f', 'f', 'Funktion', 'Eindeutige Abbildung zwischen Mengen.', 'global', 11, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(7, 'T', 'T', 'Operator', 'Transformation zwischen mathematischen Räumen.', 'global', 13, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 6),
(8, 'X', 'X', 'Zustandsvektor', 'Vollständiger Zustand eines Systems.', 'global', 14, NULL, NULL, NULL, NULL, 1, 0, 0, NULL, 'checked', 6),
(9, '\\mathcal{X}', '\\mathcal{X}', 'Zustandsraum', 'Menge aller zulässigen Zustände.', 'global', 14, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(10, 'F', 'F', 'Entwicklungsfunktion', 'Funktion oder Operator der Zustandsentwicklung.', 'chapter', 14, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 6),
(11, 'G', 'G', 'Graph', 'Geordnetes Paar aus Knoten- und Kantenmenge.', 'global', 18, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(12, 'V', 'V', 'Knotenmenge oder Vektorraum', 'Kontextabhängig Knotenmenge beziehungsweise Vektorraum.', 'chapter', 12, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(13, 'E', 'E', 'Kantenmenge', 'Menge der Kanten eines Graphen.', 'global', 18, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(14, 'd', 'd', 'Metrik', 'Abstandsfunktion auf einem metrischen Raum.', 'global', 19, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(15, 'H', 'H', 'Entropie', 'Shannon-Entropie einer Zufallsvariablen.', 'chapter', 17, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(16, 'I', 'I', 'Information', 'Informationsgehalt oder gegenseitige Information.', 'chapter', 17, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(17, 'D_{KL}', 'D_{KL}', 'Kullback-Leibler-Divergenz', 'Divergenz zweier Wahrscheinlichkeitsverteilungen.', 'global', 17, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(18, '\\eta', '\\eta', 'Ordnungsparameter', 'Makroskopischer Parameter der Systemordnung.', 'global', 20, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(19, '\\mathcal{M}', '\\mathcal{M}', 'Mathematisches Modell', 'Zusammenfassung von Menge, Relationen, Funktionen, Operatoren und Zustandsraum.', 'global', 21, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(20, '\\mathcal{F}', '\\mathcal{F}', 'Funktionale Wechselwirkungen', 'Gesamtheit funktionaler Wechselwirkungen.', 'global', 21, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(21, '\\mathcal{P}', '\\mathcal{P}', 'Physikalische Manifestationen', 'Physikalische Manifestation mathematischer Strukturen.', 'global', 21, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(36, '\\Delta_F', '\\Delta_F', 'funktionale Unterscheidbarkeit', 'Prämathematisches Symbol für die Möglichkeit funktionaler Unterscheidbarkeit.', 'chapter', 52, NULL, NULL, NULL, NULL, 0, 0, 0, 'Noch keine mathematische Funktion; Formalisierung erst in Kapitel 3.4.', 'checked', 10),
(37, '\\mathcal{R}_F', '\\mathcal{R}_F', 'funktionale Relationierbarkeit', 'Prämathematisches Symbol für die Möglichkeit funktionaler Zusammenhangsbildung.', 'chapter', 53, NULL, NULL, NULL, NULL, 0, 0, 0, 'Noch keine mengentheoretische Relation.', 'checked', 10),
(38, '\\mathcal{T}_F', '\\mathcal{T}_F', 'rekursive funktionale Transformation', 'Prämathematisches Symbol für die Möglichkeit rekursiver Transformation.', 'chapter', 54, NULL, NULL, NULL, NULL, 0, 0, 0, 'Noch kein mathematischer Transformationsoperator.', 'checked', 10),
(39, '\\mathcal{O}_F', '\\mathcal{O}_F', 'stabile funktionale Organisation', 'Prämathematisches Symbol für die Möglichkeit stabiler funktionaler Organisation.', 'chapter', 55, NULL, NULL, NULL, NULL, 0, 0, 0, 'In Kapitel 3.3 ausdrücklich kein Operator.', 'checked', 10),
(40, '\\mathcal{P}_F', '\\mathcal{P}_F', 'reproduzierbare Organisationsmuster', 'Prämathematisches Symbol für die Möglichkeit reproduzierbarer Organisationsmuster.', 'chapter', 56, NULL, NULL, NULL, NULL, 0, 0, 0, 'Mathematische Äquivalenz und Kohärenz werden erst in Kapitel 3.4 definiert.', 'checked', 10),
(41, '\\mathcal{F}', '\\mathcal{F}', 'funktionale Organisation', 'Konzeptionelle Bezeichnung des durch alle fünf Axiome eröffneten theoretischen Rahmens.', 'chapter', 58, NULL, NULL, NULL, NULL, 0, 0, 0, 'Noch keine festgelegte mathematische Struktur.', 'checked', 10),
(42, '\\Diamond', '\\Diamond', 'Möglichkeitsoperator', 'Modallogischer Operator zur Kennzeichnung prinzipieller Möglichkeit.', 'chapter', 53, NULL, NULL, NULL, NULL, 0, 0, 1, 'Wird in den Axiomen A2 bis A5 verwendet.', 'checked', 10),
(43, '\\prec', '\\prec', 'methodische Konstruktionsfolge', 'Kennzeichnet ausschließlich die Reihenfolge der Konstruktion in Kapitel 3.4.', 'chapter', 58, NULL, NULL, NULL, NULL, 0, 0, 0, 'Keine mathematische Ordnungsrelation.', 'checked', 10),
(60, '\\Omega_F', '\\Omega_F', 'Funktionale Konfigurationsmenge', 'Trägermenge aller funktionalen Konfigurationen.', 'chapter', 61, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(61, '\\omega', '\\omega', 'Funktionale Konfiguration', 'Einzelne funktionale Konfiguration.', 'chapter', 61, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(62, '\\Delta_F', '\\Delta_F', 'Funktionale Differenzabbildung', 'Nichtnegative Abbildung zur Beschreibung funktionaler Verschiedenheit.', 'chapter', 61, NULL, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 11),
(63, '\\mathcal{R}_F', '\\mathcal{R}_F', 'Funktionale Relationsstruktur', 'Menge funktionaler Relationen.', 'chapter', 62, 183, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(64, '\\mathcal{T}_F', '\\mathcal{T}_F', 'Funktionaler Transformationsoperator', 'Rekursiver Operator auf Relationen oder Zuständen.', 'chapter', 63, 189, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 11),
(65, '\\mathcal{O}', '\\mathcal{O}', 'Invariante Organisationsstruktur', 'Unter Transformationen invariante Teilstruktur.', 'chapter', 64, 195, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(66, '\\mathfrak{O}_F', '\\mathfrak{O}_F', 'Funktionaler Organisationsraum', 'Paar aus Organisationsstruktur und Transformationsoperator.', 'chapter', 64, 196, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(67, '\\mathcal{X}_F', '\\mathcal{X}_F', 'Funktionale Zustandsmenge', 'Menge aller funktionalen Zustände.', 'chapter', 65, 201, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(68, '\\mathfrak{X}_F', '\\mathfrak{X}_F', 'Funktionaler Zustandsraum', 'Tripel aus Zuständen, Organisation und Transformation.', 'chapter', 65, 202, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(69, '\\mathcal{K}', '\\mathcal{K}', 'Kohärente Zustandsmenge', 'Unter Transformationen invariante Zustandsmenge.', 'chapter', 66, 207, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(70, '\\mathcal{K}_F', '\\mathcal{K}_F', 'Funktionale Kohärenzstruktur', 'Menge beziehungsweise Klasse funktional kohärenter Strukturen.', 'chapter', 66, 208, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(71, '\\Psi_F', '\\Psi_F', 'Kohärenzoperator', 'Zuordnung von Zuständen zu Kohärenzstrukturen.', 'chapter', 66, 208, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 11),
(72, '\\leadsto', '\\leadsto', 'Funktionale Erreichbarkeitsrelation', 'Erreichbarkeit durch eine endliche Folge rekursiver Transformationen.', 'chapter', 67, 213, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(73, '\\mathfrak{R}_F', '\\mathfrak{R}_F', 'Funktionale Raumstruktur', 'Paar aus Zustandsmenge und Erreichbarkeitsrelation.', 'chapter', 67, 216, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(74, '\\prec_T', '\\prec_T', 'Funktionale Transformationsordnung', 'Strikte Ordnung funktionaler Zustände durch Transformationen.', 'chapter', 68, 219, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(75, '\\mathfrak{T}_F', '\\mathfrak{T}_F', 'Funktionale Zeitstruktur', 'Paar aus Raumstruktur und Transformationsordnung.', 'chapter', 68, 220, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `theorems`
--

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

--
-- Daten für Tabelle `theorems`
--

INSERT INTO `theorems` (`theorem_id`, `theorem_number`, `section_id`, `title`, `statement_text`, `statement_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(9, 'Satz 3.4.1', 61, 'Existenz einer funktionalen Differenzstruktur', 'Das Paar aus funktionalen Konfigurationen und Differenzabbildung bildet eine funktionale Differenzstruktur.', '(\\Omega_F,\\Delta_F)', '(\\Omega_F,\\Delta_F)', 'original', NULL, NULL, 'checked', 11),
(10, 'Satz 3.4.2', 62, 'Funktionale Relationsstruktur', 'Das Paar aus funktionalen Konfigurationen und funktionaler Relation bildet eine funktionale Relationsstruktur.', '(\\Omega_F,\\mathcal{R}_F)', '(\\Omega_F,\\mathcal{R}_F)', 'original', NULL, NULL, 'checked', 11),
(11, 'Satz 3.4.3', 63, 'Abgeschlossenheit funktionaler Transformationen', 'Jede nach Def. 3.4.5 definierte funktionale Transformation bildet einen funktionalen Zustand wieder auf einen funktionalen Zustand derselben Zustandsklasse ab.', '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X', '\\forall x\\in X:\\;\\mathcal{T}_F(x)\\in X', 'original', NULL, 'Def. 3.4.2 und Def. 3.4.5 gelten.', 'checked', 47),
(12, 'Satz 3.4.4', 64, 'Existenz funktionaler Organisationsräume', 'Existiert eine organisationserzeugende Transformation mit einer nichtleeren invarianten Organisationsmenge, dann existiert ein funktionaler Organisationsraum.', '\\exists\\,\\mathcal{T}_F,\\mathcal{O}_F:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F', '\\exists\\,\\mathcal{T}_F,\\mathcal{O}_F:\\;\\mathcal{T}_F(\\mathcal{O}_F)=\\mathcal{O}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F', 'original', NULL, 'Def. 3.4.7 und Def. 3.4.8 gelten.', 'checked', 48),
(13, 'Satz 3.4.5', 65, 'Existenz kohärenter Organisationsräume', 'Existiert für einen funktionalen Organisationsraum eine kohärenzerhaltende Transformation, dann besitzt dieser Organisationsraum einen wohldefinierten Kohärenzwert.', '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)', '\\exists\\,\\mathcal{T}_F:\\;\\kappa\\!\\left(\\mathcal{T}_F(\\mathfrak{O}_F)\\right)=\\kappa(\\mathfrak{O}_F)\\Longrightarrow\\exists\\,\\kappa(\\mathfrak{O}_F)', 'original', NULL, 'Def. 3.4.9 und Def. 3.4.10 gelten.', 'checked', 49),
(14, 'Satz 3.4.6', 66, 'Existenz eines Funktionalen Raum-Zeit-Kohärenzsystems', 'Existieren funktionale Organisationsräume, eine auf ihnen definierte Kohärenzrelation und eine zugehörige Raum-Zeit-Kohärenzfunktion, dann existiert ein Funktionales Raum-Zeit-Kohärenzsystem.', '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)', '\\mathfrak{FRZK}=\\left(\\mathfrak{O}_F,\\mathcal{K},\\chi\\right)', 'original', NULL, 'Def. 3.4.8, Def. 3.4.11 und Def. 3.4.12 gelten.', 'checked', 50),
(15, 'Satz 3.4.7', 67, 'Rekonstruktion funktionaler Entwicklung', 'Jede wohldefinierte endliche rekursive Transformationsfolge auf funktionalen Organisationsräumen erzeugt eine eindeutig bestimmte funktionale Entwicklungsbahn.', '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F', '\\mathcal{T}_F^{\\,n}\\Longrightarrow\\Gamma_F', 'original', NULL, 'Def. 3.4.6, Def. 3.4.8 und Def. 3.4.14 gelten; die verwendete Transformation ist wohldefiniert.', 'checked', 51),
(16, 'Satz 3.4.8', 68, 'Existenz stabiler funktionaler Attraktoren', 'Verläuft eine unendliche deterministische Entwicklungsbahn in einer endlichen Menge funktionaler Organisationsräume, dann wird mindestens ein Organisationsraum wiederholt erreicht und gehört damit zur Attraktorenmenge.', '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F', '\\left|\\{\\mathfrak{O}_i\\}\\right|<\\infty\\Longrightarrow\\exists\\,\\mathfrak{O}_A\\in\\mathcal{A}_F', 'original', NULL, 'Def. 3.4.14 bis Def. 3.4.16 gelten; die Entwicklungsbahn ist deterministisch, unendlich fortsetzbar und nimmt Werte in einer endlichen Menge funktionaler Organisationsräume an.', 'checked', 52);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `topics`
--

CREATE TABLE `topics` (
  `topic_id` bigint(20) UNSIGNED NOT NULL,
  `parent_topic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `topic_code` varchar(100) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `topics`
--

INSERT INTO `topics` (`topic_id`, `parent_topic_id`, `topic_code`, `label`, `description`) VALUES
(1, NULL, 'PHIL_SPACE_TIME', 'Raum- und Zeitphilosophie', NULL),
(2, NULL, 'PHYS_RELATIVITY', 'Relativitätstheorie', NULL),
(3, NULL, 'MATH_AXIOMATICS', 'Axiomatik', NULL),
(4, NULL, 'MATH_TOPOLOGY', 'Topologie', NULL),
(5, NULL, 'MATH_DIFFERENTIAL_GEOMETRY', 'Differentialgeometrie', NULL),
(6, NULL, 'MATH_FUNCTIONAL_ANALYSIS', 'Funktionalanalysis', NULL),
(7, NULL, 'MATH_DYNAMICAL_SYSTEMS', 'Dynamische Systeme', NULL),
(8, NULL, 'COMPLEXITY_SELF_ORGANIZATION', 'Selbstorganisation und Emergenz', NULL),
(9, NULL, 'NETWORK_SCIENCE', 'Netzwerkwissenschaft', NULL),
(10, NULL, 'QUANTUM_GRAVITY', 'Quantengravitation', NULL),
(11, NULL, 'INFORMATION_FOUNDATIONS', 'Information als Grundlage', NULL),
(12, NULL, 'FRZK_FOUNDATION', 'FRZK-Grundlegung', NULL);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_acronym_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_acronym_register` (
`acronym` varchar(100)
,`full_form` varchar(1000)
,`explanation` longtext
,`first_section_code` varchar(50)
,`category` varchar(255)
,`is_project_specific` tinyint(1)
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_assumption_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_assumption_register` (
`assumption_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`assumption_text` longtext
,`word_latex` longtext
,`status` enum('proposed','accepted','rejected','superseded')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_axiom_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_axiom_register` (
`axiom_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`axiom_text` longtext
,`word_latex` longtext
,`status` enum('draft','review','accepted','revised','rejected')
,`based_on_assumption` varchar(50)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_chapter_bibliography`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_chapter_bibliography` (
`chapter_no` int(11)
,`citation_number` int(10) unsigned
,`full_citation_text` text
,`short_citation_text` varchar(500)
,`priority` tinyint(3) unsigned
,`frzk_relevance` tinyint(3) unsigned
,`verification_status` enum('imported','partially_verified','verified','needs_review')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_citation_audit`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_citation_audit` (
`citation_number` int(10) unsigned
,`source_key` varchar(150)
,`full_citation_text` text
,`verification_status` enum('imported','partially_verified','verified','needs_review')
,`usage_count` bigint(21)
,`first_mention_count` decimal(22,0)
,`first_used_section` varchar(50)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_definition_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_definition_register` (
`definition_number` varchar(50)
,`section_code` varchar(50)
,`section_title` varchar(500)
,`title` varchar(500)
,`definition_text` longtext
,`word_latex` longtext
,`provenance` enum('original','adapted','literature')
,`source_citation_number` int(10) unsigned
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_equation_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_equation_register` (
`equation_number` varchar(50)
,`section_code` varchar(50)
,`section_title` varchar(500)
,`title` varchar(500)
,`word_latex` text
,`plain_description` text
,`provenance` enum('original','adapted','literature')
,`source_citation_number` int(10) unsigned
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_figure_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_figure_register` (
`figure_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`caption` longtext
,`file_name` varchar(500)
,`file_path` varchar(1500)
,`provenance` enum('original','adapted','literature')
,`source_citation_number` int(10) unsigned
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_pending_source_audit`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_pending_source_audit` (
`pending_source_id` bigint(20) unsigned
,`proposed_source_key` varchar(150)
,`title` varchar(1000)
,`authors_text` varchar(1000)
,`proposed_section_code` varchar(50)
,`priority` tinyint(3) unsigned
,`review_status` enum('open','in_review','accepted','rejected','merged')
,`discovered_at` timestamp
,`reviewed_at` datetime
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_proof_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_proof_register` (
`proof_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`proof_method` enum('direct','contradiction','induction','construction','equivalence','existence','uniqueness','computational','other')
,`provenance` enum('original','adapted','literature')
,`source_citation_number` int(10) unsigned
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_proposition_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_proposition_register` (
`proposition_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`statement_text` longtext
,`word_latex` longtext
,`based_on_axioms` varchar(255)
,`status` enum('draft','review','accepted','revised','rejected')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_section_inventory`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_section_inventory` (
`section_code` varchar(50)
,`title` varchar(500)
,`status` enum('planned','draft','review','final')
,`source_count` bigint(21)
,`equation_count` bigint(21)
,`definition_count` bigint(21)
,`theorem_count` bigint(21)
,`lemma_count` bigint(21)
,`corollary_count` bigint(21)
,`figure_count` bigint(21)
,`table_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_statement_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_statement_register` (
`statement_type` varchar(9)
,`statement_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`statement_text` longtext
,`word_latex` longtext
,`provenance` varchar(10)
,`source_citation_number` int(10) unsigned
,`validation_status` varchar(8)
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_symbol_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_symbol_register` (
`symbol_latex` varchar(255)
,`symbol_word_latex` varchar(255)
,`symbol_name` varchar(255)
,`definition_text` longtext
,`scope_type` enum('global','chapter','section','equation')
,`first_section_code` varchar(50)
,`first_equation_number` varchar(50)
,`unit_text` varchar(255)
,`domain_text` varchar(1000)
,`codomain_text` varchar(1000)
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `v_table_register`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_table_register` (
`table_number` varchar(50)
,`section_code` varchar(50)
,`title` varchar(500)
,`caption` longtext
,`file_name` varchar(500)
,`file_path` varchar(1500)
,`provenance` enum('original','adapted','literature')
,`source_citation_number` int(10) unsigned
,`validation_status` enum('draft','checked','verified')
);

-- --------------------------------------------------------

--
-- Struktur des Views `v_acronym_register`
--
DROP TABLE IF EXISTS `v_acronym_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_acronym_register`  AS SELECT `a`.`acronym` AS `acronym`, `a`.`full_form` AS `full_form`, `a`.`explanation` AS `explanation`, `ds`.`section_code` AS `first_section_code`, `a`.`category` AS `category`, `a`.`is_project_specific` AS `is_project_specific`, `a`.`validation_status` AS `validation_status` FROM (`acronyms` `a` left join `dissertation_sections` `ds` on(`ds`.`section_id` = `a`.`first_section_id`)) ORDER BY `a`.`acronym` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_assumption_register`
--
DROP TABLE IF EXISTS `v_assumption_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_assumption_register`  AS SELECT `a`.`assumption_number` AS `assumption_number`, `ds`.`section_code` AS `section_code`, `a`.`title` AS `title`, `a`.`assumption_text` AS `assumption_text`, `a`.`word_latex` AS `word_latex`, `a`.`status` AS `status` FROM (`assumptions` `a` join `dissertation_sections` `ds` on(`ds`.`section_id` = `a`.`section_id`)) ORDER BY `ds`.`section_order` ASC, `a`.`assumption_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_axiom_register`
--
DROP TABLE IF EXISTS `v_axiom_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_axiom_register`  AS SELECT `a`.`axiom_number` AS `axiom_number`, `ds`.`section_code` AS `section_code`, `a`.`title` AS `title`, `a`.`axiom_text` AS `axiom_text`, `a`.`word_latex` AS `word_latex`, `a`.`status` AS `status`, `asm`.`assumption_number` AS `based_on_assumption` FROM ((`axioms` `a` join `dissertation_sections` `ds` on(`ds`.`section_id` = `a`.`section_id`)) left join `assumptions` `asm` on(`asm`.`assumption_id` = `a`.`source_assumption_id`)) ORDER BY `ds`.`section_order` ASC, `a`.`axiom_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_chapter_bibliography`
--
DROP TABLE IF EXISTS `v_chapter_bibliography`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_chapter_bibliography`  AS SELECT DISTINCT `ds`.`chapter_no` AS `chapter_no`, `s`.`citation_number` AS `citation_number`, `s`.`full_citation_text` AS `full_citation_text`, `s`.`short_citation_text` AS `short_citation_text`, `s`.`priority` AS `priority`, `s`.`frzk_relevance` AS `frzk_relevance`, `s`.`verification_status` AS `verification_status` FROM ((`source_usage` `su` join `sources` `s` on(`s`.`source_id` = `su`.`source_id`)) join `dissertation_sections` `ds` on(`ds`.`section_id` = `su`.`section_id`)) WHERE `s`.`citation_number` is not null ORDER BY `ds`.`chapter_no` ASC, `s`.`citation_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_citation_audit`
--
DROP TABLE IF EXISTS `v_citation_audit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_citation_audit`  AS SELECT `s`.`citation_number` AS `citation_number`, `s`.`source_key` AS `source_key`, `s`.`full_citation_text` AS `full_citation_text`, `s`.`verification_status` AS `verification_status`, count(`su`.`usage_id`) AS `usage_count`, sum(case when `su`.`is_first_mention` = 1 then 1 else 0 end) AS `first_mention_count`, min(`ds`.`section_code`) AS `first_used_section` FROM ((`sources` `s` left join `source_usage` `su` on(`su`.`source_id` = `s`.`source_id`)) left join `dissertation_sections` `ds` on(`ds`.`section_id` = `su`.`section_id`)) GROUP BY `s`.`source_id`, `s`.`citation_number`, `s`.`source_key`, `s`.`full_citation_text`, `s`.`verification_status` ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_definition_register`
--
DROP TABLE IF EXISTS `v_definition_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_definition_register`  AS SELECT `d`.`definition_number` AS `definition_number`, `ds`.`section_code` AS `section_code`, `ds`.`title` AS `section_title`, `d`.`title` AS `title`, `d`.`definition_text` AS `definition_text`, `d`.`word_latex` AS `word_latex`, `d`.`provenance` AS `provenance`, `s`.`citation_number` AS `source_citation_number`, `d`.`validation_status` AS `validation_status` FROM ((`definitions` `d` join `dissertation_sections` `ds` on(`ds`.`section_id` = `d`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `d`.`source_id`)) ORDER BY `d`.`definition_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_equation_register`
--
DROP TABLE IF EXISTS `v_equation_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_equation_register`  AS SELECT `e`.`equation_number` AS `equation_number`, `ds`.`section_code` AS `section_code`, `ds`.`title` AS `section_title`, `e`.`title` AS `title`, `e`.`word_latex` AS `word_latex`, `e`.`plain_description` AS `plain_description`, `e`.`provenance` AS `provenance`, `s`.`citation_number` AS `source_citation_number`, `e`.`validation_status` AS `validation_status` FROM ((`equations` `e` join `dissertation_sections` `ds` on(`ds`.`section_id` = `e`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `e`.`source_id`)) ORDER BY cast(substring_index(`e`.`equation_number`,'.',1) as unsigned) ASC, cast(substring_index(`e`.`equation_number`,'.',-1) as unsigned) ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_figure_register`
--
DROP TABLE IF EXISTS `v_figure_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_figure_register`  AS SELECT `f`.`figure_number` AS `figure_number`, `ds`.`section_code` AS `section_code`, `f`.`title` AS `title`, `f`.`caption` AS `caption`, `f`.`file_name` AS `file_name`, `f`.`file_path` AS `file_path`, `f`.`provenance` AS `provenance`, `s`.`citation_number` AS `source_citation_number`, `f`.`validation_status` AS `validation_status` FROM ((`figures` `f` join `dissertation_sections` `ds` on(`ds`.`section_id` = `f`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `f`.`source_id`)) ORDER BY `f`.`figure_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_pending_source_audit`
--
DROP TABLE IF EXISTS `v_pending_source_audit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pending_source_audit`  AS SELECT `pending_sources`.`pending_source_id` AS `pending_source_id`, `pending_sources`.`proposed_source_key` AS `proposed_source_key`, `pending_sources`.`title` AS `title`, `pending_sources`.`authors_text` AS `authors_text`, `pending_sources`.`proposed_section_code` AS `proposed_section_code`, `pending_sources`.`priority` AS `priority`, `pending_sources`.`review_status` AS `review_status`, `pending_sources`.`discovered_at` AS `discovered_at`, `pending_sources`.`reviewed_at` AS `reviewed_at` FROM `pending_sources` ORDER BY field(`pending_sources`.`review_status`,'open','in_review','accepted','merged','rejected') ASC, `pending_sources`.`priority` DESC, `pending_sources`.`discovered_at` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_proof_register`
--
DROP TABLE IF EXISTS `v_proof_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_proof_register`  AS SELECT `p`.`proof_number` AS `proof_number`, `ds`.`section_code` AS `section_code`, `p`.`title` AS `title`, `p`.`proof_method` AS `proof_method`, `p`.`provenance` AS `provenance`, `s`.`citation_number` AS `source_citation_number`, `p`.`validation_status` AS `validation_status` FROM ((`proofs` `p` join `dissertation_sections` `ds` on(`ds`.`section_id` = `p`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `p`.`source_id`)) ORDER BY `ds`.`section_order` ASC, `p`.`proof_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_proposition_register`
--
DROP TABLE IF EXISTS `v_proposition_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_proposition_register`  AS SELECT `p`.`proposition_number` AS `proposition_number`, `ds`.`section_code` AS `section_code`, `p`.`title` AS `title`, `p`.`statement_text` AS `statement_text`, `p`.`word_latex` AS `word_latex`, `p`.`based_on_axioms` AS `based_on_axioms`, `p`.`status` AS `status` FROM (`propositions` `p` join `dissertation_sections` `ds` on(`ds`.`section_id` = `p`.`section_id`)) ORDER BY `p`.`proposition_number` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_section_inventory`
--
DROP TABLE IF EXISTS `v_section_inventory`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_section_inventory`  AS SELECT `ds`.`section_code` AS `section_code`, `ds`.`title` AS `title`, `ds`.`status` AS `status`, count(distinct `su`.`source_id`) AS `source_count`, count(distinct `e`.`equation_id`) AS `equation_count`, count(distinct `d`.`definition_id`) AS `definition_count`, count(distinct `th`.`theorem_id`) AS `theorem_count`, count(distinct `l`.`lemma_id`) AS `lemma_count`, count(distinct `c`.`corollary_id`) AS `corollary_count`, count(distinct `f`.`figure_id`) AS `figure_count`, count(distinct `dt`.`table_id`) AS `table_count` FROM ((((((((`dissertation_sections` `ds` left join `source_usage` `su` on(`su`.`section_id` = `ds`.`section_id`)) left join `equations` `e` on(`e`.`section_id` = `ds`.`section_id`)) left join `definitions` `d` on(`d`.`section_id` = `ds`.`section_id`)) left join `theorems` `th` on(`th`.`section_id` = `ds`.`section_id`)) left join `lemmas` `l` on(`l`.`section_id` = `ds`.`section_id`)) left join `corollaries` `c` on(`c`.`section_id` = `ds`.`section_id`)) left join `figures` `f` on(`f`.`section_id` = `ds`.`section_id`)) left join `dissertation_tables` `dt` on(`dt`.`section_id` = `ds`.`section_id`)) GROUP BY `ds`.`section_id`, `ds`.`section_code`, `ds`.`title`, `ds`.`status` ORDER BY `ds`.`section_order` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_statement_register`
--
DROP TABLE IF EXISTS `v_statement_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_statement_register`  AS SELECT 'theorem' AS `statement_type`, `t`.`theorem_number` AS `statement_number`, `ds`.`section_code` AS `section_code`, `t`.`title` AS `title`, `t`.`statement_text` AS `statement_text`, `t`.`word_latex` AS `word_latex`, `t`.`provenance` AS `provenance`, `s`.`citation_number` AS `source_citation_number`, `t`.`validation_status` AS `validation_status` FROM ((`theorems` `t` join `dissertation_sections` `ds` on(`ds`.`section_id` = `t`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `t`.`source_id`))union all select 'lemma' AS `lemma`,`l`.`lemma_number` AS `lemma_number`,`ds`.`section_code` AS `section_code`,`l`.`title` AS `title`,`l`.`statement_text` AS `statement_text`,`l`.`word_latex` AS `word_latex`,`l`.`provenance` AS `provenance`,`s`.`citation_number` AS `citation_number`,`l`.`validation_status` AS `validation_status` from ((`lemmas` `l` join `dissertation_sections` `ds` on(`ds`.`section_id` = `l`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `l`.`source_id`)) union all select 'corollary' AS `corollary`,`c`.`corollary_number` AS `corollary_number`,`ds`.`section_code` AS `section_code`,`c`.`title` AS `title`,`c`.`statement_text` AS `statement_text`,`c`.`word_latex` AS `word_latex`,`c`.`provenance` AS `provenance`,`s`.`citation_number` AS `citation_number`,`c`.`validation_status` AS `validation_status` from ((`corollaries` `c` join `dissertation_sections` `ds` on(`ds`.`section_id` = `c`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `c`.`source_id`))  ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_symbol_register`
--
DROP TABLE IF EXISTS `v_symbol_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_symbol_register`  AS SELECT `s`.`symbol_latex` AS `symbol_latex`, `s`.`symbol_word_latex` AS `symbol_word_latex`, `s`.`symbol_name` AS `symbol_name`, `s`.`definition_text` AS `definition_text`, `s`.`scope_type` AS `scope_type`, `ds`.`section_code` AS `first_section_code`, `e`.`equation_number` AS `first_equation_number`, `s`.`unit_text` AS `unit_text`, `s`.`domain_text` AS `domain_text`, `s`.`codomain_text` AS `codomain_text`, `s`.`validation_status` AS `validation_status` FROM ((`symbols` `s` left join `dissertation_sections` `ds` on(`ds`.`section_id` = `s`.`first_section_id`)) left join `equations` `e` on(`e`.`equation_id` = `s`.`first_equation_id`)) ORDER BY `s`.`symbol_name` ASC, `s`.`symbol_latex` ASC ;

-- --------------------------------------------------------

--
-- Struktur des Views `v_table_register`
--
DROP TABLE IF EXISTS `v_table_register`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_table_register`  AS SELECT `t`.`table_number` AS `table_number`, `ds`.`section_code` AS `section_code`, `t`.`title` AS `title`, `t`.`caption` AS `caption`, `t`.`file_name` AS `file_name`, `t`.`file_path` AS `file_path`, `t`.`provenance` AS `provenance`, `s`.`citation_number` AS `source_citation_number`, `t`.`validation_status` AS `validation_status` FROM ((`dissertation_tables` `t` join `dissertation_sections` `ds` on(`ds`.`section_id` = `t`.`section_id`)) left join `sources` `s` on(`s`.`source_id` = `t`.`source_id`)) ORDER BY `t`.`table_number` ASC ;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `acronyms`
--
ALTER TABLE `acronyms`
  ADD PRIMARY KEY (`acronym_id`),
  ADD UNIQUE KEY `uq_acronym` (`acronym`),
  ADD KEY `fk_acronyms_section` (`first_section_id`),
  ADD KEY `fk_acronyms_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `annotations`
--
ALTER TABLE `annotations`
  ADD PRIMARY KEY (`annotation_id`),
  ADD UNIQUE KEY `uq_annotation_source` (`source_id`);

--
-- Indizes für die Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  ADD PRIMARY KEY (`assumption_id`),
  ADD UNIQUE KEY `uq_assumption_number` (`assumption_number`),
  ADD KEY `fk_assumptions_section` (`section_id`),
  ADD KEY `fk_assumptions_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`),
  ADD UNIQUE KEY `uq_authors_normalized_name` (`normalized_name`);

--
-- Indizes für die Tabelle `axioms`
--
ALTER TABLE `axioms`
  ADD PRIMARY KEY (`axiom_id`),
  ADD UNIQUE KEY `uq_axiom_number` (`axiom_number`),
  ADD KEY `fk_axioms_section` (`section_id`),
  ADD KEY `fk_axioms_assumption` (`source_assumption_id`),
  ADD KEY `fk_axioms_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `axiom_dependencies`
--
ALTER TABLE `axiom_dependencies`
  ADD PRIMARY KEY (`axiom_dependency_id`),
  ADD UNIQUE KEY `uq_axiom_dependency` (`axiom_id`,`depends_on_axiom_id`,`dependency_type`),
  ADD KEY `fk_axiom_dependencies_parent` (`depends_on_axiom_id`);

--
-- Indizes für die Tabelle `citation_corrections`
--
ALTER TABLE `citation_corrections`
  ADD PRIMARY KEY (`correction_id`),
  ADD UNIQUE KEY `uq_citation_correction` (`old_citation_label`,`section_code`),
  ADD KEY `fk_citation_correction_revision` (`revision_id`);

--
-- Indizes für die Tabelle `corollaries`
--
ALTER TABLE `corollaries`
  ADD PRIMARY KEY (`corollary_id`),
  ADD UNIQUE KEY `uq_corollary_number` (`corollary_number`),
  ADD KEY `fk_corollaries_section` (`section_id`),
  ADD KEY `fk_corollaries_theorem` (`parent_theorem_id`),
  ADD KEY `fk_corollaries_lemma` (`parent_lemma_id`),
  ADD KEY `fk_corollaries_source` (`source_id`),
  ADD KEY `fk_corollaries_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `definitions`
--
ALTER TABLE `definitions`
  ADD PRIMARY KEY (`definition_id`),
  ADD UNIQUE KEY `uq_definition_number` (`definition_number`),
  ADD KEY `fk_definitions_section` (`section_id`),
  ADD KEY `fk_definitions_source` (`source_id`),
  ADD KEY `fk_definitions_revision` (`created_revision_id`),
  ADD KEY `idx_definitions_section` (`section_id`);

--
-- Indizes für die Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  ADD PRIMARY KEY (`section_id`),
  ADD UNIQUE KEY `uq_section_code` (`section_code`),
  ADD KEY `fk_sections_parent` (`parent_section_id`);

--
-- Indizes für die Tabelle `dissertation_tables`
--
ALTER TABLE `dissertation_tables`
  ADD PRIMARY KEY (`table_id`),
  ADD UNIQUE KEY `uq_table_number` (`table_number`),
  ADD KEY `fk_tables_section` (`section_id`),
  ADD KEY `fk_tables_source` (`source_id`),
  ADD KEY `fk_tables_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD UNIQUE KEY `uq_documents_file_version` (`file_name`,`version_label`);

--
-- Indizes für die Tabelle `equations`
--
ALTER TABLE `equations`
  ADD PRIMARY KEY (`equation_id`),
  ADD UNIQUE KEY `uq_equation_number` (`equation_number`),
  ADD KEY `fk_equations_section` (`section_id`),
  ADD KEY `fk_equations_source` (`source_id`),
  ADD KEY `idx_equations_revision` (`created_revision_id`),
  ADD KEY `idx_equations_section_number` (`section_id`,`equation_number`);

--
-- Indizes für die Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  ADD PRIMARY KEY (`dependency_id`),
  ADD UNIQUE KEY `uq_equation_dependency` (`equation_id`,`depends_on_equation_id`,`dependency_type`),
  ADD KEY `fk_equation_dependencies_parent` (`depends_on_equation_id`);

--
-- Indizes für die Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  ADD PRIMARY KEY (`equation_symbol_id`),
  ADD UNIQUE KEY `uq_equation_symbol` (`equation_id`,`symbol_latex`);

--
-- Indizes für die Tabelle `figures`
--
ALTER TABLE `figures`
  ADD PRIMARY KEY (`figure_id`),
  ADD UNIQUE KEY `uq_figure_number` (`figure_number`),
  ADD KEY `fk_figures_section` (`section_id`),
  ADD KEY `fk_figures_source` (`source_id`),
  ADD KEY `fk_figures_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `lemmas`
--
ALTER TABLE `lemmas`
  ADD PRIMARY KEY (`lemma_id`),
  ADD UNIQUE KEY `uq_lemma_number` (`lemma_number`),
  ADD KEY `fk_lemmas_section` (`section_id`),
  ADD KEY `fk_lemmas_source` (`source_id`),
  ADD KEY `fk_lemmas_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `object_dependencies`
--
ALTER TABLE `object_dependencies`
  ADD PRIMARY KEY (`object_dependency_id`),
  ADD UNIQUE KEY `uq_object_dependency` (`object_type_from`,`object_id_from`,`object_type_to`,`object_id_to`,`dependency_type`);

--
-- Indizes für die Tabelle `object_source_links`
--
ALTER TABLE `object_source_links`
  ADD PRIMARY KEY (`object_source_link_id`),
  ADD UNIQUE KEY `uq_object_source` (`object_type`,`object_id`,`source_id`,`usage_type`),
  ADD KEY `fk_object_source_source` (`source_id`);

--
-- Indizes für die Tabelle `pending_sources`
--
ALTER TABLE `pending_sources`
  ADD PRIMARY KEY (`pending_source_id`),
  ADD KEY `fk_pending_merged_source` (`merged_source_id`);

--
-- Indizes für die Tabelle `proofs`
--
ALTER TABLE `proofs`
  ADD PRIMARY KEY (`proof_id`),
  ADD KEY `fk_proofs_section` (`section_id`),
  ADD KEY `fk_proofs_theorem` (`theorem_id`),
  ADD KEY `fk_proofs_lemma` (`lemma_id`),
  ADD KEY `fk_proofs_corollary` (`corollary_id`),
  ADD KEY `fk_proofs_source` (`source_id`),
  ADD KEY `fk_proofs_revision` (`created_revision_id`),
  ADD KEY `idx_proofs_section_status` (`section_id`,`validation_status`);

--
-- Indizes für die Tabelle `propositions`
--
ALTER TABLE `propositions`
  ADD PRIMARY KEY (`proposition_id`),
  ADD UNIQUE KEY `uq_proposition_number` (`proposition_number`),
  ADD KEY `fk_propositions_section` (`section_id`),
  ADD KEY `fk_propositions_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `proposition_dependencies`
--
ALTER TABLE `proposition_dependencies`
  ADD PRIMARY KEY (`proposition_dependency_id`),
  ADD UNIQUE KEY `uq_prop_dependency` (`proposition_id`,`axiom_id`,`assumption_id`,`dependency_type`),
  ADD KEY `fk_prop_dep_axiom` (`axiom_id`),
  ADD KEY `fk_prop_dep_assumption` (`assumption_id`);

--
-- Indizes für die Tabelle `repository_counters`
--
ALTER TABLE `repository_counters`
  ADD PRIMARY KEY (`counter_key`);

--
-- Indizes für die Tabelle `repository_revisions`
--
ALTER TABLE `repository_revisions`
  ADD PRIMARY KEY (`revision_id`),
  ADD UNIQUE KEY `uq_revision_code` (`revision_code`),
  ADD KEY `fk_revision_parent` (`parent_revision_id`);

--
-- Indizes für die Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  ADD PRIMARY KEY (`validation_result_id`),
  ADD UNIQUE KEY `uq_validation_revision_code` (`revision_id`,`validation_code`),
  ADD KEY `idx_validation_revision` (`revision_id`);

--
-- Indizes für die Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  ADD PRIMARY KEY (`change_id`),
  ADD KEY `idx_change_revision` (`revision_id`),
  ADD KEY `idx_change_section` (`section_id`);

--
-- Indizes für die Tabelle `sources`
--
ALTER TABLE `sources`
  ADD PRIMARY KEY (`source_id`),
  ADD UNIQUE KEY `uq_sources_source_key` (`source_key`),
  ADD UNIQUE KEY `uq_sources_citation_number` (`citation_number`),
  ADD KEY `idx_sources_title` (`title`(191)),
  ADD KEY `idx_sources_year` (`year_original`),
  ADD KEY `idx_sources_priority` (`priority`),
  ADD KEY `idx_sources_frzk_relevance` (`frzk_relevance`),
  ADD KEY `idx_sources_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `source_authors`
--
ALTER TABLE `source_authors`
  ADD PRIMARY KEY (`source_id`,`author_id`,`role`),
  ADD UNIQUE KEY `uq_source_author_order` (`source_id`,`role`,`author_order`),
  ADD KEY `fk_source_authors_author` (`author_id`);

--
-- Indizes für die Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  ADD PRIMARY KEY (`relation_id`),
  ADD UNIQUE KEY `uq_source_relation` (`source_id_from`,`source_id_to`,`relation_type`),
  ADD KEY `fk_source_relations_to` (`source_id_to`);

--
-- Indizes für die Tabelle `source_topics`
--
ALTER TABLE `source_topics`
  ADD PRIMARY KEY (`source_id`,`topic_id`),
  ADD KEY `fk_source_topics_topic` (`topic_id`);

--
-- Indizes für die Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  ADD PRIMARY KEY (`usage_id`),
  ADD KEY `idx_usage_section` (`section_id`),
  ADD KEY `idx_usage_source` (`source_id`),
  ADD KEY `idx_source_usage_revision` (`created_revision_id`),
  ADD KEY `idx_source_usage_section_source` (`section_id`,`source_id`);

--
-- Indizes für die Tabelle `symbols`
--
ALTER TABLE `symbols`
  ADD PRIMARY KEY (`symbol_id`),
  ADD UNIQUE KEY `uq_symbol_scope` (`symbol_latex`,`scope_type`,`first_section_id`),
  ADD KEY `fk_symbols_section` (`first_section_id`),
  ADD KEY `fk_symbols_equation` (`first_equation_id`),
  ADD KEY `fk_symbols_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `theorems`
--
ALTER TABLE `theorems`
  ADD PRIMARY KEY (`theorem_id`),
  ADD UNIQUE KEY `uq_theorem_number` (`theorem_number`),
  ADD KEY `fk_theorems_section` (`section_id`),
  ADD KEY `fk_theorems_source` (`source_id`),
  ADD KEY `fk_theorems_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`topic_id`),
  ADD UNIQUE KEY `uq_topic_code` (`topic_code`),
  ADD KEY `fk_topics_parent` (`parent_topic_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `acronyms`
--
ALTER TABLE `acronyms`
  MODIFY `acronym_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `annotations`
--
ALTER TABLE `annotations`
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT für Tabelle `axioms`
--
ALTER TABLE `axioms`
  MODIFY `axiom_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT für Tabelle `axiom_dependencies`
--
ALTER TABLE `axiom_dependencies`
  MODIFY `axiom_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT für Tabelle `citation_corrections`
--
ALTER TABLE `citation_corrections`
  MODIFY `correction_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `corollaries`
--
ALTER TABLE `corollaries`
  MODIFY `corollary_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT für Tabelle `definitions`
--
ALTER TABLE `definitions`
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT für Tabelle `dissertation_tables`
--
ALTER TABLE `dissertation_tables`
  MODIFY `table_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `equations`
--
ALTER TABLE `equations`
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=326;

--
-- AUTO_INCREMENT für Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT für Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=308;

--
-- AUTO_INCREMENT für Tabelle `figures`
--
ALTER TABLE `figures`
  MODIFY `figure_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `lemmas`
--
ALTER TABLE `lemmas`
  MODIFY `lemma_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT für Tabelle `object_dependencies`
--
ALTER TABLE `object_dependencies`
  MODIFY `object_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT für Tabelle `object_source_links`
--
ALTER TABLE `object_source_links`
  MODIFY `object_source_link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pending_sources`
--
ALTER TABLE `pending_sources`
  MODIFY `pending_source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `proofs`
--
ALTER TABLE `proofs`
  MODIFY `proof_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT für Tabelle `propositions`
--
ALTER TABLE `propositions`
  MODIFY `proposition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `proposition_dependencies`
--
ALTER TABLE `proposition_dependencies`
  MODIFY `proposition_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT für Tabelle `repository_revisions`
--
ALTER TABLE `repository_revisions`
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT für Tabelle `topics`
--
ALTER TABLE `topics`
  MODIFY `topic_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `acronyms`
--
ALTER TABLE `acronyms`
  ADD CONSTRAINT `fk_acronyms_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_acronyms_section` FOREIGN KEY (`first_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `annotations`
--
ALTER TABLE `annotations`
  ADD CONSTRAINT `fk_annotations_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  ADD CONSTRAINT `fk_assumptions_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_assumptions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`);

--
-- Constraints der Tabelle `axioms`
--
ALTER TABLE `axioms`
  ADD CONSTRAINT `fk_axioms_assumption` FOREIGN KEY (`source_assumption_id`) REFERENCES `assumptions` (`assumption_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_axioms_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_axioms_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`);

--
-- Constraints der Tabelle `axiom_dependencies`
--
ALTER TABLE `axiom_dependencies`
  ADD CONSTRAINT `fk_axiom_dependencies_axiom` FOREIGN KEY (`axiom_id`) REFERENCES `axioms` (`axiom_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_axiom_dependencies_parent` FOREIGN KEY (`depends_on_axiom_id`) REFERENCES `axioms` (`axiom_id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `citation_corrections`
--
ALTER TABLE `citation_corrections`
  ADD CONSTRAINT `fk_citation_correction_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `corollaries`
--
ALTER TABLE `corollaries`
  ADD CONSTRAINT `fk_corollaries_lemma` FOREIGN KEY (`parent_lemma_id`) REFERENCES `lemmas` (`lemma_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_corollaries_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_corollaries_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_corollaries_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_corollaries_theorem` FOREIGN KEY (`parent_theorem_id`) REFERENCES `theorems` (`theorem_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `definitions`
--
ALTER TABLE `definitions`
  ADD CONSTRAINT `fk_definitions_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_definitions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_definitions_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  ADD CONSTRAINT `fk_sections_parent` FOREIGN KEY (`parent_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `dissertation_tables`
--
ALTER TABLE `dissertation_tables`
  ADD CONSTRAINT `fk_tables_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tables_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_tables_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `equations`
--
ALTER TABLE `equations`
  ADD CONSTRAINT `fk_equations_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equations_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equations_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  ADD CONSTRAINT `fk_equation_dependencies_equation` FOREIGN KEY (`equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equation_dependencies_parent` FOREIGN KEY (`depends_on_equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  ADD CONSTRAINT `fk_equation_symbols_equation` FOREIGN KEY (`equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `figures`
--
ALTER TABLE `figures`
  ADD CONSTRAINT `fk_figures_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_figures_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_figures_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `lemmas`
--
ALTER TABLE `lemmas`
  ADD CONSTRAINT `fk_lemmas_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_lemmas_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_lemmas_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `object_source_links`
--
ALTER TABLE `object_source_links`
  ADD CONSTRAINT `fk_object_source_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `pending_sources`
--
ALTER TABLE `pending_sources`
  ADD CONSTRAINT `fk_pending_merged_source` FOREIGN KEY (`merged_source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `proofs`
--
ALTER TABLE `proofs`
  ADD CONSTRAINT `fk_proofs_corollary` FOREIGN KEY (`corollary_id`) REFERENCES `corollaries` (`corollary_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_proofs_lemma` FOREIGN KEY (`lemma_id`) REFERENCES `lemmas` (`lemma_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_proofs_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_proofs_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_proofs_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_proofs_theorem` FOREIGN KEY (`theorem_id`) REFERENCES `theorems` (`theorem_id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `propositions`
--
ALTER TABLE `propositions`
  ADD CONSTRAINT `fk_propositions_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_propositions_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`);

--
-- Constraints der Tabelle `proposition_dependencies`
--
ALTER TABLE `proposition_dependencies`
  ADD CONSTRAINT `fk_prop_dep_assumption` FOREIGN KEY (`assumption_id`) REFERENCES `assumptions` (`assumption_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_prop_dep_axiom` FOREIGN KEY (`axiom_id`) REFERENCES `axioms` (`axiom_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prop_dep_proposition` FOREIGN KEY (`proposition_id`) REFERENCES `propositions` (`proposition_id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `repository_revisions`
--
ALTER TABLE `repository_revisions`
  ADD CONSTRAINT `fk_revision_parent` FOREIGN KEY (`parent_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  ADD CONSTRAINT `fk_validation_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  ADD CONSTRAINT `fk_change_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_change_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `sources`
--
ALTER TABLE `sources`
  ADD CONSTRAINT `fk_sources_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `source_authors`
--
ALTER TABLE `source_authors`
  ADD CONSTRAINT `fk_source_authors_author` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_authors_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  ADD CONSTRAINT `fk_source_relations_from` FOREIGN KEY (`source_id_from`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_relations_to` FOREIGN KEY (`source_id_to`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `source_topics`
--
ALTER TABLE `source_topics`
  ADD CONSTRAINT `fk_source_topics_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_topics_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  ADD CONSTRAINT `fk_source_usage_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_usage_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_source_usage_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `symbols`
--
ALTER TABLE `symbols`
  ADD CONSTRAINT `fk_symbols_equation` FOREIGN KEY (`first_equation_id`) REFERENCES `equations` (`equation_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_symbols_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_symbols_section` FOREIGN KEY (`first_section_id`) REFERENCES `dissertation_sections` (`section_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `theorems`
--
ALTER TABLE `theorems`
  ADD CONSTRAINT `fk_theorems_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_theorems_section` FOREIGN KEY (`section_id`) REFERENCES `dissertation_sections` (`section_id`),
  ADD CONSTRAINT `fk_theorems_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `fk_topics_parent` FOREIGN KEY (`parent_topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
