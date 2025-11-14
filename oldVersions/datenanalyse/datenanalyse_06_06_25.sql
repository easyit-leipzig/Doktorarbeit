-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 06. Jun 2025 um 18:44
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
-- Datenbank: `datenanalyse`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `beobachtung_protokoll`
--

CREATE TABLE `beobachtung_protokoll` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL,
  `beobachtungsdatum` date DEFAULT curdate(),
  `fach` varchar(50) DEFAULT NULL,
  `thema` text DEFAULT NULL,
  `lernverhalten_id` int(11) DEFAULT NULL,
  `sozialverhalten_id` int(11) DEFAULT NULL,
  `wissensstand_id` int(11) DEFAULT NULL,
  `kommentar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `didaktische_metric_zuordnung`
--

CREATE TABLE `didaktische_metric_zuordnung` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `metrik_id` int(11) NOT NULL,
  `themenauswahl` int(11) DEFAULT NULL,
  `materialien` int(11) DEFAULT NULL,
  `methodenvielfalt` int(11) DEFAULT NULL,
  `individualisierung` int(11) DEFAULT NULL,
  `aufforderung` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `didaktische_metric_zuordnung`
--

INSERT INTO `didaktische_metric_zuordnung` (`id`, `unterrichts_id`, `metrik_id`, `themenauswahl`, `materialien`, `methodenvielfalt`, `individualisierung`, `aufforderung`) VALUES
(1, 1001, 1, 4, 3, 4, 3, 4),
(2, 1002, 2, 3, 4, 3, 4, 3),
(3, 1003, 3, 4, 3, 4, 3, 4),
(4, 1004, 4, 3, 4, 3, 4, 3),
(5, 1005, 1, 4, 3, 4, 3, 4),
(6, 1006, 2, 3, 4, 3, 4, 3),
(7, 1007, 3, 4, 3, 4, 3, 4),
(8, 1008, 4, 3, 4, 3, 4, 3),
(9, 1009, 1, 4, 3, 4, 3, 4),
(10, 1010, 2, 3, 4, 3, 4, 3),
(11, 1011, 3, 4, 3, 4, 3, 4),
(12, 1012, 4, 3, 4, 3, 4, 3),
(13, 1013, 1, 4, 3, 4, 3, 4),
(14, 1014, 2, 3, 4, 3, 4, 3),
(15, 1015, 3, 4, 3, 4, 3, 4),
(16, 1016, 4, 3, 4, 3, 4, 3),
(17, 1017, 1, 4, 3, 4, 3, 4),
(18, 1018, 2, 3, 4, 3, 4, 3),
(19, 1019, 3, 4, 3, 4, 3, 4),
(20, 1020, 4, 3, 4, 3, 4, 3),
(21, 1021, 1, 4, 3, 4, 3, 4),
(22, 1022, 2, 3, 4, 3, 4, 3),
(23, 1023, 3, 4, 3, 4, 3, 4),
(24, 1024, 4, 3, 4, 3, 4, 3),
(25, 3001, 1, 4, 4, 4, 4, 4),
(26, 3002, 2, 4, 4, 3, 4, 4),
(27, 3003, 3, 4, 4, 4, 4, 4),
(28, 3004, 4, 4, 4, 4, 4, 4),
(29, 3005, 5, 4, 4, 4, 4, 4),
(30, 3006, 6, 3, 4, 3, 3, 4),
(31, 3007, 7, 4, 4, 4, 4, 4),
(32, 3008, 8, 4, 4, 4, 4, 4),
(33, 3009, 9, 4, 4, 4, 4, 4),
(34, 3010, 10, 4, 4, 4, 4, 4),
(35, 3011, 11, 4, 4, 4, 4, 4),
(36, 3012, 12, 3, 3, 4, 4, 4),
(37, 3013, 13, 4, 4, 4, 4, 4),
(38, 3014, 14, 5, 5, 4, 5, 5),
(39, 3015, 15, 4, 4, 4, 4, 4),
(40, 3016, 16, 4, 4, 4, 4, 4),
(41, 3017, 17, 4, 4, 4, 4, 4),
(42, 3018, 18, 4, 4, 4, 4, 4),
(43, 3019, 19, 4, 4, 4, 4, 4),
(44, 3020, 20, 4, 4, 4, 4, 4),
(45, 3021, 21, 4, 4, 4, 4, 4),
(46, 3022, 22, 4, 4, 4, 4, 4),
(47, 3023, 23, 4, 4, 4, 4, 4),
(48, 3024, 24, 4, 4, 4, 4, 4),
(49, 3025, 25, 4, 4, 4, 4, 4),
(50, 3026, 26, 4, 4, 4, 4, 4),
(51, 3027, 27, 4, 4, 4, 4, 4),
(52, 3028, 28, 4, 4, 4, 4, 4),
(53, 3029, 29, 4, 4, 4, 4, 4),
(54, 3030, 30, 4, 4, 4, 4, 4),
(55, 3031, 31, 4, 4, 4, 4, 4),
(56, 3032, 32, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gruppen`
--

