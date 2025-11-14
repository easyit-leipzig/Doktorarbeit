-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 02. Jun 2025 um 20:29
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
-- Tabellenstruktur für Tabelle `absprachen_bezeichnung`
--

CREATE TABLE `absprachen_bezeichnung` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `absprachen_bezeichnung`
--

INSERT INTO `absprachen_bezeichnung` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Absprachen', 'Isolation', 'Der Teilnehmer vermeidet jegliche Kommunikation und Absprachen mit anderen.', 'Level 1: Vollständige Isolation'),
(2, 'Seltene Absprachen', 'Gelegentliche Kommunikation', 'Der Teilnehmer kommuniziert nur, wenn es unbedingt notwendig ist und vermeidet den Austausch.', 'Level 2: Seltene Kommunikation'),
(3, 'Durchschnittliche Absprachen', 'Regelmäßige Kommunikation', 'Der Teilnehmer tauscht sich regelmäßig mit anderen aus, um Aufgaben zu koordinieren und Informationen zu teilen.', 'Level 3: Regelmäßige Kommunikation'),
(4, 'Häufige Absprachen', 'Aktive Koordination', 'Der Teilnehmer sucht aktiv den Austausch mit anderen, um Aufgaben optimal abzustimmen und Probleme gemeinsam zu lösen.', 'Level 4: Aktive Koordination'),
(5, 'Exzellente Absprachen', 'Strategische Koordination', 'Der Teilnehmer initiiert und fördert strategische Absprachen, um die Effizienz und Effektivität des Teams zu maximieren. Fördert eine offene und transparente Kommunikation.', 'Level 5: Strategische und transparente Koordination');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `basiswissen_bezeichnungen`
--

CREATE TABLE `basiswissen_bezeichnungen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `basiswissen_bezeichnungen`
--

INSERT INTO `basiswissen_bezeichnungen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Basiswissen', 'None', 'Der Lernende verfügt über kein relevantes Basiswissen, um das Thema zu verstehen.', 'Custom'),
(2, 'Fragmentarisches Basiswissen', 'Fragmentary', 'Der Lernende verfügt über lückenhaftes oder unvollständiges Basiswissen.', 'Custom'),
(3, 'Oberflächliches Basiswissen', 'Superficial', 'Der Lernende verfügt über ein oberflächliches Verständnis des Basiswissens, das für ein tieferes Verständnis nicht ausreicht.', 'Custom'),
(4, 'Ausreichendes Basiswissen', 'Sufficient', 'Der Lernende verfügt über ausreichend Basiswissen, um die grundlegenden Konzepte des Themas zu verstehen.', 'Custom'),
(5, 'Solides Basiswissen', 'Solid', 'Der Lernende verfügt über ein solides und gut fundiertes Basiswissen, das ein tieferes Verständnis und die Anwendung des Wissens ermöglicht.', 'Custom'),
(6, 'Umfassendes Basiswissen', 'Comprehensive', 'Der Lernende verfügt über ein umfassendes und detailliertes Basiswissen, das es ihm ermöglicht, komplexe Zusammenhänge zu verstehen und das Wissen in verschiedenen Kontexten anzuwenden.', 'Custom');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `beherrscht_thema_bezeichnungen`
--

CREATE TABLE `beherrscht_thema_bezeichnungen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `beherrscht_thema_bezeichnungen`
--

INSERT INTO `beherrscht_thema_bezeichnungen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Verständnis', 'None', 'Der Lernende hat kein Verständnis des Themas und kann grundlegende Fragen nicht beantworten.', 'Custom'),
(2, 'Grundlegendes Verständnis', 'Basic', 'Der Lernende hat ein grundlegendes Verständnis des Themas und kann einfache Konzepte erklären, hat aber Schwierigkeiten bei komplexeren Fragestellungen.', 'Custom'),
(3, 'Angemessenes Verständnis', 'Adequate', 'Der Lernende hat ein angemessenes Verständnis des Themas und kann die meisten Fragen beantworten und Probleme lösen, benötigt aber möglicherweise noch Unterstützung.', 'Custom'),
(4, 'Gutes Verständnis', 'Good', 'Der Lernende hat ein gutes Verständnis des Themas und kann komplexe Fragen beantworten und Probleme selbstständig lösen.', 'Custom'),
(5, 'Ausgezeichnete Beherrschung', 'Excellent', 'Der Lernende hat eine ausgezeichnete Beherrschung des Themas, kann es detailliert erklären, komplexe Probleme lösen und das Wissen auf neue Situationen anwenden.', 'Custom'),
(6, 'Experte', 'Expert', 'Der Lernende ist ein Experte auf dem Gebiet, kann das Thema umfassend erklären, neue Erkenntnisse gewinnen und andere in diesem Bereich unterrichten.', 'Custom');

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
-- Tabellenstruktur für Tabelle `didaktik_bezeichnung_level`
--

