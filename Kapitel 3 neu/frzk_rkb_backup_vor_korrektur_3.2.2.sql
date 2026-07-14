-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Jul 2026 um 09:16
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
(52, 52, 'Überblick über Komplexität, Emergenz und adaptive Systeme.', 'Ergänzende Quelle für den Emergenzbegriff.', 'Belegt das Auftreten globaler Eigenschaften aus lokalen Regeln.', 'Komplexität, Emergenz und Berechnung.', 'Übersichtswerk, keine mathematische Primärquelle.', 'Ergänzt [12], [14] und [51].', 'reviewed', '2026-07-12 08:10:57'),
(53, 64, 'Historische Primärquelle zur Erweiterung des Funktionsbegriffs über geschlossene analytische Ausdrücke hinaus.', 'Begründet in 3.2.3 den Übergang zum modernen Zuordnungsbegriff.', 'Belegt die wissenschaftshistorische Ablösung der Funktion von einer ausschließlich formelhaften Darstellung.', 'Eine Funktion wird über eine eindeutige Zuordnung von Argumenten zu Werten bestimmt.', 'Historische Darstellung; noch keine moderne mengentheoretische Formalisierung.', 'Wird durch Lang [29] und Rudin [30] formal präzisiert.', 'reviewed', '2026-07-14 07:28:52'),
(54, 65, 'Begründet Kategorien, Funktoren und natürliche Äquivalenzen als strukturelle Verallgemeinerung kompositionsfähiger Abbildungen.', 'Stützt die Einordnung der Funktionskomposition als universelles Strukturprinzip.', 'Belegt Assoziativität, Identitäten und die strukturelle Rolle von Abbildungen.', 'Komposition und Identitätsabbildungen bilden die Grundlage kategorialer Strukturen.', 'Die vollständige Kategorientheorie ist nicht Gegenstand von 3.2.3.', 'Dient als Ausblick auf Transformationen höherer Ordnung und Operatoren.', 'reviewed', '2026-07-14 07:28:52'),
(55, 66, 'Historische Systematisierung struktureller Algebra und strukturerhaltender Abbildungen.', 'Begründet Homomorphismen, Isomorphismen, Endomorphismen und Automorphismen.', 'Belegt den Übergang von punktweisen Zuordnungen zu strukturerhaltenden Transformationen.', 'Algebraische Strukturen werden durch verknüpfungserhaltende Abbildungen verglichen.', 'Historische Referenz; moderne Terminologie wird durch spätere Lehrwerke ergänzt.', 'Bereitet Abschnitt 3.2.4 zu algebraischen Strukturen vor.', 'reviewed', '2026-07-14 07:28:52');

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
(44, 'Levy', 'Azriel', 'Levy, Azriel', NULL, NULL, NULL, 'Mitautor von Foundations of Set Theory.'),
(45, 'Dirichlet', 'Peter Gustav Lejeune', 'Dirichlet, Peter Gustav Lejeune', NULL, 1805, 1859, 'Autor der Primärquelle zum modernen Funktionsbegriff.'),
(46, 'Eilenberg', 'Samuel', 'Eilenberg, Samuel', NULL, 1913, 1998, 'Mitautor der General Theory of Natural Equivalences.'),
(47, 'Mac Lane', 'Saunders', 'Mac Lane, Saunders', NULL, 1909, 2005, 'Mitautor der General Theory of Natural Equivalences.'),
(48, 'van der Waerden', 'Bartel Leendert', 'van der Waerden, Bartel Leendert', NULL, 1903, 1996, 'Autor von Moderne Algebra.');

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
(1, 'A1', 52, 'Prinzip der funktionalen Unterscheidbarkeit', 'Es existiert die Möglichkeit funktionaler Unterscheidbarkeit.', '\\exists\\,\\Delta_F', '\\exists\\,\\Delta_F', 'Minimal notwendige Voraussetzung jeder späteren funktionalen Organisation.', 'Keine modelltheoretische Unabhängigkeit behauptet; nur begrifflich eigenständiger Inhalt.', 'Das Axiom führt weder Mengen noch Funktionen, Räume oder Metriken ein.', 'Mathematische Konstruktion der Differenzstruktur erfolgt erst in Kapitel 3.4.', 1, 'review', 10),
(2, 'A2', 53, 'Prinzip der funktionalen Relationierbarkeit', 'Funktional unterscheidbare Konfigurationen besitzen grundsätzlich die Möglichkeit, funktional miteinander in Beziehung zu treten.', '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F', '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F', 'Funktionale Organisation erfordert neben Unterscheidbarkeit die Möglichkeit struktureller Zusammenhangsbildung.', 'Keine mengentheoretische Relation wird vorausgesetzt.', 'Relationierbarkeit wird ausschließlich als qualitative Möglichkeit eingeführt.', 'Formale Relationsstrukturen werden erst in Kapitel 3.4 konstruiert.', 2, 'review', 10),
(3, 'A3', 54, 'Prinzip der rekursiven Transformation', 'Funktionale Relationen besitzen grundsätzlich die Möglichkeit, rekursiv transformiert zu werden.', '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F', '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F', 'Wiederholbarkeit funktionaler Transformationen ist Voraussetzung stabiler Organisationsbildung.', 'Keine Folge, Iteration, Zeitordnung oder Operatoralgebra wird vorausgesetzt.', 'Transformation wird vor jeder zeitlichen Interpretation verwendet.', 'Operatoren und Rekursion werden erst in Kapitel 3.4 formalisiert.', 3, 'review', 10),
(4, 'A4', 55, 'Prinzip stabiler funktionaler Organisation', 'Rekursive funktionale Transformationen besitzen grundsätzlich das Potenzial, stabile Organisationsstrukturen hervorzubringen.', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', 'Rekursive Transformation allein garantiert noch keine Organisation; deren Möglichkeit muss gesondert angenommen werden.', 'Kein Zustandsraum, Attraktor oder Stabilitätsmaß wird vorausgesetzt.', 'Organisation bleibt ein qualitativer primitiver Begriff.', 'Mathematische Organisationsstrukturen werden erst in Kapitel 3.4 konstruiert.', 4, 'review', 10),
(5, 'A5', 56, 'Prinzip reproduzierbarer Organisationsmuster', 'Stabile funktionale Organisationsstrukturen besitzen grundsätzlich das Potenzial, reproduzierbare Organisationsmuster auszubilden.', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', 'Allgemeine wissenschaftliche Gesetzmäßigkeiten setzen prinzipiell reproduzierbare Organisationsmuster voraus.', 'Kohärenz, Konvergenz und metrische Stabilität werden noch nicht vorausgesetzt.', 'Reproduzierbarkeit bedeutet nicht notwendigerweise Identität.', 'Funktionale Äquivalenz und Kohärenz werden erst in Kapitel 3.4 formal definiert.', 5, 'review', 10);

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
(44, 'Def. 3.4.1', 61, 'Funktionale Konfiguration', 'Eine funktionale Konfiguration ist ein abstraktes mathematisches Objekt, das ausschließlich durch seine funktionalen Eigenschaften charakterisiert wird.', '\\omega\\in\\Omega_F', '\\omega\\in\\Omega_F', 'original', NULL, NULL, NULL, 'checked', 11),
(45, 'Def. 3.4.2', 61, 'Funktionale Differenzabbildung', 'Die funktionale Differenzabbildung ordnet jedem Paar funktionaler Konfigurationen einen nichtnegativen Wert ihrer funktionalen Verschiedenheit zu.', '\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}', '\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}', 'original', NULL, NULL, NULL, 'checked', 11),
(46, 'Def. 3.4.3', 61, 'Funktionale Identität', 'Zwei funktionale Konfigurationen heißen funktional identisch, wenn ihre funktionale Differenz gleich null ist.', '\\Delta_F(\\omega_i,\\omega_j)=0', '\\Delta_F(\\omega_i,\\omega_j)=0', 'original', NULL, NULL, NULL, 'checked', 11),
(47, 'Def. 3.4.4', 62, 'Funktionale Relation', 'Eine funktionale Relation ist eine Relation auf der Trägermenge funktionaler Konfigurationen.', '\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F', '\\mathcal{R}_F\\subseteq\\Omega_F\\times\\Omega_F', 'original', NULL, NULL, NULL, 'checked', 11),
(48, 'Def. 3.4.5', 62, 'Aktive Relation', 'Eine funktionale Relation heißt aktiv, wenn die funktionale Differenz der verbundenen Konfigurationen positiv ist.', '\\Delta_F(\\omega_i,\\omega_j)>0', '\\Delta_F(\\omega_i,\\omega_j)>0', 'original', NULL, NULL, NULL, 'checked', 11),
(49, 'Def. 3.4.6', 63, 'Funktionaler Transformationsoperator', 'Ein funktionaler Transformationsoperator bildet funktionale Relationen auf funktionale Relationen ab.', '\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F', '\\mathcal{T}_F:\\mathcal{R}_F\\longrightarrow\\mathcal{R}_F', 'original', NULL, NULL, NULL, 'checked', 11),
(50, 'Def. 3.4.7', 63, 'Rekursive Transformation', 'Eine Transformation heißt rekursiv, wenn ihre wiederholte Komposition zulässig ist.', '\\mathcal{T}_F^{\\,n}', '\\mathcal{T}_F^{\\,n}', 'original', NULL, NULL, NULL, 'checked', 11),
(51, 'Def. 3.4.8', 64, 'Organisationserzeugende Transformation', 'Eine Transformation heißt organisationserzeugend, wenn sie eine nichttriviale invariante Relationsstruktur hervorbringt.', '\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}', '\\mathcal{T}_F(\\mathcal{O})=\\mathcal{O}', 'original', NULL, NULL, NULL, 'checked', 11),
(52, 'Def. 3.4.9', 64, 'Funktionaler Organisationsraum', 'Ein funktionaler Organisationsraum ist das geordnete Paar aus einer invarianten Organisationsstruktur und dem auf ihr wirkenden Transformationsoperator.', '\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)', '\\mathfrak{O}_F=(\\mathcal{O},\\mathcal{T}_F)', 'original', NULL, NULL, NULL, 'checked', 11),
(53, 'Def. 3.4.10', 65, 'Funktionaler Zustand', 'Ein funktionaler Zustand ist eine eindeutig beschreibbare funktionale Konfiguration innerhalb eines Organisationsraums.', 'x\\in\\mathcal{X}_F', 'x\\in\\mathcal{X}_F', 'original', NULL, NULL, NULL, 'checked', 11),
(54, 'Def. 3.4.11', 65, 'Funktionaler Zustandsraum', 'Der funktionale Zustandsraum ist das Tripel aus Zustandsmenge, Organisationsstruktur und Transformationsoperator.', '\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)', '\\mathfrak{X}_F=(\\mathcal{X}_F,\\mathcal{O},\\mathcal{T}_F)', 'original', NULL, NULL, NULL, 'checked', 11),
(55, 'Def. 3.4.12', 66, 'Funktionale Kohärenz', 'Eine Zustandsmenge heißt funktional kohärent, wenn sie unter rekursiven Transformationen invariant bleibt.', '\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}', '\\mathcal{T}_F(\\mathcal{K})=\\mathcal{K}', 'original', NULL, NULL, NULL, 'checked', 11),
(56, 'Def. 3.4.13', 66, 'Kohärenzoperator', 'Der Kohärenzoperator ordnet funktionalen Zuständen kohärente Organisationsstrukturen zu.', '\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F', '\\Psi_F:\\mathcal{X}_F\\longrightarrow\\mathcal{K}_F', 'original', NULL, NULL, NULL, 'checked', 11),
(57, 'Def. 3.4.14', 67, 'Funktionale Erreichbarkeit', 'Ein Zustand ist von einem anderen funktional erreichbar, wenn eine endliche Folge rekursiver Transformationen ihn hervorbringt.', 'x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'x_i\\leadsto x_j\\Longleftrightarrow\\exists\\,n\\in\\mathbb{N}_0:\\;x_j=\\mathcal{T}_F^{\\,n}(x_i)', 'original', NULL, NULL, NULL, 'checked', 11),
(58, 'Def. 3.4.15', 67, 'Funktionale Raumstruktur', 'Die funktionale Raumstruktur ist das Paar aus funktionalem Zustandsraum und Erreichbarkeitsrelation.', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', '\\mathfrak{R}_F=(\\mathcal{X}_F,\\leadsto)', 'original', NULL, NULL, NULL, 'checked', 11),
(59, 'Def. 3.4.16', 68, 'Transformationsordnung', 'Die Transformationsordnung ordnet Zustände nach ihrer Erzeugung durch eine positive Anzahl rekursiver Transformationen.', 'x_i\\prec_T x_j', 'x_i\\prec_T x_j', 'original', NULL, NULL, NULL, 'checked', 11),
(60, 'Def. 3.4.17', 68, 'Funktionale Zeitstruktur', 'Die funktionale Zeitstruktur ist das Paar aus funktionaler Raumstruktur und Transformationsordnung.', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', '\\mathfrak{T}_F=(\\mathfrak{R}_F,\\prec_T)', 'original', NULL, NULL, NULL, 'checked', 11),
(61, 'Def. 3.2.3.1', 11, 'Funktion', 'Eine Funktion von A nach B ordnet jedem Element der Definitionsmenge A genau ein Element der Zielmenge B zu.', 'f:A\\longrightarrow B,\\quad \\forall a\\in A\\;\\exists!\\,b\\in B:\\;f(a)=b', 'f:A\\longrightarrow B,\\quad \\forall a\\in A\\;\\exists!\\,b\\in B:\\;f(a)=b', 'literature', 29, 'A und B sind Mengen.', 'Grunddefinition des Abschnitts.', 'checked', 23),
(62, 'Def. 3.2.3.2', 11, 'Bijektive Funktion', 'Eine Funktion ist bijektiv, wenn sie zugleich injektiv und surjektiv ist.', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv und surjektiv}', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv und surjektiv}', 'literature', 30, 'f:A\\to B ist eine Funktion.', 'Grundlage der Umkehrbarkeit.', 'checked', 23),
(63, 'Def. 3.2.3.3', 11, 'Homomorphismus', 'Ein Homomorphismus ist eine Funktion zwischen algebraischen Strukturen, welche die jeweilige Verknüpfung erhält.', 'f(x\\star y)=f(x)\\circ f(y)', 'f(x\\star y)=f(x)\\circ f(y)', 'literature', 66, 'Auf A und B sind Verknüpfungen definiert.', 'Überleitung zu 3.2.4.', 'checked', 23),
(64, 'Def. 3.2.3.4', 11, 'Isomorphismus', 'Ein Isomorphismus ist ein bijektiver Homomorphismus mit strukturerhaltender Umkehrabbildung.', 'f^{-1}\\circ f=\\operatorname{id}_{A}\\land f\\circ f^{-1}=\\operatorname{id}_{B}', 'f^{-1}\\circ f=\\operatorname{id}_{A}\\land f\\circ f^{-1}=\\operatorname{id}_{B}', 'literature', 66, 'f ist bijektiv und strukturtreu.', 'Strukturelle Äquivalenz.', 'checked', 23),
(65, 'Def. 3.2.3.5', 11, 'Endomorphismus', 'Ein Endomorphismus ist eine strukturerhaltende Abbildung einer Struktur in sich selbst.', 'f:A\\longrightarrow A', 'f:A\\longrightarrow A', 'literature', 66, 'A trägt eine algebraische Struktur.', 'Grundlage für Automorphismen und Endomorphismenmonoide.', 'checked', 23),
(66, 'Def. 3.2.3.6', 11, 'Automorphismus', 'Ein Automorphismus ist ein bijektiver Endomorphismus.', 'f\\in\\operatorname{Aut}(A)\\Longleftrightarrow f\\text{ ist bijektiver Endomorphismus}', 'f\\in\\operatorname{Aut}(A)\\Longleftrightarrow f\\text{ ist bijektiver Endomorphismus}', 'literature', 66, 'A trägt eine algebraische Struktur.', 'Formale Beschreibung von Struktursymmetrien.', 'checked', 23);

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
(11, 7, '3.2.3', 'Funktionen als mathematische Beschreibung gerichteter Transformationen', 3, 3.2300, 'review', 0, 'Am 14.07.2026 vollständig neu gefasst. Der Abschnitt verwendet die Quellen [29], [30], [35] und [59] bis [61] und enthält die Gleichungen (3.10) bis (3.25).', '2026-07-12 11:14:28', '2026-07-14 05:28:51'),
(12, 7, '3.2.4', 'Algebraische Strukturen als Grundlage mathematischer Operationen', 3, 3.2400, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(13, 7, '3.2.5', 'Operatorentheorie als mathematische Grundlage funktionaler Transformationen', 3, 3.2500, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(14, 7, '3.2.6', 'Zustandsräume als mathematische Grundlage funktionaler Entwicklungen', 3, 3.2600, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(15, 7, '3.2.7', 'Funktionalanalysis als mathematischer Rahmen unendlichdimensionaler Zustandsräume', 3, 3.2700, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(16, 7, '3.2.8', 'Dynamische Systeme als mathematische Beschreibung zeitlicher Entwicklungen', 3, 3.2800, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(17, 7, '3.2.9', 'Informationstheorie als mathematische Grundlage funktionaler Informationsprozesse', 3, 3.2900, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(18, 7, '3.2.10', 'Graphen- und Netzwerktheorie als mathematische Beschreibung komplexer Beziehungsstrukturen', 3, 3.3000, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(19, 7, '3.2.11', 'Metriken und Ähnlichkeitsmaße als Grundlage funktionaler Kohärenz', 3, 3.3100, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(20, 7, '3.2.12', 'Emergenz und Selbstorganisation als mathematische Grundlagen funktionaler Strukturbildung', 3, 3.3200, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(21, 7, '3.2.13', 'Grenzen bestehender mathematischer Modelle und Herleitung der Forschungslücke', 3, 3.3300, 'review', 0, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(22, NULL, '3.3', 'Axiomatische Grundlagen des Funktionalen Raum-Zeit-Kohärenzsystems', 3, 3.4000, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(23, NULL, '3.4', 'Mathematische Rekonstruktion funktionaler Organisation', 3, 3.5000, 'review', 1, 'Mathematische Eigenleistung: Rekonstruktion funktionaler Differenz-, Relations-, Transformations-, Organisations-, Zustands-, Kohärenz-, Raum- und Zeitstrukturen.', '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(49, 22, '3.3.0', 'Einleitung', 3, 3.4001, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(50, 22, '3.3.1', 'Primitive Begriffe und axiomatische Ausgangspunkte', 3, 3.4100, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(51, 22, '3.3.2', 'Wissenschaftstheoretische Begründung der primitiven Begriffe', 3, 3.4200, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(52, 22, '3.3.3', 'Axiom A1 – Prinzip der funktionalen Unterscheidbarkeit', 3, 3.4300, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(53, 22, '3.3.4', 'Axiom A2 – Prinzip der funktionalen Relationierbarkeit', 3, 3.4400, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(54, 22, '3.3.5', 'Axiom A3 – Prinzip der rekursiven Transformation', 3, 3.4500, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(55, 22, '3.3.6', 'Axiom A4 – Prinzip stabiler funktionaler Organisation', 3, 3.4600, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(56, 22, '3.3.7', 'Axiom A5 – Prinzip reproduzierbarer Organisationsmuster', 3, 3.4700, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(57, 22, '3.3.8', 'Zusammenfassung der axiomatischen Grundlagen', 3, 3.4800, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(58, 22, '3.3.9', 'Logische Konsequenzen des Axiomensystems', 3, 3.4900, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(60, 23, '3.4.0', 'Einleitung', 3, 3.5001, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(61, 23, '3.4.1', 'Konstruktion funktionaler Differenzstrukturen', 3, 3.5100, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(62, 23, '3.4.2', 'Konstruktion funktionaler Relationen', 3, 3.5200, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(63, 23, '3.4.3', 'Konstruktion rekursiver Transformationen', 3, 3.5300, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(64, 23, '3.4.4', 'Konstruktion funktionaler Organisationsräume', 3, 3.5400, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(65, 23, '3.4.5', 'Konstruktion funktionaler Zustandsräume', 3, 3.5500, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(66, 23, '3.4.6', 'Konstruktion funktionaler Kohärenz', 3, 3.5600, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(67, 23, '3.4.7', 'Rekonstruktion funktionaler Raumstrukturen', 3, 3.5700, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(68, 23, '3.4.8', 'Rekonstruktion funktionaler Zeitstrukturen', 3, 3.5800, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(69, 23, '3.4.9', 'Zusammenfassung der mathematischen Rekonstruktion', 3, 3.5900, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28'),
(70, 23, '3.4.10', 'Wissenschaftliche Konsequenzen der mathematischen Rekonstruktion', 3, 3.6000, 'review', 1, NULL, '2026-07-12 11:14:28', '2026-07-12 11:14:28');

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
(10, '3.10', 11, 'Funktion als Abbildung', 'f\\colon A\\longrightarrow B', 'f\\colon A\\longrightarrow B', 'Eine Funktion f bildet die Definitionsmenge A in die Zielmenge B ab.', 'definition', 'literature', 29, NULL, 'A und B sind Mengen.', 'checked', 23),
(11, '3.11', 11, 'Eindeutige Zuordnung', '\\forall a\\in A\\;\\exists!\\,b\\in B\\colon f(a)=b', '\\forall a\\in A\\;\\exists!\\,b\\in B\\colon f(a)=b', 'Jedem Element der Definitionsmenge wird genau ein Element der Zielmenge zugeordnet.', 'definition', 'literature', 29, NULL, 'f ist eine Funktion von A nach B.', 'checked', 23),
(12, '3.12', 11, 'Injektivität', '\\forall x_1,x_2\\in A\\colon f(x_1)=f(x_2)\\Longrightarrow x_1=x_2', '\\forall x_1,x_2\\in A\\colon f(x_1)=f(x_2)\\Longrightarrow x_1=x_2', 'Eine Funktion ist injektiv, wenn gleiche Bilder nur von gleichen Urbildern stammen.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 23),
(13, '3.13', 11, 'Surjektivität', '\\forall y\\in B\\;\\exists x\\in A\\colon f(x)=y', '\\forall y\\in B\\;\\exists x\\in A\\colon f(x)=y', 'Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge getroffen wird.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 23),
(14, '3.14', 11, 'Bijektivität', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv und surjektiv}', 'f\\text{ ist bijektiv}\\Longleftrightarrow f\\text{ ist injektiv und surjektiv}', 'Bijektivität ist die Verbindung von Injektivität und Surjektivität.', 'definition', 'literature', 30, NULL, 'f ist eine Funktion von A nach B.', 'checked', 23),
(15, '3.15', 11, 'Umkehrfunktion', 'f^{-1}\\colon B\\longrightarrow A', 'f^{-1}\\colon B\\longrightarrow A', 'Eine bijektive Funktion besitzt eine Umkehrfunktion von B nach A.', 'definition', 'literature', 30, NULL, 'f ist bijektiv.', 'checked', 23),
(16, '3.16', 11, 'Umkehrbeziehungen', 'f^{-1}(f(x))=x\\quad\\land\\quad f(f^{-1}(y))=y', 'f^{-1}(f(x))=x\\quad\\land\\quad f(f^{-1}(y))=y', 'Die Komposition einer bijektiven Funktion mit ihrer Umkehrfunktion ergibt die jeweiligen Identitäten.', 'derived', 'literature', 30, NULL, 'x\\in A, y\\in B und f ist bijektiv.', 'checked', 23),
(17, '3.17', 11, 'Komposition von Funktionen', '(g\\circ f)(x)=g(f(x))', '(g\\circ f)(x)=g(f(x))', 'Die Komposition wendet zunächst f und anschließend g an.', 'definition', 'literature', 65, NULL, 'f:A\\to B und g:B\\to C.', 'checked', 23),
(18, '3.18', 11, 'Assoziativität der Komposition', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'Die Komposition von Funktionen ist assoziativ.', 'derived', 'literature', 65, NULL, 'Die Definitions- und Zielmengen sind kompositionsverträglich.', 'checked', 23),
(19, '3.19', 11, 'Homomorphismus', 'f(x\\star y)=f(x)\\circ f(y)', 'f(x\\star y)=f(x)\\circ f(y)', 'Ein Homomorphismus erhält die Verknüpfungen der beteiligten algebraischen Strukturen.', 'definition', 'literature', 66, NULL, '(A,\\star) und (B,\\circ) sind algebraische Strukturen.', 'checked', 23),
(20, '3.20', 11, 'Isomorphiebeziehungen', 'f^{-1}\\circ f=\\operatorname{id}_{A}\\quad\\land\\quad f\\circ f^{-1}=\\operatorname{id}_{B}', 'f^{-1}\\circ f=\\operatorname{id}_{A}\\quad\\land\\quad f\\circ f^{-1}=\\operatorname{id}_{B}', 'Ein Isomorphismus besitzt eine strukturerhaltende Umkehrabbildung.', 'derived', 'literature', 66, NULL, 'f ist ein bijektiver Homomorphismus.', 'checked', 23),
(21, '3.21', 11, 'Endomorphismus', 'f\\colon A\\longrightarrow A', 'f\\colon A\\longrightarrow A', 'Ein Endomorphismus wirkt innerhalb derselben Struktur.', 'definition', 'literature', 66, NULL, 'A ist eine mathematische Struktur.', 'checked', 23),
(22, '3.22', 11, 'Automorphismus', 'f\\in\\operatorname{Aut}(A)\\Longleftrightarrow f\\text{ ist bijektiver Endomorphismus}', 'f\\in\\operatorname{Aut}(A)\\Longleftrightarrow f\\text{ ist bijektiver Endomorphismus}', 'Ein Automorphismus ist ein bijektiver Endomorphismus.', 'definition', 'literature', 66, NULL, 'A ist eine mathematische Struktur.', 'checked', 23),
(23, '3.23', 11, 'Menge aller Funktionen', 'B^{A}=\\{f\\mid f\\colon A\\longrightarrow B\\}', 'B^{A}=\\{f\\mid f\\colon A\\longrightarrow B\\}', 'B hoch A bezeichnet die Menge aller Funktionen von A nach B.', 'definition', 'literature', 35, NULL, 'A und B sind Mengen.', 'checked', 23),
(24, '3.24', 11, 'Identitätsabbildung', '\\operatorname{id}_{A}(x)=x', '\\operatorname{id}_{A}(x)=x', 'Die Identitätsabbildung lässt jedes Element unverändert.', 'definition', 'literature', 65, NULL, 'x\\in A.', 'checked', 23),
(25, '3.25', 11, 'Neutrales Element der Komposition', 'f\\circ\\operatorname{id}_{A}=\\operatorname{id}_{A}\\circ f=f', 'f\\circ\\operatorname{id}_{A}=\\operatorname{id}_{A}\\circ f=f', 'Die Identitätsabbildung ist das neutrale Element der Endomorphismenkomposition.', 'derived', 'literature', 65, NULL, 'f:A\\to A.', 'checked', 23),
(26, '3.26', 12, 'Assoziativität', '(a\\ast b)\\ast c=a\\ast(b\\ast c)', '(a\\ast b)\\ast c=a\\ast(b\\ast c)', 'Assoziativgesetz.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(27, '3.27', 12, 'Neutrales Element', 'a\\ast e=e\\ast a=a', 'a\\ast e=e\\ast a=a', 'Definition eines neutralen Elements.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(28, '3.28', 12, 'Inverses Element', 'a\\ast a^{-1}=a^{-1}\\ast a=e', 'a\\ast a^{-1}=a^{-1}\\ast a=e', 'Definition eines inversen Elements.', 'definition', 'literature', 31, NULL, NULL, 'checked', 6),
(29, '3.29', 12, 'Vektoraddition', '+:V\\times V\\rightarrow V', '+:V\\times V\\rightarrow V', 'Innere Addition im Vektorraum.', 'definition', 'literature', 34, NULL, NULL, 'checked', 6),
(30, '3.30', 12, 'Skalarmultiplikation', '\\cdot:K\\times V\\rightarrow V', '\\cdot:K\\times V\\rightarrow V', 'Skalarmultiplikation im Vektorraum.', 'definition', 'literature', 34, NULL, NULL, 'checked', 6),
(31, '3.31', 13, 'Operator', 'T:X\\rightarrow Y', 'T:X\\rightarrow Y', 'Allgemeine Operatordefinition.', 'definition', 'literature', 35, NULL, NULL, 'checked', 6),
(32, '3.32', 13, 'Operatorwirkung', 'y=T(x)', 'y=T(x)', 'Wirkung eines Operators auf ein Element.', 'definition', 'literature', 35, NULL, NULL, 'checked', 6),
(33, '3.33', 13, 'Linearität', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)=\\alpha T(x)+\\beta T(y)', 'Linearitätsbedingung eines Operators.', 'definition', 'literature', 35, NULL, NULL, 'checked', 6),
(34, '3.34', 13, 'Nichtlinearität', 'T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)', 'T(\\alpha x+\\beta y)\\neq\\alpha T(x)+\\beta T(y)', 'Abgrenzung eines nichtlinearen Operators.', 'definition', 'literature', 37, NULL, NULL, 'checked', 6),
(35, '3.35', 13, 'Operatorkomposition', '(T\\circ S)(x)=T(S(x))', '(T\\circ S)(x)=T(S(x))', 'Komposition zweier Operatoren.', 'definition', 'literature', 35, NULL, NULL, 'checked', 6),
(36, '3.36', 13, 'Operatoriteration', 'x_{n+1}=T(x_n)', 'x_{n+1}=T(x_n)', 'Rekursive Anwendung eines Operators.', 'model', 'literature', 37, NULL, NULL, 'checked', 6),
(37, '3.37', 14, 'Zustandsvektor', 'X=\\left(x_1,x_2,\\ldots,x_n\\right)^T', 'X=\\left(x_1,x_2,\\ldots,x_n\\right)^T', 'Vektorielle Darstellung eines Systemzustands.', 'definition', 'literature', 38, NULL, NULL, 'checked', 6),
(38, '3.38', 14, 'Zustandsraum', '\\mathcal{X}=\\left\\{X\\mid X\\text{ zulässig}\\right\\}', '\\mathcal{X}=\\left\\{X\\mid X\\text{ zulässig}\\right\\}', 'Menge aller zulässigen Systemzustände.', 'definition', 'literature', 38, NULL, NULL, 'checked', 6),
(39, '3.39', 14, 'Diskrete Zustandsentwicklung', 'X(t+\\Delta t)=F\\!\\left(X(t)\\right)', 'X(t+\\Delta t)=F\\!\\left(X(t)\\right)', 'Diskrete Zustandsentwicklung.', 'model', 'literature', 38, NULL, NULL, 'checked', 6),
(40, '3.40', 14, 'Kontinuierliche Zustandsentwicklung', '\\frac{dX}{dt}=F(X,t)', '\\frac{dX}{dt}=F(X,t)', 'Kontinuierliches Zustandsraummodell.', 'model', 'literature', 38, NULL, NULL, 'checked', 6),
(41, '3.41', 14, 'Lineares Zustandsraummodell', '\\frac{dX}{dt}=AX', '\\frac{dX}{dt}=AX', 'Lineare Zustandsdynamik.', 'model', 'literature', 38, NULL, NULL, 'checked', 6),
(42, '3.42', 14, 'Lösung des linearen Systems', 'X(t)=e^{At}X(0)', 'X(t)=e^{At}X(0)', 'Formale Lösung eines autonomen linearen Systems.', 'derived', 'literature', 38, NULL, NULL, 'checked', 6),
(43, '3.43', 14, 'Nichtlineares Zustandsraummodell', '\\frac{dX}{dt}=F(X)', '\\frac{dX}{dt}=F(X)', 'Autonome nichtlineare Zustandsdynamik.', 'model', 'literature', 39, NULL, NULL, 'checked', 6),
(44, '3.44', 15, 'Addition von Funktionen', '(f+g)(x)=f(x)+g(x)', '(f+g)(x)=f(x)+g(x)', 'Punktweise Addition von Funktionen.', 'definition', 'literature', 41, NULL, NULL, 'checked', 6),
(45, '3.45', 15, 'Skalarmultiplikation von Funktionen', '(\\alpha f)(x)=\\alpha\\,f(x)', '(\\alpha f)(x)=\\alpha\\,f(x)', 'Punktweise Skalarmultiplikation.', 'definition', 'literature', 41, NULL, NULL, 'checked', 6),
(46, '3.46', 15, 'Positivität der Norm', '\\|f\\|\\ge0,\\qquad\\|f\\|=0\\Longleftrightarrow f=0', '\\|f\\|\\ge0,\\qquad\\|f\\|=0\\Longleftrightarrow f=0', 'Positivität und Definitheit einer Norm.', 'definition', 'literature', 42, NULL, NULL, 'checked', 6),
(47, '3.47', 15, 'Dreiecksungleichung der Norm', '\\|f+g\\|\\le\\|f\\|+\\|g\\|', '\\|f+g\\|\\le\\|f\\|+\\|g\\|', 'Dreiecksungleichung einer Norm.', 'definition', 'literature', 42, NULL, NULL, 'checked', 6),
(48, '3.48', 15, 'Cauchy-Bedingung', '\\forall\\varepsilon>0\\;\\exists N:m,n>N\\Rightarrow\\|f_n-f_m\\|<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N:m,n>N\\Rightarrow\\|f_n-f_m\\|<\\varepsilon', 'Cauchy-Bedingung in einem normierten Raum.', 'definition', 'literature', 42, NULL, NULL, 'checked', 6),
(49, '3.49', 15, 'Skalarprodukt', '\\langle f,g\\rangle', '\\langle f,g\\rangle', 'Skalarprodukt zweier Elemente.', 'definition', 'literature', 41, NULL, NULL, 'checked', 6),
(50, '3.50', 15, 'Induzierte Norm', '\\|f\\|=\\sqrt{\\langle f,f\\rangle}', '\\|f\\|=\\sqrt{\\langle f,f\\rangle}', 'Durch ein Skalarprodukt induzierte Norm.', 'derived', 'literature', 41, NULL, NULL, 'checked', 6),
(51, '3.51', 16, 'Allgemeines dynamisches System', '\\frac{dX}{dt}=F(X,t)', '\\frac{dX}{dt}=F(X,t)', 'Allgemeine kontinuierliche Dynamik.', 'model', 'literature', 43, NULL, NULL, 'checked', 6),
(52, '3.52', 16, 'Diskrete Dynamik', 'X_{n+1}=F(X_n)', 'X_{n+1}=F(X_n)', 'Diskrete rekursive Systementwicklung.', 'model', 'literature', 43, NULL, NULL, 'checked', 6),
(53, '3.53', 16, 'Fixpunkt', 'F(X^\\ast)=X^\\ast', 'F(X^\\ast)=X^\\ast', 'Fixpunktbedingung.', 'definition', 'literature', 43, NULL, NULL, 'checked', 6),
(54, '3.54', 16, 'Asymptotische Stabilität', '\\lim_{t\\rightarrow\\infty}X(t)=X^\\ast', '\\lim_{t\\rightarrow\\infty}X(t)=X^\\ast', 'Konvergenz gegen einen stabilen Fixpunkt.', 'definition', 'literature', 43, NULL, NULL, 'checked', 6),
(55, '3.55', 16, 'Attraktorbedingung', '\\operatorname{dist}(X(t),A)\\longrightarrow0\\qquad(t\\rightarrow\\infty)', '\\operatorname{dist}(X(t),A)\\longrightarrow0\\qquad(t\\rightarrow\\infty)', 'Annäherung an einen Attraktor.', 'definition', 'literature', 44, NULL, NULL, 'checked', 6),
(56, '3.56', 16, 'Parametrisierte Dynamik', '\\frac{dX}{dt}=F(X,\\mu)', '\\frac{dX}{dt}=F(X,\\mu)', 'Dynamik mit Steuerparameter.', 'model', 'literature', 37, NULL, NULL, 'checked', 6),
(57, '3.57', 16, 'Lyapunov-Divergenz', '\\delta(t)\\approx\\delta_0e^{\\lambda t}', '\\delta(t)\\approx\\delta_0e^{\\lambda t}', 'Exponentielle Divergenz benachbarter Trajektorien.', 'model', 'literature', 44, NULL, NULL, 'checked', 6),
(58, '3.58', 17, 'Informationsgehalt', 'I(x)=-\\log_{2}p(x)', 'I(x)=-\\log_{2}p(x)', 'Informationsgehalt eines Ereignisses.', 'definition', 'literature', 46, NULL, NULL, 'checked', 6),
(59, '3.59', 17, 'Shannon-Entropie', 'H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i', 'H(X)=-\\sum_{i=1}^{n}p_i\\log_{2}p_i', 'Mittlere Unsicherheit einer Zufallsvariablen.', 'definition', 'literature', 46, NULL, NULL, 'checked', 6),
(60, '3.60', 17, 'Gemeinsame Entropie', 'H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)', 'H(X,Y)=-\\sum_{i,j}p(x_i,y_j)\\log_{2}p(x_i,y_j)', 'Gemeinsame Entropie zweier Zufallsvariablen.', 'definition', 'literature', 45, NULL, NULL, 'checked', 6),
(61, '3.61', 17, 'Gegenseitige Information', 'I(X;Y)=H(X)+H(Y)-H(X,Y)', 'I(X;Y)=H(X)+H(Y)-H(X,Y)', 'Statistische Abhängigkeit zweier Zufallsvariablen.', 'definition', 'literature', 45, NULL, NULL, 'checked', 6),
(62, '3.62', 17, 'Kullback-Leibler-Divergenz', 'D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}', 'D_{KL}(P\\parallel Q)=\\sum_iP(i)\\log_{2}\\frac{P(i)}{Q(i)}', 'Divergenz zweier Wahrscheinlichkeitsverteilungen.', 'definition', 'literature', 45, NULL, NULL, 'checked', 6),
(63, '3.63', 18, 'Graph', 'G=(V,E)', 'G=(V,E)', 'Definition eines Graphen.', 'definition', 'literature', 47, NULL, NULL, 'checked', 6),
(64, '3.64', 18, 'Gerichtete Kantenmenge', 'E\\subseteq V\\times V', 'E\\subseteq V\\times V', 'Kanten als gerichtete Relationen.', 'definition', 'literature', 47, NULL, NULL, 'checked', 6),
(65, '3.65', 18, 'Knotengrad', '\\deg(v)=|\\{u\\in V\\mid(u,v)\\in E\\}|', '\\deg(v)=|\\{u\\in V\\mid(u,v)\\in E\\}|', 'Grad eines Knotens.', 'definition', 'literature', 47, NULL, NULL, 'checked', 6),
(66, '3.66', 18, 'Adjazenzmatrix', 'A=(a_{ij})', 'A=(a_{ij})', 'Matrixdarstellung eines Graphen.', 'definition', 'literature', 47, NULL, NULL, 'checked', 6),
(67, '3.67', 18, 'Adjazenzmatrixelement', 'a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}', 'a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&\\text{sonst}.\\end{cases}', 'Eintrag der Adjazenzmatrix.', 'definition', 'literature', 47, NULL, NULL, 'checked', 6),
(68, '3.68', 18, 'Pfad', 'P=(v_1,v_2,\\ldots,v_n)', 'P=(v_1,v_2,\\ldots,v_n)', 'Folge verbundener Knoten.', 'definition', 'literature', 47, NULL, NULL, 'checked', 6),
(69, '3.69', 18, 'Gradzentralität', 'C_D(v)=\\frac{\\deg(v)}{|V|-1}', 'C_D(v)=\\frac{\\deg(v)}{|V|-1}', 'Normierte Gradzentralität.', 'metric', 'literature', 48, NULL, NULL, 'checked', 6),
(70, '3.70', 19, 'Metrik', 'd:X\\times X\\rightarrow\\mathbb{R}', 'd:X\\times X\\rightarrow\\mathbb{R}', 'Allgemeine Metrikfunktion.', 'definition', 'literature', 49, NULL, NULL, 'checked', 6),
(71, '3.71', 19, 'Nichtnegativität', 'd(x,y)\\ge0', 'd(x,y)\\ge0', 'Nichtnegativitätsaxiom einer Metrik.', 'definition', 'literature', 49, NULL, NULL, 'checked', 6),
(72, '3.72', 19, 'Identität', 'd(x,y)=0\\Longleftrightarrow x=y', 'd(x,y)=0\\Longleftrightarrow x=y', 'Identitätsaxiom einer Metrik.', 'definition', 'literature', 49, NULL, NULL, 'checked', 6),
(73, '3.73', 19, 'Symmetrie der Metrik', 'd(x,y)=d(y,x)', 'd(x,y)=d(y,x)', 'Symmetrieaxiom einer Metrik.', 'definition', 'literature', 49, NULL, NULL, 'checked', 6),
(74, '3.74', 19, 'Dreiecksungleichung der Metrik', 'd(x,z)\\le d(x,y)+d(y,z)', 'd(x,z)\\le d(x,y)+d(y,z)', 'Dreiecksungleichung einer Metrik.', 'definition', 'literature', 49, NULL, NULL, 'checked', 6),
(75, '3.75', 19, 'Euklidische Distanz', 'd_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}', 'd_E(x,y)=\\sqrt{\\sum_{i=1}^{n}(x_i-y_i)^2}', 'Euklidischer Abstand zweier Vektoren.', 'metric', 'literature', 49, NULL, NULL, 'checked', 6),
(76, '3.76', 19, 'Minkowski-Metrik', 'd_p(x,y)=\\left(\\sum_{i=1}^{n}|x_i-y_i|^p\\right)^{1/p}', 'd_p(x,y)=\\left(\\sum_{i=1}^{n}|x_i-y_i|^p\\right)^{1/p}', 'Allgemeine Minkowski-Metrik.', 'metric', 'literature', 49, NULL, NULL, 'checked', 6),
(77, '3.77', 19, 'Kosinusähnlichkeit', '\\operatorname{cos}(x,y)=\\frac{x\\cdot y}{\\|x\\|\\;\\|y\\|}', '\\operatorname{cos}(x,y)=\\frac{x\\cdot y}{\\|x\\|\\;\\|y\\|}', 'Winkelbasierte Ähnlichkeit zweier Vektoren.', 'metric', 'literature', 50, NULL, NULL, 'checked', 6),
(78, '3.78', 19, 'Pearson-Korrelation', 'r=\\frac{\\sum_{i=1}^{n}(x_i-\\bar{x})(y_i-\\bar{y})}{\\sqrt{\\sum_{i=1}^{n}(x_i-\\bar{x})^2}\\sqrt{\\sum_{i=1}^{n}(y_i-\\bar{y})^2}}', 'r=\\frac{\\sum_{i=1}^{n}(x_i-\\bar{x})(y_i-\\bar{y})}{\\sqrt{\\sum_{i=1}^{n}(x_i-\\bar{x})^2}\\sqrt{\\sum_{i=1}^{n}(y_i-\\bar{y})^2}}', 'Linearer Korrelationskoeffizient.', 'metric', 'literature', 50, NULL, NULL, 'checked', 6),
(79, '3.79', 20, 'Gekoppelte Systemdynamik', '\\frac{dX}{dt}=F(X)+C(X)', '\\frac{dX}{dt}=F(X)+C(X)', 'Dynamik eines Systems mit Kopplungsterm.', 'model', 'literature', 51, NULL, NULL, 'checked', 6),
(80, '3.80', 20, 'Rekursive Selbstorganisation', 'X_{n+1}=F(X_n,X_n^{\\,\\mathrm{Umgebung}})', 'X_{n+1}=F(X_n,X_n^{\\,\\mathrm{Umgebung}})', 'Zustandsentwicklung unter Einbeziehung der Umgebung.', 'model', 'literature', 51, NULL, NULL, 'checked', 6),
(81, '3.81', 20, 'Ordnungsparameter', '\\eta=\\Phi(X)', '\\eta=\\Phi(X)', 'Makroskopischer Ordnungsparameter als Funktion des Gesamtzustands.', 'definition', 'literature', 12, NULL, NULL, 'checked', 6),
(82, '3.82', 20, 'Attraktordynamik', 'X(t)\\longrightarrow A,\\qquad t\\rightarrow\\infty', 'X(t)\\longrightarrow A,\\qquad t\\rightarrow\\infty', 'Langfristige Entwicklung zu einem Attraktor.', 'model', 'literature', 12, NULL, NULL, 'checked', 6),
(83, '3.83', 21, 'Allgemeines mathematisches Modell', '\\mathcal{M}=(M,R,F,O,\\mathcal{X})', '\\mathcal{M}=(M,R,F,O,\\mathcal{X})', 'Schematische Zusammenfassung vorausgesetzter Modellbestandteile.', 'schema', 'original', NULL, NULL, NULL, 'checked', 6),
(84, '3.84', 21, 'Klassische Modellrichtung', '\\mathcal{M}\\Longrightarrow\\text{Analyse}(\\mathcal{M})', '\\mathcal{M}\\Longrightarrow\\text{Analyse}(\\mathcal{M})', 'Klassische Analyse eines bereits gegebenen Modells.', 'schema', 'original', NULL, NULL, NULL, 'checked', 6),
(85, '3.85', 21, 'Forschungslücke', '?\\Longrightarrow\\mathcal{M}', '?\\Longrightarrow\\mathcal{M}', 'Offene Frage nach der Genese des mathematischen Modells.', 'schema', 'original', NULL, NULL, NULL, 'checked', 6),
(86, '3.86', 21, 'Funktionale Entwicklungsrichtung', '\\mathcal{F}\\Longrightarrow\\mathcal{M}\\Longrightarrow\\mathcal{P}', '\\mathcal{F}\\Longrightarrow\\mathcal{M}\\Longrightarrow\\mathcal{P}', 'Funktionale Wechselwirkungen erzeugen mathematische Strukturen und physikalische Manifestationen.', 'schema', 'original', NULL, NULL, NULL, 'checked', 6),
(116, '3.87', 49, 'Konzeptionelle Entwicklungsrichtung', '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}', '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}', 'Konzeptionelle Reihenfolge der grundlegenden Organisationsprinzipien des FRZK.', 'schema', 'original', NULL, NULL, NULL, 'checked', 10),
(117, '3.88', 50, 'Primitive begriffliche Entwicklungsfolge', '\\text{funktional}\\Longrightarrow\\text{Unterschied}\\Longrightarrow\\text{Relation}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}', '\\text{funktional}\\Longrightarrow\\text{Unterschied}\\Longrightarrow\\text{Relation}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Stabilisierung}', 'Qualitative Beziehung der sechs primitiven Begriffe.', 'schema', 'original', NULL, NULL, NULL, 'checked', 10),
(118, '3.89', 52, 'Axiom A1 – Funktionale Unterscheidbarkeit', '\\exists\\,\\Delta_F', '\\exists\\,\\Delta_F', 'Logische Kennzeichnung der Möglichkeit funktionaler Unterscheidbarkeit.', 'axiom', 'original', NULL, NULL, NULL, 'checked', 10),
(119, '3.90', 53, 'Axiom A2 – Funktionale Relationierbarkeit', '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F', '\\Delta_F\\Longrightarrow\\Diamond\\,\\mathcal{R}_F', 'Funktionale Unterscheidbarkeit eröffnet die Möglichkeit funktionaler Relationierung.', 'axiom', 'original', NULL, NULL, NULL, 'checked', 10),
(120, '3.91', 54, 'Axiom A3 – Rekursive Transformation', '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F', '\\mathcal{R}_F\\Longrightarrow\\Diamond\\,\\mathcal{T}_F', 'Funktionale Relationierbarkeit eröffnet die Möglichkeit rekursiver Transformation.', 'axiom', 'original', NULL, NULL, NULL, 'checked', 10),
(121, '3.92', 55, 'Axiom A4 – Stabile funktionale Organisation', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', '\\mathcal{T}_F\\Longrightarrow\\Diamond\\,\\mathcal{O}_F', 'Rekursive Transformation eröffnet die Möglichkeit stabiler funktionaler Organisation.', 'axiom', 'original', NULL, NULL, NULL, 'checked', 10),
(122, '3.93', 56, 'Axiom A5 – Reproduzierbare Organisationsmuster', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', '\\mathcal{O}_F\\Longrightarrow\\Diamond\\,\\mathcal{P}_F', 'Stabile funktionale Organisation eröffnet die Möglichkeit reproduzierbarer Organisationsmuster.', 'axiom', 'original', NULL, NULL, NULL, 'checked', 10),
(123, '3.94', 57, 'Zusammenfassende axiomatische Entwicklungsfolge', '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Reproduzierbarkeit}', '\\text{Unterscheidbarkeit}\\Longrightarrow\\text{Relationierung}\\Longrightarrow\\text{Transformation}\\Longrightarrow\\text{Organisation}\\Longrightarrow\\text{Reproduzierbarkeit}', 'Zusammenfassung der konzeptionellen Reihenfolge der fünf gleichrangigen Axiome.', 'schema', 'original', NULL, NULL, NULL, 'checked', 10),
(124, '3.95', 58, 'Proposition 3.1 – Möglichkeit funktionaler Organisation', 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}', 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}', 'Gemeinsame Gültigkeit der fünf Axiome eröffnet einen theoretischen Rahmen funktionaler Organisation.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 10),
(125, '3.96', 58, 'Proposition 3.2 – Nichtredundanz der Axiome', '\\forall i\\neq j:A_i\\not\\equiv A_j', '\\forall i\\neq j:A_i\\not\\equiv A_j', 'Die fünf Axiome besitzen unterschiedliche theoretische Inhalte.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 10),
(126, '3.97', 58, 'Proposition 3.3 – Keine Vorwegnahme mathematischer Strukturen', '\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}', '\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}', 'Mengen, mathematische Relationen, Funktionen und Zustandsräume werden nicht als primitive Voraussetzungen eingeführt.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 10),
(127, '3.98', 58, 'Proposition 3.4 – Konstruktive Reihenfolge', 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5', 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5', 'Das Symbol prec kennzeichnet ausschließlich die Reihenfolge der mathematischen Konstruktion in Kapitel 3.4.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 10),
(128, '3.99', 58, 'Proposition 3.5 – Offenheit der mathematischen Modellierung', '\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n', '\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n', 'Die Axiome lassen grundsätzlich mehrere mathematische Realisierungen funktionaler Organisation zu.', 'theorem', 'original', NULL, NULL, NULL, 'checked', 10),
(178, '3.100', 61, 'Funktionale Differenzabbildung', '\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}', '\\Delta_F:\\Omega_F\\times\\Omega_F\\longrightarrow\\mathbb{R}_{\\ge0}', 'Definition einer nichtnegativen funktionalen Differenzabbildung.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
(179, '3.101', 61, 'Funktionale Identität', '\\Delta_F(\\omega_i,\\omega_j)=0', '\\Delta_F(\\omega_i,\\omega_j)=0', 'Funktionale Identität zweier Konfigurationen.', 'definition', 'original', NULL, NULL, NULL, 'checked', 11),
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
(231, '3.8', 10, 'Symmetrie einer Relation', '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa', '\\forall a,b\\in A:\\;aRb\\Longrightarrow bRa', 'Eine Relation R auf A ist symmetrisch, wenn aus aRb stets bRa folgt.', '', 'literature', 27, NULL, 'R ist eine Relation auf A.', 'checked', 22);

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
(18, 10, 'f', 'Funktion', 'Eindeutige Abbildung von A nach B.', NULL, 'f:A\\to B', 1),
(19, 10, 'A', 'Definitionsmenge', 'Menge der zulässigen Argumente.', NULL, 'Menge', 2),
(20, 10, 'B', 'Zielmenge', 'Menge der möglichen Funktionswerte.', NULL, 'Menge', 3),
(21, 11, '\\exists!', 'eindeutige Existenz', 'Es existiert genau ein zugeordnetes Element.', NULL, 'Logischer Quantor', 1),
(22, 12, 'x_1', 'erstes Urbild', 'Erstes Element der Definitionsmenge.', NULL, 'A', 1),
(23, 12, 'x_2', 'zweites Urbild', 'Zweites Element der Definitionsmenge.', NULL, 'A', 2),
(24, 13, 'y', 'Zielelement', 'Beliebiges Element der Zielmenge.', NULL, 'B', 1),
(25, 15, 'f^{-1}', 'Umkehrfunktion', 'Inverse Abbildung einer bijektiven Funktion.', NULL, 'B\\to A', 1),
(26, 17, 'g\\circ f', 'Funktionskomposition', 'Verkettung der Funktionen f und g.', NULL, 'A\\to C', 1),
(27, 18, 'h', 'dritte Funktion', 'Dritte kompositionsverträgliche Funktion.', NULL, 'C\\to D', 1),
(28, 19, '\\star', 'Verknüpfung auf A', 'Algebraische Verknüpfung der Ausgangsstruktur.', NULL, 'A\\times A\\to A', 1),
(29, 19, '\\circ', 'Verknüpfung auf B', 'Algebraische Verknüpfung der Zielstruktur.', NULL, 'B\\times B\\to B', 2),
(30, 20, '\\operatorname{id}_{A}', 'Identität auf A', 'Neutrale Abbildung auf A.', NULL, 'A\\to A', 1),
(31, 20, '\\operatorname{id}_{B}', 'Identität auf B', 'Neutrale Abbildung auf B.', NULL, 'B\\to B', 2),
(32, 22, '\\operatorname{Aut}(A)', 'Automorphismengruppe', 'Menge der Automorphismen von A.', NULL, 'Automorphismen von A', 1),
(33, 23, 'B^{A}', 'Funktionsmenge', 'Menge aller Funktionen von A nach B.', NULL, 'Menge von Abbildungen', 1),
(34, 24, '\\operatorname{id}_{A}', 'Identitätsabbildung', 'Abbildung, die jedes Element von A fest lässt.', NULL, 'A\\to A', 1),
(35, 25, '\\operatorname{id}_{A}', 'neutrales Kompositionselement', 'Identitätsabbildung als neutrales Element.', NULL, 'Endomorphismen von A', 1);

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
(19, 'Lemma 3.4.3', 62, 'Existenz trivialer Relationen', 'Jede funktionale Konfiguration besitzt die Identitätsrelation zu sich selbst.', '(\\omega,\\omega)\\in\\mathcal{R}_F', '(\\omega,\\omega)\\in\\mathcal{R}_F', 'original', NULL, NULL, 'checked', 11),
(20, 'Lemma 3.4.4', 62, 'Existenz nichttrivialer Relationen', 'Positive funktionale Differenz begründet eine aktive funktionale Relation.', '\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F', '\\Delta_F(\\omega_i,\\omega_j)>0\\Longrightarrow(\\omega_i,\\omega_j)\\in\\mathcal{R}_F', 'original', NULL, NULL, 'checked', 11),
(21, 'Lemma 3.4.5', 63, 'Abgeschlossenheit unter Transformation', 'Die Transformation einer funktionalen Relation ist wieder eine funktionale Relation.', '\\mathcal{T}_F(r)\\in\\mathcal{R}_F', '\\mathcal{T}_F(r)\\in\\mathcal{R}_F', 'original', NULL, NULL, 'checked', 11),
(22, 'Lemma 3.4.6', 63, 'Rekursive Abgeschlossenheit', 'Jede endliche Iteration des Transformationsoperators verbleibt in der Relationsstruktur.', '\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F', '\\mathcal{T}_F^{\\,n}(r)\\in\\mathcal{R}_F', 'original', NULL, NULL, 'checked', 11),
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
(16, 'Prop. 3.1', 58, 'Möglichkeit funktionaler Organisation', 'Unter der gemeinsamen Annahme der Axiome A1 bis A5 existiert ein theoretischer Rahmen, innerhalb dessen funktionale Organisation beschrieben werden kann.', 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}', 'A_1\\land A_2\\land A_3\\land A_4\\land A_5\\Longrightarrow\\exists\\,\\mathcal{F}', 'Erst die gemeinsame Gültigkeit aller fünf qualitativen Organisationsprinzipien eröffnet den vollständigen theoretischen Möglichkeitsrahmen.', 'A1,A2,A3,A4,A5', 'review', 10),
(17, 'Prop. 3.2', 58, 'Nichtredundanz der Axiome', 'Die fünf Axiome beschreiben unterschiedliche theoretische Eigenschaften funktionaler Organisation.', '\\forall i\\neq j:A_i\\not\\equiv A_j', '\\forall i\\neq j:A_i\\not\\equiv A_j', 'Die Proposition behauptet keine modelltheoretische Unabhängigkeit, sondern lediglich begriffliche Nichtgleichheit.', 'A1,A2,A3,A4,A5', 'review', 10),
(18, 'Prop. 3.3', 58, 'Keine Vorwegnahme mathematischer Strukturen', 'Die fünf Axiome setzen weder Mengen, mathematische Relationen, Funktionen noch Zustandsräume als primitive mathematische Objekte voraus.', '\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}', '\\neg\\exists(M,R,f,X)\\;\\text{als Voraussetzung}', 'Die Axiome formulieren ausschließlich qualitative Organisationsprinzipien.', 'A1,A2,A3,A4,A5', 'review', 10),
(19, 'Prop. 3.4', 58, 'Konstruktive Reihenfolge', 'Die Axiome bestimmen die Reihenfolge, in der die mathematische Konstruktion in Kapitel 3.4 vorgenommen wird.', 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5', 'A_1\\prec A_2\\prec A_3\\prec A_4\\prec A_5', 'Das Relationszeichen prec kennzeichnet keine axiomatische Ableitung, sondern ausschließlich eine methodische Konstruktionsfolge.', 'A1,A2,A3,A4,A5', 'review', 10),
(20, 'Prop. 3.5', 58, 'Offenheit der mathematischen Modellierung', 'Aus den Axiomen folgt zunächst keine eindeutig festgelegte mathematische Repräsentation.', '\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n', '\\exists\\mathcal{M}_i,\\qquad i=1,\\dots,n', 'Mehrere mathematische Modelle können grundsätzlich dieselben qualitativen Organisationsprinzipien realisieren.', 'A1,A2,A3,A4,A5', 'review', 10);

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
(11, 16, 1, NULL, 'uses', 'Prop. 3.1 verwendet A1.'),
(12, 17, 1, NULL, 'uses', 'Prop. 3.2 verwendet A1.'),
(13, 18, 1, NULL, 'uses', 'Prop. 3.3 verwendet A1.'),
(14, 19, 1, NULL, 'uses', 'Prop. 3.4 verwendet A1.'),
(15, 20, 1, NULL, 'uses', 'Prop. 3.5 verwendet A1.'),
(16, 16, 2, NULL, 'uses', 'Prop. 3.1 verwendet A2.'),
(17, 17, 2, NULL, 'uses', 'Prop. 3.2 verwendet A2.'),
(18, 18, 2, NULL, 'uses', 'Prop. 3.3 verwendet A2.'),
(19, 19, 2, NULL, 'uses', 'Prop. 3.4 verwendet A2.'),
(20, 20, 2, NULL, 'uses', 'Prop. 3.5 verwendet A2.'),
(21, 16, 3, NULL, 'uses', 'Prop. 3.1 verwendet A3.'),
(22, 17, 3, NULL, 'uses', 'Prop. 3.2 verwendet A3.'),
(23, 18, 3, NULL, 'uses', 'Prop. 3.3 verwendet A3.'),
(24, 19, 3, NULL, 'uses', 'Prop. 3.4 verwendet A3.'),
(25, 20, 3, NULL, 'uses', 'Prop. 3.5 verwendet A3.'),
(26, 16, 4, NULL, 'uses', 'Prop. 3.1 verwendet A4.'),
(27, 17, 4, NULL, 'uses', 'Prop. 3.2 verwendet A4.'),
(28, 18, 4, NULL, 'uses', 'Prop. 3.3 verwendet A4.'),
(29, 19, 4, NULL, 'uses', 'Prop. 3.4 verwendet A4.'),
(30, 20, 4, NULL, 'uses', 'Prop. 3.5 verwendet A4.'),
(31, 16, 5, NULL, 'uses', 'Prop. 3.1 verwendet A5.'),
(32, 17, 5, NULL, 'uses', 'Prop. 3.2 verwendet A5.'),
(33, 18, 5, NULL, 'uses', 'Prop. 3.3 verwendet A5.'),
(34, 19, 5, NULL, 'uses', 'Prop. 3.4 verwendet A5.'),
(35, 20, 5, NULL, 'uses', 'Prop. 3.5 verwendet A5.');

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
('last_edited_section', '3.2.3', '2026-07-14 05:28:55'),
('last_repository_revision', 'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V1', '2026-07-14 05:28:55'),
('next_citation_number', '62', '2026-07-14 05:28:55'),
('next_equation_number', '3.26', '2026-07-14 05:28:55');

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
(23, 'RKB-2026-07-14-K3.2.3-NEUFASSUNG-V1', '2026-07-14 07:28:50', 'section', '3.2.3', '1.0', 'Neufassung von Abschnitt 3.2.3: Funktionen als mathematische Beschreibung gerichteter Transformationen; Registrierung der Quellen [59] bis [61], Wiederverwendung von [29], [30] und [35] sowie Aktualisierung der Gleichungen (3.10) bis (3.25).', 'Olaf Thiele / ChatGPT', 22);

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
(76, 23, 11, 'rewritten', 'section', '3.2.3', 'Abschnitt 3.2.3 wurde vollständig neu gefasst.', 'Bisheriger Repository-Stand von Abschnitt 3.2.3.', 'Neufassung mit sechs Quellenverwendungen, sechs Definitionen und sechzehn Gleichungen.', '2026-07-14 05:28:55'),
(77, 23, 11, 'source_added', 'sources', '[59]–[61]', 'Drei neue Literaturquellen wurden registriert.', NULL, 'Dirichlet [59], Eilenberg/Mac Lane [60], van der Waerden [61].', '2026-07-14 05:28:55'),
(78, 23, 11, 'source_reused', 'sources', '[29], [30], [35]', 'Drei bestehende Quellen wurden wiederverwendet.', NULL, 'Lang [29], Rudin [30], Conway [35].', '2026-07-14 05:28:55'),
(79, 23, 11, 'definition_added', 'definitions', 'Def. 3.2.3.1–Def. 3.2.3.6', 'Sechs Definitionen wurden registriert.', NULL, 'Funktion, Bijektion, Homomorphismus, Isomorphismus, Endomorphismus und Automorphismus.', '2026-07-14 05:28:55'),
(80, 23, 11, 'equation_added', 'equations', '(3.10)–(3.25)', 'Sechzehn Gleichungen wurden registriert.', NULL, 'Definitionen und Eigenschaften des Funktionsbegriffs.', '2026-07-14 05:28:55'),
(81, 23, 11, 'symbol_added', 'symbols', 'f, f^{-1}, g\\circ f, id_A, B^A', 'Zentrale Symbole des Abschnitts wurden registriert.', NULL, 'Funktion, Umkehrfunktion, Komposition, Identität und Funktionsmenge.', '2026-07-14 05:28:55');

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
(63, 58, 'fraenkel_bar_hillel_levy_foundations_set_theory_1973', 'book', 'Foundations of Set Theory', NULL, 1958, 1973, NULL, 'North-Holland', 'Amsterdam', NULL, NULL, NULL, 'Second Revised Edition', NULL, NULL, NULL, 'en', 5, 'reference', 4, 'needs_review', '3.2.1', 'Erstnennung in der Neufassung von Abschnitt 3.2.1.', 'Fraenkel, Abraham A.; Bar-Hillel, Yehoshua; Levy, Azriel: Foundations of Set Theory. Second Revised Edition. Amsterdam: North-Holland, 1973.', 'Fraenkel, Bar-Hillel und Levy [58]', 'Referenzwerk zur axiomatischen Mengenlehre und zu den Grundlagen von ZFC.', 21, '2026-07-12 12:53:53', '2026-07-12 12:53:53'),
(64, 59, 'dirichlet_functions_1837', 'journal_article', 'Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen', NULL, 1837, 1837, 'Repertorium der Physik', NULL, NULL, '1', NULL, '152–174', NULL, NULL, NULL, NULL, 'de', 5, 'primary', 4, 'partially_verified', '3.2.3', 'Erstnennung in Abschnitt 3.2.3.', 'Dirichlet, Peter Gustav Lejeune: Über die Darstellung ganz willkürlicher Functionen durch Sinus- und Cosinusreihen. Repertorium der Physik, Bd. 1, 1837, S. 152–174; wiederabgedruckt in: Dirichlet’s Werke, Bd. 1, Berlin: Georg Reimer, 1889–1897.', 'Dirichlet [59]', 'Primärquelle zur Ablösung des Funktionsbegriffs von einer ausschließlich analytischen Formel.', 23, '2026-07-14 05:28:51', '2026-07-14 05:28:51'),
(65, 60, 'eilenberg_maclane_natural_equivalences_1945', 'journal_article', 'General Theory of Natural Equivalences', NULL, 1945, 1945, 'Transactions of the American Mathematical Society', NULL, NULL, '58', '2', '231–294', NULL, '10.1090/S0002-9947-1945-0013131-6', NULL, NULL, 'en', 5, 'primary', 4, 'verified', '3.2.3', 'Erstnennung in Abschnitt 3.2.3.', 'Eilenberg, Samuel; Mac Lane, Saunders: General Theory of Natural Equivalences. Transactions of the American Mathematical Society, 58(2), 1945, S. 231–294. DOI: 10.1090/S0002-9947-1945-0013131-6.', 'Eilenberg/Mac Lane [60]', 'Primärquelle für Kategorien, Funktoren, natürliche Transformationen und die strukturelle Bedeutung der Komposition.', 23, '2026-07-14 05:28:51', '2026-07-14 05:28:51'),
(66, 61, 'van_der_waerden_moderne_algebra_1930_1931', 'book', 'Moderne Algebra', NULL, 1930, 1931, NULL, 'Springer', 'Berlin', 'I–II', NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'de', 4, 'historical', 4, 'partially_verified', '3.2.3', 'Erstnennung in Abschnitt 3.2.3.', 'van der Waerden, Bartel Leendert: Moderne Algebra. 2 Bände. Berlin: Springer, 1930–1931.', 'van der Waerden [61]', 'Historische Referenz zur strukturellen Algebra, zu Homomorphismen und Isomorphismen.', 23, '2026-07-14 05:28:51', '2026-07-14 05:28:51');

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
(64, 45, 1, 'author'),
(65, 46, 1, 'author'),
(65, 47, 2, 'author'),
(66, 48, 1, 'author');

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
(43, 31, 12, 'first_citation', 'Verwendung von Quelle [31] im Abschnitt 3.2.4.', 'Abschnitt 3.2.4', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(44, 32, 12, 'first_citation', 'Verwendung von Quelle [32] im Abschnitt 3.2.4.', 'Abschnitt 3.2.4', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(45, 33, 12, 'first_citation', 'Verwendung von Quelle [33] im Abschnitt 3.2.4.', 'Abschnitt 3.2.4', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(46, 34, 12, 'first_citation', 'Verwendung von Quelle [34] im Abschnitt 3.2.4.', 'Abschnitt 3.2.4', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(47, 35, 13, 'first_citation', 'Verwendung von Quelle [35] im Abschnitt 3.2.5.', 'Abschnitt 3.2.5', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(48, 36, 13, 'first_citation', 'Verwendung von Quelle [36] im Abschnitt 3.2.5.', 'Abschnitt 3.2.5', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(49, 37, 13, 'first_citation', 'Verwendung von Quelle [37] im Abschnitt 3.2.5.', 'Abschnitt 3.2.5', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(50, 38, 14, 'first_citation', 'Verwendung von Quelle [38] im Abschnitt 3.2.6.', 'Abschnitt 3.2.6', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(51, 39, 14, 'first_citation', 'Verwendung von Quelle [39] im Abschnitt 3.2.6.', 'Abschnitt 3.2.6', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(52, 40, 14, 'first_citation', 'Verwendung von Quelle [40] im Abschnitt 3.2.6.', 'Abschnitt 3.2.6', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(53, 41, 15, 'first_citation', 'Verwendung von Quelle [41] im Abschnitt 3.2.7.', 'Abschnitt 3.2.7', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(54, 42, 15, 'first_citation', 'Verwendung von Quelle [42] im Abschnitt 3.2.7.', 'Abschnitt 3.2.7', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(55, 35, 15, 'background', 'Verwendung von Quelle [35] im Abschnitt 3.2.7.', 'Abschnitt 3.2.7', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(56, 36, 15, 'background', 'Verwendung von Quelle [36] im Abschnitt 3.2.7.', 'Abschnitt 3.2.7', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(57, 43, 16, 'first_citation', 'Verwendung von Quelle [43] im Abschnitt 3.2.8.', 'Abschnitt 3.2.8', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(58, 44, 16, 'first_citation', 'Verwendung von Quelle [44] im Abschnitt 3.2.8.', 'Abschnitt 3.2.8', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(59, 37, 16, 'background', 'Verwendung von Quelle [37] im Abschnitt 3.2.8.', 'Abschnitt 3.2.8', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(60, 45, 17, 'first_citation', 'Verwendung von Quelle [45] im Abschnitt 3.2.9.', 'Abschnitt 3.2.9', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(61, 46, 17, 'first_citation', 'Verwendung von Quelle [46] im Abschnitt 3.2.9.', 'Abschnitt 3.2.9', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(62, 47, 18, 'first_citation', 'Verwendung von Quelle [47] im Abschnitt 3.2.10.', 'Abschnitt 3.2.10', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(63, 48, 18, 'first_citation', 'Verwendung von Quelle [48] im Abschnitt 3.2.10.', 'Abschnitt 3.2.10', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(64, 15, 18, 'background', 'Verwendung von Quelle [15] im Abschnitt 3.2.10.', 'Abschnitt 3.2.10', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(65, 49, 19, 'first_citation', 'Verwendung von Quelle [49] im Abschnitt 3.2.11.', 'Abschnitt 3.2.11', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(66, 50, 19, 'first_citation', 'Verwendung von Quelle [50] im Abschnitt 3.2.11.', 'Abschnitt 3.2.11', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(67, 51, 20, 'first_citation', 'Verwendung von Quelle [51] im Abschnitt 3.2.12.', 'Abschnitt 3.2.12', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(68, 52, 20, 'first_citation', 'Verwendung von Quelle [52] im Abschnitt 3.2.12.', 'Abschnitt 3.2.12', 1, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(69, 12, 20, 'background', 'Verwendung von Quelle [12] im Abschnitt 3.2.12.', 'Abschnitt 3.2.12', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
(70, 14, 20, 'background', 'Verwendung von Quelle [14] im Abschnitt 3.2.12.', 'Abschnitt 3.2.12', 0, 0, 'Automatisch durch Kapitelabschluss-Revision registriert.', 6),
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
(132, 7, 50, 'background', 'Einordnung primitiver Begriffe innerhalb klassischer axiomatischer Methodik.', '3.3.1', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(133, 8, 50, 'background', 'Einordnung primitiver Begriffe innerhalb klassischer axiomatischer Methodik.', '3.3.1', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(134, 24, 50, 'background', 'Einordnung primitiver Begriffe innerhalb klassischer axiomatischer Methodik.', '3.3.1', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(135, 8, 51, 'background', 'Wissenschaftstheoretische Begründung minimaler primitiver Begriffe.', '3.3.2', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(136, 18, 51, 'background', 'Wissenschaftstheoretische Begründung minimaler primitiver Begriffe.', '3.3.2', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
(137, 24, 51, 'background', 'Wissenschaftstheoretische Begründung minimaler primitiver Begriffe.', '3.3.2', 0, 0, 'Wiederverwendung einer bereits nummerierten Masterquelle.', 10),
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
(209, 64, 11, 'first_citation', 'Historische Entwicklung des modernen Funktionsbegriffs und Ablösung von einer ausschließlich analytischen Darstellung.', 'Historische Entwicklung in 3.2.3', 1, 1, 'Neue Primärquelle [59].', 23),
(210, 29, 11, 'definition', 'Formale Definition einer Funktion sowie Grundbegriffe von Definitionsmenge, Zielmenge und Bild.', 'Definitionen und Abbildungseigenschaften in 3.2.3', 0, 1, 'Bereits vorhandene Quelle [29].', 23),
(211, 30, 11, 'definition', 'Injektivität, Surjektivität, Bijektivität, Umkehrabbildung und Komposition.', 'Formale Eigenschaften in 3.2.3', 0, 1, 'Bereits vorhandene Quelle [30].', 23),
(212, 65, 11, 'first_citation', 'Komposition, Identitätsabbildung und strukturelle Verallgemeinerung von Funktionen.', 'Komposition und strukturelle Einordnung in 3.2.3', 1, 1, 'Neue Primärquelle [60].', 23),
(213, 66, 11, 'first_citation', 'Homomorphismen, Isomorphismen, Endomorphismen und Automorphismen als strukturerhaltende Funktionen.', 'Strukturerhaltende Abbildungen in 3.2.3', 1, 1, 'Neue historische Referenz [61].', 23),
(214, 35, 11, 'state_of_research', 'Funktionen als Elemente von Funktionenräumen und Übergang zur Funktionalanalysis.', 'Universelle Bedeutung und Grenzen in 3.2.3', 0, 1, 'Wiederverwendung der bereits als [35] registrierten Conway-Quelle.', 23);

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
(6, 'f', 'f', 'Funktion', 'Eindeutige Abbildung zwischen Mengen.', 'global', 11, 17, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(7, 'T', 'T', 'Operator', 'Transformation zwischen mathematischen Räumen.', 'global', 13, 31, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 6),
(8, 'X', 'X', 'Zustandsvektor', 'Vollständiger Zustand eines Systems.', 'global', 14, 37, NULL, NULL, NULL, 1, 0, 0, NULL, 'checked', 6),
(9, '\\mathcal{X}', '\\mathcal{X}', 'Zustandsraum', 'Menge aller zulässigen Zustände.', 'global', 14, 38, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(10, 'F', 'F', 'Entwicklungsfunktion', 'Funktion oder Operator der Zustandsentwicklung.', 'chapter', 14, 39, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 6),
(11, 'G', 'G', 'Graph', 'Geordnetes Paar aus Knoten- und Kantenmenge.', 'global', 18, 63, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(12, 'V', 'V', 'Knotenmenge oder Vektorraum', 'Kontextabhängig Knotenmenge beziehungsweise Vektorraum.', 'chapter', 12, 29, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(13, 'E', 'E', 'Kantenmenge', 'Menge der Kanten eines Graphen.', 'global', 18, 63, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(14, 'd', 'd', 'Metrik', 'Abstandsfunktion auf einem metrischen Raum.', 'global', 19, 70, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(15, 'H', 'H', 'Entropie', 'Shannon-Entropie einer Zufallsvariablen.', 'chapter', 17, 59, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(16, 'I', 'I', 'Information', 'Informationsgehalt oder gegenseitige Information.', 'chapter', 17, 58, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(17, 'D_{KL}', 'D_{KL}', 'Kullback-Leibler-Divergenz', 'Divergenz zweier Wahrscheinlichkeitsverteilungen.', 'global', 17, 62, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(18, '\\eta', '\\eta', 'Ordnungsparameter', 'Makroskopischer Parameter der Systemordnung.', 'global', 20, 81, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(19, '\\mathcal{M}', '\\mathcal{M}', 'Mathematisches Modell', 'Zusammenfassung von Menge, Relationen, Funktionen, Operatoren und Zustandsraum.', 'global', 21, 83, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(20, '\\mathcal{F}', '\\mathcal{F}', 'Funktionale Wechselwirkungen', 'Gesamtheit funktionaler Wechselwirkungen.', 'global', 21, 86, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(21, '\\mathcal{P}', '\\mathcal{P}', 'Physikalische Manifestationen', 'Physikalische Manifestation mathematischer Strukturen.', 'global', 21, 86, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 6),
(36, '\\Delta_F', '\\Delta_F', 'funktionale Unterscheidbarkeit', 'Prämathematisches Symbol für die Möglichkeit funktionaler Unterscheidbarkeit.', 'chapter', 52, 118, NULL, NULL, NULL, 0, 0, 0, 'Noch keine mathematische Funktion; Formalisierung erst in Kapitel 3.4.', 'checked', 10),
(37, '\\mathcal{R}_F', '\\mathcal{R}_F', 'funktionale Relationierbarkeit', 'Prämathematisches Symbol für die Möglichkeit funktionaler Zusammenhangsbildung.', 'chapter', 53, 119, NULL, NULL, NULL, 0, 0, 0, 'Noch keine mengentheoretische Relation.', 'checked', 10),
(38, '\\mathcal{T}_F', '\\mathcal{T}_F', 'rekursive funktionale Transformation', 'Prämathematisches Symbol für die Möglichkeit rekursiver Transformation.', 'chapter', 54, 120, NULL, NULL, NULL, 0, 0, 0, 'Noch kein mathematischer Transformationsoperator.', 'checked', 10),
(39, '\\mathcal{O}_F', '\\mathcal{O}_F', 'stabile funktionale Organisation', 'Prämathematisches Symbol für die Möglichkeit stabiler funktionaler Organisation.', 'chapter', 55, 121, NULL, NULL, NULL, 0, 0, 0, 'In Kapitel 3.3 ausdrücklich kein Operator.', 'checked', 10),
(40, '\\mathcal{P}_F', '\\mathcal{P}_F', 'reproduzierbare Organisationsmuster', 'Prämathematisches Symbol für die Möglichkeit reproduzierbarer Organisationsmuster.', 'chapter', 56, 122, NULL, NULL, NULL, 0, 0, 0, 'Mathematische Äquivalenz und Kohärenz werden erst in Kapitel 3.4 definiert.', 'checked', 10),
(41, '\\mathcal{F}', '\\mathcal{F}', 'funktionale Organisation', 'Konzeptionelle Bezeichnung des durch alle fünf Axiome eröffneten theoretischen Rahmens.', 'chapter', 58, 124, NULL, NULL, NULL, 0, 0, 0, 'Noch keine festgelegte mathematische Struktur.', 'checked', 10),
(42, '\\Diamond', '\\Diamond', 'Möglichkeitsoperator', 'Modallogischer Operator zur Kennzeichnung prinzipieller Möglichkeit.', 'chapter', 53, 119, NULL, NULL, NULL, 0, 0, 1, 'Wird in den Axiomen A2 bis A5 verwendet.', 'checked', 10),
(43, '\\prec', '\\prec', 'methodische Konstruktionsfolge', 'Kennzeichnet ausschließlich die Reihenfolge der Konstruktion in Kapitel 3.4.', 'chapter', 58, 127, NULL, NULL, NULL, 0, 0, 0, 'Keine mathematische Ordnungsrelation.', 'checked', 10),
(60, '\\Omega_F', '\\Omega_F', 'Funktionale Konfigurationsmenge', 'Trägermenge aller funktionalen Konfigurationen.', 'chapter', 61, 178, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(61, '\\omega', '\\omega', 'Funktionale Konfiguration', 'Einzelne funktionale Konfiguration.', 'chapter', 61, 179, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(62, '\\Delta_F', '\\Delta_F', 'Funktionale Differenzabbildung', 'Nichtnegative Abbildung zur Beschreibung funktionaler Verschiedenheit.', 'chapter', 61, 178, NULL, NULL, NULL, 0, 0, 1, NULL, 'checked', 11),
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
(75, '\\mathfrak{T}_F', '\\mathfrak{T}_F', 'Funktionale Zeitstruktur', 'Paar aus Raumstruktur und Transformationsordnung.', 'chapter', 68, 220, NULL, NULL, NULL, 0, 0, 0, NULL, 'checked', 11),
(76, 'f', 'f', 'Funktion', 'Eindeutige Abbildung von einer Definitionsmenge in eine Zielmenge.', 'section', 11, 10, NULL, 'A', 'B', 0, 0, 0, 'Grundsymbol des Abschnitts 3.2.3.', 'checked', 23),
(77, 'f^{-1}', 'f^{-1}', 'Umkehrfunktion', 'Inverse Abbildung einer bijektiven Funktion.', 'section', 11, 15, NULL, 'B', 'A', 0, 0, 0, 'Nur für bijektive Funktionen vorhanden.', 'checked', 23),
(78, 'g\\circ f', 'g\\circ f', 'Funktionskomposition', 'Verkettung zweier kompositionsverträglicher Funktionen.', 'section', 11, 17, NULL, 'A', 'C', 0, 0, 0, 'Zuerst f, danach g.', 'checked', 23),
(79, '\\operatorname{id}_{A}', '\\operatorname{id}_{A}', 'Identitätsabbildung', 'Neutrale Abbildung auf A.', 'section', 11, 24, NULL, 'A', 'A', 0, 0, 0, 'Neutrales Element der Komposition.', 'checked', 23),
(80, 'B^{A}', 'B^{A}', 'Funktionsmenge', 'Menge aller Funktionen von A nach B.', 'section', 11, 23, NULL, 'Funktionen A\\to B', NULL, 0, 0, 0, 'Vorbereitung auf Funktionenräume.', 'checked', 23);

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
(11, 'Satz 3.4.3', 63, 'Existenz rekursiver Transformationsräume', 'Das Paar aus Relationsstruktur und Transformationsoperator bildet einen funktionalen Transformationsraum.', '(\\mathcal{R}_F,\\mathcal{T}_F)', '(\\mathcal{R}_F,\\mathcal{T}_F)', 'original', NULL, NULL, 'checked', 11),
(12, 'Satz 3.4.4', 64, 'Existenz funktionaler Organisationsräume', 'Existiert eine organisationserzeugende Transformation, so existiert ein funktionaler Organisationsraum.', '\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F', '\\exists\\,\\mathcal{T}_F\\Longrightarrow\\exists\\,\\mathfrak{O}_F', 'original', NULL, NULL, 'checked', 11),
(13, 'Satz 3.4.5', 65, 'Existenz funktionaler Zustandsräume', 'Jeder funktionale Organisationsraum besitzt mindestens einen zugehörigen funktionalen Zustandsraum.', '\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F', '\\mathfrak{O}_F\\Longrightarrow\\exists\\,\\mathfrak{X}_F', 'original', NULL, NULL, 'checked', 11),
(14, 'Satz 3.4.6', 66, 'Existenz funktionaler Kohärenz', 'Jeder funktionale Zustandsraum besitzt mindestens eine funktional kohärente Organisationsstruktur.', '\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F', '\\mathfrak{X}_F\\Longrightarrow\\exists\\,\\mathcal{K}_F', 'original', NULL, NULL, 'checked', 11),
(15, 'Satz 3.4.7', 67, 'Rekonstruktion des Raumbegriffs', 'Jeder funktionale Zustandsraum induziert eine funktionale Raumstruktur.', '\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F', '\\mathfrak{X}_F\\Longrightarrow\\mathfrak{R}_F', 'original', NULL, NULL, 'checked', 11),
(16, 'Satz 3.4.8', 68, 'Rekonstruktion der Zeitstruktur', 'Jede funktionale Raumstruktur induziert eine funktionale Zeitstruktur.', '\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F', '\\mathfrak{R}_F\\Longrightarrow\\mathfrak{T}_F', 'original', NULL, NULL, 'checked', 11);

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
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT für Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

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
