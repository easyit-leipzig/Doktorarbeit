-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 27. Jul 2026 um 02:49
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
(1, 1, 'Historische Bestimmung des Verhältnisses von Sein, Denken und Nichtsein.', 'Begründet die erkenntnistheoretische Unzugänglichkeit eines absolut voraussetzungslosen Nichts.', 'Beleg der frühen philosophischen Problematisierung des Nichtseins.', 'Übernommen wird ausschließlich der Hinweis, dass die sprachliche oder gedankliche Bestimmung des Nichts bereits eine Unterscheidung voraussetzt.', 'Die ontologische Gesamtposition des Parmenides wird nicht vollständig übernommen.', 'Die Quelle wird als historischer Ausgangspunkt, nicht als unmittelbare formale Grundlage des FRZK verwendet.', 'reviewed', '2026-07-26 08:35:12'),
(2, 2, 'Systematische Darstellung des quantenfeldtheoretischen Zustands- und Vakuumbegriffes.', 'Ermöglicht die Abgrenzung des physikalischen Vakuums vom absoluten Nichts.', 'Beleg dafür, dass das Vakuum ein Zustand innerhalb einer bereits definierten Theorie ist.', 'Übernommen wird die Einordnung des Vakuums als mathematisch strukturierter Grundzustand.', 'Die Quelle behandelt keine metaphysische Theorie des Nichts.', 'Die Verwendung bleibt auf die begriffliche Abgrenzung zwischen Vakuum und absolutem Nichts beschränkt.', 'reviewed', '2026-07-26 08:35:12'),
(3, 3, 'Elementare Darstellung der Mengenlehre und der leeren Menge.', 'Begründet die Unterscheidung zwischen einer leeren mathematischen Struktur und der Abwesenheit jeder Struktur.', 'Beleg dafür, dass die leere Menge ein definiertes mathematisches Objekt ist.', 'Übernommen wird die Stellung der leeren Menge innerhalb eines bereits vorausgesetzten Axiomen- und Relationssystems.', 'Die naive Mengenlehre ersetzt keine vollständige axiomatische Fundierung.', 'Die Quelle wird zur begrifflichen Abgrenzung verwendet, nicht als vollständige mengentheoretische Grundlage des FRZK.', 'reviewed', '2026-07-26 08:35:12');

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
(1, 'Parmenides', NULL, 'Parmenides', NULL, -515, -450, 'Antiker Autor der Fragmente in Quelle [4].'),
(2, 'Diels', 'Hermann', 'Diels, Hermann', NULL, 1848, 1922, 'Herausgeber der Fragmente der Vorsokratiker, Quelle [4].'),
(3, 'Kranz', 'Walther', 'Kranz, Walther', NULL, 1884, 1960, 'Bearbeiter und Herausgeber der Fragmente der Vorsokratiker, Quelle [4].'),
(4, 'Weinberg', 'Steven', 'Weinberg, Steven', NULL, 1933, 2021, 'Autor von Quelle [36].'),
(5, 'Halmos', 'Paul R.', 'Halmos, Paul R.', NULL, 1916, 2006, 'Autor der Quelle [6].'),
(6, 'Kant', 'Immanuel', 'Kant, Immanuel', NULL, 1724, 1804, 'Für Abschnitt 3.1.2 registriert.'),
(7, 'Timmermann', 'Jens', 'Timmermann, Jens', NULL, NULL, NULL, 'Herausgeber der verwendeten Kant-Ausgabe.'),
(8, 'Hegel', 'Georg Wilhelm Friedrich', 'Hegel, Georg Wilhelm Friedrich', NULL, 1770, 1831, 'Für Abschnitt 3.1.2 registriert.'),
(9, 'Russell', 'Bertrand', 'Russell, Bertrand', NULL, 1872, 1970, 'Für Abschnitt 3.1.2 registriert.'),
(10, 'Whitehead', 'Alfred North', 'Whitehead, Alfred North', NULL, 1861, 1947, 'Autor von Quelle [63].'),
(11, 'Griffin', 'David Ray', 'Griffin, David Ray', NULL, 1939, NULL, 'Herausgeber der korrigierten Ausgabe von Process and Reality.'),
(12, 'Sherburne', 'Donald W.', 'Sherburne, Donald W.', NULL, 1929, 2016, 'Herausgeber der korrigierten Ausgabe von Process and Reality.'),
(13, 'Bitbol', 'Michel', 'Bitbol, Michel', NULL, NULL, NULL, 'Autor der in Abschnitt 3.1.2 verwendeten erkenntnistheoretischen Quelle.'),
(14, 'Newton', 'Isaac', 'Newton, Isaac', NULL, 1643, 1727, 'Autor von Quelle [26].'),
(15, 'Mach', 'Ernst', 'Mach, Ernst', NULL, 1838, 1916, 'Autor von Quelle [27].'),
(16, 'Einstein', 'Albert', 'Einstein, Albert', NULL, 1879, 1955, 'Autor der Quellen [28] und [30].'),
(17, 'Minkowski', 'Hermann', 'Minkowski, Hermann', NULL, 1864, 1909, 'Autor von Quelle [29].'),
(18, 'Weyl', 'Hermann', 'Weyl, Hermann', NULL, 1885, 1955, 'Autor von Quelle [31].'),
(19, 'Wald', 'Robert M.', 'Wald, Robert M.', NULL, 1947, NULL, 'Autor von Quelle [32].'),
(20, 'Hawking', 'Stephen W.', 'Hawking, Stephen W.', NULL, 1942, 2018, 'Erstautor von Quelle [33].'),
(21, 'Ellis', 'George F. R.', 'Ellis, George F. R.', NULL, 1939, NULL, 'Zweitautor von Quelle [33].'),
(22, 'von Neumann', 'John', 'von Neumann, John', NULL, 1903, 1957, 'Autor von Quelle [34].'),
(23, 'Dirac', 'Paul A. M.', 'Dirac, Paul A. M.', NULL, 1902, 1984, 'Autor von Quelle [35].'),
(24, 'DeWitt', 'Bryce S.', 'DeWitt, Bryce S.', NULL, 1923, 2004, 'Autor von Quelle [37].'),
(25, 'Rovelli', 'Carlo', 'Rovelli, Carlo', NULL, 1956, NULL, 'Autor von Quelle [38].'),
(26, 'Kiefer', 'Claus', 'Kiefer, Claus', NULL, 1958, NULL, 'Autor von Quelle [39].'),
(29, 'Helmholtz', 'Hermann von', 'Helmholtz, Hermann von', NULL, 1821, 1894, 'Autor von Quelle [45].'),
(30, 'Hanson', 'Norwood Russell', 'Hanson, Norwood Russell', NULL, 1924, 1967, 'Autor von Quelle [46].'),
(31, 'Kuhn', 'Thomas S.', 'Kuhn, Thomas S.', NULL, 1922, 1996, 'Autor von Quelle [47].'),
(32, 'Popper', 'Karl R.', 'Popper, Karl R.', NULL, 1902, 1994, 'Autor von Quelle [48].'),
(33, 'Lakatos', 'Imre', 'Lakatos, Imre', NULL, 1922, 1974, 'Autor von Quelle [49].'),
(34, 'Quine', 'Willard Van Orman', 'Quine, Willard Van Orman', NULL, 1908, 2000, 'Autor von Quelle [50].'),
(35, 'Duhem', 'Pierre', 'Duhem, Pierre', NULL, 1861, 1916, 'Autor von Quelle [51].'),
(36, 'van Fraassen', 'Bas C.', 'van Fraassen, Bas C.', NULL, 1941, NULL, 'Autor von Quelle [52].'),
(37, 'Worrall', 'John', 'Worrall, John', NULL, 1946, NULL, 'Autor von Quelle [53].'),
(38, 'Ladyman', 'James', 'Ladyman, James', NULL, NULL, NULL, 'Autor der Quellen [54] und [55].'),
(39, 'French', 'Steven', 'French, Steven', NULL, NULL, NULL, 'Erstautor von Quelle [55].'),
(40, 'Hesse', 'Mary B.', 'Hesse, Mary B.', NULL, 1924, 2016, 'Autorin von Quelle [56].'),
(41, 'Giere', 'Ronald N.', 'Giere, Ronald N.', NULL, 1938, 2020, 'Autor von Quelle [57].'),
(42, 'Suppes', 'Patrick', 'Suppes, Patrick', NULL, 1922, 2014, 'Autor von Quelle [58].'),
(43, 'Tarski', 'Alfred', 'Tarski, Alfred', NULL, 1901, 1983, 'Autor von Quelle [59].'),
(44, 'Mac Lane', 'Saunders', 'Mac Lane, Saunders', NULL, 1909, 2005, 'Autor von Quelle [60] und Mitautor von Quelle [61].'),
(45, 'Eilenberg', 'Samuel', 'Eilenberg, Samuel', NULL, 1913, 1998, 'Erstautor von Quelle [61].'),
(46, 'Frege', 'Gottlob', 'Frege, Gottlob', NULL, 1848, 1925, 'Autor von Quelle [62].'),
(47, 'von Bertalanffy', 'Ludwig', 'von Bertalanffy, Ludwig', NULL, 1901, 1972, 'Autor von Quelle [64].'),
(48, 'Wiener', 'Norbert', 'Wiener, Norbert', NULL, 1894, 1964, 'Autor von Quelle [65].'),
(49, 'Ashby', 'W. Ross', 'Ashby, W. Ross', NULL, 1903, 1972, 'Autor von Quelle [66].'),
(50, 'Resnik', 'Michael D.', 'Resnik, Michael D.', NULL, 1938, NULL, 'Autor von Quelle [67].'),
(51, 'Shapiro', 'Stewart', 'Shapiro, Stewart', NULL, 1951, NULL, 'Autor von Quelle [68].'),
(52, 'von Foerster', 'Heinz', 'von Foerster, Heinz', NULL, 1911, 2002, 'Autor von Quelle [69].'),
(53, 'Luhmann', 'Niklas', 'Luhmann, Niklas', NULL, 1927, 1998, 'Autor von Quelle [70].');

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
(1, NULL, '3', 'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen', 3, 3.0000, 'draft', 1, 'Übergeordnetes Wurzelkapitel für den Neuaufbau von Kapitel 3.', '2026-07-26 06:17:28', '2026-07-26 06:17:28'),
(2, 1, '3.1', 'Grundlagen der funktionalen Beschreibung von Raum und Zeit', 3, 3.1000, 'final', 1, 'Kapitel 3.1 wird nach dem Weiter-Skript-Prinzip unterabschnittsweise aufgebaut.\nKapitel 3.1 mit Abschnitt 3.1.7 vollständig abgeschlossen.', '2026-07-26 06:17:28', '2026-07-26 17:31:39'),
(3, 2, '3.1.0', 'Einleitung', 3, 3.1000, 'final', 0, 'Einleitung zu Kapitel 3.1; Literaturverweise [1] bis [3]; keine nummerierten Gleichungen.', '2026-07-26 06:17:28', '2026-07-26 06:17:28'),
(4, 2, '3.1.1', 'Das Nichts als mathematischer Ausgangspunkt', 3, 3.1100, 'final', 1, 'Der Abschnitt grenzt das absolute Nichts von mathematisch und physikalisch strukturierten Formen der Leere ab und leitet funktionale Unterscheidbarkeit als minimale Voraussetzung mathematischer Beschreibung her. Literatur [4] bis [6]; keine nummerierte Gleichung.', '2026-07-26 06:35:12', '2026-07-26 06:35:12'),
(6, 2, '3.1.2', 'Philosophische Grundlagen', 3, 3.1200, 'final', 1, 'Abschnitt 3.1.2 vollständig abgeschlossen. Philosophische Grundlagen von Parmenides bis Bitbol; Literatur [4] sowie [7] bis [25]; keine nummerierten Gleichungen. Ergebnis: vier Arbeitsprinzipien für das FRZK und Überleitung zu 3.1.3.', '2026-07-26 06:54:27', '2026-07-26 08:58:07'),
(7, 2, '3.1.3', 'Physikalische Grundlagen', 3, 3.1300, 'draft', 1, 'Teil 1 und Teil 2 eingearbeitet. Literaturstand [26] bis [39]; keine nummerierten Gleichungen.', '2026-07-26 11:16:49', '2026-07-26 11:54:25'),
(8, 2, '3.1.4', 'Erkenntnistheoretische Grundlagen', 3, 3.1400, 'final', 1, 'Abgeschlossen. Wiederverwendung [15], [19], [23]; neue Quellen [45]–[59]; keine nummerierten Gleichungen.', '2026-07-26 15:54:31', '2026-07-26 15:54:31'),
(9, 2, '3.1.5', 'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem', 3, 3.1500, 'final', 1, 'Abschnitt vollständig abgeschlossen. Methodologische Grundsätze M1 bis M10; neue Quellen [60] und [61]; keine nummerierten Gleichungen.', '2026-07-26 17:20:10', '2026-07-26 17:20:10'),
(10, 2, '3.1.6', 'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft', 3, 3.1600, 'final', 1, 'Abschnitt vollständig abgeschlossen. Wiederverwendung der Quellen [18], [60] und [61]; neue Quellen [62] bis [70]; keine nummerierten Gleichungen.', '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(11, 2, '3.1.7', 'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung', 3, 3.1700, 'final', 1, 'Abschlussabschnitt der allgemeinen Grundlegung in Kapitel 3.1. Keine neuen Literaturstellen; keine nummerierten Gleichungen.', '2026-07-26 17:31:39', '2026-07-26 17:31:39');

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
('current_section', '3.2', '2026-07-26 17:31:40'),
('last_citation_number', '70', '2026-07-26 17:26:06'),
('last_completed_chapter', '3.1', '2026-07-26 17:31:40'),
('last_completed_section', '3.1.7', '2026-07-26 17:31:40'),
('next_citation_number', '71', '2026-07-26 17:26:06');

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
(1, 'K3_1_0_REBUILD_V1', '2026-07-26 08:17:28', 'section', '3.1.0', '3.1.0-v1', 'Repositorygerechte Anlage und Dokumentation des Abschnitts 3.1.0 einschließlich der Literaturverwendungen [1] bis [3].', 'Olaf Thiele / ChatGPT', NULL),
(2, 'RKB-NEU-K3.1.1-V1', '2026-07-26 08:35:12', 'section', '3.1.1', '1.0', 'Aufnahme des Abschnitts 3.1.1 „Das Nichts als mathematischer Ausgangspunkt“ einschließlich der erstmals verwendeten Quellen [4] bis [6]. Der Abschnitt enthält keine nummerierte Gleichung.', 'Olaf Thiele / ChatGPT', 1),
(3, 'RKB-NEU-K3.1.2-T1-V1', '2026-07-26 08:54:27', 'section', '3.1.2', '3.1.2-T1-v1', 'Aufnahme des ersten Teils von Abschnitt 3.1.2 mit den philosophischen Positionen von Platon bis Leibniz und den Literaturquellen [7] bis [12].', 'Olaf Thiele / ChatGPT', 2),
(4, 'RKB-NEU-K3.1.2-T2-V1', '2026-07-26 09:24:44', 'section', '3.1.2', '3.1.2-T2-v1', 'Fortsetzung von Abschnitt 3.1.2 mit Kant, Hegel, Russell und Whitehead sowie den Literaturquellen [13] bis [16].', 'Olaf Thiele / ChatGPT', 3),
(5, 'RKB-NEU-K3.1.2-T3-V1', '2026-07-26 09:56:18', 'section', '3.1.2', '3.1.2-T3-v1', 'Fortsetzung Abschnitt 3.1.2 mit Husserl bis Floridi.', 'Olaf Thiele / ChatGPT', 4),
(6, 'RKB-NEU-K3.1.2-T4-V1', '2026-07-26 10:58:07', 'section', '3.1.2', '3.1.2-T4-v1', 'Abschluss von Abschnitt 3.1.2 mit Michel Bitbol, Gesamtsynthese, vier philosophischen Arbeitsprinzipien und Überleitung zu Abschnitt 3.1.3.', 'Olaf Thiele / ChatGPT', 5),
(7, 'RKB-NEU-K3.1.3-T1-V1', '2026-07-26 13:16:49', 'section', '3.1.3', '3.1.3-T1-v1', 'Beginn von Abschnitt 3.1.3: Newton, Mach, Spezielle und Allgemeine Relativitätstheorie sowie kosmologische Modellgrenzen.', 'Olaf Thiele / ChatGPT', 6),
(8, 'RKB-NEU-K3.1.3-T2-V1', '2026-07-26 13:54:24', 'section', '3.1.3', '3.1.3-T2-v1', 'Fortsetzung von Abschnitt 3.1.3: Quantenmechanik, Quantenfeldtheorie und Quantengravitation.', 'Olaf Thiele / ChatGPT', 7),
(9, 'RKB-NEU-K3.1.4-ABSCHLUSS-V2', '2026-07-26 17:54:31', 'section', '3.1.4', '3.1.4-Abschluss-v2', 'Vollständiger Abschluss von 3.1.4 Erkenntnistheoretische Grundlagen; Quellen [15], [19], [23] und [45]–[59]; keine Gleichungen.', 'Olaf Thiele / ChatGPT', 8),
(10, 'RKB-NEU-K3.1.5-ABSCHLUSS-V1', '2026-07-26 19:20:10', 'section', '3.1.5', '3.1.5-Abschluss-v1', 'Vollständiger Abschluss des Abschnitts 3.1.5 „Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem“ mit den methodologischen Grundsätzen M1 bis M10 und den Quellen [60] bis [61]. Keine nummerierten Gleichungen.', 'Olaf Thiele / ChatGPT', 9),
(11, 'RKB-NEU-K3.1.6-ABSCHLUSS-V1', '2026-07-26 19:26:06', 'section', '3.1.6', '3.1.6-Abschluss-v1', 'Vollständiger Abschluss des Abschnitts 3.1.6 „Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft“ mit Wiederverwendung der Quellen [18], [60] und [61] sowie Aufnahme der Quellen [62] bis [70]. Keine nummerierten Gleichungen.', 'Olaf Thiele / ChatGPT', 10),
(12, 'RKB-NEU-K3.1.7-ABSCHLUSS-V1', '2026-07-26 19:31:39', 'section', '3.1.7', '3.1.7-Abschluss-v1', 'Vollständiger Abschluss des Abschnitts 3.1.7 „Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung“. Zugleich Abschluss des Kapitels 3.1. Keine neuen Literaturstellen und keine nummerierten Gleichungen.', 'Olaf Thiele / ChatGPT', 11);

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
(1, 1, 'K3_1_0_SECTION_EXISTS', 'passed', '1', '1', 'Prüft, ob Abschnitt 3.1.0 vorhanden ist.', '2026-07-26 06:17:29'),
(2, 1, 'K3_1_0_SOURCE_USAGE', 'warning', '3', '0', 'Prüft die Verknüpfung der Literaturquellen [1] bis [3]. Ein Warnstatus bedeutet, dass die Quellen zuvor noch in sources angelegt werden müssen.', '2026-07-26 06:17:29'),
(3, 1, 'K3_1_0_NO_EQUATIONS', 'passed', '0', '0', 'Abschnitt 3.1.0 enthält keine nummerierten Gleichungen.', '2026-07-26 06:17:29'),
(4, 2, 'K3_1_1_SOURCES_4_6', 'passed', '3', '3', 'Prüft das Vorhandensein der Literaturquellen [4] bis [6].', '2026-07-26 06:35:13'),
(5, 2, 'K3_1_1_SOURCE_USAGE', 'passed', '3', '3', 'Prüft die drei Quellenverwendungen in Abschnitt 3.1.1.', '2026-07-26 06:35:13'),
(6, 2, 'K3_1_1_NO_EQUATIONS', 'passed', '0', '0', 'Abschnitt 3.1.1 enthält keine nummerierte Gleichung.', '2026-07-26 06:35:13'),
(7, 4, 'K3.1.2-T2-SOURCES', 'passed', '4', '4', 'Die Quellen [13] bis [16] müssen vollständig registriert sein.', '2026-07-26 07:24:45'),
(8, 4, 'K3.1.2-T2-EQUATIONS', 'passed', '0', '0', 'Teil 2 von Abschnitt 3.1.2 enthält keine nummerierten Gleichungen.', '2026-07-26 07:24:45'),
(9, 5, 'K312T3_EQ', 'passed', '0', '0', 'Keine Gleichungen vorhanden.', '2026-07-26 07:56:18'),
(10, 6, 'K3.1.2-T4-SOURCE25', 'passed', '1', '1', 'Quelle [25] muss genau einmal im Repository vorhanden sein.', '2026-07-26 08:58:07'),
(11, 6, 'K3.1.2-STATUS', 'passed', 'final', 'final', 'Abschnitt 3.1.2 muss nach Teil 4 den Status final besitzen.', '2026-07-26 08:58:07'),
(12, 6, 'K3.1.2-EQUATIONS', 'passed', '0', '0', 'Der vollständige Abschnitt 3.1.2 enthält keine nummerierten Gleichungen.', '2026-07-26 08:58:07'),
(13, 7, 'K3.1.3-T1-SOURCES', 'passed', '8', '8', 'Die Quellen [26] bis [33] müssen vollständig vorhanden sein.', '2026-07-26 11:16:49'),
(14, 7, 'K3.1.3-T1-EQUATIONS', 'passed', '0', '0', 'Teil 1 des Abschnitts 3.1.3 enthält keine nummerierten Gleichungen.', '2026-07-26 11:16:49'),
(15, 8, 'K3.1.3-T2-SOURCES', 'passed', '6', '6', 'Die Quellen [34] bis [39] müssen vollständig vorhanden sein.', '2026-07-26 11:54:25'),
(16, 8, 'K3.1.3-T2-USAGE', 'passed', '6', '6', 'Alle sechs Quellen müssen mit Abschnitt 3.1.3 verknüpft sein.', '2026-07-26 11:54:25'),
(17, 8, 'K3.1.3-T2-EQUATIONS', 'passed', '0', '0', 'Teil 2 des Abschnitts 3.1.3 enthält keine nummerierten Gleichungen.', '2026-07-26 11:54:25'),
(19, 9, 'K3_1_4_SECTION', 'passed', '1', '1', 'Abschnitt 3.1.4 genau einmal vorhanden.', '2026-07-26 15:54:32'),
(20, 9, 'K3_1_4_SOURCES', 'passed', '15', '15', 'Quellen [45]–[59] vollständig.', '2026-07-26 15:54:32'),
(21, 9, 'K3_1_4_USAGE', 'passed', '15', '15', 'Neue Quellen vollständig verknüpft.', '2026-07-26 15:54:32'),
(22, 9, 'K3_1_4_REUSE', 'failed', '3', '1', 'Wiederverwendete Quellen vollständig verknüpft.', '2026-07-26 15:54:32'),
(23, 9, 'K3_1_4_NO_EQUATIONS', 'passed', '0', '0', 'Keine nummerierten Gleichungen.', '2026-07-26 15:54:32'),
(24, 10, 'K3_1_5_SECTION', 'passed', '1', '1', 'Abschnitt 3.1.5 muss genau einmal vorhanden sein.', '2026-07-26 17:20:10'),
(25, 10, 'K3_1_5_SOURCES', 'passed', '2', '2', 'Die Quellen [60] und [61] müssen vollständig vorhanden sein.', '2026-07-26 17:20:10'),
(26, 10, 'K3_1_5_SOURCE_USAGE', 'passed', '2', '2', 'Beide neuen Quellen müssen mit Abschnitt 3.1.5 verknüpft sein.', '2026-07-26 17:20:10'),
(27, 10, 'K3_1_5_PRINCIPLES', 'passed', '10', '10', 'Die methodologischen Grundsätze M1 bis M10 müssen vollständig protokolliert sein.', '2026-07-26 17:20:10'),
(28, 10, 'K3_1_5_NO_EQUATIONS', 'passed', '0', '0', 'Abschnitt 3.1.5 enthält keine nummerierten Gleichungen.', '2026-07-26 17:20:10'),
(29, 11, 'K3_1_6_SECTION', 'passed', '1', '1', 'Abschnitt 3.1.6 muss genau einmal vorhanden sein.', '2026-07-26 17:26:06'),
(30, 11, 'K3_1_6_NEW_SOURCES', 'passed', '9', '9', 'Die Quellen [62] bis [70] müssen vollständig vorhanden sein.', '2026-07-26 17:26:06'),
(31, 11, 'K3_1_6_REUSED_SOURCES', 'failed', '3', '2', 'Die Quellen [18], [60] und [61] müssen mit Abschnitt 3.1.6 verknüpft sein.', '2026-07-26 17:26:06'),
(32, 11, 'K3_1_6_NEW_USAGE', 'passed', '9', '9', 'Alle Quellen [62] bis [70] müssen mit Abschnitt 3.1.6 verknüpft sein.', '2026-07-26 17:26:06'),
(33, 11, 'K3_1_6_NO_EQUATIONS', 'passed', '0', '0', 'Abschnitt 3.1.6 enthält keine nummerierten Gleichungen.', '2026-07-26 17:26:06'),
(34, 12, 'K3_1_7_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.1.7 muss genau einmal vorhanden sein.', '2026-07-26 17:31:40'),
(35, 12, 'K3_1_7_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.1.7 muss den Status final besitzen.', '2026-07-26 17:31:40'),
(36, 12, 'K3_1_CHAPTER_FINAL', 'passed', '1', '1', 'Der übergeordnete Abschnitt 3.1 muss nach Abschluss von 3.1.7 den Status final besitzen.', '2026-07-26 17:31:40'),
(37, 12, 'K3_1_7_NO_NEW_SOURCES', 'passed', '0', '0', 'Abschnitt 3.1.7 führt keine neuen Literaturstellen ein.', '2026-07-26 17:31:40'),
(38, 12, 'K3_1_7_NO_SOURCE_USAGE', 'passed', '0', '0', 'Für Abschnitt 3.1.7 sind in dieser Fassung keine zusätzlichen Einzelquellenverwendungen vorgesehen.', '2026-07-26 17:31:40'),
(39, 12, 'K3_1_7_NO_EQUATIONS', 'passed', '0', '0', 'Abschnitt 3.1.7 enthält keine nummerierten Gleichungen.', '2026-07-26 17:31:40'),
(40, 12, 'K3_1_7_LAST_CITATION', 'passed', '70', '70', 'Die letzte vergebene Literaturstelle muss nach Abschnitt 3.1.7 weiterhin [70] sein.', '2026-07-26 17:31:40');

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
(1, 1, 3, 'created', 'section', '3.1.0', 'Abschnitt 3.1.0 schemagerecht angelegt beziehungsweise aktualisiert.', NULL, 'Einleitung; Status final; Literatur [1] bis [3]; keine Gleichungen.', '2026-07-26 06:17:29'),
(2, 1, 3, 'source_added', 'sources', '[1]–[3]', 'Die drei Grundlagenquellen des Einleitungsabschnitts wurden, soweit in sources vorhanden, mit Abschnitt 3.1.0 verknüpft.', NULL, 'Verknüpfte Quellen: 0', '2026-07-26 06:17:29'),
(3, 2, 4, 'created', 'section', '3.1.1', 'Abschnitt 3.1.1 wurde schemagerecht angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Originalbeitrag; Literatur [4] bis [6]; keine nummerierten Gleichungen.', '2026-07-26 06:35:12'),
(4, 2, 4, 'source_added', 'sources', '[4]–[6]', 'Die Quellen [4] bis [6] wurden angelegt, mit Autorenrollen versehen, annotiert und dem Abschnitt 3.1.1 als Erstnennungen zugeordnet.', NULL, '3 neue Quellen; 5 Autoren bzw. Herausgeber; 3 Quellenverwendungen.', '2026-07-26 06:35:12'),
(6, 3, 6, 'created', 'section', '3.1.2', 'Abschnitt 3.1.2 wurde angelegt beziehungsweise für den ersten Bearbeitungsteil aktualisiert.', NULL, 'Teil 1: Platon bis Leibniz; Literatur [7] bis [12]; keine Gleichungen.', '2026-07-26 06:54:27'),
(7, 3, 6, 'source_added', 'sources', '[7]–[12]', 'Die im ersten Teil von Abschnitt 3.1.2 verwendeten Literaturquellen wurden mit dem Abschnitt verknüpft.', NULL, 'Verknüpfte Quellen: 0', '2026-07-26 06:54:27'),
(8, 4, 6, 'edited', 'section', '3.1.2-T2', 'Abschnitt 3.1.2 wurde um die philosophischen Positionen von Kant, Hegel, Russell und Whitehead erweitert.', 'Bearbeitungsstand Teil 1: Literatur [7] bis [12].', 'Bearbeitungsstand Teil 2: Literatur [7] bis [16]; keine Gleichungen.', '2026-07-26 07:24:45'),
(9, 4, 6, 'source_added', 'sources', '[13]–[16]', 'Vier neue philosophische Quellen wurden aufgenommen und mit Abschnitt 3.1.2 verknüpft.', 'next_citation_number=13', 'next_citation_number=17', '2026-07-26 07:24:45'),
(10, 5, 6, 'edited', 'section', '3.1.2-T3', 'Abschnitt erweitert um Husserl bis Floridi.', 'Literatur bis [16]', 'Literatur bis [24]', '2026-07-26 07:56:18'),
(11, 6, 6, 'edited', 'section', '3.1.2-T4', 'Der vierte Teil wurde mit Michel Bitbol, der philosophischen Gesamtsynthese und den vier Arbeitsprinzipien des FRZK ergänzt.', 'Bearbeitungsstand Teil 3: Literatur bis [24].', 'Vollständiger Abschnitt: Literatur bis [25], Synthese und Überleitung zu 3.1.3.', '2026-07-26 08:58:07'),
(12, 6, 6, 'source_added', 'source', '[25]', 'Michel Bitbol wurde als Quelle [25] aufgenommen und mit Abschnitt 3.1.2 verknüpft.', 'last_citation_number=24', 'last_citation_number=25', '2026-07-26 08:58:07'),
(13, 6, 6, '', 'section', '3.1.2', 'Abschnitt 3.1.2 Philosophische Grundlagen wurde vollständig abgeschlossen.', 'draft', 'final', '2026-07-26 08:58:07'),
(14, 7, 7, 'created', 'section', '3.1.3-T1', 'Abschnitt 3.1.3 wurde mit dem ersten Teil der physikalischen Grundlagen angelegt.', 'Abschnitt nicht vorhanden beziehungsweise ohne Teil 1.', 'Newton bis Hawking/Ellis; Literatur [26] bis [33].', '2026-07-26 11:16:49'),
(15, 7, 7, 'source_added', 'source_range', '[26]-[33]', 'Die Quellen [26] bis [33] wurden aufgenommen und mit Abschnitt 3.1.3 verknüpft.', 'last_citation_number=25', 'last_citation_number=33', '2026-07-26 11:16:49'),
(16, 8, 7, 'edited', 'section', '3.1.3-T2', 'Der zweite Teil der physikalischen Grundlagen wurde ergänzt.', 'Teil 1: Literaturstand [33].', 'Teil 2: Quantenmechanik, Quantenfeldtheorie und Quantengravitation; Literaturstand [39].', '2026-07-26 11:54:25'),
(17, 8, 7, 'source_added', 'source_range', '[34]-[39]', 'Die Quellen [34] bis [39] wurden aufgenommen und mit Abschnitt 3.1.3 verknüpft.', 'last_citation_number=33', 'last_citation_number=39', '2026-07-26 11:54:25'),
(18, 9, 8, 'created', 'section', '3.1.4', 'Abschnitt 3.1.4 vollständig angelegt und abgeschlossen.', NULL, 'Quellen [15], [19], [23] und [45]–[59]; keine Gleichungen.', '2026-07-26 15:54:32'),
(19, 10, 9, 'created', 'methodological_principle', 'M1', 'Vermeidung vorweggenommener Raum- und Zeitstrukturen.', NULL, 'Raum, Zeit, Richtung, Entfernung, Dauer und Gleichzeitigkeit dürfen nicht als elementare Eigenschaften des funktionalen Ausgangssystems vorausgesetzt werden.', '2026-07-26 17:20:10'),
(20, 10, 9, 'created', 'methodological_principle', 'M2', 'Explizite Ableitungsabhängigkeit.', NULL, 'Jede Definition, Relation und mathematische Konstruktion muss vollständig auf bereits eingeführte Begriffe zurückführbar sein.', '2026-07-26 17:20:10'),
(21, 10, 9, 'created', 'methodological_principle', 'M3', 'Relationale Bestimmung funktionaler Zustände.', NULL, 'Funktionale Zustände werden zunächst durch Unterscheidbarkeit sowie definierte Relationen und Transformationen bestimmt.', '2026-07-26 17:20:10'),
(22, 10, 9, 'created', 'methodological_principle', 'M4', 'Vorrang strukturerhaltender Transformationen.', NULL, 'Für Transformationen ist zu bestimmen, welche Relationen, Eigenschaften oder Invarianten erhalten, verändert oder erzeugt werden.', '2026-07-26 17:20:10'),
(23, 10, 9, 'created', 'methodological_principle', 'M5', 'Funktionale Anschlussfähigkeit von Definitionen.', NULL, 'Definitionen müssen eindeutig, widerspruchsfrei und für weitere Ableitungen verwendbar sein.', '2026-07-26 17:20:10'),
(24, 10, 9, 'created', 'methodological_principle', 'M6', 'Nicht rückwirkende Begriffsentwicklung.', NULL, 'Neue Definitionen dürfen die Bedeutung bereits eingeführter Begriffe nicht unbemerkt verändern.', '2026-07-26 17:20:10'),
(25, 10, 9, 'created', 'methodological_principle', 'M7', 'Trennung von Formalismus und Interpretation.', NULL, 'Mathematische Entwicklung und empirische oder fachwissenschaftliche Interpretation sind voneinander zu trennen.', '2026-07-26 17:20:10'),
(26, 10, 9, 'created', 'methodological_principle', 'M8', 'Modularität und Abhängigkeitskontrolle.', NULL, 'Logische Abhängigkeiten müssen eindeutig bestimmt und Änderungen auf tatsächlich abhängige Aussagen begrenzt werden.', '2026-07-26 17:20:10'),
(27, 10, 9, 'created', 'methodological_principle', 'M9', 'Versionierung und Reproduzierbarkeit.', NULL, 'Jede inhaltliche oder formale Änderung muss dokumentiert, einer Revision zugeordnet und überprüfbar sein.', '2026-07-26 17:20:10'),
(28, 10, 9, 'created', 'methodological_principle', 'M10', 'Vorrang der Rekonstruktion vor der Deutung.', NULL, 'Ontologische, physikalische oder anwendungsbezogene Deutungen erfolgen erst auf Grundlage einer konsistent entwickelten mathematischen Struktur.', '2026-07-26 17:20:10'),
(34, 10, 9, 'created', 'section', '3.1.5', 'Abschnitt 3.1.5 „Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem“ wurde vollständig angelegt und abgeschlossen.', NULL, 'Methodologische Grundsätze M1 bis M10; Quellen [60] und [61]; keine nummerierten Gleichungen.', '2026-07-26 17:20:10'),
(35, 10, 9, 'source_added', 'source_range', '[60]-[61]', 'Die neuen Quellen [60] und [61] wurden aufgenommen und mit Abschnitt 3.1.5 verknüpft.', 'last_citation_number=59', 'last_citation_number=61', '2026-07-26 17:20:10'),
(36, 10, 9, 'status_changed', 'section', '3.1.5-ABSCHLUSS', 'Abschnitt 3.1.5 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-07-26 17:20:10'),
(37, 11, 10, 'created', 'section', '3.1.6', 'Abschnitt 3.1.6 „Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft“ wurde vollständig angelegt und abgeschlossen.', NULL, 'Quellen [18], [60], [61] sowie [62] bis [70]; keine nummerierten Gleichungen.', '2026-07-26 17:26:06'),
(38, 11, 10, 'source_added', 'source_range', '[62]-[70]', 'Die neuen Quellen [62] bis [70] wurden aufgenommen und mit Abschnitt 3.1.6 verknüpft.', 'last_citation_number=61', 'last_citation_number=70', '2026-07-26 17:26:06'),
(39, 11, 10, 'status_changed', 'section', '3.1.6-ABSCHLUSS', 'Abschnitt 3.1.6 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-07-26 17:26:06'),
(40, 12, 11, 'created', 'section', '3.1.7', 'Abschnitt 3.1.7 wurde vollständig angelegt und abgeschlossen.', NULL, 'Forschungsstand, disziplinübergreifende Forschungslücke, Minimalitätsproblem, wissenschaftliche Zielsetzung, Forschungsfragen und Geltungsgrenzen des FRZK.', '2026-07-26 17:31:40'),
(41, 12, 11, '', 'research_gap', 'FRZK-FORSCHUNGSLUECKE-3.1.7', 'Die Forschungslücke wurde als fehlende Rekonstruktion einer minimalen funktionalen Organisation bestimmt, aus der Zustände, Relationen, Transformationen und geordnete Strukturen hervorgehen können.', NULL, 'Forschungslücke disziplinübergreifend und nicht als Defizit einer einzelnen bestehenden Theorie bestimmt.', '2026-07-26 17:31:40'),
(42, 12, 11, '', 'research_objective', 'FRZK-ZIELSETZUNG-3.1.7', 'Die wissenschaftliche Zielsetzung wurde als Entwicklung eines minimalen, explizit aufgebauten funktionalen Grundsystems formuliert.', NULL, 'Schrittweise Rekonstruktion von Zuständen, Relationen, Transformationen und kohärenten Organisationsformen.', '2026-07-26 17:31:40'),
(43, 12, 11, '', 'research_questions', 'FRZK-FORSCHUNGSFRAGEN-3.1.7', 'Sechs übergeordnete Forschungsfragen zur Entstehung funktionaler Zustände, Relationen, Transformationen, Kohärenz, Raum-Zeit-Interpretation und Systemgrenzen wurden festgelegt.', NULL, 'Forschungsfragen 1 bis 6 als Leitstruktur der weiteren mathematischen Entwicklung.', '2026-07-26 17:31:40'),
(44, 12, 2, 'status_changed', 'section', '3.1-ABSCHLUSS', 'Kapitel 3.1 wurde mit Abschluss von Abschnitt 3.1.7 vollständig beendet.', 'in_progress', 'final', '2026-07-26 17:31:40');

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
(1, 4, 'parmenides_fragmente_diels_kranz_1951', 'historical_work', 'Die Fragmente der Vorsokratiker', 'Griechisch und deutsch, Band 1; Fragmente 28 B2, B3 und B6', NULL, 1951, NULL, 'Weidmann', 'Berlin', '1', NULL, NULL, '6. Auflage', NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.1', 'Erstnennung zur philosophischen Unzugänglichkeit des Nichtseins und zur Bindung von Denken, Sagen und Sein.', 'Parmenides: Fragmente 28 B2, B3 und B6. In: Diels, Hermann; Kranz, Walther (Hrsg.) (1951): Die Fragmente der Vorsokratiker. Griechisch und deutsch. Band 1. 6. Auflage. Berlin: Weidmann.', 'Parmenides, Fragmente 28 B2, B3 und B6 [4]', 'Historische Primärüberlieferung in der Edition von Diels und Kranz.', 2, '2026-07-26 06:35:12', '2026-07-26 06:35:12'),
(2, 5, 'weinberg_quantum_fields_vol1_1995', 'book', 'The Quantum Theory of Fields', 'Volume I: Foundations', 1995, 1995, NULL, 'Cambridge University Press', 'Cambridge', 'I', NULL, NULL, '1', NULL, '978-0-521-55001-7', NULL, 'en', 1, 'textbook', 8, 'verified', '3.1.1', 'Erstnennung zur Einordnung des quantenfeldtheoretischen Vakuums als strukturierter Grundzustand eines vorausgesetzten formalen Systems.', 'Weinberg, Steven (1995): The Quantum Theory of Fields. Volume I: Foundations. Cambridge: Cambridge University Press.', 'Weinberg (1995) [5]', 'Grundlegende Darstellung der Quantenfeldtheorie; verwendet für den Zustands- und Vakuumbegriff.', 2, '2026-07-26 06:35:12', '2026-07-26 06:35:12'),
(3, 6, 'halmos_naive_set_theory_1974', 'book', 'Naive Set Theory', NULL, 1960, 1974, NULL, 'Springer-Verlag', 'New York', NULL, NULL, '1–12', 'Reprint', NULL, '978-0-387-90092-6', NULL, 'en', 1, 'textbook', 8, 'verified', '3.1.1', 'Erstnennung zur leeren Menge als wohldefiniertem mathematischem Objekt innerhalb einer vorausgesetzten Mengenstruktur.', 'Halmos, Paul R. (1974): Naive Set Theory. New York: Springer-Verlag, insbesondere S. 1–12.', 'Halmos (1974) [6]', 'Referenzwerk zur elementaren Mengenlehre und zur begrifflichen Stellung der leeren Menge.', 2, '2026-07-26 06:35:12', '2026-07-26 06:35:12'),
(4, 13, 'kant_kritik_reinen_vernunft_timmermann_1998', 'historical_work', 'Kritik der reinen Vernunft', 'Insbesondere A19/B33–A49/B73', 1781, 1998, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.2', 'Erstnennung zu Raum und Zeit als reinen Formen der sinnlichen Anschauung und Bedingungen möglicher Erfahrung.', 'Kant, Immanuel: Kritik der reinen Vernunft. Herausgegeben von Jens Timmermann. Hamburg: Felix Meiner Verlag, 1998, insbesondere A19/B33–A49/B73.', 'Kant, Kritik der reinen Vernunft [13]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 4, '2026-07-26 07:24:45', '2026-07-26 07:24:45'),
(5, 14, 'hegel_wissenschaft_logik_1986', 'historical_work', 'Wissenschaft der Logik I', 'Werke, Band 5; insbesondere Sein, Nichts und Werden', 1812, 1986, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.2', 'Erstnennung zur dialektischen Verbindung von Sein, Nichts und Werden sowie zur prozessualen Bestimmtheit.', 'Hegel, Georg Wilhelm Friedrich: Wissenschaft der Logik I. Werke, Band 5. Frankfurt am Main: Suhrkamp, 1986, insbesondere „Sein“, „Nichts“ und „Werden“.', 'Hegel, Wissenschaft der Logik I [14]', 'Historische Primärquelle zur philosophischen Bestimmung von Differenz, Negation und Vermittlung.', 4, '2026-07-26 07:24:45', '2026-07-26 07:24:45'),
(6, 15, 'russell_principles_mathematics_1903', 'book', 'The Principles of Mathematics', NULL, 1903, 1903, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 7, 'partially_verified', '3.1.2', 'Erstnennung zur formalen Eigenständigkeit mehrstelliger Relationen in der modernen Logik.', 'Russell, Bertrand: The Principles of Mathematics. Cambridge: Cambridge University Press, 1903.', 'Russell, The Principles of Mathematics [15]', 'Historische Primärquelle zur relationalen Logik und zu den Grundlagen der Mathematik.', 4, '2026-07-26 07:24:45', '2026-07-26 07:24:45'),
(7, 16, 'whitehead_process_reality_1978', 'book', 'Process and Reality', 'An Essay in Cosmology', 1929, 1978, NULL, 'Free Press', 'New York', NULL, NULL, NULL, 'Corrected edition', NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.2', 'Erstnennung zur Prozessontologie und zum Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaften Substanzen.', 'Whitehead, Alfred North: Process and Reality. An Essay in Cosmology. Corrected edition. Herausgegeben von David Ray Griffin und Donald W. Sherburne. New York: Free Press, 1978.', 'Whitehead, Process and Reality [16]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 4, '2026-07-26 07:24:45', '2026-07-26 07:24:45'),
(8, 25, 'bitbol_reflective_metaphysics_2021', 'book', 'Reflective Metaphysics', 'Understanding Quantum Mechanics from a Kantian Standpoint', 2021, 2021, NULL, 'Springer', 'Cham', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.2', 'Erstnennung zur erkenntnistheoretischen Reflexion moderner Physik und zur Trennung mathematischer Möglichkeit von ontologischer und physikalischer Geltung.', 'Bitbol, Michel: Reflective Metaphysics. Understanding Quantum Mechanics from a Kantian Standpoint. Cham: Springer, 2021.', 'Bitbol, Reflective Metaphysics [25]', 'Methodisch zentrale Quelle zur erkenntnistheoretischen Begrenzung ontologischer Schlüsse aus mathematischen Formalismen.', 6, '2026-07-26 08:58:07', '2026-07-26 08:58:07'),
(9, 26, 'newton_principia_1687', 'book', 'Philosophiae Naturalis Principia Mathematica', NULL, 1687, 1687, NULL, 'Joseph Streater', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'la', 1, 'primary', 10, 'verified', '3.1.3', 'Absolute Zeit und absoluter Raum als primitive physikalische Grundgrößen.', 'Newton, Isaac: Philosophiae Naturalis Principia Mathematica. London: Joseph Streater, 1687.', 'Newton, Principia [26]', 'Grundlage für die klassische Trennung von Raum, Zeit und physikalischen Vorgängen.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(10, 27, 'mach_mechanik_1883', 'book', 'Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt', NULL, 1883, 1883, NULL, 'F. A. Brockhaus', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.3', 'Kritik am absoluten Raum und relationale Bestimmung von Trägheit und Bewegung.', 'Mach, Ernst: Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt. Leipzig: F. A. Brockhaus, 1883.', 'Mach, Mechanik [27]', 'Zentrale Quelle für die relationale Kritik am newtonschen Raumbegriff.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(11, 28, 'einstein_elektrodynamik_1905', 'journal_article', 'Zur Elektrodynamik bewegter Körper', NULL, 1905, 1905, NULL, 'Annalen der Physik', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.3', 'Spezielle Relativitätstheorie, Relativität der Gleichzeitigkeit und Invarianz der Lichtgeschwindigkeit.', 'Einstein, Albert: Zur Elektrodynamik bewegter Körper. In: Annalen der Physik, Band 17, 1905, S. 891–921.', 'Einstein, Elektrodynamik [28]', 'Primärquelle zur Speziellen Relativitätstheorie.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(12, 29, 'minkowski_raum_zeit_1909', 'book', 'Raum und Zeit', NULL, 1909, 1909, NULL, 'B. G. Teubner', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.3', 'Vereinigung von Raum und Zeit in einer vierdimensionalen Raumzeitstruktur.', 'Minkowski, Hermann: Raum und Zeit. Leipzig: B. G. Teubner, 1909.', 'Minkowski, Raum und Zeit [29]', 'Grundlage für die geometrische Raumzeitbeschreibung.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(13, 30, 'einstein_allgemeine_relativitaet_1916', 'journal_article', 'Die Grundlage der allgemeinen Relativitätstheorie', NULL, 1916, 1916, NULL, 'Annalen der Physik', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.3', 'Dynamische Raumzeitgeometrie und geometrische Deutung der Gravitation.', 'Einstein, Albert: Die Grundlage der allgemeinen Relativitätstheorie. In: Annalen der Physik, Band 49, 1916, S. 769–822.', 'Einstein, Allgemeine Relativitätstheorie [30]', 'Primärquelle zur Allgemeinen Relativitätstheorie.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(14, 31, 'weyl_raum_zeit_materie_1923', 'book', 'Raum – Zeit – Materie', 'Vorlesungen über allgemeine Relativitätstheorie', 1918, 1923, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '5. Auflage', NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.3', 'Zusammenhang von Geometrie, Materie, Feldern und Symmetrien.', 'Weyl, Hermann: Raum – Zeit – Materie. Vorlesungen über allgemeine Relativitätstheorie. 5. Auflage. Berlin: Springer, 1923.', 'Weyl, Raum – Zeit – Materie [31]', 'Vertiefung der geometrisch-feldtheoretischen Raumzeitbeschreibung.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(15, 32, 'wald_general_relativity_1984', 'book', 'General Relativity', NULL, 1984, 1984, NULL, 'University of Chicago Press', 'Chicago', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.3', 'Systematische Darstellung der Allgemeinen Relativitätstheorie auf Lorentz-Mannigfaltigkeiten.', 'Wald, Robert M.: General Relativity. Chicago: University of Chicago Press, 1984.', 'Wald, General Relativity [32]', 'Beleg für die mathematischen Voraussetzungen der Allgemeinen Relativitätstheorie.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(16, 33, 'hawking_ellis_large_scale_1973', 'book', 'The Large Scale Structure of Space-Time', NULL, 1973, 1973, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.3', 'Kosmologische Raumzeitstrukturen, Gravitationskollaps und Singularitätssätze.', 'Hawking, Stephen W.; Ellis, George F. R.: The Large Scale Structure of Space-Time. Cambridge: Cambridge University Press, 1973.', 'Hawking/Ellis, Large Scale Structure [33]', 'Grundlage für die Diskussion von Singularitäten als Modellgrenzen.', 7, '2026-07-26 11:16:49', '2026-07-26 11:16:49'),
(17, 34, 'von_neumann_mathematische_grundlagen_1932', 'book', 'Mathematische Grundlagen der Quantenmechanik', NULL, 1932, 1932, NULL, 'Julius Springer', 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.3', 'Formalisierung quantenmechanischer Zustände, Observablen und Operatoren im Hilbertraum.', 'von Neumann, John: Mathematische Grundlagen der Quantenmechanik. Berlin: Julius Springer, 1932.', 'von Neumann, Quantenmechanik [34]', 'Zentrale Primärquelle zur mathematischen Struktur der Quantenmechanik.', 8, '2026-07-26 11:54:25', '2026-07-26 11:54:25'),
(18, 35, 'dirac_principles_quantum_mechanics_1930', 'book', 'The Principles of Quantum Mechanics', NULL, 1930, 1930, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Abstrakte Formulierung quantenmechanischer Zustände, Observablen und Transformationen.', 'Dirac, Paul A. M.: The Principles of Quantum Mechanics. Oxford: Clarendon Press, 1930.', 'Dirac, Principles of Quantum Mechanics [35]', 'Primärquelle zur abstrakten Operator- und Zustandsformulierung.', 8, '2026-07-26 11:54:25', '2026-07-26 11:54:25'),
(19, 36, 'weinberg_qtf_volume1_1995', 'book', 'The Quantum Theory of Fields', 'Volume I: Foundations', 1995, 1995, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 10, 'verified', '3.1.3', 'Grundlagen relativistischer Quantenfelder, Symmetrien, Lokalität und Teilchen als Feldanregungen.', 'Weinberg, Steven: The Quantum Theory of Fields. Volume I: Foundations. Cambridge: Cambridge University Press, 1995.', 'Weinberg, Quantum Theory of Fields I [36]', 'Systematische Grundlage der Quantenfeldtheorie.', 8, '2026-07-26 11:54:25', '2026-07-26 11:54:25'),
(20, 37, 'dewitt_quantum_theory_gravity_1967', 'journal_article', 'Quantum Theory of Gravity. I. The Canonical Theory', NULL, 1967, 1967, 'Physical Review', NULL, NULL, '160', NULL, '1113–1148', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Kanonische Quantisierung der Gravitation und Einbeziehung des geometrischen Hintergrunds in die Quantentheorie.', 'DeWitt, Bryce S.: Quantum Theory of Gravity. I. The Canonical Theory. In: Physical Review, Band 160, 1967, S. 1113–1148.', 'DeWitt, Quantum Theory of Gravity I [37]', 'Frühe Primärquelle zur kanonischen Quantengravitation.', 8, '2026-07-26 11:54:25', '2026-07-26 11:54:25'),
(21, 38, 'rovelli_quantum_gravity_2004', 'book', 'Quantum Gravity', NULL, 2004, 2004, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 10, 'verified', '3.1.3', 'Raum als möglicherweise aus quantisierten relationalen Strukturen hervorgehende Größe.', 'Rovelli, Carlo: Quantum Gravity. Cambridge: Cambridge University Press, 2004.', 'Rovelli, Quantum Gravity [38]', 'Zentrale Darstellung schleifenquantengravitativer und relationaler Raumkonzepte.', 8, '2026-07-26 11:54:25', '2026-07-26 11:54:25'),
(22, 39, 'kiefer_quantum_gravity_2012', 'book', 'Quantum Gravity', NULL, 2004, 2012, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, '3. Auflage', NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.3', 'Vergleich quantengravitativer Forschungsprogramme und ihrer empirischen sowie theoretischen Grenzen.', 'Kiefer, Claus: Quantum Gravity. 3. Auflage. Oxford: Oxford University Press, 2012.', 'Kiefer, Quantum Gravity [39]', 'Vergleichende Darstellung unterschiedlicher Quantengravitationsansätze.', 8, '2026-07-26 11:54:25', '2026-07-26 11:54:25'),
(24, 45, 'helmholtz_handbuch_phys_optik_1867', 'book', 'Handbuch der physiologischen Optik', NULL, 1867, 1867, NULL, 'Leopold Voss', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.4', 'Wahrnehmung als Ergebnis unbewusster Schlussprozesse.', 'Helmholtz, Hermann von: Handbuch der physiologischen Optik. Leipzig: Leopold Voss, 1867.', 'Helmholtz [45]', 'Erkenntnistheoretische Vermittlung zwischen Reiz, Wahrnehmung und Gegenstandsbezug.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(25, 46, 'hanson_patterns_discovery_1958', 'book', 'Patterns of Discovery', 'An Inquiry into the Conceptual Foundations of Science', 1958, 1958, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Theorieabhängigkeit wissenschaftlicher Beobachtung.', 'Hanson, Norwood Russell: Patterns of Discovery. Cambridge: Cambridge University Press, 1958.', 'Hanson [46]', 'Theoriegeladenheit wissenschaftlichen Sehens.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(26, 47, 'kuhn_structure_scientific_revolutions_1962', 'book', 'The Structure of Scientific Revolutions', NULL, 1962, 1962, NULL, 'University of Chicago Press', 'Chicago', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.4', 'Paradigmen und historische Theorieentwicklung.', 'Kuhn, Thomas S.: The Structure of Scientific Revolutions. Chicago: University of Chicago Press, 1962.', 'Kuhn [47]', 'Paradigmatische Einbettung wissenschaftlicher Begriffe.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(27, 48, 'popper_logik_forschung_1935', 'book', 'Logik der Forschung', 'Zur Erkenntnistheorie der modernen Naturwissenschaft', 1935, 1935, NULL, 'Julius Springer', 'Wien', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.4', 'Falsifizierbarkeit empirischer Wissenschaft.', 'Popper, Karl R.: Logik der Forschung. Wien: Julius Springer, 1935.', 'Popper [48]', 'Falsifizierbarkeit wissenschaftlicher Aussagen.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(28, 49, 'lakatos_falsification_research_programmes_1970', 'book_chapter', 'Falsification and the Methodology of Scientific Research Programmes', NULL, 1970, 1970, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, '91–196', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.4', 'Progressive und degenerative Forschungsprogramme.', 'Lakatos, Imre: Falsification and the Methodology of Scientific Research Programmes. In: Lakatos/Musgrave (Hrsg.): Criticism and the Growth of Knowledge. Cambridge, 1970, S. 91–196.', 'Lakatos [49]', 'Methodische Selbstprüfung des FRZK.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(29, 50, 'quine_two_dogmas_empiricism_1951', 'journal_article', 'Two Dogmas of Empiricism', NULL, 1951, 1951, 'The Philosophical Review', NULL, NULL, '60', NULL, '20–43', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.4', 'Holismus wissenschaftlicher Überprüfung.', 'Quine, Willard Van Orman: Two Dogmas of Empiricism. The Philosophical Review 60 (1951), S. 20–43.', 'Quine [50]', 'Bestätigungs- und Überprüfungsholismus.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(30, 51, 'duhem_theorie_physique_1906', 'book', 'La théorie physique', 'Son objet et sa structure', 1906, 1906, NULL, 'Chevalier & Rivière', 'Paris', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fr', 1, 'primary', 10, 'verified', '3.1.4', 'Experimente prüfen Bündel von Voraussetzungen.', 'Duhem, Pierre: La théorie physique. Son objet et sa structure. Paris: Chevalier & Rivière, 1906.', 'Duhem [51]', 'Unterbestimmtheit physikalischer Theorien.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(31, 52, 'van_fraassen_scientific_image_1980', 'book', 'The Scientific Image', NULL, 1980, 1980, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Konstruktiver Empirismus.', 'van Fraassen, Bas C.: The Scientific Image. Oxford: Clarendon Press, 1980.', 'van Fraassen [52]', 'Zurückhaltende ontologische Interpretation.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(32, 53, 'worrall_structural_realism_1989', 'journal_article', 'Structural Realism: The Best of Both Worlds?', NULL, 1989, 1989, 'Dialectica', NULL, NULL, '43', NULL, '99–124', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.4', 'Strukturerhaltung bei Theorieumbrüchen.', 'Worrall, John: Structural Realism: The Best of Both Worlds? Dialectica 43 (1989), S. 99–124.', 'Worrall [53]', 'Epistemischer Strukturenrealismus.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(33, 54, 'ladyman_what_structural_realism_1998', 'journal_article', 'What is Structural Realism?', NULL, 1998, 1998, 'Studies in History and Philosophy of Science', NULL, NULL, '29', NULL, '409–424', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Ontischer Strukturenrealismus.', 'Ladyman, James: What is Structural Realism? Studies in History and Philosophy of Science 29 (1998), S. 409–424.', 'Ladyman [54]', 'Ontische Interpretation wissenschaftlicher Strukturen.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(34, 55, 'french_ladyman_remodelling_structural_realism_2003', 'journal_article', 'Remodelling Structural Realism', 'Quantum Physics and the Metaphysics of Structure', 2003, 2003, 'Synthese', NULL, NULL, '136', NULL, '31–56', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Strukturenrealismus und Quantenphysik.', 'French, Steven; Ladyman, James: Remodelling Structural Realism. Synthese 136 (2003), S. 31–56.', 'French/Ladyman [55]', 'Strukturalistische Interpretation moderner Physik.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(35, 56, 'hesse_models_analogies_science_1963', 'book', 'Models and Analogies in Science', NULL, 1963, 1963, NULL, 'Sheed and Ward', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Positive, negative und neutrale Analogien.', 'Hesse, Mary B.: Models and Analogies in Science. London: Sheed and Ward, 1963.', 'Hesse [56]', 'Selektive und analoge Funktion wissenschaftlicher Modelle.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(36, 57, 'giere_explaining_science_1988', 'book', 'Explaining Science', 'A Cognitive Approach', 1988, 1988, NULL, 'University of Chicago Press', 'Chicago', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Modelle als zielgerichtete Repräsentationen.', 'Giere, Ronald N.: Explaining Science. Chicago: University of Chicago Press, 1988.', 'Giere [57]', 'Ziel- und zweckabhängige Modellrepräsentation.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(37, 58, 'suppes_models_mathematics_empirical_sciences_1960', 'journal_article', 'A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences', NULL, 1960, 1960, 'Synthese', NULL, NULL, '12', NULL, '287–301', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.4', 'Theorien als Klassen mathematischer Strukturen.', 'Suppes, Patrick: A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences. Synthese 12 (1960), S. 287–301.', 'Suppes [58]', 'Modelltheoretische Auffassung wissenschaftlicher Theorien.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(38, 59, 'tarski_truth_formalized_languages_1933_1956', 'book_chapter', 'The Concept of Truth in Formalized Languages', NULL, 1933, 1956, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, '152–278', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.4', 'Objekt- und Metasprache sowie Erfüllungsbedingungen.', 'Tarski, Alfred: The Concept of Truth in Formalized Languages. In: Logic, Semantics, Metamathematics. Oxford: Clarendon Press, 1956, S. 152–278.', 'Tarski [59]', 'Trennung formaler Systemebenen.', 9, '2026-07-26 15:54:32', '2026-07-26 15:54:32'),
(39, 60, 'mac_lane_mathematics_form_function_1986', 'book', 'Mathematics: Form and Function', NULL, 1986, 1986, NULL, 'Springer', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.5', 'Strukturorientierte Bestimmung mathematischer Gegenstände durch Beziehungen und Operationen.', 'Mac Lane, Saunders: Mathematics: Form and Function. New York: Springer, 1986.', 'Mac Lane, Mathematics: Form and Function [60]', 'Methodische Grundlage für die relationale Bestimmung funktionaler Zustände im FRZK.', 10, '2026-07-26 17:20:10', '2026-07-26 17:20:10'),
(40, 61, 'eilenberg_mac_lane_natural_equivalences_1945', 'journal_article', 'General Theory of Natural Equivalences', NULL, 1945, 1945, 'Transactions of the American Mathematical Society', NULL, NULL, '58', NULL, '231–294', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.5', 'Strukturerhaltende Abbildungen und natürliche Äquivalenzen als methodischer Bezugspunkt.', 'Eilenberg, Samuel; Mac Lane, Saunders: General Theory of Natural Equivalences. In: Transactions of the American Mathematical Society, Band 58, 1945, S. 231–294.', 'Eilenberg/Mac Lane, Natural Equivalences [61]', 'Methodischer Bezug für die Untersuchung strukturerhaltender Transformationen im FRZK; keine kategorientheoretische Rekonstruktion des FRZK.', 10, '2026-07-26 17:20:10', '2026-07-26 17:20:10'),
(41, 62, 'frege_grundlagen_arithmetik_1884', 'book', 'Die Grundlagen der Arithmetik', 'Eine logisch mathematische Untersuchung über den Begriff der Zahl', 1884, 1884, NULL, 'Wilhelm Koebner', 'Breslau', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.6', 'Logische und relationale Bestimmbarkeit mathematischer Bedeutung.', 'Frege, Gottlob: Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl. Breslau: Wilhelm Koebner, 1884.', 'Frege, Grundlagen der Arithmetik [62]', 'Quelle zur Abkehr von rein anschaulichen Objektvorstellungen in der Mathematik.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(42, 63, 'whitehead_process_reality_1929', 'book', 'Process and Reality', 'An Essay in Cosmology', 1929, 1929, NULL, 'Macmillan', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.6', 'Prozessontologie und Stabilität als Ergebnis wiederholter Prozesszusammenhänge.', 'Whitehead, Alfred North: Process and Reality. An Essay in Cosmology. New York: Macmillan, 1929.', 'Whitehead, Process and Reality [63]', 'Quelle zur Verschiebung von Substanz zu Prozess.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(43, 64, 'bertalanffy_general_system_theory_1968', 'book', 'General System Theory', 'Foundations, Development, Applications', 1968, 1968, NULL, 'George Braziller', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.6', 'Systeme als geordnete Ganzheiten mit wechselwirkenden Bestandteilen.', 'von Bertalanffy, Ludwig: General System Theory. Foundations, Development, Applications. New York: George Braziller, 1968.', 'Bertalanffy, General System Theory [64]', 'Grundlage der systemischen Organisationsperspektive.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(44, 65, 'wiener_cybernetics_1948', 'book', 'Cybernetics', 'Or Control and Communication in the Animal and the Machine', 1948, 1948, NULL, 'Hermann & Cie / MIT Press', 'Paris / Cambridge, MA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.6', 'Steuerung, Kommunikation und Rückkopplung in technischen und biologischen Systemen.', 'Wiener, Norbert: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann & Cie; Cambridge, MA: MIT Press, 1948.', 'Wiener, Cybernetics [65]', 'Quelle für Rückkopplung, Rekursion und funktionale Organisation.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(45, 66, 'ashby_introduction_cybernetics_1956', 'book', 'An Introduction to Cybernetics', NULL, 1956, 1956, NULL, 'Chapman & Hall', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.6', 'Zustandsübergänge und Regelungsprozesse als formale Systembeschreibung.', 'Ashby, W. Ross: An Introduction to Cybernetics. London: Chapman & Hall, 1956.', 'Ashby, Introduction to Cybernetics [66]', 'Quelle zur formalen Beschreibung von Zustandsübergängen.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(46, 67, 'resnik_mathematics_patterns_1997', 'book', 'Mathematics as a Science of Patterns', NULL, 1997, 1997, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.6', 'Mathematische Objekte als Positionen in Strukturen und Mustern.', 'Resnik, Michael D.: Mathematics as a Science of Patterns. Oxford: Clarendon Press, 1997.', 'Resnik, Mathematics as Patterns [67]', 'Quelle zum mathematischen Strukturalismus.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(47, 68, 'shapiro_structure_ontology_1997', 'book', 'Philosophy of Mathematics', 'Structure and Ontology', 1997, 1997, NULL, 'Oxford University Press', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.6', 'Mathematische Gegenstände als Stellen innerhalb von Strukturen.', 'Shapiro, Stewart: Philosophy of Mathematics. Structure and Ontology. New York: Oxford University Press, 1997.', 'Shapiro, Structure and Ontology [68]', 'Quelle zur strukturalistischen Bestimmung mathematischer Identität.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(48, 69, 'von_foerster_observing_systems_1981', 'book', 'Observing Systems', NULL, 1981, 1981, NULL, 'Intersystems Publications', 'Seaside, CA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.6', 'Beobachter als Bestandteil rekursiver Beschreibungszusammenhänge.', 'von Foerster, Heinz: Observing Systems. Seaside, CA: Intersystems Publications, 1981.', 'von Foerster, Observing Systems [69]', 'Quelle zur Kybernetik zweiter Ordnung und Beobachterabhängigkeit.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(49, 70, 'luhmann_soziale_systeme_1984', 'book', 'Soziale Systeme', 'Grundriß einer allgemeinen Theorie', 1984, 1984, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'verified', '3.1.6', 'Systembestand durch rekursiv anschließende Operationen statt dauerhafter Bestandteile.', 'Luhmann, Niklas: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984.', 'Luhmann, Soziale Systeme [70]', 'Quelle zur operativen Geschlossenheit und Anschlussfähigkeit.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06');

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
(1, 2, 1, 'editor'),
(1, 3, 2, 'editor'),
(2, 4, 1, 'author'),
(3, 5, 1, 'author'),
(4, 6, 1, 'author'),
(4, 7, 2, 'editor'),
(5, 8, 1, 'author'),
(6, 9, 1, 'author'),
(7, 10, 1, 'author'),
(7, 11, 2, 'editor'),
(7, 12, 3, 'editor'),
(8, 13, 1, 'author'),
(9, 14, 1, 'author'),
(10, 15, 1, 'author'),
(11, 16, 1, 'author'),
(12, 17, 1, 'author'),
(13, 16, 1, 'author'),
(14, 18, 1, 'author'),
(15, 19, 1, 'author'),
(16, 20, 1, 'author'),
(16, 21, 2, 'author'),
(17, 22, 1, 'author'),
(18, 23, 1, 'author'),
(19, 4, 1, 'author'),
(20, 24, 1, 'author'),
(21, 25, 1, 'author'),
(22, 26, 1, 'author'),
(24, 29, 1, 'author'),
(25, 30, 1, 'author'),
(26, 31, 1, 'author'),
(27, 32, 1, 'author'),
(28, 33, 1, 'author'),
(29, 34, 1, 'author'),
(30, 35, 1, 'author'),
(31, 36, 1, 'author'),
(32, 37, 1, 'author'),
(33, 38, 1, 'author'),
(34, 39, 1, 'author'),
(34, 38, 2, 'author'),
(35, 40, 1, 'author'),
(36, 41, 1, 'author'),
(37, 42, 1, 'author'),
(38, 43, 1, 'author'),
(39, 44, 1, 'author'),
(40, 45, 1, 'author'),
(40, 44, 2, 'author'),
(41, 46, 1, 'author'),
(42, 10, 1, 'author'),
(43, 47, 1, 'author'),
(44, 48, 1, 'author'),
(45, 49, 1, 'author'),
(46, 50, 1, 'author'),
(47, 51, 1, 'author'),
(48, 52, 1, 'author'),
(49, 53, 1, 'author');

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

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `source_topics`
--

CREATE TABLE `source_topics` (
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED NOT NULL,
  `relevance` tinyint(3) UNSIGNED NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, 4, 'first_citation', 'Parmenides dient als historische Grundlage für die Aussage, dass das Nichtseiende weder widerspruchsfrei gedacht noch sprachlich bestimmt werden kann.', 'Abschnitt 3.1.1, Absatz 3', 1, 1, 'Erstnennung der Quelle [4].', 2),
(2, 2, 4, 'first_citation', 'Weinberg stützt die Einordnung des quantenfeldtheoretischen Vakuums als definierten und strukturierten Grundzustand eines bereits vorausgesetzten formalen Systems.', 'Abschnitt 3.1.1, Absatz 4', 1, 1, 'Erstnennung der Quelle [5].', 2),
(3, 3, 4, 'first_citation', 'Halmos stützt die Abgrenzung der leeren Menge vom absoluten Nichts, da die leere Menge ein wohldefiniertes Objekt innerhalb einer Mengenlehre ist.', 'Abschnitt 3.1.1, Absatz 6', 1, 1, 'Erstnennung der Quelle [6].', 2),
(4, 4, 6, 'first_citation', 'Kant bestimmt Raum und Zeit als reine Formen der Anschauung und Bedingungen möglicher Erfahrung.', '3.1.2, Kant', 1, 1, 'Erstnennung als Quelle [13] in Abschnitt 3.1.2.', 4),
(5, 5, 6, 'first_citation', 'Hegel verbindet vollständige Bestimmungslosigkeit von Sein und Nichts mit dem Prozess des Werdens.', '3.1.2, Hegel', 1, 1, 'Erstnennung als Quelle [14] in Abschnitt 3.1.2.', 4),
(6, 6, 6, 'first_citation', 'Russell weist mehrstelligen Relationen einen eigenständigen formalen Status zu.', '3.1.2, Russell', 1, 1, 'Erstnennung als Quelle [15] in Abschnitt 3.1.2.', 4),
(7, 7, 6, 'first_citation', 'Whitehead begründet eine Prozessontologie, in der Ereignisse, Relationen und Werden gegenüber dauerhaften Substanzen vorrangig sind.', '3.1.2, Whitehead', 1, 1, 'Erstnennung als Quelle [16] in Abschnitt 3.1.2.', 4),
(8, 8, 6, 'first_citation', 'Bitbol begründet die erkenntnistheoretische Zurückhaltung gegenüber unmittelbaren ontologischen Schlüssen aus mathematischen Formalismen.', '3.1.2, Michel Bitbol', 1, 1, 'Quelle [25] bildet den erkenntnistheoretischen Abschluss der philosophischen Grundlagen.', 6),
(9, 9, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [26] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(10, 10, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [27] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(11, 11, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [28] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(12, 12, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [29] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(13, 13, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [30] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(14, 14, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [31] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(15, 15, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [32] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(16, 16, 7, 'first_citation', 'Erstverwendung der physikalischen Quelle [33] in Abschnitt 3.1.3.', '3.1.3 Teil 1', 1, 1, 'Physikalische Grundlagen, Teil 1.', 7),
(24, 17, 7, 'first_citation', 'Von Neumann formalisiert Zustände, Observablen und Operatoren im Hilbertraum.', '3.1.3 Teil 2', 1, 1, 'Erstverwendung in den physikalischen Grundlagen, Teil 2.', 8),
(25, 18, 7, 'first_citation', 'Dirac entwickelt eine abstrakte Zustands- und Operatorformulierung.', '3.1.3 Teil 2', 1, 1, 'Erstverwendung in den physikalischen Grundlagen, Teil 2.', 8),
(26, 19, 7, 'first_citation', 'Weinberg beschreibt relativistische Quantenfelder und Teilchen als Feldanregungen.', '3.1.3 Teil 2', 1, 1, 'Erstverwendung in den physikalischen Grundlagen, Teil 2.', 8),
(27, 20, 7, 'first_citation', 'DeWitt bezieht den geometrischen Hintergrund in die Quantisierung der Gravitation ein.', '3.1.3 Teil 2', 1, 1, 'Erstverwendung in den physikalischen Grundlagen, Teil 2.', 8),
(28, 21, 7, 'first_citation', 'Rovelli behandelt Raum als möglicherweise relational und quantisiert hervorgehend.', '3.1.3 Teil 2', 1, 1, 'Erstverwendung in den physikalischen Grundlagen, Teil 2.', 8),
(29, 22, 7, 'first_citation', 'Kiefer vergleicht Quantengravitationsprogramme und ihre empirischen Grenzen.', '3.1.3 Teil 2', 1, 1, 'Erstverwendung in den physikalischen Grundlagen, Teil 2.', 8),
(30, 6, 8, '', 'Kants Unterscheidung zwischen Erkenntnisbedingungen und Dingen an sich.', '3.1.4', 0, 1, 'Wiederverwendung.', 9),
(31, 24, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [45].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(32, 25, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [46].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(33, 26, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [47].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(34, 27, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [48].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(35, 28, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [49].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(36, 29, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [50].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(37, 30, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [51].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(38, 31, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [52].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(39, 32, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [53].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(40, 33, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [54].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(41, 34, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [55].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(42, 35, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [56].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(43, 36, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [57].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(44, 37, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [58].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(45, 38, 8, 'first_citation', 'Erstverwendung der erkenntnistheoretischen Quelle [59].', '3.1.4', 1, 1, 'Erstverwendung in den erkenntnistheoretischen Grundlagen.', 9),
(46, 39, 9, 'first_citation', 'Mathematische Objekte werden methodisch durch ihre Beziehungen, Operationen und ihre Stellung innerhalb einer Struktur bestimmt.', '3.1.5', 1, 1, 'Erstverwendung zur Begründung des methodologischen Grundsatzes M3.', 10),
(47, 40, 9, 'first_citation', 'Strukturerhaltende Abbildungen bilden einen methodischen Bezugspunkt für die Analyse funktionaler Transformationen und Invarianten.', '3.1.5', 1, 1, 'Erstverwendung zur Begründung des methodologischen Grundsatzes M4; das FRZK wird ausdrücklich nicht als kategorientheoretische Rekonstruktion ausgewiesen.', 10),
(49, 39, 10, '', 'Mac Lanes strukturorientierte Mathematik unterstützt den Vorrang von Formen, Funktionen und Transformationen.', '3.1.6', 0, 1, 'Bereits früher eingeführte Quelle; in Abschnitt 3.1.6 erneut verwendet.', 11),
(50, 40, 10, '', 'Eilenberg und Mac Lane begründen den methodischen Vorrang strukturerhaltender Abbildungen.', '3.1.6', 0, 1, 'Bereits früher eingeführte Quelle; in Abschnitt 3.1.6 erneut verwendet.', 11),
(52, 41, 10, 'first_citation', 'Mathematische Bedeutung kann logisch und relational bestimmt werden, ohne auf anschauliche Objektvorstellungen zurückzugreifen.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(53, 42, 10, 'first_citation', 'Stabilität kann als Ergebnis wiederholter Prozesszusammenhänge und nicht als ursprüngliche Substanz verstanden werden.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(54, 43, 10, 'first_citation', 'Systemeigenschaften entstehen wesentlich aus der Organisation von Wechselwirkungen.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(55, 44, 10, 'first_citation', 'Rückkopplung, Steuerung und Kommunikation begründen rekursive funktionale Organisation.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(56, 45, 10, 'first_citation', 'Zustandsübergänge ermöglichen eine formale Beschreibung von Veränderung ohne notwendige räumliche Bewegung.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(57, 46, 10, 'first_citation', 'Mathematische Objekte werden durch Positionen innerhalb von Strukturen und Mustern bestimmt.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(58, 47, 10, 'first_citation', 'Die Identität mathematischer Gegenstände entsteht durch ihre Stellung in einer Struktur.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(59, 48, 10, 'first_citation', 'Beobachter und Beschreibungssysteme können Teil rekursiver Wirkungszusammenhänge sein.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(60, 49, 10, 'first_citation', 'Systembestand kann durch die fortgesetzte Anschlussfähigkeit von Operationen erklärt werden.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11);

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
  MODIFY `acronym_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `annotations`
--
ALTER TABLE `annotations`
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT für Tabelle `axioms`
--
ALTER TABLE `axioms`
  MODIFY `axiom_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `axiom_dependencies`
--
ALTER TABLE `axiom_dependencies`
  MODIFY `axiom_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `citation_corrections`
--
ALTER TABLE `citation_corrections`
  MODIFY `correction_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `corollaries`
--
ALTER TABLE `corollaries`
  MODIFY `corollary_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `definitions`
--
ALTER TABLE `definitions`
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT für Tabelle `dissertation_tables`
--
ALTER TABLE `dissertation_tables`
  MODIFY `table_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `equations`
--
ALTER TABLE `equations`
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `figures`
--
ALTER TABLE `figures`
  MODIFY `figure_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `lemmas`
--
ALTER TABLE `lemmas`
  MODIFY `lemma_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `proof_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `propositions`
--
ALTER TABLE `propositions`
  MODIFY `proposition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `proposition_dependencies`
--
ALTER TABLE `proposition_dependencies`
  MODIFY `proposition_dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `repository_revisions`
--
ALTER TABLE `repository_revisions`
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `topics`
--
ALTER TABLE `topics`
  MODIFY `topic_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
