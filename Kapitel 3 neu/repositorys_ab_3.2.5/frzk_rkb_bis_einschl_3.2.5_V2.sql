-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 15. Jul 2026 um 08:05
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.0.30

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
(52, 52, 'Überblick über Komplexität, Emergenz und adaptive Systeme.', 'Ergänzende Quelle für den Emergenzbegriff.', 'Belegt das Auftreten globaler Eigenschaften aus lokalen Regeln.', 'Komplexität, Emergenz und Berechnung.', 'Übersichtswerk, keine mathematische Primärquelle.', 'Ergänzt [12], [14] und [51].', 'reviewed', '2026-07-12 08:10:57'),
(56, 70, 'Historische Primärquelle zur Ablösung des Funktionsbegriffs von einer einheitlichen analytischen Formel.', 'Begründet den Übergang zum abstrakten Zuordnungsbegriff in Abschnitt 3.2.3.', 'Belegt die wissenschaftshistorische Erweiterung des Funktionsbegriffs.', 'Eine Funktion wird durch die eindeutige Zuordnung von Argumenten zu Werten bestimmt.', 'Historische Darstellung ohne moderne mengentheoretische Formalisierung.', 'Die formale Präzisierung erfolgt mit Lang [29] und Rudin [30].', 'reviewed', '2026-07-14 18:13:43'),
(67, 81, 'Historische Primärquelle zur gruppentheoretischen Analyse der Lösbarkeit algebraischer Gleichungen.', 'Begründet den historischen Übergang von Rechenverfahren zu abstrakten Symmetriestrukturen.', 'Erstnennung zur Entstehung der Gruppentheorie.', 'Symmetrien der Nullstellen bestimmen die Lösbarkeit durch Radikale.', 'Historische Primärquelle in älterer Terminologie.', 'Wird durch moderne algebraische Standardwerke formal präzisiert.', 'reviewed', '2026-07-15 07:36:22'),
(68, 82, 'Begründet die abstrakte Ideal- und Ringtheorie in axiomatischer Form.', 'Zentrale Quelle für den strukturellen Paradigmenwechsel der Algebra.', 'Belegt die systematische Ablösung algebraischer Aussagen von konkreten Zahlbereichen.', 'Ring- und Idealstrukturen können allgemein axiomatisch untersucht werden.', 'Fokussiert auf Ringbereiche und Idealtheorie.', 'Wird mit van der Waerden [63] systematisch eingeordnet.', 'reviewed', '2026-07-15 07:36:22'),
(69, 83, 'Systematisiert Gruppen, Ringe, Körper und weitere algebraische Strukturen.', 'Formale Hauptreferenz für die Definitionen in Abschnitt 3.2.4.', 'Belegt die axiomatische Strukturhierarchie der abstrakten Algebra.', 'Algebraische Strukturen werden durch Trägermengen, Operationen und Axiome bestimmt.', 'Historisches Standardwerk; moderne Terminologie kann abweichen.', 'Wird durch Mac Lane/Birkhoff [64] ergänzt.', 'reviewed', '2026-07-15 07:36:22'),
(70, 84, 'Stellt Gruppen, Homomorphismen und Isomorphismen in moderner struktureller Form dar.', 'Referenz für Gruppen, Untergruppen und strukturerhaltende Abbildungen.', 'Belegt die strukturelle Gleichwertigkeit isomorpher algebraischer Objekte.', 'Homomorphismen erhalten Verknüpfungsstrukturen.', 'Lehrbuchdarstellung statt Primärquelle.', 'Ergänzt die historischen Primärquellen.', 'reviewed', '2026-07-15 07:36:22'),
(71, 85, 'Beweist den Zusammenhang kontinuierlicher Symmetrien mit Erhaltungssätzen.', 'Belegt die wissenschaftliche Bedeutung von Gruppen als Symmetriemodelle.', 'Primärquelle zur Verbindung von Algebra und theoretischer Physik.', 'Kontinuierliche Symmetrien führen zu Erhaltungsgrößen.', 'Setzt variationsanalytische Voraussetzungen voraus.', 'Dient als Anwendungsbezug der Gruppentheorie.', 'reviewed', '2026-07-15 07:36:22'),
(74, 88, 'Systematische Theorie linearer Integralgleichungen und Integraloperatoren.', 'Historische Grundlage der Operatorentheorie in 3.2.5.', 'Belegt den Übergang von konkreten Integralgleichungen zur Untersuchung von Operatoren auf Funktionenräumen.', 'Operatoren können als eigenständige mathematische Transformationsobjekte behandelt werden.', 'Historische Darstellung vor der vollständigen Banachraumtheorie.', 'Wird durch Banachs allgemeinen funktionalanalytischen Rahmen ergänzt.', 'reviewed', '2026-07-15 07:38:39'),
(75, 89, 'Allgemeine Theorie linearer Operationen auf normierten und vollständigen Räumen.', 'Zentrale Primärquelle für lineare Operatoren, Kern, Bild und Operatoralgebra.', 'Belegt die funktionalanalytische Fundierung der Operatorentheorie.', 'Lineare Operatoren werden durch Raumstruktur, Linearität und Abbildungseigenschaften charakterisiert.', 'Schwerpunkt auf linearer Theorie.', 'Nichtlineare Entwicklungen werden in späteren Abschnitten getrennt behandelt.', 'reviewed', '2026-07-15 07:38:39');

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
(7, 'Hilbert', 'David', 'Hilbert, David', NULL, NULL, NULL, 'Historische Primärquelle zu Integralgleichungen und Operatoren.'),
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
(44, 'Levy', 'Azriel', 'Levy, Azriel', NULL, NULL, NULL, 'Mitautor von Foundations of Set Theory.'),
(45, 'Dirichlet', 'Peter Gustav Lejeune', 'Dirichlet, Peter Gustav Lejeune', NULL, 1805, 1859, 'Autor der Primärquelle zum modernen Funktionsbegriff.'),
(46, 'Eilenberg', 'Samuel', 'Eilenberg, Samuel', NULL, 1913, 1998, 'Mitautor der General Theory of Natural Equivalences.'),
(47, 'Mac Lane', 'Saunders', 'Mac Lane, Saunders', NULL, 1909, 2005, 'Mitautor eines Standardwerks der abstrakten Algebra.'),
(48, 'van der Waerden', 'Bartel Leendert', 'van der Waerden, Bartel Leendert', NULL, 1903, 1996, 'Systematische Darstellung der modernen abstrakten Algebra.'),
(53, 'Tarski', 'Alfred', 'Tarski, Alfred', NULL, NULL, NULL, 'Autor von On the Calculus of Relations.'),
(65, 'Galois', 'Évariste', 'Galois, Évariste', NULL, 1811, 1832, 'Primärquelle zur Entstehung der Gruppentheorie.'),
(66, 'Noether', 'Emmy', 'Noether, Emmy', NULL, 1882, 1935, 'Primärquellen zur strukturellen Algebra und zum Symmetrie-Erhaltungssatz.'),
(69, 'Birkhoff', 'Garrett', 'Birkhoff, Garrett', NULL, 1911, 1996, 'Mitautor eines Standardwerks der abstrakten Algebra.'),
(73, 'Banach', 'Stefan', 'Banach, Stefan', NULL, 1892, 1945, 'Primärquelle zur linearen Funktionalanalysis und Operatorentheorie.');

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
(67, 'Def. 3.2.1.1', 9, 'Menge', 'Eine Menge ist im axiomatischen Rahmen ein primitiver mathematischer Gegenstand, dessen Bedeutung durch die Elementrelation und die Axiome der Mengenlehre bestimmt wird.', NULL, NULL, 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(68, 'Def. 3.2.1.2', 9, 'Elementzugehörigkeit', 'Die Aussage x∈M bezeichnet die Zugehörigkeit des Objekts x zur Menge M.', 'x\\in M', 'x\\in M', 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(69, 'Def. 3.2.1.3', 9, 'Leere Menge', 'Die leere Menge ist die eindeutig bestimmte Menge, die kein Element enthält.', '\\emptyset', '\\emptyset', 'literature', 24, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(70, 'Def. 3.2.1.4', 9, 'Teilmenge', 'A ist Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'literature', 24, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(71, 'Def. 3.2.1.5', 9, 'Kartesisches Produkt', 'Das kartesische Produkt A×B ist die Menge aller geordneten Paare (a,b) mit a∈A und b∈B.', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(72, 'Def. 3.2.1.6', 9, 'Potenzmenge', 'Die Potenzmenge P(A) ist die Menge aller Teilmengen von A.', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(73, 'Def. 3.2.2.1', 10, 'Geordnetes Paar', 'Ein geordnetes Paar ist ein Paar mathematischer Objekte, bei dem die Reihenfolge der Komponenten wesentlich ist.', '(a,b)', '(a,b)', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(74, 'Def. 3.2.2.2', 10, 'Binäre Relation', 'Eine binäre Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts A	imes B.', 'Rsubseteq A	imes B', 'Rsubseteq A	imes B', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(75, 'Def. 3.2.2.3', 10, 'Inverse Relation', 'Die inverse Relation entsteht durch Vertauschung der Komponenten aller Paare einer Relation.', 'R^{-1}={(b,a)mid(a,b)in R}', 'R^{-1}={(b,a)mid(a,b)in R}', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(76, 'Def. 3.2.2.4', 10, 'Äquivalenzrelation', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', NULL, NULL, 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(77, 'Def. 3.2.2.5', 10, 'Äquivalenzklasse', 'Die Äquivalenzklasse eines Elements enthält alle Elemente, die bezüglich der Relation zu ihm äquivalent sind.', '[a]_R={xin Amid xRa}', '[a]_R={xin Amid xRa}', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(78, 'Def. 3.2.2.6', 10, 'Halbordnung', 'Eine Halbordnung ist reflexiv, antisymmetrisch und transitiv.', NULL, NULL, 'literature', 28, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(79, 'Def. 3.2.2.7', 10, 'Totalordnung', 'Eine Totalordnung ist eine Halbordnung, in der je zwei Elemente vergleichbar sind.', NULL, NULL, 'literature', 28, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(80, 'Def. 3.2.2.8', 10, 'Relationskomposition', 'Die Komposition zweier Relationen beschreibt mittelbare Beziehungen über ein Zwischenelement.', 'Scirc R={(a,c)midexists b:aRbland bSc}', 'Scirc R={(a,c)midexists b:aRbland bSc}', 'literature', 69, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(81, 'Def. 3.2.3.1', 11, 'Funktion', 'Eine Funktion von A nach B ist eine Relation, die jedem Element von A genau ein Element von B zuordnet.', 'f:A\\longrightarrow B', 'f:A\\longrightarrow B', 'literature', 29, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(82, 'Def. 3.2.3.2', 11, 'Bildmenge', 'Die Bildmenge enthält alle Werte, die durch die Funktion tatsächlich erreicht werden.', 'f(A)=\\{f(x)\\mid x\\in A\\}', 'f(A)=\\{f(x)\\mid x\\in A\\}', 'literature', 29, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(83, 'Def. 3.2.3.3', 11, 'Urbild', 'Das Urbild einer Teilmenge N enthält alle Elemente des Definitionsbereichs, deren Bilder in N liegen.', 'f^{-1}(N)=\\{x\\in A\\mid f(x)\\in N\\}', 'f^{-1}(N)=\\{x\\in A\\mid f(x)\\in N\\}', 'literature', 29, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(84, 'Def. 3.2.3.4', 11, 'Injektive Funktion', 'Eine Funktion ist injektiv, wenn verschiedene Ausgangselemente verschiedene Bilder besitzen.', NULL, NULL, 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(85, 'Def. 3.2.3.5', 11, 'Surjektive Funktion', 'Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.', NULL, NULL, 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(86, 'Def. 3.2.3.6', 11, 'Bijektive Funktion', 'Eine Funktion ist bijektiv, wenn sie injektiv und surjektiv ist.', NULL, NULL, 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(87, 'Def. 3.2.3.7', 11, 'Umkehrfunktion', 'Die Umkehrfunktion einer bijektiven Funktion ordnet jedem Zielwert sein eindeutiges Urbild zu.', 'f^{-1}:B\\longrightarrow A', 'f^{-1}:B\\longrightarrow A', 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(88, 'Def. 3.2.3.8', 11, 'Funktionskomposition', 'Die Komposition zweier Funktionen wendet die zweite Abbildung auf das Ergebnis der ersten an.', '(g\\circ f)(x)=g(f(x))', '(g\\circ f)(x)=g(f(x))', 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(89, 'Def. 3.2.3.9', 11, 'Identitätsabbildung', 'Die Identitätsabbildung auf A ordnet jedem Element sich selbst zu.', '\\operatorname{id}_A(x)=x', '\\operatorname{id}_A(x)=x', 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(116, 'Def. 3.2.4.1', 12, 'Innere binäre Verknüpfung', 'Eine innere binäre Verknüpfung auf A ordnet jedem Paar aus A×A eindeutig ein Element aus A zu.', 'star:A	imes Alongrightarrow A', 'star:A	imes Alongrightarrow A', 'literature', 83, NULL, NULL, 'checked', 29),
(117, 'Def. 3.2.4.2', 12, 'Magma', 'Ein Magma ist eine nichtleere Menge mit einer abgeschlossenen inneren binären Verknüpfung.', 'left(A,star\right)', 'left(A,star\right)', 'literature', 83, NULL, NULL, 'checked', 29),
(118, 'Def. 3.2.4.3', 12, 'Halbgruppe', 'Eine Halbgruppe ist ein Magma mit assoziativer Verknüpfung.', 'left(A,star\right)', 'left(A,star\right)', 'literature', 83, NULL, NULL, 'checked', 29),
(119, 'Def. 3.2.4.4', 12, 'Neutrales Element', 'Ein neutrales Element lässt jedes Element bei links- und rechtsseitiger Verknüpfung unverändert.', 'estar a=astar e=a', 'estar a=astar e=a', 'literature', 83, NULL, NULL, 'checked', 29),
(120, 'Def. 3.2.4.5', 12, 'Monoid', 'Ein Monoid ist eine Halbgruppe mit neutralem Element.', 'left(A,star,e\right)', 'left(A,star,e\right)', 'literature', 83, NULL, NULL, 'checked', 29),
(121, 'Def. 3.2.4.6', 12, 'Gruppe', 'Eine Gruppe ist ein Monoid, in dem jedes Element ein inverses Element besitzt.', 'left(A,star\right)', 'left(A,star\right)', 'literature', 84, NULL, NULL, 'checked', 29),
(122, 'Def. 3.2.4.7', 12, 'Abelsche Gruppe', 'Eine abelsche Gruppe ist eine Gruppe mit kommutativer Verknüpfung.', 'astar b=bstar a', 'astar b=bstar a', 'literature', 84, NULL, NULL, 'checked', 29),
(123, 'Def. 3.2.4.8', 12, 'Untergruppe', 'Eine Untergruppe ist eine Teilmenge einer Gruppe, die bezüglich derselben Verknüpfung selbst eine Gruppe bildet.', 'Hsubseteq G', 'Hsubseteq G', 'literature', 84, NULL, NULL, 'checked', 29),
(124, 'Def. 3.2.4.9', 12, 'Homomorphismus', 'Ein Homomorphismus ist eine Abbildung, die die algebraische Verknüpfung erhält.', 'varphi(astar b)=varphi(a)circvarphi(b)', 'varphi(astar b)=varphi(a)circvarphi(b)', 'literature', 84, NULL, NULL, 'checked', 29),
(125, 'Def. 3.2.4.10', 12, 'Isomorphismus', 'Ein Isomorphismus ist ein bijektiver Homomorphismus.', 'Gcong H', 'Gcong H', 'literature', 84, NULL, NULL, 'checked', 29),
(126, 'Def. 3.2.4.11', 12, 'Ring', 'Ein Ring ist eine Menge mit additiver abelscher Gruppenstruktur und einer assoziativen Multiplikation, die distributiv miteinander verknüpft sind.', 'left(R,+,cdot\right)', 'left(R,+,cdot\right)', 'literature', 82, NULL, NULL, 'checked', 29),
(127, 'Def. 3.2.4.12', 12, 'Körper', 'Ein Körper ist ein kommutativer Ring mit Eins, in dem jedes von null verschiedene Element multiplikativ invertierbar ist.', NULL, NULL, 'literature', 83, NULL, NULL, 'checked', 29),
(128, 'Def. 3.2.4.13', 12, 'Vektorraum', 'Ein Vektorraum über K ist eine abelsche Gruppe mit kompatibler Skalarmultiplikation.', 'K	imes Vlongrightarrow V', 'K	imes Vlongrightarrow V', 'literature', 83, NULL, NULL, 'checked', 29),
(139, 'Def. 3.2.5.1', 13, 'Operator', 'Ein Operator ist eine Abbildung zwischen mathematisch strukturierten Räumen.', 'T:X\\longrightarrow Y', 'T:X\\longrightarrow Y', 'literature', 35, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(140, 'Def. 3.2.5.2', 13, 'Endomorpher Operator', 'Ein Operator auf X bildet den Raum X in sich selbst ab.', 'T:X\\longrightarrow X', 'T:X\\longrightarrow X', 'literature', 35, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(141, 'Def. 3.2.5.3', 13, 'Definitionsbereich eines Operators', 'Der Definitionsbereich enthält alle Elemente, auf denen der Operator tatsächlich definiert ist.', '\\mathcal{D}(T)\\subseteq X', '\\mathcal{D}(T)\\subseteq X', 'literature', 36, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(142, 'Def. 3.2.5.4', 13, 'Wertebereich eines Operators', 'Der Wertebereich enthält alle durch den Operator tatsächlich erzeugten Bilder.', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}', 'literature', 36, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(143, 'Def. 3.2.5.5', 13, 'Linearer Operator', 'Ein Operator ist linear, wenn er Addition und Skalarmultiplikation erhält.', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'literature', 89, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(144, 'Def. 3.2.5.6', 13, 'Kern eines linearen Operators', 'Der Kern enthält alle Elemente, die auf den Nullvektor abgebildet werden.', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', 'literature', 89, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(145, 'Def. 3.2.5.7', 13, 'Bild eines linearen Operators', 'Das Bild enthält alle durch den Operator erreichbaren Elemente des Zielraums.', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', 'literature', 89, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(146, 'Def. 3.2.5.8', 13, 'Invertierbarer Operator', 'Ein Operator ist invertierbar, wenn eine beidseitige Umkehrabbildung existiert.', 'T^{-1}\\circ T=I_X,\\quad T\\circ T^{-1}=I_Y', 'T^{-1}\\circ T=I_X,\\quad T\\circ T^{-1}=I_Y', 'literature', 35, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(147, 'Def. 3.2.5.9', 13, 'Endomorphismenring', 'Die Menge aller linearen Endomorphismen eines Vektorraums bildet unter Addition und Komposition eine Operatoralgebra.', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', 'literature', 36, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(148, 'Def. 3.2.5.10', 13, 'Spektrum eines Operators', 'Das Spektrum besteht aus allen komplexen Zahlen, für die T minus Lambda mal I nicht invertierbar ist.', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', 'literature', 11, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31);

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
(7, NULL, '3.2', 'Mathematische Grundlagen', 3, 3.2000, 'review', 0, 'Kapitel 3.2 wird abschnittsweise neu gefasst; Stand der Forschung, keine FRZK-Eigenleistung.', '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(8, 7, '3.2.0', 'Einleitung', 3, 3.2001, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Die Einleitung ordnet Kapitel 3.2 als mathematischen Forschungsstand ein und grenzt es von der Eigenleistung ab Kapitel 3.3 ab. Keine nummerierte Gleichung.', '2026-07-12 11:14:28', '2026-07-12 12:53:42'),
(9, 7, '3.2.1', 'Mengen als Grundlage mathematischer Modellbildung', 3, 3.2100, 'review', 0, 'Am 14.07.2026 vollständig neu gefasst. Forschungsstand zur axiomatischen Mengenlehre mit den Quellen [23], [24] und [58]; Gleichungen (3.3)–(3.16).', '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(10, 7, '3.2.2', 'Relationen als mathematische Beschreibung struktureller Zusammenhänge', 3, 3.2200, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [27], [28], [59] und Gleichungen (3.17)–(3.41).', '2026-07-12 11:14:28', '2026-07-14 15:51:26'),
(11, 7, '3.2.3', 'Funktionen als mathematische Beschreibung gerichteter Transformationen', 3, 3.2300, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [29], [30], [60] und Gleichungen (3.42)–(3.64).', '2026-07-12 11:14:28', '2026-07-14 16:13:43'),
(12, 7, '3.2.4', 'Algebraische Strukturen als Grundlage regelhafter Verknüpfungen', 3, 3.2400, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [61]–[65] und Gleichungen (3.65)–(3.106).', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(13, 7, '3.2.5', 'Operatoren als mathematische Beschreibung funktionaler Transformationen', 3, 3.2500, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [66]–[67] und Gleichungen (3.107)–(3.135).', '2026-07-12 11:14:28', '2026-07-15 05:38:39'),
(14, 7, '3.2.6', 'Zustandsräume als mathematische Grundlage funktionaler Entwicklungen', 3, 3.2600, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(15, 7, '3.2.7', 'Funktionalanalysis als mathematischer Rahmen unendlichdimensionaler Zustandsräume', 3, 3.2700, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(16, 7, '3.2.8', 'Dynamische Systeme als mathematische Beschreibung zeitlicher Entwicklungen', 3, 3.2800, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(17, 7, '3.2.9', 'Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse', 3, 3.2900, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(18, 7, '3.2.10', 'Graphen- und Netzwerktheorie als mathematische Beschreibung komplexer Beziehungsstrukturen', 3, 3.3000, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(19, 7, '3.2.11', 'Metriken und Ähnlichkeitsmaße als Grundlage funktionaler Kohärenz', 3, 3.3100, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(20, 7, '3.2.12', 'Emergenz und Selbstorganisation als mathematische Grundlagen funktionaler Strukturbildung', 3, 3.3200, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(21, 7, '3.2.13', 'Grenzen bestehender mathematischer Modelle und Herleitung der Forschungslücke', 3, 3.3300, 'planned', 0, NULL, '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(22, NULL, '3.3', 'Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems', 3, 3.4000, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(23, NULL, '3.4', 'Mathematische Rekonstruktion funktionaler Organisation', 3, 3.5000, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(49, 22, '3.3.0', 'Einleitung', 3, 3.4001, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(50, 22, '3.3.1', 'Primitive Begriffe und axiomatische Ausgangspunkte', 3, 3.4100, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(51, 22, '3.3.2', 'Wissenschaftstheoretische Begründung der primitiven Begriffe', 3, 3.4200, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(52, 22, '3.3.3', 'Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit', 3, 3.4300, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(53, 22, '3.3.4', 'Axiom A2 – Prinzip der funktionalen Relationierbarkeit', 3, 3.4400, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(54, 22, '3.3.5', 'Axiom A3 – Prinzip der rekursiven Transformation', 3, 3.4500, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(55, 22, '3.3.6', 'Axiom A4 – Prinzip stabiler funktionaler Organisation', 3, 3.4600, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(56, 22, '3.3.7', 'Axiom A5 – Prinzip reproduzierbarer Organisationsmuster', 3, 3.4700, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(57, 22, '3.3.8', 'Zusammenfassung der axiomatischen Grundlagen', 3, 3.4800, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(58, 22, '3.3.9', 'Logische Konsequenzen des Axiomensystems', 3, 3.4900, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(60, 23, '3.4.0', 'Einleitung', 3, 3.5001, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(61, 23, '3.4.1', 'Konstruktion funktionaler Differenzstrukturen', 3, 3.5100, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(62, 23, '3.4.2', 'Konstruktion funktionaler Relationen', 3, 3.5200, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(63, 23, '3.4.3', 'Konstruktion rekursiver Transformationen', 3, 3.5300, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(64, 23, '3.4.4', 'Konstruktion funktionaler Organisationsräume', 3, 3.5400, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(65, 23, '3.4.5', 'Konstruktion funktionaler Zustandsräume', 3, 3.5500, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(66, 23, '3.4.6', 'Konstruktion funktionaler Kohärenz', 3, 3.5600, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(67, 23, '3.4.7', 'Rekonstruktion funktionaler Raumstrukturen', 3, 3.5700, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(68, 23, '3.4.8', 'Rekonstruktion funktionaler Zeitstrukturen', 3, 3.5800, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(69, 23, '3.4.9', 'Zusammenfassung der mathematischen Rekonstruktion', 3, 3.5900, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22'),
(70, 23, '3.4.10', 'Wissenschaftliche Konsequenzen der mathematischen Rekonstruktion', 3, 3.6000, 'planned', 1, 'Inhaltliche Repository-Artefakte wegen neuer globaler Gleichungsnummerierung ab 3.2.4 zurückgesetzt; Neuaufbau folgt.', '2026-07-12 11:14:28', '2026-07-15 05:36:22');

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
(232, '3.3', 9, 'Elementzugehörigkeit', 'x\\in M', 'x\\in M', 'Das Objekt x ist Element der Menge M.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(233, '3.4', 9, 'Nichtzugehörigkeit', 'x\\notin M', 'x\\notin M', 'Das Objekt x ist kein Element der Menge M.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(234, '3.5', 9, 'Leere Menge', '\\emptyset', '\\emptyset', 'Bezeichnung der eindeutig bestimmten Menge ohne Elemente.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(235, '3.6', 9, 'Extensionalitätsaxiom', 'A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)', 'A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)', 'Zwei Mengen sind genau dann identisch, wenn sie dieselben Elemente besitzen.', 'axiom', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(236, '3.7', 9, 'Teilmengenrelation', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(237, '3.8', 9, 'Aussonderungsmenge', 'A_P=\\left\\{x\\in A\\mid P(x)\\right\\}', 'A_P=\\left\\{x\\in A\\mid P(x)\\right\\}', 'Teilmenge von A, deren Elemente die Eigenschaft P erfüllen.', 'definition', 'literature', 63, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(238, '3.9', 9, 'Vereinigung', 'A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}', 'A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}', 'Vereinigung der Mengen A und B.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(239, '3.10', 9, 'Durchschnitt', 'A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}', 'A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}', 'Durchschnitt der Mengen A und B.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(240, '3.11', 9, 'Differenzmenge', 'A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}', 'A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}', 'Differenzmenge von A bezüglich B.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(241, '3.12', 9, 'Komplement', 'A^{c}=U\\setminus A', 'A^{c}=U\\setminus A', 'Komplement von A relativ zur Grundmenge U.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(242, '3.13', 9, 'Kartesisches Produkt', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'Menge aller geordneten Paare aus A und B.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(243, '3.14', 9, 'Potenzmenge', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', 'Menge aller Teilmengen von A.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(244, '3.15', 9, 'Satz von Cantor', '|\\mathcal P(A)|>|A|', '|\\mathcal P(A)|>|A|', 'Die Potenzmenge besitzt eine strikt größere Mächtigkeit als ihre Ausgangsmenge.', 'theorem', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(245, '3.16', 9, 'Schema mengenbildender Operationen', '\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)', '\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)', 'Schematische Darstellung einer Operation auf Teilmengen einer Grundmenge.', 'schema', 'adapted', 63, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(255, '3.17', 10, 'Geordnetes Paar', '(a,b)', '(a,b)', 'Geordnetes Paar aus den Komponenten a und b.', 'definition', 'literature', 27, NULL, 'a und b sind Elemente geeigneter Mengen.', 'checked', 25),
(256, '3.18', 10, 'Identität geordneter Paare', '(a,b)=(c,d)Longleftrightarrow a=cland b=d', '(a,b)=(c,d)Longleftrightarrow a=cland b=d', 'Zwei geordnete Paare sind genau dann gleich, wenn ihre jeweiligen Komponenten übereinstimmen.', 'definition', 'literature', 27, NULL, 'a,b,c,d sind mathematische Objekte.', 'checked', 25),
(257, '3.19', 10, 'Reihenfolge geordneter Paare', '(a,b)\neq(b,a)', '(a,b)\neq(b,a)', 'Bei verschiedenen Komponenten ist die Reihenfolge eines geordneten Paares wesentlich.', 'derived', 'literature', 27, NULL, 'a\neq b.', 'checked', 25),
(258, '3.20', 10, 'Kartesisches Produkt', 'A	imes B=left{(a,b)mid ain Aland bin B\right}', 'A	imes B=left{(a,b)mid ain Aland bin B\right}', 'Das kartesische Produkt enthält alle geordneten Paare aus A und B.', 'definition', 'literature', 27, NULL, 'A und B sind Mengen.', 'checked', 25),
(259, '3.21', 10, 'Binäre Relation', 'Rsubseteq A	imes B', 'Rsubseteq A	imes B', 'Eine binäre Relation zwischen A und B ist eine Teilmenge ihres kartesischen Produkts.', 'definition', 'literature', 27, NULL, 'A und B sind Mengen.', 'checked', 25),
(260, '3.22', 10, 'Relationsnotation', 'aRbLongleftrightarrow(a,b)in R', 'aRbLongleftrightarrow(a,b)in R', 'Die Schreibweise aRb bedeutet, dass das geordnete Paar (a,b) zur Relation R gehört.', 'definition', 'literature', 27, NULL, 'Rsubseteq A	imes B.', 'checked', 25),
(261, '3.23', 10, 'Relation auf einer Menge', 'Rsubseteq A	imes A', 'Rsubseteq A	imes A', 'Eine Relation auf A ist eine Teilmenge von A mal A.', 'definition', 'literature', 27, NULL, 'A ist eine Menge.', 'checked', 25),
(262, '3.24', 10, 'Definitionsbereich einer Relation', 'operatorname{dom}(R)=left{ain Amidexists bin B:(a,b)in R\right}', 'operatorname{dom}(R)=left{ain Amidexists bin B:(a,b)in R\right}', 'Der Definitionsbereich enthält alle ersten Komponenten, die in mindestens einem Relationspaar auftreten.', 'definition', 'literature', 27, NULL, 'Rsubseteq A	imes B.', 'checked', 25),
(263, '3.25', 10, 'Wertebereich einer Relation', 'operatorname{ran}(R)=left{bin Bmidexists ain A:(a,b)in R\right}', 'operatorname{ran}(R)=left{bin Bmidexists ain A:(a,b)in R\right}', 'Der Wertebereich enthält alle zweiten Komponenten, die in mindestens einem Relationspaar auftreten.', 'definition', 'literature', 27, NULL, 'Rsubseteq A	imes B.', 'checked', 25),
(264, '3.26', 10, 'Inverse Relation', 'R^{-1}=left{(b,a)mid(a,b)in R\right}', 'R^{-1}=left{(b,a)mid(a,b)in R\right}', 'Die inverse Relation entsteht durch Vertauschung der Komponenten aller Relationspaare.', 'definition', 'literature', 27, NULL, 'R ist eine binäre Relation.', 'checked', 25),
(265, '3.27', 10, 'Reflexivität', 'forall ain A:;aRa', 'forall ain A:;aRa', 'Eine Relation ist reflexiv, wenn jedes Element zu sich selbst in Relation steht.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(266, '3.28', 10, 'Irreflexivität', 'forall ain A:;\neg(aRa)', 'forall ain A:;\neg(aRa)', 'Eine Relation ist irreflexiv, wenn kein Element zu sich selbst in Relation steht.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(267, '3.29', 10, 'Symmetrie', 'forall a,bin A:;aRbLongrightarrow bRa', 'forall a,bin A:;aRbLongrightarrow bRa', 'Eine Relation ist symmetrisch, wenn jede Beziehung auch in der Gegenrichtung gilt.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(268, '3.30', 10, 'Antisymmetrie', 'forall a,bin A:;left(aRbland bRa\right)Longrightarrow a=b', 'forall a,bin A:;left(aRbland bRa\right)Longrightarrow a=b', 'Eine Relation ist antisymmetrisch, wenn wechselseitige Relation Identität erzwingt.', 'definition', 'literature', 28, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(269, '3.31', 10, 'Asymmetrie', 'forall a,bin A:;aRbLongrightarrow\neg(bRa)', 'forall a,bin A:;aRbLongrightarrow\neg(bRa)', 'Eine Relation ist asymmetrisch, wenn aus aRb die Nichtgeltung von bRa folgt.', 'definition', 'literature', 28, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(270, '3.32', 10, 'Transitivität', 'forall a,b,cin A:;left(aRbland bRc\right)Longrightarrow aRc', 'forall a,b,cin A:;left(aRbland bRc\right)Longrightarrow aRc', 'Eine Relation ist transitiv, wenn verkettete Beziehungen wieder eine Beziehung ergeben.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(271, '3.33', 10, 'Äquivalenzrelation', 'R	ext{ ist Äquivalenzrelation}Longleftrightarrow R	ext{ ist reflexiv, symmetrisch und transitiv}', 'R	ext{ ist Äquivalenzrelation}Longleftrightarrow R	ext{ ist reflexiv, symmetrisch und transitiv}', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(272, '3.34', 10, 'Äquivalenzklasse', '[a]_R=left{xin Amid xRa\right}', '[a]_R=left{xin Amid xRa\right}', 'Die Äquivalenzklasse eines Elements enthält alle zu ihm äquivalenten Elemente.', 'definition', 'literature', 27, NULL, 'R ist eine Äquivalenzrelation auf A.', 'checked', 25),
(273, '3.35', 10, 'Quotientenmenge', 'A/R=left{[a]_Rmid ain A\right}', 'A/R=left{[a]_Rmid ain A\right}', 'Die Quotientenmenge besteht aus allen Äquivalenzklassen von A bezüglich R.', 'definition', 'literature', 27, NULL, 'R ist eine Äquivalenzrelation auf A.', 'checked', 25),
(274, '3.36', 10, 'Halbordnung', 'R	ext{ ist Halbordnung}Longleftrightarrow R	ext{ ist reflexiv, antisymmetrisch und transitiv}', 'R	ext{ ist Halbordnung}Longleftrightarrow R	ext{ ist reflexiv, antisymmetrisch und transitiv}', 'Eine Halbordnung ist reflexiv, antisymmetrisch und transitiv.', 'definition', 'literature', 28, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(275, '3.37', 10, 'Partiell geordnete Menge', 'left(A,preceq\right)', 'left(A,preceq\right)', 'Ein Paar aus einer Menge A und einer Halbordnung bildet eine partiell geordnete Menge.', 'definition', 'literature', 28, NULL, 'preceq ist eine Halbordnung auf A.', 'checked', 25),
(276, '3.38', 10, 'Totalordnung', 'forall a,bin A:;apreceq blor bpreceq a', 'forall a,bin A:;apreceq blor bpreceq a', 'In einer Totalordnung sind je zwei Elemente vergleichbar.', 'definition', 'literature', 28, NULL, 'preceq ist eine Halbordnung auf A.', 'checked', 25),
(277, '3.39', 10, 'Komposition von Relationen', 'Scirc R=left{(a,c)in A	imes Cmidexists bin B:;aRbland bSc\right}', 'Scirc R=left{(a,c)in A	imes Cmidexists bin B:;aRbland bSc\right}', 'Die Komposition erfasst Beziehungen, die über ein Zwischenelement vermittelt werden.', 'definition', 'literature', 69, NULL, 'Rsubseteq A	imes B und Ssubseteq B	imes C.', 'checked', 25),
(278, '3.40', 10, 'Transitivität als Selbstkomposition', 'Rcirc Rsubseteq R', 'Rcirc Rsubseteq R', 'Eine Relation ist transitiv, wenn ihre Selbstkomposition in ihr enthalten ist.', 'derived', 'literature', 69, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(279, '3.41', 10, 'Graph einer Relation', 'G_R=left(A,R\right)', 'G_R=left(A,R\right)', 'Eine binäre Relation auf A kann als gerichteter Graph mit Knotenmenge A und Kantenmenge R interpretiert werden.', 'model', 'literature', 27, NULL, 'Rsubseteq A	imes A.', 'checked', 25),
(280, '3.42', 11, 'Funktion als Abbildung', 'f:A\\longrightarrow B', 'f:A\\longrightarrow B', 'Eine Funktion f bildet die Definitionsmenge A in die Zielmenge B ab.', 'definition', 'literature', 29, NULL, 'A und B sind Mengen.', 'checked', 26),
(281, '3.43', 11, 'Existenz und Eindeutigkeit', '\\forall x\\in A\\;\\exists!\\,y\\in B:\\;f(x)=y', '\\forall x\\in A\\;\\exists!\\,y\\in B:\\;f(x)=y', 'Jedem Element des Definitionsbereichs wird genau ein Element des Zielbereichs zugeordnet.', 'definition', 'literature', 29, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(282, '3.44', 11, 'Existenzbedingung', '\\forall x\\in A\\;\\exists y\\in B:\\;f(x)=y', '\\forall x\\in A\\;\\exists y\\in B:\\;f(x)=y', 'Für jedes Element des Definitionsbereichs existiert mindestens ein Funktionswert.', 'definition', 'literature', 29, NULL, 'f ist eine totale Funktion auf A.', 'checked', 26),
(283, '3.45', 11, 'Eindeutigkeitsbedingung', '\\forall x\\in A\\;\\forall y_1,y_2\\in B:\\;\\left(f(x)=y_1\\land f(x)=y_2\\right)\\Longrightarrow y_1=y_2', '\\forall x\\in A\\;\\forall y_1,y_2\\in B:\\;\\left(f(x)=y_1\\land f(x)=y_2\\right)\\Longrightarrow y_1=y_2', 'Zu einem Ausgangselement können nicht zwei verschiedene Funktionswerte gehören.', 'definition', 'literature', 29, NULL, 'x liegt in A; y_1 und y_2 liegen in B.', 'checked', 26),
(284, '3.46', 11, 'Funktion als spezielle Relation', 'f\\subseteq A\\times B', 'f\\subseteq A\\times B', 'Eine Funktion ist eine spezielle Relation zwischen A und B.', 'definition', 'literature', 29, NULL, 'Zusätzlich gilt die Existenz- und Eindeutigkeitsbedingung.', 'checked', 26),
(285, '3.47', 11, 'Funktionswert und Relationspaar', 'f(x)=y\\Longleftrightarrow(x,y)\\in f', 'f(x)=y\\Longleftrightarrow(x,y)\\in f', 'Der Funktionswert y entspricht dem eindeutig zugeordneten Relationspaar.', 'definition', 'literature', 29, NULL, 'f ist mengentheoretisch als Relation aufgefasst.', 'checked', 26),
(286, '3.48', 11, 'Bild einer Menge', 'f(A)=\\left\\{f(x)\\mid x\\in A\\right\\}', 'f(A)=\\left\\{f(x)\\mid x\\in A\\right\\}', 'Das Bild von A enthält alle tatsächlich auftretenden Funktionswerte.', 'definition', 'literature', 29, NULL, 'f ist auf A definiert.', 'checked', 26),
(287, '3.49', 11, 'Bildmenge als Teilmenge', 'f(A)\\subseteq B', 'f(A)\\subseteq B', 'Das Bild einer Funktion ist Teilmenge ihrer Zielmenge.', 'derived', 'literature', 29, NULL, 'f bildet A nach B ab.', 'checked', 26),
(288, '3.50', 11, 'Bild einer Teilmenge', 'f(M)=\\left\\{f(x)\\mid x\\in M\\right\\}', 'f(M)=\\left\\{f(x)\\mid x\\in M\\right\\}', 'Bild einer Teilmenge M des Definitionsbereichs.', 'definition', 'literature', 29, NULL, 'M ist Teilmenge von A.', 'checked', 26),
(289, '3.51', 11, 'Urbild einer Teilmenge', 'f^{-1}(N)=\\left\\{x\\in A\\mid f(x)\\in N\\right\\}', 'f^{-1}(N)=\\left\\{x\\in A\\mid f(x)\\in N\\right\\}', 'Das Urbild enthält alle Ausgangselemente, deren Bilder in N liegen.', 'definition', 'literature', 29, NULL, 'N ist Teilmenge von B; keine inverse Funktion erforderlich.', 'checked', 26),
(290, '3.52', 11, 'Injektivität', '\\forall x_1,x_2\\in A:\\;f(x_1)=f(x_2)\\Longrightarrow x_1=x_2', '\\forall x_1,x_2\\in A:\\;f(x_1)=f(x_2)\\Longrightarrow x_1=x_2', 'Eine Funktion ist injektiv, wenn gleiche Bilder nur von gleichen Urbildern stammen.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(291, '3.53', 11, 'Äquivalente Injektivitätsbedingung', 'x_1\\neq x_2\\Longrightarrow f(x_1)\\neq f(x_2)', 'x_1\\neq x_2\\Longrightarrow f(x_1)\\neq f(x_2)', 'Verschiedene Ausgangselemente besitzen bei einer injektiven Funktion verschiedene Bilder.', 'derived', 'literature', 30, NULL, 'f ist injektiv.', 'checked', 26),
(292, '3.54', 11, 'Surjektivität', '\\forall y\\in B\\;\\exists x\\in A:\\;f(x)=y', '\\forall y\\in B\\;\\exists x\\in A:\\;f(x)=y', 'Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(293, '3.55', 11, 'Bildmenge einer surjektiven Funktion', 'f(A)=B', 'f(A)=B', 'Bei einer surjektiven Funktion stimmen Bild- und Zielmenge überein.', 'derived', 'literature', 30, NULL, 'f ist surjektiv.', 'checked', 26),
(294, '3.56', 11, 'Bijektivität', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv}\\land f\\text{ ist surjektiv}', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv}\\land f\\text{ ist surjektiv}', 'Bijektivität verbindet Injektivität und Surjektivität.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(295, '3.57', 11, 'Umkehrfunktion', 'f^{-1}:B\\longrightarrow A', 'f^{-1}:B\\longrightarrow A', 'Eine bijektive Funktion besitzt eine Umkehrfunktion von B nach A.', 'definition', 'literature', 30, NULL, 'f ist bijektiv.', 'checked', 26),
(296, '3.58', 11, 'Linke Umkehrbeziehung', 'f^{-1}(f(x))=x', 'f^{-1}(f(x))=x', 'Die Umkehrfunktion hebt die Wirkung von f auf Elementen aus A auf.', 'derived', 'literature', 30, NULL, 'x liegt in A und f ist bijektiv.', 'checked', 26),
(297, '3.59', 11, 'Rechte Umkehrbeziehung', 'f(f^{-1}(y))=y', 'f(f^{-1}(y))=y', 'Die Funktion hebt die Wirkung ihrer Umkehrfunktion auf Elementen aus B auf.', 'derived', 'literature', 30, NULL, 'y liegt in B und f ist bijektiv.', 'checked', 26),
(298, '3.60', 11, 'Komposition von Funktionen', '(g\\circ f)(x)=g(f(x))', '(g\\circ f)(x)=g(f(x))', 'Die Komposition wendet zunächst f und anschließend g an.', 'definition', 'literature', 30, NULL, 'f:A nach B und g:B nach C.', 'checked', 26),
(299, '3.61', 11, 'Assoziativität der Komposition', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'Die Komposition von Funktionen ist assoziativ.', 'derived', 'literature', 30, NULL, 'Definitions- und Zielmengen sind kompositionsverträglich.', 'checked', 26),
(300, '3.62', 11, 'Identitätsabbildung', '\\operatorname{id}_A:A\\longrightarrow A', '\\operatorname{id}_A:A\\longrightarrow A', 'Die Identitätsabbildung ist eine Funktion von A nach A.', 'definition', 'literature', 30, NULL, 'A ist eine Menge.', 'checked', 26),
(301, '3.63', 11, 'Wirkung der Identitätsabbildung', '\\operatorname{id}_A(x)=x', '\\operatorname{id}_A(x)=x', 'Die Identitätsabbildung lässt jedes Element unverändert.', 'definition', 'literature', 30, NULL, 'x liegt in A.', 'checked', 26),
(302, '3.64', 11, 'Identität als neutrales Element', 'f\\circ\\operatorname{id}_A=f=\\operatorname{id}_B\\circ f', 'f\\circ\\operatorname{id}_A=f=\\operatorname{id}_B\\circ f', 'Identitätsabbildungen sind neutrale Elemente der Funktionskomposition.', 'derived', 'literature', 30, NULL, 'f bildet A nach B ab.', 'checked', 26),
(351, '3.65', 12, 'Innere binäre Verknüpfung', 'star:A	imes Alongrightarrow A', 'star:A	imes Alongrightarrow A', 'Eine innere Verknüpfung bildet Paare aus A wieder nach A ab.', 'definition', 'literature', 83, NULL, 'A ist eine nichtleere Menge.', 'checked', 29),
(352, '3.66', 12, 'Abgeschlossenheit', 'forall a,bin A:;astar bin A', 'forall a,bin A:;astar bin A', 'Das Ergebnis der Verknüpfung liegt wieder in A.', 'definition', 'literature', 83, NULL, 'a,b liegen in A.', 'checked', 29),
(353, '3.67', 12, 'Magma', 'left(A,star\right)', 'left(A,star\right)', 'Paar aus Trägermenge und innerer Verknüpfung.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(354, '3.68', 12, 'Linke Klammerung', 'left(astar b\right)star c', 'left(astar b\right)star c', 'Erste Klammerung einer dreifachen Verknüpfung.', 'other', 'literature', 83, NULL, '', 'checked', 29),
(355, '3.69', 12, 'Rechte Klammerung', 'astarleft(bstar c\right)', 'astarleft(bstar c\right)', 'Zweite Klammerung einer dreifachen Verknüpfung.', 'other', 'literature', 83, NULL, '', 'checked', 29),
(356, '3.70', 12, 'Assoziativität', 'forall a,b,cin A:;left(astar b\right)star c=astarleft(bstar c\right)', 'forall a,b,cin A:;left(astar b\right)star c=astarleft(bstar c\right)', 'Assoziativgesetz.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(357, '3.71', 12, 'Halbgruppe', 'left(A,star\right)	ext{ ist Halbgruppe}Longleftrightarrowstar	ext{ ist abgeschlossen und assoziativ}', 'left(A,star\right)	ext{ ist Halbgruppe}Longleftrightarrowstar	ext{ ist abgeschlossen und assoziativ}', 'Charakterisierung einer Halbgruppe.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(358, '3.72', 12, 'Verknüpfungsfolge', 'a_1star a_2starcdotsstar a_n', 'a_1star a_2starcdotsstar a_n', 'Assoziativ interpretierbare endliche Verknüpfungsfolge.', 'schema', 'literature', 83, NULL, '', 'checked', 29),
(359, '3.73', 12, 'Linksneutrales Element', 'forall ain A:;estar a=a', 'forall ain A:;estar a=a', 'Linke Neutralität.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(360, '3.74', 12, 'Rechtsneutrales Element', 'forall ain A:;astar e=a', 'forall ain A:;astar e=a', 'Rechte Neutralität.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(361, '3.75', 12, 'Eindeutigkeit des neutralen Elements', 'e_1=e_1star e_2=e_2', 'e_1=e_1star e_2=e_2', 'Nachweis der Eindeutigkeit eines neutralen Elements.', 'derived', 'literature', 83, NULL, '', 'checked', 29),
(362, '3.76', 12, 'Monoid', 'left(A,star,e\right)	ext{ ist Monoid}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ ist neutrales Element}end{array}\right.', 'left(A,star,e\right)	ext{ ist Monoid}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ ist neutrales Element}end{array}\right.', 'Charakterisierung eines Monoids.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(363, '3.77', 12, 'Positive Potenz', 'a^n=underbrace{astar astarcdotsstar a}_{n	ext{ Faktoren}}', 'a^n=underbrace{astar astarcdotsstar a}_{n	ext{ Faktoren}}', 'Wiederholte Verknüpfung eines Elements.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(364, '3.78', 12, 'Nullte Potenz', 'a^0=e', 'a^0=e', 'Die nullte Potenz entspricht dem neutralen Element.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(365, '3.79', 12, 'Freies Wortmonoid', 'left(Sigma^ast,cdot,varepsilon\right)', 'left(Sigma^ast,cdot,varepsilon\right)', 'Monoid endlicher Wörter unter Konkatenation.', 'model', 'literature', 83, NULL, '', 'checked', 29),
(366, '3.80', 12, 'Rechtsinverses', 'astar a^{-1}=e', 'astar a^{-1}=e', 'Rechtsseitige Inversenbedingung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(367, '3.81', 12, 'Linksinverses', 'a^{-1}star a=e', 'a^{-1}star a=e', 'Linksseitige Inversenbedingung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(368, '3.82', 12, 'Gruppe', 'left(A,star\right)	ext{ ist Gruppe}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ existiert}\\forall ain A;exists a^{-1}in Aend{array}\right.', 'left(A,star\right)	ext{ ist Gruppe}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ existiert}\\forall ain A;exists a^{-1}in Aend{array}\right.', 'Charakterisierung einer Gruppe.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(369, '3.83', 12, 'Eindeutigkeit inverser Elemente', 'b=bstar e=bstarleft(astar c\right)=left(bstar a\right)star c=estar c=c', 'b=bstar e=bstarleft(astar c\right)=left(bstar a\right)star c=estar c=c', 'Herleitung der Eindeutigkeit des Inversen.', 'derived', 'literature', 84, NULL, '', 'checked', 29),
(370, '3.84', 12, 'Kommutativität', 'forall a,bin A:;astar b=bstar a', 'forall a,bin A:;astar b=bstar a', 'Kommutativgesetz einer abelschen Gruppe.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(371, '3.85', 12, 'Untergruppenkriterium', 'forall a,bin H:;astar b^{-1}in H', 'forall a,bin H:;astar b^{-1}in H', 'Praktisches Kriterium für eine Untergruppe.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(372, '3.86', 12, 'Gruppenhomomorphismus', 'varphileft(astar b\right)=varphi(a)circvarphi(b)', 'varphileft(astar b\right)=varphi(a)circvarphi(b)', 'Erhaltung der Gruppenverknüpfung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(373, '3.87', 12, 'Isomorphie', 'Gcong H', 'Gcong H', 'Kennzeichnung strukturgleicher Gruppen.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(374, '3.88', 12, 'Ringstruktur', 'left(R,+,cdot\right)', 'left(R,+,cdot\right)', 'Ring mit zwei inneren Operationen.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(375, '3.89', 12, 'Assoziativität der Addition', 'forall a,b,cin R:;left(a+b\right)+c=a+left(b+c\right)', 'forall a,b,cin R:;left(a+b\right)+c=a+left(b+c\right)', 'Assoziativgesetz der Addition.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(376, '3.90', 12, 'Additives neutrales Element', 'a+0=a', 'a+0=a', 'Additive Neutralität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(377, '3.91', 12, 'Additives Inverses', 'a+left(-a\right)=0', 'a+left(-a\right)=0', 'Additive Inversenbedingung.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(378, '3.92', 12, 'Assoziativität der Multiplikation', 'left(acdot b\right)cdot c=acdotleft(bcdot c\right)', 'left(acdot b\right)cdot c=acdotleft(bcdot c\right)', 'Assoziativgesetz der Multiplikation.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(379, '3.93', 12, 'Linkes Distributivgesetz', 'acdotleft(b+c\right)=acdot b+acdot c', 'acdotleft(b+c\right)=acdot b+acdot c', 'Linke Distributivität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(380, '3.94', 12, 'Rechtes Distributivgesetz', 'left(a+b\right)cdot c=acdot c+bcdot c', 'left(a+b\right)cdot c=acdot c+bcdot c', 'Rechte Distributivität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(381, '3.95', 12, 'Kommutative Multiplikation', 'acdot b=bcdot a', 'acdot b=bcdot a', 'Kommutativität in einem kommutativen Ring.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(382, '3.96', 12, 'Multiplikatives neutrales Element', '1cdot a=a=acdot 1', '1cdot a=a=acdot 1', 'Multiplikative Neutralität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(383, '3.97', 12, 'Multiplikatives Inverses im Körper', 'forall a\neq0;exists a^{-1}:;acdot a^{-1}=1', 'forall a\neq0;exists a^{-1}:;acdot a^{-1}=1', 'Inverseigenschaft von Körperelementen.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(384, '3.98', 12, 'Grundkörper', 'mathbb{Q},;mathbb{R},;mathbb{C}', 'mathbb{Q},;mathbb{R},;mathbb{C}', 'Beispiele wichtiger Körper.', 'schema', 'literature', 83, NULL, '', 'checked', 29),
(385, '3.99', 12, 'Skalarmultiplikation', 'K	imes Vlongrightarrow V', 'K	imes Vlongrightarrow V', 'Skalarmultiplikation eines Vektorraums.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(386, '3.100', 12, 'Distributivität über Vektoraddition', 'lambdaleft(u+v\right)=lambda u+lambda v', 'lambdaleft(u+v\right)=lambda u+lambda v', 'Erstes Distributivgesetz des Vektorraums.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(387, '3.101', 12, 'Distributivität über Skalaraddition', 'left(lambda+mu\right)v=lambda v+mu v', 'left(lambda+mu\right)v=lambda v+mu v', 'Zweites Distributivgesetz des Vektorraums.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(388, '3.102', 12, 'Assoziativität der Skalarmultiplikation', 'left(lambdamu\right)v=lambdaleft(mu v\right)', 'left(lambdamu\right)v=lambdaleft(mu v\right)', 'Verträglichkeit der Skalarmultiplikation.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(389, '3.103', 12, 'Skalare Identität', '1v=v', '1v=v', 'Wirkung der skalaren Eins.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(390, '3.104', 12, 'Homomorphismus', 'varphileft(astar b\right)=varphi(a)starvarphi(b)', 'varphileft(astar b\right)=varphi(a)starvarphi(b)', 'Allgemeine Erhaltung einer algebraischen Verknüpfung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(391, '3.105', 12, 'Additive Strukturerhaltung', 'varphileft(a+b\right)=varphi(a)+varphi(b)', 'varphileft(a+b\right)=varphi(a)+varphi(b)', 'Erhaltung der Ringaddition.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(392, '3.106', 12, 'Multiplikative Strukturerhaltung', 'varphileft(acdot b\right)=varphi(a)cdotvarphi(b)', 'varphileft(acdot b\right)=varphi(a)cdotvarphi(b)', 'Erhaltung der Ringmultiplikation.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(396, '3.107', 13, 'Allgemeiner Operator', 'T:X\\longrightarrow Y', 'T:X\\longrightarrow Y', 'Operator als Abbildung zwischen mathematisch strukturierten Räumen.', 'definition', 'literature', 35, NULL, 'X und Y sind geeignete mathematische Räume.', 'checked', 31),
(397, '3.108', 13, 'Operatorbild eines Elements', 'T(x)\\in Y', 'T(x)\\in Y', 'Bild eines Elements unter dem Operator.', 'derived', 'literature', 35, NULL, 'x\\in X.', 'checked', 31),
(398, '3.109', 13, 'Operator auf einem Raum', 'T:X\\longrightarrow X', 'T:X\\longrightarrow X', 'Endomorpher Operator auf X.', 'definition', 'literature', 35, NULL, 'Definitions- und Zielraum stimmen überein.', 'checked', 31),
(399, '3.110', 13, 'Rekursive Operatorwirkung', 'x_{n+1}=T(x_n)', 'x_{n+1}=T(x_n)', 'Ein Folgezustand entsteht durch Operatoranwendung.', 'model', 'literature', 35, NULL, 'x_n\\in X.', 'checked', 31),
(400, '3.111', 13, 'Iterierte Operatorwirkung', 'x_n=T^n(x_0)', 'x_n=T^n(x_0)', 'n-fache Komposition eines Operators.', 'derived', 'literature', 35, NULL, 'n\\in\\mathbb N.', 'checked', 31),
(401, '3.112', 13, 'Definitionsbereich', '\\mathcal{D}(T)\\subseteq X', '\\mathcal{D}(T)\\subseteq X', 'Tatsächlicher Definitionsbereich eines Operators.', 'definition', 'literature', 36, NULL, 'T ist möglicherweise nicht auf ganz X definiert.', 'checked', 31),
(402, '3.113', 13, 'Operator mit explizitem Definitionsbereich', 'T:\\mathcal{D}(T)\\longrightarrow Y', 'T:\\mathcal{D}(T)\\longrightarrow Y', 'Operatorabbildung mit eingeschränkter Domäne.', 'definition', 'literature', 36, NULL, '\\mathcal{D}(T)\\subseteq X.', 'checked', 31),
(403, '3.114', 13, 'Wertebereich eines Operators', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}\\subseteq Y', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}\\subseteq Y', 'Menge aller tatsächlich erzeugten Operatorbilder.', 'definition', 'literature', 36, NULL, NULL, 'checked', 31),
(404, '3.115', 13, 'Linearitätsbedingung', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'Erhalt von Linearkombinationen.', 'definition', 'literature', 89, NULL, 'X und Y sind Vektorräume über demselben Körper.', 'checked', 31),
(405, '3.116', 13, 'Additivität', 'T(x+y)=T(x)+T(y)', 'T(x+y)=T(x)+T(y)', 'Erhalt der Vektoraddition.', 'derived', 'literature', 89, NULL, 'T ist linear.', 'checked', 31),
(406, '3.117', 13, 'Homogenität', 'T(\\alpha x)=\\alpha T(x)', 'T(\\alpha x)=\\alpha T(x)', 'Erhalt der Skalarmultiplikation.', 'derived', 'literature', 89, NULL, 'T ist linear.', 'checked', 31),
(407, '3.118', 13, 'Kern eines Operators', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', 'Menge aller auf Null abgebildeten Elemente.', 'definition', 'literature', 89, NULL, 'T ist linear.', 'checked', 31),
(408, '3.119', 13, 'Bild eines Operators', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', 'Menge aller erreichbaren Operatorbilder.', 'definition', 'literature', 89, NULL, 'T ist linear.', 'checked', 31),
(409, '3.120', 13, 'Kern und Bild als Unterräume', '\\ker(T)\\leq X\\qquad\\text{und}\\qquad\\operatorname{im}(T)\\leq Y', '\\ker(T)\\leq X\\qquad\\text{und}\\qquad\\operatorname{im}(T)\\leq Y', 'Kern und Bild linearer Operatoren sind Unterräume.', 'theorem', 'literature', 89, NULL, 'T ist linear.', 'checked', 31),
(410, '3.121', 13, 'Injektivitätskriterium', '\\ker(T)=\\{0\\}', '\\ker(T)=\\{0\\}', 'Ein linearer Operator ist genau dann injektiv, wenn sein Kern trivial ist.', 'theorem', 'literature', 89, NULL, 'T ist linear.', 'checked', 31),
(411, '3.122', 13, 'Surjektivitätskriterium', '\\operatorname{im}(T)=Y', '\\operatorname{im}(T)=Y', 'Ein Operator ist surjektiv, wenn sein Bild dem Zielraum entspricht.', 'definition', 'literature', 89, NULL, NULL, 'checked', 31),
(412, '3.123', 13, 'Operatorenkomposition', '(S\\circ T)(x)=S(T(x))', '(S\\circ T)(x)=S(T(x))', 'Aufeinanderfolgende Anwendung zweier Operatoren.', 'definition', 'literature', 35, NULL, 'T:X\\to Y und S:Y\\to Z.', 'checked', 31),
(413, '3.124', 13, 'Abbildungstyp der Komposition', 'S\\circ T:X\\longrightarrow Z', 'S\\circ T:X\\longrightarrow Z', 'Komposition als Operator von X nach Z.', 'derived', 'literature', 35, NULL, 'Kompatible Definitions- und Zielräume.', 'checked', 31),
(414, '3.125', 13, 'Assoziativität der Komposition', 'R\\circ(S\\circ T)=(R\\circ S)\\circ T', 'R\\circ(S\\circ T)=(R\\circ S)\\circ T', 'Assoziativität der Operatorverkettung.', 'theorem', 'literature', 35, NULL, 'Kompositionen sind definiert.', 'checked', 31),
(415, '3.126', 13, 'Nichtkommutativität', 'S\\circ T\\neq T\\circ S', 'S\\circ T\\neq T\\circ S', 'Operatorenkomposition ist im Allgemeinen nicht kommutativ.', 'other', 'literature', 35, NULL, 'Beide Kompositionen sind definiert.', 'checked', 31),
(416, '3.127', 13, 'Identitätsoperator', 'I_X:X\\longrightarrow X', 'I_X:X\\longrightarrow X', 'Identitätsoperator auf X.', 'definition', 'literature', 35, NULL, NULL, 'checked', 31),
(417, '3.128', 13, 'Wirkung des Identitätsoperators', 'I_X(x)=x', 'I_X(x)=x', 'Der Identitätsoperator lässt jedes Element unverändert.', 'definition', 'literature', 35, NULL, 'x\\in X.', 'checked', 31),
(418, '3.129', 13, 'Neutralität des Identitätsoperators', 'T\\circ I_X=T=I_Y\\circ T', 'T\\circ I_X=T=I_Y\\circ T', 'Identitätsoperator als neutrales Element der Komposition.', 'theorem', 'literature', 35, NULL, 'T:X\\to Y.', 'checked', 31),
(419, '3.130', 13, 'Linksinverse', 'T^{-1}\\circ T=I_X', 'T^{-1}\\circ T=I_X', 'Linksinverse hebt T auf X auf.', 'definition', 'literature', 35, NULL, 'T ist invertierbar.', 'checked', 31),
(420, '3.131', 13, 'Rechtsinverse', 'T\\circ T^{-1}=I_Y', 'T\\circ T^{-1}=I_Y', 'Rechtsinverse hebt T auf Y auf.', 'definition', 'literature', 35, NULL, 'T ist invertierbar.', 'checked', 31),
(421, '3.132', 13, 'Endomorphismenmenge', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', 'Menge aller linearen Endomorphismen von V.', 'definition', 'literature', 36, NULL, 'V ist ein Vektorraum.', 'checked', 31),
(422, '3.133', 13, 'Addition von Operatoren', '(S+T)(x)=S(x)+T(x)', '(S+T)(x)=S(x)+T(x)', 'Punktweise Addition linearer Operatoren.', 'definition', 'literature', 36, NULL, 'S und T sind lineare Operatoren V nach V.', 'checked', 31),
(423, '3.134', 13, 'Skalarmultiplikation von Operatoren', '(\\lambda T)(x)=\\lambda T(x)', '(\\lambda T)(x)=\\lambda T(x)', 'Punktweise Skalarmultiplikation eines Operators.', 'definition', 'literature', 36, NULL, '\\lambda liegt im Skalarkörper.', 'checked', 31),
(424, '3.135', 13, 'Spektrum eines Operators', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', 'Spektrum als Menge der Nichtinvertierbarkeitswerte.', 'definition', 'literature', 11, NULL, 'T ist ein geeigneter linearer Operator.', 'checked', 31);

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
(1, 2, 1, 'contrasts', 'Die FRZK-Entwicklungsrichtung wird der klassischen Entwicklungsrichtung gegenübergestellt.');

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
(36, 232, 'x', 'Element', 'Beliebiges mathematisches Objekt.', NULL, 'Objekt', 1),
(37, 232, 'M', 'Menge', 'Menge, deren Elementzugehörigkeit geprüft wird.', NULL, 'Menge', 2),
(38, 233, 'x', 'Element', 'Beliebiges mathematisches Objekt.', NULL, 'Objekt', 1),
(39, 233, 'M', 'Menge', 'Menge, zu der x nicht gehört.', NULL, 'Menge', 2),
(40, 234, '\\emptyset', 'Leere Menge', 'Eindeutig bestimmte Menge ohne Elemente.', NULL, 'Menge', 1),
(41, 235, 'A', 'Menge A', 'Erste Vergleichsmenge.', NULL, 'Menge', 1),
(42, 235, 'B', 'Menge B', 'Zweite Vergleichsmenge.', NULL, 'Menge', 2),
(43, 235, 'x', 'Element', 'Beliebiges Prüfelement.', NULL, 'Objekt', 3),
(44, 236, 'A', 'Teilmenge', 'Mögliche Teilmenge von B.', NULL, 'Menge', 1),
(45, 236, 'B', 'Obermenge', 'Menge, die alle Elemente von A enthält.', NULL, 'Menge', 2),
(46, 236, 'x', 'Element', 'Beliebiges Element.', NULL, 'Objekt', 3),
(47, 237, 'A_P', 'Aussonderungsmenge', 'Teilmenge der Elemente von A mit Eigenschaft P.', NULL, 'Menge', 1),
(48, 237, 'A', 'Grundmenge', 'Bereits vorhandene Menge.', NULL, 'Menge', 2),
(49, 237, 'P(x)', 'Prädikat', 'Auswahlbedingung für x.', NULL, 'Aussage', 3),
(50, 238, 'A', 'Menge A', 'Erste Vereinigungsmenge.', NULL, 'Menge', 1),
(51, 238, 'B', 'Menge B', 'Zweite Vereinigungsmenge.', NULL, 'Menge', 2),
(52, 238, 'x', 'Element', 'Element mindestens einer Ausgangsmenge.', NULL, 'Objekt', 3),
(53, 239, 'A', 'Menge A', 'Erste Schnittmenge.', NULL, 'Menge', 1),
(54, 239, 'B', 'Menge B', 'Zweite Schnittmenge.', NULL, 'Menge', 2),
(55, 239, 'x', 'Element', 'Gemeinsames Element beider Mengen.', NULL, 'Objekt', 3),
(56, 240, 'A', 'Menge A', 'Ausgangsmenge.', NULL, 'Menge', 1),
(57, 240, 'B', 'Menge B', 'Auszuschließende Menge.', NULL, 'Menge', 2),
(58, 240, 'x', 'Element', 'Element von A, das nicht in B liegt.', NULL, 'Objekt', 3),
(59, 241, 'A^c', 'Komplement', 'Komplement von A relativ zu U.', NULL, 'Menge', 1),
(60, 241, 'U', 'Grundmenge', 'Bezugsuniversum des Komplements.', NULL, 'Menge', 2),
(61, 241, 'A', 'Teilmenge', 'Zu komplementierende Teilmenge.', NULL, 'Menge', 3),
(62, 242, 'A', 'Menge A', 'Erste Faktormenge.', NULL, 'Menge', 1),
(63, 242, 'B', 'Menge B', 'Zweite Faktormenge.', NULL, 'Menge', 2),
(64, 242, '(a,b)', 'Geordnetes Paar', 'Paar mit erster Komponente aus A und zweiter aus B.', NULL, 'Geordnetes Paar', 3),
(65, 243, '\\mathcal P(A)', 'Potenzmenge', 'Menge aller Teilmengen von A.', NULL, 'Menge', 1),
(66, 243, 'X', 'Teilmenge', 'Beliebige Teilmenge von A.', NULL, 'Menge', 2),
(67, 243, 'A', 'Ausgangsmenge', 'Menge, deren Potenzmenge gebildet wird.', NULL, 'Menge', 3),
(68, 244, '|\\mathcal P(A)|', 'Mächtigkeit der Potenzmenge', 'Kardinalität der Potenzmenge von A.', NULL, 'Kardinalzahl', 1),
(69, 244, '|A|', 'Mächtigkeit von A', 'Kardinalität der Ausgangsmenge A.', NULL, 'Kardinalzahl', 2),
(70, 245, '\\Omega', 'Mengenoperation', 'Allgemeine Operation auf Teilmengen von M.', NULL, 'Operator', 1),
(71, 245, '\\mathcal P(M)', 'Potenzmenge', 'Definitions- und Zielbereich der Operation.', NULL, 'Menge', 2),
(72, 245, 'M', 'Grundmenge', 'Zugrunde liegende Menge.', NULL, 'Menge', 3),
(85, 258, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 1),
(86, 258, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 2),
(87, 259, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(88, 259, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(89, 259, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(90, 260, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(91, 261, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(92, 261, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(93, 262, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(94, 262, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(95, 262, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(96, 263, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(97, 263, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(98, 263, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(99, 264, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(100, 265, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(101, 265, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(102, 266, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(103, 266, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(104, 267, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(105, 267, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(106, 268, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(107, 268, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(108, 269, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(109, 269, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(110, 270, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(111, 270, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(112, 271, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(113, 272, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(114, 272, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(115, 273, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(116, 273, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(117, 274, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(118, 275, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 1),
(119, 275, 'preceq', 'Ordnungsrelation', 'Halb- oder Totalordnung.', NULL, 'Relation auf A', 2),
(120, 276, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 1),
(121, 276, 'preceq', 'Ordnungsrelation', 'Halb- oder Totalordnung.', NULL, 'Relation auf A', 2),
(122, 277, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(123, 277, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(124, 277, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(125, 277, 'circ', 'Relationskomposition', 'Komposition zweier Relationen.', NULL, 'Relationsoperation', 4),
(126, 278, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(127, 278, 'circ', 'Relationskomposition', 'Komposition zweier Relationen.', NULL, 'Relationsoperation', 2),
(128, 279, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(129, 279, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(130, 280, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(131, 280, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(132, 280, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(133, 281, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(134, 281, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(135, 281, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(136, 282, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(137, 282, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(138, 282, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(139, 283, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(140, 283, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(141, 283, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(142, 284, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(143, 284, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(144, 284, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(145, 285, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(146, 286, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(147, 286, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(148, 287, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(149, 287, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(150, 287, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(151, 288, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(152, 289, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(153, 289, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(154, 290, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(155, 290, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(156, 291, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(157, 292, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(158, 292, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(159, 292, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(160, 293, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(161, 293, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(162, 293, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(163, 294, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(164, 295, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(165, 295, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(166, 295, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(167, 296, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(168, 297, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(169, 298, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(170, 298, 'g', 'zweite Funktion', 'zweite Funktion.', NULL, 'Abbildung', 2),
(171, 299, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(172, 299, 'g', 'zweite Funktion', 'zweite Funktion.', NULL, 'Abbildung', 2),
(173, 300, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 1),
(174, 300, '\\operatorname{id}', 'Identitätsabbildung', 'Identitätsabbildung.', NULL, 'Abbildung', 3),
(175, 301, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 1),
(176, 301, '\\operatorname{id}', 'Identitätsabbildung', 'Identitätsabbildung.', NULL, 'Abbildung', 2),
(177, 302, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(178, 302, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(179, 302, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(180, 302, '\\operatorname{id}', 'Identitätsabbildung', 'Identitätsabbildung.', NULL, 'Abbildung', 4),
(181, 351, 'star', 'binäre Verknüpfung', 'Innere Verknüpfung auf A.', NULL, 'A×A→A', 1),
(182, 351, 'A', 'Trägermenge', 'Grundmenge der algebraischen Struktur.', NULL, 'Menge', 2),
(183, 359, 'e', 'neutrales Element', 'Element ohne verändernde Wirkung.', NULL, 'A', 1),
(184, 366, 'a^{-1}', 'inverses Element', 'Inverse zu a.', NULL, 'A', 1),
(185, 372, 'varphi', 'Homomorphismus', 'Strukturerhaltende Abbildung.', NULL, 'Abbildung', 1),
(186, 374, 'R', 'Ring', 'Trägermenge des Ringes.', NULL, 'Ring', 1),
(187, 385, 'K', 'Skalarkörper', 'Körper der Skalare.', NULL, 'Körper', 1),
(188, 385, 'V', 'Vektorraum', 'Träger der Vektoren.', NULL, 'Vektorraum', 2),
(189, 386, 'lambda', 'Skalar', 'Element des Körpers K.', NULL, 'K', 1),
(190, 386, 'u', 'Vektor', 'Element von V.', NULL, 'V', 2),
(191, 386, 'v', 'Vektor', 'Element von V.', NULL, 'V', 3),
(192, 396, 'T', 'Operator', 'Abbildung zwischen mathematischen Räumen.', NULL, 'X\\to Y', 1),
(193, 396, 'X', 'Definitionsraum', 'Mathematischer Ausgangsraum.', NULL, 'Raum', 2),
(194, 396, 'Y', 'Zielraum', 'Mathematischer Zielraum.', NULL, 'Raum', 3),
(195, 399, 'x_n', 'Zustand', 'Zustand nach n Operatoranwendungen.', NULL, 'X', 1),
(196, 400, 'T^n', 'Operatoriteration', 'n-fache Komposition von T.', NULL, 'X\\to X', 1),
(197, 401, '\\mathcal{D}(T)', 'Definitionsbereich', 'Tatsächliche Domäne des Operators.', NULL, 'Teilmenge von X', 1),
(198, 403, '\\mathcal{R}(T)', 'Wertebereich', 'Menge der tatsächlich erzeugten Bilder.', NULL, 'Teilmenge von Y', 1),
(199, 404, '\\alpha,\\beta', 'Skalare', 'Skalare des zugrunde liegenden Körpers.', NULL, 'K', 1),
(200, 407, '\\ker(T)', 'Kern', 'Nullraum des linearen Operators.', NULL, 'Unterraum von X', 1),
(201, 408, '\\operatorname{im}(T)', 'Bild', 'Bildraum des linearen Operators.', NULL, 'Unterraum von Y', 1),
(202, 412, 'S\\circ T', 'Operatorenkomposition', 'Verkettung der Operatoren T und S.', NULL, 'X\\to Z', 1),
(203, 416, 'I_X', 'Identitätsoperator', 'Neutrale Transformation auf X.', NULL, 'X\\to X', 1),
(204, 419, 'T^{-1}', 'Inverser Operator', 'Umkehrabbildung eines invertierbaren Operators.', NULL, 'Y\\to X', 1),
(205, 421, '\\operatorname{End}(V)', 'Endomorphismenmenge', 'Menge aller linearen Endomorphismen von V.', NULL, 'Operatorraum', 1),
(206, 424, '\\sigma(T)', 'Spektrum', 'Menge der Nichtinvertierbarkeitswerte.', NULL, 'Teilmenge von \\mathbb C', 1),
(207, 424, '\\lambda', 'Spektralparameter', 'Komplexer Skalar im Spektrum.', NULL, '\\mathbb C', 2);

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
(2, 'Abb. 3.1', 9, 'Mengenhierarchie', 'Schematische Darstellung von Element, Menge und Teilmenge.', NULL, NULL, NULL, 'schema', 'original', NULL, NULL, NULL, 'draft', 6);

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
('last_completed_section', '3.4', '2026-07-12 11:14:28'),
('last_edited_section', '3.2.5', '2026-07-15 05:38:39'),
('last_repository_revision', 'RKB-2026-07-15-K3.2.5-NEUFASSUNG-V2', '2026-07-15 05:38:39'),
('next_citation_number', '68', '2026-07-15 05:38:39'),
('next_equation_number', '3.136', '2026-07-15 05:38:39');

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
(24, 'RKB-2026-07-14-K3.2.1-NEUFASSUNG-V2', '2026-07-14 16:56:18', 'section', '3.2.1', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.1 mit Mengenbegriff, Axiomatik, Mengenoperationen, kartesischem Produkt, Potenzmenge und Forschungsgrenze.', 'Olaf Thiele / ChatGPT', 21),
(25, 'RKB-2026-07-14-K3.2.2-NEUFASSUNG-V2', '2026-07-14 17:51:26', 'section', '3.2.2', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.2 mit Relationseigenschaften, Äquivalenz- und Ordnungsrelationen, Relationskomposition und Graphinterpretation.', 'Olaf Thiele / ChatGPT', 24),
(26, 'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V2', '2026-07-14 18:13:43', 'section', '3.2.3', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.3 mit modernem Funktionsbegriff, Bild und Urbild, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung.', 'Olaf Thiele / ChatGPT', 25),
(29, 'RKB-2026-07-14-K3.2.4-NEUFASSUNG-V2', '2026-07-15 07:36:21', 'section', '3.2.4', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.4 mit Magmen, Halbgruppen, Monoiden, Gruppen, Ringen, Körpern, Vektorräumen, Homomorphismen und Symmetriebezug.', 'Olaf Thiele / ChatGPT', 26),
(31, 'RKB-2026-07-15-K3.2.5-NEUFASSUNG-V2', '2026-07-15 07:38:39', 'section', '3.2.5', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.5 mit allgemeinem Operatorbegriff, Definitions- und Wertebereich, linearen Operatoren, Kern und Bild, Operatoralgebra, Invertierbarkeit und Spektrum.', 'Olaf Thiele / ChatGPT', 29);

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
(8, 6, 7, 'symbol_added', 'symbols', 'Symbolverzeichnis 3.2', 'Zentrale mathematische Symbole aus Kapitel 3.2 registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(9, 6, 7, 'figure_added', 'figures', 'Abb. 3.1–Abb. 3.8', 'Acht geplante Abbildungen registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(10, 6, 7, 'table_added', 'tables', 'Tab. 3.1–Tab. 3.5', 'Fünf geplante Tabellen registriert.', NULL, NULL, '2026-07-12 06:10:58'),
(11, 6, 7, 'renumbered', 'citations', 'Dublettenbereinigung', 'Barabási, Haken und Holland werden mit [15], [12] und [14] wiederverwendet; die nachfolgenden neuen Quellen wurden auf [49]–[52] korrigiert.', NULL, NULL, '2026-07-12 06:10:58'),
(12, 6, 7, 'status_changed', 'section', '3.2', 'Kapitel 3.2 auf Status review gesetzt.', NULL, NULL, '2026-07-12 06:10:58'),
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
(82, 24, 9, 'rewritten', 'section', '3.2.1', 'Abschnitt 3.2.1 vollständig neu gefasst.', 'Frühere Arbeitsfassung.', 'Dissertationsfähige Neufassung mit historischem Forschungsstand, Axiomatik, Mengenoperationen und expliziter Forschungsgrenze.', '2026-07-14 14:56:18'),
(83, 24, 9, 'source_added', 'source', '[58]', 'Fraenkel, Bar-Hillel und Levy als neue Referenzquelle aufgenommen.', NULL, 'Foundations of Set Theory.', '2026-07-14 14:56:18'),
(84, 24, 9, 'source_reused', 'source', '[23], [24]', 'Cantor und Zermelo mit bestehenden Literaturnummern wiederverwendet.', NULL, 'Primärquellen zur Mengenlehre.', '2026-07-14 14:56:18'),
(85, 24, 9, 'equation_changed', 'equation', '(3.3)–(3.16)', 'Gleichungsbestand des Abschnitts vollständig neu aufgebaut.', NULL, '14 Gleichungen mit Word-LaTeX und Symbolzuordnungen.', '2026-07-14 14:56:18'),
(86, 24, 9, 'definition_added', 'definition', 'Def. 3.2.1.1–3.2.1.6', 'Sechs zentrale Definitionen registriert.', NULL, 'Menge, Element, leere Menge, Teilmenge, kartesisches Produkt und Potenzmenge.', '2026-07-14 14:56:18'),
(87, 25, 10, 'rewritten', 'section', '3.2.2', 'Abschnitt 3.2.2 wurde vollständig neu gefasst.', 'Vorheriger Repository-Stand.', 'Neufassung V2 mit 25 Gleichungen.', '2026-07-14 15:51:27'),
(88, 25, 10, 'source_added', 'source', '[59]', 'Tarskis Primärquelle zur Relationsalgebra wurde aufgenommen.', NULL, 'On the Calculus of Relations.', '2026-07-14 15:51:27'),
(89, 25, 10, 'source_reused', 'sources', '[27], [28]', 'Enderton sowie Davey und Priestley wurden wiederverwendet.', NULL, 'Drei Quellenverwendungen insgesamt.', '2026-07-14 15:51:27'),
(90, 25, 10, 'equation_added', 'equations', '(3.17)–(3.41)', 'Relationen, Eigenschaften, Klassen, Ordnungen, Komposition und Graphmodell wurden registriert.', NULL, '25 Gleichungen.', '2026-07-14 15:51:27'),
(91, 25, 10, 'definition_added', 'definitions', 'Def. 3.2.2.1–3.2.2.8', 'Acht Definitionen wurden registriert.', NULL, '8 Definitionen.', '2026-07-14 15:51:27'),
(92, 25, 10, 'status_changed', 'section', '3.2.2', 'Abschnitt auf review gesetzt.', 'planned', 'review', '2026-07-14 15:51:27'),
(93, 26, 11, 'rewritten', 'section', '3.2.3', 'Abschnitt 3.2.3 wurde vollständig neu gefasst.', 'Bisheriger oder geplanter Abschnittsstand.', 'Neufassung mit Funktionen, Abbildungseigenschaften, Komposition und Identität.', '2026-07-14 16:13:43'),
(94, 26, 11, 'source_added', 'sources', '[60]', 'Dirichlet [60] wurde als neue Primärquelle registriert.', NULL, '1 neue Quelle.', '2026-07-14 16:13:43'),
(95, 26, 11, 'source_reused', 'sources', '[29], [30]', 'Die bestehenden Quellen [29] und [30] wurden wiederverwendet.', NULL, '2 Quellenwiederverwendungen.', '2026-07-14 16:13:43'),
(96, 26, 11, 'equation_added', 'equations', '(3.42)–(3.64)', '23 Gleichungen wurden registriert.', NULL, '23 Gleichungen.', '2026-07-14 16:13:43'),
(97, 26, 11, 'definition_added', 'definitions', 'Def. 3.2.3.1–3.2.3.9', 'Neun Definitionen wurden registriert.', NULL, '9 Definitionen.', '2026-07-14 16:13:43'),
(98, 26, 11, 'symbol_added', 'symbols', '3.2.3', 'Zentrale Funktionssymbole wurden registriert.', NULL, '4 Abschnittssymbole.', '2026-07-14 16:13:43'),
(99, 26, 11, 'status_changed', 'section', '3.2.3', 'Der Abschnitt wurde auf review gesetzt.', NULL, 'review', '2026-07-14 16:13:43'),
(100, 29, 12, 'rewritten', 'section', '3.2.4', 'Abschnitt 3.2.4 vollständig neu gefasst.', 'Bisheriger Repository-Stand.', 'Neufassung mit fünf neuen Quellen, dreizehn Definitionen und 42 Gleichungen.', '2026-07-15 05:36:22'),
(101, 29, 12, 'source_added', 'sources', '[61]–[65]', 'Fünf neue Literaturquellen registriert.', NULL, 'Galois [61], Noether [62], van der Waerden [63], Mac Lane/Birkhoff [64], Noether [65].', '2026-07-15 05:36:22'),
(102, 29, 12, 'definition_added', 'definitions', 'Def. 3.2.4.1–Def. 3.2.4.13', 'Dreizehn algebraische Definitionen registriert.', NULL, 'Binäre Verknüpfung bis Vektorraum.', '2026-07-15 05:36:22'),
(103, 29, 12, 'equation_added', 'equations', '(3.65)–(3.106)', '42 Gleichungen registriert.', NULL, 'Algebraische Strukturen und Strukturerhaltung.', '2026-07-15 05:36:22'),
(104, 29, 12, 'symbol_added', 'symbols', 'star, e, a^{-1}, varphi, R, K, V', 'Zentrale Abschnittssymbole registriert.', NULL, 'Symbolregister 3.2.4 V2.', '2026-07-15 05:36:22'),
(105, 31, 13, 'rewritten', 'section', '3.2.5', 'Abschnitt 3.2.5 vollständig neu gefasst.', 'Bisheriger Repository-Stand.', 'Neufassung mit Operatorbegriff, linearer Struktur, Operatoralgebra und Spektrum.', '2026-07-15 05:38:39'),
(106, 31, 13, 'source_added', 'sources', '[66]–[67]', 'Zwei neue Primärquellen registriert.', NULL, 'Hilbert [66], Banach [67].', '2026-07-15 05:38:39'),
(107, 31, 13, 'source_reused', 'sources', '[11], [35], [36]', 'Drei bestehende Standardquellen wiederverwendet.', NULL, 'Rudin [11], Conway [35], Kreyszig [36].', '2026-07-15 05:38:39'),
(108, 31, 13, 'definition_added', 'definitions', 'Def. 3.2.5.1–Def. 3.2.5.10', 'Zehn Definitionen registriert.', NULL, 'Operator bis Spektrum.', '2026-07-15 05:38:39'),
(109, 31, 13, 'equation_added', 'equations', '(3.107)–(3.135)', '29 Gleichungen registriert.', NULL, 'Operatorbegriff, Linearität, Kern, Bild, Komposition, Invertierbarkeit und Spektrum.', '2026-07-15 05:38:39'),
(110, 31, 13, 'symbol_added', 'symbols', 'T, D(T), R(T), ker(T), im(T), I_X, T^{-1}, End(V), sigma(T)', 'Zentrale Operatorsymbole registriert.', NULL, 'Symbolregister 3.2.5.', '2026-07-15 05:38:39');

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
(63, 58, 'fraenkel_bar_hillel_levy_foundations_set_theory_1973', 'book', 'Foundations of Set Theory', NULL, 1958, 1973, NULL, 'North-Holland', 'Amsterdam', NULL, NULL, NULL, 'Second Revised Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'partially_verified', '3.2.1', 'Erstnennung in der Neufassung von Abschnitt 3.2.1.', 'Fraenkel, Abraham A.; Bar-Hillel, Yehoshua; Levy, Azriel: Foundations of Set Theory. Second Revised Edition. Amsterdam: North-Holland, 1973.', 'Fraenkel, Bar-Hillel und Levy [58]', 'Referenzwerk zur axiomatischen Mengenlehre, zu ZFC und zur Begrenzung zulässiger Mengenbildungen.', 24, '2026-07-12 12:53:53', '2026-07-14 14:56:18'),
(69, 59, 'tarski_calculus_relations_1941', 'journal_article', 'On the Calculus of Relations', NULL, 1941, 1941, 'The Journal of Symbolic Logic', NULL, NULL, '6', '3', '73–89', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 4, 'verified', '3.2.2', 'Erstnennung zur Algebra und Komposition von Relationen.', 'Tarski, Alfred: On the Calculus of Relations. The Journal of Symbolic Logic, Bd. 6, Nr. 3, 1941, S. 73–89.', 'Tarski [59]', 'Primärquelle zur Relationsalgebra.', 25, '2026-07-14 15:51:27', '2026-07-14 15:51:27'),
(70, 60, 'dirichlet_functions_1837', 'journal_article', 'Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen', NULL, 1837, 1889, 'Repertorium der Physik', NULL, NULL, '1', NULL, '152–174', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'partially_verified', '3.2.3', 'Erstnennung zur historischen Ablösung des Funktionsbegriffs von einer ausschließlich analytischen Darstellung.', 'Dirichlet, Peter Gustav Lejeune: Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen. Repertorium der Physik, Bd. 1, 1837, S. 152–174; wiederabgedruckt in: Dirichlet’s Werke, Bd. 1, Berlin: Georg Reimer, 1889, S. 133–160.', 'Dirichlet [60]', 'Primärquelle zum modernen abstrakten Funktionsbegriff.', 26, '2026-07-14 16:13:43', '2026-07-14 16:13:43'),
(81, 61, 'galois_resolubilite_1846', 'journal_article', 'Mémoire sur les conditions de résolubilité des équations par radicaux', NULL, 1831, 1846, 'Journal de Mathématiques Pures et Appliquées', NULL, NULL, '11', NULL, '417–433', NULL, NULL, NULL, NULL, 'fr', 5, 'primary', 4, 'partially_verified', '3.2.4', 'Historische Primärquelle zur Entstehung der Gruppentheorie.', 'Galois, Évariste: Mémoire sur les conditions de résolubilité des équations par radicaux. Eingereicht 1831; veröffentlicht in: Journal de Mathématiques Pures et Appliquées, Bd. 11, 1846, S. 417–433.', 'Galois [61]', 'Primärquelle zur Symmetriestruktur algebraischer Gleichungen.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(82, 62, 'noether_idealtheorie_1921', 'journal_article', 'Idealtheorie in Ringbereichen', NULL, 1921, 1921, 'Mathematische Annalen', NULL, NULL, '83', NULL, '24–66', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 5, 'verified', '3.2.4', 'Primärquelle zur strukturellen Ring- und Idealtheorie.', 'Noether, Emmy: Idealtheorie in Ringbereichen. Mathematische Annalen, Bd. 83, 1921, S. 24–66.', 'Noether [62]', 'Grundlage der modernen strukturellen Algebra.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(83, 63, 'van_der_waerden_moderne_algebra_1930', 'book', 'Moderne Algebra', NULL, 1930, 1931, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'secondary', 5, 'partially_verified', '3.2.4', 'Systematische Darstellung abstrakter algebraischer Strukturen.', 'van der Waerden, Bartel Leendert: Moderne Algebra. Berlin: Springer, 1930–1931.', 'van der Waerden [63]', 'Standardwerk zur strukturellen Algebra.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(84, 64, 'mac_lane_birkhoff_algebra_1988', 'book', 'Algebra', NULL, 1967, 1988, NULL, 'Chelsea Publishing', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'secondary', 4, 'partially_verified', '3.2.4', 'Standardreferenz zu Gruppen, Homomorphismen und algebraischen Strukturen.', 'Mac Lane, Saunders; Birkhoff, Garrett: Algebra. 3. Auflage. New York: Chelsea Publishing, 1988.', 'Mac Lane/Birkhoff [64]', 'Standardwerk der abstrakten Algebra.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(85, 65, 'noether_invariante_variationsprobleme_1918', 'journal_article', 'Invariante Variationsprobleme', NULL, 1918, 1918, 'Nachrichten von der Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse', NULL, NULL, NULL, NULL, '235–257', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 5, 'verified', '3.2.4', 'Primärquelle zum Zusammenhang von kontinuierlichen Symmetrien und Erhaltungssätzen.', 'Noether, Emmy: Invariante Variationsprobleme. Nachrichten von der Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse, 1918, S. 235–257.', 'Noether [65]', 'Primärquelle zum Noether-Theorem.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(88, 66, 'hilbert_integralgleichungen_1912', 'book', 'Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen', NULL, 1912, 1912, NULL, 'B. G. Teubner', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'primary', 5, 'partially_verified', '3.2.5', 'Historische Primärquelle zur Entwicklung der Operatorentheorie.', 'Hilbert, David: Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen. Leipzig: B. G. Teubner, 1912.', 'Hilbert [66]', 'Begründet die systematische Betrachtung linearer Integraloperatoren.', 31, '2026-07-15 05:38:39', '2026-07-15 05:38:39'),
(89, 67, 'banach_operations_lineaires_1932', 'book', 'Théorie des opérations linéaires', NULL, 1932, 1932, NULL, 'Monografie Matematyczne', 'Warszawa', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'fr', 5, 'primary', 5, 'partially_verified', '3.2.5', 'Primärquelle zur allgemeinen Theorie linearer Operatoren auf normierten Räumen.', 'Banach, Stefan: Théorie des opérations linéaires. Warszawa: Monografie Matematyczne, 1932.', 'Banach [67]', 'Grundlage der linearen Funktionalanalysis und der Theorie beschränkter Operatoren.', 31, '2026-07-15 05:38:39', '2026-07-15 05:38:39');

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
(63, 44, 3, 'author'),
(69, 53, 1, 'author'),
(70, 45, 1, 'author'),
(81, 65, 1, 'author'),
(82, 66, 1, 'author'),
(83, 48, 1, 'author'),
(84, 47, 1, 'author'),
(84, 69, 2, 'author'),
(85, 66, 1, 'author'),
(88, 7, 1, 'author'),
(89, 73, 1, 'author');

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
(215, 23, 9, 'historical_context', 'Cantors Arbeiten begründen den modernen Mengenbegriff, die transfinite Mengenlehre, die Potenzmengenbildung und den Satz über die größere Mächtigkeit der Potenzmenge.', '3.2.1: historische Entwicklung und Mengenoperationen', 0, 1, 'Bestehende Quelle [23] wird wiederverwendet.', 24),
(216, 24, 9, 'state_of_research', 'Zermelos Axiomatisierung begrenzt zulässige Mengenbildungen und fundiert Extensionalität, Aussonderung, Vereinigung und Potenzmenge.', '3.2.1: axiomatische Fundierung und Mengenoperationen', 0, 1, 'Bestehende Quelle [24] wird wiederverwendet.', 24),
(217, 63, 9, 'first_citation', 'Das Referenzwerk systematisiert die axiomatischen Grundlagen von ZFC und grenzt Konstruktion vorhandener Mengen von einer Erklärung ihrer Genese ab.', '3.2.1: axiomatische Einordnung und wissenschaftliche Grenze', 1, 1, 'Neue Erstnennung [58].', 24),
(221, 27, 10, 'state_of_research', 'Enderton fundiert den mengentheoretischen Relationsbegriff, geordnete Paare, kartesische Produkte und grundlegende Relationseigenschaften.', 'Abschnitt 3.2.2', 0, 1, 'Neufassung V2.', 25),
(222, 28, 10, 'state_of_research', 'Davey und Priestley fundieren Halbordnungen, Totalordnungen und hierarchische relationale Strukturen.', 'Abschnitt 3.2.2', 0, 1, 'Neufassung V2.', 25),
(223, 69, 10, 'first_citation', 'Tarski fundiert Relationskomposition und die algebraische Behandlung von Relationen.', 'Abschnitt 3.2.2', 1, 1, 'Neufassung V2.', 25),
(224, 70, 11, 'first_citation', 'Historische Entwicklung des modernen Funktionsbegriffs und Ablösung von einer ausschließlich analytischen Darstellung.', 'Historische Entwicklung in 3.2.3', 1, 1, 'Neufassung 3.2.3 V2.', 26),
(225, 29, 11, 'definition', 'Formale Definition einer Funktion, Bild, Urbild sowie Existenz- und Eindeutigkeitsbedingungen.', 'Definitionen in 3.2.3', 0, 1, 'Neufassung 3.2.3 V2.', 26),
(226, 30, 11, 'definition', 'Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung.', 'Eigenschaften in 3.2.3', 0, 1, 'Neufassung 3.2.3 V2.', 26),
(237, 81, 12, 'first_citation', 'Historische Entstehung der Gruppentheorie aus der Analyse algebraischer Gleichungen.', 'Einleitung 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(238, 82, 12, 'first_citation', 'Strukturelle Ring- und Idealtheorie als Wendepunkt der modernen Algebra.', 'Einleitung sowie Ringabschnitt 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(239, 83, 12, 'first_citation', 'Systematische Definition algebraischer Grundstrukturen von der binären Verknüpfung bis zum Vektorraum.', 'Definitionen und Strukturhierarchie 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(240, 84, 12, 'first_citation', 'Gruppen, Untergruppen, Homomorphismen und Isomorphismen.', 'Gruppenabschnitt 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(241, 85, 12, 'first_citation', 'Zusammenhang von Symmetriegruppen und Erhaltungssätzen.', 'Symmetrieabschnitt 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(247, 88, 13, 'first_citation', 'Historische Entwicklung linearer Integraloperatoren', 'Einleitender Forschungsstand zu Hilbert', 1, 1, 'Neue Erstnennung [66].', 31),
(248, 89, 13, 'first_citation', 'Allgemeine Theorie linearer Operatoren auf normierten Räumen', 'Einleitender Forschungsstand zu Banach', 1, 1, 'Neue Erstnennung [67].', 31),
(249, 35, 13, 'definition', 'Allgemeiner Operatorbegriff, Komposition und Spektrum', 'Mathematische Definitionen und Operatoralgebra', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 31),
(250, 36, 13, 'definition', 'Lineare Operatoren, Kern, Bild und Invertierbarkeit', 'Abschnitte zu linearen Operatoren und Operatoralgebra', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 31),
(251, 11, 13, 'background', 'Spektraltheorie und Operatoren auf Funktionenräumen', 'Abschnitt zum Spektrum', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 31);

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
(2, 'M', 'M', 'Menge', 'Allgemeine Menge mathematischer Objekte.', 'global', 9, NULL, NULL, NULL, NULL, 0, 0, 0, 'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.', 'checked', 24),
(3, 'A', 'A', 'Grundmenge oder Matrix', 'Kontextabhängig eine Menge oder Systemmatrix.', 'chapter', 9, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, 'checked', 6),
(4, 'B', 'B', 'Ziel- oder Vergleichsmenge', 'Kontextabhängig eine mathematische Menge.', 'chapter', 9, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(82, 'x', 'x', 'Element', 'Beliebiges mathematisches Objekt beziehungsweise Mengenelement.', 'section', 9, NULL, NULL, NULL, NULL, 0, 0, 0, 'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.', 'checked', 24),
(83, '\\emptyset', '\\emptyset', 'Leere Menge', 'Eindeutig bestimmte Menge ohne Elemente.', 'global', 9, NULL, NULL, NULL, NULL, 0, 0, 0, 'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.', 'checked', 24),
(84, '\\mathcal P(A)', '\\mathcal P(A)', 'Potenzmenge', 'Menge aller Teilmengen von A.', 'section', 9, NULL, NULL, NULL, NULL, 0, 0, 0, 'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.', 'checked', 24),
(85, '\\Omega', '\\Omega', 'Mengenoperation', 'Schematische Operation auf der Potenzmenge einer Grundmenge.', 'section', 9, NULL, NULL, NULL, NULL, 0, 0, 1, 'In Abschnitt 3.2.1 registriert beziehungsweise aktualisiert.', 'checked', 24),
(86, 'R', 'R', 'Relation', 'Binäre Relation zwischen mathematischen Elementen.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(87, 'R^{-1}', 'R^{-1}', 'inverse Relation', 'Relation mit vertauschten Komponenten.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(88, 'operatorname{dom}(R)', 'operatorname{dom}(R)', 'Definitionsbereich', 'Menge aller ersten Komponenten einer Relation.', 'section', 10, NULL, NULL, 'Menge', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(89, 'operatorname{ran}(R)', 'operatorname{ran}(R)', 'Wertebereich', 'Menge aller zweiten Komponenten einer Relation.', 'section', 10, NULL, NULL, 'Menge', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(90, 'preceq', 'preceq', 'Ordnungsrelation', 'Symbol für eine Halb- oder Totalordnung.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(91, 'Scirc R', 'Scirc R', 'Relationskomposition', 'Komposition zweier Relationen.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(92, 'A/R', 'A/R', 'Quotientenmenge', 'Menge der Äquivalenzklassen von A bezüglich R.', 'section', 10, NULL, NULL, 'Menge', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(93, 'f', 'f', 'Funktion', 'Eindeutige Abbildung von A nach B.', 'section', 11, NULL, NULL, 'A', 'B', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(94, 'f^{-1}', 'f^{-1}', 'Umkehrfunktion', 'Inverse Abbildung einer bijektiven Funktion.', 'section', 11, NULL, NULL, 'B', 'A', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(95, 'g\\circ f', 'g\\circ f', 'Funktionskomposition', 'Verkettung zweier kompositionsverträglicher Funktionen.', 'section', 11, NULL, NULL, 'A', 'C', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(96, '\\operatorname{id}_A', '\\operatorname{id}_A', 'Identitätsabbildung', 'Neutrale Abbildung auf A.', 'section', 11, NULL, NULL, 'A', 'A', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(97, 'star', 'star', 'binäre Verknüpfung', 'Abgeschlossene innere binäre Verknüpfung.', 'section', 12, 351, NULL, 'A×A', 'A', 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(98, 'e', 'e', 'neutrales Element', 'Element, das unter der Verknüpfung keine Änderung bewirkt.', 'section', 12, 359, NULL, 'A', 'A', 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(99, 'a^{-1}', 'a^{-1}', 'inverses Element', 'Inverse zu a bezüglich der Gruppenverknüpfung.', 'section', 12, 366, NULL, 'A', 'A', 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(100, 'varphi', 'varphi', 'Homomorphismus', 'Strukturerhaltende Abbildung zwischen algebraischen Strukturen.', 'section', 12, 372, NULL, NULL, NULL, 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(101, 'R', 'R', 'Ring', 'Trägermenge mit additiver und multiplikativer Verknüpfung.', 'section', 12, 374, NULL, 'Ring', NULL, 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(102, 'K', 'K', 'Skalarkörper', 'Körper der Skalare eines Vektorraums.', 'section', 12, 385, NULL, 'Körper', NULL, 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(103, 'V', 'V', 'Vektorraum', 'Vektorraum über dem Körper K.', 'section', 12, 385, NULL, 'Vektorraum', NULL, 1, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(104, 'T', 'T', 'Operator', 'Abbildung zwischen mathematisch strukturierten Räumen.', 'global', 13, 396, NULL, 'X', 'Y', 0, 0, 1, 'Zentrales Operatorsymbol.', 'checked', 31),
(105, '\\mathcal{D}(T)', '\\mathcal{D}(T)', 'Definitionsbereich eines Operators', 'Tatsächlicher Bereich, auf dem T definiert ist.', 'section', 13, 401, NULL, 'Operator T', 'Teilmenge von X', 0, 0, 0, 'Domäne des Operators.', 'checked', 31),
(106, '\\mathcal{R}(T)', '\\mathcal{R}(T)', 'Wertebereich eines Operators', 'Menge aller von T erzeugten Bilder.', 'section', 13, 403, NULL, 'Operator T', 'Teilmenge von Y', 0, 0, 0, 'Range des Operators.', 'checked', 31),
(107, '\\ker(T)', '\\ker(T)', 'Kern eines Operators', 'Menge aller auf Null abgebildeten Elemente.', 'section', 13, 407, NULL, 'linearer Operator T', 'Unterraum von X', 0, 0, 0, 'Nullraum.', 'checked', 31),
(108, '\\operatorname{im}(T)', '\\operatorname{im}(T)', 'Bild eines Operators', 'Menge aller erreichbaren Operatorbilder.', 'section', 13, 408, NULL, 'linearer Operator T', 'Unterraum von Y', 0, 0, 0, 'Bildraum.', 'checked', 31),
(109, 'I_X', 'I_X', 'Identitätsoperator', 'Neutrale Transformation auf X.', 'section', 13, 416, NULL, 'X', 'X', 0, 0, 1, 'Neutrales Element der Komposition.', 'checked', 31),
(110, 'T^{-1}', 'T^{-1}', 'Inverser Operator', 'Umkehrabbildung eines invertierbaren Operators.', 'section', 13, 419, NULL, 'Y', 'X', 0, 0, 1, 'Existiert nur bei Invertierbarkeit.', 'checked', 31),
(111, '\\operatorname{End}(V)', '\\operatorname{End}(V)', 'Endomorphismenmenge', 'Menge aller linearen Endomorphismen von V.', 'section', 13, 421, NULL, 'Vektorraum V', 'Operatorraum', 0, 0, 0, 'Träger der Operatoralgebra.', 'checked', 31),
(112, '\\sigma(T)', '\\sigma(T)', 'Spektrum eines Operators', 'Menge der Werte, für die T minus Lambda I nicht invertierbar ist.', 'section', 13, 424, NULL, 'Operator T', 'Teilmenge von \\mathbb C', 0, 0, 0, 'Spektrale Charakterisierung.', 'checked', 31);

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
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT für Tabelle `axioms`
--
ALTER TABLE `axioms`
  MODIFY `axiom_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT für Tabelle `axiom_dependencies`
--
ALTER TABLE `axiom_dependencies`
  MODIFY `axiom_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=448;

--
-- AUTO_INCREMENT für Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

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
  MODIFY `object_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `proposition_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT für Tabelle `repository_revisions`
--
ALTER TABLE `repository_revisions`
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=257;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

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