CREATE TABLE `didaktik_bezeichnung_level` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `wert` int(11) DEFAULT NULL,
  `erstellt_am` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `didaktik_bezeichnung_level`
--

INSERT INTO `didaktik_bezeichnung_level` (`id`, `bezeichnung`, `beschreibung`, `wert`, `erstellt_am`) VALUES
(1, 'Sehr gering', 'Kaum vorhanden', 1, '2025-06-01 12:14:57'),
(2, 'Gering', 'Verbesserungswürdig', 2, '2025-06-01 12:14:57'),
(3, 'Mittel', 'Durchschnittlich', 3, '2025-06-01 12:14:57'),
(4, 'Hoch', 'Gut', 4, '2025-06-01 12:14:57'),
(5, 'Sehr hoch', 'Exzellent', 5, '2025-06-01 12:14:57');

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
-- Tabellenstruktur für Tabelle `didaktische_metriken`
--

CREATE TABLE `didaktische_metriken` (
  `id` int(11) NOT NULL,
  `veranstaltungs_id` int(11) DEFAULT NULL,
  `datum` date NOT NULL,
  `themenauswahl` int(11) DEFAULT NULL,
  `materialien` int(11) DEFAULT NULL,
  `methodenvielfalt` int(11) DEFAULT NULL,
  `individualisierung` int(11) DEFAULT NULL,
  `aufforderung` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fleiss_bezeichnung`
--

CREATE TABLE `fleiss_bezeichnung` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `fleiss_bezeichnung`
--

INSERT INTO `fleiss_bezeichnung` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Fleiss', 'Antriebslosigkeit', 'Der Teilnehmer zeigt keinerlei Arbeitsbereitschaft oder Engagement. Aufgaben werden vermieden oder nur widerwillig erledigt.', 'Level 1: Vollständige Antriebslosigkeit'),
(2, 'Geringer Fleiss', 'Minimale Arbeitsbereitschaft', 'Der Teilnehmer zeigt wenig Eigeninitiative und erledigt Aufgaben nur, wenn es unbedingt notwendig ist.', 'Level 2: Minimale Arbeitsbereitschaft'),
(3, 'Durchschnittlicher Fleiss', 'Regelmäßige Arbeitsbereitschaft', 'Der Teilnehmer erledigt Aufgaben zuverlässig und zeigt eine durchschnittliche Arbeitsbereitschaft.', 'Level 3: Regelmäßige Arbeitsbereitschaft'),
(4, 'Hoher Fleiss', 'Engagierte Arbeitsweise', 'Der Teilnehmer ist hochmotiviert, übernimmt zusätzliche Aufgaben und arbeitet kontinuierlich an der Verbesserung seiner Leistung.', 'Level 4: Engagierte Arbeitsweise'),
(5, 'Exzellenter Fleiss', 'Ausdauernde Zielstrebigkeit', 'Der Teilnehmer zeigt außergewöhnliche Ausdauer und Zielstrebigkeit, übertrifft Erwartungen und setzt sich kontinuierlich für den Erfolg des Teams ein.', 'Level 5: Ausdauernde Zielstrebigkeit');

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
-- Tabellenstruktur für Tabelle `konzentration_bezeichnung`
--

CREATE TABLE `konzentration_bezeichnung` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `konzentration_bezeichnung`
--

INSERT INTO `konzentration_bezeichnung` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Konzentration', 'Ablenkung', 'Der Teilnehmer ist ständig abgelenkt, kann sich nicht auf Aufgaben konzentrieren und verliert schnell den Fokus.', 'Level 1: Ständige Ablenkung'),
(2, 'Geringe Konzentration', 'Häufige Ablenkung', 'Der Teilnehmer lässt sich leicht ablenken und benötigt häufige Pausen, um sich wieder zu sammeln.', 'Level 2: Häufige Ablenkung'),
(3, 'Durchschnittliche Konzentration', 'Gelegentliche Ablenkung', 'Der Teilnehmer kann sich für eine gewisse Zeit konzentrieren, wird aber gelegentlich durch äußere Einflüsse abgelenkt.', 'Level 3: Gelegentliche Ablenkung'),
(4, 'Hohe Konzentration', 'Fokussiertes Arbeiten', 'Der Teilnehmer kann sich gut konzentrieren und Aufgaben fokussiert bearbeiten, ohne sich leicht ablenken zu lassen.', 'Level 4: Fokussiertes Arbeiten'),
(5, 'Exzellente Konzentration', 'Tiefes Konzentrationsvermögen', 'Der Teilnehmer verfügt über ein außergewöhnliches Konzentrationsvermögen, kann tief in Aufgaben eintauchen und auch unter schwierigen Bedingungen hochproduktiv arbeiten.', 'Level 5: Tiefes Konzentrationsvermögen');

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
-- Tabellenstruktur für Tabelle `leistungsmetriken`
--

CREATE TABLE `leistungsmetriken` (
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
-- Tabellenstruktur für Tabelle `lernfortschritt_bezeichnungen`
--

CREATE TABLE `lernfortschritt_bezeichnungen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `lernfortschritt_bezeichnungen`
--

INSERT INTO `lernfortschritt_bezeichnungen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
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
-- Tabellenstruktur für Tabelle `mitarbeit_bezeichnung`
--

CREATE TABLE `mitarbeit_bezeichnung` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `mitarbeit_bezeichnung`
--

INSERT INTO `mitarbeit_bezeichnung` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Mitarbeit', 'Passivität', 'Der Teilnehmer zeigt keinerlei Engagement oder Beteiligung. Ignoriert Aufgaben und Anweisungen.', 'Level 1: Keine Beteiligung'),
(2, 'Minimale Mitarbeit', 'Gelegentliche Beteiligung', 'Der Teilnehmer beteiligt sich nur selten und auf Aufforderung. Zeigt wenig Eigeninitiative.', 'Level 2: Geringfügige Beteiligung'),
(3, 'Durchschnittliche Mitarbeit', 'Aktive Beteiligung', 'Der Teilnehmer beteiligt sich regelmäßig, bringt Ideen ein und arbeitet mit anderen zusammen.', 'Level 3: Aktive Beteiligung'),
(4, 'Hohe Mitarbeit', 'Engagierte Teilnahme', 'Der Teilnehmer ist hochmotiviert, übernimmt Verantwortung und treibt Projekte voran. Fördert die Zusammenarbeit im Team.', 'Level 4: Engagierte Teilnahme'),
(5, 'Exzellente Mitarbeit', 'Führungsrolle', 'Der Teilnehmer agiert als Vorbild, inspiriert andere und leitet Projekte. Löst Probleme selbstständig und trägt maßgeblich zum Erfolg bei.', 'Level 5: Führungsrolle/Vorbild');

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
-- Tabellenstruktur für Tabelle `selbststaendigkeit_bezeichnung`
--

CREATE TABLE `selbststaendigkeit_bezeichnung` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) DEFAULT NULL,
  `begriff` varchar(255) DEFAULT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `selbststaendigkeit_bezeichnung`
--

INSERT INTO `selbststaendigkeit_bezeichnung` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Keine Selbstständigkeit', 'Vollständige Abhängigkeit', 'Der Teilnehmer ist vollständig auf Anweisungen und Hilfe anderer angewiesen.', 'Level 1: Vollständige Abhängigkeit'),
(2, 'Geringe Selbstständigkeit', 'Gelegentliche Eigeninitiative', 'Der Teilnehmer zeigt gelegentlich Eigeninitiative, benötigt aber häufig Unterstützung.', 'Level 2: Gelegentliche Eigeninitiative'),
(3, 'Durchschnittliche Selbstständigkeit', 'Eigenständige Aufgabenlösung', 'Der Teilnehmer löst Aufgaben eigenständig, sucht aber bei komplexeren Problemen Hilfe.', 'Level 3: Eigenständige Aufgabenlösung'),
(4, 'Hohe Selbstständigkeit', 'Eigenverantwortliches Handeln', 'Der Teilnehmer übernimmt Verantwortung für seine Aufgaben und löst Probleme selbstständig.', 'Level 4: Eigenverantwortliches Handeln'),
(5, 'Exzellente Selbstständigkeit', 'Autonomes Handeln', 'Der Teilnehmer handelt autonom, initiiert eigene Projekte und trägt maßgeblich zum Erfolg bei.', 'Level 5: Autonomes Handeln');

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
-- Tabellenstruktur für Tabelle `soziale_metriken`
--

CREATE TABLE `soziale_metriken` (
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
-- Tabellenstruktur für Tabelle `transferdenken_bezeichnungen`
--

CREATE TABLE `transferdenken_bezeichnungen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `transferdenken_bezeichnungen`
--

INSERT INTO `transferdenken_bezeichnungen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Kein Transferdenken', 'None', 'Der Lernende kann das Wissen nicht auf andere Situationen anwenden.', 'Custom'),
(2, 'Minimales Transferdenken', 'Minimal', 'Der Lernende kann das Wissen nur auf sehr ähnliche Situationen anwenden.', 'Custom'),
(3, 'Geleitetes Transferdenken', 'Guided', 'Der Lernende kann das Wissen mit Anleitung auf neue Situationen anwenden.', 'Custom'),
(4, 'Selbstständiges Transferdenken', 'Independent', 'Der Lernende kann das Wissen selbstständig auf neue Situationen anwenden.', 'Custom'),
(5, 'Kreatives Transferdenken', 'Creative', 'Der Lernende kann das Wissen kreativ auf völlig neue und unvorhergesehene Situationen anwenden und innovative Lösungen entwickeln.', 'Custom'),
(6, 'Generalisiertes Transferdenken', 'Generalized', 'Der Lernende kann das Wissen auf ein breites Spektrum von Situationen anwenden und generelle Prinzipien ableiten.', 'Custom');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `unterrichtseinheit`
--

CREATE TABLE `unterrichtseinheit` (
  `id` int(11) NOT NULL,
  `datum` date NOT NULL,
  `zeit` varchar(5) NOT NULL,
  `gruppen_id` int(11) NOT NULL,
  `ort` varchar(255) DEFAULT NULL,
  `vertretung_fuer` varchar(255) DEFAULT NULL,
  `vertretung_durch` varchar(100) DEFAULT NULL COMMENT 'Name oder Kürzel der vertretenden Lehrkraft',
  `original_lehrkraft` varchar(100) DEFAULT NULL COMMENT 'Name oder Kürzel der ursprünglichen Lehrkraft'
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
-- Tabellenstruktur für Tabelle `vorbereitet_bezeichnungen`
--

CREATE TABLE `vorbereitet_bezeichnungen` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(255) NOT NULL,
  `begriff` varchar(255) NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `level_nach_author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `vorbereitet_bezeichnungen`
--

INSERT INTO `vorbereitet_bezeichnungen` (`id`, `bezeichnung`, `begriff`, `beschreibung`, `level_nach_author`) VALUES
(1, 'Nicht vorbereitet', 'Unprepared', 'Der Lernende hat keine der erforderlichen Vorbereitungen getroffen.', 'Custom'),
(2, 'Mangelhaft vorbereitet', 'Poorly Prepared', 'Der Lernende hat einige Vorbereitungen getroffen, aber diese sind unzureichend oder fehlerhaft.', 'Custom'),
(3, 'Teilweise vorbereitet', 'Partially Prepared', 'Der Lernende hat einen Teil der erforderlichen Vorbereitungen getroffen.', 'Custom'),
(4, 'Gut vorbereitet', 'Well Prepared', 'Der Lernende hat alle erforderlichen Vorbereitungen getroffen und ist bereit für die Lernsitzung oder Aufgabe.', 'Custom'),
(5, 'Sehr gut vorbereitet', 'Very Well Prepared', 'Der Lernende hat nicht nur alle erforderlichen Vorbereitungen getroffen, sondern sich auch zusätzlich mit dem Thema auseinandergesetzt.', 'Custom'),
(6, 'Ausgezeichnet vorbereitet', 'Excellently Prepared', 'Der Lernende hat sich außergewöhnlich gut vorbereitet, das Thema umfassend recherchiert und ist in der Lage, aktiv zum Lernprozess beizutragen.', 'Custom');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `absprachen_bezeichnung`
--
ALTER TABLE `absprachen_bezeichnung`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `basiswissen_bezeichnungen`
--
ALTER TABLE `basiswissen_bezeichnungen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `beherrscht_thema_bezeichnungen`
--
ALTER TABLE `beherrscht_thema_bezeichnungen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `beobachtung_protokoll`
--
ALTER TABLE `beobachtung_protokoll`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `didaktik_bezeichnung_level`
--
ALTER TABLE `didaktik_bezeichnung_level`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `didaktische_metric_zuordnung`
--
ALTER TABLE `didaktische_metric_zuordnung`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `didaktische_metriken`
--
ALTER TABLE `didaktische_metriken`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `fleiss_bezeichnung`
--
ALTER TABLE `fleiss_bezeichnung`
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
-- Indizes für die Tabelle `konzentration_bezeichnung`
--
ALTER TABLE `konzentration_bezeichnung`
  ADD PRIMARY KEY (`id`);

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
-- Indizes für die Tabelle `leistungsmetriken`
--
ALTER TABLE `leistungsmetriken`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_beherrscht_thema` (`beherrscht_thema`),
  ADD KEY `fk_transferdenken` (`transferdenken`),
  ADD KEY `fk_basiswissen` (`basiswissen`),
  ADD KEY `fk_vorbereitet` (`vorbereitet`),
  ADD KEY `fk_lernfortschritt` (`lernfortschritt`);

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
-- Indizes für die Tabelle `lernfortschritt_bezeichnungen`
--
ALTER TABLE `lernfortschritt_bezeichnungen`
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
-- Indizes für die Tabelle `mitarbeit_bezeichnung`
--
ALTER TABLE `mitarbeit_bezeichnung`
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
-- Indizes für die Tabelle `selbststaendigkeit_bezeichnung`
--
ALTER TABLE `selbststaendigkeit_bezeichnung`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `soziale_metric_zuordnung`
--
ALTER TABLE `soziale_metric_zuordnung`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `soziale_metriken`
--
ALTER TABLE `soziale_metriken`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mitarbeit_id` (`mitarbeit`),
  ADD KEY `fk_absprachen_id` (`absprachen`),
  ADD KEY `fk_selbststaendigkeit_id` (`selbststaendigkeit`),
  ADD KEY `fk_konzentration_id` (`konzentration`),
  ADD KEY `fk_fleiss_id` (`fleiss`);

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
-- Indizes für die Tabelle `transferdenken_bezeichnungen`
--
ALTER TABLE `transferdenken_bezeichnungen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `unterrichtseinheit`
--
ALTER TABLE `unterrichtseinheit`
  ADD KEY `idx_unterricht_gruppe` (`gruppen_id`);

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
-- Indizes für die Tabelle `vorbereitet_bezeichnungen`
--
ALTER TABLE `vorbereitet_bezeichnungen`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `absprachen_bezeichnung`
--
ALTER TABLE `absprachen_bezeichnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `basiswissen_bezeichnungen`
--
ALTER TABLE `basiswissen_bezeichnungen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `beherrscht_thema_bezeichnungen`
--
ALTER TABLE `beherrscht_thema_bezeichnungen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `beobachtung_protokoll`
--
ALTER TABLE `beobachtung_protokoll`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `didaktik_bezeichnung_level`
--
ALTER TABLE `didaktik_bezeichnung_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `didaktische_metric_zuordnung`
--
ALTER TABLE `didaktische_metric_zuordnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT für Tabelle `didaktische_metriken`
--
ALTER TABLE `didaktische_metriken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `fleiss_bezeichnung`
--
ALTER TABLE `fleiss_bezeichnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT für Tabelle `konzentration_bezeichnung`
--
ALTER TABLE `konzentration_bezeichnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT für Tabelle `leistungsmetriken`
--
ALTER TABLE `leistungsmetriken`
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
-- AUTO_INCREMENT für Tabelle `lernfortschritt_bezeichnungen`
--
ALTER TABLE `lernfortschritt_bezeichnungen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT für Tabelle `lernfortschritt_gruppen`
--
ALTER TABLE `lernfortschritt_gruppen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `mitarbeit_bezeichnung`
--
ALTER TABLE `mitarbeit_bezeichnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT für Tabelle `selbststaendigkeit_bezeichnung`
--
ALTER TABLE `selbststaendigkeit_bezeichnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `soziale_metric_zuordnung`
--
ALTER TABLE `soziale_metric_zuordnung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT für Tabelle `soziale_metriken`
--
ALTER TABLE `soziale_metriken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT für Tabelle `transferdenken_bezeichnungen`
--
ALTER TABLE `transferdenken_bezeichnungen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
-- AUTO_INCREMENT für Tabelle `vorbereitet_bezeichnungen`
--
ALTER TABLE `vorbereitet_bezeichnungen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `leistungsmetriken`
--
ALTER TABLE `leistungsmetriken`
  ADD CONSTRAINT `fk_basiswissen` FOREIGN KEY (`basiswissen`) REFERENCES `basiswissen_bezeichnungen` (`id`),
  ADD CONSTRAINT `fk_beherrscht_thema` FOREIGN KEY (`beherrscht_thema`) REFERENCES `beherrscht_thema_bezeichnungen` (`id`),
  ADD CONSTRAINT `fk_lernfortschritt` FOREIGN KEY (`lernfortschritt`) REFERENCES `lernfortschritt_bezeichnungen` (`id`),
  ADD CONSTRAINT `fk_transferdenken` FOREIGN KEY (`transferdenken`) REFERENCES `transferdenken_bezeichnungen` (`id`),
  ADD CONSTRAINT `fk_vorbereitet` FOREIGN KEY (`vorbereitet`) REFERENCES `vorbereitet_bezeichnungen` (`id`);

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
  ADD CONSTRAINT `lernfortschritt_gruppen_zuordnung_ibfk_2` FOREIGN KEY (`lernfortschritt_bezeichnungen_id`) REFERENCES `lernfortschritt_bezeichnungen` (`id`);

--
-- Constraints der Tabelle `lernstand_unterricht`
--
ALTER TABLE `lernstand_unterricht`
  ADD CONSTRAINT `lernstand_unterricht_ibfk_1` FOREIGN KEY (`unterrichts_id`) REFERENCES `tmp_unterrichtseinheiten` (`id`),
  ADD CONSTRAINT `lernstand_unterricht_ibfk_2` FOREIGN KEY (`schueler_id`) REFERENCES `tmp_schueler` (`SchuelerID`);

--
-- Constraints der Tabelle `rueckkopplung_metrik_lehrkraft`
--
ALTER TABLE `rueckkopplung_metrik_lehrkraft`
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_1` FOREIGN KEY (`themenauswahl_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_2` FOREIGN KEY (`materialien_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_3` FOREIGN KEY (`methodenvielfalt_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_4` FOREIGN KEY (`individualisierung_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_lehrkraft_ibfk_5` FOREIGN KEY (`aufforderung_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`);

--
-- Constraints der Tabelle `rueckkopplung_metrik_teilnehmer`
--
ALTER TABLE `rueckkopplung_metrik_teilnehmer`
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_1` FOREIGN KEY (`themenauswahl_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_2` FOREIGN KEY (`materialien_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_3` FOREIGN KEY (`methodenvielfalt_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_4` FOREIGN KEY (`individualisierung_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`),
  ADD CONSTRAINT `rueckkopplung_metrik_teilnehmer_ibfk_5` FOREIGN KEY (`aufforderung_level_id`) REFERENCES `didaktik_bezeichnung_level` (`id`);

--
-- Constraints der Tabelle `soziale_metriken`
--
ALTER TABLE `soziale_metriken`
  ADD CONSTRAINT `fk_absprachen_id` FOREIGN KEY (`absprachen`) REFERENCES `absprachen_bezeichnung` (`id`),
  ADD CONSTRAINT `fk_fleiss_id` FOREIGN KEY (`fleiss`) REFERENCES `fleiss_bezeichnung` (`id`),
  ADD CONSTRAINT `fk_konzentration_id` FOREIGN KEY (`konzentration`) REFERENCES `konzentration_bezeichnung` (`id`),
  ADD CONSTRAINT `fk_mitarbeit_id` FOREIGN KEY (`mitarbeit`) REFERENCES `mitarbeit_bezeichnung` (`id`),
  ADD CONSTRAINT `fk_selbststaendigkeit_id` FOREIGN KEY (`selbststaendigkeit`) REFERENCES `selbststaendigkeit_bezeichnung` (`id`);

--
-- Constraints der Tabelle `std_schueler_list_unterricht`
--
ALTER TABLE `std_schueler_list_unterricht`
  ADD CONSTRAINT `std_schueler_list_unterricht_ibfk_1` FOREIGN KEY (`GruppenID`) REFERENCES `std_gruppen` (`GruppenID`),
  ADD CONSTRAINT `std_schueler_list_unterricht_ibfk_2` FOREIGN KEY (`KlassentypID`) REFERENCES `std_klassentyp` (`KlassentypID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
