-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 17. Jul 2026 um 16:30
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
(1, 'Newton', 'Isaac', 'Newton, Isaac', NULL, 1643, 1727, 'Autor der Quelle [1].'),
(2, 'Einstein', 'Albert', 'Einstein, Albert', NULL, 1879, 1955, 'Autor der Quelle [2].'),
(3, 'Rovelli', 'Carlo', 'Rovelli, Carlo', NULL, 1956, NULL, 'Autor der Quelle [3].'),
(4, 'Parmenides', NULL, 'Parmenides', NULL, -515, -450, 'Antiker Autor der Fragmente in Quelle [4].'),
(5, 'Diels', 'Hermann', 'Diels, Hermann', NULL, 1848, 1922, 'Herausgeber der Fragmente der Vorsokratiker, Quelle [4].'),
(6, 'Kranz', 'Walther', 'Kranz, Walther', NULL, 1884, 1960, 'Bearbeiter und Herausgeber der Fragmente der Vorsokratiker, Quelle [4].'),
(7, 'Weinberg', 'Steven', 'Weinberg, Steven', NULL, 1933, 2021, 'Autor der Quelle [5].'),
(8, 'Halmos', 'Paul R.', 'Halmos, Paul R.', NULL, 1916, 2006, 'Autor der Quelle [6].'),
(9, 'Platon', NULL, 'Platon', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(10, 'Eigler', 'Gunther', 'Eigler, Gunther', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(11, 'Aristoteles', NULL, 'Aristoteles', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(12, 'Zekl', 'Hans Günter', 'Zekl, Hans Günter', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(13, 'Plotin', NULL, 'Plotin', NULL, 204, 270, 'Für Abschnitt 3.1.2 registriert.'),
(14, 'Harder', 'Richard', 'Harder, Richard', NULL, 1896, 1957, 'Für Abschnitt 3.1.2 registriert.'),
(15, 'Beutler', 'Rudolf', 'Beutler, Rudolf', NULL, 1911, 1975, 'Für Abschnitt 3.1.2 registriert.'),
(16, 'Theiler', 'Willy', 'Theiler, Willy', NULL, 1899, 1977, 'Für Abschnitt 3.1.2 registriert.'),
(17, 'Nikolaus von Kues', NULL, 'Nikolaus von Kues', NULL, 1401, 1464, 'Für Abschnitt 3.1.2 registriert.'),
(18, 'Wilpert', 'Paul', 'Wilpert, Paul', NULL, 1906, 1967, 'Für Abschnitt 3.1.2 registriert.'),
(19, 'Spinoza', 'Baruch de', 'Spinoza, Baruch de', NULL, 1632, 1677, 'Für Abschnitt 3.1.2 registriert.'),
(20, 'Bartuschat', 'Wolfgang', 'Bartuschat, Wolfgang', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(21, 'Leibniz', 'Gottfried Wilhelm', 'Leibniz, Gottfried Wilhelm', NULL, 1646, 1716, 'Für Abschnitt 3.1.2 registriert.'),
(22, 'Clarke', 'Samuel', 'Clarke, Samuel', NULL, 1675, 1729, 'Für Abschnitt 3.1.2 registriert.'),
(23, 'Alexander', 'H. G.', 'Alexander, H. G.', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(24, 'Kant', 'Immanuel', 'Kant, Immanuel', NULL, 1724, 1804, 'Für Abschnitt 3.1.2 registriert.'),
(25, 'Timmermann', 'Jens', 'Timmermann, Jens', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(26, 'Hegel', 'Georg Wilhelm Friedrich', 'Hegel, Georg Wilhelm Friedrich', NULL, 1770, 1831, 'Für Abschnitt 3.1.2 registriert.'),
(27, 'Russell', 'Bertrand', 'Russell, Bertrand', NULL, 1872, 1970, 'Für Abschnitt 3.1.2 registriert.'),
(28, 'Whitehead', 'Alfred North', 'Whitehead, Alfred North', NULL, 1861, 1947, 'Für Abschnitt 3.1.2 registriert.'),
(29, 'Griffin', 'David Ray', 'Griffin, David Ray', NULL, 1939, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(30, 'Sherburne', 'Donald W.', 'Sherburne, Donald W.', NULL, NULL, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(31, 'Husserl', 'Edmund', 'Husserl, Edmund', NULL, 1859, 1938, 'Für Abschnitt 3.1.2 registriert.'),
(32, 'Boehm', 'Rudolf', 'Boehm, Rudolf', NULL, 1927, 2019, 'Für Abschnitt 3.1.2 registriert.'),
(33, 'Cassirer', 'Ernst', 'Cassirer, Ernst', NULL, 1874, 1945, 'Für Abschnitt 3.1.2 registriert.'),
(34, 'Heidegger', 'Martin', 'Heidegger, Martin', NULL, 1889, 1976, 'Für Abschnitt 3.1.2 registriert.'),
(35, 'Wittgenstein', 'Ludwig', 'Wittgenstein, Ludwig', NULL, 1889, 1951, 'Für Abschnitt 3.1.2 registriert.'),
(36, 'Carnap', 'Rudolf', 'Carnap, Rudolf', NULL, 1891, 1970, 'Für Abschnitt 3.1.2 registriert.'),
(37, 'Spencer-Brown', 'George', 'Spencer-Brown, George', NULL, 1923, 2016, 'Für Abschnitt 3.1.2 registriert.'),
(38, 'Floridi', 'Luciano', 'Floridi, Luciano', NULL, 1964, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(39, 'Bitbol', 'Michel', 'Bitbol, Michel', NULL, 1954, NULL, 'Für Abschnitt 3.1.2 registriert.'),
(40, 'Mach', 'Ernst', 'Mach, Ernst', NULL, 1838, 1916, 'Für Abschnitt 3.1.3 registriert.'),
(41, 'Minkowski', 'Hermann', 'Minkowski, Hermann', NULL, 1864, 1909, 'Für Abschnitt 3.1.3 registriert.'),
(42, 'Weyl', 'Hermann', 'Weyl, Hermann', NULL, 1885, 1955, 'Für Abschnitt 3.1.3 registriert.'),
(43, 'Wald', 'Robert M.', 'Wald, Robert M.', NULL, 1947, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(44, 'Hawking', 'Stephen W.', 'Hawking, Stephen W.', NULL, 1942, 2018, 'Für Abschnitt 3.1.3 registriert.'),
(45, 'Ellis', 'George F. R.', 'Ellis, George F. R.', NULL, 1939, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(46, 'von Neumann', 'John', 'von Neumann, John', NULL, 1903, 1957, 'Für Abschnitt 3.1.3 registriert.'),
(47, 'Dirac', 'Paul A. M.', 'Dirac, Paul A. M.', NULL, 1902, 1984, 'Für Abschnitt 3.1.3 registriert.'),
(48, 'DeWitt', 'Bryce S.', 'DeWitt, Bryce S.', NULL, 1923, 2004, 'Für Abschnitt 3.1.3 registriert.'),
(49, 'Kiefer', 'Claus', 'Kiefer, Claus', NULL, 1958, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(50, 'Bombelli', 'Luca', 'Bombelli, Luca', NULL, NULL, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(51, 'Lee', 'Joohan', 'Lee, Joohan', NULL, NULL, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(52, 'Meyer', 'David', 'Meyer, David', NULL, NULL, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(53, 'Sorkin', 'Rafael D.', 'Sorkin, Rafael D.', NULL, 1945, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(54, 'Jacobson', 'Ted', 'Jacobson, Ted', NULL, 1954, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(55, 'Ryu', 'Shinsei', 'Ryu, Shinsei', NULL, NULL, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(56, 'Takayanagi', 'Tadashi', 'Takayanagi, Tadashi', NULL, 1975, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(57, 'Van Raamsdonk', 'Mark', 'Van Raamsdonk, Mark', NULL, NULL, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(58, 'Verlinde', 'Erik', 'Verlinde, Erik', NULL, 1962, NULL, 'Für Abschnitt 3.1.3 registriert.'),
(59, 'Helmholtz', 'Hermann von', 'Helmholtz, Hermann von', NULL, 1821, 1894, 'Für Abschnitt 3.1.4 registriert.'),
(60, 'Hanson', 'Norwood Russell', 'Hanson, Norwood Russell', NULL, 1924, 1967, 'Für Abschnitt 3.1.4 registriert.'),
(61, 'Kuhn', 'Thomas S.', 'Kuhn, Thomas S.', NULL, 1922, 1996, 'Für Abschnitt 3.1.4 registriert.'),
(62, 'Popper', 'Karl R.', 'Popper, Karl R.', NULL, 1902, 1994, 'Für Abschnitt 3.1.4 registriert.'),
(63, 'Lakatos', 'Imre', 'Lakatos, Imre', NULL, 1922, 1974, 'Für Abschnitt 3.1.4 registriert.'),
(64, 'Musgrave', 'Alan', 'Musgrave, Alan', NULL, 1940, NULL, 'Für Abschnitt 3.1.4 registriert.'),
(65, 'Quine', 'Willard Van Orman', 'Quine, Willard Van Orman', NULL, 1908, 2000, 'Für Abschnitt 3.1.4 registriert.'),
(66, 'Duhem', 'Pierre', 'Duhem, Pierre', NULL, 1861, 1916, 'Für Abschnitt 3.1.4 registriert.'),
(67, 'van Fraassen', 'Bas C.', 'van Fraassen, Bas C.', NULL, 1941, NULL, 'Für Abschnitt 3.1.4 registriert.'),
(68, 'Worrall', 'John', 'Worrall, John', NULL, 1946, NULL, 'Für Abschnitt 3.1.4 registriert.'),
(69, 'Ladyman', 'James', 'Ladyman, James', NULL, NULL, NULL, 'Für Abschnitt 3.1.4 registriert.'),
(70, 'French', 'Steven', 'French, Steven', NULL, NULL, NULL, 'Für Abschnitt 3.1.4 registriert.'),
(71, 'Hesse', 'Mary B.', 'Hesse, Mary B.', NULL, 1924, 2016, 'Für Abschnitt 3.1.4 registriert.'),
(72, 'Giere', 'Ronald N.', 'Giere, Ronald N.', NULL, 1938, 2020, 'Für Abschnitt 3.1.4 registriert.'),
(73, 'Suppes', 'Patrick', 'Suppes, Patrick', NULL, 1922, 2014, 'Für Abschnitt 3.1.4 registriert.'),
(74, 'Tarski', 'Alfred', 'Tarski, Alfred', NULL, 1901, 1983, 'Für Abschnitt 3.1.4 registriert.');

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
(1, NULL, '3', 'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen', 3, 3.0000, 'final', 0, 'Übergeordnete Kapitelüberschrift des vollständig neu aufgebauten Kapitels 3.', '2026-07-17 07:16:55', '2026-07-17 07:16:55'),
(2, 1, '3.1', 'Grundlagen der funktionalen Beschreibung von Raum und Zeit', 3, 3.1000, 'final', 0, 'Grundlagenabschnitt des vollständig neu aufgebauten Kapitels 3.', '2026-07-17 07:16:56', '2026-07-17 07:16:56'),
(3, 2, '3.1.0', 'Einleitung', 3, 3.1001, 'final', 0, 'Vollständige Neufassung. Der Abschnitt grenzt den funktionalen Ausgangspunkt des FRZK von klassischen und quantengravitativen Raum-Zeit-Konzeptionen ab.', '2026-07-17 07:16:56', '2026-07-17 07:16:56'),
(4, 2, '3.1.1', 'Das Nichts als mathematischer Ausgangspunkt', 3, 3.1100, 'final', 1, 'Vollständige Neufassung. Der Abschnitt grenzt das absolute Nichts von mathematisch und physikalisch strukturierten Formen der Leere ab und leitet funktionale Unterscheidbarkeit als minimale Voraussetzung mathematischer Beschreibung her.', '2026-07-17 07:17:13', '2026-07-17 07:17:13'),
(5, 2, '3.1.2', 'Philosophische Grundlagen', 3, 3.1200, 'final', 1, 'Vollständige Neufassung. Systematische Untersuchung philosophischer Begriffe von Sein, Nichtsein, Differenz, Relation, Prozess, Raum, Zeit, Erkenntnis und Information als Grundlage des FRZK.', '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(6, 2, '3.1.3', 'Physikalische Grundlagen', 3, 3.1300, 'final', 0, 'Analyse klassischer, relativistischer, quantenmechanischer und emergenter Raum-Zeit-Konzeptionen. Klare Trennung zwischen mathematischer Rekonstruktion und physikalischem Geltungsanspruch.', '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(7, 2, '3.1.4', 'Erkenntnistheoretische Grundlagen', 3, 3.1400, 'final', 0, 'Erkenntnistheoretische Abgrenzung von Konstruktion, Modell, Interpretation, empirischer Geltung und Ontologie.', '2026-07-17 11:19:14', '2026-07-17 11:19:14');

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
('next_citation_number', '56', '2026-07-17 11:19:14');

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
(1, 'RKB-NEU-K3.1.0-V1', '2026-07-17 09:16:55', 'section', '3.1.0', '1.0', 'Neubeginn des FRZK-Repositories: Aufnahme der Kapitelüberschrift 3, der Abschnittsüberschrift 3.1 und des vollständig neu entwickelten Abschnitts 3.1.0 Einleitung einschließlich der erstmals verwendeten Quellen [1] bis [3].', 'Olaf Thiele / ChatGPT', NULL),
(2, 'RKB-NEU-K3.1.1-V1', '2026-07-17 09:17:12', 'section', '3.1.1', '1.0', 'Vollständige Neufassung von Abschnitt 3.1.1 Das Nichts als mathematischer Ausgangspunkt. Aufnahme der erstmals verwendeten Quellen [4] bis [6] und ihrer Verwendungen.', 'Olaf Thiele / ChatGPT', 1),
(3, 'RKB-NEU-K3.1.2-V1', '2026-07-17 09:17:37', 'section', '3.1.2', '1.0', 'Vollständige Neufassung von Abschnitt 3.1.2 Philosophische Grundlagen. Aufnahme der erstmals verwendeten Quellen [7] bis [25] einschließlich Autoren-, Herausgeber- und Übersetzerrollen.', 'Olaf Thiele / ChatGPT', 2),
(4, 'RKB-NEU-K3.1.3-V1', '2026-07-17 12:57:01', 'section', '3.1.3', '1.0', 'Vollständige Neufassung von Abschnitt 3.1.3 Physikalische Grundlagen. Wiederverwendung der Quellen [1], [2], [3] und [5] sowie Aufnahme der neuen Quellen [26] bis [40].', 'Olaf Thiele / ChatGPT', 3),
(5, 'RKB-NEU-K3.1.4-V1', '2026-07-17 13:19:14', 'section', '3.1.4', '1.0', 'Vollständige Neufassung von Abschnitt 3.1.4. Wiederverwendung von [13], [18], [22] und Aufnahme von [41] bis [55].', 'Olaf Thiele / ChatGPT', 4);

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
(1, 1, 1, 'created', 'section', '3', 'Kapitelüberschrift 3 neu angelegt.', NULL, 'Funktionales Raum-Zeit-Kohärenzsystem – Theoretische Grundlagen', '2026-07-17 07:16:56'),
(2, 1, 2, 'created', 'section', '3.1', 'Abschnittsüberschrift 3.1 neu angelegt.', NULL, 'Grundlagen der funktionalen Beschreibung von Raum und Zeit', '2026-07-17 07:16:56'),
(3, 1, 3, 'created', 'section', '3.1.0', 'Abschnitt 3.1.0 vollständig neu erstellt und repositoryseitig abgeschlossen.', NULL, 'Einleitung einschließlich Quellen [1] bis [3]', '2026-07-17 07:16:56'),
(4, 1, 3, 'source_added', 'source', '[1]–[3]', 'Drei erstmals zitierte Grundlagenquellen aufgenommen und mit Abschnitt 3.1.0 verknüpft.', NULL, 'Newton (1687), Einstein (1916), Rovelli (2004)', '2026-07-17 07:16:56'),
(5, 1, 3, 'status_changed', 'section', '3.1.0', 'Bearbeitungsstatus des Abschnitts auf final gesetzt.', 'draft', 'final', '2026-07-17 07:16:56'),
(6, 2, 4, 'created', 'section', '3.1.1', 'Abschnitt 3.1.1 vollständig neu erstellt und repositoryseitig abgeschlossen.', NULL, 'Das Nichts als mathematischer Ausgangspunkt', '2026-07-17 07:17:13'),
(7, 2, 4, 'source_added', 'sources', '[4]–[6]', 'Drei erstmals zitierte Quellen aufgenommen und mit Abschnitt 3.1.1 verknüpft.', NULL, 'Parmenides/Diels/Kranz (1951), Weinberg (1995), Halmos (1974)', '2026-07-17 07:17:13'),
(8, 2, 4, 'other', 'conceptual_result', 'funktionale Unterscheidbarkeit', 'Zentrales Arbeitsergebnis des Abschnitts dokumentiert: Ein absolutes Nichts ist mathematisch unzugänglich; minimale Beschreibung setzt funktionale Unterscheidbarkeit voraus.', NULL, 'Vorbereitende konzeptionelle Grundlage; noch keine formale Definition und kein Axiom.', '2026-07-17 07:17:13'),
(9, 2, 4, 'status_changed', 'section', '3.1.1', 'Bearbeitungsstatus des Abschnitts auf final gesetzt.', 'draft', 'final', '2026-07-17 07:17:13'),
(10, 3, 5, 'created', 'section', '3.1.2', 'Abschnitt 3.1.2 vollständig neu erstellt und repositoryseitig abgeschlossen.', NULL, 'Philosophische Grundlagen', '2026-07-17 07:17:38'),
(11, 3, 5, 'source_added', 'sources', '[7]–[25]', 'Neunzehn erstmals zitierte Quellen aufgenommen und mit Abschnitt 3.1.2 verknüpft.', NULL, 'Quellen [7]–[25]', '2026-07-17 07:17:38'),
(12, 3, 5, 'other', 'conceptual_result', 'philosophische Arbeitsprinzipien', 'Vier Arbeitsprinzipien dokumentiert: minimale Unterscheidbarkeit; Vorrang von Relationen und Prozessen; Trennung von Konstruktion, Erkenntnis und Ontologie; rekonstruierbare Raum- und Zeitordnungen.', NULL, 'Konzeptionelle Grundlage, noch keine formale Definition und kein Axiom.', '2026-07-17 07:17:38'),
(13, 3, 5, 'status_changed', 'section', '3.1.2', 'Bearbeitungsstatus des Abschnitts auf final gesetzt.', 'draft', 'final', '2026-07-17 07:17:38'),
(14, 4, 6, 'created', 'section', '3.1.3', 'Abschnitt 3.1.3 vollständig neu erstellt.', NULL, 'Physikalische Grundlagen', '2026-07-17 10:57:01'),
(15, 4, 6, 'source_reused', 'source', '[1], [2], [3], [5]', 'Vier bereits vorhandene Grundlagenquellen wurden korrekt wiederverwendet.', NULL, 'Newton [1], Einstein 1916 [2], Rovelli [3], Weinberg [5]', '2026-07-17 10:57:01'),
(16, 4, 6, 'source_added', 'source', '[26]–[40]', 'Fünfzehn neue physikalische Quellen wurden aufgenommen.', NULL, 'Neue Quellen [26] bis [40]', '2026-07-17 10:57:01'),
(17, 4, 6, 'status_changed', 'section', '3.1.3', 'Bearbeitungsstatus auf final gesetzt.', 'draft', 'final', '2026-07-17 10:57:01'),
(18, 5, 7, 'created', 'section', '3.1.4', 'Abschnitt 3.1.4 vollständig neu erstellt.', NULL, 'Erkenntnistheoretische Grundlagen', '2026-07-17 11:19:14'),
(19, 5, 7, 'source_reused', 'source', '[13], [18], [22]', 'Drei bereits vorhandene Quellen wurden wiederverwendet.', NULL, 'Kant [13], Cassirer [18], Carnap [22]', '2026-07-17 11:19:14'),
(20, 5, 7, 'source_added', 'source', '[41]–[55]', 'Fünfzehn neue Quellen wurden aufgenommen.', NULL, 'Quellen [41] bis [55]', '2026-07-17 11:19:14'),
(21, 5, 7, 'other', 'conceptual_result', 'erkenntnistheoretische Grundsätze', 'Sechs Grundsätze zur Trennung von Konstruktion, Modell, Interpretation, empirischer Geltung und Ontologie dokumentiert.', NULL, 'Methodisch-strukturalistische und empirisch anschlussfähige Grundposition', '2026-07-17 11:19:14'),
(22, 5, 7, 'status_changed', 'section', '3.1.4', 'Bearbeitungsstatus auf final gesetzt.', 'draft', 'final', '2026-07-17 11:19:14');

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
(1, 1, 'newton_principia_1687', 'historical_work', 'Philosophiæ Naturalis Principia Mathematica', NULL, 1687, 1687, NULL, 'Joseph Streater', 'London', NULL, NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'la', 1, 'historical', 7, 'verified', '3.1.0', 'Erstnennung zur klassischen Konzeption von absolutem Raum und absoluter Zeit.', 'Newton, Isaac (1687): Philosophiæ Naturalis Principia Mathematica. London: Joseph Streater.', 'Newton (1687)', 'Historische Primärquelle zur klassischen Mechanik und zur absoluten Raum-Zeit-Konzeption.', 1, '2026-07-17 07:16:56', '2026-07-17 07:16:56'),
(2, 2, 'einstein_allgemeine_relativitaetstheorie_1916', 'journal_article', 'Die Grundlage der allgemeinen Relativitätstheorie', NULL, 1916, 1916, 'Annalen der Physik', 'Johann Ambrosius Barth', 'Leipzig', '354', '7', '769–822', NULL, '10.1002/andp.19163540702', NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.0', 'Erstnennung zur dynamischen geometrischen Beschreibung der Raumzeit.', 'Einstein, Albert (1916): Die Grundlage der allgemeinen Relativitätstheorie. In: Annalen der Physik, Bd. 354, Nr. 7, S. 769–822. DOI: 10.1002/andp.19163540702.', 'Einstein (1916)', 'Primärquelle zur Allgemeinen Relativitätstheorie.', 1, '2026-07-17 07:16:56', '2026-07-17 07:16:56'),
(3, 3, 'rovelli_quantum_gravity_2004', 'book', 'Quantum Gravity', NULL, 2004, 2004, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, '1', NULL, '978-0-521-83733-0', NULL, 'en', 1, 'textbook', 9, 'verified', '3.1.0', 'Erstnennung zur Quantengravitation und zur möglichen Emergenz von Raum und Zeit.', 'Rovelli, Carlo (2004): Quantum Gravity. Cambridge: Cambridge University Press. ISBN 978-0-521-83733-0.', 'Rovelli (2004)', 'Grundlegende Monografie zur Schleifenquantengravitation.', 1, '2026-07-17 07:16:56', '2026-07-17 07:16:56'),
(4, 4, 'parmenides_fragmente_diels_kranz_1951', 'historical_work', 'Die Fragmente der Vorsokratiker', 'Griechisch und deutsch, Band 1; Fragmente 28 B2, B3 und B6', NULL, 1951, NULL, 'Weidmann', 'Berlin', '1', NULL, NULL, '6. Auflage', NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.1', 'Erstnennung zur philosophischen Unzugänglichkeit des Nichtseins und zur Bindung von Denken, Sagen und Sein.', 'Parmenides: Fragmente 28 B2, B3 und B6. In: Diels, Hermann; Kranz, Walther (Hrsg.) (1951): Die Fragmente der Vorsokratiker. Griechisch und deutsch. Band 1. 6. Auflage. Berlin: Weidmann.', 'Parmenides, Fragmente 28 B2, B3 und B6 [4]', 'Historische Primärüberlieferung in der maßgeblichen Edition von Diels und Kranz.', 2, '2026-07-17 07:17:13', '2026-07-17 07:17:13'),
(5, 5, 'weinberg_quantum_fields_vol1_1995', 'book', 'The Quantum Theory of Fields', 'Volume I: Foundations', 1995, 1995, NULL, 'Cambridge University Press', 'Cambridge', 'I', NULL, NULL, '1', NULL, '978-0-521-55001-7', NULL, 'en', 1, 'textbook', 8, 'verified', '3.1.1', 'Erstnennung zur Einordnung des quantenfeldtheoretischen Vakuums als strukturierter Grundzustand eines vorausgesetzten formalen Systems.', 'Weinberg, Steven (1995): The Quantum Theory of Fields. Volume I: Foundations. Cambridge: Cambridge University Press.', 'Weinberg (1995) [5]', 'Grundlegende Darstellung der Quantenfeldtheorie; im Abschnitt insbesondere für den Zustands- und Vakuumbegriff verwendet.', 2, '2026-07-17 07:17:13', '2026-07-17 07:17:13'),
(6, 6, 'halmos_naive_set_theory_1974', 'book', 'Naive Set Theory', NULL, 1960, 1974, NULL, 'Springer-Verlag', 'New York', NULL, NULL, '1–12', 'Reprint', NULL, '978-0-387-90092-6', NULL, 'en', 1, 'textbook', 8, 'verified', '3.1.1', 'Erstnennung zur leeren Menge als wohldefiniertem mathematischem Objekt innerhalb einer bereits vorausgesetzten Mengenstruktur.', 'Halmos, Paul R. (1974): Naive Set Theory. New York: Springer-Verlag, insbesondere S. 1–12.', 'Halmos (1974) [6]', 'Referenzwerk zur elementaren Mengenlehre und zur begrifflichen Stellung der leeren Menge.', 2, '2026-07-17 07:17:13', '2026-07-17 07:17:13'),
(7, 7, 'platon_sophistes_eigler_1990', 'historical_work', 'Sophistes', 'In: Werke in acht Bänden, griechisch und deutsch, Band 6', NULL, 1990, NULL, 'Wissenschaftliche Buchgesellschaft', 'Darmstadt', '6', NULL, '254d–259d', NULL, NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.2', 'Erstnennung zur Bestimmung des Nichtseins als Andersheit und zur relationalen Fassung von Verschiedenheit.', 'Platon: Sophistes. In: Platon, Werke in acht Bänden, griechisch und deutsch. Herausgegeben von Gunther Eigler. Band 6. Darmstadt: Wissenschaftliche Buchgesellschaft, 1990, insbesondere 254d–259d.', 'Platon, Sophistes [7]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(8, 8, 'aristoteles_physikvorlesung_zekl_1987', 'historical_work', 'Physikvorlesung', 'Bücher IV und VI', NULL, 1987, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.2', 'Erstnennung zu Ort, Bewegung sowie Zeit als Zahl beziehungsweise Maß der Bewegung hinsichtlich des Früher und Später.', 'Aristoteles: Physikvorlesung. Übersetzt von Hans Günter Zekl. Hamburg: Felix Meiner Verlag, 1987, Bücher IV und VI.', 'Aristoteles, Physikvorlesung [8]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(9, 9, 'plotin_schriften_harder_1956_1960', 'historical_work', 'Schriften', 'Griechisch-deutsch; insbesondere Enneaden V.1 und V.2', NULL, 1960, NULL, 'Felix Meiner Verlag', 'Hamburg', 'I–V', NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 7, 'verified', '3.1.2', 'Erstnennung zur neuplatonischen Hervorbringung geordneter Vielheit aus dem Einen.', 'Plotin: Schriften. Griechisch-deutsch. Übersetzt von Richard Harder; Neubearbeitung fortgeführt von Rudolf Beutler und Willy Theiler. Bände I–V. Hamburg: Felix Meiner Verlag, 1956–1960, insbesondere Enneaden V.1 und V.2.', 'Plotin, Schriften [9]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(10, 10, 'cusanus_de_docta_ignorantia_wilpert_1994', 'historical_work', 'De docta ignorantia – Die belehrte Unwissenheit', 'Lateinisch-deutsch', 1440, 1994, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 7, 'verified', '3.1.2', 'Erstnennung zur coincidentia oppositorum und zur erkenntnistheoretischen Begrenztheit bestimmender Begriffe.', 'Nikolaus von Kues: De docta ignorantia – Die belehrte Unwissenheit. Lateinisch-deutsch. Übersetzt und herausgegeben von Paul Wilpert. Hamburg: Felix Meiner Verlag, 1994.', 'Nikolaus von Kues [10]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(11, 11, 'spinoza_ethik_bartuschat_2015', 'historical_work', 'Ethik in geometrischer Ordnung dargestellt', 'Lateinisch-deutsch', 1677, 2015, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 7, 'verified', '3.1.2', 'Erstnennung zur immanenten Ordnung von Substanz, Attributen und Modi sowie zur geometrischen Darstellungsweise.', 'Spinoza, Baruch de: Ethik in geometrischer Ordnung dargestellt. Lateinisch-deutsch. Übersetzt und herausgegeben von Wolfgang Bartuschat. Hamburg: Felix Meiner Verlag, 2015.', 'Spinoza, Ethik [11]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(12, 12, 'leibniz_clarke_correspondence_alexander_1956', 'book', 'The Leibniz–Clarke Correspondence', 'Insbesondere Leibniz’ dritte bis fünfte Schreiben', 1717, 1956, NULL, 'Manchester University Press', 'Manchester', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'historical', 9, 'verified', '3.1.2', 'Erstnennung zur relationalen Auffassung von Raum als Ordnung des Zugleichseins und Zeit als Ordnung des Nacheinanders.', 'Leibniz, Gottfried Wilhelm; Clarke, Samuel: The Leibniz–Clarke Correspondence. Herausgegeben von H. G. Alexander. Manchester: Manchester University Press, 1956, insbesondere Leibniz’ dritte bis fünfte Schreiben.', 'Leibniz–Clarke [12]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(13, 13, 'kant_kritik_reinen_vernunft_timmermann_1998', 'historical_work', 'Kritik der reinen Vernunft', 'Insbesondere A19/B33–A49/B73', 1781, 1998, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.2', 'Erstnennung zu Raum und Zeit als reinen Formen der sinnlichen Anschauung und Bedingungen möglicher Erfahrung.', 'Kant, Immanuel: Kritik der reinen Vernunft. Herausgegeben von Jens Timmermann. Hamburg: Felix Meiner Verlag, 1998, insbesondere A19/B33–A49/B73.', 'Kant, Kritik der reinen Vernunft [13]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(14, 14, 'hegel_wissenschaft_logik_1986', 'historical_work', 'Wissenschaft der Logik I', 'Werke, Band 5; Sein, Nichts und Werden', 1812, 1986, NULL, 'Suhrkamp', 'Frankfurt am Main', '5', NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 8, 'verified', '3.1.2', 'Erstnennung zur dialektischen Vermittlung von Sein, Nichts und Werden sowie zur Bestimmung durch Negation.', 'Hegel, Georg Wilhelm Friedrich: Wissenschaft der Logik I. Werke, Band 5. Frankfurt am Main: Suhrkamp, 1986, insbesondere „Sein“, „Nichts“ und „Werden“.', 'Hegel, Wissenschaft der Logik I [14]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(15, 15, 'russell_principles_mathematics_1903', 'book', 'The Principles of Mathematics', NULL, 1903, 1903, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 8, 'verified', '3.1.2', 'Erstnennung zur formalen Eigenständigkeit mehrstelliger Relationen in der modernen Logik.', 'Russell, Bertrand: The Principles of Mathematics. Cambridge: Cambridge University Press, 1903.', 'Russell (1903) [15]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(16, 16, 'whitehead_process_reality_1978', 'book', 'Process and Reality', 'An Essay in Cosmology', 1929, 1978, NULL, 'Free Press', 'New York', NULL, NULL, NULL, 'Corrected edition', NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.2', 'Erstnennung zur Prozessontologie und zum Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaften Substanzen.', 'Whitehead, Alfred North: Process and Reality. An Essay in Cosmology. Corrected edition. Herausgegeben von David Ray Griffin und Donald W. Sherburne. New York: Free Press, 1978.', 'Whitehead, Process and Reality [16]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(17, 17, 'husserl_inneres_zeitbewusstsein_hua10_1966', 'book', 'Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917)', 'Husserliana, Band X', 1917, 1966, NULL, 'Martinus Nijhoff', 'Den Haag', 'X', NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'verified', '3.1.2', 'Erstnennung zur zeitlichen Bewusstseinsstruktur aus Urimpression, Retention und Protention.', 'Husserl, Edmund: Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917). Husserliana, Band X. Herausgegeben von Rudolf Boehm. Den Haag: Martinus Nijhoff, 1966.', 'Husserl, Zeitbewusstsein [17]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(18, 18, 'cassirer_substanzbegriff_funktionsbegriff_1910', 'book', 'Substanzbegriff und Funktionsbegriff', 'Untersuchungen über die Grundfragen der Erkenntniskritik', 1910, 1910, NULL, 'Bruno Cassirer', 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.2', 'Erstnennung zum wissenschaftstheoretischen Übergang vom Substanzbegriff zum Funktions- und Relationsbegriff.', 'Cassirer, Ernst: Substanzbegriff und Funktionsbegriff. Untersuchungen über die Grundfragen der Erkenntniskritik. Berlin: Bruno Cassirer, 1910.', 'Cassirer (1910) [18]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(19, 19, 'heidegger_sein_zeit_2006', 'book', 'Sein und Zeit', 'Insbesondere §§ 65–71', 1927, 2006, NULL, 'Max Niemeyer Verlag', 'Tübingen', NULL, NULL, NULL, '19. Auflage', NULL, NULL, NULL, 'de', 1, 'primary', 7, 'verified', '3.1.2', 'Erstnennung zur Kritik der Zeit als bloßer Abfolge von Jetztpunkten und zur existenzialen Zeitlichkeit.', 'Heidegger, Martin: Sein und Zeit. 19. Auflage. Tübingen: Max Niemeyer Verlag, 2006, insbesondere §§ 65–71.', 'Heidegger, Sein und Zeit [19]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(20, 20, 'wittgenstein_tractatus_1963', 'book', 'Tractatus logico-philosophicus', NULL, 1921, 1963, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 7, 'verified', '3.1.2', 'Erstnennung zur Welt als Gesamtheit von Tatsachen und zur logischen Struktur sinnvoller Aussagen.', 'Wittgenstein, Ludwig: Tractatus logico-philosophicus. Frankfurt am Main: Suhrkamp, 1963.', 'Wittgenstein, Tractatus [20]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(21, 21, 'wittgenstein_philosophische_untersuchungen_2003', 'book', 'Philosophische Untersuchungen', NULL, 1953, 2003, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 7, 'verified', '3.1.2', 'Erstnennung zur Bedeutung als regelgeleitetem Gebrauch innerhalb von Sprachspielen.', 'Wittgenstein, Ludwig: Philosophische Untersuchungen. Frankfurt am Main: Suhrkamp, 2003.', 'Wittgenstein, Philosophische Untersuchungen [21]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(22, 22, 'carnap_logischer_aufbau_1998', 'book', 'Der logische Aufbau der Welt', NULL, 1928, 1998, NULL, 'Felix Meiner Verlag', 'Hamburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.2', 'Erstnennung zum konstruktiven Aufbau wissenschaftlicher Begriffe aus einer begrenzten Basis und expliziten Konstruktionsregeln.', 'Carnap, Rudolf: Der logische Aufbau der Welt. Hamburg: Felix Meiner Verlag, 1998. Erstveröffentlichung 1928.', 'Carnap, Logischer Aufbau [22]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(23, 23, 'spencer_brown_laws_form_1969', 'book', 'Laws of Form', NULL, 1969, 1969, NULL, 'George Allen & Unwin', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.2', 'Erstnennung zur Unterscheidung als elementarer Operation der Formbildung.', 'Spencer-Brown, George: Laws of Form. London: George Allen & Unwin, 1969.', 'Spencer-Brown (1969) [23]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(24, 24, 'floridi_philosophy_information_2011', 'book', 'The Philosophy of Information', NULL, 2011, 2011, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.2', 'Erstnennung zur philosophischen Analyse informationeller Strukturen, Unterschiede und Relationen.', 'Floridi, Luciano: The Philosophy of Information. Oxford: Oxford University Press, 2011.', 'Floridi (2011) [24]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(25, 25, 'bitbol_reflective_metaphysics_2021', 'book', 'Reflective Metaphysics', 'Understanding Quantum Mechanics from a Kantian Standpoint', 2021, 2021, NULL, 'Springer', 'Cham', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 8, 'verified', '3.1.2', 'Erstnennung zur erkenntnistheoretischen Zurückhaltung gegenüber unmittelbaren ontologischen Schlüssen aus physikalischen Formalismen.', 'Bitbol, Michel: Reflective Metaphysics. Understanding Quantum Mechanics from a Kantian Standpoint. Cham: Springer, 2021.', 'Bitbol (2021) [25]', 'Primär- oder maßgebliche Werkausgabe für die philosophische Grundlegung des FRZK.', 3, '2026-07-17 07:17:37', '2026-07-17 07:17:37'),
(26, 26, 'mach_mechanik_1883', 'historical_work', 'Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt', NULL, 1883, 1883, NULL, 'F. A. Brockhaus', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 9, 'verified', '3.1.3', 'Erstnennung zur relationalen Kritik des absoluten Raumes.', 'Mach, Ernst: Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt. Leipzig: F. A. Brockhaus, 1883.', 'Mach, Mechanik [26]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(27, 27, 'einstein_elektrodynamik_1905', 'journal_article', 'Zur Elektrodynamik bewegter Körper', NULL, 1905, 1905, 'Annalen der Physik', NULL, NULL, '17', NULL, '891–921', NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zur Speziellen Relativitätstheorie und Relativität der Gleichzeitigkeit.', 'Einstein, Albert: Zur Elektrodynamik bewegter Körper. In: Annalen der Physik, Band 17, 1905, S. 891–921.', 'Einstein (1905) [27]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(28, 28, 'minkowski_raum_zeit_1909', 'historical_work', 'Raum und Zeit', NULL, 1908, 1909, NULL, 'B. G. Teubner', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 10, 'verified', '3.1.3', 'Erstnennung zur vierdimensionalen Zusammenführung von Raum und Zeit.', 'Minkowski, Hermann: Raum und Zeit. Leipzig: B. G. Teubner, 1909.', 'Minkowski, Raum und Zeit [28]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(29, 29, 'weyl_raum_zeit_materie_1923', 'book', 'Raum – Zeit – Materie', 'Vorlesungen über allgemeine Relativitätstheorie', 1918, 1923, NULL, 'Springer', 'Berlin', NULL, NULL, NULL, '5. Auflage', NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.3', 'Erstnennung zur Verbindung von Geometrie, Materie und Feldstrukturen.', 'Weyl, Hermann: Raum – Zeit – Materie. Vorlesungen über allgemeine Relativitätstheorie. 5. Auflage. Berlin: Springer, 1923.', 'Weyl, Raum – Zeit – Materie [29]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(30, 30, 'wald_general_relativity_1984', 'book', 'General Relativity', NULL, 1984, 1984, NULL, 'University of Chicago Press', 'Chicago', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'textbook', 9, 'verified', '3.1.3', 'Erstnennung zur mathematischen Struktur der Allgemeinen Relativitätstheorie.', 'Wald, Robert M.: General Relativity. Chicago: University of Chicago Press, 1984.', 'Wald (1984) [30]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(31, 31, 'hawking_ellis_large_scale_1973', 'book', 'The Large Scale Structure of Space-Time', NULL, 1973, 1973, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.3', 'Erstnennung zu Raumzeitstruktur, geodätischer Unvollständigkeit und Singularitätssätzen.', 'Hawking, Stephen W.; Ellis, George F. R.: The Large Scale Structure of Space-Time. Cambridge: Cambridge University Press, 1973.', 'Hawking und Ellis [31]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(32, 32, 'von_neumann_quantenmechanik_1932', 'book', 'Mathematische Grundlagen der Quantenmechanik', NULL, 1932, 1932, NULL, 'Julius Springer', 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zur Hilbertraumformulierung der Quantenmechanik.', 'von Neumann, John: Mathematische Grundlagen der Quantenmechanik. Berlin: Julius Springer, 1932.', 'von Neumann (1932) [32]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(33, 33, 'dirac_principles_quantum_mechanics_1930', 'book', 'The Principles of Quantum Mechanics', NULL, 1930, 1930, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, NULL, '1st edition', NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zur abstrakten Zustands- und Operatorformulierung der Quantenmechanik.', 'Dirac, Paul A. M.: The Principles of Quantum Mechanics. Oxford: Clarendon Press, 1930.', 'Dirac (1930) [33]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(34, 34, 'dewitt_quantum_gravity_canonical_1967', 'journal_article', 'Quantum Theory of Gravity. I. The Canonical Theory', NULL, 1967, 1967, 'Physical Review', NULL, NULL, '160', NULL, '1113–1148', NULL, '10.1103/PhysRev.160.1113', NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zur kanonischen Quantisierung der Gravitation.', 'DeWitt, Bryce S.: Quantum Theory of Gravity. I. The Canonical Theory. In: Physical Review, Band 160, 1967, S. 1113–1148.', 'DeWitt (1967) [34]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(35, 35, 'kiefer_quantum_gravity_2012', 'book', 'Quantum Gravity', NULL, 2004, 2012, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, '3rd edition', NULL, NULL, NULL, 'en', 1, 'textbook', 9, 'verified', '3.1.3', 'Erstnennung zur vergleichenden Darstellung quantengravitativer Ansätze.', 'Kiefer, Claus: Quantum Gravity. 3. Auflage. Oxford: Oxford University Press, 2012.', 'Kiefer (2012) [35]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(36, 36, 'bombelli_lee_meyer_sorkin_causal_set_1987', 'journal_article', 'Space-Time as a Causal Set', NULL, 1987, 1987, 'Physical Review Letters', NULL, NULL, '59', NULL, '521–524', NULL, '10.1103/PhysRevLett.59.521', NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zur diskreten kausalen Ordnung als möglicher Grundlage kontinuierlicher Raumzeit.', 'Bombelli, Luca; Lee, Joohan; Meyer, David; Sorkin, Rafael D.: Space-Time as a Causal Set. In: Physical Review Letters, Band 59, 1987, S. 521–524.', 'Bombelli et al. (1987) [36]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(37, 37, 'jacobson_thermodynamics_spacetime_1995', 'journal_article', 'Thermodynamics of Spacetime: The Einstein Equation of State', NULL, 1995, 1995, 'Physical Review Letters', NULL, NULL, '75', NULL, '1260–1263', NULL, '10.1103/PhysRevLett.75.1260', NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zur thermodynamischen Herleitung der Einstein-Gleichung.', 'Jacobson, Ted: Thermodynamics of Spacetime: The Einstein Equation of State. In: Physical Review Letters, Band 75, 1995, S. 1260–1263.', 'Jacobson (1995) [37]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(38, 38, 'ryu_takayanagi_holographic_entanglement_2006', 'journal_article', 'Holographic Derivation of Entanglement Entropy from AdS/CFT', NULL, 2006, 2006, 'Physical Review Letters', NULL, NULL, '96', NULL, '181602', NULL, '10.1103/PhysRevLett.96.181602', NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zum Zusammenhang von Verschränkungsentropie und Geometrie.', 'Ryu, Shinsei; Takayanagi, Tadashi: Holographic Derivation of Entanglement Entropy from AdS/CFT. In: Physical Review Letters, Band 96, 2006, Artikel 181602.', 'Ryu und Takayanagi [38]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(39, 39, 'van_raamsdonk_building_spacetime_2010', 'journal_article', 'Building up Spacetime with Quantum Entanglement', NULL, 2010, 2010, 'General Relativity and Gravitation', NULL, NULL, '42', NULL, '2323–2329', NULL, '10.1007/s10714-010-1034-0', NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.3', 'Erstnennung zum Zusammenhang zwischen Raumzeitzusammenhang und Verschränkungsstruktur.', 'Van Raamsdonk, Mark: Building up Spacetime with Quantum Entanglement. In: General Relativity and Gravitation, Band 42, 2010, S. 2323–2329.', 'Van Raamsdonk (2010) [39]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(40, 40, 'verlinde_origin_gravity_2011', 'journal_article', 'On the Origin of Gravity and the Laws of Newton', NULL, 2011, 2011, 'Journal of High Energy Physics', NULL, NULL, NULL, '04', '029', NULL, '10.1007/JHEP04(2011)029', NULL, NULL, 'en', 1, 'primary', 8, 'verified', '3.1.3', 'Erstnennung zur entropischen und informationellen Interpretation von Gravitation.', 'Verlinde, Erik: On the Origin of Gravity and the Laws of Newton. In: Journal of High Energy Physics, Ausgabe 04, 2011, Artikel 029.', 'Verlinde (2011) [40]', 'Quelle für Abschnitt 3.1.3.', 4, '2026-07-17 10:57:01', '2026-07-17 10:57:01'),
(41, 41, 'helmholtz_physiologische_optik_1867', 'book', 'Handbuch der physiologischen Optik', NULL, 1867, 1867, NULL, 'Leopold Voss', 'Leipzig', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 9, 'verified', '3.1.4', 'Wahrnehmung als Ergebnis unbewusster Schlussprozesse.', 'Helmholtz, Hermann von: Handbuch der physiologischen Optik. Leipzig: Leopold Voss, 1867.', 'Helmholtz (1867) [41]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(42, 42, 'hanson_patterns_discovery_1958', 'book', 'Patterns of Discovery', 'An Inquiry into the Conceptual Foundations of Science', 1958, 1958, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.4', 'Theoriegeladenheit wissenschaftlicher Beobachtung.', 'Hanson, Norwood Russell: Patterns of Discovery. An Inquiry into the Conceptual Foundations of Science. Cambridge: Cambridge University Press, 1958.', 'Hanson (1958) [42]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(43, 43, 'kuhn_structure_scientific_revolutions_1962', 'book', 'The Structure of Scientific Revolutions', NULL, 1962, 1962, NULL, 'University of Chicago Press', 'Chicago', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.4', 'Paradigmen, Normalwissenschaft und wissenschaftliche Revolutionen.', 'Kuhn, Thomas S.: The Structure of Scientific Revolutions. Chicago: University of Chicago Press, 1962.', 'Kuhn (1962) [43]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(44, 44, 'popper_logik_forschung_1935', 'book', 'Logik der Forschung', 'Zur Erkenntnistheorie der modernen Naturwissenschaft', 1935, 1935, NULL, 'Julius Springer', 'Wien', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 9, 'verified', '3.1.4', 'Falsifizierbarkeit und kritische Prüfung wissenschaftlicher Hypothesen.', 'Popper, Karl R.: Logik der Forschung. Zur Erkenntnistheorie der modernen Naturwissenschaft. Wien: Julius Springer, 1935.', 'Popper (1935) [44]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(45, 45, 'lakatos_falsification_research_programmes_1970', 'book_chapter', 'Falsification and the Methodology of Scientific Research Programmes', NULL, 1970, 1970, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, '91–196', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Methodologie wissenschaftlicher Forschungsprogramme.', 'Lakatos, Imre: Falsification and the Methodology of Scientific Research Programmes. In: Lakatos, Imre; Musgrave, Alan (Hrsg.): Criticism and the Growth of Knowledge. Cambridge: Cambridge University Press, 1970, S. 91–196.', 'Lakatos (1970) [45]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(46, 46, 'quine_two_dogmas_1951', 'journal_article', 'Two Dogmas of Empiricism', NULL, 1951, 1951, 'The Philosophical Review', NULL, NULL, '60', NULL, '20–43', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Holismus der empirischen Prüfung.', 'Quine, Willard Van Orman: Two Dogmas of Empiricism. In: The Philosophical Review, Band 60, 1951, S. 20–43.', 'Quine (1951) [46]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(47, 47, 'duhem_theorie_physique_1906', 'book', 'La théorie physique', 'Son objet et sa structure', 1906, 1906, NULL, 'Chevalier & Rivière', 'Paris', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 9, 'verified', '3.1.4', 'Unterbestimmtheit physikalischer Hypothesen durch Experimente.', 'Duhem, Pierre: La théorie physique. Son objet et sa structure. Paris: Chevalier & Rivière, 1906.', 'Duhem (1906) [47]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(48, 48, 'van_fraassen_scientific_image_1980', 'book', 'The Scientific Image', NULL, 1980, 1980, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.4', 'Konstruktiver Empirismus und empirische Angemessenheit.', 'van Fraassen, Bas C.: The Scientific Image. Oxford: Clarendon Press, 1980.', 'van Fraassen (1980) [48]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(49, 49, 'worrall_structural_realism_1989', 'journal_article', 'Structural Realism: The Best of Both Worlds?', NULL, 1989, 1989, 'Dialectica', NULL, NULL, '43', NULL, '99–124', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Epistemischer Strukturenrealismus.', 'Worrall, John: Structural Realism: The Best of Both Worlds? In: Dialectica, Band 43, 1989, S. 99–124.', 'Worrall (1989) [49]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(50, 50, 'ladyman_what_structural_realism_1998', 'journal_article', 'What is Structural Realism?', NULL, 1998, 1998, 'Studies in History and Philosophy of Science', NULL, NULL, '29', NULL, '409–424', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Ontischer Strukturenrealismus.', 'Ladyman, James: What is Structural Realism? In: Studies in History and Philosophy of Science, Band 29, 1998, S. 409–424.', 'Ladyman (1998) [50]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(51, 51, 'french_ladyman_remodelling_structural_realism_2003', 'journal_article', 'Remodelling Structural Realism', 'Quantum Physics and the Metaphysics of Structure', 2003, 2003, 'Synthese', NULL, NULL, '136', NULL, '31–56', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Strukturenrealismus im Kontext der Quantenphysik.', 'French, Steven; Ladyman, James: Remodelling Structural Realism: Quantum Physics and the Metaphysics of Structure. In: Synthese, Band 136, 2003, S. 31–56.', 'French und Ladyman (2003) [51]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(52, 52, 'hesse_models_analogies_science_1963', 'book', 'Models and Analogies in Science', NULL, 1963, 1963, NULL, 'Sheed and Ward', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.4', 'Positive, negative und neutrale Analogien wissenschaftlicher Modelle.', 'Hesse, Mary B.: Models and Analogies in Science. London: Sheed and Ward, 1963.', 'Hesse (1963) [52]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(53, 53, 'giere_explaining_science_1988', 'book', 'Explaining Science', 'A Cognitive Approach', 1988, 1988, NULL, 'University of Chicago Press', 'Chicago', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.4', 'Modelle als zielgerichtete Repräsentationen.', 'Giere, Ronald N.: Explaining Science. A Cognitive Approach. Chicago: University of Chicago Press, 1988.', 'Giere (1988) [53]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(54, 54, 'suppes_models_mathematics_empirical_sciences_1960', 'journal_article', 'A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences', NULL, 1960, 1960, 'Synthese', NULL, NULL, '12', NULL, '287–301', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.4', 'Modelltheoretische Auffassung wissenschaftlicher Theorien.', 'Suppes, Patrick: A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences. In: Synthese, Band 12, 1960, S. 287–301.', 'Suppes (1960) [54]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(55, 55, 'tarski_concept_truth_formalized_languages_1956', 'book_chapter', 'The Concept of Truth in Formalized Languages', NULL, 1933, 1956, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, '152–278', NULL, NULL, NULL, NULL, 'en', 1, 'historical', 9, 'verified', '3.1.4', 'Semantische Wahrheitstheorie und Trennung von Objekt- und Metasprache.', 'Tarski, Alfred: The Concept of Truth in Formalized Languages. In: Tarski, Alfred: Logic, Semantics, Metamathematics. Oxford: Clarendon Press, 1956, S. 152–278; polnische Erstveröffentlichung 1933.', 'Tarski (1956) [55]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14');

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
(4, 5, 2, 'editor'),
(4, 6, 3, 'editor'),
(5, 7, 1, 'author'),
(6, 8, 1, 'author'),
(7, 9, 1, 'author'),
(7, 10, 2, 'editor'),
(8, 11, 1, 'author'),
(8, 12, 2, 'translator'),
(9, 13, 1, 'author'),
(9, 15, 3, 'editor'),
(9, 16, 4, 'editor'),
(9, 14, 2, 'translator'),
(10, 17, 1, 'author'),
(10, 18, 2, 'editor'),
(11, 19, 1, 'author'),
(11, 20, 2, 'editor'),
(12, 21, 1, 'author'),
(12, 22, 2, 'author'),
(12, 23, 3, 'editor'),
(13, 24, 1, 'author'),
(13, 25, 2, 'editor'),
(14, 26, 1, 'author'),
(15, 27, 1, 'author'),
(16, 28, 1, 'author'),
(16, 29, 2, 'editor'),
(16, 30, 3, 'editor'),
(17, 31, 1, 'author'),
(17, 32, 2, 'editor'),
(18, 33, 1, 'author'),
(19, 34, 1, 'author'),
(20, 35, 1, 'author'),
(21, 35, 1, 'author'),
(22, 36, 1, 'author'),
(23, 37, 1, 'author'),
(24, 38, 1, 'author'),
(25, 39, 1, 'author'),
(26, 40, 1, 'author'),
(27, 2, 1, 'author'),
(28, 41, 1, 'author'),
(29, 42, 1, 'author'),
(30, 43, 1, 'author'),
(31, 44, 1, 'author'),
(31, 45, 2, 'author'),
(32, 46, 1, 'author'),
(33, 47, 1, 'author'),
(34, 48, 1, 'author'),
(35, 49, 1, 'author'),
(36, 50, 1, 'author'),
(36, 51, 2, 'author'),
(36, 52, 3, 'author'),
(36, 53, 4, 'author'),
(37, 54, 1, 'author'),
(38, 55, 1, 'author'),
(38, 56, 2, 'author'),
(39, 57, 1, 'author'),
(40, 58, 1, 'author'),
(41, 59, 1, 'author'),
(42, 60, 1, 'author'),
(43, 61, 1, 'author'),
(44, 62, 1, 'author'),
(45, 63, 1, 'author'),
(45, 64, 2, 'editor'),
(46, 65, 1, 'author'),
(47, 66, 1, 'author'),
(48, 67, 1, 'author'),
(49, 68, 1, 'author'),
(50, 69, 1, 'author'),
(51, 70, 1, 'author'),
(51, 69, 2, 'author'),
(52, 71, 1, 'author'),
(53, 72, 1, 'author'),
(54, 73, 1, 'author'),
(55, 74, 1, 'author');

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
(1, 1, 3, 'first_citation', 'Historischer Ausgangspunkt der klassischen Konzeption eines absoluten Raumes und einer absoluten Zeit.', '3.1.0, Absatz 1 und 2', 1, 1, 'Erstnennung als Quelle [1].', 1),
(2, 2, 3, 'first_citation', 'Grundlage der dynamischen geometrischen Raumzeitbeschreibung in der Allgemeinen Relativitätstheorie.', '3.1.0, Absatz 1 und 2', 1, 1, 'Erstnennung als Quelle [2].', 1),
(3, 3, 3, 'first_citation', 'Einordnung quantengravitativer Ansätze, in denen Raum und Zeit als nichtfundamental oder emergent untersucht werden.', '3.1.0, Absatz 1 und 2', 1, 1, 'Erstnennung als Quelle [3].', 1),
(4, 4, 4, 'first_citation', 'Parmenides begrenzt die Denkbarkeit und sprachliche Bestimmbarkeit des Nichtseins und liefert damit einen historischen Ausgangspunkt für die Frage nach einem voraussetzungslosen Nichts.', '3.1.1, Absätze 3 und 4', 1, 1, 'Erstnennung als Quelle [4]; relevante Fragmente: 28 B2, B3 und B6.', 2),
(5, 5, 4, 'first_citation', 'Das quantenfeldtheoretische Vakuum ist ein definierter Zustand eines bereits strukturierten mathematisch-physikalischen Systems und daher kein absolutes Nichts.', '3.1.1, Absatz 5', 1, 1, 'Erstnennung als Quelle [5]; Bezug insbesondere auf die Grundlagenkapitel 2 und 5.', 2),
(6, 6, 4, 'first_citation', 'Die leere Menge enthält keine Elemente, bleibt aber selbst ein definiertes Objekt innerhalb einer vorausgesetzten Mengenlehre.', '3.1.1, Absatz 7', 1, 1, 'Erstnennung als Quelle [6]; Bezug insbesondere auf S. 1–12.', 2),
(7, 7, 5, 'first_citation', 'Erstnennung zur Bestimmung des Nichtseins als Andersheit und zur relationalen Fassung von Verschiedenheit.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [7]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(8, 8, 5, 'first_citation', 'Erstnennung zu Ort, Bewegung sowie Zeit als Zahl beziehungsweise Maß der Bewegung hinsichtlich des Früher und Später.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [8]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(9, 9, 5, 'first_citation', 'Erstnennung zur neuplatonischen Hervorbringung geordneter Vielheit aus dem Einen.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [9]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(10, 10, 5, 'first_citation', 'Erstnennung zur coincidentia oppositorum und zur erkenntnistheoretischen Begrenztheit bestimmender Begriffe.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [10]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(11, 11, 5, 'first_citation', 'Erstnennung zur immanenten Ordnung von Substanz, Attributen und Modi sowie zur geometrischen Darstellungsweise.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [11]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(12, 12, 5, 'first_citation', 'Erstnennung zur relationalen Auffassung von Raum als Ordnung des Zugleichseins und Zeit als Ordnung des Nacheinanders.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [12]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(13, 13, 5, 'first_citation', 'Erstnennung zu Raum und Zeit als reinen Formen der sinnlichen Anschauung und Bedingungen möglicher Erfahrung.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [13]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(14, 14, 5, 'first_citation', 'Erstnennung zur dialektischen Vermittlung von Sein, Nichts und Werden sowie zur Bestimmung durch Negation.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [14]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(15, 15, 5, 'first_citation', 'Erstnennung zur formalen Eigenständigkeit mehrstelliger Relationen in der modernen Logik.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [15]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(16, 16, 5, 'first_citation', 'Erstnennung zur Prozessontologie und zum Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaften Substanzen.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [16]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(17, 17, 5, 'first_citation', 'Erstnennung zur zeitlichen Bewusstseinsstruktur aus Urimpression, Retention und Protention.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [17]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(18, 18, 5, 'first_citation', 'Erstnennung zum wissenschaftstheoretischen Übergang vom Substanzbegriff zum Funktions- und Relationsbegriff.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [18]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(19, 19, 5, 'first_citation', 'Erstnennung zur Kritik der Zeit als bloßer Abfolge von Jetztpunkten und zur existenzialen Zeitlichkeit.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [19]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(20, 20, 5, 'first_citation', 'Erstnennung zur Welt als Gesamtheit von Tatsachen und zur logischen Struktur sinnvoller Aussagen.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [20]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(21, 21, 5, 'first_citation', 'Erstnennung zur Bedeutung als regelgeleitetem Gebrauch innerhalb von Sprachspielen.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [21]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(22, 22, 5, 'first_citation', 'Erstnennung zum konstruktiven Aufbau wissenschaftlicher Begriffe aus einer begrenzten Basis und expliziten Konstruktionsregeln.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [22]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(23, 23, 5, 'first_citation', 'Erstnennung zur Unterscheidung als elementarer Operation der Formbildung.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [23]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(24, 24, 5, 'first_citation', 'Erstnennung zur philosophischen Analyse informationeller Strukturen, Unterschiede und Relationen.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [24]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(25, 25, 5, 'first_citation', 'Erstnennung zur erkenntnistheoretischen Zurückhaltung gegenüber unmittelbaren ontologischen Schlüssen aus physikalischen Formalismen.', 'Abschnitt 3.1.2', 1, 1, 'Erstnennung als Quelle [25]; bibliografische Angaben entsprechend dem Manuskript.', 3),
(26, 1, 6, 'historical_context', 'Wiederverwendung der Quelle [1] zur klassischen Konzeption von absolutem Raum und absoluter Zeit.', 'Abschnitt 3.1.3', 0, 1, 'Bereits in 3.1.0 erstmals zitierte Quelle.', 4),
(27, 2, 6, 'background', 'Wiederverwendung der Quelle [2] zur dynamischen geometrischen Raumzeitbeschreibung der Allgemeinen Relativitätstheorie.', 'Abschnitt 3.1.3', 0, 1, 'Bereits in 3.1.0 erstmals zitierte Quelle.', 4),
(28, 3, 6, 'state_of_research', 'Wiederverwendung der Quelle [3] zur Schleifenquantengravitation und relationalen Quantisierung geometrischer Strukturen.', 'Abschnitt 3.1.3', 0, 1, 'Bereits in 3.1.0 erstmals zitierte Quelle.', 4),
(29, 5, 6, 'background', 'Wiederverwendung der Quelle [5] zu Grundlagen der Quantenfeldtheorie und zum strukturierten Vakuumbegriff.', 'Abschnitt 3.1.3', 0, 1, 'Bereits in 3.1.1 erstmals zitierte Quelle.', 4),
(30, 26, 6, 'first_citation', 'Relationale Kritik des absoluten Raumes und Bestimmung von Bewegung gegenüber materiellen Beziehungen.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [26].', 4),
(31, 27, 6, 'first_citation', 'Spezielle Relativitätstheorie, Relativität der Gleichzeitigkeit und beobachterabhängige Raum-Zeit-Messung.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [27].', 4),
(32, 28, 6, 'first_citation', 'Vierdimensionale Zusammenführung von Raum und Zeit.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [28].', 4),
(33, 29, 6, 'first_citation', 'Verbindung von Geometrie, Materie, Symmetrien und physikalischen Feldern.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [29].', 4),
(34, 30, 6, 'first_citation', 'Mathematische Struktur der Allgemeinen Relativitätstheorie auf Lorentz-Mannigfaltigkeiten.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [30].', 4),
(35, 31, 6, 'first_citation', 'Kosmologische Raumzeitstruktur, Singularitätssätze und geodätische Unvollständigkeit.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [31].', 4),
(36, 32, 6, 'first_citation', 'Hilbertraumformulierung quantenmechanischer Zustände und Observablen.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [32].', 4),
(37, 33, 6, 'first_citation', 'Abstrakte Zustands- und Operatorformulierung der Quantenmechanik.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [33].', 4),
(38, 34, 6, 'first_citation', 'Kanonische Quantisierung der Gravitation und Einbeziehung der Geometrie in die Quantentheorie.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [34].', 4),
(39, 35, 6, 'first_citation', 'Vergleichende Darstellung quantengravitativer Forschungsprogramme und ihrer Grenzen.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [35].', 4),
(40, 36, 6, 'first_citation', 'Diskrete kausale Ordnungsstruktur als möglicher Ursprung kontinuierlicher Raumzeit.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [36].', 4),
(41, 37, 6, 'first_citation', 'Thermodynamische Rekonstruktion der Einstein-Gleichung.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [37].', 4),
(42, 38, 6, 'first_citation', 'Zusammenhang von Verschränkungsentropie und geometrischen Flächen in holografischen Modellen.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [38].', 4),
(43, 39, 6, 'first_citation', 'Zusammenhang zwischen Raumzeitzusammenhang und Verschränkungsstruktur.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [39].', 4),
(44, 40, 6, 'first_citation', 'Entropische und informationelle Interpretation der Gravitation.', 'Abschnitt 3.1.3', 1, 1, 'Erstnennung als Quelle [40].', 4),
(45, 13, 7, 'background', 'Raum und Zeit als Bedingungen möglicher Erfahrung und methodische Trennung von Erkenntnisbedingungen und Gegenstand.', 'Abschnitt 3.1.4', 0, 1, 'Wiederverwendung von Kant [13].', 5),
(46, 18, 7, 'background', 'Funktionale und relationale Bestimmung wissenschaftlicher Gegenstände.', 'Abschnitt 3.1.4', 0, 1, 'Wiederverwendung von Cassirer [18].', 5),
(47, 22, 7, 'method', 'Explizite formale Rekonstruktion wissenschaftlicher Begriffe und ihrer Konstruktionsregeln.', 'Abschnitt 3.1.4', 0, 1, 'Wiederverwendung von Carnap [22].', 5),
(48, 41, 7, 'first_citation', 'Wahrnehmung als Ergebnis unbewusster Schlussprozesse.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [41].', 5),
(49, 42, 7, 'first_citation', 'Theoriegeladenheit wissenschaftlicher Beobachtung.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [42].', 5),
(50, 43, 7, 'first_citation', 'Paradigmen, Normalwissenschaft und wissenschaftliche Revolutionen.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [43].', 5),
(51, 44, 7, 'first_citation', 'Falsifizierbarkeit und kritische Prüfung wissenschaftlicher Hypothesen.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [44].', 5),
(52, 45, 7, 'first_citation', 'Methodologie wissenschaftlicher Forschungsprogramme.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [45].', 5),
(53, 46, 7, 'first_citation', 'Holismus der empirischen Prüfung.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [46].', 5),
(54, 47, 7, 'first_citation', 'Unterbestimmtheit physikalischer Hypothesen durch Experimente.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [47].', 5),
(55, 48, 7, 'first_citation', 'Konstruktiver Empirismus und empirische Angemessenheit.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [48].', 5),
(56, 49, 7, 'first_citation', 'Epistemischer Strukturenrealismus.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [49].', 5),
(57, 50, 7, 'first_citation', 'Ontischer Strukturenrealismus.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [50].', 5),
(58, 51, 7, 'first_citation', 'Strukturenrealismus im Kontext der Quantenphysik.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [51].', 5),
(59, 52, 7, 'first_citation', 'Positive, negative und neutrale Analogien wissenschaftlicher Modelle.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [52].', 5),
(60, 53, 7, 'first_citation', 'Modelle als zielgerichtete Repräsentationen.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [53].', 5),
(61, 54, 7, 'first_citation', 'Modelltheoretische Auffassung wissenschaftlicher Theorien.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [54].', 5),
(62, 55, 7, 'first_citation', 'Semantische Wahrheitstheorie und Trennung von Objekt- und Metasprache.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [55].', 5);

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
  MODIFY `annotation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

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
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

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
