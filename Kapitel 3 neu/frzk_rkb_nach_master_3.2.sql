-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 15. Jul 2026 um 21:01
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
(48, 48, 'Umfassendes Referenzwerk zu komplexen Netzwerken.', 'Referenz für Zentralitäten und Netzwerkanalyse.', 'Belegt Gradzentralität und strukturelle Netzwerkeigenschaften.', 'Zentralität, Gemeinschaften und Netzwerkmodelle.', 'Setzt Knoten und Kanten voraus.', 'Ergänzt Diestel [47] und Barabási [15].', 'reviewed', '2026-07-12 08:10:57'),
(49, 49, 'Standardwerk der metrischen Geometrie.', 'Hauptquelle für Metrikaxiome und Minkowski-Distanzen.', 'Belegt die formale Definition metrischer Räume.', 'Metriken, geodätische Räume und metrische Geometrie.', 'Beschreibt Abstände, nicht deren funktionale Genese.', 'Grundlage für 3.2.11.', 'reviewed', '2026-07-12 08:10:57'),
(50, 50, 'Standardwerk zu Vektorraummodellen und Kosinusähnlichkeit.', 'Referenz für semantische Ähnlichkeitsmaße.', 'Belegt die Verwendung der Kosinusähnlichkeit im Information Retrieval.', 'Vektorraummodell, Kosinusähnlichkeit und Retrieval.', 'Anwendungsbezogene Sekundärquelle.', 'Verbindet Metrik mit semantischen Vektorräumen.', 'reviewed', '2026-07-12 08:10:57'),
(51, 51, 'Systematisiert Selbstorganisation in biologischen Systemen.', 'Hauptreferenz für lokale Interaktionen und globale Ordnungsbildung.', 'Belegt Selbstorganisation ohne zentrale Steuerung.', 'Lokale Regeln, Rückkopplung und Musterbildung.', 'Setzt Agenten und Wechselwirkungsregeln voraus.', 'Ergänzt Haken [12] und Holland [14].', 'reviewed', '2026-07-12 08:10:57'),
(52, 52, 'Überblick über Komplexität, Emergenz und adaptive Systeme.', 'Ergänzende Quelle für den Emergenzbegriff.', 'Belegt das Auftreten globaler Eigenschaften aus lokalen Regeln.', 'Komplexität, Emergenz und Berechnung.', 'Übersichtswerk, keine mathematische Primärquelle.', 'Ergänzt [12], [14] und [51].', 'reviewed', '2026-07-12 08:10:57'),
(101, 70, 'Historische Primärquelle zur Ablösung des Funktionsbegriffs von einer einheitlichen analytischen Formel.', 'Begründet den Übergang zum abstrakten Zuordnungsbegriff in Abschnitt 3.2.3.', 'Belegt die wissenschaftshistorische Erweiterung des Funktionsbegriffs.', 'Eine Funktion wird durch die eindeutige Zuordnung von Argumenten zu Werten bestimmt.', 'Historische Darstellung ohne moderne mengentheoretische Formalisierung.', 'Die formale Präzisierung erfolgt mit Lang [29] und Rudin [30].', 'reviewed', '2026-07-15 19:27:43'),
(102, 81, 'Historische Primärquelle zur gruppentheoretischen Analyse der Lösbarkeit algebraischer Gleichungen.', 'Begründet den historischen Übergang von Rechenverfahren zu abstrakten Symmetriestrukturen.', 'Erstnennung zur Entstehung der Gruppentheorie.', 'Symmetrien der Nullstellen bestimmen die Lösbarkeit durch Radikale.', 'Historische Primärquelle in älterer Terminologie.', 'Wird durch moderne algebraische Standardwerke formal präzisiert.', 'reviewed', '2026-07-15 19:27:44'),
(103, 82, 'Begründet die abstrakte Ideal- und Ringtheorie in axiomatischer Form.', 'Zentrale Quelle für den strukturellen Paradigmenwechsel der Algebra.', 'Belegt die systematische Ablösung algebraischer Aussagen von konkreten Zahlbereichen.', 'Ring- und Idealstrukturen können allgemein axiomatisch untersucht werden.', 'Fokussiert auf Ringbereiche und Idealtheorie.', 'Wird mit van der Waerden [63] systematisch eingeordnet.', 'reviewed', '2026-07-15 19:27:44'),
(104, 83, 'Systematisiert Gruppen, Ringe, Körper und weitere algebraische Strukturen.', 'Formale Hauptreferenz für die Definitionen in Abschnitt 3.2.4.', 'Belegt die axiomatische Strukturhierarchie der abstrakten Algebra.', 'Algebraische Strukturen werden durch Trägermengen, Operationen und Axiome bestimmt.', 'Historisches Standardwerk; moderne Terminologie kann abweichen.', 'Wird durch Mac Lane/Birkhoff [64] ergänzt.', 'reviewed', '2026-07-15 19:27:44'),
(105, 84, 'Stellt Gruppen, Homomorphismen und Isomorphismen in moderner struktureller Form dar.', 'Referenz für Gruppen, Untergruppen und strukturerhaltende Abbildungen.', 'Belegt die strukturelle Gleichwertigkeit isomorpher algebraischer Objekte.', 'Homomorphismen erhalten Verknüpfungsstrukturen.', 'Lehrbuchdarstellung statt Primärquelle.', 'Ergänzt die historischen Primärquellen.', 'reviewed', '2026-07-15 19:27:44'),
(106, 85, 'Beweist den Zusammenhang kontinuierlicher Symmetrien mit Erhaltungssätzen.', 'Belegt die wissenschaftliche Bedeutung von Gruppen als Symmetriemodelle.', 'Primärquelle zur Verbindung von Algebra und theoretischer Physik.', 'Kontinuierliche Symmetrien führen zu Erhaltungsgrößen.', 'Setzt variationsanalytische Voraussetzungen voraus.', 'Dient als Anwendungsbezug der Gruppentheorie.', 'reviewed', '2026-07-15 19:27:44'),
(107, 131, 'Systematische Theorie linearer Integralgleichungen und Integraloperatoren.', 'Historische Grundlage der Operatorentheorie in 3.2.5.', 'Belegt den Übergang von konkreten Integralgleichungen zur Untersuchung von Operatoren auf Funktionenräumen.', 'Operatoren können als eigenständige mathematische Transformationsobjekte behandelt werden.', 'Historische Darstellung vor der vollständigen Banachraumtheorie.', 'Wird durch Banachs allgemeinen funktionalanalytischen Rahmen ergänzt.', 'reviewed', '2026-07-15 19:27:44'),
(108, 132, 'Allgemeine Theorie linearer Operationen auf normierten und vollständigen Räumen.', 'Zentrale Primärquelle für lineare Operatoren, Kern, Bild und Operatoralgebra.', 'Belegt die funktionalanalytische Fundierung der Operatorentheorie.', 'Lineare Operatoren werden durch Raumstruktur, Linearität und Abbildungseigenschaften charakterisiert.', 'Schwerpunkt auf linearer Theorie.', 'Nichtlineare Entwicklungen werden in späteren Abschnitten getrennt behandelt.', 'reviewed', '2026-07-15 19:27:44'),
(109, 133, 'Formalisierung linearer dynamischer Systeme durch Zustandsvektoren und Zustandsraumdarstellungen.', 'Zentrale Primärquelle für den modernen Zustandsraumbegriff in 3.2.6.', 'Belegt die vollständige interne Zustandsbeschreibung als Grundlage weiterer Systementwicklung.', 'Der Zustand enthält die für die weitere Entwicklung relevanten Systeminformationen.', 'Schwerpunkt auf linearen endlichdimensionalen Systemen.', 'Wird durch allgemeine dynamische Systemtheorie und nichtlineare Modelle ergänzt.', 'reviewed', '2026-07-15 19:27:44'),
(110, 134, 'Allgemeine Theorie gewöhnlicher Differentialgleichungen, Flüsse und Trajektorien.', 'Grundlage für die kontinuierliche Zustandsentwicklung in 3.2.6.', 'Belegt die mathematische Beschreibung autonomer und nichtautonomer Dynamik im Zustandsraum.', 'Kontinuierliche Systementwicklung kann durch Anfangswertprobleme und Flüsse dargestellt werden.', 'Behandelt primär gewöhnliche Differentialgleichungen.', 'Unendlichdimensionale und stochastische Entwicklungen werden später gesondert betrachtet.', 'reviewed', '2026-07-15 19:27:44'),
(111, 138, 'Systematische Klassifikation lokaler Bifurkationen und ihrer Normalformen.', 'Zentrale Referenz für Definitionen, kritische Parameterwerte und lokale Bifurkationstypen in 3.2.8.', 'Belegt die mathematische Struktur von Sattel-Knoten-, transkritischer, Pitchfork- und Hopf-Bifurkation.', 'Bifurkationen beschreiben qualitative Strukturänderungen parameterabhängiger Dynamik.', 'Schwerpunkt auf etablierter lokaler Bifurkationstheorie.', 'Die Quelle wird mit globalen nichtlinearen Perspektiven aus [74] ergänzt.', 'reviewed', '2026-07-15 19:27:45'),
(112, 139, 'Verbindung nichtlinearer Schwingungen, lokaler Bifurkationen und globaler dynamischer Strukturen.', 'Ergänzende Standardreferenz für Nichtlinearität, Linearisierung und Hopf-Dynamik.', 'Belegt die Rolle nichtlinearer Terme und lokaler Normalformen für qualitative Dynamikwechsel.', 'Nichtlinearität ermöglicht qualitative Strukturübergänge, die in linearen Systemen nicht auftreten.', 'Konzentriert sich auf klassische glatte dynamische Systeme.', 'Die emergenztheoretische Interpretation bleibt eine wissenschaftliche Einordnung des Abschnitts.', 'reviewed', '2026-07-15 19:27:45'),
(113, 140, 'Mathematische Quantifizierung von Selbstinformation, Entropie, bedingter Entropie und Informationsübertragung.', 'Zentrale Primärquelle für sämtliche informationstheoretischen Definitionen in Abschnitt 3.2.9.', 'Belegt die probabilistische Definition von Information unabhängig von Semantik.', 'Information wird als Verringerung probabilistischer Unbestimmtheit quantifiziert.', 'Die semantische Bedeutung von Nachrichten wird bewusst ausgeklammert.', 'Diese Begrenzung ist für die spätere FRZK-Forschungslücke ausdrücklich relevant.', 'reviewed', '2026-07-15 19:27:45'),
(114, 141, 'Verknüpfung von Information, Kommunikation, Steuerung und Rückkopplung.', 'Erweitert die rein probabilistische Perspektive um die funktionale Rolle von Information in dynamischen Systemen.', 'Belegt die Bedeutung von Information innerhalb regulierter Prozesse.', 'Information ist für Steuerung und Rückkopplung funktional wirksam.', 'Keine allgemeine mathematische Genese semantischer oder funktionaler Raum-Zeit-Strukturen.', 'Wieners funktionale Perspektive ergänzt Shannons quantitative Theorie.', 'reviewed', '2026-07-15 19:27:45'),
(115, 142, 'Einführung einer rein relationalen Problembeschreibung unabhängig von geometrischen Längen und Winkeln.', 'Historischer Ausgangspunkt der Graphentheorie in Abschnitt 3.2.10.', 'Belegt die Entstehung eines strukturellen, nichtmetrischen Zugangs zu Verbindungsproblemen.', 'Die relationale Struktur kann unabhängig von geometrischer Einbettung untersucht werden.', 'Die Arbeit enthält noch keine moderne abstrakte Graphentheorie.', 'Wird durch Diestels moderne Darstellung ergänzt.', 'reviewed', '2026-07-15 19:27:46'),
(116, 143, 'Systematische moderne Darstellung von Graphen, Wegen, Zusammenhang, Matrizen und gewichteten Strukturen.', 'Zentrale Referenz für alle mathematischen Definitionen von Abschnitt 3.2.10.', 'Belegt die formale Graphstruktur und ihre elementaren Eigenschaften.', 'Graphen modellieren relationale Systeme unabhängig von der konkreten Bedeutung ihrer Knoten und Kanten.', 'Funktionale Genese und semantische Bedeutung der Relationen sind nicht Gegenstand der Theorie.', 'Diese Grenze wird als Übergang zur FRZK-Forschungslücke verwendet.', 'reviewed', '2026-07-15 19:27:46'),
(117, 144, 'Einführung des Small-World-Modells mit hoher Clusterung und kurzen Wegen.', 'Zentrale Primärquelle für Gleichung (3.273) und die globale Netzwerkeinordnung.', 'Belegt die Kombination lokaler Clusterung mit global effizienter Erreichbarkeit.', 'Reale Netzwerke können zugleich stark geclustert und global kurzwegig sein.', 'Das Modell erklärt nicht die funktionale Genese konkreter Relationen.', 'Wird als Beispiel emergenter globaler Organisation aus lokalen Verknüpfungen verwendet.', 'reviewed', '2026-07-15 19:27:46'),
(118, 145, 'Einführung skalenfreier Netzwerke durch Wachstum und bevorzugte Anlagerung.', 'Zentrale Primärquelle für Gleichung (3.274) und die Hub-Struktur.', 'Belegt potenzgesetzartige Gradverteilungen in wachsenden Netzwerken.', 'Wenige Hubs und viele schwach vernetzte Knoten können aus lokaler Wachstumsdynamik entstehen.', 'Das ursprüngliche Modell bildet nicht alle realen Netzwerkmechanismen ab.', 'Dient als Beispiel für makroskopische Strukturentstehung aus lokalen Regeln.', 'reviewed', '2026-07-15 19:27:46'),
(119, 146, 'Systematische Klärung verschiedener Zentralitätskonzepte.', 'Primärquelle für Grad-, Closeness- und Betweenness-Zentralität.', 'Belegt die unterschiedlichen mathematischen Bedeutungen struktureller Zentralität.', 'Zentralität ist mehrdimensional und hängt vom gewählten Strukturkriterium ab.', 'Eigenvektor-Zentralität wird in späteren Arbeiten vertieft.', 'Ergänzt die modernen Netzwerkmodelle durch klassische Zentralitätsmaße.', 'reviewed', '2026-07-15 19:27:46');

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
(15, 'Barabási', 'Albert-László', 'Barabási, Albert-László', NULL, NULL, NULL, 'Mitbegründer der Theorie skalenfreier Netzwerke.'),
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
(73, 'Banach', 'Stefan', 'Banach, Stefan', NULL, 1892, 1945, 'Primärquelle zur linearen Funktionalanalysis und Operatorentheorie.'),
(87, 'Kalman', 'Rudolf E.', 'Kalman, Rudolf E.', NULL, 1930, 2016, 'Grundlegende Quelle zur modernen Zustandsraumdarstellung linearer dynamischer Systeme.'),
(88, 'Lyapunov', 'Aleksandr M.', 'Lyapunov, Aleksandr M.', NULL, 1857, 1918, 'Begründer der modernen Stabilitätstheorie.'),
(89, 'LaSalle', 'Joseph P.', 'LaSalle, Joseph P.', NULL, 1916, 1983, 'Entwickler des LaSalle-Invarianzprinzips.'),
(90, 'Ruelle', 'David', 'Ruelle, David', NULL, 1935, NULL, 'Mitbegründer der modernen Theorie seltsamer Attraktoren.'),
(91, 'Takens', 'Floris', 'Takens, Floris', NULL, 1940, 2010, 'Mitautor der grundlegenden Arbeit zur Turbulenz und seltsamen Attraktoren.'),
(92, 'Kuznetsov', 'Yuri A.', 'Kuznetsov, Yuri A.', NULL, 1959, NULL, 'Standardreferenz der angewandten Bifurkationstheorie.'),
(93, 'Guckenheimer', 'John', 'Guckenheimer, John', NULL, 1945, NULL, 'Grundlegende Arbeiten zu nichtlinearen dynamischen Systemen und Bifurkationen.'),
(94, 'Holmes', 'Philip', 'Holmes, Philip', NULL, 1945, NULL, 'Grundlegende Arbeiten zu nichtlinearen Schwingungen, Dynamik und Bifurkationen.'),
(95, 'Shannon', 'Claude E.', 'Shannon, Claude E.', NULL, 1916, 2001, 'Begründer der mathematischen Informationstheorie.'),
(96, 'Wiener', 'Norbert', 'Wiener, Norbert', NULL, 1894, 1964, 'Begründer der Kybernetik und der informationsbezogenen Rückkopplungstheorie.'),
(105, 'Watts', 'Duncan J.', 'Watts, Duncan J.', NULL, 1971, NULL, 'Mitentwickler des Small-World-Netzwerkmodells.'),
(106, 'Strogatz', 'Steven H.', 'Strogatz, Steven H.', NULL, 1959, NULL, 'Mitentwickler des Small-World-Netzwerkmodells.'),
(107, 'Albert', 'Réka', 'Albert, Réka', NULL, 1972, NULL, 'Mitentwicklerin des Preferential-Attachment-Modells.'),
(109, 'Euler', 'Leonhard', 'Euler, Leonhard', NULL, 1707, 1783, 'Begründer der Graphentheorie durch das Königsberger Brückenproblem.'),
(110, 'Diestel', 'Reinhard', 'Diestel, Reinhard', NULL, 1959, NULL, 'Autor eines internationalen Standardwerks der modernen Graphentheorie.'),
(115, 'Freeman', 'Linton C.', 'Freeman, Linton C.', NULL, 1927, 2018, 'Grundlegende Arbeiten zur Konzeptualisierung von Zentralitätsmaßen.');

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
(288, 'Def. 3.2.1.1', 9, 'Menge', 'Eine Menge ist im axiomatischen Rahmen ein primitiver mathematischer Gegenstand, dessen Bedeutung durch die Elementrelation und die Axiome der Mengenlehre bestimmt wird.', NULL, NULL, 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(289, 'Def. 3.2.1.2', 9, 'Elementzugehörigkeit', 'Die Aussage x∈M bezeichnet die Zugehörigkeit des Objekts x zur Menge M.', 'x\\in M', 'x\\in M', 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(290, 'Def. 3.2.1.3', 9, 'Leere Menge', 'Die leere Menge ist die eindeutig bestimmte Menge, die kein Element enthält.', '\\emptyset', '\\emptyset', 'literature', 24, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(291, 'Def. 3.2.1.4', 9, 'Teilmenge', 'A ist Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'literature', 24, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(292, 'Def. 3.2.1.5', 9, 'Kartesisches Produkt', 'Das kartesische Produkt A×B ist die Menge aller geordneten Paare (a,b) mit a∈A und b∈B.', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(293, 'Def. 3.2.1.6', 9, 'Potenzmenge', 'Die Potenzmenge P(A) ist die Menge aller Teilmengen von A.', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', 'literature', 23, 'Die verwendeten Begriffe werden im Rahmen der axiomatischen Mengenlehre interpretiert.', 'Definition für den Forschungsstandsabschnitt 3.2.1.', 'checked', 24),
(294, 'Def. 3.2.2.1', 10, 'Geordnetes Paar', 'Ein geordnetes Paar ist ein Paar mathematischer Objekte, bei dem die Reihenfolge der Komponenten wesentlich ist.', '(a,b)', '(a,b)', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(295, 'Def. 3.2.2.2', 10, 'Binäre Relation', 'Eine binäre Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts A	imes B.', 'Rsubseteq A	imes B', 'Rsubseteq A	imes B', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(296, 'Def. 3.2.2.3', 10, 'Inverse Relation', 'Die inverse Relation entsteht durch Vertauschung der Komponenten aller Paare einer Relation.', 'R^{-1}={(b,a)mid(a,b)in R}', 'R^{-1}={(b,a)mid(a,b)in R}', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(297, 'Def. 3.2.2.4', 10, 'Äquivalenzrelation', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', NULL, NULL, 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(298, 'Def. 3.2.2.5', 10, 'Äquivalenzklasse', 'Die Äquivalenzklasse eines Elements enthält alle Elemente, die bezüglich der Relation zu ihm äquivalent sind.', '[a]_R={xin Amid xRa}', '[a]_R={xin Amid xRa}', 'literature', 27, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(299, 'Def. 3.2.2.6', 10, 'Halbordnung', 'Eine Halbordnung ist reflexiv, antisymmetrisch und transitiv.', NULL, NULL, 'literature', 28, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(300, 'Def. 3.2.2.7', 10, 'Totalordnung', 'Eine Totalordnung ist eine Halbordnung, in der je zwei Elemente vergleichbar sind.', NULL, NULL, 'literature', 28, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(301, 'Def. 3.2.2.8', 10, 'Relationskomposition', 'Die Komposition zweier Relationen beschreibt mittelbare Beziehungen über ein Zwischenelement.', 'Scirc R={(a,c)midexists b:aRbland bSc}', 'Scirc R={(a,c)midexists b:aRbland bSc}', 'literature', 69, NULL, 'Neufassung 3.2.2 V2.', 'checked', 25),
(302, 'Def. 3.2.3.1', 11, 'Funktion', 'Eine Funktion von A nach B ist eine Relation, die jedem Element von A genau ein Element von B zuordnet.', 'f:A\\longrightarrow B', 'f:A\\longrightarrow B', 'literature', 29, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(303, 'Def. 3.2.3.2', 11, 'Bildmenge', 'Die Bildmenge enthält alle Werte, die durch die Funktion tatsächlich erreicht werden.', 'f(A)=\\{f(x)\\mid x\\in A\\}', 'f(A)=\\{f(x)\\mid x\\in A\\}', 'literature', 29, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(304, 'Def. 3.2.3.3', 11, 'Urbild', 'Das Urbild einer Teilmenge N enthält alle Elemente des Definitionsbereichs, deren Bilder in N liegen.', 'f^{-1}(N)=\\{x\\in A\\mid f(x)\\in N\\}', 'f^{-1}(N)=\\{x\\in A\\mid f(x)\\in N\\}', 'literature', 29, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(305, 'Def. 3.2.3.4', 11, 'Injektive Funktion', 'Eine Funktion ist injektiv, wenn verschiedene Ausgangselemente verschiedene Bilder besitzen.', NULL, NULL, 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(306, 'Def. 3.2.3.5', 11, 'Surjektive Funktion', 'Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.', NULL, NULL, 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(307, 'Def. 3.2.3.6', 11, 'Bijektive Funktion', 'Eine Funktion ist bijektiv, wenn sie injektiv und surjektiv ist.', NULL, NULL, 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(308, 'Def. 3.2.3.7', 11, 'Umkehrfunktion', 'Die Umkehrfunktion einer bijektiven Funktion ordnet jedem Zielwert sein eindeutiges Urbild zu.', 'f^{-1}:B\\longrightarrow A', 'f^{-1}:B\\longrightarrow A', 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(309, 'Def. 3.2.3.8', 11, 'Funktionskomposition', 'Die Komposition zweier Funktionen wendet die zweite Abbildung auf das Ergebnis der ersten an.', '(g\\circ f)(x)=g(f(x))', '(g\\circ f)(x)=g(f(x))', 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(310, 'Def. 3.2.3.9', 11, 'Identitätsabbildung', 'Die Identitätsabbildung auf A ordnet jedem Element sich selbst zu.', '\\operatorname{id}_A(x)=x', '\\operatorname{id}_A(x)=x', 'literature', 30, NULL, 'Neufassung 3.2.3 V2.', 'checked', 26),
(311, 'Def. 3.2.4.1', 12, 'Innere binäre Verknüpfung', 'Eine innere binäre Verknüpfung auf A ordnet jedem Paar aus A×A eindeutig ein Element aus A zu.', 'star:A	imes Alongrightarrow A', 'star:A	imes Alongrightarrow A', 'literature', 83, NULL, NULL, 'checked', 29),
(312, 'Def. 3.2.4.2', 12, 'Magma', 'Ein Magma ist eine nichtleere Menge mit einer abgeschlossenen inneren binären Verknüpfung.', 'left(A,star\right)', 'left(A,star\right)', 'literature', 83, NULL, NULL, 'checked', 29),
(313, 'Def. 3.2.4.3', 12, 'Halbgruppe', 'Eine Halbgruppe ist ein Magma mit assoziativer Verknüpfung.', 'left(A,star\right)', 'left(A,star\right)', 'literature', 83, NULL, NULL, 'checked', 29),
(314, 'Def. 3.2.4.4', 12, 'Neutrales Element', 'Ein neutrales Element lässt jedes Element bei links- und rechtsseitiger Verknüpfung unverändert.', 'estar a=astar e=a', 'estar a=astar e=a', 'literature', 83, NULL, NULL, 'checked', 29),
(315, 'Def. 3.2.4.5', 12, 'Monoid', 'Ein Monoid ist eine Halbgruppe mit neutralem Element.', 'left(A,star,e\right)', 'left(A,star,e\right)', 'literature', 83, NULL, NULL, 'checked', 29),
(316, 'Def. 3.2.4.6', 12, 'Gruppe', 'Eine Gruppe ist ein Monoid, in dem jedes Element ein inverses Element besitzt.', 'left(A,star\right)', 'left(A,star\right)', 'literature', 84, NULL, NULL, 'checked', 29),
(317, 'Def. 3.2.4.7', 12, 'Abelsche Gruppe', 'Eine abelsche Gruppe ist eine Gruppe mit kommutativer Verknüpfung.', 'astar b=bstar a', 'astar b=bstar a', 'literature', 84, NULL, NULL, 'checked', 29),
(318, 'Def. 3.2.4.8', 12, 'Untergruppe', 'Eine Untergruppe ist eine Teilmenge einer Gruppe, die bezüglich derselben Verknüpfung selbst eine Gruppe bildet.', 'Hsubseteq G', 'Hsubseteq G', 'literature', 84, NULL, NULL, 'checked', 29),
(319, 'Def. 3.2.4.9', 12, 'Homomorphismus', 'Ein Homomorphismus ist eine Abbildung, die die algebraische Verknüpfung erhält.', 'varphi(astar b)=varphi(a)circvarphi(b)', 'varphi(astar b)=varphi(a)circvarphi(b)', 'literature', 84, NULL, NULL, 'checked', 29),
(320, 'Def. 3.2.4.10', 12, 'Isomorphismus', 'Ein Isomorphismus ist ein bijektiver Homomorphismus.', 'Gcong H', 'Gcong H', 'literature', 84, NULL, NULL, 'checked', 29),
(321, 'Def. 3.2.4.11', 12, 'Ring', 'Ein Ring ist eine Menge mit additiver abelscher Gruppenstruktur und einer assoziativen Multiplikation, die distributiv miteinander verknüpft sind.', 'left(R,+,cdot\right)', 'left(R,+,cdot\right)', 'literature', 82, NULL, NULL, 'checked', 29),
(322, 'Def. 3.2.4.12', 12, 'Körper', 'Ein Körper ist ein kommutativer Ring mit Eins, in dem jedes von null verschiedene Element multiplikativ invertierbar ist.', NULL, NULL, 'literature', 83, NULL, NULL, 'checked', 29),
(323, 'Def. 3.2.4.13', 12, 'Vektorraum', 'Ein Vektorraum über K ist eine abelsche Gruppe mit kompatibler Skalarmultiplikation.', 'K	imes Vlongrightarrow V', 'K	imes Vlongrightarrow V', 'literature', 83, NULL, NULL, 'checked', 29),
(324, 'Def. 3.2.5.1', 13, 'Operator', 'Ein Operator ist eine Abbildung zwischen mathematisch strukturierten Räumen.', 'T:X\\longrightarrow Y', 'T:X\\longrightarrow Y', 'literature', 35, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(325, 'Def. 3.2.5.2', 13, 'Endomorpher Operator', 'Ein Operator auf X bildet den Raum X in sich selbst ab.', 'T:X\\longrightarrow X', 'T:X\\longrightarrow X', 'literature', 35, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(326, 'Def. 3.2.5.3', 13, 'Definitionsbereich eines Operators', 'Der Definitionsbereich enthält alle Elemente, auf denen der Operator tatsächlich definiert ist.', '\\mathcal{D}(T)\\subseteq X', '\\mathcal{D}(T)\\subseteq X', 'literature', 36, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(327, 'Def. 3.2.5.4', 13, 'Wertebereich eines Operators', 'Der Wertebereich enthält alle durch den Operator tatsächlich erzeugten Bilder.', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}', 'literature', 36, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(328, 'Def. 3.2.5.5', 13, 'Linearer Operator', 'Ein Operator ist linear, wenn er Addition und Skalarmultiplikation erhält.', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'literature', 132, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(329, 'Def. 3.2.5.6', 13, 'Kern eines linearen Operators', 'Der Kern enthält alle Elemente, die auf den Nullvektor abgebildet werden.', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', 'literature', 132, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(330, 'Def. 3.2.5.7', 13, 'Bild eines linearen Operators', 'Das Bild enthält alle durch den Operator erreichbaren Elemente des Zielraums.', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', 'literature', 132, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(331, 'Def. 3.2.5.8', 13, 'Invertierbarer Operator', 'Ein Operator ist invertierbar, wenn eine beidseitige Umkehrabbildung existiert.', 'T^{-1}\\circ T=I_X,\\quad T\\circ T^{-1}=I_Y', 'T^{-1}\\circ T=I_X,\\quad T\\circ T^{-1}=I_Y', 'literature', 35, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(332, 'Def. 3.2.5.9', 13, 'Endomorphismenring', 'Die Menge aller linearen Endomorphismen eines Vektorraums bildet unter Addition und Komposition eine Operatoralgebra.', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', 'literature', 36, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(333, 'Def. 3.2.5.10', 13, 'Spektrum eines Operators', 'Das Spektrum besteht aus allen komplexen Zahlen, für die T minus Lambda mal I nicht invertierbar ist.', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', 'literature', 11, NULL, 'Stand der Forschung; keine FRZK-Eigenleistung.', 'checked', 31),
(334, 'Def. 3.2.6.1', 14, 'Zustand', 'Ein Zustand eines Systems ist ein Element des Zustandsraumes und enthält die für die weitere Modellentwicklung relevanten Angaben.', 'x\\in X', 'x\\in X', 'literature', 133, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(335, 'Def. 3.2.6.2', 14, 'Zustandsraum', 'Der Zustandsraum ist die Menge aller im Modell zulässigen Zustände eines Systems.', 'X', 'X', 'literature', 133, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(336, 'Def. 3.2.6.3', 14, 'Vollständige Zustandsbeschreibung', 'Eine Zustandsbeschreibung ist vollständig, wenn der aktuelle Zustand zusammen mit der Übergangsregel die weitere Entwicklung bestimmt.', 'x_{k+1}=F(x_k)', 'x_{k+1}=F(x_k)', 'literature', 133, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(337, 'Def. 3.2.6.4', 14, 'Zulässiger Zustandsraum', 'Der zulässige Zustandsraum ist die Teilmenge aller Zustände, welche die Modellnebenbedingungen erfüllen.', 'X_{\\mathrm{zul}}\\subseteq X', 'X_{\\mathrm{zul}}\\subseteq X', 'literature', 38, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(338, 'Def. 3.2.6.5', 14, 'Diskrete Zustandsentwicklung', 'Eine diskrete Zustandsentwicklung ist eine durch Iteration einer Übergangsabbildung erzeugte Zustandsfolge.', 'x_{k+1}=F(x_k)', 'x_{k+1}=F(x_k)', 'literature', 40, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(339, 'Def. 3.2.6.6', 14, 'Zeitabhängige Zustandsfunktion', 'Eine zeitabhängige Zustandsfunktion ordnet jedem Zeitpunkt eines Intervalls genau einen Zustand zu.', 'x:I\\longrightarrow X', 'x:I\\longrightarrow X', 'literature', 134, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(340, 'Def. 3.2.6.7', 14, 'Fluss', 'Ein Fluss ist eine zeitparametrisierte Familie von Zustandsabbildungen mit Identitäts- und Kompositionseigenschaft.', '\\Phi:\\mathbb{R}\\times X\\longrightarrow X', '\\Phi:\\mathbb{R}\\times X\\longrightarrow X', 'literature', 134, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(341, 'Def. 3.2.6.8', 14, 'Trajektorie', 'Eine Trajektorie ist die Menge aller Zustände, die aus einem Anfangszustand entlang eines Flusses erreicht werden.', '\\gamma(x_0)=\\{\\Phi(t,x_0)\\mid t\\in I\\}', '\\gamma(x_0)=\\{\\Phi(t,x_0)\\mid t\\in I\\}', 'literature', 40, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(342, 'Def. 3.2.6.9', 14, 'Gleichgewichtspunkt', 'Ein Gleichgewichtspunkt ist ein Zustand, dessen zeitliche Entwicklung unverändert bleibt.', 'F(x^\\ast)=0', 'F(x^\\ast)=0', 'literature', 39, NULL, 'Neufassung 3.2.6 V2.', 'checked', 38),
(343, 'Def. 3.2.7.1', 15, 'Positiv invariante Menge', 'Eine Teilmenge ist positiv invariant, wenn jede in ihr beginnende Trajektorie für alle zukünftigen Zeiten in ihr verbleibt.', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\geq0', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\geq0', 'literature', 136, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(344, 'Def. 3.2.7.2', 15, 'Invariante Menge', 'Eine Teilmenge ist invariant, wenn sie unter der gesamten definierten Dynamik erhalten bleibt.', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\in\\mathbb{R}', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\in\\mathbb{R}', 'literature', 136, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(345, 'Def. 3.2.7.3', 15, 'Lyapunov-Stabilität', 'Ein Gleichgewichtspunkt ist stabil, wenn hinreichend kleine Anfangsabweichungen dauerhaft klein bleiben.', '\\forall\\varepsilon>0\\;\\exists\\delta>0:\\left\\|x_0-x^\\ast\\right\\|<\\delta\\Longrightarrow\\left\\|\\Phi(t,x_0)-x^\\ast\\right\\|<\\varepsilon\\quad\\forall t\\geq0', '\\forall\\varepsilon>0\\;\\exists\\delta>0:\\left\\|x_0-x^\\ast\\right\\|<\\delta\\Longrightarrow\\left\\|\\Phi(t,x_0)-x^\\ast\\right\\|<\\varepsilon\\quad\\forall t\\geq0', 'literature', 135, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(346, 'Def. 3.2.7.4', 15, 'Attraktivität', 'Ein Gleichgewichtspunkt ist attraktiv, wenn benachbarte Trajektorien langfristig gegen ihn konvergieren.', '\\exists r>0:\\left\\|x_0-x^\\ast\\right\\|<r\\Longrightarrow\\lim_{t\\rightarrow\\infty}\\Phi(t,x_0)=x^\\ast', '\\exists r>0:\\left\\|x_0-x^\\ast\\right\\|<r\\Longrightarrow\\lim_{t\\rightarrow\\infty}\\Phi(t,x_0)=x^\\ast', 'literature', 135, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(347, 'Def. 3.2.7.5', 15, 'Asymptotische Stabilität', 'Asymptotische Stabilität verbindet Stabilität und Attraktivität.', 'x^\\ast\\text{ ist asymptotisch stabil}\\Longleftrightarrow x^\\ast\\text{ ist stabil und attraktiv}', 'x^\\ast\\text{ ist asymptotisch stabil}\\Longleftrightarrow x^\\ast\\text{ ist stabil und attraktiv}', 'literature', 135, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(348, 'Def. 3.2.7.6', 15, 'Lyapunov-Funktion', 'Eine Lyapunov-Funktion ist eine skalare Funktion, die am Gleichgewicht verschwindet und entlang der Dynamik nicht zunimmt.', 'V:X\\longrightarrow\\mathbb{R}', 'V:X\\longrightarrow\\mathbb{R}', 'literature', 135, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(349, 'Def. 3.2.7.7', 15, 'Attraktor', 'Ein Attraktor ist eine kompakte invariante Menge, die ein Einzugsgebiet anzieht und bezüglich dieser Eigenschaften minimal ist.', '\\Phi(t,A)=A\\qquad\\forall t\\geq0', '\\Phi(t,A)=A\\qquad\\forall t\\geq0', 'literature', 137, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(350, 'Def. 3.2.7.8', 15, 'Einzugsgebiet', 'Das Einzugsgebiet eines Attraktors enthält alle Anfangszustände, deren Trajektorien sich dem Attraktor annähern.', 'B(A)=\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi(t,x_0),A)\\rightarrow0\\}', 'B(A)=\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi(t,x_0),A)\\rightarrow0\\}', 'literature', 137, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(351, 'Def. 3.2.7.9', 15, 'Punktattraktor', 'Ein Punktattraktor besteht aus einem asymptotisch stabilen Gleichgewichtspunkt.', 'A=\\{x^\\ast\\}', 'A=\\{x^\\ast\\}', 'literature', 137, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(352, 'Def. 3.2.7.10', 15, 'Periodischer Attraktor', 'Ein periodischer Attraktor ist eine geschlossene, anziehende periodische Bahn.', 'x(t+T)=x(t)', 'x(t+T)=x(t)', 'literature', 40, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(353, 'Def. 3.2.7.11', 15, 'Omega-Grenzmenge', 'Die Omega-Grenzmenge enthält alle Häufungspunkte einer Trajektorie für gegen unendlich strebende Zeiten.', '\\omega(x_0)=\\{y\\in X\\mid\\exists t_n\\rightarrow\\infty:\\Phi(t_n,x_0)\\rightarrow y\\}', '\\omega(x_0)=\\{y\\in X\\mid\\exists t_n\\rightarrow\\infty:\\Phi(t_n,x_0)\\rightarrow y\\}', 'literature', 40, NULL, 'Neufassung 3.2.7 V2.', 'checked', 39),
(354, 'Def. 3.2.8.1', 16, 'Nichtlineares dynamisches System', 'Ein dynamisches System ist nichtlinear, wenn sein Entwicklungsgesetz das Superpositionsprinzip nicht erfüllt.', 'F(\\alpha x_1+\\beta x_2,\\mu)\\neq\\alpha F(x_1,\\mu)+\\beta F(x_2,\\mu)', 'F(\\alpha x_1+\\beta x_2,\\mu)\\neq\\alpha F(x_1,\\mu)+\\beta F(x_2,\\mu)', 'literature', 139, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(355, 'Def. 3.2.8.2', 16, 'Kontrollparameter', 'Ein Kontrollparameter ist eine äußere oder innere Modellgröße, deren Variation die qualitative Dynamik verändern kann.', '\\mu\\in\\mathbb{R}^p', '\\mu\\in\\mathbb{R}^p', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(356, 'Def. 3.2.8.3', 16, 'Linearisierung', 'Die Linearisierung ist die Approximation eines nichtlinearen Systems durch die erste Ableitung seines Vektorfeldes in der Umgebung eines Gleichgewichtspunktes.', '\\dot{\\xi}=J(x^\\ast,\\mu)\\xi', '\\dot{\\xi}=J(x^\\ast,\\mu)\\xi', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(357, 'Def. 3.2.8.4', 16, 'Jacobi-Matrix', 'Die Jacobi-Matrix ist die Ableitung des Vektorfeldes bezüglich der Zustandsvariablen.', 'J(x^\\ast,\\mu)=D_xF(x^\\ast,\\mu)', 'J(x^\\ast,\\mu)=D_xF(x^\\ast,\\mu)', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(358, 'Def. 3.2.8.5', 16, 'Kritischer Parameterwert', 'Ein Parameterwert ist kritisch, wenn mindestens ein Eigenwert der linearisierten Dynamik einen verschwindenden Realteil besitzt.', '\\exists i:\\operatorname{Re}(\\lambda_i(\\mu_c))=0', '\\exists i:\\operatorname{Re}(\\lambda_i(\\mu_c))=0', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(359, 'Def. 3.2.8.6', 16, 'Bifurkation', 'Eine Bifurkation ist eine qualitative Änderung der Dynamik bei Variation eines Parameters, sodass die Systeme beiderseits des kritischen Wertes nicht topologisch äquivalent sind.', '\\Phi_{\\mu_c-\\varepsilon}\\not\\sim\\Phi_{\\mu_c+\\varepsilon}', '\\Phi_{\\mu_c-\\varepsilon}\\not\\sim\\Phi_{\\mu_c+\\varepsilon}', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(360, 'Def. 3.2.8.7', 16, 'Sattel-Knoten-Bifurkation', 'Eine Sattel-Knoten-Bifurkation erzeugt oder vernichtet lokal zwei Gleichgewichtspunkte.', '\\dot{x}=\\mu-x^2', '\\dot{x}=\\mu-x^2', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(361, 'Def. 3.2.8.8', 16, 'Transkritische Bifurkation', 'Bei einer transkritischen Bifurkation tauschen zwei Gleichgewichtszweige ihre Stabilität.', '\\dot{x}=\\mu x-x^2', '\\dot{x}=\\mu x-x^2', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(362, 'Def. 3.2.8.9', 16, 'Pitchfork-Bifurkation', 'Eine Pitchfork-Bifurkation beschreibt die symmetrische Aufspaltung eines Gleichgewichtszweiges.', '\\dot{x}=\\mu x-x^3', '\\dot{x}=\\mu x-x^3', 'literature', 138, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(363, 'Def. 3.2.8.10', 16, 'Hopf-Bifurkation', 'Eine Hopf-Bifurkation ist ein Übergang von einem Gleichgewicht zu einer periodischen Lösung durch ein komplex konjugiertes Eigenwertpaar.', '\\dot{z}=(\\mu+i\\omega)z-|z|^2z', '\\dot{z}=(\\mu+i\\omega)z-|z|^2z', 'literature', 139, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(364, 'Def. 3.2.8.11', 16, 'Emergenter Strukturwechsel', 'Ein emergenter Strukturwechsel liegt vor, wenn durch eine Parameteränderung eine qualitativ neue asymptotische Organisationsform entsteht.', 'A(\\mu^-)\\neq A(\\mu^+)', 'A(\\mu^-)\\neq A(\\mu^+)', 'literature', 137, NULL, 'Neufassung 3.2.8 V2.', 'checked', 40),
(365, 'Def. 3.2.9.1', 17, 'Diskrete Zufallsvariable', 'Eine diskrete Zufallsvariable ordnet elementaren Ergebnissen Werte aus einem endlichen oder abzählbaren Alphabet zu.', 'X:\\Omega\\to\\mathcal X', 'X:\\Omega\\to\\mathcal X', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(366, 'Def. 3.2.9.2', 17, 'Selbstinformation', 'Die Selbstinformation eines Ereignisses ist der negative Logarithmus seiner Wahrscheinlichkeit.', 'I(x_i)=-\\log_b p_i', 'I(x_i)=-\\log_b p_i', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(367, 'Def. 3.2.9.3', 17, 'Shannon-Entropie', 'Die Shannon-Entropie ist der Erwartungswert der Selbstinformation einer Zufallsvariablen.', 'H(X)=-\\sum_i p_i\\log_b p_i', 'H(X)=-\\sum_i p_i\\log_b p_i', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(368, 'Def. 3.2.9.4', 17, 'Gemeinsame Entropie', 'Die gemeinsame Entropie quantifiziert die gesamte Unbestimmtheit zweier Zufallsvariablen.', 'H(X,Y)=-\\sum_i\\sum_jp(x_i,y_j)\\log p(x_i,y_j)', 'H(X,Y)=-\\sum_i\\sum_jp(x_i,y_j)\\log p(x_i,y_j)', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(369, 'Def. 3.2.9.5', 17, 'Bedingte Entropie', 'Die bedingte Entropie misst die verbleibende Unsicherheit einer Variablen bei Kenntnis einer anderen.', 'H(X|Y)', 'H(X|Y)', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(370, 'Def. 3.2.9.6', 17, 'Gegenseitige Information', 'Die gegenseitige Information misst die Reduktion der Unsicherheit einer Variablen durch Kenntnis einer anderen.', 'I(X;Y)=H(X)-H(X|Y)', 'I(X;Y)=H(X)-H(X|Y)', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(371, 'Def. 3.2.9.7', 17, 'Kullback-Leibler-Divergenz', 'Die Kullback-Leibler-Divergenz quantifiziert den gerichteten Informationsverlust bei Approximation einer Verteilung P durch Q.', 'D_{KL}(P||Q)=\\sum_iP(x_i)\\log\\frac{P(x_i)}{Q(x_i)}', 'D_{KL}(P||Q)=\\sum_iP(x_i)\\log\\frac{P(x_i)}{Q(x_i)}', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(372, 'Def. 3.2.9.8', 17, 'Jensen-Shannon-Divergenz', 'Die Jensen-Shannon-Divergenz ist eine symmetrische Divergenz auf Grundlage zweier Kullback-Leibler-Divergenzen zur Mischverteilung.', 'D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)', 'D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(373, 'Def. 3.2.9.9', 17, 'Informationsabhängigkeit', 'Informationsabhängigkeit liegt vor, wenn die gegenseitige Information zweier Variablen positiv ist.', 'I(X;Y)>0', 'I(X;Y)>0', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(374, 'Def. 3.2.9.10', 17, 'Informationsunabhängigkeit', 'Zwei Zufallsvariablen sind informationsunabhängig, wenn ihre gegenseitige Information verschwindet.', 'I(X;Y)=0', 'I(X;Y)=0', 'literature', 140, NULL, 'Vollständige Neufassung 3.2.9 V3.', 'checked', 41),
(375, 'Def. 3.2.10.1', 18, 'Graph', 'Ein Graph ist ein geordnetes Paar aus einer Knotenmenge und einer Kantenmenge.', 'G=(V,E)', 'G=(V,E)', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(376, 'Def. 3.2.10.2', 18, 'Gerichteter Graph', 'Ein gerichteter Graph besitzt Kanten als geordnete Paare von Knoten.', 'E\\subseteq V\\times V', 'E\\subseteq V\\times V', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(377, 'Def. 3.2.10.3', 18, 'Ungerichteter Graph', 'Ein ungerichteter Graph besitzt Kanten als ungeordnete Zweiermengen von Knoten.', '\\{v_i,v_j\\}\\in E', '\\{v_i,v_j\\}\\in E', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(378, 'Def. 3.2.10.4', 18, 'Einfacher Graph', 'Ein einfacher Graph enthält keine Schleifen und höchstens eine Kante zwischen zwei Knoten.', '(v_i,v_i)\\notin E', '(v_i,v_i)\\notin E', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(379, 'Def. 3.2.10.5', 18, 'Adjazenzmatrix', 'Die Adjazenzmatrix kodiert die Kantenstruktur eines endlichen Graphen in Matrixform.', 'A=(a_{ij})', 'A=(a_{ij})', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(380, 'Def. 3.2.10.6', 18, 'Knotengrad', 'Der Knotengrad ist die Anzahl der an einen Knoten angrenzenden Kanten.', '\\deg(v_i)=\\sum_j a_{ij}', '\\deg(v_i)=\\sum_j a_{ij}', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(381, 'Def. 3.2.10.7', 18, 'Weg', 'Ein Weg ist eine Knotenfolge, in der je zwei aufeinanderfolgende Knoten durch eine Kante verbunden sind.', '(v_i,v_{i+1})\\in E', '(v_i,v_{i+1})\\in E', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(382, 'Def. 3.2.10.8', 18, 'Graphendistanz', 'Die Graphendistanz ist die Länge eines kürzesten Pfades zwischen zwei Knoten.', 'd(v_i,v_j)=\\min_{P\\in\\mathcal P(v_i,v_j)}|P|', 'd(v_i,v_j)=\\min_{P\\in\\mathcal P(v_i,v_j)}|P|', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(383, 'Def. 3.2.10.9', 18, 'Zusammenhängender Graph', 'Ein Graph ist zusammenhängend, wenn zwischen jedem Knotenpaar mindestens ein Pfad existiert.', '\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal P(v_i,v_j)', '\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal P(v_i,v_j)', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(384, 'Def. 3.2.10.10', 18, 'Gewichteter Graph', 'Ein gewichteter Graph besitzt eine Gewichtsfunktion auf seiner Kantenmenge.', 'w:E\\to\\mathbb R', 'w:E\\to\\mathbb R', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(385, 'Def. 3.2.10.11', 18, 'Knotenstärke', 'Die Knotenstärke ist die Summe der Gewichte aller an einem Knoten anliegenden Kanten.', 's(v_i)=\\sum_j w_{ij}', 's(v_i)=\\sum_j w_{ij}', 'literature', 143, NULL, 'Masterstandard V5 für Abschnitt 3.2.10.', 'checked', 47),
(386, 'Def. 3.2.11.1', 19, 'Gradzentralität', 'Die Gradzentralität misst den normierten Anteil der direkten Nachbarn eines Knotens.', 'C_D(v_i)=\\frac{\\deg(v_i)}{n-1}', 'C_D(v_i)=\\frac{\\deg(v_i)}{n-1}', 'literature', 146, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(387, 'Def. 3.2.11.2', 19, 'Closeness-Zentralität', 'Die Closeness-Zentralität misst die globale Erreichbarkeit eines Knotens über die Summe kürzester Distanzen.', 'C_C(v_i)=\\frac{n-1}{\\sum_j d(v_i,v_j)}', 'C_C(v_i)=\\frac{n-1}{\\sum_j d(v_i,v_j)}', 'literature', 146, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(388, 'Def. 3.2.11.3', 19, 'Betweenness-Zentralität', 'Die Betweenness-Zentralität misst die Vermittlungsfunktion eines Knotens auf kürzesten Wegen.', 'C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}', 'C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}', 'literature', 146, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(389, 'Def. 3.2.11.4', 19, 'Eigenvektor-Zentralität', 'Die Eigenvektor-Zentralität bewertet einen Knoten höher, wenn er mit bereits zentralen Knoten verbunden ist.', 'Ax=\\lambda x', 'Ax=\\lambda x', 'literature', 146, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(390, 'Def. 3.2.11.5', 19, 'Lokaler Clusterkoeffizient', 'Der lokale Clusterkoeffizient quantifiziert die Vernetzung innerhalb der Nachbarschaft eines Knotens.', 'C(v_i)=\\frac{2m_i}{k_i(k_i-1)}', 'C(v_i)=\\frac{2m_i}{k_i(k_i-1)}', 'literature', 144, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(391, 'Def. 3.2.11.6', 19, 'Mittlere Weglänge', 'Die mittlere Weglänge ist der Durchschnitt der kürzesten Distanzen zwischen allen erreichbaren Knotenpaaren.', 'L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)', 'L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)', 'literature', 144, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(392, 'Def. 3.2.11.7', 19, 'Small-World-Netzwerk', 'Ein Small-World-Netzwerk verbindet hohe lokale Clusterung mit einer mittleren Weglänge nahe der eines Zufallsgraphen.', 'C\\gg C_{\\mathrm{random}},\\;L\\approx L_{\\mathrm{random}}', 'C\\gg C_{\\mathrm{random}},\\;L\\approx L_{\\mathrm{random}}', 'literature', 144, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(393, 'Def. 3.2.11.8', 19, 'Skalenfreies Netzwerk', 'Ein skalenfreies Netzwerk besitzt näherungsweise eine potenzgesetzartige Knotengradverteilung.', 'P(k)\\sim k^{-\\gamma}', 'P(k)\\sim k^{-\\gamma}', 'literature', 145, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(394, 'Def. 3.2.11.9', 19, 'Hub', 'Ein Hub ist ein Knoten mit im Verhältnis zum Gesamtnetzwerk außergewöhnlich hohem Grad oder hoher Zentralität.', 'k\\gg\\langle k\\rangle', 'k\\gg\\langle k\\rangle', 'literature', 145, NULL, 'Masterstandard V5 für Abschnitt 3.2.11.', 'checked', 45),
(395, 'Def. 3.2.12.1', 20, 'Systematische Forschungslücke', 'Die systematische Forschungslücke besteht im Fehlen eines formalen Systems, das die Entstehung, Veränderung und Stabilisierung funktionaler Relationen sowie die daraus hervorgehende Rekonstruktion von Raum und Zeit erklärt.', NULL, NULL, 'original', NULL, 'Etablierte mathematische Theorien setzen Träger, Relationen, Zustandsräume oder Wahrscheinlichkeitsräume bereits voraus.', 'Zusammenfassende Eigenanalyse des Forschungsstandes.', 'checked', 49),
(396, 'Def. 3.2.12.2', 20, 'Funktionale Strukturgenese', 'Funktionale Strukturgenese bezeichnet die regelhafte Entstehung, Veränderung, Stabilisierung und übergeordnete Organisation funktionaler Relationen, ohne geometrischen Raum und externe Zeit als primitive Größen vorauszusetzen.', NULL, NULL, 'original', NULL, 'Raum und Zeit sollen als rekonstruierbare Organisationsgrößen behandelt werden.', 'Methodische Anschlussanforderung für Kapitel 3.3.', 'checked', 49),
(397, 'Def. 3.2.12.3', 20, 'Axiomatische Anschlussanforderung', 'Die axiomatische Anschlussanforderung verlangt, dass die mathematische Rekonstruktion funktionaler Organisation aus einer kleinen Menge expliziter, voneinander abgegrenzter und nachvollziehbar verknüpfter Grundannahmen ableitbar ist.', NULL, NULL, 'original', NULL, 'Kapitel 3.3 formuliert die qualitativen Grundannahmen; Kapitel 3.4 rekonstruiert daraus mathematische Strukturen.', 'Übergangsdefinition zwischen Kapitel 3.2 und Kapitel 3.3.', 'checked', 49);

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
(7, NULL, '3.2', 'Mathematische Grundlagen', 3, 3.2000, 'final', 0, 'Kapitel 3.2 vollständig abgeschlossen; Abschnitte 3.2.1–3.2.12 revisionssicher registriert.', '2026-07-12 11:14:28', '2026-07-15 17:27:46'),
(8, 7, '3.2.0', 'Einleitung', 3, 3.2001, 'review', 0, 'Am 12.07.2026 vollständig neu gefasst. Die Einleitung ordnet Kapitel 3.2 als mathematischen Forschungsstand ein und grenzt es von der Eigenleistung ab Kapitel 3.3 ab. Keine nummerierte Gleichung.', '2026-07-12 11:14:28', '2026-07-12 12:53:42'),
(9, 7, '3.2.1', 'Mengen als Grundlage mathematischer Modellbildung', 3, 3.2100, 'review', 0, 'Am 14.07.2026 vollständig neu gefasst. Forschungsstand zur axiomatischen Mengenlehre mit den Quellen [23], [24] und [58]; Gleichungen (3.3)–(3.16).', '2026-07-12 11:14:28', '2026-07-14 14:56:18'),
(10, 7, '3.2.2', 'Relationen als mathematische Beschreibung struktureller Zusammenhänge', 3, 3.2200, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [27], [28], [59] und Gleichungen (3.17)–(3.41).', '2026-07-12 11:14:28', '2026-07-15 17:27:43'),
(11, 7, '3.2.3', 'Funktionen als mathematische Beschreibung gerichteter Transformationen', 3, 3.2300, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [29], [30], [60] und Gleichungen (3.42)–(3.64).', '2026-07-12 11:14:28', '2026-07-15 17:27:43'),
(12, 7, '3.2.4', 'Algebraische Strukturen als Grundlage regelhafter Verknüpfungen', 3, 3.2400, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [61]–[65] und Gleichungen (3.65)–(3.106).', '2026-07-12 11:14:28', '2026-07-15 17:27:44'),
(13, 7, '3.2.5', 'Operatoren als mathematische Beschreibung funktionaler Transformationen', 3, 3.2500, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [66]–[67] und Gleichungen (3.107)–(3.135).', '2026-07-12 11:14:28', '2026-07-15 17:27:44'),
(14, 7, '3.2.6', 'Zustandsräume als mathematische Grundlage funktionaler Dynamik', 3, 3.2600, 'review', 0, 'Vollständige Neufassung V2 mit Quellen [68]–[69] und Gleichungen (3.136)–(3.158).', '2026-07-12 11:14:28', '2026-07-15 17:27:44'),
(15, 7, '3.2.7', 'Stabilität, Invarianz und Attraktoren als mathematische Beschreibung langfristiger Organisation', 3, 3.2700, 'review', 0, 'Neufassung V2 mit Quellen [70]–[72] und Gleichungen (3.159)–(3.183).', '2026-07-12 11:14:28', '2026-07-15 17:27:45'),
(16, 7, '3.2.8', 'Nichtlinearität, Bifurkationen und Emergenz als mathematische Grundlagen qualitativer Strukturveränderungen', 3, 3.2800, 'review', 0, 'Neufassung V2 mit Quellen [73]–[74] und Gleichungen (3.184)–(3.211).', '2026-07-12 11:14:28', '2026-07-15 17:27:45'),
(17, 7, '3.2.9', 'Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse', 3, 3.2900, 'review', 0, 'Vollständige Neufassung V3 mit Quellen [75]–[76] und Gleichungen (3.212)–(3.244).', '2026-07-12 11:14:28', '2026-07-15 17:27:45'),
(18, 7, '3.2.10', 'Graphen- und Netzwerktheorie als mathematische Grundlage relationaler Strukturen', 3, 3.3000, 'review', 0, 'Masterstandard V5 mit Quellen [77]–[78] und Gleichungen (3.245)–(3.266).', '2026-07-12 11:14:28', '2026-07-15 17:27:46'),
(19, 7, '3.2.11', 'Netzwerkeigenschaften, Zentralitätsmaße und globale Organisationsstrukturen', 3, 3.3100, 'review', 0, 'Masterstandard V5 mit Quellen [79]–[81] und Gleichungen (3.267)–(3.274).', '2026-07-12 11:14:28', '2026-07-15 17:27:46'),
(20, 7, '3.2.12', 'Zusammenfassung der mathematischen Grundlagen und Identifikation der Forschungslücke', 3, 3.3200, 'final', 0, 'Abschluss von Kapitel 3.2; keine neue Literaturquelle und keine neue Gleichung.', '2026-07-12 11:14:28', '2026-07-15 17:27:46'),
(21, 7, '3.2.13', 'Grenzen bestehender mathematischer Modelle und Herleitung der Forschungslücke', 3, 3.3300, 'planned', 0, 'Durch die Endstruktur von Kapitel 3.2 entfallen; der Kapitelabschluss befindet sich in 3.2.12.', '2026-07-12 11:14:28', '2026-07-15 17:27:46'),
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
(736, '3.3', 9, 'Elementzugehörigkeit', 'x\\in M', 'x\\in M', 'Das Objekt x ist Element der Menge M.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(737, '3.4', 9, 'Nichtzugehörigkeit', 'x\\notin M', 'x\\notin M', 'Das Objekt x ist kein Element der Menge M.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(738, '3.5', 9, 'Leere Menge', '\\emptyset', '\\emptyset', 'Bezeichnung der eindeutig bestimmten Menge ohne Elemente.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(739, '3.6', 9, 'Extensionalitätsaxiom', 'A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)', 'A=B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)', 'Zwei Mengen sind genau dann identisch, wenn sie dieselben Elemente besitzen.', 'axiom', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(740, '3.7', 9, 'Teilmengenrelation', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A\\subseteq B\\Longleftrightarrow\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(741, '3.8', 9, 'Aussonderungsmenge', 'A_P=\\left\\{x\\in A\\mid P(x)\\right\\}', 'A_P=\\left\\{x\\in A\\mid P(x)\\right\\}', 'Teilmenge von A, deren Elemente die Eigenschaft P erfüllen.', 'definition', 'literature', 63, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(742, '3.9', 9, 'Vereinigung', 'A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}', 'A\\cup B=\\{x\\mid x\\in A\\lor x\\in B\\}', 'Vereinigung der Mengen A und B.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(743, '3.10', 9, 'Durchschnitt', 'A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}', 'A\\cap B=\\{x\\mid x\\in A\\land x\\in B\\}', 'Durchschnitt der Mengen A und B.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(744, '3.11', 9, 'Differenzmenge', 'A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}', 'A\\setminus B=\\{x\\mid x\\in A\\land x\\notin B\\}', 'Differenzmenge von A bezüglich B.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(745, '3.12', 9, 'Komplement', 'A^{c}=U\\setminus A', 'A^{c}=U\\setminus A', 'Komplement von A relativ zur Grundmenge U.', 'definition', 'literature', 24, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(746, '3.13', 9, 'Kartesisches Produkt', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'A\\times B=\\{(a,b)\\mid a\\in A,\\;b\\in B\\}', 'Menge aller geordneten Paare aus A und B.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(747, '3.14', 9, 'Potenzmenge', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', '\\mathcal P(A)=\\{X\\mid X\\subseteq A\\}', 'Menge aller Teilmengen von A.', 'definition', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(748, '3.15', 9, 'Satz von Cantor', '|\\mathcal P(A)|>|A|', '|\\mathcal P(A)|>|A|', 'Die Potenzmenge besitzt eine strikt größere Mächtigkeit als ihre Ausgangsmenge.', 'theorem', 'literature', 23, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(749, '3.16', 9, 'Schema mengenbildender Operationen', '\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)', '\\Omega:\\mathcal P(M)\\longrightarrow\\mathcal P(M)', 'Schematische Darstellung einer Operation auf Teilmengen einer Grundmenge.', 'schema', 'adapted', 63, NULL, 'Gültig im Rahmen der axiomatischen Mengenlehre und der im Abschnitt angegebenen Grundmengen.', 'checked', 24),
(750, '3.17', 10, 'Geordnetes Paar', '(a,b)', '(a,b)', 'Geordnetes Paar aus den Komponenten a und b.', 'definition', 'literature', 27, NULL, 'a und b sind Elemente geeigneter Mengen.', 'checked', 25),
(751, '3.18', 10, 'Identität geordneter Paare', '(a,b)=(c,d)Longleftrightarrow a=cland b=d', '(a,b)=(c,d)Longleftrightarrow a=cland b=d', 'Zwei geordnete Paare sind genau dann gleich, wenn ihre jeweiligen Komponenten übereinstimmen.', 'definition', 'literature', 27, NULL, 'a,b,c,d sind mathematische Objekte.', 'checked', 25),
(752, '3.19', 10, 'Reihenfolge geordneter Paare', '(a,b)\neq(b,a)', '(a,b)\neq(b,a)', 'Bei verschiedenen Komponenten ist die Reihenfolge eines geordneten Paares wesentlich.', 'derived', 'literature', 27, NULL, 'a\neq b.', 'checked', 25),
(753, '3.20', 10, 'Kartesisches Produkt', 'A	imes B=left{(a,b)mid ain Aland bin B\right}', 'A	imes B=left{(a,b)mid ain Aland bin B\right}', 'Das kartesische Produkt enthält alle geordneten Paare aus A und B.', 'definition', 'literature', 27, NULL, 'A und B sind Mengen.', 'checked', 25),
(754, '3.21', 10, 'Binäre Relation', 'Rsubseteq A	imes B', 'Rsubseteq A	imes B', 'Eine binäre Relation zwischen A und B ist eine Teilmenge ihres kartesischen Produkts.', 'definition', 'literature', 27, NULL, 'A und B sind Mengen.', 'checked', 25),
(755, '3.22', 10, 'Relationsnotation', 'aRbLongleftrightarrow(a,b)in R', 'aRbLongleftrightarrow(a,b)in R', 'Die Schreibweise aRb bedeutet, dass das geordnete Paar (a,b) zur Relation R gehört.', 'definition', 'literature', 27, NULL, 'Rsubseteq A	imes B.', 'checked', 25),
(756, '3.23', 10, 'Relation auf einer Menge', 'Rsubseteq A	imes A', 'Rsubseteq A	imes A', 'Eine Relation auf A ist eine Teilmenge von A mal A.', 'definition', 'literature', 27, NULL, 'A ist eine Menge.', 'checked', 25),
(757, '3.24', 10, 'Definitionsbereich einer Relation', 'operatorname{dom}(R)=left{ain Amidexists bin B:(a,b)in R\right}', 'operatorname{dom}(R)=left{ain Amidexists bin B:(a,b)in R\right}', 'Der Definitionsbereich enthält alle ersten Komponenten, die in mindestens einem Relationspaar auftreten.', 'definition', 'literature', 27, NULL, 'Rsubseteq A	imes B.', 'checked', 25),
(758, '3.25', 10, 'Wertebereich einer Relation', 'operatorname{ran}(R)=left{bin Bmidexists ain A:(a,b)in R\right}', 'operatorname{ran}(R)=left{bin Bmidexists ain A:(a,b)in R\right}', 'Der Wertebereich enthält alle zweiten Komponenten, die in mindestens einem Relationspaar auftreten.', 'definition', 'literature', 27, NULL, 'Rsubseteq A	imes B.', 'checked', 25),
(759, '3.26', 10, 'Inverse Relation', 'R^{-1}=left{(b,a)mid(a,b)in R\right}', 'R^{-1}=left{(b,a)mid(a,b)in R\right}', 'Die inverse Relation entsteht durch Vertauschung der Komponenten aller Relationspaare.', 'definition', 'literature', 27, NULL, 'R ist eine binäre Relation.', 'checked', 25),
(760, '3.27', 10, 'Reflexivität', 'forall ain A:;aRa', 'forall ain A:;aRa', 'Eine Relation ist reflexiv, wenn jedes Element zu sich selbst in Relation steht.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(761, '3.28', 10, 'Irreflexivität', 'forall ain A:;\neg(aRa)', 'forall ain A:;\neg(aRa)', 'Eine Relation ist irreflexiv, wenn kein Element zu sich selbst in Relation steht.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(762, '3.29', 10, 'Symmetrie', 'forall a,bin A:;aRbLongrightarrow bRa', 'forall a,bin A:;aRbLongrightarrow bRa', 'Eine Relation ist symmetrisch, wenn jede Beziehung auch in der Gegenrichtung gilt.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(763, '3.30', 10, 'Antisymmetrie', 'forall a,bin A:;left(aRbland bRa\right)Longrightarrow a=b', 'forall a,bin A:;left(aRbland bRa\right)Longrightarrow a=b', 'Eine Relation ist antisymmetrisch, wenn wechselseitige Relation Identität erzwingt.', 'definition', 'literature', 28, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(764, '3.31', 10, 'Asymmetrie', 'forall a,bin A:;aRbLongrightarrow\neg(bRa)', 'forall a,bin A:;aRbLongrightarrow\neg(bRa)', 'Eine Relation ist asymmetrisch, wenn aus aRb die Nichtgeltung von bRa folgt.', 'definition', 'literature', 28, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(765, '3.32', 10, 'Transitivität', 'forall a,b,cin A:;left(aRbland bRc\right)Longrightarrow aRc', 'forall a,b,cin A:;left(aRbland bRc\right)Longrightarrow aRc', 'Eine Relation ist transitiv, wenn verkettete Beziehungen wieder eine Beziehung ergeben.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(766, '3.33', 10, 'Äquivalenzrelation', 'R	ext{ ist Äquivalenzrelation}Longleftrightarrow R	ext{ ist reflexiv, symmetrisch und transitiv}', 'R	ext{ ist Äquivalenzrelation}Longleftrightarrow R	ext{ ist reflexiv, symmetrisch und transitiv}', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', 'definition', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(767, '3.34', 10, 'Äquivalenzklasse', '[a]_R=left{xin Amid xRa\right}', '[a]_R=left{xin Amid xRa\right}', 'Die Äquivalenzklasse eines Elements enthält alle zu ihm äquivalenten Elemente.', 'definition', 'literature', 27, NULL, 'R ist eine Äquivalenzrelation auf A.', 'checked', 25),
(768, '3.35', 10, 'Quotientenmenge', 'A/R=left{[a]_Rmid ain A\right}', 'A/R=left{[a]_Rmid ain A\right}', 'Die Quotientenmenge besteht aus allen Äquivalenzklassen von A bezüglich R.', 'definition', 'literature', 27, NULL, 'R ist eine Äquivalenzrelation auf A.', 'checked', 25),
(769, '3.36', 10, 'Halbordnung', 'R	ext{ ist Halbordnung}Longleftrightarrow R	ext{ ist reflexiv, antisymmetrisch und transitiv}', 'R	ext{ ist Halbordnung}Longleftrightarrow R	ext{ ist reflexiv, antisymmetrisch und transitiv}', 'Eine Halbordnung ist reflexiv, antisymmetrisch und transitiv.', 'definition', 'literature', 28, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(770, '3.37', 10, 'Partiell geordnete Menge', 'left(A,preceq\right)', 'left(A,preceq\right)', 'Ein Paar aus einer Menge A und einer Halbordnung bildet eine partiell geordnete Menge.', 'definition', 'literature', 28, NULL, 'preceq ist eine Halbordnung auf A.', 'checked', 25),
(771, '3.38', 10, 'Totalordnung', 'forall a,bin A:;apreceq blor bpreceq a', 'forall a,bin A:;apreceq blor bpreceq a', 'In einer Totalordnung sind je zwei Elemente vergleichbar.', 'definition', 'literature', 28, NULL, 'preceq ist eine Halbordnung auf A.', 'checked', 25),
(772, '3.39', 10, 'Komposition von Relationen', 'Scirc R=left{(a,c)in A	imes Cmidexists bin B:;aRbland bSc\right}', 'Scirc R=left{(a,c)in A	imes Cmidexists bin B:;aRbland bSc\right}', 'Die Komposition erfasst Beziehungen, die über ein Zwischenelement vermittelt werden.', 'definition', 'literature', 69, NULL, 'Rsubseteq A	imes B und Ssubseteq B	imes C.', 'checked', 25),
(773, '3.40', 10, 'Transitivität als Selbstkomposition', 'Rcirc Rsubseteq R', 'Rcirc Rsubseteq R', 'Eine Relation ist transitiv, wenn ihre Selbstkomposition in ihr enthalten ist.', 'derived', 'literature', 69, NULL, 'R ist eine Relation auf A.', 'checked', 25),
(774, '3.41', 10, 'Graph einer Relation', 'G_R=left(A,R\right)', 'G_R=left(A,R\right)', 'Eine binäre Relation auf A kann als gerichteter Graph mit Knotenmenge A und Kantenmenge R interpretiert werden.', 'model', 'literature', 27, NULL, 'Rsubseteq A	imes A.', 'checked', 25),
(775, '3.42', 11, 'Funktion als Abbildung', 'f:A\\longrightarrow B', 'f:A\\longrightarrow B', 'Eine Funktion f bildet die Definitionsmenge A in die Zielmenge B ab.', 'definition', 'literature', 29, NULL, 'A und B sind Mengen.', 'checked', 26),
(776, '3.43', 11, 'Existenz und Eindeutigkeit', '\\forall x\\in A\\;\\exists!\\,y\\in B:\\;f(x)=y', '\\forall x\\in A\\;\\exists!\\,y\\in B:\\;f(x)=y', 'Jedem Element des Definitionsbereichs wird genau ein Element des Zielbereichs zugeordnet.', 'definition', 'literature', 29, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(777, '3.44', 11, 'Existenzbedingung', '\\forall x\\in A\\;\\exists y\\in B:\\;f(x)=y', '\\forall x\\in A\\;\\exists y\\in B:\\;f(x)=y', 'Für jedes Element des Definitionsbereichs existiert mindestens ein Funktionswert.', 'definition', 'literature', 29, NULL, 'f ist eine totale Funktion auf A.', 'checked', 26),
(778, '3.45', 11, 'Eindeutigkeitsbedingung', '\\forall x\\in A\\;\\forall y_1,y_2\\in B:\\;\\left(f(x)=y_1\\land f(x)=y_2\\right)\\Longrightarrow y_1=y_2', '\\forall x\\in A\\;\\forall y_1,y_2\\in B:\\;\\left(f(x)=y_1\\land f(x)=y_2\\right)\\Longrightarrow y_1=y_2', 'Zu einem Ausgangselement können nicht zwei verschiedene Funktionswerte gehören.', 'definition', 'literature', 29, NULL, 'x liegt in A; y_1 und y_2 liegen in B.', 'checked', 26),
(779, '3.46', 11, 'Funktion als spezielle Relation', 'f\\subseteq A\\times B', 'f\\subseteq A\\times B', 'Eine Funktion ist eine spezielle Relation zwischen A und B.', 'definition', 'literature', 29, NULL, 'Zusätzlich gilt die Existenz- und Eindeutigkeitsbedingung.', 'checked', 26),
(780, '3.47', 11, 'Funktionswert und Relationspaar', 'f(x)=y\\Longleftrightarrow(x,y)\\in f', 'f(x)=y\\Longleftrightarrow(x,y)\\in f', 'Der Funktionswert y entspricht dem eindeutig zugeordneten Relationspaar.', 'definition', 'literature', 29, NULL, 'f ist mengentheoretisch als Relation aufgefasst.', 'checked', 26),
(781, '3.48', 11, 'Bild einer Menge', 'f(A)=\\left\\{f(x)\\mid x\\in A\\right\\}', 'f(A)=\\left\\{f(x)\\mid x\\in A\\right\\}', 'Das Bild von A enthält alle tatsächlich auftretenden Funktionswerte.', 'definition', 'literature', 29, NULL, 'f ist auf A definiert.', 'checked', 26),
(782, '3.49', 11, 'Bildmenge als Teilmenge', 'f(A)\\subseteq B', 'f(A)\\subseteq B', 'Das Bild einer Funktion ist Teilmenge ihrer Zielmenge.', 'derived', 'literature', 29, NULL, 'f bildet A nach B ab.', 'checked', 26),
(783, '3.50', 11, 'Bild einer Teilmenge', 'f(M)=\\left\\{f(x)\\mid x\\in M\\right\\}', 'f(M)=\\left\\{f(x)\\mid x\\in M\\right\\}', 'Bild einer Teilmenge M des Definitionsbereichs.', 'definition', 'literature', 29, NULL, 'M ist Teilmenge von A.', 'checked', 26),
(784, '3.51', 11, 'Urbild einer Teilmenge', 'f^{-1}(N)=\\left\\{x\\in A\\mid f(x)\\in N\\right\\}', 'f^{-1}(N)=\\left\\{x\\in A\\mid f(x)\\in N\\right\\}', 'Das Urbild enthält alle Ausgangselemente, deren Bilder in N liegen.', 'definition', 'literature', 29, NULL, 'N ist Teilmenge von B; keine inverse Funktion erforderlich.', 'checked', 26),
(785, '3.52', 11, 'Injektivität', '\\forall x_1,x_2\\in A:\\;f(x_1)=f(x_2)\\Longrightarrow x_1=x_2', '\\forall x_1,x_2\\in A:\\;f(x_1)=f(x_2)\\Longrightarrow x_1=x_2', 'Eine Funktion ist injektiv, wenn gleiche Bilder nur von gleichen Urbildern stammen.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(786, '3.53', 11, 'Äquivalente Injektivitätsbedingung', 'x_1\\neq x_2\\Longrightarrow f(x_1)\\neq f(x_2)', 'x_1\\neq x_2\\Longrightarrow f(x_1)\\neq f(x_2)', 'Verschiedene Ausgangselemente besitzen bei einer injektiven Funktion verschiedene Bilder.', 'derived', 'literature', 30, NULL, 'f ist injektiv.', 'checked', 26),
(787, '3.54', 11, 'Surjektivität', '\\forall y\\in B\\;\\exists x\\in A:\\;f(x)=y', '\\forall y\\in B\\;\\exists x\\in A:\\;f(x)=y', 'Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(788, '3.55', 11, 'Bildmenge einer surjektiven Funktion', 'f(A)=B', 'f(A)=B', 'Bei einer surjektiven Funktion stimmen Bild- und Zielmenge überein.', 'derived', 'literature', 30, NULL, 'f ist surjektiv.', 'checked', 26),
(789, '3.56', 11, 'Bijektivität', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv}\\land f\\text{ ist surjektiv}', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv}\\land f\\text{ ist surjektiv}', 'Bijektivität verbindet Injektivität und Surjektivität.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 26),
(790, '3.57', 11, 'Umkehrfunktion', 'f^{-1}:B\\longrightarrow A', 'f^{-1}:B\\longrightarrow A', 'Eine bijektive Funktion besitzt eine Umkehrfunktion von B nach A.', 'definition', 'literature', 30, NULL, 'f ist bijektiv.', 'checked', 26),
(791, '3.58', 11, 'Linke Umkehrbeziehung', 'f^{-1}(f(x))=x', 'f^{-1}(f(x))=x', 'Die Umkehrfunktion hebt die Wirkung von f auf Elementen aus A auf.', 'derived', 'literature', 30, NULL, 'x liegt in A und f ist bijektiv.', 'checked', 26),
(792, '3.59', 11, 'Rechte Umkehrbeziehung', 'f(f^{-1}(y))=y', 'f(f^{-1}(y))=y', 'Die Funktion hebt die Wirkung ihrer Umkehrfunktion auf Elementen aus B auf.', 'derived', 'literature', 30, NULL, 'y liegt in B und f ist bijektiv.', 'checked', 26),
(793, '3.60', 11, 'Komposition von Funktionen', '(g\\circ f)(x)=g(f(x))', '(g\\circ f)(x)=g(f(x))', 'Die Komposition wendet zunächst f und anschließend g an.', 'definition', 'literature', 30, NULL, 'f:A nach B und g:B nach C.', 'checked', 26),
(794, '3.61', 11, 'Assoziativität der Komposition', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'Die Komposition von Funktionen ist assoziativ.', 'derived', 'literature', 30, NULL, 'Definitions- und Zielmengen sind kompositionsverträglich.', 'checked', 26),
(795, '3.62', 11, 'Identitätsabbildung', '\\operatorname{id}_A:A\\longrightarrow A', '\\operatorname{id}_A:A\\longrightarrow A', 'Die Identitätsabbildung ist eine Funktion von A nach A.', 'definition', 'literature', 30, NULL, 'A ist eine Menge.', 'checked', 26),
(796, '3.63', 11, 'Wirkung der Identitätsabbildung', '\\operatorname{id}_A(x)=x', '\\operatorname{id}_A(x)=x', 'Die Identitätsabbildung lässt jedes Element unverändert.', 'definition', 'literature', 30, NULL, 'x liegt in A.', 'checked', 26),
(797, '3.64', 11, 'Identität als neutrales Element', 'f\\circ\\operatorname{id}_A=f=\\operatorname{id}_B\\circ f', 'f\\circ\\operatorname{id}_A=f=\\operatorname{id}_B\\circ f', 'Identitätsabbildungen sind neutrale Elemente der Funktionskomposition.', 'derived', 'literature', 30, NULL, 'f bildet A nach B ab.', 'checked', 26),
(798, '3.65', 12, 'Innere binäre Verknüpfung', 'star:A	imes Alongrightarrow A', 'star:A	imes Alongrightarrow A', 'Eine innere Verknüpfung bildet Paare aus A wieder nach A ab.', 'definition', 'literature', 83, NULL, 'A ist eine nichtleere Menge.', 'checked', 29),
(799, '3.66', 12, 'Abgeschlossenheit', 'forall a,bin A:;astar bin A', 'forall a,bin A:;astar bin A', 'Das Ergebnis der Verknüpfung liegt wieder in A.', 'definition', 'literature', 83, NULL, 'a,b liegen in A.', 'checked', 29),
(800, '3.67', 12, 'Magma', 'left(A,star\right)', 'left(A,star\right)', 'Paar aus Trägermenge und innerer Verknüpfung.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(801, '3.68', 12, 'Linke Klammerung', 'left(astar b\right)star c', 'left(astar b\right)star c', 'Erste Klammerung einer dreifachen Verknüpfung.', 'other', 'literature', 83, NULL, '', 'checked', 29),
(802, '3.69', 12, 'Rechte Klammerung', 'astarleft(bstar c\right)', 'astarleft(bstar c\right)', 'Zweite Klammerung einer dreifachen Verknüpfung.', 'other', 'literature', 83, NULL, '', 'checked', 29),
(803, '3.70', 12, 'Assoziativität', 'forall a,b,cin A:;left(astar b\right)star c=astarleft(bstar c\right)', 'forall a,b,cin A:;left(astar b\right)star c=astarleft(bstar c\right)', 'Assoziativgesetz.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(804, '3.71', 12, 'Halbgruppe', 'left(A,star\right)	ext{ ist Halbgruppe}Longleftrightarrowstar	ext{ ist abgeschlossen und assoziativ}', 'left(A,star\right)	ext{ ist Halbgruppe}Longleftrightarrowstar	ext{ ist abgeschlossen und assoziativ}', 'Charakterisierung einer Halbgruppe.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(805, '3.72', 12, 'Verknüpfungsfolge', 'a_1star a_2starcdotsstar a_n', 'a_1star a_2starcdotsstar a_n', 'Assoziativ interpretierbare endliche Verknüpfungsfolge.', 'schema', 'literature', 83, NULL, '', 'checked', 29),
(806, '3.73', 12, 'Linksneutrales Element', 'forall ain A:;estar a=a', 'forall ain A:;estar a=a', 'Linke Neutralität.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(807, '3.74', 12, 'Rechtsneutrales Element', 'forall ain A:;astar e=a', 'forall ain A:;astar e=a', 'Rechte Neutralität.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(808, '3.75', 12, 'Eindeutigkeit des neutralen Elements', 'e_1=e_1star e_2=e_2', 'e_1=e_1star e_2=e_2', 'Nachweis der Eindeutigkeit eines neutralen Elements.', 'derived', 'literature', 83, NULL, '', 'checked', 29),
(809, '3.76', 12, 'Monoid', 'left(A,star,e\right)	ext{ ist Monoid}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ ist neutrales Element}end{array}\right.', 'left(A,star,e\right)	ext{ ist Monoid}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ ist neutrales Element}end{array}\right.', 'Charakterisierung eines Monoids.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(810, '3.77', 12, 'Positive Potenz', 'a^n=underbrace{astar astarcdotsstar a}_{n	ext{ Faktoren}}', 'a^n=underbrace{astar astarcdotsstar a}_{n	ext{ Faktoren}}', 'Wiederholte Verknüpfung eines Elements.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(811, '3.78', 12, 'Nullte Potenz', 'a^0=e', 'a^0=e', 'Die nullte Potenz entspricht dem neutralen Element.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(812, '3.79', 12, 'Freies Wortmonoid', 'left(Sigma^ast,cdot,varepsilon\right)', 'left(Sigma^ast,cdot,varepsilon\right)', 'Monoid endlicher Wörter unter Konkatenation.', 'model', 'literature', 83, NULL, '', 'checked', 29),
(813, '3.80', 12, 'Rechtsinverses', 'astar a^{-1}=e', 'astar a^{-1}=e', 'Rechtsseitige Inversenbedingung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(814, '3.81', 12, 'Linksinverses', 'a^{-1}star a=e', 'a^{-1}star a=e', 'Linksseitige Inversenbedingung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(815, '3.82', 12, 'Gruppe', 'left(A,star\right)	ext{ ist Gruppe}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ existiert}\\forall ain A;exists a^{-1}in Aend{array}\right.', 'left(A,star\right)	ext{ ist Gruppe}Longleftrightarrowleft{egin{array}{l}star	ext{ ist assoziativ}\\e	ext{ existiert}\\forall ain A;exists a^{-1}in Aend{array}\right.', 'Charakterisierung einer Gruppe.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(816, '3.83', 12, 'Eindeutigkeit inverser Elemente', 'b=bstar e=bstarleft(astar c\right)=left(bstar a\right)star c=estar c=c', 'b=bstar e=bstarleft(astar c\right)=left(bstar a\right)star c=estar c=c', 'Herleitung der Eindeutigkeit des Inversen.', 'derived', 'literature', 84, NULL, '', 'checked', 29),
(817, '3.84', 12, 'Kommutativität', 'forall a,bin A:;astar b=bstar a', 'forall a,bin A:;astar b=bstar a', 'Kommutativgesetz einer abelschen Gruppe.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(818, '3.85', 12, 'Untergruppenkriterium', 'forall a,bin H:;astar b^{-1}in H', 'forall a,bin H:;astar b^{-1}in H', 'Praktisches Kriterium für eine Untergruppe.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(819, '3.86', 12, 'Gruppenhomomorphismus', 'varphileft(astar b\right)=varphi(a)circvarphi(b)', 'varphileft(astar b\right)=varphi(a)circvarphi(b)', 'Erhaltung der Gruppenverknüpfung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(820, '3.87', 12, 'Isomorphie', 'Gcong H', 'Gcong H', 'Kennzeichnung strukturgleicher Gruppen.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(821, '3.88', 12, 'Ringstruktur', 'left(R,+,cdot\right)', 'left(R,+,cdot\right)', 'Ring mit zwei inneren Operationen.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(822, '3.89', 12, 'Assoziativität der Addition', 'forall a,b,cin R:;left(a+b\right)+c=a+left(b+c\right)', 'forall a,b,cin R:;left(a+b\right)+c=a+left(b+c\right)', 'Assoziativgesetz der Addition.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(823, '3.90', 12, 'Additives neutrales Element', 'a+0=a', 'a+0=a', 'Additive Neutralität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(824, '3.91', 12, 'Additives Inverses', 'a+left(-a\right)=0', 'a+left(-a\right)=0', 'Additive Inversenbedingung.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(825, '3.92', 12, 'Assoziativität der Multiplikation', 'left(acdot b\right)cdot c=acdotleft(bcdot c\right)', 'left(acdot b\right)cdot c=acdotleft(bcdot c\right)', 'Assoziativgesetz der Multiplikation.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(826, '3.93', 12, 'Linkes Distributivgesetz', 'acdotleft(b+c\right)=acdot b+acdot c', 'acdotleft(b+c\right)=acdot b+acdot c', 'Linke Distributivität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(827, '3.94', 12, 'Rechtes Distributivgesetz', 'left(a+b\right)cdot c=acdot c+bcdot c', 'left(a+b\right)cdot c=acdot c+bcdot c', 'Rechte Distributivität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(828, '3.95', 12, 'Kommutative Multiplikation', 'acdot b=bcdot a', 'acdot b=bcdot a', 'Kommutativität in einem kommutativen Ring.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(829, '3.96', 12, 'Multiplikatives neutrales Element', '1cdot a=a=acdot 1', '1cdot a=a=acdot 1', 'Multiplikative Neutralität.', 'definition', 'literature', 82, NULL, '', 'checked', 29),
(830, '3.97', 12, 'Multiplikatives Inverses im Körper', 'forall a\neq0;exists a^{-1}:;acdot a^{-1}=1', 'forall a\neq0;exists a^{-1}:;acdot a^{-1}=1', 'Inverseigenschaft von Körperelementen.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(831, '3.98', 12, 'Grundkörper', 'mathbb{Q},;mathbb{R},;mathbb{C}', 'mathbb{Q},;mathbb{R},;mathbb{C}', 'Beispiele wichtiger Körper.', 'schema', 'literature', 83, NULL, '', 'checked', 29),
(832, '3.99', 12, 'Skalarmultiplikation', 'K	imes Vlongrightarrow V', 'K	imes Vlongrightarrow V', 'Skalarmultiplikation eines Vektorraums.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(833, '3.100', 12, 'Distributivität über Vektoraddition', 'lambdaleft(u+v\right)=lambda u+lambda v', 'lambdaleft(u+v\right)=lambda u+lambda v', 'Erstes Distributivgesetz des Vektorraums.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(834, '3.101', 12, 'Distributivität über Skalaraddition', 'left(lambda+mu\right)v=lambda v+mu v', 'left(lambda+mu\right)v=lambda v+mu v', 'Zweites Distributivgesetz des Vektorraums.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(835, '3.102', 12, 'Assoziativität der Skalarmultiplikation', 'left(lambdamu\right)v=lambdaleft(mu v\right)', 'left(lambdamu\right)v=lambdaleft(mu v\right)', 'Verträglichkeit der Skalarmultiplikation.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(836, '3.103', 12, 'Skalare Identität', '1v=v', '1v=v', 'Wirkung der skalaren Eins.', 'definition', 'literature', 83, NULL, '', 'checked', 29),
(837, '3.104', 12, 'Homomorphismus', 'varphileft(astar b\right)=varphi(a)starvarphi(b)', 'varphileft(astar b\right)=varphi(a)starvarphi(b)', 'Allgemeine Erhaltung einer algebraischen Verknüpfung.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(838, '3.105', 12, 'Additive Strukturerhaltung', 'varphileft(a+b\right)=varphi(a)+varphi(b)', 'varphileft(a+b\right)=varphi(a)+varphi(b)', 'Erhaltung der Ringaddition.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(839, '3.106', 12, 'Multiplikative Strukturerhaltung', 'varphileft(acdot b\right)=varphi(a)cdotvarphi(b)', 'varphileft(acdot b\right)=varphi(a)cdotvarphi(b)', 'Erhaltung der Ringmultiplikation.', 'definition', 'literature', 84, NULL, '', 'checked', 29),
(840, '3.107', 13, 'Allgemeiner Operator', 'T:X\\longrightarrow Y', 'T:X\\longrightarrow Y', 'Operator als Abbildung zwischen mathematisch strukturierten Räumen.', 'definition', 'literature', 35, NULL, 'X und Y sind geeignete mathematische Räume.', 'checked', 31),
(841, '3.108', 13, 'Operatorbild eines Elements', 'T(x)\\in Y', 'T(x)\\in Y', 'Bild eines Elements unter dem Operator.', 'derived', 'literature', 35, NULL, 'x\\in X.', 'checked', 31),
(842, '3.109', 13, 'Operator auf einem Raum', 'T:X\\longrightarrow X', 'T:X\\longrightarrow X', 'Endomorpher Operator auf X.', 'definition', 'literature', 35, NULL, 'Definitions- und Zielraum stimmen überein.', 'checked', 31),
(843, '3.110', 13, 'Rekursive Operatorwirkung', 'x_{n+1}=T(x_n)', 'x_{n+1}=T(x_n)', 'Ein Folgezustand entsteht durch Operatoranwendung.', 'model', 'literature', 35, NULL, 'x_n\\in X.', 'checked', 31),
(844, '3.111', 13, 'Iterierte Operatorwirkung', 'x_n=T^n(x_0)', 'x_n=T^n(x_0)', 'n-fache Komposition eines Operators.', 'derived', 'literature', 35, NULL, 'n\\in\\mathbb N.', 'checked', 31),
(845, '3.112', 13, 'Definitionsbereich', '\\mathcal{D}(T)\\subseteq X', '\\mathcal{D}(T)\\subseteq X', 'Tatsächlicher Definitionsbereich eines Operators.', 'definition', 'literature', 36, NULL, 'T ist möglicherweise nicht auf ganz X definiert.', 'checked', 31),
(846, '3.113', 13, 'Operator mit explizitem Definitionsbereich', 'T:\\mathcal{D}(T)\\longrightarrow Y', 'T:\\mathcal{D}(T)\\longrightarrow Y', 'Operatorabbildung mit eingeschränkter Domäne.', 'definition', 'literature', 36, NULL, '\\mathcal{D}(T)\\subseteq X.', 'checked', 31),
(847, '3.114', 13, 'Wertebereich eines Operators', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}\\subseteq Y', '\\mathcal{R}(T)=\\{T(x)\\mid x\\in\\mathcal{D}(T)\\}\\subseteq Y', 'Menge aller tatsächlich erzeugten Operatorbilder.', 'definition', 'literature', 36, NULL, NULL, 'checked', 31),
(848, '3.115', 13, 'Linearitätsbedingung', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'Erhalt von Linearkombinationen.', 'definition', 'literature', 132, NULL, 'X und Y sind Vektorräume über demselben Körper.', 'checked', 31),
(849, '3.116', 13, 'Additivität', 'T(x+y)=T(x)+T(y)', 'T(x+y)=T(x)+T(y)', 'Erhalt der Vektoraddition.', 'derived', 'literature', 132, NULL, 'T ist linear.', 'checked', 31),
(850, '3.117', 13, 'Homogenität', 'T(\\alpha x)=\\alpha T(x)', 'T(\\alpha x)=\\alpha T(x)', 'Erhalt der Skalarmultiplikation.', 'derived', 'literature', 132, NULL, 'T ist linear.', 'checked', 31),
(851, '3.118', 13, 'Kern eines Operators', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', '\\ker(T)=\\{x\\in X\\mid T(x)=0\\}', 'Menge aller auf Null abgebildeten Elemente.', 'definition', 'literature', 132, NULL, 'T ist linear.', 'checked', 31),
(852, '3.119', 13, 'Bild eines Operators', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', '\\operatorname{im}(T)=\\{T(x)\\mid x\\in X\\}', 'Menge aller erreichbaren Operatorbilder.', 'definition', 'literature', 132, NULL, 'T ist linear.', 'checked', 31),
(853, '3.120', 13, 'Kern und Bild als Unterräume', '\\ker(T)\\leq X\\qquad\\text{und}\\qquad\\operatorname{im}(T)\\leq Y', '\\ker(T)\\leq X\\qquad\\text{und}\\qquad\\operatorname{im}(T)\\leq Y', 'Kern und Bild linearer Operatoren sind Unterräume.', 'theorem', 'literature', 132, NULL, 'T ist linear.', 'checked', 31),
(854, '3.121', 13, 'Injektivitätskriterium', '\\ker(T)=\\{0\\}', '\\ker(T)=\\{0\\}', 'Ein linearer Operator ist genau dann injektiv, wenn sein Kern trivial ist.', 'theorem', 'literature', 132, NULL, 'T ist linear.', 'checked', 31),
(855, '3.122', 13, 'Surjektivitätskriterium', '\\operatorname{im}(T)=Y', '\\operatorname{im}(T)=Y', 'Ein Operator ist surjektiv, wenn sein Bild dem Zielraum entspricht.', 'definition', 'literature', 132, NULL, NULL, 'checked', 31),
(856, '3.123', 13, 'Operatorenkomposition', '(S\\circ T)(x)=S(T(x))', '(S\\circ T)(x)=S(T(x))', 'Aufeinanderfolgende Anwendung zweier Operatoren.', 'definition', 'literature', 35, NULL, 'T:X\\to Y und S:Y\\to Z.', 'checked', 31),
(857, '3.124', 13, 'Abbildungstyp der Komposition', 'S\\circ T:X\\longrightarrow Z', 'S\\circ T:X\\longrightarrow Z', 'Komposition als Operator von X nach Z.', 'derived', 'literature', 35, NULL, 'Kompatible Definitions- und Zielräume.', 'checked', 31),
(858, '3.125', 13, 'Assoziativität der Komposition', 'R\\circ(S\\circ T)=(R\\circ S)\\circ T', 'R\\circ(S\\circ T)=(R\\circ S)\\circ T', 'Assoziativität der Operatorverkettung.', 'theorem', 'literature', 35, NULL, 'Kompositionen sind definiert.', 'checked', 31),
(859, '3.126', 13, 'Nichtkommutativität', 'S\\circ T\\neq T\\circ S', 'S\\circ T\\neq T\\circ S', 'Operatorenkomposition ist im Allgemeinen nicht kommutativ.', 'other', 'literature', 35, NULL, 'Beide Kompositionen sind definiert.', 'checked', 31),
(860, '3.127', 13, 'Identitätsoperator', 'I_X:X\\longrightarrow X', 'I_X:X\\longrightarrow X', 'Identitätsoperator auf X.', 'definition', 'literature', 35, NULL, NULL, 'checked', 31),
(861, '3.128', 13, 'Wirkung des Identitätsoperators', 'I_X(x)=x', 'I_X(x)=x', 'Der Identitätsoperator lässt jedes Element unverändert.', 'definition', 'literature', 35, NULL, 'x\\in X.', 'checked', 31),
(862, '3.129', 13, 'Neutralität des Identitätsoperators', 'T\\circ I_X=T=I_Y\\circ T', 'T\\circ I_X=T=I_Y\\circ T', 'Identitätsoperator als neutrales Element der Komposition.', 'theorem', 'literature', 35, NULL, 'T:X\\to Y.', 'checked', 31),
(863, '3.130', 13, 'Linksinverse', 'T^{-1}\\circ T=I_X', 'T^{-1}\\circ T=I_X', 'Linksinverse hebt T auf X auf.', 'definition', 'literature', 35, NULL, 'T ist invertierbar.', 'checked', 31),
(864, '3.131', 13, 'Rechtsinverse', 'T\\circ T^{-1}=I_Y', 'T\\circ T^{-1}=I_Y', 'Rechtsinverse hebt T auf Y auf.', 'definition', 'literature', 35, NULL, 'T ist invertierbar.', 'checked', 31),
(865, '3.132', 13, 'Endomorphismenmenge', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', '\\operatorname{End}(V)=\\{T:V\\longrightarrow V\\mid T\\text{ linear}\\}', 'Menge aller linearen Endomorphismen von V.', 'definition', 'literature', 36, NULL, 'V ist ein Vektorraum.', 'checked', 31),
(866, '3.133', 13, 'Addition von Operatoren', '(S+T)(x)=S(x)+T(x)', '(S+T)(x)=S(x)+T(x)', 'Punktweise Addition linearer Operatoren.', 'definition', 'literature', 36, NULL, 'S und T sind lineare Operatoren V nach V.', 'checked', 31),
(867, '3.134', 13, 'Skalarmultiplikation von Operatoren', '(\\lambda T)(x)=\\lambda T(x)', '(\\lambda T)(x)=\\lambda T(x)', 'Punktweise Skalarmultiplikation eines Operators.', 'definition', 'literature', 36, NULL, '\\lambda liegt im Skalarkörper.', 'checked', 31),
(868, '3.135', 13, 'Spektrum eines Operators', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', '\\sigma(T)=\\{\\lambda\\in\\mathbb C\\mid T-\\lambda I\\text{ ist nicht invertierbar}\\}', 'Spektrum als Menge der Nichtinvertierbarkeitswerte.', 'definition', 'literature', 11, NULL, 'T ist ein geeigneter linearer Operator.', 'checked', 31),
(869, '3.136', 14, 'Zustand im Zustandsraum', 'x\\in X', 'x\\in X', 'Ein Zustand x ist Element des Zustandsraumes X.', 'definition', 'literature', 133, NULL, 'X ist ein nichtleerer Zustandsraum.', 'checked', 38),
(870, '3.137', 14, 'Zustandsvektor', 'x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n\\\\\\end{pmatrix}', 'x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n\\\\\\end{pmatrix}', 'Darstellung eines n-dimensionalen Zustandes als Spaltenvektor.', 'definition', 'literature', 133, NULL, 'Das System besitzt n Zustandsgrößen.', 'checked', 38),
(871, '3.138', 14, 'Endlichdimensionaler Zustandsraum', 'X\\subseteq\\mathbb{R}^{n}', 'X\\subseteq\\mathbb{R}^{n}', 'Zulässiger Zustandsraum als Teilmenge des reellen n-dimensionalen Raumes.', 'definition', 'literature', 133, NULL, 'Endlichdimensionale reelle Zustandsbeschreibung.', 'checked', 38),
(872, '3.139', 14, 'Übergangsabbildung', 'F:X\\longrightarrow X', 'F:X\\longrightarrow X', 'Abbildung eines Zustandes auf einen Folgezustand desselben Zustandsraumes.', 'definition', 'literature', 38, NULL, 'Vollständige Zustandsbeschreibung und deterministische Übergangsregel.', 'checked', 38),
(873, '3.140', 14, 'Diskreter Zustandsübergang', 'x_{k+1}=F(x_k)', 'x_{k+1}=F(x_k)', 'Rekursive Erzeugung des Folgezustandes aus dem aktuellen Zustand.', 'model', 'literature', 38, NULL, 'Diskrete deterministische Dynamik.', 'checked', 38),
(874, '3.141', 14, 'Zulässige Zustände mit Gleichungsnebenbedingung', 'X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)=0\\right\\}', 'X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)=0\\right\\}', 'Zulässige Zustände unter einer Gleichungsnebenbedingung.', 'definition', 'literature', 38, NULL, 'g ist eine geeignete Nebenbedingungsabbildung.', 'checked', 38),
(875, '3.142', 14, 'Zulässige Zustände mit Ungleichungsnebenbedingung', 'X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)\\leq0\\right\\}', 'X_{\\mathrm{zul}}=\\left\\{x\\in X\\mid g(x)\\leq0\\right\\}', 'Zulässige Zustände unter einer Ungleichungsnebenbedingung.', 'definition', 'literature', 38, NULL, 'g ist eine geeignete Nebenbedingungsabbildung.', 'checked', 38),
(876, '3.143', 14, 'Diskrete Zustandsfolge', 'x_0,x_1,x_2,\\ldots', 'x_0,x_1,x_2,\\ldots', 'Geordnete Folge diskreter Zustände.', 'schema', 'literature', 40, NULL, 'Diskrete Zeitindizes k∈N.', 'checked', 38),
(877, '3.144', 14, 'Rekursive diskrete Dynamik', 'x_{k+1}=F(x_k)', 'x_{k+1}=F(x_k)', 'Erneute Darstellung der rekursiven Zustandsentwicklung im Kontext diskreter Systeme.', 'model', 'literature', 40, NULL, 'Diskrete deterministische Dynamik.', 'checked', 38),
(878, '3.145', 14, 'Iterierte Zustandsentwicklung', 'x_k=F^{\\,k}(x_0)', 'x_k=F^{\\,k}(x_0)', 'Zustand nach k-facher Iteration der Übergangsabbildung.', 'derived', 'literature', 40, NULL, 'F ist k-fach kompositionsfähig.', 'checked', 38),
(879, '3.146', 14, 'Zeitabhängige Zustandsfunktion', 'x:I\\longrightarrow X', 'x:I\\longrightarrow X', 'Zuordnung eines Zustandes zu jedem Zeitpunkt eines Intervalls I.', 'definition', 'literature', 134, NULL, 'I ist ein reelles Zeitintervall.', 'checked', 38),
(880, '3.147', 14, 'Zeitliche Ableitung des Zustandes', '\\dot{x}(t)=\\frac{dx(t)}{dt}', '\\dot{x}(t)=\\frac{dx(t)}{dt}', 'Ableitung der Zustandsfunktion nach der Zeit.', 'definition', 'literature', 134, NULL, 'x ist differenzierbar.', 'checked', 38),
(881, '3.148', 14, 'Nichtautonome Zustandsgleichung', '\\dot{x}(t)=F(x(t),t)', '\\dot{x}(t)=F(x(t),t)', 'Allgemeines zeitabhängiges Entwicklungsgesetz.', 'model', 'literature', 134, NULL, 'F ist hinreichend regulär.', 'checked', 38),
(882, '3.149', 14, 'Autonome Zustandsgleichung', '\\dot{x}=F(x)', '\\dot{x}=F(x)', 'Zeitinvariante kontinuierliche Zustandsentwicklung.', 'model', 'literature', 134, NULL, 'F hängt nicht explizit von t ab.', 'checked', 38),
(883, '3.150', 14, 'Anfangsbedingung', 'x(t_0)=x_0', 'x(t_0)=x_0', 'Festlegung des Anfangszustandes zum Zeitpunkt t0.', 'definition', 'literature', 134, NULL, 'x0 liegt im Zustandsraum.', 'checked', 38),
(884, '3.151', 14, 'Anfangswertproblem', '\\left\\{\\begin{array}{l}\\dot{x}=F(x,t)\\\\x(t_0)=x_0\\end{array}\\right.', '\\left\\{\\begin{array}{l}\\dot{x}=F(x,t)\\\\x(t_0)=x_0\\end{array}\\right.', 'Kombination aus Entwicklungsgleichung und Anfangsbedingung.', 'model', 'literature', 134, NULL, 'Existenz- und Eindeutigkeitsbedingungen sind gesondert zu prüfen.', 'checked', 38),
(885, '3.152', 14, 'Flussabbildung', '\\Phi:\\mathbb{R}\\times X\\longrightarrow X', '\\Phi:\\mathbb{R}\\times X\\longrightarrow X', 'Fluss als zeitparametrisierte Zustandsabbildung.', 'definition', 'literature', 134, NULL, 'Globale Definition des Flusses vorausgesetzt.', 'checked', 38),
(886, '3.153', 14, 'Fluss und Lösung', '\\Phi(t,x_0)=x(t)', '\\Phi(t,x_0)=x(t)', 'Zuordnung der Lösungskurve zum Anfangszustand.', 'definition', 'literature', 134, NULL, 'x(t) ist Lösung des Anfangswertproblems.', 'checked', 38),
(887, '3.154', 14, 'Identität des Flusses', '\\Phi(0,x)=x', '\\Phi(0,x)=x', 'Der Fluss lässt den Zustand bei Zeitparameter Null unverändert.', 'definition', 'literature', 134, NULL, 'Flussstruktur.', 'checked', 38),
(888, '3.155', 14, 'Flusseigenschaft', '\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)', '\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)', 'Kompositionsgesetz zeitlicher Entwicklungen.', 'definition', 'literature', 134, NULL, 'Kompatible Existenzintervalle.', 'checked', 38),
(889, '3.156', 14, 'Trajektorie', '\\gamma(x_0)=\\left\\{\\Phi(t,x_0)\\mid t\\in I\\right\\}', '\\gamma(x_0)=\\left\\{\\Phi(t,x_0)\\mid t\\in I\\right\\}', 'Menge aller entlang des Flusses erreichten Zustände.', 'definition', 'literature', 40, NULL, 'I ist das betrachtete Zeitintervall.', 'checked', 38),
(890, '3.157', 14, 'Gleichgewichtspunkt', 'F(x^\\ast)=0', 'F(x^\\ast)=0', 'Ein Gleichgewichtspunkt ist eine Nullstelle des Vektorfeldes.', 'definition', 'literature', 39, NULL, 'Autonomes dynamisches System.', 'checked', 38),
(891, '3.158', 14, 'Invarianz eines Gleichgewichtspunktes', '\\Phi(t,x^\\ast)=x^\\ast', '\\Phi(t,x^\\ast)=x^\\ast', 'Ein Gleichgewichtspunkt bleibt unter dem Fluss unverändert.', 'derived', 'literature', 39, NULL, 'x* ist Gleichgewichtspunkt.', 'checked', 38),
(892, '3.159', 15, 'Positive Invarianz', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\geq0', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\geq0', 'Positive Invarianz.', 'definition', 'literature', 136, NULL, NULL, 'checked', 39),
(893, '3.160', 15, 'Invarianz', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\in\\mathbb{R}', 'x_0\\in M\\Longrightarrow\\Phi(t,x_0)\\in M\\qquad\\forall t\\in\\mathbb{R}', 'Invarianz.', 'definition', 'literature', 136, NULL, NULL, 'checked', 39),
(894, '3.161', 15, 'Invarianz eines Gleichgewichtspunktes', '\\Phi(t,x^\\ast)=x^\\ast\\qquad\\forall t', '\\Phi(t,x^\\ast)=x^\\ast\\qquad\\forall t', 'Invarianz eines Gleichgewichtspunktes.', 'derived', 'literature', 134, NULL, NULL, 'checked', 39),
(895, '3.162', 15, 'Einelementige invariante Menge', '\\left\\{x^\\ast\\right\\}', '\\left\\{x^\\ast\\right\\}', 'Einelementige invariante Menge.', 'definition', 'literature', 134, NULL, NULL, 'checked', 39),
(896, '3.163', 15, 'Lyapunov-Stabilität', '\\forall\\varepsilon>0\\;\\exists\\delta>0:\\left\\|x_0-x^\\ast\\right\\|<\\delta\\Longrightarrow\\left\\|\\Phi(t,x_0)-x^\\ast\\right\\|<\\varepsilon\\quad\\forall t\\geq0', '\\forall\\varepsilon>0\\;\\exists\\delta>0:\\left\\|x_0-x^\\ast\\right\\|<\\delta\\Longrightarrow\\left\\|\\Phi(t,x_0)-x^\\ast\\right\\|<\\varepsilon\\quad\\forall t\\geq0', 'Lyapunov-Stabilität.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(897, '3.164', 15, 'Attraktivität', '\\exists r>0:\\left\\|x_0-x^\\ast\\right\\|<r\\Longrightarrow\\lim_{t\\rightarrow\\infty}\\Phi(t,x_0)=x^\\ast', '\\exists r>0:\\left\\|x_0-x^\\ast\\right\\|<r\\Longrightarrow\\lim_{t\\rightarrow\\infty}\\Phi(t,x_0)=x^\\ast', 'Attraktivität.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(898, '3.165', 15, 'Asymptotische Stabilität', 'x^\\ast\\text{ ist asymptotisch stabil}\\Longleftrightarrow x^\\ast\\text{ ist stabil und attraktiv}', 'x^\\ast\\text{ ist asymptotisch stabil}\\Longleftrightarrow x^\\ast\\text{ ist stabil und attraktiv}', 'Asymptotische Stabilität.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(899, '3.166', 15, 'Globale asymptotische Stabilität', '\\forall x_0\\in X:\\lim_{t\\rightarrow\\infty}\\Phi(t,x_0)=x^\\ast', '\\forall x_0\\in X:\\lim_{t\\rightarrow\\infty}\\Phi(t,x_0)=x^\\ast', 'Globale asymptotische Stabilität.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(900, '3.167', 15, 'Lyapunov-Funktion', 'V:X\\longrightarrow\\mathbb{R}', 'V:X\\longrightarrow\\mathbb{R}', 'Lyapunov-Funktion.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(901, '3.168', 15, 'Nullwert der Lyapunov-Funktion', 'V(x^\\ast)=0', 'V(x^\\ast)=0', 'Nullwert der Lyapunov-Funktion.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(902, '3.169', 15, 'Positive Definitheit', 'V(x)>0\\qquad\\forall x\\neq x^\\ast', 'V(x)>0\\qquad\\forall x\\neq x^\\ast', 'Positive Definitheit.', 'definition', 'literature', 135, NULL, NULL, 'checked', 39),
(903, '3.170', 15, 'Ableitung der Lyapunov-Funktion', '\\dot{V}(x)=\\nabla V(x)^{T}F(x)', '\\dot{V}(x)=\\nabla V(x)^{T}F(x)', 'Ableitung der Lyapunov-Funktion.', 'derived', 'literature', 135, NULL, NULL, 'checked', 39),
(904, '3.171', 15, 'Nichtzunahme der Lyapunov-Funktion', '\\dot{V}(x)\\leq0', '\\dot{V}(x)\\leq0', 'Nichtzunahme der Lyapunov-Funktion.', 'theorem', 'literature', 135, NULL, NULL, 'checked', 39),
(905, '3.172', 15, 'Strikte Abnahme der Lyapunov-Funktion', '\\dot{V}(x)<0\\qquad\\forall x\\neq x^\\ast', '\\dot{V}(x)<0\\qquad\\forall x\\neq x^\\ast', 'Strikte Abnahme der Lyapunov-Funktion.', 'theorem', 'literature', 135, NULL, NULL, 'checked', 39),
(906, '3.173', 15, 'Invarianz eines Attraktors', '\\Phi(t,A)=A\\qquad\\forall t\\geq0', '\\Phi(t,A)=A\\qquad\\forall t\\geq0', 'Invarianz eines Attraktors.', 'definition', 'literature', 137, NULL, NULL, 'checked', 39),
(907, '3.174', 15, 'Attraktion zum Attraktor', '\\forall x_0\\in B(A):\\operatorname{dist}(\\Phi(t,x_0),A)\\longrightarrow0\\quad(t\\rightarrow\\infty)', '\\forall x_0\\in B(A):\\operatorname{dist}(\\Phi(t,x_0),A)\\longrightarrow0\\quad(t\\rightarrow\\infty)', 'Attraktion zum Attraktor.', 'definition', 'literature', 137, NULL, NULL, 'checked', 39),
(908, '3.175', 15, 'Einzugsgebiet', 'B(A)=\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi(t,x_0),A)\\rightarrow0\\}', 'B(A)=\\{x_0\\in X\\mid\\operatorname{dist}(\\Phi(t,x_0),A)\\rightarrow0\\}', 'Einzugsgebiet.', 'definition', 'literature', 137, NULL, NULL, 'checked', 39),
(909, '3.176', 15, 'Punktattraktor', 'A=\\{x^\\ast\\}', 'A=\\{x^\\ast\\}', 'Punktattraktor.', 'definition', 'literature', 137, NULL, NULL, 'checked', 39),
(910, '3.177', 15, 'Periodische Lösung', 'x(t+T)=x(t)', 'x(t+T)=x(t)', 'Periodische Lösung.', 'definition', 'literature', 40, NULL, NULL, 'checked', 39),
(911, '3.178', 15, 'Torusattraktor', '\\mathbb{T}^{n}', '\\mathbb{T}^{n}', 'Torusattraktor.', 'definition', 'literature', 40, NULL, NULL, 'checked', 39),
(912, '3.179', 15, 'Exponentielle Störungsentwicklung', '\\|\\delta x(t)\\|\\approx\\|\\delta x(0)\\|e^{\\lambda t}', '\\|\\delta x(t)\\|\\approx\\|\\delta x(0)\\|e^{\\lambda t}', 'Exponentielle Störungsentwicklung.', 'model', 'literature', 137, NULL, NULL, 'checked', 39),
(913, '3.180', 15, 'Positiver Lyapunov-Exponent', '\\lambda>0', '\\lambda>0', 'Positiver Lyapunov-Exponent.', 'definition', 'literature', 137, NULL, NULL, 'checked', 39),
(914, '3.181', 15, 'Omega-Grenzmenge', '\\omega(x_0)=\\{y\\in X\\mid\\exists t_n\\rightarrow\\infty:\\Phi(t_n,x_0)\\rightarrow y\\}', '\\omega(x_0)=\\{y\\in X\\mid\\exists t_n\\rightarrow\\infty:\\Phi(t_n,x_0)\\rightarrow y\\}', 'Omega-Grenzmenge.', 'definition', 'literature', 40, NULL, NULL, 'checked', 39),
(915, '3.182', 15, 'LaSalle-Bedingung', '\\dot V\\le0', '\\dot V\\le0', 'LaSalle-Bedingung.', 'theorem', 'literature', 136, NULL, NULL, 'checked', 39),
(916, '3.183', 15, 'LaSalle-Nullmengenbedingung', '\\{x\\mid\\dot V(x)=0\\}', '\\{x\\mid\\dot V(x)=0\\}', 'LaSalle-Nullmengenbedingung.', 'theorem', 'literature', 136, NULL, NULL, 'checked', 39),
(917, '3.184', 16, 'Parameterabhängiges nichtlineares System', '\\dot{x}=F(x,\\mu)', '\\dot{x}=F(x,\\mu)', 'Allgemeines kontinuierliches dynamisches System mit Kontrollparameter.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(918, '3.185', 16, 'Lineares parameterabhängiges System', '\\dot{x}=A(\\mu)x', '\\dot{x}=A(\\mu)x', 'Lineare Dynamik mit parameterabhängiger Systemmatrix.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(919, '3.186', 16, 'Zerlegung in linearen und nichtlinearen Anteil', '\\dot{x}=A(\\mu)x+N(x,\\mu)', '\\dot{x}=A(\\mu)x+N(x,\\mu)', 'Darstellung eines nichtlinearen Systems als linearer Anteil plus Nichtlinearität.', 'model', 'literature', 139, NULL, NULL, 'checked', 40),
(920, '3.187', 16, 'Verletzung des Superpositionsprinzips', 'F(\\alpha x_1+\\beta x_2,\\mu)\\neq\\alpha F(x_1,\\mu)+\\beta F(x_2,\\mu)', 'F(\\alpha x_1+\\beta x_2,\\mu)\\neq\\alpha F(x_1,\\mu)+\\beta F(x_2,\\mu)', 'Kennzeichen eines nichtlinearen Entwicklungsgesetzes.', 'definition', 'literature', 139, NULL, NULL, 'checked', 40),
(921, '3.188', 16, 'Parameterabhängiger Gleichgewichtspunkt', 'F(x^\\ast,\\mu)=0', 'F(x^\\ast,\\mu)=0', 'Gleichgewichtsbedingung eines parameterabhängigen Systems.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(922, '3.189', 16, 'Gleichgewichtsverzweigung', 'x^\\ast=x^\\ast(\\mu)', 'x^\\ast=x^\\ast(\\mu)', 'Abhängigkeit eines Gleichgewichtspunktes vom Kontrollparameter.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(923, '3.190', 16, 'Lokale Abweichung vom Gleichgewicht', '\\xi=x-x^\\ast', '\\xi=x-x^\\ast', 'Lokale Koordinate relativ zum Gleichgewichtspunkt.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40),
(924, '3.191', 16, 'Taylorentwicklung des Vektorfeldes', 'F(x^\\ast+\\xi,\\mu)=F(x^\\ast,\\mu)+D_xF(x^\\ast,\\mu)\\xi+\\mathcal{O}\\!\\left(\\|\\xi\\|^2\\right)', 'F(x^\\ast+\\xi,\\mu)=F(x^\\ast,\\mu)+D_xF(x^\\ast,\\mu)\\xi+\\mathcal{O}\\!\\left(\\|\\xi\\|^2\\right)', 'Lokale Taylorentwicklung des nichtlinearen Vektorfeldes.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(925, '3.192', 16, 'Linearisierte Dynamik', '\\dot{\\xi}=J(x^\\ast,\\mu)\\xi', '\\dot{\\xi}=J(x^\\ast,\\mu)\\xi', 'Linearisierung in der Umgebung eines Gleichgewichtspunktes.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(926, '3.193', 16, 'Jacobi-Matrix', 'J(x^\\ast,\\mu)=D_xF(x^\\ast,\\mu)', 'J(x^\\ast,\\mu)=D_xF(x^\\ast,\\mu)', 'Definition der Jacobi-Matrix des Vektorfeldes.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40),
(927, '3.194', 16, 'Lokale asymptotische Stabilitätsbedingung', '\\operatorname{Re}(\\lambda_i)<0\\qquad\\forall i', '\\operatorname{Re}(\\lambda_i)<0\\qquad\\forall i', 'Negativer Realteil aller Eigenwerte als lokale Stabilitätsbedingung.', 'theorem', 'literature', 139, NULL, NULL, 'checked', 40),
(928, '3.195', 16, 'Lokale Instabilitätsbedingung', '\\exists i:\\operatorname{Re}(\\lambda_i)>0', '\\exists i:\\operatorname{Re}(\\lambda_i)>0', 'Positiver Realteil mindestens eines Eigenwertes als Instabilitätskriterium.', 'theorem', 'literature', 139, NULL, NULL, 'checked', 40),
(929, '3.196', 16, 'Kritischer Parameterwert', '\\exists i:\\operatorname{Re}\\left(\\lambda_i(\\mu_c)\\right)=0', '\\exists i:\\operatorname{Re}\\left(\\lambda_i(\\mu_c)\\right)=0', 'Spektrale Bedingung eines kritischen Parameterwertes.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40),
(930, '3.197', 16, 'Qualitative Änderung der Dynamik', '\\Phi_{\\mu_c-\\varepsilon}\\not\\sim\\Phi_{\\mu_c+\\varepsilon}\\qquad\\text{für hinreichend kleines }\\varepsilon>0', '\\Phi_{\\mu_c-\\varepsilon}\\not\\sim\\Phi_{\\mu_c+\\varepsilon}\\qquad\\text{für hinreichend kleines }\\varepsilon>0', 'Nichtäquivalenz der Dynamiken beiderseits eines Bifurkationswertes.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40),
(931, '3.198', 16, 'Normalform der Sattel-Knoten-Bifurkation', '\\dot{x}=\\mu-x^2', '\\dot{x}=\\mu-x^2', 'Normalform einer Sattel-Knoten-Bifurkation.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(932, '3.199', 16, 'Gleichgewichtsbedingung der Sattel-Knoten-Bifurkation', '\\mu-x^2=0', '\\mu-x^2=0', 'Stationäre Bedingung der Sattel-Knoten-Normalform.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(933, '3.200', 16, 'Gleichgewichte der Sattel-Knoten-Bifurkation', 'x^\\ast=\\pm\\sqrt{\\mu}', 'x^\\ast=\\pm\\sqrt{\\mu}', 'Gleichgewichtslösungen der Sattel-Knoten-Normalform.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(934, '3.201', 16, 'Normalform der transkritischen Bifurkation', '\\dot{x}=\\mu x-x^2', '\\dot{x}=\\mu x-x^2', 'Normalform einer transkritischen Bifurkation.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(935, '3.202', 16, 'Erstes transkritisches Gleichgewicht', 'x^\\ast=0', 'x^\\ast=0', 'Trivialer Gleichgewichtszweig der transkritischen Bifurkation.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(936, '3.203', 16, 'Zweites transkritisches Gleichgewicht', 'x^\\ast=\\mu', 'x^\\ast=\\mu', 'Nichttrivialer Gleichgewichtszweig der transkritischen Bifurkation.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(937, '3.204', 16, 'Normalform der Pitchfork-Bifurkation', '\\dot{x}=\\mu x-x^3', '\\dot{x}=\\mu x-x^3', 'Überkritische Pitchfork-Normalform.', 'model', 'literature', 138, NULL, NULL, 'checked', 40),
(938, '3.205', 16, 'Faktorisierte Gleichgewichtsbedingung der Pitchfork-Bifurkation', 'x\\left(\\mu-x^2\\right)=0', 'x\\left(\\mu-x^2\\right)=0', 'Faktorisierte stationäre Bedingung der Pitchfork-Normalform.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(939, '3.206', 16, 'Zentrales Pitchfork-Gleichgewicht', 'x^\\ast=0', 'x^\\ast=0', 'Zentraler Gleichgewichtszweig der Pitchfork-Bifurkation.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(940, '3.207', 16, 'Symmetriegebrochene Pitchfork-Gleichgewichte', 'x^\\ast=\\pm\\sqrt{\\mu}', 'x^\\ast=\\pm\\sqrt{\\mu}', 'Neue Gleichgewichtszweige nach der Symmetriebrechung.', 'derived', 'literature', 138, NULL, NULL, 'checked', 40),
(941, '3.208', 16, 'Normalform der Hopf-Bifurkation', '\\dot{z}=(\\mu+i\\omega)z-|z|^2z', '\\dot{z}=(\\mu+i\\omega)z-|z|^2z', 'Komplexe Normalform einer überkritischen Hopf-Bifurkation.', 'model', 'literature', 139, NULL, NULL, 'checked', 40),
(942, '3.209', 16, 'Kritischer Parameter', '\\mu_c', '\\mu_c', 'Bezeichnung des kritischen Parameterwertes.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40),
(943, '3.210', 16, 'Spektrale Bifurkationsbedingung', '\\operatorname{Re}\\left(\\lambda(\\mu_c)\\right)=0', '\\operatorname{Re}\\left(\\lambda(\\mu_c)\\right)=0', 'Eigenwertbedingung am Bifurkationspunkt.', 'definition', 'literature', 138, NULL, NULL, 'checked', 40),
(944, '3.211', 16, 'Wechsel der Attraktormenge', 'A(\\mu^-)\\neq A(\\mu^+)', 'A(\\mu^-)\\neq A(\\mu^+)', 'Qualitative Änderung der asymptotischen Organisationsform.', 'model', 'literature', 137, NULL, NULL, 'checked', 40),
(945, '3.212', 17, 'Alphabet der Zufallsvariablen', '\\mathcal{X}=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', '\\mathcal{X}=\\left\\{x_1,x_2,\\ldots,x_n\\right\\}', 'Menge möglicher Werte einer diskreten Zufallsvariablen.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(946, '3.213', 17, 'Ereigniswahrscheinlichkeit', 'p_i=P(X=x_i)', 'p_i=P(X=x_i)', 'Wahrscheinlichkeit des Ereignisses X=x_i.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(947, '3.214', 17, 'Nichtnegativität der Wahrscheinlichkeiten', 'p_i\\geq0\\qquad\\forall i', 'p_i\\geq0\\qquad\\forall i', 'Nichtnegativitätsbedingung diskreter Wahrscheinlichkeiten.', 'axiom', 'literature', 140, NULL, NULL, 'checked', 41),
(948, '3.215', 17, 'Normierung der Wahrscheinlichkeitsverteilung', '\\sum_{i=1}^{n}p_i=1', '\\sum_{i=1}^{n}p_i=1', 'Normierungsbedingung einer diskreten Wahrscheinlichkeitsverteilung.', 'axiom', 'literature', 140, NULL, NULL, 'checked', 41),
(949, '3.216', 17, 'Selbstinformation', 'I(x_i)=-\\log_b p_i', 'I(x_i)=-\\log_b p_i', 'Informationsgehalt eines Ereignisses mit Wahrscheinlichkeit p_i.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(950, '3.217', 17, 'Bit als Informationseinheit', 'b=2', 'b=2', 'Logarithmusbasis zwei definiert die Einheit Bit.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(951, '3.218', 17, 'Information eines sicheren Ereignisses', 'P(X=x_i)=1\\Longrightarrow I(x_i)=0', 'P(X=x_i)=1\\Longrightarrow I(x_i)=0', 'Ein sicheres Ereignis liefert keinen zusätzlichen Informationsgewinn.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(952, '3.219', 17, 'Monotonie der Selbstinformation', 'p_i<p_j\\Longrightarrow I(x_i)>I(x_j)', 'p_i<p_j\\Longrightarrow I(x_i)>I(x_j)', 'Seltenere Ereignisse besitzen einen höheren Selbstinformationswert.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(953, '3.220', 17, 'Unabhängigkeit zweier Ereignisse', 'P(x_i,y_j)=P(x_i)P(y_j)', 'P(x_i,y_j)=P(x_i)P(y_j)', 'Faktorisierung der gemeinsamen Wahrscheinlichkeit unabhängiger Ereignisse.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(954, '3.221', 17, 'Additivität unabhängiger Informationen', 'I(x_i,y_j)=I(x_i)+I(y_j)', 'I(x_i,y_j)=I(x_i)+I(y_j)', 'Informationsgehalte unabhängiger Ereignisse addieren sich.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(955, '3.222', 17, 'Entropie als Erwartungswert', 'H(X)=\\mathbb{E}\\left[I(X)\\right]', 'H(X)=\\mathbb{E}\\left[I(X)\\right]', 'Shannon-Entropie als Erwartungswert der Selbstinformation.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(956, '3.223', 17, 'Diskrete Shannon-Entropie', 'H(X)=-\\sum_{i=1}^{n}p_i\\log_b p_i', 'H(X)=-\\sum_{i=1}^{n}p_i\\log_b p_i', 'Mittlere Unbestimmtheit einer diskreten Zufallsvariablen.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(957, '3.224', 17, 'Entropie eines sicheren Ereignisses', 'H(X)=0', 'H(X)=0', 'Eine deterministische Zufallsvariable besitzt keine Shannon-Entropie.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(958, '3.225', 17, 'Gleichverteilung', 'p_i=\\frac{1}{n}\\qquad\\forall i', 'p_i=\\frac{1}{n}\\qquad\\forall i', 'Gleichverteilung über n mögliche Zustände.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(959, '3.226', 17, 'Maximale Entropie der Gleichverteilung', 'H(X)=\\log_b n', 'H(X)=\\log_b n', 'Maximale Entropie einer diskreten Zufallsvariablen mit n Zuständen.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(960, '3.227', 17, 'Gemeinsame Wahrscheinlichkeitsverteilung', 'p(x_i,y_j)=P(X=x_i,Y=y_j)', 'p(x_i,y_j)=P(X=x_i,Y=y_j)', 'Gemeinsame Wahrscheinlichkeit zweier diskreter Zufallsvariablen.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(961, '3.228', 17, 'Randverteilung von X', 'p(x_i)=\\sum_j p(x_i,y_j)', 'p(x_i)=\\sum_j p(x_i,y_j)', 'Marginalisierung der gemeinsamen Verteilung über Y.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(962, '3.229', 17, 'Randverteilung von Y', 'p(y_j)=\\sum_i p(x_i,y_j)', 'p(y_j)=\\sum_i p(x_i,y_j)', 'Marginalisierung der gemeinsamen Verteilung über X.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(963, '3.230', 17, 'Gemeinsame Entropie', 'H(X,Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i,y_j)', 'H(X,Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i,y_j)', 'Gemeinsame Unbestimmtheit zweier Zufallsvariablen.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(964, '3.231', 17, 'Additivität der Entropie bei Unabhängigkeit', 'H(X,Y)=H(X)+H(Y)', 'H(X,Y)=H(X)+H(Y)', 'Gemeinsame Entropie unabhängiger Zufallsvariablen.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(965, '3.232', 17, 'Bedingte Entropie', 'H(X|Y)', 'H(X|Y)', 'Verbleibende Unsicherheit von X bei Kenntnis von Y.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(966, '3.233', 17, 'Formel der bedingten Entropie', 'H(X|Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i|y_j)', 'H(X|Y)=-\\sum_i\\sum_j p(x_i,y_j)\\log p(x_i|y_j)', 'Erwartete bedingte Selbstinformation.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(967, '3.234', 17, 'Kettenregel der Entropie I', 'H(X,Y)=H(Y)+H(X|Y)', 'H(X,Y)=H(Y)+H(X|Y)', 'Zerlegung der gemeinsamen Entropie.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(968, '3.235', 17, 'Kettenregel der Entropie II', 'H(X,Y)=H(X)+H(Y|X)', 'H(X,Y)=H(X)+H(Y|X)', 'Symmetrische Zerlegung der gemeinsamen Entropie.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(969, '3.236', 17, 'Gegenseitige Information', 'I(X;Y)=H(X)-H(X|Y)', 'I(X;Y)=H(X)-H(X|Y)', 'Reduktion der Unsicherheit über X durch Kenntnis von Y.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(970, '3.237', 17, 'Symmetrische Darstellung der gegenseitigen Information', 'I(X;Y)=H(X)+H(Y)-H(X,Y)', 'I(X;Y)=H(X)+H(Y)-H(X,Y)', 'Darstellung durch Einzel- und gemeinsame Entropie.', 'derived', 'literature', 140, NULL, NULL, 'checked', 41),
(971, '3.238', 17, 'Symmetrie der gegenseitigen Information', 'I(X;Y)=I(Y;X)', 'I(X;Y)=I(Y;X)', 'Mutual Information ist symmetrisch.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(972, '3.239', 17, 'Kullback-Leibler-Divergenz', 'D_{KL}(P||Q)=\\sum_i P(x_i)\\log\\frac{P(x_i)}{Q(x_i)}', 'D_{KL}(P||Q)=\\sum_i P(x_i)\\log\\frac{P(x_i)}{Q(x_i)}', 'Gerichtetes Divergenzmaß zwischen zwei Wahrscheinlichkeitsverteilungen.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(973, '3.240', 17, 'Nichtnegativität der Kullback-Leibler-Divergenz', 'D_{KL}(P||Q)\\geq0', 'D_{KL}(P||Q)\\geq0', 'Gibbs-Ungleichung.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(974, '3.241', 17, 'Nullbedingung der Kullback-Leibler-Divergenz', 'D_{KL}(P||Q)=0\\Longleftrightarrow P=Q', 'D_{KL}(P||Q)=0\\Longleftrightarrow P=Q', 'Die Divergenz verschwindet genau bei identischen Verteilungen.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(975, '3.242', 17, 'Mischverteilung', 'M=\\frac12(P+Q)', 'M=\\frac12(P+Q)', 'Mittlere Verteilung für die Jensen-Shannon-Divergenz.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(976, '3.243', 17, 'Jensen-Shannon-Divergenz', 'D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)', 'D_{JS}(P,Q)=\\frac12D_{KL}(P||M)+\\frac12D_{KL}(Q||M)', 'Symmetrisierte und geglättete Divergenz zwischen P und Q.', 'definition', 'literature', 140, NULL, NULL, 'checked', 41),
(977, '3.244', 17, 'Symmetrie der Jensen-Shannon-Divergenz', 'D_{JS}(P,Q)=D_{JS}(Q,P)', 'D_{JS}(P,Q)=D_{JS}(Q,P)', 'Die Jensen-Shannon-Divergenz ist symmetrisch.', 'theorem', 'literature', 140, NULL, NULL, 'checked', 41),
(978, '3.245', 18, 'Definition eines Graphen', 'G=(V,E)', 'G=(V,E)', 'Graph als geordnetes Paar aus Knoten- und Kantenmenge.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(979, '3.246', 18, 'Kantenmenge eines gerichteten Graphen', 'E\\subseteq V\\times V', 'E\\subseteq V\\times V', 'Gerichtete Kanten als geordnete Paare von Knoten.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(980, '3.247', 18, 'Gerichtete Kante', '(v_i,v_j)\\in E', '(v_i,v_j)\\in E', 'Gerichtete Relation vom Knoten vi zum Knoten vj.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(981, '3.248', 18, 'Ungerichtete Kante', '\\{v_i,v_j\\}\\in E', '\\{v_i,v_j\\}\\in E', 'Ungerichtete Verbindung zweier Knoten.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(982, '3.249', 18, 'Schleifenfreiheit eines einfachen Graphen', '(v_i,v_i)\\notin E', '(v_i,v_i)\\notin E', 'Ausschluss von Selbstkanten in einfachen Graphen.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(983, '3.250', 18, 'Schleife', '(v_i,v_i)\\in E', '(v_i,v_i)\\in E', 'Selbstkante eines Knotens.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(984, '3.251', 18, 'Adjazenzmatrix', 'A=(a_{ij})\\in\\{0,1\\}^{n\\times n}', 'A=(a_{ij})\\in\\{0,1\\}^{n\\times n}', 'Binäre Matrixdarstellung eines endlichen Graphen.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(985, '3.252', 18, 'Elemente der Adjazenzmatrix', 'a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}', 'a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}', 'Definition der Matrixeinträge durch das Vorliegen einer Kante.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(986, '3.253', 18, 'Potenzen der Adjazenzmatrix', '(A^k)_{ij}', '(A^k)_{ij}', 'Anzahl gerichteter Wege der Länge k von vi nach vj.', 'derived', 'literature', 143, NULL, NULL, 'checked', 47),
(987, '3.254', 18, 'Knotengrad im ungerichteten Graphen', '\\deg(v_i)=\\sum_{j=1}^{n}a_{ij}', '\\deg(v_i)=\\sum_{j=1}^{n}a_{ij}', 'Anzahl der an vi inzidenten Kanten.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(988, '3.255', 18, 'Eingangsgrad', '\\deg^{-}(v_i)=\\sum_{j=1}^{n}a_{ji}', '\\deg^{-}(v_i)=\\sum_{j=1}^{n}a_{ji}', 'Anzahl eingehender Kanten eines Knotens.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(989, '3.256', 18, 'Ausgangsgrad', '\\deg^{+}(v_i)=\\sum_{j=1}^{n}a_{ij}', '\\deg^{+}(v_i)=\\sum_{j=1}^{n}a_{ij}', 'Anzahl ausgehender Kanten eines Knotens.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(990, '3.257', 18, 'Knotenfolge eines Weges', 'v_0,v_1,\\ldots,v_k', 'v_0,v_1,\\ldots,v_k', 'Geordnete Knotenfolge eines Weges.', 'schema', 'literature', 143, NULL, NULL, 'checked', 47),
(991, '3.258', 18, 'Kantenbedingung eines Weges', '(v_i,v_{i+1})\\in E\\qquad\\forall i\\in\\{0,\\ldots,k-1\\}', '(v_i,v_{i+1})\\in E\\qquad\\forall i\\in\\{0,\\ldots,k-1\\}', 'Aufeinanderfolgende Knoten eines Weges sind durch Kanten verbunden.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(992, '3.259', 18, 'Länge eines Weges', 'k', 'k', 'Anzahl der Kanten eines Weges.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(993, '3.260', 18, 'Zyklusbedingung', 'v_0=v_k', 'v_0=v_k', 'Identität von Anfangs- und Endknoten eines Zyklus.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(994, '3.261', 18, 'Graphendistanz', 'd(v_i,v_j)=\\min_{P\\in\\mathcal{P}(v_i,v_j)}|P|', 'd(v_i,v_j)=\\min_{P\\in\\mathcal{P}(v_i,v_j)}|P|', 'Länge eines kürzesten Pfades zwischen zwei Knoten.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(995, '3.262', 18, 'Unendliche Distanz', 'd(v_i,v_j)=\\infty', 'd(v_i,v_j)=\\infty', 'Distanz nicht verbundener Knoten.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(996, '3.263', 18, 'Zusammenhang eines Graphen', '\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal{P}(v_i,v_j)', '\\forall v_i,v_j\\in V\\;\\exists P\\in\\mathcal{P}(v_i,v_j)', 'Existenz eines Pfades zwischen jedem Knotenpaar.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(997, '3.264', 18, 'Gewichtsfunktion', 'w:E\\longrightarrow\\mathbb{R}', 'w:E\\longrightarrow\\mathbb{R}', 'Zuordnung numerischer Kantengewichte.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(998, '3.265', 18, 'Gewichtete Adjazenzmatrix', 'W=(w_{ij})', 'W=(w_{ij})', 'Matrixdarstellung eines gewichteten Graphen.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(999, '3.266', 18, 'Knotenstärke', 's(v_i)=\\sum_{j=1}^{n}w_{ij}', 's(v_i)=\\sum_{j=1}^{n}w_{ij}', 'Summe der Kantengewichte eines Knotens.', 'definition', 'literature', 143, NULL, NULL, 'checked', 47),
(1000, '3.267', 19, 'Gradzentralität', 'C_D(v_i)=\\frac{\\deg(v_i)}{n-1}', 'C_D(v_i)=\\frac{\\deg(v_i)}{n-1}', 'Normierter Anteil unmittelbar erreichbarer Nachbarn eines Knotens.', 'definition', 'literature', 146, NULL, NULL, 'checked', 45),
(1001, '3.268', 19, 'Closeness-Zentralität', 'C_C(v_i)=\\frac{n-1}{\\sum_{j=1}^{n}d(v_i,v_j)}', 'C_C(v_i)=\\frac{n-1}{\\sum_{j=1}^{n}d(v_i,v_j)}', 'Inverse mittlere Entfernung eines Knotens zu allen übrigen Knoten.', 'definition', 'literature', 146, NULL, NULL, 'checked', 45),
(1002, '3.269', 19, 'Betweenness-Zentralität', 'C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}', 'C_B(v)=\\sum_{s\\neq v\\neq t}\\frac{\\sigma_{st}(v)}{\\sigma_{st}}', 'Anteil kürzester Wege, die über einen Knoten verlaufen.', 'definition', 'literature', 146, NULL, NULL, 'checked', 45),
(1003, '3.270', 19, 'Eigenvektor-Zentralität', 'Ax=\\lambda x', 'Ax=\\lambda x', 'Zentralität eines Knotens in Abhängigkeit von der Zentralität seiner Nachbarn.', 'definition', 'literature', 146, NULL, NULL, 'checked', 45),
(1004, '3.271', 19, 'Lokaler Clusterkoeffizient', 'C(v_i)=\\frac{2m_i}{k_i(k_i-1)}', 'C(v_i)=\\frac{2m_i}{k_i(k_i-1)}', 'Anteil tatsächlich vorhandener Verbindungen zwischen den Nachbarn eines Knotens.', 'definition', 'literature', 144, NULL, NULL, 'checked', 45),
(1005, '3.272', 19, 'Mittlere Weglänge', 'L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)', 'L=\\frac{1}{n(n-1)}\\sum_{i\\neq j}d(v_i,v_j)', 'Mittlere kürzeste Distanz zwischen allen geordneten Knotenpaaren.', 'definition', 'literature', 144, NULL, NULL, 'checked', 45),
(1006, '3.273', 19, 'Small-World-Bedingung', 'C\\gg C_{\\mathrm{random}},\\qquad L\\approx L_{\\mathrm{random}}', 'C\\gg C_{\\mathrm{random}},\\qquad L\\approx L_{\\mathrm{random}}', 'Kombination hoher Clusterung mit kurzer mittlerer Weglänge.', 'model', 'literature', 144, NULL, NULL, 'checked', 45),
(1007, '3.274', 19, 'Skalenfreie Gradverteilung', 'P(k)\\sim k^{-\\gamma}', 'P(k)\\sim k^{-\\gamma}', 'Potenzgesetzartige Verteilung der Knotengrade.', 'model', 'literature', 145, NULL, NULL, 'checked', 45);

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
(445, 736, 'x', 'Element', 'Beliebiges mathematisches Objekt.', NULL, 'Objekt', 1),
(446, 736, 'M', 'Menge', 'Menge, deren Elementzugehörigkeit geprüft wird.', NULL, 'Menge', 2),
(447, 737, 'x', 'Element', 'Beliebiges mathematisches Objekt.', NULL, 'Objekt', 1),
(448, 737, 'M', 'Menge', 'Menge, zu der x nicht gehört.', NULL, 'Menge', 2),
(449, 738, '\\emptyset', 'Leere Menge', 'Eindeutig bestimmte Menge ohne Elemente.', NULL, 'Menge', 1),
(450, 739, 'A', 'Menge A', 'Erste Vergleichsmenge.', NULL, 'Menge', 1),
(451, 739, 'B', 'Menge B', 'Zweite Vergleichsmenge.', NULL, 'Menge', 2),
(452, 739, 'x', 'Element', 'Beliebiges Prüfelement.', NULL, 'Objekt', 3),
(453, 740, 'A', 'Teilmenge', 'Mögliche Teilmenge von B.', NULL, 'Menge', 1),
(454, 740, 'B', 'Obermenge', 'Menge, die alle Elemente von A enthält.', NULL, 'Menge', 2),
(455, 740, 'x', 'Element', 'Beliebiges Element.', NULL, 'Objekt', 3),
(456, 741, 'A_P', 'Aussonderungsmenge', 'Teilmenge der Elemente von A mit Eigenschaft P.', NULL, 'Menge', 1),
(457, 741, 'A', 'Grundmenge', 'Bereits vorhandene Menge.', NULL, 'Menge', 2),
(458, 741, 'P(x)', 'Prädikat', 'Auswahlbedingung für x.', NULL, 'Aussage', 3),
(459, 742, 'A', 'Menge A', 'Erste Vereinigungsmenge.', NULL, 'Menge', 1),
(460, 742, 'B', 'Menge B', 'Zweite Vereinigungsmenge.', NULL, 'Menge', 2),
(461, 742, 'x', 'Element', 'Element mindestens einer Ausgangsmenge.', NULL, 'Objekt', 3),
(462, 743, 'A', 'Menge A', 'Erste Schnittmenge.', NULL, 'Menge', 1),
(463, 743, 'B', 'Menge B', 'Zweite Schnittmenge.', NULL, 'Menge', 2),
(464, 743, 'x', 'Element', 'Gemeinsames Element beider Mengen.', NULL, 'Objekt', 3),
(465, 744, 'A', 'Menge A', 'Ausgangsmenge.', NULL, 'Menge', 1),
(466, 744, 'B', 'Menge B', 'Auszuschließende Menge.', NULL, 'Menge', 2),
(467, 744, 'x', 'Element', 'Element von A, das nicht in B liegt.', NULL, 'Objekt', 3),
(468, 745, 'A^c', 'Komplement', 'Komplement von A relativ zu U.', NULL, 'Menge', 1),
(469, 745, 'U', 'Grundmenge', 'Bezugsuniversum des Komplements.', NULL, 'Menge', 2),
(470, 745, 'A', 'Teilmenge', 'Zu komplementierende Teilmenge.', NULL, 'Menge', 3),
(471, 746, 'A', 'Menge A', 'Erste Faktormenge.', NULL, 'Menge', 1),
(472, 746, 'B', 'Menge B', 'Zweite Faktormenge.', NULL, 'Menge', 2),
(473, 746, '(a,b)', 'Geordnetes Paar', 'Paar mit erster Komponente aus A und zweiter aus B.', NULL, 'Geordnetes Paar', 3),
(474, 747, '\\mathcal P(A)', 'Potenzmenge', 'Menge aller Teilmengen von A.', NULL, 'Menge', 1),
(475, 747, 'X', 'Teilmenge', 'Beliebige Teilmenge von A.', NULL, 'Menge', 2),
(476, 747, 'A', 'Ausgangsmenge', 'Menge, deren Potenzmenge gebildet wird.', NULL, 'Menge', 3),
(477, 748, '|\\mathcal P(A)|', 'Mächtigkeit der Potenzmenge', 'Kardinalität der Potenzmenge von A.', NULL, 'Kardinalzahl', 1),
(478, 748, '|A|', 'Mächtigkeit von A', 'Kardinalität der Ausgangsmenge A.', NULL, 'Kardinalzahl', 2),
(479, 749, '\\Omega', 'Mengenoperation', 'Allgemeine Operation auf Teilmengen von M.', NULL, 'Operator', 1),
(480, 749, '\\mathcal P(M)', 'Potenzmenge', 'Definitions- und Zielbereich der Operation.', NULL, 'Menge', 2),
(481, 749, 'M', 'Grundmenge', 'Zugrunde liegende Menge.', NULL, 'Menge', 3),
(482, 753, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 1),
(483, 753, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 2),
(484, 754, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(485, 754, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(486, 754, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(487, 755, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(488, 756, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(489, 756, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(490, 757, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(491, 757, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(492, 757, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(493, 758, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(494, 758, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(495, 758, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(496, 759, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(497, 760, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(498, 760, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(499, 761, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(500, 761, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(501, 762, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(502, 762, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(503, 763, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(504, 763, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(505, 764, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(506, 764, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(507, 765, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(508, 765, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(509, 766, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(510, 767, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(511, 767, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(512, 768, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(513, 768, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(514, 769, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(515, 770, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 1),
(516, 770, 'preceq', 'Ordnungsrelation', 'Halb- oder Totalordnung.', NULL, 'Relation auf A', 2),
(517, 771, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 1),
(518, 771, 'preceq', 'Ordnungsrelation', 'Halb- oder Totalordnung.', NULL, 'Relation auf A', 2),
(519, 772, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(520, 772, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(521, 772, 'B', 'Zielmenge', 'Ziel- oder Vergleichsmenge.', NULL, 'Menge', 3),
(522, 772, 'circ', 'Relationskomposition', 'Komposition zweier Relationen.', NULL, 'Relationsoperation', 4),
(523, 773, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(524, 773, 'circ', 'Relationskomposition', 'Komposition zweier Relationen.', NULL, 'Relationsoperation', 2),
(525, 774, 'R', 'Relation', 'Binäre Relation.', NULL, 'Relation', 1),
(526, 774, 'A', 'Grundmenge', 'Ausgangs- oder Grundmenge.', NULL, 'Menge', 2),
(527, 775, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(528, 775, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(529, 775, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(530, 776, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(531, 776, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(532, 776, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(533, 777, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(534, 777, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(535, 777, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(536, 778, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(537, 778, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(538, 778, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(539, 779, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(540, 779, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(541, 779, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(542, 780, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(543, 781, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(544, 781, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(545, 782, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(546, 782, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(547, 782, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(548, 783, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(549, 784, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(550, 784, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(551, 785, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(552, 785, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(553, 786, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(554, 787, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(555, 787, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(556, 787, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(557, 788, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(558, 788, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(559, 788, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(560, 789, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(561, 790, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(562, 790, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(563, 790, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(564, 791, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(565, 792, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(566, 793, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(567, 793, 'g', 'zweite Funktion', 'zweite Funktion.', NULL, 'Abbildung', 2),
(568, 794, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(569, 794, 'g', 'zweite Funktion', 'zweite Funktion.', NULL, 'Abbildung', 2),
(570, 795, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 1),
(571, 795, '\\operatorname{id}', 'Identitätsabbildung', 'Identitätsabbildung.', NULL, 'Abbildung', 3),
(572, 796, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 1),
(573, 796, '\\operatorname{id}', 'Identitätsabbildung', 'Identitätsabbildung.', NULL, 'Abbildung', 2),
(574, 797, 'f', 'Funktion', 'Funktion.', NULL, 'Abbildung', 1),
(575, 797, 'A', 'Definitionsmenge', 'Definitionsmenge.', NULL, 'Menge', 2),
(576, 797, 'B', 'Zielmenge', 'Zielmenge.', NULL, 'Menge', 3),
(577, 797, '\\operatorname{id}', 'Identitätsabbildung', 'Identitätsabbildung.', NULL, 'Abbildung', 4),
(578, 798, 'star', 'binäre Verknüpfung', 'Innere Verknüpfung auf A.', NULL, 'A×A→A', 1),
(579, 798, 'A', 'Trägermenge', 'Grundmenge der algebraischen Struktur.', NULL, 'Menge', 2),
(580, 806, 'e', 'neutrales Element', 'Element ohne verändernde Wirkung.', NULL, 'A', 1),
(581, 813, 'a^{-1}', 'inverses Element', 'Inverse zu a.', NULL, 'A', 1),
(582, 819, 'varphi', 'Homomorphismus', 'Strukturerhaltende Abbildung.', NULL, 'Abbildung', 1),
(583, 821, 'R', 'Ring', 'Trägermenge des Ringes.', NULL, 'Ring', 1),
(584, 832, 'K', 'Skalarkörper', 'Körper der Skalare.', NULL, 'Körper', 1),
(585, 832, 'V', 'Vektorraum', 'Träger der Vektoren.', NULL, 'Vektorraum', 2),
(586, 833, 'lambda', 'Skalar', 'Element des Körpers K.', NULL, 'K', 1),
(587, 833, 'u', 'Vektor', 'Element von V.', NULL, 'V', 2),
(588, 833, 'v', 'Vektor', 'Element von V.', NULL, 'V', 3),
(589, 840, 'T', 'Operator', 'Abbildung zwischen mathematischen Räumen.', NULL, 'X\\to Y', 1),
(590, 840, 'X', 'Definitionsraum', 'Mathematischer Ausgangsraum.', NULL, 'Raum', 2),
(591, 840, 'Y', 'Zielraum', 'Mathematischer Zielraum.', NULL, 'Raum', 3),
(592, 843, 'x_n', 'Zustand', 'Zustand nach n Operatoranwendungen.', NULL, 'X', 1),
(593, 844, 'T^n', 'Operatoriteration', 'n-fache Komposition von T.', NULL, 'X\\to X', 1),
(594, 845, '\\mathcal{D}(T)', 'Definitionsbereich', 'Tatsächliche Domäne des Operators.', NULL, 'Teilmenge von X', 1),
(595, 847, '\\mathcal{R}(T)', 'Wertebereich', 'Menge der tatsächlich erzeugten Bilder.', NULL, 'Teilmenge von Y', 1),
(596, 848, '\\alpha,\\beta', 'Skalare', 'Skalare des zugrunde liegenden Körpers.', NULL, 'K', 1),
(597, 851, '\\ker(T)', 'Kern', 'Nullraum des linearen Operators.', NULL, 'Unterraum von X', 1),
(598, 852, '\\operatorname{im}(T)', 'Bild', 'Bildraum des linearen Operators.', NULL, 'Unterraum von Y', 1),
(599, 856, 'S\\circ T', 'Operatorenkomposition', 'Verkettung der Operatoren T und S.', NULL, 'X\\to Z', 1),
(600, 860, 'I_X', 'Identitätsoperator', 'Neutrale Transformation auf X.', NULL, 'X\\to X', 1),
(601, 863, 'T^{-1}', 'Inverser Operator', 'Umkehrabbildung eines invertierbaren Operators.', NULL, 'Y\\to X', 1),
(602, 865, '\\operatorname{End}(V)', 'Endomorphismenmenge', 'Menge aller linearen Endomorphismen von V.', NULL, 'Operatorraum', 1),
(603, 868, '\\sigma(T)', 'Spektrum', 'Menge der Nichtinvertierbarkeitswerte.', NULL, 'Teilmenge von \\mathbb C', 1),
(604, 868, '\\lambda', 'Spektralparameter', 'Komplexer Skalar im Spektrum.', NULL, '\\mathbb C', 2),
(605, 869, 'x', 'Zustandsraum', 'Menge aller zulässigen Zustände.', NULL, 'Menge oder Raum', 2),
(607, 870, 'x_i', 'Zustandskomponente', 'i-te Komponente des Zustandsvektors.', NULL, '\\mathbb R', 1),
(608, 872, 'F', 'Übergangsabbildung', 'Abbildung eines Zustandes auf den Folgezustand.', NULL, 'X\\to X', 1),
(609, 873, 'k', 'diskreter Index', 'Index des diskreten Entwicklungsschrittes.', NULL, '\\mathbb N', 1),
(610, 874, 'X_{\\mathrm{zul}}', 'zulässiger Zustandsraum', 'Menge aller nebenbedingungskonformen Zustände.', NULL, 'Teilmenge von X', 1),
(611, 879, 'I', 'Zeitintervall', 'Definitionsintervall der Zustandsfunktion.', NULL, 'Teilmenge von \\mathbb R', 1),
(612, 880, '\\dot{x}(t)', 'Zustandsableitung', 'Zeitliche Änderungsrate des Zustandes.', NULL, 'Tangentialraum', 1),
(613, 885, '\\Phi', 'Fluss', 'Zeitparametrisierte Zustandsabbildung.', NULL, '\\mathbb R\\times X\\to X', 1),
(614, 889, '\\gamma(x_0)', 'Trajektorie', 'Bahn des Anfangszustandes im Zustandsraum.', NULL, 'Teilmenge von X', 1),
(615, 890, 'x^\\ast', 'Gleichgewichtspunkt', 'Zustand mit verschwindendem Vektorfeld.', NULL, 'X', 1),
(616, 892, 'M', 'invariante Menge', 'Erhaltene Teilmenge des Zustandsraumes.', NULL, NULL, 1),
(617, 892, 'Phi', 'Fluss', 'Dynamische Entwicklung auf X.', NULL, NULL, 2),
(618, 896, 'varepsilon', 'Toleranz', 'Vorgegebene maximale Abweichung.', NULL, NULL, 1),
(619, 896, 'delta', 'Anfangsradius', 'Hinreichend kleine Anfangsabweichung.', NULL, NULL, 2),
(620, 900, 'V', 'Lyapunov-Funktion', 'Skalare Stabilitätsfunktion.', NULL, NULL, 1),
(621, 903, 'dot V', 'Ableitung der Lyapunov-Funktion', 'Änderung von V entlang der Dynamik.', NULL, NULL, 1),
(622, 906, 'A', 'Attraktor', 'Invariante anziehende Menge.', NULL, NULL, 1),
(623, 908, 'B(A)', 'Einzugsgebiet', 'Menge der zu A konvergierenden Anfangszustände.', NULL, NULL, 1),
(624, 912, 'lambda', 'Lyapunov-Exponent', 'Exponentielle Wachstumsrate infinitesimaler Störungen.', NULL, NULL, 1),
(625, 914, 'omega(x_0)', 'Omega-Grenzmenge', 'Asymptotische Häufungsmenge einer Trajektorie.', NULL, NULL, 1),
(626, 917, '\\mu', 'Kontrollparameter', 'Parameter der dynamischen Systemfamilie.', NULL, '\\mathbb{R}^p', 1),
(627, 917, 'F', 'Vektorfeld', 'Parameterabhängiges Entwicklungsgesetz.', NULL, 'X\\times\\mathbb{R}^p\\to TX', 2),
(628, 918, 'A(\\mu)', 'Systemmatrix', 'Parameterabhängige lineare Systemmatrix.', NULL, '\\mathbb{R}^{n\\times n}', 1),
(629, 919, 'N', 'nichtlinearer Anteil', 'Nichtlinearer Anteil des Entwicklungsgesetzes.', NULL, NULL, 1),
(630, 923, '\\xi', 'lokale Abweichung', 'Abweichung vom Gleichgewichtspunkt.', NULL, '\\mathbb{R}^n', 1),
(631, 926, 'J', 'Jacobi-Matrix', 'Ableitung des Vektorfeldes bezüglich des Zustandes.', NULL, '\\mathbb{R}^{n\\times n}', 1),
(632, 927, '\\lambda_i', 'Eigenwert', 'i-ter Eigenwert der Jacobi-Matrix.', NULL, '\\mathbb{C}', 1),
(633, 929, '\\mu_c', 'kritischer Parameter', 'Parameterwert mit verschwindendem Eigenwertrealteil.', NULL, '\\mathbb{R}', 1),
(634, 930, '\\Phi_\\mu', 'parameterabhängiger Fluss', 'Fluss des Systems beim Parameterwert mu.', NULL, NULL, 1),
(635, 941, 'z', 'komplexe Zustandsvariable', 'Lokale komplexe Koordinate der Hopf-Normalform.', NULL, '\\mathbb{C}', 1),
(636, 941, '\\omega', 'Eigenkreisfrequenz', 'Imaginärteil des kritischen Eigenwertpaares.', NULL, '\\mathbb{R}_{>0}', 2),
(637, 944, 'A(\\mu)', 'Attraktormenge', 'Parameterabhängige asymptotische Organisationsform.', NULL, NULL, 1),
(638, 945, '\\mathcal X', 'Alphabet', 'Menge möglicher Werte der Zufallsvariablen.', NULL, '\\{x_1,\\ldots,x_n\\}', 1),
(639, 946, 'p_i', 'Ereigniswahrscheinlichkeit', 'Wahrscheinlichkeit des Ereignisses X=x_i.', NULL, '[0,1]', 1),
(640, 949, 'I', 'Selbstinformation', 'Informationsgehalt eines Ereignisses.', NULL, '\\mathbb R_{\\ge0}', 1),
(641, 949, 'b', 'Logarithmusbasis', 'Basis des Informationsmaßes.', NULL, '\\mathbb R_{>1}', 2),
(642, 956, 'H', 'Shannon-Entropie', 'Mittlere Unbestimmtheit einer Zufallsvariablen.', NULL, '\\mathbb R_{\\ge0}', 1),
(643, 960, 'p(x_i,y_j)', 'gemeinsame Wahrscheinlichkeit', 'Gemeinsame Wahrscheinlichkeit zweier Ereignisse.', NULL, '[0,1]', 1),
(644, 965, 'H(X|Y)', 'bedingte Entropie', 'Verbleibende Unsicherheit von X bei Kenntnis von Y.', NULL, '\\mathbb R_{\\ge0}', 1),
(645, 969, 'I(X\nON DUPLICATE KEY UPDATE `symbol_name`=VALUES(`symbol_name`),`definition_text`=VALUES(`definition_text`),`unit_text`=VALUES(`unit_text`),`domain_text`=VALUES(`domain_text`),`symbol_order`=VALUES(`symbol_order`);Y)', 'gegenseitige Information', 'Statistische Informationsabhängigkeit zwischen X und Y.', NULL, '\\mathbb R_{\\ge0}', 1),
(646, 972, 'D_{KL}', 'Kullback-Leibler-Divergenz', 'Gerichtetes Divergenzmaß zweier Verteilungen.', NULL, '\\mathbb R_{\\ge0}', 1),
(647, 975, 'M', 'Mischverteilung', 'Arithmetisches Mittel der Verteilungen P und Q.', NULL, NULL, 1),
(648, 976, 'D_{JS}', 'Jensen-Shannon-Divergenz', 'Symmetrisches Divergenzmaß.', NULL, '\\mathbb R_{\\ge0}', 1),
(649, 978, 'G', 'Graph', 'Geordnetes Paar aus Knoten- und Kantenmenge.', NULL, NULL, 1),
(650, 978, 'V', 'Knotenmenge', 'Menge aller Knoten des Graphen.', NULL, NULL, 2),
(651, 978, 'E', 'Kantenmenge', 'Menge aller Kanten des Graphen.', NULL, NULL, 3),
(652, 984, 'A', 'Adjazenzmatrix', 'Binäre Matrixdarstellung des Graphen.', NULL, '\\{0,1\\}^{n\\times n}', 1),
(653, 985, 'a_{ij}', 'Adjazenzeintrag', 'Kantenindikator zwischen vi und vj.', NULL, '\\{0,1\\}', 1),
(654, 987, '\\deg(v_i)', 'Knotengrad', 'Anzahl der Nachbarn von vi.', NULL, '\\mathbb N_0', 1),
(655, 994, 'd', 'Graphendistanz', 'Länge eines kürzesten Pfades.', NULL, '\\mathbb N_0\\cup\\{\\infty\\}', 1),
(656, 997, 'w', 'Gewichtsfunktion', 'Zuordnung eines Wertes zu jeder Kante.', NULL, '\\mathbb R', 1),
(657, 998, 'W', 'gewichtete Adjazenzmatrix', 'Matrix der Kantengewichte.', NULL, '\\mathbb R^{n\\times n}', 1),
(658, 999, 's(v_i)', 'Knotenstärke', 'Summe der Kantengewichte eines Knotens.', NULL, '\\mathbb R', 1),
(659, 1000, 'C_D', 'Gradzentralität', 'Normierter Grad eines Knotens.', NULL, '[0,1]', 1),
(660, 1001, 'C_C', 'Closeness-Zentralität', 'Inverse Summe der Distanzen zu allen Knoten.', NULL, '\\mathbb R_{\\ge0}', 1),
(661, 1002, 'C_B', 'Betweenness-Zentralität', 'Vermittlungsanteil auf kürzesten Wegen.', NULL, '\\mathbb R_{\\ge0}', 1),
(662, 1002, '\\sigma_{st}', 'Anzahl kürzester Wege', 'Anzahl kürzester Wege zwischen s und t.', NULL, '\\mathbb N', 2),
(663, 1003, 'x', 'Zentralitätsvektor', 'Eigenvektorbasierte Zentralitätswerte.', NULL, '\\mathbb R^n', 1),
(664, 1003, '\\lambda', 'größter Eigenwert', 'Dominanter Eigenwert der Adjazenzmatrix.', NULL, '\\mathbb R', 2),
(665, 1004, 'C(v_i)', 'Clusterkoeffizient', 'Lokaler Grad der Nachbarschaftsvernetzung.', NULL, '[0,1]', 1),
(666, 1005, 'L', 'mittlere Weglänge', 'Durchschnitt kürzester Distanzen.', NULL, '\\mathbb R_{\\ge0}', 1),
(667, 1007, 'P(k)', 'Gradverteilung', 'Wahrscheinlichkeit eines Knotengrades k.', NULL, '[0,1]', 1),
(668, 1007, '\\gamma', 'Skalierungsexponent', 'Exponent der potenzgesetzartigen Gradverteilung.', NULL, '\\mathbb R_{>0}', 2);

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
('last_edited_section', '3.2.12', '2026-07-15 17:27:46'),
('last_repository_revision', 'RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5', '2026-07-15 17:27:46'),
('next_citation_number', '82', '2026-07-15 17:27:46'),
('next_equation_number', '3.275', '2026-07-15 17:27:46');

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
(24, 'RKB-2026-07-14-K3.2.1-NEUFASSUNG-V2', '2026-07-15 19:27:43', 'section', '3.2.1', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.1 mit Mengenbegriff, Axiomatik, Mengenoperationen, kartesischem Produkt, Potenzmenge und Forschungsgrenze.', 'Olaf Thiele / ChatGPT', 21),
(25, 'RKB-2026-07-14-K3.2.2-NEUFASSUNG-V2', '2026-07-15 19:27:43', 'section', '3.2.2', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.2 mit Relationseigenschaften, Äquivalenz- und Ordnungsrelationen, Relationskomposition und Graphinterpretation.', 'Olaf Thiele / ChatGPT', 24),
(26, 'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V2', '2026-07-15 19:27:43', 'section', '3.2.3', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.3 mit modernem Funktionsbegriff, Bild und Urbild, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung.', 'Olaf Thiele / ChatGPT', 25),
(29, 'RKB-2026-07-14-K3.2.4-NEUFASSUNG-V2', '2026-07-15 19:27:44', 'section', '3.2.4', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.4 mit Magmen, Halbgruppen, Monoiden, Gruppen, Ringen, Körpern, Vektorräumen, Homomorphismen und Symmetriebezug.', 'Olaf Thiele / ChatGPT', 26),
(31, 'RKB-2026-07-15-K3.2.5-NEUFASSUNG-V2', '2026-07-15 19:27:44', 'section', '3.2.5', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.5 mit allgemeinem Operatorbegriff, Definitions- und Wertebereich, linearen Operatoren, Kern und Bild, Operatoralgebra, Invertierbarkeit und Spektrum.', 'Olaf Thiele / ChatGPT', 29),
(38, 'RKB-2026-07-15-K3.2.6-NEUFASSUNG-V2', '2026-07-15 19:27:44', 'section', '3.2.6', '2.0', 'Vollständige Neufassung von Abschnitt 3.2.6 mit Zustandsraumbegriff, vollständiger Zustandsbeschreibung, diskreten und kontinuierlichen Zustandsentwicklungen, Flüssen, Trajektorien und Gleichgewichtspunkten.', 'Olaf Thiele / ChatGPT', 31),
(39, 'RKB-2026-07-15-K3.2.7-NEUFASSUNG-V2', '2026-07-15 19:27:45', 'section', '3.2.7', '2.0', 'Neufassung von Abschnitt 3.2.7 zu Invarianz, Stabilität, Lyapunov-Funktionen und Attraktoren.', 'Olaf Thiele / ChatGPT', 38),
(40, 'RKB-2026-07-15-K3.2.8-NEUFASSUNG-V2', '2026-07-15 19:27:45', 'section', '3.2.8', '2.0', 'Neufassung von Abschnitt 3.2.8 zu Nichtlinearität, Linearisierung, lokalen Bifurkationen und emergenten Strukturwechseln.', 'Olaf Thiele / ChatGPT', 39),
(41, 'RKB-2026-07-15-K3.2.9-NEUFASSUNG-V3', '2026-07-15 19:27:45', 'section', '3.2.9', '3.0', 'Vollständige Repository-Neufassung von Abschnitt 3.2.9 mit Shannon-Entropie, bedingter Entropie, gegenseitiger Information und Divergenzmaßen.', 'Olaf Thiele / ChatGPT', 40),
(42, 'RKB-2026-07-15-K3.2.10-NEUFASSUNG-V3', '2026-07-15 09:15:58', 'section', '3.2.10', '3.0', 'Graphen- und Netzwerktheorie mit Graphen, Adjazenzmatrix, Wegen, Distanzen und gewichteten Netzwerken.', 'Olaf Thiele / ChatGPT', 41),
(45, 'RKB-2026-07-15-K3.2.11-NEUFASSUNG-V5', '2026-07-15 19:27:46', 'section', '3.2.11', '5.0', 'Vollständige Neufassung von Abschnitt 3.2.11 mit Zentralitätsmaßen, Clusterkoeffizient, mittlerer Weglänge, Small-World- und skalenfreien Netzwerken.', 'Olaf Thiele / ChatGPT', 47),
(47, 'RKB-2026-07-15-K3.2.10-NEUFASSUNG-V5', '2026-07-15 19:27:46', 'section', '3.2.10', '5.0', 'Vollständige Neufassung von Abschnitt 3.2.10 mit Graphen, Adjazenzmatrizen, Graden, Wegen, Distanzen, Zusammenhang und gewichteten Netzwerken.', 'Olaf Thiele / ChatGPT', 41),
(49, 'RKB-2026-07-15-K3.2.12-NEUFASSUNG-V5', '2026-07-15 19:27:46', 'section', '3.2.12', '5.0', 'Zusammenfassung der mathematischen Grundlagen und systematische Identifikation der Forschungslücke als Übergang zur FRZK-Axiomatik.', 'Olaf Thiele / ChatGPT', 45);

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
(173, 24, 9, 'rewritten', 'section', '3.2.1', 'Abschnitt 3.2.1 vollständig neu gefasst.', 'Frühere Arbeitsfassung.', 'Dissertationsfähige Neufassung mit historischem Forschungsstand, Axiomatik, Mengenoperationen und expliziter Forschungsgrenze.', '2026-07-15 17:27:43'),
(174, 24, 9, 'source_added', 'source', '[58]', 'Fraenkel, Bar-Hillel und Levy als neue Referenzquelle aufgenommen.', NULL, 'Foundations of Set Theory.', '2026-07-15 17:27:43'),
(175, 24, 9, 'source_reused', 'source', '[23], [24]', 'Cantor und Zermelo mit bestehenden Literaturnummern wiederverwendet.', NULL, 'Primärquellen zur Mengenlehre.', '2026-07-15 17:27:43'),
(176, 24, 9, 'equation_changed', 'equation', '(3.3)–(3.16)', 'Gleichungsbestand des Abschnitts vollständig neu aufgebaut.', NULL, '14 Gleichungen mit Word-LaTeX und Symbolzuordnungen.', '2026-07-15 17:27:43'),
(177, 24, 9, 'definition_added', 'definition', 'Def. 3.2.1.1–3.2.1.6', 'Sechs zentrale Definitionen registriert.', NULL, 'Menge, Element, leere Menge, Teilmenge, kartesisches Produkt und Potenzmenge.', '2026-07-15 17:27:43'),
(178, 25, 10, 'rewritten', 'section', '3.2.2', 'Abschnitt 3.2.2 wurde vollständig neu gefasst.', 'Vorheriger Repository-Stand.', 'Neufassung V2 mit 25 Gleichungen.', '2026-07-15 17:27:43'),
(179, 25, 10, 'source_added', 'source', '[59]', 'Tarskis Primärquelle zur Relationsalgebra wurde aufgenommen.', NULL, 'On the Calculus of Relations.', '2026-07-15 17:27:43'),
(180, 25, 10, 'source_reused', 'sources', '[27], [28]', 'Enderton sowie Davey und Priestley wurden wiederverwendet.', NULL, 'Drei Quellenverwendungen insgesamt.', '2026-07-15 17:27:43'),
(181, 25, 10, 'equation_added', 'equations', '(3.17)–(3.41)', 'Relationen, Eigenschaften, Klassen, Ordnungen, Komposition und Graphmodell wurden registriert.', NULL, '25 Gleichungen.', '2026-07-15 17:27:43'),
(182, 25, 10, 'definition_added', 'definitions', 'Def. 3.2.2.1–3.2.2.8', 'Acht Definitionen wurden registriert.', NULL, '8 Definitionen.', '2026-07-15 17:27:43'),
(183, 25, 10, 'status_changed', 'section', '3.2.2', 'Abschnitt auf review gesetzt.', 'planned', 'review', '2026-07-15 17:27:43'),
(184, 26, 11, 'rewritten', 'section', '3.2.3', 'Abschnitt 3.2.3 wurde vollständig neu gefasst.', 'Bisheriger oder geplanter Abschnittsstand.', 'Neufassung mit Funktionen, Abbildungseigenschaften, Komposition und Identität.', '2026-07-15 17:27:43'),
(185, 26, 11, 'source_added', 'sources', '[60]', 'Dirichlet [60] wurde als neue Primärquelle registriert.', NULL, '1 neue Quelle.', '2026-07-15 17:27:43'),
(186, 26, 11, 'source_reused', 'sources', '[29], [30]', 'Die bestehenden Quellen [29] und [30] wurden wiederverwendet.', NULL, '2 Quellenwiederverwendungen.', '2026-07-15 17:27:43'),
(187, 26, 11, 'equation_added', 'equations', '(3.42)–(3.64)', '23 Gleichungen wurden registriert.', NULL, '23 Gleichungen.', '2026-07-15 17:27:43'),
(188, 26, 11, 'definition_added', 'definitions', 'Def. 3.2.3.1–3.2.3.9', 'Neun Definitionen wurden registriert.', NULL, '9 Definitionen.', '2026-07-15 17:27:43'),
(189, 26, 11, 'symbol_added', 'symbols', '3.2.3', 'Zentrale Funktionssymbole wurden registriert.', NULL, '4 Abschnittssymbole.', '2026-07-15 17:27:43'),
(190, 26, 11, 'status_changed', 'section', '3.2.3', 'Der Abschnitt wurde auf review gesetzt.', NULL, 'review', '2026-07-15 17:27:44'),
(191, 29, 12, 'rewritten', 'section', '3.2.4', 'Abschnitt 3.2.4 vollständig neu gefasst.', 'Bisheriger Repository-Stand.', 'Neufassung mit fünf neuen Quellen, dreizehn Definitionen und 42 Gleichungen.', '2026-07-15 17:27:44'),
(192, 29, 12, 'source_added', 'sources', '[61]–[65]', 'Fünf neue Literaturquellen registriert.', NULL, 'Galois [61], Noether [62], van der Waerden [63], Mac Lane/Birkhoff [64], Noether [65].', '2026-07-15 17:27:44'),
(193, 29, 12, 'definition_added', 'definitions', 'Def. 3.2.4.1–Def. 3.2.4.13', 'Dreizehn algebraische Definitionen registriert.', NULL, 'Binäre Verknüpfung bis Vektorraum.', '2026-07-15 17:27:44'),
(194, 29, 12, 'equation_added', 'equations', '(3.65)–(3.106)', '42 Gleichungen registriert.', NULL, 'Algebraische Strukturen und Strukturerhaltung.', '2026-07-15 17:27:44'),
(195, 29, 12, 'symbol_added', 'symbols', 'star, e, a^{-1}, varphi, R, K, V', 'Zentrale Abschnittssymbole registriert.', NULL, 'Symbolregister 3.2.4 V2.', '2026-07-15 17:27:44'),
(196, 31, 13, 'rewritten', 'section', '3.2.5', 'Abschnitt 3.2.5 vollständig neu gefasst.', 'Bisheriger Repository-Stand.', 'Neufassung mit Operatorbegriff, linearer Struktur, Operatoralgebra und Spektrum.', '2026-07-15 17:27:44'),
(197, 31, 13, 'source_added', 'sources', '[66]–[67]', 'Zwei neue Primärquellen registriert.', NULL, 'Hilbert [66], Banach [67].', '2026-07-15 17:27:44'),
(198, 31, 13, 'source_reused', 'sources', '[11], [35], [36]', 'Drei bestehende Standardquellen wiederverwendet.', NULL, 'Rudin [11], Conway [35], Kreyszig [36].', '2026-07-15 17:27:44'),
(199, 31, 13, 'definition_added', 'definitions', 'Def. 3.2.5.1–Def. 3.2.5.10', 'Zehn Definitionen registriert.', NULL, 'Operator bis Spektrum.', '2026-07-15 17:27:44'),
(200, 31, 13, 'equation_added', 'equations', '(3.107)–(3.135)', '29 Gleichungen registriert.', NULL, 'Operatorbegriff, Linearität, Kern, Bild, Komposition, Invertierbarkeit und Spektrum.', '2026-07-15 17:27:44'),
(201, 31, 13, 'symbol_added', 'symbols', 'T, D(T), R(T), ker(T), im(T), I_X, T^{-1}, End(V), sigma(T)', 'Zentrale Operatorsymbole registriert.', NULL, 'Symbolregister 3.2.5.', '2026-07-15 17:27:44'),
(202, 38, 14, 'rewritten', 'section', '3.2.6', 'Abschnitt 3.2.6 vollständig neu gefasst.', 'Bisheriger Repository-Stand.', 'Neufassung mit Zustandsraum, diskreter und kontinuierlicher Dynamik, Fluss, Trajektorie und Gleichgewicht.', '2026-07-15 17:27:44'),
(203, 38, 14, 'source_added', 'sources', '[68]–[69]', 'Zwei neue Quellen registriert.', NULL, 'Kalman [68], Arnold [69].', '2026-07-15 17:27:44'),
(204, 38, 14, 'source_reused', 'sources', '[38]–[40]', 'Drei bestehende Standardquellen wiederverwendet.', NULL, 'Sontag [38], Khalil [39], Hirsch/Smale/Devaney [40].', '2026-07-15 17:27:44'),
(205, 38, 14, 'definition_added', 'definitions', 'Def. 3.2.6.1–Def. 3.2.6.9', 'Neun Definitionen registriert.', NULL, 'Zustand bis Gleichgewichtspunkt.', '2026-07-15 17:27:44'),
(206, 38, 14, 'equation_added', 'equations', '(3.136)–(3.158)', '23 Gleichungen registriert.', NULL, 'Zustandsraum, Übergänge, Nebenbedingungen, Fluss, Trajektorie und Gleichgewicht.', '2026-07-15 17:27:44'),
(207, 38, 14, 'symbol_added', 'symbols', 'X, x, F, X_zul, Phi, gamma(x0), x*', 'Zentrale Zustandsraumsymbole registriert.', NULL, 'Symbolregister 3.2.6.', '2026-07-15 17:27:44'),
(208, 39, 15, 'rewritten', 'section', '3.2.7', 'Abschnitt vollständig neu gefasst.', NULL, 'Invarianz, Stabilität, Lyapunov-Funktionen und Attraktoren.', '2026-07-15 17:27:45'),
(209, 39, 15, 'source_added', 'sources', '[70]–[72]', 'Drei neue Quellen registriert.', NULL, 'Lyapunov, LaSalle, Ruelle/Takens.', '2026-07-15 17:27:45'),
(210, 39, 15, 'equation_added', 'equations', '(3.159)–(3.183)', '25 Gleichungen registriert.', NULL, 'Stabilitäts- und Attraktorformalismus.', '2026-07-15 17:27:45'),
(211, 40, 16, 'rewritten', 'section', '3.2.8', 'Abschnitt vollständig neu gefasst.', NULL, 'Nichtlinearität, Linearisierung, Bifurkationen und emergente Strukturwechsel.', '2026-07-15 17:27:45'),
(212, 40, 16, 'source_added', 'sources', '[73]–[74]', 'Zwei neue Quellen registriert.', NULL, 'Kuznetsov [73], Guckenheimer/Holmes [74].', '2026-07-15 17:27:45'),
(213, 40, 16, 'definition_added', 'definitions', 'Def. 3.2.8.1–Def. 3.2.8.11', 'Elf Definitionen registriert.', NULL, 'Nichtlinearität bis emergenter Strukturwechsel.', '2026-07-15 17:27:45'),
(214, 40, 16, 'equation_added', 'equations', '(3.184)–(3.211)', '28 Gleichungen registriert.', NULL, 'Nichtlinearität, Linearisierung, Bifurkationsnormalformen und Attraktorwechsel.', '2026-07-15 17:27:45'),
(215, 41, 17, 'rewritten', 'section', '3.2.9', 'Abschnitt 3.2.9 vollständig neu gefasst.', NULL, 'Informationstheorie mit Entropie, Mutual Information und Divergenzen.', '2026-07-15 17:27:46'),
(216, 41, 17, 'source_added', 'sources', '[75]–[76]', 'Zwei Primärquellen registriert.', NULL, 'Shannon [75], Wiener [76].', '2026-07-15 17:27:46'),
(217, 41, 17, 'definition_added', 'definitions', 'Def. 3.2.9.1–Def. 3.2.9.10', 'Zehn Definitionen registriert.', NULL, 'Zufallsvariable bis Informationsunabhängigkeit.', '2026-07-15 17:27:46'),
(218, 41, 17, 'equation_added', 'equations', '(3.212)–(3.244)', '33 Gleichungen registriert.', NULL, 'Vollständiger mathematischer Formalismus des Abschnitts.', '2026-07-15 17:27:46'),
(219, 47, 18, 'rewritten', 'section', '3.2.10', 'Abschnitt 3.2.10 vollständig im Masterstandard V5 neu gefasst.', NULL, 'Graphen, Adjazenzmatrizen, Grade, Wege, Distanzen, Zusammenhang und gewichtete Netzwerke.', '2026-07-15 17:27:46'),
(220, 47, 18, 'source_added', 'sources', '[77]–[78]', 'Zwei Quellen vollständig registriert.', NULL, 'Euler [77], Diestel [78].', '2026-07-15 17:27:46'),
(221, 47, 18, 'definition_added', 'definitions', 'Def. 3.2.10.1–Def. 3.2.10.11', 'Elf Definitionen registriert.', NULL, 'Graph bis Knotenstärke.', '2026-07-15 17:27:46'),
(222, 47, 18, 'equation_added', 'equations', '(3.245)–(3.266)', '22 Gleichungen registriert.', NULL, 'Vollständiger mathematischer Formalismus des Abschnitts.', '2026-07-15 17:27:46'),
(223, 45, 19, 'rewritten', 'section', '3.2.11', 'Abschnitt 3.2.11 vollständig im Masterstandard V5 neu gefasst.', NULL, 'Zentralitätsmaße, Clusterung, Small-World- und skalenfreie Netzwerke.', '2026-07-15 17:27:46'),
(224, 45, 19, 'source_added', 'sources', '[79]–[81]', 'Drei Quellen vollständig registriert.', NULL, 'Watts/Strogatz [79], Barabási/Albert [80], Freeman [81].', '2026-07-15 17:27:46'),
(225, 45, 19, 'definition_added', 'definitions', 'Def. 3.2.11.1–Def. 3.2.11.9', 'Neun Definitionen registriert.', NULL, 'Zentralitätsmaße bis Hub.', '2026-07-15 17:27:46'),
(226, 45, 19, 'equation_added', 'equations', '(3.267)–(3.274)', 'Acht Gleichungen registriert.', NULL, 'Vollständiger mathematischer Formalismus des Abschnitts.', '2026-07-15 17:27:46'),
(227, 49, 20, 'rewritten', 'section', '3.2.12', 'Abschnitt 3.2.12 vollständig als Kapitelabschluss neu gefasst.', NULL, 'Zusammenfassung der mathematischen Grundlagen, Forschungslücke und Übergang zur Axiomatik.', '2026-07-15 17:27:46'),
(228, 49, 20, 'source_reused', 'sources', '[23],[24],[29],[38],[40],[75],[78]–[80]', 'Zentrale Bestandsquellen synthetisch wiederverwendet.', NULL, 'Keine neue Literaturnummer vergeben.', '2026-07-15 17:27:46'),
(229, 49, 20, 'definition_added', 'definitions', 'Def. 3.2.12.1–Def. 3.2.12.3', 'Drei zusammenfassende Definitionen registriert.', NULL, 'Forschungslücke, funktionale Strukturgenese und axiomatische Anschlussanforderung.', '2026-07-15 17:27:46'),
(230, 49, 20, 'status_changed', 'chapter', '3.2', 'Kapitel 3.2 fachlich und repositorytechnisch abgeschlossen.', 'review', 'final', '2026-07-15 17:27:46');

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
(63, 58, 'fraenkel_bar_hillel_levy_foundations_set_theory_1973', 'book', 'Foundations of Set Theory', NULL, 1958, 1973, NULL, 'North-Holland', 'Amsterdam', NULL, NULL, NULL, 'Second Revised Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'partially_verified', '3.2.1', 'Erstnennung in der Neufassung von Abschnitt 3.2.1.', 'Fraenkel, Abraham A.; Bar-Hillel, Yehoshua; Levy, Azriel: Foundations of Set Theory. Second Revised Edition. Amsterdam: North-Holland, 1973.', 'Fraenkel, Bar-Hillel und Levy [58]', 'Referenzwerk zur axiomatischen Mengenlehre, zu ZFC und zur Begrenzung zulässiger Mengenbildungen.', 24, '2026-07-12 12:53:53', '2026-07-15 17:27:43'),
(69, 59, 'tarski_calculus_relations_1941', 'journal_article', 'On the Calculus of Relations', NULL, 1941, 1941, 'The Journal of Symbolic Logic', NULL, NULL, '6', '3', '73–89', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 4, 'verified', '3.2.2', 'Erstnennung zur Algebra und Komposition von Relationen.', 'Tarski, Alfred: On the Calculus of Relations. The Journal of Symbolic Logic, Bd. 6, Nr. 3, 1941, S. 73–89.', 'Tarski [59]', 'Primärquelle zur Relationsalgebra.', 25, '2026-07-14 15:51:27', '2026-07-14 15:51:27'),
(70, 60, 'dirichlet_functions_1837', 'journal_article', 'Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen', NULL, 1837, 1889, 'Repertorium der Physik', NULL, NULL, '1', NULL, '152–174', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'partially_verified', '3.2.3', 'Erstnennung zur historischen Ablösung des Funktionsbegriffs von einer ausschließlich analytischen Darstellung.', 'Dirichlet, Peter Gustav Lejeune: Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen. Repertorium der Physik, Bd. 1, 1837, S. 152–174; wiederabgedruckt in: Dirichlet’s Werke, Bd. 1, Berlin: Georg Reimer, 1889, S. 133–160.', 'Dirichlet [60]', 'Primärquelle zum modernen abstrakten Funktionsbegriff.', 26, '2026-07-14 16:13:43', '2026-07-14 16:13:43'),
(81, 61, 'galois_resolubilite_1846', 'journal_article', 'Mémoire sur les conditions de résolubilité des équations par radicaux', NULL, 1831, 1846, 'Journal de Mathématiques Pures et Appliquées', NULL, NULL, '11', NULL, '417–433', NULL, NULL, NULL, NULL, 'fr', 5, 'primary', 4, 'partially_verified', '3.2.4', 'Historische Primärquelle zur Entstehung der Gruppentheorie.', 'Galois, Évariste: Mémoire sur les conditions de résolubilité des équations par radicaux. Eingereicht 1831; veröffentlicht in: Journal de Mathématiques Pures et Appliquées, Bd. 11, 1846, S. 417–433.', 'Galois [61]', 'Primärquelle zur Symmetriestruktur algebraischer Gleichungen.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(82, 62, 'noether_idealtheorie_1921', 'journal_article', 'Idealtheorie in Ringbereichen', NULL, 1921, 1921, 'Mathematische Annalen', NULL, NULL, '83', NULL, '24–66', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 5, 'verified', '3.2.4', 'Primärquelle zur strukturellen Ring- und Idealtheorie.', 'Noether, Emmy: Idealtheorie in Ringbereichen. Mathematische Annalen, Bd. 83, 1921, S. 24–66.', 'Noether [62]', 'Grundlage der modernen strukturellen Algebra.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(83, 63, 'van_der_waerden_moderne_algebra_1930', 'book', 'Moderne Algebra', NULL, 1930, 1931, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'secondary', 5, 'partially_verified', '3.2.4', 'Systematische Darstellung abstrakter algebraischer Strukturen.', 'van der Waerden, Bartel Leendert: Moderne Algebra. Berlin: Springer, 1930–1931.', 'van der Waerden [63]', 'Standardwerk zur strukturellen Algebra.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(84, 64, 'mac_lane_birkhoff_algebra_1988', 'book', 'Algebra', NULL, 1967, 1988, NULL, 'Chelsea Publishing', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 4, 'secondary', 4, 'partially_verified', '3.2.4', 'Standardreferenz zu Gruppen, Homomorphismen und algebraischen Strukturen.', 'Mac Lane, Saunders; Birkhoff, Garrett: Algebra. 3. Auflage. New York: Chelsea Publishing, 1988.', 'Mac Lane/Birkhoff [64]', 'Standardwerk der abstrakten Algebra.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(85, 65, 'noether_invariante_variationsprobleme_1918', 'journal_article', 'Invariante Variationsprobleme', NULL, 1918, 1918, 'Nachrichten von der Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse', NULL, NULL, NULL, NULL, '235–257', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 5, 'verified', '3.2.4', 'Primärquelle zum Zusammenhang von kontinuierlichen Symmetrien und Erhaltungssätzen.', 'Noether, Emmy: Invariante Variationsprobleme. Nachrichten von der Gesellschaft der Wissenschaften zu Göttingen, Mathematisch-Physikalische Klasse, 1918, S. 235–257.', 'Noether [65]', 'Primärquelle zum Noether-Theorem.', 29, '2026-07-15 05:36:22', '2026-07-15 05:36:22'),
(131, 66, 'hilbert_integralgleichungen_1912', 'book', 'Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen', NULL, 1912, 1912, NULL, 'B. G. Teubner', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 5, 'primary', 5, 'partially_verified', '3.2.5', 'Historische Primärquelle zur Entwicklung der Operatorentheorie.', 'Hilbert, David: Grundzüge einer allgemeinen Theorie der linearen Integralgleichungen. Leipzig: B. G. Teubner, 1912.', 'Hilbert [66]', 'Begründet die systematische Betrachtung linearer Integraloperatoren.', 31, '2026-07-15 17:27:44', '2026-07-15 17:27:44'),
(132, 67, 'banach_operations_lineaires_1932', 'book', 'Théorie des opérations linéaires', NULL, 1932, 1932, NULL, 'Monografie Matematyczne', 'Warszawa', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'fr', 5, 'primary', 5, 'partially_verified', '3.2.5', 'Primärquelle zur allgemeinen Theorie linearer Operatoren auf normierten Räumen.', 'Banach, Stefan: Théorie des opérations linéaires. Warszawa: Monografie Matematyczne, 1932.', 'Banach [67]', 'Grundlage der linearen Funktionalanalysis und der Theorie beschränkter Operatoren.', 31, '2026-07-15 17:27:44', '2026-07-15 17:27:44'),
(133, 68, 'kalman_linear_dynamical_systems_1963', 'journal_article', 'Mathematical Description of Linear Dynamical Systems', NULL, 1963, 1963, 'Journal of the Society for Industrial and Applied Mathematics, Series A: Control', NULL, NULL, '1', '2', '152–192', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'partially_verified', '3.2.6', 'Primärquelle zur modernen Zustandsraumdarstellung linearer Systeme.', 'Kalman, Rudolf E.: Mathematical Description of Linear Dynamical Systems. Journal of the Society for Industrial and Applied Mathematics, Series A: Control, Bd. 1, Nr. 2, 1963, S. 152–192.', 'Kalman [68]', 'Grundlage des modernen Zustandsraumansatzes.', 38, '2026-07-15 17:27:44', '2026-07-15 17:27:44'),
(134, 69, 'arnold_ordinary_differential_equations_1973', 'book', 'Ordinary Differential Equations', NULL, 1973, 1973, NULL, 'MIT Press', 'Cambridge, Massachusetts', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 5, 'partially_verified', '3.2.6', 'Standardwerk zu Flüssen, Trajektorien und Gleichgewichtspunkten.', 'Arnold, Vladimir I.: Ordinary Differential Equations. Cambridge, Massachusetts: MIT Press, 1973.', 'Arnold [69]', 'Mathematische Grundlage kontinuierlicher Zustandsentwicklungen.', 38, '2026-07-15 17:27:44', '2026-07-15 17:27:44'),
(135, 70, 'lyapunov_stability_motion_1892', 'book', 'The General Problem of the Stability of Motion', NULL, 1892, 1992, NULL, 'Taylor & Francis', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'partially_verified', '3.2.7', 'Erstnennung in Abschnitt 3.2.7.', 'Lyapunov, Aleksandr M.: The General Problem of the Stability of Motion. Charkow, 1892; englische Ausgabe: London: Taylor & Francis, 1992.', 'Lyapunov [70]', 'Quelle für Abschnitt 3.2.7.', 39, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(136, 71, 'lasalle_stability_dynamical_systems_1976', 'book', 'The Stability of Dynamical Systems', NULL, 1976, 1976, NULL, 'Society for Industrial and Applied Mathematics', 'Philadelphia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 5, 'partially_verified', '3.2.7', 'Erstnennung in Abschnitt 3.2.7.', 'LaSalle, Joseph P.: The Stability of Dynamical Systems. Philadelphia: Society for Industrial and Applied Mathematics, 1976.', 'LaSalle [71]', 'Quelle für Abschnitt 3.2.7.', 39, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(137, 72, 'ruelle_takens_nature_turbulence_1971', 'journal_article', 'On the Nature of Turbulence', NULL, 1971, 1971, 'Communications in Mathematical Physics', NULL, NULL, '20', NULL, '167–192', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'partially_verified', '3.2.7', 'Erstnennung in Abschnitt 3.2.7.', 'Ruelle, David; Takens, Floris: On the Nature of Turbulence. Communications in Mathematical Physics, Bd. 20, 1971, S. 167–192.', 'Ruelle/Takens [72]', 'Quelle für Abschnitt 3.2.7.', 39, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(138, 73, 'kuznetsov_applied_bifurcation_theory_2004', 'book', 'Elements of Applied Bifurcation Theory', NULL, 1995, 2004, NULL, 'Springer', 'New York', NULL, NULL, NULL, '3rd Edition', NULL, NULL, NULL, 'en', 5, 'reference', 5, 'partially_verified', '3.2.8', 'Erstnennung in Abschnitt 3.2.8.', 'Kuznetsov, Yuri A.: Elements of Applied Bifurcation Theory. 3. Auflage. New York: Springer, 2004.', 'Kuznetsov [73]', 'Standardwerk zur lokalen und angewandten Bifurkationstheorie.', 40, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(139, 74, 'guckenheimer_holmes_nonlinear_oscillations_1983', 'book', 'Nonlinear Oscillations, Dynamical Systems, and Bifurcations of Vector Fields', NULL, 1983, 1983, NULL, 'Springer', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'reference', 5, 'partially_verified', '3.2.8', 'Erstnennung in Abschnitt 3.2.8.', 'Guckenheimer, John; Holmes, Philip: Nonlinear Oscillations, Dynamical Systems, and Bifurcations of Vector Fields. New York: Springer, 1983.', 'Guckenheimer/Holmes [74]', 'Standardwerk zu nichtlinearen Schwingungen, Bifurkationen und chaotischer Dynamik.', 40, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(140, 75, 'shannon_mathematical_theory_communication_1948', 'journal_article', 'A Mathematical Theory of Communication', NULL, 1948, 1948, 'Bell System Technical Journal', NULL, NULL, '27', NULL, '379–423; 623–656', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.2.9', 'Erstnennung zur mathematischen Definition von Information und Entropie.', 'Shannon, Claude E.: A Mathematical Theory of Communication. Bell System Technical Journal, Bd. 27, 1948, S. 379–423 und 623–656.', 'Shannon [75]', 'Primärquelle der mathematischen Informationstheorie.', 41, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(141, 76, 'wiener_cybernetics_1948', 'book', 'Cybernetics or Control and Communication in the Animal and the Machine', NULL, 1948, 1948, NULL, 'Hermann / MIT Press', 'Paris / Cambridge, Massachusetts', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.2.9', 'Erstnennung zur funktionalen Bedeutung von Information in Rückkopplungs- und Regelungssystemen.', 'Wiener, Norbert: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann; Cambridge, Massachusetts: MIT Press, 1948.', 'Wiener [76]', 'Grundlagenwerk der Kybernetik.', 41, '2026-07-15 17:27:45', '2026-07-15 17:27:45'),
(142, 77, 'euler_koenigsberger_bruecken_1736', 'journal_article', 'Solutio problematis ad geometriam situs pertinentis', NULL, 1736, 1736, 'Commentarii Academiae Scientiarum Imperialis Petropolitanae', NULL, NULL, '8', NULL, '128–140', NULL, NULL, NULL, NULL, 'la', 5, 'primary', 5, 'verified', '3.2.10', 'Erstnennung zur historischen Entstehung der Graphentheorie.', 'Euler, Leonhard: Solutio problematis ad geometriam situs pertinentis. Commentarii Academiae Scientiarum Imperialis Petropolitanae, Bd. 8, 1736, S. 128–140.', 'Euler [77]', 'Primärquelle des Königsberger Brückenproblems.', 47, '2026-07-15 17:27:46', '2026-07-15 17:27:46'),
(143, 78, 'diestel_graph_theory_2017', 'book', 'Graph Theory', NULL, 1997, 2017, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '5th Edition', NULL, NULL, NULL, 'en', 5, 'reference', 5, 'verified', '3.2.10', 'Erstnennung als modernes Standardwerk der Graphentheorie.', 'Diestel, Reinhard: Graph Theory. 5. Auflage. Berlin: Springer, 2017.', 'Diestel [78]', 'Standardwerk für Definitionen und strukturelle Eigenschaften von Graphen.', 47, '2026-07-15 17:27:46', '2026-07-15 17:27:46'),
(144, 79, 'watts_strogatz_small_world_1998', 'journal_article', 'Collective Dynamics of Small-World Networks', NULL, 1998, 1998, 'Nature', NULL, NULL, '393', NULL, '440–442', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.2.11', 'Erstnennung zum Small-World-Modell.', 'Watts, Duncan J.; Strogatz, Steven H.: Collective Dynamics of Small-World Networks. Nature, Bd. 393, 1998, S. 440–442.', 'Watts/Strogatz [79]', 'Primärquelle des Small-World-Netzwerkmodells.', 45, '2026-07-15 17:27:46', '2026-07-15 17:27:46'),
(145, 80, 'barabasi_albert_scaling_random_networks_1999', 'journal_article', 'Emergence of Scaling in Random Networks', NULL, 1999, 1999, 'Science', NULL, NULL, '286', NULL, '509–512', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 5, 'verified', '3.2.11', 'Erstnennung zu skalenfreien Netzwerken und Preferential Attachment.', 'Barabási, Albert-László; Albert, Réka: Emergence of Scaling in Random Networks. Science, Bd. 286, 1999, S. 509–512.', 'Barabási/Albert [80]', 'Primärquelle des skalenfreien Netzwerkmodells.', 45, '2026-07-15 17:27:46', '2026-07-15 17:27:46'),
(146, 81, 'freeman_centrality_social_networks_1978', 'journal_article', 'Centrality in Social Networks: Conceptual Clarification', NULL, 1978, 1978, 'Social Networks', NULL, NULL, '1', '3', '215–239', NULL, NULL, NULL, NULL, 'en', 5, 'primary', 4, 'verified', '3.2.11', 'Erstnennung als Primärquelle zur Systematisierung von Zentralitätsmaßen.', 'Freeman, Linton C.: Centrality in Social Networks: Conceptual Clarification. Social Networks, Bd. 1, Nr. 3, 1978, S. 215–239.', 'Freeman [81]', 'Primärquelle zur Konzeptualisierung von Grad-, Closeness- und Betweenness-Zentralität.', 45, '2026-07-15 17:27:46', '2026-07-15 17:27:46');

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
(131, 7, 1, 'author'),
(132, 73, 1, 'author'),
(133, 87, 1, 'author'),
(134, 16, 1, 'author'),
(135, 88, 1, 'author'),
(136, 89, 1, 'author'),
(137, 90, 1, 'author'),
(137, 91, 2, 'author'),
(138, 92, 1, 'author'),
(139, 93, 1, 'author'),
(139, 94, 2, 'author'),
(140, 95, 1, 'author'),
(141, 96, 1, 'author'),
(142, 109, 1, 'author'),
(143, 110, 1, 'author'),
(144, 105, 1, 'author'),
(144, 106, 2, 'author'),
(145, 15, 1, 'author'),
(145, 107, 2, 'author'),
(146, 115, 1, 'author');

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
(325, 23, 9, 'historical_context', 'Cantors Arbeiten begründen den modernen Mengenbegriff, die transfinite Mengenlehre, die Potenzmengenbildung und den Satz über die größere Mächtigkeit der Potenzmenge.', '3.2.1: historische Entwicklung und Mengenoperationen', 0, 1, 'Bestehende Quelle [23] wird wiederverwendet.', 24),
(326, 24, 9, 'state_of_research', 'Zermelos Axiomatisierung begrenzt zulässige Mengenbildungen und fundiert Extensionalität, Aussonderung, Vereinigung und Potenzmenge.', '3.2.1: axiomatische Fundierung und Mengenoperationen', 0, 1, 'Bestehende Quelle [24] wird wiederverwendet.', 24),
(327, 63, 9, 'first_citation', 'Das Referenzwerk systematisiert die axiomatischen Grundlagen von ZFC und grenzt Konstruktion vorhandener Mengen von einer Erklärung ihrer Genese ab.', '3.2.1: axiomatische Einordnung und wissenschaftliche Grenze', 1, 1, 'Neue Erstnennung [58].', 24),
(328, 27, 10, 'state_of_research', 'Enderton fundiert den mengentheoretischen Relationsbegriff, geordnete Paare, kartesische Produkte und grundlegende Relationseigenschaften.', 'Abschnitt 3.2.2', 0, 1, 'Neufassung V2.', 25),
(329, 28, 10, 'state_of_research', 'Davey und Priestley fundieren Halbordnungen, Totalordnungen und hierarchische relationale Strukturen.', 'Abschnitt 3.2.2', 0, 1, 'Neufassung V2.', 25),
(330, 69, 10, 'first_citation', 'Tarski fundiert Relationskomposition und die algebraische Behandlung von Relationen.', 'Abschnitt 3.2.2', 1, 1, 'Neufassung V2.', 25),
(331, 70, 11, 'first_citation', 'Historische Entwicklung des modernen Funktionsbegriffs und Ablösung von einer ausschließlich analytischen Darstellung.', 'Historische Entwicklung in 3.2.3', 1, 1, 'Neufassung 3.2.3 V2.', 26),
(332, 29, 11, 'definition', 'Formale Definition einer Funktion, Bild, Urbild sowie Existenz- und Eindeutigkeitsbedingungen.', 'Definitionen in 3.2.3', 0, 1, 'Neufassung 3.2.3 V2.', 26),
(333, 30, 11, 'definition', 'Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung.', 'Eigenschaften in 3.2.3', 0, 1, 'Neufassung 3.2.3 V2.', 26),
(334, 81, 12, 'first_citation', 'Historische Entstehung der Gruppentheorie aus der Analyse algebraischer Gleichungen.', 'Einleitung 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(335, 82, 12, 'first_citation', 'Strukturelle Ring- und Idealtheorie als Wendepunkt der modernen Algebra.', 'Einleitung sowie Ringabschnitt 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(336, 83, 12, 'first_citation', 'Systematische Definition algebraischer Grundstrukturen von der binären Verknüpfung bis zum Vektorraum.', 'Definitionen und Strukturhierarchie 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(337, 84, 12, 'first_citation', 'Gruppen, Untergruppen, Homomorphismen und Isomorphismen.', 'Gruppenabschnitt 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(338, 85, 12, 'first_citation', 'Zusammenhang von Symmetriegruppen und Erhaltungssätzen.', 'Symmetrieabschnitt 3.2.4', 1, 1, 'Neufassung 3.2.4 V2.', 29),
(339, 131, 13, 'first_citation', 'Historische Entwicklung linearer Integraloperatoren', 'Einleitender Forschungsstand zu Hilbert', 1, 1, 'Neue Erstnennung [66].', 31),
(340, 132, 13, 'first_citation', 'Allgemeine Theorie linearer Operatoren auf normierten Räumen', 'Einleitender Forschungsstand zu Banach', 1, 1, 'Neue Erstnennung [67].', 31),
(341, 35, 13, 'definition', 'Allgemeiner Operatorbegriff, Komposition und Spektrum', 'Mathematische Definitionen und Operatoralgebra', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 31),
(342, 36, 13, 'definition', 'Lineare Operatoren, Kern, Bild und Invertierbarkeit', 'Abschnitte zu linearen Operatoren und Operatoralgebra', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 31),
(343, 11, 13, 'background', 'Spektraltheorie und Operatoren auf Funktionenräumen', 'Abschnitt zum Spektrum', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 31),
(344, 133, 14, 'first_citation', 'Moderner Zustandsraumansatz mit internem Zustandsvektor.', 'Einleitender Forschungsstand und Zustandsdefinition', 1, 1, 'Neue Erstnennung [68].', 38),
(345, 134, 14, 'first_citation', 'Kontinuierliche Zustandsentwicklung, Anfangswertproblem, Fluss und Trajektorie.', 'Kontinuierliche Zustandsentwicklung', 1, 1, 'Neue Erstnennung [69].', 38),
(346, 38, 14, 'method', 'Zustandsraumdarstellung, Nebenbedingungen und Übergangsabbildungen.', 'Vollständige Zustandsbeschreibung und zulässige Zustände', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 38),
(347, 39, 14, 'definition', 'Gleichgewichtspunkte und nichtlineare Systemdarstellungen.', 'Gleichgewichtszustände', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 38),
(348, 40, 14, 'state_of_research', 'Diskrete Dynamik, Trajektorien und geometrische Interpretation dynamischer Systeme.', 'Diskrete Zustandsentwicklung und Trajektorien', 0, 1, 'Bestehende Standardquelle wiederverwendet.', 38),
(349, 135, 15, 'first_citation', 'Grundlagen der Lyapunov-Stabilität und Lyapunov-Funktionen.', 'Stabilität und Lyapunov-Funktionen', 1, 1, 'Neue Erstnennung [70].', 39),
(350, 136, 15, 'first_citation', 'LaSalle-Invarianzprinzip und asymptotische Stabilitätsanalyse.', 'Invarianz und LaSalle-Prinzip', 1, 1, 'Neue Erstnennung [71].', 39),
(351, 137, 15, 'first_citation', 'Seltsame Attraktoren und komplexe Langzeitdynamik.', 'Attraktoren', 1, 1, 'Neue Erstnennung [72].', 39),
(352, 40, 15, 'state_of_research', 'Trajektorien, periodische Bahnen und Grenzmengen dynamischer Systeme.', 'Attraktorformen und Omega-Grenzmengen', 0, 1, 'Bestehende Quelle [40].', 39),
(353, 134, 15, 'background', 'Flüsse und Gleichgewichtspunkte als Grundlage der Stabilitätsanalyse.', 'Einleitung und Invarianz', 0, 1, 'Bestehende Quelle [69].', 39),
(354, 138, 16, 'first_citation', 'Lokale Bifurkationstheorie, kritische Parameter und Normalformen.', 'Einleitung, Linearisierung und elementare Bifurkationen', 1, 1, 'Neue Erstnennung [73].', 40),
(355, 139, 16, 'first_citation', 'Nichtlineare Schwingungen, Dynamik und Bifurkationen von Vektorfeldern.', 'Nichtlinearität, Hopf-Bifurkation und wissenschaftliche Einordnung', 1, 1, 'Neue Erstnennung [74].', 40),
(356, 134, 16, 'background', 'Flüsse, Gleichgewichtspunkte und gewöhnliche Differentialgleichungen.', 'Mathematischer Ausgangsrahmen', 0, 1, 'Bestehende Quelle [69].', 40),
(357, 135, 16, 'comparison', 'Stabilitätsbegriff als Voraussetzung der Analyse von Stabilitätswechseln.', 'Linearisierung und Eigenwertkriterien', 0, 1, 'Bestehende Quelle [70].', 40),
(358, 136, 16, 'comparison', 'Invarianz und asymptotische Dynamik als Bezugspunkt für Strukturwechsel.', 'Übergang zu Attraktoren und Emergenz', 0, 1, 'Bestehende Quelle [71].', 40),
(359, 137, 16, 'state_of_research', 'Attraktoren als asymptotische Organisationsformen vor und nach Bifurkationen.', 'Emergenz und Attraktorwechsel', 0, 1, 'Bestehende Quelle [72].', 40),
(360, 140, 17, 'first_citation', 'Begründung der mathematischen Informationstheorie sowie der Shannon-Entropie.', 'Einleitung und Selbstinformation', 1, 1, 'Neue Erstnennung [75].', 41),
(361, 140, 17, 'definition', 'Definitionen von Entropie, bedingter Entropie, Mutual Information und Divergenzmaßen.', 'Gesamter mathematischer Formalismus 3.2.9', 0, 1, 'Primärquelle und etablierte Weiterentwicklung.', 41),
(362, 141, 17, 'first_citation', 'Funktionale Bedeutung von Information in Kommunikation, Steuerung und Rückkopplung.', 'Einleitender Forschungsstand', 1, 1, 'Neue Erstnennung [76].', 41),
(363, 141, 17, 'comparison', 'Vergleich der quantitativen Shannon-Perspektive mit der funktionalen kybernetischen Perspektive.', 'Wissenschaftliche Einordnung', 0, 1, 'Ergänzende Primärquelle.', 41),
(364, 142, 18, 'first_citation', 'Historische Begründung der Graphentheorie durch das Königsberger Brückenproblem.', 'Einleitender Forschungsstand', 1, 1, 'Neue Erstnennung [77].', 47),
(365, 143, 18, 'first_citation', 'Moderne Definitionen und Eigenschaften von Graphen und Netzwerken.', 'Definition eines Graphen und folgende mathematische Grundlagen', 1, 1, 'Neue Erstnennung [78].', 47),
(366, 143, 18, 'definition', 'Adjazenzmatrix, Knotengrad, Wege, Distanzen, Zusammenhang und Gewichtung.', 'Gesamter mathematischer Formalismus 3.2.10', 0, 1, 'Zentrale Standardquelle.', 47),
(367, 144, 19, 'first_citation', 'Small-World-Strukturen mit hoher Clusterung und kurzen Wegen.', 'Einleitung und Small-World-Netzwerke', 1, 1, 'Neue Erstnennung [79].', 45),
(368, 145, 19, 'first_citation', 'Skalenfreie Netzwerke und potenzgesetzartige Gradverteilungen.', 'Einleitung und skalenfreie Netzwerke', 1, 1, 'Neue Erstnennung [80].', 45),
(369, 146, 19, 'first_citation', 'Systematisierung zentraler Netzwerkmaße.', 'Zentralitätsmaße', 1, 1, 'Neue Erstnennung [81].', 45),
(370, 144, 19, 'definition', 'Clusterkoeffizient und mittlere Weglänge als globale Netzwerkparameter.', 'Gleichungen (3.271)–(3.273)', 0, 1, 'Primärquelle und etablierte Netzwerktheorie.', 45),
(371, 145, 19, 'definition', 'Potenzgesetz der Knotengrade und Hub-Struktur.', 'Gleichung (3.274)', 0, 1, 'Primärquelle.', 45),
(372, 146, 19, 'definition', 'Grad-, Closeness- und Betweenness-Zentralität.', 'Gleichungen (3.267)–(3.269)', 0, 1, 'Primärquelle.', 45),
(373, 23, 20, 'state_of_research', 'Mengenlehre als grundlegende mathematische Sprache, die unterscheidbare Objekte voraussetzt.', 'Gesamtsynthese der mathematischen Grundlagen', 0, 1, 'Wiederverwendung von [23].', 49),
(374, 24, 20, 'state_of_research', 'Axiomatische Begrenzung zulässiger mengentheoretischer Konstruktionen.', 'Gesamtsynthese der mathematischen Grundlagen', 0, 1, 'Wiederverwendung von [24].', 49),
(375, 29, 20, 'state_of_research', 'Funktionen als eindeutige gerichtete Zuordnungen.', 'Gesamtsynthese der mathematischen Grundlagen', 0, 1, 'Wiederverwendung von [29].', 49),
(376, 38, 20, 'state_of_research', 'Zustandsraumdarstellung und systemtheoretische Modellierung.', 'Gesamtsynthese dynamischer Systeme', 0, 1, 'Wiederverwendung von [38].', 49),
(377, 40, 20, 'state_of_research', 'Trajektorien und qualitative Organisation dynamischer Systeme.', 'Gesamtsynthese dynamischer Systeme', 0, 1, 'Wiederverwendung von [40].', 49),
(378, 140, 20, 'critique', 'Probabilistische Informationstheorie quantifiziert Unbestimmtheit, klammert die funktionale Semantik jedoch aus.', 'Informationstheoretische Grenze', 0, 1, 'Wiederverwendung von [75].', 49),
(379, 143, 20, 'critique', 'Graphentheorie analysiert explizit vorgegebene Knoten und Kanten, nicht deren funktionale Genese.', 'Graphentheoretische Grenze', 0, 1, 'Wiederverwendung von [78].', 49),
(380, 144, 20, 'comparison', 'Small-World-Strukturen illustrieren globale Organisation aus lokalen Verknüpfungen.', 'Netzwerktheoretische Synthese', 0, 1, 'Wiederverwendung von [79].', 49),
(381, 145, 20, 'comparison', 'Skalenfreie Netzwerke illustrieren makroskopische Strukturentstehung aus lokalen Wachstumsregeln.', 'Netzwerktheoretische Synthese', 0, 1, 'Wiederverwendung von [80].', 49),
(382, 143, 20, 'research_gap', 'Es fehlt ein formales System zur Genese funktionaler Relationen und zur Rekonstruktion daraus hervorgehender Raum-Zeit-Strukturen.', 'Systematische Forschungslücke', 0, 1, 'Zusammenfassende Ableitung aus Kapitel 3.2.', 49);

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
(196, 'R', 'R', 'Relation', 'Binäre Relation zwischen mathematischen Elementen.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(197, 'R^{-1}', 'R^{-1}', 'inverse Relation', 'Relation mit vertauschten Komponenten.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(198, 'operatorname{dom}(R)', 'operatorname{dom}(R)', 'Definitionsbereich', 'Menge aller ersten Komponenten einer Relation.', 'section', 10, NULL, NULL, 'Menge', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(199, 'operatorname{ran}(R)', 'operatorname{ran}(R)', 'Wertebereich', 'Menge aller zweiten Komponenten einer Relation.', 'section', 10, NULL, NULL, 'Menge', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(200, 'preceq', 'preceq', 'Ordnungsrelation', 'Symbol für eine Halb- oder Totalordnung.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(201, 'Scirc R', 'Scirc R', 'Relationskomposition', 'Komposition zweier Relationen.', 'section', 10, NULL, NULL, 'Relation', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(202, 'A/R', 'A/R', 'Quotientenmenge', 'Menge der Äquivalenzklassen von A bezüglich R.', 'section', 10, NULL, NULL, 'Menge', NULL, 0, 0, 0, 'Abschnitt 3.2.2 V2.', 'checked', 25),
(203, 'f', 'f', 'Funktion', 'Eindeutige Abbildung von A nach B.', 'section', 11, NULL, NULL, 'A', 'B', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(204, 'f^{-1}', 'f^{-1}', 'Umkehrfunktion', 'Inverse Abbildung einer bijektiven Funktion.', 'section', 11, NULL, NULL, 'B', 'A', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(205, 'g\\circ f', 'g\\circ f', 'Funktionskomposition', 'Verkettung zweier kompositionsverträglicher Funktionen.', 'section', 11, NULL, NULL, 'A', 'C', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(206, '\\operatorname{id}_A', '\\operatorname{id}_A', 'Identitätsabbildung', 'Neutrale Abbildung auf A.', 'section', 11, NULL, NULL, 'A', 'A', 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.3.', 'checked', 26),
(207, 'star', 'star', 'binäre Verknüpfung', 'Abgeschlossene innere binäre Verknüpfung.', 'section', 12, 798, NULL, 'A×A', 'A', 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(208, 'e', 'e', 'neutrales Element', 'Element, das unter der Verknüpfung keine Änderung bewirkt.', 'section', 12, 806, NULL, 'A', 'A', 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(209, 'a^{-1}', 'a^{-1}', 'inverses Element', 'Inverse zu a bezüglich der Gruppenverknüpfung.', 'section', 12, 813, NULL, 'A', 'A', 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(210, 'varphi', 'varphi', 'Homomorphismus', 'Strukturerhaltende Abbildung zwischen algebraischen Strukturen.', 'section', 12, 819, NULL, NULL, NULL, 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(211, 'R', 'R', 'Ring', 'Trägermenge mit additiver und multiplikativer Verknüpfung.', 'section', 12, 821, NULL, 'Ring', NULL, 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(212, 'K', 'K', 'Skalarkörper', 'Körper der Skalare eines Vektorraums.', 'section', 12, 832, NULL, 'Körper', NULL, 0, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(213, 'V', 'V', 'Vektorraum', 'Vektorraum über dem Körper K.', 'section', 12, 832, NULL, 'Vektorraum', NULL, 1, 0, 0, 'Neufassung 3.2.4 V2.', 'checked', 29),
(214, 'T', 'T', 'Operator', 'Abbildung zwischen mathematisch strukturierten Räumen.', 'global', 13, 840, NULL, 'X', 'Y', 0, 0, 1, 'Zentrales Operatorsymbol.', 'checked', 31),
(215, '\\mathcal{D}(T)', '\\mathcal{D}(T)', 'Definitionsbereich eines Operators', 'Tatsächlicher Bereich, auf dem T definiert ist.', 'section', 13, 845, NULL, 'Operator T', 'Teilmenge von X', 0, 0, 0, 'Domäne des Operators.', 'checked', 31),
(216, '\\mathcal{R}(T)', '\\mathcal{R}(T)', 'Wertebereich eines Operators', 'Menge aller von T erzeugten Bilder.', 'section', 13, 847, NULL, 'Operator T', 'Teilmenge von Y', 0, 0, 0, 'Range des Operators.', 'checked', 31),
(217, '\\ker(T)', '\\ker(T)', 'Kern eines Operators', 'Menge aller auf Null abgebildeten Elemente.', 'section', 13, 851, NULL, 'linearer Operator T', 'Unterraum von X', 0, 0, 0, 'Nullraum.', 'checked', 31),
(218, '\\operatorname{im}(T)', '\\operatorname{im}(T)', 'Bild eines Operators', 'Menge aller erreichbaren Operatorbilder.', 'section', 13, 852, NULL, 'linearer Operator T', 'Unterraum von Y', 0, 0, 0, 'Bildraum.', 'checked', 31),
(219, 'I_X', 'I_X', 'Identitätsoperator', 'Neutrale Transformation auf X.', 'section', 13, 860, NULL, 'X', 'X', 0, 0, 1, 'Neutrales Element der Komposition.', 'checked', 31),
(220, 'T^{-1}', 'T^{-1}', 'Inverser Operator', 'Umkehrabbildung eines invertierbaren Operators.', 'section', 13, 863, NULL, 'Y', 'X', 0, 0, 1, 'Existiert nur bei Invertierbarkeit.', 'checked', 31),
(221, '\\operatorname{End}(V)', '\\operatorname{End}(V)', 'Endomorphismenmenge', 'Menge aller linearen Endomorphismen von V.', 'section', 13, 865, NULL, 'Vektorraum V', 'Operatorraum', 0, 0, 0, 'Träger der Operatoralgebra.', 'checked', 31),
(222, '\\sigma(T)', '\\sigma(T)', 'Spektrum eines Operators', 'Menge der Werte, für die T minus Lambda I nicht invertierbar ist.', 'section', 13, 868, NULL, 'Operator T', 'Teilmenge von \\mathbb C', 0, 0, 0, 'Spektrale Charakterisierung.', 'checked', 31),
(223, 'X', 'x', 'Zustand', 'Einzelner Zustand eines Systems.', 'section', 14, 869, NULL, 'X', NULL, 1, 0, 0, 'Kontextabhängig skalar, Vektor oder Funktion.', 'checked', 38),
(224, 'F', 'F', 'Entwicklungs- oder Übergangsabbildung', 'Regel zur Erzeugung von Folgezuständen.', 'section', 14, 872, NULL, 'X', 'X', 0, 0, 1, 'Diskrete oder kontinuierliche Dynamik.', 'checked', 38),
(225, 'X_{mathrm{zul}}', 'X_{mathrm{zul}}', 'zulässiger Zustandsraum', 'Teilmenge aller nebenbedingungskonformen Zustände.', 'section', 14, 874, NULL, 'X', NULL, 0, 0, 0, 'Durch Modellnebenbedingungen eingeschränkt.', 'checked', 38),
(226, 'Phi', 'Phi', 'Fluss', 'Zeitparametrisierte Familie von Zustandsabbildungen.', 'section', 14, 885, NULL, 'mathbb R	imes X', 'X', 0, 0, 1, 'Kontinuierliche Zustandsentwicklung.', 'checked', 38),
(227, 'gamma(x_0)', 'gamma(x_0)', 'Trajektorie', 'Menge der aus x0 entlang des Flusses erreichten Zustände.', 'section', 14, 889, NULL, 'Zeitintervall', 'Teilmenge von X', 0, 0, 0, 'Geometrische Bahn im Zustandsraum.', 'checked', 38),
(228, 'x^ast', 'x^ast', 'Gleichgewichtspunkt', 'Zustand mit verschwindender Dynamik.', 'section', 14, 890, NULL, 'X', NULL, 0, 0, 0, 'Invarianter stationärer Zustand.', 'checked', 38),
(230, '\\mu', '\\mu', 'Kontrollparameter', 'Parameter, dessen Variation qualitative Änderungen der Dynamik auslösen kann.', 'section', 16, 917, NULL, '\\mathbb{R}^p', NULL, 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(231, 'F', 'F', 'nichtlineares Vektorfeld', 'Parameterabhängiges Entwicklungsgesetz des Systems.', 'section', 16, 917, NULL, 'X\\times\\mathbb{R}^p', 'TX', 0, 0, 1, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(232, 'N(x,\\mu)', 'N(x,\\mu)', 'nichtlinearer Anteil', 'Nichtlinearer Anteil des Entwicklungsgesetzes.', 'section', 16, 919, NULL, NULL, NULL, 0, 0, 1, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(233, '\\xi', '\\xi', 'lokale Abweichung', 'Lokale Abweichung vom Gleichgewichtspunkt.', 'section', 16, 923, NULL, '\\mathbb{R}^n', NULL, 1, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(234, 'J', 'J', 'Jacobi-Matrix', 'Linearisierung des Vektorfeldes am Gleichgewichtspunkt.', 'section', 16, 926, NULL, '\\mathbb{R}^{n\\times n}', '\\mathbb{R}^{n\\times n}', 0, 1, 0, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(235, '\\lambda_i', '\\lambda_i', 'Eigenwert', 'Eigenwert der Jacobi-Matrix.', 'section', 16, 927, NULL, '\\mathbb{C}', NULL, 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(236, '\\mu_c', '\\mu_c', 'kritischer Parameterwert', 'Parameterwert einer möglichen Bifurkation.', 'section', 16, 929, NULL, '\\mathbb{R}', NULL, 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(237, '\\Phi_\\mu', '\\Phi_\\mu', 'parameterabhängiger Fluss', 'Dynamischer Fluss für einen festen Parameterwert.', 'section', 16, 930, NULL, NULL, NULL, 0, 0, 1, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(238, 'A(\\mu)', 'A(\\mu)', 'parameterabhängiger Attraktor', 'Asymptotische Organisationsform des Systems beim Parameterwert mu.', 'section', 16, 944, NULL, NULL, NULL, 0, 0, 0, 'Zentrales Symbol des Abschnitts 3.2.8.', 'checked', 40),
(239, '\\mathcal X', '\\mathcal X', 'Alphabet', 'Menge möglicher Werte einer diskreten Zufallsvariablen.', 'section', 17, 945, NULL, '\\{x_1,\\ldots,x_n\\}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(240, 'p_i', 'p_i', 'Ereigniswahrscheinlichkeit', 'Wahrscheinlichkeit des i-ten Ereignisses.', 'section', 17, 946, NULL, '[0,1]', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(241, 'I', 'I', 'Selbstinformation', 'Informationsgehalt eines Einzelereignisses.', 'section', 17, 949, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(242, 'H', 'H', 'Shannon-Entropie', 'Mittlere probabilistische Unbestimmtheit.', 'section', 17, 956, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(243, 'H(X|Y)', 'H(X|Y)', 'bedingte Entropie', 'Verbleibende Unsicherheit von X bei Kenntnis von Y.', 'section', 17, 965, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(244, 'I(X;Y)', 'I(X;Y)', 'gegenseitige Information', 'Informationsabhängigkeit zwischen X und Y.', 'section', 17, 969, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(245, 'D_{KL}', 'D_{KL}', 'Kullback-Leibler-Divergenz', 'Gerichteter Vergleich zweier Wahrscheinlichkeitsverteilungen.', 'section', 17, 972, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(246, 'D_{JS}', 'D_{JS}', 'Jensen-Shannon-Divergenz', 'Symmetrischer Vergleich zweier Wahrscheinlichkeitsverteilungen.', 'section', 17, 976, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.9.', 'checked', 41),
(247, 'G', 'G', 'Graph', 'Geordnetes Paar aus Knoten- und Kantenmenge.', 'section', 18, 978, NULL, NULL, NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.10.', 'checked', 47),
(248, 'V', 'V', 'Knotenmenge', 'Menge aller Knoten.', 'section', 18, 978, NULL, NULL, NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.10.', 'checked', 47),
(249, 'E', 'E', 'Kantenmenge', 'Menge aller Kanten.', 'section', 18, 978, NULL, NULL, NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.10.', 'checked', 47),
(250, 'A', 'A', 'Adjazenzmatrix', 'Binäre Matrixdarstellung eines endlichen Graphen.', 'section', 18, 984, NULL, '\\{0,1\\}^{n\\times n}', NULL, 0, 1, 0, 'Zentrales Symbol von Abschnitt 3.2.10.', 'checked', 47),
(251, 'd', 'd', 'Graphendistanz', 'Länge eines kürzesten Pfades zwischen zwei Knoten.', 'section', 18, 994, NULL, NULL, '\\mathbb N_0\\cup\\{\\infty\\}', 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.10.', 'checked', 47),
(252, 'w', 'W', 'gewichtete Adjazenzmatrix', 'Matrix der Kantengewichte.', 'section', 18, 998, NULL, '\\mathbb R^{n\\times n}', NULL, 0, 1, 0, 'Zentrales Symbol von Abschnitt 3.2.10.', 'checked', 47),
(254, 'C_D', 'C_D', 'Gradzentralität', 'Normierte lokale Vernetzung eines Knotens.', 'section', 19, 1000, NULL, '[0,1]', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(255, 'C_C', 'C_C', 'Closeness-Zentralität', 'Globale Erreichbarkeit eines Knotens.', 'section', 19, 1001, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(256, 'C_B', 'C_B', 'Betweenness-Zentralität', 'Vermittlungsfunktion eines Knotens.', 'section', 19, 1002, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(257, 'x', 'x', 'Eigenvektor-Zentralitätsvektor', 'Zentralitätswerte aller Knoten.', 'section', 19, 1003, NULL, '\\mathbb R^n', NULL, 1, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(258, 'C', 'C', 'Clusterkoeffizient', 'Lokale beziehungsweise globale Clusterung.', 'section', 19, 1004, NULL, '[0,1]', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(259, 'L', 'L', 'mittlere Weglänge', 'Durchschnitt der kürzesten Knotenabstände.', 'section', 19, 1005, NULL, '\\mathbb R_{\\ge0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(260, 'P(k)', 'P(k)', 'Gradverteilung', 'Wahrscheinlichkeitsverteilung der Knotengrade.', 'section', 19, 1007, NULL, '[0,1]', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45),
(261, '\\gamma', '\\gamma', 'Skalierungsexponent', 'Exponent der potenzgesetzartigen Gradverteilung.', 'section', 19, 1007, NULL, '\\mathbb R_{>0}', NULL, 0, 0, 0, 'Zentrales Symbol von Abschnitt 3.2.11.', 'checked', 45);

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
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=398;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;

--
-- AUTO_INCREMENT für Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=669;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=383;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

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