CREATE TABLE `gruppen` (
  `GruppenID` int(11) NOT NULL,
  `Fach` varchar(50) DEFAULT NULL,
  `Raum` varchar(10) DEFAULT NULL,
  `Tag` varchar(10) DEFAULT NULL,
  `Zeit` varchar(20) DEFAULT NULL,
  `Lehrer` varchar(50) DEFAULT NULL,
  `gruppe_tag` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klassentyp`
--

CREATE TABLE `klassentyp` (
  `KlassentypID` int(11) NOT NULL,
  `Klassentyp` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `klassentyp`
--

INSERT INTO `klassentyp` (`KlassentypID`, `Klassentyp`) VALUES
(1, 'GR'),
(2, 'GYM'),
(3, 'RS'),
(4, 'HS'),
(5, 'GR'),
(6, 'GYM'),
(7, 'RS'),
(8, 'HS'),
(9, 'GR'),
(10, 'GYM'),
(11, 'RS'),
(12, 'HS'),
(13, 'GR'),
(14, 'GYM'),
(15, 'RS'),
(16, 'HS'),
(17, 'GR'),
(18, 'GYM'),
(19, 'RS'),
(20, 'HS');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lehrer_unterricht`
--

CREATE TABLE `lehrer_unterricht` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `lehrer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lehrkraft`
--

CREATE TABLE `lehrkraft` (
  `id` int(11) NOT NULL,
  `vorname` varchar(255) NOT NULL,
  `nachname` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `vertretung_flag` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lehrkraft`
--

INSERT INTO `lehrkraft` (`id`, `vorname`, `nachname`, `email`, `vertretung_flag`) VALUES
(1, 'Maria', 'Schmidt', 'maria.schmidt@schule.de', 0),
(2, 'Hans', 'Peter', 'hans.peter@schule.de', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `leistungsdaten_unterricht`
--

CREATE TABLE `leistungsdaten_unterricht` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL,
  `lernfortschritt` int(11) DEFAULT NULL,
  `beherrscht_thema` int(11) DEFAULT NULL,
  `transferdenken` int(11) DEFAULT NULL,
  `basiswissen` int(11) DEFAULT NULL,
  `vorbereitet` int(11) DEFAULT NULL,
  `note_typ` varchar(50) DEFAULT NULL COMMENT 'z.B. Test, Klausur, Anmeldung, Zeugnis',
  `note_beschreibung` varchar(255) DEFAULT NULL COMMENT 'z.B. Thema: Algebra, Wachstumsvorgänge',
  `note_signum` varchar(50) DEFAULT NULL COMMENT 'Kürzel des Bewertenden',
  `note_verlauf` varchar(15) DEFAULT NULL COMMENT 'z.B. trending_up, trending_down'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernfeld`
--

CREATE TABLE `lernfeld` (
  `id` int(11) NOT NULL,
  `klassenstufe` int(11) DEFAULT NULL,
  `lernfeld` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfeld`
--

INSERT INTO `lernfeld` (`id`, `klassenstufe`, `lernfeld`) VALUES
(1, 9, 'Kreis & Zylinder'),
(2, 9, 'Parabeln / Quadratfunktionen'),
(3, 9, 'Quadratische Gleichungen'),
(4, 9, 'Quadratwurzeln'),
(5, 9, 'Satz des Pythagoras'),
(6, 9, 'Wurzelfunktionen'),
(7, 9, 'Zinsen & Zinseszinsen'),
(8, 9, 'Ähnlichkeit & Strahlensatz'),
(9, 10, 'Daten'),
(10, 10, 'Exponentialfunktionen'),
(11, 10, 'Kombinatorik'),
(12, 10, 'Körper'),
(13, 10, 'Potenzen & Wurzeln'),
(14, 10, 'Trigonometrie im Dreieck'),
(15, 10, 'Trigonometrische Funktionen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernfeld_inhalt`
--

CREATE TABLE `lernfeld_inhalt` (
  `id` int(11) NOT NULL,
  `lernfeld_id` int(11) DEFAULT NULL,
  `inhalt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfeld_inhalt`
--

INSERT INTO `lernfeld_inhalt` (`id`, `lernfeld_id`, `inhalt`) VALUES
(1, 1, 'Alle Werte des Kreises berechnen'),
(2, 1, 'Kreisausschnitt/Kreisbogen & Kreisring'),
(3, 1, 'Sachaufgaben zu Zylinder'),
(4, 1, 'Textaufgaben zu Kreisen'),
(5, 1, 'Umfang & Flächeninhalt berechnen'),
(6, 1, 'Zylindermantel'),
(7, 1, 'Zylinderoberfläche'),
(8, 1, 'Zylindervolumen'),
(9, 2, 'Allgemeine Form in Scheitelpunktform umwandeln'),
(10, 2, 'Beliebig Verschieben: f(x) = (x - d)² + e'),
(11, 2, 'Horizontal Verschieben: f(x) = (x - d)²'),
(12, 2, 'Normalparabel: f(x) = x²'),
(13, 2, 'Sachaufgaben'),
(14, 2, 'Scheitelpunktform in Allgemeine Form umwandeln'),
(15, 2, 'Scheitelpunktform: f(x) = a(x - d)² + e'),
(16, 2, 'Strecken'),
(17, 2, 'Stauchen'),
(18, 2, 'Spiegeln: f(x) = ax²'),
(19, 2, 'Vertikal Verschieben: f(x) = x² + c'),
(20, 3, 'Biquadratische Gleichungen (Substitution, Resubstitution)'),
(21, 3, 'Diskriminante'),
(22, 3, 'Grafisches Lösen'),
(23, 3, 'Mitternachtsformel'),
(24, 3, 'Quadratische Ungleichungen'),
(25, 3, 'Rechnerisches Lösen I: Reinquadratisch'),
(26, 3, 'Rechnerisches Lösen II: (x + d)² - Form'),
(27, 3, 'Rechnerisches Lösen III: Quadratische Ergänzung'),
(28, 3, 'Rechnerisches Lösen IV: P-Q-Formel'),
(29, 3, 'Rechnerisches Lösen V: I-IV vermischt'),
(30, 3, 'Satz von Vieta'),
(31, 3, 'Textaufgaben'),
(32, 3, 'Zerlegung in Linearfaktoren'),
(33, 3, 'abc-Formel'),
(34, 4, 'Näherungsweise Wurzelziehen'),
(35, 4, 'Potenzdarstellung von Wurzeln'),
(36, 4, 'Quadrieren & Wurzelziehen'),
(37, 4, 'Reelle Zahlenbereiche'),
(38, 4, 'Wurzelgleichungen'),
(39, 5, 'Anwendung'),
(40, 5, 'Grundlagen'),
(41, 5, 'Höhen- & Kathetensatz'),
(42, 6, 'Grundlagen'),
(43, 7, 'Zinseszinsen'),
(44, 8, 'Maßstab / Längenverhältnisse'),
(45, 8, 'Strahlensatz I'),
(46, 8, 'Strahlensatz II'),
(47, 8, 'Strahlensatz I & II'),
(48, 8, 'Zentrische Streckung'),
(49, 8, 'Ähnlichkeit'),
(50, 8, 'Ähnlichkeit bei Dreiecken'),
(88, 9, 'Boxplots (Begriffe, Zeichnung, Ablesen)'),
(89, 10, 'Anwendung bei Zinseszinsrechnung'),
(90, 10, 'Beschränktes & Logistisches Wachstum'),
(91, 10, 'Grundlagen'),
(92, 10, 'Logarithmen'),
(93, 10, 'Logarithmen - Exponentialgleichungen'),
(94, 10, 'Logarithmengesetze'),
(95, 11, 'Binomialkoeffizient'),
(96, 11, 'Kombinatorik'),
(97, 12, 'Kegel'),
(98, 12, 'Kegelstumpf'),
(99, 12, 'Kugel'),
(100, 12, 'Pyramide'),
(101, 12, 'Pyramidenstumpf'),
(102, 12, 'Sachaufgaben'),
(103, 12, 'Textaufgaben'),
(104, 12, 'Zusammengesetzte Körper'),
(105, 13, '10er Potenzen'),
(106, 13, 'Grundlagen'),
(107, 13, 'Potenzen mit ganzzahligen / rationalen Exponenten'),
(108, 13, 'Potenzfunktionen'),
(109, 13, 'Potenzgesetze'),
(110, 13, 'Wurzelgesetze'),
(111, 13, 'Wurzeln'),
(112, 14, 'Anwendung im Körper'),
(113, 14, 'Anwendung im beliebigen Dreieck'),
(114, 14, 'Anwendung im gleichschenkligen Dreieck'),
(115, 14, 'Anwendung im rechtwinkl. Dreieck'),
(116, 14, 'Anwendung in Textaufgaben'),
(117, 14, 'Anwendung in beliebigen Figuren'),
(118, 14, 'Sinus'),
(119, 14, 'Kosinus'),
(120, 14, 'Tangens im Einheitskreis'),
(121, 15, 'Anwendung im Sachaufgaben'),
(122, 15, 'Einheitskreis'),
(123, 15, 'Funktionen verändern'),
(124, 15, 'Grundlagen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernfeld_inhalt_sachsen`
--

CREATE TABLE `lernfeld_inhalt_sachsen` (
  `id` int(11) NOT NULL,
  `lernfeld_id` int(11) DEFAULT NULL,
  `inhalt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfeld_inhalt_sachsen`
--

INSERT INTO `lernfeld_inhalt_sachsen` (`id`, `lernfeld_id`, `inhalt`) VALUES
(1, 1, 'Rationale Zahlen'),
(2, 1, 'Rechnen mit rationalen Zahlen'),
(3, 2, 'Rationale Zahlen'),
(4, 2, 'Rechnen mit rationalen Zahlen'),
(5, 3, 'Rationale Zahlen'),
(6, 3, 'Rechnen mit rationalen Zahlen'),
(7, 3, 'Irrationale Zahlen'),
(8, 4, 'Grundbegriffe der Geometrie'),
(9, 4, 'Flächenberechnung'),
(10, 5, 'Grundbegriffe der Geometrie'),
(11, 5, 'Flächenberechnung'),
(12, 6, 'Grundbegriffe der Geometrie'),
(13, 6, 'Flächenberechnung'),
(14, 6, 'Körperberechnung'),
(15, 7, 'Umfang und Flächeninhalt'),
(16, 7, 'Volumen'),
(17, 8, 'Umfang und Flächeninhalt'),
(18, 8, 'Volumen'),
(19, 9, 'Umfang und Flächeninhalt'),
(20, 9, 'Volumen'),
(21, 9, 'Masse und Gewicht'),
(22, 10, 'Proportionale und antiproportionale Zuordnungen'),
(23, 11, 'Proportionale und antiproportionale Zuordnungen'),
(24, 11, 'Lineare Funktionen'),
(25, 12, 'Terme und Gleichungen'),
(26, 12, 'Lineare Gleichungssysteme'),
(27, 13, 'Zufallsexperimente'),
(28, 13, 'Wahrscheinlichkeiten'),
(29, 14, 'Quadratische Funktionen darstellen'),
(30, 14, 'Quadratische Gleichungen lösen'),
(31, 15, 'Quadratische Funktionen darstellen'),
(32, 15, 'Quadratische Gleichungen lösen'),
(33, 16, 'Quadratische Funktionen darstellen'),
(34, 16, 'Quadratische Gleichungen lösen'),
(35, 16, 'Anwendungen quadratischer Funktionen'),
(36, 17, 'Volumen und Oberfläche von Pyramiden'),
(37, 17, 'Volumen und Oberfläche von Kegeln'),
(38, 18, 'Volumen und Oberfläche von Pyramiden'),
(39, 18, 'Volumen und Oberfläche von Kegeln'),
(40, 19, 'Volumen und Oberfläche von Pyramiden'),
(41, 19, 'Volumen und Oberfläche von Kegeln'),
(42, 19, 'Volumen und Oberfläche von Kugeln'),
(43, 20, 'Zufallsexperimente und Wahrscheinlichkeiten'),
(44, 20, 'Mehrstufige Zufallsexperimente'),
(45, 21, 'Sinus, Kosinus und Tangens im rechtwinkligen Dreieck'),
(46, 21, 'Sinussatz und Kosinussatz'),
(47, 22, 'Geraden und ihre Gleichungen'),
(48, 22, 'Kreise und ihre Gleichungen'),
(49, 23, 'Zahlen lesen und schreiben'),
(50, 23, 'Zahlen ordnen und vergleichen'),
(51, 24, 'Zahlen lesen und schreiben'),
(52, 24, 'Zahlen ordnen und vergleichen'),
(53, 25, 'Zahlen lesen und schreiben'),
(54, 25, 'Zahlen ordnen und vergleichen'),
(55, 25, 'Runden von Zahlen'),
(56, 26, 'Einfache geometrische Formen erkennen und benennen'),
(57, 26, 'Zeichnen von Linien und einfachen Formen'),
(58, 27, 'Einfache geometrische Formen erkennen und benennen'),
(59, 27, 'Zeichnen von Linien und einfachen Formen'),
(60, 28, 'Einfache geometrische Formen erkennen und benennen'),
(61, 28, 'Zeichnen von Linien und einfachen Formen'),
(62, 28, 'Symmetrie erkennen'),
(63, 29, 'Umgang mit Geld'),
(64, 29, 'Umgang mit Längen'),
(65, 30, 'Umgang mit Geld'),
(66, 30, 'Umgang mit Längen'),
(67, 31, 'Umgang mit Geld'),
(68, 31, 'Umgang mit Längen'),
(69, 31, 'Einfache Sachaufgaben lösen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernfeld_sachsen`
--

CREATE TABLE `lernfeld_sachsen` (
  `id` int(11) NOT NULL,
  `klassenstufe` int(11) DEFAULT NULL,
  `schulform` enum('RS','OS','GYM') DEFAULT NULL,
  `lernfeld` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfeld_sachsen`
--

INSERT INTO `lernfeld_sachsen` (`id`, `klassenstufe`, `schulform`, `lernfeld`) VALUES
(1, 9, 'RS', 'Zahlen und Rechnen'),
(2, 9, 'OS', 'Zahlen und Rechnen'),
(3, 9, 'GYM', 'Zahlen und Rechnen'),
(4, 9, 'RS', 'Geometrie'),
(5, 9, 'OS', 'Geometrie'),
(6, 9, 'GYM', 'Geometrie'),
(7, 9, 'RS', 'Größen und Messen'),
(8, 9, 'OS', 'Größen und Messen'),
(9, 9, 'GYM', 'Größen und Messen'),
(10, 9, 'OS', 'Funktionale Zusammenhänge'),
(11, 9, 'GYM', 'Funktionale Zusammenhänge'),
(12, 9, 'GYM', 'Algebra'),
(13, 9, 'GYM', 'Wahrscheinlichkeit'),
(14, 10, 'RS', 'Quadratische Funktionen und Gleichungen'),
(15, 10, 'OS', 'Quadratische Funktionen und Gleichungen'),
(16, 10, 'GYM', 'Quadratische Funktionen und Gleichungen'),
(17, 10, 'RS', 'Körperberechnung'),
(18, 10, 'OS', 'Körperberechnung'),
(19, 10, 'GYM', 'Körperberechnung'),
(20, 10, 'OS', 'Wahrscheinlichkeitsrechnung'),
(21, 10, 'GYM', 'Trigonometrie'),
(22, 10, 'GYM', 'Analytische Geometrie'),
(23, 4, 'RS', 'Zahlenraum bis 10000'),
(24, 4, 'OS', 'Zahlenraum bis 10000'),
(25, 4, 'GYM', 'Zahlenraum bis 10000'),
(26, 4, 'RS', 'Geometrische Formen'),
(27, 4, 'OS', 'Geometrische Formen'),
(28, 4, 'GYM', 'Geometrische Formen'),
(29, 4, 'RS', 'Größen und Sachrechnen'),
(30, 4, 'OS', 'Größen und Sachrechnen'),
(31, 4, 'GYM', 'Größen und Sachrechnen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernfortschritt_gruppen`
--

CREATE TABLE `lernfortschritt_gruppen` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfortschritt_gruppen`
--

INSERT INTO `lernfortschritt_gruppen` (`id`, `name`, `beschreibung`) VALUES
(1, 'Orientierung & Grundlagen', 'Diese Gruppe umfasst grundlegende Lernstufen, in denen es um das Kennenlernen des Themas, das Verstehen von Basiswissen und die ersten Schritte zur Anwendung geht.'),
(2, 'Basisverständnis & Anwendung', 'Diese Gruppe konzentriert sich auf das Erreichen eines soliden Basisverständnisses und die Fähigkeit, das Gelernte in einfachen Kontexten anzuwenden.'),
(3, 'Vertiefung & Kompetenz', 'Diese Gruppe beinhaltet Lernstufen, in denen das Wissen vertieft, komplexere Zusammenhänge verstanden und selbstständige Problemlösungsfähigkeiten entwickelt werden.'),
(4, 'Analyse & Transfer', 'Diese Gruppe umfasst Lernstufen, in denen es um die Fähigkeit geht, Wissen zu analysieren, kritisch zu hinterfragen und auf neue Situationen zu übertragen.'),
(5, 'Expertise & Innovation', 'Diese Gruppe beinhaltet die höchsten Lernstufen, in denen es um die Fähigkeit geht, Wissen kreativ anzuwenden, innovative Lösungen zu entwickeln und als Experte auf dem Gebiet zu agieren.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernfortschritt_gruppen_zuordnung`
--

CREATE TABLE `lernfortschritt_gruppen_zuordnung` (
  `lernfortschritt_gruppen_id` int(11) NOT NULL,
  `lernfortschritt_bezeichnungen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfortschritt_gruppen_zuordnung`
--

INSERT INTO `lernfortschritt_gruppen_zuordnung` (`lernfortschritt_gruppen_id`, `lernfortschritt_bezeichnungen_id`) VALUES
(1, 1),
(1, 11),
(2, 2),
(2, 7),
(2, 12),
(3, 3),
(3, 8),
(3, 13),
(4, 4),
(4, 9),
(5, 5),
(5, 6),
(5, 10),
(5, 14),
(5, 15);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lernstand_unterricht`
--

CREATE TABLE `lernstand_unterricht` (
  `unterrichts_id` int(11) DEFAULT NULL,
  `schueler_id` int(11) DEFAULT NULL,
  `lernfortschritt` int(11) DEFAULT NULL,
  `beherrscht_thema` int(11) DEFAULT NULL,
  `transferdenken` int(11) DEFAULT NULL,
  `basiswissen` int(11) DEFAULT NULL,
  `vorbereitet` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernstand_unterricht`
--

INSERT INTO `lernstand_unterricht` (`unterrichts_id`, `schueler_id`, `lernfortschritt`, `beherrscht_thema`, `transferdenken`, `basiswissen`, `vorbereitet`) VALUES
(1001, 1, 4, 0, 0, 1, 0),
(1002, 1, 4, 0, 0, 1, 1),
(1003, 1, 4, 1, 0, 1, 1),
(1004, 1, 4, 1, 0, 1, 1),
(1005, 1, 4, 1, 0, 1, 1),
(1006, 1, 4, 0, 0, 1, 1),
(1007, 1, 4, 1, 0, 1, 1),
(1008, 1, 4, 1, 0, 1, 1),
(1009, 1, 4, 0, 0, 1, 0),
(1010, 1, 4, 1, 0, 1, 1),
(1011, 1, 4, 1, 0, 1, 0),
(1012, 1, 4, 0, 0, 1, 0),
(1013, 1, 4, 1, 0, 1, 1),
(1014, 1, 4, 1, 0, 1, 1),
(1015, 1, 4, 0, 0, 0, 1),
(1016, 1, 4, 0, 0, 1, 1),
(1017, 1, 4, 1, 0, 1, 1),
(1018, 1, 4, 0, 1, 1, 1),
(1019, 1, 4, 1, 1, 1, 1),
(1020, 1, 4, 1, 0, 1, 1),
(1021, 1, 4, 1, 0, 1, 1),
(1022, 1, 4, 1, 0, 1, 1),
(1023, 1, 4, 1, 0, 1, 1),
(1024, 1, 4, 1, 1, 1, 1),
(3001, 20, 4, 4, 4, 5, 4),
(3002, 20, 4, 4, 3, 4, 4),
(3003, 20, 4, 5, 4, 5, 4),
(3004, 20, 4, 5, 3, 5, 4),
(3005, 20, 4, 4, 4, 4, 4),
(3006, 20, 4, 3, 3, 4, 4),
(3007, 20, 4, 4, 4, 4, 4),
(3008, 20, 4, 4, 4, 4, 4),
(3009, 20, 4, 4, 4, 4, 4),
(3010, 20, 4, 4, 5, 4, 4),
(3011, 20, 4, 4, 4, 4, 4),
(3012, 20, 3, 3, 4, 4, 4),
(3013, 20, 4, 4, 4, 4, 4),
(3014, 20, 5, 5, 4, 5, 5),
(3015, 20, 4, 4, 4, 4, 4),
(3016, 20, 4, 4, 4, 4, 4),
(3017, 20, 4, 4, 4, 4, 4),
(3018, 20, 4, 4, 4, 4, 4),
(3019, 20, 4, 4, 4, 4, 4),
(3020, 20, 4, 4, 4, 4, 4),
(3021, 20, 4, 4, 4, 4, 4),
(3022, 20, 4, 4, 4, 4, 4),
(3023, 20, 4, 4, 4, 4, 4),
(3024, 20, 4, 4, 4, 4, 4),
(3025, 20, 4, 4, 4, 4, 4),
(3026, 20, 4, 4, 4, 4, 4),
(3027, 20, 4, 4, 4, 4, 4),
(3028, 20, 4, 4, 4, 4, 4),
(3029, 20, 4, 4, 4, 4, 4),
(3030, 20, 4, 4, 4, 4, 4),
(3031, 20, 4, 4, 4, 4, 4),
(3032, 20, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_didaktik`
--

CREATE TABLE `mtr_didaktik` (
  `id` int(11) NOT NULL,
  `veranstaltungs_id` int(11) DEFAULT NULL,
  `datum` date NOT NULL,
  `themenauswahl` int(11) DEFAULT NULL,
  `materialien` int(11) DEFAULT NULL,
  `methodenvielfalt` int(11) DEFAULT NULL,
  `individualisierung` int(11) DEFAULT NULL,
  `aufforderung` int(11) DEFAULT NULL,
  `materialien_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_didaktik_gruppe`
--

CREATE TABLE `mtr_didaktik_gruppe` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `mtr_didaktik_gruppe`
--

INSERT INTO `mtr_didaktik_gruppe` (`id`, `name`, `beschreibung`) VALUES
(1, 'Struktur & Klarheit', 'Didaktische Merkmale zur Organisation und Verständlichkeit'),
(2, 'Differenzierung', 'Aspekte zur Anpassung an individuelle Lernstände'),
(3, 'Materialeinsatz', 'Qualität und Vielfalt der eingesetzten Unterrichtsmaterialien');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_didaktik_gruppe_zuordnung`
--

CREATE TABLE `mtr_didaktik_gruppe_zuordnung` (
  `id` int(11) NOT NULL,
  `gruppe_id` int(11) NOT NULL,
  `bezeichnung_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_emotion`
--

CREATE TABLE `mtr_emotion` (
  `id` int(11) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_feedback`
--

CREATE TABLE `mtr_feedback` (
  `id` int(11) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_kompetenz`
--

CREATE TABLE `mtr_kompetenz` (
  `id` int(11) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_leistung`
--

CREATE TABLE `mtr_leistung` (
  `id` int(11) NOT NULL,
  `veranstaltungs_id` int(11) DEFAULT NULL,
  `datum` date NOT NULL,
  `lernfortschritt` int(11) DEFAULT NULL,
  `beherrscht_thema` int(11) DEFAULT NULL,
  `transferdenken` int(11) DEFAULT NULL,
  `basiswissen` int(11) DEFAULT NULL,
  `vorbereitet` int(11) DEFAULT NULL,
  `verhaltensbeurteilung_code` varchar(255) DEFAULT NULL COMMENT 'Zusätzlicher Code zur Bewertung z.B. Chips-Auswahl',
  `reflexionshinweis` text DEFAULT NULL COMMENT 'Freitext für didaktische oder diagnostische Reflexion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_medien`
--

CREATE TABLE `mtr_medien` (
  `id` int(11) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_sozial`
--

CREATE TABLE `mtr_sozial` (
  `id` int(11) NOT NULL,
  `veranstaltungs_id` int(11) DEFAULT NULL,
  `datum` date NOT NULL,
  `mitarbeit` int(11) DEFAULT NULL,
  `absprachen` int(11) DEFAULT NULL,
  `selbststaendigkeit` int(11) DEFAULT NULL,
  `konzentration` int(11) DEFAULT NULL,
  `fleiss` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_sozial_gruppe`
--

CREATE TABLE `mtr_sozial_gruppe` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `mtr_sozial_gruppe`
--

INSERT INTO `mtr_sozial_gruppe` (`id`, `name`, `beschreibung`) VALUES
(1, 'Kooperationsverhalten', 'Verhalten in Gruppen- oder Partnerarbeit'),
(2, 'Selbststeuerung', 'Eigenverantwortliches Handeln, Zielverfolgung'),
(3, 'Arbeitsverhalten', 'Motivation, Fleiß, Regelbeachtung');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_sozial_gruppe_zuordnung`
--

CREATE TABLE `mtr_sozial_gruppe_zuordnung` (
  `id` int(11) NOT NULL,
  `gruppe_id` int(11) NOT NULL,
  `bezeichnung_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mtr_thema`
--

CREATE TABLE `mtr_thema` (
  `id` int(11) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rueckkopplung_metrik_lehrkraft`
--

CREATE TABLE `rueckkopplung_metrik_lehrkraft` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `lehrkraft_id` int(11) NOT NULL,
  `themenauswahl` int(11) DEFAULT NULL,
  `materialien` int(11) DEFAULT NULL,
  `methodenvielfalt` int(11) DEFAULT NULL,
  `individualisierung` int(11) DEFAULT NULL,
  `aufforderung` int(11) DEFAULT NULL,
  `mitarbeit` int(11) DEFAULT NULL,
  `absprachen` int(11) DEFAULT NULL,
  `selbststaendigkeit` int(11) DEFAULT NULL,
  `konzentration` int(11) DEFAULT NULL,
  `fleiss` int(11) DEFAULT NULL,
  `lernfortschritt` int(11) DEFAULT NULL,
  `beherrscht_thema` int(11) DEFAULT NULL,
  `transferdenken` int(11) DEFAULT NULL,
  `basiswissen` int(11) DEFAULT NULL,
  `vorbereitet` int(11) DEFAULT NULL,
  `erfasst_am` date DEFAULT curdate(),
  `themenauswahl_level_id` int(11) DEFAULT NULL,
  `materialien_level_id` int(11) DEFAULT NULL,
  `methodenvielfalt_level_id` int(11) DEFAULT NULL,
  `individualisierung_level_id` int(11) DEFAULT NULL,
  `aufforderung_level_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rueckkopplung_metrik_teilnehmer`
--

CREATE TABLE `rueckkopplung_metrik_teilnehmer` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL,
  `themenauswahl` int(11) DEFAULT NULL,
  `materialien` int(11) DEFAULT NULL,
  `methodenvielfalt` int(11) DEFAULT NULL,
  `individualisierung` int(11) DEFAULT NULL,
  `aufforderung` int(11) DEFAULT NULL,
  `mitarbeit` int(11) DEFAULT NULL,
  `absprachen` int(11) DEFAULT NULL,
  `selbststaendigkeit` int(11) DEFAULT NULL,
  `konzentration` int(11) DEFAULT NULL,
  `fleiss` int(11) DEFAULT NULL,
  `lernfortschritt` int(11) DEFAULT NULL,
  `beherrscht_thema` int(11) DEFAULT NULL,
  `transferdenken` int(11) DEFAULT NULL,
  `basiswissen` int(11) DEFAULT NULL,
  `vorbereitet` int(11) DEFAULT NULL,
  `erfasst_am` date DEFAULT curdate(),
  `themenauswahl_level_id` int(11) DEFAULT NULL,
  `materialien_level_id` int(11) DEFAULT NULL,
  `methodenvielfalt_level_id` int(11) DEFAULT NULL,
  `individualisierung_level_id` int(11) DEFAULT NULL,
  `aufforderung_level_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schueler_statusinfo`
--

CREATE TABLE `schueler_statusinfo` (
  `id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL,
  `statuscode_id` int(11) NOT NULL,
  `kommentar` text DEFAULT NULL,
  `gueltig_ab` date DEFAULT curdate(),
  `gueltig_bis` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schüler`
--

CREATE TABLE `schüler` (
  `SchülerID` int(11) NOT NULL,
  `Vorname` varchar(50) DEFAULT NULL,
  `Nachname` varchar(50) DEFAULT NULL,
  `Nachstunde` tinyint(1) DEFAULT NULL,
  `Klassenstufe` int(11) DEFAULT NULL,
  `KlassentypID` int(11) DEFAULT NULL,
  `Bis` date DEFAULT NULL,
  `GruppenID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `soziale_metric_zuordnung`
--

CREATE TABLE `soziale_metric_zuordnung` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `metrik_id` int(11) NOT NULL,
  `mitarbeit` int(11) DEFAULT NULL,
  `absprachen` int(11) DEFAULT NULL,
  `selbststaendigkeit` int(11) DEFAULT NULL,
  `konzentration` int(11) DEFAULT NULL,
  `fleiss` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `soziale_metric_zuordnung`
--

INSERT INTO `soziale_metric_zuordnung` (`id`, `unterrichts_id`, `metrik_id`, `mitarbeit`, `absprachen`, `selbststaendigkeit`, `konzentration`, `fleiss`) VALUES
(1, 1001, 5, 4, 4, 3, 4, 4),
(2, 1002, 6, 3, 3, 4, 3, 3),
(3, 1003, 7, 4, 4, 3, 4, 4),
(4, 1004, 8, 3, 3, 4, 3, 3),
(5, 1005, 5, 4, 4, 3, 4, 4),
(6, 1006, 6, 3, 3, 4, 3, 3),
(7, 1007, 7, 4, 4, 3, 4, 4),
(8, 1008, 8, 3, 3, 4, 3, 3),
(9, 1009, 5, 4, 4, 3, 4, 4),
(10, 1010, 6, 3, 3, 4, 3, 3),
(11, 1011, 7, 4, 4, 3, 4, 4),
(12, 1012, 8, 3, 3, 4, 3, 3),
(13, 1013, 5, 4, 4, 3, 4, 4),
(14, 1014, 6, 3, 3, 4, 3, 3),
(15, 1015, 7, 4, 4, 3, 4, 4),
(16, 1016, 8, 3, 3, 4, 3, 3),
(17, 1017, 5, 4, 4, 3, 4, 4),
(18, 1018, 6, 3, 3, 4, 3, 3),
(19, 1019, 7, 4, 4, 3, 4, 4),
(20, 1020, 8, 3, 3, 4, 3, 3),
(21, 1021, 5, 4, 4, 3, 4, 4),
(22, 1022, 6, 3, 3, 4, 3, 3),
(23, 1023, 7, 4, 4, 3, 4, 4),
(24, 1024, 8, 3, 3, 4, 3, 3),
(25, 1001, 5, 4, 4, 3, 4, 4),
(26, 1002, 6, 3, 3, 4, 3, 3),
(27, 1003, 7, 4, 4, 3, 4, 4),
(28, 1004, 8, 3, 3, 4, 3, 3),
(29, 1005, 5, 4, 4, 3, 4, 4),
(30, 1006, 6, 3, 3, 4, 3, 3),
(31, 1007, 7, 4, 4, 3, 4, 4),
(32, 1008, 8, 3, 3, 4, 3, 3),
(33, 1009, 5, 4, 4, 3, 4, 4),
(34, 1010, 6, 3, 3, 4, 3, 3),
(35, 1011, 7, 4, 4, 3, 4, 4),
(36, 1012, 8, 3, 3, 4, 3, 3),
(37, 1013, 5, 4, 4, 3, 4, 4),
(38, 1014, 6, 3, 3, 4, 3, 3),
(39, 1015, 7, 4, 4, 3, 4, 4),
(40, 1016, 8, 3, 3, 4, 3, 3),
(41, 1017, 5, 4, 4, 3, 4, 4),
(42, 1018, 6, 3, 3, 4, 3, 3),
(43, 1019, 7, 4, 4, 3, 4, 4),
(44, 1020, 8, 3, 3, 4, 3, 3),
(45, 1021, 5, 4, 4, 3, 4, 4),
(46, 1022, 6, 3, 3, 4, 3, 3),
(47, 1023, 7, 4, 4, 3, 4, 4),
(48, 1024, 8, 3, 3, 4, 3, 3),
(49, 1001, 5, 4, 4, 3, 4, 4),
(50, 1002, 6, 3, 3, 4, 3, 3),
(51, 1003, 7, 4, 4, 3, 4, 4),
(52, 1004, 8, 3, 3, 4, 3, 3),
(53, 1005, 5, 4, 4, 3, 4, 4),
(54, 1006, 6, 3, 3, 4, 3, 3),
(55, 1007, 7, 4, 4, 3, 4, 4),
(56, 1008, 8, 3, 3, 4, 3, 3),
(57, 1009, 5, 4, 4, 3, 4, 4),
(58, 1010, 6, 3, 3, 4, 3, 3),
(59, 1011, 7, 4, 4, 3, 4, 4),
(60, 1012, 8, 3, 3, 4, 3, 3),
(61, 1013, 5, 4, 4, 3, 4, 4),
(62, 1014, 6, 3, 3, 4, 3, 3),
(63, 1015, 7, 4, 4, 3, 4, 4),
(64, 1016, 8, 3, 3, 4, 3, 3),
(65, 1017, 5, 4, 4, 3, 4, 4),
(66, 1018, 6, 3, 3, 4, 3, 3),
(67, 1019, 7, 4, 4, 3, 4, 4),
(68, 1020, 8, 3, 3, 4, 3, 3),
(69, 1021, 5, 4, 4, 3, 4, 4),
(70, 1022, 6, 3, 3, 4, 3, 3),
(71, 1023, 7, 4, 4, 3, 4, 4),
(72, 1024, 8, 3, 3, 4, 3, 3),
(73, 3001, 1, 4, 4, 4, 4, 4),
(74, 3002, 2, 4, 4, 4, 4, 4),
(75, 3003, 3, 4, 4, 4, 4, 4),
(76, 3004, 4, 4, 4, 4, 4, 4),
(77, 3005, 5, 4, 4, 4, 4, 4),
(78, 3006, 6, 4, 4, 4, 4, 4),
(79, 3007, 7, 4, 4, 4, 4, 4),
(80, 3008, 8, 4, 4, 4, 4, 4),
(81, 3009, 9, 4, 4, 4, 4, 4),
(82, 3010, 10, 4, 4, 4, 4, 4),
(83, 3011, 11, 4, 4, 4, 4, 4),
(84, 3012, 12, 4, 4, 4, 4, 4),
(85, 3013, 13, 4, 4, 4, 4, 4),
(86, 3014, 14, 4, 4, 4, 4, 4),
(87, 3015, 15, 4, 4, 4, 4, 4),
(88, 3016, 16, 4, 4, 4, 4, 4),
(89, 3017, 17, 4, 4, 4, 4, 4),
(90, 3018, 18, 4, 4, 4, 4, 4),
(91, 3019, 19, 4, 4, 4, 4, 4),
(92, 3020, 20, 4, 4, 4, 4, 4),
(93, 3021, 21, 4, 4, 4, 4, 4),
(94, 3022, 22, 4, 4, 4, 4, 4),
(95, 3023, 23, 4, 4, 4, 4, 4),
(96, 3024, 24, 4, 4, 4, 4, 4),
(97, 3025, 25, 4, 4, 4, 4, 4),
(98, 3026, 26, 4, 4, 4, 4, 4),
(99, 3027, 27, 4, 4, 4, 4, 4),
(100, 3028, 28, 4, 4, 4, 4, 4),
(101, 3029, 29, 4, 4, 4, 4, 4),
(102, 3030, 30, 4, 4, 4, 4, 4),
(103, 3031, 31, 4, 4, 4, 4, 4),
(104, 3032, 32, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_bewertung_textbausteine`
--

CREATE TABLE `std_bewertung_textbausteine` (
  `id` int(11) NOT NULL,
  `kategorie` varchar(100) NOT NULL,
  `unterkategorie` varchar(100) NOT NULL,
  `wert` varchar(100) NOT NULL,
  `textbaustein_vorlage` text NOT NULL,
  `platzhalter_erlaubt` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `std_bewertung_textbausteine`
--

INSERT INTO `std_bewertung_textbausteine` (`id`, `kategorie`, `unterkategorie`, `wert`, `textbaustein_vorlage`, `platzhalter_erlaubt`) VALUES
(1, 'Wissensreproduktion', 'Detaillierung', 'sehr tiefes/gutes/oberflächliches/unzureichendes', 'Der/Die Teilnehmer/in demonstriert ein [sehr tiefes/gutes/oberflächliches/unzureichendes] Verständnis der funktionalen Zusammenhänge im Themenbereich [Thema]. Die Fähigkeit, komplexe Sachverhalte [klar und präzise/strukturiert/fragmentiert/fehlerhaft] wiederzugeben, ist [ausgeprägt/gut/durchschnittlich/eingeschränkt/nicht vorhanden].', 1),
(2, 'Wissensreproduktion', 'Modelle & Theorien', 'vollständig/überwiegend/teilweise/kaum', 'Der/Die Teilnehmer/in kann die [zentralen/wichtigen/weniger wichtigen] Modelle und Theorien [vollständig/überwiegend/teilweise/kaum] aufzählen und deren [wesentliche/grundlegende/oberflächliche] Annahmen [zutreffend/überwiegend zutreffend/teilweise zutreffend/nicht zutreffend] erläutern.', 1),
(3, 'Wissenstransfer', 'Anwendbarkeit', 'einfache/komplexe/unbekannte', 'Der/Die Teilnehmer/in ist in der Lage, das erworbene Wissen auf [einfache/komplexe/unbekannte] Problemstellungen [kreativ/effektiv/angemessen/begrenzt/nicht] anzuwenden und [innovative/praxisorientierte/theoretisch fundierte/wenig originelle/keine] Lösungen zu entwickeln.', 1),
(4, 'Wissenstransfer', 'Lösungsansätze', 'gut/eingeschränkt/nicht', 'Der/Die Teilnehmer/in kann [gut/eingeschränkt/nicht] zwischen verschiedenen Lösungsansätzen wählen und diese [begründen/teilweise begründen/nicht begründen].', 1),
(5, 'Problemlösungskompetenz', 'Analysefähigkeit', 'ausgezeichnete/gute/durchschnittliche/schwache/keine', 'Der/Die Teilnehmer/in demonstriert eine [ausgezeichnete/gute/durchschnittliche/schwache/keine] Fähigkeit zur Analyse von Problemen, zur Entwicklung von Lösungsstrategien und zur Umsetzung dieser Strategien in [erfolgreiche/teilweise erfolgreiche/nicht erfolgreiche] Ergebnisse.', 1),
(6, 'Problemlösungskompetenz', 'Vorgehensweise', 'strukturiert/systematisch/zielorientiert/chaotisch/nicht', 'Der/Die Teilnehmer/in geht bei der Problemlösung [strukturiert/systematisch/zielorientiert/chaotisch/nicht] vor und berücksichtigt [alle relevanten/die meisten relevanten/nur wenige relevante/keine relevanten] Aspekte.', 1),
(7, 'Analytische Fähigkeiten', 'Informationsanalyse', 'präzise und umfassend/strukturiert/oberflächlich/fehlerhaft/nicht', 'Der/Die Teilnehmer/in analysiert [präzise und umfassend/strukturiert/oberflächlich/fehlerhaft/nicht] die relevanten Informationen und zieht daraus [fundierte/plausible/fragwürdige/falsche/keine] Schlussfolgerungen.', 1),
(8, 'Analytische Fähigkeiten', 'Erkennen von Zusammenhängen', 'sicher/überwiegend/teilweise/nicht', 'Der/Die Teilnehmer/in erkennt [sicher/überwiegend/teilweise/nicht] die [wesentlichen/relevanten/weniger wichtigen] Zusammenhänge und Beziehungen zwischen den einzelnen Informationen.', 1),
(9, 'Kritisches Denken', 'Hinterfragen von Annahmen', 'konstruktiv und differenziert/teilweise/selten/nie', 'Der/Die Teilnehmer/in hinterfragt [konstruktiv und differenziert/teilweise/selten/nie] bestehende Annahmen und entwickelt [eigene/wenig originelle/keine] Perspektiven.', 1),
(10, 'Kritisches Denken', 'Unterscheidung Perspektiven', 'gut/eingeschränkt/nicht', 'Der/Die Teilnehmer/in kann [gut/eingeschränkt/nicht] zwischen verschiedenen Perspektiven unterscheiden und diese [nachvollziehbar/teilweise nachvollziehbar/nicht nachvollziehbar] begründen.', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_gruppen`
--

CREATE TABLE `std_gruppen` (
  `GruppenID` int(11) NOT NULL,
  `Fach` varchar(50) DEFAULT NULL,
  `Raum` varchar(10) DEFAULT NULL,
  `Tag` varchar(10) DEFAULT NULL,
  `Zeit` varchar(20) DEFAULT NULL,
  `Lehrer` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `std_gruppen`
--

INSERT INTO `std_gruppen` (`GruppenID`, `Fach`, `Raum`, `Tag`, `Zeit`, `Lehrer`) VALUES
(1, 'MAT', 'Rm. 3', 'Mo', '14:00 - 15:30', 'Thiele, D.'),
(2, 'MAT', 'Rm. 3', 'Mo', '15:35 - 17:05', 'Thiele, D.'),
(3, 'MAT', 'Rm. 3', 'Mo', '17:10 - 18:40', 'Thiele, D.'),
(4, 'MAT', 'Rm. 3', 'Di', '14:00 - 15:30', 'Thiele, D.'),
(5, 'MAT', 'Rm. 3', 'Di', '15:35 - 17:05', 'Thiele, D.'),
(6, 'MAT', 'Rm. 3', 'Di', '17:10 - 18:40', 'Thiele, D.'),
(7, 'MAT', 'Rm. 3', 'Mi', '15:35 - 17:05', 'Thiele, D.'),
(8, 'MAT', 'Rm. 3', 'Mi', '17:10 - 18:40', 'Thiele, D.'),
(9, 'MAT', 'Rm. 3', 'Do', '15:35 - 17:05', 'Thiele, D.'),
(10, 'PHY', 'Rm. 3', 'Do', '17:10 - 18:40', 'Thiele, D.'),
(11, 'MAT', 'Rm. 3', 'Fr', '15:35 - 17:05', 'Thiele, D.'),
(12, 'MAT', 'Rm. 3', 'Mo', '14:00 - 15:30', 'Thiele, D.'),
(13, 'MAT', 'Rm. 3', 'Di', '14:00 - 15:30', 'Thiele, D.'),
(14, 'MAT', 'Rm. 3', 'Mi', '15:35 - 17:05', 'Thiele, D.'),
(15, 'MAT', 'Rm. 3', 'Do', '15:35 - 17:05', 'Thiele, D.'),
(16, 'MAT', 'Rm. 3', 'Fr', '14:00 - 15:30', 'Thiele, D.'),
(17, 'MAT', 'Rm. 3', 'Mo', '14:00 - 15:30', 'Thiele, D.'),
(18, 'MAT', 'Rm. 3', 'Di', '14:00 - 15:30', 'Thiele, D.'),
(19, 'MAT', 'Rm. 3', 'Mi', '15:35 - 17:05', 'Thiele, D.'),
(20, 'MAT', 'Rm. 3', 'Do', '15:35 - 17:05', 'Thiele, D.'),
(21, 'MAT', 'Rm. 3', 'Fr', '14:00 - 15:30', 'Thiele, D.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_klassentyp`
--

CREATE TABLE `std_klassentyp` (
  `KlassentypID` int(11) NOT NULL,
  `Klassentyp` varchar(10) DEFAULT NULL,
  `Beschreibung` varchar(255) DEFAULT NULL COMMENT 'Erweiterte Bezeichnung, z.B. Gymnasium G8, Oberschule mit Teilschwerpunkt etc.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `std_klassentyp`
--

INSERT INTO `std_klassentyp` (`KlassentypID`, `Klassentyp`, `Beschreibung`) VALUES
(1, 'GR', NULL),
(2, 'GYM', NULL),
(3, 'RS', NULL),
(4, 'HS', NULL),
(5, 'OS', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_lehrinhalte_ue`
--

CREATE TABLE `std_lehrinhalte_ue` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `source_table` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `std_lehrinhalte_ue`
--

INSERT INTO `std_lehrinhalte_ue` (`id`, `type`, `source_table`) VALUES
(1, 'Lehplan', 'lernfeld_sachsen'),
(2, 'Schülerhilfe', 'lernfeld');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_lehrkraft`
--

CREATE TABLE `std_lehrkraft` (
  `id` int(11) NOT NULL,
  `vorname` varchar(255) NOT NULL,
  `nachname` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `vertretung_flag` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `std_lehrkraft`
--

INSERT INTO `std_lehrkraft` (`id`, `vorname`, `nachname`, `email`, `vertretung_flag`) VALUES
(1, 'Maria', 'Schmidt', 'maria.schmidt@schule.de', 0),
(2, 'Hans', 'Peter', 'hans.peter@schule.de', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_schueler`
--

CREATE TABLE `std_schueler` (
  `id` int(11) NOT NULL,
  `Vorname` varchar(255) DEFAULT NULL,
  `Nachname` varchar(255) DEFAULT NULL,
  `geschlecht` char(1) NOT NULL,
  `geburtstag` date NOT NULL,
  `Nachstunde` tinyint(1) DEFAULT NULL,
  `Klassenstufe` int(11) DEFAULT NULL,
  `KlassentypID` int(11) DEFAULT NULL,
  `Bis` date DEFAULT NULL,
  `GruppenID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `std_schueler_list_unterricht`
--

CREATE TABLE `std_schueler_list_unterricht` (
  `SchülerID` int(11) NOT NULL,
  `Vorname` varchar(50) DEFAULT NULL,
  `Nachname` varchar(50) DEFAULT NULL,
  `Nachstunde` tinyint(1) DEFAULT NULL,
  `Klassenstufe` int(11) DEFAULT NULL,
  `KlassentypID` int(11) DEFAULT NULL,
  `Bis` date DEFAULT NULL,
  `GruppenID` int(11) DEFAULT NULL,
  `statusinfo` text DEFAULT NULL,
  `notizflag` tinyint(1) DEFAULT 0,
  `Statuscode` varchar(255) DEFAULT NULL COMMENT 'z.B. Probeschüler, versetzungsgefährdet',
  `Notenerfassung` tinyint(1) DEFAULT 1 COMMENT '0 = keine Noten, 1 = Notenerfassung erlaubt',
  `Teilnahmenachweis_Unterschrift` tinyint(1) DEFAULT 0 COMMENT '1 = Unterschrift erforderlich'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `std_schueler_list_unterricht`
--

INSERT INTO `std_schueler_list_unterricht` (`SchülerID`, `Vorname`, `Nachname`, `Nachstunde`, `Klassenstufe`, `KlassentypID`, `Bis`, `GruppenID`, `statusinfo`, `notizflag`, `Statuscode`, `Notenerfassung`, `Teilnahmenachweis_Unterschrift`) VALUES
(1, 'Meta', 'Huth', 1, 4, 1, '2025-12-31', 1, NULL, 0, NULL, 1, 0),
(2, 'Sistine', 'Lauschke', 1, 3, 1, '2025-05-31', 1, NULL, 0, NULL, 1, 0),
(3, 'Tamino', 'Ahrens', 1, 8, 2, '2025-12-31', 2, NULL, 0, NULL, 1, 0),
(4, 'Anna-Sophie', 'Canitz', 1, 9, 2, '2025-12-31', 2, NULL, 0, NULL, 1, 0),
(5, 'Fabian', 'Fischer', 1, 6, 2, '2025-05-25', 2, NULL, 0, NULL, 1, 0),
(6, 'Lukas', 'Hillpert', 1, 8, 3, '2025-12-31', 2, NULL, 0, NULL, 1, 0),
(7, 'Emily', 'Pyka', 1, 9, 2, '2025-12-31', 2, NULL, 0, NULL, 1, 0),
(8, 'Gustav', 'Fleischer', 1, 10, 2, '2025-12-31', 3, NULL, 0, NULL, 1, 0),
(9, 'Carlotta Erika', 'Körber', 1, 8, 2, '2025-10-31', 3, NULL, 0, NULL, 1, 0),
(10, 'Luise', 'Schaff', 1, 9, 2, '2025-12-31', 3, NULL, 0, NULL, 1, 0),
(11, 'Leon', 'Schulze', 1, 7, 4, '2025-12-31', 3, NULL, 0, NULL, 1, 0),
(12, 'Wicher', 'Lotte Marie', 1, 9, 2, '2025-12-31', 3, NULL, 0, NULL, 1, 0),
(13, 'Lajoie', 'Efuto Isokola', 1, 4, 1, '2025-05-26', 4, NULL, 0, NULL, 1, 0),
(14, 'Mira', 'Moritz', 1, 4, 1, '2025-12-31', 4, NULL, 0, NULL, 1, 0),
(15, 'Sarah', 'Kahle', 1, 5, 2, '2025-12-31', 5, NULL, 0, NULL, 1, 0),
(16, 'Karl', 'König', 1, 6, 2, '2025-05-13', 5, NULL, 0, NULL, 1, 0),
(17, 'Laila', 'Stockmann', 1, 3, 1, '2025-12-31', 5, NULL, 0, NULL, 1, 0),
(18, 'Gustav', 'Fleischer', 1, 10, 2, '2025-12-31', 6, NULL, 0, NULL, 1, 0),
(19, 'Selina', 'Möwes', 1, 8, 3, '2025-12-31', 6, NULL, 0, NULL, 1, 0),
(20, 'Helena', 'Mußdorf', 1, 10, 2, '2025-12-31', 6, NULL, 0, NULL, 1, 0),
(21, 'Lia', 'Schubert', 1, 7, 2, '2025-12-31', 6, NULL, 0, NULL, 1, 0),
(22, 'Noah', 'Freiberg', 1, 11, 2, '2025-12-31', 7, NULL, 0, NULL, 1, 0),
(23, 'Lukas', 'Hillpert', 1, 8, 3, '2025-12-31', 7, NULL, 0, NULL, 1, 0),
(24, 'Karl', 'König', 1, 6, 2, '2025-12-31', 7, NULL, 0, NULL, 1, 0),
(25, 'Felix', 'Scheithauer', 1, 7, 2, '2025-05-14', 7, NULL, 0, NULL, 1, 0),
(26, 'Zoey', 'Schönherr', 1, 6, 2, '2025-12-31', 7, NULL, 0, NULL, 1, 0),
(27, 'Fabian', 'Fischer', 1, 6, 2, '2025-05-27', 8, NULL, 0, NULL, 1, 0),
(28, 'Helena', 'Mußdorf', 1, 10, 2, '2025-12-31', 8, NULL, 0, NULL, 1, 0),
(29, 'Felix', 'Schölzel', 1, 7, 2, '2025-12-31', 8, NULL, 0, NULL, 1, 0),
(30, 'Juni Florentine', 'Schölzel', 1, 6, 2, '2025-12-31', 8, NULL, 0, NULL, 1, 0),
(31, 'Jalia', 'Wagner', 1, 9, 2, '2025-12-31', 8, NULL, 0, NULL, 1, 0),
(32, 'Maja', 'Deutlich', 1, 6, 3, '2025-12-31', 9, NULL, 0, NULL, 1, 0),
(33, 'Noah', 'Freiberg', 1, 11, 2, '2025-12-31', 9, NULL, 0, NULL, 1, 0),
(34, 'Louis', 'Grobe', 1, 9, 2, '2025-05-15', 9, NULL, 0, NULL, 1, 0),
(35, 'Luisa', 'Höhne', 1, 8, 2, '2025-05-15', 9, NULL, 0, NULL, 1, 0),
(36, 'Lia', 'Schubert', 1, 7, 2, '2025-12-31', 9, NULL, 0, NULL, 1, 0),
(37, 'Anna-Sophie', 'Canitz', 1, 9, 2, '2025-12-31', 10, NULL, 0, NULL, 1, 0),
(38, 'Alina', 'Flores Martin', 1, 7, 2, '2025-12-31', 10, NULL, 0, NULL, 1, 0),
(39, 'Karl', 'König', 1, 6, 2, '2025-05-15', 10, NULL, 0, NULL, 1, 0),
(40, 'Maxilian', 'Motschmann', 1, 8, 2, '2025-12-31', 10, NULL, 0, NULL, 1, 0),
(41, 'Felix', 'Scheithauer', 1, 7, 2, '2025-09-30', 10, NULL, 0, NULL, 1, 0),
(42, 'Karl', 'König', 1, 6, 2, '2025-12-31', 11, NULL, 0, NULL, 1, 0),
(43, 'Luise', 'Schaff', 1, 9, 2, '2025-12-31', 11, NULL, 0, NULL, 1, 0),
(44, 'Zoey', 'Schönherr', 1, 6, 2, '2025-12-31', 11, NULL, 0, NULL, 1, 0),
(45, 'Lia', 'Schubert', 1, 7, 2, '2025-05-16', 11, NULL, 0, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teilnehmer_unterricht`
--

CREATE TABLE `teilnehmer_unterricht` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tmp_schueler`
--

CREATE TABLE `tmp_schueler` (
  `SchuelerID` int(11) NOT NULL,
  `Vorname` varchar(255) DEFAULT NULL,
  `Nachname` varchar(255) DEFAULT NULL,
  `Nachstunde` tinyint(1) DEFAULT NULL,
  `Klassenstufe` int(11) DEFAULT NULL,
  `KlassentypID` int(11) DEFAULT NULL,
  `Bis` date DEFAULT NULL,
  `GruppenID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tmp_schueler`
--

INSERT INTO `tmp_schueler` (`SchuelerID`, `Vorname`, `Nachname`, `Nachstunde`, `Klassenstufe`, `KlassentypID`, `Bis`, `GruppenID`) VALUES
(1, 'Karl', 'Koenig', 1, 6, 2, '2025-12-31', 5),
(20, 'Helena', 'Mußdorf', 1, 10, 2, '2025-12-31', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tmp_unterrichtseinheiten`
--

CREATE TABLE `tmp_unterrichtseinheiten` (
  `id` int(11) NOT NULL,
  `datum` date DEFAULT NULL,
  `zeit` time DEFAULT NULL,
  `dauer_min` int(11) DEFAULT NULL,
  `gruppen_id` int(11) DEFAULT NULL,
  `fach` varchar(255) DEFAULT NULL,
  `lehrkraft` varchar(255) DEFAULT NULL,
  `thema` varchar(255) DEFAULT NULL,
  `absprachen` int(11) DEFAULT NULL,
  `mitarbeit` int(11) DEFAULT NULL,
  `fleissig` int(11) DEFAULT NULL,
  `selbststaendig` int(11) DEFAULT NULL,
  `vorbereitet` int(11) DEFAULT NULL,
  `konzentriert` int(11) DEFAULT NULL,
  `lernfortschritt` int(11) DEFAULT NULL,
  `beherrscht_thema` int(11) DEFAULT NULL,
  `transferdenken` int(11) DEFAULT NULL,
  `basiswissen` int(11) DEFAULT NULL,
  `freitext` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tmp_unterrichtseinheiten`
--

INSERT INTO `tmp_unterrichtseinheiten` (`id`, `datum`, `zeit`, `dauer_min`, `gruppen_id`, `fach`, `lehrkraft`, `thema`, `absprachen`, `mitarbeit`, `fleissig`, `selbststaendig`, `vorbereitet`, `konzentriert`, `lernfortschritt`, `beherrscht_thema`, `transferdenken`, `basiswissen`, `freitext`) VALUES
(1001, '2025-05-28', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Geometrie: Prism', 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, ''),
(1002, '2025-05-23', '14:00:00', 90, 5, 'MAT', 'Städter, Kathleen', 'Geometrie Prismen', 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, ''),
(1003, '2025-05-22', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Geometrie: Prism', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1004, '2025-05-21', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Grundrechenarten: schriftlGRAalle', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1005, '2025-05-16', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Grundrechenarten: schrftlGRA', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1006, '2025-05-14', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Geometrie: Prismen', 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 'weitermachen'),
(1007, '2025-05-13', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Grundrechenarten: alle', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1008, '2025-05-09', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Geometrie: Vierecke', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1009, '2025-05-07', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Geometrie: VE', 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, ''),
(1010, '2025-05-02', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Grundrechenarten: schrftlDiv selbst', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1011, '2025-04-30', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Grundrechenarten: Urschleim schrftlDiv', 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 'ueben'),
(1012, '2025-04-27', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Geometrie: Dreiecke', 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 'Materialien fehlen'),
(1013, '2025-04-16', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Brueche: Kürzen', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1014, '2025-04-09', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Brueche: Kürzen', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1015, '2025-03-27', '14:00:00', 90, 5, 'MAT', 'Trigkidis, Dimitrios', 'Winkel messen und zeichnen', 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 'Karl sehr gut mitgemacht'),
(1016, '2025-03-21', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'bruchrechnen / kürzen / schriftl Div / dezZ bestimmen', 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, ''),
(1017, '2025-03-06', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'weitere Themen: Vorb LK / Prop / Fkt', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 'Textaufgaben'),
(1018, '2025-02-12', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'weitere Themen: Vorb.LK', 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, ''),
(1019, '2025-01-27', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Proportionen/Verhältnisse: Arbeitsblatt Proportionalität', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ''),
(1020, '2025-01-15', '14:00:00', 90, 5, 'MAT', 'Djalilpoor, Sam', 'Zuordnungen: Gruppenarbeit mit Zoey', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 'arbeitet ordentlich und aufmerksam'),
(1021, '2024-12-11', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Dezimalzahlen: Einheitenrechnung', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, ''),
(1022, '2024-11-06', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Brueche: Brueche erweitern', 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 'vorbereitet'),
(1023, '2024-01-15', '14:00:00', 90, 5, 'MAT', 'Djalilpoor, Sam', 'Koordinatensystem', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 'super Mitarbeit'),
(1024, '2024-02-11', '14:00:00', 90, 5, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Dreisatz', 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 'sollte sitzen, kommt gut voran'),
(3001, '2025-05-27', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'ExpLogUmkFkt - Log Wiederholung', 4, 4, 4, 4, 4, 4, 4, 5, 4, 5, ''),
(3002, '2025-05-20', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'ExpWachstum/Log/UmkehrFkt', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3003, '2025-05-07', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Funktionen AB', 4, 4, 4, 4, 4, 4, 4, 5, 4, 5, ''),
(3004, '2025-05-06', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Gedankenexperiment', 4, 4, 4, 4, 4, 4, 4, 5, 3, 5, 'sehr guter Erfolg'),
(3005, '2025-04-30', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Tabelle erarbeitet', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 'riesiger Fortschritt'),
(3006, '2025-04-29', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Lineare Funktion/Gleichung kompl. Aufgabe', 4, 4, 4, 4, 4, 4, 4, 3, 3, 4, 'FktVerst fehlt -> Verh. von Fkt klären'),
(3007, '2025-04-22', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Stochastik: Erw,Wert/Var. Mengen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3008, '2025-04-08', '15:35:00', 90, 6, 'MAT', 'Wolter, Kathrin', 'Stochastik Aufgaben AH', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3009, '2025-04-16', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Stochastik: Varianz/StdAbw', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3010, '2025-04-15', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Stochastik: Glücksrad', 4, 4, 4, 4, 4, 4, 4, 5, 4, 4, 'weiter üben'),
(3011, '2025-04-02', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Stochastik: Wahrscheinlichkeitsrechnung', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3012, '2025-03-19', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Funktionen: ganzrationale Funktionen', 4, 4, 4, 4, 4, 4, 4, 3, 4, 4, 'Unverständnis'),
(3013, '2025-03-18', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'weitere Themen: Auswertung BLF', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3014, '2025-03-12', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'weitere Themen: BLF', 4, 4, 4, 4, 4, 4, 4, 5, 4, 5, ''),
(3015, '2025-02-26', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Terme', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 'Leistungskontrolle'),
(3016, '2025-02-19', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Terme', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3017, '2025-02-05', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Terme', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3018, '2025-01-29', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Graphen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3019, '2025-01-22', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Graphen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3020, '2025-01-08', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Funktionen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3021, '2024-12-18', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'lineare Funktionen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3022, '2024-12-11', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'lineare Funktionen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3023, '2024-12-04', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'lineare Funktionen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3024, '2024-11-27', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Terme', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3025, '2024-11-20', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Terme', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3026, '2024-11-06', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Terme', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3027, '2024-10-30', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Gleichungen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3028, '2024-10-23', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Gleichungen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3029, '2024-10-09', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Gleichungen', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3030, '2024-09-25', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Prozentrechnung', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3031, '2024-09-18', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Prozentrechnung', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ''),
(3032, '2024-09-11', '15:35:00', 90, 6, 'MAT', 'Thiele, Dipl.-Ing. Olaf', 'Prozentrechnung', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_mtr_emotion_zuwertung`
--

CREATE TABLE `ue_mtr_emotion_zuwertung` (
  `id` int(11) NOT NULL,
  `emotion_metrik_id` int(11) NOT NULL,
  `dimension_id` int(11) NOT NULL,
  `wert` tinyint(4) NOT NULL CHECK (`wert` between 1 and 6),
  `kommentar` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_mtr_feedback_zuwertung`
--

CREATE TABLE `ue_mtr_feedback_zuwertung` (
  `id` int(11) NOT NULL,
  `feedback_metrik_id` int(11) NOT NULL,
  `typ_id` int(11) NOT NULL,
  `wert` tinyint(4) NOT NULL CHECK (`wert` between 1 and 6),
  `kommentar` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_mtr_kompetenz_zuwertung`
--

CREATE TABLE `ue_mtr_kompetenz_zuwertung` (
  `id` int(11) NOT NULL,
  `kompetenz_metrik_id` int(11) NOT NULL,
  `kompetenzbereich_id` int(11) NOT NULL,
  `kompetenzstufe_id` int(11) NOT NULL,
  `kommentar` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_mtr_lernihalte_themen`
--

CREATE TABLE `ue_mtr_lernihalte_themen` (
  `id` int(11) NOT NULL,
  `typ_id` int(11) NOT NULL,
  `lerninhalt_id` int(11) NOT NULL,
  `lern_unterthema_id` int(11) NOT NULL,
  `lernform_id` int(2) NOT NULL,
  `freitext` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_mtr_medien_zuwertung`
--

CREATE TABLE `ue_mtr_medien_zuwertung` (
  `id` int(11) NOT NULL,
  `medien_metrik_id` int(11) NOT NULL,
  `medienart_id` int(11) NOT NULL,
  `effekt_id` int(11) NOT NULL,
  `wert` tinyint(4) NOT NULL CHECK (`wert` between 1 and 6),
  `kommentar` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_mtr_thema_zuwertung`
--

CREATE TABLE `ue_mtr_thema_zuwertung` (
  `id` int(11) NOT NULL,
  `thema_metrik_id` int(11) NOT NULL,
  `quelle` enum('Lehrplan','Schülerserver') NOT NULL,
  `quelle_id` int(11) NOT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `wert` tinyint(4) NOT NULL CHECK (`wert` between 1 and 6),
  `kommentar` text DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_schueler`
--

CREATE TABLE `ue_schueler` (
  `id` int(11) NOT NULL,
  `ue_id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL,
  `metrik_didaktik_id` int(11) DEFAULT NULL,
  `metrik_leistung_id` int(11) DEFAULT NULL,
  `metrik_sozial_id` int(11) DEFAULT NULL,
  `metrik_emotion_id` int(11) DEFAULT NULL,
  `metrik_thema_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_unterrichtseinheit`
--

CREATE TABLE `ue_unterrichtseinheit` (
  `id` int(11) NOT NULL,
  `datum` date NOT NULL,
  `zeit` int(3) NOT NULL DEFAULT 90,
  `gruppe_id` int(11) DEFAULT 0,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_unterrichtsmaterial`
--

CREATE TABLE `ue_unterrichtsmaterial` (
  `id` int(11) NOT NULL,
  `inhalt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `ue_unterrichtsmaterial`
--

INSERT INTO `ue_unterrichtsmaterial` (`id`, `inhalt`) VALUES
(1, '\r\nQuadratische Funktionen\r\nSchwierigkeitsgrad: mittel\r\nThemen: quadratische/lineare Gleichungen, Gleichungssysteme, Potenzrechnung\r\n\r\nVorbereitung (8’)\r\n\r\nWir müssen zum Anfang zwei Gedankenexperimente durchführen:\r\nTennisplatz:\r\n\r\nDu sollst mit deinem Nachbarn aus dem Physikunterricht untersuchen: “Wie verläuft die Flugbahn eines Tennisballs, wenn ich diesen schräg in die Luft werfe?” \r\nLege eine Skizze des Tennisplatzes von der Seite an und zeichne die Stelle links auf  der Skizze, von der ihr werft.\r\nWirf jetzt gedanklich den Ball 2 Mal. Die Kraft soll gleich bleiben, nur der Winkel ändert sich! Wurf A: leicht nach oben. Wurf B: mittel schräg nach oben (etwa 45°). Zeichne mit blau die Flugbahnen des Tennisballs in deine Skizze ein. Was kannst du in Abhängigkeit vom Winkel für die Wurfbahn ableiten?\r\nWähle jetzt den Winkel von 45°. Werft den Ball 2 Mal, aber jedes Mal mit einer anderen Kraft: Wurf C: ganz locker. Wurf D: mittel kräftig.Was kannst du in Abhängigkeit von der Wurfkraft für die Wurfbahn ableiten?\r\nNotiere die gedanklich festgestellten Abhängigkeiten der Wurfbahn. Gibt es noch andere Kräfte, die wirken?\r\n\r\nTür:\r\nDu bist in Gedanken und willst den Raum verlassen. Du bemerkst nicht, dass die Tür geschlossen ist und läufst dagegen. Was passiert?\r\nNimm an, du wärst doppelt so schnell gewesen. Gibt es einen Unterschied zu vorher?\r\nJetzt passiert dasselbe Herrn Thiele (85 kg). Würde er einen Unterschied bei gleicher Geschwindigkeit feststellen?\r\nNotiere dir, wovon hängt das, was du/Herr Thiele erleben, ab.\r\nDiskutiere deine Ergebnisse aus 1. und 2. mit Herrn Thiele\r\n\r\n\r\nAufgabe (120’)\r\n\r\nDu arbeitest als Konstruktionsingenieur für die “alphaLaser GmbH” und sollst für einen Düngemittelhersteller eine neue Verladehalle konzipieren, in der 24h/d automatisch beim Verladen von Düngemittelkörnern durch ein Druckluftsystem mittels Laser Verunreinigungen beseitigt und ebenfalls verladen werden sollen.\r\nBekannt ist folgendes:\r\nin einem Container befindet sich verunreinigtes Düngemittel (m=3g; Anteil der Verunreinigungen 15,5%; Dichte im Luftstrom = 0,32 kg l-1 )\r\ndurch ein Rohr (25cm Durchmesser, Winkel 30°, Austrittsöffnung in Höhe von 2,85m) wird mittels Druckluft, Geschwindigkeit 7ms-1 , der verunreinigte Dünger in eine neu zu konzipierende Verladehalle “geblasen”\r\nnach Verlassen des Rohres bewegen sich die Düngerkörner auf der Bahn einer Wurfparabel (g = 9,81, v0  wird dimensionslos in ms-1 angegeben, h = Höhe in m, cos() und tan() sind Konstanten),\r\n  \r\n\r\n-0,5 g(v0-cos())2 x2+tan() x + h\r\n\r\n\r\nin der Halle sollen 2 Förderbänder laufen (befinden sich mit der Öffnung in Bodenhöhe), eines für das gereinigte Düngemittel, das andere für die Verunreinigungen\r\nder Laser (Impuls = 174 mNs, Anstellwinkel 42°) ist bereits installiert und dessen Austrittsöffnung befindet sich senkrecht zur Rohraustrittsöffnung in Höhe von 48cm mit dem gegebenen Anstellwinkel derselben Wand\r\nein Laser ist ein Gerät, welches einen sehr starken, gebündelten Lichtstrahl erzeugt, der geradlinig verläuft, wobei die Photonen alle die gleiche Farbe (Wellenlänge) haben,\r\nder Impuls des Lasers wird beim Auftreffen auf ein verunreinigtes Korn vollständig auf dieses übertragen\r\nein Impuls ist das Produkt aus Masse und Geschwindigkeit\r\n\r\nN = m * v\r\n\r\nder Laser ist mit einer Fotozelle gekoppelt, die die Verunreinigungen im Teilchenstrom erkennen kann und dann ein Signal zur Auslösung des Lasers sendet\r\n\r\nFür die Konzeption der Halle muss nun geklärt werden, wo die einzelnen Elemente installiert werden müssen, wie hoch die Halle mindestens sein muss (Sicherheitsabstand zum Körnerstrom 1m nach oben) und wieviel gereinigten Dünger man somit pro Tag reinigen und verladen kann. Der Luftwiderstand wird vernachlässigt.\r\nAnlage skizzieren,\r\nProblem andersfarbig eintragen,\r\nFormeln und Konstanten bestimmen\r\nFunktionsgleichung für den Verlauf des Teilchenstrom nach dem Austritt aus dem Rohr bestimmen,\r\nPosition des Förderbandes für das gereinigte Düngemittel bestimmen,\r\nFunktionsgleichung für den Verlauf des Laserstrahls in der zukünftigen Halle bestimmen,\r\nKoordinaten für die Position der Fotozelle bestimmen,\r\nFunktionsgleichung für den Verlauf des Teilchenstrom der Verunreinigungen nach der Impulsübertragung durch den Laser bestimmen,\r\nPosition des Förderbandes für die Verunreinigungen bestimmen,\r\nMindesthöhe der Halle bestimmen,\r\nFörderleistung pro Tag berechnen\r\n\r\nFragen (sobald Du bei einer Frage nicht weiter kommst, diskutiere Deinen Lösungsansatz mit Herrn Thiele):\r\nkannst Du die Anlage skizzieren?\r\nkannst Du das Problem in die Skizze eintragen?\r\nkannst Du die gesuchten Werte markieren/notieren?\r\nkannst Du die Formeln und Konstanten für die Berechnung der Flugbahn des gereinigten Düngemittels aufstellen?\r\nkannst Du erkennen, dass bei gegebener Geschwindigkeit und Winkel die Gleichung der Flugbahn zu einer Form f(x) = ax^2 +bx + h wird?\r\nkannst Du a und b und berechnen?\r\nkannst Du die Position des Förderbandes berechnen?\r\nkannst Du eine Funktionsgleichung für den Strahl des Lasers aufstellen?\r\nkannst Du eine Gleichung für die Berechnung der Position der Fotozelle aufstellen?\r\nkannst Du die Koordinaten der Fotozelle bestimmen?\r\nkannst Du die Formeln und Konstanten für die Berechnung der Flugbahn des verunreinigten Düngemittels aufstellen?\r\nKannst Du die Höhe des Dachs bestimmen?\r\nKannst Du eine Formel zur Förderleistung aufstellen?\r\nKannst Du die Förderleistung berechnen?\r\n'),
(2, '🛰️ Mathematische Analyse – Kreissegmente auf der ISS\r\nAuf der Internationalen Raumstation (ISS) soll ein Hochgenauigkeitsmessgerät für Gasströme installiert werden. Dazu wird eine Gaspumpe mit zwei besonders beanspruchten Lagerstellen benötigt. Diese entsprechen zwei Kreissegmenten in der folgenden Skizze. Zur Stabilitätsberechnung muss die Fläche dieser Kreissegmente berechnet werden.\r\nNutze dein Wissen aus Geometrie, Trigonometrie und linearen Funktionen.\r\nSkizze:\r\n\r\n\r\n🔍 Ziel der Aufgabe\r\nBestimme die Fläche der beiden farblich hervorgehobenen Kreissegmente auf drei Stellen genau.\r\nDie Maße sind in Millimetern angegeben.\r\n🔍 gegeben\r\nPunkt P(5,3)\r\nPunkt M(13,9)\r\nInnenkreis mit Mittelpunkt in M und Radius 4mm\r\nAußenkreis mit Mittelpunkt in M und Radius 4,5mm\r\nTangenten mit gemeinsamen Schnittpunkt P am Innenkreis (Innenkreis des Lagers)\r\nTangenten mit gemeinsamen Schnittpunkt P am Außenkreis Kreis (Außenkreis  des Lagers, Befestigung Stabhalterung des Lagers)\r\n🧩 Leitfragen zum schrittweisen Arbeiten\r\n1. Welche zwei Punkte kennst du, um die Gerade PM aufzustellen?\r\n2. Wie berechnest du aus zwei Punkten eine Funktionsgleichung?\r\n3. Was weißt du über den Winkel zwischen dem Radius und der Tangente?\r\n4. Wie kannst du den Winkel zur Gerade PM berechnen (z. B. mit Tangens)?\r\n5. Wie berechnest du die Steigung einer Geraden, die senkrecht auf einer anderen steht?\r\n6. Was brauchst du, um die Tangentengleichung zu bestimmen (Punkt + Steigung)?\r\n7. Wie kannst du mit Dreiecken oder Winkeln den Kreissektor berechnen?\r\n8. Wie erhältst du aus dem Sektor die Fläche des Kreissegments?\r\n🆘 Differenzierte Hilfen\r\n💡 Hinweis 1: Die Gerade PM verläuft durch zwei Punkte – bestimme ihre Steigung m und den y-Achsenabschnitt.\r\n💡 Hinweis 2: Tangenten stehen senkrecht auf dem Radius im Berührpunkt – also ist ihre Steigung der negative Kehrwert der Radiussteigung.\r\n💡 Hinweis 3: Nutze tan(α) = m, um Winkel zu berechnen, falls du Steigungen kennst.\r\n💡 Hinweis 4: Die Fläche eines Kreissegments ergibt sich aus der Fläche des Sektors minus des zugehörigen Dreiecks (oder durch eine Formel direkt mit dem Mittelpunktswinkel).\r\n💡 Hinweis 5: Berechne die Strecke PM über den Satz des Pythagoras, um sie im weiteren Verlauf nutzen zu können.\r\n\r\n🔧 Rechne mit r₁ = 4 mm und r₂ = 4,5 mm. Nutze geeignete trigonometrische Beziehungen.\r\n');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_unterricht_lehrkraft`
--

CREATE TABLE `ue_unterricht_lehrkraft` (
  `id` int(11) NOT NULL,
  `unterrichtseinheit_id` int(11) NOT NULL,
  `lehrkraft_id` int(11) NOT NULL,
  `rolle_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ue_zuweisung_ue_mtr_lerninhalt`
--

CREATE TABLE `ue_zuweisung_ue_mtr_lerninhalt` (
  `id` int(11) NOT NULL,
  `ue_id` int(11) NOT NULL,
  `lerninhalt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `unterrichtsinhalt`
--

CREATE TABLE `unterrichtsinhalt` (
  `id` int(11) NOT NULL,
  `unterrichts_id` int(11) NOT NULL,
  `lernfeld_id` int(11) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `quelle` varchar(100) DEFAULT NULL,
  `ursprung` varchar(50) DEFAULT NULL COMMENT 'z.B. ICAS, eigene Planung',
  `beobachtungsmaske_vorhanden` tinyint(1) DEFAULT 0 COMMENT '1 = Beobachtungsdaten existieren',
  `noten_erhoben` tinyint(1) DEFAULT 1 COMMENT '1 = Noten zu dieser Einheit gespeichert'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `unterrichtsstatus_code`
--

CREATE TABLE `unterrichtsstatus_code` (
  `id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `beschreibung` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `unterrichtsstatus_code`
--

INSERT INTO `unterrichtsstatus_code` (`id`, `code`, `beschreibung`) VALUES
(1, 'VF', 'Vertretung für eine Lehrkraft'),
(2, 'VFG', 'Vertretung freigegeben'),
(3, 'U', 'Unterschrift erforderlich'),
(4, 'GESPERRT', 'Teilnehmer gesperrt'),
(5, 'PROBE', 'Probeschüler'),
(6, 'VSG', 'Versetzungsgefährdet'),
(7, 'BLOCKED', 'Systemintern gesperrt');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `var_gruppen`
--

CREATE TABLE `var_gruppen` (
  `id` int(11) NOT NULL,
  `tag` int(1) NOT NULL,
  `zeit` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `var_gruppen_schueler`
--

CREATE TABLE `var_gruppen_schueler` (
  `id` int(11) NOT NULL,
  `gruppen_id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_bewertung_textbausteine_unterkategorie`
--

CREATE TABLE `_bewertung_textbausteine_unterkategorie` (
  `id` int(11) NOT NULL,
  `textbaustein_id` int(11) NOT NULL,
  `wert` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_bewertung_textbausteine_unterkategorie`
--

INSERT INTO `_bewertung_textbausteine_unterkategorie` (`id`, `textbaustein_id`, `wert`) VALUES
(1, 1, 'klar und präzise'),
(2, 1, 'strukturiert'),
(3, 1, 'fragmentiert'),
(4, 1, 'fehlerhaft'),
(5, 2, 'zentralen'),
(6, 2, 'wichtigen'),
(7, 2, 'weniger wichtigen'),
(8, 3, 'einfache'),
(9, 3, 'komplexe'),
(10, 3, 'unbekannte'),
(11, 4, 'gut'),
(12, 4, 'eingeschränkt'),
(13, 4, 'nicht'),
(14, 5, 'ausgezeichnete'),
(15, 5, 'gute'),
(16, 5, 'durchschnittliche'),
(17, 5, 'schwache'),
(18, 5, 'keine'),
(19, 6, 'strukturiert'),
(20, 6, 'systematisch'),
(21, 6, 'zielorientiert'),
(22, 6, 'chaotisch'),
(23, 6, 'nicht'),
(24, 7, 'präzise und umfassend'),
(25, 7, 'strukturiert'),
(26, 7, 'oberflächlich'),
(27, 7, 'fehlerhaft'),
(28, 7, 'nicht'),
(29, 8, 'sicher'),
(30, 8, 'überwiegend'),
(31, 8, 'teilweise'),
(32, 8, 'nicht'),
(33, 9, 'konstruktiv und differenziert'),
(34, 9, 'teilweise'),
(35, 9, 'selten'),
(36, 9, 'nie'),
(37, 10, 'gut'),
(38, 10, 'eingeschränkt'),
(39, 10, 'nicht');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_didaktik_bezeichnung_level`
--

CREATE TABLE `_mtr_didaktik_bezeichnung_level` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `wert` int(11) DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_didaktik_bezeichnung_level`
--

INSERT INTO `_mtr_didaktik_bezeichnung_level` (`id`, `bezeichnung`, `beschreibung`, `wert`, `erstellt_am`) VALUES
(1, 'Sehr gering', 'Kaum vorhanden', 1, '2025-06-01 12:14:57'),
(2, 'Gering', 'Verbesserungswürdig', 2, '2025-06-01 12:14:57'),
(3, 'Mittel', 'Durchschnittlich', 3, '2025-06-01 12:14:57'),
(4, 'Hoch', 'Gut', 4, '2025-06-01 12:14:57'),
(5, 'Sehr hoch', 'Exzellent', 5, '2025-06-01 12:14:57');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_didaktik_materialien`
--

CREATE TABLE `_mtr_didaktik_materialien` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `wert` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_didaktik_themenauswahl`
--

CREATE TABLE `_mtr_didaktik_themenauswahl` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `wert` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_emotion_dimension`
--

CREATE TABLE `_mtr_emotion_dimension` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_emotion_dimension`
--

INSERT INTO `_mtr_emotion_dimension` (`id`, `bezeichnung`, `beschreibung`) VALUES
(1, 'Valenz', 'Positivität vs. Negativität des emotionalen Zustands'),
(2, 'Arousal', 'Grad der Aktivierung oder Erregung'),
(3, 'Dominanz', 'Gefühl von Kontrolle oder Unterlegenheit');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_feedback_typ`
--

CREATE TABLE `_mtr_feedback_typ` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_kompetenzbereich`
--

CREATE TABLE `_mtr_kompetenzbereich` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_kompetenzstufe`
--

CREATE TABLE `_mtr_kompetenzstufe` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `niveau` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_leistung_basiswissen`
--

CREATE TABLE `_mtr_leistung_basiswissen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_leistung_basiswissen`
--

INSERT INTO `_mtr_leistung_basiswissen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Basiswissen', 'None', 'Der Lernende verfügt über kein relevantes Basiswissen, um das Thema zu verstehen.', 'Custom'),
(2, 'Fragmentarisches Basiswissen', 'Fragmentary', 'Der Lernende verfügt über lückenhaftes oder unvollständiges Basiswissen.', 'Custom'),
(3, 'Oberflächliches Basiswissen', 'Superficial', 'Der Lernende verfügt über ein oberflächliches Verständnis des Basiswissens, das für ein tieferes Verständnis nicht ausreicht.', 'Custom'),
(4, 'Ausreichendes Basiswissen', 'Sufficient', 'Der Lernende verfügt über ausreichend Basiswissen, um die grundlegenden Konzepte des Themas zu verstehen.', 'Custom'),
(5, 'Solides Basiswissen', 'Solid', 'Der Lernende verfügt über ein solides und gut fundiertes Basiswissen, das ein tieferes Verständnis und die Anwendung des Wissens ermöglicht.', 'Custom'),
(6, 'Umfassendes Basiswissen', 'Comprehensive', 'Der Lernende verfügt über ein umfassendes und detailliertes Basiswissen, das es ihm ermöglicht, komplexe Zusammenhänge zu verstehen und das Wissen in verschiedenen Kontexten anzuwenden.', 'Custom');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_leistung_beherrscht_thema`
--

CREATE TABLE `_mtr_leistung_beherrscht_thema` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_leistung_beherrscht_thema`
--

INSERT INTO `_mtr_leistung_beherrscht_thema` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Verständnis', 'None', 'Der Lernende hat kein Verständnis des Themas und kann grundlegende Fragen nicht beantworten.', 'Custom'),
(2, 'Grundlegendes Verständnis', 'Basic', 'Der Lernende hat ein grundlegendes Verständnis des Themas und kann einfache Konzepte erklären, hat aber Schwierigkeiten bei komplexeren Fragestellungen.', 'Custom'),
(3, 'Angemessenes Verständnis', 'Adequate', 'Der Lernende hat ein angemessenes Verständnis des Themas und kann die meisten Fragen beantworten und Probleme lösen, benötigt aber möglicherweise noch Unterstützung.', 'Custom'),
(4, 'Gutes Verständnis', 'Good', 'Der Lernende hat ein gutes Verständnis des Themas und kann komplexe Fragen beantworten und Probleme selbstständig lösen.', 'Custom'),
(5, 'Ausgezeichnete Beherrschung', 'Excellent', 'Der Lernende hat eine ausgezeichnete Beherrschung des Themas, kann es detailliert erklären, komplexe Probleme lösen und das Wissen auf neue Situationen anwenden.', 'Custom'),
(6, 'Experte', 'Expert', 'Der Lernende ist ein Experte auf dem Gebiet, kann das Thema umfassend erklären, neue Erkenntnisse gewinnen und andere in diesem Bereich unterrichten.', 'Custom');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_leistung_lernfortschritt`
--

CREATE TABLE `_mtr_leistung_lernfortschritt` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_leistung_lernfortschritt`
--

INSERT INTO `_mtr_leistung_lernfortschritt` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Anfänger (Dreyfus)', 'Novice', 'Befolgt strikt Regeln und Anweisungen, ohne Kontext oder Flexibilität.', 'Dreyfus'),
(2, 'Fortgeschrittener Anfänger', 'Advanced Beginner', 'Beginnt, situative Aspekte zu erkennen, benötigt aber noch Anleitung und hat Schwierigkeiten bei komplexen Entscheidungen.', 'Dreyfus'),
(3, 'Kompetent', 'Competent', 'Kann Ziele setzen und planen, aber es fehlt noch an intuitiver Entscheidungsfindung und Flexibilität in unvorhergesehenen Situationen.', 'Dreyfus'),
(4, 'Wissen', 'Remembering', 'Sich an grundlegende Informationen erinnern und diese abrufen können.', 'Bloom'),
(5, 'Reaktion', 'Reaction', 'Wie die Teilnehmenden die Schulung oder das Lernangebot empfunden haben (z.B. Zufriedenheit).', 'Kirkpatrick'),
(6, 'Verstehen', 'Understanding', 'Konzepte und Ideen erklären und in eigenen Worten wiedergeben können.', 'Bloom'),
(7, 'Lernen', 'Learning', 'Was die Teilnehmenden tatsächlich gelernt und verstanden haben (Wissenszuwachs).', 'Kirkpatrick'),
(8, 'Anwenden', 'Applying', 'Informationen in neuen, konkreten Situationen und Kontexten nutzen und einsetzen können.', 'Bloom'),
(9, 'Verhalten', 'Behavior', 'Wie sich das Verhalten der Teilnehmenden aufgrund des Gelernten im Arbeitsalltag verändert hat.', 'Kirkpatrick'),
(10, 'Analysieren', 'Analyzing', 'Verbindungen und Beziehungen zwischen verschiedenen Ideen und Konzepten erkennen und herstellen können.', 'Bloom'),
(11, 'Erfahren', 'Proficient', 'Kann Situationen ganzheitlich betrachten und intuitiv handeln, benötigt weniger Anleitung und kann auch in komplexen Situationen effektive Entscheidungen treffen.', 'Dreyfus'),
(12, 'Bewerten', 'Evaluating', 'Begründete Urteile fällen und fundierte Entscheidungen treffen können.', 'Bloom'),
(13, 'Ergebnisse', 'Results', 'Welche messbaren, positiven Ergebnisse (z.B. verbesserte Leistung, höhere Effizienz) durch die Schulung oder das Lernangebot erzielt wurden.', 'Kirkpatrick'),
(14, 'Erschaffen', 'Creating', 'Neue und originelle Arbeiten oder Lösungen entwickeln und erstellen können.', 'Bloom'),
(15, 'Experte', 'Expert', 'Handelt intuitiv und flexibel, setzt neue Standards und kann innovative Lösungen entwickeln. Verfügt über tiefes, umfassendes Wissen und Können.', 'Dreyfus');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_leistung_transferdenken`
--

CREATE TABLE `_mtr_leistung_transferdenken` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_leistung_transferdenken`
--

INSERT INTO `_mtr_leistung_transferdenken` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Transferdenken', 'None', 'Der Lernende kann das Wissen nicht auf andere Situationen anwenden.', 'Custom'),
(2, 'Minimales Transferdenken', 'Minimal', 'Der Lernende kann das Wissen nur auf sehr ähnliche Situationen anwenden.', 'Custom'),
(3, 'Geleitetes Transferdenken', 'Guided', 'Der Lernende kann das Wissen mit Anleitung auf neue Situationen anwenden.', 'Custom'),
(4, 'Selbstständiges Transferdenken', 'Independent', 'Der Lernende kann das Wissen selbstständig auf neue Situationen anwenden.', 'Custom'),
(5, 'Kreatives Transferdenken', 'Creative', 'Der Lernende kann das Wissen kreativ auf völlig neue und unvorhergesehene Situationen anwenden und innovative Lösungen entwickeln.', 'Custom'),
(6, 'Generalisiertes Transferdenken', 'Generalized', 'Der Lernende kann das Wissen auf ein breites Spektrum von Situationen anwenden und generelle Prinzipien ableiten.', 'Custom');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_leistung_vorbereitet`
--

CREATE TABLE `_mtr_leistung_vorbereitet` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_leistung_vorbereitet`
--

INSERT INTO `_mtr_leistung_vorbereitet` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Nicht vorbereitet', 'Unprepared', 'Der Lernende hat keine der erforderlichen Vorbereitungen getroffen.', 'Custom'),
(2, 'Mangelhaft vorbereitet', 'Poorly Prepared', 'Der Lernende hat einige Vorbereitungen getroffen, aber diese sind unzureichend oder fehlerhaft.', 'Custom'),
(3, 'Teilweise vorbereitet', 'Partially Prepared', 'Der Lernende hat einen Teil der erforderlichen Vorbereitungen getroffen.', 'Custom'),
(4, 'Gut vorbereitet', 'Well Prepared', 'Der Lernende hat alle erforderlichen Vorbereitungen getroffen und ist bereit für die Lernsitzung oder Aufgabe.', 'Custom'),
(5, 'Sehr gut vorbereitet', 'Very Well Prepared', 'Der Lernende hat nicht nur alle erforderlichen Vorbereitungen getroffen, sondern sich auch zusätzlich mit dem Thema auseinandergesetzt.', 'Custom'),
(6, 'Ausgezeichnet vorbereitet', 'Excellently Prepared', 'Der Lernende hat sich außergewöhnlich gut vorbereitet, das Thema umfassend recherchiert und ist in der Lage, aktiv zum Lernprozess beizutragen.', 'Custom');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_medienart`
--

CREATE TABLE `_mtr_medienart` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_medieneffekt`
--

CREATE TABLE `_mtr_medieneffekt` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_sozial_absprachen`
--

CREATE TABLE `_mtr_sozial_absprachen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_sozial_absprachen`
--

INSERT INTO `_mtr_sozial_absprachen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Absprachen', 'Isolation', 'Der Teilnehmer vermeidet jegliche Kommunikation und Absprachen mit anderen.', 'Level 1: Vollständige Isolation'),
(2, 'Seltene Absprachen', 'Gelegentliche Kommunikation', 'Der Teilnehmer kommuniziert nur, wenn es unbedingt notwendig ist und vermeidet den Austausch.', 'Level 2: Seltene Kommunikation'),
(3, 'Durchschnittliche Absprachen', 'Regelmäßige Kommunikation', 'Der Teilnehmer tauscht sich regelmäßig mit anderen aus, um Aufgaben zu koordinieren und Informationen zu teilen.', 'Level 3: Regelmäßige Kommunikation'),
(4, 'Häufige Absprachen', 'Aktive Koordination', 'Der Teilnehmer sucht aktiv den Austausch mit anderen, um Aufgaben optimal abzustimmen und Probleme gemeinsam zu lösen.', 'Level 4: Aktive Koordination'),
(5, 'Exzellente Absprachen', 'Strategische Koordination', 'Der Teilnehmer initiiert und fördert strategische Absprachen, um die Effizienz und Effektivität des Teams zu maximieren. Fördert eine offene und transparente Kommunikation.', 'Level 5: Strategische und transparente Koordination');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_sozial_fleiss`
--

CREATE TABLE `_mtr_sozial_fleiss` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_sozial_fleiss`
--

INSERT INTO `_mtr_sozial_fleiss` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Fleiss', 'Antriebslosigkeit', 'Der Teilnehmer zeigt keinerlei Arbeitsbereitschaft oder Engagement. Aufgaben werden vermieden oder nur widerwillig erledigt.', 'Level 1: Vollständige Antriebslosigkeit'),
(2, 'Geringer Fleiss', 'Minimale Arbeitsbereitschaft', 'Der Teilnehmer zeigt wenig Eigeninitiative und erledigt Aufgaben nur, wenn es unbedingt notwendig ist.', 'Level 2: Minimale Arbeitsbereitschaft'),
(3, 'Durchschnittlicher Fleiss', 'Regelmäßige Arbeitsbereitschaft', 'Der Teilnehmer erledigt Aufgaben zuverlässig und zeigt eine durchschnittliche Arbeitsbereitschaft.', 'Level 3: Regelmäßige Arbeitsbereitschaft'),
(4, 'Hoher Fleiss', 'Engagierte Arbeitsweise', 'Der Teilnehmer ist hochmotiviert, übernimmt zusätzliche Aufgaben und arbeitet kontinuierlich an der Verbesserung seiner Leistung.', 'Level 4: Engagierte Arbeitsweise'),
(5, 'Exzellenter Fleiss', 'Ausdauernde Zielstrebigkeit', 'Der Teilnehmer zeigt außergewöhnliche Ausdauer und Zielstrebigkeit, übertrifft Erwartungen und setzt sich kontinuierlich für den Erfolg des Teams ein.', 'Level 5: Ausdauernde Zielstrebigkeit');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_sozial_konzentration`
--

CREATE TABLE `_mtr_sozial_konzentration` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_sozial_konzentration`
--

INSERT INTO `_mtr_sozial_konzentration` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Konzentration', 'Ablenkung', 'Der Teilnehmer ist ständig abgelenkt, kann sich nicht auf Aufgaben konzentrieren und verliert schnell den Fokus.', 'Level 1: Ständige Ablenkung'),
(2, 'Geringe Konzentration', 'Häufige Ablenkung', 'Der Teilnehmer lässt sich leicht ablenken und benötigt häufige Pausen, um sich wieder zu sammeln.', 'Level 2: Häufige Ablenkung'),
(3, 'Durchschnittliche Konzentration', 'Gelegentliche Ablenkung', 'Der Teilnehmer kann sich für eine gewisse Zeit konzentrieren, wird aber gelegentlich durch äußere Einflüsse abgelenkt.', 'Level 3: Gelegentliche Ablenkung'),
(4, 'Hohe Konzentration', 'Fokussiertes Arbeiten', 'Der Teilnehmer kann sich gut konzentrieren und Aufgaben fokussiert bearbeiten, ohne sich leicht ablenken zu lassen.', 'Level 4: Fokussiertes Arbeiten'),
(5, 'Exzellente Konzentration', 'Tiefes Konzentrationsvermögen', 'Der Teilnehmer verfügt über ein außergewöhnliches Konzentrationsvermögen, kann tief in Aufgaben eintauchen und auch unter schwierigen Bedingungen hochproduktiv arbeiten.', 'Level 5: Tiefes Konzentrationsvermögen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_sozial_mitarbeit`
--

CREATE TABLE `_mtr_sozial_mitarbeit` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_sozial_mitarbeit`
--

INSERT INTO `_mtr_sozial_mitarbeit` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Mitarbeit', 'Passivität', 'Der Teilnehmer zeigt keinerlei Engagement oder Beteiligung. Ignoriert Aufgaben und Anweisungen.', 'Level 1: Keine Beteiligung'),
(2, 'Minimale Mitarbeit', 'Gelegentliche Beteiligung', 'Der Teilnehmer beteiligt sich nur selten und auf Aufforderung. Zeigt wenig Eigeninitiative.', 'Level 2: Geringfügige Beteiligung'),
(3, 'Durchschnittliche Mitarbeit', 'Aktive Beteiligung', 'Der Teilnehmer beteiligt sich regelmäßig, bringt Ideen ein und arbeitet mit anderen zusammen.', 'Level 3: Aktive Beteiligung'),
(4, 'Hohe Mitarbeit', 'Engagierte Teilnahme', 'Der Teilnehmer ist hochmotiviert, übernimmt Verantwortung und treibt Projekte voran. Fördert die Zusammenarbeit im Team.', 'Level 4: Engagierte Teilnahme'),
(5, 'Exzellente Mitarbeit', 'Führungsrolle', 'Der Teilnehmer agiert als Vorbild, inspiriert andere und leitet Projekte. Löst Probleme selbstständig und trägt maßgeblich zum Erfolg bei.', 'Level 5: Führungsrolle/Vorbild');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_mtr_sozial_selbststaendigkeit`
--

CREATE TABLE `_mtr_sozial_selbststaendigkeit` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_mtr_sozial_selbststaendigkeit`
--

INSERT INTO `_mtr_sozial_selbststaendigkeit` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Selbstständigkeit', 'Vollständige Abhängigkeit', 'Der Teilnehmer ist vollständig auf Anweisungen und Hilfe anderer angewiesen.', 'Level 1: Vollständige Abhängigkeit'),
(2, 'Geringe Selbstständigkeit', 'Gelegentliche Eigeninitiative', 'Der Teilnehmer zeigt gelegentlich Eigeninitiative, benötigt aber häufig Unterstützung.', 'Level 2: Gelegentliche Eigeninitiative'),
(3, 'Durchschnittliche Selbstständigkeit', 'Eigenständige Aufgabenlösung', 'Der Teilnehmer löst Aufgaben eigenständig, sucht aber bei komplexeren Problemen Hilfe.', 'Level 3: Eigenständige Aufgabenlösung'),
(4, 'Hohe Selbstständigkeit', 'Eigenverantwortliches Handeln', 'Der Teilnehmer übernimmt Verantwortung für seine Aufgaben und löst Probleme selbstständig.', 'Level 4: Eigenverantwortliches Handeln'),
(5, 'Exzellente Selbstständigkeit', 'Autonomes Handeln', 'Der Teilnehmer handelt autonom, initiiert eigene Projekte und trägt maßgeblich zum Erfolg bei.', 'Level 5: Autonomes Handeln');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_ue_lehrkraft_rolle`
--

CREATE TABLE `_ue_lehrkraft_rolle` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(100) NOT NULL,
  `beschreibung` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_ue_lehrkraft_rolle`
--

INSERT INTO `_ue_lehrkraft_rolle` (`id`, `bezeichnung`, `beschreibung`) VALUES
(1, 'Standard', 'Reguläre Lehrkraft der Einheit'),
(2, 'Hilfslehrer', 'Unterstützende Lehrkraft'),
(3, 'Hospitation', 'Hospitierende Beobachter'),
(4, 'Vertretung', 'Eingesprungene Vertretung'),
(5, 'Gast', 'Externe Beteiligung z. B. Dozent, Trainer');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_ue_lernziele`
--

CREATE TABLE `_ue_lernziele` (
  `id` int(11) NOT NULL,
  `allgemeine_ziele` varchar(255) NOT NULL,
  `bildungsstufe` varchar(255) NOT NULL,
  `lernziel` varchar(255) NOT NULL,
  `faehigkeit` varchar(255) NOT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_ue_lernziele`
--

INSERT INTO `_ue_lernziele` (`id`, `allgemeine_ziele`, `bildungsstufe`, `lernziel`, `faehigkeit`, `erstellt_am`) VALUES
(1, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kritisches Denken', 'Fähigkeit, Argumente zu analysieren und zu bewerten', '2025-06-05 09:28:51'),
(2, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kritisches Denken', 'Erkennen von Fehlschlüssen und Widersprüchen', '2025-06-05 09:28:51'),
(3, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kritisches Denken', 'Hinterfragen von Quellen und Informationen', '2025-06-05 09:28:51'),
(4, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kritisches Denken', 'Fähigkeit, verschiedene Perspektiven zu berücksichtigen', '2025-06-05 09:28:51'),
(5, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kritisches Denken', 'Förderung von Reflexion und Problembewusstsein', '2025-06-05 09:28:51'),
(6, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Problemlösungsfähigkeiten', 'Identifizieren von Problemen und deren Ursachen', '2025-06-05 09:28:51'),
(7, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Problemlösungsfähigkeiten', 'Entwickeln von Lösungsstrategien', '2025-06-05 09:28:51'),
(8, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Problemlösungsfähigkeiten', 'Kreativität bei der Suche nach Lösungen', '2025-06-05 09:28:51'),
(9, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Problemlösungsfähigkeiten', 'Anwendung von mathematischen, logischen und kreativen Problemlösungsansätzen in unterschiedlichen Kontexten', '2025-06-05 09:28:51'),
(10, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kommunikationsfähigkeit', 'Mündliche Ausdrucksfähigkeit (Präsentieren, Diskutieren)', '2025-06-05 09:28:51'),
(11, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kommunikationsfähigkeit', 'Schriftliche Ausdrucksfähigkeit (Klarheit, Struktur)', '2025-06-05 09:28:51'),
(12, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kommunikationsfähigkeit', 'Zuhören und Empathie in Gesprächen', '2025-06-05 09:28:51'),
(13, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kommunikationsfähigkeit', 'Argumentationstechniken und -strategien', '2025-06-05 09:28:51'),
(14, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Kommunikationsfähigkeit', 'Teamarbeit und interkulturelle Kommunikation', '2025-06-05 09:28:51'),
(15, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Teamarbeit und Zusammenarbeit', 'Effiziente Zusammenarbeit in Gruppen', '2025-06-05 09:28:51'),
(16, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Teamarbeit und Zusammenarbeit', 'Konfliktlösung und Mediation innerhalb von Gruppen', '2025-06-05 09:28:51'),
(17, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Teamarbeit und Zusammenarbeit', 'Entwicklung von Kompromissen', '2025-06-05 09:28:51'),
(18, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Teamarbeit und Zusammenarbeit', 'Verantwortungsübernahme und eigenständige Aufgabenbewältigung in Gruppen', '2025-06-05 09:28:51'),
(19, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Selbstständigkeit', 'Eigenständiges Planen und Organisieren von Aufgaben', '2025-06-05 09:28:51'),
(20, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Selbstständigkeit', 'Selbstmotivation und Selbstkontrolle', '2025-06-05 09:28:51'),
(21, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Selbstständigkeit', 'Kritische Selbstreflexion und Verbesserung der eigenen Lernmethoden', '2025-06-05 09:28:51'),
(22, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Selbstständigkeit', 'Zeitmanagement und Priorisierung', '2025-06-05 09:28:51'),
(23, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Digitale Kompetenz', 'Umgang mit digitalen Werkzeugen und Software', '2025-06-05 09:28:51'),
(24, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Digitale Kompetenz', 'Sicheres Surfen im Internet und Umgang mit Daten', '2025-06-05 09:28:51'),
(25, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Digitale Kompetenz', 'Analyse und Bewertung von digitalen Inhalten', '2025-06-05 09:28:51'),
(26, 'Allgemeine Lernziele im Bildungssystem', 'Allgemein', 'Digitale Kompetenz', 'Erstellung von digitalen Projekten und Präsentationen', '2025-06-05 09:28:51'),
(27, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Lesen und Schreiben', 'Erkennen von Buchstaben und Wörtern', '2025-06-05 09:28:51'),
(28, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Lesen und Schreiben', 'Verständnis von Texten und Geschichten', '2025-06-05 09:28:51'),
(29, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Lesen und Schreiben', 'Ausdrückliches Schreiben und Verbalisieren von Gedanken', '2025-06-05 09:28:51'),
(30, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Lesen und Schreiben', 'Rechtschreibung und Grammatik', '2025-06-05 09:28:51'),
(31, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Lesen und Schreiben', 'Verbesserung des Leseverständnisses durch gezielte Übung', '2025-06-05 09:28:51'),
(32, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Zahlenverständnis', 'Grundlegende mathematische Operationen (Addition, Subtraktion, Multiplikation, Division)', '2025-06-05 09:28:51'),
(33, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Zahlenverständnis', 'Zahlenverständnis bis 100', '2025-06-05 09:28:51'),
(34, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Zahlenverständnis', 'Erkennen von Mustern und geometrischen Formen', '2025-06-05 09:28:51'),
(35, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Zahlenverständnis', 'Anwendung einfacher mathematischer Konzepte im Alltag', '2025-06-05 09:28:51'),
(36, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Soziale Fähigkeiten', 'Empathie entwickeln und sich in andere hineinversetzen können', '2025-06-05 09:28:51'),
(37, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Soziale Fähigkeiten', 'Grundlegende Konfliktlösungsstrategien anwenden', '2025-06-05 09:28:51'),
(38, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Soziale Fähigkeiten', 'Kooperation und Rücksichtnahme in Gruppenaktivitäten', '2025-06-05 09:28:51'),
(39, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Soziale Fähigkeiten', 'Umgang mit unterschiedlichen Meinungen und Bedürfnissen', '2025-06-05 09:28:51'),
(40, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Naturwissenschaftliche Grundkenntnisse', 'Neugierde und Interesse an der natürlichen Welt', '2025-06-05 09:28:51'),
(41, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Naturwissenschaftliche Grundkenntnisse', 'Grundverständnis von Naturphänomenen (z.B. Wetter, Pflanzen, Tiere)', '2025-06-05 09:28:51'),
(42, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Naturwissenschaftliche Grundkenntnisse', 'Durchführung einfacher Experimente', '2025-06-05 09:28:51'),
(43, 'Lernziele für bestimmte Bildungsstufen', 'Grundschule', 'Naturwissenschaftliche Grundkenntnisse', 'Beobachtungs- und Messfähigkeiten entwickeln', '2025-06-05 09:28:51'),
(44, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Fachliches Wissen (Mathematik, Deutsch, etc.)', 'Anwendung mathematischer Konzepte in realen Szenarien', '2025-06-05 09:30:13'),
(45, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Fachliches Wissen (Mathematik, Deutsch, etc.)', 'Vertieftes Leseverständnis von komplexeren Texten', '2025-06-05 09:30:13'),
(46, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Fachliches Wissen (Mathematik, Deutsch, etc.)', 'Analyse literarischer Werke und deren kulturelle Bedeutung', '2025-06-05 09:30:13'),
(47, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Fachliches Wissen (Mathematik, Deutsch, etc.)', 'Historisches und politisches Bewusstsein aufbauen', '2025-06-05 09:30:13'),
(48, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Kritisches Denken und Analyse', 'Entwicklung von Argumenten und deren fundierte Begründung', '2025-06-05 09:30:13'),
(49, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Kritisches Denken und Analyse', 'Eigenständige Recherche und Analyse von Informationen', '2025-06-05 09:30:13'),
(50, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Kritisches Denken und Analyse', 'Hinterfragen und Bewerten von Quellen und deren Glaubwürdigkeit', '2025-06-05 09:30:13'),
(51, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Kritisches Denken und Analyse', 'Identifizierung von möglichen Bias in Texten', '2025-06-05 09:30:13'),
(52, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Komplexere Problemlösungsstrategien', 'Anwendung von formalen mathematischen Methoden (z.B. algebraische Gleichungen)', '2025-06-05 09:30:13'),
(53, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Komplexere Problemlösungsstrategien', 'Analyse von historischen Ereignissen und deren Auswirkungen', '2025-06-05 09:30:13'),
(54, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Komplexere Problemlösungsstrategien', 'Anwendung von wissenschaftlichen Methoden zur Problemlösung', '2025-06-05 09:30:13'),
(55, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Selbstorganisation und Zeitmanagement', 'Eigenständiges Arbeiten und Organisieren von Projekten', '2025-06-05 09:30:13'),
(56, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Selbstorganisation und Zeitmanagement', 'Setzen von Zielen und deren zeitgerechte Umsetzung', '2025-06-05 09:30:13'),
(57, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe I', 'Selbstorganisation und Zeitmanagement', 'Nutzung von Zeitmanagement-Techniken wie To-Do-Listen oder Zeitblockierung', '2025-06-05 09:30:13'),
(58, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Fachspezifische Expertise', 'Vertiefte Kenntnisse in einem speziellen Studienfach', '2025-06-05 09:30:13'),
(59, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Fachspezifische Expertise', 'Anwendung theoretischer Konzepte auf Praxisbeispiele', '2025-06-05 09:30:13'),
(60, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Fachspezifische Expertise', 'Durchführung von Projekten und Forschungen im Fachgebiet', '2025-06-05 09:30:13'),
(61, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Fachspezifische Expertise', 'Fähigkeit zur interdisziplinären Zusammenarbeit', '2025-06-05 09:30:13'),
(62, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Forschungsmethoden', 'Kenntnisse in quantitativen und qualitativen Forschungsmethoden', '2025-06-05 09:30:13'),
(63, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Forschungsmethoden', 'Anwendung statistischer Methoden zur Datenauswertung', '2025-06-05 09:30:13'),
(64, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Forschungsmethoden', 'Entwicklung und Durchführung von Experimenten und Studien', '2025-06-05 09:30:13'),
(65, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Forschungsmethoden', 'Präsentation und Interpretation von Forschungsergebnissen', '2025-06-05 09:30:13'),
(66, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Kritische Reflexion', 'Hinterfragen der eigenen Forschungsergebnisse und -methoden', '2025-06-05 09:30:13'),
(67, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Kritische Reflexion', 'Kritische Auseinandersetzung mit bestehenden Theorien und Modellen', '2025-06-05 09:30:13'),
(68, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Kritische Reflexion', 'Reflexion über die Auswirkungen von Forschung auf Gesellschaft und Umwelt', '2025-06-05 09:30:13'),
(69, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Interdisziplinäre Zusammenarbeit', 'Kommunikation und Kooperation mit anderen Fachbereichen', '2025-06-05 09:30:13'),
(70, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Interdisziplinäre Zusammenarbeit', 'Integration von Wissen aus verschiedenen Disziplinen', '2025-06-05 09:30:13'),
(71, 'Lernziele für bestimmte Bildungsstufen', 'Hochschule', 'Interdisziplinäre Zusammenarbeit', 'Fähigkeit, interdisziplinäre Perspektiven zu verbinden und in Lösungen einzubeziehen', '2025-06-05 09:30:13'),
(72, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Fachliches Wissen und Spezialisierung', 'Vertiefung des Wissens in spezifischen Fächern (z.B. Mathematik, Physik, Literatur)', '2025-06-05 09:33:32'),
(73, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Fachliches Wissen und Spezialisierung', 'Anwendung fachspezifischer Methoden und Techniken', '2025-06-05 09:33:32'),
(74, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Fachliches Wissen und Spezialisierung', 'Komplexere mathematische und naturwissenschaftliche Modelle verstehen und anwenden', '2025-06-05 09:33:32'),
(75, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Fachliches Wissen und Spezialisierung', 'Vertieftes Textverständnis und Analyse komplexer literarischer Werke', '2025-06-05 09:33:32'),
(76, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Kritisches Denken und Problemlösen', 'Entwicklung von Lösungen für komplexe Probleme mit interdisziplinären Ansätzen', '2025-06-05 09:33:32'),
(77, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Kritisches Denken und Problemlösen', 'Kritische Reflexion und Bewertung von Quellen in wissenschaftlichen Kontexten', '2025-06-05 09:33:32'),
(78, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Kritisches Denken und Problemlösen', 'Bewertung von Argumenten und Theorien aus verschiedenen Perspektiven', '2025-06-05 09:33:32'),
(79, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Kritisches Denken und Problemlösen', 'Verwendung logischer und empirischer Daten zur Begründung von Entscheidungen', '2025-06-05 09:33:32'),
(80, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Wissenschaftliche Methoden und Forschungskompetenz', 'Anwendung wissenschaftlicher Forschungsmethoden (z.B. empirische Forschung, qualitative Analyse)', '2025-06-05 09:33:32'),
(81, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Wissenschaftliche Methoden und Forschungskompetenz', 'Durchführung von Experimenten, Studien und Umfragen zur Untersuchung von Hypothesen', '2025-06-05 09:33:32'),
(82, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Wissenschaftliche Methoden und Forschungskompetenz', 'Auswertung und Interpretation von Forschungsergebnissen', '2025-06-05 09:33:32'),
(83, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Wissenschaftliche Methoden und Forschungskompetenz', 'Erstellung von wissenschaftlichen Arbeiten, einschließlich der korrekten Zitierung und Quellenangabe', '2025-06-05 09:33:32'),
(84, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Teamarbeit und interdisziplinäre Zusammenarbeit', 'Kooperative Arbeit in komplexen Gruppenprojekten mit verschiedenen Disziplinen', '2025-06-05 09:33:32'),
(85, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Teamarbeit und interdisziplinäre Zusammenarbeit', 'Effektive Kommunikation und Konfliktlösung in Gruppen', '2025-06-05 09:33:32'),
(86, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Teamarbeit und interdisziplinäre Zusammenarbeit', 'Integration von verschiedenen Perspektiven in einer gemeinsamen Lösung', '2025-06-05 09:33:32'),
(87, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Selbstorganisation und eigenständiges Lernen', 'Eigenständige Planung und Durchführung von Lernprojekten', '2025-06-05 09:33:32'),
(88, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Selbstorganisation und eigenständiges Lernen', 'Zielgerichtetes Zeitmanagement zur Bewältigung von schulischen Anforderungen', '2025-06-05 09:33:32'),
(89, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Selbstorganisation und eigenständiges Lernen', 'Selbstmotivation und -disziplin in der Vor- und Nachbereitung von Prüfungen und Aufgaben', '2025-06-05 09:33:32'),
(90, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Präsentations- und Kommunikationstechniken', 'Sicheres Präsentieren von Forschungsergebnissen und Projekten vor einer größeren Gruppe', '2025-06-05 09:33:32'),
(91, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Präsentations- und Kommunikationstechniken', 'Verwendung von Präsentationstechniken (z.B. PowerPoint, Posterpräsentationen) zur Unterstützung von Argumenten', '2025-06-05 09:33:32'),
(92, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Präsentations- und Kommunikationstechniken', 'Wirkungsvolle Kommunikation von komplexen Themen in verständlicher Form', '2025-06-05 09:33:32'),
(93, 'Lernziele für bestimmte Bildungsstufen', 'Sekundarstufe II', 'Präsentations- und Kommunikationstechniken', 'Effektive Diskussion und Verteidigung von Argumenten in Debatten', '2025-06-05 09:33:32');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_ue_mtr_lerninhalt_lernformen`
--

CREATE TABLE `_ue_mtr_lerninhalt_lernformen` (
  `id` int(2) NOT NULL,
  `oberbegriff` varchar(50) DEFAULT NULL,
  `lernform` varchar(50) DEFAULT NULL,
  `beschreibung` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_ue_mtr_lerninhalt_lernformen`
--

INSERT INTO `_ue_mtr_lerninhalt_lernformen` (`id`, `oberbegriff`, `lernform`, `beschreibung`) VALUES
(1, 'Grundlegende Fähigkeiten', 'Rechnen', 'Erlernen grundlegender mathematischer Operationen (Addition, Subtraktion, Multiplikation, Division) und deren Anwendung.'),
(2, 'Grundlegende Fähigkeiten', 'Lesen', 'Erfassen von Buchstaben, Wörtern und Sätzen, um Texte zu verstehen.'),
(3, 'Grundlegende Fähigkeiten', 'Schreiben', 'Formulieren von Gedanken und Informationen in schriftlicher Form.'),
(4, 'Komplexere Fähigkeiten/Übungen', 'Auswendiglernen/Memorieren', 'Wiedergabe von Informationen aus dem Gedächtnis (z.B. Vokabeln, Formeln, Gedichte).'),
(5, 'Komplexere Fähigkeiten/Übungen', 'Übung/Drill', 'Wiederholtes Durchführen einer Aufgabe, um Fertigkeiten zu festigen (z.B. Tippen, Sport).'),
(6, 'Komplexere Fähigkeiten/Übungen', 'Problemlösen', 'Anwenden von Wissen und Strategien, um Lösungen für konkrete Probleme zu finden.'),
(7, 'Komplexere Fähigkeiten/Übungen', 'Kritisches Denken', 'Hinterfragen von Informationen, Erkennen von Annahmen und Schlussfolgerungen ziehen.'),
(8, 'Komplexere Fähigkeiten/Übungen', 'Kreatives Denken', 'Entwickeln neuer Ideen, Konzepte und Lösungen.'),
(9, 'Komplexere Fähigkeiten/Übungen', 'Sprachen lernen', 'Erlernen einer neuen Sprache mit Vokabeln, Grammatik und Aussprache.'),
(10, 'Verständnis und Anwendung', 'Zusammenhänge erkennen', 'Verknüpfen von Informationen, um ein tieferes Verständnis zu entwickeln.'),
(11, 'Verständnis und Anwendung', 'Analyse', 'Zerlegen komplexer Informationen in einzelne Teile, um sie besser zu verstehen.'),
(12, 'Verständnis und Anwendung', 'Synthese', 'Zusammenfügen verschiedener Informationen zu einem neuen Ganzen.'),
(13, 'Verständnis und Anwendung', 'Bewertung', 'Beurteilen der Qualität, Relevanz und Gültigkeit von Informationen.'),
(14, 'Verständnis und Anwendung', 'Transfer', 'Anwenden von Wissen und Fähigkeiten in neuen Situationen.'),
(15, 'Verständnis und Anwendung', 'Projektbasiertes Lernen', 'Eigenständiges Bearbeiten eines Projekts, um Wissen zu erwerben und anzuwenden.'),
(16, 'Verständnis und Anwendung', 'Forschendes Lernen', 'Eigenständiges Erforschen eines Themas durch Experimente und Beobachtungen.'),
(17, 'Soziale Lernformen', 'Lernen durch Lehren', 'Erlernen von Wissen, indem man es anderen erklärt.'),
(18, 'Soziale Lernformen', 'Gruppenarbeit', 'Gemeinsames Bearbeiten einer Aufgabe in einer Gruppe.'),
(19, 'Soziale Lernformen', 'Diskussion', 'Austausch von Meinungen und Perspektiven zu einem Thema.'),
(20, 'Soziale Lernformen', 'Kooperatives Lernen', 'Strukturierte Gruppenarbeit, bei der jedes Mitglied eine bestimmte Rolle hat.'),
(21, 'Weitere Lernformen', 'Blended Learning', 'Kombination aus Präsenzunterricht und Online-Lernen.'),
(22, 'Weitere Lernformen', 'E-Learning', 'Lernen mit digitalen Medien (z.B. Online-Kurse, Lern-Apps).'),
(23, 'Weitere Lernformen', 'Selbstgesteuertes Lernen', 'Eigenverantwortliches Planen und Durchführen des Lernprozesses.'),
(24, 'Weitere Lernformen', 'Erfahrungsbasiertes Lernen', 'Lernen durch praktische Erfahrungen (z.B. Praktika, Exkursionen).');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `_ue_mtr_lerninhalt_type`
--

CREATE TABLE `_ue_mtr_lerninhalt_type` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `_ue_mtr_lerninhalt_type`
--

INSERT INTO `_ue_mtr_lerninhalt_type` (`id`, `type`) VALUES
(1, 'Lehrplan'),
(2, 'Schülerserver'),
(3, 'Frei');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `beobachtung_protokoll`
--
ALTER TABLE `beobachtung_protokoll`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `didaktische_metric_zuordnung`
--
ALTER TABLE `didaktische_metric_zuordnung`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `gruppen`
--
ALTER TABLE `gruppen`
  ADD PRIMARY KEY (`GruppenID`);

--
-- Indizes für die Tabelle `klassentyp`
--
ALTER TABLE `klassentyp`
  ADD PRIMARY KEY (`KlassentypID`);

--
-- Indizes für die Tabelle `lehrer_unterricht`
--
ALTER TABLE `lehrer_unterricht`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `lehrkraft`
--
ALTER TABLE `lehrkraft`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indizes für die Tabelle `leistungsdaten_unterricht`
--
ALTER TABLE `leistungsdaten_unterricht`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_leistungsdaten_schueler` (`unterrichts_id`,`schueler_id`);

--
-- Indizes für die Tabelle `lernfeld`
--
ALTER TABLE `lernfeld`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `lernfeld_inhalt`
--
ALTER TABLE `lernfeld_inhalt`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lernfeld_id` (`lernfeld_id`);

--
-- Indizes für die Tabelle `lernfeld_inhalt_sachsen`
--
ALTER TABLE `lernfeld_inhalt_sachsen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lernfeld_id` (`lernfeld_id`);

--
-- Indizes für die Tabelle `lernfeld_sachsen`
--
ALTER TABLE `lernfeld_sachsen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `lernfortschritt_gruppen`
--
ALTER TABLE `lernfortschritt_gruppen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `lernfortschritt_gruppen_zuordnung`
--
ALTER TABLE `lernfortschritt_gruppen_zuordnung`
  ADD PRIMARY KEY (`lernfortschritt_gruppen_id`,`lernfortschritt_bezeichnungen_id`),
  ADD KEY `lernfortschritt_bezeichnungen_id` (`lernfortschritt_bezeichnungen_id`);

--
-- Indizes für die Tabelle `lernstand_unterricht`
--
ALTER TABLE `lernstand_unterricht`
  ADD KEY `unterrichts_id` (`unterrichts_id`),
  ADD KEY `schueler_id` (`schueler_id`);

--
-- Indizes für die Tabelle `mtr_didaktik`
--
ALTER TABLE `mtr_didaktik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_didaktik_themenauswahl` (`themenauswahl`),
  ADD KEY `fk_didaktik_materialien` (`materialien`),
  ADD KEY `fk_didaktik_methodenvielfalt` (`methodenvielfalt`),
  ADD KEY `fk_didaktik_individualisierung` (`individualisierung`),
  ADD KEY `fk_didaktik_aufforderung` (`aufforderung`),
  ADD KEY `fk_mtr_didaktik_materialien_id` (`materialien_id`);

--
-- Indizes für die Tabelle `mtr_didaktik_gruppe`
--
ALTER TABLE `mtr_didaktik_gruppe`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mtr_didaktik_gruppe_zuordnung`
--
ALTER TABLE `mtr_didaktik_gruppe_zuordnung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gruppe_id` (`gruppe_id`),
  ADD KEY `bezeichnung_id` (`bezeichnung_id`);

--
-- Indizes für die Tabelle `mtr_emotion`
--
ALTER TABLE `mtr_emotion`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mtr_feedback`
--
ALTER TABLE `mtr_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mtr_kompetenz`
--
ALTER TABLE `mtr_kompetenz`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mtr_leistung`
--
ALTER TABLE `mtr_leistung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lernfortschritt` (`lernfortschritt`),
  ADD KEY `fk_basiswissen` (`basiswissen`),
  ADD KEY `fk_transferdenken` (`transferdenken`),
  ADD KEY `fk_beherrscht_thema` (`beherrscht_thema`),
  ADD KEY `fk_vorbereitet` (`vorbereitet`);

--
-- Indizes für die Tabelle `mtr_medien`
--
ALTER TABLE `mtr_medien`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mtr_sozial`
--
ALTER TABLE `mtr_sozial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mtr_sozial_absprachen` (`absprachen`),
  ADD KEY `fk_mtr_sozial_fleiss` (`fleiss`),
  ADD KEY `fk_mtr_sozial_konzentration` (`konzentration`),
  ADD KEY `fk_mtr_sozial_mitarbeit` (`mitarbeit`),
  ADD KEY `fk_mtr_sozial_selbststaendigkeit` (`selbststaendigkeit`);

--
-- Indizes für die Tabelle `mtr_sozial_gruppe`
--
ALTER TABLE `mtr_sozial_gruppe`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mtr_sozial_gruppe_zuordnung`
--
ALTER TABLE `mtr_sozial_gruppe_zuordnung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gruppe_id` (`gruppe_id`),
  ADD KEY `bezeichnung_id` (`bezeichnung_id`);

--
-- Indizes für die Tabelle `mtr_thema`
--
ALTER TABLE `mtr_thema`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `rueckkopplung_metrik_lehrkraft`
--
ALTER TABLE `rueckkopplung_metrik_lehrkraft`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_unterrichts_id` (`unterrichts_id`),
  ADD KEY `idx_lehrkraft_id` (`lehrkraft_id`),
  ADD KEY `idx_themenauswahl_level_id` (`themenauswahl_level_id`),
  ADD KEY `idx_materialien_level_id` (`materialien_level_id`),
  ADD KEY `idx_methodenvielfalt_level_id` (`methodenvielfalt_level_id`),
  ADD KEY `idx_individualisierung_level_id` (`individualisierung_level_id`),
  ADD KEY `idx_aufforderung_level_id` (`aufforderung_level_id`);

--
-- Indizes für die Tabelle `rueckkopplung_metrik_teilnehmer`
--
ALTER TABLE `rueckkopplung_metrik_teilnehmer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_unterrichts_id` (`unterrichts_id`),
  ADD KEY `idx_schueler_id` (`schueler_id`),
  ADD KEY `idx_themenauswahl_level_id` (`themenauswahl_level_id`),
  ADD KEY `idx_materialien_level_id` (`materialien_level_id`),
  ADD KEY `idx_methodenvielfalt_level_id` (`methodenvielfalt_level_id`),
  ADD KEY `idx_individualisierung_level_id` (`individualisierung_level_id`),
  ADD KEY `idx_aufforderung_level_id` (`aufforderung_level_id`);

--
-- Indizes für die Tabelle `schueler_statusinfo`
--
ALTER TABLE `schueler_statusinfo`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `schüler`
--
ALTER TABLE `schüler`
  ADD PRIMARY KEY (`SchülerID`);

--
-- Indizes für die Tabelle `soziale_metric_zuordnung`
--
ALTER TABLE `soziale_metric_zuordnung`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `std_bewertung_textbausteine`
--
ALTER TABLE `std_bewertung_textbausteine`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `std_gruppen`
--
ALTER TABLE `std_gruppen`
  ADD PRIMARY KEY (`GruppenID`);

--
-- Indizes für die Tabelle `std_klassentyp`
--
ALTER TABLE `std_klassentyp`
  ADD PRIMARY KEY (`KlassentypID`);

--
-- Indizes für die Tabelle `std_lehrinhalte_ue`
--
ALTER TABLE `std_lehrinhalte_ue`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `std_lehrkraft`
--
ALTER TABLE `std_lehrkraft`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indizes für die Tabelle `std_schueler`
--
ALTER TABLE `std_schueler`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_std_schueler` (`Nachname`,`Vorname`,`Klassenstufe`);

--
-- Indizes für die Tabelle `std_schueler_list_unterricht`
--
ALTER TABLE `std_schueler_list_unterricht`
  ADD PRIMARY KEY (`SchülerID`),
  ADD KEY `GruppenID` (`GruppenID`),
  ADD KEY `KlassentypID` (`KlassentypID`);

--
-- Indizes für die Tabelle `teilnehmer_unterricht`
--
ALTER TABLE `teilnehmer_unterricht`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_teilnehmer_unterricht` (`unterrichts_id`,`schueler_id`);

--
-- Indizes für die Tabelle `tmp_schueler`
--
ALTER TABLE `tmp_schueler`
  ADD PRIMARY KEY (`SchuelerID`);

--
-- Indizes für die Tabelle `tmp_unterrichtseinheiten`
--
ALTER TABLE `tmp_unterrichtseinheiten`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ue_mtr_emotion_zuwertung`
--
ALTER TABLE `ue_mtr_emotion_zuwertung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emotion_metrik_id` (`emotion_metrik_id`),
  ADD KEY `dimension_id` (`dimension_id`);

--
-- Indizes für die Tabelle `ue_mtr_feedback_zuwertung`
--
ALTER TABLE `ue_mtr_feedback_zuwertung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feedback_metrik_id` (`feedback_metrik_id`),
  ADD KEY `typ_id` (`typ_id`);

--
-- Indizes für die Tabelle `ue_mtr_kompetenz_zuwertung`
--
ALTER TABLE `ue_mtr_kompetenz_zuwertung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kompetenz_metrik_id` (`kompetenz_metrik_id`),
  ADD KEY `kompetenzbereich_id` (`kompetenzbereich_id`),
  ADD KEY `kompetenzstufe_id` (`kompetenzstufe_id`);

--
-- Indizes für die Tabelle `ue_mtr_lernihalte_themen`
--
ALTER TABLE `ue_mtr_lernihalte_themen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_typ_id` (`typ_id`),
  ADD KEY `idx_lern_unterthema_id` (`lern_unterthema_id`),
  ADD KEY `idx_lernform_id` (`lernform_id`);

--
-- Indizes für die Tabelle `ue_mtr_medien_zuwertung`
--
ALTER TABLE `ue_mtr_medien_zuwertung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medien_metrik_id` (`medien_metrik_id`),
  ADD KEY `medienart_id` (`medienart_id`),
  ADD KEY `effekt_id` (`effekt_id`);

--
-- Indizes für die Tabelle `ue_mtr_thema_zuwertung`
--
ALTER TABLE `ue_mtr_thema_zuwertung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thema_metrik_id` (`thema_metrik_id`);

--
-- Indizes für die Tabelle `ue_schueler`
--
ALTER TABLE `ue_schueler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ue_schueler_ue` (`ue_id`),
  ADD KEY `fk_ue_schueler_didaktik` (`metrik_didaktik_id`),
  ADD KEY `fk_ue_schueler_leistung` (`metrik_leistung_id`),
  ADD KEY `fk_ue_schueler_sozial` (`metrik_sozial_id`),
  ADD KEY `fk_ue_schueler_emotion` (`metrik_emotion_id`),
  ADD KEY `fk_ue_schueler_thema` (`metrik_thema_id`);

--
-- Indizes für die Tabelle `ue_unterrichtseinheit`
--
ALTER TABLE `ue_unterrichtseinheit`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ue_unterrichtsmaterial`
--
ALTER TABLE `ue_unterrichtsmaterial`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ue_unterricht_lehrkraft`
--
ALTER TABLE `ue_unterricht_lehrkraft`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unterrichtseinheit_id` (`unterrichtseinheit_id`),
  ADD KEY `lehrkraft_id` (`lehrkraft_id`),
  ADD KEY `rolle_id` (`rolle_id`);

--
-- Indizes für die Tabelle `ue_zuweisung_ue_mtr_lerninhalt`
--
ALTER TABLE `ue_zuweisung_ue_mtr_lerninhalt`
  ADD KEY `fk_zuweisung_unterrichtseinheit` (`ue_id`),
  ADD KEY `fk_ue_zuweisung_lerninhalt_id` (`lerninhalt_id`);

--
-- Indizes für die Tabelle `unterrichtsinhalt`
--
ALTER TABLE `unterrichtsinhalt`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `unterrichtsstatus_code`
--
ALTER TABLE `unterrichtsstatus_code`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `var_gruppen`
--
ALTER TABLE `var_gruppen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_bewertung_textbausteine_unterkategorie`
--
ALTER TABLE `_bewertung_textbausteine_unterkategorie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `textbaustein_id` (`textbaustein_id`);

--
-- Indizes für die Tabelle `_mtr_didaktik_bezeichnung_level`
--
ALTER TABLE `_mtr_didaktik_bezeichnung_level`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_didaktik_materialien`
--
ALTER TABLE `_mtr_didaktik_materialien`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_didaktik_themenauswahl`
--
ALTER TABLE `_mtr_didaktik_themenauswahl`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_emotion_dimension`
--
ALTER TABLE `_mtr_emotion_dimension`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_feedback_typ`
--
ALTER TABLE `_mtr_feedback_typ`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_kompetenzbereich`
--
ALTER TABLE `_mtr_kompetenzbereich`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_kompetenzstufe`
--
ALTER TABLE `_mtr_kompetenzstufe`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_leistung_basiswissen`
--
ALTER TABLE `_mtr_leistung_basiswissen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_leistung_beherrscht_thema`
--
ALTER TABLE `_mtr_leistung_beherrscht_thema`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_leistung_lernfortschritt`
--
ALTER TABLE `_mtr_leistung_lernfortschritt`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_leistung_transferdenken`
--
ALTER TABLE `_mtr_leistung_transferdenken`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_leistung_vorbereitet`
--
ALTER TABLE `_mtr_leistung_vorbereitet`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_medienart`
--
ALTER TABLE `_mtr_medienart`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_medieneffekt`
--
ALTER TABLE `_mtr_medieneffekt`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_sozial_absprachen`
--
ALTER TABLE `_mtr_sozial_absprachen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_sozial_fleiss`
--
ALTER TABLE `_mtr_sozial_fleiss`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_sozial_konzentration`
--
ALTER TABLE `_mtr_sozial_konzentration`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_sozial_mitarbeit`
--
ALTER TABLE `_mtr_sozial_mitarbeit`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_mtr_sozial_selbststaendigkeit`
--
ALTER TABLE `_mtr_sozial_selbststaendigkeit`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_ue_lehrkraft_rolle`
--
ALTER TABLE `_ue_lehrkraft_rolle`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_ue_lernziele`
--
ALTER TABLE `_ue_lernziele`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_ue_mtr_lerninhalt_lernformen`
--
ALTER TABLE `_ue_mtr_lerninhalt_lernformen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `_ue_mtr_lerninhalt_type`
--
ALTER TABLE `_ue_mtr_lerninhalt_type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `beobachtung_protokoll`
--
ALTER TABLE `beobachtung_protokoll`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `didaktische_metric_zuordnung`
--
ALTER TABLE `didaktische_metric_zuordnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT für Tabelle `gruppen`
--
ALTER TABLE `gruppen`
  MODIFY `GruppenID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `klassentyp`
--
ALTER TABLE `klassentyp`
  MODIFY `KlassentypID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `lehrer_unterricht`
--
ALTER TABLE `lehrer_unterricht`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `lehrkraft`
--
ALTER TABLE `lehrkraft`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `leistungsdaten_unterricht`
--
ALTER TABLE `leistungsdaten_unterricht`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `lernfeld`
--
ALTER TABLE `lernfeld`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT für Tabelle `lernfeld_inhalt`
--
ALTER TABLE `lernfeld_inhalt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT für Tabelle `lernfeld_inhalt_sachsen`
--
ALTER TABLE `lernfeld_inhalt_sachsen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT für Tabelle `lernfeld_sachsen`
--
ALTER TABLE `lernfeld_sachsen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT für Tabelle `lernfortschritt_gruppen`
--
ALTER TABLE `lernfortschritt_gruppen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `mtr_didaktik`
--
ALTER TABLE `mtr_didaktik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_didaktik_gruppe`
--
ALTER TABLE `mtr_didaktik_gruppe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `mtr_didaktik_gruppe_zuordnung`
--
ALTER TABLE `mtr_didaktik_gruppe_zuordnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_emotion`
--
ALTER TABLE `mtr_emotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_feedback`
--
ALTER TABLE `mtr_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_kompetenz`
--
ALTER TABLE `mtr_kompetenz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_leistung`
--
ALTER TABLE `mtr_leistung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_medien`
--
ALTER TABLE `mtr_medien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_sozial`
--
ALTER TABLE `mtr_sozial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_sozial_gruppe`
--
ALTER TABLE `mtr_sozial_gruppe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `mtr_sozial_gruppe_zuordnung`
--
ALTER TABLE `mtr_sozial_gruppe_zuordnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mtr_thema`
--
ALTER TABLE `mtr_thema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `rueckkopplung_metrik_lehrkraft`
--
ALTER TABLE `rueckkopplung_metrik_lehrkraft`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `rueckkopplung_metrik_teilnehmer`
--
ALTER TABLE `rueckkopplung_metrik_teilnehmer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `schueler_statusinfo`
--
ALTER TABLE `schueler_statusinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `schüler`
--
ALTER TABLE `schüler`
  MODIFY `SchülerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `soziale_metric_zuordnung`
--
ALTER TABLE `soziale_metric_zuordnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT für Tabelle `std_bewertung_textbausteine`
--
ALTER TABLE `std_bewertung_textbausteine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `std_gruppen`
--
ALTER TABLE `std_gruppen`
  MODIFY `GruppenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT für Tabelle `std_klassentyp`
--
ALTER TABLE `std_klassentyp`
  MODIFY `KlassentypID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `std_lehrinhalte_ue`
--
ALTER TABLE `std_lehrinhalte_ue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `std_lehrkraft`
--
ALTER TABLE `std_lehrkraft`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `std_schueler`
--
ALTER TABLE `std_schueler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `std_schueler_list_unterricht`
--
ALTER TABLE `std_schueler_list_unterricht`
  MODIFY `SchülerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT für Tabelle `teilnehmer_unterricht`
--
ALTER TABLE `teilnehmer_unterricht`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_mtr_emotion_zuwertung`
--
ALTER TABLE `ue_mtr_emotion_zuwertung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_mtr_feedback_zuwertung`
--
ALTER TABLE `ue_mtr_feedback_zuwertung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_mtr_kompetenz_zuwertung`
--
ALTER TABLE `ue_mtr_kompetenz_zuwertung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_mtr_lernihalte_themen`
--
ALTER TABLE `ue_mtr_lernihalte_themen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_mtr_medien_zuwertung`
--
ALTER TABLE `ue_mtr_medien_zuwertung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_mtr_thema_zuwertung`
--
ALTER TABLE `ue_mtr_thema_zuwertung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_schueler`
--
ALTER TABLE `ue_schueler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_unterrichtseinheit`
--
ALTER TABLE `ue_unterrichtseinheit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ue_unterrichtsmaterial`
--
ALTER TABLE `ue_unterrichtsmaterial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `ue_unterricht_lehrkraft`
--
ALTER TABLE `ue_unterricht_lehrkraft`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `unterrichtsinhalt`
--
ALTER TABLE `unterrichtsinhalt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `unterrichtsstatus_code`
--
ALTER TABLE `unterrichtsstatus_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `var_gruppen`
--
ALTER TABLE `var_gruppen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_bewertung_textbausteine_unterkategorie`
--
ALTER TABLE `_bewertung_textbausteine_unterkategorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT für Tabelle `_mtr_didaktik_bezeichnung_level`
--
ALTER TABLE `_mtr_didaktik_bezeichnung_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_mtr_didaktik_materialien`
--
ALTER TABLE `_mtr_didaktik_materialien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_didaktik_themenauswahl`
--
ALTER TABLE `_mtr_didaktik_themenauswahl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_emotion_dimension`
--
ALTER TABLE `_mtr_emotion_dimension`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `_mtr_feedback_typ`
--
ALTER TABLE `_mtr_feedback_typ`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_kompetenzbereich`
--
ALTER TABLE `_mtr_kompetenzbereich`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_kompetenzstufe`
--
ALTER TABLE `_mtr_kompetenzstufe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_leistung_basiswissen`
--
ALTER TABLE `_mtr_leistung_basiswissen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `_mtr_leistung_beherrscht_thema`
--
ALTER TABLE `_mtr_leistung_beherrscht_thema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `_mtr_leistung_lernfortschritt`
--
ALTER TABLE `_mtr_leistung_lernfortschritt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT für Tabelle `_mtr_leistung_transferdenken`
--
ALTER TABLE `_mtr_leistung_transferdenken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `_mtr_leistung_vorbereitet`
--
ALTER TABLE `_mtr_leistung_vorbereitet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `_mtr_medienart`
--
ALTER TABLE `_mtr_medienart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_medieneffekt`
--
ALTER TABLE `_mtr_medieneffekt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `_mtr_sozial_absprachen`
--
ALTER TABLE `_mtr_sozial_absprachen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_mtr_sozial_fleiss`
--
ALTER TABLE `_mtr_sozial_fleiss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_mtr_sozial_konzentration`
--
ALTER TABLE `_mtr_sozial_konzentration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_mtr_sozial_mitarbeit`
--
ALTER TABLE `_mtr_sozial_mitarbeit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_mtr_sozial_selbststaendigkeit`
--
ALTER TABLE `_mtr_sozial_selbststaendigkeit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_ue_lehrkraft_rolle`
--
ALTER TABLE `_ue_lehrkraft_rolle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `_ue_lernziele`
--
ALTER TABLE `_ue_lernziele`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT für Tabelle `_ue_mtr_lerninhalt_lernformen`
--
ALTER TABLE `_ue_mtr_lerninhalt_lernformen`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT für Tabelle `_ue_mtr_lerninhalt_type`
--
ALTER TABLE `_ue_mtr_lerninhalt_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `lernfeld_inhalt`
--
ALTER TABLE `lernfeld_inhalt`
  ADD CONSTRAINT `lernfeld_inhalt_ibfk_1` FOREIGN KEY (`lernfeld_id`) REFERENCES `lernfeld` (`id`);

--
-- Constraints der Tabelle `lernfeld_inhalt_sachsen`
--
ALTER TABLE `lernfeld_inhalt_sachsen`
  ADD CONSTRAINT `lernfeld_inhalt_sachsen_ibfk_1` FOREIGN KEY (`lernfeld_id`) REFERENCES `lernfeld_sachsen` (`id`);

--
-- Constraints der Tabelle `lernfortschritt_gruppen_zuordnung`
--
ALTER TABLE `lernfortschritt_gruppen_zuordnung`
  ADD CONSTRAINT `lernfortschritt_gruppen_zuordnung_ibfk_1` FOREIGN KEY (`lernfortschritt_gruppen_id`) REFERENCES `lernfortschritt_gruppen` (`id`),
  ADD CONSTRAINT `lernfortschritt_gruppen_zuordnung_ibfk_2` FOREIGN KEY (`lernfortschritt_bezeichnungen_id`) REFERENCES `_mtr_leistung_lernfortschritt` (`id`);

--
-- Constraints der Tabelle `lernstand_unterricht`
--
ALTER TABLE `lernstand_unterricht`
  ADD CONSTRAINT `lernstand_unterricht_ibfk_1` FOREIGN KEY (`unterrichts_id`) REFERENCES `tmp_unterrichtseinheiten` (`id`),
  ADD CONSTRAINT `lernstand_unterricht_ibfk_2` FOREIGN KEY (`schueler_id`) REFERENCES `tmp_schueler` (`SchuelerID`);

--
-- Constraints der Tabelle `mtr_didaktik`
--
ALTER TABLE `mtr_didaktik`
  ADD CONSTRAINT `fk_didaktik_aufforderung` FOREIGN KEY (`aufforderung`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `fk_didaktik_individualisierung` FOREIGN KEY (`individualisierung`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `fk_didaktik_methodenvielfalt` FOREIGN KEY (`methodenvielfalt`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `fk_didaktik_themenauswahl` FOREIGN KEY (`themenauswahl`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `fk_mtr_didaktik_materialien_id` FOREIGN KEY (`materialien_id`) REFERENCES `_mtr_didaktik_materialien` (`id`);

--
-- Constraints der Tabelle `mtr_didaktik_gruppe_zuordnung`
--
ALTER TABLE `mtr_didaktik_gruppe_zuordnung`
  ADD CONSTRAINT `mtr_didaktik_gruppe_zuordnung_ibfk_1` FOREIGN KEY (`gruppe_id`) REFERENCES `mtr_didaktik_gruppe` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mtr_didaktik_gruppe_zuordnung_ibfk_2` FOREIGN KEY (`bezeichnung_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `mtr_leistung`
--
ALTER TABLE `mtr_leistung`
  ADD CONSTRAINT `fk_basiswissen` FOREIGN KEY (`basiswissen`) REFERENCES `_mtr_leistung_basiswissen` (`id`),
  ADD CONSTRAINT `fk_beherrscht_thema` FOREIGN KEY (`beherrscht_thema`) REFERENCES `_mtr_leistung_beherrscht_thema` (`id`),
  ADD CONSTRAINT `fk_lernfortschritt` FOREIGN KEY (`lernfortschritt`) REFERENCES `_mtr_leistung_lernfortschritt` (`id`),
  ADD CONSTRAINT `fk_transferdenken` FOREIGN KEY (`transferdenken`) REFERENCES `_mtr_leistung_transferdenken` (`id`),
  ADD CONSTRAINT `fk_vorbereitet` FOREIGN KEY (`vorbereitet`) REFERENCES `_mtr_leistung_vorbereitet` (`id`);

--
-- Constraints der Tabelle `mtr_sozial`
--
ALTER TABLE `mtr_sozial`
  ADD CONSTRAINT `fk_mtr_sozial_absprachen` FOREIGN KEY (`absprachen`) REFERENCES `_mtr_sozial_absprachen` (`id`),
  ADD CONSTRAINT `fk_mtr_sozial_fleiss` FOREIGN KEY (`fleiss`) REFERENCES `_mtr_sozial_fleiss` (`id`),
  ADD CONSTRAINT `fk_mtr_sozial_konzentration` FOREIGN KEY (`konzentration`) REFERENCES `_mtr_sozial_konzentration` (`id`),
  ADD CONSTRAINT `fk_mtr_sozial_mitarbeit` FOREIGN KEY (`mitarbeit`) REFERENCES `_mtr_sozial_mitarbeit` (`id`),
  ADD CONSTRAINT `fk_mtr_sozial_selbststaendigkeit` FOREIGN KEY (`selbststaendigkeit`) REFERENCES `_mtr_sozial_selbststaendigkeit` (`id`);

--
-- Constraints der Tabelle `mtr_sozial_gruppe_zuordnung`
--
ALTER TABLE `mtr_sozial_gruppe_zuordnung`
  ADD CONSTRAINT `mtr_sozial_gruppe_zuordnung_ibfk_1` FOREIGN KEY (`gruppe_id`) REFERENCES `mtr_sozial_gruppe` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mtr_sozial_gruppe_zuordnung_ibfk_2` FOREIGN KEY (`bezeichnung_id`) REFERENCES `_mtr_sozial_mitarbeit` (`id`);

--
-- Constraints der Tabelle `rueckkopplung_metrik_lehrkraft`
--
ALTER TABLE `rueckkopplung_metrik_lehrkraft`
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_1` FOREIGN KEY (`themenauswahl_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_2` FOREIGN KEY (`materialien_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_3` FOREIGN KEY (`methodenvielfalt_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_4` FOREIGN KEY (`individualisierung_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_5` FOREIGN KEY (`aufforderung_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`);

--
-- Constraints der Tabelle `rueckkopplung_metrik_teilnehmer`
--
ALTER TABLE `rueckkopplung_metrik_teilnehmer`
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_1` FOREIGN KEY (`themenauswahl_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_2` FOREIGN KEY (`materialien_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_3` FOREIGN KEY (`methodenvielfalt_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_4` FOREIGN KEY (`individualisierung_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_5` FOREIGN KEY (`aufforderung_level_id`) REFERENCES `_mtr_didaktik_bezeichnung_level` (`id`);

--
-- Constraints der Tabelle `std_schueler_list_unterricht`
--
ALTER TABLE `std_schueler_list_unterricht`
  ADD CONSTRAINT `std_schueler_list_unterricht_ibfk_1` FOREIGN KEY (`GruppenID`) REFERENCES `std_gruppen` (`GruppenID`),
  ADD CONSTRAINT `std_schueler_list_unterricht_ibfk_2` FOREIGN KEY (`KlassentypID`) REFERENCES `std_klassentyp` (`KlassentypID`);

--
-- Constraints der Tabelle `ue_mtr_emotion_zuwertung`
--
ALTER TABLE `ue_mtr_emotion_zuwertung`
  ADD CONSTRAINT `ue_mtr_emotion_zuwertung_ibfk_1` FOREIGN KEY (`emotion_metrik_id`) REFERENCES `mtr_emotion` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ue_mtr_emotion_zuwertung_ibfk_2` FOREIGN KEY (`dimension_id`) REFERENCES `_mtr_emotion_dimension` (`id`);

--
-- Constraints der Tabelle `ue_mtr_feedback_zuwertung`
--
ALTER TABLE `ue_mtr_feedback_zuwertung`
  ADD CONSTRAINT `ue_mtr_feedback_zuwertung_ibfk_1` FOREIGN KEY (`feedback_metrik_id`) REFERENCES `mtr_feedback` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ue_mtr_feedback_zuwertung_ibfk_2` FOREIGN KEY (`typ_id`) REFERENCES `_mtr_feedback_typ` (`id`);

--
-- Constraints der Tabelle `ue_mtr_kompetenz_zuwertung`
--
ALTER TABLE `ue_mtr_kompetenz_zuwertung`
  ADD CONSTRAINT `ue_mtr_kompetenz_zuwertung_ibfk_1` FOREIGN KEY (`kompetenz_metrik_id`) REFERENCES `mtr_kompetenz` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ue_mtr_kompetenz_zuwertung_ibfk_2` FOREIGN KEY (`kompetenzbereich_id`) REFERENCES `_mtr_kompetenzbereich` (`id`),
  ADD CONSTRAINT `ue_mtr_kompetenz_zuwertung_ibfk_3` FOREIGN KEY (`kompetenzstufe_id`) REFERENCES `_mtr_kompetenzstufe` (`id`);

--
-- Constraints der Tabelle `ue_mtr_medien_zuwertung`
--
ALTER TABLE `ue_mtr_medien_zuwertung`
  ADD CONSTRAINT `ue_mtr_medien_zuwertung_ibfk_1` FOREIGN KEY (`medien_metrik_id`) REFERENCES `mtr_medien` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ue_mtr_medien_zuwertung_ibfk_2` FOREIGN KEY (`medienart_id`) REFERENCES `_mtr_medienart` (`id`),
  ADD CONSTRAINT `ue_mtr_medien_zuwertung_ibfk_3` FOREIGN KEY (`effekt_id`) REFERENCES `_mtr_medieneffekt` (`id`);

--
-- Constraints der Tabelle `ue_mtr_thema_zuwertung`
--
ALTER TABLE `ue_mtr_thema_zuwertung`
  ADD CONSTRAINT `ue_mtr_thema_zuwertung_ibfk_1` FOREIGN KEY (`thema_metrik_id`) REFERENCES `mtr_thema` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `ue_schueler`
--
ALTER TABLE `ue_schueler`
  ADD CONSTRAINT `fk_ue_schueler_didaktik` FOREIGN KEY (`metrik_didaktik_id`) REFERENCES `mtr_didaktik` (`id`),
  ADD CONSTRAINT `fk_ue_schueler_emotion` FOREIGN KEY (`metrik_emotion_id`) REFERENCES `mtr_emotion` (`id`),
  ADD CONSTRAINT `fk_ue_schueler_leistung` FOREIGN KEY (`metrik_leistung_id`) REFERENCES `mtr_leistung` (`id`),
  ADD CONSTRAINT `fk_ue_schueler_sozial` FOREIGN KEY (`metrik_sozial_id`) REFERENCES `mtr_sozial` (`id`),
  ADD CONSTRAINT `fk_ue_schueler_thema` FOREIGN KEY (`metrik_thema_id`) REFERENCES `mtr_thema` (`id`),
  ADD CONSTRAINT `fk_ue_schueler_ue` FOREIGN KEY (`ue_id`) REFERENCES `ue_unterrichtseinheit` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `ue_unterricht_lehrkraft`
--
ALTER TABLE `ue_unterricht_lehrkraft`
  ADD CONSTRAINT `fk_unterricht_lehrkraft_rolle` FOREIGN KEY (`rolle_id`) REFERENCES `_ue_lehrkraft_rolle` (`id`),
  ADD CONSTRAINT `ue_unterricht_lehrkraft_ibfk_1` FOREIGN KEY (`unterrichtseinheit_id`) REFERENCES `ue_unterrichtseinheit` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ue_unterricht_lehrkraft_ibfk_2` FOREIGN KEY (`lehrkraft_id`) REFERENCES `std_lehrkraft` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ue_unterricht_lehrkraft_ibfk_3` FOREIGN KEY (`rolle_id`) REFERENCES `_ue_lehrkraft_rolle` (`id`);

--
-- Constraints der Tabelle `ue_zuweisung_ue_mtr_lerninhalt`
--
ALTER TABLE `ue_zuweisung_ue_mtr_lerninhalt`
  ADD CONSTRAINT `fk_lerninhalt_thema` FOREIGN KEY (`lerninhalt_id`) REFERENCES `ue_mtr_lernihalte_themen` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ue_zuweisung_lerninhalt_id` FOREIGN KEY (`lerninhalt_id`) REFERENCES `ue_mtr_lernihalte_themen` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_zuweisung_unterrichtseinheit` FOREIGN KEY (`ue_id`) REFERENCES `ue_unterrichtseinheit` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `_bewertung_textbausteine_unterkategorie`
--
ALTER TABLE `_bewertung_textbausteine_unterkategorie`
  ADD CONSTRAINT `_bewertung_textbausteine_unterkategorie_ibfk_1` FOREIGN KEY (`textbaustein_id`) REFERENCES `std_bewertung_textbausteine` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
